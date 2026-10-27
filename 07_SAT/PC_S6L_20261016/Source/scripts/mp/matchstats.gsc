// scripts\mp\matchstats.gsc  (hash_3afe00da9a5bb422.gscc) (size: 4336 Bytes / 0x10f0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x64229b01 (1679989505)
// size ...... 4336 (0x10f0)
// includes .. 1   (offset: 0x1018)
// strings ... 8   (offset: 0x1020)
// dev strs .. 5   (offset: 0x10a4)
// exports ... 16  (offset: 0xa6c)
// cseg ...... 0xba + 0x9b2 (0xa6c)
// imports ... 27  (offset: 0xcec)
// animtree1 . 0   (offset: 0x10f0)
// animtree2 . 0   (offset: 0x10f0)
#using scripts\mp\flags;

#namespace matchstats;

// Namespace matchstats
// Params 0
// Checksum 0x86ea0144, Offset: 0xd8
// Size: 0x5d
function init()
{
    if ( !level.rankedmatch )
    {
        return;
    }
    
    level.matchstats = spawnstruct();
    level.matchstats.datawritten = 0;
    loadgamemodestatmap();
    thread watchplayerconnect();
    thread watchgameend();
    level.matchstats.enabled = 1;
}

// Namespace matchstats
// Params 0
// Checksum 0x9fa6fe75, Offset: 0x13d
// Size: 0xee
function loadgamemodestatmap()
{
    gametype = isbrgamemode() ? "br" : level.gametype;
    row = tablelookuprownum( "mp/gameModeMatchStats.csv", 0, gametype );
    var_46a86101f7e54403 = level.matchstats;
    
    if ( !isdefined( row ) || row < 0 )
    {
        println( "<dev string:x24>" );
        var_46a86101f7e54403.modestatsenabled = 0;
        return;
    }
    
    var_46a86101f7e54403.modestatsenabled = 1;
    var_46a86101f7e54403.modestatmap = [];
    
    for ( columnindex = 1; columnindex < 7 ; columnindex++ )
    {
        statname = tablelookupbyrow( "mp/gameModeMatchStats.csv", row, columnindex );
        
        if ( !isdefined( statname ) || statname == "" )
        {
            continue;
        }
        
        var_46a86101f7e54403.modestatmap[ statname ] = columnindex - 1;
    }
}

// Namespace matchstats
// Params 0
// Checksum 0x354af7db, Offset: 0x233
// Size: 0x38
function watchplayerconnect()
{
    while ( true )
    {
        level waittill( #"connected", player );
        
        if ( isai( player ) )
        {
            continue;
        }
        
        player thread initplayer();
    }
}

// Namespace matchstats
// Params 0
// Checksum 0xd130f19b, Offset: 0x273
// Size: 0x7c
function initplayer()
{
    if ( isdefined( self.pers[ "matchstats" ] ) )
    {
        self.matchstats = self.pers[ "matchstats" ];
        return;
    }
    
    self.matchstats = spawnstruct();
    var_610f555d57b53683 = self.matchstats;
    self.matchstats.values = [];
    self.matchstats.paths = [];
}

// Namespace matchstats
// Params 0
// Checksum 0x6dcb4ef5, Offset: 0x2f7
// Size: 0xb4
function watchgameend()
{
    flags::levelflagwait( "game_over" );
    players = level.players;
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player writeplayerinfo();
        waitframe();
    }
    
    level.matchstats.datawritten = 1;
}

// Namespace matchstats
// Params 0
// Checksum 0x66e0582f, Offset: 0x3b3
// Size: 0x1c3
function writeplayerinfo()
{
    var_610f555d57b53683 = self.matchstats;
    
    if ( !isdefined( var_610f555d57b53683 ) )
    {
        return;
    }
    
    assert( var_610f555d57b53683.paths.size == var_610f555d57b53683.values.size );
    
    foreach ( statkey, value in var_610f555d57b53683.values )
    {
        patharray = var_610f555d57b53683.paths[ statkey ];
        
        switch ( patharray.size )
        {
            case 1:
                self setplayerdata( level.var_6f9b00680ed002d8, "matchStats", patharray[ 0 ], value );
                break;
            case 2:
                self setplayerdata( level.var_6f9b00680ed002d8, "matchStats", patharray[ 0 ], patharray[ 1 ], value );
                break;
            case 3:
                self setplayerdata( level.var_6f9b00680ed002d8, "matchStats", patharray[ 0 ], patharray[ 1 ], patharray[ 2 ], value );
                break;
            case 4:
                self setplayerdata( level.var_6f9b00680ed002d8, "matchStats", patharray[ 0 ], patharray[ 1 ], patharray[ 2 ], patharray[ 3 ], value );
                break;
            case 5:
                self setplayerdata( level.var_6f9b00680ed002d8, "matchStats", patharray[ 0 ], patharray[ 1 ], patharray[ 2 ], patharray[ 3 ], patharray[ 4 ], value );
                break;
        }
    }
}

// Namespace matchstats
// Params 1
// Checksum 0x7d14eca2, Offset: 0x57e
// Size: 0x4e
function getmatchstatpathkey( patharray )
{
    pathstring = "";
    
    for ( i = 0; i < patharray.size ; i++ )
    {
        if ( isdefined( patharray[ i ] ) )
        {
            pathstring += patharray[ i ] + ".";
        }
    }
    
    return pathstring;
}

// Namespace matchstats
// Params 6
// Checksum 0x1c29da37, Offset: 0x5d5
// Size: 0xee
function setmatchstat( value, path1, path2, path3, path4, path5 )
{
    if ( !arematchstatsenabled() )
    {
        return;
    }
    
    assert( !level.matchstats.datawritten, "<dev string:x6e>" );
    patharray = [ path1 ];
    
    if ( isdefined( path2 ) )
    {
        patharray[ patharray.size ] = path2;
    }
    
    if ( isdefined( path3 ) )
    {
        patharray[ patharray.size ] = path3;
    }
    
    if ( isdefined( path4 ) )
    {
        patharray[ patharray.size ] = path4;
    }
    
    if ( isdefined( path5 ) )
    {
        patharray[ patharray.size ] = path5;
    }
    
    pathkey = getmatchstatpathkey( patharray );
    self.matchstats.values[ pathkey ] = value;
    self.matchstats.paths[ pathkey ] = patharray;
}

// Namespace matchstats
// Params 6
// Checksum 0x96e89b5e, Offset: 0x6cb
// Size: 0x145
function addtomatchstat( incrementamount, path1, path2, path3, path4, path5 )
{
    if ( !arematchstatsenabled() )
    {
        return;
    }
    
    assert( !level.matchstats.datawritten, "<dev string:x6e>" );
    
    if ( !isdefined( incrementamount ) )
    {
        incrementamount = 1;
    }
    
    patharray = [ path1 ];
    
    if ( isdefined( path2 ) )
    {
        patharray[ patharray.size ] = path2;
    }
    
    if ( isdefined( path3 ) )
    {
        patharray[ patharray.size ] = path3;
    }
    
    if ( isdefined( path4 ) )
    {
        patharray[ patharray.size ] = path4;
    }
    
    if ( isdefined( path5 ) )
    {
        patharray[ patharray.size ] = path5;
    }
    
    pathkey = getmatchstatpathkey( patharray );
    
    if ( !isdefined( self.matchstats.paths[ pathkey ] ) )
    {
        self.matchstats.values[ pathkey ] = incrementamount;
        self.matchstats.paths[ pathkey ] = patharray;
        return;
    }
    
    self.matchstats.values[ pathkey ] += incrementamount;
}

// Namespace matchstats
// Params 5
// Checksum 0xb9c2cb47, Offset: 0x818
// Size: 0xab
function getmatchstat( path1, path2, path3, path4, path5 )
{
    if ( !arematchstatsenabled() )
    {
        return;
    }
    
    patharray = [ path1, path2, path3, path4, path5 ];
    pathkey = getmatchstatpathkey( patharray );
    
    if ( !isdefined( self.matchstats.values[ pathkey ] ) )
    {
        return 0;
    }
    
    return self.matchstats.values[ pathkey ];
}

// Namespace matchstats
// Params 1
// Checksum 0xefdce539, Offset: 0x8cc
// Size: 0x40
function getmodestatindex( statname )
{
    var_46a86101f7e54403 = level.matchstats;
    
    if ( !isdefined( var_46a86101f7e54403.modestatsenabled ) )
    {
        return;
    }
    
    return var_46a86101f7e54403.modestatmap[ statname ];
}

// Namespace matchstats
// Params 2
// Checksum 0xb0f6625d, Offset: 0x915
// Size: 0x62
function setgamemodestat( statname, newvalue )
{
    if ( !arematchstatsenabled() )
    {
        return;
    }
    
    statindex = getmodestatindex( statname );
    
    if ( !isdefined( statindex ) )
    {
        assertmsg( "<dev string:xb7>" + statname + "<dev string:xd6>" );
        return;
    }
    
    setmatchstat( newvalue, "modeStats", statindex );
}

// Namespace matchstats
// Params 2
// Checksum 0xb0cde5fc, Offset: 0x97f
// Size: 0x62
function addtogamemodestat( statname, incrementamount )
{
    if ( !arematchstatsenabled() )
    {
        return;
    }
    
    statindex = getmodestatindex( statname );
    
    if ( !isdefined( statindex ) )
    {
        assertmsg( "<dev string:x112>" + statname + "<dev string:xd6>" );
        return;
    }
    
    addtomatchstat( incrementamount, "modeStats", statindex );
}

// Namespace matchstats
// Params 1
// Checksum 0x71f64e94, Offset: 0x9e9
// Size: 0x56
function getgamemodestat( statname )
{
    if ( !arematchstatsenabled() )
    {
        return;
    }
    
    statindex = getmodestatindex( statname );
    
    if ( !isdefined( statindex ) )
    {
        assertmsg( "<dev string:x112>" + statname + "<dev string:xd6>" );
        return;
    }
    
    return getmatchstat( "modeStats", statindex );
}

// Namespace matchstats
// Params 0
// Checksum 0x506159b2, Offset: 0xa48
// Size: 0x23, Type: bool
function arematchstatsenabled()
{
    return isdefined( level.matchstats ) && level.matchstats.enabled;
}

