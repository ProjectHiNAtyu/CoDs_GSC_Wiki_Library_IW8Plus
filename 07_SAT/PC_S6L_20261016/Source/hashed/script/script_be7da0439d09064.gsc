// script_be7da0439d09064  (hash_0be7da0439d09064.gscc) (size: 12547 Bytes / 0x3103 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1c1b854 (29472852)
// size ...... 12547 (0x3103)
// includes .. 14  (offset: 0x2e0b)
// strings ... 34  (offset: 0x2e7b)
// dev strs .. 4   (offset: 0x30d3)
// exports ... 36  (offset: 0x1bc3)
// cseg ...... 0x348 + 0x187b (0x1bc3)
// imports ... 102 (offset: 0x2163)
// animtree1 . 0   (offset: 0x3103)
// animtree2 . 0   (offset: 0x3103)
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_dev;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\flags;
#using scripts\mp\hud_popup;
#using scripts\mp\outofbounds;

#namespace br_ftue_popups;

// Namespace br_ftue_popups
// Params 0
// Checksum 0x5be7e703, Offset: 0x366
// Size: 0x8a
function init()
{
    if ( getdvarint( @"br_ftue_enabled", 0 ) == 0 )
    {
        return;
    }
    
    level.br_ftue_enabled = 1;
    level.br_ftue_active = getdvarint( @"br_ftue_active", 0 );
    utility::registersharedfunc( #"ftue", #"player_action", &ftue_triggertip );
    utility::registersharedfunc( #"hud", #"ftue_trigger_landed_hint", &ftue_trigger_landed_hint );
    function_6443ed0caf8009c4();
    
    /#
        br_dev::registerhandlecommand( &handledevcommand_ftue );
    #/
}

// Namespace br_ftue_popups
// Params 0
// Checksum 0x88d40a16, Offset: 0x3f8
// Size: 0x36
function function_6443ed0caf8009c4()
{
    level.var_5e08a049786cb275 = [];
    function_f6599c469bb3a7ce( "br_ftue_supply_box", &function_cb7ae97db5c5bda3 );
    function_f6599c469bb3a7ce( "br_ftue_sliding", &function_a5a441e566ac190a );
    level thread function_2ada57a1ca21644c();
}

// Namespace br_ftue_popups
// Params 1
// Checksum 0x43841ea7, Offset: 0x436
// Size: 0x51
function function_f49737dc364fe5fe( ref )
{
    if ( !isdefined( self.br_ftue_popup_aggregate ) )
    {
        self.br_ftue_popup_aggregate = [];
    }
    
    if ( isdefined( self.br_ftue_popup_aggregate[ ref ] ) )
    {
        self.br_ftue_popup_aggregate[ ref ]++;
        return;
    }
    
    self.br_ftue_popup_aggregate[ ref ] = 1;
}

// Namespace br_ftue_popups
// Params 0
// Checksum 0x4fa3dd6b, Offset: 0x48f
// Size: 0xc2
function function_c55a278601495a5f()
{
    if ( !isdefined( self.br_ftue_popup_aggregate ) )
    {
        return;
    }
    
    foreach ( ref, aggregate in self.br_ftue_popup_aggregate )
    {
        self dlog_recordplayerevent( "dlog_event_ftue_popup_aggregate", [ "is_ftue_playlist", istrue( level.br_ftue_active ), "ftue_popup_ref", ref, "ftue_popup_aggregate", aggregate ] );
    }
}

// Namespace br_ftue_popups
// Params 0
// Checksum 0xb69c5327, Offset: 0x559
// Size: 0x216
function function_2ada57a1ca21644c()
{
    level endon( #"game_ended" );
    level waittill( #"prematch_done" );
    
    if ( getdvarint( @"hash_24c29de93e1ad520", 0 ) == 1 )
    {
        foreach ( player in level.players )
        {
            if ( isdefined( player ) && !isbot( player ) )
            {
                player function_67667cdadc7fd4eb();
            }
        }
    }
    
    var_22ccb27faf250166 = 0;
    var_8f4aa76345b59090 = getdvarint( @"hash_2e1526107156458a", 5 );
    
    if ( var_8f4aa76345b59090 <= 0 )
    {
        return;
    }
    
    wait 10;
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( isalive( player ) )
            {
                foreach ( func in level.var_5e08a049786cb275 )
                {
                    if ( isfunction( func ) )
                    {
                        player [[ func ]]();
                    }
                }
                
                var_22ccb27faf250166++;
            }
            
            if ( var_22ccb27faf250166 >= var_8f4aa76345b59090 )
            {
                var_22ccb27faf250166 = 0;
                wait getdvarint( @"hash_cae27c6584a113b1", 5000 ) / 1000;
            }
        }
        
        var_22ccb27faf250166 = 0;
        wait getdvarint( @"hash_cae27c6584a113b1", 5000 ) / 1000;
    }
}

// Namespace br_ftue_popups
// Params 2
// Checksum 0xf414c88c, Offset: 0x777
// Size: 0x23
function function_f6599c469bb3a7ce( ref, watcherfunc )
{
    level.var_5e08a049786cb275[ ref ] = watcherfunc;
}

// Namespace br_ftue_popups
// Params 1
// Checksum 0xe6c48156, Offset: 0x7a2
// Size: 0x3d
function function_ea9c3e14d02fcaf2( ref )
{
    id = hud_popup::function_87babd196b8f69( ref );
    var_b96eb4fed655dbe8 = hud_popup::function_372e68a1d0e98eec( id );
    return var_b96eb4fed655dbe8.tier;
}

// Namespace br_ftue_popups
// Params 1
// Checksum 0xd94a98e1, Offset: 0x7e8
// Size: 0xa1
function ftue_gettipmask( ref )
{
    id = hud_popup::function_87babd196b8f69( ref );
    var_b96eb4fed655dbe8 = hud_popup::function_372e68a1d0e98eec( id );
    
    if ( isdefined( var_b96eb4fed655dbe8.bitindex ) )
    {
        mask = 1 << var_b96eb4fed655dbe8.bitindex;
    }
    else
    {
        idstring = id ?? "undefined_id";
        refstring = ref ?? "undefined_ref";
        script::demoforcesre( "[ftue_getTipMask] infoPopupEntry.bitIndex undefined for id : " + idstring + " and ref " + refstring );
        mask = undefined;
    }
    
    return mask;
}

// Namespace br_ftue_popups
// Params 1
// Checksum 0x5e5a8907, Offset: 0x892
// Size: 0x3e, Type: bool
function function_523deb6e18e5bf( ref )
{
    playerdata = ftue_getplayerdata();
    mask = ftue_gettipmask( ref );
    
    if ( !isdefined( mask ) )
    {
        return false;
    }
    
    return istrue( playerdata & mask );
}

// Namespace br_ftue_popups
// Params 1
// Checksum 0x747f8aa8, Offset: 0x8d9
// Size: 0x1d4, Type: bool
function function_be4b7154b7be6cc6( ref )
{
    if ( !level.br_ftue_enabled )
    {
        return false;
    }
    
    if ( !isplayer( self ) || isbot( self ) || self isplayerheadless() )
    {
        return false;
    }
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        return false;
    }
    
    if ( !isalive( self ) )
    {
        return false;
    }
    
    if ( !flags::gameflagexists( "br_ready_to_jump" ) )
    {
        return false;
    }
    
    if ( !flags::gameflag( "br_ready_to_jump" ) && ref != "br_ftue_suggested_landing" )
    {
        return false;
    }
    
    if ( player::isinlaststand( self ) )
    {
        return false;
    }
    
    if ( br_public::isplayeringulag() )
    {
        return false;
    }
    
    if ( outofbounds::isoob( self ) )
    {
        return false;
    }
    
    if ( isdefined( self.br_kiosk ) )
    {
        return false;
    }
    
    if ( function_5ac5fbe81fc2a2c5( ref ) )
    {
        return false;
    }
    
    if ( function_523deb6e18e5bf( ref ) )
    {
        function_f49737dc364fe5fe( ref );
        return false;
    }
    
    popupduration = getdvarint( @"hash_185628cd0876e868", 12000 );
    popupdelay = getdvarint( @"hash_c2618ebb2ca593d3", 3000 );
    
    if ( isdefined( self.lastpopuptime ) && gettime() - self.lastpopuptime <= popupduration + popupdelay )
    {
        return false;
    }
    
    if ( ref != "br_ftue_gas" && br_circle::function_6bf5d4e680297398( self.origin ) && ref != "br_ftue_suggested_landing" )
    {
        return false;
    }
    
    if ( !function_6b5ba8bfc7429c4a( ref ) )
    {
        var_e80ec190a0d2aaff = getdvarint( @"br_ftue_enemy_dist", 3000 );
        var_9d817c8e6ecff072 = getdvarint( @"hash_3ebb28ca5b9b3010", 500 );
        enemy_in_range = self getclosestenemy( var_e80ec190a0d2aaff, var_9d817c8e6ecff072, 1 );
        
        if ( isdefined( enemy_in_range ) && !isagent( enemy_in_range ) )
        {
            return false;
        }
        
        if ( function_ff065e4e4dea9f90( self ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace br_ftue_popups
// Params 1
// Checksum 0x5152fb8b, Offset: 0xab6
// Size: 0x169
function function_b48acf0cdbfb0831( pingent )
{
    if ( !isplayer( self ) || isbot( self ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_7f7ff49d4459fedd", 0 ) == 1 )
    {
        return;
    }
    
    if ( !isdefined( pingent ) )
    {
        return;
    }
    
    pingindex = undefined;
    
    if ( isvector( pingent ) )
    {
        var_16de0f4e12c08f4c = function_1bf3a084cfe14025( 8 );
        pingindex = calloutmarkerping::function_a3f0d6526c09f579( var_16de0f4e12c08f4c, pingent + ( 0, 0, level.calloutmarkerping.var_b41266c97bfb092c ) );
    }
    else if ( isent( pingent ) && isplayer( pingent ) && isdefined( pingent.team ) && isalive( pingent ) )
    {
        if ( self.team != pingent.team )
        {
            var_2d515e25c568f2b3 = function_1bf3a084cfe14025( 4 );
            pingindex = calloutmarkerping::function_a3f0d6526c09f579( var_2d515e25c568f2b3, pingent.origin + ( 0, 0, 82 ) );
        }
        else
        {
            var_16de0f4e12c08f4c = function_1bf3a084cfe14025( 8 );
            pingindex = calloutmarkerping::function_a3f0d6526c09f579( var_16de0f4e12c08f4c, pingent.origin + ( 0, 0, level.calloutmarkerping.var_b41266c97bfb092c ) );
        }
    }
    else if ( pingent getscriptableisloot() )
    {
        pingindex = calloutmarkerping::function_920a63c06abdefe8( pingent.index );
    }
    else
    {
        return;
    }
    
    if ( isdefined( pingindex ) )
    {
        thread calloutmarkerping::predicted_timeout( pingindex );
    }
}

// Namespace br_ftue_popups
// Params 2
// Checksum 0x356f9520, Offset: 0xc27
// Size: 0x66
function ftue_triggertip( ref, pingent )
{
    if ( !isplayer( self ) || isbot( self ) )
    {
        return;
    }
    
    if ( level.br_ftue_enabled && function_be4b7154b7be6cc6( ref ) )
    {
        hud_popup::showinfopopup( ref );
        thread function_b48acf0cdbfb0831( pingent );
        thread function_14427d4900704e75( ref );
        self playlocalsound( "uin_iw9_ftue_tip_generic" );
    }
}

// Namespace br_ftue_popups
// Params 1
// Checksum 0xcd2f61e8, Offset: 0xc95
// Size: 0x3f, Type: bool
function function_1f5ba12b3d060c59( ref )
{
    if ( !isalive( self ) )
    {
        return false;
    }
    
    if ( br_public::isplayeringulag() )
    {
        return false;
    }
    
    if ( isdefined( self.br_kiosk ) )
    {
        return false;
    }
    
    if ( function_ff065e4e4dea9f90( self ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br_ftue_popups
// Params 3
// Checksum 0x30808dd1, Offset: 0xcdd
// Size: 0xf5
function function_14427d4900704e75( ref, mask, bimmediate )
{
    assert( isplayer( self ) );
    self endon( #"hash_16f24c99b1ccc8bf" );
    
    if ( !bimmediate )
    {
        waitduration = getdvarint( @"hash_185628cd0876e868", 12000 ) / 1000;
        wait waitduration;
    }
    
    if ( !function_1f5ba12b3d060c59( ref ) )
    {
        function_2c91796e37baa989( ref );
        return;
    }
    
    if ( ref == "br_ftue_suggested_landing" )
    {
        return;
    }
    
    if ( level.br_ftue_enabled )
    {
        playerdata = ftue_getplayerdata();
        mask = ftue_gettipmask( ref );
        playerdata |= mask;
        ftue_setplayerdata( playerdata );
        isftueplaylist = istrue( level.br_ftue_active );
        self dlog_recordplayerevent( "dlog_event_ftue_popup_initial", [ "ftue_popup_ref", ref, "is_ftue_playlist", isftueplaylist ] );
    }
}

// Namespace br_ftue_popups
// Params 0
// Checksum 0xe4969f15, Offset: 0xdda
// Size: 0x48
function function_882bc4a418cc66db()
{
    if ( isdefined( self.var_19f4eef76dc6a979 ) && !function_523deb6e18e5bf( self.var_19f4eef76dc6a979 ) )
    {
        self notify( #"hash_16f24c99b1ccc8bf" );
        function_2c91796e37baa989( self.var_19f4eef76dc6a979 );
        hud_popup::function_7a2062cf8e49c4b8();
        return 0;
    }
}

// Namespace br_ftue_popups
// Params 1
// Checksum 0x4e0b074b, Offset: 0xe2a
// Size: 0x44
function function_2c91796e37baa989( ref )
{
    if ( isdefined( ref ) && isdefined( self ) )
    {
        if ( !isdefined( self.var_440bfe659653b763 ) )
        {
            self.var_440bfe659653b763 = [];
        }
        
        self.var_440bfe659653b763[ self.var_440bfe659653b763.size ] = ref;
    }
}

// Namespace br_ftue_popups
// Params 1
// Checksum 0x5d97785a, Offset: 0xe76
// Size: 0x94, Type: bool
function function_5ac5fbe81fc2a2c5( ref )
{
    if ( isdefined( self.var_440bfe659653b763 ) )
    {
        foreach ( skipped_ref in self.var_440bfe659653b763 )
        {
            if ( ref == skipped_ref )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace br_ftue_popups
// Params 0
// Checksum 0xad7942d3, Offset: 0xf13
// Size: 0x31
function ftue_getplayerdata()
{
    assert( isplayer( self ) );
    playerdata = self getplayerdata( "mp", "ftueData", "popup_messages_01" );
    return playerdata;
}

// Namespace br_ftue_popups
// Params 1
// Checksum 0xad794299, Offset: 0xf4d
// Size: 0x30
function ftue_setplayerdata( data )
{
    assert( isplayer( self ) );
    self setplayerdata( "mp", "ftueData", "popup_messages_01", data );
}

// Namespace br_ftue_popups
// Params 1
// Checksum 0xfc2b30bf, Offset: 0xf85
// Size: 0x6c
function function_67667cdadc7fd4eb( ref )
{
    assert( isplayer( self ) );
    
    if ( isdefined( ref ) )
    {
        playerdata = ftue_getplayerdata();
        mask = ftue_gettipmask( ref );
        playerdata &= !mask;
        ftue_setplayerdata( playerdata );
        return;
    }
    
    self setplayerdata( "mp", "ftueData", "popup_messages_01", 0 );
}

// Namespace br_ftue_popups
// Params 0
// Checksum 0xb934c148, Offset: 0xff9
// Size: 0x31
function function_cafc3410f3b1cf55()
{
    assert( isplayer( self ) );
    matchcount = self getplayerdata( "mp", "ftueData", "ftue_match_count" );
    return matchcount;
}

// Namespace br_ftue_popups
// Params 1
// Checksum 0xb934c102, Offset: 0x1033
// Size: 0x30
function function_763064fb49699819( data )
{
    assert( isplayer( self ) );
    self setplayerdata( "mp", "ftueData", "ftue_match_count", data );
}

// Namespace br_ftue_popups
// Params 0
// Checksum 0xfc6fae6c, Offset: 0x106b
// Size: 0x57
function function_3575388e7b3207cb()
{
    if ( isplayer( self ) )
    {
        function_c55a278601495a5f();
        matchcount = self getplayerdata( "mp", "ftueData", "ftue_match_count" );
        
        if ( matchcount < 10 )
        {
            matchcount += 1;
            self setplayerdata( "mp", "ftueData", "ftue_match_count", matchcount );
        }
    }
}

// Namespace br_ftue_popups
// Params 0
// Checksum 0xfaa748fe, Offset: 0x10ca
// Size: 0x25
function function_4639617921a94fea()
{
    assert( isplayer( self ) );
    self setplayerdata( "mp", "ftueData", "ftue_match_count", 0 );
}

// Namespace br_ftue_popups
// Params 0
// Checksum 0xa96894b0, Offset: 0x10f7
// Size: 0x1d6
function function_e0f2f6db293c4367()
{
    /#
        if ( level.mapname == "<dev string:x24>" && getdvarint( @"hash_97ab1e3e328ddff9", 0 ) == 0 )
        {
            return;
        }
    #/
    
    wait 1;
    startpt = level.infilstruct.c130pathstruct.startpt;
    endpt = level.infilstruct.c130pathstruct.endpt;
    maxdist = 2000;
    maxdistsquared = maxdist * maxdist;
    locationindex = 1;
    
    foreach ( player in level.players )
    {
        if ( player br_public::isplayerbrsquadleader() )
        {
            for ( i = locationindex; i <= tablelookupgetnumrows( "mp/brLandingLocations.csv" ) ; i++ )
            {
                xvalue = int( tablelookupbyrow( "mp/brLandingLocations.csv", i, 1 ) );
                yvalue = int( tablelookupbyrow( "mp/brLandingLocations.csv", i, 2 ) );
                zvalue = int( tablelookupbyrow( "mp/brLandingLocations.csv", i, 3 ) );
                landingpoint = ( xvalue, yvalue, zvalue );
                dist2dsquared = distance2dsquared( pointonsegmentnearesttopoint( startpt, endpt, landingpoint ), landingpoint );
                
                if ( dist2dsquared <= maxdistsquared )
                {
                    locationindex = i + 1;
                    player ftue_triggertip( "br_ftue_suggested_landing", landingpoint );
                }
            }
        }
    }
}

// Namespace br_ftue_popups
// Params 0
// Checksum 0xba0bcbf3, Offset: 0x12d5
// Size: 0x1e9
function function_cb7ae97db5c5bda3()
{
    if ( function_be4b7154b7be6cc6( "br_ftue_supply_box" ) )
    {
        var_ca77ea7d96da9013 = getentitylessscriptablearray( undefined, undefined, self.origin, 800, "body" );
        
        if ( var_ca77ea7d96da9013.size > 0 )
        {
            var_13fc033c2285d3b7 = undefined;
            var_dc1e1039746ac67 = 640000;
            player_angles = self getplayerangles();
            player_forward = anglestoforward( player_angles );
            var_f2f9059a23692741 = 0.8;
            
            foreach ( lootcache in var_ca77ea7d96da9013 )
            {
                partstate = lootcache getscriptablepartstate( "body", 1 );
                
                if ( !isdefined( partstate ) )
                {
                    continue;
                }
                
                if ( partstate == #"closed_usable" || partstate == #"closed_usable_no_collision" )
                {
                    distsq = distancesquared( self.origin, lootcache.origin );
                    angles = vectortoangles( lootcache.origin - self.origin );
                    forward = anglestoforward( angles );
                    facingdot = vectordot( forward, player_forward );
                    
                    if ( facingdot > var_f2f9059a23692741 )
                    {
                        if ( distsq < var_dc1e1039746ac67 && abs( self.origin[ 2 ] - lootcache.origin[ 2 ] ) < 80 )
                        {
                            var_13fc033c2285d3b7 = lootcache;
                            var_dc1e1039746ac67 = distsq;
                        }
                    }
                }
            }
            
            if ( isdefined( var_13fc033c2285d3b7 ) )
            {
                ftue_triggertip( "br_ftue_supply_box", var_13fc033c2285d3b7.origin );
            }
        }
    }
}

// Namespace br_ftue_popups
// Params 0
// Checksum 0xa51c080d, Offset: 0x14c6
// Size: 0x69
function function_fecb083307153311()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( self usinggamepad() )
    {
        invertslide = utility::requestgamerprofile( "slideDiveInvertHoldGamepad" );
    }
    else
    {
        invertslide = utility::requestgamerprofile( "slideDiveInvertHoldKBM" );
    }
    
    if ( invertslide )
    {
        ftue_triggertip( "br_ftue_sliding_invert" );
        return;
    }
    
    ftue_triggertip( "br_ftue_sliding" );
}

// Namespace br_ftue_popups
// Params 0
// Checksum 0x7eb347e9, Offset: 0x1537
// Size: 0x2e
function function_a5a441e566ac190a()
{
    if ( function_be4b7154b7be6cc6( "br_ftue_sliding" ) || function_be4b7154b7be6cc6( "br_ftue_sliding_invert" ) )
    {
        if ( self issprinting() )
        {
            thread function_fecb083307153311();
        }
    }
}

// Namespace br_ftue_popups
// Params 1
// Checksum 0x8b7c0dd3, Offset: 0x156d
// Size: 0x7c
function function_75685f2376c4d9dd( victim )
{
    if ( function_be4b7154b7be6cc6( "br_ftue_enemy_down" ) )
    {
        wait 5;
        
        if ( player::isinlaststand( victim ) )
        {
            ftue_triggertip( "br_ftue_enemy_down", victim );
        }
        
        return;
    }
    
    if ( function_be4b7154b7be6cc6( "br_ftue_interrogation" ) && function_523deb6e18e5bf( "br_ftue_enemy_down" ) )
    {
        wait 3;
        
        if ( player::isinlaststand( victim ) && isalive( victim ) )
        {
            ftue_triggertip( "br_ftue_interrogation", victim );
        }
    }
}

// Namespace br_ftue_popups
// Params 1
// Checksum 0x3911d225, Offset: 0x15f1
// Size: 0x57
function function_e05ce093ad06ba05( teammate )
{
    if ( function_be4b7154b7be6cc6( "br_ftue_revive" ) )
    {
        distsq = distancesquared( self.origin, teammate.origin );
        
        if ( distsq < 1000000 )
        {
            ftue_triggertip( "br_ftue_revive", teammate );
        }
    }
}

// Namespace br_ftue_popups
// Params 1
// Checksum 0x4280c25c, Offset: 0x1650
// Size: 0x44, Type: bool
function function_6b5ba8bfc7429c4a( ref )
{
    return ref == "br_ftue_interrogation" || ref == "br_ftue_enemy_down" || ref == "br_ftue_gas" || ref == "br_ftue_parachute" || ref == "br_ftue_suggested_landing";
}

// Namespace br_ftue_popups
// Params 1
// Checksum 0x3cccb806, Offset: 0x169d
// Size: 0x12e, Type: bool
function function_ff065e4e4dea9f90( player )
{
    currenttime = gettime();
    var_d88abe6649a4ded2 = getdvarint( @"hash_2d46f9a1548dfb28", 12000 );
    
    if ( isdefined( player ) && isdefined( player.pers[ "lastDamageTime" ] ) && player.pers[ "lastDamageTime" ] + var_d88abe6649a4ded2 > currenttime || isdefined( player.lasttimedamaged ) && player.lasttimedamaged + var_d88abe6649a4ded2 > currenttime || isdefined( player.lastdamagedtime ) && player.lastdamagedtime + var_d88abe6649a4ded2 > currenttime )
    {
        return true;
    }
    
    player battlechatter_mp::validaterecentattackers();
    
    if ( player.recentattackers.size > 0 )
    {
        return true;
    }
    
    if ( isdefined( player.vehicle ) )
    {
        if ( player.vehicle.burningdown )
        {
            return true;
        }
        
        if ( weapon_utility::islockedonto( player.vehicle ) )
        {
            return true;
        }
    }
    
    if ( isdefined( player ) && player outofbounds::istouchingoobtrigger() )
    {
        return true;
    }
    
    return false;
}

// Namespace br_ftue_popups
// Params 0
// Checksum 0x12a02b43, Offset: 0x17d4
// Size: 0x6c
function ftue_trigger_landed_hint()
{
    if ( function_be4b7154b7be6cc6( "br_ftue_controls" ) )
    {
        ftue_triggertip( "br_ftue_controls" );
        return;
    }
    
    teamplayers = teams::getfriendlyplayers( self.team, 1 );
    
    if ( teamplayers.size > 0 && function_523deb6e18e5bf( "br_ftue_controls" ) && function_be4b7154b7be6cc6( "br_ftue_ping" ) )
    {
        ftue_triggertip( "br_ftue_ping" );
    }
}

// Namespace br_ftue_popups
// Params 2
// Checksum 0xb96fe5ca, Offset: 0x1848
// Size: 0x7c
function function_b35cb1894366eb2c( scriptablename, pickup )
{
    if ( function_be4b7154b7be6cc6( "br_ftue_stronghold" ) )
    {
        if ( !br_pickups::function_3a6d2dc9abde2071( pickup ) )
        {
            return;
        }
        
        var_6f1adca00d0cf65b = level.br_pickups.br_itemtype[ scriptablename ] == #"key" && issubstr( scriptablename, "loot_key_fortress" );
        
        if ( var_6f1adca00d0cf65b )
        {
            ftue_triggertip( "br_ftue_stronghold" );
        }
    }
}

/#

    // Namespace br_ftue_popups
    // Params 2
    // Checksum 0x96d8cd63, Offset: 0x18cc
    // Size: 0x2f7, Type: dev
    function handledevcommand_ftue( command, args )
    {
        switch ( command )
        {
            case #"hash_331cc3d256f46a92":
                popupref = "<dev string:x3e>";
                
                if ( isdefined( args[ 0 ] ) )
                {
                    popupref = args[ 0 ];
                }
                
                level.player function_67667cdadc7fd4eb( popupref );
                level.player ftue_triggertip( popupref );
                break;
            case #"hash_6d4107298063ce5b":
                level.player function_67667cdadc7fd4eb();
                level.player function_4639617921a94fea();
                break;
            case #"hash_3042071cce2a405a":
                level.player function_67667cdadc7fd4eb();
                break;
            case #"hash_3e708dd7a95b6863":
                level.player function_4639617921a94fea();
                break;
            case #"hash_cd0526653dd5a3c2":
                matchcount = 1;
                
                if ( isdefined( args ) )
                {
                    matchcount = args;
                }
                
                level.player function_763064fb49699819( matchcount );
                break;
            case #"hash_f51410d2484dcf62":
                level.player function_3575388e7b3207cb();
                break;
            case #"hash_75c29bbe1edeb517":
                popupref = "<dev string:xbe>";
                level.player function_67667cdadc7fd4eb( popupref );
                squadmates = teams::function_d032b36d01bbbab3( level.player.team, level.player.sessionsquadid, 1 );
                
                foreach ( player in squadmates )
                {
                    if ( player != level.player )
                    {
                        level.player ftue_triggertip( popupref, player );
                        return;
                    }
                }
                
                break;
            case #"hash_badf722cbb8a0456":
                popupref = "<dev string:xdc>";
                level.player function_67667cdadc7fd4eb( popupref );
                enemyplayers = teams::getenemyplayers( level.player.team, 1 );
                
                foreach ( player in enemyplayers )
                {
                    if ( isalive( player ) )
                    {
                        level.player ftue_triggertip( popupref, player );
                    }
                    
                    return;
                }
                
                break;
            default:
                break;
        }
    }

#/
