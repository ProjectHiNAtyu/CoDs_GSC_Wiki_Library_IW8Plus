// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_sa_cs.gsc  (hash_732edb7003d57ced.gscc) (size: 6956 Bytes / 0x1b2c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x95b9f35f (2511991647)
// size ...... 6956 (0x1b2c)
// includes .. 3   (offset: 0x16f8)
// strings ... 43  (offset: 0x1710)
// dev strs .. 0   (offset: 0x1b2c)
// exports ... 9   (offset: 0x1328)
// cseg ...... 0x3e2 + 0xf46 (0x1328)
// imports ... 21  (offset: 0x1490)
// animtree1 . 0   (offset: 0x1b2c)
// animtree2 . 0   (offset: 0x1b2c)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_locust_sa_cs;

// Namespace zm_sat_locust_sa_cs
// Params 0, eflags: 0x5
// Checksum 0x141dd66d, Offset: 0x400
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_locust_sa_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_locust_sa_cs
// Params 0, eflags: 0x4
// Checksum 0x3e06b237, Offset: 0x421
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_locust_sa_cs
// Params 0, eflags: 0x4
// Checksum 0xbb3d61db, Offset: 0x432
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_locust_sa_cs
// Params 2
// Checksum 0xbd43792, Offset: 0x443
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_locust_sa_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_locust_sa_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_locust_sa_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_locust_sa_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_locust_sa_cs
// Params 3, eflags: 0x4
// Checksum 0x38bfd514, Offset: 0x4cb
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_locust_sa_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_locust_sa_cs" );
}

// Namespace zm_sat_locust_sa_cs
// Params 3, eflags: 0x4
// Checksum 0xcf600796, Offset: 0x545
// Size: 0xdc3
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.groupid = "Lighthouse Exit";
    s.script_flag_wait = "ww_step_08";
    s.script_parameters = "zm_locust_ww_lighthouse_exit_2d";
    s.script_radius = int( 48 );
    s.script_type = "lighthouse";
    fe [[ f ]]( s, us, cf, ( 7174.99, 1200, 1580 ), ( 0, 0, 0 ), "cspf_0_auto11766874597790103493", "cspf_0_auto14872480976100657298", "exit" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.groupid = "Lighthouse Entrance";
    s.script_flag_set = "ww_step_07";
    s.script_flag_wait = "ww_step_06";
    s.script_label = "no_objective";
    s.script_parameters = "zm_locust_ww_lighthouse_enter_2d";
    s.script_radius = int( 96 );
    s.script_string = "lighthouse";
    s.script_type = "lighthouse";
    fe [[ f ]]( s, us, cf, ( 6997.96, 1288.41, 1348 ), ( 0, 10, -180 ), "cspf_0_auto11766874597790103493", "cspf_0_auto2535763301727611243", "enter" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.groupid = "Lighthouse Exit";
    fe [[ f ]]( s, us, cf, ( 7097.34, 1287.42, 464 ), ( 0, 193.54, 0 ), "cspf_0_auto14872480976100657298", undefined, "player_position" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.groupid = "Lighthouse Exit";
    fe [[ f ]]( s, us, cf, ( 7086.56, 1332.79, 462.09 ), ( 0, 193.54, 0 ), "cspf_0_auto14872480976100657298", undefined, "player_position" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.groupid = "Lighthouse Exit";
    fe [[ f ]]( s, us, cf, ( 7100.33, 1245.94, 464 ), ( 0, 178.54, 0 ), "cspf_0_auto14872480976100657298", undefined, "player_position" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.groupid = "Lighthouse Exit";
    fe [[ f ]]( s, us, cf, ( 7074.59, 1374.27, 468.18 ), ( 0, 208.54, 0 ), "cspf_0_auto14872480976100657298", undefined, "player_position" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.groupid = "Lighthouse Entrance";
    fe [[ f ]]( s, us, cf, ( 7182, 1216, 1594 ), ( 0, 101, 0 ), "cspf_0_auto2535763301727611243", undefined, "player_position" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.groupid = "Lighthouse Entrance";
    fe [[ f ]]( s, us, cf, ( 7200, 1220, 1594 ), ( 0, 101, 0 ), "cspf_0_auto2535763301727611243", undefined, "player_position" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.name = "Lighthouse Main Node";
    fe [[ f ]]( s, us, cf, ( 7178, 1288, 1374 ), ( 0, 0, 0 ), "safe_area_node", "cspf_0_auto11766874597790103493" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.groupid = "Lighthouse Entrance";
    fe [[ f ]]( s, us, cf, ( 7144, 1208, 1594 ), ( 0, 101, 0 ), "cspf_0_auto2535763301727611243", undefined, "player_position" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.groupid = "Lighthouse Entrance";
    fe [[ f ]]( s, us, cf, ( 7162, 1212, 1594 ), ( 0, 101, 0 ), "cspf_0_auto2535763301727611243", undefined, "player_position" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.name = "Shoulder Main Node";
    fe [[ f ]]( s, us, cf, ( 3498.08, 7867.2, 486.55 ), ( 0, 0, 0 ), "safe_area_node", "cspf_0_auto7287002022840017600" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.groupid = "Shoulder Exit";
    s.script_flag_wait = "pap_step_05";
    s.script_parameters = "zm_locust_robot_enter_2d";
    s.script_radius = int( 32 );
    s.script_string = "robot_shoulder";
    s.script_type = "robot";
    fe [[ f ]]( s, us, cf, ( 3166, 9662, 1634 ), ( 0, 329.98, 0 ), "cspf_0_auto7287002022840017600", "cspf_0_auto13721159970383834519", "exit" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.groupid = "Shoulder Entrance";
    s.script_flag_set = "shoulder_rap";
    s.script_flag_wait = "pap_step_02";
    s.script_int = int( 60 );
    s.script_label = "objective";
    s.script_parameters = "zm_locust_robot_enter_2d";
    s.script_radius = int( 64 );
    s.script_string = "robot_head";
    s.script_type = "robot";
    fe [[ f ]]( s, us, cf, ( 3684, 8319, 326.25 ), ( 0, 280, 0 ), "cspf_0_auto7287002022840017600", "cspf_0_auto17843495505376115444", "enter" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.groupid = "Shoulder Entrance";
    fe [[ f ]]( s, us, cf, ( 3173.55, 9699.64, 1615.8 ), ( 0, 240, 0 ), "cspf_0_auto17843495505376115444", undefined, "player_position" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.groupid = "Shoulder Entrance";
    fe [[ f ]]( s, us, cf, ( 3140.55, 9697.36, 1615.8 ), ( 0, 240, 0 ), "cspf_0_auto17843495505376115444", undefined, "player_position" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.groupid = "Shoulder Entrance";
    fe [[ f ]]( s, us, cf, ( 3209.45, 9654.64, 1615.8 ), ( 0, 240, 0 ), "cspf_0_auto17843495505376115444", undefined, "player_position" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.groupid = "Shoulder Entrance";
    fe [[ f ]]( s, us, cf, ( 3197.45, 9686.36, 1615.8 ), ( 0, 240, 0 ), "cspf_0_auto17843495505376115444", undefined, "player_position" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.groupid = "Shoulder Exit";
    fe [[ f ]]( s, us, cf, ( 3680, 8241, 266.96 ), ( 0, 280, 0 ), "cspf_0_auto13721159970383834519", undefined, "player_position" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.groupid = "Shoulder Exit";
    fe [[ f ]]( s, us, cf, ( 3648, 8235, 266.65 ), ( 0, 280, 0 ), "cspf_0_auto13721159970383834519", undefined, "player_position" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.groupid = "Foot Entrance";
    fe [[ f ]]( s, us, cf, ( 3094, 9742, 1615.8 ), ( 0, 240, 0 ), "cspf_0_auto10056408738479283273", undefined, "player_position" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.groupid = "Foot Entrance";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3042, 9758, 1615.8 ), ( 0, 240, 0 ), "cspf_0_auto10056408738479283273", undefined, "player_position" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.groupid = "Foot Entrance";
    fe [[ f ]]( s, us, cf, ( 3116, 9718, 1615.8 ), ( 0, 240, 0 ), "cspf_0_auto10056408738479283273", undefined, "player_position" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.groupid = "Foot Entrance";
    fe [[ f ]]( s, us, cf, ( 3068, 9756, 1615.8 ), ( 359.9, 239.99, 0.47 ), "cspf_0_auto10056408738479283273", undefined, "player_position" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.groupid = "Shoulder Exit";
    fe [[ f ]]( s, us, cf, ( 3742, 8251, 273.48 ), ( 0, 280, 0 ), "cspf_0_auto13721159970383834519", undefined, "player_position" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.groupid = "Shoulder Exit";
    fe [[ f ]]( s, us, cf, ( 3710, 8245, 267.93 ), ( 0, 280, 0 ), "cspf_0_auto13721159970383834519", undefined, "player_position" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.name = "Foot Main Node";
    fe [[ f ]]( s, us, cf, ( -174.33, 7495.98, 490 ), ( 0, 0, 0 ), "safe_area_node", "cspf_0_auto16171215418333333327" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.groupid = "Foot Exit";
    fe [[ f ]]( s, us, cf, ( -792, 7829, 338.14 ), ( 0, 210, 0 ), "cspf_0_auto4342428959639580691", undefined, "player_position" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.groupid = "Foot Entrance";
    s.script_flag_set = "foot_rap";
    s.script_flag_wait = "pap_step_02";
    s.script_int = int( 60 );
    s.script_label = "objective";
    s.script_parameters = "zm_locust_robot_enter_2d";
    s.script_radius = int( 64 );
    s.script_string = "robot_head";
    s.script_type = "robot";
    fe [[ f ]]( s, us, cf, ( -723, 7863, 428 ), ( 0, 210, 0 ), "cspf_0_auto16171215418333333327", "cspf_0_auto10056408738479283273", "enter" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.groupid = "Foot Exit";
    fe [[ f ]]( s, us, cf, ( -808, 7865, 337.91 ), ( 0, 210, 0 ), "cspf_0_auto4342428959639580691", undefined, "player_position" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.groupid = "Foot Exit";
    s.script_flag_wait = "pap_step_05";
    s.script_parameters = "zm_locust_robot_enter_2d";
    s.script_radius = int( 32 );
    s.script_string = "robot_foot";
    s.script_type = "robot";
    fe [[ f ]]( s, us, cf, ( 3068, 9716, 1634 ), ( 0, 151.31, 0 ), "cspf_0_auto16171215418333333327", "cspf_0_auto4342428959639580691", "exit" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.groupid = "Foot Exit";
    fe [[ f ]]( s, us, cf, ( -752, 7771, 333.1 ), ( 0, 210, 0 ), "cspf_0_auto4342428959639580691", undefined, "player_position" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_sa_cs";
    s.groupid = "Foot Exit";
    fe [[ f ]]( s, us, cf, ( -772, 7799, 336.69 ), ( 0, 210, 0 ), "cspf_0_auto4342428959639580691", undefined, "player_position" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_locust_sa_cs
// Params 0, eflags: 0x4
// Checksum 0x400ed555, Offset: 0x1310
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_locust_sa_cs
// Params 0
// Checksum 0xfaec0859, Offset: 0x131a
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_locust_sa_cs" );
}

