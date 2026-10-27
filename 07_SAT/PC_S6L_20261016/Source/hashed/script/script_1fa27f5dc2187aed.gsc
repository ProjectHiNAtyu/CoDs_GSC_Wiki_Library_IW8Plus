// script_1fa27f5dc2187aed  (hash_1fa27f5dc2187aed.gscc) (size: 1894 Bytes / 0x766 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa6edac29 (2800593961)
// size ...... 1894 (0x766)
// includes .. 5   (offset: 0x706)
// strings ... 3   (offset: 0x72e)
// dev strs .. 0   (offset: 0x766)
// exports ... 10  (offset: 0x376)
// cseg ...... 0x95 + 0x2e1 (0x376)
// imports ... 18  (offset: 0x506)
// animtree1 . 0   (offset: 0x766)
// animtree2 . 0   (offset: 0x766)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\mp\gametypes\ob_gametype_story_mission;

#namespace namespace_e30666daca71236;

// Namespace namespace_e30666daca71236
// Params 0, eflags: 0x5
// Checksum 0x77cf0cce, Offset: 0xb3
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_15aeebee40a21e11", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_e30666daca71236
// Params 0, eflags: 0x4
// Checksum 0xbbca0a7a, Offset: 0xdc
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_GEMINI_CABIN_DEFEND1";
    activity_common::registeractivitytype( "OB_GEMINI_CABIN_DEFEND1", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_CABIN_DEFEND1", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_CABIN_DEFEND1", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_CABIN_DEFEND1", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_GEMINI_CABIN_DEFEND1" );
}

// Namespace namespace_e30666daca71236
// Params 0
// Checksum 0x7f3e4427, Offset: 0x153
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance function_5be6af3fdbd0a20c();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_e30666daca71236
// Params 0
// Checksum 0x91b824d7, Offset: 0x1b8
// Size: 0x3d
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance function_d0fec8cbf314845d();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_e30666daca71236
// Params 0
// Checksum 0xf5a98697, Offset: 0x1fd
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_e30666daca71236
// Params 1
// Checksum 0x64bb8b97, Offset: 0x221
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread function_9da30cf267efc64b( player );
    }
}

// Namespace namespace_e30666daca71236
// Params 0
// Checksum 0x5264a44c, Offset: 0x2dd
// Size: 0xf
function function_5be6af3fdbd0a20c()
{
    activity_instance = self;
}

// Namespace namespace_e30666daca71236
// Params 0
// Checksum 0x13641c41, Offset: 0x2f4
// Size: 0x30
function function_d0fec8cbf314845d()
{
    activity_instance = self;
    level.activity_instance = activity_instance;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
}

// Namespace namespace_e30666daca71236
// Params 1
// Checksum 0xdd32cbe, Offset: 0x32c
// Size: 0x4a
function function_9da30cf267efc64b( player )
{
    activity_instance = self;
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        player ob_story_mission_utils::function_4657f38861c52871( "sat_ar_condor_mp" );
        player ob_story_mission_utils::function_ec74a55c78cc831( 2 );
    }
}

