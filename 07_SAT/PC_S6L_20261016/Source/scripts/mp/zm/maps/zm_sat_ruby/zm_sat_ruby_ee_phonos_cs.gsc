// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_ee_phonos_cs.gsc  (hash_55e67a4f5aad1233.gscc) (size: 3757 Bytes / 0xead / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9a42ffed (2588082157)
// size ...... 3757 (0xead)
// includes .. 3   (offset: 0xcf1)
// strings ... 23  (offset: 0xd09)
// dev strs .. 0   (offset: 0xead)
// exports ... 9   (offset: 0x959)
// cseg ...... 0x252 + 0x707 (0x959)
// imports ... 20  (offset: 0xac1)
// animtree1 . 0   (offset: 0xead)
// animtree2 . 0   (offset: 0xead)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_ruby_ee_phonos_cs;

// Namespace zm_sat_ruby_ee_phonos_cs
// Params 0, eflags: 0x5
// Checksum 0xe0d55618, Offset: 0x270
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_ruby_ee_phonos_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_ruby_ee_phonos_cs
// Params 0, eflags: 0x4
// Checksum 0xf585b3ea, Offset: 0x291
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_ruby_ee_phonos_cs
// Params 0, eflags: 0x4
// Checksum 0x70be6006, Offset: 0x2a2
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_ruby_ee_phonos_cs
// Params 2
// Checksum 0xc057364f, Offset: 0x2b3
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_ruby_ee_phonos_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_ruby_ee_phonos_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_ruby_ee_phonos_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_ruby_ee_phonos_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_ruby_ee_phonos_cs
// Params 3, eflags: 0x4
// Checksum 0xf33cd4c9, Offset: 0x33b
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_ruby_ee_phonos_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_ruby_ee_phonos_cs" );
}

// Namespace zm_sat_ruby_ee_phonos_cs
// Params 3, eflags: 0x4
// Checksum 0x5072925d, Offset: 0x3b5
// Size: 0x584
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_phonos_cs";
    fe [[ f ]]( s, us, cf, ( -344.78, -157.02, 321 ), ( 0, 141.7, 0 ), "cspf_0_auto16830129582014560268", "ee_phonos_center" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_phonos_cs";
    fe [[ f ]]( s, us, cf, ( -322, -175, 300 ), ( 0, 141.7, 0 ), "ee_phonos_center" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_phonos_cs";
    s.name = "record_placed";
    fe [[ f ]]( s, us, cf, ( -325.25, -172.7, 287 ), ( 0, 0, 0 ), "ee_phonos_record_placed", "cspf_0_auto16830129582014560268", "museum" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_phonos_cs";
    fe [[ f ]]( s, us, cf, ( 1686, 1053, 332 ), ( 0, 219.3, 0 ), "ee_phonos_capture_2", "ee_phonos_center_2", "2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_phonos_cs";
    fe [[ f ]]( s, us, cf, ( 1711, 1074, 309 ), ( 0, 219.3, 0 ), "ee_phonos_center_2", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_phonos_cs";
    s.name = "record_placed";
    fe [[ f ]]( s, us, cf, ( 1708, 1071, 295 ), ( 0, 217.7, 0 ), "ee_phonos_record_placed", "ee_phonos_capture_2", "planetarium" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_phonos_cs";
    fe [[ f ]]( s, us, cf, ( 1585.22, -3055.79, 83 ), ( 0, 49.6, 0 ), "cspf_0_auto12138776016512835169", "ee_phonos_center_3", "3" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_phonos_cs";
    fe [[ f ]]( s, us, cf, ( 1566.05, -3079.14, 63 ), ( 0, 49.6, 0 ), "ee_phonos_center_3", undefined, "3" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_phonos_cs";
    s.name = "record_placed";
    fe [[ f ]]( s, us, cf, ( 1568.41, -3076.42, 49 ), ( 0, 48, 0 ), "ee_phonos_record_placed", "cspf_0_auto12138776016512835169", "study" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_phonos_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 94, 90, 72 );
    s._size_min = ( 288, 416, 32 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 1646, 1044, 266 ), ( 0, 6, 0 ), "ee_phonos_capture_trigger_planetarium" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_phonos_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 128;
    fe [[ f ]]( s, us, cf, ( -325, -173, 214 ), ( 0, 0, 0 ), "ee_phonos_capture_trigger_museum", undefined, undefined, undefined, undefined, undefined, undefined, 333 );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_phonos_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 469, 225, 32 );
    s._size_min = ( 63, 223, 70 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 1624, -3026, 76 ), ( 0, 356.9, 0 ), "ee_phonos_capture_trigger_study" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_phonos_cs";
    fe [[ f ]]( s, us, cf, ( -371, -181, 220 ), ( 0, 192.1, 0 ), "ee_phonos_reward_museum" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_phonos_cs";
    fe [[ f ]]( s, us, cf, ( 1604, -3039, 8 ), ( 0, 51.8, 0 ), "ee_phonos_reward_study" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ee_phonos_cs";
    fe [[ f ]]( s, us, cf, ( 1681.86, 1043.97, 253 ), ( 0, 220.3, 0 ), "ee_phonos_reward_planetarium" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_ruby_ee_phonos_cs
// Params 0, eflags: 0x4
// Checksum 0xdc0ee9df, Offset: 0x941
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_ruby_ee_phonos_cs
// Params 0
// Checksum 0x316f0984, Offset: 0x94b
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_ruby_ee_phonos_cs" );
}

