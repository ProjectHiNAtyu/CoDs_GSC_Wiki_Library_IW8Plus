// script_7899f876fd3b30c4  (hash_7899f876fd3b30c4.gscc) (size: 878 Bytes / 0x36e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x85a339fc (2242066940)
// size ...... 878 (0x36e)
// includes .. 2   (offset: 0x33a)
// strings ... 2   (offset: 0x34a)
// dev strs .. 0   (offset: 0x36e)
// exports ... 6   (offset: 0x16a)
// cseg ...... 0x72 + 0xf8 (0x16a)
// imports ... 8   (offset: 0x25a)
// animtree1 . 0   (offset: 0x36e)
// animtree2 . 0   (offset: 0x36e)
#using script_aa3bac81ad4fc8e;
#using scripts\common\system;

#namespace namespace_36b4be222002f421;

// Namespace namespace_36b4be222002f421
// Params 0, eflags: 0x5
// Checksum 0xf59ba5dc, Offset: 0x90
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "temporal_gift", #"bgb", &__init__, undefined );
}

// Namespace namespace_36b4be222002f421
// Params 0
// Checksum 0xe5bdb454, Offset: 0xb5
// Size: 0x2c
function __init__()
{
    bgb::register( "temporal_gift", "event", &event, undefined, &disable );
    level.powerup_timeout_override = &temporal_gift_check;
}

// Namespace namespace_36b4be222002f421
// Params 1, eflags: 0x4
// Checksum 0x13dce34, Offset: 0xe9
// Size: 0x2f
function private temporal_gift_check( wait_time )
{
    if ( bgb::is_enabled( "temporal_gift" ) )
    {
        wait_time += 30;
        self notify( #"hash_7bbf1a12d2ccc1ea" );
    }
    
    return wait_time;
}

// Namespace namespace_36b4be222002f421
// Params 0
// Checksum 0x9575f023, Offset: 0x121
// Size: 0x33
function event()
{
    self endon( #"disconnect" );
    self endon( #"kill_temporal_gift" );
    self waittill( #"hash_7bbf1a12d2ccc1ea" );
    bgb::function_b62ba460d1b3dac9( "temporal_gift" );
}

// Namespace namespace_36b4be222002f421
// Params 0
// Checksum 0x6ba5c243, Offset: 0x15c
// Size: 0xe
function disable()
{
    self notify( #"kill_temporal_gift" );
}

