// script_67c00f778df7d493  (hash_67c00f778df7d493.gscc) (size: 2603 Bytes / 0xa2b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2070cc05 (544263173)
// size ...... 2603 (0xa2b)
// includes .. 9   (offset: 0x983)
// strings ... 6   (offset: 0x9cb)
// dev strs .. 0   (offset: 0xa2b)
// exports ... 12  (offset: 0x50b)
// cseg ...... 0xc3 + 0x448 (0x50b)
// imports ... 23  (offset: 0x6eb)
// animtree1 . 0   (offset: 0xa2b)
// animtree2 . 0   (offset: 0xa2b)
#using script_34b50456e3922412;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;

#namespace namespace_5ed8d1767ccbfcee;

/#

    // Namespace namespace_5ed8d1767ccbfcee
    // Params 0
    // Checksum 0xb8f2f3b0, Offset: 0xe1
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_5ed8d1767ccbfcee
// Params 0, eflags: 0x5
// Checksum 0x46159ec6, Offset: 0xee
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_31ed106e73243181", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_5ed8d1767ccbfcee
// Params 0, eflags: 0x4
// Checksum 0x6ba6e4a2, Offset: 0x117
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_VIRGO_NM_REWARD";
    activity_common::registeractivitytype( "OB_VIRGO_NM_REWARD", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_NM_REWARD", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_NM_REWARD", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_NM_REWARD", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_VIRGO_NM_REWARD" );
}

// Namespace namespace_5ed8d1767ccbfcee
// Params 0
// Checksum 0xd4d27086, Offset: 0x18e
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance nightmare_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_5ed8d1767ccbfcee
// Params 0
// Checksum 0xa69908b3, Offset: 0x1f3
// Size: 0x5f
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    level.request_ids = [];
    
    if ( !ob::nightmare() )
    {
        activity_instance waittill( #"hash_1e9bc5e84aa89155" );
    }
    
    activity_instance thread nightmare_main();
}

// Namespace namespace_5ed8d1767ccbfcee
// Params 0
// Checksum 0x25c5684f, Offset: 0x25a
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_5ed8d1767ccbfcee
// Params 1
// Checksum 0xf49327e1, Offset: 0x27e
// Size: 0x9f
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    
    foreach ( player in player_list )
    {
        activity_instance thread player_setup( player );
    }
}

/#

    // Namespace namespace_5ed8d1767ccbfcee
    // Params 0
    // Checksum 0xff4857a0, Offset: 0x325
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_5ed8d1767ccbfcee
// Params 1
// Checksum 0x7ebdab84, Offset: 0x332
// Size: 0xc
function player_setup( player )
{
    
}

// Namespace namespace_5ed8d1767ccbfcee
// Params 0
// Checksum 0xc982c24f, Offset: 0x346
// Size: 0x2
function nightmare_start()
{
    
}

// Namespace namespace_5ed8d1767ccbfcee
// Params 0
// Checksum 0x51874780, Offset: 0x350
// Size: 0x1bb
function nightmare_main()
{
    activity_instance = self;
    level.var_bd2748e149a8024b = self;
    level.nm_activity_instance = self;
    level.nm_activity_name = "OB_VIRGO_NM_REWARD";
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    ob_nm_mode::reward_objective( "nm_reward_conv_3" );
    level thread ob_nm_mode::end_remote_robot();
    
    foreach ( player in level.players )
    {
        player utility::callsharedfunc( #"hash_561b73e89e879cb7", #"hash_3fa3c8cca94e4308", "virgo" );
        
        if ( !player.laststandstarttime )
        {
            level callback::callback( #"hash_67122492117aadca", { #players:[ player ] } );
        }
    }
    
    level callback::callback( #"virgo_nm_complete", { #players:level.players } );
    
    if ( level.var_49940117feb022ef == 1 )
    {
        level callback::callback( #"virgo_nm_solo", { #players:level.players } );
    }
    
    struct = utility::getstruct( "nm_carrier_circle_struct", "targetname" );
    ob_story_mission_utils::function_e1f7ae6f70c4b0c1( struct.origin, struct.angles, undefined, undefined, 1 );
    activity_instance_common::endactivity( activity_instance, 1 );
}

