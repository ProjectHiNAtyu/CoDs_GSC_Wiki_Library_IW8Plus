// scripts\mp\samsite.gsc  (hash_09c80f03799b1fbc.gscc) (size: 11385 Bytes / 0x2c79 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6059da8c (1616501388)
// size ...... 11385 (0x2c79)
// includes .. 3   (offset: 0x2959)
// strings ... 50  (offset: 0x2971)
// dev strs .. 0   (offset: 0x2c6d)
// exports ... 24  (offset: 0x1ba1)
// cseg ...... 0x412 + 0x178f (0x1ba1)
// imports ... 79  (offset: 0x1f61)
// animtree1 . 1   (offset: 0x2c6d)
// animtree2 . 0   (offset: 0x2c79)
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;

#namespace samsite;

// Namespace samsite
// Params 1
// Checksum 0xde765dbc, Offset: 0x430
// Size: 0x22a
function sam_spawntest( turret )
{
    turret endon( #"death" );
    turret.target_entity = spawn( "script_model", turret.origin + ( 0, 0, 900 ) + anglestoforward( turret.angles ) * 750 );
    leftpos = anglestoleft( turret.angles ) * 500;
    rightpos = anglestoright( turret.angles ) * 500;
    turret settargetentity( turret.target_entity );
    turret.target_entity moveto( turret.origin + ( 0, 0, 900 ) + anglestoforward( turret.angles ) * 750 + rightpos, 5 );
    turret setscriptablepartstate( "audio", "rotate_start" );
    wait 5;
    turret setscriptablepartstate( "audio", "rotate_stop" );
    pos = "right";
    
    while ( true )
    {
        wait 1;
        turret thread function_c6f769c78c2e9b12();
        wait 10;
        turret thread function_c6f769c78c2e9b12();
        wait 10;
        turret thread function_c6f769c78c2e9b12();
        wait 5;
        function_e223076ba8697313( turret );
        wait 1;
        
        if ( pos == "right" )
        {
            turret.target_entity moveto( turret.origin + ( 0, 0, 900 ) + anglestoforward( turret.angles ) * 1000 + leftpos, 5 );
            pos = "left";
        }
        else if ( pos == "left" )
        {
            turret.target_entity moveto( turret.origin + ( 0, 0, 750 ) + anglestoforward( turret.angles ) * 1000 + rightpos, 5 );
            pos = "right";
        }
        
        turret setscriptablepartstate( "audio", "rotate_start" );
        wait 5;
        turret setscriptablepartstate( "audio", "rotate_stop" );
    }
}

// Namespace samsite
// Params 3
// Checksum 0x6ba898f6, Offset: 0x662
// Size: 0x1bc
function function_5772afed0d0a7557( struct, model, turretweapon = "iw9_tur_samsite_cp" )
{
    turret = spawnturret( "misc_turret", struct.origin, turretweapon );
    
    if ( !isdefined( struct.angles ) )
    {
        struct.angles = ( 0, 0, 0 );
    }
    
    turret.angles = struct.angles;
    
    if ( !isdefined( model ) )
    {
        model = "military_samsite_01_rig_skeleton";
    }
    
    turret.team = "axis";
    turret setmodel( model );
    turret settoparc( 75 );
    turret setbottomarc( 0 );
    turret setleftarc( 360 );
    turret setrightarc( 360 );
    turret makeunusable();
    turret setscriptablepartstate( "rocket1", "hidden" );
    turret setscriptablepartstate( "rocket2", "hidden" );
    turret setscriptablepartstate( "rocket3", "hidden" );
    gametype = game_utility::getgametype();
    
    if ( gametype == "wm" || gametype == "ob" )
    {
        turret setscriptablepartstate( "usable_left", "usable" );
        turret setscriptablepartstate( "usable_right", "usable" );
        turret setscriptablepartstate( "usable_front", "usable" );
    }
    else
    {
        useent = spawn( "script_model", turret.origin + ( 0, 0, 40 ) );
        useent setmodel( "tag_origin" );
        useent thread function_d5871cb3ba4e3fb5();
        turret.useent = useent;
    }
    
    return turret;
}

// Namespace samsite
// Params 2
// Checksum 0x21b4efb3, Offset: 0x827
// Size: 0x65
function function_e223076ba8697313( turret, sam_modelname )
{
    if ( !isdefined( turret ) )
    {
        return;
    }
    
    turret.missile1 = turret function_68d749d82d50abd2( 1, sam_modelname );
    turret.missile2 = turret function_68d749d82d50abd2( 2, sam_modelname );
    turret.missile3 = turret function_68d749d82d50abd2( 3, sam_modelname );
}

// Namespace samsite
// Params 2
// Checksum 0xe05aa41a, Offset: 0x894
// Size: 0x89
function function_68d749d82d50abd2( num, sam_modelname )
{
    missile = spawn( "script_model", self gettagorigin( "mg0" + num ) );
    
    if ( isdefined( sam_modelname ) )
    {
        missile setmodel( sam_modelname );
    }
    else
    {
        missile setmodel( "military_missile_rig_skeleton" );
    }
    
    missile.angles = self gettagangles( "mg0" + num );
    missile linkto( self, "mg0" + num );
    missile thread function_10a696ff0a96e424( self );
    return missile;
}

// Namespace samsite
// Params 1
// Checksum 0xb53623bf, Offset: 0x926
// Size: 0x270
function function_c6f769c78c2e9b12( istest )
{
    self endon( #"death" );
    missile = undefined;
    
    if ( isdefined( self.missile1 ) )
    {
        missile = self.missile1;
        self.missile1 notify( #"hash_ca6921477c7ed867" );
        self.missile1 = undefined;
        
        if ( !self isnearanyplayer( 5000 ) || istest )
        {
            self.missile1 = function_68d749d82d50abd2( 1 );
        }
    }
    else if ( isdefined( self.missile2 ) )
    {
        missile = self.missile2;
        self.missile2 notify( #"hash_ca6921477c7ed867" );
        self.missile2 = undefined;
        
        if ( !self isnearanyplayer( 5000 ) || istest )
        {
            self.missile2 = function_68d749d82d50abd2( 2 );
        }
    }
    else if ( isdefined( self.missile3 ) )
    {
        missile = self.missile3;
        self.missile3 notify( #"hash_ca6921477c7ed867" );
        self.missile3 = undefined;
        
        if ( !self isnearanyplayer( 5000 ) || istest )
        {
            self.missile3 = function_68d749d82d50abd2( 3 );
        }
        else
        {
            utility::delaythread( 5, &function_44516c040c1d6fa );
        }
    }
    
    self setscriptablepartstate( "launch", "on" );
    
    if ( !isdefined( missile ) )
    {
        return;
    }
    
    self.var_248955cad2996e34 = missile;
    missile.launched = 1;
    fakefireweapon = makeweapon( "iw9_la_samsite_cp" );
    magicbullet( fakefireweapon, missile.origin, missile.origin );
    
    if ( game_utility::getgametype() == "wm" )
    {
        playsoundatpos( missile.origin + ( 0, 30, 0 ), "jup_samsite_fire_npc" );
    }
    else
    {
        playsoundatpos( missile.origin + ( 0, 30, 0 ), "weap_samsite_fire_npc" );
    }
    
    missile setscriptablepartstate( "military_samsite_missile", "on" );
    missile unlink();
    wait 0.5;
    earthquake( 0.4, 1, missile.origin, 1200 );
    missile moveto( missile.origin + anglestoforward( missile.angles ) * 40000, 15 );
    wait 15;
    
    if ( isdefined( missile ) )
    {
        missile delete();
    }
}

// Namespace samsite
// Params 1
// Checksum 0x9c7fde46, Offset: 0xb9e
// Size: 0xc2
function sam_spawn( struct )
{
    turret = function_5772afed0d0a7557( struct );
    function_e223076ba8697313( turret );
    turret.target_entity = spawn( "script_model", turret.origin + ( 0, 0, 900 ) + anglestoforward( turret.angles ) * 1000 );
    leftpos = anglestoleft( turret.angles ) * 1000;
    rightpos = anglestoright( turret.angles ) * 1000;
    turret settargetentity( turret.target_entity );
    turret thread function_4ae7dfef75c455e6();
    return turret;
}

// Namespace samsite
// Params 0
// Checksum 0xd8b8e782, Offset: 0xc69
// Size: 0x12c
function sam_idle()
{
    self endon( #"launching" );
    self endon( #"death" );
    idle_points = function_31f3e39c934d37dd( self.origin + ( 0, 0, 800 ), 12, 512 );
    startingpoint = function_47c86977a18df38b( idle_points, self.target_entity.origin );
    var_ab8a92654788f6d9 = 0;
    thread function_d3ea919d856bdfa6();
    
    while ( true )
    {
        foreach ( point in idle_points )
        {
            if ( startingpoint != point && !var_ab8a92654788f6d9 )
            {
                continue;
            }
            else if ( !var_ab8a92654788f6d9 )
            {
                var_ab8a92654788f6d9 = 1;
                continue;
            }
            
            self.target_entity moveto( point.origin, 5 );
            wait 5;
        }
        
        waitframe();
    }
}

// Namespace samsite
// Params 0
// Checksum 0x2c68d042, Offset: 0xd9d
// Size: 0x12c
function function_2c011ad68afa9951()
{
    idle_points = function_31f3e39c934d37dd( self.origin + ( 0, 0, 800 ), 12, 512 );
    startingpoint = function_47c86977a18df38b( idle_points, self.target_entity.origin );
    var_ab8a92654788f6d9 = 0;
    thread function_d3ea919d856bdfa6();
    count = 0;
    
    foreach ( point in idle_points )
    {
        if ( startingpoint != point && !var_ab8a92654788f6d9 )
        {
            continue;
        }
        
        self.target_entity moveto( point.origin, 1.5 );
        wait 1.5;
        count++;
        
        if ( count > 2 )
        {
            break;
        }
    }
    
    self notify( #"launching" );
    wait 1.5;
}

// Namespace samsite
// Params 0
// Checksum 0x679cb354, Offset: 0xed1
// Size: 0x3b
function function_d3ea919d856bdfa6()
{
    self endon( #"death" );
    self setscriptablepartstate( "audio", "rotate_start" );
    self waittill( #"launching" );
    self setscriptablepartstate( "audio", "rotate_stop" );
}

// Namespace samsite
// Params 3
// Checksum 0x51ee68b2, Offset: 0xf14
// Size: 0xeb
function function_31f3e39c934d37dd( point, num_positions, path_radius )
{
    degs_per_pos = 360 / num_positions;
    positions = [];
    fwd = ( 1, 0, 0 );
    i = 0;
    
    while ( i < 360 )
    {
        altforward = fwd * path_radius;
        rotated_forward = ( cos( i ) * altforward[ 0 ] - sin( i ) * altforward[ 1 ], sin( i ) * altforward[ 0 ] + cos( i ) * altforward[ 1 ], altforward[ 2 ] );
        pos = point + rotated_forward;
        position = spawnstruct();
        position.origin = pos;
        positions[ positions.size ] = position;
        i += degs_per_pos;
    }
    
    return positions;
}

// Namespace samsite
// Params 1
// Checksum 0x7c0470fc, Offset: 0x1008
// Size: 0x252
function function_10a696ff0a96e424( sam_site )
{
    self endon( #"death" );
    self.health = 999999;
    self setcandamage( 1 );
    self setcanradiusdamage( 1 );
    self.dmgtaken = 0;
    self.var_19f6c7c935cb45e0 = 750;
    self.var_2c44fe21572b1d02 = &function_8d7161989c6f416c;
    attacker = undefined;
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, tagname, partname, dflags, objweapon );
        
        if ( !isplayer( attacker ) || !isexplosivedamagemod( meansofdeath ) && meansofdeath != "MOD_IMPACT" )
        {
            if ( isplayer( attacker ) && utility::isbulletdamage( meansofdeath ) )
            {
                if ( utility::issharedfuncdefined( #"damage", #"updatedamagefeedback" ) )
                {
                    updatedamagefeedbackfunc = utility::getsharedfunc( #"damage", #"updatedamagefeedback" );
                    attacker thread [[ updatedamagefeedbackfunc ]]( "hitnobulletdamage" );
                }
            }
            
            self.health += amount;
            continue;
        }
        
        if ( !isexplosivedamagemod( meansofdeath ) )
        {
            self.health += amount;
            continue;
        }
        
        if ( isdefined( objweapon ) && objweapon.basename == "c4_mp" )
        {
            amount = 350;
        }
        
        self.dmgtaken += amount;
        
        if ( self.dmgtaken > self.var_19f6c7c935cb45e0 )
        {
            break;
        }
    }
    
    self.health = 0;
    playfx( level._effect[ "c4_explosion_convoy" ], self.origin );
    earthquake( 0.35, 1, self.origin, 1024 );
    org = self.origin;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
    
    radiusdamage( org, 350, 300, 300, attacker, "MOD_EXPLOSIVE" );
}

// Namespace samsite
// Params 1
// Checksum 0xa8a22c09, Offset: 0x1262
// Size: 0x321
function function_4ae7dfef75c455e6( sam_site )
{
    self endon( #"hash_1c3f71ac236fabac" );
    self setcandamage( 1 );
    self setcanradiusdamage( 1 );
    self.dmgtaken = 0;
    self.var_19f6c7c935cb45e0 = 750;
    self.var_2c44fe21572b1d02 = &function_8d7161989c6f416c;
    attacker = undefined;
    self.health = 9999999;
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, tagname, partname, dflags, objweapon );
        
        if ( isdefined( objweapon ) && ( objweapon.basename == "c4_mp" || objweapon.basename == "c4_cp_noproj" ) )
        {
            amount = 1000;
        }
        else if ( !isplayer( attacker ) || !isexplosivedamagemod( meansofdeath ) && meansofdeath != "MOD_IMPACT" )
        {
            if ( isplayer( attacker ) && utility::isbulletdamage( meansofdeath ) )
            {
                if ( utility::issharedfuncdefined( #"damage", #"updatedamagefeedback" ) )
                {
                    updatedamagefeedbackfunc = utility::getsharedfunc( #"damage", #"updatedamagefeedback" );
                    attacker thread [[ updatedamagefeedbackfunc ]]( "hitnobulletdamage" );
                }
            }
            
            self.health += amount;
            continue;
        }
        
        if ( !isexplosivedamagemod( meansofdeath ) )
        {
            self.health += amount;
            continue;
        }
        
        if ( isdefined( objweapon ) )
        {
            weaponrootname = getweaponrootstring( objweapon );
            
            switch ( weaponrootname )
            {
                case #"hash_fa1e80f6bd5b8e72":
                    amount = 755;
                    break;
                case #"hash_5d11ac1131cddab1":
                case #"hash_607145e68712971c":
                case #"hash_720535feb098085f":
                case #"hash_7c03088193266bc4":
                case #"hash_c9a436974fe60919":
                case #"hash_d2d2f2854b7d8b7d":
                case #"hash_ff28a6c5cf8f547f":
                    amount = int( 225 );
                    break;
                case #"hash_326dc2026394652a":
                case #"hash_572e39c5466a5575":
                    amount = 380;
                    break;
            }
        }
        
        self.health += amount;
        
        if ( utility::isbulletdamage( meansofdeath ) )
        {
            amount = min( 10, amount );
        }
        
        self.dmgtaken += amount;
        
        if ( self.dmgtaken > self.var_19f6c7c935cb45e0 )
        {
            break;
        }
    }
    
    if ( utility::issharedfuncdefined( #"challenges", #"hash_daaf38d0e3087691" ) )
    {
        [[ utility::getsharedfunc( #"challenges", #"hash_daaf38d0e3087691" ) ]]( level.script, objweapon, attacker );
    }
    
    sam_explode( attacker );
}

// Namespace samsite
// Params 3
// Checksum 0xd9dea2e7, Offset: 0x158b
// Size: 0x2fe
function sam_explode( attacker, part = "base", destroyed_model_name )
{
    self.health = 0;
    self setscriptablepartstate( part, "destroyed" );
    utility::play_loopsound_in_space( "dst_mil_sam_site_fire_lp", self.origin );
    radiusdamage( self.origin, 350, 300, 85 );
    
    if ( isdefined( self.missile1 ) && !self.missile1.launched )
    {
        if ( isdefined( level._effect[ "c4_explosion_convoy" ] ) )
        {
            playfx( level._effect[ "c4_explosion_convoy" ], self.missile1.origin );
        }
        
        self.missile1 hide();
    }
    
    if ( isdefined( self.missile2 ) && !self.missile2.launched )
    {
        if ( isdefined( level._effect[ "c4_explosion_convoy" ] ) )
        {
            playfx( level._effect[ "c4_explosion_convoy" ], self.missile2.origin );
        }
        
        self.missile2 hide();
    }
    
    if ( isdefined( self.missile3 ) && !self.missile3.launched )
    {
        if ( isdefined( level._effect[ "c4_explosion_convoy" ] ) )
        {
            playfx( level._effect[ "c4_explosion_convoy" ], self.missile3.origin );
        }
        
        self.missile3 hide();
    }
    
    if ( isdefined( self.soundent ) )
    {
        self.soundent delete();
    }
    
    if ( isdefined( self.useent ) )
    {
        self.useent delete();
    }
    
    destroyed_model = spawn( "script_model", self.origin );
    destroyed_model.angles = self.angles;
    
    if ( isdefined( destroyed_model_name ) )
    {
        destroyed_model setmodel( destroyed_model_name );
    }
    else
    {
        destroyed_model setmodel( "military_samsite_01_damaged_rig_skeleton" );
    }
    
    destroyed_model setscriptablepartstate( "base", "destroyed" );
    
    if ( level.var_ad30af62fe9e5839 )
    {
        destroyed_model.dmgtrig = spawn( "trigger_radius", self.origin, 0, 96, 512 );
        destroyed_model.dmgtrig.targetname = "sam_dmg";
        destroyed_model.dmgtrig thread sam_playerdamagemonitor();
    }
    
    if ( !isdefined( level.destroyed_samsites ) )
    {
        level.destroyed_samsites = [];
    }
    
    level.destroyed_samsites[ level.destroyed_samsites.size ] = destroyed_model;
    level notify( #"samsite_destroyed", attacker );
    self notify( #"samsite_dead", attacker );
    wait 10;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace samsite
// Params 0
// Checksum 0x358bd0f3, Offset: 0x1891
// Size: 0x4d
function sam_playerdamagemonitor()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( isplayer( ent ) )
        {
            thread sam_playerdamage( ent );
        }
    }
}

// Namespace samsite
// Params 1
// Checksum 0xd5fac171, Offset: 0x18e6
// Size: 0x64
function sam_playerdamage( player )
{
    player endon( #"disconnect" );
    
    if ( !player.onfire )
    {
        player.onfire = 1;
        player dodamage( 45, player.origin, undefined, undefined, "MOD_TRIGGER_HURT" );
        wait 0.5;
        player.onfire = 0;
    }
}

// Namespace samsite
// Params 0
// Checksum 0x48a8f79f, Offset: 0x1952
// Size: 0x3d
function sam_dmgmsg()
{
    if ( self.showing_sam_dmg )
    {
        return;
    }
    
    self.showing_sam_dmg = 1;
    self thread [[ level.showerrormessagefunc ]]( %"mp/explosve_damage_only" );
    wait 3;
    self.showing_sam_dmg = undefined;
}

// Namespace samsite
// Params 1
// Checksum 0x3487f46a, Offset: 0x1997
// Size: 0x29, Type: bool
function function_8d7161989c6f416c( idamage )
{
    if ( idamage + self.dmgtaken > self.var_19f6c7c935cb45e0 )
    {
        return true;
    }
    
    return false;
}

// Namespace samsite
// Params 0
// Checksum 0x2ee7c6ef, Offset: 0x19c9
// Size: 0x27
function function_44516c040c1d6fa()
{
    self endon( #"death" );
    
    while ( self isnearanyplayer( 5000 ) )
    {
        wait 1;
    }
    
    function_e223076ba8697313( self );
}

// Namespace samsite
// Params 0
// Checksum 0xe1059e7c, Offset: 0x19f8
// Size: 0x71
function function_d5871cb3ba4e3fb5()
{
    self makeusable();
    self endon( #"death" );
    function_25b6c739ac062144();
    player = undefined;
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( !player isvalidplayer() )
        {
            continue;
        }
        
        break;
    }
    
    player giveandfireoffhand( "c4_mp" );
    self makeunusable();
    wait 5;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace samsite
// Params 0
// Checksum 0x55eacce1, Offset: 0x1a71
// Size: 0x52
function function_9a29ad713c169bd1()
{
    if ( !isdefined( level.scr_animtree[ "samsite" ] ) )
    {
        function_ebccf21577bc8a09();
    }
    
    self.animname = "samsite";
    self useanimtree( level.scr_animtree[ "samsite" ] );
    animation::anim_single( [ self ], "fire" );
}

#using_animtree( "script_model" );

// Namespace samsite
// Params 0
// Checksum 0x6b525550, Offset: 0x1acb
// Size: 0x39
function function_ebccf21577bc8a09()
{
    level.scr_animtree[ "samsite" ] = #animtree;
    level.scr_anim[ "samsite" ][ "fire" ] = level.br_anim[ "iw9_mp_prop_samsite_launch" ];
}

// Namespace samsite
// Params 0
// Checksum 0x6addbc19, Offset: 0x1b0c
// Size: 0x36, Type: bool
function isvalidplayer()
{
    if ( !isplayer( self ) )
    {
        return false;
    }
    
    if ( !isdefined( self ) )
    {
        return false;
    }
    
    if ( !isalive( self ) )
    {
        return false;
    }
    
    if ( self.sessionstate == "spectator" )
    {
        return false;
    }
    
    return true;
}

// Namespace samsite
// Params 0
// Checksum 0x9a5b2abc, Offset: 0x1b4b
// Size: 0x56
function function_25b6c739ac062144()
{
    self sethintstring( &"cp_mission_esc/plant_charge" );
    self sethinticon( "hud_icon_c4_plant" );
    self sethintdisplayrange( 512 );
    self setuserange( 150 );
    self setcursorhint( "HINT_BUTTON" );
    self sethintdisplayfov( 65 );
    self sethintonobstruction( "show" );
    self setuseholdduration( "duration_short" );
}

