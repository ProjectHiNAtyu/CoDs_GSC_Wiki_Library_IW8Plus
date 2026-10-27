// script_421ed14c38dd11e  (hash_0421ed14c38dd11e.gscc) (size: 26547 Bytes / 0x67b3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x72828460 (1921156192)
// size ...... 26547 (0x67b3)
// includes .. 24  (offset: 0x6323)
// strings ... 59  (offset: 0x63e3)
// dev strs .. 10  (offset: 0x6737)
// exports ... 67  (offset: 0x3f57)
// cseg ...... 0x4f4 + 0x3a63 (0x3f57)
// imports ... 212 (offset: 0x49cf)
// animtree1 . 0   (offset: 0x67b3)
// animtree2 . 0   (offset: 0x67b3)
#using script_31ee2a173f3499b7;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\mp\common\killstreaks\sentry_gun_mp;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\damage;
#using scripts\mp\vehicles\damage;
#using scripts\mp\zm\zm_utility;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_camera;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_hazard;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace namespace_31ff9b79f857ed23;

// Namespace namespace_31ff9b79f857ed23
// Params 0, eflags: 0x5
// Checksum 0x81d09fe7, Offset: 0x512
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_6b5f76758828f168", undefined, undefined, &init );
}

// Namespace namespace_31ff9b79f857ed23
// Params 0
// Checksum 0x2797996e, Offset: 0x533
// Size: 0x9
function init()
{
    thread initside();
}

// Namespace namespace_31ff9b79f857ed23
// Params 0
// Checksum 0x7246df93, Offset: 0x544
// Size: 0xf5
function initside()
{
    level utility::flag_wait( "ztron_bonus_room_initialized" );
    var_a8d8980c65b4b0de = ztron_bonus_room::function_98dedbfc79dc3572( "side_scroller_helo" );
    
    if ( var_a8d8980c65b4b0de.size > 0 )
    {
        foreach ( room in var_a8d8980c65b4b0de )
        {
            room function_6dcd23c5789ccae5();
            room.setupcallback = &sidesetup;
            room.var_d822af3942fcbc3d = &function_435f0c71c3aa8605;
            room.var_d4ea8a279b48a561 = 1;
            room.var_a3f88f4d9c9c6b73 = 1;
            room.var_e1b2540e2c81f811 = 1;
        }
    }
    
    /#
        level thread function_ac7ee3673d6e340d();
    #/
}

// Namespace namespace_31ff9b79f857ed23
// Params 0
// Checksum 0x89ce6dec, Offset: 0x641
// Size: 0x90
function function_6dcd23c5789ccae5()
{
    self.var_6210dc1f68bbfa57 = 0;
    self.var_cbb1c8215c893086 = utility::getstruct( "side_scroller2_cam_start", "script_noteworthy" );
    self.helispawnpoints = utility::getstructarray( "bonus_" + self.name + "_helo_spawnpoint", "targetname" );
    self.var_c6e91d5c2ae9021f = utility::getstructarray( "bonus_" + self.name + "_spectator", "targetname" );
    assert( self.var_c6e91d5c2ae9021f.size > 0, "<dev string:x24>" );
}

// Namespace namespace_31ff9b79f857ed23
// Params 1, eflags: 0x4
// Checksum 0x4c71ebe2, Offset: 0x6d9
// Size: 0x70
function private sideend( reason )
{
    level notify( #"side_end" );
    
    if ( isdefined( self.moveorg ) )
    {
        self.moveorg delete();
        self.moveorg = undefined;
    }
    
    wait 5;
    
    if ( isdefined( self.exit ) )
    {
        self.exit notify( #"abort" );
    }
    
    self notify( #"room_done" );
}

// Namespace namespace_31ff9b79f857ed23
// Params 0, eflags: 0x4
// Checksum 0xb1b2fcc, Offset: 0x751
// Size: 0xe
function private function_6ed2c20377fc032b()
{
    self notify( #"exit_god_mode" );
}

// Namespace namespace_31ff9b79f857ed23
// Params 1, eflags: 0x4
// Checksum 0xd1e65eb0, Offset: 0x767
// Size: 0x9b
function private vehiclegodmode( duration )
{
    self endon( #"death" );
    
    if ( self.godmode )
    {
        return;
    }
    
    ztron_debug::debugmsg( "vehicleGodMode enter " + gettime() );
    self.godmode = 1;
    shieldfx = utility::getfx( "ztron_player_shield_short_sideView" );
    playfxontag( shieldfx, self, "tag_origin" );
    utility::waittill_any_timeout( duration, "exit_god_mode" );
    ztron_debug::debugmsg( "vehicleGodMode exit " + gettime() );
    stopfxontag( shieldfx, self, "tag_origin" );
    self.godmode = 0;
}

// Namespace namespace_31ff9b79f857ed23
// Params 14, eflags: 0x4
// Checksum 0x80b94237, Offset: 0x80a
// Size: 0x1c7
function private vehicledamagecallback( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid )
{
    if ( self.godmode )
    {
        return;
    }
    
    if ( self.owner.team == attacker.team )
    {
        return;
    }
    
    if ( meansofdeath == "MOD_SUICIDE" )
    {
        damage = self.maxhealth;
    }
    else
    {
        damage = damage > 0 ? 1 : 0;
    }
    
    if ( self.health > 0 )
    {
        self.health -= damage;
        self.health = int( clamp( self.health, 0, self.maxhealth ) );
        thread function_6f1ac9061eb3e907();
        function_c462b91b2a449e23();
    }
    
    if ( attacker.classname == "worldspawn" )
    {
        vfx = utility::getfx( "ztron_player_heli_hit_damage_sideView" );
        playfxontag( vfx, self, "tag_origin" );
    }
    
    if ( self.health == 0 )
    {
        if ( isdefined( self.owner ) )
        {
            data = damage_utility::packdamagedata( attacker, self, damage, objweapon, meansofdeath, inflictor, point, dir, modelindex, attachtagname, partname, undefined, dflags, eventid, hitloc );
            self.owner notify( #"hash_323126e6acb1231e", data );
        }
        
        return;
    }
    
    thread vehiclegodmode( 3 );
}

// Namespace namespace_31ff9b79f857ed23
// Params 0
// Checksum 0x697dfd83, Offset: 0x9d9
// Size: 0x50
function function_6f1ac9061eb3e907()
{
    self endon( #"death" );
    
    for ( c = 0; c < 10 ; c++ )
    {
        self setscriptablepartstate( "damaged_received_animation", "on" );
        wait 0.3;
        self setscriptablepartstate( "damaged_received_animation", "off" );
        waitframe();
    }
}

// Namespace namespace_31ff9b79f857ed23
// Params 1, eflags: 0xc
// Checksum 0x7cd24d11, Offset: 0xa31
// Size: 0x14a
function private function_e32a3100b40e562( room )
{
    self notify( #"hash_5ae7c7f8c511a73a" );
    self endon( #"hash_5ae7c7f8c511a73a" );
    self endon( #"disconnect" );
    thread ztron_item::function_bdebc9f850639d13( "ztron_helicopter_side_scroller" );
    self waittill( #"vehicle_enter", vehicle );
    vehicle thread ztron_util::function_36239518d8da65f0( self, "disconnect" );
    vehicle.health = 10;
    vehicle.maxhealth = 10;
    vehicle.fuel = 100;
    vehicle.var_770281861b1d4ec4 = 2;
    vehicle.maxfuel = 100;
    vehicle.ztron = spawnstruct();
    vehicle.damagecallback = &vehicledamagecallback;
    waitframe();
    idx = self.sessionuimemberindex;
    idx = clampint( idx, 0, room.helispawnpoints.size - 1 );
    thread ztron_util::teleport_player( room.helispawnpoints[ idx ].origin, room.helispawnpoints[ idx ].angles );
    ztron_ui::function_ba4ed5d9b5ec4bae();
    thread function_dec5440938e182f1( vehicle );
    level notify( #"hash_a79dab85edc3b22a" );
}

// Namespace namespace_31ff9b79f857ed23
// Params 0, eflags: 0xc
// Checksum 0x3f27389, Offset: 0xb83
// Size: 0x26
function private function_1a016194f954d14a()
{
    self notify( #"hash_a81ecd9f8c5baff2" );
    self endon( #"hash_a81ecd9f8c5baff2" );
    self notify( #"ztron_player_dump_vehicle" );
}

// Namespace namespace_31ff9b79f857ed23
// Params 0, eflags: 0x4
// Checksum 0xa661f2bf, Offset: 0xbb1
// Size: 0xb6
function private function_fe20bf8120ae387()
{
    foreach ( var_4d080f710fb8349e in self.hazards )
    {
        type = getxhash( var_4d080f710fb8349e.script_noteworthy );
        
        if ( type == #"elec_pole" )
        {
            var_4d080f710fb8349e.trigger_radius = 10;
            var_4d080f710fb8349e.trigger_height = 122;
        }
    }
}

// Namespace namespace_31ff9b79f857ed23
// Params 1
// Checksum 0x23d59b2a, Offset: 0xc6f
// Size: 0xc6
function sidesetup( room )
{
    level.ztron.sideviewactive = 1;
    level.var_8972cc8b6869f399 = 1;
    level.ztron.var_8e96854cca0f779c = -20;
    level.ztron.var_6e99d2677d1c2965 = 40;
    room.var_76a1c6d566d98aed = 1;
    level ztron_ui::function_f5177e090dadd8f4( 2 );
    room function_fe20bf8120ae387();
    room thread sideclean();
    function_d9ffa07015cdc2d1( room );
    level callback::add( "on_zombie_ai_killed", &function_36e82b3eaa874d78 );
    level waittill( #"hash_9d2492f7742c7564" );
    room thread function_2d97f9ee692eaaa7();
    room thread function_bc728afabc95ca95();
    room thread function_2349d2bb435ccf26();
}

// Namespace namespace_31ff9b79f857ed23
// Params 0
// Checksum 0x779eb1e8, Offset: 0xd3d
// Size: 0xa0
function sideclean()
{
    level utility::waittill_any( "bonus_room_expired", "ztron_game_is_over" );
    clearentities();
    function_b1406bacd91e0b43();
    function_d08d3f1806c83361( self );
    ztron_util::killallenemies();
    level thread ztron_item::function_25f69b2b896fd56();
    level callback::remove( "on_zombie_ai_killed", &function_36e82b3eaa874d78 );
    level.var_8972cc8b6869f399 = 0;
    level.ztron.sideviewactive = 0;
    level.ztron.var_8e96854cca0f779c = undefined;
    level.ztron.var_6e99d2677d1c2965 = undefined;
    ztron_ui::function_d43781ee65f990d();
    level ztron_ui::function_f5177e090dadd8f4( 0 );
}

// Namespace namespace_31ff9b79f857ed23
// Params 0
// Checksum 0xf977d2c5, Offset: 0xde5
// Size: 0x89
function function_b1406bacd91e0b43()
{
    foreach ( var_4d080f710fb8349e in self.var_5e825774eedf11d2 )
    {
        var_4d080f710fb8349e notify( #"destroy_hazard" );
    }
    
    self.var_5e825774eedf11d2 = undefined;
}

// Namespace namespace_31ff9b79f857ed23
// Params 1, eflags: 0xc
// Checksum 0x7f9b9fb6, Offset: 0xe76
// Size: 0x107
function private function_c8dbe80abc7ee07f( var_4659d2db90ce8d11 = 0 )
{
    self notify( #"hash_480a6e6c6573b665" );
    self endon( #"hash_480a6e6c6573b665" );
    thread function_9b25ae40b9b65f5b( var_4659d2db90ce8d11 );
    thread function_410f9cd6f3e6e5cc();
    
    foreach ( player in level.players )
    {
        if ( !var_4659d2db90ce8d11 )
        {
            player val::set( "side_scroller_helo", "vehicle_exit", 0 );
            player val::set( "side_scroller_helo", "vehicle_seat_switch", 0 );
            player thread function_e32a3100b40e562( self );
            thread function_582e2a33527cecea( player );
            continue;
        }
        
        player val::reset_all( "side_scroller_helo" );
        player thread function_1a016194f954d14a();
    }
}

// Namespace namespace_31ff9b79f857ed23
// Params 0
// Checksum 0x7882d85d, Offset: 0xf85
// Size: 0x17b
function function_410f9cd6f3e6e5cc()
{
    level endon( #"bonus_room_expired", #"hash_26543e77189e41db" );
    
    while ( true )
    {
        level waittill( #"hash_a79dab85edc3b22a" );
        
        foreach ( player in level.players )
        {
            if ( !player.ztron.vehicle )
            {
                continue;
            }
            
            foreach ( otherplayer in level.players )
            {
                if ( player == otherplayer )
                {
                    continue;
                }
                
                if ( !otherplayer.ztron.vehicle )
                {
                    continue;
                }
                
                player.ztron.vehicle function_4dbc83f34d013baf( otherplayer.ztron.vehicle );
            }
        }
    }
}

// Namespace namespace_31ff9b79f857ed23
// Params 1
// Checksum 0x18c044c0, Offset: 0x1108
// Size: 0x9d
function function_435f0c71c3aa8605( room )
{
    room thread function_c8dbe80abc7ee07f();
    
    foreach ( player in level.players )
    {
        player.ztron.var_557a2e6d2ffa015c = 1;
    }
}

// Namespace namespace_31ff9b79f857ed23
// Params 1
// Checksum 0xa8ebeee5, Offset: 0x11ad
// Size: 0xa5
function function_d08d3f1806c83361( room )
{
    room thread function_c8dbe80abc7ee07f( 1 );
    
    foreach ( player in level.players )
    {
        player.ztron.var_557a2e6d2ffa015c = 0;
    }
    
    ztron_ui::function_477495be638928c3();
}

// Namespace namespace_31ff9b79f857ed23
// Params 0, eflags: 0xc
// Checksum 0x62c2bd0a, Offset: 0x125a
// Size: 0x25
function private function_c31c49e7934410ed()
{
    self notify( #"hash_8b78d1c00f43f2c5" );
    self endon( #"hash_8b78d1c00f43f2c5" );
    wait 20;
    ztron_bonus_room::function_9595e8f0926735a4( self );
}

// Namespace namespace_31ff9b79f857ed23
// Params 1
// Checksum 0xeff1f5d7, Offset: 0x1287
// Size: 0x25b
function function_9b25ae40b9b65f5b( var_4659d2db90ce8d11 = 0 )
{
    level ztron_camera::function_672265518094104d( !var_4659d2db90ce8d11 );
    
    if ( !var_4659d2db90ce8d11 )
    {
        if ( !isdefined( self.moveorg ) )
        {
            self.moveorg = utility::spawn_model( "tag_origin", self.var_cbb1c8215c893086.origin );
        }
        
        self.moveorg forcenetfieldhighlod( 1 );
        self.moveorg setmoverantilagged( 1 );
        size = ( 968, 968, 494 );
        self.cameratrigger = spawn( "trigger_box", self.moveorg.origin + ( -128, 70, 80 ), 0, size, size );
        self.cameratrigger.angles = self.moveorg.angles;
        self.cameratrigger enablelinkto();
        self.cameratrigger linkto( self.moveorg );
        setdvar( @"hash_fec85f3a23983407", self.moveorg getentitynumber() );
        
        /#
            if ( getdvarint( @"hash_5c20025dcf72c2bc", 0 ) > 0 )
            {
                self.cameratrigger thread ztron_debug::drawtrigger();
            }
        #/
        
        thread function_986e7d2519124875();
        thread function_c31c49e7934410ed();
    }
    
    foreach ( player in level.players )
    {
        if ( !var_4659d2db90ce8d11 )
        {
            player.ztron.scriptedcam.origin = self.moveorg.origin;
            player.ztron.scriptedcam linkto( self.moveorg );
            player.ztron.scriptedcam forcenetfieldhighlod( 1 );
            self.cameratrigger thread function_df27ee94f3f918d( player );
        }
    }
}

// Namespace namespace_31ff9b79f857ed23
// Params 1
// Checksum 0x219191e2, Offset: 0x14ea
// Size: 0xbc
function function_df27ee94f3f918d( player )
{
    level endon( #"bonus_room_expired" );
    level endon( #"hash_26543e77189e41db" );
    player endon( #"disconnect" );
    
    while ( isdefined( self ) )
    {
        if ( ispointinvolume( player.origin, self ) )
        {
            pos = function_d3543bf299f0f471( player.origin );
        }
        else
        {
            pos = [ -1, -1 ];
        }
        
        /#
            if ( getdvarint( @"hash_5c20025dcf72c2bc", 0 ) > 0 )
            {
                thread utility::debugprinttoscreen( "<dev string:x55>" + pos[ 0 ] + "<dev string:x64>" + pos[ 1 ], level.framedurationseconds, 300, 300 );
            }
        #/
        
        waitframe();
    }
}

// Namespace namespace_31ff9b79f857ed23
// Params 1
// Checksum 0x70d8d738, Offset: 0x15ae
// Size: 0x8b
function function_d3543bf299f0f471( pos )
{
    var_905652bfc335786a = ( self.origin[ 0 ], self.origin[ 1 ] - 968, self.origin[ 2 ] - 494 );
    ratiox = abs( ( pos[ 1 ] - var_905652bfc335786a[ 1 ] ) / 1936 );
    ratioy = abs( ( pos[ 2 ] - var_905652bfc335786a[ 2 ] ) / 988 );
    return [ ratiox, ratioy ];
}

/#

    // Namespace namespace_31ff9b79f857ed23
    // Params 0, eflags: 0xc
    // Checksum 0x15c99526, Offset: 0x1642
    // Size: 0x6a, Type: dev
    function private function_4db47c90e69b66a()
    {
        self notify( #"hash_41b2c0e2664b3d20" );
        self endon( #"hash_41b2c0e2664b3d20" );
        
        while ( isdefined( self.moveorg ) )
        {
            thread ztron_debug::drawsphere( self.moveorg.origin + ( -100, 0, 0 ), 5, 0.05, ( 1, 0, 0 ) );
            waitframe();
        }
    }

#/

// Namespace namespace_31ff9b79f857ed23
// Params 0
// Checksum 0xe647d7f3, Offset: 0x16b4
// Size: 0x72
function function_986e7d2519124875()
{
    self.moveorg.curspeed = 0.1;
    self.moveorg.dir = ( 0, 0, 0 );
    self.moveorg thread function_d197039cc35729e7( self.var_cbb1c8215c893086 );
    
    /#
        if ( getdvarint( @"hash_5c20025dcf72c2bc", 0 ) > 0 )
        {
            thread function_4db47c90e69b66a();
        }
    #/
}

// Namespace namespace_31ff9b79f857ed23
// Params 1
// Checksum 0xc67c1232, Offset: 0x172e
// Size: 0x161
function function_d197039cc35729e7( nexttarget )
{
    level endon( #"bonus_room_expired" );
    level endon( #"hash_26543e77189e41db" );
    self endon( #"death" );
    
    if ( !( isdefined( nexttarget ) && isdefined( self ) ) )
    {
        return;
    }
    
    if ( isdefined( nexttarget.script_parameters ) )
    {
        splitstrings = strtok( nexttarget.script_parameters, ";" );
        delay = float( splitstrings[ 1 ] );
        
        if ( !isdefined( delay ) || delay == -1 )
        {
            return;
        }
        
        if ( delay > 0 )
        {
            wait delay;
            self.curspeed = 0.1;
        }
        
        speed = float( splitstrings[ 0 ] );
        
        if ( speed != 0 )
        {
            target = utility::getstruct( nexttarget.target, "targetname" );
            
            if ( isdefined( target ) )
            {
                self.dir = vectornormalize( target.origin - self.origin );
                function_7fa9bd587f6fda45( speed, 2, target.origin );
                time = distance( self.origin, target.origin ) / speed;
                self moveto( target.origin, time );
                wait time;
                thread function_d197039cc35729e7( target );
            }
        }
    }
}

// Namespace namespace_31ff9b79f857ed23
// Params 3
// Checksum 0x4b010b0b, Offset: 0x1897
// Size: 0xc4
function function_7fa9bd587f6fda45( finalspeed, time, targetpos )
{
    if ( self.curspeed == finalspeed )
    {
        return;
    }
    
    startspeed = self.curspeed;
    targettime = gettime() + utility::function_4b74c15943231980( time );
    starttime = gettime();
    
    while ( gettime() < targettime )
    {
        timefrac = math::normalize_value( starttime, targettime, gettime() );
        self.curspeed = math::lerp( startspeed, finalspeed, timefrac );
        time = distance( self.origin, targetpos ) / self.curspeed;
        self moveto( targetpos, time );
        waitframe();
    }
}

// Namespace namespace_31ff9b79f857ed23
// Params 0
// Checksum 0x236ab157, Offset: 0x1963
// Size: 0xdd
function function_2349d2bb435ccf26()
{
    level endon( #"bonus_room_expired" );
    level endon( #"hash_26543e77189e41db" );
    
    if ( isdefined( self.moveorg ) )
    {
        self.var_5e825774eedf11d2 = [];
        hazardtriggers = ztron_util::function_2d9de5c7b97db39( self.name + "_hazard_trigger", #targetname );
        
        foreach ( trigger in hazardtriggers )
        {
            trigger childthread function_d6e26cc071e85e95( self );
        }
        
        self.moveorg childthread function_b11a789c6cd075b4( self );
    }
}

// Namespace namespace_31ff9b79f857ed23
// Params 1
// Checksum 0xf87a6448, Offset: 0x1a48
// Size: 0x102
function function_d6e26cc071e85e95( room )
{
    while ( isdefined( room.moveorg ) )
    {
        if ( room.moveorg istouching( self ) )
        {
            hazards = utility::getstructarray( self.target, "targetname" );
            
            foreach ( var_4d080f710fb8349e in hazards )
            {
                room.var_5e825774eedf11d2[ room.var_5e825774eedf11d2.size ] = var_4d080f710fb8349e;
                type = getxhash( var_4d080f710fb8349e.script_noteworthy );
                thread ztron_hazard::function_ed33fea23f0d8109( type, #"create", var_4d080f710fb8349e );
            }
            
            return;
        }
        
        waitframe();
    }
}

// Namespace namespace_31ff9b79f857ed23
// Params 1
// Checksum 0xb364e0ba, Offset: 0x1b52
// Size: 0xeb
function function_b11a789c6cd075b4( room )
{
    while ( isdefined( self ) )
    {
        foreach ( var_4d080f710fb8349e in room.var_5e825774eedf11d2 )
        {
            if ( function_e6f2939774d55d7d( var_4d080f710fb8349e.origin ) && distancesquared( var_4d080f710fb8349e.origin, self.origin ) > squared( 2000 ) )
            {
                var_4d080f710fb8349e notify( #"destroy_hazard" );
                room.var_5e825774eedf11d2 = arrayremove( room.var_5e825774eedf11d2, var_4d080f710fb8349e );
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_31ff9b79f857ed23
// Params 1
// Checksum 0xa2288cf7, Offset: 0x1c45
// Size: 0x27, Type: bool
function function_e6f2939774d55d7d( pos )
{
    return vectordot( pos - self.origin, self.dir ) < 0;
}

// Namespace namespace_31ff9b79f857ed23
// Params 1
// Checksum 0xd466aa8a, Offset: 0x1c75
// Size: 0xdc
function function_d9ffa07015cdc2d1( room )
{
    room.paths = [];
    
    for ( i = 1; isdefined( utility::getstruct( "path" + i, "targetname" ) ) ; i++ )
    {
        pathstr = "path" + i;
        pathstruct = utility::getstruct( pathstr, "targetname" );
        
        if ( !isdefined( pathstruct ) )
        {
            break;
        }
        
        pathspots = [];
        pathspots[ 0 ] = pathstruct.origin;
        
        while ( isdefined( pathstruct.target ) )
        {
            pathstruct = utility::getstruct( pathstruct.target, "targetname" );
            pathspots[ pathspots.size ] = pathstruct.origin;
        }
        
        room.paths[ pathstr ] = pathspots;
    }
}

// Namespace namespace_31ff9b79f857ed23
// Params 0, eflags: 0x4
// Checksum 0xbf56137e, Offset: 0x1d59
// Size: 0x83
function private function_bc728afabc95ca95()
{
    foreach ( var_a03f3ef026355506 in self.enemytriggers )
    {
        var_a03f3ef026355506 thread function_5271dda5f56c0864( self );
        var_a03f3ef026355506 triggerenable();
    }
}

// Namespace namespace_31ff9b79f857ed23
// Params 1, eflags: 0xc
// Checksum 0xe0be9c32, Offset: 0x1de4
// Size: 0x8a
function private function_5271dda5f56c0864( room )
{
    self notify( #"hash_2a6418dc146fe64a" );
    self endon( #"hash_2a6418dc146fe64a" );
    self endon( #"death" );
    self endon( #"disable_trigger" );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( isdefined( ent ) && ent vehicle::is_vehicle() && self function_b0b72d20769d0233() )
        {
            thread spawntargetenemies( room );
            break;
        }
    }
    
    self triggerdisable();
}

// Namespace namespace_31ff9b79f857ed23
// Params 1, eflags: 0x4
// Checksum 0xe7d29578, Offset: 0x1e76
// Size: 0xb0
function private spawntargetenemies( room )
{
    assert( isdefined( self.target ) );
    var_f0ad9529fc17dd4e = utility::getstructarray( self.target, "targetname" );
    
    foreach ( point in var_f0ad9529fc17dd4e )
    {
        level thread function_95798efa90d78671( room, point );
    }
}

// Namespace namespace_31ff9b79f857ed23
// Params 2, eflags: 0x4
// Checksum 0x4da2682e, Offset: 0x1f2e
// Size: 0x1ad
function private function_95798efa90d78671( room, point )
{
    level endon( #"bonus_room_expired", #"hash_26543e77189e41db" );
    spawnarr = strtok( point.script_noteworthy, ";" );
    
    if ( spawnarr[ 0 ] == "turret" )
    {
        room thread function_b30aff62be61734a( point );
        return;
    }
    
    enemydef = ztron_enemy::function_96eea0d09d5640d1( spawnarr[ 0 ] );
    enemycount = int( spawnarr[ 1 ] );
    enemypathtype = spawnarr[ 2 ];
    
    for ( i = 0; i < enemycount ; i++ )
    {
        enemyai = ztron_enemy::function_77e1bf43b991b4a( enemydef, 1, point.origin, 0, undefined, undefined, undefined, level.ztron.active_arena, undefined, undefined, 1, 1 );
        enemyai.ignoreall = 1;
        enemyai.maxhealth = 200 + ( level.players.size - 1 ) * 0.8 * 200;
        enemyai.health = enemyai.maxhealth;
        enemyai.moveorg = utility::spawn_model( "tag_origin", enemyai.origin, point.angles );
        enemyai.moveorg.owner = enemyai;
        enemyai linkto( enemyai.moveorg );
        enemyai thread function_5b9244e26edb491( room, enemypathtype );
        enemyai thread function_9b63522ed25588cb();
        enemyai thread function_af53ded974960f6e( room );
        wait 0.5;
    }
}

// Namespace namespace_31ff9b79f857ed23
// Params 1
// Checksum 0xf1e8d4f4, Offset: 0x20e3
// Size: 0x146
function function_af53ded974960f6e( room )
{
    self endon( #"death" );
    level endon( #"bonus_room_expired", #"hash_26543e77189e41db" );
    
    while ( isdefined( room.cameratrigger ) && !ispointinvolume( self.origin, room.cameratrigger ) )
    {
        wait 0.5;
    }
    
    wait randomintrange( 2, 5 );
    
    while ( isdefined( room.cameratrigger ) && ispointinvolume( self.origin, room.cameratrigger ) )
    {
        bullet = utility::spawn_model( "t10_zm_parasite_spit_attack", self.origin, self.angles );
        bounds = bullet getboundshalfsize();
        bullet.trigger = spawn( "trigger_radius", bullet.origin, 0, bounds[ 0 ], bounds[ 2 ] * 2 );
        bullet.trigger enablelinkto();
        bullet.trigger linkto( bullet );
        bullet.trigger thread ztron_util::function_f7544bfa701db406( bullet );
        bullet thread simulatebullet( room );
        wait randomintrange( 5, 10 );
    }
}

// Namespace namespace_31ff9b79f857ed23
// Params 0, eflags: 0x4
// Checksum 0x5c4845f0, Offset: 0x2231
// Size: 0xbd
function private function_de3704b0ea49ef5a()
{
    players = [];
    
    foreach ( player in level.players )
    {
        if ( player.ztron.vehicle )
        {
            players[ players.size ] = player;
        }
    }
    
    if ( players.size > 0 )
    {
        return players[ randomint( players.size ) ];
    }
    
    return level.players[ 0 ];
}

// Namespace namespace_31ff9b79f857ed23
// Params 1, eflags: 0x4
// Checksum 0xe74376a6, Offset: 0x22f6
// Size: 0x1e4
function private simulatebullet( room )
{
    self endon( #"death" );
    utility::function_32b24db3127bff40( "spit", "aerial" );
    thread function_45ff1ed185183866();
    dir = vectornormalize( anglestoforward( self.angles ) );
    targetplayer = function_de3704b0ea49ef5a();
    
    if ( isdefined( targetplayer ) )
    {
        var_2e499a238244f803 = vectornormalize( anglestoforward( targetplayer.angles ) );
        targetplayerpos = room.cameratrigger function_d3543bf299f0f471( targetplayer.origin );
        predicteddirection = targetplayerpos[ 0 ] > 0.5 ? -1 : 1;
        predictedorigin = targetplayer.origin + 200 * var_2e499a238244f803 * predicteddirection;
        dir = vectornormalize( predictedorigin - self.origin );
    }
    
    deathtime = gettime() + utility::function_4b74c15943231980( 10 );
    
    while ( gettime() < deathtime )
    {
        results = trace::ray_trace( self.origin, self.origin + dir * 10000, undefined, trace::create_world_contents() );
        
        if ( !isdefined( results[ "position" ] ) )
        {
            break;
        }
        
        durationtime = distance( results[ "position" ], self.origin ) / 200;
        
        if ( durationtime > 0 )
        {
            self moveto( results[ "position" ], durationtime );
            self waittill( #"movedone" );
        }
        
        if ( results[ "hittype" ] == "hittype_world" )
        {
            var_62e858c45bbf3f11 = utility::getfx( "parasite_spit_attack_impact_fx" );
            
            if ( isdefined( var_62e858c45bbf3f11 ) )
            {
                playfx( var_62e858c45bbf3f11, self.origin );
            }
            
            break;
        }
        
        wait 0.1;
    }
    
    self delete();
}

// Namespace namespace_31ff9b79f857ed23
// Params 1, eflags: 0x4
// Checksum 0x8ef6af4c, Offset: 0x24e2
// Size: 0x15d
function private function_b30aff62be61734a( var_ae553e46ea7d3739 )
{
    level endon( #"bonus_room_expired", #"hash_26543e77189e41db" );
    turret = spawnturret( "misc_turret", var_ae553e46ea7d3739.origin, "sat_ztron_sentry_turret_side2" );
    turret setmodel( "jup_wm_zm_defend_turret" );
    turret.angles = var_ae553e46ea7d3739.angles;
    turret.maxhealth = 400 + ( level.players.size - 1 ) * 0.8 * 400;
    turret.health = turret.maxhealth;
    turret.var_184c25daff35740e = 1;
    turret makeunusable();
    turret setmode( "sentry" );
    turret setturretteam( zm_utility::get_zombie_team() );
    turret setleftarc( 360 );
    turret setrightarc( 360 );
    turret setbottomarc( 90 );
    turret settoparc( 90 );
    targetplayer = function_de3704b0ea49ef5a();
    targetent = targetplayer.ztron.vehicle;
    turret turretwatchdamage();
    turret thread turretwatchdeath();
    turret thread function_c698bcc5146d85c5();
    
    if ( isdefined( targetent ) )
    {
        turret settargetentity( targetent );
        turret thread turretattacktargets( self );
    }
}

// Namespace namespace_31ff9b79f857ed23
// Params 0, eflags: 0x4
// Checksum 0x8ccdba90, Offset: 0x2647
// Size: 0x36
function private turretwatchdamage()
{
    self notify( #"hash_132222844eaf7009" );
    thread damage::monitordamage( self.maxhealth, "hitequip", &sentry_gun_mp::sentryturret_handledeathdamage, &sentry_gun_mp::sentryturret_modifydamage, 1 );
    thread function_1ab66b886d993e47();
}

// Namespace namespace_31ff9b79f857ed23
// Params 0, eflags: 0x4
// Checksum 0x702904bb, Offset: 0x2685
// Size: 0xbd
function private function_1ab66b886d993e47()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath );
        
        if ( isdefined( attacker ) && damage > 0 )
        {
            playerattacker = ztron_util::function_da4039e4c338f818( attacker );
            
            if ( isdefined( playerattacker ) )
            {
                var_3f23721405e49c19 = damage > self.health ? self.health : damage;
                ztron_util::function_eb8ba16055d6da7c( playerattacker, self, "none", meansofdeath, undefined, var_3f23721405e49c19, point, undefined, undefined, 0, 0 );
            }
        }
    }
}

// Namespace namespace_31ff9b79f857ed23
// Params 0, eflags: 0x4
// Checksum 0x2c513407, Offset: 0x274a
// Size: 0x2f
function private function_c698bcc5146d85c5()
{
    self endon( #"death" );
    level utility::waittill_any( "bonus_room_expired", "ztron_game_is_over" );
    self notify( #"kill_turret", 1, 0 );
}

// Namespace namespace_31ff9b79f857ed23
// Params 0, eflags: 0x4
// Checksum 0xb1dea78, Offset: 0x2781
// Size: 0x114
function private turretwatchdeath()
{
    self waittill( #"kill_turret", skipshutdown, wasdestroyed );
    self setturretholdstill( 1 );
    self setscriptablepartstate( "explode", "violent" );
    ztron_sound::ztron_playsound( "fuel_tank_destroyed" );
    playfx( utility::getfx( "fuel_tank_explosion" ), self.origin );
    wait 1;
    
    if ( wasdestroyed )
    {
        params = spawnstruct();
        params.overrideangles = ( 0, 0, 0 );
        params.scale = 1;
        itembundlename = level.ztron.gembundles[ "ztron_gem_green" ];
        dir = vectornormalize( anglestoup( self.angles ) );
        ztron_item::requestspawnitem( itembundlename, self.origin + dir * 30, 0, undefined, params );
    }
    
    if ( isdefined( self ) )
    {
        self setscriptablepartstate( "visibility", "hide" );
        self delete();
    }
}

// Namespace namespace_31ff9b79f857ed23
// Params 1, eflags: 0x4
// Checksum 0x837791b6, Offset: 0x289d
// Size: 0x54
function private turretattacktargets( room )
{
    self endon( #"kill_turret", #"death" );
    level endon( #"bonus_room_expired", #"hash_26543e77189e41db" );
    
    while ( true )
    {
        self waittill( #"turretstatechange" );
        thread turretburstfirestart( room );
    }
}

// Namespace namespace_31ff9b79f857ed23
// Params 1, eflags: 0x4
// Checksum 0x9264e021, Offset: 0x28f9
// Size: 0x136
function private turretburstfirestart( room )
{
    self endon( #"kill_turret", #"death" );
    level endon( #"bonus_room_expired", #"hash_26543e77189e41db" );
    
    while ( isdefined( room.cameratrigger ) && !ispointinvolume( self.origin, room.cameratrigger ) )
    {
        wait 0.5;
    }
    
    while ( isdefined( room.cameratrigger ) && ispointinvolume( self.origin, room.cameratrigger ) )
    {
        targetplayer = function_de3704b0ea49ef5a();
        targetent = targetplayer.ztron.vehicle;
        
        if ( isdefined( targetent ) )
        {
            self settargetentity( targetent );
            prefiretime = self prefireturret();
            
            if ( prefiretime > 0 )
            {
                wait prefiretime;
            }
            
            for ( i = 0; i < 3 && !self.overheated ; i++ )
            {
                self shootturret( #"tag_flash" );
                wait 0.5;
            }
        }
        
        wait randomintrange( 3, 5 );
    }
}

// Namespace namespace_31ff9b79f857ed23
// Params 0, eflags: 0x4
// Checksum 0xba14b828, Offset: 0x2a37
// Size: 0xba
function private function_45ff1ed185183866()
{
    self endon( #"death" );
    level endon( #"bonus_room_expired", #"hash_26543e77189e41db" );
    assert( isdefined( self.trigger ) );
    
    while ( true )
    {
        self.trigger waittill( #"trigger", ent );
        
        if ( isdefined( ent ) && ent vehicle::is_vehicle() )
        {
            ent dodamage( 1, ent.origin, self, self );
            var_62e858c45bbf3f11 = utility::getfx( "parasite_spit_attack_impact_fx" );
            
            if ( isdefined( var_62e858c45bbf3f11 ) )
            {
                playfx( var_62e858c45bbf3f11, self.origin );
            }
            
            break;
        }
    }
    
    self delete();
}

// Namespace namespace_31ff9b79f857ed23
// Params 2, eflags: 0x4
// Checksum 0x183c7930, Offset: 0x2af9
// Size: 0x10c
function private function_5b9244e26edb491( room, pathtype )
{
    self endon( #"death" );
    level endon( #"bonus_room_expired", #"hash_26543e77189e41db" );
    
    if ( !isdefined( pathtype ) || pathtype == "" )
    {
        return;
    }
    
    pathspots = room.paths[ pathtype ];
    
    if ( !isdefined( pathspots ) || pathspots.size < 2 )
    {
        return;
    }
    
    for ( i = 0; isdefined( pathspots[ i + 1 ] ) ; i++ )
    {
        duration = distance( pathspots[ i + 1 ], pathspots[ i ] ) / 160;
        movepath = pathspots[ i + 1 ] - pathspots[ i ];
        targetpos = self.origin + movepath;
        self.moveorg moveto( targetpos, duration );
        self.moveorg waittill( #"movedone" );
    }
    
    thread ztron_util::deletemedelay( 0.5 );
}

// Namespace namespace_31ff9b79f857ed23
// Params 0, eflags: 0x4
// Checksum 0x25809b5f, Offset: 0x2c0d
// Size: 0x7c
function private function_9b63522ed25588cb()
{
    self endon( #"death" );
    level endon( #"bonus_room_expired", #"hash_26543e77189e41db" );
    bounds = self getboundshalfsize();
    trigger = spawn( "trigger_radius", self.origin, 0, bounds[ 0 ], bounds[ 2 ] * 2 );
    trigger enablelinkto();
    trigger linkto( self );
    self.deathtrigger = trigger;
    thread function_2e422fbb273b3520();
}

// Namespace namespace_31ff9b79f857ed23
// Params 0, eflags: 0x4
// Checksum 0xf7f8211d, Offset: 0x2c91
// Size: 0x6e
function private function_2e422fbb273b3520()
{
    self endon( #"death" );
    
    while ( true )
    {
        self.deathtrigger waittill( #"trigger", ent );
        
        if ( isdefined( ent ) && ent vehicle::is_vehicle() )
        {
            ent dodamage( 1, ent.origin, self, self );
            thread ztron_util::function_ea0a0be5c5468c48( 0.1 );
            break;
        }
    }
}

// Namespace namespace_31ff9b79f857ed23
// Params 1
// Checksum 0x68dfe963, Offset: 0x2d07
// Size: 0xd4
function function_36e82b3eaa874d78( params )
{
    if ( isdefined( self.deathtrigger ) )
    {
        self.deathtrigger delete();
        self.deathtrigger = undefined;
    }
    
    if ( isdefined( self.moveorg ) )
    {
        self.moveorg delete();
        self.moveorg = undefined;
    }
    
    if ( isdefined( params.eattacker ) )
    {
        params = spawnstruct();
        params.scale = 1;
        params.overrideangles = ( 0, 0, 0 );
        itembundlename = level.ztron.gembundles[ "ztron_gem_red" ];
        ztron_item::requestspawnitem( itembundlename, self.origin, 0, undefined, params );
    }
    
    thread function_f5b0182fd953ead6();
}

// Namespace namespace_31ff9b79f857ed23
// Params 0
// Checksum 0xa2ba864c, Offset: 0x2de3
// Size: 0x48
function function_f5b0182fd953ead6()
{
    level endon( #"bonus_room_expired", #"hash_26543e77189e41db" );
    waitframe();
    corpse = self getcorpseentity();
    
    if ( isdefined( corpse ) )
    {
        corpse startragdollfromimpact( "torso_lower", ( 0, 0, -1000 ) );
    }
}

// Namespace namespace_31ff9b79f857ed23
// Params 1, eflags: 0xc
// Checksum 0x5c4aebe0, Offset: 0x2e33
// Size: 0x130
function private function_721588ded11f1ead( veh )
{
    self notify( #"hash_cf34cef533cbd10f" );
    self endon( #"hash_cf34cef533cbd10f" );
    level endon( #"bonus_room_expired" );
    level endon( #"side_end" );
    veh endon( #"death", #"going_down" );
    var_ba4c804da776d979 = level.framedurationseconds * veh.var_770281861b1d4ec4;
    wait 3;
    
    while ( veh.fuel > 0 )
    {
        var_b14365457422f75d = veh.fuel < 30 ? 0.5 : 1;
        veh.fuel -= var_ba4c804da776d979 * var_b14365457422f75d;
        
        if ( veh.fuel <= 0 )
        {
            veh.fuel = 0;
            thread function_df4554fafb73bfce( veh );
        }
        
        ztron_ui::function_76bcd958c9d09b8c();
        waitframe();
    }
    
    if ( isdefined( veh ) )
    {
        veh function_6ed2c20377fc032b();
        waitframe();
        veh dodamage( veh.maxhealth, veh.origin, self, veh, "MOD_SUICIDE" );
    }
}

// Namespace namespace_31ff9b79f857ed23
// Params 1
// Checksum 0xef89f3cf, Offset: 0x2f6b
// Size: 0xfe
function function_df4554fafb73bfce( veh )
{
    self notify( #"hash_718da92ce43eab40" );
    self endon( #"hash_718da92ce43eab40" );
    level endon( #"bonus_room_expired" );
    level endon( #"side_end" );
    veh endon( #"death" );
    veh notify( #"going_down" );
    veh playsound( #"hash_2c99cc52314f1243" );
    
    while ( veh.fuel <= 0 )
    {
        veh.health -= 1;
        
        if ( veh.health <= 0 && isdefined( veh ) )
        {
            veh.health = 0;
            veh function_6ed2c20377fc032b();
            waitframe();
            veh dodamage( veh.maxhealth, veh.origin, self, veh, "MOD_SUICIDE" );
        }
        
        veh function_c462b91b2a449e23();
        wait 0.5;
    }
    
    thread function_721588ded11f1ead( veh );
}

// Namespace namespace_31ff9b79f857ed23
// Params 0, eflags: 0x4
// Checksum 0x4d05ec41, Offset: 0x3071
// Size: 0x85
function private function_c462b91b2a449e23()
{
    currentstate = self getscriptablepartstate( #"body_low_health" );
    nextstate = currentstate;
    
    if ( self.health <= 3 )
    {
        nextstate = #"on";
    }
    else
    {
        nextstate = #"off";
    }
    
    if ( currentstate != nextstate )
    {
        self setscriptablepartstate( #"body_low_health", nextstate );
    }
    
    if ( isdefined( self.owner ) )
    {
        self.owner ztron_ui::function_ba4ed5d9b5ec4bae();
    }
}

// Namespace namespace_31ff9b79f857ed23
// Params 0, eflags: 0xc
// Checksum 0x8a2fe243, Offset: 0x30fe
// Size: 0xe2
function private function_2d97f9ee692eaaa7()
{
    self notify( #"hash_4dffff5937ce07ef" );
    self endon( #"hash_4dffff5937ce07ef" );
    level endon( #"bonus_room_expired" );
    level endon( #"side_end" );
    aliveplayer = 1;
    
    while ( aliveplayer )
    {
        aliveplayer = 0;
        
        foreach ( player in level.players )
        {
            if ( isdefined( player.ztron.vehicle ) )
            {
                aliveplayer = 1;
                break;
            }
        }
        
        waitframe();
    }
    
    thread sideend( 0 );
}

// Namespace namespace_31ff9b79f857ed23
// Params 0
// Checksum 0xfbbf3a36, Offset: 0x31e8
// Size: 0x4c
function clearentities()
{
    if ( isdefined( self.moveorg ) )
    {
        self.moveorg delete();
        self.moveorg = undefined;
    }
    
    if ( isdefined( self.cameratrigger ) )
    {
        self.cameratrigger delete();
        self.cameratrigger = undefined;
    }
}

// Namespace namespace_31ff9b79f857ed23
// Params 1, eflags: 0xc
// Checksum 0xe822f4e4, Offset: 0x323c
// Size: 0x90
function private dumpheli( deathdata )
{
    self notify( #"hash_62d636424edb93d4" );
    self endon( #"hash_62d636424edb93d4" );
    vehicle = self.ztron.vehicle;
    
    if ( isdefined( vehicle ) )
    {
        vehicle thread vehicle_damage::explode();
        vehiclename = vehicle vehicle::get_ref();
        
        if ( isdefined( vehiclename ) )
        {
            deathcallback = damage::get_death_callback( vehiclename );
            vehicle [[ deathcallback ]]( deathdata );
        }
    }
    
    waitframe();
    self notify( #"ztron_player_dump_vehicle" );
}

// Namespace namespace_31ff9b79f857ed23
// Params 0, eflags: 0x4
// Checksum 0xe502d7dd, Offset: 0x32d4
// Size: 0x213
function private function_c1a6b3e262c5457b()
{
    self endon( #"disconnect" );
    
    if ( self.ztron.scriptedcam )
    {
        var_57ecee6e0b54fa8d = -150;
        offsets = [ ( var_57ecee6e0b54fa8d, -150, 0 ), ( var_57ecee6e0b54fa8d, -50, 0 ), ( var_57ecee6e0b54fa8d, 50, 0 ), ( var_57ecee6e0b54fa8d, 150, 0 ) ];
        index = self.sessionuimemberindex ?? 0;
        offset = offsets[ index % offsets.size ];
        
        if ( !isdefined( self.spectatororg ) )
        {
            self.spectatororg = utility::spawn_model( "tag_origin" );
        }
        
        self.spectatororg thread ztron_util::function_36239518d8da65f0( level, "bonus_room_completed" );
        self.spectatororg thread ztron_util::function_36239518d8da65f0( level, "ztron_game_is_over" );
        self.spectatororg enablelinkto();
        waitframe();
        
        if ( self.ztron.scriptedcam )
        {
            self.spectatororg linkto( self.ztron.scriptedcam, "tag_origin", offset, ( 0, 0, 0 ) );
            self playerlinkto( self.spectatororg );
        }
    }
    else
    {
        room = level.ztron.var_8a9067aa4cd65369;
        idx = clampint( self.sessionuimemberindex, 0, room.var_c6e91d5c2ae9021f.size - 1 );
        origin = room.var_c6e91d5c2ae9021f[ idx ].origin;
        angles = room.var_c6e91d5c2ae9021f[ idx ].angles;
        thread ztron_util::teleport_player( origin, angles );
    }
    
    thread ztron_util::set_player_frozen_vars( 1, "side_scroller_helo" );
    ztron_ui::clearplayerhint();
    level utility::waittill_any( "bonus_room_expired" );
    self unlink();
    thread ztron_ui::function_a4f9663d5b871640();
    thread ztron_util::set_player_frozen_vars( 0, "side_scroller_helo" );
}

// Namespace namespace_31ff9b79f857ed23
// Params 1, eflags: 0x4
// Checksum 0xecd7e2ed, Offset: 0x34ef
// Size: 0x47
function private function_e9af63d71193236b( deathdata )
{
    self endon( #"disconnect" );
    thread dumpheli( deathdata );
    self.ztron.vehicle waittill( #"death" );
    thread function_c1a6b3e262c5457b();
}

// Namespace namespace_31ff9b79f857ed23
// Params 1, eflags: 0xc
// Checksum 0x4ee86bed, Offset: 0x353e
// Size: 0x17f
function private function_dec5440938e182f1( veh )
{
    self notify( #"hash_36bb25f9972fd37e" );
    self endon( #"hash_36bb25f9972fd37e" );
    level endon( #"bonus_room_expired" );
    level endon( #"side_end" );
    self endon( #"disconnect" );
    room = level.ztron.var_8a9067aa4cd65369;
    thread function_721588ded11f1ead( veh );
    thread function_4143ee33e5d8beeb( room );
    self waittill( #"hash_323126e6acb1231e", deathdata );
    thread function_e9af63d71193236b( deathdata );
    
    if ( self.ztron.scriptedcam )
    {
        self.ztron.scriptedcam unlink();
        wait 2;
        
        if ( isdefined( room.moveorg ) )
        {
            fade_time = 0.3;
            thread game_utility::fadetoblackforplayerkeepui( self, 1, fade_time );
            wait fade_time;
            
            if ( isdefined( self.ztron.scriptedcam ) && isdefined( room.moveorg ) )
            {
                self.ztron.scriptedcam.origin = room.moveorg.origin;
                self.ztron.scriptedcam linkto( room.moveorg );
            }
            
            waitframe();
            thread game_utility::fadetoblackforplayerkeepui( self, 0, fade_time );
        }
    }
}

// Namespace namespace_31ff9b79f857ed23
// Params 1, eflags: 0xc
// Checksum 0x5ea94271, Offset: 0x36c5
// Size: 0x5b1
function private function_4143ee33e5d8beeb( room )
{
    self notify( #"hash_86e1b1ee675ff49b" );
    self endon( #"hash_86e1b1ee675ff49b" );
    
    if ( !isdefined( self.ztron.vehicle ) )
    {
        return;
    }
    
    veh = self.ztron.vehicle;
    level endon( #"bonus_room_expired", #"side_end" );
    veh endon( #"death" );
    var_cff8dd05c9da18ee = getdvarint( @"hash_64f5af1fdb8525dd", 750 );
    var_cff8dc05c9da16bb = getdvarint( @"hash_73690070f5640b94", 350 );
    content = 0;
    contentcache = level.create_contents_cache ?? trace::make_create_contents_cache();
    content |= contentcache._world | contentcache.vehicle | contentcache.playerclip | contentcache.vehicleclip;
    var_2ee93613e395ba53 = 50;
    var_c56d0b8368c45dd4 = [];
    
    foreach ( player in level.players )
    {
        var_c56d0b8368c45dd4[ var_c56d0b8368c45dd4.size ] = player;
        vehicle = player.ztron.vehicle;
        
        if ( isdefined( vehicle ) )
        {
            var_c56d0b8368c45dd4[ var_c56d0b8368c45dd4.size ] = vehicle;
        }
    }
    
    while ( true )
    {
        if ( isdefined( room.moveorg ) )
        {
            var_4571954f67b8f5f4 = room.moveorg.origin;
            vehorigin = veh.origin;
            dir = room.moveorg.dir;
            ydiff = vehorigin[ 1 ] - var_4571954f67b8f5f4[ 1 ];
            zdiff = vehorigin[ 2 ] - var_4571954f67b8f5f4[ 2 ];
            var_3f7e897d087072de = [ vehorigin, vehorigin + ( 0, 0, 15 ), vehorigin + ( 0, 0, -15 ) ];
            vehicleright = ( 1, 0, 0 );
            
            if ( abs( dir[ 2 ] ) > 0.1 )
            {
                for ( i = 0; i < var_3f7e897d087072de.size ; i++ )
                {
                    rotateoffset = rotatepointaroundvector( vehicleright, var_3f7e897d087072de[ i ] - vehorigin, 90 );
                    var_3f7e897d087072de[ i ] = rotateoffset + vehorigin;
                }
            }
            
            /#
                if ( getdvarint( @"hash_c30407850bfa541", 0 ) == 1 )
                {
                    foreach ( var_e2cb7370147a0fd9 in var_3f7e897d087072de )
                    {
                        thread ztron_debug::drawsphere( var_e2cb7370147a0fd9, 5, 0.05, ( 0, 1, 0 ) );
                    }
                }
            #/
            
            var_3fd0b4c657322c67 = ydiff * dir[ 1 ] < 0 && abs( ydiff ) > var_cff8dd05c9da18ee;
            var_4c47f9d4c4557a98 = zdiff * dir[ 2 ] < 0 && abs( zdiff ) > var_cff8dc05c9da16bb;
            var_ec9f5b5e0b24cfba = function_decb653c5689e4ca( veh.model );
            forcecrash = 0;
            
            if ( abs( ydiff ) > var_cff8dd05c9da18ee && abs( abs( ydiff ) - var_cff8dd05c9da18ee ) > var_ec9f5b5e0b24cfba[ 0 ] * 2 )
            {
                forcecrash = 1;
            }
            
            if ( abs( zdiff ) > var_cff8dc05c9da16bb && abs( abs( zdiff ) - var_cff8dc05c9da16bb ) > var_ec9f5b5e0b24cfba[ 2 ] * 2 )
            {
                forcecrash = 1;
            }
            
            if ( var_3fd0b4c657322c67 || var_4c47f9d4c4557a98 )
            {
                var_7344c2f804f63677 = 1;
                
                foreach ( var_e2cb7370147a0fd9 in var_3f7e897d087072de )
                {
                    passed = trace::ray_trace_passed( var_e2cb7370147a0fd9, var_e2cb7370147a0fd9 + dir * var_2ee93613e395ba53, var_c56d0b8368c45dd4, content );
                    
                    /#
                        if ( getdvarint( @"hash_c30407850bfa541", 0 ) == 1 )
                        {
                            thread ztron_debug::drawline( var_e2cb7370147a0fd9, var_e2cb7370147a0fd9 + dir * var_2ee93613e395ba53, 0.05, passed ? ( 0, 1, 0 ) : ( 1, 0, 0 ) );
                        }
                    #/
                    
                    if ( passed )
                    {
                        var_7344c2f804f63677 = 0;
                        break;
                    }
                }
                
                if ( var_7344c2f804f63677 )
                {
                    veh function_6ed2c20377fc032b();
                    waitframe();
                    veh dodamage( veh.maxhealth, veh.origin, undefined, veh, "MOD_SUICIDE" );
                    ztron_debug::debugmsg( "sideHeliScrollerPositionWatch: stucked by obstacle, destroy vehilce" );
                    break;
                }
            }
            
            if ( forcecrash )
            {
                veh function_6ed2c20377fc032b();
                waitframe();
                veh dodamage( veh.maxhealth, veh.origin, undefined, veh, "MOD_SUICIDE" );
                ztron_debug::debugmsg( "sideHeliScrollerPositionWatch: forceCrah, destroy vehilce" );
                break;
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_31ff9b79f857ed23
// Params 1
// Checksum 0x25113c07, Offset: 0x3c7e
// Size: 0xbf
function function_582e2a33527cecea( player )
{
    level endon( #"bonus_room_completed", #"ztron_game_is_over", #"hash_26543e77189e41db", #"bonus_room_expired" );
    self endon( #"room_done" );
    player endon( #"hash_323126e6acb1231e", #"disconnect" );
    timeout = self.timeout ?? 8;
    duration = clampint( timeout, 0, 1023 );
    
    if ( timeout == 999 )
    {
        while ( true )
        {
            player ztron_ui::function_787d89891b886acf( "HELI_SIDE_ROCKET_BOMB_HINT", duration, 1 );
            wait 1023;
        }
        
        return;
    }
    
    player ztron_ui::function_787d89891b886acf( "HELI_SIDE_ROCKET_BOMB_HINT", duration, 1 );
}

/#

    // Namespace namespace_31ff9b79f857ed23
    // Params 0, eflags: 0x4
    // Checksum 0x7e081e21, Offset: 0x3d45
    // Size: 0xd1, Type: dev
    function private function_1def0424ef9d5219()
    {
        foreach ( player in level.players )
        {
            vehicle = player.ztron.vehicle;
            
            if ( isdefined( vehicle ) )
            {
                vehicle.health = int( clamp( vehicle.health + 1, 0, vehicle.maxhealth ) );
                vehicle function_c462b91b2a449e23();
            }
        }
    }

    // Namespace namespace_31ff9b79f857ed23
    // Params 0, eflags: 0x4
    // Checksum 0xc0ef82c2, Offset: 0x3e1e
    // Size: 0xc4, Type: dev
    function private function_4f01e3e84bb6d283()
    {
        foreach ( player in level.players )
        {
            vehicle = player.ztron.vehicle;
            
            if ( isdefined( vehicle ) )
            {
                vehicle.fuel = clamp( vehicle.fuel + 30, 0, vehicle.maxfuel );
            }
        }
    }

    // Namespace namespace_31ff9b79f857ed23
    // Params 0
    // Checksum 0xcb1985d0, Offset: 0x3eea
    // Size: 0x6d, Type: dev
    function function_ac7ee3673d6e340d()
    {
        categoryname = ztron_bonus_room::function_26fbf99313eff547( "<dev string:x66>" );
        devgui::function_9082edeb5db93280( "<dev string:x75>" );
        devgui::add_devgui_func( "<dev string:x89>" + categoryname + "<dev string:x99>", "<dev string:xa8>", &function_1def0424ef9d5219 );
        devgui::add_devgui_func( "<dev string:x89>" + categoryname + "<dev string:xbe>", "<dev string:xd0>", &function_4f01e3e84bb6d283 );
        devgui::function_77df7fe7dd273e10();
    }

#/
