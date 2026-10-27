// script_3e201e31212eaecb  (hash_3e201e31212eaecb.gscc) (size: 943 Bytes / 0x3af / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x92ec80e3 (2464973027)
// size ...... 943 (0x3af)
// includes .. 3   (offset: 0x377)
// strings ... 2   (offset: 0x38f)
// dev strs .. 0   (offset: 0x3af)
// exports ... 7   (offset: 0x147)
// cseg ...... 0x6d + 0xda (0x147)
// imports ... 10  (offset: 0x25f)
// animtree1 . 0   (offset: 0x3af)
// animtree2 . 0   (offset: 0x3af)
#using script_aa3bac81ad4fc8e;
#using scripts\common\system;
#using scripts\mp\zm\systems\loot_drops;

#namespace zm_bgb_dead_drop;

// Namespace zm_bgb_dead_drop
// Params 0, eflags: 0x5
// Checksum 0x158a01df, Offset: 0x8b
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "dead_drop", #"bgb", &__init__, undefined );
}

// Namespace zm_bgb_dead_drop
// Params 0
// Checksum 0x7fbd62ee, Offset: 0xb0
// Size: 0x31
function __init__()
{
    bgb::register( "dead_drop", "time", 300, &enable, &disable, &validation );
    loot_drops::function_935f8b619d093b69( &check_dead_drop );
}

// Namespace zm_bgb_dead_drop
// Params 0
// Checksum 0xf17f03cc, Offset: 0xe9
// Size: 0x2
function enable()
{
    
}

// Namespace zm_bgb_dead_drop
// Params 0
// Checksum 0x4d9a86af, Offset: 0xf3
// Size: 0x2
function disable()
{
    
}

// Namespace zm_bgb_dead_drop
// Params 0
// Checksum 0x147390e7, Offset: 0xfd
// Size: 0x4, Type: bool
function validation()
{
    return true;
}

// Namespace zm_bgb_dead_drop
// Params 1
// Checksum 0xb4cde043, Offset: 0x10a
// Size: 0x3c, Type: bool
function check_dead_drop( params )
{
    if ( isplayer( params.eattacker ) && params.eattacker bgb::is_enabled( "dead_drop" ) )
    {
        return true;
    }
    
    return false;
}

