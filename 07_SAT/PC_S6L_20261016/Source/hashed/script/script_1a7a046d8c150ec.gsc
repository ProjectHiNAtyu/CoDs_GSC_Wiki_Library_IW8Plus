// script_1a7a046d8c150ec  (hash_01a7a046d8c150ec.gscc) (size: 2005 Bytes / 0x7d5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x645d132 (105238834)
// size ...... 2005 (0x7d5)
// includes .. 5   (offset: 0x789)
// strings ... 3   (offset: 0x7b1)
// dev strs .. 0   (offset: 0x7d5)
// exports ... 7   (offset: 0x415)
// cseg ...... 0x92 + 0x383 (0x415)
// imports ... 21  (offset: 0x52d)
// animtree1 . 0   (offset: 0x7d5)
// animtree2 . 0   (offset: 0x7d5)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_hazard;

#namespace namespace_301c1c47ac7cc7e6;

// Namespace namespace_301c1c47ac7cc7e6
// Params 0, eflags: 0x5
// Checksum 0x7ea6aa31, Offset: 0xb0
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_8e84f63d42f235dd", #"ztron_hazards", undefined, &init );
}

// Namespace namespace_301c1c47ac7cc7e6
// Params 0
// Checksum 0x8650dd28, Offset: 0xd9
// Size: 0x3e
function init()
{
    ztron_hazard::function_6f661fac5fd31f1( #"lava_pool", #"create", &function_ce8c749c8a5098a );
    ztron_hazard::function_6f661fac5fd31f1( #"lava_pool", #"arenaspawn", &function_c7236459bbcac7eb );
}

// Namespace namespace_301c1c47ac7cc7e6
// Params 0
// Checksum 0xf9c80cee, Offset: 0x11f
// Size: 0x9c
function function_c7236459bbcac7eb()
{
    hazards = level.ztron.active_arena ztron_arena::function_eb3bad474c41ae42( "lava_pool" );
    
    foreach ( var_4d080f710fb8349e in hazards )
    {
        function_ce8c749c8a5098a( var_4d080f710fb8349e );
    }
}

// Namespace namespace_301c1c47ac7cc7e6
// Params 2
// Checksum 0xdce6893, Offset: 0x1c3
// Size: 0xbf
function function_ce8c749c8a5098a( trap, paged )
{
    if ( !isdefined( trap.radius ) )
    {
        trap.radius = 30;
    }
    
    if ( !isdefined( trap.pitch ) )
    {
        trap.pitch = 45;
    }
    
    if ( !isdefined( trap.var_de3b8203c9fca52c ) )
    {
        trap.var_de3b8203c9fca52c = 10;
    }
    
    if ( !isdefined( trap.weapon ) )
    {
        trap.weapon = makeweapon( "sat_la_ztron_lava_pool" );
    }
    
    /#
        trap.debug = getdvarint( @"hash_e0d1acd921d5fdb5", 0 ) >= 1;
    #/
    
    trap thread ztron_hazard::function_4d643b159a80c647( 0 );
    trap thread function_751be4312e0d507f();
}

// Namespace namespace_301c1c47ac7cc7e6
// Params 0
// Checksum 0x8110ff2e, Offset: 0x28a
// Size: 0x57
function function_751be4312e0d507f()
{
    self endon( #"destroy_hazard" );
    minwait = 5;
    maxwait = 10;
    
    while ( true )
    {
        thread lava_pool_burst();
        interval = randomfloatrange( minwait, maxwait );
        level utility::waittill_notify_or_timeout( "lava_pool_burst", interval );
    }
}

// Namespace namespace_301c1c47ac7cc7e6
// Params 0
// Checksum 0x3395d550, Offset: 0x2e9
// Size: 0x12c
function lava_pool_burst()
{
    level endon( #"lava_pool_burst" );
    self endon( #"destroy_hazard" );
    radius = self.radius;
    pitch = self.pitch;
    origin = self.origin;
    weapon = self.weapon;
    var_de3b8203c9fca52c = self.var_de3b8203c9fca52c;
    
    while ( var_de3b8203c9fca52c > 0 )
    {
        burstvector = vectornormalize( anglestoforward( ( pitch * -1 + randomfloatrange( -5, 5 ), randomfloatrange( 0, 360 ), 0 ) ) );
        burstorigin = origin + vectornormalize2( burstvector ) * randomfloatrange( 0, radius );
        
        /#
            if ( self.debug )
            {
                level thread ztron_debug::drawline( burstorigin, burstorigin + burstvector * radius, 5, ( 1, 0, 0 ) );
                level thread ztron_debug::drawsphere( burstorigin, 10, 5, ( 1, 1, 0 ) );
            }
        #/
        
        magicbullet( weapon, burstorigin, burstorigin + burstvector * 1000 );
        var_de3b8203c9fca52c--;
        wait 0.1;
    }
}

