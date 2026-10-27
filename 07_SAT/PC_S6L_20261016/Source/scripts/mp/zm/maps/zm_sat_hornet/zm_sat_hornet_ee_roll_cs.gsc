// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ee_roll_cs.gsc  (hash_168a94c1b2dee273.gscc) (size: 2496 Bytes / 0x9c0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe28d6408 (3800917000)
// size ...... 2496 (0x9c0)
// includes .. 2   (offset: 0x89c)
// strings ... 15  (offset: 0x8ac)
// dev strs .. 0   (offset: 0x9c0)
// exports ... 6   (offset: 0x5ec)
// cseg ...... 0x190 + 0x45c (0x5ec)
// imports ... 16  (offset: 0x6dc)
// animtree1 . 0   (offset: 0x9c0)
// animtree2 . 0   (offset: 0x9c0)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_hornet_ee_roll_cs;

// Namespace zm_sat_hornet_ee_roll_cs
// Params 2
// Checksum 0x9b2ca479, Offset: 0x1ae
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_hornet_ee_roll_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_hornet_ee_roll_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_hornet_ee_roll_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_hornet_ee_roll_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_hornet_ee_roll_cs
// Params 3, eflags: 0x4
// Checksum 0xa84746ff, Offset: 0x236
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_hornet_ee_roll_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_hornet_ee_roll_cs" );
}

// Namespace zm_sat_hornet_ee_roll_cs
// Params 3, eflags: 0x4
// Checksum 0x3fe9889, Offset: 0x2b0
// Size: 0x31c
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_roll_cs";
    fe [[ f ]]( s, us, cf, ( 3108, -20581, 418.32 ), ( 0, 76, 0 ), "gch_r_start" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_roll_cs";
    fe [[ f ]]( s, us, cf, ( 3091.99, -20583.1, 428.32 ), ( 0, 76, 0 ), "gch_r_end" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_roll_cs";
    fe [[ f ]]( s, us, cf, ( 3093, -20583, 420.32 ), ( 0, 76, 0 ), "gch_r_ctrl" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_roll_cs";
    fe [[ f ]]( s, us, cf, ( 3123, -20595, 383 ), ( 0, 173.1, 0 ), "gch_bar" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_roll_cs";
    fe [[ f ]]( s, us, cf, ( 3077, -20581, 433.32 ), ( 0, 353.1, 0 ), "gch_cam" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_roll_cs";
    s.groupid = "trail_path";
    fe [[ f ]]( s, us, cf, ( 3000, -20704, 409.32 ), ( 0, 180, 0 ), "cspf_0_auto17323803074291568319", "cspf_0_auto745313670465178504" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_roll_cs";
    s.groupid = "trail_path";
    fe [[ f ]]( s, us, cf, ( 3108, -20581, 417.32 ), ( 0, 180, 0 ), "gch_trail_path", "cspf_0_auto17323803074291568319" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_roll_cs";
    s.groupid = "trail_path";
    fe [[ f ]]( s, us, cf, ( 2824, -20744, 468.32 ), ( 0, 180, 0 ), "cspf_0_auto745313670465178504", "cspf_0_auto12868552679632718854" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_roll_cs";
    s.groupid = "trail_path";
    fe [[ f ]]( s, us, cf, ( 2581, -20690, 453.01 ), ( 357.48, 180.05, -1.19 ), "cspf_0_auto12868552679632718854", "cspf_0_auto5680303928471548103" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_roll_cs";
    s.groupid = "trail_path";
    fe [[ f ]]( s, us, cf, ( 2440, -20776, 417.4 ), ( 0, 0, 0 ), "cspf_0_auto5680303928471548103", "zone_second_bailey" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_hornet_ee_roll_cs
// Params 0, eflags: 0x4
// Checksum 0x3ded587, Offset: 0x5d4
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_hornet_ee_roll_cs
// Params 0
// Checksum 0x6a149bb2, Offset: 0x5de
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_hornet_ee_roll_cs" );
}

