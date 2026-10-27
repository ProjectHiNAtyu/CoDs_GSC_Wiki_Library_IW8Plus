// script_67558a40f06051a4  (hash_67558a40f06051a4.gscc) (size: 1883 Bytes / 0x75b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xee4a97f4 (3997865972)
// size ...... 1883 (0x75b)
// includes .. 5   (offset: 0x6fb)
// strings ... 3   (offset: 0x723)
// dev strs .. 0   (offset: 0x75b)
// exports ... 10  (offset: 0x36b)
// cseg ...... 0x95 + 0x2d6 (0x36b)
// imports ... 18  (offset: 0x4fb)
// animtree1 . 0   (offset: 0x75b)
// animtree2 . 0   (offset: 0x75b)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\mp\gametypes\ob_gametype_story_mission;

#namespace namespace_e30656daca71003;

// Namespace namespace_e30656daca71003
// Params 0, eflags: 0x5
// Checksum 0xeec659a8, Offset: 0xb3
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_15aee8ee40a218f8", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_e30656daca71003
// Params 0, eflags: 0x4
// Checksum 0xbbca084f, Offset: 0xdc
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_GEMINI_CABIN_DEFEND2";
    activity_common::registeractivitytype( "OB_GEMINI_CABIN_DEFEND2", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_CABIN_DEFEND2", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_CABIN_DEFEND2", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_CABIN_DEFEND2", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_GEMINI_CABIN_DEFEND2" );
}

// Namespace namespace_e30656daca71003
// Params 0
// Checksum 0xd7df0d35, Offset: 0x153
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance function_5263a0e9551720cd();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_e30656daca71003
// Params 0
// Checksum 0x8e2505f6, Offset: 0x1b8
// Size: 0x3d
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance function_79de91b5989a7026();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_e30656daca71003
// Params 0
// Checksum 0xf5a984a2, Offset: 0x1fd
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_e30656daca71003
// Params 1
// Checksum 0x81d3fdc3, Offset: 0x221
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread function_53b6ff230d39b8cc( player );
    }
}

// Namespace namespace_e30656daca71003
// Params 0
// Checksum 0x638cbce4, Offset: 0x2dd
// Size: 0xf
function function_5263a0e9551720cd()
{
    activity_instance = self;
}

// Namespace namespace_e30656daca71003
// Params 0
// Checksum 0x95f06cf7, Offset: 0x2f4
// Size: 0x25
function function_79de91b5989a7026()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
}

// Namespace namespace_e30656daca71003
// Params 1
// Checksum 0x71b20b50, Offset: 0x321
// Size: 0x4a
function function_53b6ff230d39b8cc( player )
{
    activity_instance = self;
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        player ob_story_mission_utils::function_4657f38861c52871( "sat_ar_condor_mp" );
        player ob_story_mission_utils::function_ec74a55c78cc831( 2 );
    }
}

