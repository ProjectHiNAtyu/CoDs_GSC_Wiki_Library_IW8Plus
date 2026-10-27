// script_1f76cef8733c7a3f  (hash_1f76cef8733c7a3f.gscc) (size: 881 Bytes / 0x371 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa299bce3 (2727984355)
// size ...... 881 (0x371)
// includes .. 3   (offset: 0x341)
// strings ... 0   (offset: 0x359)
// dev strs .. 2   (offset: 0x359)
// exports ... 6   (offset: 0x161)
// cseg ...... 0x58 + 0x109 (0x161)
// imports ... 8   (offset: 0x251)
// animtree1 . 0   (offset: 0x371)
// animtree2 . 0   (offset: 0x371)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\relics\zm_relics;

#namespace namespace_aa797d4c6942d15f;

// Namespace namespace_aa797d4c6942d15f
// Params 0, eflags: 0x5
// Checksum 0xea54938f, Offset: 0x76
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_e75323ca84b8afa9", undefined, &function_ea84f00d35f69eea, undefined );
}

// Namespace namespace_aa797d4c6942d15f
// Params 0
// Checksum 0x503c79d2, Offset: 0x97
// Size: 0xa
function function_ea84f00d35f69eea()
{
    level thread function_a9464337978690c3();
}

// Namespace namespace_aa797d4c6942d15f
// Params 0
// Checksum 0xae0a8325, Offset: 0xa9
// Size: 0x1c
function function_a9464337978690c3()
{
    zm_relics::register_relic_functions( #"hash_6358f8a3135ad6e6", &function_9de70041e463e143, &function_a24164fb5888ab7e );
}

// Namespace namespace_aa797d4c6942d15f
// Params 0
// Checksum 0x91f654d4, Offset: 0xcd
// Size: 0x46
function function_9de70041e463e143()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"hash_74e12d08ec24b807" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace namespace_aa797d4c6942d15f
// Params 0
// Checksum 0x7d429e2a, Offset: 0x11b
// Size: 0x46
function function_a24164fb5888ab7e()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"hash_10c8316937744987" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x56>" );
    #/
}

