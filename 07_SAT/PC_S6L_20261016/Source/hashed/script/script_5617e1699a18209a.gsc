// script_5617e1699a18209a  (hash_5617e1699a18209a.gscc) (size: 27113 Bytes / 0x69e9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7959c6fb (2035926779)
// size ...... 27113 (0x69e9)
// includes .. 29  (offset: 0x603d)
// strings ... 145 (offset: 0x6125)
// dev strs .. 0   (offset: 0x69e9)
// exports ... 50  (offset: 0x3cf5)
// cseg ...... 0xe6b + 0x2e8a (0x3cf5)
// imports ... 228 (offset: 0x44c5)
// animtree1 . 0   (offset: 0x69e9)
// animtree2 . 0   (offset: 0x69e9)
#using script_4d6ddd547bcd9399;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\ai_spawn_director_utility;
#using scripts\common\ai\ai_utility;
#using scripts\common\puzzles\connection_puzzle;
#using scripts\common\scene;
#using scripts\common\snd\snd;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\waypoint_objective_handler;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\scriptable_door_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\interaction;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_audio;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_util;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_vo;
#using scripts\mp\ob\jailbreak_machine;
#using scripts\mp\ob\systems\ob_item_select;
#using scripts\mp\objective_marker_bundle_helper_mp;
#using scripts\mp\objidpoolmanager;

#namespace namespace_6334eb96c2d6266a;

/#

    // Namespace namespace_6334eb96c2d6266a
    // Params 0
    // Checksum 0x6ef2934, Offset: 0xe89
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_6334eb96c2d6266a
// Params 0, eflags: 0x5
// Checksum 0xe6cb9afe, Offset: 0xe96
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_a8bd3cae38c97d3", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_6334eb96c2d6266a
// Params 0, eflags: 0x4
// Checksum 0xe449ca83, Offset: 0xebf
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LIBRA_ARMORY_PREPARE";
    activity_common::registeractivitytype( "OB_LIBRA_ARMORY_PREPARE", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_ARMORY_PREPARE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_ARMORY_PREPARE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_ARMORY_PREPARE", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_6334eb96c2d6266a
// Params 0
// Checksum 0x4cc12b5a, Offset: 0xf20
// Size: 0x65
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance setup();
    }
    
    level thread setup_jailbreak();
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_6334eb96c2d6266a
// Params 0
// Checksum 0xbc8da7ff, Offset: 0xf8d
// Size: 0x37
function setup_jailbreak()
{
    utility::flag_wait( "scriptables_ready" );
    scriptables = getentitylessscriptablearray( "jbm_scriptable", "script_noteworthy" );
    scriptables[ 0 ] jailbreak_machine::init( 0, 4, 1 );
}

// Namespace namespace_6334eb96c2d6266a
// Params 0
// Checksum 0xa1a2fb29, Offset: 0xfcc
// Size: 0x47
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    activity_instance armory_main();
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_6334eb96c2d6266a
// Params 0
// Checksum 0x9bd8b2cb, Offset: 0x101b
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_6334eb96c2d6266a
// Params 0
// Checksum 0xd23094fd, Offset: 0x103f
// Size: 0xae
function setup_ui_widget()
{
    ob_story_mission_utils::objective_text_show( "ob_libra_ambush_exit" );
    level utility::flag_wait( "flag_armory_entered" );
    ob_story_mission_utils::objective_text_show( "OB_LIBRA_ARMORY_PREPARE" );
    level utility::flag_wait( "flag_armory_to_processing_intro_played" );
    ob_story_mission_utils::objective_text_show( "ob_libra_armory_prepare_mech" );
    level utility::flag_wait( "flag_armory_to_processing_door_destroyed" );
    ob_story_mission_utils::objective_text_show( "ob_libra_armory_prepare_clean_up" );
    level utility::flag_wait_all( "flag_armory_bots_dead", "flag_all_scene_guild_bots_dead", "flag_armory_juggerbot_dead" );
    ob_story_mission_utils::objective_text_show( "ob_libra_ambush_exit" );
    level utility::flag_wait( "flag_lab_door_01_opened" );
    ob_story_mission_utils::objective_text_show( "ob_libra_armory_prepare_clean_up" );
    level utility::flag_wait( "flag_pre_processing_dead" );
    ob_story_mission_utils::objective_text_show( "ob_libra_ambush_exit" );
}

/#

    // Namespace namespace_6334eb96c2d6266a
    // Params 0
    // Checksum 0x41558d24, Offset: 0x10f5
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_6334eb96c2d6266a
// Params 0
// Checksum 0xbc80eaf4, Offset: 0x1102
// Size: 0x17
function setup()
{
    level utility::flag_set( "flag_ambush_exit_tunnel_vo_done" );
    level thread function_bb859a32890e1ebe();
}

// Namespace namespace_6334eb96c2d6266a
// Params 0
// Checksum 0xe918b0cb, Offset: 0x1121
// Size: 0x5d0
function armory_main()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    level utility::flag_set( "flag_armory_prepare_begin" );
    thread setup_ui_widget();
    connection_puzzle_init();
    mech_activation_button = utility::getstruct( "armory_mech_laptop_interact_org", "targetname" );
    mech_activation_button thread ob_story_mission_utils::function_e89ed2a08ce38bbf( "mech_activation_button", level.connection_puzzle_asset );
    thread function_613bbd6ba86dfd42();
    thread mp_sat_ob_libra_util::function_3404036aa1432445( "processing_alt_door" );
    thread function_36bdbd68c11a0cfb();
    level thread mp_sat_ob_libra_vo::armory_prepare();
    level thread setup_guild_bots();
    level thread armory_alarms();
    level thread mp_sat_ob_libra_vo::function_2ccb8eb3d3d3a28b();
    level.legs = getentarray( "armory_mech_legs", #targetname );
    
    foreach ( base in level.legs )
    {
        base thread scene::play( base, "init", "scene_sat_cin_libra_armory_mech_activation" );
        spawndata = spawnstruct();
        spawndata.origin = base gettagorigin( "tag_turret_attach" );
        spawndata.angles = base gettagangles( "tag_turret_attach" );
        base.torso = vehicle::spawn( %"vehiclebundle:veh_libra_mech_turret", spawndata );
        base.torso.owner = level;
        base.torso setcandamage( 0 );
        base.torso vehicle::godon();
        base.torso.empnotallowed = 1;
        base.torso function_d143ff6924adc05f( 1, 0 );
        base.torso linkto( base, "tag_turret_attach", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        base.var_2625efdafde82b32 = getentarray( base.target, #targetname );
        
        foreach ( ent in base.var_2625efdafde82b32 )
        {
            if ( ent.script_noteworthy == "mech_torso_clip" )
            {
                base.torso.clip = ent;
                base.torso.clip linkto( base.torso, "tag_turret", ( 0, 0, 0 ), ( 0, 0, 0 ) );
            }
        }
        
        thread function_8e7af61518a4536d( base );
    }
    
    thread mech_activation_button();
    thread function_af56284789ffd88b();
    level.destruction_targets = utility::getstructarray( "armory_destruction_target" );
    thread function_f6a0d814c62e2c44();
    trigger = getent( "processing_main_door", #script_noteworthy );
    
    if ( isdefined( trigger ) )
    {
        trigger thread scriptable_door_utility::simple_lock_door();
    }
    
    utility::flag_wait( "flag_mech_activation_hack_completed" );
    mech_activation_button thread ob_story_mission_utils::remove_connection_puzzle_streaming_volume();
    level utility::flag_wait( "flag_armory_to_processing_door_destroyed" );
    
    foreach ( player in level.players )
    {
        function_d4daec94abe37b46( player );
        
        if ( isdefined( player.var_b0ccc9c433c21c9d ) )
        {
            objective_delete( player.var_b0ccc9c433c21c9d );
        }
    }
    
    level.armory_juggerbot = ai_spawn_director::spawn_targetname( "armory_juggerbot", 1 );
    
    if ( !isarray( level.armory_juggerbot ) && isalive( level.armory_juggerbot ) )
    {
        level.armory_juggerbot.team = "team_hundred_ninety";
        level.armory_juggerbot thread function_dbb67e65eabcec5c();
    }
    else
    {
        utility::flag_set( "flag_armory_juggerbot_dead" );
    }
    
    level utility::flag_wait_all( "flag_armory_bots_dead", "flag_all_scene_guild_bots_dead", "flag_armory_juggerbot_dead" );
    activateworldevent( "VFX_Libra_Labs_Calm_Ambient" );
    level thread mp_sat_ob_libra_vo::last_of_them();
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "lab_door_01_waypoint_org", undefined, "lab_door_01_waypoint_org_waypoint_done", undefined, undefined, 1, undefined, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 16 ) );
    level thread mp_sat_ob_libra_util::function_776ea74dd9e92d46( "flag_lab_door_01_opened", "lab_door_01_waypoint_org" );
    level utility::flag_wait( "flag_lab_door_01_opened" );
    level.var_7c60caafb0bb3790 = utility::getstruct( "tag_align_processing_center" );
    level.var_7c60caafb0bb3790 scene::add_spawn_function( &mp_sat_ob_libra_util::fire_custom, "fiftyfifty" );
    level.var_7c60caafb0bb3790 scene::add_spawn_function( &mp_sat_ob_libra_util::fire_custom, "enemy01" );
    level.var_7c60caafb0bb3790 scene::pre_stream( undefined, undefined, -1, "scene_sat_cin_libra_processing_center" );
    level thread namespace_eee6457f670d8545::function_fea33e63d0f156d1();
    level thread mp_sat_ob_libra_vo::armory_prepare_checkin();
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "processing_waypoint_org", undefined, "processing_waypoint_org_waypoint_done", undefined, undefined, 1 );
    level thread mp_sat_ob_libra_util::function_776ea74dd9e92d46( "flag_pre_processing_dead", "processing_waypoint_org" );
    level utility::flag_wait( "flag_pre_processing_dead" );
}

// Namespace namespace_6334eb96c2d6266a
// Params 0
// Checksum 0x3be05869, Offset: 0x16f9
// Size: 0x99
function function_dbb67e65eabcec5c()
{
    self endon( #"death" );
    scene = utility::getstruct( "armory_juggerbot_intro" );
    
    if ( isdefined( scene ) )
    {
        scene scene::play( level.armory_juggerbot );
        juggerbot_start_goal = utility::getstruct( "juggerbot_start_goal" );
        level.armory_juggerbot thread ai_utility::go_to_node( juggerbot_start_goal );
        gv_large = getnoentvolumearray( "armory_large_gv", #targetname )[ 0 ];
        level.armory_juggerbot thread function_aecd4b35fc2b4e63( gv_large, "flag_armory_to_processing_door_passed" );
    }
}

// Namespace namespace_6334eb96c2d6266a
// Params 0
// Checksum 0xa9612611, Offset: 0x179a
// Size: 0x7b
function function_613bbd6ba86dfd42()
{
    thread ob_story_mission_utils::item_spawn_weapon( "s_weapon_armory", "flag_igc_processing_done", 1 );
    thread ob_story_mission_utils::item_spawn_equipment( "s_equip_armory", "flag_igc_processing_done", 1 );
    thread ob_story_mission_utils::function_e6799e9a19df2365( "s_supply_cache_libra_armory" );
    case_struct = utility::getstruct( "armory_ability_struct", "targetname" );
    
    if ( isdefined( case_struct ) )
    {
        thread ob_item_select::function_95f9ecc2af4693f6( case_struct.origin, "super_grappling_hook_sm", "super_portal_summon", #"tactical" );
    }
}

// Namespace namespace_6334eb96c2d6266a
// Params 0
// Checksum 0xd311b904, Offset: 0x181d
// Size: 0xb1
function function_f6a0d814c62e2c44()
{
    mp_sat_ob_libra_util::function_c58a10af89e58f3f( "armory_to_processing_door_interact", "flag_armory_to_processing_button_interacted", &"sat_ob_story_missions/interact_unlock" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "armory_to_processing_door_interact", undefined, "armory_to_processing_door_interact_waypoint_done", undefined, undefined, 1, undefined, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 16 ) );
    level thread mp_sat_ob_libra_util::function_776ea74dd9e92d46( "flag_armory_to_processing_button_interacted", "armory_to_processing_door_interact" );
    level utility::flag_wait( "flag_armory_to_processing_button_interacted" );
    armory_to_processing_door_interact = utility::getstruct( "armory_to_processing_door_interact" );
    playsoundatpos( armory_to_processing_door_interact.origin, "fly_hyd_hatch_locked" );
    wait 0.3;
    level thread mp_sat_ob_libra_vo::armory_access_denied( armory_to_processing_door_interact.origin );
    mp_sat_ob_libra_vo::armory_to_processing_intro();
}

// Namespace namespace_6334eb96c2d6266a
// Params 0
// Checksum 0x4cc684b5, Offset: 0x18d6
// Size: 0xc5
function function_8128dc145e73f4c1()
{
    if ( level utility::flag( "flag_mech_activation_hack_completed" ) )
    {
        return;
    }
    
    level utility::flag_clear( "flag_mech_activation_puzzle_active" );
    level.mech_activation_button = utility::getstruct( "armory_mech_laptop_interact_org", "targetname" );
    level.mech_activation_button.interact = interaction::register_interact( level.mech_activation_button.origin, 64, &function_48e939a854311eed, &"sat_ob_story_missions/interact_hack", undefined, undefined, undefined, "HINT_BUTTON" );
    level.mech_activation_button.obj_root = self;
    level.current_activity thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "armory_mech_laptop_interact_org", undefined, "armory_mech_laptop_interact_org_waypoint_done", undefined, undefined, 1, undefined, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 16 ) );
}

// Namespace namespace_6334eb96c2d6266a
// Params 0
// Checksum 0xa9e043a5, Offset: 0x19a3
// Size: 0x16
function mech_activation_button()
{
    level utility::flag_wait( "flag_armory_to_processing_intro_played" );
    thread function_8128dc145e73f4c1();
}

// Namespace namespace_6334eb96c2d6266a
// Params 1
// Checksum 0xa396ff, Offset: 0x19c1
// Size: 0x15
function function_48e939a854311eed( player )
{
    thread function_be19e56410df00f1( player );
}

// Namespace namespace_6334eb96c2d6266a
// Params 1
// Checksum 0x24f6db5d, Offset: 0x19de
// Size: 0x400
function function_be19e56410df00f1( player )
{
    if ( level utility::flag( "flag_mech_activation_puzzle_active" ) || level utility::flag( "flag_mech_activation_hack_completed" ) || !player val::get( "allow_connection_puzzle" ) )
    {
        return;
    }
    
    consoles = getscriptablearray( "mech_activate_console", "targetname" );
    level utility::flag_set( "flag_mech_activation_puzzle_active" );
    player thread libra_audio::function_d014452496a2e975();
    self delete();
    waypoint_objective_handler::waypoint_objective_handler_cancel( "armory_mech_laptop_interact_org" );
    skip_puzzle = getdvarint( @"connection_puzzle_skip", 0 );
    
    if ( skip_puzzle != 0 || isautopilot( player ) )
    {
        finished = "ConnectionPuzzleCompleted";
        wait 2;
    }
    else
    {
        player mp_sat_ob_libra_util::start_interact_scene( "mech_terminal_interact" );
        
        if ( player connection_puzzle::open( level.connection_puzzle_asset, "armory_puzzle" ) )
        {
            foreach ( spectator in level.players )
            {
                if ( spectator != player )
                {
                    spectator thread connection_puzzle::open( level.connection_puzzle_asset, "armory_puzzle", 1 );
                }
            }
            
            foreach ( var_190f59357d8260f7 in consoles )
            {
                var_190f59357d8260f7 setscriptablepartstate( #"base", #"hash_cacbbd1f76200a42" );
            }
            
            finished = player utility::waittill_any_return( "ConnectionPuzzleClosed", "ConnectionPuzzleCompleted", "death_or_disconnect" );
            
            foreach ( p in level.players )
            {
                if ( p != player )
                {
                    p connection_puzzle::close_spectator( level.connection_puzzle_asset, "armory_puzzle" );
                }
            }
        }
        
        if ( player )
        {
            player mp_sat_ob_libra_util::function_d68eec31414afe2e( "mech_terminal_interact" );
        }
    }
    
    if ( finished == "ConnectionPuzzleCompleted" || connection_puzzle::is_instance_complete( level.connection_puzzle_asset, "armory_puzzle" ) )
    {
        level utility::flag_set( "flag_mech_activation_hack_completed" );
        
        foreach ( var_190f59357d8260f7 in consoles )
        {
            var_190f59357d8260f7 setscriptablepartstate( #"base", #"circuit_operational" );
        }
        
        player connection_puzzle::close();
        thread function_ae9db9736235094f( player );
        return;
    }
    
    foreach ( var_190f59357d8260f7 in consoles )
    {
        var_190f59357d8260f7 setscriptablepartstate( #"base", #"circuit_interrupted" );
    }
    
    wait 0.5;
    level.mech_activation_button.obj_root thread function_8128dc145e73f4c1();
}

// Namespace namespace_6334eb96c2d6266a
// Params 1
// Checksum 0x4eae9c97, Offset: 0x1de6
// Size: 0x122
function function_ae9db9736235094f( player )
{
    level utility::flag_set( "flag_armory_mech_activate_begin" );
    thread libra_audio::function_365b0bd51dacb480();
    
    for ( i = 0; i < level.legs.size ; i++ )
    {
        level.legs[ i ].torso thread libra_audio::mech_hum_start();
    }
    
    wait 0.5;
    level thread mp_sat_ob_libra_vo::function_7d261949ca5c976c();
    wait 2.5;
    i = 0;
    level.mech_flag_array = [];
    
    foreach ( base in level.legs )
    {
        base thread mech_base_activate( i );
        i++;
    }
    
    level utility::flag_wait_all_array( level.mech_flag_array );
    level utility::flag_set( "flag_armory_mech_in_fire_position" );
    level thread mp_sat_ob_libra_vo::armory_prepare_mech_online();
}

// Namespace namespace_6334eb96c2d6266a
// Params 1
// Checksum 0x1134b8a0, Offset: 0x1f10
// Size: 0xc4
function mech_base_activate( i )
{
    base = self;
    base.scene_done_set_flag = "flag_mech_activated" + string( i );
    level.mech_flag_array[ level.mech_flag_array.size ] = base.scene_done_set_flag;
    wait i;
    base.torso thread libra_audio::mech_activate( i );
    base scene::add_scene_func( "scene_sat_cin_libra_armory_mech_activation", &scene_done_set_flag, "callback_done" );
    base thread scene::play( base, "activate", "scene_sat_cin_libra_armory_mech_activation" );
    wait 2;
    base setmodel( %"lights::xcomp_veh_sat_mil_drone_biped_legs" );
    base.torso setscriptablepartstate( "mech_lights", "lights_on" );
}

// Namespace namespace_6334eb96c2d6266a
// Params 0
// Checksum 0xec36551b, Offset: 0x1fdc
// Size: 0x13
function scene_done_set_flag()
{
    level utility::flag_set( self.scene_done_set_flag );
}

// Namespace namespace_6334eb96c2d6266a
// Params 1
// Checksum 0xf1ecefac, Offset: 0x1ff7
// Size: 0xb4
function function_8e7af61518a4536d( base )
{
    base.var_ed92d3edd3eded9 = utility::getstruct( base.target );
    base.var_ed92d3edd3eded9.base = base;
    base.button = base.var_ed92d3edd3eded9;
    base.scene_struct = utility::getstruct( base.var_ed92d3edd3eded9.target );
    base.scene_struct.base = base;
    thread function_68b9a216fd575fc7( base, &"sat_ob_story_missions/interact_control", base.scene_struct );
}

// Namespace namespace_6334eb96c2d6266a
// Params 1
// Checksum 0xa8b457db, Offset: 0x20b3
// Size: 0x152
function function_966630a9d8a006eb( mech )
{
    mp_sat_ob_libra_util::function_4761f7db1c5265f0();
    self usevehicle( mech.torso, 0 );
    mech.torso.owner = self;
    mech.torso.teamfriendlyto = self.team;
    mech.torso setentityowner( self );
    mech.torso setotherent( self );
    mech.torso setvehicleteam( self.team );
    pbgpostfxbundlestart( self, %"cer_mp_gunship" );
    self setclientomnvar( "ui_remote_turrent_is_mech_state", 1 );
    killstreak_utility::function_d546aaa588f088c3( "remote_turret", "on" );
    thread function_1ff4387d382d9b3( mech );
    self.var_f12969e76f45932e = snd::play( "evt_armory_mech_control_lp", self );
    
    if ( !level utility::flag( "flag_armory_to_processing_door_destroyed" ) )
    {
        mech_door_obj_org = utility::getstruct( "mech_door_obj_org" );
        
        if ( isdefined( mech_door_obj_org ) )
        {
            self.var_b0ccc9c433c21c9d = objective_marker_bundle_helper_mp::mp_createobjectivemarkerfrombundlexhash( %"objectivemarker:sat_ob_objectivemarker_storymissionmain" );
            objidpoolmanager::objective_playermask_addshowplayer( self.var_b0ccc9c433c21c9d, self );
            objidpoolmanager::update_objective_position( self.var_b0ccc9c433c21c9d, mech_door_obj_org.origin );
        }
    }
}

// Namespace namespace_6334eb96c2d6266a
// Params 1
// Checksum 0xa51e97ed, Offset: 0x220d
// Size: 0xc8
function function_1ff4387d382d9b3( mech )
{
    self endon( #"death_or_disconnect" );
    mech endon( #"hash_60c11a1112f1aa90" );
    last_angles = self getplayerangles();
    is_aiming = 0;
    
    while ( true )
    {
        current_angles = self getplayerangles();
        
        if ( distancesquared( current_angles, last_angles ) > 0.25 )
        {
            if ( !is_aiming )
            {
                self.var_8eefe66c4e4c6423 = snd::play( "evt_armory_console_mech_turret_move_lp", mech.torso );
                is_aiming = 1;
            }
        }
        else if ( is_aiming )
        {
            if ( isdefined( self.var_8eefe66c4e4c6423 ) )
            {
                snd::stop( self.var_8eefe66c4e4c6423 );
                self.var_8eefe66c4e4c6423 = undefined;
            }
            
            is_aiming = 0;
        }
        
        last_angles = current_angles;
        waitframe();
    }
}

// Namespace namespace_6334eb96c2d6266a
// Params 3
// Checksum 0x2fe45167, Offset: 0x22dd
// Size: 0x1ee
function function_68b9a216fd575fc7( base, var_81916649a7b1af22, interact_scene_struct )
{
    level utility::flag_wait( "flag_armory_mech_in_fire_position" );
    radius = 52;
    interact = interaction::register_interact( base.button.origin, radius, &function_5959d42cd8dd8edc, var_81916649a7b1af22, undefined, undefined, undefined, "HINT_BUTTON" );
    interact sethintdisplayrange( 100 );
    interact sethintdisplayfov( 360 );
    interact setusefov( 45 );
    interact.obj_root = self;
    interact.use_origin = base.button.origin;
    interact.use_radius = radius;
    interact.interact_scene_struct = interact_scene_struct;
    interact.mech = base.button.base;
    interact.struct_targetname = base.var_ed92d3edd3eded9.targetname;
    
    if ( !isdefined( level.var_9aa249948cb5092d ) )
    {
        level.var_9aa249948cb5092d = [];
    }
    
    level.var_9aa249948cb5092d[ level.var_9aa249948cb5092d.size ] = interact;
    
    foreach ( player in level.players )
    {
        thread ob_story_mission_utils::function_56960723e6738b6c( undefined, interact.struct_targetname, undefined, interact.struct_targetname + "_waypoint_done", undefined, player, 0, 0, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 16 ) );
    }
}

// Namespace namespace_6334eb96c2d6266a
// Params 0
// Checksum 0x46eb1f8, Offset: 0x24d3
// Size: 0x99
function function_af56284789ffd88b()
{
    armory_secret_door_interact = utility::getstruct( "armory_secret_door_interact" );
    radius = 64;
    level.armory_secret_door_interact = interaction::register_interact( armory_secret_door_interact.origin, radius, &function_7216c7eca8fed500, &"sat_ob_story_missions/interact_unlock" );
    level.armory_secret_door_interact.obj_root = self;
    level.armory_secret_door_interact.use_origin = armory_secret_door_interact.origin;
    level.armory_secret_door_interact.use_radius = radius;
}

// Namespace namespace_6334eb96c2d6266a
// Params 1
// Checksum 0xaf1c99c5, Offset: 0x2574
// Size: 0x97
function function_7216c7eca8fed500( player )
{
    level.armory_secret_door_interact endon( #"death" );
    self makeunusable();
    armory_secret_door_interact = utility::getstruct( "armory_secret_door_interact" );
    playsoundatpos( armory_secret_door_interact.origin, "fly_hyd_hatch_locked" );
    wait 0.3;
    level thread mp_sat_ob_libra_vo::armory_access_denied( level.armory_secret_door_interact.origin );
    wait 1.5;
    self makeusable();
    self setuserange( 64 );
    interaction::set_interact_hint_string( &"sat_ob_story_missions/interact_unlock" );
}

// Namespace namespace_6334eb96c2d6266a
// Params 1
// Checksum 0xfccab8f0, Offset: 0x2613
// Size: 0x33f
function function_5959d42cd8dd8edc( player )
{
    if ( utility::ent_flag( "ent_flag_mech_in_use" ) )
    {
        return;
    }
    
    utility::ent_flag_set( "ent_flag_mech_in_use" );
    player utility::ent_flag_set( "ent_flag_player_using_mech" );
    
    if ( !level utility::flag( "flag_armory_to_processing_door_destroyed" ) )
    {
        foreach ( var_5b41f39c89231fe1 in level.players )
        {
            if ( isdefined( var_5b41f39c89231fe1 waypoint_objective_handler::function_c2eeb9e0ffc2533d( self.struct_targetname ) ) )
            {
                level thread waypoint_objective_handler::waypoint_objective_handler_cancel( self.struct_targetname, var_5b41f39c89231fe1 );
            }
        }
        
        function_d4daec94abe37b46( player );
    }
    
    self makeunusable();
    playsoundatpos( self.origin, "evt_armory_console_mech_enter_button" );
    player playsoundtoplayer( "evt_armory_console_mech_enter_foley", player );
    player val::set( "mech_control_values", "allow_movement", 0 );
    player val::set( "mech_control_values", "crouch", 0 );
    player val::set( "mech_control_values", "prone", 0 );
    player val::set( "mech_control_values", "melee", 0 );
    player val::set( "mech_control_values", "offhand_primary_weapons", 0 );
    player val::set( "mech_control_values", "offhand_secondary_weapons", 0 );
    player val::set( "mech_control_values", "usability", 1 );
    player val::set( "mech_control_values", "killstreaks", 0 );
    player val::set( "mech_control_values", "weapon_switch", 0 );
    player val::set( "mech_control_values", "action_slot_weapon", 0 );
    player val::set( "mech_control_values", "armor", 0 );
    player val::set( "mech_control_values", "supers", 0 );
    player val::set( "mech_control_values", "damage", 0 );
    player utility::delaythread( 0.25, &function_15e96e84b0eea816, 1, 0.5 );
    self.mech.scene_struct scene::play( player, "enter" );
    self.mech.scene_struct thread scene::play( player, "idle" );
    waitframe();
    level thread mp_sat_ob_libra_vo::fire_at_the_door();
    player thread function_966630a9d8a006eb( self.mech );
    player thread mech_outline( self.mech );
    player thread function_3059ff79ba665501( self );
    player function_f06d8944c437e298( self.mech );
    self.mech notify( #"hash_60c11a1112f1aa90" );
    thread function_26fc99099f08ed44( player );
    wait 0.5;
    
    if ( !level utility::flag( "start_processing" ) )
    {
        self makeusable();
        self setuserange( 64 );
        interaction::set_interact_hint_string( &"sat_ob_story_missions/interact_control" );
    }
    
    utility::ent_flag_clear( "ent_flag_mech_in_use" );
    
    if ( isdefined( player ) )
    {
        player utility::ent_flag_clear( "ent_flag_player_using_mech" );
    }
    
    if ( !level utility::flag( "flag_armory_to_processing_door_destroyed" ) )
    {
        function_d538011f34fe72dc();
    }
}

// Namespace namespace_6334eb96c2d6266a
// Params 2
// Checksum 0xc63e1122, Offset: 0x295a
// Size: 0x36
function function_15e96e84b0eea816( var_1d38d06d1b0dc98, duration )
{
    self endon( #"death_or_disconnect" );
    thread emp_debuff::play_emp_scramble( var_1d38d06d1b0dc98 );
    wait duration;
    thread emp_debuff::stop_emp_scramble( var_1d38d06d1b0dc98 );
}

// Namespace namespace_6334eb96c2d6266a
// Params 1
// Checksum 0x4f56b145, Offset: 0x2998
// Size: 0xab
function function_3059ff79ba665501( var_76f621aa9099d07b )
{
    self endon( #"hash_cd8ff27f547cb17c" );
    self waittill( #"death_or_disconnect" );
    
    if ( isdefined( var_76f621aa9099d07b ) )
    {
        var_76f621aa9099d07b thread function_26fc99099f08ed44( self );
    }
    
    if ( isdefined( self.var_8eefe66c4e4c6423 ) )
    {
        snd::stop( self.var_8eefe66c4e4c6423 );
        self.var_8eefe66c4e4c6423 = undefined;
    }
    
    if ( isdefined( self.var_f12969e76f45932e ) )
    {
        snd::stop( self.var_f12969e76f45932e );
        self.var_8eefe66c4e4c6423 = undefined;
    }
    
    if ( isdefined( var_76f621aa9099d07b ) )
    {
        var_76f621aa9099d07b makeusable();
        var_76f621aa9099d07b setuserange( 64 );
        var_76f621aa9099d07b interaction::set_interact_hint_string( &"sat_ob_story_missions/interact_control" );
    }
}

// Namespace namespace_6334eb96c2d6266a
// Params 1
// Checksum 0x468d64e7, Offset: 0x2a4b
// Size: 0x149
function function_26fc99099f08ed44( player )
{
    player endon( #"death_or_disconnect" );
    
    if ( isdefined( player ) )
    {
        player notify( #"hash_cd8ff27f547cb17c" );
        
        if ( isdefined( player.var_b0ccc9c433c21c9d ) )
        {
            objective_delete( player.var_b0ccc9c433c21c9d );
        }
        
        player function_d5f69d833fd73377();
        
        if ( player isusingremoteturret() )
        {
            player leavevehicle();
        }
        
        player playsoundtoplayer( "evt_armory_console_mech_exit_foley", player );
        
        if ( isdefined( player.var_8eefe66c4e4c6423 ) )
        {
            snd::stop( player.var_8eefe66c4e4c6423 );
            player.var_8eefe66c4e4c6423 = undefined;
        }
        
        if ( isdefined( player.var_f12969e76f45932e ) )
        {
            snd::stop( player.var_f12969e76f45932e );
            player.var_8eefe66c4e4c6423 = undefined;
        }
        
        pbgpostfxbundleend( player, %"cer_mp_gunship" );
        player setclientomnvar( "ui_remote_turrent_is_mech_state", 0 );
        player killstreak_utility::function_d546aaa588f088c3( "remote_turret", "off" );
        
        if ( !level utility::flag( "start_processing" ) )
        {
            player thread function_15e96e84b0eea816( 1, 0.25 );
            self.mech.scene_struct scene::play( player, "exit" );
        }
        
        player val::reset_all( "mech_control_values" );
    }
}

// Namespace namespace_6334eb96c2d6266a
// Params 1
// Checksum 0x995c714e, Offset: 0x2b9c
// Size: 0xd9
function function_d4daec94abe37b46( player )
{
    foreach ( interact in level.var_9aa249948cb5092d )
    {
        if ( isdefined( player waypoint_objective_handler::function_c2eeb9e0ffc2533d( interact.struct_targetname ) ) )
        {
            player.waypoint_objective_state[ interact.struct_targetname ] = 3;
            player.var_52f632411cc75d51[ interact.struct_targetname ] = undefined;
            player notify( "cancel_waypoint_objective_handler" + interact.struct_targetname );
        }
    }
}

// Namespace namespace_6334eb96c2d6266a
// Params 0
// Checksum 0x62114859, Offset: 0x2c7d
// Size: 0x15d
function function_d538011f34fe72dc()
{
    foreach ( player in level.players )
    {
        if ( player utility::ent_flag( "ent_flag_player_using_mech" ) )
        {
            continue;
        }
        
        foreach ( interact in level.var_9aa249948cb5092d )
        {
            if ( !interact utility::ent_flag( "ent_flag_mech_in_use" ) )
            {
                if ( !isdefined( player.waypoint_objective_state[ interact.struct_targetname ] ) )
                {
                    level thread ob_story_mission_utils::function_56960723e6738b6c( undefined, interact.struct_targetname, undefined, interact.struct_targetname + "_waypoint_done", undefined, player, 0, 0, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 16 ) );
                }
            }
        }
    }
}

// Namespace namespace_6334eb96c2d6266a
// Params 1
// Checksum 0x12a29808, Offset: 0x2de2
// Size: 0x1f9
function mech_outline( mech )
{
    self notify( #"hash_7920227453bc2460" );
    self endon( #"hash_7920227453bc2460" );
    self endon( #"death_or_disconnect" );
    mech endon( #"hash_60c11a1112f1aa90" );
    
    while ( true )
    {
        actors = getaiarray();
        
        if ( !isdefined( self.var_fdc85853d76d59cd ) )
        {
            self.var_fdc85853d76d59cd = [];
        }
        
        foreach ( actor in actors )
        {
            if ( isalive( actor ) )
            {
                if ( arraycontains( self.var_fdc85853d76d59cd, actor ) || actor.ignoreme )
                {
                    continue;
                }
                
                if ( actor.team == "team_hundred_ninety" || actor.team == "team_hundred_ninety_nine" )
                {
                    actor hudoutlineenableforclient( self, "outline_nodepth_red" );
                    self.var_fdc85853d76d59cd[ self.var_fdc85853d76d59cd.size ] = actor;
                }
            }
        }
        
        foreach ( player in level.players )
        {
            if ( arraycontains( self.var_fdc85853d76d59cd, player ) )
            {
                continue;
            }
            
            player hudoutlineenableforclient( self, "outline_nodepth_blue" );
            self.var_fdc85853d76d59cd[ self.var_fdc85853d76d59cd.size ] = player;
        }
        
        wait 0.1;
    }
}

// Namespace namespace_6334eb96c2d6266a
// Params 0
// Checksum 0xd4dc2268, Offset: 0x2fe3
// Size: 0x97
function function_d5f69d833fd73377()
{
    if ( isdefined( self.var_fdc85853d76d59cd ) )
    {
        foreach ( var_19877914b1415bf3 in self.var_fdc85853d76d59cd )
        {
            if ( isdefined( var_19877914b1415bf3 ) )
            {
                var_19877914b1415bf3 hudoutlinedisableforclient( self );
            }
        }
        
        self.var_fdc85853d76d59cd = undefined;
    }
}

// Namespace namespace_6334eb96c2d6266a
// Params 1
// Checksum 0x58ab42f9, Offset: 0x3082
// Size: 0x290
function function_f06d8944c437e298( mech )
{
    self endon( #"death_or_disconnect" );
    wait 0.5;
    self notifyonplayercommand( "exit", "+stance" );
    self notifyonplayercommand( "exit", "+movedown" );
    self notifyonplayercommand( "exit", "+prone" );
    self notifyonplayercommand( "exit", "+activate" );
    self notifyonplayercommand( "exit", "+usereload" );
    self notifyonplayercommand( "mech_fire_weapon", "+attack" );
    self notifyonplayercommand( "mech_fire_weapon", "+attack_akimbo_accessible" );
    
    while ( true )
    {
        msg = utility::waittill_any_return( "exit", "mech_fire_weapon" );
        
        if ( msg == "mech_fire_weapon" )
        {
            start = mech.torso gettagorigin( "tag_camera" );
            end = start + anglestoforward( self getplayerangles() ) * 3000;
            end = trace::ray_trace( start, end, [ mech, mech.torso, mech.torso.clip ], undefined, 0, 1, 1 );
            rocket = magicbullet( makeweapon( "sat_mech_turret_rocket_fast" ), mech.torso gettagorigin( "tag_gunner2_flash" ) + anglestoforward( mech.torso gettagangles( "tag_gunner2_flash" ) ) * 25, mech.torso gettagorigin( "tag_gunner2_flash" ) + anglestoforward( mech.torso gettagangles( "tag_gunner2_flash" ) ) * 100, self );
            rocket thread function_137212514f61a76f( end[ "position" ], 0.05 );
            rocket thread function_f9cab8594747de34();
            rocket thread libra_audio::function_b75198a735b395e5();
            playrumbleonposition( "damage_med", start );
            self playrumbleonpositionforclient( "defaultweapon_fire", self.origin );
            mp_sat_ob_libra_util::function_18fee449c48ecd39( start );
            level utility::delaythread( 0.5, &mp_sat_ob_libra_vo::bring_the_heat );
            wait 0.5;
            continue;
        }
        
        break;
    }
    
    if ( isdefined( self ) )
    {
        self notifyonplayercommandremove( "exit", "+stance" );
        self notifyonplayercommandremove( "exit", "+movedown" );
        self notifyonplayercommandremove( "exit", "+prone" );
        self notifyonplayercommandremove( "exit", "+activate" );
        self notifyonplayercommandremove( "exit", "+usereload" );
        self notifyonplayercommandremove( "mech_fire_weapon", "+attack" );
        self notifyonplayercommandremove( "mech_fire_weapon", "+attack_akimbo_accessible" );
    }
}

// Namespace namespace_6334eb96c2d6266a
// Params 2
// Checksum 0x6925cf6a, Offset: 0x331a
// Size: 0x2c
function function_137212514f61a76f( pos, delay )
{
    self endon( #"death" );
    wait delay;
    self missile_settargetpos( pos );
}

// Namespace namespace_6334eb96c2d6266a
// Params 0
// Checksum 0xf2df0767, Offset: 0x334e
// Size: 0x333
function function_f9cab8594747de34()
{
    if ( isdefined( level.destruction_targets ) )
    {
        self waittill( #"death" );
        missileorigin = self.origin;
        
        if ( !isdefined( missileorigin ) )
        {
            return;
        }
        
        foreach ( struct in level.destruction_targets )
        {
            if ( distancesquared( missileorigin, struct.origin ) < 9216 )
            {
                if ( isdefined( struct.script_flag_set ) )
                {
                    level utility::flag_set( struct.script_flag_set );
                }
                
                if ( isdefined( struct.script_fxid ) )
                {
                    utility::exploder( struct.script_fxid );
                }
                
                if ( isdefined( struct.script_linkto ) )
                {
                    struct.linked_ents = struct utility::get_linked_ents();
                    
                    if ( isdefined( struct.linked_ents ) )
                    {
                        foreach ( ent in struct.linked_ents )
                        {
                            if ( ent.targetname == "door_trigger" )
                            {
                                ent scriptable_door_utility::simple_unlock_door();
                                level thread libra_audio::metal_door_hit( missileorigin );
                                
                                if ( isdefined( ent.target ) )
                                {
                                    target_doors = getentitylessscriptablearray( ent.target, "targetname", undefined, undefined, "door" );
                                    
                                    if ( isdefined( target_doors ) )
                                    {
                                        foreach ( door in target_doors )
                                        {
                                            door setscriptablepartstate( "door", "hidden" );
                                        }
                                    }
                                }
                                
                                if ( ent.script_noteworthy == "armory_to_processing_door_trigger" )
                                {
                                    level thread mp_sat_ob_libra_vo::function_7ff852a04609d104();
                                }
                                else if ( ent.script_noteworthy == "armory_secret_door_trigger" || ent.script_noteworthy == "armory_entrance_door" )
                                {
                                    if ( isdefined( level.armory_secret_door_interact ) )
                                    {
                                        if ( isdefined( level.armory_secret_door_interact.obj_root ) )
                                        {
                                            level.armory_secret_door_interact.obj_root ob_story_mission_utils::objective_marker_clear( level.armory_secret_door_interact.var_8029d4363972e15 );
                                        }
                                        
                                        level.armory_secret_door_interact delete();
                                    }
                                    
                                    level thread mp_sat_ob_libra_vo::wrong_door();
                                }
                                
                                ent delete();
                            }
                        }
                    }
                }
            }
        }
    }
}

// Namespace namespace_6334eb96c2d6266a
// Params 0
// Checksum 0xa7a4d576, Offset: 0x3689
// Size: 0x206
function function_36bdbd68c11a0cfb()
{
    utility::flag_wait( "flag_armory_to_processing_door_destroyed" );
    waitframe();
    level.var_1827b1d7ab4e0a63 = [];
    level.enc_armory = activity_ai_encounters::function_92b671064b0b1ce2( "encounter_libra_armory", 1, 1, 1, 1 );
    function_ef57f478f96b050c( level.enc_armory, 1 );
    activity_ai_encounters::function_6bf4ff2fbde584ee( level.enc_armory, &function_342b1530062e8fc6 );
    ai_spawn_director::add_spawned_callback( level.enc_armory, &armory_spawn_func );
    ai_spawn_director::function_a49c35b72d6b6fea( level.enc_armory, &function_f3b354fcf368cbe5 );
    utility::flag_wait( "flag_armory_enemies_spawned" );
    utility::flag_wait( "lab_flag1" );
    level.var_43dab29e2279f72b = ai_spawn_director::array_spawn_targetname( "pre_proc_grunts" );
    
    if ( isdefined( level.var_43dab29e2279f72b ) )
    {
        foreach ( agent in level.var_43dab29e2279f72b )
        {
            if ( isalive( agent ) )
            {
                agent.ignoreall = 1;
            }
        }
    }
    
    utility::flag_wait( "flag_lab_door_01_opened" );
    level thread libra_audio::function_3560b6b6768232bb();
    
    if ( isdefined( level.var_43dab29e2279f72b ) )
    {
        foreach ( agent in level.var_43dab29e2279f72b )
        {
            if ( isalive( agent ) )
            {
                if ( agent.script_noteworthy == "node_lab_guy" )
                {
                    agent thread function_345437b0e3e76192( randomintrange( 220, 255 ) );
                }
                
                agent.ignoreall = 0;
            }
        }
    }
}

// Namespace namespace_6334eb96c2d6266a
// Params 1
// Checksum 0x34122361, Offset: 0x3897
// Size: 0x33
function function_345437b0e3e76192( speed )
{
    self endon( #"death" );
    self aisetdesiredspeed( speed );
    self waittill( #"goal" );
    self aiclearscriptdesiredspeed();
}

// Namespace namespace_6334eb96c2d6266a
// Params 4
// Checksum 0x3f3c14f6, Offset: 0x38d2
// Size: 0x8c
function armory_spawn_func( requestid, instance, agent, ai_data )
{
    level.var_1827b1d7ab4e0a63[ level.var_1827b1d7ab4e0a63.size ] = agent;
    guildbot_start_goal = utility::getstruct( "guildbot_start_goal" );
    agent thread ai_utility::go_to_node( guildbot_start_goal );
    gv_large = getnoentvolumearray( "armory_large_gv", #targetname )[ 0 ];
    agent thread function_aecd4b35fc2b4e63( gv_large, "flag_armory_to_processing_door_passed" );
}

// Namespace namespace_6334eb96c2d6266a
// Params 2
// Checksum 0x1d97666c, Offset: 0x3966
// Size: 0x39
function function_aecd4b35fc2b4e63( var_c98d6c6f587ca667, flag )
{
    self endon( #"death" );
    level utility::flag_wait( flag );
    
    if ( var_c98d6c6f587ca667 )
    {
        thread ai_utility::go_to_node( var_c98d6c6f587ca667 );
    }
}

// Namespace namespace_6334eb96c2d6266a
// Params 3
// Checksum 0x899d1fe0, Offset: 0x39a7
// Size: 0x6d
function function_f3b354fcf368cbe5( requestid, userdata, shutdowndata )
{
    level utility::flag_set( "flag_armory_bots_dead" );
    
    if ( isdefined( level.enc_armory ) )
    {
        iprintln( "armory encounter complete!" );
        ai_spawn_director::cancel_spawn_request( level.enc_armory );
    }
    
    if ( !utility::flag( "flag_armory_enemies_spawned" ) )
    {
        level notify( #"hash_3b6db33337b8cf23" );
    }
}

// Namespace namespace_6334eb96c2d6266a
// Params 3
// Checksum 0xbd31078, Offset: 0x3a1c
// Size: 0x2b
function function_342b1530062e8fc6( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_armory_enemies_spawned" );
}

// Namespace namespace_6334eb96c2d6266a
// Params 0
// Checksum 0x5c519a11, Offset: 0x3a4f
// Size: 0x99
function setup_guild_bots()
{
    if ( !isdefined( level.var_c0ee7b6e1e1f71c6 ) )
    {
        level.var_c0ee7b6e1e1f71c6 = [];
    }
    
    level.var_c0ee7b6e1e1f71c6[ "armory_bots" ] = [];
    mp_sat_ob_libra_util::function_c8c6f25fb6f7f1d4( "armory_guild_bot_ground_spawner_group_01", "flag_armory_to_processing_door_destroyed", 1, "flag_all_scene_guild_bots_dead", "armory_bots" );
    
    if ( level.players.size > 1 )
    {
        mp_sat_ob_libra_util::function_c8c6f25fb6f7f1d4( "armory_guild_bot_wall_spawner_group_01", "flag_armory_to_processing_door_destroyed", 2, "flag_all_scene_guild_bots_dead", "armory_bots" );
        mp_sat_ob_libra_util::function_c8c6f25fb6f7f1d4( "armory_guild_bot_wall_spawner_group_02", "flag_armory_to_processing_door_destroyed", 3, "flag_all_scene_guild_bots_dead", "armory_bots" );
    }
}

// Namespace namespace_6334eb96c2d6266a
// Params 0, eflags: 0x4
// Checksum 0x2fa72dcc, Offset: 0x3af0
// Size: 0xeb
function private connection_puzzle_init()
{
    asset = hashcat( %"scriptedwidget:", "scripted_widget_connection_puzzle_3side_4player_sat_default" );
    consoles = getscriptablearray( "mech_activate_console", "targetname" );
    
    foreach ( var_190f59357d8260f7 in consoles )
    {
        var_190f59357d8260f7 setscriptablepartstate( #"base", #"circuit_interrupted" );
    }
    
    connection_puzzle::init_from_layout( asset, "libra_armory", "armory_puzzle", 1, "scripted_widget_connection_puzzle_3side_4player_sat_default_spectator" );
    level.connection_puzzle_asset = asset;
    thread function_2e122204a2a9f941();
    thread libra_audio::audio_puzzle_complete();
}

// Namespace namespace_6334eb96c2d6266a
// Params 0, eflags: 0x4
// Checksum 0xcfa19922, Offset: 0x3be3
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

// Namespace namespace_6334eb96c2d6266a
// Params 0
// Checksum 0xa030dc18, Offset: 0x3c97
// Size: 0x2f
function function_bb859a32890e1ebe()
{
    ambush_exit_swim_door = getent( "ambush_exit_swim_door", #script_noteworthy );
    
    if ( isdefined( ambush_exit_swim_door ) )
    {
        ambush_exit_swim_door thread scriptable_door_utility::simple_lock_door();
    }
}

// Namespace namespace_6334eb96c2d6266a
// Params 0
// Checksum 0xc2bf00da, Offset: 0x3cce
// Size: 0x27
function armory_alarms()
{
    level utility::flag_wait( "flag_armory_to_processing_door_destroyed" );
    wait 2;
    level thread mp_sat_ob_libra_util::handle_alarms( "armory_alarms", "start_processing" );
}

