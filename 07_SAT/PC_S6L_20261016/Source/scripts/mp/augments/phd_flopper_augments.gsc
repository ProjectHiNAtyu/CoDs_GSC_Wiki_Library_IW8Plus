// scripts\mp\augments\phd_flopper_augments.gsc  (hash_36829d569f45fae5.gscc) (size: 8484 Bytes / 0x2124 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x86ea7cd6 (2263514326)
// size ...... 8484 (0x2124)
// includes .. 8   (offset: 0x1f90)
// strings ... 24  (offset: 0x1fd0)
// dev strs .. 0   (offset: 0x2124)
// exports ... 14  (offset: 0x154c)
// cseg ...... 0x1f1 + 0x135b (0x154c)
// imports ... 66  (offset: 0x177c)
// animtree1 . 0   (offset: 0x2124)
// animtree2 . 0   (offset: 0x2124)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\perks\zombie\perk_phd_flopper;

#namespace phd_flopper_augments;

// Namespace phd_flopper_augments
// Params 0, eflags: 0x5
// Checksum 0x1f8487e0, Offset: 0x20f
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"phd_flopper_augments", undefined, &init_phd_flopper_augments, &function_57de451ad8725344 );
}

// Namespace phd_flopper_augments
// Params 0
// Checksum 0xd76cb2bd, Offset: 0x234
// Size: 0x5c
function init_phd_flopper_augments()
{
    if ( !level.zombie_augments_in_use )
    {
        return;
    }
    
    callback::add( "zm_perk_obtained", &function_288f120db5b6defb );
    callback::add( "zm_perk_lost", &function_9e09844df6bf44c7 );
    callback::add( #"hash_9456270bf9577eb1", &function_be36a6b010766d3a );
    callback::add( #"wall_jump_begin", &function_39466ee5279c9439 );
}

// Namespace phd_flopper_augments
// Params 0
// Checksum 0x45a3cf6b, Offset: 0x298
// Size: 0x6c
function function_57de451ad8725344()
{
    if ( !level.zombie_augments_in_use )
    {
        return;
    }
    
    if ( isdefined( level.zombie_augments[ #"phdflopper_shove" ] ) )
    {
        shovefx = level.zombie_augments[ #"phdflopper_shove" ].var_9c428a695fb1a65c;
        
        if ( isdefined( shovefx ) )
        {
            level._effect[ "flopper_shove_fx" ] = loadfxasset( shovefx );
        }
    }
}

// Namespace phd_flopper_augments
// Params 1
// Checksum 0x3ce35a30, Offset: 0x30c
// Size: 0x146
function function_288f120db5b6defb( params )
{
    if ( params.var_ffc1674def575bfa == "specialty_phd_flopper" )
    {
        var_b680893ff7e468a6 = istrue( utility::callsharedfunc( #"zombie", #"player_has_augment", #"phdflopper_slide_boost" ) );
        var_f503044807d43f34 = istrue( utility::callsharedfunc( #"zombie", #"player_has_augment", #"phdflopper_slider" ) );
        
        if ( var_b680893ff7e468a6 || var_f503044807d43f34 )
        {
            var_12905f37d92d8d76 = level.zombie_augments[ #"phdflopper_slide_boost" ].var_2f19837e10c104ad ?? 1.5;
            sliderradius = level.zombie_augments[ #"phdflopper_slider" ].phdsliderradius ?? 48;
            thread function_bebc6e950882b053( var_12905f37d92d8d76, sliderradius, var_b680893ff7e468a6, var_f503044807d43f34 );
        }
        
        if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"phdflopper_shove" ) )
        {
            shoveradius = level.zombie_augments[ #"phdflopper_shove" ].var_d8e745b1f21e3e05 ?? 48;
            thread function_90b124f5d853be08( shoveradius );
        }
    }
}

// Namespace phd_flopper_augments
// Params 1
// Checksum 0xa66841d5, Offset: 0x45a
// Size: 0x49
function function_9e09844df6bf44c7( params )
{
    if ( params.var_ffc1674def575bfa == "specialty_phd_flopper" )
    {
        utility::function_32b24db3127bff40( "phd_slider_fx", "phd_slide_exit" );
        self notify( #"hash_14518d7376e2ef28" );
        self notify( #"hash_4933fef8025ad301" );
    }
}

// Namespace phd_flopper_augments
// Params 1, eflags: 0x4
// Checksum 0x90b1cd62, Offset: 0x4ab
// Size: 0x679
function private function_90b124f5d853be08( radius = 48 )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_4933fef8025ad301" );
    hit_targets = [];
    is_moving_attack = 0;
    self.var_82ae0f2d2815f80b = 0;
    self.var_5ba130aa79ed7221 = 0;
    self.var_308e6684816777e2 = 0;
    
    while ( true )
    {
        if ( level.gamemodebundle.var_2d09ffdf1e6a201b )
        {
            if ( !self.var_82ae0f2d2815f80b && self.var_5ba130aa79ed7221 && !isdefined( self.perks[ "specialty_supersprint" ] ) )
            {
                if ( gettime() - self.var_308e6684816777e2 >= 3000 )
                {
                    self.var_82ae0f2d2815f80b = 1;
                    self.var_308e6684816777e2 = gettime();
                }
            }
            
            if ( !self issupersprinting() )
            {
                if ( isdefined( self.perks[ "specialty_supersprint" ] ) )
                {
                    is_moving_attack = 0;
                    waitframe();
                    continue;
                }
                else if ( self.var_82ae0f2d2815f80b )
                {
                    if ( gettime() - self.var_308e6684816777e2 < 3000 )
                    {
                        is_moving_attack = 0;
                        waitframe();
                        continue;
                    }
                    else
                    {
                        self.var_82ae0f2d2815f80b = 0;
                        self.var_5ba130aa79ed7221 = 0;
                    }
                }
                else if ( !self issprinting() )
                {
                    is_moving_attack = 0;
                    waitframe();
                    continue;
                }
            }
        }
        else if ( !self issupersprinting() )
        {
            is_moving_attack = 0;
            waitframe();
            continue;
        }
        
        if ( !is_moving_attack )
        {
            hit_targets = [];
            is_moving_attack = 1;
        }
        
        currentpos = self.origin;
        forward = anglestoforward( self.angles );
        right = anglestoright( self.angles );
        potential_targets = [];
        potential_targets = getplayersandaiarrayinradius( currentpos, radius );
        var_a5d700a05e77292d = 0;
        var_375c3e35770652f = 0;
        var_1f43a1a5ec69808 = 5000;
        
        foreach ( target in potential_targets )
        {
            if ( !isalive( target ) )
            {
                continue;
            }
            
            if ( target.team == self.team )
            {
                continue;
            }
            
            if ( utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
            {
                if ( !level [[ utility::getsharedfunc( #"zm", #"hash_8e5cbc74839b479b" ) ]]( self, target ) )
                {
                    continue;
                }
            }
            
            var_ee6433c31961982d = vectornormalize( ( target.origin[ 0 ], target.origin[ 1 ], 0 ) - ( currentpos[ 0 ], currentpos[ 1 ], 0 ) );
            dot = vectordot( forward, var_ee6433c31961982d );
            
            if ( dot < 0.71 )
            {
                continue;
            }
            
            if ( arraycontains( hit_targets, target ) )
            {
                continue;
            }
            
            hit_targets[ hit_targets.size ] = target;
            var_a5d700a05e77292d = 1;
            
            if ( isalive( target ) )
            {
                if ( !isdefined( target.aicategory ) || target.aicategory == "normal" )
                {
                    current_round = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( target.origin );
                    base_zombie_max_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", current_round ) ?? target.maxhealth;
                    var_8d2325a3c1b80415 = level.zombie_augments[ #"phdflopper_shove" ].var_a36f4b39cc98766f ?? 0.1;
                    damage = int( base_zombie_max_health * var_8d2325a3c1b80415 ) ?? 13;
                    
                    if ( !target zombie_knockdown::function_19d6107cb6bdff5c() )
                    {
                        self playrumbleonentity( "grenade_rumble" );
                        self earthquakeforplayer( 0.35, 0.5, self.origin, 200 );
                        shovegesture = level.zombie_augments[ #"phdflopper_shove" ].var_68630ec38c3d6766 ?? "t10_ges_sprint_door_impact";
                        currentweapon = self getcurrentweapon();
                        
                        if ( !isnullweapon( currentweapon ) )
                        {
                            self playgestureviewmodel( shovegesture );
                        }
                        
                        if ( isdefined( level._effect[ "flopper_shove_fx" ] ) )
                        {
                            fxorigin = ( target.origin[ 0 ], target.origin[ 1 ], target.origin[ 2 ] + 48 );
                            playfx( utility::getfx( "flopper_shove_fx" ), fxorigin );
                        }
                        
                        target playsoundevent( %"sndevent_ai_shove_knockdown_imp" );
                        target.killed_by_phd_flopper = 1;
                        target dodamage( damage, target.origin, self, self, "MOD_UNKNOWN", "<explicitweaponnone>", "none", undefined, 1073807360 );
                        self.var_5ba130aa79ed7221 = 1;
                        self.var_308e6684816777e2 = gettime();
                        
                        if ( !isalive( target ) && !target.var_33df89471a965163 )
                        {
                            v_dir = vectornormalize( target.origin - self.origin );
                            target.var_33df89471a965163 = 1;
                            var_24ed309d808c077a = target getcorpseentity();
                            params = spawnstruct();
                            params.player = self;
                            params.augmentused = #"phdflopper_shove";
                            target callback::callback( "phd_flopper_killed", params );
                            
                            if ( var_375c3e35770652f < 5 )
                            {
                                if ( isdefined( var_24ed309d808c077a ) )
                                {
                                    launchx = clamp( v_dir[ 0 ] * var_1f43a1a5ec69808, -5000, 5000 );
                                    launchy = clamp( v_dir[ 1 ] * var_1f43a1a5ec69808, -5000, 5000 );
                                    launchz = clamp( ( v_dir[ 2 ] + 150 ) * var_1f43a1a5ec69808, 0, 5000 );
                                    v_launch = ( launchx, launchy, launchz );
                                    var_24ed309d808c077a startragdollfromimpact( "torso_lower", v_launch );
                                    var_375c3e35770652f++;
                                }
                            }
                        }
                        else if ( isagent( target ) )
                        {
                            target zombie_knockdown::function_6fc167d4a3590991( currentpos );
                        }
                        
                        if ( isalive( target ) )
                        {
                            target.killed_by_phd_flopper = undefined;
                        }
                    }
                }
            }
        }
        
        if ( var_a5d700a05e77292d )
        {
            level thread function_5b7d0a03eb846e2c( self );
        }
        
        waitframe();
    }
}

// Namespace phd_flopper_augments
// Params 1, eflags: 0x4
// Checksum 0x71b92a8d, Offset: 0xb2c
// Size: 0x7c
function private function_5b7d0a03eb846e2c( player )
{
    if ( !isdefined( player.var_1242add814c91d87 ) || gettime() > player.var_1242add814c91d87 )
    {
        var_4fdac44e2c8cefd9 = 1;
        player.var_1242add814c91d87 = gettime() + var_4fdac44e2c8cefd9 * 1000;
        player playrumbleonentity( "damage_light" );
        player earthquakeforplayer( 0.2, var_4fdac44e2c8cefd9, player.origin, 100 );
    }
}

// Namespace phd_flopper_augments
// Params 4
// Checksum 0x9cd9923f, Offset: 0xbb0
// Size: 0x69
function function_bebc6e950882b053( var_12905f37d92d8d76 = 0, sliderradius = 32, var_b680893ff7e468a6 = 0, var_f503044807d43f34 = 0 )
{
    self endon( #"hash_14518d7376e2ef28" );
    childthread function_ba18f0bad6c5c091( var_12905f37d92d8d76, var_b680893ff7e468a6 );
    childthread function_d53625a8f54f6017( undefined, sliderradius, var_f503044807d43f34 );
}

// Namespace phd_flopper_augments
// Params 2
// Checksum 0x1bba11ad, Offset: 0xc21
// Size: 0x139
function function_ba18f0bad6c5c091( var_12905f37d92d8d76 = 0, var_b680893ff7e468a6 = 0 )
{
    self endon( #"hash_bca1a98427c3107e" );
    self endon( #"death_or_disconnect" );
    self.var_592ca8d463ed39eb = gettime();
    
    while ( true )
    {
        if ( self issprintsliding() || self isactiverolling() )
        {
            var_b5dc6164c06a63a2 = gettime() - self.var_592ca8d463ed39eb;
            var_e2a9ed9c5a0acca5 = val::get( "slide_boost" );
            
            if ( !self.slideboosted && var_b680893ff7e468a6 && var_e2a9ed9c5a0acca5 && ( var_b5dc6164c06a63a2 == 0 || var_b5dc6164c06a63a2 >= 3000 ) )
            {
                self.slideboosted = 1;
                var_88d00a565ab1cb5a = self getvelocity();
                xboost = clamp( var_88d00a565ab1cb5a[ 0 ] * var_12905f37d92d8d76, -1800, 1800 );
                yboost = clamp( var_88d00a565ab1cb5a[ 1 ] * var_12905f37d92d8d76, -1800, 1800 );
                var_88d00a565ab1cb5a = ( xboost, yboost, var_88d00a565ab1cb5a[ 2 ] );
                self.var_592ca8d463ed39eb = gettime();
                self setvelocity( var_88d00a565ab1cb5a );
            }
        }
        else
        {
            self.slideboosted = undefined;
        }
        
        waitframe();
    }
}

// Namespace phd_flopper_augments
// Params 3
// Checksum 0x6704c89, Offset: 0xd62
// Size: 0x3d3
function function_d53625a8f54f6017( params, sliderradius = 32, var_f503044807d43f34 = 0 )
{
    self endon( #"hash_1dff27af656b725c" );
    self endon( #"death_or_disconnect" );
    trail_scriptable_part = params.var_bc686430db369fde ?? "phd_slider_fx";
    var_277c7a22b46d295e = params.var_fb6431738ed4a2bc ?? "phd_slide_on";
    var_9d85178f2f279e73 = params.var_92ec0b4f80daded1 ?? "phd_slide_exit";
    var_d0f00e01d89f9464 = params.var_2564757d5f235f12 ?? "phd_roll_on";
    hit_targets = [];
    is_moving_attack = 0;
    var_9c067ec753e2ebf0 = 0;
    
    while ( true )
    {
        if ( self issprintsliding() || self isactiverolling() )
        {
            if ( var_f503044807d43f34 && !var_9c067ec753e2ebf0 )
            {
                if ( self isactiverolling() )
                {
                    utility::function_32b24db3127bff40( trail_scriptable_part, var_d0f00e01d89f9464 );
                }
                else
                {
                    utility::function_32b24db3127bff40( trail_scriptable_part, var_277c7a22b46d295e );
                }
                
                if ( !is_moving_attack )
                {
                    hit_targets = [];
                    is_moving_attack = 1;
                }
                
                currentpos = self.origin;
                slidedir = self getvelocity();
                slidedir = vectornormalize( slidedir );
                potential_targets = [];
                potential_targets = getplayersandaiarrayinradius( currentpos, sliderradius );
                var_b51801f26520c56b = getaiarrayinradius( currentpos, sliderradius * 2 );
                
                foreach ( var_1f16a3089de86f57 in var_b51801f26520c56b )
                {
                    if ( var_1f16a3089de86f57.aicategory == "elite" )
                    {
                        var_5c3f67df62d7d541 = vectornormalize( var_1f16a3089de86f57.origin - currentpos );
                        dot = vectordot( var_5c3f67df62d7d541, slidedir );
                        
                        if ( dot >= 0 )
                        {
                            potential_targets[ potential_targets.size ] = var_1f16a3089de86f57;
                        }
                    }
                }
                
                var_a5d700a05e77292d = 0;
                
                foreach ( target in potential_targets )
                {
                    if ( !isalive( target ) )
                    {
                        continue;
                    }
                    
                    if ( target zombie_utils::function_bf1464d09f4e4b40() )
                    {
                        continue;
                    }
                    
                    if ( target.team == self.team )
                    {
                        continue;
                    }
                    
                    var_ee6433c31961982d = vectornormalize( target.origin - currentpos );
                    
                    if ( arraycontains( hit_targets, target ) )
                    {
                        continue;
                    }
                    
                    dot = vectordot( var_ee6433c31961982d, slidedir );
                    
                    if ( isalive( target ) && dot >= 0 )
                    {
                        var_a5d700a05e77292d = 1;
                        hit_targets[ hit_targets.size ] = target;
                        var_9c067ec753e2ebf0 = 1;
                        
                        if ( !isdefined( self.var_9c79f2f01b89f2d1 ) )
                        {
                            self.var_9c79f2f01b89f2d1 = self.origin;
                        }
                        
                        distancetraveled = distance2d( self.var_9c79f2f01b89f2d1, self.origin );
                        augmentused = #"phdflopper_slider";
                        perk_phd_flopper::flopper_explode( self, distancetraveled, augmentused, params );
                    }
                }
                
                if ( var_a5d700a05e77292d )
                {
                    level thread function_5b7d0a03eb846e2c( self );
                }
                
                function_d442aa33e9d708f4( params, sliderradius, hit_targets );
            }
        }
        else
        {
            if ( is_moving_attack )
            {
                utility::function_32b24db3127bff40( trail_scriptable_part, var_9d85178f2f279e73 );
            }
            
            var_9c067ec753e2ebf0 = 0;
            is_moving_attack = 0;
            self.var_9c79f2f01b89f2d1 = self.origin;
        }
        
        waitframe();
    }
}

// Namespace phd_flopper_augments
// Params 1
// Checksum 0xa6a9a0d2, Offset: 0x113d
// Size: 0x139
function function_be36a6b010766d3a( params )
{
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"phdflopper_ashes" ) )
    {
        if ( !isdefined( self.var_ca90c871a197c33 ) )
        {
            self.var_ca90c871a197c33 = gettime();
        }
        
        cooldowntime = level.zombie_augments[ #"phdflopper_ashes" ].var_27edd21280401f23 ?? 60;
        cooldowntime *= 1000;
        timepassed = gettime() - self.var_ca90c871a197c33;
        
        if ( timepassed == 0 || timepassed >= cooldowntime )
        {
            if ( utility::issharedfuncdefined( #"zombie", #"hash_8bd9ed022653701d" ) )
            {
                self.var_ca90c871a197c33 = gettime();
                duration = level.zombie_augments[ #"phdflopper_ashes" ].var_af55a6275e5691e ?? 5;
                self.var_2de028ea974579b5[ #"phdflopper_ashes" ] = 1;
                thread utility::callsharedfunc( #"zombie", #"hash_8bd9ed022653701d", duration, #"phdflopper_ashes", "ashes" );
            }
        }
    }
}

// Namespace phd_flopper_augments
// Params 3, eflags: 0x4
// Checksum 0xcaae0394, Offset: 0x127e
// Size: 0x13a
function private function_d442aa33e9d708f4( params, sliderradius, hit_targets )
{
    if ( !params.kfe_damage )
    {
        return;
    }
    
    kfes = utility::callsharedfunc( "specialty_phd_flopper", #"hash_6740cbe62b8dfc98", self.origin, sliderradius );
    
    foreach ( kfe in kfes )
    {
        if ( arraycontains( hit_targets, kfe ) )
        {
            continue;
        }
        
        if ( isent( kfe ) )
        {
            kfe dodamage( params.kfe_damage, kfe.origin, self, self, "MOD_EXPLOSIVE", "<explicitweaponnone>" );
            hit_targets[ hit_targets.size ] = kfe;
            continue;
        }
        
        if ( kfe.classname == "scriptable" )
        {
            kfe scriptabledodamage( params.kfe_damage, self, self, undefined, undefined );
            hit_targets[ hit_targets.size ] = kfe;
        }
    }
}

// Namespace phd_flopper_augments
// Params 1, eflags: 0x4
// Checksum 0xb3f84682, Offset: 0x13c0
// Size: 0x18c
function private function_39466ee5279c9439( sparams )
{
    if ( isplayer( self ) && utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_phd_flopper", #"phdflopper_wall_flopper" ) )
    {
        var_51ef870503967f06 = 96;
        var_622931df2c9b536 = 1;
        round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
        base_zombie_maxhealth = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
        var_3b0370610aa91472 = 0;
        explosion_damage = base_zombie_maxhealth;
        params = {};
        
        if ( isdefined( self.var_ebab2b0c839a157 ) )
        {
            var_3b0370610aa91472 = gettime() - self.var_ebab2b0c839a157;
            
            if ( var_3b0370610aa91472 <= 2000 )
            {
                var_622931df2c9b536 = 0.1;
                s_mod = "MOD_UNKNOWN";
            }
            else if ( var_3b0370610aa91472 <= 4000 && var_3b0370610aa91472 > 2000 )
            {
                var_622931df2c9b536 = 0.5;
                s_mod = "MOD_UNKNOWN";
            }
            else if ( var_3b0370610aa91472 >= 6000 )
            {
                var_622931df2c9b536 = 1;
                s_mod = "MOD_EXPLOSIVE";
            }
            
            explosion_damage = base_zombie_maxhealth * var_622931df2c9b536;
        }
        
        params.smeansofdeath = s_mod;
        params.explosion_damage = explosion_damage;
        params.base_radius = 300;
        params.var_da2505a8cf14a513 = 1;
        self.var_ebab2b0c839a157 = gettime();
        augmentused = #"phdflopper_wall_flopper";
        perk_phd_flopper::flopper_explode( self, var_51ef870503967f06, augmentused, params );
    }
}

