// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_quest_pap_cs.gsc  (hash_2230a304e5a29a43.gscc) (size: 7408 Bytes / 0x1cf0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc7f715df (3354858975)
// size ...... 7408 (0x1cf0)
// includes .. 2   (offset: 0x17f4)
// strings ... 63  (offset: 0x1804)
// dev strs .. 0   (offset: 0x1cf0)
// exports ... 6   (offset: 0x1544)
// cseg ...... 0x4eb + 0x1059 (0x1544)
// imports ... 16  (offset: 0x1634)
// animtree1 . 0   (offset: 0x1cf0)
// animtree2 . 0   (offset: 0x1cf0)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_ruby_quest_pap_cs;

// Namespace zm_sat_ruby_quest_pap_cs
// Params 2
// Checksum 0x32b0be89, Offset: 0x509
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_ruby_quest_pap_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_ruby_quest_pap_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_ruby_quest_pap_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_ruby_quest_pap_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_ruby_quest_pap_cs
// Params 3, eflags: 0x4
// Checksum 0x1db5c0f, Offset: 0x591
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_ruby_quest_pap_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_ruby_quest_pap_cs" );
}

// Namespace zm_sat_ruby_quest_pap_cs
// Params 3, eflags: 0x4
// Checksum 0x1559b117, Offset: 0x60b
// Size: 0xf19
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.groupid = "Power";
    fe [[ f ]]( s, us, cf, ( 4245, -1272, 112 ), ( 0, 265.11, 0 ), undefined, undefined, "papq_power_station_interact" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.groupid = "Power";
    fe [[ f ]]( s, us, cf, ( 4273, -1210, 109 ), ( 0, 354.4, 0 ), undefined, undefined, "papq_power_device_interact" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.groupid = "attractor";
    fe [[ f ]]( s, us, cf, ( 4240, -1288, 64 ), ( 0, 353.1, 0 ), "papq_attractor", undefined, "slot2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.groupid = "Power";
    fe [[ f ]]( s, us, cf, ( 4247.25, -1272.25, 78.25 ), ( 0, 265.11, 0 ), "smoke_vfx" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.groupid = "Pieces";
    s.name = "pipe_1";
    fe [[ f ]]( s, us, cf, ( 764.41, 1615.48, 222 ), ( 0, 356, 90 ), "pipe1a", undefined, "0" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.groupid = "Holdout";
    s.script_animation = "spawn";
    s.variantname = "spawner";
    fe [[ f ]]( s, us, cf, ( 4235.32, -1630.93, 16 ), ( 0, 35.87, 0 ), undefined, undefined, "papq_holdout_spawner" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.groupid = "Holdout";
    s.script_animation = "spawn";
    s.variantname = "spawner";
    fe [[ f ]]( s, us, cf, ( 4286.62, -1678.15, 16 ), ( 0, 128.4, 0 ), undefined, undefined, "papq_holdout_spawner" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.groupid = "Holdout";
    s.script_animation = "spawn";
    s.variantname = "spawner";
    fe [[ f ]]( s, us, cf, ( 4352.3, -1622.94, 16 ), ( 0, 9.36, 0 ), undefined, undefined, "papq_holdout_spawner" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.groupid = "Holdout";
    s.script_animation = "spawn";
    s.variantname = "spawner";
    fe [[ f ]]( s, us, cf, ( 4293.68, -767.14, 16 ), ( 0, 323.14, 0 ), undefined, undefined, "papq_holdout_spawner" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.groupid = "Holdout";
    s.script_animation = "spawn";
    s.variantname = "spawner";
    fe [[ f ]]( s, us, cf, ( 4364.47, -809.96, 16 ), ( 0, 256.72, 0 ), undefined, undefined, "papq_holdout_spawner" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.groupid = "attractor";
    fe [[ f ]]( s, us, cf, ( 4250, -1289, 64 ), ( 0, 353.1, 0 ), "papq_attractor", undefined, "slot1" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.groupid = "Holdout";
    s.script_animation = "spawn";
    s.variantname = "spawner";
    fe [[ f ]]( s, us, cf, ( 4455.06, -783.59, 16 ), ( 0, 232.09, 0 ), undefined, undefined, "papq_holdout_spawner" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.groupid = "Pieces";
    s.name = "pipe_1";
    fe [[ f ]]( s, us, cf, ( 740.91, 837.73, 237.75 ), ( 0, 91, 90 ), "pipe1b", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.groupid = "Circle";
    s.variantname = "circle";
    fe [[ f ]]( s, us, cf, ( 772, 1518, 378 ), ( 0, 0, 0 ), "papq_piece_1_circle", "cspf_0_auto17666355458055542062", "papq_piece_1_circle", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.groupid = "Circle";
    s.variantname = "circle";
    fe [[ f ]]( s, us, cf, ( 1074, -2696, 276 ), ( 0, 0, 0 ), "papq_piece_2_circle", "cspf_0_auto8297756984504205350", "papq_piece_2_circle", undefined, undefined, undefined, undefined, 800 );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.groupid = "Pieces";
    s.name = "pipe_2";
    fe [[ f ]]( s, us, cf, ( 975.7, -2083.6, 202 ), ( 0, 64.71, 90 ), "pipe2c", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.groupid = "Pieces";
    s.name = "pipe_2";
    fe [[ f ]]( s, us, cf, ( 1300.95, -2252.1, 345.75 ), ( 0, 41.27, 90 ), "pipe2a", undefined, "0" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.groupid = "Pieces";
    s.name = "pipe_2";
    fe [[ f ]]( s, us, cf, ( 1144.2, -3157.35, 202 ), ( 0, 102.66, 90 ), "pipe2b", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    fe [[ f ]]( s, us, cf, ( 4445.5, -1230, 71.5 ), ( 0, 0, 0 ), "papq_beam_end" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    fe [[ f ]]( s, us, cf, ( 4336, -1240, 238 ), ( 0, 0, 0 ), undefined, undefined, "reach_observatory_loc", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.groupid = "attractor";
    fe [[ f ]]( s, us, cf, ( 4287, -1218, 64 ), ( 0, 353.1, 0 ), "papq_attractor", undefined, "slot3" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.groupid = "Pieces";
    s.name = "corpse_1";
    s.variantname = "corpse";
    fe [[ f ]]( s, us, cf, ( 744.16, 1631.98, 219.5 ), ( 0, 105, 1.25 ), "pap_corpse_1", undefined, "pipe1a" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.groupid = "Pieces";
    s.name = "corpse_1";
    s.variantname = "corpse";
    fe [[ f ]]( s, us, cf, ( 730.91, 816.73, 236 ), ( 0, 195, 0 ), "pap_corpse_1", undefined, "pipe1b" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.groupid = "Pieces";
    s.name = "corpse_2";
    s.variantname = "corpse";
    fe [[ f ]]( s, us, cf, ( 1290.91, -2279.27, 343.75 ), ( 0, 180, -2.91 ), "pap_corpse_2", undefined, "pipe2a" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.groupid = "Pieces";
    s.name = "corpse_1";
    s.variantname = "corpse";
    fe [[ f ]]( s, us, cf, ( 1282.91, 848.73, 236.25 ), ( 0, 105, 0 ), "pap_corpse_1", undefined, "pipe1c" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.groupid = "Pieces";
    s.name = "corpse_2";
    s.variantname = "corpse";
    fe [[ f ]]( s, us, cf, ( 1179.91, -3152.77, 199.25 ), ( 0, 45, -1.73 ), "pap_corpse_2", undefined, "pipe2b" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.groupid = "Pieces";
    s.name = "corpse_2";
    s.variantname = "corpse";
    fe [[ f ]]( s, us, cf, ( 981.66, -2111.02, 200.25 ), ( 0, 195, 0 ), "pap_corpse_2", undefined, "pipe2c" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.name = "script_struct_breadcrumb_a";
    s.script_parameters = "doorbuy_landing_to_planetarium_bought";
    fe [[ f ]]( s, us, cf, ( -806, 1038, 312 ), ( 0, 4.1, 0 ), "pap_path_a", "cspf_0_auto11588038611105849674", "breadcrumb0" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.name = "script_struct_breadcrumb_b";
    s.script_parameters = "doorbuy_landing_to_mainhall_bought";
    fe [[ f ]]( s, us, cf, ( -936, -294, 307 ), ( 0, 4.7, 0 ), "pap_path_b", "cspf_0_auto11775667077248881483", "breadcrumb0" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.name = "script_struct_breadcrumb_a";
    s.script_label = "papq_near_telescope";
    s.script_parameters = "zone_telescope_enabled_left";
    fe [[ f ]]( s, us, cf, ( 4650, -616, 64 ), ( 0, 85.9, 0 ), "pap_path_a", undefined, "breadcrumb2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.name = "script_struct_breadcrumb_b";
    s.script_parameters = "doorbuy_mainhall_to_orrery_bought";
    fe [[ f ]]( s, us, cf, ( -97, -962, 300 ), ( 0, 95.9, 0 ), "pap_path_b", "cspf_0_auto10846117398909545009", "breadcrumb1" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.name = "script_struct_breadcrumb_b";
    s.script_parameters = "zone_telescope_enabled_right";
    fe [[ f ]]( s, us, cf, ( 1523, -2720, 98 ), ( 0, 178.36, 0 ), "pap_path_b", undefined, "breadcrumb2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.name = "script_struct_breadcrumb_a";
    s.script_parameters = "doorbuy_planetarium_to_cliff_bought";
    fe [[ f ]]( s, us, cf, ( 1698, 1365, 320 ), ( 0, 4.7, 0 ), "pap_path_a", "cspf_0_auto18153398998592737935", "breadcrumb1" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.groupid = "attractor";
    fe [[ f ]]( s, us, cf, ( 4291, -1183, 64 ), ( 0, 353.1, 0 ), "papq_attractor", undefined, "slot4" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.groupid = "attractor";
    fe [[ f ]]( s, us, cf, ( 4251, -1147, 64 ), ( 0, 353.1, 0 ), "papq_attractor", undefined, "slot5" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    fe [[ f ]]( s, us, cf, ( 4479, -1234.5, 71.5 ), ( 0, 354.43, 0 ), "pap_knockback_pos", undefined, undefined, undefined, undefined, undefined, undefined, 90 );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    fe [[ f ]]( s, us, cf, ( -527, 371, -15.36 ), ( 0, 0, 0 ), "meteor_strike", undefined, undefined, undefined, undefined, undefined, undefined, 2000 );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_quest_pap_cs";
    s.groupid = "Pieces";
    s.name = "pipe_1";
    fe [[ f ]]( s, us, cf, ( 1306.41, 852.98, 237.75 ), ( 0, 0, 90 ), "pipe1c", undefined, "2" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_ruby_quest_pap_cs
// Params 0, eflags: 0x4
// Checksum 0xde73ae37, Offset: 0x152c
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_ruby_quest_pap_cs
// Params 0
// Checksum 0xc3888142, Offset: 0x1536
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_ruby_quest_pap_cs" );
}

