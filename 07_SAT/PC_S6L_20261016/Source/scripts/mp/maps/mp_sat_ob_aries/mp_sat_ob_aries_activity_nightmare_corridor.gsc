// scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_activity_nightmare_corridor.gsc  (hash_6ef673782c2e5904.gscc) (size: 17802 Bytes / 0x458a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xed13fe1 (248594401)
// size ...... 17802 (0x458a)
// includes .. 14  (offset: 0x3e46)
// strings ... 118 (offset: 0x3eb6)
// dev strs .. 3   (offset: 0x455e)
// exports ... 37  (offset: 0x2ace)
// cseg ...... 0xf4f + 0x1b7f (0x2ace)
// imports ... 104 (offset: 0x3096)
// animtree1 . 0   (offset: 0x458a)
// animtree2 . 0   (offset: 0x458a)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\interaction;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_audio;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_scenes;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_util;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_vo;
#using scripts\mp\ob\systems\ob_container_spawn_closet;

#namespace namespace_a7ec45bcd7d54d98;

// Namespace namespace_a7ec45bcd7d54d98
// Params 0, eflags: 0x5
// Checksum 0x67a88d13, Offset: 0xf6d
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_d178b0594c327bf9", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_a7ec45bcd7d54d98
// Params 0, eflags: 0x4
// Checksum 0xc0b855d4, Offset: 0xf96
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_ARIES_NIGHTMARE_CORRIDOR";
    activity_common::registeractivitytype( "OB_ARIES_NIGHTMARE_CORRIDOR", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_NIGHTMARE_CORRIDOR", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_NIGHTMARE_CORRIDOR", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_NIGHTMARE_CORRIDOR", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_ARIES_NIGHTMARE_CORRIDOR" );
}

// Namespace namespace_a7ec45bcd7d54d98
// Params 0
// Checksum 0xc895cc76, Offset: 0x100d
// Size: 0x59
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance function_52dfb05323a76e39();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_a7ec45bcd7d54d98
// Params 0
// Checksum 0x605f7a96, Offset: 0x106e
// Size: 0x39
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance function_66725f69c25678ba();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_a7ec45bcd7d54d98
// Params 0
// Checksum 0x8edbd939, Offset: 0x10af
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_a7ec45bcd7d54d98
// Params 1
// Checksum 0x3be6e99f, Offset: 0x10d3
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread function_5e7f334fd8530d0( player );
    }
}

// Namespace namespace_a7ec45bcd7d54d98
// Params 0
// Checksum 0xd1e4a415, Offset: 0x118f
// Size: 0x39
function function_52dfb05323a76e39()
{
    activity_instance = self;
    ob_container_spawn_closet::function_e6f9ca6684759ebe( "p2_spawn_closet", "p2_fake_floor", "ob_sat_items_enemy_zombie_aries_spawn_closet" );
    level thread aries_util::function_3d7162d72da84e14();
    utility::flag_set( "flag_aries_nightmare_intro_complete" );
}

// Namespace namespace_a7ec45bcd7d54d98
// Params 0
// Checksum 0x4600b6c, Offset: 0x11d0
// Size: 0x37b
function function_66725f69c25678ba()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level thread aries_vo::function_6cad3ca9d99ddd23();
    level thread aries_util::bloodpool_player_setup();
    activity_instance thread function_32e4043b53b08918();
    activity_instance thread function_3a56ee5a599453e4();
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "str_corridor_weapon", "flag_aries_nightmare_maze_catchup_complete", 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "str_corridor_lethal", "flag_aries_nightmare_maze_catchup_complete", 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "str_corridor_tactical", "flag_aries_nightmare_maze_catchup_complete", 1 );
    activity_instance thread function_2ac0c277510fa520();
    level thread function_9cefa4d33ccd8970();
    level._effect[ "vine_door_1" ] = loadfxasset( "vfx_sat_mp_ob_aries_scr_vines_wall_destruction_02" );
    level._effect[ "vine_door_2" ] = loadfxasset( "vfx_sat_mp_ob_aries_scr_vines_wall_destruction_03" );
    level._effect[ "memory_transition" ] = loadfxasset( "vfx_sat_mp_ob_gem_memory_cradle_dissipate_1" );
    var_a0a876f7a37560c1 = getnoentvolumearray( "trig_corridor_intro", #targetname );
    var_cc6750eaabef14d8 = getnoentvolumearray( "trig_corridor_constrict_1", #targetname );
    var_cc6753eaabef1b71 = getnoentvolumearray( "trig_corridor_constrict_2", #targetname );
    var_b0d6a9d12127df41 = getnoentvolumearray( "trig_maze_intro_progress_75", #targetname );
    var_a0a876f7a37560c1[ 0 ] thread function_2ea9bd1610bb47ec( "flag_aries_nightmare_maze_catchup_complete" );
    var_a0a876f7a37560c1[ 0 ] waittill( #"trigger", player );
    level thread aries_audio::function_ee01595d02ff5e1f();
    utility::flag_set( "flag_nm_maze_boss_intro_init" );
    utility::flag_wait( "flag_aries_nightmare_maze_reveal_complete" );
    level thread namespace_d11629872d017c15::function_e710ff2618150704();
    var_cc6750eaabef14d8[ 0 ] thread function_a2821857c34ba33d( "flag_aries_nightmare_maze_catchup_complete" );
    activity_instance thread function_73894006983041e7( "scn_maze_intro_end_vermin_walk_vertical", 2, 2 );
    var_cc6750eaabef14d8[ 0 ] waittill( #"trigger", player );
    var_cc6753eaabef1b71[ 0 ] waittill( #"trigger", player );
    utility::flag_set( "flag_aries_nightmare_maze_intro_progress_50" );
    activity_instance thread function_ffb71d4b2d613b41( "flag_aries_nightmare_maze_catchup_complete" );
    activity_instance thread aries_util::getplayercount( activity_instance );
    activity_instance thread function_3d8e1a3ff2d54d2a( "flag_aries_nightmare_maze_intro_progress_75" );
    var_b0d6a9d12127df41[ 0 ] waittill( #"trigger", player );
    utility::flag_set( "flag_aries_nightmare_maze_intro_progress_75" );
    activity_instance thread function_c016e3849c75223d();
    utility::flag_wait( "flag_aries_nightmare_corridor_all_enemies_spawned" );
    wait 1;
    activity_instance thread function_33c5d646b9cd4113( 1, "flag_aries_nightmare_maze_intro_combat_complete" );
    utility::flag_wait( "flag_aries_nightmare_maze_intro_combat_complete" );
    level thread aries_util::function_26d151c44e04f67c();
    activity_instance thread ob_story_mission_utils::objective_text_show( "ob_aries_reveal_woods_memory" );
    s_nmr_woods_memory_1_interact_ref = utility::getstruct( "s_nmr_woods_memory_1_interact_ref", "targetname" );
    
    if ( isdefined( s_nmr_woods_memory_1_interact_ref ) )
    {
        obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( s_nmr_woods_memory_1_interact_ref.origin + ( 0, 0, 16 ) );
    }
    
    interact_struct = interaction::register_interact( s_nmr_woods_memory_1_interact_ref.origin, 64, &function_de1e14b42d86e3b1, &"sat_ob_story_missions_aries/reveal_woods_memory_obj", undefined, undefined, undefined, "HINT_BUTTON" );
    utility::flag_wait( "flg_nmr_woods_memory_1_starting" );
    activity_instance thread function_10eea1365dc05ca6();
    activity_instance thread aries_util::waterfall_handler( "vfx_maze_waterfall_a", undefined, "flag_aries_nightmare_maze_catchup_complete" );
    activity_instance thread aries_util::waterfall_handler( "vfx_maze_waterfall_b", undefined, "flag_aries_nightmare_maze_catchup_complete" );
    activity_instance thread aries_util::waterfall_handler( "vfx_maze_waterfall_c", undefined, "flag_aries_nightmare_maze_catchup_complete" );
    activity_instance thread aries_util::waterfall_handler( "vfx_maze_waterfall_d", undefined, "flag_aries_nightmare_maze_catchup_complete" );
    utility::flag_wait( "flag_nm_maze_woods_memory_01_narration_complete" );
    ob_story_mission_utils::objective_marker_clear( obj_id );
    ob_story_mission_utils::objective_text_clear();
}

// Namespace namespace_a7ec45bcd7d54d98
// Params 1
// Checksum 0xdec7fa44, Offset: 0x1553
// Size: 0x43
function function_5e7f334fd8530d0( player )
{
    activity_instance = self;
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        player ob_story_mission_utils::function_2383fc8bfc3074d2();
        player ob_story_mission_utils::function_288fdad79fa2a11();
    }
}

// Namespace namespace_a7ec45bcd7d54d98
// Params 0
// Checksum 0x2bb189e5, Offset: 0x159e
// Size: 0x14
function function_10eea1365dc05ca6()
{
    wait 18.75;
    utility::flag_set( "flg_nightmare_realm_maze_vines" );
}

/#

    // Namespace namespace_a7ec45bcd7d54d98
    // Params 0
    // Checksum 0xf6d025fb, Offset: 0x15ba
    // Size: 0x5, Type: dev
    function function_f342b3fcd37f6bfc()
    {
        
    }

#/

// Namespace namespace_a7ec45bcd7d54d98
// Params 1
// Checksum 0x382339c1, Offset: 0x15c7
// Size: 0x15e
function function_2ea9bd1610bb47ec( cleanup_flag )
{
    var_d2904070af508b8a = utility::getstruct( "sat_cin_ari_nightmare_corridor", "targetname" );
    var_d2904070af508b8a thread scene::play( undefined, "pose" );
    self waittill( #"trigger", player );
    var_d2904070af508b8a thread scene::set_anim_rate( 1.5 );
    var_d2904070af508b8a thread scene::play( undefined, "shot_010" );
    var_d2904070af508b8a thread aries_util::function_46ea5163d8f3c881( "nmr_corridor_containers_rumble_01" );
    var_faf2cd50cd20cbcc = getent( "sbm_nmr_corridor_intro_nograpple", #targetname );
    var_faf2cd50cd20cbcc delete();
    utility::flag_set( "flag_aries_nightmare_maze_reveal_complete" );
    wait 0.9;
    e_blocker_right_a = getent( "sbm_nmr_corridor_intro_clip_right_a", #targetname );
    e_blocker_right_a delete();
    wait 0.3;
    e_blocker_left_a = getent( "sbm_nmr_corridor_intro_clip_left_a", #targetname );
    e_blocker_left_a delete();
    wait 0.8;
    e_blocker_left_b = getent( "sbm_nmr_corridor_intro_clip_left_b", #targetname );
    e_blocker_left_b delete();
    wait 0.1;
    e_blocker_right_b = getent( "sbm_nmr_corridor_intro_clip_right_b", #targetname );
    e_blocker_right_b delete();
    utility::flag_wait( cleanup_flag );
    var_d2904070af508b8a thread scene::cleanup();
}

// Namespace namespace_a7ec45bcd7d54d98
// Params 1
// Checksum 0x517b8ae0, Offset: 0x172d
// Size: 0xb6
function function_a2821857c34ba33d( cleanup_flag )
{
    var_8d34a7629cdeac14 = [ "sm_container_constrict_a1_0", "sm_container_constrict_a1_1", "sm_container_constrict_a1_2", "sm_container_constrict_a1_3", "sm_container_constrict_a1_4", "sm_container_constrict_a1_5", "sm_container_constrict_a1_6" ];
    var_2fddb2ef9c6a0e93 = function_bbef8e1239ac81a( var_8d34a7629cdeac14 );
    self waittill( #"trigger", player );
    thread aries_util::function_2ad4d6454b67c8a8( var_2fddb2ef9c6a0e93 );
    thread aries_util::function_46ea5163d8f3c881( "nmr_corridor_containers_rumble_02" );
    level thread aries_audio::function_6a50d2fd579ff2db();
    utility::flag_wait( cleanup_flag );
    function_daed65b8fa01f78a( var_2fddb2ef9c6a0e93 );
    var_8d34a7629cdeac14 = undefined;
    var_2fddb2ef9c6a0e93 = undefined;
}

// Namespace namespace_a7ec45bcd7d54d98
// Params 2
// Checksum 0xbbff3ba7, Offset: 0x17eb
// Size: 0x43b
function function_ffb71d4b2d613b41( cleanup_flag, is_catchup )
{
    if ( isdefined( is_catchup ) )
    {
        thread function_73894006983041e7( "scn_maze_intro_end_vermin_walk_vertical", 2, 2 );
        wait 2;
    }
    
    var_50df729348a66213 = [];
    var_f873ec447c4ef099 = getent( "spawn_closet_maze_a_1", #targetname );
    var_f873e9447c4eea00 = getent( "spawn_closet_maze_a_2", #targetname );
    var_fc0b33769cd963b3 = utility::getstruct( "static_encounter_maze_a_1", "targetname" );
    var_6c011483a0d789f0 = utility::getstruct( "static_encounter_maze_a_2", "targetname" );
    container_wall_left_l1 = getent( "sm_container_wall_left_l1", #targetname );
    var_50df729348a66213[ var_50df729348a66213.size ] = container_wall_left_l1;
    container_wall_left_l1_target = utility::getstruct( "sbm_container_wall_left_l1_target", "targetname" );
    container_wall_right_l1 = getent( "sm_container_wall_right_l1", #targetname );
    var_50df729348a66213[ var_50df729348a66213.size ] = container_wall_right_l1;
    container_wall_right_l1_target = utility::getstruct( "sbm_container_wall_right_l1_target", "targetname" );
    container_wall_right_l3 = getent( "sm_container_wall_right_l3", #targetname );
    var_50df729348a66213[ var_50df729348a66213.size ] = container_wall_right_l3;
    container_wall_right_l3_target = utility::getstruct( "sbm_container_wall_right_l3_target", "targetname" );
    container_wall_left_l3 = getent( "sm_container_wall_left_l3", #targetname );
    var_50df729348a66213[ var_50df729348a66213.size ] = container_wall_left_l3;
    container_wall_left_l3_target = utility::getstruct( "sbm_container_wall_left_l3_target", "targetname" );
    container_wall_left_l2 = getent( "sm_container_wall_left_l2", #targetname );
    var_50df729348a66213[ var_50df729348a66213.size ] = container_wall_left_l2;
    container_wall_left_l2_target = utility::getstruct( "sbm_container_wall_left_l2_target", "targetname" );
    container_wall_right_l2 = getent( "sm_container_wall_right_l2", #targetname );
    var_50df729348a66213[ var_50df729348a66213.size ] = container_wall_right_l2;
    container_wall_right_l2_target = utility::getstruct( "sbm_container_wall_right_l2_target", "targetname" );
    
    foreach ( ent in var_50df729348a66213 )
    {
        ent markkeyframedmover();
        ent forcenetfieldhighlod( 1 );
        ent setmoveroptimized( 1 );
        ent setmoverantilagged( 1 );
    }
    
    utility::flag_set( "flag_aries_nightmare_maze_close_path_initiated" );
    container_wall_left_l1 moveto( container_wall_left_l1_target.origin, 0.5, 0.1, 0.1 );
    container_wall_right_l1 moveto( container_wall_right_l1_target.origin, 0.5, 0.1, 0.1 );
    var_f873ec447c4ef099 thread ob_container_spawn_closet::function_e2f5560f63a19f46( var_fc0b33769cd963b3, 0.5, 0.5, 0.15, 0.15 );
    container_wall_right_l2 moveto( container_wall_right_l2_target.origin, 0.75, 0.1, 0.1 );
    container_wall_left_l2 moveto( container_wall_left_l2_target.origin, 0.75, 0.1, 0.1 );
    var_f873e9447c4eea00 thread ob_container_spawn_closet::function_e2f5560f63a19f46( var_6c011483a0d789f0, 1, 0.5, 0.15, 0.15 );
    container_wall_left_l3 moveto( container_wall_left_l3_target.origin, 1, 0.1, 0.1 );
    container_wall_right_l3 moveto( container_wall_right_l3_target.origin, 1, 0.1, 0.1 );
    wait 2.5;
    utility::flag_set( "flag_aries_nightmare_maze_intro_spawnclosets_in_position" );
    utility::flag_wait( cleanup_flag );
    
    foreach ( ent in var_50df729348a66213 )
    {
        ent delete();
    }
    
    function_daed65b8fa01f78a( [ var_f873ec447c4ef099, var_f873e9447c4eea00 ] );
    var_50df729348a66213 = undefined;
}

// Namespace namespace_a7ec45bcd7d54d98
// Params 0
// Checksum 0x176f29f8, Offset: 0x1c2e
// Size: 0x222
function function_32e4043b53b08918()
{
    container_left_1 = getent( "sm_maze_reveal_p4", #targetname );
    container_left_2 = getent( "sm_maze_reveal_p5", #targetname );
    container_left_3 = getent( "sm_maze_reveal_p1", #targetname );
    container_down_left_1 = getent( "sm_maze_reveal_p6", #targetname );
    container_down_left_2 = getent( "sm_maze_reveal_p2", #targetname );
    container_down_left_3 = getent( "sm_maze_reveal_p3", #targetname );
    container_down_right_1 = getent( "sm_maze_reveal_p9", #targetname );
    container_down_right_2 = getent( "sm_maze_reveal_p10", #targetname );
    container_down_right_3 = getent( "sm_maze_reveal_p7", #targetname );
    container_right_1 = getent( "sm_maze_reveal_p8", #targetname );
    container_right_2 = getent( "sm_maze_reveal_p12", #targetname );
    var_800bfb91bb8e46e7 = [ container_left_1, container_left_2, container_left_3, container_down_left_1, container_down_left_2, container_down_left_3, container_down_right_1, container_down_right_2, container_down_right_3, container_right_1, container_right_2 ];
    
    foreach ( ent in var_800bfb91bb8e46e7 )
    {
        ent moveto( utility::getstruct( ent.target, "targetname" ).origin, 0.5, 0.1, 0.1 );
    }
}

// Namespace namespace_a7ec45bcd7d54d98
// Params 0
// Checksum 0x4e247f41, Offset: 0x1e58
// Size: 0x45
function function_c016e3849c75223d()
{
    var_b0bc28d1210a9a84 = getnoentvolumearray( "trig_maze_intro_progress_90", #targetname );
    var_b0bc28d1210a9a84[ 0 ] waittill( #"trigger", player );
    utility::flag_set( "flag_aries_nightmare_maze_intro_progress_90" );
}

// Namespace namespace_a7ec45bcd7d54d98
// Params 1
// Checksum 0xd0ae53a1, Offset: 0x1ea5
// Size: 0xa2
function function_bbef8e1239ac81a( var_8d34a7629cdeac14 )
{
    a_ents = [];
    
    foreach ( str_ent_name in var_8d34a7629cdeac14 )
    {
        container_ent = getent( str_ent_name, #targetname );
        a_ents[ a_ents.size ] = container_ent;
    }
    
    return a_ents;
}

// Namespace namespace_a7ec45bcd7d54d98
// Params 1
// Checksum 0xc99afe92, Offset: 0x1f50
// Size: 0x82
function function_daed65b8fa01f78a( a_sequence_ents )
{
    foreach ( ent in a_sequence_ents )
    {
        if ( isdefined( ent ) )
        {
            ent delete();
        }
    }
}

/#

    // Namespace namespace_a7ec45bcd7d54d98
    // Params 0
    // Checksum 0x22cfb4d, Offset: 0x1fda
    // Size: 0x5, Type: dev
    function function_39cd51e70ff41760()
    {
        
    }

#/

// Namespace namespace_a7ec45bcd7d54d98
// Params 0
// Checksum 0x7b19cd1, Offset: 0x1fe7
// Size: 0xad
function function_9cefa4d33ccd8970()
{
    var_f873ec447c4ef099 = getent( "spawn_closet_maze_a_1", #targetname );
    var_f873e9447c4eea00 = getent( "spawn_closet_maze_a_2", #targetname );
    var_42e7f5910059c9b1 = utility::getstruct( "static_encounter_maze_a_1_waiting", "targetname" );
    var_f4357fc85235d5b0 = utility::getstruct( "static_encounter_maze_a_2_waiting", "targetname" );
    waitframe();
    var_f873ec447c4ef099 thread ob_container_spawn_closet::function_e2f5560f63a19f46( var_42e7f5910059c9b1, 0.5, 0.5, 0.15, 0.15 );
    var_f873e9447c4eea00 thread ob_container_spawn_closet::function_e2f5560f63a19f46( var_f4357fc85235d5b0, 0.5, 0.5, 0.15, 0.15 );
}

// Namespace namespace_a7ec45bcd7d54d98
// Params 1
// Checksum 0xeef0e2d3, Offset: 0x209c
// Size: 0x38f
function function_3d8e1a3ff2d54d2a( flag_spawn_enemies )
{
    var_f873ea447c4eec33 = getent( "spawn_closet_maze_a_3", #targetname );
    var_f873ef447c4ef732 = getent( "spawn_closet_maze_a_4", #targetname );
    var_75f350bd8910114d = utility::getstruct( "static_encounter_maze_a_3", "targetname" );
    var_ed8fa314efb9de3a = utility::getstruct( "static_encounter_maze_a_4", "targetname" );
    var_f873ea447c4eec33 thread ob_container_spawn_closet::function_e2f5560f63a19f46( var_75f350bd8910114d, 0.5, 0.5, 0.15, 0.15 );
    var_f873ef447c4ef732 thread ob_container_spawn_closet::function_e2f5560f63a19f46( var_ed8fa314efb9de3a, 0.5, 0.5, 0.15, 0.15 );
    level thread aries_audio::function_8b9d91955461101d();
    waitframe();
    utility::flag_wait_all( flag_spawn_enemies, "flag_aries_nightmare_maze_intro_spawnclosets_in_position" );
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
    
    var_f873ec447c4ef099 = getent( "spawn_closet_maze_a_1", #targetname );
    var_f873e9447c4eea00 = getent( "spawn_closet_maze_a_2", #targetname );
    
    if ( level.playercount > 2 || !level.is_squad_size_small )
    {
        /#
            iprintlnbold( "<dev string:x44>" );
        #/
        
        var_f873ec447c4ef099 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_maze_a1_enc", "ai_encounter:aries_p2_spawn_closet_encounter_corridor", "zombie", 4, 20, undefined, undefined, 0 );
        wait 1;
        var_f873e9447c4eea00 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_maze_a2_enc", "ai_encounter:aries_p2_spawn_closet_encounter_corridor", "zombie", 4, 20, undefined, undefined, 0 );
        thread function_33c5d646b9cd4113( 5, "flag_aries_nightmare_maze_intro_combat_a_count_hit" );
        utility::flag_wait_or_timeout( "flag_aries_nightmare_maze_intro_combat_a_count_hit", 5 );
    }
    else
    {
        /#
            iprintlnbold( "<dev string:x5d>" );
        #/
        
        var_f873ec447c4ef099 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_maze_a1_enc", "ai_encounter:aries_p2_spawn_closet_encounter_corridor", "zombie", 2, 20, undefined, undefined, 0 );
        wait 2;
        var_f873e9447c4eea00 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_maze_a2_enc", "ai_encounter:aries_p2_spawn_closet_encounter_corridor", "zombie", 2, 20, undefined, undefined, 0 );
    }
    
    enc_maze_intro = activity_ai_encounters::function_92b671064b0b1ce2( "vol_enc_cont_maze_intro", 1, 1, 1, 1 );
    activity_ai_encounters::function_52d1342183200a8f( enc_maze_intro, &function_6521c5c746d6ddff );
    activity_ai_encounters::function_189110951b3533d1( enc_maze_intro, &function_62f656f2ea0c44a1, self );
    
    if ( level.playercount > 2 || !level.is_squad_size_small )
    {
        /#
            iprintlnbold( "<dev string:x44>" );
        #/
        
        thread function_33c5d646b9cd4113( 10, "flag_aries_nightmare_maze_intro_combat_b_count_hit" );
        utility::flag_wait_or_timeout( "flag_aries_nightmare_maze_intro_combat_b_count_hit", 8 );
        utility::flag_wait_or_timeout( "flag_shutdown_spawn_closet_maze_a1_enc", 6 );
        var_f873ea447c4eec33 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_maze_a3_enc", "ai_encounter:aries_p2_spawn_closet_encounter_corridor", "zombie", 4, 20, undefined, undefined, 0 );
        utility::flag_wait_or_timeout( "flag_shutdown_spawn_closet_maze_a3_enc", 6 );
        
        while ( !utility::flag( "flag_aries_nightmare_maze_intro_combat_count" ) )
        {
            if ( getaicount() < 6 )
            {
                var_f873ef447c4ef732 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_maze_a4_enc", "ai_encounter:aries_p2_spawn_closet_encounter_corridor", "zombie", 4, 20, undefined, undefined, 0 );
                utility::flag_set( "flag_aries_nightmare_maze_intro_combat_count" );
            }
            
            wait 1;
        }
    }
    else
    {
        /#
            iprintlnbold( "<dev string:x5d>" );
        #/
        
        thread function_33c5d646b9cd4113( 6, "flag_aries_nightmare_maze_intro_combat_b_count_hit" );
        utility::flag_wait_or_timeout( "flag_aries_nightmare_maze_intro_combat_b_count_hit", 12 );
        thread function_33c5d646b9cd4113( 4, "flag_aries_nightmare_maze_intro_combat_c_count_hit" );
        utility::flag_wait_or_timeout( "flag_aries_nightmare_maze_intro_combat_c_count_hit", 8 );
        var_f873ea447c4eec33 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_maze_a3_enc", "ai_encounter:aries_p2_spawn_closet_encounter_corridor", "zombie", 2, 20, undefined, undefined, 0 );
    }
    
    level utility::flag_set( "flag_aries_nightmare_corridor_all_enemies_spawned" );
    utility::flag_wait( "flag_aries_nightmare_tower_complete" );
    function_daed65b8fa01f78a( [ var_f873ec447c4ef099, var_f873e9447c4eea00, var_f873ea447c4eec33, var_f873ef447c4ef732 ] );
}

/#

    // Namespace namespace_a7ec45bcd7d54d98
    // Params 0
    // Checksum 0x46d63c70, Offset: 0x2433
    // Size: 0x5, Type: dev
    function function_44d206b1599267d1()
    {
        
    }

#/

// Namespace namespace_a7ec45bcd7d54d98
// Params 2
// Checksum 0xfd4ff25, Offset: 0x2440
// Size: 0x50
function function_33c5d646b9cd4113( target_count, var_cdb665c03b873a33 )
{
    current_ai_count = getaicount();
    
    while ( current_ai_count >= target_count )
    {
        current_ai_count = getaicount();
        wait 0.5;
        wait 0.5;
    }
    
    if ( isdefined( var_cdb665c03b873a33 ) )
    {
        utility::flag_set( var_cdb665c03b873a33 );
    }
}

// Namespace namespace_a7ec45bcd7d54d98
// Params 0
// Checksum 0x8eec94d6, Offset: 0x2498
// Size: 0xef
function function_3a56ee5a599453e4()
{
    a_kill_trigger = getnoentvolumearray( "trig_maze_intro_kill_fallen_ai", #targetname );
    
    while ( !utility::flag( "flag_aries_nightmare_maze_intro_combat_complete" ) )
    {
        a_ai = getaiarray( "team_hundred_ninety" );
        
        if ( a_ai.size > 0 )
        {
            foreach ( ai in a_ai )
            {
                if ( isalive( ai ) )
                {
                    if ( ai istouching( a_kill_trigger[ 0 ] ) )
                    {
                        ai.nocorpse = 1;
                        ai.var_a13bed1ac47e1b2c = 1;
                        ai kill();
                    }
                }
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_a7ec45bcd7d54d98
// Params 4
// Checksum 0x410303f8, Offset: 0x258f
// Size: 0x51
function function_6521c5c746d6ddff( requestid, activity_instance, agent, data )
{
    utility::flag_set( "flag_aries_nightmare_maze_intro_combat_spawned" );
    agent function_fa32376aaa88a7a2( agent.origin, 5000 );
    agent aries_util::function_fe0a54195e81bbc6();
}

// Namespace namespace_a7ec45bcd7d54d98
// Params 4
// Checksum 0xa04d34f, Offset: 0x25e8
// Size: 0x27
function function_62f656f2ea0c44a1( requestid, activity_instance, agent, data )
{
    
}

/#

    // Namespace namespace_a7ec45bcd7d54d98
    // Params 0
    // Checksum 0x632b165e, Offset: 0x2617
    // Size: 0x5, Type: dev
    function function_7e36ea0ebb77a99()
    {
        
    }

#/

// Namespace namespace_a7ec45bcd7d54d98
// Params 0
// Checksum 0x59a5bd4e, Offset: 0x2624
// Size: 0x208
function function_2d1ebe460cad2ee1()
{
    var_88168f2217f54dd7 = utility::getstructarray( "scn_maze_hallucinate_vermin_walk", "targetname" );
    
    foreach ( scene in var_88168f2217f54dd7 )
    {
        scene thread scene::set_anim_rate( 1.5 );
        scene thread scene::play( undefined, "walk" );
    }
    
    var_9e927062d054c134 = utility::getstructarray( "scn_maze_hallucinate_vermin_walk_vertical", "targetname" );
    
    foreach ( scene in var_9e927062d054c134 )
    {
        scene thread scene::set_anim_rate( 1.5 );
        scene thread scene::play();
    }
    
    wait 1.25;
    
    foreach ( scene in var_88168f2217f54dd7 )
    {
        scene thread scene::cleanup();
    }
    
    foreach ( scene in var_9e927062d054c134 )
    {
        scene thread scene::cleanup();
    }
}

// Namespace namespace_a7ec45bcd7d54d98
// Params 4
// Checksum 0xa33197c3, Offset: 0x2834
// Size: 0xc0
function function_73894006983041e7( scene_zombies, amount, playspeed, var_3e7cf343e0805099 )
{
    a_animnode = utility::getstructarray( scene_zombies, "targetname" );
    
    if ( isdefined( amount ) )
    {
        n_max = minint( amount, a_animnode.size );
        a_animnode = arrayrandomize( a_animnode );
    }
    else
    {
        n_max = a_animnode.size;
    }
    
    i = 0;
    
    while ( i <= n_max )
    {
        a_animnode[ i ] thread scene::set_anim_rate( playspeed );
        
        if ( isdefined( var_3e7cf343e0805099 ) )
        {
            a_animnode[ i ] thread scene::play( var_3e7cf343e0805099 );
        }
        else
        {
            a_animnode[ i ] thread scene::play();
        }
        
        if ( i == n_max )
        {
            break;
        }
        else
        {
            i++;
        }
        
        wait 0.1;
    }
}

/#

    // Namespace namespace_a7ec45bcd7d54d98
    // Params 0
    // Checksum 0xb4ec9ba6, Offset: 0x28fc
    // Size: 0x5, Type: dev
    function function_104445f3c4826a8()
    {
        
    }

#/

// Namespace namespace_a7ec45bcd7d54d98
// Params 1
// Checksum 0xbc8688ce, Offset: 0x2909
// Size: 0x3a
function function_de1e14b42d86e3b1( player )
{
    self makeunusable();
    utility::flag_set( "flg_nmr_woods_memory_1_starting" );
    thread function_1ab1033361e90746( player );
    namespace_d11629872d017c15::function_1479818cb43ea632();
    utility::flag_set( "flg_nmr_woods_memory_1_complete" );
}

// Namespace namespace_a7ec45bcd7d54d98
// Params 1
// Checksum 0xbfc0124c, Offset: 0x294b
// Size: 0x23
function function_1ab1033361e90746( player )
{
    player playrumbleonpositionforclient( "viewmodel_large", player.origin );
}

/#

    // Namespace namespace_a7ec45bcd7d54d98
    // Params 0
    // Checksum 0x330e28de, Offset: 0x2976
    // Size: 0x5, Type: dev
    function function_f138ef08a5d43165()
    {
        
    }

#/

// Namespace namespace_a7ec45bcd7d54d98
// Params 0
// Checksum 0x413681dc, Offset: 0x2983
// Size: 0x6e
function function_2ac0c277510fa520()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"ob_aries_nightmare_arena" );
    level utility::flag_wait( "flag_trg_intro_maze_vo" );
    activity_instance thread ob_story_mission_utils::objective_text_show( "ob_aries_find_woods_nightmare" );
    level utility::flag_wait_all( "flag_trg_first_encounter_nightmare_vo", "flag_aries_nightmare_maze_intro_combat_spawned" );
    ob_story_mission_utils::objective_text_clear();
    activity_instance thread function_17700bec462ed5cb();
}

// Namespace namespace_a7ec45bcd7d54d98
// Params 0
// Checksum 0xea65984e, Offset: 0x29f9
// Size: 0x6d
function function_17700bec462ed5cb()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"ob_aries_nightmare_arena" );
    activity_instance thread ob_story_mission_utils::objective_text_show( "ob_aries_defeat_vermin" );
    level utility::flag_set( "flag_first_encounter_maze_objective" );
    utility::flag_wait_any( "flag_trg_maze_part_2", "flag_aries_nightmare_maze_intro_combat_complete" );
    ob_story_mission_utils::objective_text_clear();
    activity_instance thread function_263cb975549f48();
}

// Namespace namespace_a7ec45bcd7d54d98
// Params 0
// Checksum 0x7ac558fc, Offset: 0x2a6e
// Size: 0x60
function function_263cb975549f48()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level utility::flag_wait( "flag_aries_nightmare_maze_intro_combat_complete" );
    activity_instance thread ob_story_mission_utils::objective_text_show( "ob_aries_reveal_woods_memory" );
    level utility::flag_set( "flag_first_encounter_maze_objective" );
    utility::flag_wait( "flag_nm_maze_woods_memory_01_narration_complete" );
    ob_story_mission_utils::objective_text_clear();
}

