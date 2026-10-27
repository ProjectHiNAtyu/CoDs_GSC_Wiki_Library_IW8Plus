// scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_activity_boss_intro.gsc  (hash_31dd37dd3818768c.gscc) (size: 2976 Bytes / 0xba0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9afba30e (2600182542)
// size ...... 2976 (0xba0)
// includes .. 9   (offset: 0xab4)
// strings ... 12  (offset: 0xafc)
// dev strs .. 0   (offset: 0xba0)
// exports ... 12  (offset: 0x564)
// cseg ...... 0x190 + 0x3d4 (0x564)
// imports ... 31  (offset: 0x744)
// animtree1 . 0   (offset: 0xba0)
// animtree2 . 0   (offset: 0xba0)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_audio;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_util;

#namespace mp_sat_ob_aries_activity_boss_intro;

/#

    // Namespace mp_sat_ob_aries_activity_boss_intro
    // Params 0
    // Checksum 0x49fd3186, Offset: 0x1ae
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace mp_sat_ob_aries_activity_boss_intro
// Params 0, eflags: 0x5
// Checksum 0x5090477e, Offset: 0x1bb
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_c20edded6755ae51", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace mp_sat_ob_aries_activity_boss_intro
// Params 0, eflags: 0x4
// Checksum 0x9aa92694, Offset: 0x1e4
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_ARIES_BOSS_INTRO";
    activity_common::registeractivitytype( "OB_ARIES_BOSS_INTRO", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_BOSS_INTRO", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_BOSS_INTRO", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_BOSS_INTRO", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_ARIES_BOSS_INTRO" );
}

// Namespace mp_sat_ob_aries_activity_boss_intro
// Params 0
// Checksum 0x6496934d, Offset: 0x25b
// Size: 0x59
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance function_7bbea8bbc47099f9();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace mp_sat_ob_aries_activity_boss_intro
// Params 0
// Checksum 0xf0d8b929, Offset: 0x2bc
// Size: 0x39
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance function_2512c852c1402b7a();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace mp_sat_ob_aries_activity_boss_intro
// Params 0
// Checksum 0xd4caaa79, Offset: 0x2fd
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace mp_sat_ob_aries_activity_boss_intro
// Params 1
// Checksum 0xfc31d1e2, Offset: 0x321
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread boss_intro_player_setup( player );
    }
}

/#

    // Namespace mp_sat_ob_aries_activity_boss_intro
    // Params 0
    // Checksum 0xe479596, Offset: 0x3dd
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace mp_sat_ob_aries_activity_boss_intro
// Params 0
// Checksum 0xfc9a5147, Offset: 0x3ea
// Size: 0x17
function function_7bbea8bbc47099f9()
{
    activity_instance = self;
    level thread aries_util::bloodpool_player_setup();
}

// Namespace mp_sat_ob_aries_activity_boss_intro
// Params 0
// Checksum 0xe4ecfb17, Offset: 0x409
// Size: 0x101
function function_2512c852c1402b7a()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_mars_arena_weapon", undefined, 1, undefined, undefined, undefined, undefined, 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_mars_arena_equipment", undefined, 1, undefined, undefined, undefined, undefined, 1 );
    activity_instance thread ob_story_mission_utils::function_fa27c4afc0f886da( "s_mars_armor_plates", undefined, 1 );
    structs = ob_story_mission_utils::get_activity_starts( "OB_ARIES_BOSS_PHASEONE" );
    level utility::flag_set( "flag_aries_boss_intro_start" );
    thread aries_audio::function_4c710b4033251aae();
    level coop::play_cinematic( "sat_aries_boss_intro", { #var_ba7c3b8fa9d3823:level.teleport_initiator, #timeout:68, #structs:structs } );
    level utility::flag_set( "flag_aries_boss_intro_end" );
    aries_util::mars_setup( activity_instance, 1 );
    activity_instance thread aries_util::waterfall_handler( "vfx_maze_transition_waterfall", "trig_waterfalls_p3" );
    showcinematicletterboxing();
    wait 2;
    hidecinematicletterboxing( 1.5, 0 );
}

// Namespace mp_sat_ob_aries_activity_boss_intro
// Params 1
// Checksum 0xf063cf4d, Offset: 0x512
// Size: 0x52
function boss_intro_player_setup( player )
{
    activity_instance = self;
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        player ob_story_mission_utils::function_2383fc8bfc3074d2();
        player ob_story_mission_utils::function_288fdad79fa2a11();
        player ob_gametype_story_mission::function_bdbb24f577154fa7( "sat_wingsuit_ob_sm_reduced_mag_fov", 0 );
    }
}

