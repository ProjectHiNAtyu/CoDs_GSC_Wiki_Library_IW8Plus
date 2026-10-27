// script_5748b94ba1263a19  (hash_5748b94ba1263a19.gscc) (size: 695 Bytes / 0x2b7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9ece888c (2664335500)
// size ...... 695 (0x2b7)
// includes .. 3   (offset: 0x277)
// strings ... 3   (offset: 0x28f)
// dev strs .. 0   (offset: 0x2b7)
// exports ... 5   (offset: 0x107)
// cseg ...... 0x80 + 0x87 (0x107)
// imports ... 6   (offset: 0x1cf)
// animtree1 . 0   (offset: 0x2b7)
// animtree2 . 0   (offset: 0x2b7)
#using script_aa3bac81ad4fc8e;
#using scripts\common\powerups;
#using scripts\common\system;

#namespace namespace_f4118a7f2e7426d4;

// Namespace namespace_f4118a7f2e7426d4
// Params 0, eflags: 0x5
// Checksum 0x2d0c676, Offset: 0x9e
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "cache_back", #"bgb", &__init__, undefined );
}

// Namespace namespace_f4118a7f2e7426d4
// Params 0
// Checksum 0x4ab9efe4, Offset: 0xc3
// Size: 0x21
function __init__()
{
    bgb::register( "cache_back", "activated", 1, undefined, undefined, &validation, &activation );
}

// Namespace namespace_f4118a7f2e7426d4
// Params 0
// Checksum 0xa8c536ab, Offset: 0xec
// Size: 0xe
function activation()
{
    thread powerups::powerup_activate( "full_ammo" );
}

// Namespace namespace_f4118a7f2e7426d4
// Params 0
// Checksum 0x38d87dcd, Offset: 0x102
// Size: 0x4, Type: bool
function validation()
{
    return true;
}

