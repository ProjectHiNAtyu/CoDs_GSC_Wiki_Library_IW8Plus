// script_a6c07e9164bb935  (hash_0a6c07e9164bb935.gscc) (size: 3864 Bytes / 0xf18 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2bec10cb (736891083)
// size ...... 3864 (0xf18)
// includes .. 11  (offset: 0xd64)
// strings ... 26  (offset: 0xdbc)
// dev strs .. 0   (offset: 0xf18)
// exports ... 12  (offset: 0x7f8)
// cseg ...... 0x2f1 + 0x507 (0x7f8)
// imports ... 32  (offset: 0x9d8)
// animtree1 . 0   (offset: 0xf18)
// animtree2 . 0   (offset: 0xf18)
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
#using scripts\mp\ob\systems\ob_item_select;

#namespace namespace_cb3cb24a70826771;

/#

    // Namespace namespace_cb3cb24a70826771
    // Params 0
    // Checksum 0xb4bb682f, Offset: 0x30f
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_cb3cb24a70826771
// Params 0, eflags: 0x5
// Checksum 0x1d64f810, Offset: 0x31c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_88cd515e7238ad3e", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_cb3cb24a70826771
// Params 0, eflags: 0x4
// Checksum 0x67ef7f3d, Offset: 0x345
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LEO_NM_JUNGLE";
    activity_common::registeractivitytype( "OB_LEO_NM_JUNGLE", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LEO_NM_JUNGLE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LEO_NM_JUNGLE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LEO_NM_JUNGLE", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_LEO_NM_JUNGLE" );
}

// Namespace namespace_cb3cb24a70826771
// Params 0
// Checksum 0x8ebf8aef, Offset: 0x3bc
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

// Namespace namespace_cb3cb24a70826771
// Params 0
// Checksum 0xfcf4f2da, Offset: 0x421
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

// Namespace namespace_cb3cb24a70826771
// Params 0
// Checksum 0x298cf3d0, Offset: 0x488
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_cb3cb24a70826771
// Params 1
// Checksum 0xaefedd88, Offset: 0x4ac
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

    // Namespace namespace_cb3cb24a70826771
    // Params 0
    // Checksum 0xf301cc3f, Offset: 0x553
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_cb3cb24a70826771
// Params 1
// Checksum 0x3dd8367f, Offset: 0x560
// Size: 0x30
function player_setup( player )
{
    if ( isdefined( level.zrex ) )
    {
        player thread ob_story_mission_utils::function_16e0adef86e5d052( "zombie_phobos_healthbar", level.zrex );
    }
}

// Namespace namespace_cb3cb24a70826771
// Params 0
// Checksum 0x824f7b60, Offset: 0x598
// Size: 0x1e
function nightmare_start()
{
    level thread mp_sat_ob_leo_util::function_46c7dd890b4e2bbb();
    level thread mp_sat_ob_leo_util::function_3c8a17513e90ef86();
    utility::exploder( "leo_nic_rocks_falling" );
}

// Namespace namespace_cb3cb24a70826771
// Params 0
// Checksum 0xf2e68dcf, Offset: 0x5be
// Size: 0x23a
function nightmare_main()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level._effect[ "enemy_vfx" ] = loadfxasset( "vfx_sat_wc_ai_cradle_spawn_burst_med_01" );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "struct_nm_nicaragua_item", "flag_nm_jungle_complete", 1 );
    level.var_bd2748e149a8024b = self;
    level.nm_activity_instance = self;
    level.nm_activity_name = "OB_LEO_NM_JUNGLE";
    level.var_6ac65a56e9e60396 = "OB_LEO_NM_JUNGLE";
    struct = utility::getstruct( "nm_circle_start", "targetname" );
    ob_item_select::function_95f9ecc2af4693f6( struct.origin, "super_annihilator", "super_war_machine", #"default" );
    level thread ob_story_mission_utils::function_e6799e9a19df2365( "struct_nm_cache_jungle" );
    ob_nm_mode::function_1f2648b3b22d9816();
    circle_struct_array = [ "nm_circle_wave_0", "nm_circle_wave_1", "nm_circle_wave_2", "nm_circle_wave_3" ];
    encounter_array = [ "nm_encounter_nicaragua_activity_00", "nm_encounter_nicaragua_activity_01", "nm_encounter_nicaragua_activity_02", "nm_encounter_nicaragua_activity_03" ];
    var_4a3fc3b6173da92f = [ 5, 10, 10, 8 ];
    level.enemy_count_array = [ 10, 14, 18, 22 ];
    function_a25acb62ddab20e2( "nm_minion_guild", 1 );
    level.minion_kill_obj = 20 + level.players.size * 20;
    level.cadence_override = 2;
    ob_nm_mode::function_44bcd5233c8a155d( "nm_circle_start", circle_struct_array, encounter_array, var_4a3fc3b6173da92f, 512, 0, %"hash_3a042c199de86df1" );
    function_a25acb62ddab20e2( "nm_minion_guild", 0 );
    ob_nm_mode::nightmare_prepare();
    level.enemy_count_array = undefined;
    ob_nm_mode::function_bad3def5cf63c2b9( "struct_zrex_circle_static", "nightmare_nicaragua_boss_struct", 1000, "sat_spawner_zombie_phobos_ob", 1, "team_two_hundred", 1 );
    wait 5;
    level callback::callback( #"leo_nm_complete", { #players:level.players } );
    activity_instance_common::endactivity( activity_instance, 1 );
}

