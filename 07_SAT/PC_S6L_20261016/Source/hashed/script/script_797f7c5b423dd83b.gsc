// script_797f7c5b423dd83b  (hash_797f7c5b423dd83b.gscc) (size: 881 Bytes / 0x371 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa8b9bb0e (2830744334)
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

#namespace namespace_cd11ac6b11092c64;

// Namespace namespace_cd11ac6b11092c64
// Params 0, eflags: 0x5
// Checksum 0x1d418e17, Offset: 0x76
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_491876eb20559a1a", undefined, &function_bec1ffb3c0a1ca47, undefined );
}

// Namespace namespace_cd11ac6b11092c64
// Params 0
// Checksum 0x4fd0c9c8, Offset: 0x97
// Size: 0xa
function function_bec1ffb3c0a1ca47()
{
    level thread function_d1b25e93d7f7ee20();
}

// Namespace namespace_cd11ac6b11092c64
// Params 0
// Checksum 0x79e8fbf9, Offset: 0xa9
// Size: 0x1c
function function_d1b25e93d7f7ee20()
{
    zm_relics::register_relic_functions( #"hash_6338753196da732b", &function_9d41b22bb38f58ee, &function_c9e4f7b97bde67ed );
}

// Namespace namespace_cd11ac6b11092c64
// Params 0
// Checksum 0x88c02a87, Offset: 0xcd
// Size: 0x46
function function_9d41b22bb38f58ee()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"hash_545ec0b85eae52fc" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace namespace_cd11ac6b11092c64
// Params 0
// Checksum 0xd1557462, Offset: 0x11b
// Size: 0x46
function function_c9e4f7b97bde67ed()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"hash_8d7cb05856e28f7c" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x50>" );
    #/
}

