// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_rh_cs.gsc  (hash_68951f73b65404a7.gscc) (size: 6995 Bytes / 0x1b53 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x98db7944 (2564520260)
// size ...... 6995 (0x1b53)
// includes .. 3   (offset: 0x16bb)
// strings ... 65  (offset: 0x16d3)
// dev strs .. 0   (offset: 0x1b53)
// exports ... 9   (offset: 0x1323)
// cseg ...... 0x318 + 0x100b (0x1323)
// imports ... 20  (offset: 0x148b)
// animtree1 . 0   (offset: 0x1b53)
// animtree2 . 0   (offset: 0x1b53)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_ruby_rh_cs;

// Namespace zm_sat_ruby_rh_cs
// Params 0, eflags: 0x5
// Checksum 0xe980e069, Offset: 0x336
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_ruby_rh_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_ruby_rh_cs
// Params 0, eflags: 0x4
// Checksum 0x1e383407, Offset: 0x357
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_ruby_rh_cs
// Params 0, eflags: 0x4
// Checksum 0x9b03e7eb, Offset: 0x368
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_ruby_rh_cs
// Params 2
// Checksum 0x2beab1a2, Offset: 0x379
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_ruby_rh_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_ruby_rh_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_ruby_rh_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_ruby_rh_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_ruby_rh_cs
// Params 3, eflags: 0x4
// Checksum 0x18815324, Offset: 0x401
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_ruby_rh_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_ruby_rh_cs" );
}

// Namespace zm_sat_ruby_rh_cs
// Params 3, eflags: 0x4
// Checksum 0x159a3bbd, Offset: 0x47b
// Size: 0xe88
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "deadbeat_final";
    fe [[ f ]]( s, us, cf, ( -2951, -533.75, -12 ), ( 0.17, 59.15, -1.38 ), "deadbeat_final", undefined, "1.80" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "deadbeat_p1";
    fe [[ f ]]( s, us, cf, ( 1676.25, 2231.75, 215.5 ), ( 0.17, 59.15, -1.38 ), "deadbeat_p1" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "deadbeat_s1";
    fe [[ f ]]( s, us, cf, ( 1627.25, 2461.75, 274.75 ), ( 0.17, 59.15, -1.38 ), "deadbeat_s1", undefined, "4" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "deadbeat_s2";
    fe [[ f ]]( s, us, cf, ( 863.5, 2523, 259.25 ), ( 0.17, 59.15, -1.38 ), "deadbeat_s2", undefined, "5" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "deadbeat_s3";
    fe [[ f ]]( s, us, cf, ( -517.5, 2218.75, 233.5 ), ( 0.17, 59.15, -1.38 ), "deadbeat_s3", undefined, "6" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "deadbeat_p2";
    fe [[ f ]]( s, us, cf, ( -394.5, 1759, 217.5 ), ( 0.17, 59.15, -1.38 ), "deadbeat_p2", undefined, "5" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "deadbeat_s4";
    fe [[ f ]]( s, us, cf, ( -2715, 1408, 189.25 ), ( 0.17, 59.15, -1.38 ), "deadbeat_s4", undefined, "12" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "deadbeat_s5";
    fe [[ f ]]( s, us, cf, ( -3106.25, 800.75, 320.25 ), ( 0.17, 59.15, -1.38 ), "deadbeat_s5", undefined, "7" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "deadbeat_p3";
    fe [[ f ]]( s, us, cf, ( -3278.75, -584.75, 336.25 ), ( 0.17, 59.15, -1.38 ), "deadbeat_p3", undefined, "7" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "deadbeat_s6";
    fe [[ f ]]( s, us, cf, ( -3149.75, -461.5, 310.75 ), ( 0.17, 59.15, -1.38 ), "deadbeat_s6", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "angel_spawn";
    fe [[ f ]]( s, us, cf, ( -4170.5, -45966.8, -10610.5 ), ( 0.17, 59.15, -1.38 ), "angel_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "angel_2";
    fe [[ f ]]( s, us, cf, ( -259, -40644.1, -9518.5 ), ( 0.17, 59.15, -1.38 ), "angel_2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "angel_1";
    fe [[ f ]]( s, us, cf, ( 8417, -39695.1, -10544.8 ), ( 0.17, 59.15, -1.38 ), "angel_1" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "angel_3";
    fe [[ f ]]( s, us, cf, ( 4913.25, -42630.6, -11905.2 ), ( 0.17, 59.15, -1.38 ), "angel_3" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "1_to_sp";
    fe [[ f ]]( s, us, cf, ( 5171.25, -42687.4, -12945.5 ), ( 354.74, 142.98, -5.95 ), "to_sp" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "1_go_ld";
    fe [[ f ]]( s, us, cf, ( 5026, -42562.4, -12987.8 ), ( 357.79, 127.72, -86.27 ), "go_ld" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "1_go_sp";
    fe [[ f ]]( s, us, cf, ( 5178, -42470.9, -12948.5 ), ( 353.47, 148.38, -2.94 ), "go_sp" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "1_to_ld";
    fe [[ f ]]( s, us, cf, ( 5021.75, -42586.9, -12985.8 ), ( 354.93, 50.81, 82.99 ), "to_ld" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "1_sp_sp";
    fe [[ f ]]( s, us, cf, ( 4807, -42687.1, -12951.2 ), ( 359.98, 141.18, -0.02 ), "sp_sp" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "1_sp_ld";
    fe [[ f ]]( s, us, cf, ( 5008.25, -42596.1, -12986.5 ), ( 283.64, 45.61, 93.86 ), "sp_ld" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "1_lv_sp";
    fe [[ f ]]( s, us, cf, ( 4809.75, -42475.1, -12937.2 ), ( 1.78, 195.64, 14.92 ), "lv_sp" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "1_lv_ld";
    fe [[ f ]]( s, us, cf, ( 4996.75, -42582.9, -12988.8 ), ( 278.81, 321.04, -179.86 ), "lv_ld" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "angel_center";
    fe [[ f ]]( s, us, cf, ( 4093.25, -41905.6, -10531 ), ( 0.17, 59.15, -1.38 ), "angel_center" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "angel_rot";
    fe [[ f ]]( s, us, cf, ( 487.5, -40338.4, -10623 ), ( 0.17, 59.15, -1.38 ), "angel_rot" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "ali";
    fe [[ f ]]( s, us, cf, ( 5003.25, -42578.4, -12993.7 ), ( 0.17, 59.15, -6.07 ), "ali" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "angel_4";
    fe [[ f ]]( s, us, cf, ( 4906.25, -42625.1, -11534.5 ), ( 0.17, 59.15, -1.38 ), "angel_4" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "angel_5";
    fe [[ f ]]( s, us, cf, ( 3034.5, -43729.1, -11553.8 ), ( 0.17, 59.15, -1.38 ), "angel_5" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "angel_6";
    fe [[ f ]]( s, us, cf, ( 5340.5, -44712.6, -11495.3 ), ( 0.17, 59.15, -1.38 ), "angel_6" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "angel_7";
    fe [[ f ]]( s, us, cf, ( 91863, -464351, 12764 ), ( 0.17, 59.15, -1.38 ), "angel_7" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "metro_fx_2";
    fe [[ f ]]( s, us, cf, ( 3051.25, -42398.6, -12960 ), ( 0, 0, 0 ), "metro_fx_2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "metro_fx_1";
    fe [[ f ]]( s, us, cf, ( 3130.5, -42713.1, -12960 ), ( 0, 180.01, 0 ), "metro_fx_1" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "angel_takeoff_1";
    fe [[ f ]]( s, us, cf, ( -4254.5, -45931.9, -10568.8 ), ( 0.17, 59.15, -1.38 ), "angel_takeoff_1" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "angel_8";
    fe [[ f ]]( s, us, cf, ( 4218.55, -39099.8, -10677.5 ), ( 0.17, 59.15, -1.38 ), "angel_8" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "m_vfx";
    fe [[ f ]]( s, us, cf, ( 5175.25, -42473.1, -12945.7 ), ( 0, 0, 0 ), "m_vfx", undefined, "f" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "m_vfx";
    fe [[ f ]]( s, us, cf, ( 5170, -42688.4, -12945.8 ), ( 0, 0, 0 ), "m_vfx", undefined, "t" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "m_vfx";
    fe [[ f ]]( s, us, cf, ( 4809, -42689.1, -12946.2 ), ( 0, 0, 0 ), "m_vfx", undefined, "s" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "m_vfx";
    fe [[ f ]]( s, us, cf, ( 4809.5, -42474.9, -12946 ), ( 0, 0, 0 ), "m_vfx", undefined, "l" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "rev";
    fe [[ f ]]( s, us, cf, ( 5031, -42615.6, -12988 ), ( 0, 0, 0 ), "rev" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "rev";
    fe [[ f ]]( s, us, cf, ( 4978.5, -42618.6, -12987.8 ), ( 0, 0, 0 ), "rev" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "rev";
    fe [[ f ]]( s, us, cf, ( 4976.25, -42566.4, -12987 ), ( 0, 0, 0 ), "rev" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "rev";
    fe [[ f ]]( s, us, cf, ( 5029, -42565.9, -12987 ), ( 0, 0, 0 ), "rev" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "1_to_md";
    fe [[ f ]]( s, us, cf, ( 5086, -42622.4, -12940.5 ), ( 354.74, 142.98, -5.95 ), "to_md" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "1_go_md";
    fe [[ f ]]( s, us, cf, ( 5093.5, -42533.6, -12958.5 ), ( 353.47, 148.38, -2.94 ), "go_md" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "1_lv_md";
    fe [[ f ]]( s, us, cf, ( 4934, -42510.9, -12915.2 ), ( 1.78, 195.64, 14.92 ), "lv_md" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_rh_cs";
    s.name = "1_sp_md";
    fe [[ f ]]( s, us, cf, ( 4908.25, -42625.4, -12954.5 ), ( 359.98, 141.18, -0.02 ), "sp_md" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_ruby_rh_cs
// Params 0, eflags: 0x4
// Checksum 0xbcfe3e71, Offset: 0x130b
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_ruby_rh_cs
// Params 0
// Checksum 0xdad28e69, Offset: 0x1315
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_ruby_rh_cs" );
}

