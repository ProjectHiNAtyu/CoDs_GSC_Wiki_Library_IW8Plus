// script_65d213c1ef6ac784  (hash_65d213c1ef6ac784.gscc) (size: 7016 Bytes / 0x1b68 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfe1463d7 (4262749143)
// size ...... 7016 (0x1b68)
// includes .. 7   (offset: 0x18e4)
// strings ... 22  (offset: 0x191c)
// dev strs .. 0   (offset: 0x1acc)
// exports ... 17  (offset: 0x1044)
// cseg ...... 0x2f3 + 0xd51 (0x1044)
// imports ... 50  (offset: 0x12ec)
// animtree1 . 1   (offset: 0x1acc)
// animtree2 . 9   (offset: 0x1ad8)
#using scripts\common\anim;
#using scripts\common\trace;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_tracking;
#using scripts\mp\hostmigration;

#namespace namespace_ae33899132c54ba6;

#using_animtree( "mp_vehicles_always_loaded" );

// Namespace namespace_ae33899132c54ba6
// Params 0
// Checksum 0xf6d4fc7b, Offset: 0x311
// Size: 0x66
function function_4357964a6b7684ca()
{
    level.scr_anim[ "cargo_delivery_extract" ][ "heli_in" ] = %iw9_dmz_cargo_heli_in;
    level.scr_anim[ "cargo_delivery_extract" ][ "heli_loop" ] = %iw9_dmz_cargo_heli_loop;
    level.scr_anim[ "cargo_delivery_extract" ][ "heli_out" ] = %iw9_dmz_cargo_heli_out;
    function_743c08bfe288c40d();
}

#using_animtree( "script_model" );

// Namespace namespace_ae33899132c54ba6
// Params 0
// Checksum 0x2d93ab74, Offset: 0x37f
// Size: 0xce
function function_743c08bfe288c40d()
{
    level.scr_animtree[ "cargo_delivery_extract_props" ] = #animtree;
    level.scr_anim[ "cargo_delivery_extract_props" ][ "rope_in" ] = %iw9_dmz_cargo_heli_rope_in;
    level.scr_anim[ "cargo_delivery_extract_props" ][ "rope_loop" ] = %iw9_dmz_cargo_heli_rope_loop;
    level.scr_anim[ "cargo_delivery_extract_props" ][ "rope_out" ] = %iw9_dmz_cargo_heli_rope_out;
    level.scr_anim[ "cargo_delivery_extract_props" ][ "hook_in" ] = %iw9_dmz_cargo_heli_hook_in;
    level.scr_anim[ "cargo_delivery_extract_props" ][ "hook_loop" ] = %iw9_dmz_cargo_heli_hook_loop;
    level.scr_anim[ "cargo_delivery_extract_props" ][ "hook_out" ] = %iw9_dmz_cargo_heli_hook_out;
}

// Namespace namespace_ae33899132c54ba6
// Params 4
// Checksum 0xb1375759, Offset: 0x455
// Size: 0x3f0
function function_bd1f657f7943610d( extractorigin, offset, var_21a5382dc1befa63, helioverride )
{
    extractgroundpos = getgroundposition( extractorigin, 1 ) + offset;
    var_9370b5c935fd8b21 = extractgroundpos + ( 0, 0, 4000 );
    spawnposoffset = extractgroundpos + ( 0, 0, 8000 );
    var_ce1eb256270347b7 = extractgroundpos + ( 0, 0, 850 );
    flightyaw = 0;
    flightangles = ( 0, 0, 0 );
    flightyaw = function_3ddbf73678266282( spawnposoffset, var_9370b5c935fd8b21 );
    flightangles = ( 0, flightyaw, 0 );
    enterposition = spawnposoffset - anglestoforward( flightangles ) * 20000;
    const_num_flares = 1;
    flightangle = vectortoangles( var_9370b5c935fd8b21 * ( 1, 1, 0 ) - enterposition * ( 1, 1, 0 ) );
    spawndata = spawnstruct();
    spawndata.origin = enterposition;
    spawndata.angles = flightangle;
    spawndata.var_499a16b493ff31ed = 1;
    spawndata.triggerrecycle = 1;
    
    if ( var_21a5382dc1befa63 )
    {
        heli = vehicle::spawn( %"hash_24c5305775780381", spawndata );
    }
    else if ( helioverride )
    {
        heli = vehicle::spawn( helioverride, spawndata );
    }
    else
    {
        heli = vehicle::spawn( %"hash_5b1746f66e66db96", spawndata );
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
    heli setmaxpitchroll( 10, 25 );
    heli vehicle_setspeed( heli.speed, heli.accel );
    heli sethoverparams( 1, 1, 1 );
    heli setturningability( 0.05 );
    heli setyawspeed( 45, 25, 25, 0.5 );
    
    if ( isent( self ) )
    {
        if ( isdefined( self.team ) )
        {
            heli.team = self.team;
        }
        
        heli.owner = self;
        heli setotherent( self );
    }
    
    heli setscriptablepartstate( "engine", "on" );
    heli setscriptablepartstate( "running_lights", "on" );
    heli setscriptablepartstate( "infil_lights", "on" );
    heli.scenenode = spawn( "script_model", extractorigin + ( 0, 0, -15 ) + offset );
    heli.scenenode.angles = heli.sceneangles;
    heli.scenenode setmodel( "tag_origin" );
    heli.scenenode animation::anim_first_frame_solo( heli, "heli_in" );
    level.var_e0e9fa51e8c5e493 = heli;
    function_a3286eef242512a7( heli );
    heli thread function_62998d0dd896dcf4( extractorigin + offset );
    return heli;
}

// Namespace namespace_ae33899132c54ba6
// Params 1, eflags: 0x4
// Checksum 0x86aa02c5, Offset: 0x84e
// Size: 0x148
function private function_a3286eef242512a7( heli )
{
    rope = spawn( "script_model", ( 0, 0, 0 ) );
    rope setmodel( "misc_rapelling_rope_01_fiber_br" );
    rope linkto( heli, "origin_animate_jnt", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    rope notsolid();
    rope show();
    rope.animname = "cargo_delivery_extract_props";
    rope animation::setanimtree();
    heli animation::anim_first_frame_solo( rope, "rope_in", "origin_animate_jnt" );
    crate = spawn( "script_model", ( 0, 0, 0 ) );
    crate setmodel( "construction_lattice_boom_crane_01_hook" );
    crate linkto( heli, "origin_animate_jnt", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    crate notsolid();
    crate show();
    crate.animname = "cargo_delivery_extract_props";
    crate animation::setanimtree();
    heli animation::anim_first_frame_solo( crate, "hook_in", "origin_animate_jnt" );
    heli.rope = rope;
    heli.crate = crate;
}

// Namespace namespace_ae33899132c54ba6
// Params 3
// Checksum 0x4713c4df, Offset: 0x99e
// Size: 0x9a
function function_7cc61d66e0d9f135( distinches, speedmph, accelmph )
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

// Namespace namespace_ae33899132c54ba6
// Params 1
// Checksum 0xdf40d681, Offset: 0xa41
// Size: 0x51
function function_7f4a60d2c75f6d08( var_f4feabcd5c9f80b8 )
{
    arrivetime = function_7cc61d66e0d9f135( 20000, 100, 125 );
    descendtime = function_7cc61d66e0d9f135( var_f4feabcd5c9f80b8, 25, 31.25 );
    totaltime = arrivetime + descendtime;
    return totaltime;
}

// Namespace namespace_ae33899132c54ba6
// Params 1
// Checksum 0xbf0d7399, Offset: 0xa9b
// Size: 0xb4
function function_62998d0dd896dcf4( extractlocation )
{
    self endon( #"death" );
    self endon( #"leaving" );
    groundz = self.extractgroundpos[ 2 ];
    var_f4feabcd5c9f80b8 = self.descendpos[ 2 ] - groundz;
    self.flytime = function_7f4a60d2c75f6d08( var_f4feabcd5c9f80b8 );
    thread function_76f9d54dd010640a();
    self.preventleave = 1;
    function_69e5f0b507d2fced();
    self.preventleave = undefined;
    self setscriptablepartstate( "vector_field", "on" );
    
    if ( level.gameended )
    {
        thread function_9a06804d2ae23ba8();
        return;
    }
    
    thread function_9a06804d2ae23ba8();
}

// Namespace namespace_ae33899132c54ba6
// Params 2
// Checksum 0xd4f57235, Offset: 0xb57
// Size: 0xfa
function function_3ddbf73678266282( var_9bfc3973acf74366, var_db18f8c567bc3349 )
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
        
        /#
        #/
        
        if ( yaw % 3 == 0 )
        {
            waitframe();
        }
        
        yaw += var_5dcd37deb66bc6d3;
    }
    
    return var_18397e93d9334888;
}

// Namespace namespace_ae33899132c54ba6
// Params 0
// Checksum 0xfc20f25a, Offset: 0xc5a
// Size: 0x53
function function_1fb13d71a8abd0cb()
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

// Namespace namespace_ae33899132c54ba6
// Params 0
// Checksum 0x689f18f8, Offset: 0xcb5
// Size: 0x11
function function_d9fd628144369ac2()
{
    function_1fb13d71a8abd0cb();
    vehicle_tracking::delete_vehicle( self );
}

// Namespace namespace_ae33899132c54ba6
// Params 0
// Checksum 0x10af1ca8, Offset: 0xcce
// Size: 0x102
function function_9a06804d2ae23ba8()
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
    thread animation::anim_single_solo( self.rope, "rope_out", "origin_animate_jnt" );
    thread animation::anim_single_solo( self.crate, "hook_out", "origin_animate_jnt" );
    hostmigration::waitlongdurationwithpause( animtime_out );
    self stoploopsound();
    self notify( #"heli_gone" );
    function_d9fd628144369ac2();
}

// Namespace namespace_ae33899132c54ba6
// Params 0
// Checksum 0x64d64934, Offset: 0xdd8
// Size: 0x9f
function function_69e5f0b507d2fced()
{
    self endon( #"death" );
    animtime_in = getanimlength( level.scr_anim[ self.animname ][ "heli_in" ] );
    self.scenenode thread animation::anim_single_solo( self, "heli_in" );
    thread animation::anim_single_solo( self.rope, "rope_in", "origin_animate_jnt" );
    thread animation::anim_single_solo( self.crate, "hook_in", "origin_animate_jnt" );
    hostmigration::waitlongdurationwithpause( animtime_in );
    thread function_a89a214c2d020c14();
    thread function_12dce9fed6e219ec();
    thread function_33699291aa8d5e7();
}

// Namespace namespace_ae33899132c54ba6
// Params 0
// Checksum 0xa6e3011e, Offset: 0xe7f
// Size: 0x95
function function_a89a214c2d020c14()
{
    self endon( #"death" );
    self.scenenode endon( #"death" );
    animtime = getanimlength( level.scr_anim[ self.animname ][ "heli_loop" ] );
    
    while ( true )
    {
        self.scenenode thread animation::anim_single_solo( self, "heli_loop" );
        wait animtime;
        
        if ( self.readytoleave && !self.preventleave )
        {
            self notify( #"hash_8182ff35fd9e24b8" );
            break;
        }
    }
}

// Namespace namespace_ae33899132c54ba6
// Params 0
// Checksum 0x9c27993a, Offset: 0xf1c
// Size: 0x75
function function_12dce9fed6e219ec()
{
    self endon( #"death" );
    animtime = getanimlength( level.scr_anim[ self.rope.animname ][ "rope_loop" ] );
    
    while ( true )
    {
        thread animation::anim_single_solo( self.rope, "rope_loop", "origin_animate_jnt" );
        wait animtime;
        
        if ( self.readytoleave )
        {
            break;
        }
    }
}

// Namespace namespace_ae33899132c54ba6
// Params 0
// Checksum 0x3cecbaf6, Offset: 0xf99
// Size: 0x75
function function_33699291aa8d5e7()
{
    self endon( #"death" );
    animtime = getanimlength( level.scr_anim[ self.crate.animname ][ "hook_loop" ] );
    
    while ( true )
    {
        thread animation::anim_single_solo( self.crate, "hook_loop", "origin_animate_jnt" );
        wait animtime;
        
        if ( self.readytoleave )
        {
            break;
        }
    }
}

// Namespace namespace_ae33899132c54ba6
// Params 0
// Checksum 0x7a68e476, Offset: 0x1016
// Size: 0x2e
function function_76f9d54dd010640a()
{
    self endon( #"death" );
    self endon( #"hash_8c8d8512d8835926" );
    level waittill( #"game_ended" );
    thread function_9a06804d2ae23ba8();
}

