// scripts\mp\music_and_dialog.gsc  (hash_37397e0b9ca7c1d8.gscc) (size: 38446 Bytes / 0x962e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9c5d8b3e (2623376190)
// size ...... 38446 (0x962e)
// includes .. 9   (offset: 0x80c2)
// strings ... 364 (offset: 0x810a)
// dev strs .. 1   (offset: 0x9622)
// exports ... 52  (offset: 0x688a)
// cseg ...... 0x2272 + 0x4618 (0x688a)
// imports ... 84  (offset: 0x70aa)
// animtree1 . 0   (offset: 0x962e)
// animtree2 . 0   (offset: 0x962e)
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\gamescore;

#namespace music_and_dialog;

// Namespace music_and_dialog
// Params 0
// Checksum 0x67dd4c1b, Offset: 0x2290
// Size: 0x10
function init()
{
    init_music();
    function_676f55eabe22905();
}

// Namespace music_and_dialog
// Params 0
// Checksum 0x9d050130, Offset: 0x22a8
// Size: 0x15f
function init_music()
{
    audio_utility::setmusicset( "axis_used_nuke", "mus_fd_nuke_fired" );
    audio_utility::setmusicset( "axis_hit_by_nuke", "mus_fd_nuke_hit" );
    trials_loss = [ "mp_round_lose_playlist" ];
    audio_utility::setmusicset( "trials_loss", trials_loss );
    trials_win_low = [ "mp_round_win_playlist" ];
    audio_utility::setmusicset( "trials_win_low", trials_win_low );
    trials_win_mid = [ "mp_round_win_playlist" ];
    audio_utility::setmusicset( "trials_win_mid", trials_win_mid );
    trials_win_high = [ "mp_round_win_playlist" ];
    audio_utility::setmusicset( "trials_win_high", trials_win_high );
    infected = [ "infected_01", "infected_02", "infected_03", "infected_04", "infected_05" ];
    audio_utility::setmusicset( "infected", infected );
    ko_carry_music = [ "mp_hp_new_playlist", "mp_hp_captured_playlist" ];
    audio_utility::setmusicset( "ko_carry_music", ko_carry_music );
    prisoner_carry_music = [ "mp_prisoner_loop_1", "mp_prisoner_loop_2" ];
    audio_utility::setmusicset( "prisoner_carry_music", prisoner_carry_music );
    init_music_br();
    init_music_dmz();
    function_30ef73178214a066();
}

// Namespace music_and_dialog
// Params 0
// Checksum 0x9d8c5b40, Offset: 0x240f
// Size: 0x5ce
function init_music_br()
{
    if ( !isbrgamemode() )
    {
        return;
    }
    
    br_null = [ "" ];
    br_lobby_intro = [ "" ];
    audio_utility::setmusicset( "br_lobby_intro", br_null );
    br_lobby_outro = [ "mx_mp_br_prelobby_outro" ];
    audio_utility::setmusicset( "br_lobby_outro", br_null );
    br_infil_intro = [ "mx_mp_br_infil_1" ];
    audio_utility::setmusicset( "br_infil_intro", br_null );
    br_plane_jump = [ "" ];
    audio_utility::setmusicset( "br_plane_jump", br_null );
    br_plane_jump_parachute = [ "" ];
    audio_utility::setmusicset( "br_plane_jump_parachute", br_null );
    br_gulag_intro = [ "mx_mp_br_gulag_intro_1" ];
    audio_utility::setmusicset( "br_gulag_intro", br_null );
    br_gulag_jailer = [ "" ];
    audio_utility::setmusicset( "br_gulag_jailer", br_null );
    br_gulag_lose = [ "mx_mp_br_gulag_lose" ];
    audio_utility::setmusicset( "br_gulag_lose", br_null );
    br_gulag_win = [ "mx_mp_br_gulag_win" ];
    audio_utility::setmusicset( "br_gulag_win", br_null );
    br_ring_low = [ "mx_mp_br_circle_close_low_1", "mx_mp_br_circle_close_low_2", "mx_mp_br_circle_close_low_3", "mx_mp_br_circle_close_low_4" ];
    audio_utility::setmusicset( "br_ring_low", br_null );
    br_ring_med = [ "mx_mp_br_circle_close_med_1", "mx_mp_br_circle_close_med_2", "mx_mp_br_circle_close_med_3", "mx_mp_br_circle_close_med_4" ];
    audio_utility::setmusicset( "br_ring_med", br_null );
    br_ring_high = [ "mx_mp_br_circle_close_high_1", "mx_mp_br_circle_close_high_2", "mx_mp_br_circle_close_high_3", "mx_mp_br_circle_close_high_4" ];
    audio_utility::setmusicset( "br_ring_high", br_null );
    br_ring_final = [ "mx_mp_br_circle_close_final_1", "mx_mp_br_circle_close_final_2" ];
    audio_utility::setmusicset( "br_ring_final", br_null );
    br_exfil_intro1 = [ "mx_mp_br_exfil1" ];
    audio_utility::setmusicset( "br_exfil_intro1", br_null );
    br_exfil_intro2 = [ "mx_mp_br_exfil1" ];
    audio_utility::setmusicset( "br_exfil_intro2", br_null );
    br_exfil_intro3 = [ "mx_mp_br_exfil1" ];
    audio_utility::setmusicset( "br_exfil_intro3", br_null );
    br_exfil_intro4 = [ "mx_mp_br_exfil1" ];
    audio_utility::setmusicset( "br_exfil_intro4", br_null );
    br_exfil_intro5 = [ "mx_mp_br_exfil1" ];
    audio_utility::setmusicset( "br_exfil_intro5", br_null );
    br_exfil_intro6 = [ "mx_mp_br_exfil1" ];
    audio_utility::setmusicset( "br_exfil_intro6", br_null );
    br_exfil_intro7 = [ "mx_mp_br_exfil1" ];
    audio_utility::setmusicset( "br_exfil_intro7", br_null );
    br_secondary_exfil = [ "mx_mp_br_sv_exfil_loop" ];
    audio_utility::setmusicset( "br_secondary_exfil", br_null );
    br_secondary_exfil_aborted = [ "mx_mp_br_sv_exfil_abort" ];
    audio_utility::setmusicset( "br_secondary_exfil_aborted", br_null );
    br_secondary_exfil_success = [ "mx_mp_br_sv_exfil_success" ];
    audio_utility::setmusicset( "br_secondary_exfil_success", br_null );
    br_cq_element = [ "mx_mp_br_cq_elementfound_1", "mx_mp_br_cq_elementfound_2", "mx_mp_br_cq_elementfound_3", "mx_mp_br_cq_elementfound_7" ];
    audio_utility::setmusicset( "br_cq_element", br_null );
    br_cq_bomb_armed = [ "mx_mp_br_cq_bombarmed_1", "mx_mp_br_cq_bombarmed_2", "mx_mp_br_cq_bombarmed_3", "mx_mp_br_cq_bombarmed_4", "mx_mp_br_cq_bombarmed_5" ];
    audio_utility::setmusicset( "br_cq_bomb_armed", br_null );
    br_cq_ending_flyby = [ "mx_mp_br_cq_airplaneoneshot_1" ];
    audio_utility::setmusicset( "br_cq_ending_flyby", br_null );
    br_cq_exfil = [ "mx_mp_br_cq_exfil_1" ];
    audio_utility::setmusicset( "br_cq_exfil", br_null );
    plunder_tenpercent = [ "br_plunder_tenpercent_1", "br_plunder_tenpercent_2" ];
    audio_utility::setmusicset( "plunder_tenpercent", plunder_tenpercent );
    plunder_thirtypercent = [ "br_plunder_thirtypercent_1", "br_plunder_thirtypercent_2" ];
    audio_utility::setmusicset( "plunder_thirtypercent", plunder_thirtypercent );
    plunder_fiftypercent = [ "br_plunder_fiftypercent_1", "br_plunder_fiftypercent_2", "br_plunder_fiftypercent_3" ];
    audio_utility::setmusicset( "plunder_fiftypercent", plunder_fiftypercent );
    plunder_seventyfivepercent = [ "br_plunder_seventyfivepercent_1", "br_plunder_seventyfivepercent_2", "br_plunder_seventyfivepercent_3" ];
    audio_utility::setmusicset( "plunder_seventyfivepercent", plunder_seventyfivepercent );
    plunder_ninetypercent = [ "br_plunder_ninetypercent_1", "br_plunder_ninetypercent_2", "br_plunder_ninetypercent_3" ];
    audio_utility::setmusicset( "plunder_ninetypercent", plunder_ninetypercent );
    plunder_bonustime_long = [ "br_plunder_bonustime_long" ];
    audio_utility::setmusicset( "plunder_bonustime_long", plunder_bonustime_long );
    zc_zone_streak = [ "mx_mp_br_delta_zonecontrol_loop1", "mx_mp_br_delta_zonecontrol_loop2", "mx_mp_br_delta_zonecontrol_loop3" ];
    audio_utility::setmusicset( "zc_zone_streak_main", zc_zone_streak );
    
    if ( utility::issharedfuncdefined( #"music_and_dialog", #"hash_85cab1568f5ee175" ) )
    {
        [[ utility::getsharedfunc( #"music_and_dialog", #"hash_85cab1568f5ee175" ) ]]();
    }
}

// Namespace music_and_dialog
// Params 0
// Checksum 0xe22e6708, Offset: 0x29e5
// Size: 0x5e0
function init_music_dmz()
{
    var_4b04f83f2691708b = game_utility::getgametype() == "dmz";
    
    if ( !var_4b04f83f2691708b )
    {
        return;
    }
    
    dmz_infil = [ "iw9_mp_dmz_infil1", "iw9_mp_dmz_infil2", "iw9_mp_dmz_infil3", "iw9_mp_dmz_infil4", "iw9_mp_dmz_infil5" ];
    audio_utility::setmusicset( "dmz_infil", dmz_infil );
    dmz_activity_start = [ "iw9_mp_dmz_activity_start" ];
    audio_utility::setmusicset( "dmz_activity_start", dmz_activity_start );
    dmz_activity_tension = [ "iw9_mp_dmz_activity_tension" ];
    audio_utility::setmusicset( "dmz_activity_tension", dmz_activity_tension );
    dmz_activity_action = [ "iw9_mp_dmz_activity_action" ];
    audio_utility::setmusicset( "dmz_activity_action", dmz_activity_action );
    dmz_activity_win = [ "iw9_mp_dmz_activity_won" ];
    audio_utility::setmusicset( "dmz_activity_win", dmz_activity_win );
    dmz_activity_lose = [ "iw9_mp_dmz_activity_lose" ];
    audio_utility::setmusicset( "dmz_activity_lose", dmz_activity_lose );
    dmz_exfil_start = [ "iw9_mp_dmz_exfil1", "iw9_mp_dmz_exfil2" ];
    audio_utility::setmusicset( "dmz_exfil_start", dmz_exfil_start );
    dmz_exfil_manual = [ "iw9_mp_dmz_exfil_manual" ];
    audio_utility::setmusicset( "dmz_exfil_manual", dmz_exfil_manual );
    dmz_exfil_end = [ "" ];
    audio_utility::setmusicset( "dmz_exfil_end", dmz_exfil_end );
    dmz_exfil_abort = [ "iw9_mp_dmz_exfil_abort" ];
    audio_utility::setmusicset( "dmz_exfil_abort", dmz_exfil_abort );
    dmz_stronghold_unlock = [ "dmz_stronghold_unlock" ];
    audio_utility::setmusicset( "dmz_stronghold_unlock", dmz_stronghold_unlock );
    dmz_elimination_start = [ "dmz_elimination_accept" ];
    audio_utility::setmusicset( "dmz_elimination_start", dmz_elimination_start );
    dmz_elimination_approach = [ "dmz_elimination_approach" ];
    audio_utility::setmusicset( "dmz_elimination_approach", dmz_elimination_approach );
    dmz_elimination_win = [ "dmz_elimination_kill" ];
    audio_utility::setmusicset( "dmz_elimination_win", dmz_elimination_win );
    dmz_geigersearch_pickups = [ "dmz_geigersearch_pickups" ];
    audio_utility::setmusicset( "dmz_geigersearch_pickups", dmz_geigersearch_pickups );
    dmz_hostage_start = [ "dmz_fortress_hostage_contract" ];
    audio_utility::setmusicset( "dmz_hostage_start", dmz_hostage_start );
    dmz_hostage_approach = [ "dmz_fortress_hostage_approach" ];
    audio_utility::setmusicset( "dmz_hostage_approach", dmz_hostage_approach );
    dmz_hostage_breach = [ "dmz_stronghold_unlock" ];
    audio_utility::setmusicset( "dmz_hostage_breach", dmz_hostage_breach );
    dmz_hostage_rescue = [ "dmz_fortress_hostage_rescue" ];
    audio_utility::setmusicset( "dmz_hostage_rescue", dmz_hostage_rescue );
    dmz_hostage_rescue_failed = [ "dmz_fortress_hostage_rescuefailed" ];
    audio_utility::setmusicset( "dmz_hostage_rescue_failed", dmz_hostage_rescue_failed );
    dmz_trap_start = [ "dmz_trap_assigned" ];
    audio_utility::setmusicset( "dmz_trap_start", dmz_trap_start );
    dmz_trap_approach = [ "dmz_trap_approach" ];
    audio_utility::setmusicset( "dmz_trap_approach", dmz_trap_approach );
    dmz_trap_drill = [ "dmz_trap_drill" ];
    audio_utility::setmusicset( "dmz_trap_drill", dmz_trap_drill );
    dmz_train_safe_drill = [ "mx_mp_dmz_safecracker_train_loop" ];
    audio_utility::setmusicset( "dmz_train_safe_drill", dmz_train_safe_drill );
    
    if ( level.mapname == "mp_bio_lab" || level.mapname == "mp_biobunker" )
    {
        dmz_infil = [ "dmz_stronghold_unlock" ];
        audio_utility::setmusicset( "dmz_infil", dmz_infil );
    }
    
    if ( game_utility::function_238d71fc76232bef() )
    {
        dmz_infil = [ "mx_mp_dmz_s2_infil1", "mx_mp_dmz_s2_infil2" ];
        audio_utility::setmusicset( "dmz_infil", dmz_infil );
        dmz_activity_start = [ "mx_mp_dmz_s2_activity_start" ];
        audio_utility::setmusicset( "dmz_activity_start", dmz_activity_start );
        dmz_activity_tension = [ "mx_mp_dmz_s2_activity_tension" ];
        audio_utility::setmusicset( "dmz_activity_tension", dmz_activity_tension );
        dmz_activity_action = [ "mx_mp_dmz_s2_activity_action" ];
        audio_utility::setmusicset( "dmz_activity_action", dmz_activity_action );
        dmz_activity_win = [ "mx_mp_dmz_s2_activity_win" ];
        audio_utility::setmusicset( "dmz_activity_win", dmz_activity_win );
        dmz_activity_lose = [ "mx_mp_dmz_s2_activity_lose" ];
        audio_utility::setmusicset( "dmz_activity_lose", dmz_activity_lose );
        dmz_exfil_start = [ "mx_mp_dmz_s2_exfil1", "mx_mp_dmz_s2_exfil2" ];
        audio_utility::setmusicset( "dmz_exfil_start", dmz_exfil_start );
        dmz_stronghold_unlock = [ "dmz_stronghold_unlock" ];
        audio_utility::setmusicset( "dmz_stronghold_unlock", dmz_stronghold_unlock );
        dmz_elimination_start = [ "mx_mp_dmz_s2_activity_start" ];
        audio_utility::setmusicset( "dmz_elimination_start", dmz_activity_start );
        dmz_elimination_approach = [ "mx_mp_dmz_s2_activity_action_loop2" ];
        audio_utility::setmusicset( "dmz_elimination_approach", dmz_elimination_approach );
        dmz_elimination_win = [ "" ];
        audio_utility::setmusicset( "dmz_elimination_win", dmz_elimination_win );
        dmz_geigersearch_pickups = [ "mx_mp_dmz_s2_activity_pickups" ];
        audio_utility::setmusicset( "dmz_geigersearch_pickups", dmz_geigersearch_pickups );
        dmz_hostage_start = [ "mx_mp_dmz_s2_activity_start" ];
        audio_utility::setmusicset( "dmz_hostage_start", dmz_hostage_start );
        dmz_hostage_approach = [ "mx_mp_dmz_s2_activity_tension" ];
        audio_utility::setmusicset( "dmz_hostage_approach", dmz_hostage_approach );
        dmz_hostage_breach = [ "dmz_stronghold_unlock" ];
        audio_utility::setmusicset( "dmz_hostage_breach", dmz_hostage_breach );
        dmz_hostage_rescue = [ "mx_mp_dmz_s2_activity_action_loop3" ];
        audio_utility::setmusicset( "dmz_hostage_rescue", dmz_hostage_rescue );
        dmz_hostage_rescue_failed = [ "mx_mp_dmz_s2_activity_lose" ];
        audio_utility::setmusicset( "dmz_hostage_rescue_failed", dmz_hostage_rescue_failed );
        dmz_trap_start = [ "mx_mp_dmz_s2_activity_start" ];
        audio_utility::setmusicset( "dmz_trap_start", dmz_trap_start );
        dmz_trap_approach = [ "mx_mp_dmz_s2_activity_tension" ];
        audio_utility::setmusicset( "dmz_trap_approach", dmz_trap_approach );
        dmz_trap_drill = [ "mx_mp_dmz_s2_activity_action_loop2" ];
        audio_utility::setmusicset( "dmz_trap_drill", dmz_trap_drill );
    }
}

// Namespace music_and_dialog
// Params 0
// Checksum 0xa1ec0eaf, Offset: 0x2fcd
// Size: 0x573
function function_30ef73178214a066()
{
    br_infil_intro_classic = [ "mx_mp_br_infil_1_classic" ];
    audio_utility::setmusicset( "br_infil_intro_classic", br_infil_intro_classic );
    br_gulag_lose_classic = [ "mx_mp_br_gulag_lose_classic" ];
    audio_utility::setmusicset( "br_gulag_lose_classic", br_gulag_lose_classic );
    br_gulag_win_classic = [ "mx_mp_br_gulag_win_classic" ];
    audio_utility::setmusicset( "br_gulag_win_classic", br_gulag_win_classic );
    br_ring_low_classic = [ "mx_mp_br_circle_close_low_1_classic", "mx_mp_br_circle_close_low_2_classic" ];
    audio_utility::setmusicset( "br_ring_low_classic", br_ring_low_classic );
    br_ring_med_classic = [ "mx_mp_br_circle_close_med_1_classic", "mx_mp_br_circle_close_med_2_classic" ];
    audio_utility::setmusicset( "br_ring_med_classic", br_ring_med_classic );
    br_ring_high_classic = [ "mx_mp_br_circle_close_high_1_classic", "mx_mp_br_circle_close_high_2_classic" ];
    audio_utility::setmusicset( "br_ring_high_classic", br_ring_high_classic );
    br_ring_final_classic = [ "mx_mp_br_circle_close_final_loop_1_classic", "mx_mp_br_circle_close_final_loop_2_classic" ];
    audio_utility::setmusicset( "br_ring_final_classic", br_ring_final_classic );
    br_exfil_intro1_classic = [ "mx_mp_br_exfil1_classic" ];
    audio_utility::setmusicset( "br_exfil_intro1_classic", br_exfil_intro1_classic );
    br_exfil_intro2_classic = [ "mx_mp_br_exfil2_classic" ];
    audio_utility::setmusicset( "br_exfil_intro2_classic", br_exfil_intro2_classic );
    br_exfil_intro3_classic = [ "mx_mp_br_exfil3_classic" ];
    audio_utility::setmusicset( "br_exfil_intro3_classic", br_exfil_intro3_classic );
    br_exfil_intro4_classic = [ "mx_mp_br_exfil4_classic" ];
    audio_utility::setmusicset( "br_exfil_intro4_classic", br_exfil_intro4_classic );
    br_exfil_intro5_classic = [ "mx_mp_br_exfil5_classic" ];
    audio_utility::setmusicset( "br_exfil_intro5_classic", br_exfil_intro5_classic );
    br_exfil_intro6_classic = [ "mx_mp_br_exfil6_classic" ];
    audio_utility::setmusicset( "br_exfil_intro6_classic", br_exfil_intro6_classic );
    br_exfil_intro7_classic = [ "mx_mp_br_exfil6_classic" ];
    audio_utility::setmusicset( "br_exfil_intro7_classic", br_exfil_intro7_classic );
    br_cq_element_classic = [ "mx_mp_br_cq_elementfound_1_classic", "mx_mp_br_cq_elementfound_2_classic", "mx_mp_br_cq_elementfound_3_classic" ];
    audio_utility::setmusicset( "br_cq_element_classic", br_cq_element_classic );
    br_cq_bomb_armed_classic = [ "mx_mp_br_cq_bombarmed_1_classic" ];
    audio_utility::setmusicset( "br_cq_bomb_armed_classic", br_cq_bomb_armed_classic );
    dmz_infil_classic = [ "iw9_mp_dmz_infil1_classic", "iw9_mp_dmz_infil2_classic", "iw9_mp_dmz_infil3_classic", "iw9_mp_dmz_infil4_classic", "iw9_mp_dmz_infil5_classic" ];
    audio_utility::setmusicset( "dmz_infil_classic", dmz_infil_classic );
    dmz_activity_start_classic = [ "iw9_mp_dmz_activity_start_classic" ];
    audio_utility::setmusicset( "dmz_activity_start_classic", dmz_activity_start_classic );
    dmz_activity_tension_classic = [ "iw9_mp_dmz_activity_tension_classic" ];
    audio_utility::setmusicset( "dmz_activity_tension_classic", dmz_activity_tension_classic );
    dmz_activity_action_classic = [ "iw9_mp_dmz_activity_action_classic" ];
    audio_utility::setmusicset( "dmz_activity_action_classic", dmz_activity_action_classic );
    dmz_activity_win_classic = [ "iw9_mp_dmz_activity_won_classic" ];
    audio_utility::setmusicset( "dmz_activity_win_classic", dmz_activity_win_classic );
    dmz_activity_lose_classic = [ "iw9_mp_dmz_activity_lose_classic" ];
    audio_utility::setmusicset( "dmz_activity_lose_classic", dmz_activity_lose_classic );
    dmz_exfil_start_classic = [ "iw9_mp_dmz_exfil1_classic", "iw9_mp_dmz_exfil2_classic" ];
    audio_utility::setmusicset( "dmz_exfil_start_classic", dmz_exfil_start_classic );
    dmz_stronghold_unlock_classic = [ "dmz_stronghold_unlock_classic" ];
    audio_utility::setmusicset( "dmz_stronghold_unlock_classic", dmz_stronghold_unlock_classic );
    dmz_elimination_start_classic = [ "dmz_elimination_accept_classic" ];
    audio_utility::setmusicset( "dmz_elimination_start_classic", dmz_elimination_start_classic );
    dmz_elimination_approach_classic = [ "dmz_elimination_approach_classic" ];
    audio_utility::setmusicset( "dmz_elimination_approach_classic", dmz_elimination_approach_classic );
    dmz_elimination_win_classic = [ "dmz_elimination_kill_classic" ];
    audio_utility::setmusicset( "dmz_elimination_win_classic", dmz_elimination_win_classic );
    dmz_geigersearch_pickups_classic = [ "dmz_geigersearch_pickups_classic" ];
    audio_utility::setmusicset( "dmz_geigersearch_pickups_classic", dmz_geigersearch_pickups_classic );
    dmz_hostage_start_classic = [ "dmz_fortress_hostage_contract_classic" ];
    audio_utility::setmusicset( "dmz_hostage_start_classic", dmz_hostage_start_classic );
    dmz_hostage_approach_classic = [ "dmz_fortress_hostage_approach_classic" ];
    audio_utility::setmusicset( "dmz_hostage_approach_classic", dmz_hostage_approach_classic );
    dmz_hostage_breach_classic = [ "dmz_stronghold_unlock_classic" ];
    audio_utility::setmusicset( "dmz_hostage_breach_classic", dmz_hostage_breach_classic );
    dmz_hostage_rescue_classic = [ "dmz_fortress_hostage_rescue_classic" ];
    audio_utility::setmusicset( "dmz_hostage_rescue_classic", dmz_hostage_rescue_classic );
    dmz_hostage_rescue_failed_classic = [ "dmz_fortress_hostage_rescuefailed_classic" ];
    audio_utility::setmusicset( "dmz_hostage_rescue_failed_classic", dmz_hostage_rescue_failed_classic );
    dmz_trap_start_classic = [ "dmz_trap_assigned_classic" ];
    audio_utility::setmusicset( "dmz_trap_start_classic", dmz_trap_start_classic );
    dmz_trap_approach_classic = [ "dmz_trap_approach_classic" ];
    audio_utility::setmusicset( "dmz_trap_approach_classic", dmz_trap_approach_classic );
    dmz_trap_drill_classic = [ "dmz_trap_drill_classic" ];
    audio_utility::setmusicset( "dmz_trap_drill_classic", dmz_trap_drill_classic );
    dmz_train_safe_drill_classic = [ "mx_mp_dmz_safecracker_train_loop" ];
    audio_utility::setmusicset( "dmz_train_safe_drill_classic", dmz_train_safe_drill_classic );
    zc_zone_streak_classic = [ "zc_points_streak_classic" ];
    audio_utility::setmusicset( "zc_zone_streak_main_classic", zc_zone_streak_classic );
}

// Namespace music_and_dialog
// Params 0
// Checksum 0x25f85f90, Offset: 0x3548
// Size: 0x27
function init_mp_musicbank()
{
    self endon( #"disconnect" );
    
    if ( !isbrgamemode() )
    {
        self.var_3d4f0a3ba4fe5c90 = [];
        thread function_60ac6296939041e1();
    }
}

// Namespace music_and_dialog
// Params 0
// Checksum 0x390eef92, Offset: 0x3577
// Size: 0x137
function function_60ac6296939041e1()
{
    if ( getdvarint( @"current_season" ) == 3 && self.musicpack != 1 )
    {
        function_4b0e3b325692d17c( "mp_season03", "allies" );
        function_4b0e3b325692d17c( "mp_season03", "axis" );
        
        if ( game_utility::getgametype() == "xfire" )
        {
            function_4b0e3b325692d17c( "mp_season03", "team_three" );
        }
        
        return;
    }
    
    alliesfaction = teams::getteamvoiceinfix( "allies" );
    axisfaction = teams::getteamvoiceinfix( "axis" );
    
    if ( game_utility::getgametype() == "xfire" )
    {
        team_threefaction = teams::getteamvoiceinfix( "team_three" );
        function_b8cb1eebc0ef382( alliesfaction, "allies" );
        function_b8cb1eebc0ef382( axisfaction, "axis" );
        function_b8cb1eebc0ef382( team_threefaction, "team_three" );
        return;
    }
    
    if ( game_utility::getgametype() == "koth_horde" )
    {
        function_4b0e3b325692d17c( "mp_mode_hordepoint", "allies" );
        function_4b0e3b325692d17c( "mp_mode_hordepoint", "axis" );
        return;
    }
    
    function_b8cb1eebc0ef382( alliesfaction, "allies" );
    function_b8cb1eebc0ef382( axisfaction, "axis" );
}

// Namespace music_and_dialog
// Params 2
// Checksum 0x22846800, Offset: 0x36b6
// Size: 0x1cb
function function_b8cb1eebc0ef382( factionname, teamname )
{
    if ( self.musicpack == 1 )
    {
        switch ( factionname )
        {
            case #"hash_af17f86d59bb3d35":
                function_4b0e3b325692d17c( "mp_faction_tf141_classic", teamname );
                break;
            case #"hash_20abb6900079e8a3":
                function_4b0e3b325692d17c( "mp_faction_rangers_classic", teamname );
                break;
            case #"hash_b4f27b89f5a78a00":
                function_4b0e3b325692d17c( "mp_faction_navyseals_classic", teamname );
                break;
            case #"hash_d73ed93ff1b09b71":
                function_4b0e3b325692d17c( "mp_faction_opfor_classic", teamname );
                break;
            case #"hash_521188a1f4fac07":
                function_4b0e3b325692d17c( "mp_faction_spetsnaz_classic", teamname );
                break;
            case #"hash_bfb1c034c59a88dc":
                function_4b0e3b325692d17c( "mp_faction_militia_classic", teamname );
                break;
            default:
                function_4b0e3b325692d17c( "mp_default", teamname );
                break;
        }
        
        return;
    }
    
    switch ( factionname )
    {
        case #"hash_af17f86d59bb3d35":
            function_4b0e3b325692d17c( "mp_faction_tf141", teamname );
            break;
        case #"hash_20abb6900079e8a3":
            function_4b0e3b325692d17c( "mp_faction_rangers", teamname );
            break;
        case #"hash_b4f27b89f5a78a00":
            function_4b0e3b325692d17c( "mp_faction_navyseals", teamname );
            break;
        case #"hash_d73ed93ff1b09b71":
            function_4b0e3b325692d17c( "mp_faction_opfor", teamname );
            break;
        case #"hash_521188a1f4fac07":
            function_4b0e3b325692d17c( "mp_faction_spetsnaz", teamname );
            break;
        case #"hash_bfb1c034c59a88dc":
            function_4b0e3b325692d17c( "mp_faction_militia", teamname );
            break;
        default:
            function_4b0e3b325692d17c( "mp_default", teamname );
            break;
    }
}

// Namespace music_and_dialog
// Params 3
// Checksum 0xc8b407b7, Offset: 0x3889
// Size: 0xc1
function function_4b0e3b325692d17c( str_musicbank, teamname, var_4e05935674a0d30a )
{
    if ( isdefined( getscriptbundle( "musicbank:" + str_musicbank ) ) )
    {
        if ( isdefined( teamname ) )
        {
            self.var_3d4f0a3ba4fe5c90[ "musicbank_" + teamname ] = str_musicbank;
            audio_utility::function_23f0ab01b3a03ad1( "musicbank", str_musicbank, getscriptbundle( "musicbank:" + str_musicbank ) );
        }
        else
        {
            self.var_3d4f0a3ba4fe5c90[ "musicbank" ] = str_musicbank;
            audio_utility::function_23f0ab01b3a03ad1( "musicbank", str_musicbank, getscriptbundle( "musicbank:" + str_musicbank ) );
        }
        
        return;
    }
    
    self.var_3d4f0a3ba4fe5c90[ "musicbank" ] = str_musicbank;
    audio_utility::function_23f0ab01b3a03ad1( "musicbank", str_musicbank, getscriptbundle( "musicbank:" + str_musicbank ) );
}

// Namespace music_and_dialog
// Params 1
// Checksum 0xb3b6baad, Offset: 0x3952
// Size: 0x52
function function_4f9033c0e67a1519( var_81a83c79d2f5dd53 )
{
    musicevent = function_d8fb7da7ab1b73ab( var_81a83c79d2f5dd53 );
    
    if ( isdefined( musicevent ) )
    {
        musicstate = utility::array_random( musicevent.musicstates );
        self setplayermusicstate( musicstate.statename );
    }
}

// Namespace music_and_dialog
// Params 1
// Checksum 0x41f6dabb, Offset: 0x39ac
// Size: 0x19d
function function_d8fb7da7ab1b73ab( var_81a83c79d2f5dd53 )
{
    if ( !isdefined( var_81a83c79d2f5dd53 ) || var_81a83c79d2f5dd53 == "" )
    {
        return;
    }
    
    if ( self.team == "allies" )
    {
        if ( !isdefined( self.mpmusicbank[ "musicbank_allies" ] ) )
        {
            return;
        }
        
        musicbank = audio_utility::function_72015cb5d5677cad( "musicbank", self.mpmusicbank[ "musicbank_allies" ] );
    }
    else if ( self.team == "axis" )
    {
        if ( !isdefined( self.mpmusicbank[ "musicbank_axis" ] ) )
        {
            return;
        }
        
        musicbank = audio_utility::function_72015cb5d5677cad( "musicbank", self.mpmusicbank[ "musicbank_axis" ] );
    }
    else if ( self.team == "team_three" && isdefined( self.mpmusicbank[ "musicbank_team_three" ] ) )
    {
        if ( !isdefined( self.mpmusicbank[ "musicbank_team_three" ] ) )
        {
            return;
        }
        
        musicbank = audio_utility::function_72015cb5d5677cad( "musicbank", self.mpmusicbank[ "musicbank_team_three" ] );
    }
    else
    {
        return;
    }
    
    if ( !isdefined( musicbank ) )
    {
        return;
    }
    
    foreach ( event in musicbank.musicevent )
    {
        if ( event.eventid == var_81a83c79d2f5dd53 )
        {
            return event;
        }
    }
}

// Namespace music_and_dialog
// Params 0
// Checksum 0xa78f5266, Offset: 0x3b51
// Size: 0x5f
function function_676f55eabe22905()
{
    callback::add( #"player_spawned", &onplayerspawned );
    level thread onplayerconnect();
    level thread musiccontroller();
    level thread ongameended();
    
    if ( game_utility::getgametype() == "gwai" )
    {
        setdvar( @"hash_58a078a367c02ab3", 1 );
        setdvar( @"hash_c5d765aefb9658bd", 1500 );
    }
}

// Namespace music_and_dialog
// Params 0
// Checksum 0x87f9c170, Offset: 0x3bb8
// Size: 0x8f
function onplayerconnect()
{
    for ( ;; )
    {
        level waittill( #"connected", player );
        musicpack = player getplayerdata( "common", "commonCustomization", "musicbox" );
        player.musicpack = musicpack;
        
        if ( game_utility::getgametype() == "dmz" )
        {
            player thread function_8b86bab2e449bacc();
        }
        
        player thread init_mp_musicbank();
        player thread watchhostmigration();
        player.needtoplayintro = 1;
        player setsoundsubmix( "mp_cer_prematch" );
    }
}

// Namespace music_and_dialog
// Params 1
// Checksum 0x908a14f4, Offset: 0x3c4f
// Size: 0x41
function onplayerspawned( params )
{
    setdvarifuninitialized( @"hash_61e9133b2e499a6c", 0 );
    
    if ( isai( self ) )
    {
        return;
    }
    
    if ( self.needtoplayintro )
    {
        thread dointro();
        self.needtoplayintro = undefined;
    }
}

// Namespace music_and_dialog
// Params 0
// Checksum 0xcc5ea913, Offset: 0x3c98
// Size: 0x109
function function_8b86bab2e449bacc()
{
    self endon( #"disconnect" );
    var_4b04f83f2691708b = game_utility::getgametype() == "dmz";
    isdmzinfil = getdvarint( @"hash_9c43b60485fbd92e", 0 ) == 0;
    
    if ( !var_4b04f83f2691708b )
    {
        return;
    }
    
    if ( getdvarint( @"hash_61e9133b2e499a6c" ) )
    {
        dmz_infil_classic = audio_utility::function_d4d265f3dcd0a13c( "dmz_infil_classic" );
        self setplayermusicstate( dmz_infil_classic );
    }
    else
    {
        dmz_infil = audio_utility::function_d4d265f3dcd0a13c( "dmz_infil" );
        self setplayermusicstate( dmz_infil );
    }
    
    if ( isdmzinfil )
    {
        while ( !flags::gameflag( "prematch_done" ) )
        {
            if ( level.infilcompleted || isnumber( level.matchcountdowntime ) && level.matchcountdowntime <= 3 )
            {
                break;
            }
            
            waitframe();
        }
        
        waitframe();
    }
    
    if ( isdefined( level.prematchperiod ) )
    {
        while ( !flags::gameflag( "prematch_done" ) )
        {
            waitframe();
        }
    }
    
    waittillframeend();
    self setplayermusicstate( "" );
}

// Namespace music_and_dialog
// Params 0
// Checksum 0xa04485d1, Offset: 0x3da9
// Size: 0x40
function waitcountdown()
{
    level endon( #"host_migration_begin" );
    self endon( #"disconnect" );
    
    for ( ;; )
    {
        if ( flags::gameflag( "prematch_done" ) )
        {
            self notify( #"luinotifyserver", "matchReady" );
            return;
        }
        
        wait 1;
    }
}

// Namespace music_and_dialog
// Params 0
// Checksum 0x3b25a23f, Offset: 0x3df1
// Size: 0x18a
function dointro()
{
    level endon( #"game_ended" );
    level endon( #"host_migration_begin" );
    self endon( #"disconnect" );
    var_4b04f83f2691708b = game_utility::getgametype() == "dmz";
    
    if ( var_4b04f83f2691708b )
    {
        return;
    }
    
    while ( level.ingraceperiod > 15 )
    {
        waitframe();
    }
    
    if ( !isdefined( level.infilvotiming ) && game_utility_mp::teamhasinfil( self.team ) && game[ "roundsPlayed" ] == 0 )
    {
        level.infilvotiming = 1;
    }
    
    if ( isdefined( game[ "trial" ][ "tries_remaining" ] ) && game[ "trial" ][ "tries_remaining" ] < 3 )
    {
        return;
    }
    
    if ( level.script == "mp_m_speed" )
    {
        waiting = 0;
    }
    else
    {
        waiting = !flags::gameflag( "prematch_done" ) && ( !game_utility_mp::isroundbased() || game_utility_mp::isfirstround() );
    }
    
    if ( game_utility::getgametype() == "ctf" )
    {
        thread prematch_music();
    }
    
    if ( waiting )
    {
        thread waitcountdown();
        thread prematch_music();
        self setsoundsubmix( "iw9_mp_core_prematch" );
        
        for ( ;; )
        {
            self waittill( #"luinotifyserver", result, value );
            
            if ( result == "matchReady" )
            {
                break;
            }
        }
    }
    
    self clearsoundsubmix( "iw9_mp_core_prematch", 2 );
    
    if ( level.infilvotiming )
    {
        flags::gameflagwait( "prematch_done" );
        wait 1.5;
    }
}

// Namespace music_and_dialog
// Params 1
// Checksum 0x213381fa, Offset: 0x3f83
// Size: 0xda
function function_3afb6eaa3b8e17d6( submix_override )
{
    self endon( #"disconnect" );
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( isdefined( submix_override ) )
    {
        self.submix = submix_override;
    }
    else
    {
        var_1de29f483a185a21 = [];
        var_1de29f483a185a21[ var_1de29f483a185a21.size ] = "mp_infil_mix_musicheavy";
        var_1de29f483a185a21[ var_1de29f483a185a21.size ] = "mp_infil_mix_normal";
        var_18c9fa8ddd4daeee = var_1de29f483a185a21.size;
        var_8417a1e7c9a34056 = randomint( var_18c9fa8ddd4daeee );
        self.submix = var_1de29f483a185a21[ var_8417a1e7c9a34056 ];
    }
    
    if ( isdefined( self.team ) && self.team != "spectator" )
    {
        thread function_4f9033c0e67a1519( "mp_infil" );
        self.playedinfilmusic = 1;
        wait 15;
        
        if ( isent( self ) && isplayer( self ) )
        {
            self clearclienttriggeraudiozone( 3 );
            return;
        }
        
        return;
    }
}

// Namespace music_and_dialog
// Params 0
// Checksum 0x52ee502e, Offset: 0x4065
// Size: 0x416
function prematch_music()
{
    self endon( #"disconnect" );
    
    if ( flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    level waittill( #"prematch_music" );
    
    if ( !level.splitscreen && !isdefined( self.playedinfilmusic ) || level.splitscreen && !isdefined( level.playedstartingmusic ) )
    {
        if ( !self issplitscreenplayer() || self issplitscreenplayerprimary() )
        {
            if ( isdefined( self.team ) && self.team != "spectator" && game_utility::getgametype() != "arm" && game_utility::getgametype() != "conflict" && !game_utility_mp::isroundbased() )
            {
                mapname = getdvar( @"g_mapname" );
                
                if ( mapname == "mp_gunsmith_gl" )
                {
                    self setplayermusicstate( "" );
                }
                else if ( game_utility::getgametype() == "training_course" )
                {
                    level waittill( #"prematch_over" );
                    
                    if ( self.team == "allies" )
                    {
                        if ( ismusicenabled() )
                        {
                            thread function_4f9033c0e67a1519( "mp_spawn" );
                        }
                        
                        self.nosuspensemusic = 1;
                    }
                    else
                    {
                        if ( ismusicenabled() )
                        {
                            thread function_4f9033c0e67a1519( "mp_spawn" );
                        }
                        
                        self.nosuspensemusic = 1;
                    }
                }
                else if ( game_utility::getgametype() == "ballmode" )
                {
                    if ( game[ "roundsPlayed" ] == 0 )
                    {
                        if ( self.team == "allies" )
                        {
                            if ( ismusicenabled() )
                            {
                                thread function_4f9033c0e67a1519( "mp_spawn" );
                            }
                            
                            self.nosuspensemusic = 1;
                        }
                        else
                        {
                            if ( ismusicenabled() )
                            {
                                thread function_4f9033c0e67a1519( "mp_spawn" );
                            }
                            
                            self.nosuspensemusic = 1;
                        }
                    }
                }
                else if ( self.team == "allies" )
                {
                    if ( ismusicenabled() )
                    {
                        thread function_4f9033c0e67a1519( "mp_spawn" );
                    }
                    
                    self.nosuspensemusic = 1;
                }
                else
                {
                    if ( ismusicenabled() )
                    {
                        thread function_4f9033c0e67a1519( "mp_spawn" );
                    }
                    
                    self.nosuspensemusic = 1;
                }
            }
            
            if ( game_utility_mp::isroundbased() && isdefined( game[ "roundsPlayed" ] ) && game[ "roundsPlayed" ] == 0 )
            {
                if ( self.team == "allies" )
                {
                    if ( ismusicenabled() )
                    {
                        thread function_4f9033c0e67a1519( "mp_spawn" );
                    }
                    
                    self.nosuspensemusic = 1;
                }
                else
                {
                    if ( ismusicenabled() )
                    {
                        thread function_4f9033c0e67a1519( "mp_spawn" );
                    }
                    
                    self.nosuspensemusic = 1;
                }
            }
            
            if ( game_utility::getgametype() == "ctf" && isdefined( game[ "roundsPlayed" ] ) && game[ "roundsPlayed" ] != 0 )
            {
                if ( self.team == "allies" )
                {
                    if ( ismusicenabled() )
                    {
                        thread function_4f9033c0e67a1519( "mp_spawn" );
                    }
                }
                else if ( ismusicenabled() )
                {
                    thread function_4f9033c0e67a1519( "mp_spawn" );
                }
            }
            
            if ( ( game_utility::getgametype() == "arm" || game_utility::getgametype() == "conflict" ) && !isdefined( level.playedstartingmusic ) )
            {
                if ( self.team == "allies" )
                {
                    if ( ismusicenabled() )
                    {
                        thread function_4f9033c0e67a1519( "mp_spawn" );
                    }
                    
                    self.nosuspensemusic = 1;
                }
                else
                {
                    if ( ismusicenabled() )
                    {
                        thread function_4f9033c0e67a1519( "mp_spawn" );
                    }
                    
                    self.nosuspensemusic = 1;
                }
            }
            
            if ( game_utility::getgametype() == "arena" && isdefined( game[ "roundsPlayed" ] ) && game[ "roundsPlayed" ] == 0 )
            {
                thread function_4f9033c0e67a1519( "mp_prematch_gunfight" );
            }
            
            if ( game_utility::getgametype() == "xfire" && isdefined( game[ "roundsPlayed" ] ) && game[ "roundsPlayed" ] == 0 )
            {
                thread function_4f9033c0e67a1519( "mp_prematch_gunfight" );
            }
        }
        
        if ( level.splitscreen )
        {
            level.playedstartingmusic = 1;
        }
        
        thread suspensemusic_reset( 20 );
    }
}

// Namespace music_and_dialog
// Params 0
// Checksum 0x81c72b76, Offset: 0x4483
// Size: 0x5d
function watchhostmigration()
{
    self endon( #"disconnect" );
    level endon( #"grace_period_ending" );
    
    while ( true )
    {
        level waittill( #"host_migration_begin" );
        var_4b8f91dea101926c = level.ingraceperiod;
        level waittill( #"host_migration_end" );
        
        if ( var_4b8f91dea101926c )
        {
            thread dointro();
        }
    }
}

// Namespace music_and_dialog
// Params 1
// Checksum 0x9991c07c, Offset: 0x44e8
// Size: 0x46
function dmz_activity_start( players )
{
    dmz_activity_start = audio_utility::function_d4d265f3dcd0a13c( "dmz_activity_start" );
    dmz_activity_start_classic = audio_utility::function_d4d265f3dcd0a13c( "dmz_activity_start_classic" );
    audio_utility::function_6a0ed3b9fb942369( players, dmz_activity_start, undefined, undefined, dmz_activity_start_classic );
}

// Namespace music_and_dialog
// Params 1
// Checksum 0x9329a590, Offset: 0x4536
// Size: 0x46
function dmz_activity_tension( players )
{
    dmz_activity_tension = audio_utility::function_d4d265f3dcd0a13c( "dmz_activity_tension" );
    dmz_activity_tension_classic = audio_utility::function_d4d265f3dcd0a13c( "dmz_activity_tension_classic" );
    audio_utility::function_6a0ed3b9fb942369( players, dmz_activity_tension, undefined, undefined, dmz_activity_tension_classic );
}

// Namespace music_and_dialog
// Params 1
// Checksum 0x266a4eef, Offset: 0x4584
// Size: 0x46
function function_80fd7be5e8ada7a4( players )
{
    dmz_activity_action = audio_utility::function_d4d265f3dcd0a13c( "dmz_activity_action" );
    dmz_activity_action_classic = audio_utility::function_d4d265f3dcd0a13c( "dmz_activity_action_classic" );
    audio_utility::function_6a0ed3b9fb942369( players, dmz_activity_action, undefined, undefined, dmz_activity_action_classic );
}

// Namespace music_and_dialog
// Params 1
// Checksum 0xbda48d2f, Offset: 0x45d2
// Size: 0x46
function dmz_activity_win( players )
{
    dmz_activity_win = audio_utility::function_d4d265f3dcd0a13c( "dmz_activity_win" );
    dmz_activity_win_classic = audio_utility::function_d4d265f3dcd0a13c( "dmz_activity_win_classic" );
    audio_utility::function_6a0ed3b9fb942369( players, dmz_activity_win, undefined, undefined, dmz_activity_win_classic );
}

// Namespace music_and_dialog
// Params 1
// Checksum 0xc1f02e26, Offset: 0x4620
// Size: 0x46
function dmz_activity_lose( players )
{
    dmz_activity_lose = audio_utility::function_d4d265f3dcd0a13c( "dmz_activity_lose" );
    dmz_activity_lose_classic = audio_utility::function_d4d265f3dcd0a13c( "dmz_activity_lose_classic" );
    audio_utility::function_6a0ed3b9fb942369( players, dmz_activity_lose, undefined, undefined, dmz_activity_lose_classic );
}

// Namespace music_and_dialog
// Params 0
// Checksum 0x389531fa, Offset: 0x466e
// Size: 0x36b
function ongameended()
{
    level waittill( #"hash_fd59437961aec2ea", winner );
    
    if ( !isdefined( winner ) || isdefined( level.endmusicplayed ) )
    {
        return;
    }
    
    if ( isbrgamemode() && game_utility::getgametype() != "plunder" )
    {
        return;
    }
    
    if ( !ismusicenabled() )
    {
        return;
    }
    
    if ( game_utility::getgametype() == "xfire" )
    {
        ongameended_xfire( winner );
    }
    else if ( level.teambased )
    {
        if ( level.splitscreen )
        {
            foreach ( player in level.players )
            {
                if ( player issplitscreenplayer() && !player issplitscreenplayerprimary() )
                {
                    continue;
                }
                
                player damage_effects::function_e8cba6f10a4635e9();
                
                if ( winner == player.team )
                {
                    player thread function_4f9033c0e67a1519( "mp_victory" );
                }
                else
                {
                    player thread function_4f9033c0e67a1519( "mp_defeat" );
                }
                
                player setsoundsubmix( "mp_matchend_music", 2 );
            }
        }
        else
        {
            foreach ( player in level.players )
            {
                player damage_effects::function_e8cba6f10a4635e9();
                player setsoundsubmix( "mp_matchend_music", 2 );
                
                if ( winner == player.team )
                {
                    player thread function_4f9033c0e67a1519( "mp_victory" );
                    continue;
                }
                
                player thread function_4f9033c0e67a1519( "mp_defeat" );
            }
        }
    }
    else
    {
        foreach ( player in level.players )
        {
            player damage_effects::function_e8cba6f10a4635e9();
            player setsoundsubmix( "mp_matchend_music", 2 );
            player setplayermusicstate( "" );
            
            if ( player issplitscreenplayer() && !player issplitscreenplayerprimary() )
            {
                continue;
            }
            
            if ( isstring( winner ) && ( winner == "tie" || winner == "none" ) )
            {
                continue;
            }
            
            assert( isstring( winner ) || isstring( winner.team ), "<dev string:x24>" );
            
            if ( isstring( winner ) && winner == player.team || !isstring( winner ) && isdefined( winner.team ) && winner.team == player.team )
            {
                player thread function_4f9033c0e67a1519( "mp_victory" );
                continue;
            }
            
            player thread function_4f9033c0e67a1519( "mp_defeat" );
        }
    }
    
    level.endmusicplayed = 1;
}

// Namespace music_and_dialog
// Params 1
// Checksum 0x554d8deb, Offset: 0x49e1
// Size: 0xda
function ongameended_xfire( winner )
{
    foreach ( player in level.players )
    {
        if ( player issplitscreenplayer() && !player issplitscreenplayerprimary() )
        {
            continue;
        }
        
        player damage_effects::function_e8cba6f10a4635e9();
        player setsoundsubmix( "mp_matchend_music", 2 );
        
        if ( winner == player.team )
        {
            player thread function_4f9033c0e67a1519( "mp_victory" );
            continue;
        }
        
        player thread function_4f9033c0e67a1519( "mp_defeat" );
    }
}

// Namespace music_and_dialog
// Params 1
// Checksum 0x39349e46, Offset: 0x4ac3
// Size: 0xbd
function midpoint_music( winning_team )
{
    thread stopsuspensemusic();
    
    foreach ( player in level.players )
    {
        if ( winning_team == player.team )
        {
            player thread function_4f9033c0e67a1519( "mp_midpoint_winning" );
            continue;
        }
        
        player thread function_4f9033c0e67a1519( "mp_midpoint_losing" );
    }
    
    wait 25;
    thread suspensemusic();
}

// Namespace music_and_dialog
// Params 1
// Checksum 0xcdec2ff6, Offset: 0x4b88
// Size: 0xe2
function dominating_music( dominating_team )
{
    if ( level.dominating_music == 1 )
    {
        return;
    }
    
    thread stopsuspensemusic();
    
    foreach ( player in level.players )
    {
        if ( dominating_team == player.team )
        {
            player thread function_4f9033c0e67a1519( "mp_dominating" );
            continue;
        }
        
        player thread function_4f9033c0e67a1519( "mp_dominated" );
    }
    
    level.dominating_music = 1;
    wait 25;
    level.dominating_music = 0;
    thread suspensemusic();
}

// Namespace music_and_dialog
// Params 0
// Checksum 0x454bb04, Offset: 0x4c72
// Size: 0x152
function bombplanted_music()
{
    if ( level.bombtimer > 44 )
    {
        waittime = level.bombtimer - 45;
        wait waittime;
        
        foreach ( player in level.players )
        {
            player thread function_4f9033c0e67a1519( "mp_bombplant" );
        }
    }
    else if ( isdefined( level.bombtimer ) )
    {
        waittime = level.bombtimer - 30;
        
        if ( waittime < 0 )
        {
            waittime = 0;
        }
        
        wait waittime;
        
        foreach ( player in level.players )
        {
            player thread function_4f9033c0e67a1519( "mp_bombplant30" );
        }
    }
    
    level.bombplanted_music = 1;
}

// Namespace music_and_dialog
// Params 0
// Checksum 0x8f7832b8, Offset: 0x4dcc
// Size: 0x458
function musiccontroller()
{
    level endon( #"game_ended" );
    
    if ( !isdefined( level.musicenabled ) )
    {
        level.musicenabled = 1;
    }
    
    thread suspensemusic();
    level waittill( #"match_ending_soon", reason );
    assert( isdefined( reason ) );
    
    if ( level.roundlimit == 1 || game[ "roundsPlayed" ] == level.roundlimit - 1 || level.gametypebundle.scoringstrategy == #"teamscores" )
    {
        if ( !level.splitscreen )
        {
            if ( reason == "time" )
            {
                if ( level.teambased )
                {
                    if ( game[ "teamScores" ][ "allies" ] > game[ "teamScores" ][ "axis" ] )
                    {
                        if ( ismusicenabled() )
                        {
                            thread timelimitmusic( "allies" );
                        }
                    }
                    else if ( game[ "teamScores" ][ "axis" ] > game[ "teamScores" ][ "allies" ] )
                    {
                        if ( ismusicenabled() )
                        {
                            thread timelimitmusic( "axis" );
                        }
                    }
                    else if ( ismusicenabled() )
                    {
                        thread timelimitmusic( "draw" );
                    }
                }
                else if ( ismusicenabled() )
                {
                    foreach ( player in level.players )
                    {
                        player thread function_4f9033c0e67a1519( "mp_timesup_winning" );
                    }
                }
            }
            else if ( reason == "score" )
            {
                if ( level.teambased && game_utility::getgametype() != "arena" )
                {
                    if ( game[ "teamScores" ][ "allies" ] > game[ "teamScores" ][ "axis" ] )
                    {
                        if ( ismusicenabled() )
                        {
                            foreach ( player in level.players )
                            {
                                if ( player.team == "allies" )
                                {
                                    player thread function_4f9033c0e67a1519( "mp_round_winning" );
                                    continue;
                                }
                                
                                player thread function_4f9033c0e67a1519( "mp_round_losing" );
                            }
                        }
                    }
                    else if ( game[ "teamScores" ][ "axis" ] > game[ "teamScores" ][ "allies" ] )
                    {
                        if ( ismusicenabled() )
                        {
                            foreach ( player in level.players )
                            {
                                if ( player.team == "allies" )
                                {
                                    player thread function_4f9033c0e67a1519( "mp_round_losing" );
                                    continue;
                                }
                                
                                player thread function_4f9033c0e67a1519( "mp_round_winning" );
                            }
                        }
                    }
                }
                else
                {
                    winningplayer = gamescore::gethighestscoringplayer();
                    excludelist[ 0 ] = winningplayer;
                    
                    if ( ismusicenabled() )
                    {
                        foreach ( player in level.players )
                        {
                            if ( winningplayer.pers[ "team" ] == player.team )
                            {
                                player thread function_4f9033c0e67a1519( "mp_round_winning" );
                                continue;
                            }
                            
                            player thread function_4f9033c0e67a1519( "mp_round_losing" );
                        }
                    }
                }
            }
        }
        
        return;
    }
    
    if ( game_utility::getgametype() != "arena" )
    {
        clearmusicstate();
    }
}

// Namespace music_and_dialog
// Params 1
// Checksum 0xce0c2bca, Offset: 0x522c
// Size: 0xd3
function timelimitmusic( team )
{
    self endon( #"game_ended" );
    level notify( #"hash_94e235a6ed948fda" );
    
    if ( game_utility::getgametype() != "arena" )
    {
        foreach ( player in level.players )
        {
            if ( team == player.team )
            {
                player thread function_4f9033c0e67a1519( "mp_timesup_winning" );
                continue;
            }
            
            player thread function_4f9033c0e67a1519( "mp_timesup_losing" );
        }
    }
}

// Namespace music_and_dialog
// Params 0
// Checksum 0x7679f641, Offset: 0x5307
// Size: 0x87
function headquarters_newhq_music()
{
    stopsuspensemusic();
    
    foreach ( player in level.players )
    {
        player thread function_4f9033c0e67a1519( "mp_hq_new" );
    }
}

// Namespace music_and_dialog
// Params 0
// Checksum 0x7eee347, Offset: 0x5396
// Size: 0xab
function headquarters_captured_music()
{
    level endon( #"hash_b6ab8f06828835fb" );
    stopsuspensemusic();
    
    foreach ( player in level.players )
    {
        player thread function_4f9033c0e67a1519( "mp_captured" );
        level.hq_captured_music = 1;
        wait 60;
        level.hq_captured_music = 0;
    }
}

// Namespace music_and_dialog
// Params 1
// Checksum 0x64f3ee0a, Offset: 0x5449
// Size: 0xd5
function headquarters_deactivate_music( claimteam )
{
    stopsuspensemusic();
    
    if ( level.hq_captured_music )
    {
        level notify( #"hash_b6ab8f06828835fb" );
        level.hq_captured_music = 0;
        
        foreach ( player in level.players )
        {
            if ( claimteam == player.team )
            {
                player thread function_4f9033c0e67a1519( "mp_destroyed_pos" );
                continue;
            }
            
            player thread function_4f9033c0e67a1519( "mp_destroyed_neg" );
        }
    }
}

// Namespace music_and_dialog
// Params 1
// Checksum 0xdd77983c, Offset: 0x5526
// Size: 0xb3
function function_ec864b719af336e8( claimteam )
{
    stopsuspensemusic();
    
    foreach ( player in level.players )
    {
        if ( claimteam == player.team )
        {
            player thread function_4f9033c0e67a1519( "mp_destroyed_pos" );
            continue;
        }
        
        player thread function_4f9033c0e67a1519( "mp_destroyed_neg" );
    }
}

// Namespace music_and_dialog
// Params 0
// Checksum 0x816cef64, Offset: 0x55e1
// Size: 0x21
function infected_music()
{
    infected = audio_utility::function_d4d265f3dcd0a13c( "infected" );
    self setplayermusicstate( infected );
}

// Namespace music_and_dialog
// Params 1
// Checksum 0x2b10253f, Offset: 0x560a
// Size: 0x118
function suspensemusic( var_6bd46b1c763f6812 )
{
    if ( !ismusicenabled() )
    {
        return;
    }
    
    mapname = getdvar( @"g_mapname" );
    
    if ( mapname == "mp_gunsmith_gl" )
    {
        return;
    }
    
    level endon( #"game_ended" );
    level endon( #"match_ending_soon" );
    level endon( #"hash_94e235a6ed948fda" );
    
    if ( level.nosuspensemusic )
    {
        return;
    }
    
    wait 30;
    
    if ( var_6bd46b1c763f6812 )
    {
        wait 120;
    }
    
    for ( ;; )
    {
        wait randomfloatrange( 75, 120 );
        
        if ( level.nosuspensemusic )
        {
            return;
        }
        
        if ( !game[ "inLiveLobby" ] )
        {
            foreach ( player in level.players )
            {
                player thread function_4f9033c0e67a1519( "mp_suspense" );
            }
        }
    }
}

// Namespace music_and_dialog
// Params 1
// Checksum 0x6ed18050, Offset: 0x572a
// Size: 0x19
function suspensemusic_reset( waittime )
{
    wait waittime;
    self.nosuspensemusic = undefined;
}

// Namespace music_and_dialog
// Params 0
// Checksum 0x960c6550, Offset: 0x574b
// Size: 0x23
function stopsuspensemusic()
{
    level notify( #"hash_94e235a6ed948fda" );
    
    if ( level.cursuspsensetrack.size == 2 )
    {
        clearmusicstate();
    }
}

// Namespace music_and_dialog
// Params 0
// Checksum 0xc56b4445, Offset: 0x5776
// Size: 0x21
function enablemusic()
{
    if ( level.musicenabled == 0 )
    {
        thread suspensemusic();
    }
    
    level.musicenabled++;
}

// Namespace music_and_dialog
// Params 0
// Checksum 0x1c0e8bfd, Offset: 0x579f
// Size: 0x48
function disablemusic()
{
    if ( !isdefined( level.musicenabled ) )
    {
        level.musicenabled = 0;
        return;
    }
    
    if ( level.musicenabled > 0 )
    {
        level.musicenabled--;
        
        if ( level.musicenabled == 0 )
        {
            stopsuspensemusic();
        }
    }
}

// Namespace music_and_dialog
// Params 3
// Checksum 0xec115394, Offset: 0x57ef
// Size: 0x6fd
function round_end_music( winner, endreasontext, endreasontextloss )
{
    if ( isdefined( level.endmusicplayed ) )
    {
        return;
    }
    
    if ( level.halftimetype == "halftime" && level.roundlimit && game[ "roundsPlayed" ] * 2 == level.roundlimit )
    {
        setmusicstate( "mus_mp_halftime" );
        return;
    }
    
    if ( level.playovertime )
    {
        setmusicstate( "mus_mp_halftime" );
        return;
    }
    
    if ( level.halftimetype == "halftime" && !level.roundlimit )
    {
        foreach ( player in level.players )
        {
            music_pack_name = getdvar( @"hash_cbe7c358c50968ba" );
            
            if ( winner == "allies" )
            {
                if ( game_utility::getgametype() != "arena" )
                {
                    if ( player.team == "allies" )
                    {
                        if ( getdvarint( @"hash_61e9133b2e499a6c" ) && music_pack_name != "" )
                        {
                            roundwin_allies = audio_utility::function_d4d265f3dcd0a13c( "roundwin_allies_" + music_pack_name );
                            player setplayermusicstate( roundwin_allies );
                        }
                        else
                        {
                            roundwin_allies = audio_utility::function_d4d265f3dcd0a13c( "roundwin_allies" );
                            player setplayermusicstate( roundwin_allies );
                        }
                    }
                    else if ( getdvarint( @"hash_61e9133b2e499a6c" ) && music_pack_name != "" )
                    {
                        roundloss_axis = audio_utility::function_d4d265f3dcd0a13c( "roundloss_axis_" + music_pack_name );
                        player setplayermusicstate( roundloss_axis );
                    }
                    else
                    {
                        roundloss_axis = audio_utility::function_d4d265f3dcd0a13c( "roundloss_axis" );
                        player setplayermusicstate( roundloss_axis );
                    }
                }
                else if ( getdvarint( @"hash_61e9133b2e499a6c" ) && music_pack_name != "" )
                {
                    roundendmusictype = getarenaroundendmusictype();
                    gunfight_roundwin = audio_utility::function_d4d265f3dcd0a13c( "gunfight_roundwin_" + roundendmusictype + "_" + music_pack_name );
                    player setplayermusicstate( gunfight_roundwin );
                }
                else
                {
                    roundendmusictype = getarenaroundendmusictype();
                    gunfight_roundwin = audio_utility::function_d4d265f3dcd0a13c( "gunfight_roundwin_" + roundendmusictype );
                    player setplayermusicstate( gunfight_roundwin );
                }
                
                continue;
            }
            
            if ( winner == "axis" )
            {
                if ( game_utility::getgametype() != "arena" )
                {
                    if ( player.team == "allies" )
                    {
                        if ( getdvarint( @"hash_61e9133b2e499a6c" ) && music_pack_name != "" )
                        {
                            roundloss_allies = audio_utility::function_d4d265f3dcd0a13c( "roundloss_allies_" + music_pack_name );
                            player setplayermusicstate( roundloss_allies );
                        }
                        else
                        {
                            roundloss_allies = audio_utility::function_d4d265f3dcd0a13c( "roundloss_allies" );
                            player setplayermusicstate( roundloss_allies );
                        }
                    }
                    else if ( getdvarint( @"hash_61e9133b2e499a6c" ) && music_pack_name != "" )
                    {
                        roundwin_axis = audio_utility::function_d4d265f3dcd0a13c( "roundwin_axis_" + music_pack_name );
                        player setplayermusicstate( roundwin_axis );
                    }
                    else
                    {
                        roundwin_axis = audio_utility::function_d4d265f3dcd0a13c( "roundwin_axis" );
                        player setplayermusicstate( roundwin_axis );
                    }
                }
                else if ( getdvarint( @"hash_61e9133b2e499a6c" ) && music_pack_name != "" )
                {
                    roundendmusictype = getarenaroundendmusictype();
                    gunfight_roundloss = audio_utility::function_d4d265f3dcd0a13c( "gunfight_roundloss_" + roundendmusictype + "_" + music_pack_name );
                    player setplayermusicstate( gunfight_roundloss );
                }
                else
                {
                    roundendmusictype = getarenaroundendmusictype();
                    gunfight_roundloss = audio_utility::function_d4d265f3dcd0a13c( "gunfight_roundloss_" + roundendmusictype );
                    player setplayermusicstate( gunfight_roundloss );
                }
                
                continue;
            }
            
            if ( game_utility::getgametype() != "arena" )
            {
                if ( getdvarint( @"hash_61e9133b2e499a6c" ) && music_pack_name != "" )
                {
                    rounddraw_music = audio_utility::function_d4d265f3dcd0a13c( "rounddraw_" + music_pack_name );
                    player setplayermusicstate( rounddraw_music );
                }
                else
                {
                    player setplayermusicstate( "mp_round_draw_playlist" );
                }
                
                continue;
            }
            
            if ( getdvarint( @"hash_61e9133b2e499a6c" ) && music_pack_name != "" )
            {
                roundendmusictype = getarenaroundendmusictype();
                gunfight_roundwin = audio_utility::function_d4d265f3dcd0a13c( "gunfight_roundwin_" + roundendmusictype + "_" + music_pack_name );
                player setplayermusicstate( gunfight_roundwin );
                continue;
            }
            
            roundendmusictype = getarenaroundendmusictype();
            gunfight_roundwin = audio_utility::function_d4d265f3dcd0a13c( "gunfight_roundwin_" + roundendmusictype );
            player setplayermusicstate( gunfight_roundwin );
        }
        
        return;
    }
    
    if ( level.halftimetype == "halftime" && game_utility::getgametype() == "dd" && !game_utility_mp::hitroundlimit() )
    {
        foreach ( player in level.players )
        {
            music_pack_name = getdvar( @"hash_cbe7c358c50968ba" );
            
            if ( winner == "allies" )
            {
                if ( player.team == "allies" )
                {
                    if ( getdvarint( @"hash_61e9133b2e499a6c" ) && music_pack_name != "" )
                    {
                        roundwin_allies = audio_utility::function_d4d265f3dcd0a13c( "roundwin_allies_" + music_pack_name );
                        player setplayermusicstate( roundwin_allies );
                    }
                    else
                    {
                        roundwin_allies = audio_utility::function_d4d265f3dcd0a13c( "roundwin_allies" );
                        player setplayermusicstate( roundwin_allies );
                    }
                }
                else if ( getdvarint( @"hash_61e9133b2e499a6c" ) && music_pack_name != "" )
                {
                    roundloss_axis = audio_utility::function_d4d265f3dcd0a13c( "roundloss_axis_" + music_pack_name );
                    player setplayermusicstate( roundloss_axis );
                }
                else
                {
                    roundloss_axis = audio_utility::function_d4d265f3dcd0a13c( "roundloss_axis" );
                    player setplayermusicstate( roundloss_axis );
                }
                
                continue;
            }
            
            if ( winner == "axis" )
            {
                if ( player.team == "allies" )
                {
                    if ( getdvarint( @"hash_61e9133b2e499a6c" ) && music_pack_name != "" )
                    {
                        roundloss_allies = audio_utility::function_d4d265f3dcd0a13c( "roundloss_allies_" + music_pack_name );
                        player setplayermusicstate( roundloss_allies );
                    }
                    else
                    {
                        roundloss_allies = audio_utility::function_d4d265f3dcd0a13c( "roundloss_allies" );
                        player setplayermusicstate( roundloss_allies );
                    }
                }
                else if ( getdvarint( @"hash_61e9133b2e499a6c" ) && music_pack_name != "" )
                {
                    roundwin_axis = audio_utility::function_d4d265f3dcd0a13c( "roundwin_axis_" + music_pack_name );
                    player setplayermusicstate( roundwin_axis );
                }
                else
                {
                    roundwin_axis = audio_utility::function_d4d265f3dcd0a13c( "roundwin_axis" );
                    player setplayermusicstate( roundwin_axis );
                }
                
                continue;
            }
            
            if ( getdvarint( @"hash_61e9133b2e499a6c" ) && music_pack_name != "" )
            {
                rounddraw_music = audio_utility::function_d4d265f3dcd0a13c( "rounddraw_" + music_pack_name );
                player setplayermusicstate( rounddraw_music );
                continue;
            }
            
            player setplayermusicstate( "mp_round_draw_playlist" );
        }
    }
}

// Namespace music_and_dialog
// Params 1
// Checksum 0xdb28cf07, Offset: 0x5ef4
// Size: 0xe4
function round_end_music_xfire( winner )
{
    thread stopsuspensemusic();
    
    foreach ( player in level.players )
    {
        if ( winner == "tie" )
        {
            player thread function_4f9033c0e67a1519( "mp_round_draw_" + getarenaroundendmusictype() );
            continue;
        }
        
        if ( winner == player.team )
        {
            player thread function_4f9033c0e67a1519( "mp_round_win_" + getarenaroundendmusictype() );
            continue;
        }
        
        player thread function_4f9033c0e67a1519( "mp_round_loss_" + getarenaroundendmusictype() );
    }
}

// Namespace music_and_dialog
// Params 1
// Checksum 0x10983171, Offset: 0x5fe0
// Size: 0x10e
function function_37fbef08acd408ba( generic )
{
    thread stopsuspensemusic();
    
    if ( isdefined( generic ) )
    {
        foreach ( player in level.players )
        {
            player thread function_4f9033c0e67a1519( "mp_overtime" );
        }
        
        return;
    }
    
    foreach ( player in level.players )
    {
        player thread function_4f9033c0e67a1519( "mp_overtime" );
    }
}

// Namespace music_and_dialog
// Params 0
// Checksum 0xd2363e82, Offset: 0x60f6
// Size: 0x107
function getarenaroundendmusictype()
{
    musictype = "early";
    mostroundswon = 0;
    
    foreach ( entry in level.teamnamelist )
    {
        roundswon = game[ "roundsWon" ][ entry ];
        
        if ( roundswon > mostroundswon )
        {
            mostroundswon = roundswon;
        }
    }
    
    if ( mostroundswon > 0 )
    {
        perc = mostroundswon / level.winlimit;
        
        if ( perc <= 0.34 )
        {
            musictype = "early";
        }
        else if ( perc >= 0.34 && perc <= 0.67 )
        {
            musictype = "mid";
        }
        else
        {
            musictype = "late";
        }
    }
    
    return musictype;
}

// Namespace music_and_dialog
// Params 0
// Checksum 0xfaba1ab1, Offset: 0x6206
// Size: 0xd, Type: bool
function ismusicenabled()
{
    return level.musicenabled > 0;
}

// Namespace music_and_dialog
// Params 0
// Checksum 0x181fc152, Offset: 0x621c
// Size: 0x380
function function_99ad828ca6bd744a()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    stopsuspensemusic();
    
    if ( !isdefined( self.music_value ) )
    {
        self.music_value = 0;
    }
    
    if ( !isdefined( self.previous_music_value ) )
    {
        self.previous_music_value = 0;
    }
    
    if ( !isdefined( self.music_time ) )
    {
        self.music_time = 0;
    }
    
    while ( true )
    {
        music_diff = self.music_value - self.previous_music_value;
        
        if ( self.music_value >= 0 )
        {
            self.previous_music_value = self.music_value;
        }
        
        iprintln( "current music diff is " + music_diff );
        
        if ( music_diff > 0 )
        {
            if ( music_diff > 1 && music_diff < 6 )
            {
                if ( !isdefined( self.music_low ) )
                {
                    thread function_93ef6e03d957c973();
                }
            }
            else if ( music_diff >= 6 && music_diff <= 15 )
            {
                if ( !isdefined( self.music_med ) )
                {
                    thread function_82666403cb609cfb();
                }
            }
            else if ( music_diff > 15 )
            {
                if ( !isdefined( self.music_high ) )
                {
                    thread function_44001b14d8cd046f();
                }
            }
        }
        
        if ( music_diff < 0 )
        {
            if ( music_diff <= -5 && music_diff > -10 )
            {
                if ( isdefined( self.music_med ) || isdefined( self.music_high ) || isdefined( self.music_low ) )
                {
                    self setsoundsubmix( "iw9_mp_musictest_fadeout", 4 );
                    self notify( #"clear_music_low" );
                    self notify( #"clear_music_med" );
                    self notify( #"clear_music_high" );
                    self.music_low = undefined;
                    self.music_high = undefined;
                    self.music_med = undefined;
                    wait self.music_time + 10;
                    
                    if ( self.music_value >= 0 )
                    {
                        self.previous_music_value = self.music_value;
                    }
                    
                    self stoplocalsound( "mus_iw9_mpmusictest_ambient1_intro" );
                    self clearsoundsubmix( "iw9_mp_musictest_fadeout", 2 );
                }
            }
            else if ( music_diff < -10 )
            {
                if ( isdefined( self.music_med ) || isdefined( self.music_high ) )
                {
                    self playlocalsound( "mus_iw9_mpmusictest_hit1_intro" );
                }
                
                if ( isdefined( self.music_med ) || isdefined( self.music_high ) || isdefined( self.music_low ) )
                {
                    self setsoundsubmix( "iw9_mp_musictest_fadeout", 2 );
                    self notify( #"clear_music_low" );
                    self notify( #"clear_music_med" );
                    self notify( #"clear_music_high" );
                    self.music_low = undefined;
                    self.music_high = undefined;
                    self.music_med = undefined;
                    wait self.music_time + 10;
                    
                    if ( self.music_value >= 0 )
                    {
                        self.previous_music_value = self.music_value;
                    }
                    
                    self stoplocalsound( "mus_iw9_mpmusictest_ambient1_intro" );
                    self clearsoundsubmix( "iw9_mp_musictest_fadeout", 2 );
                }
            }
        }
        
        if ( self.music_value >= 0 )
        {
            self.music_value -= 0.5;
        }
        
        if ( self.music_value < 0 )
        {
            self.music_value = 0;
        }
        
        iprintln( "current music value is " + self.music_value );
        wait 2;
        
        if ( self.music_time > 0 )
        {
            self.music_time -= 2;
            
            if ( self.music_time < 0 )
            {
                self.music_time = 0;
            }
        }
    }
}

// Namespace music_and_dialog
// Params 0
// Checksum 0x73b5aeb9, Offset: 0x65a4
// Size: 0x7d
function function_93ef6e03d957c973()
{
    self endon( #"disconnect" );
    self endon( #"clear_music_low" );
    level endon( #"game_ended" );
    
    if ( !isdefined( self.music_low ) )
    {
        self.music_low = 1;
        self playlocalsound( "mus_iw9_mpmusictest_ambient1_intro" );
        iprintln( "adding low music" );
        self.music_time = 25;
        wait self.music_time;
        iprintln( "low music state cleared" );
        self.music_low = undefined;
    }
}

// Namespace music_and_dialog
// Params 0
// Checksum 0xa1aa0455, Offset: 0x6629
// Size: 0x12b
function function_82666403cb609cfb()
{
    self endon( #"disconnect" );
    self endon( #"clear_music_med" );
    level endon( #"game_ended" );
    
    if ( isdefined( self.music_high ) )
    {
        self.music_high = 1;
        self.music_med = 1;
        self clearsoundsubmix( "iw9_mp_musictest_fadeout", 2 );
        self setplayermusicstate( "" );
        self notify( #"clear_music_high" );
        iprintln( "adding med music" );
        self.music_time = 21;
        wait self.music_time;
        iprintln( "music states cleared" );
        self.music_high = undefined;
        self.music_med = undefined;
        return;
    }
    
    self.music_med = 1;
    self clearsoundsubmix( "iw9_mp_musictest_fadeout", 2 );
    self setplayermusicstate( "iw9_mpmusictest_perc1" );
    iprintln( "adding med music" );
    self.music_time = 21;
    wait self.music_time - 2;
    self setsoundsubmix( "iw9_mp_musictest_fadeout", 2 );
    self stopplayermusicstate( "iw9_mpmusictest_perc1" );
    wait self.music_time + 2;
    iprintln( "med music state cleared" );
    self.music_med = undefined;
}

// Namespace music_and_dialog
// Params 0
// Checksum 0xbc61bc15, Offset: 0x675c
// Size: 0x12e
function function_44001b14d8cd046f()
{
    self endon( #"disconnect" );
    self endon( #"clear_music_high" );
    level endon( #"game_ended" );
    
    if ( isdefined( self.music_med ) )
    {
        self.music_high = 1;
        self.music_med = 1;
        self setplayermusicstate( "" );
        self clearsoundsubmix( "iw9_mp_musictest_fadeout", 2 );
        self notify( #"clear_music_med" );
        iprintln( "adding high music" );
        self.music_time = 31;
        wait self.music_time;
        iprintln( "music states cleared" );
        self.music_high = undefined;
        self.music_med = undefined;
        return;
    }
    
    self.music_high = 1;
    self clearsoundsubmix( "iw9_mp_musictest_fadeout", 2 );
    self setplayermusicstate( "iw9_mpmusictest_bass1" );
    iprintln( "adding high music" );
    self.music_time = 30.5;
    wait self.music_time - 2;
    self setsoundsubmix( "iw9_mp_musictest_fadeout", 2 );
    self stopplayermusicstate( "iw9_mpmusictest_bass1" );
    wait self.music_time + 2;
    iprintln( "high music state cleared" );
    self.music_high = undefined;
}

