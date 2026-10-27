// script_434328a2fbe401cd  (hash_434328a2fbe401cd.gscc) (size: 6405 Bytes / 0x1905 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe105765a (3775231578)
// size ...... 6405 (0x1905)
// includes .. 13  (offset: 0x171d)
// strings ... 25  (offset: 0x1785)
// dev strs .. 0   (offset: 0x1905)
// exports ... 22  (offset: 0xd31)
// cseg ...... 0x30e + 0xa23 (0xd31)
// imports ... 55  (offset: 0x10a1)
// animtree1 . 0   (offset: 0x1905)
// animtree2 . 0   (offset: 0x1905)
#using script_493d3716c5966d74;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_progress_tracking;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_audio;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_util;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_vo;

#namespace namespace_482c17801f6561d5;

/#

    // Namespace namespace_482c17801f6561d5
    // Params 0
    // Checksum 0xdb5c6e8b, Offset: 0x32c
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_482c17801f6561d5
// Params 0, eflags: 0x5
// Checksum 0xb6ba07c1, Offset: 0x339
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_b2ded62832bd9abc", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_482c17801f6561d5
// Params 0, eflags: 0x4
// Checksum 0x427d6dc9, Offset: 0x362
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LIBRA_INFIL_ANALYSIS";
    activity_common::registeractivitytype( "OB_LIBRA_INFIL_ANALYSIS", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_INFIL_ANALYSIS", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_INFIL_ANALYSIS", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_INFIL_ANALYSIS", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_482c17801f6561d5
// Params 0
// Checksum 0x4fd42992, Offset: 0x3c3
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_482c17801f6561d5
// Params 0
// Checksum 0x4bdaeee2, Offset: 0x428
// Size: 0x48
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    activity_instance function_f8a1a2e0b4eb18bd();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_482c17801f6561d5
// Params 0
// Checksum 0x466bf574, Offset: 0x478
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_482c17801f6561d5
// Params 0
// Checksum 0x17686c75, Offset: 0x49c
// Size: 0xe
function setup_ui_widget()
{
    ob_story_mission_utils::objective_text_show( "OB_LIBRA_INFIL_ANALYSIS" );
}

/#

    // Namespace namespace_482c17801f6561d5
    // Params 0
    // Checksum 0x9ce6ca9b, Offset: 0x4b2
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_482c17801f6561d5
// Params 0
// Checksum 0xcb4d0e63, Offset: 0x4bf
// Size: 0x3a
function start()
{
    activity_instance = self;
    activity_instance setup_ui_widget();
    
    if ( !utility::flag( "flag_infil_door_opened" ) )
    {
        utility::flag_set( "flag_infil_door_opened" );
    }
    
    thread namespace_a5a87f7f1400855e::function_4581cafa455d71af();
}

// Namespace namespace_482c17801f6561d5
// Params 0
// Checksum 0xee7cf186, Offset: 0x501
// Size: 0x97
function function_f8a1a2e0b4eb18bd()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    ob_story_mission_utils::objective_text_show( "OB_LIBRA_INFIL_ANALYSIS" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "analysis_waypoint_org", undefined, "analysis_waypoint_done", undefined, undefined, 1 );
    level thread mp_sat_ob_libra_util::function_776ea74dd9e92d46( "flag_infil_analysis_done", "analysis_waypoint_org" );
    thread function_93e87280c431f4c7();
    level utility::flag_wait( "flag_infil_door_opened" );
    level thread mp_sat_ob_libra_vo::infil_data_center();
    level thread mp_sat_ob_libra_vo::function_9f3e772fdda470fe();
    level thread mp_sat_ob_libra_vo::infil_analysis_enemy_callout();
    level thread mp_sat_ob_libra_vo::analysis_pa();
    level thread analysis_alarms();
    utility::flag_wait( "flag_infil_analysis_done" );
}

// Namespace namespace_482c17801f6561d5
// Params 0, eflags: 0x4
// Checksum 0x7c7b8bdf, Offset: 0x5a0
// Size: 0x21
function private facility_intro_objectives()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    setup_ui_widget();
}

// Namespace namespace_482c17801f6561d5
// Params 0
// Checksum 0xc9d2569c, Offset: 0x5c9
// Size: 0xf3
function function_93e87280c431f4c7()
{
    level utility::flag_set( "flag_infil_analysis_start" );
    level.var_3eaa730b1783ea8f = [];
    level.enc_analysis = activity_ai_encounters::function_92b671064b0b1ce2( "encounter_libra_analysis", 1, 1, 1, 1 );
    function_ef57f478f96b050c( level.enc_analysis, 1 );
    activity_ai_encounters::function_6bf4ff2fbde584ee( level.enc_analysis, &function_56e502305a648d66 );
    ai_spawn_director::add_spawned_callback( level.enc_analysis, &analysis_spawn_func );
    ai_spawn_director::function_a49c35b72d6b6fea( level.enc_analysis, &function_ba064dabf72e2a85 );
    level utility::flag_wait( "flag_analysis_enemies_spawned" );
    activity_progress_tracking::function_82d854bb84c20512( "analysis_kill_progress_tracker", level.var_3eaa730b1783ea8f, &analysis_kill_progress_tracker );
    thread function_9a8e07dc8a11fc92();
    utility::flag_wait( "analysis_retreat_flag" );
    
    if ( !utility::flag( "analysis_enemies_low" ) )
    {
        thread function_a31c2057be50bd0f();
        thread libra_audio::function_a489203dbfc6a70c();
    }
    
    wait 1;
    level thread mp_sat_ob_libra_vo::infil_analysis_enemy_falling_back();
    level utility::flag_wait( "flag_infil_analysis_done" );
}

// Namespace namespace_482c17801f6561d5
// Params 4
// Checksum 0xc8131cfa, Offset: 0x6c4
// Size: 0x9f
function analysis_spawn_func( requestid, instance, agent, ai_data )
{
    level.var_3eaa730b1783ea8f[ level.var_3eaa730b1783ea8f.size ] = agent;
    
    if ( isdefined( ai_data.script_noteworthy ) )
    {
        switch ( ai_data.script_noteworthy )
        {
            case #"hash_9ed9a0d03e415456":
                agent thread function_a56eb0e40e52f9d8();
                break;
            case #"hash_9ed99fd03e4152c3":
                agent thread function_f8fb8683937df077();
                break;
            default:
                break;
        }
    }
}

// Namespace namespace_482c17801f6561d5
// Params 3
// Checksum 0x873f050d, Offset: 0x76b
// Size: 0x60
function function_ba064dabf72e2a85( requestid, userdata, shutdowndata )
{
    if ( isdefined( level.enc_analysis ) )
    {
        iprintln( "analysis encounter complete!" );
        ai_spawn_director::cancel_spawn_request( level.enc_analysis );
    }
    
    if ( !utility::flag( "flag_storage_enemies_spawned" ) )
    {
        level notify( #"hash_9d7057e3432c4193" );
    }
}

// Namespace namespace_482c17801f6561d5
// Params 3
// Checksum 0x31337abc, Offset: 0x7d3
// Size: 0x2b
function function_56e502305a648d66( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_analysis_enemies_spawned" );
}

// Namespace namespace_482c17801f6561d5
// Params 0
// Checksum 0xf863fc33, Offset: 0x806
// Size: 0x119
function function_9a8e07dc8a11fc92()
{
    if ( isdefined( level.var_3eaa730b1783ea8f ) )
    {
        foreach ( agent in level.var_3eaa730b1783ea8f )
        {
            agent.ignoreall = 1;
        }
    }
    
    utility::flag_wait( "flag_infil_door_opened" );
    
    if ( isdefined( level.var_3eaa730b1783ea8f ) )
    {
        foreach ( agent in level.var_3eaa730b1783ea8f )
        {
            agent.ignoreall = 0;
        }
    }
}

// Namespace namespace_482c17801f6561d5
// Params 0
// Checksum 0xd4d03e8, Offset: 0x927
// Size: 0x21
function function_a56eb0e40e52f9d8()
{
    level.infil_analysis_guy_01 = self;
    utility::set_battlechatter( 0 );
    level utility::flag_set( "flag_infil_analysis_guy_01_spawned" );
}

// Namespace namespace_482c17801f6561d5
// Params 0
// Checksum 0x8401da65, Offset: 0x950
// Size: 0x21
function function_f8fb8683937df077()
{
    level.infil_analysis_guy_02 = self;
    utility::set_battlechatter( 0 );
    level utility::flag_set( "flag_infil_analysis_guy_02_spawned" );
}

// Namespace namespace_482c17801f6561d5
// Params 3
// Checksum 0x2ec78932, Offset: 0x979
// Size: 0x8a
function analysis_kill_progress_tracker( requestid, activity_instance, agent )
{
    level.var_3eaa730b1783ea8f = utility::array_removedead_or_dying( level.var_3eaa730b1783ea8f );
    
    if ( !utility::flag( "analysis_retreat_flag" ) )
    {
        if ( level.var_3eaa730b1783ea8f.size <= 6 )
        {
            utility::flag_set( "analysis_enemies_low" );
            utility::flag_set( "analysis_retreat_flag" );
            thread function_a31c2057be50bd0f();
            return;
        }
    }
    
    if ( level.var_3eaa730b1783ea8f.size == 1 )
    {
        clearmusicstate();
    }
}

// Namespace namespace_482c17801f6561d5
// Params 0
// Checksum 0x75c4ef7e, Offset: 0xa0b
// Size: 0x2f7
function function_a31c2057be50bd0f()
{
    level.var_3eaa730b1783ea8f = utility::array_removedead_or_dying( level.var_3eaa730b1783ea8f );
    vol = getent( "storage_mainfloor", "targetname" );
    struct = utility::getstruct( "analysis_rotate_struct", "targetname" );
    var_c16dd4b9d3102f8c = utility::getstruct( "zone_0_struct", "targetname" );
    zone1 = utility::getstruct( "zone_1_struct", "targetname" );
    zone2 = utility::getstruct( "zone_2_struct", "targetname" );
    
    if ( !utility::flag( "retreat_done" ) )
    {
        group1 = [];
        group2 = [];
        var_f405eb5615c69806 = [];
        
        for ( i = 0; i < 2 ; i++ )
        {
            group1[ i ] = level.var_3eaa730b1783ea8f[ i ];
        }
        
        for ( i = 3; i < 6 ; i++ )
        {
            group2[ i - 3 ] = level.var_3eaa730b1783ea8f[ i ];
        }
        
        for ( i = 6; i < level.var_3eaa730b1783ea8f.size ; i++ )
        {
            var_f405eb5615c69806[ i - 6 ] = level.var_3eaa730b1783ea8f[ i ];
        }
        
        if ( isdefined( group1 ) )
        {
            foreach ( agent in group1 )
            {
                agent endon( #"death" );
                agent setgoalpos( zone1.origin, 200 );
            }
        }
        
        if ( isdefined( group2 ) )
        {
            foreach ( agent in group2 )
            {
                agent endon( #"death" );
                agent setgoalpos( zone2.origin, 250 );
            }
        }
        
        if ( isdefined( var_f405eb5615c69806 ) && isdefined( var_c16dd4b9d3102f8c ) )
        {
            foreach ( agent in var_f405eb5615c69806 )
            {
                agent endon( #"death" );
                agent setgoalpos( var_c16dd4b9d3102f8c.origin, 400 );
            }
        }
    }
    
    utility::flag_set( "retreat_done" );
}

// Namespace namespace_482c17801f6561d5
// Params 0
// Checksum 0xf7791bc9, Offset: 0xd0a
// Size: 0x27
function analysis_alarms()
{
    level utility::flag_wait( "flag_analysis_alerted" );
    wait 2;
    level thread mp_sat_ob_libra_util::handle_alarms( "analysis_alarms", "flag_infil_storage_done" );
}

