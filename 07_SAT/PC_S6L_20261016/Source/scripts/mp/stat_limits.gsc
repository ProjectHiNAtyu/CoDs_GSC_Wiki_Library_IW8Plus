// scripts\mp\stat_limits.gsc  (hash_0bebae958191bdf3.gscc) (size: 1137 Bytes / 0x471 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa9c4f299 (2848256665)
// size ...... 1137 (0x471)
// includes .. 1   (offset: 0x431)
// strings ... 4   (offset: 0x439)
// dev strs .. 0   (offset: 0x471)
// exports ... 5   (offset: 0x2b5)
// cseg ...... 0x86 + 0x22f (0x2b5)
// imports ... 6   (offset: 0x37d)
// animtree1 . 0   (offset: 0x471)
// animtree2 . 0   (offset: 0x471)
#using scripts\common\callbacks;

#namespace stat_limits;

// Namespace stat_limits
// Params 0
// Checksum 0xd6aed284, Offset: 0xa4
// Size: 0xbf
function init()
{
    level.statLimits = [];
    disabled = getdvarint( @"hash_52a5dffcb887f372", 0 ) != 0;
    level.statLimits[ #"hash_354a8bd48a879532" ] = disabled ? 0 : getmatchrulesdata( "statLimits", "rankXP" );
    level.statLimits[ #"limitkills" ] = disabled ? 0 : getmatchrulesdata( "statLimits", "kills" );
    level.statLimits[ #"limitheadshots" ] = disabled ? 0 : getmatchrulesdata( "statLimits", "headshots" );
    level callback::add( #"player_connect", &onplayerconnect );
}

// Namespace stat_limits
// Params 1
// Checksum 0x40e5047e, Offset: 0x16b
// Size: 0x8d
function onplayerconnect( params )
{
    if ( !isdefined( self.pers[ #"hash_354a8bd48a879532" ] ) )
    {
        self.pers[ #"hash_354a8bd48a879532" ] = 0;
    }
    
    if ( !isdefined( self.pers[ #"limitkills" ] ) )
    {
        self.pers[ #"limitkills" ] = 0;
    }
    
    if ( !isdefined( self.pers[ #"limitheadshots" ] ) )
    {
        self.pers[ #"limitheadshots" ] = 0;
    }
}

// Namespace stat_limits
// Params 2
// Checksum 0xc8da5e37, Offset: 0x200
// Size: 0x50
function limitvalue( stat, value )
{
    assert( isdefined( level.statLimits[ stat ] ) );
    
    if ( level.statLimits[ stat ] == 0 )
    {
        return value;
    }
    
    return min( value, level.statLimits[ stat ] );
}

// Namespace stat_limits
// Params 1
// Checksum 0xf064471a, Offset: 0x259
// Size: 0x5b, Type: bool
function function_608486f90656f2f7( stat )
{
    assert( isdefined( level.statLimits[ stat ] ) );
    
    if ( level.statLimits[ stat ] == 0 )
    {
        return false;
    }
    
    value = self.pers[ stat ];
    return level.statLimits[ stat ] < value;
}

