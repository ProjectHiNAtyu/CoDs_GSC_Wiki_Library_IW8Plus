// scripts\mp\common\utility\squad_utility.gsc  (hash_14d76aa023628152.gscc) (size: 4161 Bytes / 0x1041 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x994462d (160712237)
// size ...... 4161 (0x1041)
// includes .. 3   (offset: 0xfed)
// strings ... 2   (offset: 0x1005)
// dev strs .. 3   (offset: 0x101d)
// exports ... 17  (offset: 0xa59)
// cseg ...... 0x107 + 0x952 (0xa59)
// imports ... 24  (offset: 0xd01)
// animtree1 . 0   (offset: 0x1041)
// animtree2 . 0   (offset: 0x1041)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\teams;

#namespace squad_utility;

// Namespace squad_utility
// Params 0, eflags: 0x5
// Checksum 0xa2408b7a, Offset: 0x125
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"squad_utils", undefined, undefined, &post_main );
}

// Namespace squad_utility
// Params 0, eflags: 0x4
// Checksum 0xad69a264, Offset: 0x146
// Size: 0x9
function private post_main()
{
    thread squad_utility_init();
}

// Namespace squad_utility
// Params 0
// Checksum 0xe2efaabb, Offset: 0x157
// Size: 0x56
function squad_utility_init()
{
    utility::registersharedfunc( #"squad_utility", #"getsquadmembers", &getsquadmembers );
    
    if ( utility::issharedfuncdefined( #"squad_utility", #"init" ) )
    {
        [[ utility::getsharedfunc( #"squad_utility", #"init" ) ]]();
    }
}

// Namespace squad_utility
// Params 2
// Checksum 0x5f5c8f04, Offset: 0x1b5
// Size: 0xac
function getsquadmembers( team, aliveonly )
{
    if ( !isdefined( team ) && !( isdefined( self ) && isdefined( self.team ) ) )
    {
        return [];
    }
    
    if ( utility::issharedfuncdefined( #"squad_utility", #"hash_ca8a81a3ee73b2f6" ) )
    {
        return [[ utility::getsharedfunc( #"squad_utility", #"hash_ca8a81a3ee73b2f6" ) ]]( team, aliveonly );
    }
    
    if ( isdefined( team ) )
    {
        propertystring = aliveonly ? "alivePlayers" : "players";
        teammates = teams::getteamdata( team, propertystring );
        
        if ( isdefined( teammates ) )
        {
            return teammates;
        }
    }
    
    return [];
}

// Namespace squad_utility
// Params 1
// Checksum 0x608d8c3, Offset: 0x26a
// Size: 0x161
function function_c0c042f61085310b( aliveonly )
{
    squadmates = getsquadmembers( self.team, aliveonly );
    var_4ae65e852a5402d9 = utility::callsharedfunc( #"pvp_contract", #"hash_9d96968e4defe402", self.team, self.sessionsquadid );
    
    if ( isarray( var_4ae65e852a5402d9 ) && var_4ae65e852a5402d9.size > 0 )
    {
        squadmates = arraycombineunique( var_4ae65e852a5402d9, squadmates );
    }
    
    if ( squadmates.size <= 1 )
    {
        return;
    }
    
    var_fbcdacbc86c740d4 = undefined;
    nearestdistsq = undefined;
    selforigin = self.origin;
    
    foreach ( mate in squadmates )
    {
        if ( mate == self )
        {
            continue;
        }
        
        if ( !mate.origin )
        {
            continue;
        }
        
        distsq = distancesquared( selforigin, mate.origin );
        
        if ( !var_fbcdacbc86c740d4 || distsq < nearestdistsq )
        {
            var_fbcdacbc86c740d4 = mate;
            nearestdistsq = distsq;
        }
    }
    
    return var_fbcdacbc86c740d4;
}

// Namespace squad_utility
// Params 2
// Checksum 0x656a6efb, Offset: 0x3d4
// Size: 0x174
function getsquadalivecount( team, squadindex )
{
    /#
        assert( isdefined( level.squaddata ) );
        assert( isdefined( level.squaddata[ team ] ), "<dev string:x24>" + team );
        assert( isdefined( level.squaddata[ team ][ squadindex ] ), "<dev string:x35>" + squadindex );
    #/
    
    if ( !( isdefined( team ) && isdefined( squadindex ) && isdefined( level.squaddata[ team ][ squadindex ].players ) ) )
    {
        return;
    }
    
    alivecount = 0;
    squadmembers = level.squaddata[ team ][ squadindex ].players;
    var_4ae65e852a5402d9 = utility::callsharedfunc( #"pvp_contract", #"hash_9d96968e4defe402", team, squadindex );
    
    if ( isarray( var_4ae65e852a5402d9 ) && var_4ae65e852a5402d9.size > 0 )
    {
        squadmembers = arraycombineunique( var_4ae65e852a5402d9, squadmembers );
    }
    
    foreach ( player in squadmembers )
    {
        if ( isalive( player ) )
        {
            alivecount++;
        }
    }
    
    return alivecount;
}

// Namespace squad_utility
// Params 0
// Checksum 0x2d1be4c, Offset: 0x551
// Size: 0xb
function getmaxsquadsize()
{
    return level.maxsquadsize;
}

// Namespace squad_utility
// Params 2
// Checksum 0x7668353c, Offset: 0x565
// Size: 0x4f
function getsquadleader( team, index )
{
    if ( !level.usesquadleader )
    {
        return;
    }
    
    if ( !isdefined( level.squaddata[ team ][ index ] ) )
    {
        return;
    }
    
    return level.squaddata[ team ][ index ].squadleader;
}

// Namespace squad_utility
// Params 0
// Checksum 0x25d0fff3, Offset: 0x5bd
// Size: 0x14b
function shouldmodesetsquads()
{
    if ( level.gametypebundle.issquadmode )
    {
        return 1;
    }
    
    if ( isbrgamemode() )
    {
        if ( utility::callsharedfunc( #"teamassim", #"isenabled" ) )
        {
            var_24a81510e3b3494f = utility::callsharedfunc( #"teamassim", #"getmaxassimilationteamsize" );
            return ( var_24a81510e3b3494f > 1 );
        }
        else
        {
            return issquadmode();
        }
    }
    
    switch ( level.gametype )
    {
        case #"hash_1e4846dca3ccf38":
        case #"hash_ca6516c10db2c95":
        case #"hash_25397d96e5bc8403":
        case #"hash_5ff8e011d5b9d1c8":
        case #"hash_7f9c384a34cc392f":
        case #"hash_8f01ce022684fbc8":
        case #"hash_9a6f07d0214a87db":
        case #"hash_a34aaabd92f0ff28":
        case #"hash_b7ddfbe1d0e2457a":
        case #"hash_b8aae84522ccf348":
        case #"hash_c065cef60f38490a":
        case #"hash_c4f97a56da3b7cde":
        case #"hash_c7f4420f385eeb3d":
        case #"hash_dcb9324af7bb9f35":
        case #"hash_fa2ae2f6bd652314":
            return issquadmode();
        default:
            return 0;
    }
}

// Namespace squad_utility
// Params 0
// Checksum 0x3efa4b7a, Offset: 0x710
// Size: 0x38
function function_1df8c3bebd512a8c()
{
    var_24738235084a4878 = 0;
    
    if ( level.gametypebundle.var_24738235084a4878 )
    {
        var_24738235084a4878 = 1;
    }
    
    return getdvarint( @"hash_8713d15c2f16358a", var_24738235084a4878 );
}

// Namespace squad_utility
// Params 0
// Checksum 0x996c7eb7, Offset: 0x751
// Size: 0xe, Type: bool
function issquadmode()
{
    return level.maxsquadsize > 1;
}

// Namespace squad_utility
// Params 2
// Checksum 0x95eb81df, Offset: 0x768
// Size: 0x99, Type: bool
function function_1cab5a91412434dd( team, index )
{
    if ( !isdefined( level.squaddata[ team ][ index ] ) )
    {
        return false;
    }
    
    squadsize = level.squaddata[ team ][ index ].players.size;
    var_4ae65e852a5402d9 = utility::callsharedfunc( #"pvp_contract", #"hash_9d96968e4defe402", team, index );
    
    if ( isarray( var_4ae65e852a5402d9 ) && var_4ae65e852a5402d9.size > 0 )
    {
        squadsize += var_4ae65e852a5402d9.size;
    }
    
    return squadsize == level.maxsquadsize;
}

// Namespace squad_utility
// Params 2
// Checksum 0xcb99a674, Offset: 0x80a
// Size: 0x3b
function function_6a77a8d0f8eb25b5( player1, player2 )
{
    var_32cdb742a2cc2c61 = player1 getsquadmembers( player1.team );
    return arraycontains( var_32cdb742a2cc2c61, player2 );
}

// Namespace squad_utility
// Params 1
// Checksum 0x7d6a5edc, Offset: 0x84e
// Size: 0xac
function getsquadsize( player )
{
    playerteam = player.team;
    playersquadindex = player.sessionsquadid;
    
    if ( !( isdefined( playerteam ) && isdefined( playersquadindex ) ) )
    {
        return 0;
    }
    
    squadmembers = level.squaddata[ playerteam ][ playersquadindex ].players;
    var_4ae65e852a5402d9 = utility::callsharedfunc( #"pvp_contract", #"hash_9d96968e4defe402", playerteam, playersquadindex );
    
    if ( isarray( var_4ae65e852a5402d9 ) && var_4ae65e852a5402d9.size > 0 )
    {
        squadmembers = arraycombineunique( var_4ae65e852a5402d9, squadmembers );
    }
    
    return squadmembers.size;
}

// Namespace squad_utility
// Params 0
// Checksum 0x4566bdc8, Offset: 0x903
// Size: 0x41
function function_9019b69d85af20ec()
{
    var_49cb24c8621b10cf = 0;
    
    if ( isdefined( level.gametypebundle ) )
    {
        var_49cb24c8621b10cf = istrue( level.gametypebundle.var_4b6819fa0e2f84d );
    }
    
    return getdvarint( @"scr_game_use_squad_ui", var_49cb24c8621b10cf );
}

// Namespace squad_utility
// Params 2
// Checksum 0xbf805206, Offset: 0x94d
// Size: 0x10b
function function_ed1cc36405244cd4( radius, ignore_self )
{
    assert( radius, "<dev string:x4c>" );
    nearby_squadmates = [];
    radius_sq = radius * radius;
    
    if ( isbrgamemode() )
    {
        team = self.team;
    }
    
    squadmates = getsquadmembers( team, 1 );
    
    foreach ( player in squadmates )
    {
        if ( ignore_self && player == self )
        {
            continue;
        }
        
        if ( distancesquared( self.origin, player.origin ) <= radius_sq )
        {
            nearby_squadmates[ nearby_squadmates.size ] = player;
        }
    }
    
    return nearby_squadmates;
}

