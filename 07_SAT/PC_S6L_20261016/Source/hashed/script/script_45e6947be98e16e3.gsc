// script_45e6947be98e16e3  (hash_45e6947be98e16e3.gscc) (size: 13370 Bytes / 0x343a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x41979fa0 (1100455840)
// size ...... 13370 (0x343a)
// includes .. 13  (offset: 0x3306)
// strings ... 17  (offset: 0x336e)
// dev strs .. 0   (offset: 0x343a)
// exports ... 75  (offset: 0x1fae)
// cseg ...... 0x1da + 0x1dd4 (0x1fae)
// imports ... 61  (offset: 0x2b66)
// animtree1 . 0   (offset: 0x343a)
// animtree2 . 0   (offset: 0x343a)
#using script_782ed84671b152fb;
#using scripts\common\utility;
#using scripts\mp\armor;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\common\utility\teams;
#using scripts\mp\ftue\utility\ftue_cash;
#using scripts\mp\ftue\utility\ftue_loadout;
#using scripts\mp\ftue\utility\ftue_movement;
#using scripts\mp\ftue\utility\ftue_objectives;
#using scripts\mp\ftue\utility\ftue_player;
#using scripts\mp\ftue\utility\ftue_vehicles;
#using scripts\mp\gamelogic;

#namespace namespace_727c07157c884ff5;

// Namespace namespace_727c07157c884ff5
// Params 0
// Checksum 0xc268c92b, Offset: 0x1f8
// Size: 0x182
function init()
{
    level.var_11133cb0607b498f = level.var_11133cb0607b498f ?? {};
    level.var_11133cb0607b498f.var_676d11a91d9e3069 = [];
    level.var_11133cb0607b498f.var_676d11a91d9e3069[ "isOnGround" ] = &function_bbfa84d08a937f5;
    level.var_11133cb0607b498f.var_676d11a91d9e3069[ "isPlayerSafeAnywhere" ] = &function_6471b7a984eb7e87;
    level.var_11133cb0607b498f.var_676d11a91d9e3069[ "playerGotArmorPlates" ] = &playerGotArmorPlates;
    level.var_11133cb0607b498f.var_676d11a91d9e3069[ "validateCondDataIsTrue" ] = &validateCondDataIsTrue;
    level.var_11133cb0607b498f.var_676d11a91d9e3069[ "validateCondDataValue" ] = &validateCondDataValue;
    level.var_11133cb0607b498f.var_676d11a91d9e3069[ "validateCircleIndex" ] = &validateCircleIndex;
    level.var_11133cb0607b498f.var_676d11a91d9e3069[ "trackLuiNotifyServerMessage" ] = &trackLuiNotifyServerMessage;
    level.var_11133cb0607b498f.var_676d11a91d9e3069[ "IsLootNearPlayer" ] = &IsLootNearPlayer;
    level.var_11133cb0607b498f.var_676d11a91d9e3069[ "hasTeammateEliminated" ] = &hasTeammateEliminated;
    level.var_11133cb0607b498f.var_676d11a91d9e3069[ "hasEnoughMoney" ] = &hasEnoughMoney;
    level.var_11133cb0607b498f.var_676d11a91d9e3069[ "isPlayerFreeFalling" ] = &isPlayerFreeFalling;
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0x28fcad18, Offset: 0x382
// Size: 0x3c, Type: bool
function validateCondDataIsTrue( params )
{
    tipsdata = namespace_70ebaadbdb24c64d::function_cc2f74a7cb8daa12( params.tipskey );
    return tipsdata && tipsdata[ params.datakey ];
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0xaebbaefe, Offset: 0x3c7
// Size: 0x66
function validateCondDataValue( params )
{
    tipsdata = namespace_70ebaadbdb24c64d::function_cc2f74a7cb8daa12( params.tipskey );
    result = tipsdata && isdefined( tipsdata[ params.datakey ] ) && tipsdata[ params.datakey ] == params.var_9b3000a2f37ff90f;
    return result;
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0x1f257772, Offset: 0x436
// Size: 0x14, Type: bool
function playerGotArmorPlates( params )
{
    return armor::function_22290101992e4874() > 0;
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0x472629f6, Offset: 0x453
// Size: 0x2b, Type: bool
function validateCircleIndex( params )
{
    return level.br_circle.circleindex == params.var_9b3000a2f37ff90f;
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0xf63cc3c2, Offset: 0x487
// Size: 0x61
function trackLuiNotifyServerMessage( params )
{
    tipsdata = namespace_70ebaadbdb24c64d::function_cc2f74a7cb8daa12( params.tipskey );
    var_7783c2a7ef3bc71d = tipsdata[ params.datakey ];
    
    if ( !isdefined( var_7783c2a7ef3bc71d ) )
    {
        tipsdata[ params.datakey ] = 0;
        thread function_14731f7b24eae3ce( params );
    }
    
    return var_7783c2a7ef3bc71d;
}

// Namespace namespace_727c07157c884ff5
// Params 1, eflags: 0x4
// Checksum 0xe2e345b8, Offset: 0x4f1
// Size: 0x9a
function private function_14731f7b24eae3ce( params )
{
    self endon( #"disconnect" );
    level endon( #"game_end" );
    assert( isdefined( self ) );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", message, value );
        datakey = params.datakey;
        
        if ( message == datakey )
        {
            tipsdata = namespace_70ebaadbdb24c64d::function_cc2f74a7cb8daa12( params.tipskey );
            tipsdata[ datakey ] = 1;
            break;
        }
    }
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0x34cc0639, Offset: 0x593
// Size: 0xbe, Type: bool
function IsLootNearPlayer( params )
{
    foreach ( var_2c67cce493677bbe in params.var_dec8a38453275dcb )
    {
        var_9b63abffb10d8f58 = getlootscriptablearrayinradius( var_2c67cce493677bbe.loot, undefined, self.origin, params.var_9b3000a2f37ff90f );
        
        if ( var_9b63abffb10d8f58 && var_9b63abffb10d8f58.size > 0 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0x72aeb46f, Offset: 0x65a
// Size: 0xaf
function hasTeammateEliminated( params )
{
    if ( !self.team )
    {
        return;
    }
    
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        if ( player != self && player.br_iseliminated )
        {
            return 1;
        }
    }
    
    return 0;
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0x7564f52b, Offset: 0x712
// Size: 0x24, Type: bool
function hasEnoughMoney( params )
{
    return self.plundercount * 10 >= params.var_9b3000a2f37ff90f;
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0x174c2e86, Offset: 0x73f
// Size: 0x4a, Type: bool
function function_76035c8e0ac4b5f0( params )
{
    assert( isdefined( params ) );
    assert( isdefined( params.circleindex ) );
    return level.br_circle.circleindex >= params.circleindex;
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0x4b614521, Offset: 0x792
// Size: 0x65, Type: bool
function function_b1c7685ac37709ee( params )
{
    assert( isdefined( params ) );
    assert( isdefined( params.var_cb5bf8ec0dfc02a7 ) );
    dangercircleradius = level.br_circle.dangercircleent.origin[ 2 ];
    return dangercircleradius > params.var_cb5bf8ec0dfc02a7;
}

// Namespace namespace_727c07157c884ff5
// Params 0
// Checksum 0x7ade055d, Offset: 0x800
// Size: 0x8d, Type: bool
function function_616b36694e0a4d5()
{
    if ( function_88f70b445cbda9b1() )
    {
        foreach ( ally in self.nearbyallies )
        {
            if ( ally.inlaststand )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace namespace_727c07157c884ff5
// Params 0
// Checksum 0x1a0f6841, Offset: 0x896
// Size: 0x8d, Type: bool
function function_c04cf3b0a1df4691()
{
    if ( function_98154fcb15750955() )
    {
        foreach ( enemy in self.nearbyenemies )
        {
            if ( enemy.inlaststand )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0xb2d8a2db, Offset: 0x92c
// Size: 0x87, Type: bool
function function_ab3300532cd9a40f( dist )
{
    if ( br_gametypes::isfeaturedisabled( #"kiosk" ) || !isdefined( level.common_armory_kiosk.instances ) )
    {
        return false;
    }
    
    buystation = function_47c86977a18df38b( level.common_armory_kiosk.instances, self.origin, dist );
    
    if ( isdefined( buystation ) )
    {
        self.var_11133cb0607b498f.currentbuystation = buystation;
        return true;
    }
    
    return false;
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0x4f5ad338, Offset: 0x9bc
// Size: 0x3c, Type: bool
function function_4e28a5536a8acba2( params )
{
    assert( isdefined( params ) );
    assert( isdefined( params.var_dd6175144d8931a8 ) );
    return function_ab3300532cd9a40f( params.var_dd6175144d8931a8 );
}

// Namespace namespace_727c07157c884ff5
// Params 0
// Checksum 0xddde6d3a, Offset: 0xa01
// Size: 0xc8, Type: bool
function function_282b0d131dd79a82()
{
    self.var_11133cb0607b498f.grounddrops = ftue_loadout::function_70e44dcf20375ded();
    
    foreach ( grounddrops in self.var_11133cb0607b498f.grounddrops )
    {
        if ( isdefined( grounddrops ) && isdefined( grounddrops.team ) && grounddrops.team == self.team )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0xcb81a3f5, Offset: 0xad2
// Size: 0x12d, Type: bool
function function_3fd61caeed3a4449( params )
{
    assert( isdefined( params ) );
    assert( isdefined( params.var_a2ee575af77bbb3e ) );
    
    if ( self.var_11133cb0607b498f.grounddrops.size > 0 )
    {
        foreach ( loadoutdrop in self.var_11133cb0607b498f.grounddrops )
        {
            if ( isdefined( loadoutdrop ) && isdefined( loadoutdrop.team ) )
            {
                if ( loadoutdrop.team == self.team && distance( loadoutdrop.origin, self.origin ) <= params.var_a2ee575af77bbb3e )
                {
                    self.var_11133cb0607b498f.currentloadoutdrop = loadoutdrop;
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0xbd1673a8, Offset: 0xc08
// Size: 0x100
function function_40e1fe3b16a91e72( radius )
{
    grounddrops = ftue_loadout::function_70e44dcf20375ded();
    
    if ( !isdefined( grounddrops ) )
    {
        return;
    }
    
    var_20ed50e6d49184f = sortbydistancecullbyradius( grounddrops, self.origin, radius );
    
    foreach ( grounddrop in var_20ed50e6d49184f )
    {
        if ( isdefined( grounddrop.team ) && grounddrop.team == self.team )
        {
            self.var_11133cb0607b498f.grounddrops = grounddrops;
            self.var_11133cb0607b498f.currentloadoutdrop = grounddrop;
            return 1;
        }
    }
    
    return 0;
}

// Namespace namespace_727c07157c884ff5
// Params 0
// Checksum 0x450e8907, Offset: 0xd11
// Size: 0x16, Type: bool
function function_a148a17f534520ff()
{
    return isdefined( self.var_11133cb0607b498f.currentloadoutdrop );
}

// Namespace namespace_727c07157c884ff5
// Params 0
// Checksum 0x38633c69, Offset: 0xd30
// Size: 0x7
function function_eeb08902e747d826()
{
    return self isshooting();
}

// Namespace namespace_727c07157c884ff5
// Params 0
// Checksum 0xa05d989f, Offset: 0xd40
// Size: 0x9, Type: bool
function function_8ed7e782cd39eee9()
{
    return !function_eeb08902e747d826();
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0x85ad2b09, Offset: 0xd52
// Size: 0x62, Type: bool
function condisingulag( params )
{
    expectedvalue = 1;
    
    if ( isdefined( params ) && isdefined( params.expectedvalue ) )
    {
        expectedvalue = params.expectedvalue;
    }
    
    return expectedvalue == self.var_11133cb0607b498f.eventscondition[ "GulagStarted" ].isactive;
}

// Namespace namespace_727c07157c884ff5
// Params 0
// Checksum 0x81d8142d, Offset: 0xdbd
// Size: 0x25
function function_e11070f8c39b516()
{
    return self.var_11133cb0607b498f.eventscondition[ "PlayerShotByEnemy" ].isactive;
}

// Namespace namespace_727c07157c884ff5
// Params 0
// Checksum 0x94b3331c, Offset: 0xdeb
// Size: 0x9, Type: bool
function function_4a9574cdba75b5d3()
{
    return !function_e11070f8c39b516();
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0x28d71781, Offset: 0xdfd
// Size: 0x30, Type: bool
function function_6471b7a984eb7e87( params )
{
    return !function_98154fcb15750955() && function_8ed7e782cd39eee9() && ftue_player::function_b940805bdd38cde7() && isalive( self );
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0x3b706ebe, Offset: 0xe36
// Size: 0x31, Type: bool
function function_da24926f47408f3a( params )
{
    expectedvalue = params.expectedvalue ?? 1;
    return expectedvalue == function_6471b7a984eb7e87();
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0x76d0d1c2, Offset: 0xe70
// Size: 0x3b, Type: bool
function function_d6346b47316cfeca( params )
{
    expectedvalue = params.expectedvalue ?? 1;
    return expectedvalue == ( function_6471b7a984eb7e87() && ftue_movement::function_b637614feabc055f() );
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0x55486c4b, Offset: 0xeb4
// Size: 0x34, Type: bool
function function_748dffc202f20964( params )
{
    expectedvalue = params.expectedvalue ?? 1;
    return self.var_748dffc202f20964 == expectedvalue;
}

// Namespace namespace_727c07157c884ff5
// Params 0
// Checksum 0x636c2f66, Offset: 0xef1
// Size: 0x3, Type: bool
function function_affdbc5a1801e01c()
{
    return false;
}

// Namespace namespace_727c07157c884ff5
// Params 0
// Checksum 0x46e79016, Offset: 0xefd
// Size: 0x1f, Type: bool
function function_b80a8768d6ae141a()
{
    if ( self isspectatinganyone() && self getclientomnvar( "ui_requestRedeployButton_state" ) > 1 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_727c07157c884ff5
// Params 0
// Checksum 0x7dd354, Offset: 0xf25
// Size: 0x49, Type: bool
function function_f23b3081cd0fcfe0()
{
    if ( isdefined( self.var_11133cb0607b498f.var_ce53c4bce083d394.var_5043a2d01e658cc0 ) )
    {
        if ( self.var_11133cb0607b498f.var_ce53c4bce083d394.var_5043a2d01e658cc0 )
        {
            return true;
        }
        
        return false;
    }
    
    return false;
}

// Namespace namespace_727c07157c884ff5
// Params 0
// Checksum 0x77717363, Offset: 0xf77
// Size: 0x3d, Type: bool
function function_98154fcb15750955()
{
    nearbyenemies = getentitiesinradiusfrompartitiongrid( self.origin, 1000, createentitytypemask( [ "etype_player" ] ), [ self ] );
    return nearbyenemies && nearbyenemies.size > 0;
}

// Namespace namespace_727c07157c884ff5
// Params 0
// Checksum 0x50ffefa8, Offset: 0xfbd
// Size: 0x1d, Type: bool
function function_594e989d11db31e4()
{
    if ( isdefined( self.var_bc5a0f9e5ec20e4e ) )
    {
        return ( self.var_bc5a0f9e5ec20e4e.size > 0 );
    }
    
    return false;
}

// Namespace namespace_727c07157c884ff5
// Params 0
// Checksum 0x8330a7b9, Offset: 0xfe3
// Size: 0x1d, Type: bool
function function_88f70b445cbda9b1()
{
    if ( isdefined( self.nearbyallies ) )
    {
        return ( self.nearbyallies.size > 0 );
    }
    
    return false;
}

// Namespace namespace_727c07157c884ff5
// Params 0
// Checksum 0x8609f49a, Offset: 0x1009
// Size: 0x92, Type: bool
function function_f7e0f9f348708385()
{
    if ( !function_98154fcb15750955() )
    {
        return false;
    }
    
    foreach ( currentenemy in self.nearbyenemies )
    {
        if ( isdefined( currentenemy ) && currentenemy isshooting() )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_727c07157c884ff5
// Params 0
// Checksum 0xaf77772b, Offset: 0x10a4
// Size: 0x3, Type: bool
function function_969703618e87966b()
{
    return false;
}

// Namespace namespace_727c07157c884ff5
// Params 0
// Checksum 0xcc4d64a, Offset: 0x10b0
// Size: 0xac, Type: bool
function function_d1566269fe60d9a0()
{
    if ( !function_98154fcb15750955() )
    {
        return false;
    }
    
    foreach ( currentenemy in self.nearbyenemies )
    {
        if ( !isalive( currentenemy ) )
        {
            self.var_11133cb0607b498f.var_ce53c4bce083d394.killedenemy = currentenemy;
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_727c07157c884ff5
// Params 0
// Checksum 0x9a25bd31, Offset: 0x1165
// Size: 0x26, Type: bool
function function_eb67b51ce22d2d0c()
{
    if ( self.var_11133cb0607b498f.var_bdcc1fed73c1b7fb.cashpicked )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0x7c43be30, Offset: 0x1194
// Size: 0x129, Type: bool
function function_5b93b34229d4622a( params )
{
    assert( isdefined( params ) );
    assert( isdefined( params.mindistance ) );
    assert( isdefined( params.maxdistance ) );
    mindistance = params.mindistance;
    maxdistance = params.maxdistance;
    
    for ( i = 0; i < level.var_a0091bd8bb5fd717.var_c6b2d55070c7f917.size ; i++ )
    {
        cashlist = getlootscriptablearrayinradius( level.var_a0091bd8bb5fd717.var_c6b2d55070c7f917[ i ], undefined, self.origin, maxdistance );
        
        if ( cashlist.size >= 1 )
        {
            cash = cashlist[ 0 ];
            dist = distance2d( cash.origin, self.origin );
            
            if ( dist >= mindistance )
            {
                self.var_11133cb0607b498f.var_bdcc1fed73c1b7fb.closedcash = cash;
                return true;
            }
        }
    }
    
    return false;
}

// Namespace namespace_727c07157c884ff5
// Params 0
// Checksum 0x7c6701c6, Offset: 0x12c6
// Size: 0x22
function function_d3d4cff7c7087f39()
{
    self.var_11133cb0607b498f.var_bdcc1fed73c1b7fb.var_70cd990462dd48a6 = 1;
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0x1ad3e04, Offset: 0x12f0
// Size: 0x5a, Type: bool
function function_e39a9c2b02f9a535( params )
{
    assert( isdefined( params ) );
    assert( isdefined( params.expectedvalue ) );
    return params.expectedvalue == ftue_cash::function_8fb1f467dcab16c9( self.var_11133cb0607b498f.var_bdcc1fed73c1b7fb.closedcash );
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0x1fd1d194, Offset: 0x1353
// Size: 0x76
function function_c78b9b134e8f22cf( params )
{
    assert( isdefined( params ) );
    assert( isdefined( params.var_559bb6b61fbe6ea2 ) );
    return function_e31421c7f6bbe724( self.var_11133cb0607b498f.var_ce53c4bce083d394.waypointposition, params.var_559bb6b61fbe6ea2, self.var_11133cb0607b498f.var_ce53c4bce083d394.waypointposition );
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0x7973ca70, Offset: 0x13d2
// Size: 0x76
function function_7a60602f93e27687( params )
{
    assert( isdefined( params ) );
    assert( isdefined( params.var_559bb6b61fbe6ea2 ) );
    return function_c3c67edfef45b7f4( self.var_11133cb0607b498f.var_ce53c4bce083d394.waypointposition, params.var_559bb6b61fbe6ea2, self.var_11133cb0607b498f.var_ce53c4bce083d394.waypointposition );
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0xeecb4021, Offset: 0x1451
// Size: 0x76
function function_fae015843b69fbe8( params )
{
    assert( isdefined( params ) );
    assert( isdefined( params.var_9e53da5ccf535707 ) );
    return function_e31421c7f6bbe724( self.var_11133cb0607b498f.var_bdcc1fed73c1b7fb.waypointposition, params.var_9e53da5ccf535707, self.var_11133cb0607b498f.var_bdcc1fed73c1b7fb.waypoint );
}

// Namespace namespace_727c07157c884ff5
// Params 0
// Checksum 0xb665817d, Offset: 0x14d0
// Size: 0x24, Type: bool
function function_22bfa02c238151de()
{
    return !isalive( self.var_11133cb0607b498f.var_15a355a64b7c4cbb.allydown );
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0xfcfae607, Offset: 0x14fd
// Size: 0x8a
function function_80920d1b7209ee97( allies )
{
    if ( !isdefined( allies ) )
    {
        return;
    }
    
    foreach ( ally in allies )
    {
        if ( !isalive( ally ) )
        {
            return ally;
        }
    }
}

// Namespace namespace_727c07157c884ff5
// Params 0
// Checksum 0x9eb124ba, Offset: 0x1590
// Size: 0x11
function function_217acc5fadb2a0aa()
{
    return function_80920d1b7209ee97( self.allallies );
}

// Namespace namespace_727c07157c884ff5
// Params 0
// Checksum 0x22606fc6, Offset: 0x15aa
// Size: 0x11
function function_98bb6e823ac946d1()
{
    return function_80920d1b7209ee97( self.nearbyallies );
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0x3b482d2e, Offset: 0x15c4
// Size: 0x10e
function function_962a6f44d52089f6( params )
{
    assert( isdefined( params ) );
    assert( isdefined( params.var_422ac04238675000 ) );
    var_9ec2e30b282c56b9 = self.allallies;
    
    if ( params.var_24242c77316ee796 )
    {
        var_9ec2e30b282c56b9 = self.nearbyallies;
    }
    
    if ( !isdefined( var_9ec2e30b282c56b9 ) )
    {
        return 0;
    }
    
    var_422ac04238675000 = params.var_422ac04238675000;
    
    foreach ( ally in var_9ec2e30b282c56b9 )
    {
        if ( !isalive( ally ) )
        {
            self.var_11133cb0607b498f.deadally = ally;
            return var_422ac04238675000;
        }
        
        if ( !var_422ac04238675000 )
        {
            return 1;
        }
    }
    
    return 0;
}

// Namespace namespace_727c07157c884ff5
// Params 0
// Checksum 0x1057962a, Offset: 0x16db
// Size: 0x3b, Type: bool
function function_aedb892a1c78e040()
{
    if ( isdefined( self.var_11133cb0607b498f.deadally ) && ftue_player::function_de7cca2ef9bc611c( self, self.var_11133cb0607b498f.deadally ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_727c07157c884ff5
// Params 0
// Checksum 0x1e3af7d6, Offset: 0x171f
// Size: 0xd2, Type: bool
function function_11ef24d0e4aaf282()
{
    wait 1;
    var_ca00d6ab058c8873 = self getcurrentprimaryweapon();
    
    foreach ( notweapon in self.var_11133cb0607b498f.var_cf82970e3c0a2bc6.notweapons )
    {
        if ( var_ca00d6ab058c8873.basename == notweapon )
        {
            return false;
        }
    }
    
    if ( self.var_11133cb0607b498f.var_cf82970e3c0a2bc6.firstweapon != var_ca00d6ab058c8873 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0x7c6662e5, Offset: 0x17fa
// Size: 0x51, Type: bool
function function_78bec54d64c6d014( params )
{
    assert( isdefined( params ) );
    assert( isdefined( params.var_9d3132c8ba63a719 ) );
    
    if ( self.var_11133cb0607b498f.var_cdf8f9cd67258dc >= params.var_9d3132c8ba63a719 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0xc68502db, Offset: 0x1854
// Size: 0x4c, Type: bool
function function_9909c3350df0537c( params )
{
    assert( isdefined( params ) );
    assert( isdefined( params.var_3c253437b2ab5284 ) );
    
    if ( function_88f70b445cbda9b1() )
    {
        return ( self.nearbyallies.size == params.var_3c253437b2ab5284 );
    }
    
    return false;
}

// Namespace namespace_727c07157c884ff5
// Params 0
// Checksum 0x9f314c42, Offset: 0x18a9
// Size: 0x8b, Type: bool
function function_4641037497231bce()
{
    if ( function_88f70b445cbda9b1() )
    {
        foreach ( ally in self.nearbyallies )
        {
            if ( !ally isonground() )
            {
                return false;
            }
        }
        
        return true;
    }
    
    return false;
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0x667ba06a, Offset: 0x193d
// Size: 0x11
function function_bbfa84d08a937f5( params )
{
    return self isonground();
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0x2ee45e55, Offset: 0x1957
// Size: 0x11
function isPlayerFreeFalling( params )
{
    return self isinfreefall();
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0x9222bae1, Offset: 0x1971
// Size: 0x43
function condisplayerinvehicle( params )
{
    returnvalue = self isvehicleactive();
    
    if ( isdefined( params ) && isdefined( params.expectedvalue ) )
    {
        return ( params.expectedvalue == returnvalue );
    }
    
    return returnvalue;
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0x52b63e35, Offset: 0x19bd
// Size: 0x58
function function_ae55d906f194f6b2( params )
{
    returnvalue = self isvehicleactive() && self == ftue_vehicles::function_441683b10aa68b57( self.vehicle );
    
    if ( isdefined( params ) && isdefined( params.expectedvalue ) )
    {
        return ( params.expectedvalue == returnvalue );
    }
    
    return returnvalue;
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0x94d86dc0, Offset: 0x1a1e
// Size: 0x86, Type: bool
function function_a37c618069078107( params )
{
    if ( isdefined( self.var_11133cb0607b498f.var_5b3ecb2a43070915.var_8a09422cea9dd0a5.itemsdropped ) )
    {
        if ( isdefined( self.lootcachesopened ) )
        {
            if ( self.lootcachesopened == self.var_11133cb0607b498f.lootcachesopened )
            {
                return true;
            }
        }
        else if ( self.var_11133cb0607b498f.lootcachesopened == 0 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0x8ccd6587, Offset: 0x1aad
// Size: 0x44
function condisprematch( params )
{
    returnvalue = gamelogic_mp::inprematch();
    
    if ( isdefined( params ) && isdefined( params.expectedvalue ) )
    {
        return ( params.expectedvalue == returnvalue );
    }
    
    return returnvalue;
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0xae53e12e, Offset: 0x1afa
// Size: 0x39, Type: bool
function function_76f44af8b032d0b0( params )
{
    if ( level.allowarmor )
    {
        currentplates = armor::function_22290101992e4874();
        
        if ( currentplates > 0 )
        {
            return armor::caninsertarmor();
        }
    }
    
    return false;
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0xe15fb2e1, Offset: 0x1b3c
// Size: 0x52
function function_3700200c8e51cdc2( params )
{
    returnvalue = istrue( self.var_11133cb0607b498f.inventoryitemadded );
    
    if ( isdefined( params ) && isdefined( params.expectedvalue ) )
    {
        return ( params.expectedvalue == returnvalue );
    }
    
    return returnvalue;
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0x67f59dcf, Offset: 0x1b97
// Size: 0x52
function function_49ae08a5c8be41b0( params )
{
    returnvalue = istrue( self.var_11133cb0607b498f.hasgasmask );
    
    if ( isdefined( params ) && isdefined( params.expectedvalue ) )
    {
        return ( params.expectedvalue == returnvalue );
    }
    
    return returnvalue;
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0x45cf1f88, Offset: 0x1bf2
// Size: 0x59
function condisplayermoving( params )
{
    vel = self getvelocity();
    returnvalue = length2dsquared( vel ) > 0;
    
    if ( isdefined( params ) && isdefined( params.expectedvalue ) )
    {
        return ( params.expectedvalue == returnvalue );
    }
    
    return returnvalue;
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0x6ade0b50, Offset: 0x1c54
// Size: 0x43
function condisplayersprinting( params )
{
    returnvalue = self issprinting();
    
    if ( isdefined( params ) && isdefined( params.expectedvalue ) )
    {
        return ( params.expectedvalue == returnvalue );
    }
    
    return returnvalue;
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0xd8068ba8, Offset: 0x1ca0
// Size: 0x43
function condisplayerswimming( params )
{
    returnvalue = self isswimming();
    
    if ( isdefined( params ) && isdefined( params.expectedvalue ) )
    {
        return ( params.expectedvalue == returnvalue );
    }
    
    return returnvalue;
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0x862af0c1, Offset: 0x1cec
// Size: 0x61, Type: bool
function function_666973781b4c8792( params )
{
    assert( isdefined( params ) );
    assert( isdefined( params.var_69a7da470814aa46 ) );
    tablet = br_contract_manager::function_12bf8ec6b4419503( params.var_69a7da470814aa46 );
    self.var_11133cb0607b498f.var_97de1c9c7b4a8d85 = tablet;
    return isdefined( tablet );
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0xdb6f2cce, Offset: 0x1d56
// Size: 0x52
function function_db633fd3f9ac034a( params )
{
    returnvalue = istrue( self.var_11133cb0607b498f.hasperkpack );
    
    if ( isdefined( params ) && isdefined( params.expectedvalue ) )
    {
        return ( params.expectedvalue == returnvalue );
    }
    
    return returnvalue;
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0xbfb9ffd7, Offset: 0x1db1
// Size: 0x52
function function_dd13fad7a4999f6b( params )
{
    returnvalue = istrue( self.var_11133cb0607b498f.var_1f5fc91e28cc16a6 );
    
    if ( isdefined( params ) && isdefined( params.expectedvalue ) )
    {
        return ( params.expectedvalue == returnvalue );
    }
    
    return returnvalue;
}

// Namespace namespace_727c07157c884ff5
// Params 1
// Checksum 0x41b98480, Offset: 0x1e0c
// Size: 0xac
function function_2cd95ff652807766( bot )
{
    self waittill( #"waypoint_active" );
    self.var_11133cb0607b498f.var_ce53c4bce083d394.waypointposition = utility::drop_to_ground( bot.origin, 100 ) + ( 0, 0, 1 );
    self.var_11133cb0607b498f.var_ce53c4bce083d394.waypoint = ftue_objectives::function_518a2916085fd4f8( self.var_11133cb0607b498f.var_ce53c4bce083d394.waypointposition, &"ftue_mobile/pick_up_loot", "icon_waypoint_objective_general", 25, self, 1 );
}

// Namespace namespace_727c07157c884ff5
// Params 3
// Checksum 0xda0fc63, Offset: 0x1ec0
// Size: 0x59, Type: bool
function function_e31421c7f6bbe724( position, distancetoitem, item )
{
    if ( isdefined( item ) )
    {
        dist = distance( position, self.origin );
        maxdistance = distancetoitem + distancetoitem * 0.2;
        return ( dist >= maxdistance );
    }
    
    return false;
}

// Namespace namespace_727c07157c884ff5
// Params 3
// Checksum 0xafaf25e6, Offset: 0x1f22
// Size: 0x59, Type: bool
function function_c3c67edfef45b7f4( position, distancetoitem, item )
{
    if ( isdefined( item ) )
    {
        dist = distance( position, self.origin );
        mindistance = distancetoitem + distancetoitem * 0.2;
        return ( dist <= mindistance );
    }
    
    return false;
}

// Namespace namespace_727c07157c884ff5
// Params 0
// Checksum 0x1c9b031f, Offset: 0x1f84
// Size: 0x29
function function_b7cf37986181df6a()
{
    params = spawnstruct();
    params.amount = 4000;
    return ftue_cash::function_11d35b17ca7c28ef( params );
}

