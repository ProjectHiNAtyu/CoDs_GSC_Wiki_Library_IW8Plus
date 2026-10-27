// scripts\mp\bounty.gsc  (hash_2205c1b16edb84f5.gscc) (size: 2628 Bytes / 0xa44 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdaaec254 (3668886100)
// size ...... 2628 (0xa44)
// includes .. 5   (offset: 0x9d8)
// strings ... 4   (offset: 0xa00)
// dev strs .. 1   (offset: 0xa34)
// exports ... 15  (offset: 0x4d0)
// cseg ...... 0xcc + 0x404 (0x4d0)
// imports ... 24  (offset: 0x728)
// animtree1 . 0   (offset: 0xa44)
// animtree2 . 0   (offset: 0xa44)
#using scripts\common\utility;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\join_team_aggregator;
#using scripts\mp\common\utility\points;
#using scripts\mp\hud_util;

#namespace bounty;

// Namespace bounty
// Params 0
// Checksum 0x2d5c755a, Offset: 0xea
// Size: 0x49
function init()
{
    level.bounty_index = [];
    level._effect[ "vfx_mo_money_cash_exp" ] = loadfxasset( "vfx_iw7_requests_mp_mo_money_cash_explo" );
    
    if ( true )
    {
        thread onplayerconnect();
        disconnect_event_aggregator::registerondisconnecteventcallback( &onplayerdisconnect );
        join_team_aggregator::registeronplayerjointeamcallback( &onplayerjoinedteam );
    }
}

// Namespace bounty
// Params 0
// Checksum 0xb6939376, Offset: 0x13b
// Size: 0x2c
function onplayerconnect()
{
    while ( true )
    {
        level waittill( #"connected", player );
        player bountyinit();
    }
}

// Namespace bounty
// Params 0
// Checksum 0xf8fd301f, Offset: 0x16f
// Size: 0x25
function bountyinit()
{
    if ( !isdefined( self.bountypoints ) )
    {
        playerregisterbountyindex();
        playerresetbountypoints();
        playerresetbountystreak();
    }
}

// Namespace bounty
// Params 1
// Checksum 0x1d50ebdb, Offset: 0x19c
// Size: 0x30
function onplayerdisconnect( player )
{
    if ( isdefined( player.bounty_index ) )
    {
        level.bounty_index[ player.bounty_index ] = undefined;
    }
}

// Namespace bounty
// Params 1
// Checksum 0x31d40cc3, Offset: 0x1d4
// Size: 0x32
function onplayerjoinedspectators( player )
{
    if ( true )
    {
        if ( isdefined( player.bounty_index ) )
        {
            player playerresetbountypoints();
            player playerresetbountystreak();
        }
    }
}

// Namespace bounty
// Params 1
// Checksum 0x78e6e880, Offset: 0x20e
// Size: 0x32
function onplayerjoinedteam( player )
{
    if ( true )
    {
        if ( isdefined( player.bounty_index ) )
        {
            player playerresetbountypoints();
            player playerresetbountystreak();
        }
    }
}

// Namespace bounty
// Params 0
// Checksum 0x30203e3d, Offset: 0x248
// Size: 0x3e
function playerregisterbountyindex()
{
    for ( index = 0; isdefined( level.bounty_index[ index ] ) ; index++ )
    {
    }
    
    level.bounty_index[ index ] = self;
    self.bounty_index = index;
}

// Namespace bounty
// Params 0
// Checksum 0x170645dd, Offset: 0x28e
// Size: 0x22
function playergetbountypoints()
{
    assert( isdefined( self.bountypoints ), "<dev string:x24>" );
    return self.bountypoints;
}

// Namespace bounty
// Params 1
// Checksum 0xb4192e9, Offset: 0x2b9
// Size: 0x65
function playersetbountypoints( bountypoints )
{
    assert( isdefined( self.bounty_index ), "<dev string:x24>" );
    
    if ( level.bounty_index[ self.bounty_index ] )
    {
        self.bountypoints = bountypoints;
        level.bounty_index[ self.bounty_index ] setbountycount( self.bountypoints );
    }
}

// Namespace bounty
// Params 1
// Checksum 0xfaf41572, Offset: 0x326
// Size: 0x33
function playerresetbountypoints( wait_time )
{
    self endon( #"disconnect" );
    
    if ( false )
    {
        return;
    }
    
    if ( isdefined( wait_time ) )
    {
        wait wait_time;
    }
    
    if ( isdefined( self ) )
    {
        playersetbountypoints( 0 );
    }
}

// Namespace bounty
// Params 1
// Checksum 0xc372354f, Offset: 0x361
// Size: 0x29
function playerresetbountystreak( wait_time )
{
    if ( false )
    {
        return;
    }
    
    if ( isdefined( wait_time ) )
    {
        wait wait_time;
    }
    
    if ( isdefined( self ) )
    {
        self.bountystreak = 0;
    }
}

// Namespace bounty
// Params 1
// Checksum 0xb185df47, Offset: 0x392
// Size: 0x4c
function bountyincreasestreak( amount )
{
    if ( false )
    {
        return;
    }
    
    if ( !isdefined( amount ) )
    {
        amount = 1;
    }
    
    if ( !isdefined( self.bountystreak ) )
    {
        self.bountystreak = 0;
    }
    
    self.bountystreak += amount;
    bountyconvert();
}

// Namespace bounty
// Params 0
// Checksum 0x6ae35c40, Offset: 0x3e6
// Size: 0x50
function bountyconvert()
{
    if ( false )
    {
        return;
    }
    
    old_bounty = playergetbountypoints();
    new_bounty = int( floor( self.bountystreak / 3 ) );
    
    if ( new_bounty > old_bounty && new_bounty <= 5 )
    {
        playersetbountypoints( new_bounty );
    }
}

// Namespace bounty
// Params 2
// Checksum 0x5d00b5a3, Offset: 0x43e
// Size: 0x92
function bountycollect( victim_bounty, victim_pos )
{
    if ( false )
    {
        return;
    }
    
    if ( isdefined( self.perks[ "specialty_bounty" ] ) )
    {
        if ( victim_bounty > 0 )
        {
            for ( i = 0; i < victim_bounty ; i++ )
            {
                thread points::doscoreevent( #"bounty" );
                bountyincreasestreak();
                playfx( utility::getfx( "vfx_mo_money_cash_exp" ), victim_pos + ( 0, 0, 45 ) );
            }
            
            thread hud_util::teamplayercardsplash( "callout_bounty_collected", self );
        }
    }
}

