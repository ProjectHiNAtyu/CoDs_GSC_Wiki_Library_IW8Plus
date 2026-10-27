// script_7d7d51d89aa853fa  (hash_7d7d51d89aa853fa.gscc) (size: 3436 Bytes / 0xd6c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbc60bfc2 (3160457154)
// size ...... 3436 (0xd6c)
// includes .. 3   (offset: 0xbd8)
// strings ... 23  (offset: 0xbf0)
// dev strs .. 0   (offset: 0xd6c)
// exports ... 9   (offset: 0x840)
// cseg ...... 0x25d + 0x5e3 (0x840)
// imports ... 20  (offset: 0x9a8)
// animtree1 . 0   (offset: 0xd6c)
// animtree2 . 0   (offset: 0xd6c)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_mantis_script_mannequin_wish_ee_cs;

// Namespace zm_sat_mantis_script_mannequin_wish_ee_cs
// Params 0, eflags: 0x5
// Checksum 0xe0c25805, Offset: 0x27b
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_mantis_script_mannequin_wish_ee_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_mantis_script_mannequin_wish_ee_cs
// Params 0, eflags: 0x4
// Checksum 0xff82a3ea, Offset: 0x29c
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_mantis_script_mannequin_wish_ee_cs
// Params 0, eflags: 0x4
// Checksum 0x7ab97006, Offset: 0x2ad
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_mantis_script_mannequin_wish_ee_cs
// Params 2
// Checksum 0xca50264f, Offset: 0x2be
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_mantis_script_mannequin_wish_ee_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_mantis_script_mannequin_wish_ee_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_mantis_script_mannequin_wish_ee_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_mantis_script_mannequin_wish_ee_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_mantis_script_mannequin_wish_ee_cs
// Params 3, eflags: 0x4
// Checksum 0xf93bc4c9, Offset: 0x346
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_mantis_script_mannequin_wish_ee_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_mantis_script_mannequin_wish_ee_cs" );
}

// Namespace zm_sat_mantis_script_mannequin_wish_ee_cs
// Params 3, eflags: 0x4
// Checksum 0x24da88c6, Offset: 0x3c0
// Size: 0x460
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_mannequin_wish_ee_cs";
    s.name = "sit_mannequin_loc";
    fe [[ f ]]( s, us, cf, ( 56429.5, -31577.5, -118.5 ), ( 0, 148.89, 0 ), undefined, undefined, "mannequin_eat_food_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_mannequin_wish_ee_cs";
    s.name = "pan_kill_distance_check";
    fe [[ f ]]( s, us, cf, ( 79043, -31671, -121 ), ( 0, 336.45, 0 ), undefined, undefined, "pan_kill_distance_check", undefined, undefined, undefined, undefined, 60 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_mannequin_wish_ee_cs";
    s.name = "pan_loc";
    fe [[ f ]]( s, us, cf, ( 79072.4, -31702.8, -82 ), ( 0, 330, 0 ), undefined, undefined, "mw_pan_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_mannequin_wish_ee_cs";
    s.name = "stand_mannequin_loc_bunker";
    fe [[ f ]]( s, us, cf, ( 77772.3, -29517.2, -128.97 ), ( 0, 2.66, 0 ), "mannequin_bunker_meet_loc_col", undefined, "mannequin_bunker_meet_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_mannequin_wish_ee_cs";
    s.name = "meat_loc";
    fe [[ f ]]( s, us, cf, ( 79077, -31705, -84 ), ( 0, 0, 0 ), undefined, undefined, "pan_meat_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_mannequin_wish_ee_cs";
    s.name = "steak_loc";
    fe [[ f ]]( s, us, cf, ( 56421.7, -31577.3, -87 ), ( 0, 42.53, 0 ), undefined, undefined, "steak_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_mannequin_wish_ee_cs";
    s.name = "lure_zombie_attack_location";
    fe [[ f ]]( s, us, cf, ( 77783.5, -29544, -128.75 ), ( 0, 21.63, 0 ), undefined, undefined, "lure_zombie_attack_location" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_mannequin_wish_ee_cs";
    s.name = "food_plate_loc";
    fe [[ f ]]( s, us, cf, ( 56421.7, -31577.3, -87 ), ( 0, 0, 0 ), undefined, undefined, "food_plate_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_mannequin_wish_ee_cs";
    fe [[ f ]]( s, us, cf, ( 77810.5, -29533, -93 ), ( 0, 21.63, 0 ), undefined, undefined, "mw_zombie_attaractor", undefined, undefined, undefined, undefined, 600 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_mannequin_wish_ee_cs";
    s.name = "glasses_loc";
    fe [[ f ]]( s, us, cf, ( 56414.7, -31592.2, -86.75 ), ( 0, 0, -23.21 ), undefined, undefined, "glasses_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_mannequin_wish_ee_cs";
    s.name = "final_reward_cache";
    fe [[ f ]]( s, us, cf, ( 55264.5, -29542, -125 ), ( 0, 203.87, 0 ), undefined, undefined, "final_reward_cache" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_mannequin_wish_ee_cs";
    s.name = "fork_loc";
    fe [[ f ]]( s, us, cf, ( 56440.5, -31575, -81 ), ( 3.46, 334.66, 54.48 ), undefined, undefined, "fork_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_mannequin_wish_ee_cs";
    s.name = "stand_mannequin_loc_step1";
    fe [[ f ]]( s, us, cf, ( 56526.5, -31676.5, -121 ), ( 0, 335, 0 ), "mannequin_first_meet_loc_col", undefined, "mannequin_first_meet_loc" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_mantis_script_mannequin_wish_ee_cs
// Params 0, eflags: 0x4
// Checksum 0xd32acc, Offset: 0x828
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_mantis_script_mannequin_wish_ee_cs
// Params 0
// Checksum 0x3b681984, Offset: 0x832
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_mantis_script_mannequin_wish_ee_cs" );
}

