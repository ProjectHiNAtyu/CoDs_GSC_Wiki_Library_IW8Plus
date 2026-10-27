// scripts\common\vehicle_compass.gsc  (hash_12c4fcf07f81c417.gscc) (size: 3951 Bytes / 0xf6f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x824cbc2b (2186066987)
// size ...... 3951 (0xf6f)
// includes .. 4   (offset: 0xeff)
// strings ... 2   (offset: 0xf1f)
// dev strs .. 4   (offset: 0xf3f)
// exports ... 18  (offset: 0x8db)
// cseg ...... 0x7e + 0x85d (0x8db)
// imports ... 27  (offset: 0xbab)
// animtree1 . 0   (offset: 0xf6f)
// animtree2 . 0   (offset: 0xf6f)
#using scripts\common\utility;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_spawn;
#using scripts\common\vehicle_tracking;

#namespace vehicle_compass;

// Namespace vehicle_compass
// Params 1
// Checksum 0x39c38035, Offset: 0x9c
// Size: 0x58
function register_instance( vehicle )
{
    leveldata = get_level_data();
    leveldata.instances[ vehicle getentitynumber() ] = vehicle;
    vehicle_show( vehicle );
    
    if ( vehicle vehicle_tracking::get_spawn_data() vehicle_spawn::has_flag( 7 ) )
    {
        vehicle_hide( vehicle );
    }
}

// Namespace vehicle_compass
// Params 1
// Checksum 0xd258922, Offset: 0xfc
// Size: 0x30
function deregister_instance( vehicle )
{
    leveldata = get_level_data();
    leveldata.instances[ vehicle getentitynumber() ] = undefined;
}

// Namespace vehicle_compass
// Params 1
// Checksum 0x8a2758ab, Offset: 0x134
// Size: 0x33, Type: bool
function instance_is_registered( vehicle )
{
    leveldata = get_level_data();
    return leveldata.instances[ vehicle getentitynumber() ] == vehicle;
}

// Namespace vehicle_compass
// Params 3
// Checksum 0x32c0872, Offset: 0x170
// Size: 0x61
function function_484c1142d4f4e710( vehicle, player, var_e6c819f806ce2c86 )
{
    if ( !player.hasspawned )
    {
        return;
    }
    
    if ( !function_461bc9a9504d10ed( vehicle, var_e6c819f806ce2c86 ) )
    {
        return;
    }
    
    vehicle builtin [[ level.sharedfuncs[ #"vehicle" ][ #"vehicleshowonminimapforclient" ] ]]( player, 1 );
}

// Namespace vehicle_compass
// Params 3
// Checksum 0x407aa28, Offset: 0x1d9
// Size: 0xcc
function function_f43158fa5698deb9( vehicle, players, var_e6c819f806ce2c86 )
{
    if ( !function_461bc9a9504d10ed( vehicle, var_e6c819f806ce2c86 ) )
    {
        return;
    }
    
    foreach ( player in players )
    {
        if ( !player.hasspawned )
        {
            continue;
        }
        
        vehicle builtin [[ level.sharedfuncs[ #"vehicle" ][ #"vehicleshowonminimapforclient" ] ]]( player, 1 );
    }
}

// Namespace vehicle_compass
// Params 2, eflags: 0x4
// Checksum 0xbc5d24bb, Offset: 0x2ad
// Size: 0x88, Type: bool
function private function_461bc9a9504d10ed( vehicle, var_e6c819f806ce2c86 )
{
    leveldata = get_level_data();
    
    if ( !leveldata.visibilityisscriptcontrolled )
    {
        return false;
    }
    
    if ( !isdefined( vehicle ) )
    {
        return false;
    }
    
    if ( !instance_is_registered( vehicle ) )
    {
        if ( !var_e6c819f806ce2c86 )
        {
            assertmsg( "<dev string:x24>" );
        }
        
        return false;
    }
    
    if ( !isdefined( level.sharedfuncs[ #"vehicle" ][ #"vehicleshowonminimapforclient" ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace vehicle_compass
// Params 2
// Checksum 0xfe890357, Offset: 0x33e
// Size: 0xd4
function function_875431dd0d57f2fd( vehicle, var_e6c819f806ce2c86 )
{
    if ( !function_461bc9a9504d10ed( vehicle ) )
    {
        return;
    }
    
    var_cbaf02c53ccec36d = level.sharedfuncs[ #"vehicle" ][ #"vehicleshowonminimapforclient" ];
    
    foreach ( player in level.players )
    {
        if ( !player.hasspawned )
        {
            continue;
        }
        
        vehicle builtin [[ var_cbaf02c53ccec36d ]]( player, 1 );
    }
}

// Namespace vehicle_compass
// Params 2
// Checksum 0x8ca9448d, Offset: 0x41a
// Size: 0x102
function function_3e3244741bc2a2ec( player, var_e6c819f806ce2c86 )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    leveldata = get_level_data();
    
    if ( !leveldata.visibilityisscriptcontrolled )
    {
        return;
    }
    
    if ( !leveldata.instances.size )
    {
        return;
    }
    
    var_cbaf02c53ccec36d = level.sharedfuncs[ #"vehicle" ][ #"vehicleshowonminimapforclient" ];
    
    if ( !isdefined( var_cbaf02c53ccec36d ) )
    {
        return;
    }
    
    foreach ( instance in leveldata.instances )
    {
        if ( !isdefined( instance ) )
        {
            continue;
        }
        
        instance builtin [[ var_cbaf02c53ccec36d ]]( player, 1 );
    }
}

// Namespace vehicle_compass
// Params 1
// Checksum 0xab57fb96, Offset: 0x524
// Size: 0x9b
function vehicle_show( vehicle )
{
    leveldata = get_level_data();
    
    if ( leveldata.visibilityisscriptcontrolled )
    {
        vehicle utility::callsharedfunc( #"vehicle", #"vehicleshowonminimap", 1 );
    }
    
    if ( isdefined( leveldata.instances[ vehicle getentitynumber() ] ) )
    {
        if ( level.teambased )
        {
            function_e527b9d6ae381350( vehicle, vehicle_occupancy::function_88fc32afbd317644( vehicle ) );
        }
        else
        {
            set_player_friendly_to( vehicle, vehicle_occupancy::get_player_friendly_to( vehicle ) );
        }
        
        function_875431dd0d57f2fd( vehicle, 1 );
    }
}

// Namespace vehicle_compass
// Params 1
// Checksum 0x3505ce92, Offset: 0x5c7
// Size: 0x5a
function vehicle_hide( vehicle )
{
    leveldata = get_level_data();
    leveldata.instances[ vehicle getentitynumber() ] = undefined;
    
    if ( leveldata.visibilityisscriptcontrolled )
    {
        vehicle utility::callsharedfunc( #"vehicle", #"vehicleshowonminimap", 0 );
    }
}

// Namespace vehicle_compass
// Params 2
// Checksum 0xb17b45c8, Offset: 0x629
// Size: 0x54
function function_e527b9d6ae381350( vehicle, team )
{
    if ( !isdefined( team ) || team == "neutral" || team == "none" )
    {
        team = utility::issp() ? "neutral" : "none";
    }
    
    vehicle setvehicleteam( team );
}

// Namespace vehicle_compass
// Params 2
// Checksum 0xb2e24664, Offset: 0x685
// Size: 0x1d
function set_player_friendly_to( vehicle, player )
{
    vehicle setentityowner( undefined );
}

// Namespace vehicle_compass
// Params 0
// Checksum 0x2e11171, Offset: 0x6aa
// Size: 0x10a
function init()
{
    assert( isdefined( level.vehicle ), "<dev string:x73>" );
    assert( !isdefined( level.vehicle.compass ), "<dev string:xa9>" );
    leveldata = spawnstruct();
    level.vehicle.compass = leveldata;
    leveldata.instances = [];
    runleanthreadmode = 0;
    
    if ( utility::issharedfuncdefined( #"game", #"runleanthreadmode" ) )
    {
        runleanthreadmode = [[ utility::getsharedfunc( #"game", #"runleanthreadmode" ) ]]();
    }
    
    leveldata.visibilityisscriptcontrolled = !runleanthreadmode || getdvarint( @"hash_61d6ab22f59b15a6", 1 ) > 0;
    
    if ( utility::issharedfuncdefined( #"vehicle_compass", #"init" ) )
    {
        [[ utility::getsharedfunc( #"vehicle_compass", #"init" ) ]]();
    }
}

// Namespace vehicle_compass
// Params 0
// Checksum 0x14834f64, Offset: 0x7bc
// Size: 0x36
function get_level_data()
{
    assert( isdefined( level.vehicle.compass ), "<dev string:xdd>" );
    return level.vehicle.compass;
}

// Namespace vehicle_compass
// Params 3
// Checksum 0x9a323b59, Offset: 0x7fb
// Size: 0x99
function function_863cca296c26ac67( vehicle, var_82e6ae7a41cd7ff8, var_e56f1d76e18cd597 )
{
    leveldata = get_level_data();
    isregistered = isdefined( leveldata.instances[ vehicle getentitynumber() ] ) && leveldata.instances[ vehicle getentitynumber() ] == vehicle;
    
    if ( !isregistered )
    {
        return;
    }
    
    if ( level.teambased )
    {
        function_e527b9d6ae381350( vehicle, var_e56f1d76e18cd597 );
    }
    else
    {
        set_player_friendly_to( vehicle, var_e56f1d76e18cd597 );
    }
    
    function_875431dd0d57f2fd( vehicle );
}

// Namespace vehicle_compass
// Params 1
// Checksum 0x750dea4d, Offset: 0x89c
// Size: 0x23
function player_joined_team_callback( player )
{
    if ( !level.teambased )
    {
        return;
    }
    
    function_3e3244741bc2a2ec( player );
}

// Namespace vehicle_compass
// Params 1
// Checksum 0xee9d6b0b, Offset: 0x8c7
// Size: 0x14
function player_spawned_callback( params )
{
    function_3e3244741bc2a2ec( self );
}

