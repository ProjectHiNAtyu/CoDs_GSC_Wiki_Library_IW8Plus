// script_66a92fa5f8b72d47  (hash_66a92fa5f8b72d47.gscc) (size: 2340 Bytes / 0x924 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5080f98e (1350629774)
// size ...... 2340 (0x924)
// includes .. 9   (offset: 0x888)
// strings ... 5   (offset: 0x8d0)
// dev strs .. 0   (offset: 0x924)
// exports ... 12  (offset: 0x434)
// cseg ...... 0xae + 0x386 (0x434)
// imports ... 22  (offset: 0x614)
// animtree1 . 0   (offset: 0x924)
// animtree2 . 0   (offset: 0x924)
#using script_34b50456e3922412;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;

#namespace namespace_899bb02b43be3ea1;

/#

    // Namespace namespace_899bb02b43be3ea1
    // Params 0
    // Checksum 0x878731ff, Offset: 0xcc
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_899bb02b43be3ea1
// Params 0, eflags: 0x5
// Checksum 0xbc8abbdd, Offset: 0xd9
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_d41d02e6b45bcdb6", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_899bb02b43be3ea1
// Params 0, eflags: 0x4
// Checksum 0x54d326ed, Offset: 0x102
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LIBRA_NM_REWARD";
    activity_common::registeractivitytype( "OB_LIBRA_NM_REWARD", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_NM_REWARD", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_NM_REWARD", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_NM_REWARD", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_LIBRA_NM_REWARD" );
}

// Namespace namespace_899bb02b43be3ea1
// Params 0
// Checksum 0xe932a9aa, Offset: 0x179
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

// Namespace namespace_899bb02b43be3ea1
// Params 0
// Checksum 0x9b79d19f, Offset: 0x1de
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

// Namespace namespace_899bb02b43be3ea1
// Params 0
// Checksum 0x1ab0aa00, Offset: 0x245
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_899bb02b43be3ea1
// Params 1
// Checksum 0xc973fecd, Offset: 0x269
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

    // Namespace namespace_899bb02b43be3ea1
    // Params 0
    // Checksum 0xc03d95ef, Offset: 0x310
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_899bb02b43be3ea1
// Params 1
// Checksum 0x41c869cb, Offset: 0x31d
// Size: 0xc
function player_setup( player )
{
    
}

// Namespace namespace_899bb02b43be3ea1
// Params 0
// Checksum 0xf6f70000, Offset: 0x331
// Size: 0x2
function nightmare_start()
{
    
}

// Namespace namespace_899bb02b43be3ea1
// Params 0
// Checksum 0x804fd286, Offset: 0x33b
// Size: 0xf9
function nightmare_main()
{
    activity_instance = self;
    level.var_bd2748e149a8024b = self;
    level.nm_activity_instance = self;
    level.nm_activity_name = "OB_LIBRA_NM_REWARD";
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    ob_nm_mode::reward_objective( "nm_reward_conv_5" );
    level callback::callback( #"libra_nm_complete", { #players:level.players } );
    
    if ( level.var_49940117feb022ef )
    {
        level callback::callback( #"hash_8996b48b3485073b", { #players:level.players } );
    }
    
    struct = utility::getstruct( "reward_chest", "targetname" );
    ob_story_mission_utils::function_e1f7ae6f70c4b0c1( struct.origin, struct.angles, undefined, undefined, 1 );
    level thread ob_nm_mode::function_b2df4178a4626376();
    activity_instance_common::endactivity( activity_instance, 1 );
}

