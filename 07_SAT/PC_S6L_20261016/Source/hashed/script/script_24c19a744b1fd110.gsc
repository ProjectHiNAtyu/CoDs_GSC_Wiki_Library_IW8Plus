// script_24c19a744b1fd110  (hash_24c19a744b1fd110.gscc) (size: 472 Bytes / 0x1d8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6e9d421b (1855799835)
// size ...... 472 (0x1d8)
// includes .. 1   (offset: 0x1c4)
// strings ... 1   (offset: 0x1cc)
// dev strs .. 0   (offset: 0x1d8)
// exports ... 3   (offset: 0xf8)
// cseg ...... 0x75 + 0x83 (0xf8)
// imports ... 3   (offset: 0x170)
// animtree1 . 0   (offset: 0x1d8)
// animtree2 . 0   (offset: 0x1d8)
#using scripts\common\callbacks;

#namespace specialty_jump_ads_reduce;

// Namespace specialty_jump_ads_reduce
// Params 0, eflags: 0x5
// Checksum 0x220b33cb, Offset: 0x93
// Size: 0x2b
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_cfe9203c28947acd );
    setdvar( @"hash_f6c17e8b6d373bee", 1.3 );
}

// Namespace specialty_jump_ads_reduce
// Params 1, eflags: 0x4
// Checksum 0x44372e1d, Offset: 0xc6
// Size: 0x32
function private function_cfe9203c28947acd( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_jump_ads_reduce", undefined, undefined, [] );
    }
}

