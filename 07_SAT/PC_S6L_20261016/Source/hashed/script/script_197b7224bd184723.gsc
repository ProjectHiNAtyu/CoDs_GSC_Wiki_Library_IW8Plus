// script_197b7224bd184723  (hash_197b7224bd184723.gscc) (size: 437 Bytes / 0x1b5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x93d888aa (2480441514)
// size ...... 437 (0x1b5)
// includes .. 1   (offset: 0x1a1)
// strings ... 1   (offset: 0x1a9)
// dev strs .. 0   (offset: 0x1b5)
// exports ... 3   (offset: 0xf1)
// cseg ...... 0x81 + 0x70 (0xf1)
// imports ... 2   (offset: 0x169)
// animtree1 . 0   (offset: 0x1b5)
// animtree2 . 0   (offset: 0x1b5)
#using scripts\common\callbacks;

#namespace specialty_reduce_regen_delay_on_plate;

// Namespace specialty_reduce_regen_delay_on_plate
// Params 0, eflags: 0x1
// Checksum 0xb01649c9, Offset: 0x9f
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_cb0d1a7e76480297 );
}

// Namespace specialty_reduce_regen_delay_on_plate
// Params 1
// Checksum 0x2261c676, Offset: 0xbf
// Size: 0x32
function function_cb0d1a7e76480297( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_reduce_regen_delay_on_plate", undefined, undefined, [] );
    }
}

