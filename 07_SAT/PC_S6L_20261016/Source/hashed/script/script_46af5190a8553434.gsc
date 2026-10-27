// script_46af5190a8553434  (hash_46af5190a8553434.gscc) (size: 706 Bytes / 0x2c2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe99540ba (3918872762)
// size ...... 706 (0x2c2)
// includes .. 3   (offset: 0x286)
// strings ... 2   (offset: 0x29e)
// dev strs .. 0   (offset: 0x2c2)
// exports ... 5   (offset: 0x112)
// cseg ...... 0x70 + 0xa2 (0x112)
// imports ... 6   (offset: 0x1da)
// animtree1 . 0   (offset: 0x2c2)
// animtree2 . 0   (offset: 0x2c2)
#using script_aa3bac81ad4fc8e;
#using scripts\common\system;
#using scripts\common\utility;

#namespace namespace_ef0945168554d2a1;

// Namespace namespace_ef0945168554d2a1
// Params 0, eflags: 0x5
// Checksum 0x166f281c, Offset: 0x8e
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "power_vacuum", #"bgb", &__init__, undefined );
}

// Namespace namespace_ef0945168554d2a1
// Params 0
// Checksum 0x145e522a, Offset: 0xb3
// Size: 0x21
function __init__()
{
    bgb::register( "power_vacuum", "time", 300, &enable, &disable, undefined );
}

// Namespace namespace_ef0945168554d2a1
// Params 0
// Checksum 0x4db7c455, Offset: 0xdc
// Size: 0x17
function enable()
{
    utility::callsharedfunc( "power_vacuum", #"enable" );
}

// Namespace namespace_ef0945168554d2a1
// Params 0
// Checksum 0x7a1d7e1b, Offset: 0xfb
// Size: 0x17
function disable()
{
    utility::callsharedfunc( "power_vacuum", #"disable" );
}

