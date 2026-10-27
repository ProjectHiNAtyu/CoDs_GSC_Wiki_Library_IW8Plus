// script_1931519ec0674b31  (hash_1931519ec0674b31.gscc) (size: 11646 Bytes / 0x2d7e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x637248b6 (1668434102)
// size ...... 11646 (0x2d7e)
// includes .. 17  (offset: 0x2912)
// strings ... 71  (offset: 0x299a)
// dev strs .. 0   (offset: 0x2d7e)
// exports ... 26  (offset: 0x1ace)
// cseg ...... 0x70d + 0x13c1 (0x1ace)
// imports ... 84  (offset: 0x1ede)
// animtree1 . 0   (offset: 0x2d7e)
// animtree2 . 0   (offset: 0x2d7e)
#using script_34b50456e3922412;
#using script_38d332e857e7a312;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\chyron;
#using scripts\common\scene;
#using scripts\common\snd\snd;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_util;
#using scripts\mp\mp_agent;
#using scripts\mp\ob\systems\ob_item_select;

#namespace namespace_e35ae575c4ce8dbd;

/#

    // Namespace namespace_e35ae575c4ce8dbd
    // Params 0
    // Checksum 0xf782e3, Offset: 0x72b
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_e35ae575c4ce8dbd
// Params 0, eflags: 0x5
// Checksum 0x27248380, Offset: 0x738
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_28c84b1fcdd77008", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_e35ae575c4ce8dbd
// Params 0, eflags: 0x4
// Checksum 0xd3a395f1, Offset: 0x761
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LIBRA_NM_1";
    activity_common::registeractivitytype( "OB_LIBRA_NM_1", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_NM_1", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_NM_1", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_NM_1", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_LIBRA_NM_1" );
}

// Namespace namespace_e35ae575c4ce8dbd
// Params 0
// Checksum 0xb102c49, Offset: 0x7d8
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

// Namespace namespace_e35ae575c4ce8dbd
// Params 0
// Checksum 0x795b547c, Offset: 0x83d
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

// Namespace namespace_e35ae575c4ce8dbd
// Params 0
// Checksum 0x9dc0191c, Offset: 0x8a4
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_e35ae575c4ce8dbd
// Params 1
// Checksum 0x2b517b2e, Offset: 0x8c8
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

    // Namespace namespace_e35ae575c4ce8dbd
    // Params 0
    // Checksum 0x474d26f3, Offset: 0x96f
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_e35ae575c4ce8dbd
// Params 1
// Checksum 0xb2655f12, Offset: 0x97c
// Size: 0x30
function player_setup( player )
{
    if ( isdefined( level.health_struct ) )
    {
        player ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_nm_rhino", level.health_struct );
    }
}

// Namespace namespace_e35ae575c4ce8dbd
// Params 0
// Checksum 0x7187b31c, Offset: 0x9b4
// Size: 0x2
function nightmare_start()
{
    
}

// Namespace namespace_e35ae575c4ce8dbd
// Params 0
// Checksum 0x36a7be7f, Offset: 0x9be
// Size: 0x196
function nightmare_main()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.var_bd2748e149a8024b = self;
    level.nm_activity_instance = self;
    level.nm_activity_name = "OB_LIBRA_NM_1";
    thread ob_nm_mode::watch_solo_player();
    namespace_78b1c18caf50ee83::function_d41002779543c80e( undefined, 0.01, 0.01 );
    level._effect[ "enemy_vfx" ] = loadfxasset( "vfx_sat_wc_ai_cradle_spawn_burst_med_01" );
    level._effect[ "mech_repulsor" ] = loadfxasset( "vfx_sat_wc_libra_mech_repulsor_aoe" );
    level._effect[ "blast_vfx" ] = loadfxasset( "vfx_sat_levels_wc_cradle_site_clean_blast" );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "struct_nm_storage_medkit", "flag_libra_nm_1_complete", 1 );
    thread mp_sat_ob_libra_util::function_3404036aa1432445( "storage_side_door", 1, 1, 1 );
    thread mp_sat_ob_libra_util::function_3404036aa1432445( "storage_door_trig", 1, 1, 1 );
    thread function_b13946401774bfab();
    thread function_5d0c10362a91cd63();
    level thread namespace_e9f5d4f831b290e0::function_a8a5021af4501af4();
    struct = utility::getstruct( "struct_nm_1_crate", "targetname" );
    
    if ( struct )
    {
        ob_item_select::function_95f9ecc2af4693f6( struct.origin, "super_mega_jump", "super_grappling_hook", #"tactical" );
    }
    
    ob_nm_mode::function_1f2648b3b22d9816( undefined, "nm_overlord_glich_start" );
    function_f3df2664d7d1b2c2( "struct_libra_nm_1_boss", "sat_juggerbot_ob_boss_nm" );
    level utility::flag_set( "flag_libra_nm_1_complete" );
    ob_nm_mode::nightmare_teleport( "OB_LIBRA_NM_2" );
    level thread ob_nm_mode::function_5dd43e7cb0682d57( "struct_libra_nm_1", "OB_LIBRA_NM_2" );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_e35ae575c4ce8dbd
// Params 0
// Checksum 0xd1ba047, Offset: 0xb5c
// Size: 0x16e
function function_5d0c10362a91cd63()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    level endon( #"robotic_lines_disabled" );
    
    while ( !isdefined( level.var_75dacee2337798ec ) || !isdefined( level.var_af192118978d72d9 ) )
    {
        if ( utility::flag( "flag_libra_nm_1_complete" ) )
        {
            return;
        }
        
        wait 0.1;
    }
    
    hatch01_top = level.var_75dacee2337798ec scene::get_entity( "hatch01_top" );
    hatch02_top = level.var_75dacee2337798ec scene::get_entity( "hatch02_top" );
    hatch05_top = level.var_af192118978d72d9 scene::get_entity( "hatch05_top" );
    hatch06_top = level.var_af192118978d72d9 scene::get_entity( "hatch06_top" );
    top_hatches = [ hatch01_top, hatch02_top, hatch05_top, hatch06_top ];
    
    foreach ( var_6cf54908cd066dfc in top_hatches )
    {
        if ( isdefined( var_6cf54908cd066dfc ) )
        {
            var_6cf54908cd066dfc thread function_c0c2af185ac0bf20();
        }
    }
}

// Namespace namespace_e35ae575c4ce8dbd
// Params 0
// Checksum 0xb9e44f01, Offset: 0xcd2
// Size: 0x130
function function_c0c2af185ac0bf20()
{
    var_6cf54908cd066dfc = self;
    var_6cf54908cd066dfc endon( #"death" );
    level endon( #"robotic_lines_disabled" );
    
    if ( !isdefined( var_6cf54908cd066dfc.var_2529d7bfd355abb6 ) )
    {
        var_6cf54908cd066dfc.var_2529d7bfd355abb6 = var_6cf54908cd066dfc.origin[ 2 ];
    }
    
    while ( !utility::flag( "flag_libra_nm_1_complete" ) )
    {
        hatch_is_open = isdefined( var_6cf54908cd066dfc.origin ) && var_6cf54908cd066dfc.origin[ 2 ] > var_6cf54908cd066dfc.var_2529d7bfd355abb6 + 2;
        
        if ( hatch_is_open && !isdefined( var_6cf54908cd066dfc.var_7c346c3f3aa0cd5c ) )
        {
            var_6cf54908cd066dfc.var_7c346c3f3aa0cd5c = snd::play( "amb_force_field_libra_nm_lp", var_6cf54908cd066dfc );
        }
        else if ( !hatch_is_open && isdefined( var_6cf54908cd066dfc.var_7c346c3f3aa0cd5c ) )
        {
            snd::stop( var_6cf54908cd066dfc.var_7c346c3f3aa0cd5c );
            var_6cf54908cd066dfc.var_7c346c3f3aa0cd5c = undefined;
        }
        
        wait 0.1;
    }
    
    if ( isdefined( var_6cf54908cd066dfc.var_7c346c3f3aa0cd5c ) )
    {
        snd::stop( var_6cf54908cd066dfc.var_7c346c3f3aa0cd5c );
        var_6cf54908cd066dfc.var_7c346c3f3aa0cd5c = undefined;
    }
}

// Namespace namespace_e35ae575c4ce8dbd
// Params 0
// Checksum 0xf518dd52, Offset: 0xe0a
// Size: 0xa
function function_b13946401774bfab()
{
    level thread function_3d8c9ad8020377e4();
}

// Namespace namespace_e35ae575c4ce8dbd
// Params 0
// Checksum 0xe77d0008, Offset: 0xe1c
// Size: 0x92
function function_3d8c9ad8020377e4()
{
    amb_struct = utility::getstruct( "storage_central_waypoint_org", "targetname" );
    amb_origin = ( 852, -1927, 1528 );
    
    if ( isdefined( amb_struct ) )
    {
        amb_origin = amb_struct.origin;
    }
    
    level.var_65dd22b708485692 = snd::play( "amb_quad_3d_libra_storage_lr", amb_origin );
    level utility::flag_wait( "flag_libra_nm_1_complete" );
    
    if ( isdefined( level.var_65dd22b708485692 ) )
    {
        snd::stop( level.var_65dd22b708485692 );
        level.var_65dd22b708485692 = undefined;
    }
}

// Namespace namespace_e35ae575c4ce8dbd
// Params 2
// Checksum 0x8dd09d03, Offset: 0xeb6
// Size: 0x43e
function function_f3df2664d7d1b2c2( var_e04c0425c57a325, main_boss = "sat_spawner_zombie_disciple_skoll_ob_falkner" )
{
    ob_nm_mode::start_of_round_fanfare( "nm_overlord_boss_start", "nm_boss_start" );
    self.var_9be376218db54aba = "sat_ob_objectivemarker_nm_big_boss";
    var_e04c0425c57a325 = utility::getstructarray( var_e04c0425c57a325, "targetname" );
    var_e04c0425c57a325 = arrayrandomize( var_e04c0425c57a325 );
    level utility::flag_clear( "nightmare_encouter_done" );
    ob_story_mission_utils::objective_text_show( %"hash_f401d4226f34697" );
    num_bosses = 1;
    level.nm_bosses = num_bosses;
    level.var_ff552d2355510bb7 = 0;
    wait 1;
    level.boss_total_time = 600;
    ob_story_mission_utils::objective_timer_update( level.boss_total_time );
    level.rhino_start_time = gettime();
    level thread ob_nm_mode::wave_fail_timer( level.boss_total_time );
    level.enemy_count_array = [ 7, 10, 13, 16 ];
    level.cadence_override = 0.5;
    function_a25acb62ddab20e2( "nm_minion_zombie", 1 );
    playfx( level._effect[ "enemy_vfx" ], var_e04c0425c57a325[ 0 ].origin );
    boss = mp_agent::spawnnewagentaitype( main_boss, var_e04c0425c57a325[ 0 ].origin, var_e04c0425c57a325[ 0 ].angles, "team_two_hundred" );
    level utility::flag_set( "flag_skip_rozar_death" );
    level.boss_teleport_structs = utility::getstructarray( "boss_teleport_structs", "script_noteworthy" );
    level.bubble_shield_teleport_structs = utility::getstructarray( "bubble_shield_teleport_structs", "script_noteworthy" );
    level.boss_mega_jump_structs = utility::getstructarray( "boss_mega_jump_structs", "script_noteworthy" );
    level.boss_block_traversal_structs = utility::getstructarray( "boss_block_traversal_structs", "script_noteworthy" );
    level utility::flag_set( "nightmare_encouter_active" );
    level.nm_1_boss = boss;
    level.nm_1_boss.var_24954f14e27b448d = 0;
    level.nm_1_boss setup_boss_health();
    level.nm_1_boss.nm_boss = 1;
    level.nm_1_boss.var_1b5e87bd56ab3e6b = 0.01;
    level.nm_1_boss agent_utils::function_1874e18b42e6d814( &boss_immune );
    waitframe();
    level.nm_1_boss thread ob_nm_mode::setup_boss_healthbar( level.nm_1_boss.health, level.nm_1_boss.maxhealth, "ob_boss_nm_rhino" );
    level.nm_1_boss thread boss_stage_setup();
    level.boss_obj_id = ob_story_mission_utils::function_804834359f20ef5a( level.nm_1_boss );
    function_2b8e3d3ae2a6414a( level.boss_obj_id, 0 );
    boss waittill( #"death" );
    playfx( level._effect[ "blast_vfx" ], boss.origin );
    
    if ( isdefined( level.boss_obj_id ) )
    {
        ob_story_mission_utils::objective_marker_clear( level.boss_obj_id );
    }
    
    level thread function_aba2686729407f26();
    level utility::flag_set( "flag_nm_1_boss_dead" );
    level notify( #"cleanup_minions" );
    level utility::flag_clear( "nightmare_encouter_active" );
    level utility::flag_set( "nightmare_encouter_done" );
    level notify( #"hash_aefc5c470125baf8" );
    level utility::flag_clear( "flag_shard_round" );
    level utility::flag_set( "flag_shard_event_done" );
    level utility::flag_set( "flag_boss_stage_1" );
    level utility::flag_set( "flag_boss_stage_2" );
    level utility::flag_set( "flag_boss_stage_3" );
    level notify( #"shard_event_done" );
    
    foreach ( player in level.players )
    {
        player notify( #"stop_shard_hint" );
    }
    
    self.var_9be376218db54aba = undefined;
    wait 4;
    ob_nm_mode::end_of_round_fanfare( "nm_overlord_boss_dead", "nm_boss_end" );
}

// Namespace namespace_e35ae575c4ce8dbd
// Params 1
// Checksum 0x67f3e516, Offset: 0x12fc
// Size: 0x3e
function boss_immune( dmg_struct )
{
    if ( self.boss_immune )
    {
        return -2;
    }
    
    return clamp( dmg_struct.idamage, 0, int( self.maxhealth * 0.01 ) );
}

// Namespace namespace_e35ae575c4ce8dbd
// Params 1
// Checksum 0xee4d31d6, Offset: 0x1343
// Size: 0xbf
function function_b3cfd5e956f6b49c( b_immune )
{
    self endon( #"death" );
    
    foreach ( player in level.players )
    {
        if ( b_immune )
        {
            player ob_story_mission_utils::player_boss_healthbar_immune();
        }
        else
        {
            player thread ob_story_mission_utils::player_boss_healthbar_show();
        }
        
        player ob_story_mission_utils::function_e231206f1628d4c6( 1, self.health, self.max_health );
    }
}

// Namespace namespace_e35ae575c4ce8dbd
// Params 0
// Checksum 0xef9286e4, Offset: 0x140a
// Size: 0x69
function setup_boss_health()
{
    var_78a1a9cabfc4d42e = 600000;
    new_health = var_78a1a9cabfc4d42e;
    
    if ( level.players.size )
    {
        new_health = var_78a1a9cabfc4d42e * level.players.size;
    }
    
    new_health = int( new_health );
    self.maxhealth = new_health;
    self.health = self.maxhealth;
    mp_agent::set_agent_health( new_health );
}

// Namespace namespace_e35ae575c4ce8dbd
// Params 0
// Checksum 0xa892e216, Offset: 0x147b
// Size: 0x29c
function function_117a81f4b3ee159a()
{
    utility::add_fx( "shard_vfx", "vfx_sat_wc_gameplay_nightmare_shards_01" );
    utility::add_fx( "score_vfx", "vfx_sat_zm_weapons_fireworks_burst_ch_yellow" );
    utility::add_fx( "deposit_zone", "vfx_sat_zm_weapons_fireworks_fire_wheel_yellow" );
    utility::add_fx( "deposit_beam", "vfx_sat_saw_avalon_cradle_warp_portal_sky_beam" );
    level notify( #"hash_d8beacc10da6a7ee" );
    level utility::flag_clear( "flag_shard_event_done" );
    level.shard_event = 1;
    level.var_2e07a4798d97c706 = 0;
    level.var_99f5df355fd6eae7 = 0;
    level.shards_collected = 0;
    level utility::flag_set( "flag_shard_round" );
    level.shard_spawner_type = "snipe";
    level.shard_objective_count = level.players.size * 4;
    wait 3;
    level.nm_activity_instance ob_story_mission_utils::objective_text_show( %"hash_5d38ac682f61924f" );
    current_time = gettime();
    duration = abs( current_time - level.rhino_start_time );
    var_31688a0f3073df86 = int( duration / 1000 );
    time_remaining = abs( level.boss_total_time - var_31688a0f3073df86 );
    level.nm_activity_instance ob_story_mission_utils::objective_timer_update( time_remaining );
    ob_nm_mode::start_of_round_fanfare( "nm_overlord_shard_start", "nm_shard_start" );
    level.var_bd2748e149a8024b ob_story_mission_utils::function_315d79883d962ba7( 0, level.shard_objective_count );
    thread ob_nm_mode::function_30533bd3780661e4( "struct_libra_nm_1", "stop_dropoff_1" );
    
    while ( level.shards_collected < level.shard_objective_count )
    {
        waitframe();
    }
    
    level thread function_63ce9f1b8e59c0d();
    level.var_bd2748e149a8024b ob_story_mission_utils::function_315d79883d962ba7( 0, 0 );
    level utility::flag_set( "flag_shard_event_done" );
    level utility::flag_clear( "flag_shard_round" );
    level notify( #"shard_event_done" );
    
    foreach ( player in level.players )
    {
        player notify( #"stop_shard_hint" );
    }
    
    if ( isarray( level.var_3da29412e8cac16a ) )
    {
        for ( i = 0; i < level.var_3da29412e8cac16a.size ; i++ )
        {
            level.var_3da29412e8cac16a[ i ] setscriptablepartstate( "chevron", "off" );
        }
    }
}

// Namespace namespace_e35ae575c4ce8dbd
// Params 0
// Checksum 0x1bb152cd, Offset: 0x171f
// Size: 0x2e
function function_63ce9f1b8e59c0d()
{
    level endon( #"hash_aefc5c470125baf8" );
    level endon( #"hash_d8beacc10da6a7ee" );
    wait 4;
    ob_nm_mode::start_of_round_fanfare( "nm_overlord_boss_start", "nm_boss_vulnerable" );
}

// Namespace namespace_e35ae575c4ce8dbd
// Params 0
// Checksum 0x7aff5e3a, Offset: 0x1755
// Size: 0x11b
function boss_stage_setup()
{
    self endon( #"death" );
    max_health = self.health;
    level.nm_activity_instance thread ob_nm_mode::minion_encounter( "encounter_nm_1_boss", "flag_boss_stage_1" );
    
    while ( self.health > max_health * 0.75 )
    {
        waitframe();
    }
    
    level utility::flag_set( "flag_boss_stage_1" );
    wait 2;
    level.nm_activity_instance thread ob_nm_mode::minion_encounter( "encounter_nm_1_boss_1", "flag_boss_stage_2" );
    function_77b69729b53156a6();
    
    while ( self.health > max_health * 0.5 )
    {
        waitframe();
    }
    
    level utility::flag_set( "flag_boss_stage_2" );
    wait 2;
    level.nm_activity_instance thread ob_nm_mode::minion_encounter( "encounter_nm_1_boss_2", "flag_boss_stage_3" );
    function_77b69729b53156a6();
    
    while ( self.health > max_health * 0.25 )
    {
        waitframe();
    }
    
    level utility::flag_set( "flag_boss_stage_3" );
    wait 2;
    level.nm_activity_instance thread ob_nm_mode::minion_encounter( "encounter_nm_1_boss_3", "flag_nm_1_boss_dead" );
    function_77b69729b53156a6();
}

// Namespace namespace_e35ae575c4ce8dbd
// Params 0
// Checksum 0xd553517d, Offset: 0x1878
// Size: 0x12e
function function_77b69729b53156a6()
{
    self endon( #"death" );
    playfx( level._effect[ "mech_repulsor" ], self.origin + ( 0, 0, 50 ) );
    self.boss_immune = 1;
    childthread function_b3cfd5e956f6b49c( 1 );
    level thread ob_nm_mode::function_3b33d641fd3a8730( self, 5, 8 );
    function_117a81f4b3ee159a();
    level.nm_activity_instance ob_story_mission_utils::objective_text_show( %"hash_f401d4226f34697" );
    current_time = gettime();
    duration = abs( current_time - level.rhino_start_time );
    var_31688a0f3073df86 = int( duration / 1000 );
    time_remaining = abs( level.boss_total_time - var_31688a0f3073df86 );
    level.nm_activity_instance ob_story_mission_utils::objective_timer_update( time_remaining );
    playfx( level._effect[ "mech_repulsor" ], self.origin + ( 0, 0, 50 ) );
    level thread ob_nm_mode::function_3b33d641fd3a8730( self, 5, 8 );
    self.boss_immune = 0;
    childthread function_b3cfd5e956f6b49c( 0 );
}

// Namespace namespace_e35ae575c4ce8dbd
// Params 1
// Checksum 0xaea297fc, Offset: 0x19ae
// Size: 0x71
function shock_stick_threshold( value )
{
    level.nm_1_boss endon( #"death" );
    max_health = level.nm_1_boss.maxhealth;
    
    while ( level.nm_1_boss.health > max_health * value )
    {
        waitframe();
    }
    
    level thread ob_nm_mode::function_3b33d641fd3a8730( level.nm_1_boss, 1 );
}

// Namespace namespace_e35ae575c4ce8dbd
// Params 0
// Checksum 0x74ed661b, Offset: 0x1a27
// Size: 0xa7
function function_aba2686729407f26()
{
    foreach ( player in level.players )
    {
        if ( player utility::ent_flag( "flag_fail_shock_challenge" ) )
        {
            return;
        }
    }
    
    level callback::callback( #"hash_8d02a676820106cb", { #players:level.players } );
}

