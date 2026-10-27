// scripts\common\vehicle_occupancy.gsc  (hash_4f91b90299ecc61e.gscc) (size: 98910 Bytes / 0x1825e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x23936bd7 (596863959)
// size ...... 98910 (0x1825e)
// includes .. 19  (offset: 0x16e32)
// strings ... 197 (offset: 0x16eca)
// dev strs .. 89  (offset: 0x17cb6)
// exports ... 248 (offset: 0xfd46)
// cseg ...... 0xe40 + 0xef06 (0xfd46)
// imports ... 538 (offset: 0x12406)
// animtree1 . 1   (offset: 0x18252)
// animtree2 . 0   (offset: 0x1825e)
#using script_4880fce3c83f33ef;
#using scripts\common\battle_tracks;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_ai;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_collision;
#using scripts\common\vehicle_compass;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_dlog;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_omnvar_utility;
#using scripts\common\vehicle_spawn;
#using scripts\common\weapon;

#namespace vehicle_occupancy;

// Namespace vehicle_occupancy
// Params 2
// Checksum 0x9249afcb, Offset: 0xe5e
// Size: 0x17f
function get_data( vehiclename, create )
{
    if ( create && ( !vehicle::has_data( vehiclename ) || !isdefined( vehicle::get_data( vehiclename ).occupancy ) ) )
    {
        data = undefined;
        
        if ( !vehicle::has_data( vehiclename ) )
        {
            data = spawnstruct();
        }
        else
        {
            data = vehicle::get_data( vehiclename );
        }
        
        data.occupancy = spawnstruct();
        data.occupancy.seatdata = [];
        data.occupancy.restrictions = [];
        data.occupancy.damagemodifier = -1;
        data.occupancy.threatbiasgroup = "Level_Vehicle";
        data.occupancy.exitextents = [];
        data.occupancy.exitoffsets = [];
        data.occupancy.exitdirections = [];
        data.occupancy.damagefeedbackgrouplight = "driver";
        data.occupancy.damagefeedbackgroupheavy = "all";
        vehicle::add_data( vehiclename, data );
    }
    
    if ( vehicle::has_data( vehiclename ) )
    {
        return vehicle::get_data( vehiclename ).occupancy;
    }
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0x7e309cd0, Offset: 0xfe5
// Size: 0x31, Type: bool
function function_4860c79fe0651911()
{
    if ( getdvarint( @"hash_c662d4e3a5aa9839" ) == 0 )
    {
        return false;
    }
    
    if ( !level.gamemodebundle.var_237502f987b43baf )
    {
        return false;
    }
    
    return true;
}

// Namespace vehicle_occupancy
// Params 3, eflags: 0x4
// Checksum 0x7803bbf3, Offset: 0x101f
// Size: 0x61
function private get_out( player, vehicle, exitvehicle )
{
    if ( isdefined( player ) )
    {
        if ( player isvehicleactive() )
        {
            player leavevehicle( 0, exitvehicle );
            
            while ( player function_a6a5bc06938ebb88() )
            {
                vehicle.var_222a83a3f36751e7 = 1;
                waitframe();
            }
        }
        
        assert( !player isvehicleactive() );
    }
}

// Namespace vehicle_occupancy
// Params 3
// Checksum 0x8f7d9758, Offset: 0x1088
// Size: 0xb5
function function_568cd324ac705619( vehiclename, seatid, create )
{
    if ( isstring( vehiclename ) && vehicle::has_data( vehiclename ) )
    {
        if ( level.projectbundle.var_53c4124af039142e )
        {
            if ( isdefined( vehicle::get_data( vehiclename ).vehicle ) )
            {
                vehiclename = vehicle::get_data( vehiclename ).vehicle;
            }
        }
        else if ( isdefined( vehicle::get_data( vehiclename ).bundlename ) )
        {
            vehiclename = vehicle::get_data( vehiclename ).bundlename;
        }
    }
    
    return get_data( vehiclename ).seatdata[ seatid ];
}

// Namespace vehicle_occupancy
// Params 1
// Checksum 0xd0caafd3, Offset: 0x1146
// Size: 0xb7
function register_instance( vehicle )
{
    vehicle.occupants = [];
    vehicle.occupantsreserving = [];
    vehicle.isempty = 1;
    
    /#
        leveldata = get_level_data();
        leveldata.debuginstances = function_5713d46873b29625( leveldata.debuginstances );
        leveldata.debuginstances[ leveldata.debuginstances.size ] = vehicle;
    #/
    
    if ( utility::issharedfuncdefined( #"vehicle_occupancy", #"registerInstance" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_occupancy", #"registerInstance" ) ]]( vehicle );
    }
}

// Namespace vehicle_occupancy
// Params 1
// Checksum 0x366f4d8f, Offset: 0x1205
// Size: 0x70
function deregister_instance( vehicle )
{
    vehicle.occupants = undefined;
    vehicle.occupantsreserving = undefined;
    vehicle.isempty = undefined;
    vehicle.preventspawninto = undefined;
    
    if ( utility::issharedfuncdefined( #"vehicle_occupancy", #"deregisterInstance" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_occupancy", #"deregisterInstance" ) ]]( vehicle );
    }
}

// Namespace vehicle_occupancy
// Params 1
// Checksum 0x2f4e3824, Offset: 0x127d
// Size: 0x18, Type: bool
function instance_is_registered( vehicle )
{
    return isdefined( vehicle.occupants );
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0x8a75a2a6, Offset: 0x129e
// Size: 0x8e
function function_8a8e1601e7e6610( vehicle, var_bfba3b5977bff568 = 1 )
{
    assert( isdefined( vehicle vehicle::get_ref() ), "<dev string:x24>" );
    leveldataforvehicle = get_data( vehicle vehicle::get_ref() );
    assert( !var_bfba3b5977bff568 || isdefined( leveldataforvehicle ), "<dev string:x71>" );
    
    if ( isdefined( leveldataforvehicle ) && isdefined( leveldataforvehicle.seatdata ) )
    {
        return getarraykeys( leveldataforvehicle.seatdata );
    }
    
    return;
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0xf4a4e19c, Offset: 0x1334
// Size: 0xb5
function function_41d81defa67de264( vehicle, player )
{
    availableseatids = [];
    seatids = function_8a8e1601e7e6610( vehicle );
    
    foreach ( seatid in seatids )
    {
        if ( !is_seat_available( vehicle, seatid, player ) )
        {
            continue;
        }
        
        availableseatids[ availableseatids.size ] = seatid;
    }
    
    return availableseatids;
}

// Namespace vehicle_occupancy
// Params 1
// Checksum 0x8a16707d, Offset: 0x13f2
// Size: 0x177
function function_495d488c998ad412( vehicle )
{
    availableseatids = function_41d81defa67de264( vehicle );
    
    if ( !isdefined( availableseatids ) || availableseatids.size <= 0 )
    {
        return;
    }
    else if ( availableseatids.size == 1 )
    {
        return availableseatids[ 0 ];
    }
    
    bestseat = availableseatids[ 0 ];
    bestpriority = -1;
    seatarray = vehicle_interact::get_data( vehicle vehicle::get_ref() ).var_30c65d47028f9ff4;
    assert( isdefined( seatarray ), "<dev string:xc9>" );
    
    foreach ( seatid in availableseatids )
    {
        leveldataforseat = function_568cd324ac705619( vehicle vehicle::get_ref(), seatid );
        spawnpriority = leveldataforseat.spawnpriority;
        seatorder = function_f02c63b99c9614c9( seatarray, seatid );
        
        if ( !isdefined( spawnpriority ) && isdefined( seatorder ) )
        {
            spawnpriority = seatarray.size - seatorder;
        }
        else if ( !isdefined( spawnpriority ) )
        {
            spawnpriority = 0;
        }
        else
        {
            spawnpriority = int( max( 0, spawnpriority ) );
        }
        
        if ( spawnpriority > bestpriority )
        {
            bestseat = seatid;
            bestpriority = spawnpriority;
        }
    }
    
    return bestseat;
}

// Namespace vehicle_occupancy
// Params 3
// Checksum 0x51dd9f50, Offset: 0x1572
// Size: 0xd3, Type: bool
function is_seat_available( vehicle, seatid, player )
{
    assert( isdefined( vehicle.occupants ) && isdefined( vehicle.occupantsreserving ), "<dev string:xed>" );
    
    if ( vehicle.var_a8b1efefa07bcfb7 && seatid == "driver" )
    {
        return false;
    }
    
    occupant = vehicle.occupants[ seatid ];
    occupantreserving = vehicle.occupantsreserving[ seatid ];
    
    if ( !isdefined( occupant ) && !isdefined( occupantreserving ) )
    {
        occupant = vehicle_ai::function_b74a31eb8af242a0( vehicle, seatid );
        
        if ( !isdefined( occupant ) )
        {
            return true;
        }
    }
    
    if ( isdefined( player ) )
    {
        if ( occupant === player )
        {
            return true;
        }
        
        if ( occupantreserving === player )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace vehicle_occupancy
// Params 3
// Checksum 0x94845f4, Offset: 0x164e
// Size: 0x275, Type: bool
function is_seat_blocked( vehicle, seatid, player )
{
    contents = physics_createcontents( [ "physicscontents_vehicleclip", "physicscontents_playerclip" ] );
    ignorelist = [];
    
    foreach ( ent in vehicle getlinkedchildren( 1 ) )
    {
        if ( !isplayer( ent ) )
        {
            ignorelist[ ignorelist.size ] = ent;
        }
    }
    
    ignorelist[ ignorelist.size ] = vehicle;
    ignorelist[ ignorelist.size ] = player;
    leveldataforseat = function_568cd324ac705619( vehicle vehicle::get_ref(), seatid );
    
    if ( !isdefined( leveldataforseat.animtag ) )
    {
        return false;
    }
    
    tagpos = vehicle gettagorigin( leveldataforseat.animtag );
    tagdir = anglestoup( vehicle gettagangles( leveldataforseat.animtag ) );
    var_5ae62c844686fca3 = tagpos + tagdir * leveldataforseat.var_45486078f1fde9bc;
    var_ada3dd75eb3e9b36 = var_5ae62c844686fca3 + tagdir * leveldataforseat.var_b009ee59cc7f2d56;
    spherecastradius = leveldataforseat.var_2a812fb731a0e4cf;
    seatcast = physics_spherecast( var_5ae62c844686fca3, var_ada3dd75eb3e9b36, spherecastradius, contents, ignorelist, "physicsquery_closest", "physicsquery_any", 1 );
    
    if ( seatcast[ 1 ] )
    {
        /#
            if ( level.debugvehicleexit )
            {
                level thread function_94553a295e176da5( var_5ae62c844686fca3, var_ada3dd75eb3e9b36, spherecastradius, 60, ( 1, 0, 1 ) );
            }
        #/
        
        return true;
    }
    
    if ( isdefined( seatcast ) && ( seatcast[ 1 ] || isdefined( seatcast[ 0 ][ 0 ][ "position" ] ) ) )
    {
        /#
            if ( level.debugvehicleexit )
            {
                finalposition = seatcast[ 0 ][ 0 ][ "<dev string:x155>" ] ?? var_ada3dd75eb3e9b36;
                
                if ( isdefined( seatcast[ 0 ][ 0 ][ "<dev string:x164>" ] ) )
                {
                    level thread function_daa8eeffc9a97683( seatcast[ 0 ][ 0 ][ "<dev string:x164>" ], spherecastradius, 60, ( 1, 0, 0 ) );
                }
                
                level thread function_94553a295e176da5( var_5ae62c844686fca3, finalposition, spherecastradius, 60, ( 0, 1, 0 ) );
            }
        #/
        
        return true;
    }
    
    return false;
}

// Namespace vehicle_occupancy
// Params 3
// Checksum 0xcd8bc72c, Offset: 0x18cc
// Size: 0x87
function get_seat_occupant( vehicle, seatid, var_bfba3b5977bff568 = 1 )
{
    assert( !var_bfba3b5977bff568 || isdefined( vehicle.occupants ), "<dev string:x16d>" + ( vehicle ? vehicle vehicle::get_ref() ?? "<dev string:x1e6>" : "<dev string:x1e6>" ) );
    
    if ( isdefined( vehicle.occupants ) )
    {
        return vehicle.occupants[ seatid ];
    }
    
    return;
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0x7e3309eb, Offset: 0x195b
// Size: 0x4d
function get_all_occupants( vehicle, var_bfba3b5977bff568 = 1 )
{
    if ( !vehicle.occupants )
    {
        assert( !var_bfba3b5977bff568, "<dev string:x1f0>" );
        return;
    }
    
    return arraycopy( vehicle.occupants );
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0x2cfb07e1, Offset: 0x19b1
// Size: 0x63
function function_8ed9bcd8e9ea74f5( vehicle, var_bfba3b5977bff568 = 1 )
{
    assert( !var_bfba3b5977bff568 || isdefined( vehicle.occupants ), "<dev string:x1f0>" );
    return arraycombineunique( vehicle.occupants, vehicle.ridingplayers, vehicle.turretoccupants );
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0xa98264c, Offset: 0x1a1d
// Size: 0x69
function function_b6077e40739ebc4b( vehicle, var_bfba3b5977bff568 = 1 )
{
    assert( !var_bfba3b5977bff568 || isdefined( vehicle.occupants ), "<dev string:x1f0>" );
    
    if ( !isdefined( vehicle.occupants ) )
    {
        return;
    }
    
    return arraycombineunique( vehicle.occupants, vehicle.occupantsreserving );
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0x8992ab45, Offset: 0x1a8f
// Size: 0x5a
function get_reserving( vehicle, var_bfba3b5977bff568 = 1 )
{
    assert( !var_bfba3b5977bff568 || isdefined( vehicle.occupants ), "<dev string:x1f0>" );
    
    if ( !isdefined( vehicle.occupants ) )
    {
        return;
    }
    
    return vehicle.occupantsreserving;
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0x67002682, Offset: 0x1af2
// Size: 0xb6
function get_occupant_seat( vehicle, player )
{
    assert( isdefined( vehicle.occupants ), "<dev string:x1f0>" );
    
    foreach ( seatid, occupant in vehicle.occupants )
    {
        if ( isnumber( seatid ) )
        {
            continue;
        }
        
        if ( occupant == player )
        {
            return seatid;
        }
    }
}

// Namespace vehicle_occupancy
// Params 1
// Checksum 0x60255a91, Offset: 0x1bb1
// Size: 0xa4, Type: bool
function function_3080323254ba6900( player )
{
    if ( isdefined( player.vehicle.occupants ) )
    {
        seatid = get_occupant_seat( player.vehicle, player );
        leveldataforseat = function_568cd324ac705619( player.vehicle vehicle::get_ref(), seatid );
        
        if ( isdefined( leveldataforseat.animtag ) && ( leveldataforseat.animtag == "tag_seat_0" || leveldataforseat.animtag == "offset_seat_0" ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0x63e5ba75, Offset: 0x1c5e
// Size: 0x3d
function get_driver( vehicle, var_e6c819f806ce2c86 )
{
    driverseatid = get_driver_seat( vehicle, var_e6c819f806ce2c86 );
    
    if ( isdefined( driverseatid ) )
    {
        return get_seat_occupant( vehicle, driverseatid, !var_e6c819f806ce2c86 );
    }
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0xdb252af0, Offset: 0x1ca4
// Size: 0x1a
function get_driver_seat( vehicle, var_e6c819f806ce2c86 )
{
    return "driver";
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0x6e5bc787, Offset: 0x1cc7
// Size: 0x42, Type: bool
function is_driver_seat( vehicle, seatid )
{
    leveldataforseat = function_568cd324ac705619( vehicle vehicle::get_ref(), seatid );
    return leveldataforseat.ref == "driver";
}

// Namespace vehicle_occupancy
// Params 5
// Checksum 0x4e9bc56d, Offset: 0x1d12
// Size: 0x764
function enter( vehicle, seatid, player, data, immediate )
{
    assert( isdefined( vehicle vehicle::get_ref() ), "<dev string:x25c>" );
    assert( isdefined( get_data( vehicle vehicle::get_ref() ) ), "<dev string:x2ab>" + vehicle.vehiclename + "<dev string:x2c9>" );
    assert( isdefined( vehicle.occupants ) && isdefined( vehicle.occupantsreserving ), "<dev string:x305>" );
    assert( !( isdefined( data ) && isdefined( data.success ) ), "<dev string:x365>" );
    var_3bcce941a1db4325 = 0;
    
    if ( isdefined( data ) && isdefined( data.useonspawn ) )
    {
        var_3bcce941a1db4325 = 1;
    }
    
    if ( !var_3bcce941a1db4325 && !player utility::callsharedfunc( #"player", #"playerisalive" ) )
    {
        return;
    }
    
    if ( player.inlaststand )
    {
        return;
    }
    
    if ( vehicle.isdestroyed )
    {
        return;
    }
    
    if ( player.var_f3e39340e1caf279 >= gettime() )
    {
        return;
    }
    
    if ( !isent( vehicle ) )
    {
        return;
    }
    
    foreach ( occupantreserving in vehicle.occupantsreserving )
    {
        if ( occupantreserving == player )
        {
            return;
        }
    }
    
    if ( !callback::response( 2, #"hash_8267c353428d4773", { #immediate:immediate, #data:data, #player:player, #seatid:seatid, #vehicle:vehicle } ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_4fe1e9e44bfa1554", 1 ) == 1 )
    {
        leveldataforseat = function_568cd324ac705619( vehicle vehicle::get_ref(), seatid );
        
        if ( leveldataforseat && leveldataforseat.requireclearance )
        {
            if ( is_seat_blocked( vehicle, seatid, player ) )
            {
                error_message( player, 4 );
                return;
            }
        }
    }
    
    oldseatid = get_occupant_seat( vehicle, player );
    
    if ( attempt_hijack( vehicle, seatid, player, data, immediate ) )
    {
        return;
    }
    
    stop_monitoring_occupant( player );
    
    if ( !isdefined( data ) )
    {
        data = spawnstruct();
    }
    
    data.immediate = istrue( immediate );
    data.raceendnotify = "vehicle_race_last_call";
    data.raceendon = "vehicle_race_finished";
    
    if ( !data.immediate )
    {
        thread function_301751a8d62a4337( player, data );
        thread race_vehicle_death( vehicle, data );
        thread function_4f363a218b64862c( vehicle, player, seatid, oldseatid, data );
        thread race_complete( oldseatid, seatid, data );
    }
    
    if ( isdefined( oldseatid ) )
    {
        thread exit_start( vehicle, oldseatid, seatid, player, data );
    }
    
    if ( isdefined( seatid ) )
    {
        thread enter_start( vehicle, seatid, oldseatid, player, data );
    }
    
    update_occupancy( vehicle );
    thread monitor_empty_occupied_vehicle_bug( vehicle );
    
    if ( !data.immediate )
    {
        data waittill( data.raceendnotify );
        waittillframeend();
        data notify( data.raceendon );
    }
    
    if ( !vehicle_interact::instance_is_registered( vehicle ) )
    {
        return;
    }
    
    success = race_results( vehicle, player, oldseatid, seatid, data );
    
    if ( isdefined( oldseatid ) )
    {
        thread exit_end( vehicle, oldseatid, seatid, player, data );
    }
    
    if ( isdefined( seatid ) )
    {
        thread enter_end( vehicle, seatid, oldseatid, player, data );
    }
    
    update_occupancy( vehicle );
    vehicle vehicle_interact::update_occupancy_lights();
    
    if ( success )
    {
        if ( utility::issharedfuncdefined( #"vehicle_occupancy", #"changedSeats" ) )
        {
            [[ utility::getsharedfunc( #"vehicle_occupancy", #"changedSeats" ) ]]( player, vehicle, oldseatid, seatid );
        }
        
        thread monitor_occupant( vehicle, player, seatid );
        player val::reset( "veh_occupancy_reload", "reload" );
        
        if ( isdefined( oldseatid ) )
        {
            isdriverseat = is_driver_seat( vehicle, oldseatid );
            
            if ( isdriverseat )
            {
                if ( utility::issharedfuncdefined( #"challenges", #"stopchallengetimer" ) )
                {
                    player [[ utility::getsharedfunc( #"challenges", #"stopchallengetimer" ) ]]( "driving" );
                }
                
                vehicle thread vehicle_collision::function_9a12b1f4777c3cb3();
            }
        }
        
        if ( isdefined( seatid ) )
        {
            isdriverseat = is_driver_seat( vehicle, seatid );
            
            if ( isdriverseat )
            {
                vehicle turn_engine_on();
                vehicle vehicle::function_75612a7234349491();
                
                if ( isdefined( player.vehiclecustomization ) )
                {
                    vehicleref = vehicle vehicle::get_ref();
                    
                    if ( !isdefined( vehicle.mtx ) && !vehicle.var_1f4f9d64c04f05db )
                    {
                        mtx = vehicle::function_a634e7859d837381( player, vehicleref );
                        vehicle::set_mtx( vehicle, mtx );
                    }
                    
                    if ( isdefined( player.vehiclecustomization.horns[ vehicleref ] ) )
                    {
                        vehicle setvehiclehornsound( player.vehiclecustomization.horns[ vehicleref ] );
                    }
                    else if ( isdefined( vehicle.mtx ) && isdefined( vehicle.mtx.vehiclehorn ) )
                    {
                        vehicle setvehiclehornsound( vehicle.mtx.vehiclehorn );
                    }
                    else
                    {
                        vehicle setvehiclehornsound( "" );
                    }
                }
                
                if ( utility::issharedfuncdefined( #"challenges", #"startchallengetimer" ) )
                {
                    player [[ utility::getsharedfunc( #"challenges", #"startchallengetimer" ) ]]( "driving" );
                }
                
                vehicle setrotorsactive( 1 );
            }
        }
        
        if ( !isdefined( oldseatid ) )
        {
            entertype = "ENTERED_VEHICLE";
            
            if ( utility::issharedfuncdefined( #"challenges", #"reportVehicleEvent" ) )
            {
                player [[ utility::getsharedfunc( #"challenges", #"reportVehicleEvent" ) ]]( vehicle, "enter_vehicle" );
            }
        }
        else
        {
            entertype = "SEAT_SWITCH";
        }
        
        if ( level.var_a7bf93687486b5ba[ vehicle vehicle::get_ref() ].haswartracks )
        {
            battle_tracks::vehicle_occupancy_enter( vehicle, player, seatid, oldseatid );
        }
        
        vehicle_dlog::enter_event( vehicle, player, seatid, entertype );
        vehicle.can_hijack = undefined;
        return;
    }
    
    if ( isdefined( oldseatid ) && !data.vehicledeath )
    {
        if ( data.playerdeath || data.playerlaststand || data.playerdisconnect )
        {
            _data = spawnstruct();
            _data.playerdeath = data.playerdeath;
            _data.playerlaststand = data.playerlaststand;
            _data.playerliveragdoll = data.playerliveragdoll;
            _data.playerdisconnect = data.playerdisconnect;
            thread exit( vehicle, oldseatid, player, _data, 1 );
            return;
        }
        
        reenter( vehicle, oldseatid, seatid, player, data );
    }
}

// Namespace vehicle_occupancy
// Params 6
// Checksum 0x3c9b1c56, Offset: 0x247e
// Size: 0x3c0
function exit( vehicle, seatid, player, data, immediate, specialexit )
{
    assert( isdefined( vehicle vehicle::get_ref() ), "<dev string:x3b0>" );
    assert( isdefined( get_data( vehicle vehicle::get_ref() ) ), "<dev string:x2ab>" + vehicle.vehiclename + "<dev string:x3fe>" );
    assert( isdefined( vehicle.occupants ) && isdefined( vehicle.occupantsreserving ), "<dev string:x439>" );
    
    if ( isdefined( data ) )
    {
        assert( !isdefined( data.success ), "<dev string:x498>" );
    }
    
    if ( isdefined( player ) && player function_2907aa812eda8a21() )
    {
        player notify( #"interrupt_roof_exit" );
        return;
    }
    
    oldseatid = seatid;
    
    if ( isdefined( player ) )
    {
        if ( !isdefined( oldseatid ) )
        {
            oldseatid = get_occupant_seat( vehicle, player );
        }
        
        if ( !player utility::callsharedfunc( #"player", #"playerisalive" ) )
        {
            immediate = 1;
        }
        
        if ( player.inlaststand )
        {
            immediate = 1;
        }
        
        stop_monitoring_occupant( player );
    }
    else
    {
        immediate = 1;
        function_448dc92adaa89078( vehicle, oldseatid );
    }
    
    if ( vehicle.isdestroyed )
    {
        immediate = 1;
    }
    
    assert( isdefined( oldseatid ), "<dev string:x4e2>" );
    
    if ( !isdefined( data ) )
    {
        data = spawnstruct();
    }
    
    data.immediate = istrue( immediate );
    data.raceendnotify = "vehicle_race_last_call";
    data.raceendon = "vehicle_race_finished";
    
    if ( !data.immediate )
    {
        thread function_301751a8d62a4337( player, data );
        thread race_vehicle_death( vehicle, data );
        thread race_complete( oldseatid, undefined, data );
    }
    
    thread exit_start( vehicle, oldseatid, undefined, player, data, specialexit );
    
    if ( !data.immediate )
    {
        data waittill( data.raceendnotify );
        waittillframeend();
        data notify( data.raceendon );
    }
    
    success = race_results( vehicle, player, oldseatid, undefined, data );
    thread exit_end( vehicle, oldseatid, undefined, player, data, specialexit );
    update_occupancy( vehicle );
    vehicle vehicle_interact::update_occupancy_lights();
    
    if ( player && player.var_be04506626bbcc1f )
    {
        player switchtoweaponimmediate( player.var_be04506626bbcc1f );
        player.var_be04506626bbcc1f = undefined;
    }
    
    if ( vehicle.isheli && vehicle.isempty )
    {
        vehicle thread function_8f5c8ba353b9ffe1();
    }
    
    if ( vehicle.isempty )
    {
        vehicle.var_eb7b108fdae249ab = player.team;
        vehicle.var_3c322c8f59f5832b = gettime();
    }
    
    if ( success )
    {
        if ( isdefined( player ) )
        {
            player val::reset( "veh_occupancy_reload", "reload" );
            isdriverseat = is_driver_seat( vehicle, oldseatid );
            
            if ( isdriverseat )
            {
                if ( utility::issharedfuncdefined( #"challenges", #"stopchallengetimer" ) )
                {
                    player [[ utility::getsharedfunc( #"challenges", #"stopchallengetimer" ) ]]( "driving" );
                }
                
                vehicle thread vehicle_collision::function_9a12b1f4777c3cb3();
            }
        }
        
        return;
    }
    
    if ( !data.playerdeath && !data.playerlaststand && !data.playerliveragdoll && !data.playerdisconnect && !data.vehicledeath )
    {
        reenter( vehicle, oldseatid, undefined, player, data );
    }
}

// Namespace vehicle_occupancy
// Params 5, eflags: 0x4
// Checksum 0x5a3795be, Offset: 0x2846
// Size: 0x160, Type: bool
function private attempt_hijack( vehicle, seatid, player, data, immediate )
{
    if ( getdvarint( @"hash_762d0b20f3d2c4d5", 0 ) != 1 || !vehicle.can_hijack || !is_driver_seat( vehicle, seatid ) )
    {
        return false;
    }
    
    if ( !is_seat_available( vehicle, seatid, player ) )
    {
        driver = get_driver( vehicle );
        
        if ( isagent( driver ) )
        {
            exit( vehicle, seatid, driver, data, 1 );
            broadcaststealthevent( player, "vehicle_hijack" );
            broadcasteventtocivs( player, "vehicle_hijack", player.origin, 200, 0 );
            broadcasteventtocivs( player, "vehicle_hijack", player.origin, 1000, 1 );
            vehicle notify( #"stop_ai_lookahead" );
            vehicle notify( #"stop_player_lookahead" );
        }
        else
        {
            return true;
        }
    }
    else
    {
        broadcaststealthevent( player, "vehicle_hijack" );
        broadcasteventtocivs( player, "vehicle_hijack", player.origin, 200, 0 );
        broadcasteventtocivs( player, "vehicle_hijack", player.origin, 1000, 1 );
        vehicle notify( #"stop_ai_lookahead" );
        vehicle notify( #"stop_player_lookahead" );
    }
    
    return false;
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0xb91858d9, Offset: 0x29af
// Size: 0x5f
function is_friendly_to_player( vehicle, player )
{
    if ( level.teambased )
    {
        return function_977daeae4e2f0e30( vehicle, player.team );
    }
    
    if ( vehicle.friendlystatusdirty )
    {
        vehicle function_6db77ed5a92ea72e( vehicle );
    }
    
    return vehicle.playerfriendlyto == player;
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0x2b4b0e75, Offset: 0x2a16
// Size: 0x6f
function is_enemy_to_player( vehicle, player )
{
    if ( level.teambased )
    {
        return function_fcf4c995a24246d1( vehicle, player.team );
    }
    
    if ( vehicle.friendlystatusdirty )
    {
        vehicle function_6db77ed5a92ea72e( vehicle );
    }
    
    return isdefined( vehicle.playerfriendlyto ) && vehicle.playerfriendlyto != player;
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0x434b4b88, Offset: 0x2a8d
// Size: 0x5e
function is_neutral_to_player( vehicle, player )
{
    if ( level.teambased )
    {
        return function_381efb9169661936( vehicle, player.team );
    }
    
    if ( vehicle.friendlystatusdirty )
    {
        vehicle function_6db77ed5a92ea72e( vehicle );
    }
    
    return !isdefined( vehicle.playerfriendlyto );
}

// Namespace vehicle_occupancy
// Params 1
// Checksum 0x5dcad295, Offset: 0x2af3
// Size: 0x3d
function get_player_friendly_to( vehicle )
{
    if ( !level.teambased )
    {
        if ( vehicle.friendlystatusdirty )
        {
            vehicle function_6db77ed5a92ea72e( vehicle );
        }
        
        return vehicle.playerfriendlyto;
    }
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0x77eff421, Offset: 0x2b39
// Size: 0x58
function function_977daeae4e2f0e30( vehicle, team )
{
    if ( level.teambased )
    {
        if ( vehicle.friendlystatusdirty )
        {
            vehicle function_6db77ed5a92ea72e( vehicle );
        }
        
        return ( isdefined( vehicle.teamfriendlyto ) && vehicle.teamfriendlyto === team );
    }
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0x11a1f0a1, Offset: 0x2b9a
// Size: 0x58
function function_fcf4c995a24246d1( vehicle, team )
{
    if ( level.teambased )
    {
        if ( vehicle.friendlystatusdirty )
        {
            vehicle function_6db77ed5a92ea72e( vehicle );
        }
        
        return ( isdefined( vehicle.teamfriendlyto ) && vehicle.teamfriendlyto != team );
    }
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0xc85a4d71, Offset: 0x2bfb
// Size: 0x47
function function_381efb9169661936( vehicle, team )
{
    if ( level.teambased )
    {
        if ( vehicle.friendlystatusdirty )
        {
            vehicle function_6db77ed5a92ea72e( vehicle );
        }
        
        return !isdefined( vehicle.teamfriendlyto );
    }
}

// Namespace vehicle_occupancy
// Params 1
// Checksum 0x55730d6e, Offset: 0x2c4b
// Size: 0x3c
function function_88fc32afbd317644( vehicle )
{
    if ( level.teambased )
    {
        if ( vehicle.friendlystatusdirty )
        {
            vehicle function_6db77ed5a92ea72e( vehicle );
        }
        
        return vehicle.teamfriendlyto;
    }
}

// Namespace vehicle_occupancy
// Params 1
// Checksum 0xe57e5850, Offset: 0x2c90
// Size: 0x23
function function_8b5abdda8e51a528( vehicle )
{
    vehicle.friendlystatusdirty = 1;
    vehicle_interact::set_dirty( vehicle );
}

// Namespace vehicle_occupancy
// Params 1
// Checksum 0x6fe3a20b, Offset: 0x2cbb
// Size: 0x2b6
function function_6db77ed5a92ea72e( vehicle )
{
    if ( level.teambased )
    {
        cleaned = 0;
        oldteamfriendlyto = vehicle.teamfriendlyto;
        
        if ( isdefined( vehicle.team ) && vehicle.team != "neutral" )
        {
            vehicle.teamfriendlyto = vehicle.team;
            vehicle.friendlystatusdirty = undefined;
            cleaned = 1;
        }
        
        if ( !cleaned )
        {
            foreach ( occupant in vehicle.occupants )
            {
                if ( isdefined( occupant ) )
                {
                    vehicle.teamfriendlyto = occupant.team;
                    vehicle.friendlystatusdirty = undefined;
                    cleaned = 1;
                    break;
                }
            }
        }
        
        if ( !cleaned )
        {
            vehicle.teamfriendlyto = undefined;
            vehicle.friendlystatusdirty = undefined;
        }
        
        if ( !isdefined( oldteamfriendlyto ) && !isdefined( vehicle.teamfriendlyto ) )
        {
            return 0;
        }
        
        if ( oldteamfriendlyto == vehicle.teamfriendlyto )
        {
            return 0;
        }
        
        function_863cca296c26ac67( vehicle, oldteamfriendlyto, vehicle.teamfriendlyto );
        return 1;
    }
    
    cleaned = 0;
    oldplayerfriendlyto = vehicle.playerfriendlyto;
    
    if ( isdefined( vehicle.originalowner ) )
    {
        vehicle.playerfriendlyto = vehicle.originalowner;
        vehicle.friendlystatusdirty = undefined;
        cleaned = 1;
    }
    
    if ( !cleaned )
    {
        occupants = get_all_occupants( vehicle );
        
        foreach ( occupant in occupants )
        {
            if ( isdefined( occupant ) )
            {
                vehicle.playerfriendlyto = occupant;
                vehicle.friendlystatusdirty = undefined;
                return;
            }
        }
    }
    
    if ( !isdefined( oldplayerfriendlyto ) && !isdefined( vehicle.playerfriendlyto ) )
    {
        return 0;
    }
    
    if ( oldplayerfriendlyto == vehicle.playerfriendlyto )
    {
        return 0;
    }
    
    function_863cca296c26ac67( vehicle, oldplayerfriendlyto, vehicle.playerfriendlyto );
    return 1;
}

// Namespace vehicle_occupancy
// Params 3
// Checksum 0x1045024a, Offset: 0x2f79
// Size: 0xe4
function function_863cca296c26ac67( vehicle, var_82e6ae7a41cd7ff8, var_e56f1d76e18cd597 )
{
    /#
        if ( level.teambased )
        {
            assert( !isdefined( var_82e6ae7a41cd7ff8 ) || isstring( var_82e6ae7a41cd7ff8 ), "<dev string:x516>" );
            assert( !isdefined( var_e56f1d76e18cd597 ) || isstring( var_e56f1d76e18cd597 ), "<dev string:x55b>" );
        }
        else
        {
            assert( !isdefined( var_82e6ae7a41cd7ff8 ) || isplayer( var_82e6ae7a41cd7ff8 ), "<dev string:x5a0>" );
            assert( !isdefined( var_e56f1d76e18cd597 ) || isplayer( var_e56f1d76e18cd597 ), "<dev string:x5e5>" );
        }
    #/
    
    vehicle_compass::function_863cca296c26ac67( vehicle, var_82e6ae7a41cd7ff8, var_e56f1d76e18cd597 );
    leveldataforvehicle = get_data( vehicle vehicle::get_ref() );
    
    if ( !isdefined( leveldataforvehicle.friendlystatuschangedcallback ) )
    {
        return;
    }
    
    thread [[ leveldataforvehicle.friendlystatuschangedcallback ]]( vehicle, var_82e6ae7a41cd7ff8, var_e56f1d76e18cd597 );
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0x24a10739, Offset: 0x3065
// Size: 0x46
function set_original_owner( vehicle, player )
{
    assert( !isdefined( vehicle.originalowner ), "<dev string:x62a>" );
    vehicle.originalowner = player;
    update_owner( vehicle );
}

// Namespace vehicle_occupancy
// Params 4
// Checksum 0x70034202, Offset: 0x30b3
// Size: 0xa8
function set_owner( vehicle, player, var_f7e4f61d9c42bc80, timeroverride )
{
    if ( !isdefined( vehicle.owners ) )
    {
        vehicle.owners = [];
    }
    else
    {
        clear_owner( vehicle, player );
        vehicle.owners = function_5713d46873b29625( vehicle.owners );
    }
    
    vehicle.owners[ vehicle.owners.size ] = player;
    
    if ( timeroverride == -1 )
    {
    }
    else
    {
        thread watch_owner( vehicle, player, var_f7e4f61d9c42bc80, timeroverride );
    }
    
    update_owner( vehicle );
}

// Namespace vehicle_occupancy
// Params 1
// Checksum 0x7be18adf, Offset: 0x3163
// Size: 0x23e
function update_owner( vehicle )
{
    vehicle notify( #"vehicle_owner_update" );
    previousowner = vehicle.owner;
    previousownerteam = vehicle.ownerteam;
    bestowner = undefined;
    
    if ( isdefined( vehicle.owners ) )
    {
        for ( i = vehicle.owners.size - 1; i >= 0 ; i-- )
        {
            if ( is_player_valid_owner( vehicle, vehicle.owners[ i ] ) )
            {
                bestowner = vehicle.owners[ i ];
                break;
            }
        }
    }
    
    if ( !isdefined( bestowner ) )
    {
        if ( is_player_valid_owner( vehicle, vehicle.originalowner ) )
        {
            bestowner = vehicle.originalowner;
        }
    }
    
    vehicle.owner = bestowner;
    ownerchanged = 0;
    
    if ( isdefined( bestowner ) || isdefined( previousowner ) )
    {
        if ( !isdefined( bestowner ) && isdefined( previousowner ) )
        {
            ownerchanged = 1;
        }
        else if ( isdefined( bestowner ) && !isdefined( previousowner ) )
        {
            ownerchanged = 1;
        }
        else if ( bestowner != previousowner )
        {
            ownerchanged = 1;
        }
    }
    
    ownerteamchanged = 0;
    
    if ( isdefined( bestowner ) )
    {
        if ( previousownerteam != bestowner.team )
        {
            ownerteamchanged = 1;
        }
        
        vehicle.ownerteam = bestowner.team;
        vehicle_compass::function_e527b9d6ae381350( vehicle, bestowner.team );
        thread watch_owner_joined_team( vehicle, bestowner );
    }
    else
    {
        if ( ownerchanged )
        {
            ownerteamchanged = 1;
        }
        
        vehicle.ownerteam = undefined;
    }
    
    if ( ownerchanged )
    {
        if ( !level.teambased )
        {
            function_8b5abdda8e51a528( vehicle );
        }
        
        vehicle vehicle::bunker_buster_update_callback();
    }
    
    if ( utility::issharedfuncdefined( #"vehicle_occupancy", #"updateOwner" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_occupancy", #"updateOwner" ) ]]( vehicle );
    }
    
    if ( utility::issharedfuncdefined( vehicle vehicle::get_ref(), #"updateOwner" ) )
    {
        [[ utility::getsharedfunc( vehicle vehicle::get_ref(), #"updateOwner" ) ]]( vehicle, bestowner, ownerchanged, ownerteamchanged );
    }
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0xc2b4143c, Offset: 0x33a9
// Size: 0x6b
function clear_owner( vehicle, player )
{
    vehicle notify( "vehicle_clear_owner_" + player getentitynumber() );
    
    if ( isdefined( vehicle.owners ) )
    {
        vehicle.owners = arrayremove( vehicle.owners, player );
    }
    
    if ( vehicle.owner == player )
    {
        update_owner( vehicle );
    }
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0xd8395c9b, Offset: 0x341c
// Size: 0xb6
function set_team( vehicle, team )
{
    teamchanged = vehicle.team != team;
    vehicle.team = team;
    
    if ( vehicle.classname == "script_vehicle" )
    {
        vehicle_compass::function_e527b9d6ae381350( vehicle, team );
    }
    
    if ( teamchanged )
    {
        if ( level.teambased )
        {
            function_8b5abdda8e51a528( vehicle );
        }
    }
    
    if ( utility::issharedfuncdefined( vehicle vehicle::get_ref(), #"updateTeam" ) )
    {
        [[ utility::getsharedfunc( vehicle vehicle::get_ref(), #"updateTeam" ) ]]( vehicle, team, teamchanged );
    }
    
    update_owner( vehicle );
}

#using_animtree( "script_model" );

// Namespace vehicle_occupancy
// Params 0
// Checksum 0x42a2743d, Offset: 0x34da
// Size: 0x1bf
function init()
{
    assert( isdefined( level.vehicle ), "<dev string:x684>" );
    assert( !isdefined( level.vehicle.occupancy ), "<dev string:x6bb>" );
    leveldata = spawnstruct();
    level.vehicle.occupancy = leveldata;
    leveldata.var_a87413b9ffb22fc6 = getdvarint( @"hash_4bf0d02ff4ac62ed", 1 ) > 0;
    
    if ( leveldata.var_a87413b9ffb22fc6 )
    {
        leveldata.var_578122b40ca9849a = 0;
        leveldata.var_1a843af7d8cf4c6b = [];
    }
    
    init_debug();
    callback::callback( #"vehicle_occupancy_init", {} );
    level.var_9e85fa55dfcb5605 = getdvarint( @"bg_veh_exit_jumpout_enabled", 1 );
    level.var_e445b76f87f11639 = getdvarint( @"hash_2bf0e47506040359", 1 ) == 1;
    level.var_8b0a26b04bac3108 = getdvarfloat( @"hash_83928d2d50dc276c" ) + 50;
    level.var_51db840a745c6105 = getdvarfloat( @"hash_c9b7b0f34821b869" ) + 50;
    level.var_cb8ff8f046da9128 = getdvarfloat( @"hash_94db90babe43cdc4", 100 );
    level.vehiclelightsenabled = getdvarint( @"scr_vehicle_lights", 1 );
    
    if ( utility::callsharedfunc( #"game", #"isusingmatchrulesdata" ) )
    {
        leveldata.var_f706d2ddeaba4c7 = utility::callsharedfunc( #"game", #"getmatchrulesdata", "commonOption", "vehicleUnmannedKillProtectionTimeout" ) ?? 4;
    }
    
    if ( level.var_e445b76f87f11639 )
    {
        level.scr_animtree[ "player_exit_vehicle_to_roof" ] = #animtree;
    }
}

// Namespace vehicle_occupancy
// Params 5, eflags: 0x4
// Checksum 0xdad7ab9c, Offset: 0x36a1
// Size: 0x13e
function private enter_start( vehicle, seatid, oldseatid, player, data )
{
    data endon( data.raceendon );
    
    if ( player.insertingarmorplate )
    {
        player notify( #"try_armor_cancel", "vehicle_enter" );
    }
    
    vehicle_damage::function_5ca0c600bb09b1d2( vehicle, player );
    vehicle.occupantsreserving[ seatid ] = player;
    player.vehiclereserved = vehicle;
    vehicle_interact::update_usability( vehicle );
    timestamp = undefined;
    
    if ( data.immediate )
    {
        timestamp = gettime();
    }
    
    if ( isdefined( data.enterstartwaitmsg ) )
    {
        player waittill( data.enterstartwaitmsg );
    }
    
    function_4793dd4d02d6e68c( vehicle, seatid, 1 );
    enterstartcallback = function_82efe2b416a05fc2( vehicle, seatid );
    
    if ( isdefined( enterstartcallback ) )
    {
        [[ enterstartcallback ]]( vehicle, seatid, oldseatid, player, data );
    }
    
    if ( !isdefined( data.enterstartcomplete ) )
    {
        data.enterstartcomplete = 1;
    }
    
    if ( data.immediate )
    {
        assert( timestamp == gettime(), "<dev string:x6f0>" );
    }
}

// Namespace vehicle_occupancy
// Params 6, eflags: 0x4
// Checksum 0x5573af3, Offset: 0x37e7
// Size: 0x10a
function private exit_start( vehicle, seatid, newseatid, player, data, specialexit )
{
    data endon( data.raceendon );
    timestamp = undefined;
    
    if ( data.immediate )
    {
        timestamp = gettime();
    }
    
    if ( isdefined( player ) )
    {
        if ( player isinvehicleleanout() )
        {
            player.var_1eccc1c617b1c217 = 1;
        }
        else
        {
            player.var_1eccc1c617b1c217 = undefined;
        }
    }
    
    exitstartcallback = function_5780eb2296e7b4b6( vehicle, seatid );
    
    if ( isdefined( exitstartcallback ) )
    {
        [[ exitstartcallback ]]( vehicle, seatid, newseatid, player, data, specialexit );
    }
    else
    {
        exit_start_callback( vehicle, seatid, newseatid, player, data, specialexit );
    }
    
    if ( !isdefined( data.exitstartcomplete ) )
    {
        data.exitstartcomplete = 1;
    }
    
    if ( data.immediate )
    {
        assert( timestamp == gettime(), "<dev string:x73e>" );
    }
}

// Namespace vehicle_occupancy
// Params 5
// Checksum 0xe28b8384, Offset: 0x38f9
// Size: 0x4c
function function_cd55d6fab4e1e132( vehicle, seatid, oldseatid, player, data )
{
    if ( data.success )
    {
        function_e291d8dcac970f8e( vehicle, seatid, oldseatid, player, data );
    }
}

// Namespace vehicle_occupancy
// Params 5, eflags: 0x4
// Checksum 0xe7b3b5c1, Offset: 0x394d
// Size: 0x3d
function private function_e291d8dcac970f8e( vehicle, seatid, oldseatid, player, data )
{
    vehicle_omnvar::function_e0aa0be8e3297e0d( vehicle, oldseatid, seatid, player );
}

// Namespace vehicle_occupancy
// Params 5
// Checksum 0x6fa54956, Offset: 0x3992
// Size: 0x4c
function function_3a81035d298258ac( vehicle, seatid, newseatid, player, data )
{
    if ( data.success )
    {
        function_d7b87ab0b838d34c( vehicle, seatid, newseatid, player, data );
    }
}

// Namespace vehicle_occupancy
// Params 5, eflags: 0x4
// Checksum 0xf2b21c50, Offset: 0x39e6
// Size: 0xe6
function private function_d7b87ab0b838d34c( vehicle, seatid, newseatid, player, data )
{
    if ( !data.playerdisconnect )
    {
        success = move_player_to_exit( vehicle, seatid, newseatid, player, data );
        
        if ( !success )
        {
            if ( utility::issharedfuncdefined( #"vehicle_occupancy", #"handleSuicideFromVehicles" ) )
            {
                [[ utility::getsharedfunc( #"vehicle_occupancy", #"handleSuicideFromVehicles" ) ]]( player );
            }
            else if ( utility::issharedfuncdefined( #"player", #"suicide" ) )
            {
                player utility::callsharedfunc( #"player", #"suicide" );
            }
            else
            {
                player kill();
            }
        }
    }
    
    vehicle_omnvar::function_1f2d7e52383cc345( vehicle, seatid, newseatid, player );
}

// Namespace vehicle_occupancy
// Params 6
// Checksum 0x1e7bf328, Offset: 0x3ad4
// Size: 0x14c
function exit_start_callback( vehicle, seatid, newseatid, player, data, specialexit )
{
    player endon( #"disconnect" );
    data endon( data.raceendon );
    result = find_player_exit( player, vehicle, seatid, newseatid, data, specialexit );
    
    if ( !result )
    {
        data.exitstartcomplete = 0;
        error_message( player, specialexit == "_to_roof" ? 5 : 2 );
        
        if ( !data.immediate )
        {
            waitframe();
            data notify( data.raceendnotify );
        }
        
        return;
    }
    
    if ( data.specialexit == "_to_roof" && player && player isvehicleactive() )
    {
        result = roof_exit_animation( player, vehicle, seatid, data );
        
        if ( !result )
        {
            player val::reset_all( "vehicle_roof_exit" );
            player val::reset_all( "vehicle_occupant" );
            player val::reset_all( "vehicle_occupant_common" );
            vehicleref = vehicle vehicle::get_ref();
            vehicle_omnvar::clear_all( player, vehicleref );
            exit_start_callback( vehicle, seatid, newseatid, player, data, undefined );
        }
    }
}

// Namespace vehicle_occupancy
// Params 5, eflags: 0x4
// Checksum 0x930cde07, Offset: 0x3c28
// Size: 0x493
function private enter_end( vehicle, seatid, oldseatid, player, data )
{
    if ( data.success )
    {
        vehicle.occupants[ seatid ] = player;
        vehicle.occupantsreserving[ seatid ] = undefined;
        player.vehicle = vehicle;
        player.vehiclereserved = undefined;
        
        if ( utility::issharedfuncdefined( #"player", #"disableclassswapallowed" ) )
        {
            self [[ utility::getsharedfunc( #"player", #"disableclassswapallowed" ) ]]();
        }
        
        function_79ec2dd10f9db026( vehicle, seatid, player, data );
        update_riot_shield( player, vehicle, seatid );
        hide_occupant( vehicle, seatid, player, data );
        function_50ef45c679199e96( vehicle, seatid, oldseatid, player, data );
        function_24f5de0e1ca83fe4( vehicle, seatid, player, data );
        function_702b50a45a0bb141( vehicle, seatid, player, data );
        hide_helmet( vehicle, seatid, player, data );
        function_2f7211392db5a9ac( vehicle, player );
        
        if ( vehicle vehicle_damage::function_2b7271a5e9ac2ec6( seatid ) )
        {
            player thread vehicle_damage::function_8b54529d7c41c894( vehicle, seatid );
        }
        
        if ( !isdefined( oldseatid ) )
        {
            on_enter_vehicle( vehicle, seatid, player, data );
            vehicle vehicle_interact::function_ca5f55b11d5b4274();
            
            if ( isdefined( player.pers[ "telemetry" ] ) )
            {
                var_800f9664a7db6ed2 = player.pers[ "telemetry" ];
                isgroundvehicle = vehicle vehicle::is_ground_vehicle();
                
                if ( isdefined( var_800f9664a7db6ed2.ground_vehicle_used_count ) && isgroundvehicle )
                {
                    var_800f9664a7db6ed2.ground_vehicle_used_count++;
                }
                
                isairvehicle = vehicle vehicle::can_fly();
                
                if ( isdefined( var_800f9664a7db6ed2.air_vehicle_used_count ) && isairvehicle )
                {
                    var_800f9664a7db6ed2.air_vehicle_used_count++;
                }
            }
        }
        
        leveldataforseat = function_568cd324ac705619( vehicle vehicle::get_ref(), seatid );
        
        if ( isdefined( leveldataforseat.animtag ) && ( leveldataforseat.animtag == "tag_seat_0" || leveldataforseat.animtag == "offset_seat_0" ) )
        {
            set_owner( vehicle, player, 1 );
        }
        
        if ( !isdefined( oldseatid ) )
        {
            vehicle notify( #"player_enter", player );
            player notify( #"vehicle_enter", vehicle );
            thread function_e49d06ee6668a3ca( player, vehicle, leveldataforseat, 1 );
        }
        else
        {
            player notify( #"vehicle_change_seat", vehicle );
            thread function_e49d06ee6668a3ca( player, vehicle, leveldataforseat, 0 );
        }
        
        wasdriver = is_driver_seat( vehicle, seatid );
        
        if ( wasdriver && vehicle::get_data( vehicle vehicle::get_ref() ).isboat )
        {
            vehicle function_9d1cf0e18cb109d3();
        }
        
        if ( vehicle.isheli )
        {
            vehicle function_474d87fe62493d22();
        }
        
        if ( wasdriver && vehicle.var_3fee62740baee02f )
        {
            vehicle function_9afa8159255a47de();
        }
    }
    else
    {
        if ( isdefined( player ) )
        {
            player.vehiclereserved = undefined;
        }
        
        if ( !data.vehicledeath )
        {
            vehicle.occupantsreserving[ seatid ] = undefined;
        }
    }
    
    timestamp = gettime();
    
    if ( data.success )
    {
        player thread animate_player( vehicle, seatid, oldseatid );
        hide_weapon( vehicle, seatid, player, data );
        
        if ( vehicle is_locked() && vehicle vehicle_isphysveh() )
        {
            vehicle vehphys_parkingbrake( 1 );
        }
        
        if ( !isdefined( oldseatid ) )
        {
            params = { #vehicle:vehicle, #seatid:seatid, #player:player };
            player callback::callback( #"player_vehicle_enter", params );
        }
        else
        {
            params = { #vehicle:vehicle, #oldseatid:oldseatid, #seatid:seatid, #player:player };
            player callback::callback( #"player_vehicle_seat_switch", params );
        }
        
        if ( seatid == "driver" && get_data( vehicle vehicle::get_ref() ).var_220b0d91c5bad4 )
        {
            vehicle thread function_6cb37d47153b2285( player );
        }
        
        vehicle thread monitor_occupant_submix( player, seatid );
    }
    
    enterendcallback = function_b1f649239886599b( vehicle, seatid );
    
    if ( isdefined( enterendcallback ) )
    {
        [[ enterendcallback ]]( vehicle, seatid, oldseatid, player, data );
    }
    else
    {
        function_cd55d6fab4e1e132( vehicle, seatid, oldseatid, player, data );
    }
    
    assert( timestamp == gettime(), "<dev string:x78b>" );
}

// Namespace vehicle_occupancy
// Params 6, eflags: 0x4
// Checksum 0xed07e997, Offset: 0x40c3
// Size: 0x2d5
function private exit_end( vehicle, seatid, newseatid, player, data, specialexit )
{
    if ( data.success )
    {
        vehicle.occupants[ seatid ] = undefined;
        
        if ( isdefined( player ) )
        {
            player notify( #"vehicle_seat_exit" );
            
            if ( !isdefined( newseatid ) )
            {
                player.vehicle = undefined;
            }
            
            function_822f728fe96ed09( vehicle, seatid, player, data );
            update_riot_shield( player, vehicle, newseatid );
            show_occupant( vehicle, seatid, player, data );
            show_weapon( vehicle, seatid, player, data );
            show_helmet( vehicle, seatid, player, data );
            function_ba3b1c53755cfe51( vehicle, newseatid, player, data );
            function_d817e42472ea2fc7( vehicle, seatid, player, data );
            function_91c2eed4926ac7c6( vehicle, seatid, player, data );
        }
        
        if ( !isdefined( newseatid ) )
        {
            on_exit_vehicle( vehicle, seatid, player, data );
        }
        
        if ( !vehicle vehicle_code::vehicle_is_stopped() && is_driver_seat( vehicle, seatid ) )
        {
            if ( utility::issharedfuncdefined( #"br", #"challengeevaluator" ) )
            {
                paramstruct = { #exitdriver:1 };
                player thread [[ utility::getsharedfunc( #"br", #"challengeevaluator" ) ]]( "br_mastery_ghostRideWhip", paramstruct );
            }
        }
        
        if ( is_driver_seat( vehicle, seatid ) && vehicle::get_data( vehicle vehicle::get_ref() ).isboat )
        {
            vehicle thread function_8881828632e5d04d();
        }
    }
    
    timestamp = gettime();
    exitendcallback = function_1dec8dc419914c27( vehicle, seatid );
    
    if ( isdefined( exitendcallback ) )
    {
        [[ exitendcallback ]]( vehicle, seatid, newseatid, player, data );
    }
    else
    {
        function_3a81035d298258ac( vehicle, seatid, newseatid, player, data );
    }
    
    if ( function_4860c79fe0651911() )
    {
        timestamp = gettime();
    }
    
    if ( isdefined( player ) )
    {
        player usebuttondone();
        
        if ( !isdefined( newseatid ) )
        {
            if ( isdefined( player.vehoccupancy_lastseatbc ) )
            {
                player.vehoccupancy_lastseatbc = undefined;
            }
            
            if ( isdefined( player.vehoccupancy_lastbctime ) )
            {
                player.vehoccupancy_lastbctime = undefined;
            }
        }
        
        player.var_6bb95d5c412d3e98 = undefined;
    }
    
    if ( data.success && !isdefined( newseatid ) )
    {
        if ( isdefined( player ) )
        {
            player.var_f3e39340e1caf279 = gettime() + getdvarint( @"hash_4c1997b229a0a01e", 100 );
        }
        
        params = { #specialexit:specialexit, #vehicle:vehicle, #seatid:seatid, #player:player };
        player callback::callback( #"player_vehicle_exit", params );
    }
    
    assert( timestamp == gettime(), "<dev string:x7c3>" );
}

// Namespace vehicle_occupancy
// Params 5, eflags: 0x4
// Checksum 0x4ff15481, Offset: 0x43a0
// Size: 0xd7
function private reenter( vehicle, reenterseatid, var_79c815a81d81533, player, data )
{
    thread monitor_occupant( vehicle, player, reenterseatid );
    timestamp = gettime();
    reentercallback = function_cdec1bdc4ddf3d32( vehicle, reenterseatid );
    
    if ( isdefined( reentercallback ) )
    {
        [[ reentercallback ]]( vehicle, reenterseatid, var_79c815a81d81533, player, data );
    }
    else
    {
        data.success = undefined;
        data.exitposition = undefined;
        data.exitangles = undefined;
        data.specialexit = undefined;
        data.exitdirection = undefined;
        data.exitoffset = undefined;
        thread enter( vehicle, reenterseatid, player, data, 1 );
    }
    
    assert( timestamp == gettime(), "<dev string:x7fa>" );
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0x2278f435, Offset: 0x447f
// Size: 0x4d
function get_level_data()
{
    assert( isdefined( level.vehicle ), "<dev string:x831>" );
    assert( isdefined( level.vehicle.occupancy ), "<dev string:x883>" );
    return level.vehicle.occupancy;
}

// Namespace vehicle_occupancy
// Params 4, eflags: 0x4
// Checksum 0x54b5e15c, Offset: 0x44d5
// Size: 0x15c
function private function_e49d06ee6668a3ca( player, vehicle, seatdata, var_4822120e6ef8e0c2 )
{
    if ( utility::issp() )
    {
        return;
    }
    
    data = vehicle::get_data( vehicle vehicle::get_ref() );
    
    if ( data.occupancy.disablebattlechatter )
    {
        return;
    }
    
    assert( utility::issharedfuncdefined( #"game", #"trysaylocalsound" ) );
    soundevent = function_5049968b7024f750( vehicle, seatdata );
    
    if ( var_4822120e6ef8e0c2 )
    {
        player.vehoccupancy_lastseatbc = soundevent;
        player.vehoccupancy_lastbctime = gettime();
        thread utility::callsharedfunc( #"game", #"trysaylocalsound", player, soundevent, 1 );
        return;
    }
    
    if ( isdefined( player.vehoccupancy_lastseatbc ) && isdefined( player.vehoccupancy_lastbctime ) && player.vehoccupancy_lastseatbc != soundevent && utility::time_has_passed( player.vehoccupancy_lastbctime, 5 ) )
    {
        player.vehoccupancy_lastseatbc = soundevent;
        player.vehoccupancy_lastbctime = gettime();
        thread utility::callsharedfunc( #"game", #"trysaylocalsound", player, soundevent );
    }
}

// Namespace vehicle_occupancy
// Params 2, eflags: 0x4
// Checksum 0x6c253648, Offset: 0x4639
// Size: 0x79
function private function_5049968b7024f750( vehicle, seatdata )
{
    if ( seatdata.ref == "driver" )
    {
        if ( vehicle vehicle::ishelicopter() )
        {
            return #"ping_vehicle_pilot";
        }
        else
        {
            return #"ping_vehicle_driver";
        }
        
        return;
    }
    
    if ( seatdata.ref == "gunner" )
    {
        return #"ping_vehicle_gunner";
    }
    
    return #"ping_vehicle_rider";
}

// Namespace vehicle_occupancy
// Params 2, eflags: 0x4
// Checksum 0x436b96f7, Offset: 0x46ba
// Size: 0x31
function private function_448dc92adaa89078( vehicle, seatid )
{
    vehicle.occupants[ seatid ] = undefined;
    vehicle.occupantsreserving[ seatid ] = undefined;
}

// Namespace vehicle_occupancy
// Params 4, eflags: 0x4
// Checksum 0xd7580db, Offset: 0x46f3
// Size: 0x174
function private on_enter_vehicle( vehicle, newseatid, player, data )
{
    level notify( #"enter_vehicle", vehicle, player );
    function_8b5abdda8e51a528( vehicle );
    function_a35cf989a96d5404( vehicle, player );
    vehicle vehicle_spawn::stop_watching_abandoned();
    player setstance( "stand" );
    player val::set_array( "vehicle_occupant_common", get_occupant_restrictions(), 0 );
    thread take_riot_shield( player, vehicle, newseatid );
    battle_tracks::on_enter_vehicle( vehicle, player );
    vehicle_interact::on_enter_vehicle( vehicle, player );
    namespace_258c393149f2e837::on_enter_vehicle( vehicle, player );
    
    if ( utility::issharedfuncdefined( #"vehicle_occupancy", #"onEnterVehicle" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_occupancy", #"onEnterVehicle" ) ]]( vehicle, newseatid, player, data );
    }
    
    params = { #data:data, #player:player, #newseatid:newseatid, #vehicle:vehicle };
    level callback::callback( "onEnterVehicle", params );
    
    /#
        if ( utility::issharedfuncdefined( #"game", #"gethostplayer" ) )
        {
            host = [[ utility::getsharedfunc( #"game", #"gethostplayer" ) ]]();
            
            if ( player == host )
            {
                level.botvehicle = vehicle;
            }
        }
    #/
}

// Namespace vehicle_occupancy
// Params 4, eflags: 0x4
// Checksum 0x1a67922d, Offset: 0x486f
// Size: 0x219
function private on_exit_vehicle( vehicle, oldseatid, player, data )
{
    level notify( #"exit_vehicle", vehicle, player );
    
    if ( !data.playerdisconnect )
    {
        player function_998629932390cbc4();
        player function_f2eda11ef5a74b2b();
        vehicle_interact::on_exit_vehicle( vehicle, player );
        
        if ( player.occupantsubmix )
        {
            function_cecc0376fcd40c5e( player, player.occupantsubmix );
        }
        
        if ( !data.playerdeath )
        {
            if ( data.playerlaststand || data.playerliveragdoll )
            {
                data.exittype = "DEATH";
            }
            else if ( !isdefined( data.exittype ) )
            {
                data.exittype = "VOLUNTARY";
            }
            
            thread vehicle_collision::function_e3bc60c772acd609( vehicle, player );
        }
        else
        {
            data.exittype = "DEATH";
        }
        
        thread give_riot_shield( player, data.playerdeath, data.playerlaststand );
    }
    else
    {
        data.exittype = "DISCONNECT";
    }
    
    function_8b5abdda8e51a528( vehicle );
    function_a35cf989a96d5404( vehicle, player );
    vehicle thread vehicle_spawn::watch_abandoned();
    
    if ( !vehicle vehicle::ishelicopter() )
    {
        vehicle thread vehicle_spawn::function_dbc69ecc19a5dca3();
    }
    
    if ( utility::issharedfuncdefined( #"vehicle_occupancy", #"onExitVehicle" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_occupancy", #"onExitVehicle" ) ]]( vehicle, oldseatid, player, data );
    }
    
    params = { #data:data, #player:player, #oldseatid:oldseatid, #vehicle:vehicle };
    level callback::callback( "onExitVehicle", params );
    player notify( #"exit_vehicle" );
    vehicle_dlog::exit_event( vehicle, player, oldseatid, data );
    battle_tracks::on_exit_vehicle( vehicle, player, oldseatid );
    namespace_258c393149f2e837::on_exit_vehicle( vehicle, player );
}

// Namespace vehicle_occupancy
// Params 2, eflags: 0x4
// Checksum 0xd1aafe33, Offset: 0x4a90
// Size: 0x5b
function private function_c4f474465c3cf339( vehicle, player )
{
    var_8e7ae3516bd8c682 = 1;
    
    while ( var_8e7ae3516bd8c682 )
    {
        if ( player function_a6a5bc06938ebb88() )
        {
            var_8e7ae3516bd8c682 = 0;
            break;
        }
        
        waitframe();
    }
    
    while ( player function_a6a5bc06938ebb88() )
    {
        waitframe();
    }
    
    vehicle utility::function_7c10ea82c1e305b8( "stability", "unstable" );
}

// Namespace vehicle_occupancy
// Params 2, eflags: 0x4
// Checksum 0x6bbaa1c2, Offset: 0x4af3
// Size: 0xb4
function private function_a35cf989a96d5404( vehicle, player )
{
    if ( !vehicle getscriptablehaspart( "stability" ) )
    {
        return;
    }
    
    occupants = get_all_occupants( vehicle );
    var_9bf1a3d220aae6e5 = utility::mph_to_ips( abs( vehicle vehicle_getspeed() ) );
    
    if ( occupants.size > 0 )
    {
        vehicle utility::function_7c10ea82c1e305b8( "stability", "stable" );
        return;
    }
    
    if ( occupants.size == 0 && var_9bf1a3d220aae6e5 > vehicle.var_e08a216ed3c26f8b )
    {
        if ( player function_f51629c9283ec6e4() )
        {
            thread function_c4f474465c3cf339( vehicle, player );
            return;
        }
        
        vehicle utility::function_7c10ea82c1e305b8( "stability", "unstable" );
    }
}

// Namespace vehicle_occupancy
// Params 1
// Checksum 0x45a78baf, Offset: 0x4baf
// Size: 0x87
function update_occupancy( vehicle )
{
    if ( !instance_is_registered( vehicle ) )
    {
        return;
    }
    
    availablevehicleseats = function_41d81defa67de264( vehicle );
    allvehicleseats = function_8a8e1601e7e6610( vehicle );
    vehicle.isempty = availablevehicleseats.size == allvehicleseats.size;
    vehicle.isfull = availablevehicleseats.size <= 0 ? 1 : undefined;
    vehicle_interact::set_dirty( vehicle );
    vehicle_interact::set_points_dirty( vehicle );
    vehicle_interact::update_usability( vehicle );
}

// Namespace vehicle_occupancy
// Params 2, eflags: 0x4
// Checksum 0xed1a8068, Offset: 0x4c3e
// Size: 0x47
function private function_82efe2b416a05fc2( vehicle, seatid )
{
    if ( utility::issharedfuncdefined( vehicle vehicle::get_ref(), #"enterStart" ) )
    {
        return utility::getsharedfunc( vehicle vehicle::get_ref(), #"enterStart" );
    }
}

// Namespace vehicle_occupancy
// Params 2, eflags: 0x4
// Checksum 0x3a195a05, Offset: 0x4c8d
// Size: 0x47
function private function_b1f649239886599b( vehicle, seatid )
{
    if ( utility::issharedfuncdefined( vehicle vehicle::get_ref(), #"enterEnd" ) )
    {
        return utility::getsharedfunc( vehicle vehicle::get_ref(), #"enterEnd" );
    }
}

// Namespace vehicle_occupancy
// Params 2, eflags: 0x4
// Checksum 0x72e45657, Offset: 0x4cdc
// Size: 0x47
function private function_5780eb2296e7b4b6( vehicle, seatid )
{
    if ( utility::issharedfuncdefined( vehicle vehicle::get_ref(), #"exitStart" ) )
    {
        return utility::getsharedfunc( vehicle vehicle::get_ref(), #"exitStart" );
    }
}

// Namespace vehicle_occupancy
// Params 2, eflags: 0x4
// Checksum 0xcf97cae, Offset: 0x4d2b
// Size: 0x47
function private function_1dec8dc419914c27( vehicle, seatid )
{
    if ( utility::issharedfuncdefined( vehicle vehicle::get_ref(), #"exitEnd" ) )
    {
        return utility::getsharedfunc( vehicle vehicle::get_ref(), #"exitEnd" );
    }
}

// Namespace vehicle_occupancy
// Params 2, eflags: 0x4
// Checksum 0xfc99e3f6, Offset: 0x4d7a
// Size: 0x47
function private function_cdec1bdc4ddf3d32( vehicle, seatid )
{
    if ( utility::issharedfuncdefined( vehicle vehicle::get_ref(), #"reenter" ) )
    {
        return utility::getsharedfunc( vehicle vehicle::get_ref(), #"reenter" );
    }
}

// Namespace vehicle_occupancy
// Params 4, eflags: 0x4
// Checksum 0x636cb15f, Offset: 0x4dc9
// Size: 0x81
function private function_79ec2dd10f9db026( vehicle, newseatid, player, data )
{
    if ( !is_movement_allowed( vehicle ) && !vehicle function_a64cc2eb8cc3ca3a() )
    {
        if ( newseatid == get_driver_seat( vehicle ) )
        {
            allow_movement_player( vehicle, player, 0, newseatid );
        }
    }
    
    restrictions = function_3774683642a3268( vehicle, newseatid );
    player val::set_array( "vehicle_occupant", restrictions, 0 );
}

// Namespace vehicle_occupancy
// Params 4, eflags: 0x4
// Checksum 0x7175099d, Offset: 0x4e52
// Size: 0x51
function private function_822f728fe96ed09( vehicle, oldseatid, player, data )
{
    if ( !data.playerdeath )
    {
        allow_movement_player( vehicle, player, 1, undefined );
        player val::reset_all( "vehicle_occupant" );
    }
}

// Namespace vehicle_occupancy
// Params 0, eflags: 0x4
// Checksum 0x375a41c1, Offset: 0x4eab
// Size: 0x2f
function private function_c6b1f5dcf2712ab2()
{
    if ( !isdefined( level.var_efd968853344c68b ) )
    {
        level.var_efd968853344c68b = getdvarint( @"hash_4f6bb46a93a86d18", 1 );
    }
    
    return level.var_efd968853344c68b;
}

// Namespace vehicle_occupancy
// Params 4, eflags: 0x4
// Checksum 0xdffdf4c2, Offset: 0x4ee3
// Size: 0x6f
function private hide_occupant( vehicle, newseatid, player, data )
{
    if ( function_b2d43c8350835934( vehicle, newseatid ) )
    {
        player.nocorpse = 1;
        
        if ( function_c6b1f5dcf2712ab2() )
        {
            player utility::callsharedfunc( #"player", #"playerhide" );
            return;
        }
        
        player playerhide();
    }
}

// Namespace vehicle_occupancy
// Params 4, eflags: 0x4
// Checksum 0x8fad893d, Offset: 0x4f5a
// Size: 0x79
function private hide_weapon( vehicle, oldseatid, player, data )
{
    should_hide_weapon = function_62a140633e1ef9a1( vehicle, oldseatid, player );
    
    if ( should_hide_weapon )
    {
        player.lastweaponobj = undefined;
        
        if ( should_hide_weapon.stowed )
        {
            player vehicle_setstowedweaponvisibility( 0 );
        }
        
        if ( should_hide_weapon.held )
        {
            player vehicle_setheldweaponvisibility( 0 );
        }
    }
}

// Namespace vehicle_occupancy
// Params 2, eflags: 0x4
// Checksum 0x7a9bcef5, Offset: 0x4fdb
// Size: 0xb0
function private function_15bf152e11f41072( player, data )
{
    leveldata = get_level_data();
    
    if ( !leveldata.var_a87413b9ffb22fc6 )
    {
        return;
    }
    
    id = leveldata.var_578122b40ca9849a;
    leveldata.var_578122b40ca9849a++;
    player utility::callsharedfunc( #"player", #"playerhide" );
    leveldata.var_1a843af7d8cf4c6b[ id ] = player;
    
    if ( !isdefined( data.var_1a843af7d8cf4c6b ) )
    {
        data.var_1a843af7d8cf4c6b = [];
    }
    
    data.var_1a843af7d8cf4c6b[ id ] = player;
    return id;
}

// Namespace vehicle_occupancy
// Params 3, eflags: 0x4
// Checksum 0x8ce7e2c8, Offset: 0x5094
// Size: 0xc7
function private function_8841dfac3cc31875( id, data, var_7b196ee02b72f962 )
{
    leveldata = get_level_data();
    
    if ( !leveldata.var_a87413b9ffb22fc6 )
    {
        return;
    }
    
    if ( var_7b196ee02b72f962 )
    {
        waitframe();
        waitframe();
    }
    
    if ( !leveldata.var_a87413b9ffb22fc6 )
    {
        return;
    }
    
    if ( !isdefined( leveldata.var_1a843af7d8cf4c6b[ id ] ) )
    {
        return;
    }
    
    player = leveldata.var_1a843af7d8cf4c6b[ id ];
    
    if ( isdefined( data ) && isdefined( data.var_1a843af7d8cf4c6b ) )
    {
        data.var_1a843af7d8cf4c6b[ id ] = undefined;
    }
    
    if ( isdefined( player ) )
    {
        player utility::callsharedfunc( #"player", #"playershow" );
    }
}

// Namespace vehicle_occupancy
// Params 2, eflags: 0x4
// Checksum 0x34ab59e5, Offset: 0x5163
// Size: 0x10b
function private function_d5622be2b7cbec44( data, var_7b196ee02b72f962 )
{
    leveldata = get_level_data();
    
    if ( !leveldata.var_a87413b9ffb22fc6 )
    {
        return;
    }
    
    if ( var_7b196ee02b72f962 )
    {
        waitframe();
        waitframe();
    }
    
    if ( !isdefined( data.var_1a843af7d8cf4c6b ) )
    {
        return;
    }
    
    foreach ( id, player in data.var_1a843af7d8cf4c6b )
    {
        if ( isdefined( leveldata.var_1a843af7d8cf4c6b[ id ] ) )
        {
            leveldata.var_1a843af7d8cf4c6b[ id ] = undefined;
            
            if ( isdefined( player ) )
            {
                player utility::callsharedfunc( #"player", #"playershow" );
            }
        }
    }
    
    data.var_1a843af7d8cf4c6b = undefined;
}

// Namespace vehicle_occupancy
// Params 0, eflags: 0x4
// Checksum 0x187dd24f, Offset: 0x5276
// Size: 0xa9
function private function_99e5cd8ebed537cf()
{
    leveldata = get_level_data();
    
    if ( !leveldata.var_a87413b9ffb22fc6 )
    {
        return;
    }
    
    foreach ( id, player in leveldata.var_1a843af7d8cf4c6b )
    {
        if ( !isdefined( player ) )
        {
            leveldata.var_1a843af7d8cf4c6b[ id ] = undefined;
        }
    }
}

// Namespace vehicle_occupancy
// Params 4, eflags: 0x4
// Checksum 0x1ecff5a7, Offset: 0x5327
// Size: 0x8a
function private show_occupant( vehicle, oldseatid, player, data )
{
    if ( !data.playerdeath )
    {
        if ( function_b2d43c8350835934( vehicle, oldseatid ) )
        {
            if ( !data.nocorpse )
            {
                player.nocorpse = undefined;
            }
            
            if ( function_c6b1f5dcf2712ab2() )
            {
                player utility::callsharedfunc( #"player", #"playershow" );
                return;
            }
            
            player playershow();
        }
    }
}

// Namespace vehicle_occupancy
// Params 4, eflags: 0x4
// Checksum 0x9fdf46a2, Offset: 0x53b9
// Size: 0x7f
function private show_weapon( vehicle, oldseatid, player, data )
{
    if ( !data.playerdeath )
    {
        should_hide_weapon = function_62a140633e1ef9a1( vehicle, oldseatid, player );
        
        if ( should_hide_weapon )
        {
            if ( should_hide_weapon.stowed )
            {
                player vehicle_setstowedweaponvisibility( 1 );
            }
            
            if ( should_hide_weapon.held )
            {
                player vehicle_setheldweaponvisibility( 1 );
            }
        }
    }
}

// Namespace vehicle_occupancy
// Params 4, eflags: 0x4
// Checksum 0xb8c2cc2, Offset: 0x5440
// Size: 0x52
function private hide_helmet( vehicle, oldseatid, player, data )
{
    if ( function_38b442de2b872386( vehicle, oldseatid, player ) && player tagexists( "j_helmet_hide" ) )
    {
        player hidepart( "j_helmet_hide", undefined, 1 );
    }
}

// Namespace vehicle_occupancy
// Params 4, eflags: 0x4
// Checksum 0x2213be10, Offset: 0x549a
// Size: 0x52
function private show_helmet( vehicle, oldseatid, player, data )
{
    if ( function_38b442de2b872386( vehicle, oldseatid, player ) && player tagexists( "j_helmet_hide" ) )
    {
        player showpart( "j_helmet_hide", undefined, 1 );
    }
}

// Namespace vehicle_occupancy
// Params 3, eflags: 0x4
// Checksum 0xb3d04289, Offset: 0x54f4
// Size: 0x5c, Type: bool
function private function_38b442de2b872386( vehicle, seatid, player )
{
    leveldataforvehicle = get_data( vehicle vehicle::get_ref() );
    leveldataforseat = leveldataforvehicle.seatdata[ seatid ];
    return istrue( leveldataforseat.hidehelmet );
}

// Namespace vehicle_occupancy
// Params 5, eflags: 0x4
// Checksum 0xf141810, Offset: 0x5559
// Size: 0x6c
function private function_50ef45c679199e96( vehicle, seatid, oldseatid, player, data )
{
    camera = function_9cd7c58917a9d908( vehicle, seatid );
    
    if ( camera )
    {
        oldcamera = function_9cd7c58917a9d908( vehicle, oldseatid );
        
        if ( oldcamera != camera )
        {
            player cameraset( camera );
        }
    }
}

// Namespace vehicle_occupancy
// Params 4, eflags: 0x4
// Checksum 0xb2c9215, Offset: 0x55cd
// Size: 0x59
function private function_ba3b1c53755cfe51( vehicle, newseatid, player, data )
{
    if ( isdefined( newseatid ) )
    {
        camera = function_9cd7c58917a9d908( vehicle, newseatid );
        
        if ( !camera )
        {
            player cameradefault();
        }
        
        return;
    }
    
    player cameradefault();
}

// Namespace vehicle_occupancy
// Params 4, eflags: 0x4
// Checksum 0x9fe27584, Offset: 0x562e
// Size: 0x99
function private function_24f5de0e1ca83fe4( vehicle, newseatid, player, data )
{
    damagemodifier = function_cc13ecc8b4a9824e( vehicle, newseatid );
    
    if ( isdefined( damagemodifier ) && damagemodifier != -1 )
    {
        player utility::callsharedfunc( #"damage", #"adddamagemodifier", isxhashasset( vehicle vehicle::get_ref() ) ? hashcat( vehicle vehicle::get_ref(), newseatid ) : vehicle vehicle::get_ref() + newseatid, damagemodifier, 0, &function_daa30c6b6a3a6fd7 );
    }
}

// Namespace vehicle_occupancy
// Params 4, eflags: 0x4
// Checksum 0x524cf9f1, Offset: 0x56cf
// Size: 0xa1
function private function_d817e42472ea2fc7( vehicle, oldseatid, player, data )
{
    if ( !data.playerdeath )
    {
        damagemodifier = function_cc13ecc8b4a9824e( vehicle, oldseatid );
        
        if ( isdefined( damagemodifier ) && damagemodifier != -1 )
        {
            player utility::callsharedfunc( #"damage", #"removedamagemodifier", isxhashasset( vehicle vehicle::get_ref() ) ? hashcat( vehicle vehicle::get_ref(), oldseatid ) : vehicle vehicle::get_ref() + oldseatid, 0 );
        }
    }
}

// Namespace vehicle_occupancy
// Params 2, eflags: 0x4
// Checksum 0x8614bbe5, Offset: 0x5778
// Size: 0xe1
function private function_3774683642a3268( vehicle, seatid )
{
    leveldataforvehicle = get_data( vehicle vehicle::get_ref() );
    leveldataforseat = leveldataforvehicle.seatdata[ seatid ];
    restrictions = arraycopy( leveldataforseat.restrictions ?? leveldataforvehicle.restrictions );
    
    if ( leveldataforvehicle.canleanout )
    {
        if ( !vehicle vehicle_damage::is_door_alive( seatid ) )
        {
            restrictions[ restrictions.size ] = "vehicle_lean_out";
        }
        
        if ( !leveldataforseat.allowmelee )
        {
            restrictions = arraycombineunique( restrictions, [ "melee" ] );
        }
    }
    
    if ( vehicle function_e20754e93d144ee3() && function_e27ae9e6770588e8( vehicle vehicle::get_ref(), seatid ) )
    {
        restrictions[ restrictions.size ] = "fire";
    }
    
    return restrictions;
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0xe5f9f1a4, Offset: 0x5862
// Size: 0x73
function function_b2d43c8350835934( vehicle, seatid )
{
    leveldataforvehicle = get_data( vehicle vehicle::get_ref() );
    leveldataforseat = leveldataforvehicle.seatdata[ seatid ];
    
    if ( isdefined( leveldataforseat.hideoccupant ) )
    {
        return istrue( leveldataforseat.hideoccupant );
    }
    
    return istrue( leveldataforvehicle.hideoccupant );
}

// Namespace vehicle_occupancy
// Params 3, eflags: 0x4
// Checksum 0x49b43c21, Offset: 0x58dd
// Size: 0xac
function private function_62a140633e1ef9a1( vehicle, seatid, player )
{
    leveldataforvehicle = get_data( vehicle vehicle::get_ref() );
    leveldataforseat = leveldataforvehicle.seatdata[ seatid ];
    
    if ( player isvehicleactive() && !player isremotecontrolling() && ( leveldataforseat.hidestowedweapon || leveldataforseat.hideheldweapon ) )
    {
        return { #held:leveldataforseat.hideheldweapon, #stowed:leveldataforseat.hidestowedweapon };
    }
}

// Namespace vehicle_occupancy
// Params 2, eflags: 0x4
// Checksum 0xb86a2a6e, Offset: 0x5991
// Size: 0xc2
function private function_9cd7c58917a9d908( vehicle, seatid )
{
    leveldataforvehicle = get_data( vehicle vehicle::get_ref() );
    
    if ( isdefined( seatid ) )
    {
        leveldataforseat = leveldataforvehicle.seatdata[ seatid ];
        camera = leveldataforvehicle.camera;
        
        if ( isdefined( leveldataforseat.camera ) )
        {
            camera = leveldataforseat.camera;
        }
        
        if ( isdefined( leveldataforseat.animtag ) && ( leveldataforseat.animtag == "tag_seat_0" || leveldataforseat.animtag == "offset_seat_0" ) )
        {
            camera = undefined;
        }
    }
    else
    {
        camera = undefined;
    }
    
    return camera;
}

// Namespace vehicle_occupancy
// Params 2, eflags: 0x4
// Checksum 0x63a465ef, Offset: 0x5a5c
// Size: 0x60, Type: bool
function private function_cc13ecc8b4a9824e( vehicle, seatid )
{
    leveldataforvehicle = get_data( vehicle vehicle::get_ref() );
    leveldataforseat = leveldataforvehicle.seatdata[ seatid ];
    return leveldataforseat.damagemodifier ?? leveldataforvehicle.damagemodifier;
}

// Namespace vehicle_occupancy
// Params 7, eflags: 0x4
// Checksum 0xe0b6f97d, Offset: 0x5ac5
// Size: 0xae, Type: bool
function private function_daa30c6b6a3a6fd7( inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc )
{
    if ( meansofdeath == "MOD_TRIGGER_HURT" )
    {
        return true;
    }
    
    if ( isdefined( objweapon ) && objweapon.basename == "bomb_site_mp" )
    {
        return true;
    }
    
    if ( utility::issharedfuncdefined( #"damage", #"isstuckdamage" ) && victim utility::callsharedfunc( #"damage", #"isstuckdamage", inflictor, meansofdeath ) )
    {
        return true;
    }
    
    return false;
}

// Namespace vehicle_occupancy
// Params 2, eflags: 0x4
// Checksum 0x834e8c91, Offset: 0x5b7c
// Size: 0x118
function private function_2f7211392db5a9ac( vehicle, player )
{
    vehicleoobtriggers = vehicle.oobtriggers;
    playeroobtriggers = player.oobtriggers;
    
    if ( !isdefined( vehicleoobtriggers ) )
    {
        return;
    }
    
    foreach ( vehicletrigger in vehicleoobtriggers )
    {
        refreshoob = 1;
        
        if ( isdefined( playeroobtriggers ) && playeroobtriggers.size > 0 )
        {
            refreshoob = !arraycontains( playeroobtriggers, vehicletrigger );
        }
        
        if ( refreshoob )
        {
            if ( utility::issharedfuncdefined( #"game", #"onenteroobtrigger" ) )
            {
                [[ utility::getsharedfunc( #"game", #"onenteroobtrigger" ) ]]( vehicletrigger, player, 1 );
            }
            
            break;
        }
    }
}

// Namespace vehicle_occupancy
// Params 3, eflags: 0x4
// Checksum 0xd870b78a, Offset: 0x5c9c
// Size: 0x63
function private monitor_occupant( vehicle, player, seatid )
{
    thread monitor_controls( vehicle, player, seatid );
    
    if ( !level.var_3a28db61277e7016 )
    {
        thread monitor_seat_switch( vehicle, player, seatid, 1 );
        thread monitor_exit( vehicle, player, seatid );
    }
    
    thread monitor_game_ended( vehicle, player, seatid );
    thread function_3cb5e70d950d5fee( vehicle, player );
}

// Namespace vehicle_occupancy
// Params 1, eflags: 0x4
// Checksum 0xcf7c245b, Offset: 0x5d07
// Size: 0x4d
function private stop_monitoring_occupant( player )
{
    player notify( #"vehicle_occupancy_monitorcontrols" );
    player notify( #"vehicle_occupancy_monitorseatswitch" );
    player notify( #"vehicle_occupancy_monitorexit" );
    player notify( #"vehicle_occupancy_monitorgameended" );
    player notify( #"vehicle_occupancy_monitorleanblocked" );
}

// Namespace vehicle_occupancy
// Params 2, eflags: 0x4
// Checksum 0x83076d44, Offset: 0x5d5c
// Size: 0xa5
function private function_3cb5e70d950d5fee( vehicle, player )
{
    player notify( #"vehicle_occupancy_monitorleanblocked" );
    player endon( #"vehicle_occupancy_monitorleanblocked" );
    player endon( #"death_or_disconnect" );
    player endon( #"last_stand_enter" );
    
    while ( true )
    {
        player utility::waittill_any( "vehicle_leanout_attempt_denied", "vehicle_leanout_forced_return" );
        
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            player [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"vehicles/lean_out_blocked" );
        }
    }
}

// Namespace vehicle_occupancy
// Params 4, eflags: 0x4
// Checksum 0x35c515e2, Offset: 0x5e09
// Size: 0x205
function private monitor_seat_switch( vehicle, player, seatid, applydelay )
{
    if ( getdvarint( @"hash_13b2e4ab3d17e938", 0 ) != 0 )
    {
        return;
    }
    
    if ( vehicle.var_9b6d5e24d8eed7c4 )
    {
        return;
    }
    
    player endon( #"death_or_disconnect" );
    player endon( #"last_stand_enter" );
    vehicle endon( #"death" );
    level endon( #"game_ended" );
    player notify( #"vehicle_occupancy_monitorseatswitch" );
    player endon( #"vehicle_occupancy_monitorseatswitch" );
    leveldataforvehicle = get_data( vehicle vehicle::get_ref() );
    
    if ( leveldataforvehicle.seatdata.size <= 1 )
    {
        return;
    }
    
    leveldataforseat = function_568cd324ac705619( vehicle vehicle::get_ref(), seatid );
    
    if ( !isdefined( leveldataforseat.seatswitcharray ) || leveldataforseat.seatswitcharray.size <= 0 )
    {
        return;
    }
    
    if ( applydelay )
    {
        wait 0.05;
    }
    
    while ( player vehswitchseatbuttonpressed() || player function_5f2f6ad7e7d5fb71() )
    {
        waitframe();
    }
    
    while ( !player vehswitchseatbuttonpressed() && !player function_5f2f6ad7e7d5fb71() || player.var_9b6d5e24d8eed7c4 )
    {
        waitframe();
    }
    
    if ( player function_5f2f6ad7e7d5fb71() )
    {
        switchseatid = function_7a83ea47b335b66a( vehicle, player, seatid );
    }
    else
    {
        switchseatid = function_79f80964bb18e6c6( vehicle, player, seatid );
    }
    
    seatblocked = 0;
    
    if ( getdvarint( @"hash_4f6e477f1f9079e0", 1 ) == 1 )
    {
        var_f45a7156d12fac37 = function_568cd324ac705619( vehicle vehicle::get_ref(), switchseatid );
        
        if ( var_f45a7156d12fac37.requireclearance )
        {
            if ( is_seat_blocked( vehicle, switchseatid, player ) )
            {
                seatblocked = 1;
                switchseatid = undefined;
            }
        }
    }
    
    if ( isdefined( switchseatid ) )
    {
        thread enter( vehicle, switchseatid, player );
    }
    
    error_message( player, seatblocked ? 4 : 1 );
    thread monitor_seat_switch( vehicle, player, seatid, 0 );
}

// Namespace vehicle_occupancy
// Params 1, eflags: 0x4
// Checksum 0x78d359bb, Offset: 0x6016
// Size: 0x467
function private monitor_empty_occupied_vehicle_bug( vehicle )
{
    vehicle notify( #"hash_a307c57b7aa06173" );
    vehicle endon( #"hash_a307c57b7aa06173" );
    
    if ( getdvarint( @"scr_monitor_empty_occupied_vehicle_bug", isbrgamemode() ) == 0 )
    {
        return;
    }
    
    vehicle endon( #"death" );
    waittime = 1;
    countthreshold = getdvarint( @"hash_1bee924c22d86b70", 60 );
    counter = 0;
    
    while ( true )
    {
        speed = vehicle vehicle_getspeed();
        
        if ( speed == 0 && vehicle.teamfriendlyto )
        {
            if ( counter >= countthreshold )
            {
                assertmsg( "<dev string:x8df>" );
                occupancystring = "";
                separator = "";
                occupancystring += "Vehicle Name: " + vehicle.vehiclename;
                occupancystring += ", Entity Num: " + vehicle getentitynumber();
                occupancystring += ", Occupancy Count: " + vehicle.occupants.size;
                occupancystring += ", Turret Occupancy Count: " + vehicle.turretoccupants.size;
                occupancystring += ", Reserving Occupancy Count: " + vehicle.occupantsreserving.size;
                occupancystring += ", Riding Occupancy Count: " + vehicle.ridingplayers.size;
                occupancystring += ", Team ID: " + vehicle.team;
                occupancystring += ", Team Friendly To: " + vehicle.teamfriendlyto;
                occupancystring += ", Vehicle Origin: " + vehicle.origin;
                occupancystring += ", Is Destroyed: " + vehicle.isdestroyed;
                occupancystring += ", Owner Name: " + vehicle.owner.name;
                occupancystring += ", Last Owner Name: " + vehicle.lastowner.name;
                occupancystring += ", Marks Enabled: " + vehicle.marksenabled;
                occupants = arraycombineunique( vehicle.occupants, vehicle.turretoccupants, vehicle.occupantsreserving, vehicle.ridingplayers );
                occupancystring += ", Occupancy info [";
                
                foreach ( occupant in occupants )
                {
                    seatid = function_f02c63b99c9614c9( vehicle.occupants, occupant );
                    occupancystring += separator + "Seat ID: " + seatid;
                    
                    if ( occupant )
                    {
                        inoccupants = arraycontains( vehicle.occupants, occupant );
                        inturret = vehicle.turretoccupants ? arraycontains( vehicle.turretoccupants, occupant ) : 0;
                        inreserving = arraycontains( vehicle.occupantsreserving, occupant );
                        inriding = vehicle.ridingplayers ? arraycontains( vehicle.ridingplayers, occupant ) : 0;
                        isgamepad = occupant usinggamepad();
                        var_be64afbf6555b72f = occupant getuseholdkbmprofile();
                        usereloadconfig = occupant getcurrentusereloadconfig();
                        occupancystring += ", Occupant Info: (Name: " + occupant.name + ", Origin: " + occupant.origin + ", Gamepad: " + isgamepad + ", kbmHold: " + var_be64afbf6555b72f + ", Use Reload Config: " + usereloadconfig + ", In Occupants: " + inoccupants + ", In Turret: " + inturret + ", In Reserving: " + inreserving + ", In Riding: " + inriding + ", Team: " + occupant.team + ")";
                    }
                    else
                    {
                        occupancystring += ", Occupant: Undefined";
                    }
                    
                    separator = ", ";
                }
                
                occupancystring += "]";
                logstring( "monitor_empty_occupied_vehicle_bug - " + occupancystring );
                break;
            }
            
            counter++;
        }
        else
        {
            counter = 0;
        }
        
        wait waittime;
    }
}

// Namespace vehicle_occupancy
// Params 3
// Checksum 0xe09606e1, Offset: 0x6485
// Size: 0xdd
function function_79f80964bb18e6c6( vehicle, player, seatid )
{
    leveldataforseat = function_568cd324ac705619( vehicle vehicle::get_ref(), seatid );
    
    if ( !isdefined( leveldataforseat.seatswitcharray ) || leveldataforseat.seatswitcharray.size <= 0 )
    {
        return;
    }
    
    foreach ( switchseatid in leveldataforseat.seatswitcharray )
    {
        if ( is_seat_available( vehicle, switchseatid, player ) )
        {
            return switchseatid;
        }
    }
}

// Namespace vehicle_occupancy
// Params 3
// Checksum 0xa3350447, Offset: 0x656b
// Size: 0xeb
function function_7a83ea47b335b66a( vehicle, player, seatid )
{
    leveldataforseat = function_568cd324ac705619( vehicle vehicle::get_ref(), seatid );
    
    if ( !isdefined( leveldataforseat.seatswitcharray ) || leveldataforseat.seatswitcharray.size <= 0 )
    {
        return;
    }
    
    prevseatid = undefined;
    
    foreach ( switchseatid in leveldataforseat.seatswitcharray )
    {
        if ( is_seat_available( vehicle, switchseatid, player ) )
        {
            prevseatid = switchseatid;
        }
    }
    
    return prevseatid;
}

// Namespace vehicle_occupancy
// Params 3, eflags: 0x4
// Checksum 0x9a465cf, Offset: 0x665f
// Size: 0x100
function private monitor_exit( vehicle, player, seatid )
{
    player notify( #"vehicle_occupancy_monitorexit" );
    player endon( #"vehicle_occupancy_monitorexit" );
    vehicle endon( #"death" );
    level endon( #"game_ended" );
    specialexit = monitor_exit_internal( vehicle, player, seatid );
    data = spawnstruct();
    
    if ( isdefined( player ) )
    {
        if ( !player utility::callsharedfunc( #"player", #"playerisalive" ) )
        {
            data.playerdeath = 1;
        }
        
        if ( player.inlaststand )
        {
            data.playerlaststand = 1;
        }
        
        if ( player.liveragdoll )
        {
            data.playerliveragdoll = 1;
        }
    }
    else
    {
        data.playerdisconnect = 1;
    }
    
    thread exit( vehicle, seatid, player, data, undefined, specialexit );
}

// Namespace vehicle_occupancy
// Params 1
// Checksum 0x7097bfaa, Offset: 0x6767
// Size: 0x5c
function function_694c2792588bc5dc( player )
{
    player endon( #"death_or_disconnect" );
    player endon( #"enter_live_ragdoll" );
    player endon( #"vehicle_occupancy_monitorexit" );
    player waittill( #"live_ragdoll_vehicle_occupant_unlink" );
    player.var_6bb95d5c412d3e98 = 1;
    player notify( #"vehicle_occupant_unlink_processed" );
}

// Namespace vehicle_occupancy
// Params 3
// Checksum 0xcafa8b60, Offset: 0x67cb
// Size: 0x5a3
function monitor_exit_internal( vehicle, player, seatid )
{
    player endon( #"death_or_disconnect" );
    player endon( #"last_stand_enter" );
    player endon( #"enter_live_ragdoll" );
    player endon( #"vehicle_occupant_unlink_processed" );
    thread function_694c2792588bc5dc( player );
    endtime = gettime() + 50;
    buttonreleased = 0;
    data = get_data( vehicle vehicle::get_ref() );
    roofexittype = undefined;
    
    if ( isdefined( data ) )
    {
        roofexittype = data.roofexittype;
    }
    
    canstandup = level.var_e445b76f87f11639 && isdefined( roofexittype ) && roofexittype == "stand_up";
    var_b50a7b057ec0e3ae = istrue( level.var_9e85fa55dfcb5605 );
    var_10cfb99222d2ee13 = utility::callsharedfunc( #"game", #"getmatchrulesdata", "commonOption", "vehicleDiveOutMinSpeed" ) ?? 10;
    player setclientomnvar( "ui_veh_exit_button_holdtime", 0 );
    leveldataforseat = function_568cd324ac705619( vehicle vehicle::get_ref(), seatid );
    var_da8576f70fc157dd = istrue( leveldataforseat.var_da8576f70fc157dd );
    
    if ( var_da8576f70fc157dd )
    {
        endtime = gettime() + 300;
    }
    
    while ( true )
    {
        if ( !player usebuttonpressed( 1 ) )
        {
            buttonreleased = 1;
        }
        
        if ( buttonreleased && gettime() >= endtime )
        {
            break;
        }
        
        waitframe();
    }
    
    updaterate = level.framedurationseconds;
    var_5190ffaf44fe09df = getdvarint( @"hash_9402582f8123db99", 250 ) / 1000;
    var_cc140c1f8e2ef223 = 0;
    var_323aded6861c3f09 = undefined;
    
    while ( true )
    {
        timeused = 0;
        var_2095e9afbe27fa21 = 0;
        reloadstarted = 0;
        player setclientomnvar( "ui_veh_exit_button_holdtime", 0 );
        requiresleanout = getdvarint( @"hash_3f21db7c43ceecb9", 1 );
        
        if ( !player isreloading() )
        {
            player val::set( "veh_occupancy_reload", "reload", 0 );
        }
        
        if ( !player isreloading() && !function_a029c377aa2a0c46( vehicle, player ) && player reloadbuttonpressed() && !player usebuttonpressed( 1 ) )
        {
            player val::reset( "veh_occupancy_reload", "reload" );
            player forcereloading();
            reloadstarted = 1;
        }
        
        if ( !requiresleanout )
        {
            var_866dd2a10554f712 = min( getdvarfloat( @"hash_e240d0849c0c892" ), getdvarfloat( @"hash_f67753f018a1115b" ) );
            var_10cfb99222d2ee13 = min( var_10cfb99222d2ee13, var_866dd2a10554f712 );
        }
        
        while ( player usebuttonpressed( 1 ) )
        {
            var_2095e9afbe27fa21 = 1;
            timeused += updaterate;
            activatepressed = player activatekeypressed( 1 );
            isgamepad = player usinggamepad();
            var_6897df6bb7a98f72 = player getuseholdkbmprofile();
            var_dc4fbbf513a64e3a = !isgamepad && !var_6897df6bb7a98f72;
            info = weapon::function_e418c15787e60727( player, 1, function_a029c377aa2a0c46( vehicle, player ), function_ec25b7cd78651ae5( vehicle ) );
            var_3fa2c72430d1b472 = info.var_17a7b9ae2a4d76d5;
            var_49a0d90abcf5bc24 = info.var_54453e630bc1ba7d;
            var_aa6e765352034cea = info.var_ccdc123013cfa167;
            var_8942c9b26785365c = info.var_d9982fb23eaa73df;
            
            if ( !var_3fa2c72430d1b472 )
            {
                player setclientomnvar( "ui_veh_exit_button_holdtime", timeused / 0.3 );
            }
            
            if ( !player val::get( "vehicle_exit" ) )
            {
                wait updaterate;
                continue;
            }
            
            if ( var_49a0d90abcf5bc24 && timeused > 0.3 || var_dc4fbbf513a64e3a || var_da8576f70fc157dd )
            {
                player val::set( "veh_occupancy_reload", "reload", 0 );
                player cancelreloading();
                leanoutcheck = !requiresleanout || player isinvehicleleanout();
                return ( var_b50a7b057ec0e3ae && leanoutcheck && vehicle vehicle_getspeed() > var_10cfb99222d2ee13 ? "_to_dive" : undefined );
            }
            else if ( !reloadstarted && !activatepressed && var_8942c9b26785365c && timeused >= var_5190ffaf44fe09df )
            {
                player val::reset( "veh_occupancy_reload", "reload" );
                player forcereloading();
                reloadstarted = 1;
            }
            
            wait updaterate;
        }
        
        if ( !player val::get( "vehicle_exit" ) )
        {
            waitframe();
            continue;
        }
        
        if ( var_2095e9afbe27fa21 && var_3fa2c72430d1b472 && timeused < var_5190ffaf44fe09df )
        {
            player val::set( "veh_occupancy_reload", "reload", 0 );
            player cancelreloading();
            leanoutcheck = !requiresleanout || player isinvehicleleanout();
            return ( var_b50a7b057ec0e3ae && leanoutcheck && vehicle vehicle_getspeed() > var_10cfb99222d2ee13 ? "_to_dive" : undefined );
        }
        else if ( !reloadstarted && !activatepressed && var_2095e9afbe27fa21 && var_aa6e765352034cea )
        {
            player val::reset( "veh_occupancy_reload", "reload" );
            player forcereloading();
        }
        
        if ( player function_cab040fe4549a850() )
        {
            return;
        }
        
        if ( player is_roof_exit_enabled( roofexittype ) )
        {
            var_cc140c1f8e2ef223 |= player jumpbuttonpressed();
            
            if ( player jumpbuttonpressed() )
            {
                var_323aded6861c3f09 = gettime();
            }
            else if ( var_cc140c1f8e2ef223 && isdefined( var_323aded6861c3f09 ) && var_323aded6861c3f09 + 400 < gettime() )
            {
                var_cc140c1f8e2ef223 = 0;
            }
            
            if ( var_cc140c1f8e2ef223 && !player function_325682e4dddac927() && ( player function_669a2f1799f2fa7b() || canstandup ) )
            {
                return "_to_roof";
            }
        }
        
        waitframe();
    }
}

// Namespace vehicle_occupancy
// Params 1, eflags: 0x4
// Checksum 0x96fb0bd4, Offset: 0x6d76
// Size: 0x31, Type: bool
function private is_roof_exit_enabled( roofexittype )
{
    return level.var_e445b76f87f11639 && isdefined( roofexittype ) && ( roofexittype == "stand_up" || self function_669a2f1799f2fa7b() );
}

// Namespace vehicle_occupancy
// Params 2, eflags: 0x4
// Checksum 0xc9ed700d, Offset: 0x6db0
// Size: 0xc1
function private error_message( player, errorref )
{
    errorstr = undefined;
    
    switch ( errorref )
    {
        case 1:
            errorstr = %"vehicles/seat_switch_occupied";
            break;
        case 2:
            errorstr = %"vehicles/cannot_exit";
            break;
        case 5:
            errorstr = %"VEHICLES/CANNOT_ROOF_EXIT";
            break;
        case 4:
            errorstr = %"VEHICLES/SEAT_SWITCH_BLOCKED";
            break;
    }
    
    assert( isdefined( errorstr ), "<dev string:x937>" );
    player utility::callsharedfunc( #"hud", #"showerrormessage", errorstr );
}

// Namespace vehicle_occupancy
// Params 3, eflags: 0x4
// Checksum 0xf94b2b84, Offset: 0x6e79
// Size: 0x75
function private monitor_game_ended( vehicle, player, seatid )
{
    player endon( #"death_or_disconnect" );
    player endon( #"last_stand_enter" );
    player notify( #"vehicle_occupancy_monitorgameended" );
    player endon( #"vehicle_occupancy_monitorgameended" );
    
    if ( seatid == get_driver_seat( vehicle ) )
    {
        level waittill( #"game_ended" );
        player allowmovement( 0 );
    }
}

// Namespace vehicle_occupancy
// Params 3, eflags: 0x4
// Checksum 0xf0038eb0, Offset: 0x6ef6
// Size: 0xd8
function private monitor_controls( vehicle, player, seatid )
{
    player endon( #"death_or_disconnect" );
    player endon( #"last_stand_enter" );
    vehicle endon( #"death" );
    level endon( #"game_ended" );
    player notify( #"vehicle_occupancy_monitorcontrols" );
    player endon( #"vehicle_occupancy_monitorcontrols" );
    
    if ( vehicle_omnvar::function_3a46307fb9c3a02( player ) )
    {
        return;
    }
    
    if ( true )
    {
        wait 1.5;
    }
    
    childthread function_62515deeb9d6335b( vehicle, player, seatid );
    childthread function_6b3a50cea153bb4e( vehicle, player, seatid );
    leveldataforvehicle = get_data( vehicle vehicle::get_ref() );
    
    if ( isdefined( leveldataforvehicle.monitorcontrolscallback ) )
    {
        childthread [[ leveldataforvehicle.monitorcontrolscallback ]]( vehicle, player, seatid, "vehicle_occupancy_monitorControls" );
    }
}

// Namespace vehicle_occupancy
// Params 1
// Checksum 0x4ff943d8, Offset: 0x6fd6
// Size: 0x22
function fade_out_controls( player )
{
    vehicle_omnvar::fade_out_controls( player );
    player notify( #"vehicle_occupancy_monitorcontrols" );
}

// Namespace vehicle_occupancy
// Params 3, eflags: 0x4
// Checksum 0x33668bee, Offset: 0x7000
// Size: 0x118
function private function_62515deeb9d6335b( vehicle, player, seatid )
{
    driverseatid = get_driver_seat( vehicle );
    
    if ( seatid == driverseatid )
    {
        canfly = vehicle vehicle::can_fly();
        
        if ( canfly )
        {
            while ( true )
            {
                forward = vehicle vehicle_getinputvalue( 0 );
                turn = vehicle vehicle_getinputvalue( 2 );
                strafe = vehicle vehicle_getinputvalue( 1 );
                ascend = vehicle vehicle_getinputvalue( 3 );
                
                if ( abs( forward ) > 0 || abs( turn ) > 0 || abs( strafe ) > 0 || abs( ascend ) > 0 )
                {
                    fade_out_controls( player );
                }
                
                wait 0.05;
            }
            
            return;
        }
        
        while ( true )
        {
            gasinput = vehicle vehicle_getinputvalue( 4 );
            
            if ( abs( gasinput ) >= 0.2 )
            {
                fade_out_controls( player );
            }
            
            wait 0.05;
        }
    }
}

// Namespace vehicle_occupancy
// Params 3, eflags: 0x4
// Checksum 0xc1dc58e, Offset: 0x7120
// Size: 0x88
function private function_6b3a50cea153bb4e( vehicle, player, seatid )
{
    leveldataforseat = function_568cd324ac705619( vehicle vehicle::get_ref(), seatid );
    
    if ( isdefined( leveldataforseat.turretobjweapon ) )
    {
        turret = vehicle::function_95e3c2e0c6eec800( vehicle, leveldataforseat.turretobjweapon );
        
        if ( isdefined( turret ) )
        {
            turret utility::waittill_any( "turret_fire", "turret_reload" );
            fade_out_controls( player );
        }
    }
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0xd6713b7a, Offset: 0x71b0
// Size: 0xaa
function function_921d1edcf33652ee( vehicleref, seatid )
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
    
    return function_568cd324ac705619( vehicleref, seatid ).turretobjweapon;
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0xe078f352, Offset: 0x7263
// Size: 0xaa
function function_c1aff67bba66f89f( vehicleref, seatid )
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
    
    return function_568cd324ac705619( vehicleref, seatid ).turretweapon;
}

// Namespace vehicle_occupancy
// Params 1
// Checksum 0x8d7c5f5d, Offset: 0x7316
// Size: 0x41
function function_ec25b7cd78651ae5( vehicle )
{
    driverturret = function_c1aff67bba66f89f( vehicle vehicle::get_ref(), "driver" );
    return driverturret ? vehicle function_4a982264b67c1076() == weaponclipsize( driverturret ) : undefined;
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0x9abb61f5, Offset: 0x7360
// Size: 0x55, Type: bool
function function_a029c377aa2a0c46( vehicle, player )
{
    driverturret = function_c1aff67bba66f89f( vehicle vehicle::get_ref(), "driver" );
    currentseat = get_occupant_seat( vehicle, player );
    return currentseat == "driver" && driverturret;
}

// Namespace vehicle_occupancy
// Params 2, eflags: 0x4
// Checksum 0x926f6b78, Offset: 0x73be
// Size: 0xc8
function private function_301751a8d62a4337( player, data )
{
    data endon( data.raceendon );
    result = player utility::waittill_any_return_no_endon_death( "death", "disconnect", "enter_live_ragdoll", "last_stand_enter" );
    
    if ( result == "death" )
    {
        data.playerdeath = 1;
    }
    else if ( result == "disconnect" )
    {
        data.playerdisconnect = 1;
    }
    else if ( result == "enter_live_ragdoll" )
    {
        data.playerliveragdoll = 1;
    }
    else if ( result == "last_stand_enter" )
    {
        data.playerlaststand = 1;
    }
    
    data notify( data.raceendnotify );
}

// Namespace vehicle_occupancy
// Params 2, eflags: 0x4
// Checksum 0xac2660c0, Offset: 0x748e
// Size: 0x4f
function private race_vehicle_death( vehicle, data )
{
    data endon( data.raceendon );
    vehicle waittill( #"death" );
    data.vehicledeath = 1;
    data notify( data.raceendnotify );
}

// Namespace vehicle_occupancy
// Params 5, eflags: 0x4
// Checksum 0x1838628b, Offset: 0x74e5
// Size: 0x77
function private function_4f363a218b64862c( vehicle, player, seatid, oldseatid, data )
{
    data endon( data.raceendon );
    
    while ( isdefined( vehicle ) )
    {
        if ( !is_seat_available( vehicle, seatid, player ) )
        {
            data.seatunavailable = 1;
            data notify( data.raceendnotify );
            break;
        }
        
        waitframe();
    }
}

// Namespace vehicle_occupancy
// Params 3, eflags: 0x4
// Checksum 0x541145ad, Offset: 0x7564
// Size: 0x9d
function private race_complete( oldseatid, newseatid, data )
{
    data endon( data.raceendon );
    
    if ( isdefined( oldseatid ) && isdefined( newseatid ) )
    {
        while ( !data.enterstartcomplete || !data.exitstartcomplete )
        {
            waitframe();
        }
    }
    else if ( isdefined( oldseatid ) )
    {
        while ( !data.exitstartcomplete )
        {
            waitframe();
        }
    }
    else
    {
        while ( !data.enterstartcomplete )
        {
            waitframe();
        }
    }
    
    data notify( data.raceendnotify );
}

// Namespace vehicle_occupancy
// Params 5, eflags: 0x4
// Checksum 0xc5d0316b, Offset: 0x7609
// Size: 0x1e1
function private race_results( vehicle, player, oldseatid, newseatid, data )
{
    if ( !isdefined( data.success ) )
    {
        data.success = 1;
    }
    
    if ( data.immediate )
    {
        data.playerdisconnect = isdefined( player ) ? 0 : 1;
        
        if ( !data.playerdisconnect )
        {
            data.playerdeath = !player utility::callsharedfunc( #"player", #"playerisalive" );
            data.playerlaststand = istrue( player.inlaststand );
            data.playerliveragdoll = istrue( player.liveragdoll );
        }
        
        data.vehicledeath = istrue( vehicle.isdestroyed );
    }
    else if ( data.success )
    {
        if ( isdefined( oldseatid ) && !data.exitstartcomplete )
        {
            data.success = 0;
        }
        
        if ( isdefined( newseatid ) && !data.enterstartcomplete )
        {
            data.success = 0;
        }
        
        if ( data.vehicledeath )
        {
            data.success = 0;
        }
    }
    else
    {
        return 0;
    }
    
    if ( isdefined( newseatid ) )
    {
        if ( data.playerdeath || data.playerliveragdoll || data.playerlaststand || data.playerdisconnect || data.vehicledeath || data.seatunavailable )
        {
            data.success = 0;
        }
    }
    
    return data.success;
}

// Namespace vehicle_occupancy
// Params 4, eflags: 0x4
// Checksum 0x1de4d0cb, Offset: 0x77f3
// Size: 0x84
function private watch_owner( vehicle, player, var_f7e4f61d9c42bc80, timeroverride )
{
    player endon( #"disconnect" );
    vehicle endon( #"death" );
    vehicle endon( "vehicle_clear_owner_" + player getentitynumber() );
    
    if ( var_f7e4f61d9c42bc80 )
    {
        player waittill( #"vehicle_seat_exit" );
    }
    
    var_3d7e80fdea60f1c = timeroverride ?? 20;
    wait var_3d7e80fdea60f1c;
    thread clear_owner( vehicle, player );
}

// Namespace vehicle_occupancy
// Params 2, eflags: 0x4
// Checksum 0xe0317827, Offset: 0x787f
// Size: 0x58
function private watch_owner_joined_team( vehicle, player )
{
    player endon( #"disconnect" );
    vehicle endon( #"death" );
    vehicle endon( #"vehicle_owner_update" );
    player utility::waittill_any( "joined_team", "joined_spectators" );
    thread update_owner( vehicle );
}

// Namespace vehicle_occupancy
// Params 2, eflags: 0x4
// Checksum 0x14a30284, Offset: 0x78df
// Size: 0x92, Type: bool
function private is_player_valid_owner( vehicle, player )
{
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    if ( level.teambased && isdefined( vehicle.team ) )
    {
        if ( vehicle.team != "neutral" && player.team != vehicle.team )
        {
            return false;
        }
    }
    else if ( isdefined( vehicle.originalowner ) )
    {
        if ( player != vehicle.originalowner )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace vehicle_occupancy
// Params 3, eflags: 0x4
// Checksum 0x6732431f, Offset: 0x797a
// Size: 0x153
function private animate_player( vehicle, seatid, oldseatid )
{
    leveldataforseat = function_568cd324ac705619( vehicle vehicle::get_ref(), seatid );
    
    if ( !isdefined( leveldataforseat.animtag ) )
    {
        return;
    }
    
    self cancelmantle();
    enterseatindex = 0;
    seattag = leveldataforseat.animtag;
    
    if ( issubstr( seattag, "tag_seat_" ) )
    {
        enterseatindex = int( getsubstr( seattag, 9 ) );
    }
    else if ( issubstr( seattag, "offset_seat_" ) )
    {
        enterseatindex = int( getsubstr( seattag, 12 ) );
    }
    else if ( issubstr( seattag, "tag_gunner" ) )
    {
        enterseatindex = int( getsubstr( seattag, 10 ) ) + 10 - 1;
    }
    else if ( issubstr( seattag, "gunner_" ) )
    {
        enterseatindex = int( getsubstr( seattag, 7 ) ) + 10 - 1;
    }
    
    isexitvehicle = !isdefined( seatid );
    get_out( self, vehicle, isexitvehicle );
    isentervehicle = !isdefined( oldseatid ) && isdefined( seatid );
    isroofentrance = self usevehicle( vehicle, enterseatindex, isentervehicle );
    
    if ( isroofentrance && vehicle vehicle_damage::function_2b7271a5e9ac2ec6( seatid ) )
    {
        vehicle vehicle_damage::destroy_door_window( seatid );
    }
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0xe4e4ef6e, Offset: 0x7ad5
// Size: 0x2c
function function_961dfeea38feb976()
{
    if ( self.isheli && self getscriptablehaspart( "Exhaust" ) )
    {
        self setscriptablepartstate( "Exhaust", "off" );
    }
}

// Namespace vehicle_occupancy
// Params 0, eflags: 0x4
// Checksum 0x38ed0255, Offset: 0x7b09
// Size: 0xf0
function private function_8f5c8ba353b9ffe1()
{
    hasexhaust = self getscriptablehaspart( "Exhaust" );
    haslights = self getscriptablehaspart( "NaviLights" );
    
    if ( !hasexhaust && !haslights )
    {
        return;
    }
    
    self endon( #"death" );
    self notify( #"hash_5ae7313136274dc0" );
    self endon( #"hash_5ae7313136274dc0" );
    self.var_339900b9756c9bd = "waitingToTurnOff";
    wait 6;
    
    while ( self.ishovering )
    {
        wait 2;
    }
    
    if ( self.var_339900b9756c9bd != "waitingToTurnOff" )
    {
        return;
    }
    
    self.var_339900b9756c9bd = undefined;
    
    if ( hasexhaust && self getscriptablepartstate( "Exhaust" ) == "on" )
    {
        self setscriptablepartstate( "Exhaust", "off" );
    }
    
    if ( haslights && self getscriptablepartstate( "NaviLights" ) == "on" )
    {
        self setscriptablepartstate( "NaviLights", "off" );
    }
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0xc8ade501, Offset: 0x7c01
// Size: 0x86
function function_474d87fe62493d22()
{
    if ( !isdefined( self.var_339900b9756c9bd ) )
    {
        if ( self getscriptablehaspart( "Exhaust" ) && vehicle_damage::get_state() == "pristine" && ( !isdefined( self.fuel ) || self.fuel > 0 ) )
        {
            self setscriptablepartstate( "Exhaust", "on" );
        }
        
        if ( self getscriptablehaspart( "NaviLights" ) )
        {
            self setscriptablepartstate( "NaviLights", "on" );
        }
    }
    
    self.var_339900b9756c9bd = "playing";
}

// Namespace vehicle_occupancy
// Params 0, eflags: 0x4
// Checksum 0x6f68de69, Offset: 0x7c8f
// Size: 0x38
function private function_8881828632e5d04d()
{
    self endon( #"death" );
    self endon( #"unanchored" );
    
    while ( self vehicle_getspeed() > 2 )
    {
        wait 0.2;
    }
    
    self function_c21d39b1929f7cb1( -1, 100 );
}

// Namespace vehicle_occupancy
// Params 0, eflags: 0x4
// Checksum 0xccc10bfe, Offset: 0x7ccf
// Size: 0x15
function private function_9d1cf0e18cb109d3()
{
    self notify( #"unanchored" );
    self function_c21d39b1929f7cb1( 0 );
}

// Namespace vehicle_occupancy
// Params 1
// Checksum 0xfc317865, Offset: 0x7cec
// Size: 0x17d
function function_92ebe8fd4c9a3c7e( bool )
{
    if ( bool )
    {
        if ( self.firedisabled > 0 )
        {
            self.firedisabled--;
        }
        else
        {
            assertmsg( "<dev string:x977>" );
            return;
        }
        
        if ( self.firedisabled == 0 )
        {
            self.firedisabled = undefined;
            
            foreach ( occupant in function_f740a73aab507fd7() )
            {
                occupant val::set( "vehicle_occupant", "fire", 1 );
            }
        }
        
        return;
    }
    
    if ( !isdefined( self.firedisabled ) )
    {
        self.firedisabled = 0;
    }
    
    self.firedisabled++;
    
    if ( self.firedisabled == 1 )
    {
        foreach ( occupant in function_f740a73aab507fd7() )
        {
            occupant val::set( "vehicle_occupant", "fire", 0 );
        }
    }
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0x53ed8b85, Offset: 0x7e71
// Size: 0x13, Type: bool
function function_e20754e93d144ee3()
{
    return isdefined( self ) && self.firedisabled > 0;
}

// Namespace vehicle_occupancy
// Params 0, eflags: 0x4
// Checksum 0x7519c7ad, Offset: 0x7e8d
// Size: 0xbd
function private function_f740a73aab507fd7()
{
    vehicleref = vehicle::get_ref();
    var_fcac3ef374b208ba = [];
    
    foreach ( seatid in function_8a8e1601e7e6610( self ) )
    {
        if ( function_e27ae9e6770588e8( vehicleref, seatid ) )
        {
            occupant = get_seat_occupant( self, seatid, 0 );
            
            if ( isplayer( occupant ) )
            {
                var_fcac3ef374b208ba[ var_fcac3ef374b208ba.size ] = occupant;
            }
        }
    }
    
    return var_fcac3ef374b208ba;
}

// Namespace vehicle_occupancy
// Params 2, eflags: 0x4
// Checksum 0xee93691d, Offset: 0x7f53
// Size: 0x3c, Type: bool
function private function_e27ae9e6770588e8( vehicleref, seatid )
{
    seatdata = function_568cd324ac705619( vehicleref, seatid );
    return isdefined( seatdata ) && seatdata.hasvehicleweapon;
}

// Namespace vehicle_occupancy
// Params 0, eflags: 0x4
// Checksum 0xf5eb1347, Offset: 0x7f98
// Size: 0x16, Type: bool
function private function_a64cc2eb8cc3ca3a()
{
    return isdefined( self ) && self vehicle_isphysveh() && self vehphys_isgroundvehicle();
}

// Namespace vehicle_occupancy
// Params 4
// Checksum 0xdf416a4c, Offset: 0x7fb7
// Size: 0x2ec
function allow_movement( vehicle, bool, showwarning = 1, var_77b1341a42d85c2f )
{
    if ( vehicle vehicle::is_static() )
    {
        return 0;
    }
    
    if ( bool )
    {
        if ( vehicle.movementdisabled > 0 )
        {
            vehicle.movementdisabled--;
        }
        else
        {
            assertmsg( "<dev string:x9f6>" );
            return 1;
        }
        
        if ( vehicle.movementdisabled == 0 )
        {
            vehicle.movementdisabled = undefined;
            occupants = function_8ed9bcd8e9ea74f5( vehicle );
            
            if ( isdefined( occupants ) )
            {
                vehicle_omnvar::hide_warning( "movementDisabled", occupants, vehicle vehicle::get_ref() );
                
                if ( vehicle vehicle_isphysveh() )
                {
                    if ( vehicle hascomponent( "p2p" ) )
                    {
                        vehicle setconfigvalue( "p2p", "resume", 1 );
                    }
                    
                    if ( vehicle hascomponent( "path" ) )
                    {
                        vehicle setconfigvalue( "path", "resume", 1 );
                    }
                }
                
                if ( vehicle function_a64cc2eb8cc3ca3a() )
                {
                    vehicle function_92e333ef50ff2c83( 0 );
                }
                else
                {
                    foreach ( seatid, occupant in vehicle.occupants )
                    {
                        allow_movement_player( vehicle, occupant, 1, seatid );
                    }
                }
            }
            
            return 1;
        }
        
        return;
    }
    
    if ( !isdefined( vehicle.movementdisabled ) )
    {
        vehicle.movementdisabled = 0;
    }
    
    vehicle.movementdisabled++;
    
    if ( vehicle.movementdisabled == 1 )
    {
        occupants = function_8ed9bcd8e9ea74f5( vehicle );
        
        if ( isdefined( occupants ) )
        {
            if ( showwarning == 1 )
            {
                vehicle_omnvar::show_warning( "movementDisabled", occupants, vehicle vehicle::get_ref() );
            }
            
            if ( vehicle vehicle_isphysveh() )
            {
                if ( vehicle hascomponent( "p2p" ) && !var_77b1341a42d85c2f )
                {
                    vehicle setconfigvalue( "p2p", "pause", 1 );
                }
                
                if ( vehicle hascomponent( "path" ) )
                {
                    vehicle setconfigvalue( "path", "pause", 1 );
                }
            }
            
            if ( vehicle function_a64cc2eb8cc3ca3a() )
            {
                vehicle function_92e333ef50ff2c83( 1 );
                vehicle.veh_throttle = 0;
            }
            else
            {
                foreach ( seatid, occupant in vehicle.occupants )
                {
                    allow_movement_player( vehicle, occupant, 0, seatid );
                }
            }
        }
        
        return 0;
    }
}

// Namespace vehicle_occupancy
// Params 1
// Checksum 0x8b6f03af, Offset: 0x82ab
// Size: 0x124
function clear_allow_movement( vehicle )
{
    if ( vehicle vehicle::is_static() )
    {
        return;
    }
    
    vehicle_omnvar::hide_warning( "movementDisabled", function_8ed9bcd8e9ea74f5( vehicle ), vehicle vehicle::get_ref() );
    
    if ( vehicle hascomponent( "p2p" ) )
    {
        vehicle setconfigvalue( "p2p", "resume", 1 );
    }
    
    if ( vehicle hascomponent( "path" ) )
    {
        vehicle setconfigvalue( "path", "resume", 1 );
    }
    
    if ( vehicle function_a64cc2eb8cc3ca3a() )
    {
        vehicle function_92e333ef50ff2c83( 0 );
    }
    else if ( isdefined( vehicle.occupants ) )
    {
        foreach ( seatid, occupant in vehicle.occupants )
        {
            allow_movement_player( 1, occupant, seatid );
        }
    }
    
    vehicle.movementdisabled = undefined;
}

// Namespace vehicle_occupancy
// Params 4
// Checksum 0xdd58abde, Offset: 0x83d7
// Size: 0x116
function allow_movement_player( vehicle, player, bool, seatid )
{
    if ( bool )
    {
        if ( player.vehicledisabledmovement )
        {
            if ( player utility::callsharedfunc( #"player", #"playerisalive" ) )
            {
                player val::reset_all( "vehicle_occupancy" );
            }
            
            player.vehicledisabledmovement = undefined;
        }
        
        return;
    }
    
    leveldataforseat = function_568cd324ac705619( vehicle vehicle::get_ref(), seatid );
    
    if ( isdefined( leveldataforseat.animtag ) && ( leveldataforseat.animtag == "tag_seat_0" || leveldataforseat.animtag == "offset_seat_0" ) )
    {
        if ( !player.vehicledisabledmovement )
        {
            if ( player utility::callsharedfunc( #"player", #"playerisalive" ) )
            {
                player val::set( "vehicle_occupancy", "allow_movement", 0 );
                player.vehicledisabledmovement = 1;
            }
        }
    }
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0x397c607, Offset: 0x84f5
// Size: 0x43
function clear_allow_movement_player( player, fromdeath )
{
    if ( !fromdeath && player.vehicledisabledmovement )
    {
        player val::reset_all( "vehicle_occupancy" );
    }
    
    player.vehicledisabledmovement = undefined;
}

// Namespace vehicle_occupancy
// Params 1
// Checksum 0x12ab037f, Offset: 0x8540
// Size: 0x2a, Type: bool
function is_movement_allowed( vehicle )
{
    return !isdefined( vehicle.movementdisabled ) || vehicle.movementdisabled <= 0;
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0xaf5634a8, Offset: 0x8573
// Size: 0x55
function lock()
{
    allow_movement( self, 0, 0 );
    disable_engine();
    
    if ( self vehicle_isphysveh() )
    {
        self vehphys_parkingbrake( 1 );
    }
    
    self.islocked = 1;
    occupants = function_8ed9bcd8e9ea74f5( self );
    vehicle_omnvar::show_warning( "locked", occupants, vehicle::get_ref() );
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0x58854e0, Offset: 0x85d0
// Size: 0x5b
function unlock()
{
    allow_movement( self, 1, 0 );
    enable_engine();
    turn_engine_on();
    
    if ( self vehicle_isphysveh() )
    {
        self vehphys_parkingbrake( 0 );
    }
    
    self.islocked = undefined;
    occupants = function_8ed9bcd8e9ea74f5( self );
    vehicle_omnvar::hide_warning( "locked", occupants, vehicle::get_ref() );
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0x6f5454e0, Offset: 0x8633
// Size: 0x11, Type: bool
function is_locked()
{
    return isdefined( self ) && self.islocked;
}

// Namespace vehicle_occupancy
// Params 7
// Checksum 0x88e56eed, Offset: 0x864d
// Size: 0x34e
function function_759b1ac7685fb992( vehicle, player, seatid, allowairexit, islaststand, specialexit, allowcrouchexits = 0 )
{
    exitboundinginfo = get_exit_info( vehicle );
    leveldataforseat = function_568cd324ac705619( vehicle vehicle::get_ref(), seatid );
    leveldataforvehicle = get_data( vehicle vehicle::get_ref() );
    
    if ( isdefined( specialexit ) )
    {
        exitid = seatid + specialexit;
        exitdirection = leveldataforvehicle.exitdirections[ exitid ];
        position = get_exit_position( vehicle, player, exitid, exitboundinginfo, 1, allowcrouchexits );
        
        if ( isdefined( position ) )
        {
            angles = undefined;
            
            if ( !isdefined( leveldataforseat.animtag ) || leveldataforseat.animtag != "tag_seat_0" && leveldataforseat.animtag != "offset_seat_0" )
            {
                angles = get_exit_angles( vehicle, player, exitid, islaststand );
            }
            
            if ( specialexit == "_to_roof" )
            {
                player notify( #"roof_exit" );
            }
            
            position.angles = angles;
            position.specialexit = specialexit;
            position.direction = exitdirection;
            return position;
        }
        
        if ( specialexit == "_to_roof" && level.projectbundle.var_836fb29368eb04a2 )
        {
            return;
        }
    }
    
    skipexits = 0;
    
    /#
        skipexits = getdvarint( @"hash_7ae0d88acb509143", 0 );
    #/
    
    if ( vehicle vehicle::is_moving_backwards() && leveldataforseat.exitids[ 0 ].exitdirection == "back" )
    {
        skipexits = 1;
    }
    
    foreach ( exitstruct in leveldataforseat.exitids )
    {
        exitid = exitstruct.exitdirection;
        exitdirection = leveldataforvehicle.exitdirections[ exitid ];
        
        if ( exitdirection == "roof" || exitdirection == "dive" )
        {
            continue;
        }
        
        if ( skipexits > 0 )
        {
            skipexits -= 1;
            continue;
        }
        
        position = get_exit_position( vehicle, player, exitid, exitboundinginfo, allowairexit, allowcrouchexits );
        
        if ( isdefined( position ) )
        {
            angles = undefined;
            
            if ( !isdefined( leveldataforseat.animtag ) || leveldataforseat.animtag != "tag_seat_0" && leveldataforseat.animtag != "offset_seat_0" )
            {
                angles = get_exit_angles( vehicle, player, exitid, islaststand );
            }
            
            position.angles = angles;
            position.direction = exitdirection;
            return position;
        }
    }
    
    if ( getdvarint( @"hash_9c95c78d2efca328", 1 ) == 1 )
    {
        var_7237854e3be197ca = get_emergency_exit( vehicle, player );
        
        if ( isdefined( var_7237854e3be197ca ) )
        {
            return var_7237854e3be197ca;
        }
    }
}

// Namespace vehicle_occupancy
// Params 6
// Checksum 0x57dcff63, Offset: 0x89a3
// Size: 0xd65
function get_exit_position( vehicle, player, exitid, exitinfo, allowairexit, allowcrouchexits = 0 )
{
    if ( !( isdefined( vehicle ) && isdefined( player ) && isdefined( exitid ) ) )
    {
        assertmsg( "<dev string:xa5f>" + isdefined( vehicle ) + "<dev string:xa76>" + isdefined( player ) + "<dev string:xa8d>" + isdefined( exitid ) );
        return;
    }
    
    data = get_data( vehicle vehicle::get_ref() );
    
    if ( !isdefined( data ) )
    {
        assertmsg( "<dev string:xaa4>" + isdefined( data ) + "<dev string:xab8>" + vehicle.vehiclename );
        return;
    }
    
    if ( exitinfo.exitsfailed[ exitid ] )
    {
        return;
    }
    
    if ( isdefined( exitinfo.exitpositions[ exitid ] ) )
    {
        return exitinfo.exitpositions[ exitid ];
    }
    
    if ( !isdefined( data.exitoffsets[ exitid ] ) )
    {
        assertmsg( "<dev string:xac7>" + exitid + "<dev string:xada>" + vehicle.vehiclename );
        return;
    }
    
    if ( !isdefined( data.exitdirections[ exitid ] ) )
    {
        assertmsg( "<dev string:xafb>" + exitid + "<dev string:xada>" + vehicle.vehiclename );
        return;
    }
    
    exitoffset = data.exitoffsets[ exitid ];
    exitdirection = data.exitdirections[ exitid ];
    
    /#
        if ( getdvarint( @"hash_6d41518ba7b7fe27", 0 ) != 0 )
        {
            exitoffset = getdvarvector( @"hash_6d41518ba7b7fe27", exitoffset );
        }
    #/
    
    if ( exitdirection == "roof" && data.roofexittype == "animated" )
    {
        if ( getdvarint( @"hash_92092a101c9e6e0b", 0 ) == 1 )
        {
            exitposition = vehicle.origin + rotatevector( exitoffset, vehicle.angles );
            exit = { #iscrouchexit:0, #origin:exitposition };
            exitinfo.exitpositions[ exitid ] = exit;
            return exit;
        }
    }
    
    contents = physics_createcontents( [ "physicscontents_item", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_vehicleclip", "physicscontents_playerclip" ] );
    ignorelist = [];
    ignoreoccupants = ( exitdirection == "roof" || exitdirection == "dive" ) && getdvarint( @"hash_1a3a7c893dd9cc18", 1 ) == 1;
    
    foreach ( ent in vehicle getlinkedchildren( 1 ) )
    {
        if ( !isplayer( ent ) || ignoreoccupants )
        {
            ignorelist[ ignorelist.size ] = ent;
        }
    }
    
    ignorelist[ ignorelist.size ] = vehicle;
    ignorelist[ ignorelist.size ] = player;
    
    if ( exitdirection == "inside" || exitdirection == "dive" || exitdirection == "roof" || exitdirection == "top" )
    {
        caststart = vehicle.origin + rotatevector( exitoffset, vehicle.angles );
        castend = caststart;
        castend = character_cast( player, caststart, castend, ignorelist, allowairexit, exitdirection );
        
        if ( !isdefined( castend ) )
        {
            exitinfo.exitsfailed[ exitid ] = 1;
            return;
        }
        
        exit = { #iscrouchexit:0, #origin:castend };
        exitinfo.exitpositions[ exitid ] = exit;
        return exit;
    }
    
    center = vehicle get_center( data );
    isflipped = math::anglebetweenvectors( anglestoup( vehicle.angles ), ( 0, 0, 1 ) ) > 90;
    capsule = player getcollision( "stand" );
    playerradius = capsule.capsule_radius;
    standheight = capsule.capsule_halfheight + capsule.capsule_midpoint_height + capsule.capsule_radius;
    capsule = player getcollision( "crouch" );
    crouchheight = capsule.capsule_halfheight + capsule.capsule_midpoint_height + capsule.capsule_radius;
    tiltoffset = playerradius;
    castingdown = 0;
    
    switch ( exitdirection )
    {
        case #"hash_4b8799075d3a89b8":
            tiltangle = vehicle.angles[ 0 ];
            
            if ( tiltangle == 90 || tiltangle == 270 )
            {
                tilttan = 1;
            }
            else
            {
                tilttan = tan( tiltangle );
            }
            
            castingdown = tilttan > 0;
            
            if ( castingdown )
            {
                var_c5a5f0f0e5ffe1e2 = data.exitextents[ "front" ] + abs( tilttan ) * data.exitextents[ "top" ];
                tiltoffset += cos( tiltangle ) * var_c5a5f0f0e5ffe1e2;
                exitoffset = ( max( exitoffset[ 0 ], tiltoffset ), exitoffset[ 1 ], exitoffset[ 2 ] );
            }
            else
            {
                tiltoffset += min( abs( tilttan ), 1 ) * ( data.exitextents[ "bottom" ] + 10 );
                exitoffset = ( max( exitoffset[ 0 ], data.exitextents[ "front" ] + tiltoffset ), exitoffset[ 1 ], exitoffset[ 2 ] );
            }
            
            break;
        case #"hash_5163a22eb8c03302":
            tiltangle = vehicle.angles[ 0 ];
            
            if ( tiltangle == 90 || tiltangle == 270 )
            {
                tilttan = 1;
            }
            else
            {
                tilttan = tan( tiltangle );
            }
            
            castingdown = tilttan < 0;
            
            if ( castingdown )
            {
                var_c5a5f0f0e5ffe1e2 = data.exitextents[ "back" ] + abs( tilttan ) * data.exitextents[ "top" ];
                tiltoffset += cos( tiltangle ) * var_c5a5f0f0e5ffe1e2;
                exitoffset = ( min( exitoffset[ 0 ], -1 * tiltoffset ), exitoffset[ 1 ], exitoffset[ 2 ] );
            }
            else
            {
                tiltoffset += min( abs( tilttan ), 1 ) * ( data.exitextents[ "bottom" ] + 10 );
                exitoffset = ( min( exitoffset[ 0 ], -1 * ( data.exitextents[ "back" ] + tiltoffset ) ), exitoffset[ 1 ], exitoffset[ 2 ] );
            }
            
            break;
        case #"hash_c9b3133a17a3b2d0":
            tiltangle = vehicle.angles[ 2 ];
            
            if ( tiltangle == 90 || tiltangle == 270 )
            {
                tilttan = 1;
            }
            else
            {
                tilttan = tan( tiltangle );
            }
            
            castingdown = tilttan < 0;
            
            if ( castingdown )
            {
                var_c5a5f0f0e5ffe1e2 = data.exitextents[ "left" ] + abs( tilttan ) * data.exitextents[ "top" ];
                tiltoffset += cos( tiltangle ) * var_c5a5f0f0e5ffe1e2;
                exitoffset = ( exitoffset[ 0 ], max( exitoffset[ 1 ], tiltoffset ), exitoffset[ 2 ] );
            }
            else
            {
                tiltoffset += min( abs( tilttan ), 1 ) * ( data.exitextents[ "bottom" ] + 10 );
                exitoffset = ( exitoffset[ 0 ], max( exitoffset[ 1 ], data.exitextents[ "left" ] + tiltoffset ), exitoffset[ 2 ] );
            }
            
            break;
        case #"hash_96815ce4f2a3dbc5":
            tiltangle = vehicle.angles[ 2 ];
            
            if ( tiltangle == 90 || tiltangle == 270 )
            {
                tilttan = 1;
            }
            else
            {
                tilttan = tan( tiltangle );
            }
            
            castingdown = tilttan > 0;
            
            if ( castingdown )
            {
                var_c5a5f0f0e5ffe1e2 = data.exitextents[ "right" ] + abs( tilttan ) * data.exitextents[ "top" ];
                tiltoffset += cos( tiltangle ) * var_c5a5f0f0e5ffe1e2;
                exitoffset = ( exitoffset[ 0 ], min( exitoffset[ 1 ], -1 * tiltoffset ), exitoffset[ 2 ] );
            }
            else
            {
                tiltoffset += min( abs( tilttan ), 1 ) * ( data.exitextents[ "bottom" ] + 10 );
                exitoffset = ( exitoffset[ 0 ], min( exitoffset[ 1 ], -1 * ( data.exitextents[ "right" ] + tiltoffset ) ), exitoffset[ 2 ] );
            }
            
            break;
    }
    
    angles = castingdown ? ( 0, vehicle.angles[ 1 ], 0 ) : vehicle.angles;
    exitoffset = center + rotatevector( ( exitoffset[ 0 ], exitoffset[ 1 ], 10 ), angles );
    
    if ( isflipped )
    {
        exitoffset += ( 0, 0, 20 );
    }
    
    if ( !isdefined( exitinfo.spherecastradius ) )
    {
        exitinfo.spherecastradius = playerradius;
    }
    
    spherecastradius = exitinfo.spherecastradius;
    var_d85db35d6c3cf704 = physics_spherecast( center, exitoffset, spherecastradius, contents, ignorelist, "physicsquery_closest", "physicsquery_any", 1 );
    
    if ( var_d85db35d6c3cf704[ 1 ] )
    {
        if ( exitinfo.spherecastradius == playerradius )
        {
            exitinfo.spherecastradius = 10;
        }
        else
        {
            exitinfo.spherecastradius = 5;
        }
    }
    
    if ( isdefined( var_d85db35d6c3cf704 ) && ( var_d85db35d6c3cf704[ 1 ] || isdefined( var_d85db35d6c3cf704[ 0 ][ 0 ][ "position" ] ) ) )
    {
        /#
            if ( level.debugvehicleexit )
            {
                finalposition = var_d85db35d6c3cf704[ 0 ][ 0 ][ "<dev string:x155>" ] ?? exitoffset;
                
                if ( isdefined( var_d85db35d6c3cf704[ 0 ][ 0 ][ "<dev string:x164>" ] ) )
                {
                    level thread function_daa8eeffc9a97683( var_d85db35d6c3cf704[ 0 ][ 0 ][ "<dev string:x164>" ], 2, 60, ( 1, 0, 0 ) );
                }
                
                level thread function_94553a295e176da5( center, finalposition, spherecastradius, 60, ( 0, 1, 0 ) );
            }
        #/
        
        exitinfo.exitsfailed[ exitid ] = 1;
        return;
    }
    
    level thread function_94553a295e176da5( center, exitoffset, spherecastradius, 60, ( 0, 1, 0 ) );
    castupposition = exitoffset + ( 0, 0, 70 );
    castup = physics_spherecast( exitoffset, castupposition, playerradius, contents, ignorelist, "physicsquery_closest", "physicsquery_any", 1 );
    
    if ( isdefined( castup ) && castup.size > 0 )
    {
        if ( isdefined( castup[ 0 ][ 0 ][ "position" ] ) )
        {
            level thread function_daa8eeffc9a97683( castup[ 0 ][ 0 ][ "position" ], 2, 60, ( 1, 0, 0 ) );
        }
        
        if ( castup[ 1 ] )
        {
            level thread function_94553a295e176da5( exitoffset, castup[ 0 ][ 0 ][ "shape_position" ] ?? exitoffset, playerradius, 60, ( 1, 0, 0 ) );
            exitinfo.exitsfailed[ exitid ] = 1;
            return;
        }
        else
        {
            if ( isdefined( castup[ 0 ][ 0 ][ "shape_position" ] ) )
            {
                castupposition = castup[ 0 ][ 0 ][ "shape_position" ];
            }
            
            level thread function_94553a295e176da5( exitoffset, castupposition, playerradius, 60, ( 0, 1, 0 ) );
        }
    }
    
    if ( !isdefined( exitinfo.lowerbound ) )
    {
        exitinfo.lowerbound = vehicle function_edc9b80d6bd30d3a( data.exitextents );
    }
    
    castdownstart = castupposition - ( 0, 0, 1 );
    castdownend = ( castupposition[ 0 ], castupposition[ 1 ], exitinfo.lowerbound - 125 );
    castdown = physics_spherecast( castdownstart, castdownend, playerradius, contents, ignorelist, "physicsquery_closest", "physicsquery_any", 1 );
    castfailed = castdown.size > 0 && castdown[ 1 ];
    castfailed |= castdown[ 0 ].size == 0 && !allowairexit;
    
    if ( isdefined( castdown ) && castdown.size > 0 )
    {
        if ( isdefined( castdown[ 0 ][ 0 ][ "position" ] ) )
        {
            level thread function_daa8eeffc9a97683( castdown[ 0 ][ 0 ][ "position" ], 2, 60, ( 0, 1, 0 ) );
        }
        
        shapeposition = castdown[ 0 ][ 0 ][ "shape_position" ];
        
        if ( shapeposition )
        {
            castdownend = shapeposition;
            groundposition = shapeposition - ( 0, 0, playerradius );
        }
        
        if ( castdown[ 0 ].size == 0 )
        {
            if ( exitdirection != "top" && exitdirection != "roof" && exitdirection != "inside" )
            {
                castdownend += ( 0, 0, 40 );
            }
        }
    }
    
    totalheight = castdownstart[ 2 ] - castdownend[ 2 ] + playerradius * 2;
    castfailed |= totalheight < crouchheight;
    castfailed |= !allowcrouchexits && totalheight < standheight;
    level thread function_94553a295e176da5( castdownstart, castdownend, playerradius, 60, castfailed ? ( 1, 0, 0 ) : ( 0, 1, 1 ) );
    
    if ( castfailed )
    {
        exitinfo.exitsfailed[ exitid ] = 1;
        return;
    }
    
    exit = { #iscrouchexit:totalheight < standheight, #origin:groundposition ?? castdownend };
    exitinfo.exitpositions[ exitid ] = exit;
    return exit;
}

// Namespace vehicle_occupancy
// Params 1, eflags: 0x4
// Checksum 0x7bd58c36, Offset: 0x9711
// Size: 0xc3
function private get_center( data )
{
    if ( self tagexists( "tag_body_animate" ) )
    {
        center = self gettagorigin( "tag_body_animate" );
    }
    else if ( self tagexists( "tag_body" ) )
    {
        center = self gettagorigin( "tag_body" );
    }
    else
    {
        center = self getcentroid();
    }
    
    if ( data.centeroffset )
    {
        center += rotatevector( ( data.centeroffset.x ?? 0, data.centeroffset.y ?? 0, data.centeroffset.z ?? 0 ), self.angles );
    }
    
    return center;
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0xd21366f3, Offset: 0x97dd
// Size: 0x3a9
function get_emergency_exit( vehicle, player )
{
    if ( isnavmeshloaded() )
    {
        leveldataforvehicle = get_data( vehicle vehicle::get_ref() );
        radiussize = 50;
        
        if ( leveldataforvehicle.exitextents )
        {
            foreach ( extent in leveldataforvehicle.exitextents )
            {
                radiussize = max( extent, radiussize );
            }
        }
        
        radiusincrease = radiussize;
        maxradius = radiusincrease * getdvarfloat( @"hash_ac8df14c02e380bd", 5 );
        var_594ff49a1d5c73f2 = 0;
        radiusincrease = getdvarfloat( @"hash_5264fcbe32bf9d29", radiusincrease );
        center = vehicle get_center( leveldataforvehicle );
        
        while ( radiussize <= maxradius )
        {
            exitpoint = function_d115ed3f24729c7( player, vehicle, radiussize, var_594ff49a1d5c73f2, center );
            
            if ( isdefined( exitpoint ) )
            {
                radiussize = maxradius + 1;
                println( "<dev string:xb11>" );
                return { #iscrouchexit:0, #direction:"nav_points", #origin:exitpoint };
            }
            
            if ( !var_594ff49a1d5c73f2 && radiussize + radiusincrease >= maxradius )
            {
                var_594ff49a1d5c73f2 = 1;
                radiussize = 50;
                continue;
            }
            
            radiussize += radiusincrease;
        }
    }
    
    ignorelist = [ player ];
    nodes = getnodesinradiussorted( vehicle.origin, 800, 0, 250, "path" );
    direction = "nodes";
    
    if ( !isdefined( nodes ) || nodes.size <= 0 )
    {
        if ( isnavmeshloaded() )
        {
            vecs = getrandomnavpoints( vehicle.origin, 800, 6 );
        }
        else
        {
            return;
        }
        
        if ( !isdefined( vecs ) || vecs.size <= 0 )
        {
            return;
        }
        
        nodes = [];
        
        foreach ( vec in vecs )
        {
            node = { #origin:vec };
            nodes[ nodes.size ] = node;
        }
        
        nodes = sortbydistance( nodes, vehicle.origin );
        direction = "nav_points";
    }
    
    nodestried = 0;
    
    foreach ( node in nodes )
    {
        castend = character_cast( player, node.origin, node.origin, ignorelist, 1, "inside" );
        
        if ( isdefined( castend ) )
        {
            return { #iscrouchexit:0, #direction:direction, #origin:castend };
        }
        
        nodestried += 1;
        
        if ( nodestried > 5 )
        {
            break;
        }
    }
}

// Namespace vehicle_occupancy
// Params 5, eflags: 0x4
// Checksum 0x88ac4f7a, Offset: 0x9b8e
// Size: 0x314
function private function_d115ed3f24729c7( player, vehicle, radius, var_594ff49a1d5c73f2, center )
{
    ignorelist = [ player ];
    contents = physics_createcontents( [ "physicscontents_playernosight", "physicscontents_cameraclip", "physicscontents_glass", "physicscontents_itemclip" ] );
    attempts = 0;
    var_b677ec0c898e2861 = center;
    println( "<dev string:xb3d>" + var_b677ec0c898e2861 );
    
    if ( var_594ff49a1d5c73f2 )
    {
        vertical_offset = ( 0, 0, 1000 );
        content = [ "physicscontents_aiclip", "physicscontents_glass" ];
        solid_ai_contents = physics_createcontents( content );
        ray_trace = trace::ray_trace( center - ( 0, 0, 100 ), center - vertical_offset, undefined, solid_ai_contents );
        var_b677ec0c898e2861 = ray_trace[ "hittype" ] != "hittype_none" ? ray_trace[ "position" ] : center;
        thread function_5a2af62439f0d42c( center - ( 0, 0, 100 ), center - vertical_offset, 60, ( 0, 0, 1 ) );
        println( "<dev string:xb65>" + var_b677ec0c898e2861 );
        
        if ( var_b677ec0c898e2861 == center )
        {
            return;
        }
    }
    
    while ( true )
    {
        segmentdegrees = randomintrange( 0, 360 );
        println( "<dev string:xb92>" + segmentdegrees );
        println( "<dev string:xbba>" + radius );
        var_21cd6c2bd1a1ccc0 = function_34f24d36df92858c( var_b677ec0c898e2861, radius, segmentdegrees );
        onnavmesh = getclosestpointonnavmesh( var_21cd6c2bd1a1ccc0, level.vehiclenavmeshlayer );
        castresults = physics_raycast( center, onnavmesh + ( 0, 0, 35 ), contents, [ vehicle, player ], 0, "physicsquery_closest", 1 );
        
        if ( castresults.size == 0 )
        {
            castend = character_cast( player, onnavmesh + ( 0, 0, 10 ), onnavmesh - ( 0, 0, 20 ), ignorelist, 1, "inside" );
            
            if ( !isdefined( castend ) )
            {
                thread function_5a2af62439f0d42c( center, onnavmesh + ( 0, 0, 35 ), 60, ( 0, 0, 1 ) );
                println( "<dev string:xbda>" );
            }
            else
            {
                thread function_5a2af62439f0d42c( center, onnavmesh + ( 0, 0, 35 ), 60, ( 0, 1, 0 ) );
                println( "<dev string:xc08>" );
                return castend;
            }
        }
        else
        {
            thread function_5a2af62439f0d42c( center, onnavmesh + ( 0, 0, 35 ), 60, ( 1, 0, 0 ) );
            println( "<dev string:xc32>" );
        }
        
        attempts++;
        
        if ( attempts > getdvarint( @"hash_8d7fbced2a67f08", 10 ) )
        {
            return;
        }
    }
}

// Namespace vehicle_occupancy
// Params 3, eflags: 0x4
// Checksum 0x3bcc7d2e, Offset: 0x9eaa
// Size: 0x35
function private function_34f24d36df92858c( center, radius, deg )
{
    return center + ( radius * cos( deg ), radius * sin( deg ), 0 );
}

// Namespace vehicle_occupancy
// Params 3, eflags: 0x4
// Checksum 0xbf59c3f8, Offset: 0x9ee8
// Size: 0xdb, Type: bool
function private function_b41e409298199cf3( vehicle, player, origin )
{
    ignorelist = [];
    
    foreach ( ent in vehicle getlinkedchildren( 1 ) )
    {
        if ( !isplayer( ent ) )
        {
            ignorelist[ ignorelist.size ] = ent;
        }
    }
    
    ignorelist[ ignorelist.size ] = vehicle;
    ignorelist[ ignorelist.size ] = player;
    castend = origin;
    castend = character_cast( player, origin, castend, ignorelist, 1, "inside" );
    return isdefined( castend );
}

// Namespace vehicle_occupancy
// Params 6, eflags: 0x4
// Checksum 0x2804145, Offset: 0x9fcc
// Size: 0x22c
function private character_cast( player, caststart, castend, ignorelist, allowairexit, exitdirection )
{
    castfailed = 0;
    debuglinestart = undefined;
    debuglineend = undefined;
    
    /#
        debuglinestart = caststart;
        debuglineend = castend;
    #/
    
    contents = physics_createcontents( [ "physicscontents_item", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_vehicleclip", "physicscontents_playerclip", "physicscontents_characterproxy" ] );
    castresults = physics_charactercast( caststart, castend, player, 0, ( 0, 0, 0 ), contents, ignorelist, "physicsquery_closest", "physicsquery_any" );
    
    if ( isdefined( castresults ) && castresults.size > 0 )
    {
        if ( castresults[ 1 ] )
        {
            /#
                debuglineend = debuglinestart;
            #/
            
            castfailed = 1;
        }
        else if ( castresults[ 0 ].size == 0 )
        {
            if ( !allowairexit )
            {
                /#
                    debuglineend = debuglinestart;
                #/
                
                castfailed = 1;
            }
            else
            {
                if ( exitdirection != "top" && exitdirection != "roof" && exitdirection != "inside" )
                {
                    castend += ( 0, 0, 40 );
                }
                
                /#
                    debuglineend = castend;
                #/
            }
        }
        else
        {
            castend = castresults[ 0 ][ 0 ][ "shape_position" ];
            
            /#
                debuglineend = castend;
            #/
        }
    }
    
    /#
        if ( level.debugvehicleexit )
        {
            drawframes = int( ceil( 60 / level.framedurationseconds ) );
            thread function_fab637e91697ac1( debuglinestart, 15, 70, undefined, ( 0, 1, 1 ), undefined, drawframes );
            thread function_5a2af62439f0d42c( debuglinestart, debuglineend, 60, ( 0, 1, 1 ) );
            
            if ( castfailed && isdefined( castresults[ 0 ][ 0 ][ "<dev string:x164>" ] ) )
            {
                level thread function_daa8eeffc9a97683( castresults[ 0 ][ 0 ][ "<dev string:x164>" ], 2, 60, ( 1, 0, 0 ) );
            }
        }
    #/
    
    if ( castfailed )
    {
        return;
    }
    
    thread function_daa8eeffc9a97683( debuglineend, 2, 60, ( 0, 1, 0 ) );
    return castend;
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0xc721e3c3, Offset: 0xa201
// Size: 0x37
function function_7908774084bd703b( vehicleref, direction )
{
    data = get_data( vehicleref );
    return data.exitextents[ direction ];
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0x2802bb77, Offset: 0xa241
// Size: 0x8a4
function get_exit_info( vehicle, debugonly = 0 )
{
    exitboundinginfo = undefined;
    
    if ( isdefined( vehicle.exitboundinginfo ) && vehicle.exitboundinginfo.timestamp == gettime() )
    {
        exitboundinginfo = vehicle.exitboundinginfo;
        
        /#
            function_67fabdb37c99a2d4( exitboundinginfo, debugonly );
        #/
    }
    else
    {
        leveldataforvehicle = get_data( vehicle vehicle::get_ref() );
        
        if ( isdefined( leveldataforvehicle ) && isdefined( leveldataforvehicle.exitextents ) )
        {
            assert( isdefined( leveldataforvehicle.exitextents[ "<dev string:xc75>" ] ), "<dev string:xc7b>" );
            assert( isdefined( leveldataforvehicle.exitextents[ "<dev string:xccf>" ] ), "<dev string:xcd4>" );
            assert( isdefined( leveldataforvehicle.exitextents[ "<dev string:xd27>" ] ), "<dev string:xd2c>" );
            assert( isdefined( leveldataforvehicle.exitextents[ "<dev string:xd7f>" ] ), "<dev string:xd85>" );
            assert( isdefined( leveldataforvehicle.exitextents[ "<dev string:xdd9>" ] ), "<dev string:xddd>" );
            assert( isdefined( leveldataforvehicle.exitextents[ "<dev string:xe2f>" ] ), "<dev string:xe36>" );
            exitboundinginfo = spawnstruct();
            vehicle.exitboundinginfo = exitboundinginfo;
            exitboundinginfo = exitboundinginfo;
            exitboundinginfo.vehicle = vehicle;
            exitboundinginfo.timestamp = gettime();
            exitboundinginfo.exitsfailed = [];
            exitboundinginfo.exitpositions = [];
            
            /#
                exitboundinginfo.orientedboxpoints = [];
                exitboundinginfo.unorientedboxpoints = [];
                angles = vehicle.angles;
                exitextents = arraycopy( leveldataforvehicle.exitextents );
                
                if ( getdvar( @"hash_a338b83c3b10b3e7", "<dev string:xe8b>" ) != "<dev string:xe8b>" )
                {
                    foreach ( override in strtok( getdvar( @"hash_a338b83c3b10b3e7", "<dev string:xe8b>" ), "<dev string:xe8c>" ) )
                    {
                        if ( issubstr( override, "<dev string:xc75>" ) )
                        {
                            exitextents[ "<dev string:xc75>" ] = float( removesubstr( override, "<dev string:xc75>" ) );
                            continue;
                        }
                        
                        if ( issubstr( override, "<dev string:xccf>" ) )
                        {
                            exitextents[ "<dev string:xccf>" ] = float( removesubstr( override, "<dev string:xccf>" ) );
                            continue;
                        }
                        
                        if ( issubstr( override, "<dev string:xd7f>" ) )
                        {
                            exitextents[ "<dev string:xd7f>" ] = float( removesubstr( override, "<dev string:xd7f>" ) );
                            continue;
                        }
                        
                        if ( issubstr( override, "<dev string:xd27>" ) )
                        {
                            exitextents[ "<dev string:xd27>" ] = float( removesubstr( override, "<dev string:xd27>" ) );
                            continue;
                        }
                        
                        if ( issubstr( override, "<dev string:xdd9>" ) )
                        {
                            exitextents[ "<dev string:xdd9>" ] = float( removesubstr( override, "<dev string:xdd9>" ) );
                            continue;
                        }
                        
                        if ( issubstr( override, "<dev string:xe2f>" ) )
                        {
                            exitextents[ "<dev string:xe2f>" ] = float( removesubstr( override, "<dev string:xe2f>" ) );
                        }
                    }
                }
                
                topleftfront = rotatevector( ( exitextents[ "<dev string:xc75>" ], exitextents[ "<dev string:xd27>" ] * -1, exitextents[ "<dev string:xdd9>" ] ), angles );
                toprightfront = rotatevector( ( exitextents[ "<dev string:xc75>" ], exitextents[ "<dev string:xd7f>" ], exitextents[ "<dev string:xdd9>" ] ), angles );
                topleftback = rotatevector( ( exitextents[ "<dev string:xccf>" ] * -1, exitextents[ "<dev string:xd27>" ] * -1, exitextents[ "<dev string:xdd9>" ] ), angles );
                toprightback = rotatevector( ( exitextents[ "<dev string:xccf>" ] * -1, exitextents[ "<dev string:xd7f>" ], exitextents[ "<dev string:xdd9>" ] ), angles );
                bottomleftfront = rotatevector( ( exitextents[ "<dev string:xc75>" ], exitextents[ "<dev string:xd27>" ] * -1, exitextents[ "<dev string:xe2f>" ] * -1 ), angles );
                bottomrightfront = rotatevector( ( exitextents[ "<dev string:xc75>" ], exitextents[ "<dev string:xd7f>" ], exitextents[ "<dev string:xe2f>" ] * -1 ), angles );
                bottomleftback = rotatevector( ( exitextents[ "<dev string:xccf>" ] * -1, exitextents[ "<dev string:xd27>" ] * -1, exitextents[ "<dev string:xe2f>" ] * -1 ), angles );
                bottomrightback = rotatevector( ( exitextents[ "<dev string:xccf>" ] * -1, exitextents[ "<dev string:xd7f>" ], exitextents[ "<dev string:xe2f>" ] * -1 ), angles );
                points = [ topleftfront, toprightfront, topleftback, toprightback, bottomleftfront, bottomrightfront, bottomleftback, bottomrightback ];
                bestfront = -99999;
                bestback = 99999;
                bestleft = -99999;
                bestright = 99999;
                besttop = -99999;
                bestbot = 99999;
                anglesyawonly = ( 0, angles[ 1 ], 0 );
                
                foreach ( point in points )
                {
                    point = rotatevectorinverted( point, anglesyawonly );
                    
                    if ( point[ 0 ] > bestfront )
                    {
                        bestfront = point[ 0 ];
                    }
                    
                    if ( point[ 0 ] < bestback )
                    {
                        bestback = point[ 0 ];
                    }
                    
                    if ( point[ 1 ] < bestright )
                    {
                        bestright = point[ 1 ];
                    }
                    
                    if ( point[ 1 ] > bestleft )
                    {
                        bestleft = point[ 1 ];
                    }
                    
                    if ( point[ 2 ] > besttop )
                    {
                        besttop = point[ 2 ];
                    }
                    
                    if ( point[ 2 ] < bestbot )
                    {
                        bestbot = point[ 2 ];
                    }
                }
                
                exitboundinginfo.orientedboxpoints[ "<dev string:xe8e>" ] = vehicle.origin + topleftfront;
                exitboundinginfo.orientedboxpoints[ "<dev string:xe9b>" ] = vehicle.origin + toprightfront;
                exitboundinginfo.orientedboxpoints[ "<dev string:xea9>" ] = vehicle.origin + topleftback;
                exitboundinginfo.orientedboxpoints[ "<dev string:xeb5>" ] = vehicle.origin + toprightback;
                exitboundinginfo.orientedboxpoints[ "<dev string:xec2>" ] = vehicle.origin + bottomleftfront;
                exitboundinginfo.orientedboxpoints[ "<dev string:xed2>" ] = vehicle.origin + bottomrightfront;
                exitboundinginfo.orientedboxpoints[ "<dev string:xee3>" ] = vehicle.origin + bottomleftback;
                exitboundinginfo.orientedboxpoints[ "<dev string:xef2>" ] = vehicle.origin + bottomrightback;
                exitboundinginfo.unorientedboxpoints[ "<dev string:xe8e>" ] = vehicle.origin + rotatevector( ( bestfront, bestleft, besttop ), anglesyawonly );
                exitboundinginfo.unorientedboxpoints[ "<dev string:xe9b>" ] = vehicle.origin + rotatevector( ( bestfront, bestright, besttop ), anglesyawonly );
                exitboundinginfo.unorientedboxpoints[ "<dev string:xea9>" ] = vehicle.origin + rotatevector( ( bestback, bestleft, besttop ), anglesyawonly );
                exitboundinginfo.unorientedboxpoints[ "<dev string:xeb5>" ] = vehicle.origin + rotatevector( ( bestback, bestright, besttop ), anglesyawonly );
                exitboundinginfo.unorientedboxpoints[ "<dev string:xec2>" ] = vehicle.origin + rotatevector( ( bestfront, bestleft, bestbot ), anglesyawonly );
                exitboundinginfo.unorientedboxpoints[ "<dev string:xed2>" ] = vehicle.origin + rotatevector( ( bestfront, bestright, bestbot ), anglesyawonly );
                exitboundinginfo.unorientedboxpoints[ "<dev string:xee3>" ] = vehicle.origin + rotatevector( ( bestback, bestleft, bestbot ), anglesyawonly );
                exitboundinginfo.unorientedboxpoints[ "<dev string:xef2>" ] = vehicle.origin + rotatevector( ( bestback, bestright, bestbot ), anglesyawonly );
            #/
            
            exitboundinginfo thread cleanup_exit_info();
            
            /#
                function_67fabdb37c99a2d4( exitboundinginfo, debugonly );
            #/
        }
    }
    
    return exitboundinginfo;
}

// Namespace vehicle_occupancy
// Params 1, eflags: 0x4
// Checksum 0x94359a20, Offset: 0xaaee
// Size: 0x1e8
function private function_edc9b80d6bd30d3a( exitextents )
{
    angles = self.angles;
    points = [ rotatevector( ( exitextents[ "front" ], exitextents[ "left" ] * -1, exitextents[ "top" ] ), angles ), rotatevector( ( exitextents[ "front" ], exitextents[ "right" ], exitextents[ "top" ] ), angles ), rotatevector( ( exitextents[ "back" ] * -1, exitextents[ "left" ] * -1, exitextents[ "top" ] ), angles ), rotatevector( ( exitextents[ "back" ] * -1, exitextents[ "right" ], exitextents[ "top" ] ), angles ), rotatevector( ( exitextents[ "front" ], exitextents[ "left" ] * -1, exitextents[ "bottom" ] * -1 ), angles ), rotatevector( ( exitextents[ "front" ], exitextents[ "right" ], exitextents[ "bottom" ] * -1 ), angles ), rotatevector( ( exitextents[ "back" ] * -1, exitextents[ "left" ] * -1, exitextents[ "bottom" ] * -1 ), angles ), rotatevector( ( exitextents[ "back" ] * -1, exitextents[ "right" ], exitextents[ "bottom" ] * -1 ), angles ) ];
    lowerbound = undefined;
    
    foreach ( point in points )
    {
        if ( !lowerbound || point[ 2 ] < lowerbound )
        {
            lowerbound = point[ 2 ];
        }
    }
    
    return lowerbound + self.origin[ 2 ];
}

// Namespace vehicle_occupancy
// Params 0, eflags: 0x4
// Checksum 0xa3489299, Offset: 0xacdf
// Size: 0x68
function private cleanup_exit_info()
{
    waitframe();
    
    if ( isdefined( self.vehicle ) )
    {
        return;
    }
    
    if ( !isdefined( self.vehicle.exitboundinginfo ) )
    {
        return;
    }
    
    if ( self.vehicle.exitboundinginfo.timestamp != self.timestamp )
    {
        return;
    }
    
    self.vehicle.exitboundinginfo = undefined;
}

// Namespace vehicle_occupancy
// Params 4, eflags: 0x4
// Checksum 0x958e64db, Offset: 0xad4f
// Size: 0x2d3
function private get_exit_angles( vehicle, player, exitid, islaststand )
{
    leveldataforvehicle = get_data( vehicle vehicle::get_ref() );
    exitboundinginfo = get_exit_info( vehicle );
    exitposition = exitboundinginfo.exitpositions[ exitid ].origin;
    focalpoint = undefined;
    ignorelos = 0;
    
    if ( islaststand )
    {
        focalpoint = vehicle.origin + rotatevector( leveldataforvehicle.exitoffsets[ exitid ], vehicle.angles );
        ignorelos = 1;
    }
    
    if ( !isdefined( focalpoint ) )
    {
        focalpoint = player getvieworigin() + anglestoforward( player getplayerangles() ) * 550;
    }
    
    viewposition = undefined;
    
    if ( islaststand )
    {
        viewposition = exitposition + ( 0, 0, 22 );
    }
    else
    {
        viewposition = exitposition + ( 0, 0, 60 );
    }
    
    viewdirection = vectornormalize( focalpoint - viewposition );
    
    if ( !ignorelos )
    {
        contents = physics_createcontents( [ "physicscontents_vehicle", "physicscontents_item" ] );
        castresults = physics_raycast( viewposition, viewposition + viewdirection * 300, contents, undefined, 0, "physicsquery_closest", 1 );
        
        if ( isdefined( castresults ) && castresults.size > 0 )
        {
            hitent = castresults[ 0 ][ "entity" ];
            viewblocked = 0;
            
            if ( isdefined( hitent ) )
            {
                hitlist = vehicle getlinkedchildren( 1 );
                
                if ( !isdefined( hitlist ) )
                {
                    hitlist = [];
                }
                
                hitlist[ hitlist.size ] = vehicle;
                
                foreach ( ent in hitlist )
                {
                    if ( hitent == ent )
                    {
                        viewblocked = 1;
                        break;
                    }
                }
            }
            
            if ( viewblocked )
            {
                exitdirection = leveldataforvehicle.exitdirections[ exitid ];
                angles = ( 0, vehicle.angles[ 1 ], 0 );
                
                if ( exitdirection == "left" || exitdirection == "right" )
                {
                    canceldirection = anglestoright( angles );
                }
                else
                {
                    canceldirection = anglestoforward( angles );
                }
                
                viewdirection -= canceldirection * vectordot( viewdirection, canceldirection );
            }
        }
    }
    
    viewangles = vectortoangles( viewdirection );
    viewangles = ( clamp( viewangles[ 0 ], -12, 12 ), viewangles[ 1 ], 0 );
    return viewangles;
}

// Namespace vehicle_occupancy
// Params 6, eflags: 0x4
// Checksum 0xeeee5a0e, Offset: 0xb02b
// Size: 0x1b9
function private find_player_exit( player, vehicle, oldseatid, newseatid, data, specialexit )
{
    if ( !isdefined( player ) || !isdefined( vehicle ) || isdefined( newseatid ) || data.playerdeath && !data.playerlaststand && !data.playerliveragdoll )
    {
        return 1;
    }
    
    /#
        function_d0b91dc395312ace();
    #/
    
    leveldataforvehicle = get_data( vehicle vehicle::get_ref() );
    allowairexit = vehicle vehicle_isphysveh() ? leveldataforvehicle.allowairexit || data.allowairexit || !vehicle vehicle_isonground() : 0;
    exit = function_759b1ac7685fb992( vehicle, player, oldseatid, allowairexit, data.playerlaststand, specialexit, 1 );
    
    if ( isdefined( exit ) )
    {
        data.exitposition = exit.origin;
        data.exitangles = exit.angles;
        data.specialexit = exit.specialexit;
        data.exitdirection = exit.direction;
        data.iscrouchexit = exit.iscrouchexit;
        data.exitoffset = rotatevectorinverted( data.exitposition - vehicle.origin, vehicle.angles );
        return 1;
    }
    
    return 0;
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0x97374b34, Offset: 0xb1ec
// Size: 0xa7, Type: bool
function function_63c6c86801e0685c()
{
    if ( isdefined( vehicle::get_ref() ) )
    {
        leveldataforvehicle = get_data( vehicle::get_ref() );
        return ( isdefined( leveldataforvehicle ) && isdefined( leveldataforvehicle.exitextents[ "front" ] ) && isdefined( leveldataforvehicle.exitextents[ "back" ] ) && isdefined( leveldataforvehicle.exitextents[ "left" ] ) && isdefined( leveldataforvehicle.exitextents[ "right" ] ) && isdefined( leveldataforvehicle.exitextents[ "top" ] ) && isdefined( leveldataforvehicle.exitextents[ "bottom" ] ) );
    }
    
    return false;
}

// Namespace vehicle_occupancy
// Params 5
// Checksum 0xa2bbc89e, Offset: 0xb29c
// Size: 0x3c4
function function_7ce9972f31ab138b( player, vehicle, testpoint, skipmovementdirection, allowcrouchexits = 0 )
{
    if ( !( isdefined( player ) && isdefined( vehicle ) && isdefined( testpoint ) && isdefined( vehicle.origin ) && isdefined( vehicle.angles ) ) )
    {
        return;
    }
    
    data = get_data( vehicle vehicle::get_ref() );
    skipdirection = undefined;
    
    if ( skipmovementdirection )
    {
        forward = anglestoforward( vehicle.angles );
        moving = vehicle vehicle_getvelocity();
        between = math::anglebetweenvectors( forward, moving );
        
        if ( between < 45 )
        {
            skipdirection = "front";
        }
        else if ( between > 135 )
        {
            skipdirection = "back";
        }
    }
    
    exits = [];
    
    foreach ( ref, offset in data.exitoffsets )
    {
        dir = data.exitdirections[ ref ];
        
        if ( skipdirection == dir || dir == "dive" || dir == "roof" )
        {
            continue;
        }
        
        exit = { #origin:vehicle.origin + rotatevector( offset, vehicle.angles ), #dir:dir, #ref:ref };
        exits[ exits.size ] = exit;
    }
    
    exits = sortbydistance( exits, testpoint );
    exitboundinginfo = get_exit_info( vehicle );
    
    foreach ( exit in exits )
    {
        if ( exit.dir == "top" || exit.dir == "inside" )
        {
            continue;
        }
        
        position = get_exit_position( vehicle, player, exit.ref, exitboundinginfo, 1, allowcrouchexits );
        
        if ( isdefined( position ) )
        {
            position.direction = exit.dir;
            return position;
        }
    }
    
    foreach ( exit in exits )
    {
        if ( exit.dir != "top" && exit.dir != "inside" )
        {
            continue;
        }
        
        position = get_exit_position( vehicle, player, exit.ref, exitboundinginfo, 1, allowcrouchexits );
        
        if ( isdefined( position ) )
        {
            position.direction = exit.dir;
            return position;
        }
    }
    
    if ( getdvarint( @"hash_9c95c78d2efca328", 1 ) == 1 )
    {
        return get_emergency_exit( vehicle, player );
    }
}

// Namespace vehicle_occupancy
// Params 5
// Checksum 0xf1afa720, Offset: 0xb668
// Size: 0x32e
function move_player_to_exit( vehicle, seatid, newseatid, player, data )
{
    playerdeathexit = data.playerdeath && !data.playerlaststand && !data.playerliveragdoll && !data.var_51e28ecc5c1cbffd;
    
    if ( !isdefined( player ) || playerdeathexit || isdefined( newseatid ) || player.var_6bb95d5c412d3e98 )
    {
        if ( isdefined( player ) && !isdefined( newseatid ) )
        {
            get_out( player, vehicle, !isdefined( newseatid ) );
            player val::reset_all( "vehicle_roof_exit" );
            player val::reset_all( "vehicle_occupant_common" );
            player val::reset_all( "vehicle_occupant" );
            
            if ( seatid == "driver" )
            {
                player val::group_reset( "vehicle" );
            }
            else
            {
                player val::group_reset( "vehicle_passenger" );
            }
        }
        
        return 1;
    }
    
    movedexitposition = undefined;
    
    if ( isdefined( data.exitoffset ) )
    {
        movedexitposition = vehicle.origin + rotatevector( data.exitoffset, vehicle.angles );
    }
    
    if ( isdefined( movedexitposition ) && function_b41e409298199cf3( vehicle, player, movedexitposition ) )
    {
        exitposition = movedexitposition;
    }
    else
    {
        exitposition = data.exitposition;
    }
    
    if ( isdefined( exitposition ) )
    {
        if ( isdefined( data.specialexit ) )
        {
            if ( data.specialexit == "_to_roof" )
            {
                roof_exit( player, vehicle, seatid, data );
            }
            else
            {
                player function_2fc424070ee1794c();
                player leavevehicle( 0, 1 );
                player val::reset_all( "vehicle_roof_exit" );
                player val::reset_all( "vehicle_occupant_common" );
            }
        }
        else
        {
            get_out( player, vehicle, !isdefined( newseatid ) );
            
            if ( player.sessionstate != "spectator" )
            {
                player dontinterpolate();
                
                if ( data.exitdirection == "inside" || data.exitdirection == "top" )
                {
                    player function_b24bb8a9e05f54bc( exitposition, vehicle );
                }
                else
                {
                    player setorigin( exitposition, 1, 1 );
                }
                
                player setstance( data.iscrouchexit ? "crouch" : "stand" );
                
                /#
                    if ( level.debugvehicleexit )
                    {
                        drawframes = int( ceil( 60 / level.framedurationseconds ) );
                        utility::draw_capsule( exitposition, 15, 70, undefined, ( 1, 1, 0 ), undefined, drawframes );
                    }
                #/
                
                if ( isdefined( data.exitangles ) )
                {
                    player setplayerangles( data.exitangles );
                }
            }
            
            player val::reset_all( "vehicle_roof_exit" );
            player val::reset_all( "vehicle_occupant_common" );
        }
        
        return 1;
    }
    
    get_out( player, vehicle, !isdefined( newseatid ) );
    player val::reset_all( "vehicle_roof_exit" );
    player val::reset_all( "vehicle_occupant_common" );
    return 0;
}

// Namespace vehicle_occupancy
// Params 4, eflags: 0x4
// Checksum 0xe080c1e4, Offset: 0xb99e
// Size: 0x19e
function private roof_exit( player, vehicle, seatid, data )
{
    vehicleref = vehicle vehicle::get_ref();
    var_4925f33993c8d4db = get_data( vehicleref );
    
    if ( var_4925f33993c8d4db.roofexittype == "animated" )
    {
        finalposition = player function_e50a4c015224c4eb();
        
        if ( finalposition )
        {
            finalposition += ( 0, 0, 18 );
        }
        else
        {
            finalposition = vehicle.origin + rotatevector( var_4925f33993c8d4db.exitoffsets[ seatid + "_to_roof" ], vehicle.angles );
        }
    }
    else
    {
        offset = var_4925f33993c8d4db.exitoffsets[ seatid + "_to_roof" ];
        finalposition = vehicle.origin + rotatevector( offset, vehicle.angles );
    }
    
    get_out( player, vehicle, 1 );
    player thread vehicle_collision::function_e3bc60c772acd609( vehicle, player );
    stance = var_4925f33993c8d4db.roofexittype == "stand_up" ? "stand" : "crouch";
    
    if ( isbot( player ) )
    {
        player utility::callsharedfunc( #"bots", #"botsetstance", stance );
    }
    
    player setstance( stance, 1, 1, 1 );
    player dontinterpolate();
    player function_b24bb8a9e05f54bc( finalposition, vehicle );
    player val::reset_all( "vehicle_occupant_common" );
    player val::reset_all( "vehicle_roof_exit" );
}

/#

    // Namespace vehicle_occupancy
    // Params 2, eflags: 0x4
    // Checksum 0x9247272a, Offset: 0xbb44
    // Size: 0x64, Type: dev
    function private function_f9ba3136976d8b0f( startingposition, angles )
    {
        self notify( #"hash_ffa4791d77d03156" );
        self endon( #"hash_ffa4791d77d03156" );
        
        while ( true )
        {
            iprintlnbold( "<dev string:xe8b>" + rotatevector( self.origin - startingposition, angles ) - ( 0, 0, 18 ) );
            waitframe();
        }
    }

#/

// Namespace vehicle_occupancy
// Params 4, eflags: 0x4
// Checksum 0x17fa9022, Offset: 0xbbb0
// Size: 0x196
function private roof_exit_animation( player, vehicle, seatid, data )
{
    vehicleref = vehicle vehicle::get_ref();
    var_4925f33993c8d4db = get_data( vehicleref );
    
    if ( !isdefined( var_4925f33993c8d4db.roofexittype ) )
    {
        assertmsg( "<dev string:xf02>" );
        return;
    }
    
    driver = get_driver( vehicle );
    
    if ( driver == player )
    {
        vehicle thread function_d222aac7ad917141( 8000 );
    }
    
    if ( var_4925f33993c8d4db.roofexittype == "animated" )
    {
        player endon( #"death_or_disconnect" );
        player endon( #"last_stand_enter" );
        player endon( #"enter_live_ragdoll" );
        player endon( #"interrupt_roof_exit" );
        player endon( #"vehicle_roof_exit_collision_detected" );
        vehicle endon( #"death" );
        player val::set_array( "vehicle_roof_exit", [ "script_weapon_switch", "weapon_switch", "melee", "vehicle_seat_switch", "allow_movement" ], 0 );
        player function_858e4d19c2817326();
        endtime = gettime() + ( player isinvehicleleanout() ? level.var_8b0a26b04bac3108 : level.var_51db840a745c6105 );
        
        while ( !player function_2907aa812eda8a21() && gettime() < endtime )
        {
            waitframe();
        }
        
        while ( player function_2907aa812eda8a21() && gettime() < endtime )
        {
            waitframe();
        }
    }
    
    return 1;
}

// Namespace vehicle_occupancy
// Params 1, eflags: 0x4
// Checksum 0x925a7c8b, Offset: 0xbd4f
// Size: 0x157
function private function_d222aac7ad917141( time )
{
    if ( isdefined( self.vehicletype ) )
    {
        if ( self.vehicletype == "veh9_civ_lnd_dirt_bike_physics_mp" || self.vehicletype == "veh9_civ_lnd_motorcycle_cruiser_2008_physics_mp" || self.vehicletype == "veh9_civ_lnd_scooter_eu_physics_mp" )
        {
            return;
        }
    }
    
    self notify( #"hash_788a322c9905e04b" );
    self endon( #"hash_788a322c9905e04b" );
    
    if ( vehicle::is_moving_backwards() || self vehicle_getspeed() < 5 )
    {
        return;
    }
    
    self endon( #"death" );
    self.var_3fee62740baee02f = 1;
    self removecomponent( "player" );
    self addcomponent( "p2p" );
    maxspeed = self vehicle_getspeed();
    endtime = gettime() + time;
    
    while ( gettime() < endtime && self.var_3fee62740baee02f && self vehicle_getspeed() > 5 )
    {
        self setconfigvalue( "p2p", "manualSpeed", utility::mph_to_ips( min( maxspeed, self vehicle_getspeed() ) ) );
        self setconfigvalue( "p2p", "goalPoint", self.origin + anglestoforward( self.angles ) * 2000 );
        waitframe();
    }
    
    if ( !self.var_3fee62740baee02f )
    {
        return;
    }
    
    function_9afa8159255a47de();
}

// Namespace vehicle_occupancy
// Params 0, eflags: 0x4
// Checksum 0x2514b984, Offset: 0xbeae
// Size: 0x28
function private function_9afa8159255a47de()
{
    self.var_3fee62740baee02f = undefined;
    self setconfigvalue( "p2p", "manualSpeed", 0 );
    self removecomponent( "p2p" );
}

// Namespace vehicle_occupancy
// Params 1
// Checksum 0xc44bcc2, Offset: 0xbede
// Size: 0x1fc
function function_aabb37430ffe599( driverseatid )
{
    driver = get_seat_occupant( self, driverseatid );
    occupants = get_all_occupants( self );
    
    if ( isdefined( driver ) )
    {
        driverinput = driver getnormalizedmovement()[ 0 ];
        
        if ( abs( driverinput ) > 0.15 )
        {
            foreach ( occupant in occupants )
            {
                if ( occupant utility::callsharedfunc( #"player", #"playerisalive" ) )
                {
                    occupant function_19e78a15b22e4a8c();
                }
            }
        }
        else
        {
            foreach ( occupant in occupants )
            {
                if ( occupant utility::callsharedfunc( #"player", #"playerisalive" ) )
                {
                    occupant function_998629932390cbc4();
                }
            }
        }
        
        return;
    }
    
    if ( isdefined( occupants ) )
    {
        foreach ( occupant in occupants )
        {
            if ( occupant utility::callsharedfunc( #"player", #"playerisalive" ) )
            {
                occupant function_998629932390cbc4();
            }
        }
    }
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0xdf5d02fa, Offset: 0xc0e2
// Size: 0x2b
function function_19e78a15b22e4a8c()
{
    if ( self.vehiclemoveshakeenabled )
    {
        return;
    }
    
    self.vehiclemoveshakeenabled = 1;
    self setscriptablepartstate( "vehicleMoveShake", "active1", 0 );
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0x871051c5, Offset: 0xc115
// Size: 0x2b
function function_998629932390cbc4()
{
    if ( !self.vehiclemoveshakeenabled )
    {
        return;
    }
    
    self.vehiclemoveshakeenabled = undefined;
    self setscriptablepartstate( "vehicleMoveShake", "neutral", 0 );
}

// Namespace vehicle_occupancy
// Params 1
// Checksum 0x10a89b9b, Offset: 0xc148
// Size: 0x310
function update_damage_feedback( data )
{
    leveldataforvehicle = get_data( vehicle::get_ref() );
    
    if ( !isdefined( leveldataforvehicle ) )
    {
        return;
    }
    
    if ( self.isequipment )
    {
        return;
    }
    
    if ( !isdefined( data.damage ) || data.damage <= 0 )
    {
        return;
    }
    
    if ( !isdefined( data.meansofdeath ) )
    {
        return;
    }
    
    damagefeedbacktype = undefined;
    damagefeedbackgroup = undefined;
    
    switch ( data.meansofdeath )
    {
        case #"hash_571e46e17a3cf2e3":
        case #"hash_5f1054c48d66fd1c":
        case #"hash_66cb246f3e55fbe2":
        case #"hash_966768b3f0c94767":
        case #"hash_a86d8c43482948a4":
        case #"hash_c22b13f81bed11f0":
            damagefeedbacktype = "light";
            damagefeedbackgroup = leveldataforvehicle.damagefeedbackgrouplight;
            break;
        case #"hash_3c20f39c73a1422b":
        case #"hash_a911a1880d996edb":
        case #"hash_b1078ff213fddba6":
            damagefeedbacktype = "heavy";
            damagefeedbackgroup = leveldataforvehicle.damagefeedbackgroupheavy;
            break;
    }
    
    if ( !isdefined( damagefeedbacktype ) )
    {
        return;
    }
    
    if ( !isdefined( damagefeedbackgroup ) || damagefeedbackgroup == "none" )
    {
        return;
    }
    
    players = [];
    
    if ( damagefeedbackgroup == "driver" )
    {
        foreach ( seatid, leveldataforseat in leveldataforvehicle.seatdata )
        {
            if ( !isdefined( leveldataforseat.animtag ) )
            {
                continue;
            }
            
            if ( leveldataforseat.animtag == "tag_seat_0" || leveldataforseat.animtag == "offset_seat_0" )
            {
                players = [ get_seat_occupant( self, seatid ) ];
                break;
            }
        }
    }
    else if ( damagefeedbackgroup == "all" && instance_is_registered( self ) )
    {
        players = get_all_occupants( self );
    }
    
    if ( !isdefined( players ) || players.size == 0 )
    {
        return;
    }
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !player utility::callsharedfunc( #"player", #"playerisalive" ) )
        {
            continue;
        }
        
        if ( damagefeedbacktype == "light" )
        {
            player thread function_fd5e7a6f0d16c5d0();
            continue;
        }
        
        if ( damagefeedbacktype == "heavy" )
        {
            player thread function_5c6dde8258d14841();
        }
    }
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0x4c2d6e1f, Offset: 0xc460
// Size: 0x78
function function_fd5e7a6f0d16c5d0()
{
    self endon( #"disconnect" );
    self endon( #"vehicle_occupancy_clearlightdamagefeedbackplayer" );
    
    if ( !isdefined( self.vehiclelightdamagefeedbackid ) )
    {
        self.vehiclelightdamagefeedbackid = 1;
    }
    
    utility::function_7c10ea82c1e305b8( "vehicleDamageShakeLight", "active" + self.vehiclelightdamagefeedbackid );
    self.vehiclelightdamagefeedbackid = 1 + int( self.vehiclelightdamagefeedbackid + 1 ) % 3;
    wait 0.15;
    thread function_daef2fed719d68fa();
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0x1d2b0dd, Offset: 0xc4e0
// Size: 0x29
function function_daef2fed719d68fa()
{
    self notify( #"vehicle_occupancy_clearlightdamagefeedbackplayer" );
    utility::function_7c10ea82c1e305b8( "vehicleDamageShakeLight", "neutral" );
    self.vehiclelightdamagefeedbackid = undefined;
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0xb77dac19, Offset: 0xc511
// Size: 0x74
function function_5c6dde8258d14841()
{
    self endon( #"disconnect" );
    self endon( #"vehicle_occupancy_clearheavydamagefeedbackplayer" );
    
    if ( !isdefined( self.vehicleheavydamagefeedbackid ) )
    {
        self.vehicleheavydamagefeedbackid = 1;
    }
    
    utility::function_7c10ea82c1e305b8( "vehicleDamageShakeHeavy", "active" + self.vehicleheavydamagefeedbackid );
    self.vehicleheavydamagefeedbackid = 1 + ( self.vehicleheavydamagefeedbackid + 1 ) % 3;
    wait 0.3;
    thread function_520d22bfee929413();
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0xe211ae05, Offset: 0xc58d
// Size: 0x29
function function_520d22bfee929413()
{
    self notify( #"vehicle_occupancy_clearheavydamagefeedbackplayer" );
    utility::function_7c10ea82c1e305b8( "vehicleDamageShakeHeavy", "neutral" );
    self.vehicleheavydamagefeedbackid = undefined;
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0x3c83a0e3, Offset: 0xc5be
// Size: 0x10
function function_f2eda11ef5a74b2b()
{
    function_daef2fed719d68fa();
    function_520d22bfee929413();
}

// Namespace vehicle_occupancy
// Params 3
// Checksum 0x2b3d5b2, Offset: 0xc5d6
// Size: 0x13b
function give_turret( player, vehicle, objweapon )
{
    player endon( #"disconnect" );
    wasinvehicle = player isvehicleactive();
    get_out( player, vehicle );
    
    if ( wasinvehicle )
    {
        waitframe();
    }
    
    player val::set( "vehicle_turret", "unresolved_collisions", 0 );
    player val::set( "vehicle_turret", "vehicle_predictive_ragdoll", 0 );
    turret = vehicle::function_95e3c2e0c6eec800( vehicle, objweapon );
    turret.owner = player;
    turret setotherent( player );
    turret setentityowner( player );
    turret setsentryowner( player );
    player disableturretdismount();
    player utility::callsharedfunc( #"player", #"controlturreton", turret );
    
    if ( !player hasweapon( objweapon ) )
    {
        player utility::callsharedfunc( #"weapons", #"giveweapon", objweapon );
    }
    
    if ( !player utility::callsharedfunc( #"weapons", #"iscurrentweapon", objweapon ) )
    {
        player utility::callsharedfunc( #"weapons", #"domonitoredweaponswitch", objweapon, 1, 1 );
    }
}

// Namespace vehicle_occupancy
// Params 5
// Checksum 0x656e0195, Offset: 0xc719
// Size: 0x1e3
function take_turret( player, vehicle, objweapon, data, shouldtimeout )
{
    if ( isdefined( data.raceendon ) )
    {
        data endon( data.raceendon );
    }
    
    if ( shouldtimeout )
    {
        childthread function_8b04a89f7f3ac70e( data, 1.5 );
    }
    
    player val::reset_all( "vehicle_turret" );
    
    if ( player hasweapon( objweapon ) )
    {
        result = undefined;
        thread function_67dad5f8266910c6( player );
        
        if ( player utility::callsharedfunc( #"weapons", #"isswitchingtoweaponwithmonitoring", objweapon ) )
        {
            assert( player getcurrentweapon().basename != objweapon );
            player utility::callsharedfunc( #"weapons", #"abortmonitoredweaponswitch", makeweapon( objweapon ) );
            result = 1;
        }
        else
        {
            turret = vehicle::function_95e3c2e0c6eec800( vehicle, objweapon );
            
            if ( isdefined( turret ) )
            {
                player utility::callsharedfunc( #"player", #"controlturretoff", turret );
            }
            
            if ( player hasweapon( objweapon ) )
            {
                holdingweapon = player utility::callsharedfunc( #"weapons", #"iscurrentweapon", objweapon );
                
                if ( holdingweapon )
                {
                    player utility::callsharedfunc( #"weapons", #"takeweapon", objweapon );
                    player thread utility::callsharedfunc( #"weapons", #"forcevalidweapon" );
                }
                else
                {
                    player thread utility::callsharedfunc( #"weapons", #"getridofweapon", objweapon, 1 );
                }
            }
            
            result = 1;
        }
        
        if ( isdefined( result ) && !result )
        {
            data.success = 0;
            data notify( data.raceendnotify );
        }
    }
}

// Namespace vehicle_occupancy
// Params 2, eflags: 0x4
// Checksum 0xcc414c2a, Offset: 0xc904
// Size: 0x34
function private function_8b04a89f7f3ac70e( data, timeout )
{
    wait timeout;
    data.success = 0;
    data notify( data.raceendnotify );
}

// Namespace vehicle_occupancy
// Params 1, eflags: 0x4
// Checksum 0xa21cc9b4, Offset: 0xc940
// Size: 0x3a
function private function_67dad5f8266910c6( player )
{
    player notify( #"vehicle_occupancy_forceweaponswitchallowed" );
    
    if ( player val::get( "weapon_switch" ) )
    {
        player enableweaponswitch();
        return;
    }
    
    player disableweaponswitch();
}

// Namespace vehicle_occupancy
// Params 1
// Checksum 0xc66cadef, Offset: 0xc982
// Size: 0xe9
function eject_all_occupants( vehicle )
{
    if ( vehicle vehicle::is_husk() )
    {
        return;
    }
    
    seatids = function_8a8e1601e7e6610( vehicle );
    
    foreach ( seatid in seatids )
    {
        occupant = get_seat_occupant( vehicle, seatid );
        
        if ( isdefined( occupant ) )
        {
            thread vehicle_collision::function_e3bc60c772acd609( vehicle, occupant );
            data = { #exittype:"INVOLUNTARY", #allowairexit:1 };
            thread exit( vehicle, seatid, occupant, data, 1 );
        }
    }
}

// Namespace vehicle_occupancy
// Params 1
// Checksum 0x375d4c0f, Offset: 0xca73
// Size: 0x95
function function_37e523b895cca204( vehicle )
{
    vehicle.var_a8b1efefa07bcfb7 = 1;
    driver = get_driver( vehicle );
    
    if ( driver )
    {
        switchseatid = function_79f80964bb18e6c6( vehicle, driver, "driver" );
        
        if ( switchseatid )
        {
            thread enter( vehicle, switchseatid, driver );
            return;
        }
        
        data = { #exittype:"INVOLUNTARY", #allowairexit:1 };
        thread exit( vehicle, "driver", driver, data, 1 );
    }
}

// Namespace vehicle_occupancy
// Params 1
// Checksum 0xd7b81160, Offset: 0xcb10
// Size: 0xf7
function function_1dafc6cf543f6545( vehicle )
{
    if ( vehicle vehicle::is_husk() )
    {
        return;
    }
    
    seatids = function_8a8e1601e7e6610( vehicle );
    
    foreach ( seatid in seatids )
    {
        if ( seatid == "driver" )
        {
            continue;
        }
        
        occupant = get_seat_occupant( vehicle, seatid );
        
        if ( isdefined( occupant ) )
        {
            thread vehicle_collision::function_e3bc60c772acd609( vehicle, occupant );
            data = { #exittype:"INVOLUNTARY", #allowairexit:1 };
            thread exit( vehicle, seatid, occupant, data, 1 );
        }
    }
}

// Namespace vehicle_occupancy
// Params 5
// Checksum 0xa3390074, Offset: 0xcc0f
// Size: 0xe0
function function_d2642bca0c636233( vehicle, weapon, attachtag, model, skinoverride )
{
    turret = spawnturret( "misc_turret", vehicle gettagorigin( attachtag ), weapon, 0 );
    turret linkto( vehicle, attachtag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    
    if ( isdefined( skinoverride ) )
    {
        model = skinoverride + "::" + model;
    }
    
    turret setmodel( model );
    turret setmode( "sentry_offline" );
    turret setsentryowner( undefined );
    turret makeunusable();
    turret setdefaultdroppitch( 0 );
    turret setturretmodechangewait( 1 );
    turret.angles = vehicle.angles;
    turret.vehicle = vehicle;
    return turret;
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0x77efbbce, Offset: 0xccf8
// Size: 0x33
function reset_turret()
{
    self setmode( "sentry_offline" );
    self setsentryowner( undefined );
    self makeunusable();
    self setdefaultdroppitch( 0 );
    self setturretmodechangewait( 1 );
    self.gunner = undefined;
}

// Namespace vehicle_occupancy
// Params 4
// Checksum 0x7697db64, Offset: 0xcd33
// Size: 0x7d
function function_312f5bf4d47d6f47( vehicle, weaponname, normalraisetime, firstraisetime )
{
    raisetime = 0;
    
    if ( vehicle.playedfirstraise )
    {
        raisetime = normalraisetime ?? 850;
    }
    else
    {
        raisetime = firstraisetime ?? 2200;
    }
    
    level thread disable_fire_for_time( self, raisetime );
    thread give_turret( self, vehicle, weaponname );
    vehicle.playedfirstraise = 1;
}

// Namespace vehicle_occupancy
// Params 3
// Checksum 0x5e07bbb7, Offset: 0xcdb8
// Size: 0xb6
function function_3d4acb78f07de5d1( data, vehicle, weaponname )
{
    turret = vehicle::function_95e3c2e0c6eec800( vehicle, weaponname );
    
    if ( !data.playerdisconnect )
    {
        self enableturretdismount();
        utility::callsharedfunc( #"player", #"controlturretoff", turret );
        thread function_9d41e9434004ca0f( self, data.playerdeath );
        
        if ( !data.playerdeath )
        {
            thread take_turret( self, vehicle, weaponname, data, 1 );
        }
    }
    
    turret.owner = undefined;
    turret setotherent( undefined );
    turret setentityowner( undefined );
    turret setsentryowner( undefined );
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0xcfd37ca5, Offset: 0xce76
// Size: 0xb4
function get_occupant_restrictions()
{
    allows = [ "crouch", "prone", "sprint", "mantle", "mount_top", "mount_side", "vehicle_use", "vehicle_predictive_ragdoll", "crate_use", "ladder_placement", "execution_attack", "execution_victim" ];
    
    if ( !level.var_ebd0541e14d3b7c0 )
    {
        allows[ allows.size ] = "usability";
    }
    
    if ( getdvarint( @"hash_6c68604cd07d358", 0 ) == 1 )
    {
        allows[ allows.size ] = "offhand_weapons";
    }
    
    return allows;
}

// Namespace vehicle_occupancy
// Params 1
// Checksum 0x322c2d5f, Offset: 0xcf33
// Size: 0x20
function function_d166c9cd83969e0e( val = 1 )
{
    level.var_ebd0541e14d3b7c0 = val;
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0x57a79158, Offset: 0xcf5b
// Size: 0x39
function get_driver_restrictions()
{
    return [ "offhand_weapons", "fire", "reload", "autoreload", "weapon_switch", "cough_gesture" ];
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0x41a8444f, Offset: 0xcf9d
// Size: 0x30
function function_f02bc30b02f79356()
{
    return [ "offhand_weapons", "reload", "autoreload", "weapon_switch", "cough_gesture" ];
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0xeae8b6a3, Offset: 0xcfd6
// Size: 0x8
function function_64a3829f0655c0b0()
{
    return function_f02bc30b02f79356();
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0x890ed149, Offset: 0xcfe7
// Size: 0x8
function function_a3d537a4bea3e85e()
{
    return function_b8eb35c9e4ccc722();
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0xe8c8d3b7, Offset: 0xcff8
// Size: 0xc
function function_b8eb35c9e4ccc722()
{
    return [ "weapon_pickup" ];
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0x499d4691, Offset: 0xd00d
// Size: 0x8
function function_24cd2940c5b56fdb()
{
    return get_driver_restrictions();
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0xbbdfb292, Offset: 0xd01e
// Size: 0x30
function get_turret_passenger_restrictions()
{
    restrictions = function_b8eb35c9e4ccc722();
    restrictions[ restrictions.size ] = "cough_gesture";
    restrictions[ restrictions.size ] = "offhand_weapons";
    return arrayremoveduplicates( restrictions );
}

// Namespace vehicle_occupancy
// Params 3
// Checksum 0x95e35ff5, Offset: 0xd057
// Size: 0xc3
function disable_fire_for_time( player, timems, var_bca0c8468a20ab1c )
{
    player endon( #"disconnect" );
    player notify( #"vehicle_occupancy_disablefirefortime" );
    player endon( #"vehicle_occupancy_disablefirefortime" );
    
    if ( !self.vehicledisablefire )
    {
        player.vehicledisablefire = 1;
        player val::set( "vehicleDisableFire", "fire", 0 );
    }
    
    if ( !isdefined( player.vehicledisablefireendtime ) || !var_bca0c8468a20ab1c )
    {
        player.vehicledisablefireendtime = gettime() + timems;
    }
    
    while ( gettime() < player.vehicledisablefireendtime )
    {
        wait 0.05;
    }
    
    thread function_9d41e9434004ca0f( player );
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0x78b718bf, Offset: 0xd122
// Size: 0x5b
function function_9d41e9434004ca0f( player, fromdeath )
{
    player notify( #"vehicle_occupancy_disablefirefortime" );
    
    if ( isdefined( player.vehicledisablefire ) )
    {
        if ( !fromdeath )
        {
            player val::reset_all( "vehicleDisableFire" );
        }
    }
    
    player.vehicledisablefire = undefined;
    player.vehicledisablefireendtime = undefined;
}

// Namespace vehicle_occupancy
// Params 3
// Checksum 0x957fd43e, Offset: 0xd185
// Size: 0x58
function take_riot_shield( player, vehicle, newseatid )
{
    if ( utility::issharedfuncdefined( #"vehicle_occupancy", #"takeriotshield" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_occupancy", #"takeriotshield" ) ]]( player, vehicle, newseatid );
    }
}

// Namespace vehicle_occupancy
// Params 3
// Checksum 0x4451dee2, Offset: 0xd1e5
// Size: 0x58
function give_riot_shield( player, fromdeath, fromlaststand )
{
    if ( utility::issharedfuncdefined( #"vehicle_occupancy", #"giveriotshield" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_occupancy", #"giveriotshield" ) ]]( player, fromdeath, fromlaststand );
    }
}

// Namespace vehicle_occupancy
// Params 3
// Checksum 0x81f8ddfe, Offset: 0xd245
// Size: 0x58
function update_riot_shield( player, vehicle, newseatid )
{
    if ( utility::issharedfuncdefined( #"vehicle_occupancy", #"updateRiotShield" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_occupancy", #"updateRiotShield" ) ]]( player, vehicle, newseatid );
    }
}

// Namespace vehicle_occupancy
// Params 4
// Checksum 0xf93ba999, Offset: 0xd2a5
// Size: 0x63
function function_702b50a45a0bb141( vehicle, seatid, player, data )
{
    if ( utility::issharedfuncdefined( #"vehicle_occupancy", #"hideCashBag" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_occupancy", #"hideCashBag" ) ]]( vehicle, seatid, player, data );
    }
}

// Namespace vehicle_occupancy
// Params 4
// Checksum 0x312a2a1e, Offset: 0xd310
// Size: 0x63
function function_91c2eed4926ac7c6( vehicle, seatid, player, data )
{
    if ( utility::issharedfuncdefined( #"vehicle_occupancy", #"showcashbag" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_occupancy", #"showcashbag" ) ]]( vehicle, seatid, player, data );
    }
}

// Namespace vehicle_occupancy
// Params 1, eflags: 0x4
// Checksum 0xe966ece8, Offset: 0xd37b
// Size: 0x55
function private register_sentient( vehicle )
{
    if ( vehicle.sentientdisabled > 0 )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"vehicle_occupancy", #"registersentient" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_occupancy", #"registersentient" ) ]]( vehicle );
    }
}

// Namespace vehicle_occupancy
// Params 1, eflags: 0x4
// Checksum 0x18c1c6e0, Offset: 0xd3d8
// Size: 0x44
function private unregister_sentient( vehicle )
{
    if ( utility::issharedfuncdefined( #"vehicle_occupancy", #"unregistersentient" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_occupancy", #"unregistersentient" ) ]]( vehicle );
    }
}

// Namespace vehicle_occupancy
// Params 1
// Checksum 0xdc622f84, Offset: 0xd424
// Size: 0x44
function is_sentient( vehicle )
{
    if ( utility::issharedfuncdefined( #"vehicle_occupancy", #"issentient" ) )
    {
        return [[ utility::getsharedfunc( #"vehicle_occupancy", #"issentient" ) ]]( vehicle );
    }
}

// Namespace vehicle_occupancy
// Params 1
// Checksum 0xb82df46e, Offset: 0xd470
// Size: 0x8a
function allow_sentient( bool )
{
    if ( bool )
    {
        if ( self.sentientdisabled > 0 )
        {
            self.sentientdisabled--;
        }
        else
        {
            assertmsg( "<dev string:xf3e>" );
            return;
        }
        
        if ( self.sentientdisabled == 0 )
        {
            register_sentient( self );
        }
        
        return;
    }
    
    if ( !isdefined( self.sentientdisabled ) )
    {
        self.sentientdisabled = 0;
    }
    
    self.sentientdisabled++;
    
    if ( self.sentientdisabled == 1 )
    {
        unregister_sentient( self );
    }
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0x956d501c, Offset: 0xd502
// Size: 0xee
function function_3fdb556dfc812f8( vehicle, var_a0fc3fce2a67081a )
{
    linktooriginandangles = spawnstruct();
    
    if ( vehicle tagexists( var_a0fc3fce2a67081a ) )
    {
        linktooriginandangles.origin = vehicle gettagorigin( var_a0fc3fce2a67081a );
        linktooriginandangles.angles = vehicle gettagangles( var_a0fc3fce2a67081a );
    }
    else
    {
        leveldataforseat = function_568cd324ac705619( vehicle vehicle::get_ref(), var_a0fc3fce2a67081a );
        
        if ( isdefined( leveldataforseat.animtag ) )
        {
            linktooriginandangles.origin = vehicle gettagorigin( leveldataforseat.animtag );
            linktooriginandangles.angles = vehicle gettagangles( leveldataforseat.animtag );
        }
        else
        {
            linktooriginandangles.origin = vehicle.origin;
            linktooriginandangles.angles = vehicle.angles;
        }
    }
    
    return linktooriginandangles;
}

// Namespace vehicle_occupancy
// Params 3
// Checksum 0xb4e1fa1b, Offset: 0xd5f9
// Size: 0x92
function function_e1a19a7a2a793b7f( corpse, vehicle, var_a0fc3fce2a67081a )
{
    if ( vehicle tagexists( var_a0fc3fce2a67081a ) )
    {
        corpse enablelinkto();
        corpse linkto( vehicle, var_a0fc3fce2a67081a );
        return;
    }
    
    leveldataforseat = function_568cd324ac705619( vehicle vehicle::get_ref(), var_a0fc3fce2a67081a );
    
    if ( isdefined( leveldataforseat.animtag ) )
    {
        corpse enablelinkto();
        corpse linkto( vehicle, leveldataforseat.animtag );
        return;
    }
    
    corpse enablelinkto();
    corpse linkto( vehicle );
}

// Namespace vehicle_occupancy
// Params 4
// Checksum 0xadf83a94, Offset: 0xd693
// Size: 0x8a
function function_7730eb57fd31aeea( corpse, vehicle, var_a0fc3fce2a67081a, deleteonseatenter )
{
    assert( !vehicle.isdestroyed, "<dev string:xfa7>" );
    
    if ( !isdefined( vehicle.corpses ) )
    {
        vehicle.corpses = [];
    }
    
    function_4793dd4d02d6e68c( vehicle, var_a0fc3fce2a67081a, 0 );
    vehicle.corpses[ var_a0fc3fce2a67081a ] = corpse;
    
    if ( !deleteonseatenter )
    {
        corpse.dontdeleteonseatenter = 1;
    }
}

// Namespace vehicle_occupancy
// Params 3
// Checksum 0x2cd37e93, Offset: 0xd725
// Size: 0x49
function function_e0dab587ee188096( corpse, vehicle, var_a0fc3fce2a67081a )
{
    if ( isdefined( vehicle.corpses[ var_a0fc3fce2a67081a ] ) )
    {
        vehicle.corpses[ var_a0fc3fce2a67081a ] = undefined;
    }
    
    corpse.dontdeleteonseatenter = undefined;
}

// Namespace vehicle_occupancy
// Params 3
// Checksum 0x227bf0fd, Offset: 0xd776
// Size: 0x87
function function_4793dd4d02d6e68c( vehicle, var_a0fc3fce2a67081a, var_7e0124fcc9f427af )
{
    if ( isdefined( vehicle.corpses[ var_a0fc3fce2a67081a ] ) )
    {
        corpse = vehicle.corpses[ var_a0fc3fce2a67081a ];
        
        if ( isdefined( corpse ) )
        {
            if ( !corpse.dontdeleteonseatenter || !var_7e0124fcc9f427af )
            {
                vehicle.corpses[ var_a0fc3fce2a67081a ] delete();
                vehicle.corpses[ var_a0fc3fce2a67081a ] = undefined;
            }
        }
    }
}

// Namespace vehicle_occupancy
// Params 1
// Checksum 0x71a8c8a8, Offset: 0xd805
// Size: 0x120
function function_4116af5d3e9e02cd( vehicle )
{
    if ( isdefined( vehicle.corpses ) )
    {
        foreach ( corpse in vehicle.corpses )
        {
            if ( isdefined( corpse ) )
            {
                corpse delete();
            }
        }
    }
    
    vehicle.corpses = undefined;
    
    foreach ( ent in vehicle getlinkedchildren() )
    {
        if ( isactorcorpse( ent ) )
        {
            ent delete();
        }
    }
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0xd3bdbff5, Offset: 0xd92d
// Size: 0x9c
function function_6d9760c4971403c2( vehicle, bool )
{
    if ( vehicle.isdestroyed || !isdefined( vehicle.occupants ) )
    {
        vehicle.preventspawninto = undefined;
        return;
    }
    
    if ( bool )
    {
        if ( vehicle.preventspawninto > 0 )
        {
            vehicle.preventspawninto--;
        }
        else
        {
            assertmsg( "<dev string:xff2>" );
            return;
        }
        
        return;
    }
    
    if ( !isdefined( vehicle.preventspawninto ) )
    {
        vehicle.preventspawninto = 0;
    }
    
    vehicle.preventspawninto++;
}

// Namespace vehicle_occupancy
// Params 1
// Checksum 0xcbde461b, Offset: 0xd9d1
// Size: 0x41, Type: bool
function can_spawn_into( vehicle )
{
    if ( vehicle.isdestroyed || !isdefined( vehicle.occupants ) )
    {
        return false;
    }
    
    if ( vehicle.preventspawninto > 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0xd72c099c, Offset: 0xda1b
// Size: 0x8c
function function_7b5a0eb785dba6d2( seatid, seatidarr )
{
    assert( arraycontains( seatidarr, seatid ), "<dev string:x105f>" );
    seatswitcharr = [];
    foundseatid = 0;
    
    for ( i = 0; true ; i++ )
    {
        if ( !foundseatid )
        {
            if ( seatid == seatidarr[ i ] )
            {
                foundseatid = 1;
            }
            
            continue;
        }
        
        i %= seatidarr.size;
        
        if ( seatid == seatidarr[ i ] )
        {
            break;
        }
        
        seatswitcharr[ seatswitcharr.size ] = seatidarr[ i ];
    }
    
    return seatswitcharr;
}

// Namespace vehicle_occupancy
// Params 3
// Checksum 0x477721cb, Offset: 0xdab0
// Size: 0x2f3
function kill_occupants( vehicle, damagedata, exitdata )
{
    function_4116af5d3e9e02cd( vehicle );
    
    if ( !vehicle vehicle::is_vehicle() || !instance_is_registered( vehicle ) )
    {
        return;
    }
    
    if ( !isdefined( damagedata.inflictor ) && isdefined( damagedata.meansofdeath ) )
    {
        switch ( damagedata.meansofdeath )
        {
            case #"hash_3c20f39c73a1422b":
            case #"hash_571e46e17a3cf2e3":
            case #"hash_66cb246f3e55fbe2":
            case #"hash_c22b13f81bed11f0":
                if ( isdefined( vehicle.killcament ) )
                {
                    vehicle.killcament delete();
                }
                
                vehicle.killcament = damagedata.inflictor;
                damagedata.inflictor = vehicle;
                break;
        }
    }
    
    if ( isdefined( damagedata ) && !isdefined( damagedata.inflictor ) )
    {
        damagedata.inflictor = undefined;
    }
    
    seatids = function_8a8e1601e7e6610( vehicle, 0 );
    
    if ( !isdefined( seatids ) )
    {
        return;
    }
    
    meansofdeath = damagedata.meansofdeath ?? "MOD_EXPLOSIVE";
    
    if ( meansofdeath == "MOD_PROJECTILE" )
    {
        meansofdeath = "MOD_PROJECTILE_SPLASH";
    }
    else if ( meansofdeath == "MOD_GRENADE" )
    {
        meansofdeath = "MOD_GRENADE_SPLASH";
    }
    
    foreach ( seatid in seatids )
    {
        occupant = get_seat_occupant( vehicle, seatid );
        
        if ( isdefined( occupant ) )
        {
            curattacker = damagedata.attacker;
            
            if ( !isdefined( curattacker ) || !utility::callsharedfunc( #"player", #"playersareenemies", curattacker, occupant ) )
            {
                curattacker = occupant;
            }
            
            occupant.donotmodifydamage = 1;
            var_27df2a3c3c4a1852 = 0;
            
            if ( isbrgamemode() && occupant.isjuggernaut )
            {
                if ( occupant.health > occupant.juggcontext.juggconfig.vehiclecankillhealth )
                {
                    var_27df2a3c3c4a1852 = 1;
                }
            }
            
            if ( !var_27df2a3c3c4a1852 && occupant utility::callsharedfunc( #"player", #"playerisalive" ) )
            {
                occupant thread function_5802afe15314e237( vehicle, curattacker, damagedata, meansofdeath );
                
                if ( isdefined( level.vehicleoccupantdeathcustomcallback ) )
                {
                    occupant thread [[ level.vehicleoccupantdeathcustomcallback ]]();
                }
            }
            
            occupant.donotmodifydamage = undefined;
            thread exit( vehicle, seatid, occupant, exitdata, 1 );
        }
    }
}

// Namespace vehicle_occupancy
// Params 4, eflags: 0x4
// Checksum 0x7c058d48, Offset: 0xddab
// Size: 0xd8
function private function_5802afe15314e237( vehicle, curattacker, damagedata, meansofdeath )
{
    self endon( #"death_or_disconnect" );
    origin = vehicle.origin;
    
    while ( self isvehicleactive() )
    {
        waitframe();
    }
    
    attacker = damagedata.attacker;
    inflictor = damagedata.inflictor;
    
    if ( !isdefined( attacker ) )
    {
        attacker = self.burndownattacker ?? self;
    }
    
    if ( !isdefined( attacker ) )
    {
        if ( isdefined( vehicle ) )
        {
            attacker = vehicle;
        }
        else
        {
            attacker = self;
        }
    }
    
    if ( !isdefined( inflictor ) )
    {
        inflictor = self;
    }
    
    self dodamage( self.maxhealth, origin, attacker, inflictor, meansofdeath, damagedata.objweapon, "torso_upper" );
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0x8295c257, Offset: 0xde8b
// Size: 0x47e
function watch_riding( var_6aaf6e51f47e0df0, var_4594166c803842b9 )
{
    self notify( #"hash_e6db6e9bebd309e8" );
    self endon( #"hash_e6db6e9bebd309e8" );
    self endon( #"death" );
    ref = vehicle::get_ref();
    self.onEndRiding = var_4594166c803842b9;
    onStartRiding = var_6aaf6e51f47e0df0 ?? utility::getsharedfunc( ref, #"onStartRiding" );
    onEndRiding = var_4594166c803842b9 ?? utility::getsharedfunc( ref, #"onEndRiding" );
    isInInterior = utility::getsharedfunc( ref, #"isInInterior" );
    onEnterInterior = utility::getsharedfunc( ref, #"onEnterInterior" );
    onExitInterior = utility::getsharedfunc( ref, #"onExitInterior" );
    hasinterior = isdefined( isInInterior );
    self.ridingplayers = [];
    prevonground = self vehicle_isonground();
    
    while ( true )
    {
        onground = self vehicle_isonground();
        validridingplayers = [];
        
        foreach ( player in utility::playersnear( self.origin, 550 ) )
        {
            if ( isdefined( player ) && isdefined( player.guid ) && player utility::callsharedfunc( #"player", #"playerisalive" ) && !player isvehicleactive() && function_dbf7952d671b64c( player, self ) && ( !is_below_vehicle( player.origin ) || player ishanging() || player ismantling() ) )
            {
                validridingplayers[ player.guid ] = 1;
                
                if ( !isdefined( self.ridingplayers[ player.guid ] ) )
                {
                    self.ridingplayers[ player.guid ] = player;
                    [[ onStartRiding ]]( player );
                    
                    if ( !onground )
                    {
                        player function_19e78a15b22e4a8c();
                    }
                }
                
                if ( hasinterior )
                {
                    ininterior = [[ isInInterior ]]( player );
                    
                    if ( !player.var_ee5e928d943532a4 && ininterior )
                    {
                        [[ onEnterInterior ]]( player );
                    }
                    else if ( player.var_ee5e928d943532a4 && !ininterior )
                    {
                        [[ onExitInterior ]]( player );
                    }
                    
                    player.var_ee5e928d943532a4 = ininterior;
                }
            }
        }
        
        foreach ( guid, player in self.ridingplayers )
        {
            if ( !validridingplayers[ guid ] )
            {
                self.ridingplayers[ guid ] = undefined;
                [[ onEndRiding ]]( player );
                
                if ( isdefined( player ) )
                {
                    player function_998629932390cbc4();
                }
                
                if ( hasinterior )
                {
                    if ( player.var_ee5e928d943532a4 )
                    {
                        [[ onExitInterior ]]( player );
                    }
                    
                    if ( isdefined( player ) )
                    {
                        player.var_ee5e928d943532a4 = undefined;
                    }
                }
            }
        }
        
        if ( onground != prevonground )
        {
            if ( !onground )
            {
                foreach ( player in self.ridingplayers )
                {
                    player function_19e78a15b22e4a8c();
                }
            }
            else
            {
                foreach ( player in self.ridingplayers )
                {
                    player function_998629932390cbc4();
                }
            }
        }
        
        prevonground = onground;
        wait 0.25;
    }
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0x330f38c0, Offset: 0xe311
// Size: 0x71, Type: bool
function function_dbf7952d671b64c( player, vehicleplatform )
{
    if ( isdefined( vehicleplatform ) && vehicleplatform vehicle::is_vehicle() )
    {
        playerplatform = function_bfb3bb62a0e41e66( player );
        
        if ( playerplatform == vehicleplatform )
        {
            return true;
        }
    }
    
    playerplatformparent = player getmovingplatformparent();
    
    if ( isdefined( vehicleplatform ) && playerplatformparent == vehicleplatform.e_navmesh )
    {
        return true;
    }
    
    return false;
}

// Namespace vehicle_occupancy
// Params 1
// Checksum 0xc57cb559, Offset: 0xe38b
// Size: 0x58
function function_bfb3bb62a0e41e66( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    vehicleplatform = player getmovingplatformparent();
    var_9afee6fc5874bbdf = function_e960790b424f8b5a( player );
    
    if ( isdefined( var_9afee6fc5874bbdf ) )
    {
        vehicleplatform = var_9afee6fc5874bbdf;
    }
    
    if ( isdefined( vehicleplatform ) && !vehicleplatform vehicle::is_vehicle() )
    {
        return;
    }
    
    return vehicleplatform;
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0x63250ea1, Offset: 0xe3ec
// Size: 0x46
function function_d95c5411816227d7( player, vehicle )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( isdefined( vehicle ) && vehicle vehicle::is_vehicle() )
    {
        player.var_c36ea1f016ec4571 = vehicle;
        player thread function_5fc0961df3cdc5a6();
    }
}

// Namespace vehicle_occupancy
// Params 0, eflags: 0x4
// Checksum 0x98edb07e, Offset: 0xe43a
// Size: 0x3d
function private function_5fc0961df3cdc5a6()
{
    self endon( #"disconnect" );
    self endon( #"disabled_force_ride" );
    level endon( #"game_ended" );
    self waittill( #"death" );
    self.var_c36ea1f016ec4571 = undefined;
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0xad1bae36, Offset: 0xe47f
// Size: 0x7f
function function_1ad9f175c154a56e( player, vehicle )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( isdefined( vehicle ) && vehicle vehicle::is_vehicle() )
    {
        if ( player utility::callsharedfunc( #"player", #"playerisalive" ) )
        {
            player dontinterpolate();
            player function_b24bb8a9e05f54bc( player.origin, vehicle );
            player notify( #"disabled_force_ride" );
        }
    }
    
    player.var_c36ea1f016ec4571 = undefined;
}

// Namespace vehicle_occupancy
// Params 1, eflags: 0x4
// Checksum 0x5ed6ba09, Offset: 0xe506
// Size: 0x1f
function private function_e960790b424f8b5a( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    return player.var_c36ea1f016ec4571;
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0x1bcd376a, Offset: 0xe52e
// Size: 0xc, Type: bool
function is_engine_disabled()
{
    return isdefined( self.enginedisabled );
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0x6f2a5d60, Offset: 0xe543
// Size: 0x55
function enable_engine()
{
    if ( !isdefined( self.enginedisabled ) )
    {
        assert( isdefined( self.enginedisabled ), "<dev string:x107e>" );
        return;
    }
    
    self.enginedisabled -= 1;
    
    if ( self.enginedisabled <= 0 )
    {
        self.enginedisabled = undefined;
    }
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0x79915cd4, Offset: 0xe5a0
// Size: 0x34
function disable_engine()
{
    if ( !isdefined( self.enginedisabled ) )
    {
        self.enginedisabled = 0;
    }
    
    self.enginedisabled += 1;
    turn_engine_off();
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0xf5d01eba, Offset: 0xe5dc
// Size: 0x30
function turn_engine_on()
{
    if ( !is_engine_disabled() )
    {
        if ( !vehicle::is_static() )
        {
            self vehicle_turnengineon();
            self.var_2d11ca7423079960 = gettime();
        }
        
        vehicle_interact::function_867ea9d5b4458d20();
    }
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0xb5a33efa, Offset: 0xe614
// Size: 0x26
function turn_engine_off()
{
    if ( !vehicle::is_static() )
    {
        self vehicle_turnengineoff();
        self.var_a7fd2a4165cc431a = gettime();
    }
    
    vehicle_interact::function_e3ff6fb751c623a();
}

// Namespace vehicle_occupancy
// Params 1
// Checksum 0x4d4082b3, Offset: 0xe642
// Size: 0xf1, Type: bool
function function_6b3a6137e14e34e2( point )
{
    if ( !function_63c6c86801e0685c() )
    {
        return false;
    }
    
    localorigin = coordtransformtranspose( point, self.origin, self.angles );
    leveldataforvehicle = get_data( vehicle::get_ref() );
    return localorigin[ 0 ] > leveldataforvehicle.exitextents[ "back" ] * -1 && localorigin[ 0 ] < leveldataforvehicle.exitextents[ "front" ] && localorigin[ 1 ] > leveldataforvehicle.exitextents[ "left" ] * -1 && localorigin[ 1 ] < leveldataforvehicle.exitextents[ "right" ] && localorigin[ 2 ] > leveldataforvehicle.exitextents[ "bottom" ] * -1 && localorigin[ 2 ] < leveldataforvehicle.exitextents[ "top" ];
}

// Namespace vehicle_occupancy
// Params 1
// Checksum 0xc24dbefa, Offset: 0xe73c
// Size: 0x6b, Type: bool
function is_below_vehicle( point )
{
    if ( !function_63c6c86801e0685c() )
    {
        return false;
    }
    
    localorigin = coordtransformtranspose( point, self.origin, self.angles );
    leveldataforvehicle = get_data( vehicle::get_ref() );
    return localorigin[ 2 ] < leveldataforvehicle.exitextents[ "bottom" ] * -1;
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0xe60c2d7, Offset: 0xe7b0
// Size: 0x52
function function_86526639bb87c4e4()
{
    self endon( #"death" );
    vehicle_omnvar::function_8de48e050dcfaef7();
    
    while ( true )
    {
        message = utility::waittill_any_return( "vehicle_turret_fire", "vehicle_turret_reload_end" );
        
        if ( message == "vehicle_turret_fire" )
        {
            tank_turret_dust_kickup();
        }
        
        vehicle_omnvar::function_8de48e050dcfaef7();
    }
}

// Namespace vehicle_occupancy
// Params 0
// Checksum 0xb71afa1a, Offset: 0xe80a
// Size: 0x95
function function_ef6e3c7eeb60277c()
{
    self endon( #"death" );
    shockwaveexplosion = vehicle::get_data( vehicle::get_ref() ).tank.var_11b9d22b526a5019;
    
    while ( true )
    {
        self waittill( #"vehicle_turret_fire", turretindex, param2, projectile );
        
        if ( turretindex == 0 )
        {
            driver = get_seat_occupant( self, "driver" );
            projectile thread function_9b9a47a28dae2ec8( driver, shockwaveexplosion );
        }
    }
}

// Namespace vehicle_occupancy
// Params 2, eflags: 0x4
// Checksum 0x9e6054cf, Offset: 0xe8a7
// Size: 0x9f
function private function_9b9a47a28dae2ec8( driver, shockwaveexplosion )
{
    level endon( #"game_ended" );
    self waittill( #"explode", position );
    
    if ( shockwaveexplosion )
    {
        utility::function_ce86ddbb7d60e9bd( position, shockwaveexplosion );
    }
    
    if ( !isdefined( driver ) )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"spawn", #"addSpawnInfluencer" ) )
    {
        [[ utility::getsharedfunc( #"spawn", #"addSpawnInfluencer" ) ]]( #"hash_eafb9a6b88def4ca", position, driver.team, driver );
    }
}

// Namespace vehicle_occupancy
// Params 0, eflags: 0x4
// Checksum 0x5bf0d896, Offset: 0xe94e
// Size: 0x17b
function private tank_turret_dust_kickup()
{
    fxname = isxhashasset( vehicle::get_ref() ) ? hashcat( vehicle::get_ref(), "_cannon_dust" ) : vehicle::get_ref() + "_cannon_dust";
    
    if ( !utility::fxexists( fxname ) )
    {
        return;
    }
    
    contents = physics_createcontents( [ "physicscontents_itemclip", "physicscontents_water", "physicscontents_glass", "physicscontents_item" ] );
    ignorelist = self getlinkedchildren();
    
    if ( !isdefined( ignorelist ) )
    {
        ignorelist = [];
    }
    
    ignorelist[ ignorelist.size ] = self;
    caststart = self gettagorigin( "tag_flash" );
    castend = caststart + ( 0, 0, 1 ) * -200;
    castresults = physics_raycast( caststart, castend, contents, ignorelist, 0, "physicsquery_closest", 1 );
    
    if ( !isdefined( castresults ) || !castresults.size )
    {
        return;
    }
    
    forward = anglestoforward( self gettagangles( "tag_flash" ) * ( 0, 1, 0 ) );
    up = castresults[ 0 ][ "normal" ];
    right = vectorcross( forward, up );
    up = vectorcross( right, forward );
    angles = axistoangles( forward, right, up );
    playfx( utility::getfx( fxname ), castresults[ 0 ][ "position" ], anglestoforward( angles ), anglestoup( angles ) );
}

// Namespace vehicle_occupancy
// Params 1
// Checksum 0xbe3d5018, Offset: 0xead1
// Size: 0x23c
function function_6cb37d47153b2285( driver )
{
    self endon( #"death" );
    driverturret = function_c1aff67bba66f89f( vehicle::get_ref(), "driver" );
    var_792e7767ece74ff = get_data( vehicle::get_ref() ).var_123315e202afa466;
    
    if ( !isdefined( driver ) )
    {
        return;
    }
    
    if ( !isdefined( driverturret ) )
    {
        return;
    }
    
    vehicle_omnvar::function_8de48e050dcfaef7();
    driver endon( #"vehicle_change_seat" );
    driver endon( #"vehicle_seat_exit" );
    driver endon( #"death_or_disconnect" );
    
    while ( driver reloadbuttonpressed() && var_792e7767ece74ff && self function_4a982264b67c1076() > 0 )
    {
        waitframe();
    }
    
    var_5190ffaf44fe09df = getdvarint( @"hash_9402582f8123db99", 250 ) / 1000;
    
    while ( true )
    {
        holdtime = 0;
        reloadstarted = 0;
        isgamepad = driver usinggamepad();
        
        while ( driver reloadbuttonpressed() || self function_4a982264b67c1076() == 0 )
        {
            info = weapon::function_e418c15787e60727( driver, 1, function_a029c377aa2a0c46( self, driver ), function_ec25b7cd78651ae5( self ) );
            var_aa6e765352034cea = info.var_ccdc123013cfa167;
            var_8942c9b26785365c = info.var_d9982fb23eaa73df;
            
            if ( var_aa6e765352034cea && ( !isgamepad && self function_4a982264b67c1076() < weaponclipsize( driverturret ) || var_792e7767ece74ff && self function_4a982264b67c1076() == 0 ) )
            {
                self function_4f6f504106e6aaf6();
                reloadstarted = 1;
                vehicle_omnvar::function_8de48e050dcfaef7();
                break;
            }
            
            if ( self function_4a982264b67c1076() < weaponclipsize( driverturret ) && var_8942c9b26785365c && holdtime >= var_5190ffaf44fe09df )
            {
                self function_4f6f504106e6aaf6();
                reloadstarted = 1;
                vehicle_omnvar::function_8de48e050dcfaef7();
            }
            
            holdtime += level.framedurationseconds;
            waitframe();
        }
        
        if ( !reloadstarted && isgamepad && self function_4a982264b67c1076() < weaponclipsize( driverturret ) && ( var_aa6e765352034cea && holdtime > 0 && holdtime < 0.2 || var_8942c9b26785365c && holdtime >= var_5190ffaf44fe09df ) )
        {
            self function_4f6f504106e6aaf6();
            vehicle_omnvar::function_8de48e050dcfaef7();
        }
        
        waitframe();
    }
}

// Namespace vehicle_occupancy
// Params 2
// Checksum 0xc0d59c46, Offset: 0xed15
// Size: 0x141
function monitor_occupant_submix( player, seatid )
{
    data = vehicle::get_data( vehicle::get_ref() );
    
    if ( !data.occupancy.var_9bcebac312d0c8d8 || !soundsubmixexists( data.occupancy.var_9bcebac312d0c8d8 ) )
    {
        return;
    }
    
    submix = data.occupancy.var_9bcebac312d0c8d8;
    seatdata = function_568cd324ac705619( vehicle::get_ref(), seatid );
    isdriverseat = is_driver_seat( self, seatid );
    
    if ( isdefined( seatdata.turretobjweapon ) && !isdriverseat )
    {
        if ( player.occupantsubmix )
        {
            function_cecc0376fcd40c5e( player, player.occupantsubmix );
        }
        
        return;
    }
    
    player endon( #"vehicle_seat_exit" );
    
    while ( true )
    {
        if ( !player.occupantsubmix )
        {
            function_4828453e80529079( player, submix );
        }
        
        player waittill( #"vehicle_leanout_begin" );
        function_cecc0376fcd40c5e( player, submix );
        player utility::waittill_any( "vehicle_leanout_end", "vehicle_leanout_forced_return" );
    }
}

// Namespace vehicle_occupancy
// Params 2, eflags: 0x4
// Checksum 0x56ed74a3, Offset: 0xee5e
// Size: 0x2c
function private function_4828453e80529079( player, submix )
{
    player.occupantsubmix = submix;
    player function_76780be6bf0498e0( player, submix );
}

// Namespace vehicle_occupancy
// Params 2, eflags: 0x4
// Checksum 0xe4622b37, Offset: 0xee92
// Size: 0x2c
function private function_cecc0376fcd40c5e( player, submix )
{
    player.occupantsubmix = undefined;
    player clearentitysoundsubmix( player, submix, undefined, 1 );
}

// Namespace vehicle_occupancy
// Params 0, eflags: 0x4
// Checksum 0xebf32905, Offset: 0xeec6
// Size: 0x2b
function private init_debug()
{
    leveldata = get_level_data();
    leveldata.debuginstances = [];
    
    /#
        thread monitor_debug();
    #/
}

/#

    // Namespace vehicle_occupancy
    // Params 0, eflags: 0x4
    // Checksum 0x304016dc, Offset: 0xeef9
    // Size: 0x348, Type: dev
    function private monitor_debug()
    {
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        leveldata = get_level_data();
        wait 5;
        setdevdvarifuninitialized( @"hash_2de891db9eeac685", 0 );
        setdevdvarifuninitialized( @"hash_6c296dda80496851", 0 );
        setdevdvarifuninitialized( @"hash_fdf60fe90077b559", 0 );
        setdevdvarifuninitialized( @"hash_a864c803709b59ce", 0 );
        
        while ( true )
        {
            if ( getdvarint( @"scr_debugvehicleexit", 0 ) > 0 )
            {
                level.debugvehicleexit = 1;
            }
            else
            {
                level.debugvehicleexit = undefined;
            }
            
            foreach ( vehicle in leveldata.debuginstances )
            {
                if ( !isdefined( vehicle ) )
                {
                    continue;
                }
                
                if ( level.debugvehicleexit )
                {
                    get_exit_info( vehicle, 1 );
                }
            }
            
            host = undefined;
            
            if ( utility::issharedfuncdefined( #"game", #"gethostplayer" ) )
            {
                host = [[ utility::getsharedfunc( #"game", #"gethostplayer" ) ]]();
            }
            
            if ( isdefined( host ) )
            {
                function_934da7e52c45e47c( host );
            }
            
            if ( getdvarint( @"hash_fdf60fe90077b559", 0 ) == 1 )
            {
                setdvar( @"hash_fdf60fe90077b559", 0 );
                
                if ( isdefined( level.botvehicle ) && ( isdefined( level.friendlyvehiclebot ) || isdefined( level.enemyvehiclebot ) ) )
                {
                    bot = level.friendlyvehiclebot ?? level.enemyvehiclebot;
                    bot utility::callsharedfunc( #"bots", #"botpressbutton", "<dev string:x10d1>" );
                }
            }
            
            if ( getdvarint( @"hash_a864c803709b59ce", 0 ) == 1 )
            {
                setdvar( @"hash_a864c803709b59ce", 0 );
                
                if ( isdefined( level.botvehicle ) && ( isdefined( level.friendlyvehiclebot ) || isdefined( level.enemyvehiclebot ) ) )
                {
                    bot = level.friendlyvehiclebot ?? level.enemyvehiclebot;
                    bot utility::callsharedfunc( #"bots", #"botpressbutton", "<dev string:x10d6>" );
                }
            }
            
            if ( getdvarint( @"hash_6c296dda80496851", 0 ) == 1 )
            {
                setdvar( @"hash_6c296dda80496851", 0 );
                
                if ( isdefined( level.botvehicle ) && ( isdefined( level.friendlyvehiclebot ) || isdefined( level.enemyvehiclebot ) ) )
                {
                    bot = level.friendlyvehiclebot ?? level.enemyvehiclebot;
                    seatid = get_occupant_seat( level.botvehicle, bot );
                    
                    if ( isdefined( seatid ) )
                    {
                        switchseatid = function_79f80964bb18e6c6( level.botvehicle, bot, seatid );
                        
                        if ( isdefined( switchseatid ) )
                        {
                            enter( level.botvehicle, switchseatid, bot );
                        }
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace vehicle_occupancy
    // Params 2, eflags: 0x4
    // Checksum 0xcef4b955, Offset: 0xf249
    // Size: 0x18d, Type: dev
    function private function_67fabdb37c99a2d4( boundinginfo, debugonly )
    {
        if ( !isdefined( debugonly ) )
        {
            debugonly = 0;
        }
        
        if ( level.debugvehicleexit )
        {
            duration = debugonly ? 0.05 : 60;
            thread debug::function_5216f7041907b4f3( boundinginfo.orientedboxpoints[ "<dev string:xe8e>" ], boundinginfo.orientedboxpoints[ "<dev string:xe9b>" ], boundinginfo.orientedboxpoints[ "<dev string:xea9>" ], boundinginfo.orientedboxpoints[ "<dev string:xeb5>" ], boundinginfo.orientedboxpoints[ "<dev string:xec2>" ], boundinginfo.orientedboxpoints[ "<dev string:xed2>" ], boundinginfo.orientedboxpoints[ "<dev string:xee3>" ], boundinginfo.orientedboxpoints[ "<dev string:xef2>" ], duration, ( 1, 1, 1 ), "<dev string:x10dc>" );
            thread debug::function_5216f7041907b4f3( boundinginfo.unorientedboxpoints[ "<dev string:xe8e>" ], boundinginfo.unorientedboxpoints[ "<dev string:xe9b>" ], boundinginfo.unorientedboxpoints[ "<dev string:xea9>" ], boundinginfo.unorientedboxpoints[ "<dev string:xeb5>" ], boundinginfo.unorientedboxpoints[ "<dev string:xec2>" ], boundinginfo.unorientedboxpoints[ "<dev string:xed2>" ], boundinginfo.unorientedboxpoints[ "<dev string:xee3>" ], boundinginfo.unorientedboxpoints[ "<dev string:xef2>" ], duration, ( 1, 1, 0 ), "<dev string:x10dc>" );
        }
    }

#/

// Namespace vehicle_occupancy
// Params 0, eflags: 0x4
// Checksum 0x6ae87f07, Offset: 0xf3de
// Size: 0xe
function private function_d0b91dc395312ace()
{
    level notify( #"hash_3bc7c1d8a5015d2b" );
}

// Namespace vehicle_occupancy
// Params 4, eflags: 0x4
// Checksum 0x7dad0017, Offset: 0xf3f4
// Size: 0x48
function private function_5a2af62439f0d42c( start, end, drawtimeseconds, color )
{
    /#
        if ( level.debugvehicleexit )
        {
            debug::line( start, end, color, drawtimeseconds, "<dev string:x10dc>" );
        }
    #/
}

// Namespace vehicle_occupancy
// Params 4, eflags: 0x4
// Checksum 0x121ec5db, Offset: 0xf444
// Size: 0x48
function private function_daa8eeffc9a97683( origin, radius, drawtimeseconds, color )
{
    /#
        if ( level.debugvehicleexit )
        {
            debug::sphere( origin, radius, color, drawtimeseconds, "<dev string:x10dc>" );
        }
    #/
}

/#

    // Namespace vehicle_occupancy
    // Params 7, eflags: 0x4
    // Checksum 0x2c2b80ca, Offset: 0xf494
    // Size: 0xba, Type: dev
    function private function_fab637e91697ac1( pos, radius, height, angles, color, depthtest, duration )
    {
        if ( level.debugvehicleexit )
        {
            level endon( #"hash_3bc7c1d8a5015d2b" );
            drawframes = int( ceil( 0.05 / level.framedurationseconds ) );
            endtime = gettime() + duration * 1000;
            
            while ( gettime() < endtime )
            {
                level childthread utility::draw_capsule( pos, radius, height, angles, color, depthtest, drawframes );
                wait 0.05;
            }
        }
    }

#/

// Namespace vehicle_occupancy
// Params 5, eflags: 0x4
// Checksum 0x7792b2d3, Offset: 0xf556
// Size: 0x121
function private function_94553a295e176da5( origin, otherorigin, radius, drawtimeseconds, color )
{
    /#
        if ( level.debugvehicleexit )
        {
            debug::sphere( origin, radius, color, drawtimeseconds, "<dev string:x10dc>" );
            debug::sphere( otherorigin, radius, color, drawtimeseconds, "<dev string:x10dc>" );
            
            foreach ( offset in [ ( radius, 0, 0 ), ( -1 * radius, 0, 0 ), ( 0, radius, 0 ), ( 0, -1 * radius, 0 ), ( 0, 0, radius ), ( 0, 0, -1 * radius ) ] )
            {
                debug::line( origin + offset, otherorigin + offset, color, drawtimeseconds, "<dev string:x10dc>" );
            }
        }
    #/
}

/#

    // Namespace vehicle_occupancy
    // Params 1, eflags: 0x4
    // Checksum 0x25d626ea, Offset: 0xf67f
    // Size: 0x37d, Type: dev
    function private function_934da7e52c45e47c( host )
    {
        switchseat = 0;
        addid = getdvarint( @"hash_2de891db9eeac685", 0 );
        bot = undefined;
        
        if ( !isdefined( level.botvehicle ) || level.botvehicle.isdestroyed )
        {
            level.botvehicle = undefined;
        }
        
        if ( addid == 0 )
        {
            return;
        }
        
        if ( isdefined( level.botvehicle ) )
        {
            switch ( addid )
            {
                case 1:
                    setdevdvar( @"hash_2de891db9eeac685", 0 );
                    bot = level.friendlyvehiclebot;
                    
                    if ( isdefined( bot ) && !utility::callsharedfunc( #"player", #"playersareenemies", bot, host ) )
                    {
                        if ( isdefined( level.botvehicle ) )
                        {
                            botvehicle = bot vehicle::get_vehicle();
                            
                            if ( isdefined( botvehicle ) )
                            {
                                if ( botvehicle == level.botvehicle )
                                {
                                    switchseat = 1;
                                    break;
                                }
                                else
                                {
                                    bot = undefined;
                                }
                            }
                        }
                    }
                    
                    if ( !isdefined( bot ) )
                    {
                        players = utility::callsharedfunc( #"team_utility", #"getfriendlyplayers", host.team, 1 );
                        
                        if ( isdefined( players ) )
                        {
                            foreach ( player in players )
                            {
                                if ( !isbot( player ) )
                                {
                                    continue;
                                }
                                
                                bot = player;
                                break;
                            }
                        }
                    }
                    
                    level.friendlyvehiclebot = bot;
                    break;
                case 2:
                    setdevdvar( @"hash_2de891db9eeac685", 0 );
                    bot = level.enemyvehiclebot;
                    
                    if ( isdefined( bot ) && utility::callsharedfunc( #"player", #"playersareenemies", bot, host ) )
                    {
                        if ( isdefined( level.botvehicle ) )
                        {
                            botvehicle = bot vehicle::get_vehicle();
                            
                            if ( isdefined( botvehicle ) )
                            {
                                if ( botvehicle == level.botvehicle )
                                {
                                    switchseat = 1;
                                    break;
                                }
                                else
                                {
                                    bot = undefined;
                                }
                            }
                        }
                    }
                    
                    if ( !isdefined( bot ) )
                    {
                        players = utility::callsharedfunc( #"team_utility", #"getenemyplayers", host.team, 1 );
                        
                        if ( isdefined( players ) )
                        {
                            foreach ( player in players )
                            {
                                if ( !isbot( player ) )
                                {
                                    continue;
                                }
                                
                                bot = player;
                                break;
                            }
                        }
                    }
                    
                    level.enemyvehiclebot = bot;
                    break;
                default:
                    return;
            }
            
            if ( isdefined( bot ) )
            {
                if ( switchseat )
                {
                    function_614f3895e4c2ecf8( bot );
                }
                else
                {
                    function_e52de0cdff6aa50a( host, bot );
                }
            }
            else if ( addid != 0 )
            {
                iprintln( "<dev string:x10e7>" );
            }
        }
        else if ( addid != 0 )
        {
            iprintln( "<dev string:x1101>" );
        }
        
        setdevdvar( @"hash_2de891db9eeac685", 0 );
    }

    // Namespace vehicle_occupancy
    // Params 2, eflags: 0x4
    // Checksum 0x21e53015, Offset: 0xfa04
    // Size: 0xf6, Type: dev
    function private function_e52de0cdff6aa50a( host, bot )
    {
        if ( utility::issharedfuncdefined( #"game", #"gethostplayer" ) )
        {
            host = [[ utility::getsharedfunc( #"game", #"gethostplayer" ) ]]();
        }
        
        if ( !isdefined( host ) )
        {
            return 0;
        }
        
        vehicle = level.botvehicle;
        
        if ( !isdefined( vehicle ) || vehicle.isdestroyed )
        {
            iprintln( "<dev string:x1101>" );
            return 0;
        }
        
        occupants = function_b6077e40739ebc4b( vehicle );
        hostvehicle = host vehicle::get_vehicle();
        
        if ( vehicle::is_enemy_to_player( vehicle, bot ) )
        {
            if ( occupants.size > 1 )
            {
                iprintln( "<dev string:x111d>" );
                return 0;
            }
            else if ( hostvehicle == vehicle )
            {
                return function_a3fa19aa45807445( vehicle, bot, host );
            }
            
            return;
        }
        
        return function_dd1b574a9998bd15( vehicle, bot );
    }

    // Namespace vehicle_occupancy
    // Params 3, eflags: 0x4
    // Checksum 0x7c52bead, Offset: 0xfb02
    // Size: 0xc6, Type: dev
    function private function_a3fa19aa45807445( vehicle, bot, host )
    {
        vehicle_interact::allow_use( vehicle, 0 );
        thread eject_all_occupants( vehicle );
        
        while ( true )
        {
            if ( !isdefined( host ) )
            {
                break;
            }
            
            if ( !isdefined( bot ) )
            {
                break;
            }
            
            if ( !isdefined( vehicle ) )
            {
                break;
            }
            
            hostvehicle = host vehicle::get_vehicle();
            
            if ( hostvehicle != vehicle )
            {
                break;
            }
            
            waitframe();
        }
        
        if ( !isdefined( vehicle ) || vehicle.isdestroyed )
        {
            iprintln( "<dev string:x1134>" );
            return 0;
        }
        else
        {
            vehicle_interact::allow_use( vehicle, 1 );
        }
        
        if ( !isdefined( bot ) )
        {
            iprintln( "<dev string:x1134>" );
            return 0;
        }
        
        return function_dd1b574a9998bd15( vehicle, bot );
    }

    // Namespace vehicle_occupancy
    // Params 1, eflags: 0x4
    // Checksum 0xa1e88119, Offset: 0xfbd0
    // Size: 0x8e, Type: dev
    function private function_614f3895e4c2ecf8( bot )
    {
        vehicle = level.botvehicle;
        
        if ( !isdefined( vehicle ) || vehicle.isdestroyed )
        {
            iprintln( "<dev string:x1101>" );
            return 0;
        }
        
        seatid = get_occupant_seat( vehicle, bot );
        switchseatid = function_79f80964bb18e6c6( vehicle, bot, seatid );
        
        if ( !isdefined( switchseatid ) )
        {
            iprintln( "<dev string:x114e>" );
            return 0;
        }
        
        thread enter( vehicle, switchseatid, bot );
        return 1;
    }

    // Namespace vehicle_occupancy
    // Params 2, eflags: 0x4
    // Checksum 0x4390eb7c, Offset: 0xfc66
    // Size: 0xe0, Type: dev
    function private function_dd1b574a9998bd15( vehicle, bot )
    {
        pointrefs = vehicle_interact::get_point_refs( vehicle );
        state = vehicle_interact::get_scriptable_usable_state();
        
        foreach ( part in pointrefs )
        {
            if ( isdefined( bot vehicle::get_vehicle() ) )
            {
                break;
            }
            
            vehicle_interact::scriptable_used( vehicle getlinkedscriptableinstance(), part, state, bot, 0 );
        }
        
        if ( !isdefined( bot vehicle::get_vehicle() ) )
        {
            iprintln( "<dev string:x1134>" );
            return 0;
        }
        
        return 1;
    }

#/
