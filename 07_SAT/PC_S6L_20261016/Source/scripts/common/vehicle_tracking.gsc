// scripts\common\vehicle_tracking.gsc  (hash_638ca7d8bce8e0be.gscc) (size: 11888 Bytes / 0x2e70 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd6fbdb93 (3606829971)
// size ...... 11888 (0x2e70)
// includes .. 4   (offset: 0x2c08)
// strings ... 17  (offset: 0x2c28)
// dev strs .. 29  (offset: 0x2d08)
// exports ... 32  (offset: 0x2060)
// cseg ...... 0x1fe + 0x1e62 (0x2060)
// imports ... 46  (offset: 0x2560)
// animtree1 . 0   (offset: 0x2e70)
// animtree2 . 0   (offset: 0x2e70)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_spawn;

#namespace vehicle_tracking;

// Namespace vehicle_tracking
// Params 2
// Checksum 0xe51353db, Offset: 0x21c
// Size: 0x225
function spawn_vehicle( spawndata, faildata )
{
    /#
        function_e0a8c3f4eeb707e( spawndata );
    #/
    
    if ( !can_spawn_vehicle() )
    {
        if ( isdefined( faildata ) )
        {
            faildata.fail = "total_limit_exceeded";
        }
        
        if ( level.debugvehiclespawns )
        {
            logstring( "VEHICLE_SPAWN_DEBUG: There's no room for " + spawndata.modelname + ", level.vehicleCount: " + level.vehiclecount + ", level.maxVehicleCount: " + level.maxvehiclecount );
            function_4cfe9b5ba30f80c4();
        }
        
        return;
    }
    
    if ( !spawndata vehicle_spawn::has_flag( 11 ) && utility::issharedfuncdefined( #"game", #"isvalidpointinbounds" ) )
    {
        if ( ![[ utility::getsharedfunc( #"game", #"isvalidpointinbounds" ) ]]( spawndata.origin ) )
        {
            if ( isdefined( faildata ) )
            {
                faildata.fail = "spawn_invalid_location";
            }
            
            return;
        }
    }
    
    vehicle = spawnvehicle( spawndata.modelname, spawndata.targetname ?? spawndata.script_vehicleref ?? spawndata.vehicletype, spawndata.vehicletype, spawndata.origin, spawndata.angles, spawndata.owner, spawndata.initialvelocity, spawndata.dospawnedcallback );
    
    if ( !isdefined( vehicle.vehiclename ) )
    {
        vehicle.vehiclename = spawndata.vehicletype;
    }
    
    if ( !isdefined( vehicle ) )
    {
        if ( isdefined( faildata ) )
        {
            faildata.fail = "total_limit_exceeded";
        }
        
        /#
            if ( level.debugvehiclespawns )
            {
                println( "<dev string:x24>" + spawndata.modelname );
            }
        #/
        
        return;
    }
    
    vehicle.spawndata = spawndata;
    level.vehiclecount++;
    callback::callback( #"vehicle_spawn", { #spawndata:spawndata, #vehicle:vehicle } );
    return vehicle;
}

// Namespace vehicle_tracking
// Params 2
// Checksum 0x8313f69f, Offset: 0x44a
// Size: 0xfe
function function_67616b82fb3a0d53( spawndata, faildata )
{
    /#
        function_e0a8c3f4eeb707e( spawndata );
    #/
    
    vehicle = spawn( "script_model", spawndata.origin );
    vehicle.angles = spawndata.angles;
    vehicle.targetname = spawndata.targetname ?? spawndata.script_vehicleref;
    vehicle.owner = spawndata.owner;
    vehicle.vehicletype = spawndata.vehicletype;
    vehicle.spawndata = spawndata;
    vehicle setmodel( spawndata.modelname );
    level.vehiclecount++;
    callback::callback( #"vehicle_spawn", { #spawndata:spawndata, #vehicle:vehicle } );
    return vehicle;
}

// Namespace vehicle_tracking
// Params 5
// Checksum 0x4158a37d, Offset: 0x551
// Size: 0x16f
function spawn_helicopter( owner, origin, angles, type, modelname )
{
    faildata = spawnstruct();
    spawndata = spawnstruct();
    spawndata.modelname = modelname;
    spawndata.vehicletype = type;
    spawndata.origin = origin;
    spawndata.angles = angles;
    spawndata.owner = owner;
    
    if ( !can_spawn_vehicle() )
    {
        if ( isdefined( faildata ) )
        {
            faildata.fail = "total_limit_exceeded";
        }
        
        return;
    }
    
    vehicle = utility::callsharedfunc( #"vehicle", #"spawnhelicopter", spawndata.owner, spawndata.origin, spawndata.angles, spawndata.vehicletype, spawndata.modelname );
    
    if ( !isdefined( vehicle ) )
    {
        if ( isdefined( faildata ) )
        {
            faildata.fail = "code";
        }
        
        return;
    }
    
    level.vehiclecount++;
    vehicle.spawndata = spawndata;
    callback::callback( #"helicopter_spawn", { #spawndata:spawndata, #vehicle:vehicle } );
    return vehicle;
}

// Namespace vehicle_tracking
// Params 1
// Checksum 0x11e268d9, Offset: 0x6c9
// Size: 0x52, Type: bool
function delete_vehicle( vehicle )
{
    if ( vehicle )
    {
        vehicle notify( #"vehicle_deleted" );
    }
    
    level.vehiclecount--;
    
    if ( isdefined( vehicle ) )
    {
        vehicle callback::callback( #"hash_e6c52cbe24abf037" );
        delete_linked_scriptables( vehicle );
        vehicle delete();
    }
    
    return true;
}

// Namespace vehicle_tracking
// Params 1, eflags: 0x4
// Checksum 0x8a089621, Offset: 0x724
// Size: 0x155
function private delete_linked_scriptables( vehicle )
{
    if ( !isdefined( vehicle.linkedchildren ) )
    {
        return;
    }
    
    foreach ( scriptable in vehicle.linkedchildren )
    {
        if ( !isdefined( scriptable ) )
        {
            continue;
        }
        
        if ( isdefined( scriptable.type ) && utility::issharedfuncdefined( scriptable.type, #"delete" ) && scriptable [[ utility::getsharedfunc( scriptable.type, #"delete" ) ]]() )
        {
            continue;
        }
        
        scriptable notify( #"death", vehicle.burndownattacker ?? vehicle );
        scriptable utility::script_func( "deregisterScriptable" );
        
        if ( scriptable getscriptableisreserved() )
        {
            scriptable freescriptable();
            continue;
        }
        
        part = scriptable function_84ad2f70189ee7c3();
        
        if ( scriptable getscriptableparthasstate( part, "hidden" ) )
        {
            scriptable setscriptablepartstate( part, "hidden" );
        }
    }
}

// Namespace vehicle_tracking
// Params 1
// Checksum 0xa104acbc, Offset: 0x881
// Size: 0x2b, Type: bool
function can_spawn_vehicle( count = 1 )
{
    return level.vehiclecount + count <= level.maxvehiclecount;
}

// Namespace vehicle_tracking
// Params 0
// Checksum 0xbcd0550b, Offset: 0x8b5
// Size: 0xb
function get_vehicle_count()
{
    return level.vehiclecount;
}

// Namespace vehicle_tracking
// Params 0
// Checksum 0x1989fa94, Offset: 0x8c9
// Size: 0x96
function function_c2c7b13ef5c4446e()
{
    count = 0;
    
    foreach ( vehicle in function_5820a38c9873992e() )
    {
        if ( vehicle get_base_spawn_data() vehicle_spawn::has_flag( 4 ) )
        {
            count += 1;
        }
    }
    
    return count;
}

// Namespace vehicle_tracking
// Params 1
// Checksum 0x76b9c20, Offset: 0x968
// Size: 0xae, Type: bool
function reserve_vehicle( count )
{
    if ( can_spawn_vehicle() )
    {
        if ( !isdefined( count ) )
        {
            level.vehiclecount++;
            return true;
        }
        
        availablevehicles = level.maxvehiclecount - level.vehiclecount;
        
        if ( count <= availablevehicles )
        {
            level.vehiclecount += count;
            return true;
        }
    }
    
    if ( level.debugvehiclespawns )
    {
        logstring( "VEHICLE_SPAWN_DEBUG: Failed to reserve for " + count + " vehicles" + ", level.vehicleCount: " + level.vehiclecount + ", level.maxVehicleCount: " + level.maxvehiclecount );
        function_4cfe9b5ba30f80c4();
    }
    
    return false;
}

// Namespace vehicle_tracking
// Params 1
// Checksum 0xf6f490ce, Offset: 0xa1f
// Size: 0x62
function function_4f76f5b4541acef1( count = 1 )
{
    level.vehiclecount -= count;
    
    /#
        if ( level.vehiclecount < 0 )
        {
            utility::error( "<dev string:x5b>" );
        }
    #/
    
    level.vehiclecount = int( max( 0, level.vehiclecount ) );
}

// Namespace vehicle_tracking
// Params 0
// Checksum 0xf38c7007, Offset: 0xa89
// Size: 0xb
function get_spawn_data()
{
    return self.spawndata;
}

// Namespace vehicle_tracking
// Params 0
// Checksum 0x648c3de2, Offset: 0xa9d
// Size: 0x1f
function get_base_spawn_data()
{
    if ( vehicle::is_husk() )
    {
        return self.basevehiclespawndata;
    }
    
    return get_spawn_data();
}

// Namespace vehicle_tracking
// Params 2
// Checksum 0xf60c444d, Offset: 0xac4
// Size: 0x23d
function function_2b6c8c165ab5f521( from, to )
{
    to.modelname = from.modelname;
    to.var_305ce2bb6ec0993d = from.var_305ce2bb6ec0993d;
    to.targetname = from.targetname;
    to.script_vehicleref = from.script_vehicleref;
    to.script_vehiclerefs = from.script_vehiclerefs;
    to.vehicletype = from.vehicletype;
    to.origin = from.origin;
    to.angles = from.angles;
    to.originalorigin = from.originalorigin;
    to.originalangles = from.originalangles;
    to.owner = from.owner;
    to.initialvelocity = from.initialvelocity;
    to.spawntype = from.spawntype;
    to.team = from.team;
    to.script_team = from.script_team;
    to.ref = from.ref;
    to.script_noteworthy = from.script_noteworthy;
    to.script_modelname = from.script_modelname;
    to.script_vehicle_lights_on = from.script_vehicle_lights_on;
    to.script_disconnectpaths = from.script_disconnectpaths;
    to.script_badplace = from.script_badplace;
    to.script_startinghealth = from.script_startinghealth;
    to.script_godmode = from.script_godmode;
    to.spawnflags = from.spawnflags;
}

// Namespace vehicle_tracking
// Params 3
// Checksum 0x974ca9c7, Offset: 0xd09
// Size: 0x11a
function register_instance( vehicle, owner, team )
{
    assert( isdefined( level.vehicle ), "<dev string:x9e>" );
    assert( isdefined( level.vehicle.instances ), "<dev string:xe2>" );
    assert( isdefined( vehicle vehicle::get_ref() ), "<dev string:x130>" );
    deregister_instance( vehicle );
    entitynumber = vehicle getentitynumber();
    level.vehicle.instances[ vehicle vehicle::get_ref() ][ entitynumber ] = vehicle;
    level.vehicle.all[ entitynumber ] = vehicle;
    
    if ( vehicle vehicle::can_fly() )
    {
        level.vehicle.aircraft[ entitynumber ] = vehicle;
    }
    else
    {
        level.vehicle.groundonly[ entitynumber ] = vehicle;
    }
    
    vehicle.vehicleowner = owner;
    vehicle.vehicleteam = team;
}

// Namespace vehicle_tracking
// Params 1
// Checksum 0x1f0db49e, Offset: 0xe2b
// Size: 0x66
function deregister_instance( vehicle )
{
    assert( isdefined( vehicle vehicle::get_ref() ), "<dev string:x176>" );
    vehicle_ref = vehicle vehicle::get_ref();
    entity_number = vehicle getentitynumber();
    function_beb20e6beba06994( vehicle_ref, entity_number );
    vehicle.vehicleowner = undefined;
    vehicle.vehicleteam = undefined;
}

// Namespace vehicle_tracking
// Params 2
// Checksum 0x13d14ba6, Offset: 0xe99
// Size: 0x130
function function_beb20e6beba06994( vehicle_ref, entity_number )
{
    if ( !isdefined( level.vehicle ) )
    {
        return;
    }
    
    if ( !( isdefined( level.vehicle.instances ) && isdefined( level.vehicle.all ) ) )
    {
        return;
    }
    
    if ( !isdefined( level.vehicle.instances[ vehicle_ref ] ) )
    {
        return;
    }
    
    level.vehicle.instances[ vehicle_ref ][ entity_number ] = undefined;
    level.vehicle.all[ entity_number ] = undefined;
    
    if ( isdefined( level.vehicle.aircraft[ entity_number ] ) )
    {
        level.vehicle.aircraft[ entity_number ] = undefined;
    }
    
    if ( isdefined( level.vehicle.groundonly[ entity_number ] ) )
    {
        level.vehicle.groundonly[ entity_number ] = undefined;
    }
    
    if ( level.vehicle.instances[ vehicle_ref ].size <= 0 )
    {
        level.vehicle.instances[ vehicle_ref ] = undefined;
    }
}

// Namespace vehicle_tracking
// Params 3
// Checksum 0x9d71bff0, Offset: 0xfd1
// Size: 0x108
function function_2b4ad1f3a68a848f( vehicleref, limit, message )
{
    assert( isdefined( level.vehicle ), "<dev string:x1be>" );
    assert( isdefined( level.vehicle.instances ), "<dev string:x202>" );
    
    if ( isstring( vehicleref ) && vehicle::has_data( vehicleref ) )
    {
        if ( level.projectbundle.var_53c4124af039142e )
        {
            if ( isdefined( vehicle::get_data( vehicleref ).vehicle ) )
            {
                vehicleref = vehicle::get_data( vehicleref ).vehicle;
            }
        }
        else if ( isdefined( vehicle::get_data( vehicleref ).bundlename ) )
        {
            vehicleref = vehicle::get_data( vehicleref ).bundlename;
        }
    }
    
    level.vehicle.instancelimits[ vehicleref ] = limit;
    level.vehicle.instancelimitmessages[ vehicleref ] = message;
}

// Namespace vehicle_tracking
// Params 3
// Checksum 0x8b19006a, Offset: 0x10e1
// Size: 0x123
function function_8d0cbf44f999d0f9( vehicleref, spawntype, limit )
{
    assert( isdefined( level.vehicle ), "<dev string:x1be>" );
    assert( isdefined( level.vehicle.instances ), "<dev string:x202>" );
    
    if ( isstring( vehicleref ) && vehicle::has_data( vehicleref ) )
    {
        if ( level.projectbundle.var_53c4124af039142e )
        {
            if ( isdefined( vehicle::get_data( vehicleref ).vehicle ) )
            {
                vehicleref = vehicle::get_data( vehicleref ).vehicle;
            }
        }
        else if ( isdefined( vehicle::get_data( vehicleref ).bundlename ) )
        {
            vehicleref = vehicle::get_data( vehicleref ).bundlename;
        }
    }
    
    if ( !isdefined( level.vehicle.spawntypeinstancelimits[ vehicleref ] ) )
    {
        level.vehicle.spawntypeinstancelimits[ vehicleref ] = [];
    }
    
    level.vehicle.spawntypeinstancelimits[ vehicleref ][ spawntype ] = limit;
}

// Namespace vehicle_tracking
// Params 3
// Checksum 0x88874f63, Offset: 0x120c
// Size: 0x108
function function_29d71103ac6897ea( vehicleref, limit, message )
{
    assert( isdefined( level.vehicle ), "<dev string:x24f>" );
    assert( isdefined( level.vehicle.instances ), "<dev string:x294>" );
    
    if ( isstring( vehicleref ) && vehicle::has_data( vehicleref ) )
    {
        if ( level.projectbundle.var_53c4124af039142e )
        {
            if ( isdefined( vehicle::get_data( vehicleref ).vehicle ) )
            {
                vehicleref = vehicle::get_data( vehicleref ).vehicle;
            }
        }
        else if ( isdefined( vehicle::get_data( vehicleref ).bundlename ) )
        {
            vehicleref = vehicle::get_data( vehicleref ).bundlename;
        }
    }
    
    level.vehicle.ownerinstancelimits[ vehicleref ] = limit;
    level.vehicle.ownerinstancelimitmessages[ vehicleref ] = message;
}

// Namespace vehicle_tracking
// Params 3
// Checksum 0x3eec1611, Offset: 0x131c
// Size: 0x108
function function_5e28a72fa076ebb8( vehicleref, limit, message )
{
    assert( isdefined( level.vehicle ), "<dev string:x2e2>" );
    assert( isdefined( level.vehicle.instances ), "<dev string:x326>" );
    
    if ( isstring( vehicleref ) && vehicle::has_data( vehicleref ) )
    {
        if ( level.projectbundle.var_53c4124af039142e )
        {
            if ( isdefined( vehicle::get_data( vehicleref ).vehicle ) )
            {
                vehicleref = vehicle::get_data( vehicleref ).vehicle;
            }
        }
        else if ( isdefined( vehicle::get_data( vehicleref ).bundlename ) )
        {
            vehicleref = vehicle::get_data( vehicleref ).bundlename;
        }
    }
    
    level.vehicle.teaminstancelimits[ vehicleref ] = limit;
    level.vehicle.teaminstancelimitmessages[ vehicleref ] = message;
}

// Namespace vehicle_tracking
// Params 5
// Checksum 0x3f88be85, Offset: 0x142c
// Size: 0x32f, Type: bool
function function_279695c41be653f( vehicleref, owner, team, spawntype, sendmessage )
{
    assert( isdefined( level.vehicle ), "<dev string:x373>" );
    assert( isdefined( level.vehicle.instances ), "<dev string:x3b4>" );
    
    if ( isstring( vehicleref ) && vehicle::has_data( vehicleref ) )
    {
        if ( level.projectbundle.var_53c4124af039142e )
        {
            if ( isdefined( vehicle::get_data( vehicleref ).vehicle ) )
            {
                vehicleref = vehicle::get_data( vehicleref ).vehicle;
            }
        }
        else if ( isdefined( vehicle::get_data( vehicleref ).bundlename ) )
        {
            vehicleref = vehicle::get_data( vehicleref ).bundlename;
        }
    }
    
    if ( !isdefined( level.vehicle.instances[ vehicleref ] ) )
    {
        return false;
    }
    
    gamelimit = level.vehicle.instancelimits[ vehicleref ];
    
    if ( isdefined( gamelimit ) )
    {
        if ( level.vehicle.instances[ vehicleref ].size >= gamelimit )
        {
            return true;
        }
    }
    
    spawntypelimit = undefined;
    spawntypecount = undefined;
    
    if ( isdefined( spawntype ) && isdefined( level.vehicle.spawntypeinstancelimits[ vehicleref ][ spawntype ] ) )
    {
        spawntypelimit = level.vehicle.spawntypeinstancelimits[ vehicleref ][ spawntype ];
        spawntypecount = 0;
    }
    
    ownerlimit = undefined;
    ownercount = undefined;
    
    if ( isdefined( owner ) )
    {
        ownerlimit = level.vehicle.ownerinstancelimits[ vehicleref ];
        ownercount = 0;
    }
    
    teamlimit = undefined;
    teamcount = undefined;
    
    if ( isdefined( team ) )
    {
        teamlimit = level.vehicle.teaminstancelimits[ vehicleref ];
        teamcount = 0;
    }
    
    if ( !isdefined( ownerlimit ) && !isdefined( teamlimit ) && !isdefined( spawntypelimit ) )
    {
        return false;
    }
    
    foreach ( instance in level.vehicle.instances[ vehicleref ] )
    {
        if ( isdefined( ownerlimit ) && instance.vehicleowner == owner )
        {
            ownercount++;
            
            if ( ownercount >= ownerlimit )
            {
                return true;
            }
        }
        
        if ( isdefined( teamlimit ) && instance.vehicleteam == team )
        {
            teamcount++;
            
            if ( teamcount >= teamlimit )
            {
                return true;
            }
        }
        
        if ( isdefined( spawntypelimit ) && isdefined( instance.spawndata ) && instance.spawndata.spawntype == spawntype )
        {
            spawntypecount++;
            
            if ( spawntypecount >= spawntypelimit )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace vehicle_tracking
// Params 1
// Checksum 0x6ec90a72, Offset: 0x1764
// Size: 0xf9
function get_game_instances( vehicleref )
{
    assert( isdefined( level.vehicle ), "<dev string:x3fe>" );
    assert( isdefined( level.vehicle.instances ), "<dev string:x440>" );
    
    if ( isstring( vehicleref ) && vehicle::has_data( vehicleref ) )
    {
        if ( level.projectbundle.var_53c4124af039142e )
        {
            if ( isdefined( vehicle::get_data( vehicleref ).vehicle ) )
            {
                vehicleref = vehicle::get_data( vehicleref ).vehicle;
            }
        }
        else if ( isdefined( vehicle::get_data( vehicleref ).bundlename ) )
        {
            vehicleref = vehicle::get_data( vehicleref ).bundlename;
        }
    }
    
    if ( !isdefined( level.vehicle.instances[ vehicleref ] ) )
    {
        return [];
    }
    
    return level.vehicle.instances[ vehicleref ];
}

// Namespace vehicle_tracking
// Params 2
// Checksum 0x87675ba2, Offset: 0x1866
// Size: 0x18e
function get_owner_instances( vehicleref, owner )
{
    assert( isdefined( level.vehicle ), "<dev string:x48b>" );
    assert( isdefined( level.vehicle.instances ), "<dev string:x4ce>" );
    
    if ( isstring( vehicleref ) && vehicle::has_data( vehicleref ) )
    {
        if ( level.projectbundle.var_53c4124af039142e )
        {
            if ( isdefined( vehicle::get_data( vehicleref ).vehicle ) )
            {
                vehicleref = vehicle::get_data( vehicleref ).vehicle;
            }
        }
        else if ( isdefined( vehicle::get_data( vehicleref ).bundlename ) )
        {
            vehicleref = vehicle::get_data( vehicleref ).bundlename;
        }
    }
    
    if ( !isdefined( level.vehicle.instances[ vehicleref ] ) )
    {
        return [];
    }
    
    instances = [];
    
    foreach ( instance in level.vehicle.instances[ vehicleref ] )
    {
        if ( instance.vehicleowner == owner )
        {
            instances[ instances.size ] = instance;
        }
    }
    
    return instances;
}

// Namespace vehicle_tracking
// Params 2
// Checksum 0x5901d649, Offset: 0x19fd
// Size: 0x18e
function get_team_instances( vehicleref, team )
{
    assert( isdefined( level.vehicle ), "<dev string:x51a>" );
    assert( isdefined( level.vehicle.instances ), "<dev string:x55c>" );
    
    if ( isstring( vehicleref ) && vehicle::has_data( vehicleref ) )
    {
        if ( level.projectbundle.var_53c4124af039142e )
        {
            if ( isdefined( vehicle::get_data( vehicleref ).vehicle ) )
            {
                vehicleref = vehicle::get_data( vehicleref ).vehicle;
            }
        }
        else if ( isdefined( vehicle::get_data( vehicleref ).bundlename ) )
        {
            vehicleref = vehicle::get_data( vehicleref ).bundlename;
        }
    }
    
    if ( !isdefined( level.vehicle.instances[ vehicleref ] ) )
    {
        return [];
    }
    
    instances = [];
    
    foreach ( instance in level.vehicle.instances[ vehicleref ] )
    {
        if ( instance.vehicleteam == team )
        {
            instances[ instances.size ] = instance;
        }
    }
    
    return instances;
}

// Namespace vehicle_tracking
// Params 0
// Checksum 0x66301d3, Offset: 0x1b94
// Size: 0x2c
function function_5820a38c9873992e()
{
    assert( isdefined( level.vehicle ), "<dev string:x5a7>" );
    return level.vehicle.all;
}

// Namespace vehicle_tracking
// Params 1
// Checksum 0xa6de6c4e, Offset: 0x1bc9
// Size: 0x13b, Type: bool
function function_b77f352821482252( vehicleref )
{
    assert( isdefined( level.vehicle ), "<dev string:x5ef>" );
    assert( isdefined( level.vehicle.instances ), "<dev string:x634>" );
    
    if ( isstring( vehicleref ) && vehicle::has_data( vehicleref ) )
    {
        if ( level.projectbundle.var_53c4124af039142e )
        {
            if ( isdefined( vehicle::get_data( vehicleref ).vehicle ) )
            {
                vehicleref = vehicle::get_data( vehicleref ).vehicle;
            }
        }
        else if ( isdefined( vehicle::get_data( vehicleref ).bundlename ) )
        {
            vehicleref = vehicle::get_data( vehicleref ).bundlename;
        }
    }
    
    if ( isdefined( level.vehicle.instancelimits[ vehicleref ] ) )
    {
        return true;
    }
    
    if ( isdefined( level.vehicle.ownerinstancelimits[ vehicleref ] ) )
    {
        return true;
    }
    
    if ( isdefined( level.vehicle.teaminstancelimits[ vehicleref ] ) )
    {
        return true;
    }
    
    if ( isdefined( level.vehicle.spawntypeinstancelimits[ vehicleref ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace vehicle_tracking
// Params 0
// Checksum 0x81f92a83, Offset: 0x1d0d
// Size: 0x146
function init()
{
    assert( isdefined( level.vehicle ), "<dev string:x682>" );
    assert( !isdefined( level.vehicle.instances ), "<dev string:x6b8>" );
    level.vehicle.instances = [];
    level.vehicle.all = [];
    level.vehicle.aircraft = [];
    level.vehicle.groundonly = [];
    level.vehicle.instancelimits = [];
    level.vehicle.ownerinstancelimits = [];
    level.vehicle.teaminstancelimits = [];
    level.vehicle.spawntypeinstancelimits = [];
    level.vehicle.instancelimitmessages = [];
    level.vehicle.ownerinstancelimitmessages = [];
    level.vehicle.teaminstancelimitmessages = [];
    level.vehiclecount = 0;
    level.maxvehiclecount = getdvarint( @"scr_maxvehiclecount", function_5426ab0abe3e55b5() );
}

// Namespace vehicle_tracking
// Params 1
// Checksum 0x61b55225, Offset: 0x1e5b
// Size: 0x41, Type: bool
function validate_spawn_data( spawndata )
{
    if ( !isdefined( spawndata ) )
    {
        thread utility::error( "spawnData must be defined." );
        return false;
    }
    
    if ( !isdefined( spawndata.origin ) )
    {
        thread utility::error( "spawnData.origin must be defined." );
        return false;
    }
    
    return true;
}

// Namespace vehicle_tracking
// Params 0
// Checksum 0x1c982617, Offset: 0x1ea5
// Size: 0xb3
function function_4cfe9b5ba30f80c4()
{
    logstring( " --- TRACKED VEHICLES LIST --- " );
    
    foreach ( vehicle in level.vehicle.all )
    {
        logstring( " [" + vehicle getentitynumber() + "] " + vehicle.vehiclename );
    }
    
    logstring( " --- TRACKED VEHICLES LIST /END --- " );
}

/#

    // Namespace vehicle_tracking
    // Params 1
    // Checksum 0x4ff6e84a, Offset: 0x1f60
    // Size: 0x7e, Type: dev
    function function_e0a8c3f4eeb707e( spawndata )
    {
        if ( !validate_spawn_data( spawndata ) )
        {
            return 0;
        }
        
        if ( !isdefined( spawndata.vehicletype ) )
        {
            thread utility::error( "<dev string:x6ec>" );
            return 0;
        }
        
        if ( !isdefined( spawndata.targetname ) && !isdefined( spawndata.script_vehicleref ) && !isdefined( spawndata.script_vehiclebundle ) )
        {
            thread utility::error( "<dev string:x713>" );
            return 0;
        }
        
        return 1;
    }

    // Namespace vehicle_tracking
    // Params 1
    // Checksum 0x77227d38, Offset: 0x1fe6
    // Size: 0x7a, Type: dev
    function function_6b6a0c78a4707c87( spawndata )
    {
        if ( !validate_spawn_data( spawndata ) )
        {
            return 0;
        }
        
        if ( !isdefined( spawndata.owner ) )
        {
            thread utility::error( "<dev string:x758>" );
            return 0;
        }
        
        if ( !isdefined( spawndata.vehicletype ) )
        {
            thread utility::error( "<dev string:x6ec>" );
            return 0;
        }
        
        if ( !isdefined( spawndata.modelname ) )
        {
            thread utility::error( "<dev string:x779>" );
            return 0;
        }
        
        return 1;
    }

#/
