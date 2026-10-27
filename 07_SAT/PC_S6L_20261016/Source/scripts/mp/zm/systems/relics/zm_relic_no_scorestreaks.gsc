// scripts\mp\zm\systems\relics\zm_relic_no_scorestreaks.gsc  (hash_5a1d92ee75c17fbb.gscc) (size: 881 Bytes / 0x371 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x834e71e2 (2202956258)
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

#namespace zm_relic_no_scorestreaks;

// Namespace zm_relic_no_scorestreaks
// Params 0, eflags: 0x5
// Checksum 0x8256582c, Offset: 0x76
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_e382295ea75b053f", undefined, &function_8db6c9a06146f826, undefined );
}

// Namespace zm_relic_no_scorestreaks
// Params 0
// Checksum 0x57bf79f6, Offset: 0x97
// Size: 0xa
function function_8db6c9a06146f826()
{
    level thread function_983a7b4684c40659();
}

// Namespace zm_relic_no_scorestreaks
// Params 0
// Checksum 0x7c18f7e5, Offset: 0xa9
// Size: 0x1c
function function_983a7b4684c40659()
{
    zm_relics::register_relic_functions( #"hash_4f7c03ce0b91409f", &function_ee4c51da3480ca74, &function_1e5f42c9edb0593b );
}

// Namespace zm_relic_no_scorestreaks
// Params 0
// Checksum 0x3cb36bac, Offset: 0xcd
// Size: 0x46
function function_ee4c51da3480ca74()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"hash_2ec63fc4ecf657ea" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_relic_no_scorestreaks
// Params 0
// Checksum 0xdc5b3248, Offset: 0x11b
// Size: 0x46
function function_1e5f42c9edb0593b()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"hash_1d327898b0ab96a" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x46>" );
    #/
}

