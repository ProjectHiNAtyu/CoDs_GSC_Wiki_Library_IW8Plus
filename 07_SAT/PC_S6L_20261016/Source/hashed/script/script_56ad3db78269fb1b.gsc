// script_56ad3db78269fb1b  (hash_56ad3db78269fb1b.gscc) (size: 697 Bytes / 0x2b9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xccb0afa3 (3434131363)
// size ...... 697 (0x2b9)
// includes .. 3   (offset: 0x279)
// strings ... 3   (offset: 0x291)
// dev strs .. 0   (offset: 0x2b9)
// exports ... 5   (offset: 0x109)
// cseg ...... 0x82 + 0x87 (0x109)
// imports ... 6   (offset: 0x1d1)
// animtree1 . 0   (offset: 0x2b9)
// animtree2 . 0   (offset: 0x2b9)
#using script_aa3bac81ad4fc8e;
#using scripts\common\powerups;
#using scripts\common\system;

#namespace namespace_14011a495dbcb9ce;

// Namespace namespace_14011a495dbcb9ce
// Params 0, eflags: 0x5
// Checksum 0xce874373, Offset: 0xa0
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "on_the_house", #"bgb", &__init__, undefined );
}

// Namespace namespace_14011a495dbcb9ce
// Params 0
// Checksum 0xa3b024c4, Offset: 0xc5
// Size: 0x21
function __init__()
{
    bgb::register( "on_the_house", "activated", 1, undefined, undefined, &validation, &activation );
}

// Namespace namespace_14011a495dbcb9ce
// Params 0
// Checksum 0x4fde1f76, Offset: 0xee
// Size: 0xe
function activation()
{
    thread powerups::powerup_activate( "free_perk" );
}

// Namespace namespace_14011a495dbcb9ce
// Params 0
// Checksum 0x4b10e2d7, Offset: 0x104
// Size: 0x4, Type: bool
function validation()
{
    return true;
}

