// script_6b0b112afccb0999  (hash_6b0b112afccb0999.gscc) (size: 707 Bytes / 0x2c3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa932481a (2838644762)
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

#namespace namespace_835d32782368eb84;

// Namespace namespace_835d32782368eb84
// Params 0, eflags: 0x5
// Checksum 0xc7567757, Offset: 0xaa
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "whos_keeping_score", #"bgb", &__init__, undefined );
}

// Namespace namespace_835d32782368eb84
// Params 0
// Checksum 0x6a453dd2, Offset: 0xcf
// Size: 0x21
function __init__()
{
    bgb::register( "whos_keeping_score", "activated", 1, undefined, undefined, &validation, &activation );
}

// Namespace namespace_835d32782368eb84
// Params 0
// Checksum 0x6f97dd67, Offset: 0xf8
// Size: 0xe
function activation()
{
    thread powerups::powerup_activate( "double_points" );
}

// Namespace namespace_835d32782368eb84
// Params 0
// Checksum 0x35c4b09d, Offset: 0x10e
// Size: 0x4, Type: bool
function validation()
{
    return true;
}

