// scripts\common\vehicle_omnvar_utility.gsc  (hash_13f05a92a4f35787.gscc) (size: 20995 Bytes / 0x5203 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4c5697ae (1280743342)
// size ...... 20995 (0x5203)
// includes .. 5   (offset: 0x4c77)
// strings ... 53  (offset: 0x4c9f)
// dev strs .. 15  (offset: 0x510b)
// exports ... 52  (offset: 0x352f)
// cseg ...... 0x461 + 0x30ce (0x352f)
// imports ... 96  (offset: 0x3d4f)
// animtree1 . 0   (offset: 0x5203)
// animtree2 . 0   (offset: 0x5203)
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;

#namespace vehicle_omnvar;

// Namespace vehicle_omnvar
// Params 2
// Checksum 0xff8b5358, Offset: 0x47f
// Size: 0x188
function set_vehicle( vehicleref, clients )
{
    leveldataforvehicle = get_data( vehicleref );
    id = undefined;
    
    if ( getdvarint( @"hash_dc6d2fe87aa001f", 0 ) == 0 )
    {
        id = leveldataforvehicle.id;
    }
    else if ( level.projectbundle.var_53c4124af039142e )
    {
        id = function_43b5ed5a14a56573( #"vehicle", vehicleref ) ?? leveldataforvehicle.id;
    }
    else
    {
        name = vehicle::function_451bd53633bae879( vehicleref );
        id = function_43b5ed5a14a56573( #"scriptbundle_vehiclebundle", name ) ?? leveldataforvehicle.id;
    }
    
    assert( isdefined( id ), "<dev string:x24>" + getxhashsourcename( vehicleref ) + "<dev string:x3d>" );
    
    if ( isdefined( clients ) )
    {
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isplayer( client ) )
                {
                    client function_476aa03004b524d4( "ui_veh_vehicle", id );
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients function_476aa03004b524d4( "ui_veh_vehicle", id );
        }
    }
}

// Namespace vehicle_omnvar
// Params 3
// Checksum 0xb3535762, Offset: 0x60f
// Size: 0xea
function set_current_seat( vehicle, seatref, client )
{
    if ( !isdefined( client ) )
    {
        return;
    }
    
    vehicleref = vehicle vehicle::get_ref();
    id = -1;
    
    if ( isdefined( vehicleref ) )
    {
        leveldataforvehicle = get_data( vehicleref );
        
        if ( isdefined( seatref ) )
        {
            id = leveldataforvehicle.seatids[ seatref ];
            
            if ( ( leveldataforvehicle.hasdoors || leveldataforvehicle.canleanout ) && seatref != "gunner" && vehicle vehicle_damage::is_door_alive( seatref ) )
            {
                id |= 16;
            }
            
            assert( isdefined( id ), "<dev string:x24>" + vehicle.vehiclename + "<dev string:x56>" + seatref + "<dev string:x78>" );
        }
    }
    
    client setclientomnvar( "ui_veh_current_seat", id );
}

// Namespace vehicle_omnvar
// Params 3
// Checksum 0xba10121d, Offset: 0x701
// Size: 0x92
function set_next_seat( vehicleref, seatref, client )
{
    if ( !isdefined( client ) )
    {
        return;
    }
    
    id = -1;
    
    if ( isdefined( seatref ) )
    {
        leveldataforvehicle = get_data( vehicleref );
        id = leveldataforvehicle.seatids[ seatref ];
        assert( isdefined( id ), "<dev string:x24>" + getxhashsourcename( vehicleref ) + "<dev string:x56>" + seatref + "<dev string:x78>" );
    }
    
    client function_476aa03004b524d4( "ui_veh_next_seat", id );
}

// Namespace vehicle_omnvar
// Params 4
// Checksum 0x80ca57d1, Offset: 0x79b
// Size: 0x203
function set_seat_entity( vehicleref, seatref, seatentity, clients )
{
    id = -1;
    
    if ( isdefined( vehicleref ) )
    {
        leveldataforvehicle = get_data( vehicleref );
        
        if ( isdefined( seatref ) )
        {
            id = leveldataforvehicle.seatids[ seatref ];
            assert( isdefined( id ), "<dev string:x24>" + getxhashsourcename( vehicleref ) + "<dev string:x56>" + seatref + "<dev string:x78>" );
        }
    }
    
    omnvar = undefined;
    
    switch ( id )
    {
        case 0:
            omnvar = "ui_veh_occupant_0";
            break;
        case 1:
            omnvar = "ui_veh_occupant_1";
            break;
        case 2:
            omnvar = "ui_veh_occupant_2";
            break;
        case 3:
            omnvar = "ui_veh_occupant_3";
            break;
        case 4:
            omnvar = "ui_veh_occupant_4";
            break;
        case 5:
            omnvar = "ui_veh_occupant_5";
            break;
        case 6:
            omnvar = "ui_veh_occupant_6";
            break;
    }
    
    assert( isdefined( omnvar ), "<dev string:x7a>" );
    seatentityid = -1;
    
    if ( isdefined( seatentity ) )
    {
        seatentityid = seatentity getentitynumber();
    }
    
    if ( isdefined( clients ) )
    {
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isplayer( client ) )
                {
                    client function_476aa03004b524d4( omnvar, seatentityid );
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients function_476aa03004b524d4( omnvar, seatentityid );
        }
    }
}

// Namespace vehicle_omnvar
// Params 3
// Checksum 0x6fa7664b, Offset: 0x9a6
// Size: 0x2b
function function_6fccbdc0754fe059( vehicleref, seatref, clients )
{
    set_seat_entity( vehicleref, seatref, undefined, clients );
}

// Namespace vehicle_omnvar
// Params 2
// Checksum 0x389434da, Offset: 0x9d9
// Size: 0xce
function set_health_percent( healthpercentvalue = 0, clients )
{
    if ( isdefined( clients ) )
    {
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isplayer( client ) )
                {
                    client setclientomnvar( "ui_veh_health_percent", int( healthpercentvalue ) );
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients setclientomnvar( "ui_veh_health_percent", int( healthpercentvalue ) );
        }
    }
}

// Namespace vehicle_omnvar
// Params 1
// Checksum 0x73361055, Offset: 0xaaf
// Size: 0x16
function clear_health_percent( clients )
{
    set_health_percent( undefined, clients );
}

// Namespace vehicle_omnvar
// Params 1
// Checksum 0xfcf1b1ad, Offset: 0xacd
// Size: 0xb9
function show_health( clients )
{
    if ( isdefined( clients ) )
    {
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isplayer( client ) )
                {
                    client function_476aa03004b524d4( "ui_veh_show_health", 1 );
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients function_476aa03004b524d4( "ui_veh_show_health", 1 );
        }
    }
}

// Namespace vehicle_omnvar
// Params 1
// Checksum 0x222f3197, Offset: 0xb8e
// Size: 0xb7
function hide_health( clients )
{
    if ( isdefined( clients ) )
    {
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isplayer( client ) )
                {
                    client function_476aa03004b524d4( "ui_veh_show_health", 0 );
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients function_476aa03004b524d4( "ui_veh_show_health", 0 );
        }
    }
}

// Namespace vehicle_omnvar
// Params 1
// Checksum 0xaed18463, Offset: 0xc4d
// Size: 0x25
function clear_show_health( clients )
{
    if ( false )
    {
        show_health( clients );
        return;
    }
    
    hide_health( clients );
}

// Namespace vehicle_omnvar
// Params 2
// Checksum 0x453d339a, Offset: 0xc7a
// Size: 0xd2
function set_time_percent( timepercentvalue = 0, clients )
{
    if ( isdefined( clients ) )
    {
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isplayer( client ) )
                {
                    client function_476aa03004b524d4( "ui_veh_time_percent", int( timepercentvalue ) );
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients function_476aa03004b524d4( "ui_veh_time_percent", int( timepercentvalue ) );
        }
    }
}

// Namespace vehicle_omnvar
// Params 1
// Checksum 0xb74e0a75, Offset: 0xd54
// Size: 0x16
function clear_time_percent( clients )
{
    set_time_percent( undefined, clients );
}

// Namespace vehicle_omnvar
// Params 1
// Checksum 0xe2ff3a3, Offset: 0xd72
// Size: 0xb9
function show_time( clients )
{
    if ( isdefined( clients ) )
    {
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isplayer( client ) )
                {
                    client function_476aa03004b524d4( "ui_veh_show_time", 1 );
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients function_476aa03004b524d4( "ui_veh_show_time", 1 );
        }
    }
}

// Namespace vehicle_omnvar
// Params 1
// Checksum 0xa009d8fb, Offset: 0xe33
// Size: 0xb7
function hide_time( clients )
{
    if ( isdefined( clients ) )
    {
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isplayer( client ) )
                {
                    client function_476aa03004b524d4( "ui_veh_show_time", 0 );
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients function_476aa03004b524d4( "ui_veh_show_time", 0 );
        }
    }
}

// Namespace vehicle_omnvar
// Params 1
// Checksum 0x4e64bf14, Offset: 0xef2
// Size: 0x25
function clear_show_time( clients )
{
    if ( false )
    {
        show_time( clients );
        return;
    }
    
    hide_time( clients );
}

// Namespace vehicle_omnvar
// Params 2
// Checksum 0xf2fc0c00, Offset: 0xf1f
// Size: 0x45
function function_9f4759fcb3acdc4( currentfuel, maxfuel )
{
    fuelpercentage = get_fuel_percent( currentfuel, maxfuel );
    occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( self );
    set_fuel_percent( fuelpercentage, occupants );
}

// Namespace vehicle_omnvar
// Params 3
// Checksum 0xc5137aaf, Offset: 0xf6c
// Size: 0x3d
function function_20347e94284fa3ed( player, currentfuel, maxfuel )
{
    fuelpercentage = get_fuel_percent( currentfuel, maxfuel );
    set_fuel_percent( fuelpercentage, player );
}

// Namespace vehicle_omnvar
// Params 2, eflags: 0x4
// Checksum 0x103d5f95, Offset: 0xfb1
// Size: 0x5a
function private get_fuel_percent( currentfuel = self.fuel, maxfuel = vehicle_interact::get_max_fuel() )
{
    if ( maxfuel == -1 )
    {
        return 100;
    }
    
    assert( isdefined( currentfuel ) && isdefined( maxfuel ), "<dev string:x9d>" );
    return currentfuel / maxfuel * 100;
}

// Namespace vehicle_omnvar
// Params 2
// Checksum 0xbe86e03e, Offset: 0x1014
// Size: 0xd3
function set_fuel_percent( var_6779d30d1fcfe10 = 100, clients )
{
    if ( isdefined( clients ) )
    {
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isplayer( client ) )
                {
                    client function_476aa03004b524d4( "ui_veh_fuel_percent", int( var_6779d30d1fcfe10 ) );
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients function_476aa03004b524d4( "ui_veh_fuel_percent", int( var_6779d30d1fcfe10 ) );
        }
    }
}

// Namespace vehicle_omnvar
// Params 4
// Checksum 0x231fcd4f, Offset: 0x10ef
// Size: 0x1cc
function set_ammo( vehicleref, ammoref, ammovalue, clients )
{
    leveldataforvehicle = get_data( vehicleref );
    
    if ( leveldataforvehicle.ammoomnvars[ ammoref ] )
    {
        omnvar = leveldataforvehicle.ammoomnvars[ ammoref ];
    }
    else
    {
        id = leveldataforvehicle.ammoids[ ammoref ];
        assert( isdefined( id ), "<dev string:x24>" + getxhashsourcename( vehicleref ) + "<dev string:x101>" + ammoref + "<dev string:x78>" );
        omnvar = undefined;
        
        switch ( id )
        {
            case 0:
                omnvar = "ui_veh_ammo_0";
                break;
            case 1:
                omnvar = "ui_veh_ammo_1";
                break;
            case 2:
                omnvar = "ui_veh_ammo_2";
                break;
        }
    }
    
    assert( isdefined( omnvar ), "<dev string:x126>" );
    
    if ( !isdefined( ammovalue ) )
    {
        ammovalue = -1;
    }
    else if ( isstring( ammovalue ) && ammovalue == "infinite" )
    {
        ammovalue = -2;
    }
    
    if ( isdefined( clients ) )
    {
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isplayer( client ) )
                {
                    client function_476aa03004b524d4( omnvar, ammovalue );
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients function_476aa03004b524d4( omnvar, ammovalue );
        }
    }
}

// Namespace vehicle_omnvar
// Params 0
// Checksum 0xf4a84181, Offset: 0x12c3
// Size: 0x39
function function_8de48e050dcfaef7()
{
    driver = vehicle_occupancy::get_seat_occupant( self, "driver" );
    
    if ( isdefined( driver ) )
    {
        set_ammo( vehicle::get_ref(), "turret", self function_4a982264b67c1076(), driver );
    }
}

// Namespace vehicle_omnvar
// Params 3
// Checksum 0x8ebb58d1, Offset: 0x1304
// Size: 0x2b
function clear_ammo( vehicleref, ammoref, clients )
{
    set_ammo( vehicleref, ammoref, undefined, clients );
}

// Namespace vehicle_omnvar
// Params 4
// Checksum 0xb0f31b6e, Offset: 0x1337
// Size: 0x59
function show_ammo( vehicleref, ammoref, ammovalue, clients )
{
    assert( isstring( ammovalue ) || ammovalue != -1, "<dev string:x149>" + -1 + "<dev string:x78>" );
    set_ammo( vehicleref, ammoref, ammovalue, clients );
}

// Namespace vehicle_omnvar
// Params 3
// Checksum 0x8bf3d2c, Offset: 0x1398
// Size: 0x2c
function hide_ammo( vehicleref, ammoref, clients )
{
    set_ammo( vehicleref, ammoref, -1, clients );
}

// Namespace vehicle_omnvar
// Params 3
// Checksum 0x67e79f0b, Offset: 0x13cc
// Size: 0x165
function show_warning( warningref, clients, vehicleref )
{
    leveldataforvehicle = get_data( vehicleref, 1 );
    id = leveldataforvehicle.warningbits[ warningref ];
    assert( id < 12, "<dev string:x17b>" + id + "<dev string:x1ac>" + 12 + "<dev string:x78>" );
    
    if ( isdefined( clients ) )
    {
        warningstartcallback = leveldataforvehicle.warningstartcallbacks[ warningref ];
        
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isplayer( client ) )
                {
                    client function_47457b9ec007482e( "ui_veh_warning", id, 1, 1 );
                    
                    if ( isdefined( warningstartcallback ) )
                    {
                        thread [[ warningstartcallback ]]( client, "ui_veh_warning" + "_omnvar_modified" );
                    }
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients function_47457b9ec007482e( "ui_veh_warning", id, 1, 1 );
            
            if ( isdefined( warningstartcallback ) )
            {
                thread [[ warningstartcallback ]]( clients, "ui_veh_warning" + "_omnvar_modified" );
            }
        }
    }
}

// Namespace vehicle_omnvar
// Params 3
// Checksum 0xdd11b9e2, Offset: 0x1539
// Size: 0x163
function hide_warning( warningref, clients, vehicleref )
{
    leveldataforvehicle = get_data( vehicleref, 1 );
    id = leveldataforvehicle.warningbits[ warningref ];
    assert( id < 12, "<dev string:x17b>" + id + "<dev string:x1ac>" + 12 + "<dev string:x78>" );
    
    if ( isdefined( clients ) )
    {
        warningendcallback = leveldataforvehicle.warningendcallbacks[ warningref ];
        
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isplayer( client ) )
                {
                    client function_47457b9ec007482e( "ui_veh_warning", id, 1, 0 );
                    
                    if ( isdefined( warningendcallback ) )
                    {
                        thread [[ warningendcallback ]]( client, "ui_veh_warning" + "_omnvar_modified" );
                    }
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients function_47457b9ec007482e( "ui_veh_warning", id, 1, 0 );
            
            if ( isdefined( warningendcallback ) )
            {
                thread [[ warningendcallback ]]( clients, "ui_veh_warning" + "_omnvar_modified" );
            }
        }
    }
}

// Namespace vehicle_omnvar
// Params 2
// Checksum 0xaa9863fc, Offset: 0x16a4
// Size: 0x218
function clear_warnings( clients, vehicleref )
{
    if ( isdefined( clients ) )
    {
        leveldataforvehicle = undefined;
        
        if ( isdefined( vehicleref ) )
        {
            leveldataforvehicle = get_data( vehicleref, undefined, 1 );
        }
        
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isplayer( client ) )
                {
                    var_1d1ab712be451ee4 = client getclientomnvar( "ui_veh_warning" ) != 0;
                    client setclientomnvar( "ui_veh_warning", 0 );
                    
                    if ( var_1d1ab712be451ee4 )
                    {
                        stop_warning_sounds( client );
                    }
                    
                    if ( isdefined( leveldataforvehicle ) )
                    {
                        foreach ( warningclearcallback in leveldataforvehicle.warningclearcallbacks )
                        {
                            if ( isdefined( warningclearcallback ) )
                            {
                                thread [[ warningclearcallback ]]( client );
                            }
                        }
                    }
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            var_1d1ab712be451ee4 = clients getclientomnvar( "ui_veh_warning" ) != 0;
            clients setclientomnvar( "ui_veh_warning", 0 );
            
            if ( var_1d1ab712be451ee4 )
            {
                stop_warning_sounds( clients );
            }
            
            if ( isdefined( leveldataforvehicle ) )
            {
                foreach ( warningclearcallback in leveldataforvehicle.warningclearcallbacks )
                {
                    if ( isdefined( warningclearcallback ) )
                    {
                        thread [[ warningclearcallback ]]( clients );
                    }
                }
            }
        }
    }
}

// Namespace vehicle_omnvar
// Params 1
// Checksum 0xdf70bb35, Offset: 0x18c4
// Size: 0x122
function stop_warning_sounds( client )
{
    var_edcc64012c6fc784 = client getscriptablehaspart( "veh_fuel_warning_sfx" );
    var_29653db2edb57370 = client getscriptablehaspart( "veh_missile_warning_sfx" );
    
    if ( !var_edcc64012c6fc784 )
    {
        if ( soundexists( "uin_veh_warning_low_fuel" ) )
        {
            client stoplocalsound( "uin_veh_warning_low_fuel" );
        }
        
        if ( soundexists( "uin_veh_warning_low_fuel_heli" ) )
        {
            client stoplocalsound( "uin_veh_warning_low_fuel_heli" );
        }
        
        if ( soundexists( "uin_veh_warning_out_of_fuel" ) )
        {
            client stoplocalsound( "uin_veh_warning_out_of_fuel" );
        }
        
        if ( soundexists( "uin_veh_warning_out_of_fuel_heli" ) )
        {
            client stoplocalsound( "uin_veh_warning_out_of_fuel_heli" );
        }
    }
    else if ( client getscriptableparthasstate( "veh_fuel_warning_sfx", "off" ) )
    {
        client setscriptablepartstate( "veh_fuel_warning_sfx", "off" );
    }
    
    if ( !var_29653db2edb57370 )
    {
        if ( soundexists( "veh_warning_missile_locking" ) )
        {
            client stoplocalsound( "veh_warning_missile_locking" );
        }
        
        if ( soundexists( "veh_warning_missile_incoming" ) )
        {
            client stoplocalsound( "veh_warning_missile_incoming" );
        }
        
        return;
    }
    
    if ( client getscriptableparthasstate( "veh_missile_warning_sfx", "off" ) )
    {
        client setscriptablepartstate( "veh_missile_warning_sfx", "off" );
    }
}

// Namespace vehicle_omnvar
// Params 4
// Checksum 0x5ea71697, Offset: 0x19ee
// Size: 0x1a4
function set_rotation( vehicleref, rotationref, rotationvalue, clients )
{
    leveldataforvehicle = get_data( vehicleref );
    id = leveldataforvehicle.rotationids[ rotationref ];
    assert( isdefined( id ), "<dev string:x24>" + getxhashsourcename( vehicleref ) + "<dev string:x1bf>" + rotationref + "<dev string:x78>" );
    omnvar = undefined;
    
    switch ( id )
    {
        case 0:
            omnvar = "ui_veh_degrees_0";
            break;
        case 1:
            omnvar = "ui_veh_degrees_1";
            break;
    }
    
    assert( isdefined( omnvar ), "<dev string:x1e8>" );
    
    if ( !isdefined( rotationvalue ) )
    {
        rotationvalue = 0;
    }
    
    if ( isdefined( clients ) )
    {
        remainder = rotationvalue - floor( rotationvalue );
        
        if ( remainder >= 0.5 )
        {
            rotationvalue = ceil( rotationvalue );
        }
        else
        {
            rotationvalue = floor( rotationvalue );
        }
        
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isplayer( client ) )
                {
                    client function_476aa03004b524d4( omnvar, rotationvalue );
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients function_476aa03004b524d4( omnvar, rotationvalue );
        }
    }
}

// Namespace vehicle_omnvar
// Params 3
// Checksum 0x802fe089, Offset: 0x1b9a
// Size: 0x2b
function clear_rotation( vehicleref, rotationref, clients )
{
    set_rotation( vehicleref, rotationref, undefined, clients );
}

// Namespace vehicle_omnvar
// Params 1
// Checksum 0x7ec5d0f5, Offset: 0x1bcd
// Size: 0xf1
function show_controls( clients )
{
    if ( isdefined( clients ) )
    {
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isplayer( client ) )
                {
                    client notify( #"vehomn_modified_controls" );
                    client.vehomncontrols = "show";
                    client setclientomnvar( "ui_veh_controls", 1 );
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients notify( #"vehomn_modified_controls" );
            clients.vehomncontrols = "show";
            clients setclientomnvar( "ui_veh_controls", 1 );
        }
    }
}

// Namespace vehicle_omnvar
// Params 1
// Checksum 0xb6d45372, Offset: 0x1cc6
// Size: 0xef
function hide_controls( clients )
{
    if ( isdefined( clients ) )
    {
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isplayer( client ) )
                {
                    client notify( #"vehomn_modified_controls" );
                    client.vehomncontrols = "hide";
                    client setclientomnvar( "ui_veh_controls", 0 );
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients notify( #"vehomn_modified_controls" );
            clients.vehomncontrols = "hide";
            clients setclientomnvar( "ui_veh_controls", 0 );
        }
    }
}

// Namespace vehicle_omnvar
// Params 1
// Checksum 0xc1a866d3, Offset: 0x1dbd
// Size: 0xab
function fade_out_controls( clients )
{
    if ( isdefined( clients ) )
    {
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isplayer( client ) )
                {
                    thread function_96ae647221cfe804( client );
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            thread function_96ae647221cfe804( clients );
        }
    }
}

// Namespace vehicle_omnvar
// Params 1
// Checksum 0x52992fe8, Offset: 0x1e70
// Size: 0x8b
function function_96ae647221cfe804( client )
{
    client endon( #"death_or_disconnect" );
    client endon( #"vehomn_modified_controls" );
    
    if ( !isdefined( client.vehomncontrols ) || client.vehomncontrols != "hide" && client.vehomncontrols != "fadeOut" )
    {
        client.vehomncontrols = "fadeOut";
        client setclientomnvar( "ui_veh_controls", 2 );
        wait 3;
        thread hide_controls( client );
    }
}

// Namespace vehicle_omnvar
// Params 1
// Checksum 0x2ebdfd20, Offset: 0x1f03
// Size: 0xc9
function clear_controls( clients )
{
    if ( isdefined( clients ) )
    {
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isplayer( client ) )
                {
                    client.vehomncontrols = undefined;
                    client setclientomnvar( "ui_veh_controls", 0 );
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients setclientomnvar( "ui_veh_controls", 0 );
            clients.vehomncontrols = undefined;
        }
    }
}

// Namespace vehicle_omnvar
// Params 1
// Checksum 0x9b3d3ba9, Offset: 0x1fd4
// Size: 0x43, Type: bool
function function_3a46307fb9c3a02( client )
{
    return !isdefined( client.vehomncontrols ) || client.vehomncontrols == "fadeOut" || client.vehomncontrols == "hide";
}

// Namespace vehicle_omnvar
// Params 3
// Checksum 0x3107b524, Offset: 0x2020
// Size: 0x2dd
function get_data( vehicleref, create, var_e6c819f806ce2c86 )
{
    if ( create && ( !vehicle::has_data( vehicleref ) || !isdefined( vehicle::get_data( vehicleref ).occupancy ) || !isdefined( vehicle::get_data( vehicleref ).occupancy.seatids ) ) )
    {
        data = undefined;
        
        if ( vehicle::has_data( vehicleref ) )
        {
            data = vehicle::get_data( vehicleref );
        }
        else
        {
            data = spawnstruct();
        }
        
        if ( !isdefined( data.occupancy ) )
        {
            data.occupancy = spawnstruct();
        }
        
        data.occupancy.seatids = [];
        data.occupancy.ammoids = [];
        data.occupancy.rotationids = [];
        data.occupancy.warningbits = [];
        data.occupancy.warningstartcallbacks = [];
        data.occupancy.warningendcallbacks = [];
        data.occupancy.warningclearcallbacks = [];
        data.occupancy.rotationrefsbyseatandweapon = [];
        data.occupancy.warningbits[ "burningDown" ] = 1;
        data.occupancy.warningbits[ "missileLocking" ] = 2;
        data.occupancy.warningbits[ "missileIncoming" ] = 4;
        data.occupancy.warningbits[ "movementDisabled" ] = 3;
        data.occupancy.warningbits[ "outOfFuel" ] = 6;
        data.occupancy.warningbits[ "lowFuel" ] = 5;
        data.occupancy.warningbits[ "BunkerBusterAttached" ] = 7;
        data.occupancy.warningbits[ "shockStickAttached" ] = 8;
        data.occupancy.warningbits[ "DDoSed" ] = 9;
        data.occupancy.warningbits[ "locked" ] = 10;
        data.occupancy.warningbits[ "broken" ] = 11;
        vehicle::add_data( vehicleref, data );
    }
    
    if ( vehicle::has_data( vehicleref ) )
    {
        return vehicle::get_data( vehicleref ).occupancy;
    }
}

// Namespace vehicle_omnvar
// Params 3
// Checksum 0x9b600d07, Offset: 0x2305
// Size: 0xa2
function clear_data( vehicleref, create, var_e6c819f806ce2c86 )
{
    leveldataforvehicle = get_data( vehicleref, create, var_e6c819f806ce2c86 );
    
    if ( isdefined( leveldataforvehicle ) )
    {
        leveldataforvehicle.seatids = [];
        leveldataforvehicle.ammoids = [];
        leveldataforvehicle.rotationids = [];
        leveldataforvehicle.warningbits = [];
        leveldataforvehicle.warningstartcallbacks = [];
        leveldataforvehicle.warningendcallbacks = [];
        leveldataforvehicle.warningclearcallbacks = [];
        leveldataforvehicle.id = undefined;
    }
    
    return leveldataforvehicle;
}

// Namespace vehicle_omnvar
// Params 2
// Checksum 0xae98b48f, Offset: 0x23b0
// Size: 0x9e
function clear_all( clients, vehicleref )
{
    if ( isarray( clients ) )
    {
        foreach ( client in clients )
        {
            clear_all_internal( client, vehicleref );
        }
        
        return;
    }
    
    clear_all_internal( clients, vehicleref );
}

// Namespace vehicle_omnvar
// Params 2, eflags: 0x4
// Checksum 0xc39dd227, Offset: 0x2456
// Size: 0x155
function private clear_all_internal( client, vehicleref )
{
    if ( isplayer( client ) )
    {
        client setclientomnvar( "ui_veh_vehicle", -1 );
        client setclientomnvar( "ui_veh_current_seat", -1 );
        client function_476aa03004b524d4( "ui_veh_next_seat", -1 );
        client function_476aa03004b524d4( "ui_veh_occupant_0", -1 );
        client function_476aa03004b524d4( "ui_veh_occupant_1", -1 );
        client function_476aa03004b524d4( "ui_veh_occupant_2", -1 );
        client function_476aa03004b524d4( "ui_veh_occupant_3", -1 );
        client function_476aa03004b524d4( "ui_veh_occupant_4", -1 );
        client function_476aa03004b524d4( "ui_veh_occupant_5", -1 );
        client function_476aa03004b524d4( "ui_veh_occupant_6", -1 );
        client setclientomnvar( "ui_veh_health_percent", 0 );
        client function_476aa03004b524d4( "ui_veh_show_health", 0 );
        client function_476aa03004b524d4( "ui_veh_time_percent", 0 );
        client function_476aa03004b524d4( "ui_veh_show_time", 0 );
        client function_476aa03004b524d4( "ui_veh_fuel_percent", 100 );
        client function_476aa03004b524d4( "ui_veh_ammo_0", -1 );
        client function_476aa03004b524d4( "ui_veh_ammo_1", -1 );
        clear_warnings( client, vehicleref );
        client function_476aa03004b524d4( "ui_veh_degrees_0", 0 );
        client function_476aa03004b524d4( "ui_veh_degrees_1", 0 );
        clear_controls( client );
    }
}

// Namespace vehicle_omnvar
// Params 4
// Checksum 0xb2b8774, Offset: 0x25b3
// Size: 0x502
function function_e0aa0be8e3297e0d( vehicle, oldseatid, newseatid, player )
{
    set_vehicle( vehicle vehicle::get_ref(), player );
    set_current_seat( vehicle, newseatid, player );
    lowfuelsound = "uin_veh_warning_low_fuel";
    outoffuelsound = "uin_veh_warning_out_of_fuel";
    var_edcc64012c6fc784 = player getscriptablehaspart( "veh_fuel_warning_sfx" );
    
    if ( vehicle vehicle::ishelicopter() )
    {
        lowfuelsound = "uin_veh_warning_low_fuel_heli";
        outoffuelsound = "uin_veh_warning_out_of_fuel_heli";
    }
    
    occupants = vehicle_occupancy::get_all_occupants( vehicle );
    
    if ( isdefined( oldseatid ) )
    {
        function_6fccbdc0754fe059( vehicle vehicle::get_ref(), oldseatid, occupants );
    }
    else
    {
        foreach ( seatid, occupant in occupants )
        {
            if ( isdefined( occupant ) && occupant != player )
            {
                set_seat_entity( vehicle vehicle::get_ref(), seatid, occupant, player );
            }
        }
    }
    
    set_seat_entity( vehicle vehicle::get_ref(), newseatid, player, occupants );
    function_2c9ed144f176f7d8( vehicle );
    
    if ( vehicle.health < vehicle.maxhealth )
    {
        function_ca8a66bb3a611610( vehicle );
    }
    
    if ( vehicle_interact::fuel_is_enabled() && isdefined( vehicle.fuel ) )
    {
        vehicle function_20347e94284fa3ed( player );
    }
    
    show_controls( player );
    function_f5732979a745bce0( vehicle, player, newseatid );
    leveldataforvehicle = get_data( vehicle vehicle::get_ref() );
    
    if ( vehicle.var_4c567014a63269e )
    {
        if ( isdefined( leveldataforvehicle.warningbits[ "BunkerBusterAttached" ] ) )
        {
            show_warning( "BunkerBusterAttached", player, vehicle vehicle::get_ref() );
        }
    }
    
    if ( utility::callsharedfunc( #"weapons", #"islockedonto", vehicle ) )
    {
        if ( isdefined( leveldataforvehicle.warningbits[ "missileLocking" ] ) )
        {
            show_warning( "missileLocking", player, vehicle vehicle::get_ref() );
        }
    }
    
    if ( utility::callsharedfunc( #"weapons", #"hasincoming", vehicle ) )
    {
        if ( isdefined( leveldataforvehicle.warningbits[ "missileIncoming" ] ) )
        {
            show_warning( "missileIncoming", player, vehicle vehicle::get_ref() );
        }
    }
    
    if ( !vehicle_occupancy::is_movement_allowed( vehicle ) )
    {
        if ( vehicle vehicle_occupancy::is_locked() )
        {
            if ( isdefined( leveldataforvehicle.warningbits[ "locked" ] ) )
            {
                show_warning( "locked", player, vehicle vehicle::get_ref() );
            }
        }
        else if ( vehicle.isbroken )
        {
            if ( isdefined( leveldataforvehicle.warningbits[ "broken" ] ) )
            {
                show_warning( "broken", player, vehicle vehicle::get_ref() );
            }
        }
        else if ( vehicle utility::callsharedfunc( #"emp", #"is_empd" ) && !isdefined( vehicle.ksempd ) && getdvarint( @"hash_6434c2bc75e4ba1", !isbrgamemode() ) )
        {
            show_warning( "DDoSed", player, vehicle vehicle::get_ref() );
        }
        else if ( vehicle.fuel <= 0 && isdefined( leveldataforvehicle.warningbits[ "outOfFuel" ] ) )
        {
            show_warning( "outOfFuel", player, vehicle vehicle::get_ref() );
        }
        else if ( isdefined( leveldataforvehicle.warningbits[ "movementDisabled" ] ) && !isdefined( vehicle.ksempd ) )
        {
            show_warning( "movementDisabled", player, vehicle vehicle::get_ref() );
        }
        
        if ( !isdefined( oldseatid ) )
        {
            if ( !var_edcc64012c6fc784 && soundexists( outoffuelsound ) )
            {
                player stoplocalsound( outoffuelsound );
                player playlocalsound( outoffuelsound );
            }
            else if ( player getscriptableparthasstate( "veh_fuel_warning_sfx", "veh_fuel_warning_out_of_fuel" ) )
            {
                player setscriptablepartstate( "veh_fuel_warning_sfx", "veh_fuel_warning_out_of_fuel" );
            }
        }
    }
    
    if ( vehicle vehicle_damage::is_burning_down() )
    {
        if ( isdefined( leveldataforvehicle.warningbits[ "burningDown" ] ) )
        {
            show_warning( "burningDown", player, vehicle vehicle::get_ref() );
        }
    }
    
    if ( vehicle.fuel <= 25 && vehicle.fuel > 0 )
    {
        if ( isdefined( leveldataforvehicle.warningbits[ "lowFuel" ] ) )
        {
            show_warning( "lowFuel", player, vehicle vehicle::get_ref() );
            
            if ( !isdefined( oldseatid ) )
            {
                if ( !var_edcc64012c6fc784 && soundexists( lowfuelsound ) )
                {
                    player stoplocalsound( lowfuelsound );
                    player playlocalsound( lowfuelsound );
                    return;
                }
                
                player setscriptablepartstate( "veh_fuel_warning_sfx", "veh_fuel_warning_low_fuel" );
            }
        }
    }
}

// Namespace vehicle_omnvar
// Params 2
// Checksum 0x63ba2537, Offset: 0x2abd
// Size: 0x327
function function_fc8e70f33a941b3d( vehicle, player )
{
    set_vehicle( vehicle vehicle::get_ref(), player );
    lowfuelsound = "uin_veh_warning_low_fuel";
    outoffuelsound = "uin_veh_warning_out_of_fuel";
    var_edcc64012c6fc784 = player getscriptablehaspart( "veh_fuel_warning_sfx" );
    
    if ( vehicle::ishelicopter() )
    {
        lowfuelsound = "uin_veh_warning_low_fuel_heli";
        outoffuelsound = "uin_veh_warning_out_of_fuel_heli";
    }
    
    if ( vehicle.health < vehicle.maxhealth )
    {
        function_ca8a66bb3a611610( vehicle );
    }
    
    if ( vehicle_interact::fuel_is_enabled() && isdefined( vehicle.fuel ) )
    {
        vehicle function_20347e94284fa3ed( player );
    }
    
    leveldataforvehicle = get_data( vehicle vehicle::get_ref() );
    
    if ( utility::callsharedfunc( #"weapons", #"hasBunkerBustersAttached", vehicle ) )
    {
        if ( isdefined( leveldataforvehicle.warningbits[ "missileLocking" ] ) )
        {
            show_warning( "missileLocking", player, vehicle vehicle::get_ref() );
        }
    }
    
    if ( utility::callsharedfunc( #"weapons", #"islockedonto", vehicle ) )
    {
        if ( isdefined( leveldataforvehicle.warningbits[ "missileLocking" ] ) )
        {
            show_warning( "missileLocking", player, vehicle vehicle::get_ref() );
        }
    }
    
    if ( utility::callsharedfunc( #"weapons", #"hasincoming", vehicle ) )
    {
        if ( isdefined( leveldataforvehicle.warningbits[ "missileIncoming" ] ) )
        {
            show_warning( "missileIncoming", player, vehicle vehicle::get_ref() );
        }
    }
    
    if ( !vehicle_occupancy::is_movement_allowed( vehicle ) )
    {
        if ( vehicle.fuel <= 0 && isdefined( leveldataforvehicle.warningbits[ "outOfFuel" ] ) )
        {
            show_warning( "outOfFuel", player, vehicle vehicle::get_ref() );
            
            if ( !var_edcc64012c6fc784 && soundexists( outoffuelsound ) )
            {
                player playlocalsound( outoffuelsound );
            }
            else if ( player getscriptableparthasstate( "veh_fuel_warning_sfx", "veh_fuel_warning_out_of_fuel" ) )
            {
                player setscriptablepartstate( "veh_fuel_warning_sfx", "veh_fuel_warning_out_of_fuel" );
            }
        }
        else if ( isdefined( leveldataforvehicle.warningbits[ "movementDisabled" ] ) )
        {
            show_warning( "movementDisabled", player, vehicle vehicle::get_ref() );
        }
    }
    
    if ( vehicle vehicle_damage::is_burning_down() )
    {
        if ( isdefined( leveldataforvehicle.warningbits[ "burningDown" ] ) )
        {
            show_warning( "burningDown", player, vehicle vehicle::get_ref() );
        }
    }
    
    if ( vehicle.fuel <= 25 && vehicle.fuel > 0 )
    {
        if ( isdefined( leveldataforvehicle.warningbits[ "lowFuel" ] ) )
        {
            show_warning( "lowFuel", player, vehicle vehicle::get_ref() );
            
            if ( !var_edcc64012c6fc784 && soundexists( lowfuelsound ) )
            {
                player stoplocalsound( lowfuelsound );
                player playlocalsound( lowfuelsound );
                return;
            }
            
            if ( player getscriptableparthasstate( "veh_fuel_warning_sfx", "veh_fuel_warning_low_fuel" ) )
            {
                player setscriptablepartstate( "veh_fuel_warning_sfx", "veh_fuel_warning_low_fuel" );
            }
        }
    }
}

// Namespace vehicle_omnvar
// Params 4
// Checksum 0xd125d4a6, Offset: 0x2dec
// Size: 0x7a
function function_1f2d7e52383cc345( vehicle, oldseatid, newseatid, player )
{
    if ( !isdefined( newseatid ) )
    {
        if ( isdefined( oldseatid ) )
        {
            clear_all( player, vehicle vehicle::get_ref() );
            
            if ( isdefined( vehicle ) )
            {
                occupants = vehicle_occupancy::get_all_occupants( vehicle );
                function_6fccbdc0754fe059( vehicle vehicle::get_ref(), oldseatid, occupants );
                function_2c9ed144f176f7d8( vehicle );
            }
        }
    }
}

// Namespace vehicle_omnvar
// Params 2
// Checksum 0xf7a41073, Offset: 0x2e6e
// Size: 0x26
function function_a9e60d4916911fc6( vehicle, player )
{
    clear_all( player, vehicle vehicle::get_ref() );
}

// Namespace vehicle_omnvar
// Params 2
// Checksum 0x964cfa36, Offset: 0x2e9c
// Size: 0x119
function function_ca8a66bb3a611610( vehicle, data )
{
    if ( !isdefined( vehicle.maxhealth ) )
    {
        assertmsg( "<dev string:x20f>" );
        return;
    }
    
    occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( vehicle, 0 );
    
    if ( vehicle.maxhealth == 0 )
    {
        healthpercent = 0;
    }
    else if ( !isdefined( data.damage ) )
    {
        healthpercent = int( clamp( vehicle.health / vehicle.maxhealth * 100, 0, 100 ) );
    }
    else if ( utility::issp() )
    {
        healthpercent = int( clamp( vehicle.health / vehicle.maxhealth * 100, 0, 100 ) );
    }
    else
    {
        healthpercent = int( clamp( ( vehicle.health - data.damage ) / vehicle.maxhealth * 100, 0, 100 ) );
    }
    
    show_health( occupants );
    set_health_percent( healthpercent, occupants );
}

// Namespace vehicle_omnvar
// Params 2
// Checksum 0xf75628de, Offset: 0x2fbd
// Size: 0xfe
function function_b7e5944543c97cfa( vehicle, data = spawnstruct() )
{
    leveldataforvehicle = get_data( vehicle vehicle::get_ref(), undefined, 1 );
    occupants = vehicle_occupancy::get_all_occupants( vehicle );
    
    if ( isdefined( occupants ) && isdefined( leveldataforvehicle ) )
    {
        if ( occupants.size > 0 )
        {
            foreach ( seatid, occupant in occupants )
            {
                if ( isplayer( occupant ) && occupant utility::callsharedfunc( #"player", #"playerisalive" ) )
                {
                    function_f5732979a745bce0( vehicle, occupant, seatid, data );
                }
            }
        }
    }
}

// Namespace vehicle_omnvar
// Params 4
// Checksum 0x82660935, Offset: 0x30c3
// Size: 0x61
function function_f5732979a745bce0( vehicle, client, seatid = vehicle_occupancy::get_occupant_seat( vehicle, client ), data )
{
    assert( isdefined( seatid ), "<dev string:x25f>" + client getentitynumber() + "<dev string:x78>" );
    function_ac478526d789c733( vehicle, client, seatid, data );
}

// Namespace vehicle_omnvar
// Params 1
// Checksum 0x90e8830f, Offset: 0x312c
// Size: 0xad
function function_2c9ed144f176f7d8( vehicle )
{
    occupants = vehicle_occupancy::get_all_occupants( vehicle );
    
    foreach ( seatid, occupant in occupants )
    {
        nextseatid = vehicle_occupancy::function_79f80964bb18e6c6( vehicle, occupant, seatid );
        set_next_seat( vehicle vehicle::get_ref(), nextseatid, occupant );
    }
}

// Namespace vehicle_omnvar
// Params 4
// Checksum 0x3cb759c0, Offset: 0x31e1
// Size: 0x1c3
function function_ac478526d789c733( vehicle, client, seatid, data )
{
    leveldataforvehicle = get_data( vehicle vehicle::get_ref() );
    
    if ( leveldataforvehicle.rotationrefsbyseatandweapon.size > 0 && isdefined( leveldataforvehicle.rotationrefsbyseatandweapon[ seatid ] ) )
    {
        if ( vehicle_occupancy::is_driver_seat( vehicle, seatid ) )
        {
            if ( isdefined( vehicle.objweapon ) )
            {
                rotationref = leveldataforvehicle.rotationrefsbyseatandweapon[ seatid ][ vehicle.objweapon.basename ];
                
                if ( isdefined( rotationref ) )
                {
                    invertedangles = invertangles( client getplayerangles() );
                    angles = vehicle.angles;
                    entangles = combineangles( invertedangles, angles );
                    entrotation = angleclamp( entangles[ 1 ] );
                    set_rotation( vehicle vehicle::get_ref(), rotationref, entrotation, client );
                }
            }
        }
        
        anglesarr = function_958654161cd92cc8( vehicle, data );
        
        if ( isdefined( anglesarr ) )
        {
            foreach ( weaponname, rotationref in leveldataforvehicle.rotationrefsbyseatandweapon[ seatid ] )
            {
                entangles = anglesarr[ weaponname ];
                
                if ( isdefined( entangles ) )
                {
                    entrotation = angleclamp( entangles[ 1 ] );
                    set_rotation( vehicle vehicle::get_ref(), rotationref, entrotation, client );
                }
            }
        }
    }
}

// Namespace vehicle_omnvar
// Params 2
// Checksum 0xde3d9bc9, Offset: 0x33ac
// Size: 0x152
function function_958654161cd92cc8( vehicle, data )
{
    if ( isdefined( data ) && isdefined( data.localangles ) )
    {
        return data.rotationentangles;
    }
    
    leveldataforvehicle = get_data( vehicle vehicle::get_ref(), 1 );
    ents = vehicle::get_turrets( vehicle );
    
    if ( isdefined( leveldataforvehicle.mainturretweapon ) && isdefined( vehicle gettagorigin( "tag_flash" ) ) )
    {
        ents[ leveldataforvehicle.mainturretweapon ] = vehicle;
    }
    
    if ( ents.size > 0 )
    {
        entangles = [];
        vehicleanglesinverted = invertangles( vehicle.angles );
        
        foreach ( weaponname, ent in ents )
        {
            entangles[ weaponname ] = combineangles( vehicleanglesinverted, ent gettagangles( "tag_flash" ) );
        }
        
        if ( isdefined( data ) )
        {
            data.rotationentangles = entangles;
        }
        
        return entangles;
    }
}

// Namespace vehicle_omnvar
// Params 2, eflags: 0x4
// Checksum 0x4ed0371a, Offset: 0x3507
// Size: 0x28
function private function_476aa03004b524d4( omnvar, value )
{
    if ( self function_5c766d1d0140b86( omnvar ) )
    {
        self setclientomnvar( omnvar, value );
    }
}

