// scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_activity_tunnels_pit.gsc  (hash_3118e2d44d375a85.gscc) (size: 12019 Bytes / 0x2ef3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x41d4e543 (1104471363)
// size ...... 12019 (0x2ef3)
// includes .. 17  (offset: 0x2b33)
// strings ... 48  (offset: 0x2bbb)
// dev strs .. 6   (offset: 0x2eab)
// exports ... 31  (offset: 0x191f)
// cseg ...... 0x6b9 + 0x1266 (0x191f)
// imports ... 111 (offset: 0x1df7)
// animtree1 . 0   (offset: 0x2ef3)
// animtree2 . 0   (offset: 0x2ef3)
#using script_4c1e16e1162d066f;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\interaction;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_activity_tunnels_mine;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_util;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_vo;
#using scripts\mp\ob\contracts\ob_contract_ui_widget;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;

#namespace namespace_f77971aa36d1d3d7;

/#

    // Namespace namespace_f77971aa36d1d3d7
    // Params 0
    // Checksum 0xf2e8dc89, Offset: 0x6d7
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_f77971aa36d1d3d7
// Params 0, eflags: 0x5
// Checksum 0xf3eefe74, Offset: 0x6e4
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_9077cdbdb1375b05", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_f77971aa36d1d3d7
// Params 0, eflags: 0x4
// Checksum 0x21bccb9b, Offset: 0x70d
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_GEMINI_TUNNELS_PIT";
    activity_common::registeractivitytype( "OB_GEMINI_TUNNELS_PIT", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_TUNNELS_PIT", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_TUNNELS_PIT", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_TUNNELS_PIT", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_GEMINI_TUNNELS_PIT" );
}

// Namespace namespace_f77971aa36d1d3d7
// Params 0
// Checksum 0xf5d6818c, Offset: 0x784
// Size: 0x59
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance tunnels_pit_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_f77971aa36d1d3d7
// Params 0
// Checksum 0xd75561fb, Offset: 0x7e5
// Size: 0x39
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance tunnels_pit_main();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_f77971aa36d1d3d7
// Params 0
// Checksum 0x6fdf4776, Offset: 0x826
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_f77971aa36d1d3d7
// Params 1
// Checksum 0x2d7064b, Offset: 0x84a
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread tunnels_pit_player_setup( player );
    }
}

/#

    // Namespace namespace_f77971aa36d1d3d7
    // Params 0
    // Checksum 0xb5527899, Offset: 0x906
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_f77971aa36d1d3d7
// Params 0
// Checksum 0x5fbefdd5, Offset: 0x913
// Size: 0x95
function tunnels_pit_start()
{
    activity_instance = self;
    ob_story_mission_utils::function_6314f03dfe2adbc5( 0 );
    activity_instance thread ob_story_mission_utils::objective_marker_clear_all();
    level thread gemini_util::function_85abe3355f8a3cce();
    gemini_util::function_34a3d0cff5de2d7d();
    level ob_adz::function_86ebf122bc776db5();
    level thread namespace_b109f7cb70e0649d::tunnels_mine_screen_setup();
    activity_instance thread namespace_b109f7cb70e0649d::function_f82925b9a769dc1b( 1 );
    activity_instance thread function_7d3411eb18c9fb08();
    
    /#
        if ( getdvarint( @"hash_977d6e69d9305776", 0 ) )
        {
            thread namespace_b109f7cb70e0649d::function_d283aee3d1244e6c( "<dev string:x24>" );
        }
    #/
    
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_tunnels_mine_weapon", undefined, 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_tunnels_mine_equipment", undefined, 1 );
}

// Namespace namespace_f77971aa36d1d3d7
// Params 0
// Checksum 0xe47210cd, Offset: 0x9b0
// Size: 0x153
function tunnels_pit_main()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    waitframe();
    
    /#
        activity_instance thread gemini_util::function_d6c199899ef5b468( "<dev string:x39>", "<dev string:x4f>", "<dev string:x69>" );
    #/
    
    waitframe();
    
    if ( !isdefined( level.var_3ce1f8d9700aaa07 ) )
    {
        level.var_3ce1f8d9700aaa07 = undefined;
    }
    
    if ( !level callback::exists( #"player_spawned", &function_9dbcf5b93b30b52a ) )
    {
        level callback::add( #"player_spawned", &function_9dbcf5b93b30b52a );
    }
    
    level.var_d53163b0ef2a4488 = 1;
    activity_instance childthread gemini_vo::function_a02aa5f9081b6020();
    activity_instance thread function_c866812d3b464808();
    activity_instance thread function_690ac6888066751();
    activity_instance thread function_9f0709b1c1444716( "s_tunnels_pit_center" );
    thread gemini_util::function_6ba38d8e858007a9();
    thread gemini_util::function_bad374b9f21345b( "e_tunnels_mine_gate_03", "flag_tunnels_mine_gate_03_open", "flag_tunnels_mine_gate_03_interact", "flag_tunnels_pit_complete", undefined, 1 );
    level utility::flag_wait( "flag_trig_tunnels_mine_complete" );
    activity_instance thread function_9ac87975ff32122c();
    activity_instance thread tunnels_pit_cleanup();
    level utility::flag_wait( "flag_tunnels_pit_complete" );
    
    if ( level callback::exists( #"player_spawned", &function_9dbcf5b93b30b52a ) )
    {
        level callback::remove( #"player_spawned", &function_9dbcf5b93b30b52a );
    }
    
    /#
        iprintlnbold( "<dev string:x84>" );
    #/
}

// Namespace namespace_f77971aa36d1d3d7
// Params 0
// Checksum 0xf3ec58b8, Offset: 0xb0b
// Size: 0x73
function tunnels_pit_cleanup()
{
    activity_instance = self;
    activity_instance gemini_util::function_97b700689f1e4cbd( 1, 0 );
    level utility::flag_wait( "flag_tunnels_pit_complete" );
    wait 1;
    var_399a0f97e8cb8e0b = utility::getstruct( "s_tunnels_mine_obj_interrogation", "targetname" );
    gemini_util::function_b95c324c7b2d9f63( var_399a0f97e8cb8e0b.origin, 8000 );
    wait 1;
    level thread gemini_util::delete_all_ai();
    ob_story_mission_utils::set_revive_spawns( undefined );
}

// Namespace namespace_f77971aa36d1d3d7
// Params 1
// Checksum 0xe3b40287, Offset: 0xb86
// Size: 0x54
function tunnels_pit_player_setup( player )
{
    activity_instance = self;
    activity_instance thread function_ed6e40bd47b81064( player );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        player thread gemini_util::player_cold_breath_toggle( "flag_tunnels_pit_complete" );
        player thread namespace_b109f7cb70e0649d::function_77dfef6d795b0b87( 1 );
    }
}

// Namespace namespace_f77971aa36d1d3d7
// Params 0
// Checksum 0xd652e1e, Offset: 0xbe2
// Size: 0x35c
function function_690ac6888066751()
{
    level utility::flag_wait( "flag_trig_tunnels_mine_progress_08" );
    var_5bc3ec6f12d5ef3f = utility::getstruct( "s_enc_vol_mine_zombie_03a", "targetname" );
    var_5bc3ec6f12d5ef3f.var_b60496d5b429ae0f = "flag_tunnels_mine_gate_03_open";
    var_5bc3ec6f12d5ef3f.emergence_spawn_chance = 50;
    var_42a719ed2a688ad0 = gemini_util::function_51e3aaef58423855( var_5bc3ec6f12d5ef3f.target, &namespace_b109f7cb70e0649d::function_edbdc57799e15062, var_5bc3ec6f12d5ef3f, "flag_tunnels_mine_gate_03_open" );
    ai_spawn_director::function_c99d360d62c49a9c( var_42a719ed2a688ad0, &function_87a01f27be92f02b );
    ai_spawn_director::function_53289c032f506bb1( var_42a719ed2a688ad0, &function_a012837f5056111a );
    a_players = ob_story_mission_utils::get_playing_players( 1 );
    
    if ( a_players.size < 3 || level.is_squad_size_small )
    {
        n_max_count = 4;
    }
    else
    {
        n_max_count = 6;
    }
    
    function_bbd192652d1a9e18( var_42a719ed2a688ad0, n_max_count );
    function_a748fd0f51127844( var_42a719ed2a688ad0, 1 );
    level utility::flag_wait( "flag_trig_tunnels_mine_progress_09" );
    thread namespace_b109f7cb70e0649d::function_ea6053ae19da11d1( "trig_tunnels_mine_ambush_04", "flag_tunnels_mine_ambush_04", "flag_tunnels_mine_gate_03_open", 0, 50 );
    waitframe();
    thread namespace_b109f7cb70e0649d::function_ea6053ae19da11d1( "trig_tunnels_mine_ambush_05", "flag_tunnels_mine_ambush_05", "flag_trig_tunnels_mine_gate_03_complete", 1, 50 );
    wait 1;
    var_5bc3ed6f12d5f172 = utility::getstruct( "s_enc_vol_mine_zombie_03b", "targetname" );
    var_5bc3ed6f12d5f172.var_b60496d5b429ae0f = "flag_tunnels_pit_complete";
    var_5bc3ed6f12d5f172.emergence_spawn_chance = 25;
    var_42a71ced2a689169 = gemini_util::function_51e3aaef58423855( var_5bc3ed6f12d5f172.target, &namespace_b109f7cb70e0649d::function_edbdc57799e15062, var_5bc3ed6f12d5f172, "flag_tunnels_pit_complete" );
    ai_spawn_director::function_c99d360d62c49a9c( var_42a71ced2a689169, &function_87a01f27be92f02b );
    ai_spawn_director::function_53289c032f506bb1( var_42a71ced2a689169, &function_b29343eaa08f0adb );
    a_players = ob_story_mission_utils::get_playing_players( 1 );
    
    if ( a_players.size < 3 || level.is_squad_size_small )
    {
        n_max_count = 4;
    }
    else
    {
        n_max_count = 6;
    }
    
    function_bbd192652d1a9e18( var_42a71ced2a689169, n_max_count );
    function_a748fd0f51127844( var_42a71ced2a689169, 1 );
    function_a748fd0f51127844( var_42a719ed2a688ad0, 3 );
    level utility::flag_wait( "flag_trig_tunnels_mine_gate_03_begin" );
    var_5bc3ee6f12d5f3a5 = utility::getstruct( "s_enc_vol_mine_zombie_03c", "targetname" );
    var_5bc3ee6f12d5f3a5.var_b60496d5b429ae0f = "flag_tunnels_pit_complete";
    var_5bc3ee6f12d5f3a5.emergence_spawn_chance = 75;
    var_42a71bed2a688f36 = gemini_util::function_51e3aaef58423855( var_5bc3ee6f12d5f3a5.target, &namespace_b109f7cb70e0649d::function_edbdc57799e15062, var_5bc3ee6f12d5f3a5, "flag_tunnels_pit_complete" );
    ai_spawn_director::function_c99d360d62c49a9c( var_42a71bed2a688f36, &function_87a01f27be92f02b );
    ai_spawn_director::function_53289c032f506bb1( var_42a71bed2a688f36, &function_5f31a3e58f8fec10 );
    a_players = ob_story_mission_utils::get_playing_players( 1 );
    
    if ( a_players.size < 3 || level.is_squad_size_small )
    {
        n_max_count = 1;
    }
    else
    {
        n_max_count = 2;
    }
    
    function_bbd192652d1a9e18( var_42a71bed2a688f36, n_max_count );
    function_a748fd0f51127844( var_42a71bed2a688f36, 3 );
    function_a748fd0f51127844( var_42a71ced2a689169, 3 );
    waitframe();
    a_players = ob_story_mission_utils::get_playing_players( 1 );
    
    if ( a_players.size < 3 || level.is_squad_size_small )
    {
        flag_trigger = "flag_tunnels_mine_gate_03_unstick";
    }
    else
    {
        flag_trigger = "flag_tunnels_mine_gate_03_stuck";
    }
    
    thread namespace_b109f7cb70e0649d::function_c36fe1117e7f2fcf( "scene_tunnels_mine_horde_fall_02", [ flag_trigger ], "flag_tunnels_pit_complete" );
    level utility::flag_wait( "flag_tunnels_mine_gate_03_open" );
    a_players = ob_story_mission_utils::get_playing_players( 1 );
    
    if ( a_players.size < 3 || level.is_squad_size_small )
    {
        n_max_count = 1;
    }
    else
    {
        n_max_count = 2;
    }
    
    function_bbd192652d1a9e18( var_42a71bed2a688f36, n_max_count );
    function_a748fd0f51127844( var_42a71bed2a688f36, 10 );
}

// Namespace namespace_f77971aa36d1d3d7
// Params 2
// Checksum 0x79f5ebd2, Offset: 0xf46
// Size: 0x66, Type: bool
function function_87a01f27be92f02b( requestid, userdata )
{
    a_players = ob_story_mission_utils::get_playing_players( 1 );
    var_47fb9dbeaec0bd43 = getaicount();
    
    if ( a_players.size < 3 || level.is_squad_size_small )
    {
        if ( var_47fb9dbeaec0bd43 > 15 )
        {
            return false;
        }
    }
    else if ( var_47fb9dbeaec0bd43 > 25 )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_f77971aa36d1d3d7
// Params 2
// Checksum 0xc688208c, Offset: 0xfb5
// Size: 0x28, Type: bool
function function_a012837f5056111a( requestid, userdata )
{
    if ( level utility::flag( "flag_trig_tunnels_mine_gate_03_complete" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_f77971aa36d1d3d7
// Params 2
// Checksum 0x4bd77f27, Offset: 0xfe6
// Size: 0x28, Type: bool
function function_b29343eaa08f0adb( requestid, userdata )
{
    if ( level utility::flag( "flag_tunnels_mine_gate_03_open" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_f77971aa36d1d3d7
// Params 2
// Checksum 0x12b4b04b, Offset: 0x1017
// Size: 0x28, Type: bool
function function_5f31a3e58f8fec10( requestid, userdata )
{
    if ( level utility::flag( "flag_trig_tunnels_mine_gate_03_complete" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_f77971aa36d1d3d7
// Params 0
// Checksum 0x17cb55d, Offset: 0x1048
// Size: 0xa0
function function_9ac87975ff32122c()
{
    var_cc9dbb3fbaaec44e = utility::getstruct( "s_tunnels_mine_obj_interrogation" );
    interact = interaction::register_interact( var_cc9dbb3fbaaec44e.origin, 64, &function_f79abfa63da5d13a, &"sat_ob_story_missions_gemini/interact_door" );
    interact setusableenabled( 1 );
    interact setusepriority( 0 );
    interact sethintdisplayrange( 384 );
    interact setusefov( 120 );
    interact sethintdisplayfov( 120 );
    interact setcursorhint( "HINT_BUTTON" );
    interact setuseholdduration( "duration_medium" );
    interact setuserange( 64 );
    interact.interact_use_range = 64;
}

// Namespace namespace_f77971aa36d1d3d7
// Params 1, eflags: 0x4
// Checksum 0x288378a6, Offset: 0x10f0
// Size: 0x2a
function private function_f79abfa63da5d13a( player )
{
    level.teleport_initiator = player;
    waitframe();
    utility::flag_set( "flag_tunnels_pit_complete" );
    self delete();
}

/#

    // Namespace namespace_f77971aa36d1d3d7
    // Params 0
    // Checksum 0xcc839269, Offset: 0x1122
    // Size: 0x5, Type: dev
    function function_d17e65506d4163c9()
    {
        
    }

#/

// Namespace namespace_f77971aa36d1d3d7
// Params 1, eflags: 0x4
// Checksum 0x717b512c, Offset: 0x112f
// Size: 0x352
function private function_ed6e40bd47b81064( player )
{
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    player childthread gemini_util::function_57180a47f178d6d6( "trig_tunnels_mine_gate_03_begin", "flag_trig_tunnels_mine_gate_03_begin" );
    player childthread gemini_util::function_57180a47f178d6d6( "trig_tunnels_mine_gate_03_progress_04", "flag_trig_tunnels_mine_gate_03_progress_04" );
    
    foreach ( obj_id in activity_instance.a_obj_id )
    {
        objective_removeclientfrommask( obj_id, player );
    }
    
    if ( !player.player_objective )
    {
        player.player_objective = spawnstruct();
    }
    
    activity_instance namespace_b451b5202140ccde::function_dac15947c2d451e9( [ player ] );
    waitframe();
    activity_instance namespace_b451b5202140ccde::function_d3aa02fc5d62637d( "OB_GEMINI_TUNNELS_MINE_ESCAPE", [ player ] );
    player.player_objective.obj_id = gemini_util::function_70fecc661764c00a( "s_obj_tunnels_mine_06", player, 16, undefined, undefined, "active" );
    player utility::ent_flag_wait( "flag_trig_tunnels_mine_gate_03_begin" );
    ob_story_mission_utils::objective_marker_clear( player.player_objective.obj_id );
    waitframe();
    player.player_objective.obj_id = gemini_util::function_70fecc661764c00a( "s_obj_tunnels_mine_07", player, 16, undefined, undefined, "active" );
    player utility::ent_flag_wait( "flag_trig_tunnels_mine_gate_03_progress_04" );
    ob_story_mission_utils::objective_marker_clear( player.player_objective.obj_id );
    waitframe();
    e_tunnels_mine_gate_03 = gemini_util::get_scriptable( "e_tunnels_mine_gate_03" );
    
    foreach ( interact in e_tunnels_mine_gate_03.a_gate_interact )
    {
        activity_instance childthread function_ba405f841f07954f( interact, player );
    }
    
    level utility::flag_wait( "flag_tunnels_mine_gate_03_unstick" );
    player.player_objective.obj_id = gemini_util::function_70fecc661764c00a( "s_obj_tunnels_mine_08", player, 16, undefined, undefined, "active" );
    player utility::ent_flag_wait( "flag_ent_tunnels_mine_gate_03_complete" );
    ob_story_mission_utils::objective_marker_clear( player.player_objective.obj_id );
    waitframe();
    activity_instance namespace_b451b5202140ccde::function_dac15947c2d451e9( [ player ] );
    waitframe();
    activity_instance namespace_b451b5202140ccde::function_d3aa02fc5d62637d( "OB_GEMINI_TUNNELS_MINE_CONFRONTATION", [ player ] );
    player.player_objective.obj_id = gemini_util::function_70fecc661764c00a( "s_tunnels_mine_obj_interrogation", player, 16, "targetname", "sat_ob_objectivemarker_storymissionmain" );
    level utility::flag_wait( "flag_tunnels_pit_complete" );
    ob_story_mission_utils::objective_text_clear();
    ob_story_mission_utils::objective_marker_clear( player.player_objective.obj_id );
}

// Namespace namespace_f77971aa36d1d3d7
// Params 2, eflags: 0x4
// Checksum 0x4a44f6d, Offset: 0x1489
// Size: 0x84
function private function_ba405f841f07954f( interact, player )
{
    activity_instance = self;
    
    if ( !isdefined( interact ) )
    {
        return;
    }
    
    if ( interact getscriptablepartstate( "base" ) != "console_on" )
    {
        obj_id = gemini_util::function_70fecc661764c00a( interact.origin, player, 68, undefined, "sat_ob_objectivemarker_storymissionmain" );
        player childthread function_7189ee581228d9f2( obj_id );
        interact waittill( #"hash_93d4ae4acdfc3ef5" );
        ob_story_mission_utils::objective_marker_clear( obj_id );
    }
}

// Namespace namespace_f77971aa36d1d3d7
// Params 1, eflags: 0x4
// Checksum 0xb6df62fc, Offset: 0x1515
// Size: 0x3c
function private function_7189ee581228d9f2( obj_id )
{
    player = self;
    player waittill( #"death_or_disconnect" );
    
    if ( !objidpoolmanager::function_fb05d646a96ed99e( obj_id ) )
    {
        objidpoolmanager::returnobjectiveid( obj_id );
    }
}

// Namespace namespace_f77971aa36d1d3d7
// Params 1, eflags: 0x4
// Checksum 0x459fd89a, Offset: 0x1559
// Size: 0xb7
function private function_9dbcf5b93b30b52a( params )
{
    player = self;
    
    if ( level.var_3ce1f8d9700aaa07 )
    {
        switch ( level.var_3ce1f8d9700aaa07 )
        {
            case #"hash_999095664b8c7abc":
                player utility::ent_flag_set( "flag_ent_tunnels_mine_gate_03_complete" );
            case #"hash_999096664b8c7c4f":
                player utility::ent_flag_set( "flag_trig_tunnels_mine_gate_03_progress_04" );
            case #"hash_998da7664b8a587b":
            case #"hash_999091664b8c7470":
            case #"hash_999093664b8c7796":
            case #"hash_999094664b8c7929":
                player utility::ent_flag_set( "flag_trig_tunnels_mine_gate_03_begin" );
            default:
                break;
        }
    }
}

// Namespace namespace_f77971aa36d1d3d7
// Params 0, eflags: 0x4
// Checksum 0x70e4e22d, Offset: 0x1618
// Size: 0x5b
function private function_7d3411eb18c9fb08()
{
    level endon( #"game_ended" );
    trig = getent( "trig_tunnels_pit_oob", #targetname );
    
    if ( !isdefined( trig ) )
    {
        return;
    }
    
    outofbounds::function_ea64b5c2bd16e0f5( trig );
    level utility::flag_wait( "flag_tunnels_pit_complete" );
    outofbounds::function_73faa310ef29036a( trig );
    waitframe();
    trig delete();
}

/#

    // Namespace namespace_f77971aa36d1d3d7
    // Params 0
    // Checksum 0xbe92b3fb, Offset: 0x167b
    // Size: 0x5, Type: dev
    function function_1e1ed293334e7f78()
    {
        
    }

#/

// Namespace namespace_f77971aa36d1d3d7
// Params 1
// Checksum 0x210b4c40, Offset: 0x1688
// Size: 0x1c2
function function_9f0709b1c1444716( struct_targetname )
{
    level endon( #"game_ended", #"flag_tunnels_pit_complete" );
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    var_c83e094645149e62 = utility::getstruct( struct_targetname, "targetname" );
    
    if ( !isdefined( var_c83e094645149e62 ) )
    {
        return;
    }
    
    requestid = activity_instance activity_ai_encounters::function_306a1676777f93e2( "enc_vol_pit_zombie_player_flood" );
    
    if ( !isdefined( requestid ) )
    {
        return;
    }
    
    var_c83e094645149e62.requestid = activity_instance activity_ai_encounters::function_92b671064b0b1ce2( "enc_vol_pit_zombie_player_flood", 0, 1, 1, 1 );
    activity_ai_encounters::function_52d1342183200a8f( var_c83e094645149e62.requestid, &namespace_b109f7cb70e0649d::function_abca723e2719e60 );
    activity_ai_encounters::function_dcf6bdb6ee9d1ca0( var_c83e094645149e62.requestid, &function_1e8a0fce4e081433, var_c83e094645149e62 );
    activity_ai_encounters::function_d33de057e760c97b( var_c83e094645149e62.requestid, &function_9360998f308ed1f5, var_c83e094645149e62 );
    activity_ai_encounters::function_48582991402cac50( var_c83e094645149e62.requestid, 1 );
    var_c83e094645149e62.a_players = ob_story_mission_utils::get_playing_players( 1 );
    
    if ( var_c83e094645149e62.a_players.size < 3 || level.is_squad_size_small )
    {
        n_max_alive_count = 3;
    }
    else
    {
        n_max_alive_count = 5;
    }
    
    function_bbd192652d1a9e18( var_c83e094645149e62.requestid, n_max_alive_count );
    function_a748fd0f51127844( var_c83e094645149e62.requestid, 3 );
    waitframe();
    activity_instance thread gemini_util::function_a8d4d78033f6456d( var_c83e094645149e62.requestid, var_c83e094645149e62.origin, "flag_trig_tunnels_mine_gate_02_complete" );
    level utility::flag_wait( "flag_trig_tunnels_mine_gate_03_complete" );
    
    if ( isdefined( var_c83e094645149e62.requestid ) )
    {
        ai_spawn_director::cancel_spawn_request( var_c83e094645149e62.requestid, 0, 1 );
    }
}

// Namespace namespace_f77971aa36d1d3d7
// Params 2
// Checksum 0x15dd7d8d, Offset: 0x1852
// Size: 0x28, Type: bool
function function_1e8a0fce4e081433( requestid, userdata )
{
    if ( level utility::flag( "flag_trig_tunnels_mine_gate_03_progress_01" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_f77971aa36d1d3d7
// Params 2
// Checksum 0xda9bcdde, Offset: 0x1883
// Size: 0x35, Type: bool
function function_9360998f308ed1f5( requestid, userdata )
{
    if ( level utility::flag( "flag_trig_tunnels_mine_gate_03_progress_01" ) )
    {
        /#
            iprintlnbold( "<dev string:xa8>" );
        #/
        
        return true;
    }
    
    return false;
}

// Namespace namespace_f77971aa36d1d3d7
// Params 0
// Checksum 0xc565b88e, Offset: 0x18c1
// Size: 0x5e
function function_c866812d3b464808()
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    trig = getent( "trig_tunnels_mine_final_hallway", #targetname );
    createnavbadplacebyent( trig, "team_two_hundred", "team_hundred_ninety" );
}

