// script_18124c938cffd6d3  (hash_18124c938cffd6d3.gscc) (size: 12100 Bytes / 0x2f44 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2561eca4 (627174564)
// size ...... 12100 (0x2f44)
// includes .. 3   (offset: 0x2830)
// strings ... 80  (offset: 0x2848)
// dev strs .. 0   (offset: 0x2f44)
// exports ... 9   (offset: 0x2498)
// cseg ...... 0x87f + 0x1c19 (0x2498)
// imports ... 20  (offset: 0x2600)
// animtree1 . 0   (offset: 0x2f44)
// animtree2 . 0   (offset: 0x2f44)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs;

// Namespace mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs
// Params 0, eflags: 0x5
// Checksum 0x7aedc40d, Offset: 0x89d
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs
// Params 0, eflags: 0x4
// Checksum 0xf6245eb9, Offset: 0x8be
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs
// Params 0, eflags: 0x4
// Checksum 0x731f8d55, Offset: 0x8cf
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs
// Params 2
// Checksum 0xc3f6db1c, Offset: 0x8e0
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs
// Params 3, eflags: 0x4
// Checksum 0xf09d399a, Offset: 0x968
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs" );
}

// Namespace mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs
// Params 3, eflags: 0x4
// Checksum 0x4f1cf29b, Offset: 0x9e2
// Size: 0x1a96
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 48424.2, -18364, 1724.13 ), ( 0, 308.2, 0 ), "cspf_0_auto131579091677510163", "cspf_0_auto12666553779155125661", undefined, undefined, undefined, undefined, undefined, undefined, 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 50709, -10701, 2642.29 ), ( 19.6, 262.08, -19.53 ), "pisces_vtol_spawn", "cspf_0_auto11231641194385032128", undefined, undefined, undefined, undefined, undefined, undefined, 60, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 49288, -15000, 1257.72 ), ( 4.6, 308.2, 0 ), "cspf_0_auto11231641194385032128", "cspf_0_auto131579091677510163", undefined, undefined, undefined, undefined, undefined, undefined, 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 47002.4, -19998.7, 1829.55 ), ( 0, 308.2, 0 ), "cspf_0_auto12666553779155125661", "cspf_0_auto4704085945111157064", undefined, undefined, undefined, undefined, undefined, undefined, 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.ishelistruct = 1;
    s.name = "pickup_spot_struct";
    fe [[ f ]]( s, us, cf, ( 46323.7, -22309, 1031.23 ), ( 0, 70.79, 0 ), "cspf_0_auto4704085945111157064", "cspf_0_auto17273140023662492068", "pickup_spot", undefined, undefined, undefined, undefined, undefined, 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.ishelistruct = 1;
    s.name = "pickup_left_struct";
    fe [[ f ]]( s, us, cf, ( 45632.7, -23157.6, 1387.4 ), ( 0, 247.1, 0 ), "cspf_0_auto17273140023662492068", "cspf_0_auto10884020138724592801", "pickup_left", undefined, undefined, undefined, undefined, undefined, 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.height = 700;
    s.ishelistruct = 1;
    s.name = "gas_station_start_struct";
    fe [[ f ]]( s, us, cf, ( 42913, -24140.3, 1234.12 ), ( 0, 247.1, 0 ), "cspf_0_auto10884020138724592801", "cspf_0_auto7751433745708785978", "gas_station_start", undefined, undefined, undefined, undefined, undefined, 30 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.name = "rocket_spawn";
    fe [[ f ]]( s, us, cf, ( 36345, -41204, 1295.6 ), ( 0, 0, 0 ), "pisces_rocket_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.height = 500;
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 40525, -25865.1, 1010.82 ), ( 0, 247.1, 0 ), "cspf_0_auto10292178592126956561", "cspf_0_auto18389762983913482971", undefined, undefined, undefined, undefined, undefined, undefined, 25 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.height = 500;
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 41189.2, -27406.7, 1021.21 ), ( 0, 247.1, 0 ), "cspf_0_auto18389762983913482971", "cspf_0_auto9053119515938167104", undefined, undefined, undefined, undefined, undefined, undefined, 10 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 41613.9, -27931.4, 1008.34 ), ( 0, 247.1, 0 ), "cspf_0_auto9053119515938167104", "cspf_0_auto1979841979808524302", undefined, undefined, undefined, undefined, undefined, undefined, 40 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.ishelistruct = 1;
    s.name = "gas_station_end_struct";
    fe [[ f ]]( s, us, cf, ( 42485.4, -28663.2, 1006.25 ), ( 0, 247.1, 0 ), "cspf_0_auto1979841979808524302", "cspf_0_auto5481813171828564359", "gas_station_end", undefined, undefined, undefined, undefined, undefined, 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 43465.6, -29467.5, 1255.45 ), ( 0, 247.1, 0 ), "cspf_0_auto5481813171828564359", "cspf_0_auto7953330526364039636", undefined, undefined, undefined, undefined, undefined, undefined, 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 45464.1, -29862.7, 2171.88 ), ( 0, 247.1, 0 ), "cspf_0_auto7953330526364039636", "cspf_0_auto13071376508586308533", undefined, undefined, undefined, undefined, undefined, undefined, 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 47724.2, -31142.7, 3091.01 ), ( 0, 247.1, 0 ), "cspf_0_auto13071376508586308533", "cspf_0_auto3905936771563309141", undefined, undefined, undefined, undefined, undefined, undefined, 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.ishelistruct = 1;
    s.name = "car_factory_start_struct";
    fe [[ f ]]( s, us, cf, ( 49320.5, -32144.7, 2868.13 ), ( 0, 247.1, 0 ), "cspf_0_auto3905936771563309141", "cspf_0_auto15906863051126525204", "car_factory_start", undefined, undefined, undefined, undefined, undefined, 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 50942.9, -33108, 2801.33 ), ( 0, 247.1, 0 ), "cspf_0_auto15906863051126525204", "cspf_0_auto10790957480824470938", undefined, undefined, undefined, undefined, undefined, undefined, 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.height = 850;
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 51258.8, -36761.3, 2735.75 ), ( 0, 247.1, 0 ), "cspf_0_auto11826771729839256036", "cspf_0_auto2003523794681340087", undefined, undefined, undefined, undefined, undefined, undefined, 25 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.name = "crash_location";
    fe [[ f ]]( s, us, cf, ( 36468, -41585, 1211.94 ), ( 0, 0, 0 ), "pisces_vtol_crash_location" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.name = "rocket_spawn";
    fe [[ f ]]( s, us, cf, ( 39331, -43809, 861.6 ), ( 0, 0, 0 ), "pisces_rocket_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.name = "rocket_spawn";
    fe [[ f ]]( s, us, cf, ( 37525, -43816, 861.6 ), ( 0, 0, 0 ), "pisces_rocket_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "lmg";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, us, cf, ( 45870, -31239.5, 2181.72 ), ( 6.24, 90.2, 1.61 ), "pisces_vtol_ride_cliff_spawnpoint", "cspf_0_auto3484445904068793313" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "rocketeer";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, us, cf, ( 47716.5, -30307, 2221.42 ), ( 359.62, 180.02, -1.24 ), "pisces_vtol_ride_cliff_spawnpoint", "cspf_0_auto109464378006121448" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s._size_max = ( 728, 1608, 1016 );
    s._size_min = ( 1188, 1020, 600 );
    s.var_5afd49978f924648 = "1";
    s.var_a8568d8e0b0b6076 = "1";
    s.var_3f3960eb7318312d = "1";
    s.default_goal_radius = "-1";
    s.height = 128;
    s.length = "128";
    s.script_stealthgroup = "-1";
    s.script_string = "sat_ob_ambient_pisces_spawnpoint";
    s.var_95e2cee7aca5aaae = "0";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 46402.5, -31109.5, 1712.5 ), ( 0, 314.31, 0 ), "pisces_vtol_ride_cliff_enc", "pisces_vtol_ride_cliff_spawnpoint", "noent_volume_ai_encounter_cs" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.name = "rocket_spawn";
    fe [[ f ]]( s, us, cf, ( 36419, -41741, 1248.6 ), ( 0, 0, 0 ), "pisces_rocket_spawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.name = "rocket_soldier_spawn";
    fe [[ f ]]( s, us, cf, ( 51424, -37391, 2507 ), ( 0, 132.5, 0 ), "pisces_rocket_soldier_spawn_02" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.name = "rocket_soldier_spawn";
    fe [[ f ]]( s, us, cf, ( 52080, -36568, 2606.25 ), ( 0, 132.5, 0 ), "pisces_rocket_soldier_spawn_02" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.name = "rocket_soldier_spawn";
    fe [[ f ]]( s, us, cf, ( 49451, -36705, 2467 ), ( 0, 312.5, 0 ), "pisces_rocket_soldier_spawn_02" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.name = "rocket_soldier_spawn";
    fe [[ f ]]( s, us, cf, ( 49123, -37170, 2467 ), ( 0, 312.5, 0 ), "pisces_rocket_soldier_spawn_02" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.name = "rocket_soldier_spawn";
    fe [[ f ]]( s, us, cf, ( 41260, -38577, 2023.97 ), ( 0, 298, 0 ), "pisces_rocket_soldier_spawn_03" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.name = "rocket_soldier_spawn";
    fe [[ f ]]( s, us, cf, ( 40565, -38543, 2056.33 ), ( 0, 298, 0 ), "pisces_rocket_soldier_spawn_03" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.height = 850;
    s.ishelistruct = 1;
    s.name = "car_factory_end_struct";
    fe [[ f ]]( s, us, cf, ( 49171.1, -38842.2, 2735.53 ), ( 0, 247.1, 0 ), "cspf_0_auto8458970740961203645", "cspf_0_auto14059003359090016235", "car_factory_end", undefined, undefined, undefined, undefined, undefined, 10 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 47269, -39018.5, 2735.87 ), ( 0, 247.1, 0 ), "cspf_0_auto14059003359090016235", "cspf_0_auto8281930406150691635", undefined, undefined, undefined, undefined, undefined, undefined, 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 45297.2, -39310, 2515.28 ), ( 0, 247.1, 0 ), "cspf_0_auto8281930406150691635", "cspf_0_auto1273970252160665491", undefined, undefined, undefined, undefined, undefined, undefined, 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 43995.6, -39717.6, 2306.59 ), ( 0, 247.1, 0 ), "cspf_0_auto1273970252160665491", "cspf_0_auto9286007000472246865", "wingsuit_toast", undefined, undefined, undefined, undefined, undefined, 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.ishelistruct = 1;
    s.name = "pre_vtol_explode_struct";
    fe [[ f ]]( s, us, cf, ( 42046.5, -40258.2, 2102.95 ), ( 0, 247.1, 0 ), "cspf_0_auto9286007000472246865", "cspf_0_auto2757709381512834578", "pre_vtol_explode", undefined, undefined, undefined, undefined, undefined, 55 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    fe [[ f ]]( s, us, cf, ( 46131, -22302, 748.46 ), ( 0, 0, 0 ), "pisces_vtol_pickup_location" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 41064.9, -40593.8, 1945.93 ), ( 0, 247.1, 0 ), "cspf_0_auto2757709381512834578", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 60 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.name = "rocket_soldier_spawn";
    fe [[ f ]]( s, us, cf, ( 41905, -25518, 464 ), ( 0, 107.1, 0 ), "pisces_rocket_soldier_spawn_01" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.name = "rocket_soldier_spawn";
    fe [[ f ]]( s, us, cf, ( 41618, -25955, 464 ), ( 0, 193.4, 0 ), "pisces_rocket_soldier_spawn_01" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "soldier";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, us, cf, ( 45901.5, -31344.5, 2181.11 ), ( 357.69, 89.4, 5.36 ), "pisces_vtol_ride_cliff_spawnpoint", "cspf_0_auto3484445904068793313" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.height = 500;
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 41278.5, -24685.9, 991.33 ), ( 0, 247.1, 0 ), "cspf_0_auto7751433745708785978", "cspf_0_auto10292178592126956561", undefined, undefined, undefined, undefined, undefined, undefined, 25 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "soldier";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, us, cf, ( 47784.5, -30373.5, 2219.33 ), ( 357.85, 180.97, -14.51 ), "pisces_vtol_ride_cliff_spawnpoint", "cspf_0_auto109464378006121448" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "dmr";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, us, cf, ( 46104.5, -30153, 1687.99 ), ( 12.74, 185.32, 17.16 ), "pisces_vtol_ride_cliff_spawnpoint", "cspf_0_auto1986123830993722221" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "soldier";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, us, cf, ( 46015, -30082.5, 1650.11 ), ( 10.85, 183.88, 12.11 ), "pisces_vtol_ride_cliff_spawnpoint", "cspf_0_auto1986123830993722221" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "sniper";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, us, cf, ( 46100.5, -30103, 1673.33 ), ( 10.89, 185.14, 15.29 ), "pisces_vtol_ride_cliff_spawnpoint", "cspf_0_auto1986123830993722221" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.groupid = "cliff_encounter";
    s.name = "goal";
    fe [[ f ]]( s, us, cf, ( 47682.5, -30385.5, 2220.14 ), ( 353.26, 357.53, -4.75 ), "cspf_0_auto109464378006121448", undefined, undefined, undefined, undefined, undefined, undefined, 400 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.groupid = "cliff_encounter";
    s.name = "goal";
    fe [[ f ]]( s, us, cf, ( 46003, -31246.5, 2183.48 ), ( 347.23, 358.04, 8.8 ), "cspf_0_auto3484445904068793313", undefined, undefined, undefined, undefined, undefined, undefined, 400 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.groupid = "cliff_encounter";
    s.name = "goal";
    fe [[ f ]]( s, us, cf, ( 45944.5, -30114.5, 1646.41 ), ( 349.19, 355.15, -9.25 ), "cspf_0_auto1986123830993722221", undefined, undefined, undefined, undefined, undefined, undefined, 400 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.maxspawns = "1";
    s.minspawns = "1";
    s.var_6324368dbfa7058a = "3000";
    s.script_stealthgroup = "-1";
    s.spawn_filter = "custom";
    s.spawn_filter_custom = "rocketeer";
    s.variantname = "ai_encounter_spawnpoint";
    fe [[ f ]]( s, us, cf, ( 46125, -31102, 2198.53 ), ( 4.33, 89.92, -3.34 ), "pisces_vtol_ride_cliff_spawnpoint", "cspf_0_auto3484445904068793313" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.name = "ability_crate";
    fe [[ f ]]( s, us, cf, ( 47207, -21858.5, 906.47 ), ( 0, 45.01, 0 ), "pisces_step_03_vtol_ability_crate" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.height = 850;
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 52077.2, -34968.9, 2778.82 ), ( 0, 247.1, 0 ), "cspf_0_auto10790957480824470938", "cspf_0_auto11826771729839256036", undefined, undefined, undefined, undefined, undefined, undefined, 35 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.name = "pisces_vtol_surfing_respawn";
    fe [[ f ]]( s, us, cf, ( 44487.8, -20878.1, 576.71 ), ( 0, 334.5, 0 ), "pisces_vtol_surfing_respawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.name = "pisces_vtol_surfing_respawn";
    fe [[ f ]]( s, us, cf, ( 44406.9, -21029.3, 576.75 ), ( 0, 334.5, 0 ), "pisces_vtol_surfing_respawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.name = "pisces_vtol_surfing_respawn";
    fe [[ f ]]( s, us, cf, ( 44554.1, -20700.1, 579.21 ), ( 0, 334.5, 0 ), "pisces_vtol_surfing_respawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.name = "pisces_vtol_surfing_respawn";
    fe [[ f ]]( s, us, cf, ( 44637.1, -20556.7, 567.46 ), ( 0, 334.5, 0 ), "pisces_vtol_surfing_respawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.height = 850;
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 49968, -38044.5, 2739.83 ), ( 0, 247.1, 0 ), "cspf_0_auto2003523794681340087", "cspf_0_auto8458970740961203645", "medium_damage", undefined, undefined, undefined, undefined, undefined, 10 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.name = "pisces_mid_vtol_surfing_respawn";
    fe [[ f ]]( s, us, cf, ( 43143.8, -34938.1, 1921.34 ), ( 0, 334.5, 0 ), "pisces_mid_vtol_surfing_respawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.name = "pisces_mid_vtol_surfing_respawn";
    fe [[ f ]]( s, us, cf, ( 43062.9, -35089.3, 1937.46 ), ( 0, 334.5, 0 ), "pisces_mid_vtol_surfing_respawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.name = "pisces_mid_vtol_surfing_respawn";
    fe [[ f ]]( s, us, cf, ( 43210.1, -34760.1, 1907.12 ), ( 0, 334.5, 0 ), "pisces_mid_vtol_surfing_respawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.name = "pisces_mid_vtol_surfing_respawn";
    fe [[ f ]]( s, us, cf, ( 43293.1, -34616.7, 1876.26 ), ( 0, 334.5, 0 ), "pisces_mid_vtol_surfing_respawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.name = "pisces_end_vtol_surfing_respawn";
    fe [[ f ]]( s, us, cf, ( 31341.2, -40563.1, 1094.22 ), ( 0, 299.5, 0 ), "pisces_end_vtol_surfing_respawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.name = "pisces_end_vtol_surfing_respawn";
    fe [[ f ]]( s, us, cf, ( 31188.2, -40640.5, 1088.16 ), ( 0, 299.5, 0 ), "pisces_end_vtol_surfing_respawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.name = "pisces_end_vtol_surfing_respawn";
    fe [[ f ]]( s, us, cf, ( 31497.6, -40455.3, 1095.48 ), ( 0, 299.5, 0 ), "pisces_end_vtol_surfing_respawn" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs";
    s.name = "pisces_end_vtol_surfing_respawn";
    fe [[ f ]]( s, us, cf, ( 31647.8, -40385.5, 1097.01 ), ( 0, 299.5, 0 ), "pisces_end_vtol_surfing_respawn" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs
// Params 0, eflags: 0x4
// Checksum 0x7cd2aa03, Offset: 0x2480
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs
// Params 0
// Checksum 0x32cee4d7, Offset: 0x248a
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q4_ob_activity_pisces_vtol_path_01_cs" );
}

