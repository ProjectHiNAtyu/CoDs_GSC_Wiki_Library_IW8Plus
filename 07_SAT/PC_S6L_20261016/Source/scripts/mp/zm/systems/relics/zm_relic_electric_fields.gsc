// scripts\mp\zm\systems\relics\zm_relic_electric_fields.gsc  (hash_677fc71a876b979b.gscc) (size: 1493 Bytes / 0x5d5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2aff25b7 (721364407)
// size ...... 1493 (0x5d5)
// includes .. 3   (offset: 0x575)
// strings ... 4   (offset: 0x58d)
// dev strs .. 2   (offset: 0x5bd)
// exports ... 6   (offset: 0x35d)
// cseg ...... 0xf4 + 0x269 (0x35d)
// imports ... 10  (offset: 0x44d)
// animtree1 . 0   (offset: 0x5d5)
// animtree2 . 0   (offset: 0x5d5)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\relics\zm_relics;

#namespace zm_relic_electric_fields;

// Namespace zm_relic_electric_fields
// Params 0, eflags: 0x5
// Checksum 0x84e55fe0, Offset: 0x112
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_aff0137402fc285f", undefined, &init_relic_electric_fields, undefined );
}

// Namespace zm_relic_electric_fields
// Params 0
// Checksum 0xc9e58ee7, Offset: 0x133
// Size: 0x3c
function init_relic_electric_fields()
{
    level._effect[ "vfx_perk_dw_aoe_exp" ] = loadfxasset( "vfx_t10_gameplay_zm_dead_wire_elec_ball" );
    level._effect[ "vfx_perk_dw_aoe_exp_end_disappear" ] = loadfxasset( "vfx_t10_gameplay_zm_dead_wire_elec_ball_disappear" );
    level thread function_7b052897240930dd();
}

// Namespace zm_relic_electric_fields
// Params 0
// Checksum 0x78053960, Offset: 0x177
// Size: 0x1c
function function_7b052897240930dd()
{
    zm_relics::register_relic_functions( #"electric_fields", &function_91160392a6076cd5, &function_c0073e12bad0edc8 );
}

// Namespace zm_relic_electric_fields
// Params 0
// Checksum 0xd2a984ed, Offset: 0x19b
// Size: 0x174
function function_91160392a6076cd5()
{
    params = {};
    params.spawnradius = level.zm_relic_modifiers[ #"electric_fields" ].spawnradius;
    params.damageradius = level.zm_relic_modifiers[ #"electric_fields" ].damageradius;
    params.tickrate = level.zm_relic_modifiers[ #"electric_fields" ].tickrate;
    params.var_66691c6b8ccdeb7b = level.zm_relic_modifiers[ #"electric_fields" ].var_66691c6b8ccdeb7b;
    params.var_d8738ec9cef3fcdb = level.zm_relic_modifiers[ #"electric_fields" ].var_d8738ec9cef3fcdb;
    params.var_1fc0ceac8cf654c8 = level.zm_relic_modifiers[ #"electric_fields" ].var_1fc0ceac8cf654c8;
    params.var_934c3232f51d2a7b = level.zm_relic_modifiers[ #"electric_fields" ].var_934c3232f51d2a7b;
    
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"set_electric_fields", params );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_relic_electric_fields
// Params 0
// Checksum 0x234b6df0, Offset: 0x317
// Size: 0x46
function function_c0073e12bad0edc8()
{
    if ( utility::callsharedfunc( #"zm_mode_modifiers", #"hash_d0e6560a86f1d651" ) )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"disable_electric_fields" );
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x46>" );
    #/
}

