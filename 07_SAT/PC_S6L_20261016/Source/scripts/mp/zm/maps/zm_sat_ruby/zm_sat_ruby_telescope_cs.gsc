// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_telescope_cs.gsc  (hash_13fd7af88d02122b.gscc) (size: 4849 Bytes / 0x12f1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1cc90a80 (482937472)
// size ...... 4849 (0x12f1)
// includes .. 3   (offset: 0xff1)
// strings ... 38  (offset: 0x1009)
// dev strs .. 0   (offset: 0x12f1)
// exports ... 9   (offset: 0xc59)
// cseg ...... 0x1ca + 0xa8f (0xc59)
// imports ... 20  (offset: 0xdc1)
// animtree1 . 0   (offset: 0x12f1)
// animtree2 . 0   (offset: 0x12f1)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_ruby_telescope_cs;

// Namespace zm_sat_ruby_telescope_cs
// Params 0, eflags: 0x5
// Checksum 0x91e22fbe, Offset: 0x1e8
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_ruby_telescope_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_ruby_telescope_cs
// Params 0, eflags: 0x4
// Checksum 0xe4c36eb4, Offset: 0x209
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_ruby_telescope_cs
// Params 0, eflags: 0x4
// Checksum 0x61f8bd58, Offset: 0x21a
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_ruby_telescope_cs
// Params 2
// Checksum 0xd111eb11, Offset: 0x22b
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_ruby_telescope_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_ruby_telescope_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_ruby_telescope_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_ruby_telescope_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_ruby_telescope_cs
// Params 3, eflags: 0x4
// Checksum 0xe27a0997, Offset: 0x2b3
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_ruby_telescope_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_ruby_telescope_cs" );
}

// Namespace zm_sat_ruby_telescope_cs
// Params 3, eflags: 0x4
// Checksum 0xe999dc42, Offset: 0x32d
// Size: 0x90c
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_ruby_telescope_cs";
    s.name = "rh";
    fe [[ f ]]( s, us, cf, ( -1280.5, -253.5, 2.5 ), ( 319.45, 106.03, 66.14 ), "rh_kite_1" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_telescope_cs";
    s.declination = "58";
    s.declination_min = "19";
    s.name = "telescope_target_pos";
    fe [[ f ]]( s, us, cf, ( -1268, -228.5, 43.75 ), ( 0, 0, 0 ), "telescope_target_positions", undefined, "no_sun" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_telescope_cs";
    s.name = "telescope_view";
    fe [[ f ]]( s, us, cf, ( -1200.5, -207.75, -70.75 ), ( 310, 180, -0 ), "telescope_view_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_telescope_cs";
    s.declination = "52";
    s.declination_min = "57";
    s.name = "telescope_target_pos";
    fe [[ f ]]( s, us, cf, ( -1281.75, -191.75, 39 ), ( 313, 180, -0 ), "telescope_target_positions" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_telescope_cs";
    s.declination = "53";
    s.declination_min = "08";
    s.name = "telescope_target_pos";
    fe [[ f ]]( s, us, cf, ( -1282.25, -220, 39.5 ), ( 313, 180, -0 ), "telescope_target_positions" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_telescope_cs";
    s.declination = "46";
    s.declination_min = "01";
    s.name = "telescope_target_pos";
    fe [[ f ]]( s, us, cf, ( -1295, -211.25, 27.25 ), ( 313, 180, -0 ), "telescope_target_positions" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_telescope_cs";
    s.declination = "57";
    s.declination_min = "29";
    s.name = "telescope_target_pos";
    fe [[ f ]]( s, us, cf, ( -1273.75, -202, 44.5 ), ( 313, 180, -0 ), "telescope_target_positions" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_telescope_cs";
    s.declination = "45";
    s.declination_min = "28";
    s.name = "telescope_target_pos";
    fe [[ f ]]( s, us, cf, ( -1295.75, -196.5, 26.75 ), ( 313, 180, -0 ), "telescope_target_positions" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_telescope_cs";
    s.name = "rh";
    fe [[ f ]]( s, us, cf, ( -1256, -164.25, 37.5 ), ( 0, 0, 0 ), "rh_kite_2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_telescope_cs";
    s.declination = "47";
    s.declination_min = "31";
    s.name = "telescope_target_pos";
    fe [[ f ]]( s, us, cf, ( -1292.25, -219.5, 30.25 ), ( 313, 180, -0 ), "telescope_target_positions" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_telescope_cs";
    s.declination = "51";
    s.declination_min = "59";
    s.name = "telescope_target_pos";
    fe [[ f ]]( s, us, cf, ( -1284.25, -196.5, 37.5 ), ( 313, 180, -0 ), "telescope_target_positions" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_telescope_cs";
    s.declination = "42";
    s.declination_min = "25";
    s.name = "telescope_target_pos";
    fe [[ f ]]( s, us, cf, ( -1296, -235.75, 20.25 ), ( 0, 0, 0 ), "telescope_target_positions", undefined, "no_sun" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_telescope_cs";
    s.name = "jumpscare";
    fe [[ f ]]( s, us, cf, ( -1294.25, -238, 19 ), ( 358.56, 9.62, 4.03 ), "ruby_ee_js" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_telescope_cs";
    s.declination = "42";
    s.declination_min = "23";
    s.name = "telescope_target_pos";
    fe [[ f ]]( s, us, cf, ( -1296, -178.5, 20.25 ), ( 0, 0, 0 ), "telescope_target_positions", undefined, "no_sun" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_telescope_cs";
    s.declination = "58";
    s.declination_min = "22";
    s.name = "telescope_target_pos";
    fe [[ f ]]( s, us, cf, ( -1266.75, -186.5, 44.5 ), ( 0, 0, 0 ), "telescope_target_positions", undefined, "no_sun" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_telescope_cs";
    s.declination = "57";
    s.declination_min = "05";
    s.name = "telescope_target_pos";
    fe [[ f ]]( s, us, cf, ( -1273.25, -222.5, 44 ), ( 313, 180, -0 ), "telescope_target_positions" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_telescope_cs";
    s.declination = "46";
    s.declination_min = "10";
    s.name = "telescope_target_pos";
    fe [[ f ]]( s, us, cf, ( -1292.75, -229.5, 28 ), ( 313, 180, -0 ), "telescope_target_positions" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_telescope_cs";
    s.declination = "48";
    s.declination_min = "31";
    s.name = "telescope_target_pos";
    fe [[ f ]]( s, us, cf, ( -1289.25, -185.5, 32.75 ), ( 313, 180, -0 ), "telescope_target_positions" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_telescope_cs";
    s.declination = "53";
    s.declination_min = "19";
    s.name = "telescope_target_pos";
    fe [[ f ]]( s, us, cf, ( -1281.25, -228.25, 38.5 ), ( 313, 180, -0 ), "telescope_target_positions" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_telescope_cs";
    s.declination = "55";
    s.declination_min = "21";
    s.name = "telescope_target_pos";
    fe [[ f ]]( s, us, cf, ( -1276.25, -189.5, 42 ), ( 313, 180, -0 ), "telescope_target_positions" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_telescope_cs";
    s.declination = "57";
    s.declination_min = "41";
    s.name = "telescope_target_pos";
    fe [[ f ]]( s, us, cf, ( -1273.75, -211.25, 44.5 ), ( 313, 180, -0 ), "telescope_target_positions" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_ruby_telescope_cs
// Params 0, eflags: 0x4
// Checksum 0x858937ab, Offset: 0xc41
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_ruby_telescope_cs
// Params 0
// Checksum 0x2029d4da, Offset: 0xc4b
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_ruby_telescope_cs" );
}

