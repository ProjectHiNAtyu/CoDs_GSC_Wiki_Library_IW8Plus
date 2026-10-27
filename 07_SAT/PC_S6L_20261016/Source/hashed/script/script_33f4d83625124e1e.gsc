// script_33f4d83625124e1e  (hash_33f4d83625124e1e.gscc) (size: 20960 Bytes / 0x51e0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x43289b00 (1126734592)
// size ...... 20960 (0x51e0)
// includes .. 19  (offset: 0x4af8)
// strings ... 96  (offset: 0x4b90)
// dev strs .. 3   (offset: 0x51bc)
// exports ... 52  (offset: 0x2f80)
// cseg ...... 0x91d + 0x2663 (0x2f80)
// imports ... 154 (offset: 0x37a0)
// animtree1 . 0   (offset: 0x51e0)
// animtree2 . 0   (offset: 0x51e0)
#using script_16ea1b94f0f381b3;
#using script_34b50456e3922412;
#using script_4807fa09430c799f;
#using script_636bd827a012af12;
#using script_66878054d141dbc0;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\snd\snd;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\interaction;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_util;
#using scripts\mp\mp_agent;
#using scripts\mp\ob\systems\ob_item_select;
#using scripts\mp\supers;

#namespace namespace_21e60aef063ff4f3;

/#

    // Namespace namespace_21e60aef063ff4f3
    // Params 0
    // Checksum 0xc206fbad, Offset: 0x93b
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_21e60aef063ff4f3
// Params 0, eflags: 0x5
// Checksum 0xe23b765b, Offset: 0x948
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_a2a5846ea4929d1e", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_21e60aef063ff4f3
// Params 0, eflags: 0x4
// Checksum 0x1152ecbf, Offset: 0x971
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_VIRGO_NM_CARRIER";
    activity_common::registeractivitytype( "OB_VIRGO_NM_CARRIER", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_NM_CARRIER", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_NM_CARRIER", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_NM_CARRIER", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_VIRGO_NM_CARRIER" );
}

// Namespace namespace_21e60aef063ff4f3
// Params 0
// Checksum 0xa74a3484, Offset: 0x9e8
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

// Namespace namespace_21e60aef063ff4f3
// Params 0
// Checksum 0xd5014cb1, Offset: 0xa4d
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

// Namespace namespace_21e60aef063ff4f3
// Params 0
// Checksum 0x5f316052, Offset: 0xab4
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_21e60aef063ff4f3
// Params 1
// Checksum 0x870b63e3, Offset: 0xad8
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

    // Namespace namespace_21e60aef063ff4f3
    // Params 0
    // Checksum 0x85bc5fbd, Offset: 0xb7f
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_21e60aef063ff4f3
// Params 1
// Checksum 0x449a399, Offset: 0xb8c
// Size: 0xc
function player_setup( player )
{
    
}

// Namespace namespace_21e60aef063ff4f3
// Params 0
// Checksum 0xb376ca52, Offset: 0xba0
// Size: 0x2
function nightmare_start()
{
    
}

// Namespace namespace_21e60aef063ff4f3
// Params 0
// Checksum 0xdd4662f4, Offset: 0xbaa
// Size: 0x23
function setup_cradle_audio()
{
    if ( !isdefined( level.audio ) )
    {
        level.audio = spawnstruct();
    }
    
    level thread namespace_a350a26c6d662a6a::function_be0e9dd8c09bbe32();
}

// Namespace namespace_21e60aef063ff4f3
// Params 0
// Checksum 0xd0a0082b, Offset: 0xbd5
// Size: 0x229
function nightmare_main()
{
    activity_instance = self;
    level.var_bd2748e149a8024b = self;
    level.nm_activity_instance = self;
    level.nm_activity_name = "OB_VIRGO_NM_CARRIER";
    setup_cradle_audio();
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    case_struct = utility::getstruct( "nm_carrier_case", "targetname" );
    
    if ( isdefined( case_struct ) )
    {
        level thread ob_item_select::function_95f9ecc2af4693f6( case_struct.origin, "super_war_machine", "super_drone_launcher", #"default" );
    }
    
    level thread ob_story_mission_utils::function_e6799e9a19df2365( "nm_carrier_cache", %"itemspawnlist:ob_sat_items_equipment", 2 );
    
    if ( level.players.size > 2 )
    {
        var_83fb2972126d7a2 = 2;
    }
    
    if ( level.players.size <= 2 )
    {
        var_83fb2972126d7a2 = 3;
    }
    
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "struct_nm_medkit_carrier", "flag_nm_barge_complete", 1, undefined, undefined, undefined, var_83fb2972126d7a2 );
    level thread ob_virgo_util::carrier_exploders();
    utility::add_fx( "popcorn_spawn", "vfx_sat_levels_wc_lightning_strike_impact" );
    utility::add_fx( "spawn_smoke", "vfx_sat_mp_ob_gem_cradle_tornado_rot_1" );
    ob_nm_mode::function_1f2648b3b22d9816();
    level.cadence_override = 0.5;
    level.enemy_count_array = [ 7, 11, 14, 18 ];
    level.minion_kill_obj = ob_nm_mode::kill_obj_count( 45, 75, 110, 140 );
    function_a25acb62ddab20e2( "nm_minion_cradle", 1 );
    level utility::flag_set( "flag_killstreak_event" );
    function_31604c8e77a916f9( undefined, undefined, "nm_carrier_activity", %"hash_3bf3224ce3a42f82" );
    function_a25acb62ddab20e2( "nm_minion_cradle", 0 );
    ob_nm_mode::nightmare_prepare();
    level.enemy_count_array = [ 12, 16, 20, 24 ];
    level.cadence_override = 2.5;
    function_a25acb62ddab20e2( "nm_minion_zombie", 1 );
    klaus_fight( "nm_carrier_circle_struct", "nm_carrier_struct", undefined, "sat_spawner_zombie_viper_hvt_ob", undefined, "nm_carrier_boss", 1, 1 );
    level utility::flag_set( "flag_nm_carrier_complete" );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_21e60aef063ff4f3
// Params 4
// Checksum 0xb31f18e9, Offset: 0xe06
// Size: 0x1d4
function function_31604c8e77a916f9( var_db648a65d028f89c, killstreak_name, encounter_name, objective_asset )
{
    heightent = namespace_9d8e359c3b1041e5::getkillstreakairstrikeheightentsharedfunc();
    heightent.origin += ( 0, 0, -2000 );
    level utility::flag_set( "flag_killcount_event" );
    obj = objective_asset ?? %"hash_3cff3470e9aafa2b";
    time_modifier = ob_nm_mode::function_3fc7f1f10018b737( 450 );
    ob_story_mission_utils::objective_text_show( obj );
    ob_story_mission_utils::objective_timer_update( time_modifier );
    level thread ob_nm_mode::wave_fail_timer( time_modifier );
    
    if ( !isdefined( level.minions_killed ) )
    {
        level.minions_killed = 0;
    }
    
    if ( level.minion_kill_obj > 100 )
    {
        fraction = level.minions_killed / level.minion_kill_obj;
        percent = int( fraction * 100 );
        level.nm_activity_instance ob_story_mission_utils::function_315d79883d962ba7( percent, 100 );
    }
    else
    {
        level.nm_activity_instance ob_story_mission_utils::function_315d79883d962ba7( level.minions_killed, level.minion_kill_obj );
    }
    
    function_c69971d5befdd977();
    level utility::flag_clear( "flag_enable_super_sprint" );
    level.nm_activity_instance ob_story_mission_utils::function_315d79883d962ba7( 100, 100 );
    level notify( #"hash_df6d926e73c18e9f" );
    level utility::flag_set( "flag_disable_ks_tablets" );
    level utility::flag_set( "flag_stop_all_capture_zones" );
    wait 0.5;
    level utility::flag_clear( "flag_multi_capture_event" );
    level utility::flag_set( "flag_killstreak_frenzy_complete" );
    level utility::flag_clear( "flag_killcount_event" );
    level notify( #"hash_aefc5c470125baf8" );
    ob_nm_mode::end_of_round_fanfare( undefined, "nm_wave_threat_end" );
}

// Namespace namespace_21e60aef063ff4f3
// Params 0
// Checksum 0x2a805e9b, Offset: 0xfe2
// Size: 0x2d4
function function_c69971d5befdd977()
{
    ob_nm_mode::nightmare_splash( "nm_wave_threat_start" );
    wait 1;
    level thread frenzy_br_circle();
    struct = utility::getstruct( "struct_carrier_smoke_1", "targetname" );
    obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( struct.origin, 128 );
    level thread ob_nm_mode::play_spawn_smoke( "struct_carrier_smoke_1", "flag_killcount_round_1_done" );
    level thread function_69fd7cd14ea350cf( "struct_carrier_smoke_1", "flag_killcount_round_1_done" );
    level.minion_volume = getnoentvolumearray( "vol_nm_carrier_1", "targetname" )[ 0 ];
    thread ob_nm_mode::minion_encounter( "nm_carrier_activity", "flag_killcount_round_1_done", undefined, 1 );
    level thread airdrop_minion( "struct_carrier_smoke_1", "flag_killcount_round_1_done", "sat_ob_enemy_hvt_jugg_minigun" );
    
    while ( level.minions_killed < level.minion_kill_obj / 3 )
    {
        waitframe();
    }
    
    ob_story_mission_utils::objective_marker_clear( obj_id );
    level notify( #"hash_f8318a5d48451de5" );
    waitframe();
    level utility::flag_set( "flag_killcount_round_1_done" );
    level utility::flag_set( "flag_enable_super_sprint" );
    struct = utility::getstruct( "struct_carrier_smoke_2", "targetname" );
    obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( struct.origin, 128 );
    ob_nm_mode::nightmare_splash( "nm_wave_threat_start" );
    level thread ob_nm_mode::play_spawn_smoke( "struct_carrier_smoke_2", "flag_killcount_round_2_done" );
    level thread function_69fd7cd14ea350cf( "struct_carrier_smoke_2", "flag_killcount_round_2_done" );
    level.minion_volume = getnoentvolumearray( "vol_nm_carrier_2", "targetname" )[ 0 ];
    thread ob_nm_mode::minion_encounter( "nm_carrier_activity_2", "flag_killcount_round_2_done", undefined, 1 );
    level thread airdrop_minion( "struct_carrier_smoke_2", "flag_killcount_round_2_done", "sat_ob_enemy_hvt_jugg_minigun" );
    
    while ( level.minions_killed < 0.666667 * level.minion_kill_obj )
    {
        waitframe();
    }
    
    ob_story_mission_utils::objective_marker_clear( obj_id );
    level notify( #"hash_f8318a5d48451de5" );
    waitframe();
    level utility::flag_clear( "flag_enable_super_sprint" );
    level utility::flag_set( "flag_killcount_round_2_done" );
    ob_nm_mode::nightmare_splash( "nm_wave_threat_start" );
    struct = utility::getstruct( "struct_carrier_smoke_3", "targetname" );
    obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( struct.origin, 128 );
    level thread ob_nm_mode::play_spawn_smoke( "struct_carrier_smoke_3", "flag_killcount_round_3_done" );
    level thread function_69fd7cd14ea350cf( "struct_carrier_smoke_3", "flag_killcount_round_3_done" );
    level thread airdrop_minion( "struct_carrier_smoke_3", "flag_killcount_round_3_done", "sat_ob_enemy_hvt_jugg_minigun" );
    level.minion_volume = getnoentvolumearray( "vol_nm_carrier_3", "targetname" )[ 0 ];
    thread ob_nm_mode::minion_encounter( "nm_carrier_activity_3", "flag_killcount_round_3_done", undefined, 1 );
    
    while ( level.minions_killed < level.minion_kill_obj )
    {
        waitframe();
    }
    
    ob_story_mission_utils::objective_marker_clear( obj_id );
    level notify( #"hash_f8318a5d48451de5" );
    waitframe();
    level utility::flag_set( "flag_killcount_round_3_done" );
    level.minion_volume = undefined;
}

// Namespace namespace_21e60aef063ff4f3
// Params 0
// Checksum 0x77b8cddd, Offset: 0x12be
// Size: 0x1c8
function frenzy_br_circle()
{
    var_39a9c4923260d901 = utility::getstruct( "struct_carrier_smoke_1", "targetname" );
    var_9a7b20e173174021 = 4096;
    radius = 2100;
    var_cf306bbdec90ce = 15;
    circle = ob_nm_mode::function_21689e5c8bddd87c( var_39a9c4923260d901.origin, var_9a7b20e173174021 );
    circle brcirclemoveto( var_39a9c4923260d901.origin[ 0 ], var_39a9c4923260d901.origin[ 1 ], radius, var_cf306bbdec90ce );
    level thread ob_nm_mode::update_minimap_circle( circle, var_39a9c4923260d901.origin, var_39a9c4923260d901.origin, var_9a7b20e173174021, radius, var_cf306bbdec90ce );
    level utility::flag_wait( "flag_killcount_round_1_done" );
    var_1d3f1d13aecfdeec = utility::getstruct( "struct_carrier_smoke_2", "targetname" );
    circle brcirclemoveto( var_1d3f1d13aecfdeec.origin[ 0 ], var_1d3f1d13aecfdeec.origin[ 1 ], radius, var_cf306bbdec90ce );
    level thread ob_nm_mode::update_minimap_circle( circle, var_39a9c4923260d901.origin, var_1d3f1d13aecfdeec.origin, radius, radius, var_cf306bbdec90ce );
    level utility::flag_wait( "flag_killcount_round_2_done" );
    var_c991d910bb83b5ab = utility::getstruct( "struct_carrier_smoke_3", "targetname" );
    circle brcirclemoveto( var_c991d910bb83b5ab.origin[ 0 ], var_c991d910bb83b5ab.origin[ 1 ], radius, var_cf306bbdec90ce );
    level thread ob_nm_mode::update_minimap_circle( circle, var_1d3f1d13aecfdeec.origin, var_c991d910bb83b5ab.origin, radius, radius, var_cf306bbdec90ce );
    level utility::flag_wait( "flag_killcount_round_3_done" );
    level notify( #"stop_circle" );
    
    if ( isdefined( circle ) )
    {
        if ( isdefined( circle.mapcircle ) )
        {
            circle game_utility::questcircle_delete();
        }
        
        circle delete();
    }
}

// Namespace namespace_21e60aef063ff4f3
// Params 2
// Checksum 0x96d0db93, Offset: 0x148e
// Size: 0x77
function function_69fd7cd14ea350cf( var_dc6a4b4b351da087, flag_to_end )
{
    wave_smoke = utility::getstruct( var_dc6a4b4b351da087, "targetname" );
    
    if ( !isdefined( wave_smoke ) )
    {
        return;
    }
    
    loop_sound = snd::play( "amb_cradle_tornado_rotation", wave_smoke.origin + ( 0, 0, 100 ) );
    level utility::flag_wait( flag_to_end );
    snd::stop( loop_sound );
}

// Namespace namespace_21e60aef063ff4f3
// Params 0
// Checksum 0x1f5b19d4, Offset: 0x150d
// Size: 0x3f
function round_intermission()
{
    var_ad30c944bbd232d7 = 1.5;
    level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", var_ad30c944bbd232d7, undefined, level.players, undefined, undefined, 1 );
    ob_nm_mode::nightmare_splash( "nm_wave_threat_end" );
    wait 8;
}

// Namespace namespace_21e60aef063ff4f3
// Params 0
// Checksum 0xe3c5a4d9, Offset: 0x1554
// Size: 0x3c
function function_bf74d63f5b4c32d3()
{
    while ( level.minions_killed < level.minion_kill_obj * 0.5 )
    {
        waitframe();
    }
    
    /#
        iprintln( "<dev string:x24>" );
    #/
    
    level utility::flag( "flag_enable_super_sprint" );
}

// Namespace namespace_21e60aef063ff4f3
// Params 0
// Checksum 0x6f1b561b, Offset: 0x1598
// Size: 0xba
function killstreak_capture_points()
{
    level utility::flag_set( "flag_multi_capture_event" );
    capture_structs = utility::getstructarray( "carrier_ks_capture", "targetname" );
    
    for ( i = 0; i < capture_structs.size ; i++ )
    {
        switch ( capture_structs[ i ].script_noteworthy )
        {
            case #"hash_8f6cefea3b20a779":
                var_62499c7b56d89a2c = 1;
                break;
            case #"hash_9578079b52b549c":
                var_62499c7b56d89a2c = 2;
                break;
            case #"hash_c07ca120d6686cff":
                var_62499c7b56d89a2c = 3;
                break;
            default:
                var_62499c7b56d89a2c = 1;
                break;
        }
        
        thread ob_nm_mode::capture_zone_instance( capture_structs[ i ], var_62499c7b56d89a2c );
    }
}

// Namespace namespace_21e60aef063ff4f3
// Params 1
// Checksum 0x2811950a, Offset: 0x165a
// Size: 0x95
function setup_sentry_traps( var_dc6a4b4b351da087 )
{
    a_structs = utility::getstructarray( var_dc6a4b4b351da087, "targetname" );
    
    foreach ( struct in a_structs )
    {
        struct thread setup_individual_sentry();
    }
}

// Namespace namespace_21e60aef063ff4f3
// Params 0
// Checksum 0x64c74ece, Offset: 0x16f7
// Size: 0x104
function setup_individual_sentry()
{
    model = spawn( "script_model", self.origin );
    model.angles = self.angles;
    model setmodel( %"streak_t10_wm_sentry_turret" );
    model hudoutlineenable( "outline_nodepth_yellow" );
    model setscriptablepartstate( #"visibility", #"show" );
    org = anglestoforward( self.angles ) * -24;
    spot = self.origin + org;
    interact = interaction::register_interact( spot + ( 0, 0, 40 ), 64, &turret_interacted, &"sat_ob_story_missions/interact_activate", undefined, undefined, undefined, "HINT_BUTTON" );
    interact.var_555a947463e55350 = self;
    interact setuseholdduration( 0 );
    interact function_b7dbd12e52c5b2e1();
    interact makeunusable();
    
    if ( isdefined( model ) )
    {
        model delete();
    }
}

// Namespace namespace_21e60aef063ff4f3
// Params 1
// Checksum 0xd47f7a77, Offset: 0x1803
// Size: 0x2a
function turret_interacted( var_9d64a5e2cee72c8f )
{
    self notify( #"turret_used" );
    self.var_555a947463e55350 ob_nm_mode::function_bd6063946e66442c( var_9d64a5e2cee72c8f );
}

// Namespace namespace_21e60aef063ff4f3
// Params 0
// Checksum 0x3b1a6992, Offset: 0x1835
// Size: 0x27
function function_b7dbd12e52c5b2e1()
{
    level endon( #"hash_23dc72c206f93882" );
    self endon( #"turret_used" );
    level utility::flag_wait( "flag_disable_turret_interacts" );
}

// Namespace namespace_21e60aef063ff4f3
// Params 1
// Checksum 0xa0af237a, Offset: 0x1864
// Size: 0xbe
function setup_killstreak_interacts( var_dc6a4b4b351da087 )
{
    a_structs = utility::getstructarray( var_dc6a4b4b351da087, "targetname" );
    
    foreach ( struct in a_structs )
    {
        if ( struct.script_noteworthy == "vtol" || struct.script_noteworthy == "hellstorm" )
        {
            struct thread setup_individual_killstreak();
        }
    }
}

// Namespace namespace_21e60aef063ff4f3
// Params 1
// Checksum 0xfe6da1e6, Offset: 0x192a
// Size: 0x158
function setup_individual_killstreak( flag_name )
{
    if ( isdefined( flag_name ) )
    {
        level utility::flag_wait( flag_name );
    }
    
    model = spawn( "script_model", self.origin );
    model.angles = self.angles;
    model setmodel( %"eqp_sat_wm_tablet" );
    model hudoutlineenable( "outline_nodepth_yellow" );
    
    switch ( self.script_noteworthy )
    {
        case #"hash_8f6cefea3b20a779":
            string = &"sat_ob_story_missions/nm_ks_rhino";
            break;
        case #"hash_c07ca120d6686cff":
            string = &"sat_ob_story_missions/nm_ks_hellstorm";
            break;
        case #"hash_9578079b52b549c":
            string = &"sat_ob_story_missions/nm_ks_vtol";
            break;
        default:
            string = &"sat_ob_story_missions/nm_ks_hellstorm";
            break;
    }
    
    interact = interaction::register_interact( self.origin + ( 0, 0, 2 ), 64, &function_66899d4bf089e7e6, string, undefined, undefined, undefined, "HINT_BUTTON" );
    interact.streak_name = self.script_noteworthy;
    interact setuseholdduration( 0 );
    interact function_b47ae86f123d2add();
    interact makeunusable();
    model delete();
}

// Namespace namespace_21e60aef063ff4f3
// Params 0
// Checksum 0xa54ed706, Offset: 0x1a8a
// Size: 0x1b
function function_b47ae86f123d2add()
{
    self endon( #"ks_used" );
    level utility::flag_wait( "flag_disable_ks_tablets" );
}

// Namespace namespace_21e60aef063ff4f3
// Params 1
// Checksum 0x4c0cca7, Offset: 0x1aad
// Size: 0x99
function function_66899d4bf089e7e6( var_9d64a5e2cee72c8f )
{
    if ( level utility::flag( "flag_disable_ks_tablets" ) )
    {
        return;
    }
    
    self notify( #"ks_used" );
    
    switch ( self.streak_name )
    {
        case #"hash_8f6cefea3b20a779":
            var_9d64a5e2cee72c8f thread ob_nm_mode::start_remote_robot();
            break;
        case #"hash_c07ca120d6686cff":
            var_9d64a5e2cee72c8f thread ob_nm_mode::start_hellstorm();
            break;
        case #"hash_9578079b52b549c":
            var_9d64a5e2cee72c8f thread ob_nm_mode::start_vtol_warship();
            break;
        default:
            var_9d64a5e2cee72c8f thread ob_nm_mode::start_hellstorm();
            break;
    }
}

// Namespace namespace_21e60aef063ff4f3
// Params 9
// Checksum 0x79216117, Offset: 0x1b4e
// Size: 0x224
function klaus_fight( var_fcb964ac6f23a112, var_e04c0425c57a325, radius, main_boss = "sat_spawner_zombie_mimic_ob", static_circle, minion_encounter_name, big_boss, spawn_minions, objective_asset )
{
    ob_nm_mode::start_of_round_fanfare( "nm_overlord_boss_start", "nm_boss_start" );
    var_fcb964ac6f23a112 = utility::getstruct( var_fcb964ac6f23a112, "targetname" );
    var_e04c0425c57a325 = utility::getstructarray( var_e04c0425c57a325, "targetname" );
    var_e04c0425c57a325 = arrayrandomize( var_e04c0425c57a325 );
    level utility::flag_clear( "nightmare_encouter_done" );
    level utility::flag_set( "nightmare_encouter_active" );
    obj = objective_asset ?? %"hash_1d6c1f3ae5d084d5";
    ob_story_mission_utils::objective_text_show( obj );
    time_modifier = ob_nm_mode::function_3fc7f1f10018b737( 360 );
    ob_story_mission_utils::objective_timer_update( time_modifier );
    level thread ob_nm_mode::wave_fail_timer( time_modifier );
    waitframe();
    spawn_pos = getclosestpointonnavmesh( var_e04c0425c57a325[ 0 ].origin );
    playfx( level._effect[ "enemy_vfx" ], spawn_pos + ( 0, 0, 32 ) );
    var_ed2e4415196b4d1c = mp_agent::spawnnewagentaitype( main_boss, spawn_pos, var_e04c0425c57a325[ 0 ].angles, "team_two_hundred" );
    var_ed2e4415196b4d1c zombie_utils::function_dfae6a5bd222c586( &function_ca401c4211026608 );
    var_ed2e4415196b4d1c function_fa32376aaa88a7a2( var_ed2e4415196b4d1c.origin, 10000 );
    level.nm_klaus = var_ed2e4415196b4d1c;
    var_ed2e4415196b4d1c thread function_c7d6d085089ea23b( "main", self );
    var_ed2e4415196b4d1c thread function_c9094959264f8e9b();
    var_ed2e4415196b4d1c thread function_d7ba7770145fb134();
    thread function_43947637021980da();
    thread function_9b0724e325d3994( var_ed2e4415196b4d1c );
    level utility::flag_wait( "flag_klaus_fight_complete" );
    level notify( #"cleanup_minions" );
    level notify( #"hash_aefc5c470125baf8" );
    level utility::flag_clear( "nightmare_encouter_active" );
    level utility::flag_set( "nightmare_encouter_done" );
    level notify( #"stop_circle" );
    self.var_9be376218db54aba = undefined;
    ob_nm_mode::end_of_round_fanfare( "nm_overlord_boss_dead", "nm_boss_end" );
}

// Namespace namespace_21e60aef063ff4f3
// Params 1
// Checksum 0xffdadeb4, Offset: 0x1d7a
// Size: 0x5f
function function_ca401c4211026608( params )
{
    damage = params.idamage;
    
    if ( self.boss_immune )
    {
        return 0;
    }
    
    if ( issubstr( self.classname, "mini" ) )
    {
        return clamp( damage, 0, self.maxhealth * 0.05 );
    }
    
    return -1;
}

// Namespace namespace_21e60aef063ff4f3
// Params 0
// Checksum 0x4cd4e298, Offset: 0x1de2
// Size: 0x9d
function function_c9094959264f8e9b()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"leap_landed" );
        
        if ( !level utility::flag( "flag_klaus_up_in_air" ) )
        {
            spot = utility::getstruct( "nm_carrier_circle_struct", "targetname" );
            origin = ( level.nm_klaus.origin[ 0 ], level.nm_klaus.origin[ 1 ], spot.origin[ 2 ] );
            level thread OB_VIRGO_CARRIER_INTRO::function_1f89f29043f859c9( origin );
        }
    }
}

// Namespace namespace_21e60aef063ff4f3
// Params 0
// Checksum 0xeadb4af2, Offset: 0x1e87
// Size: 0x1df
function function_43947637021980da()
{
    level.enemy_count_array = [ 12, 16, 20, 24 ];
    level.cadence_override = 2.5;
    thread ob_nm_mode::minion_encounter( "nm_carrier_boss", "flag_klaus_end_stage_1" );
    level utility::flag_wait( "flag_klaus_start_stage_2" );
    level.enemy_count_array = [ 8, 12, 16, 20 ];
    level.cadence_override = 2.5;
    thread ob_nm_mode::minion_encounter( "nm_carrier_boss_2", "flag_klaus_end_stage_2" );
    level utility::flag_wait( "flag_klaus_start_stage_3" );
    level utility::flag_wait( "flag_start_mini_klaus" );
    level.enemy_count_array = [ 8, 12, 16, 20 ];
    level.cadence_override = 2.5;
    thread ob_nm_mode::minion_encounter( "nm_carrier_boss_3", "flag_start_mini_klaus_final" );
    level utility::flag_wait( "flag_start_mini_klaus_final" );
    var_fcb964ac6f23a112 = utility::getstruct( "nm_carrier_circle_struct_2" );
    var_17c94bd4556610bb = var_fcb964ac6f23a112.origin;
    
    if ( isdefined( level.var_bc613b9e18b2b346 ) )
    {
        var_17c94bd4556610bb = level.var_bc613b9e18b2b346.origin;
    }
    
    var_9a7b20e173174021 = 4096;
    radius = 1000;
    var_cf306bbdec90ce = 15;
    circle = ob_nm_mode::function_21689e5c8bddd87c( var_17c94bd4556610bb, var_9a7b20e173174021 );
    circle brcirclemoveto( var_17c94bd4556610bb[ 0 ], var_17c94bd4556610bb[ 1 ], radius, var_cf306bbdec90ce );
    level thread ob_nm_mode::update_minimap_circle( circle, var_17c94bd4556610bb, var_17c94bd4556610bb, var_9a7b20e173174021, radius, var_cf306bbdec90ce );
    level utility::flag_wait( "flag_klaus_fight_complete" );
    level notify( #"stop_circle" );
    
    if ( isdefined( circle ) )
    {
        if ( isdefined( circle.mapcircle ) )
        {
            circle game_utility::questcircle_delete();
        }
        
        circle delete();
    }
}

// Namespace namespace_21e60aef063ff4f3
// Params 0
// Checksum 0x1045412, Offset: 0x206e
// Size: 0x11b
function function_22b0dfcec67c8005()
{
    if ( isdefined( level.var_bc613b9e18b2b346 ) )
    {
        origin = level.var_bc613b9e18b2b346.origin;
    }
    else
    {
        struct = utility::getstruct( "nm_carrier_circle_struct", "targetname" );
        origin = struct.origin;
    }
    
    radius = 1024;
    var_909a633aee72cb9 = level.players.size * 3;
    segment_degrees = 360 / var_909a633aee72cb9;
    
    for ( i = 0; i < var_909a633aee72cb9 ; i++ )
    {
        local_offset = anglestoforward( ( 0, segment_degrees * i, 0 ) ) * radius;
        chevron_org = coordtransform( local_offset, origin, ( 0, 0, 0 ) );
        chevron_org = getclosestpointonnavmesh( chevron_org );
        chevron_ang = vectortoangles( chevron_org - origin );
        extra_dude = mp_agent::spawnnewagentaitype( "sat_spawner_zombie_viper_mini_ob", chevron_org, chevron_ang, "team_two_hundred" );
        extra_dude thread function_2132a487a77f70f3();
        waitframe();
    }
}

// Namespace namespace_21e60aef063ff4f3
// Params 0
// Checksum 0x4e606e7b, Offset: 0x2191
// Size: 0x90
function function_2132a487a77f70f3()
{
    self endon( #"death" );
    playfx( level._effect[ "popcorn_spawn" ], self.origin + ( 0, 0, 32 ) );
    self function_fa32376aaa88a7a2( self.origin, 10000 );
    thread ob_nm_mode::individual_vanish( "flag_klaus_fight_complete" );
    mp_agent::set_agent_health( 1000 );
    wait 1;
    self setscriptablepartstate( "self_destruct", "start" );
    self setscriptablepartstate( "base", "self_destruct" );
    self notify( #"self_destruct_approach" );
}

// Namespace namespace_21e60aef063ff4f3
// Params 0
// Checksum 0xc34154d, Offset: 0x2229
// Size: 0x91
function boss_missile_attack()
{
    level endon( #"hash_8897b378146d724a" );
    level endon( #"hash_e95ced04f8eba21a" );
    self endon( #"death" );
    
    while ( true )
    {
        for ( i = 0; i < level.players.size ; i++ )
        {
            if ( isalive( level.players[ i ] ) && !active_camo_is_active( level.players[ i ] ) )
            {
                function_fd9564152eca84c1( level.players[ i ] );
            }
        }
        
        wait 3;
    }
}

// Namespace namespace_21e60aef063ff4f3
// Params 1
// Checksum 0xe8b80097, Offset: 0x22c2
// Size: 0x26, Type: bool
function active_camo_is_active( player )
{
    return player supers_mp::getcurrentsuperref() == "super_active_camo" && player supers_mp::issuperinuse();
}

// Namespace namespace_21e60aef063ff4f3
// Params 0
// Checksum 0x1aa60635, Offset: 0x22f1
// Size: 0x97
function function_d7ba7770145fb134()
{
    self endon( #"death" );
    max_health = self.health;
    
    while ( self.health > max_health * 0.66 )
    {
        waitframe();
    }
    
    level utility::flag_set( "flag_klaus_end_stage_1" );
    function_a788a502e783184c();
    level utility::flag_set( "flag_klaus_start_stage_2" );
    
    while ( self.health > max_health * 0.33 )
    {
        waitframe();
    }
    
    level utility::flag_set( "flag_klaus_end_stage_2" );
    function_a788a502e783184c();
    level utility::flag_set( "flag_klaus_start_stage_3" );
}

// Namespace namespace_21e60aef063ff4f3
// Params 0
// Checksum 0xb030268b, Offset: 0x2390
// Size: 0x1a2
function function_a788a502e783184c()
{
    self endon( #"death" );
    self.boss_immune = 1;
    thread function_b3cfd5e956f6b49c( 1 );
    ob_nm_mode::nightmare_splash( "nm_incoming_strike" );
    var_ad30c944bbd232d7 = 1.5;
    level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", var_ad30c944bbd232d7, undefined, level.players, undefined, undefined, 1 );
    wait var_ad30c944bbd232d7;
    level utility::flag_set( "flag_klaus_up_in_air" );
    utility::function_32b24db3127bff40( "thruster", "on" );
    waitframe();
    move_time = 2;
    anchor_tag = level utility::function_1808878d1c511ce8( self.origin, self.angles );
    self motionwarpcancel();
    self linkto( anchor_tag );
    anchor_tag movez( 512, move_time );
    wait move_time;
    thread boss_missile_attack();
    klaus_shield( anchor_tag );
    utility::function_32b24db3127bff40( "thruster", "off" );
    wait 1;
    anchor_tag movez( -512, move_time / 4 );
    wait move_time / 4;
    wait 0.2;
    spot = utility::getstruct( "nm_carrier_circle_struct", "targetname" );
    origin = ( level.nm_klaus.origin[ 0 ], level.nm_klaus.origin[ 1 ], spot.origin[ 2 ] );
    level thread OB_VIRGO_CARRIER_INTRO::function_1f89f29043f859c9( origin );
    level notify( #"hash_23dc72c206f93882" );
    level utility::flag_clear( "flag_klaus_up_in_air" );
    self.boss_immune = 0;
    thread function_b3cfd5e956f6b49c( 0 );
    self unlink();
}

// Namespace namespace_21e60aef063ff4f3
// Params 1
// Checksum 0x2cbc4898, Offset: 0x253a
// Size: 0xbf
function function_b3cfd5e956f6b49c( b_immune )
{
    self endon( #"death" );
    
    foreach ( player in level.players )
    {
        if ( b_immune )
        {
            player ob_story_mission_utils::player_boss_healthbar_immune();
        }
        else
        {
            player thread ob_story_mission_utils::player_boss_healthbar_show();
        }
        
        player ob_story_mission_utils::function_e231206f1628d4c6( 1, self.health, self.max_health );
    }
}

// Namespace namespace_21e60aef063ff4f3
// Params 0
// Checksum 0xfce1dd0, Offset: 0x2601
// Size: 0xb1
function function_ce54689a4072dafc()
{
    self endon( #"death" );
    max_health = self.health;
    
    while ( self.health > max_health * 0.66 )
    {
        waitframe();
    }
    
    thread ob_nm_mode::nightmare_splash( "nm_wave_threat_start" );
    
    /#
        iprintln( "<dev string:x37>" );
    #/
    
    level utility::flag_set( "flag_start_mini_klaus_stage_2" );
    level thread function_22b0dfcec67c8005();
    
    while ( self.health > max_health * 0.33 )
    {
        waitframe();
    }
    
    thread ob_nm_mode::nightmare_splash( "nm_wave_threat_start" );
    
    /#
        iprintln( "<dev string:x49>" );
    #/
    
    level utility::flag_set( "flag_start_mini_klaus_final" );
    level thread function_22b0dfcec67c8005();
}

// Namespace namespace_21e60aef063ff4f3
// Params 1
// Checksum 0x13ac75de, Offset: 0x26ba
// Size: 0xdb
function klaus_shield( tag_origin )
{
    self endon( #"death" );
    
    if ( self islinked() )
    {
        level utility::flag_set( "flag_klaus_fight" );
        bubble_shield_spawn_pos = tag_origin.origin + ( 0, 0, 32 );
        bubble_shield_model = utility::spawn_model( "eqp_sat_wm_bubble_shield_razor", bubble_shield_spawn_pos, tag_origin.angles );
        bubble_shield_model setscriptablepartstate( #"visibility", #"show" );
        bubble_shield_model setscriptablepartstate( #"active", #"active" );
        childthread utility::delete_on_death( bubble_shield_model );
        level.var_bd2748e149a8024b thread ob_nm_mode::bubble_shield( bubble_shield_model, self );
        level waittill( #"hash_e95ced04f8eba21a" );
    }
    
    level notify( #"hash_8897b378146d724a" );
}

// Namespace namespace_21e60aef063ff4f3
// Params 2
// Checksum 0x5d5b905d, Offset: 0x279d
// Size: 0xa0
function function_fd9564152eca84c1( player, var_bbf0fa162edd3ce6 = 4 )
{
    self endon( #"death" );
    
    for ( i = 0; i < var_bbf0fa162edd3ce6 ; i++ )
    {
        start = self.origin + ( 0, 0, 128 );
        end = self.origin + ( 0, 0, 256 );
        childthread individual_missile( start, end, player );
        wait randomfloatrange( 0.5, 0.75 );
    }
}

// Namespace namespace_21e60aef063ff4f3
// Params 3
// Checksum 0x3518b2c3, Offset: 0x2845
// Size: 0x91
function individual_missile( start, end, player )
{
    if ( isalive( player ) && !active_camo_is_active( player ) )
    {
        missile = magicbullet( "sat_la_ztron_fireball_virgo_nm", start, end, self );
        missile endon( #"death" );
        wait randomfloatrange( 0.5, 0.75 );
        
        if ( isalive( player ) && !active_camo_is_active( player ) )
        {
            missile missile_settargetpos( player.origin );
        }
    }
}

// Namespace namespace_21e60aef063ff4f3
// Params 2
// Checksum 0x38426445, Offset: 0x28de
// Size: 0x142
function function_c7d6d085089ea23b( enemy_type, activity_instance )
{
    level.var_bd2748e149a8024b.var_9be376218db54aba = "sat_ob_objectivemarker_nm_big_boss";
    
    switch ( enemy_type )
    {
        case #"hash_faea0534e49cf368":
            self.var_be5ccf6d16f6b59e = 1;
            ob_nm_mode::set_boss_health( 0.2 * level.players.size );
            thread ob_nm_mode::setup_boss_healthbar( self.health, self.maxhealth, "ob_boss_virgo_nm_klaus" );
            level.var_2329358fe54790a0 = level.var_bd2748e149a8024b ob_story_mission_utils::function_804834359f20ef5a( self, 128 );
            function_2b8e3d3ae2a6414a( level.var_2329358fe54790a0, 0 );
            break;
        case #"hash_bfabc434c59611fa":
            self.var_be5ccf6d16f6b59e = 1;
            self hudoutlineenable( "outline_nodepth_red" );
            ob_nm_mode::set_boss_health( 0.4 * level.players.size );
            thread ob_nm_mode::setup_boss_healthbar( self.health, self.maxhealth, "ob_boss_virgo_nm_klaus_mini" );
            level.var_2329388fe5479739 = level.var_bd2748e149a8024b ob_story_mission_utils::function_804834359f20ef5a( self );
            function_2b8e3d3ae2a6414a( level.var_2329388fe5479739, 0 );
            break;
        default:
            break;
    }
}

// Namespace namespace_21e60aef063ff4f3
// Params 1
// Checksum 0xdbd28b95, Offset: 0x2a28
// Size: 0x1ab
function function_9b0724e325d3994( boss )
{
    boss waittill( #"death" );
    var_8fc61192c6783b9c = 1;
    
    if ( isdefined( level.var_2329358fe54790a0 ) )
    {
        level.var_bd2748e149a8024b ob_story_mission_utils::objective_marker_clear( level.var_2329358fe54790a0 );
    }
    
    level thread function_6dc4bb7a44f95fbd();
    
    while ( var_8fc61192c6783b9c )
    {
        enemies = getaiarray();
        
        foreach ( enemy in enemies )
        {
            if ( issubstr( enemy.classname, "viper_mini" ) )
            {
                var_8fc61192c6783b9c = 0;
            }
        }
        
        waitframe();
    }
    
    level utility::flag_set( "flag_start_mini_klaus" );
    wait 1;
    enemies = getaiarray();
    var_8fc61192c6783b9c = 1;
    
    foreach ( enemy in enemies )
    {
        if ( issubstr( enemy.classname, "viper_mini" ) )
        {
            enemy zombie_utils::function_dfae6a5bd222c586( &function_ca401c4211026608 );
            level thread mini_klaus_fight( enemy );
            var_8fc61192c6783b9c = 0;
        }
    }
    
    if ( var_8fc61192c6783b9c )
    {
        level utility::flag_set( "flag_klaus_fight_complete" );
    }
}

// Namespace namespace_21e60aef063ff4f3
// Params 0
// Checksum 0x737290f5, Offset: 0x2bdb
// Size: 0x24
function function_6dc4bb7a44f95fbd()
{
    wait 10;
    
    if ( level utility::flag( "flag_start_mini_klaus" ) )
    {
        return;
    }
    
    level utility::flag_set( "flag_klaus_fight_complete" );
}

// Namespace namespace_21e60aef063ff4f3
// Params 1
// Checksum 0xf05330e, Offset: 0x2c07
// Size: 0x5d
function mini_klaus_fight( boss )
{
    level.var_bc613b9e18b2b346 = boss;
    boss thread function_c7d6d085089ea23b( "mini" );
    boss thread function_ce54689a4072dafc();
    level utility::delaycall( 5, &utility::flag_set, "flag_spawn_klaus_encounter_3" );
    boss waittill( #"death" );
    level utility::flag_set( "flag_klaus_fight_complete" );
}

// Namespace namespace_21e60aef063ff4f3
// Params 3
// Checksum 0x44da8b3d, Offset: 0x2c6c
// Size: 0x91
function airdrop_minion( var_dc6a4b4b351da087, flag_name, minion_type = "sat_ob_enemy_hvt_jugg_minigun" )
{
    struct = utility::getstruct( var_dc6a4b4b351da087, "targetname" );
    extra_dude = mp_agent::spawnnewagentaitype( minion_type, struct.origin, struct.angles, "team_hundred_ninety" );
    extra_dude ob_nm_mode::set_boss_health( 0.75 );
    extra_dude thread ob_nm_mode::individual_vanish( flag_name );
    extra_dude thread aidrop_on_death();
}

// Namespace namespace_21e60aef063ff4f3
// Params 0
// Checksum 0xce903d76, Offset: 0x2d05
// Size: 0x49
function aidrop_on_death()
{
    level endon( #"hash_f8318a5d48451de5" );
    self function_fa32376aaa88a7a2( self.origin, 10000 );
    self hudoutlineenable( "outline_depth_yellow" );
    self waittill( #"death" );
    level thread killstreak_drop( self.origin );
}

// Namespace namespace_21e60aef063ff4f3
// Params 1
// Checksum 0xd49b078d, Offset: 0x2d56
// Size: 0x112
function function_dcb13f1f16265933( origin )
{
    player = level.players[ 0 ];
    spawn_point = origin + ( 0, 0, 1000 );
    spawn_items = [ %"hash_35298bd2d2aff71f", %"hash_35298bd2d2aff71f", %"hash_5266d3009edcba6" ];
    crate = ob_story_mission_utils::function_53ca684fc4aa8af3( player, spawn_point, spawn_items, 1, 0, 1 );
    crate hudoutlineenable( "outline_depth_yellow" );
    
    foreach ( player in level.players )
    {
        level thread utility::play_sound_in_space( "mp_arms_new_objective", player.origin );
    }
}

// Namespace namespace_21e60aef063ff4f3
// Params 1
// Checksum 0xc215f9c4, Offset: 0x2e70
// Size: 0xa0
function killstreak_drop( origin )
{
    struct = spawnstruct();
    spot = getclosestpointonnavmesh( origin );
    offset = ( 0, 0, 8 );
    struct.origin = spot + offset;
    struct.angles = ( 0, 0, 0 );
    struct.script_noteworthy = "rhino";
    
    if ( utility::cointoss() )
    {
        struct.script_noteworthy = "hellstorm";
    }
    
    struct thread setup_individual_killstreak();
}

// Namespace namespace_21e60aef063ff4f3
// Params 0
// Checksum 0xa72e01b8, Offset: 0x2f18
// Size: 0x68
function suicide_bots()
{
    a_structs = utility::getstructarray( "nm_carrier_struct", "targetname" );
    a_structs = arrayrandomize( a_structs );
    extra_dude = mp_agent::spawnnewagentaitype( "sat_spawner_zombie_viper_mini_ob", a_structs[ 0 ].origin, a_structs[ 0 ].angles, "team_two_hundred" );
    extra_dude thread ob_nm_mode::individual_vanish( "flag_klaus_fight_complete" );
}

