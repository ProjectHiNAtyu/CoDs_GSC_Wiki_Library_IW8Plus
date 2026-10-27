// scripts\mp\common\perks\perk_death_perception_mp.gsc  (hash_0452527e0e870697.gscc) (size: 509 Bytes / 0x1fd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc4de736d (3302912877)
// size ...... 509 (0x1fd)
// includes .. 1   (offset: 0x1d9)
// strings ... 2   (offset: 0x1e1)
// dev strs .. 0   (offset: 0x1fd)
// exports ... 3   (offset: 0x129)
// cseg ...... 0x8d + 0x9c (0x129)
// imports ... 2   (offset: 0x1a1)
// animtree1 . 0   (offset: 0x1fd)
// animtree2 . 0   (offset: 0x1fd)
#using scripts\common\callbacks;

#namespace perk_death_perception_mp;

// Namespace perk_death_perception_mp
// Params 0, eflags: 0x1
// Checksum 0x162244c9, Offset: 0xab
// Size: 0x18
function autoexec main()
{
    level callback::add( #"register_perk", &perk_register );
}

// Namespace perk_death_perception_mp
// Params 1
// Checksum 0xfd902bbe, Offset: 0xcb
// Size: 0x5e
function perk_register( params )
{
    bundle = level.perkbundles[ "specialty_death_perception" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_death_perception", undefined, undefined, [ "specialty_operative" ] );
    }
}

