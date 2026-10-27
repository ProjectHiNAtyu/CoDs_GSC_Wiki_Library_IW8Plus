// script_7a8e4154f98e35b3  (hash_7a8e4154f98e35b3.gscc) (size: 429 Bytes / 0x1ad / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x734ad5dd (1934284253)
// size ...... 429 (0x1ad)
// includes .. 1   (offset: 0x199)
// strings ... 1   (offset: 0x1a1)
// dev strs .. 0   (offset: 0x1ad)
// exports ... 3   (offset: 0xe9)
// cseg ...... 0x79 + 0x70 (0xe9)
// imports ... 2   (offset: 0x161)
// animtree1 . 0   (offset: 0x1ad)
// animtree2 . 0   (offset: 0x1ad)
#using scripts\common\callbacks;

#namespace specialty_faster_reload_speed;

// Namespace specialty_faster_reload_speed
// Params 0, eflags: 0x5
// Checksum 0x9e4fda13, Offset: 0x97
// Size: 0x18
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_1565e096e6d3c0e );
}

// Namespace specialty_faster_reload_speed
// Params 1, eflags: 0x4
// Checksum 0x164d35f1, Offset: 0xb7
// Size: 0x32
function private function_1565e096e6d3c0e( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_faster_reload_speed", undefined, undefined, [] );
    }
}

