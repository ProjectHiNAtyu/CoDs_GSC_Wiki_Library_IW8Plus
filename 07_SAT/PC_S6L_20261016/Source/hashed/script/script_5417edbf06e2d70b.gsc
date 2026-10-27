// script_5417edbf06e2d70b  (hash_5417edbf06e2d70b.gscc) (size: 5767 Bytes / 0x1687 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2e17f8bb (773322939)
// size ...... 5767 (0x1687)
// includes .. 13  (offset: 0x14e3)
// strings ... 20  (offset: 0x154b)
// dev strs .. 1   (offset: 0x1677)
// exports ... 16  (offset: 0xb87)
// cseg ...... 0x26a + 0x91d (0xb87)
// imports ... 60  (offset: 0xe07)
// animtree1 . 0   (offset: 0x1687)
// animtree2 . 0   (offset: 0x1687)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\hud_util;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\interaction;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_util;
#using scripts\mp\snd\snd_ob;

#namespace namespace_debc83c5256fe721;

/#

    // Namespace namespace_debc83c5256fe721
    // Params 0
    // Checksum 0xe156e87f, Offset: 0x288
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_debc83c5256fe721
// Params 0, eflags: 0x5
// Checksum 0x5950dc6, Offset: 0x295
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_c0fa4b82e568b164", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_debc83c5256fe721
// Params 0, eflags: 0x4
// Checksum 0x3202ff6d, Offset: 0x2be
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LEO_JUNGLE_MANSION";
    activity_common::registeractivitytype( "OB_LEO_JUNGLE_MANSION", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LEO_JUNGLE_MANSION", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LEO_JUNGLE_MANSION", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LEO_JUNGLE_MANSION", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_LEO_JUNGLE_MANSION" );
}

// Namespace namespace_debc83c5256fe721
// Params 0
// Checksum 0xd5f62232, Offset: 0x335
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance jungle_mansion_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_debc83c5256fe721
// Params 0
// Checksum 0x33d611de, Offset: 0x39a
// Size: 0x47
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    level.request_ids = [];
    activity_instance thread jungle_mansion_main();
}

// Namespace namespace_debc83c5256fe721
// Params 0
// Checksum 0x7c617380, Offset: 0x3e9
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_debc83c5256fe721
// Params 1
// Checksum 0x4d49464, Offset: 0x40d
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread player_setup( player );
    }
}

/#

    // Namespace namespace_debc83c5256fe721
    // Params 0
    // Checksum 0xa6ec4c6f, Offset: 0x4c9
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_debc83c5256fe721
// Params 1
// Checksum 0x91513495, Offset: 0x4d6
// Size: 0x1e
function player_setup( player )
{
    player thread ob_story_mission_utils::function_a1cd17816bae5f6();
    player thread ob_story_mission_utils::refill_super_mega_jump();
}

// Namespace namespace_debc83c5256fe721
// Params 0
// Checksum 0x52e70237, Offset: 0x4fc
// Size: 0x90
function jungle_mansion_start()
{
    level thread mp_sat_ob_leo_util::function_46c7dd890b4e2bbb();
    level thread mp_sat_ob_leo_util::function_3c8a17513e90ef86();
    utility::exploder( "leo_nic_rocks_falling" );
    mp_sat_ob_leo_util::function_7ef23a62d6556750();
    ob_story_mission_utils::objective_text_show( %"hash_4194f104fb0af16c" );
    struct = utility::getstruct( "jungle_village_obj_marker_end", "targetname" );
    self.var_8029d4363972e15 = ob_story_mission_utils::function_b9cb179f9577f32a( struct.origin + ( 0, 0, 16 ), undefined, undefined, "sat_ob_objectivemarker_storymissionmain" );
    jungle_mansion_scene( 1 );
    thread jungle_mansion_interact();
}

// Namespace namespace_debc83c5256fe721
// Params 0
// Checksum 0x9166ab26, Offset: 0x594
// Size: 0x53
function jungle_mansion_interact()
{
    struct = utility::getstruct( "jungle_village_obj_marker_end", "targetname" );
    struct.interact = interaction::register_interact( struct.origin, 64, &function_3bb7121643cbda72, &"sat_ob_story_missions/leo_interact_open_gate", undefined, undefined, undefined, "HINT_BUTTON" );
}

// Namespace namespace_debc83c5256fe721
// Params 1
// Checksum 0xda3c8b11, Offset: 0x5ef
// Size: 0x41
function function_3bb7121643cbda72( player )
{
    level utility::flag_set( "flag_jungle_mansion_courtyard_gate_interacted_with" );
    level notify( #"hash_5c9dae018fffee1f" );
    self makeunusable();
    
    if ( isdefined( self ) )
    {
        self delete();
    }
    
    level.var_a0fee1447220b47b = player;
}

// Namespace namespace_debc83c5256fe721
// Params 0
// Checksum 0x99f16253, Offset: 0x638
// Size: 0xfb
function jungle_mansion_main()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( !level utility::flag( "jungle_village_complete" ) )
    {
        level utility::flag_wait( "flag_jungle_mansion_courtyard_gate_interacted_with" );
    }
    
    coop::function_164d95b45992525( { #var_ba7c3b8fa9d3823:level.var_a0fee1447220b47b } );
    level notify( #"hash_204e5b1988c774ad" );
    jungle_village_cradle_wall = getent( "jungle_village_cradle_wall", #targetname );
    
    if ( isdefined( jungle_village_cradle_wall ) )
    {
        jungle_village_cradle_wall delete();
    }
    
    level thread snd_ob::function_70013396bb42f6cc( level.players, "scene_nic_face_to_face" );
    level utility::flag_set( "flag_nm_mansion_scene" );
    jungle_mansion_scene( 0 );
    level utility::flag_set( "jungle_mansion_complete" );
    level utility::flag_set( "machete_covernode_cleanup" );
    level thread snd_ob::function_52bc8194809997e8( level.players, "scene_nic_face_to_face" );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_debc83c5256fe721
// Params 1
// Checksum 0x9fe31427, Offset: 0x73b
// Size: 0x1e5
function jungle_mansion_scene( prestream )
{
    scene_struct = utility::getstruct( "scene_nic_face_to_face", "targetname" );
    
    if ( !isdefined( scene_struct ) )
    {
        if ( !prestream )
        {
            jungle_mansion_cinematic();
        }
        
        return;
    }
    
    var_3fa2b369f2b1df90 = arrayremove( scene_struct scene::get_shot_names(), "init" );
    entities = [ level.var_77e9f36a18ae5ee1, level.var_326edda0c9842ec2 ];
    
    if ( prestream )
    {
        scene_struct utility::delaythread( 0.1, &scene::pre_stream, entities, var_3fa2b369f2b1df90, -1 );
        return;
    }
    
    mp_sat_ob_leo_util::function_f20a9fe6c594f5b3( 1 );
    activity_name = "OB_LEO_JUNGLE_MANSION_DEFEND";
    a_spawn_points = getspawnarray( "mp_ob_spawn_start" );
    a_s_start = [];
    
    foreach ( spawn_point in a_spawn_points )
    {
        if ( spawn_point.script_noteworthy == activity_name )
        {
            a_s_start[ a_s_start.size ] = spawn_point;
        }
    }
    
    a_s_start = arrayrandomize( a_s_start );
    
    if ( a_s_start.size == 0 )
    {
        /#
            iprintln( "<dev string:x24>" );
        #/
        
        return;
    }
    
    coop::teleport_players( level.players, a_s_start );
    
    if ( !ob::nightmare() )
    {
        scene_struct scene::play( entities, var_3fa2b369f2b1df90 );
    }
    else
    {
        scene_struct scene::play( entities, var_3fa2b369f2b1df90, "scene_sat_wc_s2_cin_nic_face_to_face" );
    }
    
    ents = scene_struct scene::get_entities();
    scene_struct scene::cleanup( 1 );
    utility::array_delete( ents );
    scene_struct thread scene::play( undefined, "init" );
    mp_sat_ob_leo_util::function_f20a9fe6c594f5b3( 0 );
}

// Namespace namespace_debc83c5256fe721
// Params 0
// Checksum 0xbf930f94, Offset: 0x928
// Size: 0x25f
function jungle_mansion_cinematic()
{
    level notify( #"hash_204e5b1988c774ad" );
    
    foreach ( player in level.players )
    {
        player thread hud_util::fade_out( 1, "black" );
    }
    
    wait 1;
    mp_sat_ob_leo_util::function_f20a9fe6c594f5b3( 1 );
    iprintlnbold( "IGC HERE WITH MENENDEZ REVEAL" );
    wait 3;
    activity_name = "OB_LEO_JUNGLE_MANSION_DEFEND";
    a_spawn_points = getspawnarray( "mp_ob_spawn_start" );
    a_s_start = [];
    
    foreach ( spawn_point in a_spawn_points )
    {
        if ( spawn_point.script_noteworthy == activity_name )
        {
            a_s_start[ a_s_start.size ] = spawn_point;
        }
    }
    
    a_s_start = arrayrandomize( a_s_start );
    
    if ( a_s_start.size == 0 )
    {
        /#
            iprintln( "<dev string:x24>" );
        #/
        
        return;
    }
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        level.players[ i ] setorigin( a_s_start[ i ].origin + ( 0, 0, 32 ) );
        level.players[ i ] setplayerangles( a_s_start[ i ].angles );
    }
    
    foreach ( player in level.players )
    {
        player thread hud_util::fade_in( 0.5, "black" );
    }
    
    mp_sat_ob_leo_util::function_f20a9fe6c594f5b3( 0 );
}

