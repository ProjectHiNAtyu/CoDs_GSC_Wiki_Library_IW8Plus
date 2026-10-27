// scripts\mp\zm\systems\zm_relic_delay_health_regen.gsc  (hash_0642f917e6ea7a13.gscc) (size: 961 Bytes / 0x3c1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4def5ec7 (1307532999)
// size ...... 961 (0x3c1)
// includes .. 3   (offset: 0x391)
// strings ... 0   (offset: 0x3a9)
// dev strs .. 2   (offset: 0x3a9)
// exports ... 6   (offset: 0x199)
// cseg ...... 0x58 + 0x141 (0x199)
// imports ... 9   (offset: 0x289)
// animtree1 . 0   (offset: 0x3c1)
// animtree2 . 0   (offset: 0x3c1)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\relics\zm_relics;

#namespace zm_relic_delay_health_regen;

// Namespace zm_relic_delay_health_regen
// Params 0, eflags: 0x5
// Checksum 0x2b7a4540, Offset: 0x76
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_cf4fc3dbed6ee2a2", undefined, &init_relic_delay_health_regen, undefined );
}

// Namespace zm_relic_delay_health_regen
// Params 0
// Checksum 0x42c9a432, Offset: 0x97
// Size: 0xa
function init_relic_delay_health_regen()
{
    level thread function_82424773b98f6620();
}

// Namespace zm_relic_delay_health_regen
// Params 0
// Checksum 0x813271a6, Offset: 0xa9
// Size: 0x1c
function function_82424773b98f6620()
{
    zm_relics::register_relic_functions( #"delay_health_regen", &function_a13e20f3a6484566, &function_82e45ef317bca145 );
}

// Namespace zm_relic_delay_health_regen
// Params 0
// Checksum 0xb5785104, Offset: 0xcd
// Size: 0x7e
function function_a13e20f3a6484566()
{
    params = {};
    params.var_786c9fa7547cf486 = level.zm_relic_modifiers[ #"delay_health_regen" ].var_c424a3ded13d25ce;
    
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"set_delay_health_regen", params );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_relic_delay_health_regen
// Params 0
// Checksum 0xffd49bc8, Offset: 0x153
// Size: 0x46
function function_82e45ef317bca145()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"disable_delay_health_regen" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x49>" );
    #/
}

