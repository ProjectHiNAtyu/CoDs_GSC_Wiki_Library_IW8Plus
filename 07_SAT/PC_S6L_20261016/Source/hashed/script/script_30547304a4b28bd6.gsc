// script_30547304a4b28bd6  (hash_30547304a4b28bd6.gscc) (size: 4115 Bytes / 0x1013 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x93b02c5c (2477796444)
// size ...... 4115 (0x1013)
// includes .. 12  (offset: 0xe5b)
// strings ... 24  (offset: 0xebb)
// dev strs .. 0   (offset: 0x1013)
// exports ... 12  (offset: 0x85b)
// cseg ...... 0x2f2 + 0x569 (0x85b)
// imports ... 37  (offset: 0xa3b)
// animtree1 . 0   (offset: 0x1013)
// animtree2 . 0   (offset: 0x1013)
#using script_34b50456e3922412;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\chyron;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_util;
#using scripts\mp\ob\systems\ob_item_select;

#namespace namespace_8ed5a37380e6f012;

/#

    // Namespace namespace_8ed5a37380e6f012
    // Params 0
    // Checksum 0x44dfff4c, Offset: 0x310
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_8ed5a37380e6f012
// Params 0, eflags: 0x5
// Checksum 0x16198658, Offset: 0x31d
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_f5f6f85e5b0c7961", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_8ed5a37380e6f012
// Params 0, eflags: 0x4
// Checksum 0x978be85e, Offset: 0x346
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LEO_NM_ATRIUM";
    activity_common::registeractivitytype( "OB_LEO_NM_ATRIUM", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LEO_NM_ATRIUM", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LEO_NM_ATRIUM", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LEO_NM_ATRIUM", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_LEO_NM_ATRIUM" );
}

// Namespace namespace_8ed5a37380e6f012
// Params 0
// Checksum 0xacf620f8, Offset: 0x3bd
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

// Namespace namespace_8ed5a37380e6f012
// Params 0
// Checksum 0xdebd58cd, Offset: 0x422
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

// Namespace namespace_8ed5a37380e6f012
// Params 0
// Checksum 0xd9e864b3, Offset: 0x489
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_8ed5a37380e6f012
// Params 1
// Checksum 0x8cb7779f, Offset: 0x4ad
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

    // Namespace namespace_8ed5a37380e6f012
    // Params 0
    // Checksum 0x3655b5c, Offset: 0x554
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_8ed5a37380e6f012
// Params 1
// Checksum 0x8290a778, Offset: 0x561
// Size: 0xc
function player_setup( player )
{
    
}

// Namespace namespace_8ed5a37380e6f012
// Params 0
// Checksum 0x722bec03, Offset: 0x575
// Size: 0x1e
function nightmare_start()
{
    level thread mp_sat_ob_leo_util::function_46c7dd890b4e2bbb();
    level thread mp_sat_ob_leo_util::function_3c8a17513e90ef86();
    utility::exploder( "leo_nic_rocks_falling" );
}

// Namespace namespace_8ed5a37380e6f012
// Params 0
// Checksum 0x47de5acf, Offset: 0x59b
// Size: 0x2c0
function nightmare_main()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    chyron::function_d41002779543c80e( undefined, 0.01, 0.01 );
    level.var_bd2748e149a8024b = self;
    level.nm_activity_instance = self;
    level.nm_activity_name = "OB_LEO_NM_ATRIUM";
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "struct_nm_atrium_item", "flag_nm_atrium_complete", 1 );
    level._effect[ "enemy_vfx" ] = loadfxasset( "vfx_sat_wc_ai_cradle_spawn_burst_med_01" );
    thread mp_sat_ob_leo_util::function_d2eaefb295692571();
    struct = utility::getstruct( "nightmare_atrium_struct_1", "targetname" );
    ob_item_select::function_95f9ecc2af4693f6( struct.origin, "super_shadow_break", "super_bubble_shield", #"default" );
    level thread ob_story_mission_utils::function_e6799e9a19df2365( "struct_nm_cache_atrium" );
    ob_nm_mode::function_1f2648b3b22d9816( undefined, "nm_overlord_glich_start" );
    function_a25acb62ddab20e2( "nm_minion_guild", 1 );
    level.cadence_override = 2.5;
    special_enemy_array = [ undefined, "sat_ob_enemy_cradle_specialist_shielded", "sat_ob_enemy_cradle_hvt_jugg_minigun" ];
    level utility::flag_set( "flag_multi_capture_event" );
    ob_nm_mode::capture_zone_event( "nightmare_atrium_boss_struct", "nm_encounter_atrium_activity", 0, special_enemy_array, %"hash_3a0430199de874bd" );
    level utility::flag_clear( "flag_multi_capture_event" );
    function_a25acb62ddab20e2( "nm_minion_guild", 0 );
    level.cadence_override = undefined;
    winners = [];
    
    foreach ( player in level.players )
    {
        if ( !player.var_84b04a32e5935354 )
        {
            winners[ winners.size ] = player;
        }
    }
    
    if ( winners.size )
    {
        level callback::callback( #"hash_7a66622c4c71c97e", { #players:winners } );
    }
    
    ob_nm_mode::nightmare_prepare();
    ai_bosses = [];
    ai_bosses[ ai_bosses.size ] = "sat_spawner_zombie_mimic_hvt_ob";
    ai_bosses[ ai_bosses.size ] = "sat_spawner_zombie_mangler_hvt_ob";
    ai_bosses[ ai_bosses.size ] = "sat_spawner_zombie_ghoul_ob_elite";
    ai_bosses[ ai_bosses.size ] = "sat_spawner_zombie_mimic_hvt_ob";
    ob_nm_mode::function_7610ada426867407( "nightmare_atrium_struct_1", "nightmare_atrium_boss_struct", 750, ai_bosses, undefined, "nm_encounter_atrium_miniboss", undefined, undefined, %"hash_3a042d199de86fa4" );
    ob_nm_mode::nightmare_teleport( "OB_LEO_NM_MACGUFFIN" );
    level thread ob_nm_mode::function_5dd43e7cb0682d57( "nightmare_atrium_boss_struct", "OB_LEO_NM_MACGUFFIN" );
    level utility::flag_set( "flag_nm_atrium_complete" );
    activity_instance_common::endactivity( activity_instance, 1 );
}

