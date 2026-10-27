// scripts\mp\telemetry_mp.gsc  (hash_45f403e1732217d3.gscc) (size: 112523 Bytes / 0x1b78b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x82e40702 (2195982082)
// size ...... 112523 (0x1b78b)
// includes .. 36  (offset: 0x17acf)
// strings ... 913 (offset: 0x17bef)
// dev strs .. 23  (offset: 0x1b60f)
// exports ... 88  (offset: 0x14767)
// cseg ...... 0x4b63 + 0xfc04 (0x14767)
// imports ... 270 (offset: 0x15527)
// animtree1 . 0   (offset: 0x1b78b)
// animtree2 . 0   (offset: 0x1b78b)
#using script_16ea1b94f0f381b3;
#using script_7cab86232cdd30ba;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\game_utility;
#using scripts\common\progression_utility;
#using scripts\common\script;
#using scripts\common\telemetry;
#using scripts\common\telemetry_utils;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\class;
#using scripts\mp\common\killstreaks\uav;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\dmz\telemetry_dmz;
#using scripts\mp\equipment;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\operator;
#using scripts\mp\persistence;
#using scripts\mp\playerstats_interface;
#using scripts\mp\rank;
#using scripts\mp\supers;
#using scripts\mp\telemetry_utils;
#using scripts\mp\weaponrank;
#using scripts\mp\weapons;

#namespace telemetry_mp;

// Namespace telemetry_mp
// Params 0
// Checksum 0x4a8e21b3, Offset: 0x4b81
// Size: 0x259
function init()
{
    telemetry_utils::function_5995f9c2ef729dbd( "callback_match_start", &on_match_start );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_match_end", &on_match_end );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_round_start", &on_round_start );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_round_end", &on_round_end );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_server_exit_level", &function_f8ac77476d140859 );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_server_post_exit_level", &function_1225d74b02c47ba );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_on_player_first_connect", &on_player_connect );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_on_player_spawned", &on_player_spawned );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_player_death", &on_player_death );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_on_player_disconnect", &on_player_disconnect );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_player_new_loadout_used", &function_73fbc313c1652179 );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_update_weapon_stats", &update_weapon_stats );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_player_score_event", &on_player_score_event );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_on_game_event", &on_game_event );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_on_player_armor_auto_apply", &on_player_armor_auto_apply );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_on_reload_cancel", &on_reload_cancel );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_operator_vo", &function_5b217bffe8d1fa92 );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_dmz_on_exfil", &dmz_on_exfil );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_dmz_on_reinforce", &dmz_on_reinforce );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_dmz_on_lpcon_alert", &function_36adeffaa952e72 );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_dmz_on_container", &dmz_on_container );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_dmz_contract", &dmz_contract );
    telemetry_utils::function_5995f9c2ef729dbd( #"dmz_xp_gained", &function_c5eca3da8c74bf06 );
    telemetry_utils::function_5995f9c2ef729dbd( #"hash_751cd4a063920b00", &function_1f4211e0341b8ce );
    telemetry_utils::function_5995f9c2ef729dbd( "currency_pickup", &function_1f4211e0341b8ce );
    telemetry_utils::function_5995f9c2ef729dbd( "loot_drop_on_death", &function_49f54e00529f2bf6 );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_the_hunt_eom", &function_c1db69208074fca9 );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_countdown_eom", &function_ff3a9866a9f1757d );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_example", &function_ccaa57587d66e80a );
    level callback::add( #"on_ai_killed", &on_ai_killed );
    
    if ( !isdefined( level.mp_ai_killed_telemetry_throttle ) )
    {
        level.mp_ai_killed_telemetry_throttle = throttle::throttle_initialize( "mp_ai_killed_telemetry_throttle", 1, level.framedurationseconds );
    }
    
    setdvarifuninitialized( @"hash_817f686503ccdecf", 15 );
    telemetry_utils::function_5995f9c2ef729dbd( "callback_bots_set_proportion", &function_ef10df305126b130 );
}

// Namespace telemetry_mp
// Params 0
// Checksum 0xfb223c18, Offset: 0x4de2
// Size: 0x3da
function on_match_start()
{
    level callback::add( #"player_death", &on_player_death_end_match );
    level callback::add( #"on_contract_start", &function_17f67c882fe2f6c );
    level callback::add( #"player_vehicle_enter", &on_vehicle_enter );
    level callback::add( #"hash_42a07c459e05796d", &function_5bd3b4eeec2f3204 );
    level callback::add( "currency_pickup", &on_plunder_pickup );
    utc_start_time_s = getmatchdata( "commonMatchData", "utc_start_time_s" ) ?? 0;
    
    if ( utc_start_time_s == 0 )
    {
        utc_start_time_s = getsystemtime();
        setmatchdata( "commonMatchData", "utc_start_time_s", utc_start_time_s );
        assert( utc_start_time_s > 0, "<dev string:x24>" );
    }
    else
    {
        assert( utc_start_time_s > 0, "<dev string:x24>" );
    }
    
    if ( isdefined( game[ "telemetry" ] ) )
    {
        game[ "telemetry" ].utc_start_time_s = utc_start_time_s;
    }
    
    setmatchdata( "commonMatchData", "player_count_start", level.players.size );
    game_type = game_utility::getgametype();
    game_type_variant = game_utility::function_e9de4eeab29754c3();
    game_mode_key = function_22c2831dc71d262();
    playlist_id = 0;
    playlist_name = "";
    
    if ( game_utility_mp::matchmakinggame() )
    {
        playlist_id = getplaylistid();
        playlist_name = getplaylistname();
    }
    
    is_ranked = level.leagueplaymatch || level.var_309e3d9dac389de6;
    max_players_allowed = getdvarint( @"party_maxplayers", -1 );
    frame_duration = getframeduration();
    sub_game_type = level.var_7ca18ab899076acf ?? "";
    
    if ( function_97de808fe549b3b7() )
    {
        function_ad05aed95a44741e( 1996680956793016933, [ 17:game_mode_key, 16:sub_game_type, 15:is_ranked, 14:frame_duration, 13:max_players_allowed, 12:!level.onlinegame, 11:playlist_name, 10:playlist_id, 9:getdediserverguid(), 8:getdvar( @"experiment_name" ), 7:getdvarint( @"dlog_is_playtest" ) && getdvarint( @"dlog_is_playtest_active" ), 6:game_type_variant, 5:game_type, 4:level.script, 3:utc_start_time_s ] );
    }
    else
    {
        dlog_recordevent( "dlog_event_mp_server_match_start", [ "utc_start_time_s", utc_start_time_s, "map", level.script, "game_type", game_type, "game_type_variant", game_type_variant, "is_playtest", getdvarint( @"dlog_is_playtest" ) && getdvarint( @"dlog_is_playtest_active" ), "experiment_name", getdvar( @"experiment_name" ), "dedi_server_guid", getdediserverguid(), "playlist_id", playlist_id, "playlist_name", playlist_name, "is_offline", !level.onlinegame, "max_players_allowed", max_players_allowed, "frame_duration", frame_duration, "is_ranked", is_ranked, "sub_game_type", sub_game_type, "game_mode_key", game_mode_key ] );
    }
    
    var_ef414121cc2240a4 = "{\"game_type\":\"" + game_type + "\",\"map\":\"" + level.script + "\"}";
    recordeventforsreparser( "server_match_start", var_ef414121cc2240a4 );
    
    if ( isbrgamemode() )
    {
        utility::trycall( level.matchdata_br_onmatchstart );
    }
    
    onmatchbegin();
}

// Namespace telemetry_mp
// Params 1
// Checksum 0x6b4c3c68, Offset: 0x51c4
// Size: 0x5ee
function on_match_end( data )
{
    utc_start_time_s = 0;
    total_player_connections = 0;
    life_count = 0;
    game_event_count = 0;
    end_reason = 0;
    total_bot_count = 0;
    unique_player_count_wo_bots = 0;
    
    if ( isdefined( game[ "telemetry" ].utc_start_time_s ) )
    {
        utc_start_time_s = game[ "telemetry" ].utc_start_time_s;
    }
    
    if ( isdefined( game[ "telemetry" ].total_player_connections ) )
    {
        total_player_connections = game[ "telemetry" ].total_player_connections;
    }
    
    if ( isdefined( game[ "telemetry" ].life_count ) )
    {
        life_count = game[ "telemetry" ].life_count;
    }
    
    if ( isdefined( game[ "telemetry" ].game_event_count ) )
    {
        game_event_count = game[ "telemetry" ].game_event_count;
    }
    
    if ( isdefined( data.endreason ) )
    {
        end_reason = data.endreason;
    }
    
    if ( isdefined( game[ "telemetry" ].total_bot_count ) )
    {
        total_bot_count = game[ "telemetry" ].total_bot_count;
    }
    
    if ( isdefined( game[ "telemetry" ].player_ids ) )
    {
        unique_player_count_wo_bots = game[ "telemetry" ].player_ids.size;
    }
    
    game_type = game_utility::getgametype();
    game_type_variant = game_utility::function_e9de4eeab29754c3();
    playlist_id = 0;
    playlist_name = "";
    
    if ( game_utility_mp::matchmakinggame() )
    {
        playlist_id = getplaylistid();
        playlist_name = getplaylistname();
    }
    
    allies_score = 0;
    axis_score = 0;
    team_three_score = 0;
    
    if ( level.teambased )
    {
        allies_score = getteamscore( "allies" );
        axis_score = getteamscore( "axis" );
        
        if ( team_utility::isgameplayteam( "team_three" ) )
        {
            team_three_score = getteamscore( "team_three" );
        }
    }
    
    max_players_allowed = getdvarint( @"party_maxplayers", -1 );
    is_ranked = 0;
    
    if ( level.leagueplaymatch || level.var_309e3d9dac389de6 )
    {
        is_ranked = 1;
    }
    
    var_9b5613cdc9fcde58 = function_53609df45841c88c();
    
    if ( function_97de808fe549b3b7() )
    {
        function_ad05aed95a44741e( -1086202344808314726, [ 23:unique_player_count_wo_bots, 22:total_bot_count, 21:end_reason, 20:var_9b5613cdc9fcde58, 19:is_ranked, 18:max_players_allowed, 17:function_2cc62c2072d5a7a2(), 16:game_event_count, 15:team_three_score, 14:axis_score, 13:allies_score, 12:!level.onlinegame, 11:level.script, 10:game_type_variant, 9:game_type, 8:playlist_name, 7:playlist_id, 6:life_count, 5:total_player_connections, 4:getsystemtime(), 3:utc_start_time_s ] );
    }
    else
    {
        dlog_recordevent( "dlog_event_mp_server_match_end", [ "utc_start_time_s", utc_start_time_s, "utc_end_time_s", getsystemtime(), "total_player_connections", total_player_connections, "life_count", life_count, "playlist_id", playlist_id, "playlist_name", playlist_name, "game_type", game_type, "game_type_variant", game_type_variant, "map", level.script, "is_offline", !level.onlinegame, "allies_score", allies_score, "axis_score", axis_score, "team_three_score", team_three_score, "game_event_count", game_event_count, "weapon_map_watermark", function_2cc62c2072d5a7a2(), "max_players_allowed", max_players_allowed, "is_ranked", is_ranked, "is_archive_replay_recorded", var_9b5613cdc9fcde58, "end_reason", end_reason, "total_bot_count", total_bot_count, "unique_player_count_wo_bots", unique_player_count_wo_bots ] );
    }
    
    dlog_recordevent( "dlog_event_mp_server_match_end_archive", [ "utc_start_time_s", utc_start_time_s, "utc_end_time_s", getsystemtime(), "total_player_connections", total_player_connections, "life_count", life_count, "playlist_id", playlist_id, "playlist_name", playlist_name, "game_type", game_type, "game_type_variant", game_type_variant, "map", level.script, "is_offline", !level.onlinegame, "allies_score", allies_score, "axis_score", axis_score, "team_three_score", team_three_score, "game_event_count", game_event_count, "weapon_map_watermark", function_2cc62c2072d5a7a2(), "max_players_allowed", max_players_allowed, "is_ranked", is_ranked, "is_archive_replay_recorded", var_9b5613cdc9fcde58, "end_reason", end_reason ] );
    
    if ( !isdefined( level.nbmeatshield ) )
    {
        level.nbmeatshield = 0;
    }
    
    if ( !isdefined( level.var_8b935d1f6cdc1b6 ) )
    {
        level.var_8b935d1f6cdc1b6 = 0;
    }
    
    dlog_recordevent( "dlog_event_mp_server_meat_shield", [ "meat_shield_count", level.nbmeatshield, "interrupted_meat_shield_count", level.var_8b935d1f6cdc1b6 ] );
}

// Namespace telemetry_mp
// Params 1
// Checksum 0x928fad3b, Offset: 0x57ba
// Size: 0x33
function on_round_start( data )
{
    if ( isdefined( game[ "telemetry" ] ) )
    {
        game[ "telemetry" ].round_start_time_ms = telemetry_utils::get_time_from_match_start( gettime() );
    }
}

// Namespace telemetry_mp
// Params 1
// Checksum 0xe983a47b, Offset: 0x57f5
// Size: 0xde
function on_round_end( data )
{
    round_start_time_ms = 0;
    
    if ( isdefined( game[ "telemetry" ].round_start_time_ms ) )
    {
        round_start_time_ms = game[ "telemetry" ].round_start_time_ms;
    }
    
    allies_score = 0;
    axis_score = 0;
    
    if ( level.teambased )
    {
        allies_score = getteamscore( "allies" );
        axis_score = getteamscore( "axis" );
    }
    
    round_end_time_ms = telemetry_utils::get_time_from_match_start( gettime() );
    dlog_recordevent( "dlog_event_mp_server_round_end", [ "round_start_time_ms", round_start_time_ms, "round_end_time_ms", round_end_time_ms, "allies_score", allies_score, "axis_score", axis_score ] );
    function_5c45d02d1a36cf5c( round_start_time_ms, round_end_time_ms );
}

// Namespace telemetry_mp
// Params 1
// Checksum 0xfe8d3203, Offset: 0x58db
// Size: 0x33
function function_ce16447ef1f1b7ff( player )
{
    return isbot( player ) || istestclient( player ) || isai( player ) ? 0 : player usinggamepad();
}

// Namespace telemetry_mp
// Params 0
// Checksum 0xcda0fc3a, Offset: 0x5917
// Size: 0x92
function function_5f57eef0097a3091()
{
    self endon( #"disconnect" );
    match_end_selection_map = [ "Main Menu", "Play Again", "Play Again with Squad", "" ];
    
    while ( true )
    {
        self waittill( #"luinotifyserver", channel, val );
        
        if ( channel == "ui_match_end_selection" )
        {
            self.pers[ "telemetry" ].match_end_selection = match_end_selection_map[ val ];
            return;
        }
    }
}

// Namespace telemetry_mp
// Params 1
// Checksum 0x8dba9146, Offset: 0x59b1
// Size: 0x1c58
function on_player_connect( player )
{
    if ( !telemetry_utils::is_valid_client( player ) )
    {
        return;
    }
    
    if ( isdefined( player.pers[ "telemetry" ].connected ) )
    {
        return;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ] ) )
    {
        player.pers[ "telemetry" ] = spawnstruct();
    }
    
    if ( isdefined( game[ "telemetry" ].total_player_connections ) )
    {
        player.pers[ "telemetry" ].connect_index = game[ "telemetry" ].total_player_connections;
        game[ "telemetry" ].total_player_connections++;
    }
    else
    {
        println( "<dev string:x9e>" );
        return;
    }
    
    if ( isdefined( game[ "telemetry" ].total_bot_count ) && isbot( player ) )
    {
        game[ "telemetry" ].total_bot_count++;
    }
    
    if ( isdefined( game[ "telemetry" ].player_ids ) && !isbot( player ) )
    {
        game[ "telemetry" ].player_ids = arraycombineunique( game[ "telemetry" ].player_ids, [ player.guid ] );
    }
    
    var_9b9f7cc860f634f = getsystemtime() ?? 0;
    player.pers[ "telemetry" ].utc_connect_time_s = var_9b9f7cc860f634f;
    player.pers[ "telemetry" ].connected = 1;
    player.pers[ "telemetry" ].shots = 0;
    player.pers[ "telemetry" ].hits = 0;
    
    if ( player game_utility_mp::rankingenabled() )
    {
        player.pers[ "telemetry" ].xp_at_start = player player_progression_achievements::function_ad429e448c443545();
        player.pers[ "telemetry" ].rank_at_start = player player_progression_achievements::function_1f72ecc33fd16c37();
        player.pers[ "telemetry" ].prestige_at_start = player player_progression_achievements::function_89de54a4f43714a4();
        player.pers[ "telemetry" ].progression_verified = 0;
        player.pers[ "telemetry" ].score_at_start = player getplayerdata( level.var_6f9b00680ed002d8, "playerStats", "matchStats", "score" );
    }
    else
    {
        player.pers[ "telemetry" ].xp_at_start = 0;
        player.pers[ "telemetry" ].rank_at_start = 0;
        player.pers[ "telemetry" ].prestige_at_start = 0;
        player.pers[ "telemetry" ].progression_verified = 0;
        player.pers[ "telemetry" ].score_at_start = 0;
    }
    
    is_party_host = level.onlinegame ? player isfireteamleader() : 0;
    operator_allies = "";
    operator_axis = "";
    operator_allies_skin = -1;
    operator_axis_skin = -1;
    operator_allies_execution_ref = "none";
    operator_axis_execution_ref = "none";
    game_type = game_utility::getgametype();
    game_type_variant = game_utility::function_e9de4eeab29754c3();
    playlist_id = 0;
    playlist_name = "";
    is_veto_voting_type = 0;
    
    if ( game_utility_mp::matchmakinggame() )
    {
        playlist_id = getplaylistid();
        playlist_name = getplaylistname();
        is_veto_voting_type = function_c2613a20dae966e3();
    }
    
    connect_index = player.pers[ "telemetry" ].connect_index ?? 0;
    lobby_id = getlobbyid() ?? "";
    current_team = player.team ?? player.sessionteam ?? "unset";
    is_ranked = level.leagueplaymatch || level.var_309e3d9dac389de6;
    is_controller = function_ce16447ef1f1b7ff( player );
    client_ip_address_array = player getplayerip();
    client_ip_address = client_ip_address_array[ 0 ] + "." + client_ip_address_array[ 1 ] + "." + client_ip_address_array[ 2 ] + "." + client_ip_address_array[ 3 ];
    prestige_level = player player_progression_achievements::getprestige();
    is_using_vcon = player function_837cf56ce8e59b00();
    
    if ( function_97de808fe549b3b7() )
    {
        player function_ad05aed95a44741e( 607679409895575221, [ 34:is_using_vcon, 33:is_veto_voting_type, 32:client_ip_address, 31:is_controller, 30:player function_694baff5e636c8d3(), 29:player function_270290a172b9c73c() ?? [ "" ], 28:player function_90690ef42343d0cc(), 27:player function_87c3530d6dcd1ec7(), 26:prestige_level, 25:getdvarint( @"current_season", -1 ), 24:is_ranked, 23:lobby_id, 22:connect_index, 21:game_type_variant, 20:game_type, 19:playlist_name, 18:playlist_id, level.script, 16:operator_axis_execution_ref, 15:operator_allies_execution_ref, 14:operator_axis_skin, 13:operator_allies_skin, 12:operator_axis, 11:operator_allies, 10:player function_a36eded60cdc3922() != 1, 9:is_party_host, 8:player getpartyid(), 7:player getskill(), 6:player getjointype(), 5:current_team, 4:var_9b9f7cc860f634f ] );
    }
    else
    {
        player dlog_recordplayerevent( "dlog_event_mp_player_match_start", [ "utc_connect_time_s", var_9b9f7cc860f634f, "team", current_team, "join_type", player getjointype(), "skill", player getskill(), "party_id", player getpartyid(), "is_party_host", is_party_host, "was_keyboardmouse", player function_a36eded60cdc3922() != 1, "operator_allies", operator_allies, "operator_axis", operator_axis, "operator_allies_skin", operator_allies_skin, "operator_axis_skin", operator_axis_skin, "operator_allies_execution_ref", operator_allies_execution_ref, "operator_axis_execution_ref", operator_axis_execution_ref, "map", level.script, "playlist_id", playlist_id, "playlist_name", playlist_name, "game_type", game_type, "game_type_variant", game_type_variant, "connect_index", connect_index, "lobby_id", lobby_id, "is_ranked", is_ranked, "current_season", getdvarint( @"current_season", -1 ), "prestige_level", prestige_level, "map_voting_options", player function_87c3530d6dcd1ec7(), "map_voted_for", player function_90690ef42343d0cc(), "mode_voting_options", player function_270290a172b9c73c() ?? "", "mode_voted_for", player function_694baff5e636c8d3(), "is_controller", is_controller, "client_ip_address", client_ip_address, "is_veto_voting_type", is_veto_voting_type, "is_using_vcon", is_using_vcon ] );
    }
    
    recordeventforsreparser( "player_match_start", "" );
    
    if ( level.gamemodebundle.var_2fc669d4ccb1f63e )
    {
        if ( !isdefined( player.pers[ "telemetry" ].eliminations ) )
        {
            player.pers[ "telemetry" ].eliminations = 0;
        }
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_66d40dcc3e2ce088 ) )
    {
        player.pers[ "telemetry" ].var_66d40dcc3e2ce088 = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].one_shot_kills ) )
    {
        player.pers[ "telemetry" ].one_shot_kills = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].player_score_event_count ) )
    {
        player.pers[ "telemetry" ].player_score_event_count = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].player_weapon_stats_count ) )
    {
        player.pers[ "telemetry" ].player_weapon_stats_count = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].player_field_upgrade_stats_count ) )
    {
        player.pers[ "telemetry" ].player_field_upgrade_stats_count = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].player_equipment_stats_count ) )
    {
        player.pers[ "telemetry" ].player_equipment_stats_count = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].kill_streak_expired_count ) )
    {
        player.pers[ "telemetry" ].kill_streak_expired_count = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].player_loadout_count ) )
    {
        player.pers[ "telemetry" ].player_loadout_count = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].ai_agent_kills ) )
    {
        player.pers[ "telemetry" ].ai_agent_kills = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].armor_collected ) )
    {
        player.pers[ "telemetry" ].armor_collected = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].armor_equipped ) )
    {
        player.pers[ "telemetry" ].armor_equipped = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].armor_destroyed ) )
    {
        player.pers[ "telemetry" ].armor_destroyed = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].vehicle_autofwd_count ) )
    {
        player.pers[ "telemetry" ].vehicle_autofwd_count = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].ground_vehicle_used_count ) )
    {
        player.pers[ "telemetry" ].ground_vehicle_used_count = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].air_vehicle_used_count ) )
    {
        player.pers[ "telemetry" ].air_vehicle_used_count = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].reached_match_end ) )
    {
        player.pers[ "telemetry" ].reached_match_end = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_6ac2c6490dd67adc ) )
    {
        player.pers[ "telemetry" ].var_6ac2c6490dd67adc = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].killstreaks_used ) )
    {
        player.pers[ "telemetry" ].killstreaks_used = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].player_killstreak_kills ) )
    {
        player.pers[ "telemetry" ].player_killstreak_kills = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].bot_killstreak_kills ) )
    {
        player.pers[ "telemetry" ].bot_killstreak_kills = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].agent_killstreak_kills ) )
    {
        player.pers[ "telemetry" ].agent_killstreak_kills = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_d0d338af214b4950 ) )
    {
        player.pers[ "telemetry" ].var_d0d338af214b4950 = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_90ab4e486d171e04 ) )
    {
        player.pers[ "telemetry" ].var_90ab4e486d171e04 = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_522a9bfd5c6f728 ) )
    {
        player.pers[ "telemetry" ].var_522a9bfd5c6f728 = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].player_kills ) )
    {
        player.pers[ "telemetry" ].player_kills = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].bot_kills ) )
    {
        player.pers[ "telemetry" ].bot_kills = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].agent_kills ) )
    {
        player.pers[ "telemetry" ].agent_kills = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].bot_assists ) )
    {
        player.pers[ "telemetry" ].bot_assists = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].bot_headshots ) )
    {
        player.pers[ "telemetry" ].bot_headshots = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].agent_headshots ) )
    {
        player.pers[ "telemetry" ].agent_headshots = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_98a5205ed62c93d ) )
    {
        player.pers[ "telemetry" ].var_98a5205ed62c93d = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_e3103b223b34ee91 ) )
    {
        player.pers[ "telemetry" ].var_e3103b223b34ee91 = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].player_hits ) )
    {
        player.pers[ "telemetry" ].player_hits = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].bot_hits ) )
    {
        player.pers[ "telemetry" ].bot_hits = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].agent_hits ) )
    {
        player.pers[ "telemetry" ].agent_hits = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_596bc72160ba30dd ) )
    {
        player.pers[ "telemetry" ].var_596bc72160ba30dd = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_ed8397fa350b0793 ) )
    {
        player.pers[ "telemetry" ].var_ed8397fa350b0793 = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_36ab2b1350da7ffb ) )
    {
        player.pers[ "telemetry" ].var_36ab2b1350da7ffb = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_af5fee48115acc2c ) )
    {
        player.pers[ "telemetry" ].var_af5fee48115acc2c = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_10c1b854abd32824 ) )
    {
        player.pers[ "telemetry" ].var_10c1b854abd32824 = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_1b735d40cbf8c158 ) )
    {
        player.pers[ "telemetry" ].var_1b735d40cbf8c158 = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_aaefe63e2908cf61 ) )
    {
        player.pers[ "telemetry" ].var_aaefe63e2908cf61 = 0;
    }
    
    player.pers[ "telemetry" ].var_61c7f7fc343e033b = [];
    
    if ( !isdefined( player.pers[ "telemetry" ].var_61c7f7fc343e033b[ "ar" ] ) )
    {
        player.pers[ "telemetry" ].var_61c7f7fc343e033b[ "ar" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_61c7f7fc343e033b[ "br" ] ) )
    {
        player.pers[ "telemetry" ].var_61c7f7fc343e033b[ "br" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_61c7f7fc343e033b[ "dmr" ] ) )
    {
        player.pers[ "telemetry" ].var_61c7f7fc343e033b[ "dmr" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_61c7f7fc343e033b[ "sniper" ] ) )
    {
        player.pers[ "telemetry" ].var_61c7f7fc343e033b[ "sniper" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_61c7f7fc343e033b[ "launcher" ] ) )
    {
        player.pers[ "telemetry" ].var_61c7f7fc343e033b[ "launcher" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_61c7f7fc343e033b[ "lmg" ] ) )
    {
        player.pers[ "telemetry" ].var_61c7f7fc343e033b[ "lmg" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_61c7f7fc343e033b[ "melee" ] ) )
    {
        player.pers[ "telemetry" ].var_61c7f7fc343e033b[ "melee" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_61c7f7fc343e033b[ "pistol" ] ) )
    {
        player.pers[ "telemetry" ].var_61c7f7fc343e033b[ "pistol" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_61c7f7fc343e033b[ "shotgun" ] ) )
    {
        player.pers[ "telemetry" ].var_61c7f7fc343e033b[ "shotgun" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_61c7f7fc343e033b[ "smg" ] ) )
    {
        player.pers[ "telemetry" ].var_61c7f7fc343e033b[ "smg" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_61c7f7fc343e033b[ "other" ] ) )
    {
        player.pers[ "telemetry" ].var_61c7f7fc343e033b[ "other" ] = 0;
    }
    
    player.pers[ "telemetry" ].var_aedba93c9726c98f = [];
    
    if ( !isdefined( player.pers[ "telemetry" ].var_aedba93c9726c98f[ "ar" ] ) )
    {
        player.pers[ "telemetry" ].var_aedba93c9726c98f[ "ar" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_aedba93c9726c98f[ "br" ] ) )
    {
        player.pers[ "telemetry" ].var_aedba93c9726c98f[ "br" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_aedba93c9726c98f[ "dmr" ] ) )
    {
        player.pers[ "telemetry" ].var_aedba93c9726c98f[ "dmr" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_aedba93c9726c98f[ "sniper" ] ) )
    {
        player.pers[ "telemetry" ].var_aedba93c9726c98f[ "sniper" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_aedba93c9726c98f[ "launcher" ] ) )
    {
        player.pers[ "telemetry" ].var_aedba93c9726c98f[ "launcher" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_aedba93c9726c98f[ "lmg" ] ) )
    {
        player.pers[ "telemetry" ].var_aedba93c9726c98f[ "lmg" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_aedba93c9726c98f[ "melee" ] ) )
    {
        player.pers[ "telemetry" ].var_aedba93c9726c98f[ "melee" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_aedba93c9726c98f[ "pistol" ] ) )
    {
        player.pers[ "telemetry" ].var_aedba93c9726c98f[ "pistol" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_aedba93c9726c98f[ "shotgun" ] ) )
    {
        player.pers[ "telemetry" ].var_aedba93c9726c98f[ "shotgun" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_aedba93c9726c98f[ "smg" ] ) )
    {
        player.pers[ "telemetry" ].var_aedba93c9726c98f[ "smg" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_aedba93c9726c98f[ "other" ] ) )
    {
        player.pers[ "telemetry" ].var_aedba93c9726c98f[ "other" ] = 0;
    }
    
    player.pers[ "telemetry" ].var_defc700e2a933403 = [];
    
    if ( !isdefined( player.pers[ "telemetry" ].var_defc700e2a933403[ "ar" ] ) )
    {
        player.pers[ "telemetry" ].var_defc700e2a933403[ "ar" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_defc700e2a933403[ "br" ] ) )
    {
        player.pers[ "telemetry" ].var_defc700e2a933403[ "br" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_defc700e2a933403[ "dmr" ] ) )
    {
        player.pers[ "telemetry" ].var_defc700e2a933403[ "dmr" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_defc700e2a933403[ "sniper" ] ) )
    {
        player.pers[ "telemetry" ].var_defc700e2a933403[ "sniper" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_defc700e2a933403[ "launcher" ] ) )
    {
        player.pers[ "telemetry" ].var_defc700e2a933403[ "launcher" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_defc700e2a933403[ "lmg" ] ) )
    {
        player.pers[ "telemetry" ].var_defc700e2a933403[ "lmg" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_defc700e2a933403[ "melee" ] ) )
    {
        player.pers[ "telemetry" ].var_defc700e2a933403[ "melee" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_defc700e2a933403[ "pistol" ] ) )
    {
        player.pers[ "telemetry" ].var_defc700e2a933403[ "pistol" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_defc700e2a933403[ "shotgun" ] ) )
    {
        player.pers[ "telemetry" ].var_defc700e2a933403[ "shotgun" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_defc700e2a933403[ "smg" ] ) )
    {
        player.pers[ "telemetry" ].var_defc700e2a933403[ "smg" ] = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].var_defc700e2a933403[ "other" ] ) )
    {
        player.pers[ "telemetry" ].var_defc700e2a933403[ "other" ] = 0;
    }
    
    if ( getdvarint( @"hash_5ce3657bc4920adc", 1 ) == 1 )
    {
        player.pers[ "telemetry" ].playerkillevents = [];
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].reached_match_end ) )
    {
        player.pers[ "telemetry" ].reached_match_end = 0;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].is_early_disconnect ) )
    {
        player.pers[ "telemetry" ].is_early_disconnect = 1;
    }
}

// Namespace telemetry_mp
// Params 1
// Checksum 0x56a39bc4, Offset: 0x7611
// Size: 0x358
function on_player_spawned( player )
{
    if ( !telemetry_utils::is_valid_client( player ) )
    {
        return;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ] ) )
    {
        player.pers[ "telemetry" ] = spawnstruct();
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].life ) )
    {
        player.pers[ "telemetry" ].life = spawnstruct();
    }
    
    if ( isdefined( game[ "telemetry" ].life_count ) )
    {
        player.pers[ "telemetry" ].life.life_index = game[ "telemetry" ].life_count;
        game[ "telemetry" ].life_count++;
    }
    
    if ( isdefined( player.pers[ "summary" ][ "xp" ] ) )
    {
        player.pers[ "telemetry" ].life.var_cf1e1f502926dd46 = player.pers[ "summary" ][ "xp" ];
    }
    else
    {
        player.pers[ "telemetry" ].life.var_cf1e1f502926dd46 = 0;
    }
    
    if ( isdefined( player.score ) )
    {
        player.pers[ "telemetry" ].life.var_18c9be0a7e4ab2ac = player.score;
    }
    else
    {
        player.pers[ "telemetry" ].life.var_18c9be0a7e4ab2ac = 0;
    }
    
    if ( player game_utility_mp::rankingenabled() && !player.pers[ "telemetry" ].progression_verified )
    {
        player.pers[ "telemetry" ].xp_at_start = player player_progression_achievements::function_fbde1ca37c2aeeb6();
        player.pers[ "telemetry" ].rank_at_start = player player_progression_achievements::function_1682192f91884908();
        player.pers[ "telemetry" ].prestige_at_start = player player_progression_achievements::getprestige();
        player.pers[ "telemetry" ].progression_verified = player player_progression_achievements::function_a14a1871d0fbd201();
        player.pers[ "telemetry" ].score_at_start = player getplayerdata( level.var_6f9b00680ed002d8, "playerStats", "matchStats", "score" );
        return;
    }
    
    player.pers[ "telemetry" ].xp_at_start = 0;
    player.pers[ "telemetry" ].rank_at_start = 0;
    player.pers[ "telemetry" ].score_at_start = 0;
    player.pers[ "telemetry" ].prestige_at_start = 0;
    player.pers[ "telemetry" ].progression_verified = 0;
}

// Namespace telemetry_mp
// Params 0
// Checksum 0x43c04883, Offset: 0x7971
// Size: 0xa1
function function_f8ac77476d140859()
{
    foreach ( player in level.players )
    {
        data = spawnstruct();
        data.player = player;
        telemetry_utils::function_c54601d44e7b8e8a( player );
        player thread send_player_match_end_event( data );
    }
}

// Namespace telemetry_mp
// Params 0
// Checksum 0xbfa363c8, Offset: 0x7a1a
// Size: 0x67
function function_b0f4fb2573fbd1dd()
{
    if ( level.gametypebundle.var_43f596fe9c6cb4bb == #"Throttle" )
    {
        keepwaiting = 1;
        
        while ( keepwaiting )
        {
            keepwaiting = 0;
            
            if ( !throttle::is_empty( level.send_player_match_end_event_throttle ) && !throttle::function_eed893c053dbf304( level.send_player_match_end_event_throttle ) )
            {
                keepwaiting = 1;
            }
            
            waitframe();
        }
    }
}

// Namespace telemetry_mp
// Params 1
// Checksum 0x60757832, Offset: 0x7a89
// Size: 0x97
function send_player_match_end_event( data )
{
    player = data.player;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !player.disconnecting )
    {
        if ( level.gametypebundle.var_43f596fe9c6cb4bb == #"Throttle" )
        {
            if ( !isdefined( level.send_player_match_end_event_throttle ) )
            {
                level.send_player_match_end_event_throttle = throttle::throttle_initialize( "send_player_match_end_event_throttle", 1 );
            }
            
            throttle::throttle_wait_in_queue( level.send_player_match_end_event_throttle, player );
        }
    }
    
    function_94f05072b22783c5( data );
}

// Namespace telemetry_mp
// Params 1, eflags: 0x4
// Checksum 0xfc231e95, Offset: 0x7b28
// Size: 0x24aa
function private function_94f05072b22783c5( data )
{
    player = data.player;
    
    if ( isdefined( player.pers[ "telemetry" ].var_fa7df34e464eabdf ) )
    {
        return;
    }
    
    if ( !telemetry_utils::is_valid_client( player ) )
    {
        return;
    }
    
    if ( player.var_5a792f9fdacf9283 && !level.gameended )
    {
        return;
    }
    
    team_xp_modifier = level.teambased ? int( player rank::getteamrankxpmultiplier( player.team ) ) : 0;
    
    if ( player game_utility_mp::onlinestatsenabled() )
    {
        pers_summary = { #battlepass_xp:int( player.pers[ "summary" ][ "battlepassXP" ] ) ?? 0, #clan_xp:player.pers[ "summary" ][ "clanXP" ] ?? 0, #operator_xp:player.pers[ "summary" ][ "operatorXP" ] ?? 0, #weapon_xp:player.pers[ "summary" ][ "weaponXP" ] ?? 0, #accolade_xp:player.pers[ "summary" ][ "accolade" ] ?? 0, #misc_xp:player.pers[ "summary" ][ "misc" ] ?? 0, #bonus_xp:player.pers[ "summary" ][ "bonusXP" ] ?? 0, #medal_xp:player.pers[ "summary" ][ "medal" ] ?? 0, #match_xp:player.pers[ "summary" ][ "match" ] ?? 0, #challenge_xp:player.pers[ "summary" ][ "challenge" ] ?? 0, #score_xp:player.pers[ "summary" ][ "score" ] ?? 0, #total_xp:player.pers[ "summary" ][ "xp" ] ?? 0 };
    }
    
    lifetimedata = { #prestige_at_start:player.pers[ "telemetry" ].prestige_at_start ?? 0, #score_at_start:player.pers[ "telemetry" ].score_at_start ?? 0, #xp_at_start:player.pers[ "telemetry" ].xp_at_start ?? 0, #rank_at_start:player.pers[ "telemetry" ].rank_at_start ?? 0 };
    
    if ( player game_utility_mp::rankingenabled() && player hasplayerdata() )
    {
        lifetimedata.xp_at_end = player.pers[ "rankxp" ];
        lifetimedata.rank_at_end = player progression_utility::getrankforxp( lifetimedata.xp_at_end );
        lifetimedata.prestige_at_end = player player_progression_achievements::getprestige();
        lifetimedata.score_at_end = player getplayerdata( level.var_6f9b00680ed002d8, "playerStats", "matchStats", "score" );
        lifetimedata.lifetime_kills = player getplayerdata( level.var_6f9b00680ed002d8, "playerStats", "combatStats", "kills" );
        lifetimedata.lifetime_deaths = player getplayerdata( level.var_6f9b00680ed002d8, "playerStats", "combatStats", "deaths" );
        lifetimedata.lifetime_wins = player getplayerdata( level.var_6f9b00680ed002d8, "playerStats", "matchStats", "wins" );
        lifetimedata.lifetime_losses = player getplayerdata( level.var_6f9b00680ed002d8, "playerStats", "matchStats", "losses" );
        lifetimedata.lifetime_hits = player getplayerdata( level.var_6f9b00680ed002d8, "playerStats", "combatStats", "hits" );
        lifetimedata.lifetime_misses = player getplayerdata( level.var_6f9b00680ed002d8, "playerStats", "combatStats", "misses" );
        lifetimedata.lifetime_wall_bangs = player getplayerdata( level.var_6f9b00680ed002d8, "playerStats", "combatStats", "wallbangs" );
        lifetimedata.lifetime_near_misses = player getplayerdata( level.var_6f9b00680ed002d8, "playerStats", "combatStats", "nearMisses" );
        lifetimedata.lifetime_games_played = player getplayerdata( level.var_6f9b00680ed002d8, "playerStats", "matchStats", "gamesPlayed" );
        lifetimedata.lifetime_time_played_total = player getplayerdata( level.var_6f9b00680ed002d8, "playerStats", "matchStats", "timePlayedTotal" );
    }
    
    if ( isdefined( data.disconnectreason ) )
    {
        if ( game_utility_mp::isroundbased() )
        {
            player_quit_round_number = game[ "roundsPlayed" ];
        }
        
        if ( level.teambased && isdefined( player.team ) )
        {
            if ( player.team == "allies" )
            {
                player_quit_team_score = getteamscore( "allies" );
                player_quit_opposing_team_score = getteamscore( "axis" );
            }
            else if ( player.team == "axis" )
            {
                player_quit_team_score = getteamscore( "axis" );
                player_quit_opposing_team_score = getteamscore( "allies" );
            }
        }
    }
    
    if ( player.pers[ "movementUpdateCount" ] >= 30 )
    {
        percent_time_moving = player.pers[ "movingTotal" ] / player.pers[ "movementUpdateCount" ] / 5 * 100;
        average_speed_during_match = player.pers[ "distanceTotal" ] / player.pers[ "movementUpdateCount" ];
    }
    
    weapon_accuracy = 0;
    totalshots = player playerstats_interface::getplayerstat( "combatStats", "totalShots" );
    totalhits = player playerstats_interface::getplayerstat( "combatStats", "hits" );
    
    if ( isdefined( totalhits ) && totalshots > 0 )
    {
        weapon_accuracy = float( totalhits / totalshots * 100 );
    }
    
    if ( ( game_utility::getgametype() == "arm" || game_utility::getgametype() == "conflict" ) && isdefined( player.gwinputtypesused ) )
    {
        gw_spawn_method_press_rclick = istrue( player.gwinputtypesused[ "rightmouseup" ] );
        gw_spawn_method_press_lclick = istrue( player.gwinputtypesused[ "leftmouseup" ] );
        gw_spawn_method_press_activate = istrue( player.gwinputtypesused[ "activate" ] );
        gw_spawn_method_press_gostand = istrue( player.gwinputtypesused[ "gostand" ] );
    }
    
    game_type = game_utility::getgametype();
    game_type_variant = game_utility::function_e9de4eeab29754c3();
    
    if ( game_utility_mp::matchmakinggame() )
    {
        playlist_id = getplaylistid();
        playlist_name = getplaylistname();
    }
    
    player weapons::function_8a7193fb82f2181b();
    player persistence::updateweaponbufferedstats();
    function_abf3fae8f87a753f( player, #"hash_ffe986ec2b69c991" );
    
    if ( isdefined( player ) && isdefined( player.team ) && ( getdvarint( @"hash_3f7dbd03a63a2aa", 0 ) == 1 || !isbot( player ) ) )
    {
        operatorstruct = { #operator_execution_ref:player operator::function_4308bc9472e8e835() ?? "none", #operator_skin:player operator::function_cc5d60d5178c5007(), #operator:player operator::getoperatorref() };
        
        if ( operatorstruct.operator && !isxhashasset( operatorstruct.operator ) )
        {
            operatorstruct.operator = getxhashasset( operatorstruct.operator );
        }
        
        if ( operatorstruct.operator_skin && !isxhashasset( operatorstruct.operator_skin ) )
        {
            operatorstruct.operator_skin = getxhashasset( operatorstruct.operator_skin );
        }
    }
    
    lobby_id = getlobbyid() ?? "";
    current_season = getdvarint( @"current_season", -1 );
    current_team = player.team ?? player.sessionteam ?? "unset";
    is_ranked = level.leagueplaymatch || level.var_309e3d9dac389de6;
    is_controller = function_ce16447ef1f1b7ff( player );
    holding_weapon_case = namespace_9d8e359c3b1041e5::didextractwithweaponcasesharedfunc( player );
    
    if ( isdefined( player.team ) && teams::function_8f3d2f6628601447( player.team, "best_squad_wipes" ) )
    {
        best_squad_wipe_streak = teams::getteamdata( player.team, "best_squad_wipes" );
    }
    
    reached_match_end = istrue( player.pers[ "telemetry" ].reached_match_end );
    
    if ( reached_match_end )
    {
        player.pers[ "telemetry" ].is_early_disconnect = 0;
    }
    
    is_early_disconnect = player.pers[ "telemetry" ].is_early_disconnect ?? 1;
    is_prematch = gamelogic_mp::inprematch();
    player_placement = player.pers[ "telemetry" ].teamplacement;
    
    if ( !isdefined( player_placement ) )
    {
        if ( is_early_disconnect )
        {
            player_placement = -1;
        }
        else
        {
            player_placement = gamescore::function_ca38b93f32c7b685( player ) ?? -1;
        }
    }
    
    if ( utility::issharedfuncdefined( #"deadliestweapon", #"hash_a4f0254e8a3abe2a" ) )
    {
        var_7d284148c7e252c1 = [[ utility::getsharedfunc( #"deadliestweapon", #"hash_a4f0254e8a3abe2a" ) ]]( player );
    }
    
    teamsize = getmatchrulesdata( "commonOption", "teamSize" );
    botdifficulty = "";
    
    if ( isbot( player ) )
    {
        botdifficulty = player botgetdifficulty();
    }
    
    var_3662cc13cbfcc812 = player.pers[ "deaths" ] ?? 0;
    suicides = player.pers[ "suicides" ] ?? 0;
    var_98a5205ed62c93d = player.pers[ "telemetry" ].var_98a5205ed62c93d ?? 0;
    var_e3103b223b34ee91 = player.pers[ "telemetry" ].var_e3103b223b34ee91 ?? 0;
    non_player_deaths = suicides + var_98a5205ed62c93d + var_e3103b223b34ee91;
    deaths_by_player = max( 0, var_3662cc13cbfcc812 - non_player_deaths );
    
    if ( function_97de808fe549b3b7() )
    {
        player function_ad05aed95a44741e( 4087066007766107809, [ 130:botdifficulty, 129:player.pers[ "wallbangsdamage" ], 128:player.pers[ "telemetry" ].blackcell_loyalty ?? 0, 127:teamsize, 126:is_prematch, 125:player.loss_forgiven ?? 0, 123:istrue( level.var_d7be75388b125a1c ), 122:is_early_disconnect, 121:reached_match_end, 120:best_squad_wipe_streak ?? 0, 119:player.pers[ "wallbangs" ], 118:holding_weapon_case, 117:istrue( player.extracted ), 116:is_controller, 115:player.pers[ "telemetry" ].air_vehicle_used_count ?? 0, 114:player.pers[ "telemetry" ].ground_vehicle_used_count ?? 0, 113:player.pers[ "telemetry" ].vehicle_autofwd_count ?? 0, 112:player.pers[ "telemetry" ].var_bd01ba2a79bcab95 ?? 0, 111:player.pers[ "telemetry" ].armor_destroyed ?? 0, 110:player.pers[ "telemetry" ].armor_equipped ?? 0, 109:player.pers[ "telemetry" ].armor_collected ?? 0, 108:is_ranked, 107:current_season, 106:lobby_id, 105:var_7d284148c7e252c1.accuracy ?? 0, 104:var_7d284148c7e252c1.deaths ?? 0, 103:var_7d284148c7e252c1.eliminations ?? 0, 102:var_7d284148c7e252c1.name ?? "", 101:operatorstruct.operator_execution_ref ?? "none", 100:operatorstruct.operator_skin ?? "", 99:operatorstruct.operator ?? "", 98:player.pers[ "telemetry" ].player_loadout_count ?? 0, 97:player.pers[ "telemetry" ].kill_streak_expired_count ?? 0, 96:player.pers[ "telemetry" ].player_equipment_stats_count ?? 0, 95:player.pers[ "telemetry" ].player_field_upgrade_stats_count ?? 0, 94:player.pers[ "telemetry" ].player_weapon_stats_count ?? 0, 93:player.pers[ "telemetry" ].player_score_event_count ?? 0, 92:player.pers[ "telemetry" ].hits ?? 0, 91:player.pers[ "telemetry" ].shots ?? 0, 90:pers_summary.battlepass_xp ?? 0, 89:pers_summary.clan_xp ?? 0, 88:pers_summary.operator_xp ?? 0, 87:pers_summary.weapon_xp ?? 0, 86:pers_summary.accolade_xp ?? 0, 85:pers_summary.misc_xp ?? 0, 84:pers_summary.bonus_xp ?? 0, 83:pers_summary.medal_xp ?? 0, 82:pers_summary.match_xp ?? 0, 81:pers_summary.challenge_xp ?? 0, 80:pers_summary.score_xp ?? 0, 79:pers_summary.total_xp ?? 0, 78:lifetimedata.lifetime_time_played_total ?? 0, 77:lifetimedata.lifetime_games_played ?? 0, 76:lifetimedata.lifetime_near_misses ?? 0, 75:lifetimedata.lifetime_wall_bangs ?? 0, 74:lifetimedata.lifetime_misses ?? 0, 73:lifetimedata.lifetime_hits ?? 0, 72:lifetimedata.lifetime_losses ?? 0, 71:lifetimedata.lifetime_wins ?? 0, 70:lifetimedata.lifetime_deaths ?? 0, 69:lifetimedata.lifetime_kills ?? 0, 68:lifetimedata.prestige_at_end ?? 0, 67:lifetimedata.prestige_at_start ?? 0, 66:lifetimedata.score_at_end ?? 0, 65:lifetimedata.score_at_start ?? 0, 124:player.pers[ "telemetry" ].progression_verified ?? 0, 64:lifetimedata.xp_at_end ?? 0, 63:lifetimedata.xp_at_start ?? 0, 62:lifetimedata.rank_at_end ?? 0, 61:lifetimedata.rank_at_start ?? 0, 60:player.pers[ "match_outcome" ] ?? "loss", 59:player.pers[ "telemetry" ].connect_index ?? 0, 58:level.script, 57:playlist_name ?? "", 56:playlist_id ?? 0, 55:gw_spawn_method_press_rclick ?? 0, 54:gw_spawn_method_press_lclick ?? 0, 53:gw_spawn_method_press_gostand ?? 0, 52:gw_spawn_method_press_activate ?? 0, 51:game_type_variant, 50:game_type, 49:suicides, 48:weapon_accuracy, 47:float( player.pers[ "totalDistTraveled" ] ?? 0 ), 46:player.pers[ "damageTaken" ] ?? 0, 45:player.pers[ "damage" ] ?? 0, 44:percent_time_moving ?? 0, 43:average_speed_during_match ?? 0, 42:player_quit_opposing_team_score ?? 0, 41:player_quit_team_score ?? 0, 40:player_quit_round_number ?? -1, 39:data.disconnectreason ?? #"", 38:int( player weaponrank::getweaponrankxpmultiplier() ), 37:team_xp_modifier, 36:int( player rank::getrankxpmultiplier() ), 35:player.pers[ "enemiesCrushedByCarePackages" ] ?? 0, 34:player.pers[ "stolenCarePackages" ] ?? 0, 33:player.pers[ "executions" ] ?? 0, 32:player.pers[ "headshots" ] ?? 0, 31:var_e3103b223b34ee91, 30:var_98a5205ed62c93d, 29:deaths_by_player, 28:var_3662cc13cbfcc812, 27:player.pers[ "telemetry" ].player_kills ?? 0, 26:player.pers[ "telemetry" ].ai_bot_kills ?? 0, 25:player.pers[ "telemetry" ].ai_agent_kills ?? 0, 24:player.pers[ "telemetry" ].eliminations ?? 0, 23:player.pers[ "telemetry" ].one_shot_kills ?? 0, 22:player.pers[ "kills" ], 21:player.pers[ "longestStreak" ], 20:player.pers[ "assists" ], 19:player_placement, 18:player.var_e572d1214d36a52a ?? "", 17:player.var_e572cc214d369a2b ?? "", 16:player.var_e572cb214d3697f8 ?? "", 15:player.var_e572ce214d369e91 ?? "", 14:player.var_e572cd214d369c5e ?? "", 13:player.pers[ "extrascore4" ] ?? 0, 12:player.pers[ "extrascore3" ] ?? 0, 11:player.pers[ "extrascore2" ] ?? 0, 10:player.pers[ "extrascore1" ] ?? 0, 9:player.pers[ "extrascore0" ] ?? 0, 8:player.pers[ "objectivescore" ] ?? 0, 7:player.pers[ "score" ], 6:current_team, 5:getsystemtime(), 4:player.pers[ "telemetry" ].utc_connect_time_s ?? 0 ] );
    }
    else
    {
        player dlog_recordplayerevent( "dlog_event_mp_player_match_end", [ "utc_connect_time_s", player.pers[ "telemetry" ].utc_connect_time_s ?? 0, "utc_disconnect_time_s", getsystemtime(), "team", current_team, "score", player.pers[ "score" ], "objective_score", player.pers[ "objectivescore" ] ?? 0, "extra_score_0", player.pers[ "extrascore0" ] ?? 0, "extra_score_1", player.pers[ "extrascore1" ] ?? 0, "extra_score_2", player.pers[ "extrascore2" ] ?? 0, "extra_score_3", player.pers[ "extrascore3" ] ?? 0, "extra_score_4", player.pers[ "extrascore4" ] ?? 0, "extra_score_info_0", player.var_e572cd214d369c5e ?? "", "extra_score_info_1", player.var_e572ce214d369e91 ?? "", "extra_score_info_2", player.var_e572cb214d3697f8 ?? "", "extra_score_info_3", player.var_e572cc214d369a2b ?? "", "extra_score_info_4", player.var_e572d1214d36a52a ?? "", "placement", player_placement, "assists", player.pers[ "assists" ], "longest_streak", player.pers[ "longestStreak" ], "kills", player.pers[ "kills" ], "one_shot_kills", player.pers[ "telemetry" ].one_shot_kills ?? 0, "eliminations", player.pers[ "telemetry" ].eliminations ?? 0, "ai_agent_kills", player.pers[ "telemetry" ].ai_agent_kills ?? 0, "ai_bot_kills", player.pers[ "telemetry" ].ai_bot_kills ?? 0, "player_kills", player.pers[ "telemetry" ].player_kills ?? 0, "deaths", var_3662cc13cbfcc812, "deaths_by_player", deaths_by_player, "deaths_by_ai_bot", var_98a5205ed62c93d, "deaths_by_ai_agent", var_e3103b223b34ee91, "headshots", player.pers[ "headshots" ] ?? 0, "executions", player.pers[ "executions" ] ?? 0, "stolen_care_packages", player.pers[ "stolenCarePackages" ] ?? 0, "enemies_crushed_by_care_packages", player.pers[ "enemiesCrushedByCarePackages" ] ?? 0, "player_xp_modifier", int( player rank::getrankxpmultiplier() ), "team_xp_modifier", team_xp_modifier, "weapon_xp_modifier", int( player weaponrank::getweaponrankxpmultiplier() ), "disconnect_reason", data.disconnectreason ?? #"", "player_quit_round_number", player_quit_round_number ?? -1, "player_quit_team_score", player_quit_team_score ?? 0, "player_quit_opposing_team_score", player_quit_opposing_team_score ?? 0, "average_speed_during_match", average_speed_during_match ?? 0, "percent_time_moving", percent_time_moving ?? 0, "damage_done", player.pers[ "damage" ] ?? 0, "damage_taken", player.pers[ "damageTaken" ] ?? 0, "distance_traveled", float( player.pers[ "totalDistTraveled" ] ?? 0 ), "weapon_accuracy", weapon_accuracy, "suicides", suicides, "game_type", game_type, "game_type_variant", game_type_variant, "gw_spawn_method_press_activate", gw_spawn_method_press_activate ?? 0, "gw_spawn_method_press_gostand", gw_spawn_method_press_gostand ?? 0, "gw_spawn_method_press_lclick", gw_spawn_method_press_lclick ?? 0, "gw_spawn_method_press_rclick", gw_spawn_method_press_rclick ?? 0, "playlist_id", playlist_id ?? 0, "playlist_name", playlist_name ?? "", "map", level.script, "connect_index", player.pers[ "telemetry" ].connect_index ?? 0, "match_outcome", player.pers[ "match_outcome" ] ?? "loss", "rank_at_start", lifetimedata.rank_at_start ?? 0, "rank_at_end", lifetimedata.rank_at_end ?? 0, "xp_at_start", lifetimedata.xp_at_start ?? 0, "xp_at_end", lifetimedata.xp_at_end ?? 0, "progression_verified", player.pers[ "telemetry" ].progression_verified ?? 0, "score_at_start", lifetimedata.score_at_start ?? 0, "score_at_end", lifetimedata.score_at_end ?? 0, "prestige_at_start", lifetimedata.prestige_at_start ?? 0, "prestige_at_end", lifetimedata.prestige_at_end ?? 0, "lifetime_kills", lifetimedata.lifetime_kills ?? 0, "lifetime_deaths", lifetimedata.lifetime_deaths ?? 0, "lifetime_wins", lifetimedata.lifetime_wins ?? 0, "lifetime_losses", lifetimedata.lifetime_losses ?? 0, "lifetime_hits", lifetimedata.lifetime_hits ?? 0, "lifetime_misses", lifetimedata.lifetime_misses ?? 0, "lifetime_wall_bangs", lifetimedata.lifetime_wall_bangs ?? 0, "lifetime_near_misses", lifetimedata.lifetime_near_misses ?? 0, "lifetime_games_played", lifetimedata.lifetime_games_played ?? 0, "lifetime_time_played_total", lifetimedata.lifetime_time_played_total ?? 0, "total_xp", pers_summary.total_xp ?? 0, "score_xp", pers_summary.score_xp ?? 0, "challenge_xp", pers_summary.challenge_xp ?? 0, "match_xp", pers_summary.match_xp ?? 0, "medal_xp", pers_summary.medal_xp ?? 0, "bonus_xp", pers_summary.bonus_xp ?? 0, "misc_xp", pers_summary.misc_xp ?? 0, "accolade_xp", pers_summary.accolade_xp ?? 0, "weapon_xp", pers_summary.weapon_xp ?? 0, "operator_xp", pers_summary.operator_xp ?? 0, "clan_xp", pers_summary.clan_xp ?? 0, "battlepass_xp", pers_summary.battlepass_xp ?? 0, "shots", player.pers[ "telemetry" ].shots ?? 0, "hits", player.pers[ "telemetry" ].hits ?? 0, "player_score_event_count", player.pers[ "telemetry" ].player_score_event_count ?? 0, "player_weapon_stats_count", player.pers[ "telemetry" ].player_weapon_stats_count ?? 0, "player_field_upgrade_stats_count", player.pers[ "telemetry" ].player_field_upgrade_stats_count ?? 0, "player_equipment_stats_count", player.pers[ "telemetry" ].player_equipment_stats_count ?? 0, "kill_streak_expired_count", player.pers[ "telemetry" ].kill_streak_expired_count ?? 0, "player_loadout_count", player.pers[ "telemetry" ].player_loadout_count ?? 0, "operator", operatorstruct.operator ?? "", "operator_skin", operatorstruct.operator_skin ?? "", "operator_execution_ref", operatorstruct.operator_execution_ref ?? "none", "deadliest_weapon_name", var_7d284148c7e252c1.name ?? "", "deadliest_weapon_eliminations", var_7d284148c7e252c1.eliminations ?? 0, "deadliest_weapon_deaths", var_7d284148c7e252c1.deaths ?? 0, "deadliest_weapon_accuracy", var_7d284148c7e252c1.accuracy ?? 0, "lobby_id", lobby_id, "current_season", current_season, "is_ranked", is_ranked, "armor_collected", player.pers[ "telemetry" ].armor_collected ?? 0, "armor_equipped", player.pers[ "telemetry" ].armor_equipped ?? 0, "armor_destroyed", player.pers[ "telemetry" ].armor_destroyed ?? 0, "win_challenge_points_earned", player.pers[ "telemetry" ].var_bd01ba2a79bcab95 ?? 0, "vehicle_autofwd_count", player.pers[ "telemetry" ].vehicle_autofwd_count ?? 0, "ground_vehicle_used_count", player.pers[ "telemetry" ].ground_vehicle_used_count ?? 0, "air_vehicle_used_count", player.pers[ "telemetry" ].air_vehicle_used_count ?? 0, "is_controller", is_controller, "secondary_victory", istrue( player.extracted ), "holding_weapon_case", holding_weapon_case, "wall_bangs", player.pers[ "wallbangs" ], "best_squad_wipe_streak", best_squad_wipe_streak ?? 0, "reached_match_end", reached_match_end, "is_early_disconnect", is_early_disconnect, "has_bounty_royal_played", istrue( level.var_d7be75388b125a1c ), "loss_forgiven", player.loss_forgiven ?? 0, "is_prematch", is_prematch, "team_size", teamsize, "blackcell_loyalty", player.pers[ "telemetry" ].blackcell_loyalty ?? 0, "wall_bangs_damage", player.pers[ "wallbangsdamage" ], "bot_difficulty", botdifficulty ] );
    }
    
    if ( utility::issharedfuncdefined( #"telemetry", #"hash_c2ff97bbe61f0a3f" ) )
    {
        player [[ utility::getsharedfunc( #"telemetry", #"hash_c2ff97bbe61f0a3f" ) ]]();
    }
    
    disconnect_reason_string = "";
    
    if ( isdefined( data.disconnectreason ) )
    {
        if ( isxhash( data.disconnectreason ) || isxhashasset( data.disconnectreason ) || isxhash32( data.disconnectreason ) )
        {
            disconnect_reason_string = getxhashhexname( data.disconnectreason );
        }
        else
        {
            disconnect_reason_string = data.disconnectreason;
        }
    }
    
    var_ef414121cc2240a4 = "{\"disconnect_reason\":\"" + disconnect_reason_string + "\"}";
    recordeventforsreparser( "player_match_end", var_ef414121cc2240a4 );
    player.pers[ "telemetry" ].var_fa7df34e464eabdf = 1;
}

// Namespace telemetry_mp
// Params 0
// Checksum 0x90e375a5, Offset: 0x9fda
// Size: 0x7b
function function_1225d74b02c47ba()
{
    foreach ( player in level.players )
    {
        function_cda560a73c457824( player );
    }
}

// Namespace telemetry_mp
// Params 1
// Checksum 0x74b1514f, Offset: 0xa05d
// Size: 0x11a
function function_cda560a73c457824( player )
{
    if ( !isdefined( player.pers[ "telemetry" ].var_33fd5d5e0836fe64 ) )
    {
        if ( !telemetry_utils::is_valid_client( player ) )
        {
            return;
        }
        
        if ( player.var_5a792f9fdacf9283 && !level.gameended )
        {
            return;
        }
        
        if ( isdefined( level.var_c9483c125e3413d8 ) && level.var_c9483c125e3413d8 )
        {
            optin_selection = "OPTED_OUT";
            
            if ( player function_d0fae6719e9018ee() )
            {
                optin_selection = "OPTED_IN";
            }
            
            is_party_host = 0;
            
            if ( level.onlinegame )
            {
                is_party_host = player isfireteamleader();
            }
            
            player dlog_recordplayerevent( "dlog_event_mp_player_rematch_opt_in", [ "selection", optin_selection, "party_id", player getpartyid(), "is_party_host", is_party_host, "timed_out", 0 ] );
        }
        
        player.pers[ "telemetry" ].var_33fd5d5e0836fe64 = 1;
    }
}

// Namespace telemetry_mp
// Params 2
// Checksum 0x3ca18a94, Offset: 0xa17f
// Size: 0x128
function function_730ff856cab87e50( weaponobj, var_bf9e81b9aed1f6b1 = 1 )
{
    if ( !weaponobj )
    {
        assertmsg( "<dev string:x108>" );
        return "invalid_unified_weapon_name";
    }
    
    telemetrykey = level.var_408d62ecdaa48b0d[ weaponobj.basenamehash ];
    
    if ( telemetrykey )
    {
        return telemetrykey;
    }
    
    refname = supers_mp::getsuperrefforsuperweapon( weaponobj.basenamehash ) ?? equipment_mp::function_fdc4a655fbde0dec( weaponobj.basenamehash );
    
    if ( !refname )
    {
        if ( var_bf9e81b9aed1f6b1 )
        {
            assertmsg( "<dev string:x131>" + weaponobj.basename + "<dev string:x155>" );
        }
        
        return "invalid_unified_weapon_name";
    }
    
    telemetrykey = level.gamemodebundle.var_52709b1931d7bc48 ? refname + "_" + level.gamemodebundle.var_52709b1931d7bc48 : refname;
    
    if ( !isdefined( level.var_408d62ecdaa48b0d ) )
    {
        level.var_408d62ecdaa48b0d = [];
    }
    
    level.var_408d62ecdaa48b0d[ weaponobj.basenamehash ] = telemetrykey;
    return telemetrykey;
}

// Namespace telemetry_mp
// Params 4
// Checksum 0x79528f84, Offset: 0xa2b0
// Size: 0xeb
function function_80a95f340a7c8f67( var_b55ce0dcce6c4627, buffreceiver, weaponobj, instanceid )
{
    if ( !isdefined( weaponobj ) )
    {
        assertmsg( "<dev string:x18e>" );
        return;
    }
    
    if ( !( isdefined( var_b55ce0dcce6c4627 ) && isdefined( buffreceiver ) ) )
    {
        return;
    }
    
    if ( !isdefined( buffreceiver.buffinfo ) )
    {
        buffreceiver.buffinfo = [];
    }
    
    if ( !isdefined( buffreceiver.buffinfo[ weaponobj.basenamehash ] ) )
    {
        buffreceiver.buffinfo[ weaponobj.basenamehash ] = [];
    }
    
    buffreceiver.buffinfo[ weaponobj.basenamehash ][ buffreceiver.buffinfo[ weaponobj.basenamehash ].size ] = { #instanceid:instanceid, #var_b55ce0dcce6c4627:var_b55ce0dcce6c4627, #weaponobj:weaponobj };
}

// Namespace telemetry_mp
// Params 3
// Checksum 0x8755c65f, Offset: 0xa3a3
// Size: 0xfc
function function_c4080f7bf60d4131( buffreceiver, weaponobj, instanceid )
{
    if ( !isdefined( weaponobj ) )
    {
        assertmsg( "<dev string:x18e>" );
        return;
    }
    
    if ( !isdefined( buffreceiver.buffinfo[ weaponobj.basenamehash ] ) )
    {
        return;
    }
    
    foreach ( key, buffinstance in buffreceiver.buffinfo[ weaponobj.basenamehash ] )
    {
        if ( buffinstance.instanceid != instanceid )
        {
            continue;
        }
        
        buffreceiver.buffinfo[ weaponobj.basenamehash ][ key ] = undefined;
    }
}

// Namespace telemetry_mp
// Params 4
// Checksum 0x201711b4, Offset: 0xa4a7
// Size: 0x81
function function_e097bffa2fd8f2a0( player, weaponobj, instanceid, delayseconds = level.framedurationseconds )
{
    delayseconds = max( delayseconds, level.framedurationseconds );
    var_d6e9778e6b9b6d1a = level utility::waittill_notify_or_timeout( "game_ended", delayseconds );
    
    if ( !( isdefined( player ) && isdefined( weaponobj ) && isdefined( instanceid ) ) )
    {
        return;
    }
    
    function_c4080f7bf60d4131( player, weaponobj, instanceid );
}

// Namespace telemetry_mp
// Params 4
// Checksum 0x668931c4, Offset: 0xa530
// Size: 0x81
function function_c66882927ed29e53( player, weaponobj, instanceid, delayseconds = level.framedurationseconds )
{
    delayseconds = max( delayseconds, level.framedurationseconds );
    var_d6e9778e6b9b6d1a = level utility::waittill_notify_or_timeout( "game_ended", delayseconds );
    
    if ( !( isdefined( player ) && isdefined( weaponobj ) && isdefined( instanceid ) ) )
    {
        return;
    }
    
    function_edb43d25c7bd56c6( player, weaponobj, instanceid );
}

// Namespace telemetry_mp
// Params 3
// Checksum 0xe843aebb, Offset: 0xa5b9
// Size: 0x1a6
function function_75399aefea54c661( attacker, victim, hoststruct )
{
    foreach ( var_b09f4280daaf720a in attacker.buffinfo )
    {
        foreach ( buffinstance in var_b09f4280daaf720a )
        {
            var_b55ce0dcce6c4627 = buffinstance.var_b55ce0dcce6c4627;
            var_6174d9c6337324c4 = buffinstance.weaponobj;
            
            if ( !player_utility::playersareenemies( attacker, victim ) )
            {
                continue;
            }
            
            if ( function_629810b8aa596911( hoststruct, var_6174d9c6337324c4, attacker, "buff_death" ) )
            {
                if ( attacker == var_b55ce0dcce6c4627 )
                {
                    attacker function_89a5d8fb8ed3a4fe( hoststruct, attacker, buffinstance.instanceid, var_6174d9c6337324c4 );
                    attacker thread gamelogic_mp::threadedsetweaponstatbyname( var_6174d9c6337324c4, 1, "buff_kills" );
                }
                else
                {
                    var_b55ce0dcce6c4627 thread gamelogic_mp::threadedsetweaponstatbyname( var_6174d9c6337324c4, 1, "buff_assists" );
                }
                
                victim thread gamelogic_mp::threadedsetweaponstatbyname( var_6174d9c6337324c4, 1, "killed_by_player_buffed_by", undefined, var_b55ce0dcce6c4627 );
            }
        }
    }
    
    victim.buffinfo = undefined;
}

// Namespace telemetry_mp
// Params 4
// Checksum 0x3d8f0a41, Offset: 0xa767
// Size: 0xdd
function function_594cbdc6a4d8098a( victim, attacker, weaponobj, instanceid )
{
    if ( !isdefined( weaponobj ) )
    {
        assertmsg( "<dev string:x18e>" );
        return;
    }
    
    if ( !isdefined( victim.debuffinfo ) )
    {
        victim.debuffinfo = [];
    }
    
    if ( !isdefined( victim.debuffinfo[ weaponobj.basenamehash ] ) )
    {
        victim.debuffinfo[ weaponobj.basenamehash ] = [];
    }
    
    victim.debuffinfo[ weaponobj.basenamehash ][ victim.debuffinfo[ weaponobj.basenamehash ].size ] = { #instanceid:instanceid, #attacker:attacker, #weaponobj:weaponobj };
}

// Namespace telemetry_mp
// Params 3
// Checksum 0x2c322ab7, Offset: 0xa84c
// Size: 0xfc
function function_edb43d25c7bd56c6( victim, weaponobj, instanceid )
{
    if ( !isdefined( weaponobj ) )
    {
        assertmsg( "<dev string:x18e>" );
        return;
    }
    
    if ( !isdefined( victim.debuffinfo[ weaponobj.basenamehash ] ) )
    {
        return;
    }
    
    foreach ( key, debuffinstance in victim.debuffinfo[ weaponobj.basenamehash ] )
    {
        if ( debuffinstance.instanceid != instanceid )
        {
            continue;
        }
        
        victim.debuffinfo[ weaponobj.basenamehash ][ key ] = undefined;
    }
}

// Namespace telemetry_mp
// Params 3
// Checksum 0x8967b53a, Offset: 0xa950
// Size: 0x1d9
function function_6b08bb7eb0006e2e( attacker, victim, hoststruct )
{
    foreach ( var_aacf9b300eee2783 in victim.debuffinfo )
    {
        foreach ( debuffinstance in var_aacf9b300eee2783 )
        {
            debuffattacker = debuffinstance.attacker;
            var_7b609195052d70a9 = debuffinstance.weaponobj;
            
            if ( !player_utility::playersareenemies( debuffattacker, victim ) )
            {
                continue;
            }
            
            if ( function_629810b8aa596911( hoststruct, var_7b609195052d70a9, debuffattacker, "debuff_death" ) )
            {
                if ( attacker == debuffattacker )
                {
                    debuffattacker function_89a5d8fb8ed3a4fe( hoststruct, debuffattacker, debuffinstance.instanceid, var_7b609195052d70a9 );
                    debuffattacker thread gamelogic_mp::threadedsetweaponstatbyname( var_7b609195052d70a9, 1, "debuff_kills" );
                }
                else
                {
                    debuffattacker thread gamelogic_mp::threadedsetweaponstatbyname( var_7b609195052d70a9, 1, "debuff_assists" );
                }
                
                var_7754a4583dbe5809 = debuffattacker.var_ec0bb630fbaa253a[ var_7b609195052d70a9.basename ];
                
                if ( var_7754a4583dbe5809 )
                {
                    victim killstreak::function_7acb73c1355e75ce( attacker, debuffattacker, var_7754a4583dbe5809 );
                }
                
                victim thread gamelogic_mp::threadedsetweaponstatbyname( var_7b609195052d70a9, 1, "killed_while_debuffed_by", undefined, attacker );
            }
        }
    }
    
    victim.debuffinfo = undefined;
}

// Namespace telemetry_mp
// Params 4, eflags: 0x4
// Checksum 0x83b47c4, Offset: 0xab31
// Size: 0x10b, Type: bool
function private function_629810b8aa596911( hoststruct, weaponobj, attacker, recordname )
{
    attackerid = attacker getentitynumber();
    
    if ( !isdefined( hoststruct ) || isdefined( hoststruct.recordedattackers[ weaponobj.basename ][ attackerid ][ recordname ] ) )
    {
        return false;
    }
    
    if ( !isdefined( hoststruct.recordedattackers ) )
    {
        hoststruct.recordedattackers = [];
    }
    
    if ( !isdefined( hoststruct.recordedattackers[ weaponobj.basename ] ) )
    {
        hoststruct.recordedattackers[ weaponobj.basename ] = [];
    }
    
    if ( !isdefined( hoststruct.recordedattackers[ weaponobj.basename ][ attackerid ] ) )
    {
        hoststruct.recordedattackers[ weaponobj.basename ][ attackerid ] = [];
    }
    
    hoststruct.recordedattackers[ weaponobj.basename ][ attackerid ][ recordname ] = 1;
    return true;
}

// Namespace telemetry_mp
// Params 4, eflags: 0x4
// Checksum 0xd63a7ed2, Offset: 0xac45
// Size: 0x5d, Type: bool
function private function_3712c682831fec38( hoststruct, weaponobj, attacker, recordname )
{
    attackerid = attacker getentitynumber();
    
    if ( isdefined( hoststruct.recordedattackers[ weaponobj.basename ][ attackerid ][ recordname ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace telemetry_mp
// Params 4, eflags: 0x4
// Checksum 0x8acc784d, Offset: 0xacab
// Size: 0xb9
function private function_f4fffcd0724c3950( attacker, instanceid, weaponobj, var_e369faffe72ce40d )
{
    foreach ( entry in attacker.var_83ddb6f721a2b638[ weaponobj.basename ] )
    {
        if ( entry.id == instanceid )
        {
            return entry;
        }
    }
}

// Namespace telemetry_mp
// Params 5, eflags: 0x4
// Checksum 0x9a3f77da, Offset: 0xad6d
// Size: 0x1fe
function private function_d980c63c830a7c1d( hoststruct, attacker, instanceid, weaponobj, var_e369faffe72ce40d )
{
    if ( isdefined( hoststruct ) && !function_629810b8aa596911( hoststruct, weaponobj, attacker, var_e369faffe72ce40d ) )
    {
        return;
    }
    
    if ( !isdefined( weaponobj.basename ) )
    {
        assertmsg( "<dev string:x1b6>" );
        return;
    }
    
    if ( !isdefined( attacker.var_83ddb6f721a2b638 ) )
    {
        attacker.var_83ddb6f721a2b638 = [];
    }
    
    if ( !isdefined( attacker.var_83ddb6f721a2b638[ weaponobj.basename ] ) )
    {
        attacker.var_83ddb6f721a2b638[ weaponobj.basename ] = [];
    }
    
    foreach ( entry in attacker.var_83ddb6f721a2b638[ weaponobj.basename ] )
    {
        if ( entry.id == instanceid )
        {
            return entry;
        }
    }
    
    if ( attacker.var_83ddb6f721a2b638[ weaponobj.basename ].size >= 4 )
    {
        attacker.var_83ddb6f721a2b638[ weaponobj.basename ][ attacker.var_83ddb6f721a2b638[ weaponobj.basename ].size - 1 ] = undefined;
    }
    
    attacker.var_83ddb6f721a2b638[ weaponobj.basename ] = arraycombine( [ { #id:instanceid, #stats:[] } ], attacker.var_83ddb6f721a2b638[ weaponobj.basename ] );
    return attacker.var_83ddb6f721a2b638[ weaponobj.basename ][ 0 ];
}

// Namespace telemetry_mp
// Params 5, eflags: 0x4
// Checksum 0xc0137015, Offset: 0xaf74
// Size: 0x92
function private function_b1339e980e0933f( hoststruct, attacker, instanceid, weaponobj, var_e369faffe72ce40d )
{
    statentry = function_d980c63c830a7c1d( hoststruct, attacker, instanceid, weaponobj, var_e369faffe72ce40d );
    
    if ( !isdefined( statentry ) )
    {
        return;
    }
    
    if ( !isdefined( statentry.stats[ var_e369faffe72ce40d ] ) )
    {
        statentry.stats[ var_e369faffe72ce40d ] = 0;
    }
    
    statentry.stats[ var_e369faffe72ce40d ] += 1;
}

// Namespace telemetry_mp
// Params 6, eflags: 0x4
// Checksum 0x5d73cab8, Offset: 0xb00e
// Size: 0x81
function private function_26a2672bba04b96c( hoststruct, attacker, instanceid, weaponobj, var_e369faffe72ce40d, var_96e1298aef4a261a )
{
    statentry = function_d980c63c830a7c1d( hoststruct, attacker, instanceid, weaponobj, var_e369faffe72ce40d );
    
    if ( !isdefined( statentry ) )
    {
        return;
    }
    
    if ( var_96e1298aef4a261a > ( statentry.stats[ var_e369faffe72ce40d ] ?? 0 ) )
    {
        statentry.stats[ var_e369faffe72ce40d ] = var_96e1298aef4a261a;
    }
}

// Namespace telemetry_mp
// Params 4
// Checksum 0xa31737be, Offset: 0xb097
// Size: 0x52
function function_89a5d8fb8ed3a4fe( deathdata, attacker, instanceid, weaponobj )
{
    self notify( #"hash_b7d271092eeeddba" );
    self endon( #"hash_b7d271092eeeddba" );
    function_c30275046afb21e5( deathdata, attacker, instanceid, weaponobj, "most_kills_per_use", 0 );
}

// Namespace telemetry_mp
// Params 3
// Checksum 0xc966ab2b, Offset: 0xb0f1
// Size: 0x48
function function_36100e50dccb52fa( attacker, instanceid, weaponobj )
{
    self notify( #"hash_10d08b7d7174a4e4" );
    self endon( #"hash_10d08b7d7174a4e4" );
    function_c30275046afb21e5( undefined, attacker, instanceid, weaponobj, "most_equipment_destructions_per_use", 0 );
}

// Namespace telemetry_mp
// Params 3
// Checksum 0xf228e777, Offset: 0xb141
// Size: 0x48
function function_b653df8a1833e78d( attacker, instanceid, weaponobj )
{
    self notify( #"hash_13b135c5c68d1cac" );
    self endon( #"hash_13b135c5c68d1cac" );
    function_c30275046afb21e5( undefined, attacker, instanceid, weaponobj, "most_restocks_per_use", 0 );
}

// Namespace telemetry_mp
// Params 3
// Checksum 0xb45ed0d0, Offset: 0xb191
// Size: 0x4a
function function_7640fb4384ba46fa( attacker, weaponobj, killdistance )
{
    self notify( #"hash_c4e62cfab5232f9b" );
    self endon( #"hash_c4e62cfab5232f9b" );
    function_275d40cd6d41061a( undefined, attacker, weaponobj, "furthest_kill", killdistance, 1 );
}

// Namespace telemetry_mp
// Params 6, eflags: 0x4
// Checksum 0xfcf3a4c0, Offset: 0xb1e3
// Size: 0x104
function private function_9b7edd35439c67a4( hoststruct, attacker, instanceid, weaponobj, var_e369faffe72ce40d, var_c87a85c8f61f6965 )
{
    issuper = weapon::issuperweapon( weaponobj );
    var_1e16d16e6da8beb5 = supers_mp::shouldtracksuperweaponstats( weaponobj );
    
    if ( issuper && !var_1e16d16e6da8beb5 )
    {
        return;
    }
    
    if ( !var_c87a85c8f61f6965 )
    {
        isequipment = equipment_mp::function_65ff545a795c7f55( weaponobj );
        
        if ( !( issuper || isequipment ) )
        {
            return;
        }
    }
    
    if ( !isdefined( instanceid ) )
    {
        return;
    }
    
    var_3546ccb81708d7ce = equipment_mp::getequipmentreffromweapon( weaponobj );
    var_33057efa72a9b2fc = equipment_mp::getweaponfromequipmentref( var_3546ccb81708d7ce );
    
    if ( !isdefined( var_33057efa72a9b2fc ) )
    {
        if ( isequipment )
        {
            assertmsg( "<dev string:x200>" + ( weaponobj.basename ?? "<dev string:x267>" ) );
            return;
        }
        else
        {
            var_33057efa72a9b2fc = weaponobj;
        }
    }
    
    if ( function_3712c682831fec38( hoststruct, var_33057efa72a9b2fc, attacker, var_e369faffe72ce40d ) )
    {
        return;
    }
    
    return var_33057efa72a9b2fc;
}

// Namespace telemetry_mp
// Params 6, eflags: 0x4
// Checksum 0x8d32c1f7, Offset: 0xb2f0
// Size: 0xfb
function private function_c30275046afb21e5( hoststruct, attacker, instanceid, weaponobj, var_e369faffe72ce40d, var_64c72e7816d35b0b )
{
    var_33057efa72a9b2fc = function_9b7edd35439c67a4( hoststruct, attacker, instanceid, weaponobj, var_e369faffe72ce40d, var_64c72e7816d35b0b );
    
    if ( !isdefined( var_33057efa72a9b2fc ) )
    {
        return;
    }
    
    function_b1339e980e0933f( hoststruct, attacker, instanceid, var_33057efa72a9b2fc, var_e369faffe72ce40d );
    entry = function_f4fffcd0724c3950( attacker, instanceid, var_33057efa72a9b2fc, var_e369faffe72ce40d );
    var_faae48336b943203 = entry.stats[ var_e369faffe72ce40d ] ?? 0;
    fullweaponname = getcompleteweaponname( var_33057efa72a9b2fc );
    recordedmax = attacker.pers[ "weaponStats" ][ fullweaponname ].stats[ var_e369faffe72ce40d ] ?? 0;
    additional = var_faae48336b943203 - recordedmax;
    
    if ( additional > 0 )
    {
        attacker gamelogic_mp::setweaponstat( var_33057efa72a9b2fc, additional, var_e369faffe72ce40d );
    }
}

// Namespace telemetry_mp
// Params 6, eflags: 0x4
// Checksum 0x25da4fee, Offset: 0xb3f3
// Size: 0xfc
function private function_275d40cd6d41061a( hoststruct, attacker, weaponobj, var_e369faffe72ce40d, var_96e1298aef4a261a, var_64c72e7816d35b0b )
{
    var_33057efa72a9b2fc = function_9b7edd35439c67a4( hoststruct, attacker, 0, weaponobj, var_e369faffe72ce40d, var_64c72e7816d35b0b );
    
    if ( !isdefined( var_33057efa72a9b2fc ) )
    {
        return;
    }
    
    function_26a2672bba04b96c( hoststruct, attacker, 0, var_33057efa72a9b2fc, var_e369faffe72ce40d, var_96e1298aef4a261a );
    entry = function_f4fffcd0724c3950( attacker, 0, var_33057efa72a9b2fc, var_e369faffe72ce40d );
    var_faae48336b943203 = entry.stats[ var_e369faffe72ce40d ] ?? 0;
    fullweaponname = getcompleteweaponname( var_33057efa72a9b2fc );
    recordedmax = attacker.pers[ "weaponStats" ][ fullweaponname ].stats[ var_e369faffe72ce40d ] ?? 0;
    additional = var_faae48336b943203 - recordedmax;
    
    if ( additional > 0 )
    {
        attacker gamelogic_mp::setweaponstat( var_33057efa72a9b2fc, additional, var_e369faffe72ce40d );
    }
}

// Namespace telemetry_mp
// Params 3
// Checksum 0x40fb69ba, Offset: 0xb4f7
// Size: 0x60
function function_cbf4eaf678a574e3( victim, killstreakname, var_d38711dabd8d9b5e )
{
    if ( !victim )
    {
        return;
    }
    
    victim dlog_recordplayerevent( "dlog_event_kill_streak_killed_by", [ "killstreak_name", killstreakname ?? "", "streak_source", var_d38711dabd8d9b5e ?? "" ] );
}

// Namespace telemetry_mp
// Params 1
// Checksum 0xb0af8f40, Offset: 0xb55f
// Size: 0xb0
function function_3a70f4799d2d7acc( victim )
{
    detectioninfo = uav::function_48f6c3c47f835e04( victim );
    
    if ( detectioninfo.var_12767a1b38aa5cfd )
    {
        function_cbf4eaf678a574e3( victim, detectioninfo.var_93d3341a759026a5 ?? "empty_auav_name", "" );
    }
    else if ( detectioninfo.var_2346079f5ac9d337 )
    {
        function_cbf4eaf678a574e3( victim, detectioninfo.var_1bdaf6fcb3cd5db5 ?? "empty_uav_name", "" );
    }
    
    if ( detectioninfo.var_46e10151815ffaaa )
    {
        function_cbf4eaf678a574e3( victim, detectioninfo.var_a6a18268a321061b ?? "empty_cuav_name", "" );
    }
}

// Namespace telemetry_mp
// Params 1
// Checksum 0x8f2bcd47, Offset: 0xb617
// Size: 0x1b0
function on_ai_killed( params )
{
    if ( !level.disablestattracking )
    {
        if ( self.death_source == "despawn" )
        {
            return;
        }
        
        if ( !telemetry_utils::is_valid_client( params.eattacker ) )
        {
            return;
        }
        
        ai_killed_event = spawnstruct();
        throttle::throttle_wait_in_queue( level.mp_ai_killed_telemetry_throttle, ai_killed_event );
        
        if ( !isdefined( params.eattacker ) )
        {
            return;
        }
        
        if ( isnullweapon( params.sweapon ) )
        {
            return;
        }
        
        if ( isdefined( params.eattacker.pers[ "telemetry" ].ai_agent_kills ) )
        {
            params.eattacker.pers[ "telemetry" ].ai_agent_kills++;
        }
        
        telemetry_data = { #weaponobj:params.sweapon, #variantid:getweaponvariantindex( params.sweapon ), #statupdates:[ { #value:1, #name:"ai_agent_kills" } ], #fullweaponname:getcompleteweaponname( params.sweapon ), #weaponname:weapon::getweaponrootname( params.sweapon ) };
        assert( level.telemetry_callbacks[ "<dev string:x268>" ].size == 1, "<dev string:x285>" );
        
        if ( params.smeansofdeath != "MOD_EXECUTION" )
        {
            params.eattacker update_weapon_stats( telemetry_data );
        }
    }
}

// Namespace telemetry_mp
// Params 0, eflags: 0x4
// Checksum 0x8049b91, Offset: 0xb7cf
// Size: 0x81
function private function_ea796f5a715af435()
{
    if ( !isdefined( level.gametypebundle.var_162edba954f66870 ) )
    {
        level.gametypebundle.var_162edba954f66870 = #"nowait";
    }
    
    switch ( level.gametypebundle.var_162edba954f66870 )
    {
        case #"nowait":
            return;
        case #"slowprocessing":
        default:
            script::waittillslowprocessallowed( 1, 1 );
            return;
    }
}

// Namespace telemetry_mp
// Params 2
// Checksum 0xf0f00701, Offset: 0xb858
// Size: 0x1352
function on_player_death( data, called_from )
{
    profilestart();
    attacker = data.attacker;
    victim = data.victim;
    
    if ( !telemetry_utils::is_valid_client( victim ) )
    {
        profilestop();
        return;
    }
    
    weapon_string = data.weaponfullstring ?? "";
    means_of_death = data.meansofdeath ?? "";
    spawntime = victim.spawntime ?? 0;
    time = gettime();
    spawn_time_from_match_start_ms = telemetry_utils::get_time_from_match_start( spawntime );
    death_time_from_match_start_ms = telemetry_utils::get_time_from_match_start( time );
    life_index = victim.pers[ "telemetry" ].life.life_index ?? -1;
    
    if ( victim.pers[ "telemetry" ].life.var_b9df4af82e4b39e9 == life_index )
    {
        profilestop();
        return;
    }
    
    attacker_death_modifiers = [];
    victimorigin = victim.origin;
    victimangles = victim.angles;
    var_66ca5d2c052ac026 = telemetry_utils::is_valid_client( attacker );
    
    if ( var_66ca5d2c052ac026 )
    {
        attacker_weapon = getweaponbasename( weapon_string );
        var_88517351cae22e7e = attacker;
        attacker_weapon_picked_up = attacker weapon::ispickedupweapon( weapon_string, data.weapongroup );
        attacker_weapon_alt_mode = attacker isalternatemode( weapon_string );
        
        if ( weapon::iscacprimaryorsecondary( weapon_string, data.weapongroup ) )
        {
            attacker_ads_value = attacker playerads();
        }
        
        attacker_pos = attacker.origin;
        attacker_angles = attacker.angles;
        attacker_mount_type = attacker telemetry_utils::function_cae236c583ce98fe();
        attacker_life_index = attacker.pers[ "telemetry" ].life.life_index;
        attacker_loadout_index = attacker.loadoutindex;
        attacker_death_modifiers = attacker telemetry_utils::get_death_modifiers();
        
        if ( attacker.perks.size > 0 )
        {
            attacker function_1b4c783911ce25d6( attacker.perks );
        }
    }
    else
    {
        var_88517351cae22e7e = undefined;
        
        if ( isagent( attacker ) )
        {
            attacker_was_ai = 1;
            ai_tier = attacker.agent_type;
            attacker_pos = attacker.origin;
            attacker_angles = attacker.angles;
        }
        else
        {
            attacker_pos = ( 0, 0, 0 );
            attacker_angles = ( 0, 0, 0 );
        }
    }
    
    victim_death_modifiers = victim telemetry_utils::get_death_modifiers();
    victimcurrentweapon = player::isinlaststand( victim ) && isdefined( victim.laststandoldweaponobj ) ? victim.laststandoldweaponobj : victim.lastweaponused;
    
    if ( isdefined( victimcurrentweapon ) )
    {
        victim_weapon_picked_up = victim weapon::ispickedupweapon( victimcurrentweapon );
        victim_weapon_alt_mode = victim isalternatemode( victimcurrentweapon, 0, 1 );
        victim_ads_value = victim playerads();
    }
    else
    {
        victim_weapon_picked_up = 0;
        victim_weapon_alt_mode = 0;
        victim_ads_value = 0;
    }
    
    victim_mount_type = victim telemetry_utils::function_cae236c583ce98fe();
    victim_loadout_index = victim.loadoutindex;
    xp_earned = 0;
    currentxp = victim.pers[ "summary" ][ "xp" ];
    
    if ( isdefined( currentxp ) )
    {
        xp_earned = currentxp - victim.pers[ "telemetry" ].life.var_cf1e1f502926dd46;
    }
    
    score_earned = victim.score - victim.pers[ "telemetry" ].life.var_18c9be0a7e4ab2ac;
    round = -1;
    
    if ( game_utility_mp::isroundbased() )
    {
        round = game[ "roundsPlayed" ];
        
        if ( means_of_death == "MOD_GAME_ENDED" || means_of_death == "MOD_ROUND_ENDED" )
        {
            round--;
            
            if ( round < 0 )
            {
                round = 0;
            }
        }
    }
    
    is_hipfire = attacker.modifiers[ "hipfire" ];
    spawn_pos = victim.spawnpos;
    was_tactical_insertion = victim.wasti;
    spawn_evaluation_id = victim.var_af6d8f2a60e3cf4a;
    
    if ( isdefined( attacker ) )
    {
        attacker_shooting_mode = attacker.pers[ "shootingMode" ];
    }
    
    victim_shooting_mode = victim.pers[ "shootingMode" ];
    
    if ( isdefined( victim.var_c8e77c8b66f05eaa ) )
    {
        first_damage_delivered_time_ms = telemetry_utils::get_time_from_match_start( victim.var_c8e77c8b66f05eaa );
    }
    
    if ( isdefined( victim.var_d15047abc75b9fb7 ) )
    {
        first_damage_received_time_ms = telemetry_utils::get_time_from_match_start( victim.var_d15047abc75b9fb7 );
    }
    
    first_engagement_per_life_ms = victim.var_13e00284b1601b70;
    incomingdamage = victim.var_52134643987847ec;
    outgoingdamage = victim.lifetimedamage;
    victimteam = victim.team;
    victimishost = victim ishost();
    victim_was_reloading = victim isreloading();
    victim_was_executing = victim isinexecutionattack();
    victimxuid = victim getxuid();
    victimclientid = victim.clientid;
    attackerteam = attacker.team;
    attackerxuid = var_66ca5d2c052ac026 ? attacker getxuid() : 0;
    attackerclientid = attacker.clientid;
    
    if ( isdefined( var_88517351cae22e7e ) )
    {
        var_6c2c150894af98a9 = var_88517351cae22e7e getplayermovementstate();
    }
    
    profilestop();
    var_ee31475fb5cc7e82 = 1;
    
    if ( called_from == #"on_player_disconnect" )
    {
        var_ee31475fb5cc7e82 = 0;
    }
    
    if ( var_ee31475fb5cc7e82 )
    {
        function_ea796f5a715af435();
    }
    
    if ( victim.pers[ "telemetry" ].life.var_b9df4af82e4b39e9 === life_index )
    {
        return;
    }
    
    means_of_death_hash = getxhash( means_of_death );
    
    if ( var_66ca5d2c052ac026 || attacker_was_ai )
    {
        attacker_was_in_victim_fov = withinfov( victimorigin, victimangles, attacker_pos, 0.4226 );
        victim_was_in_attacker_fov = withinfov( attacker_pos, attacker_angles, victimorigin, 0.4226 );
    }
    
    if ( weapon_string == "agent_mp" )
    {
        attacker_weapon_attachments = [];
    }
    else
    {
        var_472e8411f3728998 = getweaponattachments( weapon_string );
        attacker_weapon_attachments = weapon::attachmentsfilterforstats( var_472e8411f3728998, weapon_string );
    }
    
    victim_weapon_attachments = [];
    victim_weapon = "";
    
    if ( isdefined( victimcurrentweapon ) )
    {
        var_fe424b2ef187de97 = getweaponattachments( victimcurrentweapon );
        victim_weapon_attachments = weapon::attachmentsfilterforstats( var_fe424b2ef187de97, victimcurrentweapon );
        victim_weapon = getweaponbasename( victimcurrentweapon );
        
        /#
            if ( victim_weapon == "<dev string:x2bb>" )
            {
                InvalidOpCode( 0x2 );
                // Unknown operator ( 0x2, t11, Black Ops 7 )
            }
        #/
    }
    
    victim_star_level = -1;
    victim_poi = #"unknown";
    poi_star_level = -1;
    
    if ( isplayer( victim ) )
    {
        if ( utility::issharedfuncdefined( #"dmz_star_system", #"get_player_star_level" ) )
        {
            victim_star_level = [[ utility::getsharedfunc( #"dmz_star_system", #"get_player_star_level" ) ]]( victim );
        }
        
        if ( utility::issharedfuncdefined( #"hash_7160a636b947b0d", #"hash_f14c637523d65993" ) )
        {
            victim_poi = [[ utility::getsharedfunc( #"hash_7160a636b947b0d", #"hash_f14c637523d65993" ) ]]( victimorigin, 1 );
        }
        
        if ( utility::issharedfuncdefined( #"dmz_star_system", #"hash_87cef5439a4b9eda" ) )
        {
            poi_star_level = [[ utility::getsharedfunc( #"dmz_star_system", #"hash_87cef5439a4b9eda" ) ]]( victim_poi );
        }
    }
    
    if ( !isdefined( victim ) )
    {
        return;
    }
    
    if ( !isdefined( var_88517351cae22e7e ) )
    {
        var_88517351cae22e7e = undefined;
    }
    
    if ( function_97de808fe549b3b7() )
    {
        victim function_ad05aed95a44741e( -7285091616948939839, [ 86:poi_star_level ?? -1, 85:victim_poi ?? #"unknown", 84:victim_star_level ?? -1, 83:var_6c2c150894af98a9.isdoublejump ?? 0, 82:var_6c2c150894af98a9.iswalljump ?? 0, 81:var_6c2c150894af98a9.isjump ?? 0, 80:var_6c2c150894af98a9.isinair ?? 0, 79:var_6c2c150894af98a9.iswallrun ?? 0, 78:var_6c2c150894af98a9.var_970e028f986ace43 ?? 0, 77:var_6c2c150894af98a9.var_b470e64cd4f4930f ?? 0, 76:var_6c2c150894af98a9.isslide ?? 0, 75:var_6c2c150894af98a9.var_50a5c93322d764b6 ?? 0, 74:var_6c2c150894af98a9.issprint ?? 0, 73:var_6c2c150894af98a9.iswalk ?? 0, 72:var_6c2c150894af98a9.var_b30d6737b826b6d9 ?? 0, 71:var_6c2c150894af98a9.isdivetoprone ?? 0, 70:var_6c2c150894af98a9.ismantle ?? 0, 69:var_6c2c150894af98a9.iscrouch ?? 0, 68:var_6c2c150894af98a9.isprone ?? 0, 67:var_6c2c150894af98a9.issupine ?? 0, 66:var_6c2c150894af98a9.ismeatshieldattacker ?? 0, 65:var_6c2c150894af98a9.ismeatshieldvictim ?? 0, 64:var_6c2c150894af98a9.ismeatshield ?? 0, 61:first_engagement_per_life_ms ?? 0, 60:ai_tier ?? "", 59:float( incomingdamage ?? -1 ), 58:float( outgoingdamage ?? -1 ), 57:istrue( attacker_was_ai ), 56:first_damage_received_time_ms ?? 0, 55:first_damage_delivered_time_ms ?? 0, 54:victim_shooting_mode ?? "1st", 53:attacker_shooting_mode ?? "1st", 52:istrue( is_hipfire ), 51:round, 50:victim_was_executing, 49:victim_was_reloading, 48:attacker_loadout_index ?? -1, 47:attacker_life_index ?? -1, 46:victim_loadout_index ?? -1, 45:score_earned, 44:xp_earned, 43:victim_mount_type, attacker_mount_type ?? "MOUNT_NONE", 41:istrue( victim_was_in_attacker_fov ), 40:istrue( attacker_was_in_victim_fov ), 39:victim_ads_value, 38:attacker_ads_value ?? 0, 37:victim_weapon_picked_up, 36:victim_weapon_alt_mode, 35:istrue( attacker_weapon_picked_up ), 34:istrue( attacker_weapon_alt_mode ), 33:means_of_death_hash, 32:attacker_angles[ 2 ], 31:attacker_angles[ 1 ], 30:attacker_angles[ 0 ], 29:attacker_pos[ 2 ], 28:attacker_pos[ 1 ], 27:attacker_pos[ 0 ], 26:victimangles[ 2 ], 25:victimangles[ 1 ], 24:victimangles[ 0 ], 23:victimorigin[ 2 ], 22:victimorigin[ 1 ], 21:victimorigin[ 0 ], 20:attacker_death_modifiers, 19:victim_death_modifiers, 18:attacker_weapon_attachments, 17:attacker_weapon ?? "", 16:victim_weapon_attachments, 15:victim_weapon, 14:death_time_from_match_start_ms, 13:istrue( was_tactical_insertion ), 12:victimishost, 11:victimteam, 10:spawn_pos[ 2 ] ?? 0, 9:spawn_pos[ 1 ] ?? 0, 8:spawn_pos[ 0 ] ?? 0, 7:spawn_evaluation_id ?? 0, 6:life_index, 5:spawn_time_from_match_start_ms, 4:var_88517351cae22e7e ] );
    }
    else
    {
        victim dlog_recordplayerevent( "dlog_event_mp_life", [ "attacker", var_88517351cae22e7e, "spawn_time_from_match_start_ms", spawn_time_from_match_start_ms, "life_index", life_index, "spawn_evaluation_id", spawn_evaluation_id ?? 0, "spawn_pos_x", spawn_pos[ 0 ] ?? 0, "spawn_pos_y", spawn_pos[ 1 ] ?? 0, "spawn_pos_z", spawn_pos[ 2 ] ?? 0, "team", victimteam, "is_host", victimishost, "was_tactical_insertion", istrue( was_tactical_insertion ), "death_time_from_match_start_ms", death_time_from_match_start_ms, "victim_weapon", victim_weapon, "victim_weapon_attachments", victim_weapon_attachments, "attacker_weapon", attacker_weapon ?? "", "attacker_weapon_attachments", attacker_weapon_attachments, "victim_death_modifiers", victim_death_modifiers, "attacker_death_modifiers", attacker_death_modifiers, "death_pos_x", victimorigin[ 0 ], "death_pos_y", victimorigin[ 1 ], "death_pos_z", victimorigin[ 2 ], "death_angle_x", victimangles[ 0 ], "death_angle_y", victimangles[ 1 ], "death_angle_z", victimangles[ 2 ], "attacker_pos_x", attacker_pos[ 0 ], "attacker_pos_y", attacker_pos[ 1 ], "attacker_pos_z", attacker_pos[ 2 ], "attacker_angle_x", attacker_angles[ 0 ], "attacker_angle_y", attacker_angles[ 1 ], "attacker_angle_z", attacker_angles[ 2 ], "means_of_death", means_of_death_hash, "attacker_weapon_alt_mode", istrue( attacker_weapon_alt_mode ), "attacker_weapon_picked_up", istrue( attacker_weapon_picked_up ), "victim_weapon_alt_mode", victim_weapon_alt_mode, "victim_weapon_picked_up", victim_weapon_picked_up, "attacker_ads_value", attacker_ads_value ?? 0, "victim_ads_value", victim_ads_value, "attacker_was_in_victim_fov", istrue( attacker_was_in_victim_fov ), "victim_was_in_attacker_fov", istrue( victim_was_in_attacker_fov ), "attacker_mount_type", attacker_mount_type ?? "MOUNT_NONE", "victim_mount_type", victim_mount_type, "xp_earned", xp_earned, "score_earned", score_earned, "victim_loadout_index", victim_loadout_index ?? -1, "attacker_life_index", attacker_life_index ?? -1, "attacker_loadout_index", attacker_loadout_index ?? -1, "victim_was_reloading", victim_was_reloading, "victim_was_executing", victim_was_executing, "round", round, "is_hipfire", istrue( is_hipfire ), "attacker_shooting_mode", attacker_shooting_mode ?? "1st", "victim_shooting_mode", victim_shooting_mode ?? "1st", "first_damage_delivered_time_ms", first_damage_delivered_time_ms ?? 0, "first_damage_received_time_ms", first_damage_received_time_ms ?? 0, "attacker_was_ai", istrue( attacker_was_ai ), "lifetime_damage_dealt", float( outgoingdamage ?? -1 ), "lifetime_damage_received", float( incomingdamage ?? -1 ), "ai_tier", ai_tier ?? "", "first_engagement_per_life_ms", first_engagement_per_life_ms ?? 0, "attacker_is_meat_shield", var_6c2c150894af98a9.ismeatshield ?? 0, "attacker_is_meat_shield_victim", var_6c2c150894af98a9.ismeatshieldvictim ?? 0, "attacker_is_meat_shield_attacker", var_6c2c150894af98a9.ismeatshieldattacker ?? 0, "attacker_is_supine", var_6c2c150894af98a9.issupine ?? 0, "attacker_is_prone", var_6c2c150894af98a9.isprone ?? 0, "attacker_is_crouch", var_6c2c150894af98a9.iscrouch ?? 0, "attacker_is_mantle", var_6c2c150894af98a9.ismantle ?? 0, "attacker_is_dtp", var_6c2c150894af98a9.isdivetoprone ?? 0, "attacker_is_non_forward_dtp", var_6c2c150894af98a9.var_b30d6737b826b6d9 ?? 0, "attacker_is_walk", var_6c2c150894af98a9.iswalk ?? 0, "attacker_is_sprint", var_6c2c150894af98a9.issprint ?? 0, "attacker_is_non_forward_sprint", var_6c2c150894af98a9.var_50a5c93322d764b6 ?? 0, "attacker_is_slide", var_6c2c150894af98a9.isslide ?? 0, "attacker_is_non_forward_slide", var_6c2c150894af98a9.var_b470e64cd4f4930f ?? 0, "attacker_is_active_roll", var_6c2c150894af98a9.var_970e028f986ace43 ?? 0, "attacker_is_wall_run", var_6c2c150894af98a9.iswallrun ?? 0, "attacker_is_in_air", var_6c2c150894af98a9.isinair ?? 0, "attacker_is_jump", var_6c2c150894af98a9.isjump ?? 0, "attacker_is_wall_jump", var_6c2c150894af98a9.iswalljump ?? 0, "attacker_is_double_jump", var_6c2c150894af98a9.isdoublejump ?? 0, "victim_star_level", victim_star_level ?? -1, "victim_poi", victim_poi ?? #"unknown", "victim_poi_star_level", poi_star_level ?? -1 ] );
    }
    
    if ( isdefined( victim ) )
    {
        victim.pers[ "telemetry" ].life.var_b9df4af82e4b39e9 = life_index;
    }
    
    if ( var_66ca5d2c052ac026 )
    {
        logtournamentdeath( victimxuid, attackerxuid, weapon_string, means_of_death == "MOD_HEAD_SHOT" );
        
        if ( isdefined( level.matchrecording_logevent ) )
        {
            [[ level.matchrecording_logevent ]]( victimclientid, victimteam, "DEATH", victimorigin[ 0 ], victimorigin[ 1 ], time );
            
            if ( issubstr( tolower( means_of_death ), "bullet" ) && isdefined( weapon_string ) && !weapon::iskillstreakweapon( weapon_string ) )
            {
                [[ level.matchrecording_logevent ]]( attackerclientid, attackerteam, "BULLET", attacker_pos[ 0 ], attacker_pos[ 1 ], time, undefined, victimorigin[ 0 ], victimorigin[ 1 ] );
            }
        }
    }
}

// Namespace telemetry_mp
// Params 1
// Checksum 0x6a7a745d, Offset: 0xcbb2
// Size: 0x1d6
function on_player_disconnect( data )
{
    if ( data.player.hasseenendgamesplash )
    {
        telemetry_utils::function_c54601d44e7b8e8a( data.player );
    }
    
    send_player_match_end_event( data );
    var_6ab7801525ff3aca = -1;
    
    if ( telemetry_utils::function_ac165ec93ebac8d5( data ) && isdefined( data.player.pers[ "telemetry" ].life.var_b9df4af82e4b39e9 ) )
    {
        var_6ab7801525ff3aca = data.player.pers[ "telemetry" ].life.var_b9df4af82e4b39e9;
    }
    
    lifeindex = -1;
    
    if ( telemetry_utils::function_ac165ec93ebac8d5( data ) && isdefined( data.player.pers[ "telemetry" ].life.life_index ) )
    {
        lifeindex = data.player.pers[ "telemetry" ].life.life_index;
    }
    
    if ( var_6ab7801525ff3aca != lifeindex )
    {
        lifedata = spawnstruct();
        lifedata.victim = data.player;
        lifedata.attacker = undefined;
        lifedata.weaponfullstring = "none";
        lifedata.meansofdeath = "";
        
        if ( isdefined( data.disconnectreason ) )
        {
            lifedata.meansofdeath = "MOD_DISCONNECTED";
        }
        
        on_player_death( lifedata, #"on_player_disconnect" );
    }
    
    data.player function_63c6fc21f87b8553();
}

// Namespace telemetry_mp
// Params 1
// Checksum 0x139236e7, Offset: 0xcd90
// Size: 0x15b8
function function_73fbc313c1652179( data )
{
    var_5d0b26f3397efa9f = data.lifeindex ?? -1;
    timemsfrommatchstart = telemetry_utils::get_time_from_match_start( gettime() );
    classstruct = data.classstruct;
    var_a5fa738197c1be9d = classstruct.loadoutprimary;
    primaryweaponobj = classstruct.loadoutprimaryobject;
    var_19a580b93c461872 = [];
    maxprimaryattachments = weapon::getmaxprimaryattachments( classstruct.loadoutwildcard );
    loadoutprimaryattachments = classstruct.loadoutprimaryattachments;
    
    for ( attachmentindex = 0; attachmentindex < maxprimaryattachments ; attachmentindex++ )
    {
        primaryattach = loadoutprimaryattachments[ attachmentindex ];
        var_ffdab5b82356387a = isdefined( primaryattach ) ? getxhash( primaryattach ) : #"";
        var_19a580b93c461872[ attachmentindex ] = var_ffdab5b82356387a;
    }
    
    var_31540bc577c277d5 = classstruct.loadoutprimarycamo ?? #"";
    var_71304495a88c79cb = classstruct.loadoutprimaryreticle;
    var_b94211ac9e01b409 = classstruct.loadoutprimarylootitemid ?? -1;
    var_c1f6ba6dc5ef1f9f = classstruct.loadoutprimaryvariantid ?? -1;
    var_d8925ee05522ac2d = classstruct.loadoutsecondary;
    secondaryweaponobj = classstruct.loadoutsecondaryobject;
    var_665bc65c68d769a2 = [];
    maxsecondaryattachments = weapon::getmaxsecondaryattachments( classstruct.loadoutwildcard );
    loadoutsecondaryattachments = classstruct.loadoutsecondaryattachments;
    
    for ( attachmentindex = 0; attachmentindex < maxsecondaryattachments ; attachmentindex++ )
    {
        secondaryattach = loadoutsecondaryattachments[ attachmentindex ];
        var_fd487f317dce334a = isdefined( secondaryattach ) ? getxhash( secondaryattach ) : #"";
        var_665bc65c68d769a2[ attachmentindex ] = var_fd487f317dce334a;
    }
    
    var_9410a5cdeb6c96e5 = classstruct.loadoutsecondarycamo ?? #"";
    var_60d050d6ee74813b = classstruct.loadoutsecondaryreticle;
    var_401a5cb0f665d019 = classstruct.loadoutsecondarylootitemid ?? -1;
    var_d670158ed732b6af = classstruct.loadoutsecondaryvariantid ?? -1;
    primarygrenade = classstruct.loadoutequipmentprimary ?? #"undefined";
    var_ea20c7184fdcd2b8 = classstruct.loadoutEquipmentPrimaryAttachments ?? [];
    tacticalgear = classstruct.loadoutequipmentsecondary ?? #"undefined";
    var_4e7152bf0b07fa26 = classstruct.loadoutEquipmentSecondaryAttachments ?? [];
    base_perk_one = classstruct.loadoutperks[ 0 ] ?? #"specialty_null";
    base_perk_two = classstruct.loadoutperks[ 1 ] ?? #"specialty_null";
    base_perk_three = classstruct.loadoutperks[ 2 ] ?? #"specialty_null";
    base_perk_four = classstruct.loadoutperks[ 3 ] ?? #"specialty_null";
    base_perk_five = data.player.var_8ce8d93781ae0220 ?? #"specialty_null";
    extra_perk_one = classstruct.loadoutextraperks[ 0 ] ?? #"specialty_null";
    extra_perk_two = classstruct.loadoutextraperks[ 1 ] ?? #"specialty_null";
    extra_perk_three = classstruct.loadoutextraperks[ 2 ] ?? #"specialty_null";
    extra_perk_four = classstruct.loadoutextraperks[ 3 ] ?? #"specialty_null";
    extra_perk_five = classstruct.loadoutextraperks[ 4 ] ?? #"specialty_null";
    loadoutwildcard = classstruct.loadoutwildcard ?? #"wildcard_none";
    vest_perk = #"specialty_null";
    glove_perk = #"specialty_null";
    boot_perk = #"specialty_null";
    gear_perk_one = #"specialty_null";
    gear_perk_two = #"specialty_null";
    
    foreach ( perk in classstruct.loadoutstandardperks )
    {
        perkbundle = level.perkbundles[ perk ];
        
        if ( isdefined( perkbundle.var_bd1b34729a3981d5 ) == 0 )
        {
            continue;
        }
        
        switch ( perkbundle.var_bd1b34729a3981d5 )
        {
            case #"hash_8cbf71797441f513":
                vest_perk = perk;
                break;
            case #"hash_6fb5d66c124bebf7":
                glove_perk = perk;
                break;
            case #"hash_998e90e64af76252":
                boot_perk = perk;
                break;
            case #"hash_60a8910f025fc58e":
                if ( gear_perk_one == #"specialty_null" )
                {
                    gear_perk_one = perk;
                }
                else
                {
                    gear_perk_two = perk;
                }
                
                break;
        }
    }
    
    fieldupgradeone = data.player.loadoutfieldupgrade1 ?? #"none";
    var_592812d20fb33ba8 = data.player.loadoutFieldUpgrade1Attachments ?? [];
    fieldupgradetwo = data.player.loadoutfieldupgrade2 ?? #"none";
    var_cb16661cc8a61066 = data.player.loadoutFieldUpgrade2Attachments ?? [];
    primarytuning = function_fa62c051bd819627( primaryweaponobj );
    secondarytuning = function_fa62c051bd819627( secondaryweaponobj );
    
    if ( isdefined( data.primaryblueprint ) )
    {
        primary_blueprint = data.primaryblueprint.blueprintname;
        primaryblueprintname = primary_blueprint;
        primaryblueprintid = data.primaryblueprint.lootid;
        var_965e6472036ee206 = 1;
    }
    else
    {
        primary_blueprint = #"";
        primaryblueprintid = 0;
        primaryblueprintname = #"";
        var_965e6472036ee206 = 0;
    }
    
    if ( isdefined( data.secondaryblueprint ) )
    {
        secondary_blueprint = data.secondaryblueprint.blueprintname;
        secondaryblueprintname = secondary_blueprint;
        secondaryblueprintid = data.secondaryblueprint.lootid;
        var_618379aa7c8e1116 = 1;
    }
    else
    {
        secondary_blueprint = #"";
        secondaryblueprintid = 0;
        secondaryblueprintname = #"";
        var_618379aa7c8e1116 = 0;
    }
    
    isdefaultloadout = isdefined( self.loadoutclass ) && getsubstr( self.loadoutclass, 0, 7 ) == "default";
    var_4b39f3d90e9d668d = isdefined( primaryweaponobj.var_32fd4fb74b0a0502 ) && primaryweaponobj.var_32fd4fb74b0a0502.size > 0;
    var_28e13a9ff83c709d = isdefined( secondaryweaponobj.var_32fd4fb74b0a0502 ) && secondaryweaponobj.var_32fd4fb74b0a0502.size > 0;
    killstreak1 = classstruct.loadoutkillstreak1 ?? "none";
    killstreak2 = classstruct.loadoutkillstreak2 ?? "none";
    killstreak3 = classstruct.loadoutkillstreak3 ?? "none";
    shooting_mode = self.pers[ "shootingMode" ] ?? "1st";
    streaktype = self.scorestreaktype ? "Points" : "Killstreaks";
    primaryampdata = function_56db95c628b43903( primaryweaponobj );
    secondaryampdata = function_56db95c628b43903( secondaryweaponobj );
    operator_ref = data.classstruct.operator ?? %"unknown";
    operator_skin = data.classstruct.operatorskin ?? %"unknown";
    
    if ( !isdmzgamemode() )
    {
        if ( !isxhashasset( operator_ref ) && isstring( operator_ref ) )
        {
            operator_ref = getxhashasset( operator_ref );
        }
        
        if ( !isxhashasset( operator_skin ) && isstring( operator_skin ) )
        {
            operator_skin = getxhashasset( operator_skin );
        }
    }
    
    add_telemetry_data = data.player utility::callsharedfunc( #"player", #"hash_e67978577988fba" );
    
    if ( !isdefined( add_telemetry_data ) )
    {
        add_telemetry_data = [];
    }
    
    telemetry_data = [ "loadout_index", data.loadoutindex, "class_type", getxhash( data.classtype ), "mid_match_edit_count", data.var_e09c81b2bbdea49b, "first_use_life_index", var_5d0b26f3397efa9f, "time_from_match_start_ms", timemsfrommatchstart, "primary_weapon_setup_camo", getxhash( var_31540bc577c277d5 ), "primary_weapon_setup_reticle", var_71304495a88c79cb, "primary_weapon_setup_loot_item_id", var_b94211ac9e01b409, "primary_weapon_setup_variant_id", var_c1f6ba6dc5ef1f9f, "secondary_weapon_setup_camo", getxhash( var_9410a5cdeb6c96e5 ), "secondary_weapon_setup_reticle", var_60d050d6ee74813b, "secondary_weapon_setup_loot_item_id", var_401a5cb0f665d019, "secondary_weapon_setup_variant_id", var_d670158ed732b6af, "primary_grenade", getxhash( primarygrenade ), "primary_grenade_attachments", var_ea20c7184fdcd2b8, "tactical_gear", getxhash( tacticalgear ), "tactical_gear_attachments", var_4e7152bf0b07fa26, "base_perk_1", getxhash( base_perk_one ), "base_perk_2", getxhash( base_perk_two ), "base_perk_3", getxhash( base_perk_three ), "base_perk_4", getxhash( base_perk_four ), "base_perk_5", getxhash( base_perk_five ), "extra_perk_1", getxhash( extra_perk_one ), "extra_perk_2", getxhash( extra_perk_two ), "extra_perk_3", getxhash( extra_perk_three ), "extra_perk_4", getxhash( extra_perk_four ), "extra_perk_5", getxhash( extra_perk_five ), "killstreak_0", getxhash( getxhash( killstreak1 ) ), "killstreak_1", getxhash( getxhash( killstreak2 ) ), "killstreak_2", getxhash( getxhash( killstreak3 ) ), "field_upgrade_0", getxhash( fieldupgradeone ), "field_upgrade_0_attachments", var_592812d20fb33ba8, "field_upgrade_1", getxhash( fieldupgradetwo ), "field_upgrade_1_attachments", var_cb16661cc8a61066, "shooting_mode", getxhash( shooting_mode ), "primary_blueprint", getxhash( primary_blueprint ), "secondary_blueprint", getxhash( secondary_blueprint ), "primary_weapon_receiver", getxhash( primarytuning.weapon_receiver ), "primary_weapon_front_piece", getxhash( primarytuning.weapon_front_piece ), "primary_weapon_back_piece", getxhash( primarytuning.weapon_back_piece ), "primary_weapon_magazine", getxhash( primarytuning.weapon_magazine ), "primary_weapon_optic", getxhash( primarytuning.weapon_optic ), "primary_weapon_underbarrel", getxhash( primarytuning.weapon_underbarrel ), "primary_weapon_modifier", getxhash( primarytuning.weapon_modifier ), "primary_weapon_muzzle", getxhash( primarytuning.weapon_muzzle ), "primary_weapon_rear_grip", getxhash( primarytuning.weapon_rear_grip ), "primary_weapon_trigger", getxhash( primarytuning.weapon_trigger ), "primary_weapon_extra", getxhash( primarytuning.weapon_extra ), "primary_lid_receiver", primarytuning.lid_receiver, "primary_lid_front_piece", primarytuning.lid_front_piece, "primary_lid_back_piece", primarytuning.lid_back_piece, "primary_lid_magazine", primarytuning.lid_magazine, "primary_lid_optic", primarytuning.lid_optic, "primary_lid_underbarrel", primarytuning.lid_underbarrel, "primary_lid_modifier", primarytuning.lid_modifier, "primary_lid_muzzle", primarytuning.lid_muzzle, "primary_lid_rear_grip", primarytuning.lid_rear_grip, "primary_lid_trigger", primarytuning.lid_trigger, "primary_lid_extra", primarytuning.lid_extra, "primary_tv_receiver", primarytuning.tv_receiver, "primary_tv_front_piece", primarytuning.tv_front_piece, "primary_tv_back_piece", primarytuning.tv_back_piece, "primary_tv_magazine", primarytuning.tv_magazine, "primary_tv_optic", primarytuning.tv_optic, "primary_tv_underbarrel", primarytuning.tv_underbarrel, "primary_tv_modifier", primarytuning.tv_modifier, "primary_tv_muzzle", primarytuning.tv_muzzle, "primary_tv_rear_grip", primarytuning.tv_rear_grip, "primary_tv_trigger", primarytuning.tv_trigger, "primary_tv_extra", primarytuning.tv_extra, "secondary_weapon_receiver", getxhash( secondarytuning.weapon_receiver ), "secondary_weapon_front_piece", getxhash( secondarytuning.weapon_front_piece ), "secondary_weapon_back_piece", getxhash( secondarytuning.weapon_back_piece ), "secondary_weapon_magazine", getxhash( secondarytuning.weapon_magazine ), "secondary_weapon_optic", getxhash( secondarytuning.weapon_optic ), "secondary_weapon_underbarrel", getxhash( secondarytuning.weapon_underbarrel ), "secondary_weapon_modifier", getxhash( secondarytuning.weapon_modifier ), "secondary_weapon_muzzle", getxhash( secondarytuning.weapon_muzzle ), "secondary_weapon_rear_grip", getxhash( secondarytuning.weapon_rear_grip ), "secondary_weapon_trigger", getxhash( secondarytuning.weapon_trigger ), "secondary_weapon_extra", getxhash( secondarytuning.weapon_extra ), "secondary_lid_receiver", secondarytuning.lid_receiver, "secondary_lid_front_piece", secondarytuning.lid_front_piece, "secondary_lid_back_piece", secondarytuning.lid_back_piece, "secondary_lid_magazine", secondarytuning.lid_magazine, "secondary_lid_optic", secondarytuning.lid_optic, "secondary_lid_underbarrel", secondarytuning.lid_underbarrel, "secondary_lid_modifier", secondarytuning.lid_modifier, "secondary_lid_muzzle", secondarytuning.lid_muzzle, "secondary_lid_rear_grip", secondarytuning.lid_rear_grip, "secondary_lid_trigger", secondarytuning.lid_trigger, "secondary_lid_extra", secondarytuning.lid_extra, "secondary_tv_receiver", secondarytuning.tv_receiver, "secondary_tv_front_piece", secondarytuning.tv_front_piece, "secondary_tv_back_piece", secondarytuning.tv_back_piece, "secondary_tv_magazine", secondarytuning.tv_magazine, "secondary_tv_optic", secondarytuning.tv_optic, "secondary_tv_underbarrel", secondarytuning.tv_underbarrel, "secondary_tv_modifier", secondarytuning.tv_modifier, "secondary_tv_muzzle", secondarytuning.tv_muzzle, "secondary_tv_rear_grip", secondarytuning.tv_rear_grip, "secondary_tv_trigger", secondarytuning.tv_trigger, "secondary_tv_extra", secondarytuning.tv_extra, "is_default_loadout", isdefaultloadout, "primary_is_a_blueprint_weapon", var_965e6472036ee206, "primary_blueprint_name", getxhash( primaryblueprintname ), "primary_blueprint_id", primaryblueprintid, "primary_is_player_tuned", var_4b39f3d90e9d668d, "primary_weapon_setup_attachment_0", var_19a580b93c461872[ 0 ], "primary_weapon_setup_attachment_1", var_19a580b93c461872[ 1 ], "primary_weapon_setup_attachment_2", var_19a580b93c461872[ 2 ], "primary_weapon_setup_attachment_3", var_19a580b93c461872[ 3 ], "primary_weapon_setup_attachment_4", var_19a580b93c461872[ 4 ], "secondary_is_a_blueprint_weapon", var_618379aa7c8e1116, "secondary_blueprint_name", getxhash( secondaryblueprintname ), "secondary_blueprint_id", secondaryblueprintid, "secondary_is_player_tuned", var_28e13a9ff83c709d, "secondary_weapon_setup_attachment_0", var_665bc65c68d769a2[ 0 ], "secondary_weapon_setup_attachment_1", var_665bc65c68d769a2[ 1 ], "secondary_weapon_setup_attachment_2", var_665bc65c68d769a2[ 2 ], "secondary_weapon_setup_attachment_3", var_665bc65c68d769a2[ 3 ], "secondary_weapon_setup_attachment_4", var_665bc65c68d769a2[ 4 ], "streak_type", getxhash( streaktype ), "vest_perk", getxhash( vest_perk ), "glove_perk", getxhash( glove_perk ), "boot_perk", getxhash( boot_perk ), "gear_perk_1", getxhash( gear_perk_one ), "gear_perk_2", getxhash( gear_perk_two ), "primary_amp_data", primaryampdata, "secondary_amp_data", secondaryampdata, "primary_weapon_name", var_a5fa738197c1be9d, "secondary_weapon_name", var_d8925ee05522ac2d, "wildcard", getxhash( loadoutwildcard ), "operator_ref", operator_ref ?? %"unknown", "operator_skin", operator_skin ?? %"unknown" ];
    all_telemetry_data = arraycombine( telemetry_data, add_telemetry_data );
    var_da6175121f0769cb = data.player dlog_recordplayerevent( "dlog_event_mp_player_loadout", all_telemetry_data );
    
    if ( isdefined( data.player.pers[ "telemetry" ].player_loadout_count ) && var_da6175121f0769cb )
    {
        data.player.pers[ "telemetry" ].player_loadout_count++;
    }
}

// Namespace telemetry_mp
// Params 2
// Checksum 0x24f24a54, Offset: 0xe350
// Size: 0x1e4
function function_abf3fae8f87a753f( player, var_10e7927ff3023cf8 )
{
    if ( !telemetry_utils::is_valid_client( player ) )
    {
        return;
    }
    
    if ( !( getdvarint( @"hash_3f7dbd03a63a2aa", 0 ) == 1 ) && ( isbot( player ) || istestclient( player ) || isai( player ) ) )
    {
        return;
    }
    
    if ( var_10e7927ff3023cf8 == #"hash_6b7fab2a814953f3" )
    {
        self endon( #"disconnect" );
        weaponstats = arraycopy( player.pers[ "weaponStats" ] );
    }
    else
    {
        weaponstats = player.pers[ "weaponStats" ];
    }
    
    foreach ( datastruct in weaponstats )
    {
        if ( var_10e7927ff3023cf8 == #"hash_6b7fab2a814953f3" )
        {
            waitframe();
            waittillframeend();
            
            do
            {
                var_7a6bd11a32cb5f96 = 0;
                
                if ( script::function_7cae34dfec48a6d1() )
                {
                    var_881054c6b24926ed = function_8fc063681724727f();
                    
                    if ( level.var_28b0b95d6825011 == var_881054c6b24926ed || level.var_a97ce32d4d2a2f7a == var_881054c6b24926ed )
                    {
                        var_7a6bd11a32cb5f96 = 1;
                        waitframe();
                        waittillframeend();
                    }
                }
            }
            while ( var_7a6bd11a32cb5f96 );
        }
        
        if ( player )
        {
            function_5a6d4232d59c729a( player, datastruct );
            function_10d474f4cbf6b69a( player, datastruct );
            function_ef8941386866e7c8( player, datastruct );
            function_423cc735207a1993( player, datastruct );
            
            if ( isdefined( player.pers[ "telemetry" ].var_6ac2c6490dd67adc ) )
            {
                player.pers[ "telemetry" ].var_6ac2c6490dd67adc++;
            }
            
            continue;
        }
        
        assert( "<dev string:x2c7>" );
    }
}

// Namespace telemetry_mp
// Params 2
// Checksum 0xbff4976b, Offset: 0xe53c
// Size: 0x4f6
function function_ef8941386866e7c8( player, datastruct )
{
    issuper = weapon::issuperweapon( datastruct.weaponobj );
    
    if ( issuper )
    {
        return;
    }
    
    isequipment = equipment_mp::function_65ff545a795c7f55( datastruct.weaponobj );
    
    if ( isequipment == 0 )
    {
        return;
    }
    
    is_ranked = level.leagueplaymatch || level.var_309e3d9dac389de6;
    prestige_level = player player_progression_achievements::getprestige();
    var_da6175121f0769cb = player dlog_recordplayerevent( "dlog_event_mp_player_equipment_stats", [ "equipment_name", datastruct.weapon, "equipment_basename", datastruct.weaponobj.basename ?? "", "weapon_lootid", function_309bfd2186e3eab3( datastruct.weaponobj ), "variant_id", datastruct.variantid ?? 0, "current_season", getdvarint( @"current_season", -1 ), "is_ranked", is_ranked, "prestige_level", prestige_level, "total_score_earned", datastruct.stats[ "total_score_earned" ] ?? 0, "deaths", datastruct.stats[ "deaths" ] ?? 0, "most_kills_per_use", datastruct.stats[ "most_kills_per_use" ] ?? 0, "kills", datastruct.stats[ "kills" ] ?? 0, "furthest_kill", datastruct.stats[ "furthest_kill" ] ?? 0, "kill_assists", datastruct.stats[ "kill_assists" ] ?? 0, "debuff_kills", datastruct.stats[ "debuff_kills" ] ?? 0, "debuff_assists", datastruct.stats[ "debuff_assists" ] ?? 0, "buff_kills", datastruct.stats[ "buff_kills" ] ?? 0, "buff_assists", datastruct.stats[ "buff_assists" ] ?? 0, "killed_by", datastruct.stats[ "killed_by" ] ?? 0, "killed_while_debuffed_by", datastruct.stats[ "killed_while_debuffed_by" ] ?? 0, "killed_by_player_buffed_by", datastruct.stats[ "killed_by_player_buffed_by" ] ?? 0, "eliminations", datastruct.stats[ "eliminations" ] ?? 0, "kill_streak_destructions", datastruct.stats[ "kill_streak_destructions" ] ?? 0, "most_equipment_destructions_per_use", datastruct.stats[ "most_equipment_destructions_per_use" ] ?? 0, "equipment_steals", datastruct.stats[ "equipment_steals" ] ?? 0, "equipment_destructions", datastruct.stats[ "equipment_destructions" ] ?? 0, "equipment_destroyed_by", datastruct.stats[ "equipment_destroyed_by" ] ?? 0, "objective_captures", datastruct.stats[ "objective_captures" ] ?? 0, "special_hits", datastruct.stats[ "special_hits" ] ?? 0, "shots", datastruct.stats[ "shots" ] ?? 0, "damage", datastruct.stats[ "damage" ] ?? 0, "attachments", datastruct.weaponobj.attachments, "weapon_unique_session_event_id", player.pers[ "telemetry" ].var_6ac2c6490dd67adc ?? 0 ] );
    
    if ( isdefined( player.pers[ "telemetry" ].player_equipment_stats_count ) && var_da6175121f0769cb )
    {
        player.pers[ "telemetry" ].player_equipment_stats_count++;
    }
}

// Namespace telemetry_mp
// Params 2
// Checksum 0xc97409bd, Offset: 0xea3a
// Size: 0x50d
function function_423cc735207a1993( player, datastruct )
{
    if ( weapon::issuperweapon( datastruct.weaponobj ) == 0 )
    {
        return;
    }
    
    is_ranked = level.leagueplaymatch || level.var_309e3d9dac389de6;
    prestige_level = player player_progression_achievements::getprestige();
    var_da6175121f0769cb = player dlog_recordplayerevent( "dlog_event_mp_player_field_upgrade_stats", [ "field_upgrade_name", datastruct.weapon, "field_upgrade_basename", datastruct.weaponobj.basename ?? "", "weapon_lootid", function_309bfd2186e3eab3( datastruct.weaponobj ), "variant_id", datastruct.variantid ?? 0, "current_season", getdvarint( @"current_season", -1 ), "is_ranked", is_ranked, "prestige_level", prestige_level, "total_score_earned", datastruct.stats[ "total_score_earned" ] ?? 0, "deaths", datastruct.stats[ "deaths" ] ?? 0, "most_kills_per_use", datastruct.stats[ "most_kills_per_use" ] ?? 0, "kills", datastruct.stats[ "kills" ] ?? 0, "furthest_kill", datastruct.stats[ "furthest_kill" ] ?? 0, "kill_assists", datastruct.stats[ "kill_assists" ] ?? 0, "debuff_kills", datastruct.stats[ "debuff_kills" ] ?? 0, "debuff_assists", datastruct.stats[ "debuff_assists" ] ?? 0, "buff_kills", datastruct.stats[ "buff_kills" ] ?? 0, "buff_assists", datastruct.stats[ "buff_assists" ] ?? 0, "killed_by", datastruct.stats[ "killed_by" ] ?? 0, "killed_while_debuffed_by", datastruct.stats[ "killed_while_debuffed_by" ] ?? 0, "killed_by_player_buffed_by", datastruct.stats[ "killed_by_player_buffed_by" ] ?? 0, "eliminations", datastruct.stats[ "eliminations" ] ?? 0, "kill_streak_destructions", datastruct.stats[ "kill_streak_destructions" ] ?? 0, "most_equipment_destructions_per_use", datastruct.stats[ "most_equipment_destructions_per_use" ] ?? 0, "equipment_steals", datastruct.stats[ "equipment_steals" ] ?? 0, "equipment_destructions", datastruct.stats[ "equipment_destructions" ] ?? 0, "equipment_destroyed_by", datastruct.stats[ "equipment_destroyed_by" ] ?? 0, "special_hits", datastruct.stats[ "special_hits" ] ?? 0, "shots", datastruct.stats[ "shots" ] ?? 0, "most_restocks_per_use", datastruct.stats[ "most_restocks_per_use" ] ?? 0, "restocks", datastruct.stats[ "restocks" ] ?? 0, "objective_captures", datastruct.stats[ "objective_captures" ] ?? 0, "damage", datastruct.stats[ "damage" ] ?? 0, "attachments", datastruct.weaponobj.attachments, "weapon_unique_session_event_id", player.pers[ "telemetry" ].var_6ac2c6490dd67adc ?? 0 ] );
    
    if ( isdefined( player.pers[ "telemetry" ].player_field_upgrade_stats_count ) && var_da6175121f0769cb )
    {
        player.pers[ "telemetry" ].player_field_upgrade_stats_count++;
    }
}

// Namespace telemetry_mp
// Params 2
// Checksum 0xd3bc2d2, Offset: 0xef4f
// Size: 0x135e
function function_5a6d4232d59c729a( player, datastruct )
{
    issuper = weapon::issuperweapon( datastruct.weaponobj );
    isequipment = equipment_mp::function_65ff545a795c7f55( datastruct.weaponobj );
    var_aff0b87889329d98 = !( issuper || isequipment );
    
    if ( getdvarint( @"hash_3f7dbd03a63a2aa", 0 ) == 1 && weapon::function_707f7162a89aa0e0( datastruct.weapon ) || game_utility::getgametype() == "dmz" )
    {
        return;
    }
    
    if ( isenumvaluevalid( "common", "LoadoutWeapon", datastruct.weapon ) )
    {
        startingweaponxp = player getplayerdata( level.loadoutsgroup, "squadMembers", "weapon_xp", datastruct.weapon ) ?? 0;
        startweaponrank = weaponrank::getweaponrankforxp( datastruct.weapon, startingweaponxp ) ?? 0;
    }
    else
    {
        startingweaponxp = 0;
        startweaponrank = 0;
    }
    
    isablueprint = 0;
    blueprintid = 0;
    blueprintname = "";
    isplayertuned = 0;
    camoidequipped = "none";
    weaponroot = weapon::function_170e300815e9c1a2( datastruct.weaponobj );
    
    if ( isdefined( datastruct.weaponobj ) )
    {
        if ( isdefined( datastruct.weaponobj.camo ) )
        {
            camoidequipped = datastruct.weaponobj.camo;
        }
        
        if ( isdefined( datastruct.weaponobj.var_32fd4fb74b0a0502 ) )
        {
            if ( datastruct.weaponobj.var_32fd4fb74b0a0502.size > 0 )
            {
                isplayertuned = 1;
            }
        }
        
        if ( isdefined( datastruct.weaponobj.weaponblueprint ) )
        {
            isablueprint = 1;
            blueprintid = datastruct.weaponobj.weaponblueprint.lootid;
            blueprintname = weaponroot + "|" + datastruct.weaponobj.variantid;
        }
    }
    
    weaponattachmentsetup = [];
    maxprimaryattachments = weapon::getmaxprimaryattachments( player class::function_facf39de1a82731a() );
    
    for ( attachmentindex = 0; attachmentindex < maxprimaryattachments ; attachmentindex++ )
    {
        weaponattachmentsetup[ attachmentindex ] = "";
        
        if ( isdefined( datastruct.weaponobj ) )
        {
            if ( isdefined( datastruct.weaponobj.attachments[ attachmentindex ] ) )
            {
                weaponattachmentsetup[ attachmentindex ] = datastruct.weaponobj.attachments[ attachmentindex ];
            }
        }
    }
    
    endweaponrank = 0;
    
    if ( isdefined( datastruct.stats[ "xp_earned" ] ) )
    {
        if ( isenumvaluevalid( "common", "LoadoutWeapon", datastruct.weapon ) )
        {
            startingweaponxp = player getplayerdata( level.loadoutsgroup, "squadMembers", "weapon_xp", datastruct.weapon );
            weaponearnedxp = datastruct.stats[ "xp_earned" ];
            var_8150cdce13ac31b = startingweaponxp + weaponearnedxp;
            endweaponrank = weaponrank::getweaponrankforxp( datastruct.weapon, var_8150cdce13ac31b );
        }
        
        if ( !isdefined( endweaponrank ) )
        {
            endweaponrank = 0;
        }
    }
    
    primaryampdata = [];
    secondaryampdata = [];
    
    if ( isdefined( self.primaryweapons ) )
    {
        if ( isdefined( self.primaryweapons[ 0 ] ) )
        {
            primaryampdata = function_56db95c628b43903( self.primaryweapons[ 0 ] );
        }
        
        if ( isdefined( self.primaryweapons[ 1 ] ) )
        {
            secondaryampdata = function_56db95c628b43903( self.primaryweapons[ 1 ] );
        }
    }
    
    weaponclass = getscriptbundlefieldvalue( hashcat( %"weapondata:", weaponroot ), #"classdata" ) ?? datastruct.weaponobj.classname ?? "";
    tuningdata = function_fa62c051bd819627( datastruct.weaponobj );
    is_ranked = level.leagueplaymatch || level.var_309e3d9dac389de6;
    prestige_level = player player_progression_achievements::getprestige();
    var_da6175121f0769cb = 0;
    
    if ( function_97de808fe549b3b7() )
    {
        var_da6175121f0769cb = player function_ad05aed95a44741e( 7944230297536451712, [ 88:player.pers[ "wallbangs" ], 87:secondaryampdata, 86:primaryampdata, 85:player.pers[ "telemetry" ].var_6ac2c6490dd67adc ?? 0, 84:endweaponrank, 83:startweaponrank, 82:datastruct.isdualwielding, 81:weaponattachmentsetup[ 4 ], 80:weaponattachmentsetup[ 3 ], 79:weaponattachmentsetup[ 2 ], 78:weaponattachmentsetup[ 1 ], 77:weaponattachmentsetup[ 0 ], 76:camoidequipped, 75:isplayertuned, 74:blueprintname, 73:blueprintid, 72:isablueprint, 71:function_309bfd2186e3eab3( datastruct.weaponobj ), 70:tuningdata.tv_extra, 69:tuningdata.tv_trigger, 68:tuningdata.tv_rear_grip, 67:tuningdata.tv_muzzle, 66:tuningdata.tv_modifier, 65:tuningdata.tv_underbarrel, 64:tuningdata.tv_optic, 63:tuningdata.tv_magazine, 62:tuningdata.tv_back_piece, 61:tuningdata.tv_front_piece, 60:tuningdata.tv_receiver, 59:tuningdata.lid_extra, 58:tuningdata.lid_trigger, 57:tuningdata.lid_rear_grip, 56:tuningdata.lid_muzzle, 55:tuningdata.lid_modifier, 54:tuningdata.lid_underbarrel, 53:tuningdata.lid_optic, 52:tuningdata.lid_magazine, 51:tuningdata.lid_back_piece, 50:tuningdata.lid_front_piece, 49:tuningdata.lid_receiver, 48:tuningdata.weapon_extra, 47:tuningdata.weapon_trigger, 46:tuningdata.weapon_rear_grip, 45:tuningdata.weapon_muzzle, tuningdata.weapon_modifier, 43:tuningdata.weapon_underbarrel, 42:tuningdata.weapon_optic, 41:tuningdata.weapon_magazine, 40:tuningdata.weapon_back_piece, 39:tuningdata.weapon_front_piece, 38:tuningdata.weapon_receiver, 37:datastruct.stats[ "player_damage" ] ?? 0, 36:datastruct.stats[ "ai_damage" ] ?? 0, 35:datastruct.stats[ "damage" ] ?? 0, 34:float( datastruct.stats[ "timeUsed" ] ?? 0 ) / 1000, 33:datastruct.stats[ "shots" ] ?? 0, 32:datastruct.stats[ "player_ads_kills" ] ?? 0, 31:datastruct.stats[ "ai_ads_kills" ] ?? 0, 30:datastruct.stats[ "ads_kills" ] ?? 0, 29:datastruct.stats[ "ai_agent_kills" ] ?? 0, 92:datastruct.stats[ "equipment_destructions" ] ?? 0, 28:datastruct.stats[ "kill_streak_destructions" ] ?? 0, 27:datastruct.stats[ "eliminations" ] ?? 0, 26:datastruct.stats[ "killed_by" ] ?? 0, 25:datastruct.stats[ "furthest_kill" ] ?? 0, 24:datastruct.stats[ "kills" ] ?? 0, 23:datastruct.stats[ "special_hits" ] ?? 0, 22:datastruct.stats[ "player_hits" ] ?? 0, 21:datastruct.stats[ "ai_hits" ] ?? 0, 20:datastruct.stats[ "hits" ] ?? 0, 19:datastruct.stats[ "player_headshots" ] ?? 0, 18:datastruct.stats[ "ai_headshots" ] ?? 0, 17:datastruct.stats[ "headshots" ] ?? 0, 16:datastruct.stats[ "player_deaths" ] ?? 0, 15:datastruct.stats[ "ai_deaths" ] ?? 0, 14:datastruct.stats[ "deaths" ] ?? 0, 13:datastruct.stats[ "xp_earned" ] ?? 0, 91:prestige_level, 89:is_ranked, 90:getdvarint( @"current_season", -1 ), 12:startingweaponxp, 11:datastruct.ispickedup, 10:datastruct.loadoutindex, 9:datastruct.weaponattachments, 8:datastruct.variantid, 7:var_aff0b87889329d98, 6:weaponclass, 5:datastruct.weaponobj.basename ?? "", 4:datastruct.weapon ] );
    }
    else
    {
        var_da6175121f0769cb = player dlog_recordplayerevent( "dlog_event_mp_player_weapon_stats", [ "weapon", datastruct.weapon, "weapon_basename", datastruct.weaponobj.basename ?? "", "weapon_class", weaponclass, "is_weapon_only", var_aff0b87889329d98, "variant_id", datastruct.variantid, "attachments", datastruct.weaponattachments, "loadout_index", datastruct.loadoutindex, "is_picked_up", datastruct.ispickedup, "starting_weapon_xp", startingweaponxp, "current_season", getdvarint( @"current_season", -1 ), "is_ranked", is_ranked, "prestige_level", prestige_level, "xp_earned", datastruct.stats[ "xp_earned" ] ?? 0, "deaths", datastruct.stats[ "deaths" ] ?? 0, "ai_deaths", datastruct.stats[ "ai_deaths" ] ?? 0, "player_deaths", datastruct.stats[ "player_deaths" ] ?? 0, "headshots", datastruct.stats[ "headshots" ] ?? 0, "ai_headshots", datastruct.stats[ "ai_headshots" ] ?? 0, "player_headshots", datastruct.stats[ "player_headshots" ] ?? 0, "hits", datastruct.stats[ "hits" ] ?? 0, "ai_hits", datastruct.stats[ "ai_hits" ] ?? 0, "player_hits", datastruct.stats[ "player_hits" ] ?? 0, "special_hits", datastruct.stats[ "special_hits" ] ?? 0, "kills", datastruct.stats[ "kills" ] ?? 0, "furthest_kill", datastruct.stats[ "furthest_kill" ] ?? 0, "killed_by", datastruct.stats[ "killed_by" ] ?? 0, "eliminations", datastruct.stats[ "eliminations" ] ?? 0, "kill_streak_destructions", datastruct.stats[ "kill_streak_destructions" ] ?? 0, "equipment_destructions", datastruct.stats[ "equipment_destructions" ] ?? 0, "ai_agent_kills", datastruct.stats[ "ai_agent_kills" ] ?? 0, "ads_kills", datastruct.stats[ "ads_kills" ] ?? 0, "ai_ads_kills", datastruct.stats[ "ai_ads_kills" ] ?? 0, "player_ads_kills", datastruct.stats[ "player_ads_kills" ] ?? 0, "shots", datastruct.stats[ "shots" ] ?? 0, "time_used_s", float( datastruct.stats[ "timeUsed" ] ?? 0 ) / 1000, "damage", datastruct.stats[ "damage" ] ?? 0, "ai_damage", datastruct.stats[ "ai_damage" ] ?? 0, "player_damage", datastruct.stats[ "player_damage" ] ?? 0, "weapon_receiver", tuningdata.weapon_receiver, "weapon_front_piece", tuningdata.weapon_front_piece, "weapon_back_piece", tuningdata.weapon_back_piece, "weapon_magazine", tuningdata.weapon_magazine, "weapon_optic", tuningdata.weapon_optic, "weapon_underbarrel", tuningdata.weapon_underbarrel, "weapon_modifier", tuningdata.weapon_modifier, "weapon_muzzle", tuningdata.weapon_muzzle, "weapon_rear_grip", tuningdata.weapon_rear_grip, "weapon_trigger", tuningdata.weapon_trigger, "weapon_extra", tuningdata.weapon_extra, "lid_receiver", tuningdata.lid_receiver, "lid_front_piece", tuningdata.lid_front_piece, "lid_back_piece", tuningdata.lid_back_piece, "lid_magazine", tuningdata.lid_magazine, "lid_optic", tuningdata.lid_optic, "lid_underbarrel", tuningdata.lid_underbarrel, "lid_modifier", tuningdata.lid_modifier, "lid_muzzle", tuningdata.lid_muzzle, "lid_rear_grip", tuningdata.lid_rear_grip, "lid_trigger", tuningdata.lid_trigger, "lid_extra", tuningdata.lid_extra, "tv_receiver", tuningdata.tv_receiver, "tv_front_piece", tuningdata.tv_front_piece, "tv_back_piece", tuningdata.tv_back_piece, "tv_magazine", tuningdata.tv_magazine, "tv_optic", tuningdata.tv_optic, "tv_underbarrel", tuningdata.tv_underbarrel, "tv_modifier", tuningdata.tv_modifier, "tv_muzzle", tuningdata.tv_muzzle, "tv_rear_grip", tuningdata.tv_rear_grip, "tv_trigger", tuningdata.tv_trigger, "tv_extra", tuningdata.tv_extra, "weapon_lootid", function_309bfd2186e3eab3( datastruct.weaponobj ), "is_a_blueprint_weapon", isablueprint, "blueprint_id", blueprintid, "blueprint_name", blueprintname, "is_player_tuned", isplayertuned, "camo_equipped_id", camoidequipped, "weapon_setup_attachment_0", weaponattachmentsetup[ 0 ], "weapon_setup_attachment_1", weaponattachmentsetup[ 1 ], "weapon_setup_attachment_2", weaponattachmentsetup[ 2 ], "weapon_setup_attachment_3", weaponattachmentsetup[ 3 ], "weapon_setup_attachment_4", weaponattachmentsetup[ 4 ], "is_dual_wielding", datastruct.isdualwielding, "weapon_rank_start", startweaponrank, "weapon_rank_end", endweaponrank, "weapon_unique_session_event_id", player.pers[ "telemetry" ].var_6ac2c6490dd67adc ?? 0, "primary_amp_data", primaryampdata, "secondary_amp_data", secondaryampdata, "wall_bangs", player.pers[ "wallbangs" ] ] );
    }
    
    if ( isdefined( player.pers[ "telemetry" ].player_weapon_stats_count ) && var_da6175121f0769cb )
    {
        player.pers[ "telemetry" ].player_weapon_stats_count++;
    }
}

// Namespace telemetry_mp
// Params 2
// Checksum 0xa6108cdd, Offset: 0x102b5
// Size: 0x21e
function function_10d474f4cbf6b69a( player, datastruct )
{
    if ( game_utility::getgametype() != "ob" && game_utility::getgametype() != "ob_rift_run" )
    {
        return;
    }
    
    player dlog_recordplayerevent( "dlog_event_ob_player_weapon_stats", [ "weapon", datastruct.weapon, "weapon_normal_zombie_kills", datastruct.stats[ "weapon_normal_zombie_kills" ] ?? 0, "weapon_special_zombie_kills", datastruct.stats[ "weapon_special_zombie_kills" ] ?? 0, "weapon_elite_zombie_kills", datastruct.stats[ "weapon_elite_zombie_kills" ] ?? 0, "weapon_boss_zombie_kills", datastruct.stats[ "weapon_boss_zombie_kills" ] ?? 0, "weapon_pack_a_punch_kills", datastruct.stats[ "weapon_pack_a_punch_kills" ] ?? 0, "weapon_critical_kills", datastruct.stats[ "weapon_critical_kills" ] ?? 0, "weapon_soldier_kills", datastruct.stats[ "weapon_soldier_kills" ] ?? 0, "weapon_white_rarity_kills", datastruct.stats[ "weapon_white_rarity_kills" ] ?? 0, "weapon_green_rarity_kills", datastruct.stats[ "weapon_green_rarity_kills" ] ?? 0, "weapon_blue_rarity_kills", datastruct.stats[ "weapon_blue_rarity_kills" ] ?? 0, "weapon_orange_rarity_kills", datastruct.stats[ "weapon_orange_rarity_kills" ] ?? 0, "weapon_purple_rarity_kills", datastruct.stats[ "weapon_purple_rarity_kills" ] ?? 0, "weapon_unique_session_event_id", player.pers[ "telemetry" ].var_6ac2c6490dd67adc ?? 0 ] );
}

// Namespace telemetry_mp
// Params 1
// Checksum 0x7b3d2029, Offset: 0x104db
// Size: 0xca8
function function_fa62c051bd819627( weapon )
{
    data = spawnstruct();
    data.weapon_receiver = "";
    data.lid_receiver = 0;
    data.tv_receiver = [ 0, 0 ];
    data.weapon_front_piece = "";
    data.lid_front_piece = 0;
    data.tv_front_piece = [ 0, 0 ];
    data.weapon_back_piece = "";
    data.lid_back_piece = 0;
    data.tv_back_piece = [ 0, 0 ];
    data.weapon_magazine = "";
    data.lid_magazine = 0;
    data.tv_magazine = [ 0, 0 ];
    data.weapon_optic = "";
    data.lid_optic = 0;
    data.tv_optic = [ 0, 0 ];
    data.weapon_underbarrel = "";
    data.lid_underbarrel = 0;
    data.tv_underbarrel = [ 0, 0 ];
    data.weapon_modifier = "";
    data.lid_modifier = 0;
    data.tv_modifier = [ 0, 0 ];
    data.weapon_muzzle = "";
    data.lid_muzzle = 0;
    data.tv_muzzle = [ 0, 0 ];
    data.weapon_rear_grip = "";
    data.lid_rear_grip = 0;
    data.tv_rear_grip = [ 0, 0 ];
    data.weapon_trigger = "";
    data.lid_trigger = 0;
    data.tv_trigger = [ 0, 0 ];
    data.weapon_extra = "";
    data.lid_extra = 0;
    data.tv_extra = [ 0, 0 ];
    
    if ( !isdefined( weapon ) )
    {
        return data;
    }
    
    basename = weapon.basename;
    var_32fd4fb74b0a0502 = weapon.var_32fd4fb74b0a0502;
    receiver = weapon.receiver;
    
    if ( isdefined( receiver ) )
    {
        data.weapon_receiver = receiver;
        data.lid_receiver = weapon::getattachmentlootid( basename, receiver );
        attachtune = var_32fd4fb74b0a0502[ receiver ];
        
        if ( isdefined( attachtune ) )
        {
            var_3ae47920d5874622 = attachtune[ 0 ];
            
            if ( !isdefined( var_3ae47920d5874622 ) || !isfloat( var_3ae47920d5874622 ) )
            {
                assert( "<dev string:x2ee>" );
                data.tv_receiver[ 0 ] = -1e+06;
            }
            else
            {
                data.tv_receiver[ 0 ] = var_3ae47920d5874622;
            }
            
            var_3ae47920d5874622 = attachtune[ 1 ];
            
            if ( !isdefined( var_3ae47920d5874622 ) || !isfloat( var_3ae47920d5874622 ) )
            {
                assert( "<dev string:x2ee>" );
                data.tv_receiver[ 1 ] = -1e+06;
            }
            else
            {
                data.tv_receiver[ 1 ] = var_3ae47920d5874622;
            }
        }
    }
    
    frontpiece = weapon.frontpiece;
    
    if ( isdefined( frontpiece ) )
    {
        data.weapon_front_piece = frontpiece;
        data.lid_front_piece = weapon::getattachmentlootid( basename, frontpiece );
        attachtune = var_32fd4fb74b0a0502[ frontpiece ];
        
        if ( isdefined( attachtune ) )
        {
            var_3ae47920d5874622 = attachtune[ 0 ];
            
            if ( !isdefined( var_3ae47920d5874622 ) || !isfloat( var_3ae47920d5874622 ) )
            {
                assert( "<dev string:x2ee>" );
                data.tv_front_piece[ 0 ] = -1e+06;
            }
            else
            {
                data.tv_front_piece[ 0 ] = var_3ae47920d5874622;
            }
            
            var_3ae47920d5874622 = attachtune[ 1 ];
            
            if ( !isdefined( var_3ae47920d5874622 ) || !isfloat( var_3ae47920d5874622 ) )
            {
                assert( "<dev string:x2ee>" );
                data.tv_front_piece[ 1 ] = -1e+06;
            }
            else
            {
                data.tv_front_piece[ 1 ] = var_3ae47920d5874622;
            }
        }
    }
    
    backpiece = weapon.backpiece;
    
    if ( isdefined( backpiece ) )
    {
        data.weapon_back_piece = backpiece;
        data.lid_back_piece = weapon::getattachmentlootid( basename, backpiece );
        attachtune = var_32fd4fb74b0a0502[ backpiece ];
        
        if ( isdefined( attachtune ) )
        {
            var_3ae47920d5874622 = attachtune[ 0 ];
            
            if ( !isdefined( var_3ae47920d5874622 ) || !isfloat( var_3ae47920d5874622 ) )
            {
                assert( "<dev string:x2ee>" );
                data.tv_back_piece[ 0 ] = -1e+06;
            }
            else
            {
                data.tv_back_piece[ 0 ] = var_3ae47920d5874622;
            }
            
            var_3ae47920d5874622 = attachtune[ 1 ];
            
            if ( !isdefined( var_3ae47920d5874622 ) || !isfloat( var_3ae47920d5874622 ) )
            {
                assert( "<dev string:x2ee>" );
                data.tv_back_piece[ 1 ] = -1e+06;
            }
            else
            {
                data.tv_back_piece[ 1 ] = var_3ae47920d5874622;
            }
        }
    }
    
    magazine = weapon.magazine;
    
    if ( isdefined( magazine ) )
    {
        data.weapon_magazine = magazine;
        data.lid_magazine = weapon::getattachmentlootid( basename, magazine );
        attachtune = var_32fd4fb74b0a0502[ magazine ];
        
        if ( isdefined( attachtune ) )
        {
            var_3ae47920d5874622 = attachtune[ 0 ];
            
            if ( !isdefined( var_3ae47920d5874622 ) || !isfloat( var_3ae47920d5874622 ) )
            {
                assert( "<dev string:x2ee>" );
                data.tv_magazine[ 0 ] = -1e+06;
            }
            else
            {
                data.tv_magazine[ 0 ] = var_3ae47920d5874622;
            }
            
            var_3ae47920d5874622 = attachtune[ 1 ];
            
            if ( !isdefined( var_3ae47920d5874622 ) || !isfloat( var_3ae47920d5874622 ) )
            {
                assert( "<dev string:x2ee>" );
                data.tv_magazine[ 1 ] = -1e+06;
            }
            else
            {
                data.tv_magazine[ 1 ] = var_3ae47920d5874622;
            }
        }
    }
    
    scope = weapon.scope;
    
    if ( isdefined( scope ) )
    {
        data.weapon_optic = scope;
        data.lid_optic = weapon::getattachmentlootid( basename, scope );
        attachtune = var_32fd4fb74b0a0502[ scope ];
        
        if ( isdefined( attachtune ) )
        {
            var_3ae47920d5874622 = attachtune[ 0 ];
            
            if ( !isdefined( var_3ae47920d5874622 ) || !isfloat( var_3ae47920d5874622 ) )
            {
                assert( "<dev string:x2ee>" );
                data.tv_optic[ 0 ] = -1e+06;
            }
            else
            {
                data.tv_optic[ 0 ] = var_3ae47920d5874622;
            }
            
            var_3ae47920d5874622 = attachtune[ 1 ];
            
            if ( !isdefined( var_3ae47920d5874622 ) || !isfloat( var_3ae47920d5874622 ) )
            {
                assert( "<dev string:x2ee>" );
                data.tv_optic[ 1 ] = -1e+06;
            }
            else
            {
                data.tv_optic[ 1 ] = var_3ae47920d5874622;
            }
        }
    }
    
    underbarrel = weapon.underbarrel;
    
    if ( isdefined( underbarrel ) )
    {
        data.weapon_underbarrel = underbarrel;
        data.lid_underbarrel = weapon::getattachmentlootid( basename, underbarrel );
        attachtune = var_32fd4fb74b0a0502[ underbarrel ];
        
        if ( isdefined( attachtune ) )
        {
            var_3ae47920d5874622 = attachtune[ 0 ];
            
            if ( !isdefined( var_3ae47920d5874622 ) || !isfloat( var_3ae47920d5874622 ) )
            {
                assert( "<dev string:x2ee>" );
                data.tv_underbarrel[ 0 ] = -1e+06;
            }
            else
            {
                data.tv_underbarrel[ 0 ] = var_3ae47920d5874622;
            }
            
            var_3ae47920d5874622 = attachtune[ 1 ];
            
            if ( !isdefined( var_3ae47920d5874622 ) || !isfloat( var_3ae47920d5874622 ) )
            {
                assert( "<dev string:x2ee>" );
                data.tv_underbarrel[ 1 ] = -1e+06;
            }
            else
            {
                data.tv_underbarrel[ 1 ] = var_3ae47920d5874622;
            }
        }
    }
    
    modifier = weapon.modifier;
    
    if ( isdefined( modifier ) )
    {
        data.weapon_modifier = modifier;
        data.lid_modifier = weapon::getattachmentlootid( basename, modifier );
        attachtune = var_32fd4fb74b0a0502[ modifier ];
        
        if ( isdefined( attachtune ) )
        {
            var_3ae47920d5874622 = attachtune[ 0 ];
            
            if ( !isdefined( var_3ae47920d5874622 ) || !isfloat( var_3ae47920d5874622 ) )
            {
                assert( "<dev string:x2ee>" );
                data.tv_modifier[ 0 ] = -1e+06;
            }
            else
            {
                data.tv_modifier[ 0 ] = var_3ae47920d5874622;
            }
            
            var_3ae47920d5874622 = attachtune[ 1 ];
            
            if ( !isdefined( var_3ae47920d5874622 ) || !isfloat( var_3ae47920d5874622 ) )
            {
                assert( "<dev string:x2ee>" );
                data.tv_modifier[ 1 ] = -1e+06;
            }
            else
            {
                data.tv_modifier[ 1 ] = var_3ae47920d5874622;
            }
        }
    }
    
    muzzle = weapon.muzzle;
    
    if ( isdefined( muzzle ) )
    {
        data.weapon_muzzle = muzzle;
        data.lid_muzzle = weapon::getattachmentlootid( basename, muzzle );
        attachtune = var_32fd4fb74b0a0502[ muzzle ];
        
        if ( isdefined( attachtune ) )
        {
            var_3ae47920d5874622 = attachtune[ 0 ];
            
            if ( !isdefined( var_3ae47920d5874622 ) || !isfloat( var_3ae47920d5874622 ) )
            {
                assert( "<dev string:x2ee>" );
                data.tv_muzzle[ 0 ] = -1e+06;
            }
            else
            {
                data.tv_muzzle[ 0 ] = var_3ae47920d5874622;
            }
            
            var_3ae47920d5874622 = attachtune[ 1 ];
            
            if ( !isdefined( var_3ae47920d5874622 ) || !isfloat( var_3ae47920d5874622 ) )
            {
                assert( "<dev string:x2ee>" );
                data.tv_muzzle[ 1 ] = -1e+06;
            }
            else
            {
                data.tv_muzzle[ 1 ] = var_3ae47920d5874622;
            }
        }
    }
    
    reargrip = weapon.reargrip;
    
    if ( isdefined( reargrip ) )
    {
        data.weapon_rear_grip = reargrip;
        data.lid_rear_grip = weapon::getattachmentlootid( basename, reargrip );
        attachtune = var_32fd4fb74b0a0502[ reargrip ];
        
        if ( isdefined( attachtune ) )
        {
            var_3ae47920d5874622 = attachtune[ 0 ];
            
            if ( !isdefined( var_3ae47920d5874622 ) || !isfloat( var_3ae47920d5874622 ) )
            {
                assert( "<dev string:x2ee>" );
                data.tv_reargrip[ 0 ] = -1e+06;
            }
            else
            {
                data.tv_reargrip[ 0 ] = var_3ae47920d5874622;
            }
            
            var_3ae47920d5874622 = attachtune[ 1 ];
            
            if ( !isdefined( var_3ae47920d5874622 ) || !isfloat( var_3ae47920d5874622 ) )
            {
                assert( "<dev string:x2ee>" );
                data.tv_reargrip[ 1 ] = -1e+06;
            }
            else
            {
                data.tv_reargrip[ 1 ] = var_3ae47920d5874622;
            }
        }
    }
    
    trigger = weapon.trigger;
    
    if ( isdefined( trigger ) )
    {
        data.weapon_trigger = trigger;
        data.lid_trigger = weapon::getattachmentlootid( basename, trigger );
        
        if ( isdefined( var_32fd4fb74b0a0502[ trigger ] ) )
        {
            var_3ae47920d5874622 = attachtune[ 0 ];
            
            if ( !isdefined( var_3ae47920d5874622 ) || !isfloat( var_3ae47920d5874622 ) )
            {
                assert( "<dev string:x2ee>" );
                data.tv_trigger[ 0 ] = -1e+06;
            }
            else
            {
                data.tv_trigger[ 0 ] = var_3ae47920d5874622;
            }
            
            var_3ae47920d5874622 = attachtune[ 1 ];
            
            if ( !isdefined( var_3ae47920d5874622 ) || !isfloat( var_3ae47920d5874622 ) )
            {
                assert( "<dev string:x2ee>" );
                data.tv_trigger[ 1 ] = -1e+06;
            }
            else
            {
                data.tv_trigger[ 1 ] = var_3ae47920d5874622;
            }
        }
    }
    
    extra = weapon.extra;
    
    if ( isdefined( extra ) )
    {
        data.weapon_extra = extra;
        data.lid_extra = weapon::getattachmentlootid( basename, extra );
        attachtune = var_32fd4fb74b0a0502[ extra ];
        
        if ( isdefined( attachtune ) )
        {
            var_3ae47920d5874622 = attachtune[ 0 ];
            
            if ( !isdefined( var_3ae47920d5874622 ) || !isfloat( var_3ae47920d5874622 ) )
            {
                assert( "<dev string:x2ee>" );
                data.tv_extra[ 0 ] = -1e+06;
            }
            else
            {
                data.tv_extra[ 0 ] = var_3ae47920d5874622;
            }
            
            var_3ae47920d5874622 = attachtune[ 1 ];
            
            if ( !isdefined( var_3ae47920d5874622 ) || !isfloat( var_3ae47920d5874622 ) )
            {
                assert( "<dev string:x2ee>" );
                data.tv_extra[ 1 ] = -1e+06;
            }
            else
            {
                data.tv_extra[ 1 ] = var_3ae47920d5874622;
            }
        }
    }
    
    return data;
}

// Namespace telemetry_mp
// Params 1, eflags: 0x4
// Checksum 0x792acdaf, Offset: 0x1118c
// Size: 0x454
function private update_weapon_stats( data )
{
    if ( isdefined( data.incvalue ) )
    {
        assertmsg( "<dev string:x35a>" );
        telemetry::function_6367d060fde50007( data, data.statname, data.incvalue );
    }
    
    currenttime = telemetry_utils::get_time_from_match_start( data.stattime ?? gettime() );
    
    if ( isnullweapon( data.weaponobj ) )
    {
        assertmsg( "<dev string:x3b5>" );
        return;
    }
    
    if ( currenttime <= 0 && ( !isdefined( self.loadoutindex ) || self.loadoutindex == -1 ) )
    {
        return;
    }
    
    weaponstats = self.pers[ "weaponStats" ];
    
    if ( !isdefined( weaponstats ) )
    {
        return;
    }
    
    weaponbasename = data.weaponobj.basename;
    
    if ( weapon::iskillstreakweaponname( weaponbasename ) || vehicle::isvehicleweaponname( weaponbasename ) || weapon::isfistsonly( data.weaponobj ) )
    {
        return;
    }
    
    var_a836626b3eb16832 = data.fullweaponname;
    
    if ( !isdefined( weaponstats[ var_a836626b3eb16832 ] ) )
    {
        var_e6f236e7660502a6 = getdvarint( @"hash_817f686503ccdecf", 15 );
        
        if ( weaponstats.size >= var_e6f236e7660502a6 )
        {
            thread function_abf3fae8f87a753f( self, level.gametypebundle.var_10e7927ff3023cf8 );
            self.pers[ "weaponStats" ] = [];
        }
        
        var_9499c7cbd4b3f5d1 = self isdualwielding() == 1;
        
        if ( isdefined( self ) && isdefined( data ) )
        {
            if ( isdefined( data.weaponobj ) )
            {
                var_9499c7cbd4b3f5d1 = self function_1ea59633649ae3dd( data.weaponobj );
            }
            else if ( isdefined( data.fullweaponname ) )
            {
                var_9499c7cbd4b3f5d1 = self function_1ea59633649ae3dd( data.fullweaponname );
            }
        }
        
        var_298ce6d21dbc7049 = telemetry_utils::is_valid_client( self ) ? weapon::ispickedupweapon( data.weaponobj ) : 0;
        newweaponattachments = data.fullweaponname == "agent_mp" ? [] : weapon::attachmentsfilterforstats( getweaponattachments( data.fullweaponname ), data.fullweaponname );
        newloadoutindex = isdefined( self.loadoutindex ) && !var_298ce6d21dbc7049 ? self.loadoutindex : -1;
        self.pers[ "weaponStats" ][ var_a836626b3eb16832 ] = { #isdualwielding:var_9499c7cbd4b3f5d1, #variantid:data.variantid ?? -1, #weaponobj:data.weaponobj, #ispickedup:var_298ce6d21dbc7049, #loadoutindex:newloadoutindex, #weaponattachments:newweaponattachments, #weapon:data.weaponname, #stats:[] };
    }
    
    weaponstatscontainer = self.pers[ "weaponStats" ][ var_a836626b3eb16832 ];
    telemetry::function_25f6c2a46443f597( data, weaponstatscontainer );
    
    foreach ( statupdate in data.statupdates )
    {
        switch ( statupdate.name )
        {
            case #"hash_1f658b3efcf092d2":
                self.pers[ "telemetry" ].shots = self.pers[ "telemetry" ].shots + statupdate.value;
                break;
            case #"hash_7b99e54a94aa5fb":
                self.pers[ "telemetry" ].hits = self.pers[ "telemetry" ].hits + statupdate.value;
                break;
        }
    }
}

// Namespace telemetry_mp
// Params 1
// Checksum 0x20d314b9, Offset: 0x115e8
// Size: 0x165
function on_player_score_event( data )
{
    eventtime = gettime();
    function_ea796f5a715af435();
    player = data.player;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( game_utility_common::isgameparticipant( player ) == 0 )
    {
        assertmsg( "<dev string:x427>" + data.player.code_classname );
        return;
    }
    
    if ( !telemetry_utils::is_valid_client( player ) )
    {
        return;
    }
    
    if ( isbot( player ) || istestclient( player ) || isai( player ) )
    {
        return;
    }
    
    timefrommatchstart = telemetry_utils::get_time_from_match_start( eventtime );
    scoreevent = data.scoreevent;
    
    if ( isxhash( scoreevent ) )
    {
        scoreevent = getxhashhexname( scoreevent );
    }
    
    var_da6175121f0769cb = player dlog_recordplayerevent( "dlog_event_mp_player_score_event", [ "time_from_match_start_ms", timefrommatchstart, "score_event", scoreevent, "points", data.points ?? 0 ] );
    
    if ( isdefined( player.pers[ "telemetry" ].player_score_event_count ) && var_da6175121f0769cb )
    {
        player.pers[ "telemetry" ].player_score_event_count++;
    }
}

// Namespace telemetry_mp
// Params 1
// Checksum 0x1265d8c7, Offset: 0x11755
// Size: 0xd5
function on_reload_cancel( data )
{
    player = data.player;
    cancelreason = data.cancelreason;
    reloadtimestart = data.reloadcanceltime;
    var_46d8c510a04d7126 = player function_c9980b59cc6aa434();
    
    if ( !var_46d8c510a04d7126 )
    {
        return;
    }
    
    if ( !telemetry_utils::is_valid_client( player ) )
    {
        return;
    }
    
    if ( isbot( player ) || istestclient( player ) || isai( player ) )
    {
        return;
    }
    
    if ( !isdefined( cancelreason ) )
    {
        cancelreason = "DEFAULT";
    }
    
    player dlog_recordplayerevent( "dlog_event_reload_cancel_reason", [ "reload_cancel_time", reloadtimestart, "reload_canceled", 1, "reload_cancel_type", cancelreason ] );
}

// Namespace telemetry_mp
// Params 1
// Checksum 0xc1e0be04, Offset: 0x11832
// Size: 0x232
function on_game_event( data )
{
    player = undefined;
    lifeindex = -1;
    
    if ( isdefined( data.player ) && telemetry_utils::is_valid_client( data.player ) && game_utility_common::isgameparticipant( data.player ) )
    {
        player = data.player;
        
        if ( isdefined( data.player.pers[ "telemetry" ].life.life_index ) )
        {
            lifeindex = data.player.pers[ "telemetry" ].life.life_index;
        }
    }
    
    timefrommatchstart = telemetry_utils::get_time_from_match_start( gettime() );
    dlog_recordevent( "dlog_event_mp_game_event", [ "client", player, "event_name", getxhash( data.eventname ), "time_from_match_start_ms", timefrommatchstart, "player_life_index", lifeindex, "pos_x", data.position[ 0 ] ?? 0, "pos_y", data.position[ 1 ] ?? 0, "pos_z", data.position[ 2 ] ?? 0, "extra_info_0", data.extra_info_0 ?? #"", "extra_info_1", data.extra_info_1 ?? #"", "extra_info_2", data.extra_info_2 ?? #"" ] );
    
    if ( isdefined( game[ "telemetry" ].game_event_count ) )
    {
        game[ "telemetry" ].game_event_count++;
    }
}

// Namespace telemetry_mp
// Params 2, eflags: 0x4
// Checksum 0xbb6fb0f6, Offset: 0x11a6c
// Size: 0x1b0
function private function_78e1d7de16e82d4c( mainreason, specificreason )
{
    var_2ded7f49b3d6d1d5 = [];
    var_2ded7f49b3d6d1d5[ "armor_plate_done" ] = "NONE";
    var_2ded7f49b3d6d1d5[ "death" ] = "DEATH";
    var_2ded7f49b3d6d1d5[ "mantle_start" ] = "MANTLE_STARTED";
    var_2ded7f49b3d6d1d5[ "last_stand_enter" ] = "LAST_STAND_STARTED";
    var_2ded7f49b3d6d1d5[ "scr_change_swim_state" ] = "SWIM_STATE_CHANGED";
    var_2ded7f49b3d6d1d5[ "special_weapon_fired" ] = "SPECIAL_WEAPON_FIRED";
    var_2ded7f49b3d6d1d5[ "try_armor_cancel" ] = [];
    var_2ded7f49b3d6d1d5[ "try_armor_cancel" ][ "damage_received" ] = "DAMAGE_RECEIVED";
    var_2ded7f49b3d6d1d5[ "try_armor_cancel" ][ "parachuting" ] = "PARACHUTING";
    var_2ded7f49b3d6d1d5[ "try_armor_cancel" ][ "last_stand_reviver_start" ] = "LAST_STAND_REVIVER_STARTED";
    var_2ded7f49b3d6d1d5[ "try_armor_cancel" ][ "armory_kiosk_used" ] = "ARMORY_KIOSK_USED";
    var_2ded7f49b3d6d1d5[ "try_armor_cancel" ][ "interrogation_interrogator_start" ] = "INTERROGATION_INTERROGATOR_STARTED";
    var_2ded7f49b3d6d1d5[ "try_armor_cancel" ][ "vehicle_enter" ] = "VEHICLE_ENTER";
    var_2ded7f49b3d6d1d5[ "try_armor_cancel" ][ "game_end" ] = "GAME_END";
    var_2ded7f49b3d6d1d5[ "try_armor_cancel" ][ "all_armor_plates_dropped" ] = "ALL_ARMOR_PLATES_DROPPED";
    var_2ded7f49b3d6d1d5[ "try_armor_cancel" ][ "loadout_open" ] = "LOADOUT_OPEN";
    var_2ded7f49b3d6d1d5[ "try_armor_cancel" ][ "ladder_used" ] = "LADDER_USED";
    var_2ded7f49b3d6d1d5[ "try_armor_cancel" ][ "player_switched_weapon" ] = "PLAYER_SWITCHED_WEAPON";
    var_2ded7f49b3d6d1d5[ "try_armor_cancel" ][ "player_switched_to_grenade" ] = "PLAYER_SWITCHED_TO_GRENADE";
    var_2ded7f49b3d6d1d5[ "try_armor_cancel" ][ "player_interaction" ] = "PLAYER_DIRECT_ACTION";
    var_2ded7f49b3d6d1d5[ "try_armor_cancel" ][ "armor_unselected" ] = "OTHER_ARMOR_UNSELECTED";
    telemetryvalue = var_2ded7f49b3d6d1d5[ mainreason ];
    
    if ( isarray( telemetryvalue ) )
    {
        telemetryvalue = var_2ded7f49b3d6d1d5[ mainreason ][ specificreason ];
    }
    
    if ( !isdefined( telemetryvalue ) )
    {
        telemetryvalue = "OTHER";
    }
    
    return telemetryvalue;
}

// Namespace telemetry_mp
// Params 1
// Checksum 0xfab1a2a5, Offset: 0x11c25
// Size: 0x61
function on_player_armor_auto_apply( data )
{
    if ( !telemetry_utils::is_valid_client( data.player ) )
    {
        return;
    }
    
    data.player dlog_recordplayerevent( "dlog_event_player_armor_auto_equip_cancel", [ "cancel_reason", function_78e1d7de16e82d4c( data.mainreason, data.specificreason ) ] );
}

// Namespace telemetry_mp
// Params 1
// Checksum 0x1959aca9, Offset: 0x11c8e
// Size: 0x1ea
function dmz_on_exfil( data )
{
    data.player dlog_recordplayerevent( "dlog_event_dmz_player_extraction_complete", [ "team", data.current_team, "player_x", data.x, "player_y", data.y, "player_z", data.z, "player_pitch", data.xrot, "player_yaw", data.yrot, "player_roll", data.zrot, "lpcon_level", data.lpconlevel, "match_time_elapsed", data.matchtimeelapsed, "extraction_type", data.extractiontype, "cash_total", data.cashtotal, "backpack_items", data.backpackitems, "stowed_weapon", data.stowedweapon, "loadout_items", data.loadoutitems, "mission_1_status", data.mission1status, "mission_2_status", data.mission2status, "mission_3_status", data.mission3status, "new_items_unlocked", data.newitemsunlocked, "exfilstreak", data.exfilstreak ] );
}

// Namespace telemetry_mp
// Params 1
// Checksum 0xd06eed98, Offset: 0x11e80
// Size: 0x142
function dmz_on_container( data )
{
    data.player dlog_recordplayerevent( "dlog_event_dmz_container_open", [ "team", data.current_team, "player_x", data.x, "player_y", data.y, "player_z", data.z, "player_pitch", data.xrot, "player_yaw", data.yrot, "player_roll", data.zrot, "lpcon_level", data.lpconlevel, "match_time_elapsed", data.matchtimeelapsed, "item_ids", data.itemids, "item_counts", data.itemcounts, "container_type", data.container_type ] );
}

// Namespace telemetry_mp
// Params 1
// Checksum 0xf9a7b83b, Offset: 0x11fca
// Size: 0x112
function dmz_contract( data )
{
    data.player dlog_recordplayerevent( "dlog_event_dmz_contract_complete", [ "contract_name", data.activity_name, "result", data.result, "team", data.teamid, "endx", data.x, "endy", data.y, "endz", data.z, "startx", data.contractoriginx, "starty", data.contractoriginy, "startz", data.contractoriginz, "poi", data.script_poi ] );
}

// Namespace telemetry_mp
// Params 1
// Checksum 0x3f677ec4, Offset: 0x120e4
// Size: 0x161
function function_c5eca3da8c74bf06( callbackparams )
{
    type = callbackparams.source;
    rankxp = callbackparams.amount;
    xptype = callbackparams.resourcetype;
    
    if ( !isdefined( type ) || !isdefined( rankxp ) || !isdefined( xptype ) )
    {
        println( "<dev string:x445>" );
        return;
    }
    
    sourcestr = #"unknown";
    
    if ( isdefined( type ) )
    {
        if ( isxhash( type ) )
        {
            sourcestr = type;
        }
        
        if ( self.var_4820067d5f8a5cb4 && type == #"kill" )
        {
            sourcestr = #"hash_b914e84b33f78c3b";
        }
        else if ( !self.var_4820067d5f8a5cb4 && type == #"kill" )
        {
            sourcestr = #"player_kill";
        }
        
        self.var_4820067d5f8a5cb4 = undefined;
    }
    
    transactiondata = [ "resource_type", xptype, "source", getxhash( sourcestr ), "sink", #"none", "amount", rankxp, "is_spend", 0 ];
    self dlog_recordplayerevent( "dlog_event_dmz_resource_transaction", transactiondata );
}

// Namespace telemetry_mp
// Params 1
// Checksum 0xb192ea27, Offset: 0x1224d
// Size: 0x17e
function function_1f4211e0341b8ce( callbackparams )
{
    sourceitem = callbackparams.sourceitem;
    currencyamount = callbackparams.amount;
    currencytype = callbackparams.currencytype;
    
    if ( !isdefined( sourceitem ) || !isdefined( currencyamount ) || !isdefined( currencytype ) )
    {
        println( "<dev string:x492>" );
        return;
    }
    
    if ( !isxhash( currencytype ) )
    {
        assertmsg( "<dev string:x4fc>" );
        return;
    }
    
    if ( sourceitem.fromground )
    {
        source = #"ground_pickup";
    }
    else if ( sourceitem.fromcache )
    {
        source = #"container";
    }
    else if ( sourceitem.aidropped )
    {
        source = #"looted_ai";
    }
    else if ( sourceitem.playerdropped )
    {
        source = #"looted_player";
    }
    else
    {
        source = #"other";
    }
    
    transactiondata = [ "resource_type", getxhash( currencytype ), "source", getxhash( source ), "sink", #"none", "amount", currencyamount, "is_spend", 0 ];
    self dlog_recordplayerevent( "dlog_event_dmz_resource_transaction", transactiondata );
}

// Namespace telemetry_mp
// Params 1
// Checksum 0x23c3e2f2, Offset: 0x123d3
// Size: 0xfd
function function_49f54e00529f2bf6( callbackparams )
{
    if ( !isplayer( self ) && player::isreallyalive( self ) )
    {
        return;
    }
    
    lootid = callbackparams.sourceitem;
    itemamount = callbackparams.amount;
    
    if ( !isdefined( lootid ) || !isdefined( itemamount ) )
    {
        println( "<dev string:x492>" );
        return;
    }
    
    itemref = loot::function_f54ecb89dfab8e8c( lootid );
    transactiondata = [ "resource_type", itemref ?? #"unknown", "source", #"dropped", "sink", #"death", "amount", itemamount ?? -1, "is_spend", 0 ];
    self dlog_recordplayerevent( "dlog_event_dmz_resource_transaction", transactiondata );
}

// Namespace telemetry_mp
// Params 1
// Checksum 0xbc21357b, Offset: 0x124d8
// Size: 0x57
function function_e9916990e84fae44( player )
{
    current_team = "unset";
    
    if ( isdefined( player.sessionteam ) )
    {
        current_team = player.sessionteam;
    }
    
    if ( isdefined( player.team ) )
    {
        current_team = player.team;
    }
    
    return current_team;
}

// Namespace telemetry_mp
// Params 3
// Checksum 0x1ff14f28, Offset: 0x12538
// Size: 0x1e3
function function_390c5cfc04cca2d9( activity, result, completingteam )
{
    if ( !isdefined( activity ) )
    {
        return;
    }
    
    if ( !isdefined( activity.name ) )
    {
        return;
    }
    
    if ( !isdefined( result ) )
    {
        result = "fail";
    }
    
    players = teams::getteamdata( completingteam, "players" );
    
    foreach ( player in players )
    {
        current_team = function_e9916990e84fae44( player );
        data = spawnstruct();
        data.activity_name = activity.name;
        data.player = player;
        data.result = result;
        data.teamid = current_team;
        data.x = player.origin[ 0 ];
        data.y = player.origin[ 1 ];
        data.z = player.origin[ 2 ];
        data.contractoriginx = activity.origin[ 0 ];
        data.contractoriginy = activity.origin[ 1 ];
        data.contractoriginz = activity.origin[ 2 ];
        data.script_poi = activity.script_poi;
        telemetry_utils::function_af2d366f9522f76f( "callback_dmz_contract", data );
    }
}

// Namespace telemetry_mp
// Params 1
// Checksum 0x44a773ae, Offset: 0x12723
// Size: 0x1d8
function dmz_on_reinforce( data )
{
    if ( !isdefined( data ) )
    {
        return;
    }
    
    if ( !isdefined( data.agents ) )
    {
        return;
    }
    
    matchtime = int( game_utility_mp::getsecondspassed() );
    location = data.reinforceorigin;
    
    if ( !isdefined( location ) )
    {
        location = ( 0, 0, 0 );
    }
    
    poi = data.script_poi;
    
    if ( !isdefined( poi ) )
    {
        poi = "none";
    }
    
    agentlist = [];
    
    foreach ( agent in data.agents )
    {
        if ( isdefined( agent.agent_type ) )
        {
            agentlist[ agentlist.size ] = agent.agent_type;
        }
    }
    
    lpconlevel = "0";
    
    if ( isdefined( level.lpconmanager.currentalertlevel ) )
    {
        lpconlevel = string( level.lpconmanager.currentalertlevel );
    }
    
    dlog_recordevent( "dlog_event_dmz_reinforcement_triggered", [ "time_elapsed", matchtime, "lpcon_level", lpconlevel, "pos_x", location[ 0 ], "pos_y", location[ 1 ], "pos_z", location[ 2 ], "poi", poi, "agents", agentlist ] );
}

// Namespace telemetry_mp
// Params 1
// Checksum 0xd7e5aae1, Offset: 0x12903
// Size: 0xf7
function function_36adeffaa952e72( data )
{
    matchtimeelapsed = -1;
    
    if ( isdefined( data.matchtimeelapsed ) )
    {
        matchtimeelapsed = data.matchtimeelapsed;
    }
    
    teamsremaining = -1;
    
    if ( isdefined( data.teamsremaining ) )
    {
        teamsremaining = data.teamsremaining;
    }
    
    agentskilled = -1;
    
    if ( isdefined( data.agentskilled ) )
    {
        agentskilled = data.agentskilled;
    }
    
    lpconlevel = #"undefined";
    
    if ( isdefined( data.lpconlevel ) )
    {
        lpconlevel = telemetry_dmz::function_3ae64a84c6590538();
    }
    
    dlog_recordevent( "dlog_event_dmz_biolab_lpcon", [ "match_time_elapsed", matchtimeelapsed, "teams_remaining", teamsremaining, "agents_killed", agentskilled, "lpcon_level", lpconlevel ] );
}

// Namespace telemetry_mp
// Params 1
// Checksum 0x23b82557, Offset: 0x12a02
// Size: 0x139
function function_309bfd2186e3eab3( weaponobj )
{
    if ( !isdefined( weaponobj ) )
    {
        return "invalid";
    }
    
    if ( isdefined( weaponobj.weaponblueprint.lootid ) )
    {
        return string( weaponobj.weaponblueprint.lootid );
    }
    
    if ( isdefined( level.killstreakweaponmap[ weaponobj.basename ] ) )
    {
        lootid = loot::getlootidfromref( level.killstreakweaponmap[ weaponobj.basename ] );
        
        if ( isdefined( lootid ) && lootid != 0 )
        {
            return string( lootid );
        }
    }
    
    superref = supers_mp::getsuperrefforsuperweapon( weaponobj );
    lootid = loot::getlootidfromref( superref );
    
    if ( isdefined( lootid ) && lootid != 0 )
    {
        return string( lootid );
    }
    
    equipmentref = equipment_mp::getequipmentreffromweapon( weaponobj );
    lootid = loot::getlootidfromref( equipmentref );
    
    if ( isdefined( lootid ) && lootid != 0 )
    {
        return string( lootid );
    }
    
    weaponref = weapon::getweaponrootname( weaponobj );
    lootid = loot::getlootidfromref( weaponref );
    
    if ( isdefined( lootid ) && lootid != 0 )
    {
        return string( lootid );
    }
    
    return "invalid";
}

// Namespace telemetry_mp
// Params 0
// Checksum 0xac0a5017, Offset: 0x12b44
// Size: 0xa0
function function_413dc2fb17219cd4()
{
    game_type = game_utility::function_e9de4eeab29754c3();
    sub_game_type = game_utility::getgametype();
    playlist_id = 0;
    playlist_name = "";
    
    if ( level.matchmakingmatch )
    {
        playlist_id = getplaylistid();
        playlist_name = getplaylistname();
    }
    
    round_num = -1;
    
    if ( game_utility_mp::isroundbased() )
    {
        round_num = game[ "roundsPlayed" ];
    }
    
    return [ level.script, game_type, sub_game_type, playlist_id, playlist_name, round_num ];
}

// Namespace telemetry_mp
// Params 1
// Checksum 0xe9c1c6f4, Offset: 0x12bed
// Size: 0x430
function function_56db95c628b43903( weaponobj )
{
    ampdata = [];
    ampdata[ 0 ] = "";
    ampdata[ 1 ] = "";
    ampdata[ 2 ] = "";
    ampdata[ 3 ] = "";
    ampdata[ 4 ] = "";
    ampdata[ 5 ] = "";
    ampdata[ 6 ] = "";
    ampdata[ 7 ] = "";
    ampdata[ 8 ] = "";
    ampdata[ 9 ] = "";
    ampdata[ 10 ] = "";
    ampdata[ 11 ] = "";
    ampdata[ 12 ] = "";
    
    if ( isdefined( weaponobj ) )
    {
        if ( weaponobj hasattachment( "jup_jp12_pi_mike93_bar_hvyconvert" ) )
        {
            ampdata[ 11 ] = "jup_jp12_pi_mike93_bar_hvyconvert";
            ampdata[ 1 ] = "jup_jp12_pi_mike93_bar_hvyconvert";
            ampdata[ 5 ] = "jup_jp12_mike93_grip_amp_vert";
            ampdata[ 2 ] = "jup_jp12_pi_mike93_stock";
            ampdata[ 4 ] = "jup_mike93_ironsdefault_stockp";
        }
        else if ( weaponobj hasattachment( "jup_bromeo2m_amp" ) )
        {
            ampdata[ 11 ] = "jup_bromeo2m_amp";
            ampdata[ 0 ] = "jup_bromeo2m_rec";
            ampdata[ 6 ] = "ammo_762s";
            ampdata[ 1 ] = "jup_jp02_ar_bromeo2m_bar_heavy_short";
            ampdata[ 2 ] = "jup_jp02_br_bromeo2_stock_folding";
            ampdata[ 3 ] = "jup_jp02_ar_bromeo2m_mag_30_762s";
            ampdata[ 4 ] = "jup_bromeo2m_ironsdefault";
            ampdata[ 8 ] = "jup_jp02_br_bromeo2_pgrip_ass";
        }
        else if ( weaponobj hasattachment( "jup_cp24_sm_glima21_bar_convert" ) )
        {
            ampdata[ 11 ] = "jup_cp24_sm_glima21_bar_convert";
            ampdata[ 1 ] = "jup_cp24_sm_glima21_bar_convert";
        }
        else if ( weaponobj hasattachment( "jup_pkilop_amp_bull" ) )
        {
            ampdata[ 11 ] = "jup_pkilop_amp_bull";
            ampdata[ 1 ] = "jup_jp06_lm_pkilob_bar_bullshort";
            ampdata[ 2 ] = "jup_jp06_lm_pkilob_stock_pad";
            ampdata[ 3 ] = "jup_jp06_lm_pkilob_belt_100_762n";
            ampdata[ 4 ] = "jup_pkilob_ironsdefault";
            ampdata[ 0 ] = "jup_pkilob_rec";
        }
        else if ( weaponobj hasattachment( "jup_jp07_sm_uzulu_22_45acp" ) )
        {
            ampdata[ 11 ] = "jup_jp07_sm_uzulu_22_45acp";
            ampdata[ 1 ] = "jup_jp07_sm_uzulu_bar_amp_45";
            ampdata[ 2 ] = "jup_jp07_sm_uzulu_stock_amp_45";
            ampdata[ 3 ] = "jup_jp07_sm_uzulu_22_45acp";
            ampdata[ 6 ] = "ammo_45acp";
            ampdata[ 0 ] = "jup_uzulu_rec_amp";
            ampdata[ 5 ] = "jup_grip_uzulup1_amp";
        }
        else if ( weaponobj hasattachment( "jup_jp07_sm_uzulup_stock_brace" ) )
        {
            ampdata[ 11 ] = "jup_jp07_sm_uzulup_stock_brace";
            ampdata[ 2 ] = "jup_jp07_sm_uzulup_stock_brace";
            ampdata[ 12 ] = "jup_uzulup_akimbo";
        }
        else if ( weaponobj hasattachment( "jup_acharlie_amp_300blk" ) )
        {
            ampdata[ 11 ] = "jup_acharlie_amp_300blk";
            ampdata[ 0 ] = "jup_acharlie300_rec";
            ampdata[ 6 ] = "ammo_blk";
            ampdata[ 1 ] = "jup_jp19_ar_acharlie300_bar_lgtlong";
            ampdata[ 2 ] = "jup_jp19_ar_acharlie300_stockno";
            ampdata[ 3 ] = "jup_jp19_ar_acharlie300_mag_30_blk";
            ampdata[ 4 ] = "jup_acharlie300_ironsdefault";
            ampdata[ 8 ] = "jup_jp19_ar_acharlie300_pgrip_ass";
        }
        else if ( weaponobj hasattachment( "jup_jp08_ar_qbravo95_amp_t95" ) )
        {
            ampdata[ 11 ] = "jup_jp08_ar_qbravo95_amp_t95";
            ampdata[ 0 ] = "jup_qbravo95_rec";
            ampdata[ 1 ] = "jup_jp08_ar_qbravo95_bar";
            ampdata[ 3 ] = "jup_jp08_ar_qbravo95_mag_30_58";
            ampdata[ 4 ] = "jup_qbravo95_ironsdefault";
            ampdata[ 8 ] = "jup_jp08_ar_qbravo95_pgrip";
        }
        else if ( weaponobj hasattachment( "jup_jp19_dm_acharlied_mag_20_68r_amp" ) )
        {
            ampdata[ 11 ] = "jup_jp19_dm_acharlied_mag_20_68r_amp";
            ampdata[ 0 ] = "jup_acharlied_amp_rec";
            ampdata[ 2 ] = "jup_jp19_dm_acharlied_stock_tacheavy";
            ampdata[ 12 ] = "jup_acharlied_selectauto";
        }
        else if ( weaponobj hasattachment( "jup_jp14_pi_rsierra12_bar_amp" ) )
        {
            ampdata[ 11 ] = "jup_jp14_pi_rsierra12_bar_amp";
            ampdata[ 0 ] = "jup_rsierra12_convert_rec";
            ampdata[ 2 ] = "jup_jp14_pi_rsierra12_stock_amp";
            ampdata[ 8 ] = "jup_jp14_pi_rsierra12_pgrip_amp";
            ampdata[ 4 ] = "jup_rsierra12_irons_stock";
        }
        else if ( weaponobj hasattachment( "jup_jp19_br_acharlie450_drum_50_450b" ) )
        {
            ampdata[ 11 ] = "jup_jp19_br_acharlie450_drum_50_450b";
            ampdata[ 0 ] = "jup_acharlie450_rec_amp";
        }
        else if ( weaponobj hasattachment( "jup_jp02_sm_scharlie3_bar_amp" ) )
        {
            ampdata[ 11 ] = "jup_jp02_sm_scharlie3_bar_amp";
            ampdata[ 0 ] = "jup_scharlie3_rec_amp";
            ampdata[ 7 ] = "jup_comp_sm_14_amp";
        }
        else if ( weaponobj hasattachment( "jup_jp01_ar_golf36_bar_amp" ) )
        {
            ampdata[ 11 ] = "jup_jp01_ar_golf36_bar_amp";
            ampdata[ 0 ] = "jup_golf36_rec_amp";
            ampdata[ 4 ] = "jup_reflex08_tall_amp";
        }
        else if ( weaponobj hasattachment( "jup_jp01_dm_slima8_bar_amp" ) )
        {
            ampdata[ 11 ] = "jup_jp01_dm_slima8_bar_amp";
            ampdata[ 0 ] = "jup_slima8_rec_amp";
            ampdata[ 4 ] = "jup_reflex08_tall_amp";
        }
        else if ( weaponobj hasattachment( "jup_cp01_sm_coscar635_bar_amp" ) )
        {
            ampdata[ 11 ] = "jup_cp01_sm_coscar635_bar_amp";
            ampdata[ 0 ] = "jup_coscar635_amp_rec";
        }
    }
    
    return ampdata;
}

// Namespace telemetry_mp
// Params 1
// Checksum 0xd339ff33, Offset: 0x13026
// Size: 0xca
function function_c1db69208074fca9( data )
{
    data.player dlog_recordplayerevent( "dlog_event_player_the_hunt_report", [ "playlist_id", data.playlistid, "mode", data.mode, "sub_mode", data.sub_mode, "bones_zombies", data.bones_zombies, "skulls_armored_zombies", data.skulls_armored_zombies, "skulls_hellhounds", data.skulls_hellhounds, "skulls_mimics", data.skulls_mimics ] );
}

// Namespace telemetry_mp
// Params 1
// Checksum 0xadc58296, Offset: 0x130f8
// Size: 0x2c1
function function_ff3a9866a9f1757d( data )
{
    if ( getdvarint( @"scr_countdown", 0 ) )
    {
        foreach ( player in level.players )
        {
            if ( isdefined( player ) && !isbot( player ) && isdefined( player.team ) && player.team != "spectator" && player.team != "codcaster" )
            {
                if ( isdefined( player.pers[ "telemetry" ] ) && player.pers[ "telemetry" ].var_9d12a2481d9754b1 )
                {
                    return;
                }
                
                playlistid = -1;
                mode = "undefined";
                sub_mode = "undefined";
                map = "undefined";
                items_collected_type_0 = 0;
                items_collected_type_1 = 0;
                items_collected_type_2 = 0;
                items_collected_type_3 = 0;
                items_collected_total = 0;
                playlistid = getplaylistid();
                mode = game_utility::getgametype();
                map = game_utility::getmapname();
                
                if ( isdefined( player.var_24bbd6267f56da9f ) )
                {
                    items_collected_type_0 = player.var_24bbd6267f56da9f;
                }
                
                if ( isdefined( player.var_c7ff88b7aaa38b40 ) )
                {
                    items_collected_type_1 = player.var_c7ff88b7aaa38b40;
                }
                
                if ( isdefined( player.var_f354ef593e08f23d ) )
                {
                    items_collected_type_2 = player.var_f354ef593e08f23d;
                }
                
                if ( isdefined( player.var_b1246084988a9c9e ) )
                {
                    items_collected_type_3 = player.var_b1246084988a9c9e;
                }
                
                items_collected_total = items_collected_type_0 + items_collected_type_1 + items_collected_type_2 + items_collected_type_3;
                player.pers[ "telemetry" ].var_9d12a2481d9754b1 = 1;
                player dlog_recordplayerevent( "dlog_event_player_countdown", [ "playlist_id", playlistid, "mode", mode, "sub_mode", sub_mode, "map", map, "items_collected_type_0", items_collected_type_0, "items_collected_type_1", items_collected_type_1, "items_collected_type_2", items_collected_type_2, "items_collected_type_3", items_collected_type_3, "items_collected_total", items_collected_total ] );
            }
        }
    }
}

// Namespace telemetry_mp
// Params 0, eflags: 0x4
// Checksum 0x20ea93ad, Offset: 0x133c1
// Size: 0x21
function private function_63c6fc21f87b8553()
{
    player = self;
    player callback::callback( #"player_match_end_analytics" );
}

// Namespace telemetry_mp
// Params 1, eflags: 0x4
// Checksum 0x87aecc0f, Offset: 0x133ea
// Size: 0xf4
function private on_player_death_end_match( data )
{
    player = data.victim;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player.endmatchstats[ "playerDeaths" ] = ( player.endmatchstats[ "playerDeaths" ] ?? 0 ) + 1;
    
    if ( isdefined( player.endmatchstats[ "lastLandingSpot" ] ) )
    {
        if ( !isdefined( player.endmatchstats[ "distancePlayerTravel" ] ) )
        {
            player.endmatchstats[ "distancePlayerTravel" ] = 0;
        }
        
        player.endmatchstats[ "distancePlayerTravel" ] = player.endmatchstats[ "distancePlayerTravel" ] + distance2d( player.origin, player.endmatchstats[ "lastLandingSpot" ] ?? player.origin );
        player.endmatchstats[ "lastLandingSpot" ] = undefined;
    }
}

// Namespace telemetry_mp
// Params 1, eflags: 0x4
// Checksum 0x77ad6c18, Offset: 0x134e6
// Size: 0xd1
function private function_17f67c882fe2f6c( params )
{
    team = params.task.team;
    
    if ( !isdefined( team ) )
    {
        return;
    }
    
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        player.endmatchstats[ "teamContractsAssigned" ] = ( player.endmatchstats[ "teamContractsAssigned" ] ?? 0 ) + 1;
    }
}

// Namespace telemetry_mp
// Params 1, eflags: 0x4
// Checksum 0x8b676d86, Offset: 0x135bf
// Size: 0x55
function private on_vehicle_enter( params )
{
    player = params.player;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player.endmatchstats[ "vehicleEnter" ] = ( player.endmatchstats[ "vehicleEnter" ] ?? 0 ) + 1;
}

// Namespace telemetry_mp
// Params 1, eflags: 0x4
// Checksum 0xe7e9c846, Offset: 0x1361c
// Size: 0x39
function private function_5bd3b4eeec2f3204( params )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.endmatchstats[ "platesInserted" ] = ( self.endmatchstats[ "platesInserted" ] ?? 0 ) + 1;
}

// Namespace telemetry_mp
// Params 1, eflags: 0x4
// Checksum 0xb7a239cd, Offset: 0x1365d
// Size: 0x39
function private on_plunder_pickup( params )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.endmatchstats[ "moneyPickupTimes" ] = ( self.endmatchstats[ "moneyPickupTimes" ] ?? 0 ) + 1;
}

// Namespace telemetry_mp
// Params 1, eflags: 0x4
// Checksum 0x4dedd086, Offset: 0x1369e
// Size: 0x77
function private function_ef10df305126b130( data )
{
    dlog_recordevent( "dlog_event_br_bots_proportion", [ "performance_value", data.performance_value, "proportion", data.proportion, "bots_count", data.bots_count, "ui_bots_count", data.ui_bots_count ] );
}

// Namespace telemetry_mp
// Params 2, eflags: 0x4
// Checksum 0x2c8ae730, Offset: 0x1371d
// Size: 0x18e
function private get_mp_header( origin, angles )
{
    [ map_name, game_type, sub_game_type, playlist_id, playlist_name, round_num ] = function_413dc2fb17219cd4();
    
    if ( !isdefined( origin ) )
    {
        origin[ 0 ] = -1;
        origin[ 1 ] = -1;
        origin[ 2 ] = -1;
    }
    
    if ( !isdefined( angles ) )
    {
        angles[ 0 ] = -1;
        angles[ 1 ] = -1;
        angles[ 2 ] = -1;
    }
    
    header = [ "map", map_name, "game_type", game_type, "sub_game_type", sub_game_type, "playlist_id", playlist_id, "playlist_name", playlist_name, "round_num", round_num, "gametime", gettime(), "originx", origin[ 0 ], "originy", origin[ 1 ], "originz", origin[ 2 ], "angleyaw", angles[ 1 ], "anglepitch", angles[ 0 ] ];
    return header;
}

// Namespace telemetry_mp
// Params 1, eflags: 0x4
// Checksum 0xe90d9255, Offset: 0x138b4
// Size: 0x3a
function private param_to_string( param )
{
    if ( !isdefined( param ) )
    {
        param = "";
    }
    else if ( isint( param ) || isfloat( param ) )
    {
        param = string( param );
    }
    
    return param;
}

// Namespace telemetry_mp
// Params 4
// Checksum 0x22ccd79c, Offset: 0x138f7
// Size: 0xad
function function_4a7abffd4afa0089( subevent, param0, param1, param2 )
{
    mp_header = get_mp_header();
    param0 = param_to_string( param0 );
    param1 = param_to_string( param1 );
    param2 = param_to_string( param2 );
    dlog_recordevent( "dlog_event_mp_notifications", [ "mp_header", mp_header, "sub_event", subevent, "param0", param0, "param1", param1, "param2", param2 ] );
}

// Namespace telemetry_mp
// Params 4
// Checksum 0x1c69f908, Offset: 0x139ac
// Size: 0xae
function function_354a8fa887bb995b( subevent, param0, param1, param2 )
{
    mp_header = get_mp_header();
    param0 = param_to_string( param0 );
    param1 = param_to_string( param1 );
    param2 = param_to_string( param2 );
    self dlog_recordplayerevent( "dlog_event_mp_notifications_player", [ "mp_header", mp_header, "sub_event", subevent, "param0", param0, "param1", param1, "param2", param2 ] );
}

// Namespace telemetry_mp
// Params 0
// Checksum 0x83b93444, Offset: 0x13a62
// Size: 0xdc
function function_f2f697e16046b9c5()
{
    wait 5;
    
    while ( true )
    {
        level.players[ 0 ] debug::function_4be0558f456a7a55( "DPAD_LEFT", "send_example_array_of_rows()" );
        telemetry_utils::function_af2d366f9522f76f( "callback_example", { #my_string:"regular string example BBB", #my_int:123456, #my_xhash_string:#"hash_21372455c009c541" } );
        data = spawnstruct();
        data.my_xhash_string = #"hash_2b903a55c66076f6";
        data.my_int = -98765;
        data.my_string = "regular string example BBB";
        telemetry_utils::function_af2d366f9522f76f( "callback_example", data );
        level.players[ 0 ] function_354a8fa887bb995b( "test player event" );
        function_4a7abffd4afa0089( "test server event" );
    }
}

// Namespace telemetry_mp
// Params 1, eflags: 0x4
// Checksum 0x61a61b7c, Offset: 0x13b46
// Size: 0x285
function private function_ccaa57587d66e80a( data )
{
    [ map_name, game_type, sub_game_type, playlist_id, playlist_name, round_num ] = function_413dc2fb17219cd4();
    num_unlogged = 0;
    row_array = [];
    
    foreach ( player in level.players )
    {
        row_array[ row_array.size ] = [ "player_name", player.name ?? player.classname, "health", player.health, "suit", player.suit ?? "", "voice", player.operatorcustomization.voice ?? "" ];
    }
    
    if ( row_array.size > 100 )
    {
        num_unlogged = row_array.size - 100;
    }
    
    dlog_recordevent( "dlog_event_example_with_array_of_rows", [ "example_rows", row_array, "map", map_name, "game_type", game_type, "sub_game_type", sub_game_type, "playlist_id", playlist_id, "playlist_name", playlist_name, "round_num", round_num, "num_entries_total", row_array.size, "num_entries_unlogged", num_unlogged, "my_xhash_string", data.my_xhash_string ?? "", "my_int", data.my_int ?? 0, "my_string", data.my_string ?? "" ] );
}

// Namespace telemetry_mp
// Params 1
// Checksum 0xf7a97df3, Offset: 0x13dd3
// Size: 0x65b
function function_5b217bffe8d1fa92( data )
{
    if ( isbrgamemode() )
    {
        return;
    }
    
    speaker_name = "";
    speaker_team = "";
    speaker_voice = "";
    speaker_sessionstate = "";
    speaker_origin_x = -1;
    speaker_origin_y = -1;
    speaker_origin_z = -1;
    speaker_is_player = 0;
    target_name = "";
    target_voice = "";
    target_sessionstate = "";
    target_origin_x = -1;
    target_origin_y = -1;
    target_origin_z = -1;
    target_is_player = 0;
    
    if ( isdefined( data.speaker ) )
    {
        speaker_name = data.speaker.suit;
        speaker_team = data.speaker.team;
        speaker_sessionstate = data.speaker.sessionstate;
        speaker_origin_x = data.speaker.origin[ 0 ];
        speaker_origin_y = data.speaker.origin[ 1 ];
        speaker_origin_z = data.speaker.origin[ 2 ];
        
        if ( !isbot( data.speaker ) && isplayer( data.speaker ) )
        {
            speaker_is_player = 1;
        }
        
        if ( isdefined( data.speaker.operatorcustomization ) )
        {
            speaker_voice = data.speaker.operatorcustomization.voice;
        }
    }
    
    if ( isdefined( data.target ) )
    {
        if ( isdefined( data.target.suit ) )
        {
            target_name = data.target.suit;
        }
        else
        {
            target_name = data.target.classname;
        }
        
        target_sessionstate = data.target.sessionstate;
        target_origin_x = data.target.origin[ 0 ];
        target_origin_y = data.target.origin[ 1 ];
        target_origin_z = data.target.origin[ 2 ];
        
        if ( isent( data.target ) && !isbot( data.target ) && isplayer( data.target ) )
        {
            target_is_player = 1;
        }
        
        if ( isdefined( data.target.operatorcustomization ) )
        {
            target_voice = data.target.operatorcustomization.voice;
        }
    }
    
    [ map_name, game_type, sub_game_type, playlist_id, playlist_name, round_num ] = function_413dc2fb17219cd4();
    dlog_recordevent( "dlog_event_mp_operator_vo", [ "map", map_name, "game_type", game_type, "sub_game_type", sub_game_type, "playlist_id", playlist_id, "playlist_name", playlist_name, "round_num", round_num, "script_func_name", data.script_func_name, "sound_type", data.sound_type ?? "", "sound_event", data.sound_event, "speaker_name", speaker_name ?? "", "speaker_voice", speaker_voice ?? "", "speaker_team", speaker_team ?? "", "speaker_origin_x", speaker_origin_x, "speaker_origin_y", speaker_origin_y, "speaker_origin_z", speaker_origin_z, "speaker_sessionstate", speaker_sessionstate ?? "", "speaker_is_player", speaker_is_player, "target_name", target_name ?? "", "target_voice", target_voice ?? "", "target_origin_x", target_origin_x, "target_origin_y", target_origin_y, "target_origin_z", target_origin_z, "target_sessionstate", target_sessionstate ?? "", "target_is_player", target_is_player ] );
    
    if ( !isdefined( level.var_544ae808cb81ffc1 ) )
    {
        level.var_544ae808cb81ffc1 = [];
    }
    
    if ( !isdefined( level.var_544ae808cb81ffc1[ data.sound_event ] ) )
    {
        level.var_544ae808cb81ffc1[ data.sound_event ] = spawnstruct();
        level.var_544ae808cb81ffc1[ data.sound_event ].count = 1;
        level.var_544ae808cb81ffc1[ data.sound_event ].player_only_count = 1;
        level.var_544ae808cb81ffc1[ data.sound_event ].name = data.sound_event;
        return;
    }
    
    level.var_544ae808cb81ffc1[ data.sound_event ].count++;
    
    if ( speaker_is_player )
    {
        level.var_544ae808cb81ffc1[ data.sound_event ].player_only_count++;
    }
}

// Namespace telemetry_mp
// Params 2, eflags: 0x4
// Checksum 0xd54b4e7f, Offset: 0x14436
// Size: 0x2c, Type: bool
function private function_e9505484d454c958( left, right )
{
    return left.count >= right.count;
}

// Namespace telemetry_mp
// Params 2, eflags: 0x4
// Checksum 0x3e33bf92, Offset: 0x1446b
// Size: 0x2fc
function private function_5c45d02d1a36cf5c( round_start_time_ms, round_end_time_ms )
{
    if ( isbrgamemode() )
    {
        return;
    }
    
    [ map_name, game_type, sub_game_type, playlist_id, playlist_name, round_num ] = function_413dc2fb17219cd4();
    dlog_row_array = [];
    num_unique_entries_total = 0;
    num_unique_entries_unlogged = 0;
    
    if ( isdefined( level.var_544ae808cb81ffc1 ) )
    {
        num_unique_entries_total = level.var_544ae808cb81ffc1.size;
        sorted = [];
        
        foreach ( var_d8e2768f36b1d97d in level.var_544ae808cb81ffc1 )
        {
            sorted[ sorted.size ] = var_d8e2768f36b1d97d;
        }
        
        sorted = arraysort( sorted, undefined, &function_e9505484d454c958 );
        
        if ( sorted.size > 500 )
        {
            num_unique_entries_unlogged = num_unique_entries_total - 500;
            median_index = int( num_unique_entries_total * 0.5 );
            delete_start_index = median_index - int( num_unique_entries_unlogged * 0.5 );
            delete_end_index = delete_start_index + median_index - 1;
            
            for ( i = delete_start_index; i <= delete_end_index ; i++ )
            {
                sorted[ i ] = undefined;
            }
            
            assertmsg( "<dev string:x567>" + num_unique_entries_unlogged + "<dev string:x58d>" + 500 + "<dev string:x5fc>" );
        }
        
        for ( i = 0; i < sorted.size ; i++ )
        {
            if ( isdefined( sorted[ i ] ) )
            {
                dlog_row_array[ dlog_row_array.size ] = [ "sound_event", sorted[ i ].name, "count", sorted[ i ].count, "player_only_count", sorted[ i ].player_only_count ];
            }
        }
    }
    
    dlog_recordevent( "dlog_event_mp_operator_vo_accumulated", [ "events", dlog_row_array, "map", map_name, "game_type", game_type, "sub_game_type", sub_game_type, "playlist_id", playlist_id, "playlist_name", playlist_name, "round_start_time_ms", round_start_time_ms, "round_end_time_ms", round_end_time_ms, "round_num", round_num, "num_unique_entries_total", num_unique_entries_total, "num_unique_entries_unlogged", num_unique_entries_unlogged ] );
}

