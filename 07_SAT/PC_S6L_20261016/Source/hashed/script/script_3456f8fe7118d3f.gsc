// script_3456f8fe7118d3f  (hash_03456f8fe7118d3f.gscc) (size: 559 Bytes / 0x22f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5612b5a2 (1444066722)
// size ...... 559 (0x22f)
// includes .. 2   (offset: 0x20f)
// strings ... 1   (offset: 0x21f)
// dev strs .. 0   (offset: 0x22f)
// exports ... 4   (offset: 0xff)
// cseg ...... 0x77 + 0x88 (0xff)
// imports ... 4   (offset: 0x19f)
// animtree1 . 0   (offset: 0x22f)
// animtree2 . 0   (offset: 0x22f)
#using scripts\common\callbacks;
#using scripts\mp\common\perks\perks;

#namespace specialty_snapshot_immunity;

// Namespace specialty_snapshot_immunity
// Params 0, eflags: 0x1
// Checksum 0xbc51b287, Offset: 0x95
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_snapshot_immunity
// Params 1
// Checksum 0xf3d89a4d, Offset: 0xb5
// Size: 0x34
function registerspecialty( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_snapshot_immunity", &setspecialty );
    }
}

// Namespace specialty_snapshot_immunity
// Params 0
// Checksum 0x3360a08a, Offset: 0xf1
// Size: 0xe
function setspecialty()
{
    perks::function_70e4256c5fb41ada( "specialty_snapshot_immunity" );
}

