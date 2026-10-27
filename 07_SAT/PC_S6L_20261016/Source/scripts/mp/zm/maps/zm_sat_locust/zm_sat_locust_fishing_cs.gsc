// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_fishing_cs.gsc  (hash_0562cb6cc0bbf029.gscc) (size: 8444 Bytes / 0x20fc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf6471a1d (4131854877)
// size ...... 8444 (0x20fc)
// includes .. 3   (offset: 0x1bac)
// strings ... 54  (offset: 0x1bc4)
// dev strs .. 0   (offset: 0x20fc)
// exports ... 9   (offset: 0x1814)
// cseg ...... 0x5cb + 0x1249 (0x1814)
// imports ... 20  (offset: 0x197c)
// animtree1 . 0   (offset: 0x20fc)
// animtree2 . 0   (offset: 0x20fc)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_locust_fishing_cs;

// Namespace zm_sat_locust_fishing_cs
// Params 0, eflags: 0x5
// Checksum 0x163be626, Offset: 0x5e9
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_locust_fishing_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_locust_fishing_cs
// Params 0, eflags: 0x4
// Checksum 0x9bedc3e0, Offset: 0x60a
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_locust_fishing_cs
// Params 0, eflags: 0x4
// Checksum 0x1ed6100c, Offset: 0x61b
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_locust_fishing_cs
// Params 2
// Checksum 0xae3f4645, Offset: 0x62c
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_locust_fishing_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_locust_fishing_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_locust_fishing_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_locust_fishing_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_locust_fishing_cs
// Params 3, eflags: 0x4
// Checksum 0x9d54a4c3, Offset: 0x6b4
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_locust_fishing_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_locust_fishing_cs" );
}

// Namespace zm_sat_locust_fishing_cs
// Params 3, eflags: 0x4
// Checksum 0xf811cff0, Offset: 0x72e
// Size: 0x10c6
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_1";
    s.name = "fishing_pole_stand";
    fe [[ f ]]( s, us, cf, ( 3192, -194, 266 ), ( 0, 270, 0 ), "uranium", "cspf_0_auto16179481162771510956", "fishing_pole_stand_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_1";
    s.name = "fishing_hole";
    fe [[ f ]]( s, us, cf, ( 2432, -260, 52 ), ( 0, 87.17, 0 ), "cspf_0_auto16179481162771510956", "cspf_0_auto12124123707667285207", "fishing_hole_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_2";
    s.name = "fishing_pole_stand";
    fe [[ f ]]( s, us, cf, ( 1435, 3753, 145 ), ( 0, 121.5, 0 ), "uranium", "cspf_0_auto1759857023457558055", "fishing_pole_stand_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_2";
    s.name = "fishing_hole";
    fe [[ f ]]( s, us, cf, ( 1791.99, 3972.81, 48.39 ), ( 0, 297.17, 0 ), "cspf_0_auto1759857023457558055", "cspf_0_auto6939212164368877474", "fishing_hole_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_3";
    s.name = "fishing_pole_stand";
    fe [[ f ]]( s, us, cf, ( 2890, 5669, 300 ), ( 0, 90, 0 ), undefined, "cspf_0_auto12315304872617156768", "fishing_pole_stand_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_3";
    s.name = "fishing_hole";
    fe [[ f ]]( s, us, cf, ( 3488.05, 5682.11, 48 ), ( 0, 276.04, 0 ), "cspf_0_auto12315304872617156768", "cspf_0_auto3480882103521557662", "fishing_hole_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_4";
    s.name = "fishing_pole_stand";
    fe [[ f ]]( s, us, cf, ( 8117, 2121, 144 ), ( 0, 73.8, 0 ), undefined, "cspf_0_auto4265627134911946625", "fishing_pole_stand_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_4";
    s.name = "fishing_hole";
    fe [[ f ]]( s, us, cf, ( 8490.5, 2042, 45.5 ), ( 0, 268.63, 0 ), "cspf_0_auto4265627134911946625", "cspf_0_auto3010087681315522507", "fishing_hole_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_1";
    s.name = "fishing_loot_loc";
    fe [[ f ]]( s, us, cf, ( 3236, -192, 224 ), ( 0, 179.07, 0 ), "cspf_0_auto12124123707667285207", undefined, "fishing_loot_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_2";
    s.name = "fishing_loot_loc";
    fe [[ f ]]( s, us, cf, ( 1400, 3732, 108 ), ( 0, 32, 0 ), "cspf_0_auto6939212164368877474", undefined, "fishing_loot_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_3";
    s.name = "fishing_loot_loc";
    fe [[ f ]]( s, us, cf, ( 2832, 5672, 256 ), ( 0, 0, 0 ), "cspf_0_auto3480882103521557662", undefined, "fishing_loot_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.name = "fishing_pole_pickup_1";
    fe [[ f ]]( s, us, cf, ( 6899, 2420, 96 ), ( 343, 308, 0 ), undefined, undefined, "fishing_pole_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_4";
    s.name = "fishing_loot_loc";
    fe [[ f ]]( s, us, cf, ( 8077, 2136, 104 ), ( 0, 344.8, 0 ), "cspf_0_auto3010087681315522507", undefined, "fishing_loot_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_9";
    s.name = "fishing_pole_stand";
    fe [[ f ]]( s, us, cf, ( -234, 7075, 309 ), ( 0, 29.9, 0 ), undefined, "cspf_0_auto10156857960501367171", "fishing_pole_stand_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "rod_barrel";
    s.name = "fishing_pole_barrel";
    fe [[ f ]]( s, us, cf, ( 1340, 5712, 256 ), ( 0, 140, 0 ), undefined, "cspf_0_auto7328036621744169516", "fishing_pole_barrel" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_9";
    s.name = "fishing_hole";
    fe [[ f ]]( s, us, cf, ( 150.4, 6642.73, 55 ), ( 0, 222.07, 0 ), "cspf_0_auto10156857960501367171", "cspf_0_auto5775653293653074099", "fishing_hole_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_9";
    s.name = "fishing_loot_loc";
    fe [[ f ]]( s, us, cf, ( -260, 7122, 264 ), ( 0, 302.68, 0 ), "cspf_0_auto5775653293653074099", undefined, "fishing_loot_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_10";
    s.name = "fishing_pole_stand";
    fe [[ f ]]( s, us, cf, ( 2829, 4059, 144 ), ( 0, 240, 0 ), undefined, "cspf_0_auto1819920283794292889", "fishing_pole_stand_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_10";
    s.name = "fishing_hole";
    fe [[ f ]]( s, us, cf, ( 2530.11, 4221.4, 53 ), ( 0, 61.71, 0 ), "cspf_0_auto1819920283794292889", "cspf_0_auto15618098866267024858", "fishing_hole_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_10";
    s.name = "fishing_loot_loc";
    fe [[ f ]]( s, us, cf, ( 2875.65, 4030.35, 104 ), ( 0, 150, 0 ), "cspf_0_auto15618098866267024858", undefined, "fishing_loot_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_11";
    s.name = "fishing_pole_stand";
    fe [[ f ]]( s, us, cf, ( 5721, 776, 144 ), ( 0, 352.5, 0 ), undefined, "cspf_0_auto8750979823027435460", "fishing_pole_stand_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_11";
    s.name = "fishing_hole";
    fe [[ f ]]( s, us, cf, ( 5678, 268, 50 ), ( 0, 188.63, 0 ), "cspf_0_auto8750979823027435460", "cspf_0_auto15905209470596221365", "fishing_hole_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_11";
    s.name = "fishing_loot_loc";
    fe [[ f ]]( s, us, cf, ( 5728.87, 817, 104 ), ( 0, 260.8, 0 ), "cspf_0_auto15905209470596221365", undefined, "fishing_loot_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "rod_barrel";
    s.name = "barrel_rod_1";
    fe [[ f ]]( s, us, cf, ( 1331, 5704, 256 ), ( 300.06, 237.41, -8.23 ), "cspf_0_auto7328036621744169516", undefined, "in_barrel_fishing_rod" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "rod_barrel";
    s.name = "barrel_rod_4";
    fe [[ f ]]( s, us, cf, ( 1335, 5715, 256 ), ( 341.39, 212.97, 0.22 ), "cspf_0_auto7328036621744169516", undefined, "in_barrel_fishing_rod" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "rod_barrel";
    s.name = "barrel_rod_3";
    fe [[ f ]]( s, us, cf, ( 1346, 5712, 257 ), ( 346.68, 205.86, -12.08 ), "cspf_0_auto7328036621744169516", undefined, "in_barrel_fishing_rod" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "rod_barrel";
    s.name = "barrel_rod_1";
    fe [[ f ]]( s, us, cf, ( 1335, 5720, 257 ), ( 332.35, 125.45, 4.27 ), "cspf_0_auto7328036621744169516", undefined, "in_barrel_fishing_rod" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.name = "fishing_pole_pickup_2";
    fe [[ f ]]( s, us, cf, ( -560, 3019, 39 ), ( 342, 155, 0 ), undefined, undefined, "fishing_pole_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.name = "fishing_pole_pickup_3";
    fe [[ f ]]( s, us, cf, ( 2192, 7938, 496 ), ( 343.95, 121.53, 1.76 ), undefined, undefined, "fishing_pole_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.name = "fishing_pole_pickup_4";
    fe [[ f ]]( s, us, cf, ( 4558, 4156, 159 ), ( 344, 145, 1 ), undefined, undefined, "fishing_pole_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_5";
    s.name = "fishing_pole_stand";
    fe [[ f ]]( s, us, cf, ( 3760, 7063, 320 ), ( 0, 306.9, 0 ), undefined, "cspf_0_auto5744343634993142605", "fishing_pole_stand_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_5";
    s.name = "fishing_hole";
    fe [[ f ]]( s, us, cf, ( 3296, 6728, 56 ), ( 0, 132.07, 0 ), "cspf_0_auto5744343634993142605", "cspf_0_auto11205277596772442787", "fishing_hole_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_5";
    s.name = "fishing_loot_loc";
    fe [[ f ]]( s, us, cf, ( 3815.85, 7107.94, 283.74 ), ( 0, 210, 0 ), "cspf_0_auto11205277596772442787", undefined, "fishing_loot_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_6";
    s.name = "fishing_pole_stand";
    fe [[ f ]]( s, us, cf, ( 1915, 6342, 237 ), ( 0, 180, 0 ), undefined, "cspf_0_auto11342315957762791617", "fishing_pole_stand_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_6";
    s.name = "fishing_hole";
    fe [[ f ]]( s, us, cf, ( 1872, 6926.5, 54 ), ( 0, 7, 0 ), "cspf_0_auto11342315957762791617", "cspf_0_auto10820926921541090206", "fishing_hole_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_6";
    s.name = "fishing_loot_loc";
    fe [[ f ]]( s, us, cf, ( 1913, 6304.53, 192 ), ( 0, 90, 0 ), "cspf_0_auto10820926921541090206", undefined, "fishing_loot_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_7";
    s.name = "fishing_pole_stand";
    fe [[ f ]]( s, us, cf, ( 4509, 1076, 184 ), ( 0, 90, 0 ), "uranium", "cspf_0_auto11261705361182559018", "fishing_pole_stand_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_7";
    s.name = "fishing_hole";
    fe [[ f ]]( s, us, cf, ( 4889.25, 1043.92, 48 ), ( 0, 88.49, 0 ), "cspf_0_auto11261705361182559018", "cspf_0_auto6764659933052553218", "fishing_hole_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_7";
    s.name = "fishing_loot_loc";
    fe [[ f ]]( s, us, cf, ( 4459, 1076, 144 ), ( 0, 180, 0 ), "cspf_0_auto6764659933052553218", undefined, "fishing_loot_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_8";
    s.name = "fishing_pole_stand";
    fe [[ f ]]( s, us, cf, ( 4731, 2928, 218 ), ( 0, 90, 0 ), "uranium", "cspf_0_auto3891297379292984390", "fishing_pole_stand_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_8";
    s.name = "fishing_hole";
    fe [[ f ]]( s, us, cf, ( 5240, 2904, 48 ), ( 0, 96.63, 0 ), "cspf_0_auto3891297379292984390", "cspf_0_auto13169374740687791484", "fishing_hole_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_fishing_cs";
    s.groupid = "fishing_spot_8";
    s.name = "fishing_loot_loc";
    fe [[ f ]]( s, us, cf, ( 4688, 2928, 176 ), ( 0, 180, 0 ), "cspf_0_auto13169374740687791484", undefined, "fishing_loot_loc" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_locust_fishing_cs
// Params 0, eflags: 0x4
// Checksum 0x9ed8e1a7, Offset: 0x17fc
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_locust_fishing_cs
// Params 0
// Checksum 0x5f07798e, Offset: 0x1806
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_locust_fishing_cs" );
}

