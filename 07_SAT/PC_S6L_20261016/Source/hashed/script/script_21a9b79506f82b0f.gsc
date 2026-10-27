// script_21a9b79506f82b0f  (hash_21a9b79506f82b0f.gscc) (size: 12903 Bytes / 0x3267 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2040078c (541067148)
// size ...... 12903 (0x3267)
// includes .. 16  (offset: 0x2d67)
// strings ... 79  (offset: 0x2de7)
// dev strs .. 0   (offset: 0x3267)
// exports ... 39  (offset: 0x1b4b)
// cseg ...... 0x7b5 + 0x1396 (0x1b4b)
// imports ... 99  (offset: 0x2163)
// animtree1 . 0   (offset: 0x3267)
// animtree2 . 0   (offset: 0x3267)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_progress_tracking;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\puzzles\connection_puzzle;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_audio;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_util;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_vo;

#namespace namespace_8a782610143da27a;

/#

    // Namespace namespace_8a782610143da27a
    // Params 0
    // Checksum 0xd004ad24, Offset: 0x7d3
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_8a782610143da27a
// Params 0, eflags: 0x5
// Checksum 0x934e67dd, Offset: 0x7e0
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_585058d5a4a061d5", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_8a782610143da27a
// Params 0, eflags: 0x4
// Checksum 0x475ac4b3, Offset: 0x809
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_VIRGO_JAPAN_FIGHT";
    activity_common::registeractivitytype( "OB_VIRGO_JAPAN_FIGHT", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_JAPAN_FIGHT", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_JAPAN_FIGHT", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_JAPAN_FIGHT", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_8a782610143da27a
// Params 0
// Checksum 0xc304edde, Offset: 0x86a
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance japan_fight_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_8a782610143da27a
// Params 0
// Checksum 0xa6bd23d, Offset: 0x8cf
// Size: 0x32
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance japan_fight_main();
}

// Namespace namespace_8a782610143da27a
// Params 0
// Checksum 0x4d3336db, Offset: 0x909
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

/#

    // Namespace namespace_8a782610143da27a
    // Params 0
    // Checksum 0x97be0934, Offset: 0x92d
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_8a782610143da27a
// Params 0
// Checksum 0xfa5e6b2a, Offset: 0x93a
// Size: 0x2f
function japan_fight_start()
{
    level thread utility::exploder( "fx_jpn_intro" );
    level thread utility::exploder( "fx_jpn_fight" );
    setdvar( @"hash_8adcf05d62fe94fd", 0.55 );
}

// Namespace namespace_8a782610143da27a
// Params 0
// Checksum 0x29255f5c, Offset: 0x971
// Size: 0x2c2
function japan_fight_main()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    level thread ob_virgo_util::function_9f5a4a38ccd4c7a3();
    level thread ob_virgo_util::function_5014ebb9978c03b2( "flag_void_2_bink_done", "teleport", &"sat_ob_story_missions/virgo_flicker_hint" );
    level thread ob_virgo_util::function_5014ebb9978c03b2( "flag_void_2_bink_done", "summon", &"sat_ob_story_missions/virgo_summon_hint" );
    level thread function_eb39f6851ca081c6();
    level.garden_activity = self;
    level thread virgo_vo::function_dacd191256516a47();
    level thread ob_virgo_util::function_1415e67b35bab88e( "trig_japan_garden", "flag_garden_combat_start" );
    level thread ob_virgo_util::function_1415e67b35bab88e( "trig_japan_safehouse", "flag_japan_at_safehouse" );
    level thread ob_virgo_util::function_1415e67b35bab88e( "trig_japan_post_garden_01", "flag_japan_post_garden" );
    level thread ob_virgo_util::function_1415e67b35bab88e( "trig_japan_post_garden_02", "flag_japan_near_safehouse" );
    thread ob_virgo_util::function_144604a50795e58f( "struct_obj_waypoint_japan_fight", "flag_start_garden_countdown", undefined );
    thread ob_story_mission_utils::item_spawn_weapon( "s_weapon_japan_fight", undefined, 1 );
    thread ob_story_mission_utils::item_spawn_equipment( "s_equip_japan_fight", undefined, 1, undefined, undefined, undefined );
    thread japan_fight_combat();
    level thread function_17244447da45f972();
    struct = utility::getstruct( "struct_scene_virgo_betrayal", "targetname" );
    level utility::flag_wait_all( "flag_garden_wave_4_done", "flag_garden_wave_1_cleared", "flag_garden_wave_2_cleared", "flag_garden_wave_3_cleared" );
    ob_virgo_util::function_3fbaca3bceae7dfb( "OB_VIRGO_JAPAN_POST" );
    level utility::flag_set( "flag_japan_tanks_defeated" );
    level thread function_9cb08127aa8e375b();
    level thread japan_finale();
    thread ob_virgo_util::function_144604a50795e58f( "struct_virgo_japan_fight_end", "flag_virgo_japan_fight_done" );
    thread ob_virgo_util::function_70674852bcdd6cd3( "struct_virgo_japan_fight_end", "flag_virgo_japan_fight_done", &"sat_ob_story_missions/interact_open" );
    level utility::flag_wait( "flag_virgo_japan_fight_done" );
    virgo_vo::function_3b5c92445b52357e();
    structs = ob_story_mission_utils::get_activity_starts( "OB_VIRGO_CARRIER_INTRO" );
    level thread coop::play_cinematic( "sat_cin_virgo_betrayal_memory_void_2", { #triggerradius:256, #timeout:134, #flag:"flag_void_2_bink_done", #structs:structs } );
    level thread prestream_harper_boss();
    level thread utility::kill_exploder( "fx_jpn_intro" );
    level thread utility::kill_exploder( "fx_jpn_fight" );
    setdvar( @"hash_8adcf05d62fe94fd", 0 );
    level utility::flag_wait( "flag_void_2_bink_done" );
    
    foreach ( player in level.players )
    {
        player utility::player_prestream_clear( "virgo_japan_fight" );
    }
    
    level thread ob_virgo_util::function_fdd5b4c27ba17b79( "light", 1 );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_8a782610143da27a
// Params 0
// Checksum 0x96f5200c, Offset: 0xc3b
// Size: 0x27
function function_17244447da45f972()
{
    level utility::flag_wait( "flag_start_garden_countdown" );
    wait 10;
    level.garden_activity ob_virgo_util::function_3fbaca3bceae7dfb( "OB_VIRGO_JAPAN_FIGHT" );
}

// Namespace namespace_8a782610143da27a
// Params 0
// Checksum 0xc0f1be52, Offset: 0xc6a
// Size: 0x99
function wakeup_robots()
{
    level utility::flag_wait( "flag_start_garden_countdown" );
    wait 10;
    
    foreach ( player in level.players )
    {
        player connection_puzzle::close( 0 );
    }
    
    level utility::flag_set( "flag_japan_fight_combat_start" );
}

// Namespace namespace_8a782610143da27a
// Params 0
// Checksum 0xb3b3f8d1, Offset: 0xd0b
// Size: 0x4b
function japan_finale()
{
    struct = utility::getstruct( "struct_scene_50_ending", "targetname" );
    level utility::flag_wait( "flag_japan_post_garden" );
    struct thread ob_virgo_util::function_29164af2d4d89658();
    struct thread scene::play();
    ob_virgo_util::function_f8c90a6db244c560( struct, "fiftyfifty" );
}

// Namespace namespace_8a782610143da27a
// Params 0
// Checksum 0x475e8050, Offset: 0xd5e
// Size: 0xee
function function_9cb08127aa8e375b()
{
    wall = getent( "script_brush_japan_fight", "targetname" );
    wall delete();
    gate = getent( "japan_garden_gate", "targetname" );
    
    if ( isdefined( gate ) )
    {
        gate delete();
        structs = utility::getstructarray( "struct_gate_poof" );
        
        foreach ( spot in structs )
        {
            playfx( level._effect[ "enemy_vanish" ], spot.origin, spot.angles );
        }
    }
}

// Namespace namespace_8a782610143da27a
// Params 0
// Checksum 0x26286f9c, Offset: 0xe54
// Size: 0x17e
function japan_fight_combat()
{
    level.var_f1a791a8af5c828f = [];
    level.var_f1a791a8af5c828f[ level.var_f1a791a8af5c828f.size ] = "frozen_01";
    level.var_f1a791a8af5c828f[ level.var_f1a791a8af5c828f.size ] = "frozen_02";
    level.var_f1a791a8af5c828f[ level.var_f1a791a8af5c828f.size ] = "frozen_03";
    level.var_f1a791a8af5c828f[ level.var_f1a791a8af5c828f.size ] = "frozen_04";
    level.var_f1a791a8af5c828f[ level.var_f1a791a8af5c828f.size ] = "frozen_05";
    level.var_f1a791a8af5c828f[ level.var_f1a791a8af5c828f.size ] = "frozen_06";
    level.var_f1a791a8af5c828f[ level.var_f1a791a8af5c828f.size ] = "frozen_07";
    level.var_f1a791a8af5c828f[ level.var_f1a791a8af5c828f.size ] = "frozen_08";
    thread wakeup_robots();
    thread function_7383a6274a00eb71();
    thread function_7383a3274a00e4d8();
    thread function_7383a4274a00e70b();
    level thread virgo_audio::japan_fight_combat_walla();
    level utility::flag_wait( "flag_japan_fight_combat_start" );
    level thread ob_virgo_util::function_fdd5b4c27ba17b79();
    level utility::flag_wait( "flag_garden_wave_2_done" );
    level thread ob_virgo_util::function_fdd5b4c27ba17b79();
    level utility::flag_wait( "flag_garden_wave_3_done" );
    level thread ob_virgo_util::function_fdd5b4c27ba17b79();
    level utility::flag_wait_all( "flag_garden_wave_1_cleared", "flag_garden_wave_2_cleared", "flag_garden_wave_3_cleared" );
    thread function_ca91467c258acd7d();
    level utility::flag_wait( "flag_start_juggerbots" );
    thread function_7383a9274a00f20a();
    level utility::flag_wait( "flag_garden_wave_4_done" );
}

// Namespace namespace_8a782610143da27a
// Params 0
// Checksum 0x826e3ba7, Offset: 0xfda
// Size: 0x82
function function_ca91467c258acd7d()
{
    struct = utility::getstruct( "struct_garden_fifty_loop", "targetname" );
    scene_struct = utility::getstruct( "struct_scene_fifty_loop_garden", "targetname" );
    activity = self;
    level thread ob_virgo_util::function_1415e67b35bab88e( "trig_japan_garden_jugger_drop", "flag_garden_loop_interact" );
    activity thread ob_virgo_util::function_144604a50795e58f( "struct_garden_fifty_loop", "flag_garden_loop_interact" );
    level utility::flag_wait( "flag_garden_loop_interact" );
    level utility::flag_set( "flag_start_juggerbots" );
}

// Namespace namespace_8a782610143da27a
// Params 1
// Checksum 0x3cd93057, Offset: 0x1064
// Size: 0x2d
function special_death_watcher( var_6f5c0bece5deb66e )
{
    while ( var_6f5c0bece5deb66e.size )
    {
        var_6f5c0bece5deb66e = utility::array_removedead_or_dying( var_6f5c0bece5deb66e );
        waitframe();
    }
    
    level utility::flag_set( "flag_garden_jugg_dead" );
}

// Namespace namespace_8a782610143da27a
// Params 0
// Checksum 0xf52068b1, Offset: 0x1099
// Size: 0x98
function function_7383a6274a00eb71()
{
    level.garden_enemies = [];
    encounter_targetname = "encounter_japan_tank";
    level.var_8353d302b3a278f4 = activity_ai_encounters::function_92b671064b0b1ce2( encounter_targetname, 1, 1, 1, 1 );
    function_ef57f478f96b050c( level.var_8353d302b3a278f4, 1 );
    ai_spawn_director::add_spawned_callback( level.var_8353d302b3a278f4, &function_fc69a81bc0e924bc );
    activity_ai_encounters::function_6bf4ff2fbde584ee( level.var_8353d302b3a278f4, &function_75cd038d65f767fb, self );
    level utility::flag_wait( "flag_garden_enemies_spawned" );
    activity_progress_tracking::function_82d854bb84c20512( "garden_tracker", level.garden_enemies, &function_6c904bb122254779 );
}

// Namespace namespace_8a782610143da27a
// Params 4
// Checksum 0x395d0c6d, Offset: 0x1139
// Size: 0x59
function function_fc69a81bc0e924bc( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    level.garden_enemies[ level.garden_enemies.size ] = agent;
    agent thread freeze_robot( "flag_japan_fight_combat_start" );
}

// Namespace namespace_8a782610143da27a
// Params 4
// Checksum 0x1274ac78, Offset: 0x119a
// Size: 0x59
function function_d82067595db84531( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    level.var_5d4e476d6471b441[ level.var_5d4e476d6471b441.size ] = agent;
    agent thread freeze_robot( "flag_garden_wave_1_done" );
}

// Namespace namespace_8a782610143da27a
// Params 3
// Checksum 0x6996b3db, Offset: 0x11fb
// Size: 0x2b
function function_75cd038d65f767fb( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_garden_enemies_spawned" );
}

// Namespace namespace_8a782610143da27a
// Params 3
// Checksum 0x7ea67a20, Offset: 0x122e
// Size: 0x70
function function_6c904bb122254779( requestid, activity_instance, agent )
{
    level.garden_enemies = utility::array_removedead_or_dying( level.garden_enemies );
    
    if ( level.garden_enemies.size < 2 )
    {
        level utility::flag_set( "flag_garden_wave_1_done" );
    }
    
    if ( level.garden_enemies.size < 1 )
    {
        level utility::flag_set( "flag_garden_wave_1_cleared" );
    }
}

// Namespace namespace_8a782610143da27a
// Params 0
// Checksum 0xd68a6b20, Offset: 0x12a6
// Size: 0x98
function function_7383a3274a00e4d8()
{
    encounter_targetname = "encounter_japan_tank_2";
    level.var_5d4e476d6471b441 = [];
    level.var_59c102278906cf9 = activity_ai_encounters::function_92b671064b0b1ce2( encounter_targetname, 1, 1, 1, 1 );
    function_ef57f478f96b050c( level.var_59c102278906cf9, 1 );
    ai_spawn_director::add_spawned_callback( level.var_59c102278906cf9, &function_d82067595db84531 );
    activity_ai_encounters::function_6bf4ff2fbde584ee( level.var_59c102278906cf9, &function_2fab32bd3d16bc16, self );
    level utility::flag_wait( "flag_garden_enemies_spawned_2" );
    activity_progress_tracking::function_82d854bb84c20512( "garden_tracker_2", level.var_5d4e476d6471b441, &function_2817ec7ebe0a47e0 );
}

// Namespace namespace_8a782610143da27a
// Params 3
// Checksum 0x79b115bd, Offset: 0x1346
// Size: 0x70
function function_2817ec7ebe0a47e0( requestid, activity_instance, agent )
{
    level.var_5d4e476d6471b441 = utility::array_removedead_or_dying( level.var_5d4e476d6471b441 );
    
    if ( level.var_5d4e476d6471b441.size < 2 )
    {
        level utility::flag_set( "flag_garden_wave_2_done" );
    }
    
    if ( level.var_5d4e476d6471b441.size < 1 )
    {
        level utility::flag_set( "flag_garden_wave_2_cleared" );
    }
}

// Namespace namespace_8a782610143da27a
// Params 3
// Checksum 0x58309d1f, Offset: 0x13be
// Size: 0x2b
function function_2fab32bd3d16bc16( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_garden_enemies_spawned_2" );
}

// Namespace namespace_8a782610143da27a
// Params 0
// Checksum 0xc1f17f63, Offset: 0x13f1
// Size: 0x98
function function_7383a4274a00e70b()
{
    encounter_targetname = "encounter_japan_tank_3";
    level.var_5d4e466d6471b20e = [];
    level.var_7314cdf10d7fddf0 = activity_ai_encounters::function_92b671064b0b1ce2( encounter_targetname, 1, 1, 1, 1 );
    function_ef57f478f96b050c( level.var_7314cdf10d7fddf0, 1 );
    ai_spawn_director::add_spawned_callback( level.var_7314cdf10d7fddf0, &function_d82066595db842fe );
    activity_ai_encounters::function_6bf4ff2fbde584ee( level.var_7314cdf10d7fddf0, &function_83560954b6350e9d, self );
    level utility::flag_wait( "flag_garden_enemies_spawned_3" );
    activity_progress_tracking::function_82d854bb84c20512( "garden_tracker_3", level.var_5d4e466d6471b20e, &function_2817ed7ebe0a4a13 );
}

// Namespace namespace_8a782610143da27a
// Params 4
// Checksum 0xe3e7ee40, Offset: 0x1491
// Size: 0x59
function function_d82066595db842fe( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    level.var_5d4e466d6471b20e[ level.var_5d4e466d6471b20e.size ] = agent;
    agent thread freeze_robot( "flag_garden_wave_2_done" );
}

// Namespace namespace_8a782610143da27a
// Params 3
// Checksum 0x384cb9ca, Offset: 0x14f2
// Size: 0x2b
function function_83560954b6350e9d( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_garden_enemies_spawned_3" );
}

// Namespace namespace_8a782610143da27a
// Params 3
// Checksum 0xd291e2cd, Offset: 0x1525
// Size: 0x70
function function_2817ed7ebe0a4a13( requestid, activity_instance, agent )
{
    level.var_5d4e466d6471b20e = utility::array_removedead_or_dying( level.var_5d4e466d6471b20e );
    
    if ( level.var_5d4e466d6471b20e.size < 2 )
    {
        level utility::flag_set( "flag_garden_wave_3_done" );
    }
    
    if ( level.var_5d4e466d6471b20e.size < 1 )
    {
        level utility::flag_set( "flag_garden_wave_3_cleared" );
    }
}

// Namespace namespace_8a782610143da27a
// Params 0
// Checksum 0x338edb66, Offset: 0x159d
// Size: 0xb7
function function_7383a9274a00f20a()
{
    encounter_targetname = "encounter_japan_tank_4";
    level.var_5d4e496d6471b8a7 = [];
    level.var_8353d302b3a278f4 = activity_ai_encounters::function_92b671064b0b1ce2( encounter_targetname, 1, 1, 1, 1 );
    function_ef57f478f96b050c( level.var_8353d302b3a278f4, 1 );
    ai_spawn_director::add_spawned_callback( level.var_8353d302b3a278f4, &function_d82069595db84997 );
    activity_ai_encounters::function_6bf4ff2fbde584ee( level.var_8353d302b3a278f4, &function_aa235baa89234158, self );
    level utility::flag_wait( "flag_garden_enemies_spawned_4" );
    level thread rumble_players();
    playsoundatpos( ( 43126, -47755, 210 ), "evt_juggerbot_airdrop_impact_thunderous_01" );
    activity_progress_tracking::function_82d854bb84c20512( "garden_tracker_4", level.var_5d4e496d6471b8a7, &function_2817f27ebe0a5512 );
}

// Namespace namespace_8a782610143da27a
// Params 4
// Checksum 0x5818f961, Offset: 0x165c
// Size: 0x4b
function function_d82069595db84997( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    level.var_5d4e496d6471b8a7[ level.var_5d4e496d6471b8a7.size ] = agent;
}

// Namespace namespace_8a782610143da27a
// Params 3
// Checksum 0xc24941a0, Offset: 0x16af
// Size: 0x2b
function function_aa235baa89234158( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_garden_enemies_spawned_4" );
}

// Namespace namespace_8a782610143da27a
// Params 3
// Checksum 0xfcf3bcba, Offset: 0x16e2
// Size: 0x53
function function_2817f27ebe0a5512( requestid, activity_instance, agent )
{
    level.var_5d4e496d6471b8a7 = utility::array_removedead_or_dying( level.var_5d4e496d6471b8a7 );
    
    if ( level.var_5d4e496d6471b8a7.size < 1 )
    {
        level utility::flag_set( "flag_garden_wave_4_done" );
    }
}

// Namespace namespace_8a782610143da27a
// Params 1
// Checksum 0xb5f28fd0, Offset: 0x173d
// Size: 0x15f
function freeze_robot( flag_name )
{
    self endon( #"death" );
    self.hacked = 0;
    self.var_24954f14e27b448d = 0;
    delay = randomfloatrange( 0.25, 0.75 );
    struct = spawnstruct();
    struct.origin = self.origin + ( 0, 0, 0 );
    struct.angles = self.angles;
    
    if ( isdefined( self.script_noteworthy ) )
    {
        shot = self.script_noteworthy;
    }
    else
    {
        shot = utility::array_random( level.var_f1a791a8af5c828f );
    }
    
    thread ob_virgo_util::function_88d17055dbbf5a84( flag_name, delay );
    val::set( "virgo_garden_echo_robot", "ignoreme", 1 );
    struct thread scene::play( self, shot, "scene_sat_cin_virgo_garden_echo_robots" );
    thread virgo_audio::function_82a021be57ae5af1( flag_name );
    function_41ef7526fe2d9f9d( flag_name, delay );
    playfx( level._effect[ "echo_burst" ], struct.origin + ( 0, 0, 32 ) );
    struct scene::stop();
    self notify( #"robot_shutdown" );
    self.var_24954f14e27b448d = 1;
    val::reset( "virgo_garden_echo_robot", "ignoreme" );
}

// Namespace namespace_8a782610143da27a
// Params 2
// Checksum 0xbc83b4bc, Offset: 0x18a4
// Size: 0x4c
function function_41ef7526fe2d9f9d( flag_name, delay )
{
    self endon( #"robot_shutdown" );
    self endon( #"damage" );
    self endon( #"death" );
    level utility::flag_wait( flag_name );
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
}

// Namespace namespace_8a782610143da27a
// Params 0
// Checksum 0xb791b126, Offset: 0x18f8
// Size: 0x76
function function_eb39f6851ca081c6()
{
    struct = utility::getstruct( "struct_scene_japan_echo", "targetname" );
    struct thread ob_virgo_util::function_29164af2d4d89658();
    struct thread scene::play( undefined, "echo_03" );
    var_a03861f8df3b8222 = struct scene::function_b3c7b792a7a154fa( 2 );
    level thread ob_virgo_util::function_f8c90a6db244c560( struct, "fitfyfifty" );
    wait var_a03861f8df3b8222;
    level utility::flag_wait( "flag_garden_combat_start" );
    level utility::flag_set( "flag_start_garden_countdown" );
}

// Namespace namespace_8a782610143da27a
// Params 0
// Checksum 0xa683df37, Offset: 0x1976
// Size: 0xc2
function rumble_players()
{
    foreach ( player in level.players )
    {
        player playrumbleonentity( "heavy_3s" );
    }
    
    struct = utility::getstruct( "struct_garden_fifty_loop", "targetname" );
    earthquakeadvanced( 0.3, 0.2, 0.04, 1, struct.origin, 2000, 4000, 8000 );
}

// Namespace namespace_8a782610143da27a
// Params 2, eflags: 0x4
// Checksum 0x81231b7c, Offset: 0x1a40
// Size: 0x6a
function private function_585dd586fbe8a210( scene_struct, var_578f5d219aa28a92 )
{
    waitframe();
    fiftyfifty_ent = scene_struct scene::get_entity( var_578f5d219aa28a92 );
    fiftyfifty_ent.team = level.players[ 0 ].team;
    level notify( #"highvis_reload_outline", fiftyfifty_ent.team, [ fiftyfifty_ent ] );
}

// Namespace namespace_8a782610143da27a
// Params 0
// Checksum 0xe7d55893, Offset: 0x1ab2
// Size: 0x99
function prestream_harper_boss()
{
    foreach ( player in level.players )
    {
        player thread utility::player_prestream_assets( "virgo_japan_fight", "model", [ "xcomp_c_sat_usa_npc_harper_boss_cradle" ], [ 2000 ], -1 );
    }
}

