// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_script_living_world_create_script.gsc  (hash_59f188894c646c85.gscc) (size: 8711 Bytes / 0x2207 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x57cbe85c (1472981084)
// size ...... 8711 (0x2207)
// includes .. 3   (offset: 0x1d03)
// strings ... 55  (offset: 0x1d1b)
// dev strs .. 0   (offset: 0x2207)
// exports ... 9   (offset: 0x18d7)
// cseg ...... 0x3fb + 0x14dc (0x18d7)
// imports ... 22  (offset: 0x1a3f)
// animtree1 . 0   (offset: 0x2207)
// animtree2 . 0   (offset: 0x2207)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_mantis_script_living_world_create_script;

// Namespace zm_sat_mantis_script_living_world_create_script
// Params 0, eflags: 0x5
// Checksum 0x68e1e73e, Offset: 0x419
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_mantis_script_living_world_create_script", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_mantis_script_living_world_create_script
// Params 0, eflags: 0x4
// Checksum 0xb35ffcfa, Offset: 0x43a
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_mantis_script_living_world_create_script
// Params 0, eflags: 0x4
// Checksum 0x36642f16, Offset: 0x44b
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_mantis_script_living_world_create_script
// Params 2
// Checksum 0x868d795f, Offset: 0x45c
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_mantis_script_living_world_create_script" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_mantis_script_living_world_create_script" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_mantis_script_living_world_create_script" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_mantis_script_living_world_create_script" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_mantis_script_living_world_create_script
// Params 3, eflags: 0x4
// Checksum 0xb5e69bd9, Offset: 0x4e4
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_mantis_script_living_world_create_script" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_mantis_script_living_world_create_script" );
}

// Namespace zm_sat_mantis_script_living_world_create_script
// Params 3, eflags: 0x4
// Checksum 0xd18be9c9, Offset: 0x55e
// Size: 0x1359
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.script_string = "living_world_transition_check";
    fe [[ f ]]( s, us, cf, ( 55690.3, -30779.2, -96.67 ), ( 0, 0, 0 ), "lw_struct_1_check", undefined, undefined, undefined, undefined, undefined, undefined, 95 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.name = "03_f";
    s.script_count = int( 3 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    s.variantname = "livingworld_struct";
    fe [[ f ]]( s, us, cf, ( 56417.6, -30576.7, -123.23 ), ( 0, 292.43, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 125 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.name = "02_f";
    s.script_count = int( 2 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_multi_eating_corpse_zmb";
    s.variantname = "livingworld_struct";
    fe [[ f ]]( s, us, cf, ( 55090.2, -30711.7, -122.05 ), ( 0, 115.61, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 115 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.name = "05_f";
    s.script_count = int( 5 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_multi_eating_corpse_zmb";
    s.variantname = "livingworld_struct";
    fe [[ f ]]( s, us, cf, ( 56592.2, -31292, -121 ), ( 0, 354.63, 0 ), "zm_living_world", "lv_check_05" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.script_string = "living_world_transition_check";
    fe [[ f ]]( s, us, cf, ( 56550.9, -31379.8, -121 ), ( 0, 0, 0 ), "lv_check_05", undefined, undefined, undefined, undefined, undefined, undefined, 115 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.name = "06_f";
    s.script_count = int( 6 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    s.variantname = "livingworld_struct";
    fe [[ f ]]( s, us, cf, ( 56549.5, -32322.9, -126.34 ), ( 0, 153.42, 0 ), "zm_living_world", "lv_check_06" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.script_string = "living_world_transition_check";
    fe [[ f ]]( s, us, cf, ( 56582.1, -32248.1, -117.66 ), ( 0, 51.5, 0 ), "lv_check_06", undefined, undefined, undefined, undefined, undefined, undefined, 80 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.name = "08_f";
    s.script_count = int( 8 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    s.variantname = "livingworld_struct";
    fe [[ f ]]( s, us, cf, ( 55321.3, -29545.4, -124.12 ), ( 0, 28.3, 0 ), "zm_living_world", "lv_check_08" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.script_string = "living_world_transition_check";
    fe [[ f ]]( s, us, cf, ( 54762.7, -29955.7, -111.36 ), ( 0, 0, 0 ), "lv_check_09", undefined, undefined, undefined, undefined, undefined, undefined, 130 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.script_string = "living_world_transition_check";
    fe [[ f ]]( s, us, cf, ( 55371.2, -29660.2, -111.36 ), ( 0, 0, 0 ), "lv_check_08", undefined, undefined, undefined, undefined, undefined, undefined, 115 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.name = "09_f";
    s.script_count = int( 9 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_multi_eating_corpse_zmb";
    s.variantname = "livingworld_struct";
    fe [[ f ]]( s, us, cf, ( 54726.8, -29938.4, -125.37 ), ( 0, 66.43, 0 ), "zm_living_world", "lv_check_09" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.name = "10_f";
    s.script_count = int( 10 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_crushed_zmb";
    s.variantname = "livingworld_struct";
    fe [[ f ]]( s, us, cf, ( 55217.5, -30434.6, -120 ), ( 0, 11.95, 0 ), "zm_living_world", "lv_check_10" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.script_string = "living_world_transition_check";
    fe [[ f ]]( s, us, cf, ( 55265.4, -30434.8, -121 ), ( 0, 0, 0 ), "lv_check_10", undefined, undefined, undefined, undefined, undefined, undefined, 90 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.name = "11_f";
    s.script_count = int( 11 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    s.variantname = "livingworld_struct";
    fe [[ f ]]( s, us, cf, ( 55471.9, -30428.1, 15.5 ), ( 0, 303.78, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 130 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.name = "12_f";
    s.script_count = int( 12 );
    s.script_linkname = "future_street_crushed_under_truck";
    s.script_linkto = "future_street_crushed_under_truck";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_crushed_zmb";
    s.variantname = "livingworld_struct";
    fe [[ f ]]( s, us, cf, ( 54693.6, -32087.2, -132.53 ), ( 0, 67.88, 0 ), "zm_living_world", "lv_check_12" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.script_string = "living_world_transition_check";
    fe [[ f ]]( s, us, cf, ( 54715.5, -32044, -132.63 ), ( 0, 0, 0 ), "lv_check_12", undefined, undefined, undefined, undefined, undefined, undefined, 90 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.name = "13_f";
    s.script_count = int( 13 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_multi_eating_corpse_zmb";
    s.variantname = "livingworld_struct";
    fe [[ f ]]( s, us, cf, ( 54734.6, -32804.3, -123.87 ), ( 0, 239.04, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 115 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.name = "14_f";
    s.script_chance = float( 100 );
    s.script_count = int( 14 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_crushed_zmb";
    s.variantname = "livingworld_struct";
    fe [[ f ]]( s, us, cf, ( 53837.1, -32569.6, -124 ), ( 0, 38.22, 0 ), "zm_living_world", "lv_check_14" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.script_string = "living_world_transition_check";
    fe [[ f ]]( s, us, cf, ( 53863.8, -32544, -124 ), ( 0, 0, 0 ), "lv_check_14", undefined, undefined, undefined, undefined, undefined, undefined, 90 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.name = "15_p";
    s.script_count = int( 15 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_chair_zmb";
    s.variantname = "livingworld_struct";
    fe [[ f ]]( s, us, cf, ( 77682.3, -30342.9, 15 ), ( 0, 104.91, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.name = "16_p";
    s.script_count = int( 16 );
    s.script_linkname = "past_greenhouse_ground_floor";
    s.script_linkto = "past_greenhouse_ground_floor";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_chair_zmb";
    s.variantname = "livingworld_struct";
    fe [[ f ]]( s, us, cf, ( 77713.5, -30399.7, -121 ), ( 0, 104.91, 0 ), "zm_living_world", "lv_check_16" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.script_string = "living_world_transition_check";
    fe [[ f ]]( s, us, cf, ( 77764.9, -30417.6, -121 ), ( 0, 0, 0 ), "lv_check_16", undefined, undefined, undefined, undefined, undefined, undefined, 70 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.name = "18_p";
    s.script_count = int( 18 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_multi_eating_corpse_zmb";
    s.variantname = "livingworld_struct";
    fe [[ f ]]( s, us, cf, ( 77592.1, -29482.8, -129.12 ), ( 0, 7.08, 0 ), "zm_living_world", "lv_check_18" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.script_string = "living_world_transition_check";
    fe [[ f ]]( s, us, cf, ( 77589.5, -29528.9, -129.18 ), ( 0, 0, 0 ), "lv_check_18", undefined, undefined, undefined, undefined, undefined, undefined, 115 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.name = "19_p";
    s.script_count = int( 19 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_chair_zmb";
    s.variantname = "livingworld_struct";
    fe [[ f ]]( s, us, cf, ( 77081.2, -30187.7, -127.29 ), ( 0, 18, 0 ), "zm_living_world", "lv_check_19" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.name = "01_f";
    s.script_count = int( 1 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    s.variantname = "livingworld_struct";
    fe [[ f ]]( s, us, cf, ( 55688.9, -30638.3, -122.25 ), ( 0, 351.89, 0 ), "zm_living_world", "lw_struct_1_check" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.script_string = "living_world_transition_check";
    fe [[ f ]]( s, us, cf, ( 77087.5, -30209.6, -126.95 ), ( 0, 0, 0 ), "lv_check_19", undefined, undefined, undefined, undefined, undefined, undefined, 80 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.name = "20_p";
    s.script_count = int( 20 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_crushed_zmb";
    s.variantname = "livingworld_struct";
    fe [[ f ]]( s, us, cf, ( 77609, -30714.2, -122.25 ), ( 0, 12.69, 0 ), "zm_living_world", "lv_check_20" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.script_string = "living_world_transition_check";
    fe [[ f ]]( s, us, cf, ( 77640.6, -30701, -122.49 ), ( 0, 0, 0 ), "lv_check_20", undefined, undefined, undefined, undefined, undefined, undefined, 90 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.name = "21_p";
    s.script_count = int( 21 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    s.variantname = "livingworld_struct";
    fe [[ f ]]( s, us, cf, ( 78566.1, -30577.2, -125.88 ), ( 0, 264.45, 0 ), "zm_living_world", "lv_check_21" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.script_string = "living_world_transition_check";
    fe [[ f ]]( s, us, cf, ( 78490.3, -30562, -125.78 ), ( 0, 0, 0 ), "lv_check_21", undefined, undefined, undefined, undefined, undefined, undefined, 95 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.name = "22_p";
    s.script_count = int( 22 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_undr_low_obj_zmb";
    s.variantname = "livingworld_struct";
    fe [[ f ]]( s, us, cf, ( 78725.9, -31475.2, -121 ), ( 0, 321.42, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 85 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.name = "23_p";
    s.script_count = int( 23 );
    s.script_linkname = "past_orangehouse_upper_floor";
    s.script_linkto = "past_orangehouse_upper_floor";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_undr_low_obj_zmb";
    s.variantname = "livingworld_struct";
    fe [[ f ]]( s, us, cf, ( 78677.9, -31495.1, 15 ), ( 0, 235.91, 0 ), "zm_living_world", undefined, undefined, undefined, undefined, undefined, undefined, 85 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.name = "24_p";
    s.script_count = int( 24 );
    s.script_linkname = "past_orangehouse_upper_floor";
    s.script_linkto = "past_orangehouse_upper_floor";
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_chair_zmb";
    s.variantname = "livingworld_struct";
    fe [[ f ]]( s, us, cf, ( 78756.4, -31691.5, 15 ), ( 0, 99.66, 0 ), "zm_living_world", "lv_check_24" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.script_string = "living_world_transition_check";
    fe [[ f ]]( s, us, cf, ( 78808.6, -31664.3, 15 ), ( 0, 0, 0 ), "lv_check_24", undefined, undefined, undefined, undefined, undefined, undefined, 80 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.name = "25_p";
    s.script_count = int( 25 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    s.variantname = "livingworld_struct";
    fe [[ f ]]( s, us, cf, ( 79629.4, -32243, -128.14 ), ( 0, 247.39, 0 ), "zm_living_world", "lv_check_25" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.script_string = "living_world_transition_check";
    fe [[ f ]]( s, us, cf, ( 79517.8, -32194.4, -128.21 ), ( 0, 0, 0 ), "lv_check_25", undefined, undefined, undefined, undefined, undefined, undefined, 80 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.name = "26_p";
    s.script_count = int( 26 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    s.variantname = "livingworld_struct";
    fe [[ f ]]( s, us, cf, ( 77096, -32101.3, -132.58 ), ( 0, 168.92, 0 ), "zm_living_world", "lv_check_26" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.script_string = "living_world_transition_check";
    fe [[ f ]]( s, us, cf, ( 77111.9, -32011.7, -132.6 ), ( 0, 0, 0 ), "lv_check_26", undefined, undefined, undefined, undefined, undefined, undefined, 115 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.name = "27_p";
    s.script_count = int( 27 );
    s.script_scenescriptbundle = "sat_cin_zm_living_world_slumped_over_zmb";
    s.variantname = "livingworld_struct";
    fe [[ f ]]( s, us, cf, ( 76399.1, -32308.4, -124 ), ( 0, 52.01, 0 ), "zm_living_world", "lv_check_27" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_living_world_create_script";
    s.script_string = "living_world_transition_check";
    fe [[ f ]]( s, us, cf, ( 76479.1, -32392.7, -124 ), ( 0, 0, 0 ), "lv_check_27", undefined, undefined, undefined, undefined, undefined, undefined, 85 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_mantis_script_living_world_create_script
// Params 0, eflags: 0x4
// Checksum 0x795cea73, Offset: 0x18bf
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_mantis_script_living_world_create_script
// Params 0
// Checksum 0x77b54694, Offset: 0x18c9
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_mantis_script_living_world_create_script" );
}

