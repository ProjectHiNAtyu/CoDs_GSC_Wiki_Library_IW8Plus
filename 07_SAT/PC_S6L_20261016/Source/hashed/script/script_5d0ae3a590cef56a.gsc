// script_5d0ae3a590cef56a  (hash_5d0ae3a590cef56a.gscc) (size: 3890 Bytes / 0xf32 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb9fca28f (3120341647)
// size ...... 3890 (0xf32)
// includes .. 10  (offset: 0xd8e)
// strings ... 24  (offset: 0xdde)
// dev strs .. 0   (offset: 0xf32)
// exports ... 12  (offset: 0x7b2)
// cseg ...... 0x2a7 + 0x50b (0x7b2)
// imports ... 36  (offset: 0x992)
// animtree1 . 0   (offset: 0xf32)
// animtree2 . 0   (offset: 0xf32)
#using script_34b50456e3922412;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_util;
#using scripts\mp\ob\systems\ob_item_select;

#namespace namespace_a954bbda5b527968;

/#

    // Namespace namespace_a954bbda5b527968
    // Params 0
    // Checksum 0x9f6b7636, Offset: 0x2c5
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_a954bbda5b527968
// Params 0, eflags: 0x5
// Checksum 0xc7fe5357, Offset: 0x2d2
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_b22ecff31dafd039", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_a954bbda5b527968
// Params 0, eflags: 0x4
// Checksum 0x4c3f6124, Offset: 0x2fb
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LEO_NM_MACGUFFIN";
    activity_common::registeractivitytype( "OB_LEO_NM_MACGUFFIN", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LEO_NM_MACGUFFIN", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LEO_NM_MACGUFFIN", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LEO_NM_MACGUFFIN", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_LEO_NM_MACGUFFIN" );
}

// Namespace namespace_a954bbda5b527968
// Params 0
// Checksum 0x3bb25caf, Offset: 0x372
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

// Namespace namespace_a954bbda5b527968
// Params 0
// Checksum 0x49f9249a, Offset: 0x3d7
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

// Namespace namespace_a954bbda5b527968
// Params 0
// Checksum 0x25cedc9, Offset: 0x43e
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_a954bbda5b527968
// Params 1
// Checksum 0x1bf30bc8, Offset: 0x462
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

    // Namespace namespace_a954bbda5b527968
    // Params 0
    // Checksum 0xd8d1d226, Offset: 0x509
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_a954bbda5b527968
// Params 1
// Checksum 0x59242e02, Offset: 0x516
// Size: 0xc
function player_setup( player )
{
    
}

// Namespace namespace_a954bbda5b527968
// Params 0
// Checksum 0xa99f6579, Offset: 0x52a
// Size: 0x1e
function nightmare_start()
{
    level thread mp_sat_ob_leo_util::function_46c7dd890b4e2bbb();
    level thread mp_sat_ob_leo_util::function_3c8a17513e90ef86();
    utility::exploder( "leo_nic_rocks_falling" );
}

// Namespace namespace_a954bbda5b527968
// Params 0
// Checksum 0x6050f0ca, Offset: 0x550
// Size: 0x262
function nightmare_main()
{
    activity_instance = self;
    level.var_bd2748e149a8024b = self;
    level.nm_activity_instance = self;
    level.nm_activity_name = "OB_LEO_NM_MACGUFFIN";
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level._effect[ "enemy_vfx" ] = loadfxasset( "vfx_sat_wc_ai_cradle_spawn_burst_med_01" );
    thread mp_sat_ob_leo_util::turn_off_force_field( "quantum_computer_ff", "targetname", 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "struct_nm_macguffin_item", "flag_nm_macguffin_complete", 1 );
    struct = utility::getstruct( "nightmare_macguffin_struct_1", "targetname" );
    level.var_76c3404f06466ae6 = struct;
    ob_item_select::function_95f9ecc2af4693f6( struct.origin, "super_survival_life_drain", "super_active_camo", #"default" );
    level thread ob_story_mission_utils::function_e6799e9a19df2365( "struct_nm_cache_macguffin" );
    scriptables = getentitylessscriptablearray( "leo_jailbreak", "script_noteworthy" );
    
    foreach ( thing in scriptables )
    {
        thing setscriptablepartstate( "body", "invisible" );
    }
    
    ob_nm_mode::function_1f2648b3b22d9816();
    ob_nm_mode::function_5457286dafa242e4( "nm_encounter_macguffin_activity", %"hash_3a042e199de87157" );
    ob_nm_mode::nightmare_prepare();
    ai_bosses = [];
    ai_bosses[ ai_bosses.size ] = "sat_ob_enemy_cradle_hvt_jugg_minigun";
    ai_bosses[ ai_bosses.size ] = "sat_juggerbot";
    ai_bosses[ ai_bosses.size ] = "sat_ob_enemy_cradle_hvt_jugg_minigun";
    ai_bosses[ ai_bosses.size ] = "sat_juggerbot";
    level.enemy_count_array = [ 4, 8, 12, 16 ];
    ob_nm_mode::function_7610ada426867407( "nightmare_macguffin_struct_1", "nightmare_macguffin_boss_struct", 750, ai_bosses, undefined, "nm_encounter_macguffin_miniboss", undefined, undefined, %"hash_3a042b199de86c3e" );
    level.enemy_count_array = undefined;
    ob_nm_mode::function_70467d6be224da52( "nm_overlord_sector_end" );
    ob_nm_mode::nightmare_teleport( "OB_LEO_NM_JUNGLE" );
    level thread ob_nm_mode::function_5dd43e7cb0682d57( "nightmare_macguffin_struct_1", "OB_LEO_NM_JUNGLE" );
    level utility::flag_set( "flag_nm_macguffin_complete" );
    activity_instance_common::endactivity( activity_instance, 1 );
}

