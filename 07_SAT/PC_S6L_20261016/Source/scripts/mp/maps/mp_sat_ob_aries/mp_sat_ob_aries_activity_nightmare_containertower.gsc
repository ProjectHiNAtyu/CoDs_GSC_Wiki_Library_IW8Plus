// scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_activity_nightmare_containertower.gsc  (hash_0f6673f38468321a.gscc) (size: 30015 Bytes / 0x753f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5f0bb43f (1594602559)
// size ...... 30015 (0x753f)
// includes .. 16  (offset: 0x675f)
// strings ... 193 (offset: 0x67df)
// dev strs .. 27  (offset: 0x73f3)
// exports ... 55  (offset: 0x49af)
// cseg ...... 0x1a2d + 0x2f82 (0x49af)
// imports ... 150 (offset: 0x5247)
// animtree1 . 0   (offset: 0x753f)
// animtree2 . 0   (offset: 0x753f)
#using script_16d8789bae43669e;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\lighting;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\interaction;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_audio;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_scenes;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_util;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_vo;
#using scripts\mp\ob\systems\ob_container_spawn_closet;

#namespace mp_sat_ob_aries_activity_nightmare_containertower;

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 0, eflags: 0x5
// Checksum 0x98ecbbab, Offset: 0x1a4b
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_e2e26ebe14d39c3f", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 0, eflags: 0x4
// Checksum 0x68265676, Offset: 0x1a74
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_ARIES_NIGHTMARE_CONTAINERTOWER";
    activity_common::registeractivitytype( "OB_ARIES_NIGHTMARE_CONTAINERTOWER", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_NIGHTMARE_CONTAINERTOWER", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_NIGHTMARE_CONTAINERTOWER", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_NIGHTMARE_CONTAINERTOWER", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_ARIES_NIGHTMARE_CONTAINERTOWER" );
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 0
// Checksum 0xa596d7da, Offset: 0x1aeb
// Size: 0x59
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance function_fabc42fdf8deb9c7();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 0
// Checksum 0xdbf2f319, Offset: 0x1b4c
// Size: 0x39
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance function_3c7b3f6c067765b0();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 0
// Checksum 0x2645da9b, Offset: 0x1b8d
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 1
// Checksum 0xf6fb730b, Offset: 0x1bb1
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread function_1c7fb9f356c06bd6( player );
    }
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 0
// Checksum 0x45b723d9, Offset: 0x1c6d
// Size: 0xd8
function function_fabc42fdf8deb9c7()
{
    activity_instance = self;
    ob_container_spawn_closet::function_e6f9ca6684759ebe( "p2_spawn_closet", "p2_fake_floor", "ob_sat_items_enemy_zombie_aries_spawn_closet" );
    level thread aries_util::bloodpool_player_setup();
    activity_instance thread function_d1ced418a6768db5();
    level.var_821f8d6f0a129792 = [];
    
    foreach ( player in level.players )
    {
        if ( !arraycontains( level.var_821f8d6f0a129792, player ) )
        {
            level.var_821f8d6f0a129792[ level.var_821f8d6f0a129792.size ] = player;
        }
    }
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 0
// Checksum 0x8b4e8178, Offset: 0x1d4d
// Size: 0x996
function function_3c7b3f6c067765b0()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    utility::add_fx( "memory_gun_active", "vfx_sat_mp_ob_ari_cradle_memory_gun_1" );
    utility::add_fx( "memory_transition", "vfx_sat_mp_ob_gem_memory_cradle_dissipate_1" );
    utility::add_fx( "memory_gun_char_spine", "vfx_sat_mp_ob_ari_cradle_memory_joint_1" );
    utility::add_fx( "memory_gun_char_knee_ri", "vfx_sat_mp_ob_ari_cradle_memory_joint_2" );
    utility::add_fx( "memory_gun_char_ankle_le", "vfx_sat_mp_ob_ari_cradle_memory_joint_3" );
    utility::add_fx( "memory_gun_char_wrist_le", "vfx_sat_mp_ob_ari_cradle_memory_joint_4" );
    activity_instance thread aries_util::memory_fx_init();
    level thread ob_story_mission_utils::function_fe3c20270b6e910a( "smb_tower_platform_model" );
    
    if ( !isdefined( level.var_8a09e86f6cea0eed ) )
    {
        level.var_8a09e86f6cea0eed = getent( "sbm_player_coll_transition", #targetname );
        level.var_8a09e86f6cea0eed connectpaths();
        level.var_8a09e86f6cea0eed notsolid();
    }
    
    level thread aries_util::function_4f28f01bdd215b23();
    performance_delay = 10;
    activity_instance thread aries_util::waterfall_handler( "vfx_tower_waterfall_lvl0_a1", "trig_bp_vfx_damage_tower_lvl0_a1", "flg_nmr_woods_memory_2_starting", "flag_aries_nightmare_tower_water_level_3", performance_delay + 2, "flag_nm_audio_waterfalls_start" );
    activity_instance thread aries_util::waterfall_handler( "vfx_tower_waterfall_lvl0_a2", "trig_bp_vfx_damage_tower_lvl0_a2", "flg_nmr_woods_memory_2_starting", "flag_aries_nightmare_tower_water_level_3", performance_delay + 6 );
    activity_instance thread aries_util::waterfall_handler( "vfx_tower_waterfall_lvl1_a1", "trig_bp_vfx_damage_tower_lvl1_a1", "flg_nmr_woods_memory_2_starting", "flag_aries_nightmare_tower_water_level_3", performance_delay + 4.5 );
    activity_instance thread aries_util::waterfall_handler( "vfx_tower_waterfall_lvl1_a2", "trig_bp_vfx_damage_tower_lvl1_a2", "flg_nmr_woods_memory_2_starting", "flag_aries_nightmare_tower_water_level_3", performance_delay + 3.5 );
    activity_instance thread aries_util::waterfall_handler( "vfx_tower_waterfall_lvl1_a3", "trig_bp_vfx_damage_tower_lvl1_a3", "flg_nmr_woods_memory_2_starting", "flag_aries_nightmare_tower_water_level_3", performance_delay + 5.5 );
    activity_instance thread aries_util::waterfall_handler( "vfx_tower_waterfall_lvl3_a1", "trig_bp_vfx_damage_tower_lvl3_a1", "flg_nmr_woods_memory_2_starting", "flag_aries_nightmare_tower_water_level_3", performance_delay + 6.5 );
    activity_instance thread function_e9586c3b3ea9b300();
    level thread aries_vo::function_e47d4dd40b082759();
    activity_instance thread function_adbdedfa3816a46e();
    level thread namespace_d11629872d017c15::function_cfa6e8177c92faf7();
    level thread namespace_d11629872d017c15::function_1479808cb43ea3ff();
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_nmr_tower_weapon", "flag_aries_nightmare_tower_complete", 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "str_equipment_tower", "flag_aries_nightmare_tower_complete", 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "str_tower_lethal", "flag_aries_nightmare_tower_complete", 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "str_tower_tactical", "flag_aries_nightmare_tower_complete", 1 );
    wait 0.5;
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "str_elevator_lethal", "flag_aries_nightmare_tower_complete", 1 );
    var_6a151ff2f1995a72 = getnoentvolumearray( "trig_maze_final_trasition", #targetname );
    var_6a151ff2f1995a72[ 0 ] waittill( #"trigger", player );
    utility::flag_set( "flag_aries_nightmare_maze_tower_transition" );
    var_23de8cf636e5a177 = getnoentvolumearray( "trig_containertower_entered", #targetname );
    var_23de8cf636e5a177[ 0 ] waittill( #"trigger", player );
    level utility::flag_set( "flag_aries_nightmare_tower_entered" );
    s_nmr_woods_memory_2_interact_ref = utility::getstruct( "s_nmr_woods_memory_2_interact_ref", "targetname" );
    e_nmr_woods_memory_2_interact_obj = getent( "e_nmr_woods_memory_2_interact_obj", #targetname );
    interact_struct = interaction::register_interact( s_nmr_woods_memory_2_interact_ref.origin, 64, &function_a5bdd091e741619c, &"sat_ob_story_missions_aries/reveal_woods_memory_obj", undefined, undefined, undefined, "HINT_BUTTON" );
    utility::flag_wait( "flg_nmr_woods_memory_2_starting" );
    activity_instance thread function_1e74f4a653a389e();
    
    if ( level.players.size > 1 )
    {
        activity_instance thread namespace_1f3f9eb1e9681da5::function_9dbeaf9ca833864( activity_instance, "player_catchup_nm_maze_tower", "flag_aries_nightmare_tower_catchup_complete", 3 );
        wait 3;
    }
    else
    {
        utility::flag_set( "flag_aries_nightmare_tower_catchup_complete" );
    }
    
    activity_instance thread function_6db88e9571f4e393();
    level.var_8a09e86f6cea0eed disconnectpaths();
    level.var_8a09e86f6cea0eed solid();
    activity_instance thread function_1cd624651247cd7e( "flag_aries_nightmare_crashsite_complete" );
    utility::flag_wait_any( "flag_nm_tower_woods_memory_02_narration_complete", "flag_aries_nightmare_narr_tower_a_skipped" );
    var_83fc12cf46a41ebf = getnoentvolumearray( "trig_tower_oob", #script_noteworthy );
    
    foreach ( trigger in var_83fc12cf46a41ebf )
    {
        trigger delete();
    }
    
    var_83fc12cf46a41ebf = undefined;
    var_faf2cd50cd20cbcc = getent( "sbm_tower_level0_nograpple", #targetname );
    var_faf2cd50cd20cbcc delete();
    activity_instance thread function_2bbc0040e189a606();
    utility::flag_wait( "flag_aries_nightmare_tower_catchup_complete" );
    activity_instance thread function_53005a9a86fae60e();
    activity_instance thread water_level_watcher();
    activity_instance utility::flag_set( "flag_aries_nightmare_tower_water_raise_start" );
    var_7e7dc3f64e33360a = utility::getstructarray( "nightmare_containertower_override_respawn_lvl1", "targetname" );
    
    if ( isdefined( var_7e7dc3f64e33360a ) )
    {
        ob_story_mission_utils::set_revive_spawns( var_7e7dc3f64e33360a );
    }
    else
    {
        var_7e7dc3f64e33360a = utility::getstructarray( "nightmare_containertower_override_respawn", "targetname" );
        ob_story_mission_utils::set_revive_spawns( var_7e7dc3f64e33360a );
    }
    
    utility::flag_wait( "flag_aries_nightmare_tower_barge_0_start" );
    activity_instance thread function_eaf0fa7e7143545d();
    utility::flag_wait_any( "flag_aries_nightmare_tower_water_level_edge_encounter_1_start", "flag_aries_nightmare_tower_barge_0_stop" );
    var_7e7dc3f64e33360a = utility::getstructarray( "nightmare_containertower_override_respawn_lvl2", "targetname" );
    
    if ( isdefined( var_7e7dc3f64e33360a ) )
    {
        ob_story_mission_utils::set_revive_spawns( var_7e7dc3f64e33360a );
    }
    else
    {
        var_7e7dc3f64e33360a = utility::getstructarray( "nightmare_containertower_override_respawn", "targetname" );
        ob_story_mission_utils::set_revive_spawns( var_7e7dc3f64e33360a );
    }
    
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "str_nmr_tower_weapon_random_lvl1", "flag_aries_nightmare_tower_water_raise_complete", 1, undefined, undefined, 1, 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "str_equipment_tower_selfrev_random_lvl1", "flag_aries_nightmare_tower_water_raise_complete", 1, undefined, undefined, 1, 1 );
    var_b14e3448120fa5d8 = activity_instance activity_ai_encounters::function_92b671064b0b1ce2( "vol_tower_enc_lvl1", 1, 1, 1, 1 );
    activity_ai_encounters::function_52d1342183200a8f( var_b14e3448120fa5d8, &function_f407a5bd0a7de3be );
    activity_instance thread aries_util::getplayercount( activity_instance );
    activity_instance thread function_960b52fec1a0ceee();
    utility::flag_wait( "flag_aries_nightmare_tower_level_2_spawncloset_start" );
    activity_instance thread aries_util::getplayercount( activity_instance );
    activity_instance thread function_960b51fec1a0ccbb();
    utility::flag_wait( "flag_aries_nightmare_tower_water_level_edge_encounter_2_start" );
    var_7e7dc3f64e33360a = utility::getstructarray( "nightmare_containertower_override_respawn_lvl3", "targetname" );
    
    if ( isdefined( var_7e7dc3f64e33360a ) )
    {
        ob_story_mission_utils::set_revive_spawns( var_7e7dc3f64e33360a );
    }
    else
    {
        var_7e7dc3f64e33360a = utility::getstructarray( "nightmare_containertower_override_respawn", "targetname" );
        ob_story_mission_utils::set_revive_spawns( var_7e7dc3f64e33360a );
    }
    
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "str_nmr_tower_weapon_random_lvl2", "flag_aries_nightmare_tower_water_raise_complete", 1, undefined, undefined, 1, 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "str_equipment_tower_selfrev_random_lvl2", "flag_aries_nightmare_tower_water_raise_complete", 1, undefined, undefined, 1, 1 );
    var_b14e3748120fac71 = activity_instance activity_ai_encounters::function_92b671064b0b1ce2( "vol_tower_enc_lvl2", 1, 1, 1, 1 );
    activity_ai_encounters::function_52d1342183200a8f( var_b14e3748120fac71, &function_f407a5bd0a7de3be );
    utility::flag_wait( "flag_aries_nightmare_tower_level_3_spawncloset_start" );
    activity_instance thread aries_util::getplayercount( activity_instance );
    activity_instance thread function_960b50fec1a0ca88();
    utility::flag_wait( "flag_aries_nightmare_tower_water_level_edge_encounter_3_start" );
    var_7e7dc3f64e33360a = utility::getstructarray( "nightmare_containertower_override_respawn", "targetname" );
    
    if ( isdefined( var_7e7dc3f64e33360a ) )
    {
        ob_story_mission_utils::set_revive_spawns( var_7e7dc3f64e33360a );
    }
    
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "str_nmr_tower_weapon_random_lvl3", "flag_aries_nightmare_tower_water_raise_complete", 1, undefined, undefined, 1, 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "str_equipment_tower_selfrev_random_lvl3", "flag_aries_nightmare_tower_water_raise_complete", 1, undefined, undefined, 1, 1 );
    utility::flag_wait( "flag_nm_tower_boss_encounter_vines_init" );
    level.var_8a09e86f6cea0eed delete();
    utility::flag_wait( "flag_aries_nightmare_tower_water_raise_complete" );
    utility::flag_set( "flag_nm_tower_boss_encounter_init" );
    utility::flag_wait( "flag_nm_tower_weakpoints_set_a_complete" );
    a_vine_door = getscriptablearray( "scr_vines_tower", #script_noteworthy );
    
    foreach ( door in a_vine_door )
    {
        door setscriptablepartstate( "base", "dead" );
    }
    
    var_e76757e35bd1f5fa = getentarray( "sm_tower_exit", #targetname );
    tower_exit_clip = getent( "smb_tower_exit_clip", #targetname );
    var_e76757e35bd1f5fa[ var_e76757e35bd1f5fa.size ] = tower_exit_clip;
    
    foreach ( blocker in var_e76757e35bd1f5fa )
    {
        blocker delete();
    }
    
    foreach ( player in level.players )
    {
        player earthquakeforplayer( 0.3, 0.5, player.origin, 256 );
        player playrumbleonpositionforclient( "artillery_rumble_light", player.origin );
    }
    
    var_db545fb9cd256e61 = getnoentvolumearray( "trig_containertower_completed", #targetname );
    var_db545fb9cd256e61[ 0 ] waittill( #"trigger", player );
    ob_story_mission_utils::set_revive_spawns();
    utility::flag_set( "flag_aries_nightmare_tower_complete" );
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 0
// Checksum 0xf8b552b7, Offset: 0x26eb
// Size: 0x69
function function_1e74f4a653a389e()
{
    activity_instance = self;
    wait 10;
    var_9fb960f9a14c7f0f = utility::getstruct( "s_memory_trauma_02_woods_sniper", "targetname" );
    
    if ( isdefined( var_9fb960f9a14c7f0f ) )
    {
        var_5b21050c7fd2a3ad = [ "s_memory_trauma_02_woods_sniper", "s_memory_trauma_02_alex_mason" ];
        var_9fb960f9a14c7f0f thread aries_util::function_3f8753d47ffa5842( var_5b21050c7fd2a3ad, 1.4 );
        level thread aries_audio::function_650914567ca4936f();
    }
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 0
// Checksum 0xe2d60fb6, Offset: 0x275c
// Size: 0x39
function function_cf7f116f0f2684b()
{
    wait 2;
    killfxontag( level._effect[ "memory_gun_active" ], self, "tag_origin" );
    playfxontag( level._effect[ "memory_transition" ], self, "tag_origin" );
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 0
// Checksum 0x98ed1ef6, Offset: 0x279d
// Size: 0x5d
function function_21436135c7924004()
{
    var_52e7a45bab517f32 = getnoentvolumearray( "trig_containertower_lvl1", #targetname );
    var_52e7a45bab517f32[ 0 ] waittill( #"trigger", player );
    utility::flag_set( "FLAG_START_LEVEL1_ENCOUNTER" );
    utility::flag_set( "flag_aries_nightmare_narr_tower_a_skipped" );
    utility::flag_set( "flg_nmr_woods_memory_2_starting" );
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 1
// Checksum 0x65a37cf0, Offset: 0x2802
// Size: 0x55
function function_1c7fb9f356c06bd6( player )
{
    activity_instance = self;
    player thread aries_audio::function_6b17b966d7327acd();
    player thread function_b1183f0e4bada096();
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        player ob_story_mission_utils::function_2383fc8bfc3074d2();
        player ob_story_mission_utils::function_288fdad79fa2a11();
    }
}

/#

    // Namespace mp_sat_ob_aries_activity_nightmare_containertower
    // Params 0
    // Checksum 0x90de21d4, Offset: 0x285f
    // Size: 0x5, Type: dev
    function function_bb1447edaf07271b()
    {
        
    }

#/

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 4
// Checksum 0x5a8ae2de, Offset: 0x286c
// Size: 0x155
function function_f407a5bd0a7de3be( requestid, activity_instance, agent, data )
{
    agent function_fa32376aaa88a7a2( agent.origin, 5000 );
    agent aries_util::function_fe0a54195e81bbc6();
    
    if ( agent.basearchetype == "zombie_parasite" )
    {
        if ( level.playercount > 2 || !level.is_squad_size_small )
        {
            agent function_786bb6aa1b76c7ee( "spit_max_target_count", 3 );
            agent.var_fe9bb2f0c2468d9a = 5;
            agent.var_95fe29c1ef1d5ac0 = 8;
        }
        else
        {
            agent function_786bb6aa1b76c7ee( "spit_max_target_count", 3 );
            agent.var_fe9bb2f0c2468d9a = 5;
            agent.var_95fe29c1ef1d5ac0 = 8;
        }
    }
    
    if ( agent.basearchetype == "zombie_vermin" )
    {
        if ( level.playercount > 2 || !level.is_squad_size_small )
        {
            agent function_786bb6aa1b76c7ee( "spit_max_target_count", 3 );
            agent.var_fe9bb2f0c2468d9a = 5;
            agent.var_95fe29c1ef1d5ac0 = 8;
            return;
        }
        
        agent function_786bb6aa1b76c7ee( "spit_max_target_count", 3 );
        agent.var_fe9bb2f0c2468d9a = 5;
        agent.var_95fe29c1ef1d5ac0 = 8;
    }
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 4
// Checksum 0x7fb06483, Offset: 0x29c9
// Size: 0x29, Type: bool
function function_183815da4673dfd6( requestid, activity_instance, agent, data )
{
    return true;
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 2
// Checksum 0x4077a0d6, Offset: 0x29fb
// Size: 0x23, Type: bool
function function_b45aca6f80a6bb30( requestid, userdata )
{
    utility::flag_wait( "flag_aries_nightmare_tower_water_level_edge_encounter_1_start" );
    return true;
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 2
// Checksum 0xfe47271c, Offset: 0x2a27
// Size: 0x23, Type: bool
function function_3d5ed7acc2e8dcd5( requestid, userdata )
{
    utility::flag_wait( "flag_aries_nightmare_tower_barge_1_stop" );
    return true;
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 2
// Checksum 0x6b8c6c45, Offset: 0x2a53
// Size: 0x23, Type: bool
function function_ee2a0cbb58eebe54( requestid, userdata )
{
    utility::flag_wait( "flag_aries_nightmare_tower_water_level_2" );
    return true;
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 0
// Checksum 0x80049ac9, Offset: 0x2a7f
// Size: 0x130
function function_5ab9de126f4a8323()
{
    level endon( #"game_ended" );
    level endon( #"flag_aries_nightmare_tower_complete" );
    utility::flag_wait( "flag_aries_nightmare_tower_water_traversal_2to1_disable" );
    var_b2f8e5c576d3e25f = getnodearray( "traversal_lvl2_down", "script_noteworthy" );
    
    foreach ( traversal in var_b2f8e5c576d3e25f )
    {
        destroynavlink( traversal );
    }
    
    utility::flag_wait( "flag_aries_nightmare_tower_water_traversal_3to2_disable" );
    var_b2f8e5c576d3e25f = getnodearray( "traversal_lvl3_down", "script_noteworthy" );
    
    foreach ( traversal in var_b2f8e5c576d3e25f )
    {
        destroynavlink( traversal );
    }
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 0
// Checksum 0x199ecba9, Offset: 0x2bb7
// Size: 0x108
function function_6db88e9571f4e393()
{
    if ( !isdefined( str_team ) )
    {
        str_team = "team_hundred_ninety";
    }
    
    s_nmr_woods_memory_2_interact_ref = utility::getstruct( "s_nmr_woods_memory_2_interact_ref", "targetname" );
    a_ai = getaiarray();
    
    if ( a_ai.size > 0 )
    {
        foreach ( ai in a_ai )
        {
            if ( distance2d( ai.origin, s_nmr_woods_memory_2_interact_ref.origin ) < 1500 )
            {
                a_ai = arrayremove( a_ai, ai );
                continue;
            }
            
            if ( isalive( ai ) )
            {
                ai.diequietly = 1;
                ai.var_a13bed1ac47e1b2c = 1;
                ai kill();
            }
        }
    }
}

/#

    // Namespace mp_sat_ob_aries_activity_nightmare_containertower
    // Params 0
    // Checksum 0xbd8d3381, Offset: 0x2cc7
    // Size: 0x5, Type: dev
    function function_c4c628d7d5d211a4()
    {
        
    }

#/

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 0
// Checksum 0x43044493, Offset: 0x2cd4
// Size: 0x3a
function function_eaf0fa7e7143545d()
{
    thread function_c5442d49630fc045( "vol_tower_enc_barge_intro", "sm_barge_spawnpoint", "flag_aries_nightmare_tower_barge_0_stop" );
    utility::flag_wait( "flag_aries_nightmare_tower_barge_1_start" );
    thread function_c5442d49630fc045( "vol_tower_enc_barge_a", "sm_barge_spawnpoint", "flag_aries_nightmare_tower_barge_1_stop" );
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 4
// Checksum 0x3098b579, Offset: 0x2d16
// Size: 0x4d
function function_b5c6cf5a7661161a( requestid, userdata, agent, data )
{
    data.animscripted_alias = "no_anim";
    agent function_fa32376aaa88a7a2( agent.origin, 5000 );
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 3
// Checksum 0xfd103483, Offset: 0x2d6b
// Size: 0x12a
function function_c5442d49630fc045( vol_encounter, var_b0b87874c88ab210, shutdown_flag )
{
    a_e_spawn_pos = getentarray( var_b0b87874c88ab210, #targetname );
    encounter = ai_spawn_director::lookup_spawn_request( vol_encounter );
    ai_spawn_director::function_c99d360d62c49a9c( encounter, &function_183815da4673dfd6 );
    ai_spawn_director::add_spawned_callback( encounter, &function_b5c6cf5a7661161a );
    
    switch ( vol_encounter )
    {
        case #"hash_3548bc6bd9ea284":
            ai_spawn_director::function_53289c032f506bb1( encounter, &function_b45aca6f80a6bb30 );
            break;
        case #"hash_6ab1f14b46916741":
            ai_spawn_director::function_53289c032f506bb1( encounter, &function_3d5ed7acc2e8dcd5 );
            break;
        case #"hash_6ab1ee4b46916288":
            ai_spawn_director::function_53289c032f506bb1( encounter, &function_ee2a0cbb58eebe54 );
            break;
    }
    
    i = 0;
    
    while ( !utility::flag( shutdown_flag ) )
    {
        if ( i >= a_e_spawn_pos.size )
        {
            i = 0;
            function_c505198907e0d306( encounter, a_e_spawn_pos[ i ], 1 );
            function_ef57f478f96b050c( encounter, 1 );
        }
        else
        {
            function_c505198907e0d306( encounter, a_e_spawn_pos[ i ], 1 );
            function_ef57f478f96b050c( encounter, 1 );
            i++;
        }
        
        wait 1;
    }
    
    function_ef57f478f96b050c( encounter, 0 );
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 0
// Checksum 0x6e9065d7, Offset: 0x2e9d
// Size: 0x1a6
function function_960b52fec1a0ceee()
{
    spawn_closet_a = getent( "spawn_closet_tower_lvl1_A", #targetname );
    spawn_closet_b = getent( "spawn_closet_tower_lvl1_B", #targetname );
    spawn_closet_c = getent( "spawn_closet_tower_lvl1_C", #targetname );
    spawn_closet_d = getent( "spawn_closet_tower_lvl1_D", #targetname );
    spawn_closet_e = getent( "spawn_closet_tower_lvl1_E", #targetname );
    spawn_closet_f = getent( "spawn_closet_tower_lvl1_F", #targetname );
    waitframe();
    
    if ( level.playercount > 2 || !level.is_squad_size_small )
    {
        /#
            iprintlnbold( "<dev string:x24>" );
        #/
        
        spawn_closet_b thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_tower_lvl1_b_enc", "ai_encounter:aries_p2_spawn_closet_encounter_cradle_guild", "grunt", 4 );
        utility::flag_wait_or_timeout( "flag_shutdown_spawn_closet_tower_lvl1_a_enc", 2 );
        spawn_closet_c thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_tower_lvl1_c_enc", "ai_encounter:aries_p2_spawn_closet_encounter_cradle_guild", "grunt", 4 );
        utility::flag_wait_or_timeout( "flag_shutdown_spawn_closet_tower_lvl1_c_enc", 2 );
        spawn_closet_f thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_tower_lvl1_f_enc", "ai_encounter:aries_p2_spawn_closet_encounter_cradle_guild", "grunt", 4 );
        aries_util::function_33c5d646b9cd4113( 8, "flag_aries_nightmare_tower_level_1_base_combat_complete", "flag_aries_nightmare_tower_water_level_1" );
        return;
    }
    
    /#
        iprintlnbold( "<dev string:x4f>" );
    #/
    
    spawn_closet_c thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_tower_lvl1_c_enc", "ai_encounter:aries_p2_spawn_closet_encounter_cradle_guild", "grunt", 2 );
    utility::flag_wait_or_timeout( "flag_shutdown_spawn_closet_tower_lvl1_c_enc", 3 );
    spawn_closet_f thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_tower_lvl1_f_enc", "ai_encounter:aries_p2_spawn_closet_encounter_cradle_guild", "grunt", 2 );
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 0
// Checksum 0xdec2b495, Offset: 0x304b
// Size: 0x14b
function function_960b51fec1a0ccbb()
{
    spawn_closet_a = getent( "spawn_closet_tower_lvl2_A", #targetname );
    spawn_closet_b = getent( "spawn_closet_tower_lvl2_B", #targetname );
    spawn_closet_c = getent( "spawn_closet_tower_lvl2_C", #targetname );
    waitframe();
    
    if ( level.playercount > 2 || !level.is_squad_size_small )
    {
        /#
            iprintlnbold( "<dev string:x7a>" );
        #/
        
        spawn_closet_a thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_tower_lvl2_a_enc", "ai_encounter:aries_p2_spawn_closet_encounter_cradle_guild", "grunt_long", 2, 20 );
        wait 1;
        aries_util::function_33c5d646b9cd4113( 5, "flag_aries_nightmare_tower_level_2_base_combat_complete", "flag_aries_nightmare_tower_water_level_2" );
        utility::flag_wait_or_timeout( "flag_aries_nightmare_tower_level_2_base_combat_complete", 6 );
        spawn_closet_c thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_tower_lvl2_c_enc", "ai_encounter:aries_p2_spawn_closet_encounter_cradle_guild", "grunt", 4, 20 );
        return;
    }
    
    /#
        iprintlnbold( "<dev string:xa5>" );
    #/
    
    spawn_closet_a thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_tower_lvl2_a_enc", "ai_encounter:aries_p2_spawn_closet_encounter_cradle_guild", "grunt_long", 2, 20 );
    wait 3;
    aries_util::function_33c5d646b9cd4113( 5, "flag_aries_nightmare_tower_level_2_base_combat_complete", "flag_aries_nightmare_tower_water_level_2" );
    utility::flag_wait_or_timeout( "flag_aries_nightmare_tower_level_2_base_combat_complete", 8 );
    spawn_closet_c thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_tower_lvl2_c_enc", "ai_encounter:aries_p2_spawn_closet_encounter_cradle_guild", "grunt", 2, 20 );
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 0
// Checksum 0xa807ee3e, Offset: 0x319e
// Size: 0x15d
function function_960b50fec1a0ca88()
{
    spawn_closet_a = getent( "spawn_closet_tower_lvl3_A", #targetname );
    spawn_closet_b = getent( "spawn_closet_tower_lvl3_B", #targetname );
    spawn_closet_c = getent( "spawn_closet_tower_lvl3_C", #targetname );
    waitframe();
    
    if ( level.playercount > 2 || !level.is_squad_size_small )
    {
        /#
            iprintlnbold( "<dev string:xd0>" );
        #/
        
        spawn_closet_a thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_tower_lvl3_a_enc", "ai_encounter:aries_p2_spawn_closet_encounter_cradle_guild", "grunt", 4, 20 );
        utility::flag_wait_or_timeout( "flag_shutdown_spawn_closet_tower_lvl3_a_enc", 2 );
        spawn_closet_b thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_tower_lvl3_b_enc", "ai_encounter:aries_p2_spawn_closet_encounter_cradle_guild", "grunt_lmg", 2, 20 );
        wait 2;
        spawn_closet_c thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_tower_lvl3_c_enc", "ai_encounter:aries_p2_spawn_closet_encounter_cradle_guild", "grunt", 4, 20 );
        return;
    }
    
    /#
        iprintlnbold( "<dev string:xfb>" );
    #/
    
    spawn_closet_a thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_tower_lvl3_a_enc", "ai_encounter:aries_p2_spawn_closet_encounter_cradle_guild", "grunt_lmg", 2, 20 );
    utility::flag_wait_or_timeout( "flag_shutdown_spawn_closet_tower_lvl3_a_enc", 4 );
    spawn_closet_b thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_tower_lvl3_b_enc", "ai_encounter:aries_p2_spawn_closet_encounter_cradle_guild", "grunt", 2, 20 );
    wait 4;
    spawn_closet_c thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_tower_lvl3_c_enc", "ai_encounter:aries_p2_spawn_closet_encounter_cradle_guild", "grunt", 2, 20 );
}

/#

    // Namespace mp_sat_ob_aries_activity_nightmare_containertower
    // Params 0
    // Checksum 0xbfa53a67, Offset: 0x3303
    // Size: 0x5, Type: dev
    function function_475f62dfeb52a4f9()
    {
        
    }

#/

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 0
// Checksum 0x8c55659b, Offset: 0x3310
// Size: 0x79
function door_blocker_handler()
{
    var_40be060335ef6caf = getent( "smb_containertower_door_blocker", #targetname );
    
    if ( !isdefined( var_40be060335ef6caf ) )
    {
        /#
            iprintlnbold( "<dev string:x126>" );
        #/
        
        return;
    }
    
    waitframe();
    var_40be060335ef6caf hide();
    var_8fa77ea8b904984 = getnoentvolumearray( "trig_containertower_water_sequence", #targetname );
    var_8fa77ea8b904984[ 0 ] waittill( #"trigger", player );
    var_40be060335ef6caf show();
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 1
// Checksum 0x365ec104, Offset: 0x3391
// Size: 0x176
function function_1cd624651247cd7e( cleanup_flag )
{
    var_50df729348a66213 = [];
    var_efcdd01e22f653f0 = getent( "sm_tower_intro_transition_b_l3", #targetname );
    var_50df729348a66213[ var_50df729348a66213.size ] = var_efcdd01e22f653f0;
    var_efcdd31e22f65a89 = getent( "sm_tower_intro_transition_b_r2", #targetname );
    var_50df729348a66213[ var_50df729348a66213.size ] = var_efcdd31e22f65a89;
    var_efcdd21e22f65856 = getent( "sm_tower_intro_transition_b_l2", #targetname );
    var_50df729348a66213[ var_50df729348a66213.size ] = var_efcdd21e22f65856;
    var_efcdd51e22f65eef = getent( "sm_tower_intro_transition_b_r1", #targetname );
    var_50df729348a66213[ var_50df729348a66213.size ] = var_efcdd51e22f65eef;
    var_efcdd41e22f65cbc = getent( "sm_tower_intro_transition_b_l1", #targetname );
    var_50df729348a66213[ var_50df729348a66213.size ] = var_efcdd41e22f65cbc;
    var_efcdd71e22f66355 = getent( "sm_tower_intro_transition_b_r3", #targetname );
    var_50df729348a66213[ var_50df729348a66213.size ] = var_efcdd71e22f66355;
    level thread aries_audio::function_344308701ab3439b();
    aries_util::function_2ad4d6454b67c8a8( var_50df729348a66213 );
    utility::flag_wait( cleanup_flag );
    
    foreach ( ent in var_50df729348a66213 )
    {
        ent delete();
    }
    
    var_50df729348a66213 = undefined;
}

/#

    // Namespace mp_sat_ob_aries_activity_nightmare_containertower
    // Params 0
    // Checksum 0xe7f5c73b, Offset: 0x350f
    // Size: 0x5, Type: dev
    function function_e19429f0d3b1ed36()
    {
        
    }

#/

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 1
// Checksum 0xd970c641, Offset: 0x351c
// Size: 0x4c
function function_ccb4220bf1f66b10( water_height )
{
    while ( !utility::flag( "flag_nm_tower_boss_encounter_vines_init" ) )
    {
        if ( level.water_offset > water_height )
        {
            /#
                iprintlnbold( "<dev string:x15c>" );
            #/
            
            utility::flag_set( "flag_nm_tower_boss_encounter_vines_init" );
        }
        
        wait 0.5;
    }
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 0
// Checksum 0x19dec301, Offset: 0x3570
// Size: 0x116
function function_2bbc0040e189a606()
{
    activity_instance = self;
    activity_instance thread aries_util::function_d092342c9ead418d( "scr_nmr_tower_weakpoint_a_1", "flag_aries_nightmare_tower_water_level_90", "weak_point_tower_vine_long_a", undefined, undefined, "flag_nm_tower_weakpoint_a_1_destroyed", "flag_nm_tower_weakpoint_vine_a_1_complete", 0 );
    activity_instance thread aries_util::function_d092342c9ead418d( "scr_nmr_tower_weakpoint_a_2", "flag_aries_nightmare_tower_water_level_90", "weak_point_tower_vine_short_a", undefined, undefined, "flag_nm_tower_weakpoint_a_2_destroyed", "flag_nm_tower_weakpoint_vine_a_2_complete", 0 );
    activity_instance thread aries_util::function_d092342c9ead418d( "scr_nmr_tower_weakpoint_a_3", "flag_aries_nightmare_tower_water_level_90", "weak_point_tower_vine_short_b", undefined, undefined, "flag_nm_tower_weakpoint_a_3_destroyed", "flag_nm_tower_weakpoint_vine_a_3_complete", 0 );
    activity_instance thread aries_util::function_d092342c9ead418d( "scr_nmr_tower_weakpoint_a_4", "flag_aries_nightmare_tower_water_level_90", "weak_point_tower_vine_long_b", undefined, undefined, "flag_nm_tower_weakpoint_a_4_destroyed", "flag_nm_tower_weakpoint_vine_a_4_complete", 0 );
    activity_instance thread function_cf4273a0207d0faa( "flag_nm_tower_weakpoint_a_2_destroyed", "towerWeakPointLight_001" );
    activity_instance thread function_cf4273a0207d0faa( "flag_nm_tower_weakpoint_a_1_destroyed", "towerWeakPointLight_002" );
    activity_instance thread function_cf4273a0207d0faa( "flag_nm_tower_weakpoint_a_4_destroyed", "towerWeakPointLight_003" );
    activity_instance thread function_cf4273a0207d0faa( "flag_nm_tower_weakpoint_a_3_destroyed", "towerWeakPointLight_004" );
    utility::flag_wait_all( "flag_nm_tower_weakpoint_vine_a_1_complete", "flag_nm_tower_weakpoint_vine_a_2_complete", "flag_nm_tower_weakpoint_vine_a_3_complete", "flag_nm_tower_weakpoint_vine_a_4_complete" );
    utility::flag_set( "flag_nm_tower_weakpoints_set_a_complete" );
}

/#

    // Namespace mp_sat_ob_aries_activity_nightmare_containertower
    // Params 0
    // Checksum 0x10dfb2d2, Offset: 0x368e
    // Size: 0x5, Type: dev
    function function_50df6813fa2eded1()
    {
        
    }

#/

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 1
// Checksum 0x6b771cf9, Offset: 0x369b
// Size: 0x41
function function_a5bdd091e741619c( player )
{
    self makeunusable();
    utility::flag_set( "flg_nmr_woods_memory_2_starting" );
    player thread function_703fb0379225bbc5( player );
    
    /#
        iprintlnbold( "<dev string:x172>" );
    #/
    
    utility::flag_set( "flg_nmr_woods_memory_2_complete" );
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 1
// Checksum 0x96eac4d1, Offset: 0x36e4
// Size: 0x23
function function_703fb0379225bbc5( player )
{
    player playrumbleonpositionforclient( "viewmodel_large", player.origin );
}

/#

    // Namespace mp_sat_ob_aries_activity_nightmare_containertower
    // Params 0
    // Checksum 0x173f540e, Offset: 0x370f
    // Size: 0x5, Type: dev
    function function_43b34d6285bc114e()
    {
        
    }

#/

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 0
// Checksum 0x8eab5013, Offset: 0x371c
// Size: 0x3f9
function function_adbdedfa3816a46e()
{
    activity_instance = self;
    activity_instance endon( #"flag_aries_nightmare_crashsite_complete" );
    var_8a433f3735c6cb2c = getentarray( "sm_barge_spawnpoint", #targetname );
    var_301166e291628db3 = getent( "sm_barge_spawnpoint_roof", #targetname );
    
    foreach ( ent in var_8a433f3735c6cb2c )
    {
        ent hide();
    }
    
    var_301166e291628db3 hide();
    var_3c6e4a0c8a5d936e = getent( "smb_tower_platform_model", #targetname );
    tower_elevator_collision = getent( "smb_tower_platform_collision", #targetname );
    trig_on_barge = getent( "trig_on_barge", #targetname );
    var_493278b774cfe542 = utility::getstruct( "str_tower_elevator_target_boss_encounter", "targetname" );
    utility::register_moving_platform_ent( var_3c6e4a0c8a5d936e );
    tower_elevator_collision enablelinkto();
    
    foreach ( ent in var_8a433f3735c6cb2c )
    {
        ent enablelinkto();
    }
    
    if ( isdefined( trig_on_barge ) )
    {
        trig_on_barge enablelinkto();
    }
    
    wait 0.5;
    tower_elevator_collision linkto( var_3c6e4a0c8a5d936e );
    
    foreach ( ent in var_8a433f3735c6cb2c )
    {
        ent linkto( var_3c6e4a0c8a5d936e );
    }
    
    if ( isdefined( trig_on_barge ) )
    {
        trig_on_barge linkto( var_3c6e4a0c8a5d936e );
    }
    else
    {
        /#
            iprintlnbold( "<dev string:x18e>" );
        #/
    }
    
    utility::flag_wait( "flag_aries_nightmare_tower_water_raise_start" );
    level thread water_ai_cleanup( var_3c6e4a0c8a5d936e );
    level thread aries_audio::function_29eb8215bdbb044d( var_3c6e4a0c8a5d936e );
    
    foreach ( player in level.players )
    {
        player earthquakeforplayer( 0.5, 1, player.origin, 256 );
        player playrumbleonpositionforclient( "artillery_rumble_heavy", player.origin );
    }
    
    var_3c6e4a0c8a5d936e moveto( var_493278b774cfe542.origin, 140, 0.1, 0.1 );
    var_3c6e4a0c8a5d936e rotateto( ( 0, 272, 0 ), 100, 0.1, 0.1 );
    level.water_offset = 0;
    maxoffset = 3650;
    var_51f8199c5ea550b9 = 25;
    ticktime = 0.05;
    
    while ( level.water_offset <= maxoffset )
    {
        if ( !utility::flag( "flag_aries_nightmare_crashsite_complete" ) )
        {
            level.water_offset += var_51f8199c5ea550b9 * ticktime;
            function_f3a6772c8b060a41( level.water_offset );
            
            if ( !utility::flag( "flag_aries_nightmare_tower_complete" ) )
            {
                /#
                    iprintln( "<dev string:x1e0>" + level.water_offset );
                #/
            }
        }
        
        wait ticktime;
    }
    
    utility::flag_set( "flag_aries_nightmare_tower_water_raise_complete" );
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 0
// Checksum 0xf77f3247, Offset: 0x3b1d
// Size: 0x4b
function function_b1183f0e4bada096()
{
    self endon( #"disconnect" );
    utility::flag_wait( "flag_aries_nightmare_tower_water_raise_start" );
    trig_on_barge = getent( "trig_on_barge", #targetname );
    thread aries_util::player_camera_sway_enable( trig_on_barge, "flag_nm_tower_boss_encounter_vines_init", 0.8 );
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 0
// Checksum 0xa69bffe8, Offset: 0x3b70
// Size: 0x515
function water_level_watcher()
{
    level endon( #"flag_aries_nightmare_crashsite_complete" );
    
    while ( !utility::flag( "flag_aries_nightmare_tower_water_raise_complete" ) )
    {
        if ( level.water_offset > 250 && !utility::flag( "flag_local_barge_enc_0_pre_warn" ) )
        {
            /#
                iprintlnbold( "<dev string:x1f7>" );
            #/
            
            foreach ( player in level.players )
            {
                player thread aries_audio::function_f6cbf058f9afe425();
                player thread function_abdaee24f5ee315d();
            }
            
            utility::flag_set( "flag_local_barge_enc_0_pre_warn" );
        }
        else if ( level.water_offset > 300 && !utility::flag( "flag_aries_nightmare_tower_barge_0_start" ) )
        {
            /#
                iprintlnbold( "<dev string:x214>" );
            #/
            
            utility::flag_set( "flag_aries_nightmare_tower_barge_0_start" );
        }
        else if ( level.water_offset > 700 && !utility::flag( "flag_aries_nightmare_tower_barge_0_stop" ) )
        {
            /#
                iprintlnbold( "<dev string:x22f>" );
            #/
            
            utility::flag_set( "flag_aries_nightmare_tower_barge_0_stop" );
        }
        else if ( level.water_offset > 925 && !utility::flag( "flag_aries_nightmare_tower_water_level_edge_encounter_1_start" ) )
        {
            /#
                iprintlnbold( "<dev string:x24a>" );
            #/
            
            utility::flag_set( "flag_aries_nightmare_tower_water_level_edge_encounter_1_start" );
        }
        else if ( level.water_offset > 1100 && !utility::flag( "flag_aries_nightmare_tower_water_level_1" ) )
        {
            /#
                iprintlnbold( "<dev string:x267>" );
            #/
            
            utility::flag_set( "flag_aries_nightmare_tower_water_level_1" );
        }
        else if ( level.water_offset >= 1600 && !utility::flag( "flag_aries_nightmare_tower_level_2_spawncloset_start" ) )
        {
            /#
                iprintlnbold( "<dev string:x27e>" );
            #/
            
            utility::flag_set( "flag_aries_nightmare_tower_level_2_spawncloset_start" );
        }
        else if ( level.water_offset >= 1700 && !utility::flag( "flag_aries_nightmare_tower_water_level_2" ) )
        {
            /#
                iprintlnbold( "<dev string:x2a5>" );
            #/
            
            utility::flag_set( "flag_aries_nightmare_tower_water_level_2" );
        }
        else if ( level.water_offset >= 1725 && !utility::flag( "flag_aries_nightmare_tower_water_level_edge_encounter_2_start" ) )
        {
            /#
                iprintlnbold( "<dev string:x2bc>" );
            #/
            
            utility::flag_set( "flag_aries_nightmare_tower_water_level_edge_encounter_2_start" );
        }
        else if ( level.water_offset > 1850 && !utility::flag( "flag_local_barge_enc_1_pre_warn" ) )
        {
            /#
                iprintlnbold( "<dev string:x2df>" );
            #/
            
            utility::flag_set( "flag_local_barge_enc_1_pre_warn" );
        }
        else if ( level.water_offset >= 2400 && !utility::flag( "flag_aries_nightmare_tower_level_3_spawncloset_start" ) )
        {
            /#
                iprintlnbold( "<dev string:x2fc>" );
            #/
            
            utility::flag_set( "flag_aries_nightmare_tower_level_3_spawncloset_start" );
        }
        else if ( level.water_offset > 2500 && !utility::flag( "flag_aries_nightmare_tower_water_level_3" ) )
        {
            /#
                iprintlnbold( "<dev string:x323>" );
            #/
            
            utility::flag_set( "flag_aries_nightmare_tower_water_level_3" );
        }
        else if ( level.water_offset > 2600 && !utility::flag( "flag_aries_nightmare_tower_water_level_edge_encounter_3_start" ) )
        {
            /#
                iprintlnbold( "<dev string:x33a>" );
            #/
            
            utility::flag_set( "flag_aries_nightmare_tower_water_level_edge_encounter_3_start" );
        }
        else if ( level.water_offset > 2950 && !utility::flag( "flag_local_barge_enc_final_pre_warn" ) )
        {
            /#
                iprintlnbold( "<dev string:x359>" );
            #/
            
            foreach ( player in level.players )
            {
                player thread function_abdaee24f5ee315d();
                player thread aries_audio::function_6da7cb25be5201da();
            }
            
            utility::flag_set( "flag_local_barge_enc_final_pre_warn" );
        }
        else if ( level.water_offset >= 3000 && !utility::flag( "flag_aries_nightmare_tower_barge_1_start" ) )
        {
            /#
                iprintlnbold( "<dev string:x37d>" );
            #/
            
            utility::flag_set( "flag_aries_nightmare_tower_barge_1_start" );
        }
        else if ( level.water_offset > 3350 && !utility::flag( "flag_aries_nightmare_tower_barge_1_stop" ) )
        {
            /#
                iprintlnbold( "<dev string:x398>" );
            #/
            
            utility::flag_set( "flag_aries_nightmare_tower_barge_1_stop" );
        }
        else if ( level.water_offset > 3400 && !utility::flag( "flag_aries_nightmare_tower_water_level_90" ) )
        {
            /#
                iprintlnbold( "<dev string:x3b1>" );
            #/
            
            utility::flag_set( "flag_aries_nightmare_tower_water_level_90" );
        }
        else if ( level.water_offset > 3500 && !utility::flag( "flag_nm_tower_boss_encounter_vines_init" ) )
        {
            /#
                iprintlnbold( "<dev string:x3b1>" );
            #/
            
            utility::flag_set( "flag_nm_tower_boss_encounter_vines_init" );
        }
        
        wait 1;
    }
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 1
// Checksum 0xaf248ae5, Offset: 0x408d
// Size: 0x126
function water_ai_cleanup( var_710ca6e88772b224 )
{
    level endon( #"flag_aries_nightmare_tower_complete" );
    
    while ( true )
    {
        if ( !isdefined( str_team ) )
        {
            str_team = "team_hundred_ninety";
        }
        
        a_ai = getaiarrayinradius( var_710ca6e88772b224.origin, 1500, str_team );
        
        if ( a_ai.size > 0 )
        {
            foreach ( ai in a_ai )
            {
                if ( isalive( ai ) )
                {
                    if ( ai.origin[ 2 ] < var_710ca6e88772b224.origin[ 2 ] - 80 )
                    {
                        ai.diequietly = 1;
                        ai.var_a13bed1ac47e1b2c = 1;
                        ai kill();
                    }
                }
            }
            
            if ( utility::flag( "flag_aries_nightmare_tower_complete" ) )
            {
                break;
            }
        }
        
        wait 1;
    }
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 0
// Checksum 0xeb7380be, Offset: 0x41bb
// Size: 0xa9
function function_53005a9a86fae60e()
{
    utility::flag_wait( "flag_aries_nightmare_crashsite_complete" );
    function_f3a6772c8b060a41( -5000 );
    minoffset = 0;
    var_51f8199c5ea550b9 = 20;
    ticktime = 0.01;
    offset = level.water_offset;
    
    while ( offset <= minoffset )
    {
        if ( !utility::flag( "flag_aries_nightmare_crashsite_complete" ) )
        {
            level.water_offset += var_51f8199c5ea550b9 * ticktime;
            function_f3a6772c8b060a41( level.water_offset );
            
            /#
                iprintln( "<dev string:x1e0>" + level.water_offset );
            #/
        }
        
        wait ticktime;
    }
}

/#

    // Namespace mp_sat_ob_aries_activity_nightmare_containertower
    // Params 0
    // Checksum 0x806c7111, Offset: 0x426c
    // Size: 0x5, Type: dev
    function function_caf9a886db202b()
    {
        
    }

#/

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 0
// Checksum 0xd0e203d1, Offset: 0x4279
// Size: 0xa3
function function_e9586c3b3ea9b300()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    a_t_memory = getnoentvolumearray( "t_nmr_containertower_memory_objective", #targetname );
    a_t_memory[ 0 ] waittill( #"trigger" );
    wait 0.5;
    activity_instance thread ob_story_mission_utils::objective_text_show( "ob_aries_reveal_woods_memory" );
    s_nmr_woods_memory_2_interact_ref = utility::getstruct( "s_nmr_woods_memory_2_interact_ref", "targetname" );
    thread function_a4be8d6f52267915( s_nmr_woods_memory_2_interact_ref );
    utility::flag_wait( "flg_nmr_woods_memory_2_complete" );
    ob_story_mission_utils::objective_text_clear();
    activity_instance thread function_2c911d126eaa3735();
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 1
// Checksum 0xf9362fe8, Offset: 0x4324
// Size: 0x11c
function function_a4be8d6f52267915( memory_interact )
{
    var_8ec10611cdf1a599 = [];
    
    foreach ( player in level.var_821f8d6f0a129792 )
    {
        if ( !arraycontains( var_8ec10611cdf1a599, player ) )
        {
            var_8ec10611cdf1a599[ var_8ec10611cdf1a599.size ] = player;
            player thread function_b3fc04f734aa6113( memory_interact );
        }
    }
    
    var_879893c3755f65c5 = getnoentvolumearray( "t_nmr_containertower_memory_objective", #targetname );
    
    while ( !utility::flag( "flg_nmr_woods_memory_2_complete" ) )
    {
        var_879893c3755f65c5[ 0 ] waittill( #"trigger", triggerer );
        
        if ( isplayer( triggerer ) && !arraycontains( var_8ec10611cdf1a599, triggerer ) )
        {
            var_8ec10611cdf1a599[ var_8ec10611cdf1a599.size ] = triggerer;
            triggerer thread function_b3fc04f734aa6113( memory_interact );
        }
        
        level notify( #"hash_b4b148e1238aeaaa" );
    }
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 1
// Checksum 0x435a5f3a, Offset: 0x4448
// Size: 0x46
function function_b3fc04f734aa6113( memory_interact )
{
    obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( memory_interact.origin, 24, [ self ] );
    utility::flag_wait( "flg_nmr_woods_memory_2_complete" );
    ob_story_mission_utils::objective_marker_clear( obj_id );
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 0
// Checksum 0xe5dc34ae, Offset: 0x4496
// Size: 0xa4
function function_2c911d126eaa3735()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    wait 5;
    level endon( #"hash_94d82f612b5647cc" );
    level utility::flag_wait( "flag_nm_tower_woods_memory_02_narration_complete" );
    activity_instance thread ob_story_mission_utils::objective_text_show( "ob_aries_grapple_hook_maze" );
    level utility::flag_wait( "flag_aries_nightmare_tower_water_level_90" );
    ob_story_mission_utils::objective_text_clear();
    activity_instance thread ob_story_mission_utils::objective_text_show( "ob_aries_destroy_flowers_defeat_enemies" );
    level utility::flag_wait( "flag_aries_nightmare_tower_water_raise_complete" );
    activity_instance thread function_afe5ba5b1eafbef7();
    activity_instance thread function_514ca68e52ad1577();
    level utility::flag_wait( "flag_trg_containertower_exit_obj" );
    ob_story_mission_utils::objective_text_clear();
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 0
// Checksum 0xaa17daaf, Offset: 0x4542
// Size: 0x164
function function_afe5ba5b1eafbef7()
{
    self endon( #"flag_nm_tower_weakpoints_set_a_complete" );
    self endon( #"flag_trg_containertower_exit_obj" );
    wait 20;
    
    if ( utility::flag( "flag_nm_tower_weakpoint_a_1_destroyed" ) )
    {
    }
    else
    {
        s_obj_destroy_weakpoint = utility::getstruct( "str_tower_weakpoint_a_1", "targetname" );
        obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( s_obj_destroy_weakpoint.origin );
        utility::flag_wait( "flag_nm_tower_weakpoint_a_1_destroyed" );
        ob_story_mission_utils::objective_marker_clear( obj_id );
        wait 10;
    }
    
    if ( utility::flag( "flag_nm_tower_weakpoint_a_4_destroyed" ) )
    {
    }
    else
    {
        s_obj_destroy_weakpoint = utility::getstruct( "str_tower_weakpoint_a_4", "targetname" );
        obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( s_obj_destroy_weakpoint.origin );
        utility::flag_wait( "flag_nm_tower_weakpoint_a_4_destroyed" );
        ob_story_mission_utils::objective_marker_clear( obj_id );
        wait 10;
    }
    
    if ( utility::flag( "flag_nm_tower_weakpoint_a_2_destroyed" ) )
    {
    }
    else
    {
        s_obj_destroy_weakpoint = utility::getstruct( "str_tower_weakpoint_a_2", "targetname" );
        obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( s_obj_destroy_weakpoint.origin );
        utility::flag_wait( "flag_nm_tower_weakpoint_a_2_destroyed" );
        ob_story_mission_utils::objective_marker_clear( obj_id );
        wait 10;
    }
    
    if ( utility::flag( "flag_nm_tower_weakpoint_a_3_destroyed" ) )
    {
        return;
    }
    
    s_obj_destroy_weakpoint = utility::getstruct( "str_tower_weakpoint_a_3", "targetname" );
    obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( s_obj_destroy_weakpoint.origin );
    utility::flag_wait( "flag_nm_tower_weakpoint_a_3_destroyed" );
    ob_story_mission_utils::objective_marker_clear( obj_id );
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 2
// Checksum 0x8462b1cd, Offset: 0x46ae
// Size: 0x95
function function_cf4273a0207d0faa( var_46f1327fcd04fb1e, t_light )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"flag_nm_tower_weakpoints_set_a_complete" );
    utility::flag_wait( var_46f1327fcd04fb1e );
    e_light = getent( t_light, #targetname );
    
    if ( isdefined( e_light ) )
    {
        lighting::lerp_spot_intensity( t_light, 0, 0 );
        e_light.lumens = 0;
        e_light.script_intensity = 0;
        e_light.script_intensity2 = 0;
    }
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 0
// Checksum 0x1c47d8ce, Offset: 0x474b
// Size: 0x78
function function_514ca68e52ad1577()
{
    self endon( #"flag_aries_nightmare_tower_complete" );
    utility::flag_wait( "flag_nm_tower_weakpoints_set_a_complete" );
    wait 10;
    
    if ( !utility::flag( "flag_trg_containertower_exit_obj" ) )
    {
        var_972c4cbb03f0cdbb = utility::getstruct( "struct_container_tower_exit_waypoint", "targetname" );
        obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( var_972c4cbb03f0cdbb.origin );
        utility::flag_wait( "flag_trg_containertower_exit_obj" );
        ob_story_mission_utils::objective_marker_clear( obj_id );
    }
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 0
// Checksum 0x79672468, Offset: 0x47cb
// Size: 0xb5
function function_b618744feb35d17e()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance thread ob_story_mission_utils::objective_text_show( "ob_aries_reveal_woods_memory" );
    var_71498d35c1280e28 = utility::getstruct( "struct_memory_waypoint_2", "targetname" );
    
    if ( isdefined( var_71498d35c1280e28 ) )
    {
        obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( var_71498d35c1280e28.origin );
    }
    else
    {
        var_71498d35c1280e28 = utility::getstruct( "str_memory_interact_crashsite", "script_noteworthy" );
        obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( var_71498d35c1280e28.origin, 48 );
    }
    
    level utility::flag_wait( "flag_aries_nightmare_narr_tower_b_started" );
    ob_story_mission_utils::objective_marker_clear( obj_id );
    ob_story_mission_utils::objective_text_clear();
}

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 0
// Checksum 0xe14c4972, Offset: 0x4888
// Size: 0x76
function function_abdaee24f5ee315d()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    trig_on_barge = getent( "trig_on_barge", #targetname );
    wait 0.3;
    
    if ( self istouching( trig_on_barge ) )
    {
        earthquake( 0.4, 1.75, self.origin, 256 );
        playrumbleonposition( "artillery_rumble_light", self.origin );
    }
}

/#

    // Namespace mp_sat_ob_aries_activity_nightmare_containertower
    // Params 0
    // Checksum 0xd989bfc3, Offset: 0x4906
    // Size: 0x5, Type: dev
    function function_4ffa1d14a0e4f53d()
    {
        
    }

#/

// Namespace mp_sat_ob_aries_activity_nightmare_containertower
// Params 0
// Checksum 0x8bb0756f, Offset: 0x4913
// Size: 0x9c
function function_d1ced418a6768db5()
{
    activity_instance = self;
    activity_instance thread ob_story_mission_utils::function_e6799e9a19df2365( "str_tower_weapon_cache_a", %"hash_43f0ec9b2eb8b67f", 2 );
    activity_instance thread ob_story_mission_utils::function_e6799e9a19df2365( "str_tower_weapon_cache_b", %"hash_43f0ee9b2eb8b9e5", 2 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "str_maze_lethal", "flag_aries_nightmare_tower_catchup_complete", 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "str_maze_tactical", "flag_aries_nightmare_tower_catchup_complete", 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "str_maze_weapon", "flag_aries_nightmare_tower_catchup_complete", 1 );
    wait 2;
    activity_instance thread aries_util::waterfall_handler( "vfx_maze_transition_waterfall", "trig_bp_vfx_damage_tower_lvl0_a2", undefined, "flag_aries_nightmare_tower_catchup_complete" );
}

