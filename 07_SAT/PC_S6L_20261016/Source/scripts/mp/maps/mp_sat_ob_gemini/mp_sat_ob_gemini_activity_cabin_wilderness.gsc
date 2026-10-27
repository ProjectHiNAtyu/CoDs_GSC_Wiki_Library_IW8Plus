// scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_activity_cabin_wilderness.gsc  (hash_4e5b5344a4b82e68.gscc) (size: 5702 Bytes / 0x1646 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3a30d518 (976278808)
// size ...... 5702 (0x1646)
// includes .. 14  (offset: 0x148e)
// strings ... 21  (offset: 0x14fe)
// dev strs .. 0   (offset: 0x1646)
// exports ... 18  (offset: 0xaf2)
// cseg ...... 0x30a + 0x7e8 (0xaf2)
// imports ... 60  (offset: 0xdc2)
// animtree1 . 0   (offset: 0x1646)
// animtree2 . 0   (offset: 0x1646)
#using script_2399696a9d953451;
#using script_636bd827a012af12;
#using script_66878054d141dbc0;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_activity_cabin_initialmemory;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_scenes;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_util;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_vo;

#namespace namespace_663317432f7e4e4b;

// Namespace namespace_663317432f7e4e4b
// Params 0, eflags: 0x5
// Checksum 0x647fd551, Offset: 0x328
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_5f0aaa43a407713e", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_663317432f7e4e4b
// Params 0, eflags: 0x4
// Checksum 0x38135607, Offset: 0x351
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_GEMINI_CABIN_WILDERNESS";
    activity_common::registeractivitytype( "OB_GEMINI_CABIN_WILDERNESS", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_CABIN_WILDERNESS", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_CABIN_WILDERNESS", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_CABIN_WILDERNESS", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_GEMINI_CABIN_WILDERNESS" );
}

// Namespace namespace_663317432f7e4e4b
// Params 0
// Checksum 0x91e56520, Offset: 0x3c8
// Size: 0x59
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance cabin_wilderness_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_663317432f7e4e4b
// Params 0
// Checksum 0xa44dd3aa, Offset: 0x429
// Size: 0x39
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance cabin_wilderness_main();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_663317432f7e4e4b
// Params 0
// Checksum 0x7670daea, Offset: 0x46a
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_663317432f7e4e4b
// Params 1
// Checksum 0x29c7b979, Offset: 0x48e
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread cabin_wilderness_player_setup( player );
    }
}

/#

    // Namespace namespace_663317432f7e4e4b
    // Params 0
    // Checksum 0x38c59acb, Offset: 0x54a
    // Size: 0x5, Type: dev
    function function_4022db360dfbbb46()
    {
        
    }

#/

// Namespace namespace_663317432f7e4e4b
// Params 0
// Checksum 0x97650e46, Offset: 0x557
// Size: 0x16
function cabin_wilderness_start()
{
    activity_instance = self;
    gemini_util::function_dfcbf5f9b3b2e6a0();
}

// Namespace namespace_663317432f7e4e4b
// Params 0
// Checksum 0x4717b1aa, Offset: 0x575
// Size: 0x121
function cabin_wilderness_main()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    level.var_d53163b0ef2a4488 = 1;
    level utility::flag_clear( "FLAG_CABIN_WILDERNESS_CABIN_APPROACHED_1" );
    level utility::flag_clear( "FLAG_CABIN_WILDERNESS_CABIN_APPROACHED_2" );
    level utility::flag_clear( "FLAG_CABIN_WILDERNESS_CABIN_APPROACHED_4" );
    activity_instance childthread function_ffd1a9d21c7096a7();
    activity_instance childthread gemini_vo::function_815ede11868205();
    level thread gemini_util::function_178de2439c77b626();
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_cabin_pickups_equipment_wilderness", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1, undefined, 0.5, 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_cabin_pickups_weapon_wilderness", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1 );
    
    if ( !level.is_squad_size_small )
    {
        activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_cabin_pickups_equipment_wilderness_large", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1, undefined, 0.5, 1 );
        activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_cabin_pickups_weapon_wilderness_large", "OB_GEMINI_CABIN_BARRAGE_COMPLETE", 1 );
    }
    
    activity_instance thread namespace_60d9b3cbf41663fe::function_b4dbb2fd9f18d56f();
    activity_instance thread namespace_60d9b3cbf41663fe::function_ec29754525c1de62();
    activity_instance thread function_1e76c8520c9d8942();
    activity_instance thread namespace_59d718ab43872b7e::function_64d4548f43edbd35( 0 );
    activity_instance utility::flag_wait( "OB_GEMINI_CABIN_WILDERNESS_COMPLETE" );
}

// Namespace namespace_663317432f7e4e4b
// Params 1
// Checksum 0xf9d6800c, Offset: 0x69e
// Size: 0x43
function cabin_wilderness_player_setup( player )
{
    activity_instance = self;
    player thread function_7d4fd5871b105b22();
    player thread cabin_wilderness_player_prestream();
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
    }
}

// Namespace namespace_663317432f7e4e4b
// Params 0
// Checksum 0x9195f459, Offset: 0x6e9
// Size: 0x68
function cabin_wilderness_player_prestream()
{
    player = self;
    level utility::flag_wait( "scriptables_ready" );
    scriptables = getentitylessscriptablearray( "gemini_jailbreak", #script_noteworthy );
    
    if ( scriptables.size > 0 && isdefined( scriptables[ 0 ].origin ) )
    {
        player utility::player_prestream_camera_wait( scriptables[ 0 ].origin );
    }
}

// Namespace namespace_663317432f7e4e4b
// Params 0
// Checksum 0xf5017a65, Offset: 0x759
// Size: 0xd1
function function_7d4fd5871b105b22()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    player_utility::function_99d180c3f0ca93b8( self, "player_soundveil_shake_reduced_mp", 2 );
    var_1d38d06d1b0dc98 = 2;
    emp_debuff::play_emp_scramble( var_1d38d06d1b0dc98 );
    earthquake( 0.1, 3, self.origin, 512 );
    gemini_util::function_1cdd28af12b71f9c( 15, 0 );
    pbgpostfxbundlestart( self, %"sat_cradle_ambient_stage_flash" );
    wait 0.1;
    level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "medium", 4.5, undefined, [ self ] );
    wait 1.5;
    thread gemini_util::player_fov_restore( 6 );
    var_1d38d06d1b0dc98 = 1;
    emp_debuff::play_emp_scramble( var_1d38d06d1b0dc98 );
    wait 3;
    player_utility::function_c14762bb6e0b4edb( self );
    emp_debuff::stop_emp_scramble( var_1d38d06d1b0dc98 );
    waitframe();
    emp_debuff::clear_emp_scramble();
}

/#

    // Namespace namespace_663317432f7e4e4b
    // Params 0
    // Checksum 0x56fa4405, Offset: 0x832
    // Size: 0x5, Type: dev
    function function_5b993500f9d015c3()
    {
        
    }

#/

// Namespace namespace_663317432f7e4e4b
// Params 0
// Checksum 0x669f3355, Offset: 0x83f
// Size: 0x46
function function_1e76c8520c9d8942()
{
    activity_instance = self;
    level endon( #"game_ended", #"OB_GEMINI_CABIN_WILDERNESS_COMPLETE" );
    activity_instance childthread function_68eda58be007dc79();
    level utility::flag_wait( "flag_cabin_wilderness_players_entered_cabin" );
    utility::flag_set( "OB_GEMINI_CABIN_WILDERNESS_COMPLETE" );
}

// Namespace namespace_663317432f7e4e4b
// Params 0, eflags: 0x4
// Checksum 0x1915aed2, Offset: 0x88d
// Size: 0x1c1
function private function_68eda58be007dc79()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended", #"OB_GEMINI_CABIN_BARRAGE_COMPLETE" );
    trig = getnoentvolumearray( "cabin_interior_trigger", #targetname )[ 0 ];
    
    while ( true )
    {
        a_players = ob_story_mission_utils::get_playing_players();
        a_players_inside = [];
        
        foreach ( player in a_players )
        {
            if ( !isalive( player ) )
            {
                waitframe();
                continue;
            }
            
            if ( player istouching( trig ) )
            {
                if ( !player utility::ent_flag_exist( "flag_cabin_player_inside" ) || !player utility::ent_flag( "flag_cabin_player_inside" ) )
                {
                    player utility::ent_flag_set( "flag_cabin_player_inside" );
                }
                
                a_players_inside = arraycombineunique( a_players_inside, [ player ] );
            }
            else if ( player utility::ent_flag_exist( "flag_cabin_player_inside" ) && player utility::ent_flag( "flag_cabin_player_inside" ) )
            {
                player utility::ent_flag_clear( "flag_cabin_player_inside" );
            }
            
            waitframe();
        }
        
        if ( a_players_inside.size > 0 && !level utility::flag( "flag_cabin_wilderness_players_entered_cabin" ) )
        {
            level utility::flag_set( "flag_cabin_wilderness_players_entered_cabin" );
        }
        else if ( a_players_inside.size == 0 && level utility::flag( "flag_cabin_wilderness_players_entered_cabin" ) )
        {
            level utility::flag_clear( "flag_cabin_wilderness_players_entered_cabin" );
        }
        
        wait 0.5;
    }
}

/#

    // Namespace namespace_663317432f7e4e4b
    // Params 0
    // Checksum 0x2123f66f, Offset: 0xa56
    // Size: 0x5, Type: dev
    function function_9f0d481c5c980756()
    {
        
    }

#/

// Namespace namespace_663317432f7e4e4b
// Params 0, eflags: 0x4
// Checksum 0x4f9b7f20, Offset: 0xa63
// Size: 0x8f
function private function_ffd1a9d21c7096a7()
{
    activity_instance = self;
    ob_story_mission_utils::objective_text_show( "OB_GEMINI_CABIN_WILDERNESS_APPROACH" );
    mission_ui::function_759924b87215156b( 0, 1, level.players );
    s_obj_cabin = utility::getstruct( "cabin_wilderness_obj_struct", "targetname" );
    activity_instance.obj_circle = ob_story_mission_utils::function_ab06e28322870f4( s_obj_cabin.origin, s_obj_cabin.radius );
    level utility::flag_wait( "flag_cabin_wilderness_players_entered_cabin" );
    ob_story_mission_utils::function_352aa3aab98a0618( activity_instance.obj_circle );
}

