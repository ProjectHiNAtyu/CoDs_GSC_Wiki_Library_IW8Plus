// scripts\mp\rally_point.gsc  (hash_1bf41126054f4e1d.gscc) (size: 6712 Bytes / 0x1a38 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb7d23bca (3084008394)
// size ...... 6712 (0x1a38)
// includes .. 13  (offset: 0x18d4)
// strings ... 18  (offset: 0x193c)
// dev strs .. 1   (offset: 0x1a28)
// exports ... 17  (offset: 0xfb4)
// cseg ...... 0x217 + 0xd9d (0xfb4)
// imports ... 56  (offset: 0x125c)
// animtree1 . 0   (offset: 0x1a38)
// animtree2 . 0   (offset: 0x1a38)
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_spawn;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\player;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\laststand;
#using scripts\mp\objectiveiconstates;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\spawnselection;
#using scripts\mp\teamrevive;

#namespace rally_point;

// Namespace rally_point
// Params 0
// Checksum 0xc0966b17, Offset: 0x235
// Size: 0x2
function init()
{
    
}

// Namespace rally_point
// Params 1
// Checksum 0xb8eadea0, Offset: 0x23f
// Size: 0x8e
function makerallypoint( object )
{
    if ( object.israllypoint )
    {
        return;
    }
    
    object.israllypoint = 1;
    object.registeredrallypointplayers = [];
    object.autorespawntime = getdvarint( @"scr_player_laststandtimer" );
    
    if ( !isdefined( level.rallypoints ) )
    {
        level.rallypoints = [];
    }
    
    level.rallypoints[ level.rallypoints.size ] = object;
    thread watchforplayerdeath( object );
    thread watchforrallypointdeath( object );
}

// Namespace rally_point
// Params 2
// Checksum 0x880b1060, Offset: 0x2d5
// Size: 0x8b
function registerplayerwithrallypoint( player, rallypoint )
{
    if ( !rallypoint.israllypoint )
    {
        debugprint( "Trying to register a player with an object that is not a rally point." );
        return;
    }
    
    debugprint( player.name + " has been registered wtih rally point: " + rallypoint.targetname );
    player.rallypoint = rallypoint;
    player.beingrallyrespawned = 0;
    rallypoint.registeredrallypointplayers[ rallypoint.registeredrallypointplayers.size ] = player;
}

// Namespace rally_point
// Params 1
// Checksum 0x19b58769, Offset: 0x368
// Size: 0xea
function watchforplayerdeath( rallypoint )
{
    while ( isdefined( rallypoint ) )
    {
        foreach ( player in rallypoint.registeredrallypointplayers )
        {
            if ( !isdefined( player ) )
            {
                rallypoint.registeredrallypointplayers = arrayremove( rallypoint.registeredrallypointplayers, player );
                continue;
            }
            
            if ( !player::isreallyalive( player ) && isdefined( player.rallypoint ) && !player.beingrallyrespawned )
            {
                prepareplayerforrespawn( player, rallypoint );
            }
        }
        
        wait 0.1;
    }
}

// Namespace rally_point
// Params 2
// Checksum 0x2781da6b, Offset: 0x45a
// Size: 0x1cb
function prepareplayerforrespawn( player, rallypoint )
{
    level endon( #"game_ended" );
    player endon( #"team_eliminated" );
    messagearray = [ "rally_point_respawn", "rally_point_destroyed" ];
    msg = player utility::waittill_any_in_array_or_timeout( messagearray, rallypoint.autorespawntime );
    
    if ( msg == "rally_point_destroyed" )
    {
        if ( isdefined( player ) || !player::isreallyalive( player ) )
        {
            return;
        }
        
        message = player lower_message::getlowermessage();
        player lower_message::setlowermessageomnvar( "rally_wait_revive", int( gettime() + self.timeuntilbleedout * 1000 ) );
        waitframe();
        player.lowertimer settimer( player.timelefttospawnaction );
        return;
    }
    
    player.beingrallyrespawned = 1;
    spawnposition = vectornormalize( anglestoforward( rallypoint.angles ) );
    spawnposition = spawnposition * -175 + rallypoint.origin;
    player.forcespawnorigin = getclosestpointonnavmesh( spawnposition );
    waitframe();
    debugprint( "Player respawning at rally point location:" + player.forcespawnorigin );
    player.forcespawnangles = ( 0, 90, 0 );
    player laststand::exit( "last_stand_self_revive" );
    player player::_freezecontrols( 0 );
    player thread teamrevive::respawn();
    player setclientomnvar( "ui_securing", 0 );
    player setclientomnvar( "ui_securing_progress", 0.01 );
    player.ui_securing = undefined;
    
    while ( !player::isreallyalive( player ) )
    {
        wait 0.1;
    }
    
    player.beingrallyrespawned = 0;
}

// Namespace rally_point
// Params 1
// Checksum 0xa7800b1f, Offset: 0x62d
// Size: 0xa5
function watchforrallypointdeath( rallypoint )
{
    rallypoint waittill( #"death" );
    
    foreach ( owner in rallypoint.registeredrallypointplayers )
    {
        owner notify( #"rally_point_destroyed" );
        owner iprintlnbold( "Your Rally Point has been destroyed" );
    }
}

// Namespace rally_point
// Params 1
// Checksum 0x731503a0, Offset: 0x6da
// Size: 0x1b
function debugprint( text )
{
    /#
        if ( true )
        {
            println( text );
        }
    #/
}

// Namespace rally_point
// Params 1
// Checksum 0x7a682ad, Offset: 0x6fd
// Size: 0x10b
function rallypointvehicle_activate( vehicle )
{
    spawndata = vehicle vehicle_tracking::get_spawn_data();
    team = vehicle.team;
    ref = "gw_vehicle_apc_1";
    vehicle.israllypointvehicle = 1;
    thread spawnselection::vehicleindangertracking( vehicle );
    spawnselection::adddynamicspawnarea( team, vehicle, ref, ( 0, 0, 128 ) );
    
    if ( level.var_3416583522672ad3 )
    {
        level.var_3297f3d0b4e2f8da[ team ][ level.var_3297f3d0b4e2f8da[ team ].size ] = ref;
        spawnselection::setspawnlocations( level.var_3297f3d0b4e2f8da[ team ], team );
    }
    else
    {
        level.spawnareas[ team ][ level.spawnareas[ team ].size ] = ref;
        spawnselection::setspawnlocations( level.spawnareas[ team ], team );
    }
    
    vehicle.ref = ref;
    rallypoint_activatevehiclemarker( vehicle );
    thread rallypoint_watchforvehicledeath( vehicle );
    thread rallypoint_wathcforenemydiscovery( vehicle );
}

// Namespace rally_point
// Params 1
// Checksum 0x173f9f97, Offset: 0x810
// Size: 0xc
function rallypointvehicle_deactivate( vehicle )
{
    
}

// Namespace rally_point
// Params 1
// Checksum 0xa5031454, Offset: 0x824
// Size: 0x10b
function rallypoint_showafterprematch( vehicle )
{
    vehicle endon( #"death" );
    flags::gameflagwait( "prematch_done" );
    
    foreach ( player in level.players )
    {
        if ( player.team == vehicle.team )
        {
            objidpoolmanager::objective_playermask_addshowplayer( vehicle.marker.objidnum, player );
            var_f526766138a4909a = vehicle_spawn::get_data( vehicle vehicle::get_ref() ).var_f526766138a4909a;
            assert( var_f526766138a4909a, "<dev string:x24>" );
            player lower_message::setlowermessageomnvar( var_f526766138a4909a, undefined, 5 );
        }
    }
}

// Namespace rally_point
// Params 1
// Checksum 0x663f10a0, Offset: 0x937
// Size: 0xe0
function rallypoint_watchforvehicledeath( vehicle )
{
    vehicle waittill( #"death" );
    
    if ( level.var_3416583522672ad3 )
    {
        level.var_3297f3d0b4e2f8da[ vehicle.team ] = arrayremove( level.var_3297f3d0b4e2f8da[ vehicle.team ], vehicle.ref );
    }
    else
    {
        level.spawnareas[ vehicle.team ] = arrayremove( level.spawnareas[ vehicle.team ], vehicle.ref );
    }
    
    rallypoint_deacivatevehiclemarker( vehicle );
    spawnselection::removedynamicspawnarea( vehicle.team, vehicle.ref );
    spawnselection::removespawnlocation( vehicle.ref, vehicle.team );
}

// Namespace rally_point
// Params 1
// Checksum 0x22197ef, Offset: 0xa1f
// Size: 0x26d
function rallypoint_activatevehiclemarker( vehicle )
{
    visibility = "friendly";
    origin = vehicle.origin + ( 0, 0, 128 );
    marker = gameobjects::createobjidobject( origin, "neutral", ( 0, 0, 0 ), undefined, visibility, 0 );
    objidpoolmanager::update_objective_ownerteam( marker.objidnum, vehicle.team );
    objidpoolmanager::objective_playermask_hidefromall( marker.objidnum );
    
    while ( level.players.size == 0 )
    {
        waitframe();
    }
    
    vehicle.marker = marker;
    
    if ( flags::gameflag( "prematch_done" ) )
    {
        foreach ( player in level.players )
        {
            if ( player.team == vehicle.team )
            {
                if ( player.inspawnselection )
                {
                    objidpoolmanager::objective_playermask_addshowplayer( vehicle.marker.objidnum, player );
                }
                
                var_f526766138a4909a = vehicle_spawn::get_data( vehicle vehicle::get_ref() ).var_f526766138a4909a;
                assert( var_f526766138a4909a, "<dev string:x24>" );
                player lower_message::setlowermessageomnvar( var_f526766138a4909a, undefined, 5 );
            }
        }
    }
    else
    {
        thread rallypoint_showafterprematch( vehicle );
    }
    
    objidpoolmanager::objective_set_play_intro( marker.objidnum, 0 );
    marker.lockupdatingicons = 0;
    objidpoolmanager::objective_pin_global( marker.objidnum, 0 );
    objidpoolmanager::update_objective_state( vehicle.marker.objidnum, "invisible" );
    objidpoolmanager::update_objective_onentity( marker.objidnum, vehicle );
    namespace_1cdb218d68ef13f6::set_objective_icon_state( vehicle.marker.objidnum, #"hash_407f994b1929d0cc" );
    marker.lockupdatingicons = 1;
    vehicle.marker = marker;
}

// Namespace rally_point
// Params 1
// Checksum 0xe3769c0, Offset: 0xc94
// Size: 0x50
function rallypoint_deacivatevehiclemarker( vehicle )
{
    vehicle.marker gameobjects::setvisibleteam( "none" );
    vehicle.marker gameobjects::releaseid();
    vehicle.marker.visibleteam = "none";
}

// Namespace rally_point
// Params 1
// Checksum 0x73d6afb4, Offset: 0xcec
// Size: 0x80
function rallypoint_wathcforenemydiscovery( vehicle )
{
    vehicle endon( #"death" );
    
    while ( !flags::gameflag( "prematch_done" ) )
    {
        waitframe();
    }
    
    rallypointtrigger = spawn( "trigger_radius", vehicle.origin - ( 0, 0, 512 ), 0, 1024, 1536 );
    rallypointtrigger thread watchrallytriggeruse( vehicle );
    rallypointtrigger waittill( #"rallypoint_revealed" );
    rallypointtrigger delete();
}

// Namespace rally_point
// Params 1
// Checksum 0xce6cbd3f, Offset: 0xd74
// Size: 0x124
function watchrallytriggeruse( vehicle )
{
    self endon( #"rallypoint_revealed" );
    vehicle endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        waitframe();
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( player.team == vehicle.team )
        {
            continue;
        }
        
        vehicle.revealed = 1;
        
        foreach ( plr in level.players )
        {
            objidpoolmanager::objective_playermask_addshowplayer( vehicle.marker.objidnum, plr );
        }
        
        self notify( #"rallypoint_revealed" );
    }
}

// Namespace rally_point
// Params 1
// Checksum 0xc489bd13, Offset: 0xea0
// Size: 0x114
function rallypoint_showtoplayer( player )
{
    player endon( #"death_or_disconnect" );
    
    while ( !flags::gameflag( "prematch_done" ) )
    {
        waitframe();
    }
    
    while ( !isdefined( player.team ) || player.team == "spectator" )
    {
        waitframe();
    }
    
    if ( isdefined( level.rallypointvehicles ) )
    {
        foreach ( vehicle in level.rallypointvehicles )
        {
            if ( !isdefined( vehicle ) )
            {
                continue;
            }
            
            if ( player.team == vehicle.team )
            {
                objidpoolmanager::objective_playermask_addshowplayer( vehicle.marker.objidnum, player );
            }
        }
    }
}

