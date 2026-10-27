// script_481754271e72231c  (hash_481754271e72231c.gscc) (size: 707 Bytes / 0x2c3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x758d2847 (1972185159)
// size ...... 707 (0x2c3)
// includes .. 3   (offset: 0x283)
// strings ... 3   (offset: 0x29b)
// dev strs .. 0   (offset: 0x2c3)
// exports ... 5   (offset: 0x113)
// cseg ...... 0x8c + 0x87 (0x113)
// imports ... 6   (offset: 0x1db)
// animtree1 . 0   (offset: 0x2c3)
// animtree2 . 0   (offset: 0x2c3)
#using script_aa3bac81ad4fc8e;
#using scripts\common\powerups;
#using scripts\common\system;

#namespace namespace_e8566cbb070d6299;

// Namespace namespace_e8566cbb070d6299
// Params 0, eflags: 0x5
// Checksum 0x3477ae80, Offset: 0xaa
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "immolation_liquidation", #"bgb", &__init__, undefined );
}

// Namespace namespace_e8566cbb070d6299
// Params 0
// Checksum 0x61c2e7ef, Offset: 0xcf
// Size: 0x21
function __init__()
{
    bgb::register( "immolation_liquidation", "activated", 1, undefined, undefined, &validation, &activation );
}

// Namespace namespace_e8566cbb070d6299
// Params 0
// Checksum 0xb0825ef6, Offset: 0xf8
// Size: 0xe
function activation()
{
    thread powerups::powerup_activate( "fire_sale" );
}

// Namespace namespace_e8566cbb070d6299
// Params 0
// Checksum 0x11a13980, Offset: 0x10e
// Size: 0x4, Type: bool
function validation()
{
    return true;
}

