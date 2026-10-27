// script_6ea21b1569e5c662  (hash_6ea21b1569e5c662.gscc) (size: 2281 Bytes / 0x8e9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x209dd3b9 (547214265)
// size ...... 2281 (0x8e9)
// includes .. 8   (offset: 0x81d)
// strings ... 10  (offset: 0x85d)
// dev strs .. 0   (offset: 0x8e9)
// exports ... 11  (offset: 0x40d)
// cseg ...... 0x184 + 0x289 (0x40d)
// imports ... 21  (offset: 0x5c5)
// animtree1 . 0   (offset: 0x8e9)
// animtree2 . 0   (offset: 0x8e9)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_util;

#namespace namespace_ffe59e3292ddd682;

/#

    // Namespace namespace_ffe59e3292ddd682
    // Params 0
    // Checksum 0x56e4d9dc, Offset: 0x1a2
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_ffe59e3292ddd682
// Params 0, eflags: 0x5
// Checksum 0x3f058394, Offset: 0x1af
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_dc8dc30b621a69fb", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_ffe59e3292ddd682
// Params 0, eflags: 0x4
// Checksum 0xcc04d2dc, Offset: 0x1d8
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LIBRA_IGC_BOSS_INTRO";
    activity_common::registeractivitytype( "OB_LIBRA_IGC_BOSS_INTRO", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_IGC_BOSS_INTRO", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_IGC_BOSS_INTRO", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_IGC_BOSS_INTRO", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_ffe59e3292ddd682
// Params 0
// Checksum 0x96cc5e80, Offset: 0x239
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

// Namespace namespace_ffe59e3292ddd682
// Params 0
// Checksum 0x99a17f33, Offset: 0x29e
// Size: 0x47
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    activity_instance main();
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_ffe59e3292ddd682
// Params 0
// Checksum 0xcbd34223, Offset: 0x2ed
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_ffe59e3292ddd682
// Params 0
// Checksum 0xcdb11325, Offset: 0x311
// Size: 0xe
function setup_ui_widget()
{
    ob_story_mission_utils::objective_text_show( "OB_LIBRA_IGC_BOSS_INTRO" );
}

/#

    // Namespace namespace_ffe59e3292ddd682
    // Params 0
    // Checksum 0x115e7dcc, Offset: 0x327
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_ffe59e3292ddd682
// Params 0
// Checksum 0xda4830d, Offset: 0x334
// Size: 0x2
function start()
{
    
}

// Namespace namespace_ffe59e3292ddd682
// Params 0
// Checksum 0xcf0217ea, Offset: 0x33e
// Size: 0xcf
function main()
{
    activity_instance = self;
    activity_instance setup_ui_widget();
    level thread mp_sat_ob_libra_util::function_96910d9608e728ce( "armory_to_processing_door_trigger", #script_noteworthy, 1 );
    thread mp_sat_ob_libra_util::function_cabd5f53e8d27f19( [ "hoist_interact_scene_a", "hoist_interact_scene_b" ] );
    level utility::flag_wait( "story_mission_party_check_complete" );
    options = spawnstruct();
    options.structs = ob_story_mission_utils::get_activity_starts( "OB_LIBRA_BOSS_1" );
    options.timeout = 95;
    options.flag_countdown = "flag_boss_intro_regroup_countdown_finished";
    options.countdown = -1;
    utility::flag_set( "flag_igc_boss_intro_start" );
    coop::play_cinematic( "sat_libra_boss_intro", options );
    utility::flag_set( "flag_igc_boss_intro_done" );
}

