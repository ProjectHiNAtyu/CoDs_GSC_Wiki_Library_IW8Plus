// script_f9eb4439f9997da  (hash_0f9eb4439f9997da.gscc) (size: 418 Bytes / 0x1a2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3e5bf548 (1046213960)
// size ...... 418 (0x1a2)
// includes .. 1   (offset: 0x18e)
// strings ... 1   (offset: 0x196)
// dev strs .. 0   (offset: 0x1a2)
// exports ... 3   (offset: 0xde)
// cseg ...... 0x6e + 0x70 (0xde)
// imports ... 2   (offset: 0x156)
// animtree1 . 0   (offset: 0x1a2)
// animtree2 . 0   (offset: 0x1a2)
#using scripts\common\callbacks;

#namespace specialty_uav_buff;

// Namespace specialty_uav_buff
// Params 0, eflags: 0x1
// Checksum 0xf966af9a, Offset: 0x8c
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerperk );
}

// Namespace specialty_uav_buff
// Params 1
// Checksum 0xb8a87d6f, Offset: 0xac
// Size: 0x32
function registerperk( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_uav_buff", undefined, undefined, [] );
    }
}

