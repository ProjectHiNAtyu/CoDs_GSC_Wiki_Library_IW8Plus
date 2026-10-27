// script_742eea394f3ef111  (hash_742eea394f3ef111.gscc) (size: 5421 Bytes / 0x152d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xda9e7412 (3667817490)
// size ...... 5421 (0x152d)
// includes .. 14  (offset: 0x132d)
// strings ... 29  (offset: 0x139d)
// dev strs .. 0   (offset: 0x152d)
// exports ... 14  (offset: 0xa05)
// cseg ...... 0x2c2 + 0x743 (0xa05)
// imports ... 62  (offset: 0xc35)
// animtree1 . 0   (offset: 0x152d)
// animtree2 . 0   (offset: 0x152d)
#using script_55b30772fa27258;
#using script_636bd827a012af12;
#using script_6b10011ac07f7291;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_audio;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_util;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_vo;

#namespace namespace_6764bf62edd0d121;

/#

    // Namespace namespace_6764bf62edd0d121
    // Params 0
    // Checksum 0x29e9de7f, Offset: 0x2e0
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_6764bf62edd0d121
// Params 0, eflags: 0x5
// Checksum 0x9c7e5e6f, Offset: 0x2ed
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_dbe1138713009340", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_6764bf62edd0d121
// Params 0, eflags: 0x4
// Checksum 0xeb2c3081, Offset: 0x316
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LIBRA_BOSS_1";
    activity_common::registeractivitytype( "OB_LIBRA_BOSS_1", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_BOSS_1", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_BOSS_1", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_BOSS_1", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_6764bf62edd0d121
// Params 0
// Checksum 0x44ad79c0, Offset: 0x377
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

// Namespace namespace_6764bf62edd0d121
// Params 0
// Checksum 0xb7c6a454, Offset: 0x3dc
// Size: 0x45
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    function_78297b0cd5211dea();
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_6764bf62edd0d121
// Params 0
// Checksum 0xb4de4580, Offset: 0x429
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_6764bf62edd0d121
// Params 0
// Checksum 0x57a4041c, Offset: 0x44d
// Size: 0x2a
function setup_ui_widget()
{
    ob_story_mission_utils::objective_text_show( "OB_LIBRA_BOSS_1" );
    level.var_6fe05155beb36355 = 0;
    ob_story_mission_utils::function_315d79883d962ba7( level.var_6fe05155beb36355, 3 );
}

/#

    // Namespace namespace_6764bf62edd0d121
    // Params 0
    // Checksum 0x6e537a6f, Offset: 0x47f
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_6764bf62edd0d121
// Params 0
// Checksum 0xdcc758d9, Offset: 0x48c
// Size: 0x9
function start()
{
    thread namespace_4759598db99787a0::debug_killstreak_cheats();
}

// Namespace namespace_6764bf62edd0d121
// Params 0
// Checksum 0x818e9abb, Offset: 0x49d
// Size: 0x43c
function function_78297b0cd5211dea()
{
    level thread mp_sat_ob_libra_util::function_cf3e18e44adf3387( 1 );
    thread namespace_4759598db99787a0::arena_teleport_trigger();
    thread namespace_4759598db99787a0::init_boss_ffs();
    thread namespace_4759598db99787a0::init_cradle_crates();
    activity_instance = self;
    activity_instance setup_ui_widget();
    thread namespace_4759598db99787a0::preplaced_care_packages();
    activateworldevent( "VFX_Libra_Boss_Arena_Ambient" );
    thread namespace_4759598db99787a0::init_destructible_cover();
    level thread libra_audio::function_8a1846a4c3c224f8();
    level utility::flag_wait( "story_mission_party_check_complete" );
    wait 3;
    namespace_4759598db99787a0::function_45df75d7cdcb6f3d();
    center_org = getent( "boss_rotator_1", #targetname );
    level.center_rotator = center_org;
    floater_rotator = utility::spawn_tag_origin( center_org.origin, center_org.angles );
    level thread mp_sat_ob_libra_util::function_4f33c858a708f9d4( "boss_vista_spinning_sphere", 1, 4, 5, 10, "script_noteworthy", "stage3_done", 1, 1 );
    level.floaters = getentarray( "boss_floaties_outer", "targetname" );
    
    foreach ( floater in level.floaters )
    {
        floater linkto( floater_rotator );
    }
    
    floater_rotator thread namespace_4759598db99787a0::function_e5fb51e234237279( ( 0, -90, 0 ), ( 0, 0, 32 ), 60, "stage1_done" );
    drop_spot = utility::getstruct( "mech_drop_spot", "targetname" );
    mech_positions = utility::getstructarray( "mech_pos_1", "targetname" );
    mechs = [];
    thread function_7737e2bb31afd58();
    
    foreach ( pos in mech_positions )
    {
        base = undefined;
        new_mech = sat_libra_mech_turret::spawn_mech( drop_spot.origin, drop_spot.angles, undefined, "rocket", 0 );
        new_mech.goalradius = 128;
        new_mech.radius = 128;
        new_mech aisetdesiredspeed( 100 );
        new_mech.disabledstate = 1;
        new_mech sat_libra_mech_turret::disable_right_arm();
        mechs[ mechs.size ] = new_mech;
        finisher_igc = utility::getstruct( "igc_boss_phase1_end", "targetname" );
        new_mech thread namespace_4759598db99787a0::function_f70ed84fe274b1b6( pos.origin, base, self, "stage1_done", 0, finisher_igc, 1, "sat_libra_debris_overlook_01" );
        new_mech waittill( #"landed" );
        new_mech.var_8029d4363972e15 = namespace_4759598db99787a0::mech_obj_marker( new_mech, 256 );
        break;
    }
    
    level.var_9cd8c10faa1a46f7 = 0;
    mechs[ 0 ] thread namespace_4759598db99787a0::mech_death_func( self, "kill_mech1a" );
    mechs[ 0 ].other_mech = mechs[ 1 ];
    level.mechs = mechs;
    thread function_292134d32390169d();
    level waittill( #"hash_42bf2389a88d055f" );
    wait 1;
    thread namespace_4759598db99787a0::drop_supply_crate();
    wait 10;
    
    /#
        var_6d7ec15e22b6b01c = getdvarint( @"hash_996b1afb6b81eeb1", 0 );
    #/
    
    if ( !var_6d7ec15e22b6b01c )
    {
        requestid = activity_ai_encounters::function_92b671064b0b1ce2( "ai_encounter_libra_boss_grunts1", 1, 1, 1, 1 );
        ai_spawn_director::add_spawned_callback( requestid, &function_362ba0c29a0174a0 );
        function_ef57f478f96b050c( requestid, 1 );
        activity_ai_encounters::function_d33de057e760c97b( requestid, &namespace_4759598db99787a0::function_d2c2b06ddeb71db5, "stage1_done" );
        requestid = activity_ai_encounters::function_92b671064b0b1ce2( "ai_encounter_libra_boss_grunts1_large_squad", 1, 1, 1, 1 );
        ai_spawn_director::add_spawned_callback( requestid, &function_362ba0c29a0174a0 );
        function_ef57f478f96b050c( requestid, 1 );
        activity_ai_encounters::function_d33de057e760c97b( requestid, &namespace_4759598db99787a0::function_d2c2b06ddeb71db5, "stage1_done" );
    }
    
    utility::flag_wait( "stage1_done" );
}

// Namespace namespace_6764bf62edd0d121
// Params 0
// Checksum 0xa1d9ab4d, Offset: 0x8e1
// Size: 0x99
function function_7737e2bb31afd58()
{
    wait 2;
    level waittill( #"new_mech_started" );
    thread mp_sat_ob_libra_vo::boss1_intro();
    thread mp_sat_ob_libra_vo::function_7238a3a74c67a4c0( 25, "boss1_taunt1", "mech_in_middle" );
    level waittill( #"mech_in_middle" );
    thread mp_sat_ob_libra_vo::function_7238a3a74c67a4c0( 5, "boss1_taunt2", "finish_mech" );
    level waittill( #"finish_mech" );
    wait 3;
    mp_sat_ob_libra_vo::boss1_disabled();
    mp_sat_ob_libra_vo::finish_mech_vo( "stage1_done_use", "finish_mech1", [ "finish_mech1_nag1", "finish_mech1_nag2", "finish_mech_nag1", "finish_mech_nag2" ] );
}

// Namespace namespace_6764bf62edd0d121
// Params 4
// Checksum 0xd1351da2, Offset: 0x982
// Size: 0x30
function function_362ba0c29a0174a0( requestid, userdata, agent, data )
{
    agent thread namespace_4759598db99787a0::function_12cfdd9aff763010();
}

// Namespace namespace_6764bf62edd0d121
// Params 0
// Checksum 0x75955a2f, Offset: 0x9ba
// Size: 0x4b
function function_292134d32390169d()
{
    utility::flag_wait( "stage1_done_use" );
    utility::flag_set( "pause_minions" );
    enemies = getaiarray();
    enemies = arrayremove( enemies, level.mechs[ 0 ] );
    utility::array_thread( enemies, &agent_utils::despawnagent );
}

