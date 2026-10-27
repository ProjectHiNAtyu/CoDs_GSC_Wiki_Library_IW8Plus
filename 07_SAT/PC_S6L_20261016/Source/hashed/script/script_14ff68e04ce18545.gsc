// script_14ff68e04ce18545  (hash_14ff68e04ce18545.gscc) (size: 671 Bytes / 0x29f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7ab53ff3 (2058698739)
// size ...... 671 (0x29f)
// includes .. 1   (offset: 0x24f)
// strings ... 6   (offset: 0x257)
// dev strs .. 0   (offset: 0x29f)
// exports ... 3   (offset: 0x19f)
// cseg ...... 0x102 + 0x9d (0x19f)
// imports ... 2   (offset: 0x217)
// animtree1 . 0   (offset: 0x29f)
// animtree2 . 0   (offset: 0x29f)
#using scripts\common\callbacks;

#namespace specialty_tac_resist;

// Namespace specialty_tac_resist
// Params 0, eflags: 0x1
// Checksum 0xe1a4c70a, Offset: 0x120
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_8c08613018dc29a8 );
}

// Namespace specialty_tac_resist
// Params 1
// Checksum 0xea08a433, Offset: 0x140
// Size: 0x5f
function function_8c08613018dc29a8( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_tac_resist", undefined, undefined, [ "specialty_stun_resistance", "specialty_emp_resist", "specialty_gas_grenade_resist", "specialty_scrambler_resist", "specialty_snapshot_immunity" ] );
    }
}

