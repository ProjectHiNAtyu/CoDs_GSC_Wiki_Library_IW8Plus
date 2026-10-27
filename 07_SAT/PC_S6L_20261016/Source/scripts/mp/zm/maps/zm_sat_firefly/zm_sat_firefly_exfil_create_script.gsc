// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_exfil_create_script.gsc  (hash_68755d01e7188e09.gscc) (size: 6839 Bytes / 0x1ab7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb386e42e (3011961902)
// size ...... 6839 (0x1ab7)
// includes .. 3   (offset: 0x174b)
// strings ... 28  (offset: 0x1763)
// dev strs .. 0   (offset: 0x1ab7)
// exports ... 9   (offset: 0x1377)
// cseg ...... 0x331 + 0x1046 (0x1377)
// imports ... 21  (offset: 0x14df)
// animtree1 . 0   (offset: 0x1ab7)
// animtree2 . 0   (offset: 0x1ab7)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_firefly_exfil_create_script;

// Namespace zm_sat_firefly_exfil_create_script
// Params 0, eflags: 0x5
// Checksum 0x6ff4433d, Offset: 0x34f
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_exfil_create_script", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_firefly_exfil_create_script
// Params 0, eflags: 0x4
// Checksum 0xf19666b6, Offset: 0x370
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_firefly_exfil_create_script
// Params 0, eflags: 0x4
// Checksum 0x74adb55a, Offset: 0x381
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_firefly_exfil_create_script
// Params 2
// Checksum 0xc444e313, Offset: 0x392
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_exfil_create_script" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_firefly_exfil_create_script" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_exfil_create_script" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_exfil_create_script" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_exfil_create_script
// Params 3, eflags: 0x4
// Checksum 0xf72f0195, Offset: 0x41a
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_exfil_create_script" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_exfil_create_script" );
}

// Namespace zm_sat_firefly_exfil_create_script
// Params 3, eflags: 0x4
// Checksum 0x2f3a8074, Offset: 0x494
// Size: 0xec3
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( 24105.5, -120.23, 312.51 ), ( 0, 180.83, 0 ), "cspf_0_auto16911536170443586329" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    s.script_int = int( 120 );
    s.script_label = "zombie_mangler_hvt";
    s.script_radius = int( 9000 );
    s.script_timer = int( 30 );
    fe [[ f ]]( s, us, cf, ( 23943.2, 757.02, 1131.87 ), ( 0, 0, 0 ), "zm_exfil", "cspf_0_auto4544706440968475029" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( 24681, 1329.53, 371.55 ), ( 0, 90, 0 ), "cspf_0_auto1284933450841619039", undefined, "interact" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( 24086.8, -32.44, 425.3 ), ( 0, 180.83, 0 ), "cspf_0_auto1284933450841619039", "cspf_0_auto16911536170443586329", "teleport_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( 24104.1, -42.43, 312.51 ), ( 0, 180.83, 0 ), "cspf_0_auto16911536170443586329" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( 24105.9, -84.89, 312.51 ), ( 0, 180.83, 0 ), "cspf_0_auto16911536170443586329" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( 12876.7, 1327.06, 916.5 ), ( 0, 264.65, 0 ), "cspf_0_auto15474361460168494059" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( 24102.2, -4.62, 312.51 ), ( 0, 180.83, 0 ), "cspf_0_auto16911536170443586329" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    s.script_radius = int( 4000 );
    fe [[ f ]]( s, us, cf, ( 24704.2, 1328.62, 312.53 ), ( 0, 180, 0 ), "cspf_0_auto4544706440968475029", "cspf_0_auto1284933450841619039", "zone_jplaza_roundabout", undefined, undefined, undefined, undefined, 4000 );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( 14091.7, -4614.19, 576.22 ), ( 0, 32.61, 0 ), "cspf_0_auto15978011123940093995" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( 23846.3, 864.63, 330.08 ), ( 0, 180, 0 ), "cspf_0_auto1284933450841619039", undefined, "hvt_spawn_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( 14156.3, -2867.31, 692.4 ), ( 0, 167.15, 0 ), "cspf_0_auto9709692143619376135", undefined, "interact" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( 14132.7, -4603.19, 661.45 ), ( 0, 32.61, 0 ), "cspf_0_auto9709692143619376135", "cspf_0_auto15978011123940093995", "teleport_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( 14134.7, -4676.56, 576.22 ), ( 0, 32.61, 0 ), "cspf_0_auto15978011123940093995" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( 14110.9, -4641.47, 576.22 ), ( 0, 32.61, 0 ), "cspf_0_auto15978011123940093995" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( 13123.8, 617.59, 966.31 ), ( 0, 14.07, 0 ), "cspf_0_auto17335372497169027574", undefined, "interact" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( 14152.7, -4705.47, 576.22 ), ( 0, 32.61, 0 ), "cspf_0_auto15978011123940093995" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    s.script_radius = int( 3000 );
    fe [[ f ]]( s, us, cf, ( 14162.4, -2846.08, 632.34 ), ( 0, 254.37, 0 ), "cspf_0_auto4544706440968475029", "cspf_0_auto9709692143619376135", "zone_farm", undefined, undefined, undefined, undefined, 3000 );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( 14028.9, -3163.34, 637.17 ), ( 0, 254.37, 0 ), "cspf_0_auto9709692143619376135", undefined, "hvt_spawn_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( 12826.2, 1312.96, 964.85 ), ( 0, 264.65, 0 ), "cspf_0_auto17335372497169027574", "cspf_0_auto15474361460168494059", "teleport_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( 12801.1, 1331.51, 913.37 ), ( 0, 264.65, 0 ), "cspf_0_auto15474361460168494059" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( 12843.4, 1328.69, 915.18 ), ( 0, 264.65, 0 ), "cspf_0_auto15474361460168494059" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( 12767.2, 1335.09, 911.66 ), ( 0, 264.65, 0 ), "cspf_0_auto15474361460168494059" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    s.script_radius = int( 5000 );
    fe [[ f ]]( s, us, cf, ( 13128.5, 601.33, 904.29 ), ( 0, 101.3, 0 ), "cspf_0_auto4544706440968475029", "cspf_0_auto17335372497169027574", "zone_lakefront", undefined, undefined, undefined, undefined, 5000 );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( 13116.7, 649.95, 921.4 ), ( 0, 101.3, 0 ), "cspf_0_auto17335372497169027574", undefined, "hvt_spawn_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( 3028.42, 426.24, 472.43 ), ( 0, 195.9, 0 ), "cspf_0_auto16317579466588978503" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( 2348.97, 296.08, 647.82 ), ( 0, 211.93, 0 ), "cspf_0_auto10361305985053464693", undefined, "interact" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( 2985.99, 427.49, 557.66 ), ( 0, 195.9, 0 ), "cspf_0_auto10361305985053464693", "cspf_0_auto16317579466588978503", "teleport_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( 3005.16, 498.35, 472.43 ), ( 0, 195.9, 0 ), "cspf_0_auto16317579466588978503" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( 3017.88, 457.9, 472.43 ), ( 0, 195.9, 0 ), "cspf_0_auto16317579466588978503" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( 2996.24, 531.21, 472.43 ), ( 0, 195.9, 0 ), "cspf_0_auto16317579466588978503" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    s.script_radius = int( 7000 );
    fe [[ f ]]( s, us, cf, ( 2335.56, 314.28, 586.21 ), ( 0, 299.15, 0 ), "cspf_0_auto4544706440968475029", "cspf_0_auto10361305985053464693", "zone_middle_bridge", undefined, undefined, undefined, undefined, 7000 );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( 3052.82, 291.05, 446.91 ), ( 0, 299.15, 0 ), "cspf_0_auto10361305985053464693", undefined, "hvt_spawn_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( -8240.84, -5218.66, 1586.22 ), ( 0, 235.91, 0 ), "cspf_0_auto16115195696320996022" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( -8631.8, -5250.73, 1634.86 ), ( 0, 324.64, 0 ), "cspf_0_auto9070655922325894130", undefined, "interact" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( -8274.14, -5244.98, 1671.44 ), ( 0, 235.91, 0 ), "cspf_0_auto9070655922325894130", "cspf_0_auto16115195696320996022", "teleport_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( -8305.02, -5178.39, 1586.22 ), ( 0, 235.91, 0 ), "cspf_0_auto16115195696320996022" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( -8269.27, -5201.19, 1586.22 ), ( 0, 235.91, 0 ), "cspf_0_auto16115195696320996022" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( -8332.98, -5158.96, 1586.22 ), ( 0, 235.91, 0 ), "cspf_0_auto16115195696320996022" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    s.script_radius = int( 6000 );
    fe [[ f ]]( s, us, cf, ( -8645.61, -5268.37, 1575.84 ), ( 0, 51.86, 0 ), "cspf_0_auto4544706440968475029", "cspf_0_auto9070655922325894130", "zone_launcher", undefined, undefined, undefined, undefined, 6000 );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( -8595.22, -5207.18, 1588.94 ), ( 0, 49.27, 0 ), "cspf_0_auto9070655922325894130", undefined, "hvt_spawn_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( -13481.7, 2567.19, 415.92 ), ( 0, 184.14, 0 ), "cspf_0_auto6923357144908759424" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( -13858.3, 2645.08, 474.24 ), ( 0, 254.38, 0 ), "cspf_0_auto12579647553266942913", undefined, "interact" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( -13534, 2611.97, 460.94 ), ( 0, 184.14, 0 ), "cspf_0_auto12579647553266942913", "cspf_0_auto6923357144908759424", "teleport_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( -13489.8, 2642.45, 414.7 ), ( 0, 184.14, 0 ), "cspf_0_auto6923357144908759424" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( -13485.6, 2600.27, 415.11 ), ( 0, 184.14, 0 ), "cspf_0_auto6923357144908759424" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( -13491.8, 2676.44, 414.57 ), ( 0, 184.14, 0 ), "cspf_0_auto6923357144908759424" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    s.script_radius = int( 4000 );
    fe [[ f ]]( s, us, cf, ( -13889.1, 2654.68, 416.48 ), ( 0, 341.6, 0 ), "cspf_0_auto4544706440968475029", "cspf_0_auto12579647553266942913", "zone_115", undefined, undefined, undefined, undefined, 4000 );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( -13405.1, 3024.22, 412.62 ), ( 0, 341.6, 0 ), "cspf_0_auto12579647553266942913", undefined, "hvt_spawn_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( 13866.4, -3108.24, 638.71 ), ( 0, 0, 0 ), "cspf_0_auto9709692143619376135", undefined, "override_exfil_center", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( 23796.2, 818.36, 319.5 ), ( 0, 0, 0 ), "cspf_0_auto1284933450841619039", undefined, "override_exfil_center", undefined, undefined, undefined, undefined, 1250 );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( 2938.72, 217.5, 405.48 ), ( 0, 0, 0 ), "cspf_0_auto10361305985053464693", undefined, "override_exfil_center" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_exfil_create_script";
    fe [[ f ]]( s, us, cf, ( -13399, 2977, 414 ), ( 0, 0, 0 ), "cspf_0_auto12579647553266942913", undefined, "override_exfil_center", undefined, undefined, undefined, undefined, 1000 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_exfil_create_script
// Params 0, eflags: 0x4
// Checksum 0x6c0cab4e, Offset: 0x135f
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_exfil_create_script
// Params 0
// Checksum 0x357cdcd8, Offset: 0x1369
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_exfil_create_script" );
}

