// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_quest_lost_key_cs.gsc  (hash_70de871b4370c58a.gscc) (size: 4819 Bytes / 0x12d3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1fa02188 (530588040)
// size ...... 4819 (0x12d3)
// includes .. 3   (offset: 0x106f)
// strings ... 23  (offset: 0x1087)
// dev strs .. 0   (offset: 0x12d3)
// exports ... 9   (offset: 0xcd7)
// cseg ...... 0x30e + 0x9c9 (0xcd7)
// imports ... 20  (offset: 0xe3f)
// animtree1 . 0   (offset: 0x12d3)
// animtree2 . 0   (offset: 0x12d3)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_mantis_quest_lost_key_cs;

// Namespace zm_sat_mantis_quest_lost_key_cs
// Params 0, eflags: 0x5
// Checksum 0x961701a1, Offset: 0x32c
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_mantis_quest_lost_key_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_mantis_quest_lost_key_cs
// Params 0, eflags: 0x4
// Checksum 0x4ebdc3e2, Offset: 0x34d
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_mantis_quest_lost_key_cs
// Params 0, eflags: 0x4
// Checksum 0xcb86100e, Offset: 0x35e
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_mantis_quest_lost_key_cs
// Params 2
// Checksum 0x7b6f4647, Offset: 0x36f
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_mantis_quest_lost_key_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_mantis_quest_lost_key_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_mantis_quest_lost_key_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_mantis_quest_lost_key_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_mantis_quest_lost_key_cs
// Params 3, eflags: 0x4
// Checksum 0x4804a4c1, Offset: 0x3f7
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_mantis_quest_lost_key_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_mantis_quest_lost_key_cs" );
}

// Namespace zm_sat_mantis_quest_lost_key_cs
// Params 3, eflags: 0x4
// Checksum 0xe4abe086, Offset: 0x471
// Size: 0x846
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_lost_key_cs";
    fe [[ f ]]( s, us, cf, ( 78522.5, -30397.2, 79.5 ), ( 0, 155.25, 0 ), "sq_lost_key_container_loc", "cspf_0_auto9138202777827591711", "accessory_locker_key_02" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_lost_key_cs";
    fe [[ f ]]( s, us, cf, ( 79104.8, -31776.8, 9.75 ), ( 0, 326.08, 0 ), "sq_lost_key_container_loc", "cspf_0_auto2785385768014272396", "accessory_locker_key_02" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_lost_key_cs";
    fe [[ f ]]( s, us, cf, ( 77672.5, -30158, 83.5 ), ( 0, 0, 0 ), "sq_lost_key_container_loc", "cspf_0_auto2768928957500836438", "accessory_locker_key_02" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_lost_key_cs";
    fe [[ f ]]( s, us, cf, ( 77741.2, -29849.2, 11.5 ), ( 0, 301.34, 0 ), "sq_lost_key_container_loc", "cspf_0_auto13477739808418808133", "accessory_locker_key_02" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_lost_key_cs";
    fe [[ f ]]( s, us, cf, ( 77049, -29994, -18.5 ), ( 0, 0, 0 ), "sq_lost_key_container_loc", "cspf_0_auto15865249143681469219", "accessory_locker_key_02" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_lost_key_cs";
    fe [[ f ]]( s, us, cf, ( 78433.8, -31588, 1.5 ), ( 0, 46.91, 0 ), "sq_lost_key_container_loc", "cspf_0_auto17151964315719265422", "accessory_locker_key_02" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_lost_key_cs";
    fe [[ f ]]( s, us, cf, ( 78658.2, -30397.7, 71 ), ( 0, 339.61, 0 ), "sq_lost_key_container_loc", "cspf_0_auto9181690623551312779", "accessory_locker_key_02" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_lost_key_cs";
    fe [[ f ]]( s, us, cf, ( 78708.2, -30439.7, 62.75 ), ( 0, 339.61, 0 ), "sq_lost_key_container_loc", "cspf_0_auto17937464478585102400", "accessory_locker_key_02" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_lost_key_cs";
    fe [[ f ]]( s, us, cf, ( 77948, -30479.2, 15.5 ), ( 0, 202.28, 0 ), "sq_lost_key_crate_loc", undefined, "decor_suitcase_01" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_lost_key_cs";
    fe [[ f ]]( s, us, cf, ( 79164, -31673.8, 10 ), ( 0, 145.87, 0 ), "sq_lost_key_container_loc", "cspf_0_auto5214747819311825051", "accessory_locker_key_02" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_lost_key_cs";
    fe [[ f ]]( s, us, cf, ( 79030.5, -31904.8, 9.75 ), ( 0, 326.08, 0 ), "sq_lost_key_container_loc", "cspf_0_auto11501601911896860126", "accessory_locker_key_02" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_lost_key_cs";
    fe [[ f ]]( s, us, cf, ( 77042, -31442.6, 8 ), ( 0, 326.08, 0 ), "sq_lost_key_container_loc", "cspf_0_auto9428060658381483451", "accessory_locker_key_02" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_lost_key_cs";
    fe [[ f ]]( s, us, cf, ( 77543.7, -30093.7, 11.25 ), ( 0, 301.34, 0 ), "sq_lost_key_container_loc", "cspf_0_auto18333242802571103413", "accessory_locker_key_02" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_lost_key_cs";
    fe [[ f ]]( s, us, cf, ( 77784.5, -29941.7, 11.25 ), ( 0, 294.72, 0 ), "sq_lost_key_container_loc", "cspf_0_auto453096339580835955", "accessory_locker_key_02" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_lost_key_cs";
    fe [[ f ]]( s, us, cf, ( 77488.5, -30927.6, -43.5 ), ( 359.89, 304.97, 0 ), "sq_lost_key_container_loc", "cspf_0_auto14699999061603715594", "accessory_locker_key_02" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_lost_key_cs";
    fe [[ f ]]( s, us, cf, ( 77660, -29958, 522 ), ( 0, 314, 0 ), "sq_clock_reward_loc", "sq_clock_reward_des" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_lost_key_cs";
    fe [[ f ]]( s, us, cf, ( 78326, -30370, -118 ), ( 0, 266, 0 ), "sq_clock_reward_des" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_lost_key_cs";
    fe [[ f ]]( s, us, cf, ( 78670, -30395, -126.63 ), ( 0, 0, 0 ), "cspf_0_auto9181690623551312779" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_lost_key_cs";
    fe [[ f ]]( s, us, cf, ( 78530, -30403, -126.63 ), ( 0, 0, 0 ), "cspf_0_auto9138202777827591711" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_lost_key_cs";
    fe [[ f ]]( s, us, cf, ( 78730, -30458, -126.63 ), ( 0, 0, 0 ), "cspf_0_auto17937464478585102400" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_lost_key_cs";
    fe [[ f ]]( s, us, cf, ( 79171, -31679, -113.71 ), ( 0, 0, 0 ), "cspf_0_auto5214747819311825051" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_lost_key_cs";
    fe [[ f ]]( s, us, cf, ( 79114, -31789, -113.71 ), ( 0, 0, 0 ), "cspf_0_auto2785385768014272396" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_lost_key_cs";
    fe [[ f ]]( s, us, cf, ( 79024, -31919, -113.71 ), ( 0, 0, 0 ), "cspf_0_auto11501601911896860126" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_lost_key_cs";
    fe [[ f ]]( s, us, cf, ( 77779, -29951, -121 ), ( 0, 0, 0 ), "cspf_0_auto453096339580835955" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_lost_key_cs";
    fe [[ f ]]( s, us, cf, ( 77692, -30140, 15 ), ( 0, 0, 0 ), "cspf_0_auto2768928957500836438" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_lost_key_cs";
    fe [[ f ]]( s, us, cf, ( 77740, -29846, -121 ), ( 0, 0, 0 ), "cspf_0_auto13477739808418808133" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_lost_key_cs";
    fe [[ f ]]( s, us, cf, ( 77561, -30091, -121 ), ( 0, 0, 0 ), "cspf_0_auto18333242802571103413" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_lost_key_cs";
    fe [[ f ]]( s, us, cf, ( 77072, -29953, -129 ), ( 0, 0, 0 ), "cspf_0_auto15865249143681469219" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_lost_key_cs";
    fe [[ f ]]( s, us, cf, ( 78424, -31572, -124 ), ( 0, 0, 0 ), "cspf_0_auto17151964315719265422" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_lost_key_cs";
    fe [[ f ]]( s, us, cf, ( 77037, -31454, -110 ), ( 0, 0, 0 ), "cspf_0_auto9428060658381483451" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_lost_key_cs";
    fe [[ f ]]( s, us, cf, ( 77585, -30929, -123 ), ( 0, 0, 0 ), "cspf_0_auto14699999061603715594" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_mantis_quest_lost_key_cs
// Params 0, eflags: 0x4
// Checksum 0xd3d15d30, Offset: 0xcbf
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_mantis_quest_lost_key_cs
// Params 0
// Checksum 0x8a57798c, Offset: 0xcc9
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_mantis_quest_lost_key_cs" );
}

