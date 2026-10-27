// script_12d8132da66cbb07  (hash_12d8132da66cbb07.gscc) (size: 2750 Bytes / 0xabe / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x69d98328 (1775862568)
// size ...... 2750 (0xabe)
// includes .. 10  (offset: 0x9ea)
// strings ... 8   (offset: 0xa3a)
// dev strs .. 1   (offset: 0xab2)
// exports ... 13  (offset: 0x4de)
// cseg ...... 0x111 + 0x3cd (0x4de)
// imports ... 27  (offset: 0x6e6)
// animtree1 . 0   (offset: 0xabe)
// animtree2 . 0   (offset: 0xabe)
#using script_66878054d141dbc0;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\hud_util;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_util;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_vo;

#namespace namespace_aeaed18fa4c7051f;

/#

    // Namespace namespace_aeaed18fa4c7051f
    // Params 0
    // Checksum 0x60fe0a41, Offset: 0x12f
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_aeaed18fa4c7051f
// Params 0, eflags: 0x5
// Checksum 0x8ee3f14f, Offset: 0x13c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_be394275a8418214", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_aeaed18fa4c7051f
// Params 0, eflags: 0x4
// Checksum 0xb3aa1d53, Offset: 0x165
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LEO_JUNGLE_ESCAPE";
    activity_common::registeractivitytype( "OB_LEO_JUNGLE_ESCAPE", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LEO_JUNGLE_ESCAPE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LEO_JUNGLE_ESCAPE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LEO_JUNGLE_ESCAPE", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_LEO_JUNGLE_ESCAPE" );
}

// Namespace namespace_aeaed18fa4c7051f
// Params 0
// Checksum 0x3399f5c2, Offset: 0x1dc
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance function_1a0a54e3cd607948();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_aeaed18fa4c7051f
// Params 0
// Checksum 0xaa146452, Offset: 0x241
// Size: 0x47
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    level.request_ids = [];
    activity_instance thread jungle_escape_main();
}

// Namespace namespace_aeaed18fa4c7051f
// Params 0
// Checksum 0xfdc991be, Offset: 0x290
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_aeaed18fa4c7051f
// Params 1
// Checksum 0xc28b5b9d, Offset: 0x2b4
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread player_setup( player );
    }
}

/#

    // Namespace namespace_aeaed18fa4c7051f
    // Params 0
    // Checksum 0x2744ae51, Offset: 0x370
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_aeaed18fa4c7051f
// Params 1
// Checksum 0x448b5397, Offset: 0x37d
// Size: 0x19
function player_setup( player )
{
    activity_instance = self;
}

// Namespace namespace_aeaed18fa4c7051f
// Params 0
// Checksum 0xcdbfe24b, Offset: 0x39e
// Size: 0x12
function function_1a0a54e3cd607948()
{
    level thread mp_sat_ob_leo_util::function_46c7dd890b4e2bbb();
    level thread mp_sat_ob_leo_util::function_3c8a17513e90ef86();
}

// Namespace namespace_aeaed18fa4c7051f
// Params 0
// Checksum 0xb8be7d7d, Offset: 0x3b8
// Size: 0x7b
function jungle_escape_main()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    if ( !level utility::flag( "flag_jungle_mansion_defend_end_vo_complete" ) )
    {
        wait 1;
    }
    
    thread mp_sat_ob_leo_vo::function_1d1ed620cc2b6a30();
    level utility::flag_wait( "flag_jungle_escape_end_vo_complete" );
    wait 3;
    thread leo_outro_cinematic();
    level utility::flag_wait( "jungle_escape_complete" );
    coop::achievement_simple( "sat_wc_mission1" );
    activity_instance_common::endactivity( self, 1 );
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace namespace_aeaed18fa4c7051f
// Params 0
// Checksum 0xe24f4297, Offset: 0x43b
// Size: 0xa3
function leo_outro_cinematic()
{
    thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "light", 2 );
    
    foreach ( player in level.players )
    {
        player thread hud_util::fade_out( 0.75, "black" );
    }
    
    wait 1;
    level utility::flag_set( "jungle_escape_complete" );
}

