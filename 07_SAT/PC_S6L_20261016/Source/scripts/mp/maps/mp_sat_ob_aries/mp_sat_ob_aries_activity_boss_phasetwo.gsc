// scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_activity_boss_phasetwo.gsc  (hash_0a6530b304f58e07.gscc) (size: 8596 Bytes / 0x2194 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x57c0c1e4 (1472250340)
// size ...... 8596 (0x2194)
// includes .. 16  (offset: 0x1ed4)
// strings ... 36  (offset: 0x1f54)
// dev strs .. 4   (offset: 0x2164)
// exports ... 22  (offset: 0x1244)
// cseg ...... 0x431 + 0xe13 (0x1244)
// imports ... 75  (offset: 0x15b4)
// animtree1 . 0   (offset: 0x2194)
// animtree2 . 0   (offset: 0x2194)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\aitypes\aries_boss\aries_boss;
#using scripts\common\ai\aitypes\shared\zombie\zombie_emergence_spawning;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_boss;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_util;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_vo;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_weakpoint;

#namespace mp_sat_ob_aries_activity_boss_phasetwo;

// Namespace mp_sat_ob_aries_activity_boss_phasetwo
// Params 0, eflags: 0x5
// Checksum 0xd7628758, Offset: 0x44f
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_db193feefa6cf832", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace mp_sat_ob_aries_activity_boss_phasetwo
// Params 0, eflags: 0x4
// Checksum 0x666a0de5, Offset: 0x478
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_ARIES_BOSS_PHASETWO";
    activity_common::registeractivitytype( "OB_ARIES_BOSS_PHASETWO", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_BOSS_PHASETWO", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_BOSS_PHASETWO", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_BOSS_PHASETWO", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_ARIES_BOSS_PHASETWO" );
}

// Namespace mp_sat_ob_aries_activity_boss_phasetwo
// Params 0
// Checksum 0xdb4a5c8a, Offset: 0x4ef
// Size: 0x59
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance function_619327f6724c2028();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace mp_sat_ob_aries_activity_boss_phasetwo
// Params 0
// Checksum 0xf7ffc64b, Offset: 0x550
// Size: 0x39
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance function_66e2cd358d6894e1();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace mp_sat_ob_aries_activity_boss_phasetwo
// Params 0
// Checksum 0x28098108, Offset: 0x591
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace mp_sat_ob_aries_activity_boss_phasetwo
// Params 1
// Checksum 0x7a8747e6, Offset: 0x5b5
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread function_1475ff3eefddf89f( player );
    }
}

// Namespace mp_sat_ob_aries_activity_boss_phasetwo
// Params 0
// Checksum 0x4b666f72, Offset: 0x671
// Size: 0x18d
function function_619327f6724c2028()
{
    activity_instance = self;
    level thread aries_util::bloodpool_player_setup();
    activity_instance thread aries_util::waterfall_handler( "vfx_maze_transition_waterfall", "trig_waterfalls_p3" );
    utility::flag_set( "flag_started_from_start_function" );
    activity_instance thread aries_util::function_97223bf7668b6f43();
    aries_util::mars_setup( activity_instance );
    weakpoint_health = level.is_squad_size_small ? 562 : 1125;
    var_43be5ac5a6bb28fe = level.is_squad_size_small ? 900 : 1800;
    level.mars_ai.health = var_43be5ac5a6bb28fe * 3 + 4 * weakpoint_health;
    level.mars_ai mars::healthbar_update();
    vital_point_cluster = level.mars_ai.var_1d42ef2fdb0dbb1a[ "phase_one" ];
    
    foreach ( vital_point in vital_point_cluster.arr_weak_point )
    {
        vital_point weak_point::set_state( "inactive" );
    }
    
    activity_instance thread aries_util::function_8aaa6995bd26fc43();
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_mars_arena_weapon", undefined, 1, undefined, undefined, undefined, undefined, 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_mars_arena_equipment", undefined, 1, undefined, undefined, undefined, undefined, 1 );
}

// Namespace mp_sat_ob_aries_activity_boss_phasetwo
// Params 0
// Checksum 0xf6ad2c6a, Offset: 0x806
// Size: 0x73
function function_66e2cd358d6894e1()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance thread aries_boss::function_db70a947f03fd561();
    activity_instance childthread aries_vo::function_1ffcad08f896e065();
    activity_instance thread aries_util::getplayercount( activity_instance );
    level childthread function_213583b47aedc01d( activity_instance );
    activity_instance thread function_87cce21330255b4c();
    level utility::flag_set( "flag_mars_hint_boss" );
    level utility::flag_wait_all( "aries_boss_phasetwo_complete", "aries_boss_phase_2_5_complete" );
}

// Namespace mp_sat_ob_aries_activity_boss_phasetwo
// Params 1
// Checksum 0x90dde47d, Offset: 0x881
// Size: 0x52
function function_1475ff3eefddf89f( player )
{
    activity_instance = self;
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        player ob_story_mission_utils::function_2383fc8bfc3074d2();
        player ob_story_mission_utils::function_288fdad79fa2a11();
        player ob_gametype_story_mission::function_bdbb24f577154fa7( "sat_wingsuit_ob_sm_reduced_mag_fov", 0 );
    }
}

// Namespace mp_sat_ob_aries_activity_boss_phasetwo
// Params 1
// Checksum 0x5138eb4c, Offset: 0x8db
// Size: 0x3fe
function function_213583b47aedc01d( activity_instance )
{
    var_7e7dc3f64e33360a = utility::getstructarray( "mars_phasethree_respawn_override", "targetname" );
    
    if ( isdefined( var_7e7dc3f64e33360a ) )
    {
        ob_story_mission_utils::set_revive_spawns( var_7e7dc3f64e33360a );
    }
    
    mars_instance = level.mars_ai;
    mars_instance aries_boss::set_health_threshold( 2 );
    mars_instance thread mars::function_58511065e929f1f2();
    mars_instance mars::function_f6098d122e2499e3( 0 );
    
    if ( !utility::flag( "flag_started_from_start_function" ) )
    {
        mars_instance thread mars::phase_transition_notify( mars_instance.var_e03a976980256ff1[ 0 ], "rage_rumble_start", "rage_rumble_end" );
    }
    
    foreach ( head in mars_instance.var_e03a976980256ff1 )
    {
        head aries_boss::set_phase( 2 );
    }
    
    mars_instance.activity_instance = activity_instance;
    mars_instance notify( #"hash_64ac2a071b11b1cd" );
    utility::flag_set( "flag_phasetwo_start" );
    utility::flag_wait( "flag_mars_first_homing_projectile" );
    
    if ( level.playercount > 2 || !level.is_squad_size_small )
    {
        /#
            iprintlnbold( "<dev string:x24>" );
        #/
    }
    else
    {
        /#
            iprintlnbold( "<dev string:x4f>" );
        #/
    }
    
    var_4607d28f41b7698e = mars_instance function_a01d314c3153486f();
    level utility::flag_set( "flag_mars_vermin_spawned" );
    mars_instance.var_56e03db0739a3b35 waittill( #"hash_c35372eda579cd54" );
    mars_instance mars::function_f6098d122e2499e3( 1 );
    function_ef57f478f96b050c( var_4607d28f41b7698e, 0 );
    level utility::flag_set( "aries_boss_phasetwo_complete" );
    mars_instance mars::function_7da2cbf0e84c6adf();
    level thread aries_vo::function_e9d6588d6b0c34f5();
    
    foreach ( head in mars_instance.var_e03a976980256ff1 )
    {
        head aries_boss::set_phase( 3 );
        head thread aries_boss::function_10287b60f902efb2( 3 );
    }
    
    level.mars_ai.inactive_state = 1;
    mars_instance notify( #"notify_mars_inactive" );
    var_50581b71ef23582 = mars_instance function_1c3083f3015a397f();
    
    foreach ( agent in level.var_2c516590a7902c38 )
    {
        agent zombie_stun::stun_ai( 5 );
        
        /#
            iprintlnbold( "<dev string:x7a>" );
        #/
    }
    
    level thread function_43dbbf5eca7564e();
    origin = ( -18453, 23433, 2200 );
    angles = ( 0, 0, 0 );
    utility::flag_wait_or_timeout( "aries_boss_phase_2_5_complete", 90 );
    
    foreach ( encounter_id in var_50581b71ef23582 )
    {
        function_ef57f478f96b050c( encounter_id, 0 );
    }
    
    mars_instance mars::function_f6098d122e2499e3( 0 );
    level utility::flag_set( "aries_boss_phase_2_5_complete" );
    level.mars_ai.inactive_state = 0;
}

// Namespace mp_sat_ob_aries_activity_boss_phasetwo
// Params 0
// Checksum 0xe6b7b607, Offset: 0xce1
// Size: 0x7c
function function_a01d314c3153486f()
{
    var_4607d28f41b7698e = ai_spawn_director::lookup_spawn_request( "mars_adds_phasetwo" );
    
    if ( !isdefined( level.var_2c516590a7902c38 ) )
    {
        level.var_2c516590a7902c38 = [];
    }
    
    level.var_6648af92b98f295 = 0;
    ai_spawn_director::function_53289c032f506bb1( var_4607d28f41b7698e, &function_62c534e772310702, self );
    ai_spawn_director::function_c99d360d62c49a9c( var_4607d28f41b7698e, &function_5dc24790d1951c1, self );
    ai_spawn_director::add_spawned_callback( var_4607d28f41b7698e, &function_50c121f3dab66e14 );
    utility::flag_set( "flag_force_mars_adds_spawn" );
    function_ef57f478f96b050c( var_4607d28f41b7698e, 1 );
    return var_4607d28f41b7698e;
}

// Namespace mp_sat_ob_aries_activity_boss_phasetwo
// Params 0
// Checksum 0xb891aee8, Offset: 0xd66
// Size: 0x9c
function function_43dbbf5eca7564e()
{
    level endon( #"aries_boss_phase_2_5_complete" );
    wait 75;
    
    foreach ( agent in level.var_2c516590a7902c38 )
    {
        agent.health = 35;
    }
    
    /#
        iprintlnbold( "<dev string:x87>" );
    #/
}

// Namespace mp_sat_ob_aries_activity_boss_phasetwo
// Params 2
// Checksum 0x224f93, Offset: 0xe0a
// Size: 0x7e, Type: bool
function function_5dc24790d1951c1( requestid, userdata )
{
    add_limit = level.is_squad_size_small ? 8 : 15;
    
    if ( utility::flag( "flag_force_mars_adds_spawn" ) )
    {
        if ( level.var_6648af92b98f295 >= add_limit )
        {
            utility::flag_clear( "flag_force_mars_adds_spawn" );
        }
        
        return true;
    }
    
    if ( utility::flag( "flag_mars_weak_point_destroyed" ) )
    {
        utility::flag_clear( "flag_mars_weak_point_destroyed" );
        return true;
    }
    
    return false;
}

// Namespace mp_sat_ob_aries_activity_boss_phasetwo
// Params 2
// Checksum 0x6ac1a6d6, Offset: 0xe91
// Size: 0x29, Type: bool
function function_62c534e772310702( requestid, userdata )
{
    if ( userdata.health <= 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace mp_sat_ob_aries_activity_boss_phasetwo
// Params 0
// Checksum 0x9e90a80f, Offset: 0xec3
// Size: 0xe5
function function_1c3083f3015a397f()
{
    var_722b44168916757e = ai_spawn_director::lookup_spawn_request( "mars_adds_phase_2_5" );
    var_e84132e14ed12732 = ai_spawn_director::lookup_spawn_request( "mars_adds_phase_2_5_vermin" );
    
    if ( !isdefined( level.var_2c516590a7902c38 ) )
    {
        level.var_2c516590a7902c38 = [];
    }
    
    ai_spawn_director::function_53289c032f506bb1( var_722b44168916757e, &function_62c534e772310702, self );
    ai_spawn_director::function_c99d360d62c49a9c( var_722b44168916757e, &function_c88510b18e11629, self );
    ai_spawn_director::add_spawned_callback( var_722b44168916757e, &function_50c121f3dab66e14 );
    ai_spawn_director::function_53289c032f506bb1( var_e84132e14ed12732, &function_62c534e772310702, self );
    ai_spawn_director::function_c99d360d62c49a9c( var_e84132e14ed12732, &function_c88510b18e11629, self );
    ai_spawn_director::add_spawned_callback( var_e84132e14ed12732, &function_50c121f3dab66e14 );
    ai_spawn_director::function_5a08798970350207( var_722b44168916757e, &function_1228c8b09bf8cc40, self );
    ai_spawn_director::function_5a08798970350207( var_e84132e14ed12732, &function_ff7acb0bfbaad7be, self );
    utility::flag_set( "flag_force_mars_adds_spawn" );
    function_ef57f478f96b050c( var_722b44168916757e, 1 );
    function_ef57f478f96b050c( var_e84132e14ed12732, 1 );
    return [ var_722b44168916757e, var_e84132e14ed12732 ];
}

// Namespace mp_sat_ob_aries_activity_boss_phasetwo
// Params 2
// Checksum 0x89e5764c, Offset: 0xfb1
// Size: 0x4a
function function_1228c8b09bf8cc40( request_id, userdata )
{
    utility::flag_set( "aries_boss_phase_2_5_finished_spawning" );
    
    if ( utility::flag( "aries_boss_phase_2_5_finished_spawning" ) && utility::flag( "aries_boss_phase_2_5_vermin_finished_spawning" ) )
    {
        utility::flag_set( "aries_boss_phase_2_5_started" );
    }
}

// Namespace mp_sat_ob_aries_activity_boss_phasetwo
// Params 2
// Checksum 0x72bdc029, Offset: 0x1003
// Size: 0x4a
function function_ff7acb0bfbaad7be( request_id, userdata )
{
    utility::flag_set( "aries_boss_phase_2_5_vermin_finished_spawning" );
    
    if ( utility::flag( "aries_boss_phase_2_5_finished_spawning" ) && utility::flag( "aries_boss_phase_2_5_vermin_finished_spawning" ) )
    {
        utility::flag_set( "aries_boss_phase_2_5_started" );
    }
}

// Namespace mp_sat_ob_aries_activity_boss_phasetwo
// Params 2
// Checksum 0xd9892546, Offset: 0x1055
// Size: 0x33, Type: bool
function function_c88510b18e11629( requestid, userdata )
{
    if ( utility::flag( "flag_force_mars_adds_spawn" ) )
    {
        utility::flag_clear( "flag_force_mars_adds_spawn" );
        return true;
    }
    
    return false;
}

// Namespace mp_sat_ob_aries_activity_boss_phasetwo
// Params 4
// Checksum 0xe73c54e9, Offset: 0x1091
// Size: 0x109
function function_50c121f3dab66e14( requestid, userdata, agent, data )
{
    level.var_2c516590a7902c38[ level.var_2c516590a7902c38.size ] = agent;
    level.var_6648af92b98f295++;
    
    if ( agent.agent_type == "actor_sat_spawner_zombie_base_ob_aries" )
    {
        agent namespace_659599414270bd0a::function_80623a2279a4d888();
        agent.health = 1000;
        agent zombie_utils::function_a8ce00e0448cb6f0( "super_sprint", "aries_boss_base_zombies", 25 );
        agent function_fa32376aaa88a7a2( agent.origin, 5000 );
    }
    else
    {
        if ( agent.agent_type == "actor_sat_spawner_zombie_vermin_ob_sm" )
        {
            agent.health = 380;
        }
        else
        {
            agent.health = 380;
        }
        
        agent val::set( "mars_parasites", "dont_evolve", 1 );
        agent function_fa32376aaa88a7a2( agent.origin, 5000 );
    }
    
    agent thread function_e19deb3558e926b8();
}

// Namespace mp_sat_ob_aries_activity_boss_phasetwo
// Params 0
// Checksum 0xdde346c5, Offset: 0x11a2
// Size: 0x51
function function_e19deb3558e926b8()
{
    self waittill( #"death" );
    level.var_2c516590a7902c38 = utility::array_removedead_or_dying( level.var_2c516590a7902c38 );
    
    if ( utility::flag( "aries_boss_phase_2_5_started" ) && level.var_2c516590a7902c38.size <= 0 )
    {
        utility::flag_set( "aries_boss_phase_2_5_complete" );
    }
}

// Namespace mp_sat_ob_aries_activity_boss_phasetwo
// Params 0
// Checksum 0x8ddd108c, Offset: 0x11fb
// Size: 0x49
function function_87cce21330255b4c()
{
    ob_story_mission_utils::objective_text_clear();
    waitframe();
    ob_story_mission_utils::objective_text_show( "OB_ARIES_BOSS_WEAK_POINT" );
    utility::flag_wait( "aries_boss_phasetwo_complete" );
    ob_story_mission_utils::objective_text_clear();
    waitframe();
    ob_story_mission_utils::objective_text_show( "OB_ARIES_BOSS_ADD_PHASE" );
    utility::flag_wait( "aries_boss_phase_2_5_complete" );
    ob_story_mission_utils::objective_text_clear();
}

