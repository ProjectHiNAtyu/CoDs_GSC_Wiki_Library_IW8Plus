// scripts\autotests\test_vehicles_seats.gsc  (hash_654e122dc9afb446.gscc) (size: 6150 Bytes / 0x1806 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfcd145bd (4241573309)
// size ...... 6150 (0x1806)
// includes .. 8   (offset: 0x15ce)
// strings ... 37  (offset: 0x160e)
// dev strs .. 0   (offset: 0x1806)
// exports ... 9   (offset: 0xf16)
// cseg ...... 0x39c + 0xb7a (0xf16)
// imports ... 41  (offset: 0x107e)
// animtree1 . 0   (offset: 0x1806)
// animtree2 . 0   (offset: 0x1806)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility_player;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_omnvar_utility;
#using scripts\common\vehicle_spawn;

#namespace test_vehicles_seats;

// Namespace test_vehicles_seats/testautomation
// Params 0, eflags: 0x20
// Checksum 0xa293f876, Offset: 0x3ba
// Size: 0x26
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/test_vehicles_seats.gsc", #"gp_vehicles", &start_test, &setup, &cleanup );
}

// Namespace test_vehicles_seats
// Params 0, eflags: 0x4
// Checksum 0xe9deef20, Offset: 0x3e8
// Size: 0x17, Type: bool
function private setup()
{
    autotests::function_5c8c87763724c132();
    utility::flag_wait( "vehicle_init_done" );
    return true;
}

// Namespace test_vehicles_seats
// Params 0, eflags: 0x4
// Checksum 0x9011e7f1, Offset: 0x408
// Size: 0x9
function private cleanup()
{
    function_15e328716acd61a3();
}

// Namespace test_vehicles_seats
// Params 0
// Checksum 0xdc63843f, Offset: 0x419
// Size: 0xc7, Type: bool
function function_15e328716acd61a3()
{
    if ( isdefined( level.autotests.spawnedvehicles ) )
    {
        foreach ( vehicle in level.autotests.spawnedvehicles )
        {
            autotests::report_info( "Cleaning up vehicle: " + vehicle.vehiclename );
            vehicle delete();
        }
        
        level.autotests.spawnedvehicles = undefined;
    }
    
    return true;
}

// Namespace test_vehicles_seats
// Params 0, eflags: 0x4
// Checksum 0x55a1286, Offset: 0x4e9
// Size: 0x24, Type: bool
function private start_test()
{
    player = autotests_utility_player::get_player();
    test_vehicles( get_vehicles(), player );
    return false;
}

// Namespace test_vehicles_seats
// Params 2
// Checksum 0x70f9c415, Offset: 0x516
// Size: 0x197
function test_vehicles( valid_vehicles, player )
{
    autotests::report_info( "Vehicles to test " + valid_vehicles.size );
    
    foreach ( vehicle in valid_vehicles )
    {
        var_63a718d91714219d = autotests::function_36ed835262a19e53( "vehicle still exists in map?", vehicle, "scripts/autotests/test_vehicles_seats.gsc", 66 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        if ( !isdefined( vehicle ) )
        {
            continue;
        }
        
        autotests::report_info( "Test vehicle " + vehicle.vehiclename );
        
        if ( vehicle_interact::get_data( vehicle vehicle::get_ref() ).var_c3d9b257664dde2a )
        {
            autotests::report_info( "Vehicle " + vehicle.vehiclename + " can't be used. Skipping it." );
            continue;
        }
        
        autotests::set_current_asset_name( vehicle.vehiclename );
        autotests::push_function( "Seat switch ok?" );
        test_result_int = test_seat_switch( vehicle, player ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Seat switch ok?", test_result_int, undefined, undefined, "scripts/autotests/test_vehicles_seats.gsc", 82 );
        autotests::pop_function( "Seat switch ok?" );
        autotests::test_assert_return( test_result_int );
    }
    
    autotests::set_current_asset_name( "" );
}

// Namespace test_vehicles_seats
// Params 2, eflags: 0x4
// Checksum 0xee6626f7, Offset: 0x6b5
// Size: 0x310
function private test_seat_switch( vehicle, player )
{
    allvehicleseats = vehicle_occupancy::function_8a8e1601e7e6610( vehicle );
    var_26b824fa49f8ce0c = allvehicleseats.size;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "All seats available before?", allvehicleseats.size, vehicle_occupancy::function_41d81defa67de264( vehicle ).size, "scripts/autotests/test_vehicles_seats.gsc", 92 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    if ( !vehicle_interact::vehicle_can_be_used( vehicle ) )
    {
        return 0;
    }
    
    autotests::report_info( "Vehicles has " + allvehicleseats.size + " seats" );
    next_seat_id = "driver";
    current_seat_id = next_seat_id;
    
    for ( i = 0; i < var_26b824fa49f8ce0c ; i++ )
    {
        if ( !isdefined( next_seat_id ) )
        {
            break;
        }
        
        autotests::report_info( "Trying to sit in seat " + next_seat_id );
        thread vehicle_occupancy::enter( vehicle, next_seat_id, player );
        
        if ( i == 0 )
        {
            autotests::test_wait_any( "Entered First Seat?", player, [ "vehicle_enter", "enter_vehicle" ], 2, "scripts/autotests/test_vehicles_seats.gsc", 116 );
            driver = vehicle_occupancy::get_driver( vehicle );
            var_63a718d91714219d = autotests::function_36ed835262a19e53( "Vehicle has driver?", driver, "scripts/autotests/test_vehicles_seats.gsc", 119 );
            
            if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
            {
                if ( autotests::function_561cb32cd7469145() )
                {
                    return;
                }
                
                autotests::test_assert_return( var_63a718d91714219d );
            }
            
            var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Driver is player?", driver, player, "scripts/autotests/test_vehicles_seats.gsc", 120 );
            
            if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
            {
                if ( autotests::function_561cb32cd7469145() )
                {
                    return;
                }
                
                autotests::test_assert_return( var_63a718d91714219d );
            }
        }
        else
        {
            autotests::test_wait_any( "Switched seat?", player, [ "vehicle_change_seat" ], 1, "scripts/autotests/test_vehicles_seats.gsc", 125 );
        }
        
        seats = vehicle_occupancy::function_41d81defa67de264( vehicle ).size;
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Only seat occupied?", var_26b824fa49f8ce0c - vehicle_occupancy::function_41d81defa67de264( vehicle ).size, 1, "scripts/autotests/test_vehicles_seats.gsc", 129 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        var_63a718d91714219d = autotests::function_36ed835262a19e53( "vehicle still exists after wait in seat switch test?", vehicle, "scripts/autotests/test_vehicles_seats.gsc", 131 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        current_seat_id = next_seat_id;
        next_seat_id = vehicle_occupancy::function_79f80964bb18e6c6( vehicle, player, current_seat_id );
    }
    
    thread vehicle_occupancy::exit( vehicle, current_seat_id, player );
    autotests::test_wait_any( "Exited vehicle?", player, [ "vehicle_seat_exit", "vehicle_exit" ], 2, "scripts/autotests/test_vehicles_seats.gsc", 138 );
    wait 2;
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "vehicle still exists after final wait in seat switch test?", vehicle, "scripts/autotests/test_vehicles_seats.gsc", 142 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "All seats available after?", allvehicleseats.size, vehicle_occupancy::function_41d81defa67de264( vehicle ).size, "scripts/autotests/test_vehicles_seats.gsc", 144 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    return 0;
}

// Namespace test_vehicles_seats
// Params 1
// Checksum 0x7d92734f, Offset: 0x9ce
// Size: 0x547
function get_vehicles( var_82a686028727ab67 = 0 )
{
    valid_vehicles = [];
    unique_huds = [];
    level.autotests.spawnedvehicles = [];
    
    if ( isdefined( level.vehicle ) )
    {
        foreach ( vehicles in level.vehicle.instances )
        {
            foreach ( vehicle in vehicles )
            {
                if ( !isdefined( vehicle ) || !vehicle_interact::vehicle_can_be_used( vehicle ) )
                {
                    continue;
                }
                
                if ( var_82a686028727ab67 )
                {
                    id = vehicle_omnvar::get_data( vehicle vehicle::get_ref() ).id;
                    
                    if ( !id || unique_huds[ id ] )
                    {
                        continue;
                    }
                    
                    unique_huds[ id ] = 1;
                }
                
                valid_vehicles[ valid_vehicles.size ] = vehicle;
            }
        }
    }
    
    corner = level.br_level.br_mapbounds[ 0 ] ?? level.mapcorners[ 0 ].origin;
    othercorner = level.br_level.br_mapbounds[ 1 ] ?? level.mapcorners[ 1 ].origin;
    directionx = utility::sign( othercorner[ 0 ] - corner[ 0 ] );
    directiony = utility::sign( othercorner[ 1 ] - corner[ 1 ] );
    corner += ( directionx * 10, directiony * 10, 0 );
    x = corner[ 0 ];
    y = corner[ 1 ];
    stepx = directionx * 700;
    stepy = directiony * 300;
    
    foreach ( vehicleref in vehicle::function_75acd2d48a8f3605( 1 ) )
    {
        if ( !isdefined( vehicle_spawn::get_data( vehicleref ) ) )
        {
            continue;
        }
        
        occupancydata = vehicle_occupancy::get_data( vehicleref );
        
        if ( !( isdefined( occupancydata.exitextents[ "front" ] ) && isdefined( occupancydata.exitextents[ "back" ] ) && isdefined( occupancydata.exitextents[ "left" ] ) && isdefined( occupancydata.exitextents[ "right" ] ) && isdefined( occupancydata.exitextents[ "bottom" ] ) && isdefined( occupancydata.seatdata ) ) || occupancydata.seatdata.size == 0 )
        {
            continue;
        }
        
        if ( var_82a686028727ab67 )
        {
            id = vehicle_omnvar::get_data( vehicleref ).id;
            
            if ( !id || unique_huds[ id ] )
            {
                continue;
            }
            
            unique_huds[ id ] = 1;
        }
        
        autotests::report_info( "Attempting to spawn: " + vehicle::get_data( vehicleref ).ref );
        
        while ( true )
        {
            origin = ( x, y, 0 );
            x += stepx;
            
            if ( directionx > 0 && x > othercorner[ 0 ] || directionx < 0 && x < othercorner[ 0 ] )
            {
                x = corner[ 0 ] * -1;
                y += stepy;
                
                if ( directiony > 0 && y > othercorner[ 1 ] || directiony < 0 && y < othercorner[ 1 ] )
                {
                    break;
                }
            }
            
            origin = vehicle::function_37bfd4038858cd15( vehicleref, origin );
            
            if ( !origin )
            {
                continue;
            }
            
            vehicle = vehicle::spawn( vehicleref, { #angles:( 0, 0, 0 ), #origin:origin } );
            var_63a718d91714219d = autotests::function_36ed835262a19e53( "Vehicle can spawn?", vehicle, "scripts/autotests/test_vehicles_seats.gsc", 230 );
            
            if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
            {
                if ( autotests::function_561cb32cd7469145() )
                {
                    return;
                }
                
                autotests::test_assert_return( var_63a718d91714219d );
            }
            
            if ( isdefined( vehicle ) )
            {
                valid_vehicles[ valid_vehicles.size ] = vehicle;
                level.autotests.spawnedvehicles[ level.autotests.spawnedvehicles.size ] = vehicle;
            }
            
            break;
        }
        
        if ( directiony > 0 && y > othercorner[ 1 ] || directiony < 0 && y < othercorner[ 1 ] )
        {
            autotests::report_info( "Ran out of flat space on the map to spawn vehicles" );
            break;
        }
    }
    
    return valid_vehicles;
}

