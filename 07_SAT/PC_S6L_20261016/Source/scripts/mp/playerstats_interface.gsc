// scripts\mp\playerstats_interface.gsc  (hash_28264b40cefbe224.gscc) (size: 4004 Bytes / 0xfa4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x37c1e0be (935452862)
// size ...... 4004 (0xfa4)
// includes .. 1   (offset: 0xf18)
// strings ... 6   (offset: 0xf20)
// dev strs .. 4   (offset: 0xf70)
// exports ... 19  (offset: 0x9ac)
// cseg ...... 0xab + 0x901 (0x9ac)
// imports ... 17  (offset: 0xca4)
// animtree1 . 0   (offset: 0xfa4)
// animtree2 . 0   (offset: 0xfa4)
#using scripts\mp\playerstats;

#namespace playerstats_interface;

// Namespace playerstats_interface
// Params 7
// Checksum 0x989226c1, Offset: 0xc9
// Size: 0xac
function setplayerstat( value, path1, path2, path3, path4, path5, gamemode )
{
    if ( !areplayerstatsenabled( gamemode ) )
    {
        return;
    }
    
    if ( isai( self ) )
    {
        return;
    }
    
    pathkey = playerstats::getplayerstatpathkey( path1, path2, path3, path4, path5 );
    
    if ( !playerstats::isstatwritable_internal( pathkey, gamemode ) )
    {
        return;
    }
    
    playerstats::setplayerstat_internal( value, pathkey, path1, path2, path3, path4, path5, gamemode );
    playerstats::writeplayerstat( value, path1, path2, path3, path4, path5, gamemode );
    playerstats::updateparentratiosbuffered( pathkey, gamemode );
}

// Namespace playerstats_interface
// Params 7
// Checksum 0xbb6b65e3, Offset: 0x17d
// Size: 0xa5
function setplayerstatbuffered( value, path1, path2, path3, path4, path5, gamemode )
{
    if ( !areplayerstatsenabled( gamemode ) )
    {
        return;
    }
    
    if ( isai( self ) )
    {
        return;
    }
    
    pathkey = playerstats::getplayerstatpathkey( path1, path2, path3, path4, path5 );
    
    if ( !playerstats::isstatwritable_internal( pathkey, gamemode ) )
    {
        return;
    }
    
    playerstats::setplayerstat_internal( value, pathkey, path1, path2, path3, path4, path5, gamemode );
    playerstats::flagstatforbufferedwrite( pathkey, gamemode );
    playerstats::updateparentratiosbuffered( pathkey, gamemode );
}

// Namespace playerstats_interface
// Params 7
// Checksum 0x8e25e380, Offset: 0x22a
// Size: 0xde
function addtoplayerstat( incrementamount, path1, path2, path3, path4, path5, gamemode )
{
    if ( !areplayerstatsenabled( gamemode ) )
    {
        return;
    }
    
    if ( isai( self ) )
    {
        return;
    }
    
    if ( game[ "practiceRound" ] )
    {
        return;
    }
    
    if ( !isdefined( incrementamount ) )
    {
        incrementamount = 1;
    }
    
    pathkey = playerstats::getplayerstatpathkey( path1, path2, path3, path4, path5 );
    
    if ( !playerstats::isstatwritable_internal( pathkey, gamemode ) )
    {
        return;
    }
    
    playerstats::addtoplayerstat_internal( incrementamount, pathkey, path1, path2, path3, path4, path5, gamemode );
    playerstats = function_e11e328ebfe147e( gamemode );
    playerstats::writeplayerstat( playerstats.values[ pathkey ], path1, path2, path3, path4, path5, gamemode );
    playerstats::updateparentratios( pathkey, gamemode );
}

// Namespace playerstats_interface
// Params 7
// Checksum 0x9118d693, Offset: 0x310
// Size: 0xae
function addtoplayerstatbuffered( incrementamount = 1, path1, path2, path3, path4, path5, gamemode )
{
    if ( !areplayerstatsenabled( gamemode ) )
    {
        return;
    }
    
    if ( isai( self ) )
    {
        return;
    }
    
    pathkey = playerstats::getplayerstatpathkey( path1, path2, path3, path4, path5 );
    
    if ( !playerstats::isstatwritable_internal( pathkey, gamemode ) )
    {
        return;
    }
    
    playerstats::addtoplayerstat_internal( incrementamount, pathkey, path1, path2, path3, path4, path5, gamemode );
    playerstats::flagstatforbufferedwrite( pathkey, gamemode );
    playerstats::updateparentratiosbuffered( pathkey, gamemode );
}

// Namespace playerstats_interface
// Params 6
// Checksum 0x70b368ed, Offset: 0x3c6
// Size: 0xc8
function getplayerstat( path1, path2, path3, path4, path5, gamemode )
{
    if ( !areplayerstatsenabled( gamemode ) )
    {
        return;
    }
    
    if ( isai( self ) )
    {
        return 0;
    }
    
    playerstats = function_e11e328ebfe147e( gamemode );
    
    if ( !isdefined( playerstats.values ) )
    {
        return;
    }
    
    pathkey = playerstats::getplayerstatpathkey( path1, path2, path3, path4, path5 );
    
    if ( !isdefined( playerstats.values[ pathkey ] ) )
    {
        playerstats.values[ pathkey ] = playerstats::readplayerstat( path1, path2, path3, path4, path5, gamemode );
    }
    
    return playerstats.values[ pathkey ];
}

// Namespace playerstats_interface
// Params 1
// Checksum 0xbb7cd236, Offset: 0x497
// Size: 0x1e
function areplayerstatsenabled( gamemode )
{
    return function_39efb33b2ce235b4( gamemode ).enabled;
}

// Namespace playerstats_interface
// Params 1
// Checksum 0xe38c9c2a, Offset: 0x4be
// Size: 0x20, Type: bool
function areplayerstatsreadonly( gamemode )
{
    return function_39efb33b2ce235b4( gamemode ).readonly > 0;
}

// Namespace playerstats_interface
// Params 1
// Checksum 0xbf7fb27a, Offset: 0x4e7
// Size: 0x2c
function makeallplayerstatsreadonly( gamemode )
{
    globals = function_39efb33b2ce235b4( gamemode );
    globals.readonly++;
}

// Namespace playerstats_interface
// Params 1
// Checksum 0x4cdf07b7, Offset: 0x51b
// Size: 0x46
function makeallplayerstatswritable( gamemode )
{
    globals = function_39efb33b2ce235b4( gamemode );
    assert( globals.readonly > 0, "<dev string:x24>" );
    globals.readonly--;
}

// Namespace playerstats_interface
// Params 6
// Checksum 0x353e956, Offset: 0x569
// Size: 0x5d
function makeplayerstatreadonly( path1, path2, path3, path4, path5, gamemode )
{
    pathkey = playerstats::getplayerstatpathkey( path1, path2, path3, path4, path5 );
    return playerstats::modifystatwritability( pathkey, 0, gamemode );
}

// Namespace playerstats_interface
// Params 6
// Checksum 0x388f2dba, Offset: 0x5cf
// Size: 0x5e
function makeplayerstatwritable( path1, path2, path3, path4, path5, gamemode )
{
    pathkey = playerstats::getplayerstatpathkey( path1, path2, path3, path4, path5 );
    return playerstats::modifystatwritability( pathkey, 1, gamemode );
}

// Namespace playerstats_interface
// Params 6
// Checksum 0xb24b2e38, Offset: 0x636
// Size: 0x5b
function isplayerstatwritable( path1, path2, path3, path4, path5, gamemode )
{
    pathkey = playerstats::getplayerstatpathkey( path1, path2, path3, path4, path5 );
    return playerstats::isstatwritable_internal( pathkey, gamemode );
}

// Namespace playerstats_interface
// Params 2
// Checksum 0xa66f2427, Offset: 0x69a
// Size: 0x5a
function makeplayerstatgroupreadonly( statgroup, gamemode )
{
    globals = function_39efb33b2ce235b4( gamemode );
    assert( isdefined( globals.statgroups[ statgroup ] ), "<dev string:x7d>" + statgroup + "<dev string:xb8>" );
    playerstats::modifystatgroupwritability( statgroup, 0, gamemode );
}

// Namespace playerstats_interface
// Params 2
// Checksum 0x9db3e0cb, Offset: 0x6fc
// Size: 0x5b
function makeplayerstatgroupwritable( statgroup, gamemode )
{
    globals = function_39efb33b2ce235b4( gamemode );
    assert( isdefined( globals.statgroups[ statgroup ] ), "<dev string:xba>" + statgroup + "<dev string:xb8>" );
    playerstats::modifystatgroupwritability( statgroup, 1, gamemode );
}

// Namespace playerstats_interface
// Params 4
// Checksum 0xe72e4ff6, Offset: 0x75f
// Size: 0x17a
function registerplayerstatratio( ratiopatharray, var_3a8b50e6561eba07, var_b317e339788a8f9b, gamemode )
{
    globals = function_39efb33b2ce235b4( gamemode );
    var_d0a91d680873d219 = playerstats::getplayerstatpathkey( ratiopatharray[ 0 ], ratiopatharray[ 1 ], ratiopatharray[ 2 ], ratiopatharray[ 3 ], ratiopatharray[ 4 ] );
    globals.ratios[ var_d0a91d680873d219 ] = [];
    globals.ratios[ var_d0a91d680873d219 ][ "numerator" ] = var_3a8b50e6561eba07;
    globals.ratios[ var_d0a91d680873d219 ][ "denominator" ] = var_b317e339788a8f9b;
    var_b69e0f4249c51ca5 = playerstats::getplayerstatpathkey( var_3a8b50e6561eba07[ 0 ], var_3a8b50e6561eba07[ 1 ], var_3a8b50e6561eba07[ 2 ], var_3a8b50e6561eba07[ 3 ], var_3a8b50e6561eba07[ 4 ] );
    var_7b232fad4818f991 = playerstats::getplayerstatpathkey( var_b317e339788a8f9b[ 0 ], var_b317e339788a8f9b[ 1 ], var_b317e339788a8f9b[ 2 ], var_b317e339788a8f9b[ 3 ], var_b317e339788a8f9b[ 4 ] );
    
    if ( !isdefined( globals.ratiochildren[ var_b69e0f4249c51ca5 ] ) )
    {
        globals.ratiochildren[ var_b69e0f4249c51ca5 ] = [ ratiopatharray ];
    }
    else
    {
        globals.ratiochildren[ var_b69e0f4249c51ca5 ][ globals.ratiochildren[ var_b69e0f4249c51ca5 ].size ] = ratiopatharray;
    }
    
    if ( !isdefined( globals.ratiochildren[ var_7b232fad4818f991 ] ) )
    {
        globals.ratiochildren[ var_7b232fad4818f991 ] = [ ratiopatharray ];
        return;
    }
    
    globals.ratiochildren[ var_7b232fad4818f991 ][ globals.ratiochildren[ var_7b232fad4818f991 ].size ] = ratiopatharray;
}

// Namespace playerstats_interface
// Params 1
// Checksum 0xf294f3fc, Offset: 0x8e1
// Size: 0x4a
function function_39efb33b2ce235b4( gamemode )
{
    if ( gamemode == "zm" )
    {
        return ( level.var_cc0c7bf608489ed8 ? level.zmPlayerStats : undefined );
    }
    
    return level.onlinestatsenabled ? level.playerstats : undefined;
}

// Namespace playerstats_interface
// Params 1
// Checksum 0x2eb484a6, Offset: 0x934
// Size: 0x4a
function function_e11e328ebfe147e( gamemode )
{
    if ( gamemode == "zm" )
    {
        return ( level.var_cc0c7bf608489ed8 ? self.zmPlayerStats : undefined );
    }
    
    return level.onlinestatsenabled ? self.playerstats : undefined;
}

// Namespace playerstats_interface
// Params 1
// Checksum 0xb875618f, Offset: 0x987
// Size: 0x24
function function_4b454cbef313e5f1( gamemode )
{
    return gamemode == "zm" ? "zmPlayerStats" : "playerStats";
}

