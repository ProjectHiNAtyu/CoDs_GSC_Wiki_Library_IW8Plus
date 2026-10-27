// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_boss_fight_cs.gsc  (hash_7bfec8bd83fe30f5.gscc) (size: 7791 Bytes / 0x1e6f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2965a02a (694525994)
// size ...... 7791 (0x1e6f)
// includes .. 3   (offset: 0x1a43)
// strings ... 41  (offset: 0x1a5b)
// dev strs .. 0   (offset: 0x1e6f)
// exports ... 9   (offset: 0x16ab)
// cseg ...... 0x4be + 0x11ed (0x16ab)
// imports ... 20  (offset: 0x1813)
// animtree1 . 0   (offset: 0x1e6f)
// animtree2 . 0   (offset: 0x1e6f)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_mantis_boss_fight_cs;

// Namespace zm_sat_mantis_boss_fight_cs
// Params 0, eflags: 0x5
// Checksum 0x93f96996, Offset: 0x4dc
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_mantis_boss_fight_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_mantis_boss_fight_cs
// Params 0, eflags: 0x4
// Checksum 0xc559f57a, Offset: 0x4fd
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_mantis_boss_fight_cs
// Params 0, eflags: 0x4
// Checksum 0x40622696, Offset: 0x50e
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_mantis_boss_fight_cs
// Params 2
// Checksum 0xf08b70df, Offset: 0x51f
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_mantis_boss_fight_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_mantis_boss_fight_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_mantis_boss_fight_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_mantis_boss_fight_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_mantis_boss_fight_cs
// Params 3, eflags: 0x4
// Checksum 0xc3e09259, Offset: 0x5a7
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_mantis_boss_fight_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_mantis_boss_fight_cs" );
}

// Namespace zm_sat_mantis_boss_fight_cs
// Params 3, eflags: 0x4
// Checksum 0x531d5021, Offset: 0x621
// Size: 0x106a
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 54455.9, -32709.7, -131 ), ( 0, 44.4, 0 ), "boss_fight_barrier", undefined, "t10_zm_author_energy_barrier_295x110" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 54661.9, -32921.7, -131 ), ( 0, 44.4, 0 ), "boss_fight_barrier", undefined, "t10_zm_author_energy_barrier_295x110" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 54249.9, -32499.7, -131 ), ( 0, 44.4, 0 ), "boss_fight_barrier", undefined, "t10_zm_author_energy_barrier_295x110" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 54101.9, -32348.7, -131 ), ( 0, 44.4, 0 ), "boss_fight_barrier", undefined, "t10_zm_author_energy_barrier_130x110" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 55600, -31060, 468 ), ( 0, 0, 0 ), "dark_heart", "cspf_0_auto4868355459809814906" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 54010.9, -32255.7, -131 ), ( 0, 44.4, 0 ), "boss_fight_barrier", undefined, "t10_zm_author_energy_barrier_130x110" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 54855, -31896, -133 ), ( 0, 45, 0 ), "hold_out_pos", "cspf_0_auto5325924342640612312", "fireplace" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 54891.5, -31817.5, -131 ), ( 0, 0, 0 ), "cspf_0_auto5325924342640612312", "cspf_0_auto14043795793163170469", "phase_1" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 54720, -29808, -130 ), ( 0, 0, 0 ), "hold_out_pos", "cspf_0_auto646481231403975397", "toybox" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 54917, -29833, -86 ), ( 0, 0, 0 ), "cspf_0_auto646481231403975397", "cspf_0_auto3751870552891871842", "phase_1" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 56880, -32208, -126 ), ( 0, 135, 0 ), "hold_out_pos", "cspf_0_auto7159046999680039131", "piano" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 56787, -32119, -69 ), ( 0, 0, 0 ), "cspf_0_auto7159046999680039131", "cspf_0_auto656672773507786972", "phase_1" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 57106.6, -31790.7, -119.58 ), ( 270, 0, 0 ), "cspf_0_auto656672773507786972" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 53920.9, -32163.7, -131 ), ( 0, 44.4, 0 ), "boss_fight_barrier", undefined, "t10_zm_author_energy_barrier_130x110" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 53828.9, -32069.7, -131 ), ( 0, 44.4, 0 ), "boss_fight_barrier", undefined, "t10_zm_author_energy_barrier_130x110" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 55043.2, -32294.6, -113.53 ), ( 270, 0, 0 ), "cspf_0_auto14043795793163170469" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    s.script_label = "sat_cin_zm_vig_plr_dth_drk_hrt";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_drk_hrt";
    fe [[ f ]]( s, us, cf, ( 55442, -31418, -135 ), ( 0, 68.6, 0 ), "sat_cin_zm_vig_plr_dth_drk_hrt", undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 54959.4, -30356.6, -37.32 ), ( 359.86, 116.09, -90 ), "cspf_0_auto3751870552891871842" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    s.script_label = "doorbuy_zm_sat_floating_debris_farm_02";
    fe [[ f ]]( s, us, cf, ( 55321.1, -30583.2, 28.5 ), ( 0, 178.62, 0 ), "bf_window_mdl" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    s.script_label = "doorbuy_zm_sat_floating_debris_farm_02";
    fe [[ f ]]( s, us, cf, ( 56016.5, -31616.5, 33 ), ( 0, 41.68, 0 ), "bf_window_mdl" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 54671.5, -31840.6, -80.45 ), ( 0, 0, 0 ), "cspf_0_auto5325924342640612312", "cspf_0_auto4189422393593326546", "phase_2" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 56730.8, -32220.6, -79.58 ), ( 0, 0, 0 ), "cspf_0_auto7159046999680039131", "cspf_0_auto11738221203286684467", "phase_2" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 54877.8, -31884.2, 88 ), ( 0, 0, 0 ), "cspf_0_auto4189422393593326546" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 54776.7, -29918.7, -97.94 ), ( 0, 0, 0 ), "cspf_0_auto646481231403975397", "cspf_0_auto526083841932144162", "phase_2" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    s.script_scenescriptbundle = "sat_cin_zm_vig_fly_sisters_chalk";
    fe [[ f ]]( s, us, cf, ( 54925.5, -31939.5, -133.01 ), ( 0, 60.23, 0 ), "cspf_0_auto2715226267910506565" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 54855, -31896, -133 ), ( 0, 0, 0 ), "cspf_0_auto5325924342640612312", "cspf_0_auto2715226267910506565", "twins_pos", undefined, undefined, undefined, undefined, 120 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    s.script_scenescriptbundle = "sat_cin_zm_vig_fly_sisters_chalk";
    fe [[ f ]]( s, us, cf, ( 56836.1, -32272.3, -128.15 ), ( 0, 327.62, 0 ), "cspf_0_auto15703310849092736535" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 56880, -32208, -128 ), ( 0, 315, 0 ), "cspf_0_auto7159046999680039131", "cspf_0_auto15703310849092736535", "twins_pos", undefined, undefined, undefined, undefined, 120 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    s.script_scenescriptbundle = "sat_cin_zm_vig_fly_sisters_chalk";
    fe [[ f ]]( s, us, cf, ( 54682.6, -29739.5, -130.43 ), ( 0, 210.99, 0 ), "cspf_0_auto8971836000471752248" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 54720, -29808, -128 ), ( 0, 105, 0 ), "cspf_0_auto646481231403975397", "cspf_0_auto8971836000471752248", "twins_pos", undefined, undefined, undefined, undefined, 120 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 54723.8, -29805.9, 70.51 ), ( 0, 0, 0 ), "cspf_0_auto526083841932144162" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 56887.6, -32204.6, 88.87 ), ( 0, 0, 0 ), "cspf_0_auto11738221203286684467" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    s.script_scenescriptbundle = "sat_cin_zm_vig_fly_sisters_chalk";
    fe [[ f ]]( s, us, cf, ( 54784.5, -31933.5, -133.01 ), ( 0, 329.14, 0 ), "cspf_0_auto2715226267910506565" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 55608, -31096, -96 ), ( 0, 0, 0 ), "cspf_0_auto4868355459809814906" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    s.script_scenescriptbundle = "sat_cin_zm_vig_fly_sisters_chalk";
    fe [[ f ]]( s, us, cf, ( 54855.5, -31815, -132 ), ( 0, 192.98, 0 ), "cspf_0_auto2715226267910506565" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    s.script_scenescriptbundle = "sat_cin_zm_vig_fly_sisters_chalk";
    fe [[ f ]]( s, us, cf, ( 56855.4, -32130.2, -129.08 ), ( 0, 196.8, 0 ), "cspf_0_auto15703310849092736535" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    s.script_scenescriptbundle = "sat_cin_zm_vig_fly_sisters_chalk";
    fe [[ f ]]( s, us, cf, ( 56968.9, -32204, -127.76 ), ( 0, 91.18, 0 ), "cspf_0_auto15703310849092736535" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    s.script_scenescriptbundle = "sat_cin_zm_vig_fly_sisters_chalk";
    fe [[ f ]]( s, us, cf, ( 54796.1, -29805.6, -129.69 ), ( 0, 89.49, 0 ), "cspf_0_auto8971836000471752248" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    s.script_scenescriptbundle = "sat_cin_zm_vig_fly_sisters_chalk";
    fe [[ f ]]( s, us, cf, ( 54682.8, -29878.7, -124.8 ), ( 0, 331.62, 0 ), "cspf_0_auto8971836000471752248" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 55808.7, -31383.1, -81.4 ), ( 0, 0, 0 ), undefined, undefined, "bf_fullammo_phase3" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 55521.5, -30745.4, -81.4 ), ( 0, 0, 0 ), undefined, undefined, "bf_fullammo_phase2" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 54721, -29808, -100 ), ( 0, 1.1, 0 ), "hold_out_pos_sub_item_toybox" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 54865, -31886, -110 ), ( 0, 46.1, 0 ), "hold_out_pos_sub_item_fireplace" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 56870, -32200, -87 ), ( 90, 279.94, 144.94 ), "hold_out_pos_sub_item_piano" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    s.script_label = "sat_zm_door_wood_burnt_01_dyn";
    fe [[ f ]]( s, us, cf, ( 56529.9, -31775.5, 14.75 ), ( 0, 240, 0 ), "bf_door_mdl" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    s.script_label = "sat_zm_door_wood_burnt_01_dyn";
    fe [[ f ]]( s, us, cf, ( 56509.9, -31810, -121 ), ( 0, 240, 0 ), "bf_door_mdl" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    s.script_label = "sat_zm_door_wood_burnt_01_dyn";
    fe [[ f ]]( s, us, cf, ( 55993.1, -31569.6, -121 ), ( 0, 60, 0 ), "bf_door_mdl" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    s.script_label = "sat_zm_door_wood_burnt_01_dyn";
    fe [[ f ]]( s, us, cf, ( 54855.8, -30419.2, -121 ), ( 0, 25.57, 0 ), "bf_door_mdl" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    s.script_label = "sat_zm_door_garage_wood_burnt_02_dyn";
    fe [[ f ]]( s, us, cf, ( 55114.5, -30542.5, -121 ), ( 0, 294.74, 0 ), "bf_door_mdl" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    s.script_label = "sat_zm_door_wood_burnt_01_dyn";
    fe [[ f ]]( s, us, cf, ( 55056.5, -30218.8, -121 ), ( 0, 295, 0 ), "bf_door_mdl" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    s.script_label = "sat_zm_door_wood_burnt_01_dyn";
    fe [[ f ]]( s, us, cf, ( 55278.8, -30033.8, -121 ), ( 0, 25, 0 ), "bf_door_mdl" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    s.script_label = "sat_zm_door_garage_wood_burnt_01_dyn";
    fe [[ f ]]( s, us, cf, ( 56346.3, -31359.8, -121 ), ( 0, 150, 0 ), "bf_door_mdl" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    s.script_label = "sat_zm_door_wood_burnt_01_dyn";
    fe [[ f ]]( s, us, cf, ( 55237.6, -30053.7, 15 ), ( 0, 204.55, 0 ), "bf_door_mdl" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    s.script_label = "sat_zm_door_wood_burnt_01_dyn";
    fe [[ f ]]( s, us, cf, ( 55408.3, -30600.9, -121 ), ( 0, 25, 0 ), "bf_door_mdl" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    s.script_label = "sat_zm_door_wood_burnt_01_dyn";
    fe [[ f ]]( s, us, cf, ( 56710.8, -31390.2, -121 ), ( 0, 240, 0 ), "bf_door_mdl" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 56880, -32208, -129.13 ), ( 0, 135, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 54720, -29808, -130 ), ( 0, 135, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_boss_fight_cs";
    fe [[ f ]]( s, us, cf, ( 54854.3, -31895.5, -133 ), ( 0, 45, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_mantis_boss_fight_cs
// Params 0, eflags: 0x4
// Checksum 0xf544b193, Offset: 0x1693
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_mantis_boss_fight_cs
// Params 0
// Checksum 0x1b34f14, Offset: 0x169d
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_mantis_boss_fight_cs" );
}

