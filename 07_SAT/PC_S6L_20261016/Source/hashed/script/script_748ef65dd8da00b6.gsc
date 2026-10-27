// script_748ef65dd8da00b6  (hash_748ef65dd8da00b6.gscc) (size: 907 Bytes / 0x38b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa22bd45e (2720781406)
// size ...... 907 (0x38b)
// includes .. 3   (offset: 0x35b)
// strings ... 0   (offset: 0x373)
// dev strs .. 2   (offset: 0x373)
// exports ... 6   (offset: 0x163)
// cseg ...... 0x58 + 0x10b (0x163)
// imports ... 9   (offset: 0x253)
// animtree1 . 0   (offset: 0x38b)
// animtree2 . 0   (offset: 0x38b)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\relics\zm_relics;

#namespace namespace_6168ef0f8e83a9ca;

// Namespace namespace_6168ef0f8e83a9ca
// Params 0, eflags: 0x5
// Checksum 0xc9bb328, Offset: 0x76
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_5d68e7c85b6f79b", undefined, &function_527d76ce6b1cd85b, undefined );
}

// Namespace namespace_6168ef0f8e83a9ca
// Params 0
// Checksum 0x27388927, Offset: 0x97
// Size: 0xa
function function_527d76ce6b1cd85b()
{
    level thread function_a127f269f1b41e86();
}

// Namespace namespace_6168ef0f8e83a9ca
// Params 0
// Checksum 0x8903b3b8, Offset: 0xa9
// Size: 0x1c
function function_a127f269f1b41e86()
{
    zm_relics::register_relic_functions( #"hash_36bc7ab5ef9c8d9f", &function_e91ecbdb201440c, &function_63a6005aea292bf3 );
}

// Namespace namespace_6168ef0f8e83a9ca
// Params 0
// Checksum 0xc4ad1fb6, Offset: 0xcd
// Size: 0x47
function function_e91ecbdb201440c()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        level utility::callsharedfunc( #"zm_mode_modifiers", #"hash_70586852998134e2" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace namespace_6168ef0f8e83a9ca
// Params 0
// Checksum 0x22d34d59, Offset: 0x11c
// Size: 0x47
function function_63a6005aea292bf3()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        level utility::callsharedfunc( #"zm_mode_modifiers", #"hash_c3f6cb2e4d0c662" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x49>" );
    #/
}

