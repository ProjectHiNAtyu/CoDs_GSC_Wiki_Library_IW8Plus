// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_quest_mq_cs.gsc  (hash_5159f51168e1e19a.gscc) (size: 29959 Bytes / 0x7507 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7b4181eb (2067890667)
// size ...... 29959 (0x7507)
// includes .. 3   (offset: 0x621f)
// strings ... 239 (offset: 0x6237)
// dev strs .. 0   (offset: 0x7507)
// exports ... 9   (offset: 0x5e33)
// cseg ...... 0x1a89 + 0x43aa (0x5e33)
// imports ... 21  (offset: 0x5f9b)
// animtree1 . 0   (offset: 0x7507)
// animtree2 . 0   (offset: 0x7507)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_mantis_quest_mq_cs;

// Namespace zm_sat_mantis_quest_mq_cs
// Params 0, eflags: 0x5
// Checksum 0xfc0542b0, Offset: 0x1aa7
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_mantis_quest_mq_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_mantis_quest_mq_cs
// Params 0, eflags: 0x4
// Checksum 0xd2586a93, Offset: 0x1ac8
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_mantis_quest_mq_cs
// Params 0, eflags: 0x4
// Checksum 0x5763b97f, Offset: 0x1ad9
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_mantis_quest_mq_cs
// Params 2
// Checksum 0xe78aef36, Offset: 0x1aea
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_mantis_quest_mq_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_mantis_quest_mq_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_mantis_quest_mq_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_mantis_quest_mq_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_mantis_quest_mq_cs
// Params 3, eflags: 0x4
// Checksum 0xd4e10db0, Offset: 0x1b72
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_mantis_quest_mq_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_mantis_quest_mq_cs" );
}

// Namespace zm_sat_mantis_quest_mq_cs
// Params 3, eflags: 0x4
// Checksum 0x648eabc9, Offset: 0x1bec
// Size: 0x4227
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 56251.8, -31422.5, -111 ), ( 0, 192.18, 0 ), "fireplace_ambient_furture" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55560, -30856, -135 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55049.5, -33153, -102 ), ( 300.68, 223.9, 0 ), "s_item_chalk", "cspf_0_auto14197701306635093978", "sat_zm_chalk_stick" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55146.6, -31470.8, -134.75 ), ( 0, 49.93, 0 ), "cspf_0_auto3339502886905868984", undefined, "player_position" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 54869, -32931, -121 ), ( 0, 134.6, 0 ), "garage_door", undefined, "sat_zm_sat_scriptable_mantis_garage_door" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 58281.9, -31320.5, 257 ), ( 0, 331.41, 0 ), "lost_soul_fire_start_pos", "cspf_0_auto2774729354935014165", undefined, undefined, undefined, undefined, undefined, 500 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55201.6, -31517.3, -133.15 ), ( 0, 49.93, 0 ), "cspf_0_auto3339502886905868984", undefined, "player_position" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55248.8, -31560, -131.52 ), ( 0, 49.93, 0 ), "cspf_0_auto3339502886905868984", undefined, "player_position" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 79758.9, -31553.5, -104 ), ( 0, 201, 0 ), "past_swing_seat", undefined, "cp_town_playground_swingset_part01" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55296.4, -31594.3, -137.9 ), ( 0, 49.93, 0 ), "cspf_0_auto3339502886905868984", undefined, "player_position" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_scenescriptbundle = "sat_zm_mantis_zombie_floating_scene";
    fe [[ f ]]( s, us, cf, ( 58130.2, -31625.3, -114.74 ), ( 0, 167.35, 0 ), "cspf_0_auto2774729354935014165" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_scenescriptbundle = "sat_cin_zm_vig_mantis_swing_seat_drop";
    fe [[ f ]]( s, us, cf, ( 79772, -31588, -123.5 ), ( 0, 200.92, 0 ), "twins_swing_seat_past" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77747.8, -30511.4, -87.5 ), ( 83.77, 310.24, -72.18 ), "sheet_music_final_pos", undefined, "sat_zm_music_sheet_fxnaim" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55201, -31555.5, -17 ), ( 0, 0, 0 ), "final_teleport_pos", "cspf_0_auto3339502886905868984" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55021.9, -33122.3, -120 ), ( 0, 45.18, 0 ), "s_gh_cd_in_ge", undefined, "sat_zm_sat_scriptable_mantis_burned_husk" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 79704.2, -31573.9, -120 ), ( 0, 201, 0 ), "past_seat_item_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 57236.7, -31557.6, -85 ), ( 294.05, 290.65, 0 ), "future_ghost_child", undefined, "sat_zm_chalk_stick" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 76871.6, -33002.5, -126 ), ( 0, 0, 0 ), "past_magic_tree_pos", undefined, "sat_zm_sat_scriptable_mantis_mq_magic_tree" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 56348.2, -31463.4, -84.59 ), ( 0, 62, 0 ), "future_toolbox", undefined, "sat_zm_sat_scriptable_mantis_seed_box" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_animation = "spawn_portal";
    s.var_b6279e33503ba8f = int( 1 );
    fe [[ f ]]( s, us, cf, ( 76251, -31675, -124 ), ( 0, 0, 0 ), "cspf_0_auto5243474811163202199", undefined, "zombie_base" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 76872.6, -33003, -126 ), ( 0, 0, 0 ), "past_plant_tree_pos", undefined, "sat_zm_mud_pit_crater_01_small" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 54353.9, -32987.3, -128.88 ), ( 0, 331.08, 0 ), "future_magic_tree_pos", undefined, "sat_foliage_tree_bonsai_large_zm" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 54343.5, -33025.8, -128.38 ), ( 0, 351.76, 0 ), "future_plant_tree_pos", undefined, "sat_zm_mud_pit_crater_01" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_int = int( 2 );
    s.script_scenescriptbundle = "sat_cin_zm_vig_mantis_sisters_ending_vignette";
    fe [[ f ]]( s, us, cf, ( 78766.3, -31442.3, -121 ), ( 0, 239.42, 0 ), "final_sister_scene", undefined, "hold_idle_exit_f" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_int = int( 1 );
    s.script_scenescriptbundle = "sat_cin_zm_vig_mantis_sisters_ending_vignette";
    fe [[ f ]]( s, us, cf, ( 77225.5, -31717.5, -124 ), ( 0, 52.07, 0 ), "final_sister_scene", undefined, "hold_idle_exit_f" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 78782.2, -31418.1, -103.82 ), ( 0, 226.76, -9.46 ), "firewood_in_fireplace", undefined, "decor_firewood_01" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 78787.2, -31421.6, -112.82 ), ( 0, 192.18, 0 ), "fireplace_ambient", undefined, "sat_zm_wood_plank_dmg_burnt_trunk_03" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 78777.7, -31432.6, -97.32 ), ( 0, 0, 0 ), "fireplace_interaction", undefined, "t10_zm_gameplay_collision_05" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 76542.5, -31844, -123 ), ( 0, 327.62, 0 ), "music_box_start_pos", "cspf_0_auto13214628225437222030", "sat_zm_antique_music_box_fxanim" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 76526, -31836, -23 ), ( 0, 0, 0 ), "hopscotch_anomaly_pos", undefined, "sat_zm_sat_scriptable_mantis_mq_minigame_anomaly" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 76898, -32037, -79.5 ), ( 0, 0, 0 ), "cspf_0_auto6632521355994516616", "cspf_0_auto3759634476882114772" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 76542.5, -31842, -69.5 ), ( 0, 0, 0 ), "cspf_0_auto13214628225437222030", "cspf_0_auto6632521355994516616" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77653, -31526, -76 ), ( 0, 0, 0 ), "cspf_0_auto3759634476882114772", "cspf_0_auto2573279591912178023" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 78155, -31505, -85.5 ), ( 0, 0, 0 ), "cspf_0_auto2573279591912178023", "cspf_0_auto12664699440329784311" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 78528.5, -31546, -89 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 78796, -31560, -89 ), ( 0, 0, 0 ), "cspf_0_auto10032965503437339089", "cspf_0_auto8661272060606895540" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 78762.5, -31451, -95.5 ), ( 0, 0, 0 ), "cspf_0_auto8661272060606895540", undefined, "end" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 57133.8, -32502.2, -96.24 ), ( 323.05, 3.51, 20.48 ), "maxis_headset", "cspf_0_auto1525363431150185221", "sat_zm_headgear_headphones" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77205.3, -31733.7, -105.12 ), ( 0, 58.02, 0 ), "maxis_goggles_in_box", undefined, "c_sat_zmb_gear_maxis_headgear_goggles" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 53911.5, -33425.1, 207.12 ), ( 1.82, 136.16, -0.44 ), "maxis_goggles", "cspf_0_auto9078073790900342018", "c_sat_zmb_gear_maxis_headgear_goggles" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77192.3, -31725.2, -111.62 ), ( 0, 0, 0 ), "maxis_headphone_in_box", undefined, "c_sat_zmb_gear_maxis_headgear_headphones" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77201.8, -31726.7, -124.12 ), ( 0, 52.78, 0 ), "toy_box", undefined, "sat_zm_toy_chest_fxanim" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77413.4, -30217.8, -43 ), ( 0, 0, 0 ), "foursquare_anomaly_pos", undefined, "sat_zm_sat_scriptable_mantis_mq_minigame_anomaly" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77957, -29886, -76.5 ), ( 0, 0, 0 ), "cspf_0_auto6387402972916883603", "cspf_0_auto4685919704652156756" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77380.5, -30166, -120 ), ( 0, 0, 0 ), "monkey_cymbals_start_pos", "cspf_0_auto11174855596886084488", "sat_zm_monkey_cymbals_fxanim" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77381.5, -30166.5, -71 ), ( 0, 0, 0 ), "cspf_0_auto11174855596886084488", "cspf_0_auto6387402972916883603" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 78406.2, -30611.4, -76 ), ( 0, 0, 0 ), "cspf_0_auto4685919704652156756", "cspf_0_auto6821372922977222770" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 78480, -31289.2, -73 ), ( 0, 0, 0 ), "cspf_0_auto14516226695605729897", "cspf_0_auto5862570185058099288" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77263.1, -31959.5, -37.73 ), ( 0, 0, 0 ), "jacks_anomaly_pos", undefined, "sat_zm_sat_scriptable_mantis_mq_minigame_anomaly" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77438.5, -31840, -82 ), ( 0, 0, 0 ), "cspf_0_auto13840780702203101288", "cspf_0_auto7736072483662458532" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77437.5, -31838.5, -133 ), ( 0, 0, 0 ), "sheet_music_start_pos", "cspf_0_auto13840780702203101288", "sat_zm_music_sheet_fxnaim" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77552.5, -31498, -68 ), ( 0, 0, 0 ), "cspf_0_auto7736072483662458532", "cspf_0_auto8093654259065243139" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55213.5, -30515.2, -121 ), ( 0, 24.6, 0 ), "future_piano_pos", undefined, "sat_zm_sat_scriptable_mantis_piano" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 78691.6, -30924.6, -70 ), ( 0, 0, 0 ), "cspf_0_auto6821372922977222770", "cspf_0_auto14516226695605729897" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77740.5, -30514.5, -120.5 ), ( 0, 24.6, 0 ), "past_piano_pos", undefined, "sat_zm_sat_scriptable_mantis_piano" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55216.4, -29677.5, -128.71 ), ( 0, 0, 0 ), "cspf_0_auto243929879376856898" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77443.7, -31843.3, -132.63 ), ( 359.95, 331.57, -0 ), "zombiejacks_center", undefined, "sat_zm_signage_graphic_chalk_drawing_02" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 76191.8, -32350.6, -122 ), ( 271.32, 55.34, -154.34 ), "past_missing_piano_key" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77377.5, -30170.2, -121 ), ( 0, 25.4, 0 ), "foursquare_center", undefined, "sat_zm_signage_graphic_chalk_drawing_03" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77308, -30139, -82 ), ( 0, 24.2, 0 ), "foursquare_start_pos", undefined, "sat_zm_game_ball" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77443.7, -31843.3, -79 ), ( 0, 0, 0 ), "zombiejacks_start_pos", undefined, "sat_zm_game_ball" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 76727.2, -32027.8, -76 ), ( 0, 134.9, 0 ), "hopscotch_start_pos", undefined, "sat_zm_sat_scriptable_mantis_mq_minigame_anomaly" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 76728.4, -32028.1, -124 ), ( 0, 134.9, 0 ), "hopscotch_center", "cspf_0_auto3711332269876840829" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77205.6, -31723.4, -103.62 ), ( 0, 0, 0 ), "cspf_0_auto3366764800400587160", undefined, "end" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_int = int( 0 );
    s.script_scenescriptbundle = "sat_cin_zm_vig_mantis_sisters_ending_vignette";
    fe [[ f ]]( s, us, cf, ( 77772.7, -30493.3, -121 ), ( 0, 206.18, 0 ), "final_sister_scene", undefined, "hold_idle_exit_b" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 79744, -31560.8, -87.69 ), ( 0, 45, 0 ), "boss_fight_start", "cspf_0_auto3664794979730398261", "jup_ball_fanshop_01" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_label = "draw_chalk_play_space_2";
    s.script_scenescriptbundle = "sat_cin_zm_vig_mantis_sisters_draw_chalk";
    fe [[ f ]]( s, us, cf, ( 77471.5, -30205.5, -120.5 ), ( 0, 245.65, 0 ), "foursquare_chalk_scene", undefined, "chalk_02" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_scenescriptbundle = "sat_cin_zm_vig_mantis_sisters_ending_vignette";
    fe [[ f ]]( s, us, cf, ( 79739.6, -31560.4, -122.53 ), ( 0, 199.5, 0 ), "start_boss_sister_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 78519, -31856, -85.5 ), ( 0, 0, 0 ), "cspf_0_auto12664699440329784311", "cspf_0_auto2795420378854251975" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 53912, -33425.1, 203.44 ), ( 0, 223.9, 0 ), "cspf_0_auto9078073790900342018", undefined, "t10_zm_gameplay_collision_07" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 76564.5, -31867.7, -123.75 ), ( 0, 135.85, 0 ), "cspf_0_auto3711332269876840829", undefined, "sat_zm_signage_graphic_chalk_drawing_01" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 53947.1, -33397.7, -122.66 ), ( 359.76, 134.17, -78.99 ), "maxis_goggles_drop_pos", undefined, "c_sat_zmb_gear_maxis_headgear_goggles" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55302.9, -32296.3, -59.36 ), ( 90, 223.81, -1.02 ), "cspf_0_auto198965173952064219", "cspf_0_auto1766703932865346722", "sat_zm_sat_scriptable_music_note" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 54994.3, -31962.5, 164.35 ), ( 0, 0, 0 ), "music_notes", "cspf_0_auto198965173952064219" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 54559.8, -31415.4, -91.69 ), ( 53.51, 286.08, -36.79 ), "cspf_0_auto198965173952064219", "cspf_0_auto7758633774131767080", "sat_zm_sat_scriptable_music_note" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55293.8, -29459.2, -79.74 ), ( 81.8, 115.05, 2.22 ), "cspf_0_auto198965173952064219", "cspf_0_auto9690096682621639535", "sat_zm_sat_scriptable_music_note" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 57107.8, -32145.7, -84.45 ), ( 89.55, 331.17, -1.94 ), "cspf_0_auto198965173952064219", "cspf_0_auto12725883062846383885", "sat_zm_sat_scriptable_music_note" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 56540.8, -30920.4, -87.63 ), ( 90, 168.81, 54.55 ), "cspf_0_auto198965173952064219", "cspf_0_auto8817582586831565320", "sat_zm_sat_scriptable_music_note" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77759, -30583.3, -50.93 ), ( 90, 205, 180 ), "music_note_signs", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77676.9, -31291.2, -67.93 ), ( 0, 0, 0 ), "cspf_0_auto8093654259065243139", "cspf_0_auto3291694957987916864" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77751, -30566.8, -44.93 ), ( 90, 205, 180 ), "music_note_signs", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77906.9, -30493.2, -82.93 ), ( 0, 0, 0 ), "cspf_0_auto4026879632209212276", "cspf_0_auto18136127819381413689" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77742.5, -30547.8, -50.43 ), ( 90, 205, 180 ), "music_note_signs", undefined, "3" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77734, -30530.8, -42.93 ), ( 90, 205, 180 ), "music_note_signs", undefined, "4" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77726.5, -30513.3, -43.43 ), ( 90, 205, 180 ), "music_note_signs", undefined, "5" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55293.5, -30403.5, 82 ), ( 351.33, 290.94, 1.2 ), "maxis_headset", "cspf_0_auto4264972570514301611", "sat_zm_headgear_headphones" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55052, -33152, -90 ), ( 0, 315.74, 0 ), "cspf_0_auto14197701306635093978" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55116, -31160.4, -116.9 ), ( 274.97, 193.28, 89.59 ), "maxis_headset", undefined, "sat_zm_headgear_headphones" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 54795.5, -30190.7, -120.5 ), ( 0, 79.4, 0 ), "foursquare_x_pos_future", undefined, "sat_zm_signage_graphic_chalk_drawing_04", undefined, undefined, undefined, undefined, 50 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77752.7, -30508, -90.93 ), ( 0, 0, 0 ), "cspf_0_auto18136127819381413689", undefined, "end" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_label = "draw_chalk_play_space_3";
    s.script_scenescriptbundle = "sat_cin_zm_vig_mantis_sisters_draw_chalk";
    fe [[ f ]]( s, us, cf, ( 77442.9, -32010.1, -133.19 ), ( 0, 75.12, 0 ), "zombiejacks_chalk_scene", undefined, "chalk_03" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 79070.5, -32167.5, -85.5 ), ( 0, 0, 0 ), "cspf_0_auto2795420378854251975", "cspf_0_auto10971998492973243844" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 79440.5, -32026.5, -85.5 ), ( 0, 0, 0 ), "cspf_0_auto10971998492973243844", "cspf_0_auto14349835766566217115" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55295.1, -30410.8, 15 ), ( 0, 0, 0 ), "cspf_0_auto4264972570514301611" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_scenescriptbundle = "sat_cin_zm_mantis_outro";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "mantis_mq_outro" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 57124.5, -32498.5, -126.5 ), ( 0, 0, 0 ), "cspf_0_auto1525363431150185221" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 54230.5, -32067, -123.5 ), ( 0.28, 314.8, 0 ), "hopscotch_x_pos_future", undefined, "sat_zm_signage_graphic_chalk_drawing_04", undefined, undefined, undefined, undefined, 50 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 54879.4, -31875.5, -133.11 ), ( 0, 26.8, -0 ), "zombiejacks_x_pos_future", undefined, "sat_zm_signage_graphic_chalk_drawing_04", undefined, undefined, undefined, undefined, 50 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 79621.5, -31706, -85.5 ), ( 0, 0, 0 ), "cspf_0_auto14349835766566217115", "cspf_0_auto5659969973475187990" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_label = "draw_chalk_play_space_1";
    s.script_scenescriptbundle = "sat_cin_zm_vig_mantis_sisters_draw_chalk";
    fe [[ f ]]( s, us, cf, ( 76534.1, -31859.1, -123.93 ), ( 0, 50.56, 0 ), "hopscotch_chalk_scene", undefined, "chalk_01" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.is_cs_model = 1;
    s.model = "sat_zm_doomsday_support_clock_hour";
    s.var_4a62bf732f3923cb = "1";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 55383.6, -30209.9, 299.4 ), ( 349.9, 295.79, 296 ), "clock_hand", undefined, "hour" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55433.3, -31226.9, -78.77 ), ( 90, 254.55, -74.55 ), "cspf_0_auto198965173952064219", "cspf_0_auto13748670530290235892", "sat_zm_sat_scriptable_music_note" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.is_cs_model = 1;
    s.model = "sat_zm_doomsday_support_clock_minute";
    s.var_4a62bf732f3923cb = "1";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 55385.9, -30212.2, 300.25 ), ( 349.9, 295.79, 296 ), "clock_hand", undefined, "minute" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 79218, -31407, -85.5 ), ( 0, 0, 0 ), "cspf_0_auto5659969973475187990", "cspf_0_auto6680231451664153780" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55110.3, -30540.5, -122.59 ), ( 0, 0, 0 ), "cspf_0_auto8985748447387149663", "cspf_0_auto12592885041122148465" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 53878.5, -32302.5, 1 ), ( 0, 0, 0 ), "ball_start_pos", "cspf_0_auto5408529360290647446" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55191.5, -30986, -132.5 ), ( 0, 0, 0 ), "cspf_0_auto15412610530025066848", "cspf_0_auto8985748447387149663" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 54989.7, -30464.5, -124.44 ), ( 0, 0, 0 ), "cspf_0_auto12592885041122148465", "cspf_0_auto15008770580873982905" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 54888, -30403.3, -123.94 ), ( 0, 0, 0 ), "cspf_0_auto15008770580873982905", "cspf_0_auto12044331520402239660" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 54793.3, -30191.3, -120.94 ), ( 0, 0, 0 ), "cspf_0_auto12044331520402239660" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 54007.1, -32426.5, -131.87 ), ( 0, 0, 0 ), "cspf_0_auto5408529360290647446", "cspf_0_auto2263158699783428000" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 54259, -32033, -124.33 ), ( 0, 0, 0 ), "cspf_0_auto2263158699783428000", "cspf_0_auto17485832775305060372" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 54745.9, -31897.1, -133.19 ), ( 0, 0, 0 ), "cspf_0_auto17485832775305060372", "cspf_0_auto7185410915256911663" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55139.5, -31308.7, -124.44 ), ( 0, 0, 0 ), "cspf_0_auto7185410915256911663", "cspf_0_auto15412610530025066848" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 56735.4, -31707.1, 141.38 ), ( 0, 0, 0 ), "ball_start_pos", "cspf_0_auto14817069424202128498" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 56399.2, -30986.2, -127.64 ), ( 0, 0, 0 ), "cspf_0_auto14067186228105717228", "cspf_0_auto16207515576664947366" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 56867.5, -31236.5, -129 ), ( 0, 0, 0 ), "cspf_0_auto14817069424202128498", "cspf_0_auto14067186228105717228" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55875, -30680.1, -124.89 ), ( 0, 0, 0 ), "cspf_0_auto16207515576664947366", "cspf_0_auto533268361899988819" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55828.3, -30415.2, -126.07 ), ( 0, 0, 0 ), "cspf_0_auto533268361899988819", "cspf_0_auto14759011820258659690" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55521, -29935.7, -127.27 ), ( 0, 0, 0 ), "cspf_0_auto14759011820258659690", "cspf_0_auto13803233161149889945" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55117.8, -30019.8, -121.27 ), ( 0, 0, 0 ), "cspf_0_auto16975863974968154763", "cspf_0_auto12044331520402239660" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55349, -29861.2, -124.56 ), ( 0, 0, 0 ), "cspf_0_auto13803233161149889945", "cspf_0_auto16975863974968154763" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 54689, -29253.5, -129 ), ( 0, 0, 0 ), "piano_teacher", "cspf_0_auto243929879376856898" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55125, -29397.5, -129 ), ( 0, 0, 0 ), "cspf_0_auto243929879376856898" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 54959.8, -29790.4, -127.8 ), ( 0, 0, 0 ), "cspf_0_auto243929879376856898" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 54785, -30065.6, -120.5 ), ( 0, 0, 0 ), "cspf_0_auto243929879376856898" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 54420.7, -29558.6, -129.7 ), ( 0, 0, 0 ), "cspf_0_auto243929879376856898" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 54087.8, -33108.6, -54.66 ), ( 58.22, 215.5, 12.68 ), "cspf_0_auto198965173952064219", "cspf_0_auto2931530752649174671", "sat_zm_sat_scriptable_music_note" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55240, -30502.5, -121 ), ( 0, 202.98, 0 ), "future_piano_pos_teacher" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 58087.3, -32592.1, 257 ), ( 0, 328.82, 0 ), "lost_soul_fire_start_pos", "lost_soul_zombie", undefined, undefined, undefined, undefined, undefined, 500 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_scenescriptbundle = "sat_zm_mantis_zombie_floating_scene";
    fe [[ f ]]( s, us, cf, ( 58448, -31522.9, -114.74 ), ( 0, 167.35, 0 ), "cspf_0_auto2774729354935014165" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 54898, -32892, -120 ), ( 3.72, 134.16, -0.1 ), "garage_door_wood_shatter", undefined, "sat_zm_garage_door_wood_shatter" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_scenescriptbundle = "sat_zm_mantis_zombie_floating_scene";
    fe [[ f ]]( s, us, cf, ( 57963.9, -31144, -114.74 ), ( 0, 167.35, 0 ), "cspf_0_auto2774729354935014165" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_scenescriptbundle = "sat_zm_mantis_zombie_floating_scene";
    fe [[ f ]]( s, us, cf, ( 58402.2, -31012.9, -114.74 ), ( 0, 167.35, 0 ), "cspf_0_auto2774729354935014165" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_scenescriptbundle = "sat_zm_mantis_zombie_floating_scene";
    fe [[ f ]]( s, us, cf, ( 58314, -31330.6, -114.74 ), ( 0, 167.35, 0 ), "cspf_0_auto2774729354935014165" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55462.8, -28235.9, 257 ), ( 0, 232.82, 0 ), "lost_soul_fire_start_pos", "cspf_0_auto3382157710022830139", undefined, undefined, undefined, undefined, undefined, 500 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_scenescriptbundle = "sat_zm_mantis_zombie_floating_scene";
    fe [[ f ]]( s, us, cf, ( 55257.1, -28027.3, -114.74 ), ( 0, 68.75, 0 ), "cspf_0_auto3382157710022830139" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_scenescriptbundle = "sat_zm_mantis_zombie_floating_scene";
    fe [[ f ]]( s, us, cf, ( 55310.8, -28356.9, -114.74 ), ( 0, 68.75, 0 ), "cspf_0_auto3382157710022830139" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_scenescriptbundle = "sat_zm_mantis_zombie_floating_scene";
    fe [[ f ]]( s, us, cf, ( 55757.8, -27934.8, -114.74 ), ( 0, 68.75, 0 ), "cspf_0_auto3382157710022830139" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_scenescriptbundle = "sat_zm_mantis_zombie_floating_scene";
    fe [[ f ]]( s, us, cf, ( 58248.3, -32353.6, -119.53 ), ( 0, 164.76, 0 ), "lost_soul_zombie" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_scenescriptbundle = "sat_zm_mantis_zombie_floating_scene";
    fe [[ f ]]( s, us, cf, ( 58290, -32685.7, -123.02 ), ( 0, 164.76, 0 ), "lost_soul_zombie" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_scenescriptbundle = "sat_zm_mantis_zombie_floating_scene";
    fe [[ f ]]( s, us, cf, ( 58020.2, -32563.1, -114.74 ), ( 0, 164.76, 0 ), "lost_soul_zombie" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_scenescriptbundle = "sat_zm_mantis_zombie_floating_scene";
    fe [[ f ]]( s, us, cf, ( 57843.5, -33021.1, -122.23 ), ( 0, 164.76, 0 ), "lost_soul_zombie" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_scenescriptbundle = "sat_zm_mantis_zombie_floating_scene";
    fe [[ f ]]( s, us, cf, ( 58140.9, -33050.3, -123.89 ), ( 0, 164.76, 0 ), "lost_soul_zombie" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 78771.5, -31444, -68 ), ( 0, 241.17, 0 ), "music_box_final_pos", undefined, "sat_zm_antique_music_box_fxanim_scriptable" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 53739.8, -32104, -70.66 ), ( 90, 68.71, 111.29 ), "cspf_0_auto198965173952064219", "cspf_0_auto18088192592237035249", "sat_zm_sat_scriptable_music_note" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77719, -30496.3, -50.43 ), ( 90, 205, 180 ), "music_note_signs", undefined, "6" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77710.5, -30479.3, -45.93 ), ( 90, 205, 180 ), "music_note_signs", undefined, "7" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77702.5, -30461.3, -50.93 ), ( 90, 205, 180 ), "music_note_signs", undefined, "8" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 54410.7, -29655.5, -120.01 ), ( 283.38, 119.97, 0.6 ), "cspf_0_auto391427578238102491", undefined, "x1_rcxd_controller_01" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77205.6, -31723.4, -107.62 ), ( 0, 0, 0 ), "monkey_cymbals_in_box", undefined, "sat_zm_monkey_cymbals_fxanim" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 53331.5, -32700.5, -120 ), ( 342.82, 135.58, 0 ), "cspf_0_auto391427578238102491", undefined, "x1_rcxd_controller_01" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 56628, -31516, -99.81 ), ( 6.03, 110.88, 5.89 ), "cspf_0_auto391427578238102491", undefined, "x1_rcxd_controller_01" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 78008.5, -31437.5, -134.5 ), ( 0, 0, 0 ), "reward_spawn_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55898, -31187.5, 176.5 ), ( 0, 0, 0 ), "rcxd_controller", "cspf_0_auto391427578238102491" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 54306, -33626, -127 ), ( 0, 315.22, 0 ), "rcxd_start_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_scenescriptbundle = "sat_cin_zm_vig_mantis_sisters_swing_02";
    fe [[ f ]]( s, us, cf, ( 57251, -31551, -121.5 ), ( 0, 193.53, 0 ), "twins_swing_vig" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.is_cs_model = 1;
    s.model = "sat_zm_town_playground_swingset_01_fxanim";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 57249.5, -31592, -124 ), ( 0, 199.42, 0 ), "twins_swing_seat_future" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 78257.7, -31460.2, -80.25 ), ( 0, 0, 0 ), "cspf_0_auto5862570185058099288", "cspf_0_auto8488208643459836646" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77707.2, -31465.2, -80.25 ), ( 0, 0, 0 ), "cspf_0_auto8488208643459836646", "cspf_0_auto1582061778735844729" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 76854.1, -31795.9, -103.62 ), ( 0, 0, 0 ), undefined, undefined, "end" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77355.7, -31537.7, -80.25 ), ( 0, 0, 0 ), "cspf_0_auto1582061778735844729", "cspf_0_auto3366764800400587160" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 79050.5, -31585.5, -85.5 ), ( 0, 0, 0 ), "cspf_0_auto6680231451664153780", "cspf_0_auto18042029932913329955" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 78885.5, -31668.5, -85.5 ), ( 0, 0, 0 ), "cspf_0_auto18042029932913329955", "cspf_0_auto10032965503437339089" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77735.9, -30909.7, -67.93 ), ( 0, 0, 0 ), "cspf_0_auto3291694957987916864", "cspf_0_auto12899141909634632468" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77618.9, -30481.7, -67.93 ), ( 0, 0, 0 ), "cspf_0_auto12899141909634632468", "cspf_0_auto8965353319018282964" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77409.9, -30411.2, -67.93 ), ( 0, 0, 0 ), "cspf_0_auto8965353319018282964", "cspf_0_auto5031405407861832315" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77376.9, -30015.7, -67.93 ), ( 0, 0, 0 ), "cspf_0_auto5031405407861832315", "cspf_0_auto12826596010191712144" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77701.9, -29881.7, 55.57 ), ( 0, 0, 0 ), "cspf_0_auto12826596010191712144", "cspf_0_auto1938585769577197885" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77743.9, -30065.7, 55.57 ), ( 0, 0, 0 ), "cspf_0_auto1938585769577197885", "cspf_0_auto16087557189766152587" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77856.9, -30129.7, 55.57 ), ( 0, 0, 0 ), "cspf_0_auto16087557189766152587", "cspf_0_auto15851539815245656352" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77911.9, -30146.7, 55.57 ), ( 0, 0, 0 ), "cspf_0_auto15851539815245656352", "cspf_0_auto17777586822614695962" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77931.4, -30186.7, 55.57 ), ( 0, 0, 0 ), "cspf_0_auto17777586822614695962", "cspf_0_auto15560177595173577452" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 78035.9, -30425.2, -80.93 ), ( 0, 0, 0 ), "cspf_0_auto15560177595173577452", "cspf_0_auto4026879632209212276" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55114, -32547.7, 52.13 ), ( 0, 0, 0 ), "ball_start_pos", "cspf_0_auto17485832775305060372" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 76562.5, -31899.5, 61 ), ( 0, 0, 0 ), "hopscotch_game_spawner", "cspf_0_auto5243474811163202199" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_scenescriptbundle = "sat_cin_zm_vig_mantis_zombie_piano_open";
    fe [[ f ]]( s, us, cf, ( 77761, -30504.5, -121 ), ( 0, 206.09, 0 ), "zombie_open_piano" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 78135.5, -31150.5, 345.5 ), ( 0, 0, 0 ), "twins_vignette_cloud", "cspf_0_auto13363097043250229071", "vfx_t10_levels_zm_jade_cin_outro_sa_dark_aether_energy_top_blue_2", undefined, undefined, undefined, undefined, 400 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 78135.5, -31150.5, -132 ), ( 0, 0, 0 ), "cspf_0_auto13363097043250229071" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.is_cs_model = 1;
    s.model = "decor_barrels_gameplay_flammable";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 54970, -32865, -120 ), ( 0, 0, 0 ), "flammable_in_garage", undefined, undefined, undefined, undefined, undefined, undefined, 250 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_animation = "spawn_portal";
    s.var_b6279e33503ba8f = int( 1 );
    fe [[ f ]]( s, us, cf, ( 76487.5, -32147.5, -124 ), ( 0, 0, 0 ), "cspf_0_auto5243474811163202199", undefined, "zombie_base" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_animation = "spawn_portal";
    s.var_b6279e33503ba8f = int( 1 );
    fe [[ f ]]( s, us, cf, ( 76373.5, -31572.8, -124 ), ( 0, 0, 0 ), "cspf_0_auto5243474811163202199", undefined, "zombie_base" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_animation = "spawn_portal";
    s.var_b6279e33503ba8f = int( 1 );
    fe [[ f ]]( s, us, cf, ( 76953.6, -31821, -124.48 ), ( 0, 0, 0 ), "cspf_0_auto5243474811163202199", undefined, "zombie_base" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77378.1, -30150.3, 59.75 ), ( 0, 0, 0 ), "foursquare_game_spawner", "cspf_0_auto8238818152126730289" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_animation = "spawn_portal";
    s.var_b6279e33503ba8f = int( 1 );
    fe [[ f ]]( s, us, cf, ( 77432.2, -29829.3, -125.73 ), ( 0, 0, 0 ), "cspf_0_auto8238818152126730289", undefined, "zombie_base" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_animation = "spawn_portal";
    s.var_b6279e33503ba8f = int( 1 );
    fe [[ f ]]( s, us, cf, ( 77108.3, -29890.3, -128.91 ), ( 0, 0, 0 ), "cspf_0_auto8238818152126730289", undefined, "zombie_base" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_animation = "spawn_portal";
    s.var_b6279e33503ba8f = int( 1 );
    fe [[ f ]]( s, us, cf, ( 77151.4, -30367.7, -125 ), ( 0, 0, 0 ), "cspf_0_auto8238818152126730289", undefined, "zombie_base" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_animation = "spawn_portal";
    s.var_b6279e33503ba8f = int( 1 );
    fe [[ f ]]( s, us, cf, ( 77561, -30041.2, -120.5 ), ( 0, 0, 0 ), "cspf_0_auto8238818152126730289", undefined, "zombie_base" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77593.4, -31825.7, 48.41 ), ( 0, 0, 0 ), "zombiejacks_game_spawner", "cspf_0_auto14611393706213020704" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_animation = "spawn_portal";
    s.var_b6279e33503ba8f = int( 1 );
    fe [[ f ]]( s, us, cf, ( 77510.2, -32193.1, -120.84 ), ( 0, 0, 0 ), "cspf_0_auto14611393706213020704", undefined, "zombie_base" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_animation = "spawn_portal";
    s.var_b6279e33503ba8f = int( 1 );
    fe [[ f ]]( s, us, cf, ( 77226.7, -32031.7, -132.64 ), ( 0, 0, 0 ), "cspf_0_auto14611393706213020704", undefined, "zombie_base" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_animation = "spawn_portal";
    s.var_b6279e33503ba8f = int( 1 );
    fe [[ f ]]( s, us, cf, ( 77272.1, -31538.3, -123.99 ), ( 0, 0, 0 ), "cspf_0_auto14611393706213020704", undefined, "zombie_base" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_animation = "spawn_portal";
    s.var_b6279e33503ba8f = int( 1 );
    fe [[ f ]]( s, us, cf, ( 77066.1, -31797.5, -123.85 ), ( 0, 0, 0 ), "cspf_0_auto14611393706213020704", undefined, "zombie_base" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_scenescriptbundle = "sat_zm_mantis_zombie_floating_scene";
    fe [[ f ]]( s, us, cf, ( 55822, -28387.8, -114.74 ), ( 0, 68.75, 0 ), "cspf_0_auto3382157710022830139" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_scenescriptbundle = "sat_zm_mantis_zombie_floating_scene";
    fe [[ f ]]( s, us, cf, ( 55521, -28253.1, -114.74 ), ( 0, 68.75, 0 ), "cspf_0_auto3382157710022830139" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 53703.3, -28791, 257 ), ( 0, 261.85, 0 ), "lost_soul_fire_start_pos", "cspf_0_auto4873392031821325150", undefined, undefined, undefined, undefined, undefined, 500 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_scenescriptbundle = "sat_zm_mantis_zombie_floating_scene";
    fe [[ f ]]( s, us, cf, ( 53437.2, -28839.8, -114.74 ), ( 0, 97.79, 0 ), "cspf_0_auto4873392031821325150" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_scenescriptbundle = "sat_zm_mantis_zombie_floating_scene";
    fe [[ f ]]( s, us, cf, ( 53571.6, -29017.4, -114.74 ), ( 0, 97.79, 0 ), "cspf_0_auto4873392031821325150" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_scenescriptbundle = "sat_zm_mantis_zombie_floating_scene";
    fe [[ f ]]( s, us, cf, ( 53874.1, -28542.9, -114.74 ), ( 0, 97.79, 0 ), "cspf_0_auto4873392031821325150" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_scenescriptbundle = "sat_zm_mantis_zombie_floating_scene";
    fe [[ f ]]( s, us, cf, ( 54033.5, -28796.3, -114.74 ), ( 0, 97.79, 0 ), "cspf_0_auto4873392031821325150" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.script_scenescriptbundle = "sat_zm_mantis_zombie_floating_scene";
    fe [[ f ]]( s, us, cf, ( 53705, -28824.6, -114.74 ), ( 0, 97.79, 0 ), "cspf_0_auto4873392031821325150" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 54669, -31729.1, -124 ), ( 0, 52.78, 0 ), "future_toy_box", undefined, "sat_zm_toy_chest_fxanim" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77731, -30522, -24.5 ), ( 68.57, 114.56, 90.57 ), "music_low_note" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 78757.4, -31461.9, -121 ), ( 0, 0, 0 ), "music_box_reward_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77238, -31686.5, -124 ), ( 0, 0, 0 ), "monkey_cymbals_reward_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77775.8, -30494.3, -121 ), ( 0, 0, 0 ), "sheet_music_reward_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 54670, -31728, -105 ), ( 0, 0, 0 ), "future_monkey_cymbals_in_box", undefined, "sat_zm_monkey_cymbals_fxanim" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 57211.1, -31478.8, -122.62 ), ( 0, 288.29, 0 ), "swing_safe_point_future" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 57344, -31525.5, -122.5 ), ( 0, 192.94, 0 ), "swing_safe_point_future" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 57146, -31607.4, -123.64 ), ( 0, 24.27, 0 ), "swing_safe_point_future" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 57258.2, -31626.2, -122.15 ), ( 0, 117.86, 0 ), "swing_safe_point_future" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77729, -31555.5, -17 ), ( 0, 0, 0 ), "final_teleport_pos_past", "cspf_0_auto15881537516688167002" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77674.6, -31470.8, -134.75 ), ( 0, 49.93, 0 ), "cspf_0_auto15881537516688167002", undefined, "player_position" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77729.6, -31517.3, -133.15 ), ( 0, 49.93, 0 ), "cspf_0_auto15881537516688167002", undefined, "player_position" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77776.8, -31560, -131.52 ), ( 0, 49.93, 0 ), "cspf_0_auto15881537516688167002", undefined, "player_position" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 77824.3, -31594.3, -137.9 ), ( 0, 49.93, 0 ), "cspf_0_auto15881537516688167002", undefined, "player_position" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 54672.3, -31736.7, -102.12 ), ( 0, 58.02, 0 ), "future_maxis_goggles_in_box", undefined, "c_sat_zmb_gear_maxis_headgear_goggles" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 54659.3, -31728.2, -108.62 ), ( 0, 0, 0 ), "future_maxis_headphone_in_box", undefined, "c_sat_zmb_gear_maxis_headgear_headphones" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.groupid = "rc_waypoints";
    fe [[ f ]]( s, us, cf, ( 55304, -33536, -48 ), ( 0, 0, 0 ), "rcw1", undefined, "rc_wayp" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 56241, -31447, -68 ), ( 0, 238, 0 ), "future_music_box", undefined, "sat_zm_antique_music_box_fxanim_scriptable" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55221, -30512, -88 ), ( 83.77, 310.24, -72.18 ), "future_sheet_music", undefined, "sat_zm_music_sheet_fxnaim" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.groupid = "rc_waypoints";
    fe [[ f ]]( s, us, cf, ( 54972, -33888, -48 ), ( 0, 0, 0 ), "rcw0", undefined, "rc_wayp" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    s.groupid = "rc_waypoints";
    fe [[ f ]]( s, us, cf, ( 54948, -33420, -116 ), ( 0, 0, 0 ), "rcw2", undefined, "rc_wayp" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 79776, -31608, -120 ), ( 0, 109.7, 0 ), "swing_safe_point_past" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 54391, -33036, -130 ), ( 0, 0, 0 ), "dm_axe" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 78864, -31581, -86 ), ( 0, 0, 0 ), "dm_mol" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 79704, -31576, -120 ), ( 0, 19.7, 0 ), "swing_safe_point_past" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 79744, -31504, -120 ), ( 0, 289.7, 0 ), "swing_safe_point_past" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 79816, -31536, -120 ), ( 0, 199.7, 0 ), "swing_safe_point_past" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 54078.7, -33112.9, -57.29 ), ( 0, 0, 0 ), "cspf_0_auto2931530752649174671" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 53749.7, -32112.9, -70.32 ), ( 0, 315.19, 0 ), "cspf_0_auto18088192592237035249" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55296.4, -32304.7, -58.64 ), ( 0, 228.52, 0 ), "cspf_0_auto1766703932865346722" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 54569.5, -31423.8, -90.89 ), ( 0, 324.97, 0 ), "cspf_0_auto7758633774131767080" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55442.4, -31232.1, -79.19 ), ( 0, 332.79, 0 ), "cspf_0_auto13748670530290235892" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 57118.2, -32152.3, -84.29 ), ( 0, 330.01, 0 ), "cspf_0_auto12725883062846383885" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 55290.1, -29449.4, -85.44 ), ( 0, 117.97, 0 ), "cspf_0_auto9690096682621639535" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_mq_cs";
    fe [[ f ]]( s, us, cf, ( 56538.1, -30911.8, -89.57 ), ( 0, 114.95, 0 ), "cspf_0_auto8817582586831565320" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_mantis_quest_mq_cs
// Params 0, eflags: 0x4
// Checksum 0xd9a28a80, Offset: 0x5e1b
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_mantis_quest_mq_cs
// Params 0
// Checksum 0x16b2d0fd, Offset: 0x5e25
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_mantis_quest_mq_cs" );
}

