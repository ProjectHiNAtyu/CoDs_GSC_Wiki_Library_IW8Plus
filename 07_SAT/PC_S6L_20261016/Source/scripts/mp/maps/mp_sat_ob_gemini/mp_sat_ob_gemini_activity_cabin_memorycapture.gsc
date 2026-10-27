// scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_activity_cabin_memorycapture.gsc  (hash_0dbd474a43121919.gscc) (size: 8857 Bytes / 0x2299 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd323f4b3 (3542348979)
// size ...... 8857 (0x2299)
// includes .. 14  (offset: 0x1fcd)
// strings ... 38  (offset: 0x203d)
// dev strs .. 0   (offset: 0x2299)
// exports ... 23  (offset: 0x13c9)
// cseg ...... 0x4f5 + 0xed4 (0x13c9)
// imports ... 73  (offset: 0x1761)
// animtree1 . 0   (offset: 0x2299)
// animtree2 . 0   (offset: 0x2299)
#using script_2399696a9d953451;
#using script_4c1e16e1162d066f;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_exclusion_zone;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_scenes;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_util;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_vo;
#using scripts\mp\ob\contracts\ob_contract_ui_widget;

#namespace mp_sat_ob_gemini_activity_cabin_memorycapture;

// Namespace mp_sat_ob_gemini_activity_cabin_memorycapture
// Params 0, eflags: 0x5
// Checksum 0xe4b8a4f5, Offset: 0x513
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_eb5ca2d9c5a01c65", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace mp_sat_ob_gemini_activity_cabin_memorycapture
// Params 0, eflags: 0x4
// Checksum 0x86ecdf94, Offset: 0x53c
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_GEMINI_CABIN_MEMORYCAPTURE";
    activity_common::registeractivitytype( "OB_GEMINI_CABIN_MEMORYCAPTURE", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_CABIN_MEMORYCAPTURE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_CABIN_MEMORYCAPTURE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_CABIN_MEMORYCAPTURE", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_GEMINI_CABIN_MEMORYCAPTURE" );
}

// Namespace mp_sat_ob_gemini_activity_cabin_memorycapture
// Params 0
// Checksum 0x4d456e33, Offset: 0x5b3
// Size: 0x59
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance cabin_memorycapture_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace mp_sat_ob_gemini_activity_cabin_memorycapture
// Params 0
// Checksum 0x5daff430, Offset: 0x614
// Size: 0x39
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance cabin_memorycapture_main();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace mp_sat_ob_gemini_activity_cabin_memorycapture
// Params 0
// Checksum 0xc88f5379, Offset: 0x655
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace mp_sat_ob_gemini_activity_cabin_memorycapture
// Params 1
// Checksum 0xf9209361, Offset: 0x679
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread cabin_memorycapture_player_setup( player );
    }
}

/#

    // Namespace mp_sat_ob_gemini_activity_cabin_memorycapture
    // Params 0
    // Checksum 0x71e7ab97, Offset: 0x735
    // Size: 0x5, Type: dev
    function function_4455d07f6ba2dde()
    {
        
    }

#/

// Namespace mp_sat_ob_gemini_activity_cabin_memorycapture
// Params 0
// Checksum 0xe35466fe, Offset: 0x742
// Size: 0x167
function cabin_memorycapture_start()
{
    activity_instance = self;
    activity_instance thread namespace_60d9b3cbf41663fe::function_b4dbb2fd9f18d56f();
    activity_instance thread namespace_60d9b3cbf41663fe::function_21c9e40d5c20c5da();
    gemini_util::function_34a3d0cff5de2d7d();
    gemini_util::function_dfcbf5f9b3b2e6a0();
    level ob_adz::function_86ebf122bc776db5( 1 );
    level.var_e07082c4f4aa4a97 = ob_adz::function_47e86714392d46b4( "cabin_center_struct", 2450, 1 );
    activity_instance thread gemini_util::function_fe0b04783865b1e7( level.var_e07082c4f4aa4a97 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_cabin_pickups_equipment_wilderness", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1, undefined, 0.5, 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_cabin_pickups_weapon_wilderness", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1 );
    
    if ( !level.is_squad_size_small )
    {
        activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_cabin_pickups_equipment_wilderness_large", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1, undefined, 0.5, 1 );
        activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_cabin_pickups_weapon_wilderness_large", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1 );
    }
    
    a_structs = utility::getstructarray( "gemini_p2_adz_safety_teleport", "targetname" );
    
    foreach ( player in level.players )
    {
        player thread gemini_util::function_7da3d7491a75f0a8( a_structs );
    }
}

// Namespace mp_sat_ob_gemini_activity_cabin_memorycapture
// Params 0
// Checksum 0x620997d3, Offset: 0x8b1
// Size: 0x27c
function cabin_memorycapture_main()
{
    activity_instance = self;
    level.activity_instance = activity_instance;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    
    if ( isdefined( level.current_capture_zone ) )
    {
        level.current_capture_zone = undefined;
    }
    
    level.var_d53163b0ef2a4488 = 1;
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_cabin_pickups_equipment_initialmcz", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1, undefined, 0.5, 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_cabin_pickups_weapon_initialmcz", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1, undefined, 0.5, 1 );
    
    if ( !level.is_squad_size_small )
    {
        activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_cabin_pickups_equipment_initialmcz_large", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1, undefined, 0.5, 1 );
        activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_cabin_pickups_weapon_initialmcz_large", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1, undefined, 0.5, 1 );
    }
    
    activity_instance childthread gemini_vo::function_5bb64bf965c57cc8();
    activity_instance namespace_b451b5202140ccde::function_bb923ce693c606f9( %"hash_24217f6a5756791f", level.players );
    activity_instance mission_ui::function_759924b87215156b( 1, 1, level.players );
    activity_instance mission_ui::function_d84701041f6f95c2( 1, 100, 100, level.players );
    level utility::flag_wait( "flag_cabin_memorycapture_memories_appear" );
    level thread ob_adz::function_f94c18166de9f51d( level.var_e07082c4f4aa4a97.zone_id, undefined, 2450, 10 );
    exclusioncircle = level.exclusionzones[ level.var_e07082c4f4aa4a97.var_e0dd4b03666cb7e8 ];
    exclusioncircle thread exclusion_zones::function_a1a887e23f767ba0( ( 4900, 4900, 0 ), 10 );
    activity_instance thread function_5fb81ce79a5788c2();
    level.capture_zone_dock = activity_instance gemini_util::init_cabin_mcz( "mcz_woods", "OB_GEMINI_CABIN_MEMORYCAPTURE_COMPLETE", undefined, undefined, 0, undefined, undefined, "ring_dock", 2 );
    level.capture_zone_basement = activity_instance gemini_util::init_cabin_mcz( "mcz_basement", "OB_GEMINI_CABIN_MEMORYCAPTURE_COMPLETE", undefined, undefined, 0, undefined, undefined, "ring_standard", 1 );
    level.capture_zone_tree = activity_instance gemini_util::init_cabin_mcz( "mcz_cliffs", "OB_GEMINI_CABIN_MEMORYCAPTURE_COMPLETE", undefined, undefined, 0, undefined, undefined, "ring_large", 3 );
    activity_instance thread gemini_util::function_a9376b156b863dd4( "trig_cabin_basement_vermin_vent", "OB_GEMINI_CABIN_MEMORYCAPTURE_COMPLETE" );
    activity_instance childthread function_d2f035a4f66f99fc();
    activity_instance utility::flag_wait( "OB_GEMINI_CABIN_MEMORYCAPTURE_COMPLETE" );
    var_399a0f97e8cb8e0b = utility::getstruct( "cabin_center_struct", "targetname" );
    activity_instance thread gemini_util::function_b95c324c7b2d9f63( var_399a0f97e8cb8e0b.origin, 8000, 0.1 );
}

// Namespace mp_sat_ob_gemini_activity_cabin_memorycapture
// Params 1
// Checksum 0x281c0661, Offset: 0xb35
// Size: 0x31
function cabin_memorycapture_player_setup( player )
{
    activity_instance = self;
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
    }
}

/#

    // Namespace mp_sat_ob_gemini_activity_cabin_memorycapture
    // Params 0
    // Checksum 0xfb5ea229, Offset: 0xb6e
    // Size: 0x5, Type: dev
    function function_b41c23892d9c5d7e()
    {
        
    }

#/

// Namespace mp_sat_ob_gemini_activity_cabin_memorycapture
// Params 0
// Checksum 0x9afffcd6, Offset: 0xb7b
// Size: 0x114
function function_5fb81ce79a5788c2()
{
    activity_instance = self;
    activity_instance.var_ef530193c27d0ea8 = [];
    activity_instance.var_68982e4ddedd7153 = ai_spawn_director::lookup_spawn_request( "mcz_wide_floodfill" );
    function_ef57f478f96b050c( activity_instance.var_68982e4ddedd7153, 1 );
    ai_spawn_director::add_spawned_callback( activity_instance.var_68982e4ddedd7153, &function_bab57c63461b7800, activity_instance );
    ai_spawn_director::function_c99d360d62c49a9c( activity_instance.var_68982e4ddedd7153, &function_6f70b8b329f5d227, activity_instance );
    ai_spawn_director::function_53289c032f506bb1( activity_instance.var_68982e4ddedd7153, &function_7214306eaf8dcbdc, activity_instance );
    
    if ( level.is_squad_size_small )
    {
        activity_instance.var_881c17c854c8f86c = 1;
    }
    else
    {
        activity_instance.var_881c17c854c8f86c = 2;
    }
    
    activity_instance childthread function_5828bbe529bf1c3b();
    activity_instance childthread function_41bc15b5319670ea();
    
    while ( !utility::flag( "OB_GEMINI_CABIN_MEMORYCAPTURE_COMPLETE" ) )
    {
        function_bbd192652d1a9e18( activity_instance.var_68982e4ddedd7153, activity_instance.var_881c17c854c8f86c );
        activity_instance waittill( #"capture_zone_completed" );
        activity_instance.var_881c17c854c8f86c++;
    }
}

// Namespace mp_sat_ob_gemini_activity_cabin_memorycapture
// Params 2, eflags: 0x4
// Checksum 0xb8c9752, Offset: 0xc97
// Size: 0x2b
function private function_6f70b8b329f5d227( requestid, userdata )
{
    if ( userdata.var_6f70b8b329f5d227 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace mp_sat_ob_gemini_activity_cabin_memorycapture
// Params 2, eflags: 0x4
// Checksum 0x84c2fb4, Offset: 0xcca
// Size: 0x2b
function private function_7214306eaf8dcbdc( requestid, userdata )
{
    if ( utility::flag( "OB_GEMINI_CABIN_MEMORYCAPTURE_COMPLETE" ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace mp_sat_ob_gemini_activity_cabin_memorycapture
// Params 4, eflags: 0x4
// Checksum 0xc6bcd1ff, Offset: 0xcfd
// Size: 0x96
function private function_bab57c63461b7800( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    userdata.var_6f70b8b329f5d227 = 0;
    var_399a0f97e8cb8e0b = utility::getstruct( "cabin_center_struct", "targetname" );
    agent function_fa32376aaa88a7a2( var_399a0f97e8cb8e0b.origin, 5280 );
    agent gemini_util::function_daf8afa8f377f24();
    userdata.var_ef530193c27d0ea8[ userdata.var_ef530193c27d0ea8.size ] = agent;
}

// Namespace mp_sat_ob_gemini_activity_cabin_memorycapture
// Params 0, eflags: 0x4
// Checksum 0x3750ff24, Offset: 0xd9b
// Size: 0xa2
function private function_5828bbe529bf1c3b()
{
    activity_instance = self;
    activity_instance endon( #"OB_GEMINI_CABIN_MEMORYCAPTURE_COMPLETE" );
    spawn_cadence = 20;
    
    while ( !utility::flag( "OB_GEMINI_CABIN_MEMORYCAPTURE_COMPLETE" ) )
    {
        activity_instance.var_ef530193c27d0ea8 = utility::array_removedead_or_dying( activity_instance.var_ef530193c27d0ea8 );
        
        if ( activity_instance.var_45c517f01a6fa02e || activity_instance.var_ef530193c27d0ea8.size == activity_instance.var_881c17c854c8f86c )
        {
            activity_instance.var_6f70b8b329f5d227 = 0;
        }
        else
        {
            activity_instance.var_6f70b8b329f5d227 = 1;
        }
        
        wait spawn_cadence;
    }
}

// Namespace mp_sat_ob_gemini_activity_cabin_memorycapture
// Params 0
// Checksum 0x9a3f2546, Offset: 0xe45
// Size: 0x79
function function_41bc15b5319670ea()
{
    activity_instance = self;
    activity_instance endon( #"OB_GEMINI_CABIN_MEMORYCAPTURE_COMPLETE" );
    
    while ( !utility::flag( "OB_GEMINI_CABIN_MEMORYCAPTURE_COMPLETE" ) )
    {
        msg = activity_instance utility::waittill_notify_or_timeout_return( "capture_zone_checkpoint_reached", 30 );
        
        if ( msg == "capture_zone_checkpoint_reached" )
        {
            activity_instance.var_45c517f01a6fa02e = 1;
        }
        else
        {
            activity_instance.var_45c517f01a6fa02e = 0;
        }
        
        wait 1;
    }
}

/#

    // Namespace mp_sat_ob_gemini_activity_cabin_memorycapture
    // Params 0
    // Checksum 0x6bd38666, Offset: 0xec6
    // Size: 0x5, Type: dev
    function function_d17e65506d4163c9()
    {
        
    }

#/

// Namespace mp_sat_ob_gemini_activity_cabin_memorycapture
// Params 0, eflags: 0x4
// Checksum 0xa7b69d7e, Offset: 0xed3
// Size: 0x1af
function private function_d2f035a4f66f99fc()
{
    activity_instance = self;
    s_mcz_woods = utility::getstruct( "mcz_woods", "targetname" );
    s_mcz_cliffs = utility::getstruct( "mcz_cliffs", "targetname" );
    s_mcz_basement = utility::getstruct( "mcz_basement", "targetname" );
    scriptable_mcz_cliffs_interact = getscriptablearray( "mcz_cliffs_interact", #targetname )[ 0 ];
    scriptable_mcz_woods_interact = getscriptablearray( "mcz_woods_interact", #targetname )[ 0 ];
    scriptable_mcz_basement_interact = getscriptablearray( "mcz_basement_interact", #targetname )[ 0 ];
    activity_instance childthread function_386a08358d790754( s_mcz_woods, scriptable_mcz_woods_interact, "OB_GEMINI_MCZ_CHECKPOINT_WOODS_START" );
    activity_instance childthread function_386a08358d790754( s_mcz_cliffs, scriptable_mcz_cliffs_interact, "OB_GEMINI_MCZ_CHECKPOINT_CLIFFS_START" );
    activity_instance childthread function_386a08358d790754( s_mcz_basement, scriptable_mcz_basement_interact, "OB_GEMINI_MCZ_CHECKPOINT_BASEMENT_START" );
    activity_instance childthread function_4c5131498cb1bbd5();
    missionasset = %"hash_59fff7468f58b9e6";
    options = spawnstruct();
    options.step = 0;
    options.var_cf684f09b6c37c3a = 3;
    options.var_e866adf65a6cef87 = 100;
    options.a_end_flag = [ "OB_GEMINI_MCZ_CHECKPOINT_BASEMENT_COMPLETE", "OB_GEMINI_MCZ_CHECKPOINT_WOODS_COMPLETE", "OB_GEMINI_MCZ_CHECKPOINT_CLIFFS_COMPLETE" ];
    a_capture_zone = [ level.capture_zone_basement, level.capture_zone_dock, level.capture_zone_tree ];
    activity_instance thread gemini_util::function_44166e34e7081b17( a_capture_zone, missionasset, level.players, options, "OB_GEMINI_CABIN_MEMORYCAPTURE_COMPLETE" );
}

// Namespace mp_sat_ob_gemini_activity_cabin_memorycapture
// Params 3, eflags: 0x4
// Checksum 0xeb03bc4b, Offset: 0x108a
// Size: 0xa6
function private function_386a08358d790754( s_mcz, var_9e472a4bc3193fdb, var_25f402cd3aa64c2e )
{
    activity_instance = self;
    
    if ( !s_mcz || !var_9e472a4bc3193fdb || !var_25f402cd3aa64c2e || s_mcz.complete )
    {
        return;
    }
    
    obj_circle = ob_story_mission_utils::function_ab06e28322870f4( s_mcz.origin, 550 );
    function_5ae5649ceb802a7a( s_mcz );
    ob_story_mission_utils::function_352aa3aab98a0618( obj_circle );
    obj_id = gemini_util::function_7a621dc87829fa67( var_9e472a4bc3193fdb, 32 );
    level utility::flag_wait( var_25f402cd3aa64c2e );
    ob_story_mission_utils::objective_marker_clear( obj_id );
}

// Namespace mp_sat_ob_gemini_activity_cabin_memorycapture
// Params 1, eflags: 0x4
// Checksum 0x78342958, Offset: 0x1138
// Size: 0xf5
function private function_5ae5649ceb802a7a( s_mcz )
{
    activity_instance = self;
    
    if ( s_mcz.targetname != "mcz_basement" )
    {
        activity_instance endon( #"hash_5968acee2850a4fb" );
    }
    
    if ( s_mcz.targetname == "mcz_basement" )
    {
        var_7f71f1b3869ea2e2 = getent( "mcz_basement_trigger", #targetname );
        
        if ( var_7f71f1b3869ea2e2 )
        {
            var_7f71f1b3869ea2e2 waittill( #"trigger", player );
            activity_instance notify( #"hash_8fce0749c03e4365", player );
            level utility::flag_set( "flag_cabin_memorycapture_basement_found" );
            return;
        }
    }
    
    while ( true )
    {
        a_players_in_circle = function_6a293b884c444a20( level.players, s_mcz.origin, s_mcz.radius );
        
        if ( a_players_in_circle.size > 0 )
        {
            activity_instance notify( #"hash_8fce0749c03e4365", a_players_in_circle[ 0 ] );
            break;
        }
        
        waitframe();
    }
}

// Namespace mp_sat_ob_gemini_activity_cabin_memorycapture
// Params 0, eflags: 0x4
// Checksum 0x7327ec1, Offset: 0x1235
// Size: 0x194
function private function_4c5131498cb1bbd5()
{
    activity_instance = self;
    
    while ( activity_instance.var_30371edbcd339720 <= 1 )
    {
        waitframe();
    }
    
    activity_instance notify( #"hash_5968acee2850a4fb" );
    wait 60;
    
    if ( !utility::flag( "flag_cabin_memorycapture_basement_found" ) )
    {
        activity_instance childthread gemini_vo::function_51732a1c6b668a11();
        structs = utility::getstructarray( "cabin_basement_entrance", "targetname" );
        
        if ( !structs )
        {
            return;
        }
        
        activity_instance.obj_ids = [];
        
        foreach ( struct in structs )
        {
            obj_id = gemini_util::function_70fecc661764c00a( struct, undefined, undefined, undefined, undefined, "active" );
            activity_instance.obj_ids[ activity_instance.obj_ids.size ] = obj_id;
        }
        
        utility::flag_wait( "flag_cabin_memorycapture_basement_found" );
        
        foreach ( obj_id in activity_instance.obj_ids )
        {
            ob_story_mission_utils::objective_marker_clear( obj_id );
        }
    }
}

