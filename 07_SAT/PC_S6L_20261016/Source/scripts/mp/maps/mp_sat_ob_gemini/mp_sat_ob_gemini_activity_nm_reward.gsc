// scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_activity_nm_reward.gsc  (hash_7c300b35623384b9.gscc) (size: 2308 Bytes / 0x904 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x40e13557 (1088501079)
// size ...... 2308 (0x904)
// includes .. 9   (offset: 0x868)
// strings ... 5   (offset: 0x8b0)
// dev strs .. 0   (offset: 0x904)
// exports ... 12  (offset: 0x430)
// cseg ...... 0xaf + 0x381 (0x430)
// imports ... 21  (offset: 0x610)
// animtree1 . 0   (offset: 0x904)
// animtree2 . 0   (offset: 0x904)
#using script_34b50456e3922412;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;

#namespace mp_sat_ob_gemini_activity_nm_reward;

/#

    // Namespace mp_sat_ob_gemini_activity_nm_reward
    // Params 0
    // Checksum 0xf2d0697e, Offset: 0xcd
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace mp_sat_ob_gemini_activity_nm_reward
// Params 0, eflags: 0x5
// Checksum 0x64909c18, Offset: 0xda
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_4e32f971df542e4d", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace mp_sat_ob_gemini_activity_nm_reward
// Params 0, eflags: 0x4
// Checksum 0x21847e6c, Offset: 0x103
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_GEMINI_NM_REWARD";
    activity_common::registeractivitytype( "OB_GEMINI_NM_REWARD", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_NM_REWARD", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_NM_REWARD", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_NM_REWARD", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_GEMINI_NM_REWARD" );
}

// Namespace mp_sat_ob_gemini_activity_nm_reward
// Params 0
// Checksum 0x5a276d94, Offset: 0x17a
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

// Namespace mp_sat_ob_gemini_activity_nm_reward
// Params 0
// Checksum 0x286c15a1, Offset: 0x1df
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

// Namespace mp_sat_ob_gemini_activity_nm_reward
// Params 0
// Checksum 0x6fe7f281, Offset: 0x246
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace mp_sat_ob_gemini_activity_nm_reward
// Params 1
// Checksum 0x7a663af3, Offset: 0x26a
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

    // Namespace mp_sat_ob_gemini_activity_nm_reward
    // Params 0
    // Checksum 0xb56acd6e, Offset: 0x311
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace mp_sat_ob_gemini_activity_nm_reward
// Params 1
// Checksum 0x349f314a, Offset: 0x31e
// Size: 0xc
function player_setup( player )
{
    
}

// Namespace mp_sat_ob_gemini_activity_nm_reward
// Params 0
// Checksum 0x83a05881, Offset: 0x332
// Size: 0x2
function nightmare_start()
{
    
}

// Namespace mp_sat_ob_gemini_activity_nm_reward
// Params 0
// Checksum 0x4dbfaf15, Offset: 0x33c
// Size: 0xf4
function nightmare_main()
{
    activity_instance = self;
    level.var_bd2748e149a8024b = self;
    level.nm_activity_instance = self;
    level.nm_activity_name = "OB_GEMINI_NM_REWARD";
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    ob_nm_mode::reward_objective( "nm_reward_conv_4" );
    level callback::callback( #"gemini_nm_complete", { #players:level.players } );
    
    if ( level.var_49940117feb022ef == 1 )
    {
        level callback::callback( #"hash_d842de1c48117b14", { #players:level.players } );
    }
    
    struct = utility::getstruct( "reward_chest", "targetname" );
    ob_story_mission_utils::function_e1f7ae6f70c4b0c1( struct.origin, struct.angles, undefined, undefined, 1 );
    activity_instance_common::endactivity( activity_instance, 1 );
}

