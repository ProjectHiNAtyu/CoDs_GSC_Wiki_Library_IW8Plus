// script_535f9bfccadcae  (hash_00535f9bfccadcae.gscc) (size: 974 Bytes / 0x3ce / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb6d68554 (3067512148)
// size ...... 974 (0x3ce)
// includes .. 3   (offset: 0x39e)
// strings ... 0   (offset: 0x3b6)
// dev strs .. 2   (offset: 0x3b6)
// exports ... 6   (offset: 0x18e)
// cseg ...... 0x58 + 0x136 (0x18e)
// imports ... 10  (offset: 0x27e)
// animtree1 . 0   (offset: 0x3ce)
// animtree2 . 0   (offset: 0x3ce)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\relics\zm_relics;

#namespace namespace_110017181faa407a;

// Namespace namespace_110017181faa407a
// Params 0, eflags: 0x5
// Checksum 0xb80f32ff, Offset: 0x76
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_eeb05de90358f743", undefined, &function_cdfc7621ada84003, undefined );
}

// Namespace namespace_110017181faa407a
// Params 0
// Checksum 0x2614d5b2, Offset: 0x97
// Size: 0xa
function function_cdfc7621ada84003()
{
    level thread function_d3bf86b8ebc2f4be();
}

// Namespace namespace_110017181faa407a
// Params 0
// Checksum 0x5bf7a486, Offset: 0xa9
// Size: 0x1c
function function_d3bf86b8ebc2f4be()
{
    zm_relics::register_relic_functions( #"hash_c0b55876ba2d886f", &function_45deb2ec439e98cc, &function_c80623d8dd485db3 );
}

// Namespace namespace_110017181faa407a
// Params 0
// Checksum 0x32462a58, Offset: 0xcd
// Size: 0x72
function function_45deb2ec439e98cc()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        perk_limit = level.zm_relic_modifiers[ #"hash_c0b55876ba2d886f" ].var_f180062fd8380015;
        level utility::callsharedfunc( #"zm_mode_modifiers", #"hash_7dfc9bdac73805a2", perk_limit );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace namespace_110017181faa407a
// Params 0
// Checksum 0x2a7dae91, Offset: 0x147
// Size: 0x47
function function_c80623d8dd485db3()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        level utility::callsharedfunc( #"zm_mode_modifiers", #"hash_cf734eacedf02322" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x49>" );
    #/
}

