// scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_activity_river_waterfall.gsc  (hash_77e5fd6d42701ec1.gscc) (size: 9935 Bytes / 0x26cf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe3d06401 (3822085121)
// size ...... 9935 (0x26cf)
// includes .. 12  (offset: 0x23df)
// strings ... 45  (offset: 0x243f)
// dev strs .. 0   (offset: 0x26cf)
// exports ... 28  (offset: 0x15f7)
// cseg ...... 0x601 + 0xff6 (0x15f7)
// imports ... 79  (offset: 0x1a57)
// animtree1 . 0   (offset: 0x26cf)
// animtree2 . 0   (offset: 0x26cf)
#using script_16555c1140262e45;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_util;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_vo;

#namespace mp_sat_ob_aries_activity_river_waterfall;

// Namespace mp_sat_ob_aries_activity_river_waterfall
// Params 0, eflags: 0x5
// Checksum 0xa0aba80, Offset: 0x61f
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_9e901d9e62750254", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace mp_sat_ob_aries_activity_river_waterfall
// Params 0, eflags: 0x4
// Checksum 0x5a9820ab, Offset: 0x648
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_ARIES_RIVER_WATERFALL";
    activity_common::registeractivitytype( "OB_ARIES_RIVER_WATERFALL", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_RIVER_WATERFALL", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_RIVER_WATERFALL", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_RIVER_WATERFALL", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_ARIES_RIVER_WATERFALL" );
}

// Namespace mp_sat_ob_aries_activity_river_waterfall
// Params 0
// Checksum 0x8c0f3e50, Offset: 0x6bf
// Size: 0x59
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance function_2a9a4022504f1d6();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace mp_sat_ob_aries_activity_river_waterfall
// Params 0
// Checksum 0x31c235ac, Offset: 0x720
// Size: 0x39
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance function_68654dbcf35f95bf();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace mp_sat_ob_aries_activity_river_waterfall
// Params 0
// Checksum 0x14fbac46, Offset: 0x761
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace mp_sat_ob_aries_activity_river_waterfall
// Params 1
// Checksum 0xa76fe9a1, Offset: 0x785
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread function_1d7a45d4985d499d( player );
    }
}

// Namespace mp_sat_ob_aries_activity_river_waterfall
// Params 0
// Checksum 0xc886b68e, Offset: 0x841
// Size: 0x75
function function_2a9a4022504f1d6()
{
    activity_instance = self;
    ob_story_mission_utils::function_6314f03dfe2adbc5();
    aries_util::function_ff8302797d7d1756();
    level function_872f467682ac59a0();
    activity_instance thread function_e9dab9bdf043397d( 1 );
    level utility::flag_set( "river_jungle_vtol_liftoff_scene" );
    level utility::flag_set( "flag_trg_encounter_1_area_entered" );
    level utility::flag_set( "flag_waterfall_vo_entered" );
    level utility::flag_set( "flag_jungle_trg_grapple_first_cliffs" );
    activity_instance thread function_66e2b6b02ac05427();
    level thread aries_vo::function_3c47ce81d1dde6e9();
}

// Namespace mp_sat_ob_aries_activity_river_waterfall
// Params 0
// Checksum 0x5322907e, Offset: 0x8be
// Size: 0x14c
function function_68654dbcf35f95bf()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    waitframe();
    
    foreach ( player in level.players )
    {
        player notify( #"hash_c280c79b99811a3e" );
        remove_wpn = player aries_util::function_862a02480e506c14();
        
        if ( isdefined( remove_wpn ) )
        {
            player takeweapon( remove_wpn );
        }
        
        player thread function_6edec2ede14e1e0c();
    }
    
    level.var_5fe1c01595a2e32b = [ "ent_flag_jungle_clear_wp_1" ];
    level callback::add( #"player_spawned", &aries_util::function_d77f848569c2ad76 );
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_river_waterfall_weapon", "flag_river_trail_ambush", 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_river_waterfall_equipment", "flag_river_trail_ambush", 1 );
    activity_instance thread ob_story_mission_utils::function_e6799e9a19df2365( "s_river_waterfall_cache", %"hash_43f0ed9b2eb8b832", 2 );
    activity_instance thread function_bd9587f20bea4e98();
    level utility::flag_wait( "flag_end_objective_secure_area_1_jungle" );
}

// Namespace mp_sat_ob_aries_activity_river_waterfall
// Params 1
// Checksum 0x356e3be, Offset: 0xa12
// Size: 0x4d
function function_1d7a45d4985d499d( player )
{
    activity_instance = self;
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        player ob_story_mission_utils::function_2383fc8bfc3074d2();
        player ob_story_mission_utils::function_288fdad79fa2a11();
    }
    
    activity_instance thread function_3f9675ef4278bd68( player );
}

// Namespace mp_sat_ob_aries_activity_river_waterfall
// Params 0
// Checksum 0xc1a878ca, Offset: 0xa67
// Size: 0x38
function function_6edec2ede14e1e0c()
{
    level utility::flag_wait( "flag_waterfall_vo_entered" );
    function_fde859de4858f491( [ self ], "hint_war_machine", &"sat_ob/hint_use_war_machine_gamepad", &"sat_ob/hint_use_war_machine_kbm", 3 );
}

// Namespace mp_sat_ob_aries_activity_river_waterfall
// Params 5
// Checksum 0xfd6d2c0b, Offset: 0xaa7
// Size: 0x113
function function_fde859de4858f491( players, toast_hint = "hint_wingsuit_deploy", toast_text = &"sat_ob/bigmap_avalon", var_d0f27fc78fd36d9a, delay = 0 )
{
    wait delay;
    
    foreach ( player in players )
    {
        if ( var_d0f27fc78fd36d9a && !player usinggamepad() )
        {
            player utility::callsharedfunc( #"hint", #"add_simple", toast_hint, var_d0f27fc78fd36d9a, 10 );
            continue;
        }
        
        player utility::callsharedfunc( #"hint", #"add_simple", toast_hint, toast_text, 10 );
    }
}

// Namespace mp_sat_ob_aries_activity_river_waterfall
// Params 0
// Checksum 0x1fbe5768, Offset: 0xbc2
// Size: 0x13
function function_872f467682ac59a0()
{
    aries_util::function_619b5a0410cf1a0a( "e_river_trail_vtol", "hide" );
}

// Namespace mp_sat_ob_aries_activity_river_waterfall
// Params 1
// Checksum 0xc5b02429, Offset: 0xbdd
// Size: 0xb7
function function_e9dab9bdf043397d( b_immediate = 0 )
{
    activity_instance = self;
    
    if ( !b_immediate )
    {
        tr_jungle_river_vtol_1_takeoff = getent( "tr_jungle_river_vtol_1_takeoff", #targetname );
    }
    
    activity_instance thread ob_story_mission_utils::function_273dfd9583646854( "river_waterfall_vtol", tr_jungle_river_vtol_1_takeoff, 1, undefined, 40, 400, 0, undefined, undefined, 1, undefined, undefined, undefined, 1 );
    
    if ( !b_immediate )
    {
        tr_jungle_river_vtol_1_takeoff waittill( #"trigger" );
    }
    
    var_fbed8b44dc606192 = utility::getstruct( "river_waterfall_vtol", "targetname" );
    level thread function_2aa74b92f2a937d6( var_fbed8b44dc606192 );
    level utility::flag_set( "river_jungle_vtol_liftoff_scene" );
    
    if ( isdefined( tr_jungle_river_vtol_1_takeoff ) )
    {
        tr_jungle_river_vtol_1_takeoff delete();
    }
}

// Namespace mp_sat_ob_aries_activity_river_waterfall
// Params 1
// Checksum 0xe1ead3fe, Offset: 0xc9c
// Size: 0x71
function function_2aa74b92f2a937d6( e_vtol )
{
    level._effect[ "vtol_dustoff" ] = loadfxasset( "vfx_iw9_vehicle_script_shared_heli_dust_lrg_high_water" );
    vtol_dustoff_fx = spawnfx( level._effect[ "vtol_dustoff" ], e_vtol.origin - ( 0, 0, 50 ) );
    triggerfx( vtol_dustoff_fx );
    wait 3;
    vtol_dustoff_fx delete();
}

/#

    // Namespace mp_sat_ob_aries_activity_river_waterfall
    // Params 0
    // Checksum 0x16811cf3, Offset: 0xd15
    // Size: 0x5, Type: dev
    function function_780e02a04ec694e6()
    {
        
    }

#/

// Namespace mp_sat_ob_aries_activity_river_waterfall
// Params 0
// Checksum 0xc3af3e86, Offset: 0xd22
// Size: 0x85
function function_66e2b6b02ac05427()
{
    activity_instance = self;
    level utility::flag_wait( "flag_jungle_trg_grapple_first_cliffs" );
    level utility::flag_set( "flag_jungle_encounter_1_start" );
    level.var_1346376b067787f6 = [];
    level.var_56333b2e456d9f = [];
    activity_instance thread waterfall_spawn_soldiers();
    activity_instance thread function_d8f094b94440cb90();
    activity_instance thread function_7d08126421c83e36();
    
    while ( level.var_1346376b067787f6.size <= 2 )
    {
        wait 0.5;
    }
    
    activity_instance thread function_29a28b0931f86d9a( 6, 3 );
    function_9f88990869b4976e();
}

// Namespace mp_sat_ob_aries_activity_river_waterfall
// Params 0
// Checksum 0x73317854, Offset: 0xdaf
// Size: 0x82
function waterfall_spawn_soldiers()
{
    activity_instance = self;
    var_92bb3dca33e3f5a1 = "enc_jungle_dawg_soldiers";
    var_458d3fd67675b73c = ai_spawn_director::lookup_spawn_request( var_92bb3dca33e3f5a1 );
    function_ef57f478f96b050c( var_458d3fd67675b73c, 1 );
    function_64ac8c4e752f4dca( var_458d3fd67675b73c, 0 );
    ai_spawn_director::add_callback( "OnSpawned", var_458d3fd67675b73c, &function_34a4923ed053df29 );
    level utility::flag_wait( "flag_river_minefield_progress_01" );
    function_64ac8c4e752f4dca( var_458d3fd67675b73c, 1 );
    level utility::flag_wait( "player_catchup_river_barge_complete" );
    ai_spawn_director::cancel_spawn_request( var_458d3fd67675b73c, 0, 0 );
}

// Namespace mp_sat_ob_aries_activity_river_waterfall
// Params 4
// Checksum 0x1b40546c, Offset: 0xe39
// Size: 0x12d
function function_34a4923ed053df29( requestid, activity_instance, agent, data )
{
    activity_instance = self;
    agent endon( #"death" );
    
    if ( !isdefined( level.var_1346376b067787f6 ) )
    {
        level.var_1346376b067787f6 = [];
    }
    
    level.var_1346376b067787f6 = arraycombineunique( level.var_1346376b067787f6, [ agent ] );
    
    if ( !isdefined( level.var_56333b2e456d9f ) )
    {
        level.var_56333b2e456d9f = [];
    }
    
    if ( !( agent.agent_type == "actor_sat_ob_enemy_basic_grunt_sniper" || agent.agent_type == "actor_sat_ob_enemy_basic_grunt_sniper" ) && level.var_56333b2e456d9f.size <= 6 )
    {
        level.var_56333b2e456d9f = arraycombineunique( level.var_56333b2e456d9f, [ agent ] );
    }
    
    level utility::flag_wait( "flag_jungle_clearing_ground_enemies_fallback" );
    var_f6c65a642af1ec59 = "vol_river_jungle_enemies_fallback";
    a_vol_fallback = getnoentvolumearray( var_f6c65a642af1ec59, #targetname );
    agent setgoalpos( agent.origin, 16 );
    agent setgoalvolumeauto( a_vol_fallback[ 0 ] );
}

// Namespace mp_sat_ob_aries_activity_river_waterfall
// Params 0
// Checksum 0x2bdfa977, Offset: 0xf6e
// Size: 0x1d2
function function_9f88990869b4976e()
{
    level endon( #"flag_jungle_clearing_ridge_enemies_spawn" );
    level endon( #"flag_jungle_clearing_ground_enemies_fallback" );
    var_5fa3ddfe2eb628fa = level utility::flag_wait_any_return( "flag_waterfall_corridor_entered_left", "flag_waterfall_corridor_entered_right" );
    
    if ( var_5fa3ddfe2eb628fa == "flag_waterfall_corridor_entered_left" )
    {
        var_346fffd51590e9c = getnoentvolumearray( "vol_river_jungle_enemies_left_entrance", #targetname );
    }
    else
    {
        var_346fffd51590e9c = getnoentvolumearray( "vol_river_jungle_enemies_right_entrance", #targetname );
    }
    
    vol_push = var_346fffd51590e9c[ 0 ];
    
    foreach ( enemy in level.var_56333b2e456d9f )
    {
        if ( isalive( enemy ) )
        {
            enemy setgoalpos( enemy.origin );
            enemy setgoalvolumeauto( vol_push );
        }
    }
    
    level utility::flag_wait( "flag_trg_encounter_1_area_entered" );
    [ vol_return ] = getnoentvolumearray( "vol_river_jungle_enemies_main", #targetname );
    
    foreach ( enemy in level.var_56333b2e456d9f )
    {
        if ( isalive( enemy ) )
        {
            enemy setgoalpos( enemy.origin );
            enemy setgoalvolumeauto( vol_return );
        }
    }
}

// Namespace mp_sat_ob_aries_activity_river_waterfall
// Params 0
// Checksum 0x6f918281, Offset: 0x1148
// Size: 0x82
function function_d8f094b94440cb90()
{
    level utility::flag_wait( "flag_jungle_clearing_ground_enemies_fallback" );
    activity_instance = self;
    var_92bb3dca33e3f5a1 = "enc_jungle_dawg";
    var_458d3fd67675b73c = ai_spawn_director::lookup_spawn_request( var_92bb3dca33e3f5a1 );
    function_ef57f478f96b050c( var_458d3fd67675b73c, 1 );
    function_64ac8c4e752f4dca( var_458d3fd67675b73c, 0 );
    ai_spawn_director::add_callback( "OnSpawned", var_458d3fd67675b73c, &function_83aed2def88c8db8 );
    level utility::flag_wait( "flag_river_minefield_progress_01" );
    function_64ac8c4e752f4dca( var_458d3fd67675b73c, 1 );
    ai_spawn_director::cancel_spawn_request( var_458d3fd67675b73c, 0, 0 );
}

// Namespace mp_sat_ob_aries_activity_river_waterfall
// Params 4
// Checksum 0xd08ac2bd, Offset: 0x11d2
// Size: 0x9f
function function_83aed2def88c8db8( requestid, activity_instance, agent, data )
{
    activity_instance = self;
    agent endon( #"death" );
    
    if ( !isdefined( level.var_1346376b067787f6 ) )
    {
        level.var_1346376b067787f6 = [];
    }
    
    level.var_1346376b067787f6 = arraycombineunique( level.var_1346376b067787f6, [ agent ] );
    agent dawg_turret::dawg_turret_set_owner( agent );
    wait 1;
    var_be09b63d47712825 = getnoentvolumearray( "vol_river_jungle_enemies_main", #targetname );
    agent setgoalvolumeauto( var_be09b63d47712825[ 0 ] );
}

// Namespace mp_sat_ob_aries_activity_river_waterfall
// Params 0
// Checksum 0xa0905c68, Offset: 0x1279
// Size: 0x89
function function_7d08126421c83e36()
{
    activity_instance = self;
    level utility::flag_wait( "flag_jungle_clearing_ridge_enemies_spawn" );
    var_92bb3dca33e3f5a1 = "enc_jungle_dawg_soldiers_ridge";
    var_458d3fd67675b73c = activity_instance activity_ai_encounters::function_92b671064b0b1ce2( var_92bb3dca33e3f5a1, 1, 1, 1, 2 );
    function_ef57f478f96b050c( var_458d3fd67675b73c, 1 );
    function_64ac8c4e752f4dca( var_458d3fd67675b73c, 0 );
    activity_instance activity_ai_encounters::function_52d1342183200a8f( var_458d3fd67675b73c, &function_dc2e6efc01171671, activity_instance );
    level utility::flag_wait( "flag_river_minefield_progress_01" );
    function_64ac8c4e752f4dca( var_458d3fd67675b73c, 1 );
    ai_spawn_director::cancel_spawn_request( var_458d3fd67675b73c, 0, 0 );
}

// Namespace mp_sat_ob_aries_activity_river_waterfall
// Params 4
// Checksum 0xa12755eb, Offset: 0x130a
// Size: 0x44
function function_dc2e6efc01171671( requestid, activity_instance, agent, data )
{
    level.var_1346376b067787f6 = arraycombineunique( level.var_1346376b067787f6, [ agent ] );
}

// Namespace mp_sat_ob_aries_activity_river_waterfall
// Params 2
// Checksum 0xd53b9c24, Offset: 0x1356
// Size: 0x182
function function_29a28b0931f86d9a( var_89a1e7515dbb3de6, var_1c8dd9d6e651dccd )
{
    level endon( #"flag_river_minefield_progress_01" );
    
    while ( level.var_1346376b067787f6.size > var_89a1e7515dbb3de6 )
    {
        level.var_1346376b067787f6 = utility::array_removedead_or_dying( level.var_1346376b067787f6, 1 );
        wait 0.5;
    }
    
    level utility::flag_set( "flag_jungle_clearing_dawgs_spawn" );
    
    while ( level.var_1346376b067787f6.size > var_1c8dd9d6e651dccd )
    {
        level.var_1346376b067787f6 = utility::array_removedead_or_dying( level.var_1346376b067787f6, 1 );
        wait 0.5;
    }
    
    level utility::flag_set( "flag_jungle_clearing_ridge_enemies_spawn" );
    level utility::flag_set( "flag_jungle_clearing_ground_enemies_fallback" );
    
    while ( level.var_1346376b067787f6.size > 0 )
    {
        level.var_1346376b067787f6 = utility::array_removedead_or_dying( level.var_1346376b067787f6, 1 );
        wait 0.5;
    }
    
    level utility::flag_set( "flg_jungle_clearing_soldiers_killed" );
    
    foreach ( player in level.players )
    {
        player utility::ent_flag_set( "flg_jungle_clearing_soldiers_killed" );
    }
    
    if ( isdefined( level.var_1346376b067787f6 ) )
    {
        level.var_1346376b067787f6 = undefined;
    }
}

/#

    // Namespace mp_sat_ob_aries_activity_river_waterfall
    // Params 0
    // Checksum 0xa752e124, Offset: 0x14e0
    // Size: 0x5, Type: dev
    function function_7cd81705b5b3efb7()
    {
        
    }

#/

// Namespace mp_sat_ob_aries_activity_river_waterfall
// Params 0
// Checksum 0xad31c2ec, Offset: 0x14ed
// Size: 0x63
function function_bd9587f20bea4e98()
{
    activity_instance = self;
    level utility::flag_set( "dawg_objective_start" );
    ob_story_mission_utils::objective_text_show( "ob_aries_fight_through_jungle" );
    level utility::flag_wait_any( "flg_jungle_clearing_soldiers_killed", "flag_end_objective_secure_area_1_jungle" );
    ob_story_mission_utils::objective_text_clear();
    activity_instance thread ob_story_mission_utils::objective_text_show( "ob_aries_look_for_woods_jungle" );
    level utility::flag_wait( "flag_end_objective_secure_area_1_jungle" );
    ob_story_mission_utils::objective_text_clear();
}

// Namespace mp_sat_ob_aries_activity_river_waterfall
// Params 1
// Checksum 0x9628e345, Offset: 0x1558
// Size: 0x9f
function function_3f9675ef4278bd68( player )
{
    activity_instance = self;
    player endon( #"ent_flag_end_objective_secure_area_1_jungle", #"death_or_disconnect" );
    msg = player utility::function_e2baa5896d5756cc( [ "flg_jungle_clearing_soldiers_killed", "ent_flag_end_objective_secure_area_1_jungle" ] );
    
    if ( msg == "flg_jungle_clearing_soldiers_killed" )
    {
        obj_s = utility::getstruct( "s_jungle_river_arena_obj_wp_2", "targetname" );
        activity_instance thread aries_util::function_e6895f5efd1feb56( player, obj_s.origin, undefined, "sat_ob_objectivemarker_storymissionmain", player, "ent_flag_end_objective_secure_area_1_jungle", undefined, 2500 );
    }
}

