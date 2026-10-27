// scripts\mp\augments\mary_paris_augments.gsc  (hash_0dde81cd02b6fdcd.gscc) (size: 8064 Bytes / 0x1f80 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x57ad4221 (1470972449)
// size ...... 8064 (0x1f80)
// includes .. 19  (offset: 0x1dc4)
// strings ... 21  (offset: 0x1e5c)
// dev strs .. 0   (offset: 0x1f80)
// exports ... 13  (offset: 0x14c8)
// cseg ...... 0x1db + 0x12ed (0x14c8)
// imports ... 60  (offset: 0x16d0)
// animtree1 . 0   (offset: 0x1f80)
// animtree2 . 0   (offset: 0x1f80)
#using script_16ea1b94f0f381b3;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\mp\utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_cannonball;
#using scripts\common\ai\aitypes\shared\zombie\zombie_traverse;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\mp\ammomods\brainrot;
#using scripts\mp\ammomods\cryofreeze;
#using scripts\mp\ammomods\deadwire;
#using scripts\mp\ammomods\napalmburst;
#using scripts\mp\ammomods\shadowvortex;
#using scripts\mp\augments\brainrot_augments;
#using scripts\mp\augments\cryofreeze_augments;
#using scripts\mp\playerhealth;

#namespace mary_paris_augments;

// Namespace mary_paris_augments
// Params 0, eflags: 0x5
// Checksum 0x31473372, Offset: 0x1f9
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mary_paris_augments", undefined, &init_mary_paris_augments, undefined );
}

// Namespace mary_paris_augments
// Params 0
// Checksum 0xceab7ed4, Offset: 0x21a
// Size: 0x5c
function init_mary_paris_augments()
{
    if ( !level.zombie_augments_in_use )
    {
        return;
    }
    
    level._effect[ "mary_paris_blast" ] = loadfxasset( "vfx_t10_zm_mister_peeks_aether_bunny_surprise" );
    callback::add( "mary_paris_started", &function_bbcc1e15c1de2928 );
    callback::add( "mary_paris_attack_hit", &on_mary_paris_attack_hit );
    callback::add( "mary_paris_end", &on_mary_paris_end );
}

// Namespace mary_paris_augments
// Params 1
// Checksum 0xe7cfb31c, Offset: 0x27e
// Size: 0xae
function function_bbcc1e15c1de2928( sparams )
{
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"mary_paris_paris_favor" ) )
    {
        thread mary_paris_magicbox( sparams.misterpeeks );
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"mary_paris_dance_party" ) )
    {
        thread mary_paris_dance_party( sparams.misterpeeks );
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"mary_paris_peek_health" ) )
    {
        thread mary_paris_peek_health( sparams.misterpeeks );
    }
}

// Namespace mary_paris_augments
// Params 1
// Checksum 0xf1b8d192, Offset: 0x334
// Size: 0x78
function on_mary_paris_end( sparams )
{
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"mary_paris_dance_party" ) )
    {
        thread mary_paris_dance_party_end( sparams.misterpeeks );
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"mary_paris_peek_health" ) )
    {
        thread function_4590f92d5b934822( sparams.misterpeeks );
    }
}

// Namespace mary_paris_augments
// Params 1
// Checksum 0x964ae15, Offset: 0x3b4
// Size: 0x116
function function_4590f92d5b934822( misterpeeks )
{
    misterpeeks notify( #"hash_65be34bfe1d63693" );
    str_team = self.team;
    wait 0.5;
    
    foreach ( player in level.players )
    {
        can_affect = 1;
        
        if ( utility::issharedfuncdefined( #"zm", #"hash_95f8b65e45fc2ef4" ) )
        {
            can_affect = level [[ utility::getsharedfunc( #"zm", #"hash_95f8b65e45fc2ef4" ) ]]( self, player );
        }
        
        if ( player.team == str_team && can_affect )
        {
            player.var_2dee1a7166e0cdae = undefined;
            player.var_745eb623184b68a9 = undefined;
        }
    }
}

// Namespace mary_paris_augments
// Params 1
// Checksum 0x32870679, Offset: 0x4d2
// Size: 0x1f1
function mary_paris_peek_health( misterpeeks )
{
    misterpeeks endon( #"death", #"hash_65be34bfe1d63693" );
    str_team = self.team;
    radiussq = level.zombie_augments[ #"mary_paris_peek_health" ].var_4d684193c08afe13 ?? 250;
    radiussq *= radiussq;
    var_b0ea3f5ac7b106f8 = level.zombie_augments[ #"mary_paris_peek_health" ].var_8073e69f6a5f3aa7 ?? 0.01;
    
    while ( isdefined( misterpeeks ) )
    {
        foreach ( player in level.players )
        {
            if ( player.team != str_team )
            {
                continue;
            }
            
            can_affect = 1;
            
            if ( utility::issharedfuncdefined( #"zm", #"hash_95f8b65e45fc2ef4" ) )
            {
                can_affect = level [[ utility::getsharedfunc( #"zm", #"hash_95f8b65e45fc2ef4" ) ]]( self, player );
            }
            
            if ( !can_affect )
            {
                continue;
            }
            
            if ( distance2d( player.origin, misterpeeks.origin ) <= radiussq )
            {
                if ( !player.var_745eb623184b68a9 )
                {
                    player.var_745eb623184b68a9 = 1;
                    player.var_2dee1a7166e0cdae = var_b0ea3f5ac7b106f8;
                    playerhealth::forcehealthregen( player, 1 );
                }
                
                continue;
            }
            
            if ( player.var_745eb623184b68a9 )
            {
                player.var_745eb623184b68a9 = undefined;
                player.var_2dee1a7166e0cdae = undefined;
            }
        }
        
        waitframe();
    }
}

// Namespace mary_paris_augments
// Params 1
// Checksum 0x2713cdd2, Offset: 0x6cb
// Size: 0x266
function mary_paris_dance_party( misterpeeks )
{
    misterpeeks endon( #"hash_198abe1caaf58bb1" );
    
    if ( !isdefined( misterpeeks ) )
    {
        return;
    }
    
    start_origin = misterpeeks.origin;
    var_9a7b20e173174021 = level.zombie_augments[ #"mary_paris_dance_party" ].var_edc884cdcf439b95 ?? 500;
    self.dancingzombies = [];
    
    while ( isdefined( misterpeeks ) )
    {
        var_da240dd623954f38 = getaiarrayinradius( start_origin, var_9a7b20e173174021 );
        
        if ( utility::issharedfuncdefined( #"zm", #"hash_275603844e04e7ac" ) )
        {
            var_da240dd623954f38 = level [[ utility::getsharedfunc( #"zm", #"hash_275603844e04e7ac" ) ]]( var_da240dd623954f38, self );
        }
        
        foreach ( zombie in var_da240dd623954f38 )
        {
            if ( isalive( zombie ) && zombie utility::function_4c656524ecb504d6( "dance" ) && zombie.aicategory == "normal" && !zombie zombie_utils::function_bf1464d09f4e4b40() )
            {
                var_3eeee0a78e41d2ca = 0;
                var_caa67496e8434636 = zombie findoverridearchetype( "animscript" );
                
                if ( isdefined( var_caa67496e8434636 ) && var_caa67496e8434636 != zombie getbasearchetype() )
                {
                    var_3eeee0a78e41d2ca = 1;
                }
                
                if ( zombie.disallow_knockdown || zombie.b_ignore_mary_paris || zombie namespace_b76ff2659823e89d::is_crawling() || zombie zombie_traverse::is_traversing() )
                {
                    var_3eeee0a78e41d2ca = 1;
                }
                
                if ( zombie.var_c41913aeafebae8d )
                {
                    var_3eeee0a78e41d2ca = 1;
                }
                
                if ( zombie.is_living_world_ai )
                {
                    var_3eeee0a78e41d2ca = 1;
                }
                
                if ( zombie zombie_cannonball::function_aa1319badace3306() )
                {
                    var_3eeee0a78e41d2ca = 1;
                }
                
                if ( !var_3eeee0a78e41d2ca )
                {
                    zombie.var_c41913aeafebae8d = 1;
                    zombie thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "dance", "dance_end", undefined, undefined, "dance_animating" );
                    zombie thread function_518da8be0ed6c20e();
                    
                    if ( isplayer( self ) )
                    {
                        self.dancingzombies[ self.dancingzombies.size ] = zombie;
                    }
                }
            }
        }
        
        wait 0.5;
    }
}

// Namespace mary_paris_augments
// Params 0
// Checksum 0x25a27877, Offset: 0x939
// Size: 0x29
function function_518da8be0ed6c20e()
{
    self endon( #"death" );
    self waittill( #"dance_end" );
    
    if ( self )
    {
        self.var_c41913aeafebae8d = undefined;
    }
}

// Namespace mary_paris_augments
// Params 1
// Checksum 0x38021dc2, Offset: 0x96a
// Size: 0x3cd
function mary_paris_dance_party_end( misterpeeks )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !isdefined( misterpeeks ) )
    {
        return;
    }
    
    misterpeeks notify( #"hash_198abe1caaf58bb1" );
    
    if ( !isdefined( level.mary_paris_dance_party_throttle ) )
    {
        level.mary_paris_dance_party_throttle = throttle::throttle_initialize( "mary_paris_dance_party_throttle", 1, level.framedurationseconds );
    }
    
    var_266493faa440f098 = level.field_upgrade_bundles[ "super_mary_paris" ].offhandweapon;
    
    if ( isdefined( level.weaponmetadata[ %"mary_paris" ] ) )
    {
        if ( !isdefined( level.weaponmetadata[ %"mary_paris" ].weaponobj ) )
        {
            var_266493faa440f098 = makeweapon( level.weaponmetadata[ %"mary_paris" ].weapon );
            level.weaponmetadata[ %"mary_paris" ].weaponobj = var_266493faa440f098;
        }
        else
        {
            var_266493faa440f098 = level.weaponmetadata[ %"mary_paris" ].weaponobj;
        }
    }
    
    peeks_origin = misterpeeks.origin;
    damage_radius = level.zombie_augments[ #"mary_paris_dance_party" ].var_3f629d106ae69b5e ?? 500;
    var_8d2325a3c1b80415 = level.zombie_augments[ #"mary_paris_dance_party" ].var_ce52633d5d80aeb9 ?? 2.5;
    round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( misterpeeks.origin );
    zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
    damage = int( zombie_base_health * var_8d2325a3c1b80415 );
    
    if ( isdefined( level._effect[ "mary_paris_blast" ] ) )
    {
        playfx( level._effect[ "mary_paris_blast" ], peeks_origin );
    }
    
    var_da240dd623954f38 = getaiarrayinradius( peeks_origin, damage_radius );
    
    if ( utility::issharedfuncdefined( #"zm", #"hash_275603844e04e7ac" ) )
    {
        var_da240dd623954f38 = level [[ utility::getsharedfunc( #"zm", #"hash_275603844e04e7ac" ) ]]( var_da240dd623954f38, self );
    }
    
    var_a134472124fa2713 = spawnstruct();
    var_c99825ecdb04639c = var_da240dd623954f38.size;
    
    foreach ( zombie in var_da240dd623954f38 )
    {
        zombie dodamage( damage, peeks_origin, self, self, "MOD_ELEMENTAL_DARK", var_266493faa440f098, "none", undefined, 1073807360 );
        throttle::throttle_wait_in_queue( level.mary_paris_dance_party_throttle, var_a134472124fa2713 );
    }
    
    wait 0.25;
    
    foreach ( dancezombie in self.dancingzombies )
    {
        if ( isalive( dancezombie ) )
        {
            dancezombie asm_bb::bb_clearanimscripted();
            dancezombie notify( #"dance_end" );
        }
    }
    
    wait_time = var_c99825ecdb04639c * level.framedurationseconds;
    wait wait_time;
    
    if ( self )
    {
        callback::callback( "field_upgrade_ended", { #ref:"super_mary_paris" } );
    }
}

// Namespace mary_paris_augments
// Params 1
// Checksum 0x7bff7396, Offset: 0xd3f
// Size: 0x216
function mary_paris_magicbox( misterpeeks )
{
    if ( utility::flag( "powerup_fire_sale_active" ) )
    {
        return;
    }
    
    if ( level.zm_mode_modifiers.var_7d3d84e96a1a43b5 )
    {
        return;
    }
    
    distance_check = 9999;
    s_closest_magicbox = undefined;
    
    foreach ( var_349a0723ed9ac19c in level.var_1bbb5557537e2c0c )
    {
        if ( distancesquared( misterpeeks.origin, var_349a0723ed9ac19c.origin ) <= 62500 )
        {
            s_closest_magicbox = var_349a0723ed9ac19c;
            break;
        }
    }
    
    if ( !isdefined( s_closest_magicbox ) )
    {
        return;
    }
    
    var_9af1667b5edcf3c1 = 0;
    
    if ( !s_closest_magicbox.var_f14b2b4820b635e7 && !s_closest_magicbox.var_9870f882980ab31b )
    {
        s_closest_magicbox utility::callsharedfunc( #"zombie", #"hash_d66633c1e4eea8f1" );
        var_9af1667b5edcf3c1 = 1;
    }
    
    if ( var_9af1667b5edcf3c1 )
    {
        while ( isdefined( s_closest_magicbox.mdl_magicbox.interact ) && !s_closest_magicbox.mdl_magicbox.interact function_45c212dce7227aa7() )
        {
            waitframe();
        }
    }
    
    if ( s_closest_magicbox.mdl_magicbox.interact )
    {
        if ( !s_closest_magicbox.mdl_magicbox.interact.b_opened_magicbox )
        {
            s_closest_magicbox.mdl_magicbox.interact utility::callsharedfunc( #"zombie", #"on_use_magicbox", self, 1, 1 );
        }
        
        if ( utility::callsharedfunc( #"bgb", #"is_enabled", "wonderbar" ) )
        {
            self notify( #"hash_b0358cd4c78b6b45" );
        }
        
        s_closest_magicbox thread function_b8794748bd7c7d6d();
    }
}

// Namespace mary_paris_augments
// Params 0
// Checksum 0x4d26e6eb, Offset: 0xf5d
// Size: 0xa4
function function_b8794748bd7c7d6d()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( !self.mdl_magicbox.interact.b_opened_magicbox )
    {
        waitframe();
    }
    
    if ( self.mdl_magicbox.interact )
    {
        while ( self.mdl_magicbox.interact.b_opened_magicbox )
        {
            waitframe();
        }
        
        if ( self && !self.var_f14b2b4820b635e7 )
        {
            utility::callsharedfunc( #"zombie", #"hash_ba00127cec14a5b2" );
        }
    }
}

// Namespace mary_paris_augments
// Params 1
// Checksum 0xa94cf265, Offset: 0x1009
// Size: 0x4bf
function on_mary_paris_attack_hit( sparams )
{
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( sparams.zombie ) )
    {
        return;
    }
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( sparams.zombie.aicategory == "elite" || sparams.zombie.aicategory == "hvt" || sparams.zombie.aicategory == "boss" )
    {
        return;
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"mary_paris_arcane_fury" ) )
    {
        var_266493faa440f098 = level.field_upgrade_bundles[ "super_mary_paris" ].offhandweapon;
        
        if ( isdefined( level.weaponmetadata[ %"mary_paris" ] ) )
        {
            if ( !isdefined( level.weaponmetadata[ %"mary_paris" ].weaponobj ) )
            {
                var_266493faa440f098 = makeweapon( level.weaponmetadata[ %"mary_paris" ].weapon );
                level.weaponmetadata[ %"mary_paris" ].weaponobj = var_266493faa440f098;
            }
            else
            {
                var_266493faa440f098 = level.weaponmetadata[ %"mary_paris" ].weaponobj;
            }
        }
        
        cooldown = level.zombie_augments[ #"mary_paris_arcane_fury" ].var_fa84ddb5669828d5;
        cooldown *= 1000;
        procchance = level.zombie_augments[ #"mary_paris_arcane_fury" ].var_a2612c71420e96b8 ?? 1;
        procchance *= 100;
        
        if ( !isdefined( self.var_5c871a39cc029d96 ) )
        {
            self.var_5c871a39cc029d96 = 0;
        }
        
        timenow = gettime();
        
        if ( isdefined( sparams.zombie ) && utility::percent_chance( procchance ) && timenow - self.var_5c871a39cc029d96 >= cooldown )
        {
            center = sparams.zombie getcentroid();
            randomnumber = randomintrange( 0, 7 );
            
            if ( !isdefined( self.var_46080659f132a436 ) )
            {
                self.var_46080659f132a436 = randomnumber;
            }
            
            switch ( self.var_46080659f132a436 )
            {
                case 0:
                    self.var_46080659f132a436 = ( self.var_46080659f132a436 + 1 ) % 7;
                    sparams.zombie brainrot::function_2fa96fd205e9d8f7( self );
                    sparams.zombie brainrot_augments::try_brainrot_bloat( 1 );
                    break;
                case 1:
                    self.var_46080659f132a436 = ( self.var_46080659f132a436 + 1 ) % 7;
                    sparams.zombie cryofreeze::function_78dcfeb8fef113fb( 0, self, undefined, var_266493faa440f098, center );
                    sparams.zombie cryofreeze_augments::cryofreeze_ice_cloud( self );
                    break;
                case 2:
                    self.var_46080659f132a436 = ( self.var_46080659f132a436 + 1 ) % 7;
                    sparams.zombie deadwire::function_97d4335963cfad58( 0, self, undefined, var_266493faa440f098, center, "none", undefined, 1 );
                    break;
                case 3:
                    self.var_46080659f132a436 = ( self.var_46080659f132a436 + 1 ) % 7;
                    sparams.zombie napalmburst::function_2d2890b8aaa96ed4( 0, self, undefined, var_266493faa440f098, center, "none", undefined, 1, 1 );
                    break;
                case 4:
                    self.var_46080659f132a436 = ( self.var_46080659f132a436 + 1 ) % 7;
                    sparams.zombie shadowvortex::function_7ebadea72ea922fb( 0, self, undefined, var_266493faa440f098, center, "none", undefined, 0, 0, 1, 0 );
                    break;
                case 5:
                    self.var_46080659f132a436 = ( self.var_46080659f132a436 + 1 ) % 7;
                    sparams.zombie utility::callsharedfunc( #"shatterblast", #"hash_4086acd0fbc92388", 0, self, undefined, var_266493faa440f098, center, "none", undefined, 1, 1 );
                    break;
                case 6:
                    self.var_46080659f132a436 = ( self.var_46080659f132a436 + 1 ) % 7;
                    sparams.zombie utility::callsharedfunc( #"lightray", #"hash_c333c3a1e7aa8b2d", 0, self, undefined, var_266493faa440f098, center, "none", undefined, 1, 1 );
                    break;
            }
            
            if ( isdefined( self ) )
            {
                self.var_5c871a39cc029d96 = gettime();
            }
        }
    }
}

