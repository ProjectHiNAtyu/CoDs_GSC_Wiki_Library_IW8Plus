// scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_activity_boss_phasethree.gsc  (hash_0f6f773d0ab9224d.gscc) (size: 7632 Bytes / 0x1dd0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa7895b36 (2810796854)
// size ...... 7632 (0x1dd0)
// includes .. 17  (offset: 0x1b60)
// strings ... 34  (offset: 0x1be8)
// dev strs .. 2   (offset: 0x1db8)
// exports ... 17  (offset: 0x1044)
// cseg ...... 0x38b + 0xcb9 (0x1044)
// imports ... 74  (offset: 0x12ec)
// animtree1 . 0   (offset: 0x1dd0)
// animtree2 . 0   (offset: 0x1dd0)
#using script_3edd59d0d3fc3262;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\aitypes\aries_boss\aries_boss;
#using scripts\common\ai\aitypes\shared\zombie\zombie_emergence_spawning;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_boss;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_util;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_vo;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_weakpoint;

#namespace mp_sat_ob_aries_activity_boss_phasethree;

// Namespace mp_sat_ob_aries_activity_boss_phasethree
// Params 0, eflags: 0x5
// Checksum 0x6c3aac52, Offset: 0x3a9
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_249441f8669f0c20", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace mp_sat_ob_aries_activity_boss_phasethree
// Params 0, eflags: 0x4
// Checksum 0xe689a20f, Offset: 0x3d2
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_ARIES_BOSS_PHASETHREE";
    activity_common::registeractivitytype( "OB_ARIES_BOSS_PHASETHREE", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_BOSS_PHASETHREE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_BOSS_PHASETHREE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_BOSS_PHASETHREE", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_ARIES_BOSS_PHASETHREE" );
}

// Namespace mp_sat_ob_aries_activity_boss_phasethree
// Params 0
// Checksum 0x26fbc852, Offset: 0x449
// Size: 0x71
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance function_36121b5f4570335a();
    }
    else
    {
        level.mars_ai.inactive_state = 0;
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace mp_sat_ob_aries_activity_boss_phasethree
// Params 0
// Checksum 0x7964ee9a, Offset: 0x4c2
// Size: 0x39
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance function_565763cce005e22b();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace mp_sat_ob_aries_activity_boss_phasethree
// Params 0
// Checksum 0xa8ea2ee2, Offset: 0x503
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace mp_sat_ob_aries_activity_boss_phasethree
// Params 1
// Checksum 0xe0513aff, Offset: 0x527
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread function_1e1e195514567069( player );
    }
}

// Namespace mp_sat_ob_aries_activity_boss_phasethree
// Params 0
// Checksum 0x502f2eaa, Offset: 0x5e3
// Size: 0x21f
function function_36121b5f4570335a()
{
    activity_instance = self;
    level thread aries_util::bloodpool_player_setup();
    activity_instance thread aries_util::waterfall_handler( "vfx_maze_transition_waterfall", "trig_waterfalls_p3" );
    utility::flag_set( "flag_started_from_start_function" );
    aries_util::mars_setup( activity_instance );
    level.mars_ai.health = ( level.is_squad_size_small ? 900 : 1800 ) * 3;
    level.mars_ai mars::healthbar_update();
    vital_point_cluster = level.mars_ai.var_1d42ef2fdb0dbb1a[ "phase_one" ];
    
    foreach ( vital_point in vital_point_cluster.arr_weak_point )
    {
        vital_point weak_point::set_state( "inactive" );
    }
    
    vital_point_cluster = level.mars_ai.var_1d42ef2fdb0dbb1a[ "phase_two" ];
    
    foreach ( vital_point in vital_point_cluster.arr_weak_point )
    {
        vital_point weak_point::set_state( "inactive" );
    }
    
    level.mars_ai.inactive_state = 0;
    var_7e7dc3f64e33360a = utility::getstructarray( "mars_phasethree_respawn_override", "targetname" );
    
    if ( isdefined( var_7e7dc3f64e33360a ) )
    {
        ob_story_mission_utils::set_revive_spawns( var_7e7dc3f64e33360a );
    }
    
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_mars_arena_weapon", undefined, 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_mars_arena_equipment", undefined, 1 );
    activity_instance thread aries_util::function_8aaa6995bd26fc43();
    activity_instance thread aries_util::function_97223bf7668b6f43();
}

// Namespace mp_sat_ob_aries_activity_boss_phasethree
// Params 0
// Checksum 0x298c7e72, Offset: 0x80a
// Size: 0x148
function function_565763cce005e22b()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance thread aries_boss::function_db70a947f03fd561();
    activity_instance thread aries_util::getplayercount( activity_instance );
    activity_instance childthread aries_vo::function_7ef59c243046d603();
    level childthread function_213582b47aedbdea( activity_instance );
    activity_instance thread function_8480b38bf08ad592();
    level utility::flag_wait( "aries_boss_phasethree_complete" );
    level.var_2c516590a7902c38 = utility::array_removedead_or_dying( level.var_2c516590a7902c38 );
    
    foreach ( remaining_ai in level.var_2c516590a7902c38 )
    {
        if ( !utility::is_dead_or_dying( remaining_ai ) )
        {
            remaining_ai kill();
        }
    }
    
    story_contract_util::mark_complete( level.players, #"aries_complete" );
    story_contract_util::achievement_activities( level.players, "sat_wc_mission2and3", [ #"pisces_step_06", #"aries_complete" ] );
    function_d21cd9ec01b2df47();
}

// Namespace mp_sat_ob_aries_activity_boss_phasethree
// Params 1
// Checksum 0xad43e996, Offset: 0x95a
// Size: 0x52
function function_1e1e195514567069( player )
{
    activity_instance = self;
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        player ob_story_mission_utils::function_2383fc8bfc3074d2();
        player ob_story_mission_utils::function_288fdad79fa2a11();
        player ob_gametype_story_mission::function_bdbb24f577154fa7( "sat_wingsuit_ob_sm_reduced_mag_fov", 0 );
    }
}

// Namespace mp_sat_ob_aries_activity_boss_phasethree
// Params 1
// Checksum 0xef408524, Offset: 0x9b4
// Size: 0x2f7
function function_213582b47aedbdea( activity_instance )
{
    mars_instance = level.mars_ai;
    mars_instance aries_boss::set_health_threshold( 3 );
    
    if ( !utility::flag( "flag_started_from_start_function" ) )
    {
        mars_instance thread mars::phase_transition_notify( mars_instance.var_e03a976980256ff1[ 0 ], "rage_rumble_start", "rage_rumble_end" );
    }
    
    foreach ( head in mars_instance.var_e03a976980256ff1 )
    {
        head aries_boss::set_phase( 3 );
        head.var_cce7c67ea2da8902 = level.is_squad_size_small ? 900 : 1800;
    }
    
    mars_instance.activity_instance = activity_instance;
    
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
    
    mars_instance.health = ( level.is_squad_size_small ? 900 : 1800 ) * 3;
    mars_instance mars::function_f6098d122e2499e3( 0 );
    mars_instance thread mars::function_bf4982196464ad90();
    mars_instance notify( #"mars_phasethree_start" );
    utility::flag_set( "flag_phasethree_start" );
    
    if ( !utility::flag( "flag_started_from_start_function" ) )
    {
        mars_instance.var_e03a976980256ff1[ 0 ] waittill( #"rage_rumble_start" );
        
        foreach ( head in mars_instance.var_e03a976980256ff1 )
        {
            head setscriptablepartstate( "attack", "dragons_breath" );
        }
        
        mars_instance.var_e03a976980256ff1[ 0 ] waittill( #"rage_rumble_end" );
        
        foreach ( head in mars_instance.var_e03a976980256ff1 )
        {
            head setscriptablepartstate( "attack", "idle" );
        }
    }
    
    var_98f01b87fbd35560 = mars_instance function_d665d81c375ab609();
    mars_instance waittill( #"death" );
    level utility::flag_set( "aries_boss_phasethree_complete" );
    function_ef57f478f96b050c( var_98f01b87fbd35560, 0 );
}

// Namespace mp_sat_ob_aries_activity_boss_phasethree
// Params 0
// Checksum 0x86ec31c6, Offset: 0xcb3
// Size: 0x7c
function function_d665d81c375ab609()
{
    var_98f01b87fbd35560 = ai_spawn_director::lookup_spawn_request( "mars_adds_phasethree" );
    
    if ( !isdefined( level.var_2c516590a7902c38 ) )
    {
        level.var_2c516590a7902c38 = [];
    }
    
    level.var_6648af92b98f295 = 0;
    ai_spawn_director::function_53289c032f506bb1( var_98f01b87fbd35560, &function_a0b632f9d42f2aac, self );
    ai_spawn_director::function_c99d360d62c49a9c( var_98f01b87fbd35560, &function_82c2cc5568f08a9b, self );
    ai_spawn_director::add_spawned_callback( var_98f01b87fbd35560, &function_50c121f3dab66e14 );
    utility::flag_set( "flag_force_mars_adds_spawn" );
    function_ef57f478f96b050c( var_98f01b87fbd35560, 1 );
    return var_98f01b87fbd35560;
}

// Namespace mp_sat_ob_aries_activity_boss_phasethree
// Params 2
// Checksum 0x58e19606, Offset: 0xd38
// Size: 0x80, Type: bool
function function_82c2cc5568f08a9b( requestid, userdata )
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
    
    if ( utility::flag( "flag_mars_head_destroyed" ) )
    {
        utility::flag_clear( "flag_mars_head_destroyed" );
        return true;
    }
    
    return false;
}

// Namespace mp_sat_ob_aries_activity_boss_phasethree
// Params 2
// Checksum 0xccfe34f, Offset: 0xdc1
// Size: 0x29, Type: bool
function function_a0b632f9d42f2aac( requestid, userdata )
{
    if ( userdata.health <= 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace mp_sat_ob_aries_activity_boss_phasethree
// Params 4
// Checksum 0xabe6e8f1, Offset: 0xdf3
// Size: 0xf4
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
    }
    
    agent thread function_e19deb3558e926b8();
}

// Namespace mp_sat_ob_aries_activity_boss_phasethree
// Params 0
// Checksum 0x1eac17af, Offset: 0xeef
// Size: 0x1f
function function_e19deb3558e926b8()
{
    self waittill( #"death" );
    utility::array_removedead_or_dying( level.var_2c516590a7902c38 );
}

// Namespace mp_sat_ob_aries_activity_boss_phasethree
// Params 0
// Checksum 0x2afba45c, Offset: 0xf16
// Size: 0x12e
function function_8480b38bf08ad592()
{
    ob_story_mission_utils::objective_text_clear();
    waitframe();
    ob_story_mission_utils::objective_text_show( "OB_ARIES_BOSS_FINAL_WEAK_POINT" );
    thread mars::function_11c81406e9fe90e4();
    
    while ( level.mars_ai.health > 0 )
    {
        level.mars_ai utility::waittill_any( "notify_final_phase_head_destroyed", "death" );
        
        if ( level.mars_ai.remaining_heads == 2 )
        {
            childthread aries_vo::function_84686b7424cd7ef1();
        }
        
        if ( level.mars_ai.remaining_heads == 1 )
        {
            level utility::flag_set( "flag_mars_one_head_remaining" );
            childthread aries_vo::function_2b9466f9d7f3c3eb();
        }
        
        if ( level.mars_ai.health <= 0 || level.mars_ai.remaining_heads <= 0 )
        {
            ob_story_mission_utils::objective_text_clear();
            level.mars_ai mars::function_f6098d122e2499e3( 1 );
            level callback::callback( #"aries_boss_defeated", { #players:level.players } );
            level.mars_ai notify( #"death" );
            utility::flag_set( "aries_boss_phasethree_complete" );
            return;
        }
    }
}

