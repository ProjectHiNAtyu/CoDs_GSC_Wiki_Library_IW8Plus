// scripts\mp\common\perks\agility.gsc  (hash_10ca030284f826a1.gscc) (size: 453 Bytes / 0x1c5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5ea0a1ce (1587585486)
// size ...... 453 (0x1c5)
// includes .. 1   (offset: 0x1ad)
// strings ... 1   (offset: 0x1b5)
// dev strs .. 0   (offset: 0x1c5)
// exports ... 3   (offset: 0xfd)
// cseg ...... 0x6d + 0x90 (0xfd)
// imports ... 2   (offset: 0x175)
// animtree1 . 0   (offset: 0x1c5)
// animtree2 . 0   (offset: 0x1c5)
#using scripts\common\callbacks;

#namespace agility;

// Namespace agility
// Params 0, eflags: 0x1
// Checksum 0x190c1f75, Offset: 0x8b
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_a9cc26118dbe6ea );
}

// Namespace agility
// Params 1
// Checksum 0xf28a38a, Offset: 0xab
// Size: 0x52
function function_a9cc26118dbe6ea( params )
{
    bundle = level.perkbundles[ "specialty_agility" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_agility" );
    }
}

