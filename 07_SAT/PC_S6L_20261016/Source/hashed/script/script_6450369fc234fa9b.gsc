// script_6450369fc234fa9b  (hash_6450369fc234fa9b.gscc) (size: 12934 Bytes / 0x3286 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5312ab93 (1393732499)
// size ...... 12934 (0x3286)
// includes .. 4   (offset: 0x2c4a)
// strings ... 30  (offset: 0x2c6a)
// dev strs .. 0   (offset: 0x3286)
// exports ... 17  (offset: 0x2646)
// cseg ...... 0x3ea + 0x225c (0x2646)
// imports ... 30  (offset: 0x28ee)
// animtree1 . 0   (offset: 0x3286)
// animtree2 . 0   (offset: 0x3286)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q4_ob_activity_prop_hunt_cs;

// Namespace mp_sat_avalon_q4_ob_activity_prop_hunt_cs
// Params 0, eflags: 0x5
// Checksum 0x78f01045, Offset: 0x408
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q4_ob_activity_prop_hunt_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q4_ob_activity_prop_hunt_cs
// Params 0, eflags: 0x4
// Checksum 0x67e765bc, Offset: 0x431
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q4_ob_activity_prop_hunt_cs
// Params 0, eflags: 0x4
// Checksum 0xe2dcb650, Offset: 0x442
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q4_ob_activity_prop_hunt_cs
// Params 2
// Checksum 0x76098172, Offset: 0x453
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q4_ob_activity_prop_hunt_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q4_ob_activity_prop_hunt_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q4_ob_activity_prop_hunt_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q4_ob_activity_prop_hunt_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q4_ob_activity_prop_hunt_cs
// Params 3, eflags: 0x4
// Checksum 0x615e029f, Offset: 0x4e7
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q4_ob_activity_prop_hunt_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q4_ob_activity_prop_hunt_cs" );
}

// Namespace mp_sat_avalon_q4_ob_activity_prop_hunt_cs
// Params 3, eflags: 0x4
// Checksum 0xd8f7d946, Offset: 0x561
// Size: 0x4fc
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.activity_bundle = "sat_ob_activitydefinition_prop_hunt_q4_roadside_crates";
    s.name = "PROP_HUNT_ROADSIDE_CRATES";
    fe [[ f ]]( s, "PROP_HUNT_ROADSIDE_CRATES", cf, ( 59443.7, -8218.44, 1267.15 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    fe [[ f ]]( s, "PROP_HUNT_ROADSIDE_CRATES", cf, ( 59456.5, -8235.38, 1268.14 ), ( 0, 0, 0 ), "activity_nexus_instance_joiner", "PROP_HUNT_ROADSIDE_CRATES", "PROP_HUNT_ROADSIDE_CRATES", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.activity_bundle = "sat_ob_activitydefinition_prop_hunt_q4_parking_lot";
    s.name = "PROP_HUNT_PARKING_LOT";
    fe [[ f ]]( s, "PROP_HUNT_PARKING_LOT", cf, ( 46882, -36682.8, 1988.83 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    fe [[ f ]]( s, "PROP_HUNT_PARKING_LOT", cf, ( 46886.7, -36719.3, 1988.83 ), ( 0, 0, 0 ), "activity_nexus_instance_joiner", "PROP_HUNT_PARKING_LOT", "PROP_HUNT_PARKING_LOT", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.activity_bundle = "sat_ob_activitydefinition_prop_hunt_q4_art_storage";
    s.name = "PROP_HUNT_ART_STORAGE";
    fe [[ f ]]( s, "PROP_HUNT_ART_STORAGE", cf, ( 35038.2, -13046.1, 216.53 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    fe [[ f ]]( s, "PROP_HUNT_ART_STORAGE", cf, ( 35051, -13063.1, 217.51 ), ( 0, 0, 0 ), "activity_nexus_instance_joiner", "PROP_HUNT_ART_STORAGE", "PROP_HUNT_ROADSIDE_CRATES", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.activity_bundle = "sat_ob_activitydefinition_prop_hunt_q4_warehouse";
    s.name = "PROP_HUNT_WAREHOUSE";
    fe [[ f ]]( s, "PROP_HUNT_WAREHOUSE", cf, ( 22244.6, -55085.9, 80 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    fe [[ f ]]( s, "PROP_HUNT_WAREHOUSE", cf, ( 22249.3, -55122.4, 80.01 ), ( 0, 0, 0 ), "activity_nexus_instance_joiner", "PROP_HUNT_WAREHOUSE", "PROP_HUNT_WAREHOUSE", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.activity_bundle = "sat_ob_activitydefinition_prop_hunt_q4_office";
    s.name = "PROP_HUNT_OFFICE";
    fe [[ f ]]( s, "PROP_HUNT_OFFICE", cf, ( 28299.4, -4505.11, 396 ), ( 0, 0, 0 ), "activity_nexus_variant", undefined, undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    fe [[ f ]]( s, "PROP_HUNT_OFFICE", cf, ( 28268.2, -4586.05, 396 ), ( 0, 0, 0 ), "activity_nexus_instance_joiner", "PROP_HUNT_OFFICE", "PROP_HUNT_OFFICE", undefined, "activity_link", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q4_ob_activity_prop_hunt_cs
// Params 0, eflags: 0x4
// Checksum 0x618d353f, Offset: 0xa65
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q4_ob_activity_prop_hunt_cs
// Params 0
// Checksum 0xa30ddfd2, Offset: 0xa6f
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q4_ob_activity_prop_hunt_cs" );
}

// Namespace mp_sat_avalon_q4_ob_activity_prop_hunt_cs
// Params 0
// Checksum 0xe5350305, Offset: 0xa85
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_PROP_HUNT";
    activityinfostruct.scriptbundle = "sat_ob_activitydefinition_prop_hunt";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_q4_ob_activity_prop_hunt_cs
// Params 4
// Checksum 0x4ed3fa34, Offset: 0xaf4
// Size: 0xbf
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_96bd13368b410bd":
            function_53749c5dd8e07645( fe, us, cf );
            break;
        case #"hash_d6583493d93e411b":
            function_3d532ffd68140513( fe, us, cf );
            break;
        case #"hash_c0fa6bd7b474fa08":
            function_9408087eb59c1020( fe, us, cf );
            break;
        case #"hash_ad342b54da8c7880":
            function_59a0710ea26d1d58( fe, us, cf );
            break;
        case #"hash_ee563127d670b18d":
            function_21e9d749b7678f55( fe, us, cf );
            break;
    }
}

// Namespace mp_sat_avalon_q4_ob_activity_prop_hunt_cs
// Params 3
// Checksum 0xd52dc619, Offset: 0xbbb
// Size: 0x4e4
function function_53749c5dd8e07645( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_ROADSIDE_CRATES", cf, ( 59733.7, -7145.43, 1239.35 ), ( 3.46, 355.42, 1.43 ), "mysteryprop_1_enemy_struct", "PROP_HUNT_ROADSIDE_CRATES", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_ROADSIDE_CRATES", cf, ( 59732.4, -7180.17, 1239.42 ), ( 358.78, 82.93, 0.32 ), "mysteryprop_1_scriptable_struct", "PROP_HUNT_ROADSIDE_CRATES", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_ROADSIDE_CRATES", cf, ( 59733.7, -7145.43, 1239.35 ), ( 3.46, 355.42, 1.43 ), "mysteryprop_1_chest_struct", "PROP_HUNT_ROADSIDE_CRATES", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_ROADSIDE_CRATES", cf, ( 59586.5, -7337.17, 1334.76 ), ( 0, 177.9, 0 ), "mysteryprop_2_scriptable_struct", "PROP_HUNT_ROADSIDE_CRATES", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_ROADSIDE_CRATES", cf, ( 59323, -7509.12, 1232.62 ), ( 3.75, 330.63, -2.11 ), "mysteryprop_3_scriptable_struct", "PROP_HUNT_ROADSIDE_CRATES", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_ROADSIDE_CRATES", cf, ( 59590.1, -7306.18, 1335.36 ), ( 0, 1, 0 ), "mysteryprop_2_enemy_struct", "PROP_HUNT_ROADSIDE_CRATES", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_ROADSIDE_CRATES", cf, ( 59590.1, -7306.18, 1335.36 ), ( 0, 1, 0 ), "mysteryprop_2_chest_struct", "PROP_HUNT_ROADSIDE_CRATES", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_ROADSIDE_CRATES", cf, ( 59342.1, -7483.81, 1232.76 ), ( 7.26, 335.76, -4.47 ), "mysteryprop_3_enemy_struct", "PROP_HUNT_ROADSIDE_CRATES", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_ROADSIDE_CRATES", cf, ( 59660, -7612.96, 1333.36 ), ( 7.64, 0.93, -2.64 ), "mysteryprop_3_chest_struct", "PROP_HUNT_ROADSIDE_CRATES", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_prop_hunt_cs
// Params 3
// Checksum 0x6a6ed81e, Offset: 0x10a7
// Size: 0x4e4
function function_3d532ffd68140513( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_PARKING_LOT", cf, ( 47009.6, -35870.3, 2000.82 ), ( 0, 227.6, 0 ), "mysteryprop_1_enemy_struct", "PROP_HUNT_PARKING_LOT", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_PARKING_LOT", cf, ( 47004.1, -35858.3, 2000.82 ), ( 356.8, 224.1, -0 ), "mysteryprop_1_scriptable_struct", "PROP_HUNT_PARKING_LOT", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_PARKING_LOT", cf, ( 47009.6, -35870.3, 2000.82 ), ( 0, 227.6, 0 ), "mysteryprop_1_chest_struct", "PROP_HUNT_PARKING_LOT", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_PARKING_LOT", cf, ( 46093.7, -37462.6, 1989.72 ), ( 0, 225, 0 ), "mysteryprop_2_scriptable_struct", "PROP_HUNT_PARKING_LOT", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_PARKING_LOT", cf, ( 47501.4, -36387.3, 1988.83 ), ( 357.2, 40.62, 3.26 ), "mysteryprop_3_scriptable_struct", "PROP_HUNT_PARKING_LOT", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_PARKING_LOT", cf, ( 46110, -37455.3, 1989.68 ), ( 0, 226, 0 ), "mysteryprop_2_enemy_struct", "PROP_HUNT_PARKING_LOT", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_PARKING_LOT", cf, ( 46110, -37455.3, 1989.68 ), ( 0, 226, 0 ), "mysteryprop_2_chest_struct", "PROP_HUNT_PARKING_LOT", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_PARKING_LOT", cf, ( 47490.9, -36379.5, 1988.83 ), ( 0.25, 46.02, 0.28 ), "mysteryprop_3_enemy_struct", "PROP_HUNT_PARKING_LOT", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_PARKING_LOT", cf, ( 47490.9, -36379.5, 1988.83 ), ( 0.25, 46.02, 0.28 ), "mysteryprop_3_chest_struct", "PROP_HUNT_PARKING_LOT", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_prop_hunt_cs
// Params 3
// Checksum 0xd570254f, Offset: 0x1593
// Size: 0x4e4
function function_9408087eb59c1020( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_ART_STORAGE", cf, ( 35093.4, -13013.8, 224 ), ( 0, 356.95, 0 ), "mysteryprop_1_enemy_struct", "PROP_HUNT_ART_STORAGE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_ART_STORAGE", cf, ( 35098.5, -13025.6, 224.87 ), ( 0, 90, 0 ), "mysteryprop_1_scriptable_struct", "PROP_HUNT_ART_STORAGE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_ART_STORAGE", cf, ( 35091.4, -13013.8, 224 ), ( 0, 356.95, 0 ), "mysteryprop_1_chest_struct", "PROP_HUNT_ART_STORAGE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_ART_STORAGE", cf, ( 35135.1, -13487.1, 222.82 ), ( 0, 90, 0 ), "mysteryprop_2_scriptable_struct", "PROP_HUNT_ART_STORAGE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_ART_STORAGE", cf, ( 34858.3, -13092.7, 223.77 ), ( 0, 270, 0 ), "mysteryprop_3_scriptable_struct", "PROP_HUNT_ART_STORAGE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_ART_STORAGE", cf, ( 35131, -13436, 221.5 ), ( 0, 1, 0 ), "mysteryprop_2_enemy_struct", "PROP_HUNT_ART_STORAGE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_ART_STORAGE", cf, ( 35129, -13436, 221.5 ), ( 0, 1, 0 ), "mysteryprop_2_chest_struct", "PROP_HUNT_ART_STORAGE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_ART_STORAGE", cf, ( 34862.1, -13123.2, 223.89 ), ( 0, 180.93, 0 ), "mysteryprop_3_enemy_struct", "PROP_HUNT_ART_STORAGE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_ART_STORAGE", cf, ( 34857.1, -13124.2, 223.99 ), ( 0, 180.93, 0 ), "mysteryprop_3_chest_struct", "PROP_HUNT_ART_STORAGE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_prop_hunt_cs
// Params 3
// Checksum 0x94f80f27, Offset: 0x1a7f
// Size: 0x2ae
function function_59a0710ea26d1d58( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_WAREHOUSE", cf, ( 22724, -55828, 80 ), ( 0, 130, 0 ), "mysteryprop_2_enemy_struct", "PROP_HUNT_ROADSIDE_CRATES", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.name = "mysteryprop_1_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_WAREHOUSE", cf, ( 21488, -54324, 80 ), ( 0, 310, 0 ), "mysteryprop_1_scriptable_struct", "PROP_HUNT_WAREHOUSE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_WAREHOUSE", cf, ( 22696.7, -55848.1, 80 ), ( 0, 130, 0 ), "mysteryprop_2_scriptable_struct", "PROP_HUNT_WAREHOUSE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.name = "mysteryprop_3_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_WAREHOUSE", cf, ( 22213.6, -55034.5, 80 ), ( 0, 25.8, 0 ), "mysteryprop_3_scriptable_struct", "PROP_HUNT_WAREHOUSE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_WAREHOUSE", cf, ( 22715.7, -55814, 80 ), ( 0, 130, 0 ), "mysteryprop_2_chest_struct", "PROP_HUNT_ROADSIDE_CRATES", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_prop_hunt_cs
// Params 3
// Checksum 0x54651839, Offset: 0x1d35
// Size: 0x4e4
function function_21e9d749b7678f55( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_OFFICE", cf, ( 28268.3, -4226.62, 396 ), ( 0, 163.7, 0 ), "mysteryprop_1_enemy_struct", "PROP_HUNT_OFFICE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_OFFICE", cf, ( 28268.3, -4226.62, 396 ), ( 0, 163.7, 0 ), "mysteryprop_1_chest_struct", "PROP_HUNT_OFFICE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_OFFICE", cf, ( 28238.1, -4396.88, 432.58 ), ( 0, 253.7, 0 ), "mysteryprop_2_enemy_struct", "PROP_HUNT_OFFICE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_OFFICE", cf, ( 28238.1, -4396.88, 432.58 ), ( 0, 253.7, 0 ), "mysteryprop_2_chest_struct", "PROP_HUNT_OFFICE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_enemy_struct";
    fe [[ f ]]( s, "PROP_HUNT_OFFICE", cf, ( 28346.2, -4218.7, 396 ), ( 0, 163.7, 0 ), "mysteryprop_3_enemy_struct", "PROP_HUNT_OFFICE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_chest_struct";
    fe [[ f ]]( s, "PROP_HUNT_OFFICE", cf, ( 28346.2, -4218.7, 396 ), ( 0, 163.7, 0 ), "mysteryprop_3_chest_struct", "PROP_HUNT_OFFICE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_1";
    s.name = "mysteryprop_1_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_OFFICE", cf, ( 28257.7, -4232.57, 396 ), ( 0, 342.94, 0 ), "mysteryprop_1_scriptable_struct", "PROP_HUNT_OFFICE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_3";
    s.name = "mysteryprop_3_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_OFFICE", cf, ( 28353.5, -4223.3, 396 ), ( 0, 254.3, 0 ), "mysteryprop_3_scriptable_struct", "PROP_HUNT_OFFICE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    s.groupid = "prop_2";
    s.name = "mysteryprop_2_scriptable_struct";
    fe [[ f ]]( s, "PROP_HUNT_OFFICE", cf, ( 28242.7, -4389.59, 432.58 ), ( 0, 344.3, 0 ), "mysteryprop_2_scriptable_struct", "PROP_HUNT_OFFICE", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_sat_avalon_q4_ob_activity_prop_hunt_cs
// Params 0
// Checksum 0xdf387776, Offset: 0x2221
// Size: 0x424
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_prop_hunt_q4_roadside_crates";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    var_881289d7987bc770.scriptstructorigin = ( 59443.7, -8218.44, 1267.15 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 59410.1, -8236.83, 1282.11 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1500 ];
    activityinstances[ "PROP_HUNT_ROADSIDE_CRATES" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_prop_hunt_q4_parking_lot";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    var_881289d7987bc770.scriptstructorigin = ( 46882, -36682.8, 1988.83 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 46902.9, -36679.6, 1988.83 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1500 ];
    activityinstances[ "PROP_HUNT_PARKING_LOT" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_prop_hunt_q4_art_storage";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    var_881289d7987bc770.scriptstructorigin = ( 35038.2, -13046.1, 216.53 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 35004.6, -13064.5, 231.49 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1500 ];
    activityinstances[ "PROP_HUNT_ART_STORAGE" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_prop_hunt_q4_warehouse";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    var_881289d7987bc770.scriptstructorigin = ( 22244.6, -55085.9, 80 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 22260.8, -55101.4, 84.46 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1500 ];
    activityinstances[ "PROP_HUNT_WAREHOUSE" ] = var_881289d7987bc770;
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "sat_ob_activitydefinition_prop_hunt_q4_office";
    var_881289d7987bc770.cf = "mp_sat_avalon_q4_ob_activity_prop_hunt_cs";
    var_881289d7987bc770.scriptstructorigin = ( 28299.4, -4505.11, 396 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [ ( 28221.8, -4587.5, 396 ) ];
    var_881289d7987bc770.var_31ce4477e3543d24 = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [ ( 0, 0, 0 ) ];
    var_881289d7987bc770.locationradius = [ 1500 ];
    activityinstances[ "PROP_HUNT_OFFICE" ] = var_881289d7987bc770;
    return activityinstances;
}

