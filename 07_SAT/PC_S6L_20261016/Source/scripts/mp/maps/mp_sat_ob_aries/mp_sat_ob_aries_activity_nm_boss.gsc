// scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_activity_nm_boss.gsc  (hash_71c447f5c8d0b399.gscc) (size: 6059 Bytes / 0x17ab / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1e7a8024 (511344676)
// size ...... 6059 (0x17ab)
// includes .. 9   (offset: 0x154b)
// strings ... 35  (offset: 0x1593)
// dev strs .. 0   (offset: 0x17ab)
// exports ... 17  (offset: 0xd33)
// cseg ...... 0x3b5 + 0x97e (0xd33)
// imports ... 46  (offset: 0xfdb)
// animtree1 . 0   (offset: 0x17ab)
// animtree2 . 0   (offset: 0x17ab)
#using script_34b50456e3922412;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\ob\systems\ob_item_select;

#namespace mp_sat_ob_aries_activity_nm_boss;

/#

    // Namespace mp_sat_ob_aries_activity_nm_boss
    // Params 0
    // Checksum 0x7d1c780d, Offset: 0x3d3
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace mp_sat_ob_aries_activity_nm_boss
// Params 0, eflags: 0x5
// Checksum 0xd846f2ba, Offset: 0x3e0
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_7103e9efe014b2fc", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace mp_sat_ob_aries_activity_nm_boss
// Params 0, eflags: 0x4
// Checksum 0xae486f1f, Offset: 0x409
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_ARIES_NM_BOSS";
    activity_common::registeractivitytype( "OB_ARIES_NM_BOSS", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_NM_BOSS", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_NM_BOSS", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_NM_BOSS", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_ARIES_NM_BOSS" );
}

// Namespace mp_sat_ob_aries_activity_nm_boss
// Params 0
// Checksum 0xd9b19f87, Offset: 0x480
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

// Namespace mp_sat_ob_aries_activity_nm_boss
// Params 0
// Checksum 0xabfae7b2, Offset: 0x4e5
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

// Namespace mp_sat_ob_aries_activity_nm_boss
// Params 0
// Checksum 0xe02be3f2, Offset: 0x54c
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace mp_sat_ob_aries_activity_nm_boss
// Params 1
// Checksum 0xf9f0c8e0, Offset: 0x570
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

    // Namespace mp_sat_ob_aries_activity_nm_boss
    // Params 0
    // Checksum 0x3aa6dc1d, Offset: 0x617
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace mp_sat_ob_aries_activity_nm_boss
// Params 1
// Checksum 0xbb532039, Offset: 0x624
// Size: 0xc
function player_setup( player )
{
    
}

// Namespace mp_sat_ob_aries_activity_nm_boss
// Params 0
// Checksum 0xc6c49f2, Offset: 0x638
// Size: 0x2
function nightmare_start()
{
    
}

// Namespace mp_sat_ob_aries_activity_nm_boss
// Params 0
// Checksum 0x7afebcfd, Offset: 0x642
// Size: 0x1e3
function nightmare_main()
{
    activity_instance = self;
    level.var_bd2748e149a8024b = self;
    level.nm_activity_instance = self;
    level.nm_activity_name = "OB_ARIES_NM_BOSS";
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level._effect[ "enemy_vfx" ] = loadfxasset( "vfx_sat_wc_ai_cradle_spawn_burst_med_01" );
    plant_boss = getent( "mars_body", "targetname" );
    
    if ( isdefined( plant_boss ) )
    {
        plant_boss delete();
    }
    
    struct = utility::getstruct( "struct_nm_ability_crate_boss", "targetname" );
    ob_item_select::function_95f9ecc2af4693f6( struct.origin, "super_mega_jump", "super_grappling_hook", #"tactical" );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "struct_nm_medkit_boss", "flag_nm_boss_complete", 1 );
    struct = utility::getstruct( "aries_boss_circle_struct", "targetname" );
    trigger = spawn( "trigger_radius", struct.origin - ( 0, 0, 512 ), 0, 512, 1024 );
    trigger disconnectpaths();
    function_88c7845b1fd904ab();
    ob_nm_mode::function_1f2648b3b22d9816();
    level thread spawn_cover();
    shard_points = [ "struct_shard_deposit_1", "struct_shard_deposit_2" ];
    function_a25acb62ddab20e2( "nm_minion_cradle", 1 );
    ob_nm_mode::function_332a6bdf2c77969f( shard_points, "encounter_nm_boss_activity", 0, %"hash_53ff02c32fc52547" );
    function_a25acb62ddab20e2( "nm_minion_cradle", 0 );
    level thread delete_cover();
    ob_nm_mode::nightmare_prepare();
    level thread razor_spawn_vfx();
    level thread function_c3105584a8fbf366();
    ob_nm_mode::function_bad3def5cf63c2b9( "aries_boss_circle_struct", "nightmare_aries_razor_boss_struct", 2000, "sat_ob_enemy_rozar_boss", 1, "team_hundred_ninety", 0 );
    level utility::flag_set( "flag_nm_boss_complete" );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace mp_sat_ob_aries_activity_nm_boss
// Params 0
// Checksum 0x5605340e, Offset: 0x82d
// Size: 0x2b
function function_88c7845b1fd904ab()
{
    aries_boss_ai_clips = getentarray( "aries_boss_ai_clips", "targetname" );
    
    if ( isdefined( aries_boss_ai_clips ) )
    {
        utility::array_delete( aries_boss_ai_clips );
    }
}

// Namespace mp_sat_ob_aries_activity_nm_boss
// Params 0
// Checksum 0x1f951a95, Offset: 0x860
// Size: 0x199
function spawn_cover()
{
    move_time = 5;
    clips = getentarray( "nm_scripted_container_brush", "targetname" );
    
    foreach ( piece in clips )
    {
        piece movez( 512, move_time, 0.5 );
    }
    
    models = getentarray( "nm_scripted_container_model", "targetname" );
    
    foreach ( part in models )
    {
        part movez( 512, move_time, 0.5 );
    }
    
    wait move_time;
    
    foreach ( piece in clips )
    {
        piece disconnectpaths();
    }
}

// Namespace mp_sat_ob_aries_activity_nm_boss
// Params 0
// Checksum 0xe9aeb283, Offset: 0xa01
// Size: 0xe6
function delete_cover()
{
    clips = getentarray( "nm_scripted_container_brush", "targetname" );
    
    foreach ( piece in clips )
    {
        piece delete();
    }
    
    models = getentarray( "nm_scripted_container_model", "targetname" );
    
    for ( i = 0; i < models.size ; i++ )
    {
        playfx( level._effect[ "enemy_vfx" ], models[ i ].origin );
        models[ i ] delete();
    }
}

// Namespace mp_sat_ob_aries_activity_nm_boss
// Params 0
// Checksum 0xee596aee, Offset: 0xaef
// Size: 0x19f
function razor_spawn_vfx()
{
    scene_struct = utility::getstruct( "razor_scene_struct", "targetname" );
    
    if ( isdefined( scene_struct ) )
    {
        laser_tag = utility::function_1808878d1c511ce8( ( 0, 0, 0 ), ( 0, 0, 0 ) );
        laser_tag.angles = scene_struct.angles + ( 0, 90, 0 );
        laser_tag.origin = scene_struct.origin;
        utility::add_fx( "laser_spawn_vfx", "vfx_sat_levels_wc_cradle_site_laser" );
        utility::add_fx( "blast_vfx", "vfx_sat_levels_wc_cradle_site_clean_blast" );
        utility::add_fx( "smoke_portal", "vfx_sat_levels_mp_odysseus_cradle_smoke_portal" );
        waitframe();
        var_8572982e37f6c36 = playfxontag( level._effect[ "smoke_portal" ], laser_tag, "tag_origin" );
        wait 18;
        blast_fx = playfxontag( level._effect[ "blast_vfx" ], laser_tag, "tag_origin" );
        var_73ba4a5d351f5560 = playfxontag( level._effect[ "laser_spawn_vfx" ], laser_tag, "tag_origin" );
        playrumbleonposition( "heavy_3s", laser_tag.origin );
        level utility::flag_wait( "razor_scene_start" );
        wait 1.5;
        stopfxontag( level._effect[ "laser_spawn_vfx" ], laser_tag, "tag_origin" );
        level utility::flag_wait( "razor_scene_end" );
        stopfxontag( level._effect[ "smoke_portal" ], laser_tag, "tag_origin" );
        laser_tag delete();
    }
}

// Namespace mp_sat_ob_aries_activity_nm_boss
// Params 0
// Checksum 0x23a9ecfa, Offset: 0xc96
// Size: 0x9d
function function_c3105584a8fbf366()
{
    level utility::flag_wait( "nightmare_encouter_active" );
    wait 1;
    
    if ( isdefined( level.razor ) )
    {
        foreach ( player in level.players )
        {
            player.nostun = 1;
        }
    }
}

