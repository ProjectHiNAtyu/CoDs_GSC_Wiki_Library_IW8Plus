// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_training_course_cs.gsc  (hash_03d87531c539b261.gscc) (size: 9831 Bytes / 0x2667 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xff2376b7 (4280514231)
// size ...... 9831 (0x2667)
// includes .. 3   (offset: 0x1fff)
// strings ... 50  (offset: 0x2017)
// dev strs .. 0   (offset: 0x2667)
// exports ... 9   (offset: 0x1c67)
// cseg ...... 0x3b0 + 0x18b7 (0x1c67)
// imports ... 20  (offset: 0x1dcf)
// animtree1 . 0   (offset: 0x2667)
// animtree2 . 0   (offset: 0x2667)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_firefly_script_training_course_cs;

// Namespace zm_sat_firefly_script_training_course_cs
// Params 0, eflags: 0x5
// Checksum 0xebcf5c03, Offset: 0x3ce
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_script_training_course_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_firefly_script_training_course_cs
// Params 0, eflags: 0x4
// Checksum 0xd5515d74, Offset: 0x3ef
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_firefly_script_training_course_cs
// Params 0, eflags: 0x4
// Checksum 0x506a8e98, Offset: 0x400
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_firefly_script_training_course_cs
// Params 2
// Checksum 0xe083d8d1, Offset: 0x411
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_script_training_course_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_firefly_script_training_course_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_script_training_course_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_script_training_course_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_script_training_course_cs
// Params 3, eflags: 0x4
// Checksum 0xd3e83a57, Offset: 0x499
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_script_training_course_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_script_training_course_cs" );
}

// Namespace zm_sat_firefly_script_training_course_cs
// Params 3, eflags: 0x4
// Checksum 0x572d4386, Offset: 0x513
// Size: 0x1734
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "1_kill_zombies";
    s.name = "nuke_spawn";
    fe [[ f ]]( s, us, cf, ( 14460.3, -4316.2, 577.59 ), ( 0, 311.42, 0 ), "station_1", undefined, "nuke_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "1_kill_zombies";
    s.name = "objective";
    fe [[ f ]]( s, us, cf, ( 14688.8, -3353.17, 616.58 ), ( 5.92, 255.12, -0.92 ), "station_1", undefined, "objective_ammo" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "1_kill_zombies";
    s.name = "objective";
    fe [[ f ]]( s, us, cf, ( 13485.3, -5037.51, 584 ), ( 0, 105, 0 ), "station_1", undefined, "objective_craft" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "2_map_prog";
    s.name = "2_flag";
    fe [[ f ]]( s, us, cf, ( 14035, -3619.65, 633.75 ), ( 357.41, 195.07, -3.55 ), "station_2", "station_2", "flag" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "2_map_prog";
    s.name = "spawn";
    fe [[ f ]]( s, us, cf, ( 13883.2, -3764.87, 630.51 ), ( 0, 132.42, 0 ), "station_2", undefined, "spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "2_map_prog";
    s.name = "objective";
    fe [[ f ]]( s, us, cf, ( 13679.8, -3555.81, 653 ), ( 0, 314, 0 ), "station_2", undefined, "objective_doorbuy" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "3_power_up_player";
    s.name = "3_flag";
    fe [[ f ]]( s, us, cf, ( 13251.1, -4843.93, 576.6 ), ( 0, 285, 0 ), "station_3", "station_3", "flag" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "3_power_up_player";
    s.name = "respawn_start";
    fe [[ f ]]( s, us, cf, ( 14580.5, -4453.72, 565.25 ), ( 359.41, 127.32, 2.15 ), "station_3", undefined, "respawn_start" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "3_power_up_player";
    s.name = "spawn";
    fe [[ f ]]( s, us, cf, ( 13580, -4452.73, 587.88 ), ( 0, 191.8, 0 ), "station_3", undefined, "spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "3_power_up_player";
    s.name = "zombie_spawn";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 13196.1, -4918.48, 582.12 ), ( 0, 45.92, 0 ), "station_3", undefined, "zombie_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "3_power_up_player";
    s.name = "zombie_spawn";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 13238.6, -4958.34, 585.25 ), ( 0, 45.92, 0 ), "station_3", undefined, "zombie_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "3_power_up_player";
    s.name = "zombie_spawn";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 13153.6, -4878.71, 585.25 ), ( 0, 45.92, 0 ), "station_3", undefined, "zombie_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "3_power_up_player";
    s.name = "respawn_wunderfizz";
    fe [[ f ]]( s, us, cf, ( 13664.8, -4529.46, 579.75 ), ( 0, 314.53, 0 ), "station_3", undefined, "respawn_wunderfizz" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "3_power_up_player";
    s.name = "respawn_armor";
    fe [[ f ]]( s, us, cf, ( 14582.5, -3131.72, 618 ), ( 0, 167.67, 0 ), "station_3", undefined, "respawn_armor" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "3_power_up_player";
    s.name = "zombie_spawn_armor";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 14490.5, -3055.47, 618 ), ( 0, 305.2, 0 ), "station_3", undefined, "zombie_spawn_armor" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "3_power_up_player";
    s.name = "zombie_spawn_armor";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 14515.5, -3025.38, 618 ), ( 0, 305.2, 0 ), "station_3", undefined, "zombie_spawn_armor" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "4_power_up_weapon";
    s.name = "4_flag";
    fe [[ f ]]( s, us, cf, ( 13741.1, -3983.22, 606.15 ), ( 0, 285, 0 ), "station_4", "station_4", "flag" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "4_power_up_weapon";
    s.name = "respawn_stn_4";
    fe [[ f ]]( s, us, cf, ( 13888.7, -4207.8, 571.06 ), ( 2.23, 51.05, -0.03 ), "station_4", undefined, "respawn_stn_4" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "4_power_up_weapon";
    s.name = "spawn";
    fe [[ f ]]( s, us, cf, ( 13224.4, -4864.58, 774.39 ), ( 0, 226.48, 0 ), "station_4", undefined, "spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "1_kill_zombies";
    s.name = "1_flag";
    fe [[ f ]]( s, us, cf, ( 14661.5, -4547.72, 548.54 ), ( 0.9, 15.07, -0.88 ), "station_1", "station_1", "flag" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "4_power_up_weapon";
    s.name = "zombie_spawn_pap";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 13591.3, -4515.48, 578.34 ), ( 0, 224.91, 0 ), "station_4", undefined, "zombie_spawn_pap" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "4_power_up_weapon";
    s.name = "respawn_arsenal";
    fe [[ f ]]( s, us, cf, ( 13460.8, -3360.22, 508.37 ), ( 4.06, 221.26, -1.7 ), "station_4", undefined, "respawn_arsenal" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "5_new_weapons";
    s.name = "5_flag";
    fe [[ f ]]( s, us, cf, ( 14740.1, -3945.6, 579.92 ), ( 0, 116.42, 0 ), "station_5", "station_5", "flag" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "4_power_up_weapon";
    s.name = "zombie_spawn_arsenal";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 13776.9, -3749.65, 412 ), ( 0.41, 139.29, 0.52 ), "station_4", undefined, "zombie_spawn_arsenal" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "4_power_up_weapon";
    s.name = "zombie_spawn_arsenal_extra";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 13800.3, -3726.37, 412 ), ( 0.41, 139.29, 0.52 ), "station_4", undefined, "zombie_spawn_arsenal_extra" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "4_power_up_weapon";
    s.name = "zombie_spawn_arsenal_extra";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 13716, -3839.39, 411.64 ), ( 0.41, 139.29, 0.52 ), "station_4", undefined, "zombie_spawn_arsenal_extra" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "1_kill_zombies";
    s.name = "spawn";
    fe [[ f ]]( s, us, cf, ( 14514.9, -4382.16, 571.52 ), ( 0, 131.83, 0 ), "station_1", undefined, "spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "1_kill_zombies";
    s.name = "zombie_spawn";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 14329.8, -4297.49, 567.89 ), ( 0, 314.75, 0 ), "station_1", undefined, "zombie_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "1_kill_zombies";
    s.name = "zombie_spawn";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 14382.4, -4244.4, 567.89 ), ( 0, 314.75, 0 ), "station_1", undefined, "zombie_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "1_kill_zombies";
    s.name = "zombie_spawn";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 14438.4, -4189.33, 567.89 ), ( 0, 314.75, 0 ), "station_1", undefined, "zombie_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "1_kill_zombies";
    s.name = "zombie_spawn";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 14387.3, -4301.46, 567.89 ), ( 0, 314.75, 0 ), "station_1", undefined, "zombie_spawn_extra" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "1_kill_zombies";
    s.name = "zombie_spawn";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 14439.9, -4248.37, 567.89 ), ( 0, 314.75, 0 ), "station_1", undefined, "zombie_spawn_extra" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "4_power_up_weapon";
    s.name = "zombie_spawn_arsenal_extra";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 13773, -3860.98, 410.64 ), ( 0.41, 139.29, 0.52 ), "station_4", undefined, "zombie_spawn_arsenal_extra" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "4_power_up_weapon";
    s.name = "zombie_spawn_arsenal_extra";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 13753.5, -3789.1, 412 ), ( 0.41, 139.29, 0.52 ), "station_4", undefined, "zombie_spawn_arsenal_extra" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "4_power_up_weapon";
    s.name = "zombie_spawn_arsenal_extra";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 13800.1, -3795.66, 412 ), ( 0.41, 139.29, 0.52 ), "station_4", undefined, "zombie_spawn_arsenal_extra" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "4_power_up_weapon";
    s.name = "zombie_spawn_arsenal_extra";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 13900.6, -3731.76, 412 ), ( 0.41, 139.29, 0.52 ), "station_4", undefined, "zombie_spawn_arsenal_extra" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "4_power_up_weapon";
    s.name = "zombie_spawn_arsenal_extra";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 13857.9, -3762.2, 412 ), ( 0.41, 139.29, 0.52 ), "station_4", undefined, "zombie_spawn_arsenal_extra" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "5_new_weapons";
    s.name = "spawn";
    fe [[ f ]]( s, us, cf, ( 13584.6, -4558.61, 580.43 ), ( 0, 222.27, 0 ), "station_5", undefined, "spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "5_new_weapons";
    s.name = "zombie_spawn";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 14646.3, -3272.72, 618.56 ), ( 0.02, 73.36, -0.08 ), "station_5", undefined, "zombie_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "5_new_weapons";
    s.name = "zombie_spawn";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 14522.7, -3235.82, 618.57 ), ( 0.02, 73.36, -0.08 ), "station_5", undefined, "zombie_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "5_new_weapons";
    s.name = "zombie_spawn";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 14584.5, -3254.27, 618.56 ), ( 0.02, 73.36, -0.08 ), "station_5", undefined, "zombie_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "5_new_weapons";
    s.name = "spawn";
    fe [[ f ]]( s, us, cf, ( 14609.5, -3121.24, 618.01 ), ( 0.04, 77.59, 0.08 ), "station_5", undefined, "respawn_magicbox" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "6_bgb";
    s.name = "6_flag";
    fe [[ f ]]( s, us, cf, ( 14278.4, -3770.27, 587.55 ), ( 0, 15, 0 ), "station_6", "station_6", "flag" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "6_bgb";
    s.name = "spawn";
    fe [[ f ]]( s, us, cf, ( 13783.3, -3665.54, 674.59 ), ( 0, 104, 0 ), "station_6", undefined, "spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "6_bgb";
    s.name = "bot_spawn";
    fe [[ f ]]( s, us, cf, ( 14451.5, -3693.48, 591.52 ), ( 0, 195.23, 0 ), "station_6", undefined, "bot_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "6_bgb";
    s.name = "objective";
    fe [[ f ]]( s, us, cf, ( 13772.2, -3486.4, 673.74 ), ( 0, 315.4, 0 ), "station_6", undefined, "objective_bgb" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "6_bgb";
    s.name = "bot_spawn";
    fe [[ f ]]( s, us, cf, ( 14177.3, -3870.12, 590.73 ), ( 0, 161.31, 0 ), "station_6", undefined, "bot_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "7_exfil";
    s.name = "7_flag";
    fe [[ f ]]( s, us, cf, ( 13917.1, -3022.57, 640.03 ), ( 0, 15, 0 ), "station_7", "station_7", "flag" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "7_exfil";
    s.name = "spawn";
    fe [[ f ]]( s, us, cf, ( 14106.4, -3105.79, 637.74 ), ( 0, 75.23, 0 ), "station_7", undefined, "spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    fe [[ f ]]( s, us, cf, ( 14966.4, -4884.71, 512.34 ), ( 0, 129.4, 0 ), "training_course_player_initial_points" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    fe [[ f ]]( s, us, cf, ( 15013.3, -4845.32, 511.98 ), ( 0, 129.4, 0 ), "training_course_player_initial_points" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    fe [[ f ]]( s, us, cf, ( 14919.4, -4924.25, 513.96 ), ( 0, 129.4, 0 ), "training_course_player_initial_points" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    fe [[ f ]]( s, us, cf, ( 14870.1, -4965.61, 518.53 ), ( 0, 129.4, 0 ), "training_course_player_initial_points" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "1_kill_zombies";
    s.name = "objective";
    fe [[ f ]]( s, us, cf, ( 14417.5, -4271.15, 567 ), ( 5.92, 255.12, -0.92 ), "station_1", undefined, "objective_drops" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    s.groupid = "3_power_up_player";
    s.name = "respawn_stn_3";
    fe [[ f ]]( s, us, cf, ( 14366.4, -3994.82, 572.82 ), ( 0, 159.9, 0 ), "station_3", undefined, "respawn_stn_3" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_training_course_cs";
    fe [[ f ]]( s, us, cf, ( 13464, -3572, 828 ), ( 0, 44.7, 0 ), "override_perk_model", undefined, "t10_furniture_armoire_wood_02" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_script_training_course_cs
// Params 0, eflags: 0x4
// Checksum 0xdd225a96, Offset: 0x1c4f
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_script_training_course_cs
// Params 0
// Checksum 0x11bbe71a, Offset: 0x1c59
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_script_training_course_cs" );
}

