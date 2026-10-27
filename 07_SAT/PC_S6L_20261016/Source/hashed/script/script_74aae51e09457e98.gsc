// script_74aae51e09457e98  (hash_74aae51e09457e98.gscc) (size: 5785 Bytes / 0x1699 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3faf5fbb (1068457915)
// size ...... 5785 (0x1699)
// includes .. 14  (offset: 0x1455)
// strings ... 34  (offset: 0x14c5)
// dev strs .. 0   (offset: 0x1699)
// exports ... 14  (offset: 0xac5)
// cseg ...... 0x2f4 + 0x7d1 (0xac5)
// imports ... 66  (offset: 0xcf5)
// animtree1 . 0   (offset: 0x1699)
// animtree2 . 0   (offset: 0x1699)
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
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_util;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_vo;

#namespace namespace_6764bc62edd0ca88;

/#

    // Namespace namespace_6764bc62edd0ca88
    // Params 0
    // Checksum 0x29e9c5d6, Offset: 0x312
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_6764bc62edd0ca88
// Params 0, eflags: 0x5
// Checksum 0x5771f65, Offset: 0x31f
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_dbe1168713009859", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_6764bc62edd0ca88
// Params 0, eflags: 0x4
// Checksum 0xeb2c2b28, Offset: 0x348
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LIBRA_BOSS_2";
    activity_common::registeractivitytype( "OB_LIBRA_BOSS_2", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_BOSS_2", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_BOSS_2", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_BOSS_2", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_6764bc62edd0ca88
// Params 0
// Checksum 0xdda433d3, Offset: 0x3a9
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

// Namespace namespace_6764bc62edd0ca88
// Params 0
// Checksum 0xa85b9ce9, Offset: 0x40e
// Size: 0x45
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    function_bb048c2f35c0c931();
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_6764bc62edd0ca88
// Params 0
// Checksum 0xb4de5e29, Offset: 0x45b
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_6764bc62edd0ca88
// Params 0
// Checksum 0xcead4e0e, Offset: 0x47f
// Size: 0x2b
function setup_ui_widget()
{
    ob_story_mission_utils::objective_text_show( "OB_LIBRA_BOSS_2" );
    level.var_6fe05155beb36355 = 1;
    ob_story_mission_utils::function_315d79883d962ba7( level.var_6fe05155beb36355, 3 );
}

/#

    // Namespace namespace_6764bc62edd0ca88
    // Params 0
    // Checksum 0x6e5361c6, Offset: 0x4b2
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_6764bc62edd0ca88
// Params 0
// Checksum 0xaa2b1244, Offset: 0x4bf
// Size: 0x6a
function start()
{
    activity_instance = self;
    activity_instance setup_ui_widget();
    thread namespace_4759598db99787a0::debug_killstreak_cheats();
    thread namespace_4759598db99787a0::function_45df75d7cdcb6f3d();
    thread namespace_4759598db99787a0::init_destructible_cover();
    thread namespace_4759598db99787a0::preplaced_care_packages();
    thread namespace_4759598db99787a0::arena_teleport_trigger();
    thread namespace_4759598db99787a0::init_boss_ffs();
    thread namespace_4759598db99787a0::init_cradle_crates();
    level thread mp_sat_ob_libra_util::function_cf3e18e44adf3387( 1 );
    activateworldevent( "VFX_Libra_Boss_Arena_Ambient" );
    level utility::flag_wait( "story_mission_party_check_complete" );
}

// Namespace namespace_6764bc62edd0ca88
// Params 0
// Checksum 0xde5e962b, Offset: 0x531
// Size: 0x42a
function function_bb048c2f35c0c931()
{
    activity_instance = self;
    activity_instance setup_ui_widget();
    utility::flag_clear( "pause_minions" );
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
    
    floater_rotator thread namespace_4759598db99787a0::function_e5fb51e234237279( ( 0, -90, 0 ), ( 0, 0, 32 ), 60, "stage2_done" );
    wait 5;
    utility::flag_set( "show_ffs" );
    
    if ( !getdvarint( @"hash_5d83c5e65867f90e", 0 ) )
    {
        wait 15;
    }
    
    drop_spot = utility::getstruct( "mech_drop_spot", "targetname" );
    mech_positions = utility::getstructarray( "mech_pos_2", "targetname" );
    mechs = [];
    
    foreach ( pos in mech_positions )
    {
        base = undefined;
        new_mech = sat_libra_mech_turret::spawn_mech( drop_spot.origin, drop_spot.angles, undefined, "rocket", 0 );
        new_mech aisetdesiredspeed( 200 );
        new_mech.disabledstate = 1;
        new_mech sat_libra_mech_turret::disable_left_arm();
        mechs[ mechs.size ] = new_mech;
        finisher_igc = utility::getstruct( "igc_boss_phase2_end", "targetname" );
        new_mech thread namespace_4759598db99787a0::function_f70ed84fe274b1b6( pos.origin, base, self, "stage2_done", 1, finisher_igc, undefined, "sat_libra_debris_overlook_02" );
        new_mech waittill( #"landed" );
        level notify( #"new_mech" );
        new_mech.var_8029d4363972e15 = namespace_4759598db99787a0::mech_obj_marker( new_mech, 256 );
        break;
    }
    
    level.var_9cd8c10faa1a46f7 = 0;
    mechs[ 0 ] thread namespace_4759598db99787a0::mech_death_func( self, "kill_mech2a" );
    mechs[ 0 ].other_mech = mechs[ 1 ];
    level.mechs = mechs;
    thread function_292134d32390169d();
    backer_panels = getentarray( "temp_mech_backer_panel", "targetname" );
    
    foreach ( panel in backer_panels )
    {
        panel delete();
    }
    
    thread namespace_4759598db99787a0::function_f0b83a2a1383da24( center_org, "stage2_done" );
    wait 10;
    requestid = activity_ai_encounters::function_92b671064b0b1ce2( "ai_encounter_libra_boss_grunts2", 1, 1, 1, 1 );
    ai_spawn_director::add_spawned_callback( requestid, &function_4d7d62415899431c );
    function_ef57f478f96b050c( requestid, 1 );
    activity_ai_encounters::function_d33de057e760c97b( requestid, &namespace_4759598db99787a0::function_d2c2b06ddeb71db5, "stage2_done" );
    utility::flag_wait( "stage2_done" );
}

// Namespace namespace_6764bc62edd0ca88
// Params 0
// Checksum 0x375282ae, Offset: 0x963
// Size: 0xae
function function_e499be1b34e15f8b()
{
    mp_sat_ob_libra_vo::boss1_gone();
    level waittill( #"new_mech_started" );
    wait 2;
    thread mp_sat_ob_libra_vo::boss2_intro();
    thread mp_sat_ob_libra_vo::function_7238a3a74c67a4c0( 15, "boss2_taunt1", "mech_in_middle" );
    level waittill( #"mech_in_middle" );
    thread mp_sat_ob_libra_vo::function_7238a3a74c67a4c0( 5, "boss2_taunt2", "finish_mech" );
    level waittill( #"finish_mech" );
    wait 3;
    mp_sat_ob_libra_vo::boss2_disabled();
    mp_sat_ob_libra_vo::finish_mech_vo( "stage2_done_use", [ "finish_mech2", "finish_mech2_2" ], [ "finish_mech2_nag1", "finish_mech2_nag2", "finish_mech_nag3", "finish_mech_nag4" ] );
}

// Namespace namespace_6764bc62edd0ca88
// Params 4
// Checksum 0x29268aaa, Offset: 0xa19
// Size: 0x59
function function_4d7d62415899431c( requestid, userdata, agent, data )
{
    if ( agent.unittype == "zombie" )
    {
        agent zombie_utils::function_a8ce00e0448cb6f0( "sprint", "difficulty_region", 1 );
    }
    
    agent thread namespace_4759598db99787a0::function_12cfdd9aff763010();
}

// Namespace namespace_6764bc62edd0ca88
// Params 0
// Checksum 0x9ea2fa85, Offset: 0xa7a
// Size: 0x4b
function function_292134d32390169d()
{
    utility::flag_wait( "stage2_done_use" );
    utility::flag_set( "pause_minions" );
    enemies = getaiarray();
    enemies = arrayremove( enemies, level.mechs[ 0 ] );
    utility::array_thread( enemies, &agent_utils::despawnagent );
}

