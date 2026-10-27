// script_22a69f24da598f4f  (hash_22a69f24da598f4f.gscc) (size: 4377 Bytes / 0x1119 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9a6f7838 (2590996536)
// size ...... 4377 (0x1119)
// includes .. 11  (offset: 0xfb9)
// strings ... 19  (offset: 0x1011)
// dev strs .. 0   (offset: 0x1119)
// exports ... 14  (offset: 0x8c5)
// cseg ...... 0x207 + 0x6be (0x8c5)
// imports ... 42  (offset: 0xaf5)
// animtree1 . 0   (offset: 0x1119)
// animtree2 . 0   (offset: 0x1119)
#using script_1369f66fa8958a74;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director_utility;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\coop;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_util;

#namespace namespace_a658d83bd32cf09b;

/#

    // Namespace namespace_a658d83bd32cf09b
    // Params 0
    // Checksum 0x1715ffc5, Offset: 0x225
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_a658d83bd32cf09b
// Params 0, eflags: 0x5
// Checksum 0xd961f826, Offset: 0x232
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_ead223853fc9c790", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_a658d83bd32cf09b
// Params 0, eflags: 0x4
// Checksum 0xc441e8d7, Offset: 0x25b
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LEO_FACILITY_CRADLE";
    activity_common::registeractivitytype( "OB_LEO_FACILITY_CRADLE", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LEO_FACILITY_CRADLE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LEO_FACILITY_CRADLE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LEO_FACILITY_CRADLE", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_LEO_FACILITY_CRADLE" );
}

// Namespace namespace_a658d83bd32cf09b
// Params 0
// Checksum 0x2326f863, Offset: 0x2d2
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance facility_cradle_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_a658d83bd32cf09b
// Params 0
// Checksum 0x2b975ab, Offset: 0x337
// Size: 0x3d
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    activity_instance thread facility_cradle_main();
}

// Namespace namespace_a658d83bd32cf09b
// Params 0
// Checksum 0x8a22643a, Offset: 0x37c
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_a658d83bd32cf09b
// Params 1
// Checksum 0x2811770, Offset: 0x3a0
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

    // Namespace namespace_a658d83bd32cf09b
    // Params 0
    // Checksum 0x50af5bd5, Offset: 0x45c
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_a658d83bd32cf09b
// Params 1
// Checksum 0x3360a613, Offset: 0x469
// Size: 0x19
function player_setup( player )
{
    activity_instance = self;
}

// Namespace namespace_a658d83bd32cf09b
// Params 0
// Checksum 0x836caf06, Offset: 0x48a
// Size: 0x49
function facility_cradle_start()
{
    thread mp_sat_ob_leo_util::function_96b32ff9e4b0fc4c();
    thread mp_sat_ob_leo_util::function_d2eaefb295692571();
    thread namespace_fc92da645acfbbdc::function_1b86168fadcfb49d();
    mp_sat_ob_leo_util::unlock_door( "central_to_lower_atrium_door" );
    mp_sat_ob_leo_util::turn_off_force_field( "presentation_ff", "targetname", 1 );
    mp_sat_ob_leo_util::turn_off_force_field( "quantum_computer_ff", "targetname", 1 );
}

// Namespace namespace_a658d83bd32cf09b
// Params 0
// Checksum 0x1ee81dd0, Offset: 0x4db
// Size: 0x1b5
function facility_cradle_main()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    if ( !level utility::flag( "facility_escape_1_complete" ) )
    {
        struct = utility::getstruct( "facility_cradle_interact" );
        prompt = gameobjects::createhintobject( struct.origin, "HINT_BUTTON", undefined, &"mp_dmz_locks/unlock_door" );
        prompt waittill( #"trigger" );
        prompt delete();
    }
    
    cradle_cinematic();
    thread mp_sat_ob_leo_util::function_5bc972408ebad07a();
    thread mp_sat_ob_leo_util::function_81942b7272d9ec15();
    level utility::flag_set( "facility_cradle_complete" );
    activity_instance_common::endactivity( self, 1 );
    
    if ( !isdefined( level._ai_group[ self.script_aigroup ] ) )
    {
        return [];
    }
    
    ai_labs2 = ai_spawn_director::get_ai_group_ai( "ai_labs2" );
    allguys = arraycombine( ai_labs2, level.var_86b4f924b6d54f57 );
    
    foreach ( guy in allguys )
    {
        if ( isalive( guy ) )
        {
            guy.death_source = "despawn";
            guy.nocorpse = 1;
            guy.var_a13bed1ac47e1b2c = 1;
            guy.dropweapon = 0;
            guy.nodrop = 1;
            guy agent_utils::despawnagent();
        }
    }
}

// Namespace namespace_a658d83bd32cf09b
// Params 0
// Checksum 0x40e907c5, Offset: 0x698
// Size: 0x1f0
function cradle_cinematic()
{
    level utility::flag_set( "flag_leo_cradle_cinematic_start" );
    activity_name = "OB_LEO_FACILITY_ESCAPE_2";
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
    
    if ( getdvarint( @"hash_3281ead04b48dd20" ) == 1 || !coop::should_play_igcs() )
    {
        coop::teleport_players( level.players, a_s_start );
        return;
    }
    
    cradle_doors = getentarray( "trapped_doors", "targetname" );
    
    foreach ( door in cradle_doors )
    {
        door.animname = door.script_noteworthy;
    }
    
    thread function_c1b94a1fb1d7cdcb();
    level utility::flag_set( "flag_leo_cradle_cinematic_start" );
    initiator_struct = utility::getstruct( "facility_cradle_interact" );
    coop::play_cinematic( "sat_leo_trapped", { #timeout:106, #var_ba7c3b8fa9d3823:initiator_struct, #structs:a_s_start } );
    level utility::flag_set( "flag_leo_cradle_cinematic_done" );
}

// Namespace namespace_a658d83bd32cf09b
// Params 0
// Checksum 0x8a3e2f7e, Offset: 0x890
// Size: 0x35
function function_c1b94a1fb1d7cdcb()
{
    glass_struct = utility::getstruct( "facility_cradle_glass" );
    wait 69.5;
    glassradiusdamage( glass_struct.origin, 100, 100, 100 );
}

