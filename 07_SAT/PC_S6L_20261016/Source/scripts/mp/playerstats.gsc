// scripts\mp\playerstats.gsc  (hash_35e7732d85cf4fb4.gscc) (size: 6987 Bytes / 0x1b4b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x283951b3 (674845107)
// size ...... 6987 (0x1b4b)
// includes .. 4   (offset: 0x1967)
// strings ... 21  (offset: 0x1987)
// dev strs .. 3   (offset: 0x1b27)
// exports ... 22  (offset: 0x10e7)
// cseg ...... 0x13f + 0xfa8 (0x10e7)
// imports ... 42  (offset: 0x1457)
// animtree1 . 0   (offset: 0x1b4b)
// animtree2 . 0   (offset: 0x1b4b)
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\flags;
#using scripts\mp\playerstats_interface;

#namespace playerstats;

// Namespace playerstats
// Params 0
// Checksum 0x3a89ffb0, Offset: 0x15d
// Size: 0x1c3
function init()
{
    utility::registersharedfunc( #"player", #"hash_d89fce013242f931", &initplayer );
    
    if ( !level.onlinestatsenabled )
    {
        return;
    }
    
    level.playerstats = function_3d300f501f20e5aa();
    playerstats_interface::registerplayerstatratio( [ "combatStats", "kdRatio" ], [ "combatStats", "kills" ], [ "combatStats", "deaths" ] );
    playerstats_interface::registerplayerstatratio( [ "combatStats", "accuracy" ], [ "combatStats", "hits" ], [ "combatStats", "totalShots" ] );
    playerstats_interface::registerplayerstatratio( [ "matchStats", "winLossRatio" ], [ "matchStats", "wins" ], [ "matchStats", "losses" ] );
    addtostatgroup( "kdr", "combatStats", "kills" );
    addtostatgroup( "kdr", "combatStats", "deaths" );
    addtostatgroup( "kdr", "combatStats", "kdRatio" );
    addtostatgroup( "winLoss", "matchStats", "wins" );
    addtostatgroup( "winLoss", "matchStats", "losses" );
    addtostatgroup( "winLoss", "matchStats", "winLossRatio" );
    addtostatgroup( "winLoss", "matchStats", "winStreak" );
    addtostatgroup( "winLoss", "matchStats", "ties" );
    addtostatgroup( "losses", "matchStats", "losses" );
}

// Namespace playerstats
// Params 0
// Checksum 0xc5f28c2c, Offset: 0x328
// Size: 0x70
function function_3d300f501f20e5aa()
{
    globals = spawnstruct();
    globals.statgroups = [];
    globals.disabledstats = [];
    globals.enabled = 1;
    globals.readonly = 0;
    globals.ratios = [];
    globals.ratiochildren = [];
    globals.disabledpaths = [];
    return globals;
}

// Namespace playerstats
// Params 0
// Checksum 0x63427062, Offset: 0x3a1
// Size: 0x5e
function initplayer()
{
    if ( !level.onlinestatsenabled )
    {
        return;
    }
    
    if ( isdefined( self.pers[ "playerstats" ] ) )
    {
        self.playerstats = self.pers[ "playerstats" ];
    }
    else
    {
        self.playerstats = function_66626e35d76bc952();
    }
    
    if ( !game_utility_mp::runleanthreadmode() )
    {
        thread bufferedstatwritethink();
    }
}

// Namespace playerstats
// Params 0
// Checksum 0xfd15c1ad, Offset: 0x407
// Size: 0x3b
function function_66626e35d76bc952()
{
    playerstats = spawnstruct();
    playerstats.values = [];
    playerstats.paths = [];
    playerstats.bufferedstats = [];
    return playerstats;
}

// Namespace playerstats
// Params 1
// Checksum 0x26946229, Offset: 0x44b
// Size: 0x42
function bufferedstatwritethink( gamemode )
{
    self endon( #"disconnect" );
    
    while ( !flags::levelflag( "game_over" ) )
    {
        writebufferedstats( gamemode );
        wait 2;
    }
    
    writebufferedstats( gamemode );
}

// Namespace playerstats
// Params 1
// Checksum 0x3f42e379, Offset: 0x495
// Size: 0xf4
function writebufferedstats( gamemode )
{
    if ( isai( self ) )
    {
        return;
    }
    
    playerstats = playerstats_interface::function_e11e328ebfe147e( gamemode );
    
    foreach ( pathkey, unused in playerstats.bufferedstats )
    {
        patharray = playerstats.paths[ pathkey ];
        value = playerstats.values[ pathkey ];
        writeplayerstat( value, patharray[ 0 ], patharray[ 1 ], patharray[ 2 ], patharray[ 3 ], patharray[ 4 ], gamemode );
    }
    
    playerstats.bufferedstats = [];
}

// Namespace playerstats
// Params 5
// Checksum 0xc0b49d95, Offset: 0x591
// Size: 0xdb
function getplayerstatpathkey( path1, path2, path3, path4, path5 )
{
    pathstring = "";
    
    if ( isdefined( path5 ) )
    {
        pathstring = path1 + "." + path2 + "." + path3 + "." + path4 + "." + path5;
    }
    else if ( isdefined( path4 ) )
    {
        pathstring = path1 + "." + path2 + "." + path3 + "." + path4;
    }
    else if ( isdefined( path3 ) )
    {
        pathstring = path1 + "." + path2 + "." + path3;
    }
    else if ( isdefined( path2 ) )
    {
        pathstring = path1 + "." + path2;
    }
    else if ( isdefined( path1 ) )
    {
        pathstring = path1;
    }
    
    return pathstring;
}

// Namespace playerstats
// Params 7
// Checksum 0xc33fa0d5, Offset: 0x675
// Size: 0xee
function writeplayerstat( value, path1, path2, path3, path4, path5, gamemode )
{
    playerstatsstr = playerstats_interface::function_4b454cbef313e5f1( gamemode );
    
    if ( isdefined( path5 ) )
    {
        self setplayerdata( level.var_6f9b00680ed002d8, playerstatsstr, path1, path2, path3, path4, path5, value );
        return;
    }
    
    if ( isdefined( path4 ) )
    {
        self setplayerdata( level.var_6f9b00680ed002d8, playerstatsstr, path1, path2, path3, path4, value );
        return;
    }
    
    if ( isdefined( path3 ) )
    {
        self setplayerdata( level.var_6f9b00680ed002d8, playerstatsstr, path1, path2, path3, value );
        return;
    }
    
    if ( isdefined( path2 ) )
    {
        self setplayerdata( level.var_6f9b00680ed002d8, playerstatsstr, path1, path2, value );
        return;
    }
    
    if ( isdefined( path1 ) )
    {
        self setplayerdata( level.var_6f9b00680ed002d8, playerstatsstr, path1, value );
    }
}

// Namespace playerstats
// Params 6
// Checksum 0xe33b3fbe, Offset: 0x76b
// Size: 0xde
function readplayerstat( path1, path2, path3, path4, path5, gamemode )
{
    playerstatsstr = playerstats_interface::function_4b454cbef313e5f1( gamemode );
    
    if ( isdefined( path5 ) )
    {
        return self getplayerdata( level.var_6f9b00680ed002d8, playerstatsstr, path1, path2, path3, path4, path5 );
    }
    
    if ( isdefined( path4 ) )
    {
        return self getplayerdata( level.var_6f9b00680ed002d8, playerstatsstr, path1, path2, path3, path4 );
    }
    
    if ( isdefined( path3 ) )
    {
        return self getplayerdata( level.var_6f9b00680ed002d8, playerstatsstr, path1, path2, path3 );
    }
    
    if ( isdefined( path2 ) )
    {
        return self getplayerdata( level.var_6f9b00680ed002d8, playerstatsstr, path1, path2 );
    }
    
    if ( isdefined( path1 ) )
    {
        return self getplayerdata( level.var_6f9b00680ed002d8, playerstatsstr, path1 );
    }
}

// Namespace playerstats
// Params 2
// Checksum 0x31ad473, Offset: 0x851
// Size: 0x97
function flagstatforbufferedwrite( pathkey, gamemode )
{
    playerstats = playerstats_interface::function_e11e328ebfe147e( gamemode );
    
    if ( flags::levelflag( "game_over" ) )
    {
        patharray = playerstats.paths[ pathkey ];
        value = playerstats.values[ pathkey ];
        writeplayerstat( value, patharray[ 0 ], patharray[ 1 ], patharray[ 2 ], patharray[ 3 ], patharray[ 4 ], gamemode );
        return;
    }
    
    playerstats.bufferedstats[ pathkey ] = 1;
}

// Namespace playerstats
// Params 8
// Checksum 0x2a5404b0, Offset: 0x8f0
// Size: 0xae
function setplayerstat_internal( value, pathkey, path1, path2, path3, path4, path5, gamemode )
{
    playerstats = playerstats_interface::function_e11e328ebfe147e( gamemode );
    playerstats.values[ pathkey ] = value;
    
    if ( !isdefined( playerstats.paths[ pathkey ] ) )
    {
        playerstats.paths[ pathkey ] = [ path1, path2, path3, path4, path5 ];
    }
}

// Namespace playerstats
// Params 8
// Checksum 0x9da3f08, Offset: 0x9a6
// Size: 0xee
function addtoplayerstat_internal( incrementamount, pathkey, path1, path2, path3, path4, path5, gamemode )
{
    playerstats = playerstats_interface::function_e11e328ebfe147e( gamemode );
    
    if ( !isdefined( playerstats.paths[ pathkey ] ) )
    {
        playerdatavalue = readplayerstat( path1, path2, path3, path4, path5, gamemode );
        playerstats.values[ pathkey ] = playerdatavalue + incrementamount;
        playerstats.paths[ pathkey ] = [ path1, path2, path3, path4, path5 ];
        return;
    }
    
    playerstats.values[ pathkey ] += incrementamount;
}

// Namespace playerstats
// Params 3
// Checksum 0x1edc8fb8, Offset: 0xa9c
// Size: 0xbd
function modifystatwritability( pathkey, writable, gamemode )
{
    globals = playerstats_interface::function_39efb33b2ce235b4( gamemode );
    
    if ( writable )
    {
        assert( globals.disabledstats[ pathkey ] > 0, "<dev string:x24>" );
        globals.disabledstats[ pathkey ]--;
        
        if ( globals.disabledstats[ pathkey ] <= 0 )
        {
            globals.disabledstats[ pathkey ] = undefined;
        }
        
        return;
    }
    
    if ( !isdefined( globals.disabledstats[ pathkey ] ) )
    {
        globals.disabledstats[ pathkey ] = 1;
        return;
    }
    
    globals.disabledstats[ pathkey ]++;
}

// Namespace playerstats
// Params 2
// Checksum 0x4cff75a3, Offset: 0xb61
// Size: 0x51, Type: bool
function isstatwritable_internal( pathkey, gamemode )
{
    if ( playerstats_interface::areplayerstatsreadonly( gamemode ) )
    {
        return false;
    }
    
    globals = playerstats_interface::function_39efb33b2ce235b4( gamemode );
    assert( isdefined( globals ) );
    return !isdefined( globals.disabledstats[ pathkey ] );
}

// Namespace playerstats
// Params 7
// Checksum 0x81fb0103, Offset: 0xbbb
// Size: 0xae
function addtostatgroup( statgroup, path1, path2, path3, path4, path5, gamemode )
{
    globals = playerstats_interface::function_39efb33b2ce235b4( gamemode );
    pathkey = getplayerstatpathkey( path1, path2, path3, path4, path5 );
    
    if ( !isdefined( globals.statgroups[ statgroup ] ) )
    {
        globals.statgroups[ statgroup ] = [];
    }
    
    globals.statgroups[ statgroup ][ globals.statgroups[ statgroup ].size ] = pathkey;
}

// Namespace playerstats
// Params 3
// Checksum 0xf913fe42, Offset: 0xc71
// Size: 0xb0
function modifystatgroupwritability( statgroup, writable, gamemode )
{
    globals = playerstats_interface::function_39efb33b2ce235b4( gamemode );
    
    foreach ( pathkey in globals.statgroups[ statgroup ] )
    {
        modifystatwritability( pathkey, writable, gamemode );
    }
}

// Namespace playerstats
// Params 6
// Checksum 0x6303c667, Offset: 0xd29
// Size: 0x13d
function calculateplayerstatratio( path1, path2, path3, path4, path5, gamemode )
{
    if ( !playerstats_interface::areplayerstatsenabled( gamemode ) )
    {
        return;
    }
    
    globals = playerstats_interface::function_39efb33b2ce235b4( gamemode );
    pathkey = getplayerstatpathkey( path1, path2, path3, path4, path5 );
    
    if ( !isdefined( globals.ratios[ pathkey ] ) )
    {
        assertmsg( "<dev string:x72>" + pathkey + "<dev string:xa2>" );
    }
    
    if ( !isstatwritable_internal( pathkey, gamemode ) )
    {
        return;
    }
    
    numarray = globals.ratios[ pathkey ][ "numerator" ];
    denomarray = globals.ratios[ pathkey ][ "denominator" ];
    numerator = playerstats_interface::getplayerstat( numarray[ 0 ], numarray[ 1 ], numarray[ 2 ], numarray[ 3 ], numarray[ 4 ], gamemode );
    denominator = playerstats_interface::getplayerstat( denomarray[ 0 ], denomarray[ 1 ], denomarray[ 2 ], denomarray[ 3 ], denomarray[ 4 ], gamemode );
    
    if ( denominator == 0 )
    {
        denominator = 1;
    }
    
    return numerator / denominator;
}

// Namespace playerstats
// Params 6
// Checksum 0xe09ea32b, Offset: 0xe6f
// Size: 0x64
function updateplayerstatratio( path1, path2, path3, path4, path5, gamemode )
{
    value = calculateplayerstatratio( path1, path2, path3, path4, path5, gamemode );
    playerstats_interface::setplayerstat( value, path1, path2, path3, path4, path5, gamemode );
}

// Namespace playerstats
// Params 6
// Checksum 0x8dd3e814, Offset: 0xedb
// Size: 0x64
function updateplayerstatratiobuffered( path1, path2, path3, path4, path5, gamemode )
{
    value = calculateplayerstatratio( path1, path2, path3, path4, path5, gamemode );
    playerstats_interface::setplayerstatbuffered( value, path1, path2, path3, path4, path5, gamemode );
}

// Namespace playerstats
// Params 2
// Checksum 0xfa2b8b9e, Offset: 0xf47
// Size: 0xcc
function updateparentratios( var_a7dbdacf58d4234b, gamemode )
{
    globals = playerstats_interface::function_39efb33b2ce235b4( gamemode );
    
    if ( !isdefined( globals.ratiochildren[ var_a7dbdacf58d4234b ] ) )
    {
        return;
    }
    
    foreach ( parentpatharray in globals.ratiochildren[ var_a7dbdacf58d4234b ] )
    {
        updateplayerstatratio( parentpatharray[ 0 ], parentpatharray[ 1 ], parentpatharray[ 2 ], parentpatharray[ 3 ], parentpatharray[ 4 ], gamemode );
    }
}

// Namespace playerstats
// Params 2
// Checksum 0x186bb5e, Offset: 0x101b
// Size: 0xcc
function updateparentratiosbuffered( var_a7dbdacf58d4234b, gamemode )
{
    globals = playerstats_interface::function_39efb33b2ce235b4( gamemode );
    
    if ( !isdefined( globals.ratiochildren[ var_a7dbdacf58d4234b ] ) )
    {
        return;
    }
    
    foreach ( parentpatharray in globals.ratiochildren[ var_a7dbdacf58d4234b ] )
    {
        updateplayerstatratiobuffered( parentpatharray[ 0 ], parentpatharray[ 1 ], parentpatharray[ 2 ], parentpatharray[ 3 ], parentpatharray[ 4 ], gamemode );
    }
}

