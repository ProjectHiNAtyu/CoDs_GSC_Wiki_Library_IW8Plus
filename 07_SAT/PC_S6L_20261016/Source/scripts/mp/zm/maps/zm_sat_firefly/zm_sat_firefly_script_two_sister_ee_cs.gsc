// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_two_sister_ee_cs.gsc  (hash_174cf0f57ff940ed.gscc) (size: 4578 Bytes / 0x11e2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3dc039be (1036007870)
// size ...... 4578 (0x11e2)
// includes .. 3   (offset: 0xfba)
// strings ... 23  (offset: 0xfd2)
// dev strs .. 0   (offset: 0x11e2)
// exports ... 9   (offset: 0xc22)
// cseg ...... 0x2aa + 0x978 (0xc22)
// imports ... 20  (offset: 0xd8a)
// animtree1 . 0   (offset: 0x11e2)
// animtree2 . 0   (offset: 0x11e2)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_firefly_script_two_sister_ee_cs;

// Namespace zm_sat_firefly_script_two_sister_ee_cs
// Params 0, eflags: 0x5
// Checksum 0x8af79609, Offset: 0x2c8
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_script_two_sister_ee_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_firefly_script_two_sister_ee_cs
// Params 0, eflags: 0x4
// Checksum 0x1e367f3e, Offset: 0x2e9
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_firefly_script_two_sister_ee_cs
// Params 0, eflags: 0x4
// Checksum 0x9b0dacd2, Offset: 0x2fa
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_firefly_script_two_sister_ee_cs
// Params 2
// Checksum 0x2be4fa9b, Offset: 0x30b
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_script_two_sister_ee_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_firefly_script_two_sister_ee_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_script_two_sister_ee_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_script_two_sister_ee_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_script_two_sister_ee_cs
// Params 3, eflags: 0x4
// Checksum 0x188f181d, Offset: 0x393
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_script_two_sister_ee_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_script_two_sister_ee_cs" );
}

// Namespace zm_sat_firefly_script_two_sister_ee_cs
// Params 3, eflags: 0x4
// Checksum 0xf52d1f7e, Offset: 0x40d
// Size: 0x7f5
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_two_sister_ee_cs";
    fe [[ f ]]( s, us, cf, ( 13280.9, -3469.51, 675.44 ), ( 0, 355.97, 0 ), "cspf_0_auto16868856095615670482", undefined, "2nd_girl" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_two_sister_ee_cs";
    fe [[ f ]]( s, us, cf, ( 13395.8, -3368.02, 884.08 ), ( 0, 327.9, 0 ), undefined, "cspf_0_auto9132620263224643675", "ts_ee_tv_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_two_sister_ee_cs";
    fe [[ f ]]( s, us, cf, ( 13404.4, -3371.22, 876.78 ), ( 0, 331.5, 0 ), "cspf_0_auto9132620263224643675" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_two_sister_ee_cs";
    fe [[ f ]]( s, us, cf, ( 13512.7, -3971.44, 411.68 ), ( 0, 329.64, 0 ), undefined, undefined, "ts_ee_girl_loc_1st_1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_two_sister_ee_cs";
    fe [[ f ]]( s, us, cf, ( 13280.5, -3494.94, 675.12 ), ( 0, 355.97, 0 ), "cspf_0_auto16868856095615670482", undefined, "1st_girl" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_two_sister_ee_cs";
    fe [[ f ]]( s, us, cf, ( 15348.5, -3840.65, 568.77 ), ( 0, 250.97, 0 ), undefined, undefined, "ts_ee_girl_loc_teddy" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_two_sister_ee_cs";
    fe [[ f ]]( s, us, cf, ( 15252.9, -3400.09, 595.24 ), ( 0, 190.97, 0 ), "cspf_0_auto10822173651046824317", undefined, "2nd_girl" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_two_sister_ee_cs";
    fe [[ f ]]( s, us, cf, ( 15181.7, -3317.12, 609.23 ), ( 0, 195, 0 ), undefined, "cspf_0_auto10822173651046824317", "ts_ee_sisters_spawn_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_two_sister_ee_cs";
    fe [[ f ]]( s, us, cf, ( 13332.8, -3477.95, 683.88 ), ( 0, 195, 0 ), undefined, "cspf_0_auto16868856095615670482", "ts_ee_sisters_spawn_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_two_sister_ee_cs";
    fe [[ f ]]( s, us, cf, ( 13615.3, -4940.37, 590.97 ), ( 0, 240, 0 ), undefined, "cspf_0_auto7692380156482330042", "ts_ee_sisters_spawn_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_two_sister_ee_cs";
    fe [[ f ]]( s, us, cf, ( 13039.6, -4832.17, 592.09 ), ( 0, 345, 0 ), undefined, "cspf_0_auto11691582006148682570", "ts_ee_sisters_spawn_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_two_sister_ee_cs";
    fe [[ f ]]( s, us, cf, ( 12925.3, -4211.3, 600.63 ), ( 0, 30, 0 ), undefined, "cspf_0_auto8079611343471829483", "ts_ee_sisters_spawn_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_two_sister_ee_cs";
    fe [[ f ]]( s, us, cf, ( 12828.5, -3299.15, 667.02 ), ( 0, 360, 0 ), undefined, "cspf_0_auto10468841969768799209", "ts_ee_sisters_spawn_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_two_sister_ee_cs";
    fe [[ f ]]( s, us, cf, ( 15246.7, -3375.46, 593.25 ), ( 0, 190.97, 0 ), "cspf_0_auto10822173651046824317", undefined, "1st_girl" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_two_sister_ee_cs";
    fe [[ f ]]( s, us, cf, ( 13658, -4939.22, 584.33 ), ( 0, 220.97, 0 ), "cspf_0_auto7692380156482330042", undefined, "2nd_girl" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_two_sister_ee_cs";
    fe [[ f ]]( s, us, cf, ( 13640.4, -4920.92, 583.65 ), ( 0, 220.97, 0 ), "cspf_0_auto7692380156482330042", undefined, "1st_girl" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_two_sister_ee_cs";
    fe [[ f ]]( s, us, cf, ( 13006.9, -4811.9, 585.6 ), ( 0, 340.97, 0 ), "cspf_0_auto11691582006148682570", undefined, "2nd_girl" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_two_sister_ee_cs";
    fe [[ f ]]( s, us, cf, ( 12999.8, -4836.3, 585.91 ), ( 0, 340.97, 0 ), "cspf_0_auto11691582006148682570", undefined, "1st_girl" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_two_sister_ee_cs";
    fe [[ f ]]( s, us, cf, ( 12918.8, -4191.33, 606 ), ( 0, 355.97, 0 ), "cspf_0_auto8079611343471829483", undefined, "2nd_girl" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_two_sister_ee_cs";
    fe [[ f ]]( s, us, cf, ( 12917.8, -4215.49, 603.48 ), ( 0, 10.97, 0 ), "cspf_0_auto8079611343471829483", undefined, "1st_girl" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_two_sister_ee_cs";
    fe [[ f ]]( s, us, cf, ( 12824.4, -3288.89, 663.48 ), ( 0, 355.97, 0 ), "cspf_0_auto10468841969768799209", undefined, "2nd_girl" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_two_sister_ee_cs";
    fe [[ f ]]( s, us, cf, ( 12823.9, -3314.29, 665.24 ), ( 0, 355.97, 0 ), "cspf_0_auto10468841969768799209", undefined, "1st_girl" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_two_sister_ee_cs";
    fe [[ f ]]( s, us, cf, ( 15363.5, -3840.4, 567.25 ), ( 0, 250.97, 0 ), "cspf_0_auto15606492073331924708", undefined, "ts_ee_girl_loc_1st_2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_two_sister_ee_cs";
    fe [[ f ]]( s, us, cf, ( 15339, -3833.4, 570.93 ), ( 0, 250.97, 0 ), undefined, undefined, "ts_ee_girl_loc_2nd_1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_two_sister_ee_cs";
    fe [[ f ]]( s, us, cf, ( 24727.3, 317.7, 422.05 ), ( 0, 0, 0 ), undefined, undefined, "ts_ee_scene_test_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_two_sister_ee_cs";
    fe [[ f ]]( s, us, cf, ( 13561.7, -3933.22, 412.75 ), ( 270.06, 73.13, 12.77 ), undefined, undefined, "ts_ee_chalk_draw_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_two_sister_ee_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 300, 232, 8 );
    s._size_min = ( 32, 111.853, 22 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 13410.7, -3371.32, 861.01 ), ( 0, 314.8, 0 ), undefined, undefined, "check_players_in_tv_room" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_two_sister_ee_cs";
    fe [[ f ]]( s, us, cf, ( 13508.3, -3417.58, 860.41 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_script_two_sister_ee_cs
// Params 0, eflags: 0x4
// Checksum 0xf12114c2, Offset: 0xc0a
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_script_two_sister_ee_cs
// Params 0
// Checksum 0xdadcc550, Offset: 0xc14
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_script_two_sister_ee_cs" );
}

