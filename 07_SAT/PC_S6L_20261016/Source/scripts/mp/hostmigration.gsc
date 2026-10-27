// scripts\mp\hostmigration.gsc  (hash_35b1921537324436.gscc) (size: 4780 Bytes / 0x12ac / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x96b6ea32 (2528569906)
// size ...... 4780 (0x12ac)
// includes .. 3   (offset: 0x1154)
// strings ... 16  (offset: 0x116c)
// dev strs .. 8   (offset: 0x1240)
// exports ... 15  (offset: 0xae8)
// cseg ...... 0x192 + 0x956 (0xae8)
// imports ... 30  (offset: 0xd40)
// animtree1 . 0   (offset: 0x12ac)
// animtree2 . 0   (offset: 0x12ac)
#using scripts\common\game_utility;
#using scripts\common\utility;
#using scripts\mp\common\utility\player;

#namespace hostmigration;

// Namespace hostmigration
// Params 0
// Checksum 0x2f3f761c, Offset: 0x1b0
// Size: 0x226
function callback_hostmigration()
{
    level.hostmigrationreturnedplayercount = 0;
    
    if ( level.gameended )
    {
        println( "<dev string:x24>" + gettime() + "<dev string:x40>" );
        return;
    }
    
    if ( analyticsstreamerislogfilestreamingenabled() )
    {
        analyticsstreamerlogfilestartstream();
    }
    
    println( "<dev string:x24>" + gettime() );
    level thread hostmigrationconnectwatcher();
    
    foreach ( character in level.characters )
    {
        character.hostmigrationcontrolsfrozen = 0;
    }
    
    level.hostmigrationtimer = 1;
    setdvar( @"ui_inhostmigration", 1 );
    level.hostmigration = 1;
    level notify( #"host_migration_begin" );
    level [[ level.updatetimerpausedness ]]();
    
    foreach ( character in level.characters )
    {
        if ( !isdefined( character ) )
        {
            continue;
        }
        
        character thread hostmigrationtimerthink();
        
        if ( isplayer( character ) )
        {
            character setclientomnvar( "ui_session_state", character.sessionstate );
        }
    }
    
    level endon( #"host_migration_begin" );
    hostmigrationwait();
    level.hostmigrationtimer = undefined;
    setdvar( @"ui_inhostmigration", 0 );
    println( "<dev string:x67>" + gettime() );
    visionsetthermal( game[ "thermal_vision" ] );
    level.hostmigration = 0;
    level notify( #"host_migration_end" );
    level [[ level.updatetimerpausedness ]]();
    level thread [[ level.updategameevents ]]();
}

// Namespace hostmigration
// Params 0
// Checksum 0x190b3783, Offset: 0x3de
// Size: 0x5c
function hostmigrationconnectwatcher()
{
    level endon( #"host_migration_end" );
    level endon( #"host_migration_begin" );
    level waittill( #"connected", player );
    player thread hostmigrationtimerthink();
    
    if ( isplayer( player ) )
    {
        player setclientomnvar( "ui_session_state", player.sessionstate );
    }
}

// Namespace hostmigration
// Params 0
// Checksum 0xe6243589, Offset: 0x442
// Size: 0x11a
function hostmigrationwait()
{
    level endon( #"game_ended" );
    level.ingraceperiod = 25;
    level thread [[ level.matchstarttimer ]]( "waiting_for_players", 20 );
    hostmigrationwaitforplayers();
    level.ingraceperiod = 10;
    level thread [[ level.matchstarttimer ]]( "match_resuming_in", 5 );
    wait 5;
    level.ingraceperiod = 0;
    
    foreach ( p in level.players )
    {
        p setclientomnvar( "ui_match_start_countdown", 0 );
        p setclientomnvar( "ui_match_in_progress", 1 );
    }
    
    if ( level.forfeitinprogress && !level.forfeit_aborted )
    {
        setomnvar( "ui_match_start_text", "opponent_forfeiting_in" );
    }
}

// Namespace hostmigration
// Params 0
// Checksum 0x63a355a7, Offset: 0x564
// Size: 0x11
function hostmigrationwaitforplayers()
{
    level endon( #"hostmigration_enoughplayers" );
    wait 15;
}

// Namespace hostmigration
// Params 1
// Checksum 0x8659ffcc, Offset: 0x57d
// Size: 0xda
function hostmigrationname( ent )
{
    if ( !isdefined( ent ) )
    {
        return "<removed_ent>";
    }
    
    entnum = -1;
    entname = "?";
    
    if ( isdefined( ent.entity_number ) )
    {
        entnum = ent.entity_number;
    }
    
    if ( isplayer( ent ) && isdefined( ent.name ) )
    {
        entname = ent.name;
    }
    
    if ( isplayer( ent ) )
    {
        return ( "player <" + entname + ">" );
    }
    
    if ( isagent( ent ) && game_utility_common::isgameparticipant( ent ) )
    {
        return ( "participant agent <" + entnum + ">" );
    }
    
    if ( isagent( ent ) )
    {
        return ( "non-participant agent <" + entnum + ">" );
    }
    
    return "unknown entity <" + entnum + ">";
}

// Namespace hostmigration
// Params 0
// Checksum 0xa29cb09e, Offset: 0x660
// Size: 0xa0
function hostmigrationtimerthink_internal()
{
    level endon( #"host_migration_begin" );
    level endon( #"host_migration_end" );
    assert( isdefined( self.hostmigrationcontrolsfrozen ), "<dev string:x83>" + hostmigrationname( self ) );
    
    while ( !player::isreallyalive( self ) )
    {
        self waittill( #"spawned" );
    }
    
    println( "<dev string:xb0>" + hostmigrationname( self ) + "<dev string:xd1>" + self.hostmigrationcontrolsfrozen );
    self.hostmigrationcontrolsfrozen = 1;
    player::_freezecontrols( 1, undefined, "hostMigrationTimer" );
    level waittill( #"host_migration_end" );
}

// Namespace hostmigration
// Params 0
// Checksum 0x8cebf7b0, Offset: 0x708
// Size: 0xa8
function hostmigrationtimerthink()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    assert( isdefined( self.hostmigrationcontrolsfrozen ), "<dev string:x83>" + hostmigrationname( self ) );
    hostmigrationtimerthink_internal();
    assert( isdefined( self.hostmigrationcontrolsfrozen ), "<dev string:xf6>" + hostmigrationname( self ) );
    println( "<dev string:x11a>" + hostmigrationname( self ) + "<dev string:xd1>" + self.hostmigrationcontrolsfrozen );
    
    if ( self.hostmigrationcontrolsfrozen )
    {
        player::_freezecontrols( 0, undefined, "hostMigrationTimer" );
        self.hostmigrationcontrolsfrozen = undefined;
    }
}

// Namespace hostmigration
// Params 0
// Checksum 0x93f9ff1c, Offset: 0x7b8
// Size: 0x36
function waittillhostmigrationdone()
{
    if ( !isdefined( level.hostmigrationtimer ) )
    {
        return 0;
    }
    
    starttime = gettime();
    level waittill( #"host_migration_end" );
    return gettime() - starttime;
}

// Namespace hostmigration
// Params 1
// Checksum 0x9bb9896b, Offset: 0x7f7
// Size: 0x29
function waittillhostmigrationstarts( duration )
{
    if ( isdefined( level.hostmigrationtimer ) )
    {
        return;
    }
    
    level endon( #"host_migration_begin" );
    wait duration;
}

// Namespace hostmigration
// Params 2
// Checksum 0x78b9adcc, Offset: 0x828
// Size: 0x5c
function waittillnotifyortimeoutpause( msg, duration )
{
    if ( utility::issharedfuncdefined( #"hostmigration", #"waittillNotifyOrTimeoutPause" ) )
    {
        return self [[ utility::getsharedfunc( #"hostmigration", #"waittillNotifyOrTimeoutPause" ) ]]( msg, duration );
    }
    
    return utility::waittill_any_timeout( duration, msg );
}

// Namespace hostmigration
// Params 1
// Checksum 0xc095eceb, Offset: 0x88c
// Size: 0x9d
function waitlongdurationwithhostmigrationpause( duration )
{
    if ( !isdefined( duration ) || duration == 0 )
    {
        return;
    }
    
    assert( duration > 0 );
    starttime = gettime();
    endtime = gettime() + duration * 1000;
    
    while ( gettime() < endtime )
    {
        waittillhostmigrationstarts( ( endtime - gettime() ) / 1000 );
        
        if ( isdefined( level.hostmigrationtimer ) )
        {
            timepassed = waittillhostmigrationdone();
            endtime += timepassed;
        }
    }
    
    waittillhostmigrationdone();
    return gettime() - starttime;
}

// Namespace hostmigration
// Params 1
// Checksum 0xdce363f5, Offset: 0x932
// Size: 0x4a
function waitlongdurationwithpause( duration )
{
    if ( utility::issharedfuncdefined( #"hostmigration", #"waitLongDurationWithPause" ) )
    {
        [[ utility::getsharedfunc( #"hostmigration", #"waitLongDurationWithPause" ) ]]( duration );
        return;
    }
    
    wait duration;
}

// Namespace hostmigration
// Params 2
// Checksum 0xb80284c2, Offset: 0x984
// Size: 0xa3
function waittill_notify_or_timeout_hostmigration_pause( msg, duration )
{
    self endon( msg );
    
    if ( duration == 0 )
    {
        return;
    }
    
    assert( duration > 0 );
    starttime = gettime();
    endtime = gettime() + duration * 1000;
    
    while ( gettime() < endtime )
    {
        waittillhostmigrationstarts( ( endtime - gettime() ) / 1000 );
        
        if ( isdefined( level.hostmigrationtimer ) )
        {
            timepassed = waittillhostmigrationdone();
            endtime += timepassed;
        }
    }
    
    waittillhostmigrationdone();
    return gettime() - starttime;
}

// Namespace hostmigration
// Params 1
// Checksum 0x2e2b6477, Offset: 0xa30
// Size: 0xb7
function waitlongdurationwithgameendtimeupdate( duration )
{
    if ( duration == 0 )
    {
        return;
    }
    
    assert( duration > 0 );
    starttime = gettime();
    endtime = gettime() + duration * 1000;
    
    while ( gettime() < endtime )
    {
        waittillhostmigrationstarts( ( endtime - gettime() ) / 1000 );
        
        while ( isdefined( level.hostmigrationtimer ) )
        {
            endtime += 1000;
            setgameendtime( int( endtime ) );
            wait 1;
        }
    }
    
    while ( isdefined( level.hostmigrationtimer ) )
    {
        endtime += 1000;
        setgameendtime( int( endtime ) );
        wait 1;
    }
    
    return gettime() - starttime;
}

