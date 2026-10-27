// script_2ef3c27f28c74816  (hash_2ef3c27f28c74816.gscc) (size: 14185 Bytes / 0x3769 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6ff4cfc6 (1878314950)
// size ...... 14185 (0x3769)
// includes .. 19  (offset: 0x320d)
// strings ... 65  (offset: 0x32a5)
// dev strs .. 11  (offset: 0x36e5)
// exports ... 41  (offset: 0x1f11)
// cseg ...... 0x711 + 0x1800 (0x1f11)
// imports ... 94  (offset: 0x2579)
// animtree1 . 0   (offset: 0x3769)
// animtree2 . 0   (offset: 0x3769)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_progress_tracking;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\ai_spawn_director_utility;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_audio;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_util;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_vo;
#using scripts\mp\mp_agent;
#using scripts\mp\ob\systems\ob_humans;

#namespace namespace_c983f7a9bb80191b;

/#

    // Namespace namespace_c983f7a9bb80191b
    // Params 0
    // Checksum 0x7fb91645, Offset: 0x72f
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_c983f7a9bb80191b
// Params 0, eflags: 0x5
// Checksum 0x2541d2b, Offset: 0x73c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_25b41e3ab077cdf8", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_c983f7a9bb80191b
// Params 0, eflags: 0x4
// Checksum 0x6db4e922, Offset: 0x765
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_VIRGO_FREEWAY_DRONE";
    activity_common::registeractivitytype( "OB_VIRGO_FREEWAY_DRONE", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_FREEWAY_DRONE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_FREEWAY_DRONE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_FREEWAY_DRONE", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_c983f7a9bb80191b
// Params 0
// Checksum 0x143842c2, Offset: 0x7c6
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance freeway_drone_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_c983f7a9bb80191b
// Params 0
// Checksum 0x163df555, Offset: 0x82b
// Size: 0x32
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance freeway_drone_main();
}

// Namespace namespace_c983f7a9bb80191b
// Params 0
// Checksum 0xe28e8dba, Offset: 0x865
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

/#

    // Namespace namespace_c983f7a9bb80191b
    // Params 0
    // Checksum 0x3803b255, Offset: 0x889
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_c983f7a9bb80191b
// Params 0
// Checksum 0x15c09da5, Offset: 0x896
// Size: 0x8a
function freeway_drone_start()
{
    level utility::exploder( "fx_freeway_crashsite_bc" );
    level thread utility::exploder( "fx_freeway_crashsite" );
    level thread ob_virgo_util::function_4ec71c3da6905745();
    scene_drone_hack = utility::getstruct( "scene_drone_hack", "targetname" );
    scene_drone_hack thread scene::play( undefined, "Pre-Hack" );
    level thread ob_virgo_util::function_a3d301fb23f69fa2();
    level thread ob_story_mission_utils::function_e6799e9a19df2365( "struct_cache_drone" );
    level thread virgo_vo::freeway_crashsite();
    thread ob_story_mission_utils::item_spawn_weapon( "s_weapon_la_drone", undefined, 1 );
    thread ob_story_mission_utils::item_spawn_equipment( "s_equip_la_drone", undefined, 1 );
}

// Namespace namespace_c983f7a9bb80191b
// Params 0
// Checksum 0x47763824, Offset: 0x928
// Size: 0x135
function freeway_drone_main()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    ob_virgo_util::setup_ui_widget( "OB_VIRGO_FREEWAY_DRONE" );
    level.var_7725eff553b27408 = [];
    level.var_b10f88da15525763 = [];
    scene_crashsite_jets = utility::getstruct( "scene_crashsite_jets", "targetname" );
    scene_crashsite_jets thread ob_virgo_util::function_29164af2d4d89658();
    scene_crashsite_jets thread scene::play();
    thread function_6289d2d47fcde112();
    level utility::flag_wait( "flag_hack_waves_cleared" );
    level utility::flag_set( "flag_drone_hacked" );
    structs = ob_story_mission_utils::get_activity_starts( "OB_VIRGO_JAPAN_INTRO" );
    level thread coop::play_cinematic( "sat_cin_virgo_enter_japan_void_1", { #var_30215d8ee868ab1b:0, #var_bc9975ee52154653:0, #noregroup:1, #timeout:108, #flag:"flag_void_1_bink_done", #structs:structs } );
    level thread utility::kill_exploder( "fx_freeway_crashsite" );
    setdvar( @"hash_8adcf05d62fe94fd", 0.55 );
    level utility::flag_wait( "flag_void_1_bink_done" );
    level thread ob_virgo_util::function_fdd5b4c27ba17b79( "light", 1 );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_c983f7a9bb80191b
// Params 0
// Checksum 0xb9bfa178, Offset: 0xa65
// Size: 0x76
function function_8ed6ced46dc847fd()
{
    wait 30;
    level utility::flag_set( "flag_drone_hack_30_secs" );
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
    
    wait 30;
    level utility::flag_set( "flag_drone_hack_60_secs" );
    
    /#
        iprintlnbold( "<dev string:x33>" );
    #/
    
    wait 30;
    level utility::flag_set( "flag_drone_hack_90_secs" );
    
    /#
        iprintlnbold( "<dev string:x42>" );
    #/
    
    wait 30;
    level utility::flag_set( "flag_drone_hack_120_secs" );
    
    /#
        iprintlnbold( "<dev string:x51>" );
    #/
}

// Namespace namespace_c983f7a9bb80191b
// Params 4
// Checksum 0x5d1c610f, Offset: 0xae3
// Size: 0xa4
function function_fc8c0527d55d12e9( requestid, instance, agent, ai_data )
{
    agent endon( #"death" );
    level.var_f64ddd1c18a54aa3[ level.var_f64ddd1c18a54aa3.size ] = agent;
    agent thread function_e6fe6baa2a7fbd57();
    wait 15;
    vols = getnoentvolumearray( "dronesite_push_vol", "targetname" );
    agent setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait_or_timeout( "drone_hack_wave_01_count_low", 10 );
    vols = getnoentvolumearray( "dronesite_center_push_vol", "targetname" );
    agent setgoalvolumeauto( vols[ 0 ] );
}

// Namespace namespace_c983f7a9bb80191b
// Params 0
// Checksum 0xcd2a7616, Offset: 0xb8f
// Size: 0x79
function function_6ba11b9cabc6e01d()
{
    self endon( #"death" );
    level.var_f64ddd1c18a54aa3[ level.var_f64ddd1c18a54aa3.size ] = self;
    thread function_e6fe6baa2a7fbd57();
    wait 15;
    vols = getnoentvolumearray( "dronesite_push_vol", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait_or_timeout( "drone_hack_wave_01_count_low", 10 );
    vols = getnoentvolumearray( "dronesite_center_push_vol", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
}

// Namespace namespace_c983f7a9bb80191b
// Params 0
// Checksum 0x7524bf7, Offset: 0xc10
// Size: 0x76
function function_f846a21d5ad34bf4()
{
    self endon( #"death" );
    level.var_df3c3675eaa4afbe[ level.var_df3c3675eaa4afbe.size ] = self;
    thread function_e6fe6baa2a7fbd57();
    vols = getnoentvolumearray( "dronesite_push_vol", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait_or_timeout( "drone_hack_wave_02_count_low", 15 );
    vols = getnoentvolumearray( "dronesite_center_push_vol", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
}

// Namespace namespace_c983f7a9bb80191b
// Params 0
// Checksum 0x417a5f74, Offset: 0xc8e
// Size: 0x76
function function_8a7c0d5a4d474a0f()
{
    self endon( #"death" );
    level.var_987495033b2bf3e9[ level.var_987495033b2bf3e9.size ] = self;
    thread function_e6fe6baa2a7fbd57();
    vols = getnoentvolumearray( "dronesite_push_vol", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait_or_timeout( "drone_hack_wave_03_count_low", 15 );
    vols = getnoentvolumearray( "dronesite_center_push_vol", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
}

// Namespace namespace_c983f7a9bb80191b
// Params 3
// Checksum 0x8593bfff, Offset: 0xd0c
// Size: 0x48
function function_9b9f341faf23b3f3( requestid, userdata, shutdowndata )
{
    /#
        iprintln( "<dev string:x61>" );
    #/
    
    level utility::flag_set( "drone_hack_wave_01_cleared" );
    ai_spawn_director::cancel_spawn_request( level.ai_e_drone_hack_wave_01 );
}

// Namespace namespace_c983f7a9bb80191b
// Params 3
// Checksum 0x8abe9f4a, Offset: 0xd5c
// Size: 0x48
function function_e7ee4f425c3096a4( requestid, userdata, shutdowndata )
{
    /#
        iprintln( "<dev string:x88>" );
    #/
    
    level utility::flag_set( "drone_hack_wave_02_cleared" );
    ai_spawn_director::cancel_spawn_request( level.ai_e_drone_hack_wave_02 );
}

// Namespace namespace_c983f7a9bb80191b
// Params 4
// Checksum 0xb360d59a, Offset: 0xdac
// Size: 0xa1
function function_46077798dcd16a5a( requestid, instance, agent, ai_data )
{
    agent endon( #"death" );
    level.var_df3c3675eaa4afbe[ level.var_df3c3675eaa4afbe.size ] = agent;
    agent thread function_e6fe6baa2a7fbd57();
    vols = getnoentvolumearray( "dronesite_push_vol", "targetname" );
    agent setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait_or_timeout( "drone_hack_wave_02_count_low", 15 );
    vols = getnoentvolumearray( "dronesite_center_push_vol", "targetname" );
    agent setgoalvolumeauto( vols[ 0 ] );
}

// Namespace namespace_c983f7a9bb80191b
// Params 3
// Checksum 0xdc6dc049, Offset: 0xe55
// Size: 0x2b
function function_f8c794ea7e321652( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_hack_wave_02_spawned" );
}

// Namespace namespace_c983f7a9bb80191b
// Params 3
// Checksum 0x81cb4bc6, Offset: 0xe88
// Size: 0x60
function hack_wave_02_progress_tracker( requestid, activity_instance, agent )
{
    level.var_df3c3675eaa4afbe = utility::array_removedead_or_dying( level.var_df3c3675eaa4afbe );
    
    if ( level.var_df3c3675eaa4afbe.size < 2 )
    {
        /#
            iprintlnbold( "<dev string:xaf>" );
        #/
        
        level utility::flag_set( "drone_hack_wave_02_count_low" );
    }
}

// Namespace namespace_c983f7a9bb80191b
// Params 4
// Checksum 0xe94b4635, Offset: 0xef0
// Size: 0xa1
function function_ffbc45b8e895ef4f( requestid, instance, agent, ai_data )
{
    agent endon( #"death" );
    level.var_987495033b2bf3e9[ level.var_987495033b2bf3e9.size ] = agent;
    agent thread function_e6fe6baa2a7fbd57();
    vols = getnoentvolumearray( "dronesite_push_vol", "targetname" );
    agent setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait_or_timeout( "drone_hack_wave_03_count_low", 15 );
    vols = getnoentvolumearray( "dronesite_center_push_vol", "targetname" );
    agent setgoalvolumeauto( vols[ 0 ] );
}

// Namespace namespace_c983f7a9bb80191b
// Params 3
// Checksum 0x657e459b, Offset: 0xf99
// Size: 0x2b
function function_e019bb1187124b1f( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_hack_wave_03_spawned" );
}

// Namespace namespace_c983f7a9bb80191b
// Params 3
// Checksum 0x9602953, Offset: 0xfcc
// Size: 0x60
function hack_wave_03_progress_tracker( requestid, activity_instance, agent )
{
    level.var_987495033b2bf3e9 = utility::array_removedead_or_dying( level.var_987495033b2bf3e9 );
    
    if ( level.var_987495033b2bf3e9.size < 2 )
    {
        /#
            iprintlnbold( "<dev string:xca>" );
        #/
        
        level utility::flag_set( "drone_hack_wave_03_count_low" );
    }
}

// Namespace namespace_c983f7a9bb80191b
// Params 3
// Checksum 0x8fa580d9, Offset: 0x1034
// Size: 0x48
function function_ab5f41b49b00846d( requestid, userdata, shutdowndata )
{
    /#
        iprintln( "<dev string:xe5>" );
    #/
    
    level utility::flag_set( "drone_hack_wave_03_cleared" );
    ai_spawn_director::cancel_spawn_request( level.ai_e_drone_hack_wave_03 );
}

// Namespace namespace_c983f7a9bb80191b
// Params 0
// Checksum 0xe8b93e6a, Offset: 0x1084
// Size: 0x86
function function_e6fe6baa2a7fbd57()
{
    if ( level.players.size >= 3 )
    {
        level utility::flag_wait( "all_drone_juggers_dead" );
    }
    else
    {
        level utility::flag_wait( "jugger_01_dead" );
    }
    
    if ( ob::nightmare() )
    {
        level utility::flag_wait( "flag_drone_defend_nm_dead" );
    }
    
    wait 1.5;
    wait randomfloatrange( 0.1, 0.3 );
    
    if ( isalive( self ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
        agent_utils::despawnagent();
    }
}

// Namespace namespace_c983f7a9bb80191b
// Params 4
// Checksum 0x5af9912e, Offset: 0x1112
// Size: 0x89
function function_57061e5f8ff4c490( requestid, instance, agent, ai_data )
{
    agent endon( #"death" );
    level.var_a6e5c93114f8b624[ level.var_a6e5c93114f8b624.size ] = agent;
    level utility::flag_wait( "flag_cradle_wave_done" );
    wait randomfloatrange( 0, 0.25 );
    playfx( level._effect[ "enemy_death_cleanup" ], agent.origin );
    agent kill();
}

// Namespace namespace_c983f7a9bb80191b
// Params 3
// Checksum 0xfce6d027, Offset: 0x11a3
// Size: 0x2b
function function_c2782fb282b54f70( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_hack_wave_04_spawned" );
}

// Namespace namespace_c983f7a9bb80191b
// Params 3
// Checksum 0x94e4de20, Offset: 0x11d6
// Size: 0x48
function function_2316fc3d6f6f9a96( requestid, userdata, shutdowndata )
{
    /#
        iprintln( "<dev string:x10c>" );
    #/
    
    level utility::flag_set( "drone_hack_wave_04_cleared" );
    ai_spawn_director::cancel_spawn_request( level.ai_e_drone_hack_wave_04 );
}

// Namespace namespace_c983f7a9bb80191b
// Params 3
// Checksum 0xd9819754, Offset: 0x1226
// Size: 0x2b
function function_e478f137ac70c3f8( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_drone_crash_path_guild_spawned" );
}

// Namespace namespace_c983f7a9bb80191b
// Params 3
// Checksum 0xcc28487e, Offset: 0x1259
// Size: 0x2b
function function_c70821c518909301( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_hack_wave_01_spawned" );
}

// Namespace namespace_c983f7a9bb80191b
// Params 3
// Checksum 0xc347ea38, Offset: 0x128c
// Size: 0x60
function hack_wave_01_progress_tracker( requestid, activity_instance, agent )
{
    level.var_f64ddd1c18a54aa3 = utility::array_removedead_or_dying( level.var_f64ddd1c18a54aa3 );
    
    if ( level.var_f64ddd1c18a54aa3.size < 2 )
    {
        /#
            iprintlnbold( "<dev string:x133>" );
        #/
        
        level utility::flag_set( "drone_hack_wave_01_count_low" );
    }
}

// Namespace namespace_c983f7a9bb80191b
// Params 0
// Checksum 0xd4b39aab, Offset: 0x12f4
// Size: 0x111
function function_6289d2d47fcde112()
{
    level thread function_8ed6ced46dc847fd();
    level thread virgo_audio::function_24dd5d8313d8c9f9();
    hack_wave_01();
    hack_wave_02();
    thread hack_wave_03();
    
    if ( level.players.size >= 3 )
    {
        level utility::flag_wait( "all_drone_juggers_dead" );
    }
    else
    {
        level utility::flag_wait( "jugger_01_dead" );
        level utility::flag_set( "play_single_titan_dead_vo" );
    }
    
    foreach ( player in level.players )
    {
        player playrumbleonentity( "damage_heavy" );
    }
    
    if ( !ob::nightmare() )
    {
        level thread ob_virgo_util::function_fdd5b4c27ba17b79( "light" );
    }
    
    level utility::flag_set( "flag_defend_waves_done" );
    wait 7;
    level utility::flag_set( "flag_hack_waves_cleared" );
}

// Namespace namespace_c983f7a9bb80191b
// Params 0
// Checksum 0x19d11dd8, Offset: 0x140d
// Size: 0x1f8
function hack_wave_01()
{
    foreach ( player in level.players )
    {
        player playrumbleonentity( "damage_heavy" );
        waitframe();
        player playrumbleonentity( "damage_heavy" );
    }
    
    level thread ob_virgo_util::function_fdd5b4c27ba17b79( "light" );
    level.var_f64ddd1c18a54aa3 = [];
    level.ai_e_drone_hack_wave_01 = ai_spawn_director::lookup_spawn_request( "ai_e_drone_hack_wave_01" );
    level.ai_e_drone_hack_wave_01 = activity_ai_encounters::function_92b671064b0b1ce2( "ai_e_drone_hack_wave_01", 1, 1, 1, 1 );
    function_ef57f478f96b050c( level.ai_e_drone_hack_wave_01, 1 );
    ai_spawn_director::add_spawned_callback( level.ai_e_drone_hack_wave_01, &function_fc8c0527d55d12e9 );
    ai_spawn_director::function_a49c35b72d6b6fea( level.ai_e_drone_hack_wave_01, &function_9b9f341faf23b3f3 );
    activity_ai_encounters::function_6bf4ff2fbde584ee( level.ai_e_drone_hack_wave_01, &function_c70821c518909301, self );
    
    if ( level.players.size >= 3 )
    {
        hack_wave_01_enemies_coop = ai_spawn_director::array_spawn_targetname( "hack_wave_01_enemies_coop" );
        
        foreach ( var_1d247cf3288a46b1 in hack_wave_01_enemies_coop )
        {
            var_1d247cf3288a46b1 thread function_6ba11b9cabc6e01d();
        }
    }
    
    level utility::flag_set( "drone_defend_wave_1_vo" );
    level utility::flag_wait( "flag_hack_wave_01_spawned" );
    activity_progress_tracking::function_82d854bb84c20512( "hack_wave_01_progress_tracker", level.var_f64ddd1c18a54aa3, &hack_wave_01_progress_tracker );
    level utility::flag_wait( "drone_hack_wave_01_count_low" );
}

// Namespace namespace_c983f7a9bb80191b
// Params 0
// Checksum 0x2e559cde, Offset: 0x160d
// Size: 0x1eb
function hack_wave_02()
{
    foreach ( player in level.players )
    {
        player playrumbleonentity( "damage_heavy" );
    }
    
    level thread ob_virgo_util::function_fdd5b4c27ba17b79( "light" );
    level.var_df3c3675eaa4afbe = [];
    level.ai_e_drone_hack_wave_02 = ai_spawn_director::lookup_spawn_request( "ai_e_drone_hack_wave_02" );
    level.ai_e_drone_hack_wave_02 = activity_ai_encounters::function_92b671064b0b1ce2( "ai_e_drone_hack_wave_02", 1, 1, 1, 1 );
    function_ef57f478f96b050c( level.ai_e_drone_hack_wave_02, 1 );
    ai_spawn_director::add_spawned_callback( level.ai_e_drone_hack_wave_02, &function_46077798dcd16a5a );
    ai_spawn_director::function_a49c35b72d6b6fea( level.ai_e_drone_hack_wave_02, &function_e7ee4f425c3096a4 );
    activity_ai_encounters::function_6bf4ff2fbde584ee( level.ai_e_drone_hack_wave_02, &function_f8c794ea7e321652, self );
    
    if ( level.players.size >= 3 )
    {
        hack_wave_02_enemies_coop = ai_spawn_director::array_spawn_targetname( "hack_wave_02_enemies_coop" );
        
        foreach ( var_532d6e3b6062abb2 in hack_wave_02_enemies_coop )
        {
            var_532d6e3b6062abb2 thread function_f846a21d5ad34bf4();
        }
    }
    
    level utility::flag_set( "drone_defend_wave_2_vo" );
    level utility::flag_wait( "flag_hack_wave_02_spawned" );
    activity_progress_tracking::function_82d854bb84c20512( "hack_wave_02_progress_tracker", level.var_df3c3675eaa4afbe, &hack_wave_02_progress_tracker );
    level utility::flag_wait( "drone_hack_wave_02_count_low" );
}

// Namespace namespace_c983f7a9bb80191b
// Params 0
// Checksum 0x37f9f80f, Offset: 0x1800
// Size: 0x467
function hack_wave_03()
{
    foreach ( player in level.players )
    {
        player playrumbleonentity( "damage_heavy" );
    }
    
    level thread ob_virgo_util::function_fdd5b4c27ba17b79( "light" );
    level.var_987495033b2bf3e9 = [];
    scene_crashsite_jugger = utility::getstruct( "scene_crashsite_jugger", "targetname" );
    ai_juggernaut = mp_agent::spawnnewagentaitype( "sat_ob_enemy_cradle_specialist_jugg_minigun", scene_crashsite_jugger.origin, scene_crashsite_jugger.angles, "team_hundred_ninety" );
    ai_juggernaut.animname = "heavy_ai";
    scene_crashsite_jugger thread scene::play( ai_juggernaut );
    ai_juggernaut thread function_9f0661cb57a628a0();
    ai_juggernaut thread function_e7fbdb899c10ea01();
    anchor_ai = ai_juggernaut;
    hack_wave_03_tether_enemies = ai_spawn_director::array_spawn_targetname( "hack_wave_03_tether_enemies" );
    tether_ai = [];
    
    foreach ( guy in hack_wave_03_tether_enemies )
    {
        tether_ai[ tether_ai.size ] = guy;
    }
    
    ob_humans::function_6198eaa0deba2b53( anchor_ai, tether_ai );
    
    if ( level.players.size >= 3 )
    {
        wait 0.5;
        scene_crashsite_jugger_02 = utility::getstruct( "scene_crashsite_jugger_02", "targetname" );
        var_d5261789804253d0 = mp_agent::spawnnewagentaitype( "sat_ob_enemy_cradle_specialist_jugg_minigun", scene_crashsite_jugger_02.origin, scene_crashsite_jugger_02.angles, "team_hundred_ninety" );
        var_d5261789804253d0.animname = "heavy_ai";
        scene_crashsite_jugger_02 thread scene::play( var_d5261789804253d0 );
        var_d5261789804253d0 thread function_77a434ca414332f();
        var_d5261789804253d0 thread function_e7fbdb899c10ea01();
        anchor_ai = var_d5261789804253d0;
        hack_wave_03_tether_enemies_coop = ai_spawn_director::array_spawn_targetname( "hack_wave_03_tether_enemies_coop" );
        tether_ai = [];
        
        foreach ( guy in hack_wave_03_tether_enemies_coop )
        {
            tether_ai[ tether_ai.size ] = guy;
        }
        
        ob_humans::function_6198eaa0deba2b53( anchor_ai, tether_ai );
    }
    
    level utility::flag_set( "flag_play_heavy_ai_vo" );
    level thread function_417299745f2d8069();
    wait 2.5;
    nm_vols = getnoentvolumearray( "dronesite_push_vol", "targetname" );
    nm_struct = utility::getstruct( "s_gdu_crashsite_reinforcement_01", "targetname" );
    level.ai_e_drone_hack_wave_03 = ai_spawn_director::lookup_spawn_request( "ai_e_drone_hack_wave_03" );
    level.ai_e_drone_hack_wave_03 = activity_ai_encounters::function_92b671064b0b1ce2( "ai_e_drone_hack_wave_03", 1, 1, 1, 1 );
    function_ef57f478f96b050c( level.ai_e_drone_hack_wave_03, 1 );
    ai_spawn_director::add_vehicle_spawned_callback( level.ai_e_drone_hack_wave_03, &function_76a995e2f2dec0cf );
    ai_spawn_director::add_spawned_callback( level.ai_e_drone_hack_wave_03, &function_ffbc45b8e895ef4f );
    ai_spawn_director::function_a49c35b72d6b6fea( level.ai_e_drone_hack_wave_03, &function_ab5f41b49b00846d );
    activity_ai_encounters::function_6bf4ff2fbde584ee( level.ai_e_drone_hack_wave_03, &function_e019bb1187124b1f, self );
    
    if ( level.players.size >= 3 )
    {
        hack_wave_03_enemies_coop = ai_spawn_director::array_spawn_targetname( "hack_wave_03_enemies_coop" );
        
        foreach ( var_532d6e3b6062abb2 in hack_wave_03_enemies_coop )
        {
            var_532d6e3b6062abb2 thread function_8a7c0d5a4d474a0f();
        }
    }
    
    level utility::flag_wait( "flag_hack_wave_03_spawned" );
    activity_progress_tracking::function_82d854bb84c20512( "hack_wave_03_progress_tracker", level.var_987495033b2bf3e9, &hack_wave_03_progress_tracker );
}

// Namespace namespace_c983f7a9bb80191b
// Params 3
// Checksum 0x9e7ea771, Offset: 0x1c6f
// Size: 0x112
function function_76a995e2f2dec0cf( requestid, userdata, vtol )
{
    data = function_9b649316adcccbaa( requestid );
    encounter_ai = ai_spawn_director::function_5d069e637e2d0a05( requestid );
    tether_ai = [];
    anchor_ai = undefined;
    
    foreach ( agent in encounter_ai )
    {
        if ( isalive( agent ) && agent.subclass == "ob_specop_bot" )
        {
            anchor_ai = agent;
            continue;
        }
        
        if ( isalive( agent ) )
        {
            tether_ai[ tether_ai.size ] = agent;
        }
    }
    
    if ( anchor_ai && tether_ai )
    {
        ob_humans::function_6198eaa0deba2b53( anchor_ai, tether_ai );
        
        /#
        #/
        
        return;
    }
    
    /#
    #/
}

// Namespace namespace_c983f7a9bb80191b
// Params 0
// Checksum 0x27f092e0, Offset: 0x1d89
// Size: 0x59
function function_e7fbdb899c10ea01()
{
    self endon( #"death" );
    vols = getnoentvolumearray( "dronesite_push_vol", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait_or_timeout( "drone_hack_wave_03_count_low", 10 );
    vols = getnoentvolumearray( "dronesite_center_push_vol", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
}

// Namespace namespace_c983f7a9bb80191b
// Params 0
// Checksum 0x2373c948, Offset: 0x1dea
// Size: 0x1c
function function_9f0661cb57a628a0()
{
    self waittill( #"death" );
    level utility::flag_set( "jugger_01_dead" );
}

// Namespace namespace_c983f7a9bb80191b
// Params 0
// Checksum 0x2b68bc05, Offset: 0x1e0e
// Size: 0x1c
function function_77a434ca414332f()
{
    self waittill( #"death" );
    level utility::flag_set( "jugger_02_dead" );
}

// Namespace namespace_c983f7a9bb80191b
// Params 0
// Checksum 0x470ab9a5, Offset: 0x1e32
// Size: 0x21
function function_417299745f2d8069()
{
    level utility::flag_wait_all( "jugger_01_dead", "jugger_02_dead" );
    level utility::flag_set( "all_drone_juggers_dead" );
}

// Namespace namespace_c983f7a9bb80191b
// Params 0
// Checksum 0x2cce11e0, Offset: 0x1e5b
// Size: 0xb6
function hack_wave_04()
{
    level utility::flag_wait( "drone_hack_wave_03_count_low" );
    level.var_a6e5c93114f8b624 = [];
    level.ai_e_drone_hack_wave_04 = ai_spawn_director::lookup_spawn_request( "ai_e_drone_hack_wave_04" );
    level.ai_e_drone_hack_wave_04 = activity_ai_encounters::function_92b671064b0b1ce2( "ai_e_drone_hack_wave_04", 1, 1, 1, 1 );
    function_ef57f478f96b050c( level.ai_e_drone_hack_wave_04, 1 );
    ai_spawn_director::add_spawned_callback( level.ai_e_drone_hack_wave_04, &function_57061e5f8ff4c490 );
    ai_spawn_director::function_a49c35b72d6b6fea( level.ai_e_drone_hack_wave_04, &function_2316fc3d6f6f9a96 );
    activity_ai_encounters::function_6bf4ff2fbde584ee( level.ai_e_drone_hack_wave_04, &function_c2782fb282b54f70, self );
    level utility::flag_wait( "flag_hack_wave_04_spawned" );
    wait 15;
    level utility::flag_set( "flag_cradle_wave_done" );
}

