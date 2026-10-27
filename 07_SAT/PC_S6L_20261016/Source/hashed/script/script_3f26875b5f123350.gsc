// script_3f26875b5f123350  (hash_3f26875b5f123350.gscc) (size: 676 Bytes / 0x2a4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbf5c4127 (3210494247)
// size ...... 676 (0x2a4)
// includes .. 1   (offset: 0x254)
// strings ... 6   (offset: 0x25c)
// dev strs .. 0   (offset: 0x2a4)
// exports ... 3   (offset: 0x1a4)
// cseg ...... 0x107 + 0x9d (0x1a4)
// imports ... 2   (offset: 0x21c)
// animtree1 . 0   (offset: 0x2a4)
// animtree2 . 0   (offset: 0x2a4)
#using scripts\common\callbacks;

#namespace specialty_tac_resist_br;

// Namespace specialty_tac_resist_br
// Params 0, eflags: 0x1
// Checksum 0x6e7793a6, Offset: 0x125
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_8c08613018dc29a8 );
}

// Namespace specialty_tac_resist_br
// Params 1
// Checksum 0xdb8ba4a3, Offset: 0x145
// Size: 0x5f
function function_8c08613018dc29a8( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_tac_resist_br", undefined, undefined, [ "specialty_stun_resistance", "specialty_gas_grenade_resist", "specialty_snapshot_immunity", "specialty_frangible_resist", "specialty_shock_resist" ] );
    }
}

