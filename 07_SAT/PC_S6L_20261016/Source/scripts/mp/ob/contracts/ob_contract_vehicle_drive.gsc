// scripts\mp\ob\contracts\ob_contract_vehicle_drive.gsc  (hash_2a12db29f9549abc.gscc) (size: 21373 Bytes / 0x537d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8381534 (137893172)
// size ...... 21373 (0x537d)
// includes .. 28  (offset: 0x4e81)
// strings ... 71  (offset: 0x4f61)
// dev strs .. 5   (offset: 0x5341)
// exports ... 40  (offset: 0x3739)
// cseg ...... 0x6d0 + 0x3069 (0x3739)
// imports ... 138 (offset: 0x3d79)
// animtree1 . 0   (offset: 0x537d)
// animtree2 . 0   (offset: 0x537d)
#using script_3b0670880a9f4b4f;
#using script_60cd1c57e94be8d7;
#using script_65d213c1ef6ac784;
#using script_6a2ae28ba4b2c002;
#using script_79e727c8633026e2;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_player_broadcasting;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\ai_behavior;
#using scripts\mp\br\gametypes\br_dmz_radiation;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\scriptable_door_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dmz\gametypes\dmz_task_utils;
#using scripts\mp\ob\activities\ob_activity_vo_utility;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\objidpoolmanager;

#namespace ob_contract_vehicle_drive;

// Namespace ob_contract_vehicle_drive
// Params 0, eflags: 0x5
// Checksum 0x8a961921, Offset: 0x6ee
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_b2d54095e23e6b60", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_contract_vehicle_drive
// Params 0, eflags: 0x4
// Checksum 0x48d5c85d, Offset: 0x717
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_VEHICLE_DRIVE", &function_7effd6f9b9c00363 );
}

// Namespace ob_contract_vehicle_drive
// Params 0
// Checksum 0x36d2af83, Offset: 0x732
// Size: 0x195
function function_7effd6f9b9c00363()
{
    if ( !isdefined( level._effect[ "cargo_pallet_destruction" ] ) )
    {
        level._effect[ "cargo_pallet_destruction" ] = loadfxasset( "vfx_iw9_vehicle_script_death_cargo_dest" );
    }
    
    scriptable::scriptable_addusedcallbackbypart( "door_metal_roller_01", &function_842ac42ca99b037a );
    namespace_ae33899132c54ba6::function_4357964a6b7684ca();
    setdvar( @"hash_3061dc07aba9108", 0 );
    game[ "dialog" ][ "dmz_mission_vehicledrive_accept" ] = "dx_br_dmzo_cost_ovld_aivd";
    game[ "dialog" ][ "dmz_mission_vehicledrive_open_door" ] = "dx_br_dmzo_cost_ovld_vdad";
    game[ "dialog" ][ "dmz_mission_vehicledrive_extract_inbound" ] = "dx_br_dmzo_cost_ovld_vdar";
    game[ "dialog" ][ "dmz_mission_vehicledrive_destination" ] = "dx_br_dmzo_cost_ovld_vhdd";
    game[ "dialog" ][ "dmz_mission_vehicledrive_assigned" ] = "dx_br_dmzo_cost_ovld_vhda";
    activity_common::function_944074f3079c1d4e( "REV_OB_VEHICLE_DRIVE", 0, &vehicle_drive_activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_VEHICLE_DRIVE", 1, &vehicle_drive_activity_begin );
    activity_common::function_944074f3079c1d4e( "REV_OB_VEHICLE_DRIVE", 2, &function_6c8eebebef57cf65 );
    activity_common::function_944074f3079c1d4e( "REV_OB_VEHICLE_DRIVE", 3, &function_77f1ca6ec192705a );
    activity_common::function_944074f3079c1d4e( "REV_OB_VEHICLE_DRIVE", 4, &function_eb3d688141550764 );
    activity_common::function_944074f3079c1d4e( "REV_OB_VEHICLE_DRIVE", 5, &function_75ba996f84ea80e2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &function_c1634da413283dea, "REV_OB_VEHICLE_DRIVE" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &function_afce08ade6868c9d, "REV_OB_VEHICLE_DRIVE" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerAbandon", &function_c7871b7129e9c0c8, "REV_OB_VEHICLE_DRIVE" );
    
    if ( !isdefined( level.var_6185eb2ed44f2649 ) )
    {
        zombie_utils::function_dfae6a5bd222c586( &function_17fdfda41f9aa95a );
        level.var_6185eb2ed44f2649 = 1;
    }
    
    /#
        thread debug_spawnvehicle();
    #/
}

// Namespace ob_contract_vehicle_drive
// Params 0
// Checksum 0x93adcfe, Offset: 0x8cf
// Size: 0xcc0
function vehicle_drive_activity_setup()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    if ( !isdefined( level.var_e40c20196da44a3 ) )
    {
        destinations = utility::getstructarray( "dmz_vehicledrive_end", "targetname" );
        level.var_e40c20196da44a3 = [];
        
        foreach ( node in destinations )
        {
            if ( !br_dmz_radiation::function_704454416dce7454( node.origin ) )
            {
                level.var_e40c20196da44a3[ level.var_e40c20196da44a3.size ] = node;
            }
        }
    }
    
    if ( !isdefined( level.var_209035fc1e63a988 ) )
    {
        level.var_209035fc1e63a988 = utility::getstructarray( "heli_reinforceNode", "script_noteworthy" );
    }
    
    activityvariantdefinition = activity_definition_utils::function_9129cd8075c85c09( self );
    self.var_91c91f4a631c481d = activityvariantdefinition;
    var_5c048b6d7b414502 = utility::getstructarray( self.varianttag, "target" );
    
    foreach ( struct in var_5c048b6d7b414502 )
    {
        if ( struct.targetname == "dmz_vehicledrive_start" )
        {
            vehicle_node = spawnstruct();
            vehicle_node.angles = struct.angles;
            vehicle_node.origin = struct.origin;
            self.start = vehicle_node;
            continue;
        }
        
        if ( struct.targetname == "vehicledrive_guard" )
        {
            self.var_ccbb14f0da8b95d7 = struct;
            continue;
        }
        
        if ( struct.targetname == "vehicledrive_horde" )
        {
            self.horde_spawn = struct;
        }
    }
    
    if ( !isdefined( self.start ) )
    {
        activity_instance_common::function_9aeeabe50fc9cc3e( self );
    }
    
    garagedoors = [];
    blockers = [];
    var_82226ac995a08458 = undefined;
    baked_components = getentitylessscriptablearray( "vehicle_drive_garage", #target, self.start.origin, 1000 );
    
    foreach ( component in baked_components )
    {
        if ( component.targetname == "door_contract_garage" )
        {
            garagedoors[ garagedoors.size ] = component;
            continue;
        }
        
        if ( component.targetname == "door_contract_blocker" )
        {
            blockers[ blockers.size ] = component;
        }
    }
    
    baked_structs = utility::getstructarray( "door_contract_lock", "targetname" );
    var_82226ac995a08458 = function_47c86977a18df38b( baked_structs, self.start.origin );
    self.garagedoors = garagedoors;
    self.var_939ec815f4d9b19a = blockers;
    self.var_82226ac995a08458 = var_82226ac995a08458;
    self.difficulty_region = region_difficulty_manager::get_region_difficulty( self.start.origin );
    
    if ( self.difficulty_region == "difficulty_undefined" )
    {
        self.difficulty_region = "difficulty_easy";
    }
    
    self.horde_regions = [ "difficulty_darkaether", "difficulty_hard", "difficulty_normal" ];
    self.merc_regions = [ "difficulty_normal", "difficulty_easy" ];
    
    switch ( self.difficulty_region )
    {
        case #"hash_651f76c0ad6741ec":
            self.num_attractor_slots = 6;
            break;
        case #"hash_5343b465e56ec9a4":
            self.num_attractor_slots = 6;
            break;
        case #"hash_af83e47edfa8900a":
            self.num_attractor_slots = 4;
            break;
        case #"hash_7bb2cd766703d463":
        default:
            self.num_attractor_slots = 0;
            break;
    }
    
    mindist = 25000;
    maxdist = 50000;
    destinations = utility::get_array_of_closest( self.start.origin, level.var_e40c20196da44a3, undefined, undefined, maxdist, mindist );
    
    if ( destinations.size > 0 )
    {
        destinations = arrayrandomize( destinations );
        
        foreach ( dest in destinations )
        {
            if ( !dest.inuse && self.difficulty_region == region_difficulty_manager::get_region_difficulty( dest.origin ) )
            {
                if ( self.difficulty_region == "difficulty_hard" || self.difficulty_region == "difficulty_darkaether" )
                {
                    self.end = dest;
                    dest.inuse = 1;
                    break;
                }
                
                var_3e3b8abb3d56b042 = ( dest.origin + self.start.origin ) / 2;
                
                if ( region_difficulty_manager::get_region_difficulty( var_3e3b8abb3d56b042 ) != "difficulty_hard" )
                {
                    self.end = dest;
                    dest.inuse = 1;
                    break;
                }
            }
        }
    }
    
    if ( !isdefined( self.end ) )
    {
        var_17d135168fb0b8c5 = 10000;
        destinations = utility::get_array_of_closest( self.start.origin, level.var_e40c20196da44a3, undefined, undefined, maxdist + var_17d135168fb0b8c5, mindist - var_17d135168fb0b8c5 );
        destinations = arrayrandomize( destinations );
        
        foreach ( dest in destinations )
        {
            if ( !dest.inuse && self.difficulty_region == region_difficulty_manager::get_region_difficulty( dest.origin ) )
            {
                if ( self.difficulty_region == "difficulty_hard" || self.difficulty_region == "difficulty_darkaether" )
                {
                    self.end = dest;
                    dest.inuse = 1;
                    break;
                }
                
                var_3e3b8abb3d56b042 = ( dest.origin + self.start.origin ) / 2;
                
                if ( region_difficulty_manager::get_region_difficulty( var_3e3b8abb3d56b042 ) != "difficulty_hard" )
                {
                    self.end = dest;
                    dest.inuse = 1;
                    break;
                }
            }
        }
    }
    
    if ( !isdefined( self.end ) )
    {
        println( "<dev string:x24>" );
        activity_instance_common::function_9aeeabe50fc9cc3e( self );
        return;
    }
    
    if ( !vehicle::is_loaded( %"hash_406987d5bb9cf080" ) )
    {
        println( "<dev string:x5c>" );
        activity_instance_common::function_9aeeabe50fc9cc3e( self );
        return;
    }
    
    self.vehicle = namespace_b0d5e7f43c6af238::function_a0d4d8c69e61721c( self.start );
    self.vehicle.var_52dfac12181e4ef9 = self.vehicle vehicle_gettopspeedforward();
    self.vehicle.var_80f99dc346cf1422 = self.vehicle vehicle_gettopspeedreverse();
    self.vehicle vehicleshowonminimap( 0 );
    self.vehicle.godmode = 1;
    vehicle_interact::allow_use( self.vehicle, 0 );
    
    if ( getdvarint( @"hash_59e2ffb228fec3cd", 1 ) )
    {
        if ( garagedoors.size > 0 )
        {
            foreach ( door in garagedoors )
            {
                door.activityinstance = self;
                door.navblocker = createnavobstaclebybounds( door.origin, ( 10, 100, 10 ), door.angles );
                door setscriptablepartstate( "door_metal_roller_01", "close" );
            }
        }
        else
        {
            assertmsg( "<dev string:xa3>" + self.start.origin );
        }
        
        self.keypads = [];
        var_273391d7da364b71 = ( 0, 0, 0 );
        var_46afe4a836ac445c = 0;
        
        foreach ( door in self.garagedoors )
        {
            var_273391d7da364b71 += door.origin;
            var_46afe4a836ac445c++;
        }
        
        midpoint = var_273391d7da364b71 / var_46afe4a836ac445c;
        keypad = utility::spawn_model( "me_electrical_garage_numpad_01", midpoint + anglestoforward( self.garagedoors[ 0 ].angles ) * 12, self.garagedoors[ 0 ].angles );
        self.keypads[ self.keypads.size ] = keypad;
        closestdoor = utility::get_array_of_closest( self.horde_spawn.origin, self.garagedoors )[ 0 ];
        self.var_540ae3b29968d992 = closestdoor;
        var_aa6d276c39cf38d9 = utility::get_array_of_closest( self.horde_spawn.origin, self.keypads )[ 0 ];
        self.var_71a34cd45540cda3 = var_aa6d276c39cf38d9;
        var_25ae67aeafdb6c2a = 1000;
        
        foreach ( blocker in self.var_939ec815f4d9b19a )
        {
            blocker setscriptablepartstate( "state", "visible" );
        }
        
        doors = scriptable_door_utility::scriptable_door_get_in_radius( self.var_82226ac995a08458.origin, 75, 75 );
        
        foreach ( door in doors )
        {
            door scriptabledoorfreeze( 1 );
            self.var_53f3c3f754962461 = door;
        }
    }
    
    self.numagents = 0;
    
    if ( arraycontains( self.merc_regions, self.difficulty_region ) )
    {
        thread function_af7053ac3d8813eb();
    }
    else
    {
        thread function_5f02251b1162f113();
    }
    
    if ( arraycontains( self.horde_regions, self.difficulty_region ) )
    {
        thread function_b8da9f109b9572c6();
    }
    else
    {
        thread function_1333e21cbbd2073e();
    }
    
    var_805b6c95abf49bc5 = 1;
    
    if ( var_805b6c95abf49bc5 )
    {
        self.helidata = namespace_abdf64fc596be565::function_7d86b1d8eb835027();
    }
    else
    {
        self.helidata = namespace_112e5e9b0fbdf8a::function_7d86b1d8eb835027();
    }
    
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace ob_contract_vehicle_drive
// Params 4
// Checksum 0x70a8a5bc, Offset: 0x1597
// Size: 0x52, Type: bool
function function_a57cdd338ca5c096( start, end, min, max )
{
    if ( !( isdefined( start ) && isdefined( end ) ) )
    {
        return false;
    }
    
    return distancesquared( start, end ) <= max * max && distancesquared( start, end ) >= min * min;
}

// Namespace ob_contract_vehicle_drive
// Params 0
// Checksum 0xbd508ef0, Offset: 0x15f2
// Size: 0x5c2
function vehicle_drive_activity_begin()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.var_b5d893a66963d916 = ob_activity_vo_utility::function_9d4e8b8c2a6ccc45( 16625, "quest_s0a2t1_delivery_start", self.playerparticipants );
    
    if ( !self.var_b5d893a66963d916 )
    {
        activity_player_broadcasting::function_cb4750c84882dd07( "contract_vehicledrive_start_land" );
    }
    
    foreach ( player in self.playerparticipants )
    {
        params = spawnstruct();
        params.player = player;
        callback::callback( "cargo_delivery_started", params );
    }
    
    function_163e87aef633449f( self.playerparticipants[ 0 ], 1 );
    
    if ( getdvarint( @"hash_59e2ffb228fec3cd", 1 ) )
    {
        foreach ( door in self.garagedoors )
        {
            door setscriptablepartstate( "door_metal_roller_01", "locked" );
            
            foreach ( player in level.players )
            {
                door disablescriptableplayeruse( player );
            }
            
            foreach ( player in self.playerparticipants )
            {
                door enablescriptableplayeruse( player );
            }
        }
    }
    
    thread function_de5d21f9d37825ce();
    thread function_ecd15ee987282019();
    
    if ( getdvarint( @"hash_59e2ffb228fec3cd", 1 ) )
    {
        self waittill( #"vehicledrive_dooropened" );
    }
    
    vehicle_interact::allow_use( self.vehicle, 1 );
    self.vehicle vehicleshowonminimap( 1 );
    self.vehicle.godmode = 0;
    self.vehicle utility::ent_flag_init( self.type );
    thread function_c3b3285b03c9394a();
    areaorigin = self.vehicle.origin;
    techodriver = undefined;
    
    while ( !isdefined( techodriver ) || !arraycontains( self.playerparticipants, techodriver ) )
    {
        techodriver = vehicle_occupancy::get_driver( self.vehicle, 1 );
        wait 0.1;
    }
    
    var_764cdd14f6273f41 = [ ( 135, 0, 0 ), ( -125, 0, 0 ), ( 0, 50, 0 ), ( 0, -50, 0 ), ( 60, 50, 0 ), ( 60, -50, 0 ), ( -60, 50, 0 ), ( -60, -50, 0 ) ];
    self.vehicle.attractor = zombie_attractor_manager::add_attractor( self.vehicle, 2, 1250, 1, undefined, &vehicle_drive_validator );
    objidpoolmanager::update_objective_position( self.var_e747ab5c3846b1bc, self.end.origin + ( 0, 0, 60 ) );
    self thread [[ self.helidata.var_b1b3897987cfbae3 ]]();
    
    while ( isdefined( self.vehicle ) && distance2dsquared( self.vehicle.origin, areaorigin ) < 9000000 )
    {
        wait 0.1;
    }
    
    self.teams = [ self.playerparticipants[ 0 ].team ];
    self.var_959eed0f37d51326 = self [[ self.helidata.spawnheli ]]( self.vehicle );
    self.var_959eed0f37d51326.var_24954f14e27b448d = 1;
    self.var_959eed0f37d51326.var_7b10f1c2e1202450 = 1;
    self.vehicle.var_2e2ed02cfb0c625d = techodriver.team;
    self.vehicle makeentitysentient( self.vehicle.var_2e2ed02cfb0c625d );
    self.vehicle makeentitynomeleetarget();
    thread function_b77d5f6a8fed1fb5();
    wait 2;
    activity_player_broadcasting::function_cb4750c84882dd07( "vehicle_drive_enemyheliinbound" );
    self waittill( #"payload_delivered" );
    
    if ( !self.var_b5d893a66963d916 )
    {
        activity_player_broadcasting::function_cb4750c84882dd07( "contract_vehicledrive_success" );
    }
    
    if ( isdefined( self.vehicle ) )
    {
        self.vehicle utility::ent_flag_init( "cargo_delivered" );
    }
    
    activity_instance_common::endactivity( self, 1 );
}

// Namespace ob_contract_vehicle_drive
// Params 2
// Checksum 0x51b2f740, Offset: 0x1bbc
// Size: 0x60
function function_523f458d517fee35( offsets, axes )
{
    x_axis = axes[ "forward" ];
    y_axis = axes[ "right" ];
    var_50f0a8bfb3128a6c = axes[ "up" ];
    return offsets[ 0 ] * x_axis + offsets[ 1 ] * y_axis + offsets[ 2 ] * var_50f0a8bfb3128a6c;
}

// Namespace ob_contract_vehicle_drive
// Params 0
// Checksum 0xcae01574, Offset: 0x1c25
// Size: 0xce
function function_6c8eebebef57cf65()
{
    self endon( #"instance_destroyed" );
    
    if ( self.vehicle )
    {
        self.vehicle vehicle_settopspeedforward( self.vehicle.var_52dfac12181e4ef9 );
        self.vehicle vehicle_settopspeedreverse( self.vehicle.var_80f99dc346cf1422 );
    }
    
    dmz_task_utils::function_3ff46488beb193c7();
    self.end.inuse = 0;
    
    if ( isdefined( self.var_959eed0f37d51326 ) )
    {
        self.var_959eed0f37d51326 thread [[ self.helidata.flyaway ]]();
    }
    
    if ( isdefined( self.extractheli ) )
    {
        self.extractheli.readytoleave = 1;
    }
    
    function_9676228419ea816a();
}

// Namespace ob_contract_vehicle_drive
// Params 0
// Checksum 0x467eb214, Offset: 0x1cfb
// Size: 0x166
function function_77f1ca6ec192705a()
{
    function_9676228419ea816a();
    
    if ( isdefined( self.keypads ) )
    {
        if ( isdefined( self.var_71a34cd45540cda3.attractor ) )
        {
            zombie_attractor_manager::remove_attractor( self.var_71a34cd45540cda3.attractor );
        }
        
        foreach ( keypad in self.keypads )
        {
            keypad delete();
        }
    }
    
    if ( isdefined( self.var_939ec815f4d9b19a ) )
    {
        foreach ( blocker in self.var_939ec815f4d9b19a )
        {
            blocker setscriptablepartstate( "state", "hidden" );
        }
    }
    
    if ( isdefined( self.var_53f3c3f754962461 ) )
    {
        self.var_53f3c3f754962461 scriptabledoorfreeze( 0 );
    }
}

// Namespace ob_contract_vehicle_drive
// Params 0
// Checksum 0xae308724, Offset: 0x1e69
// Size: 0x4b
function function_eb3d688141550764()
{
    if ( isdefined( self.vehicle ) )
    {
        return self.vehicle.origin;
    }
    
    if ( isdefined( self.start ) )
    {
        return self.start.origin;
    }
    
    return;
}

// Namespace ob_contract_vehicle_drive
// Params 1
// Checksum 0x73a061b6, Offset: 0x1ebc
// Size: 0x97
function function_75ba996f84ea80e2( relevantinfostruct )
{
    offset = ( -100, 250, 0 );
    reward_struct = spawnstruct();
    reward_struct.origin = getclosestpointonnavmesh( self.end.origin + function_523f458d517fee35( offset, anglestoaxis( self.vehicle.angles ) ) );
    reward_struct.angles = self.end.angles;
    return reward_struct;
}

// Namespace ob_contract_vehicle_drive
// Params 1
// Checksum 0x9eb76f3b, Offset: 0x1f5c
// Size: 0x10c
function function_c1634da413283dea( info_struct )
{
    if ( getdvarint( @"hash_59e2ffb228fec3cd", 1 ) )
    {
        foreach ( player in info_struct.playerlist )
        {
            foreach ( door in self.garagedoors )
            {
                door enablescriptablepartplayeruse( "door_metal_roller_01", player );
            }
        }
    }
}

// Namespace ob_contract_vehicle_drive
// Params 1
// Checksum 0xfad351c3, Offset: 0x2070
// Size: 0x10c
function function_afce08ade6868c9d( info_struct )
{
    if ( getdvarint( @"hash_59e2ffb228fec3cd", 1 ) )
    {
        foreach ( player in info_struct.playerlist )
        {
            foreach ( door in self.garagedoors )
            {
                door disablescriptablepartplayeruse( "door_metal_roller_01", player );
            }
        }
    }
}

// Namespace ob_contract_vehicle_drive
// Params 0
// Checksum 0xcafb206c, Offset: 0x2184
// Size: 0x90
function function_f1d9b3f65aa2c056()
{
    if ( self.var_b5d893a66963d916 )
    {
        foreach ( player in self.playerparticipants )
        {
            function_421792107922fbb2( player );
        }
    }
    
    activity_instance_common::endactivity( self, 0 );
}

// Namespace ob_contract_vehicle_drive
// Params 1
// Checksum 0x12f0cd3b, Offset: 0x221c
// Size: 0x8d
function function_c7871b7129e9c0c8( relevant_info_struct )
{
    wait 0.2;
    
    foreach ( player in relevant_info_struct.playerlist )
    {
        function_421792107922fbb2( player );
    }
}

// Namespace ob_contract_vehicle_drive
// Params 1, eflags: 0x4
// Checksum 0x61bcda7a, Offset: 0x22b1
// Size: 0x28
function private function_421792107922fbb2( player )
{
    if ( ob_activity_vo_utility::is_squad_on_mission( player, 16625 ) )
    {
        player utility::ent_flag_clear( "quest_s0a2t1_delivery_start" );
    }
}

// Namespace ob_contract_vehicle_drive
// Params 6
// Checksum 0x62abaff1, Offset: 0x22e1
// Size: 0x7e
function function_842ac42ca99b037a( instance, part, state, player, bautouse, usestring )
{
    instance setscriptablepartstate( "door_metal_roller_01", "opening" );
    destroynavobstacle( instance.navblocker );
    instance.open = 1;
    instance.activityinstance notify( #"vehicledrive_dooropened" );
}

// Namespace ob_contract_vehicle_drive
// Params 0
// Checksum 0xdcf3f9d2, Offset: 0x2367
// Size: 0x108
function function_ecd15ee987282019()
{
    level endon( #"game_ended" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    while ( true )
    {
        foreach ( player in self.playerparticipants )
        {
            dist = distance2dsquared( player.origin, self.start.origin );
            
            if ( dist < 6250000 )
            {
                activity_player_broadcasting::function_cb4750c84882dd07( "vehicle_drive_inthearea" );
                
                if ( getdvarint( @"hash_59e2ffb228fec3cd", 1 ) )
                {
                    thread function_ecd15be987281980();
                    thread function_ecd15ce987281bb3();
                }
                
                return;
            }
        }
        
        wait 1;
    }
}

// Namespace ob_contract_vehicle_drive
// Params 0
// Checksum 0x93274a28, Offset: 0x2477
// Size: 0xe8
function function_ecd15be987281980()
{
    level endon( #"game_ended" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    while ( true )
    {
        foreach ( player in self.playerparticipants )
        {
            dist = distance2dsquared( player.origin, self.var_540ae3b29968d992.origin );
            
            if ( dist < 562500 )
            {
                activity_player_broadcasting::function_cb4750c84882dd07( "vehicle_drive_neardoor" );
                return;
            }
        }
        
        wait 1;
    }
}

// Namespace ob_contract_vehicle_drive
// Params 0
// Checksum 0xb653e2f6, Offset: 0x2567
// Size: 0xe8
function function_ecd15ce987281bb3()
{
    level endon( #"game_ended" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    while ( true )
    {
        foreach ( player in self.playerparticipants )
        {
            dist = distance2dsquared( player.origin, self.var_540ae3b29968d992.origin );
            
            if ( dist < 90000 )
            {
                self notify( #"hash_4cfb96d64d316ca5" );
                return;
            }
        }
        
        wait 1;
    }
}

// Namespace ob_contract_vehicle_drive
// Params 0
// Checksum 0xd6eec01f, Offset: 0x2657
// Size: 0x74
function function_af7053ac3d8813eb()
{
    requestid = activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:enc_ob_vehicle_drive_guard", self.var_ccbb14f0da8b95d7.origin, 100, 1, 0, 1, 0 );
    
    if ( isdefined( requestid ) )
    {
        function_1a9d724a960fa19d( requestid, self.difficulty_region, 1 );
        function_1a9d724a960fa19d( requestid, "inside", 1 );
        activity_ai_encounters::function_52d1342183200a8f( requestid, &function_d3d258552f69c45c, [ self, 1 ] );
    }
}

// Namespace ob_contract_vehicle_drive
// Params 0
// Checksum 0xb0d41986, Offset: 0x26d3
// Size: 0x73
function function_1333e21cbbd2073e()
{
    requestid = activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:enc_ob_vehicle_drive_guard", self.horde_spawn.origin, 100, 1, 0, 1, 0 );
    
    if ( isdefined( requestid ) )
    {
        function_1a9d724a960fa19d( requestid, self.difficulty_region, 1 );
        function_1a9d724a960fa19d( requestid, "outside", 1 );
        activity_ai_encounters::function_52d1342183200a8f( requestid, &function_d3d258552f69c45c, [ self, 0 ] );
    }
}

// Namespace ob_contract_vehicle_drive
// Params 0
// Checksum 0x9894fafc, Offset: 0x274e
// Size: 0x24c
function function_b8da9f109b9572c6()
{
    level endon( #"game_ended" );
    self.vehicle endon( #"death" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    requestid = activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:enc_ob_vehicle_drive_horde", self.horde_spawn.origin, 75, 1, 0, 1, 2 );
    
    if ( isdefined( requestid ) )
    {
        function_1a9d724a960fa19d( requestid, self.difficulty_region, 1 );
        function_1a9d724a960fa19d( requestid, "outside", 1 );
    }
    
    if ( isdefined( self.var_71a34cd45540cda3 ) )
    {
        self.var_71a34cd45540cda3.attractor = zombie_attractor_manager::add_attractor( self.var_71a34cd45540cda3, 0, 750, 1, undefined, &vehicle_drive_validator );
        var_bb2ad06dd6d21b54 = 320 / self.num_attractor_slots;
        var_fc48cc6608c8d82c = [];
        
        for ( i = 0; i < self.num_attractor_slots / 2 ; i++ )
        {
            slot = spawnstruct();
            slot.origin = self.var_71a34cd45540cda3.origin + anglestoright( self.var_71a34cd45540cda3.angles ) * 1 * ( i + 1 ) * var_bb2ad06dd6d21b54 + anglestoforward( self.var_71a34cd45540cda3.angles ) * 15;
            var_fc48cc6608c8d82c[ var_fc48cc6608c8d82c.size ] = slot;
            slot = spawnstruct();
            slot.origin = self.var_71a34cd45540cda3.origin + anglestoright( self.var_71a34cd45540cda3.angles ) * -1 * ( i + 1 ) * var_bb2ad06dd6d21b54 + anglestoforward( self.var_71a34cd45540cda3.angles ) * 15;
            var_fc48cc6608c8d82c[ var_fc48cc6608c8d82c.size ] = slot;
        }
        
        zombie_attractor_manager::set_attractor_slots( self.var_71a34cd45540cda3.attractor, var_fc48cc6608c8d82c );
        self waittill( #"hash_4cfb96d64d316ca5" );
        
        if ( isdefined( self.var_71a34cd45540cda3.attractor ) )
        {
            zombie_attractor_manager::remove_attractor( self.var_71a34cd45540cda3.attractor );
        }
    }
}

// Namespace ob_contract_vehicle_drive
// Params 0
// Checksum 0xa903606f, Offset: 0x29a2
// Size: 0x5b
function function_5f02251b1162f113()
{
    requestid = activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:enc_ob_vehicle_drive_horde", self.var_ccbb14f0da8b95d7.origin, 75, 1, 0, 1, 2 );
    
    if ( isdefined( requestid ) )
    {
        function_1a9d724a960fa19d( requestid, self.difficulty_region, 1 );
        function_1a9d724a960fa19d( requestid, "inside", 1 );
    }
}

// Namespace ob_contract_vehicle_drive
// Params 0
// Checksum 0x441fc7d2, Offset: 0x2a05
// Size: 0xf8
function function_48b033611b20e681()
{
    level endon( #"game_ended" );
    self.vehicle endon( #"death" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    wait 2;
    requestid = activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:enc_ob_vehicle_drive_horde", self.end.origin, 75, 1, 0, 1, 0 );
    
    if ( isdefined( requestid ) )
    {
        function_1a9d724a960fa19d( requestid, self.difficulty_region, 1 );
        function_1a9d724a960fa19d( requestid, "destination", 1 );
    }
    
    self.extractheli.attractor = zombie_attractor_manager::add_attractor( self.extractheli.crate, 0, 500, 1, undefined, &vehicle_drive_validator );
    self waittill( #"hash_8eae12618646be23" );
    zombie_attractor_manager::remove_attractor( self.extractheli.attractor );
}

// Namespace ob_contract_vehicle_drive
// Params 1
// Checksum 0xdf087ce8, Offset: 0x2b05
// Size: 0x49
function function_17fdfda41f9aa95a( params )
{
    if ( self.var_aeba340c898b16db )
    {
        if ( isdefined( self.attractor ) )
        {
            if ( isplayer( params.eattacker ) )
            {
                zombie_attractor_manager::remove_attractor( self.attractor );
            }
        }
    }
    
    return -1;
}

// Namespace ob_contract_vehicle_drive
// Params 4
// Checksum 0x3f086f3b, Offset: 0x2b57
// Size: 0xf8
function function_d3d258552f69c45c( requestid, userdata, agent, data )
{
    activity = userdata[ 0 ];
    var_178caee86648dbab = userdata[ 1 ];
    agent endon( #"death" );
    activity endon( #"activity_ended" );
    activity endon( #"instance_destroyed" );
    
    if ( isalive( agent ) )
    {
        activity thread function_ad73eb572ad00710( agent );
        thread ai_behavior::behavior_GuardStationary( agent );
        activity.numagents += 1;
        
        if ( var_178caee86648dbab )
        {
            locked_door_goal_radius = 16;
            agent ai_behavior::function_7bbd01e514ea0578( locked_door_goal_radius );
            agent setthreatbiasgroup( "ignored_by_zombies" );
            activity waittill( #"vehicledrive_dooropened" );
            opened_door_goal_radius = 64;
            agent ai_behavior::function_7bbd01e514ea0578( opened_door_goal_radius );
            agent setthreatbiasgroup( "team_hundred_ninety" );
        }
    }
}

// Namespace ob_contract_vehicle_drive
// Params 1
// Checksum 0xf8217f55, Offset: 0x2c57
// Size: 0x47
function function_ad73eb572ad00710( agent )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    agent waittill( #"death" );
    self.numagents -= 1;
}

// Namespace ob_contract_vehicle_drive
// Params 2
// Checksum 0xe491cbed, Offset: 0x2ca6
// Size: 0x67, Type: bool
function vehicle_drive_validator( attractor, zombie )
{
    if ( isdefined( zombie.var_bd22ba6c600a23a3 ) )
    {
        return false;
    }
    
    if ( isdefined( zombie.enemy ) )
    {
        return false;
    }
    
    if ( isalive( zombie ) && isdefined( attractor ) )
    {
        zombie.var_aeba340c898b16db = 1;
        zombie.attractor = attractor;
        return true;
    }
    
    return false;
}

// Namespace ob_contract_vehicle_drive
// Params 0
// Checksum 0x1c8bf7d8, Offset: 0x2d16
// Size: 0x78
function function_c3b3285b03c9394a()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.vehicle endon( #"death" );
    
    while ( true )
    {
        wait 1;
        
        if ( self.vehicle.health < self.vehicle.maxhealth / 4 )
        {
            activity_player_broadcasting::function_cb4750c84882dd07( "vehicle_drive_lowhealth" );
            break;
        }
    }
}

// Namespace ob_contract_vehicle_drive
// Params 0
// Checksum 0x352e6241, Offset: 0x2d96
// Size: 0x61
function function_de5d21f9d37825ce()
{
    level endon( #"game_ended" );
    self endon( #"payload_delivered" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.vehicle waittill( #"death" );
    function_9676228419ea816a();
    activity_player_broadcasting::function_cb4750c84882dd07( "vehicle_drive_destroyed" );
    function_f1d9b3f65aa2c056();
}

// Namespace ob_contract_vehicle_drive
// Params 0
// Checksum 0x2b11c72d, Offset: 0x2dff
// Size: 0xcc
function function_c211b000dee2eda0()
{
    level endon( #"game_ended" );
    self endon( #"payload_delivered" );
    self.vehicle endon( #"death" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    while ( true )
    {
        if ( isdefined( self.vehicle ) && isdefined( self.vehicle.occupants ) )
        {
            driver = vehicle_occupancy::get_driver( self.vehicle, 1 );
            
            if ( isdefined( driver ) && !arraycontains( self.playerparticipants, driver ) )
            {
                activity_player_broadcasting::function_cb4750c84882dd07( "vehicle_drive_stolen", self.playerparticipants );
                function_f1d9b3f65aa2c056();
                return;
            }
        }
        
        wait 1;
    }
}

// Namespace ob_contract_vehicle_drive
// Params 0
// Checksum 0x6ab6f46d, Offset: 0x2ed3
// Size: 0x393
function function_b77d5f6a8fed1fb5()
{
    level endon( #"game_ended" );
    self.vehicle endon( #"death" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    var_edd52247474c7dab = 0;
    var_9eaddc66829ed9af = 0;
    sqdist = squared( int( 100 ) );
    heliflyaway = 0;
    
    while ( true )
    {
        wait 0.1;
        
        if ( !( isdefined( self.vehicle ) && isdefined( self.vehicle.payload ) ) )
        {
            if ( isdefined( self.extractheli ) )
            {
                self.extractheli.readytoleave = 1;
                self.extractheli notify( #"hash_8182ff35fd9e24b8" );
            }
            
            if ( isdefined( self.var_959eed0f37d51326 ) )
            {
                self.var_959eed0f37d51326 thread [[ self.helidata.flyaway ]]();
                heliflyaway = 1;
            }
            
            return;
        }
        
        curdist = distancesquared( self.vehicle.payload.origin, self.end.origin );
        
        if ( curdist <= sqdist )
        {
            break;
        }
        
        if ( isdefined( self.var_959eed0f37d51326 ) && !heliflyaway && distancesquared( self.vehicle.origin, self.end.origin ) <= 20250000 )
        {
            self.var_959eed0f37d51326 thread [[ self.helidata.flyaway ]]();
            heliflyaway = 1;
        }
        
        if ( !var_edd52247474c7dab && curdist <= 400000000 )
        {
            players = teams::getteamdata( self.vehicle.var_2e2ed02cfb0c625d, "players" );
            
            if ( isdefined( players ) && players.size )
            {
                self.extractheli = players[ 0 ] namespace_ae33899132c54ba6::function_bd1f657f7943610d( self.end.origin, ( 0, 0, 80 ), 1 );
            }
            
            var_edd52247474c7dab = 1;
            thread function_48b033611b20e681();
        }
        
        if ( var_edd52247474c7dab && curdist <= 36000000 && !var_9eaddc66829ed9af )
        {
            var_9eaddc66829ed9af = 1;
            var_3e5df7c437647749 = getaiarrayinradius( self.end.origin, 750, "team_two_hundred" );
            
            if ( var_3e5df7c437647749.size < 10 )
            {
                activity_player_broadcasting::function_cb4750c84882dd07( "vehicle_drive_extractinbound_lowdanger" );
            }
            else
            {
                activity_player_broadcasting::function_cb4750c84882dd07( "vehicle_drive_extractinbound" );
            }
        }
        
        if ( curdist <= 2250000 )
        {
            self notify( #"hash_8eae12618646be23" );
        }
    }
    
    self.vehicle.payload notsolid();
    waitframe();
    self.vehicle.payload unlink();
    self.vehicle.payload linkto( self.extractheli.crate, "tag_origin", ( 0, 0, -110 ), ( 0, 0, 0 ) );
    self notify( #"payload_delivered" );
    self.extractheli.readytoleave = 1;
    self.extractheli notify( #"hash_8182ff35fd9e24b8" );
    self.extractheli.crate playsoundonmovingent( "mp_dmz_cargo_delivery_hook" );
}

// Namespace ob_contract_vehicle_drive
// Params 0
// Checksum 0x48d5f37, Offset: 0x326e
// Size: 0xde
function function_9676228419ea816a()
{
    if ( isdefined( self.vehicle ) )
    {
        if ( isdefined( self.vehicle.attractor ) )
        {
            zombie_attractor_manager::remove_attractor( self.vehicle.attractor );
        }
        
        if ( isdefined( self.vehicle.var_fc48cc6608c8d82c ) )
        {
            foreach ( slot in self.vehicle.var_fc48cc6608c8d82c )
            {
                if ( isdefined( slot ) )
                {
                    slot delete();
                }
            }
        }
    }
}

// Namespace ob_contract_vehicle_drive
// Params 0
// Checksum 0x37a7dfa8, Offset: 0x3354
// Size: 0x7a
function function_d2f66d35d4cf8636()
{
    self.var_e747ab5c3846b1bc = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "ob_vehicle_drive_marker", 0, 1 );
    objidpoolmanager::update_objective_position( self.var_e747ab5c3846b1bc, self.start.origin + ( 0, 0, 60 ) );
    namespace_d7fa4530141146a5::function_e27cc6376feeb35c( self.var_e747ab5c3846b1bc, 0, 1 );
    self waittill( #"activity_ended" );
    namespace_d7fa4530141146a5::function_501e44ea1cb9219d( self.var_e747ab5c3846b1bc );
}

// Namespace ob_contract_vehicle_drive
// Params 2
// Checksum 0x32d6b86a, Offset: 0x33d6
// Size: 0x162
function setup_marker_settings( objectivemarkerbundle, objectivemarkerid )
{
    generalsettings = objectivemarkerbundle.generalsettings;
    minimapsettings = objectivemarkerbundle.minimapsettings;
    tacmapsettings = objectivemarkerbundle.tacmapsettings;
    compasssettings = objectivemarkerbundle.compasssettings;
    hudsettings = objectivemarkerbundle.hudsettings;
    objective_icon( objectivemarkerid, generalsettings.var_7aed872ac463b234 );
    objective_state( objectivemarkerid, generalsettings.state );
    objective_setisoptional( objectivemarkerid, generalsettings.isoptional );
    objective_setownerteam( objectivemarkerid, generalsettings.ownerteam );
    
    if ( isdefined( generalsettings.var_dc10495f590deded ) )
    {
        var_dc10495f590deded = ( 0, 0, 0 );
        var_dc01b6bac8d24e0 = generalsettings.var_dc10495f590deded;
        var_21f669501225774f = strtok( var_dc01b6bac8d24e0, " " );
        
        if ( var_21f669501225774f.size == 4 )
        {
            var_dc10495f590deded = ( float( var_21f669501225774f[ 0 ] ) * 255, float( var_21f669501225774f[ 1 ] ) * 255, float( var_21f669501225774f[ 2 ] ) * 255 );
        }
        
        objective_settint( objectivemarkerid, int( var_dc10495f590deded[ 0 ] ), int( var_dc10495f590deded[ 1 ] ), int( var_dc10495f590deded[ 2 ] ) );
    }
}

// Namespace ob_contract_vehicle_drive
// Params 2
// Checksum 0x687eb14, Offset: 0x3540
// Size: 0x64
function function_163e87aef633449f( var_8c953eb201608663, shouldping )
{
    wait 2.4;
    thread function_d2f66d35d4cf8636();
    
    if ( isdefined( var_8c953eb201608663 ) && shouldping )
    {
        wait 2;
        var_8c953eb201608663 calloutmarkerping::function_5d7b7302e94b97c2( self.var_e747ab5c3846b1bc, self.start.origin + ( 0, 0, 60 ) );
    }
}

/#

    // Namespace ob_contract_vehicle_drive
    // Params 0
    // Checksum 0x63845608, Offset: 0x35ac
    // Size: 0x16, Type: dev
    function function_5daceb31f609a4bb()
    {
        return utility::getstructarray( "<dev string:xcf>", "<dev string:xe6>" );
    }

    // Namespace ob_contract_vehicle_drive
    // Params 0
    // Checksum 0x7998481a, Offset: 0x35ca
    // Size: 0x16f, Type: dev
    function debug_spawnvehicle()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_361e499f400fee2a", 0 ) )
            {
                setdvar( @"hash_361e499f400fee2a", 0 );
                node = spawnstruct();
                node.origin = level.players[ 0 ].origin + anglestoforward( level.players[ 0 ].angles ) * 500 + ( 0, 0, 200 );
                node.angles = level.players[ 0 ].angles;
                namespace_b0d5e7f43c6af238::function_a0d4d8c69e61721c( node );
            }
            
            if ( getdvarint( @"hash_e04153469eda5d1d", 0 ) )
            {
                setdvar( @"hash_e04153469eda5d1d", 0 );
                node = spawnstruct();
                node.origin = level.players[ 0 ].origin + anglestoforward( level.players[ 0 ].angles ) * 500 + ( 0, 0, 200 );
                node.angles = level.players[ 0 ].angles;
                node namespace_ae33899132c54ba6::function_bd1f657f7943610d( node.origin, ( 0, 0, 20 ) );
            }
            
            wait 1;
        }
    }

#/
