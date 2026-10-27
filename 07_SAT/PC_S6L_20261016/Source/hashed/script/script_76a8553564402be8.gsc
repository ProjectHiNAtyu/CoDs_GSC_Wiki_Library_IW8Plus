// script_76a8553564402be8  (hash_76a8553564402be8.gscc) (size: 881 Bytes / 0x371 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbd126f94 (3172102036)
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

#namespace namespace_3ee1eb085938b652;

// Namespace namespace_3ee1eb085938b652
// Params 0, eflags: 0x5
// Checksum 0xbe06c0ec, Offset: 0x76
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_64884af7e71f197d", undefined, &function_66ac28c1191b023d, undefined );
}

// Namespace namespace_3ee1eb085938b652
// Params 0
// Checksum 0xf6571885, Offset: 0x97
// Size: 0xa
function function_66ac28c1191b023d()
{
    level thread function_fdc5a4ece36a9246();
}

// Namespace namespace_3ee1eb085938b652
// Params 0
// Checksum 0xfaf6cd01, Offset: 0xa9
// Size: 0x1c
function function_fdc5a4ece36a9246()
{
    zm_relics::register_relic_functions( #"hash_45b90ec96daab099", &function_44bfff863f2b7ebc, &function_913f661ae6c48483 );
}

// Namespace namespace_3ee1eb085938b652
// Params 0
// Checksum 0x9bed6c42, Offset: 0xcd
// Size: 0x46
function function_44bfff863f2b7ebc()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d63c9c5b24a5004a" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace namespace_3ee1eb085938b652
// Params 0
// Checksum 0xf7cbf40a, Offset: 0x11b
// Size: 0x46
function function_913f661ae6c48483()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"hash_f24df7e0f48f68ca" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x4e>" );
    #/
}

