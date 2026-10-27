// script_42808e5693e44510  (hash_42808e5693e44510.gscc) (size: 6694 Bytes / 0x1a26 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x419b81c4 (1100710340)
// size ...... 6694 (0x1a26)
// includes .. 8   (offset: 0x17e2)
// strings ... 17  (offset: 0x1822)
// dev strs .. 0   (offset: 0x198a)
// exports ... 17  (offset: 0xf8a)
// cseg ...... 0x2a9 + 0xce1 (0xf8a)
// imports ... 48  (offset: 0x1232)
// animtree1 . 1   (offset: 0x198a)
// animtree2 . 9   (offset: 0x1996)
#using scripts\common\anim;
#using scripts\common\trace;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_spawn;
#using scripts\common\vehicle_tracking;
#using scripts\mp\hostmigration;

#namespace namespace_2fa0d8ac31fa2ddc;

#using_animtree( "mp_vehicles_always_loaded" );

// Namespace namespace_2fa0d8ac31fa2ddc
// Params 0
// Checksum 0x8a3beaa7, Offset: 0x2c7
// Size: 0x66
function function_601747d8dd81aeae()
{
    level.scr_anim[ "cargo_delivery_extract" ][ "heli_in" ] = %iw9_dmz_cargo_heli_in;
    level.scr_anim[ "cargo_delivery_extract" ][ "heli_loop" ] = %iw9_dmz_cargo_heli_loop;
    level.scr_anim[ "cargo_delivery_extract" ][ "heli_out" ] = %iw9_dmz_cargo_heli_out;
    function_e845f8b52bafb199();
}

#using_animtree( "script_model" );

// Namespace namespace_2fa0d8ac31fa2ddc
// Params 0
// Checksum 0x1978ec0d, Offset: 0x335
// Size: 0xce
function function_e845f8b52bafb199()
{
    level.scr_animtree[ "cargo_delivery_extract_props" ] = #animtree;
    level.scr_anim[ "cargo_delivery_extract_props" ][ "rope_in" ] = %iw9_dmz_cargo_heli_rope_in;
    level.scr_anim[ "cargo_delivery_extract_props" ][ "rope_loop" ] = %iw9_dmz_cargo_heli_rope_loop;
    level.scr_anim[ "cargo_delivery_extract_props" ][ "rope_out" ] = %iw9_dmz_cargo_heli_rope_out;
    level.scr_anim[ "cargo_delivery_extract_props" ][ "hook_in" ] = %iw9_dmz_cargo_heli_hook_in;
    level.scr_anim[ "cargo_delivery_extract_props" ][ "hook_loop" ] = %iw9_dmz_cargo_heli_hook_loop;
    level.scr_anim[ "cargo_delivery_extract_props" ][ "hook_out" ] = %iw9_dmz_cargo_heli_hook_out;
}

// Namespace namespace_2fa0d8ac31fa2ddc
// Params 3
// Checksum 0x3d79ea86, Offset: 0x40b
// Size: 0x387
function function_96b46bf7cb30b361( extractorigin, offset, helioverride )
{
    extractgroundpos = getgroundposition( extractorigin, 1 ) + offset;
    var_9370b5c935fd8b21 = extractgroundpos + ( 0, 0, 4000 );
    spawnposoffset = extractgroundpos + ( 0, 0, 8000 );
    var_ce1eb256270347b7 = extractgroundpos + ( 0, 0, 850 );
    flightyaw = 0;
    flightangles = ( 0, 0, 0 );
    flightyaw = function_9ae9103e5ab370c6( spawnposoffset, var_9370b5c935fd8b21 );
    flightangles = ( 0, flightyaw, 0 );
    enterposition = spawnposoffset - anglestoforward( flightangles ) * 20000;
    const_num_flares = 1;
    flightangle = vectortoangles( var_9370b5c935fd8b21 * ( 1, 1, 0 ) - enterposition * ( 1, 1, 0 ) );
    spawndata = spawnstruct();
    spawndata.origin = enterposition;
    spawndata.angles = flightangle;
    spawndata.var_499a16b493ff31ed = 1;
    spawndata.triggerrecycle = 1;
    spawndata vehicle_spawn::set_flag( 10 );
    
    if ( helioverride )
    {
        heli = vehicle::spawn( helioverride, spawndata );
    }
    else
    {
        heli = vehicle::spawn( %"hash_12432bf639dfdbdd", spawndata );
    }
    
    if ( !isdefined( heli ) )
    {
        return;
    }
    
    vehicle_interact::allow_use( heli, 0 );
    heli function_d2b8ee2e1275daaf( 1 );
    heli vehphys_forcekeyframedmotion();
    heli.speed = 100;
    heli.accel = 125;
    heli.health = 999999;
    heli.maxhealth = heli.health;
    heli.lifeid = 0;
    heli.flaresreservecount = const_num_flares;
    heli.enterpos = enterposition;
    heli.descendpos = var_9370b5c935fd8b21;
    heli.hoverpos = var_ce1eb256270347b7;
    heli.extractgroundpos = extractgroundpos;
    heli.sceneangles = flightangle;
    heli.var_7b10f1c2e1202450 = 1;
    heli.animname = "cargo_delivery_extract";
    heli vehicle_damage::set_can_damage( 0 );
    heli vehicle_setspeed( heli.speed, heli.accel );
    heli sethoverparams( 1, 1, 1 );
    heli setturningability( 0.05 );
    
    if ( isent( self ) )
    {
        if ( isdefined( self.team ) )
        {
            heli.team = self.team;
        }
        
        heli.owner = self;
        heli setotherent( self );
    }
    
    heli.scenenode = spawn( "script_model", extractorigin + ( 0, 0, 0 ) + offset );
    heli.scenenode.angles = heli.sceneangles;
    heli.scenenode setmodel( "tag_origin" );
    heli.scenenode animation::anim_first_frame_solo( heli, "heli_in" );
    level.var_e0e9fa51e8c5e493 = heli;
    function_2c938d4506a27ad6( heli );
    heli thread function_4f214598645f3850( extractorigin + offset );
    return heli;
}

// Namespace namespace_2fa0d8ac31fa2ddc
// Params 1, eflags: 0x4
// Checksum 0xbc10f2e3, Offset: 0x79b
// Size: 0x148
function private function_2c938d4506a27ad6( heli )
{
    rope = spawn( "script_model", ( 0, 0, 0 ) );
    rope setmodel( "misc_rapelling_rope_01_fiber_br" );
    rope linkto( heli, "tag_winch", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    rope notsolid();
    rope show();
    rope.animname = "cargo_delivery_extract_props";
    rope animation::setanimtree();
    heli animation::anim_first_frame_solo( rope, "rope_in", "tag_winch" );
    crate = spawn( "script_model", ( 0, 0, 0 ) );
    crate setmodel( "sat_machinery_industrial_magnet_crane_01" );
    crate linkto( heli, "tag_winch", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    crate notsolid();
    crate show();
    crate.animname = "cargo_delivery_extract_props";
    crate animation::setanimtree();
    heli animation::anim_first_frame_solo( crate, "hook_in", "tag_winch" );
    heli.rope = rope;
    heli.crate = crate;
}

// Namespace namespace_2fa0d8ac31fa2ddc
// Params 3
// Checksum 0xe566b229, Offset: 0x8eb
// Size: 0x9a
function function_99b2a3a64f1e1ba9( distinches, speedmph, accelmph )
{
    distmiles = distinches * 1.57828e-05;
    a = 0.5 * accelmph;
    b = speedmph;
    c = -1 * distmiles;
    flytime = ( -1 * b + sqrt( b * b - 4 * a * c ) ) / 2 * a;
    flytime *= 3600;
    flytime += 1.5;
    return flytime;
}

// Namespace namespace_2fa0d8ac31fa2ddc
// Params 1
// Checksum 0xb2cb9e0d, Offset: 0x98e
// Size: 0x51
function function_c497b04b383216d4( var_f4feabcd5c9f80b8 )
{
    arrivetime = function_99b2a3a64f1e1ba9( 20000, 100, 125 );
    descendtime = function_99b2a3a64f1e1ba9( var_f4feabcd5c9f80b8, 25, 31.25 );
    totaltime = arrivetime + descendtime;
    return totaltime;
}

// Namespace namespace_2fa0d8ac31fa2ddc
// Params 1
// Checksum 0x199faf34, Offset: 0x9e8
// Size: 0xa4
function function_4f214598645f3850( extractlocation )
{
    self endon( #"death" );
    self endon( #"leaving" );
    groundz = self.extractgroundpos[ 2 ];
    var_f4feabcd5c9f80b8 = self.descendpos[ 2 ] - groundz;
    self.flytime = function_c497b04b383216d4( var_f4feabcd5c9f80b8 );
    thread function_2ee950b5418b81d6();
    self.preventleave = 1;
    function_883692f9eb3dc9c1();
    self.preventleave = undefined;
    
    if ( level.gameended )
    {
        thread function_383cd2155177d314();
        return;
    }
    
    thread function_383cd2155177d314();
}

// Namespace namespace_2fa0d8ac31fa2ddc
// Params 2
// Checksum 0x46e4daa5, Offset: 0xa94
// Size: 0xf7
function function_9ae9103e5ab370c6( var_9bfc3973acf74366, var_db18f8c567bc3349 )
{
    var_5dcd37deb66bc6d3 = 10;
    contents = trace::create_contents( 0, 1, 1, 1, 1, 0, 1, 1, 0 );
    var_18397e93d9334888 = 0;
    yaw = 0;
    
    while ( yaw < 360 )
    {
        var_18397e93d9334888 += yaw;
        testangles = ( 0, var_18397e93d9334888, 0 );
        approachstartpos = var_9bfc3973acf74366 - anglestoforward( testangles ) * 20000;
        approachendpos = var_db18f8c567bc3349;
        approachtrace = trace::sphere_trace( approachstartpos, approachendpos, 100, undefined, contents, 1 );
        
        if ( approachtrace[ "fraction" ] == 1 )
        {
            /#
                line( approachstartpos, approachendpos, ( 0, 1, 0 ), 1, 0, 2000 );
            #/
            
            return var_18397e93d9334888;
        }
        
        if ( yaw % 3 == 0 )
        {
            waitframe();
        }
        
        yaw += var_5dcd37deb66bc6d3;
    }
    
    return var_18397e93d9334888;
}

// Namespace namespace_2fa0d8ac31fa2ddc
// Params 0
// Checksum 0x3f86171a, Offset: 0xb94
// Size: 0x53
function function_5a7b7e9c4b1c5687()
{
    if ( isdefined( self.rope ) )
    {
        self.rope delete();
    }
    
    if ( isdefined( self.crate ) )
    {
        self.crate delete();
    }
    
    if ( isdefined( self.scenenode ) )
    {
        self.scenenode delete();
    }
}

// Namespace namespace_2fa0d8ac31fa2ddc
// Params 0
// Checksum 0xfac22a51, Offset: 0xbef
// Size: 0x11
function function_ec3d708ed5c09096()
{
    function_5a7b7e9c4b1c5687();
    vehicle_tracking::delete_vehicle( self );
}

// Namespace namespace_2fa0d8ac31fa2ddc
// Params 0
// Checksum 0x9efde3d0, Offset: 0xc08
// Size: 0x102
function function_383cd2155177d314()
{
    if ( self.tryingtoleave || self.leaving )
    {
        return;
    }
    
    self endon( #"death" );
    self notify( #"hash_8c8d8512d8835926" );
    self.tryingtoleave = 1;
    self waittill( #"hash_8182ff35fd9e24b8" );
    self notify( #"leaving" );
    self.leaving = 1;
    self.tryingtoleave = undefined;
    animtime_out = getanimlength( level.scr_anim[ self.animname ][ "heli_out" ] );
    self.scenenode thread animation::anim_single_solo( self, "heli_out" );
    thread animation::anim_single_solo( self.rope, "rope_out", "tag_winch" );
    thread animation::anim_single_solo( self.crate, "hook_out", "tag_winch" );
    hostmigration::waitlongdurationwithpause( animtime_out );
    self stoploopsound();
    self notify( #"heli_gone" );
    function_ec3d708ed5c09096();
}

// Namespace namespace_2fa0d8ac31fa2ddc
// Params 0
// Checksum 0x7d829c4f, Offset: 0xd12
// Size: 0x9f
function function_883692f9eb3dc9c1()
{
    self endon( #"death" );
    animtime_in = getanimlength( level.scr_anim[ self.animname ][ "heli_in" ] );
    self.scenenode thread animation::anim_single_solo( self, "heli_in" );
    thread animation::anim_single_solo( self.rope, "rope_in", "tag_winch" );
    thread animation::anim_single_solo( self.crate, "hook_in", "tag_winch" );
    hostmigration::waitlongdurationwithpause( animtime_in );
    thread function_d8381d940c0b0998();
    thread function_1968f17dfbd0a80();
    thread function_51559be5b9987adb();
}

// Namespace namespace_2fa0d8ac31fa2ddc
// Params 0
// Checksum 0x1f7a8c43, Offset: 0xdb9
// Size: 0xa1
function function_d8381d940c0b0998()
{
    self endon( #"death" );
    self.scenenode endon( #"death" );
    animtime = getanimlength( level.scr_anim[ self.animname ][ "heli_loop" ] );
    
    while ( true )
    {
        self.scenenode thread animation::anim_single_solo( self, "heli_loop" );
        self notify( #"loop_wait" );
        wait animtime;
        
        if ( self.readytoleave && !self.preventleave )
        {
            self notify( #"hash_8182ff35fd9e24b8" );
            break;
        }
    }
}

// Namespace namespace_2fa0d8ac31fa2ddc
// Params 0
// Checksum 0xcab3661c, Offset: 0xe62
// Size: 0x75
function function_1968f17dfbd0a80()
{
    self endon( #"death" );
    animtime = getanimlength( level.scr_anim[ self.rope.animname ][ "rope_loop" ] );
    
    while ( true )
    {
        thread animation::anim_single_solo( self.rope, "rope_loop", "tag_winch" );
        wait animtime;
        
        if ( self.readytoleave )
        {
            break;
        }
    }
}

// Namespace namespace_2fa0d8ac31fa2ddc
// Params 0
// Checksum 0x6a7845d0, Offset: 0xedf
// Size: 0x75
function function_51559be5b9987adb()
{
    self endon( #"death" );
    animtime = getanimlength( level.scr_anim[ self.crate.animname ][ "hook_loop" ] );
    
    while ( true )
    {
        thread animation::anim_single_solo( self.crate, "hook_loop", "tag_winch" );
        wait animtime;
        
        if ( self.readytoleave )
        {
            break;
        }
    }
}

// Namespace namespace_2fa0d8ac31fa2ddc
// Params 0
// Checksum 0xabb5707d, Offset: 0xf5c
// Size: 0x2e
function function_2ee950b5418b81d6()
{
    self endon( #"death" );
    self endon( #"hash_8c8d8512d8835926" );
    level waittill( #"game_ended" );
    thread function_383cd2155177d314();
}

