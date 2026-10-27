// script_419666d0bbaf62a4  (hash_419666d0bbaf62a4.gscc) (size: 881 Bytes / 0x371 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2db68f16 (766938902)
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

#namespace namespace_ce678cba674f5118;

// Namespace namespace_ce678cba674f5118
// Params 0, eflags: 0x5
// Checksum 0x6177446f, Offset: 0x76
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_734fb1760196f80e", undefined, &function_8c142224989fec9, undefined );
}

// Namespace namespace_ce678cba674f5118
// Params 0
// Checksum 0xa0abb9be, Offset: 0x97
// Size: 0xa
function function_8c142224989fec9()
{
    level thread function_856f194b5e6e467c();
}

// Namespace namespace_ce678cba674f5118
// Params 0
// Checksum 0xb032ea87, Offset: 0xa9
// Size: 0x1c
function function_856f194b5e6e467c()
{
    zm_relics::register_relic_functions( #"hash_811ac96901a51875", &function_62c2f801586ced5a, &function_bbdcd365591e6639 );
}

// Namespace namespace_ce678cba674f5118
// Params 0
// Checksum 0x5491a72, Offset: 0xcd
// Size: 0x46
function function_62c2f801586ced5a()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"hash_a681a2a6dfb281f0" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace namespace_ce678cba674f5118
// Params 0
// Checksum 0x3a4dd4d1, Offset: 0x11b
// Size: 0x46
function function_bbdcd365591e6639()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"hash_4268a7072b021370" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x56>" );
    #/
}

