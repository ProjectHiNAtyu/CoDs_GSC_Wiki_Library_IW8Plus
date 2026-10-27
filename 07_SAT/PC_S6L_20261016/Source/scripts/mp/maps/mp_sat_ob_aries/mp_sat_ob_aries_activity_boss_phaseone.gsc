// scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_activity_boss_phaseone.gsc  (hash_519afe001219c2c9.gscc) (size: 7901 Bytes / 0x1edd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x70ecc0cf (1894564047)
// size ...... 7901 (0x1edd)
// includes .. 16  (offset: 0x1c6d)
// strings ... 29  (offset: 0x1ced)
// dev strs .. 4   (offset: 0x1ead)
// exports ... 22  (offset: 0x105d)
// cseg ...... 0x39e + 0xcbf (0x105d)
// imports ... 71  (offset: 0x13cd)
// animtree1 . 0   (offset: 0x1edd)
// animtree2 . 0   (offset: 0x1edd)
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
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_audio;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_boss;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_util;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_vo;

#namespace namespace_c87b704003a1646a;

// Namespace namespace_c87b704003a1646a
// Params 0, eflags: 0x5
// Checksum 0x9c9a5b90, Offset: 0x3bc
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_3969f8ef2f93068c", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_c87b704003a1646a
// Params 0, eflags: 0x4
// Checksum 0x14cc7c26, Offset: 0x3e5
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_ARIES_BOSS_PHASEONE";
    activity_common::registeractivitytype( "OB_ARIES_BOSS_PHASEONE", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_BOSS_PHASEONE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_BOSS_PHASEONE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_BOSS_PHASEONE", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_ARIES_BOSS_PHASEONE" );
}

// Namespace namespace_c87b704003a1646a
// Params 0
// Checksum 0xac5cd71e, Offset: 0x45c
// Size: 0x59
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance function_ab65f075532b72ea();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_c87b704003a1646a
// Params 0
// Checksum 0x1bf4333b, Offset: 0x4bd
// Size: 0x39
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance function_dbca2ea39bd59edb();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_c87b704003a1646a
// Params 0
// Checksum 0x5aaff0cb, Offset: 0x4fe
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_c87b704003a1646a
// Params 1
// Checksum 0xb85b2208, Offset: 0x522
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread function_9a0d0d5104c8699( player );
    }
}

// Namespace namespace_c87b704003a1646a
// Params 0
// Checksum 0x710909da, Offset: 0x5de
// Size: 0x6d
function function_ab65f075532b72ea()
{
    activity_instance = self;
    level thread aries_util::bloodpool_player_setup();
    activity_instance thread aries_util::waterfall_handler( "vfx_maze_transition_waterfall", "trig_waterfalls_p3" );
    utility::flag_set( "flag_started_from_start_function" );
    aries_util::mars_setup( activity_instance );
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_mars_arena_weapon", undefined, 1, undefined, undefined, undefined, undefined, 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_mars_arena_equipment", undefined, 1, undefined, undefined, undefined, undefined, 1 );
}

// Namespace namespace_c87b704003a1646a
// Params 0
// Checksum 0xaa4b359, Offset: 0x653
// Size: 0x77
function function_dbca2ea39bd59edb()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance thread aries_util::getplayercount( activity_instance );
    level thread aries_util::function_8aaa6995bd26fc43();
    activity_instance thread aries_util::function_97223bf7668b6f43();
    level childthread function_213580b47aedb984( activity_instance );
    activity_instance thread function_33a997bc2eb409e2();
    activity_instance childthread aries_vo::function_1f42bde6804fa376();
    activity_instance thread aries_boss::function_db70a947f03fd561();
    level utility::flag_wait_all( "aries_boss_phaseone_complete", "aries_boss_phase_1_5_complete" );
}

// Namespace namespace_c87b704003a1646a
// Params 1
// Checksum 0xbea0d226, Offset: 0x6d2
// Size: 0x52
function function_9a0d0d5104c8699( player )
{
    activity_instance = self;
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        player ob_story_mission_utils::function_2383fc8bfc3074d2();
        player ob_story_mission_utils::function_288fdad79fa2a11();
        player ob_gametype_story_mission::function_bdbb24f577154fa7( "sat_wingsuit_ob_sm_reduced_mag_fov", 0 );
    }
}

// Namespace namespace_c87b704003a1646a
// Params 1
// Checksum 0x60156396, Offset: 0x72c
// Size: 0x3c4
function function_213580b47aedb984( activity_instance )
{
    mars_instance = level.mars_ai;
    mars_instance aries_boss::set_health_threshold( 1 );
    mars_instance thread mars::function_8596f7e6758b6253();
    
    if ( !utility::flag( "flag_started_from_start_function" ) )
    {
        mars_instance thread mars::phase_transition_notify( mars_instance.var_e03a976980256ff1[ 0 ], "dragons_breath_start", "dragons_breath_end" );
    }
    
    foreach ( head in mars_instance.var_e03a976980256ff1 )
    {
        head aries_boss::set_phase( 1 );
    }
    
    mars_instance.activity_instance = activity_instance;
    mars_instance notify( #"hash_c49b764187656e5b" );
    
    if ( !utility::flag( "flag_started_from_start_function" ) )
    {
        mars_instance.var_e03a976980256ff1[ 0 ] waittill( #"dragons_breath_end" );
    }
    
    thread aries_audio::function_6ccd783a813a8dde();
    utility::flag_wait( "flag_mars_first_dragon_breath" );
    
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
    
    var_6ad28d23e4e7a4c8 = mars_instance function_76a4a805bbda7981();
    mars_instance.var_56e03db0739a3b35 waittill( #"all_weak_points_in_cluster_destroyed" );
    mars_instance mars::function_f6098d122e2499e3( 1 );
    function_ef57f478f96b050c( var_6ad28d23e4e7a4c8, 0 );
    level utility::flag_set( "aries_boss_phaseone_complete" );
    mars_instance mars::function_7da2cbf0e84c6adf();
    
    foreach ( head in mars_instance.var_e03a976980256ff1 )
    {
        head aries_boss::set_phase( 2 );
        head thread aries_boss::function_10287b60f902efb2( 2 );
    }
    
    level.mars_ai.inactive_state = 1;
    mars_instance notify( #"notify_mars_inactive" );
    var_50581b71ef23582 = mars_instance function_2f0c4df3522f7256();
    
    foreach ( agent in level.var_2c516590a7902c38 )
    {
        agent zombie_stun::stun_ai( 5 );
        
        /#
            iprintlnbold( "<dev string:x7a>" );
        #/
    }
    
    origin = ( -18453, 23433, 2200 );
    angles = ( 0, 0, 0 );
    level thread function_42b781dcc67d1ba9();
    utility::flag_wait_or_timeout( "aries_boss_phase_1_5_complete", 90 );
    
    foreach ( encounter_id in var_50581b71ef23582 )
    {
        function_ef57f478f96b050c( encounter_id, 0 );
    }
    
    mars_instance mars::function_f6098d122e2499e3( 0 );
    level utility::flag_set( "aries_boss_phase_1_5_complete" );
}

// Namespace namespace_c87b704003a1646a
// Params 0
// Checksum 0x4e33378e, Offset: 0xaf8
// Size: 0x7c
function function_76a4a805bbda7981()
{
    var_6ad28d23e4e7a4c8 = ai_spawn_director::lookup_spawn_request( "mars_adds_phaseone" );
    
    if ( !isdefined( level.var_2c516590a7902c38 ) )
    {
        level.var_2c516590a7902c38 = [];
    }
    
    level.var_6648af92b98f295 = 0;
    ai_spawn_director::function_53289c032f506bb1( var_6ad28d23e4e7a4c8, &function_a6de65c756d85e98, self );
    ai_spawn_director::function_c99d360d62c49a9c( var_6ad28d23e4e7a4c8, &function_d1b898560b97f73, self );
    ai_spawn_director::add_spawned_callback( var_6ad28d23e4e7a4c8, &function_50c121f3dab66e14 );
    utility::flag_set( "flag_force_mars_adds_spawn" );
    function_ef57f478f96b050c( var_6ad28d23e4e7a4c8, 1 );
    return var_6ad28d23e4e7a4c8;
}

// Namespace namespace_c87b704003a1646a
// Params 0
// Checksum 0x2a2f1d81, Offset: 0xb7d
// Size: 0x9c
function function_42b781dcc67d1ba9()
{
    level endon( #"aries_boss_phase_1_5_complete" );
    wait 75;
    
    foreach ( agent in level.var_2c516590a7902c38 )
    {
        agent.health = 35;
    }
    
    /#
        iprintlnbold( "<dev string:x87>" );
    #/
}

// Namespace namespace_c87b704003a1646a
// Params 2
// Checksum 0x3c69acd3, Offset: 0xc21
// Size: 0x80, Type: bool
function function_d1b898560b97f73( requestid, userdata )
{
    add_limit = level.is_squad_size_small ? 6 : 9;
    
    if ( utility::flag( "flag_force_mars_adds_spawn" ) )
    {
        if ( level.var_6648af92b98f295 >= add_limit )
        {
            utility::flag_clear( "flag_force_mars_adds_spawn" );
            return false;
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

// Namespace namespace_c87b704003a1646a
// Params 2
// Checksum 0x568a45e8, Offset: 0xcaa
// Size: 0x29, Type: bool
function function_a6de65c756d85e98( requestid, userdata )
{
    if ( userdata.health <= 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_c87b704003a1646a
// Params 0
// Checksum 0xe7a03d97, Offset: 0xcdc
// Size: 0xe5
function function_2f0c4df3522f7256()
{
    var_3e5ae88a13b2855d = ai_spawn_director::lookup_spawn_request( "mars_adds_phase_1_5" );
    var_a6750924e35d96db = ai_spawn_director::lookup_spawn_request( "mars_adds_phase_1_5_vermin" );
    
    if ( !isdefined( level.var_2c516590a7902c38 ) )
    {
        level.var_2c516590a7902c38 = [];
    }
    
    ai_spawn_director::function_53289c032f506bb1( var_3e5ae88a13b2855d, &function_a6de65c756d85e98, self );
    ai_spawn_director::function_c99d360d62c49a9c( var_3e5ae88a13b2855d, &function_912faa541bdc50a2, self );
    ai_spawn_director::add_spawned_callback( var_3e5ae88a13b2855d, &function_50c121f3dab66e14 );
    ai_spawn_director::function_53289c032f506bb1( var_a6750924e35d96db, &function_a6de65c756d85e98, self );
    ai_spawn_director::function_c99d360d62c49a9c( var_a6750924e35d96db, &function_912faa541bdc50a2, self );
    ai_spawn_director::add_spawned_callback( var_a6750924e35d96db, &function_50c121f3dab66e14 );
    ai_spawn_director::function_5a08798970350207( var_3e5ae88a13b2855d, &function_1228c8b09bf8cc40, self );
    ai_spawn_director::function_5a08798970350207( var_a6750924e35d96db, &function_ff7acb0bfbaad7be, self );
    utility::flag_set( "flag_force_mars_adds_spawn" );
    function_ef57f478f96b050c( var_3e5ae88a13b2855d, 1 );
    function_ef57f478f96b050c( var_a6750924e35d96db, 1 );
    return [ var_3e5ae88a13b2855d, var_a6750924e35d96db ];
}

// Namespace namespace_c87b704003a1646a
// Params 2
// Checksum 0x607f66a9, Offset: 0xdca
// Size: 0x4a
function function_1228c8b09bf8cc40( request_id, userdata )
{
    utility::flag_set( "aries_boss_phase_1_5_finished_spawning" );
    
    if ( utility::flag( "aries_boss_phase_1_5_finished_spawning" ) && utility::flag( "aries_boss_phase_1_5_vermin_finished_spawning" ) )
    {
        utility::flag_set( "aries_boss_phase_1_5_started" );
    }
}

// Namespace namespace_c87b704003a1646a
// Params 2
// Checksum 0xe2e75508, Offset: 0xe1c
// Size: 0x4a
function function_ff7acb0bfbaad7be( request_id, userdata )
{
    utility::flag_set( "aries_boss_phase_1_5_vermin_finished_spawning" );
    
    if ( utility::flag( "aries_boss_phase_1_5_finished_spawning" ) && utility::flag( "aries_boss_phase_1_5_vermin_finished_spawning" ) )
    {
        utility::flag_set( "aries_boss_phase_1_5_started" );
    }
}

// Namespace namespace_c87b704003a1646a
// Params 2
// Checksum 0x4018ef86, Offset: 0xe6e
// Size: 0x33, Type: bool
function function_912faa541bdc50a2( requestid, userdata )
{
    if ( utility::flag( "flag_force_mars_adds_spawn" ) )
    {
        utility::flag_clear( "flag_force_mars_adds_spawn" );
        return true;
    }
    
    return false;
}

// Namespace namespace_c87b704003a1646a
// Params 4
// Checksum 0x793b769f, Offset: 0xeaa
// Size: 0x109
function function_50c121f3dab66e14( requestid, userdata, agent, data )
{
    level.var_2c516590a7902c38[ level.var_2c516590a7902c38.size ] = agent;
    level.var_6648af92b98f295++;
    
    if ( agent.agent_type == "actor_sat_spawner_zombie_base_ob_aries" )
    {
        agent zombie_emergence_spawning::function_80623a2279a4d888();
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

// Namespace namespace_c87b704003a1646a
// Params 0
// Checksum 0x413983f7, Offset: 0xfbb
// Size: 0x51
function function_e19deb3558e926b8()
{
    self waittill( #"death" );
    level.var_2c516590a7902c38 = utility::array_removedead_or_dying( level.var_2c516590a7902c38 );
    
    if ( utility::flag( "aries_boss_phase_1_5_started" ) && level.var_2c516590a7902c38.size <= 0 )
    {
        utility::flag_set( "aries_boss_phase_1_5_complete" );
    }
}

// Namespace namespace_c87b704003a1646a
// Params 0
// Checksum 0xc7d9d318, Offset: 0x1014
// Size: 0x49
function function_33a997bc2eb409e2()
{
    ob_story_mission_utils::objective_text_clear();
    waitframe();
    ob_story_mission_utils::objective_text_show( "OB_ARIES_BOSS_WEAK_POINT" );
    utility::flag_wait( "aries_boss_phaseone_complete" );
    ob_story_mission_utils::objective_text_clear();
    waitframe();
    ob_story_mission_utils::objective_text_show( "OB_ARIES_BOSS_ADD_PHASE" );
    utility::flag_wait( "aries_boss_phase_1_5_complete" );
    ob_story_mission_utils::objective_text_clear();
}

