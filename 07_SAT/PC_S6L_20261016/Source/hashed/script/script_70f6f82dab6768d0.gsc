// script_70f6f82dab6768d0  (hash_70f6f82dab6768d0.gscc) (size: 17276 Bytes / 0x437c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x76eecd87 (1995361671)
// size ...... 17276 (0x437c)
// includes .. 18  (offset: 0x3dbc)
// strings ... 83  (offset: 0x3e4c)
// dev strs .. 0   (offset: 0x437c)
// exports ... 28  (offset: 0x27d4)
// cseg ...... 0x82c + 0x1fa8 (0x27d4)
// imports ... 141 (offset: 0x2c34)
// animtree1 . 0   (offset: 0x437c)
// animtree2 . 0   (offset: 0x437c)
#using script_187126f2318df171;
#using script_4d6ddd547bcd9399;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\puzzles\connection_puzzle;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\interaction;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_audio;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_lighting;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_util;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_vo;

#namespace namespace_abbef56318e51c26;

/#

    // Namespace namespace_abbef56318e51c26
    // Params 0
    // Checksum 0xdcdc1378, Offset: 0x84a
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_abbef56318e51c26
// Params 0, eflags: 0x5
// Checksum 0x9cc116ff, Offset: 0x857
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_f85efbe63099eab1", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_abbef56318e51c26
// Params 0, eflags: 0x4
// Checksum 0x7cb6ea9, Offset: 0x880
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LIBRA_PROCESSING_PUMP";
    activity_common::registeractivitytype( "OB_LIBRA_PROCESSING_PUMP", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_PROCESSING_PUMP", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_PROCESSING_PUMP", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_PROCESSING_PUMP", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_abbef56318e51c26
// Params 0
// Checksum 0x85bddb5f, Offset: 0x8e1
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance start_func();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_abbef56318e51c26
// Params 0
// Checksum 0xd3dfeaee, Offset: 0x946
// Size: 0x3d
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    activity_instance thread main_func();
}

// Namespace namespace_abbef56318e51c26
// Params 0
// Checksum 0x41eb8887, Offset: 0x98b
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_abbef56318e51c26
// Params 0
// Checksum 0x7d0173d5, Offset: 0x9af
// Size: 0xe
function setup_ui_widget()
{
    ob_story_mission_utils::objective_text_show( "OB_LIBRA_PROCESSING_PUMP" );
}

/#

    // Namespace namespace_abbef56318e51c26
    // Params 0
    // Checksum 0x9b66b768, Offset: 0x9c5
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_abbef56318e51c26
// Params 0
// Checksum 0x4c542ae1, Offset: 0x9d2
// Size: 0xc4
function start_func()
{
    mp_sat_ob_libra_util::function_8f97ea6ececa5d();
    namespace_23a5805143aa7eed::init_sphere_pos( "sphere_raise_pos" );
    activateworldevent( "LGT_PROC_DESIGN" );
    thread mp_sat_ob_libra_lighting::function_2bd21e5bfd850bd0();
    thread mp_sat_ob_libra_lighting::function_288d889fb17fd166();
    level.cradle_sphere thread mp_sat_ob_libra_lighting::function_70a171f22b600bac();
    level thread function_e8b8f14b227b3c43();
    thread mp_sat_ob_libra_util::function_3404036aa1432445( "proc_pump_room_door" );
    thread namespace_eee6457f670d8545::function_2fd33a3b1faebfe0();
    level thread mp_sat_ob_libra_util::function_2bc2cecd260a5613( [ "hoist_interact_scene_a", "hoist_interact_scene_b" ] );
    thread mp_sat_ob_libra_util::function_7c6f64dfa8ae940c();
    thread mp_sat_ob_libra_util::function_3404036aa1432445( "processing_alt_door", 1, 0, 1 );
    utility::flag_set( "processing_last_phase" );
    level thread mp_sat_ob_libra_util::function_32b80bf22f39a811( "processing_fan", "roll", 2, "flag_boss_intro_regroup_countdown_finished", %"electronics_fan_box_lg_01_blade" );
    level thread mp_sat_ob_libra_util::function_9886d86be8c62744();
}

// Namespace namespace_abbef56318e51c26
// Params 0, eflags: 0x4
// Checksum 0xa8885584, Offset: 0xa9e
// Size: 0x1b
function private function_e8b8f14b227b3c43()
{
    level utility::flag_wait( "scriptables_ready" );
    thread mp_sat_ob_libra_util::function_3404036aa1432445( "processing_main_door" );
}

// Namespace namespace_abbef56318e51c26
// Params 0
// Checksum 0x7ef0c9b4, Offset: 0xac1
// Size: 0xe9
function main_func()
{
    thread function_52d6330a30d7b596();
    function_398bc9ee922d91fd( "BossPressure", 0 );
    level thread libra_audio::function_fb418899097f8fb7();
    sight_blocker = getent( "sight_blocker", "targetname" );
    
    if ( isdefined( sight_blocker ) )
    {
        sight_blocker solid();
    }
    
    connection_puzzle_init();
    puzzle_struct = utility::getstruct( "pump_interact_a", "targetname" );
    puzzle_struct thread ob_story_mission_utils::function_e89ed2a08ce38bbf( "pump_console", level.connection_puzzle_asset );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    setup_ui_widget();
    level thread mp_sat_ob_libra_util::cooling_pool_hurt_trigger();
    mp_sat_ob_libra_vo::pump_intro();
    thread spawn_grunts();
    thread function_4ed930991c7d358d();
    utility::flag_wait_all( "pump_a_done", "pump_b_done" );
    puzzle_struct thread ob_story_mission_utils::remove_connection_puzzle_streaming_volume();
    mp_sat_ob_libra_vo::pressure_critical();
    function_a8f3e645c67a8330();
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_abbef56318e51c26
// Params 0
// Checksum 0x4d265740, Offset: 0xbb2
// Size: 0x41
function setup_pressure_gauge()
{
    level.var_e04c0425c57a325 = {};
    level.var_e04c0425c57a325.health = 0;
    level.var_e04c0425c57a325.maxhealth = 100;
    ob_story_mission_utils::function_315d79883d962ba7( 0, 100 );
}

// Namespace namespace_abbef56318e51c26
// Params 2
// Checksum 0xb9290041, Offset: 0xbfb
// Size: 0x179
function function_3f52c8dcdc152260( additional_pressure, time )
{
    level notify( #"hash_d9d479702b3e9447" );
    level endon( #"hash_d9d479702b3e9447" );
    level endon( #"hash_f139803f5753c3d1" );
    
    while ( !isdefined( level.var_e04c0425c57a325.health ) )
    {
        waitframe();
    }
    
    steps = time * 2;
    health_step = additional_pressure / steps;
    health_float = level.var_e04c0425c57a325.health;
    previous_health = level.var_e04c0425c57a325.health;
    level thread libra_audio::function_e8b498a5e90c78af();
    
    for ( i = 0; i <= steps ; i++ )
    {
        health_float += health_step;
        function_ff8390ef483c9364( previous_health, level.var_e04c0425c57a325.health );
        wait 0.25;
        
        if ( utility::flag( "pump_pressure_complete" ) )
        {
            return;
        }
        
        level.var_e04c0425c57a325.health = int( health_float );
        ob_story_mission_utils::function_315d79883d962ba7( level.var_e04c0425c57a325.health, 100 );
        libra_audio::function_1de68d9f3cdb878d();
        function_ff8390ef483c9364( previous_health, level.var_e04c0425c57a325.health );
        previous_health = level.var_e04c0425c57a325.health;
        wait 0.25;
    }
}

// Namespace namespace_abbef56318e51c26
// Params 2
// Checksum 0xc9c577a1, Offset: 0xd7c
// Size: 0x6c
function function_ff8390ef483c9364( var_fb2f98f9e8f799fa, new_health )
{
    if ( var_fb2f98f9e8f799fa < 25 && new_health >= 25 )
    {
        level notify( #"hash_636aae69f2173d8f" );
    }
    
    if ( var_fb2f98f9e8f799fa < 50 && new_health >= 50 )
    {
        level notify( #"hash_b6ddec61831339a3" );
    }
    
    if ( var_fb2f98f9e8f799fa < 75 && new_health >= 75 )
    {
        level notify( #"hash_da7d2c131250d9fa" );
    }
}

// Namespace namespace_abbef56318e51c26
// Params 0
// Checksum 0x50ee3771, Offset: 0xdf0
// Size: 0x24
function function_a8f3e645c67a8330()
{
    level notify( #"hash_f139803f5753c3d1" );
    utility::flag_set( "pump_pressure_complete" );
    level.var_e04c0425c57a325 = undefined;
}

// Namespace namespace_abbef56318e51c26
// Params 0
// Checksum 0xa2d9f0bb, Offset: 0xe1c
// Size: 0x41
function function_aeb815305731650e()
{
    if ( !isdefined( level.var_bddf5b7a6b428f58 ) )
    {
        level.var_bddf5b7a6b428f58 = 0;
    }
    
    if ( level.var_bddf5b7a6b428f58 == 0 )
    {
        mp_sat_ob_libra_vo::pressure_25();
    }
    else
    {
        mp_sat_ob_libra_vo::pressure_75();
    }
    
    level.var_bddf5b7a6b428f58++;
}

// Namespace namespace_abbef56318e51c26
// Params 0
// Checksum 0xece0a9b1, Offset: 0xe65
// Size: 0x109
function function_4ed930991c7d358d()
{
    thread function_43378e83ed6de7ef();
    handle_pump_console( "pump_interact_b", "pump_b_done", "pump_a_puzzle", "terminal_interact_scene_b", "pump_intro_vo_done" );
    level notify( #"hash_2bcddc421db4c94" );
    mp_sat_ob_libra_vo::pressure_50();
    level notify( #"hash_2a0dcc7eeca909ad" );
    consoles = getscriptablearray( "proc_pressure_console", "targetname" );
    
    foreach ( var_190f59357d8260f7 in consoles )
    {
        var_190f59357d8260f7 setscriptablepartstate( #"base", #"circuit_interrupted" );
    }
    
    utility::flag_set( "pump_enemies_lull" );
    handle_pump_console( "pump_interact_a", "pump_a_done", "pump_b_puzzle", "terminal_interact_scene_b" );
}

// Namespace namespace_abbef56318e51c26
// Params 0
// Checksum 0xcbb4bf4a, Offset: 0xf76
// Size: 0x419
function function_43378e83ed6de7ef()
{
    var_5ef74561360279e = getscriptbundle( "dtanimtemplate:scene_sat_cin_libra_cradle_meltdown" );
    cradle_sphere = getent( "cradle_sphere", "targetname" );
    thread mp_sat_ob_libra_vo::function_8947cee07a7554a2( "pump_interact_b_used" );
    utility::flag_wait( "pump_interact_b_used" );
    consoles = getscriptablearray( "proc_pressure_console", "targetname" );
    
    foreach ( var_190f59357d8260f7 in consoles )
    {
        var_190f59357d8260f7 utility::delaycall( 1.5, &setscriptablepartstate, #"base", #"circuit_interrupted" );
    }
    
    level thread libra_audio::function_2a58c67eb62af6ef();
    mp_sat_ob_libra_vo::hack_intro();
    utility::flag_set( "pump_intro_vo_done" );
    utility::flag_waitopen( "pump_interact_b_used" );
    
    while ( !utility::flag( "pump_interact_b_on" ) )
    {
        mp_sat_ob_libra_vo::hack_nags( "pump_interact_b_used" );
        utility::flag_waitopen( "pump_interact_b_used" );
    }
    
    setup_pressure_gauge();
    mp_sat_ob_libra_vo::we_are_in();
    wait 2;
    mp_sat_ob_libra_vo::pressure_systems_disabled();
    cradle_sphere thread scene::play( [ cradle_sphere ], "phase_01", "scene_sat_cin_libra_cradle_meltdown" );
    wait 5;
    mp_sat_ob_libra_vo::starting_to_heat_up();
    
    if ( level.players.size > 1 )
    {
        utility::flag_wait( "pump_interact_b_ready" );
        thread mp_sat_ob_libra_vo::function_8947cee07a7554a2( "pump_interact_b_restarted" );
    }
    
    utility::flag_wait( "pump_interact_b_restarted" );
    cradle_sphere thread scene::play( [ cradle_sphere ], "phase_03", "scene_sat_cin_libra_cradle_meltdown" );
    function_a25acb62ddab20e2( "pump_pre_cradle", 0 );
    function_a25acb62ddab20e2( "pump_post_cradle", 1 );
    utility::delaythread( 0.5, &mp_sat_ob_libra_util::function_bf06941991e5f14, cradle_sphere.origin - ( 0, 0, 200 ), "artillery_rumble_heavy", "large" );
    utility::delaythread( 5, &utility::exploder, "libra_processing_meltdown_01_vfx" );
    utility::flag_wait( "pump_b_done" );
    level waittill( #"hash_2a0dcc7eeca909ad" );
    utility::flag_waitopen( "pump_interact_a_used" );
    
    while ( !utility::flag( "pump_interact_a_on" ) )
    {
        mp_sat_ob_libra_vo::function_6eef5d7f759f2d0f( "pump_interact_a_used" );
        utility::flag_waitopen( "pump_interact_a_used" );
    }
    
    mp_sat_ob_libra_vo::pressure_systems_disabled();
    cradle_sphere thread scene::play( [ cradle_sphere ], "phase_03", "scene_sat_cin_libra_cradle_meltdown" );
    utility::delaythread( 0.5, &mp_sat_ob_libra_util::function_bf06941991e5f14, cradle_sphere.origin - ( 0, 0, 200 ), "artillery_rumble_heavy", "large" );
    utility::delaythread( 5, &utility::exploder, "libra_processing_meltdown_02_vfx" );
    utility::delaythread( 2, &mp_sat_ob_libra_vo::pressure_rising_again );
    
    foreach ( player in level.players )
    {
        pbgpostfxbundlestart( player, %"mp_sat_ob_libra_fxgrade_processing_overload" );
    }
    
    if ( level.players.size > 1 )
    {
        utility::flag_wait( "pump_interact_a_ready" );
        thread mp_sat_ob_libra_vo::function_4b06d8d9452f636d( "pump_interact_a_restarted" );
    }
    
    utility::flag_wait( "pump_interact_a_restarted" );
    cradle_sphere thread scene::play( [ cradle_sphere ], "phase_04", "scene_sat_cin_libra_cradle_meltdown" );
    utility::delaythread( 0.5, &mp_sat_ob_libra_util::function_bf06941991e5f14, cradle_sphere.origin - ( 0, 0, 200 ), "artillery_rumble_heavy", "large" );
    utility::delaythread( 5, &utility::exploder, "libra_processing_meltdown_03_vfx" );
    utility::flag_wait( "pump_a_done" );
    utility::delaythread( 5, &utility::exploder, "libra_processing_meltdown_04_vfx" );
}

// Namespace namespace_abbef56318e51c26
// Params 0
// Checksum 0x3f578d6d, Offset: 0x1397
// Size: 0x1e5
function spawn_grunts()
{
    utility::flag_wait( "flag_near_pump_room" );
    requestid = activity_ai_encounters::function_92b671064b0b1ce2( "ai_encounter_libra_processing_pre_wave3", 1, 1, 1, 1 );
    function_ef57f478f96b050c( requestid, 1 );
    activity_ai_encounters::function_d33de057e760c97b( requestid, &function_ddd1413de57b347c );
    level.var_400b44c398b1e1d7[ requestid ] = spawnstruct();
    level.var_400b44c398b1e1d7[ requestid ].fncallback = &function_f5cd2530e9bfc5b;
    level.var_400b44c398b1e1d7[ requestid ].fallback_goal = getnode( "backtrack_retreat_node", #targetname );
    utility::flag_wait( "pump_interact_b_on" );
    function_a25acb62ddab20e2( "pump_pre_cradle", 1 );
    requestid = activity_ai_encounters::function_92b671064b0b1ce2( "ai_encounter_libra_processing_wave3", 1, 1, 1, 1 );
    function_ef57f478f96b050c( requestid, 1 );
    activity_ai_encounters::function_d33de057e760c97b( requestid, &function_ddd1413de57b347c );
    level.var_400b44c398b1e1d7[ requestid ] = spawnstruct();
    level.var_400b44c398b1e1d7[ requestid ].fncallback = &function_f5cd2530e9bfc5b;
    level.var_400b44c398b1e1d7[ requestid ].fallback_goal = getnode( "backtrack_retreat_node", #targetname );
    var_8bda1922db495b = activity_ai_encounters::function_92b671064b0b1ce2( "ai_encounter_libra_processing_wave3_large_squad", 1, 1, 1, 1 );
    function_ef57f478f96b050c( var_8bda1922db495b, 1 );
    activity_ai_encounters::function_d33de057e760c97b( var_8bda1922db495b, &function_ddd1413de57b347c );
    level.var_400b44c398b1e1d7[ var_8bda1922db495b ] = spawnstruct();
    level.var_400b44c398b1e1d7[ var_8bda1922db495b ].fncallback = &function_f5cd2530e9bfc5b;
    level.var_400b44c398b1e1d7[ requestid ].fallback_goal = getnode( "backtrack_retreat_node", #targetname );
    level thread libra_audio::function_d5a3f261295838b1();
    utility::flag_wait_all( "pump_a_done", "pump_b_done" );
    function_42319057a16481e( requestid );
    function_42319057a16481e( var_8bda1922db495b );
}

// Namespace namespace_abbef56318e51c26
// Params 4
// Checksum 0x5dbabf0a, Offset: 0x1584
// Size: 0x136
function function_f5cd2530e9bfc5b( fallback_goal, check_sight, var_adc97ec15b3ff2e8, early_despawn )
{
    self endon( #"death" );
    self.armorhealth = 0;
    newhealth = randomintrange( 1, 30 );
    self.health = newhealth;
    self.maxhealth = newhealth;
    self.grenadeammo = 0;
    
    if ( issubstr( self.classname, "guild_bot" ) || issubstr( self.classname, "_cradle_" ) )
    {
        return;
    }
    
    self.set_forcedgoal = 1;
    self cleargoalentity();
    self cleargoalvolume();
    wait randomfloatrange( 0.1, 2 );
    
    if ( !isalive( self ) || !isdefined( fallback_goal ) )
    {
        return;
    }
    
    self.goalradius = 300;
    self demeanoroverride( "sprint" );
    self setgoalnode( fallback_goal );
    self waittill( #"goal" );
    self.death_source = "despawn";
    self.nocorpse = 1;
    self.var_a13bed1ac47e1b2c = 1;
    self.dropweapon = 0;
    thread agent_utils::despawnagent();
}

// Namespace namespace_abbef56318e51c26
// Params 2
// Checksum 0xe72d47ec, Offset: 0x16c2
// Size: 0x2f, Type: bool
function function_ddd1413de57b347c( requestid, userdata )
{
    return utility::flag( "pump_a_done" ) && utility::flag( "pump_b_done" );
}

// Namespace namespace_abbef56318e51c26
// Params 5
// Checksum 0x310f17a9, Offset: 0x16fa
// Size: 0x31f
function handle_pump_console( var_dc6a4b4b351da087, completed_flag_name, var_490060d47d9e122a, var_4e849c3ae91eb8aa, var_a16566084952fb7e )
{
    pump_restarts = 1;
    pump_delays = [ 20, 20 ];
    
    if ( level.players.size == 1 )
    {
        pump_delays = [ 30, 30 ];
        pump_restarts = 0;
    }
    
    on_flag = var_dc6a4b4b351da087 + "_on";
    ready_flag = var_dc6a4b4b351da087 + "_ready";
    restart_flag = var_dc6a4b4b351da087 + "_restarted";
    used_flag = var_dc6a4b4b351da087 + "_used";
    function_6f45f62c9eacee7d( var_dc6a4b4b351da087, completed_flag_name, var_490060d47d9e122a, var_4e849c3ae91eb8aa, var_a16566084952fb7e );
    utility::flag_wait( on_flag );
    level notify( #"hash_82b12167039fe27f" );
    ob_story_mission_utils::objective_text_show( "ob_libra_processing_pump_pressure" );
    consoles = getscriptablearray( "proc_pressure_console", "targetname" );
    
    for ( i = 0; i < pump_restarts ; i++ )
    {
        thread function_3f52c8dcdc152260( 25, pump_delays[ i ] );
        wait pump_delays[ i ];
        function_aeb815305731650e();
        
        foreach ( var_190f59357d8260f7 in consoles )
        {
            var_190f59357d8260f7 setscriptablepartstate( #"base", #"circuit_interrupted" );
        }
        
        utility::flag_set( ready_flag );
        level thread ob_story_mission_utils::function_56960723e6738b6c( undefined, var_dc6a4b4b351da087, undefined, var_dc6a4b4b351da087 + "_waypoint_done", undefined, undefined, 1, undefined, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 16 ) );
        level thread mp_sat_ob_libra_util::function_776ea74dd9e92d46( restart_flag, var_dc6a4b4b351da087 );
        mp_sat_ob_libra_util::function_c58a10af89e58f3f( var_dc6a4b4b351da087, restart_flag, &"sat_ob_story_missions/interact_activate" );
        ob_story_mission_utils::objective_text_show( "ob_libra_processing_pump" );
        utility::flag_wait( restart_flag );
        ob_story_mission_utils::objective_text_show( "ob_libra_processing_pump_pressure" );
        level notify( #"reactor_reactivated" );
        level thread libra_audio::function_e209a231f05103a1( var_dc6a4b4b351da087 );
        
        foreach ( var_190f59357d8260f7 in consoles )
        {
            var_190f59357d8260f7 setscriptablepartstate( #"base", #"circuit_operational" );
        }
        
        level notify( #"hash_82b12167039fe27f" );
    }
    
    if ( level.players.size == 1 )
    {
        thread function_3f52c8dcdc152260( 50, pump_delays[ i ] );
    }
    else
    {
        thread function_3f52c8dcdc152260( 25, pump_delays[ i ] );
    }
    
    wait pump_delays[ i ] / 2;
    utility::flag_set( restart_flag );
    wait pump_delays[ i ] / 2;
    utility::flag_set( completed_flag_name );
    level notify( #"hash_82b12167039fe27f" );
}

// Namespace namespace_abbef56318e51c26
// Params 5
// Checksum 0x66e34d46, Offset: 0x1a21
// Size: 0x1b3
function function_6f45f62c9eacee7d( var_dc6a4b4b351da087, completed_flag_name, var_490060d47d9e122a, var_4e849c3ae91eb8aa, var_a16566084952fb7e )
{
    button = utility::getstruct( var_dc6a4b4b351da087, "targetname" );
    on_flag = var_dc6a4b4b351da087 + "_on";
    ready_flag = var_dc6a4b4b351da087 + "_ready";
    restart_flag = var_dc6a4b4b351da087 + "_restarted";
    used_flag = var_dc6a4b4b351da087 + "_used";
    var_c65d7af13cce3674 = &"sat_ob_story_missions/interact_hack";
    
    if ( !isdefined( level.var_56953aaf1d2c7314 ) )
    {
        var_c65d7af13cce3674 = &"sat_ob_story_missions/interact_activate";
        level.var_56953aaf1d2c7314 = 1;
    }
    
    ob_story_mission_utils::objective_text_show( "ob_libra_processing_pump" );
    interact = interaction::register_interact( button.origin, 64, &pump_interact, var_c65d7af13cce3674, undefined, undefined, undefined, "HINT_BUTTON" );
    interact.on_flag = on_flag;
    interact.used_flag = used_flag;
    interact.obj_root = self;
    interact.var_4e849c3ae91eb8aa = var_4e849c3ae91eb8aa;
    interact.var_490060d47d9e122a = var_490060d47d9e122a;
    interact.var_dc6a4b4b351da087 = var_dc6a4b4b351da087;
    interact.var_a16566084952fb7e = var_a16566084952fb7e;
    interact sethintdisplayrange( 128 );
    interact sethintdisplayfov( 360 );
    interact setusefov( 45 );
    level thread ob_story_mission_utils::function_56960723e6738b6c( undefined, var_dc6a4b4b351da087, undefined, var_dc6a4b4b351da087 + "_waypoint_done", undefined, undefined, 1, undefined, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 16 ) );
    level thread mp_sat_ob_libra_util::function_776ea74dd9e92d46( used_flag, var_dc6a4b4b351da087 );
}

// Namespace namespace_abbef56318e51c26
// Params 1
// Checksum 0x85aa70ff, Offset: 0x1bdc
// Size: 0x532
function pump_interact( player )
{
    if ( !player val::get( "allow_connection_puzzle" ) )
    {
        return;
    }
    
    if ( isdefined( self.obj_root ) )
    {
        self.obj_root ob_story_mission_utils::objective_marker_clear( self.var_8029d4363972e15 );
    }
    
    utility::flag_set( self.used_flag );
    player thread libra_audio::function_d014452496a2e975();
    self makeunusable();
    skip_puzzle = getdvarint( @"connection_puzzle_skip", 0 );
    consoles = getscriptablearray( "proc_pressure_console", "targetname" );
    
    if ( skip_puzzle != 0 || isautopilot( player ) )
    {
        finished = "ConnectionPuzzleCompleted";
        wait 2;
    }
    else
    {
        player thread mp_sat_ob_libra_util::start_interact_scene( self.var_4e849c3ae91eb8aa );
        
        if ( isdefined( self.var_a16566084952fb7e ) )
        {
            utility::flag_wait( self.var_a16566084952fb7e );
        }
        
        if ( player connection_puzzle::open( level.connection_puzzle_asset, self.var_490060d47d9e122a ) )
        {
            foreach ( var_190f59357d8260f7 in consoles )
            {
                var_190f59357d8260f7 setscriptablepartstate( #"base", #"hash_cacbbd1f76200a42" );
            }
            
            foreach ( spectator in level.players )
            {
                if ( spectator != player )
                {
                    spectator thread connection_puzzle::open( level.connection_puzzle_asset, self.var_490060d47d9e122a, 1 );
                }
            }
            
            if ( level.players.size == 1 )
            {
                thread mp_sat_ob_libra_util::function_3404036aa1432445( "proc_pump_room_door", 1, 1, 1 );
            }
            
            finished = player utility::waittill_any_return( "ConnectionPuzzleClosed", "ConnectionPuzzleCompleted", "death_or_disconnect" );
            
            if ( level.players.size == 1 )
            {
                utility::delaythread( 2, &mp_sat_ob_libra_util::function_3404036aa1432445, "proc_pump_room_door", 0, 1, 1 );
            }
            
            foreach ( p in level.players )
            {
                if ( p != player )
                {
                    p connection_puzzle::close_spectator( level.connection_puzzle_asset, self.var_490060d47d9e122a );
                }
            }
        }
        
        if ( player )
        {
            player mp_sat_ob_libra_util::function_d68eec31414afe2e( self.var_4e849c3ae91eb8aa );
        }
    }
    
    utility::flag_clear( self.used_flag );
    
    if ( finished == "ConnectionPuzzleCompleted" || connection_puzzle::is_instance_complete( level.connection_puzzle_asset, self.var_490060d47d9e122a ) )
    {
        utility::flag_set( self.on_flag );
        
        foreach ( var_190f59357d8260f7 in consoles )
        {
            var_190f59357d8260f7 setscriptablepartstate( #"base", #"circuit_operational" );
        }
        
        player connection_puzzle::close();
        wait 1;
        utility::flag_clear( "pump_enemies_lull" );
        iprintlnbold( "BIOREACTOR PRESSURE INCREASING" );
        return;
    }
    
    thread function_6f45f62c9eacee7d( self.var_dc6a4b4b351da087, self.on_flag, self.var_490060d47d9e122a, self.var_4e849c3ae91eb8aa );
    
    foreach ( var_190f59357d8260f7 in consoles )
    {
        var_190f59357d8260f7 setscriptablepartstate( #"base", #"circuit_interrupted" );
    }
    
    foreach ( p in level.players )
    {
        if ( p != player )
        {
            p connection_puzzle::close_spectator( level.connection_puzzle_asset, self.var_490060d47d9e122a );
        }
    }
}

// Namespace namespace_abbef56318e51c26
// Params 0, eflags: 0x4
// Checksum 0x3ce2af2b, Offset: 0x2116
// Size: 0x1f0
function private connection_puzzle_init()
{
    asset = hashcat( %"scriptedwidget:", "scripted_widget_connection_puzzle_3side_4player_sat_default" );
    
    /#
        var_eb8f9b2b12a1a8d5 = getdvarint( @"hash_638167c2bbc5e8b4", 0 );
    #/
    
    consoles = getscriptablearray( "proc_pressure_console", "targetname" );
    
    foreach ( var_190f59357d8260f7 in consoles )
    {
        var_190f59357d8260f7 setscriptablepartstate( #"base", #"circuit_operational" );
    }
    
    if ( level.players.size == 1 && !var_eb8f9b2b12a1a8d5 )
    {
        connection_puzzle::init_from_layout( asset, "libra_processing_1p_1", "pump_a_puzzle", 1, "scripted_widget_connection_puzzle_3side_4player_sat_default_spectator" );
    }
    else if ( level.players.size == 2 && !var_eb8f9b2b12a1a8d5 )
    {
        connection_puzzle::init_from_layout( asset, "libra_processing_2p_1", "pump_a_puzzle", 1, "scripted_widget_connection_puzzle_3side_4player_sat_default_spectator" );
    }
    else
    {
        connection_puzzle::init_from_layout( asset, "libra_processing_3p_1", "pump_a_puzzle", 1, "scripted_widget_connection_puzzle_3side_4player_sat_default_spectator" );
    }
    
    if ( level.players.size == 1 && !var_eb8f9b2b12a1a8d5 )
    {
        connection_puzzle::init_from_layout( asset, "libra_processing_1p_2", "pump_b_puzzle", 1, "scripted_widget_connection_puzzle_3side_4player_sat_default_spectator" );
    }
    else if ( level.players.size == 2 && !var_eb8f9b2b12a1a8d5 )
    {
        connection_puzzle::init_from_layout( asset, "libra_processing_2p_2", "pump_b_puzzle", 1, "scripted_widget_connection_puzzle_3side_4player_sat_default_spectator" );
    }
    else
    {
        connection_puzzle::init_from_layout( asset, "libra_processing_3p_2", "pump_b_puzzle", 1, "scripted_widget_connection_puzzle_3side_4player_sat_default_spectator" );
    }
    
    level.connection_puzzle_asset = asset;
    thread function_2e122204a2a9f941();
    thread libra_audio::audio_puzzle_complete();
}

// Namespace namespace_abbef56318e51c26
// Params 0, eflags: 0x4
// Checksum 0x1592a36e, Offset: 0x230e
// Size: 0xac
function private function_2e122204a2a9f941()
{
    level endon( #"death" );
    
    while ( true )
    {
        level waittill( #"ConnectionPuzzleCompleted", data );
        
        foreach ( player in data.players )
        {
            player notify( #"ConnectionPuzzleCompleted" );
        }
    }
}

// Namespace namespace_abbef56318e51c26
// Params 0
// Checksum 0x2c64040d, Offset: 0x23c2
// Size: 0x412
function function_52d6330a30d7b596()
{
    level utility::flag_wait( "scriptables_ready" );
    wait 1;
    var_8de035d90b7c500e = getscriptablearray( "proc_sphere_screen1", "targetname" );
    var_8dd325d90b6e1859 = getscriptablearray( "proc_sphere_screen2", "targetname" );
    utility::flag_wait( "pump_interact_b_used" );
    
    foreach ( screen in var_8de035d90b7c500e )
    {
        var_b663fc67159f514d = screen getscriptablepartstate( #"base", 1 );
        
        if ( issubstr( var_b663fc67159f514d, "dead" ) )
        {
            screen setscriptablepartstate( #"base", #"safe_dead", 0 );
            continue;
        }
        
        screen setscriptablepartstate( #"base", #"safe" );
    }
    
    utility::flag_wait( "pump_interact_b_restarted" );
    
    foreach ( screen in var_8de035d90b7c500e )
    {
        var_b663fc67159f514d = screen getscriptablepartstate( #"base", 1 );
        
        if ( issubstr( var_b663fc67159f514d, "dead" ) )
        {
            screen setscriptablepartstate( #"base", #"warning_dead", 0 );
            continue;
        }
        
        screen setscriptablepartstate( #"base", #"warning" );
    }
    
    utility::flag_wait( "pump_interact_a_on" );
    
    foreach ( screen in var_8de035d90b7c500e )
    {
        var_b663fc67159f514d = screen getscriptablepartstate( #"base", 1 );
        
        if ( issubstr( var_b663fc67159f514d, "dead" ) )
        {
            screen setscriptablepartstate( #"base", #"danger_dead", 0 );
            continue;
        }
        
        screen setscriptablepartstate( #"base", #"danger" );
    }
    
    utility::flag_wait( "pump_a_done" );
    
    foreach ( screen in var_8de035d90b7c500e )
    {
        var_b663fc67159f514d = screen getscriptablepartstate( #"base", 1 );
        
        if ( issubstr( var_b663fc67159f514d, "dead" ) )
        {
            screen setscriptablepartstate( #"base", #"critical_dead", 0 );
            continue;
        }
        
        screen setscriptablepartstate( #"base", #"critical" );
    }
    
    foreach ( screen in var_8dd325d90b6e1859 )
    {
        var_b663fc67159f514d = screen getscriptablepartstate( #"base", 1 );
        
        if ( issubstr( var_b663fc67159f514d, "dead" ) )
        {
            screen setscriptablepartstate( #"base", #"save_yourself_dead", 0 );
            continue;
        }
        
        screen setscriptablepartstate( #"base", #"save_yourself" );
    }
}

