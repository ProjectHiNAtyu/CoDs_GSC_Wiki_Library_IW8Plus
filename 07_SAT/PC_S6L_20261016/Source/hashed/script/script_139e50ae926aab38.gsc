// script_139e50ae926aab38  (hash_139e50ae926aab38.gscc) (size: 18273 Bytes / 0x4761 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x98bc6f32 (2562486066)
// size ...... 18273 (0x4761)
// includes .. 20  (offset: 0x41f9)
// strings ... 78  (offset: 0x4299)
// dev strs .. 0   (offset: 0x4761)
// exports ... 37  (offset: 0x2c11)
// cseg ...... 0x793 + 0x247e (0x2c11)
// imports ... 128 (offset: 0x31d9)
// animtree1 . 0   (offset: 0x4761)
// animtree2 . 0   (offset: 0x4761)
#using script_2399696a9d953451;
#using script_34b50456e3922412;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\aitypes\shared\zombie\zombie_damage;
#using scripts\common\math;
#using scripts\common\scriptable;
#using scripts\common\snd\snd;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\damagefeedback;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_util;
#using scripts\mp\mp_agent;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\ob\systems\ob_item_select;
#using scripts\mp\supers;

#namespace namespace_e35ae275c4ce8724;

/#

    // Namespace namespace_e35ae275c4ce8724
    // Params 0
    // Checksum 0xf7887a, Offset: 0x7b1
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_e35ae275c4ce8724
// Params 0, eflags: 0x5
// Checksum 0xbe2ddd8a, Offset: 0x7be
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_28c84e1fcdd77521", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_e35ae275c4ce8724
// Params 0, eflags: 0x4
// Checksum 0xd3a39f68, Offset: 0x7e7
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LIBRA_NM_2";
    activity_common::registeractivitytype( "OB_LIBRA_NM_2", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_NM_2", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_NM_2", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_NM_2", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_LIBRA_NM_2" );
}

// Namespace namespace_e35ae275c4ce8724
// Params 0
// Checksum 0x9219776a, Offset: 0x85e
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

// Namespace namespace_e35ae275c4ce8724
// Params 0
// Checksum 0xe0520f5f, Offset: 0x8c3
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

// Namespace namespace_e35ae275c4ce8724
// Params 0
// Checksum 0xcac60dfb, Offset: 0x92a
// Size: 0x23
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    function_a44b4ab217df84f2();
}

// Namespace namespace_e35ae275c4ce8724
// Params 1
// Checksum 0xb258200d, Offset: 0x955
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

    // Namespace namespace_e35ae275c4ce8724
    // Params 0
    // Checksum 0x474d2c6a, Offset: 0x9fc
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_e35ae275c4ce8724
// Params 1
// Checksum 0x1d1551fe, Offset: 0xa09
// Size: 0x30
function player_setup( player )
{
    if ( isdefined( level.var_95fd020b64b6c1cc ) )
    {
        player ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_nm_core", level.var_95fd020b64b6c1cc );
    }
}

// Namespace namespace_e35ae275c4ce8724
// Params 0
// Checksum 0x7187b985, Offset: 0xa41
// Size: 0x2
function nightmare_start()
{
    
}

// Namespace namespace_e35ae275c4ce8724
// Params 0
// Checksum 0x8472c6f, Offset: 0xa4b
// Size: 0x202
function nightmare_main()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.var_bd2748e149a8024b = self;
    level.nm_activity_instance = self;
    level.nm_activity_name = "OB_LIBRA_NM_2";
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "struct_nm_hela_medkit", "flag_libra_nm_2_complete", 1 );
    struct = utility::getstruct( "struct_nm_2_crate", "targetname" );
    
    if ( struct )
    {
        ob_item_select::function_95f9ecc2af4693f6( struct.origin, "super_mega_jump", "super_grappling_hook", #"tactical" );
    }
    
    level thread cleanup_campaign();
    scriptable::scriptable_adddamagedcallback( &projectile_damage_callback );
    level._effect[ "enemy_vfx" ] = loadfxasset( "vfx_sat_wc_ai_cradle_spawn_burst_med_01" );
    level._effect[ "mars_projectile_explosion" ] = loadfxasset( "vfx_sat_mp_ob_ari_boss_orb_impact_1" );
    level._effect[ "laser_spawn_vfx" ] = loadfxasset( "vfx_sat_levels_wc_cradle_site_laser" );
    level._effect[ "blast_vfx" ] = loadfxasset( "vfx_sat_levels_wc_cradle_site_clean_blast" );
    thread mp_sat_ob_libra_util::function_3404036aa1432445( "proc_pump_room_door" );
    core_struct = utility::getstruct( "struct_nm_core", "targetname" );
    
    if ( isdefined( core_struct ) )
    {
        level.nm_core = spawnscriptable( "sat_ob_scorpio_interior_core", core_struct.origin, core_struct.angles );
    }
    
    shield_struct = utility::getstruct( "struct_nm_shield", "targetname" );
    
    if ( isdefined( shield_struct ) )
    {
        level.nm_shield = spawnscriptable( "sat_ob_scorpio_interior_core_shield", shield_struct.origin, shield_struct.angles );
    }
    
    ob_nm_mode::function_1f2648b3b22d9816( undefined, "nm_overlord_glich_start" );
    function_514736d36bc0c378();
    level utility::flag_set( "flag_libra_nm_2_complete" );
    ob_nm_mode::nightmare_teleport( "OB_LIBRA_NM_3" );
    level thread ob_nm_mode::function_5dd43e7cb0682d57( "struct_libra_nm_2", "OB_LIBRA_NM_3" );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_e35ae275c4ce8724
// Params 0
// Checksum 0x8f80dcd0, Offset: 0xc55
// Size: 0x4e
function cleanup_campaign()
{
    sphere_clip = getent( "biosphere_clip", "targetname" );
    
    if ( isdefined( sphere_clip ) )
    {
        sphere_clip delete();
    }
    
    cradle_sphere = getent( "cradle_sphere", "targetname" );
    
    if ( isdefined( cradle_sphere ) )
    {
        cradle_sphere delete();
    }
}

// Namespace namespace_e35ae275c4ce8724
// Params 0
// Checksum 0xc5542ae9, Offset: 0xcab
// Size: 0x33d
function function_514736d36bc0c378()
{
    level utility::flag_set( "flag_multi_capture_event" );
    self.var_9be376218db54aba = "sat_ob_objectivemarker_nm_big_boss";
    ob_story_mission_utils::objective_text_show( %"hash_5d3b92682f639bf8" );
    level.hell_start_time = gettime();
    level.boss_total_time = 660;
    ob_story_mission_utils::objective_timer_update( level.boss_total_time );
    level thread ob_nm_mode::wave_fail_timer( level.boss_total_time );
    level.capture_scalar = 5;
    thread setup_hell_healthbar();
    level._effect[ "harper_slam" ] = loadfxasset( "vfx_sat_wc_vgo_boss_hand_aoe_ring_01" );
    scriptable::scriptable_adddamagedcallback( &core_damage_callback );
    a_structs = utility::getstructarray( "struct_nm_2_capture_point", "targetname" );
    a_structs = arrayrandomize( a_structs );
    function_a25acb62ddab20e2( "nm_minion_zombie", 1 );
    level.enemy_count_array = [ 6, 10, 14, 18 ];
    level.nm_activity_instance thread ob_nm_mode::minion_encounter( "encounter_nm_2_boss", "flag_hell_dead" );
    i = 0;
    
    while ( !level utility::flag( "flag_hell_dead" ) )
    {
        ob_nm_mode::function_70467d6be224da52( "nm_overlord_capture_next" );
        ob_nm_mode::nightmare_splash( "nm_capture_boss" );
        struct = a_structs[ i % a_structs.size ];
        capture_struct = ob_nm_mode::function_b484cb1cc50eab74( struct, "nightmare_capture_zone_" + i );
        level.nm_activity_instance mission_ui::function_d84701041f6f95c2( 1, 0, 100 );
        ob_nm_mode::capture_zone_segment( capture_struct, "flag_capture_complete" + i, 1, 128 );
        level.nm_activity_instance mission_ui::function_d84701041f6f95c2( 1, 100, 100 );
        ob_nm_mode::nightmare_splash( "nm_boss_capture_end" );
        i++;
        function_6ded83735402c634();
        level thread function_621c41cc93b0e1a5( a_structs[ i % a_structs.size ] );
    }
    
    level.nm_activity_instance ob_story_mission_utils::objective_marker_clear( level.hell_obj_id );
    struct = utility::getstruct( "struct_nm_shield", "targetname" );
    playfx( level._effect[ "blast_vfx" ], struct.origin + ( 0, 0, -155 ) );
    function_a44b4ab217df84f2();
    level.nm_core setscriptablepartstate( "health", "inactive" );
    level.nm_core setscriptablepartstate( "base", "destroyed" );
    
    foreach ( player in level.players )
    {
        player ob_story_mission_utils::function_5a707116af438c92();
    }
    
    wait 2;
    function_a25acb62ddab20e2( "nm_minion_zombie", 0 );
    level utility::flag_clear( "flag_enable_super_sprint" );
    level utility::flag_clear( "flag_multi_capture_event" );
    level notify( #"hash_aefc5c470125baf8" );
    level notify( #"cleanup_minions" );
    level utility::flag_set( "flag_capture_zone_event_complete" );
    level utility::flag_clear( "nightmare_encouter_active" );
    ob_nm_mode::end_of_round_fanfare( undefined, "nm_boss_end" );
}

// Namespace namespace_e35ae275c4ce8724
// Params 0
// Checksum 0x7a0115ce, Offset: 0xff0
// Size: 0x1a5
function function_6ded83735402c634()
{
    level.nm_shield setscriptablepartstate( "model", "hidden" );
    level.nm_shield setscriptablepartstate( "health", "inactive" );
    level.nm_core setscriptablepartstate( "health", "damageable" );
    level utility::flag_set( "flag_core_exposed" );
    level.var_95fd020b64b6c1cc.immune = 0;
    level.nm_activity_instance ob_story_mission_utils::objective_text_show( %"hash_f401e4226f3484a" );
    current_time = gettime();
    duration = abs( current_time - level.hell_start_time );
    var_31688a0f3073df86 = int( duration / 1000 );
    time_remaining = abs( level.boss_total_time - var_31688a0f3073df86 );
    level.nm_activity_instance ob_story_mission_utils::objective_timer_update( time_remaining );
    update_healthbar();
    struct = utility::getstruct( "struct_nm_shield", "targetname" );
    tag = utility::function_1808878d1c511ce8( struct.origin + ( 0, 0, -155 ) );
    tag.angles = ( 180, 0, 0 );
    playfxontag( level._effect[ "laser_spawn_vfx" ], tag, "tag_origin" );
    function_396c7780a726a0ea();
    level thread core_attack();
    healthbar_wait();
    stopfxontag( level._effect[ "laser_spawn_vfx" ], tag, "tag_origin" );
    tag delete();
}

// Namespace namespace_e35ae275c4ce8724
// Params 1
// Checksum 0x470aea14, Offset: 0x119d
// Size: 0xa8
function function_621c41cc93b0e1a5( struct )
{
    if ( !isdefined( level.extra_ai ) )
    {
        spawners = [ "sat_ob_enemy_cradle_hvt_jugg_minigun", "sat_ob_enemy_cradle_hvt_jugg_minigun", "sat_ob_enemy_cradle_hvt_jugg_minigun" ];
        level.extra_ai = mp_agent::spawnnewagentaitype( utility::array_random( spawners ), struct.origin, struct.angles, "team_two_hundred" );
        level.extra_ai thread ob_nm_mode::individual_vanish( "flag_capture_zone_event_complete" );
        level.extra_ai waittill( #"death" );
        level.extra_ai = undefined;
    }
}

// Namespace namespace_e35ae275c4ce8724
// Params 1
// Checksum 0x2a497340, Offset: 0x124d
// Size: 0x26, Type: bool
function active_camo_is_active( player )
{
    return player supers_mp::getcurrentsuperref() == "super_active_camo" && player supers_mp::issuperinuse();
}

// Namespace namespace_e35ae275c4ce8724
// Params 0
// Checksum 0x3c308452, Offset: 0x127c
// Size: 0x61
function function_396c7780a726a0ea()
{
    if ( isdefined( level.var_557acd48313b93fb ) )
    {
        return;
    }
    
    shield_struct = utility::getstruct( "struct_nm_shield", "targetname" );
    
    if ( !isdefined( shield_struct ) )
    {
        return;
    }
    
    level.var_557acd48313b93fb = snd::play( "evt_libra_nm2_core_beam_lp", shield_struct.origin + ( 0, 0, -155 ) );
}

// Namespace namespace_e35ae275c4ce8724
// Params 0
// Checksum 0x7048c9d5, Offset: 0x12e5
// Size: 0x30
function function_a44b4ab217df84f2()
{
    if ( !isdefined( level.var_557acd48313b93fb ) )
    {
        return;
    }
    
    snd::stop( level.var_557acd48313b93fb, 0.15 );
    level.var_557acd48313b93fb = undefined;
}

// Namespace namespace_e35ae275c4ce8724
// Params 0
// Checksum 0xaf7812f1, Offset: 0x131d
// Size: 0x45
function core_attack()
{
    level endon( #"hash_b089fe689ede5086" );
    wait 5;
    
    while ( level utility::flag( "flag_core_exposed" ) )
    {
        drop = randomfloatrange( -256, -64 );
        level thread function_ef395567dfcad1d( drop );
        wait 5;
    }
}

// Namespace namespace_e35ae275c4ce8724
// Params 0
// Checksum 0x8f099246, Offset: 0x136a
// Size: 0x184
function healthbar_wait()
{
    level endon( #"hell_destroyed" );
    shield_struct = utility::getstruct( "struct_nm_shield", "targetname" );
    level.hell_obj_id = level.nm_activity_instance ob_story_mission_utils::function_b9cb179f9577f32a( shield_struct.origin );
    wait 40;
    level.var_95fd020b64b6c1cc.immune = 1;
    struct = utility::getstruct( "struct_core_blast", "targetname" );
    level thread ob_nm_mode::function_fa2a4a74d04185e( struct.origin );
    update_healthbar();
    level.nm_activity_instance ob_story_mission_utils::objective_marker_clear( level.hell_obj_id );
    level utility::flag_clear( "flag_core_exposed" );
    level notify( #"hash_b089fe689ede5086" );
    function_a44b4ab217df84f2();
    level.nm_shield setscriptablepartstate( "model", "visible" );
    level.nm_shield setscriptablepartstate( "health", "damageable" );
    level.nm_activity_instance ob_story_mission_utils::objective_text_show( %"hash_5d3b92682f639bf8" );
    current_time = gettime();
    duration = abs( current_time - level.hell_start_time );
    var_31688a0f3073df86 = int( duration / 1000 );
    time_remaining = abs( level.boss_total_time - var_31688a0f3073df86 );
    level.nm_activity_instance ob_story_mission_utils::objective_timer_update( time_remaining );
}

// Namespace namespace_e35ae275c4ce8724
// Params 11
// Checksum 0x53c7f990, Offset: 0x14f6
// Size: 0x23b
function core_damage_callback( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( !isplayer( eattacker ) )
    {
        return;
    }
    
    if ( instance.type != "sat_ob_scorpio_interior_core" )
    {
        return;
    }
    
    if ( !level utility::flag( "flag_core_exposed" ) )
    {
        return;
    }
    
    inflictor = einflictor;
    damage = idamage;
    dmgstruct = zombie_damage::build_damage_struct( inflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, undefined, undefined, undefined, undefined, objweapon );
    damage = zombie_damage::function_881dfa87252ee0ea( dmgstruct );
    shield_struct = utility::getstruct( "struct_nm_shield", "targetname" );
    
    if ( isdefined( objweapon.basename ) )
    {
        switch ( objweapon.basename )
        {
            case #"hash_c36e3b989848ebc9":
                damage = 0;
                break;
            case #"hash_12d387fd04678fe8":
                damage *= 0.5;
                break;
            default:
                break;
        }
    }
    
    if ( damage > 0 )
    {
        numbersorigin = shield_struct.origin;
        mp_agent_damage::function_eb8ba16055d6da7c( eattacker, self, "undefined", smeansofdeath, objweapon, damage, numbersorigin, 0, undefined, 0, 0 );
    }
    
    core = instance;
    
    if ( level.var_95fd020b64b6c1cc.immune )
    {
        return;
    }
    
    level.var_95fd020b64b6c1cc.health -= damage;
    
    if ( level.var_95fd020b64b6c1cc.health <= 0 )
    {
        level utility::flag_set( "flag_hell_dead" );
        level notify( #"hell_destroyed" );
    }
    
    update_healthbar();
    eattacker damagefeedback::updatehitmarker( "standard", 0, 0, 1 );
    eattacker utility::callsharedfunc( #"hud", #"hash_84d4f784de00c6af", 0, self );
}

// Namespace namespace_e35ae275c4ce8724
// Params 0
// Checksum 0x4a24146d, Offset: 0x1739
// Size: 0x129
function setup_hell_healthbar()
{
    activity_instance = self;
    health_struct = spawnstruct();
    health_struct.maxhealth = 600000;
    
    if ( level.players.size )
    {
        health_struct.maxhealth = 600000 * level.players.size;
    }
    
    health_struct.health = health_struct.maxhealth;
    health_struct.immune = 1;
    level.var_95fd020b64b6c1cc = health_struct;
    level.var_95fd020b64b6c1cc.immune = 1;
    
    foreach ( player in level.players )
    {
        player ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_nm_core", level.var_95fd020b64b6c1cc );
    }
    
    update_healthbar();
}

// Namespace namespace_e35ae275c4ce8724
// Params 0
// Checksum 0x20e9aa62, Offset: 0x186a
// Size: 0x7b
function update_healthbar()
{
    foreach ( player in level.players )
    {
        thread function_a3efcbd47b8ad257( player );
    }
}

// Namespace namespace_e35ae275c4ce8724
// Params 1, eflags: 0x4
// Checksum 0x7372dfcf, Offset: 0x18ed
// Size: 0x97
function private function_a3efcbd47b8ad257( player )
{
    if ( !level.var_95fd020b64b6c1cc )
    {
        return;
    }
    
    player endon( #"disconnect" );
    
    if ( player.var_71c37977095602df == "ob_boss_nm_core" )
    {
        if ( level.var_95fd020b64b6c1cc.immune )
        {
            player ob_story_mission_utils::player_boss_healthbar_immune();
        }
        else
        {
            player thread ob_story_mission_utils::player_boss_healthbar_show();
        }
        
        player ob_story_mission_utils::function_e231206f1628d4c6( 1, level.var_95fd020b64b6c1cc.health, level.var_95fd020b64b6c1cc.max_health );
    }
}

// Namespace namespace_e35ae275c4ce8724
// Params 2
// Checksum 0xc8460114, Offset: 0x198c
// Size: 0x1b5
function homing_projectile_handler( homing_projectile, target_player )
{
    a_structs = utility::getstructarray( "struct_nm_hell_shoot", "targetname" );
    
    if ( !isdefined( a_structs ) )
    {
        return;
    }
    
    struct = utility::array_random( a_structs );
    var_8fa1597c801fa4e5 = struct.origin;
    var_6c781c970ee7be3b = struct.angles;
    homing_projectile = spawn( "script_model", var_8fa1597c801fa4e5 );
    homing_projectile.angles = var_6c781c970ee7be3b;
    homing_projectile setmodel( "c_sat_aries_mars_boss_projectile" );
    homing_projectile setcandamage( 1 );
    homing_projectile hudoutlineenable( "outline_nodepth_red" );
    homing_projectile.health = 200;
    
    if ( !isdefined( self.ignore_list ) )
    {
        self.ignore_list = [];
    }
    
    self.ignore_list = function_5713d46873b29625( self.ignore_list );
    self.ignore_list[ self.ignore_list.size ] = homing_projectile;
    target_direction = vectortoangles( target_player.origin - homing_projectile.origin );
    homing_projectile setcandamage( 1 );
    homing_projectile.lifetime = 0;
    homing_projectile.movement_speed = 25;
    homing_projectile.turning_factor = 0.6;
    homing_projectile thread function_6294533bbd09c059( self );
    homing_projectile thread function_c2f9ad91613083af( target_player, var_6c781c970ee7be3b );
    homing_projectile utility::waittill_any_in_array_or_timeout( [ "destroyed", "death" ], 30 );
    playfx( level._effect[ "mars_projectile_explosion" ], homing_projectile.origin );
    homing_projectile delete();
}

// Namespace namespace_e35ae275c4ce8724
// Params 1
// Checksum 0x8df216e7, Offset: 0x1b49
// Size: 0x147
function function_6294533bbd09c059( mars )
{
    self endon( #"death" );
    wait 0.5;
    var_62ddc858cee09ea = physics_createcontents( [ "physicscontents_playerclip", "physicscontents_clipshot", "physicscontents_characterproxy" ] );
    var_fca64e6d43316fe8 = physics_createcontents( [ "physicscontents_characterproxy" ] );
    
    while ( true )
    {
        sphere_start_point = self.origin;
        sphere_end_point = sphere_start_point + anglestoforward( self.angles ) * 50;
        var_cf5ef9b4d334b298 = physics_spherecast( sphere_start_point, sphere_end_point, 15, var_62ddc858cee09ea, mars.ignore_list, "physicsquery_any" );
        var_140728395f8b50ce = physics_spherecast( sphere_start_point, sphere_end_point, 35, var_fca64e6d43316fe8, mars.ignore_list, "physicsquery_any" );
        
        if ( var_cf5ef9b4d334b298 || var_140728395f8b50ce )
        {
            if ( var_cf5ef9b4d334b298 )
            {
                snd::play( "evt_libra_nm2_core_orb_homing_impt", self.origin );
            }
            else
            {
                snd::play( "evt_libra_nm2_core_orb_homing_plr_impt", self.origin );
            }
            
            function_56b2a28ef5d790( mars, mars.ignore_list );
            self notify( #"destroyed" );
        }
        
        wait 0.1;
    }
}

// Namespace namespace_e35ae275c4ce8724
// Params 2
// Checksum 0xc1af8cc8, Offset: 0x1c98
// Size: 0x5d5
function function_c2f9ad91613083af( target_player, var_6c781c970ee7be3b )
{
    self endon( #"death" );
    self endon( #"destroyed" );
    self endon( #"entity_deleted" );
    
    if ( !isdefined( target_player ) )
    {
        self notify( #"destroyed" );
        return;
    }
    
    var_d722011cf54d3d5b = self.origin;
    last_player_position = target_player geteye() - ( 0, 0, 25 );
    self.var_ea82abf596b826f8 = self.angles;
    forward = anglestoforward( var_6c781c970ee7be3b ) * randomfloatrange( self.movement_speed * 0.5, self.movement_speed * 1.5 );
    right = anglestoright( var_6c781c970ee7be3b ) * randomfloatrange( self.movement_speed * 0.75, self.movement_speed * 2.5 ) * ( randomint( 2 ) * 2 - 1 );
    up = anglestoup( var_6c781c970ee7be3b ) * randomfloatrange( self.movement_speed * 0.5, self.movement_speed * 1.5 ) * ( randomint( 2 ) * 2 - 1 );
    setup_end_position = self.origin + anglestoforward( var_6c781c970ee7be3b ) * self.movement_speed;
    
    /#
    #/
    
    setup_end_position = setup_end_position + forward + right + up;
    var_e77ffdbc91796c3e = 0;
    
    /#
    #/
    
    while ( self.lifetime < 1.3 )
    {
        if ( distancesquared( self.origin, setup_end_position ) < squared( 50 ) )
        {
            var_e77ffdbc91796c3e = 1;
        }
        
        if ( !var_e77ffdbc91796c3e )
        {
            var_267d01d2be2d145 = get_projectile_velocity( setup_end_position, self.turning_factor );
        }
        else
        {
            var_267d01d2be2d145 = anglestoforward( self.var_ea82abf596b826f8 ) * self.movement_speed;
        }
        
        new_pos = self.origin + var_267d01d2be2d145;
        new_angles = vectortoangles( new_pos - self.origin );
        
        /#
        #/
        
        self moveto( new_pos, 0.1 );
        self rotateto( new_angles, 0.1 );
        wait 0.1;
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        self.lifetime += 0.1;
        self.var_ea82abf596b826f8 = vectortoangles( self.origin - var_d722011cf54d3d5b );
        var_d722011cf54d3d5b = self.origin;
        distance_to_point = distancesquared( self.origin, setup_end_position );
        
        if ( self.lifetime >= 0.52 && self.movement_speed > 15 )
        {
            self.movement_speed *= 0.65;
        }
        
        if ( self.lifetime >= 0.91 )
        {
            self setscriptablepartstate( "vfx", "active" );
        }
    }
    
    turn_time = self.lifetime + 0.5;
    self.turning_factor = 0.1;
    
    while ( self.lifetime < turn_time )
    {
        var_267d01d2be2d145 = anglestoforward( self.var_ea82abf596b826f8 ) * self.movement_speed * 0.5;
        new_pos = self.origin + var_267d01d2be2d145;
        new_angles = lerp_angles( last_player_position, self.turning_factor );
        self moveto( new_pos, 0.1 );
        self rotateto( new_angles, 0.1 );
        wait 0.1;
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        self.lifetime += 0.1;
        self.var_ea82abf596b826f8 = vectortoangles( self.origin - var_d722011cf54d3d5b );
        var_d722011cf54d3d5b = self.origin;
        
        if ( player::isaliveandnotinlaststand( target_player ) )
        {
            if ( !isdefined( target_player ) )
            {
                self notify( #"destroyed" );
                return;
            }
            
            last_player_position = target_player geteye() - ( 0, 0, 25 );
        }
        
        if ( self.turning_factor < 0.6 )
        {
            self.turning_factor += 0.2;
        }
    }
    
    self.turning_factor = 0.6;
    acceleration_increment = 7;
    acceleration_intervals = 3;
    var_70ad3d2b67564946 = 4;
    acceleration_count = 0;
    
    while ( true )
    {
        if ( acceleration_count < acceleration_intervals )
        {
            self.movement_speed += acceleration_increment;
            acceleration_increment += 10;
            acceleration_count++;
        }
        
        var_267d01d2be2d145 = get_projectile_velocity( last_player_position, self.turning_factor );
        new_pos = self.origin + var_267d01d2be2d145;
        new_angles = vectortoangles( new_pos - self.origin );
        self moveto( new_pos, 0.1 );
        self rotateto( new_angles, 0.1 );
        wait 0.1;
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        self.lifetime += 0.1;
        self.var_ea82abf596b826f8 = vectortoangles( self.origin - var_d722011cf54d3d5b );
        var_d722011cf54d3d5b = self.origin;
        
        if ( player::isaliveandnotinlaststand( target_player ) )
        {
            if ( !isdefined( target_player ) )
            {
                self notify( #"destroyed" );
                return;
            }
            
            last_player_position = target_player geteye() - ( 0, 0, 25 );
        }
        
        self.movement_speed += 2;
        
        if ( var_70ad3d2b67564946 > 0 )
        {
            self.turning_factor += 0.05;
            var_70ad3d2b67564946--;
            continue;
        }
        
        if ( self.turning_factor > 0.15 )
        {
            self.turning_factor -= 0.05;
        }
    }
}

// Namespace namespace_e35ae275c4ce8724
// Params 2
// Checksum 0x82624cbf, Offset: 0x2275
// Size: 0xc3
function function_56b2a28ef5d790( mars, ignore_list )
{
    var_6f69c2de53a9549a = getentarrayinradius( undefined, undefined, self.origin, 200 );
    damage = 30;
    
    /#
    #/
    
    foreach ( blasted_entity in var_6f69c2de53a9549a )
    {
        if ( isplayer( blasted_entity ) )
        {
            blasted_entity ob_nm_mode::function_ce258bccf32cf64b( self.origin );
        }
    }
}

// Namespace namespace_e35ae275c4ce8724
// Params 11
// Checksum 0x5f27f5e, Offset: 0x2340
// Size: 0x142
function projectile_damage_callback( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != "aries_boss_homing_projectile" || instance.destroyed )
    {
        return;
    }
    
    if ( isplayer( eattacker ) )
    {
        eattacker damagefeedback::updatehitmarker( "standard", self.health == 0, 0, 1 );
    }
    else if ( isplayer( eattacker.owner ) )
    {
        eattacker.owner damagefeedback::updatehitmarker( "standard", self.health == 0, 0, 1 );
    }
    
    if ( instance.entity.health <= 0 )
    {
        instance.entity notify( #"destroyed" );
        snd::play( "evt_libra_nm2_core_orb_homing_impt", instance.entity );
        return;
    }
    
    instance setscriptablepartstate( "health", "damageable" );
}

// Namespace namespace_e35ae275c4ce8724
// Params 2
// Checksum 0x26225369, Offset: 0x248a
// Size: 0x11b
function get_projectile_velocity( target_pos, var_60ab41322253e19f )
{
    current_angles = self.var_ea82abf596b826f8;
    projectile_forward = anglestoforward( current_angles );
    normal = vectornormalize( target_pos - self.origin );
    dot = vectordot( projectile_forward, normal );
    
    if ( dot > 0 || self.lifetime < 3 )
    {
        target_angles = calculate_target_angles( target_pos );
        move_angles_x = math::angle_lerp( current_angles[ 0 ], target_angles[ 0 ], var_60ab41322253e19f );
        move_angles_y = math::angle_lerp( current_angles[ 1 ], target_angles[ 1 ], var_60ab41322253e19f );
        move_angles_z = math::angle_lerp( current_angles[ 2 ], target_angles[ 2 ], var_60ab41322253e19f );
        var_562085c3a13bb970 = ( move_angles_x, move_angles_y, move_angles_z );
        forward_dir = anglestoforward( var_562085c3a13bb970 );
    }
    else
    {
        forward_dir = anglestoforward( self.angles );
    }
    
    return vectornormalize( forward_dir ) * self.movement_speed;
}

// Namespace namespace_e35ae275c4ce8724
// Params 1, eflags: 0x4
// Checksum 0x89b0ac7b, Offset: 0x25ae
// Size: 0x2a
function private calculate_target_angles( target_pos )
{
    target_angles = vectortoangles( target_pos - self.origin );
    return target_angles;
}

// Namespace namespace_e35ae275c4ce8724
// Params 2, eflags: 0x4
// Checksum 0x77136ff2, Offset: 0x25e1
// Size: 0x8d
function private lerp_angles( target_pos, var_60ab41322253e19f )
{
    current_angles = self.var_ea82abf596b826f8;
    target_angles = calculate_target_angles( target_pos );
    move_angles_x = math::angle_lerp( current_angles[ 0 ], target_angles[ 0 ], var_60ab41322253e19f );
    move_angles_y = math::angle_lerp( current_angles[ 1 ], target_angles[ 1 ], var_60ab41322253e19f );
    move_angles_z = math::angle_lerp( current_angles[ 2 ], target_angles[ 2 ], var_60ab41322253e19f );
    return ( move_angles_x, move_angles_y, move_angles_z );
}

// Namespace namespace_e35ae275c4ce8724
// Params 14
// Checksum 0xfd9df608, Offset: 0x2677
// Size: 0x105
function function_786772134de85587( einflictor, attacker, idamage, idflags, damagetype, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage )
{
    inflictor = einflictor;
    damage = idamage;
    dmgstruct = zombie_damage::build_damage_struct( inflictor, attacker, damage, idflags, damagetype, objweapon, vpoint, vdir, undefined, undefined, undefined, undefined, objweapon );
    damage = zombie_damage::function_881dfa87252ee0ea( dmgstruct );
    
    if ( damage > 0 )
    {
        numbersorigin = self.origin + ( 0, 0, 180 );
        mp_agent_damage::function_eb8ba16055d6da7c( attacker, self, shitloc, damagetype, sweapon, damage, numbersorigin, 0, undefined, 0, 0 );
    }
    
    return damage;
}

// Namespace namespace_e35ae275c4ce8724
// Params 1
// Checksum 0x6fca72b7, Offset: 0x2785
// Size: 0x24c
function function_ef395567dfcad1d( z_down = -256 )
{
    level endon( #"hash_b089fe689ede5086" );
    radius = 256;
    var_bbf0fa162edd3ce6 = 60;
    segment_degrees = 360 / var_bbf0fa162edd3ce6;
    offset = ( 0, 0, z_down );
    struct = utility::getstruct( "struct_nm_shield", "targetname" );
    
    if ( !level utility::flag( "flag_core_exposed" ) )
    {
        return;
    }
    
    if ( level utility::flag( "flag_hell_dead" ) )
    {
        return;
    }
    
    for ( i = 0; i < var_bbf0fa162edd3ce6 ; i++ )
    {
        snd::play( "evt_libra_nm2_core_projectile_launch", struct.origin );
        x = 64 * cos( 0.5 * segment_degrees * i );
        wavy_offset = offset + ( 0, 0, x );
        local_offset = anglestoforward( ( 0, segment_degrees * i, 0 ) ) * radius;
        var_629371fa3f22523f = coordtransform( local_offset, struct.origin, ( 0, 0, 0 ) );
        missile_angles = vectortoangles( var_629371fa3f22523f - struct.origin );
        missile_end = coordtransform( local_offset, var_629371fa3f22523f, ( 0, 0, 0 ) );
        shooter = getaiarray( "team_two_hundred" )[ 0 ];
        
        if ( !isdefined( shooter ) )
        {
            shooter = level.players[ 0 ];
        }
        
        if ( level utility::flag( "flag_core_exposed" ) )
        {
            missile = magicbullet( "sat_la_ztron_fireball_virgo_nm", var_629371fa3f22523f + ( 0, 0, -96 ), missile_end + wavy_offset, shooter );
            level.nm_core thread function_a2503dbe6dd43e49( missile_end + wavy_offset );
        }
        
        waitframe();
    }
    
    if ( !level utility::flag( "flag_core_exposed" ) )
    {
        return;
    }
    
    if ( level utility::flag( "flag_hell_dead" ) )
    {
        return;
    }
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( level utility::flag( "flag_core_exposed" ) )
        {
            level.nm_core thread homing_projectile_handler( undefined, level.players[ i ] );
        }
        
        wait 0.2;
    }
}

// Namespace namespace_e35ae275c4ce8724
// Params 1
// Checksum 0xb9c4c3d7, Offset: 0x29d9
// Size: 0x2c
function function_a2503dbe6dd43e49( var_1b09367d2088bed7 )
{
    level endon( #"hash_b089fe689ede5086" );
    wait 0.12;
    snd::play( "evt_libra_nm2_core_orb_impt", var_1b09367d2088bed7 );
}

// Namespace namespace_e35ae275c4ce8724
// Params 1
// Checksum 0x34a2061c, Offset: 0x2a0d
// Size: 0x204
function function_51cfe6cb912064b1( z_down = -256 )
{
    radius = 256;
    var_bbf0fa162edd3ce6 = 18;
    segment_degrees = 360 / var_bbf0fa162edd3ce6;
    offset = ( 0, 0, z_down );
    struct = utility::getstruct( "struct_nm_shield", "targetname" );
    
    if ( level utility::flag( "flag_hell_dead" ) )
    {
        return;
    }
    
    for ( i = 0; i < var_bbf0fa162edd3ce6 ; i++ )
    {
        local_offset = anglestoforward( ( 0, segment_degrees * i, 0 ) ) * radius;
        var_629371fa3f22523f = coordtransform( local_offset, struct.origin, ( 0, 0, 0 ) );
        missile_angles = vectortoangles( var_629371fa3f22523f - struct.origin );
        missile_end = coordtransform( local_offset, var_629371fa3f22523f, ( 0, 0, 0 ) );
        missile = magicbullet( "sat_la_ztron_fireball_virgo_nm", var_629371fa3f22523f, missile_end + offset, level.players[ 0 ] );
        level.nm_core thread function_a2503dbe6dd43e49( missile_end + offset );
        wait 0.05;
    }
    
    if ( level utility::flag( "flag_hell_dead" ) )
    {
        return;
    }
    
    offset = ( 0, 0, z_down / 2 );
    
    for ( i = 0; i < var_bbf0fa162edd3ce6 ; i++ )
    {
        local_offset = anglestoforward( ( 0, segment_degrees * i, 0 ) ) * radius;
        var_629371fa3f22523f = coordtransform( local_offset, struct.origin, ( 0, 0, 0 ) );
        missile_angles = vectortoangles( var_629371fa3f22523f - struct.origin );
        missile_end = coordtransform( local_offset, var_629371fa3f22523f, ( 0, 0, 0 ) );
        missile = magicbullet( "sat_la_ztron_fireball_virgo_nm", var_629371fa3f22523f, missile_end + offset, level.players[ 0 ] );
        level.nm_core thread function_a2503dbe6dd43e49( missile_end + offset );
        wait 0.05;
    }
}

