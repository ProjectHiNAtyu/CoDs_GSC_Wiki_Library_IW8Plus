// script_9295e138d07350f  (hash_09295e138d07350f.gscc) (size: 6237 Bytes / 0x185d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1ec4dff3 (516218867)
// size ...... 6237 (0x185d)
// includes .. 15  (offset: 0x15dd)
// strings ... 37  (offset: 0x1655)
// dev strs .. 0   (offset: 0x185d)
// exports ... 14  (offset: 0xc0d)
// cseg ...... 0x32d + 0x8e0 (0xc0d)
// imports ... 67  (offset: 0xe3d)
// animtree1 . 0   (offset: 0x185d)
// animtree2 . 0   (offset: 0x185d)
#using script_55b30772fa27258;
#using script_636bd827a012af12;
#using script_6b10011ac07f7291;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_util;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_vo;

#namespace namespace_6764bd62edd0ccbb;

/#

    // Namespace namespace_6764bd62edd0ccbb
    // Params 0
    // Checksum 0x29e9c3e5, Offset: 0x34b
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_6764bd62edd0ccbb
// Params 0, eflags: 0x5
// Checksum 0x7270273f, Offset: 0x358
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_dbe11587130096a6", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_6764bd62edd0ccbb
// Params 0, eflags: 0x4
// Checksum 0xeb2c2d1b, Offset: 0x381
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LIBRA_BOSS_3";
    activity_common::registeractivitytype( "OB_LIBRA_BOSS_3", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_BOSS_3", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_BOSS_3", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_BOSS_3", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_6764bd62edd0ccbb
// Params 0
// Checksum 0xaaa30576, Offset: 0x3e2
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

// Namespace namespace_6764bd62edd0ccbb
// Params 0
// Checksum 0x140079e9, Offset: 0x447
// Size: 0x45
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    function_a1b658b96ac4e950();
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_6764bd62edd0ccbb
// Params 0
// Checksum 0xb4de581a, Offset: 0x494
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_6764bd62edd0ccbb
// Params 0
// Checksum 0xb9aa78a8, Offset: 0x4b8
// Size: 0x2b
function setup_ui_widget()
{
    ob_story_mission_utils::objective_text_show( "OB_LIBRA_BOSS_3" );
    level.var_6fe05155beb36355 = 2;
    ob_story_mission_utils::function_315d79883d962ba7( level.var_6fe05155beb36355, 3 );
}

/#

    // Namespace namespace_6764bd62edd0ccbb
    // Params 0
    // Checksum 0x6e5367f5, Offset: 0x4eb
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_6764bd62edd0ccbb
// Params 0
// Checksum 0x48a8f9dc, Offset: 0x4f8
// Size: 0x6c
function start()
{
    thread namespace_4759598db99787a0::debug_killstreak_cheats();
    thread namespace_4759598db99787a0::function_45df75d7cdcb6f3d();
    thread namespace_4759598db99787a0::init_destructible_cover();
    thread namespace_4759598db99787a0::preplaced_care_packages();
    thread namespace_4759598db99787a0::arena_teleport_trigger();
    thread namespace_4759598db99787a0::init_boss_ffs();
    thread namespace_4759598db99787a0::init_cradle_crates();
    level thread mp_sat_ob_libra_util::function_cf3e18e44adf3387( 1 );
    utility::flag_set( "skip_boss_ff_fx" );
    utility::flag_set( "show_ffs" );
    activateworldevent( "VFX_Libra_Boss_Arena_Ambient" );
    level utility::flag_wait( "story_mission_party_check_complete" );
}

// Namespace namespace_6764bd62edd0ccbb
// Params 0
// Checksum 0x7a7fbf9c, Offset: 0x56c
// Size: 0x4d3
function function_a1b658b96ac4e950()
{
    activity_instance = self;
    activity_instance setup_ui_widget();
    thread function_e499be1b34e15f8b();
    thread namespace_4759598db99787a0::drop_supply_crate();
    center_org = getent( "boss_rotator_1", #targetname );
    level.center_rotator = center_org;
    floater_rotator = utility::spawn_tag_origin( center_org.origin, center_org.angles );
    level thread mp_sat_ob_libra_util::function_4f33c858a708f9d4( "boss_vista_spinning_sphere", 1, 4, 5, 10, "script_noteworthy", "stage3_done", 1, 1 );
    level.floaters = getentarray( "boss_floaties_outer", "targetname" );
    
    foreach ( floater in level.floaters )
    {
        floater linkto( floater_rotator );
    }
    
    floater_rotator thread namespace_4759598db99787a0::function_e5fb51e234237279( ( 0, -90, 0 ), ( 0, 0, 32 ), 60, "stage3_done" );
    wait 5;
    utility::flag_set( "enable_boss_cradle_crates" );
    wait 15;
    utility::flag_clear( "pause_minions" );
    drop_spot = utility::getstruct( "mech_drop_spot", "targetname" );
    mech_positions = utility::getstructarray( "mech_pos_3", "targetname" );
    mechs = [];
    
    foreach ( pos in mech_positions )
    {
        base = undefined;
        new_mech = sat_libra_mech_turret::spawn_mech( drop_spot.origin, drop_spot.angles, "laser", "rocket", 0 );
        new_mech aisetdesiredspeed( 400 );
        new_mech.disabledstate = 1;
        mechs[ mechs.size ] = new_mech;
        new_mech thread namespace_4759598db99787a0::function_f70ed84fe274b1b6( pos.origin, base, self, "stage3_done", 2 );
        new_mech waittill( #"landed" );
        level notify( #"hash_f2d704b39cae17a3" );
        new_mech.var_8029d4363972e15 = namespace_4759598db99787a0::mech_obj_marker( new_mech, 256 );
        break;
    }
    
    level.var_9cd8c10faa1a46f7 = 0;
    mechs[ 0 ] thread namespace_4759598db99787a0::mech_death_func( self, "kill_mech3a" );
    level.mechs = mechs;
    thread function_292134d32390169d();
    backer_panels = getentarray( "temp_mech_backer_panel", "targetname" );
    
    foreach ( panel in backer_panels )
    {
        panel delete();
    }
    
    thread namespace_4759598db99787a0::function_f0b83a2a1383da24( center_org, "stage3_done" );
    wait 10;
    requestid = activity_ai_encounters::function_92b671064b0b1ce2( "ai_encounter_libra_boss_grunts3", 1, 1, 1, 1 );
    ai_spawn_director::add_spawned_callback( requestid, &function_362ba0c29a0174a0 );
    function_ef57f478f96b050c( requestid, 1 );
    activity_ai_encounters::function_d33de057e760c97b( requestid, &namespace_4759598db99787a0::function_d2c2b06ddeb71db5, "stage3_done" );
    requestid = activity_ai_encounters::function_92b671064b0b1ce2( "ai_encounter_libra_boss_grunts3_large_squad", 1, 1, 1, 1 );
    ai_spawn_director::add_spawned_callback( requestid, &function_362ba0c29a0174a0 );
    function_ef57f478f96b050c( requestid, 1 );
    activity_ai_encounters::function_d33de057e760c97b( requestid, &namespace_4759598db99787a0::function_d2c2b06ddeb71db5, "stage3_done" );
    utility::flag_wait( "stage3_done" );
    deactivateworldevent( "VFX_Libra_Boss_Arena_Ambient" );
    level notify( #"boss_remote_watcher" );
    level notify( #"hash_75fca2b07f009805" );
    fade_time = 0.25;
    
    foreach ( player in level.players )
    {
        player thread coop::player_fade_with_shader( 1, fade_time, "black" );
    }
    
    wait fade_time;
}

// Namespace namespace_6764bd62edd0ccbb
// Params 0
// Checksum 0xefad8397, Offset: 0xa47
// Size: 0xb3
function function_e499be1b34e15f8b()
{
    mp_sat_ob_libra_vo::function_f85e8aa5701e1b63();
    level waittill( #"new_mech_started" );
    wait 2;
    thread mp_sat_ob_libra_vo::function_cc4426d0b7af07c9();
    thread mp_sat_ob_libra_vo::function_7238a3a74c67a4c0( 10, "boss3_taunt1", "mech_in_middle" );
    thread mp_sat_ob_libra_vo::function_7238a3a74c67a4c0( 20, "boss_banter3", "finish_mech" );
    level waittill( #"mech_in_middle" );
    thread mp_sat_ob_libra_vo::function_7238a3a74c67a4c0( 5, "boss3_taunt2", "finish_mech" );
    level waittill( #"finish_mech" );
    wait 3;
    mp_sat_ob_libra_vo::function_a7b2055ea7b8d29d();
    mp_sat_ob_libra_vo::finish_mech_vo( "stage3_done_use", "finish_mech3", [ "finish_mech3_nag1", "finish_mech3_nag2", "finish_mech_nag5", "finish_mech_nag6" ] );
}

// Namespace namespace_6764bd62edd0ccbb
// Params 4
// Checksum 0xbc6cbb2, Offset: 0xb02
// Size: 0xb8
function function_362ba0c29a0174a0( requestid, userdata, agent, data )
{
    if ( agent.unittype == "zombie" )
    {
        if ( isalive( level.mechs[ 0 ] ) && level.mechs[ 0 ].health / level.mechs[ 0 ].maxhealth > 0.5 )
        {
            agent zombie_utils::function_a8ce00e0448cb6f0( "sprint", "difficulty_region", 1 );
        }
        else
        {
            agent zombie_utils::function_a8ce00e0448cb6f0( "super_sprint", "difficulty_region", 1 );
        }
    }
    
    agent thread namespace_4759598db99787a0::function_12cfdd9aff763010();
}

// Namespace namespace_6764bd62edd0ccbb
// Params 0
// Checksum 0x71609788, Offset: 0xbc2
// Size: 0x4b
function function_292134d32390169d()
{
    utility::flag_wait( "stage3_done_use" );
    utility::flag_set( "pause_minions" );
    enemies = getaiarray();
    enemies = arrayremove( enemies, level.mechs[ 0 ] );
    utility::array_thread( enemies, &agent_utils::despawnagent );
}

