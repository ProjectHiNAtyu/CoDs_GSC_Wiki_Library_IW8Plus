// scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_activity_cabin_initialmemory.gsc  (hash_002aa4ba3c6860c9.gscc) (size: 5392 Bytes / 0x1510 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf3be6217 (4089340439)
// size ...... 5392 (0x1510)
// includes .. 12  (offset: 0x1330)
// strings ... 26  (offset: 0x1390)
// dev strs .. 1   (offset: 0x1504)
// exports ... 13  (offset: 0xb98)
// cseg ...... 0x363 + 0x835 (0xb98)
// imports ... 48  (offset: 0xda0)
// animtree1 . 0   (offset: 0x1510)
// animtree2 . 0   (offset: 0x1510)
#using script_2399696a9d953451;
#using script_4c1e16e1162d066f;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_exclusion_zone;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_scenes;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_util;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_vo;

#namespace namespace_59d718ab43872b7e;

// Namespace namespace_59d718ab43872b7e
// Params 0, eflags: 0x5
// Checksum 0x432c6f3, Offset: 0x381
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_6c74db23a4e7e375", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_59d718ab43872b7e
// Params 0, eflags: 0x4
// Checksum 0x54ea3332, Offset: 0x3aa
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_GEMINI_CABIN_INITIALMEMORY";
    activity_common::registeractivitytype( "OB_GEMINI_CABIN_INITIALMEMORY", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_CABIN_INITIALMEMORY", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_CABIN_INITIALMEMORY", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_CABIN_INITIALMEMORY", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_GEMINI_CABIN_INITIALMEMORY" );
}

// Namespace namespace_59d718ab43872b7e
// Params 0
// Checksum 0x674ec0e4, Offset: 0x421
// Size: 0x59
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance cabin_initialmemory_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_59d718ab43872b7e
// Params 0
// Checksum 0xcb6cf109, Offset: 0x482
// Size: 0x39
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance cabin_initialmemory_main();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_59d718ab43872b7e
// Params 0
// Checksum 0x1a89bfdf, Offset: 0x4c3
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_59d718ab43872b7e
// Params 1
// Checksum 0x6c566c34, Offset: 0x4e7
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread cabin_initialmemory_player_setup( player );
    }
}

// Namespace namespace_59d718ab43872b7e
// Params 0
// Checksum 0xe5326c93, Offset: 0x5a3
// Size: 0xa0
function cabin_initialmemory_start()
{
    activity_instance = self;
    gemini_util::function_34a3d0cff5de2d7d();
    gemini_util::function_dfcbf5f9b3b2e6a0();
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_cabin_pickups_equipment_wilderness", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1, undefined, 0.5, 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_cabin_pickups_weapon_wilderness", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1 );
    
    if ( !level.is_squad_size_small )
    {
        activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_cabin_pickups_equipment_wilderness_large", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1, undefined, 0.5, 1 );
        activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_cabin_pickups_weapon_wilderness_large", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1 );
    }
    
    activity_instance thread namespace_60d9b3cbf41663fe::function_b4dbb2fd9f18d56f();
    activity_instance thread namespace_60d9b3cbf41663fe::function_ec29754525c1de62();
}

// Namespace namespace_59d718ab43872b7e
// Params 0
// Checksum 0x8b41e6db, Offset: 0x64b
// Size: 0x204
function cabin_initialmemory_main()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level.var_d53163b0ef2a4488 = 1;
    var_9e472a4bc3193fdb = getscriptablearray( "mcz_initial_interact", #targetname )[ 0 ];
    var_9e472a4bc3193fdb setscriptablepartstate( "base", "disabled" );
    activity_instance function_64d4548f43edbd35( 0 );
    activity_instance childthread gemini_vo::function_5a4e8e2e85c844bc();
    activity_instance childthread function_a650589bbe2a2ba0();
    level utility::flag_wait( "flag_cabin_initialmemory_memory_appear" );
    level.current_capture_zone = activity_instance gemini_util::init_cabin_mcz( "mcz_initial", "OB_GEMINI_CABIN_INITIALMEMORY_COMPLETE", 20, 2, undefined, 1, 1, "ring_quarter" );
    level ob_adz::function_86ebf122bc776db5( 1 );
    level.var_e07082c4f4aa4a97 = ob_adz::function_47e86714392d46b4( "cabin_center_struct", 2000, 1 );
    level thread ob_adz::function_f94c18166de9f51d( level.var_e07082c4f4aa4a97.zone_id, undefined, 675, 30 );
    exclusioncircle = level.exclusionzones[ level.var_e07082c4f4aa4a97.var_e0dd4b03666cb7e8 ];
    exclusioncircle thread exclusion_zones::function_a1a887e23f767ba0( ( 1350, 1350, 0 ), 30 );
    activity_instance thread gemini_util::function_fe0b04783865b1e7( level.var_e07082c4f4aa4a97 );
    a_structs = utility::getstructarray( "gemini_p2_adz_safety_teleport", "targetname" );
    
    foreach ( player in level.players )
    {
        player thread gemini_util::function_7da3d7491a75f0a8( a_structs );
    }
    
    level utility::flag_wait( "OB_GEMINI_MCZ_CHECKPOINT_INITIAL_START" );
    activity_instance function_64d4548f43edbd35( 1 );
    activity_instance utility::flag_wait( "OB_GEMINI_CABIN_INITIALMEMORY_COMPLETE" );
}

// Namespace namespace_59d718ab43872b7e
// Params 1
// Checksum 0xdc297904, Offset: 0x857
// Size: 0x3b
function cabin_initialmemory_player_setup( player )
{
    activity_instance = self;
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
    }
    
    activity_instance thread function_577f01f432ad8b39( player );
}

// Namespace namespace_59d718ab43872b7e
// Params 1
// Checksum 0x56595305, Offset: 0x89a
// Size: 0xe0
function function_64d4548f43edbd35( b_show )
{
    activity_instance = self;
    fireplace_lights = function_92805cf2b0baa4ca( [ "light_fireplace_001", "light_fireplace_002" ], #targetname );
    
    if ( fireplace_lights.size <= 0 )
    {
        /#
            iprintlnbold( "<dev string:x24>" );
        #/
        
        return;
    }
    
    foreach ( fireplace_light in fireplace_lights )
    {
        if ( b_show )
        {
            fireplace_light setlightintensity( 1 );
            continue;
        }
        
        fireplace_light setlightintensity( 0 );
    }
}

// Namespace namespace_59d718ab43872b7e
// Params 0, eflags: 0x4
// Checksum 0x790798ee, Offset: 0x982
// Size: 0x1a4
function private function_a650589bbe2a2ba0()
{
    activity_instance = self;
    ob_story_mission_utils::objective_text_show( "OB_GEMINI_CABIN_WILDERNESS_APPROACH" );
    mission_ui::function_759924b87215156b( 1, 1, level.players );
    activity_instance.obj_id = gemini_util::function_70fecc661764c00a( "s_barrage_mason_interact", undefined, 32, "targetname", "sat_ob_objectivemarker_storymissionmain" );
    level utility::flag_wait( "flag_cabin_initialmemory_memory_appear" );
    ob_story_mission_utils::objective_marker_clear( activity_instance.obj_id );
    waitframe();
    ob_story_mission_utils::objective_text_show( "OB_GEMINI_CABIN_INITIALMEMORY_INTERACT" );
    mission_ui::function_759924b87215156b( 0, 1, level.players );
    var_9e472a4bc3193fdb = getscriptablearray( "mcz_initial_interact", #targetname )[ 0 ];
    
    if ( !var_9e472a4bc3193fdb )
    {
        return;
    }
    
    activity_instance.obj_id = gemini_util::function_7a621dc87829fa67( var_9e472a4bc3193fdb, 32 );
    level utility::flag_wait( "flag_cabin_initialmemory_activated" );
    mission_ui::function_759924b87215156b( 1, 1, level.players );
    level utility::flag_wait( "OB_GEMINI_MCZ_CHECKPOINT_INITIAL_START" );
    ob_story_mission_utils::objective_marker_clear( activity_instance.obj_id );
    mission_ui::function_759924b87215156b( 0, 0, level.players );
    waitframe();
    missionasset = %"hash_24217f6a5756791f";
    options = spawnstruct();
    options.step = 0;
    options.var_cf684f09b6c37c3a = 1;
    options.var_e866adf65a6cef87 = 100;
    options.a_end_flag = [ "OB_GEMINI_CABIN_INITIALMEMORY_COMPLETE" ];
    activity_instance thread gemini_util::function_44166e34e7081b17( [ level.current_capture_zone ], missionasset, level.players, options );
}

// Namespace namespace_59d718ab43872b7e
// Params 1, eflags: 0x4
// Checksum 0x3c273e94, Offset: 0xb2e
// Size: 0x6a
function private function_577f01f432ad8b39( player )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level utility::flag_wait( "flag_cabin_initialmemory_activated" );
    wait 5;
    player utility::callsharedfunc( #"hint", #"add_simple", "hint_defend_circles", &"sat_ob/hint_defend_circles", 10 );
}

