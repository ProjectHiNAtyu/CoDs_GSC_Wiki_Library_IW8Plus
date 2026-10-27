// script_447f379c9d266b96  (hash_447f379c9d266b96.gscc) (size: 9097 Bytes / 0x2389 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x477d1110 (1199378704)
// size ...... 9097 (0x2389)
// includes .. 21  (offset: 0x2009)
// strings ... 52  (offset: 0x20b1)
// dev strs .. 0   (offset: 0x2389)
// exports ... 24  (offset: 0x1345)
// cseg ...... 0x635 + 0xd10 (0x1345)
// imports ... 76  (offset: 0x1705)
// animtree1 . 0   (offset: 0x2389)
// animtree2 . 0   (offset: 0x2389)
#using script_1369f66fa8958a74;
#using script_60cd1c57e94be8d7;
#using script_636bd827a012af12;
#using script_c445446891e2e86;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_progress_tracking;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\waypoint_objective_handler;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\interaction;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_audio;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_util;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_vo;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\snd\snd_ob;

#namespace namespace_97b5b8dc02c7f9b2;

/#

    // Namespace namespace_97b5b8dc02c7f9b2
    // Params 0
    // Checksum 0xc6fef6ec, Offset: 0x653
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_97b5b8dc02c7f9b2
// Params 0, eflags: 0x5
// Checksum 0xeefd65e2, Offset: 0x660
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_d9bf800911d18b05", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_97b5b8dc02c7f9b2
// Params 0, eflags: 0x4
// Checksum 0x15aae1fe, Offset: 0x689
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LEO_FACILITY_MACGUFFIN_CORE";
    activity_common::registeractivitytype( "OB_LEO_FACILITY_MACGUFFIN_CORE", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LEO_FACILITY_MACGUFFIN_CORE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LEO_FACILITY_MACGUFFIN_CORE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LEO_FACILITY_MACGUFFIN_CORE", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_LEO_FACILITY_MACGUFFIN_CORE" );
}

// Namespace namespace_97b5b8dc02c7f9b2
// Params 0
// Checksum 0x3b6d141b, Offset: 0x700
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance facility_macguffin_core_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_97b5b8dc02c7f9b2
// Params 0
// Checksum 0xf718bbb, Offset: 0x765
// Size: 0x3d
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    activity_instance thread facility_macguffin_core_main();
}

// Namespace namespace_97b5b8dc02c7f9b2
// Params 0
// Checksum 0x5bc96d13, Offset: 0x7aa
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_97b5b8dc02c7f9b2
// Params 1
// Checksum 0x1b05c621, Offset: 0x7ce
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

    // Namespace namespace_97b5b8dc02c7f9b2
    // Params 0
    // Checksum 0x814452fc, Offset: 0x88a
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_97b5b8dc02c7f9b2
// Params 1
// Checksum 0xe28baf3a, Offset: 0x897
// Size: 0x19
function player_setup( player )
{
    activity_instance = self;
}

// Namespace namespace_97b5b8dc02c7f9b2
// Params 0
// Checksum 0x6c5e571a, Offset: 0x8b8
// Size: 0x9b
function facility_macguffin_core_start()
{
    thread mp_sat_ob_leo_util::function_96b32ff9e4b0fc4c();
    thread mp_sat_ob_leo_util::function_d2eaefb295692571();
    thread namespace_fc92da645acfbbdc::function_1b86168fadcfb49d();
    mp_sat_ob_leo_util::unlock_door( "central_to_lower_atrium_door" );
    mp_sat_ob_leo_util::unlock_door( "central_to_junction_door" );
    mp_sat_ob_leo_util::unlock_door( "junction_to_central_door" );
    mp_sat_ob_leo_util::turn_off_force_field( "presentation_ff", "targetname", 1 );
    mp_sat_ob_leo_util::turn_off_force_field( "quantum_computer_ff", "targetname", 1 );
    level utility::flag_set( "facility_macguffin_item_ready" );
    thread namespace_5f9a6cbc0f6e9aac::qc_bots();
    thread ob_story_mission_utils::item_spawn_weapon( "s_facility_macguffin_weapon", "facility_to_jungle_complete", 1 );
    thread ob_story_mission_utils::item_spawn_equipment( "s_facility_macguffin_equipment", "facility_to_jungle_complete", 1 );
}

// Namespace namespace_97b5b8dc02c7f9b2
// Params 0
// Checksum 0xe7eb023f, Offset: 0x95b
// Size: 0x54
function facility_macguffin_core_main()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    level thread mp_sat_ob_leo_vo::facility_macguffin_core_vo();
    thread facility_macguffin_core_objectives();
    thread facility_macguffin_core_encounters();
    level utility::flag_wait( "facility_macguffin_core_explosives_planted" );
    level utility::flag_set( "facility_macguffin_core_complete" );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_97b5b8dc02c7f9b2
// Params 0
// Checksum 0x67330279, Offset: 0x9b7
// Size: 0x35e
function facility_macguffin_core_objectives()
{
    level.macguffin_core_activity = self;
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    ob_story_mission_utils::objective_text_show( %"hash_55fde58c2a2b319f" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "quantum_hatch_struct", undefined, "", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 16 ) );
    interact_struct = utility::getstruct( "quantum_hatch_struct", "script_noteworthy" );
    level utility::flag_wait( "facility_macguffin_item_ready" );
    interact = interaction::register_interact( interact_struct.origin, 64, &function_8025f9b7dcc10133, &"sat_ob_story_missions/leo_interact_take", undefined, undefined, undefined, "HINT_BUTTON" );
    interact.activity_instance = self;
    level utility::flag_wait( "facility_macguffin_core_item_acquired" );
    waypoint_objective_handler::waypoint_objective_handler_cancel( "quantum_hatch_struct" );
    wait 1;
    ob_story_mission_utils::objective_text_show( %"hash_60a27c7d47197c69" );
    level utility::flag_wait( "flag_qc_guild_bots_dead" );
    wait 1;
    level utility::flag_set( "facility_macguffin_core_start_plant" );
    ob_story_mission_utils::objective_text_show( %"hash_731a8ac21a66b951" );
    self.var_1019f53cb44ccf2d = [];
    self.var_1019f53cb44ccf2d = utility::getstructarray( "facility_macguffin_explosives_interact", "targetname" );
    flag_array = [];
    count = 0;
    level.explosives_planted = 0;
    
    foreach ( struct in self.var_1019f53cb44ccf2d )
    {
        struct.var_8029d4363972e15 = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_objectivemarker_storymissionmain", 0, 1 );
        objidpoolmanager::update_objective_position( struct.var_8029d4363972e15, struct.origin + ( 0, 0, 16 ) );
        struct thread function_322efc2b8fe3bfd2();
        struct.flag = "flag_" + struct.script_noteworthy + count;
        flag_array[ flag_array.size ] = struct.flag;
        struct.interact = interaction::register_interact( struct.origin, 64, &on_facility_macguffin_explosives_interact, &"sat_ob_story_missions/leo_interact_plant", undefined, undefined, undefined, "HINT_BUTTON" );
        struct.interact.activity_instance = self;
        struct.interact.script_noteworthy = struct.script_noteworthy;
        count++;
    }
    
    while ( true )
    {
        ret = utility::flag_wait_any_array_return( flag_array );
        
        if ( isdefined( ret ) )
        {
            flag_array = arrayremove( flag_array, ret );
            i = int( removesubstr( ret, "flag_facility_macguffin_explosives_interact" ) );
            var_8029d4363972e15 = self.var_1019f53cb44ccf2d[ i ].var_8029d4363972e15;
            ob_story_mission_utils::function_315d79883d962ba7( level.explosives_planted, 4 );
            
            if ( flag_array.size == 0 )
            {
                break;
            }
        }
        
        waitframe();
    }
    
    wait 0.5;
    mp_sat_ob_leo_util::unlock_door( "junction_to_macguffin_door" );
    level utility::flag_set( "facility_macguffin_core_explosives_planted" );
}

// Namespace namespace_97b5b8dc02c7f9b2
// Params 0
// Checksum 0x772858b0, Offset: 0xd1d
// Size: 0x28
function function_322efc2b8fe3bfd2()
{
    level waittill( self.script_noteworthy );
    level.macguffin_core_activity namespace_d7fa4530141146a5::function_501e44ea1cb9219d( self.var_8029d4363972e15 );
}

// Namespace namespace_97b5b8dc02c7f9b2
// Params 1
// Checksum 0xbca7a670, Offset: 0xd4d
// Size: 0x101
function function_8025f9b7dcc10133( player )
{
    self makeunusable();
    level utility::flag_set( "facility_macguffin_core_interacted_with" );
    hatch = getent( "quantum_hatch", "targetname" );
    hatch.animname = "hatch";
    chip = getent( "quantum_chip", "targetname" );
    chip.animname = "chip";
    thread swap_quantum_core_button();
    scene_sat_cin_leo_quantum_core = utility::getstruct( "scene_sat_cin_leo_quantum_core", "targetname" );
    
    if ( isdefined( scene_sat_cin_leo_quantum_core ) )
    {
        snd_ob::function_70013396bb42f6cc( [ player ], "scene_sat_cin_leo_quantum_core" );
        scene_sat_cin_leo_quantum_core scene::play( [ player, hatch, chip ] );
        snd_ob::function_52bc8194809997e8( [ player ], "scene_sat_cin_leo_quantum_core" );
    }
    
    level utility::flag_set( "facility_macguffin_core_item_acquired" );
    
    if ( isdefined( chip ) )
    {
        chip delete();
    }
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace namespace_97b5b8dc02c7f9b2
// Params 0
// Checksum 0xa91219d0, Offset: 0xe56
// Size: 0x2b
function swap_quantum_core_button()
{
    button = getent( "quantum_core_button", "targetname" );
    wait 2;
    button setmodel( "sat_leo_electronics_quantumn_pc_controller_on" );
}

// Namespace namespace_97b5b8dc02c7f9b2
// Params 1
// Checksum 0xfb2ab351, Offset: 0xe89
// Size: 0x18c
function on_facility_macguffin_explosives_interact( player )
{
    foreach ( struct in self.activity_instance.var_1019f53cb44ccf2d )
    {
        if ( struct.interact == self )
        {
            self makeunusable();
            level notify( self.script_noteworthy );
            scene_struct = utility::getstruct( struct.script_noteworthy, "targetname" );
            player val::set( "c4_plant", "damage", 0 );
            scene_struct scene::play( player );
            player val::reset_all( "c4_plant" );
            level.explosives_planted++;
            level utility::flag_set( struct.flag );
            
            if ( level.explosives_planted == 1 )
            {
                level utility::flag_set( "flag_quantum_one_explosive_planted" );
            }
            
            if ( level.explosives_planted == 2 )
            {
                level utility::flag_set( "flag_quantum_two_explosives_planted" );
            }
            
            if ( level.explosives_planted == 3 )
            {
                level utility::flag_set( "flag_quantum_three_explosives_planted" );
            }
            
            if ( level.explosives_planted == 4 )
            {
                level utility::flag_set( "flag_quantum_all_explosives_planted" );
            }
            
            if ( isdefined( self ) )
            {
                self delete();
            }
        }
    }
}

// Namespace namespace_97b5b8dc02c7f9b2
// Params 0
// Checksum 0xefee7216, Offset: 0x101d
// Size: 0x1a
function delete_later()
{
    level utility::flag_wait( "facility_cradle_complete" );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace namespace_97b5b8dc02c7f9b2
// Params 0
// Checksum 0xb184498, Offset: 0x103f
// Size: 0x105
function facility_macguffin_core_encounters()
{
    level utility::flag_wait( "facility_macguffin_core_item_acquired" );
    level utility::flag_set( "facility_macguffin_core_encounter_start" );
    level thread alarm_sounds();
    level utility::flag_wait( "flag_quantum_two_explosives_planted" );
    level.var_86b4f924b6d54f57 = [];
    level.enc_facility_macguffin_core = activity_ai_encounters::function_92b671064b0b1ce2( "encounter_facility_macguffin_core", 1, 1, 1, 2 );
    function_ef57f478f96b050c( level.enc_facility_macguffin_core, 1 );
    activity_ai_encounters::function_6bf4ff2fbde584ee( level.enc_facility_macguffin_core, &function_c884b57b217ef1da );
    ai_spawn_director::add_spawned_callback( level.enc_facility_macguffin_core, &macguffin_core_spawn_func );
    ai_spawn_director::function_a49c35b72d6b6fea( level.enc_facility_macguffin_core, &function_76f7b94542d2db89 );
    level utility::flag_wait( "flag_macguffin_core_enemies_spawned" );
    mp_sat_ob_leo_util::unlock_door( "qc_2nd_floor" );
    mp_sat_ob_leo_util::unlock_door( "qc_3rd_floor" );
    mp_sat_ob_leo_util::unlock_door( "macguffin_to_junction_door" );
    thread leo_audio::function_5e92f369f16985e0();
    activity_progress_tracking::function_82d854bb84c20512( "atrium_kill_progress_tracker", level.var_86b4f924b6d54f57, &function_5882cb401234ee7a );
    level utility::flag_wait( "facility_macguffin_core_complete" );
}

// Namespace namespace_97b5b8dc02c7f9b2
// Params 0
// Checksum 0x3f3f48ff, Offset: 0x114c
// Size: 0x3a
function alarm_sounds()
{
    for ( tick = 0; tick < 6 ; tick++ )
    {
        playsoundatpos( ( 14830, -4273, -4590 ), "amb_emt_security_alarm_1" );
        wait 1.5;
    }
}

// Namespace namespace_97b5b8dc02c7f9b2
// Params 3
// Checksum 0x623f8ad9, Offset: 0x118e
// Size: 0x2b
function function_c884b57b217ef1da( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_macguffin_core_enemies_spawned" );
}

// Namespace namespace_97b5b8dc02c7f9b2
// Params 4
// Checksum 0x442e3595, Offset: 0x11c1
// Size: 0x3e
function macguffin_core_spawn_func( requestid, instance, agent, ai_data )
{
    level.var_86b4f924b6d54f57[ level.var_86b4f924b6d54f57.size ] = agent;
}

// Namespace namespace_97b5b8dc02c7f9b2
// Params 3
// Checksum 0xb82c6ccd, Offset: 0x1207
// Size: 0x45
function function_76f7b94542d2db89( requestid, userdata, shutdowndata )
{
    level utility::flag_set( "flag_macguffin_core_encounter_done" );
    iprintln( "macguffin_core encounter complete!" );
    ai_spawn_director::cancel_spawn_request( level.enc_facility_macguffin_core );
}

// Namespace namespace_97b5b8dc02c7f9b2
// Params 3
// Checksum 0x3e868d26, Offset: 0x1254
// Size: 0xf1
function function_5882cb401234ee7a( requestid, activity_instance, agent )
{
    level.var_86b4f924b6d54f57 = utility::array_removedead_or_dying( level.var_86b4f924b6d54f57 );
    
    if ( level.var_86b4f924b6d54f57.size < 4 )
    {
        iprintln( "enemies retreat / rush player" );
        
        foreach ( agent in level.var_86b4f924b6d54f57 )
        {
            players = ob_story_mission_utils::get_playing_players();
            closest_player = function_47c86977a18df38b( players, agent.origin );
            
            if ( isdefined( closest_player ) )
            {
                agent setgoalentity( closest_player );
            }
        }
    }
}

