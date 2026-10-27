// scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_activity_river_intro.gsc  (hash_264d949aab6815bd.gscc) (size: 1782 Bytes / 0x6f6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x74557c1d (1951759389)
// size ...... 1782 (0x6f6)
// includes .. 5   (offset: 0x6a2)
// strings ... 2   (offset: 0x6ca)
// dev strs .. 0   (offset: 0x6f6)
// exports ... 10  (offset: 0x32e)
// cseg ...... 0x7e + 0x2b0 (0x32e)
// imports ... 17  (offset: 0x4be)
// animtree1 . 0   (offset: 0x6f6)
// animtree2 . 0   (offset: 0x6f6)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\mp\gametypes\ob_gametype_story_mission;

#namespace mp_sat_ob_aries_activity_river_intro;

// Namespace mp_sat_ob_aries_activity_river_intro
// Params 0, eflags: 0x5
// Checksum 0x50011d0c, Offset: 0x9c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_a3d16c31b501a50", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace mp_sat_ob_aries_activity_river_intro
// Params 0, eflags: 0x4
// Checksum 0x73173a73, Offset: 0xc5
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_ARIES_RIVER_INTRO";
    activity_common::registeractivitytype( "OB_ARIES_RIVER_INTRO", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_RIVER_INTRO", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_RIVER_INTRO", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_RIVER_INTRO", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_ARIES_RIVER_INTRO" );
}

// Namespace mp_sat_ob_aries_activity_river_intro
// Params 0
// Checksum 0x44c99532, Offset: 0x13c
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance river_intro_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace mp_sat_ob_aries_activity_river_intro
// Params 0
// Checksum 0x948fd8ba, Offset: 0x1a1
// Size: 0x3d
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance function_9c9ce336354ad59f();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace mp_sat_ob_aries_activity_river_intro
// Params 0
// Checksum 0x3d74b69e, Offset: 0x1e6
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace mp_sat_ob_aries_activity_river_intro
// Params 1
// Checksum 0x86e038fe, Offset: 0x20a
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread function_2ff957d91463c8bd( player );
    }
}

// Namespace mp_sat_ob_aries_activity_river_intro
// Params 0
// Checksum 0xdd7250d3, Offset: 0x2c6
// Size: 0xf
function river_intro_start()
{
    activity_instance = self;
}

// Namespace mp_sat_ob_aries_activity_river_intro
// Params 0
// Checksum 0x446462f1, Offset: 0x2dd
// Size: 0x30
function function_9c9ce336354ad59f()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    ob_story_mission_utils::function_6314f03dfe2adbc5();
}

// Namespace mp_sat_ob_aries_activity_river_intro
// Params 1
// Checksum 0xadae63d3, Offset: 0x315
// Size: 0x19
function function_2ff957d91463c8bd( player )
{
    activity_instance = self;
}

