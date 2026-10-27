// scripts\mp\cash.gsc  (hash_1e4284c6f878216d.gscc) (size: 1979 Bytes / 0x7bb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb3892929 (3012110633)
// size ...... 1979 (0x7bb)
// includes .. 2   (offset: 0x75b)
// strings ... 4   (offset: 0x76b)
// dev strs .. 0   (offset: 0x7bb)
// exports ... 4   (offset: 0x5c7)
// cseg ...... 0xae + 0x519 (0x5c7)
// imports ... 7   (offset: 0x667)
// animtree1 . 0   (offset: 0x7bb)
// animtree2 . 0   (offset: 0x7bb)
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\utility\game_utility;

#namespace cash;

// Namespace cash
// Params 1
// Checksum 0x11398556, Offset: 0xcc
// Size: 0x1a3
function playersetplunderomnvar( value )
{
    assert( isdefined( value ) );
    
    if ( !isdefined( value ) )
    {
        return;
    }
    
    squadmemberindex = self.sessionuimemberindex;
    
    if ( !( isdefined( squadmemberindex ) && isdefined( self.team ) ) || self.isdisconnecting || squadmemberindex < 0 || squadmemberindex >= level.maxsquadsize )
    {
        return;
    }
    
    if ( game_utility::function_a43ada404e8c591f() )
    {
        self setclientomnvar( "ui_cash_squad_index_" + squadmemberindex, value );
    }
    else
    {
        squadmates = level.teamdata[ self.team ][ "players" ];
        
        if ( isdefined( level.squaddata[ self.team ][ self.sessionsquadid ] ) )
        {
            squadmates = level.squaddata[ self.team ][ self.sessionsquadid ].players;
        }
        
        foreach ( player in squadmates )
        {
            if ( isdefined( player ) )
            {
                player setclientomnvar( "ui_cash_squad_index_" + squadmemberindex, value );
            }
        }
    }
    
    if ( level.codcasterenabled && !self iscodcaster() )
    {
        codcasterclientmatchdata::function_ee35d29284860183( 19, value );
    }
    
    self setclientomnvar( "ui_cash_my_player", value );
}

// Namespace cash
// Params 2
// Checksum 0x6ba7dba0, Offset: 0x277
// Size: 0x1cf
function function_eb5a5549b0c6ecde( value, var_8cc12de13686f4e7 = 0 )
{
    assert( isdefined( value ) );
    
    if ( !isdefined( value ) )
    {
        return;
    }
    
    if ( !var_8cc12de13686f4e7 && isdefined( self.var_3b6b25040b264bd0 ) && self.var_3b6b25040b264bd0 == value )
    {
        return;
    }
    
    squadmemberindex = self.sessionuimemberindex;
    
    if ( !( isdefined( squadmemberindex ) && isdefined( self.team ) ) || self.isdisconnecting )
    {
        return;
    }
    
    if ( squadmemberindex >= level.var_b781dca6a607a0d )
    {
        return;
    }
    
    if ( !isdefined( level.var_b781dca6a607a0d ) && squadmemberindex >= level.maxsquadsize )
    {
        return;
    }
    
    if ( squadmemberindex < 0 )
    {
        return;
    }
    
    if ( game_utility::function_a43ada404e8c591f() )
    {
        self setclientomnvar( "ui_zm_essence_squad_index_" + squadmemberindex, value );
    }
    else
    {
        squadmates = level.teamdata[ self.team ][ "players" ];
        
        if ( isdefined( level.squaddata[ self.team ][ self.sessionsquadid ] ) )
        {
            squadmates = level.squaddata[ self.team ][ self.sessionsquadid ].players;
        }
        
        foreach ( player in squadmates )
        {
            player setclientomnvar( "ui_zm_essence_squad_index_" + squadmemberindex, value );
        }
    }
    
    self.var_3b6b25040b264bd0 = value;
}

// Namespace cash
// Params 0
// Checksum 0x6a371834, Offset: 0x44e
// Size: 0x179
function function_3909082084ad6974()
{
    if ( !isdefined( self.plundercount ) )
    {
        self.plundercount = 0;
    }
    
    if ( isdefined( self.team ) && !game_utility::function_a43ada404e8c591f() )
    {
        squadmates = level.teamdata[ self.team ][ "players" ];
        
        if ( isdefined( level.squaddata[ self.team ][ self.sessionsquadid ] ) )
        {
            squadmates = level.squaddata[ self.team ][ self.sessionsquadid ].players;
        }
        
        foreach ( player in squadmates )
        {
            squadmemberindex = player.sessionuimemberindex;
            
            if ( self != player && isdefined( squadmemberindex ) )
            {
                value = player getclientomnvar( "ui_cash_squad_index_" + squadmemberindex );
                self setclientomnvar( "ui_cash_squad_index_" + squadmemberindex, value );
                essencevalue = player getclientomnvar( "ui_zm_essence_squad_index_" + squadmemberindex );
                self setclientomnvar( "ui_zm_essence_squad_index_" + squadmemberindex, essencevalue );
            }
        }
    }
}

