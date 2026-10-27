// scripts\mp\br\gametypes\br_functional_poi.gsc  (hash_7426e3b4e88dd176.gscc) (size: 11294 Bytes / 0x2c1e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb563cce0 (3043216608)
// size ...... 11294 (0x2c1e)
// includes .. 17  (offset: 0x2a5a)
// strings ... 17  (offset: 0x2ae2)
// dev strs .. 6   (offset: 0x2bd2)
// exports ... 21  (offset: 0x1ece)
// cseg ...... 0x198 + 0x1d36 (0x1ece)
// imports ... 69  (offset: 0x2216)
// animtree1 . 0   (offset: 0x2c1e)
// animtree2 . 0   (offset: 0x2c1e)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_armory_kiosk;
#using scripts\mp\br\gametypes\br_bank;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_mobile_armory;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_respawn;
#using scripts\mp\br\gametypes\br_satellite_truck;
#using scripts\mp\br\gametypes\br_weapon_upgrade;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\poi;
#using scripts\mp\structspawnconfig;

#namespace br_functional_poi;

// Namespace br_functional_poi
// Params 0
// Checksum 0x91f78bca, Offset: 0x1b6
// Size: 0x85
function init()
{
    flags::gameflaginit( "POIs_initialized", 0 );
    thread function_6b4b1cbd4acf7efb();
    br_plunder::init();
    br_mobile_armory::init();
    br_satellite_truck::init();
    br_armory_kiosk::init();
    br_bank::init();
    br_weapon_upgrade::init();
    callback::callback( "br_functional_poi_init" );
    flags::gameflagset( "POIs_initialized" );
    flags::gameflaginit( "POIs_spawned", 0 );
    level notify( #"spawning_pois" );
    waittillframeend();
    level thread _spawnpois();
    
    /#
        level thread initdebug();
    #/
}

// Namespace br_functional_poi
// Params 0, eflags: 0x4
// Checksum 0xce490b09, Offset: 0x243
// Size: 0x26
function private function_6b4b1cbd4acf7efb()
{
    if ( structspawnconfig::init() )
    {
        game_utility::function_c4ff84a7288ed707();
        level waittill( #"ssc_config_spawned" );
        game_utility::function_48cf7b776b9642d3();
    }
}

// Namespace br_functional_poi
// Params 1
// Checksum 0x11f36b7c, Offset: 0x271
// Size: 0x15
function initplayer( revivespawn )
{
    br_plunder::initplayer( revivespawn );
}

/#

    // Namespace br_functional_poi
    // Params 0
    // Checksum 0x353a0aae, Offset: 0x28e
    // Size: 0x2e, Type: dev
    function initdebug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x38>", "<dev string:x46>", &rerollkiosks );
        devgui::function_77df7fe7dd273e10();
    }

#/

// Namespace br_functional_poi
// Params 0
// Checksum 0x88d146aa, Offset: 0x2c4
// Size: 0x4b
function onprematchdone()
{
    flags::gameflagwait( "POIs_spawned" );
    br_mobile_armory::onprematchdone();
    br_satellite_truck::onprematchdone();
    callback::callback( "br_functional_poi_on_prematch_done" );
    
    if ( isdefined( level.var_cef046b41cf46986 ) )
    {
        [[ level.var_cef046b41cf46986.on_prematch_done ]]();
    }
}

// Namespace br_functional_poi
// Params 0
// Checksum 0xbf597103, Offset: 0x317
// Size: 0x7
function getinteractiveoutlineasset()
{
    return "outline_depth_red";
}

// Namespace br_functional_poi
// Params 0
// Checksum 0x90307a0f, Offset: 0x327
// Size: 0x318
function _spawnpois()
{
    level endon( #"game_ended" );
    spawn_interval_seconds = 0.05;
    var_8f80f5f0b7711e94 = 5;
    var_547c2706b5e8888c = 5;
    var_4088dc6e5c4c25f9 = 7;
    var_91a1ccd29bb02f53 = 7;
    gametype = game_utility::getgametype();
    
    if ( gametype == "plunder" && ( level.mapname == "mp_saba" || level.mapname == "mp_saba2" ) || gametype == "risk" )
    {
        level.adjusteventdistributionpadding = getdvarint( @"hash_325dd950793b218d", 35 );
        level.pushdistributiontowardoppositecorner = getdvarint( @"hash_e8812b2c1b71911e", 1 );
        level.buystationsusepaddingdistribution = getdvarint( @"hash_2bd779ec50609b29", 0 );
        level thread setupmapquadrantcornersandgrid();
    }
    
    if ( !getdvarint( @"hash_28df7f89e6eab57c", 0 ) || !getdvarint( @"scr_ssc_enabled", 1 ) )
    {
        level.minplunderextractions = getdvarint( @"hash_eaacc4689dd5d721", var_91a1ccd29bb02f53 );
        level.maxplunderextractions = getdvarint( @"hash_23f4eae3aeebefd3", var_4088dc6e5c4c25f9 );
        
        if ( level.minplunderextractions < level.maxplunderextractions )
        {
            level.maxplunderextractions = randomintrange( level.minplunderextractions, level.maxplunderextractions + 1 );
        }
    }
    
    if ( !getdvarint( @"hash_28df7f89e6eab57c", 0 ) || !getdvarint( @"scr_ssc_enabled", 1 ) )
    {
        extractinstances = br_plunder::getallextractspawninstances();
        
        if ( extractinstances.size > 0 )
        {
            extractinstances = _getlocationscircleinfluencedwithnoise( extractinstances, level.maxplunderextractions, isdefined( level.paddedquadgridcenterpoints ) );
            
            if ( extractinstances.size > 0 )
            {
                br_plunder::setextractspawninstances( extractinstances );
            }
        }
    }
    
    ambulancestructs = utility::getstructarray( "br_respawn_station", "targetname" );
    
    for ( i = 0; i < ambulancestructs.size ; i++ )
    {
        wait spawn_interval_seconds;
        br_respawn::spawnambulance( ambulancestructs[ i ] );
    }
    
    var_85ce60d9761963 = getdvarint( @"hash_3a7e96b56579724d", var_8f80f5f0b7711e94 );
    mobileinstances = utility::getstructarray( "br_mobile_armory_location", "targetname" );
    
    if ( mobileinstances.size > 0 )
    {
        var_68710e0d7759bd08 = _getrandomlocations( mobileinstances, var_85ce60d9761963 );
        
        for ( i = 0; i < var_68710e0d7759bd08.size ; i++ )
        {
            wait spawn_interval_seconds;
            br_mobile_armory::spawnmobilearmory( var_68710e0d7759bd08[ i ] );
        }
    }
    
    var_7f27afc68e33f9ca = getdvarint( @"hash_8b6e7b7f2fa8c4a5", var_547c2706b5e8888c );
    truckinstances = utility::getstructarray( "br_satellite_truck_location", "targetname" );
    
    if ( truckinstances.size > 0 )
    {
        satellitetruckstructs = _getrandomlocations( truckinstances, var_7f27afc68e33f9ca );
        
        for ( i = 0; i < satellitetruckstructs.size ; i++ )
        {
            wait spawn_interval_seconds;
            br_satellite_truck::spawnsatellitetruck( satellitetruckstructs[ i ] );
        }
    }
    
    flags::gameflagset( "POIs_spawned" );
    level notify( #"pois_spawned" );
}

// Namespace br_functional_poi
// Params 3
// Checksum 0x9479d043, Offset: 0x647
// Size: 0x1c0
function _getlocationscircleinfluencedwithnoise( allspawninstances, maxinstancecount, var_e7e12097cc79f110 )
{
    if ( allspawninstances.size == 0 || maxinstancecount == 0 )
    {
        return;
    }
    
    if ( maxinstancecount > allspawninstances.size )
    {
        maxinstancecount = allspawninstances.size;
    }
    
    gametype = game_utility::getgametype();
    
    if ( gametype == "plunder" && ( level.mapname == "mp_saba" || level.mapname == "mp_saba2" ) || gametype == "risk" )
    {
        return [[ utility::getsharedfunc( #"plunder", #"getplunderextractlocations" ) ]]( allspawninstances, maxinstancecount, var_e7e12097cc79f110 );
    }
    else if ( !( isdefined( level.br_circle ) && isdefined( level.br_level ) ) )
    {
        return _getrandomlocations( allspawninstances, maxinstancecount );
    }
    
    numcircles = level.br_level.br_circlecenters.size - 1;
    noisemax = int( max( 1, numcircles * getdvarfloat( @"br_poi_noise", 1 ) ) );
    
    for ( i = 0; i < allspawninstances.size ; i++ )
    {
        instance = allspawninstances[ i ];
        noise = randomintrange( -1 * noisemax, noisemax + 1 );
        instance.score = br_circle::getcircleindexforpoint( instance.origin ) + noise;
    }
    
    instancessorted = arraysort( allspawninstances, undefined, &comparescore );
    choseninstances = [];
    
    for ( i = 0; i < maxinstancecount ; i++ )
    {
        choseninstances[ i ] = instancessorted[ i ];
    }
    
    return utility::array_slice( instancessorted, 0, maxinstancecount );
}

// Namespace br_functional_poi
// Params 2
// Checksum 0xdb24824e, Offset: 0x810
// Size: 0x2c, Type: bool
function comparescore( left, right )
{
    return left.score > right.score;
}

// Namespace br_functional_poi
// Params 2
// Checksum 0x2740658c, Offset: 0x845
// Size: 0x7e
function _getrandomlocations( var_d301a250866cda5a, maxlocations )
{
    if ( var_d301a250866cda5a.size == 0 || maxlocations == 0 )
    {
        return;
    }
    
    spawnstructs = [];
    
    if ( var_d301a250866cda5a.size > 0 )
    {
        var_d301a250866cda5a = arrayrandomize( var_d301a250866cda5a );
        newarraysize = int( min( maxlocations, var_d301a250866cda5a.size ) );
        
        for ( i = 0; i < newarraysize ; i++ )
        {
            spawnstructs[ spawnstructs.size ] = var_d301a250866cda5a[ i ];
        }
    }
    
    return spawnstructs;
}

// Namespace br_functional_poi
// Params 4
// Checksum 0xddb589f0, Offset: 0x8cc
// Size: 0x130
function showmiscmessagetoteam( team, messageref, var_ab93cb76c976b7b2, var_c05a7d5279f42ef )
{
    if ( isdefined( team ) )
    {
        message_table = "mp/hints.csv";
        col_ref_name = 1;
        messagerow = tablelookuprownum( message_table, col_ref_name, messageref );
        var_9b9b0489fba30e82 = undefined;
        
        if ( isdefined( var_c05a7d5279f42ef ) )
        {
            var_9b9b0489fba30e82 = gettime() + var_c05a7d5279f42ef;
            
            /#
                var_8e42e5c3afffc31 = 3;
                timerenabled = int( tablelookupbyrow( message_table, messagerow, var_8e42e5c3afffc31 ) );
                assert( timerenabled );
            #/
        }
        
        teamplayers = teams::getteamdata( team, "players" );
        
        foreach ( squadmember in teamplayers )
        {
            squadmember lower_message::setlowermessageomnvar( messageref, var_9b9b0489fba30e82, var_ab93cb76c976b7b2 );
        }
    }
}

// Namespace br_functional_poi
// Params 1
// Checksum 0xae517b03, Offset: 0xa04
// Size: 0x46
function initstatemachineforpoitype( poitype )
{
    if ( !isdefined( level.poistates ) )
    {
        level.poistates = [];
    }
    
    assert( !isdefined( level.poistates[ poitype ] ) );
    level.poistates[ poitype ] = [];
}

// Namespace br_functional_poi
// Params 5
// Checksum 0xebcf06c, Offset: 0xa52
// Size: 0xbe
function registerstatecallbacksforpoitype( poitype, stateid, onentercallback, var_731eb949777976c9, onexitcallback )
{
    assert( isdefined( level.poistates[ poitype ] ) );
    assert( !isdefined( level.poistates[ poitype ][ stateid ] ) );
    level.poistates[ poitype ][ stateid ] = spawnstruct();
    level.poistates[ poitype ][ stateid ].onenter = onentercallback;
    level.poistates[ poitype ][ stateid ].onupdate = var_731eb949777976c9;
    level.poistates[ poitype ][ stateid ].onexit = onexitcallback;
}

// Namespace br_functional_poi
// Params 2
// Checksum 0x1b5cf23f, Offset: 0xb18
// Size: 0xf7
function gotopoistate( poitype, newstate )
{
    poiobject = self;
    
    if ( isdefined( poiobject.currentstate ) )
    {
        statecallbacks = level.poistates[ poitype ][ poiobject.currentstate ];
        
        if ( isdefined( statecallbacks ) && isdefined( statecallbacks.onexit ) )
        {
            level [[ statecallbacks.onexit ]]( poiobject );
        }
    }
    
    poiobject notify( #"poi_state_change" );
    poiobject.currentstate = newstate;
    statecallbacks = level.poistates[ poitype ][ poiobject.currentstate ];
    
    if ( isdefined( statecallbacks ) )
    {
        if ( isdefined( statecallbacks.onenter ) )
        {
            level [[ statecallbacks.onenter ]]( poiobject );
        }
        
        if ( isdefined( statecallbacks.onupdate ) )
        {
            poiobject thread _poistateupdate( statecallbacks.onupdate );
        }
    }
}

// Namespace br_functional_poi
// Params 3
// Checksum 0x490d380a, Offset: 0xc17
// Size: 0x53
function gotopoistateontimer( poitype, newstate, var_9250f7d5b7c39ee7 )
{
    poiobject = self;
    poiobject endon( #"death" );
    poiobject endon( #"poi_state_change" );
    wait var_9250f7d5b7c39ee7;
    poiobject thread gotopoistate( poitype, newstate );
}

// Namespace br_functional_poi
// Params 0
// Checksum 0xb18a67b1, Offset: 0xc72
// Size: 0x1a
function getcurrentpoistate()
{
    poiobject = self;
    return poiobject.currentstate;
}

// Namespace br_functional_poi
// Params 1
// Checksum 0xbb0f588a, Offset: 0xc95
// Size: 0x58
function _poistateupdate( var_731eb949777976c9 )
{
    poiobject = self;
    poiobject endon( #"death" );
    updatingstate = poiobject.currentstate;
    
    while ( updatingstate == poiobject.currentstate )
    {
        level [[ var_731eb949777976c9 ]]( poiobject );
        waitframe();
    }
}

// Namespace br_functional_poi
// Params 0
// Checksum 0x13686341, Offset: 0xcf5
// Size: 0xd83
function setupmapquadrantcornersandgrid()
{
    if ( !isdefined( level.mapcorners ) )
    {
        waitframe();
    }
    
    xmin = level.mapcorners[ 0 ].origin[ 0 ];
    xmax = level.mapcorners[ 1 ].origin[ 0 ];
    corner0 = ( level.mapcorners[ 0 ].origin[ 0 ], level.mapcorners[ 0 ].origin[ 1 ], level.mapcorners[ 0 ].origin[ 2 ] );
    corner1 = ( level.mapcorners[ 1 ].origin[ 0 ], level.mapcorners[ 0 ].origin[ 1 ], level.mapcorners[ 1 ].origin[ 2 ] );
    
    if ( xmax < xmin )
    {
        corner0 = ( level.mapcorners[ 1 ].origin[ 0 ], level.mapcorners[ 0 ].origin[ 1 ], level.mapcorners[ 1 ].origin[ 2 ] );
        corner1 = ( level.mapcorners[ 0 ].origin[ 0 ], level.mapcorners[ 0 ].origin[ 1 ], level.mapcorners[ 0 ].origin[ 2 ] );
    }
    
    ymin = level.mapcorners[ 0 ].origin[ 1 ];
    ymax = level.mapcorners[ 1 ].origin[ 1 ];
    corner2 = ( level.mapcorners[ 0 ].origin[ 0 ], level.mapcorners[ 1 ].origin[ 1 ], level.mapcorners[ 0 ].origin[ 2 ] );
    corner3 = ( level.mapcorners[ 1 ].origin[ 0 ], level.mapcorners[ 1 ].origin[ 1 ], level.mapcorners[ 1 ].origin[ 2 ] );
    
    if ( ymax < ymin )
    {
        corner2 = ( level.mapcorners[ 1 ].origin[ 0 ], level.mapcorners[ 1 ].origin[ 1 ], level.mapcorners[ 1 ].origin[ 2 ] );
        corner3 = ( level.mapcorners[ 0 ].origin[ 0 ], level.mapcorners[ 1 ].origin[ 1 ], level.mapcorners[ 0 ].origin[ 2 ] );
    }
    
    quadgridcenterpoints = [];
    
    if ( game_utility::isdonetskmap() )
    {
        level.corner3to0dist = abs( distance( corner3, corner0 ) );
        var_b8ef17405cf82232 = level.corner3to0dist / 10;
        corner0 = ( corner0[ 0 ] + var_b8ef17405cf82232, corner0[ 1 ] - var_b8ef17405cf82232, corner0[ 2 ] );
        corner1 = ( corner1[ 0 ] - var_b8ef17405cf82232, corner1[ 1 ] - var_b8ef17405cf82232, corner1[ 2 ] );
        corner2 = ( corner2[ 0 ] - var_b8ef17405cf82232, corner2[ 1 ] + var_b8ef17405cf82232, corner2[ 2 ] );
        corner3 = ( corner3[ 0 ] + var_b8ef17405cf82232, corner3[ 1 ] + var_b8ef17405cf82232, corner3[ 2 ] );
        level.corner3to0dist = abs( distance( corner3, corner0 ) );
        i = 1;
        
        while ( i < 4 )
        {
            posx = i * level.corner3to0dist / 2;
            j = 1;
            
            while ( j < 4 )
            {
                posy = j * level.corner3to0dist / 2;
                centerpointy = ( corner3[ 0 ] + posx / 2, corner3[ 1 ] + posy / 2, 0 );
                quadgridcenterpoints[ quadgridcenterpoints.size ] = centerpointy;
                j += 2;
            }
            
            i += 2;
        }
    }
    
    level.quadgridcenterpoints = [];
    
    if ( level.mapname == "mp_br_mechanics" )
    {
        level.quadgridcenterpoints[ level.quadgridcenterpoints.size ] = ( 3965, 4054, 0 );
        level.quadgridcenterpoints[ level.quadgridcenterpoints.size ] = ( 4069, -4150, 0 );
        level.quadgridcenterpoints[ level.quadgridcenterpoints.size ] = ( -4035, -4074, 0 );
        level.quadgridcenterpoints[ level.quadgridcenterpoints.size ] = ( -4009, 4105, 0 );
    }
    else if ( level.mapname == "mp_br_money" )
    {
        level.quadgridcenterpoints[ level.quadgridcenterpoints.size ] = ( 46569.5, -8170, 0 );
        level.quadgridcenterpoints[ level.quadgridcenterpoints.size ] = ( 56849.5, -8170, 0 );
        level.quadgridcenterpoints[ level.quadgridcenterpoints.size ] = ( 67081.5, -17919.5, 0 );
        level.quadgridcenterpoints[ level.quadgridcenterpoints.size ] = ( 46593, -17919.5, 0 );
    }
    else
    {
        level.quadgridcenterpoints[ level.quadgridcenterpoints.size ] = ( -21299.2, 41779.2, 0 );
        level.quadgridcenterpoints[ level.quadgridcenterpoints.size ] = ( 37683.2, 41779.2, 0 );
        level.quadgridcenterpoints[ level.quadgridcenterpoints.size ] = ( 37683.2, -17203.2, 0 );
        level.quadgridcenterpoints[ level.quadgridcenterpoints.size ] = ( -21299.2, -17203.2, 0 );
    }
    
    level.quadgridcenterpoints = arrayrandomize( level.quadgridcenterpoints );
    quadgridradius = 33704;
    level.quadgridradius2dsq = abs( quadgridradius * quadgridradius );
    
    if ( level.adjusteventdistributionpadding > 0 && game_utility::isdonetskmap() )
    {
        level.randomcorner = randomintrange( 0, 5 );
        var_b8ef17405cf82232 = level.corner3to0dist / 10;
        var_ed7b09821cc6862d = level.corner3to0dist / 100 / level.adjusteventdistributionpadding;
        
        switch ( level.randomcorner )
        {
            case 0:
                padcorner0 = ( corner0[ 0 ] + var_b8ef17405cf82232, corner0[ 1 ] - var_b8ef17405cf82232, corner0[ 2 ] );
                padcorner2 = ( corner2[ 0 ] - var_ed7b09821cc6862d, corner2[ 1 ] + var_ed7b09821cc6862d, corner2[ 2 ] );
                padcorner3 = ( corner3[ 0 ] + var_b8ef17405cf82232, corner3[ 1 ] + var_ed7b09821cc6862d, corner3[ 2 ] );
                break;
            case 1:
                padcorner0 = ( corner0[ 0 ] + var_ed7b09821cc6862d, corner0[ 1 ] - var_b8ef17405cf82232, corner0[ 2 ] );
                padcorner2 = ( corner2[ 0 ] - var_ed7b09821cc6862d, corner2[ 1 ] + var_b8ef17405cf82232, corner2[ 2 ] );
                padcorner3 = ( corner3[ 0 ] + var_ed7b09821cc6862d, corner3[ 1 ] + var_ed7b09821cc6862d, corner3[ 2 ] );
                break;
            case 2:
                padcorner0 = ( corner0[ 0 ] + var_ed7b09821cc6862d, corner0[ 1 ] - var_ed7b09821cc6862d, corner0[ 2 ] );
                padcorner2 = ( corner2[ 0 ] - var_b8ef17405cf82232, corner2[ 1 ] + var_b8ef17405cf82232, corner2[ 2 ] );
                padcorner3 = ( corner3[ 0 ] + var_ed7b09821cc6862d, corner3[ 1 ] + var_b8ef17405cf82232, corner3[ 2 ] );
                break;
            case 3:
                padcorner0 = ( corner0[ 0 ] + var_b8ef17405cf82232, corner0[ 1 ] - var_ed7b09821cc6862d, corner0[ 2 ] );
                padcorner2 = ( corner2[ 0 ] - var_ed7b09821cc6862d, corner2[ 1 ] + var_b8ef17405cf82232, corner2[ 2 ] );
                padcorner3 = ( corner3[ 0 ] + var_b8ef17405cf82232, corner3[ 1 ] + var_b8ef17405cf82232, corner3[ 2 ] );
                break;
            case 4:
                padcorner0 = ( corner0[ 0 ] + var_ed7b09821cc6862d, corner0[ 1 ] - var_ed7b09821cc6862d, corner0[ 2 ] );
                padcorner2 = ( corner2[ 0 ] - var_ed7b09821cc6862d, corner2[ 1 ] + var_ed7b09821cc6862d, corner2[ 2 ] );
                padcorner3 = ( corner3[ 0 ] + var_ed7b09821cc6862d, corner3[ 1 ] + var_ed7b09821cc6862d, corner3[ 2 ] );
                break;
            default:
                padcorner0 = ( corner0[ 0 ] + var_ed7b09821cc6862d, corner0[ 1 ] - var_ed7b09821cc6862d, corner0[ 2 ] );
                padcorner2 = ( corner2[ 0 ] - var_ed7b09821cc6862d, corner2[ 1 ] + var_ed7b09821cc6862d, corner2[ 2 ] );
                padcorner3 = ( corner3[ 0 ] + var_ed7b09821cc6862d, corner3[ 1 ] + var_ed7b09821cc6862d, corner3[ 2 ] );
                break;
        }
        
        var_18acc2d2227067be = [];
        level.paddedquadgridcenterpoints = [];
        level.padcorner3to0dist = abs( distance( padcorner3, padcorner0 ) );
        level.pointinsquarewidth = level.padcorner3to0dist / 2;
        i = 1;
        
        while ( i < 4 )
        {
            posx = i * level.padcorner3to0dist / 2;
            j = 1;
            
            while ( j < 4 )
            {
                posy = j * level.padcorner3to0dist / 2;
                centerpointy = ( padcorner3[ 0 ] + posx / 2, padcorner3[ 1 ] + posy / 2, 0 );
                var_18acc2d2227067be[ var_18acc2d2227067be.size ] = centerpointy;
                j += 2;
            }
            
            i += 2;
        }
        
        if ( level.pushdistributiontowardoppositecorner == 2 )
        {
            level.paddedquadgridcenterpoints = arrayrandomize( var_18acc2d2227067be );
        }
        else
        {
            switch ( level.randomcorner )
            {
                case 0:
                    if ( level.pushdistributiontowardoppositecorner )
                    {
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 2 ];
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 3 ];
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 1 ];
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 0 ];
                    }
                    else
                    {
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 1 ];
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 3 ];
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 2 ];
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 0 ];
                    }
                    
                    break;
                case 1:
                    if ( level.pushdistributiontowardoppositecorner )
                    {
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 0 ];
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 2 ];
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 3 ];
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 1 ];
                    }
                    else
                    {
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 3 ];
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 2 ];
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 0 ];
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 1 ];
                    }
                    
                    break;
                case 2:
                    if ( level.pushdistributiontowardoppositecorner )
                    {
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 1 ];
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 0 ];
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 2 ];
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 3 ];
                    }
                    else
                    {
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 2 ];
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 0 ];
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 1 ];
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 3 ];
                    }
                    
                    break;
                case 3:
                    if ( level.pushdistributiontowardoppositecorner )
                    {
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 3 ];
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 1 ];
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 0 ];
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 2 ];
                    }
                    else
                    {
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 0 ];
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 1 ];
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 3 ];
                        level.paddedquadgridcenterpoints[ level.paddedquadgridcenterpoints.size ] = var_18acc2d2227067be[ 2 ];
                    }
                    
                    break;
                case 4:
                    level.paddedquadgridcenterpoints = arrayrandomize( var_18acc2d2227067be );
                    break;
                default:
                    level.paddedquadgridcenterpoints = arrayrandomize( var_18acc2d2227067be );
                    break;
            }
        }
        
        var_136996396d88372f = abs( distance( padcorner0, padcorner2 ) );
        level.corner0to2dist = var_136996396d88372f;
        var_5839ee1917d44c1 = var_136996396d88372f / 4.5;
        level.paddedquadgridradius2dsq = var_5839ee1917d44c1 * var_5839ee1917d44c1;
    }
}

// Namespace br_functional_poi
// Params 1
// Checksum 0x43e3e211, Offset: 0x1a80
// Size: 0x2bb
function function_7b1715a55588bb9f( allspawninstances )
{
    if ( getdvarint( @"scr_br_kiosk_distribute", 0 ) == 0 )
    {
        return allspawninstances;
    }
    
    var_89978475c0d67390 = getdvarfloat( @"hash_333f89d956059704", 1 );
    var_653cbb886ae5735a = getdvarfloat( @"scr_br_kiosk_distribute_min_dist", 7000 );
    var_dca93365238d6f9e = var_653cbb886ae5735a * var_653cbb886ae5735a;
    filtered = [];
    pois = [];
    
    foreach ( instance in allspawninstances )
    {
        poi_name = poi::poi_findpoioriginisin( instance.origin );
        
        if ( !isdefined( pois[ poi_name ] ) )
        {
            pois[ poi_name ] = [];
        }
        
        pois[ poi_name ][ pois[ poi_name ].size ] = instance;
    }
    
    foreach ( poi in pois )
    {
        kiosks = arrayrandomize( poi );
        filtered[ filtered.size ] = kiosks[ 0 ];
        var_55ea275ea518bab4 = [];
        var_55ea275ea518bab4[ 0 ] = kiosks[ 0 ];
        var_e9397d5d3ac2a73f = int( ceil( kiosks.size / var_89978475c0d67390 ) );
        numfound = 1;
        
        for ( i = 1; i < kiosks.size && numfound < var_e9397d5d3ac2a73f ; i++ )
        {
            nextkiosk = kiosks[ i ];
            valid = 1;
            
            foreach ( poikiosk in var_55ea275ea518bab4 )
            {
                distsq = distance2dsquared( nextkiosk.origin, poikiosk.origin );
                
                if ( distsq < var_dca93365238d6f9e )
                {
                    valid = 0;
                    break;
                }
            }
            
            if ( valid )
            {
                filtered[ filtered.size ] = nextkiosk;
                var_55ea275ea518bab4[ var_55ea275ea518bab4.size ] = nextkiosk;
                numfound++;
            }
        }
    }
    
    return filtered;
}

/#

    // Namespace br_functional_poi
    // Params 0
    // Checksum 0xfce9fb49, Offset: 0x1d44
    // Size: 0x18a, Type: dev
    function rerollkiosks()
    {
        foreach ( armorykiosk in level.br_armory_kiosk.scriptables )
        {
            armorykiosk setscriptablepartstate( "<dev string:x64>", "<dev string:x73>" );
            armorykiosk.visible = undefined;
        }
        
        var_dadeb26e39e1fd94 = getdvarint( @"br_max_armory_kiosk", 65 );
        kioskinstances = br_armory_kiosk::getallspawninstances();
        
        if ( kioskinstances.size > 0 )
        {
            kioskinstances = function_7b1715a55588bb9f( kioskinstances );
            kioskinstances = _getlocationscircleinfluencedwithnoise( kioskinstances, var_dadeb26e39e1fd94, level.buystationsusepaddingdistribution );
            
            if ( kioskinstances.size > 0 )
            {
                br_armory_kiosk::setspawninstances( kioskinstances );
            }
        }
        
        foreach ( armorykiosk in level.br_armory_kiosk.scriptables )
        {
            armorykiosk setscriptablepartstate( "<dev string:x64>", "<dev string:x7a>" );
            armorykiosk.visible = 1;
        }
    }

#/
