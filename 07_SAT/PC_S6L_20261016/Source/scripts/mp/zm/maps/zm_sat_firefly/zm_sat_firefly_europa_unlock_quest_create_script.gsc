// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_europa_unlock_quest_create_script.gsc  (hash_0e71f96861179a63.gscc) (size: 3864 Bytes / 0xf18 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xef1c768d (4011619981)
// size ...... 3864 (0xf18)
// includes .. 3   (offset: 0xd70)
// strings ... 19  (offset: 0xd88)
// dev strs .. 0   (offset: 0xf18)
// exports ... 9   (offset: 0x9d8)
// cseg ...... 0x226 + 0x7b2 (0x9d8)
// imports ... 20  (offset: 0xb40)
// animtree1 . 0   (offset: 0xf18)
// animtree2 . 0   (offset: 0xf18)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_firefly_europa_unlock_quest_create_script;

// Namespace zm_sat_firefly_europa_unlock_quest_create_script
// Params 0, eflags: 0x5
// Checksum 0x6ec67695, Offset: 0x244
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_europa_unlock_quest_create_script", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_firefly_europa_unlock_quest_create_script
// Params 0, eflags: 0x4
// Checksum 0xd963c43c, Offset: 0x265
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_firefly_europa_unlock_quest_create_script
// Params 0, eflags: 0x4
// Checksum 0x5c5817d0, Offset: 0x276
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_firefly_europa_unlock_quest_create_script
// Params 2
// Checksum 0xecb14199, Offset: 0x287
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_europa_unlock_quest_create_script" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_firefly_europa_unlock_quest_create_script" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_europa_unlock_quest_create_script" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_europa_unlock_quest_create_script" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_europa_unlock_quest_create_script
// Params 3, eflags: 0x4
// Checksum 0xdfdaa31f, Offset: 0x30f
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_europa_unlock_quest_create_script" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_europa_unlock_quest_create_script" );
}

// Namespace zm_sat_firefly_europa_unlock_quest_create_script
// Params 3, eflags: 0x4
// Checksum 0x8b380da5, Offset: 0x389
// Size: 0x62f
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_europa_unlock_quest_create_script";
    fe [[ f ]]( s, us, cf, ( 23652.9, -1444.09, 318.77 ), ( 0, 91.1, 0 ), undefined, undefined, "viper_respawn_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_europa_unlock_quest_create_script";
    s.is_cs_model = 1;
    s.model = "sat_zm_radio_call_boxes_fxanim";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 4438, -3083, 442.5 ), ( 5.03, 359.12, -9.88 ), undefined, undefined, "europa_summon" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_europa_unlock_quest_create_script";
    fe [[ f ]]( s, us, cf, ( 24248.5, 2200, 486 ), ( 0, 269.71, 0 ), undefined, undefined, "viper_box" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_europa_unlock_quest_create_script";
    fe [[ f ]]( s, us, cf, ( 4720, -3322, 418.26 ), ( 356.52, 166.62, 10.54 ), undefined, undefined, "europa_spawner" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_europa_unlock_quest_create_script";
    fe [[ f ]]( s, us, cf, ( 23194.5, -405.07, 512.04 ), ( 353.13, 0.08, -3.01 ), undefined, undefined, "europa_quest_stun" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_europa_unlock_quest_create_script";
    fe [[ f ]]( s, us, cf, ( 3082.5, -397.5, 374.5 ), ( 0, 0, 10.51 ), undefined, undefined, "europa_quest_stun" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_europa_unlock_quest_create_script";
    s.is_cs_model = 1;
    s.model = "sat_zm_torture_chair_conect_console_fxanim";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 4637.77, -3261.7, 471.29 ), ( 349.64, 269.46, -5.04 ), undefined, undefined, "europa_unlock_device" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_europa_unlock_quest_create_script";
    fe [[ f ]]( s, us, cf, ( 23800.5, 1978, 315.7 ), ( 0, 0, 0 ), undefined, undefined, "stabilizer_fallback_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_europa_unlock_quest_create_script";
    s.is_cs_model = 1;
    s.model = "t10_zm_emf_access_fob_dyn";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 4631.23, -3256.59, 471.07 ), ( 4.69, 354.76, 78.97 ), undefined, undefined, "europa_unlock_chip" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_europa_unlock_quest_create_script";
    s.is_cs_model = 1;
    s.model = "sat_zm_torture_chair_conect_wires";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 4637.77, -3261.7, 471.29 ), ( 349.64, 269.46, -5.04 ), undefined, undefined, "europa_unlock_wire" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_europa_unlock_quest_create_script";
    s.is_cs_model = 1;
    s.model = "sat_zm_radio_call_boxes_fxanim";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 23195.1, -433.68, 522.82 ), ( 11.67, 184.37, 0.9 ), undefined, undefined, "europa_summon" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_europa_unlock_quest_create_script";
    s.is_cs_model = 1;
    s.model = "sat_zm_radio_call_boxes_fxanim";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 13642, 2910, 1057.5 ), ( 0.27, 307.5, -0 ), undefined, undefined, "europa_summon" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_europa_unlock_quest_create_script";
    s.is_cs_model = 1;
    s.model = "sat_zm_radio_call_boxes_fxanim";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -13347.4, 3782.43, 467.13 ), ( 0, 133.8, 0 ), undefined, undefined, "europa_summon" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_europa_unlock_quest_create_script";
    s.is_cs_model = 1;
    s.model = "sat_zm_radio_call_boxes_fxanim";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 13515.3, -3248.93, 875.21 ), ( 0, 315.5, 0 ), undefined, undefined, "europa_summon" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_europa_unlock_quest_create_script";
    s.is_cs_model = 1;
    s.model = "sat_zm_radio_call_boxes_fxanim";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( -6915.49, -6697.98, 1617.72 ), ( 0, 111, 0 ), undefined, undefined, "europa_summon" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_europa_unlock_quest_create_script";
    fe [[ f ]]( s, us, cf, ( 4720, -3321.5, 417.76 ), ( 0, 170.12, 0 ), "europa_align_ref", undefined, "europa_align_ref" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_europa_unlock_quest_create_script";
    fe [[ f ]]( s, us, cf, ( 24265, 2134, 534 ), ( 325.23, 196.78, 94.71 ), undefined, undefined, "viper_box_deactivated" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_europa_unlock_quest_create_script
// Params 0, eflags: 0x4
// Checksum 0x2fbf09cc, Offset: 0x9c0
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_europa_unlock_quest_create_script
// Params 0
// Checksum 0x1d897e52, Offset: 0x9ca
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_europa_unlock_quest_create_script" );
}

