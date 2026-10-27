// script_6b84cb220281a6d3  (hash_6b84cb220281a6d3.gscc) (size: 17076 Bytes / 0x42b4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6db599f9 (1840617977)
// size ...... 17076 (0x42b4)
// includes .. 17  (offset: 0x3c1c)
// strings ... 84  (offset: 0x3ca4)
// dev strs .. 5   (offset: 0x4278)
// exports ... 43  (offset: 0x2808)
// cseg ...... 0x992 + 0x1e76 (0x2808)
// imports ... 96  (offset: 0x2ec0)
// animtree1 . 0   (offset: 0x42b4)
// animtree2 . 0   (offset: 0x42b4)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\ai_spawn_director_utility;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_util;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_vo;
#using scripts\mp\mp_agent;
#using scripts\mp\ob\ob_soldier_util;
#using scripts\mp\ob\systems\ob_flying_drone;
#using scripts\mp\ob\systems\region_difficulty_manager;

#namespace ob_virgo_freeway_broken;

/#

    // Namespace ob_virgo_freeway_broken
    // Params 0
    // Checksum 0xe1331d45, Offset: 0x9b0
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace ob_virgo_freeway_broken
// Params 0, eflags: 0x5
// Checksum 0xfde77f4, Offset: 0x9bd
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_bf356336d6c98bb7", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_virgo_freeway_broken
// Params 0, eflags: 0x4
// Checksum 0x64c6ef45, Offset: 0x9e6
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_VIRGO_FREEWAY_BROKEN";
    activity_common::registeractivitytype( "OB_VIRGO_FREEWAY_BROKEN", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_FREEWAY_BROKEN", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_FREEWAY_BROKEN", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_FREEWAY_BROKEN", 3, &function_d4acef179eb9f9b2 );
}

// Namespace ob_virgo_freeway_broken
// Params 0
// Checksum 0x692afd44, Offset: 0xa47
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance freeway_broken_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace ob_virgo_freeway_broken
// Params 0
// Checksum 0x37558a1a, Offset: 0xaac
// Size: 0x32
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance freeway_broken_main();
}

// Namespace ob_virgo_freeway_broken
// Params 0
// Checksum 0x7c0486ba, Offset: 0xae6
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

/#

    // Namespace ob_virgo_freeway_broken
    // Params 0
    // Checksum 0xa689b955, Offset: 0xb0a
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace ob_virgo_freeway_broken
// Params 0
// Checksum 0x9713cc3b, Offset: 0xb17
// Size: 0x6e
function freeway_broken_start()
{
    level thread utility::exploder( "fx_freeway_inverted" );
    level thread utility::exploder( "fx_freeway_broken" );
    level thread ob_virgo_util::function_4ec71c3da6905745();
    activity_instance = self;
    level.objective_waypoint = "struct_obj_waypoint_freeway_broken";
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_weapon_la_sandwich", undefined, 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_equip_la_sandwich", undefined, 1 );
    level thread ob_story_mission_utils::function_e6799e9a19df2365( "struct_cache_broken_weaps" );
}

// Namespace ob_virgo_freeway_broken
// Params 0
// Checksum 0x14d235a4, Offset: 0xb8d
// Size: 0x3a
function function_7801d8ea4e071560()
{
    level endon( #"flag_frogger_top" );
    level utility::flag_wait( "flag_conv_la_freeway_parkour_done" );
    wait 15;
    
    if ( !utility::flag( "flag_frogger_top" ) )
    {
        level utility::flag_set( "flag_parkour_vo_climb" );
    }
}

// Namespace ob_virgo_freeway_broken
// Params 0
// Checksum 0x6c4499c3, Offset: 0xbcf
// Size: 0x167
function freeway_broken_main()
{
    level thread virgo_vo::function_93593d5e3c494229();
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_weapon_la_canyon", undefined, 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_equip_la_canyon", undefined );
    level.objective_waypoint = "struct_waypoint_canyon_end";
    thread ob_story_mission_utils::function_56960723e6738b6c( "OB_VIRGO_FREEWAY_BROKEN", level.objective_waypoint, "sat_ob_objectivemarker_storymissionmain", "obj_waypoint_freeway_canyon_done", undefined, undefined, 0 );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_parkour_start", "flag_freeway_broken_done" );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_player_inverted_ambush_mid", "flag_player_inverted_ambush_mid" );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_player_canyon_intro_scenes", "flag_player_canyon_intro_scenes" );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_freeway_canyon_center", "flag_freeway_canyon_center" );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_mid_freeway_canyon", "flag_mid_freeway_canyon" );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_mid_freeway_fallback", "flag_mid_freeway_fallback" );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_freeway_canyon_right_runner", "flag_freeway_canyon_right_runner" );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_start_canyon_flippers", "flag_start_canyon_flippers" );
    level thread ob_virgo_util::function_4408fb951c105cb4( "trig_start_back_end_drones", "flag_start_back_end_drones" );
    level thread function_658c8f4b7dee3851();
    activity_instance thread function_c1934ea2c63d36ee();
    activity_instance thread function_ee4edeb1fbbfbb40();
    activity_instance thread function_b3de7d12d0006b8a();
    activity_instance thread function_f4cdd54f3f3d4519();
    level utility::flag_wait( "flag_freeway_broken_done" );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace ob_virgo_freeway_broken
// Params 0
// Checksum 0x53e3ecf9, Offset: 0xd3e
// Size: 0x47e
function function_b3de7d12d0006b8a()
{
    level utility::flag_wait( "flag_freeway_canyon_center" );
    front_canyon_bot = ai_spawn_director::array_spawn_targetname( "front_canyon_bot" );
    
    foreach ( bot in front_canyon_bot )
    {
        bot thread front_canyon_bot_spawn_func();
    }
    
    thread ob_virgo_util::virgo_drones( "end_canyon_drones", undefined, undefined, "turret", "flag_frogger_to_crashsite_bink_done" );
    mid_canyon_bot = ai_spawn_director::array_spawn_targetname( "mid_canyon_bot" );
    
    foreach ( bot in mid_canyon_bot )
    {
        bot thread function_1ddff93dcc546304();
    }
    
    a_turret_structs = utility::getstructarray( "canyon_turrets", "targetname" );
    
    foreach ( var_555a947463e55350 in a_turret_structs )
    {
        turret = ob_soldier_util::ob_sentry_turret_spawn( var_555a947463e55350 );
        waitframe();
        level.sentrysettings[ "ai_sentry_turret" ].targetrange = 10000;
        level.sentrysettings[ "ai_sentry_turret" ].burstmin = 55;
        level.sentrysettings[ "ai_sentry_turret" ].burstmax = 60;
        level.sentrysettings[ "ai_sentry_turret" ].pausemin = 2;
        level.sentrysettings[ "ai_sentry_turret" ].pausemax = 4;
        level.sentrysettings[ "ai_sentry_turret" ].spinuptime = 2;
        turret.isactive = 1;
        turret.team = "team_hundred_ninety";
    }
    
    waitframe();
    
    if ( level.players.size >= 3 )
    {
        mid_canyon_bot_advanced_coop = ai_spawn_director::array_spawn_targetname( "mid_canyon_bot_advanced_coop" );
        
        foreach ( bot in mid_canyon_bot_advanced_coop )
        {
            bot thread function_1ddff93dcc546304();
        }
        
        a_canyon_turrets_back = utility::getstructarray( "canyon_turrets_back", "targetname" );
        
        foreach ( var_555a947463e55350 in a_canyon_turrets_back )
        {
            turret = ob_soldier_util::ob_sentry_turret_spawn( var_555a947463e55350 );
            waitframe();
            level.sentrysettings[ "ai_sentry_turret" ].targetrange = 10000;
            level.sentrysettings[ "ai_sentry_turret" ].targetrange = 10000;
            level.sentrysettings[ "ai_sentry_turret" ].burstmin = 55;
            level.sentrysettings[ "ai_sentry_turret" ].burstmax = 60;
            level.sentrysettings[ "ai_sentry_turret" ].pausemin = 2;
            level.sentrysettings[ "ai_sentry_turret" ].pausemax = 4;
            level.sentrysettings[ "ai_sentry_turret" ].spinuptime = 2;
            turret.isactive = 1;
            turret.team = "team_hundred_ninety";
        }
    }
}

// Namespace ob_virgo_freeway_broken
// Params 0
// Checksum 0x797216b9, Offset: 0x11c4
// Size: 0x1a0
function function_f4cdd54f3f3d4519()
{
    level utility::flag_wait( "flag_start_canyon_flippers" );
    back_end_canyon_bot = ai_spawn_director::array_spawn_targetname( "back_end_canyon_bot" );
    
    foreach ( bot in back_end_canyon_bot )
    {
        bot thread function_1ddff93dcc546304();
    }
    
    back_end_canyon_advanced = ai_spawn_director::array_spawn_targetname( "back_end_canyon_advanced" );
    
    foreach ( bot in back_end_canyon_advanced )
    {
        bot thread function_1ddff93dcc546304();
    }
    
    if ( level.players.size >= 3 )
    {
        back_end_canyon_advanced_coop = ai_spawn_director::array_spawn_targetname( "back_end_canyon_advanced_coop" );
        
        foreach ( bot in back_end_canyon_advanced_coop )
        {
            bot thread function_1ddff93dcc546304();
        }
    }
}

// Namespace ob_virgo_freeway_broken
// Params 0
// Checksum 0xf64f1b0, Offset: 0x136c
// Size: 0x47
function function_1ddff93dcc546304()
{
    self endon( #"death" );
    level utility::flag_wait( "flag_parkour_top" );
    
    if ( isalive( self ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
        agent_utils::despawnagent();
    }
}

// Namespace ob_virgo_freeway_broken
// Params 0
// Checksum 0x3aa609f0, Offset: 0x13bb
// Size: 0x47
function front_canyon_bot_spawn_func()
{
    self endon( #"death" );
    level utility::flag_wait( "flag_start_back_end_drones" );
    
    if ( isalive( self ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
        agent_utils::despawnagent();
    }
}

// Namespace ob_virgo_freeway_broken
// Params 0
// Checksum 0x88001566, Offset: 0x140a
// Size: 0x190
function function_ee4edeb1fbbfbb40()
{
    if ( level.players.size >= 3 )
    {
        level utility::flag_wait( "flag_mid_freeway_fallback" );
        level.var_4371cc5bb67b0b84 = spawnstruct();
        var_26ad585bf3f8d930 = getscriptbundle( %"hash_79ca8546b5fd561b" );
        var_c566eb625bee6c2c = utility::getstructarray( "freeway_canyon_mid_drones" );
        
        foreach ( drone_struct in var_c566eb625bee6c2c )
        {
            drone_difficulty_region = region_difficulty_manager::get_region_difficulty( drone_struct.origin );
            spawn_options = { #respawn_on_death:1, #spawn_angles:drone_struct.angles, #difficulty_region:drone_difficulty_region, #var_2858c1d9ffae3f84:var_26ad585bf3f8d930.var_2858c1d9ffae3f84, #goal:#"hash_6573e43fb6b70d11", #canlootdrop:0, #canmove:1, #spawnpos:drone_struct.origin, #enableaimassist:1, #candamage:1 };
            level.var_4371cc5bb67b0b84 spawn_drone( 0, 1, spawn_options, "flag_player_inverted_ambush_mid" );
        }
    }
}

// Namespace ob_virgo_freeway_broken
// Params 3, eflags: 0x4
// Checksum 0xd6c1983c, Offset: 0x15a2
// Size: 0x4d
function private function_3263181e5e21e7ff( drone, spawn_options, var_9570b181a8081f61 )
{
    drone waittill( #"death" );
    is_main_drone = drone ob_flying_drone::is_main_drone();
    thread spawn_drone( 60, is_main_drone, spawn_options, var_9570b181a8081f61 );
}

// Namespace ob_virgo_freeway_broken
// Params 4, eflags: 0x4
// Checksum 0xad05915f, Offset: 0x15f7
// Size: 0xaa
function private spawn_drone( delay_time, is_main_drone, spawn_options, var_9570b181a8081f61 )
{
    drone = undefined;
    wait delay_time;
    
    if ( is_main_drone )
    {
        drone = ob_flying_drone::function_d664e23d9508b462( spawn_options );
        drone ob_flying_drone::function_e0de4dce57ae487();
        drone thread ob_flying_drone::function_dbc3536438aea5e0();
        drone thread ob_flying_drone::drone_movebehavior();
        drone thread drone_damage_watcher( var_9570b181a8081f61 );
        
        /#
            drone thread ob_flying_drone::function_5fc6b44c9edd444a();
        #/
        
        return;
    }
    
    drone = ob_flying_drone::spawn_helper_drone( spawn_options.var_cdffe119ed60d14d, [ spawn_options.spawnpos ], spawn_options.target, spawn_options );
}

// Namespace ob_virgo_freeway_broken
// Params 1, eflags: 0x4
// Checksum 0xd88cec48, Offset: 0x16a9
// Size: 0x45
function private drone_damage_watcher( var_9570b181a8081f61 )
{
    self endon( #"main_drone_destroyed" );
    self endon( #"orb_cleaned_up" );
    self endon( #"death" );
    utility::waittill_any( "drone_first_damage", var_9570b181a8081f61 );
    thread function_626c84bb868d8100();
}

// Namespace ob_virgo_freeway_broken
// Params 0, eflags: 0x4
// Checksum 0x5ae8baad, Offset: 0x16f6
// Size: 0x66
function private function_626c84bb868d8100()
{
    drone = self;
    drone endon( #"main_drone_destroyed" );
    drone endon( #"death" );
    drone ob_flying_drone::function_b62d57c03a13139d();
    drone utility::waittill_any_timeout( drone.var_4922a62c04b53c20, "engage_phase" );
    drone ob_flying_drone::function_5366327c25ea5eb2();
    level.var_4371cc5bb67b0b84 thread ob_flying_drone::function_6395a1838cd983f5( drone );
}

// Namespace ob_virgo_freeway_broken
// Params 0
// Checksum 0x6a03cc4f, Offset: 0x1764
// Size: 0x18d
function function_c1934ea2c63d36ee()
{
    activity_instance = self;
    level utility::flag_wait( "flag_player_inverted_ambush_mid" );
    level.var_128e185cc85df09d = [];
    activity_instance thread ob_virgo_util::virgo_drones( "mid_canyon_drones", undefined, undefined, "turret", "flag_parkour_top" );
    waitframe();
    level thread function_cb11119f7cb1dcfa();
    level.ai_e_mid_freeway = ai_spawn_director::lookup_spawn_request( "ai_e_mid_freeway" );
    function_ef57f478f96b050c( level.ai_e_mid_freeway, 1 );
    activity_instance activity_ai_encounters::function_6bf4ff2fbde584ee( level.ai_e_mid_freeway, &function_69b31332b9233ae4, activity_instance );
    ai_spawn_director::add_spawned_callback( level.ai_e_mid_freeway, &function_5d175d56719d5988 );
    ai_spawn_director::function_a49c35b72d6b6fea( level.ai_e_mid_freeway, &function_d3cec1205621550f );
    level utility::flag_wait_or_timeout( "flag_player_canyon_intro_scenes", 10 );
    spawn_pos = utility::getstruct( "virgo_spawn_pos", "targetname" );
    scene_trailer_climb_enemy = utility::getstruct( "scene_trailer_climb_enemy", "targetname" );
    var_d937a8ac809622d5 = mp_agent::spawnnewagentaitype( "sat_ob_enemy_basic_grunt_cradle_short", spawn_pos.origin, spawn_pos.angles, "team_hundred_ninety" );
    
    if ( isdefined( var_d937a8ac809622d5 ) )
    {
        var_d937a8ac809622d5 thread function_f8cb24976637b481( scene_trailer_climb_enemy );
    }
    
    scene_freewaycanyon_wall_run_up = utility::getstruct( "scene_freewaycanyon_wall_run_up", "targetname" );
    var_4f870376a3127624 = mp_agent::spawnnewagentaitype( "sat_ob_enemy_basic_grunt_cradle_long", spawn_pos.origin, spawn_pos.angles, "team_hundred_ninety" );
    
    if ( isdefined( var_4f870376a3127624 ) )
    {
        var_4f870376a3127624 thread function_729f2bb7b9354973( scene_freewaycanyon_wall_run_up );
    }
}

// Namespace ob_virgo_freeway_broken
// Params 3
// Checksum 0x4ee2a8a3, Offset: 0x18f9
// Size: 0x3b
function function_d3cec1205621550f( requestid, userdata, shutdowndata )
{
    /#
        iprintln( "<dev string:x24>" );
    #/
    
    ai_spawn_director::cancel_spawn_request( level.ai_e_mid_freeway );
}

// Namespace ob_virgo_freeway_broken
// Params 3
// Checksum 0x2576d1f5, Offset: 0x193c
// Size: 0x46
function function_91faa6cb7249750c( requestid, activity_instance, agent )
{
    level.var_128e185cc85df09d = utility::array_removedead_or_dying( level.var_128e185cc85df09d );
    
    if ( level.var_128e185cc85df09d.size < 2 )
    {
    }
}

// Namespace ob_virgo_freeway_broken
// Params 1
// Checksum 0x60d7c397, Offset: 0x198a
// Size: 0x13b
function function_729f2bb7b9354973( scene_struct )
{
    self endon( #"death" );
    scene_struct scene::play( self );
    self.fixednode = 1;
    self.goalradius = 64;
    level.var_128e185cc85df09d[ level.var_128e185cc85df09d.size ] = self;
    nd_left_wall_runner = getnode( "nd_left_wall_runner", "targetname" );
    self setgoalnode( nd_left_wall_runner );
    var_def68e8d6c25ac6f = randomfloatrange( 6, 9 );
    wait var_def68e8d6c25ac6f;
    self.fixednode = 0;
    vols = getnoentvolumearray( "canyon_front_vol", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_freeway_canyon_center" );
    vols = getnoentvolumearray( "canyon_mid_vol", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_mid_freeway_canyon" );
    vols = getnoentvolumearray( "canyon_end_vol", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_parkour_start" );
    
    if ( isalive( self ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
        agent_utils::despawnagent();
    }
}

// Namespace ob_virgo_freeway_broken
// Params 0
// Checksum 0xbbc037fa, Offset: 0x1acd
// Size: 0x118
function function_cb11119f7cb1dcfa()
{
    level utility::flag_wait( "flag_freeway_canyon_right_runner" );
    spawn_pos = utility::getstruct( "virgo_spawn_pos", "targetname" );
    
    if ( !isdefined( spawn_pos ) )
    {
        /#
            iprintln( "<dev string:x45>" );
        #/
        
        return;
    }
    
    scene_freeway_inverted_road_slide_down = utility::getstruct( "scene_freeway_inverted_road_slide_down", "targetname" );
    
    if ( isdefined( scene_freeway_inverted_road_slide_down ) )
    {
        var_d937a8ac809622d5 = mp_agent::spawnnewagentaitype( "sat_ob_enemy_basic_grunt_cradle_sg", spawn_pos.origin, spawn_pos.angles, "team_hundred_ninety" );
        
        if ( isdefined( var_d937a8ac809622d5 ) )
        {
            var_d937a8ac809622d5 thread function_ebef1444ac9d69b9( scene_freeway_inverted_road_slide_down );
        }
        else
        {
            /#
                iprintln( "<dev string:x6e>" );
            #/
        }
    }
    
    scene_freeway_inverted_wall_run = utility::getstruct( "scene_freeway_inverted_wall_run", "targetname" );
    
    if ( isdefined( scene_freeway_inverted_wall_run ) )
    {
        var_d937a8ac809622d5 = mp_agent::spawnnewagentaitype( "sat_ob_enemy_basic_grunt_cradle_long", spawn_pos.origin, spawn_pos.angles, "team_hundred_ninety" );
        
        if ( isdefined( var_d937a8ac809622d5 ) )
        {
            var_d937a8ac809622d5 thread function_118a4302df2afee3( scene_freeway_inverted_wall_run );
            return;
        }
        
        /#
            iprintln( "<dev string:x92>" );
        #/
    }
}

// Namespace ob_virgo_freeway_broken
// Params 1
// Checksum 0x58340f0f, Offset: 0x1bed
// Size: 0x13b
function function_ebef1444ac9d69b9( scene_struct )
{
    self endon( #"death" );
    level.var_128e185cc85df09d[ level.var_128e185cc85df09d.size ] = self;
    scene_struct scene::play( self );
    self.fixednode = 1;
    self.goalradius = 64;
    canyon_sniper_node = getnode( "canyon_sniper_node", "targetname" );
    self setgoalnode( canyon_sniper_node );
    var_def68e8d6c25ac6f = randomfloatrange( 6, 9 );
    wait var_def68e8d6c25ac6f;
    self.fixednode = 0;
    vols = getnoentvolumearray( "canyon_front_vol", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_freeway_canyon_center" );
    vols = getnoentvolumearray( "canyon_mid_vol", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_mid_freeway_canyon" );
    vols = getnoentvolumearray( "canyon_end_vol", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_parkour_top" );
    
    if ( isalive( self ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
        agent_utils::despawnagent();
    }
}

// Namespace ob_virgo_freeway_broken
// Params 1
// Checksum 0xb9b7ed50, Offset: 0x1d30
// Size: 0x13b
function function_118a4302df2afee3( scene_struct )
{
    self endon( #"death" );
    level.var_128e185cc85df09d[ level.var_128e185cc85df09d.size ] = self;
    scene_struct scene::play( self );
    self.fixednode = 1;
    self.goalradius = 64;
    intro_canyon_smg_node = getnode( "intro_canyon_smg_node", "targetname" );
    self setgoalnode( intro_canyon_smg_node );
    var_def68e8d6c25ac6f = randomfloatrange( 6, 9 );
    wait var_def68e8d6c25ac6f;
    self.fixednode = 0;
    vols = getnoentvolumearray( "canyon_front_vol", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_freeway_canyon_center" );
    vols = getnoentvolumearray( "canyon_mid_vol", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_mid_freeway_canyon" );
    vols = getnoentvolumearray( "canyon_end_vol", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_parkour_top" );
    
    if ( isalive( self ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
        agent_utils::despawnagent();
    }
}

// Namespace ob_virgo_freeway_broken
// Params 1
// Checksum 0x5e0cfd71, Offset: 0x1e73
// Size: 0x13b
function function_f8cb24976637b481( var_78f849f538f5d74 )
{
    self endon( #"death" );
    level.var_128e185cc85df09d[ level.var_128e185cc85df09d.size ] = self;
    var_78f849f538f5d74 scene::play( self );
    self.fixednode = 1;
    self.goalradius = 64;
    trailer_climb_node = getnode( "trailer_climb_node", "targetname" );
    self setgoalnode( trailer_climb_node );
    var_def68e8d6c25ac6f = randomfloatrange( 6, 9 );
    wait var_def68e8d6c25ac6f;
    self.fixednode = 0;
    vols = getnoentvolumearray( "canyon_front_vol", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_freeway_canyon_center" );
    vols = getnoentvolumearray( "canyon_mid_vol", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_mid_freeway_canyon" );
    vols = getnoentvolumearray( "canyon_end_vol", "targetname" );
    self setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_parkour_top" );
    
    if ( isalive( self ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
        agent_utils::despawnagent();
    }
}

// Namespace ob_virgo_freeway_broken
// Params 0
// Checksum 0xcb444520, Offset: 0x1fb6
// Size: 0x5d
function function_393a7d0c11925e37()
{
    self endon( #"death" );
    level.var_e40f5794a09373cc[ level.var_e40f5794a09373cc.size ] = self;
    level utility::flag_wait( "flag_parkour_top" );
    
    if ( isalive( self ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
        agent_utils::despawnagent();
    }
}

// Namespace ob_virgo_freeway_broken
// Params 0
// Checksum 0xd64cb148, Offset: 0x201b
// Size: 0x22
function function_5f2cfa86aa72013d()
{
    wait 2;
    level utility::flag_set( "flag_end_canyon_reinforcement_vo" );
    wait 4;
    level utility::flag_set( "flag_reinforce_objective_vo" );
}

// Namespace ob_virgo_freeway_broken
// Params 0
// Checksum 0x67618f1d, Offset: 0x2045
// Size: 0x123
function function_7ef4134cb3345bf8()
{
    activity_instance = self;
    level utility::flag_wait( "flag_mid_freeway_canyon" );
    level thread function_5f2cfa86aa72013d();
    level.var_d70b474d1198931f = [];
    waitframe();
    end_canyon_rpg = ai_spawn_director::array_spawn_targetname( "end_canyon_rpg" );
    
    foreach ( var_f2505e3ba69fca8c in end_canyon_rpg )
    {
        var_f2505e3ba69fca8c thread function_67ff42bc5d5f2603();
    }
    
    level thread function_198937e8a8cc8a69();
    level.ai_e_mid_freeway_reinforcements = ai_spawn_director::lookup_spawn_request( "ai_e_mid_freeway_reinforcements" );
    function_ef57f478f96b050c( level.ai_e_mid_freeway_reinforcements, 1 );
    activity_instance activity_ai_encounters::function_6bf4ff2fbde584ee( level.ai_e_mid_freeway_reinforcements, &function_d91d65a661f842b2, activity_instance );
    ai_spawn_director::add_spawned_callback( level.ai_e_mid_freeway_reinforcements, &function_a6eeedf439704a43 );
    ai_spawn_director::function_a49c35b72d6b6fea( level.ai_e_mid_freeway_reinforcements, &function_4885b3e9b877cf39 );
}

// Namespace ob_virgo_freeway_broken
// Params 0
// Checksum 0x7d2f8cb, Offset: 0x2170
// Size: 0x150
function function_198937e8a8cc8a69()
{
    level utility::flag_wait( "flag_start_canyon_flippers" );
    end_canyon_spawners = ai_spawn_director::array_spawn_targetname( "end_canyon_spawners" );
    
    foreach ( var_f2505e3ba69fca8c in end_canyon_spawners )
    {
        var_f2505e3ba69fca8c thread function_67ff42bc5d5f2603();
    }
    
    spawn_pos = utility::getstruct( "virgo_spawn_pos", "targetname" );
    scene_near_donna_sign_upside_down_flip = utility::getstruct( "scene_near_donna_sign_upside_down_flip", "targetname" );
    var_d937a8ac809622d5 = mp_agent::spawnnewagentaitype( "sat_ob_enemy_basic_grunt_cradle_short", spawn_pos.origin, spawn_pos.angles, "team_hundred_ninety" );
    var_d937a8ac809622d5 thread function_32fdffd9783f1799( scene_near_donna_sign_upside_down_flip );
    scene_near_donna_sign_upside_down_flip_02 = utility::getstruct( "scene_near_donna_sign_upside_down_flip_02", "targetname" );
    var_d937a8ac809622d5 = mp_agent::spawnnewagentaitype( "sat_ob_enemy_basic_grunt_cradle_long", spawn_pos.origin, spawn_pos.angles, "team_hundred_ninety" );
    var_d937a8ac809622d5 thread function_ecc444ab1c4f078a( scene_near_donna_sign_upside_down_flip_02 );
}

// Namespace ob_virgo_freeway_broken
// Params 1
// Checksum 0x1e880c23, Offset: 0x22c8
// Size: 0x93
function function_32fdffd9783f1799( scene_struct )
{
    self endon( #"death" );
    level.var_d70b474d1198931f[ level.var_d70b474d1198931f.size ] = self;
    scene_struct scene::play( self );
    donna_sign_01_node = getnode( "donna_sign_01_node", "targetname" );
    self setgoalnode( donna_sign_01_node );
    level utility::flag_wait( "flag_parkour_top" );
    
    if ( isalive( self ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
        agent_utils::despawnagent();
    }
}

// Namespace ob_virgo_freeway_broken
// Params 1
// Checksum 0xef82ac7d, Offset: 0x2363
// Size: 0x93
function function_ecc444ab1c4f078a( scene_struct )
{
    self endon( #"death" );
    level.var_d70b474d1198931f[ level.var_d70b474d1198931f.size ] = self;
    scene_struct scene::play( self );
    donna_sign_02_node = getnode( "donna_sign_02_node", "targetname" );
    self setgoalnode( donna_sign_02_node );
    level utility::flag_wait( "flag_parkour_top" );
    
    if ( isalive( self ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
        agent_utils::despawnagent();
    }
}

// Namespace ob_virgo_freeway_broken
// Params 0
// Checksum 0x5dd446cf, Offset: 0x23fe
// Size: 0x5d
function function_67ff42bc5d5f2603()
{
    self endon( #"death" );
    level.var_d70b474d1198931f[ level.var_d70b474d1198931f.size ] = self;
    level utility::flag_wait( "flag_parkour_top" );
    
    if ( isalive( self ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], self.origin );
        agent_utils::despawnagent();
    }
}

// Namespace ob_virgo_freeway_broken
// Params 3
// Checksum 0x3abc72a4, Offset: 0x2463
// Size: 0x2b
function function_87286efee43be145( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_freeway_center_encounter_spawned" );
}

// Namespace ob_virgo_freeway_broken
// Params 4
// Checksum 0x9ace96c6, Offset: 0x2496
// Size: 0x89
function function_8d75e1d6bb72d8ff( requestid, instance, agent, ai_data )
{
    agent endon( #"death" );
    level.var_e40f5794a09373cc[ level.var_e40f5794a09373cc.size ] = agent;
    level utility::flag_wait( "flag_parkour_top" );
    
    if ( isalive( agent ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], agent.origin );
        agent agent_utils::despawnagent();
    }
}

// Namespace ob_virgo_freeway_broken
// Params 3
// Checksum 0xec814235, Offset: 0x2527
// Size: 0x2b
function function_69b31332b9233ae4( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_mid_freeway_encounter_spawned" );
}

// Namespace ob_virgo_freeway_broken
// Params 4
// Checksum 0x1b04e36d, Offset: 0x255a
// Size: 0x116
function function_5d175d56719d5988( requestid, instance, agent, ai_data )
{
    agent endon( #"death" );
    level.var_128e185cc85df09d[ level.var_128e185cc85df09d.size ] = agent;
    var_def68e8d6c25ac6f = randomfloatrange( 6, 9 );
    wait var_def68e8d6c25ac6f;
    vols = getnoentvolumearray( "canyon_front_vol", "targetname" );
    agent setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_freeway_canyon_center" );
    vols = getnoentvolumearray( "canyon_mid_vol", "targetname" );
    agent setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_mid_freeway_canyon" );
    vols = getnoentvolumearray( "canyon_end_vol", "targetname" );
    agent setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_parkour_top" );
    
    if ( isalive( agent ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], agent.origin );
        agent agent_utils::despawnagent();
    }
}

// Namespace ob_virgo_freeway_broken
// Params 4
// Checksum 0x587da4a2, Offset: 0x2678
// Size: 0xc8
function function_a6eeedf439704a43( requestid, instance, agent, ai_data )
{
    agent endon( #"death" );
    level.var_d70b474d1198931f[ level.var_d70b474d1198931f.size ] = agent;
    var_def68e8d6c25ac6f = randomfloatrange( 6, 9 );
    wait var_def68e8d6c25ac6f;
    vols = getnoentvolumearray( "canyon_end_vol", "targetname" );
    agent setgoalvolumeauto( vols[ 0 ] );
    level utility::flag_wait( "flag_parkour_top" );
    
    if ( isalive( agent ) )
    {
        playfx( level._effect[ "enemy_death_cleanup" ], agent.origin );
        agent agent_utils::despawnagent();
    }
}

// Namespace ob_virgo_freeway_broken
// Params 3
// Checksum 0x485c66c, Offset: 0x2748
// Size: 0x2b
function function_d91d65a661f842b2( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_mid_freeway_reinforcements_spawned" );
}

// Namespace ob_virgo_freeway_broken
// Params 3
// Checksum 0x1f5d9d53, Offset: 0x277b
// Size: 0x48
function function_4885b3e9b877cf39( requestid, userdata, shutdowndata )
{
    /#
        iprintln( "<dev string:xb8>" );
    #/
    
    level utility::flag_set( "mid_freeway_reinforcements_cleared" );
    ai_spawn_director::cancel_spawn_request( level.ai_e_mid_freeway_reinforcements );
}

// Namespace ob_virgo_freeway_broken
// Params 0
// Checksum 0x8449a7a8, Offset: 0x27cb
// Size: 0x3d
function function_658c8f4b7dee3851()
{
    level utility::flag_wait( "flag_mid_freeway_canyon" );
    scene_freeway_canyon_jetflyby = utility::getstruct( "scene_freeway_canyon_jetflyby", "targetname" );
    scene_freeway_canyon_jetflyby thread ob_virgo_util::function_29164af2d4d89658();
    scene_freeway_canyon_jetflyby thread scene::play();
}

