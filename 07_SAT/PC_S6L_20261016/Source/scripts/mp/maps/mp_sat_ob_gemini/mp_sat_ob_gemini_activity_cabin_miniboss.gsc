// scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_activity_cabin_miniboss.gsc  (hash_473750bea042382e.gscc) (size: 4205 Bytes / 0x106d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3a0e0efc (973999868)
// size ...... 4205 (0x106d)
// includes .. 8   (offset: 0xf69)
// strings ... 12  (offset: 0xfa9)
// dev strs .. 0   (offset: 0x106d)
// exports ... 17  (offset: 0x831)
// cseg ...... 0x12d + 0x704 (0x831)
// imports ... 40  (offset: 0xad9)
// animtree1 . 0   (offset: 0x106d)
// animtree2 . 0   (offset: 0x106d)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob_gametype_story_mission;

#namespace namespace_e59b46055a798479;

// Namespace namespace_e59b46055a798479
// Params 0, eflags: 0x5
// Checksum 0xc5c46d72, Offset: 0x14b
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_c89d7a1e72be0bb8", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_e59b46055a798479
// Params 0, eflags: 0x4
// Checksum 0x4d149c35, Offset: 0x174
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_GEMINI_CABIN_MINIBOSS";
    activity_common::registeractivitytype( "OB_GEMINI_CABIN_MINIBOSS", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_CABIN_MINIBOSS", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_CABIN_MINIBOSS", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_CABIN_MINIBOSS", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_GEMINI_CABIN_MINIBOSS" );
}

// Namespace namespace_e59b46055a798479
// Params 0
// Checksum 0xb6f77135, Offset: 0x1eb
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance function_7c1030e14a9b1ba9();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_e59b46055a798479
// Params 0
// Checksum 0xa6a91a24, Offset: 0x250
// Size: 0x3d
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance function_b26beb88acfc194a();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_e59b46055a798479
// Params 0
// Checksum 0x37710d8, Offset: 0x295
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_e59b46055a798479
// Params 1
// Checksum 0x35d6ce4a, Offset: 0x2b9
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread function_172e68db09d4afa0( player );
    }
}

// Namespace namespace_e59b46055a798479
// Params 0
// Checksum 0xed647304, Offset: 0x375
// Size: 0xf
function function_7c1030e14a9b1ba9()
{
    activity_instance = self;
}

// Namespace namespace_e59b46055a798479
// Params 0
// Checksum 0x52bcc0c5, Offset: 0x38c
// Size: 0x25
function function_b26beb88acfc194a()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
}

// Namespace namespace_e59b46055a798479
// Params 1
// Checksum 0x2a778b39, Offset: 0x3b9
// Size: 0x4a
function function_172e68db09d4afa0( player )
{
    activity_instance = self;
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        player ob_story_mission_utils::function_4657f38861c52871( "sat_ar_condor_mp" );
        player ob_story_mission_utils::function_ec74a55c78cc831( 2 );
    }
}

/#

    // Namespace namespace_e59b46055a798479
    // Params 0
    // Checksum 0x62404d70, Offset: 0x40b
    // Size: 0x5, Type: dev
    function function_647ca0c833571430()
    {
        
    }

#/

// Namespace namespace_e59b46055a798479
// Params 0
// Checksum 0x4571bc08, Offset: 0x418
// Size: 0x71
function miniboss_setup()
{
    activity_instance = self;
    utility::flag_clear( "miniboss_shutdown" );
    activity_instance.miniboss_active = 1;
    activity_instance.var_b8111cf0a4cc3c71 = [];
    activity_instance.var_9e58484abc712111 = undefined;
    activity_instance.miniboss_struct = spawnstruct();
    activity_instance.miniboss_struct.activity_instance = activity_instance;
    waitframe();
    function_3b9b764e8b4d5821();
}

// Namespace namespace_e59b46055a798479
// Params 0
// Checksum 0xb97ba6f, Offset: 0x491
// Size: 0x127
function function_3b9b764e8b4d5821()
{
    activity_instance = self;
    activity_instance.miniboss_struct.request_id = ai_spawn_director::lookup_spawn_request( "defend_miniboss" );
    var_399a0f97e8cb8e0b = utility::getstruct( "cabin_center_struct", "targetname" );
    function_ef57f478f96b050c( activity_instance.miniboss_struct.request_id, 1 );
    ai_spawn_director::add_spawned_callback( activity_instance.miniboss_struct.request_id, &function_ef564eaccbffb8b, activity_instance.miniboss_struct );
    activity_instance.miniboss_struct.flood_request_id = ai_spawn_director::lookup_spawn_request( "defend_floodfill" );
    function_ef57f478f96b050c( activity_instance.miniboss_struct.flood_request_id, 1 );
    ai_spawn_director::add_spawned_callback( activity_instance.miniboss_struct.flood_request_id, &function_add1faac29a04c22, activity_instance.miniboss_struct );
    ai_spawn_director::function_53289c032f506bb1( activity_instance.miniboss_struct.flood_request_id, &should_shutdown_floodfill, activity_instance.miniboss_struct );
}

// Namespace namespace_e59b46055a798479
// Params 4
// Checksum 0x3a78dc09, Offset: 0x5c0
// Size: 0xdf
function function_ef564eaccbffb8b( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    var_399a0f97e8cb8e0b = utility::getstruct( "cabin_center_struct", "targetname" );
    agent function_fa32376aaa88a7a2( var_399a0f97e8cb8e0b.origin, 7000 );
    agent setgoalpos( var_399a0f97e8cb8e0b.origin, 2000 );
    agent forcethreatupdate();
    userdata.activity_instance.var_9e58484abc712111 = agent;
    userdata.activity_instance thread miniboss_watcher( agent );
    earthquake( 0.85, 1.5, var_399a0f97e8cb8e0b.origin, 5120 );
    playrumbleonposition( "artillery_rumble_heavy", var_399a0f97e8cb8e0b.origin );
}

// Namespace namespace_e59b46055a798479
// Params 4
// Checksum 0x158a8a7e, Offset: 0x6a7
// Size: 0xf6
function function_add1faac29a04c22( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    var_399a0f97e8cb8e0b = utility::getstruct( "cabin_center_struct", "targetname" );
    agent function_fa32376aaa88a7a2( var_399a0f97e8cb8e0b.origin, 7000 );
    agent setgoalpos( var_399a0f97e8cb8e0b.origin, 2000 );
    randomspeed = randomintrange( 0, 10 );
    
    if ( randomspeed < 5 )
    {
        agent zombie_utils::function_a8ce00e0448cb6f0( "sprint", "Barrage", 10 );
    }
    else
    {
        agent zombie_utils::function_a8ce00e0448cb6f0( "run", "Barrage", 10 );
    }
    
    agent forcethreatupdate();
    userdata.activity_instance.var_b8111cf0a4cc3c71[ userdata.activity_instance.var_b8111cf0a4cc3c71.size ] = agent;
}

// Namespace namespace_e59b46055a798479
// Params 2
// Checksum 0xcafb5a80, Offset: 0x7a5
// Size: 0x26
function should_shutdown_floodfill( requestid, userdata )
{
    if ( utility::flag( "miniboss_shutdown" ) )
    {
        return 1;
    }
}

// Namespace namespace_e59b46055a798479
// Params 1
// Checksum 0x6cfed651, Offset: 0x7d3
// Size: 0x5e
function miniboss_watcher( agent )
{
    activity_instance = self;
    agent waittill( #"death" );
    activity_instance.miniboss_active = 0;
    utility::flag_set( "miniboss_shutdown" );
    request_id = ai_spawn_director::lookup_spawn_request( "defend_floodfill" );
    function_17ee483eb76a9759( request_id, 1 );
}

