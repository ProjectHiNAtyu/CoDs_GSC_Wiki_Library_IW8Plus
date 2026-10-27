// scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_activity_nightmare_intro.gsc  (hash_4365d8e2df6111a6.gscc) (size: 3008 Bytes / 0xbc0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1aed50ba (451760314)
// size ...... 3008 (0xbc0)
// includes .. 10  (offset: 0xad8)
// strings ... 10  (offset: 0xb28)
// dev strs .. 0   (offset: 0xbc0)
// exports ... 13  (offset: 0x57c)
// cseg ...... 0x15c + 0x420 (0x57c)
// imports ... 30  (offset: 0x784)
// animtree1 . 0   (offset: 0xbc0)
// animtree2 . 0   (offset: 0xbc0)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\hud_util;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_util;
#using scripts\mp\ob\systems\ob_container_spawn_closet;

#namespace mp_sat_ob_aries_activity_nightmare_intro;

/#

    // Namespace mp_sat_ob_aries_activity_nightmare_intro
    // Params 0
    // Checksum 0x3c9551b6, Offset: 0x17a
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace mp_sat_ob_aries_activity_nightmare_intro
// Params 0, eflags: 0x5
// Checksum 0x8a4a573c, Offset: 0x187
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_ac0437aae9f166bb", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace mp_sat_ob_aries_activity_nightmare_intro
// Params 0, eflags: 0x4
// Checksum 0xefc146a4, Offset: 0x1b0
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_ARIES_NIGHTMARE_INTRO";
    activity_common::registeractivitytype( "OB_ARIES_NIGHTMARE_INTRO", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_NIGHTMARE_INTRO", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_NIGHTMARE_INTRO", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_NIGHTMARE_INTRO", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_ARIES_NIGHTMARE_INTRO" );
}

// Namespace mp_sat_ob_aries_activity_nightmare_intro
// Params 0
// Checksum 0xd6e9c5e2, Offset: 0x227
// Size: 0x59
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance nightmare_intro_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace mp_sat_ob_aries_activity_nightmare_intro
// Params 0
// Checksum 0xc67467ce, Offset: 0x288
// Size: 0x39
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance nightmare_intro_main();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace mp_sat_ob_aries_activity_nightmare_intro
// Params 0
// Checksum 0xa1a2ca49, Offset: 0x2c9
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace mp_sat_ob_aries_activity_nightmare_intro
// Params 1
// Checksum 0x87267538, Offset: 0x2ed
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread nightmare_intro_player_setup( player );
    }
}

// Namespace mp_sat_ob_aries_activity_nightmare_intro
// Params 0
// Checksum 0xe48ac641, Offset: 0x3a9
// Size: 0x17
function setup_ui_widget()
{
    ob_story_mission_utils::function_31f2c265b77aa2c1( 2 );
    ob_story_mission_utils::objective_text_show( "OB_ARIES_NIGHTMARE_INTRO" );
}

/#

    // Namespace mp_sat_ob_aries_activity_nightmare_intro
    // Params 0
    // Checksum 0x7b2ff5a6, Offset: 0x3c8
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace mp_sat_ob_aries_activity_nightmare_intro
// Params 0
// Checksum 0x19544b9d, Offset: 0x3d5
// Size: 0xf
function nightmare_intro_start()
{
    activity_instance = self;
}

// Namespace mp_sat_ob_aries_activity_nightmare_intro
// Params 0
// Checksum 0xb0b056e9, Offset: 0x3ec
// Size: 0x145
function nightmare_intro_main()
{
    activity_instance = self;
    structs = ob_story_mission_utils::get_activity_starts( "OB_ARIES_NIGHTMARE_CORRIDOR" );
    utility::flag_set( "flag_aries_nightmare_intro_start" );
    level thread coop::play_cinematic( "aries_nightmare", { #var_ba7c3b8fa9d3823:level.teleport_initiator, #timeout:100, #flag:"flag_aries_nightmare_intro_complete", #structs:structs } );
    level thread aries_util::function_3d7162d72da84e14();
    utility::flag_wait( "flag_aries_nightmare_intro_complete" );
    
    foreach ( player in level.players )
    {
        player thread hud_util::fade_out( 0, "black" );
        player thread hud_util::fade_in( 1.5, "black" );
    }
    
    showcinematicletterboxing();
    wait 2;
    hidecinematicletterboxing( 1.5, 0 );
    ob_container_spawn_closet::function_e6f9ca6684759ebe( "p2_spawn_closet", "p2_fake_floor", "ob_sat_items_enemy_zombie_aries_spawn_closet" );
}

// Namespace mp_sat_ob_aries_activity_nightmare_intro
// Params 1
// Checksum 0x55fb2fe, Offset: 0x539
// Size: 0x43
function nightmare_intro_player_setup( player )
{
    activity_instance = self;
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        player ob_story_mission_utils::function_2383fc8bfc3074d2();
        player ob_story_mission_utils::function_288fdad79fa2a11();
    }
}

