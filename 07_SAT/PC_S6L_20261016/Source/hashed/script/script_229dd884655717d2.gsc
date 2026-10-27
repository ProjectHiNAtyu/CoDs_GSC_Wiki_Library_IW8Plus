// script_229dd884655717d2  (hash_229dd884655717d2.gscc) (size: 1137 Bytes / 0x471 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x838dc573 (2207106419)
// size ...... 1137 (0x471)
// includes .. 4   (offset: 0x411)
// strings ... 3   (offset: 0x431)
// dev strs .. 2   (offset: 0x459)
// exports ... 7   (offset: 0x1a1)
// cseg ...... 0x93 + 0x10e (0x1a1)
// imports ... 12  (offset: 0x2b9)
// animtree1 . 0   (offset: 0x471)
// animtree2 . 0   (offset: 0x471)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\relics\zm_relic_challenges;

#namespace namespace_b38dc55d1a733de8;

// Namespace namespace_b38dc55d1a733de8
// Params 0, eflags: 0x5
// Checksum 0x52e60418, Offset: 0xb1
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_443dfbbb767fb017", undefined, &function_8211e95b3a5b81d7, undefined );
}

// Namespace namespace_b38dc55d1a733de8
// Params 0
// Checksum 0x8a8177df, Offset: 0xd2
// Size: 0xa
function function_8211e95b3a5b81d7()
{
    level thread function_cd9cf5699ea10c8c();
}

// Namespace namespace_b38dc55d1a733de8
// Params 0
// Checksum 0xa0aaa5c, Offset: 0xe4
// Size: 0x1c
function function_cd9cf5699ea10c8c()
{
    zm_relic_challenges::register_relic_challenge_functions( #"hash_861041d3386c8479", &function_56a495fe14a87daa, &function_20b8a11be4efc5e9 );
}

// Namespace namespace_b38dc55d1a733de8
// Params 0
// Checksum 0xffc9db77, Offset: 0x108
// Size: 0x24
function function_56a495fe14a87daa()
{
    level callback::add( "on_zombie_ai_spawned", &on_zombie_ai_spawned );
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace namespace_b38dc55d1a733de8
// Params 0
// Checksum 0xaf53ca4f, Offset: 0x134
// Size: 0x24
function function_20b8a11be4efc5e9()
{
    level callback::remove( "on_zombie_ai_spawned", &on_zombie_ai_spawned );
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x59>" );
    #/
}

// Namespace namespace_b38dc55d1a733de8
// Params 1, eflags: 0x4
// Checksum 0x593bafce, Offset: 0x160
// Size: 0x41
function private on_zombie_ai_spawned( params )
{
    wait 1;
    
    if ( self && isalive( self ) )
    {
        utility::callsharedfunc( #"zombie_utils", #"setmovespeed", "super_sprint", "relic_challenge", 9 );
    }
}

