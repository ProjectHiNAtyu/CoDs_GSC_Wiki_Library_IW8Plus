// script_72d1ece3cbd0884a  (hash_72d1ece3cbd0884a.gscc) (size: 3924 Bytes / 0xf54 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7650cad3 (1985006291)
// size ...... 3924 (0xf54)
// includes .. 5   (offset: 0xee8)
// strings ... 5   (offset: 0xf10)
// dev strs .. 0   (offset: 0xf54)
// exports ... 10  (offset: 0x9a8)
// cseg ...... 0x80 + 0x928 (0x9a8)
// imports ... 31  (offset: 0xb38)
// animtree1 . 0   (offset: 0xf54)
// animtree2 . 0   (offset: 0xf54)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\loot\common_item;

#namespace namespace_4bd17a2ee56036fa;

// Namespace namespace_4bd17a2ee56036fa
// Params 0, eflags: 0x5
// Checksum 0xfeb18fdf, Offset: 0x9e
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"vehicle_pickup", #"common_item", &function_ec0d4ae21fd84a0d, undefined );
}

// Namespace namespace_4bd17a2ee56036fa
// Params 1
// Checksum 0x754ce91c, Offset: 0xc7
// Size: 0x74
function function_5cfef02beb796343( newsubtype )
{
    if ( !newsubtype || !common_item::items_isenabled() )
    {
        return;
    }
    
    if ( !isdefined( level.commonitem.var_d477430b22cb1a46 ) )
    {
        level.commonitem.var_d477430b22cb1a46 = [];
    }
    
    level.commonitem.var_d477430b22cb1a46[ level.commonitem.var_d477430b22cb1a46.size ] = newsubtype;
}

// Namespace namespace_4bd17a2ee56036fa
// Params 0, eflags: 0x4
// Checksum 0x23aa3bf8, Offset: 0x143
// Size: 0x94
function private function_ec0d4ae21fd84a0d()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    level.commonitem.var_7eb2e960f9f5eb33 = [];
    level.commonitem.var_fe191256b91b933b = [];
    callback::add( #"player_vehicle_enter", &function_1becb8455ab9713 );
    callback::add( #"player_vehicle_exit", &function_548698841741aeda );
    callback::add( #"player_disconnect", &onplayerdisconnect );
    utility::registersharedfunc( #"vehicle_pickup", #"databaseadditem", &databaseadditem );
}

// Namespace namespace_4bd17a2ee56036fa
// Params 1, eflags: 0x4
// Checksum 0x46253408, Offset: 0x1df
// Size: 0x158
function private databaseadditem( itembundlename )
{
    itembundle = getscriptbundlefieldvalues( itembundlename, [ #"subtype", #"scriptable", #"perplayerscriptable" ] );
    
    if ( !isdefined( level.commonitem.var_d477430b22cb1a46 ) || !arraycontains( level.commonitem.var_d477430b22cb1a46, itembundle.subtype ) )
    {
        return;
    }
    
    if ( itembundle.scriptable && !arraycontains( level.commonitem.var_7eb2e960f9f5eb33, itembundle.scriptable ) )
    {
        level.commonitem.var_7eb2e960f9f5eb33[ level.commonitem.var_7eb2e960f9f5eb33.size ] = itembundle.scriptable;
    }
    
    if ( itembundle.perplayerscriptable && !arraycontains( level.commonitem.var_7eb2e960f9f5eb33, itembundle.perplayerscriptable ) )
    {
        level.commonitem.var_7eb2e960f9f5eb33[ level.commonitem.var_7eb2e960f9f5eb33.size ] = itembundle.perplayerscriptable;
    }
}

// Namespace namespace_4bd17a2ee56036fa
// Params 1, eflags: 0x4
// Checksum 0xdcb6e0f, Offset: 0x33f
// Size: 0xcb
function private onplayerdisconnect( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    playerent = self getentitynumber();
    
    foreach ( key in getarraykeys( level.commonitem.var_fe191256b91b933b ) )
    {
        if ( level.commonitem.var_fe191256b91b933b[ key ][ playerent ] )
        {
            function_953bf97e4969ad89( playerent, key );
            break;
        }
    }
}

// Namespace namespace_4bd17a2ee56036fa
// Params 1, eflags: 0x4
// Checksum 0xb7d230d7, Offset: 0x412
// Size: 0xb8
function private function_1becb8455ab9713( params )
{
    vehicle = params.vehicle;
    
    if ( !vehicle )
    {
        return;
    }
    
    vehicleent = vehicle getentitynumber();
    
    if ( level.commonitem.var_fe191256b91b933b[ vehicleent ] )
    {
        return;
    }
    
    player = params.player;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    level.commonitem.var_fe191256b91b933b[ vehicleent ] = [];
    level thread function_a9c970fc8b0fe599( vehicle );
    level.commonitem.var_fe191256b91b933b[ vehicleent ][ player getentitynumber() ] = gettime();
}

// Namespace namespace_4bd17a2ee56036fa
// Params 1, eflags: 0x4
// Checksum 0xf2f1c2f3, Offset: 0x4d2
// Size: 0x8f
function private function_548698841741aeda( params )
{
    vehicle = params.vehicle;
    
    if ( !vehicle )
    {
        return;
    }
    
    vehicleent = vehicle getentitynumber();
    
    if ( !level.commonitem.var_fe191256b91b933b[ vehicleent ] )
    {
        return;
    }
    
    player = params.player;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    playerent = player getentitynumber();
    function_953bf97e4969ad89( playerent, vehicleent );
}

// Namespace namespace_4bd17a2ee56036fa
// Params 2, eflags: 0x4
// Checksum 0x9e6d0ec, Offset: 0x569
// Size: 0xa5
function private function_953bf97e4969ad89( playerent, vehicleent )
{
    if ( !isdefined( playerent ) )
    {
        return;
    }
    
    if ( !isdefined( vehicleent ) )
    {
        return;
    }
    
    level.commonitem.var_fe191256b91b933b[ vehicleent ][ playerent ] = undefined;
    
    if ( level.commonitem.var_fe191256b91b933b[ vehicleent ].size == 0 )
    {
        level.commonitem.var_fe191256b91b933b[ vehicleent ] = undefined;
        vehicle = level.vehicle.all[ vehicleent ];
        
        if ( !vehicle )
        {
            return;
        }
        
        vehicle notify( #"hash_665660bf33e23ad5" );
    }
}

// Namespace namespace_4bd17a2ee56036fa
// Params 1, eflags: 0x4
// Checksum 0xa54ac5da, Offset: 0x616
// Size: 0x392
function private function_a9c970fc8b0fe599( vehicle )
{
    vehicle endon( #"death" );
    vehicle endon( #"hash_665660bf33e23ad5" );
    vehicle_half_size = function_decb653c5689e4ca( vehicle.model );
    vehicle_half_size += ( 15, 15, 25 );
    
    while ( true )
    {
        wait 0.25;
        
        if ( !isdefined( vehicle ) )
        {
            return;
        }
        
        driver = vehicle_occupancy::get_driver( vehicle );
        
        if ( !isplayer( driver ) )
        {
            continue;
        }
        
        var_9b8039cbd7c4dfd5 = vehicle function_48cbebbf2007bfd1();
        var_29fc63bf79c91d2f = vectorlerp( var_9b8039cbd7c4dfd5[ "min" ], var_9b8039cbd7c4dfd5[ "max" ], 0.5 );
        var_33116650bb8f92fd = length( ( var_9b8039cbd7c4dfd5[ "max" ] - var_9b8039cbd7c4dfd5[ "min" ] ) * 0.5 );
        vehicle_axis_array = anglestoaxis( vehicle.angles );
        vehicle_axis_vecs = [ vehicle_axis_array[ "forward" ], vehicle_axis_array[ "right" ], vehicle_axis_array[ "up" ] ];
        scriptables = getlootscriptablearrayinradius( undefined, undefined, var_29fc63bf79c91d2f, var_33116650bb8f92fd );
        
        foreach ( scriptable in scriptables )
        {
            if ( !scriptable getscriptableisusableonanypart() || !arraycontains( level.commonitem.var_7eb2e960f9f5eb33, getxhashasset( scriptable.type ) ) )
            {
                continue;
            }
            
            collision = 1;
            var_c503eb263a92acdc = scriptable.origin - var_29fc63bf79c91d2f;
            
            for ( i = 0; i <= 2 ; i++ )
            {
                var_d56a855b177e74b7 = abs( vectordot( vehicle_axis_vecs[ i ], var_c503eb263a92acdc ) );
                
                if ( var_d56a855b177e74b7 > vehicle_half_size[ i ] )
                {
                    collision = 0;
                    break;
                }
            }
            
            if ( !collision )
            {
                continue;
            }
            
            if ( scriptable.var_7a65426f252841e7 )
            {
                foreach ( player in vehicle.occupants )
                {
                    if ( scriptable.owningplayer == player )
                    {
                        common_item::items_scriptable_used( scriptable, undefined, undefined, player, 1 );
                        break;
                    }
                }
                
                if ( !isdefined( scriptable ) )
                {
                    continue;
                }
                
                foreach ( player in level.players )
                {
                    if ( player getmovingplatformparent() == vehicle && scriptable.owningplayer == player )
                    {
                        common_item::items_scriptable_used( scriptable, undefined, undefined, player, 1 );
                        break;
                    }
                }
                
                continue;
            }
            
            common_item::items_scriptable_used( scriptable, undefined, undefined, driver, 1 );
        }
    }
}

