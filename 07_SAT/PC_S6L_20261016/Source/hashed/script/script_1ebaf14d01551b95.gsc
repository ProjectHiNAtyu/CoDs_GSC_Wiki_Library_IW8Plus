// script_1ebaf14d01551b95  (hash_1ebaf14d01551b95.gscc) (size: 620 Bytes / 0x26c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4bf4cdcb (1274334667)
// size ...... 620 (0x26c)
// includes .. 2   (offset: 0x240)
// strings ... 2   (offset: 0x250)
// dev strs .. 0   (offset: 0x26c)
// exports ... 5   (offset: 0xec)
// cseg ...... 0x71 + 0x7b (0xec)
// imports ... 5   (offset: 0x1b4)
// animtree1 . 0   (offset: 0x26c)
// animtree2 . 0   (offset: 0x26c)
#using script_aa3bac81ad4fc8e;
#using scripts\common\system;

#namespace zm_bgb_mr_peeks;

// Namespace zm_bgb_mr_peeks
// Params 0, eflags: 0x5
// Checksum 0x4b8d0231, Offset: 0x8f
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "mr_peeks", #"bgb", &__init__, undefined );
}

// Namespace zm_bgb_mr_peeks
// Params 0
// Checksum 0x2140181c, Offset: 0xb4
// Size: 0x21
function __init__()
{
    bgb::register( "mr_peeks", "activated", 1, undefined, undefined, &validation, &function_817d950dda3d14a );
}

// Namespace zm_bgb_mr_peeks
// Params 0
// Checksum 0xd57ed829, Offset: 0xdd
// Size: 0x4, Type: bool
function validation()
{
    return true;
}

// Namespace zm_bgb_mr_peeks
// Params 0
// Checksum 0xdfbae347, Offset: 0xea
// Size: 0x2
function function_817d950dda3d14a()
{
    
}

