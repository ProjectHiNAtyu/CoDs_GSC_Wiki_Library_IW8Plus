// scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_activity_tunnels_anteroom.gsc  (hash_4db394dc166c12ad.gscc) (size: 22214 Bytes / 0x56c6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcdf118c9 (3455129801)
// size ...... 22214 (0x56c6)
// includes .. 21  (offset: 0x4f8a)
// strings ... 95  (offset: 0x5032)
// dev strs .. 6   (offset: 0x567e)
// exports ... 51  (offset: 0x307e)
// cseg ...... 0xc43 + 0x243b (0x307e)
// imports ... 189 (offset: 0x3876)
// animtree1 . 0   (offset: 0x56c6)
// animtree2 . 0   (offset: 0x56c6)
#using script_16d8789bae43669e;
#using script_2399696a9d953451;
#using script_2cd07641bf71242a;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\callbacks;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_audio;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_util;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_vo;
#using scripts\mp\ob\contracts\ob_contract_ui_widget;

#namespace namespace_4da92177d5600dd;

/#

    // Namespace namespace_4da92177d5600dd
    // Params 0
    // Checksum 0xb96f0f83, Offset: 0xc61
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_4da92177d5600dd
// Params 0, eflags: 0x5
// Checksum 0x23708163, Offset: 0xc6e
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_5719282163255087", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_4da92177d5600dd
// Params 0, eflags: 0x4
// Checksum 0x6a3b1891, Offset: 0xc97
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_GEMINI_TUNNELS_ANTEROOM";
    activity_common::registeractivitytype( "OB_GEMINI_TUNNELS_ANTEROOM", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_TUNNELS_ANTEROOM", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_TUNNELS_ANTEROOM", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_TUNNELS_ANTEROOM", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_GEMINI_TUNNELS_ANTEROOM" );
}

// Namespace namespace_4da92177d5600dd
// Params 0
// Checksum 0x99bc303d, Offset: 0xd0e
// Size: 0x59
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance tunnels_anteroom_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_4da92177d5600dd
// Params 0
// Checksum 0x581ad6f9, Offset: 0xd6f
// Size: 0x39
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance tunnels_anteroom_main();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_4da92177d5600dd
// Params 0
// Checksum 0x2458947c, Offset: 0xdb0
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_4da92177d5600dd
// Params 1
// Checksum 0x6e15219, Offset: 0xdd4
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread tunnels_anteroom_player_setup( player );
    }
}

/#

    // Namespace namespace_4da92177d5600dd
    // Params 0
    // Checksum 0xfed5ab93, Offset: 0xe90
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_4da92177d5600dd
// Params 0
// Checksum 0xe6d6cffd, Offset: 0xe9d
// Size: 0x62
function tunnels_anteroom_start()
{
    activity_instance = self;
    ob_story_mission_utils::function_6314f03dfe2adbc5();
    activity_instance thread ob_story_mission_utils::objective_marker_clear_all();
    level thread gemini_util::function_85abe3355f8a3cce();
    gemini_util::function_34a3d0cff5de2d7d();
    gemini_util::function_dfcbf5f9b3b2e6a0();
    activity_instance thread gemini_util::function_b04c2801b2760aff( "s_tunnels_anteroom_mason_ghost_01", "flag_tunnels_anteroom_complete" );
    level utility::flag_set( "flag_tunnels_anteroom_located_vo_complete" );
    level utility::flag_set( "flag_tunnels_anteroom_regroup_complete" );
}

// Namespace namespace_4da92177d5600dd
// Params 1
// Checksum 0xa220fd64, Offset: 0xf07
// Size: 0xc3
function tunnels_anteroom_player_setup( player )
{
    activity_instance = self;
    player sethidenameplate( 0 );
    activity_instance thread function_7dbbe7e03e4ea826( player );
    
    if ( player.is_disoriented )
    {
        player gemini_util::function_16357e04a0cbe73d();
    }
    
    player val::set( "solitary_intro", "sprint", 1 );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        player thread gemini_util::function_22bc129d80ed2fc7( 2 );
        player thread gemini_util::player_cold_breath_toggle( "flag_tunnels_pit_complete" );
        
        if ( !isdefined( level.var_d552cd536f03e258 ) )
        {
            level.var_d552cd536f03e258 = [];
        }
        
        level.var_d552cd536f03e258[ level.var_d552cd536f03e258.size ] = player;
        player utility::ent_flag_set( "flag_ent_tunnels_anteroom_player_entered" );
    }
}

// Namespace namespace_4da92177d5600dd
// Params 0
// Checksum 0x3546d89c, Offset: 0xfd2
// Size: 0x223
function tunnels_anteroom_main()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    
    if ( !level callback::exists( #"player_spawned", &function_a88c16df4189d76f ) )
    {
        level callback::add( #"player_spawned", &function_a88c16df4189d76f );
    }
    
    activity_instance thread gemini_util::function_e9681bbfa6c91f07();
    level utility::flag_set( "flag_player_show_minimap" );
    utility::flag_wait( "scriptables_ready" );
    waitframe();
    
    /#
        activity_instance thread gemini_util::function_d6c199899ef5b468( "<dev string:x24>", "<dev string:x3f>", "<dev string:x5e>" );
    #/
    
    waitframe();
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_tunnels_anteroom_weapon", "flag_tunnels_elevator_complete", 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_tunnels_anteroom_equipment", "flag_tunnels_elevator_complete", 1 );
    setomnvar( "ui_hide_player_icons", 0 );
    level thread gemini_util::function_bad374b9f21345b( "e_tunnels_anteroom_gate", "flag_tunnels_anteroom_gate_open", "flag_tunnels_anteroom_one_interact", "flag_tunnels_elevator_descend_start", undefined, 1 );
    activity_instance.var_c19e8c5cd9f81eaa = 0;
    activity_instance childthread gemini_vo::function_c4c5bd03109e3d1a();
    activity_instance childthread function_44961114c49fea3e();
    activity_instance thread function_ba35bd279061ca55();
    activity_instance childthread function_7ddb792f1dffac68();
    activity_instance childthread function_a65f5dfd75f94858();
    activity_instance childthread function_938b82cf97188c70();
    activity_instance thread ob_story_mission_utils::function_e6799e9a19df2365( "s_tunnels_anteroom_cache" );
    activity_instance thread function_1536743826ebe398();
    activity_instance thread function_1977d0c9d4170142( "security_door_anteroom_entrance_hi" );
    activity_instance thread function_1977d0c9d4170142( "security_door_anteroom_entrance_lo" );
    activity_instance thread function_4b55dfbb083a62ac();
    activity_instance thread function_59f72add03c0399();
    activity_instance thread gemini_util::function_a9376b156b863dd4( "trig_tunnels_anteroom_vermin_vent", "flag_tunnels_anteroom_complete" );
    activity_instance thread function_6fa818030405572b();
    activity_instance thread function_cdadf7400a0407ea();
    activity_instance thread function_e0b82704a9e07a93();
    activity_instance thread function_5c2e022448f068a2();
    utility::flag_wait( "flag_tunnels_anteroom_gate_open" );
    activity_instance thread namespace_1f3f9eb1e9681da5::function_9dbeaf9ca833864( activity_instance, "player_catchup_tunnels_anteroom", "flag_tunnels_anteroom_catchup_complete" );
    level utility::flag_wait( "flag_trig_tunnels_anteroom_exit" );
    level utility::flag_set( "flag_tunnels_anteroom_complete" );
    
    if ( level callback::exists( #"player_spawned", &function_a88c16df4189d76f ) )
    {
        level callback::remove( #"player_spawned", &function_a88c16df4189d76f );
    }
    
    activity_instance thread function_8366d440d871d589();
}

/#

    // Namespace namespace_4da92177d5600dd
    // Params 0
    // Checksum 0x2b61d04b, Offset: 0x11fd
    // Size: 0x5, Type: dev
    function function_5748e9b91b4c0545()
    {
        
    }

#/

// Namespace namespace_4da92177d5600dd
// Params 0
// Checksum 0x44b4c373, Offset: 0x120a
// Size: 0x25
function function_8366d440d871d589()
{
    activity_instance = self;
    level utility::flag_wait( "flag_tunnels_elevator_interact" );
    activity_instance gemini_util::function_97b700689f1e4cbd();
}

// Namespace namespace_4da92177d5600dd
// Params 0
// Checksum 0x9e0f0971, Offset: 0x1237
// Size: 0x66
function function_5c2e022448f068a2()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level utility::flag_wait_any( "flag_tunnels_anteroom_gate_open", "flag_trig_tunnels_anteroom_lo_office", "flag_trig_tunnels_anteroom_hi_office" );
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_tunnels_elevator_weapon", "flag_tunnels_elevator_complete", 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_tunnels_elevator_equipment", "flag_tunnels_elevator_complete", 1 );
}

// Namespace namespace_4da92177d5600dd
// Params 0
// Checksum 0xa1e44e0b, Offset: 0x12a5
// Size: 0xa5
function function_e0b82704a9e07a93()
{
    a_s_start = utility::getstructarray( "s_tunnels_anteroom_creepy_zmb", "targetname" );
    level utility::flag_wait( "ai_spawn_director_initialized" );
    
    if ( a_s_start.size > 0 )
    {
        foreach ( index, s_start in a_s_start )
        {
            thread function_e4796c1c68d35c56( s_start, index );
            waitframe();
        }
    }
}

// Namespace namespace_4da92177d5600dd
// Params 2
// Checksum 0xdbc00def, Offset: 0x1352
// Size: 0xff
function function_e4796c1c68d35c56( s_start, index )
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    groupid = ai_spawn_director::function_e19f6a00c4bb7490( "s_tunnels_anteroom_creepy_zmb_" + index, 0, 1, 1, 3 );
    
    if ( isdefined( s_start.script_flag_wait ) )
    {
        level utility::flag_wait( s_start.script_flag_wait );
    }
    else
    {
        wait randomfloatrange( 1, 3 );
    }
    
    ai_type = s_start.script_noteworthy;
    ai_spawn_director::function_35aa3b1d92cd8207( "OnSpawned", groupid, &function_c92af633778f7a5c, s_start );
    ai_spawn_director::function_9893a28f1d682a28( groupid, ai_type, s_start.origin, s_start.angles, undefined, undefined, undefined, "team_hundred_ninety" );
    level utility::flag_wait( "flag_tunnels_elevator_interact" );
    ai_spawn_director::function_d15a5427eec4ebe3( groupid );
}

// Namespace namespace_4da92177d5600dd
// Params 4
// Checksum 0xf7fa0fa, Offset: 0x1459
// Size: 0x153
function function_c92af633778f7a5c( groupid, data, agent, ai_data )
{
    agent endon( #"death" );
    s_start = data;
    var_be17fae8e83d6e7b = utility::getstruct( s_start.target, "targetname" );
    ai_speed = "sprint";
    
    if ( agent.subclass == "zombie_base" )
    {
        agent namespace_b76ff2659823e89d::function_6903092d09bd9aa8();
        ai_speed = "sprint";
        waitframe();
    }
    
    agent zombie_utils::function_dfae6a5bd222c586( &gemini_util::function_6fd9eb6c8ad80bbc );
    agent ai::set_ignoreall( 1 );
    agent ai::set_ignoreme( 1 );
    agent disableaimassist();
    agent utility::ent_flag_set( "zombie_no_heartbeat" );
    
    if ( isdefined( s_start.script_flag_wait ) )
    {
        level utility::flag_wait( s_start.script_flag_wait );
    }
    else
    {
        wait randomfloatrange( 0.5, 1.5 );
    }
    
    agent zombie_utils::function_a8ce00e0448cb6f0( ai_speed, "creepy_zombie_speed", 25 );
    
    if ( s_start.script_parameters == "creepy_zombie_react" )
    {
        agent.b_combat = 0;
        agent thread function_898e2e07223f838a( s_start );
        agent thread function_cbc3b2c69ef9ce18();
    }
    
    agent thread function_190b8d5585ce8f39( s_start, var_be17fae8e83d6e7b );
}

// Namespace namespace_4da92177d5600dd
// Params 2
// Checksum 0x950151b0, Offset: 0x15b4
// Size: 0xbc
function function_190b8d5585ce8f39( s_start, var_be17fae8e83d6e7b )
{
    level endon( #"game_ended" );
    self endon( #"death", #"hash_45b1db2650b15719" );
    player_team = gemini_util::player_get_team();
    self.var_be17fae8e83d6e7b = var_be17fae8e83d6e7b;
    thread zombie_attractor_manager::function_7eb1aaa8bc7cc15( self.var_be17fae8e83d6e7b, 10, undefined, undefined, undefined, undefined, undefined, player_team );
    
    while ( true )
    {
        if ( distance2dsquared( self.origin, self.var_be17fae8e83d6e7b.origin ) < 1024 )
        {
            break;
        }
        
        wait 0.5;
    }
    
    thread zombie_attractor_manager::function_dcfb4c31f1d97cd2( self.var_be17fae8e83d6e7b );
    waitframe();
    gemini_util::function_6db88e9571f4e393();
}

// Namespace namespace_4da92177d5600dd
// Params 1
// Checksum 0x21e1121f, Offset: 0x1678
// Size: 0xbd
function function_898e2e07223f838a( s_start )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker );
        
        if ( isplayer( attacker ) || isplayer( attacker.owner ) )
        {
            break;
        }
        
        if ( isdefined( self ) && isdefined( amount ) )
        {
            self.health += amount;
        }
        
        waitframe();
    }
    
    if ( isdefined( s_start.script_flag_set ) )
    {
        level utility::flag_set( s_start.script_flag_set );
    }
    
    thread function_e166a561eaeb734a( attacker );
}

// Namespace namespace_4da92177d5600dd
// Params 0
// Checksum 0xf1f48d3e, Offset: 0x173d
// Size: 0x88
function function_cbc3b2c69ef9ce18()
{
    level endon( #"game_ended" );
    self endon( #"death", #"hash_45b1db2650b15719" );
    
    while ( true )
    {
        a_players = getplayersinradius( self.origin + ( 0, 0, -24 ), 128, 64 );
        
        if ( a_players.size > 0 )
        {
            break;
        }
        
        wait 1;
    }
    
    a_players = sortbydistance( a_players, self.origin );
    thread function_e166a561eaeb734a( a_players[ 0 ] );
}

// Namespace namespace_4da92177d5600dd
// Params 1
// Checksum 0x6d929971, Offset: 0x17cd
// Size: 0xec
function function_e166a561eaeb734a( player )
{
    self endon( #"death" );
    
    if ( self.b_combat )
    {
        return;
    }
    
    self.b_combat = 1;
    self notify( #"hash_45b1db2650b15719" );
    waitframe();
    self.stealth_enabled = 0;
    utility::ent_flag_clear( "stealth_enabled" );
    zombie_attractor_manager::function_dcfb4c31f1d97cd2( self.var_be17fae8e83d6e7b );
    ai::set_ignoreall( 0 );
    ai::set_ignoreme( 0 );
    self enableaimassist();
    self function_fa32376aaa88a7a2( self.origin, 1024 );
    
    if ( isdefined( player ) )
    {
        self getenemyinfo( player );
        zombie_utils::set_ai_target_priority( player );
    }
    
    gemini_util::ai_nerf();
    level utility::flag_wait( "flag_tunnels_anteroom_complete" );
    aicount = getaicount();
    
    if ( aicount < 25 )
    {
        level utility::flag_wait( "flag_tunnels_elevator_interact" );
    }
    
    gemini_util::ai_delete_when_out_of_sight( 512, 1024 );
}

// Namespace namespace_4da92177d5600dd
// Params 0
// Checksum 0xd72f7346, Offset: 0x18c1
// Size: 0x3ab
function function_59f72add03c0399()
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    var_704f37bf85217934 = utility::getstructarray( "scene_tunnels_anteroom_jump_scare_office_zmb", "targetname" );
    
    foreach ( s_scene in var_704f37bf85217934 )
    {
        s_scene scene::add_spawn_function( &function_9d7185e96f33e2d7, "_object_all_" );
    }
    
    activity_instance thread gemini_util::function_b2e3b9ccdce5ec87( "scene_tunnels_anteroom_jump_scare_office_zmb", undefined, undefined, undefined, "flag_tunnels_elevator_interact" );
    utility::flag_wait( "flag_trig_tunnels_anteroom_lo_enter" );
    
    if ( utility::cointoss() )
    {
        b_first_low = 1;
        var_3385367f8850960c = 0;
    }
    else
    {
        b_first_low = 0;
        var_3385367f8850960c = 1;
    }
    
    var_704f37bf85217934 = utility::getstructarray( "scene_tunnels_anteroom_lo_zmb_01", "targetname" );
    
    foreach ( s_scene in var_704f37bf85217934 )
    {
        s_scene scene::add_spawn_function( &function_aebfda9f83a3c121, "_object_all_" );
    }
    
    var_ab4c49769a763880 = function_9265c7218403c3cb( "scene_tunnels_anteroom_lo_zmb_01", b_first_low );
    activity_instance thread gemini_util::function_b2e3b9ccdce5ec87( "scene_tunnels_anteroom_lo_zmb_01", "flag_tunnels_anteroom_lo_zmb_01_attack", "flag_tunnels_anteroom_lo_zmb_01_attack", undefined, "flag_tunnels_elevator_interact", var_ab4c49769a763880 );
    activity_instance thread function_401ce619772086d2( "scene_tunnels_anteroom_lo_spawn_zmb_01", "flag_tunnels_anteroom_lo_zmb_01_attack", b_first_low );
    wait 1;
    var_704f37bf85217934 = utility::getstructarray( "scene_tunnels_anteroom_lo_zmb_02", "targetname" );
    
    foreach ( s_scene in var_704f37bf85217934 )
    {
        s_scene scene::add_spawn_function( &function_aebfda9f83a3c121, "_object_all_" );
    }
    
    var_ab4c49769a763880 = function_9265c7218403c3cb( "scene_tunnels_anteroom_lo_zmb_02", var_3385367f8850960c );
    activity_instance thread gemini_util::function_b2e3b9ccdce5ec87( "scene_tunnels_anteroom_lo_zmb_02", "flag_tunnels_anteroom_lo_zmb_02_attack", "flag_tunnels_anteroom_lo_zmb_02_attack", undefined, "flag_tunnels_elevator_interact", var_ab4c49769a763880 );
    activity_instance thread function_401ce619772086d2( "scene_tunnels_anteroom_lo_spawn_zmb_02", "flag_tunnels_anteroom_lo_zmb_02_attack", var_3385367f8850960c );
    wait 1;
    var_704f37bf85217934 = utility::getstructarray( "scene_tunnels_anteroom_lo_zmb_03", "targetname" );
    
    foreach ( s_scene in var_704f37bf85217934 )
    {
        s_scene scene::add_spawn_function( &function_aebfda9f83a3c121, "_object_all_" );
    }
    
    var_ab4c49769a763880 = function_9265c7218403c3cb( "scene_tunnels_anteroom_lo_zmb_03" );
    activity_instance thread gemini_util::function_b2e3b9ccdce5ec87( "scene_tunnels_anteroom_lo_zmb_03", "flag_tunnels_anteroom_lo_zmb_03_attack", "flag_tunnels_anteroom_lo_zmb_03_attack", undefined, "flag_tunnels_anteroom_complete", var_ab4c49769a763880 );
    activity_instance thread function_401ce619772086d2( "scene_tunnels_anteroom_lo_spawn_zmb_03", "flag_tunnels_anteroom_lo_zmb_03_attack" );
    level utility::flag_wait_any( "flag_tunnels_anteroom_office_zmb_attack", "flag_trig_tunnels_anteroom_lo_office" );
    var_60fca3e29a8c6085 = gemini_util::function_51e3aaef58423855( "enc_vol_tunnels_anteroom_office", &function_bc62d99b9d56e51c, undefined, "flag_tunnels_elevator_interact" );
}

// Namespace namespace_4da92177d5600dd
// Params 3
// Checksum 0x6ae4e11c, Offset: 0x1c74
// Size: 0xbf
function function_401ce619772086d2( scene_struct_targetname, scene_flag_wait, b_low = 0 )
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    var_704f37bf85217934 = utility::getstructarray( scene_struct_targetname, "targetname" );
    var_704f37bf85217934 = arraysort( var_704f37bf85217934, undefined, &function_2baf2e479bb3e234 );
    var_ab4c49769a763880 = function_9265c7218403c3cb( scene_struct_targetname, b_low );
    
    for ( i = 0; i < var_ab4c49769a763880 ; i++ )
    {
        var_704f37bf85217934[ i ] thread gemini_audio::play_zombie_vox( scene_flag_wait );
        activity_instance thread function_ea45535dc1402bf1( var_704f37bf85217934[ i ], scene_flag_wait );
    }
}

// Namespace namespace_4da92177d5600dd
// Params 2
// Checksum 0x93e0f69e, Offset: 0x1d3b
// Size: 0x6d, Type: bool
function function_2baf2e479bb3e234( a, b )
{
    if ( a.script_scenescriptbundle == "sat_cin_ob_gemini_zombie_spawn_ceiling_crawler_double" || a.script_scenescriptbundle == "sat_cin_ob_gemini_zombie_spawn_ceiling_crawler_single" )
    {
        return true;
    }
    
    if ( b.script_scenescriptbundle == "sat_cin_ob_gemini_zombie_spawn_ceiling_crawler_double" || b.script_scenescriptbundle == "sat_cin_ob_gemini_zombie_spawn_ceiling_crawler_single" )
    {
        return false;
    }
    
    return false;
}

// Namespace namespace_4da92177d5600dd
// Params 2
// Checksum 0xd57bfb03, Offset: 0x1db1
// Size: 0x120
function function_ea45535dc1402bf1( s_scene, scene_flag_wait )
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( level utility::flag( "flag_tunnels_anteroom_complete" ) )
    {
        return;
    }
    
    level endon( #"flag_tunnels_anteroom_complete" );
    s_scene gemini_util::function_7240d161be9ac7b4( activity_instance, "flag_tunnels_elevator_interact" );
    s_scene scene::add_spawn_function( &function_aebfda9f83a3c121, "_object_all_" );
    s_scene scene::add_spawn_function( &gemini_util::function_df0ac467eebfe550, "_object_all_" );
    s_scene thread scene::init();
    s_scene thread gemini_util::scene_zombie_cleanup( "flag_tunnels_elevator_interact" );
    level utility::flag_wait( scene_flag_wait );
    
    if ( isdefined( s_scene.script_noteworthy ) )
    {
        if ( s_scene.script_noteworthy == "vfx_spawn_crawlout" )
        {
            s_scene thread function_f1520b2984f4709();
        }
        else
        {
            utility::exploder( s_scene.script_noteworthy );
        }
    }
    
    s_scene scene::play( undefined, "enter" );
    s_scene notify( #"scene_action" );
    s_scene notify( #"scene_release" );
}

// Namespace namespace_4da92177d5600dd
// Params 0
// Checksum 0x4ce7d421, Offset: 0x1ed9
// Size: 0xfc
function function_f1520b2984f4709()
{
    var_4e150d63f7211cdc = utility::getstruct( self.script_linkto, "script_linkname" );
    
    if ( !isdefined( var_4e150d63f7211cdc ) )
    {
        return;
    }
    
    if ( !isdefined( var_4e150d63f7211cdc.angles ) )
    {
        var_4e150d63f7211cdc.angles = ( 0, 0, 0 );
    }
    
    var_6b9b924693dc6215 = utility::spawn_model( "tag_origin", var_4e150d63f7211cdc.origin, var_4e150d63f7211cdc.angles );
    playfxontag( utility::getfx( "vfx_spawn_crawlout" ), var_6b9b924693dc6215, "tag_origin" );
    var_6b9b924693dc6215 moveto( self.origin, 3, 0.5, 0.5 );
    msg = utility::waittill_notify_or_timeout_return( "scene_zombie_death", 3 );
    
    if ( msg == "scene_zombie_death" )
    {
        wait 1;
    }
    
    stopfxontag( utility::getfx( "vfx_spawn_crawlout" ), var_6b9b924693dc6215, "tag_origin" );
    waitframe();
    var_6b9b924693dc6215 delete();
}

// Namespace namespace_4da92177d5600dd
// Params 2
// Checksum 0xc7b24159, Offset: 0x1fdd
// Size: 0xc5
function function_9265c7218403c3cb( struct_targetname, b_low = 0 )
{
    var_ab4c49769a763880 = 1;
    var_5fa90f1a51250bbf = utility::getstructarray( struct_targetname, "targetname" );
    a_players = ob_story_mission_utils::get_playing_players();
    
    if ( b_low )
    {
        if ( !level.is_squad_size_small || a_players.size > 2 )
        {
            var_ab4c49769a763880 = maxint( 1, var_5fa90f1a51250bbf.size - 1 );
        }
        else
        {
            var_ab4c49769a763880 = maxint( 1, var_5fa90f1a51250bbf.size - 2 );
        }
    }
    else if ( !level.is_squad_size_small || a_players.size > 2 )
    {
        var_ab4c49769a763880 = maxint( 1, var_5fa90f1a51250bbf.size );
    }
    else
    {
        var_ab4c49769a763880 = maxint( 1, var_5fa90f1a51250bbf.size - 1 );
    }
    
    return var_ab4c49769a763880;
}

// Namespace namespace_4da92177d5600dd
// Params 0
// Checksum 0x93dc125e, Offset: 0x20ab
// Size: 0x9d
function function_1536743826ebe398()
{
    level endon( #"game_ended", #"flag_tunnels_anteroom_catchup_complete" );
    trig = getent( "trig_tunnels_anteroom_player_inside", #targetname );
    n_count = 0;
    
    while ( true )
    {
        a_players = ob_story_mission_utils::get_playing_players();
        a_players_inside = gemini_util::function_c00e724156609769( trig );
        
        if ( a_players.size == a_players_inside.size )
        {
            n_count++;
            
            if ( n_count == 3 )
            {
                break;
            }
        }
        else
        {
            n_count = 0;
        }
        
        wait 1;
    }
    
    utility::flag_set( "flag_tunnels_anteroom_all_players_inside" );
}

// Namespace namespace_4da92177d5600dd
// Params 1
// Checksum 0x1ac95b8f, Offset: 0x2150
// Size: 0xe1
function function_1977d0c9d4170142( door_targetname )
{
    level endon( #"game_ended" );
    a_doors = gemini_util::function_d5f3a036e837913( door_targetname );
    
    if ( a_doors.size == 0 )
    {
        return;
    }
    
    msg = level utility::flag_wait_any_return( "flag_tunnels_anteroom_catchup_complete", "flag_tunnels_anteroom_all_players_inside" );
    
    if ( msg == "flag_tunnels_anteroom_catchup_complete" )
    {
        /#
            iprintlnbold( "<dev string:x7d>" + door_targetname );
        #/
    }
    else
    {
        /#
            iprintlnbold( "<dev string:x9f>" + door_targetname );
        #/
    }
    
    for ( i = 0; i < a_doors.size ; i++ )
    {
        door = a_doors[ i ];
        
        if ( i == 0 )
        {
            door thread gemini_util::scriptable_door_lock( 1 );
            continue;
        }
        
        door gemini_util::scriptable_door_lock( 1 );
        door thread function_e8ccacbf9bb56733();
    }
    
    wait 1;
    level utility::flag_set( "flag_tunnels_anteroom_doors_locked" );
}

// Namespace namespace_4da92177d5600dd
// Params 0, eflags: 0x4
// Checksum 0xa2af66b, Offset: 0x2239
// Size: 0xc7
function private function_e8ccacbf9bb56733()
{
    players = getplayersinradius( self.origin, 800 );
    
    if ( players.size > 0 )
    {
        foreach ( player in players )
        {
            player thread gemini_util::function_9623f1811bc192b4();
        }
        
        return;
    }
    
    earthquake( 0.2, 0.2, self.origin, 800 );
    playrumbleonposition( "damage_light", self.origin );
}

// Namespace namespace_4da92177d5600dd
// Params 0
// Checksum 0x8aaa69f, Offset: 0x2308
// Size: 0x100
function function_4b55dfbb083a62ac()
{
    level utility::flag_wait( "flag_tunnels_anteroom_doors_locked" );
    level.var_d53163b0ef2a4488 = 1;
    wait 1;
    vol = getnoentvolumearray( "vol_tunnels_anteroom_ai_check", #targetname )[ 0 ];
    
    if ( isdefined( vol ) )
    {
        a_agents = getaiarray( "team_two_hundred", "team_hundred_ninety" );
        
        if ( a_agents.size > 0 )
        {
            count = 0;
            
            foreach ( agent in a_agents )
            {
                if ( !agent istouching( vol ) )
                {
                    agent gemini_util::function_6db88e9571f4e393();
                    count++;
                    waitframe();
                }
            }
            
            /#
                iprintlnbold( "<dev string:xc8>" + count );
            #/
        }
    }
}

// Namespace namespace_4da92177d5600dd
// Params 0
// Checksum 0x3f6fff92, Offset: 0x2410
// Size: 0x71
function function_6fa818030405572b()
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    player = gemini_util::function_4408fb951c105cb4( "trig_tunnels_anteroom_hi_01" );
    var_957ebf7549420f38 = activity_instance gemini_util::function_51e3aaef58423855( "enc_vol_tunnels_anteroom_hi_01", &function_145d1b69dfa74e4f, player, "flag_tunnels_elevator_interact", 2, 0, &function_230df56bf38dd8f );
}

// Namespace namespace_4da92177d5600dd
// Params 0
// Checksum 0x9feb92ed, Offset: 0x2489
// Size: 0x71
function function_cdadf7400a0407ea()
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    player = gemini_util::function_4408fb951c105cb4( "trig_tunnels_anteroom_hi_02" );
    var_957ec275494215d1 = activity_instance gemini_util::function_51e3aaef58423855( "enc_vol_tunnels_anteroom_hi_02", &function_145d1b69dfa74e4f, player, "flag_tunnels_elevator_interact", 2, 0, &function_230df56bf38dd8f );
}

// Namespace namespace_4da92177d5600dd
// Params 3
// Checksum 0x1ad76fcf, Offset: 0x2502
// Size: 0x4b, Type: bool
function function_230df56bf38dd8f( request_id, user_data, var_62a6b384c0358219 )
{
    a_players = ob_story_mission_utils::get_playing_players();
    
    if ( a_players.size > 2 || !level.is_squad_size_small )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_4da92177d5600dd
// Params 0
// Checksum 0x5ce31ada, Offset: 0x2556
// Size: 0x98
function function_9d7185e96f33e2d7()
{
    self endon( #"death" );
    
    if ( !isalive( self ) || !isai( self ) )
    {
        return;
    }
    
    gemini_util::function_54a189c04c75a149( 1 );
    zombie_utils::function_dfae6a5bd222c586( &gemini_util::function_6fd9eb6c8ad80bbc );
    waitframe();
    self.stealth_enabled = 0;
    utility::ent_flag_clear( "stealth_enabled" );
    level utility::flag_wait( "flag_tunnels_anteroom_complete" );
    gemini_util::ai_nerf();
    aicount = getaicount();
    
    if ( aicount < 25 )
    {
        level utility::flag_wait( "flag_tunnels_elevator_interact" );
    }
    
    thread gemini_util::ai_delete_when_out_of_sight( 512, 1024 );
}

// Namespace namespace_4da92177d5600dd
// Params 0
// Checksum 0x7266a210, Offset: 0x25f6
// Size: 0x98
function function_aebfda9f83a3c121()
{
    self endon( #"death" );
    
    if ( !isalive( self ) || !isai( self ) )
    {
        return;
    }
    
    gemini_util::function_54a189c04c75a149( 1 );
    zombie_utils::function_dfae6a5bd222c586( &gemini_util::function_6fd9eb6c8ad80bbc );
    waitframe();
    self.stealth_enabled = 0;
    utility::ent_flag_clear( "stealth_enabled" );
    level utility::flag_wait( "flag_tunnels_anteroom_complete" );
    gemini_util::ai_nerf();
    aicount = getaicount();
    
    if ( aicount < 25 )
    {
        level utility::flag_wait( "flag_tunnels_elevator_interact" );
    }
    
    thread gemini_util::ai_delete_when_out_of_sight( 512, 1024 );
}

// Namespace namespace_4da92177d5600dd
// Params 4
// Checksum 0x888375ee, Offset: 0x2696
// Size: 0x112
function function_bc62d99b9d56e51c( request_id, data, agent, ai_data )
{
    agent endon( #"death" );
    
    if ( utility::cointoss() )
    {
        agent zombie_utils::function_a8ce00e0448cb6f0( "sprint", "anteroom_vermin", 25 );
    }
    else
    {
        agent zombie_utils::function_a8ce00e0448cb6f0( "run", "anteroom_vermin", 25 );
    }
    
    agent gemini_util::function_54a189c04c75a149( 1 );
    agent zombie_utils::function_dfae6a5bd222c586( &gemini_util::function_6fd9eb6c8ad80bbc );
    waitframe();
    agent.stealth_enabled = 0;
    agent utility::ent_flag_clear( "stealth_enabled" );
    
    if ( isplayer( data ) )
    {
        player_target = data;
        agent getenemyinfo( player_target );
        agent zombie_utils::set_ai_target_priority( player_target );
    }
    
    level utility::flag_wait( "flag_tunnels_anteroom_complete" );
    gemini_util::ai_nerf();
    aicount = getaicount();
    
    if ( aicount < 25 )
    {
        level utility::flag_wait( "flag_tunnels_elevator_interact" );
    }
    
    agent thread gemini_util::ai_delete_when_out_of_sight( 512, 1024 );
}

// Namespace namespace_4da92177d5600dd
// Params 4
// Checksum 0x94d2bb6b, Offset: 0x27b0
// Size: 0x144
function function_145d1b69dfa74e4f( request_id, data, agent, ai_data )
{
    agent endon( #"death" );
    agent zombie_traverse_asm::function_85b354b1fada24eb();
    agent function_786bb6aa1b76c7ee( "wallCrawlRangedAttackRange", 1 );
    agent.var_720018aa0a425283 = 0;
    agent zombie_utils::function_dfae6a5bd222c586( &gemini_util::function_6fd9eb6c8ad80bbc );
    
    if ( utility::cointoss() )
    {
        agent zombie_utils::function_a8ce00e0448cb6f0( "sprint", "anteroom_vermin", 25 );
    }
    else
    {
        agent zombie_utils::function_a8ce00e0448cb6f0( "run", "anteroom_vermin", 25 );
    }
    
    agent gemini_util::function_54a189c04c75a149( 1 );
    agent zombie_utils::function_dfae6a5bd222c586( &gemini_util::function_6fd9eb6c8ad80bbc );
    waitframe();
    agent.stealth_enabled = 0;
    agent utility::ent_flag_clear( "stealth_enabled" );
    
    if ( isplayer( data ) )
    {
        player_target = data;
        agent getenemyinfo( player_target );
        agent zombie_utils::set_ai_target_priority( player_target );
    }
    
    level utility::flag_wait( "flag_tunnels_anteroom_complete" );
    gemini_util::ai_nerf();
    aicount = getaicount();
    
    if ( aicount < 25 )
    {
        level utility::flag_wait( "flag_tunnels_elevator_interact" );
    }
    
    agent thread gemini_util::ai_delete_when_out_of_sight( 512, 1024 );
}

// Namespace namespace_4da92177d5600dd
// Params 0
// Checksum 0x99d9866a, Offset: 0x28fc
// Size: 0x84
function function_7ddb792f1dffac68()
{
    activity_instance = self;
    gate_interact_walkway = getentitylessscriptablearray( "e_tunnels_anteroom_walkway_gate_interact", #targetname )[ 0 ];
    
    if ( !gate_interact_walkway )
    {
        return;
    }
    
    while ( gate_interact_walkway getscriptablepartstate( "base" ) != "console_on" )
    {
        waitframe();
    }
    
    activity_instance.var_c19e8c5cd9f81eaa++;
    activity_instance mission_ui::function_759924b87215156b( activity_instance.var_c19e8c5cd9f81eaa, 2, level.var_d552cd536f03e258 );
    level utility::flag_set( "flag_tunnels_anteroom_walkway_interact_used" );
}

// Namespace namespace_4da92177d5600dd
// Params 0
// Checksum 0xce68120, Offset: 0x2988
// Size: 0x84
function function_a65f5dfd75f94858()
{
    activity_instance = self;
    gate_interact_office = getentitylessscriptablearray( "e_tunnels_anteroom_office_gate_interact", #targetname )[ 0 ];
    
    if ( !gate_interact_office )
    {
        return;
    }
    
    while ( gate_interact_office getscriptablepartstate( "base" ) != "console_on" )
    {
        waitframe();
    }
    
    activity_instance.var_c19e8c5cd9f81eaa++;
    activity_instance mission_ui::function_759924b87215156b( activity_instance.var_c19e8c5cd9f81eaa, 2, level.var_d552cd536f03e258 );
    level utility::flag_set( "flag_tunnels_anteroom_office_interact_used" );
}

// Namespace namespace_4da92177d5600dd
// Params 0
// Checksum 0xc5008a49, Offset: 0x2a14
// Size: 0x21
function function_938b82cf97188c70()
{
    level utility::flag_wait_all( "flag_tunnels_anteroom_walkway_interact_used", "flag_tunnels_anteroom_office_interact_used" );
    level utility::flag_set( "flag_tunnels_anteroom_all_interacts" );
}

/#

    // Namespace namespace_4da92177d5600dd
    // Params 0
    // Checksum 0xc60660e8, Offset: 0x2a3d
    // Size: 0x5, Type: dev
    function function_f5427601b43a8b8b()
    {
        
    }

#/

// Namespace namespace_4da92177d5600dd
// Params 0
// Checksum 0x10c2e1f4, Offset: 0x2a4a
// Size: 0x90
function function_44961114c49fea3e()
{
    activity_instance = self;
    activity_instance childthread function_e6b4c07e0a742f5e();
    activity_instance childthread function_a058e630abe47e4e();
    activity_instance childthread function_4c61e6080c71e93();
    s_obj_circle = utility::getstruct( "s_obj_tunnels_anteroom_area", "targetname" );
    activity_instance.obj_circle = ob_story_mission_utils::function_ab06e28322870f4( s_obj_circle.origin, s_obj_circle.radius );
    level utility::flag_wait_all( "flag_tunnels_anteroom_walkway_interact_found", "flag_tunnels_anteroom_office_interact_found" );
    ob_story_mission_utils::function_352aa3aab98a0618( activity_instance.obj_circle );
}

// Namespace namespace_4da92177d5600dd
// Params 1
// Checksum 0xf0bca220, Offset: 0x2ae2
// Size: 0xfe
function function_7dbbe7e03e4ea826( player )
{
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance namespace_b451b5202140ccde::function_dac15947c2d451e9( [ player ] );
    waitframe();
    activity_instance namespace_b451b5202140ccde::function_d3aa02fc5d62637d( "OB_GEMINI_TUNNELS_SOLITARY", [ player ] );
    player utility::ent_flag_wait( "flag_ent_tunnels_anteroom_player_entered" );
    waitframe();
    activity_instance namespace_b451b5202140ccde::function_dac15947c2d451e9( [ player ] );
    waitframe();
    activity_instance namespace_b451b5202140ccde::function_d3aa02fc5d62637d( "OB_GEMINI_TUNNELS_ANTEROOM", [ player ] );
    mission_ui::function_759924b87215156b( activity_instance.var_c19e8c5cd9f81eaa, 2, [ player ] );
    player val::reset_all( "player_stealth" );
    level utility::flag_wait( "flag_tunnels_anteroom_gate_open" );
    activity_instance.obj_id = gemini_util::function_70fecc661764c00a( "s_obj_tunnels_anteroom_exit", player, undefined, "targetname", undefined, "active" );
}

// Namespace namespace_4da92177d5600dd
// Params 0
// Checksum 0x53e31e68, Offset: 0x2be8
// Size: 0xbd
function function_e6b4c07e0a742f5e()
{
    activity_instance = self;
    gate_interact_walkway = getentitylessscriptablearray( "e_tunnels_anteroom_walkway_gate_interact", #targetname )[ 0 ];
    
    if ( !gate_interact_walkway || utility::flag( "flag_tunnels_anteroom_walkway_interact_used" ) )
    {
        return;
    }
    
    level utility::flag_wait( "flag_trig_tunnels_anteroom_hi_office" );
    level utility::flag_set( "flag_tunnels_anteroom_walkway_interact_found" );
    
    if ( !activity_instance.walkway_obj_id )
    {
        activity_instance.walkway_obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( gate_interact_walkway.origin, 68, level.var_d552cd536f03e258, "sat_ob_objectivemarker_storymissionmain", 0, 0, 0 );
        level utility::flag_wait( "flag_tunnels_anteroom_walkway_interact_used" );
        activity_instance ob_story_mission_utils::objective_marker_clear( activity_instance.walkway_obj_id );
    }
}

// Namespace namespace_4da92177d5600dd
// Params 0
// Checksum 0x6e5cc4c4, Offset: 0x2cad
// Size: 0xbd
function function_a058e630abe47e4e()
{
    activity_instance = self;
    gate_interact_office = getentitylessscriptablearray( "e_tunnels_anteroom_office_gate_interact", #targetname )[ 0 ];
    
    if ( !gate_interact_office || utility::flag( "flag_tunnels_anteroom_office_interact_used" ) )
    {
        return;
    }
    
    level utility::flag_wait( "flag_trig_tunnels_anteroom_lo_office" );
    level utility::flag_set( "flag_tunnels_anteroom_office_interact_found" );
    
    if ( !activity_instance.office_obj_id )
    {
        activity_instance.office_obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( gate_interact_office.origin, 68, level.var_d552cd536f03e258, "sat_ob_objectivemarker_storymissionmain", 0, 0, 0 );
        level utility::flag_wait( "flag_tunnels_anteroom_office_interact_used" );
        activity_instance ob_story_mission_utils::objective_marker_clear( activity_instance.office_obj_id );
    }
}

// Namespace namespace_4da92177d5600dd
// Params 0
// Checksum 0xdf6bfd19, Offset: 0x2d72
// Size: 0x1fa
function function_4c61e6080c71e93()
{
    level endon( #"flag_tunnels_anteroom_gate_open" );
    activity_instance = self;
    gate_interact_walkway = getentitylessscriptablearray( "e_tunnels_anteroom_walkway_gate_interact", #targetname )[ 0 ];
    gate_interact_office = getentitylessscriptablearray( "e_tunnels_anteroom_office_gate_interact", #targetname )[ 0 ];
    
    if ( !gate_interact_walkway || !gate_interact_office )
    {
        return;
    }
    
    while ( !utility::flag( "flag_tunnels_anteroom_all_interacts" ) )
    {
        activity_instance waittill( #"hash_c756f639ab2471b0" );
        
        if ( !utility::flag( "flag_tunnels_anteroom_walkway_interact_used" ) )
        {
            if ( !activity_instance.walkway_obj_id )
            {
                level utility::flag_set( "flag_tunnels_anteroom_walkway_interact_found" );
                activity_instance.walkway_obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( gate_interact_walkway.origin, 68, level.var_d552cd536f03e258, "sat_ob_objectivemarker_storymissionmain", 0, 0, 0 );
                level utility::flag_wait( "flag_tunnels_anteroom_walkway_interact_used" );
                ob_story_mission_utils::objective_marker_clear( activity_instance.walkway_obj_id );
            }
            else
            {
                activity_instance utility::waittill_notify_or_timeout( "notify_tunnels_anteroom_find_switch_nag_finished", 5 );
                
                if ( activity_instance.walkway_obj_id )
                {
                    ob_story_mission_utils::objective_marker_ping( activity_instance.walkway_obj_id, level.var_d552cd536f03e258 );
                }
            }
            
            continue;
        }
        
        if ( !utility::flag( "flag_tunnels_anteroom_office_interact_used" ) )
        {
            if ( !activity_instance.office_obj_id )
            {
                level utility::flag_set( "flag_tunnels_anteroom_office_interact_found" );
                activity_instance.office_obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( gate_interact_office.origin, 68, level.var_d552cd536f03e258, "sat_ob_objectivemarker_storymissionmain", 0, 0, 0 );
                level utility::flag_wait( "flag_tunnels_anteroom_office_interact_used" );
                ob_story_mission_utils::objective_marker_clear( activity_instance.office_obj_id );
                continue;
            }
            
            activity_instance utility::waittill_notify_or_timeout( "notify_tunnels_anteroom_find_switch_nag_finished", 5 );
            
            if ( activity_instance.office_obj_id )
            {
                ob_story_mission_utils::objective_marker_ping( activity_instance.office_obj_id, level.var_d552cd536f03e258 );
            }
        }
    }
}

// Namespace namespace_4da92177d5600dd
// Params 0
// Checksum 0x55028c08, Offset: 0x2f74
// Size: 0xc0
function function_ba35bd279061ca55()
{
    level endon( #"game_ended" );
    level endon( #"flag_tunnels_elevator_complete" );
    activity_instance = self;
    level utility::flag_wait( "flag_tunnels_anteroom_catchup_complete" );
    
    foreach ( player in level.players )
    {
        if ( player utility::ent_flag( "player_catchup_tunnels_anteroom_player_teleported" ) )
        {
            player utility::ent_flag_set( "flag_ent_tunnels_anteroom_player_entered" );
        }
    }
}

/#

    // Namespace namespace_4da92177d5600dd
    // Params 0
    // Checksum 0xa70859ba, Offset: 0x303c
    // Size: 0x5, Type: dev
    function function_80fe99d49a6a9d87()
    {
        
    }

#/

// Namespace namespace_4da92177d5600dd
// Params 1
// Checksum 0x36b5820b, Offset: 0x3049
// Size: 0x35
function function_a88c16df4189d76f( params )
{
    player = self;
    player utility::ent_flag_set( "flag_ent_tunnels_prison_player_died" );
    player utility::ent_flag_set( "flag_ent_tunnels_anteroom_player_entered" );
}

