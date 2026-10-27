// scripts\mp\ob\contracts\sat_ob_contract_taurus_destroy_supplies.gsc  (hash_7b76bcb14efd1b71.gscc) (size: 39771 Bytes / 0x9b5b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9aa951d5 (2594787797)
// size ...... 39771 (0x9b5b)
// includes .. 35  (offset: 0x9283)
// strings ... 130 (offset: 0x939b)
// dev strs .. 4   (offset: 0x9b23)
// exports ... 79  (offset: 0x66bb)
// cseg ...... 0xf3c + 0x577f (0x66bb)
// imports ... 250 (offset: 0x7313)
// animtree1 . 0   (offset: 0x9b5b)
// animtree2 . 0   (offset: 0x9b5b)
#using script_3edd59d0d3fc3262;
#using script_636bd827a012af12;
#using script_66878054d141dbc0;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_progress_tracking;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\ai_spawn_director_utility;
#using scripts\common\callbacks;
#using scripts\common\gasmask;
#using scripts\common\hud_util;
#using scripts\common\math;
#using scripts\common\metabone;
#using scripts\common\scene;
#using scripts\common\scriptable;
#using scripts\common\snd\snd_utility;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\class;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob;
#using scripts\mp\hud_message;
#using scripts\mp\ob\contracts\ob_contract_ui_widget;
#using scripts\mp\ob\systems\ob_activity_manager;
#using scripts\mp\ob\systems\ob_item_select;
#using scripts\mp\overlord;
#using scripts\mp\snd\snd_ob;

#namespace sat_ob_contract_taurus_destroy_supplies;

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 0, eflags: 0x5
// Checksum 0x2138bc46, Offset: 0xf5a
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"sat_ob_contract_taurus_destroy_supplies", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 0, eflags: 0x4
// Checksum 0xaec85af0, Offset: 0xf83
// Size: 0xc8
function private function_538033a540e63c70()
{
    ob_settings = ob::get_ob_settings();
    
    if ( !ob_settings.var_49178f6e5c220274 )
    {
        return;
    }
    
    level._effect[ "dock_crate_vfx" ] = loadfxasset( "vfx_sat_wc_avalon_ob_cradle_crates_exp" );
    level._effect[ "dock_crate_vfx_01" ] = loadfxasset( "vfx_sat_wc_avalon_ob_cradle_crates_exp_ch01" );
    level._effect[ "dock_crate_vfx_02" ] = loadfxasset( "vfx_sat_wc_avalon_ob_cradle_crates_exp_ch02" );
    level._effect[ "cradle_influence_vfx_avalon_heavy" ] = loadfxasset( "vfx_sat_mp_ob_avalon_void_br_fog" );
    level._effect[ "taurus_cradle_spawn_vfx" ] = loadfxasset( "vfx_mp_wc_leo_nic_character_spawn_cradle" );
    activity_common::registeractivitytype( "REV_OB_TAURUS_DESTROY_SUPPLIES", &activity_type_init );
    level callback::add( #"hash_cc06eb1d45f33a0c", &on_player_connect_squad );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 1
// Checksum 0x88d755a1, Offset: 0x1053
// Size: 0x355
function on_player_connect_squad( params )
{
    self notify( #"hash_eb82baa305c2cf0c" );
    self endon( #"hash_eb82baa305c2cf0c" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    utility::flag_wait( "scriptables_ready" );
    utility::ent_flag_wait( "squad_play_begin" );
    story_contract_util::waittill_active( self, #"taurus_destroy_supplies" );
    
    while ( !isdefined( level.taurus_destroy_supplies_activity ) )
    {
        waitframe();
    }
    
    if ( !isdefined( level.var_519484a5bdaa7c24 ) )
    {
        classtableentry = getscriptbundle( hashcat( %"classtableentry:", "classtableentry_sat_ob_taurus_intro_loadout" ) );
        level.var_519484a5bdaa7c24 = { #loadout_key:"starting_loadout", #loadout_array:class::function_79947c7814a64d0e( classtableentry ) };
    }
    
    if ( !isdefined( self.current_loadout_key ) )
    {
        function_d626cc76cae468c1( self, level.var_519484a5bdaa7c24, 3 );
    }
    
    if ( !isdefined( level.taurus_destroy_supplies_squads ) )
    {
        level.taurus_destroy_supplies_squads = [];
    }
    
    if ( !isdefined( level.taurus_destroy_supplies_squads[ self.sessionsquadid ] ) )
    {
        squad_struct = { #sessionsquadid:self.sessionsquadid, #team:self.team, #hack_set:0 };
        level.taurus_destroy_supplies_squads[ self.sessionsquadid ] = squad_struct;
        squad_struct.exploded_site = 0;
        squad_struct.ttl_hacked = 0;
        squad_struct.planter_array = [];
        activity_instance = function_4135e559691c4a64( squad_struct, self, level.taurus_destroy_supplies_activities );
        thread function_4a88b972a328643d( activity_instance );
        activity_instance thread function_f76a865691db83c3( squad_struct );
        activity_instance thread function_4889800b6025fa23( self, squad_struct );
    }
    else
    {
        squad_struct = level.taurus_destroy_supplies_squads[ self.sessionsquadid ];
        
        while ( !isdefined( squad_struct.activity_instance ) )
        {
            waitframe();
        }
        
        thread function_4a88b972a328643d( squad_struct.activity_instance );
        activity_participation::function_bc67362dace4370c( squad_struct.activity_instance, self, "PlayerJoinedInteract" );
        
        if ( isdefined( squad_struct.activity_instance.var_f7af54e3a4e17c28 ) )
        {
            squad_struct.activity_instance.var_f7af54e3a4e17c28 showtoplayer( self );
            squad_struct.activity_instance.var_f7af54e3a4e17c28 game_utility::questcircle_showtoplayer( self );
            self function_a565dafac620d68e( "hw_sat_lm_avalon_ob_docks_void_gas" );
        }
        else
        {
            if ( squad_struct.objective_active )
            {
                squad_struct ob_story_mission_utils::objective_marker_show( squad_struct.objective_id, [ self ] );
                logstring( "[Taurus] Showing objective marker to player : " + squad_struct.objective_id );
            }
            
            squad_struct.activity_instance thread function_4889800b6025fa23( self, squad_struct );
        }
    }
    
    foreach ( abilitycase in level.taurus_ability_cases )
    {
        ob_item_select::function_923ddf97f6cdbee( abilitycase, [ self ] );
    }
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 3
// Checksum 0xedc26954, Offset: 0x13b0
// Size: 0xcd
function function_4135e559691c4a64( squad_struct, starting_player, activity_array )
{
    activity_to_start = undefined;
    
    while ( !isdefined( activity_to_start ) )
    {
        for ( i = 0; i < activity_array.size ; i++ )
        {
            if ( activity_instance_common::getactivitystate( activity_array[ i ] ) == "Idle" )
            {
                activity_to_start = activity_array[ i ];
                break;
            }
        }
        
        /#
            if ( getdvarint( @"hash_d22e9bd305bc502e", -1 ) >= 0 )
            {
                activity_to_start = activity_array[ getdvarint( @"hash_d22e9bd305bc502e" ) ];
            }
        #/
        
        if ( isdefined( activity_to_start ) )
        {
            squad_struct.activity_instance = activity_to_start;
            activity_participation::function_bc67362dace4370c( activity_to_start, self, "PlayerJoinedInteract" );
            break;
        }
        else
        {
            /#
                iprintlnbold( "<dev string:x24>" );
            #/
        }
        
        wait 3;
    }
    
    return activity_to_start;
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 3, eflags: 0x4
// Checksum 0x6e16b165, Offset: 0x1486
// Size: 0x73
function private function_d626cc76cae468c1( player, loadout, var_7c0d29caa7b948c6 )
{
    if ( loadout && player.current_loadout_key != loadout.loadout_key )
    {
        player thread ob_story_mission_utils::function_96a2f57e9afcdff1( player, loadout.loadout_array, var_7c0d29caa7b948c6, "primary", 1 );
        player.current_loadout_key = loadout.loadout_key;
    }
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 1
// Checksum 0x70c2fcf3, Offset: 0x1501
// Size: 0x52c
function function_f76a865691db83c3( squad_struct )
{
    activity_instance = self;
    activity_instance endon( #"hash_1b6b9613636daa6a" );
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    while ( !activity_instance.master_scriptables.size )
    {
        waitframe();
    }
    
    var_64bb57aa2d6e8b35 = teams::getsquaddata( squad_struct.team, squad_struct.sessionsquadid );
    var_64bb57aa2d6e8b35 childthread taurus_destroy_supplies_music( activity_instance );
    activity_instance thread taurus_destroy_supplies_respawn( squad_struct );
    activity_instance thread function_92b4d0fd6e59dbb4();
    activity_instance thread function_b62d81be9963de4( squad_struct );
    activity_instance thread cleanup_squad_struct( squad_struct.sessionsquadid, squad_struct );
    master_struct = activity_instance.master_struct;
    master_struct thread function_d75b51975c8b5879( squad_struct, activity_instance );
    activity_instance thread taurus_destroy_supplies_objectives( squad_struct, master_struct );
    
    if ( getdvarint( @"scr_sat_ob_taurus_void_docks", 0 ) )
    {
        thread void_docks_skip( squad_struct );
        self waittill( #"hash_3e8e7fcea80b4e2d" );
    }
    
    self waittill( #"taurus_crate_timer_finished" );
    squad_struct ob_story_mission_utils::objective_marker_clear( squad_struct.objective_id, function_9cdbaea6c78ac37b( squad_struct ) );
    self waittill( #"hash_c0e3c1963606ea48" );
    cradle_time = 20;
    squad = teams::function_72b89edf6b47c40a( activity_instance.playerparticipants[ 0 ] );
    teleport_structs = utility::getstructarray( "void_teleport_structs_01", "targetname" );
    thread function_6070fd94d3acb72a( teleport_structs, "player_teleported_to_void_docks" );
    
    foreach ( player in squad.players )
    {
        player playsoundtoplayer( "evt_taurus_cradle_transition", player );
    }
    
    thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "avalon_heavy", cradle_time, undefined, activity_instance.playerparticipants, undefined, undefined, 0 );
    self waittill( #"all_crates_exploded" );
    
    foreach ( player in squad.players )
    {
        player hud_util::function_a7b5c7ac6074b623( "red_tint", "white", ( 0.375, 0, 0.02 ) );
        player thread hud_util::fade_out( 3, "red_tint" );
    }
    
    wait 3;
    activity_instance function_a109e784e9b23f56( squad );
    squad.force_region_name = "difficulty3";
    activity_instance thread taurus_destroy_supplies_void_vo();
    activity_instance thread void_docks_enc( squad );
    wait 3;
    thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "avalon_heavy", 5, undefined, activity_instance.playerparticipants, undefined, undefined, 0 );
    
    foreach ( player in squad.players )
    {
        player thread hud_util::fade_in( 3, "red_tint" );
        playfx( level._effect[ "taurus_cradle_spawn_vfx" ], player.origin, undefined, undefined, player );
    }
    
    level utility::flag_wait( "void_docks_boss_dead" );
    activity_instance notify( #"void_docks_boss_dead" );
    taurus_boss_respawn_structs = utility::getstructarray( "taurus_boss_respawn_struct", "script_noteworthy" );
    thread function_6070fd94d3acb72a( taurus_boss_respawn_structs, "players_teleported_to_razor_boss_location" );
    thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "avalon_heavy", 4, undefined, activity_instance.playerparticipants, undefined, undefined, 0 );
    wait 3;
    
    foreach ( player in squad.players )
    {
        player hud_util::function_a7b5c7ac6074b623( "red_tint", "white", ( 0.375, 0, 0.02 ) );
        player thread hud_util::fade_out( 3, "red_tint" );
        player clearclienttriggeraudiozone( 3 );
    }
    
    wait 3;
    activity_instance.var_b4098616f1f61f0d = 1;
    squad.force_region_name = undefined;
    function_fb1c50645d49ebac( squad );
    story_contract_util::mark_complete( function_9cdbaea6c78ac37b( squad_struct ), #"taurus_destroy_supplies" );
    activity_participation::function_dd782fbeb3b07e39( activity_instance, function_9cdbaea6c78ac37b( squad_struct ) );
    
    if ( activity_instance_common::getactivitystate( activity_instance ) == "Active" )
    {
        activity_instance_common::endactivity( activity_instance, 1 );
    }
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 2
// Checksum 0x56fd98c3, Offset: 0x1a35
// Size: 0xdc
function function_6070fd94d3acb72a( teleport_structs, var_a489514894de55fa )
{
    self notify( #"hash_37e29f93842294c1" );
    self endon( #"hash_37e29f93842294c1" );
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance prestream_teleport_location( teleport_structs, var_a489514894de55fa );
    
    foreach ( player in activity_instance.playerparticipants )
    {
        if ( isdefined( player ) )
        {
            player clearpredictedstreampos();
        }
    }
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 2
// Checksum 0x40bdd7d9, Offset: 0x1b19
// Size: 0xdf
function prestream_teleport_location( teleport_structs, var_a489514894de55fa )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( isdefined( var_a489514894de55fa ) )
    {
        activity_instance endon( var_a489514894de55fa );
    }
    
    while ( true )
    {
        foreach ( player in activity_instance.playerparticipants )
        {
            if ( isdefined( player ) )
            {
                player predictstreamposuntilcleared( teleport_structs[ 0 ].origin );
            }
        }
        
        wait 0.25;
    }
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 1
// Checksum 0xf2e0bf7, Offset: 0x1c00
// Size: 0x238
function taurus_destroy_supplies_music( activity_instance )
{
    level endon( #"game_ended" );
    self notify( #"hash_18378c1dae0f1798" );
    self endon( #"hash_18378c1dae0f1798" );
    activity_instance endon( #"reset" );
    squad = self;
    assert( snd::issquad( squad ) );
    assert( isplayer( squad.players[ 0 ] ) );
    var_950c5eed6692bff6 = story_contract_util::function_35a4b91d1599df3e( squad.players[ 0 ] );
    
    if ( !arraycontains( [ "taurus_intro", "taurus_destroy_supplies", "taurus_cradle_vents" ], var_950c5eed6692bff6.ddl_bit ) )
    {
        return;
    }
    
    story_contract_util::function_800aae15896dfec6( squad.players, #"taurus_destroy_supplies" );
    waittillframeend();
    assert( isplayer( squad.players[ 0 ] ) );
    var_950c5eed6692bff6 = story_contract_util::function_35a4b91d1599df3e( squad.players[ 0 ] );
    assert( isstruct( var_950c5eed6692bff6 ) && isstring( var_950c5eed6692bff6.ddl_bit ) );
    utility::flag_wait( "ob_infil_completed" );
    story_contract_util::function_800aae15896dfec6( squad.players, #"taurus_destroy_supplies" );
    var_950c5eed6692bff6 = story_contract_util::function_35a4b91d1599df3e( squad.players[ 0 ] );
    snd_ob::squad_music_stop( squad );
    wait 4.17391;
    snd_ob::squad_music_with_boost( squad, "mx_taurus_escape_lp", 6, 140, 8, 24, 32 );
    activity_instance waittill( #"taurus_crate_timer_finished" );
    snd_ob::squad_music_stop( squad );
    activity_instance waittill( #"cradle_shipment_crate_exploded", supply_site );
    snd_ob::squad_music_with_boost( squad, "mx_avalon_contract_fail_c", 6, 110, 1, 16, 8 );
    activity_instance waittill( #"hash_ac92ba77a44431f8" );
    snd_ob::squad_music_with_boost( squad, "mx_aries_rising_tide_lp", 4, 80, 4, 16, 32 );
    activity_instance waittill( #"void_boss_spawned" );
    snd_ob::squad_music_with_boost( squad, "mx_aries_boss_flower_lp", 4, 105, 2, 24, 24 );
    activity_instance waittill( #"void_docks_boss_dead" );
    snd_ob::squad_music_stop( squad );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 1
// Checksum 0x3c2eee8d, Offset: 0x1e40
// Size: 0x1ce
function function_fb1c50645d49ebac( squad )
{
    activity_instance = self;
    squad = teams::function_72b89edf6b47c40a( self.playerparticipants[ 0 ] );
    
    foreach ( player in squad.players )
    {
        if ( isdefined( player ) )
        {
            player coop::set_player_frozen_vars( 1, "player_teleport_to_taurus_boss" );
        }
    }
    
    wait 1;
    taurus_boss_respawn_structs = utility::getstructarray( "taurus_boss_respawn_struct", "script_noteworthy" );
    coop::function_6b96c51a1cdab478( { #structs:taurus_boss_respawn_structs, #squad:squad } );
    activity_instance notify( #"players_teleported_to_razor_boss_location" );
    wait 1;
    thread player_teleport_vfx();
    
    foreach ( player in squad.players )
    {
        player function_72cf2eee8e035013( "hw_sat_lm_avalon_ob_docks_void_gas" );
        player hud_util::function_a7b5c7ac6074b623( "red_tint", "white", ( 0.375, 0, 0.02 ) );
        player thread hud_util::fade_in( 1.2, "red_tint" );
        playfx( level._effect[ "taurus_cradle_spawn_vfx" ], player.origin, undefined, undefined, player );
    }
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 0
// Checksum 0x249856eb, Offset: 0x2016
// Size: 0x227
function player_teleport_vfx()
{
    activity_instance = self;
    squad = teams::function_72b89edf6b47c40a( activity_instance.playerparticipants[ 0 ] );
    
    foreach ( player in squad.players )
    {
        if ( isdefined( player ) )
        {
            player.var_b8cb492e100f9848 = utility::function_1808878d1c511ce8( player.origin + ( 15, 15, 0 ), player.angles );
            player val::set( "player_teleport_to_taurus_boss", "weapon", 1 );
        }
    }
    
    waitframe();
    wait 1;
    level thread teleport_postfx( squad );
    
    foreach ( player in squad.players )
    {
        if ( isdefined( player ) )
        {
            playfxontag( level._effect[ "taurus_cradle_spawn_vfx" ], player.var_b8cb492e100f9848, "tag_origin" );
        }
    }
    
    wait 0.25;
    
    foreach ( player in squad.players )
    {
        if ( isdefined( player ) )
        {
            player coop::set_player_frozen_vars( 0, "player_teleport_to_taurus_boss" );
            utility::array_delete( [ player.var_b8cb492e100f9848 ] );
        }
    }
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 1
// Checksum 0xfbeb44d0, Offset: 0x2245
// Size: 0xce
function teleport_postfx( squad )
{
    namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "avalon_heavy", 6, undefined, squad.players, undefined, undefined, 0 );
    
    foreach ( player in squad.players )
    {
        if ( isdefined( player ) )
        {
            player.var_4ee87c0e4520c65c = gettime();
        }
    }
    
    thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "medium", 2, undefined, squad.players, undefined, undefined, 0 );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 1
// Checksum 0x3f184533, Offset: 0x231b
// Size: 0x348
function taurus_destroy_supplies_respawn( squad_struct )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    struct = utility::getstruct( "taurus_destroy_supplies_center_struct_1_REF", "targetname" );
    min_dist_squared = squared( 13500 );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( squad_struct.team, squad_struct.sessionsquadid );
    player_arrived = 0;
    
    while ( !player_arrived && var_64bb57aa2d6e8b35.players.size > 0 )
    {
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            if ( isdefined( player ) )
            {
                f_dist_squared = distance2dsquared( struct.origin, player.origin );
                
                if ( f_dist_squared < min_dist_squared )
                {
                    player_arrived = 1;
                    closest_playerparticipant = player;
                    break;
                }
            }
        }
        
        waitframe();
    }
    
    if ( var_64bb57aa2d6e8b35.players.size == 0 )
    {
        return;
    }
    
    var_64bb57aa2d6e8b35 = teams::getsquaddata( squad_struct.team, squad_struct.sessionsquadid );
    taurus_destroy_supplies_ontheway_respawn_struct = utility::getstructarray( "taurus_destroy_supplies_ontheway_respawn_struct", "targetname" );
    var_64bb57aa2d6e8b35 thread story_contract_util::set_squad_respawn( taurus_destroy_supplies_ontheway_respawn_struct, 0.3 );
    min_dist_squared = squared( 5500 );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( squad_struct.team, squad_struct.sessionsquadid );
    player_arrived = 0;
    
    while ( !player_arrived && var_64bb57aa2d6e8b35.players.size > 0 )
    {
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            if ( isdefined( player ) )
            {
                f_dist_squared = distance2dsquared( struct.origin, player.origin );
                
                if ( f_dist_squared < min_dist_squared )
                {
                    player_arrived = 1;
                    closest_playerparticipant = player;
                    break;
                }
            }
        }
        
        waitframe();
    }
    
    if ( var_64bb57aa2d6e8b35.players.size == 0 )
    {
        return;
    }
    
    var_64bb57aa2d6e8b35 = teams::getsquaddata( squad_struct.team, squad_struct.sessionsquadid );
    taurus_destroy_supplies_respawn_struct = utility::getstructarray( "taurus_destroy_supplies_respawn_struct", "targetname" );
    var_64bb57aa2d6e8b35 thread story_contract_util::set_squad_respawn( taurus_destroy_supplies_respawn_struct, 0.4 );
    activity_instance waittill( #"player_teleported_to_void_docks" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( squad_struct.team, squad_struct.sessionsquadid );
    taurus_destroy_supplies_void_docks_respawn_struct = utility::getstructarray( "taurus_destroy_supplies_void_docks_respawn_struct", "targetname" );
    var_64bb57aa2d6e8b35 thread story_contract_util::set_squad_respawn( taurus_destroy_supplies_void_docks_respawn_struct, 0.6 );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 0
// Checksum 0x56c49d30, Offset: 0x266b
// Size: 0x172
function function_92b4d0fd6e59dbb4()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level overlord::playconversation( "taurus_destroy_supplies_briefing", activity_instance.playerparticipants );
    var_8b70d8aedcddc58c = activity_instance.master_struct.origin;
    objective_origin_radius = squared( 10000 );
    player_arrived = 0;
    
    while ( !player_arrived && activity_instance.playerparticipants.size > 0 )
    {
        foreach ( player in activity_instance.playerparticipants )
        {
            if ( isdefined( player ) )
            {
                distancesquared = distance2dsquared( player.origin, var_8b70d8aedcddc58c );
                
                if ( distancesquared <= objective_origin_radius )
                {
                    player_arrived = 1;
                    break;
                }
            }
        }
        
        waitframe();
    }
    
    activity_instance thread on_the_way_to_taurus_destroy_supplies();
    result = utility::waittill_any_ents_return( activity_instance, "on_the_way_to_taurus_destroy_supplies_complete", activity_instance, "player_at_docks" );
    
    if ( result == "on_the_way_to_taurus_destroy_supplies_complete" )
    {
        activity_instance thread taurus_destroy_supplies_nags();
    }
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 0
// Checksum 0xe7647674, Offset: 0x27e5
// Size: 0x5b
function on_the_way_to_taurus_destroy_supplies()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance endon( #"player_at_docks" );
    level overlord::playconversation( "on_the_way_to_taurus_destroy_supplies", activity_instance.playerparticipants );
    activity_instance notify( #"on_the_way_to_taurus_destroy_supplies_complete" );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 0
// Checksum 0x767c2946, Offset: 0x2848
// Size: 0x5b
function taurus_destroy_supplies_kagan_taunt()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance endon( #"player_at_docks" );
    level overlord::playconversation( "taurus_cradle_vents_kagan_taunt_1", activity_instance.playerparticipants );
    activity_instance notify( #"hash_722d5248993bc451" );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 0
// Checksum 0xb3152152, Offset: 0x28ab
// Size: 0x6c
function taurus_destroy_supplies_nags()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance endon( #"player_at_docks" );
    wait 60;
    level overlord::playevent( "taurus_destroy_supplies_nag_1_marshall", activity_instance.playerparticipants );
    wait 60;
    level overlord::playevent( "taurus_destroy_supplies_nag_2_marshall", activity_instance.playerparticipants );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 1
// Checksum 0x3998da4c, Offset: 0x291f
// Size: 0x1b7
function function_a109e784e9b23f56( squad )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    done = 0;
    
    while ( !done )
    {
        done = 1;
        
        foreach ( player in squad.players )
        {
            if ( isdefined( player ) && player utility::ent_flag( "scene_active" ) )
            {
                done = 0;
                break;
            }
        }
        
        waitframe();
    }
    
    teleport_structs = utility::getstructarray( "void_teleport_structs_01", "targetname" );
    coop::function_6b96c51a1cdab478( { #structs:teleport_structs, #squad:squad } );
    
    foreach ( player in squad.players )
    {
        if ( isdefined( player ) )
        {
            player function_a565dafac620d68e( "hw_sat_lm_avalon_ob_docks_void_gas" );
            player utility::ent_flag_set( "player_teleported_to_void_docks" );
            player setclienttriggeraudiozone( "mp_sat_ob_avalon_taurus_void_dock", 2 );
        }
    }
    
    activity_instance notify( #"player_teleported_to_void_docks" );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 0
// Checksum 0xef40a6cc, Offset: 0x2ade
// Size: 0x117
function taurus_destroy_supplies_void_vo()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    wait 1;
    level thread overlord::playconversation( "taurus_destroy_supplies_void_intro", activity_instance.playerparticipants, undefined, 1 );
    activity_instance waittill( #"hash_2a6164fbc6180d9" );
    wait 3;
    level thread overlord::playconversation( "taurus_destroy_supplies_void_zombies", activity_instance.playerparticipants );
    result = utility::waittill_any_ents_or_timeout_return( 20, activity_instance, "void_boss_spawned" );
    
    if ( isdefined( result ) && result != "void_boss_spawned" )
    {
        level thread overlord::playevent( "taurus_destroy_supplies_void_zombie_nag_samuels", activity_instance.playerparticipants );
        result = utility::waittill_any_ents_or_timeout_return( 20, activity_instance, "void_boss_spawned" );
        
        if ( isdefined( result ) && result != "void_boss_spawned" )
        {
            level thread overlord::playevent( "taurus_destroy_supplies_void_zombie_nag_5050", activity_instance.playerparticipants );
            activity_instance waittill( #"void_boss_spawned" );
        }
    }
    
    wait 2;
    level thread overlord::playconversation( "taurus_destroy_supplies_void_zombie_boss", activity_instance.playerparticipants );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 2
// Checksum 0x6a25ba5e, Offset: 0x2bfd
// Size: 0x4c
function cleanup_squad_struct( sessionsquadid, squad_struct )
{
    activity_instance = self;
    activity_instance endon( #"hash_1b6b9613636daa6a" );
    squad_struct waittill( #"cleanup_squad" );
    wait 1;
    level.taurus_destroy_supplies_squads[ sessionsquadid ] = undefined;
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 1
// Checksum 0xc9642ec6, Offset: 0x2c51
// Size: 0x5d
function function_b62d81be9963de4( squad_struct )
{
    activity_instance = self;
    activity_instance endon( #"hash_1b6b9613636daa6a" );
    squad_struct endon( #"death" );
    
    while ( squad_struct.ttl_hacked < self.master_scriptables.size )
    {
        waitframe();
    }
    
    squad_struct notify( #"hack_set_complete" );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 2
// Checksum 0xf40d8569, Offset: 0x2cb6
// Size: 0xd5
function function_4889800b6025fa23( player, squad_struct )
{
    activity_instance = self;
    player endon( #"disconnect" );
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    while ( !activity_instance.master_scriptables.size )
    {
        waitframe();
    }
    
    foreach ( scriptable in activity_instance.master_scriptables )
    {
        scriptable enablescriptableplayeruse( player );
    }
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 1
// Checksum 0x9195691d, Offset: 0x2d93
// Size: 0x8f
function function_4a88b972a328643d( activity_instance )
{
    self endon( #"disconnect" );
    activity_instance endon( #"instance_destroyed" );
    self waittill( #"hash_1b6b9613636daa6a" );
    
    if ( isdefined( activity_instance.var_f7af54e3a4e17c28.mapcircle ) )
    {
        activity_instance.var_f7af54e3a4e17c28 game_utility::questcircle_delete();
    }
    
    if ( isdefined( activity_instance.var_f7af54e3a4e17c28 ) )
    {
        activity_instance.var_f7af54e3a4e17c28 delete();
        activity_instance.var_f7af54e3a4e17c28 = undefined;
    }
    
    thread on_player_connect_squad( {} );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 0
// Checksum 0x67d5cc3d, Offset: 0x2e2a
// Size: 0x8a
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_TAURUS_DESTROY_SUPPLIES", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_TAURUS_DESTROY_SUPPLIES", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "REV_OB_TAURUS_DESTROY_SUPPLIES", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "REV_OB_TAURUS_DESTROY_SUPPLIES", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "REV_OB_TAURUS_DESTROY_SUPPLIES" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &player_left_activity, "REV_OB_TAURUS_DESTROY_SUPPLIES" );
    scriptable::scriptable_addusedcallbackbypart( "cradle_shipment_crate", &function_c13bd7c5f3e5dbcd );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 0
// Checksum 0xf9e13e29, Offset: 0x2ebc
// Size: 0x254
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( !isdefined( level.taurus_destroy_supplies_activities ) )
    {
        level.taurus_destroy_supplies_activities = [];
    }
    
    index = int( function_41bec0232e24ee41( activity_instance.varianttag, "REV_OB_TAURUS_DESTROY_SUPPLIES_" ) ) - 1;
    
    if ( index != 0 )
    {
        return;
    }
    
    level.taurus_destroy_supplies_activity = activity_instance;
    level.taurus_destroy_supplies_activities[ index ] = activity_instance;
    
    if ( !isdefined( level.taurus_destroy_supplies_structs ) )
    {
        level.taurus_destroy_supplies_structs = [];
    }
    
    if ( !isdefined( level.taurus_destroy_supplies_structs[ activity_instance.varianttag ] ) )
    {
        master_struct = utility::getstruct( activity_instance.varianttag, "targetname" );
        level.taurus_destroy_supplies_structs[ activity_instance.varianttag ] = master_struct;
    }
    else
    {
        master_struct = level.taurus_destroy_supplies_structs[ activity_instance.varianttag ];
    }
    
    self.master_struct = master_struct;
    
    if ( !isdefined( self.master_struct.master_struct_targets ) )
    {
        self.master_struct.master_struct_targets = utility::getstructarray( self.master_struct.target, "targetname" );
    }
    
    self.var_271b79911658d573 = [];
    
    foreach ( target in self.master_struct.master_struct_targets )
    {
        if ( isdefined( target.script_noteworthy ) && issubstr( target.script_noteworthy, "crate" ) )
        {
            self.var_271b79911658d573[ self.var_271b79911658d573.size ] = target;
        }
    }
    
    self.master_struct.var_271b79911658d573 = self.var_271b79911658d573;
    self.exploded_site = 0;
    self.var_31026d7ca0ad6e7c = [];
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 0
// Checksum 0x2b4524dc, Offset: 0x3118
// Size: 0x13d
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level utility::flag_clear( "void_docks_boss_dead" );
    self.master_scriptables = [];
    activity_instance thread function_93aab41b233a680a();
    
    foreach ( bomb_site in activity_instance.var_271b79911658d573 )
    {
        supply_site = activity_instance bomb_site_spawn( bomb_site, activity_instance.master_struct );
        activity_instance.var_31026d7ca0ad6e7c[ activity_instance.var_31026d7ca0ad6e7c.size ] = supply_site;
    }
    
    activity_instance.master_scriptables = activity_instance.var_31026d7ca0ad6e7c;
    
    if ( !self.master_struct.var_ee2e49a6a3e62fdd )
    {
        activity_instance thread function_868851713ec9050();
    }
    
    activity_instance thread function_bd7489fc5732f3b5( activity_instance.var_31026d7ca0ad6e7c );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 0
// Checksum 0xed5bd9cc, Offset: 0x325d
// Size: 0x5c
function function_868851713ec9050()
{
    objective_name = self.varianttag;
    function_1c4c7ef874191be2( objective_name, self.master_struct.origin, self.master_struct.radius, 1 );
    self.master_struct.var_ee2e49a6a3e62fdd = 1;
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 2
// Checksum 0x7248d8cd, Offset: 0x32c1
// Size: 0xcc
function bomb_site_spawn( spawn_struct, master_struct )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    supply_site = spawnscriptable( "sat_storage_lift_bot_crate", spawn_struct.origin, spawn_struct.angles );
    supply_site function_7653c765b6c7b815();
    supply_site.activity_instance = activity_instance;
    supply_site childthread function_868f37fc74733f44();
    supply_site childthread function_64c61f006d8f1e50();
    supply_site setscriptablepartstate( #"audio_loop", #"on" );
    supply_site.script_label = spawn_struct.script_label;
    supply_site.master_struct = master_struct;
    return supply_site;
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 1
// Checksum 0xde26b966, Offset: 0x3396
// Size: 0x126
function function_bd7489fc5732f3b5( array )
{
    activity_instance = self;
    activity_instance endon( #"all_crates_exploded" );
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance waittill( #"taurus_crate_timer_finished" );
    activity_instance thread function_179de6767e7927ae();
    
    foreach ( supply_site in activity_instance.var_31026d7ca0ad6e7c )
    {
        time = randomfloatrange( 0.2, 1 );
        wait time;
        supply_site setscriptablepartstate( "cradle_shipment_crate", "unusable_destroyed" );
        activity_instance thread function_561a6103401f3432( supply_site.origin, 1000 );
        activity_instance notify( #"cradle_shipment_crate_exploded", supply_site );
    }
    
    activity_instance notify( #"hash_c0e3c1963606ea48" );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 0
// Checksum 0x60e39e86, Offset: 0x34c4
// Size: 0x11c
function function_179de6767e7927ae()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    wait 1;
    extra_crates = utility::getstructarray( "extra_crate_structs", "targetname" );
    extra_crates = utility::getstructarray( "extra_crate_structs", "targetname" );
    
    for ( i = 1; i <= 16 ; i++ )
    {
        groupname = "crate_group_" + i;
        
        if ( i == 10 )
        {
            activity_instance notify( #"all_crates_exploded" );
        }
        
        foreach ( player in activity_instance.playerparticipants )
        {
            player thread do_crate_vfx( extra_crates, groupname, activity_instance );
        }
        
        wait 0.75;
    }
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 3
// Checksum 0x8708ae35, Offset: 0x35e8
// Size: 0x162
function do_crate_vfx( extra_crates, groupname, activity_instance )
{
    player = self;
    
    foreach ( crate in extra_crates )
    {
        if ( crate.script_noteworthy == groupname )
        {
            playfx( level._effect[ "dock_crate_vfx" ], crate.origin, undefined, undefined, player );
            playfx( level._effect[ "dock_crate_vfx_01" ], crate.origin, undefined, undefined, player );
            playfx( level._effect[ "dock_crate_vfx_02" ], crate.origin, undefined, undefined, player );
            playsoundatpos( crate.origin, "exp_cradle_crate" );
            player playrumbleonentity( "heavy_1s" );
            player earthquakeforplayer( 0.2, 0.5, player.origin, 128 );
            activity_instance thread function_561a6103401f3432( crate.origin, 1000 );
        }
    }
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 0
// Checksum 0x62b0acee, Offset: 0x3752
// Size: 0xf9
function function_93aab41b233a680a()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance waittill( #"hash_d7c8f968d6dfb41d" );
    waitframe();
    activity_instance waittill( #"hash_d7c8f968d6dfb41d" );
    activity_instance thread function_a9b44fcabad9502e();
    wait 6;
    activity_instance thread taurus_destroy_supplies_kagan_vo();
    
    if ( activity_instance.var_37635e42a1674411 )
    {
        activity_instance.var_2e8b30484f3031a0 = 1;
        activity_instance.var_37635e42a1674411 = 0;
    }
    
    activity_instance activity_progress_tracking::function_61568a80767f1652( "TAURUS_CRATE_TIMER", 20 );
    activity_instance thread function_c68934b2c39b0be( 20 );
    activity_instance thread escape_timer_sfx();
    activity_instance utility::waittill_notify_or_timeout( "blow_crates_now", 20 );
    activity_instance notify( #"taurus_crate_timer_finished" );
    activity_instance waittill( #"all_crates_exploded" );
    activity_instance.var_7aae92e3d932c3bd = 1;
    level thread overlord::playevent( "taurus_destroy_supplies_crate_explosion_reaction_harper", activity_instance.playerparticipants );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 0
// Checksum 0x9cb4aaf9, Offset: 0x3853
// Size: 0x5d
function function_a9b44fcabad9502e()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.var_7aae92e3d932c3bd = 1;
    level overlord::playconversation( "taurus_destroy_supplies_kagan_timer_starts", activity_instance.playerparticipants, undefined, 1 );
    activity_instance.var_7aae92e3d932c3bd = undefined;
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 0
// Checksum 0xbdf8c1f1, Offset: 0x38b8
// Size: 0x46
function taurus_destroy_supplies_kagan_vo()
{
    activity_instance = self;
    wait 17;
    activity_instance.var_7aae92e3d932c3bd = 1;
    level overlord::playconversation( "taurus_destroy_supplies_kagan_times_up", activity_instance.playerparticipants, undefined, 1 );
    activity_instance.var_7aae92e3d932c3bd = undefined;
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 1, eflags: 0x4
// Checksum 0xa42d6b6e, Offset: 0x3906
// Size: 0x2a
function private function_c68934b2c39b0be( var_77be3669189a4fe3 )
{
    ob_contract_ui_widget::function_2ee97780d0898a9b( var_77be3669189a4fe3 );
    self waittill( #"blow_crates_now" );
    ob_contract_ui_widget::function_2ee97780d0898a9b( 0 );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 0, eflags: 0x4
// Checksum 0x9bf9d8a2, Offset: 0x3938
// Size: 0x7b
function private escape_timer_sfx()
{
    foreach ( player in self.playerparticipants )
    {
        player thread _escape_timer_sfx();
    }
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 0, eflags: 0x4
// Checksum 0x93f9fcf5, Offset: 0x39bb
// Size: 0x92
function private _escape_timer_sfx()
{
    level endon( #"flag_escape_done", #"countdown_end", #"taurus_crate_timer_finished" );
    self endon( #"disconnect" );
    time = 20;
    timeralias = "uin_taurus_destroy_supplies_timer";
    var_df045f2d71c5b3ac = "uin_taurus_destroy_supplies_timer_urgent";
    
    while ( true )
    {
        if ( time >= 6 )
        {
            self playsoundtoplayer( timeralias, self );
        }
        else if ( time >= 1 )
        {
            self playsoundtoplayer( var_df045f2d71c5b3ac, self );
        }
        
        time -= 1;
        wait 1;
    }
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 0
// Checksum 0x4925ceaf, Offset: 0x3a55
// Size: 0x101
function function_868f37fc74733f44()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"bomb_planted", planter );
        squad_struct = level.taurus_destroy_supplies_squads[ planter.sessionsquadid ];
        assert( isdefined( squad_struct ), "<dev string:x54>" );
        squad_struct.activity_instance notify( #"hash_d7c8f968d6dfb41d" );
        squadmembers = planter squad_utility::getsquadmembers();
        
        foreach ( player in squadmembers )
        {
            self disablescriptableplayeruse( player );
        }
        
        thread handle_hack( planter, self, squad_struct );
    }
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 0
// Checksum 0x2a6c1f39, Offset: 0x3b5e
// Size: 0x197
function function_64c61f006d8f1e50()
{
    self endon( #"death" );
    self waittill( #"hash_2b1c62830571925e", planter );
    squad_struct = level.taurus_destroy_supplies_squads[ planter.sessionsquadid ];
    assert( isdefined( squad_struct ), "<dev string:x54>" );
    
    if ( !isdefined( squad_struct.cradle_crate_disabled ) )
    {
        squad_struct.cradle_crate_disabled = 0;
    }
    
    squad_struct.cradle_crate_disabled++;
    
    if ( squad_struct.cradle_crate_disabled >= 1 )
    {
        if ( !isdefined( squad_struct.var_3d0ff4b8c5f91006 ) )
        {
            squad_struct.var_3d0ff4b8c5f91006 = 1;
            
            if ( !isdefined( squad_struct.activity_instance.var_7aae92e3d932c3bd ) )
            {
                level thread overlord::playevent( "taurus_destroy_supplies_cradle_shipment_destroyed_taacom", function_9cdbaea6c78ac37b( squad_struct ) );
            }
        }
    }
    
    if ( squad_struct.cradle_crate_disabled >= 2 )
    {
        if ( !isdefined( squad_struct.var_3d0ff3b8c5f90dd3 ) )
        {
            squad_struct.var_3d0ff3b8c5f90dd3 = 1;
            
            if ( !isdefined( squad_struct.activity_instance.var_7aae92e3d932c3bd ) )
            {
                level thread overlord::playevent( "taurus_destroy_supplies_cradle_crate_destroyed_harper", function_9cdbaea6c78ac37b( squad_struct ) );
            }
        }
    }
    
    if ( squad_struct.cradle_crate_disabled >= 3 )
    {
        if ( !isdefined( squad_struct.var_3d0ff2b8c5f90ba0 ) )
        {
            squad_struct.var_3d0ff2b8c5f90ba0 = 1;
            
            if ( !isdefined( squad_struct.activity_instance.var_7aae92e3d932c3bd ) )
            {
                level thread overlord::playevent( "taurus_destroy_supplies_cradle_crate_destroyed_samuels", function_9cdbaea6c78ac37b( squad_struct ) );
            }
        }
    }
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 3
// Checksum 0xc0c40359, Offset: 0x3cfd
// Size: 0x9c
function handle_hack( hacker, scriptable, squad_struct )
{
    self endon( #"death" );
    var_538c0694c880e740 = hacker squad_utility::getsquadmembers();
    squad_struct.planter_array[ squad_struct.planter_array.size ] = hacker;
    squad_struct.ttl_hacked++;
    
    if ( squad_struct.ttl_hacked == 4 )
    {
        squad_struct.activity_instance notify( #"blow_crates_now" );
    }
    
    squad_struct notify( #"squad_hacked", hacker, self );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 6
// Checksum 0xa0f8a486, Offset: 0x3da1
// Size: 0x91
function function_c13bd7c5f3e5dbcd( instance, part, state, player, bautouse, usestring )
{
    if ( player.ismutantinjection || player.carryinghostage || player.inlaststand || player.isjuggernaut )
    {
        player hud_message::showerrormessage( %"MP/CANNOT_USE_GENERIC" );
        return;
    }
    
    instance thread function_fb9c1eaeb2412dc6( player );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 1, eflags: 0x4
// Checksum 0x64b1bdb8, Offset: 0x3e3a
// Size: 0x17d
function private function_fb9c1eaeb2412dc6( player )
{
    instance = self;
    
    if ( player.ismutantinjection || player.carryinghostage || player.inlaststand || player.isjuggernaut )
    {
        player hud_message::showerrormessage( %"MP/CANNOT_USE_GENERIC" );
        return;
    }
    
    squad = player squad_utility::getsquadmembers( player.team, 0 );
    
    foreach ( member in squad )
    {
        instance disablescriptableplayeruse( player );
    }
    
    instance setscriptablepartstate( #"cradle_shipment_crate", #"unusable_planting" );
    instance scene::play( [ player ], undefined, "scene_sat_cin_taurus_cradle_container_player" );
    
    if ( isdefined( instance ) )
    {
        instance notify( #"hash_2b1c62830571925e", player );
        utility::wait_frames( 90 );
    }
    
    if ( isdefined( instance ) )
    {
        instance setscriptablepartstate( #"cradle_shipment_crate", #"usable_planted" );
        instance.bomb_plated = 1;
        instance notify( #"bomb_planted", player );
    }
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 1
// Checksum 0xeed35d3a, Offset: 0x3fbf
// Size: 0x5c
function function_9cdbaea6c78ac37b( squad_struct )
{
    var_64bb57aa2d6e8b35 = teams::getsquaddata( squad_struct.team, squad_struct.sessionsquadid );
    
    if ( !var_64bb57aa2d6e8b35.players.size )
    {
        squad_struct notify( #"squad_empty" );
    }
    
    return var_64bb57aa2d6e8b35.players;
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 2
// Checksum 0x6782a391, Offset: 0x4024
// Size: 0xc7
function function_d75b51975c8b5879( squad_struct, activity_instance )
{
    level.var_b9513d3615bad76 = [];
    self.encounterid = activity_ai_encounters::function_92b671064b0b1ce2( self.target, 1, 0, 1, 2 );
    
    if ( isdefined( self.encounterid ) )
    {
        if ( activity_instance.playerparticipants.size <= 2 )
        {
            function_1a9d724a960fa19d( self.encounterid, "difficulty_easy", 1 );
        }
        
        if ( activity_instance.playerparticipants.size >= 3 )
        {
            function_1a9d724a960fa19d( self.encounterid, "difficulty_hard", 1 );
        }
        
        activity_instance activity_ai_encounters::function_6bf4ff2fbde584ee( self.encounterid, &function_20ed6a04d3372596, activity_instance );
        ai_spawn_director::add_spawned_callback( self.encounterid, &function_2d353ab3485fbd7 );
    }
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 4
// Checksum 0x8e28be14, Offset: 0x40f3
// Size: 0x3e
function function_2d353ab3485fbd7( requestid, instance, agent, ai_data )
{
    level.var_b9513d3615bad76[ level.var_b9513d3615bad76.size ] = agent;
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 3
// Checksum 0x25ee2f8b, Offset: 0x4139
// Size: 0x9b
function function_20ed6a04d3372596( requestid, activity_instance, agent )
{
    utility::ent_flag_set( "docks_spawned" );
    
    foreach ( agent in level.var_b9513d3615bad76 )
    {
        if ( isalive( agent ) )
        {
        }
    }
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 2
// Checksum 0x94c30a1e, Offset: 0x41dc
// Size: 0x14a
function function_561a6103401f3432( position, radius )
{
    level endon( #"player_teleported_to_void_docks" );
    agents = getaiarrayinradius( position, radius );
    agents = utility::array_removedead_or_dying( agents, 1 );
    
    foreach ( agent in agents )
    {
        if ( isalive( agent ) )
        {
            if ( agent.type == "human" && !issubstr( agent.classname, "bot" ) )
            {
                agent._blackboard.shockedendtime = gettime() + 30000;
                agent._blackboard.var_ba9517cfc0287af8 = gettime();
                
                if ( agent.allowpain && agent asmhaspainstate( agent.asmname ) )
                {
                    agent asmevalpaintransition( agent.asmname );
                }
            }
        }
    }
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 1
// Checksum 0xcf878a33, Offset: 0x432e
// Size: 0x36
function taurus_destroy_supplies_cradle_shipments_identified( squad_struct )
{
    level overlord::playevent( "taurus_destroy_supplies_cradle_shipments_identified_taacom", function_9cdbaea6c78ac37b( squad_struct ) );
    level thread overlord::playconversation( "taurus_destroy_supplies_cradle_shipments_identified", function_9cdbaea6c78ac37b( squad_struct ) );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 1
// Checksum 0x3e0bfb0a, Offset: 0x436c
// Size: 0x76
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    
    if ( isdefined( activity_instance.master_struct.encounterid ) )
    {
        ai_spawn_director::cancel_spawn_request( activity_instance.master_struct.encounterid, 1 );
    }
    
    activity_instance thread respawn_on_destroyed( "REV_OB_TAURUS_DESTROY_SUPPLIES", activity_instance.varianttag );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 2
// Checksum 0x59086756, Offset: 0x43ea
// Size: 0x7a
function respawn_on_destroyed( activity, variant )
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_info = level.var_e607236b193eb0c1.var_5992a4946aeeca5a[ activity_instance.varianttag ];
    activity_instance waittill( #"instance_destroyed" );
    level.taurus_destroy_supplies_squads = [];
    level ob_activity_manager::ob_activity_instance_init( activity_info, undefined );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 0
// Checksum 0xaf3b76b, Offset: 0x446c
// Size: 0xe8
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    
    foreach ( scriptable in activity_instance.var_31026d7ca0ad6e7c )
    {
        scriptable freescriptable();
    }
    
    if ( isdefined( activity_instance.var_f7af54e3a4e17c28.mapcircle ) )
    {
        activity_instance.var_f7af54e3a4e17c28 game_utility::questcircle_delete();
    }
    
    if ( isdefined( activity_instance.var_f7af54e3a4e17c28 ) )
    {
        activity_instance.var_f7af54e3a4e17c28 delete();
        activity_instance.var_f7af54e3a4e17c28 = undefined;
    }
    
    activity_instance endon( #"instance_destroyed" );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 0
// Checksum 0x7469bd6b, Offset: 0x455c
// Size: 0xf
function get_activity_center_point()
{
    return ( 0, 0, 0 );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 1
// Checksum 0x11f1269f, Offset: 0x4574
// Size: 0x4e
function function_470b4f0cecef4cf4( relevantinfostruct )
{
    var_983974fc347bb3cb = spawnstruct();
    var_983974fc347bb3cb.origin = ( 0, 0, 0 );
    var_983974fc347bb3cb.angles = ( 0, 0, 0 );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 1
// Checksum 0x2479683, Offset: 0x45ca
// Size: 0x38
function player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 1
// Checksum 0x79c7b323, Offset: 0x460a
// Size: 0x77
function player_left_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    
    if ( !activity_instance.playerparticipants.size && activity_instance_common::getactivitystate( activity_instance ) == "Active" && !activity_instance.var_b4098616f1f61f0d )
    {
        activity_instance notify( #"cleanup_objmarkers" );
        activity_instance_common::endactivity( activity_instance, 0 );
    }
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 2
// Checksum 0x51246ab2, Offset: 0x4689
// Size: 0xe7
function taurus_destroy_supplies_objectives( squad_struct, master_struct )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    wait 0.5;
    var_538c0694c880e740 = function_9cdbaea6c78ac37b( squad_struct );
    ob_story_mission_utils::function_b3e9457491e7af72( "REV_OB_TAURUS_DESTROY_SUPPLIES", var_538c0694c880e740 );
    ob_contract_ui_widget::setprogress( 0, master_struct.var_271b79911658d573.size, var_538c0694c880e740 );
    thread function_e78f55fbc349663d( master_struct, squad_struct );
    thread function_25d54e3c0c61adb7( master_struct, squad_struct );
    activity_instance waittill( #"player_teleported_to_void_docks" );
    ob_story_mission_utils::objective_text_clear();
    activity_instance waittill( #"hash_2a6164fbc6180d9" );
    wait 4;
    ob_story_mission_utils::function_b3e9457491e7af72( %"hash_270361130c6d1e91", var_538c0694c880e740 );
    activity_instance utility::ent_flag_wait( "spawn_docks_boss" );
    wait 1;
    ob_story_mission_utils::function_b3e9457491e7af72( %"hash_6c9fe81653d21b53", var_538c0694c880e740 );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 2
// Checksum 0x283950a0, Offset: 0x4778
// Size: 0xfa
function function_e78f55fbc349663d( master_struct, squad_struct )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    squad_struct.var_a9cd04d153081846 = 0;
    var_538c0694c880e740 = function_9cdbaea6c78ac37b( squad_struct );
    
    while ( true )
    {
        if ( squad_struct.var_a9cd04d153081846 != squad_struct.ttl_hacked )
        {
            ob_contract_ui_widget::setprogress( squad_struct.ttl_hacked, master_struct.var_271b79911658d573.size, function_9cdbaea6c78ac37b( squad_struct ) );
            squad_struct.var_a9cd04d153081846 = squad_struct.ttl_hacked;
        }
        
        if ( squad_struct.ttl_hacked == master_struct.var_31026d7ca0ad6e7c.size )
        {
            break;
        }
        
        wait 0.2;
    }
    
    squad_struct ob_story_mission_utils::mission_objective_marker_clear( squad_struct.objective_id, function_9cdbaea6c78ac37b( squad_struct ) );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 1
// Checksum 0x9acd4cf8, Offset: 0x487a
// Size: 0x9d
function function_52f82aa6e7e1b385( squad_struct )
{
    squad = function_9cdbaea6c78ac37b( squad_struct );
    
    foreach ( player in squad )
    {
        thread function_b6db7c3f7d919a43( player );
    }
    
    self waittill( #"taurus_destroy_supplies_obj_done" );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 1
// Checksum 0x35feb6fe, Offset: 0x491f
// Size: 0x33
function function_b6db7c3f7d919a43( player )
{
    player endon( #"disconnect" );
    player waittill( #"taurus_destroy_supplies_obj_done_player" );
    self notify( #"taurus_destroy_supplies_obj_done" );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 2
// Checksum 0x2d2fb31, Offset: 0x495a
// Size: 0x557
function function_25d54e3c0c61adb7( master_struct, squad_struct )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"taurus_crate_timer_finished" );
    squad_struct endon( #"hack_set_complete" );
    activity_instance = self;
    squad_struct.squad = squad_struct.sessionsquadid;
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "taurus_destroy_supplies_obj", "sat_ob_objectivemarker_location", "taurus_destroy_supplies_obj_done", "taurus_destroy_supplies_obj_done_player", squad_struct, 0, 0, 0, 1 );
    thread function_c96c9261e14ac930( squad_struct );
    function_52f82aa6e7e1b385( squad_struct );
    taurus_destroy_supplies_obj = utility::getstruct( "taurus_destroy_supplies_obj", "targetname" );
    squad_struct.objective_id = squad_struct ob_story_mission_utils::function_c5f68c5406e92c4d( taurus_destroy_supplies_obj.origin, function_9cdbaea6c78ac37b( squad_struct ) );
    var_8b70d8aedcddc58c = master_struct.origin;
    objective_origin_radius = master_struct.radius;
    squad_struct.var_27aea23e3ccb03e8 = undefined;
    var_d2e0a824df9e46ca = function_9cdbaea6c78ac37b( squad_struct );
    var_6e150a0ca769be38 = [];
    scriptable_array = self.master_scriptables;
    
    while ( true )
    {
        wait 1;
        squad = function_9cdbaea6c78ac37b( squad_struct );
        
        if ( !squad.size )
        {
            break;
        }
        
        foreach ( player in squad )
        {
            if ( isdefined( player.origin ) && isalive( player ) )
            {
                distancesquared = distance2dsquared( player.origin, var_8b70d8aedcddc58c );
                
                if ( distancesquared <= squared( objective_origin_radius ) )
                {
                    if ( arraycontains( var_d2e0a824df9e46ca, player ) || self.var_2e8b30484f3031a0 )
                    {
                        if ( arraycontains( var_d2e0a824df9e46ca, player ) )
                        {
                            squad_struct ob_story_mission_utils::mission_objective_marker_hide( squad_struct.objective_id, [ player ] );
                            var_d2e0a824df9e46ca = arrayremove( var_d2e0a824df9e46ca, player );
                            var_6e150a0ca769be38 = arraycombineunique( var_6e150a0ca769be38, [ player ] );
                        }
                        
                        if ( !isdefined( squad_struct.var_27aea23e3ccb03e8 ) )
                        {
                            foreach ( supply_site in scriptable_array )
                            {
                                supply_site_obj_origin = supply_site.origin + anglestoforward( supply_site.angles ) * -24 + ( 0, 0, 44 );
                                var_9af362a915d8f7d4 = 16;
                                
                                if ( self.var_37635e42a1674411 && !supply_site.is_primary_site )
                                {
                                    supply_site.supplyobjid = squad_struct ob_story_mission_utils::function_b9cb179f9577f32a( supply_site_obj_origin, var_9af362a915d8f7d4, [], "sat_ob_objectivemarker_storymissionmain" );
                                    supply_site disablescriptableplayeruse( player );
                                }
                                else
                                {
                                    supply_site.supplyobjid = squad_struct ob_story_mission_utils::function_b9cb179f9577f32a( supply_site_obj_origin, var_9af362a915d8f7d4, [ player ], "sat_ob_objectivemarker_storymissionmain" );
                                    supply_site enablescriptableplayeruse( player );
                                }
                                
                                squad_struct.var_27aea23e3ccb03e8 = 1;
                                supply_site thread function_1b85bcfa4276bedb( squad_struct, self );
                            }
                        }
                        else
                        {
                            foreach ( supply_site in scriptable_array )
                            {
                                if ( !supply_site.bomb_plated )
                                {
                                    if ( !self.var_37635e42a1674411 || supply_site.is_primary_site )
                                    {
                                        squad_struct ob_story_mission_utils::objective_marker_show( supply_site.supplyobjid, [ player ] );
                                        supply_site enablescriptableplayeruse( player );
                                        continue;
                                    }
                                    
                                    supply_site disablescriptableplayeruse( player );
                                }
                            }
                        }
                        
                        if ( !isdefined( self.var_b099b75039dab5bb ) )
                        {
                            activity_instance notify( #"player_at_docks" );
                            self.var_b099b75039dab5bb = 1;
                            thread taurus_destroy_supplies_cradle_shipments_identified( squad_struct );
                        }
                        
                        continue;
                    }
                    
                    var_d2e0a824df9e46ca[ var_d2e0a824df9e46ca.size ] = player;
                    
                    foreach ( supply_site in scriptable_array )
                    {
                        if ( !supply_site.bomb_plated )
                        {
                            if ( !self.var_37635e42a1674411 || supply_site.is_primary_site )
                            {
                                squad_struct ob_story_mission_utils::objective_marker_show( supply_site.supplyobjid, [ player ] );
                            }
                            
                            continue;
                        }
                        
                        supply_site disablescriptableplayeruse( player );
                    }
                }
            }
        }
        
        self.var_2e8b30484f3031a0 = 0;
    }
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 1
// Checksum 0xe9cba7fa, Offset: 0x4eb9
// Size: 0x17a
function function_c96c9261e14ac930( squad_struct )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    var_8b70d8aedcddc58c = activity_instance.master_struct.origin;
    objective_origin_radius = squared( 4000 );
    player_arrived = 0;
    
    while ( !player_arrived && activity_instance.playerparticipants.size > 0 )
    {
        foreach ( player in activity_instance.playerparticipants )
        {
            if ( isdefined( player ) )
            {
                distancesquared = distance2dsquared( player.origin, var_8b70d8aedcddc58c );
                
                if ( distancesquared <= objective_origin_radius )
                {
                    player_arrived = 1;
                    break;
                }
            }
        }
        
        waitframe();
    }
    
    var_64bb57aa2d6e8b35 = teams::getsquaddata( squad_struct.team, squad_struct.sessionsquadid );
    
    if ( var_64bb57aa2d6e8b35 )
    {
        ob_story_mission_utils::function_eee81c6c2c7fdb3( var_64bb57aa2d6e8b35 );
        level thread overlord::playevent( "tacb_wchealthupgrade", var_64bb57aa2d6e8b35.players, 0.75 );
    }
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 2
// Checksum 0xc2f4c769, Offset: 0x503b
// Size: 0x49
function function_1b85bcfa4276bedb( squad_struct, activity_instance )
{
    utility::waittill_any_ents( self, "bomb_planted", activity_instance, "all_crates_exploded", activity_instance, "cleanup_objmarkers", activity_instance, "taurus_crate_timer_finished" );
    squad_struct ob_story_mission_utils::mission_objective_marker_clear( self.supplyobjid );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 1
// Checksum 0x25321aaf, Offset: 0x508c
// Size: 0x1e0
function void_docks_enc( squad )
{
    level endon( #"void_docks_boss_dead" );
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    encounter_targetname = "void_docks_encounter_vol";
    activity_instance thread ob_story_mission_utils::function_b0bc4cf3be6ad752( "void_docks_fall_trigger" );
    activity_instance thread setup_br_wall();
    activity_instance thread function_32247da5db1abd1();
    activity_instance waittill( #"hash_2a6164fbc6180d9" );
    level.var_3a6122e97f6eefa0 = [];
    activity_instance.void_docks = activity_ai_encounters::function_92b671064b0b1ce2( encounter_targetname, 1, 0, 1, 1 );
    waitframe();
    
    if ( activity_instance.playerparticipants.size <= 2 )
    {
        function_1a9d724a960fa19d( activity_instance.void_docks, "squad_size_small", 1 );
    }
    
    if ( activity_instance.playerparticipants.size >= 3 )
    {
        function_1a9d724a960fa19d( activity_instance.void_docks, "squad_size_large", 1 );
    }
    
    if ( isdefined( activity_instance.void_docks ) )
    {
        function_ef57f478f96b050c( activity_instance.void_docks, 1 );
        activity_instance activity_ai_encounters::function_6bf4ff2fbde584ee( activity_instance.void_docks, &function_b7d70b2707f190ef, activity_instance );
        ai_spawn_director::add_spawned_callback( activity_instance.void_docks, &void_docks_spawn_func );
        activity_instance utility::ent_flag_wait( "flag_void_docks_enemies_spawned" );
        
        while ( !activity_instance utility::ent_flag( "spawn_docks_boss" ) )
        {
            level.var_3a6122e97f6eefa0 = utility::array_removedead_or_dying( level.var_3a6122e97f6eefa0, 1 );
            activity_instance thread find_player_func( level.var_3a6122e97f6eefa0 );
            
            if ( activity_instance utility::ent_flag( "void_docks_final_wave_spawned" ) )
            {
                if ( level.var_3a6122e97f6eefa0.size <= 8 )
                {
                    activity_instance utility::ent_flag_set( "spawn_docks_boss" );
                }
            }
            
            wait 0.5;
        }
    }
    
    activity_instance utility::ent_flag_wait( "spawn_docks_boss" );
    activity_instance thread handle_boss_encounter();
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 4
// Checksum 0x905da985, Offset: 0x5274
// Size: 0x3e
function void_docks_spawn_func( requestid, instance, agent, ai_data )
{
    level.var_3a6122e97f6eefa0[ level.var_3a6122e97f6eefa0.size ] = agent;
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 3
// Checksum 0x244d1884, Offset: 0x52ba
// Size: 0x2af
function function_b7d70b2707f190ef( requestid, activity_instance, agent )
{
    if ( isdefined( activity_instance.var_3a04ef2068c13fc9 ) )
    {
        activity_instance.var_3a04ef2068c13fc9 += 1;
    }
    
    if ( !isdefined( activity_instance.var_3a04ef2068c13fc9 ) )
    {
        activity_instance.var_3a04ef2068c13fc9 = 0;
    }
    
    if ( activity_instance.var_3a04ef2068c13fc9 == 1 )
    {
        foreach ( agent in level.var_3a6122e97f6eefa0 )
        {
            difficulty = utility::random_weighted( [ "difficulty_easy", "difficulty_normal" ], [ 2, 1 ] );
            agent ob_story_mission_utils::zombie_set_difficulty( difficulty );
        }
        
        level.old_zombie_array = utility::array_removedead_or_dying( level.var_3a6122e97f6eefa0 );
    }
    else if ( activity_instance.var_3a04ef2068c13fc9 == 2 )
    {
        level.var_3a6122e97f6eefa0 = arrayremove( level.var_3a6122e97f6eefa0, level.old_zombie_array );
        
        foreach ( agent in level.var_3a6122e97f6eefa0 )
        {
            agent ob_story_mission_utils::zombie_set_difficulty( "difficulty_normal" );
        }
        
        level.old_zombie_array = utility::array_removedead_or_dying( level.var_3a6122e97f6eefa0 );
    }
    else if ( activity_instance.var_3a04ef2068c13fc9 == 3 )
    {
        level.var_3a6122e97f6eefa0 = arrayremove( level.var_3a6122e97f6eefa0, level.old_zombie_array );
        
        foreach ( agent in level.var_3a6122e97f6eefa0 )
        {
            agent ob_story_mission_utils::zombie_set_difficulty( "difficulty_hard" );
        }
        
        activity_instance utility::ent_flag_set( "void_docks_final_wave_spawned" );
    }
    
    activity_instance utility::ent_flag_set( "flag_void_docks_enemies_spawned" );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 0
// Checksum 0xa6fbbe30, Offset: 0x5571
// Size: 0x135
function function_32247da5db1abd1()
{
    activity_instance = self;
    activity_instance notify( #"hash_ac92ba77a44431f8" );
    scene_struct_01 = utility::getstruct( "void_docks_scene_struct_01", "targetname" );
    scene_struct_02 = utility::getstruct( "void_docks_scene_struct_02", "targetname" );
    scene_struct_03 = utility::getstruct( "void_docks_scene_struct_03", "targetname" );
    scene_struct_01 thread scene::play( undefined, [ "enter", "loop" ], "scene_sat_cin_leo_post_cradle_b" );
    scene_struct_02 thread scene::play( undefined, "loop", "sat_ai_leo_post_cradle_01_stage_fight_guild_soldiers" );
    scene_struct_03 thread scene::play( undefined, "loop", "sat_ai_leo_post_cradle_02_back_exit_fight_guild_soldiers" );
    wait 6;
    activity_instance notify( #"hash_2a6164fbc6180d9" );
    wait 2;
    
    if ( isdefined( scene_struct_01 ) )
    {
        scene_struct_01 thread scene::stop();
    }
    
    if ( isdefined( scene_struct_02 ) )
    {
        scene_struct_02 thread scene::stop();
    }
    
    if ( isdefined( scene_struct_03 ) )
    {
        scene_struct_03 thread scene::stop();
    }
    
    activity_instance waittill( #"void_docks_boss_dead" );
    
    if ( isdefined( scene_struct_01 ) )
    {
        scene_struct_01 scene::cleanup( 1 );
    }
    
    if ( isdefined( scene_struct_02 ) )
    {
        scene_struct_02 scene::cleanup( 1 );
    }
    
    if ( isdefined( scene_struct_03 ) )
    {
        scene_struct_03 scene::cleanup( 1 );
    }
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 1
// Checksum 0xe0f6bedd, Offset: 0x56ae
// Size: 0x25c
function handle_boss_encounter( sqaud )
{
    activity_instance = self;
    level endon( #"void_docks_boss_dead" );
    activity_instance endon( #"instance_destroyed" );
    boss_encounter_targetname = "void_docks_boss_encounter_vol";
    level.var_4e52f2d80ea168bc = [];
    activity_instance.void_docks_boss = activity_ai_encounters::function_92b671064b0b1ce2( boss_encounter_targetname, 1, 0, 1, 1 );
    
    if ( activity_instance.playerparticipants.size <= 2 )
    {
        function_1a9d724a960fa19d( activity_instance.void_docks_boss, "squad_size_small", 1 );
    }
    
    if ( activity_instance.playerparticipants.size >= 3 )
    {
        function_1a9d724a960fa19d( activity_instance.void_docks_boss, "squad_size_large", 1 );
    }
    
    if ( isdefined( activity_instance.void_docks_boss ) )
    {
        function_ef57f478f96b050c( activity_instance.void_docks_boss, 1 );
        ai_spawn_director::function_53289c032f506bb1( activity_instance.void_docks_boss, &function_5182d53a08b3fb0b, [] );
        activity_instance activity_ai_encounters::function_6bf4ff2fbde584ee( activity_instance.void_docks_boss, &function_45e7e20b48c163ad, activity_instance );
        ai_spawn_director::add_spawned_callback( activity_instance.void_docks_boss, &void_docks_boss_spawn_func );
        function_fbe9bb47edbe2d7c( activity_instance.void_docks_boss );
        activity_instance utility::ent_flag_wait( "flag_void_docks_boss_spawned" );
    }
    
    activity_instance.boss = ai_spawn_director::spawn_targetname( "void_docks_boss_spawn", 1 );
    activity_instance notify( #"void_boss_spawned" );
    
    if ( isdefined( activity_instance.boss ) )
    {
        if ( activity_instance.playerparticipants.size >= 3 )
        {
            activity_instance.boss ob_story_mission_utils::zombie_set_difficulty( "difficulty_hard" );
        }
        
        boss_health = activity_instance.boss.health;
        activity_instance.boss metabone::set_metabone_health( "head", boss_health * 0.3, "armor" );
        activity_instance utility::ent_flag_set( "docks_boss_spawned" );
        center_point = utility::getstruct( "void_center_struct", "targetname" );
        activity_instance.boss setgoalpos( center_point.origin + ( 0, 600, 0 ), 800 );
    }
    
    level utility::flag_wait( "void_docks_boss_dead" );
    wait 3;
    ai_spawn_director::cancel_spawn_request( activity_instance.void_docks_boss, 1, 1 );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 4
// Checksum 0x76d1af18, Offset: 0x5912
// Size: 0x3e
function void_docks_boss_spawn_func( requestid, instance, agent, ai_data )
{
    level.var_4e52f2d80ea168bc[ level.var_4e52f2d80ea168bc.size ] = agent;
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 3
// Checksum 0x27d2394d, Offset: 0x5958
// Size: 0xdd
function function_45e7e20b48c163ad( requestid, activity_instance, agent )
{
    activity_instance utility::ent_flag_set( "flag_void_docks_boss_spawned" );
    
    foreach ( agent in level.var_4e52f2d80ea168bc )
    {
        difficulty = utility::random_weighted( [ "difficulty_easy", "difficulty_normal", "difficulty_hard" ], [ 1, 3, 1 ] );
        agent ob_story_mission_utils::zombie_set_difficulty( difficulty );
    }
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 2
// Checksum 0x114344dc, Offset: 0x5a3d
// Size: 0x2f
function function_5182d53a08b3fb0b( requestid, userdata )
{
    if ( level utility::flag( "void_docks_boss_dead" ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 1
// Checksum 0x9881c9dc, Offset: 0x5a74
// Size: 0xec
function find_player_func( array )
{
    level endon( #"void_docks_boss_dead" );
    activity_instance = self;
    
    foreach ( agent in level.var_3a6122e97f6eefa0 )
    {
        if ( isalive( agent ) )
        {
            agent function_fa32376aaa88a7a2( agent.origin, 2000 );
            var_a6d716663bee7b52 = sortbydistance( activity_instance.playerparticipants, agent.origin );
            
            if ( var_a6d716663bee7b52.size )
            {
                agent getenemyinfo( var_a6d716663bee7b52[ 0 ] );
                agent forcethreatupdate();
            }
        }
    }
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 0
// Checksum 0xff972380, Offset: 0x5b68
// Size: 0x24
function setup_br_wall()
{
    level endon( #"void_docks_boss_dead" );
    activity_instance = self;
    activity_instance thread function_8a4b5830e567ba87();
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 0
// Checksum 0x4153f75d, Offset: 0x5b94
// Size: 0x189
function function_8a4b5830e567ba87()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    center_point = utility::getstruct( "void_center_struct", "targetname" );
    radius = 1680;
    circle_move_time = 10;
    var_556c8b233a9cc422 = radius;
    circle = function_cf688c9f42a85ed9( center_point.origin, radius, undefined, activity_instance );
    circle hide();
    function_3cd2087fed4e663a( 6, 6, 0, 0.8 );
    
    foreach ( player in activity_instance.playerparticipants )
    {
        circle showtoplayer( player );
    }
    
    wait 6;
    circle thread function_221d829785a0e7ef( center_point, radius, var_556c8b233a9cc422, activity_instance );
    level utility::flag_wait( "void_docks_boss_dead" );
    activity_instance notify( #"hash_6107a1124bdde767" );
    
    if ( isdefined( activity_instance.var_f7af54e3a4e17c28.mapcircle ) )
    {
        activity_instance.var_f7af54e3a4e17c28 game_utility::questcircle_delete();
    }
    
    if ( isdefined( activity_instance.var_f7af54e3a4e17c28 ) )
    {
        activity_instance.var_f7af54e3a4e17c28 delete();
        activity_instance.var_f7af54e3a4e17c28 = undefined;
    }
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 4
// Checksum 0x5339d8d2, Offset: 0x5d25
// Size: 0x1f1
function function_221d829785a0e7ef( center_point, radius, var_556c8b233a9cc422, activity_instance )
{
    activity_instance endon( #"instance_destroyed" );
    level endon( #"hash_6107a1124bdde767" );
    level endon( #"void_docks_boss_dead" );
    circle = self;
    circle_move_time = 20;
    next_radius = radius - 280;
    circle brcirclemoveto( center_point.origin[ 0 ], center_point.origin[ 1 ], next_radius, circle_move_time );
    activity_instance thread update_minimap_circle( circle, center_point.origin, center_point.origin, radius, next_radius, circle_move_time );
    wait circle_move_time;
    radius = next_radius;
    next_radius = radius - 400;
    circle brcirclemoveto( center_point.origin[ 0 ], center_point.origin[ 1 ], next_radius, circle_move_time );
    activity_instance thread update_minimap_circle( circle, center_point.origin, center_point.origin, radius, next_radius, circle_move_time );
    wait circle_move_time;
    radius = next_radius;
    activity_instance utility::ent_flag_wait( "docks_boss_spawned" );
    next_radius = 1000;
    circle brcirclemoveto( center_point.origin[ 0 ], center_point.origin[ 1 ], next_radius, circle_move_time );
    activity_instance thread update_minimap_circle( circle, center_point.origin, center_point.origin, radius, next_radius, circle_move_time );
    wait circle_move_time;
    next_radius = 800;
    circle brcirclemoveto( center_point.origin[ 0 ], center_point.origin[ 1 ] + 600, next_radius, circle_move_time );
    activity_instance thread update_minimap_circle( circle, center_point.origin, ( center_point.origin[ 0 ], center_point.origin[ 1 ] + 600, center_point.origin[ 2 ] ), radius, next_radius, circle_move_time );
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 6
// Checksum 0xeada668a, Offset: 0x5f1e
// Size: 0x12c
function update_minimap_circle( circle, start_pos, end_pos, start_radius, end_radius, duration )
{
    assert( isdefined( circle.mapcircle ), "<dev string:x86>" );
    assert( end_radius > 0, "<dev string:xd3>" );
    assert( start_radius > 0, "<dev string:xd3>" );
    circle.mapcircle endon( #"death" );
    circle endon( #"death" );
    start_time = gettime();
    end_time = gettime() + duration * 1000;
    
    while ( gettime() < end_time )
    {
        frac = math::lerp_fraction( start_time, end_time, gettime() );
        radius = math::lerp( start_radius, end_radius, frac );
        
        if ( isdefined( start_pos ) && isdefined( end_pos ) )
        {
            pos = vectorlerp( start_pos, end_pos, frac );
            circle game_utility::questcircle_move( pos );
        }
        
        circle game_utility::function_d46d8731ed9d281( radius );
        wait 0.05;
    }
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 4
// Checksum 0x84b933d7, Offset: 0x6052
// Size: 0x14e
function function_cf688c9f42a85ed9( v_origin, radius = 1024, var_af20df805aa22681 = 10, activity_instance )
{
    level endon( #"void_docks_boss_dead" );
    activity_instance.var_f7af54e3a4e17c28 = spawnbrcircle( v_origin[ 0 ], v_origin[ 1 ], radius );
    activity_instance.var_f7af54e3a4e17c28 show();
    activity_instance.var_f7af54e3a4e17c28 game_utility::questcircle_create( "testCircle_purple", v_origin, radius );
    activity_instance.var_f7af54e3a4e17c28 game_utility::questcircle_hidefromall();
    
    foreach ( player in activity_instance.playerparticipants )
    {
        activity_instance.var_f7af54e3a4e17c28 game_utility::questcircle_showtoplayer( player );
    }
    
    activity_instance.ob_circle_damage_tick = var_af20df805aa22681;
    activity_instance.var_f7af54e3a4e17c28 thread circle_damage_tick( activity_instance );
    return activity_instance.var_f7af54e3a4e17c28;
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 1
// Checksum 0x3e9512b, Offset: 0x61a9
// Size: 0x2f9
function circle_damage_tick( activity_instance )
{
    level endon( #"hash_6107a1124bdde767" );
    level endon( #"void_docks_boss_dead" );
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.var_f7af54e3a4e17c28 = self;
    var_16fa12dd34d85976 = br_circle::function_60fec44444cbd5d2();
    
    while ( true )
    {
        if ( isdefined( activity_instance.var_f7af54e3a4e17c28 ) )
        {
            damagetick = activity_instance.ob_circle_damage_tick;
            
            if ( isdefined( activity_instance.circledamagemultiplier ) )
            {
                damagetick = int( damagetick * activity_instance.circledamagemultiplier );
            }
            
            if ( damagetick > 0 )
            {
                dangercircleorigin = activity_instance.var_f7af54e3a4e17c28.origin;
                dangercircleradius = activity_instance.var_f7af54e3a4e17c28.origin[ 2 ];
                
                foreach ( player in activity_instance.playerparticipants )
                {
                    if ( !( isdefined( player ) && isdefined( player.origin ) ) )
                    {
                        continue;
                    }
                    
                    var_d3d5e207911ff294 = 0;
                    
                    if ( distance2dsquared( dangercircleorigin, player.origin ) > dangercircleradius * dangercircleradius )
                    {
                        if ( isalive( player ) )
                        {
                            var_d3d5e207911ff294 = 1;
                            
                            if ( !isdefined( player.var_2f8b6417bc00b4a0 ) )
                            {
                                player.var_2f8b6417bc00b4a0 = gettime();
                            }
                            
                            modifieddamagetick = player br_circle::function_eaac348121cbeb8c( var_16fa12dd34d85976, damagetick );
                            
                            if ( gasmask::hasgasmask( player ) )
                            {
                                if ( gasmask::function_e949a578c3db30d( player ) )
                                {
                                    if ( !player.gasmaskequipped )
                                    {
                                        player br_circle::function_b591cdbc3dcd9112( modifieddamagetick );
                                    }
                                    
                                    player gasmask::processdamage( modifieddamagetick );
                                }
                                else if ( player.gasmaskhealth <= 0 )
                                {
                                    player playsoundtoplayer( "br_gas_mask_break_plr", player );
                                    player br_pickups::function_5375ae93bfe708df();
                                    player br_pickups::function_219547e563ff9527();
                                }
                                else
                                {
                                    if ( isdefined( level.var_548004405d16dcf8 ) )
                                    {
                                        player [[ level.var_548004405d16dcf8 ]]( "aether_gas" );
                                    }
                                    
                                    player gasmask::processdamage( modifieddamagetick );
                                }
                            }
                            else
                            {
                                player br_circle::function_b591cdbc3dcd9112( modifieddamagetick );
                            }
                        }
                        else
                        {
                            player.var_2f8b6417bc00b4a0 = undefined;
                        }
                        
                        continue;
                    }
                    
                    player.var_2f8b6417bc00b4a0 = undefined;
                    
                    if ( gasmask::hasgasmask( player ) )
                    {
                        if ( gasmask::function_e949a578c3db30d( player ) )
                        {
                            continue;
                        }
                        
                        if ( player.gasmaskhealth <= 0 )
                        {
                            player playsoundtoplayer( "br_gas_mask_break_plr", player );
                            player br_pickups::function_5375ae93bfe708df();
                            continue;
                        }
                        
                        player br_pickups::gasmaskoff( "br_circle" );
                    }
                }
            }
        }
        
        wait 1;
    }
}

// Namespace sat_ob_contract_taurus_destroy_supplies
// Params 1
// Checksum 0x40be781d, Offset: 0x64aa
// Size: 0x211
function void_docks_skip( squad_struct )
{
    teleport_structs = utility::getstructarray( "void_teleport_structs_01", "targetname" );
    thread function_6070fd94d3acb72a( teleport_structs, "player_teleported_to_void_docks" );
    wait 8;
    activity_instance = self;
    self notify( #"all_crates_exploded" );
    cradle_time = 10;
    squad = teams::function_72b89edf6b47c40a( activity_instance.playerparticipants[ 0 ] );
    thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "avalon_heavy", cradle_time, undefined, activity_instance.playerparticipants, undefined, undefined, 0 );
    
    foreach ( player in squad.players )
    {
        player hud_util::function_a7b5c7ac6074b623( "red_tint", "white", ( 0.375, 0, 0.02 ) );
        player thread hud_util::fade_out( 3, "red_tint" );
    }
    
    wait 3;
    activity_instance function_a109e784e9b23f56( squad );
    activity_instance thread taurus_destroy_supplies_void_vo();
    activity_instance thread void_docks_enc( squad );
    wait 3;
    thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "avalon_heavy", 4, undefined, activity_instance.playerparticipants, undefined, undefined, 0 );
    
    foreach ( player in squad.players )
    {
        player thread hud_util::fade_in( 3, "red_tint" );
        playfx( level._effect[ "taurus_cradle_spawn_vfx" ], player.origin, undefined, undefined, player );
    }
}

