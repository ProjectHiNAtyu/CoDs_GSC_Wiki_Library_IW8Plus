// script_4cb9e2d1627cbe74  (hash_4cb9e2d1627cbe74.gscc) (size: 881 Bytes / 0x371 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4db108fb (1303447803)
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

#namespace namespace_aac3f01b28d67012;

// Namespace namespace_aac3f01b28d67012
// Params 0, eflags: 0x5
// Checksum 0x3a0a5264, Offset: 0x76
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_a124d7cc68d8a188", undefined, &function_63c481970894f39, undefined );
}

// Namespace namespace_aac3f01b28d67012
// Params 0
// Checksum 0xc356938c, Offset: 0x97
// Size: 0xa
function function_63c481970894f39()
{
    level thread function_c83867ae4483cc2e();
}

// Namespace namespace_aac3f01b28d67012
// Params 0
// Checksum 0x637ab320, Offset: 0xa9
// Size: 0x1c
function function_c83867ae4483cc2e()
{
    zm_relics::register_relic_functions( #"no_bleedout_bar", &function_d9329f905a16db48, &function_763c1e8ff402a81f );
}

// Namespace namespace_aac3f01b28d67012
// Params 0
// Checksum 0x443c9aa3, Offset: 0xcd
// Size: 0x46
function function_d9329f905a16db48()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"hash_e632fde24edc95ba" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace namespace_aac3f01b28d67012
// Params 0
// Checksum 0x82c878ca, Offset: 0x11b
// Size: 0x46
function function_763c1e8ff402a81f()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"hash_27b0c2185066ee3a" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x46>" );
    #/
}

