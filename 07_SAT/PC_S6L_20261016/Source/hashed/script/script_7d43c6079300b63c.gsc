// script_7d43c6079300b63c  (hash_7d43c6079300b63c.gscc) (size: 6031 Bytes / 0x178f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1f93a419 (529769497)
// size ...... 6031 (0x178f)
// includes .. 3   (offset: 0x148b)
// strings ... 37  (offset: 0x14a3)
// dev strs .. 0   (offset: 0x178f)
// exports ... 9   (offset: 0x10f3)
// cseg ...... 0x465 + 0xc8e (0x10f3)
// imports ... 20  (offset: 0x125b)
// animtree1 . 0   (offset: 0x178f)
// animtree2 . 0   (offset: 0x178f)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q2_ob_activity_sagittarius_cs;

// Namespace mp_sat_avalon_q2_ob_activity_sagittarius_cs
// Params 0, eflags: 0x5
// Checksum 0xd41fe86f, Offset: 0x483
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q2_ob_activity_sagittarius_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q2_ob_activity_sagittarius_cs
// Params 0, eflags: 0x4
// Checksum 0xc234a936, Offset: 0x4a4
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q2_ob_activity_sagittarius_cs
// Params 0, eflags: 0x4
// Checksum 0x470f7ada, Offset: 0x4b5
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q2_ob_activity_sagittarius_cs
// Params 2
// Checksum 0xf7e62c93, Offset: 0x4c6
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q2_ob_activity_sagittarius_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q2_ob_activity_sagittarius_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q2_ob_activity_sagittarius_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q2_ob_activity_sagittarius_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q2_ob_activity_sagittarius_cs
// Params 3, eflags: 0x4
// Checksum 0xc48dce15, Offset: 0x54e
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q2_ob_activity_sagittarius_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q2_ob_activity_sagittarius_cs" );
}

// Namespace mp_sat_avalon_q2_ob_activity_sagittarius_cs
// Params 3, eflags: 0x4
// Checksum 0x43962897, Offset: 0x5c8
// Size: 0xb0b
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_sagittarius_cs";
    s.groupid = "VTOL_flyby_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 34267, 2946.1, 2500 ), ( 0, 261.32, 0 ), "cspf_0_auto17988454616066450865", "cspf_0_auto16709540560402746678", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_sagittarius_cs";
    s.groupid = "VTOL_flyby_path_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 28194, 4656.46, 2500 ), ( 0, 266.92, 0 ), "cspf_0_auto18403610075857948046", "cspf_0_auto3798680533245940970", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_sagittarius_cs";
    s.groupid = "VTOL_flyby_path_02";
    s.ishelistruct = 1;
    s.name = "script_struct_heli_start";
    fe [[ f ]]( s, us, cf, ( 33696.3, 20948.8, 10575.9 ), ( 33.6, 248.6, 0 ), "sag_intro_vtol_spawn_1", "cspf_0_auto13078791497747274818", "sag_intro_vtol_spawn", undefined, undefined, undefined, undefined, undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_sagittarius_cs";
    s.groupid = "VTOL_flyby_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 41098.9, -26151.6, 2500 ), ( 0, 248.2, 0 ), "cspf_0_auto15598548787078834034", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_sagittarius_cs";
    s.groupid = "VTOL_flyby_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 35132.9, -10365.7, 2500 ), ( 0, 301.8, 0 ), "cspf_0_auto16709540560402746678", "cspf_0_auto8188037804031796077", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_sagittarius_cs";
    s.is_cs_trigger = 1;
    s._size_max = ( 336, 32, 416 );
    s._size_min = ( 318, 32, 32 );
    s.height = 128;
    s.length = "128";
    s.name = "VTOL_flyby_trigger";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 27735.9, 6457.04, 722.88 ), ( 0, 55, 0 ), "sag_intro_vtol_trigger" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_sagittarius_cs";
    s.groupid = "VTOL_flyby_path_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 31640.4, 16965, 6636.01 ), ( 0, 242.49, 0 ), "cspf_0_auto13078791497747274818", "cspf_0_auto11696029265190170782", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_sagittarius_cs";
    s.groupid = "VTOL_flyby_path_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 33682.9, -16795.6, 2500 ), ( 0, 253.8, 0 ), "cspf_0_auto1635080574327929733", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_sagittarius_cs";
    s.groupid = "VTOL_flyby_path_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 28803.5, -4314.81, 2500 ), ( 0, 284.6, 0 ), "cspf_0_auto3798680533245940970", "cspf_0_auto1635080574327929733", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_sagittarius_cs";
    s.groupid = "VTOL_flyby_path_03";
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 36339.9, 1813.53, 2000 ), ( 0, 265.92, 0 ), "cspf_0_auto8860243918722630771", "cspf_0_auto5340560390121534512", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_sagittarius_cs";
    s.groupid = "VTOL_flyby_path";
    s.ishelistruct = 1;
    s.name = "script_struct_heli_start";
    fe [[ f ]]( s, us, cf, ( 39732.1, 20341.6, 10105 ), ( 51.5, 248.68, -180 ), "sag_intro_vtol_spawn_0", "cspf_0_auto10131430058522599605", "sag_intro_vtol_spawn", undefined, undefined, undefined, undefined, undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_sagittarius_cs";
    s.groupid = "VTOL_flyby_path_03";
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 39507.3, -15955.8, 2000 ), ( 0, 248.2, 0 ), "cspf_0_auto312879790389165800", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_sagittarius_cs";
    s.groupid = "VTOL_flyby_path_03";
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 36400.5, -4260.06, 2000 ), ( 0, 279, 0 ), "cspf_0_auto5340560390121534512", "cspf_0_auto312879790389165800", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_sagittarius_cs";
    s.groupid = "VTOL_flyby_path_03";
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 36854.8, 4824.43, 2000 ), ( 0, 265.92, 0 ), "cspf_0_auto10626265528929618368", "cspf_0_auto8860243918722630771", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_sagittarius_cs";
    s.groupid = "objective_locations";
    s.name = "objective_location";
    fe [[ f ]]( s, us, cf, ( 31293.3, 14168.9, 784.45 ), ( 0, 0, 0 ), "sag_objective_location", undefined, undefined, undefined, undefined, undefined, undefined, 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_sagittarius_cs";
    s.groupid = "encounter_objects";
    s.name = "ammo_crate";
    fe [[ f ]]( s, us, cf, ( 30026.7, 4689.89, 633.27 ), ( 0, 310, 0 ), "s_sag_ammocrate" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_sagittarius_cs";
    s.groupid = "objective_locations";
    s.name = "objective_location";
    fe [[ f ]]( s, us, cf, ( 30019.4, 12916.9, 724.97 ), ( 0, 0, 0 ), "sag_objective_location", undefined, undefined, undefined, undefined, undefined, undefined, 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_sagittarius_cs";
    s.groupid = "objective_locations";
    s.name = "objective_location";
    fe [[ f ]]( s, us, cf, ( 28595.1, 13021.6, 724.97 ), ( 0, 0, 0 ), "sag_objective_location", undefined, undefined, undefined, undefined, undefined, undefined, 50 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_sagittarius_cs";
    s.groupid = "VTOL_flyby_path_03";
    s.ishelistruct = 1;
    s.name = "script_struct_heli_start";
    fe [[ f ]]( s, us, cf, ( 41162.2, 19960.6, 10000 ), ( 46.7, 250.9, 0 ), "sag_intro_vtol_spawn_2", "cspf_0_auto16718011246347563441", "sag_intro_vtol_spawn", undefined, undefined, undefined, undefined, undefined, 150, 1 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_sagittarius_cs";
    s.groupid = "VTOL_flyby_path_03";
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 38419.8, 11068.9, 3342.38 ), ( 0, 250.79, 0 ), "cspf_0_auto13960802954610517248", "cspf_0_auto10626265528929618368", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_sagittarius_cs";
    s.groupid = "VTOL_flyby_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 36035.7, 10523.2, 3071.87 ), ( 0, 257.99, 0 ), "cspf_0_auto10333632908647975443", "cspf_0_auto17988454616066450865", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_sagittarius_cs";
    s.groupid = "VTOL_flyby_path_02";
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 29591.3, 13029.8, 3986.27 ), ( 0, 242.49, 0 ), "cspf_0_auto11696029265190170782", "cspf_0_auto18403610075857948046", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_sagittarius_cs";
    s.groupid = "VTOL_flyby_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 37904.1, 16351.9, 6280.55 ), ( 0, 257.99, 0 ), "cspf_0_auto10131430058522599605", "cspf_0_auto10333632908647975443", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_sagittarius_cs";
    s.groupid = "VTOL_flyby_path_03";
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 39651.2, 15626.4, 6262.53 ), ( 0, 250.79, 0 ), "cspf_0_auto16718011246347563441", "cspf_0_auto13960802954610517248", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q2_ob_activity_sagittarius_cs";
    s.groupid = "VTOL_flyby_path";
    s.ishelistruct = 1;
    fe [[ f ]]( s, us, cf, ( 38058.7, -19780.2, 2500 ), ( 0, 301.8, 0 ), "cspf_0_auto8188037804031796077", "cspf_0_auto15598548787078834034", undefined, undefined, undefined, undefined, undefined, undefined, 150 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q2_ob_activity_sagittarius_cs
// Params 0, eflags: 0x4
// Checksum 0xe6c01eb2, Offset: 0x10db
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q2_ob_activity_sagittarius_cs
// Params 0
// Checksum 0x6de1358, Offset: 0x10e5
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q2_ob_activity_sagittarius_cs" );
}

