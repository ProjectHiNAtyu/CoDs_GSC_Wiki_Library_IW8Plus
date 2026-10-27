// script_26164e6aa1721061  (hash_26164e6aa1721061.gscc) (size: 463 Bytes / 0x1cf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfbcb7a95 (4224416405)
// size ...... 463 (0x1cf)
// includes .. 1   (offset: 0x1b7)
// strings ... 1   (offset: 0x1bf)
// dev strs .. 0   (offset: 0x1cf)
// exports ... 3   (offset: 0x107)
// cseg ...... 0x74 + 0x93 (0x107)
// imports ... 2   (offset: 0x17f)
// animtree1 . 0   (offset: 0x1cf)
// animtree2 . 0   (offset: 0x1cf)
#using scripts\common\callbacks;

#namespace specialty_combat_tracker;

// Namespace specialty_combat_tracker
// Params 0, eflags: 0x1
// Checksum 0x272aa149, Offset: 0x92
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_95966cb7d34c3b1d );
}

// Namespace specialty_combat_tracker
// Params 1
// Checksum 0x276ebc56, Offset: 0xb2
// Size: 0x55
function function_95966cb7d34c3b1d( params )
{
    bundle = level.perkbundles[ "specialty_combat_tracker" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_combat_tracker", undefined, undefined, [] );
    }
}

