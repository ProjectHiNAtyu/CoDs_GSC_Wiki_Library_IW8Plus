// scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_activity_nm_barge.gsc  (hash_7b6b0f5ae53538bb.gscc) (size: 5853 Bytes / 0x16dd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2e2d3787 (774715271)
// size ...... 5853 (0x16dd)
// includes .. 10  (offset: 0x1429)
// strings ... 41  (offset: 0x1479)
// dev strs .. 0   (offset: 0x16dd)
// exports ... 14  (offset: 0xd15)
// cseg ...... 0x433 + 0x8e2 (0xd15)
// imports ... 42  (offset: 0xf45)
// animtree1 . 0   (offset: 0x16dd)
// animtree2 . 0   (offset: 0x16dd)
#using script_34b50456e3922412;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\mp_agent;
#using scripts\mp\ob\systems\ob_item_select;

#namespace mp_sat_ob_aries_activity_nm_barge;

/#

    // Namespace mp_sat_ob_aries_activity_nm_barge
    // Params 0
    // Checksum 0xbb4d8d0d, Offset: 0x451
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace mp_sat_ob_aries_activity_nm_barge
// Params 0, eflags: 0x5
// Checksum 0xd47782fb, Offset: 0x45e
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_1019e664bcf6fdf6", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace mp_sat_ob_aries_activity_nm_barge
// Params 0, eflags: 0x4
// Checksum 0x68199a1f, Offset: 0x487
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_ARIES_NM_BARGE";
    activity_common::registeractivitytype( "OB_ARIES_NM_BARGE", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_NM_BARGE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_NM_BARGE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_NM_BARGE", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_ARIES_NM_BARGE" );
}

// Namespace mp_sat_ob_aries_activity_nm_barge
// Params 0
// Checksum 0x8962a0cc, Offset: 0x4fe
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

// Namespace mp_sat_ob_aries_activity_nm_barge
// Params 0
// Checksum 0xfb29d8f9, Offset: 0x563
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

// Namespace mp_sat_ob_aries_activity_nm_barge
// Params 0
// Checksum 0x267a16f2, Offset: 0x5ca
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace mp_sat_ob_aries_activity_nm_barge
// Params 1
// Checksum 0xa923f7ab, Offset: 0x5ee
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

    // Namespace mp_sat_ob_aries_activity_nm_barge
    // Params 0
    // Checksum 0xfcf7291d, Offset: 0x695
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace mp_sat_ob_aries_activity_nm_barge
// Params 1
// Checksum 0x7d02d539, Offset: 0x6a2
// Size: 0xc
function player_setup( player )
{
    
}

// Namespace mp_sat_ob_aries_activity_nm_barge
// Params 0
// Checksum 0xca3dbcf2, Offset: 0x6b6
// Size: 0x2
function nightmare_start()
{
    
}

// Namespace mp_sat_ob_aries_activity_nm_barge
// Params 0
// Checksum 0xdb316898, Offset: 0x6c0
// Size: 0x2bd
function nightmare_main()
{
    activity_instance = self;
    level.var_bd2748e149a8024b = self;
    level.nm_activity_instance = self;
    level.nm_activity_name = "OB_ARIES_NM_BARGE";
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level._effect[ "enemy_vfx" ] = loadfxasset( "vfx_sat_wc_ai_cradle_spawn_burst_med_01" );
    vine = getscriptablearray( "weakpoint_vine_3", "script_noteworthy" )[ 0 ];
    level thread function_2c0c2f0f672423bf( 3, vine );
    plant_boss = getent( "mars_body", "targetname" );
    
    if ( isdefined( plant_boss ) )
    {
        plant_boss delete();
    }
    
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "struct_nm_medkit_barge", "flag_nm_barge_complete", 1 );
    struct = utility::getstruct( "struct_barge_defend_drop_2", "targetname" );
    ob_item_select::function_95f9ecc2af4693f6( struct.origin, "super_mega_jump", "super_grappling_hook", #"tactical" );
    ob_nm_mode::function_1f2648b3b22d9816();
    encounter_array = [ "encounter_nm_barge_activity_1", "encounter_nm_barge_activity_2" ];
    barge_points = [ "barge_cap_point_1", "barge_cap_point_2", "barge_cap_point_3" ];
    function_a25acb62ddab20e2( "nm_minion_cradle", 1 );
    level.enemy_count_array = [ 7, 10, 12, 15 ];
    special_enemy_array = [ undefined, undefined ];
    level.capture_scalar = 20;
    ob_nm_mode::function_3c06bea68f7652a6( "struct_capture_br_circle", barge_points, encounter_array, special_enemy_array, undefined, %"hash_53ff00c32fc521e1" );
    level.capture_scalar = undefined;
    function_a25acb62ddab20e2( "nm_minion_cradle", 0 );
    ob_nm_mode::nightmare_prepare();
    utility::add_fx( "disciple_trail_vfx", "vfx_sat_wc_vgo_crr_boss_attack_mouth_projectile_trail" );
    level.var_6ac65a56e9e60396 = "OB_ARIES_NM_CHURCH";
    ai_bosses = [];
    ai_bosses[ ai_bosses.size ] = "sat_spawner_zombie_disciple_skoll_ob";
    level utility::flag_set( "flag_disciple_circle" );
    ob_nm_mode::nightmare_disciple_fight( "struct_nm_barge_boss", "nm_barge_boss_struct", 1500, ai_bosses, 1, "encounter_nm_barge_miniboss", undefined, undefined, %"hash_53ff01c32fc52394" );
    level utility::flag_clear( "flag_disciple_circle" );
    barge_cover = getentarray( "nm_barge_cover", "targetname" );
    
    if ( isdefined( barge_cover ) )
    {
        utility::array_delete( barge_cover );
    }
    
    level.var_6ac65a56e9e60396 = undefined;
    level utility::flag_set( "flag_nm_barge_complete" );
    ob_nm_mode::nightmare_teleport( "OB_ARIES_NM_BOSS" );
    level.var_6ac65a56e9e60396 = "OB_ARIES_NM_BOSS";
    level thread ob_nm_mode::function_5dd43e7cb0682d57( "struct_nm_barge_boss", "OB_ARIES_NM_BOSS" );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace mp_sat_ob_aries_activity_nm_barge
// Params 2
// Checksum 0xfde00549, Offset: 0x985
// Size: 0x155
function function_2c0c2f0f672423bf( index, vine )
{
    vine setscriptablepartstate( "base", "dead" );
    vine hide();
    var_4447097a75e6472c = getent( "e_jungle_root_collision_" + index, #targetname );
    vine_claws = getscriptablearray( "vine_claw_" + index, #script_noteworthy );
    a_e_chain = [];
    a_e_chain[ a_e_chain.size ] = var_4447097a75e6472c;
    
    while ( true )
    {
        if ( isdefined( var_4447097a75e6472c.target ) )
        {
            var_4447097a75e6472c = getent( var_4447097a75e6472c.target, "targetname" );
            a_e_chain[ a_e_chain.size ] = var_4447097a75e6472c;
        }
        else
        {
            break;
        }
        
        waitframe();
    }
    
    for ( i = 0; i < a_e_chain.size ; i++ )
    {
        a_e_chain[ i ] delete();
        waitframe();
    }
    
    foreach ( var_514041e713ec83b5 in vine_claws )
    {
        var_514041e713ec83b5 setscriptablepartstate( "base", "dead" );
    }
}

// Namespace mp_sat_ob_aries_activity_nm_barge
// Params 0
// Checksum 0xa7c88032, Offset: 0xae2
// Size: 0x233
function function_56e9168d9778cd40()
{
    level utility::flag_wait( "flag_defend_event_done_1" );
    level.var_25d482efa82424c7 = [];
    
    switch ( level.players.size )
    {
        case 1:
            heavy_ai_spawn_pos_01 = utility::getstruct( "heavy_ai_spawn_pos_01", "targetname" );
            level.var_25d482efa82424c7[ 0 ] = heavy_ai_spawn_pos_01;
            break;
        case 2:
            heavy_ai_spawn_pos_01 = utility::getstruct( "heavy_ai_spawn_pos_01", "targetname" );
            level.var_25d482efa82424c7[ 0 ] = heavy_ai_spawn_pos_01;
            break;
        case 3:
            heavy_ai_spawn_pos_01 = utility::getstruct( "heavy_ai_spawn_pos_01", "targetname" );
            heavy_ai_spawn_pos_02 = utility::getstruct( "heavy_ai_spawn_pos_02", "targetname" );
            heavy_ai_spawn_pos_03 = utility::getstruct( "heavy_ai_spawn_pos_03", "targetname" );
            level.var_25d482efa82424c7[ 0 ] = heavy_ai_spawn_pos_01;
            level.var_25d482efa82424c7[ 1 ] = heavy_ai_spawn_pos_02;
            level.var_25d482efa82424c7[ 2 ] = heavy_ai_spawn_pos_03;
            break;
        case 4:
            heavy_ai_spawn_pos_01 = utility::getstruct( "heavy_ai_spawn_pos_01", "targetname" );
            heavy_ai_spawn_pos_02 = utility::getstruct( "heavy_ai_spawn_pos_02", "targetname" );
            heavy_ai_spawn_pos_03 = utility::getstruct( "heavy_ai_spawn_pos_03", "targetname" );
            level.var_25d482efa82424c7[ 0 ] = heavy_ai_spawn_pos_01;
            level.var_25d482efa82424c7[ 1 ] = heavy_ai_spawn_pos_02;
            level.var_25d482efa82424c7[ 2 ] = heavy_ai_spawn_pos_03;
            break;
    }
    
    foreach ( spawn_point in level.var_25d482efa82424c7 )
    {
        boss = mp_agent::spawnnewagentaitype( "sat_ob_enemy_cradle_hvt_jugg_minigun", spawn_point.origin, spawn_point.angles, "team_hundred_ninety" );
        thread ob_nm_mode::minion_vanish( undefined, "flag_defend_done", boss, undefined );
    }
}

