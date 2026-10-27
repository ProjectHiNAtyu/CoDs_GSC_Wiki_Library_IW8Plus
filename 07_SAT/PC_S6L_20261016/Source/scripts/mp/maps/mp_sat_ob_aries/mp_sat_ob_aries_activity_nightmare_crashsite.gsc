// scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_activity_nightmare_crashsite.gsc  (hash_452cf28d9ce754dc.gscc) (size: 5771 Bytes / 0x168b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x39a2ba20 (966965792)
// size ...... 5771 (0x168b)
// includes .. 12  (offset: 0x1457)
// strings ... 34  (offset: 0x14b7)
// dev strs .. 0   (offset: 0x168b)
// exports ... 17  (offset: 0xc2b)
// cseg ...... 0x44e + 0x7dd (0xc2b)
// imports ... 47  (offset: 0xed3)
// animtree1 . 0   (offset: 0x168b)
// animtree2 . 0   (offset: 0x168b)
#using script_16d8789bae43669e;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\interaction;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_audio;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_util;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_vo;
#using scripts\mp\objidpoolmanager;

#namespace namespace_7e7fab28a20f0d4a;

// Namespace namespace_7e7fab28a20f0d4a
// Params 0, eflags: 0x5
// Checksum 0x397ab4bd, Offset: 0x46c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_1846716f4835ae21", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_7e7fab28a20f0d4a
// Params 0, eflags: 0x4
// Checksum 0xb5621506, Offset: 0x495
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_ARIES_NIGHTMARE_CRASHSITE";
    activity_common::registeractivitytype( "OB_ARIES_NIGHTMARE_CRASHSITE", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_NIGHTMARE_CRASHSITE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_NIGHTMARE_CRASHSITE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_NIGHTMARE_CRASHSITE", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_ARIES_NIGHTMARE_CRASHSITE" );
}

// Namespace namespace_7e7fab28a20f0d4a
// Params 0
// Checksum 0xfbe37210, Offset: 0x50c
// Size: 0x59
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance function_8c03d0ea81c292a3();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_7e7fab28a20f0d4a
// Params 0
// Checksum 0x9f1a7873, Offset: 0x56d
// Size: 0x39
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance function_1998df23778b9a34();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_7e7fab28a20f0d4a
// Params 0
// Checksum 0xfb0199eb, Offset: 0x5ae
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_7e7fab28a20f0d4a
// Params 1
// Checksum 0x36026d14, Offset: 0x5d2
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread function_c1eb561db46d6f9a( player );
    }
}

// Namespace namespace_7e7fab28a20f0d4a
// Params 0
// Checksum 0xaae703b, Offset: 0x68e
// Size: 0x17
function function_8c03d0ea81c292a3()
{
    activity_instance = self;
    level thread aries_util::bloodpool_player_setup();
}

// Namespace namespace_7e7fab28a20f0d4a
// Params 0
// Checksum 0x975e29a1, Offset: 0x6ad
// Size: 0x20d
function function_1998df23778b9a34()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "str_crashsite_weapon" );
    activity_instance thread ob_story_mission_utils::function_e6799e9a19df2365( "str_crashsite_weapon_cache_a", %"hash_43f0ed9b2eb8b832", 2 );
    activity_instance thread ob_story_mission_utils::function_e6799e9a19df2365( "str_crashsite_weapon_cache_b", %"hash_43f0ed9b2eb8b832", 2 );
    activity_instance thread ob_story_mission_utils::function_e6799e9a19df2365( "str_crashsite_weapon_cache_c", %"hash_43f0ed9b2eb8b832", 2 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "str_equipment_crashsite", undefined, 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "str_crashsite_lethal", "flag_aries_nightmare_crashsite_complete", 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "str_crashsite_tactical", "flag_aries_nightmare_crashsite_complete", 1 );
    backtrack_collision = getent( "sbm_crashsite_backtrack_collision", #targetname );
    backtrack_collision notsolid();
    activity_instance thread function_65f5f7164d453d4b();
    activity_instance thread aries_util::bloodpool_handler( "trig_bp_damage_crashsite_a", "flag_aries_nightmare_tower_complete" );
    activity_instance thread aries_util::bloodpool_handler( "trig_bp_damage_crashsite_b", "flag_aries_nightmare_tower_complete" );
    activity_instance thread aries_util::bloodpool_handler( "trig_bp_damage_crashsite_c", "flag_aries_nightmare_tower_complete" );
    level thread aries_vo::function_c3bb957cf92cb470();
    activity_instance thread namespace_1f3f9eb1e9681da5::function_9dbeaf9ca833864( activity_instance, "player_catchup_tower_crashsite", "flag_aries_nightmare_crashsite_catchup_complete", 3 );
    utility::flag_wait( "flag_aries_nightmare_crashsite_catchup_complete" );
    activity_instance thread function_1cd624651247cd7e( "flag_aries_nightmare_crashsite_complete" );
    backtrack_collision solid();
    activity_instance thread function_5faaf807fde3a8a4();
    utility::flag_wait( "flag_aries_crashsite_player_rush_50" );
    utility::flag_wait( "flag_aries_crashsite_player_rush_100" );
    s_nmr_woods_prefight_interact_ref = utility::getstruct( "s_nmr_woods_prefight_interact_ref", "targetname" );
    interact = interaction::register_interact( s_nmr_woods_prefight_interact_ref.origin, 64, &interaction_handler, &"sat_ob_story_missions_aries/interact_woods_prefight", undefined, undefined, undefined, "HINT_BUTTON" );
    interact setuseholdduration( "duration_medium" );
    interact waittill( #"trigger", player );
    interact delete();
    level.teleport_initiator = player;
    utility::flag_set( "flag_aries_nightmare_crashsite_complete" );
}

// Namespace namespace_7e7fab28a20f0d4a
// Params 1
// Checksum 0xfc2cd26b, Offset: 0x8c2
// Size: 0x43
function function_c1eb561db46d6f9a( player )
{
    activity_instance = self;
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        player ob_story_mission_utils::function_2383fc8bfc3074d2();
        player ob_story_mission_utils::function_288fdad79fa2a11();
    }
}

/#

    // Namespace namespace_7e7fab28a20f0d4a
    // Params 0
    // Checksum 0x5b216373, Offset: 0x90d
    // Size: 0x5, Type: dev
    function function_844ebe51b76e8d10()
    {
        
    }

#/

// Namespace namespace_7e7fab28a20f0d4a
// Params 1
// Checksum 0x7ed3cae4, Offset: 0x91a
// Size: 0x17b
function function_1cd624651247cd7e( cleanup_flag )
{
    var_50df729348a66213 = [];
    var_efcdd51e22f65eef = getent( "sm_ct_fake_wall_a_p4", #targetname );
    var_50df729348a66213[ var_50df729348a66213.size ] = var_efcdd51e22f65eef;
    var_efcdd01e22f653f0 = getent( "sm_ct_fake_wall_a_p1", #targetname );
    var_50df729348a66213[ var_50df729348a66213.size ] = var_efcdd01e22f653f0;
    var_efcdd41e22f65cbc = getent( "sm_ct_fake_wall_a_p5", #targetname );
    var_50df729348a66213[ var_50df729348a66213.size ] = var_efcdd41e22f65cbc;
    var_efcdd31e22f65a89 = getent( "sm_ct_fake_wall_a_p2", #targetname );
    var_50df729348a66213[ var_50df729348a66213.size ] = var_efcdd31e22f65a89;
    var_efcdd71e22f66355 = getent( "sm_ct_fake_wall_a_p6", #targetname );
    var_50df729348a66213[ var_50df729348a66213.size ] = var_efcdd71e22f66355;
    var_efcdd21e22f65856 = getent( "sm_ct_fake_wall_a_p3", #targetname );
    var_50df729348a66213[ var_50df729348a66213.size ] = var_efcdd21e22f65856;
    level thread aries_audio::function_29eb5c1d2739622a();
    aries_util::function_2ad4d6454b67c8a8( var_50df729348a66213, 0.5 );
    utility::flag_wait( cleanup_flag );
    
    foreach ( ent in var_50df729348a66213 )
    {
        ent delete();
    }
    
    var_50df729348a66213 = undefined;
}

// Namespace namespace_7e7fab28a20f0d4a
// Params 1
// Checksum 0xc9c755fa, Offset: 0xa9d
// Size: 0xc
function interaction_handler( player )
{
    
}

/#

    // Namespace namespace_7e7fab28a20f0d4a
    // Params 0
    // Checksum 0x71fa6059, Offset: 0xab1
    // Size: 0x5, Type: dev
    function function_b07a6dcc2a3adaec()
    {
        
    }

#/

// Namespace namespace_7e7fab28a20f0d4a
// Params 0
// Checksum 0x9bc665c2, Offset: 0xabe
// Size: 0xa4
function function_5faaf807fde3a8a4()
{
    level endon( #"level_end" );
    var_f0bfa7ab1171ab3 = getnoentvolumearray( "trig_crashsite_progress_50", #targetname );
    
    if ( isdefined( var_f0bfa7ab1171ab3[ 0 ] ) )
    {
        var_f0bfa7ab1171ab3[ 0 ] waittill( #"trigger", player );
    }
    else
    {
        wait 10;
    }
    
    utility::flag_set( "flag_aries_crashsite_player_rush_50" );
    var_687c8ad3a05bcb85 = getnoentvolumearray( "trig_crashsite_progress_100", #targetname );
    
    if ( isdefined( var_687c8ad3a05bcb85[ 0 ] ) )
    {
        var_687c8ad3a05bcb85[ 0 ] waittill( #"trigger", player );
    }
    else
    {
        wait 10;
    }
    
    utility::flag_set( "flag_aries_crashsite_player_rush_100" );
}

/#

    // Namespace namespace_7e7fab28a20f0d4a
    // Params 0
    // Checksum 0xa7fa6268, Offset: 0xb6a
    // Size: 0x5, Type: dev
    function function_fa5c65e046ce02e2()
    {
        
    }

#/

// Namespace namespace_7e7fab28a20f0d4a
// Params 0
// Checksum 0xc953e0af, Offset: 0xb77
// Size: 0xb4
function function_65f5f7164d453d4b()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"ob_aries_nightmare_river" );
    activity_instance thread ob_story_mission_utils::objective_text_show( "ob_aries_defeat_enemies_nightmare" );
    var_f316e30df648f9ad = utility::getstruct( "str_wp_final_container", "targetname" );
    obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( var_f316e30df648f9ad.origin, 250 );
    utility::flag_wait( "flag_aries_crashsite_player_rush_50" );
    obj_id = objidpoolmanager::update_objective_position( obj_id, var_f316e30df648f9ad.origin );
    level utility::flag_wait( "flag_trg_final_woods_container_approached" );
    ob_story_mission_utils::objective_text_clear();
    ob_story_mission_utils::objective_marker_clear( obj_id );
}

