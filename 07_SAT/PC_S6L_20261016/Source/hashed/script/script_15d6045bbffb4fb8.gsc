// script_15d6045bbffb4fb8  (hash_15d6045bbffb4fb8.gscc) (size: 10049 Bytes / 0x2741 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd8135c96 (3625147542)
// size ...... 10049 (0x2741)
// includes .. 14  (offset: 0x2271)
// strings ... 76  (offset: 0x22e1)
// dev strs .. 0   (offset: 0x2741)
// exports ... 30  (offset: 0x1481)
// cseg ...... 0x84b + 0xc36 (0x1481)
// imports ... 77  (offset: 0x1931)
// animtree1 . 0   (offset: 0x2741)
// animtree2 . 0   (offset: 0x2741)
#using script_636bd827a012af12;
#using script_66878054d141dbc0;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director_utility;
#using scripts\common\ai\ai_utility;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_audio;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_lighting;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_util;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_vo;
#using scripts\mp\ob\systems\ob_item_select;

#namespace namespace_e6c82038bc91b78c;

/#

    // Namespace namespace_e6c82038bc91b78c
    // Params 0
    // Checksum 0x78a8b8d2, Offset: 0x869
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_e6c82038bc91b78c
// Params 0, eflags: 0x5
// Checksum 0x97057133, Offset: 0x876
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_37e1d4c072c035c9", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_e6c82038bc91b78c
// Params 0, eflags: 0x4
// Checksum 0x14875246, Offset: 0x89f
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LIBRA_AMBUSH";
    activity_common::registeractivitytype( "OB_LIBRA_AMBUSH", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_AMBUSH", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_AMBUSH", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_AMBUSH", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_e6c82038bc91b78c
// Params 0
// Checksum 0x2e16f015, Offset: 0x900
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_e6c82038bc91b78c
// Params 0
// Checksum 0x298051ed, Offset: 0x965
// Size: 0x48
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    activity_instance function_1277c31ae65bc2();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_e6c82038bc91b78c
// Params 0
// Checksum 0xe59f232d, Offset: 0x9b5
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_e6c82038bc91b78c
// Params 0
// Checksum 0x83a45c24, Offset: 0x9d9
// Size: 0xe
function setup_ui_widget()
{
    ob_story_mission_utils::objective_text_show( "OB_LIBRA_AMBUSH" );
}

/#

    // Namespace namespace_e6c82038bc91b78c
    // Params 0
    // Checksum 0x3f121cc2, Offset: 0x9ef
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_e6c82038bc91b78c
// Params 0
// Checksum 0x6f607ac0, Offset: 0x9fc
// Size: 0x9
function start()
{
    setup_ui_widget();
}

// Namespace namespace_e6c82038bc91b78c
// Params 0
// Checksum 0xf9bf47a9, Offset: 0xa0d
// Size: 0x18d
function function_1277c31ae65bc2()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    ob_story_mission_utils::objective_text_show( "OB_LIBRA_AMBUSH" );
    thread ob_story_mission_utils::item_spawn_weapon( "s_weapon_libra_ambush", "flag_igc_boss_intro_done", 1 );
    thread ob_story_mission_utils::item_spawn_equipment( "s_equip_ambush", "flag_igc_boss_intro_done", 1 );
    case_struct = utility::getstruct( "ability_struct_ambush", "targetname" );
    
    if ( isdefined( case_struct ) )
    {
        thread ob_item_select::function_95f9ecc2af4693f6( case_struct.origin, "super_war_machine", "super_annihilator", #"default" );
    }
    
    level thread setup_force_fields();
    level thread mp_sat_ob_libra_lighting::function_7ba8f081958256f6( [ "flag_activate_ambush_gas" ], "flag_ambush_done", 256, 20, 10 );
    thread exit_door();
    level thread ambush_gas();
    level thread ambush_fans();
    level thread mp_sat_ob_libra_vo::ambush_ff_hint();
    level thread mp_sat_ob_libra_vo::function_c4892096ff98f902();
    level thread mp_sat_ob_libra_vo::function_c4891f96ff98f6cf();
    level thread mp_sat_ob_libra_vo::ambush_intro();
    level thread setup_guild_bots();
    level thread mp_sat_ob_libra_vo::ambush_final_ff_hint();
    level thread ambush_final_ff_bad_place();
    level utility::flag_wait( "flag_ambush_intro" );
    ob_story_mission_utils::objective_text_show( "ob_libra_ambush_trap" );
    level thread mp_sat_ob_libra_util::function_7e4765db24e0ee73( "on", "ambush_ff_01", #targetname );
    level thread function_68d3a5ccef9674da();
    thread ambush_encounter();
    level utility::flag_wait( "flag_ambush_done" );
    enemies = getaiarray( "team_hundred_ninety", "team_hundred_ninety_nine" );
    
    if ( isdefined( enemies ) )
    {
        enemies = utility::array_removedead_or_dying( enemies );
        level thread ai_utility::ai_delete_when_out_of_sight( enemies, 500 );
    }
}

// Namespace namespace_e6c82038bc91b78c
// Params 0
// Checksum 0x3d14d9e2, Offset: 0xba2
// Size: 0x121
function exit_door()
{
    answers_door_interact = utility::getstruct( "answers_door_interact", "script_noteworthy" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "answers_door_interact_waypoint", undefined, "answers_door_interact_waypoint_done", undefined, undefined, 0, 0, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 16 ) );
    level thread mp_sat_ob_libra_util::function_776ea74dd9e92d46( "flag_answers_exit_door_opened", "answers_door_interact_waypoint" );
    trigger = getent( "answers_exit_door", "script_noteworthy" );
    
    if ( isdefined( trigger ) )
    {
        thread mp_sat_ob_libra_util::handle_console_unlock( trigger, answers_door_interact );
        trigger waittill( #"door_opened" );
    }
    
    level utility::flag_set( "flag_answers_exit_door_opened" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "ambush_start_waypoint_org", undefined, "ambush_start_waypoint_org_waypoint_done", undefined, undefined, 1 );
    level thread mp_sat_ob_libra_util::function_776ea74dd9e92d46( "flag_ambush_intro", "ambush_start_waypoint_org" );
    thread function_1c2abf7574a71deb();
    level utility::flag_wait( "flag_ambush_new_exit" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "ambush_exit_access_waypoint_org", undefined, "ambush_exit_accessible_01_waypoint_org_waypoint_done", undefined, undefined, 0 );
    level thread mp_sat_ob_libra_util::function_776ea74dd9e92d46( "flag_ambush_exit_accessible", "ambush_exit_access_waypoint_org", undefined, "end_ambush_exit_access_waypoint_org_canceler" );
    level utility::flag_wait( "flag_ambush_exit_accessible" );
    level utility::flag_set( "flag_ambush_done" );
}

// Namespace namespace_e6c82038bc91b78c
// Params 0
// Checksum 0x9d313e9f, Offset: 0xccb
// Size: 0x48
function function_1c2abf7574a71deb()
{
    level utility::flag_wait( "ff_intro_vo_done" );
    
    if ( !level utility::flag( "flag_ambush_first_ff_disabled" ) )
    {
        thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "ambush_start_ff_powersupply_waypoint_org", undefined, "ambush_start_ff_powersupply_org_waypoint_done", undefined, undefined, 1 );
        level thread mp_sat_ob_libra_util::function_776ea74dd9e92d46( "flag_ambush_first_ff_disabled", "ambush_start_ff_powersupply_waypoint_org" );
    }
}

// Namespace namespace_e6c82038bc91b78c
// Params 0
// Checksum 0x12d6ce0a, Offset: 0xd1b
// Size: 0x10
function function_68d3a5ccef9674da()
{
    wait 1;
    level thread mp_sat_ob_libra_vo::function_21fdf872c3bfa9e2();
}

// Namespace namespace_e6c82038bc91b78c
// Params 0, eflags: 0x4
// Checksum 0x1db95258, Offset: 0xd33
// Size: 0x21
function private facility_intro_objectives()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    setup_ui_widget();
}

// Namespace namespace_e6c82038bc91b78c
// Params 0
// Checksum 0xe4f43666, Offset: 0xd5c
// Size: 0x53
function ambush_encounter()
{
    ai_spawn_director::array_spawn_function_noteworthy( "ambush_guild_bot", &ambush_guild_bot_spawn_func );
    level thread function_d6c78602e5007962();
    level thread ambush_wave_2();
    level thread ambush_wave_2_end();
    level thread enable_ambush_wave_3();
    level thread ambush_wave_3();
    level thread ambush_wave_central();
    level thread ambush_wave_central_end();
    level thread ambush_wave_4();
}

// Namespace namespace_e6c82038bc91b78c
// Params 0
// Checksum 0x5641a8d1, Offset: 0xdb7
// Size: 0x62
function function_d6c78602e5007962()
{
    level utility::flag_wait( "flag_ambush_first_ff_disabled" );
    ambush_enemies_wave_1 = ai_spawn_director::array_spawn_targetname( "ambush_enemies_wave_1" );
    
    if ( level.is_squad_size_small == 0 )
    {
        ambush_enemies_wave_1_large = ai_spawn_director::array_spawn_targetname( "ambush_enemies_wave_1_large" );
        ambush_enemies_wave_1 = arraycombine( ambush_enemies_wave_1, ambush_enemies_wave_1_large );
    }
    
    level thread mp_sat_ob_libra_vo::ambush_guild_bots_incoming();
    level thread mp_sat_ob_libra_vo::ambush_kagan();
}

// Namespace namespace_e6c82038bc91b78c
// Params 0
// Checksum 0xbc0ba3fd, Offset: 0xe21
// Size: 0xb2
function ambush_wave_2()
{
    level endon( #"flag_ambush_done" );
    level utility::flag_wait( "flag_ambush_wave_2" );
    ambush_enemies_wave_2 = ai_spawn_director::array_spawn_targetname( "ambush_enemies_wave_2" );
    
    if ( level.is_squad_size_small == 0 )
    {
        ambush_enemies_wave_2_large = ai_spawn_director::array_spawn_targetname( "ambush_enemies_wave_2_large" );
        ambush_enemies_wave_2 = arraycombine( ambush_enemies_wave_2, ambush_enemies_wave_2_large );
    }
    
    level.audio.var_25e584ceb1945db6[ "ambush_wave2" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "ambush_wave2" ] thread libra_audio::combat_walla_oneshot( ambush_enemies_wave_2, "ambush_wave2", "dxx_libra_mech_bot_combat", 3, 8, 3, undefined, 800 );
}

// Namespace namespace_e6c82038bc91b78c
// Params 0
// Checksum 0x98e845c4, Offset: 0xedb
// Size: 0xbe
function ambush_wave_2_end()
{
    level endon( #"flag_ambush_done" );
    level endon( #"flag_ambush_wave_3" );
    level utility::flag_wait( "flag_ambush_wave_2_end" );
    ambush_enemies_wave_2_end = ai_spawn_director::array_spawn_targetname( "ambush_enemies_wave_2_end" );
    
    if ( level.is_squad_size_small == 0 )
    {
        ambush_enemies_wave_2_end_large = ai_spawn_director::array_spawn_targetname( "ambush_enemies_wave_2_end_large" );
        ambush_enemies_wave_2_end = arraycombine( ambush_enemies_wave_2_end, ambush_enemies_wave_2_end_large );
    }
    
    level.audio.var_25e584ceb1945db6[ "ambush_wave2_end" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "ambush_wave2_end" ] thread libra_audio::combat_walla_oneshot( ambush_enemies_wave_2_end, "ambush_wave2_end", "dxx_libra_mech_bot_combat", 3, 8, 3, undefined, 800 );
}

// Namespace namespace_e6c82038bc91b78c
// Params 0
// Checksum 0xb9cb0447, Offset: 0xfa1
// Size: 0x9c
function ambush_wave_central()
{
    level endon( #"flag_ambush_done" );
    level endon( #"flag_ambush_wave_4" );
    level utility::flag_wait( "flag_ambush_wave_central" );
    ambush_enemies_wave_central = ai_spawn_director::array_spawn_targetname( "ambush_enemies_wave_central" );
    
    if ( level.is_squad_size_small == 0 )
    {
    }
    
    level.audio.var_25e584ceb1945db6[ "ambush_wave_central" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "ambush_wave_central" ] thread libra_audio::combat_walla_oneshot( ambush_enemies_wave_central, "ambush_wave_central", "dxx_libra_cradled_soldier_combat", 3, 8, 3 );
}

// Namespace namespace_e6c82038bc91b78c
// Params 0
// Checksum 0xcd012be1, Offset: 0x1045
// Size: 0x9c
function ambush_wave_central_end()
{
    level endon( #"flag_ambush_done" );
    level endon( #"flag_ambush_wave_4" );
    level utility::flag_wait( "flag_ambush_wave_central_end" );
    ambush_enemies_wave_central_end = ai_spawn_director::array_spawn_targetname( "ambush_enemies_wave_central_end" );
    
    if ( level.is_squad_size_small == 0 )
    {
    }
    
    level.audio.var_25e584ceb1945db6[ "ambush_wave_central_end" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "ambush_wave_central_end" ] thread libra_audio::combat_walla_oneshot( ambush_enemies_wave_central_end, "ambush_wave_central_end", "dxx_libra_cradled_soldier_combat", 3, 8, 3 );
}

// Namespace namespace_e6c82038bc91b78c
// Params 0
// Checksum 0x8a0b84dd, Offset: 0x10e9
// Size: 0x21
function enable_ambush_wave_3()
{
    level utility::flag_wait_any( "flag_ambush_wave_2_end", "flag_ambush_wave_central_end" );
    level utility::flag_set( "flag_enable_ambush_wave_3" );
}

// Namespace namespace_e6c82038bc91b78c
// Params 0
// Checksum 0x96359fd, Offset: 0x1112
// Size: 0xba
function ambush_wave_3()
{
    level endon( #"flag_ambush_done" );
    level endon( #"flag_ambush_wave_4" );
    level utility::flag_wait( "flag_ambush_wave_3" );
    ambush_enemies_wave_3 = ai_spawn_director::array_spawn_targetname( "ambush_enemies_wave_3" );
    
    if ( level.is_squad_size_small == 0 )
    {
        ambush_enemies_wave_3_large = ai_spawn_director::array_spawn_targetname( "ambush_enemies_wave_3_large" );
        ambush_enemies_wave_3 = arraycombine( ambush_enemies_wave_3, ambush_enemies_wave_3_large );
    }
    
    level.audio.var_25e584ceb1945db6[ "ambush_wave_3" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "ambush_wave_3" ] thread libra_audio::combat_walla_oneshot( ambush_enemies_wave_3, "ambush_wave_3", "dxx_libra_cradled_soldier_combat", 3, 8, 3 );
}

// Namespace namespace_e6c82038bc91b78c
// Params 0
// Checksum 0xbb68ecf4, Offset: 0x11d4
// Size: 0x90
function ambush_wave_4()
{
    level endon( #"flag_ambush_done" );
    level utility::flag_wait( "flag_ambush_wave_4" );
    ambush_enemies_wave_4 = ai_spawn_director::array_spawn_targetname( "ambush_enemies_wave_4" );
    
    if ( level.is_squad_size_small == 0 )
    {
    }
    
    level.audio.var_25e584ceb1945db6[ "ambush_wave_4" ] = spawnstruct();
    level.audio.var_25e584ceb1945db6[ "ambush_wave_4" ] thread libra_audio::combat_walla_oneshot( ambush_enemies_wave_4, "ambush_wave_4", "dxx_libra_mech_bot_combat", 3, 8, 3 );
}

// Namespace namespace_e6c82038bc91b78c
// Params 0
// Checksum 0xd7bab678, Offset: 0x126c
// Size: 0x37
function ambush_guild_bot_spawn_func()
{
    agent = self;
    
    if ( isdefined( agent ) && issubstr( agent.classname, "guild_bot" ) )
    {
        agent mp_sat_ob_libra_util::function_90c440460dba0ba2( 0 );
    }
}

// Namespace namespace_e6c82038bc91b78c
// Params 0
// Checksum 0x39df88ca, Offset: 0x12ab
// Size: 0x1c
function setup_force_fields()
{
    mp_sat_ob_libra_util::function_7e4765db24e0ee73( "off", "ambush_ff_01", #targetname );
}

// Namespace namespace_e6c82038bc91b78c
// Params 0
// Checksum 0xf785d21d, Offset: 0x12cf
// Size: 0x27
function ambush_fans()
{
    level thread mp_sat_ob_libra_util::function_32b80bf22f39a811( "utility_fan", "roll", 2, "start_processing", %"electronics_fan_box_lg_01_blade" );
}

// Namespace namespace_e6c82038bc91b78c
// Params 0
// Checksum 0x9f739361, Offset: 0x12fe
// Size: 0x99
function setup_guild_bots()
{
    if ( !isdefined( level.var_c0ee7b6e1e1f71c6 ) )
    {
        level.var_c0ee7b6e1e1f71c6 = [];
    }
    
    level.var_c0ee7b6e1e1f71c6[ "ambush_bots" ] = [];
    mp_sat_ob_libra_util::function_c8c6f25fb6f7f1d4( "ambush_guild_bot_ground_spawner_group_01a", "flag_ambush_first_ff_disabled", 1, "flag_all_ambush_scene_guild_bots_dead", "ambush_bots" );
    mp_sat_ob_libra_util::function_c8c6f25fb6f7f1d4( "ambush_guild_bot_ground_spawner_group_02a", "flag_ambush_wave_2", 1, "flag_all_ambush_scene_guild_bots_dead", "ambush_bots" );
    
    if ( level.players.size > 2 )
    {
        mp_sat_ob_libra_util::function_c8c6f25fb6f7f1d4( "ambush_guild_bot_ground_spawner_group_01b", "flag_ambush_first_ff_disabled", 2, "flag_all_ambush_scene_guild_bots_dead", "ambush_bots" );
    }
}

// Namespace namespace_e6c82038bc91b78c
// Params 0
// Checksum 0x671c69b7, Offset: 0x139f
// Size: 0x90
function ambush_gas()
{
    level utility::flag_wait( "flag_activate_ambush_gas" );
    utility::exploder( "libra_ambush_cradle_entry_spray" );
    thread libra_audio::ambush_intro_walla();
    playsoundatpos( ( 3855, -5148, 1181 ), "evt_ambush_cradle_gas_start" );
    wait 3;
    utility::exploder( "libra_ambush_cradle_entry" );
    wait 2;
    level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "medium", undefined, undefined, undefined, undefined, undefined, 1 );
    wait 8;
    utility::stop_exploder( "libra_ambush_cradle_entry_spray" );
    level utility::flag_wait( "start_processing" );
    utility::stop_exploder( "libra_ambush_cradle_entry" );
}

// Namespace namespace_e6c82038bc91b78c
// Params 0
// Checksum 0x3a814f5f, Offset: 0x1437
// Size: 0x4a
function ambush_final_ff_bad_place()
{
    ambush_final_ff_bad_place_volume = getent( "ambush_final_ff_bad_place_volume", "targetname" );
    
    if ( ambush_final_ff_bad_place_volume )
    {
        ambush_final_ff_bad_place = createnavbadplacebyent( ambush_final_ff_bad_place_volume, "omega" );
    }
    
    level utility::flag_wait( "start_processing" );
    destroynavobstacle( ambush_final_ff_bad_place );
}

