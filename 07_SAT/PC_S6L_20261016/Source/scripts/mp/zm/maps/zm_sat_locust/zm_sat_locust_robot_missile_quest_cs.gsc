// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_robot_missile_quest_cs.gsc  (hash_75cedd553a57e641.gscc) (size: 5873 Bytes / 0x16f1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7296fe2 (120156130)
// size ...... 5873 (0x16f1)
// includes .. 3   (offset: 0x13c1)
// strings ... 38  (offset: 0x13d9)
// dev strs .. 0   (offset: 0x16f1)
// exports ... 9   (offset: 0xff1)
// cseg ...... 0x2d7 + 0xd1a (0xff1)
// imports ... 21  (offset: 0x1159)
// animtree1 . 0   (offset: 0x16f1)
// animtree2 . 0   (offset: 0x16f1)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_locust_robot_missile_quest_cs;

// Namespace zm_sat_locust_robot_missile_quest_cs
// Params 0, eflags: 0x5
// Checksum 0x2cf36faa, Offset: 0x2f5
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_locust_robot_missile_quest_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_locust_robot_missile_quest_cs
// Params 0, eflags: 0x4
// Checksum 0xb7275460, Offset: 0x316
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_locust_robot_missile_quest_cs
// Params 0, eflags: 0x4
// Checksum 0x321c878c, Offset: 0x327
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_locust_robot_missile_quest_cs
// Params 2
// Checksum 0x82f5d1c5, Offset: 0x338
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_locust_robot_missile_quest_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_locust_robot_missile_quest_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_locust_robot_missile_quest_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_locust_robot_missile_quest_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_locust_robot_missile_quest_cs
// Params 3, eflags: 0x4
// Checksum 0xb19e3343, Offset: 0x3c0
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_locust_robot_missile_quest_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_locust_robot_missile_quest_cs" );
}

// Namespace zm_sat_locust_robot_missile_quest_cs
// Params 3, eflags: 0x4
// Checksum 0x978ed5df, Offset: 0x43a
// Size: 0xb97
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    s.groupid = "Missile Crates";
    fe [[ f ]]( s, us, cf, ( -1680, 6080, 352 ), ( 0, 300, 0 ), "mqmi_cr_lo" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    s.groupid = "aa_gun";
    s.name = "mqmi_aa_ch";
    fe [[ f ]]( s, us, cf, ( 5803.27, 1095.75, 176 ), ( 0, 128, -78.13 ), undefined, undefined, "mqmi_aa_ch" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    s.groupid = "Crowbar";
    fe [[ f ]]( s, us, cf, ( 7347, 1419.73, 496.5 ), ( 0, 30, 0 ), "mqmi_crba" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    s.groupid = "Missile Crates";
    fe [[ f ]]( s, us, cf, ( -826, 5232, 160 ), ( 0, 300, 0 ), "mqmi_cr_lo" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    s.name = "mqmi_tr_de";
    fe [[ f ]]( s, us, cf, ( 3188, 9468, 1752 ), ( 0, 20, -0 ), "mqmi_tr_de" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    s.groupid = "Missile Crates";
    fe [[ f ]]( s, us, cf, ( 1448, 838, 220 ), ( 0, 95, 0 ), "mqmi_cr_lo" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    s.groupid = "Missile Crates";
    fe [[ f ]]( s, us, cf, ( -772, 2684, -152 ), ( 0, 31, 0 ), "mqmi_cr_lo" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( -598.5, 6527, 304 ), ( 0, 30, 0 ), "mqmi_ka_ra_to" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    s.groupid = "ro_tu_l";
    fe [[ f ]]( s, us, cf, ( 3301.14, 9214.99, 1345.42 ), ( 270, 0, 90 ), "left_rocket_tube_2", "left_rocket_tube_3" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    s.groupid = "ro_tu_l";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3387.04, 9244.1, 1374.31 ), ( 270, 0, 90 ), "robot_rocket_tube", "left_rocket_tube_2" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    s.groupid = "Notes";
    s.name = "Random Note Loc";
    fe [[ f ]]( s, us, cf, ( 204, 4009, 160 ), ( 272, 232, -49 ), "mqmi_no_lo" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    s.groupid = "Notes";
    s.name = "Manifest Note";
    fe [[ f ]]( s, us, cf, ( -2006, 5274, 402 ), ( 274.75, 114.61, -27.23 ), "mqmi_no_ma" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    s.groupid = "Notes";
    s.name = "Random Note Loc";
    fe [[ f ]]( s, us, cf, ( -1118, 7531, 291 ), ( 284.65, 215.31, 101.51 ), "mqmi_no_lo" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    s.name = "mqmi_to_pu";
    fe [[ f ]]( s, us, cf, ( -335.75, 6674.75, 629 ), ( 0, 210, 0 ), "mqmi_to_pu" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    s.groupid = "mqmi_ba_ta";
    s.name = "mqmi_ba_ta";
    s.script_int = int( 2 );
    fe [[ f ]]( s, us, cf, ( -1270, 6059, 735 ), ( 0, 23.91, 0 ), "mqmi_ba_ta" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    s.groupid = "mqmi_ba_ta";
    s.name = "mqmi_ba_ta";
    s.script_int = int( 0 );
    fe [[ f ]]( s, us, cf, ( 4220, 3440, 114 ), ( 0, 0, 0 ), "mqmi_ba_ta" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    s.groupid = "mqmi_ba_ta";
    s.name = "mqmi_ba_ta";
    s.script_int = int( 1 );
    fe [[ f ]]( s, us, cf, ( 1100, 5281, 261 ), ( 0, 0, 0 ), "mqmi_ba_ta" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    s.groupid = "ro_tu_l";
    fe [[ f ]]( s, us, cf, ( 3213.12, 9195.38, 1311.52 ), ( 270, 0, 90 ), "left_rocket_tube_3", "left_rocket_tube_4" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    s.groupid = "ro_tu_l";
    fe [[ f ]]( s, us, cf, ( 3134.89, 9177.36, 1272.54 ), ( 270, 0, 90 ), "left_rocket_tube_4" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    s.groupid = "ro_tu_r";
    fe [[ f ]]( s, us, cf, ( 3014.44, 10119.1, 1533.64 ), ( 270, 0, 90 ), "right_rocket_tube_2", "right_rocket_tube_3" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    s.groupid = "ro_tu_r";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3100.07, 10139.3, 1562.65 ), ( 270, 0, 90 ), "robot_rocket_tube", "right_rocket_tube_2" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    s.groupid = "ro_tu_r";
    fe [[ f ]]( s, us, cf, ( 2925.74, 10097.8, 1498.28 ), ( 270, 0, 90 ), "right_rocket_tube_3", "right_rocket_tube_4" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    s.groupid = "ro_tu_r";
    fe [[ f ]]( s, us, cf, ( 2843.84, 10079.7, 1458.02 ), ( 270, 0, 90 ), "right_rocket_tube_4" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    fe [[ f ]]( s, us, cf, ( -142.89, 6247.44, 344 ), ( 0, 210, 0 ), "robot_controller", undefined, "secondary" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    fe [[ f ]]( s, us, cf, ( -467, 6607, 344 ), ( 0, 0, 0 ), "mqmi_to_ic" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    fe [[ f ]]( s, us, cf, ( 3236, -712, 597 ), ( 319.81, 195.88, -25.96 ), "mqmi_an_pa_2", "mqmi_an_pa_3" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 3330, -566, 203 ), ( 0, 0, 0 ), "mqmi_ro_at_lo_lo" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    fe [[ f ]]( s, us, cf, ( 3246, -687, 453 ), ( 280.91, 215.73, -49.32 ), "mqmi_an_pa_3", "mqmi_an_pa_end" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3208, -786, 706 ), ( 345.31, 183.78, -20.23 ), "mqmi_an_pa_st", "mqmi_an_pa_2" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 3367, -621, 213 ), ( 0, 0, 0 ), "mqmi_ro_at_lo_lo" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    fe [[ f ]]( s, us, cf, ( 3250, -685, 295 ), ( 282.41, 296.32, -104.06 ), "mqmi_an_pa_end" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 3255, -522, 210 ), ( 0, 0, 0 ), "mqmi_ro_at_lo_lo" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 3175, -548, 214 ), ( 0, 0, 0 ), "mqmi_ro_at_lo_lo" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 3151, -600, 221 ), ( 0, 0, 0 ), "mqmi_ro_at_lo_lo" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_robot_missile_quest_cs";
    fe [[ f ]]( s, us, cf, ( 3255, -633, 280 ), ( 0, 90, 0 ), "mqmi_ro_at_in_lo" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_locust_robot_missile_quest_cs
// Params 0, eflags: 0x4
// Checksum 0x173f0377, Offset: 0xfd9
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_locust_robot_missile_quest_cs
// Params 0
// Checksum 0x73cdee0e, Offset: 0xfe3
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_locust_robot_missile_quest_cs" );
}

