// script_588275f9c13c5b34  (hash_588275f9c13c5b34.gscc) (size: 694 Bytes / 0x2b6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe6af4d83 (3870248323)
// size ...... 694 (0x2b6)
// includes .. 3   (offset: 0x276)
// strings ... 3   (offset: 0x28e)
// dev strs .. 0   (offset: 0x2b6)
// exports ... 5   (offset: 0x106)
// cseg ...... 0x7f + 0x87 (0x106)
// imports ... 6   (offset: 0x1ce)
// animtree1 . 0   (offset: 0x2b6)
// animtree2 . 0   (offset: 0x2b6)
#using script_aa3bac81ad4fc8e;
#using scripts\common\powerups;
#using scripts\common\system;

#namespace namespace_5097da01430f1fd1;

// Namespace namespace_5097da01430f1fd1
// Params 0, eflags: 0x5
// Checksum 0xcb509ed0, Offset: 0x9d
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "kill_joy", #"bgb", &__init__, undefined );
}

// Namespace namespace_5097da01430f1fd1
// Params 0
// Checksum 0x35a6392c, Offset: 0xc2
// Size: 0x21
function __init__()
{
    bgb::register( "kill_joy", "activated", 1, undefined, undefined, &validation, &activation );
}

// Namespace namespace_5097da01430f1fd1
// Params 0
// Checksum 0x90711e67, Offset: 0xeb
// Size: 0xe
function activation()
{
    thread powerups::powerup_activate( "insta_kill" );
}

// Namespace namespace_5097da01430f1fd1
// Params 0
// Checksum 0x55a344c8, Offset: 0x101
// Size: 0x4, Type: bool
function validation()
{
    return true;
}

