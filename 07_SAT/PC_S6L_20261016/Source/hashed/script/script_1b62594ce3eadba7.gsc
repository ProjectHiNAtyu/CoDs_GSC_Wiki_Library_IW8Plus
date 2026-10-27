// script_1b62594ce3eadba7  (hash_1b62594ce3eadba7.gscc) (size: 11857 Bytes / 0x2e51 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb0473e5a (2957459034)
// size ...... 11857 (0x2e51)
// includes .. 18  (offset: 0x298d)
// strings ... 69  (offset: 0x2a1d)
// dev strs .. 3   (offset: 0x2e2d)
// exports ... 21  (offset: 0x19d5)
// cseg ...... 0x690 + 0x1345 (0x19d5)
// imports ... 105 (offset: 0x1d1d)
// animtree1 . 0   (offset: 0x2e51)
// animtree2 . 0   (offset: 0x2e51)
#using script_34b50456e3922412;
#using script_40a898aee4e41369;
#using script_636bd827a012af12;
#using script_66878054d141dbc0;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\hud_util;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\ob\systems\ob_item_select;
#using scripts\mp\weapons;

#namespace ob_nm_la;

/#

    // Namespace ob_nm_la
    // Params 0
    // Checksum 0xbd77e11f, Offset: 0x6ae
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace ob_nm_la
// Params 0, eflags: 0x5
// Checksum 0xe319bf43, Offset: 0x6bb
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_697fc9ae55e36c95", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_nm_la
// Params 0, eflags: 0x4
// Checksum 0x6e23f60d, Offset: 0x6e4
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_VIRGO_NM_LA";
    activity_common::registeractivitytype( "OB_VIRGO_NM_LA", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_NM_LA", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_NM_LA", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_NM_LA", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_VIRGO_NM_LA" );
}

// Namespace ob_nm_la
// Params 0
// Checksum 0x57190c17, Offset: 0x75b
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

// Namespace ob_nm_la
// Params 0
// Checksum 0xfb9c00b5, Offset: 0x7c0
// Size: 0x92
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    level.request_ids = [];
    utility::add_fx( "escort_beam", "vfx_sat_saw_avalon_cradle_warp_portal_sky_beam" );
    utility::add_fx( "escort_zone", "vfx_sat_zm_weapons_fireworks_fire_wheel_yellow" );
    utility::add_fx( "laser_spawn_vfx", "vfx_sat_levels_wc_cradle_site_laser" );
    
    if ( !ob::nightmare() )
    {
        activity_instance waittill( #"hash_1e9bc5e84aa89155" );
    }
    
    activity_instance thread nightmare_main();
}

// Namespace ob_nm_la
// Params 0
// Checksum 0x20407ae0, Offset: 0x85a
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace ob_nm_la
// Params 1
// Checksum 0x77585b70, Offset: 0x87e
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

    // Namespace ob_nm_la
    // Params 0
    // Checksum 0xfacd450f, Offset: 0x925
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace ob_nm_la
// Params 1
// Checksum 0x7b38b92b, Offset: 0x932
// Size: 0xc
function player_setup( player )
{
    
}

// Namespace ob_nm_la
// Params 0
// Checksum 0xcc07d0e0, Offset: 0x946
// Size: 0x2
function nightmare_start()
{
    
}

// Namespace ob_nm_la
// Params 0
// Checksum 0x2d155a67, Offset: 0x950
// Size: 0x23
function setup_cradle_audio()
{
    if ( !isdefined( level.audio ) )
    {
        level.audio = spawnstruct();
    }
    
    level thread namespace_a350a26c6d662a6a::function_be0e9dd8c09bbe32();
}

// Namespace ob_nm_la
// Params 0
// Checksum 0x4f23e7a9, Offset: 0x97b
// Size: 0x390
function nightmare_main()
{
    level.activity_instance = self;
    level.var_bd2748e149a8024b = self;
    level.nm_activity_instance = self;
    level.nm_activity_name = "OB_VIRGO_NM_LA";
    level.activity_instance endon( #"activity_ended" );
    level.activity_instance endon( #"instance_destroyed" );
    case_struct = utility::getstruct( "nm_la_case", "targetname" );
    
    if ( isdefined( case_struct ) )
    {
        level thread ob_item_select::function_95f9ecc2af4693f6( case_struct.origin, "super_bubble_shield", "super_active_camo", #"default" );
    }
    
    level thread ob_story_mission_utils::function_e6799e9a19df2365( "nm_la_cache", %"ob_sat_items_equipment", 2 );
    
    if ( level.players.size > 2 )
    {
        var_83fb2972126d7a2 = 2;
    }
    
    if ( level.players.size <= 2 )
    {
        var_83fb2972126d7a2 = 3;
    }
    
    level.activity_instance thread ob_story_mission_utils::item_spawn_equipment( "struct_nm_medkit_la", "flag_nm_barge_complete", 1, undefined, undefined, undefined, var_83fb2972126d7a2 );
    bm_clip_virgo_hack = getentarray( "bm_clip_virgo_hack", "targetname" );
    
    foreach ( clip in bm_clip_virgo_hack )
    {
        if ( isdefined( clip ) )
        {
            clip delete();
        }
    }
    
    turret_structs = utility::getstructarray( "struct_la_nm_turret", "targetname" );
    
    foreach ( struct in turret_structs )
    {
        struct thread ob_nm_mode::spawn_turret();
    }
    
    level.nm_respawn_struct = undefined;
    level thread ob_nm_escort::spawn_escort_robot();
    setup_cradle_audio();
    ob_nm_mode::function_1f2648b3b22d9816( 10, "nm_overlord_glich_start" );
    function_a25acb62ddab20e2( "nm_minion_guild", 1 );
    ob_nm_escort::escort_event( "nightmare_la_circle_struct", "la_nm_activity", "nightmare_la_circle_struct", %"hash_3bf31c4ce3a42550" );
    function_a25acb62ddab20e2( "nm_minion_guild", 0 );
    level thread function_33b5d41728f08de7();
    ob_gametype_story_mission::function_b69ee4ccc5e7a2ae( "OB_VIRGO_NM_LA_BOSS" );
    function_98274185e4d63290();
    level utility::flag_set( "flag_bo2_intro_start" );
    level notify( #"hash_23dc72c206f93882" );
    ob_nm_mode::nightmare_prepare();
    main_boss = "sat_juggerbot";
    function_a25acb62ddab20e2( "nm_minion_zombie", 1 );
    level utility::flag_set( "flag_enable_super_sprint" );
    nightmare_rhino_boss_fight( "s_rhino_freeway_boss", main_boss, "la_nm_boss", undefined, %"hash_3bf3234ce3a43135" );
    function_a25acb62ddab20e2( "nm_minion_zombie", 0 );
    level utility::flag_clear( "flag_enable_super_sprint" );
    level utility::flag_clear( "flag_rhino_la_fight" );
    ob_nm_mode::nightmare_teleport( "OB_VIRGO_NM_CARRIER" );
    level utility::kill_exploder( "fx_freeway_crashsite_bc" );
    level utility::kill_exploder( "fx_freeway_crashsite" );
    level utility::kill_exploder( "fx_drone_crash" );
    level utility::kill_exploder( "fx_freeway_intro" );
    level thread ob_nm_mode::function_5dd43e7cb0682d57( "s_rhino_freeway_boss", "OB_VIRGO_NM_CARRIER" );
    level utility::flag_set( "flag_nm_la_complete" );
    activity_instance_common::endactivity( level.activity_instance, 1 );
}

// Namespace ob_nm_la
// Params 0
// Checksum 0xd6582de4, Offset: 0xd13
// Size: 0x10d
function function_33b5d41728f08de7()
{
    level utility::flag_wait( "flag_bo2_intro_start" );
    offset = ( 0, 0, -40 );
    angle = ( -90, 0, 0 );
    tag_origin = utility::function_1808878d1c511ce8( level.escortai.origin + offset );
    blast_fx = playfxontag( level._effect[ "blast_vfx" ], tag_origin, "tag_origin" );
    var_73ba4a5d351f5560 = playfxontag( level._effect[ "laser_spawn_vfx" ], tag_origin, "tag_origin" );
    playrumbleonposition( "heavy_3s", tag_origin.origin );
    level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", 3, undefined, level.players, undefined, undefined, 1 );
    wait 9.5;
    stopfxontag( level._effect[ "laser_spawn_vfx" ], tag_origin, "tag_origin" );
    level utility::flag_set( "flag_bo2_intro_end" );
}

// Namespace ob_nm_la
// Params 0
// Checksum 0x78535b8a, Offset: 0xe28
// Size: 0x1bf
function function_98274185e4d63290()
{
    offset = ( 0, 0, -40 );
    angle = ( -90, 0, 0 );
    nm_escort_beam = utility::getstruct( "nm_escort_beam", "targetname" );
    tag_origin = utility::function_1808878d1c511ce8( level.escortai.origin + offset );
    level thread utility::play_sound_in_space( "evt_rhino_delivered_beam_start", level.escortai.origin );
    var_18a80f3b7e3c0f82 = level.escortai.origin;
    
    if ( isdefined( nm_escort_beam ) )
    {
        var_18a80f3b7e3c0f82 = nm_escort_beam.origin;
    }
    
    level.var_8f0ebba0648d05c0 = utility::play_loopsound_in_space( "evt_rhino_delivered_beam_lp", var_18a80f3b7e3c0f82 );
    blast_fx = playfxontag( level._effect[ "blast_vfx" ], tag_origin, "tag_origin" );
    var_73ba4a5d351f5560 = playfxontag( level._effect[ "laser_spawn_vfx" ], tag_origin, "tag_origin" );
    playrumbleonposition( "heavy_3s", tag_origin.origin );
    level utility::flag_set( "flag_rhino_la_fight" );
    level thread ob_nm_mode::transition_stream( ob_story_mission_utils::get_activity_starts( "OB_VIRGO_NM_LA_BOSS" )[ 0 ].origin );
    level thread utility::exploder( "fx_freeway_intro" );
    wait 4;
    level thread function_6da6e364ec9c2654();
    level utility::flag_wait( "flag_rhino_hack_sequence_done" );
    stopfxontag( level._effect[ "laser_spawn_vfx" ], tag_origin, "tag_origin" );
    level notify( #"hash_88a5c9221727633d" );
    level thread ob_nm_mode::function_5dd43e7cb0682d57( "nm_escort_beam", "OB_VIRGO_NM_LA_BOSS" );
}

// Namespace ob_nm_la
// Params 0
// Checksum 0x47868215, Offset: 0xfef
// Size: 0x383
function function_6da6e364ec9c2654()
{
    foreach ( player in level.players )
    {
        player notify( #"teleport_finished" );
        player val::set( "nightmare_teleport", "allow_movement", 0 );
        player val::set( "nightmare_teleport", "allow_teleport", 0 );
        player val::set( "nightmare_teleport", "allow_gadgets", 0 );
        player utility::delaythread( 3, &val::reset_all, "nightmare_teleport" );
        player giveandfireoffhand( "sat_ob_activity_crash_site_blast_start" );
        stun_duration = 1;
        player thread weapon_utility::cleanupconcussionstun( stun_duration );
        player thread shellshock_utility_cpmp::_shellshock( %"sat_ob_virgo_harper_slam", #"stun", stun_duration, 1, 500 );
        level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", 5, undefined, player, undefined, undefined, 1 );
        player playrumbleonentity( "damage_heavy" );
    }
    
    s_rhino_freeway_boss = utility::getstruct( "s_rhino_freeway_boss", "targetname" );
    anchor_tag = level utility::function_1808878d1c511ce8( level.escortai.origin, level.escortai.angles );
    level.escortai linkto( anchor_tag );
    anchor_tag moveto( s_rhino_freeway_boss.origin, 0.1 );
    anchor_tag rotateto( s_rhino_freeway_boss.angles, 0.1 );
    anchor_tag waittill( #"movedone" );
    level.escortai unlink();
    anchor_tag delete();
    level thread ob_nm_mode::function_b2df4178a4626376();
    
    foreach ( player in level.players )
    {
        player thread hud_util::fade_out( 0.5, "white" );
    }
    
    waitframe();
    coop::teleport_players( level.players, ob_story_mission_utils::get_activity_starts( "OB_VIRGO_NM_LA_BOSS" ) );
    waitframe();
    
    if ( isdefined( level.var_8f0ebba0648d05c0 ) )
    {
        level.var_8f0ebba0648d05c0 stoploopsound( "evt_rhino_delivered_beam_lp" );
        level.var_8f0ebba0648d05c0 delete();
        level.var_8f0ebba0648d05c0 = undefined;
    }
    
    foreach ( player in level.players )
    {
        player thread hud_util::fade_in( 1.5, "white" );
    }
    
    one_shot_origin = level.escortai.origin;
    
    if ( isdefined( s_rhino_freeway_boss ) )
    {
        one_shot_origin = s_rhino_freeway_boss.origin;
    }
    
    level thread utility::play_sound_in_space( "evt_rhino_delivered_beam_start_post_teleport", one_shot_origin );
    level utility::flag_set( "flag_rhino_hack_sequence_done" );
}

// Namespace ob_nm_la
// Params 5
// Checksum 0xba373fd, Offset: 0x137a
// Size: 0x34e
function nightmare_rhino_boss_fight( var_e04c0425c57a325, main_boss, minion_encounter_name, spawn_minions, objective_asset )
{
    ob_nm_mode::start_of_round_fanfare( "nm_overlord_boss_start", "nm_miniboss_start" );
    var_e04c0425c57a325 = utility::getstructarray( var_e04c0425c57a325, "targetname" );
    level utility::flag_clear( "nightmare_encouter_done" );
    level.nm_activity_name = "OB_VIRGO_FREEWAY_INTRO";
    obj = objective_asset ?? %"hash_58ceb76ce380e3be";
    ob_story_mission_utils::objective_text_show( obj );
    time_modifier = ob_nm_mode::function_3fc7f1f10018b737( 360 );
    ob_story_mission_utils::objective_timer_update( time_modifier );
    level thread ob_nm_mode::wave_fail_timer( time_modifier );
    level utility::flag_set( "flag_knockback_blast" );
    waitframe();
    level utility::flag_wait( "flag_bo2_intro_end" );
    setdvar( @"hash_2db5ff8c06e69c1c", 1 );
    team = "team_hundred_ninety";
    spawn_pos = getclosestpointonnavmesh( var_e04c0425c57a325[ 0 ].origin );
    playfx( level._effect[ "enemy_vfx" ], spawn_pos + ( 0, 0, 32 ) );
    level.escortai ob_nm_escort::old_values();
    boss_health = 1.5 + level.players.size * 0.4;
    level.escortai.var_be5ccf6d16f6b59e = 1;
    level.escortai ob_nm_mode::set_boss_health( boss_health );
    level.escortai ob_nm_mode::function_a60cd6315c37bac1();
    level.escortai thread function_ef8376fa8b1b615e();
    level.escortai.team = team;
    level.escortai hudoutlineenable( "outline_nodepth_red" );
    level.escortai.ignoreall = 0;
    level.escortai.ignoreme = 0;
    level.escortai.var_b65c21b6930b6109 = 0;
    level.escortai setcandamage( 1 );
    thread ob_nm_mode::miniboss_objective( level.escortai );
    level utility::flag_set( "nightmare_encouter_active" );
    level.escortai.dontmelee = 0;
    level.escortai setgoalpos( level.escortai.origin, 2048 );
    level.minion_volume = getnoentvolumearray( "escort_robot_fight_vol", #targetname )[ 0 ];
    level.enemy_count_array = [ 3, 6, 9, 12 ];
    level.cadence_override = 1.75;
    thread ob_nm_mode::minion_encounter( minion_encounter_name, "nightmare_encouter_done" );
    level.escortai waittill( #"death" );
    level notify( #"cleanup_minions" );
    level notify( #"hash_aefc5c470125baf8" );
    level utility::flag_clear( "nightmare_encouter_active" );
    level utility::flag_set( "nightmare_encouter_done" );
    level utility::flag_clear( "flag_knockback_blast" );
    level notify( #"stop_circle" );
    level.minion_volume = undefined;
    self.var_9be376218db54aba = undefined;
    ob_nm_mode::end_of_round_fanfare( "nm_overlord_boss_dead" );
}

// Namespace ob_nm_la
// Params 1
// Checksum 0x3a14ce71, Offset: 0x16d0
// Size: 0x9f
function spawn_smoke_vfx( struct )
{
    utility::add_fx( "spawn_smoke", "vfx_sat_equip_smoke" );
    offset = ( 0, 0, 0 );
    tag = utility::function_1808878d1c511ce8( struct.origin + offset, struct.angles );
    playfxontag( level._effect[ "spawn_smoke" ], tag, "tag_origin" );
    wait 5;
    stopfxontag( level._effect[ "spawn_smoke" ], tag, "tag_origin" );
    tag delete();
}

// Namespace ob_nm_la
// Params 0
// Checksum 0x98dc3ee4, Offset: 0x1777
// Size: 0x42
function function_d148906ebe3558fd()
{
    self endon( #"death" );
    thread weapons::watchgrenadeusage();
    
    if ( getdvarint( @"hash_2db5ff8c06e69c1c", 0 ) )
    {
        shock_launcher = ob_nm_escort::function_69961ef34cea929();
        return;
    }
    
    thread ob_nm_escort::function_c62751ce9b00d732();
}

// Namespace ob_nm_la
// Params 0
// Checksum 0xf9b324a0, Offset: 0x17c1
// Size: 0xed
function function_ef8376fa8b1b615e()
{
    self endon( #"death" );
    max_health = self.health;
    
    while ( self.health > max_health * 0.8 )
    {
        waitframe();
    }
    
    /#
        iprintln( "<dev string:x24>" );
    #/
    
    setdvar( @"hash_2db5ff8c06e69c1c", 0 );
    function_1aa6757af3ea23a2();
    thread function_d148906ebe3558fd();
    
    while ( self.health > max_health * 0.5 )
    {
        waitframe();
    }
    
    /#
        iprintln( "<dev string:x32>" );
    #/
    
    setdvar( @"hash_2db5ff8c06e69c1c", 1 );
    function_1aa6757af3ea23a2();
    thread function_d148906ebe3558fd();
    
    while ( self.health > max_health * 0.2 )
    {
        waitframe();
    }
    
    /#
        iprintln( "<dev string:x40>" );
    #/
    
    setdvar( @"hash_2db5ff8c06e69c1c", 0 );
    function_1aa6757af3ea23a2();
    thread function_d148906ebe3558fd();
}

// Namespace ob_nm_la
// Params 1
// Checksum 0xe4f20648, Offset: 0x18b6
// Size: 0x11f
function function_1aa6757af3ea23a2( var_772501ce9a0c24da = 2 )
{
    level notify( #"stop_scripted_shield" );
    self endon( #"death" );
    struct = spawnstruct();
    struct.origin = self.origin;
    struct.angles = self.angles;
    bubble_shield_spawn_pos = struct.origin;
    bubble_shield_model = utility::spawn_model( "eqp_sat_wm_bubble_shield_razor", bubble_shield_spawn_pos, struct.angles );
    bubble_shield_model setscriptablepartstate( #"visibility", #"show" );
    bubble_shield_model setscriptablepartstate( #"active", #"active" );
    childthread utility::delete_on_death( bubble_shield_model );
    level.activity_instance thread ob_nm_mode::bubble_shield( bubble_shield_model, level.escortai );
    struct thread scene::play( self, "enter", "scene_sat_nm_rhino_stunned" );
    wait var_772501ce9a0c24da;
    struct scene::play( self, "exit", "scene_sat_nm_rhino_stunned" );
}

