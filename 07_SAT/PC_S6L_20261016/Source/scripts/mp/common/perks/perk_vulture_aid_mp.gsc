// scripts\mp\common\perks\perk_vulture_aid_mp.gsc  (hash_19e52b43990cf47b.gscc) (size: 523 Bytes / 0x20b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe87f1be9 (3900644329)
// size ...... 523 (0x20b)
// includes .. 1   (offset: 0x1e7)
// strings ... 2   (offset: 0x1ef)
// dev strs .. 0   (offset: 0x20b)
// exports ... 3   (offset: 0x137)
// cseg ...... 0x9b + 0x9c (0x137)
// imports ... 2   (offset: 0x1af)
// animtree1 . 0   (offset: 0x20b)
// animtree2 . 0   (offset: 0x20b)
#using scripts\common\callbacks;

#namespace perk_vulture_aid_mp;

// Namespace perk_vulture_aid_mp
// Params 0, eflags: 0x1
// Checksum 0xfa06e69a, Offset: 0xb9
// Size: 0x18
function autoexec main()
{
    level callback::add( #"register_perk", &perk_register );
}

// Namespace perk_vulture_aid_mp
// Params 1
// Checksum 0xe84b4a36, Offset: 0xd9
// Size: 0x5e
function perk_register( params )
{
    bundle = level.perkbundles[ "specialty_vulture_aid" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_vulture_aid", undefined, undefined, [ "specialty_scavenger_ammo_and_equipment" ] );
    }
}

