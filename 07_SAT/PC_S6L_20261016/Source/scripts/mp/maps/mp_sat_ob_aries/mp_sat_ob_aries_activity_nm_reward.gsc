// scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_activity_nm_reward.gsc  (hash_21c907f79d3cf92f.gscc) (size: 2616 Bytes / 0xa38 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa4145c27 (2752797735)
// size ...... 2616 (0xa38)
// includes .. 9   (offset: 0x990)
// strings ... 6   (offset: 0x9d8)
// dev strs .. 0   (offset: 0xa38)
// exports ... 12  (offset: 0x518)
// cseg ...... 0xbb + 0x45d (0x518)
// imports ... 23  (offset: 0x6f8)
// animtree1 . 0   (offset: 0xa38)
// animtree2 . 0   (offset: 0xa38)
#using script_34b50456e3922412;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;

#namespace mp_sat_ob_aries_activity_nm_reward;

/#

    // Namespace mp_sat_ob_aries_activity_nm_reward
    // Params 0
    // Checksum 0xfc975d8b, Offset: 0xd9
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace mp_sat_ob_aries_activity_nm_reward
// Params 0, eflags: 0x5
// Checksum 0x3275ecf9, Offset: 0xe6
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_2976ad2584840f2a", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace mp_sat_ob_aries_activity_nm_reward
// Params 0, eflags: 0x4
// Checksum 0x2fc34a99, Offset: 0x10f
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_ARIES_NM_REWARD";
    activity_common::registeractivitytype( "OB_ARIES_NM_REWARD", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_NM_REWARD", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_NM_REWARD", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_NM_REWARD", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_ARIES_NM_REWARD" );
}

// Namespace mp_sat_ob_aries_activity_nm_reward
// Params 0
// Checksum 0x57123c12, Offset: 0x186
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

// Namespace mp_sat_ob_aries_activity_nm_reward
// Params 0
// Checksum 0x25594427, Offset: 0x1eb
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

// Namespace mp_sat_ob_aries_activity_nm_reward
// Params 0
// Checksum 0x61a0c674, Offset: 0x252
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace mp_sat_ob_aries_activity_nm_reward
// Params 1
// Checksum 0x77536b75, Offset: 0x276
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

    // Namespace mp_sat_ob_aries_activity_nm_reward
    // Params 0
    // Checksum 0xbb2df99b, Offset: 0x31d
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace mp_sat_ob_aries_activity_nm_reward
// Params 1
// Checksum 0x3ad805bf, Offset: 0x32a
// Size: 0xc
function player_setup( player )
{
    
}

// Namespace mp_sat_ob_aries_activity_nm_reward
// Params 0
// Checksum 0x8de76c74, Offset: 0x33e
// Size: 0x2
function nightmare_start()
{
    
}

// Namespace mp_sat_ob_aries_activity_nm_reward
// Params 0
// Checksum 0xcb309a15, Offset: 0x348
// Size: 0x1d0
function nightmare_main()
{
    activity_instance = self;
    level.var_bd2748e149a8024b = self;
    level.nm_activity_instance = self;
    level.nm_activity_name = "OB_ARIES_NM_REWARD";
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    ob_nm_mode::reward_objective( "nm_reward_conv_2" );
    winners = [];
    
    foreach ( player in level.players )
    {
        player utility::callsharedfunc( #"hash_561b73e89e879cb7", #"hash_3fa3c8cca94e4308", "aries" );
        
        if ( player.nostun == 1 )
        {
            winners[ winners.size ] = player;
        }
    }
    
    if ( winners.size )
    {
        level callback::callback( #"hash_528bc14574e39758", { #players:winners } );
    }
    
    level callback::callback( #"aries_nm_complete", { #players:level.players } );
    
    if ( level.var_49940117feb022ef == 1 )
    {
        level callback::callback( #"nm_portal_aries_solo", { #players:level.players } );
    }
    
    struct = utility::getstruct( "struct_nm_reward", "targetname" );
    ob_story_mission_utils::function_e1f7ae6f70c4b0c1( struct.origin, struct.angles, undefined, undefined, 1 );
    level thread ob_nm_mode::function_b2df4178a4626376();
    activity_instance_common::endactivity( activity_instance, 1 );
}

