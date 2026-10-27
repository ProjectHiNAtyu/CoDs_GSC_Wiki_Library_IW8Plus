// scripts\mp\zm\systems\relics\zm_relic_mimics_infiltrate.gsc  (hash_4e8c875b9590c75d.gscc) (size: 984 Bytes / 0x3d8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x639aadbe (1671081406)
// size ...... 984 (0x3d8)
// includes .. 3   (offset: 0x3a8)
// strings ... 0   (offset: 0x3c0)
// dev strs .. 2   (offset: 0x3c0)
// exports ... 6   (offset: 0x1b4)
// cseg ...... 0x58 + 0x15c (0x1b4)
// imports ... 9   (offset: 0x2a4)
// animtree1 . 0   (offset: 0x3d8)
// animtree2 . 0   (offset: 0x3d8)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\relics\zm_relics;

#namespace zm_relic_mimics_infiltrate;

// Namespace zm_relic_mimics_infiltrate
// Params 0, eflags: 0x5
// Checksum 0x755310ab, Offset: 0x76
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_a4fa8f38ead22221", undefined, &init_relic_mimics_infiltrate, undefined );
}

// Namespace zm_relic_mimics_infiltrate
// Params 0
// Checksum 0xf78fa617, Offset: 0x97
// Size: 0xa
function init_relic_mimics_infiltrate()
{
    level thread function_295918373c3cca97();
}

// Namespace zm_relic_mimics_infiltrate
// Params 0
// Checksum 0xdd22a052, Offset: 0xa9
// Size: 0x1c
function function_295918373c3cca97()
{
    zm_relics::register_relic_functions( #"mimics_infiltrate", &function_bcdcd346fbeea183, &function_92a14b6416ca8dbe );
}

// Namespace zm_relic_mimics_infiltrate
// Params 0
// Checksum 0xf26a0b18, Offset: 0xcd
// Size: 0x9d
function function_bcdcd346fbeea183()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        var_7d4c78b7d42d3e = level.zm_relic_modifiers[ #"mimics_infiltrate" ].var_e459055b1abf306e;
        mimic_drop_list = level.zm_relic_modifiers[ #"mimics_infiltrate" ].var_fab5fba4572960f2;
        level utility::callsharedfunc( #"zm_mode_modifiers", #"hash_fbbb0712f33c62e6", var_7d4c78b7d42d3e, undefined, undefined, mimic_drop_list );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_relic_mimics_infiltrate
// Params 0
// Checksum 0xc9147e46, Offset: 0x172
// Size: 0x42
function function_92a14b6416ca8dbe()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        level.zm_mode_modifiers.var_17778bfafdc97691 = 0;
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x48>" );
    #/
}

