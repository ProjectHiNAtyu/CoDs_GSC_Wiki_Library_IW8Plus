// script_4162eac729a614d1  (hash_4162eac729a614d1.gscc) (size: 428 Bytes / 0x1ac / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8557efe8 (2237132776)
// size ...... 428 (0x1ac)
// includes .. 1   (offset: 0x198)
// strings ... 1   (offset: 0x1a0)
// dev strs .. 0   (offset: 0x1ac)
// exports ... 3   (offset: 0xe8)
// cseg ...... 0x78 + 0x70 (0xe8)
// imports ... 2   (offset: 0x160)
// animtree1 . 0   (offset: 0x1ac)
// animtree2 . 0   (offset: 0x1ac)
#using scripts\common\callbacks;

#namespace specialty_adaptive_ads_speed;

// Namespace specialty_adaptive_ads_speed
// Params 0, eflags: 0x5
// Checksum 0xe812e986, Offset: 0x96
// Size: 0x18
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_75836d9c57d82380 );
}

// Namespace specialty_adaptive_ads_speed
// Params 1, eflags: 0x4
// Checksum 0x470c57f3, Offset: 0xb6
// Size: 0x32
function private function_75836d9c57d82380( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_adaptive_ads_speed", undefined, undefined, [] );
    }
}

