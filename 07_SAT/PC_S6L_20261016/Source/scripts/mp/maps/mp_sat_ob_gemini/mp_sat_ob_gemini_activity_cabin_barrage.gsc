// scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_activity_cabin_barrage.gsc  (hash_102d97de99c0d1ae.gscc) (size: 19351 Bytes / 0x4b97 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9ef7cb9d (2667039645)
// size ...... 19351 (0x4b97)
// includes .. 30  (offset: 0x45c3)
// strings ... 76  (offset: 0x46b3)
// dev strs .. 4   (offset: 0x4b67)
// exports ... 48  (offset: 0x2c67)
// cseg ...... 0x849 + 0x241e (0x2c67)
// imports ... 149 (offset: 0x33e7)
// animtree1 . 0   (offset: 0x4b97)
// animtree2 . 0   (offset: 0x4b97)
#using script_2399696a9d953451;
#using script_4c1e16e1162d066f;
#using script_636bd827a012af12;
#using script_66878054d141dbc0;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\ai_spawn_director_utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_emergence_spawning;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\br\gametypes\br_exclusion_zone;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\emp_debuff;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\interaction;
#using scripts\mp\laststand;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_audio;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_scenes;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_util;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_vo;
#using scripts\mp\ob\contracts\ob_contract_ui_widget;
#using scripts\mp\supers;
#using scripts\mp\teamrevive;

#namespace mp_sat_ob_gemini_activity_cabin_barrage;

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 0, eflags: 0x5
// Checksum 0xe780af3, Offset: 0x867
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_fe15d604abcbc856", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 0, eflags: 0x4
// Checksum 0xcb2adb8b, Offset: 0x890
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_GEMINI_CABIN_BARRAGE";
    activity_common::registeractivitytype( "OB_GEMINI_CABIN_BARRAGE", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_CABIN_BARRAGE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_CABIN_BARRAGE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_CABIN_BARRAGE", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_GEMINI_CABIN_BARRAGE" );
}

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 0
// Checksum 0xf1c85923, Offset: 0x907
// Size: 0x59
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance cabin_barrage_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 0
// Checksum 0x278b6ff2, Offset: 0x968
// Size: 0x47
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    barrage_completed = activity_instance cabin_barrage_main();
    
    if ( barrage_completed )
    {
        activity_instance_common::endactivity( activity_instance, 1 );
    }
}

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 0
// Checksum 0x85495766, Offset: 0x9b7
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 1
// Checksum 0x28d6ec37, Offset: 0x9db
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread cabin_barrage_player_setup( player );
    }
}

/#

    // Namespace mp_sat_ob_gemini_activity_cabin_barrage
    // Params 0
    // Checksum 0xb08889fc, Offset: 0xa97
    // Size: 0x5, Type: dev
    function function_663a9214e7a9c323()
    {
        
    }

#/

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 0
// Checksum 0x5091556, Offset: 0xaa4
// Size: 0x1eb
function cabin_barrage_start()
{
    activity_instance = self;
    activity_instance thread gemini_util::function_cb22040a105c067c( 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_cabin_pickups_equipment_wilderness", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1, undefined, 0.5, 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_cabin_pickups_weapon_wilderness", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1 );
    
    if ( !level.is_squad_size_small )
    {
        activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_cabin_pickups_equipment_wilderness_large", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1, undefined, 0.5, 1 );
        activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_cabin_pickups_weapon_wilderness_large", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1 );
    }
    
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_cabin_pickups_equipment_initialmcz", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1, undefined, 0.5, 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_cabin_pickups_weapon_initialmcz", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1 );
    
    if ( !level.is_squad_size_small )
    {
        activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_cabin_pickups_equipment_initialmcz_large", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1, undefined, 0.5, 1 );
        activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_cabin_pickups_weapon_initialmcz_large", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1, undefined, 0.5, 1 );
    }
    
    activity_instance thread namespace_60d9b3cbf41663fe::function_b4dbb3fd9f18d7a2();
    activity_instance thread namespace_60d9b3cbf41663fe::function_6babdc48cee69335();
    gemini_util::function_34a3d0cff5de2d7d();
    gemini_util::function_dfcbf5f9b3b2e6a0();
    level ob_adz::function_86ebf122bc776db5( 1 );
    level.var_e07082c4f4aa4a97 = ob_adz::function_47e86714392d46b4( "cabin_center_struct", 1400, 1 );
    activity_instance thread gemini_util::function_fe0b04783865b1e7( level.var_e07082c4f4aa4a97 );
    a_structs = utility::getstructarray( "gemini_p2_adz_safety_teleport", "targetname" );
    
    foreach ( player in level.players )
    {
        player thread gemini_util::function_7da3d7491a75f0a8( a_structs );
    }
}

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 0
// Checksum 0xd01d6326, Offset: 0xc97
// Size: 0x2f4, Type: bool
function cabin_barrage_main()
{
    activity_instance = self;
    level.activity_instance = activity_instance;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    
    if ( isdefined( level.capture_zone_basement ) )
    {
        level.capture_zone_basement = undefined;
    }
    
    if ( isdefined( level.capture_zone_dock ) )
    {
        level.capture_zone_dock = undefined;
    }
    
    if ( isdefined( level.capture_zone_tree ) )
    {
        level.capture_zone_tree = undefined;
    }
    
    level.var_d53163b0ef2a4488 = 1;
    activity_instance childthread function_ccef03910379998f();
    activity_instance childthread gemini_vo::function_40764a6fb942b07d();
    activity_instance childthread namespace_60d9b3cbf41663fe::function_ae926e8ad8d5062();
    activity_instance childthread namespace_60d9b3cbf41663fe::function_e176d21ff78c394e();
    activity_instance childthread function_2bdf3a3e911ad061();
    level thread gemini_audio::cabin_barrage_vox();
    level thread ob_adz::function_f94c18166de9f51d( level.var_e07082c4f4aa4a97.zone_id, undefined, 1400, 30 );
    exclusioncircle = level.exclusionzones[ level.var_e07082c4f4aa4a97.var_e0dd4b03666cb7e8 ];
    exclusioncircle thread exclusion_zones::function_a1a887e23f767ba0( ( 2800, 2800, 0 ), 30 );
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_cabin_pickups_weapon_barrage", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1, undefined, 0.5, 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_cabin_pickups_equipment_barrage", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1, undefined, 0.5, 1 );
    
    if ( !level.is_squad_size_small )
    {
        activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_cabin_pickups_weapon_barrage_large", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1, undefined, 0.5, 1 );
        activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_cabin_pickups_equipment_barrage_large", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1, undefined, 0.5, 1 );
    }
    
    mason_interact_struct = utility::getstruct( "s_barrage_mason_interact", "targetname" );
    interact = interaction::register_interact( mason_interact_struct.origin, 64, &function_3ae456e129e50343, &"sat_ob_story_missions_gemini/interact_cabin_mason", undefined, undefined, undefined, "HINT_BUTTON" );
    interact setuseholdduration( "duration_medium" );
    level utility::flag_wait( "flag_cabin_barrage_check_on_alex_complete" );
    level utility::flag_set( "flag_cabin_barrage_survive_start" );
    level callback::callback( #"cabin_barrage_start", { #players:activity_instance.playerparticipants } );
    activity_instance thread gemini_util::function_cb22040a105c067c( 1 );
    activity_instance childthread barrage_setup();
    level utility::flag_wait( "OB_GEMINI_CABIN_BARRAGE_COMPLETE" );
    level callback::callback( #"cabin_barrage_end", { #players:activity_instance.playerparticipants } );
    activity_instance thread namespace_60d9b3cbf41663fe::function_a974af795d487a10();
    utility::delaythread( 2, &function_365f142eaf6cdf42 );
    
    if ( level callback::exists( #"player_laststand", &function_990f1260b61ff451 ) )
    {
        level callback::remove( #"player_laststand", &function_990f1260b61ff451 );
    }
    
    level.onsquadeliminated = activity_instance.var_38056ced8afa8351 ?? &ob_gametype_story_mission::function_1fb9ccca3958dbb2;
    activity_instance.var_38056ced8afa8351 = undefined;
    return true;
}

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 1, eflags: 0x4
// Checksum 0x10f2abb3, Offset: 0xf94
// Size: 0x1f
function private function_3ae456e129e50343( player )
{
    level utility::flag_set( "flag_cabin_barrage_check_on_alex_start" );
    self makeunusable();
}

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 1
// Checksum 0x379c8aa9, Offset: 0xfbb
// Size: 0x40
function cabin_barrage_player_setup( player )
{
    activity_instance = self;
    player thread gemini_util::prison_ai_corpse_cleanup( "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 0 );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
    }
}

/#

    // Namespace mp_sat_ob_gemini_activity_cabin_barrage
    // Params 0
    // Checksum 0x5e44da48, Offset: 0x1003
    // Size: 0x5, Type: dev
    function function_1a84e8f79107b9b8()
    {
        
    }

#/

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 0
// Checksum 0xa4eb9a9c, Offset: 0x1010
// Size: 0x52
function barrage_setup()
{
    activity_instance = self;
    function_6a5c82ae479b5c81();
    activity_instance.var_e521341747d186ca = 0;
    activity_instance.var_64239142c93ebf88 = 0;
    waitframe();
    activity_instance function_7c3de40e2a1a865d();
    activity_instance.barrage_active = 1;
    waitframe();
    activity_instance function_8072079989afca4e();
}

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 0
// Checksum 0xf3b6d3a9, Offset: 0x106a
// Size: 0x164
function function_6a5c82ae479b5c81()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    activity_instance.request_id_waves = ai_spawn_director::lookup_spawn_request( "defend_barrage_waves" );
    function_ef57f478f96b050c( activity_instance.request_id_waves, 1 );
    ai_spawn_director::add_spawned_callback( activity_instance.request_id_waves, &function_5ee4a8c5e0f8852b, activity_instance );
    ai_spawn_director::function_53289c032f506bb1( activity_instance.request_id_waves, &function_50559b4babad0a56, activity_instance );
    ai_spawn_director::function_c99d360d62c49a9c( activity_instance.request_id_waves, &function_e234e0613724bf6f, activity_instance );
    ai_spawn_director::function_5ee28426adb3b64b( activity_instance.request_id_waves, &function_340327de6a6663fd, activity_instance );
    ai_spawn_director::function_5a08798970350207( activity_instance.request_id_waves, &function_829ddd8b0b1fabff, activity_instance );
    activity_instance.request_id = ai_spawn_director::lookup_spawn_request( "defend_barrage_flood" );
    function_ef57f478f96b050c( activity_instance.request_id, 1 );
    ai_spawn_director::add_spawned_callback( activity_instance.request_id, &function_5ee4a8c5e0f8852b, activity_instance );
    ai_spawn_director::function_53289c032f506bb1( activity_instance.request_id, &should_shutdown_barrage, activity_instance );
    ai_spawn_director::function_c99d360d62c49a9c( activity_instance.request_id, &should_spawn_barrage, activity_instance );
    ai_spawn_director::function_5ee28426adb3b64b( activity_instance.request_id, &function_96a9fc8773437900, activity_instance );
}

/#

    // Namespace mp_sat_ob_gemini_activity_cabin_barrage
    // Params 0
    // Checksum 0xdcf8d987, Offset: 0x11d6
    // Size: 0x5, Type: dev
    function function_17e5328f9bac452()
    {
        
    }

#/

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 0
// Checksum 0x66fe6be9, Offset: 0x11e3
// Size: 0x1f4
function function_7c3de40e2a1a865d()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    activity_instance.var_dc3fee4cc28a6b0a = 1;
    function_1a9d724a960fa19d( activity_instance.request_id_waves, "Wave1", 1 );
    var_5f81aced2f5d2e51 = utility::getstruct( "cabin_center_struct", "targetname" );
    earthquake( 0.4, 1.25, var_5f81aced2f5d2e51.origin, 1500 );
    playrumbleonposition( "artillery_rumble_light", var_5f81aced2f5d2e51.origin );
    activity_instance thread function_e1144fbe3ab21df9( 1 );
    activity_instance.should_spawn_waves = 1;
    activity_instance.var_4513a97242d9f897 = 1;
    level utility::flag_set( "flag_cabin_barrage_wave1_begin" );
    activity_instance waittill( #"finished_spawning_wave" );
    activity_instance function_39086eb217816795( undefined, "flag_cabin_barrage_wave1_complete" );
    level utility::flag_set( "flag_cabin_barrage_wave1_complete" );
    wait 6;
    level utility::flag_wait_or_timeout( "FLAG_TRIG_CABIN_BARRAGE_WAVE2_NEAR", 7.5 );
    function_1a9d724a960fa19d( activity_instance.request_id_waves, "Wave1", 0 );
    function_1a9d724a960fa19d( activity_instance.request_id_waves, "Wave2", 1 );
    var_5f81aced2f5d2e51 = utility::getstruct( "cabin_center_struct", "targetname" );
    earthquake( 0.4, 1.25, var_5f81aced2f5d2e51.origin, 1500 );
    playrumbleonposition( "artillery_rumble_light", var_5f81aced2f5d2e51.origin );
    activity_instance thread function_e1144fbe3ab21df9( 2 );
    activity_instance.should_spawn_waves = 1;
    activity_instance.var_4513a97242d9f897 = 1;
    level utility::flag_set( "flag_cabin_barrage_wave2_begin" );
    activity_instance waittill( #"finished_spawning_wave" );
    activity_instance function_39086eb217816795( 0, "flag_cabin_barrage_wave2_complete" );
    level utility::flag_set( "flag_cabin_barrage_wave2_complete" );
    wait 10;
    activity_instance.var_dc3fee4cc28a6b0a = 0;
}

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 2, eflags: 0x4
// Checksum 0xa03eebae, Offset: 0x13df
// Size: 0x111
function private function_39086eb217816795( remaining_threshold = 2, var_68b32a8bafee7061 )
{
    activity_instance = self;
    level endon( var_68b32a8bafee7061 );
    activity_instance childthread function_1b79b3c9a19344df( remaining_threshold, var_68b32a8bafee7061 );
    
    if ( true )
    {
        msg = activity_instance utility::waittill_notify_or_timeout_return( "NOTIFY_BARRAGE_WAVE_CLEARED", 120 );
        
        if ( msg == "timeout" )
        {
            /#
                iprintlnbold( "<dev string:x24>" );
            #/
            
            var_f0884db07cf9f4fc = getaiarray( "team_two_hundred" );
            
            if ( var_f0884db07cf9f4fc.size > 0 )
            {
                foreach ( ai in var_f0884db07cf9f4fc )
                {
                    if ( isdefined( ai ) )
                    {
                        ai kill();
                    }
                }
            }
        }
        
        return;
    }
    
    activity_instance waittill( #"NOTIFY_BARRAGE_WAVE_CLEARED" );
}

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 2, eflags: 0x4
// Checksum 0x9eb2846a, Offset: 0x14f8
// Size: 0x74
function private function_1b79b3c9a19344df( remaining_threshold = 2, var_68b32a8bafee7061 )
{
    activity_instance = self;
    activity_instance endon( var_68b32a8bafee7061 );
    
    for ( remaining = ai_spawn_director::function_5d069e637e2d0a05( activity_instance.request_id_waves ); remaining.size > remaining_threshold ; remaining = utility::array_removedead_or_dying( remaining ) )
    {
        wait 0.1;
    }
    
    activity_instance notify( #"NOTIFY_BARRAGE_WAVE_CLEARED" );
}

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 0
// Checksum 0x3f6cbe2d, Offset: 0x1574
// Size: 0x17f
function function_8072079989afca4e()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    level utility::flag_set( "flag_cabin_barrage_flood_begin" );
    activity_instance.var_45aed4e0bf4e771c = [];
    activity_instance.spawn_delay_base = 1.3;
    activity_instance.var_3cf923b98b1e9fb2 = 14;
    activity_instance thread function_d3c056ce5f363d11();
    activity_instance thread function_8dee2fb70b2f1b10();
    activity_instance thread function_cc55a8476a750166();
    
    while ( activity_instance.barrage_active )
    {
        activity_instance.should_spawn = 1;
        activity_instance.var_45aed4e0bf4e771c = utility::array_removedead_or_dying( activity_instance.var_45aed4e0bf4e771c );
        
        if ( activity_instance.var_45aed4e0bf4e771c.size < 8 )
        {
            wait 0.1;
            continue;
        }
        
        if ( activity_instance.var_45aed4e0bf4e771c.size < activity_instance.var_3cf923b98b1e9fb2 )
        {
            wait activity_instance.spawn_delay_base;
            continue;
        }
        
        wait randomfloatrange( activity_instance.spawn_delay_base + 0.55, activity_instance.spawn_delay_base + 1.1 );
    }
    
    request_id = ai_spawn_director::lookup_spawn_request( "defend_barrage_flood" );
    function_17ee483eb76a9759( request_id, 1 );
    
    /#
        iprintlnbold( "<dev string:x39>" );
    #/
    
    level utility::flag_set( "flag_cabin_barrage_flood_complete" );
    level utility::flag_set( "OB_GEMINI_CABIN_BARRAGE_COMPLETE" );
    activity_instance notify( #"NOTIFY_BARRAGE_PLAYERS_ELIMINATED" );
}

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 0
// Checksum 0x1837ca6b, Offset: 0x16fb
// Size: 0x1bf
function function_d3c056ce5f363d11()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    activity_instance.var_38056ced8afa8351 = level.onsquadeliminated;
    level.onsquadeliminated = &function_997135e21bf47924;
    
    if ( !level callback::exists( #"player_laststand", &function_990f1260b61ff451 ) )
    {
        level callback::add( #"player_laststand", &function_990f1260b61ff451 );
    }
    
    msg = activity_instance utility::waittill_notify_or_timeout_return( "NOTIFY_BARRAGE_PLAYERS_ELIMINATED", 60 );
    level.var_daa8e6704828e14f = 1;
    
    if ( level.players.size > 0 )
    {
        squad = teams::function_72b89edf6b47c40a( level.players[ 0 ] );
    }
    
    if ( msg == "timeout" )
    {
        foreach ( player in level.players )
        {
            if ( isalive( player ) && !player::isinlaststand( player ) )
            {
                player dodamage( 9999, player.origin, player, undefined, "MOD_EXPLOSIVE" );
            }
        }
        
        if ( squad )
        {
            squad thread function_997135e21bf47924( level.players, 0 );
        }
    }
    
    while ( level.var_d5275206e2c2606c )
    {
        waitframe();
    }
    
    activity_instance.barrage_active = 0;
    activity_instance notify( #"hash_4db7d8af0a6d51a" );
}

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 1
// Checksum 0xbe06d2ee, Offset: 0x18c2
// Size: 0x7a
function function_990f1260b61ff451( params )
{
    player = self;
    player.barrage_self_revive_count = player laststand::function_7072b516e6cffb7c();
    player laststand::function_39844c1e879cc048( 0 );
    superref = supers_mp::getcurrentsuperref();
    
    if ( superref == "super_survival_life_drain" )
    {
        player val::set( "gemini_cabin_barrage", "supers", 0 );
        player supers_mp::setsuperexpended( 1, #"default" );
    }
}

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 0
// Checksum 0x8f76e2c6, Offset: 0x1944
// Size: 0xc5
function function_8dee2fb70b2f1b10()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    var_5f81aced2f5d2e51 = utility::getstruct( "cabin_center_struct", "targetname" );
    
    for ( var_36ffee45bee14163 = 0; var_36ffee45bee14163 < 4 ; var_36ffee45bee14163++ )
    {
        activity_instance notify( "Checkpoint " + var_36ffee45bee14163 );
        wait 15;
        earthquake( 0.325, 1, var_5f81aced2f5d2e51.origin, 1000 );
        playrumbleonposition( "artillery_rumble_light", var_5f81aced2f5d2e51.origin );
        
        if ( var_36ffee45bee14163 == 0 )
        {
            activity_instance thread function_e1144fbe3ab21df9( 3 );
            continue;
        }
        
        activity_instance thread function_e1144fbe3ab21df9( 4 );
    }
}

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 0
// Checksum 0x6820bebf, Offset: 0x1a11
// Size: 0x2a4
function function_cc55a8476a750166()
{
    activity_instance = self;
    activity_instance endon( #"hash_4db7d8af0a6d51a", #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    bucket_tags = [ "Barrage1", "Barrage2", "Barrage3" ];
    function_1a9d724a960fa19d( activity_instance.request_id, bucket_tags[ 0 ], 1 );
    level thread ob_adz::function_f94c18166de9f51d( level.var_e07082c4f4aa4a97.zone_id, undefined, 475, 69 );
    exclusioncircle = level.exclusionzones[ level.var_e07082c4f4aa4a97.var_e0dd4b03666cb7e8 ];
    exclusioncircle thread exclusion_zones::function_a1a887e23f767ba0( ( 950, 950, 0 ), 69 );
    activity_instance waittill( #"hash_c70543179e179d74" );
    function_1a9d724a960fa19d( activity_instance.request_id, bucket_tags[ 0 ], 0 );
    function_1a9d724a960fa19d( activity_instance.request_id, bucket_tags[ 1 ], 1 );
    activity_instance.spawn_delay_base -= 0.35;
    activity_instance.var_3cf923b98b1e9fb2 += 8;
    activity_instance.var_e521341747d186ca++;
    activity_instance.var_64239142c93ebf88++;
    activity_instance waittill( #"hash_c70546179e17a28d" );
    level thread ob_adz::function_f94c18166de9f51d( level.var_e07082c4f4aa4a97.zone_id, undefined, 1, 30 );
    exclusioncircle = level.exclusionzones[ level.var_e07082c4f4aa4a97.var_e0dd4b03666cb7e8 ];
    exclusioncircle thread exclusion_zones::function_a1a887e23f767ba0( ( 2, 2, 0 ), 30 );
    function_1a9d724a960fa19d( activity_instance.request_id, bucket_tags[ 1 ], 0 );
    function_1a9d724a960fa19d( activity_instance.request_id, bucket_tags[ 2 ], 1 );
    activity_instance.spawn_delay_base -= 0.35;
    activity_instance.var_3cf923b98b1e9fb2 += 8;
    activity_instance.var_e521341747d186ca++;
    activity_instance.var_64239142c93ebf88++;
    activity_instance waittill( #"hash_c70545179e17a0da" );
    activity_instance.spawn_delay_base -= 0.35;
    activity_instance.var_3cf923b98b1e9fb2 += 8;
    activity_instance.var_e521341747d186ca++;
    activity_instance.var_64239142c93ebf88++;
}

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 0
// Checksum 0xd6a5c576, Offset: 0x1cbd
// Size: 0x130
function function_365f142eaf6cdf42()
{
    activity_instance = self;
    ob_adz::function_a5e080cd4acacc53( level.var_e07082c4f4aa4a97.zone_id );
    exclusioncircle = level.exclusionzones[ level.var_e07082c4f4aa4a97.var_e0dd4b03666cb7e8 ];
    exclusion_zones::function_5fc2ac1152c0aa19( exclusioncircle );
    waitframe();
    var_399a0f97e8cb8e0b = utility::getstruct( "cabin_center_struct", "targetname" );
    gemini_util::function_b95c324c7b2d9f63( var_399a0f97e8cb8e0b.origin, 8000, undefined, level.var_45aed4e0bf4e771c );
    activity_ai_encounters::function_2574b40bde3bd456( 1 );
    
    if ( level.cabin_repulsors )
    {
        foreach ( nav_name in level.cabin_repulsors )
        {
            destroynavrepulsor( nav_name );
        }
    }
    
    level.cabin_repulsors = undefined;
    activity_instance thread function_cf0a508181692e53();
}

/#

    // Namespace mp_sat_ob_gemini_activity_cabin_barrage
    // Params 0
    // Checksum 0x6335528f, Offset: 0x1df5
    // Size: 0x5, Type: dev
    function function_98e9d1924b747028()
    {
        
    }

#/

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 2, eflags: 0x4
// Checksum 0x97e6458f, Offset: 0x1e02
// Size: 0x2f, Type: bool
function private should_shutdown_barrage( requestid, userdata )
{
    if ( !userdata.barrage_active )
    {
        function_b43716082f77e5e5( requestid );
        return true;
    }
    
    return false;
}

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 2, eflags: 0x4
// Checksum 0xf7303d3e, Offset: 0x1e3a
// Size: 0x21, Type: bool
function private function_50559b4babad0a56( requestid, userdata )
{
    return !userdata.var_dc3fee4cc28a6b0a;
}

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 2, eflags: 0x4
// Checksum 0x9b86dcbd, Offset: 0x1e64
// Size: 0x20
function private should_spawn_barrage( requestid, userdata )
{
    return userdata.should_spawn;
}

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 2, eflags: 0x4
// Checksum 0xd17d679, Offset: 0x1e8d
// Size: 0x20
function private function_e234e0613724bf6f( requestid, userdata )
{
    return userdata.should_spawn_waves;
}

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 2, eflags: 0x4
// Checksum 0x9d730b5c, Offset: 0x1eb6
// Size: 0x29
function private function_96a9fc8773437900( request_id, userdata )
{
    userdata.should_spawn = 0;
    function_fbe9bb47edbe2d7c( request_id );
}

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 2, eflags: 0x4
// Checksum 0x1f4ea3de, Offset: 0x1ee7
// Size: 0x29
function private function_340327de6a6663fd( request_id, userdata )
{
    userdata.should_spawn_waves = 0;
    function_fbe9bb47edbe2d7c( request_id );
}

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 2, eflags: 0x4
// Checksum 0x8bc34180, Offset: 0x1f18
// Size: 0x43
function private function_829ddd8b0b1fabff( request_id, userdata )
{
    remaining = ai_spawn_director::function_5d069e637e2d0a05( request_id );
    userdata notify( #"finished_spawning_wave" );
    userdata.var_4513a97242d9f897 = 0;
}

/#

    // Namespace mp_sat_ob_gemini_activity_cabin_barrage
    // Params 0
    // Checksum 0xb78b5b23, Offset: 0x1f63
    // Size: 0x5, Type: dev
    function function_b6a39f84f1c0b92c()
    {
        
    }

#/

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 4, eflags: 0x4
// Checksum 0x94717492, Offset: 0x1f70
// Size: 0x1ed
function private function_5ee4a8c5e0f8852b( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    var_399a0f97e8cb8e0b = utility::getstruct( "cabin_center_struct", "targetname" );
    agent setgoalpos( var_399a0f97e8cb8e0b.origin, 1000 );
    agent function_fa32376aaa88a7a2( var_399a0f97e8cb8e0b.origin, 5280 );
    randomspeed = randomintrange( 0, 10 ) + userdata.var_e521341747d186ca;
    
    if ( randomspeed > 8 && level utility::flag( "flag_cabin_barrage_flood_begin" ) )
    {
        ai_move_speed = "super_sprint";
    }
    else if ( randomspeed > 4 && level utility::flag( "flag_cabin_barrage_wave2_begin" ) )
    {
        ai_move_speed = "sprint";
    }
    else
    {
        ai_move_speed = "run";
    }
    
    agent zombie_utils::function_a8ce00e0448cb6f0( ai_move_speed, "Barrage", 25 );
    
    if ( level utility::flag( "flag_cabin_barrage_flood_begin" ) )
    {
        ai_difficulty = "difficulty_med";
    }
    else
    {
        ai_difficulty = "difficulty_low";
        agent val::set( "barrage_spawn", "allow_dismember", 0 );
    }
    
    agent ob_story_mission_utils::function_ac2a2440f56b2342( ai_difficulty );
    agent namespace_659599414270bd0a::function_80623a2279a4d888();
    agent val::set( "barrage_spawn", "dont_evolve" );
    agent utility::ent_flag_set( "ghoul_evolve_disabled" );
    agent forcethreatupdate();
    
    if ( !level utility::flag( "flag_cabin_barrage_wave1_complete" ) )
    {
        userdata.should_spawn_waves = 0;
    }
    
    if ( !level utility::flag( "flag_cabin_barrage_wave2_complete" ) )
    {
        userdata.should_spawn_waves = 0;
    }
    
    if ( level utility::flag( "flag_cabin_barrage_flood_begin" ) )
    {
        userdata.should_spawn = 0;
        userdata.var_45aed4e0bf4e771c[ userdata.var_45aed4e0bf4e771c.size ] = agent;
    }
    
    agent thread function_390e79cb196862c6( ai_move_speed );
}

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 1, eflags: 0x4
// Checksum 0xcc73b2c2, Offset: 0x2165
// Size: 0x10c
function private function_390e79cb196862c6( ai_move_speed = "run" )
{
    agent = self;
    agent endon( #"death" );
    var_a8e8b7b08c3d7f84 = 0;
    
    while ( true )
    {
        if ( agent utility::ent_flag( "adz_active" ) && !var_a8e8b7b08c3d7f84 )
        {
            var_423993adf5071246 = "super_sprint";
            
            switch ( ai_move_speed )
            {
                case #"hash_bdea5e7441323370":
                    var_423993adf5071246 = "run";
                    break;
                case #"hash_9710f96c58beeaaa":
                    var_423993adf5071246 = "sprint";
                    break;
                case #"hash_eb06fed69a41dab5":
                default:
                    var_423993adf5071246 = "super_sprint";
                    break;
            }
            
            agent zombie_utils::function_a8ce00e0448cb6f0( var_423993adf5071246, "Barrage", 25 );
            var_a8e8b7b08c3d7f84 = 1;
        }
        else if ( !agent utility::ent_flag( "adz_active" ) && var_a8e8b7b08c3d7f84 )
        {
            agent zombie_utils::function_a8ce00e0448cb6f0( ai_move_speed, "Barrage", 25 );
            var_a8e8b7b08c3d7f84 = 0;
        }
        
        wait 1;
    }
}

/#

    // Namespace mp_sat_ob_gemini_activity_cabin_barrage
    // Params 0
    // Checksum 0xd2bb6ef5, Offset: 0x2279
    // Size: 0x5, Type: dev
    function function_9e0f0cbb40f0bfe6()
    {
        
    }

#/

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 0, eflags: 0x4
// Checksum 0xa02b9df5, Offset: 0x2286
// Size: 0x1c8
function private function_ccef03910379998f()
{
    activity_instance = self;
    ob_story_mission_utils::objective_text_show( "OB_GEMINI_CABIN_RETURN" );
    mission_ui::function_759924b87215156b( 0, 1, level.players );
    activity_instance.obj_id = gemini_util::function_70fecc661764c00a( "s_barrage_mason_interact", undefined, 32, "targetname", "sat_ob_objectivemarker_storymissionmain" );
    level utility::flag_wait( "flag_cabin_barrage_check_on_alex_start" );
    mission_ui::function_759924b87215156b( 1, 1, level.players );
    level utility::flag_wait( "flag_cabin_barrage_wave1_callout" );
    ob_story_mission_utils::objective_text_clear();
    ob_story_mission_utils::objective_marker_clear( activity_instance.obj_id );
    mission_ui::function_759924b87215156b( 0, 0, level.players );
    waitframe();
    ob_story_mission_utils::objective_text_show( "OB_GEMINI_CABIN_BARRAGE" );
    missionasset = %"hash_1064229759d64c0d";
    options = spawnstruct();
    options.step = 0;
    options.var_cf684f09b6c37c3a = 1;
    activity_instance namespace_b451b5202140ccde::function_bb923ce693c606f9( missionasset, level.players, options );
    activity_instance mission_ui::function_759924b87215156b( 0, 1, level.players );
    activity_instance.obj_id_front = gemini_util::function_70fecc661764c00a( "s_obj_cabin_barrage_wave_east", undefined, 72, "targetname", "sat_ob_objectivemarker_storymissionmain" );
    activity_instance childthread function_41b2b514331a748d( "flag_cabin_barrage_wave1_begin", "flag_cabin_barrage_wave1_complete", activity_instance.obj_id_front );
    level utility::flag_wait_all( "flag_cabin_barrage_wave1_complete", "flag_cabin_barrage_wave2_callout" );
    activity_instance.obj_id_back = gemini_util::function_70fecc661764c00a( "s_obj_cabin_barrage_wave_west", undefined, 72, "targetname", "sat_ob_objectivemarker_storymissionmain" );
    activity_instance childthread function_41b2b514331a748d( "flag_cabin_barrage_wave2_begin", "flag_cabin_barrage_wave2_complete", activity_instance.obj_id_back );
    level utility::flag_wait( "OB_GEMINI_CABIN_BARRAGE_COMPLETE" );
    ob_story_mission_utils::objective_text_clear();
}

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 3, eflags: 0x4
// Checksum 0x36d94112, Offset: 0x2456
// Size: 0x3d
function private function_41b2b514331a748d( var_e63a3644d95c7a57, var_8e812dc05af3bc8a, obj_id )
{
    level utility::flag_wait( var_e63a3644d95c7a57 );
    level utility::flag_wait_or_timeout( var_8e812dc05af3bc8a, 10 );
    ob_story_mission_utils::objective_marker_clear( obj_id );
}

/#

    // Namespace mp_sat_ob_gemini_activity_cabin_barrage
    // Params 0
    // Checksum 0xb0337404, Offset: 0x249b
    // Size: 0x5, Type: dev
    function function_7be04a88994695fc()
    {
        
    }

#/

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 1, eflags: 0x4
// Checksum 0x57cb9e28, Offset: 0x24a8
// Size: 0x1d3
function private function_e1144fbe3ab21df9( var_4d498360d411d687 )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    b_flash = 0;
    n_duration_timer = 3;
    var_1a177ad1272f8d87 = 0;
    
    if ( !isdefined( activity_instance.cradle_lvl ) )
    {
        activity_instance.cradle_lvl = undefined;
    }
    
    switch ( var_4d498360d411d687 )
    {
        case 1:
            b_flash = 1;
            activity_instance.cradle_lvl = "light";
            var_1a177ad1272f8d87 = 0;
            n_duration_timer = 1.5;
            break;
        case 2:
            b_flash = 1;
            activity_instance.cradle_lvl = "medium";
            var_1a177ad1272f8d87 = 0;
            n_duration_timer = 3;
            break;
        case 3:
            b_flash = 1;
            activity_instance.cradle_lvl = "heavy";
            var_1a177ad1272f8d87 = 1;
            n_duration_timer = 4.5;
            break;
        case 4:
            b_flash = 0;
            activity_instance.cradle_lvl = "medium";
            var_1a177ad1272f8d87 = 2;
            n_duration_timer = 3;
            break;
        default:
            break;
    }
    
    foreach ( player in level.players )
    {
        player thread function_ad2ce6d83f7603ab( activity_instance.cradle_lvl, n_duration_timer, var_1a177ad1272f8d87, 0, b_flash );
    }
}

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 0, eflags: 0x4
// Checksum 0xd9182760, Offset: 0x2683
// Size: 0xa1
function private function_cf0a508181692e53()
{
    activity_instance = self;
    level endon( #"game_ended" );
    
    foreach ( player in level.players )
    {
        player thread function_ad2ce6d83f7603ab( activity_instance.cradle_lvl, 0, 0, 1 );
    }
}

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 5, eflags: 0x4
// Checksum 0x69d5a527, Offset: 0x272c
// Size: 0x133
function private function_ad2ce6d83f7603ab( cradle_lvl = "light", n_duration_timer, var_1a177ad1272f8d87 = 0, b_stop = 0, b_flash = 0 )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    if ( cradle_lvl == "light" )
    {
        var_fc96227a0770f8b = %"sat_mp_sat_lm_avalon_ob_cradle_md_01";
        var_8def05725437e887 = "cradle_influence_vfx_light";
    }
    else if ( cradle_lvl == "medium" )
    {
        var_fc96227a0770f8b = %"sat_mp_sat_lm_avalon_ob_cradle_md_02";
        var_8def05725437e887 = "cradle_influence_vfx_medium";
    }
    else if ( cradle_lvl == "heavy" )
    {
        var_fc96227a0770f8b = %"sat_mp_sat_lm_avalon_ob_cradle_md_03";
        var_8def05725437e887 = "cradle_influence_vfx_heavy";
    }
    
    if ( b_stop )
    {
        emp_debuff::clear_emp_scramble();
        namespace_a350a26c6d662a6a::function_10887bb6792fea1c( self, var_fc96227a0770f8b, undefined, var_8def05725437e887 );
        return;
    }
    
    if ( b_flash )
    {
        pbgpostfxbundlestart( self, %"sat_cradle_ambient_stage_flash" );
        wait 0.1;
    }
    
    if ( var_1a177ad1272f8d87 > 0 )
    {
        emp_debuff::play_emp_scramble( var_1a177ad1272f8d87 );
    }
    
    level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( cradle_lvl, n_duration_timer, undefined, [ self ] );
}

/#

    // Namespace mp_sat_ob_gemini_activity_cabin_barrage
    // Params 0
    // Checksum 0x4d50b25a, Offset: 0x2867
    // Size: 0x5, Type: dev
    function function_b42e6ffdac0ecc0d()
    {
        
    }

#/

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 0, eflags: 0x4
// Checksum 0x4eccfd22, Offset: 0x2874
// Size: 0x11d
function private function_2bdf3a3e911ad061()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended", #"OB_GEMINI_CABIN_BARRAGE_COMPLETE" );
    trig = getnoentvolumearray( "cabin_interior_trigger", #targetname )[ 0 ];
    
    while ( true )
    {
        a_zombies = getaiarray( "team_two_hundred", "team_hundred_ninety" );
        
        foreach ( zombie in a_zombies )
        {
            if ( !isalive( zombie ) )
            {
                waitframe();
                continue;
            }
            
            if ( zombie istouching( trig ) )
            {
                zombie utility::ent_flag_set( "flag_cabin_barrage_zombie_inside" );
            }
            else
            {
                zombie utility::ent_flag_clear( "flag_cabin_barrage_zombie_inside" );
            }
            
            waitframe();
        }
        
        wait 1;
    }
}

/#

    // Namespace mp_sat_ob_gemini_activity_cabin_barrage
    // Params 0
    // Checksum 0xb863d8a, Offset: 0x2999
    // Size: 0x5, Type: dev
    function function_d01ad6ef81ffb75c()
    {
        
    }

#/

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 2, eflags: 0x4
// Checksum 0x3392bede, Offset: 0x29a6
// Size: 0x24a
function private function_997135e21bf47924( a_squad_players, var_958151dbd0f282ec )
{
    if ( level.var_d5275206e2c2606c )
    {
        return;
    }
    
    level.var_d5275206e2c2606c = 1;
    level.var_daa8e6704828e14f = 1;
    
    foreach ( player in a_squad_players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player.powertier = undefined;
        level thread game_utility::fadetoblackforplayer( player, 1, 0.8 );
    }
    
    wait 0.9;
    
    foreach ( player in a_squad_players )
    {
        if ( player.sessionstate == "playing" && isalive( player ) )
        {
            player kill();
        }
    }
    
    waitframe();
    
    foreach ( player in a_squad_players )
    {
        player teamrevive::respawn();
    }
    
    level.var_d5275206e2c2606c = undefined;
    level.activity_instance notify( #"NOTIFY_BARRAGE_PLAYERS_ELIMINATED" );
    
    foreach ( player in a_squad_players )
    {
        if ( isdefined( player ) )
        {
            level thread function_23aab232c8dc692e( player );
        }
    }
}

// Namespace mp_sat_ob_gemini_activity_cabin_barrage
// Params 1, eflags: 0x4
// Checksum 0x6ed2a2b6, Offset: 0x2bf8
// Size: 0x6f
function private function_23aab232c8dc692e( player )
{
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    msg = player utility::waittill_any_timeout( 10, "notify_prison_intro_cinematic_starting" );
    
    /#
        if ( msg == "<dev string:x4a>" )
        {
            println( "<dev string:x52>" );
        }
    #/
    
    if ( player )
    {
        game_utility::fadetoblackforplayer( player, 0, 0.1 );
    }
}

