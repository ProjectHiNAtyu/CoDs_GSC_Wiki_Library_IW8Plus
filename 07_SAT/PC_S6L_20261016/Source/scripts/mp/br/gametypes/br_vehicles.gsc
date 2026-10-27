// scripts\mp\br\gametypes\br_vehicles.gsc  (hash_33bfee5f725b7de5.gscc) (size: 26675 Bytes / 0x6833 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcfb900af (3485008047)
// size ...... 26675 (0x6833)
// includes .. 16  (offset: 0x5fa7)
// strings ... 32  (offset: 0x6027)
// dev strs .. 119 (offset: 0x61d7)
// exports ... 42  (offset: 0x45ff)
// cseg ...... 0x439 + 0x41c6 (0x45ff)
// imports ... 141 (offset: 0x4c8f)
// animtree1 . 0   (offset: 0x6833)
// animtree2 . 0   (offset: 0x6833)
#using script_5757e9f873fc5cf3;
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_spawn;
#using scripts\common\vehicle_tracking;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\flags;
#using scripts\mp\poi;
#using scripts\mp\structspawnconfig;

#namespace br_vehicles;

// Namespace br_vehicles
// Params 0
// Checksum 0x702d501b, Offset: 0x457
// Size: 0x196
function brvehiclesinit()
{
    level.modecontrolledvehiclespawningonly = 1;
    level.br_vehiclesbuffer = clamp( getdvarint( @"scr_br_dynamic_spawn_veh_buffer", 24 ), 0, function_5426ab0abe3e55b5() );
    var_381e3dcf94cd85e9 = clamp( getdvarint( @"hash_abd2847fcb2a473b", 128 ), 0, function_5426ab0abe3e55b5() );
    level.br_totalvehiclesmax = clamp( var_381e3dcf94cd85e9 - level.br_vehiclesbuffer, 0, function_5426ab0abe3e55b5() - level.br_vehiclesbuffer );
    level.br_totalvehiclesspawned = 0;
    level.br_helosmax = getdvarint( @"hash_389f02283326428e", 3 );
    level._effect[ "vehicle_flares" ] = loadfxasset( "vfx_iw8_mp_strk_apache_angel_flares" );
    function_6a699906cd7900cb();
    br_circle::registercirclecallbacks( 1, &dangercircletick, &dangermulticircletick );
    
    if ( !isdefined( level.br_vehicles ) )
    {
        level.br_vehicles = {};
    }
    
    level.br_vehicles.var_7e060c5a0da33583 = getmatchrulesdata( "brData", "circleDamageTickAmount_Vehicles" ) ?? 100;
    level.br_vehicles.circledamagemultiplier_air = getmatchrulesdata( "brData", "circleDamageMultiplier_Vehicles_Air" ) ?? 1;
    level.br_vehicles.circledamagemultiplier_ground = getmatchrulesdata( "brData", "circleDamageMultiplier_Vehicles_Ground" ) ?? 1;
    level.br_vehicles.var_40f8ef6b6eb8a68e = getdvarfloat( @"hash_ac986f4d5c5be701", 5000 );
    level thread function_40db26a444277fd8();
    
    /#
        level thread mychangeswatcher();
    #/
}

// Namespace br_vehicles
// Params 0
// Checksum 0xcd9e0019, Offset: 0x5f5
// Size: 0x195
function function_40db26a444277fd8()
{
    level endon( #"game_ended" );
    flags::function_2f3408423ccc9b2e( "POIs_initialized" );
    utility::flag_wait( "vehicle_init_done" );
    
    if ( !level.gametypebundle.var_121f120f62dc7913 )
    {
        function_3f9adfd9ff02e718();
    }
    
    if ( level.gametypebundle.var_3a8941a244839a59 )
    {
        foreach ( vehiclealias in vehicle::function_dcc93c53cf94df59() )
        {
            structspawnconfig::function_7418a260adaec05( vehiclealias, &getvehiclespawns );
            structspawnconfig::function_8c0a09968efe9138( vehiclealias, &function_68939becd76bbeea );
            structspawnconfig::function_36050499b5f48983( vehiclealias, &function_33e48ba44ef2032c );
        }
        
        return;
    }
    
    foreach ( vehicleref in vehicle::function_75acd2d48a8f3605( 0 ) )
    {
        if ( vehicle_spawn::can_spawn_vehicle( vehicleref ) )
        {
            structspawnconfig::function_7418a260adaec05( vehicleref, &getvehiclespawns );
            structspawnconfig::function_8c0a09968efe9138( vehicleref, &function_68939becd76bbeea );
            structspawnconfig::function_36050499b5f48983( vehicleref, &function_33e48ba44ef2032c );
        }
    }
}

// Namespace br_vehicles
// Params 1, eflags: 0x4
// Checksum 0x2b95a3ba, Offset: 0x792
// Size: 0x17
function private getvehiclespawns( vehicleref )
{
    return vehicle_spawn::get_spawn_structs( vehicleref, undefined, undefined, 0 );
}

// Namespace br_vehicles
// Params 0, eflags: 0x4
// Checksum 0xa7b2df6a, Offset: 0x7b2
// Size: 0x1a6
function private function_3f9adfd9ff02e718()
{
    foreach ( vehicleref in vehicle::function_75acd2d48a8f3605( 0 ) )
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
        
        structs = level.vehicle_spawns[ vehicleref ];
        
        if ( !isdefined( structs ) || structs.size == 0 )
        {
            continue;
        }
        
        foreach ( struct in structs )
        {
            if ( issubstr( struct.name, "wz_hp" ) )
            {
                struct vehicle_spawn::set_flag( 1, 1 );
            }
        }
    }
}

// Namespace br_vehicles
// Params 0
// Checksum 0xc64d0874, Offset: 0x960
// Size: 0x2d
function brvehiclesonstartgametype()
{
    /#
        if ( getdvarint( @"hash_6cce831ff331c183", 0 ) )
        {
            level thread function_d8bbb17e97d0ebc5();
            return;
        }
    #/
    
    setupvehiclespawnvolumes();
    brvehiclesreset();
}

// Namespace br_vehicles
// Params 0
// Checksum 0xe15b2a65, Offset: 0x995
// Size: 0x55d
function setupvehiclespawnvolumes()
{
    if ( getdvarint( @"scr_ssc_enabled", 1 ) )
    {
        return;
    }
    
    volume_sets = "vehicle_volume";
    
    if ( getdvarint( @"hash_2cbc9c033fdea714", 1 ) )
    {
        volume_sets = "vehicle_volume_simplified";
    }
    
    level.brvehspawnvols = getentarray( volume_sets, #script_noteworthy );
    
    foreach ( vol in level.brvehspawnvols )
    {
        initvehiclespawnvolume( vol );
    }
    
    level.br_vehicleallspawns = [];
    level.br_vehiclealwaysspawns = [];
    level.br_helospawns = [];
    level.var_f3887d712e48d464 = [];
    var_49a1649ad50a4305 = vehicle_spawn::get_level_data();
    
    foreach ( refname in vehicle::function_75acd2d48a8f3605( 0 ) )
    {
        if ( !vehicle_spawn::can_spawn_vehicle( refname ) )
        {
            continue;
        }
        
        vehiclespawnstructs = vehicle_spawn::get_spawn_structs( refname );
        
        if ( isdefined( level.filtervehiclespawnstructsfunc ) )
        {
            vehiclespawnstructs = [[ level.filtervehiclespawnstructsfunc ]]( vehiclespawnstructs );
        }
        
        if ( isdefined( level.var_cfdf9a77ca04a059 ) )
        {
            vehiclespawnstructs = [[ level.var_cfdf9a77ca04a059 ]]( refname, vehiclespawnstructs );
        }
        
        level.var_f3887d712e48d464[ refname ] = vehiclespawnstructs;
        level.br_vehicleallspawns = arraycombineunique( level.br_vehicleallspawns, vehiclespawnstructs );
        
        foreach ( spawnpoint in vehiclespawnstructs )
        {
            spawnpoint.script_vehicleref = refname;
            
            /#
                if ( getdvarint( @"hash_6cce831ff331c183", 0 ) > 0 )
                {
                    function_ef5d7fd65e2c0763( spawnpoint );
                }
            #/
            
            if ( spawnpoint.script_priority > 0 )
            {
                arraysize = level.br_vehiclealwaysspawns.size;
                level.br_vehiclealwaysspawns[ arraysize ] = spawnpoint;
                continue;
            }
            
            if ( vehicle::can_fly( refname ) )
            {
                level.br_helospawns[ level.br_helospawns.size ] = spawnpoint;
                continue;
            }
            
            foreach ( vol in level.brvehspawnvols )
            {
                if ( ispointinvolume( spawnpoint.origin, vol ) )
                {
                    arraysize = vol.vehiclespawns.size;
                    vol.vehiclespawns[ arraysize ] = spawnpoint;
                    break;
                }
            }
        }
    }
    
    /#
        if ( getdvarint( @"hash_be81410131fa95bf", 0 ) )
        {
            println( "<dev string:x24>" + level.br_vehicleallspawns.size );
            var_49a1649ad50a4305 = vehicle_spawn::get_level_data();
            println( "<dev string:x52>" + level.br_vehiclealwaysspawns.size + "<dev string:x6d>" );
            
            foreach ( spawnpoint in level.br_vehiclealwaysspawns )
            {
                println( "<dev string:x88>" + spawnpoint.script_vehicleref + "<dev string:x8c>" + spawnpoint.origin );
            }
            
            totalspawnpoints = 0;
            var_6e8dab5782055475 = 0;
            
            foreach ( vol in level.brvehspawnvols )
            {
                println( "<dev string:x91>" + spawnpoint.script_vehicleref );
                numspawnpoints = vol.vehiclespawns.size;
                minreq = vol.minvehicles;
                
                if ( numspawnpoints > 0 || minreq > 0 )
                {
                    println( "<dev string:xb3>" + numspawnpoints + "<dev string:xb9>" + minreq );
                }
                
                totalspawnpoints += numspawnpoints;
                var_6e8dab5782055475 += minreq;
            }
            
            println( "<dev string:xda>" + totalspawnpoints );
            println( "<dev string:xf7>" + var_6e8dab5782055475 );
        }
    #/
}

// Namespace br_vehicles
// Params 1
// Checksum 0x3b5f26f5, Offset: 0xefa
// Size: 0x2f
function initvehiclespawnvolume( vol )
{
    vol.vehiclespawns = [];
    vol.vehiclesspawned = 0;
    assignvehicleminimumsforvolume( vol );
}

// Namespace br_vehicles
// Params 1
// Checksum 0x90326b3d, Offset: 0xf31
// Size: 0x283
function assignvehicleminimumsforvolume( vol )
{
    assert( isdefined( vol.targetname ) );
    vol.minvehicles = 0;
    
    switch ( vol.targetname )
    {
        case #"hash_3c20c20dc3935d6f":
            vol.minvehicles = 2;
            break;
        case #"hash_f48a166c03bb39c1":
            vol.minvehicles = 2;
            break;
        case #"hash_2c5efc9850d0cbb5":
            vol.minvehicles = 4;
            break;
        case #"hash_6058392aebff0469":
            vol.minvehicles = 1;
            break;
        case #"hash_9c5e8152de8ef99":
            vol.minvehicles = 4;
            break;
        case #"hash_663b0900ff0e81c7":
            vol.minvehicles = 1;
            break;
        case #"hash_959ab3efc8aa213":
            vol.minvehicles = 0;
            break;
        case #"hash_2e0fe9d434d05e53":
            vol.minvehicles = 1;
            break;
        case #"hash_209449a3db12c20f":
            vol.minvehicles = 3;
            break;
        case #"hash_da04b46361bbb6a6":
            vol.minvehicles = 2;
            break;
        case #"hash_37e94b17102ea1b":
            vol.minvehicles = 3;
            break;
        case #"hash_5f22fd847b75bb06":
            vol.minvehicles = 2;
            break;
        case #"hash_b445759ac0026f01":
            vol.minvehicles = 2;
            break;
        case #"hash_a86d6bdba8e7b140":
            vol.minvehicles = 1;
            break;
        case #"hash_118da067c85a311d":
            vol.minvehicles = 1;
            break;
        case #"hash_e534fd8ec73eafb4":
            vol.minvehicles = 1;
            break;
        case #"hash_426f768afb41bbcd":
            vol.minvehicles = 1;
            break;
        case #"hash_2094a957c0515134":
            vol.minvehicles = 2;
            break;
        case #"hash_c0087eafd38b4fed":
            vol.minvehicles = 1;
            break;
        case #"hash_f18542c5ad2a1020":
            vol.minvehicles = 1;
            break;
    }
}

// Namespace br_vehicles
// Params 0
// Checksum 0x6246b19e, Offset: 0x11bc
// Size: 0x11d
function emptyallvehicles()
{
    if ( !( isdefined( level.vehicle ) && isdefined( level.vehicle.instances ) ) )
    {
        return;
    }
    
    foreach ( var_b62aa59a8dd1456a in level.vehicle.instances )
    {
        foreach ( vehicle in var_b62aa59a8dd1456a )
        {
            if ( vehicle_occupancy::instance_is_registered( vehicle ) )
            {
                vehicle_occupancy::eject_all_occupants( vehicle );
            }
        }
    }
}

// Namespace br_vehicles
// Params 0
// Checksum 0x9117d5b6, Offset: 0x12e1
// Size: 0x131
function deleteextantvehicles()
{
    if ( !( isdefined( level.vehicle ) && isdefined( level.vehicle.instances ) ) )
    {
        return;
    }
    
    vehicle_spawn::function_78ba3de276c30bc4();
    
    foreach ( var_b62aa59a8dd1456a in level.vehicle.instances )
    {
        foreach ( vehicle in var_b62aa59a8dd1456a )
        {
            vehicle vehicle_spawn::prevent_respawn();
            vehicle.dontspawnhusk = 1;
            level thread vehicle::death( vehicle );
        }
    }
}

// Namespace br_vehicles
// Params 4
// Checksum 0xe5be1bcf, Offset: 0x141a
// Size: 0xf6
function tryspawnavehicle( refname, locstruct, volname, faildata )
{
    if ( isdefined( level.brgametype ) )
    {
        if ( br_gametypes::isfeaturedisabled( #"hash_3be0ee0c8d77495b" ) )
        {
            return;
        }
        
        if ( ( refname == "little_bird" || refname == "little_bird_mg" ) && br_gametypes::isfeaturedisabled( #"littlebirdspawns" ) )
        {
            return;
        }
        
        if ( !br_gametypes::isfeatureenabled( #"hash_e7b3c195cf4ac5ea" ) )
        {
            if ( !br_circle::ispointwithininitialdangercircle( locstruct.origin ) )
            {
                return;
            }
        }
    }
    
    if ( vehicle_spawn::can_spawn_vehicle( refname ) )
    {
        newvehicle = spawnavehicle( refname, locstruct, faildata );
        
        if ( isdefined( newvehicle ) )
        {
            println( "<dev string:x117>" + refname + "<dev string:x12f>" + volname + "<dev string:x8c>" + locstruct.origin + "<dev string:x13b>" );
            return newvehicle;
        }
    }
}

// Namespace br_vehicles
// Params 3
// Checksum 0xf9fe47ed, Offset: 0x1519
// Size: 0xbc
function spawnavehicle( refname, locstruct, faildata )
{
    spawnorigin = locstruct.origin;
    spawnangles = locstruct.angles;
    
    if ( !isdefined( spawnangles ) )
    {
        spawnangles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = spawnstruct();
    spawndata.origin = spawnorigin;
    spawndata.angles = spawnangles;
    spawndata.spawntype = "GAME_MODE";
    newvehicle = vehicle::spawn( refname, spawndata, faildata );
    
    if ( isdefined( newvehicle ) )
    {
        br_analytics::branalytics_vehiclespawned( newvehicle, refname );
    }
    
    return newvehicle;
}

// Namespace br_vehicles
// Params 0
// Checksum 0x27ebb056, Offset: 0x15de
// Size: 0x1392
function spawninitialvehicles()
{
    if ( getdvarint( @"scr_ssc_enabled", 1 ) )
    {
        return;
    }
    
    var_49a1649ad50a4305 = vehicle_spawn::get_level_data();
    
    /#
        if ( getdvarint( @"hash_6cce831ff331c183", 0 ) )
        {
            return;
        }
    #/
    
    /#
        if ( getdvarint( @"hash_be81410131fa95bf", 0 ) )
        {
            println( "<dev string:x13d>" );
            println( "<dev string:x153>" );
        }
        
        var_5cd301eb4c33d3ed = 0;
    #/
    
    usedspawns = [];
    unusedspawns = level.br_vehicleallspawns;
    
    /#
        level.var_84fede5b33efabbd = [];
        level.br_vehiclesspawned = [];
    #/
    
    var_7111075305db71a6 = arrayrandomize( level.br_vehiclealwaysspawns );
    
    foreach ( spawnpoint in var_7111075305db71a6 )
    {
        newvehicle = tryspawnavehicle( spawnpoint.script_vehicleref, spawnpoint, "alwaysSpawn", undefined );
        
        if ( isdefined( newvehicle ) )
        {
            level.br_totalvehiclesspawned++;
            usedspawns[ usedspawns.size ] = spawnpoint;
            
            /#
                if ( getdvarint( @"hash_be81410131fa95bf", 0 ) )
                {
                    line( newvehicle.origin, newvehicle.origin + ( 0, 0, 4096 ), ( 0, 1, 0 ), 1, 1, 20000 );
                    
                    if ( isdefined( level.br_vehiclesspawned[ spawnpoint.script_vehicleref ] ) )
                    {
                        level.br_vehiclesspawned[ spawnpoint.script_vehicleref ]++;
                    }
                    else
                    {
                        level.br_vehiclesspawned[ spawnpoint.script_vehicleref ] = 1;
                    }
                    
                    println( "<dev string:x88>" + spawnpoint.script_vehicleref + "<dev string:x16f>" + newvehicle.origin );
                }
            #/
            
            var_d07686a1eb9df67e = 0;
            
            foreach ( vol in level.brvehspawnvols )
            {
                if ( ispointinvolume( spawnpoint.origin, vol ) )
                {
                    vol.vehiclesspawned++;
                    var_d07686a1eb9df67e = 1;
                    break;
                }
            }
            
            if ( !var_d07686a1eb9df67e )
            {
                /#
                    if ( isdefined( level.var_84fede5b33efabbd[ spawnpoint.script_vehicleref ] ) )
                    {
                        level.var_84fede5b33efabbd[ spawnpoint.script_vehicleref ]++;
                    }
                    else
                    {
                        level.var_84fede5b33efabbd[ spawnpoint.script_vehicleref ] = 1;
                    }
                #/
            }
            
            if ( level.br_totalvehiclesspawned >= level.br_totalvehiclesmax )
            {
                break;
            }
            
            waitframe();
            continue;
        }
        
        var_5cd301eb4c33d3ed++;
    }
    
    /#
        if ( getdvarint( @"hash_be81410131fa95bf", 0 ) )
        {
            foreach ( vol in level.brvehspawnvols )
            {
                println( "<dev string:x17d>" + vol.targetname );
            }
            
            println( "<dev string:x1a6>" );
            
            foreach ( refname, data in var_49a1649ad50a4305.databyref )
            {
                if ( level.var_84fede5b33efabbd[ refname ] > 0 )
                {
                    println( "<dev string:x88>" + refname + "<dev string:x1d2>" + level.var_84fede5b33efabbd[ refname ] + "<dev string:x1d5>" );
                }
            }
            
            println( "<dev string:x1f2>" + var_5cd301eb4c33d3ed );
        }
    #/
    
    /#
        if ( getdvarint( @"hash_be81410131fa95bf", 0 ) )
        {
            println( "<dev string:x21b>" );
        }
        
        var_b1e6eec0b6a93321 = 0;
    #/
    
    if ( level.br_totalvehiclesspawned < level.br_totalvehiclesmax )
    {
        var_ad0fb88341619611 = arrayrandomize( level.brvehspawnvols );
        
        foreach ( vol in var_ad0fb88341619611 )
        {
            println( "<dev string:x234>" + vol.targetname + "<dev string:x268>" + vol.minvehicles + "<dev string:x26b>" );
            var_58077cb304397f39 = vol.minvehicles;
            
            if ( var_58077cb304397f39 > 0 )
            {
                /#
                    if ( var_58077cb304397f39 > vol.vehiclespawns.size )
                    {
                        println( "<dev string:x26d>" + vol.targetname + "<dev string:x291>" + var_58077cb304397f39 + "<dev string:x299>" + vol.vehiclespawns.size + "<dev string:x2af>" );
                    }
                #/
                
                if ( vol.vehiclesspawned < var_58077cb304397f39 && vol.vehiclespawns.size > 0 )
                {
                    randomspawns = arrayremove( arrayrandomize( vol.vehiclespawns ), usedspawns );
                    
                    for ( spawnindex = 0; vol.vehiclesspawned < var_58077cb304397f39 && spawnindex < randomspawns.size ; spawnindex++ )
                    {
                        faildata = spawnstruct();
                        spawnpoint = randomspawns[ spawnindex ];
                        newvehicle = tryspawnavehicle( spawnpoint.script_vehicleref, spawnpoint, vol.targetname, faildata );
                        
                        if ( !isdefined( newvehicle ) )
                        {
                            /#
                                var_b1e6eec0b6a93321++;
                                println( "<dev string:x2b1>" + vol.targetname + "<dev string:x2ce>" + spawnpoint.origin + "<dev string:x26b>" );
                            #/
                            
                            continue;
                        }
                        
                        level.br_totalvehiclesspawned++;
                        usedspawns[ usedspawns.size ] = spawnpoint;
                        vol.vehiclesspawned++;
                        
                        /#
                            if ( getdvarint( @"hash_be81410131fa95bf", 0 ) )
                            {
                                line( newvehicle.origin, newvehicle.origin + ( 0, 0, 4096 ), ( 0, 1, 1 ), 1, 1, 20000 );
                                
                                if ( isdefined( level.br_vehiclesspawned[ spawnpoint.script_vehicleref ] ) )
                                {
                                    level.br_vehiclesspawned[ spawnpoint.script_vehicleref ]++;
                                }
                                else
                                {
                                    level.br_vehiclesspawned[ spawnpoint.script_vehicleref ] = 1;
                                }
                                
                                println( "<dev string:x88>" + spawnpoint.script_vehicleref + "<dev string:x16f>" + newvehicle.origin );
                            }
                        #/
                        
                        if ( level.br_totalvehiclesspawned >= level.br_totalvehiclesmax )
                        {
                            break;
                        }
                        
                        waitframe();
                    }
                    
                    if ( level.br_totalvehiclesspawned >= level.br_totalvehiclesmax )
                    {
                        break;
                    }
                }
            }
        }
    }
    
    /#
        if ( getdvarint( @"hash_be81410131fa95bf", 0 ) )
        {
            println( "<dev string:x2e6>" );
        }
    #/
    
    if ( level.br_totalvehiclesspawned < level.br_totalvehiclesmax )
    {
        var_1730f525a4f9dfc1 = 0;
        helospawnsrandomized = arrayremove( arrayrandomize( level.br_helospawns ), usedspawns );
        
        foreach ( spawnpoint in helospawnsrandomized )
        {
            faildata = spawnstruct();
            newvehicle = tryspawnavehicle( spawnpoint.script_vehicleref, spawnpoint, "heloSpawn", faildata );
            
            if ( isdefined( newvehicle ) )
            {
                level.br_totalvehiclesspawned++;
                usedspawns[ usedspawns.size ] = spawnpoint;
                
                /#
                    if ( getdvarint( @"hash_be81410131fa95bf", 0 ) )
                    {
                        line( newvehicle.origin, newvehicle.origin + ( 0, 0, 4096 ), ( 1, 1, 1 ), 1, 1, 20000 );
                        
                        if ( isdefined( level.br_vehiclesspawned[ spawnpoint.script_vehicleref ] ) )
                        {
                            level.br_vehiclesspawned[ spawnpoint.script_vehicleref ]++;
                        }
                        else
                        {
                            level.br_vehiclesspawned[ spawnpoint.script_vehicleref ] = 1;
                        }
                        
                        println( "<dev string:x88>" + spawnpoint.script_vehicleref + "<dev string:x16f>" + newvehicle.origin );
                    }
                #/
                
                var_1730f525a4f9dfc1++;
                
                if ( var_1730f525a4f9dfc1 >= level.br_helosmax )
                {
                    break;
                }
                
                if ( level.br_totalvehiclesspawned >= level.br_totalvehiclesmax )
                {
                    break;
                }
                
                waitframe();
            }
        }
        
        /#
            if ( getdvarint( @"hash_be81410131fa95bf", 0 ) )
            {
                println( "<dev string:x2fc>" + var_1730f525a4f9dfc1 + "<dev string:x305>" );
            }
        #/
    }
    
    if ( level.br_totalvehiclesspawned < level.br_totalvehiclesmax && poi::poi_issystemactive() )
    {
        function_6b8c36e7fdbef4f2();
        unusedspawns = arrayremove( unusedspawns, usedspawns );
        
        foreach ( refname, spawns in level.var_f3887d712e48d464 )
        {
            if ( !( isdefined( level.var_e3ec58a58c1b3c37 ) && isdefined( level.var_e3ec58a58c1b3c37[ refname ] ) ) )
            {
                continue;
            }
            
            spawns = arrayrandomize( spawns );
            
            for ( i = 0; i < level.var_e3ec58a58c1b3c37[ refname ] ; i++ )
            {
                spawnpoint = spawns[ i ];
                
                if ( !isdefined( spawnpoint ) )
                {
                    break;
                }
                
                newvehicle = tryspawnavehicle( refname, spawnpoint, "globalMinSpawns", spawnstruct() );
                
                if ( !isdefined( newvehicle ) )
                {
                    continue;
                }
                
                level.br_totalvehiclesspawned++;
                usedspawns[ usedspawns.size ] = spawnpoint;
                
                /#
                    if ( getdvarint( @"hash_be81410131fa95bf", 0 ) )
                    {
                        line( newvehicle.origin, newvehicle.origin + ( 0, 0, 4096 ), ( 0, 1, 1 ), 1, 1, 20000 );
                        
                        if ( isdefined( level.br_vehiclesspawned[ refname ] ) )
                        {
                            level.br_vehiclesspawned[ refname ]++;
                        }
                        else
                        {
                            level.br_vehiclesspawned[ refname ] = 1;
                        }
                        
                        println( "<dev string:x88>" + refname + "<dev string:x16f>" + newvehicle.origin );
                    }
                #/
                
                if ( level.br_totalvehiclesspawned >= level.br_totalvehiclesmax )
                {
                    break;
                }
                
                waitframe();
            }
        }
        
        unusedspawns = arrayremove( unusedspawns, usedspawns );
        
        foreach ( spawn in unusedspawns )
        {
            poi = poi::poi_findpoioriginisin( spawn.origin );
            subarea = utility::callsharedfunc( #"poi", #"hash_8dbb0d45f903ae1c", spawn.origin, poi );
            
            if ( isdefined( subarea ) )
            {
                if ( !isdefined( subarea.vehiclespawnpoints ) )
                {
                    subarea.vehiclespawnpoints = [];
                }
                
                subarea.vehiclespawnpoints[ subarea.vehiclespawnpoints.size ] = spawn;
            }
        }
        
        if ( isdefined( level.areas ) )
        {
            organizationarray = level.areas;
        }
        else
        {
            organizationarray = level.poi;
        }
        
        foreach ( area in organizationarray )
        {
            foreach ( subarea in area[ "subAreas" ] )
            {
                if ( !isdefined( subarea.minvehicles ) || subarea.minvehicles <= 0 || !isdefined( subarea.vehiclespawnpoints ) || subarea.vehiclespawnpoints.size == 0 )
                {
                    subarea.vehiclespawnpoints = undefined;
                    continue;
                }
                
                spawns = arrayrandomize( subarea.vehiclespawnpoints );
                
                for ( i = 0; subarea.spawnedvehicles < subarea.minvehicles && i < spawns.size ; i++ )
                {
                    spawnpoint = spawns[ i ];
                    faildata = spawnstruct();
                    newvehicle = tryspawnavehicle( spawnpoint.script_vehicleref, spawnpoint, "subAreaSpawns", faildata );
                    
                    if ( isdefined( newvehicle ) )
                    {
                        level.br_totalvehiclesspawned++;
                        usedspawns[ usedspawns.size ] = spawnpoint;
                        subarea.spawnedvehicles++;
                        
                        /#
                            if ( getdvarint( @"hash_be81410131fa95bf", 0 ) )
                            {
                                line( newvehicle.origin, newvehicle.origin + ( 0, 0, 4096 ), ( 0, 1, 1 ), 1, 1, 20000 );
                                
                                if ( isdefined( level.br_vehiclesspawned[ spawnpoint.script_vehicleref ] ) )
                                {
                                    level.br_vehiclesspawned[ spawnpoint.script_vehicleref ]++;
                                }
                                else
                                {
                                    level.br_vehiclesspawned[ spawnpoint.script_vehicleref ] = 1;
                                }
                                
                                println( "<dev string:x88>" + spawnpoint.script_vehicleref + "<dev string:x16f>" + newvehicle.origin );
                            }
                        #/
                        
                        if ( level.br_totalvehiclesspawned >= level.br_totalvehiclesmax )
                        {
                            break;
                        }
                        
                        waitframe();
                    }
                }
                
                subarea.vehiclespawnpoints = undefined;
                
                if ( level.br_totalvehiclesspawned >= level.br_totalvehiclesmax )
                {
                    break;
                }
            }
            
            if ( level.br_totalvehiclesspawned >= level.br_totalvehiclesmax )
            {
                break;
            }
        }
    }
    
    /#
        if ( getdvarint( @"hash_be81410131fa95bf", 0 ) )
        {
            println( "<dev string:x30c>" );
        }
    #/
    
    if ( level.br_totalvehiclesspawned < level.br_totalvehiclesmax )
    {
        randomspawns = 0;
        unusedspawns = arrayremove( unusedspawns, usedspawns );
        unusedspawns = arrayrandomize( unusedspawns );
        
        foreach ( spawnpoint in unusedspawns )
        {
            if ( !isdefined( spawnpoint.script_vehicleref ) )
            {
                continue;
            }
            
            while ( !vehicle_tracking::can_spawn_vehicle() )
            {
                wait 1;
            }
            
            faildata = spawnstruct();
            newvehicle = tryspawnavehicle( spawnpoint.script_vehicleref, spawnpoint, "randomSpawns", faildata );
            level.br_totalvehiclesspawned++;
            
            /#
                if ( getdvarint( @"hash_be81410131fa95bf", 0 ) )
                {
                    line( newvehicle.origin, newvehicle.origin + ( 0, 0, 4096 ), ( 1, 0, 0 ), 1, 1, 20000 );
                    
                    if ( isdefined( level.br_vehiclesspawned[ spawnpoint.script_vehicleref ] ) )
                    {
                        level.br_vehiclesspawned[ spawnpoint.script_vehicleref ]++;
                    }
                    else
                    {
                        level.br_vehiclesspawned[ spawnpoint.script_vehicleref ] = 1;
                    }
                    
                    println( "<dev string:x88>" + spawnpoint.script_vehicleref + "<dev string:x324>" + newvehicle.origin );
                }
            #/
            
            randomspawns++;
            
            if ( level.br_totalvehiclesspawned >= level.br_totalvehiclesmax )
            {
                break;
            }
            
            waitframe();
        }
        
        /#
            if ( getdvarint( @"hash_be81410131fa95bf", 0 ) )
            {
                println( "<dev string:x2fc>" + randomspawns + "<dev string:x339>" );
            }
        #/
    }
    
    /#
        var_d496f82664a12e93 = 0;
        
        if ( getdvarint( @"hash_be81410131fa95bf", 0 ) )
        {
            foreach ( vol in level.brvehspawnvols )
            {
                println( "<dev string:x34a>" + vol.targetname );
                numspawnpoints = vol.vehiclespawns.size;
                minreq = vol.minvehicles;
                
                if ( minreq > 0 && minreq > vol.vehiclesspawned )
                {
                    unfilled = minreq - vol.vehiclesspawned;
                    println( "<dev string:x371>" + unfilled + "<dev string:x37a>" );
                    var_d496f82664a12e93 += unfilled;
                }
            }
            
            println( "<dev string:x396>" + var_b1e6eec0b6a93321 );
            println( "<dev string:x3bc>" );
            
            foreach ( refname, data in var_49a1649ad50a4305.databyref )
            {
                spawncount = 0;
                
                if ( isdefined( level.br_vehiclesspawned[ refname ] ) )
                {
                    spawncount = level.br_vehiclesspawned[ refname ];
                }
                
                println( "<dev string:x88>" + refname + "<dev string:x1d2>" + spawncount );
            }
        }
        
        var_55374f9f49c34a47 = var_5cd301eb4c33d3ed + var_b1e6eec0b6a93321;
        println( "<dev string:x3f2>" + level.br_totalvehiclesspawned );
        println( "<dev string:x421>" + var_55374f9f49c34a47 );
        
        if ( var_d496f82664a12e93 > 0 )
        {
            println( "<dev string:x455>" + var_d496f82664a12e93 );
        }
    #/
}

// Namespace br_vehicles
// Params 2
// Checksum 0xc5a1382f, Offset: 0x2978
// Size: 0x73
function function_68939becd76bbeea( vehicleref, loc )
{
    if ( !isdefined( level.br_vehiclesssc ) )
    {
        level.br_vehiclesssc = [];
    }
    
    if ( !isdefined( level.br_vehiclesssc[ vehicleref ] ) )
    {
        level.br_vehiclesssc[ vehicleref ] = [];
    }
    
    size = level.br_vehiclesssc[ vehicleref ].size;
    level.br_vehiclesssc[ vehicleref ][ size ] = loc;
    return loc;
}

// Namespace br_vehicles
// Params 1
// Checksum 0x7f426098, Offset: 0x29f4
// Size: 0x6b
function vehiclespawn_getspawndata( loc )
{
    spawndata = spawnstruct();
    spawndata.origin = loc.origin;
    spawndata.angles = loc.angles;
    spawndata.spawntype = "GAME_MODE";
    spawndata.showheadicon = 1;
    return spawndata;
}

// Namespace br_vehicles
// Params 3
// Checksum 0xab9d27d2, Offset: 0x2a68
// Size: 0x60
function function_12cb7a39adc47724( loc, vehicleref, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    return vehicle::spawn( vehicleref, spawndata, faildata );
}

// Namespace br_vehicles
// Params 3
// Checksum 0x74480286, Offset: 0x2ad1
// Size: 0xa9
function function_be148ae5b184429( loc, refname, faildata )
{
    if ( level.br_totalvehiclesspawned >= level.br_totalvehiclesmax )
    {
        err = "Error: SSC is trying to spawn a vehicle but the max limit (" + level.br_totalvehiclesmax + ") has been reached - " + refname;
        println( err );
        logprint( err );
        script::function_2e2007575f92910d( err );
        faildata.fail = "total_limit_exceeded";
        return;
    }
    
    vehicle = function_12cb7a39adc47724( loc, refname, faildata );
    
    if ( vehicle )
    {
        level.br_totalvehiclesspawned++;
    }
    
    return vehicle;
}

// Namespace br_vehicles
// Params 1
// Checksum 0xc93ee7ba, Offset: 0x2b83
// Size: 0x174
function function_33e48ba44ef2032c( refname )
{
    if ( !getdvarint( @"scr_ssc_enabled", 1 ) )
    {
        return;
    }
    
    if ( !isdefined( level.br_vehiclesssc ) )
    {
        return;
    }
    
    loclist = level.br_vehiclesssc[ refname ];
    
    if ( !isdefined( loclist ) )
    {
        logprint( "Error: SSC is trying to spawn a vehicle but no location was found - " + refname );
        return;
    }
    
    level endon( #"game_ended" );
    
    foreach ( loc in loclist )
    {
        if ( level.gametypebundle.var_3a8941a244839a59 )
        {
            refname = loc.script_vehiclebundle ?? loc.script_vehicleref;
        }
        
        if ( level.var_c4bd1afa9e7b69cd )
        {
            refname = level.vehiclespawnoverrides[ loc.name ] ?? refname;
        }
        
        if ( !vehicle_spawn::can_spawn_vehicle( refname ) )
        {
            break;
        }
        
        faildata = {};
        vehicle = function_be148ae5b184429( loc, refname, faildata );
        
        if ( !isdefined( vehicle ) && faildata.fail != "spawn_invalid_location" )
        {
            return;
        }
        
        waitframe();
    }
}

// Namespace br_vehicles
// Params 2
// Checksum 0xc055ac93, Offset: 0x2cff
// Size: 0x24
function function_45bf8556e4494584( refname, notification )
{
    function_33e48ba44ef2032c( refname );
    waitframe();
    level notify( notification );
}

// Namespace br_vehicles
// Params 0
// Checksum 0x3c661043, Offset: 0x2d2b
// Size: 0xce
function function_62b93dddf0940dc1()
{
    if ( !getdvarint( @"scr_ssc_enabled", 1 ) )
    {
        return;
    }
    
    if ( !isdefined( level.br_vehiclesssc ) )
    {
        return;
    }
    
    waitarray = [];
    
    foreach ( refname, loclist in level.br_vehiclesssc )
    {
        notificationid = refname + "_spawn_complete";
        level thread function_45bf8556e4494584( refname, notificationid );
        waitarray[ waitarray.size ] = notificationid;
    }
    
    level utility::waittill_all_in_array( waitarray );
}

// Namespace br_vehicles
// Params 0
// Checksum 0xfd5989e3, Offset: 0x2e01
// Size: 0x154
function function_6b8c36e7fdbef4f2()
{
    table = level.var_b40e8430c5d07a40;
    
    if ( !isdefined( table ) )
    {
        return;
    }
    
    numrows = tablelookupgetnumrows( table );
    
    if ( isdefined( level.areas ) )
    {
        organizationarray = level.areas;
    }
    else
    {
        organizationarray = level.poi;
    }
    
    for ( i = 0; i < numrows ; i++ )
    {
        areaname = tablelookupbyrow( table, i, 0 );
        subareaname = tolower( tablelookupbyrow( table, i, 1 ) );
        minvehicles = int( tablelookupbyrow( table, i, 6 ) );
        
        if ( isdefined( organizationarray[ areaname ][ "subAreas" ][ subareaname ] ) )
        {
            organizationarray[ areaname ][ "subAreas" ][ subareaname ].minvehicles = minvehicles;
            organizationarray[ areaname ][ "subAreas" ][ subareaname ].spawnedvehicles = 0;
            continue;
        }
        
        if ( areaname == "minVehicleSpawns" )
        {
            vehicleref = tablelookupbyrow( table, i, 1 );
            vehiclespawns = int( tablelookupbyrow( table, i, 2 ) );
            
            if ( !isdefined( level.var_e3ec58a58c1b3c37 ) )
            {
                level.var_e3ec58a58c1b3c37 = [];
            }
            
            level.var_e3ec58a58c1b3c37[ vehicleref ] = vehiclespawns;
        }
    }
}

// Namespace br_vehicles
// Params 0
// Checksum 0xb3094fd, Offset: 0x2f5d
// Size: 0xa2
function brvehiclespawnvolreset()
{
    if ( getdvarint( @"scr_ssc_enabled", 1 ) )
    {
        return;
    }
    
    var_49a1649ad50a4305 = vehicle_spawn::get_level_data();
    
    foreach ( vol in level.brvehspawnvols )
    {
        vol.vehiclesspawned = 0;
    }
}

// Namespace br_vehicles
// Params 0
// Checksum 0x54300485, Offset: 0x3007
// Size: 0x74
function waitforvehiclestodeletethenspawninitial()
{
    level endon( #"game_ended" );
    level notify( #"br_vehicleswaitfordelete" );
    level endon( #"br_vehicleswaitfordelete" );
    waitframe();
    waittillframeend();
    function_62b93dddf0940dc1();
    
    if ( utility::issharedfuncdefined( #"gametype", #"hash_c5e35bf2d833a005" ) )
    {
        utility::callsharedfunc( #"gametype", #"hash_c5e35bf2d833a005" );
    }
    else
    {
        spawninitialvehicles();
    }
    
    function_fb0954cc322893a();
}

// Namespace br_vehicles
// Params 0
// Checksum 0xf0d25ac4, Offset: 0x3083
// Size: 0x29
function brvehiclesreset()
{
    emptyallvehicles();
    deleteextantvehicles();
    brvehiclespawnvolreset();
    level.br_totalvehiclesspawned = 0;
    level thread waitforvehiclestodeletethenspawninitial();
}

// Namespace br_vehicles
// Params 0
// Checksum 0x3682bb88, Offset: 0x30b4
// Size: 0x1a9
function function_bf46516c0b7e717e()
{
    if ( !isdefined( level.br_vehiclesssc ) )
    {
        return;
    }
    
    level.br_totalvehiclesspawned = function_5ce84c263bbfe56f();
    
    foreach ( vehicleref, loclist in level.br_vehiclesssc )
    {
        var_a6ef578c0f41fc5 = level.vehicle.instances[ getxhashasset( vehicleref ) ] ?? 0;
        var_56e3361aaff2f40e = loclist.size - var_a6ef578c0f41fc5;
        
        if ( var_56e3361aaff2f40e <= 0 )
        {
            continue;
        }
        
        var_8593f1a2169a9e55 = arrayrandomize( loclist );
        
        foreach ( loc in var_8593f1a2169a9e55 )
        {
            if ( level.br_totalvehiclesspawned >= level.br_totalvehiclesmax )
            {
                return;
            }
            
            if ( !function_71013068aa32f918( loc.origin ) )
            {
                continue;
            }
            
            faildata = {};
            newvehicle = function_be148ae5b184429( loc, vehicleref, faildata );
            
            if ( newvehicle )
            {
                var_56e3361aaff2f40e--;
                
                if ( var_56e3361aaff2f40e <= 0 )
                {
                    break;
                }
            }
        }
    }
}

// Namespace br_vehicles
// Params 0
// Checksum 0x3a8aaeb7, Offset: 0x3265
// Size: 0x90
function function_5ce84c263bbfe56f()
{
    count = 0;
    
    foreach ( var_b62aa59a8dd1456a in level.vehicle.instances )
    {
        count += var_b62aa59a8dd1456a.size;
    }
    
    return count;
}

// Namespace br_vehicles
// Params 2, eflags: 0x4
// Checksum 0xde0ee458, Offset: 0x32fe
// Size: 0x39, Type: bool
function private function_71013068aa32f918( origin, saferadius = 800 )
{
    nearbyent = getentarrayinradius( undefined, undefined, origin, saferadius );
    return nearbyent.size == 0;
}

// Namespace br_vehicles
// Params 0
// Checksum 0x3f530cee, Offset: 0x3340
// Size: 0x51
function brvehicleonprematchstarted()
{
    /#
        if ( getdvarint( @"hash_6cce831ff331c183", 0 ) )
        {
            return;
        }
    #/
    
    wait 1.5;
    
    if ( !level.shouldinitvehicles )
    {
        return;
    }
    
    vehicle_interact::allow_use_global( 0 );
    brvehiclesreset();
    namespace_6fe0f1cba107e99::spawnpalfa();
    br_gametype_dmz::function_6a8ba004c43e487e();
    vehicle_interact::allow_use_global( 1 );
}

// Namespace br_vehicles
// Params 3
// Checksum 0x408bc221, Offset: 0x3399
// Size: 0x32
function dangercircletick( dangercircleorigin, dangercircleradius, thresholdradius )
{
    function_5b34ea11c274abbe( dangercircleorigin, dangercircleradius );
    function_283f783baebee970( dangercircleorigin, dangercircleradius );
}

// Namespace br_vehicles
// Params 0
// Checksum 0x3c516a07, Offset: 0x33d3
// Size: 0x10
function dangermulticircletick()
{
    function_5b34ea11c274abbe();
    function_283f783baebee970();
}

// Namespace br_vehicles
// Params 2, eflags: 0x4
// Checksum 0xd9735600, Offset: 0x33eb
// Size: 0x3c
function private function_5b34ea11c274abbe( dangercircleorigin, dangercircleradius )
{
    if ( br_gametypes::isfeaturedisabled( #"hash_a1e2467effef085c" ) )
    {
        return;
    }
    
    function_c5253ab01666a9b8( dangercircleorigin, dangercircleradius );
    function_227b19c7ad7d4dbf( dangercircleorigin, dangercircleradius );
}

// Namespace br_vehicles
// Params 2, eflags: 0x4
// Checksum 0xd2ed66d9, Offset: 0x342f
// Size: 0x21b
function private function_c5253ab01666a9b8( dangercircleorigin, dangercircleradius )
{
    damageamount = int( level.br_vehicles.var_7e060c5a0da33583 * level.br_vehicles.circledamagemultiplier_air );
    
    if ( damageamount <= 0 )
    {
        return;
    }
    
    helis = level.vehicle.aircraft;
    
    if ( !isdefined( helis ) )
    {
        return;
    }
    
    if ( br_circle_util::function_7c3401c47d505872() <= 1 && ( !level.exclusionzones || level.exclusionzones.size == 0 ) )
    {
        if ( !isdefined( dangercircleorigin ) )
        {
            dangercircleorigin = br_circle::getdangercircleorigin();
        }
        
        if ( !isdefined( dangercircleradius ) )
        {
            dangercircleradius = br_circle::getdangercircleradius();
        }
        
        helis = function_c44b31a67523b336( helis, dangercircleorigin, dangercircleradius - 392, 1 );
    }
    
    foreach ( heli in helis )
    {
        if ( heli.dangercircletickimmune )
        {
            continue;
        }
        
        if ( heli vehicle::is_husk() )
        {
            heli dodamage( damageamount, heli.origin, undefined, undefined, "MOD_TRIGGER_HURT", "danger_circle_br" );
            continue;
        }
        
        if ( br_circle_util::function_4c6afbf2b757376a( heli.origin ) )
        {
            continue;
        }
        
        dodamage = !br_circle_util::ispointindangercircle( heli.origin, 160 ) || !br_circle_util::ispointindangercircle( heli.origin, 36 );
        dodamage = dodamage || !br_gametypes::isfeaturedisabled( #"hash_5aaafc2b620d773c" ) && br_circle_util::function_4c6afbf2b757376a( heli.origin, 1 );
        
        if ( dodamage )
        {
            heli dodamage( damageamount, heli.origin, undefined, undefined, "MOD_TRIGGER_HURT", "danger_circle_br" );
        }
    }
}

// Namespace br_vehicles
// Params 2, eflags: 0x4
// Checksum 0xbdff148f, Offset: 0x3652
// Size: 0x1af
function private function_227b19c7ad7d4dbf( dangercircleorigin, dangercircleradius )
{
    damageamount = int( level.br_vehicles.var_7e060c5a0da33583 * level.br_vehicles.circledamagemultiplier_ground );
    
    if ( damageamount <= 0 )
    {
        return;
    }
    
    var_96fe3349a4c88cc8 = function_6b43c7d363c09571( level.vehicle.groundonly, dangercircleorigin, dangercircleradius, 0 );
    
    foreach ( vehicle in var_96fe3349a4c88cc8 )
    {
        if ( vehicle.dangercircletickimmune )
        {
            continue;
        }
        
        if ( vehicle vehicle::is_husk() )
        {
            vehicle dodamage( damageamount, vehicle.origin, undefined, undefined, "MOD_TRIGGER_HURT", "danger_circle_br" );
            continue;
        }
        
        if ( br_circle_util::function_4c6afbf2b757376a( vehicle.origin ) )
        {
            continue;
        }
        
        dodamage = !br_circle_util::ispointindangercircle( vehicle.origin, 0 );
        dodamage = dodamage || !br_gametypes::isfeaturedisabled( #"hash_5aaafc2b620d773c" ) && br_circle_util::function_4c6afbf2b757376a( vehicle.origin, 1 );
        
        if ( dodamage )
        {
            vehicle dodamage( damageamount, vehicle.origin, undefined, undefined, "MOD_TRIGGER_HURT", "danger_circle_br" );
        }
    }
}

// Namespace br_vehicles
// Params 4, eflags: 0x4
// Checksum 0x47f71db6, Offset: 0x3809
// Size: 0x102
function private function_6b43c7d363c09571( vehiclearray, dangercircleorigin, dangercircleradius, gracedistance = level.var_ea96217a33eb6457 )
{
    if ( br_circle_util::function_7c3401c47d505872() <= 1 )
    {
        if ( !isdefined( dangercircleorigin ) )
        {
            dangercircleorigin = br_circle::getdangercircleorigin();
        }
        
        if ( !isdefined( dangercircleradius ) )
        {
            dangercircleradius = br_circle::getdangercircleradius();
        }
        
        return function_c44b31a67523b336( vehiclearray, dangercircleorigin, dangercircleradius + gracedistance, 1 );
    }
    
    var_27f65122cf972727 = [];
    
    foreach ( vehicle in vehiclearray )
    {
        if ( br_circle_util::ispointinmulticircledanger( vehicle.origin, gracedistance ) )
        {
            var_27f65122cf972727[ var_27f65122cf972727.size ] = vehicle;
        }
    }
    
    return var_27f65122cf972727;
}

// Namespace br_vehicles
// Params 2, eflags: 0x4
// Checksum 0xcce863f0, Offset: 0x3913
// Size: 0x14a
function private function_283f783baebee970( dangercircleorigin, dangercircleradius )
{
    if ( !br_gametypes::isfeatureenabled( #"hash_5265bc3379d9cf51" ) )
    {
        return;
    }
    
    vehicles = function_6b43c7d363c09571( level.vehicle.all, dangercircleorigin, dangercircleradius );
    
    foreach ( vehicle in vehicles )
    {
        if ( vehicle.isairkillstreak )
        {
            continue;
        }
        
        if ( br_circle_util::function_4c6afbf2b757376a( vehicle.origin ) )
        {
            continue;
        }
        
        nearplayers = function_d63fe6a4c08ba6f5( vehicle.origin, level.br_vehicles.var_40f8ef6b6eb8a68e, level.br_vehicles.var_40f8ef6b6eb8a68e );
        
        if ( nearplayers.size > 0 )
        {
            continue;
        }
        
        vehicle vehicle_spawn::prevent_respawn();
        vehicle.dontspawnhusk = 1;
        vehicle::death( vehicle );
    }
}

// Namespace br_vehicles
// Params 1
// Checksum 0x5fc75345, Offset: 0x3a65
// Size: 0x3a
function function_abb251804aa770ff( vehicleref )
{
    bit = level.vehicleenum[ vehicleref ];
    
    if ( isdefined( bit ) )
    {
        function_a9a8165656e26139( "ui_br_vehicles_spawned", bit, 1, 1 );
    }
}

// Namespace br_vehicles
// Params 0
// Checksum 0x32a16907, Offset: 0x3aa7
// Size: 0xe4
function function_6a699906cd7900cb()
{
    level.vehicleenum = [];
    var_183324c6fa093522 = getscriptbundle( "vehicleenum:" + "iw9_vehicle_enum" );
    
    if ( !isdefined( var_183324c6fa093522 ) )
    {
        return [];
    }
    
    foreach ( id, var_8ff81b8113f7d7e2 in var_183324c6fa093522.vehicle_list )
    {
        if ( !isnumber( id ) )
        {
            continue;
        }
        
        if ( !isdefined( var_8ff81b8113f7d7e2 ) )
        {
            continue;
        }
        
        vehicleref = var_8ff81b8113f7d7e2.vehicle;
        
        if ( !isdefined( vehicleref ) )
        {
            continue;
        }
        
        level.vehicleenum[ vehicleref ] = id;
    }
}

// Namespace br_vehicles
// Params 0
// Checksum 0x34c6eab9, Offset: 0x3b93
// Size: 0x94
function function_fb0954cc322893a()
{
    if ( level.vehicleenum.size > 0 )
    {
        foreach ( vehicleref, var_b62aa59a8dd1456a in level.vehicle.instances )
        {
            function_abb251804aa770ff( vehicleref );
        }
    }
}

/#

    // Namespace br_vehicles
    // Params 0
    // Checksum 0xf66ccb7, Offset: 0x3c2f
    // Size: 0x790, Type: dev
    function function_d8bbb17e97d0ebc5()
    {
        level endon( #"game_ended" );
        
        while ( level.players.size < 1 )
        {
            wait 1;
        }
        
        var_2c1a264ec0289d7f = [];
        player = level.players[ 0 ];
        player notifyonplayercommand( "<dev string:x488>", "<dev string:x492>" );
        player notifyonplayercommand( "<dev string:x498>", "<dev string:x4a7>" );
        player notifyonplayercommand( "<dev string:x4ae>", "<dev string:x4b9>" );
        player notifyonplayercommand( "<dev string:x4c3>", "<dev string:x4d4>" );
        player notifyonplayercommand( "<dev string:x4dd>", "<dev string:x4ea>" );
        player notifyonplayercommand( "<dev string:x4f9>", "<dev string:x504>" );
        player utility::waittill_any_return( "<dev string:x488>", "<dev string:x498>", "<dev string:x4ae>", "<dev string:x4c3>", "<dev string:x4f9>", "<dev string:x4dd>" );
        setupvehiclespawnvolumes();
        wait 0.5;
        iprintlnbold( "<dev string:x510>" );
        
        while ( true )
        {
            note = player utility::waittill_any_return( "<dev string:x488>", "<dev string:x498>", "<dev string:x4ae>", "<dev string:x4c3>", "<dev string:x4f9>", "<dev string:x4dd>" );
            
            if ( note == "<dev string:x4dd>" )
            {
                if ( var_2c1a264ec0289d7f.size > 0 )
                {
                    start = player getvieworigin();
                    angles = player getplayerangles();
                    fwd = anglestoforward( angles );
                    end = start + fwd * 8000;
                    endpos = physicstrace( start, end );
                    bestdistsq = 65536;
                    var_2fb8bc3b014e540 = undefined;
                    
                    for ( index = 0; index < var_2c1a264ec0289d7f.size ; index++ )
                    {
                        distsq = distancesquared( var_2c1a264ec0289d7f[ index ].origin, endpos );
                        
                        if ( distsq < bestdistsq )
                        {
                            var_2fb8bc3b014e540 = index;
                        }
                    }
                    
                    if ( isdefined( var_2fb8bc3b014e540 ) )
                    {
                        var_2c1a264ec0289d7f[ var_2fb8bc3b014e540 ] delete();
                        var_2c1a264ec0289d7f[ var_2fb8bc3b014e540 ] = undefined;
                        
                        if ( isint( var_2fb8bc3b014e540 ) )
                        {
                            function_cdc669dbc8ea2101( var_2c1a264ec0289d7f );
                        }
                        
                        iprintlnbold( "<dev string:x531>" + var_2c1a264ec0289d7f.size + "<dev string:x54d>" );
                    }
                    else
                    {
                        iprintlnbold( "<dev string:x558>" + endpos );
                    }
                }
                
                continue;
            }
            
            if ( note == "<dev string:x4f9>" )
            {
                println( "<dev string:x57b>" );
                offset = ( 0, 0, 0 );
                filepath = "<dev string:x592>" + level.script + "<dev string:x5a6>";
                var_b3dbc63ff95194ac = openfile( filepath, "<dev string:x5b5>" );
                fprintln( var_b3dbc63ff95194ac, "<dev string:x5bb>" );
                fprintln( var_b3dbc63ff95194ac, "<dev string:x5c4>" );
                fprintln( var_b3dbc63ff95194ac, "<dev string:x5cb>" );
                fprintln( var_b3dbc63ff95194ac, "<dev string:x5cd>" );
                fprintln( var_b3dbc63ff95194ac, "<dev string:x5e8>" );
                fprintln( var_b3dbc63ff95194ac, "<dev string:x604>" );
                fprintln( var_b3dbc63ff95194ac, "<dev string:x610>" );
                fprintln( var_b3dbc63ff95194ac, "<dev string:x612>" );
                fprintln( var_b3dbc63ff95194ac, "<dev string:x5cb>" );
                fprintln( var_b3dbc63ff95194ac, "<dev string:x61b>" );
                fprintln( var_b3dbc63ff95194ac, "<dev string:x636>" );
                fprintln( var_b3dbc63ff95194ac, "<dev string:x668>" );
                fprintln( var_b3dbc63ff95194ac, "<dev string:x6a3>" );
                fprintln( var_b3dbc63ff95194ac, "<dev string:x6ad>" );
                fprintln( var_b3dbc63ff95194ac, "<dev string:x6b1>" );
                fprintln( var_b3dbc63ff95194ac, "<dev string:x6c9>" );
                fprintln( var_b3dbc63ff95194ac, "<dev string:x72c>" );
                fprintln( var_b3dbc63ff95194ac, "<dev string:x792>" );
                fprintln( var_b3dbc63ff95194ac, "<dev string:x7f8>" );
                fprintln( var_b3dbc63ff95194ac, "<dev string:x859>" );
                fprintln( var_b3dbc63ff95194ac, "<dev string:x8ba>" );
                fprintln( var_b3dbc63ff95194ac, "<dev string:x920>" );
                fprintln( var_b3dbc63ff95194ac, "<dev string:x610>" );
                entnum = 1;
                
                foreach ( entry in var_2c1a264ec0289d7f )
                {
                    fprintln( var_b3dbc63ff95194ac, "<dev string:x924>" + entnum );
                    fprintln( var_b3dbc63ff95194ac, "<dev string:x5cb>" );
                    fprintln( var_b3dbc63ff95194ac, "<dev string:x92c>" + "<dev string:x938>" + entry.angles[ 0 ] + "<dev string:x93a>" + entry.angles[ 1 ] + "<dev string:x93a>" + entry.angles[ 2 ] + "<dev string:x938>" );
                    fprintln( var_b3dbc63ff95194ac, "<dev string:x93c>" + "<dev string:x938>" + entry.origin[ 0 ] + offset[ 0 ] + "<dev string:x93a>" + entry.origin[ 1 ] + offset[ 1 ] + "<dev string:x93a>" + entry.origin[ 2 ] + offset[ 2 ] + "<dev string:x938>" );
                    fprintln( var_b3dbc63ff95194ac, "<dev string:x948>" + "<dev string:x938>" + entry.script_classname + "<dev string:x938>" );
                    fprintln( var_b3dbc63ff95194ac, "<dev string:x957>" + "<dev string:x938>" + entry.script_model + "<dev string:x938>" );
                    fprintln( var_b3dbc63ff95194ac, "<dev string:x962>" + "<dev string:x938>" + entry.targetname + "<dev string:x938>" );
                    fprintln( var_b3dbc63ff95194ac, "<dev string:x972>" + "<dev string:x938>" + entry.vehicletype + "<dev string:x938>" );
                    fprintln( var_b3dbc63ff95194ac, "<dev string:x983>" + "<dev string:x98f>" );
                    fprintln( var_b3dbc63ff95194ac, "<dev string:x997>" + "<dev string:x9a3>" );
                    fprintln( var_b3dbc63ff95194ac, "<dev string:x610>" );
                    entnum++;
                }
                
                closefile( var_b3dbc63ff95194ac );
                iprintlnbold( "<dev string:x9aa>" + var_2c1a264ec0289d7f.size + "<dev string:x9c3>" + filepath );
                continue;
            }
            
            start = player getvieworigin();
            angles = player getplayerangles();
            fwd = anglestoforward( angles );
            end = start + fwd * 8000;
            endpos = physicstrace( start, end );
            
            if ( endpos != end )
            {
                endpos += ( 0, 0, 16 );
                entry = spawn( "<dev string:x9d7>", endpos );
                entry.origin = endpos;
                entry.angles = ( 0, angles[ 1 ], 0 );
                entry.targetname = note;
                
                switch ( note )
                {
                    case #"hash_5b97d59c5aa200ba":
                        entry.script_classname = "<dev string:x9e4>";
                        entry.vehicletype = "<dev string:x9fd>";
                        entry.script_model = "<dev string:xa19>";
                        break;
                    case #"hash_9fae9f2b4d8960b5":
                        entry.script_classname = "<dev string:xa35>";
                        entry.vehicletype = "<dev string:xa4f>";
                        entry.script_model = "<dev string:xa61>";
                        break;
                    case #"hash_8d97f13aa572972d":
                        entry.script_classname = "<dev string:xa80>";
                        entry.vehicletype = "<dev string:xa96>";
                        entry.script_model = "<dev string:xaa7>";
                        break;
                    case #"hash_5976269dab51a932":
                        entry.script_classname = "<dev string:xaca>";
                        entry.vehicletype = "<dev string:xae6>";
                        entry.script_model = "<dev string:xaf7>";
                        break;
                }
                
                entry setmodel( entry.script_model );
                var_2c1a264ec0289d7f[ var_2c1a264ec0289d7f.size ] = entry;
                iprintlnbold( note + "<dev string:xb17>" + var_2c1a264ec0289d7f.size + "<dev string:x26b>" );
                function_ef5d7fd65e2c0763( entry );
            }
        }
    }

    // Namespace br_vehicles
    // Params 1
    // Checksum 0xb4210a77, Offset: 0x43c7
    // Size: 0x205, Type: dev
    function function_ef5d7fd65e2c0763( spawnpoint )
    {
        linecolor = ( 1, 0, 0 );
        
        if ( isstruct( spawnpoint ) )
        {
            script_model = undefined;
            
            switch ( spawnpoint.targetname )
            {
                case #"hash_5b97d59c5aa200ba":
                    script_model = "<dev string:xb29>";
                    linecolor = ( 1, 1, 1 );
                    break;
                case #"hash_9fae9f2b4d8960b5":
                    script_model = "<dev string:xb44>";
                    linecolor = ( 0, 1, 0 );
                    break;
                case #"hash_8d97f13aa572972d":
                    script_model = "<dev string:xb5f>";
                    linecolor = ( 1, 1, 0 );
                    break;
                case #"hash_5976269dab51a932":
                    script_model = "<dev string:xb79>";
                    linecolor = ( 1, 0, 0 );
                    break;
            }
            
            if ( isdefined( script_model ) )
            {
                placeholder = spawn( "<dev string:x9d7>", spawnpoint.origin );
                placeholder.origin = spawnpoint.origin;
                placeholder.angles = spawnpoint.angles;
                placeholder setmodel( script_model );
                wait 0.1;
            }
        }
        else
        {
            switch ( spawnpoint.targetname )
            {
                case #"hash_5b97d59c5aa200ba":
                    linecolor = ( 1, 1, 1 );
                    break;
                case #"hash_9fae9f2b4d8960b5":
                    linecolor = ( 0, 1, 0 );
                    break;
                case #"hash_8d97f13aa572972d":
                    linecolor = ( 1, 1, 0 );
                    break;
                case #"hash_5976269dab51a932":
                    linecolor = ( 1, 0, 0 );
                    break;
            }
        }
        
        line( spawnpoint.origin, spawnpoint.origin + ( 0, 0, 4096 ), linecolor, 1, 1, 200000 );
    }

    // Namespace br_vehicles
    // Params 0
    // Checksum 0xd6b140f4, Offset: 0x45d4
    // Size: 0x2b, Type: dev
    function mychangeswatcher()
    {
        while ( true )
        {
            level waittill( #"scriptable_restart" );
            vehicle_interact::allow_use_global( 0 );
            vehicle_interact::allow_use_global( 1 );
        }
    }

#/
