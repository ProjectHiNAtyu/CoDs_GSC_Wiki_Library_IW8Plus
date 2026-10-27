// scripts\mp\gametypes\arm_vehicles.gsc  (hash_27c2db69a21775a0.gscc) (size: 30332 Bytes / 0x767c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xea6dee05 (3933072901)
// size ...... 30332 (0x767c)
// includes .. 18  (offset: 0x724c)
// strings ... 41  (offset: 0x72dc)
// dev strs .. 8   (offset: 0x7608)
// exports ... 61  (offset: 0x54dc)
// cseg ...... 0x388 + 0x5154 (0x54dc)
// imports ... 140 (offset: 0x5e64)
// animtree1 . 0   (offset: 0x767c)
// animtree2 . 0   (offset: 0x767c)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_spawn;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_helicopters;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\parachute;
#using scripts\mp\rally_point;
#using scripts\mp\spawnselection;

#namespace arm_vehicles;

// Namespace arm_vehicles
// Params 2
// Checksum 0x8ae80e79, Offset: 0x3a6
// Size: 0x161
function registervehicletype( refname, spawnvehiclecallback )
{
    assert( isdefined( refname ) );
    vehicleinfo = spawnstruct();
    vehicleinfo.refname = refname;
    vehicleinfo.spawncallback = spawnvehiclecallback;
    var_26c79e2f91c31ef3 = vehicle_spawn::get_spawn_structs( refname );
    vehicleinfo.vehiclespawns = [];
    
    foreach ( spawn in var_26c79e2f91c31ef3 )
    {
        if ( !isdefined( spawn.script_team ) || refname == %"vehiclebundle:light_tank_mp" || refname == %"hash_406987d5bb9cf080" || refname == %"hash_7f492eb947d5169a" || refname == %"hash_4a676fd6497f5415" )
        {
            vehicleinfo.vehiclespawns[ vehicleinfo.vehiclespawns.size ] = spawn;
        }
    }
    
    if ( !isdefined( level.vehicleinfo ) )
    {
        level.vehicleinfo = [];
    }
    
    level.vehicleinfo[ refname ] = vehicleinfo;
}

// Namespace arm_vehicles
// Params 0
// Checksum 0xd79dc04e, Offset: 0x50f
// Size: 0x4ae
function function_8d849241da3b9f6e()
{
    registervehicletype( %"hash_49602cb7beee6fba", &vehiclespawn_littlebird );
    registervehicletype( %"hash_21df6558fa3c728b", &vehiclespawn_atv );
    registervehicletype( %"vehiclebundle:light_tank_mp", &vehiclespawn_tank );
    registervehicletype( %"vehiclebundle:veh9_rhib_mp", &vehiclespawn_rhib );
    registervehicletype( %"hash_425ab66196dfb969", &function_2d519f1df8de1fc4 );
    registervehicletype( %"hash_3ca3e443e3da4c5", &vehiclespawn_jltv );
    registervehicletype( %"hash_7ad965933c54dd53", &function_7188616def626a9c );
    registervehicletype( %"hash_3dff816eedc0901c", &function_c4436cd253b5c9b7 );
    registervehicletype( %"hash_4c7e54cca5ad7fd8", &vehiclespawn_patrol_boat );
    registervehicletype( %"hash_77eba5cf011bc16c", &function_2b91ae380d05d013 );
    registervehicletype( %"hash_1b1311417250f5f4", &vehiclespawn_utv );
    registervehicletype( %"hash_38f9469ea4893813", &vehiclespawn_hummer );
    registervehicletype( %"hash_38fe1c7502792874", &vehiclespawn_overland );
    registervehicletype( %"hash_2a014528468a1e2d", &function_8f6d4fe642a29275 );
    registervehicletype( %"hash_4ae6e64de5df601e", &function_41eec4b20630dc08 );
    registervehicletype( %"hash_4a676fd6497f5415", &vehiclespawn_razorback );
    level.vehiclespawnlocs = [];
    
    foreach ( vehicleinfo in level.vehicleinfo )
    {
        if ( !vehicle_spawn::can_spawn_vehicle( vehicleinfo.refname ) )
        {
            continue;
        }
        
        foreach ( spawnpoint in vehicleinfo.vehiclespawns )
        {
            if ( !isdefined( game_utility::getlocaleid() ) || !isdefined( spawnpoint.script_noteworthy ) || spawnpoint.script_noteworthy != level.localeid )
            {
                continue;
            }
            
            if ( !canspawnvehiclenear( vehicleinfo.refname, spawnpoint.origin ) )
            {
                continue;
            }
            
            spawnpoint = function_14e4fc1c8a0404ed( vehicleinfo.refname, spawnpoint );
            index = level.vehiclespawnlocs.size;
            level.vehiclespawnlocs[ index ] = spawnpoint;
            level.vehiclespawnlocs[ index ].refname = vehicleinfo.refname;
        }
    }
    
    if ( false )
    {
        foreach ( loc in level.vehiclespawnlocs )
        {
            thread debug::drawline( loc.origin, loc.origin + ( 0, 0, 1500 ), 1000, ( 1, 0, 0 ) );
        }
    }
    
    level.vehiclespawnlocs = arrayrandomize( level.vehiclespawnlocs );
    numtospawn = level.numnonrallyvehicles;
    
    if ( !isdefined( level.numnonrallyvehicles ) )
    {
        numtospawn = 25;
    }
    
    if ( false )
    {
        for ( i = 0; i < numtospawn ; i++ )
        {
            loc = level.vehiclespawnlocs[ i ];
            thread debug::drawline( loc.origin + ( 0, 0, 1500 ), loc.origin + ( 0, 0, 2500 ), 1000, ( 0, 1, 0 ) );
        }
    }
    
    for ( i = 0; i < numtospawn ; i++ )
    {
        loc = level.vehiclespawnlocs[ i ];
        
        if ( isdefined( loc ) )
        {
            vehicleinfo = level.vehicleinfo[ loc.refname ];
            [[ vehicleinfo.spawncallback ]]( loc );
        }
    }
}

// Namespace arm_vehicles
// Params 0
// Checksum 0x112d8387, Offset: 0x9c5
// Size: 0x72a
function init_groundwarvehicles()
{
    registervehicletype( %"hash_49602cb7beee6fba", &vehiclespawn_littlebird );
    registervehicletype( %"hash_21df6558fa3c728b", &vehiclespawn_atv );
    registervehicletype( %"vehiclebundle:light_tank_mp", &vehiclespawn_tank );
    registervehicletype( %"vehiclebundle:veh9_rhib_mp", &vehiclespawn_rhib );
    registervehicletype( %"hash_425ab66196dfb969", &function_2d519f1df8de1fc4 );
    registervehicletype( %"hash_3ca3e443e3da4c5", &vehiclespawn_jltv );
    registervehicletype( %"hash_406987d5bb9cf080", &vehiclespawn_jltv_mg );
    registervehicletype( %"hash_7ad965933c54dd53", &function_7188616def626a9c );
    registervehicletype( %"hash_3dff816eedc0901c", &function_c4436cd253b5c9b7 );
    registervehicletype( %"hash_4c7e54cca5ad7fd8", &vehiclespawn_patrol_boat );
    registervehicletype( %"hash_77eba5cf011bc16c", &function_2b91ae380d05d013 );
    registervehicletype( %"hash_1b1311417250f5f4", &vehiclespawn_utv );
    registervehicletype( %"hash_38f9469ea4893813", &vehiclespawn_hummer );
    registervehicletype( %"hash_38fe1c7502792874", &vehiclespawn_overland );
    registervehicletype( %"hash_13a0340a4961ca24", &vehiclespawn_acv );
    registervehicletype( %"hash_2a014528468a1e2d", &function_8f6d4fe642a29275 );
    registervehicletype( %"hash_4ae6e64de5df601e", &function_41eec4b20630dc08 );
    registervehicletype( %"hash_4a676fd6497f5415", &vehiclespawn_razorback );
    utility::registersharedfunc( %"vehiclebundle:light_tank_mp", #"create", &function_6e9ad418b3d9df4f );
    utility::registersharedfunc( %"hash_7f492eb947d5169a", #"create", &function_6e9ad418b3d9df4f );
    utility::registersharedfunc( %"hash_4a676fd6497f5415", #"create", &function_6e9ad418b3d9df4f );
    
    if ( getdvarint( @"hash_50c65a9fb4fa6fab", 1 ) )
    {
        utility::registersharedfunc( %"vehiclebundle:light_tank_mp", #"alterRespawnData", &function_f7f205ded546d555 );
        utility::registersharedfunc( %"hash_7f492eb947d5169a", #"alterRespawnData", &function_f7f205ded546d555 );
        level thread function_9f4cc34082261fc8();
    }
    
    utility::registersharedfunc( #"hash_fb347c5f16116383", #"spawnPlayerToC130", &spawnplayertoc130 );
    level.vehiclespawnlocs = [];
    level.tankspawnlocs_axis = [];
    level.tankspawnlocs_allies = [];
    
    foreach ( vehicleinfo in level.vehicleinfo )
    {
        if ( !vehicle_spawn::can_spawn_vehicle( vehicleinfo.refname ) )
        {
            continue;
        }
        
        foreach ( spawnpoint in vehicleinfo.vehiclespawns )
        {
            if ( !isdefined( game_utility::getlocaleid() ) || !isdefined( spawnpoint.script_noteworthy ) || spawnpoint.script_noteworthy != level.localeid )
            {
                continue;
            }
            
            if ( !canspawnvehiclenear( vehicleinfo.refname, spawnpoint.origin ) )
            {
                continue;
            }
            
            spawnpoint = function_14e4fc1c8a0404ed( vehicleinfo.refname, spawnpoint );
            
            if ( vehicleinfo.refname == %"vehiclebundle:light_tank_mp" || vehicleinfo.refname == %"hash_4a676fd6497f5415" )
            {
                if ( spawnpoint.script_team == "axis" )
                {
                    index = level.tankspawnlocs_axis.size;
                    level.tankspawnlocs_axis[ index ] = spawnpoint;
                    level.tankspawnlocs_axis[ index ].refname = vehicleinfo.refname;
                }
                else if ( spawnpoint.script_team == "allies" )
                {
                    index = level.tankspawnlocs_allies.size;
                    level.tankspawnlocs_allies[ index ] = spawnpoint;
                    level.tankspawnlocs_allies[ index ].refname = vehicleinfo.refname;
                }
                
                continue;
            }
            
            index = level.vehiclespawnlocs.size;
            level.vehiclespawnlocs[ index ] = spawnpoint;
            level.vehiclespawnlocs[ index ].refname = vehicleinfo.refname;
        }
    }
    
    if ( false )
    {
        foreach ( loc in level.vehiclespawnlocs )
        {
            thread debug::drawline( loc.origin, loc.origin + ( 0, 0, 1500 ), 1000, ( 1, 0, 0 ) );
            
            /#
                print3d( loc.origin, getxhashsourcename( loc.refname ) + "<dev string:x24>" + loc.origin, ( 1, 0, 0 ), 1, 1, 100000, 1 );
            #/
        }
    }
    
    level.vehiclespawnlocs = arrayrandomize( level.vehiclespawnlocs );
    numtospawn = level.numnonrallyvehicles;
    
    if ( !isdefined( level.numnonrallyvehicles ) )
    {
        numtospawn = 25;
    }
    
    if ( false )
    {
        for ( i = 0; i < numtospawn ; i++ )
        {
            loc = level.vehiclespawnlocs[ i ];
            thread debug::drawline( loc.origin + ( 0, 0, 1500 ), loc.origin + ( 0, 0, 2500 ), 1000, ( 0, 1, 0 ) );
        }
    }
    
    for ( i = 0; i < numtospawn ; i++ )
    {
        loc = level.vehiclespawnlocs[ i ];
        
        if ( isdefined( loc ) )
        {
            vehicleinfo = level.vehicleinfo[ loc.refname ];
            [[ vehicleinfo.spawncallback ]]( loc );
        }
    }
    
    level.numhqtanks_axis = 0;
    level.numhqtanks_allies = 0;
    
    if ( getdvarint( @"hash_4160846b9ed34b57", 0 ) == 1 )
    {
        wait 5;
    }
    else
    {
        flags::gameflagwait( "prematch_countdown" );
    }
    
    level thread function_f91dabf10a9baf0e();
    level thread function_78d85be268d69dfc();
}

// Namespace arm_vehicles
// Params 1
// Checksum 0xe56af476, Offset: 0x10f7
// Size: 0x17
function function_90b37dc7032bc525( points )
{
    level.tankrespawnpoints = points;
}

// Namespace arm_vehicles
// Params 0, eflags: 0x4
// Checksum 0xfbcd09df, Offset: 0x1116
// Size: 0x2b
function private function_9f4cc34082261fc8()
{
    tankrespawnpoints = vehicle_spawn::get_point_spawn_structs();
    
    if ( !isdefined( level.tankrespawnpoints ) )
    {
        level.tankrespawnpoints = tankrespawnpoints;
    }
}

// Namespace arm_vehicles
// Params 1, eflags: 0x4
// Checksum 0x86896e08, Offset: 0x1149
// Size: 0x232
function private function_f7f205ded546d555( spawndata )
{
    if ( !isdefined( level.tankrespawnpoints ) || level.tankrespawnpoints.size == 0 )
    {
        return spawndata;
    }
    
    var_9befd27b606519a0 = 0;
    
    foreach ( i in arrayrandomize( [ 0, 1, 2, 3, 4 ] ) )
    {
        if ( level.allfobs[ i ].trigger.gameobject.ownerteam == spawndata.team && isdefined( level.tankrespawnpoints[ i ] ) && ( !isdefined( level.tankrespawnpoints[ i ][ 0 ] ) || level.tankrespawnpoints[ i ][ 0 ] == spawndata.targetname ) && ( !isdefined( level.tankrespawnpoints[ i ][ 3 ] ) || level.tankrespawnpoints[ i ][ 3 ] == spawndata.team ) )
        {
            if ( !isdefined( spawndata.originalorigin ) )
            {
                spawndata.originalorigin = spawndata.origin;
                spawndata.originalangles = spawndata.angles;
            }
            
            spawndata.origin = level.tankrespawnpoints[ i ][ 1 ];
            spawndata.angles = level.tankrespawnpoints[ i ][ 2 ];
            var_9befd27b606519a0 = 1;
            break;
        }
    }
    
    if ( !var_9befd27b606519a0 && isdefined( spawndata.originalorigin ) )
    {
        spawndata.origin = spawndata.originalorigin;
        spawndata.angles = spawndata.originalangles;
    }
    
    return spawndata;
}

// Namespace arm_vehicles
// Params 5
// Checksum 0x22af52d6, Offset: 0x1384
// Size: 0xfc
function function_2b096b91f39a21c0( vehicleref, origin, newtargetname, newvehicletype, var_a9b527842a0381c6 )
{
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
    
    vehiclespawn = sortbydistance( vehicle_spawn::get_spawn_structs( vehicleref ), origin )[ 0 ];
    utility::deletestruct_ref( vehiclespawn );
    vehiclespawn.script_vehiclebundle = vehicleref;
    vehiclespawn.script_team = var_a9b527842a0381c6;
    utility::addstruct( vehiclespawn );
}

// Namespace arm_vehicles
// Params 2
// Checksum 0x536c63cb, Offset: 0x1488
// Size: 0x104
function function_86ec3c159223617e( vehicleref, origin )
{
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
    
    if ( !isdefined( level.var_4a068d52ec27c6d7 ) )
    {
        level.var_4a068d52ec27c6d7 = [];
    }
    
    if ( !isdefined( level.var_4a068d52ec27c6d7[ vehicleref ] ) )
    {
        level.var_4a068d52ec27c6d7[ vehicleref ] = [];
    }
    
    struct = spawnstruct();
    struct.origin = origin;
    level.var_4a068d52ec27c6d7[ vehicleref ][ level.var_4a068d52ec27c6d7[ vehicleref ].size ] = struct;
}

// Namespace arm_vehicles
// Params 2, eflags: 0x4
// Checksum 0xf879c483, Offset: 0x1594
// Size: 0xdf, Type: bool
function private canspawnvehiclenear( vehicleref, origin )
{
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
    
    if ( !isdefined( level.var_4a068d52ec27c6d7[ vehicleref ] ) )
    {
        return true;
    }
    
    closest = sortbydistance( level.var_4a068d52ec27c6d7[ vehicleref ], origin )[ 0 ];
    return distancesquared( origin, closest.origin ) >= 400;
}

// Namespace arm_vehicles
// Params 4
// Checksum 0x41599300, Offset: 0x167c
// Size: 0x132
function function_4125f3499d6e9ea( vehicleref, origin, neworigin, newangles )
{
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
    
    if ( !isdefined( level.var_4125f3499d6e9ea ) )
    {
        level.var_4125f3499d6e9ea = [];
    }
    
    if ( !isdefined( level.var_4125f3499d6e9ea[ vehicleref ] ) )
    {
        level.var_4125f3499d6e9ea[ vehicleref ] = [];
    }
    
    struct = spawnstruct();
    struct.origin = origin;
    struct.neworigin = neworigin;
    struct.newangles = newangles;
    level.var_4125f3499d6e9ea[ vehicleref ][ level.var_4125f3499d6e9ea[ vehicleref ].size ] = struct;
}

// Namespace arm_vehicles
// Params 2, eflags: 0x4
// Checksum 0xbb88095b, Offset: 0x17b6
// Size: 0x134
function private function_14e4fc1c8a0404ed( vehicleref, vehiclespawn )
{
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
    
    if ( !isdefined( level.var_4125f3499d6e9ea[ vehicleref ] ) )
    {
        return vehiclespawn;
    }
    
    closest = sortbydistance( level.var_4125f3499d6e9ea[ vehicleref ], vehiclespawn.origin )[ 0 ];
    
    if ( distancesquared( vehiclespawn.origin, closest.origin ) < 400 )
    {
        vehiclespawn.origin = closest.neworigin;
        
        if ( isdefined( closest.newangles ) )
        {
            vehiclespawn.angles = closest.newangles;
        }
    }
    
    return vehiclespawn;
}

// Namespace arm_vehicles
// Params 0
// Checksum 0xdea9dae4, Offset: 0x18f3
// Size: 0x31
function function_f91dabf10a9baf0e()
{
    wait getdvarfloat( @"hash_9c149e5fc7b81d01", 0 );
    thread vehiclespawn_hqtanks( level.tankspawnlocs_axis );
    thread vehiclespawn_hqtanks( level.tankspawnlocs_allies );
}

// Namespace arm_vehicles
// Params 0
// Checksum 0x2bce12e8, Offset: 0x192c
// Size: 0x1c2
function function_78d85be268d69dfc()
{
    wait getdvarfloat( @"hash_1f1cf80e06786f42", 4 );
    registervehicletype( %"hash_7f492eb947d5169a", &vehiclespawn_cougar );
    data = level.vehicleinfo[ %"hash_7f492eb947d5169a" ];
    
    foreach ( loc in data.vehiclespawns )
    {
        if ( !isdefined( game_utility::getlocaleid() ) || !isdefined( loc.script_noteworthy ) || loc.script_noteworthy != level.localeid )
        {
            continue;
        }
        
        if ( !canspawnvehiclenear( %"hash_7f492eb947d5169a", loc.origin ) )
        {
            continue;
        }
        
        loc = function_14e4fc1c8a0404ed( %"hash_7f492eb947d5169a", loc );
        level thread [[ data.spawncallback ]]( loc );
        
        if ( false )
        {
            thread debug::drawline( loc.origin, loc.origin + ( 0, 0, 1500 ), 1000, ( 1, 0, 0 ) );
            
            /#
                print3d( loc.origin, getxhashsourcename( %"hash_7f492eb947d5169a" ) + "<dev string:x24>" + loc.origin, ( 1, 0, 0 ), 1, 1, 100000, 1 );
            #/
        }
        
        wait 1;
    }
}

// Namespace arm_vehicles
// Params 1
// Checksum 0x46f0b453, Offset: 0x1af6
// Size: 0x1b2
function vehiclespawn_hqtanks( tankarray )
{
    foreach ( loc in tankarray )
    {
        if ( !isdefined( game_utility::getlocaleid() ) || !isdefined( loc.script_noteworthy ) || loc.script_noteworthy != level.localeid )
        {
            continue;
        }
        
        if ( !canspawnvehiclenear( loc.refname, loc.origin ) )
        {
            continue;
        }
        
        loc = function_14e4fc1c8a0404ed( loc.refname, loc );
        vehicleinfo = level.vehicleinfo[ loc.refname ];
        level thread [[ vehicleinfo.spawncallback ]]( loc );
        
        if ( false )
        {
            thread debug::drawline( loc.origin, loc.origin + ( 0, 0, 1500 ), 1000, ( 1, 0, 0 ) );
            
            /#
                print3d( loc.origin, getxhashsourcename( loc.refname ) + "<dev string:x24>" + loc.origin, ( 1, 0, 0 ), 1, 1, 100000, 1 );
            #/
        }
        
        wait randomfloatrange( 2, 3 );
    }
}

// Namespace arm_vehicles
// Params 2
// Checksum 0x8c9cf3d7, Offset: 0x1cb0
// Size: 0x5f
function vehiclespawn_littlebird( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    return vehicle::spawn( %"hash_49602cb7beee6fba", spawndata, faildata );
}

// Namespace arm_vehicles
// Params 2
// Checksum 0x698d93f7, Offset: 0x1d18
// Size: 0x5f
function vehiclespawn_atv( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    return vehicle::spawn( %"hash_21df6558fa3c728b", spawndata, faildata );
}

// Namespace arm_vehicles
// Params 2
// Checksum 0xe3ce2c7a, Offset: 0x1d80
// Size: 0x15e
function vehiclespawn_tank( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    spawndata.spawnmethod = "airdrop_at_position_unsafe";
    assert( isdefined( level.numhqtanks_axis ), "<dev string:x28>" );
    assert( isdefined( level.numhqtanks_allies ), "<dev string:x4e>" );
    assert( isdefined( level.maxhqtanks ), "<dev string:x76>" );
    
    if ( loc.script_team == "axis" )
    {
        if ( level.numhqtanks_axis >= level.maxhqtanks )
        {
            return;
        }
        
        spawndata.var_305ce2bb6ec0993d = "east";
        spawndata.team = "axis";
        level.numhqtanks_axis++;
    }
    else
    {
        if ( level.numhqtanks_allies >= level.maxhqtanks )
        {
            return;
        }
        
        spawndata.var_305ce2bb6ec0993d = "west";
        spawndata.team = "allies";
        level.numhqtanks_allies++;
    }
    
    iav = vehicle::spawn( %"vehiclebundle:light_tank_mp", spawndata, faildata );
    return iav;
}

// Namespace arm_vehicles
// Params 2
// Checksum 0x61725a4c, Offset: 0x1ee7
// Size: 0x5f
function vehiclespawn_rhib( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    return vehicle::spawn( %"vehiclebundle:veh9_rhib_mp", spawndata, faildata );
}

// Namespace arm_vehicles
// Params 2
// Checksum 0x5e7a267a, Offset: 0x1f4f
// Size: 0x5f
function function_2d519f1df8de1fc4( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    return vehicle::spawn( %"hash_425ab66196dfb969", spawndata, faildata );
}

// Namespace arm_vehicles
// Params 2
// Checksum 0x52a533aa, Offset: 0x1fb7
// Size: 0x5f
function vehiclespawn_jltv( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    return vehicle::spawn( %"hash_3ca3e443e3da4c5", spawndata, faildata );
}

// Namespace arm_vehicles
// Params 2
// Checksum 0xe4898797, Offset: 0x201f
// Size: 0x5f
function vehiclespawn_jltv_mg( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    return vehicle::spawn( %"hash_406987d5bb9cf080", spawndata, faildata );
}

// Namespace arm_vehicles
// Params 2
// Checksum 0xd80704ca, Offset: 0x2087
// Size: 0x5f
function function_7188616def626a9c( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    return vehicle::spawn( %"hash_7ad965933c54dd53", spawndata, faildata );
}

// Namespace arm_vehicles
// Params 2
// Checksum 0x3eb4141, Offset: 0x20ef
// Size: 0x5f
function function_c4436cd253b5c9b7( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    return vehicle::spawn( %"hash_3dff816eedc0901c", spawndata, faildata );
}

// Namespace arm_vehicles
// Params 2
// Checksum 0x46368bf1, Offset: 0x2157
// Size: 0x5f
function function_2b91ae380d05d013( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    return vehicle::spawn( %"hash_77eba5cf011bc16c", spawndata, faildata );
}

// Namespace arm_vehicles
// Params 2
// Checksum 0x54241b4e, Offset: 0x21bf
// Size: 0x5f
function vehiclespawn_utv( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    return vehicle::spawn( %"hash_1b1311417250f5f4", spawndata, faildata );
}

// Namespace arm_vehicles
// Params 2
// Checksum 0xeae6765, Offset: 0x2227
// Size: 0x5f
function vehiclespawn_hummer( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    return vehicle::spawn( %"hash_38f9469ea4893813", spawndata, faildata );
}

// Namespace arm_vehicles
// Params 2
// Checksum 0xa3833b02, Offset: 0x228f
// Size: 0x5f
function vehiclespawn_overland( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    return vehicle::spawn( %"hash_38fe1c7502792874", spawndata, faildata );
}

// Namespace arm_vehicles
// Params 2
// Checksum 0xdf53afce, Offset: 0x22f7
// Size: 0x5f
function vehiclespawn_acv( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    return vehicle::spawn( %"hash_13a0340a4961ca24", spawndata, faildata );
}

// Namespace arm_vehicles
// Params 2
// Checksum 0xa552e678, Offset: 0x235f
// Size: 0x5f
function function_8f6d4fe642a29275( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    return vehicle::spawn( %"hash_2a014528468a1e2d", spawndata, faildata );
}

// Namespace arm_vehicles
// Params 2
// Checksum 0x9f946f2d, Offset: 0x23c7
// Size: 0x5f
function function_41eec4b20630dc08( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    return vehicle::spawn( %"hash_4ae6e64de5df601e", spawndata, faildata );
}

// Namespace arm_vehicles
// Params 2
// Checksum 0x891e9950, Offset: 0x242f
// Size: 0x9d
function vehiclespawn_cougar( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    spawndata.spawnmethod = "airdrop_at_position_unsafe";
    spawndata.var_305ce2bb6ec0993d = spawndata.team == "axis" ? "east" : "west";
    return vehicle::spawn( %"hash_7f492eb947d5169a", spawndata, faildata );
}

// Namespace arm_vehicles
// Params 2
// Checksum 0x3e109db3, Offset: 0x24d5
// Size: 0x9d
function vehiclespawn_razorback( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    spawndata.spawnmethod = "airdrop_at_position_unsafe";
    spawndata.var_305ce2bb6ec0993d = spawndata.team == "axis" ? "east" : "west";
    return vehicle::spawn( %"hash_4a676fd6497f5415", spawndata, faildata );
}

// Namespace arm_vehicles
// Params 2
// Checksum 0x603fb6d7, Offset: 0x257b
// Size: 0x5f
function vehiclespawn_patrol_boat( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    return vehicle::spawn( %"hash_4c7e54cca5ad7fd8", spawndata, faildata );
}

// Namespace arm_vehicles
// Params 1
// Checksum 0xe0fc587e, Offset: 0x25e3
// Size: 0xc1
function function_fc113a9d85a3153f( params )
{
    if ( params.vehicle vehicle::is_husk() )
    {
        return;
    }
    
    ref = params.vehicle vehicle::get_ref();
    
    if ( level.updatedinit )
    {
        if ( ref == %"hash_186daea1f5e4cba0" || ref == %"hash_57d0b185054b4bd4" )
        {
            level thread rallyvehiclespawnedthread( params.vehicle );
        }
        
        return;
    }
    
    if ( ref == %"hash_79d97f9d1822b8fc" || ref == %"hash_1dd941f8f4026e3" || ref == %"hash_4c7e54cca5ad7fd8" )
    {
        level thread rallyvehiclespawnedthread( params.vehicle );
    }
}

// Namespace arm_vehicles
// Params 1, eflags: 0x4
// Checksum 0xaed2ff90, Offset: 0x26ac
// Size: 0x4a
function private rallyvehiclespawnedthread( vehicle )
{
    utility::flag_wait( "spawn_areas_ready" );
    ref = vehicle vehicle::get_ref();
    
    if ( ref == %"hash_57d0b185054b4bd4" )
    {
        wait 9;
    }
    
    rally_point::rallypointvehicle_activate( vehicle );
}

// Namespace arm_vehicles
// Params 1
// Checksum 0x2af17fe0, Offset: 0x26fe
// Size: 0x99
function function_6e9ad418b3d9df4f( vehicle )
{
    if ( !level.showteamtanks )
    {
        return;
    }
    
    switch ( vehicle vehicle::get_ref() )
    {
        case %"hash_7f492eb947d5169a":
            icon = "hud_icon_minimap_vehicle_tank_cougar";
            break;
        case %"hash_4a676fd6497f5415":
            icon = "hud_icon_minimap_vehicle_razorback";
            break;
        case %"vehiclebundle:light_tank_mp":
        default:
            icon = "hud_icon_minimap_vehicle_tank_coscar";
            break;
    }
    
    level thread vehicle_createspawnselectiontankmarker( vehicle, vehicle.team, icon );
}

// Namespace arm_vehicles
// Params 3
// Checksum 0x9615fd4a, Offset: 0x279f
// Size: 0x1db
function vehicle_createspawnselectiontankmarker( vehicle, team, icon = "hud_icon_minimap_vehicle_tank_coscar" )
{
    wait 1;
    marker = gameobjects::createobjidobject( vehicle.origin, team, ( 0, 0, 0 ), undefined, 0, 0 );
    objidpoolmanager::update_objective_ownerteam( marker.objidnum, team );
    objidpoolmanager::objective_playermask_hidefromall( marker.objidnum );
    objidpoolmanager::objective_set_play_intro( marker.objidnum, 0 );
    marker.lockupdatingicons = 0;
    objidpoolmanager::objective_pin_global( marker.objidnum, 0 );
    objidpoolmanager::update_objective_icon( marker.objidnum, icon );
    objidpoolmanager::update_objective_setbackground( marker.objidnum, 1 );
    objidpoolmanager::update_objective_onentity( marker.objidnum, vehicle );
    marker.lockupdatingicons = 1;
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) && player.team == team && player.inspawnselection )
        {
            objidpoolmanager::objective_playermask_addshowplayer( marker.objidnum, player );
        }
    }
    
    vehicle.spawnselectionmarker = marker;
    thread vehicle_watchmarkedtankdeath( vehicle );
    level.trackedtanks[ team ][ level.trackedtanks[ team ].size ] = vehicle;
}

// Namespace arm_vehicles
// Params 1
// Checksum 0x615be786, Offset: 0x2982
// Size: 0x77
function vehicle_watchmarkedtankdeath( vehicle )
{
    objidnum = vehicle.spawnselectionmarker.objidnum;
    team = vehicle.team;
    vehicle waittill( #"death" );
    objidpoolmanager::returnobjectiveid( objidnum );
    level.trackedtanks[ team ] = arrayremove( level.trackedtanks[ team ], vehicle );
}

// Namespace arm_vehicles
// Params 0
// Checksum 0x39dbf3cd, Offset: 0x2a01
// Size: 0x1d3
function vehicle_showteamtanks()
{
    self endon( #"disconnect" );
    flags::gameflagwait( "prematch_done" );
    
    foreach ( tank in level.trackedtanks[ self.team ] )
    {
        objidpoolmanager::objective_playermask_addshowplayer( tank.spawnselectionmarker.objidnum, self );
    }
    
    while ( self.inspawnselection )
    {
        waitframe();
    }
    
    foreach ( tank in level.trackedtanks[ "axis" ] )
    {
        objidpoolmanager::objective_playermask_hidefrom( tank.spawnselectionmarker.objidnum, self );
    }
    
    foreach ( tank in level.trackedtanks[ "allies" ] )
    {
        objidpoolmanager::objective_playermask_hidefrom( tank.spawnselectionmarker.objidnum, self );
    }
}

// Namespace arm_vehicles
// Params 1
// Checksum 0x764f0ab7, Offset: 0x2bdc
// Size: 0xa7
function vehiclespawn_getspawndata( loc )
{
    spawndata = spawnstruct();
    spawndata.origin = loc.origin;
    spawndata.angles = loc.angles;
    spawndata.spawntype = "GAME_MODE";
    spawndata.showheadicon = 1;
    
    if ( isdefined( loc.script_team ) )
    {
        spawndata.team = loc.script_team == "axis" ? "axis" : "allies";
    }
    
    return spawndata;
}

// Namespace arm_vehicles
// Params 1
// Checksum 0x8e0fcb03, Offset: 0x2c8c
// Size: 0xb3
function droptank_playincomingdialog( spawndata )
{
    team = spawndata.team;
    streakname = "bradley";
    
    if ( level.teambased )
    {
        if ( isdefined( level.killstreakactivatedtime[ streakname ] ) )
        {
            if ( isdefined( level.killstreakactivatedtime[ streakname ][ team ] ) )
            {
                if ( gettime() < level.killstreakactivatedtime[ streakname ][ team ] )
                {
                    return;
                }
            }
        }
        
        level.killstreakactivatedtime[ streakname ][ team ] = gettime() + killstreak_utility::getkillstreakdialogcooldown() * 1000;
    }
    
    dialog::leaderdialog( team + "_friendly_" + streakname + "_inbound", team, "killstreak_used" );
}

// Namespace arm_vehicles
// Params 0
// Checksum 0x1f366c16, Offset: 0x2d47
// Size: 0x8f2
function init_rallyvehicles()
{
    callback::add( #"vehicle_create_late", &function_fc113a9d85a3153f );
    
    while ( !isdefined( level.spawnselectionlocations ) )
    {
        waitframe();
    }
    
    waitframe();
    level.rallypointvehicles = [];
    var_7b763db93d9637d4 = "gw_vehicle_technical_";
    var_374a961eafe8a677 = "gw_vehicle_apc_";
    var_3536e8267621f591 = "gw_vehicle_armored_boat_";
    var_58d198fb8f46de65 = "gw_vehicle_littlebird_";
    var_a3ab531ae0535e2f = [];
    var_45fc9dcade232c5 = [];
    var_a03d4a79659cf3 = [];
    
    foreach ( team in level.teamnamelist )
    {
        var_a3ab531ae0535e2f[ team ] = 0;
        var_45fc9dcade232c5[ team ] = 0;
        var_a03d4a79659cf3[ team ] = 0;
    }
    
    var_5a11159d272ff69e = arraycombine( utility::getstructarray( "rallyPointAPC", "targetname" ), vehicle_spawn::get_spawn_structs( %"hash_5d0aabf994c1e2ac" ), vehicle_spawn::get_spawn_structs( %"hash_79d97f9d1822b8fc" ) );
    
    foreach ( loc in var_5a11159d272ff69e )
    {
        if ( isdefined( game_utility::getlocaleid() ) && isdefined( loc.script_noteworthy ) && loc.script_noteworthy != level.localeid )
        {
            continue;
        }
        
        if ( !isdefined( loc.script_team ) )
        {
            continue;
        }
        
        ref = loc.script_vehiclebundle ?? loc.targetname;
        
        if ( !canspawnvehiclenear( ref, loc.origin ) )
        {
            continue;
        }
        
        loc = function_14e4fc1c8a0404ed( ref, loc );
        
        if ( false )
        {
            thread debug::drawline( loc.origin, loc.origin + ( 0, 0, 1500 ), 1000, ( 1, 0, 0 ) );
            
            /#
                print3d( loc.origin, getxhashsourcename( ref ) + "<dev string:x24>" + loc.origin, ( 1, 0, 0 ), 1, 1, 100000, 1 );
            #/
        }
        
        if ( !vehicle_spawn::can_spawn_vehicle( ref ) )
        {
            continue;
        }
        
        team = loc.script_team == "axis" ? "axis" : "allies";
        rallyref = undefined;
        var_45fc9dcade232c5[ team ]++;
        
        if ( var_45fc9dcade232c5[ team ] <= 2 )
        {
            rallyref = var_374a961eafe8a677 + var_45fc9dcade232c5[ team ];
        }
        else
        {
            assert( 0, "<dev string:x97>" );
        }
        
        spawndata = getrallyvehiclespawndata( loc, team, rallyref );
        
        if ( ref == %"hash_79d97f9d1822b8fc" )
        {
            spawndata.var_305ce2bb6ec0993d = team == "axis" ? "east" : "west";
        }
        
        faildata = spawnstruct();
        vehicle = vehicle::spawn( ref, spawndata, faildata );
        
        if ( isdefined( vehicle ) )
        {
            level.rallypointvehicles[ level.rallypointvehicles.size ] = vehicle;
        }
    }
    
    var_5a11159d272ff69e = utility::getstructarray( "rallyPointArmoredBoat", "targetname" );
    var_5a11159d272ff69e = arraycombine( var_5a11159d272ff69e, vehicle_spawn::get_spawn_structs( %"hash_4c7e54cca5ad7fd8" ) );
    
    foreach ( loc in var_5a11159d272ff69e )
    {
        if ( isdefined( game_utility::getlocaleid() ) && isdefined( loc.script_noteworthy ) && loc.script_noteworthy != level.localeid )
        {
            continue;
        }
        
        if ( !isdefined( loc.script_team ) )
        {
            continue;
        }
        
        if ( !vehicle_spawn::can_spawn_vehicle( %"hash_4c7e54cca5ad7fd8" ) )
        {
            continue;
        }
        
        if ( !canspawnvehiclenear( %"hash_4c7e54cca5ad7fd8", loc.origin ) )
        {
            continue;
        }
        
        loc = function_14e4fc1c8a0404ed( %"hash_4c7e54cca5ad7fd8", loc );
        
        if ( false )
        {
            thread debug::drawline( loc.origin, loc.origin + ( 0, 0, 1500 ), 1000, ( 1, 0, 0 ) );
            
            /#
                print3d( loc.origin, getxhashsourcename( %"hash_4c7e54cca5ad7fd8" ) + "<dev string:x24>" + loc.origin, ( 1, 0, 0 ), 1, 1, 100000, 1 );
            #/
        }
        
        team = loc.script_team == "axis" ? "axis" : "allies";
        rallyref = undefined;
        var_a03d4a79659cf3[ team ]++;
        
        if ( var_a03d4a79659cf3[ team ] <= 2 )
        {
            rallyref = var_3536e8267621f591 + var_a03d4a79659cf3[ team ];
        }
        else
        {
            assert( 0, "<dev string:xf5>" );
        }
        
        spawndata = getrallyvehiclespawndata( loc, team, rallyref );
        spawndata.var_305ce2bb6ec0993d = team == "axis" ? "east" : "west";
        faildata = spawnstruct();
        vehicle = vehicle::spawn( %"hash_4c7e54cca5ad7fd8", spawndata, faildata );
        
        if ( isdefined( vehicle ) )
        {
            level.rallypointvehicles[ level.rallypointvehicles.size ] = vehicle;
        }
    }
    
    if ( level.updatedinit )
    {
        palfaref = %"hash_186daea1f5e4cba0";
    }
    else
    {
        palfaref = %"hash_1dd941f8f4026e3";
    }
    
    foreach ( loc in vehicle_spawn::get_spawn_structs( palfaref ) )
    {
        if ( isdefined( game_utility::getlocaleid() ) && isdefined( loc.script_noteworthy ) && loc.script_noteworthy != level.localeid )
        {
            continue;
        }
        
        if ( !isdefined( loc.script_team ) )
        {
            continue;
        }
        
        if ( !vehicle_spawn::can_spawn_vehicle( palfaref ) )
        {
            continue;
        }
        
        if ( !canspawnvehiclenear( palfaref, loc.origin ) )
        {
            continue;
        }
        
        loc = function_14e4fc1c8a0404ed( palfaref, loc );
        
        if ( false )
        {
            thread debug::drawline( loc.origin, loc.origin + ( 0, 0, 1500 ), 1000, ( 1, 0, 0 ) );
            
            /#
                print3d( loc.origin, getxhashsourcename( palfaref ) + "<dev string:x24>" + loc.origin, ( 1, 0, 0 ), 1, 1, 100000, 1 );
            #/
        }
        
        team = loc.script_team == "axis" ? "axis" : "allies";
        rallyref = undefined;
        var_a3ab531ae0535e2f[ team ]++;
        
        if ( var_a3ab531ae0535e2f[ team ] <= 2 )
        {
            rallyref = var_58d198fb8f46de65 + var_a3ab531ae0535e2f[ team ];
        }
        else
        {
            assert( 0, "<dev string:x163>" );
        }
        
        spawndata = getrallyvehiclespawndata( loc, team, rallyref );
        
        if ( !level.updatedinit )
        {
            spawndata.var_305ce2bb6ec0993d = team == "axis" ? "east" : "west";
        }
        
        faildata = spawnstruct();
        vehicle = vehicle::spawn( palfaref, spawndata, faildata );
        
        if ( isdefined( vehicle ) )
        {
            level.rallypointvehicles[ level.rallypointvehicles.size ] = vehicle;
        }
    }
    
    foreach ( entry in level.teamnamelist )
    {
        while ( !isdefined( level.availablespawnlocations[ entry ][ 0 ] ) )
        {
            waitframe();
        }
    }
    
    utility::flag_set( "spawn_areas_ready" );
}

// Namespace arm_vehicles
// Params 3
// Checksum 0xef709a99, Offset: 0x3641
// Size: 0x8b
function getrallyvehiclespawndata( loc, team, rallyref )
{
    spawndata = spawnstruct();
    spawndata.origin = loc.origin;
    spawndata.angles = loc.angles;
    spawndata.spawntype = "GAME_MODE";
    spawndata.ref = rallyref;
    spawndata.team = team;
    return spawndata;
}

// Namespace arm_vehicles
// Params 0
// Checksum 0x3a89b4bc, Offset: 0x36d5
// Size: 0x543
function managec130spawns()
{
    level endon( #"game_ended" );
    var_c1473f267e41928a = 6000;
    c130height = 12000;
    var_a213c836257bb696 = 20000;
    var_9c8a1466fa1f1b3e = 1;
    var_75b19a103f13b39a = ( 0, 0, 6000 );
    level.timebetweenc130passes = 0;
    level.flighttime = 20;
    level.spawnc130 = [];
    
    foreach ( entry in level.teamnamelist )
    {
        level.spawnc130[ entry ] = undefined;
    }
    
    c130_pickrandomflightpath();
    level.spawnc130[ "axis" ] = createc130( "axis", level.c130pathstruct_a.startpt + var_75b19a103f13b39a );
    level.spawnc130[ "allies" ] = createc130( "allies", level.c130pathstruct_b.startpt + var_75b19a103f13b39a );
    
    while ( !isdefined( level.spawnselectionlocations ) )
    {
        waitframe();
    }
    
    flags::gameflagwait( "prematch_done" );
    
    while ( true )
    {
        if ( !isdefined( level.timeuntilnextc130 ) )
        {
            level.timeuntilnextc130 = [];
        }
        
        if ( !isdefined( level.timeuntilnextc130[ "axis" ] ) )
        {
            level.timeuntilnextc130[ "axis" ] = 0;
        }
        
        if ( !isdefined( level.timeuntilnextc130[ "allies" ] ) )
        {
            level.timeuntilnextc130[ "allies" ] = 0;
        }
        
        timeuntilnextc130 = gettime() + ( level.flighttime + level.timebetweenc130passes ) * 1000;
        level.timeuntilnextc130[ "axis" ] = timeuntilnextc130;
        level.timeuntilnextc130[ "allies" ] = timeuntilnextc130;
        
        if ( false )
        {
            thread debug::drawline( level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 1000, ( 1, 0, 0 ) );
            thread debug::drawline( level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 1000, ( 0, 0, 1 ) );
        }
        
        if ( var_9c8a1466fa1f1b3e )
        {
            level.spawnc130[ "axis" ] thread handlec130motion( level.c130pathstruct_a.startpt + var_75b19a103f13b39a, level.c130pathstruct_a.endpt + var_75b19a103f13b39a, level.flighttime, "axis" );
            level.spawnc130[ "allies" ] thread handlec130motion( level.c130pathstruct_b.startpt + var_75b19a103f13b39a, level.c130pathstruct_b.endpt + var_75b19a103f13b39a, level.flighttime, "allies" );
        }
        else
        {
            level.spawnc130[ "axis" ] thread handlec130motion( level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, level.flighttime, "axis" );
            level.spawnc130[ "allies" ] thread handlec130motion( level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, level.flighttime, "allies" );
        }
        
        level.c130firstpassstarted = 1;
        level utility::waittill_all_in_array( [ "C130_path_complete_axis", "C130_path_complete_allies" ] );
        c130_fightpathmove();
        temppt = level.c130pathstruct_a.startpt;
        level.c130pathstruct_a.startpt = level.c130pathstruct_a.endpt;
        level.c130pathstruct_a.endpt = temppt;
        temppt = level.c130pathstruct_b.startpt;
        level.c130pathstruct_b.startpt = level.c130pathstruct_b.endpt;
        level.c130pathstruct_b.endpt = temppt;
        var_9c8a1466fa1f1b3e = 0;
        
        if ( level.usec130spawnfirstonly )
        {
            level.usec130spawn = 0;
            break;
        }
    }
    
    spawnselection::removedynamicspawnarea( "axis", "dynamic_c130" );
    spawnselection::removedynamicspawnarea( "allies", "dynamic_c130" );
    spawnselection::removespawnlocation( "dynamic_c130", "axis" );
    spawnselection::removespawnlocation( "dynamic_c130", "allies" );
    level.spawnc130[ "axis" ] delete();
    level.spawnc130[ "allies" ] delete();
}

// Namespace arm_vehicles
// Params 2
// Checksum 0x2caecd98, Offset: 0x3c20
// Size: 0x116
function createc130( team, startpt )
{
    gunship = spawn( "script_model", startpt );
    gunship setmodel( "veh8_mil_air_acharlie130" );
    gunship setcandamage( 0 );
    gunship.maxhealth = 100000;
    gunship.health = gunship.maxhealth;
    gunship.playeroffsets = [ ( 32, 30, 0 ), ( -32, 30, 0 ), ( 0, 30, 0 ), ( 16, 30, 0 ), ( -16, 30, 0 ) ];
    gunship.currentplayeroffset = 0;
    gunship.respawnqueue = [];
    gunship.players = [];
    gunship.team = team;
    gunship playloopsound( "iw8_ks_ac130_lp" );
    gunship thread br_c130::gunship_spawnvfx();
    return gunship;
}

// Namespace arm_vehicles
// Params 4
// Checksum 0xa06838e2, Offset: 0x3d3f
// Size: 0x22e
function handlec130motion( startpt, endpt, time, team )
{
    toend = vectornormalize( endpt - startpt );
    dist = distance( endpt, startpt );
    var_92f7507b257efb07 = startpt + toend * dist * 0.425;
    var_44be4ada2caac942 = startpt + toend * dist * 0.55;
    introtime = time * 0.3;
    dropofftime = time * 0.6;
    outrotime = time * 0.1;
    self.canjoin = 1;
    self.canparachute = 0;
    dir = vectornormalize( endpt - startpt );
    self.angles = vectortoangles( dir );
    self.origin = startpt;
    gatherc130playerstospawn();
    self moveto( endpt, introtime + dropofftime + outrotime, introtime * 0.25 );
    wait introtime;
    self.canparachute = 1;
    
    foreach ( p in self.players )
    {
        p notify( #"canParachute" );
    }
    
    wait dropofftime;
    self.canjoin = 0;
    self.canparachute = 0;
    
    foreach ( p in self.players )
    {
        p notify( #"halo_kick_c130" );
    }
    
    wait outrotime;
    level notify( "C130_path_complete_" + team );
}

// Namespace arm_vehicles
// Params 0
// Checksum 0x23f81ed4, Offset: 0x3f75
// Size: 0x132
function gatherc130playerstospawn()
{
    self.players = arraycombine( self.players, self.respawnqueue );
    self.respawnqueue = [];
    radius = 1400;
    spawnoffset = ( 30, 0, 0 );
    initialoffset = anglestoforward( spawnoffset ) * radius * -1;
    spawnpos = self gettagorigin( "tag_origin" ) + initialoffset;
    spawnang = self.angles;
    
    foreach ( p in self.players )
    {
        if ( !isdefined( p ) )
        {
            continue;
        }
        
        p.forcespawncameraorg = spawnpos;
        p.forcespawncameraang = spawnang;
        p notify( #"hash_a3d0ae213d1bbc7e" );
    }
}

// Namespace arm_vehicles
// Params 1
// Checksum 0xbd8bfaef, Offset: 0x40af
// Size: 0x16
function removefromspawnselectionaftertime( time )
{
    wait time;
    removefromspawnselection();
}

// Namespace arm_vehicles
// Params 0
// Checksum 0xa9cc58e7, Offset: 0x40cd
// Size: 0x2c
function removefromspawnselection()
{
    spawnselection::removedynamicspawnarea( self.team, "dynamic_c130" );
    spawnselection::removespawnlocation( "dynamic_c130", self.team );
}

// Namespace arm_vehicles
// Params 0
// Checksum 0xd8c889ec, Offset: 0x4101
// Size: 0x111
function spawnplayertoc130()
{
    self endon( #"disconnect" );
    
    if ( !isdefined( level.spawnc130[ self.team ] ) )
    {
        return;
    }
    
    self waittill( #"hash_9700613dc001d6d9" );
    c130 = level.spawnc130[ self.team ];
    c130.respawnqueue[ c130.respawnqueue.size ] = self;
    
    if ( c130.canjoin )
    {
        c130 gatherc130playerstospawn();
    }
    
    if ( self.inspawncamera )
    {
        self waittill( #"hash_904dbefb2e7a4bc0" );
    }
    else
    {
        self waittill( #"spawned_player" );
    }
    
    val::set( "spawnPlayerToC130", "killstreaks", 0 );
    self disableusability();
    self disableoffhandweapons();
    self allowmelee( 0 );
    self allowads( 0 );
    self allowfire( 0 );
    self setcandamage( 0 );
    thread jumplistener( c130, 0 );
    self.br_infil_type = "c130";
    
    if ( !isbot( self ) )
    {
        thread br_c130::orbitcam( c130 );
    }
}

// Namespace arm_vehicles
// Params 2
// Checksum 0xf8139d2d, Offset: 0x421a
// Size: 0x7f
function jumplistener( c130, var_3a969995f41ba818 )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self notify( #"hash_69664b3e900f26e" );
    self endon( #"hash_69664b3e900f26e" );
    
    if ( isdefined( self.parachute ) )
    {
        self.parachute delete();
    }
    
    self.c130 = c130;
    thread listenjump( c130, var_3a969995f41ba818 );
    thread listenkick( c130, var_3a969995f41ba818 );
}

// Namespace arm_vehicles
// Params 2
// Checksum 0xf7cbacef, Offset: 0x42a1
// Size: 0xb9
function listenkick( c130, forcechute )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"br_jump" );
    self notify( #"hash_49743d5559cb2233" );
    self endon( #"hash_49743d5559cb2233" );
    self waittill( #"halo_kick_c130" );
    self cameradefault();
    self unlink();
    wait 0.1;
    
    if ( self.sessionstate == "spectator" )
    {
        return;
    }
    
    var_75a668e52554375 = c130 br_helicopters::calctrailpoint();
    thread parachute( c130, forcechute );
    self notify( #"br_jump" );
    self notify( #"hash_d4693469e96d92a0" );
}

// Namespace arm_vehicles
// Params 2
// Checksum 0xa85f38a7, Offset: 0x4362
// Size: 0x112
function listenjump( c130, var_3a969995f41ba818 )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"br_jump" );
    self notify( #"hash_a182723d3fcdf501" );
    self endon( #"hash_a182723d3fcdf501" );
    self notifyonplayercommand( "halo_jump_c130", "+gostand" );
    
    while ( true )
    {
        result = utility::waittill_any( "halo_jump_c130", "canParachute" );
        
        if ( result == "canParachute" )
        {
            self iprintlnbold( "Press Jump to Parachute!" );
        }
        else if ( !c130.canparachute )
        {
            self iprintlnbold( "Not over the AO" );
        }
        else
        {
            break;
        }
        
        if ( self.sessionstate == "spectator" )
        {
            return;
        }
    }
    
    println( "<dev string:x1c3>" );
    self cameradefault();
    self unlink();
    wait 0.1;
    thread parachute( c130, var_3a969995f41ba818 );
    self notify( #"br_jump" );
    self notify( #"hash_d4693469e96d92a0" );
}

// Namespace arm_vehicles
// Params 2
// Checksum 0xf6f976a4, Offset: 0x447c
// Size: 0x1c6
function parachute( c130, var_3a969995f41ba818 )
{
    self endon( #"hash_69664b3e900f26e" );
    self notify( #"parachute()" );
    self endon( #"parachute()" );
    
    if ( self.team == "axis" )
    {
        var_57a71968a58f5445 = level.c130pathstruct_b.midpt;
    }
    else
    {
        var_57a71968a58f5445 = level.c130pathstruct_a.midpt;
    }
    
    tofrontline = vectornormalize( var_57a71968a58f5445 - c130.origin );
    c130.players = arrayremove( c130.players, self );
    
    if ( isdefined( c130.playeroffsets ) && isdefined( c130.currentplayeroffset ) )
    {
        offset = c130.playeroffsets[ c130.currentplayeroffset ];
        self setorigin( c130.origin + offset, 1, 1 );
        c130.currentplayeroffset++;
        
        if ( c130.currentplayeroffset == c130.playeroffsets.size )
        {
            c130.currentplayeroffset = 0;
        }
    }
    else
    {
        worldoffset = anglestoforward( c130.angles ) * c130.br_vieworigin;
        self setorigin( c130.origin + worldoffset, 1, 1 );
    }
    
    waitframe();
    player_utility::function_b54a1e23734ef07();
    player_utility::function_4688d689820ff1ed( "arm_vehicles::parachute()" );
    self.plotarmor = 0;
    self.c130 = undefined;
    self setplayerangles( vectortoangles( tofrontline ) );
    thread parachute::startfreefall( 5, 0 );
}

// Namespace arm_vehicles
// Params 0
// Checksum 0xbf0cf313, Offset: 0x464a
// Size: 0x163
function debug_randomflightpathstest()
{
    wait 10;
    
    while ( true )
    {
        c130_pickrandomflightpath();
        level.c130pathstruct_a.startpt -= ( 0, 0, 10000 );
        level.c130pathstruct_a.endpt -= ( 0, 0, 10000 );
        level.c130pathstruct_b.startpt -= ( 0, 0, 10000 );
        level.c130pathstruct_b.endpt -= ( 0, 0, 10000 );
        thread debug::drawline( level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 1, ( 1, 0, 1 ) );
        thread debug::drawline( level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 1, ( 1, 0, 1 ) );
        wait 1;
    }
}

// Namespace arm_vehicles
// Params 0
// Checksum 0xb7103d31, Offset: 0x47b5
// Size: 0x4fc
function c130_pickrandomflightpath()
{
    if ( level.c130alignedtolocale && level.useobjectives )
    {
        mapcenter = ( level.gw_objstruct.axishqloc.trigger.origin + level.gw_objstruct.allieshqloc.trigger.origin ) * 0.5;
        var_98d67a2098c44365 = vectortoangles( level.gw_objstruct.axishqloc.trigger.origin - level.gw_objstruct.allieshqloc.trigger.origin );
        angle = var_98d67a2098c44365[ 1 ];
        
        if ( false )
        {
            thread debug::drawsphere( mapcenter, 1000, 100000, ( 0, 1, 0 ) );
        }
    }
    else
    {
        mapcenter = ( level.mapsafecorners[ 0 ] + level.mapsafecorners[ 1 ] ) * 0.5;
        angle = randomfloatrange( 0, 359 );
    }
    
    c130params = makec130pathparamsstruct( mapcenter, angle - 90 );
    level.c130pathstruct_a = br_c130::makepathstruct( c130params );
    c130params.randomangle += 180;
    level.c130pathstruct_b = br_c130::makepathstruct( c130params );
    var_73fe7e612c4b8b46 = 0.2;
    randomxoffset = 0;
    randomyoffset = 0;
    
    if ( level.c130spacing_usebigmapsettings )
    {
        var_73fe7e612c4b8b46 = 0.1;
        randomxoffset = randomfloatrange( -5000, 5000 );
        randomyoffset = randomfloatrange( -5000, 5000 );
    }
    
    right = anglestoright( level.c130pathstruct_a.angle );
    level.c130pathstruct_a.startpt = right * level.c130distapart + level.c130pathstruct_a.startpt;
    level.c130pathstruct_a.endpt = right * level.c130distapart + level.c130pathstruct_a.endpt;
    right = anglestoright( level.c130pathstruct_b.angle );
    level.c130pathstruct_b.startpt = right * level.c130distapart + level.c130pathstruct_b.startpt;
    level.c130pathstruct_b.endpt = right * level.c130distapart + level.c130pathstruct_b.endpt;
    offset = ( randomxoffset, randomyoffset, 0 );
    level.c130pathstruct_a.startpt += offset;
    level.c130pathstruct_a.endpt += offset;
    level.c130pathstruct_a.midpt = vectorlerp( level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 0.5 );
    level.c130pathstruct_b.startpt += offset;
    level.c130pathstruct_b.endpt += offset;
    level.c130pathstruct_b.midpt = vectorlerp( level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 0.5 );
    level.battlecenter = vectorlerp( level.c130pathstruct_a.midpt, level.c130pathstruct_b.midpt, 0.5 );
    level.c130minpathmovementinterval = vectorlerp( level.c130pathstruct_a.startpt, level.c130pathstruct_b.endpt, var_73fe7e612c4b8b46 );
    level.c130minpathmovementinterval -= level.c130pathstruct_a.startpt;
    level.c130minpathmovementinterval = vectornormalize( level.c130minpathmovementinterval ) * level.c130distapart / 10;
    level.c130minpathmovementinterval = ( level.c130minpathmovementinterval[ 0 ], level.c130minpathmovementinterval[ 1 ], 0 );
}

// Namespace arm_vehicles
// Params 2
// Checksum 0x2d479bbe, Offset: 0x4cb9
// Size: 0x99
function makec130pathparamsstruct( centerpt, angle )
{
    twopi = 6.28318;
    randomangle = angle;
    endangleoffset = 180;
    r = level.c130flightdist;
    paramstruct = spawnstruct();
    paramstruct.r = r;
    paramstruct.randomangle = randomangle;
    paramstruct.endangleoffset = endangleoffset;
    paramstruct.centerpt = centerpt;
    return paramstruct;
}

// Namespace arm_vehicles
// Params 0
// Checksum 0x16063163, Offset: 0x4d5b
// Size: 0x685
function c130_fightpathmove()
{
    if ( false )
    {
        level.c130movementmethod = 2;
    }
    
    if ( level.c130movementmethod == 0 )
    {
        return;
    }
    
    if ( level.c130movementmethod == 1 )
    {
        if ( false )
        {
            level.c130pathkilltracker[ "axis" ] = 1;
            level.c130pathkilltracker[ "allies" ] = 0;
        }
        
        if ( level.c130pathkilltracker[ "axis" ] > level.c130pathkilltracker[ "allies" ] )
        {
            if ( arenextpathsinsafebounds( level.c130minpathmovementinterval ) )
            {
                level.c130pathstruct_a.startpt += level.c130minpathmovementinterval;
                level.c130pathstruct_a.endpt += level.c130minpathmovementinterval;
                level.c130pathstruct_b.startpt += level.c130minpathmovementinterval;
                level.c130pathstruct_b.endpt += level.c130minpathmovementinterval;
            }
        }
        else if ( arenextpathsinsafebounds( level.c130minpathmovementinterval * -1 ) )
        {
            level.c130pathstruct_a.startpt -= level.c130minpathmovementinterval;
            level.c130pathstruct_a.endpt -= level.c130minpathmovementinterval;
            level.c130pathstruct_b.startpt -= level.c130minpathmovementinterval;
            level.c130pathstruct_b.endpt -= level.c130minpathmovementinterval;
        }
        
        level.c130pathstruct_a.midpt = vectorlerp( level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 0.5 );
        level.c130pathstruct_b.midpt = vectorlerp( level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 0.5 );
        level.c130pathkilltracker[ "axis" ] = 0;
        level.c130pathkilltracker[ "allies" ] = 0;
        return;
    }
    
    if ( level.c130movementmethod == 2 )
    {
        var_af40860c9de41b9 = ( 0, 0, 0 );
        var_fa53d9e6aa242dd8 = ( 0, 0, 0 );
        var_1a7fbf42157e3eef = 0;
        var_1e242aa1ee62add8 = 0;
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) )
            {
                if ( player.team == "axis" )
                {
                    var_af40860c9de41b9 += player.origin;
                    var_1a7fbf42157e3eef++;
                    continue;
                }
                
                if ( player.team == "allies" )
                {
                    var_fa53d9e6aa242dd8 += player.origin;
                    var_1e242aa1ee62add8++;
                }
            }
        }
        
        if ( var_1a7fbf42157e3eef == 0 || var_1e242aa1ee62add8 == 0 )
        {
            return;
        }
        
        axiscenter = var_af40860c9de41b9 / var_1a7fbf42157e3eef;
        alliescenter = var_fa53d9e6aa242dd8 / var_1e242aa1ee62add8;
        var_dee40aef531f534b = vectorlerp( axiscenter, alliescenter, 0.5 );
        level.c130minpathmovementinterval = vectorlerp( level.battlecenter, var_dee40aef531f534b, 0.5 );
        level.c130minpathmovementinterval -= level.battlecenter;
        var_8b4de0ac01fb43be = distance2d( level.battlecenter, var_dee40aef531f534b );
        level.c130minpathmovementinterval = vectornormalize( level.c130minpathmovementinterval ) * var_8b4de0ac01fb43be / 4;
        level.c130minpathmovementinterval = ( level.c130minpathmovementinterval[ 0 ], level.c130minpathmovementinterval[ 1 ], 0 );
        
        if ( arenextpathsinsafebounds( level.c130minpathmovementinterval ) )
        {
            level.c130pathstruct_a.startpt += level.c130minpathmovementinterval;
            level.c130pathstruct_a.endpt += level.c130minpathmovementinterval;
            level.c130pathstruct_a.midpt = vectorlerp( level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 0.5 );
            level.c130pathstruct_b.startpt += level.c130minpathmovementinterval;
            level.c130pathstruct_b.endpt += level.c130minpathmovementinterval;
            level.c130pathstruct_b.midpt = vectorlerp( level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 0.5 );
            
            if ( false )
            {
                thread debug::drawsphere( level.battlecenter, 1000, 700, ( 1, 0, 0 ) );
                thread debug::drawsphere( var_dee40aef531f534b, 1000, 700, ( 0, 1, 0 ) );
            }
            
            level.battlecenter += level.c130minpathmovementinterval;
        }
    }
}

// Namespace arm_vehicles
// Params 1
// Checksum 0x6636d69e, Offset: 0x53e8
// Size: 0x88, Type: bool
function arenextpathsinsafebounds( offset )
{
    return ispointinsafebounds( level.c130pathstruct_a.startpt + offset ) && ispointinsafebounds( level.c130pathstruct_a.endpt + offset ) && ispointinsafebounds( level.c130pathstruct_b.startpt + offset ) && ispointinsafebounds( level.c130pathstruct_b.endpt + offset );
}

// Namespace arm_vehicles
// Params 1
// Checksum 0xdfb6207f, Offset: 0x5479
// Size: 0x62, Type: bool
function ispointinsafebounds( pt )
{
    return pt[ 0 ] < level.mapsafecorners[ 0 ][ 0 ] && pt[ 0 ] > level.mapsafecorners[ 1 ][ 0 ] && pt[ 1 ] < level.mapsafecorners[ 0 ][ 1 ] && pt[ 1 ] > level.mapsafecorners[ 1 ][ 1 ];
}

