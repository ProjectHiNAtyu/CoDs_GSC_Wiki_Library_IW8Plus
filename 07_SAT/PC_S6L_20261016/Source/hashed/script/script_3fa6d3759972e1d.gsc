// script_3fa6d3759972e1d  (hash_03fa6d3759972e1d.gscc) (size: 19791 Bytes / 0x4d4f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa5cd2311 (2781684497)
// size ...... 19791 (0x4d4f)
// includes .. 3   (offset: 0x4323)
// strings ... 101 (offset: 0x433b)
// dev strs .. 0   (offset: 0x4d4f)
// exports ... 9   (offset: 0x3f8b)
// cseg ...... 0xba5 + 0x33e6 (0x3f8b)
// imports ... 20  (offset: 0x40f3)
// animtree1 . 0   (offset: 0x4d4f)
// animtree2 . 0   (offset: 0x4d4f)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q2_ob_activity_pisces_cs;

// Namespace mp_sat_avalon_q2_ob_activity_pisces_cs
// Params 0, eflags: 0x5
// Checksum 0x6b321bef, Offset: 0xbc3
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q2_ob_activity_pisces_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q2_ob_activity_pisces_cs
// Params 0, eflags: 0x4
// Checksum 0xbd07f9c7, Offset: 0xbe4
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q2_ob_activity_pisces_cs
// Params 0, eflags: 0x4
// Checksum 0x383c2a2b, Offset: 0xbf5
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q2_ob_activity_pisces_cs
// Params 2
// Checksum 0x88d57c62, Offset: 0xc06
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q2_ob_activity_pisces_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q2_ob_activity_pisces_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q2_ob_activity_pisces_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q2_ob_activity_pisces_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_pisces_cs
// Params 3, eflags: 0x4
// Checksum 0xbbbe9ee4, Offset: 0xc8e
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q2_ob_activity_pisces_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q2_ob_activity_pisces_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_pisces_cs
// Params 3, eflags: 0x4
// Checksum 0xa01ee905, Offset: 0xd08
// Size: 0x3263
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    fe [[ f ]]( s, us, cf, ( 40148, 9224, 969 ), ( 0, 0, 0 ), "pisces_step_01_intro_center" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.name = "turret";
    fe [[ f ]]( s, us, cf, ( 36511.2, 5747, 186 ), ( 354.03, 159.57, -0.35 ), "s_pisces_turret" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    fe [[ f ]]( s, us, cf, ( 49151.5, 7592.1, 1889.01 ), ( 0, 354.75, 0 ), "s_evacuation_announcer_guild" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "VTOL_1";
    s.ishelistruct = 1;
    s.name = "VTOL_path";
    fe [[ f ]]( s, us, cf, ( 52924, 21685.8, 2180.48 ), ( 0, 207.31, 0 ), "cspf_0_auto3624413082962549432", "cspf_0_auto1843690401807619797", undefined, undefined, undefined, undefined, undefined, undefined, 70 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "VTOL_1";
    s.ishelistruct = 1;
    s.name = "VTOL_path_start";
    fe [[ f ]]( s, us, cf, ( 53514.5, 22155.7, 654.89 ), ( 0, 212.77, 0 ), "pisces_clifftown_vtol_flyover_01", "cspf_0_auto3624413082962549432", "pisces_clifftown_VTOL_flyover", undefined, undefined, undefined, undefined, undefined, 20, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "VTOL_1";
    s.ishelistruct = 1;
    s.name = "VTOL_path";
    fe [[ f ]]( s, us, cf, ( 33628, 7048.44, 3611 ), ( 354.91, 230.69, -6.18 ), "cspf_0_auto1843690401807619797", "cspf_0_auto14316060726972505958", undefined, undefined, undefined, undefined, undefined, undefined, 70 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "VTOL_1";
    s.ishelistruct = 1;
    s.name = "VTOL_path";
    fe [[ f ]]( s, us, cf, ( 32573.5, 5861.52, 3975 ), ( 0, 234.95, 0 ), "cspf_0_auto14316060726972505958", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 70 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "VTOL_2";
    s.ishelistruct = 1;
    s.name = "VTOL_path";
    fe [[ f ]]( s, us, cf, ( 53726.8, 16569.1, 2180.48 ), ( 0, 209.31, 0 ), "cspf_0_auto2471155729745458360", "cspf_0_auto15499324063631920462", undefined, undefined, undefined, undefined, undefined, undefined, 70 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "VTOL_2";
    s.ishelistruct = 1;
    s.name = "VTOL_path_start";
    fe [[ f ]]( s, us, cf, ( 54224.1, 17034.6, 532.89 ), ( 0, 212.77, 0 ), "pisces_clifftown_vtol_flyover_02", "cspf_0_auto2471155729745458360", "pisces_clifftown_VTOL_flyover", undefined, undefined, undefined, undefined, undefined, 20, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "VTOL_2";
    s.ishelistruct = 1;
    s.name = "VTOL_path";
    fe [[ f ]]( s, us, cf, ( 38364.4, 4137.03, 3675 ), ( 355.87, 226.57, -4.35 ), "cspf_0_auto15499324063631920462", "cspf_0_auto17632899322955122998", undefined, undefined, undefined, undefined, undefined, undefined, 70 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "VTOL_2";
    s.ishelistruct = 1;
    s.name = "VTOL_path";
    fe [[ f ]]( s, us, cf, ( 37503.3, 3402.19, 4177 ), ( 0, 222.95, 0 ), "cspf_0_auto17632899322955122998", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 70 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "VTOL_3";
    s.ishelistruct = 1;
    s.name = "VTOL_path";
    fe [[ f ]]( s, us, cf, ( 54561.2, 19838.6, 2920.48 ), ( 0, 221.31, 0 ), "cspf_0_auto4147661196654132327", "cspf_0_auto15899363167773140666", undefined, undefined, undefined, undefined, undefined, undefined, 70 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "VTOL_3";
    s.ishelistruct = 1;
    s.name = "VTOL_path_start";
    fe [[ f ]]( s, us, cf, ( 55386.9, 21546.7, 578.89 ), ( 0, 226.77, 0 ), "pisces_clifftown_vtol_flyover_03", "cspf_0_auto4147661196654132327", "pisces_clifftown_VTOL_flyover", undefined, undefined, undefined, undefined, undefined, 20, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "VTOL_3";
    s.ishelistruct = 1;
    s.name = "VTOL_path";
    fe [[ f ]]( s, us, cf, ( 36695, 6989.13, 3929 ), ( 353.41, 214.68, -4.54 ), "cspf_0_auto15899363167773140666", "cspf_0_auto716138883861160649", undefined, undefined, undefined, undefined, undefined, undefined, 70 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "VTOL_3";
    s.ishelistruct = 1;
    s.name = "VTOL_path";
    fe [[ f ]]( s, us, cf, ( 35671.6, 5957.3, 4619 ), ( 0, 220.95, 0 ), "cspf_0_auto716138883861160649", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 70 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "drones";
    s.name = "drones";
    fe [[ f ]]( s, us, cf, ( 42628, 7159, 1258.89 ), ( 0, 0, 0 ), "pisces_intro_drone" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 198, 432, 436 );
    s._size_min = ( 256, 406, 234 );
    s.groupid = "Grotto_Triggers";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 40090, 10790, -63 ), ( 0, 250.6, 0 ), "trig_clifftown_grotto_pisces_karma_scene" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "drones";
    s.name = "drones";
    fe [[ f ]]( s, us, cf, ( 40951, 8993, 1013.2 ), ( 0, 320, 0 ), "pisces_intro_drone" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "drones";
    s.name = "drones";
    fe [[ f ]]( s, us, cf, ( 39273, 5825, 1049.07 ), ( 0, 4, 0 ), "pisces_intro_drone" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "drones";
    s.name = "drones";
    fe [[ f ]]( s, us, cf, ( 46232, 8180, 1255.26 ), ( 0, 26, 0 ), "pisces_intro_drone" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 198, 168, 174 );
    s._size_min = ( 108, 178, 114 );
    s.groupid = "Grotto_Triggers";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 40861, 9971, 185 ), ( 0, 250.6, 0 ), "trig_clifftown_grotto_pisces_karma_scene" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "drones";
    s.name = "drones";
    fe [[ f ]]( s, us, cf, ( 44111, 8876, 1251.09 ), ( 0, 252, 0 ), "pisces_intro_drone" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s._size_max = ( 630, 508, 420 );
    s._size_min = ( 516, 542, 500 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "sat_ob_ambient_pisces_vtol_clifftown_intro";
    s.var_95e2cee7aca5aaae = "0";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 42437.6, 6726.33, 1269 ), ( 0, 238.01, 0 ), "clifftown_pisces_intro_vtol_02", "clifftown_pisces_intro_vtol_02_spawnpoint", "noent_volume_ai_encounter_cs" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s._size_max = ( 630, 508, 420 );
    s._size_min = ( 516, 542, 500 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "sat_ob_ambient_pisces_vtol_clifftown_intro";
    s.var_95e2cee7aca5aaae = "0";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 39189.6, 7118.33, 1269 ), ( 0, 238.01, 0 ), "clifftown_pisces_intro_vtol_03", "clifftown_pisces_intro_vtol_03_spawnpoint", "noent_volume_ai_encounter_cs" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "clifftown_pisces_intro_vtol_02";
    s.ishelistruct = 1;
    s.name = "heli_unload";
    s.script_unload = "default";
    fe [[ f ]]( s, us, cf, ( 42134.1, 6515.9, 2207 ), ( 0, 349.12, 0 ), "clifftown_pisces_intro_vtol_02_unload", "cspf_0_auto17074402015315041846", "blima_unload", undefined, undefined, undefined, undefined, undefined, 70 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "clifftown_pisces_intro_vtol_02";
    s.height = 100;
    s.name = "goal_node_01";
    fe [[ f ]]( s, us, cf, ( 42044, 6621.02, 1263.81 ), ( 0.09, 330, -1.33 ), "clifftown_pisces_intro_vtol_02_goal_01", undefined, undefined, undefined, undefined, undefined, undefined, 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "clifftown_pisces_intro_vtol_02";
    s.ishelistruct = 1;
    s.name = "heli_start";
    fe [[ f ]]( s, us, cf, ( 38038.9, 12296.7, 2700 ), ( 0, 308.19, 0 ), undefined, "cspf_0_auto7467308405683727171", undefined, undefined, undefined, undefined, undefined, undefined, 70, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s._size_max = ( 630, 508, 420 );
    s._size_min = ( 516, 542, 500 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "sat_ob_ambient_pisces_vtol_clifftown_intro";
    s.var_95e2cee7aca5aaae = "0";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 43294.5, 8909.5, 1269 ), ( 0, 268.01, 0 ), "clifftown_pisces_intro_vtol_01", "clifftown_pisces_intro_vtol_01_spawnpoint", "noent_volume_ai_encounter_cs" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "clifftown_pisces_intro_vtol_01";
    s.ishelistruct = 1;
    s.name = "heli_unload";
    s.script_unload = "default";
    fe [[ f ]]( s, us, cf, ( 43143.5, 8644, 2207 ), ( 0, 19.12, 0 ), "clifftown_pisces_intro_vtol_01_unload", "cspf_0_auto9125040232887259039", "blima_unload", undefined, undefined, undefined, undefined, undefined, 70 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "clifftown_pisces_intro_vtol_01";
    s.height = 80;
    s.name = "goal_node_01";
    fe [[ f ]]( s, us, cf, ( 43071, 8693.5, 1248.01 ), ( 359.95, 360, 0.04 ), "clifftown_pisces_intro_vtol_01_goal_01", undefined, undefined, undefined, undefined, undefined, undefined, 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "clifftown_pisces_intro_vtol_02";
    s.ishelistruct = 1;
    s.name = "heli_path";
    fe [[ f ]]( s, us, cf, ( 42122.8, 6488.36, 2511 ), ( 0, 346, 0 ), "cspf_0_auto17074402015315041846", "cspf_0_auto17661648960387248742", undefined, undefined, undefined, undefined, undefined, undefined, 70 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "clifftown_pisces_intro_vtol_02";
    s.ishelistruct = 1;
    s.name = "heli_path";
    fe [[ f ]]( s, us, cf, ( 42015.5, 6630.54, 2511 ), ( 0, 304.12, 0 ), "cspf_0_auto7467308405683727171", "clifftown_pisces_intro_vtol_02_unload", undefined, undefined, undefined, undefined, undefined, undefined, 70 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "clifftown_pisces_intro_vtol_01";
    s.ishelistruct = 1;
    s.name = "heli_start";
    fe [[ f ]]( s, us, cf, ( 38810.5, 14130, 2700 ), ( 0, 316.19, 0 ), undefined, "cspf_0_auto10017205155194031117", undefined, undefined, undefined, undefined, undefined, undefined, 70, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "clifftown_pisces_intro_vtol_01";
    s.ishelistruct = 1;
    s.name = "heli_path";
    fe [[ f ]]( s, us, cf, ( 43147.5, 8614.5, 2511 ), ( 0, 16, 0 ), "cspf_0_auto9125040232887259039", "cspf_0_auto578273966939908303", undefined, undefined, undefined, undefined, undefined, undefined, 70 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "clifftown_pisces_intro_vtol_01";
    s.ishelistruct = 1;
    s.name = "heli_path";
    fe [[ f ]]( s, us, cf, ( 42983.5, 8684, 2511 ), ( 0, 334.12, 0 ), "cspf_0_auto10017205155194031117", "clifftown_pisces_intro_vtol_01_unload", undefined, undefined, undefined, undefined, undefined, undefined, 70 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.goal_area_target = "clifftown_pisces_intro_vtol_01_goal_01";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "mediumAirship";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "clifftown_pisces_intro_vtol_01_unload";
    fe [[ f ]]( s, us, cf, ( 43132, 8633, 1248.04 ), ( 0, 0, 0 ), "clifftown_pisces_intro_vtol_01_spawnpoint" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "clifftown_pisces_intro_vtol_03";
    s.ishelistruct = 1;
    s.name = "heli_unload";
    s.script_unload = "default";
    fe [[ f ]]( s, us, cf, ( 39432.1, 7656.8, 2207 ), ( 0, 343.18, 0 ), "clifftown_pisces_intro_vtol_03_unload", "cspf_0_auto12853772072504680171", "blima_unload", undefined, undefined, undefined, undefined, undefined, 70 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "clifftown_pisces_intro_vtol_03";
    s.height = 100;
    s.name = "goal_node_01";
    fe [[ f ]]( s, us, cf, ( 39052, 6459.02, 1051.69 ), ( 0, 330, 0 ), "clifftown_pisces_intro_vtol_03_goal_01", undefined, undefined, undefined, undefined, undefined, undefined, 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "clifftown_pisces_intro_vtol_03";
    s.ishelistruct = 1;
    s.name = "heli_start";
    fe [[ f ]]( s, us, cf, ( 36113.2, 11693.3, 2700 ), ( 0, 304.19, 0 ), undefined, "cspf_0_auto932168285780040865", undefined, undefined, undefined, undefined, undefined, undefined, 70, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "clifftown_pisces_intro_vtol_03";
    s.ishelistruct = 1;
    s.name = "heli_path";
    fe [[ f ]]( s, us, cf, ( 39610.5, 7696.53, 2511 ), ( 0, 341.78, 0 ), "cspf_0_auto12853772072504680171", "cspf_0_auto5859268855431247069", undefined, undefined, undefined, undefined, undefined, undefined, 70 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.goal_area_target = "clifftown_pisces_intro_vtol_02_goal_01";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "mediumAirship";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "clifftown_pisces_intro_vtol_02_unload";
    fe [[ f ]]( s, us, cf, ( 42238.6, 6664.13, 1261.14 ), ( 0, 330, 0 ), "clifftown_pisces_intro_vtol_02_spawnpoint" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "clifftown_pisces_intro_vtol_02";
    s.ishelistruct = 1;
    s.name = "heli_path";
    fe [[ f ]]( s, us, cf, ( 49567.6, 2363.25, 4000 ), ( 0, 331, 0 ), "cspf_0_auto17661648960387248742", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 70 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "clifftown_pisces_intro_vtol_03";
    s.ishelistruct = 1;
    s.name = "heli_path";
    fe [[ f ]]( s, us, cf, ( 39225.1, 7751.12, 2661.5 ), ( 0, 330.89, 0 ), "cspf_0_auto932168285780040865", "clifftown_pisces_intro_vtol_03_unload", undefined, undefined, undefined, undefined, undefined, undefined, 70 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.goal_area_target = "clifftown_pisces_intro_vtol_03_goal_01";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "mediumAirship";
    s.variantname = "ai_encounter_spawnpoint";
    s.var_4501e0172e168ddf = "clifftown_pisces_intro_vtol_03_unload";
    fe [[ f ]]( s, us, cf, ( 39258.1, 7549.88, 1061.31 ), ( 0, 332.86, 0 ), "clifftown_pisces_intro_vtol_03_spawnpoint" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "clifftown_pisces_intro_vtol_01";
    s.ishelistruct = 1;
    s.name = "heli_path";
    fe [[ f ]]( s, us, cf, ( 51657.5, 8764.5, 4000 ), ( 0, 1, 0 ), "cspf_0_auto578273966939908303", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 70 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.groupid = "clifftown_pisces_intro_vtol_02";
    s.height = 400;
    fe [[ f ]]( s, us, cf, ( 41527.3, 5400.03, 982.6 ), ( 0, 330, 0 ), "trig_clifftown_pisces_intro_vtol_02", "clifftown_pisces_intro_vtol_02", undefined, undefined, undefined, undefined, undefined, 1600 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.groupid = "clifftown_pisces_intro_vtol_03";
    s.ishelistruct = 1;
    s.name = "heli_path";
    fe [[ f ]]( s, us, cf, ( 43828.9, -740.27, 4000 ), ( 0, 319, 0 ), "cspf_0_auto5859268855431247069", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 70 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.groupid = "Clifftown";
    s.height = 600;
    fe [[ f ]]( s, us, cf, ( 40266.3, 10275.5, 946.97 ), ( 0, 330, 0 ), "trig_clifftown_pisces_guild_vo_combat", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.groupid = "Clifftown";
    s.height = 600;
    fe [[ f ]]( s, us, cf, ( 40688.3, 9455.5, 946.97 ), ( 0, 330, 0 ), "trig_clifftown_pisces_guild_vo_combat", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.groupid = "Clifftown";
    s.height = 600;
    fe [[ f ]]( s, us, cf, ( 38902.3, 9903.53, 851 ), ( 0, 330, 0 ), "trig_clifftown_pisces_guild_vo_combat", undefined, undefined, undefined, undefined, undefined, undefined, 350 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.groupid = "clifftown_pisces_intro_vtol_03";
    s.height = 400;
    fe [[ f ]]( s, us, cf, ( 39041.8, 5918.53, 982.6 ), ( 0, 330, 0 ), "trig_clifftown_pisces_intro_vtol_03", "clifftown_pisces_intro_vtol_03", undefined, undefined, undefined, undefined, undefined, 1200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.groupid = "clifftown_pisces_intro_vtol_01";
    s.height = 400;
    fe [[ f ]]( s, us, cf, ( 44810, 8715, 982.6 ), ( 0, 0, 0 ), "trig_clifftown_pisces_intro_vtol_01", "clifftown_pisces_intro_vtol_01", undefined, undefined, undefined, undefined, undefined, 1400 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.groupid = "Clifftown";
    s.height = 600;
    fe [[ f ]]( s, us, cf, ( 41842.3, 7687.53, 946.97 ), ( 0, 330, 0 ), "trig_clifftown_pisces_guild_vo_combat", undefined, undefined, undefined, undefined, undefined, undefined, 400 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.groupid = "Clifftown";
    s.height = 600;
    fe [[ f ]]( s, us, cf, ( 41322.3, 8745.53, 946.97 ), ( 0, 330, 0 ), "trig_clifftown_pisces_guild_vo_combat", undefined, undefined, undefined, undefined, undefined, undefined, 350 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.groupid = "Clifftown";
    s.height = 600;
    fe [[ f ]]( s, us, cf, ( 42002.3, 9573.53, 851 ), ( 0, 330, 0 ), "trig_clifftown_pisces_guild_vo_combat", undefined, undefined, undefined, undefined, undefined, undefined, 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.groupid = "Clifftown";
    s.height = 600;
    fe [[ f ]]( s, us, cf, ( 40710.3, 7571.53, 946.97 ), ( 0, 330, 0 ), "trig_clifftown_pisces_guild_vo_combat", undefined, undefined, undefined, undefined, undefined, undefined, 350 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.groupid = "Clifftown";
    s.height = 600;
    fe [[ f ]]( s, us, cf, ( 39316.3, 8235.53, 946.97 ), ( 0, 330, 0 ), "trig_clifftown_pisces_guild_vo_combat", undefined, undefined, undefined, undefined, undefined, undefined, 400 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.groupid = "Clifftown";
    s.height = 600;
    fe [[ f ]]( s, us, cf, ( 41200.3, 10435.5, 946.97 ), ( 0, 330, 0 ), "trig_clifftown_pisces_guild_vo_combat", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.groupid = "Clifftown";
    s.height = 600;
    fe [[ f ]]( s, us, cf, ( 39738.3, 9131.53, 851 ), ( 0, 330, 0 ), "trig_clifftown_pisces_guild_vo_combat", undefined, undefined, undefined, undefined, undefined, undefined, 350 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 600;
    fe [[ f ]]( s, us, cf, ( 48410.3, 7899.53, 851 ), ( 0, 330, 0 ), "trig_clifftown_pisces_guild_vo_initial_encounter", undefined, undefined, undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.groupid = "Clifftown";
    s.height = 600;
    fe [[ f ]]( s, us, cf, ( 40314.3, 6419.53, 946.97 ), ( 0, 330, 0 ), "trig_clifftown_pisces_guild_vo_combat", undefined, undefined, undefined, undefined, undefined, undefined, 350 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.groupid = "Clifftown";
    s.height = 600;
    fe [[ f ]]( s, us, cf, ( 39346.3, 10975.5, 851 ), ( 0, 330, 0 ), "trig_clifftown_pisces_guild_vo_combat", undefined, undefined, undefined, undefined, undefined, undefined, 500 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 600;
    fe [[ f ]]( s, us, cf, ( 41458.3, 4315.53, 1030.03 ), ( 6.42, 330.13, 1.16 ), "trig_clifftown_pisces_guild_vo_initial_encounter", undefined, undefined, undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 600;
    fe [[ f ]]( s, us, cf, ( 38782.3, 5101.53, 798.03 ), ( 6.42, 330.13, 1.16 ), "trig_clifftown_pisces_guild_vo_initial_encounter", undefined, undefined, undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 264, 432, 452 );
    s._size_min = ( 256, -24, 234 );
    s.groupid = "Grotto_Triggers";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 38424, 9512, -64 ), ( 0, 250.6, 0 ), "trig_clifftown_grotto_pisces_karma_scene" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 264, 432, 852 );
    s._size_min = ( 256, 532, 234 );
    s.groupid = "Grotto_Triggers";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 39111, 8264, -65 ), ( 0, 222.4, 0 ), "trig_clifftown_grotto_pisces_karma_scene" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 1250, 432, 288 );
    s._size_min = ( 256, 532, 132 );
    s.groupid = "Grotto_Triggers";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 40262, 9231, 540 ), ( 0, 222.4, 0 ), "trig_clifftown_grotto_pisces_karma_scene" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.name = "karma_location";
    fe [[ f ]]( s, us, cf, ( 40441, 8924, 62 ), ( 0, 137.7, 0 ), "pisces_karma_location" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.name = "karma_interact";
    fe [[ f ]]( s, us, cf, ( 40514, 8933, 63 ), ( 0, 137.7, 0 ), "pisces_karma_grotto_interact" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.var_f9e656b1894a327c = "0";
    fe [[ f ]]( s, us, cf, ( 43335, 8723, 1348.83 ), ( 0, 0, 0 ), "cspf_0_auto6512311551678863071", "cspf_0_auto4024752627332134157", undefined, undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.height = 100;
    s.var_f9e656b1894a327c = "0";
    fe [[ f ]]( s, us, cf, ( 47250, 7936.75, 1311.61 ), ( 0, 343.58, 0 ), "pisces_intro_a_breadcrumb_start", "cspf_0_auto3233523344082867778", undefined, undefined, undefined, undefined, undefined, 400 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.var_f9e656b1894a327c = "0";
    fe [[ f ]]( s, us, cf, ( 45749, 8476, 1357.46 ), ( 0, 0, 0 ), "cspf_0_auto3233523344082867778", "cspf_0_auto6512311551678863071", undefined, undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.name = "grotto_ascender";
    fe [[ f ]]( s, us, cf, ( 40289, 9192, 1062 ), ( 0, 137.7, 0 ), "pisces_grotto_ascender" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.height = 125;
    s.var_f9e656b1894a327c = "0";
    fe [[ f ]]( s, us, cf, ( 41969, 3548, 1217.68 ), ( 0, 0, 0 ), "pisces_intro_b_breadcrumb_start", "cspf_0_auto16017326389449401432", undefined, undefined, undefined, undefined, undefined, 450 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.height = 100;
    s.name = "script_struct_breadcrumb";
    s.var_f9e656b1894a327c = "0";
    fe [[ f ]]( s, us, cf, ( 41219, 4557, 1374.43 ), ( 0, 0, 0 ), "cspf_0_auto16017326389449401432", "cspf_0_auto7575689208799231198", undefined, undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.height = 100;
    s.var_f9e656b1894a327c = "0";
    fe [[ f ]]( s, us, cf, ( 38355, 4607, 1113.44 ), ( 0, 0, 0 ), "pisces_intro_c_breadcrumb_start", "cspf_0_auto13240604267475762562", undefined, undefined, undefined, undefined, undefined, 350 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.height = 100;
    s.var_f9e656b1894a327c = "0";
    fe [[ f ]]( s, us, cf, ( 39147, 5852, 1142.89 ), ( 0, 0, 0 ), "cspf_0_auto13240604267475762562", "cspf_0_auto147302571797651414", undefined, undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.height = 100;
    s.var_f9e656b1894a327c = "0";
    fe [[ f ]]( s, us, cf, ( 41626, 6209, 1370.54 ), ( 0, 0, 0 ), "cspf_0_auto7575689208799231198", "cspf_0_auto15421835449065650936", undefined, undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 198, 432, 436 );
    s._size_min = ( 618, 406, 234 );
    s.groupid = "Grotto_Triggers_2";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 40090, 10790, -63 ), ( 0, 250.6, 0 ), "trig_clifftown_grotto_pisces_grotto_entrance" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.height = 1600;
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 40118, 9189, -139.39 ), ( 0, 0, 0 ), "pisces_intro_b", undefined, undefined, undefined, undefined, undefined, undefined, 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.height = 1600;
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 40118, 9189, -139.39 ), ( 0, 0, 0 ), "pisces_intro_a", undefined, undefined, undefined, undefined, undefined, undefined, 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.height = 1600;
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 40118, 9189, -158.39 ), ( 0, 0, 0 ), "pisces_intro_c", undefined, undefined, undefined, undefined, undefined, undefined, 4000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.var_f9e656b1894a327c = "0";
    fe [[ f ]]( s, us, cf, ( 40127, 8631, 996.18 ), ( 0, 0, 0 ), "cspf_0_auto4024752627332134157", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.var_f9e656b1894a327c = "0";
    fe [[ f ]]( s, us, cf, ( 40127, 8631, 996.18 ), ( 0, 0, 0 ), "cspf_0_auto15421835449065650936", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.var_f9e656b1894a327c = "0";
    fe [[ f ]]( s, us, cf, ( 40127, 8631, 996.18 ), ( 0, 0, 0 ), "cspf_0_auto147302571797651414", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 438, 580, 340 );
    s._size_min = ( 256, 580, 234 );
    fe [[ f ]]( s, us, cf, ( 49734, 7438, 1161 ), ( 0, 165.6, 0 ), "s_pisces_cushion" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 390, 706, 594 );
    s._size_min = ( 368, -24, 234 );
    s.groupid = "Grotto_Triggers_2";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 38244, 9544, -64 ), ( 0, 260.6, 0 ), "trig_clifftown_grotto_pisces_grotto_entrance" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 390, 432, 852 );
    s._size_min = ( 436, 532, 234 );
    s.groupid = "Grotto_Triggers_2";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 39111, 8264, -65 ), ( 0, 222.4, 0 ), "trig_clifftown_grotto_pisces_grotto_entrance" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 1250, 432, 180 );
    s._size_min = ( 256, 532, 132 );
    s.groupid = "Grotto_Triggers_2";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 40262, 9231, 680 ), ( 0, 222.4, 0 ), "trig_clifftown_grotto_pisces_grotto_entrance" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 198, 168, 174 );
    s._size_min = ( 282, 212, 114 );
    s.groupid = "Grotto_Triggers_2";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 40921, 10067, 185 ), ( 0, 205.6, 0 ), "trig_clifftown_grotto_pisces_grotto_entrance" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.name = "pisces_aquaduct_respawn";
    fe [[ f ]]( s, us, cf, ( 43815, 969, 1476.85 ), ( 0, 272.9, 0 ), "pisces_aquaduct_respawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.name = "pisces_aquaduct_respawn";
    fe [[ f ]]( s, us, cf, ( 43899, 977, 1481.29 ), ( 0, 272.9, 0 ), "pisces_aquaduct_respawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.name = "pisces_aquaduct_respawn";
    fe [[ f ]]( s, us, cf, ( 43699, 953, 1465.94 ), ( 0, 272.9, 0 ), "pisces_aquaduct_respawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.name = "pisces_aquaduct_respawn";
    fe [[ f ]]( s, us, cf, ( 43580, 940, 1461.44 ), ( 0, 272.9, 0 ), "pisces_aquaduct_respawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 162, 98, 306 );
    s._size_min = ( 60, 190, 92 );
    s.groupid = "Grotto_Triggers";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 40431, 9097.5, 652.5 ), ( 0, 222.4, 0 ), "trig_clifftown_grotto_pisces_karma_scene" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    fe [[ f ]]( s, us, cf, ( 47454.8, 8208.45, 1727.1 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 200;
    fe [[ f ]]( s, us, cf, ( 40235.3, 9231.53, 919 ), ( 0, 330, 0 ), "pisces_ascender_toast_trigger", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.name = "karma_location_check";
    fe [[ f ]]( s, us, cf, ( 40382, 9141, 62 ), ( 0, 137.7, 0 ), "pisces_karma_location_los_check", undefined, undefined, undefined, undefined, undefined, undefined, 5000 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_pisces_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 400;
    fe [[ f ]]( s, us, cf, ( 40344, 8938.5, -129 ), ( 0, 0, 0 ), "trig_clifftown_grotto_pisces_karma_greet", undefined, undefined, undefined, undefined, undefined, undefined, 750 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q2_ob_activity_pisces_cs
// Params 0, eflags: 0x4
// Checksum 0xce05450d, Offset: 0x3f73
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q2_ob_activity_pisces_cs
// Params 0
// Checksum 0x79ed43a9, Offset: 0x3f7d
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q2_ob_activity_pisces_cs" );
}

