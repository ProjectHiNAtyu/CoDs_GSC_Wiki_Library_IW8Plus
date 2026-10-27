// scripts\mp\callouts.gsc  (hash_7001f79cfe5ff18f.gscc) (size: 5989 Bytes / 0x1765 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x809fc150 (2157953360)
// size ...... 5989 (0x1765)
// includes .. 3   (offset: 0x1629)
// strings ... 12  (offset: 0x1641)
// dev strs .. 6   (offset: 0x1711)
// exports ... 14  (offset: 0xef5)
// cseg ...... 0xf3 + 0xe02 (0xef5)
// imports ... 43  (offset: 0x1125)
// animtree1 . 0   (offset: 0x1765)
// animtree2 . 0   (offset: 0x1765)
#using scripts\common\callbacks;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\player;

#namespace callouts;

// Namespace callouts
// Params 0
// Checksum 0xcd72ea06, Offset: 0x111
// Size: 0x216
function init()
{
    if ( !level.gametypebundle.var_e71d2fb08c4ca448 )
    {
        return;
    }
    
    level.calloutglobals = spawnstruct();
    var_581dd667f45f2d16 = getdvarint( @"bg_compassregions_enabled", 1 );
    
    if ( var_581dd667f45f2d16 )
    {
        var_7155b217356dab2d = game_utility_mp::function_3e2a0e4a5bf03624();
        var_46671f231be8e83f = "mp/compass_regions/" + "compassregions_" + level.mapname + "_poi_regions" + ".csv";
        compassregionsconfig = "mp/compass_regions/" + "compassregions_" + level.mapname + "_" + var_7155b217356dab2d + "_poi_regions" + ".csv";
        function_d451ed5980378d2( compassregionsconfig, var_46671f231be8e83f, 1 );
    }
    
    level.calloutglobals.var_e3610645ced210b2 = var_581dd667f45f2d16 && function_989729b41cc7d6f7( 1 );
    
    if ( !level.calloutglobals.var_e3610645ced210b2 )
    {
        mapinfo = getmapscriptbundle();
        
        if ( isdefined( mapinfo ) )
        {
            level.calloutglobals.calloutlist = [];
            
            for ( idx = 0; idx < mapinfo.calloutlist.size ; idx++ )
            {
                level.calloutglobals.calloutlist[ level.calloutglobals.calloutlist.size ] = mapinfo.calloutlist[ idx ].variant_object;
            }
        }
        else
        {
            println( "<dev string:x24>" );
        }
    }
    
    function_2e65ecb10b555546();
    
    if ( !level.calloutglobals.var_e3610645ced210b2 && !isdefined( level.calloutglobals.calloutlist ) && !isdefined( level.calloutglobals.callouttable ) )
    {
        return;
    }
    
    function_2878d3deabf9e83d();
    
    if ( isbrgamemode() && getdvarint( @"scr_disable_br_callouts", 0 ) == 0 )
    {
        return;
    }
    
    function_e015e9eaea91880c();
    thread monitorplayers();
}

// Namespace callouts
// Params 0, eflags: 0x4
// Checksum 0x8e9509d9, Offset: 0x32f
// Size: 0x45
function private function_2e65ecb10b555546()
{
    globals = level.calloutglobals;
    globals.var_53e9af0664d65512 = [];
    globals.areaidmap = [];
    globals.areaidmap[ "none" ] = -1;
}

// Namespace callouts
// Params 0, eflags: 0x4
// Checksum 0x7f90fb45, Offset: 0x37c
// Size: 0x2f0
function private function_2878d3deabf9e83d()
{
    globals = level.calloutglobals;
    
    if ( globals.var_e3610645ced210b2 )
    {
        sitecount = function_fd6ceee336caaf26( 1 );
        
        for ( siteidx = 0; siteidx < sitecount ; siteidx++ )
        {
            site = function_e1b7d58d23ea03ff( 1, siteidx );
            region = function_ba8494ae1c952908( 1, site.region );
            ref = region.name + " site_" + siteidx;
            assert( !isdefined( globals.areaidmap[ ref ] ), "<dev string:x54>" + ref + "<dev string:x62>" + level.mapname );
            globals.areaidmap[ ref ] = site.region;
            globals.var_53e9af0664d65512[ siteidx ] = ref;
        }
        
        return;
    }
    
    if ( isdefined( level.calloutglobals.calloutlist ) )
    {
        for ( idx = 0; idx < level.calloutglobals.calloutlist.size ; idx++ )
        {
            type = level.calloutglobals.calloutlist[ idx ].type;
            
            if ( type != "area" )
            {
                continue;
            }
            
            ref = level.calloutglobals.calloutlist[ idx ].calloutref;
            assert( !isdefined( globals.areaidmap[ ref ] ), "<dev string:x54>" + ref + "<dev string:x62>" + level.mapname );
            globals.areaidmap[ ref ] = idx;
        }
        
        return;
    }
    
    if ( isdefined( level.calloutglobals.callouttable ) && tableexists( level.calloutglobals.callouttable ) )
    {
        for ( row = 0; true ; row++ )
        {
            id = tablelookupbyrow( level.calloutglobals.callouttable, row, 0 );
            
            if ( !isdefined( id ) || id == "" )
            {
                break;
            }
            
            id = int( id );
            type = tablelookupbyrow( level.calloutglobals.callouttable, row, 3 );
            
            if ( type != "area" )
            {
                continue;
            }
            
            ref = tablelookupbyrow( level.calloutglobals.callouttable, row, 1 );
            assert( !isdefined( globals.areaidmap[ ref ] ), "<dev string:x54>" + ref + "<dev string:x7a>" + level.calloutglobals.callouttable );
            globals.areaidmap[ ref ] = id;
        }
    }
}

// Namespace callouts
// Params 0, eflags: 0x4
// Checksum 0xb1d43e45, Offset: 0x674
// Size: 0xc2
function private function_e015e9eaea91880c()
{
    if ( !level.calloutglobals.var_e3610645ced210b2 )
    {
        level.calloutglobals.areatriggers = getentarray( "callout_area", #targetname );
        
        foreach ( areatrigger in level.calloutglobals.areatriggers )
        {
            areatrigger thread function_ed9f34b1194d2b5();
        }
    }
}

// Namespace callouts
// Params 0, eflags: 0x4
// Checksum 0xf345e7a2, Offset: 0x73e
// Size: 0x8e
function private monitorplayers()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"connected", player );
        player thread clearcalloutareaondeath();
        player setplayercalloutarea( "none" );
        
        if ( level.gamemodebundle.var_ab0f3380d917e074 )
        {
            player callback::add( "zone_changed", &on_zone_changed );
        }
        
        if ( level.calloutglobals.var_e3610645ced210b2 )
        {
            player thread function_b3589f847de7bf06();
        }
    }
}

// Namespace callouts
// Params 0, eflags: 0x4
// Checksum 0x653c9548, Offset: 0x7d4
// Size: 0x6e
function private function_ed9f34b1194d2b5()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( isplayer( player.owner ) )
        {
            player = player.owner;
        }
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        player setplayercalloutarea( self.script_noteworthy, self );
    }
}

// Namespace callouts
// Params 0, eflags: 0x4
// Checksum 0x268e3ba6, Offset: 0x84a
// Size: 0x128
function private function_b3589f847de7bf06()
{
    assert( level.calloutglobals.var_e3610645ced210b2 );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    player = self;
    globals = level.calloutglobals;
    clientnum = player getentitynumber();
    
    while ( gettime() / level.frameduration % 5 != clientnum % 5 )
    {
        waitframe();
    }
    
    while ( true )
    {
        siteidx = function_2d6761e072b4e500( 1, player.origin );
        ref = "none";
        
        if ( isdefined( siteidx ) )
        {
            ref = globals.var_53e9af0664d65512[ siteidx ];
        }
        
        areaid = globals.areaidmap[ ref ];
        
        if ( !isdefined( player.calloutarea ) || areaid != globals.areaidmap[ player.calloutarea ] )
        {
            player setplayercalloutarea( ref );
        }
        
        wait level.framedurationseconds * 5;
    }
}

// Namespace callouts
// Params 2
// Checksum 0x5c5bc401, Offset: 0x97a
// Size: 0x18e
function setplayercalloutarea( calloutref, trigger )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( calloutref ) )
    {
        return;
    }
    
    if ( self.calloutarea == calloutref )
    {
        return;
    }
    
    if ( !isbrgamemode() )
    {
        if ( isdefined( self.calloutarea ) && calloutref != "none" && self.calloutarea != "none" )
        {
            return;
        }
    }
    
    self.calloutarea = calloutref;
    
    if ( isdefined( trigger ) )
    {
        thread watchplayerleavingcalloutarea( trigger, trigger.script_noteworthy );
    }
    
    areaid = level.calloutglobals.areaidmap[ calloutref ];
    
    if ( isdefined( areaid ) )
    {
        self setclientomnvar( "ui_callout_area_id", areaid );
        
        if ( level.codcasterenabled )
        {
            spectators = player::get_players_watching( 1, 0 );
            
            foreach ( spectator in spectators )
            {
                if ( spectator iscodcaster() )
                {
                    spectator setclientomnvar( "ui_callout_area_id", areaid );
                }
            }
        }
        
        return;
    }
    
    if ( calloutref != "none" )
    {
        assertmsg( "<dev string:x8d>" + calloutref + "<dev string:x9c>" + level.mapname );
    }
}

// Namespace callouts
// Params 2, eflags: 0x4
// Checksum 0x35bda8a5, Offset: 0xb10
// Size: 0x63
function private watchplayerleavingcalloutarea( areatrigger, calloutref )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        if ( self.calloutarea != calloutref )
        {
            return;
        }
        
        if ( !self istouching( areatrigger ) )
        {
            setplayercalloutarea( "none" );
            return;
        }
        
        wait 0.5;
    }
}

// Namespace callouts
// Params 0, eflags: 0x4
// Checksum 0x405d6ade, Offset: 0xb7b
// Size: 0x2f
function private clearcalloutareaondeath()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"death" );
        setplayercalloutarea( "none" );
    }
}

// Namespace callouts
// Params 1
// Checksum 0xdd361ad1, Offset: 0xbb2
// Size: 0x5c
function on_zone_changed( params )
{
    if ( isdefined( params.zone_struct ) && isdefined( params.zone_struct.display_name ) )
    {
        setplayercalloutarea( "none" );
        setplayercalloutarea( params.zone_struct.display_name );
    }
}

// Namespace callouts
// Params 1
// Checksum 0x7c4c00e3, Offset: 0xc16
// Size: 0x178
function function_69298682a76ef6c5( object )
{
    assert( isdefined( object.origin ) );
    globals = level.calloutglobals;
    ref = "none";
    
    if ( globals.var_e3610645ced210b2 )
    {
        siteidx = function_2d6761e072b4e500( 1, object.origin );
        
        if ( isdefined( siteidx ) )
        {
            ref = globals.var_53e9af0664d65512[ siteidx ];
        }
    }
    else if ( isdefined( level.calloutglobals.areatriggers ) )
    {
        var_275d609c68e26c32 = 3.40282e+38;
        
        foreach ( areatrigger in level.calloutglobals.areatriggers )
        {
            if ( object istouching( areatrigger ) )
            {
                distance_squared = distancesquared( object.origin, areatrigger.origin );
                
                if ( var_275d609c68e26c32 > distance_squared )
                {
                    var_275d609c68e26c32 = distance_squared;
                    ref = areatrigger.script_noteworthy;
                }
            }
        }
    }
    
    return globals.areaidmap[ ref ];
}

// Namespace callouts
// Params 1
// Checksum 0xed9e4acf, Offset: 0xd97
// Size: 0x15d
function function_9a41f54921665d99( position )
{
    globals = level.calloutglobals;
    ref = "none";
    
    if ( globals.var_e3610645ced210b2 )
    {
        siteidx = function_2d6761e072b4e500( 1, position );
        
        if ( isdefined( siteidx ) )
        {
            ref = globals.var_53e9af0664d65512[ siteidx ];
        }
    }
    else if ( isdefined( level.calloutglobals.areatriggers ) )
    {
        var_275d609c68e26c32 = 3.40282e+38;
        
        foreach ( areatrigger in level.calloutglobals.areatriggers )
        {
            if ( !isent( areatrigger ) || areatrigger istouchingpoint( position ) )
            {
                distance_squared = distancesquared( position, areatrigger.origin );
                
                if ( var_275d609c68e26c32 > distance_squared )
                {
                    var_275d609c68e26c32 = distance_squared;
                    ref = areatrigger.script_noteworthy;
                }
            }
        }
    }
    
    return globals.areaidmap[ ref ];
}

