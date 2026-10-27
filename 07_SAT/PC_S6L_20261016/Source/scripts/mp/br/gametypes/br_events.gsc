// scripts\mp\br\gametypes\br_events.gsc  (hash_202e1103ac8a0afd.gscc) (size: 3337 Bytes / 0xd09 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1a04e4ee (436528366)
// size ...... 3337 (0xd09)
// includes .. 4   (offset: 0xc65)
// strings ... 9   (offset: 0xc85)
// dev strs .. 0   (offset: 0xd09)
// exports ... 10  (offset: 0x711)
// cseg ...... 0xfe + 0x613 (0x711)
// imports ... 32  (offset: 0x8a1)
// animtree1 . 0   (offset: 0xd09)
// animtree2 . 0   (offset: 0xd09)
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\flags;

#namespace br_events;

// Namespace br_events
// Params 0
// Checksum 0x1ff78ebe, Offset: 0x11c
// Size: 0x5f
function breventsinit()
{
    br_events = getdvarint( @"scr_br_events", 0 );
    
    if ( !br_events )
    {
        return;
    }
    
    if ( br_events & 1 )
    {
        thread brevent1();
    }
    
    if ( br_events & 2 )
    {
        thread brevent2();
    }
    
    if ( br_events & 4 )
    {
        thread brevent3();
    }
    
    if ( br_events & 8 )
    {
        thread brevent4();
    }
}

// Namespace br_events
// Params 1
// Checksum 0x310989f4, Offset: 0x183
// Size: 0x31
function breventflagset( eventflag )
{
    current = self getclientomnvar( "ui_br_events" );
    self setclientomnvar( "ui_br_events", current | eventflag );
}

// Namespace br_events
// Params 1
// Checksum 0x87092b1e, Offset: 0x1bc
// Size: 0x32
function breventflagclear( eventflag )
{
    current = self getclientomnvar( "ui_br_events" );
    self setclientomnvar( "ui_br_events", current & ~eventflag );
}

// Namespace br_events
// Params 1
// Checksum 0x2faac22, Offset: 0x1f6
// Size: 0x3fd
function brevent1( videoname )
{
    if ( br_public::isanytutorialorbotpracticematch() )
    {
        return;
    }
    
    chance = getdvarfloat( @"scr_br_event1_chance", 0.04 );
    
    if ( chance <= randomfloat( 1 ) )
    {
        return;
    }
    
    flags::gameflagwait( "prematch_done" );
    mintime = getdvarfloat( @"hash_34e8f9306608b247", 180 );
    maxtime = getdvarfloat( @"hash_350ce73066310569", 300 );
    waittime = randomfloat( maxtime - mintime ) + mintime;
    wait waittime;
    
    if ( game_utility::getgametype() == "plunder" || !( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) ) || level.br_circle.circleindex < 0 )
    {
        circleorigin = level.br_level.br_mapcenter;
        circleradius = level.br_level.br_mapsize[ 0 ] * getdvarfloat( @"hash_18156afb52a30992", 0.5 );
    }
    else
    {
        circleorigin = level.br_level.br_circlecenters[ level.br_circle.circleindex ];
        circleradius = level.br_level.br_circleradii[ level.br_circle.circleindex ] * getdvarfloat( @"hash_18156afb52a30992", 1 );
    }
    
    eventheight = getdvarint( @"hash_5db9e9355474f47b", 18000 );
    circleorigin = ( circleorigin[ 0 ], circleorigin[ 1 ], eventheight );
    center = br_circle::getrandompointincircle( circleorigin, circleradius, 0, 1, 0, 0 );
    angles = ( 0, randomfloat( 360 ), 0 );
    dir = anglestoforward( angles );
    pathscale = getdvarfloat( @"hash_67211365c18c7382", 2 );
    pathradius = level.br_level.br_mapsize[ 0 ] * pathscale;
    start = center - dir * pathradius;
    end = center + dir * pathradius;
    emodel = spawn( "script_model", start );
    emodel setmodel( "x1_u2_plane" );
    emodel.angles = angles;
    dist = distance( start, end );
    speed = getdvarint( @"hash_424d58d410a4ef03", 8800 );
    time = dist / speed;
    
    /#
        if ( getdvarint( @"hash_5af00865c04c31ff", 0 ) )
        {
            line( start, end, ( 1, 0, 0 ), 1, 1, int( time / level.framedurationseconds ) );
        }
    #/
    
    playereventtime = getdvarfloat( @"hash_9a7bdd2b7675b5c6", 2 );
    
    foreach ( player in level.players )
    {
        if ( !brevent1playervalid( player ) )
        {
            continue;
        }
        
        playerdist = distance2d( emodel.origin, player.origin );
        waittime = playerdist / speed;
        player thread brevent1playerthink( waittime, playereventtime, videoname );
    }
    
    emodel moveto( end, time );
    wait time;
    emodel delete();
    level notify( #"hash_a7b6efa22c5af5ee" );
}

// Namespace br_events
// Params 1
// Checksum 0xdc5cb20e, Offset: 0x5fb
// Size: 0x41, Type: bool
function brevent1playervalid( player )
{
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    if ( player.br_iseliminated || !isalive( player ) || player.gulag )
    {
        return false;
    }
    
    return true;
}

// Namespace br_events
// Params 3
// Checksum 0x14ede01f, Offset: 0x645
// Size: 0xae
function brevent1playerthink( waittime, eventtime, videoname )
{
    self endon( #"disconnect" );
    wait waittime;
    
    if ( !isdefined( videoname ) )
    {
        videoname = "mp_amber";
    }
    
    if ( !brevent1playervalid( self ) )
    {
        return;
    }
    
    breventflagset( 1 );
    self playlocalsound( "br_event1_scramble_sfx" );
    self setclientomnvar( "ui_br_bink_overlay_state", 4 );
    self setclientomnvar( "ui_scrambler_strength", 5 );
    self playcinematicforplayer( videoname, 1, 1 );
    wait eventtime;
    breventflagclear( 1 );
    self stoplocalsound( "br_event1_scramble_sfx" );
    self setclientomnvar( "ui_br_bink_overlay_state", 0 );
    self setclientomnvar( "ui_scrambler_strength", 0 );
}

// Namespace br_events
// Params 0
// Checksum 0xbfea4532, Offset: 0x6fb
// Size: 0x2
function brevent2()
{
    
}

// Namespace br_events
// Params 0
// Checksum 0xc8ed75a4, Offset: 0x705
// Size: 0x2
function brevent3()
{
    
}

// Namespace br_events
// Params 0
// Checksum 0x5689e007, Offset: 0x70f
// Size: 0x2
function brevent4()
{
    
}

