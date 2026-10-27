// script_73b429bfb54a6703  (hash_73b429bfb54a6703.gscc) (size: 2720 Bytes / 0xaa0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2e69ec94 (778693780)
// size ...... 2720 (0xaa0)
// includes .. 10  (offset: 0x9d8)
// strings ... 8   (offset: 0xa28)
// dev strs .. 0   (offset: 0xaa0)
// exports ... 12  (offset: 0x514)
// cseg ...... 0xec + 0x428 (0x514)
// imports ... 26  (offset: 0x6f4)
// animtree1 . 0   (offset: 0xaa0)
// animtree2 . 0   (offset: 0xaa0)
#using script_34b50456e3922412;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_util;

#namespace namespace_9684e9a7784c6c8f;

/#

    // Namespace namespace_9684e9a7784c6c8f
    // Params 0
    // Checksum 0xbc7563d1, Offset: 0x10a
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_9684e9a7784c6c8f
// Params 0, eflags: 0x5
// Checksum 0x9b455e6, Offset: 0x117
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_792f4d336b9977ac", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_9684e9a7784c6c8f
// Params 0, eflags: 0x4
// Checksum 0x6f2174c3, Offset: 0x140
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LEO_NM_REWARD";
    activity_common::registeractivitytype( "OB_LEO_NM_REWARD", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LEO_NM_REWARD", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LEO_NM_REWARD", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LEO_NM_REWARD", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_LEO_NM_REWARD" );
}

// Namespace namespace_9684e9a7784c6c8f
// Params 0
// Checksum 0x83cefd8b, Offset: 0x1b7
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

// Namespace namespace_9684e9a7784c6c8f
// Params 0
// Checksum 0xf18585be, Offset: 0x21c
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

// Namespace namespace_9684e9a7784c6c8f
// Params 0
// Checksum 0x2142f82e, Offset: 0x283
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_9684e9a7784c6c8f
// Params 1
// Checksum 0xa38faaec, Offset: 0x2a7
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

    // Namespace namespace_9684e9a7784c6c8f
    // Params 0
    // Checksum 0xfbcfc7c1, Offset: 0x34e
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_9684e9a7784c6c8f
// Params 1
// Checksum 0x7a3a3be5, Offset: 0x35b
// Size: 0xc
function player_setup( player )
{
    
}

// Namespace namespace_9684e9a7784c6c8f
// Params 0
// Checksum 0x8a81709e, Offset: 0x36f
// Size: 0x1e
function nightmare_start()
{
    level thread mp_sat_ob_leo_util::function_46c7dd890b4e2bbb();
    level thread mp_sat_ob_leo_util::function_3c8a17513e90ef86();
    utility::exploder( "leo_nic_rocks_falling" );
}

// Namespace namespace_9684e9a7784c6c8f
// Params 0
// Checksum 0x53089672, Offset: 0x395
// Size: 0x17f
function nightmare_main()
{
    activity_instance = self;
    level.var_bd2748e149a8024b = self;
    level.nm_activity_instance = self;
    level.nm_activity_name = "OB_LEO_NM_REWARD";
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    ob_nm_mode::reward_objective( "nm_reward_conv" );
    var_ca3a7a105001d5de = 1;
    
    foreach ( player in level.players )
    {
        player utility::callsharedfunc( #"hash_561b73e89e879cb7", #"hash_3fa3c8cca94e4308", "leo" );
        
        if ( player.pers[ "nm_crash_shield_used" ] )
        {
            var_ca3a7a105001d5de = 0;
        }
    }
    
    if ( var_ca3a7a105001d5de )
    {
        level callback::callback( #"hash_dfd54cbf054317d7", { #players:level.players } );
    }
    
    struct = utility::getstruct( "nightmare_boss_spawn_1", "targetname" );
    ob_story_mission_utils::function_e1f7ae6f70c4b0c1( struct.origin, struct.angles, undefined, undefined, 1 );
    level thread ob_nm_mode::function_b2df4178a4626376();
    activity_instance_common::endactivity( activity_instance, 1 );
}

