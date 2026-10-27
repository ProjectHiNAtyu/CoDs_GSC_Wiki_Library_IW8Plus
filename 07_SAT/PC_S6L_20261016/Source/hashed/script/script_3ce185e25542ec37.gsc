// script_3ce185e25542ec37  (hash_3ce185e25542ec37.gscc) (size: 426 Bytes / 0x1aa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf9b35a1 (261830049)
// size ...... 426 (0x1aa)
// includes .. 1   (offset: 0x196)
// strings ... 1   (offset: 0x19e)
// dev strs .. 0   (offset: 0x1aa)
// exports ... 3   (offset: 0xe6)
// cseg ...... 0x79 + 0x6d (0xe6)
// imports ... 2   (offset: 0x15e)
// animtree1 . 0   (offset: 0x1aa)
// animtree2 . 0   (offset: 0x1aa)
#using scripts\common\callbacks;

#namespace specialty_scavenger_equipment;

// Namespace specialty_scavenger_equipment
// Params 0, eflags: 0x1
// Checksum 0x82934dd0, Offset: 0x97
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_scavenger_equipment
// Params 1
// Checksum 0xe19eb294, Offset: 0xb7
// Size: 0x2f
function registerspecialty( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_scavenger_equipment" );
    }
}

