// script_3b806732a6f5fa85  (hash_3b806732a6f5fa85.gscc) (size: 1537 Bytes / 0x601 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xebc96c61 (3955846241)
// size ...... 1537 (0x601)
// includes .. 4   (offset: 0x551)
// strings ... 12  (offset: 0x571)
// dev strs .. 0   (offset: 0x601)
// exports ... 5   (offset: 0x319)
// cseg ...... 0x145 + 0x1d4 (0x319)
// imports ... 13  (offset: 0x3e1)
// animtree1 . 0   (offset: 0x601)
// animtree2 . 0   (offset: 0x601)
#using script_76c2201325c4a523;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;

#namespace namespace_625b03302b7a113f;

// Namespace namespace_625b03302b7a113f
// Params 0, eflags: 0x5
// Checksum 0xe6b7a8a5, Offset: 0x163
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_532fa4e7bf71092c", undefined, undefined, &function_cbf3141dd279a30b );
}

// Namespace namespace_625b03302b7a113f
// Params 0, eflags: 0x4
// Checksum 0x39c229bf, Offset: 0x184
// Size: 0x17
function private function_cbf3141dd279a30b()
{
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    level thread function_e1fc422378aacf82();
}

// Namespace namespace_625b03302b7a113f
// Params 0
// Checksum 0x8e11b6b3, Offset: 0x1a3
// Size: 0xa
function function_e1fc422378aacf82()
{
    level thread ob_spawn_vehicles();
}

// Namespace namespace_625b03302b7a113f
// Params 0
// Checksum 0xdaec8c6e, Offset: 0x1b5
// Size: 0x164
function ob_spawn_vehicles()
{
    if ( !getdvarint( @"hash_53e8929882e78ac6", 1 ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_6dfc320987b819", 0 ) )
    {
        var_f09144086aa2c9e3 = [ "vehicle_group_a", "vehicle_group_b", "vehicle_group_c", "vehicle_group_d", "vehicle_group_e", "vehicle_group_f", "vehicle_group_g", "vehicle_group_h", "vehicle_group_i" ];
        var_c04fe6401200c960 = [];
        
        foreach ( var_e814baa69305ee8a in var_f09144086aa2c9e3 )
        {
            a_s_group = utility::getstructarray( var_e814baa69305ee8a, "script_noteworthy" );
            var_c04fe6401200c960 = arraycombine( var_c04fe6401200c960, namespace_bd84f01aeefe9bd9::function_9e9164d9466ec5be( a_s_group ) );
            waitframe();
        }
    }
    else
    {
        var_c04fe6401200c960 = namespace_bd84f01aeefe9bd9::function_afb3d1d504450ff2();
    }
    
    if ( var_c04fe6401200c960.size > 0 && isdefined( level.var_37ee95c5464d47be ) )
    {
        [[ level.var_37ee95c5464d47be ]]( "vehicle", var_c04fe6401200c960, &namespace_bd84f01aeefe9bd9::spawn_vehicle );
    }
    
    callback::callback( "ob_vehicles_create_script_done" );
}

