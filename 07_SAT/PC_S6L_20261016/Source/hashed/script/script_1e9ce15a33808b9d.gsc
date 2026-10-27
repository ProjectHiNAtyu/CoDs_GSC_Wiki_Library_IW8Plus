// script_1e9ce15a33808b9d  (hash_1e9ce15a33808b9d.gscc) (size: 800 Bytes / 0x320 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x54e5b1a3 (1424339363)
// size ...... 800 (0x320)
// includes .. 3   (offset: 0x2dc)
// strings ... 2   (offset: 0x2f4)
// dev strs .. 0   (offset: 0x320)
// exports ... 5   (offset: 0x148)
// cseg ...... 0x76 + 0xd2 (0x148)
// imports ... 7   (offset: 0x210)
// animtree1 . 0   (offset: 0x320)
// animtree2 . 0   (offset: 0x320)
#using script_aa3bac81ad4fc8e;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_bgb_exit_strategy;

// Namespace zm_bgb_exit_strategy
// Params 0, eflags: 0x5
// Checksum 0xc6981535, Offset: 0x94
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "exit_strategy", #"bgb", &__init__, undefined );
}

// Namespace zm_bgb_exit_strategy
// Params 0
// Checksum 0x9b19f3a1, Offset: 0xb9
// Size: 0x21
function __init__()
{
    bgb::register( "exit_strategy", "activated", 1, undefined, undefined, &validation, &function_817d950dda3d14a );
}

// Namespace zm_bgb_exit_strategy
// Params 0
// Checksum 0xb64e85b8, Offset: 0xe2
// Size: 0x2f
function validation()
{
    if ( utility::issharedfuncdefined( "exit_strategy", #"hash_c2ad3b622a5c3d9a" ) )
    {
        return utility::callsharedfunc( "exit_strategy", #"hash_c2ad3b622a5c3d9a" );
    }
    
    return 0;
}

// Namespace zm_bgb_exit_strategy
// Params 0
// Checksum 0xbc8abeec, Offset: 0x11a
// Size: 0x2e
function function_817d950dda3d14a()
{
    if ( utility::issharedfuncdefined( "exit_strategy", #"activation" ) )
    {
        utility::callsharedfunc( "exit_strategy", #"activation" );
    }
}

