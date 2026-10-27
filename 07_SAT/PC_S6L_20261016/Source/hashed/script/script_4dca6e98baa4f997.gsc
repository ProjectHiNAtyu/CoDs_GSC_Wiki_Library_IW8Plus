// script_4dca6e98baa4f997  (hash_4dca6e98baa4f997.gscc) (size: 881 Bytes / 0x371 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf828b7df (4163418079)
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

#namespace namespace_15205e305e6bd729;

// Namespace namespace_15205e305e6bd729
// Params 0, eflags: 0x5
// Checksum 0x7f43d61e, Offset: 0x76
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_eec81d495648c42b", undefined, &function_fbe00c66335cf112, undefined );
}

// Namespace namespace_15205e305e6bd729
// Params 0
// Checksum 0x2d643467, Offset: 0x97
// Size: 0xa
function function_fbe00c66335cf112()
{
    level thread function_a81d86d4b689834d();
}

// Namespace namespace_15205e305e6bd729
// Params 0
// Checksum 0xaea42236, Offset: 0xa9
// Size: 0x1c
function function_a81d86d4b689834d()
{
    zm_relics::register_relic_functions( #"hash_3385fa4802fa103e", &function_b17cd266c7c37a29, &function_7ae6297455c30ecc );
}

// Namespace namespace_15205e305e6bd729
// Params 0
// Checksum 0xb2f0728c, Offset: 0xcd
// Size: 0x46
function function_b17cd266c7c37a29()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"hash_8ecfa4a159b4a6b1" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace namespace_15205e305e6bd729
// Params 0
// Checksum 0xe4b62a69, Offset: 0x11b
// Size: 0x46
function function_7ae6297455c30ecc()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"hash_b39effb9248ec731" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x51>" );
    #/
}

