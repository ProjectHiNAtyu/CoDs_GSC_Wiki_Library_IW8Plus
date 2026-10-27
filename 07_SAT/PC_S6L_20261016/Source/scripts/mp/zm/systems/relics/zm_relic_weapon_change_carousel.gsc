// scripts\mp\zm\systems\relics\zm_relic_weapon_change_carousel.gsc  (hash_499832b1626f7e28.gscc) (size: 907 Bytes / 0x38b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x49f1d583 (1240585603)
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

#namespace zm_relic_weapon_change_carousel;

// Namespace zm_relic_weapon_change_carousel
// Params 0, eflags: 0x5
// Checksum 0x7a2fe4fa, Offset: 0x76
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_relic_weapon_change_carousel", undefined, &init_relic_weapon_change_carousel, undefined );
}

// Namespace zm_relic_weapon_change_carousel
// Params 0
// Checksum 0xc1d303af, Offset: 0x97
// Size: 0xa
function init_relic_weapon_change_carousel()
{
    level thread function_cc8a747dedacd444();
}

// Namespace zm_relic_weapon_change_carousel
// Params 0
// Checksum 0x4d3cc65d, Offset: 0xa9
// Size: 0x1c
function function_cc8a747dedacd444()
{
    zm_relics::register_relic_functions( #"weapon_change_carousel", &function_8f93a21101be801e, &function_dd4b609a44cbe53d );
}

// Namespace zm_relic_weapon_change_carousel
// Params 0
// Checksum 0xeb9a8a55, Offset: 0xcd
// Size: 0x47
function function_8f93a21101be801e()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        level utility::callsharedfunc( #"zm_mode_modifiers", #"set_weapon_change_carousel" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_relic_weapon_change_carousel
// Params 0
// Checksum 0xe924fcbf, Offset: 0x11c
// Size: 0x47
function function_dd4b609a44cbe53d()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        level utility::callsharedfunc( #"zm_mode_modifiers", #"disable_weapon_change_carousel" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x4c>" );
    #/
}

