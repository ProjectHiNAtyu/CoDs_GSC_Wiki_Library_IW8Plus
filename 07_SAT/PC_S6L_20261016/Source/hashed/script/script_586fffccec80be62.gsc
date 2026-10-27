// script_586fffccec80be62  (hash_586fffccec80be62.gscc) (size: 20121 Bytes / 0x4e99 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1c8a5687 (478828167)
// size ...... 20121 (0x4e99)
// includes .. 16  (offset: 0x4761)
// strings ... 111 (offset: 0x47e1)
// dev strs .. 1   (offset: 0x4e8d)
// exports ... 40  (offset: 0x318d)
// cseg ...... 0x923 + 0x286a (0x318d)
// imports ... 119 (offset: 0x37cd)
// animtree1 . 0   (offset: 0x4e99)
// animtree2 . 0   (offset: 0x4e99)
#using script_34b50456e3922412;
#using script_636bd827a012af12;
#using script_66878054d141dbc0;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\aitypes\shared\zombie\zombie_toxic_gas;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\chyron;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\mp_agent;
#using scripts\mp\ob\systems\ob_item_select;

#namespace namespace_602eac590c396927;

/#

    // Namespace namespace_602eac590c396927
    // Params 0
    // Checksum 0xc8006679, Offset: 0x941
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_602eac590c396927
// Params 0, eflags: 0x5
// Checksum 0x9a6af819, Offset: 0x94e
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_3982de3bfbc906de", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_602eac590c396927
// Params 0, eflags: 0x4
// Checksum 0x1b54716b, Offset: 0x977
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_VIRGO_NM_JPN";
    activity_common::registeractivitytype( "OB_VIRGO_NM_JPN", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_NM_JPN", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_NM_JPN", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_NM_JPN", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_VIRGO_NM_JPN" );
}

// Namespace namespace_602eac590c396927
// Params 0
// Checksum 0x80402106, Offset: 0x9ee
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance nightmare_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_602eac590c396927
// Params 0
// Checksum 0xf20b5933, Offset: 0xa53
// Size: 0x5f
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    level.request_ids = [];
    
    if ( !ob::nightmare() )
    {
        activity_instance waittill( #"hash_1e9bc5e84aa89155" );
    }
    
    activity_instance thread nightmare_main();
}

// Namespace namespace_602eac590c396927
// Params 0
// Checksum 0x5537fd86, Offset: 0xaba
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_602eac590c396927
// Params 1
// Checksum 0xa0017661, Offset: 0xade
// Size: 0x9f
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    
    foreach ( player in player_list )
    {
        activity_instance thread player_setup( player );
    }
}

/#

    // Namespace namespace_602eac590c396927
    // Params 0
    // Checksum 0x8fbac269, Offset: 0xb85
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_602eac590c396927
// Params 1
// Checksum 0xe4f3e4d, Offset: 0xb92
// Size: 0xc
function player_setup( player )
{
    
}

// Namespace namespace_602eac590c396927
// Params 0
// Checksum 0xb9705786, Offset: 0xba6
// Size: 0x2
function nightmare_start()
{
    
}

// Namespace namespace_602eac590c396927
// Params 0
// Checksum 0xfa4c7776, Offset: 0xbb0
// Size: 0x23
function setup_cradle_audio()
{
    if ( !isdefined( level.audio ) )
    {
        level.audio = spawnstruct();
    }
    
    level thread namespace_a350a26c6d662a6a::function_be0e9dd8c09bbe32();
}

// Namespace namespace_602eac590c396927
// Params 0
// Checksum 0xda789bc6, Offset: 0xbdb
// Size: 0x3e0
function nightmare_main()
{
    activity_instance = self;
    level.var_bd2748e149a8024b = self;
    level.nm_activity_instance = self;
    level.nm_activity_name = "OB_VIRGO_NM_JPN";
    setup_cradle_audio();
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    thread ob_nm_mode::watch_solo_player();
    level thread ob_nm_mode::function_7e4765db24e0ee73( "on", "jpn_wall_start", #targetname );
    case_struct = utility::getstruct( "nm_jpn_case", "targetname" );
    
    if ( isdefined( case_struct ) )
    {
        level thread ob_item_select::function_95f9ecc2af4693f6( case_struct.origin, "super_vision_pulse", "super_active_camo", #"default" );
    }
    
    level thread ob_story_mission_utils::function_e6799e9a19df2365( "nm_jpn_cache", %"itemspawnlist:ob_sat_items_equipment", 2 );
    
    if ( level.players.size > 2 )
    {
        var_83fb2972126d7a2 = 2;
    }
    
    if ( level.players.size <= 2 )
    {
        var_83fb2972126d7a2 = 3;
    }
    
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "struct_nm_medkit_driveway", "flag_nm_barge_complete", 1, undefined, undefined, undefined, var_83fb2972126d7a2 );
    chyron::function_d41002779543c80e( undefined, 0.01, 0.01 );
    gate = getent( "japan_garden_gate", "targetname" );
    
    if ( isdefined( gate ) )
    {
        gate delete();
    }
    
    gate_clip = getent( "script_brush_japan_fight", "targetname" );
    
    if ( isdefined( gate_clip ) )
    {
        gate_clip delete();
    }
    
    forkl = getent( "jpn_parking_forklift", "targetname" );
    
    if ( isdefined( forkl ) )
    {
        forkl delete();
    }
    
    trucks = getentarray( "virgo_jpn_trucks", "targetname" );
    trucks_clips = getentarray( "virgo_jpn_trucks_clips", "targetname" );
    
    foreach ( clip in trucks_clips )
    {
        if ( isdefined( clip ) )
        {
            clip connectpaths();
            waitframe();
            clip delete();
        }
    }
    
    foreach ( truck in trucks )
    {
        if ( isdefined( truck ) )
        {
            truck delete();
        }
    }
    
    level.abom_trigger = getent( "nm_abom_trigger", "targetname" );
    
    if ( isdefined( level.abom_trigger ) )
    {
        level.abom_trigger utility::trigger_off();
    }
    
    level thread function_b8ca9865f3e5c31b();
    level thread function_eb093890f173a38b();
    function_374817da884d7814( undefined, "nm_overlord_glich_start" );
    function_a25acb62ddab20e2( "nm_minion_zombie", 1 );
    function_da16d9dabe0dfe13( "jpn_nm_activity", %"hash_3bf31e4ce3a428b6" );
    wait 4.5;
    thread button_press_func();
    ob_gametype_story_mission::function_b69ee4ccc5e7a2ae( "OB_VIRGO_NM_JPN_ABOM" );
    level utility::exploder( "fx_freeway_crashsite_bc" );
    level utility::exploder( "fx_freeway_crashsite" );
    level utility::exploder( "fx_drone_crash" );
    function_22718d0054fdad84( "nm_jpb_abom_struct", "sat_spawner_zombie_abom_toxic_hvt_ob", "jpn_nm_boss", undefined, %"hash_3bf31d4ce3a42703", "nm_jpn_circle_struct" );
    function_a25acb62ddab20e2( "nm_minion_zombie", 0 );
    function_a25acb62ddab20e2( "nm_minion_zombie_2", 0 );
    ob_nm_mode::nightmare_teleport( "OB_VIRGO_NM_LA" );
    level utility::flag_set( "flag_nm_jpn_complete" );
    level thread ob_nm_mode::function_5dd43e7cb0682d57( "nm_jpb_abom_struct", "OB_VIRGO_NM_LA" );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_602eac590c396927
// Params 0
// Checksum 0x4c63c939, Offset: 0xfc3
// Size: 0xf8
function function_b8ca9865f3e5c31b()
{
    target = utility::getstruct( "starting_gen_spawn", "targetname" );
    array = getentarray( "jpn_start_gen", "targetname" );
    
    if ( isdefined( target ) )
    {
        gen = function_47c86977a18df38b( array, target.origin );
        obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( gen.origin, 24 );
    }
    
    level utility::flag_wait( "start_power_hunt_nm" );
    
    if ( isdefined( gen ) )
    {
        ob_story_mission_utils::objective_marker_clear( obj_id );
        playfx( level._effect[ "enemy_vfx" ], gen.origin + ( 0, 0, 32 ) );
        gen delete();
    }
    
    clip = getent( "nm_jpn_start_clip", "targetname" );
    
    if ( isdefined( clip ) )
    {
        clip delete();
    }
    
    if ( isdefined( target ) )
    {
        thread function_63f351724bc5b16a( target );
    }
}

// Namespace namespace_602eac590c396927
// Params 2
// Checksum 0x19068a82, Offset: 0x10c3
// Size: 0x6d
function function_374817da884d7814( timer = 20, ref )
{
    if ( isdefined( ref ) )
    {
        ob_nm_mode::function_70467d6be224da52( ref );
    }
    
    ob_nm_mode::nightmare_splash( "nm_sector_start" );
    ob_story_mission_utils::objective_text_show( %"hash_5d225874b0380a76" );
    utility::flag_wait_or_timeout( "start_power_hunt_nm", timer );
    ob_story_mission_utils::function_94bd9141862a4ba6( level.players );
    wait 0.5;
}

// Namespace namespace_602eac590c396927
// Params 0
// Checksum 0x342b70ea, Offset: 0x1138
// Size: 0x5d
function function_eb093890f173a38b()
{
    clip = getent( "clip_garden_door", "targetname" );
    scene_struct = utility::getstruct( "script_struct_puzzle_door", "targetname" );
    
    if ( isdefined( scene_struct ) )
    {
        scene_struct thread scene::play( undefined, "exit", "scene_sat_virgo_puzzle_doors" );
    }
    
    if ( isdefined( clip ) )
    {
        clip delete();
    }
}

// Namespace namespace_602eac590c396927
// Params 0
// Checksum 0x84a113ea, Offset: 0x119d
// Size: 0x82
function button_press_func()
{
    button = getent( "nm_boss_button", "targetname" );
    button_struct = utility::getstruct( "nm_boss_button_struct", "targetname" );
    
    if ( !isdefined( button ) || !isdefined( button_struct ) )
    {
        utility::flag_set( "abom_released" );
        return;
    }
    
    obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( button.origin );
    utility::flag_wait( "abom_released" );
    ob_story_mission_utils::objective_marker_clear( obj_id );
}

// Namespace namespace_602eac590c396927
// Params 1
// Checksum 0x6b3ead08, Offset: 0x1227
// Size: 0x18
function button_interact_callback( player )
{
    utility::flag_set( "abom_released" );
}

// Namespace namespace_602eac590c396927
// Params 6
// Checksum 0xaa75b4de, Offset: 0x1247
// Size: 0x424
function function_22718d0054fdad84( var_e04c0425c57a325, main_boss = "sat_spawner_zombie_mimic_ob", minion_encounter_name, spawn_minions = 1, objective_asset, var_fcb964ac6f23a112 )
{
    ob_nm_mode::start_of_round_fanfare( "nm_overlord_boss_start", "nm_miniboss_start" );
    var_e04c0425c57a325 = utility::getstructarray( var_e04c0425c57a325, "targetname" );
    var_fcb964ac6f23a112 = utility::getstruct( var_fcb964ac6f23a112, "targetname" );
    level utility::flag_clear( "nightmare_encouter_done" );
    obj = objective_asset ?? %"hash_58ceb76ce380e3be";
    ob_story_mission_utils::objective_text_show( obj );
    time_modifier = ob_nm_mode::function_3fc7f1f10018b737( 360 );
    ob_story_mission_utils::objective_timer_update( time_modifier );
    level thread ob_nm_mode::wave_fail_timer( time_modifier );
    waitframe();
    
    if ( isdefined( level.abom_trigger ) )
    {
        level.abom_trigger utility::trigger_on();
    }
    
    wait 1;
    
    if ( isdefined( var_fcb964ac6f23a112 ) )
    {
        circle_move_time = 10;
        var_9a7b20e173174021 = 6000;
        radius = 800;
        circle = ob_nm_mode::function_21689e5c8bddd87c( var_fcb964ac6f23a112.origin, var_9a7b20e173174021 );
        circle brcirclemoveto( var_fcb964ac6f23a112.origin[ 0 ], var_fcb964ac6f23a112.origin[ 1 ], radius, circle_move_time );
        level thread ob_nm_mode::update_minimap_circle( circle, var_fcb964ac6f23a112.origin, var_fcb964ac6f23a112.origin, var_9a7b20e173174021, radius, circle_move_time );
    }
    
    utility::flag_wait( "abom_released" );
    function_c6ab690d8fd83913();
    result = level.abom_scaler;
    
    if ( !isdefined( result ) )
    {
        result = 1;
    }
    
    team = "team_two_hundred";
    spawn_pos = getclosestpointonnavmesh( var_e04c0425c57a325[ 0 ].origin );
    playfx( level._effect[ "enemy_vfx" ], spawn_pos + ( 0, 0, 32 ) );
    abom_boss = mp_agent::spawnnewagentaitype( main_boss, spawn_pos, var_e04c0425c57a325[ 0 ].angles, team );
    abom_boss ob_nm_mode::set_boss_health( result );
    abom_boss.var_be5ccf6d16f6b59e = 1;
    level.abom_health = abom_boss.health;
    abom_boss thread abom_boss_behavior();
    abom_boss.healthbarsettingsid = function_43b5ed5a14a56573( #"scriptbundle_healthbarsettings", %"hash_1479331fab8bab62" );
    abom_boss.var_24954f14e27b448d = 1;
    abom_boss hudoutlineenable( "outline_depth_red" );
    abom_boss zombie_utils::function_a8ce00e0448cb6f0( "sprint", "aitype_default", 0 );
    abom_boss enabletraversals( 0 );
    thread ob_nm_mode::miniboss_objective( abom_boss );
    abom_boss thread force_bull_charge();
    level.abom_boss = abom_boss;
    walls = getentarray( "nm_jpn_container_cradle_wall", "script_noteworthy" );
    
    foreach ( wall in walls )
    {
        if ( isdefined( wall ) )
        {
            wall delete();
        }
    }
    
    level utility::flag_set( "nightmare_encouter_active" );
    
    if ( spawn_minions )
    {
        level.enemy_count_array = [ 3, 6, 8, 10 ];
        thread ob_nm_mode::minion_encounter( minion_encounter_name, "nightmare_encouter_done" );
    }
    
    abom_boss waittill( #"death" );
    
    if ( isdefined( circle ) )
    {
        if ( isdefined( circle.mapcircle ) )
        {
            circle game_utility::questcircle_delete();
        }
        
        circle delete();
    }
    
    level notify( #"cleanup_minions" );
    level notify( #"hash_aefc5c470125baf8" );
    level utility::flag_clear( "nightmare_encouter_active" );
    level utility::flag_set( "nightmare_encouter_done" );
    level notify( #"stop_circle" );
    self.var_9be376218db54aba = undefined;
    ob_nm_mode::end_of_round_fanfare( "nm_overlord_boss_dead" );
}

// Namespace namespace_602eac590c396927
// Params 0
// Checksum 0x552434ca, Offset: 0x1673
// Size: 0xcb
function abom_boss_behavior()
{
    self endon( #"death" );
    phases = 4;
    thread function_faf6dde69b942000( phases );
    thread function_a87505e13f037c4f();
    
    while ( true )
    {
        self waittill( #"abom_stage" );
        
        switch ( level.abom_current_phase )
        {
            case 1:
                thread function_83513074a5553505( phases );
                break;
            case 2:
                thread function_83512d74a5552e6c( phases );
                break;
            case 3:
                thread function_83512e74a555309f( phases );
                break;
            case 4:
                wait 1;
                break;
            default:
                wait 1;
                break;
        }
        
        /#
            iprintln( "<dev string:x24>" );
        #/
    }
}

// Namespace namespace_602eac590c396927
// Params 1
// Checksum 0x65e6c15f, Offset: 0x1746
// Size: 0xac
function function_faf6dde69b942000( num_phases = 4 )
{
    abom_boss = self;
    abom_boss endon( #"death" );
    var_bf1316595b384341 = abom_boss.health;
    var_abbebdb114e4f57f = 1;
    
    while ( isalive( abom_boss ) )
    {
        while ( var_abbebdb114e4f57f < num_phases + 1 )
        {
            health_threshold = var_bf1316595b384341 - var_bf1316595b384341 / num_phases * var_abbebdb114e4f57f;
            
            while ( abom_boss.health > health_threshold )
            {
                waitframe();
            }
            
            level.abom_current_phase = var_abbebdb114e4f57f;
            abom_boss notify( #"abom_stage" );
            var_abbebdb114e4f57f++;
        }
    }
}

// Namespace namespace_602eac590c396927
// Params 1
// Checksum 0xf8adee00, Offset: 0x17fa
// Size: 0x6a
function function_83513074a5553505( num_phases )
{
    abom_boss = self;
    abom_boss endon( #"death" );
    
    while ( level.abom_current_phase == 1 )
    {
        zombie_toxic_gas::spawn_toxic_gas( abom_boss, abom_boss.origin, ( 0, 0, 0 ), "from_zombie_base_toxic", 20, 64, 32, undefined, 1 );
        wait 5;
    }
}

// Namespace namespace_602eac590c396927
// Params 1
// Checksum 0xb41a1ccd, Offset: 0x186c
// Size: 0xa3
function function_83512d74a5552e6c( num_phases )
{
    abom_boss = self;
    abom_boss endon( #"death" );
    function_a25acb62ddab20e2( "nm_minion_zombie_2", 1 );
    level.enemy_count_array = [ 8, 12, 16, 20 ];
    ob_nm_mode::update_ai_count( 0 );
    
    while ( level.abom_current_phase == 2 )
    {
        zombie_toxic_gas::spawn_toxic_gas( abom_boss, abom_boss.origin, ( 0, 0, 0 ), "from_zombie_base_toxic", 20, 64, 32, undefined, 1 );
        wait 2.5;
    }
}

// Namespace namespace_602eac590c396927
// Params 1
// Checksum 0x9c432fbe, Offset: 0x1917
// Size: 0x8c
function function_83512e74a555309f( num_phases )
{
    abom_boss = self;
    abom_boss endon( #"death" );
    abom_boss.var_4bce31da81afb507 = 50;
    abom_boss zombie_utils::function_a8ce00e0448cb6f0( "super_sprint", "super_sprint_fight", 0 );
    
    while ( level.abom_current_phase == 3 )
    {
        zombie_toxic_gas::spawn_toxic_gas( abom_boss, abom_boss.origin, ( 0, 0, 0 ), "from_zombie_base_toxic", 20, 64, 32, undefined, 1 );
        wait 2;
    }
}

// Namespace namespace_602eac590c396927
// Params 0
// Checksum 0xf9acd33c, Offset: 0x19ab
// Size: 0x61
function function_a87505e13f037c4f()
{
    abom_boss = self;
    abom_boss endon( #"death" );
    
    while ( isalive( abom_boss ) )
    {
        self waittill( #"bull_charge_loop_end" );
        zombie_toxic_gas::spawn_toxic_gas( abom_boss, abom_boss.origin, ( 0, 0, 0 ), "from_zombie_base_toxic", 10, 64, 32 );
    }
}

// Namespace namespace_602eac590c396927
// Params 0, eflags: 0x4
// Checksum 0x8950cf86, Offset: 0x1a14
// Size: 0x37
function private force_bull_charge()
{
    Abom = self;
    wait 1;
    
    if ( !isdefined( Abom ) )
    {
        return;
    }
    
    Abom function_786bb6aa1b76c7ee( "roar_end_time", 4000 );
    Abom function_786bb6aa1b76c7ee( "in_bull_charge", 1 );
}

// Namespace namespace_602eac590c396927
// Params 2
// Checksum 0x92e53d78, Offset: 0x1a53
// Size: 0x260
function function_da16d9dabe0dfe13( minion_encounter_name, objective_asset )
{
    ob_nm_mode::start_of_round_fanfare( undefined, "nm_power_supply_start" );
    obj = objective_asset ?? %"hash_6531ee359f17a7aa";
    ob_story_mission_utils::objective_text_show( obj );
    time_modifier = ob_nm_mode::function_3fc7f1f10018b737( 220 );
    ob_story_mission_utils::objective_timer_update( time_modifier );
    level thread ob_nm_mode::wave_fail_timer( time_modifier );
    waitframe();
    level utility::flag_set( "nightmare_encouter_active" );
    level utility::flag_set( "power_hunt_event" );
    level utility::flag_wait( "start_power_hunt_nm" );
    level.enemy_count_array = [ 2, 4, 6, 8 ];
    thread ob_nm_mode::minion_encounter( minion_encounter_name, "flag_flowers_killed", undefined, 3 );
    function_40d1c996d99ab6b( "garden_gen" );
    level.var_9a7facf0cbad27fd = &ob_nm_mode::function_51ac155be471a4fb;
    old_struct = level.nm_respawn_struct;
    level.nm_respawn_struct = utility::getstruct( "nm_jpn_spawn_1_struct", "targetname" );
    
    if ( !isdefined( level.nm_respawn_struct ) )
    {
        level.nm_respawn_struct = old_struct;
    }
    
    obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( ( 43138, -45514, 438 ) );
    function_a2c0cfb8e8fbf2b1( "hut_gen" );
    ob_story_mission_utils::objective_marker_clear( obj_id );
    old_struct = level.nm_respawn_struct;
    struct = spawnstruct();
    struct.origin = ( 43128, -44364, 96 );
    struct.angles = ( 0, 90, 0 );
    level.nm_respawn_struct = struct;
    
    if ( !isdefined( level.nm_respawn_struct ) )
    {
        level.nm_respawn_struct = old_struct;
    }
    
    obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( ( 43222, -43896, 438 ) );
    function_990acb141ee3ca1( "parking_gen" );
    ob_story_mission_utils::objective_marker_clear( obj_id );
    level.enemy_count_array = [ 8, 12, 16, 20 ];
    level notify( #"cleanup_minions" );
    level thread function_6488d9399373bcac();
    level utility::flag_clear( "nightmare_encouter_active" );
    level utility::flag_set( "flag_flowers_killed" );
    level notify( #"hash_aefc5c470125baf8" );
    level notify( #"stop_circle" );
    ob_nm_mode::end_of_round_fanfare( undefined, "nm_power_supply_end" );
}

// Namespace namespace_602eac590c396927
// Params 0
// Checksum 0x864d7343, Offset: 0x1cbb
// Size: 0xa9
function function_6488d9399373bcac()
{
    if ( isdefined( level.gen_zombies ) )
    {
        level.gen_zombies = utility::array_removedead_or_dying( level.gen_zombies );
        
        foreach ( agent in level.gen_zombies )
        {
            if ( isalive( agent ) )
            {
                agent thread function_2ef3f21c0f62e537();
            }
        }
    }
}

// Namespace namespace_602eac590c396927
// Params 0
// Checksum 0x132de447, Offset: 0x1d6c
// Size: 0x44
function function_2ef3f21c0f62e537()
{
    agent = self;
    wait randomfloatrange( 0.1, 0.3 );
    playfx( level._effect[ "enemy_vfx" ], agent.origin );
    agent kill();
}

// Namespace namespace_602eac590c396927
// Params 1
// Checksum 0x25db0f92, Offset: 0x1db8
// Size: 0xc6
function function_e62b0511fe001bd5( color = "outline_depth_cyan" )
{
    flowers = [];
    flowers[ flowers.size ] = "garden_flower_a";
    flowers[ flowers.size ] = "garden_flower_b";
    flowers[ flowers.size ] = "garden_flower_c";
    flowers[ flowers.size ] = "garden_flower_d";
    level.var_6d9a23107f9757f4 = 0;
    level.var_3bc8f455e56fda5 = flowers.size;
    ob_story_mission_utils::function_315d79883d962ba7( level.var_6d9a23107f9757f4, level.var_3bc8f455e56fda5 );
    
    for ( i = 0; i < flowers.size ; i++ )
    {
        thread ob_nm_mode::flower_logic( flowers[ i ], color, "team_two_hundred" );
    }
    
    while ( level.var_6d9a23107f9757f4 < flowers.size )
    {
        wait 0.5;
    }
    
    wait 1;
}

// Namespace namespace_602eac590c396927
// Params 1
// Checksum 0xa56225c8, Offset: 0x1e86
// Size: 0xc6
function function_48f924397b3708d3( color = "outline_depth_cyan" )
{
    flowers = [];
    flowers[ flowers.size ] = "botanical_flower_a";
    flowers[ flowers.size ] = "botanical_flower_b";
    flowers[ flowers.size ] = "botanical_flower_c";
    flowers[ flowers.size ] = "botanical_flower_d";
    level.var_6d9a23107f9757f4 = 0;
    level.var_3bc8f455e56fda5 = flowers.size;
    ob_story_mission_utils::function_315d79883d962ba7( level.var_6d9a23107f9757f4, level.var_3bc8f455e56fda5 );
    
    for ( i = 0; i < flowers.size ; i++ )
    {
        thread ob_nm_mode::flower_logic( flowers[ i ], color, "team_two_hundred" );
    }
    
    while ( level.var_6d9a23107f9757f4 < flowers.size )
    {
        wait 0.5;
    }
    
    wait 1;
}

// Namespace namespace_602eac590c396927
// Params 1
// Checksum 0x5c1a1593, Offset: 0x1f54
// Size: 0xd9
function function_9e3992118b0e403( color = "outline_depth_cyan" )
{
    flowers = [];
    flowers[ flowers.size ] = "driveway_flower_a";
    flowers[ flowers.size ] = "driveway_flower_b";
    flowers[ flowers.size ] = "driveway_flower_c";
    flowers[ flowers.size ] = "driveway_flower_d";
    flowers[ flowers.size ] = "driveway_flower_e";
    flowers[ flowers.size ] = "driveway_flower_f";
    level.var_6d9a23107f9757f4 = 0;
    level.var_3bc8f455e56fda5 = flowers.size;
    ob_story_mission_utils::function_315d79883d962ba7( level.var_6d9a23107f9757f4, level.var_3bc8f455e56fda5 );
    
    for ( i = 0; i < flowers.size ; i++ )
    {
        thread ob_nm_mode::flower_logic( flowers[ i ], color, "team_two_hundred" );
    }
    
    while ( level.var_6d9a23107f9757f4 < flowers.size )
    {
        wait 0.5;
    }
}

// Namespace namespace_602eac590c396927
// Params 1
// Checksum 0xfd066405, Offset: 0x2035
// Size: 0x3c3
function function_40d1c996d99ab6b( targetname )
{
    level thread ob_nm_mode::function_7e4765db24e0ee73( "on", "jpn_wall_1", #targetname );
    var_c1f2d13891715df0 = [];
    var_c1f2d13891715df0[ var_c1f2d13891715df0.size ] = "garden_gen_a";
    var_c1f2d13891715df0[ var_c1f2d13891715df0.size ] = "garden_gen_b";
    var_c1f2d13891715df0[ var_c1f2d13891715df0.size ] = "garden_gen_c";
    var_c1f2d13891715df0[ var_c1f2d13891715df0.size ] = "garden_gen_d";
    var_c1f2d13891715df0[ var_c1f2d13891715df0.size ] = "garden_gen_e";
    level.var_a2d0cc6cadd7d1db = 0;
    level.var_6e14f7906bf9e064 = var_c1f2d13891715df0.size;
    ob_story_mission_utils::function_315d79883d962ba7( level.var_a2d0cc6cadd7d1db, level.var_6e14f7906bf9e064 );
    garden_gen = getscriptablearray( targetname, #targetname );
    models = getentarray( targetname, "targetname" );
    model_clips = getentarray( "nm_gen_clip", "targetname" );
    models = arrayremove( models, garden_gen );
    result = function_bada281df76923db( garden_gen, models, 6 );
    garden_gen = result.gens;
    models = result.models;
    model_clips = result.clips;
    
    foreach ( model in models )
    {
        if ( isdefined( model ) )
        {
            level utility::callsharedfunc( #"vision_pulse", #"hash_73baeda3c430f3b3", model );
        }
    }
    
    while ( level.var_a2d0cc6cadd7d1db < var_c1f2d13891715df0.size )
    {
        foreach ( g in garden_gen )
        {
            if ( g getscriptablepartstate( "force_field_power_supply", 1 ) == "destroyed" && !g.destroyed )
            {
                g.destroyed = 1;
                model = function_47c86977a18df38b( models, g.origin, 128 );
                
                if ( isdefined( model ) )
                {
                    if ( isdefined( model.target ) )
                    {
                        target = utility::getstruct( model.target, "targetname" );
                    }
                    
                    level utility::callsharedfunc( #"vision_pulse", #"hash_38470c19fcaf5542", model );
                    level utility::callsharedfunc( #"vision_pulse", #"hash_ed694d536b107c46", model );
                    playfx( level._effect[ "enemy_vfx" ], model.origin + ( 0, 0, 32 ) );
                    model delete();
                }
                
                clip = function_47c86977a18df38b( model_clips, g.origin, 128 );
                
                if ( isdefined( clip ) )
                {
                    clip delete();
                }
                
                level.var_a2d0cc6cadd7d1db++;
                ob_story_mission_utils::function_315d79883d962ba7( level.var_a2d0cc6cadd7d1db, level.var_6e14f7906bf9e064 );
                thread function_63f351724bc5b16a( target );
            }
        }
        
        wait 0.5;
    }
    
    clip = getent( "nm_jpn_wall_1_clip", "targetname" );
    
    if ( isdefined( clip ) )
    {
        clip delete();
    }
    
    thread ob_nm_mode::nightmare_splash( "nm_zone_opened" );
    level thread ob_nm_mode::function_7e4765db24e0ee73( "off", "jpn_wall_1", #targetname );
    thread function_edc2f35d92ae544c( garden_gen, models, model_clips );
    wait 1;
}

// Namespace namespace_602eac590c396927
// Params 1
// Checksum 0x998c9baf, Offset: 0x2400
// Size: 0x3a6
function function_a2c0cfb8e8fbf2b1( targetname )
{
    level thread ob_nm_mode::function_7e4765db24e0ee73( "on", "jpn_wall_2", #targetname );
    var_c1f2d13891715df0 = [];
    var_c1f2d13891715df0[ var_c1f2d13891715df0.size ] = "hut_gen_a";
    var_c1f2d13891715df0[ var_c1f2d13891715df0.size ] = "hut_gen_b";
    var_c1f2d13891715df0[ var_c1f2d13891715df0.size ] = "hut_gen_c";
    var_c1f2d13891715df0[ var_c1f2d13891715df0.size ] = "hut_gen_d";
    level.var_a2d0cc6cadd7d1db = 0;
    level.var_6e14f7906bf9e064 = var_c1f2d13891715df0.size;
    ob_story_mission_utils::function_315d79883d962ba7( level.var_a2d0cc6cadd7d1db, level.var_6e14f7906bf9e064 );
    hut_gen = getscriptablearray( targetname, #targetname );
    models = getentarray( targetname, "targetname" );
    model_clips = getentarray( "nm_gen_clip", "targetname" );
    models = arrayremove( models, hut_gen );
    result = function_bada281df76923db( hut_gen, models, 5 );
    hut_gen = result.gens;
    models = result.models;
    model_clips = result.clips;
    
    foreach ( model in models )
    {
        level utility::callsharedfunc( #"vision_pulse", #"hash_73baeda3c430f3b3", model );
    }
    
    while ( level.var_a2d0cc6cadd7d1db < var_c1f2d13891715df0.size )
    {
        foreach ( g in hut_gen )
        {
            if ( g getscriptablepartstate( "force_field_power_supply", 1 ) == "destroyed" && !g.destroyed )
            {
                g.destroyed = 1;
                model = function_47c86977a18df38b( models, g.origin, 128 );
                
                if ( isdefined( model ) )
                {
                    if ( isdefined( model.target ) )
                    {
                        target = utility::getstruct( model.target, "targetname" );
                    }
                    else
                    {
                        target = getclosestpointonnavmesh( model.origin );
                    }
                    
                    level utility::callsharedfunc( #"vision_pulse", #"hash_38470c19fcaf5542", model );
                    level utility::callsharedfunc( #"vision_pulse", #"hash_ed694d536b107c46", model );
                    playfx( level._effect[ "enemy_vfx" ], model.origin + ( 0, 0, 32 ) );
                    model delete();
                }
                
                clip = function_47c86977a18df38b( model_clips, g.origin, 128 );
                
                if ( isdefined( clip ) )
                {
                    clip delete();
                }
                
                level.var_a2d0cc6cadd7d1db++;
                ob_story_mission_utils::function_315d79883d962ba7( level.var_a2d0cc6cadd7d1db, level.var_6e14f7906bf9e064 );
                thread function_63f351724bc5b16a( target );
            }
        }
        
        wait 0.5;
    }
    
    thread ob_nm_mode::nightmare_splash( "nm_zone_opened" );
    level thread ob_nm_mode::function_7e4765db24e0ee73( "off", "jpn_wall_2", #targetname );
    thread function_edc2f35d92ae544c( hut_gen, models, model_clips );
    wait 1;
}

// Namespace namespace_602eac590c396927
// Params 1
// Checksum 0xc3fa3975, Offset: 0x27ae
// Size: 0x3a6
function function_990acb141ee3ca1( targetname )
{
    level thread ob_nm_mode::function_7e4765db24e0ee73( "on", "jpn_wall_3", #targetname );
    var_c1f2d13891715df0 = [];
    var_c1f2d13891715df0[ var_c1f2d13891715df0.size ] = "parking_gen_a";
    var_c1f2d13891715df0[ var_c1f2d13891715df0.size ] = "parking_gen_b";
    var_c1f2d13891715df0[ var_c1f2d13891715df0.size ] = "parking_gen_c";
    var_c1f2d13891715df0[ var_c1f2d13891715df0.size ] = "parking_gen_d";
    var_c1f2d13891715df0[ var_c1f2d13891715df0.size ] = "parking_gen_e";
    var_c1f2d13891715df0[ var_c1f2d13891715df0.size ] = "parking_gen_f";
    level.var_a2d0cc6cadd7d1db = 0;
    level.var_6e14f7906bf9e064 = var_c1f2d13891715df0.size;
    ob_story_mission_utils::function_315d79883d962ba7( level.var_a2d0cc6cadd7d1db, level.var_6e14f7906bf9e064 );
    parking_gen = getscriptablearray( targetname, #targetname );
    models = getentarray( targetname, "targetname" );
    model_clips = getentarray( "nm_gen_clip", "targetname" );
    models = arrayremove( models, parking_gen );
    result = function_bada281df76923db( parking_gen, models, 8 );
    parking_gen = result.gens;
    models = result.models;
    model_clips = result.clips;
    
    foreach ( model in models )
    {
        level utility::callsharedfunc( #"vision_pulse", #"hash_73baeda3c430f3b3", model );
    }
    
    thread spawn_mimic_jpn();
    
    while ( level.var_a2d0cc6cadd7d1db < var_c1f2d13891715df0.size )
    {
        foreach ( g in parking_gen )
        {
            if ( g getscriptablepartstate( "force_field_power_supply", 1 ) == "destroyed" && !g.destroyed )
            {
                g.destroyed = 1;
                model = function_47c86977a18df38b( models, g.origin, 128 );
                
                if ( isdefined( model ) )
                {
                    if ( isdefined( model.target ) )
                    {
                        target = utility::getstruct( model.target, "targetname" );
                    }
                    
                    level utility::callsharedfunc( #"vision_pulse", #"hash_38470c19fcaf5542", model );
                    level utility::callsharedfunc( #"vision_pulse", #"hash_ed694d536b107c46", model );
                    playfx( level._effect[ "enemy_vfx" ], model.origin + ( 0, 0, 32 ) );
                    model delete();
                }
                
                clip = function_47c86977a18df38b( model_clips, g.origin, 128 );
                
                if ( isdefined( clip ) )
                {
                    clip delete();
                }
                
                level.var_a2d0cc6cadd7d1db++;
                ob_story_mission_utils::function_315d79883d962ba7( level.var_a2d0cc6cadd7d1db, level.var_6e14f7906bf9e064 );
                thread function_63f351724bc5b16a( target );
            }
        }
        
        wait 0.5;
    }
    
    level thread ob_nm_mode::function_7e4765db24e0ee73( "off", "jpn_wall_3", #targetname );
    thread function_edc2f35d92ae544c( parking_gen, models, model_clips );
    wait 1;
}

// Namespace namespace_602eac590c396927
// Params 1
// Checksum 0x572e912c, Offset: 0x2b5c
// Size: 0xf6
function function_63f351724bc5b16a( target )
{
    team = "team_two_hundred";
    
    if ( !isdefined( level.gen_zombies ) )
    {
        level.gen_zombies = [];
    }
    
    count = 2;
    
    for ( i = 0; i < count ; i++ )
    {
        if ( isdefined( target ) )
        {
            spawn_pos = getclosestpointonnavmesh( target.origin );
        }
        else
        {
            return;
        }
        
        playfx( level._effect[ "enemy_vfx" ], spawn_pos + ( 0, 0, 32 ) );
        zombie = mp_agent::spawnnewagentaitype( "sat_spawner_zombie_base_armored_heavy_ob", spawn_pos, ( 0, 0, 0 ), team );
        zombie zombie_utils::function_a8ce00e0448cb6f0( "super_sprint", "super_sprint_fight", 99 );
        
        if ( isdefined( zombie ) )
        {
            level.gen_zombies[ level.gen_zombies.size ] = zombie;
        }
    }
}

// Namespace namespace_602eac590c396927
// Params 0
// Checksum 0xe48388e9, Offset: 0x2c5a
// Size: 0xc0
function spawn_mimic_jpn()
{
    if ( !isdefined( level.gen_zombies ) )
    {
        level.gen_zombies = [];
    }
    
    utility::flag_wait( "spawn_jpn_mimic" );
    spawn_pos = getclosestpointonnavmesh( ( 43142, -44258, 86 ) );
    playfx( level._effect[ "enemy_vfx" ], spawn_pos + ( 0, 0, 32 ) );
    mimic = mp_agent::spawnnewagentaitype( "sat_spawner_zombie_mimic_hvt_ob", spawn_pos, ( 0, 270, 0 ), "team_two_hundred" );
    
    if ( isdefined( mimic ) )
    {
        mimic zombie_utils::function_a8ce00e0448cb6f0( "super_sprint", "super_sprint_fight", 99 );
        level.gen_zombies[ level.gen_zombies.size ] = mimic;
    }
}

// Namespace namespace_602eac590c396927
// Params 3
// Checksum 0x1288ea50, Offset: 0x2d22
// Size: 0x1c0
function function_edc2f35d92ae544c( array, highlight_array, model_clips )
{
    if ( isdefined( array ) )
    {
        foreach ( g in array )
        {
            if ( g getscriptablepartstate( "force_field_power_supply", 1 ) != "destroyed" )
            {
                g setscriptablepartstate( "force_field_power_supply", "off" );
                clip = function_47c86977a18df38b( model_clips, g.origin, 128 );
            }
            
            if ( isdefined( clip ) )
            {
                clip delete();
            }
        }
    }
    
    if ( isdefined( highlight_array ) )
    {
        foreach ( model in highlight_array )
        {
            if ( isdefined( model ) )
            {
                level utility::callsharedfunc( #"vision_pulse", #"hash_38470c19fcaf5542", model );
                level utility::callsharedfunc( #"vision_pulse", #"hash_ed694d536b107c46", model );
                wait 1;
                playfx( level._effect[ "enemy_vfx" ], model.origin + ( 0, 0, 32 ) );
                model delete();
            }
        }
    }
}

// Namespace namespace_602eac590c396927
// Params 0
// Checksum 0x6ca25037, Offset: 0x2eea
// Size: 0x91
function function_c6ab690d8fd83913()
{
    switch ( level.players.size )
    {
        case 1:
            scaler = 0.5;
            break;
        case 2:
            scaler = 0.8;
            break;
        case 3:
            scaler = 1;
            break;
        case 4:
            scaler = 1.5;
            break;
        default:
            scaler = 1;
            break;
    }
    
    level.abom_scaler = scaler;
}

// Namespace namespace_602eac590c396927
// Params 3
// Checksum 0xe7735f14, Offset: 0x2f83
// Size: 0x209
function function_bada281df76923db( gen_array, var_a266d359f9e29f8d, count )
{
    result = spawnstruct();
    model_clips = getentarray( "nm_gen_clip", "targetname" );
    
    if ( !isdefined( count ) )
    {
        count = 5;
    }
    
    remove_amount = gen_array.size - count;
    
    if ( remove_amount <= 0 )
    {
        result.gens = gen_array;
        result.models = var_a266d359f9e29f8d;
        result.clips = model_clips;
        return result;
    }
    
    removed = [];
    
    while ( removed.size < remove_amount && gen_array.size > 0 )
    {
        idx = randomint( gen_array.size );
        removed[ removed.size ] = gen_array[ idx ];
        gen_array = arrayremove( gen_array, gen_array[ idx ] );
    }
    
    foreach ( gen in removed )
    {
        model = function_47c86977a18df38b( var_a266d359f9e29f8d, gen.origin, 128 );
        
        if ( isdefined( model ) )
        {
            var_a266d359f9e29f8d = arrayremove( var_a266d359f9e29f8d, model );
            model delete();
        }
        
        if ( isdefined( gen ) )
        {
            gen_array = arrayremove( gen_array, gen );
            
            if ( gen getscriptablepartstate( "force_field_power_supply", 1 ) != "destroyed" )
            {
                gen setscriptablepartstate( "force_field_power_supply", "off" );
            }
            
            clip = function_47c86977a18df38b( model_clips, gen.origin, 128 );
            
            if ( isdefined( clip ) )
            {
                model_clips = arrayremove( model_clips, clip );
                clip delete();
            }
        }
    }
    
    result.gens = gen_array;
    result.models = var_a266d359f9e29f8d;
    result.clips = model_clips;
    return result;
}

