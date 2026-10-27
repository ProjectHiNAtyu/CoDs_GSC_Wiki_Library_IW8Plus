// scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_vo.gsc  (hash_50fb9476adfdc82b.gscc) (size: 15589 Bytes / 0x3ce5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x745266ba (1951557306)
// size ...... 15589 (0x3ce5)
// includes .. 3   (offset: 0x33dd)
// strings ... 181 (offset: 0x33f5)
// dev strs .. 0   (offset: 0x3ce5)
// exports ... 40  (offset: 0x285d)
// cseg ...... 0x153c + 0x1321 (0x285d)
// imports ... 32  (offset: 0x2e9d)
// animtree1 . 0   (offset: 0x3ce5)
// animtree2 . 0   (offset: 0x3ce5)
#using scripts\common\utility;
#using scripts\mp\ob\ob_dialogue_util;
#using scripts\mp\overlord;

#namespace virgo_vo;

/#

    // Namespace virgo_vo
    // Params 0
    // Checksum 0x52cdb441, Offset: 0x155a
    // Size: 0x5, Type: dev
    function function_ad4ff05b329205f()
    {
        
    }

#/

// Namespace virgo_vo
// Params 0
// Checksum 0x419db974, Offset: 0x1567
// Size: 0x184
function init_virgo_radio()
{
    waitframe();
    
    if ( !isdefined( level.david_radio ) )
    {
        level.david_radio = spawnstruct();
        level.david_radio.team = "allies";
        level.david_radio.name = "David Mason";
    }
    
    if ( !isdefined( level.fiftyfifty_radio ) )
    {
        level.fiftyfifty_radio = spawnstruct();
        level.fiftyfifty_radio.team = "allies";
        level.fiftyfifty_radio.name = "50-50";
    }
    
    if ( !isdefined( level.harper_radio ) )
    {
        level.harper_radio = spawnstruct();
        level.harper_radio.team = "allies";
        level.harper_radio.name = "Harper";
    }
    
    if ( !isdefined( level.boss_radio ) )
    {
        level.boss_radio = spawnstruct();
        level.boss_radio.team = "axis";
        level.boss_radio.name = "Harper";
    }
    
    if ( !isdefined( level.samuels ) )
    {
        level.samuels = spawnstruct();
        level.samuels.team = "allies";
        level.samuels.name = "Samuels";
    }
}

/#

    // Namespace virgo_vo
    // Params 0
    // Checksum 0x29dc8e45, Offset: 0x16f3
    // Size: 0x5, Type: dev
    function function_45eef806df21f9b7()
    {
        
    }

    // Namespace virgo_vo
    // Params 0
    // Checksum 0x23fc1b25, Offset: 0x1700
    // Size: 0x5, Type: dev
    function function_7982e0a1bc72d2ed()
    {
        
    }

#/

// Namespace virgo_vo
// Params 0
// Checksum 0xefff8583, Offset: 0x170d
// Size: 0x38
function function_1f6c509486d76288()
{
    level thread function_ec5e0cb61c90b6be( "flag_intro_igc_done", "conv_la_freeway_intro_01" );
    level thread function_a9384b4fa795193a( "flag_play_civs_fleeing_vo", "flag_spawn_bo2_hover_jet" );
    level thread function_27ffcc2318635693( "flag_spawn_memory_jump_01", "event_la_freeway_rift_callout" );
}

// Namespace virgo_vo
// Params 2
// Checksum 0xa9c1a252, Offset: 0x174d
// Size: 0x54
function function_a9384b4fa795193a( flag_to_start, flag_to_end )
{
    level utility::flag_wait( flag_to_start );
    level thread function_ec5e0cb61c90b6be( undefined, "conv_la_freeway_echos" );
    
    if ( level utility::flag( flag_to_end ) )
    {
        return;
    }
    
    if ( level utility::flag( flag_to_end ) )
    {
        return;
    }
    
    if ( level utility::flag( flag_to_end ) )
    {
        return;
    }
}

// Namespace virgo_vo
// Params 0
// Checksum 0x7a1aafad, Offset: 0x17a9
// Size: 0x69
function inverted_freeway_vo()
{
    function_ec5e0cb61c90b6be( undefined, "conv_la_freeway_sorry" );
    level thread function_ec5e0cb61c90b6be( "flag_spawn_hill_enemies", "conv_la_freeway_inverted_intro" );
    level thread function_27ffcc2318635693( "flag_initial_ambush_fallback", "event_combat_callout_01" );
    level thread function_ec5e0cb61c90b6be( "flag_sandwich_fallback", "conv_la_freeway_encourage" );
    level thread function_27ffcc2318635693( "flag_player_at_inverted_ambush", "event_combat_callout_02" );
    level thread function_27ffcc2318635693( "flag_sandwich_flippers", "event_combat_callout_04" );
}

// Namespace virgo_vo
// Params 0
// Checksum 0x784b5f74, Offset: 0x181a
// Size: 0x7f
function function_93593d5e3c494229()
{
    function_27ffcc2318635693( undefined, "event_la_freeway_no_sense" );
    level thread function_27ffcc2318635693( undefined, "event_la_freeway_keep_moving" );
    level thread function_27ffcc2318635693( "flag_mid_freeway_fallback", "event_la_freeway_keep_it_up" );
    level thread function_27ffcc2318635693( "flag_player_inverted_ambush_mid", "event_combat_callout_07" );
    level thread function_27ffcc2318635693( "flag_end_canyon_reinforcement_vo", "event_combat_callout_06" );
    level thread function_27ffcc2318635693( "flag_reinforce_objective_vo", "event_la_freeway_getdrone_mole" );
    level thread function_27ffcc2318635693( "flag_start_canyon_flippers", "event_combat_callout_08" );
    level thread parkour_vo();
}

// Namespace virgo_vo
// Params 0
// Checksum 0x95c2f89d, Offset: 0x18a1
// Size: 0x73
function parkour_vo()
{
    level thread function_27ffcc2318635693( "flag_parkour_top", "event_la_freeway_frogger_intro" );
    level thread function_27ffcc2318635693( "flag_parkour_start", "event_la_freeway_climbing", "flag_event_la_freeway_climbing_done" );
    level thread function_27ffcc2318635693( "flag_event_la_freeway_climbing_done", "event_la_freeway_get_topside", "flag_event_la_freeway_get_topside_done" );
    level thread function_ec5e0cb61c90b6be( "flag_event_la_freeway_get_topside_done", "conv_la_freeway_parkour", "flag_conv_la_freeway_parkour_done" );
    level thread function_27ffcc2318635693( "flag_parkour_vo_climb", "event_la_freeway_use_to_climb" );
    level thread frogger_vo();
}

// Namespace virgo_vo
// Params 0
// Checksum 0x2b1df3e9, Offset: 0x191c
// Size: 0x2b
function frogger_vo()
{
    level thread function_27ffcc2318635693( "flag_frogger_la_traffic", "event_la_freeway_typical_traffic" );
    level thread function_27ffcc2318635693( "flag_frogger_move_quick", "event_la_freeway_gottamovequick", "frogger_move_quick_vo_done" );
}

// Namespace virgo_vo
// Params 0
// Checksum 0x483aff8b, Offset: 0x194f
// Size: 0x13b
function freeway_crashsite()
{
    level thread function_27ffcc2318635693( "flag_toDrone_wave3", "event_la_freeway_dawgs", undefined, 3 );
    level thread function_27ffcc2318635693( "flag_play_drone_crashed_vo", "event_la_freeway_drone_crash", "flag_play_drone_crashed_vo_done" );
    level thread function_27ffcc2318635693( "flag_crashed_drone_start_hack_obj", "event_la_freeway_hack_callout_00", "flag_crashed_drone_start_hack_obj_done" );
    level thread function_27ffcc2318635693( "flag_crashed_drone_start_hack_obj_done", "event_la_freeway_guild_drone", "flag_start_drone_nags" );
    level thread function_27ffcc2318635693( "flag_toDrone_wave3", "event_combat_callout_05" );
    level thread function_27ffcc2318635693( "flag_toDrone_wave2_vo", "event_la_freeway_more" );
    level thread function_27ffcc2318635693( "flag_toDrone_wave3_vo", "event_la_freeway_acquire" );
    level thread function_27ffcc2318635693( "drone_defend_wave_1_vo", "event_la_freeway_tangos", "flag_defend_wave_01_vo_done" );
    level thread function_27ffcc2318635693( "flag_defend_wave_01_vo_done", "event_la_freeway_hack_progress" );
    level thread function_27ffcc2318635693( "drone_defend_wave_2_vo", "event_combat_callout_09" );
    level thread function_27ffcc2318635693( "flag_play_heavy_ai_vo", "event_la_freeway_heavy" );
    level thread function_27ffcc2318635693( "play_single_titan_dead_vo", "event_la_freeway_single_titan_down", "play_all_clear_vo" );
    level thread function_27ffcc2318635693( "all_drone_juggers_dead", "event_la_freeway_both_titans_down", "play_all_clear_vo" );
    level thread function_27ffcc2318635693( "play_all_clear_vo", "event_la_freeway_all_clear_samuels", "flag_all_clear_line_done" );
    level thread function_27ffcc2318635693( "flag_all_clear_line_done", "event_la_freeway_we_got_them_samuels", "all_clear_vo_done" );
}

/#

    // Namespace virgo_vo
    // Params 0
    // Checksum 0x2294abcf, Offset: 0x1a92
    // Size: 0x5, Type: dev
    function function_8357fc97bfb0c022()
    {
        
    }

#/

// Namespace virgo_vo
// Params 0
// Checksum 0x591b0f4e, Offset: 0x1a9f
// Size: 0x16
function function_8d45fc2fb5f863eb()
{
    level endon( #"game_ended" );
    level function_b17861dc00d97571();
}

// Namespace virgo_vo
// Params 0
// Checksum 0x11282945, Offset: 0x1abd
// Size: 0xb3
function function_b17861dc00d97571()
{
    level endon( #"game_ended" );
    level.david_radio thread ob_dialogue_util::ob_dialogue_print( "Now where the fuck are we?" );
    wait 3;
    level.fiftyfifty_radio thread ob_dialogue_util::ob_dialogue_print( "DNI link by the looks of it, some sort of safe mode?" );
    wait 3;
    level.harper_radio thread ob_dialogue_util::ob_dialogue_print( "More like void mode" );
    wait 3;
    level.harper_radio thread ob_dialogue_util::ob_dialogue_print( "At least the drone decided to tag along" );
    wait 3;
    level.fiftyfifty_radio thread ob_dialogue_util::ob_dialogue_print( "This reminds me so much of Japan, my first failed OP" );
    wait 3;
    level.harper_radio thread ob_dialogue_util::ob_dialogue_print( "It doesn't have to be like that" );
    wait 3;
    level.fiftyfifty_radio thread ob_dialogue_util::ob_dialogue_print( "I can't help it.  Mason, I fear so much of this has happened before" );
}

/#

    // Namespace virgo_vo
    // Params 0
    // Checksum 0x114f261d, Offset: 0x1b78
    // Size: 0x5, Type: dev
    function function_10035a419d2bdc90()
    {
        
    }

#/

// Namespace virgo_vo
// Params 0
// Checksum 0xa53cf1da, Offset: 0x1b85
// Size: 0x9b
function function_959cd51445082fb8()
{
    level endon( #"game_ended" );
    level thread function_27ffcc2318635693( undefined, "event_japan_toolatetostop", undefined, 1 );
    level thread function_27ffcc2318635693( "flag_japan_intro_1", "event_japan_press_on" );
    level thread function_27ffcc2318635693( "flag_japan_inside", "event_japan_get_out" );
    level thread function_27ffcc2318635693( "flag_warehouse_scene_done", "event_japan_intro_listen", "flag_alley_combat_vo" );
    level thread function_27ffcc2318635693( "flag_alley_combat_vo", "event_combat_callout_03", undefined, 3 );
    level thread function_ec5e0cb61c90b6be( "flag_japan_puzzle_start", "conv_japan_pre_puzzle_echo" );
    level thread virgo_puzzle();
    level thread function_27ffcc2318635693( "flag_japan_echo_assembled", "event_japan_puzzle_done" );
}

// Namespace virgo_vo
// Params 0
// Checksum 0x82022d66, Offset: 0x1c28
// Size: 0x22f
function virgo_puzzle()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "flag_japan_echo_1" );
    function_ec5e0cb61c90b6be( undefined, "conv_japan_puzzle_pre" );
    
    switch ( level.puzzle_prefix )
    {
        case 5900:
            function_27ffcc2318635693( undefined, "event_japan_puzzle_01_01" );
            break;
        case 3600:
            function_27ffcc2318635693( undefined, "event_japan_puzzle_02_01" );
            break;
        case 7400:
            function_27ffcc2318635693( undefined, "event_japan_puzzle_03_01" );
            break;
        case 4200:
            function_27ffcc2318635693( undefined, "event_japan_puzzle_04_01" );
            break;
        case 8300:
            function_27ffcc2318635693( undefined, "event_japan_puzzle_05_01" );
            break;
        default:
            break;
    }
    
    if ( level utility::flag( "flag_japan_echo_assembled" ) )
    {
        return;
    }
    
    function_ec5e0cb61c90b6be( undefined, "conv_japan_puzzle_hunt" );
    wait 5;
    
    if ( level utility::flag( "flag_japan_echo_assembled" ) )
    {
        return;
    }
    
    function_27ffcc2318635693( undefined, "event_japan_50_jumbled" );
    
    if ( level utility::flag( "flag_japan_echo_assembled" ) )
    {
        return;
    }
    
    wait 5;
    
    switch ( level.puzzle_prefix )
    {
        case 5900:
            level thread function_f16db5ee89b4371d( "flag_japan_echo_assembled", [ "event_japan_puzzle_01_02", "event_japan_puzzle_01_03" ] );
            break;
        case 3600:
            level thread function_f16db5ee89b4371d( "flag_japan_echo_assembled", [ "event_japan_puzzle_02_02", "event_japan_puzzle_02_03" ] );
            break;
        case 7400:
            level thread function_f16db5ee89b4371d( "flag_japan_echo_assembled", [ "event_japan_puzzle_03_02", "event_japan_puzzle_03_03" ] );
            break;
        case 4200:
            level thread function_f16db5ee89b4371d( "flag_japan_echo_assembled", [ "event_japan_puzzle_04_02", "event_japan_puzzle_04_03" ] );
            break;
        case 8300:
            level thread function_f16db5ee89b4371d( "flag_japan_echo_assembled", [ "event_japan_puzzle_05_02", "event_japan_puzzle_05_03" ] );
            break;
        default:
            break;
    }
}

// Namespace virgo_vo
// Params 0
// Checksum 0x3e00d9cf, Offset: 0x1e5f
// Size: 0x55
function function_dacd191256516a47()
{
    level endon( #"game_ended" );
    
    if ( level.players.size > 2 )
    {
        level thread function_27ffcc2318635693( "flag_garden_enemies_spawned_4", "event_japan_juggerbot_2" );
    }
    else
    {
        level thread function_27ffcc2318635693( "flag_garden_enemies_spawned_4", "event_japan_juggerbot_1" );
    }
    
    level thread function_6ffb31246f8ada37();
    level thread function_6927b9661688a30d();
}

// Namespace virgo_vo
// Params 0
// Checksum 0xda11b7c7, Offset: 0x1ebc
// Size: 0x5b
function function_6ffb31246f8ada37()
{
    level function_ec5e0cb61c90b6be( "flag_garden_combat_start", "conv_japan_post_puzzle" );
    struct = utility::getstruct( "struct_obj_waypoint_japan_fight", "targetname" );
    playsoundatpos( struct.origin, "dx_wc_irgo_vroj_five_ohgod" );
    wait 1;
    level thread function_ec5e0cb61c90b6be( undefined, "conv_japan_post_puzzle_end", "flag_start_garden_countdown" );
}

// Namespace virgo_vo
// Params 0
// Checksum 0x7403c374, Offset: 0x1f1f
// Size: 0x49
function function_6927b9661688a30d()
{
    level utility::flag_wait( "flag_japan_tanks_defeated" );
    
    if ( level utility::flag( "flag_virgo_japan_fight_done" ) )
    {
        return;
    }
    
    function_ec5e0cb61c90b6be( undefined, "conv_japan_resolution_01" );
    
    if ( level utility::flag( "flag_virgo_japan_fight_done" ) )
    {
        return;
    }
    
    function_ec5e0cb61c90b6be( undefined, "conv_japan_resolution_02" );
}

// Namespace virgo_vo
// Params 0
// Checksum 0x678dcd1c, Offset: 0x1f70
// Size: 0xf
function function_d9b71014391c5c18()
{
    level utility::flag_wait( "flag_japan_at_safehouse" );
}

/#

    // Namespace virgo_vo
    // Params 0
    // Checksum 0x1b19970a, Offset: 0x1f87
    // Size: 0x5, Type: dev
    function function_f0c4f54dd26d41df()
    {
        
    }

#/

// Namespace virgo_vo
// Params 0
// Checksum 0x1f6dc723, Offset: 0x1f94
// Size: 0x16
function function_3e53993386fff9d8()
{
    level endon( #"game_ended" );
    level function_e1c55832380a22f4();
}

// Namespace virgo_vo
// Params 0
// Checksum 0x4620c73f, Offset: 0x1fb2
// Size: 0x83
function function_e1c55832380a22f4()
{
    level endon( #"game_ended" );
    level.david_radio thread ob_dialogue_util::ob_dialogue_print( "See, Fifty, we made it back here" );
    wait 3;
    level.fiftyfifty_radio thread ob_dialogue_util::ob_dialogue_print( "Ah, yes, void sweet void" );
    wait 3;
    level.fiftyfifty_radio thread ob_dialogue_util::ob_dialogue_print( "Um, what is that?" );
    wait 3;
    level.harper_radio thread ob_dialogue_util::ob_dialogue_print( "USS Obama console?  What is it doing here?" );
    wait 3;
    level.boss_radio thread ob_dialogue_util::ob_dialogue_print( "Don't touch it!" );
}

/#

    // Namespace virgo_vo
    // Params 0
    // Checksum 0x1dcc73db, Offset: 0x203d
    // Size: 0x5, Type: dev
    function function_379937598201b27a()
    {
        
    }

#/

// Namespace virgo_vo
// Params 0
// Checksum 0xded8cd99, Offset: 0x204a
// Size: 0xaa
function function_62378c0819bf51db()
{
    level endon( #"game_ended" );
    level thread function_ec5e0cb61c90b6be( "flag_start_boss_fight", "conv_carrier_stage_01" );
    level thread function_ec5e0cb61c90b6be( "flag_start_boss_fight_2", "conv_carrier_stage_02", undefined, 6 );
    level thread function_ec5e0cb61c90b6be( "flag_start_boss_fight_3", "conv_carrier_stage_03", undefined, 6 );
    level thread function_27ffcc2318635693( "flag_spawn_encounter_1", "event_carrier_harper_down_1" );
    level thread function_27ffcc2318635693( "flag_spawn_encounter_2", "event_carrier_harper_down_2" );
    level thread function_27ffcc2318635693( "flag_spawn_encounter_1", "event_carrier_enemy_callout_01", undefined, 6 );
    level thread function_27ffcc2318635693( "flag_spawn_encounter_2", "event_carrier_enemy_callout_02", undefined, 6 );
    level thread function_27ffcc2318635693( "flag_start_harper_gas_ring", "event_carrier_gas_callout_01" );
}

// Namespace virgo_vo
// Params 0
// Checksum 0xc0012ab, Offset: 0x20fc
// Size: 0x71
function function_ae0ea9b1fbab45d2()
{
    if ( !isdefined( level.var_72ae08645ad0c1ef ) )
    {
        init_boss_callouts();
    }
    
    if ( !isdefined( level.var_71784a99e9a7418a ) )
    {
        level.var_71784a99e9a7418a = 0;
    }
    else
    {
        level.var_71784a99e9a7418a++;
    }
    
    line_number = level.var_71784a99e9a7418a % level.var_72ae08645ad0c1ef.size;
    level thread function_27ffcc2318635693( undefined, level.var_72ae08645ad0c1ef[ line_number ] );
}

// Namespace virgo_vo
// Params 0
// Checksum 0xe3d6fe60, Offset: 0x2175
// Size: 0x71
function function_e0b9e67ee5cf3eb6()
{
    if ( !isdefined( level.var_f243716fcccb2c10 ) )
    {
        init_boss_callouts();
    }
    
    if ( !isdefined( level.var_3f2b216a0ce64a4b ) )
    {
        level.var_3f2b216a0ce64a4b = 0;
    }
    else
    {
        level.var_3f2b216a0ce64a4b++;
    }
    
    line_number = level.var_3f2b216a0ce64a4b % level.var_f243716fcccb2c10.size;
    level thread function_27ffcc2318635693( undefined, level.var_f243716fcccb2c10[ line_number ] );
}

// Namespace virgo_vo
// Params 0
// Checksum 0x4b02f6f6, Offset: 0x21ee
// Size: 0x71
function function_41c202a0e44c503()
{
    if ( !isdefined( level.var_d0526a5e71178daf ) )
    {
        init_boss_callouts();
    }
    
    if ( !isdefined( level.var_45fc783c16f9ab4a ) )
    {
        level.var_45fc783c16f9ab4a = 0;
    }
    else
    {
        level.var_45fc783c16f9ab4a++;
    }
    
    line_number = level.var_45fc783c16f9ab4a % level.var_d0526a5e71178daf.size;
    level thread function_27ffcc2318635693( undefined, level.var_d0526a5e71178daf[ line_number ] );
}

// Namespace virgo_vo
// Params 0
// Checksum 0x1ba22b66, Offset: 0x2267
// Size: 0x71
function function_24bf2574be98a7dc()
{
    if ( !isdefined( level.var_30ee23a30b46c2ee ) )
    {
        init_boss_callouts();
    }
    
    if ( !isdefined( level.var_3e382dbe83093969 ) )
    {
        level.var_3e382dbe83093969 = 0;
    }
    else
    {
        level.var_3e382dbe83093969++;
    }
    
    line_number = level.var_3e382dbe83093969 % level.var_30ee23a30b46c2ee.size;
    level thread function_27ffcc2318635693( undefined, level.var_30ee23a30b46c2ee[ line_number ] );
}

// Namespace virgo_vo
// Params 1
// Checksum 0xd90e2b2f, Offset: 0x22e0
// Size: 0x4f
function function_8fc7604fee5f9b45( count )
{
    if ( !isdefined( level.var_8fc7604fee5f9b45 ) )
    {
        init_boss_callouts();
    }
    
    index = count % level.var_8fc7604fee5f9b45.size;
    level thread function_27ffcc2318635693( undefined, level.var_8fc7604fee5f9b45[ index ] );
}

// Namespace virgo_vo
// Params 0
// Checksum 0x820fd55b, Offset: 0x2337
// Size: 0x280
function init_boss_callouts()
{
    level.var_d0526a5e71178daf = [];
    level.var_d0526a5e71178daf[ level.var_d0526a5e71178daf.size ] = "event_carrier_yell_callout_01";
    level.var_d0526a5e71178daf[ level.var_d0526a5e71178daf.size ] = "event_carrier_yell_callout_02";
    level.var_d0526a5e71178daf[ level.var_d0526a5e71178daf.size ] = "event_carrier_yell_callout_03";
    level.var_d0526a5e71178daf[ level.var_d0526a5e71178daf.size ] = "event_carrier_yell_callout_04";
    level.var_d0526a5e71178daf[ level.var_d0526a5e71178daf.size ] = "event_carrier_yell_callout_05";
    level.var_d0526a5e71178daf[ level.var_d0526a5e71178daf.size ] = "event_carrier_yell_callout_06";
    level.var_72ae08645ad0c1ef = [];
    level.var_72ae08645ad0c1ef[ level.var_72ae08645ad0c1ef.size ] = "event_carrier_killstreak_callout_01";
    level.var_72ae08645ad0c1ef[ level.var_72ae08645ad0c1ef.size ] = "event_carrier_killstreak_callout_02";
    level.var_72ae08645ad0c1ef[ level.var_72ae08645ad0c1ef.size ] = "event_carrier_killstreak_callout_03";
    level.var_72ae08645ad0c1ef[ level.var_72ae08645ad0c1ef.size ] = "event_carrier_killstreak_callout_04";
    level.var_72ae08645ad0c1ef[ level.var_72ae08645ad0c1ef.size ] = "event_carrier_killstreak_callout_05";
    level.var_72ae08645ad0c1ef[ level.var_72ae08645ad0c1ef.size ] = "event_carrier_killstreak_callout_06";
    level.var_30ee23a30b46c2ee = [];
    level.var_30ee23a30b46c2ee[ level.var_30ee23a30b46c2ee.size ] = "event_carrier_slam_callout_01";
    level.var_30ee23a30b46c2ee[ level.var_30ee23a30b46c2ee.size ] = "event_carrier_slam_callout_02";
    level.var_30ee23a30b46c2ee[ level.var_30ee23a30b46c2ee.size ] = "event_carrier_slam_callout_03";
    level.var_30ee23a30b46c2ee[ level.var_30ee23a30b46c2ee.size ] = "event_carrier_slam_callout_04";
    level.var_30ee23a30b46c2ee[ level.var_30ee23a30b46c2ee.size ] = "event_carrier_slam_callout_05";
    level.var_30ee23a30b46c2ee[ level.var_30ee23a30b46c2ee.size ] = "event_carrier_slam_callout_06";
    level.var_f243716fcccb2c10 = [];
    level.var_f243716fcccb2c10[ level.var_f243716fcccb2c10.size ] = "event_carrier_gas_callout_01";
    level.var_f243716fcccb2c10[ level.var_f243716fcccb2c10.size ] = "event_carrier_gas_callout_02";
    level.var_f243716fcccb2c10[ level.var_f243716fcccb2c10.size ] = "event_carrier_gas_callout_03";
    level.var_f243716fcccb2c10[ level.var_f243716fcccb2c10.size ] = "event_carrier_gas_callout_04";
    level.var_f243716fcccb2c10[ level.var_f243716fcccb2c10.size ] = "event_carrier_gas_callout_05";
}

// Namespace virgo_vo
// Params 2
// Checksum 0x40edb86f, Offset: 0x25bf
// Size: 0x54
function br_circle_callout( delay, alias )
{
    level endon( #"game_ended" );
    level endon( #"hash_4c3ae759ed22e567" );
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    if ( isarray( alias ) )
    {
        alias = utility::array_random( alias );
    }
    
    level thread function_27ffcc2318635693( undefined, alias );
}

// Namespace virgo_vo
// Params 1
// Checksum 0x33a27042, Offset: 0x261b
// Size: 0x23
function function_967331a8ba62048f( delay )
{
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    level thread function_27ffcc2318635693( undefined, "event_la_freeway_br_circle_2" );
}

// Namespace virgo_vo
// Params 1
// Checksum 0x33a27042, Offset: 0x2646
// Size: 0x23
function function_967330a8ba62025c( delay )
{
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    level thread function_27ffcc2318635693( undefined, "event_la_freeway_br_circle_3" );
}

// Namespace virgo_vo
// Params 4
// Checksum 0x17eb273, Offset: 0x2671
// Size: 0x7e
function function_27ffcc2318635693( flag_name, alias, done_flag, delay )
{
    level endon( #"game_ended" );
    
    if ( isdefined( flag_name ) )
    {
        level utility::flag_wait( flag_name );
    }
    
    if ( isarray( alias ) )
    {
        alias = utility::array_random( alias );
    }
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    if ( isdefined( alias ) )
    {
        overlord::function_be2d6dc71f97faa6( alias );
    }
    
    if ( isdefined( done_flag ) )
    {
        level utility::flag_set( done_flag );
    }
}

// Namespace virgo_vo
// Params 4
// Checksum 0x6f391086, Offset: 0x26f7
// Size: 0x6b
function function_ec5e0cb61c90b6be( flag_name, alias, done_flag, delay )
{
    level endon( #"game_ended" );
    
    if ( isdefined( flag_name ) )
    {
        level utility::flag_wait( flag_name );
    }
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    if ( isdefined( alias ) )
    {
        overlord::playconversation( alias );
    }
    
    if ( isdefined( done_flag ) )
    {
        level utility::flag_set( done_flag );
    }
}

// Namespace virgo_vo
// Params 4
// Checksum 0x8030302f, Offset: 0x276a
// Size: 0xd9
function function_f16db5ee89b4371d( var_fb271790770b79a9, var_60145a13ac4a9b00, var_9ac2a9920107bedc = 30, var_301dec880c0f9e02 = 20 )
{
    level endon( #"game_ended" );
    
    if ( level utility::flag( "flag_japan_echo_assembled" ) )
    {
        return;
    }
    
    function_27ffcc2318635693( undefined, var_60145a13ac4a9b00[ 0 ] );
    
    if ( level utility::flag( "flag_japan_echo_assembled" ) )
    {
        return;
    }
    
    function_27ffcc2318635693( undefined, var_60145a13ac4a9b00[ 1 ] );
    
    if ( level utility::flag( "flag_japan_echo_assembled" ) )
    {
        return;
    }
    
    i = 0;
    
    while ( !level utility::flag( var_fb271790770b79a9 ) )
    {
        wait randomfloatrange( var_301dec880c0f9e02 + i, var_9ac2a9920107bedc + i );
        
        if ( !level utility::flag( var_fb271790770b79a9 ) )
        {
            function_27ffcc2318635693( undefined, var_60145a13ac4a9b00[ i % var_60145a13ac4a9b00.size ] );
            i += 1;
        }
    }
}

// Namespace virgo_vo
// Params 0
// Checksum 0xd754b887, Offset: 0x284b
// Size: 0x12
function function_3b5c92445b52357e()
{
    overlord::function_e155a19c69aed191( level.players );
}

