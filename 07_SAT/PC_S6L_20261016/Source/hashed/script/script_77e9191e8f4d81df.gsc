// script_77e9191e8f4d81df  (hash_77e9191e8f4d81df.gscc) (size: 747 Bytes / 0x2eb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3e1cb3b5 (1042068405)
// size ...... 747 (0x2eb)
// includes .. 2   (offset: 0x297)
// strings ... 5   (offset: 0x2a7)
// dev strs .. 0   (offset: 0x2eb)
// exports ... 5   (offset: 0x123)
// cseg ...... 0x8e + 0x95 (0x123)
// imports ... 6   (offset: 0x1eb)
// animtree1 . 0   (offset: 0x2eb)
// animtree2 . 0   (offset: 0x2eb)
#using script_aa3bac81ad4fc8e;
#using scripts\common\system;

#namespace zm_bgb_die_pitched;

// Namespace zm_bgb_die_pitched
// Params 0, eflags: 0x5
// Checksum 0xf2cc940, Offset: 0xac
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "die_pitched", #"bgb", &__init__, undefined );
}

// Namespace zm_bgb_die_pitched
// Params 0
// Checksum 0xceb047b1, Offset: 0xd1
// Size: 0x20
function __init__()
{
    bgb::register( "die_pitched", "time", 180, &enable, &disable, undefined );
}

// Namespace zm_bgb_die_pitched
// Params 0
// Checksum 0x3bd7612e, Offset: 0xf9
// Size: 0x11
function enable()
{
    setglobalsoundcontext( "zm_pitched_vocals", "on" );
}

// Namespace zm_bgb_die_pitched
// Params 0
// Checksum 0x8e84cd85, Offset: 0x112
// Size: 0x11
function disable()
{
    setglobalsoundcontext( "zm_pitched_vocals", "" );
}

