// scripts\mp\zm\systems\relics\zm_relic_no_starting_loadout.gsc  (hash_3315b28854700ac5.gscc) (size: 981 Bytes / 0x3d5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6b88ad63 (1804119395)
// size ...... 981 (0x3d5)
// includes .. 3   (offset: 0x3a5)
// strings ... 0   (offset: 0x3bd)
// dev strs .. 2   (offset: 0x3bd)
// exports ... 6   (offset: 0x1b1)
// cseg ...... 0x58 + 0x159 (0x1b1)
// imports ... 9   (offset: 0x2a1)
// animtree1 . 0   (offset: 0x3d5)
// animtree2 . 0   (offset: 0x3d5)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\relics\zm_relics;

#namespace zm_relic_no_starting_loadout;

// Namespace zm_relic_no_starting_loadout
// Params 0, eflags: 0x5
// Checksum 0x168212a6, Offset: 0x76
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_64121ecb8aea8e29", undefined, &function_28755adf21a208f8, undefined );
}

// Namespace zm_relic_no_starting_loadout
// Params 0
// Checksum 0xbd0699e3, Offset: 0x97
// Size: 0xa
function function_28755adf21a208f8()
{
    level thread function_57bb7dfac2152f17();
}

// Namespace zm_relic_no_starting_loadout
// Params 0
// Checksum 0x96d756f0, Offset: 0xa9
// Size: 0x1c
function function_57bb7dfac2152f17()
{
    zm_relics::register_relic_functions( #"no_starting_loadout", &function_6fff1255221eb693, &function_6a904633d1db26ae );
}

// Namespace zm_relic_no_starting_loadout
// Params 0
// Checksum 0x45609384, Offset: 0xcd
// Size: 0x9a
function function_6fff1255221eb693()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        weapon = level.zm_relic_modifiers[ #"no_starting_loadout" ].var_6718e43890e2a86a;
        lethal = level.zm_relic_modifiers[ #"no_starting_loadout" ].var_ff3ee3776ce12904;
        level utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d6ffe8bb178fbd1f", weapon, lethal );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_relic_no_starting_loadout
// Params 0
// Checksum 0x627afb5a, Offset: 0x16f
// Size: 0x42
function function_6a904633d1db26ae()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        level.zm_mode_modifiers.var_a551bdc7e905a4fd = 0;
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x4a>" );
    #/
}

