// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_quest_wwq_cs.gsc  (hash_63371c0c1091bbff.gscc) (size: 7513 Bytes / 0x1d59 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6d8e2597 (1838032279)
// size ...... 7513 (0x1d59)
// includes .. 2   (offset: 0x18c5)
// strings ... 51  (offset: 0x18d5)
// dev strs .. 0   (offset: 0x1d59)
// exports ... 6   (offset: 0x1615)
// cseg ...... 0x3ea + 0x122b (0x1615)
// imports ... 16  (offset: 0x1705)
// animtree1 . 0   (offset: 0x1d59)
// animtree2 . 0   (offset: 0x1d59)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_ruby_quest_wwq_cs;

// Namespace zm_sat_ruby_quest_wwq_cs
// Params 2
// Checksum 0xe9b1760e, Offset: 0x408
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_ruby_quest_wwq_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_ruby_quest_wwq_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_ruby_quest_wwq_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_ruby_quest_wwq_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_ruby_quest_wwq_cs
// Params 3, eflags: 0x4
// Checksum 0xdada9488, Offset: 0x490
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_ruby_quest_wwq_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_ruby_quest_wwq_cs" );
}

// Namespace zm_sat_ruby_quest_wwq_cs
// Params 3, eflags: 0x4
// Checksum 0x1720c909, Offset: 0x50a
// Size: 0x10eb
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "oscar_solo_telescope_teleports";
    fe [[ f ]]( s, us, cf, ( 4935.5, -1260.75, 16 ), ( 0, 176.26, 0 ), "oscar_solo_telescope_teleport" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    fe [[ f ]]( s, us, cf, ( 652.5, 1732.5, 252 ), ( 0, 0, 0 ), "megalaser_trap" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    fe [[ f ]]( s, us, cf, ( 619.5, 1630.75, 296.25 ), ( 0, 187.14, 0 ), "megalaser_interact" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "oscar_solo_telescope_teleports";
    fe [[ f ]]( s, us, cf, ( 4731, -1716.5, 16 ), ( 0, 129.48, 0 ), "oscar_solo_telescope_teleport" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "oscar_solo_telescope_teleports";
    fe [[ f ]]( s, us, cf, ( 4864.25, -826.5, 16 ), ( 0, 215.89, 0 ), "oscar_solo_telescope_teleport" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    fe [[ f ]]( s, us, cf, ( -262, 37, 256.61 ), ( 0, 0, 0 ), "ice_trap", undefined, undefined, undefined, undefined, undefined, undefined, 160 );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "oscar_solo_telescope_teleports";
    fe [[ f ]]( s, us, cf, ( 4577.75, -686.5, 16 ), ( 0, 246.19, 0 ), "oscar_solo_telescope_teleport" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    fe [[ f ]]( s, us, cf, ( 4274, -1266.5, 100 ), ( 0, 326.39, 0 ), "telescope_interact", undefined, undefined, undefined, undefined, undefined, undefined, 60 );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "oscar_solo_telescope_teleports";
    fe [[ f ]]( s, us, cf, ( 4007.75, -658.75, 16 ), ( 0, 324.16, 0 ), "oscar_solo_telescope_teleport" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    fe [[ f ]]( s, us, cf, ( 4363.5, -1221.5, 62.75 ), ( 0, 355.54, 0 ), "heat_beam_target", undefined, undefined, undefined, undefined, undefined, undefined, 130 );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    fe [[ f ]]( s, us, cf, ( -2744, -69.5, -3.5 ), ( 0, 0, 0 ), "battery_landing" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    fe [[ f ]]( s, us, cf, ( -2801, -40, 26 ), ( 0, 0, 0 ), "battery_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    fe [[ f ]]( s, us, cf, ( 626, 1631, 275.25 ), ( 0, 189.54, 0 ), "battery_insert" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "lamp_structs";
    s.name = "script_struct_lamp";
    fe [[ f ]]( s, us, cf, ( 3045.5, 1151, 115.5 ), ( 0, 333.5, 0 ), "aberrant_lamp", undefined, "lamp_01" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "lamp_structs";
    s.name = "script_struct_lamp";
    fe [[ f ]]( s, us, cf, ( 3666.75, 363.75, 116.75 ), ( 0, 37.8, 0 ), "aberrant_lamp", undefined, "lamp_02" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    fe [[ f ]]( s, us, cf, ( 636.75, 1638.5, 303.25 ), ( 90, 0, -6.92 ), "drone_insert" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "lamp_structs";
    s.name = "script_struct_lamp";
    fe [[ f ]]( s, us, cf, ( 4440.75, 453.25, 117.75 ), ( 0, 34.9, 0 ), "aberrant_lamp", undefined, "lamp_11" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "lamp_structs";
    s.name = "script_struct_lamp";
    fe [[ f ]]( s, us, cf, ( -49.25, 1311.25, 407 ), ( 0, 13.8, 0 ), "aberrant_lamp", undefined, "lamp_03" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "lamp_structs";
    s.name = "script_struct_lamp";
    fe [[ f ]]( s, us, cf, ( 1082.75, -431.75, 295 ), ( 0, 345.45, 0 ), "aberrant_lamp", undefined, "lamp_14" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "lamp_structs";
    s.name = "script_struct_lamp";
    fe [[ f ]]( s, us, cf, ( 1712.5, -1152.5, 238.5 ), ( 0, 330.8, 0 ), "aberrant_lamp", undefined, "lamp_13" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "lamp_structs";
    s.name = "script_struct_lamp";
    fe [[ f ]]( s, us, cf, ( 936.5, -200, 405.25 ), ( 0, 334.2, 0 ), "aberrant_lamp", undefined, "lamp_12" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "oscar_solo_telescope_teleports";
    fe [[ f ]]( s, us, cf, ( 3688, -1137.5, 16 ), ( 0, 356.48, 0 ), "oscar_solo_telescope_teleport" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "lamp_structs";
    s.name = "script_struct_lamp";
    fe [[ f ]]( s, us, cf, ( 526, 182.5, 407 ), ( 0, 326.2, 0 ), "aberrant_lamp", undefined, "lamp_10" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "lamp_structs";
    s.name = "script_struct_lamp";
    fe [[ f ]]( s, us, cf, ( 2557, -2444, 98.25 ), ( 0, 352.1, 0 ), "aberrant_lamp", undefined, "lamp_09" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "lamp_structs";
    s.name = "script_struct_lamp";
    fe [[ f ]]( s, us, cf, ( 3461, -2939, 160.75 ), ( 0, 354, 0 ), "aberrant_lamp", undefined, "lamp_08" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "lamp_structs";
    s.name = "script_struct_lamp";
    fe [[ f ]]( s, us, cf, ( 3716.25, -2046.5, 164.25 ), ( 0, 28.38, 0 ), "aberrant_lamp", undefined, "lamp_07" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "lamp_structs";
    s.name = "script_struct_lamp";
    fe [[ f ]]( s, us, cf, ( -1585, -100, 356.75 ), ( 0, 9.6, 0 ), "aberrant_lamp", undefined, "lamp_06" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "lamp_structs";
    s.name = "script_struct_lamp";
    fe [[ f ]]( s, us, cf, ( -1212, 173.5, 471.25 ), ( 0, 34.44, 0 ), "aberrant_lamp", undefined, "lamp_05" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "lamp_structs";
    s.name = "script_struct_lamp";
    fe [[ f ]]( s, us, cf, ( -782, 1175, 418.25 ), ( 0, 4.1, 0 ), "aberrant_lamp", undefined, "lamp_04" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    fe [[ f ]]( s, us, cf, ( 657, 1675, 313 ), ( 0, 0, 0 ), "megalaser_center", undefined, undefined, undefined, undefined, undefined, undefined, 400 );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    fe [[ f ]]( s, us, cf, ( 3221, -8932, 2320 ), ( 0, 0, 0 ), "oscar_retreat" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "lamp_structs";
    s.name = "script_struct_lamp_landing";
    fe [[ f ]]( s, us, cf, ( 3020, 1104.75, -46.5 ), ( 0, 333.5, 0 ), "lamp_01_landing" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "lamp_structs";
    s.name = "script_struct_lamp_landing";
    fe [[ f ]]( s, us, cf, ( 3636, 400, -47 ), ( 0, 333.5, 0 ), "lamp_02_landing" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    fe [[ f ]]( s, us, cf, ( 619.5, 1630.75, 296.25 ), ( 0, 187.14, 0 ), "megalaser_parts_interact" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "lamp_structs";
    s.name = "script_struct_lamp_landing";
    fe [[ f ]]( s, us, cf, ( 4443.75, 528.75, -48.5 ), ( 0, 333.5, 0 ), "lamp_11_landing" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "lamp_structs";
    s.name = "script_struct_lamp_landing";
    fe [[ f ]]( s, us, cf, ( -95, 1215.5, 253 ), ( 0, 333.5, 0 ), "lamp_03_landing" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "lamp_structs";
    s.name = "script_struct_lamp_landing";
    fe [[ f ]]( s, us, cf, ( 1123.25, -431.5, 128.75 ), ( 0, 333.5, 0 ), "lamp_14_landing" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "lamp_structs";
    s.name = "script_struct_lamp_landing";
    fe [[ f ]]( s, us, cf, ( 1669.5, -1162.5, 73 ), ( 0, 333.5, 0 ), "lamp_13_landing" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "lamp_structs";
    s.name = "script_struct_lamp_landing";
    fe [[ f ]]( s, us, cf, ( 910, -174, 240 ), ( 0, 333.5, 0 ), "lamp_12_landing" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "lamp_structs";
    s.name = "script_struct_lamp_landing";
    fe [[ f ]]( s, us, cf, ( 554, 150, 244.25 ), ( 0, 333.5, 0 ), "lamp_10_landing" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "lamp_structs";
    s.name = "script_struct_lamp_landing";
    fe [[ f ]]( s, us, cf, ( 2604.5, -2437.5, -70.5 ), ( 0, 333.5, 0 ), "lamp_09_landing" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "lamp_structs";
    s.name = "script_struct_lamp_landing";
    fe [[ f ]]( s, us, cf, ( 3459, -2894, -3.5 ), ( 0, 333.5, 0 ), "lamp_08_landing" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "lamp_structs";
    s.name = "script_struct_lamp_landing";
    fe [[ f ]]( s, us, cf, ( 3740.5, -2087, 0.75 ), ( 0, 333.5, 0 ), "lamp_07_landing" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "lamp_structs";
    s.name = "script_struct_lamp_landing";
    fe [[ f ]]( s, us, cf, ( -1640.75, -120.75, 193.25 ), ( 0, 333.5, 0 ), "lamp_06_landing" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "lamp_structs";
    s.name = "script_struct_lamp_landing";
    fe [[ f ]]( s, us, cf, ( -1120, 115.25, 238.5 ), ( 0, 333.5, 0 ), "lamp_05_landing" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "lamp_structs";
    s.name = "script_struct_lamp_landing";
    fe [[ f ]]( s, us, cf, ( -747.5, 1144, 252 ), ( 0, 333.5, 0 ), "lamp_04_landing" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    fe [[ f ]]( s, us, cf, ( -1763.75, -109.5, 198.25 ), ( 0, 173.13, 0 ), "tessie_ambush_oscar_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    fe [[ f ]]( s, us, cf, ( -232, 289.75, 294.86 ), ( 0, 6.85, 0 ), "rocket_exhibit_interact" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "oscar_solo_telescope_teleports";
    fe [[ f ]]( s, us, cf, ( 3855, -1666.25, 16 ), ( 0, 57.35, 0 ), "oscar_solo_telescope_teleport" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_wwq_cs";
    s.groupid = "oscar_solo_telescope_teleports";
    fe [[ f ]]( s, us, cf, ( 4272.5, -1742.25, 16 ), ( 0, 86.04, 0 ), "oscar_solo_telescope_teleport" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_ruby_quest_wwq_cs
// Params 0, eflags: 0x4
// Checksum 0x4f6b534f, Offset: 0x15fd
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_ruby_quest_wwq_cs
// Params 0
// Checksum 0x188949c5, Offset: 0x1607
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_ruby_quest_wwq_cs" );
}

