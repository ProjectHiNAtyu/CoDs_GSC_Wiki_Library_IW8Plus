// scripts\mp\zm\systems\relics\zm_relic_no_mystery_box.gsc  (hash_59692ee3110197a7.gscc) (size: 951 Bytes / 0x3b7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x75076ca7 (1963420839)
// size ...... 951 (0x3b7)
// includes .. 3   (offset: 0x37b)
// strings ... 1   (offset: 0x393)
// dev strs .. 2   (offset: 0x39f)
// exports ... 6   (offset: 0x17f)
// cseg ...... 0x6a + 0x115 (0x17f)
// imports ... 9   (offset: 0x26f)
// animtree1 . 0   (offset: 0x3b7)
// animtree2 . 0   (offset: 0x3b7)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\relics\zm_relics;

#namespace zm_relic_no_mystery_box;

// Namespace zm_relic_no_mystery_box
// Params 0, eflags: 0x5
// Checksum 0xd97f3a, Offset: 0x88
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_5f837b494e3337c1", undefined, &init_relic_no_mystery_box, undefined );
}

// Namespace zm_relic_no_mystery_box
// Params 0
// Checksum 0x9ba0f87, Offset: 0xa9
// Size: 0xa
function init_relic_no_mystery_box()
{
    level thread function_6097646bc57598b3();
}

// Namespace zm_relic_no_mystery_box
// Params 0
// Checksum 0x9fd1d25, Offset: 0xbb
// Size: 0x1c
function function_6097646bc57598b3()
{
    zm_relics::register_relic_functions( #"no_mystery_box", &function_f6da026b8f39a833, &function_77a50f37906292ce );
}

// Namespace zm_relic_no_mystery_box
// Params 0
// Checksum 0xa63c6441, Offset: 0xdf
// Size: 0x52
function function_f6da026b8f39a833()
{
    utility::flag_wait( "magicbox_ready" );
    
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"set_no_mystery_box" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_relic_no_mystery_box
// Params 0
// Checksum 0x3bc54713, Offset: 0x139
// Size: 0x46
function function_77a50f37906292ce()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"disable_no_mystery_box" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x47>" );
    #/
}

