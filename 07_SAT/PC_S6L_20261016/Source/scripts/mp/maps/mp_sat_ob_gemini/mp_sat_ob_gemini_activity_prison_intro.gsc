// scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_activity_prison_intro.gsc  (hash_29f0d259e02d3818.gscc) (size: 2613 Bytes / 0xa35 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6b4d2ddd (1800220125)
// size ...... 2613 (0xa35)
// includes .. 8   (offset: 0x971)
// strings ... 8   (offset: 0x9b1)
// dev strs .. 0   (offset: 0xa35)
// exports ... 10  (offset: 0x519)
// cseg ...... 0x12a + 0x3ef (0x519)
// imports ... 25  (offset: 0x6a9)
// animtree1 . 0   (offset: 0xa35)
// animtree2 . 0   (offset: 0xa35)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_util;

#namespace mp_sat_ob_gemini_activity_prison_intro;

// Namespace mp_sat_ob_gemini_activity_prison_intro
// Params 0, eflags: 0x5
// Checksum 0xa0997b26, Offset: 0x148
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_ec7e3768d4fa4eba", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace mp_sat_ob_gemini_activity_prison_intro
// Params 0, eflags: 0x4
// Checksum 0x371c0b45, Offset: 0x171
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_GEMINI_PRISON_INTRO";
    activity_common::registeractivitytype( "OB_GEMINI_PRISON_INTRO", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_PRISON_INTRO", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_PRISON_INTRO", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_PRISON_INTRO", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_GEMINI_PRISON_INTRO" );
}

// Namespace mp_sat_ob_gemini_activity_prison_intro
// Params 0
// Checksum 0xd36a767b, Offset: 0x1e8
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance prison_intro_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace mp_sat_ob_gemini_activity_prison_intro
// Params 0
// Checksum 0x5db336d7, Offset: 0x24d
// Size: 0x3d
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance prison_intro_main();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace mp_sat_ob_gemini_activity_prison_intro
// Params 0
// Checksum 0x797f87a8, Offset: 0x292
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace mp_sat_ob_gemini_activity_prison_intro
// Params 1
// Checksum 0x198755df, Offset: 0x2b6
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread prison_intro_player_setup( player );
    }
}

// Namespace mp_sat_ob_gemini_activity_prison_intro
// Params 1
// Checksum 0x831f5e76, Offset: 0x372
// Size: 0x4f
function prison_intro_player_setup( player )
{
    activity_instance = self;
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
    }
    
    player thread gemini_util::function_5e0ec074b46e6e09( "flag_prison_underground_weapon_up" );
    player setstance( "stand", 1, 1 );
}

// Namespace mp_sat_ob_gemini_activity_prison_intro
// Params 0
// Checksum 0x9cb2413d, Offset: 0x3c9
// Size: 0x1d
function prison_intro_start()
{
    activity_instance = self;
    gemini_util::function_34a3d0cff5de2d7d();
    gemini_util::function_dfcbf5f9b3b2e6a0();
}

// Namespace mp_sat_ob_gemini_activity_prison_intro
// Params 0
// Checksum 0xe471f1b6, Offset: 0x3ee
// Size: 0x12b
function prison_intro_main()
{
    activity_instance = self;
    structs = ob_story_mission_utils::get_activity_starts( "OB_GEMINI_PRISON_INTRO" );
    level thread coop::play_cinematic( "sat_gemini_cabin_exit", { #fadestartnone:1, #var_a012c884853e8bb6:"gemini_squadBeginCinematic", #countdown:0, #timeout:75, #flag:"flag_gemini_cabin_exit_igc_complete", #structs:structs } );
    level utility::flag_wait_any( "gemini_squadBeginCinematic", "flag_gemini_cabin_exit_igc_complete" );
    
    foreach ( player in level.players )
    {
        player notify( #"notify_prison_intro_cinematic_starting" );
    }
    
    level utility::flag_wait( "flag_gemini_cabin_exit_igc_complete" );
    level.var_daa8e6704828e14f = 0;
    activity_instance utility::flag_set( "flag_prison_intro_complete" );
}

