// script_64ee2937f86a1d5c  (hash_64ee2937f86a1d5c.gscc) (size: 13108 Bytes / 0x3334 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1679e453 (377087059)
// size ...... 13108 (0x3334)
// includes .. 21  (offset: 0x2e44)
// strings ... 79  (offset: 0x2eec)
// dev strs .. 0   (offset: 0x3334)
// exports ... 37  (offset: 0x1c3c)
// cseg ...... 0x78f + 0x14ad (0x1c3c)
// imports ... 101 (offset: 0x2204)
// animtree1 . 0   (offset: 0x3334)
// animtree2 . 0   (offset: 0x3334)
#using script_1369f66fa8958a74;
#using script_3edd59d0d3fc3262;
#using script_636bd827a012af12;
#using scripts\asm\asm;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\ai_spawn_director_utility;
#using scripts\common\ai\ai_utility;
#using scripts\common\ai\stealth\manager;
#using scripts\common\cap;
#using scripts\common\chyron;
#using scripts\common\hints;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\waypoint_objective_handler;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_audio;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_util;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_vo;

#namespace namespace_1674a18ad0564da6;

/#

    // Namespace namespace_1674a18ad0564da6
    // Params 0
    // Checksum 0x146f42f8, Offset: 0x7ad
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_1674a18ad0564da6
// Params 0, eflags: 0x5
// Checksum 0x4e60a804, Offset: 0x7ba
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_64fc110faa39a547", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_1674a18ad0564da6
// Params 0, eflags: 0x4
// Checksum 0xc73b55ea, Offset: 0x7e3
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LEO_FACILITY_INTRO";
    activity_common::registeractivitytype( "OB_LEO_FACILITY_INTRO", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LEO_FACILITY_INTRO", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LEO_FACILITY_INTRO", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LEO_FACILITY_INTRO", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_LEO_FACILITY_INTRO" );
}

// Namespace namespace_1674a18ad0564da6
// Params 0
// Checksum 0xe3e3f999, Offset: 0x85a
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance facility_intro_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_1674a18ad0564da6
// Params 0
// Checksum 0xe384efe2, Offset: 0x8bf
// Size: 0x3d
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    activity_instance thread facility_intro_main();
}

// Namespace namespace_1674a18ad0564da6
// Params 0
// Checksum 0x8958d907, Offset: 0x904
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_1674a18ad0564da6
// Params 1
// Checksum 0x702585, Offset: 0x928
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread player_setup( player );
    }
}

/#

    // Namespace namespace_1674a18ad0564da6
    // Params 0
    // Checksum 0x53d5e6e8, Offset: 0x9e4
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_1674a18ad0564da6
// Params 1
// Checksum 0x301a1b2e, Offset: 0x9f1
// Size: 0x19
function player_setup( player )
{
    activity_instance = self;
}

// Namespace namespace_1674a18ad0564da6
// Params 0
// Checksum 0x8162f096, Offset: 0xa12
// Size: 0x10
function facility_intro_start()
{
    thread mp_sat_ob_leo_util::function_96b32ff9e4b0fc4c();
    thread mp_sat_ob_leo_util::function_d2eaefb295692571();
}

// Namespace namespace_1674a18ad0564da6
// Params 0
// Checksum 0x7bb40107, Offset: 0xa2a
// Size: 0x158
function facility_intro_main()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    thread ob_story_mission_utils::item_spawn_weapon( "s_facility_intro_weapon", "facility_to_jungle_complete", 1 );
    thread ob_story_mission_utils::item_spawn_equipment( "s_facility_intro_equipment", "facility_to_jungle_complete", 1 );
    level thread mp_sat_ob_leo_vo::facility_intro_vo();
    level utility::flag_set( "flag_leo_nm_intro" );
    chyron::function_d41002779543c80e();
    
    foreach ( player in level.players )
    {
        player thread function_6ff2801cfc7520cb();
    }
    
    thread facility_intro_objectives();
    thread facility_intro_encounters();
    level thread ob_story_mission_utils::function_e6799e9a19df2365( "struct_cache_atrium" );
    level thread namespace_fc92da645acfbbdc::presentation_puzzle();
    facility_in_led_hall = getent( "facility_in_led_hall", #targetname );
    
    if ( isdefined( facility_in_led_hall ) )
    {
        facility_in_led_hall waittill( #"trigger" );
    }
    
    level utility::flag_set( "facility_intro_complete" );
    story_contract_util::mark_complete( level.players, #"leo_launch" );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_1674a18ad0564da6
// Params 0
// Checksum 0xfdfc0211, Offset: 0xb8a
// Size: 0x28
function function_6ff2801cfc7520cb()
{
    self endon( #"death_or_disconnect" );
    wait 6;
    hints::hint_add_simple( "leo_navi_hint", &"sat_ob_story_missions/leo_navi_hint", 6 );
}

// Namespace namespace_1674a18ad0564da6
// Params 0, eflags: 0x4
// Checksum 0x299cf887, Offset: 0xbba
// Size: 0x53
function private facility_intro_objectives()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    ob_story_mission_utils::objective_text_show( %"hash_45d1aab33743f656" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "presentation_puzzle_interact", undefined, "", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 16 ) );
}

// Namespace namespace_1674a18ad0564da6
// Params 0
// Checksum 0x55ea2dff, Offset: 0xc15
// Size: 0x2
function function_d45356e533323c8c()
{
    
}

// Namespace namespace_1674a18ad0564da6
// Params 0
// Checksum 0x53b2d306, Offset: 0xc1f
// Size: 0x439
function facility_intro_encounters()
{
    utility::exploder( "facility_intro_hallway_smoke" );
    level utility::flag_set( "flag_intro_encounter_start" );
    level.var_a28f00842c3ee57b = [];
    level.intro_nodes = getnodearray( "intro_nodes", "targetname" );
    scene_struct = utility::getstruct( "sat_scene_ai_smoke_react_vig", "targetname" );
    
    if ( isdefined( scene_struct ) )
    {
        scene_struct thread scene::play();
        enemies_props = scene_struct scene::get_objects_by_type( "Types_Prop" );
        enemies = [];
        
        foreach ( enemy_prop in enemies_props )
        {
            enemy_prop.entity.var_2fc3a5fb762afb6e = 1;
            enemies[ enemies.size ] = enemy_prop.entity;
        }
        
        level notify( #"highvis_reload_outline", undefined, enemies );
    }
    
    foreach ( player in level.players )
    {
        player thread function_a668a07d3aa91d11();
    }
    
    foreach ( player in level.players )
    {
        player thread function_5939fb3872dd8f1d();
    }
    
    foreach ( player in level.players )
    {
        player thread function_ea8d7ff93adaf61c();
    }
    
    facility_atrium_encounter_start_trig = getent( "facility_atrium_encounter_start_trig", #targetname );
    facility_atrium_encounter_start_trig waittill( #"trigger" );
    
    foreach ( player in level.players )
    {
        player thread function_a4c2b95bec1c6c9c();
    }
    
    level utility::flag_set( "flag_atrium_encounter_start" );
    atrium1_wave1 = ai_spawn_director::array_spawn_targetname( "atrium1_wave1" );
    level thread function_87c57f2f89607670( atrium1_wave1 );
    level thread function_d77fa28d0799957b();
    level thread mp_sat_ob_leo_vo::function_31edf6edcc0d5b29();
    level thread mp_sat_ob_leo_vo::function_992fc75ffb5cde03();
    stealth_manager::set_stealth_bundle( "sat_stealth_ob_sm_leo" );
    level thread leo_audio::facility_office_combat_walla( atrium1_wave1 );
    
    foreach ( guy in atrium1_wave1 )
    {
        guy.goalradius = 20;
        guy aisettargetspeed( 56 );
        guy function_630eac6fd6900a61( "sat_ob_sm_leo_intro", 0 );
    }
    
    level thread mp_sat_ob_leo_util::function_2463b23bc69b1a0a( atrium1_wave1, atrium1_wave1.size - 4, "flag_atrium_wave2" );
    utility::flag_wait( "flag_atrium_wave2" );
    
    if ( utility::flag( "flag_atrium1_stealth_broke" ) )
    {
        level thread mp_sat_ob_leo_util::function_ac9de8895f3e4a23( atrium1_wave1, "vol_atrium1_back" );
    }
}

// Namespace namespace_1674a18ad0564da6
// Params 0
// Checksum 0xda6ac53a, Offset: 0x1060
// Size: 0x31
function function_a4c2b95bec1c6c9c()
{
    self endon( #"death_or_disconnect" );
    utility::flag_wait( "flag_stealth_vo_said" );
    hints::hint_add_simple( "leo_stealth_hint", &"sat_ob_story_missions/leo_stealth_hint", 5 );
}

// Namespace namespace_1674a18ad0564da6
// Params 0
// Checksum 0xdb32680d, Offset: 0x1099
// Size: 0x4d
function function_a668a07d3aa91d11()
{
    self endon( #"death_or_disconnect" );
    door_trig = getent( "intro_hallway_door", "script_noteworthy" );
    door_trig waittill( #"trigger" );
    hints::hint_add_simple( "leo_supply_cache_hint", &"sat_ob_story_missions/leo_supply_cache_hint", 5 );
}

// Namespace namespace_1674a18ad0564da6
// Params 0
// Checksum 0x8e6527a3, Offset: 0x10ee
// Size: 0x54
function function_5939fb3872dd8f1d()
{
    self endon( #"death_or_disconnect" );
    self waittill( #"damage" );
    hint_string = self usinggamepad() ? &"sat_ob_story_missions/leo_plate_hint" : &"sat_ob_story_missions/leo_plate_hint_kbm";
    hints::hint_add_simple( "leo_plate_hint", hint_string, 10 );
}

// Namespace namespace_1674a18ad0564da6
// Params 0
// Checksum 0xfc9547da, Offset: 0x114a
// Size: 0x76
function function_ea8d7ff93adaf61c()
{
    self endon( #"death_or_disconnect" );
    self notifyonplayercommand( "ability_used", "+smoke" );
    self notifyonplayercommand( "equipment_used", "+frag" );
    utility::waittill_any( "ability_used", "equipment_used" );
    hints::hint_add_simple( "leo_recharge_hint", &"sat_ob_story_missions/leo_recharge_hint", 10 );
    self notifyonplayercommandremove( "ability_used", "+smoke" );
    self notifyonplayercommandremove( "equipment_used", "+frag" );
}

// Namespace namespace_1674a18ad0564da6
// Params 1
// Checksum 0xbc51de64, Offset: 0x11c8
// Size: 0x88
function function_87c57f2f89607670( guys )
{
    foreach ( guy in guys )
    {
        guy thread function_8db66143117151f3();
    }
    
    level thread function_761e0948c21df538( guys );
}

// Namespace namespace_1674a18ad0564da6
// Params 0
// Checksum 0xc9a92a5c, Offset: 0x1258
// Size: 0x3b
function function_8db66143117151f3()
{
    utility::waittill_any( "stealth_investigate", "stealth_hunt", "stealth_combat", "startCombatRush" );
    wait 1.5;
    utility::flag_set( "flag_atrium1_stealth_broke" );
    level notify( #"flag_atrium1_stealth_broke" );
}

// Namespace namespace_1674a18ad0564da6
// Params 1
// Checksum 0x4427456e, Offset: 0x129b
// Size: 0x107
function function_761e0948c21df538( guys )
{
    utility::flag_wait( "flag_atrium1_stealth_broke" );
    guys = utility::array_removedead_or_dying( guys );
    
    foreach ( guy in guys )
    {
        guy aieventlistenerevent( "combat" );
        guy.forcegoal = 0;
        guy.fixednode = 0;
        guy cleargoalentity();
        
        if ( guy.stealth_enabled )
        {
            guy setstealthstate( "combat" );
        }
        
        if ( isdefined( guy.script_goalvolume ) )
        {
            vol = getent( guy.script_goalvolume, "targetname" );
            guy setgoalvolumeauto( vol );
        }
    }
}

// Namespace namespace_1674a18ad0564da6
// Params 0
// Checksum 0xa9354eec, Offset: 0x13aa
// Size: 0x141
function function_d77fa28d0799957b()
{
    level endon( #"hash_b19d0e139c876f55" );
    utility::flag_wait( "flag_atrium1_stealth_broke" );
    mp_sat_ob_leo_util::lock_door( "lower_atrium_to_central_door" );
    trig = getent( "trig_toggle_reinforcements", #targetname );
    trig utility::trigger_off();
    wait 1;
    mp_sat_ob_leo_util::unlock_door( "atrium_reinforcement_door" );
    atrium1_wave2 = ai_spawn_director::array_spawn_targetname( "atrium1_wave2" );
    allguys = ai_spawn_director::get_ai_group_ai( "ai_atrium1" );
    level thread function_a449d39996b66fa7();
    waypoint_objective_handler::waypoint_objective_handler_cancel( "presentation_puzzle_interact" );
    ob_story_mission_utils::objective_text_show( %"hash_60a27c7d47197c69" );
    wait 2;
    level thread mp_sat_ob_leo_util::function_df0396a50445e0c4( "intro_fire_alarms", "flag_central_player_entered_space" );
    level thread function_18af04b589172140();
    thread mp_sat_ob_leo_vo::function_bff5063e5cb50c64( "dx_wc_mleo_lprc_gpa1_alertsecuritybreachd", "pa_struct_intro" );
    level thread mp_sat_ob_leo_util::function_2463b23bc69b1a0a( allguys, allguys.size, "flag_atrium_encounter_done" );
    utility::flag_wait( "flag_atrium_encounter_done" );
    wait 1.3;
    ob_story_mission_utils::objective_text_show( %"hash_45d1aab33743f656" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "presentation_puzzle_interact", undefined, "", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 16 ) );
    mp_sat_ob_leo_util::unlock_door( "lower_atrium_to_central_door" );
}

// Namespace namespace_1674a18ad0564da6
// Params 0
// Checksum 0xb57de507, Offset: 0x14f3
// Size: 0x77
function function_18af04b589172140()
{
    var_68b32a8bafee7061 = "flag_central_player_entered_space";
    tick_name = "intro_alarm_tick";
    period = 1.5;
    level thread mp_sat_ob_leo_util::alarm_listener( "amb_emt_security_alarm_1", ( 12992, 3555, -4687 ), tick_name, var_68b32a8bafee7061 );
    level thread mp_sat_ob_leo_util::alarm_listener( "amb_emt_security_alarm_2", ( 12992, 1313, -4687 ), tick_name, var_68b32a8bafee7061 );
    level thread mp_sat_ob_leo_util::function_eae6f210af41e04f( tick_name, period, var_68b32a8bafee7061 );
}

// Namespace namespace_1674a18ad0564da6
// Params 0
// Checksum 0x3a3feb07, Offset: 0x1572
// Size: 0xf6
function function_a449d39996b66fa7()
{
    allguys = ai_spawn_director::get_ai_group_ai( "ai_atrium1" );
    level thread mp_sat_ob_leo_util::function_2463b23bc69b1a0a( allguys, allguys.size - 3, "flag_atrium_ending" );
    utility::flag_wait( "flag_atrium_ending" );
    allguys = utility::array_removedead_or_dying( allguys );
    level thread mp_sat_ob_leo_util::function_ac9de8895f3e4a23( allguys, "vol_atrium1_end" );
    level thread mp_sat_ob_leo_util::function_2463b23bc69b1a0a( allguys, allguys.size - 2, "flag_atrium_ending2" );
    utility::flag_wait( "flag_atrium_ending2" );
    
    foreach ( guy in allguys )
    {
        if ( isalive( guy ) )
        {
            guy thread ai_utility::player_seek_enable();
            guy thread function_21f4517e5f4572c3();
        }
    }
}

// Namespace namespace_1674a18ad0564da6
// Params 0
// Checksum 0xe9af2afc, Offset: 0x1670
// Size: 0x2b
function function_21f4517e5f4572c3()
{
    self endon( #"death" );
    self endon( #"damage" );
    wait 40;
    
    if ( isalive( self ) )
    {
        self kill();
    }
}

// Namespace namespace_1674a18ad0564da6
// Params 0
// Checksum 0x2048ea2f, Offset: 0x16a3
// Size: 0x9e
function function_56a5c0f3bde246df()
{
    var_d8b25ddc3f9cb2a1 = getent( "vol_atrium1_shg_left", "targetname" );
    var_8b541f529a111182 = getent( "vol_atrium1_shg_right", "targetname" );
    guy = ai_spawn_director::get_ai_group_ai( "intro_shg_guy" );
    utility::flag_wait_any( "flag_intro_shg_guy_right", "flag_intro_shg_guy_left" );
    
    if ( utility::flag( "flag_intro_shg_guy_right" ) )
    {
        if ( isalive( guy[ 0 ] ) )
        {
            guy[ 0 ] setgoalvolumeauto( var_8b541f529a111182 );
        }
    }
    
    if ( utility::flag( "flag_intro_shg_guy_left" ) )
    {
        if ( isalive( guy[ 0 ] ) )
        {
            guy[ 0 ] setgoalvolumeauto( var_d8b25ddc3f9cb2a1 );
        }
    }
}

// Namespace namespace_1674a18ad0564da6
// Params 0
// Checksum 0x9fb8600e, Offset: 0x1749
// Size: 0x39
function function_6493060dfcce6319()
{
    self endon( #"death" );
    utility::ent_flag_wait( "scene_active" );
    utility::ent_flag_waitopen_any( "scene_active" );
    self kill();
    level utility::flag_set( "flag_intro_encounter_done" );
}

// Namespace namespace_1674a18ad0564da6
// Params 3
// Checksum 0x733206d5, Offset: 0x178a
// Size: 0x2b
function function_cad1856423c11b02( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_intro_enemies_spawned" );
}

// Namespace namespace_1674a18ad0564da6
// Params 4
// Checksum 0x6a6dfd7f, Offset: 0x17bd
// Size: 0x7f
function intro_spawn_func( requestid, instance, agent, ai_data )
{
    self.goalradius = 32;
    level.var_a28f00842c3ee57b[ level.var_a28f00842c3ee57b.size ] = agent;
    
    if ( isdefined( agent.asm ) )
    {
        self.flashendtime = int( 10000 );
        agent thread asm::asm_setstate( "pain_flashed_transition" );
    }
    
    agent thread function_8ffb266b1fe580ea();
}

// Namespace namespace_1674a18ad0564da6
// Params 0
// Checksum 0x376f8240, Offset: 0x1844
// Size: 0x2f
function function_855f8a33b1e09f7e()
{
    level utility::flag_wait( "flag_atrium_encounter_start" );
    var_95b86e61b2c6a7 = utility::array_random( ob_story_mission_utils::get_playing_players() );
    self setgoalentity( var_95b86e61b2c6a7 );
}

// Namespace namespace_1674a18ad0564da6
// Params 3
// Checksum 0xa39a9875, Offset: 0x187b
// Size: 0x2b
function function_4ec017f718a6b6be( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_atrium_enemies_spawned" );
}

// Namespace namespace_1674a18ad0564da6
// Params 4
// Checksum 0x1edef3c0, Offset: 0x18ae
// Size: 0x7f
function atrium_spawn_func( requestid, instance, agent, ai_data )
{
    level.var_a28f00842c3ee57b[ level.var_a28f00842c3ee57b.size ] = agent;
    
    if ( ai_data.script_noteworthy == "cap_call_advance" )
    {
        wait 1;
        agent waittill( #"goal" );
        agent thread cap::cap_start( "sat_cap_act_turn", "sat_ai_sdr_call_advance" );
    }
    
    agent thread function_8ffb266b1fe580ea();
}

// Namespace namespace_1674a18ad0564da6
// Params 0
// Checksum 0x3ab2d9f2, Offset: 0x1935
// Size: 0xe6
function function_8ffb266b1fe580ea()
{
    agent = self;
    level utility::flag_wait( "flag_atrium_player_near_exit" );
    lower_exit_struct = utility::getstruct( "atrium_lower_exit" );
    
    if ( distance( agent.origin, lower_exit_struct.origin ) < 1000 )
    {
        agent setgoalpos( lower_exit_struct.origin );
    }
    else
    {
        players = ob_story_mission_utils::get_playing_players();
        closest_player = function_47c86977a18df38b( players, agent.origin );
        agent setgoalentity( closest_player );
        agent.goalradius = 32;
    }
    
    level utility::flag_wait( "flag_led_hall_ff_destroyed" );
    players = ob_story_mission_utils::get_playing_players();
    closest_player = function_47c86977a18df38b( players, agent.origin );
    agent setgoalentity( closest_player );
    agent.goalradius = 32;
}

// Namespace namespace_1674a18ad0564da6
// Params 3
// Checksum 0xe945b0c8, Offset: 0x1a23
// Size: 0x45
function function_c0911199b690c3fd( requestid, userdata, shutdowndata )
{
    level utility::flag_set( "flag_atrium_encounter_done" );
    iprintln( "atrium encounter complete!" );
    ai_spawn_director::cancel_spawn_request( level.var_401eccc3f6cbbf41 );
}

// Namespace namespace_1674a18ad0564da6
// Params 3
// Checksum 0x1bb867c4, Offset: 0x1a70
// Size: 0x1cc
function atrium_kill_progress_tracker( requestid, activity_instance, agent )
{
    if ( utility::flag( "flag_atrium_player_near_exit" ) )
    {
        return;
    }
    
    level.var_a28f00842c3ee57b = utility::array_removedead_or_dying( level.var_a28f00842c3ee57b );
    
    if ( level.var_a28f00842c3ee57b.size < 9 )
    {
        iprintln( "enemies retreat to exit" );
        lower_exit_struct = utility::getstruct( "atrium_lower_exit_2" );
        
        foreach ( agent in level.var_a28f00842c3ee57b )
        {
            agent setgoalpos( lower_exit_struct.origin );
        }
        
        return;
    }
    
    if ( level.var_a28f00842c3ee57b.size < 13 )
    {
        iprintln( "enemies retreat" );
        lower_exit_struct = utility::getstruct( "atrium_lower_exit" );
        upper_exit_struct = utility::getstruct( "atrium_upper_exit" );
        exit_structs = [ lower_exit_struct, upper_exit_struct ];
        
        foreach ( agent in level.var_a28f00842c3ee57b )
        {
            agent setgoalpos( function_47c86977a18df38b( exit_structs, agent.origin ).origin );
        }
    }
}

