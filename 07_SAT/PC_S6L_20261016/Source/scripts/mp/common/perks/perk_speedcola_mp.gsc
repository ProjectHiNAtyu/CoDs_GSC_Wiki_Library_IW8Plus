// scripts\mp\common\perks\perk_speedcola_mp.gsc  (hash_746cf59688816845.gscc) (size: 648 Bytes / 0x288 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x560fc526 (1443874086)
// size ...... 648 (0x288)
// includes .. 1   (offset: 0x240)
// strings ... 5   (offset: 0x248)
// dev strs .. 0   (offset: 0x288)
// exports ... 3   (offset: 0x190)
// cseg ...... 0xd9 + 0xb7 (0x190)
// imports ... 2   (offset: 0x208)
// animtree1 . 0   (offset: 0x288)
// animtree2 . 0   (offset: 0x288)
#using scripts\common\callbacks;

#namespace perk_speedcola_mp;

// Namespace perk_speedcola_mp
// Params 0, eflags: 0x1
// Checksum 0x87f96070, Offset: 0xf7
// Size: 0x18
function autoexec main()
{
    level callback::add( #"register_perk", &perk_register );
}

// Namespace perk_speedcola_mp
// Params 1
// Checksum 0xa0f255c8, Offset: 0x117
// Size: 0x79
function perk_register( params )
{
    bundle = level.perkbundles[ "specialty_speedcola" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_speedcola", undefined, undefined, [ "specialty_fastreload", "specialty_faster_field_upgrade", "specialty_quickswap", "specialty_fastoffhand" ] );
    }
}

