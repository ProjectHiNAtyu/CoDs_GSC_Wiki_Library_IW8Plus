// scripts\mp\ob\activities\ob_activity_heist.gsc  (hash_5cf116b14524051d.gscc) (size: 9721 Bytes / 0x25f9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1b3a03c9 (456786889)
// size ...... 9721 (0x25f9)
// includes .. 21  (offset: 0x2325)
// strings ... 30  (offset: 0x23cd)
// dev strs .. 10  (offset: 0x2579)
// exports ... 20  (offset: 0x1621)
// cseg ...... 0x2bc + 0x1365 (0x1621)
// imports ... 84  (offset: 0x1941)
// animtree1 . 0   (offset: 0x25f9)
// animtree2 . 0   (offset: 0x25f9)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\scriptable;
#using scripts\common\spatial_zone_container;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\interaction;
#using scripts\mp\ob\activities\ob_activity_crash_sites;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\contracts\ob_contract_ui_widget;
#using scripts\mp\ob\ob_interactions_util;
#using scripts\mp\ob\systems\ob_activity_manager;
#using scripts\mp\ob\systems\ob_music;
#using scripts\mp\ob\systems\ob_resource_manager;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\objidpoolmanager;

#namespace ob_activity_heist;

// Namespace ob_activity_heist
// Params 0, eflags: 0x5
// Checksum 0x42728e56, Offset: 0x2da
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_59eef5b3511df6f2", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_activity_heist
// Params 0, eflags: 0x4
// Checksum 0xcb1b2058, Offset: 0x303
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_HEIST", &heist_activity_type_init );
}

// Namespace ob_activity_heist
// Params 0
// Checksum 0x57bc26c6, Offset: 0x31e
// Size: 0xa0
function heist_activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_HEIST", 0, &heist_activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_HEIST", 1, &heist_activity_begin );
    activity_common::function_944074f3079c1d4e( "REV_OB_HEIST", 2, &heist_activity_end );
    activity_common::function_944074f3079c1d4e( "REV_OB_HEIST", 3, &heist_activity_destroy );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &function_2940a6b8c1cc6de, "REV_OB_HEIST" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &function_72c872e60c393aa9, "REV_OB_HEIST" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerAbandon", &function_b2dd36041299d0b9, "REV_OB_HEIST" );
    scriptable::scriptable_addusedcallbackbypart( "heist_computer_station_usable", &function_a5e5a8e5e605833 );
}

// Namespace ob_activity_heist
// Params 0
// Checksum 0x50a1f97a, Offset: 0x3c6
// Size: 0x150
function heist_activity_setup()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.location = activity_instance_common::function_776ee11e7acc64a5( self );
    self.var_37c8b9effa47207c = level.var_e607236b193eb0c1.var_5992a4946aeeca5a[ self.varianttag ].region;
    self.difficulty_region = region_difficulty_manager::function_f9fbb630598afdc7( self.location ).difficulty;
    namespace_b451b5202140ccde::function_3b7d5e996ba0c975( ob_activity_definition_utils::function_e55fda458ce2c4cc( self ), self.playerparticipants );
    level ob_music::function_859fd7ab75f367c2( self );
    spatial_zone_container::addspatialzone( self, "crash_site_clean_up_safety_zone" );
    waitframe();
    activityjoininteracts = level.activities.var_3a2ba6751c464ab7[ self.id ] ?? [];
    
    foreach ( joiner in activityjoininteracts )
    {
        joiner thread function_b42758c793aaee6( self );
    }
    
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace ob_activity_heist
// Params 1
// Checksum 0x24a379db, Offset: 0x51e
// Size: 0xe4
function function_b42758c793aaee6( activity_instance )
{
    activity_instance endon( #"ActivityBegin" );
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.joiner_trigger = spawn( "noent_volume_trigger_radius", self.origin, 0, 1000, 200 );
    noticed_players = [];
    
    while ( true )
    {
        activity_instance.joiner_trigger waittill( #"trigger", ent );
        
        if ( isplayer( ent ) && player::isreallyalive( ent ) )
        {
            squad_members_nearby = ent ob_activity_utility::function_468428fa3b477b54();
            broadcast_targets = arrayremove( squad_members_nearby, noticed_players );
            
            if ( broadcast_targets.size )
            {
                noticed_players = arraycombineunique( noticed_players, broadcast_targets );
                activity_instance thread ob_activity_utility::function_894ac80e038636c5( "wcpveheistbrief", broadcast_targets );
            }
        }
    }
}

// Namespace ob_activity_heist
// Params 0
// Checksum 0x982a81a2, Offset: 0x60a
// Size: 0x447
function heist_activity_begin()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    thread ob_activity_utility::function_894ac80e038636c5( "wcpveheistextract" );
    self.joiner_trigger delete();
    var_464875409387d7d0 = function_2d402f0fc5b7d0ca();
    terminal = var_464875409387d7d0.terminal;
    
    if ( !terminal )
    {
        assertmsg( "<dev string:x24>" + self.varianttag + "<dev string:x76>" );
        activity_instance_common::function_9aeeabe50fc9cc3e( self );
        return;
    }
    
    terminal setscriptablepartstate( #"heist_computer_station_usable", #"usable" );
    terminal interaction::set_interact_hint_callback( &function_3c3cccff81addd6f );
    terminal function_7653c765b6c7b815();
    
    foreach ( player in self.playerparticipants )
    {
        terminal enablescriptableplayeruse( player );
    }
    
    self.terminal = terminal;
    
    if ( !self.terminal.owner_activity )
    {
        assertmsg( "<dev string:x7b>" + self.varianttag + "<dev string:x76>" );
        activity_instance_common::function_9aeeabe50fc9cc3e( self );
        return;
    }
    
    activity_instance_common::function_c3911b0306ab7c81( self.terminal.owner_activity, "Any", "Cleanup" );
    level spatial_zone_container::function_847140d2863dfbf8( self, "music_awareness_zone", terminal.origin, 2500, 1 );
    ob_activity_crash_sites::crash_sites_setup( ob_activity_crash_sites::function_4eddd6fc9f54a1cf(), 0 );
    self.var_77dc5b8c6d44554d = function_6044ee1af5b60228( self.var_37c8b9effa47207c );
    
    if ( !self.var_77dc5b8c6d44554d )
    {
        assertmsg( "<dev string:xd2>" + self.varianttag + "<dev string:x76>" );
        activity_instance_common::function_9aeeabe50fc9cc3e( self );
        return;
    }
    
    self.var_8a6344d5141a40a2 = getnoentvolumearray( self.plane_crash_point.target, #targetname )[ 0 ];
    assert( isdefined( self.var_8a6344d5141a40a2 ), "<dev string:x124>" + "<dev string:x14c>" );
    self.var_cdc0e4d6d9288be8 = self.var_8a6344d5141a40a2.radius;
    level spatial_zone_container::function_847140d2863dfbf8( self, "crash_site_clean_up_safety_zone", self.plane_crash_point.origin, 4500, 1 );
    ob_activity_crash_sites::create_objective_marker( "sat_ob_objectivemarker_heist", 0, 1 );
    objidpoolmanager::update_objective_position( ob_activity_crash_sites::get_objid(), self.terminal.origin + ( 0, 0, 50 ) );
    objidpoolmanager::update_objective_description( ob_activity_crash_sites::get_objid(), &"sat_ob_activities/objective_terminal_heist" );
    thread ob_activity_crash_sites::crash_sites_begin();
    terminal waittill( #"terminal_hacked" );
    level spatial_zone_container::function_a16a7e6ae5875495( self, "music_awareness_zone" );
    thread ob_activity_utility::function_894ac80e038636c5( "wcpveheisthacksuccess" );
    namespace_b451b5202140ccde::function_33c02efd4a127b9e( 1, self.playerparticipants );
    crash_site_location = self.plane_crash_point.origin ?? self.black_box_struct.origin;
    level spatial_zone_container::function_847140d2863dfbf8( self, "music_awareness_zone", crash_site_location, 2500, 1 );
    objidpoolmanager::update_objective_position( ob_activity_crash_sites::get_objid(), crash_site_location + ( 0, 0, 50 ) );
    objidpoolmanager::update_objective_description( ob_activity_crash_sites::get_objid(), &"sat_ob_activities/objective_crash_site" );
    function_43dfaa3b60d4a6();
    
    if ( self.plane )
    {
        self.plane utility::ent_flag_set( "plane_begin_crash" );
    }
    
    self waittill( #"plane_crashed" );
    
    while ( !isdefined( self.progress ) )
    {
        wait 0.2;
    }
    
    thread ob_activity_utility::function_894ac80e038636c5( "wcpveheistdefend" );
    namespace_b451b5202140ccde::function_33c02efd4a127b9e( 2, self.playerparticipants );
    self waittill( #"hash_4c4ba1370b04f55f" );
    waitframe();
    thread ob_activity_utility::function_894ac80e038636c5( "wcpveheistsuccess", undefined, undefined, undefined, undefined, &function_7f96e19f991bcc71 );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace ob_activity_heist
// Params 1
// Checksum 0xd4ee2e0a, Offset: 0xa59
// Size: 0x2b
function function_7f96e19f991bcc71( var_73f4f05f29c6770a )
{
    if ( var_73f4f05f29c6770a == "wcpveheistsuccess_voss" )
    {
        return [ "wcpveheistclapback", "wcpveheistlastword" ];
    }
}

// Namespace ob_activity_heist
// Params 0
// Checksum 0xdb92157c, Offset: 0xa8d
// Size: 0x123
function function_43dfaa3b60d4a6()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    while ( true )
    {
        self.var_8a6344d5141a40a2 waittill( #"trigger", ent );
        
        if ( !isplayer( ent ) && !ent vehicle::is_vehicle() )
        {
            continue;
        }
        
        has_participant = arraycontains( self.playerparticipants, ent );
        
        if ( ent vehicle::is_vehicle() )
        {
            occupants = vehicle_occupancy::function_b6077e40739ebc4b( ent );
            
            foreach ( occupant in occupants )
            {
                if ( isplayer( occupant ) && arraycontains( self.playerparticipants, occupant ) )
                {
                    has_participant = 1;
                    break;
                }
            }
        }
        
        if ( has_participant )
        {
            return;
        }
    }
}

// Namespace ob_activity_heist
// Params 2
// Checksum 0xd35b264d, Offset: 0xbb8
// Size: 0xa4
function function_3c3cccff81addd6f( usable, player )
{
    if ( usable.var_1674515c4a4c0655.size )
    {
        if ( arraycontains( usable.var_1674515c4a4c0655, player ) )
        {
            return { #string:&"", #type:"HINT_NOICON" };
        }
        else
        {
            return { #string:&"sat_ob_activities/interaction_hacking_in_progress", #type:"HINT_NOBUTTON" };
        }
        
        return;
    }
    
    return { #string:&"sat_ob_activities/activity_heist_sky_control", #type:"HINT_NOICON" };
}

// Namespace ob_activity_heist
// Params 0
// Checksum 0x8162559, Offset: 0xc64
// Size: 0x383
function function_2d402f0fc5b7d0ca()
{
    activity_class = "Startup";
    activity_type = "REV_OB_QUARANTINE_ZONE";
    region = self.var_37c8b9effa47207c;
    best_candidate = undefined;
    var_1da035f1ec992705 = 1000;
    candidates_groups = [];
    activityinstances = level.var_e607236b193eb0c1.activityinstances[ activity_class ][ region.index ][ activity_type ];
    
    if ( activityinstances )
    {
        foreach ( activity_instance_info in activityinstances )
        {
            not_running = ob_activity_manager::function_b5bdbf846da577f( activity_instance_info, [] );
            real_activity_instance = level.activities.instances[ activity_instance_info.lastid ];
            
            if ( !not_running && real_activity_instance )
            {
                instance_state = real_activity_instance.state;
                
                if ( instance_state == "Active" )
                {
                    if ( !isdefined( candidates_groups[ 0 ] ) )
                    {
                        candidates_groups[ 0 ] = [];
                    }
                    
                    candidates_groups[ 0 ][ candidates_groups[ 0 ].size ] = real_activity_instance;
                }
                else
                {
                    if ( !isdefined( candidates_groups[ 3 ] ) )
                    {
                        candidates_groups[ 3 ] = [];
                    }
                    
                    candidates_groups[ 3 ][ candidates_groups[ 3 ].size ] = real_activity_instance;
                }
                
                continue;
            }
            
            var_b3f693aa93064491 = ob_activity_manager::function_714537ed7c463c8c( activity_instance_info, [] );
            
            if ( var_b3f693aa93064491 )
            {
                if ( !isdefined( candidates_groups[ 1 ] ) )
                {
                    candidates_groups[ 1 ] = [];
                }
                
                candidates_groups[ 1 ][ candidates_groups[ 1 ].size ] = activity_instance_info;
                continue;
            }
            
            if ( !isdefined( candidates_groups[ 2 ] ) )
            {
                candidates_groups[ 2 ] = [];
            }
            
            candidates_groups[ 2 ][ candidates_groups[ 2 ].size ] = activity_instance_info;
        }
    }
    
    for ( candidate_priority = 0; candidate_priority <= 3 ; candidate_priority++ )
    {
        candidates = candidates_groups[ candidate_priority ];
        
        if ( !candidates )
        {
            continue;
        }
        
        foreach ( candidate in candidates )
        {
            qzone_location = candidate.var_441d26d05f86b224 ?? candidate.centerpoint ?? activity_instance_common::function_776ee11e7acc64a5( candidate );
            distance = utility::function_3a444812a9926ec( self.location, qzone_location );
            
            if ( distance < var_1da035f1ec992705 )
            {
                var_1da035f1ec992705 = distance;
                best_candidate = candidate;
            }
        }
        
        if ( best_candidate )
        {
            break;
        }
    }
    
    if ( !activity_instance_common::isactivityinstance( best_candidate ) )
    {
        additional_spawn_data = {};
        additional_spawn_data.var_d9274cd4b9b9a361 = 1;
        additional_spawn_data.parent = self;
        additional_spawn_data.var_e206e40c465fa7bd = 1;
        
        if ( candidate_priority == 2 )
        {
            additional_spawn_data.var_2fd8956d4905e73 = 1;
        }
        
        return ob_activity_manager::ob_activity_instance_init( best_candidate, additional_spawn_data );
    }
    else
    {
        var_bb03486f3c742d9 = best_candidate.var_622af9ed9146813f.activityresources;
        ob_resource_manager::function_2948ca4364d60860( var_bb03486f3c742d9.var_9b8d447f054a4d70, var_bb03486f3c742d9.var_565837295b09914e, var_bb03486f3c742d9.var_70b4e90213acebe3 );
    }
    
    return best_candidate;
}

// Namespace ob_activity_heist
// Params 6
// Checksum 0x7849bc, Offset: 0xff0
// Size: 0x43
function function_a5e5a8e5e605833( instance, part, state, player, bautouse, usestring )
{
    instance thread function_25a1fe4c083a9804( player );
}

// Namespace ob_activity_heist
// Params 1, eflags: 0x4
// Checksum 0x8165d372, Offset: 0x103b
// Size: 0xb8
function private function_25a1fe4c083a9804( player )
{
    if ( self.var_1674515c4a4c0655.size )
    {
        return;
    }
    
    var_fab006cdb4f6e516 = ob_interactions_util::function_c7b5806740384a61( "earpiece_press_sat_ob", player, 5, self, 1, 1, 1, -1, "ClinkInteractions" );
    
    if ( !player || !self )
    {
        return;
    }
    
    if ( var_fab006cdb4f6e516 )
    {
        self notify( #"terminal_hacked" );
        utility::callsharedfunc( #"gametype", #"hash_6e7ad51030328c8e" );
        self setscriptablepartstate( #"heist_computer_station_usable", #"unusable" );
        
        if ( self.owner_activity )
        {
            activity_instance_common::function_32302285cf865c56( self.owner_activity, "Any", "Cleanup" );
        }
    }
}

// Namespace ob_activity_heist
// Params 0
// Checksum 0x93121534, Offset: 0x10fb
// Size: 0xd9
function heist_activity_end()
{
    level ob_music::function_be4c0727a998b18b( self );
    
    if ( self.terminal && self.terminal getscriptablepartstate( #"heist_computer_station_usable", 0, 1 ) == #"usable" )
    {
        self.terminal setscriptablepartstate( #"heist_computer_station_usable", #"unusable" );
        
        if ( self.terminal.owner_activity )
        {
            activity_instance_common::function_32302285cf865c56( self.terminal.owner_activity, "Any", "Cleanup" );
        }
    }
    
    if ( self.black_box )
    {
        self.black_box setscriptablepartstate( #"crash_sites_blackbox_hacking_effects", #"off" );
        self.black_box function_7653c765b6c7b815();
    }
    
    ob_activity_crash_sites::radio_data_cleanup();
}

// Namespace ob_activity_heist
// Params 0
// Checksum 0x55115304, Offset: 0x11dc
// Size: 0xa9
function heist_activity_destroy()
{
    level ob_music::function_be4c0727a998b18b( self );
    
    if ( self.terminal && self.terminal getscriptablepartstate( #"heist_computer_station_usable", 0, 1 ) == #"usable" )
    {
        self.terminal setscriptablepartstate( #"heist_computer_station_usable", #"unusable" );
        
        if ( self.terminal.owner_activity )
        {
            activity_instance_common::function_32302285cf865c56( self.terminal.owner_activity, "Any", "Cleanup" );
        }
    }
    
    ob_activity_crash_sites::crash_sites_destroy();
    self.var_8a6344d5141a40a2 = undefined;
}

// Namespace ob_activity_heist
// Params 1
// Checksum 0x99640a27, Offset: 0x128d
// Size: 0xcd
function function_2940a6b8c1cc6de( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    if ( game_utility::questcircle_exists() )
    {
        foreach ( player in player_list )
        {
            game_utility::questcircle_showtoplayer( player );
            
            if ( self.terminal )
            {
                self.terminal enablescriptableplayeruse( player );
            }
        }
    }
}

// Namespace ob_activity_heist
// Params 1
// Checksum 0x3e3181aa, Offset: 0x1362
// Size: 0xb8
function function_72c872e60c393aa9( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    
    if ( game_utility::questcircle_exists() )
    {
        foreach ( player in player_list )
        {
            game_utility::questcircle_hidefromplayer( player );
            
            if ( self.terminal )
            {
                self.terminal disablescriptableplayeruse( player );
            }
        }
    }
}

// Namespace ob_activity_heist
// Params 1
// Checksum 0xccfbfa53, Offset: 0x1422
// Size: 0x23
function function_b2dd36041299d0b9( relevant_info_struct )
{
    ob_activity_utility::function_894ac80e038636c5( "wcpveheistabandon", relevant_info_struct.playerlist );
}

// Namespace ob_activity_heist
// Params 1
// Checksum 0x3090393c, Offset: 0x144d
// Size: 0x1a1
function function_6044ee1af5b60228( var_545539b1780cc4a1 )
{
    var_c2003e3f92950d90 = level.var_e607236b193eb0c1.activityinstances[ "Activity" ][ var_545539b1780cc4a1.index ][ "REV_OB_CRASH_SITES" ];
    closestdistancesq = undefined;
    
    foreach ( activityinstance in var_c2003e3f92950d90 )
    {
        crash_site_origin = activityinstance.centerpoint;
        var_f84a31ea6323aac = distancesquared( crash_site_origin, self.plane_crash_point.origin );
        
        if ( !closestdistancesq || var_f84a31ea6323aac < closestdistancesq )
        {
            closestdistancesq = var_f84a31ea6323aac;
            var_27e9a47abc0c3ecf = activityinstance;
        }
    }
    
    /#
        crash_site_instance = level.var_e607236b193eb0c1.var_559750d3b21f479f[ "<dev string:x179>" ][ var_545539b1780cc4a1.index ][ "<dev string:x182>" ][ var_27e9a47abc0c3ecf.name ];
        var_930c30fb50400a08 = !crash_site_instance || crash_site_instance.additionalspawndata.var_a460646428aef1f6;
        assert( var_930c30fb50400a08, "<dev string:x195>" + var_27e9a47abc0c3ecf.name + "<dev string:x1ac>" );
    #/
    
    return var_27e9a47abc0c3ecf.name;
}

/#

    // Namespace ob_activity_heist
    // Params 1
    // Checksum 0xf2756aeb, Offset: 0x15f7
    // Size: 0x2a, Type: dev
    function function_7701932ea75b1d26( message )
    {
        if ( getdvarint( @"hash_4434b709141d69cc", 0 ) )
        {
            assertmsg( message );
        }
    }

#/
