// scripts\mp\zm\systems\zm_relic_no_armor.gsc  (hash_4a80395729c41274.gscc) (size: 1091 Bytes / 0x443 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa91640e0 (2836807904)
// size ...... 1091 (0x443)
// includes .. 3   (offset: 0x413)
// strings ... 0   (offset: 0x42b)
// dev strs .. 2   (offset: 0x42b)
// exports ... 7   (offset: 0x1bb)
// cseg ...... 0x58 + 0x163 (0x1bb)
// imports ... 11  (offset: 0x2d3)
// animtree1 . 0   (offset: 0x443)
// animtree2 . 0   (offset: 0x443)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\relics\zm_relics;

#namespace zm_relic_no_armor;

// Namespace zm_relic_no_armor
// Params 0, eflags: 0x5
// Checksum 0x5c6b07f7, Offset: 0x76
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_b3ef00f467e78ca5", undefined, &init_relic_no_armor, undefined );
}

// Namespace zm_relic_no_armor
// Params 0
// Checksum 0x4c9d92de, Offset: 0x97
// Size: 0xa
function init_relic_no_armor()
{
    level thread function_cf8664a8164ace1f();
}

// Namespace zm_relic_no_armor
// Params 0
// Checksum 0xba0b5fd6, Offset: 0xa9
// Size: 0x3a
function function_cf8664a8164ace1f()
{
    zm_relics::register_relic_functions( #"hash_cf8275ab5b690376", &function_8c9253fbc2eccd6f, &function_b7ad14af06e9b8ca );
    utility::registersharedfunc( #"powerup_full_armor", #"hash_75b10183404b5a16", &function_f8f92cf6745ead9 );
}

// Namespace zm_relic_no_armor
// Params 0
// Checksum 0xa37d00, Offset: 0xeb
// Size: 0x24, Type: bool
function function_f8f92cf6745ead9()
{
    return !( isdefined( level.zm_mode_modifiers ) && level.zm_mode_modifiers.var_2dc492758425fa76 );
}

// Namespace zm_relic_no_armor
// Params 0
// Checksum 0x7159b797, Offset: 0x118
// Size: 0x55
function function_8c9253fbc2eccd6f()
{
    params = {};
    
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"set_no_armor", params );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_relic_no_armor
// Params 0
// Checksum 0x7f8f30f4, Offset: 0x175
// Size: 0x46
function function_b7ad14af06e9b8ca()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"disable_no_armor" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x49>" );
    #/
}

