// scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_activity_cabin_intro.gsc  (hash_118187ef506ab67c.gscc) (size: 2235 Bytes / 0x8bb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2924bcde (690273502)
// size ...... 2235 (0x8bb)
// includes .. 8   (offset: 0x81f)
// strings ... 6   (offset: 0x85f)
// dev strs .. 0   (offset: 0x8bb)
// exports ... 10  (offset: 0x437)
// cseg ...... 0xf7 + 0x340 (0x437)
// imports ... 21  (offset: 0x5c7)
// animtree1 . 0   (offset: 0x8bb)
// animtree2 . 0   (offset: 0x8bb)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_util;

#namespace mp_sat_ob_gemini_activity_cabin_intro;

// Namespace mp_sat_ob_gemini_activity_cabin_intro
// Params 0, eflags: 0x5
// Checksum 0xf44b2cd1, Offset: 0x115
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_c6a4b086d4f1d818", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace mp_sat_ob_gemini_activity_cabin_intro
// Params 0, eflags: 0x4
// Checksum 0x5b64de01, Offset: 0x13e
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_GEMINI_CABIN_INTRO";
    activity_common::registeractivitytype( "OB_GEMINI_CABIN_INTRO", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_CABIN_INTRO", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_CABIN_INTRO", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_CABIN_INTRO", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_GEMINI_CABIN_INTRO" );
}

// Namespace mp_sat_ob_gemini_activity_cabin_intro
// Params 0
// Checksum 0x690dff6, Offset: 0x1b5
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance cabin_intro_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace mp_sat_ob_gemini_activity_cabin_intro
// Params 0
// Checksum 0x9414e256, Offset: 0x21a
// Size: 0x3d
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance cabin_intro_main();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace mp_sat_ob_gemini_activity_cabin_intro
// Params 0
// Checksum 0x150752ec, Offset: 0x25f
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace mp_sat_ob_gemini_activity_cabin_intro
// Params 1
// Checksum 0xe251d015, Offset: 0x283
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread cabin_intro_player_setup( player );
    }
}

// Namespace mp_sat_ob_gemini_activity_cabin_intro
// Params 0
// Checksum 0x70ef927e, Offset: 0x33f
// Size: 0x2a
function cabin_intro_start()
{
    activity_instance = self;
    level utility::flag_set( "flag_tunnels_pit_complete" );
    gemini_util::function_34a3d0cff5de2d7d();
    gemini_util::function_dfcbf5f9b3b2e6a0();
}

// Namespace mp_sat_ob_gemini_activity_cabin_intro
// Params 0
// Checksum 0x4397724d, Offset: 0x371
// Size: 0x8d
function cabin_intro_main()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    structs = ob_story_mission_utils::get_activity_starts( "OB_GEMINI_CABIN_WILDERNESS" );
    level coop::play_cinematic( "sat_gemini_control_room", { #noregroup:1, #var_ba7c3b8fa9d3823:level.teleport_initiator, #timeout:50, #structs:structs } );
    activity_instance utility::flag_set( "OB_GEMINI_CABIN_INTRO_COMPLETE" );
}

// Namespace mp_sat_ob_gemini_activity_cabin_intro
// Params 1
// Checksum 0xef4708d9, Offset: 0x406
// Size: 0x31
function cabin_intro_player_setup( player )
{
    activity_instance = self;
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
    }
}

