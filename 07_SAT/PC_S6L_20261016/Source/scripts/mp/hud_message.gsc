// scripts\mp\hud_message.gsc  (hash_52a6d55588cb0819.gscc) (size: 37068 Bytes / 0x90cc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7a8df151 (2056122705)
// size ...... 37068 (0x90cc)
// includes .. 20  (offset: 0x7ccc)
// strings ... 212 (offset: 0x7d6c)
// dev strs .. 29  (offset: 0x8f5c)
// exports ... 70  (offset: 0x5cbc)
// cseg ...... 0x10cd + 0x4bef (0x5cbc)
// imports ... 151 (offset: 0x67ac)
// animtree1 . 0   (offset: 0x90cc)
// animtree2 . 0   (offset: 0x90cc)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\lui_game_event_aggregator;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\gameinstance;
#using scripts\mp\gamescore;
#using scripts\mp\hud_util;
#using scripts\mp\playerhealth;
#using scripts\mp\playerlogic;
#using scripts\mp\rank;

#namespace hud_message;

// Namespace hud_message
// Params 0
// Checksum 0x16df8842, Offset: 0x10eb
// Size: 0x10c0
function init()
{
    game[ "round_end" ][ "draw" ] = 1;
    game[ "round_end" ][ "round_draw" ] = 2;
    game[ "round_end" ][ "round_win" ] = 3;
    game[ "round_end" ][ "round_loss" ] = 4;
    game[ "round_end" ][ "victory" ] = 5;
    game[ "round_end" ][ "defeat" ] = 6;
    game[ "round_end" ][ "halftime" ] = 7;
    game[ "round_end" ][ "overtime" ] = 8;
    game[ "round_end" ][ "roundend" ] = 9;
    game[ "round_end" ][ "intermission" ] = 10;
    game[ "round_end" ][ "side_switch" ] = 11;
    game[ "round_end" ][ "match_bonus" ] = 12;
    game[ "round_end" ][ "tie" ] = 13;
    game[ "round_end" ][ "spectator" ] = 14;
    game[ "round_end" ][ "final_round" ] = 15;
    game[ "round_end" ][ "match_point" ] = 16;
    game[ "round_end" ][ "practice_round" ] = 17;
    game[ "round_end" ][ "win_by_two" ] = 18;
    game[ "round_end" ][ "secondary_victory" ] = 19;
    game[ "round_end" ][ "next_round" ] = 20;
    game[ "round_end" ][ "bye_round" ] = 21;
    game[ "round_end" ][ "cancelled" ] = 22;
    game[ "round_end" ][ "regulation_draw" ] = 23;
    game[ "round_end" ][ "ot_round" ] = 24;
    game[ "end_reason" ][ "score_limit_reached" ] = 1;
    game[ "end_reason" ][ "time_limit_reached" ] = 2;
    game[ "end_reason" ][ "players_forfeited" ] = 3;
    game[ "end_reason" ][ "target_destroyed" ] = 4;
    game[ "end_reason" ][ "bomb_defused" ] = 5;
    game[ "end_reason" ][ "mp_faction_eliminated" ] = 6;
    game[ "end_reason" ][ "mp_faction_forfeited" ] = 7;
    game[ "end_reason" ][ "enemies_eliminated" ] = 8;
    game[ "end_reason" ][ "tie" ] = 9;
    game[ "end_reason" ][ "objective_completed" ] = 10;
    game[ "end_reason" ][ "objective_failed" ] = 11;
    game[ "end_reason" ][ "switching_sides" ] = 12;
    game[ "end_reason" ][ "round_limit_reached" ] = 13;
    game[ "end_reason" ][ "ended_game" ] = 14;
    game[ "end_reason" ][ "host_ended_game" ] = 15;
    game[ "end_reason" ][ "loss_stat_prevented" ] = 16;
    game[ "end_reason" ][ "time_to_beat_ctf_win" ] = 17;
    game[ "end_reason" ][ "time_to_beat_ctf_loss" ] = 18;
    game[ "end_reason" ][ "time_to_beat_uplink_win" ] = 19;
    game[ "end_reason" ][ "time_to_beat_uplink_loss" ] = 20;
    game[ "end_reason" ][ "nuke_end" ] = 21;
    game[ "end_reason" ][ "enemies_forfeited" ] = 22;
    game[ "end_reason" ][ "arena_time_health_win" ] = 23;
    game[ "end_reason" ][ "arena_time_health_loss" ] = 24;
    game[ "end_reason" ][ "arena_time_lives_win" ] = 25;
    game[ "end_reason" ][ "arena_time_lives_loss" ] = 26;
    game[ "end_reason" ][ "arena_otflag_completed" ] = 27;
    game[ "end_reason" ][ "arena_otflag_failed" ] = 28;
    game[ "end_reason" ][ "outpost_defended" ] = 29;
    game[ "end_reason" ][ "practice_round_over" ] = 30;
    game[ "end_reason" ][ "br_eliminated" ] = 31;
    game[ "end_reason" ][ "cyber_tie" ] = 32;
    game[ "end_reason" ][ "mercy_win" ] = 33;
    game[ "end_reason" ][ "mercy_loss" ] = 34;
    game[ "end_reason" ][ "blank" ] = 35;
    game[ "end_reason" ][ "mlg_time_to_beat_ctf" ] = 36;
    game[ "end_reason" ][ "mlg_time_to_beat_uplink" ] = 37;
    game[ "end_reason" ][ "mlg_time_lives" ] = 38;
    game[ "end_reason" ][ "mlg_time_health" ] = 39;
    game[ "end_reason" ][ "mlg_eliminated" ] = 40;
    game[ "end_reason" ][ "mlg_forfeited" ] = 41;
    game[ "end_reason" ][ "siege_allflags_win" ] = 42;
    game[ "end_reason" ][ "siege_allflags_loss" ] = 43;
    game[ "end_reason" ][ "siege_flag_win" ] = 44;
    game[ "end_reason" ][ "siege_flag_loss" ] = 45;
    game[ "end_reason" ][ "arena_tournament_tie_win" ] = 46;
    game[ "end_reason" ][ "arena_tournament_tie_loss" ] = 47;
    game[ "end_reason" ][ "plunder_loss" ] = 48;
    game[ "end_reason" ][ "plunder_win" ] = 49;
    game[ "end_reason" ][ "enemy_forfeit" ] = 50;
    game[ "end_reason" ][ "survivors_eliminated" ] = 51;
    game[ "end_reason" ][ "siege_force_end" ] = 52;
    game[ "end_reason" ][ "dom_force_end" ] = 53;
    game[ "end_reason" ][ "ko_flag_win" ] = 54;
    game[ "end_reason" ][ "ko_flag_loss" ] = 55;
    game[ "end_reason" ][ "ko_flag_hold_win" ] = 56;
    game[ "end_reason" ][ "ko_flag_hold_loss" ] = 57;
    game[ "end_reason" ][ "ko_alive_count_win" ] = 58;
    game[ "end_reason" ][ "ko_alive_count_loss" ] = 59;
    game[ "end_reason" ][ "ko_draw_award_point" ] = 60;
    game[ "end_reason" ][ "win_by_two_tie" ] = 61;
    game[ "end_reason" ][ "all_hostage_extracted" ] = 62;
    game[ "end_reason" ][ "mlg_otflag_captured" ] = 63;
    game[ "end_reason" ][ "mlg_tournament_tie" ] = 64;
    game[ "end_reason" ][ "team_defending_most_segments" ] = 65;
    game[ "end_reason" ][ "team_defending_most_kills" ] = 66;
    game[ "end_reason" ][ "team_defending" ] = 67;
    game[ "end_reason" ][ "control_allzones_win" ] = 68;
    game[ "end_reason" ][ "control_allzones_loss" ] = 69;
    game[ "end_reason" ][ "mlg_allzones_captured" ] = 70;
    game[ "end_reason" ][ "lg_tiebreaker_zonesheld_win" ] = 71;
    game[ "end_reason" ][ "lg_tiebreaker_zonesheld_loss" ] = 72;
    game[ "end_reason" ][ "elim_lives_win" ] = 73;
    game[ "end_reason" ][ "elim_lives_loss" ] = 74;
    game[ "end_reason" ][ "elim_tie" ] = 75;
    game[ "end_reason" ][ "friendlies_eliminated" ] = 76;
    game[ "end_reason" ][ "save_and_end_game" ] = 77;
    game[ "end_reason" ][ "server_quit" ] = 78;
    game[ "end_reason" ][ "advance_to_next_round" ] = 79;
    game[ "end_reason" ][ "enemy_disconnected" ] = 80;
    game[ "end_reason" ][ "mp_faction_success" ] = 81;
    game[ "end_reason" ][ "cursed_mode_validation_failed" ] = 82;
    game[ "end_reason" ][ "escort_tiebreaker_fastest_win" ] = 83;
    game[ "end_reason" ][ "escort_tiebreaker_distance_win" ] = 84;
    game[ "end_reason" ][ "lp_match_cancelled" ] = 85;
    game[ "end_reason" ][ "time_to_beat_sabattack_win" ] = 86;
    game[ "end_reason" ][ "time_to_beat_sabattack_loss" ] = 87;
    game[ "end_reason" ][ "time_to_beat_sabattack_improve" ] = 88;
    game[ "end_reason" ][ "time_to_beat_sabattack_no_time" ] = 89;
    game[ "end_reason" ][ "time_to_beat_sabattack_beat" ] = 90;
    game[ "end_reason" ][ "time_to_beat_sabattack_tie" ] = 91;
    game[ "end_reason" ][ "time_to_beat_sabattack_set" ] = 92;
    game[ "end_reason" ][ "time_to_beat_sabattack_beat_enemy" ] = 93;
    game[ "end_reason" ][ "cdl_time_to_beat_sabattack_set" ] = 94;
    game[ "end_reason" ][ "cdl_time_to_beat_sabattack_endround" ] = 95;
    game[ "end_reason" ][ "escort_entity_delivered_in" ] = 96;
    game[ "end_reason" ][ "escort_enemy_entity_delivered_in" ] = 97;
    game[ "end_reason" ][ "escort_add_point_fastest_win" ] = 98;
    game[ "end_reason" ][ "escort_add_point_distance_win" ] = 99;
    game[ "end_reason" ][ "free_run_finished_race" ] = 100;
    game[ "round_end_exmsg" ][ "intermission" ] = 1;
    game[ "round_end_exmsg" ][ "switching_sides" ] = 2;
    game[ "round_end_exmsg" ][ "match_point" ] = 3;
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "time_to_beat_ctf_win" ], game[ "end_reason" ][ "mlg_time_to_beat_ctf" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "time_to_beat_ctf_loss" ], game[ "end_reason" ][ "mlg_time_to_beat_ctf" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "arena_time_health_win" ], game[ "end_reason" ][ "mlg_time_health" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "arena_time_health_loss" ], game[ "end_reason" ][ "mlg_time_health" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "time_to_beat_uplink_win" ], game[ "end_reason" ][ "mlg_time_to_beat_uplink" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "time_to_beat_uplink_loss" ], game[ "end_reason" ][ "mlg_time_to_beat_uplink" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "arena_time_lives_win" ], game[ "end_reason" ][ "mlg_time_lives" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "arena_time_lives_loss" ], game[ "end_reason" ][ "mlg_time_lives" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "rusf_eliminated" ], game[ "end_reason" ][ "mlg_eliminated" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "usmc_eliminated" ], game[ "end_reason" ][ "mlg_eliminated" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "sas_eliminated" ], game[ "end_reason" ][ "mlg_eliminated" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "zvir_eliminated" ], game[ "end_reason" ][ "mlg_eliminated" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "icorps_eliminated" ], game[ "end_reason" ][ "mlg_eliminated" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "grp9_eliminated" ], game[ "end_reason" ][ "mlg_eliminated" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "rangers_eliminated" ], game[ "end_reason" ][ "mlg_eliminated" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "tf141_eliminated" ], game[ "end_reason" ][ "mlg_eliminated" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "navy_eliminated" ], game[ "end_reason" ][ "mlg_eliminated" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "opfor_eliminated" ], game[ "end_reason" ][ "mlg_eliminated" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "sptnz_eliminated" ], game[ "end_reason" ][ "mlg_eliminated" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "mili_eliminated" ], game[ "end_reason" ][ "mlg_eliminated" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "spetsnaz_forfeited" ], game[ "end_reason" ][ "mlg_forfeited" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "marines_forfeited" ], game[ "end_reason" ][ "mlg_forfeited" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "sas_forfeited" ], game[ "end_reason" ][ "mlg_forfeited" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "zvir_forfeited" ], game[ "end_reason" ][ "mlg_forfeited" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "icorps_forfeited" ], game[ "end_reason" ][ "mlg_forfeited" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "grp9_forfeited" ], game[ "end_reason" ][ "mlg_forfeited" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "rangers_forfeited" ], game[ "end_reason" ][ "mlg_forfeited" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "tf141_forfeited" ], game[ "end_reason" ][ "mlg_forfeited" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "navy_forfeited" ], game[ "end_reason" ][ "mlg_forfeited" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "opfor_forfeited" ], game[ "end_reason" ][ "mlg_forfeited" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "sptnz_forfeited" ], game[ "end_reason" ][ "mlg_forfeited" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "mili_forfeited" ], game[ "end_reason" ][ "mlg_forfeited" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "enemies_eliminated" ], game[ "end_reason" ][ "mlg_eliminated" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "mp_faction_eliminated" ], game[ "end_reason" ][ "mlg_eliminated" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "enemies_forfeited" ], game[ "end_reason" ][ "mlg_forfeited" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "arena_otflag_completed" ], game[ "end_reason" ][ "mlg_otflag_captured" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "arena_otflag_failed" ], game[ "end_reason" ][ "mlg_otflag_captured" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "arena_tournament_tie_win" ], game[ "end_reason" ][ "mlg_tournament_tie" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "arena_tournament_tie_loss" ], game[ "end_reason" ][ "mlg_tournament_tie" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "control_allzones_win" ], game[ "end_reason" ][ "mlg_allzones_captured" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "control_allzones_loss" ], game[ "end_reason" ][ "mlg_allzones_captured" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "time_to_beat_sabattack_beat_enemy" ], game[ "end_reason" ][ "cdl_time_to_beat_sabattack_set" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "time_to_beat_sabattack_beat" ], game[ "end_reason" ][ "cdl_time_to_beat_sabattack_set" ] );
    function_ec8a38a3c4491cac( "end_reason_mlg_mapping", game[ "end_reason" ][ "time_to_beat_sabattack_win" ], game[ "end_reason" ][ "cdl_time_to_beat_sabattack_endround" ] );
    
    if ( !isdefined( level.splashtablecache ) )
    {
        level.splashtablecache = [];
    }
    
    if ( !isdefined( level.var_3e518141bcfabbdd ) )
    {
        level.var_3e518141bcfabbdd = [];
    }
    
    if ( !isdefined( level.var_7b2fd27ec6c3a883 ) )
    {
        level.var_7b2fd27ec6c3a883 = [];
    }
    
    if ( !isdefined( level.splashlistcache ) )
    {
        level.splashlistcache = [];
    }
    
    level.var_d3023336ef84113c = -2;
    level.var_7e0890446f2ca2c3 = getdvarfloat( @"scr_splash_kill_buffer", 0.5 ) * 1000;
    level thread onplayerconnect();
    function_f618be077131ab21();
    function_49762958460c302b();
    lui_game_event_aggregator::registeronluieventcallback( &splashshowncallback );
    level.showerrormessagefunc = &showerrormessage;
    
    /#
        init_splash_devgui();
        function_93868c409751ae04();
    #/
    
    if ( !getdvarint( @"hash_f06348bcdd656448", 0 ) )
    {
        if ( isbrgamemode() )
        {
            function_4a87819277b2cf6b();
        }
    }
    
    if ( level.gamemodebundle.var_d705f1761a066944 )
    {
        level.var_c8b1156f27dece79 = [];
        
        foreach ( additionalsplashlist in level.gamemodebundle.var_c8b1156f27dece79 )
        {
            var_516737d51ad77948 = additionalsplashlist.splashlist;
            splashlistbundle = getscriptbundle( additionalsplashlist.splashlist );
            function_23836e6332e2cd3c( splashlistbundle, var_516737d51ad77948 );
            cachesplashlist( var_516737d51ad77948 );
            
            foreach ( splashentry in splashlistbundle.splash_list )
            {
                level.var_c8b1156f27dece79[ splashentry.ref ] = var_516737d51ad77948;
            }
        }
    }
}

// Namespace hud_message
// Params 3
// Checksum 0xec307837, Offset: 0x21b3
// Size: 0x38
function function_ec8a38a3c4491cac( key, subkey, reason )
{
    if ( isdefined( key ) && isdefined( subkey ) && isdefined( reason ) )
    {
        game[ key ][ subkey ] = reason;
    }
}

// Namespace hud_message
// Params 0
// Checksum 0xc3ce0ecb, Offset: 0x21f3
// Size: 0x30
function onplayerconnect()
{
    for ( ;; )
    {
        level waittill( #"connected", player );
        player thread lowermessagethink();
        player thread eventsplashesthink();
    }
}

// Namespace hud_message
// Params 2
// Checksum 0x8121c762, Offset: 0x222b
// Size: 0x49
function function_23836e6332e2cd3c( splashlistbundle, splashlistname )
{
    if ( !isdefined( splashlistbundle ) )
    {
        return;
    }
    
    if ( !isdefined( splashlistname ) )
    {
        return;
    }
    
    if ( !isdefined( level.splashlistcache ) )
    {
        level.splashlistcache = [];
    }
    
    level.splashlistcache[ splashlistname ] = splashlistbundle;
}

// Namespace hud_message
// Params 2
// Checksum 0xa00ce3d4, Offset: 0x227c
// Size: 0xcf
function function_b4446495b4d8f194( splashref, splashbundlename )
{
    if ( !isdefined( splashbundlename ) )
    {
        return;
    }
    
    if ( !isdefined( splashref ) )
    {
        return;
    }
    
    assert( isxhash( splashref ) );
    assert( isxhashasset( splashbundlename ) );
    
    if ( splashref == #"" )
    {
        return;
    }
    
    var_a66a9d37fb19a4fa = function_43b5ed5a14a56573( #"scriptbundle_splash", splashbundlename );
    assert( isdefined( var_a66a9d37fb19a4fa ), "<dev string:x24>" + getxhashsourcename( splashbundlename ) );
    
    if ( isdefined( var_a66a9d37fb19a4fa ) )
    {
        if ( !isdefined( level.var_3e518141bcfabbdd ) )
        {
            level.var_3e518141bcfabbdd = [];
        }
        
        assert( !isdefined( level.var_3e518141bcfabbdd[ splashref ] ), "<dev string:x65>" + getxhashsourcename( splashref ) );
        level.var_3e518141bcfabbdd[ splashref ] = var_a66a9d37fb19a4fa;
    }
}

// Namespace hud_message
// Params 1
// Checksum 0xd4b38a9d, Offset: 0x2353
// Size: 0x19, Type: bool
function function_203dfe2e6060c0b9( splashref )
{
    return isdefined( level.var_3e518141bcfabbdd[ splashref ] );
}

// Namespace hud_message
// Params 5
// Checksum 0x9b1ec05d, Offset: 0x2375
// Size: 0xcd
function showkillstreaksplash( splashref, streakval, fromcarepackage, splashlistoverride, var_f937c718caee5b5c )
{
    if ( level.gamemodebundle.var_6b9b0cbc05b8e21b )
    {
        return;
    }
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( isnumber( var_f937c718caee5b5c ) )
    {
        self endon( #"disconnect" );
        
        while ( var_f937c718caee5b5c > 0 )
        {
            var_f937c718caee5b5c--;
            waitframe();
        }
        
        if ( !isdefined( self ) )
        {
            return;
        }
    }
    
    altdisplayindex = undefined;
    
    if ( fromcarepackage )
    {
        altdisplayindex = 1;
    }
    
    splashref = getspecialistsplashfromkillstreak( splashref );
    showsplash( splashref, streakval, undefined, altdisplayindex, undefined, splashlistoverride );
    
    if ( !game_utility::function_d3f8957534dc62af() )
    {
        killstreak_utility::playkillstreakteamleaderdialog( splashref, getxhash( splashref ), #"earned" );
    }
}

// Namespace hud_message
// Params 1
// Checksum 0xa0868800, Offset: 0x244a
// Size: 0x38
function getspecialistsplashfromkillstreak( splashref )
{
    var_b5b4ab25593458dc = splashref;
    specialistperk = perks::getspecialistperkforstreak( splashref );
    
    if ( isdefined( specialistperk ) )
    {
        var_b5b4ab25593458dc = specialistperk;
    }
    
    return var_b5b4ab25593458dc;
}

// Namespace hud_message
// Params 6
// Checksum 0x3af6b0a5, Offset: 0x248b
// Size: 0xad
function showsplashwithkillcheckhack( ref, optionalnumber, playerforplayercard, altdisplayindex, splashlistoverride, forceshow )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    waitframe();
    
    if ( self.lastkilltime > 0 )
    {
        delaytime = int( max( level.var_7e0890446f2ca2c3 - gettime() - self.lastkilltime, 0 ) );
        wait delaytime / 1000;
    }
    
    if ( isdefined( self ) )
    {
        showsplash( ref, optionalnumber, playerforplayercard, altdisplayindex, 1, splashlistoverride, forceshow );
    }
}

// Namespace hud_message
// Params 3
// Checksum 0x82c6db10, Offset: 0x2540
// Size: 0x2d
function function_78fedf6f526825f4( ref, splashlistoverride, optionalnumber )
{
    showsplash( ref, optionalnumber, undefined, undefined, undefined, splashlistoverride );
}

// Namespace hud_message
// Params 6
// Checksum 0x390ea4a8, Offset: 0x2575
// Size: 0x4a
function function_ccbbac80e736b9f9( ref, optionalnumber, playerforplayercard, altdisplayindex, var_4dd30bf63f0b5e8b, splashlistoverride )
{
    showsplash( ref, optionalnumber, playerforplayercard, altdisplayindex, var_4dd30bf63f0b5e8b, splashlistoverride, 1 );
}

// Namespace hud_message
// Params 7
// Checksum 0xbbba2571, Offset: 0x25c7
// Size: 0x12b
function showsplash( ref, optionalnumber, playerforplayercard, altdisplayindex, var_4dd30bf63f0b5e8b, splashlistoverride, forceshow )
{
    self endon( #"disconnect" );
    
    if ( !forceshow && function_812489dec937e6ce() )
    {
        return;
    }
    
    assert( isplayer( self ) );
    
    if ( !var_4dd30bf63f0b5e8b )
    {
        thread showsplashwithkillcheckhack( ref, optionalnumber, playerforplayercard, altdisplayindex, splashlistoverride, forceshow );
        return;
    }
    
    playernumforplayercard = undefined;
    
    if ( isdefined( playerforplayercard ) )
    {
        playernumforplayercard = playerforplayercard getentitynumber();
    }
    
    if ( self.recentsplashcount >= 6 )
    {
        queuesplash( ref, optionalnumber, playerforplayercard, playernumforplayercard, altdisplayindex, splashlistoverride );
        return;
    }
    
    var_a16bb9f9bb667148 = level.gametypebundle.var_a16bb9f9bb667148 ?? 0;
    
    if ( !player::isreallyalive( self ) && isplayer( self ) && !self iscodcaster() && ( !var_a16bb9f9bb667148 || player::isinkillcam() ) )
    {
        queuesplash( ref, optionalnumber, playerforplayercard, playernumforplayercard, altdisplayindex, splashlistoverride );
        return;
    }
    
    showsplashinternal( ref, optionalnumber, playerforplayercard, playernumforplayercard, altdisplayindex, splashlistoverride );
}

// Namespace hud_message
// Params 6
// Checksum 0xfa4747ca, Offset: 0x26fa
// Size: 0x2f3
function showsplashinternal( ref, optionalnumber, playerforplayercard, playernumforplayercard, altdisplayindex, splashlistoverride )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( isdefined( playernumforplayercard ) )
    {
        if ( !isdefined( playerforplayercard ) )
        {
            return;
        }
    }
    
    if ( getdvarint( @"hash_ef4f06e55f320347", 0 ) == 1 )
    {
        isscriptbundlesplash = 1;
        splashid = function_b38e6009339f46f7( ref, splashlistoverride );
        
        if ( !isdefined( splashid ) || splashid < 0 )
        {
            isscriptbundlesplash = 0;
            splashid = getsplashid( ref );
        }
    }
    else
    {
        isscriptbundlesplash = 0;
        splashid = getsplashid( ref );
        
        if ( !isdefined( splashid ) || splashid < 0 )
        {
            splashid = function_b38e6009339f46f7( ref, splashlistoverride );
            isscriptbundlesplash = 1;
        }
    }
    
    if ( !isdefined( splashid ) || splashid < 0 )
    {
        assertmsg( "<dev string:x94>" + getxhashsourcename( ref ) + "<dev string:xba>" + getsplashtablename() + "<dev string:xd6>" );
        return;
    }
    
    assert( splashid < 4096, "<dev string:xed>" );
    
    if ( !isdefined( self.var_8371af86d4691b34 ) )
    {
        self.var_8371af86d4691b34 = 0;
    }
    
    if ( !isdefined( self.var_cb88a4a6305c40ea ) )
    {
        self.var_cb88a4a6305c40ea = 1;
    }
    
    omnvarvalue = splashid;
    
    if ( self.var_cb88a4a6305c40ea )
    {
        omnvarvalue |= 4096;
    }
    
    if ( isdefined( optionalnumber ) )
    {
        if ( level.var_d3023336ef84113c < optionalnumber )
        {
            level.var_d3023336ef84113c = optionalnumber;
            
            /#
                println( "<dev string:x141>" );
                println( "<dev string:x160>" + level.var_d3023336ef84113c );
            #/
        }
        
        self setclientomnvar( "ui_player_splash_param_" + self.var_8371af86d4691b34, optionalnumber );
    }
    else
    {
        self setclientomnvar( "ui_player_splash_param_" + self.var_8371af86d4691b34, -1 );
    }
    
    if ( isdefined( playernumforplayercard ) )
    {
        self setclientomnvar( "ui_player_splash_cardClientId_" + self.var_8371af86d4691b34, playernumforplayercard );
    }
    else
    {
        self setclientomnvar( "ui_player_splash_cardClientId_" + self.var_8371af86d4691b34, -1 );
    }
    
    if ( isdefined( altdisplayindex ) )
    {
        self setclientomnvar( "ui_player_splash_use_alt_" + self.var_8371af86d4691b34, altdisplayindex );
    }
    else
    {
        self setclientomnvar( "ui_player_splash_use_alt_" + self.var_8371af86d4691b34, 0 );
    }
    
    self setclientomnvar( "ui_player_splash_scriptBundle_" + self.var_8371af86d4691b34, isscriptbundlesplash );
    self setclientomnvar( "ui_player_splash_id_" + self.var_8371af86d4691b34, omnvarvalue );
    
    if ( !isdefined( self.recentsplashcount ) )
    {
        self.recentsplashcount = 1;
    }
    else
    {
        self.recentsplashcount++;
    }
    
    thread cleanuplocalplayersplashlist();
    self.var_8371af86d4691b34++;
    
    if ( self.var_8371af86d4691b34 >= 6 )
    {
        self.var_8371af86d4691b34 = 0;
        self.var_cb88a4a6305c40ea = !self.var_cb88a4a6305c40ea;
    }
    
    callback::callback( #"splash_shown", { #ref:ref } );
}

// Namespace hud_message
// Params 6
// Checksum 0xfd16b8cc, Offset: 0x29f5
// Size: 0xe2
function queuesplash( ref, optionalnumber, playerforplayercard, playernumforplayercard, altdisplayindex, splashlistoverride )
{
    struct = { #splashlistoverride:splashlistoverride, #altdisplayindex:altdisplayindex, #playernumforplayercard:playernumforplayercard, #playerforplayercard:playerforplayercard, #optionalnumber:optionalnumber, #ref:ref };
    
    if ( !isdefined( self.splashqueuehead ) )
    {
        self.splashqueuehead = struct;
        self.splashqueuetail = struct;
        thread handlesplashqueue();
        return;
    }
    
    oldtail = self.splashqueuetail;
    oldtail.nextsplash = struct;
    self.splashqueuetail = struct;
}

// Namespace hud_message
// Params 0, eflags: 0xc
// Checksum 0x7789380f, Offset: 0x2adf
// Size: 0x168
function private handlesplashqueue()
{
    self notify( #"hash_1357bbb4d567aff0" );
    self endon( #"hash_1357bbb4d567aff0" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_82dedaebefa39eb4" );
    
    if ( !isdefined( level.var_ab8d05764e255d91 ) )
    {
        gametype = game_utility::getgametype();
        level.var_ab8d05764e255d91 = isbrgamemode() && ( gametype == "dmz" || gametype == "plunder" );
    }
    
    while ( isdefined( self.splashqueuehead ) )
    {
        if ( level.var_ab8d05764e255d91 )
        {
            utility::waittill_any( "splash_list_cleared", "can_show_splashes" );
        }
        else
        {
            utility::waittill_any( "splash_list_cleared", "spawned_player" );
        }
        
        for ( var_c14d16cd0cfc1422 = 0; var_c14d16cd0cfc1422 < 6 ; var_c14d16cd0cfc1422++ )
        {
            struct = self.splashqueuehead;
            showsplashinternal( struct.ref, struct.optionalnumber, struct.playerforplayercard, struct.playernumforplayercard, struct.altdisplayindex, struct.splashlistoverride );
            self.splashqueuehead = struct.nextsplash;
            
            if ( !isdefined( self.splashqueuehead ) )
            {
                break;
            }
        }
    }
    
    self.splashqueuetail = undefined;
}

// Namespace hud_message
// Params 0
// Checksum 0x54ccbd0, Offset: 0x2c4f
// Size: 0x26
function function_c7ef9b0007b5092d()
{
    current_value = self getclientomnvar( "ui_player_splash_force_hide_current_splash" );
    self setclientomnvar( "ui_player_splash_force_hide_current_splash", !current_value );
}

// Namespace hud_message
// Params 0
// Checksum 0x6f251c0c, Offset: 0x2c7d
// Size: 0x26
function function_cb764616620ad77()
{
    current_value = self getclientomnvar( "ui_player_splash_clear_splash_queue" );
    self setclientomnvar( "ui_player_splash_clear_splash_queue", !current_value );
}

// Namespace hud_message
// Params 0
// Checksum 0x43ab97d7, Offset: 0x2cab
// Size: 0x64
function clearsplashqueue()
{
    self notify( #"hash_82dedaebefa39eb4" );
    nextsplash = self.splashqueuehead;
    
    while ( isdefined( nextsplash ) )
    {
        currentsplash = nextsplash;
        nextsplash = currentsplash.nextsplash;
        currentsplash.nextsplash = undefined;
    }
    
    self.splashqueuehead = undefined;
    self.splashqueuetail = undefined;
}

// Namespace hud_message
// Params 1
// Checksum 0xff202915, Offset: 0x2d17
// Size: 0x61
function getsplashid( splashref )
{
    if ( level.gamemodebundle.var_3ebc79b20ea42a8f )
    {
        return;
    }
    
    id = level.splashtablecache[ splashref ];
    
    if ( !isdefined( id ) )
    {
        id = tablelookuprownum( getsplashtablename(), 0, splashref );
        level.splashtablecache[ splashref ] = id;
    }
    
    return id;
}

// Namespace hud_message
// Params 0, eflags: 0x4
// Checksum 0xdd110871, Offset: 0x2d81
// Size: 0x52
function private function_4a87819277b2cf6b()
{
    if ( !isdefined( splashlistname ) )
    {
        splashlistname = level.gametypebundle.splashlist;
    }
    
    if ( !isdefined( splashlistname ) )
    {
        splashlistname = level.gamemodebundle.splashlist;
    }
    
    registersplashlist( splashlistname );
    cachesplashlist( splashlistname );
}

// Namespace hud_message
// Params 2, eflags: 0x4
// Checksum 0x8a876487, Offset: 0x2ddb
// Size: 0x101
function private function_ae6d8c4c5ebbba96( splashref, splashlistname )
{
    if ( !isdefined( splashlistname ) )
    {
        level.var_7b2fd27ec6c3a883[ splashref ] = 1;
        return;
    }
    
    registersplashlist( splashlistname );
    
    if ( !isdefined( level.splashlistcache[ splashlistname ].splash_list ) )
    {
        level.var_7b2fd27ec6c3a883[ splashref ] = 1;
        return;
    }
    
    cachesplashlist( splashlistname );
    splashbundle = level.var_e7f0111b486902cd[ splashlistname ][ splashref ];
    
    if ( isdefined( splashbundle ) )
    {
        assert( splashbundle != %"", "<dev string:x16e>" + getxhashhexname( splashref ) );
        id = undefined;
        
        if ( splashbundle != %"" )
        {
            id = function_43b5ed5a14a56573( #"scriptbundle_splash", splashbundle );
        }
        else
        {
            script::function_2e2007575f92910d( "Undefined splashListEntry.splashBundle for splashName: " + getxhashhexname( splashref ) );
        }
        
        if ( isdefined( id ) )
        {
            level.var_3e518141bcfabbdd[ splashref ] = id;
            return id;
        }
    }
}

// Namespace hud_message
// Params 1
// Checksum 0xad7aba0e, Offset: 0x2ee5
// Size: 0x63
function registersplashlist( splashlistname )
{
    if ( !isdefined( level.splashlistcache[ splashlistname ] ) )
    {
        splashlist = undefined;
        
        if ( isxhashasset( splashlistname ) )
        {
            splashlist = getscriptbundle( splashlistname );
        }
        else
        {
            splashlist = getscriptbundle( hashcat( %"hash_7ac5a0b15c7d50e5", splashlistname ) );
        }
        
        if ( isdefined( splashlist ) )
        {
            function_23836e6332e2cd3c( splashlist, splashlistname );
        }
    }
}

// Namespace hud_message
// Params 1
// Checksum 0xa1bc0563, Offset: 0x2f50
// Size: 0xee
function cachesplashlist( splashlistname )
{
    if ( isdefined( level.var_e7f0111b486902cd[ splashlistname ] ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_e7f0111b486902cd ) )
    {
        level.var_e7f0111b486902cd = [];
    }
    
    level.var_e7f0111b486902cd[ splashlistname ] = [];
    
    foreach ( splashlistentry in level.splashlistcache[ splashlistname ].splash_list )
    {
        level.var_e7f0111b486902cd[ splashlistname ][ splashlistentry.ref ] = splashlistentry.splashbundle ?? %"";
    }
}

// Namespace hud_message
// Params 2
// Checksum 0x8912b913, Offset: 0x3046
// Size: 0x171
function function_b38e6009339f46f7( splashref, splashlistoverride )
{
    if ( !isxhash( splashref ) )
    {
        splashref = getxhash( splashref );
    }
    
    id = level.var_3e518141bcfabbdd[ splashref ];
    
    if ( isdefined( id ) )
    {
        return id;
    }
    
    if ( level.var_7b2fd27ec6c3a883[ splashref ] )
    {
        return;
    }
    
    splashlistname = splashlistoverride;
    
    if ( !isdefined( splashlistname ) )
    {
        splashlistname = level.gametypebundle.splashlist;
    }
    
    if ( !isdefined( splashlistname ) )
    {
        splashlistname = level.gamemodebundle.splashlist;
    }
    
    var_8e23850932e9f567 = function_ae6d8c4c5ebbba96( splashref, splashlistname );
    
    if ( !isdefined( var_8e23850932e9f567 ) && isdefined( level.gametypebundle.var_e662dd7f27d462eb ) )
    {
        var_8e23850932e9f567 = function_ae6d8c4c5ebbba96( splashref, level.gametypebundle.var_e662dd7f27d462eb );
    }
    
    if ( !isdefined( var_8e23850932e9f567 ) )
    {
        if ( level.gamemodebundle.var_d705f1761a066944 )
        {
            if ( level.var_c8b1156f27dece79[ splashref ] )
            {
                splashlistname = level.var_c8b1156f27dece79[ splashref ];
                var_8e23850932e9f567 = function_ae6d8c4c5ebbba96( splashref, splashlistname );
            }
        }
    }
    
    var_7237854e3be197ca = var_8e23850932e9f567;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    id = rank::function_f465d08c4d101328( splashref );
    
    if ( isdefined( id ) )
    {
        level.var_3e518141bcfabbdd[ splashref ] = id;
        return id;
    }
    
    level.var_7b2fd27ec6c3a883[ splashref ] = 1;
}

// Namespace hud_message
// Params 0
// Checksum 0x88509a2c, Offset: 0x31bf
// Size: 0x1db
function lowermessagethink()
{
    self endon( #"disconnect" );
    self.lowermessages = [];
    lowermessagefont = "default";
    
    if ( isdefined( level.lowermessagefont ) )
    {
        lowermessagefont = level.lowermessagefont;
    }
    
    messagey = level.lowertexty;
    var_c7682ea4f85edd = level.lowertextfontsize;
    var_3969a1b7314dabb7 = 1.25;
    
    if ( level.splitscreen || self issplitscreenplayer() && !isai( self ) )
    {
        messagey -= 40;
        var_c7682ea4f85edd = level.lowertextfontsize * 1.3;
        var_3969a1b7314dabb7 *= 1.5;
    }
    
    self.lowermessage = hud_util::createfontstring( lowermessagefont, var_c7682ea4f85edd );
    self.lowermessage settext( "" );
    self.lowermessage.archived = 0;
    self.lowermessage.sort = 10;
    self.lowermessage.showinkillcam = 0;
    self.lowermessage hud_util::setpoint( "CENTER", level.lowertextyalign, 0, messagey );
    self.lowertimer = hud_util::createfontstring( "default", var_3969a1b7314dabb7 );
    self.lowertimer hud_util::setparent( self.lowermessage );
    self.lowertimer hud_util::setpoint( "TOP", "BOTTOM", 0, 0 );
    self.lowertimer settext( "" );
    self.lowertimer.archived = 0;
    self.lowertimer.sort = 10;
    self.lowertimer.showinkillcam = 0;
}

// Namespace hud_message
// Params 0
// Checksum 0xe6354c5d, Offset: 0x33a2
// Size: 0x3, Type: bool
function isdoingsplash()
{
    return false;
}

// Namespace hud_message
// Params 1, eflags: 0x4
// Checksum 0x136a375b, Offset: 0x33ae
// Size: 0x46
function private function_831670a7cf321d( matchresult )
{
    self setclientomnvar( o"ui_round_end_title", matchresult );
    var_6f9b00680ed002d8 = level.var_6f9b00680ed002d8;
    self setplayerdata( var_6f9b00680ed002d8, "aarData", "matchResult", matchresult );
}

// Namespace hud_message
// Params 5
// Checksum 0xdbe063b4, Offset: 0x33fc
// Size: 0xa96
function teamoutcomenotify( winner, isround, endreasontext, endreasontextloss, roundendextramessage )
{
    self endon( #"disconnect" );
    tempwinner = winner;
    gametype = game_utility::getgametype();
    
    if ( isdefined( roundendextramessage ) )
    {
        self setclientomnvar( o"ui_round_end_extra_message", roundendextramessage );
    }
    
    team = self.pers[ "team" ];
    
    if ( self iscodcaster() )
    {
        team = self getcodcasterteam();
    }
    
    if ( !isdefined( team ) || !arraycontains( level.teamnamelist, team ) )
    {
        team = "allies";
    }
    
    if ( winner == "halftime" )
    {
        self setclientomnvar( o"ui_round_end_title", game[ "round_end" ][ "halftime" ] );
        
        if ( game_utility_mp::istimetobeatrulegametype() && gametype == "sabattack" && level.currentround != 1 && isdefined( self.pers[ "team" ] ) )
        {
            if ( game[ "timeToBeatTeam" ] == team )
            {
                endreasontext = game[ "end_reason" ][ "time_to_beat_sabattack_beat" ];
            }
            else if ( game[ "timeToBeatTeam" ] == team_utility::getotherteam( self.pers[ "team" ] ) )
            {
                endreasontext = game[ "end_reason" ][ "time_to_beat_sabattack_beat_enemy" ];
            }
            else
            {
                endreasontext = game[ "end_reason" ][ "time_to_beat_sabattack_tie" ];
            }
            
            if ( self iscodcaster() && game[ "timeToBeatTeam" ] != "none" )
            {
                winner = game[ "timeToBeatTeam" ];
                endreasontext = game[ "end_reason" ][ "time_to_beat_sabattack_beat" ];
            }
        }
    }
    else if ( winner == "intermission" )
    {
        self setclientomnvar( o"ui_round_end_title", game[ "round_end" ][ "intermission" ] );
        tempwinner = "allies";
    }
    else if ( winner == "switching_sides" )
    {
        if ( game_utility_mp::istimetobeatrulegametype() && level.currentround != 1 )
        {
            if ( gametype == "sabattack" && isdefined( self.pers[ "team" ] ) )
            {
                if ( game[ "timeToBeatTeam" ] == team )
                {
                    endreasontext = game[ "end_reason" ][ "time_to_beat_sabattack_improve" ];
                }
                else if ( game[ "timeToBeatTeam" ] == team_utility::getotherteam( self.pers[ "team" ] ) || game[ "timeToBeatTeam" ] == "none" )
                {
                    endreasontext = game[ "end_reason" ][ "time_to_beat_sabattack_no_time" ];
                }
                
                setomnvar( "ui_show_time_to_beat", 1 );
                self setclientomnvar( o"ui_round_end_title", game[ "round_end" ][ "ot_round" ] );
                
                if ( level.currentround == 2 )
                {
                    endreasontext = game[ "end_reason" ][ "time_to_beat_sabattack_set" ];
                }
            }
        }
        else
        {
            self setclientomnvar( o"ui_round_end_title", game[ "round_end" ][ "side_switch" ] );
        }
        
        tempwinner = "allies";
    }
    else if ( winner == "roundend" )
    {
        self setclientomnvar( o"ui_round_end_title", game[ "round_end" ][ "roundend" ] );
        tempwinner = "allies";
    }
    else if ( winner == "overtime" )
    {
        if ( game_utility_mp::iswinbytworulegametype() && !game_utility_mp::allteamstied() )
        {
            self setclientomnvar( o"ui_round_end_title", game[ "round_end" ][ "match_point" ] );
        }
        else
        {
            self setclientomnvar( o"ui_round_end_title", game[ "round_end" ][ "overtime" ] );
        }
        
        tempwinner = "allies";
    }
    else if ( winner == "match_point" )
    {
        if ( gametype == "wm" || gametype == "escort" )
        {
            self setclientomnvar( o"ui_round_end_title", game[ "round_end" ][ "side_switch" ] );
            tempwinner = "allies";
        }
        else
        {
            self setclientomnvar( o"ui_round_end_title", game[ "round_end" ][ "match_point" ] );
            tempwinner = "allies";
        }
    }
    else if ( winner == "final_round" )
    {
        self setclientomnvar( o"ui_round_end_title", game[ "round_end" ][ "final_round" ] );
        tempwinner = "allies";
    }
    else if ( winner == "win_by_two" )
    {
        self setclientomnvar( o"ui_round_end_title", game[ "round_end" ][ "win_by_two" ] );
        tempwinner = "allies";
    }
    else if ( winner == "tie" )
    {
        if ( level.leagueplaymatchcancelled )
        {
            function_831670a7cf321d( game[ "round_end" ][ "cancelled" ] );
        }
        else if ( isround && !game_utility_mp::waslastround() )
        {
            if ( gametype == "sabattack" && game_utility_mp::istimetobeatrulegametype() )
            {
                self setclientomnvar( o"ui_round_end_title", game[ "round_end" ][ "regulation_draw" ] );
            }
            else
            {
                self setclientomnvar( o"ui_round_end_title", game[ "round_end" ][ "round_draw" ] );
            }
        }
        else
        {
            function_831670a7cf321d( game[ "round_end" ][ "draw" ] );
        }
        
        tempwinner = "allies";
    }
    else if ( winner == "bye_round" )
    {
        self setclientomnvar( o"ui_round_end_title", game[ "round_end" ][ "bye_round" ] );
        tempwinner = "allies";
    }
    else if ( self iscodcaster() )
    {
        self setclientomnvar( o"ui_round_end_title", game[ "round_end" ][ "spectator" ] );
    }
    else if ( isdefined( self.pers[ "team" ] ) && winner == team )
    {
        if ( gametype == "wm" )
        {
            if ( team == winner )
            {
                self setclientomnvar( o"ui_round_end_title", game[ "round_end" ][ "victory" ] );
            }
        }
        else if ( isround && !game_utility_mp::waslastround() )
        {
            self setclientomnvar( o"ui_round_end_title", game[ "round_end" ][ "round_win" ] );
        }
        else
        {
            function_831670a7cf321d( game[ "round_end" ][ "victory" ] );
        }
    }
    else if ( game[ "eliminated" ][ self.pers[ "team" ] ] )
    {
        self setclientomnvar( o"ui_round_end_title", game[ "round_end" ][ "defeat" ] );
        endreasontext = game[ "end_reason" ][ "friendlies_eliminated" ];
    }
    else if ( isround && !game_utility_mp::waslastround() && gametype != "wm" )
    {
        self setclientomnvar( o"ui_round_end_title", game[ "round_end" ][ "round_loss" ] );
    }
    else
    {
        function_831670a7cf321d( game[ "round_end" ][ "defeat" ] );
    }
    
    if ( !self iscodcaster() )
    {
        winner = tempwinner;
    }
    
    if ( game_utility::getgametype() == "arena" || isbrgamemode() || game_utility::getgametype() == "arm" || game_utility::getgametype() == "conflict" || game_utility::getgametype() == "siege" || game_utility_mp::getbasegametype() == "control" )
    {
        if ( isdefined( endreasontextloss ) )
        {
            if ( isdefined( self.pers[ "team" ] ) && winner == team )
            {
                endreasontext = endreasontext;
            }
            else
            {
                endreasontext = endreasontextloss;
            }
        }
    }
    else if ( game_utility_mp::inovertime() && game_utility_mp::waslastround() && game_utility_mp::istimetobeatrulegametype() )
    {
        if ( game_utility::getgametype() == "ctf" )
        {
            if ( isdefined( self.pers[ "team" ] ) && winner == team )
            {
                endreasontext = game[ "end_reason" ][ "time_to_beat_ctf_win" ];
            }
            else if ( isdefined( self.pers[ "team" ] ) && winner == team_utility::getotherteam( self.pers[ "team" ] ) )
            {
                endreasontext = game[ "end_reason" ][ "time_to_beat_ctf_loss" ];
            }
        }
        else if ( gametype == "sabattack" )
        {
            if ( isdefined( self.pers[ "team" ] ) && game[ "timeToBeatTeam" ] == "none" )
            {
                endreasontext = game[ "end_reason" ][ "time_to_beat_sabattack_loss" ];
            }
            else if ( isdefined( self.pers[ "team" ] ) && winner == team )
            {
                endreasontext = game[ "end_reason" ][ "time_to_beat_sabattack_win" ];
            }
            else if ( isdefined( self.pers[ "team" ] ) && winner == team_utility::getotherteam( self.pers[ "team" ] ) )
            {
                endreasontext = game[ "end_reason" ][ "time_to_beat_sabattack_loss" ];
            }
            
            if ( self iscodcaster() && game[ "timeToBeatTeam" ] == "none" )
            {
                winner = game[ "timeToBeatTeam" ];
                endreasontext = game[ "end_reason" ][ "time_to_beat_sabattack_win" ];
            }
        }
    }
    else if ( isdefined( endreasontextloss ) )
    {
        if ( isdefined( self.pers[ "team" ] ) && winner == team )
        {
            endreasontext = endreasontext;
        }
        else
        {
            endreasontext = endreasontextloss;
        }
    }
    
    if ( !isdefined( endreasontext ) )
    {
        endreasontext = 1;
    }
    
    if ( self iscodcaster() )
    {
        if ( isdefined( game[ "end_reason_mlg_mapping" ][ endreasontext ] ) )
        {
            endreasontext = game[ "end_reason_mlg_mapping" ][ endreasontext ];
        }
    }
    
    if ( endreasontext == game[ "end_reason" ][ "switching_sides" ] )
    {
        self setclientomnvar( o"ui_round_end_reason", 0 );
    }
    else
    {
        self setclientomnvar( o"ui_round_end_reason", endreasontext );
    }
    
    if ( winner == "axis" )
    {
        self setclientomnvar( o"ui_round_end_winner", 1 );
    }
    else if ( winner == "allies" )
    {
        self setclientomnvar( o"ui_round_end_winner", 2 );
    }
    else
    {
        self setclientomnvar( o"ui_round_end_winner", 0 );
    }
    
    if ( level.gametypebundle.scoringstrategy == #"teamscores" || level.gametypebundle.scoringstrategy == #"teamhealth" )
    {
        friendlyscore = gamescore::getteamscore( team );
        
        if ( friendlyscore > 16000 )
        {
            friendlyscore = 16000;
        }
        
        enemyscore = gamescore::getteamscore( team_utility::getotherteam( team ) );
        
        if ( enemyscore > 16000 )
        {
            enemyscore = 16000;
        }
        
        self setclientomnvar( o"ui_round_end_friendly_score", friendlyscore, 1 );
        self setclientomnvar( o"ui_round_end_enemy_score", enemyscore, 1 );
    }
    else
    {
        self setclientomnvar( o"ui_round_end_friendly_score", game[ "roundsWon" ][ team ], 1 );
        enemyteam = team_utility::getotherteam( team );
        enemyscore = game[ "roundsWon" ][ enemyteam ] ?? 0;
        self setclientomnvar( o"ui_round_end_enemy_score", enemyscore, 1 );
    }
    
    if ( isdefined( self.matchbonus ) )
    {
        self setclientomnvar( o"ui_round_end_match_bonus", self.matchbonus, 1 );
    }
}

// Namespace hud_message
// Params 4
// Checksum 0x361c9225, Offset: 0x3e9a
// Size: 0x3e0
function outcomenotify( winner, isround, endreasontext, endreasontextloss )
{
    self endon( #"disconnect" );
    players = level.placement[ "all" ];
    firstplace = players[ 0 ];
    secondplace = players[ 1 ];
    thirdplace = players[ 2 ];
    var_85fb5c0f0a81b53b = level.players.size > 3;
    
    if ( isstring( winner ) && winner == "next_round" )
    {
        self setclientomnvar( o"ui_round_end_title", game[ "round_end" ][ "next_round" ] );
        self setclientomnvar( o"ui_round_end_reason", endreasontext );
    }
    else if ( isdefined( level.var_29c1e82ec1325523 ) )
    {
        if ( [[ level.var_29c1e82ec1325523 ]]( self ) )
        {
            if ( isround && !game_utility_mp::waslastround() )
            {
                self setclientomnvar( o"ui_round_end_title", game[ "round_end" ][ "victory" ] );
            }
            else
            {
                function_831670a7cf321d( game[ "round_end" ][ "victory" ] );
            }
            
            self setclientomnvar( o"ui_round_end_reason", endreasontext );
        }
        else
        {
            if ( isround && !game_utility_mp::waslastround() )
            {
                self setclientomnvar( o"ui_round_end_title", game[ "round_end" ][ "defeat" ] );
            }
            else
            {
                function_831670a7cf321d( game[ "round_end" ][ "defeat" ] );
            }
            
            self setclientomnvar( o"ui_round_end_reason", endreasontextloss ?? endreasontext );
        }
    }
    else if ( isstring( winner ) && winner == "tie" )
    {
        if ( isdefined( firstplace ) && gamescore::getplayerscore( firstplace ) == gamescore::getplayerscore( self ) )
        {
            self setclientomnvar( o"ui_round_end_title", game[ "round_end" ][ "tie" ] );
            self setclientomnvar( o"ui_round_end_reason", endreasontext );
            function_831670a7cf321d( game[ "round_end" ][ "draw" ] );
        }
        else if ( self == firstplace || self == secondplace || self == thirdplace )
        {
            self setclientomnvar( o"ui_round_end_title", game[ "round_end" ][ "tie" ] );
            self setclientomnvar( o"ui_round_end_reason", endreasontext );
            function_831670a7cf321d( game[ "round_end" ][ "draw" ] );
        }
        else
        {
            self setclientomnvar( o"ui_round_end_title", game[ "round_end" ][ "defeat" ] );
            self setclientomnvar( o"ui_round_end_reason", endreasontextloss ?? endreasontext );
            function_831670a7cf321d( game[ "round_end" ][ "defeat" ] );
        }
    }
    else if ( isstring( winner ) && winner == "bye_round" )
    {
        self setclientomnvar( o"ui_round_end_title", game[ "round_end" ][ "bye_round" ] );
        self setclientomnvar( o"ui_round_end_reason", endreasontext );
        function_831670a7cf321d( game[ "round_end" ][ "draw" ] );
    }
    else if ( self == firstplace || var_85fb5c0f0a81b53b && ( self == secondplace || self == thirdplace ) )
    {
        self setclientomnvar( o"ui_round_end_title", game[ "round_end" ][ "victory" ] );
        self setclientomnvar( o"ui_round_end_reason", endreasontext );
        function_831670a7cf321d( game[ "round_end" ][ "victory" ] );
    }
    else
    {
        self setclientomnvar( o"ui_round_end_title", game[ "round_end" ][ "defeat" ] );
        self setclientomnvar( o"ui_round_end_reason", endreasontextloss ?? endreasontext );
        function_831670a7cf321d( game[ "round_end" ][ "defeat" ] );
    }
    
    if ( isdefined( self.matchbonus ) )
    {
        self setclientomnvar( o"ui_round_end_match_bonus", self.matchbonus, 1 );
    }
}

// Namespace hud_message
// Params 0
// Checksum 0x9d30fea2, Offset: 0x4282
// Size: 0x69
function getsplashtablename()
{
    if ( isdefined( level.gamemodebundle ) && isdefined( level.gamemodebundle.splashtable ) && level.gamemodebundle.splashtable != "" )
    {
        return level.gamemodebundle.splashtable;
    }
    
    return getdvar( @"splash_table_name", "mp/splashTable.csv" );
}

// Namespace hud_message
// Params 0
// Checksum 0x8c15d5cb, Offset: 0x42f4
// Size: 0x4
function getsplashtablemaxaltdisplays()
{
    return 5;
}

// Namespace hud_message
// Params 0
// Checksum 0x65ba17e, Offset: 0x4301
// Size: 0x78
function cleanuplocalplayersplashlist()
{
    self endon( #"disconnect" );
    self notify( #"hash_56f2ef3312aaabb7" );
    self endon( #"hash_56f2ef3312aaabb7" );
    utility::waittill_notify_or_timeout( "death", 0.5 );
    
    while ( isdefined( self ) && !player::isreallyalive( self ) && !self iscodcaster() )
    {
        wait 0.15;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.recentsplashcount = undefined;
    self notify( #"splash_list_cleared" );
}

// Namespace hud_message
// Params 2
// Checksum 0x3544759f, Offset: 0x4381
// Size: 0x21
function splashshowncallback( channel, splashindex )
{
    if ( channel != "splash_shown" )
    {
        return;
    }
}

// Namespace hud_message
// Params 1
// Checksum 0xaf1d1ba4, Offset: 0x43aa
// Size: 0x1f
function onkillstreaksplashshown( splashref )
{
    killstreak_utility::playkillstreakteamleaderdialog( splashref, splashref );
    thread checkforspecialistbonusvo( splashref );
}

// Namespace hud_message
// Params 1
// Checksum 0xd8a40f4, Offset: 0x43d1
// Size: 0x2f
function checkforspecialistbonusvo( splashref )
{
    if ( splashref == "specialist_perk_bonus" )
    {
        wait 2;
        level thread battlechatter_mp::trysaylocalsound( self, #"bc_flavor_player_positive" );
    }
}

// Namespace hud_message
// Params 0
// Checksum 0x11a47c64, Offset: 0x4408
// Size: 0xf6
function function_f618be077131ab21()
{
    /#
        if ( !( isdefined( level.gamemodebundle.errormessagelist ) && isdefined( getscriptbundle( level.gamemodebundle.errormessagelist ) ) ) )
        {
            assertmsg( "<dev string:x18c>" );
        }
    #/
    
    var_f5e03cad1318715b = getscriptbundle( level.gamemodebundle.errormessagelist );
    errorlist = var_f5e03cad1318715b.list;
    
    for ( i = 0; i < errorlist.size ; i++ )
    {
        if ( isdefined( errorlist[ i ].var_e90bab54d8b275e5 ) )
        {
            messagexhash = getscriptbundle( errorlist[ i ].var_e90bab54d8b275e5 ).message;
            level.errormessagelist[ errorlist[ i ].var_e90bab54d8b275e5 ] = i;
            level.errormessagelist[ messagexhash ] = i;
        }
    }
}

// Namespace hud_message
// Params 3
// Checksum 0x878cb5a0, Offset: 0x4506
// Size: 0x13f
function showerrormessage( var_9a315d238a685e49, optionalparam, var_796e0094adcfbcf7 )
{
    if ( !isxhashasset( var_9a315d238a685e49 ) )
    {
        var_f6dc67943cde939b = getxhashasset( var_9a315d238a685e49 );
    }
    else
    {
        var_f6dc67943cde939b = var_9a315d238a685e49;
    }
    
    index = level.errormessagelist[ var_f6dc67943cde939b ];
    
    if ( !isdefined( index ) )
    {
        assertmsg( "<dev string:x1e0>" + getxhashsourcename( var_9a315d238a685e49 ) + "<dev string:x1f1>" );
        return;
    }
    
    if ( self.var_a78e28db5644a8e9 > gettime() )
    {
        return;
    }
    
    if ( isdefined( optionalparam ) )
    {
        self setclientomnvar( o"hash_9346f87ba14b74f4", optionalparam );
    }
    else
    {
        self setclientomnvar( o"hash_9346f87ba14b74f4", -1 );
    }
    
    if ( isdefined( index ) )
    {
        self setclientomnvar( o"hash_772e2976d0ae0a96", index );
    }
    
    if ( !isdefined( self.errormessagebitflipper ) )
    {
        self.errormessagebitflipper = 0;
    }
    
    self.errormessagebitflipper = !self.errormessagebitflipper;
    self setclientomnvar( o"hash_a5927f55539d17", self.errormessagebitflipper ? 2 : 1 );
    
    if ( isdefined( var_796e0094adcfbcf7 ) )
    {
        self.var_a78e28db5644a8e9 = gettime() + var_796e0094adcfbcf7 * 1000;
        return;
    }
    
    self.var_a78e28db5644a8e9 = undefined;
}

// Namespace hud_message
// Params 2
// Checksum 0xca0fecc0, Offset: 0x464d
// Size: 0x90
function showerrormessagetoallplayers( var_9a315d238a685e49, optionalparam )
{
    foreach ( player in level.players )
    {
        player showerrormessage( var_9a315d238a685e49, optionalparam );
    }
}

// Namespace hud_message
// Params 1
// Checksum 0x19448e8b, Offset: 0x46e5
// Size: 0x41, Type: bool
function testmiscmessage( messageref )
{
    messageindex = function_43b5ed5a14a56573( #"hash_63e25d4efbac14aa", messageref );
    assert( isdefined( messageindex ), "<dev string:x251>" + getxhashsourcename( messageref ) );
    return isdefined( messageindex );
}

// Namespace hud_message
// Params 1
// Checksum 0xb383b69, Offset: 0x472f
// Size: 0x61
function showmiscmessage( messageref )
{
    messageindex = function_43b5ed5a14a56573( #"hash_63e25d4efbac14aa", messageref );
    assert( messageindex >= 0, "<dev string:x251>" + getxhashsourcename( messageref ) );
    self setclientomnvar( o"ui_misc_message_id", messageindex );
    self setclientomnvar( o"ui_misc_message_trigger", 1 );
}

// Namespace hud_message
// Params 0
// Checksum 0xbee2baf2, Offset: 0x4798
// Size: 0x196
function eventsplashesthink()
{
    self endon( #"disconnect" );
    
    if ( !game_utility_mp::matchmakinggame() )
    {
        return;
    }
    
    var_3471cf5e01b6863f = 0;
    
    if ( !isdefined( self.pers[ "hasSpawned" ] ) )
    {
        var_3471cf5e01b6863f = 1;
    }
    
    self waittill( #"loadout_class_selected" );
    var_aaae813aef8a04f0 = 0;
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level flags::gameflagwait( "prematch_done" );
        var_aaae813aef8a04f0 = 1;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    var_17bc5d48f828b2c0 = self getprivatepartysize() > 1;
    
    if ( var_3471cf5e01b6863f )
    {
        if ( var_aaae813aef8a04f0 )
        {
            wait 2;
        }
        
        if ( game_utility::function_c6e89e9bd38dba2c() == 2 || var_17bc5d48f828b2c0 && getdvarint( @"online_mp_party_xpscale" ) == 2 || self function_787b88bd6601ec4a() && getdvarfloat( @"hash_10f733902fb6e20" ) == 2 )
        {
            showsplash( "event_double_xp", undefined, self );
        }
        
        if ( game_utility::function_52f600c9a675164c() == 2 || var_17bc5d48f828b2c0 && getdvarint( @"online_mp_party_weapon_xpscale" ) == 2 )
        {
            showsplash( "event_double_weapon_xp", undefined, self );
        }
        
        if ( game_utility::function_846dc4e6907bc44b() == 2 )
        {
            showsplash( "event_double_battle_xp", undefined, self );
        }
        
        if ( getdvarint( @"online_double_keys" ) > 0 )
        {
            showsplash( "event_double_keys", undefined, self );
        }
        
        if ( getdvarint( @"online_mp_missionteam_xpscale" ) == 2 || var_17bc5d48f828b2c0 && getdvarint( @"online_mp_party_missionteam_xpscale" ) == 2 )
        {
            showsplash( "event_double_xp_teams", undefined, self );
        }
    }
}

// Namespace hud_message
// Params 7
// Checksum 0x4e7b0bd4, Offset: 0x4936
// Size: 0x167
function notifyteam( friendlystring, enemystring, friendlyteam, skipplayers, var_db7bc0c2a6467656, var_db88dec2a654ccd5, playerforplayercard )
{
    foreach ( player in level.players )
    {
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        if ( !team_utility::isgameplayteam( player.team ) )
        {
            continue;
        }
        
        if ( player.team == friendlyteam )
        {
            if ( !hud_util::canshowsplash( friendlystring ) )
            {
                continue;
            }
            
            if ( isdefined( skipplayers ) )
            {
                if ( !arraycontains( skipplayers, player ) )
                {
                    player thread showsplash( friendlystring, var_db7bc0c2a6467656, playerforplayercard );
                }
            }
            else
            {
                player thread showsplash( friendlystring, var_db7bc0c2a6467656, playerforplayercard );
            }
            
            continue;
        }
        
        if ( !hud_util::canshowsplash( enemystring ) )
        {
            continue;
        }
        
        if ( isdefined( skipplayers ) )
        {
            if ( !arraycontains( skipplayers, player ) )
            {
                player thread showsplash( enemystring, var_db88dec2a654ccd5, playerforplayercard );
            }
            
            continue;
        }
        
        player thread showsplash( enemystring, var_db88dec2a654ccd5, playerforplayercard );
    }
}

// Namespace hud_message
// Params 0
// Checksum 0xd268e387, Offset: 0x4aa5
// Size: 0x8b
function function_49762958460c302b()
{
    var_4eccca31ce7d6d3 = level.gametypebundle.matchstatuslist;
    var_a4691a5067ec2959 = getscriptbundle( var_4eccca31ce7d6d3 );
    matchstatuslist = var_a4691a5067ec2959.list;
    
    for ( i = 0; i < matchstatuslist.size ; i++ )
    {
        var_efcbef98efb5e5d = matchstatuslist[ i ].ref;
        
        if ( isdefined( var_efcbef98efb5e5d ) )
        {
            level.var_24cb2bcc83f7ac12[ var_efcbef98efb5e5d ] = i;
        }
    }
}

// Namespace hud_message
// Params 1
// Checksum 0x7bfdae78, Offset: 0x4b38
// Size: 0x48
function function_a87f62656f96a4a9( ref )
{
    if ( !isxhash( ref ) )
    {
        ref = getxhash( ref );
    }
    
    omnvarvalue = level.var_24cb2bcc83f7ac12[ ref ];
    assert( isdefined( omnvarvalue ), "<dev string:x297>" );
    return omnvarvalue;
}

// Namespace hud_message
// Params 1
// Checksum 0x17c9b3e9, Offset: 0x4b89
// Size: 0x23
function function_ef4318a0090caa0f( ref )
{
    self setclientomnvar( o"ui_match_status_hint_text", function_a87f62656f96a4a9( ref ) );
}

// Namespace hud_message
// Params 5
// Checksum 0x62966bd, Offset: 0x4bb4
// Size: 0xfa
function updatematchstatushintforallplayers( friendlyteam, friendlyhint, enemyhint, specplayer, var_f973b44d2af49b4d )
{
    level notify( #"updatehint" );
    level endon( #"updatehint" );
    
    foreach ( player in level.players )
    {
        if ( player.team == friendlyteam )
        {
            if ( player == specplayer )
            {
                player function_ef4318a0090caa0f( var_f973b44d2af49b4d );
            }
            else
            {
                player function_ef4318a0090caa0f( friendlyhint );
            }
            
            continue;
        }
        
        if ( isdefined( enemyhint ) )
        {
            player function_ef4318a0090caa0f( enemyhint );
        }
    }
}

// Namespace hud_message
// Params 2
// Checksum 0x34f38088, Offset: 0x4cb6
// Size: 0x32
function function_caacf001c8e4e6e7( enabled, lockedtimer )
{
    if ( !isdefined( enabled ) )
    {
        return;
    }
    
    setomnvar( "ui_status_locked", enabled );
    function_dbd5cf482ed06ea0( lockedtimer );
}

// Namespace hud_message
// Params 1
// Checksum 0xfd27f76, Offset: 0x4cf0
// Size: 0x42
function function_dbd5cf482ed06ea0( time )
{
    if ( !isdefined( time ) )
    {
        return;
    }
    
    if ( time > 0 )
    {
        setomnvar( "ui_status_time", int( gettime() + time * 1000 ) );
        return;
    }
    
    setomnvar( "ui_status_time", 0 );
}

// Namespace hud_message
// Params 1
// Checksum 0x8964a696, Offset: 0x4d3a
// Size: 0xa9
function function_fc3ef76206896f0e( team )
{
    if ( !isdefined( team ) )
    {
        return;
    }
    
    teamindex = 0;
    
    foreach ( index, teamname in level.allteamnamelist )
    {
        if ( team == teamname )
        {
            teamindex = index;
            break;
        }
    }
    
    setomnvar( "ui_winning_team", teamindex );
}

// Namespace hud_message
// Params 0
// Checksum 0xc59e66f1, Offset: 0x4deb
// Size: 0xeb
function function_e369cd82a03687e0()
{
    foreach ( team in level.teamnamelist )
    {
        if ( level.multimatch ?? gameinstance::is_enabled() )
        {
            if ( game[ "eliminated" ][ team ] )
            {
                continue;
            }
        }
        
        function_4ae6dc6399083782( team, 0 );
        function_f0f1321dff1da53a( team, 100 );
    }
    
    callback::add( #"player_connect", &function_9bb9a44a84f40ff9 );
    callback::add( #"player_disconnect", &function_9b51c983b91866ab );
    callback::add( #"player_spawned", &function_92bb85021000111e );
}

// Namespace hud_message
// Params 1
// Checksum 0x98731e4e, Offset: 0x4ede
// Size: 0x39
function function_9bb9a44a84f40ff9( params )
{
    self setplayerdata( level.var_6f9b00680ed002d8, "aarData", "matchResult", game[ "round_end" ][ "draw" ] );
    thread function_cdb39dc59487cee0();
}

// Namespace hud_message
// Params 0
// Checksum 0xa4187823, Offset: 0x4f1f
// Size: 0x47
function function_cdb39dc59487cee0()
{
    level endon( #"game_ended" );
    
    while ( !isdefined( self.team ) )
    {
        waitframe();
    }
    
    function_32921bf72811da6e();
    
    while ( true )
    {
        utility::waittill_any( "joined_team", "joined_spectators" );
        function_32921bf72811da6e();
    }
}

// Namespace hud_message
// Params 1
// Checksum 0x4bfba202, Offset: 0x4f6e
// Size: 0x15
function function_9b51c983b91866ab( params )
{
    function_32921bf72811da6e( 1 );
}

// Namespace hud_message
// Params 1
// Checksum 0x87048099, Offset: 0x4f8b
// Size: 0x13
function function_92bb85021000111e( params )
{
    thread function_c3100eac8367f6a9();
}

// Namespace hud_message
// Params 0
// Checksum 0xb403c35b, Offset: 0x4fa6
// Size: 0x102
function function_c3100eac8367f6a9()
{
    self notify( #"hash_dfd3548992b59d9e" );
    self endon( #"hash_dfd3548992b59d9e" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        playerhealth::function_284cd76924b8c5ae( self );
        totalhealth = 0;
        
        foreach ( player in teams::getteamdata( self.team, "players" ) )
        {
            if ( player::isaliveandnotinlaststand( player ) )
            {
                totalhealth += player.health;
            }
        }
        
        totalhealth = int( max( 0, totalhealth ) );
        function_4ae6dc6399083782( self.team, totalhealth );
    }
}

// Namespace hud_message
// Params 1
// Checksum 0xac5d4c85, Offset: 0x50b0
// Size: 0x1af
function function_32921bf72811da6e( isdisconnect )
{
    var_3b607a0b80beb1c4 = getmatchrulesdata( "commonOption", "maxHealth" );
    
    foreach ( team in level.teamnamelist )
    {
        teamcount = teams::getteamdata( team, "teamCount" );
        
        if ( teamcount <= 0 )
        {
            function_4ae6dc6399083782( team, 0 );
            continue;
        }
        
        teammaxhealth = teamcount * var_3b607a0b80beb1c4;
        function_f0f1321dff1da53a( team, teammaxhealth );
        
        if ( !isdisconnect && !player::isaliveandnotinlaststand( self ) && playerlogic::mayspawn() )
        {
            self waittill( #"spawned_player" );
        }
        
        var_a6513b89dda8e099 = 0;
        
        foreach ( player in teams::getteamdata( team, "players" ) )
        {
            if ( player::isaliveandnotinlaststand( player ) )
            {
                var_a6513b89dda8e099 += player.health;
            }
        }
        
        var_a6513b89dda8e099 = int( max( 0, var_a6513b89dda8e099 ) );
        function_4ae6dc6399083782( team, var_a6513b89dda8e099 );
    }
}

// Namespace hud_message
// Params 2, eflags: 0x4
// Checksum 0x7082da12, Offset: 0x5267
// Size: 0x143
function private function_4ae6dc6399083782( teamname, value )
{
    if ( !team_utility::isgameplayteam( teamname ) )
    {
        assertmsg( "<dev string:x2eb>" + teamname + "<dev string:x2ff>" );
        return;
    }
    
    setomnvar( "ui_arena_" + teamname + "_health", int( value ) );
    level notify( #"hash_38603932c3d6f61b", teamname, int( value ) );
    
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        if ( game[ "eliminated" ][ teamname ] )
        {
            return;
        }
    }
    
    participantplayers = game_utility_mp::function_4b15b7eb1dc364e7( teamname );
    
    foreach ( player in participantplayers )
    {
        if ( player.team == teamname )
        {
            player setclientomnvar( o"ui_arena_friendly_health", int( value ) );
            continue;
        }
        
        player setclientomnvar( o"ui_arena_enemy_health", int( value ) );
    }
}

// Namespace hud_message
// Params 2, eflags: 0x4
// Checksum 0x7d24248d, Offset: 0x53b2
// Size: 0x143
function private function_f0f1321dff1da53a( teamname, value )
{
    if ( !team_utility::isgameplayteam( teamname ) )
    {
        assertmsg( "<dev string:x2eb>" + teamname + "<dev string:x2ff>" );
        return;
    }
    
    setomnvar( "ui_arena_" + teamname + "_health_max", int( value ) );
    level notify( #"hash_1e42db9be7eb6b3c", teamname, int( value ) );
    
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        if ( game[ "eliminated" ][ teamname ] )
        {
            return;
        }
    }
    
    participantplayers = game_utility_mp::function_4b15b7eb1dc364e7( teamname );
    
    foreach ( player in participantplayers )
    {
        if ( player.team == teamname )
        {
            player setclientomnvar( o"ui_arena_friendly_health_max", int( value ) );
            continue;
        }
        
        player setclientomnvar( o"ui_arena_enemy_health_max", int( value ) );
    }
}

// Namespace hud_message
// Params 0, eflags: 0x4
// Checksum 0x63281af0, Offset: 0x54fd
// Size: 0x37, Type: bool
function private function_812489dec937e6ce()
{
    return level.var_58cdd295b0c5dafa || level.gametypebundle.disablesplashes || getdvarint( @"hash_aacc4977e4ea1009", 1 ) == 0;
}

/#

    // Namespace hud_message
    // Params 0, eflags: 0x4
    // Checksum 0xe43cd24c, Offset: 0x553d
    // Size: 0x20a, Type: dev
    function private init_splash_devgui()
    {
        var_633b95f115bcc581 = [];
        
        foreach ( splashlistname in [ level.gametypebundle.var_e662dd7f27d462eb, level.gametypebundle.splashlist ?? level.gamemodebundle.splashlist ] )
        {
            splashlist = function_359ed87eadfb6858( splashlistname );
            
            if ( !isdefined( splashlist ) )
            {
                continue;
            }
            
            foreach ( splash in splashlist.splash_list )
            {
                var_633b95f115bcc581[ var_633b95f115bcc581.size ] = { #splashlistname:splashlistname, #refstring:getxhashsourcename( splash.ref ) };
            }
        }
        
        rootcategory = { #subcategories:[], #var_633b95f115bcc581:[] };
        
        foreach ( splash in var_633b95f115bcc581 )
        {
            rootcategory function_6de0af04dc44e23( 0, splash );
        }
        
        rootcategory function_2279526324c1ae7d( "<dev string:x301>" );
    }

    // Namespace hud_message
    // Params 2, eflags: 0x4
    // Checksum 0x8af600b7, Offset: 0x574f
    // Size: 0x134, Type: dev
    function private function_6de0af04dc44e23( var_d31f0d4f00dc5b64, splash )
    {
        category = self;
        prefix = strtok( splash.refstring, "<dev string:x30e>" )[ var_d31f0d4f00dc5b64 ];
        
        if ( prefix === undefined )
        {
            if ( category.var_633b95f115bcc581[ "<dev string:x310>" ] )
            {
                return;
            }
            
            category.var_633b95f115bcc581[ "<dev string:x310>" ] = splash;
            return;
        }
        
        if ( category.subcategories[ prefix ] )
        {
            category.subcategories[ prefix ] function_6de0af04dc44e23( var_d31f0d4f00dc5b64 + 1, splash );
            return;
        }
        
        if ( category.var_633b95f115bcc581[ prefix ] )
        {
            subcategory = { #subcategories:[], #var_633b95f115bcc581:[] };
            category.subcategories[ prefix ] = subcategory;
            subcategory function_6de0af04dc44e23( var_d31f0d4f00dc5b64 + 1, category.var_633b95f115bcc581[ prefix ] );
            category.var_633b95f115bcc581[ prefix ] = undefined;
            subcategory function_6de0af04dc44e23( var_d31f0d4f00dc5b64 + 1, splash );
            return;
        }
        
        category.var_633b95f115bcc581[ prefix ] = splash;
    }

    // Namespace hud_message
    // Params 1, eflags: 0x4
    // Checksum 0x7d1993fc, Offset: 0x588b
    // Size: 0x183, Type: dev
    function private function_2279526324c1ae7d( path )
    {
        category = self;
        devgui::function_9082edeb5db93280( path );
        
        foreach ( splash in category.var_633b95f115bcc581 )
        {
            devgui::function_cd4e263c1f3018ae( splash.refstring, "<dev string:x311>" + splash.refstring + "<dev string:x319>" + getxhashsourcename( splash.splashlistname ), &devgui_show_splash );
        }
        
        devgui::function_77df7fe7dd273e10();
        separator = category.subcategories.size == 1 ? "<dev string:x30e>" : "<dev string:x31b>";
        
        foreach ( prefix, subcategory in category.subcategories )
        {
            subcategory function_2279526324c1ae7d( path + prefix + separator );
        }
    }

    // Namespace hud_message
    // Params 1, eflags: 0x4
    // Checksum 0x59df2262, Offset: 0x5a16
    // Size: 0xb8, Type: dev
    function private devgui_show_splash( params )
    {
        splashref = params[ 0 ];
        splashlistname = params[ 1 ];
        
        if ( !isdefined( splashref ) )
        {
            return;
        }
        
        foreach ( player in level.players )
        {
            if ( isdefined( player ) )
            {
                player function_78fedf6f526825f4( splashref, getxhashasset( splashlistname ) );
            }
        }
    }

    // Namespace hud_message
    // Params 1, eflags: 0x4
    // Checksum 0xc0b507f8, Offset: 0x5ad6
    // Size: 0x40, Type: dev
    function private function_359ed87eadfb6858( splashlistname )
    {
        if ( !isdefined( splashlistname ) )
        {
            return;
        }
        
        if ( isxhashasset( splashlistname ) )
        {
            splashlist = getscriptbundle( splashlistname );
        }
        else
        {
            splashlist = getscriptbundle( splashlistname );
        }
        
        return splashlist;
    }

    // Namespace hud_message
    // Params 0, eflags: 0x4
    // Checksum 0x58211784, Offset: 0x5b1e
    // Size: 0x5a, Type: dev
    function private function_93868c409751ae04()
    {
        devgui::function_9082edeb5db93280( "<dev string:x31d>" );
        devgui::add_devgui_func( "<dev string:x33b>", "<dev string:x344>", &function_f495904acb6516fd );
        devgui::add_devgui_func( "<dev string:x365>", "<dev string:x36e>", &function_20c329cf29af76d8 );
        devgui::add_devgui_func( "<dev string:x38f>", "<dev string:x396>", &function_c611728e6f121acf );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace hud_message
    // Params 1, eflags: 0x4
    // Checksum 0xd8d640d8, Offset: 0x5b80
    // Size: 0x5e, Type: dev
    function private function_1f8ece966c81d35d( var_4f000cc92b630e28 )
    {
        player = level.players[ 0 ];
        
        for ( i = 0; i < var_4f000cc92b630e28.size ; i++ )
        {
            player thread showsplash( var_4f000cc92b630e28[ i ], undefined, undefined, undefined, level.var_af0045e470655ee );
            wait 1;
        }
    }

    // Namespace hud_message
    // Params 0, eflags: 0x4
    // Checksum 0x887e5b79, Offset: 0x5be6
    // Size: 0x5c, Type: dev
    function private function_f495904acb6516fd()
    {
        standardevents = [ #"double", #"triple", #"streak_5", #"streak_10", #"streak_15" ];
        function_1f8ece966c81d35d( standardevents );
    }

    // Namespace hud_message
    // Params 0, eflags: 0x4
    // Checksum 0x40062383, Offset: 0x5c4a
    // Size: 0x28, Type: dev
    function private function_20c329cf29af76d8()
    {
        elevatedevents = [ #"firstblood" ];
        function_1f8ece966c81d35d( elevatedevents );
    }

    // Namespace hud_message
    // Params 0, eflags: 0x4
    // Checksum 0xc18bd3f7, Offset: 0x5c7a
    // Size: 0x42, Type: dev
    function private function_c611728e6f121acf()
    {
        uniqueevents = [ #"driver_kill", #"revenge_execute", #"super_longshot" ];
        function_1f8ece966c81d35d( uniqueevents );
    }

#/
