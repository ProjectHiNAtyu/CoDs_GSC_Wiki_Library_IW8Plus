// scripts\common\vehicle_interact.gsc  (hash_0caf1d000c52b25d.gscc) (size: 37675 Bytes / 0x932b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6006a36b (1611047787)
// size ...... 37675 (0x932b)
// includes .. 10  (offset: 0x8cd3)
// strings ... 80  (offset: 0x8d23)
// dev strs .. 25  (offset: 0x91ef)
// exports ... 110 (offset: 0x5fb7)
// cseg ...... 0x70d + 0x58aa (0x5fb7)
// imports ... 212 (offset: 0x70e7)
// animtree1 . 0   (offset: 0x932b)
// animtree2 . 0   (offset: 0x932b)
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_omnvar_utility;
#using scripts\common\vehicle_spawn;
#using scripts\common\vehicle_tracking;

#namespace vehicle_interact;

// Namespace vehicle_interact
// Params 3
// Checksum 0x9658836b, Offset: 0x72b
// Size: 0x10b
function get_data( vehicleref, create, var_e6c819f806ce2c86 )
{
    data = vehicle::has_data( vehicleref ) ? vehicle::get_data( vehicleref ) : undefined;
    
    if ( !isdefined( data.interact ) && create )
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
        
        if ( !isdefined( data.interact ) )
        {
            data.interact = spawnstruct();
        }
        
        data.interact.interactiontypes = [];
        data.interact.maxfuel = 180;
        data.interact.var_a5b1ad5fd2654e9a = 130;
        data.interact.var_a5d4975fd28b65f0 = 170;
        vehicle::add_data( vehicleref, data );
    }
    
    return data.interact;
}

// Namespace vehicle_interact
// Params 3
// Checksum 0x86325853, Offset: 0x83f
// Size: 0x175
function get_instance_data( vehicle, create, var_e6c819f806ce2c86 )
{
    if ( getdvarint( @"hash_74cacae425805743", 0 ) > 0 )
    {
        return;
    }
    
    instancedataforvehicle = vehicle.interactdata;
    
    if ( !isdefined( instancedataforvehicle ) )
    {
        leveldataforvehicle = get_data( vehicle vehicle::get_ref(), create, var_e6c819f806ce2c86 );
        
        if ( !isdefined( leveldataforvehicle ) )
        {
            return;
        }
        
        if ( !isdefined( vehicle getlinkedscriptableinstance() ) )
        {
            return;
        }
        
        if ( create )
        {
            instancedataforvehicle = spawnstruct();
            vehicle.interactdata = instancedataforvehicle;
            instancedataforvehicle.disabledbyallow = 0;
            instancedataforvehicle.pointdata = [];
            
            foreach ( pointref in leveldataforvehicle.interactiontypes )
            {
                instancedataforvehicle.pointdata[ pointref ] = function_c358ea472bd810ac( vehicle, pointref, create, var_e6c819f806ce2c86 );
            }
            
            instancedataforvehicle.dirty = 1;
            instancedataforvehicle.disabled = undefined;
            instancedataforvehicle.availableteam = undefined;
        }
        else
        {
            assert( var_e6c819f806ce2c86, "<dev string:x24>" );
        }
    }
    
    return instancedataforvehicle;
}

// Namespace vehicle_interact
// Params 3
// Checksum 0xae99932c, Offset: 0x9bd
// Size: 0x96
function activate_interaction_type( vehicleref, pointref, activationdata )
{
    leveldataforvehicle = get_data( vehicleref, undefined, 1 );
    
    if ( !isdefined( leveldataforvehicle ) )
    {
        return;
    }
    
    var_36d4ce271b7837bc = function_ac67a068455698f6( pointref );
    assert( isdefined( var_36d4ce271b7837bc ), "<dev string:x6f>" + pointref + "<dev string:x90>" );
    leveldataforvehicle.interactiontypes[ leveldataforvehicle.interactiontypes.size ] = pointref;
    function_e27bbc419afe6871( "activate", pointref, activationdata, leveldataforvehicle );
}

// Namespace vehicle_interact
// Params 1
// Checksum 0xd983b4c4, Offset: 0xa5b
// Size: 0x20
function register_instance( vehicle )
{
    get_instance_data( vehicle, 1 );
    update_usability( vehicle );
}

// Namespace vehicle_interact
// Params 1
// Checksum 0x7c2a2497, Offset: 0xa83
// Size: 0x20
function deregister_instance( vehicle )
{
    make_unusable( vehicle );
    vehicle.interactdata = undefined;
}

// Namespace vehicle_interact
// Params 1
// Checksum 0xfdbe4616, Offset: 0xaab
// Size: 0x18, Type: bool
function instance_is_registered( vehicle )
{
    return isdefined( vehicle.interactdata );
}

// Namespace vehicle_interact
// Params 1
// Checksum 0x5f080871, Offset: 0xacc
// Size: 0x1a5
function allow_use_global( bool )
{
    leveldata = get_level_data();
    vehicles = vehicle_tracking::function_5820a38c9873992e();
    
    if ( !isdefined( vehicles ) )
    {
        return;
    }
    
    if ( !bool )
    {
        leveldata.disabledbyallow++;
        
        if ( leveldata.disabledbyallow == 1 )
        {
            foreach ( vehicle in vehicles )
            {
                if ( !isdefined( get_instance_data( vehicle ) ) )
                {
                    continue;
                }
                
                set_dirty( vehicle );
                update_usability( vehicle );
            }
        }
        
        return;
    }
    
    assert( leveldata.disabledbyallow > 0, "<dev string:xc8>" + bool + "<dev string:xf0>" );
    leveldata.disabledbyallow--;
    
    if ( leveldata.disabledbyallow == 0 )
    {
        foreach ( vehicle in vehicles )
        {
            if ( !isdefined( get_instance_data( vehicle ) ) )
            {
                continue;
            }
            
            set_dirty( vehicle );
            update_usability( vehicle );
        }
    }
}

// Namespace vehicle_interact
// Params 2
// Checksum 0x91ad0e5a, Offset: 0xc79
// Size: 0xbd
function allow_use( vehicle, bool )
{
    instancedataforvehicle = get_instance_data( vehicle, undefined, 1 );
    
    if ( !isdefined( instancedataforvehicle ) )
    {
        return;
    }
    
    if ( !bool )
    {
        instancedataforvehicle.disabledbyallow++;
        
        if ( instancedataforvehicle.disabledbyallow == 1 )
        {
            set_dirty( vehicle );
            update_usability( vehicle );
        }
        
        return;
    }
    
    assert( instancedataforvehicle.disabledbyallow > 0, "<dev string:x116>" + bool + "<dev string:xf0>" );
    instancedataforvehicle.disabledbyallow--;
    
    if ( instancedataforvehicle.disabledbyallow == 0 )
    {
        set_dirty( vehicle );
        update_usability( vehicle );
    }
}

// Namespace vehicle_interact
// Params 2
// Checksum 0xfce80155, Offset: 0xd3e
// Size: 0x29
function function_c9835ad3c3e5dab2( vehicle, scriptable_part )
{
    vehicle.var_dcc4310e5380a5c9[ scriptable_part ] = "single";
}

// Namespace vehicle_interact
// Params 1
// Checksum 0xf70f60b0, Offset: 0xd6f
// Size: 0x51, Type: bool
function can_use( vehicle )
{
    leveldata = get_level_data();
    instancedataforvehicle = get_instance_data( vehicle, undefined, 1 );
    return leveldata.disabledbyallow == 0 && instancedataforvehicle.disabledbyallow == 0;
}

// Namespace vehicle_interact
// Params 1
// Checksum 0xdffe43d0, Offset: 0xdc9
// Size: 0x20
function function_7f6d4b46409d18b0( vehicle )
{
    if ( function_2942e71e54cd0a35( vehicle ) )
    {
        set_disabled_state( vehicle );
    }
}

// Namespace vehicle_interact
// Params 1
// Checksum 0x3010b3c8, Offset: 0xdf1
// Size: 0x86
function function_2942e71e54cd0a35( vehicle )
{
    dvarstring = hashcat( @"scr_", vehicle.vehiclename );
    
    if ( getdvar( dvarstring, "" ) == "" )
    {
        setdvar( dvarstring, "enable" );
    }
    
    println( "<dev string:x138>" + vehicle.vehiclename );
    dvarstatus = getdvar( dvarstring, "enable" ) == "disable";
    return dvarstatus;
}

// Namespace vehicle_interact
// Params 1
// Checksum 0x1b2748c2, Offset: 0xe80
// Size: 0x23
function set_disabled_state( vehicle )
{
    println( "<dev string:x149>" );
    allow_use( vehicle, 0 );
}

// Namespace vehicle_interact
// Params 0
// Checksum 0x57ec064e, Offset: 0xeab
// Size: 0x12d
function init()
{
    assert( isdefined( level.vehicle ), "<dev string:x15b>" );
    assert( !isdefined( level.vehicle.interact ), "<dev string:x191>" );
    leveldata = spawnstruct();
    level.vehicle.interact = leveldata;
    leveldata.interactiontypes = [];
    leveldata.disabledbyallow = 0;
    register_interaction_type( "single", &function_f0f37484aa7a76b5, &function_d1e96ed8551162f3, &function_fecc57c15668b2c3, &function_104c6c0ffb051ff8 );
    register_interaction_type( "upgrade", &function_93e5625d0761f3f7, &function_b45bbb4a007d4f69, &function_21c1135cab1ad90d, &function_ce94117e88989582 );
    register_interaction_type( "copyofupgrade", &function_93e5625d0761f3f7, &function_b45bbb4a007d4f69, &function_21c1135cab1ad90d, &function_ce94117e88989582 );
    level thread init_gas_stations();
    scriptable::scriptable_addusedcallback( &scriptable_used );
    
    if ( utility::issharedfuncdefined( #"vehicle_interact", #"init" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_interact", #"init" ) ]]();
    }
    
    level thread function_1f8597329cb7714e();
}

// Namespace vehicle_interact
// Params 1
// Checksum 0x138283a6, Offset: 0xfe0
// Size: 0x93
function function_bba2522f3d5de6e9( player )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    while ( true )
    {
        player waittill( #"luinotifyserver", notification );
        
        if ( !isdefined( notification ) )
        {
            continue;
        }
        
        var_800f9664a7db6ed2 = player.pers[ "telemetry" ];
        
        if ( notification == "vehicle_cruise_control_on" && isdefined( var_800f9664a7db6ed2.vehicle_autofwd_count ) )
        {
            var_800f9664a7db6ed2.vehicle_autofwd_count++;
        }
    }
}

// Namespace vehicle_interact
// Params 0
// Checksum 0x9984b45, Offset: 0x107b
// Size: 0x1f
function function_1f8597329cb7714e()
{
    while ( true )
    {
        waitframe();
        waittillframeend();
        level.vehicle.partition = undefined;
    }
}

// Namespace vehicle_interact
// Params 0
// Checksum 0x715ada86, Offset: 0x10a2
// Size: 0xf1
function create_partition()
{
    if ( isdefined( level.vehicle.partition ) )
    {
        return;
    }
    
    vehicles = vehicle_tracking::function_5820a38c9873992e();
    
    if ( isdefined( vehicles ) && vehicles.size > 0 )
    {
        level.vehicle.partition = utility::create_partition( [], 650 );
        
        foreach ( vehicle in vehicles )
        {
            if ( isdefined( vehicle ) && isdefined( vehicle.origin ) )
            {
                level.vehicle.partition utility::add_to_partition( vehicle );
            }
        }
    }
}

// Namespace vehicle_interact
// Params 5
// Checksum 0x9066c73a, Offset: 0x119b
// Size: 0xa1
function register_interaction_type( pointred, useinstancefunc, cleaninstancefunc, activatefunc, createinstancefunc )
{
    leveldata = get_level_data();
    interactiontype = spawnstruct();
    callbacks = [];
    callbacks[ "useInstance" ] = useinstancefunc;
    callbacks[ "cleanInstance" ] = cleaninstancefunc;
    callbacks[ "activate" ] = activatefunc;
    callbacks[ "createInstance" ] = createinstancefunc;
    interactiontype.callbacks = callbacks;
    leveldata.interactiontypes[ pointred ] = interactiontype;
}

// Namespace vehicle_interact
// Params 6
// Checksum 0xde9a4a29, Offset: 0x1244
// Size: 0xd1
function scriptable_used( instance, part, state, player, bautouse, usestring )
{
    if ( state == "vehicle_use" || state == "vehicle_use_alternate" )
    {
        vehicle = instance.entity;
        pointref = vehicle.var_dcc4310e5380a5c9[ part ] ?? part;
        assert( isdefined( vehicle ), "<dev string:x1c5>" );
        
        if ( function_a6656fc74b98d1c9( player, vehicle ) )
        {
            if ( point_can_be_used( vehicle, pointref ) )
            {
                instancedataforpoint = function_c358ea472bd810ac( vehicle, pointref );
                function_e27bbc419afe6871( "useInstance", pointref, instancedataforpoint, vehicle, player );
            }
        }
    }
}

// Namespace vehicle_interact
// Params 2
// Checksum 0x6d260296, Offset: 0x131d
// Size: 0x1a8
function update_player_usability( player, vehicles )
{
    if ( !function_89e68d4b41153c0e( player ) )
    {
        foreach ( vehicle in vehicles )
        {
            if ( isdefined( vehicle ) && vehicle getscriptablehaspart( "single" ) )
            {
                vehicle disablescriptablepartplayeruse( "single", player );
            }
        }
        
        return;
    }
    
    foreach ( vehicle in vehicles )
    {
        if ( !isdefined( vehicle ) )
        {
            continue;
        }
        
        if ( utility::issharedfuncdefined( #"equipment", #"updateuseobj" ) && arraycontains( level.useobjs, vehicle ) )
        {
            vehicle utility::callsharedfunc( #"equipment", #"updateuseobj" );
            continue;
        }
        
        if ( !vehicle getscriptablehaspart( "single" ) )
        {
            continue;
        }
        
        if ( function_a6656fc74b98d1c9( player, vehicle ) )
        {
            vehicle enablescriptableplayeruse( player );
            vehicle enablescriptablepartplayeruse( "single", player );
            continue;
        }
        
        vehicle disablescriptablepartplayeruse( "single", player );
    }
}

// Namespace vehicle_interact
// Params 1
// Checksum 0x29f4dcef, Offset: 0x14cd
// Size: 0x77
function function_f3db94c7cb6b6461( player )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    update_player_usability_func = level.func[ "update_player_usability" ];
    
    while ( true )
    {
        player waittill( #"update_vehicle_usability", vehiclelist );
        update_player_usability( player, vehiclelist );
        
        if ( isdefined( update_player_usability_func ) )
        {
            [[ update_player_usability_func ]]( player, vehiclelist );
        }
    }
}

// Namespace vehicle_interact
// Params 0, eflags: 0x4
// Checksum 0x783bbd84, Offset: 0x154c
// Size: 0x4d
function private get_level_data()
{
    assert( isdefined( level.vehicle ), "<dev string:x209>" );
    assert( isdefined( level.vehicle.interact ), "<dev string:x247>" );
    return level.vehicle.interact;
}

// Namespace vehicle_interact
// Params 1, eflags: 0x4
// Checksum 0x29c9c8ee, Offset: 0x15a2
// Size: 0x64
function private function_ac67a068455698f6( pointref )
{
    assert( isdefined( level.vehicle ), "<dev string:x209>" );
    assert( isdefined( level.vehicle.interact ), "<dev string:x247>" );
    return level.vehicle.interact.interactiontypes[ pointref ];
}

// Namespace vehicle_interact
// Params 5
// Checksum 0x8e41d7f9, Offset: 0x160f
// Size: 0x6e
function function_e27bbc419afe6871( callbackref, pointref, var_1d4b2087eab22320, var_7b5d8787732336f6, var_9661ab9a54353ed4 )
{
    var_36d4ce271b7837bc = function_ac67a068455698f6( pointref );
    callbackfunc = var_36d4ce271b7837bc.callbacks[ callbackref ];
    
    if ( isdefined( callbackfunc ) )
    {
        level thread [[ callbackfunc ]]( pointref, var_1d4b2087eab22320, var_7b5d8787732336f6, var_9661ab9a54353ed4 );
    }
}

// Namespace vehicle_interact
// Params 1
// Checksum 0x434a40f8, Offset: 0x1685
// Size: 0xb5, Type: bool
function function_89e68d4b41153c0e( player )
{
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    if ( !player utility::callsharedfunc( #"player", #"playerisalive" ) )
    {
        return false;
    }
    
    if ( !player val::get( "vehicle_use" ) )
    {
        return false;
    }
    
    if ( player isparachuting() || player isskydiving() )
    {
        return false;
    }
    
    if ( player isemoteactive() )
    {
        return false;
    }
    
    if ( player utility::callsharedfunc( #"execution", #"isinexecutionattack" ) || player utility::callsharedfunc( #"execution", #"isinexecutionvictim" ) )
    {
        return false;
    }
    
    if ( level.infiltransistioning )
    {
        return false;
    }
    
    return true;
}

// Namespace vehicle_interact
// Params 2
// Checksum 0x87d3bbdf, Offset: 0x1743
// Size: 0xb0, Type: bool
function vehicle_can_be_used( vehicle, ignoreallows = 0 )
{
    if ( get_data( vehicle vehicle::get_ref(), 0, 1 ).var_c3d9b257664dde2a )
    {
        return false;
    }
    
    spawndata = vehicle vehicle_tracking::get_spawn_data();
    
    if ( spawndata && spawndata vehicle_spawn::has_flag( 6 ) )
    {
        return false;
    }
    
    if ( ignoreallows )
    {
        return true;
    }
    
    instancedataforvehicle = get_instance_data( vehicle, 1, 1 );
    
    if ( !isdefined( instancedataforvehicle ) )
    {
        return false;
    }
    
    if ( instancedataforvehicle.dirty )
    {
        clean_vehicle( vehicle );
    }
    
    return !instancedataforvehicle.disabled;
}

// Namespace vehicle_interact
// Params 2
// Checksum 0x58b056c4, Offset: 0x17fc
// Size: 0x59
function point_can_be_used( vehicle, pointref )
{
    instancedataforpoint = function_c358ea472bd810ac( vehicle, pointref, undefined, 1 );
    
    if ( !isdefined( instancedataforpoint ) )
    {
        return;
    }
    
    if ( instancedataforpoint.dirty )
    {
        clean_point( vehicle, pointref );
    }
    
    return !instancedataforpoint.disabled;
}

// Namespace vehicle_interact
// Params 3
// Checksum 0xf69ad241, Offset: 0x185e
// Size: 0xcd, Type: bool
function function_a6656fc74b98d1c9( player, vehicle, ignoreallows = 0 )
{
    if ( !function_89e68d4b41153c0e( player ) )
    {
        return false;
    }
    
    if ( !vehicle_can_be_used( vehicle, ignoreallows ) )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_472ba7dac83dd31a", 0 ) == 1 )
    {
        return true;
    }
    
    if ( level.vehiclelockingenabled )
    {
        return true;
    }
    else if ( level.teambased )
    {
        team = function_9c8b1439410b3157( vehicle );
        
        if ( isdefined( team ) && team != player.team )
        {
            return false;
        }
    }
    else
    {
        playerfriendlyto = vehicle_occupancy::get_player_friendly_to( vehicle );
        
        if ( isdefined( playerfriendlyto ) && playerfriendlyto != player )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace vehicle_interact
// Params 1
// Checksum 0x1876c5e4, Offset: 0x1934
// Size: 0x4d
function function_9c8b1439410b3157( vehicle )
{
    instancedataforvehicle = get_instance_data( vehicle, undefined, 1 );
    
    if ( !isdefined( instancedataforvehicle ) )
    {
        return;
    }
    
    if ( instancedataforvehicle.dirty )
    {
        clean_vehicle( vehicle );
    }
    
    return instancedataforvehicle.availableteam;
}

// Namespace vehicle_interact
// Params 1
// Checksum 0xb1d2c944, Offset: 0x198a
// Size: 0x39
function set_dirty( vehicle )
{
    instancedataforvehicle = get_instance_data( vehicle, undefined, 1 );
    
    if ( !isdefined( instancedataforvehicle ) )
    {
        return;
    }
    
    instancedataforvehicle.dirty = 1;
}

// Namespace vehicle_interact
// Params 1
// Checksum 0x28f1d0f5, Offset: 0x19cb
// Size: 0x45
function set_visibility( show )
{
    if ( isdefined( self ) && self isscriptable() && self getscriptablehaspart( "visibility" ) )
    {
        self setscriptablepartstate( "visibility", show ? "show" : "hide" );
    }
}

// Namespace vehicle_interact
// Params 2
// Checksum 0x33a5706, Offset: 0x1a18
// Size: 0x35
function function_47e152e968cd4175( vehicle, team )
{
    vehicle.var_b2e7239d17459c75 = team;
    set_dirty( vehicle );
    update_usability( vehicle );
}

// Namespace vehicle_interact
// Params 1
// Checksum 0x2ff856d0, Offset: 0x1a55
// Size: 0x29
function function_3472852a583f6547( vehicle )
{
    vehicle.var_b2e7239d17459c75 = undefined;
    set_dirty( vehicle );
    update_usability( vehicle );
}

// Namespace vehicle_interact
// Params 1
// Checksum 0xa4c592b, Offset: 0x1a86
// Size: 0x19f
function clean_vehicle( vehicle )
{
    leveldata = get_level_data();
    instancedataforvehicle = get_instance_data( vehicle, undefined, 1 );
    
    if ( !isdefined( instancedataforvehicle ) )
    {
        return;
    }
    
    if ( vehicle.var_b2e7239d17459c75 )
    {
        instancedataforvehicle.availableteam = vehicle.var_b2e7239d17459c75;
    }
    else if ( level.teambased )
    {
        teamfriendlyto = vehicle_occupancy::function_88fc32afbd317644( vehicle );
        
        if ( isdefined( teamfriendlyto ) )
        {
            instancedataforvehicle.availableteam = teamfriendlyto;
        }
        else
        {
            availableteam = undefined;
            reserving = vehicle_occupancy::get_reserving( vehicle );
            
            foreach ( player in reserving )
            {
                if ( isplayer( player ) )
                {
                    availableteam = player.team;
                    break;
                }
            }
            
            instancedataforvehicle.availableteam = availableteam;
        }
    }
    
    if ( leveldata.disabledbyallow > 0 )
    {
        instancedataforvehicle.disabled = 1;
    }
    else if ( instancedataforvehicle.disabledbyallow > 0 )
    {
        instancedataforvehicle.disabled = 1;
    }
    else
    {
        instancedataforvehicle.disabled = 0;
    }
    
    instancedataforvehicle.dirty = 0;
}

// Namespace vehicle_interact
// Params 4
// Checksum 0x21e98800, Offset: 0x1c2d
// Size: 0xc3
function function_c358ea472bd810ac( vehicle, pointref, create, var_e6c819f806ce2c86 )
{
    instancedataforvehicle = get_instance_data( vehicle, create, var_e6c819f806ce2c86 );
    
    if ( !isdefined( instancedataforvehicle ) )
    {
        return;
    }
    
    instancedataforpoint = instancedataforvehicle.pointdata[ pointref ];
    
    if ( !isdefined( instancedataforpoint ) && isdefined( create ) )
    {
        if ( create )
        {
            instancedataforpoint = spawnstruct();
            instancedataforvehicle.pointdata[ pointref ] = instancedataforpoint;
            instancedataforpoint.dirty = 1;
            instancedataforpoint.disabled = undefined;
            function_e27bbc419afe6871( "createInstance", pointref, instancedataforpoint, vehicle );
        }
        else
        {
            assert( var_e6c819f806ce2c86, "<dev string:x28e>" );
        }
    }
    
    return instancedataforpoint;
}

// Namespace vehicle_interact
// Params 2
// Checksum 0xc6e50fc3, Offset: 0x1cf9
// Size: 0x43
function set_point_dirty( vehicle, pointref )
{
    instancedataforpoint = function_c358ea472bd810ac( vehicle, pointref, undefined, 1 );
    
    if ( !isdefined( instancedataforpoint ) )
    {
        return;
    }
    
    instancedataforpoint.dirty = 1;
}

// Namespace vehicle_interact
// Params 1
// Checksum 0xbe9e931e, Offset: 0x1d44
// Size: 0xb7
function set_points_dirty( vehicle )
{
    instancedataforvehicle = get_instance_data( vehicle, undefined, 1 );
    
    if ( !isdefined( instancedataforvehicle ) )
    {
        return;
    }
    
    foreach ( pointdata in instancedataforvehicle.pointdata )
    {
        pointdata.dirty = 1;
    }
    
    instancedataforvehicle.dirty = 1;
}

// Namespace vehicle_interact
// Params 2
// Checksum 0x4149787d, Offset: 0x1e03
// Size: 0x52
function clean_point( vehicle, pointref )
{
    instancedataforpoint = function_c358ea472bd810ac( vehicle, pointref, undefined, 1 );
    
    if ( !isdefined( instancedataforpoint ) )
    {
        return;
    }
    
    function_e27bbc419afe6871( "cleanInstance", pointref, instancedataforpoint, vehicle );
    instancedataforpoint.dirty = 0;
}

// Namespace vehicle_interact
// Params 1, eflags: 0x4
// Checksum 0xec7210a9, Offset: 0x1e5d
// Size: 0x114
function private make_unusable( vehicle )
{
    instancedataforvehicle = get_instance_data( vehicle, undefined, 1 );
    
    if ( !isdefined( instancedataforvehicle ) )
    {
        return;
    }
    
    if ( get_data( vehicle vehicle::get_ref() ).var_c3d9b257664dde2a )
    {
        return;
    }
    
    pointrefs = getarraykeys( instancedataforvehicle.pointdata );
    
    foreach ( pointref in pointrefs )
    {
        pingable = getdvarint( @"hash_a0e116e1d95f28a9", 0 ) && vehicle getscriptableparthasstate( pointref, "vehicle_unusable_pingable" );
        state = pingable ? "vehicle_unusable_pingable" : "vehicle_unusable";
        vehicle setscriptablepartstate( pointref, state );
    }
}

// Namespace vehicle_interact
// Params 1
// Checksum 0xeb318951, Offset: 0x1f79
// Size: 0x17d
function update_usability( vehicle )
{
    instancedataforvehicle = get_instance_data( vehicle, undefined, 1 );
    
    if ( !isdefined( instancedataforvehicle ) )
    {
        return;
    }
    
    if ( get_data( vehicle vehicle::get_ref() ).var_c3d9b257664dde2a )
    {
        return;
    }
    
    if ( instancedataforvehicle.dirty )
    {
        clean_vehicle( vehicle );
    }
    
    if ( instancedataforvehicle.disabled )
    {
        make_unusable( vehicle );
        return;
    }
    
    foreach ( pointref, pointdata in instancedataforvehicle.pointdata )
    {
        if ( pointdata.dirty )
        {
            clean_point( vehicle, pointref );
        }
        
        if ( pointdata.disabled )
        {
            pingable = getdvarint( @"hash_a0e116e1d95f28a9", 0 ) && vehicle getscriptableparthasstate( pointref, "vehicle_unusable_pingable" );
            state = pingable ? "vehicle_unusable_pingable" : "vehicle_unusable";
            vehicle setscriptablepartstate( pointref, state );
            continue;
        }
        
        vehicle setscriptablepartstate( pointref, self.var_8c8c031aad313a6e ? "vehicle_use_alternate" : "vehicle_use" );
    }
}

// Namespace vehicle_interact
// Params 0
// Checksum 0x83b7c129, Offset: 0x20fe
// Size: 0x1d
function function_4072ef4889a9bcf9()
{
    self.var_8c8c031aad313a6e = 1;
    self setscriptablepartstate( "single", "vehicle_use_alternate" );
}

// Namespace vehicle_interact
// Params 0
// Checksum 0xea5039ca, Offset: 0x2123
// Size: 0x14
function function_bde1bf9cea98120()
{
    self.var_8c8c031aad313a6e = undefined;
    update_usability( self );
}

// Namespace vehicle_interact
// Params 4
// Checksum 0xd6b49028, Offset: 0x213f
// Size: 0xc8
function function_f0f37484aa7a76b5( pointref, instancedataforpoint, vehicle, player )
{
    seatid = instancedataforpoint.availableseatid;
    
    if ( seatid != "driver" && seatid != "gunner" )
    {
        seatid = get_closest_seat( player, vehicle, seatid );
    }
    
    /#
        forceseatid = getdvarint( @"hash_fb517a5a3d736fa0", 0 );
        
        if ( forceseatid > 0 )
        {
            seatids = vehicle_occupancy::function_8a8e1601e7e6610( vehicle );
            forceseatid = int( min( forceseatid - 1, seatids.size - 1 ) );
            seatid = seatids[ forceseatid ];
            iprintlnbold( "<dev string:x2d8>" + seatid );
        }
    #/
    
    thread vehicle_occupancy::enter( vehicle, seatid, player );
}

// Namespace vehicle_interact
// Params 3
// Checksum 0x993119c2, Offset: 0x220f
// Size: 0x12e
function get_closest_seat( player, vehicle, nextavailableseat )
{
    closestseat = nextavailableseat;
    closestdistancesqr = undefined;
    
    foreach ( seatid, seatdata in vehicle::get_data( vehicle vehicle::get_ref() ).occupancy.seatdata )
    {
        if ( vehicle_occupancy::is_seat_available( vehicle, seatid ) && isdefined( seatdata.animtag ) )
        {
            if ( seatdata.var_f10b778a5f7f1c62 )
            {
                continue;
            }
            
            distancesqr = distancesquared( player.origin, vehicle gettagorigin( seatdata.animtag ) );
            
            if ( !isdefined( closestdistancesqr ) || distancesqr < closestdistancesqr )
            {
                closestseat = seatid;
                closestdistancesqr = distancesqr;
            }
        }
    }
    
    return closestseat;
}

// Namespace vehicle_interact
// Params 4
// Checksum 0xf9783897, Offset: 0x2346
// Size: 0xf1
function function_d1e96ed8551162f3( pointref, instancedataforpoint, vehicle, unusedtwo )
{
    var_30c65d47028f9ff4 = instancedataforpoint.var_30c65d47028f9ff4;
    assert( isdefined( var_30c65d47028f9ff4 ), "<dev string:x2e2>" );
    availableseatid = undefined;
    
    foreach ( seatid in var_30c65d47028f9ff4 )
    {
        if ( vehicle_occupancy::is_seat_available( vehicle, seatid ) )
        {
            availableseatid = seatid;
            break;
        }
    }
    
    instancedataforpoint.disabled = !isdefined( availableseatid );
    instancedataforpoint.availableseatid = availableseatid;
}

// Namespace vehicle_interact
// Params 4
// Checksum 0xbb7471c, Offset: 0x243f
// Size: 0x48
function function_fecc57c15668b2c3( pointref, var_30c65d47028f9ff4, leveldataforvehicle, unusedone )
{
    assert( isdefined( var_30c65d47028f9ff4 ), "<dev string:x31e>" );
    leveldataforvehicle.var_30c65d47028f9ff4 = var_30c65d47028f9ff4;
}

// Namespace vehicle_interact
// Params 4
// Checksum 0x8754fc6e, Offset: 0x248f
// Size: 0x82
function function_104c6c0ffb051ff8( pointref, instancedataforpoint, vehicle, unusedone )
{
    leveldataforvehicle = get_data( vehicle vehicle::get_ref(), undefined, 1 );
    assert( isdefined( leveldataforvehicle.var_30c65d47028f9ff4 ), "<dev string:x35f>" );
    instancedataforpoint.availableseatid = undefined;
    instancedataforpoint.var_30c65d47028f9ff4 = leveldataforvehicle.var_30c65d47028f9ff4;
}

// Namespace vehicle_interact
// Params 2
// Checksum 0x3d595c4c, Offset: 0x2519
// Size: 0x51
function function_b6d0fa9137efe75a( vehicle, player )
{
    if ( isdefined( vehicle ) )
    {
        if ( !isdefined( vehicle.var_e8cb705eb93ec8a4 ) )
        {
            vehicle.var_e8cb705eb93ec8a4 = [];
        }
        
        vehicle.var_e8cb705eb93ec8a4[ vehicle.var_e8cb705eb93ec8a4.size ] = player;
    }
}

// Namespace vehicle_interact
// Params 2
// Checksum 0x97d5b77c, Offset: 0x2572
// Size: 0x47
function function_f8ec5cbb44385eaa( vehicle, player )
{
    if ( isdefined( vehicle ) && isdefined( vehicle.var_e8cb705eb93ec8a4 ) )
    {
        vehicle.var_e8cb705eb93ec8a4 = arrayremove( vehicle.var_e8cb705eb93ec8a4, player );
    }
}

// Namespace vehicle_interact
// Params 4
// Checksum 0xe69dea16, Offset: 0x25c1
// Size: 0xea
function function_93e5625d0761f3f7( pointref, instancedataforpoint, vehicle, player )
{
    if ( utility::issharedfuncdefined( #"vehicle_upgrade", #"init" ) )
    {
        if ( !isdefined( level.br_pe_data ) )
        {
            /#
                iprintlnbold( "<dev string:x3ba>" );
            #/
            
            return;
        }
        
        [[ instancedataforpoint.var_8c69bee942766d37 ]]( vehicle, player );
        player setclientomnvar( "ui_buystation_override", instancedataforpoint.var_705fd52b7e08a3b1 );
        player.var_c305bd7c24a54d39 = 1;
        player.var_d5168c882218a620 = vehicle;
        function_b6d0fa9137efe75a( vehicle, player );
        var_699626b9a6f98958 = utility::getsharedfunc( #"vehicle_upgrade", #"init" );
        kiosk = function_32634a21e1b09dd7( vehicle, pointref );
        player thread [[ var_699626b9a6f98958 ]]( kiosk );
    }
}

// Namespace vehicle_interact
// Params 4
// Checksum 0x7dcff190, Offset: 0x26b3
// Size: 0x34
function function_b45bbb4a007d4f69( pointref, instancedataforpoint, vehicle, unusedtwo )
{
    instancedataforpoint.disabled = 0;
}

// Namespace vehicle_interact
// Params 4
// Checksum 0x38410f00, Offset: 0x26ef
// Size: 0xb0
function function_21c1135cab1ad90d( pointref, activationdata, leveldataforvehicle, unusedone )
{
    if ( !isdefined( leveldataforvehicle.kiosktagarrays ) )
    {
        leveldataforvehicle.kiosktagarrays = [];
    }
    
    if ( !isdefined( leveldataforvehicle.var_72e5ecefa1e310f0 ) )
    {
        leveldataforvehicle.var_72e5ecefa1e310f0 = [];
    }
    
    if ( !isdefined( leveldataforvehicle.var_8c69bee942766d37 ) )
    {
        leveldataforvehicle.var_8c69bee942766d37 = [];
    }
    
    leveldataforvehicle.kiosktagarrays[ pointref ] = activationdata[ 0 ];
    leveldataforvehicle.var_72e5ecefa1e310f0[ pointref ] = activationdata[ 1 ];
    leveldataforvehicle.var_8c69bee942766d37[ pointref ] = activationdata[ 2 ];
}

// Namespace vehicle_interact
// Params 4
// Checksum 0xaf8c0ecf, Offset: 0x27a7
// Size: 0xd6
function function_ce94117e88989582( pointref, instancedataforpoint, vehicle, unusedone )
{
    leveldataforvehicle = get_data( vehicle vehicle::get_ref(), undefined, 1 );
    assert( isdefined( leveldataforvehicle.kiosktagarrays ), "<dev string:x3ee>" );
    assert( isdefined( leveldataforvehicle.kiosktagarrays[ pointref ] ), "<dev string:x440>" );
    instancedataforpoint.var_705fd52b7e08a3b1 = leveldataforvehicle.var_72e5ecefa1e310f0[ pointref ];
    instancedataforpoint.var_8c69bee942766d37 = leveldataforvehicle.var_8c69bee942766d37[ pointref ];
    kiosktag = leveldataforvehicle.kiosktagarrays[ pointref ];
    function_b38df110f76c5fd5( vehicle, pointref, kiosktag );
}

// Namespace vehicle_interact
// Params 2
// Checksum 0x3f0e5db4, Offset: 0x2885
// Size: 0x5e
function function_32634a21e1b09dd7( vehicle, kioskid )
{
    assert( isdefined( vehicle.kioskstructs ), "<dev string:x49e>" );
    assert( isdefined( vehicle.kioskstructs[ kioskid ] ), "<dev string:x49e>" );
    return vehicle.kioskstructs[ kioskid ];
}

// Namespace vehicle_interact
// Params 3
// Checksum 0x8f28a0c5, Offset: 0x28ec
// Size: 0x64
function function_b38df110f76c5fd5( vehicle, kioskid, kiosktag )
{
    if ( !isdefined( vehicle.kioskstructs ) )
    {
        vehicle.kioskstructs = [];
    }
    
    kiosk = spawnstruct();
    kiosk thread function_40ee39bbaed07062( vehicle, kiosktag );
    vehicle.kioskstructs[ kioskid ] = kiosk;
}

// Namespace vehicle_interact
// Params 2
// Checksum 0xdffd1e73, Offset: 0x2958
// Size: 0x40
function function_40ee39bbaed07062( vehicle, kiosktag )
{
    vehicle endon( #"death" );
    
    while ( true )
    {
        self.origin = vehicle gettagorigin( kiosktag );
        wait 0.5;
    }
}

// Namespace vehicle_interact
// Params 2
// Checksum 0xa645e3bf, Offset: 0x29a0
// Size: 0x3c, Type: bool
function upgrade_activated( vehicle, upgradetype )
{
    init_upgrade( vehicle );
    return isdefined( vehicle.upgradeactivated ) && vehicle.upgradeactivated[ upgradetype ];
}

// Namespace vehicle_interact
// Params 1
// Checksum 0x87f6bbb2, Offset: 0x29e5
// Size: 0x27
function init_upgrade( vehicle )
{
    if ( !isdefined( vehicle.upgradeactivated ) )
    {
        vehicle.upgradeactivated = [];
    }
}

// Namespace vehicle_interact
// Params 3
// Checksum 0x9f722464, Offset: 0x2a14
// Size: 0x38
function give_upgrade( vehicle, upgradetype, player )
{
    set_upgrade_activated( vehicle, upgradetype );
    vehicle notify( #"give_upgrade", upgradetype, player );
}

// Namespace vehicle_interact
// Params 2
// Checksum 0x5fd53184, Offset: 0x2a54
// Size: 0x2f
function set_upgrade_activated( vehicle, upgradetype )
{
    init_upgrade( vehicle );
    vehicle.upgradeactivated[ upgradetype ] = 1;
}

// Namespace vehicle_interact
// Params 0
// Checksum 0xe0fd7ee, Offset: 0x2a8b
// Size: 0x5f
function fuel_is_enabled()
{
    if ( level.var_af2ad1dfcd5919b6 )
    {
        return 0;
    }
    
    if ( utility::callsharedfunc( #"game", #"isusingmatchrulesdata" ) )
    {
        return utility::callsharedfunc( #"game", #"getmatchrulesdata", "commonOption", "vehicleFuelEnabled" );
    }
    
    return getdvarint( @"scr_vehicle_fuel_enabled", 0 ) == 1;
}

// Namespace vehicle_interact
// Params 0, eflags: 0x4
// Checksum 0x6d9e1321, Offset: 0x2af3
// Size: 0x208
function private init_gas_stations()
{
    level endon( #"game_ended" );
    waitframe();
    
    if ( !fuel_is_enabled() )
    {
        return;
    }
    
    if ( getdvarint( @"hash_48bb9b301ddec6d5", 0 ) )
    {
        utility::flag_wait( "gas_station_create_script_initialized" );
    }
    
    gasstations = [];
    
    foreach ( gasstation in utility::getstructarray( "gas_station", "targetname" ) )
    {
        scriptable = spawn_gas_station_single( gasstation );
        gasstations[ gasstations.size ] = scriptable;
    }
    
    foreach ( gasstation in utility::getstructarray( "gas_station_marine", "targetname" ) )
    {
        scriptable = function_d04d1cfc18c6e2d0( gasstation );
        gasstations[ gasstations.size ] = scriptable;
    }
    
    foreach ( gasstation in utility::getstructarray( "charging_station", "targetname" ) )
    {
        struct = function_716915c972176706( gasstation );
        gasstations[ gasstations.size ] = struct;
    }
    
    function_74f59bfe412f9d11( gasstations );
    level.gasstations = gasstations;
    level.gasstationspawns = undefined;
    level.var_59beeaac5ae0103 = undefined;
    level.var_bf7bafd25df03005 = undefined;
}

// Namespace vehicle_interact
// Params 1
// Checksum 0x8e2588de, Offset: 0x2d03
// Size: 0x349
function function_74f59bfe412f9d11( gasstationspawns )
{
    if ( !isdefined( gasstationspawns ) )
    {
        return;
    }
    
    var_a9687b4f4899e655 = [];
    
    foreach ( gasstation in gasstationspawns )
    {
        if ( !isdefined( gasstation.triggertargetname ) )
        {
            var_a9687b4f4899e655[ var_a9687b4f4899e655.size ] = gasstation;
            continue;
        }
        
        triggers = getnoentvolumearray( gasstation.triggertargetname, #targetname );
        gasstation.triggertargetname = undefined;
        
        if ( !isdefined( triggers ) || triggers.size == 0 )
        {
            var_a9687b4f4899e655[ var_a9687b4f4899e655.size ] = gasstation;
            continue;
        }
        
        if ( getdvarint( @"hash_18e99507526e4c5d", 0 ) )
        {
            gasstation.triggers = triggers;
            
            foreach ( trigger in triggers )
            {
                if ( isdefined( trigger.struct ) && isdefined( trigger.struct.radius ) )
                {
                    trigger.radiussquared = trigger.struct.radius * trigger.struct.radius;
                }
                else
                {
                    trigger.radiussquared = gasstation.radiussquared;
                }
                
                gasstation thread function_c0c76b26f087eecf( trigger );
            }
            
            continue;
        }
        
        if ( triggers.size == 1 )
        {
            gasstation.trigger = triggers[ 0 ];
        }
        else
        {
            gasstation.trigger = sortbydistance( triggers, gasstation.origin )[ 0 ];
        }
        
        gasstation.trigger.radiussquared = gasstation.radiussquared;
        gasstation thread function_c0c76b26f087eecf( gasstation.trigger );
    }
    
    foreach ( gasstation in var_a9687b4f4899e655 )
    {
        radius = int( sqrt( gasstation.radiussquared ) );
        gasstation.trigger = spawn( "noent_volume_trigger_radius", gasstation.origin - ( 0, 0, 200 ), 0, radius, 1000 );
        gasstation.trigger.radiussquared = gasstation.radiussquared;
        gasstation thread function_c0c76b26f087eecf( gasstation.trigger );
    }
}

// Namespace vehicle_interact
// Params 1, eflags: 0x4
// Checksum 0x414e5b3b, Offset: 0x3054
// Size: 0x17b
function private function_c0c76b26f087eecf( trigger )
{
    if ( isdefined( trigger ) )
    {
        thread function_25e201cbedeb1f6d( trigger );
    }
    
    if ( self isscriptableinstance() )
    {
        if ( level.gamemodebundle.var_fb64d8e570987612 )
        {
            self.var_42ad2e0f6b95770c = arraycombineunique( self.var_42ad2e0f6b95770c ?? [], [ trigger ] );
        }
    }
    
    while ( true )
    {
        trigger waittill( #"trigger", vehicle );
        
        if ( !isdefined( vehicle ) || !vehicle vehicle::is_vehicle() || !isdefined( vehicle.origin ) )
        {
            continue;
        }
        
        if ( !isdefined( vehicle.fuel ) )
        {
            continue;
        }
        
        if ( vehicle.var_e623a680c04da658 )
        {
            continue;
        }
        
        if ( vehicle vehicle::is_killstreak() )
        {
            continue;
        }
        
        if ( isdefined( vehicle.refuelingpercentage ) || vehicle.repairing )
        {
            continue;
        }
        
        if ( self.var_95a80d5cd68cee0e && vehicle vehicle::get_ref() != %"hash_38f9469ea4893813" )
        {
            continue;
        }
        
        if ( distance2dsquared( vehicle.origin, trigger.origin ) > trigger.radiussquared )
        {
            continue;
        }
        
        driver = vehicle_occupancy::get_driver( vehicle );
        thread function_c4146d778f76e5c5( vehicle, trigger.origin, trigger.radiussquared, driver );
    }
}

// Namespace vehicle_interact
// Params 1, eflags: 0x4
// Checksum 0xa577385f, Offset: 0x31d7
// Size: 0x10e
function private function_25e201cbedeb1f6d( trigger )
{
    wait 1.5;
    
    if ( !( isdefined( trigger.struct ) && isdefined( trigger.struct.radius ) ) )
    {
        return;
    }
    
    scriptablesarray = getlootscriptablearrayinradius( undefined, undefined, trigger.origin, trigger.struct.radius * 5 );
    
    foreach ( scriptable in scriptablesarray )
    {
        if ( isdefined( scriptable.interact ) && isdefined( scriptable.interact.s_perk_machine ) )
        {
            scriptable.ingasstation = 1;
        }
    }
}

// Namespace vehicle_interact
// Params 3, eflags: 0x4
// Checksum 0x42661424, Offset: 0x32ed
// Size: 0x169
function private spawn_gas_station( origin, radius, scriptablename )
{
    level endon( #"game_ended" );
    
    if ( utility::callsharedfunc( #"poi", #"isSystemActive" ) && !utility::callsharedfunc( #"poi", #"isactive", origin ) )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"game", #"ispointwithininitialdangercircle" ) && ![[ utility::getsharedfunc( #"game", #"ispointwithininitialdangercircle" ) ]]( origin ) )
    {
        return;
    }
    
    if ( isdefined( scriptablename ) )
    {
        /#
            if ( utility::issharedfuncdefined( #"logging", #"addevent" ) )
            {
                [[ utility::getsharedfunc( #"logging", #"addevent" ) ]]( "<dev string:x4dd>", scriptablename, "<dev string:x4e8>", undefined, undefined, undefined, undefined, origin );
            }
        #/
        
        gasstation = spawnscriptable( scriptablename, origin );
    }
    else
    {
        gasstation = spawnstruct();
        gasstation.origin = origin;
    }
    
    gasstation.radiussquared = radius * radius;
    gasstation.minheight = origin[ 2 ] - 200;
    gasstation.maxheight = origin[ 2 ] + 1000 - 200;
    gasstation.var_7ed2d87e1b129d08 = gettime();
    return gasstation;
}

// Namespace vehicle_interact
// Params 1
// Checksum 0xebb1fefb, Offset: 0x345f
// Size: 0xba
function spawn_gas_station_single( gasstationstruct )
{
    radius = gasstationstruct.script_noteworthy == "large" ? 600 : 400;
    scriptable = spawn_gas_station( gasstationstruct.origin, radius, level.gametypebundle.gasstation ?? "dmz_gas_station" );
    
    if ( scriptable )
    {
        scriptable.triggertargetname = gasstationstruct.target;
        
        if ( !isdefined( level.gasstationspawns ) )
        {
            level.gasstationspawns = [];
        }
        
        level.gasstationspawns[ level.gasstationspawns.size ] = scriptable;
    }
    
    return scriptable;
}

// Namespace vehicle_interact
// Params 1
// Checksum 0x91766f3c, Offset: 0x3522
// Size: 0x93
function function_d04d1cfc18c6e2d0( gasstationstruct )
{
    scriptable = spawn_gas_station( gasstationstruct.origin, 650, level.gametypebundle.marinegasstation ?? "dmz_gas_station_marine" );
    
    if ( isdefined( scriptable ) )
    {
        scriptable.triggertargetname = gasstationstruct.target;
        
        if ( !isdefined( level.var_59beeaac5ae0103 ) )
        {
            level.var_59beeaac5ae0103 = [];
        }
        
        level.var_59beeaac5ae0103[ level.var_59beeaac5ae0103.size ] = scriptable;
    }
    
    return scriptable;
}

// Namespace vehicle_interact
// Params 1
// Checksum 0x286ea71, Offset: 0x35be
// Size: 0xb2
function function_716915c972176706( gasstationstruct )
{
    radius = 400;
    
    if ( isdefined( gasstationstruct.script_noteworthy ) )
    {
        radius = float( gasstationstruct.script_noteworthy );
    }
    
    struct = spawn_gas_station( gasstationstruct.origin, radius );
    
    if ( isdefined( struct ) )
    {
        struct.var_95a80d5cd68cee0e = 1;
        struct.triggertargetname = gasstationstruct.target;
        
        if ( !isdefined( level.var_bf7bafd25df03005 ) )
        {
            level.var_bf7bafd25df03005 = [];
        }
        
        level.var_bf7bafd25df03005[ level.var_bf7bafd25df03005.size ] = struct;
    }
    
    return struct;
}

// Namespace vehicle_interact
// Params 4, eflags: 0x4
// Checksum 0xd5ab544b, Offset: 0x3679
// Size: 0x8b5
function private function_c4146d778f76e5c5( vehicle, point, radiussquared, driver )
{
    level endon( #"game_ended" );
    currenttime = gettime();
    
    if ( currenttime - 4000 > self.var_7ed2d87e1b129d08 )
    {
        var_9436e120295fed17 = "veh_fuel_gas_station_service_bell";
        
        if ( self.var_95a80d5cd68cee0e )
        {
            var_9436e120295fed17 = "veh_fuel_ev_station_service_bell_enter";
        }
        
        playsoundatpos( point, var_9436e120295fed17 );
        self.var_7ed2d87e1b129d08 = currenttime;
    }
    
    vehicleref = vehicle vehicle::get_ref();
    interactinfo = get_data( vehicleref );
    maxfuel = vehicle get_max_fuel();
    isfuelonly = istrue( self.var_95a80d5cd68cee0e );
    vehicle.refuelingpercentage = vehicle function_8e3678ef3f745647( maxfuel, isfuelonly );
    vehicle.evcharging = isfuelonly;
    wait 1;
    
    if ( !( isdefined( vehicle ) && isdefined( vehicle.origin ) && isdefined( vehicle.maxhealth ) ) )
    {
        if ( isdefined( vehicle ) )
        {
            vehicle.refuelingpercentage = undefined;
            vehicle.evcharging = undefined;
        }
        
        return;
    }
    
    if ( distancesquared( vehicle.origin, point ) >= radiussquared * 2.25 )
    {
        vehicle.refuelingpercentage = undefined;
        vehicle.evcharging = undefined;
        return;
    }
    
    refilltime = interactinfo.var_b1b3d98efa01c5a5 ?? 30;
    
    if ( isdefined( driver ) && isdefined( driver.perks[ "specialty_trait_fast_refuel" ] ) )
    {
        refilltime *= level.perkbundles[ "specialty_trait_fast_refuel" ].refuelmod ?? 0.5;
    }
    
    refillamount = maxfuel / refilltime * 0.25;
    repairamount = vehicle.maxhealth / refilltime * 0.25;
    objidnum = undefined;
    var_e2fb7e50f8c58564 = gettime() + 2000;
    
    if ( utility::issharedfuncdefined( #"game", #"requestobjectiveid" ) )
    {
        vehicle.curorigin = ( 0, 0, 0 );
        vehicle.offset3d = ( 0, 0, 0 );
        vehicle.objidnum = [[ utility::getsharedfunc( #"game", #"requestobjectiveid" ) ]]( 99 );
        objidnum = vehicle.objidnum;
    }
    
    if ( isdefined( objidnum ) && objidnum != -1 )
    {
        objective_delete( objidnum );
        objective_state( objidnum, "current" );
        objective_setshowoncompass( objidnum, 1 );
        objective_setplayintro( objidnum, 0 );
        objective_setplayoutro( objidnum, 0 );
        objective_setbackground( objidnum, 1 );
        icon = vehicleref == %"hash_38f9469ea4893813" ? "ddos_emp_bolt" : "ui_map_icon_gas_refuel";
        objective_icon( objidnum, icon );
        objective_onentity( objidnum, vehicle );
        objective_setzoffset( objidnum, 75 );
        objective_setshowprogress( objidnum, 1 );
        objective_removeallfrommask( objidnum );
        objective_showtoplayersinmask( objidnum );
    }
    
    progressbarvisible = 0;
    vehicle.refuelingpercentage = vehicle function_8e3678ef3f745647( maxfuel, isfuelonly );
    
    if ( vehicle.refuelingpercentage < 0.99 )
    {
        progressbarvisible = 1;
        
        foreach ( occupant in vehicle.occupants )
        {
            vehicle function_24a07e6bdda36b21( occupant, objidnum, vehicleref );
        }
    }
    
    if ( vehicle.health < vehicle.maxhealth && vehicle vehicle_damage::get_state() != "heavy" )
    {
        playsoundatpos( vehicle.origin, "veh_repair_health" );
    }
    
    while ( isdefined( vehicle ) && isdefined( vehicle.origin ) && distancesquared( vehicle.origin, point ) < radiussquared * 2.25 )
    {
        if ( !vehicle function_72e531fd35c679d9() )
        {
            vehicle.refuelingpercentage = vehicle function_8e3678ef3f745647( maxfuel, isfuelonly );
            
            if ( isdefined( objidnum ) && objidnum != -1 )
            {
                objective_setprogress( objidnum, vehicle.refuelingpercentage );
            }
            
            if ( !progressbarvisible && vehicle.refuelingpercentage < 0.99 )
            {
                progressbarvisible = 1;
                
                foreach ( occupant in vehicle.occupants )
                {
                    vehicle function_24a07e6bdda36b21( occupant, objidnum, vehicleref );
                }
            }
            
            wait 0.25;
            continue;
        }
        
        vehicle.prev_fuel = vehicle.fuel;
        vehicle.fuel = min( maxfuel, vehicle.fuel + refillamount );
        vehicle vehicle_omnvar::function_9f4759fcb3acdc4( vehicle.fuel, maxfuel );
        
        if ( vehicle.prev_fuel < vehicle.fuel )
        {
            if ( !isdefined( vehicle.challengedata ) )
            {
                vehicle.challengedata = {};
            }
            
            vehicle.challengedata.was_refueled = 1;
        }
        
        if ( !isfuelonly )
        {
            if ( vehicle.health < vehicle.maxhealth && vehicle vehicle_damage::get_state() != "heavy" )
            {
                vehicle vehicle_damage::add_health( repairamount );
                
                if ( !isdefined( vehicle.challengedata ) )
                {
                    vehicle.challengedata = {};
                }
                
                vehicle.challengedata.was_repaired = 1;
            }
        }
        
        vehicle.refuelingpercentage = vehicle function_8e3678ef3f745647( maxfuel, isfuelonly );
        
        if ( isdefined( objidnum ) && objidnum != -1 )
        {
            objective_setprogress( objidnum, vehicle.refuelingpercentage );
        }
        
        if ( progressbarvisible && vehicle.refuelingpercentage >= 0.99 )
        {
            callbackparams = { #vehicle:vehicle, #players:vehicle.occupants };
            callback::callback( "dmz_vehicle_refueled_at_gas_station", callbackparams );
            progressbarvisible = 0;
            
            foreach ( occupant in vehicle.occupants )
            {
                vehicle function_2be7633e1c06b61c( occupant, objidnum, vehicleref, 1 );
            }
        }
        
        if ( !isfuelonly )
        {
            if ( gettime() > var_e2fb7e50f8c58564 )
            {
                var_e2fb7e50f8c58564 = gettime() + 2000;
                vehicle_damage::function_4b56eb7facbe21a6( vehicle );
                
                if ( !isdefined( vehicle.challengedata ) )
                {
                    vehicle.challengedata = {};
                }
                
                vehicle.challengedata.var_45600ba5c795f8d7 = 1;
            }
        }
        
        wait 0.25;
    }
    
    if ( progressbarvisible && isdefined( vehicle ) && isdefined( vehicle.occupants ) )
    {
        foreach ( occupant in vehicle.occupants )
        {
            vehicle function_2be7633e1c06b61c( occupant, objidnum, vehicleref, 1 );
        }
    }
    
    if ( isdefined( objidnum ) && objidnum != -1 && utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
    {
        [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( objidnum );
        
        if ( isdefined( vehicle ) )
        {
            vehicle.objidnum = undefined;
        }
    }
    
    if ( isdefined( vehicle ) )
    {
        vehicle.refuelingpercentage = undefined;
        vehicle.evcharging = undefined;
    }
}

// Namespace vehicle_interact
// Params 0
// Checksum 0x1919d6e5, Offset: 0x3f36
// Size: 0x53
function get_max_fuel()
{
    data = get_data( vehicle::get_ref() );
    maxfuel = data.maxfuel ?? 100;
    maxfuel *= self.spawndata.fuelmultiplier ?? 1;
    return maxfuel;
}

// Namespace vehicle_interact
// Params 0
// Checksum 0x12db4cb4, Offset: 0x3f92
// Size: 0x23, Type: bool
function function_72e531fd35c679d9()
{
    return !isdefined( self.lasttimedamaged ) || gettime() - self.lasttimedamaged >= 5000;
}

// Namespace vehicle_interact
// Params 2, eflags: 0x4
// Checksum 0xb9d405c4, Offset: 0x3fbe
// Size: 0x57
function private function_8e3678ef3f745647( maxfuel, isfuelonly )
{
    if ( isfuelonly )
    {
        return ( self.fuel / maxfuel );
    }
    
    return 0.5 * self.fuel / maxfuel + 0.5 * self.health / self.maxhealth;
}

// Namespace vehicle_interact
// Params 2
// Checksum 0x49aed9f3, Offset: 0x401d
// Size: 0x46
function on_enter_vehicle( vehicle, player )
{
    if ( vehicle.refuelingpercentage < 0.99 )
    {
        vehicle function_24a07e6bdda36b21( player, vehicle.objidnum, vehicle vehicle::get_ref() );
    }
}

// Namespace vehicle_interact
// Params 2
// Checksum 0x872ac044, Offset: 0x406b
// Size: 0x46
function on_exit_vehicle( vehicle, player )
{
    if ( vehicle.refuelingpercentage < 0.99 )
    {
        vehicle function_2be7633e1c06b61c( player, vehicle.objidnum, vehicle vehicle::get_ref() );
    }
}

// Namespace vehicle_interact
// Params 3, eflags: 0x4
// Checksum 0xc4b87bbb, Offset: 0x40b9
// Size: 0xa6
function private function_24a07e6bdda36b21( player, objidnum, vehicleref )
{
    if ( isdefined( objidnum ) && objidnum != -1 )
    {
        objective_addclienttomask( objidnum, player );
        objective_showtoplayersinmask( objidnum );
        objective_pinforclient( objidnum, player );
        objective_setshowpinnedprogressbar( 2, player );
        refuelingtext = &"mp/refueling";
        
        if ( vehicleref == %"hash_38f9469ea4893813" )
        {
            refuelingtext = self.evcharging ? &"mp/charging_fuel_only" : &"mp/charging";
        }
        
        objective_setpinnedprogressbartext( refuelingtext, player );
        function_954311ccae0b56f0( player, vehicleref );
    }
}

// Namespace vehicle_interact
// Params 4, eflags: 0x4
// Checksum 0xe3085433, Offset: 0x4167
// Size: 0x60
function private function_2be7633e1c06b61c( player, objidnum, vehicleref, success )
{
    if ( isdefined( objidnum ) && objidnum != -1 )
    {
        objective_removeclientfrommask( objidnum, player );
        objective_showtoplayersinmask( objidnum );
        objective_unpinforclient( objidnum, player );
        objective_setshowpinnedprogressbar( 0, player );
        function_2e0206358d2dedca( player, vehicleref, success );
    }
}

// Namespace vehicle_interact
// Params 2, eflags: 0x4
// Checksum 0x22273fe9, Offset: 0x41cf
// Size: 0x8f
function private function_954311ccae0b56f0( player, vehicleref )
{
    if ( player getscriptablehaspart( "veh_fuel_station_sfx" ) )
    {
        startstate = vehicleref == %"hash_38f9469ea4893813" ? "veh_fuel_ev_charge_start" : "veh_fuel_gas_pump_start";
        function_b3f8757fa5b49cbe( player, startstate );
        return;
    }
    
    refuelingsound = vehicleref == %"hash_38f9469ea4893813" ? "uin_veh_fuel_ev_charger" : "uin_veh_fuel_gas_ticker";
    
    if ( soundexists( refuelingsound ) )
    {
        player playlocalsound( refuelingsound );
    }
}

// Namespace vehicle_interact
// Params 3, eflags: 0x4
// Checksum 0xb84b8d76, Offset: 0x4266
// Size: 0xee
function private function_2e0206358d2dedca( player, vehicleref, success )
{
    if ( player getscriptablehaspart( "veh_fuel_station_sfx" ) )
    {
        finishstate = vehicleref == %"hash_38f9469ea4893813" ? "veh_fuel_ev_charge_finish" : "veh_fuel_gas_pump_finish";
        currentstate = success ? finishstate : "off";
        function_b3f8757fa5b49cbe( player, currentstate );
        return;
    }
    
    refuelingsound = vehicleref == %"hash_38f9469ea4893813" ? "uin_veh_fuel_ev_charger" : "uin_veh_fuel_gas_ticker";
    var_5c1ddc2f27c9320 = vehicleref == %"hash_38f9469ea4893813" ? "uin_veh_fuel_ev_charger_stop" : "uin_veh_fuel_gas_ticker_stop";
    
    if ( success && soundexists( var_5c1ddc2f27c9320 ) )
    {
        player playlocalsound( var_5c1ddc2f27c9320 );
    }
    
    if ( soundexists( refuelingsound ) )
    {
        player stoplocalsound( refuelingsound );
    }
}

// Namespace vehicle_interact
// Params 2, eflags: 0x4
// Checksum 0xf5c00c63, Offset: 0x435c
// Size: 0x35
function private function_b3f8757fa5b49cbe( player, state )
{
    if ( player getscriptableparthasstate( "veh_fuel_station_sfx", state ) )
    {
        player setscriptablepartstate( "veh_fuel_station_sfx", state, 1 );
    }
}

// Namespace vehicle_interact
// Params 3
// Checksum 0x4209a979, Offset: 0x4399
// Size: 0x8b
function init_fuel( vehicleref, vehicle, spawndata )
{
    if ( !vehicle vehicle::is_husk() && fuel_is_enabled() && !vehicle.isfromkillstreak )
    {
        vehicle.fuel = get_found_fuel( vehicleref );
        vehicle.fuel *= spawndata.fuelmultiplier ?? 1;
        vehicle thread function_d0aa8bbfd9d475ba( vehicleref, spawndata );
    }
}

// Namespace vehicle_interact
// Params 1, eflags: 0x4
// Checksum 0x3f00769b, Offset: 0x442c
// Size: 0x60
function private get_found_fuel( vehicleref )
{
    leveldataforvehicle = get_data( vehicleref );
    
    if ( leveldataforvehicle.var_a5b1ad5fd2654e9a >= leveldataforvehicle.var_a5d4975fd28b65f0 )
    {
        return leveldataforvehicle.var_a5b1ad5fd2654e9a;
    }
    
    return randomfloatrange( leveldataforvehicle.var_a5b1ad5fd2654e9a, leveldataforvehicle.var_a5d4975fd28b65f0 );
}

// Namespace vehicle_interact
// Params 0
// Checksum 0x95a82ba2, Offset: 0x4495
// Size: 0xe
function function_df89a6e21b8b4e65()
{
    self notify( #"stop_fuel_usage" );
}

// Namespace vehicle_interact
// Params 0
// Checksum 0xff68163c, Offset: 0x44ab
// Size: 0xd
function function_66ef1c80fb18570c()
{
    self.var_e623a680c04da658 = 1;
}

// Namespace vehicle_interact
// Params 0
// Checksum 0x7fa89802, Offset: 0x44c0
// Size: 0x11
function function_a21bb851f0405d37()
{
    self.fuel = get_max_fuel();
}

// Namespace vehicle_interact
// Params 2, eflags: 0x4
// Checksum 0xef2b8af5, Offset: 0x44d9
// Size: 0x4d0
function private function_d0aa8bbfd9d475ba( vehicleref, spawndata )
{
    self endon( #"death" );
    self endon( #"stop_fuel_usage" );
    level endon( #"game_ended" );
    maxfuel = get_max_fuel();
    
    if ( maxfuel < 0 )
    {
        return;
    }
    
    vehicle_omnvar::function_9f4759fcb3acdc4( self.fuel, maxfuel );
    topspeed = self vehicle_gettopspeedforward();
    lowFuel = 0;
    outOfFuel = 0;
    
    if ( vehicle::ishelicopter() )
    {
        lowfuelsound = "uin_veh_warning_low_fuel_heli";
        outoffuelsound = "uin_veh_warning_out_of_fuel_heli";
        var_2828b8bb48405998 = "veh_fuel_warning_low_fuel_heli";
        var_d54c6d5d918fec43 = "veh_fuel_warning_out_of_fuel_heli";
    }
    else
    {
        lowfuelsound = "uin_veh_warning_low_fuel";
        outoffuelsound = "uin_veh_warning_out_of_fuel";
        var_2828b8bb48405998 = "veh_fuel_warning_low_fuel";
        var_d54c6d5d918fec43 = "veh_fuel_warning_out_of_fuel";
    }
    
    while ( true )
    {
        wait 1;
        driver = vehicle_occupancy::get_driver( self );
        
        if ( self.ishovering || !self.isempty && isplayer( driver ) )
        {
            speedfraction = min( vehicle::ishelicopter() ? 1 : self vehicle_getspeed() / topspeed, 1 );
            speedfraction *= driver.var_75720730911396ce ?? 1;
            self.fuel = max( self.fuel - speedfraction, 0 );
        }
        
        /#
            if ( getdvarint( @"scr_vehicle_fuel_unlimited", 0 ) == 1 )
            {
                self.fuel = maxfuel;
                outOfFuel = 0;
            }
        #/
        
        vehicle_omnvar::function_9f4759fcb3acdc4( self.fuel, maxfuel );
        
        if ( self.fuel <= 0 && !outOfFuel )
        {
            outOfFuel = 1;
            vehicle_occupancy::disable_engine();
            vehicle_occupancy::function_961dfeea38feb976();
            vehicle_occupancy::allow_movement( self, 0, 0 );
            vehicle_omnvar::show_warning( "outOfFuel", vehicle_occupancy::function_8ed9bcd8e9ea74f5( self ), vehicleref );
            
            if ( utility::issharedfuncdefined( vehicleref, #"outOfFuel" ) )
            {
                [[ utility::getsharedfunc( vehicleref, #"outOfFuel" ) ]]();
            }
            
            callback::callback( "vehicle_out_of_fuel", { #vehicleref:vehicleref, #player:self } );
            function_67438acc5a9c23f5( "veh_fuel_warning_sfx", var_d54c6d5d918fec43 );
            function_a92ce326fa1c7bb9( lowfuelsound );
            function_20367b377c5ed9b3( outoffuelsound );
        }
        else if ( self.fuel > 0 && outOfFuel )
        {
            outOfFuel = 0;
            function_67438acc5a9c23f5( "veh_fuel_warning_sfx", "off" );
            function_a92ce326fa1c7bb9( outoffuelsound );
            vehicle_occupancy::enable_engine();
            vehicle_occupancy::turn_engine_on();
            
            if ( utility::issharedfuncdefined( vehicleref, #"hash_72ee2a23b8d3a16c" ) )
            {
                [[ utility::getsharedfunc( vehicleref, #"hash_72ee2a23b8d3a16c" ) ]]();
            }
            
            vehicle_occupancy::allow_movement( self, 1 );
            vehicle_omnvar::hide_warning( "outOfFuel", vehicle_occupancy::function_8ed9bcd8e9ea74f5( self ), vehicleref );
        }
        
        if ( self.fuel <= 25 && self.fuel > 0 && !lowFuel )
        {
            lowFuel = 1;
            vehicle_omnvar::show_warning( "lowFuel", vehicle_occupancy::function_8ed9bcd8e9ea74f5( self ), vehicleref );
            function_67438acc5a9c23f5( "veh_fuel_warning_sfx", var_2828b8bb48405998 );
            function_20367b377c5ed9b3( lowfuelsound );
            player = vehicle_occupancy::get_driver( self );
            
            if ( isdefined( player ) && utility::issharedfuncdefined( #"hud", #"ftue_triggerTip" ) )
            {
                closestgasstation = undefined;
                var_2f2d5cf5237088a = undefined;
                
                foreach ( gasstation in level.gasstations )
                {
                    if ( !isdefined( closestgasstation ) )
                    {
                        closestgasstation = gasstation;
                        var_2f2d5cf5237088a = distancesquared( self.origin, gasstation.origin );
                    }
                    
                    distancesqr = distancesquared( self.origin, gasstation.origin );
                    
                    if ( distancesqr < var_2f2d5cf5237088a )
                    {
                        closestgasstation = gasstation;
                        var_2f2d5cf5237088a = distancesquared( self.origin, gasstation.origin );
                    }
                }
            }
            
            continue;
        }
        
        if ( ( self.fuel > 25 || self.fuel <= 0 ) && lowFuel )
        {
            lowFuel = 0;
            vehicle_omnvar::hide_warning( "lowFuel", vehicle_occupancy::function_8ed9bcd8e9ea74f5( self ), vehicleref );
            function_a92ce326fa1c7bb9( lowfuelsound );
            
            if ( !outOfFuel )
            {
                function_67438acc5a9c23f5( "veh_fuel_warning_sfx", "off" );
            }
        }
    }
}

// Namespace vehicle_interact
// Params 2, eflags: 0x4
// Checksum 0xb6e3bc49, Offset: 0x49b1
// Size: 0xa2
function private function_67438acc5a9c23f5( part, state )
{
    foreach ( occupant in vehicle_occupancy::function_8ed9bcd8e9ea74f5( self ) )
    {
        if ( occupant getscriptablehaspart( part ) && occupant getscriptableparthasstate( part, state ) )
        {
            occupant setscriptablepartstate( part, state );
        }
    }
}

// Namespace vehicle_interact
// Params 1, eflags: 0x4
// Checksum 0x6c17079c, Offset: 0x4a5b
// Size: 0xa2
function private function_20367b377c5ed9b3( soundaliasname )
{
    if ( soundexists( soundaliasname ) )
    {
        foreach ( occupant in vehicle_occupancy::function_8ed9bcd8e9ea74f5( self ) )
        {
            if ( occupant getscriptablehaspart( "veh_fuel_warning_sfx" ) )
            {
                return;
            }
            
            occupant stoplocalsound( soundaliasname );
            occupant playlocalsound( soundaliasname );
        }
    }
}

// Namespace vehicle_interact
// Params 1, eflags: 0x4
// Checksum 0x942a51f3, Offset: 0x4b05
// Size: 0x9a
function private function_a92ce326fa1c7bb9( soundaliasname )
{
    if ( soundexists( soundaliasname ) )
    {
        foreach ( occupant in vehicle_occupancy::function_8ed9bcd8e9ea74f5( self ) )
        {
            if ( occupant getscriptablehaspart( "veh_fuel_warning_sfx" ) )
            {
                return;
            }
            
            occupant stoplocalsound( soundaliasname );
        }
    }
}

// Namespace vehicle_interact
// Params 4
// Checksum 0x47c2c4ab, Offset: 0x4ba7
// Size: 0x165
function function_168dac01f9aa2882( vehicle, gascancount, var_3df97f2404d99e4c, isexternaluse = 0 )
{
    if ( !( isdefined( vehicle ) && isdefined( vehicle.fuel ) ) )
    {
        if ( var_3df97f2404d99e4c )
        {
            return %"mp/cannot_use_gas_can_palfa";
        }
        
        return %"mp/cannot_use_gas_can";
    }
    
    if ( vehicle.var_e623a680c04da658 )
    {
        return %"mp/cannot_use_gas_can";
    }
    
    ref = vehicle vehicle::get_ref();
    interactinfo = get_data( ref );
    
    if ( level.var_1597e9e336c903e4 && !var_3df97f2404d99e4c && ref == %"hash_1dd941f8f4026e3" )
    {
        return %"mp/cannot_use_gas_can_in_palfa";
    }
    
    if ( var_3df97f2404d99e4c && ref != %"hash_1dd941f8f4026e3" )
    {
        return %"mp/cannot_use_gas_can_palfa";
    }
    
    if ( !var_3df97f2404d99e4c && ( !isdefined( gascancount ) || gascancount == 1 ) )
    {
        return %"mp/gas_can_is_empty";
    }
    
    if ( ref == %"hash_38f9469ea4893813" )
    {
        return %"mp/cannot_use_gas_can_electric";
    }
    
    if ( vehicle get_max_fuel() - vehicle.fuel < 1 )
    {
        return %"mp/vehicle_full_gas";
    }
    
    if ( !isexternaluse && interactinfo.var_5c3ccffdcf2e7d20 )
    {
        return %"hash_33c5fc4187ae6d15";
    }
}

// Namespace vehicle_interact
// Params 2
// Checksum 0xb6f03402, Offset: 0x4d14
// Size: 0x16a
function gas_can_refuel_vehicle( gascan, var_3df97f2404d99e4c )
{
    vehicle = vehicle::get_vehicle();
    var_7237854e3be197ca = function_168dac01f9aa2882( vehicle, gascan.count, var_3df97f2404d99e4c );
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    ref = vehicle vehicle::get_ref();
    refillamount = gascan.count - 1;
    
    if ( var_3df97f2404d99e4c && ref == %"hash_1dd941f8f4026e3" )
    {
        refillamount = 1000;
    }
    
    maxfuel = vehicle get_max_fuel();
    
    if ( vehicle.fuel + refillamount > maxfuel )
    {
        refillamount = int( floor( maxfuel - vehicle.fuel ) );
    }
    
    vehicle.fuel = min( maxfuel, vehicle.fuel + refillamount );
    
    if ( var_3df97f2404d99e4c )
    {
        gascan.count = 0;
    }
    else
    {
        gascan.count -= refillamount;
        
        if ( gascan.count < 1 )
        {
            gascan.count = 1;
        }
    }
    
    vehicle vehicle_omnvar::function_9f4759fcb3acdc4();
    callback::callback( "player_refuel_vehicle_with_gas_can", { #vehicle:vehicle, #player:self } );
}

// Namespace vehicle_interact
// Params 1
// Checksum 0xbcc21245, Offset: 0x4e87
// Size: 0x169
function gas_can_siphon_vehicle( gascancount )
{
    vehicle = vehicle::get_vehicle();
    
    if ( !( isdefined( vehicle ) && isdefined( vehicle.fuel ) ) )
    {
        return [ %"mp/cannot_use_gas_can", gascancount ];
    }
    
    if ( vehicle.fuel < 1 )
    {
        return [ %"hash_4d21ffc144e21f60", gascancount ];
    }
    
    if ( !isdefined( gascancount ) || gascancount == 150 )
    {
        return [ %"mp/gas_can_full", gascancount ];
    }
    
    ref = vehicle vehicle::get_ref();
    
    if ( ref == %"hash_38f9469ea4893813" )
    {
        return [ "MP/GAS_CAN_SIPHON_ON_EV", gascancount ];
    }
    
    siphonamount = 150 - gascancount + 1;
    
    if ( vehicle.fuel < siphonamount )
    {
        siphonamount = int( floor( vehicle.fuel ) );
    }
    
    vehicle.fuel = max( 0, vehicle.fuel - siphonamount );
    gascancount += siphonamount - 1;
    
    if ( gascancount > 150 )
    {
        gascancount = 150;
    }
    
    vehicle vehicle_omnvar::function_9f4759fcb3acdc4();
    callback::callback( "player_siphoned_vehicle", { #vehicle:vehicle, #player:self } );
    return [ undefined, gascancount ];
}

// Namespace vehicle_interact
// Params 1
// Checksum 0xe0685491, Offset: 0x4ff9
// Size: 0x103
function on_damage( data )
{
    if ( isplayer( data.attacker ) && isagent( self.aidriver ) && isalive( self.aidriver ) && !self.aidriver isincombat() )
    {
        utility::callsharedfunc( #"stealth", #"event_broadcast_generic", "gunshot_impact", data.point ?? self.origin, 500, self );
    }
    
    if ( self.playedcaralarm || self.lastplayedcaralarm >= gettime() || !self.isempty )
    {
        return;
    }
    
    didplay = car_alarm_on( 5 );
    
    if ( didplay )
    {
        if ( isdefined( level.var_ceb922993e45aec6 ) )
        {
            self.lastplayedcaralarm = gettime() + level.var_ceb922993e45aec6;
            return;
        }
        
        self.playedcaralarm = 1;
    }
}

// Namespace vehicle_interact
// Params 1
// Checksum 0xce73e6d0, Offset: 0x5104
// Size: 0x198, Type: bool
function car_alarm_on( time )
{
    self notify( #"hash_f0b62e42076148a" );
    self endon( #"hash_f0b62e42076148a" );
    
    if ( vehicle::is_husk() )
    {
        return false;
    }
    
    vehicleleveldata = get_data( vehicle::get_ref() );
    
    if ( !isdefined( level.caralarmenabled ) )
    {
        level.caralarmenabled = getdvarint( @"hash_e42fc7d1e9196cff", 1 ) == 1;
    }
    
    if ( !level.caralarmenabled || !function_7273219c51931fe6( 120000 ) || !vehicleleveldata.alarmpartname || vehicleleveldata.alarmpartname == "" || !self getscriptablehaspart( vehicleleveldata.alarmpartname ) || !self getscriptableparthasstate( vehicleleveldata.alarmpartname, "on" ) )
    {
        return false;
    }
    
    self endon( #"death" );
    self setscriptablepartstate( vehicleleveldata.alarmpartname, "on" );
    utility::callsharedfunc( #"stealth", #"event_broadcast_generic", "cover_blown", self.origin, 2500, self );
    params = { #vehicle:self };
    callback::callback( "car_alarm_on", params );
    function_e125e0390adb1522( time );
    
    if ( self getscriptableparthasstate( vehicleleveldata.alarmpartname, "off" ) )
    {
        self setscriptablepartstate( vehicleleveldata.alarmpartname, "off" );
    }
    
    callback::callback( "car_alarm_off", params );
    return true;
}

// Namespace vehicle_interact
// Params 1, eflags: 0x4
// Checksum 0x58732b80, Offset: 0x52a5
// Size: 0x7e, Type: bool
function private function_7273219c51931fe6( duration )
{
    if ( !isdefined( level.var_376b2433277410ba ) )
    {
        return true;
    }
    
    if ( !level.var_376b2433277410ba )
    {
        return true;
    }
    
    if ( !isdefined( self.var_2d11ca7423079960 ) )
    {
        return true;
    }
    
    if ( !isdefined( self.var_a7fd2a4165cc431a ) )
    {
        return false;
    }
    
    if ( self.var_2d11ca7423079960 > self.var_a7fd2a4165cc431a )
    {
        return false;
    }
    
    if ( gettime() - self.var_a7fd2a4165cc431a < duration )
    {
        return false;
    }
    
    return true;
}

// Namespace vehicle_interact
// Params 1, eflags: 0x4
// Checksum 0xb33bb2d0, Offset: 0x532c
// Size: 0x27
function private function_e125e0390adb1522( seconds )
{
    self endon( #"vehicle_owner_update" );
    wait level.vehiclealarmtime ?? seconds;
}

// Namespace vehicle_interact
// Params 0
// Checksum 0x10bb54c5, Offset: 0x535b
// Size: 0x1dd
function function_867ea9d5b4458d20()
{
    if ( !level.vehiclelightsenabled || self.var_34b3e5f444f2a5f0 )
    {
        return;
    }
    
    if ( self.enginelightson )
    {
        return;
    }
    
    ref = vehicle::get_ref();
    
    if ( !isdefined( ref ) || !vehicle::has_data( ref ) )
    {
        return;
    }
    
    data = vehicle::get_data( ref );
    
    if ( !( isdefined( data ) && isdefined( data.interact ) && isdefined( data.interact.lights ) ) || data.interact.lights.size == 0 )
    {
        return;
    }
    
    isnight = utility::isnightmap();
    
    foreach ( light in data.interact.lights )
    {
        if ( light.type == "engine_is_on_day_and_night" && self getscriptablepartstate( light.tag, 1 ) == "off" )
        {
            self setscriptablepartstate( light.tag, "on", 1 );
        }
        else if ( isnight && light.type == "engine_is_on_at_night" && self getscriptablepartstate( light.tag, 1 ) == "off" )
        {
            self setscriptablepartstate( light.tag, "on", 1 );
        }
        
        self.enginelightson = 1;
    }
}

// Namespace vehicle_interact
// Params 0
// Checksum 0x925dd640, Offset: 0x5540
// Size: 0x1dd
function function_e3ff6fb751c623a()
{
    if ( !level.vehiclelightsenabled || self.var_34b3e5f444f2a5f0 )
    {
        return;
    }
    
    if ( !self.enginelightson )
    {
        return;
    }
    
    ref = vehicle::get_ref();
    
    if ( !isdefined( ref ) || !vehicle::has_data( ref ) )
    {
        return;
    }
    
    data = vehicle::get_data( ref );
    
    if ( !( isdefined( data ) && isdefined( data.interact ) && isdefined( data.interact.lights ) ) || data.interact.lights.size == 0 )
    {
        return;
    }
    
    isnight = utility::isnightmap();
    
    foreach ( light in data.interact.lights )
    {
        if ( light.type == "engine_is_on_day_and_night" && self getscriptablepartstate( light.tag, 1 ) == "on" )
        {
            self setscriptablepartstate( light.tag, "off", 1 );
            continue;
        }
        
        if ( isnight && light.type == "engine_is_on_at_night" && self getscriptablepartstate( light.tag, 1 ) == "on" )
        {
            self setscriptablepartstate( light.tag, "off", 1 );
        }
    }
    
    self.enginelightson = undefined;
}

// Namespace vehicle_interact
// Params 0
// Checksum 0x82e4664e, Offset: 0x5725
// Size: 0xdc
function update_occupancy_lights()
{
    if ( !level.vehiclelightsenabled || self.var_34b3e5f444f2a5f0 )
    {
        return;
    }
    
    ref = vehicle::get_ref();
    
    if ( !isdefined( ref ) || !vehicle::has_data( ref ) )
    {
        return;
    }
    
    data = vehicle::get_data( ref );
    
    if ( !isdefined( data.interact.lights ) || data.interact.lights.size == 0 )
    {
        return;
    }
    
    var_ca904eadcab99f66 = !self.isempty;
    
    if ( var_ca904eadcab99f66 && !self.occupancylightson )
    {
        function_6fb338fa250705a3( data );
        return;
    }
    
    if ( !var_ca904eadcab99f66 && self.occupancylightson )
    {
        function_ae4f431f6e986187( data );
    }
}

// Namespace vehicle_interact
// Params 1, eflags: 0x4
// Checksum 0xfdeb6e75, Offset: 0x5809
// Size: 0x13c
function private function_6fb338fa250705a3( data )
{
    isnight = utility::isnightmap();
    
    foreach ( light in data.interact.lights )
    {
        if ( light.type == "occupied_day_and_night" && self getscriptablepartstate( light.tag, 1 ) == "off" )
        {
            self setscriptablepartstate( light.tag, "on", 1 );
            continue;
        }
        
        if ( isnight && light.type == "occupied_at_night" && self getscriptablepartstate( light.tag, 1 ) == "off" )
        {
            self setscriptablepartstate( light.tag, "on", 1 );
        }
    }
    
    self.occupancylightson = 1;
}

// Namespace vehicle_interact
// Params 1, eflags: 0x4
// Checksum 0xaee8aa0c, Offset: 0x594d
// Size: 0x13b
function private function_ae4f431f6e986187( data )
{
    isnight = utility::isnightmap();
    
    foreach ( light in data.interact.lights )
    {
        if ( light.type == "occupied_day_and_night" && self getscriptablepartstate( light.tag, 1 ) == "on" )
        {
            self setscriptablepartstate( light.tag, "off", 1 );
            continue;
        }
        
        if ( isnight && light.type == "occupied_at_night" && self getscriptablepartstate( light.tag, 1 ) == "on" )
        {
            self setscriptablepartstate( light.tag, "off", 1 );
        }
    }
    
    self.occupancylightson = undefined;
}

// Namespace vehicle_interact
// Params 0
// Checksum 0x53b844b6, Offset: 0x5a90
// Size: 0x12c
function function_ca5f55b11d5b4274()
{
    if ( !level.vehiclelightsenabled || self.var_34b3e5f444f2a5f0 )
    {
        return;
    }
    
    ref = vehicle::get_ref();
    
    if ( !isdefined( ref ) || !vehicle::has_data( ref ) )
    {
        return;
    }
    
    data = vehicle::get_data( ref );
    
    if ( !( isdefined( data ) && isdefined( data.interact ) && isdefined( data.interact.lights ) ) )
    {
        return;
    }
    
    foreach ( light in data.interact.lights )
    {
        if ( light.type == "opening_door" )
        {
            self setscriptablepartstate( light.tag, "on", 1 );
        }
    }
}

// Namespace vehicle_interact
// Params 2
// Checksum 0x580b673, Offset: 0x5bc4
// Size: 0x25
function lights_on( var_35093a42728ddcc1, overridestate )
{
    set_light_state( var_35093a42728ddcc1, "on", overridestate );
}

// Namespace vehicle_interact
// Params 2
// Checksum 0x9725a5d7, Offset: 0x5bf1
// Size: 0x25
function lights_off( var_35093a42728ddcc1, overridestate )
{
    set_light_state( var_35093a42728ddcc1, "off", overridestate );
}

// Namespace vehicle_interact
// Params 3
// Checksum 0xb8f4c866, Offset: 0x5c1e
// Size: 0x1cd
function set_light_state( var_35093a42728ddcc1, state, overridestate )
{
    ref = vehicle::get_ref();
    
    if ( !isdefined( ref ) || !vehicle::has_data( ref ) )
    {
        return;
    }
    
    data = vehicle::get_data( ref );
    
    if ( !( isdefined( data ) && isdefined( data.interact ) && isdefined( data.interact.lights ) ) )
    {
        return;
    }
    
    foreach ( light in data.interact.lights )
    {
        if ( !self getscriptablehaspart( light.tag ) )
        {
            continue;
        }
        
        if ( self getscriptablepartstate( light.tag ) == "death" )
        {
            continue;
        }
        
        if ( isdefined( var_35093a42728ddcc1 ) && !isarray( var_35093a42728ddcc1 ) && var_35093a42728ddcc1 != "all" && light.group != var_35093a42728ddcc1 )
        {
            continue;
        }
        
        if ( isarray( var_35093a42728ddcc1 ) && !arraycontains( var_35093a42728ddcc1, light.tag ) )
        {
            continue;
        }
        
        if ( isdefined( overridestate ) && self getscriptablepartstate( light.tag, overridestate ) )
        {
            self setscriptablepartstate( light.tag, overridestate );
            continue;
        }
        
        self setscriptablepartstate( light.tag, state );
    }
}

// Namespace vehicle_interact
// Params 1
// Checksum 0x57dc6784, Offset: 0x5df3
// Size: 0x160
function function_47e6a0e01f805a2e( var_35093a42728ddcc1 )
{
    if ( !( isdefined( self ) && isdefined( self.damageableparts ) ) )
    {
        return;
    }
    
    ref = vehicle::get_ref();
    
    if ( !isdefined( ref ) || !vehicle::has_data( ref ) )
    {
        return;
    }
    
    data = vehicle::get_data( ref );
    
    if ( !( isdefined( data ) && isdefined( data.interact ) && isdefined( data.interact.lights ) ) )
    {
        return;
    }
    
    foreach ( light in data.interact.lights )
    {
        if ( isdefined( var_35093a42728ddcc1 ) && !isarray( var_35093a42728ddcc1 ) && light.group != var_35093a42728ddcc1 )
        {
            continue;
        }
        
        if ( isarray( var_35093a42728ddcc1 ) && !arraycontains( var_35093a42728ddcc1, light.tag ) )
        {
            continue;
        }
        
        self.damageableparts[ light.tag ] = undefined;
    }
}

// Namespace vehicle_interact
// Params 0
// Checksum 0x54f3bbb, Offset: 0x5f5b
// Size: 0xd
function function_253eb8c405fef8f2()
{
    self.var_34b3e5f444f2a5f0 = 1;
}

/#

    // Namespace vehicle_interact
    // Params 1
    // Checksum 0xe2ca7830, Offset: 0x5f70
    // Size: 0x34, Type: dev
    function get_point_refs( vehicle )
    {
        instancedataforvehicle = get_instance_data( vehicle, 0 );
        return getarraykeys( instancedataforvehicle.pointdata );
    }

    // Namespace vehicle_interact
    // Params 0
    // Checksum 0x718b03ee, Offset: 0x5fac
    // Size: 0xb, Type: dev
    function get_scriptable_usable_state()
    {
        return "<dev string:x4f7>";
    }

#/
