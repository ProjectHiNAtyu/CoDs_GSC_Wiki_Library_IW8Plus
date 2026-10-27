// script_4336017046677b18  (hash_4336017046677b18.gscc) (size: 6749 Bytes / 0x1a5d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2268592c (577263916)
// size ...... 6749 (0x1a5d)
// includes .. 13  (offset: 0x1765)
// strings ... 45  (offset: 0x17cd)
// dev strs .. 0   (offset: 0x1a5d)
// exports ... 14  (offset: 0xe29)
// cseg ...... 0x4b1 + 0x978 (0xe29)
// imports ... 60  (offset: 0x1059)
// animtree1 . 0   (offset: 0x1a5d)
// animtree2 . 0   (offset: 0x1a5d)
#using script_636bd827a012af12;
#using script_66878054d141dbc0;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_audio;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_lighting;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_util;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_vo;

#namespace namespace_4a5ad803128108aa;

/#

    // Namespace namespace_4a5ad803128108aa
    // Params 0
    // Checksum 0xd6b807f4, Offset: 0x4cf
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_4a5ad803128108aa
// Params 0, eflags: 0x5
// Checksum 0x37c4b8f6, Offset: 0x4dc
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_b7efb9b33d93f239", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_4a5ad803128108aa
// Params 0, eflags: 0x4
// Checksum 0xb01a21f5, Offset: 0x505
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LIBRA_BACKTRACK";
    activity_common::registeractivitytype( "OB_LIBRA_BACKTRACK", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_BACKTRACK", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_BACKTRACK", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_BACKTRACK", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_4a5ad803128108aa
// Params 0
// Checksum 0xc184fe20, Offset: 0x566
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

// Namespace namespace_4a5ad803128108aa
// Params 0
// Checksum 0xba05feab, Offset: 0x5cb
// Size: 0x46
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    activity_instance setup_ui_widget();
    activity_instance thread backtrack_main();
}

// Namespace namespace_4a5ad803128108aa
// Params 0
// Checksum 0x4b8f9c0b, Offset: 0x619
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_4a5ad803128108aa
// Params 0
// Checksum 0x66bb9e84, Offset: 0x63d
// Size: 0xe
function setup_ui_widget()
{
    ob_story_mission_utils::objective_text_show( "OB_LIBRA_BACKTRACK" );
}

/#

    // Namespace namespace_4a5ad803128108aa
    // Params 0
    // Checksum 0x9102a3e4, Offset: 0x653
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_4a5ad803128108aa
// Params 0
// Checksum 0xeb293cf3, Offset: 0x660
// Size: 0x1b2
function start()
{
    activity_instance = self;
    activity_instance setup_ui_widget();
    level utility::flag_set( "pump_b_done" );
    level thread mp_sat_ob_libra_lighting::function_f3daa22b92d8fb8d();
    activateworldevent( "LGT_PROC_DESIGN" );
    utility::exploder( "libra_processing_meltdown_01_vfx" );
    utility::exploder( "libra_processing_meltdown_02_vfx" );
    utility::exploder( "libra_processing_meltdown_03_vfx" );
    utility::exploder( "libra_processing_meltdown_04_vfx" );
    mp_sat_ob_libra_util::function_8f97ea6ececa5d();
    level thread function_e8b8f14b227b3c43();
    level thread mp_sat_ob_libra_util::function_2bc2cecd260a5613( [ "hoist_interact_scene_a", "hoist_interact_scene_b" ] );
    cradle_sphere = getent( "cradle_sphere", "targetname" );
    cradle_sphere thread scene::play( [ cradle_sphere ], "phase_05_init", "scene_sat_cin_libra_cradle_meltdown" );
    cradle_sphere thread mp_sat_ob_libra_lighting::function_70a171f22b600bac();
    tags = [];
    tags[ tags.size ] = "tag_fx2";
    tags[ tags.size ] = "tag_fx3";
    tags[ tags.size ] = "tag_fx6";
    tags[ tags.size ] = "tag_fx8";
    
    foreach ( tag in tags )
    {
        playfxontag( utility::getfx( "vfx_sat_levels_mp_ob_libra_cradle_sphere_valve_release_1" ), cradle_sphere, tag );
    }
    
    level thread function_6ec0da3cd4de3150();
    level thread mp_sat_ob_libra_util::function_32b80bf22f39a811( "processing_fan", "roll", 2, "flag_boss_intro_regroup_countdown_finished", %"electronics_fan_box_lg_01_blade" );
    level thread mp_sat_ob_libra_util::function_9886d86be8c62744();
}

// Namespace namespace_4a5ad803128108aa
// Params 0
// Checksum 0xc097a08b, Offset: 0x81a
// Size: 0x8f
function function_6ec0da3cd4de3150()
{
    level utility::flag_wait( "story_mission_party_check_complete" );
    
    foreach ( player in level.players )
    {
        pbgpostfxbundlestart( player, %"mp_sat_ob_libra_fxgrade_processing_overload" );
    }
}

// Namespace namespace_4a5ad803128108aa
// Params 0, eflags: 0x4
// Checksum 0xa2ec4108, Offset: 0x8b1
// Size: 0x1b
function private function_e8b8f14b227b3c43()
{
    level utility::flag_wait( "scriptables_ready" );
    thread mp_sat_ob_libra_util::function_3404036aa1432445( "processing_main_door" );
}

// Namespace namespace_4a5ad803128108aa
// Params 0
// Checksum 0x7f4160ec, Offset: 0x8d4
// Size: 0x2be
function backtrack_main()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    level thread mp_sat_ob_libra_util::cooling_pool_hurt_trigger();
    level utility::flag_clear( "flag_backtrack_dont_stop" );
    level utility::flag_clear( "flag_backtrack_keep_moving" );
    level utility::flag_clear( "flag_backtrack_final_stretch" );
    level utility::flag_clear( "flag_backtrack_done" );
    level utility::flag_set( "flag_backtrack_start" );
    level utility::flag_set( "flag_armory_bots_dead" );
    level thread mp_sat_ob_libra_util::function_3404036aa1432445( "lab_door_01" );
    level thread mp_sat_ob_libra_util::function_3404036aa1432445( "armory_to_processing_door_trigger" );
    level utility::flag_wait( "story_mission_party_check_complete" );
    utility::exploder( "libra_processing_meltdown_05_vfx" );
    level thread libra_audio::function_61181979347a98f2();
    function_f3a6772c8b060a41( 400 );
    level thread mp_sat_ob_libra_util::function_666afe336bbc23e3( "backtrack_ambient_moment_trigger" );
    level thread mp_sat_ob_libra_util::function_7beb2eae4a2ffc52( "backtrack_looping_ambient_structs" );
    level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", -1, undefined, level.players );
    level thread mp_sat_ob_libra_util::function_d2bb8bdd5246e2ca( "flag_backtrack_done" );
    wait 1;
    cradle_sphere = getent( "cradle_sphere", "targetname" );
    cradle_sphere thread scene::play( [ cradle_sphere ], "phase_05", "scene_sat_cin_libra_cradle_meltdown" );
    mp_sat_ob_libra_vo::backtrack_taunt();
    thread mp_sat_ob_libra_vo::function_797b343d16462f92();
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "backtrack_waypoint_org", undefined, "backtrack_waypoint_org_waypoint_done", undefined, undefined, 1 );
    level thread mp_sat_ob_libra_util::function_776ea74dd9e92d46( "flag_backtrack_done", "backtrack_waypoint_org" );
    level thread mp_sat_ob_libra_util::function_3404036aa1432445( "processing_alt_door", 0, 1 );
    scriptables = getentitylessscriptablearray( "amb_destr_trigger_01", #targetname );
    
    if ( isdefined( scriptables ) )
    {
        foreach ( scriptable in scriptables )
        {
            if ( scriptable getscriptableparthasstate( "main", "destr" ) )
            {
                scriptable setscriptablepartstate( "main", "destr" );
            }
        }
    }
    
    level thread backtrack_cleanup();
    level utility::flag_wait( "flag_backtrack_done" );
    
    foreach ( player in level.players )
    {
        pbgpostfxbundlekill( player, %"mp_sat_ob_libra_fxgrade_processing_overload" );
    }
    
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_4a5ad803128108aa
// Params 0
// Checksum 0xaa51ae74, Offset: 0xb9a
// Size: 0x28f
function backtrack_cleanup()
{
    level utility::flag_wait( "flag_boss_intro_regroup_countdown_finished" );
    deactivateworldevent( "LGT_PROC_DESIGN" );
    utility::stop_exploder( "libra_processing_meltdown_01_vfx" );
    utility::stop_exploder( "libra_processing_meltdown_02_vfx" );
    utility::stop_exploder( "libra_processing_meltdown_03_vfx" );
    utility::stop_exploder( "libra_processing_meltdown_04_vfx" );
    utility::stop_exploder( "libra_processing_meltdown_05_vfx" );
    cradle_sphere = getent( "cradle_sphere", "targetname" );
    tags = [];
    tags[ tags.size ] = "tag_fx2";
    tags[ tags.size ] = "tag_fx3";
    tags[ tags.size ] = "tag_fx6";
    tags[ tags.size ] = "tag_fx8";
    
    if ( isdefined( cradle_sphere ) )
    {
        foreach ( tag in tags )
        {
            stopfxontag( utility::getfx( "vfx_sat_levels_mp_ob_libra_cradle_sphere_valve_release_1" ), cradle_sphere, tag );
        }
        
        cradle_sphere thread utility::delete_after_delay( 0.1 );
    }
    
    foreach ( player in level.players )
    {
        namespace_a350a26c6d662a6a::function_10887bb6792fea1c( player, %"sat_mp_sat_lm_avalon_ob_cradle_md_03", undefined, "cradle_influence_vfx_heavy" );
    }
    
    level notify( #"hash_866273063a45342c" );
    enemies = getaiarray();
    
    if ( enemies.size > 0 )
    {
        foreach ( enemy in enemies )
        {
            if ( isalive( enemy ) )
            {
                enemy.death_source = "despawn";
                enemy.nocorpse = 1;
                enemy.var_a13bed1ac47e1b2c = 1;
                enemy.dropweapon = 0;
                enemy thread agent_utils::despawnagent();
            }
        }
    }
}

