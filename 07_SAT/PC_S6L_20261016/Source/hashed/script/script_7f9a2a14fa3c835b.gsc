// script_7f9a2a14fa3c835b  (hash_7f9a2a14fa3c835b.gscc) (size: 977 Bytes / 0x3d1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x18722e44 (410136132)
// size ...... 977 (0x3d1)
// includes .. 5   (offset: 0x39d)
// strings ... 1   (offset: 0x3c5)
// dev strs .. 0   (offset: 0x3d1)
// exports ... 7   (offset: 0x165)
// cseg ...... 0x65 + 0x100 (0x165)
// imports ... 10  (offset: 0x27d)
// animtree1 . 0   (offset: 0x3d1)
// animtree2 . 0   (offset: 0x3d1)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\zm\gametypes\zm_rb_survival;
#using scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_pap_quest;

#namespace namespace_63817fb8df215346;

// Namespace namespace_63817fb8df215346
// Params 0, eflags: 0x5
// Checksum 0xb541bf7a, Offset: 0x83
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"zm_rb_survival_farm", undefined, &pre_main_init, &post_main_init );
}

// Namespace namespace_63817fb8df215346
// Params 0, eflags: 0x4
// Checksum 0xd2145bfd, Offset: 0xa8
// Size: 0x4b
function private pre_main_init()
{
    if ( !function_7e9cfb87ca512500() )
    {
        return;
    }
    
    level utility::registersharedfunc( #"zm_rb_survival", #"power_flag_override", &function_4e52ae52457e35e6 );
    level utility::registersharedfunc( #"firefly_pap_quest", #"hash_c87b411e7826157c", &function_3d96150e6cef029f );
}

// Namespace namespace_63817fb8df215346
// Params 0, eflags: 0x4
// Checksum 0x8babecf3, Offset: 0xfb
// Size: 0x15
function private post_main_init()
{
    if ( function_7e9cfb87ca512500() )
    {
        level.vending_machines_powered_on_at_start = 0;
    }
}

// Namespace namespace_63817fb8df215346
// Params 0, eflags: 0x4
// Checksum 0x7ce0efac, Offset: 0x118
// Size: 0x2f, Type: bool
function private function_7e9cfb87ca512500()
{
    if ( !game_utility::function_21211f3255f8ea58() )
    {
        return false;
    }
    
    poiname = zm_rb_survival::function_64c3a9143299dacb();
    
    if ( poiname != "zone_farm" )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_63817fb8df215346
// Params 0, eflags: 0x4
// Checksum 0x2ea4588f, Offset: 0x150
// Size: 0x2
function private function_4e52ae52457e35e6()
{
    
}

// Namespace namespace_63817fb8df215346
// Params 0, eflags: 0x4
// Checksum 0xde260d6, Offset: 0x15b
// Size: 0xa
function private function_3d96150e6cef029f()
{
    level thread zm_sat_firefly_pap_quest::function_f538355bb1ac751a();
}

