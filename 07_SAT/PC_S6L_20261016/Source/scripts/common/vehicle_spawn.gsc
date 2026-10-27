// scripts\common\vehicle_spawn.gsc  (hash_71e858823f74bbe8.gscc) (size: 17548 Bytes / 0x448c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf1c81721 (4056422177)
// size ...... 17548 (0x448c)
// includes .. 6   (offset: 0x4208)
// strings ... 22  (offset: 0x4238)
// dev strs .. 24  (offset: 0x4364)
// exports ... 46  (offset: 0x2da4)
// cseg ...... 0x200 + 0x2ba4 (0x2da4)
// imports ... 103 (offset: 0x34d4)
// animtree1 . 0   (offset: 0x448c)
// animtree2 . 0   (offset: 0x448c)
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_omnvar_utility;
#using scripts\common\vehicle_tracking;

#namespace vehicle_spawn;

// Namespace vehicle_spawn
// Params 2
// Checksum 0xa39302f1, Offset: 0x21e
// Size: 0xd2
function get_data( vehicleref, create )
{
    if ( create && ( !vehicle::has_data( vehicleref ) || !isdefined( vehicle::get_data( vehicleref ).spawn ) ) )
    {
        data = undefined;
        
        if ( !vehicle::has_data( vehicleref ) )
        {
            data = spawnstruct();
        }
        else
        {
            data = vehicle::get_data( vehicleref );
        }
        
        data.spawn = spawnstruct();
        data.spawn.maxinstancecount = 0;
        data.spawn.priority = 50;
        vehicle::add_data( vehicleref, data );
    }
    
    if ( vehicle::has_data( vehicleref ) )
    {
        return vehicle::get_data( vehicleref ).spawn;
    }
}

// Namespace vehicle_spawn
// Params 2
// Checksum 0x182063f4, Offset: 0x2f8
// Size: 0x231
function prepare_spawn_data( vehicleref, spawndata )
{
    if ( !isdefined( spawndata.angles ) )
    {
        spawndata.angles = ( 0, 0, 0 );
    }
    
    data = vehicle::get_data( vehicleref );
    spawndata.script_vehicleref = data.ref;
    
    if ( isdefined( spawndata.vehicleoverride ) )
    {
        spawndata.vehicletype = spawndata.vehicleoverride;
    }
    else if ( spawndata.initai && isdefined( data.ai.vehicle ) )
    {
        spawndata.vehicletype = data.ai.vehicle;
    }
    else if ( isdefined( data.vehicle ) )
    {
        spawndata.vehicletype = data.vehicle;
    }
    
    model = data.model;
    
    if ( isdefined( spawndata.script_modelname ) )
    {
        model = spawndata.script_modelname;
    }
    else if ( spawndata.initai && isdefined( data.ai.model ) )
    {
        model = data.ai.model;
    }
    
    if ( isdefined( spawndata.var_305ce2bb6ec0993d ) )
    {
        skin = utility::array_random( strtok( spawndata.var_305ce2bb6ec0993d, "," ) );
        
        if ( skin != "base" )
        {
            spawndata.modelname = skin + "::" + model;
        }
        else
        {
            spawndata.modelname = model;
        }
    }
    else if ( data.skinoverride && model == data.model )
    {
        spawndata.modelname = data.skinoverride + "::" + model;
    }
    else
    {
        spawndata.modelname = model;
    }
    
    return spawndata;
}

// Namespace vehicle_spawn
// Params 3
// Checksum 0x6f35174a, Offset: 0x532
// Size: 0x190
function function_456e98b54b607964( vehicleref, spawndata, fallbackvehicletype )
{
    if ( !isdefined( spawndata.angles ) )
    {
        spawndata.angles = ( 0, 0, 0 );
    }
    
    data = vehicle::get_data( vehicleref );
    spawndata.script_vehicleref = data.husk.ref;
    spawndata.vehicletype = data.husk.vehicle ?? data.vehicle;
    
    if ( data.husk.var_883a7fffbc09c22f && isdefined( data.husk.models ) && data.husk.models.size > 0 )
    {
        modelstruct = utility::array_random( data.husk.models );
        spawndata.modelname = modelstruct.compositemodel ?? modelstruct.model;
    }
    else
    {
        spawndata.modelname = data.husk.model;
    }
    
    if ( !isdefined( spawndata.vehicletype ) )
    {
        spawndata.vehicletype = fallbackvehicletype;
    }
    
    spawndata.dospawnedcallback = 0;
    return spawndata;
}

// Namespace vehicle_spawn
// Params 2
// Checksum 0x9350fa0e, Offset: 0x6cb
// Size: 0x20e
function create_husk_spawn_data( vehicle, vehicleref )
{
    data = vehicle::get_data( vehicleref );
    spawndata = spawnstruct();
    spawndata.origin = vehicle.origin;
    spawndata.angles = vehicle.angles;
    spawndata.initialvelocity = anglestoup( vehicle.angles ) * data.husk.belowvelocityscale;
    spawndata.damageableparts = vehicle_damage::function_62b5a7480945627a( vehicleref, vehicle.damageableparts );
    spawndata.basevehiclespawndata = vehicle vehicle_tracking::get_spawn_data();
    spawndata.contents = vehicle.contents;
    spawndata.mtx = vehicle.mtx;
    spawndata.var_5c2a5a3e858d8962 = vehicle.var_5c2a5a3e858d8962;
    spawndata.skiphusklaunch = vehicle.skiphusklaunch;
    
    if ( isdefined( vehicle_occupancy::function_921d1edcf33652ee( vehicleref, "driver" ) ) )
    {
        spawndata.var_6b0d261794318b6d = vectortoangles( rotatevectorinverted( anglestoforward( vehicle getturretworldangles() ), vehicle.angles ) );
    }
    
    if ( isdefined( spawndata.basevehiclespawndata ) )
    {
        spawndata.var_305ce2bb6ec0993d = spawndata.basevehiclespawndata.var_305ce2bb6ec0993d;
    }
    
    if ( vehicle vehicle_getspeed() > data.husk.momentumthreshold )
    {
        spawndata.initialvelocity = vehicle vehicle_getvelocity() * data.husk.abovevelocityscale;
    }
    
    spawndata.isphysicsvehicle = vehicle vehicle_isphysveh();
    spawndata.isamphibious = vehicle function_5bf8fedff42637e2();
    spawndata.isgroundvehicle = vehicle vehphys_isgroundvehicle();
    return spawndata;
}

// Namespace vehicle_spawn
// Params 2
// Checksum 0x1990d51, Offset: 0x8e2
// Size: 0x47
function function_ab128b19257dc458( vehicleref, basevehiclespawndata )
{
    basevehiclespawndata.script_vehicleref = vehicleref;
    huskspawndata = { #basevehiclespawndata:basevehiclespawndata };
    vehicle_tracking::function_2b6c8c165ab5f521( basevehiclespawndata, huskspawndata );
    return huskspawndata;
}

// Namespace vehicle_spawn
// Params 4
// Checksum 0x383a7432, Offset: 0x932
// Size: 0x2b6
function can_spawn_vehicle( vehicleref, owner, team, spawntype )
{
    /#
        if ( level.debugvehiclespawns )
        {
            println( "<dev string:x24>" + ( getxhashsourcename( vehicleref ) ?? "<dev string:x54>" ) );
        }
    #/
    
    if ( !isdefined( vehicleref ) )
    {
        /#
            if ( level.debugvehiclespawns )
            {
                println( "<dev string:x5e>" );
            }
        #/
        
        return 0;
    }
    
    if ( !vehicle::has_data( vehicleref ) )
    {
        /#
            if ( level.debugvehiclespawns )
            {
                println( "<dev string:x8d>" + getxhashsourcename( vehicleref ) );
            }
        #/
        
        return 0;
    }
    
    data = vehicle::get_data( vehicleref );
    spawndata = get_data( vehicleref );
    
    if ( !data || !spawndata )
    {
        /#
            if ( level.debugvehiclespawns )
            {
                println( "<dev string:xbf>" + getxhashsourcename( vehicleref ) );
            }
        #/
        
        return 0;
    }
    
    vehicleref = data.ref;
    
    if ( !vehicleref )
    {
        /#
            if ( level.debugvehiclespawns )
            {
                println( "<dev string:xf9>" + data.vehicle );
            }
        #/
        
        return 0;
    }
    
    if ( !vehicle_tracking::can_spawn_vehicle() )
    {
        /#
            if ( level.debugvehiclespawns )
            {
                println( "<dev string:x13b>" + vehicleref + "<dev string:x178>" + vehicle_tracking::get_vehicle_count() + "<dev string:x17a>" + level.maxvehiclecount );
            }
        #/
        
        return 0;
    }
    
    if ( utility::issharedfuncdefined( #"vehicle_spawn", #"canspawnvehicle" ) && !utility::callsharedfunc( #"vehicle_spawn", #"canspawnvehicle", vehicleref ) )
    {
        /#
            if ( level.debugvehiclespawns )
            {
                println( "<dev string:x17e>" + vehicleref );
            }
        #/
        
        return 0;
    }
    
    if ( vehicle_tracking::function_b77f352821482252( vehicleref ) && vehicle_tracking::function_279695c41be653f( vehicleref, owner, team, spawntype ) )
    {
        /#
            if ( level.debugvehiclespawns )
            {
                println( "<dev string:x1ce>" + vehicleref );
            }
        #/
        
        return 0;
    }
    
    if ( !level.ignorevehicletypeinstancelimit && isdefined( spawndata.maxinstancecount ) && vehicle_tracking::get_game_instances( vehicleref ).size >= spawndata.maxinstancecount )
    {
        /#
            if ( level.debugvehiclespawns )
            {
                println( "<dev string:x206>" + vehicleref );
            }
        #/
        
        return 0;
    }
    
    if ( getdvarint( hashcat( @"hash_e4fa5e1677f011e4", vehicleref ), 1 ) == 0 )
    {
        /#
            if ( level.debugvehiclespawns )
            {
                println( "<dev string:x23d>" + vehicleref );
            }
        #/
        
        return 0;
    }
    
    if ( isdefined( spawndata.canspawncallback ) )
    {
        return [[ spawndata.canspawncallback ]]( owner, team );
    }
    
    return 1;
}

// Namespace vehicle_spawn
// Params 1
// Checksum 0x6481bc22, Offset: 0xbf0
// Size: 0x2ca
function get_point_spawn_structs( structnameoptional )
{
    while ( !level.var_3985cc8cf0923257 )
    {
        waitframe();
    }
    
    var_e58c88b8ee826d55 = [];
    
    foreach ( ref, data in level.var_a7bf93687486b5ba )
    {
        if ( isstring( ref ) )
        {
            continue;
        }
        
        if ( !( isdefined( data.spawn ) && isdefined( data.spawn.var_33390c2e78b276d9 ) ) )
        {
            continue;
        }
        
        var_e58c88b8ee826d55[ data.spawn.var_33390c2e78b276d9 ] = data;
    }
    
    points = [];
    structs = [];
    
    foreach ( targetname, data in var_e58c88b8ee826d55 )
    {
        structs = arraycombine( structs, utility::getstructarray( targetname, "targetname" ) );
    }
    
    foreach ( struct in structs )
    {
        if ( !isdefined( struct.script_noteworthy ) )
        {
            continue;
        }
        
        num = -1;
        
        switch ( tolower( struct.script_noteworthy ) )
        {
            case #"hash_31103fbc01bd840c":
                num = 0;
                break;
            case #"hash_311042bc01bd88c5":
                num = 1;
                break;
            case #"hash_311041bc01bd8732":
                num = 2;
                break;
            case #"hash_31103cbc01bd7f53":
                num = 3;
                break;
            case #"hash_31103bbc01bd7dc0":
                num = 4;
                break;
        }
        
        if ( num == -1 )
        {
            continue;
        }
        
        points[ num ] = [ var_e58c88b8ee826d55[ struct.script_vehicleref ].ref, struct.origin, struct.angles, struct.script_team ];
    }
    
    return points;
}

// Namespace vehicle_spawn
// Params 6
// Checksum 0x21709492, Offset: 0xec3
// Size: 0x160
function add_spawn_struct( vehicleref, origin, angles, targetname, vehicletype, script_noteworthy )
{
    if ( !( isdefined( vehicleref ) && isdefined( origin ) ) )
    {
        assertmsg( "<dev string:x276>" );
        return;
    }
    
    if ( !isdefined( vehicletype ) )
    {
        vehicletype = get_vehicle_asset( vehicleref );
    }
    
    if ( !isdefined( vehicletype ) )
    {
        assertmsg( "<dev string:x2c9>" + getxhashsourcename( vehicleref ) + "<dev string:x2f9>" );
        return;
    }
    
    struct = spawnstruct();
    struct.origin = origin;
    struct.angles = angles;
    struct.targetname = targetname;
    
    if ( isstring( vehicleref ) )
    {
        struct.script_vehicleref = vehicleref;
    }
    else if ( isxhashasset( vehicleref ) )
    {
        struct.script_vehiclebundle = vehicleref;
    }
    
    struct.vehicletype = vehicletype;
    struct.script_noteworthy = script_noteworthy;
    vehiclehash = vehicle::function_451bd53633bae879( vehicleref );
    
    if ( !isdefined( level.vehicle_spawns[ vehiclehash ] ) )
    {
        level.vehicle_spawns[ vehiclehash ] = [];
    }
    
    level.vehicle_spawns[ vehiclehash ][ level.vehicle_spawns[ vehiclehash ].size ] = struct;
    utility::addstruct( struct );
}

// Namespace vehicle_spawn
// Params 4
// Checksum 0xc55de9ca, Offset: 0x102b
// Size: 0x1fc
function get_spawn_structs( vehicleref, requireflags, excludeflags, randomizespawns = 1 )
{
    if ( !isdefined( vehicleref ) )
    {
        return [];
    }
    
    if ( !isdefined( requireflags ) )
    {
        requireflags = [];
    }
    
    if ( !isdefined( excludeflags ) )
    {
        excludeflags = [ 1, 2, 4 ];
    }
    
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
    
    structs = level.vehicle_spawns[ vehicleref ];
    
    if ( !isdefined( structs ) || structs.size == 0 )
    {
        return [];
    }
    
    foreach ( flag in requireflags )
    {
        structs = function_c099079754c457aa( structs, flag );
    }
    
    foreach ( flag in excludeflags )
    {
        structs = function_4c65f104a4b40ec3( structs, flag );
    }
    
    if ( randomizespawns && structs.size > 1 )
    {
        structs = arrayrandomize( structs );
    }
    
    return structs;
}

// Namespace vehicle_spawn
// Params 0
// Checksum 0xfe2145fd, Offset: 0x1230
// Size: 0x88
function get_all_spawn_structs()
{
    allstructs = [];
    
    foreach ( structs in level.vehicle_spawns )
    {
        allstructs = arraycombineunique( allstructs, structs );
    }
    
    return allstructs;
}

// Namespace vehicle_spawn
// Params 1
// Checksum 0x664ff816, Offset: 0x12c1
// Size: 0x42
function get_vehicle_asset( vehicleref )
{
    if ( !vehicle::has_data( vehicleref ) )
    {
        return;
    }
    
    data = vehicle::get_data( vehicleref );
    
    if ( isdefined( data ) )
    {
        return data.vehicle;
    }
}

// Namespace vehicle_spawn
// Params 2
// Checksum 0xc33e506f, Offset: 0x130b
// Size: 0xc8
function function_4c65f104a4b40ec3( spawnstructs, bit )
{
    flagmask = 1 << bit - 1;
    filteredstructs = [];
    
    foreach ( struct in spawnstructs )
    {
        if ( isdefined( struct.spawnflags ) && struct.spawnflags & flagmask )
        {
            continue;
        }
        
        filteredstructs[ filteredstructs.size ] = struct;
    }
    
    return filteredstructs;
}

// Namespace vehicle_spawn
// Params 2
// Checksum 0x62445173, Offset: 0x13dc
// Size: 0xc5
function function_c099079754c457aa( spawnstructs, bit )
{
    flagmask = 1 << bit - 1;
    filteredstructs = [];
    
    foreach ( struct in spawnstructs )
    {
        if ( isdefined( struct.spawnflags ) && struct.spawnflags & flagmask )
        {
            filteredstructs[ filteredstructs.size ] = struct;
        }
    }
    
    return filteredstructs;
}

// Namespace vehicle_spawn
// Params 2
// Checksum 0x4a715cc1, Offset: 0x14aa
// Size: 0x7b
function set_flag( flag, bool = 1 )
{
    if ( !isdefined( self.spawnflags ) )
    {
        self.spawnflags = 0;
    }
    
    mask = 1 << flag - 1;
    
    if ( bool )
    {
        self.spawnflags |= mask;
        return;
    }
    
    self.spawnflags &= ~mask;
}

// Namespace vehicle_spawn
// Params 1
// Checksum 0x3985a522, Offset: 0x152d
// Size: 0x31, Type: bool
function has_flag( flag )
{
    return isdefined( self ) && isdefined( self.spawnflags ) && self.spawnflags & 1 << flag - 1;
}

// Namespace vehicle_spawn
// Params 0
// Checksum 0xe2057b24, Offset: 0x1567
// Size: 0x40
function function_7cb78fe251a14b5b()
{
    defaultvalue = !isdefined( level.gametypebundle ) || !level.gametypebundle.var_b220cf080f65ec52;
    return getdvarint( @"hash_bd25469fa7e9f44f", defaultvalue );
}

// Namespace vehicle_spawn
// Params 0
// Checksum 0x818f92ee, Offset: 0x15b0
// Size: 0x1f3
function function_e4d68d1fa03b6917()
{
    if ( !isdefined( level.var_a7bf93687486b5ba ) )
    {
        return;
    }
    
    utility::flag_wait( "scriptables_ready" );
    
    if ( utility::issharedfuncdefined( #"vehiclespawn", #"shouldspawnvehicles" ) && !utility::callsharedfunc( #"vehiclespawn", #"shouldspawnvehicles" ) )
    {
        return;
    }
    
    foreach ( vehicleref in vehicle::function_75acd2d48a8f3605( 1 ) )
    {
        if ( !can_spawn_vehicle( vehicleref ) )
        {
            continue;
        }
        
        foreach ( spawn in get_spawn_structs( vehicleref, [ 4 ], [ 1, 2 ] ) )
        {
            if ( utility::callsharedfunc( #"poi", #"isSystemActive" ) && !utility::callsharedfunc( #"poi", #"isactive", spawn.origin ) )
            {
                continue;
            }
            
            if ( isdefined( spawn.used ) )
            {
                continue;
            }
            
            spawn.used = 1;
            
            if ( isdefined( level.var_3908518e49f7ee02 ) )
            {
                spawn.script_team = [[ level.var_3908518e49f7ee02 ]]( spawn.script_team );
            }
            
            spawn vehicle::function_dcbcdc00863e94d6();
        }
    }
}

// Namespace vehicle_spawn
// Params 0
// Checksum 0x1cc3a3f2, Offset: 0x17ab
// Size: 0x287
function init()
{
    assert( isdefined( level.vehicle ), "<dev string:x336>" );
    assert( !isdefined( level.vehicle.spawn ), "<dev string:x369>" );
    leveldata = spawnstruct();
    level.vehicle.spawn = leveldata;
    leveldata.databyref = [];
    leveldata.spawnfromstructsdelayornotify = 5;
    
    if ( utility::callsharedfunc( #"game", #"isusingmatchrulesdata" ) )
    {
        leveldata.respawndelaymatchrules = utility::callsharedfunc( #"game", #"getmatchrulesdata", "commonOption", "vehicleRespawnDelay" ) ?? 0;
        leveldata.abandonedtimeoutmatchrules = utility::callsharedfunc( #"game", #"getmatchrulesdata", "commonOption", "vehicleAbandonedTimeout" ) ?? 0;
        leveldata.vehicleAbandonedTimeoutEnabled = utility::callsharedfunc( #"game", #"getmatchrulesdata", "commonOption", "vehicleAbandonedTimeoutEnabled" ) ?? 1;
        leveldata.vehicleHuskTimeoutEnabled = utility::callsharedfunc( #"game", #"getmatchrulesdata", "commonOption", "vehicleHuskTimeoutEnabled" ) ?? 1;
    }
    else
    {
        leveldata.respawndelaymatchrules = 0;
        leveldata.abandonedtimeoutmatchrules = 0;
        leveldata.vehicleAbandonedTimeoutEnabled = 0;
        leveldata.vehicleHuskTimeoutEnabled = 0;
    }
    
    leveldata.respawndelayoverride = getdvarint( @"hash_1f347fd0c3d771a2", 0 );
    leveldata.abandonedtimeoutoverride = getdvarint( @"hash_e547fe8dfe1679f6", 0 );
    leveldata.respawndelay = getdvarint( @"hash_8fdbbb498db9480a", 60 );
    leveldata.abandonedtimeoutdelay = getdvarint( @"hash_36374c04e23480b6", 30 );
    
    /#
        level.debugvehiclespawns = getdvarint( @"scr_vehicle_spawn_debug", 0 ) == 1;
    #/
    
    init_spawn_clearance();
    utility::callsharedfunc( #"vehicle_spawn", #"init" );
    level.ignorevehicletypeinstancelimit = getdvarint( @"hash_37f76437c65cd04e", 1 );
    init_late();
    
    if ( level.projectbundle.var_53c4124af039142e )
    {
        level thread find_vehicle_spawns();
        return;
    }
    
    level thread function_e299a3a85c5104f8();
}

// Namespace vehicle_spawn
// Params 0, eflags: 0x4
// Checksum 0xa8dc156c, Offset: 0x1a3a
// Size: 0x38
function private init_late()
{
    if ( utility::issharedfuncdefined( #"vehicle_spawn", #"initLate" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_spawn", #"initLate" ) ]]();
    }
}

// Namespace vehicle_spawn
// Params 0, eflags: 0x4
// Checksum 0x7adc065, Offset: 0x1a7a
// Size: 0x3c7
function private function_e299a3a85c5104f8()
{
    level.vehicle_spawns = [];
    var_9dc8537849d839c2 = [];
    
    foreach ( key, array in level.struct_class_names[ "script_vehicleref" ] )
    {
        foreach ( struct in array )
        {
            if ( isstring( struct.script_vehiclerefs ) )
            {
                foreach ( vehicleref in strtok( struct.script_vehiclerefs, "," ) )
                {
                    if ( !isdefined( var_9dc8537849d839c2[ vehicleref ] ) )
                    {
                        var_9dc8537849d839c2[ vehicleref ] = vehicle::function_451bd53633bae879( vehicleref ) ?? 0;
                    }
                    
                    hash = var_9dc8537849d839c2[ vehicleref ];
                    
                    if ( !hash )
                    {
                        /#
                            if ( level.debugvehiclespawns )
                            {
                                println( "<dev string:x39a>" + vehicleref );
                            }
                        #/
                        
                        continue;
                    }
                    
                    if ( !isdefined( level.vehicle_spawns[ hash ] ) )
                    {
                        level.vehicle_spawns[ hash ] = [];
                    }
                    
                    if ( !isdefined( struct.script_vehiclebundle ) )
                    {
                        struct.script_vehiclebundle = hash;
                    }
                    
                    level.vehicle_spawns[ hash ][ level.vehicle_spawns[ hash ].size ] = struct;
                }
                
                continue;
            }
            
            if ( !isdefined( var_9dc8537849d839c2[ key ] ) )
            {
                var_9dc8537849d839c2[ key ] = vehicle::function_451bd53633bae879( key ) ?? 0;
            }
            
            hash = var_9dc8537849d839c2[ key ];
            
            if ( !hash )
            {
                /#
                    if ( level.debugvehiclespawns )
                    {
                        println( "<dev string:x39a>" + key );
                    }
                #/
                
                continue;
            }
            
            if ( !isdefined( level.vehicle_spawns[ hash ] ) )
            {
                level.vehicle_spawns[ hash ] = [];
            }
            
            struct.script_vehiclebundle = hash;
            level.vehicle_spawns[ hash ][ level.vehicle_spawns[ hash ].size ] = struct;
        }
    }
    
    foreach ( key, array in level.struct_class_names[ "script_vehiclebundle" ] )
    {
        hash = hashcat( %"vehiclebundle:", key );
        
        if ( !isdefined( level.vehicle_spawns[ hash ] ) )
        {
            level.vehicle_spawns[ hash ] = [];
        }
        
        foreach ( struct in array )
        {
            struct.script_vehiclebundle = hash;
            level.vehicle_spawns[ hash ][ level.vehicle_spawns[ hash ].size ] = struct;
        }
    }
}

// Namespace vehicle_spawn
// Params 0, eflags: 0x4
// Checksum 0x27351143, Offset: 0x1e49
// Size: 0x310
function private find_vehicle_spawns()
{
    level.vehicle_spawns = level.struct_class_names[ "vehicletype" ];
    
    foreach ( key, array in level.vehicle_spawns )
    {
        foreach ( struct in array )
        {
            if ( !isstring( struct.script_vehiclerefs ) )
            {
                continue;
            }
            
            foreach ( vehicleref in strtok( struct.script_vehiclerefs, "," ) )
            {
                if ( !vehicle::has_data( vehicleref ) )
                {
                    /#
                        if ( level.debugvehiclespawns )
                        {
                            println( "<dev string:x39a>" + vehicleref );
                        }
                    #/
                    
                    continue;
                }
                
                hash = get_vehicle_asset( vehicleref );
                
                if ( !isdefined( level.vehicle_spawns[ hash ] ) )
                {
                    level.vehicle_spawns[ hash ] = [];
                }
                
                level.vehicle_spawns[ hash ] = arraycombineunique( level.vehicle_spawns[ hash ], [ struct ] );
            }
        }
    }
    
    foreach ( key, array in level.struct_class_names[ "script_vehiclebundle" ] )
    {
        hash = getxhashasset( key );
        
        if ( !isdefined( level.vehicle_spawns[ hash ] ) )
        {
            level.vehicle_spawns[ hash ] = [];
        }
        
        foreach ( struct in array )
        {
            struct.vehicletype = hash;
            level.vehicle_spawns[ hash ][ level.vehicle_spawns[ hash ].size ] = struct;
        }
    }
}

// Namespace vehicle_spawn
// Params 2
// Checksum 0xaf949cf4, Offset: 0x2161
// Size: 0x2c, Type: bool
function function_a7d53b59eb27fac6( vehicledataa, vehicledatab )
{
    return vehicledataa.priority >= vehicledatab.priority;
}

// Namespace vehicle_spawn
// Params 0
// Checksum 0x6e8cb71f, Offset: 0x2196
// Size: 0x4d
function get_level_data()
{
    assert( isdefined( level.vehicle ), "<dev string:x3e9>" );
    assert( isdefined( level.vehicle.spawn ), "<dev string:x433>" );
    return level.vehicle.spawn;
}

// Namespace vehicle_spawn
// Params 0
// Checksum 0xe958e5fe, Offset: 0x21ec
// Size: 0x18, Type: bool
function is_vehicle_spawn_struct()
{
    return self.vehicletype || self.script_vehiclebundle;
}

// Namespace vehicle_spawn
// Params 0
// Checksum 0xa68fdeeb, Offset: 0x220d
// Size: 0x21
function init_spawn_clearance()
{
    leveldata = get_level_data();
    leveldata.clearancecheckminradii = [];
}

// Namespace vehicle_spawn
// Params 5
// Checksum 0x1dbe5175, Offset: 0x2236
// Size: 0x2f7, Type: bool
function function_c49e68f891a06e6f( position, vehicleref, contentsoverride, ignorelistoverride, positionoffsetz )
{
    leveldata = get_level_data();
    checkradius = 200;
    checkheight = 200;
    leveldataforvehicle = get_data( vehicleref );
    assert( isdefined( leveldataforvehicle ), "<dev string:x483>" );
    minradius = leveldataforvehicle.clearancecheckradius;
    
    if ( !isdefined( minradius ) )
    {
        minradius = leveldata.clearancecheckminradii[ vehicleref ];
    }
    
    assert( isdefined( minradius ), "<dev string:x4c9>" + getxhashsourcename( vehicleref ) + "<dev string:x4f7>" );
    
    if ( isdefined( leveldataforvehicle.clearancecheckradius ) )
    {
        checkradius = leveldataforvehicle.clearancecheckradius;
    }
    
    if ( isdefined( leveldataforvehicle.clearancecheckheight ) )
    {
        checkheight = leveldataforvehicle.clearancecheckheight;
    }
    
    if ( isdefined( positionoffsetz ) )
    {
        position += ( 0, 0, positionoffsetz );
    }
    
    radiusvector = ( checkradius, checkradius, checkheight );
    aabbmin = position - radiusvector;
    aabbmax = position + radiusvector;
    contents = contentsoverride;
    
    if ( !isdefined( contents ) )
    {
        contents = physics_createcontents( [ "physicscontents_vehicle", "physicscontents_characterproxy" ] );
    }
    
    ignorelist = ignorelistoverride;
    
    if ( !isdefined( ignorelist ) )
    {
        ignorelist = [];
        ignorelist[ ignorelist.size ] = vehicle_tracking::get_game_instances( "emp_drone" );
        ignorelist[ ignorelist.size ] = vehicle_tracking::get_game_instances( "cruise_predator" );
        
        if ( isdefined( level.supportdrones ) )
        {
            ignorelist[ ignorelist.size ] = level.supportdrones;
        }
        
        ignorelist = utility::array_combine_multiple( ignorelist );
    }
    
    ents = physics_aabbbroadphasequery( aabbmin, aabbmax, contents, ignorelist );
    
    if ( ents.size > 0 )
    {
        foreach ( ent in ents )
        {
            if ( isdefined( ent vehicle::get_ref() ) )
            {
                var_2e8bb41846790a42 = get_data( ent vehicle::get_ref() );
                _minradius = var_2e8bb41846790a42.clearancecheckradius;
                
                if ( !isdefined( _minradius ) )
                {
                    _minradius = leveldata.clearancecheckminradii[ ent vehicle::get_ref() ];
                }
                
                if ( !isdefined( _minradius ) )
                {
                    continue;
                }
                
                mindist2dsqr = pow( minradius + _minradius, 2 );
                
                if ( mindist2dsqr < distance2dsquared( ent.origin, position ) )
                {
                    continue;
                }
                
                return false;
            }
            
            if ( isplayer( ent ) )
            {
                if ( distance2dsquared( ent.origin, position ) < minradius * minradius )
                {
                    return false;
                }
            }
        }
    }
    
    return true;
}

// Namespace vehicle_spawn
// Params 2
// Checksum 0x65d70782, Offset: 0x2536
// Size: 0x5e
function function_3a15dcf060e81fe( ref, minradius )
{
    leveldata = get_level_data();
    leveldataforvehicle = get_data( ref );
    
    if ( isdefined( leveldataforvehicle ) )
    {
        leveldataforvehicle.clearancecheckradius = minradius;
        return;
    }
    
    leveldata.clearancecheckminradii[ ref ] = minradius;
}

// Namespace vehicle_spawn
// Params 0
// Checksum 0xcf8451ae, Offset: 0x259c
// Size: 0x9
function function_79bec4a35ef5586d()
{
    thread function_c3e17ab979acc6e4();
}

// Namespace vehicle_spawn
// Params 0
// Checksum 0x5f02afc0, Offset: 0x25ad
// Size: 0x4d
function function_c3e17ab979acc6e4()
{
    spawndata = spawnstruct();
    vehicle_tracking::function_2b6c8c165ab5f521( vehicle_tracking::get_base_spawn_data(), spawndata );
    faildata = spawnstruct();
    vehicle = function_d9bf163821eb62c6( spawndata.script_vehicleref, spawndata, faildata );
}

// Namespace vehicle_spawn
// Params 0
// Checksum 0x1174f498, Offset: 0x2602
// Size: 0x9
function function_fd587db0cd7ec2d()
{
    thread function_db0e1e30b11b3197();
}

// Namespace vehicle_spawn
// Params 0
// Checksum 0xffa7e434, Offset: 0x2613
// Size: 0x53
function function_db0e1e30b11b3197()
{
    oldspawndata = vehicle_tracking::get_base_spawn_data();
    spawndata = spawnstruct();
    vehicle_tracking::function_2b6c8c165ab5f521( oldspawndata, spawndata );
    faildata = spawnstruct();
    vehicle = function_d9bf163821eb62c6( vehicle::get_ref(), spawndata, faildata );
}

// Namespace vehicle_spawn
// Params 3
// Checksum 0x3b4c873, Offset: 0x266e
// Size: 0x16d
function function_d9bf163821eb62c6( ref, spawndata, faildata )
{
    level endon( #"game_ended" );
    level endon( #"cancel_pending_vehicle_respawns" );
    leveldataforvehicle = get_data( ref );
    
    if ( !isdefined( leveldataforvehicle ) )
    {
        return;
    }
    
    leveldata = get_level_data();
    delay = undefined;
    
    if ( leveldataforvehicle.respawndelay )
    {
        delay = leveldataforvehicle.respawndelay;
    }
    else if ( leveldata.respawndelayoverride != 0 )
    {
        delay = leveldata.respawndelayoverride;
    }
    else if ( leveldata.respawndelaymatchrules != 0 )
    {
        delay = leveldata.respawndelaymatchrules;
    }
    else
    {
        delay = leveldata.respawndelay;
    }
    
    if ( delay >= 1 )
    {
        if ( delay >= 9999 )
        {
            return;
        }
    }
    else
    {
    }
    
    for ( delay = 1; true ; delay = 5 )
    {
        wait delay;
        
        if ( can_spawn_vehicle( ref ) )
        {
            if ( utility::issharedfuncdefined( ref, #"alterRespawnData" ) )
            {
                spawndata = [[ utility::getsharedfunc( ref, #"alterRespawnData" ) ]]( spawndata );
            }
            
            if ( function_c49e68f891a06e6f( spawndata.origin, ref ) )
            {
                vehicle = vehicle::spawn( ref, spawndata, faildata );
                
                if ( !isdefined( vehicle ) )
                {
                    continue;
                }
                
                return vehicle;
            }
        }
    }
}

// Namespace vehicle_spawn
// Params 0
// Checksum 0xbc62a13b, Offset: 0x27e3
// Size: 0x26
function prevent_respawn()
{
    if ( vehicle::is_vehicle() )
    {
        vehicle_tracking::get_base_spawn_data() set_flag( 8 );
        return;
    }
    
    set_flag( 8 );
}

// Namespace vehicle_spawn
// Params 0
// Checksum 0xc6be17c1, Offset: 0x2811
// Size: 0xe
function function_78ba3de276c30bc4()
{
    level notify( #"cancel_pending_vehicle_respawns" );
}

// Namespace vehicle_spawn
// Params 0
// Checksum 0xa83ea936, Offset: 0x2827
// Size: 0x49
function function_dbc69ecc19a5dca3()
{
    self notify( #"hash_41749a329f01d2d2" );
    self endon( #"hash_41749a329f01d2d2" );
    
    if ( self.donotwatchabandoned )
    {
        return;
    }
    
    self endon( #"death" );
    self endon( #"stop_watching_abandoned" );
    wait 60;
    vehicle_occupancy::turn_engine_off();
}

// Namespace vehicle_spawn
// Params 5
// Checksum 0xc54d69a9, Offset: 0x2878
// Size: 0x163
function function_d4bf495411e41abd( vehicle, var_bd248bcd4604ffaa = 60, var_21b0248d77cf3cd1 = 10000, dontspawnhusk = 1, var_abf21b2f49cae013 = 30 )
{
    assert( vehicle vehicle::is_vehicle() && var_bd248bcd4604ffaa );
    
    if ( !vehicle || vehicle_occupancy::get_driver( vehicle ) )
    {
        return;
    }
    
    vehicle notify( #"hash_296ede18ea4b3a2f" );
    vehicle endon( #"hash_296ede18ea4b3a2f" );
    vehicle.dontspawnhusk = 1;
    timeout = var_bd248bcd4604ffaa;
    
    while ( true )
    {
        result = vehicle utility::waittill_any_ents_or_timeout_return( timeout, vehicle, "begin_burn_down", vehicle, "death", vehicle, "player_enter" );
        timeout = 5;
        
        if ( !vehicle || result == "player_enter" )
        {
            return;
        }
        
        if ( getplayersinradius( vehicle.origin, var_21b0248d77cf3cd1 ).size == 0 )
        {
            break;
        }
    }
    
    vehicle.dontspawnhusk = dontspawnhusk;
    vehicle stuck_timeout();
    
    if ( dontspawnhusk || var_abf21b2f49cae013 <= 0 )
    {
        return;
    }
    
    husk = vehicle vehicle::function_821726d09177a949();
    
    if ( !husk )
    {
        return;
    }
    
    wait var_abf21b2f49cae013;
    
    if ( husk )
    {
        husk stuck_timeout();
    }
}

// Namespace vehicle_spawn
// Params 2
// Checksum 0x9050dd2a, Offset: 0x29e3
// Size: 0x36
function force_abandoned_timeout( delay, callback )
{
    self.var_8d0270a62f75c886 = 1;
    self.var_ad25a103dc5bbf12 = delay;
    self.var_d8c24cb9d14bd91a = callback;
}

// Namespace vehicle_spawn
// Params 1
// Checksum 0x756fa76f, Offset: 0x2a21
// Size: 0x3c
function function_438bb45fa24276e7( ishusk )
{
    leveldata = get_level_data();
    return ishusk ? leveldata.vehicleHuskTimeoutEnabled : leveldata.vehicleAbandonedTimeoutEnabled;
}

// Namespace vehicle_spawn
// Params 0
// Checksum 0xd2cbdf57, Offset: 0x2a66
// Size: 0x1bc
function watch_abandoned()
{
    ishusk = vehicle::is_husk();
    
    if ( !function_438bb45fa24276e7( ishusk ) && !self.var_8d0270a62f75c886 )
    {
        return;
    }
    
    if ( self.watchingabandoned )
    {
        return;
    }
    
    if ( self.occupants.size > 0 )
    {
        return;
    }
    
    if ( self.turretoccupants.size > 0 )
    {
        return;
    }
    
    if ( self.ridingplayers.size > 0 )
    {
        return;
    }
    
    if ( self.isdestroyed )
    {
        return;
    }
    
    if ( self.donotwatchabandoned )
    {
        return;
    }
    
    leveldataforvehicle = get_data( vehicle::get_ref() );
    
    if ( !isdefined( leveldataforvehicle ) )
    {
        return;
    }
    
    self.watchingabandoned = 1;
    self endon( #"death" );
    self endon( #"stop_watching_abandoned" );
    leveldata = get_level_data();
    delay = undefined;
    
    if ( self.var_ad25a103dc5bbf12 )
    {
        delay = self.var_ad25a103dc5bbf12;
    }
    else if ( leveldata.abandonedtimeoutoverride != 0 && !ishusk )
    {
        delay = leveldata.abandonedtimeoutoverride;
    }
    else if ( leveldata.abandonedtimeoutmatchrules != 0 && !ishusk )
    {
        delay = leveldata.abandonedtimeoutmatchrules;
    }
    else if ( isdefined( leveldataforvehicle.abandonedtimeoutdelay ) && !ishusk )
    {
        delay = leveldataforvehicle.abandonedtimeoutdelay;
    }
    else
    {
        delay = leveldata.abandonedtimeoutdelay;
    }
    
    if ( vehicle::is_boat() && self vehicle_isonground() )
    {
        delay *= 0.3;
    }
    
    if ( delay >= 1 )
    {
        if ( delay >= 9999 )
        {
            return;
        }
    }
    else
    {
        delay = 1;
    }
    
    wait delay;
    thread abandoned_timeout();
}

// Namespace vehicle_spawn
// Params 0
// Checksum 0x4ef685e8, Offset: 0x2c2a
// Size: 0x18
function stop_watching_abandoned()
{
    self notify( #"stop_watching_abandoned" );
    self.watchingabandoned = undefined;
}

// Namespace vehicle_spawn
// Params 0
// Checksum 0x88547821, Offset: 0x2c4a
// Size: 0x4f
function abandoned_timeout()
{
    stop_watching_abandoned();
    self.donotwatchabandoned = 1;
    leveldataforvehicle = get_data( vehicle::get_ref() );
    self thread [[ self.var_d8c24cb9d14bd91a ?? leveldataforvehicle.abandonedtimeoutcallback ?? &abandoned_timeout_callback ]]();
}

// Namespace vehicle_spawn
// Params 0
// Checksum 0xceb12f62, Offset: 0x2ca1
// Size: 0x1b
function stuck_timeout()
{
    stop_watching_abandoned();
    self.donotwatchabandoned = 1;
    thread abandoned_timeout_callback();
}

// Namespace vehicle_spawn
// Params 0
// Checksum 0xa4b2bed7, Offset: 0x2cc4
// Size: 0x92
function abandoned_timeout_callback()
{
    damagestate = vehicle_damage::get_state();
    
    if ( damagestate != "heavy" )
    {
        heavystatemaxhealth = vehicle_damage::function_8c4b44320250db18( self );
        
        if ( isdefined( heavystatemaxhealth ) )
        {
            newhealth = int( min( heavystatemaxhealth, self.health ) );
            
            if ( utility::issp() )
            {
                self setnormalhealth( newhealth / self.maxhealth );
            }
            else
            {
                self.health = newhealth;
            }
            
            vehicle_omnvar::function_ca8a66bb3a611610( self );
            vehicle_damage::set_state( "heavy", damagestate );
        }
    }
}

// Namespace vehicle_spawn
// Params 1
// Checksum 0xcee5184b, Offset: 0x2d5e
// Size: 0x1e
function get_abandoned_timeout( vehicleref )
{
    return get_data( vehicleref ).timeoutonabandoneddelay;
}

// Namespace vehicle_spawn
// Params 1
// Checksum 0x704988a0, Offset: 0x2d85
// Size: 0x1e
function function_b65e41134b5a89af( vehicleref )
{
    return vehicle::get_data( vehicleref ).transitionparts;
}

