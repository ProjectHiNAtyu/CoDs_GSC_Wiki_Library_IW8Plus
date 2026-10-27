// scripts\mp\br\gametypes\br_supply_drops_common.gsc  (hash_250dd6455670190c.gscc) (size: 13671 Bytes / 0x3567 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf91343aa (4178789290)
// size ...... 13671 (0x3567)
// includes .. 10  (offset: 0x324b)
// strings ... 38  (offset: 0x329b)
// dev strs .. 7   (offset: 0x3513)
// exports ... 28  (offset: 0x21e7)
// cseg ...... 0x2fb + 0x1eec (0x21e7)
// imports ... 102 (offset: 0x2647)
// animtree1 . 0   (offset: 0x3567)
// animtree2 . 0   (offset: 0x3567)
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\utility\player;
#using scripts\mp\loot;
#using scripts\mp\loot\common_cache;
#using scripts\mp\objidpoolmanager;

#namespace br_supply_drops_common;

// Namespace br_supply_drops_common
// Params 0
// Checksum 0xd5c1c136, Offset: 0x319
// Size: 0xa9
function init()
{
    level notify( #"br_supply_drops_init" );
    level.var_4280cdebdfea8385 = getdvarint( @"hash_b2f1a70335c6a20b", 17250 );
    level.var_5352f4ffec095d61 = [ "onFirstDrop", "generateFlightPath", "supplyDropFall", "planeDropRun", "spawnDropCrate", "onDropSpawned", "onPlayerEnterGulag", "onPlayerRespawn" ];
    cratedata = airdrop::getleveldata( "br_supply_drops_common" );
    cratedata.hasnointeraction = 1;
    
    /#
        level thread function_24918a7eb1f7319b();
    #/
}

// Namespace br_supply_drops_common
// Params 5
// Checksum 0x50b4b6cb, Offset: 0x3ca
// Size: 0x255
function function_2c34853680769fd9( name, cratemodel, var_ff452e610792da51, onopenfunc, planemodel )
{
    if ( !isdefined( level.supplydroptypes ) )
    {
        level.supplydroptypes = [];
    }
    
    assert( !isdefined( level.supplydroptypes[ name ] ), "<dev string:x24>" );
    level.supplydroptypes[ name ] = spawnstruct();
    level.supplydroptypes[ name ].cratemodel = cratemodel;
    level.supplydroptypes[ name ].funcs = [];
    level.supplydroptypes[ name ].planemodel = planemodel ?? "veh9_mil_air_cargo_plane_wm";
    level.supplydroptypes[ name ].bufferpercent = getdvarfloat( @"hash_c5003af4e1ec5349", 0.3 );
    level.supplydroptypes[ name ].checktimer = getdvarint( @"hash_b35f53a26ed16372", 5 );
    level.supplydroptypes[ name ].var_2fd5afa46e56e8f6 = getdvarint( @"hash_9604835948da8a54", 3 );
    level.supplydroptypes[ name ].userate = getdvarint( @"hash_b995fd166e3ec5b0", 1 );
    level.supplydroptypes[ name ].usetime = getdvarint( @"hash_b663c9a86f4ca8e3", 4 );
    level.supplydroptypes[ name ].name = name;
    
    if ( !var_ff452e610792da51 )
    {
        level.supplydroptypes[ name ].funcs[ "generateFlightPath" ] = &function_1b7be077c2b2d722;
        level.supplydroptypes[ name ].funcs[ "supplyDropFall" ] = &function_2d4cad58d926b801;
        level.supplydroptypes[ name ].funcs[ "planeDropRun" ] = &brSupplyDrop_startPlaneDropRun;
        level.supplydroptypes[ name ].funcs[ "spawnDropCrate" ] = &function_85cc64e2a6e80987;
        level.supplydroptypes[ name ].funcs[ "onOpenFunc" ] = onopenfunc;
    }
    
    return level.supplydroptypes[ name ];
}

// Namespace br_supply_drops_common
// Params 3
// Checksum 0x30494f82, Offset: 0x628
// Size: 0x6e
function function_9d48fde0cd4ee1d5( name, funcname, func )
{
    assert( isdefined( level.supplydroptypes[ name ] ), "<dev string:x5c>" );
    assert( arraycontains( level.var_5352f4ffec095d61, funcname ), "<dev string:x9e>" );
    level.supplydroptypes[ name ].funcs[ funcname ] = func;
}

// Namespace br_supply_drops_common
// Params 2
// Checksum 0x6b423346, Offset: 0x69e
// Size: 0x61
function function_173fd9aeb16272f7( container, opener )
{
    if ( isdefined( container.entity.smokesignal ) && loot_mp::iscontainerempty( container, opener ) )
    {
        container.entity.smokesignal setscriptablepartstate( "smoke_signal", "off", 1 );
    }
}

// Namespace br_supply_drops_common
// Params 0
// Checksum 0xc2877b83, Offset: 0x707
// Size: 0x16e
function function_24918a7eb1f7319b()
{
    /#
        level thread function_1ee287c60c8d366a();
    #/
    
    while ( true )
    {
        wait 2;
        
        if ( getdvar( @"hash_26efc86d59cbd50e", "" ) != "" )
        {
            function_fe46eb5b8c73096a( level.players[ 0 ].origin, getdvar( @"hash_26efc86d59cbd50e", "" ) );
            setdvar( @"hash_26efc86d59cbd50e", "" );
        }
        
        if ( getdvar( @"hash_c3236a6c15b391d3", "" ) != "" )
        {
            brsupplydrop_run( level.players[ 0 ].origin, getdvar( @"hash_c3236a6c15b391d3", "" ) );
            setdvar( @"hash_c3236a6c15b391d3", "" );
        }
        
        if ( getdvar( @"hash_67245232e538d11d", "" ) != "" )
        {
            droptype = getdvar( @"hash_67245232e538d11d", "" );
            dropstruct = level.supplydroptypes[ droptype ];
            
            if ( isdefined( dropstruct ) )
            {
                dropend = level.players[ 0 ].origin;
                [[ dropstruct.funcs[ "spawnDropCrate" ] ]]( dropend, dropstruct );
            }
            
            setdvar( @"hash_67245232e538d11d", "" );
        }
    }
}

// Namespace br_supply_drops_common
// Params 0
// Checksum 0x942b7c86, Offset: 0x87d
// Size: 0x5
function function_1390e81e421284ae()
{
    return 3044;
}

// Namespace br_supply_drops_common
// Params 2
// Checksum 0xbc0c1a27, Offset: 0x88b
// Size: 0x156
function brsupplydrop_run( pos, droptype )
{
    var_6bfb633d93b0f3f2 = level.supplydroptypes[ droptype ];
    planemodel = var_6bfb633d93b0f3f2.planemodel;
    angleoverride = var_6bfb633d93b0f3f2.var_808180820ff93e2b;
    pathstruct = [[ var_6bfb633d93b0f3f2.funcs[ "generateFlightPath" ] ]]( pos, var_6bfb633d93b0f3f2 );
    utility::function_704b6016a179b4ab( var_6bfb633d93b0f3f2.var_1cfadb6bf47bba57, pathstruct );
    dist = distance( pathstruct.startpt, pathstruct.endpt );
    travelspeed = function_1390e81e421284ae();
    time = dist / travelspeed;
    plane = function_bcee8502a3021b84( pathstruct, dist, travelspeed, time, planemodel, angleoverride );
    println( "<dev string:xd8>" );
    plane setscriptablepartstate( "audio_loop", "on", 0 );
    plane setscriptablepartstate( "objective", "active_yellow", 0 );
    plane moveto( plane.endpt, plane.lifetime );
    plane thread [[ var_6bfb633d93b0f3f2.funcs[ "planeDropRun" ] ]]( var_6bfb633d93b0f3f2, pos );
    plane thread function_7395d09b03b49827();
    return plane;
}

// Namespace br_supply_drops_common
// Params 2
// Checksum 0x150f2372, Offset: 0x9ea
// Size: 0x4d
function function_fe46eb5b8c73096a( pos, droptype )
{
    dropstruct = level.supplydroptypes[ droptype ];
    crate = brsupplydrop_spawn( pos, dropstruct );
    level.recentsupplydrop = crate;
    return crate;
}

// Namespace br_supply_drops_common
// Params 2
// Checksum 0x63540419, Offset: 0xa40
// Size: 0x166
function brSupplyDrop_startPlaneDropRun( dropstruct, pos )
{
    self endon( #"death" );
    var_536f6188f71c3845 = self.lifetime;
    var_a6bb3758a6a7729b = var_536f6188f71c3845 * dropstruct.bufferpercent;
    numcrates = 0;
    wait var_a6bb3758a6a7729b;
    
    while ( numcrates < dropstruct.var_2fd5afa46e56e8f6 )
    {
        if ( dropstruct.checktimer < var_536f6188f71c3845 - var_a6bb3758a6a7729b )
        {
            wait dropstruct.checktimer;
        }
        else
        {
            waitframe();
        }
        
        droplocation = function_44e62d6442ee846b( self.origin + self.dir * 500 );
        
        if ( !isdefined( droplocation ) )
        {
            if ( dropstruct.var_d552db893c19ac9d )
            {
                numcrates++;
            }
            
            continue;
        }
        
        crate = brsupplydrop_spawn( droplocation, dropstruct );
        
        if ( !isdefined( crate ) )
        {
            continue;
        }
        
        callback::callback( #"hash_8dfed210571539fe", { #crate:crate } );
        airdrop::function_93131a7c7bf0090e( crate, [ "self.origin":self.origin, "func":"brSupplyDrop_startPlaneDropRun" ] );
        
        if ( numcrates == 0 && isdefined( dropstruct.funcs[ "onFirstDrop" ] ) )
        {
            [[ dropstruct.funcs[ "onFirstDrop" ] ]]();
        }
        
        numcrates++;
    }
}

// Namespace br_supply_drops_common
// Params 1
// Checksum 0x289c4cdb, Offset: 0xbae
// Size: 0x155
function function_a7c1f6ae48352dfa( dropstruct )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    var_536f6188f71c3845 = self.lifetime;
    assert( dropstruct.var_2fd5afa46e56e8f6 == 1, "<dev string:x112>" );
    var_355c7bba09a42578 = ( self.centerpt[ 0 ], self.centerpt[ 1 ], level.var_4280cdebdfea8385 );
    var_c024fa2d18730787 = function_44e62d6442ee846b( var_355c7bba09a42578 );
    dropstartlocation = ( var_c024fa2d18730787[ 0 ], var_c024fa2d18730787[ 1 ], level.var_4280cdebdfea8385 );
    var_d8f2bbbb76aa6e08 = distance( self.origin, dropstartlocation );
    
    while ( true )
    {
        var_83a22d2a2a1a24cc = distance( self.origin, self.startpt );
        
        if ( var_83a22d2a2a1a24cc >= var_d8f2bbbb76aa6e08 )
        {
            break;
        }
        
        waitframe();
    }
    
    crate = brsupplydrop_spawn( var_c024fa2d18730787, dropstruct );
    
    if ( crate )
    {
        callback::callback( #"hash_8dfed210571539fe", { #crate:crate } );
    }
    
    if ( isdefined( dropstruct.funcs[ "onFirstDrop" ] ) )
    {
        [[ dropstruct.funcs[ "onFirstDrop" ] ]]();
    }
}

// Namespace br_supply_drops_common
// Params 2
// Checksum 0x2eb4b769, Offset: 0xd0b
// Size: 0x180
function function_44e62d6442ee846b( starttrace, var_18098096b98f2793 )
{
    droplocation = undefined;
    endtrace = starttrace - ( 0, 0, 30000 );
    ignorelist = isent( self ) ? [ self ] : [];
    contents = trace::create_contents( 0, 1, 1, 1, 0, 0, 1, 1, 1 );
    trace = trace::ray_trace( starttrace, endtrace, ignorelist, contents );
    
    if ( isdefined( trace ) && trace[ "hittype" ] != "hittype_none" )
    {
        pos = trace[ "position" ];
        pos = br_circle::function_7816347ed744dd74( pos );
        droplocation = isnavmeshloaded() ? getclosestpointonnavmesh( pos ) : pos;
        diff2d = droplocation - pos;
        diff2d = ( diff2d[ 0 ], diff2d[ 1 ], 0 );
        maxoffset = 100;
        
        if ( length2dsquared( diff2d ) > maxoffset * maxoffset )
        {
            diff2d += vectornormalize( diff2d ) * getdvarint( @"hash_ada223fd974a9d0b", maxoffset );
        }
        
        newpos = br_public::droptogroundmultitrace( droplocation + diff2d, 10500 );
        droplocation = isnavmeshloaded() ? getclosestpointonnavmesh( newpos ) : newpos;
    }
    
    if ( isdefined( droplocation ) && !var_18098096b98f2793 )
    {
        validpoint = isdmzgamemode() || br_circle::isvalidpointinbounds( droplocation, 1 );
        
        if ( !validpoint )
        {
            droplocation = undefined;
        }
    }
    
    return droplocation;
}

// Namespace br_supply_drops_common
// Params 2
// Checksum 0x4762e4e2, Offset: 0xe94
// Size: 0x158
function function_1b7be077c2b2d722( centerpos, dropstruct )
{
    r = level.br_level.br_circleradii[ 0 ] ?? 50000;
    pathangle = dropstruct.pathangle ?? randomfloatrange( 0, 360 );
    planeheight = dropstruct.planeheight ?? level.var_4280cdebdfea8385;
    zheight = planeheight;
    
    if ( isdefined( dropstruct.zoffset ) )
    {
        zheight += dropstruct.zoffset;
    }
    
    toedge = ( r * cos( pathangle ), r * sin( pathangle ), zheight );
    startpt = toedge + centerpos;
    startpt = ( startpt[ 0 ], startpt[ 1 ], zheight );
    endpt = centerpos - toedge;
    endpt = ( endpt[ 0 ], endpt[ 1 ], zheight );
    pathdir = vectornormalize( endpt - startpt );
    pathstruct = spawnstruct();
    pathstruct.startpt = startpt;
    pathstruct.endpt = endpt;
    pathstruct.angle = vectortoangles( pathdir );
    pathstruct.centerpt = centerpos;
    return pathstruct;
}

// Namespace br_supply_drops_common
// Params 0
// Checksum 0xb9bb69cc, Offset: 0xff5
// Size: 0xa5
function function_7395d09b03b49827()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    wait max( self.lifetime - 1, 0.05 );
    self setscriptablepartstate( "audio_exit", "on", 0 );
    wait 1;
    self setscriptablepartstate( "audio_loop", "off", 0 );
    
    if ( isdefined( self.minimapid ) )
    {
        objidpoolmanager::returnobjectiveid( self.minimapid );
    }
    
    if ( isdefined( self.chassis ) )
    {
        self.chassis delete();
    }
    
    if ( isdefined( self ) )
    {
        self delete();
    }
    
    println( "<dev string:x17e>" );
}

// Namespace br_supply_drops_common
// Params 6
// Checksum 0x60949d20, Offset: 0x10a2
// Size: 0x15a
function function_bcee8502a3021b84( pathinfo, pathdist, pathspeed, pathtime, model = "veh9_mil_air_cargo_plane_wm", angleoverride )
{
    plane = spawn( "script_model", pathinfo.startpt );
    plane setmodel( model );
    plane setcandamage( 0 );
    plane.maxhealth = 100000;
    plane.health = plane.maxhealth;
    plane.startpt = pathinfo.startpt;
    plane.endpt = pathinfo.endpt;
    plane.centerpt = pathinfo.centerpt;
    plane.dir = vectornormalize( plane.endpt - plane.startpt );
    plane.angles = angleoverride ? angleoverride : vectortoangles( plane.dir );
    plane.pathdist = pathdist;
    plane.speed = pathspeed;
    plane.lifetime = pathtime;
    return plane;
}

// Namespace br_supply_drops_common
// Params 3
// Checksum 0x6282fce4, Offset: 0x1205
// Size: 0x108
function function_85cc64e2a6e80987( dropend, dropstruct, dropstart )
{
    c130height = level.var_4280cdebdfea8385;
    
    if ( !isdefined( dropstart ) )
    {
        dropstart = ( dropend[ 0 ], dropend[ 1 ], c130height );
    }
    
    crate = spawn( "script_model", dropstart );
    crate setmodel( dropstruct.cratemodel );
    crate.physicsactivated = 0;
    crate.isdestroyed = 0;
    crate.id = "care_package";
    crate.userate = dropstruct.userate;
    crate.curprogress = 0;
    crate.usetime = dropstruct.usetime;
    crate.onopenfunc = dropstruct.onopenfunc;
    crate.supportsreroll = 0;
    crate.cratetype = "br_supply_drops_common";
    return crate;
}

// Namespace br_supply_drops_common
// Params 2
// Checksum 0xe9bd3ed4, Offset: 0x1316
// Size: 0x132
function brsupplydrop_spawn( dropend, dropstruct )
{
    crate = undefined;
    
    if ( isdefined( dropstruct.funcs[ "spawnDropCrate" ] ) )
    {
        crate = [[ dropstruct.funcs[ "spawnDropCrate" ] ]]( dropend, dropstruct );
    }
    
    if ( isdefined( crate ) )
    {
        crate.skipminimapicon = 1;
        
        if ( !crate.nochute )
        {
            chute = spawn( "script_model", crate.origin );
            chute.angles = crate.angles;
            chute setmodel( "veh9_mil_lnd_parachute_carepackage_br" );
            crate.chute = chute;
            crate.var_58f58ae1d854e3e4 = 1;
            chute linkto( crate );
        }
        
        if ( isdefined( dropstruct.funcs[ "onDropSpawned" ] ) )
        {
            crate thread [[ dropstruct.funcs[ "onDropSpawned" ] ]]( dropend );
        }
        
        if ( isdefined( dropstruct.funcs[ "supplyDropFall" ] ) )
        {
            crate thread [[ dropstruct.funcs[ "supplyDropFall" ] ]]( dropend, dropstruct );
        }
    }
    
    return crate;
}

// Namespace br_supply_drops_common
// Params 2
// Checksum 0xa1386285, Offset: 0x1451
// Size: 0x3aa
function function_2d4cad58d926b801( point, dropstruct )
{
    self endon( #"death" );
    var_c491715796150d41 = dropstruct.var_c491715796150d41 ?? 10000000;
    initialmove = dropstruct.initialmove ?? 1000;
    spawnsmoke = dropstruct.spawnsmoke ?? 1;
    
    if ( initialmove > 0 )
    {
        pointoffset = utility::randomvector( 1 ) * initialmove;
        point = br_public::droptogroundmultitrace( point + pointoffset );
    }
    
    if ( dropstruct.var_9a2df96a0970a4e0 )
    {
        thread function_ea6a8669df1a4287();
    }
    
    for ( heightsq = distancesquared( br_public::droptogroundmultitrace( self.origin, -100 ), self.origin ); heightsq > var_c491715796150d41 && !self.var_dbd8dfc4d8cbaf6c ; heightsq = distancesquared( br_public::droptogroundmultitrace( self.origin, -100 ), self.origin ) )
    {
        thread function_cd29f68044faf925( point, dropstruct );
        waitframe();
    }
    
    if ( dropstruct.var_7158594dcc2a08d6 && !self.var_dbd8dfc4d8cbaf6c )
    {
        for ( var_63a7617b61cb0c7 = distance2dsquared( self.origin, point ); var_63a7617b61cb0c7 > 10 && !self.var_dbd8dfc4d8cbaf6c ; var_63a7617b61cb0c7 = distance2dsquared( self.origin, point ) )
        {
            thread function_cd29f68044faf925( point, dropstruct, 1 );
            waitframe();
        }
    }
    
    self notify( #"hash_c9163588a1bf092e" );
    self.var_b66632a68cf546ce = undefined;
    self.var_dbd8dfc4d8cbaf6c = undefined;
    
    if ( dropstruct.var_663eca905dad71dd )
    {
        return;
    }
    
    if ( isdefined( self.chute ) )
    {
        self.chute delete();
    }
    
    if ( !self.physicsactivated )
    {
        self unlink();
        self physicslaunchserver( ( 0, 0, 0 ), ( 0, 0, 0 ) );
        bodyid = self physics_getbodyid( 0 );
        physics_setbodycenterofmassnormal( bodyid, ( 0, 0, -0.75 ) );
        self.physicsactivated = 1;
    }
    
    endpos = br_public::droptogroundmultitrace( self.origin, 25, -20000 );
    self physics_registerforcollisioncallback();
    
    if ( !self.monitoringimpact )
    {
        thread airdrop::monitorimpactinternal( 0.1 );
    }
    
    if ( spawnsmoke )
    {
        scriptable = self.smokescriptable ?? "ks_airdrop_crate_dmz";
        self.smokesignal = spawn( "script_model", endpos );
        self.smokesignal setmodel( scriptable );
        self.smokesignal setscriptablepartstate( "smoke_signal", "on", 0 );
    }
    
    wait 3;
    
    if ( !dropstruct.var_7aab74785fcbe440 )
    {
        if ( self getscriptablehaspart( "dmz_supply_drop" ) )
        {
            self setscriptablepartstate( "dmz_supply_drop", "usable" );
        }
        else
        {
            self setscriptablepartstate( "body", "partially_open_usable" );
        }
    }
    
    childthread airdrop::monitoraveragevelocities( 0.1, 8 );
    settlecount = 0;
    
    while ( true )
    {
        wait 0.1;
        avlinvel = airdrop::getaveragelinearvelocity();
        avangvel = airdrop::getaverageangularvelocity();
        
        if ( !( isdefined( avlinvel ) && isdefined( avangvel ) ) )
        {
            continue;
        }
        
        if ( avlinvel > airdrop::function_31b29cacaf6712bc() || avangvel > airdrop::function_a8eef8b3fdb0f7d5() )
        {
            settlecount = 0;
            continue;
        }
        
        settlecount++;
        
        if ( settlecount != airdrop::function_a28d377e7109bc81() )
        {
            continue;
        }
        
        self.physicssettled = 1;
        break;
    }
}

// Namespace br_supply_drops_common
// Params 0
// Checksum 0x6ce56fc8, Offset: 0x1803
// Size: 0x38
function function_ea6a8669df1a4287()
{
    self endon( #"death" );
    self endon( #"hash_c9163588a1bf092e" );
    wait 3;
    self waittill( #"collision" );
    self.var_dbd8dfc4d8cbaf6c = 1;
}

// Namespace br_supply_drops_common
// Params 3
// Checksum 0xeac95914, Offset: 0x1843
// Size: 0x25e
function function_cd29f68044faf925( point, dropstruct, var_7158594dcc2a08d6 = 0 )
{
    self endon( #"death" );
    self endon( #"hash_c9163588a1bf092e" );
    
    if ( isdefined( self.var_b66632a68cf546ce ) )
    {
        return;
    }
    
    self.var_b66632a68cf546ce = 1;
    timestep = dropstruct.timestep ?? 3;
    vertbase = dropstruct.vertbase ?? 400;
    var_30cb3e606750fb2d = dropstruct.var_30cb3e606750fb2d ?? 100;
    vertbonus = dropstruct.vertbonus ?? 100;
    var_d51f27c0c0b1350f = dropstruct.var_d51f27c0c0b1350f ?? 500;
    
    if ( var_7158594dcc2a08d6 )
    {
        downdist = randomfloat( vertbonus ) + vertbase;
        dir = point - self.origin;
        topoint = ( dir[ 0 ], dir[ 1 ], 0 - downdist );
        startpoint = self.origin;
    }
    else
    {
        downdist = randomfloat( vertbonus ) + vertbase;
        horizdist = randomfloat( var_d51f27c0c0b1350f ) + var_30cb3e606750fb2d;
        dir = point - self.origin;
        dir2d = vectornormalize( ( dir[ 0 ], dir[ 1 ], 0 ) );
        topoint = ( dir2d[ 0 ] * horizdist, dir2d[ 1 ] * horizdist, 0 - downdist );
        startpoint = self.origin;
    }
    
    timer = 0;
    
    while ( true )
    {
        dt = level.framedurationseconds;
        t = timer / timestep;
        lrscalar = t * t * ( 3 - 2 * t );
        udscalar = t * t * 0.5 + 0.5 * t;
        
        if ( !( isdefined( topoint ) && isdefined( lrscalar ) && isdefined( udscalar ) ) )
        {
            break;
        }
        
        scaledvec = ( topoint[ 0 ] * lrscalar, topoint[ 1 ] * lrscalar, topoint[ 2 ] * udscalar );
        self.origin = startpoint + scaledvec;
        timer += dt;
        
        if ( timer >= timestep )
        {
            break;
        }
        
        waitframe();
    }
    
    self.var_b66632a68cf546ce = undefined;
}

// Namespace br_supply_drops_common
// Params 6
// Checksum 0xe0b68d71, Offset: 0x1aa9
// Size: 0x1e6
function brsupplydrop_oncrateuse( instance, part, state, player, bautouse, usestring )
{
    if ( !instance.entity.open )
    {
        if ( instance.entity oncrateuseinternal( player ) )
        {
            instance.entity.open = 1;
            instance.entity.playerusing = undefined;
            instance.entity notify( #"crate_opened" );
        }
        else
        {
            return;
        }
    }
    
    if ( isdefined( instance.entity.smokesignal ) && !isdefined( instance.onclosedcallback ) )
    {
        instance.onclosedcallback = &function_173fd9aeb16272f7;
    }
    
    instance setscriptablepartstate( "dmz_supply_drop", "partially_open_in_use_unusable" );
    
    if ( isdefined( instance.entity.onopenfunc ) )
    {
        [[ instance.entity.onopenfunc ]]( instance, player );
    }
    
    if ( isdefined( level.var_a1d33fd45f933eca ) )
    {
        instance [[ level.var_a1d33fd45f933eca ]]( player );
    }
    
    items = getscriptablelootcachecontents( instance );
    callback::callback( "player_open_supply_drop", { #cache:instance, #player:player } );
    
    if ( !isdefined( instance.contents ) )
    {
        instance.containertype = 3;
        common_cache::function_a09e7cf5bad99b64( instance, items, 1 );
    }
    
    common_cache::function_60ce579fa7d3b6da( instance, part, state, player, bautouse, usestring );
    
    if ( !isdefined( player.lootcachesopened ) )
    {
        player.lootcachesopened = 1;
        return;
    }
    
    player.lootcachesopened++;
}

// Namespace br_supply_drops_common
// Params 1
// Checksum 0x48244621, Offset: 0x1c97
// Size: 0x158, Type: bool
function oncrateuseinternal( player )
{
    player endon( #"disconnect" );
    player endon( #"joined_team" );
    player endon( #"joined_spectators" );
    self endon( #"crate_opened" );
    level endon( #"game_ended" );
    
    if ( self.playerusing )
    {
        return false;
    }
    
    thread function_d239a23a07df64b8( player );
    
    while ( isdefined( player ) && player player::isreallyalive() && cankeepusingcrate( player ) && player usebuttonpressed() )
    {
        if ( !isdefined( self.playerusing ) )
        {
            self.playerusing = 1;
        }
        
        self.curprogress += level.framedurationseconds * self.userate;
        
        if ( self.curprogress >= self.usetime )
        {
            self.curprogress = 0;
            stopusingcrate( player );
            return true;
        }
        
        if ( utility::issharedfuncdefined( #"airdrop", #"updateuiprogress" ) )
        {
            player [[ utility::getsharedfunc( #"airdrop", #"updateuiprogress" ) ]]( self, 1 );
        }
        
        waitframe();
    }
    
    self.playerusing = undefined;
    stopusingcrate( player );
    self.curprogress = 0;
    return false;
}

// Namespace br_supply_drops_common
// Params 1
// Checksum 0xcdac3f26, Offset: 0x1df8
// Size: 0x46
function function_d239a23a07df64b8( player )
{
    level endon( #"game_ended" );
    self endon( #"crate_opened" );
    player utility::waittill_any( "disconnect", "joined_team", "joined_spectators" );
    self.playerusing = undefined;
}

// Namespace br_supply_drops_common
// Params 1
// Checksum 0x2086da56, Offset: 0x1e46
// Size: 0x46
function stopusingcrate( player )
{
    if ( utility::issharedfuncdefined( #"airdrop", #"updateuiprogress" ) )
    {
        player [[ utility::getsharedfunc( #"airdrop", #"updateuiprogress" ) ]]( self, 0 );
    }
}

// Namespace br_supply_drops_common
// Params 1
// Checksum 0x3de361e9, Offset: 0x1e94
// Size: 0x6e, Type: bool
function cankeepusingcrate( player )
{
    if ( !player player::isreallyalive() )
    {
        return false;
    }
    
    if ( player meleebuttonpressed() )
    {
        return false;
    }
    
    if ( player isinexecutionvictim() )
    {
        return false;
    }
    
    if ( player ismeatshieldvictim() )
    {
        return false;
    }
    
    if ( player.inlaststand )
    {
        return false;
    }
    
    if ( distancesquared( player.origin, self.origin ) >= 10000 )
    {
        return false;
    }
    
    return true;
}

// Namespace br_supply_drops_common
// Params 0
// Checksum 0xbb2b116d, Offset: 0x1f0b
// Size: 0xab
function function_7839510c13750e83()
{
    if ( !isdefined( level.supplydroptypes ) )
    {
        return;
    }
    
    foreach ( dropstruct in level.supplydroptypes )
    {
        if ( isdefined( dropstruct.funcs[ "onPlayerEnterGulag" ] ) )
        {
            self [[ dropstruct.funcs[ "onPlayerEnterGulag" ] ]]();
        }
    }
}

// Namespace br_supply_drops_common
// Params 0
// Checksum 0xed317676, Offset: 0x1fbe
// Size: 0xab
function function_f3eb6eaf154a9ee3()
{
    if ( !isdefined( level.supplydroptypes ) )
    {
        return;
    }
    
    foreach ( dropstruct in level.supplydroptypes )
    {
        if ( isdefined( dropstruct.funcs[ "onPlayerRespawn" ] ) )
        {
            self thread [[ dropstruct.funcs[ "onPlayerRespawn" ] ]]();
        }
    }
}

/#

    // Namespace br_supply_drops_common
    // Params 0
    // Checksum 0x1c8371af, Offset: 0x2071
    // Size: 0x176, Type: dev
    function function_1ee287c60c8d366a()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            val = getdvarint( @"scr_supply_drop_test", 0 );
            
            if ( val )
            {
                setdvar( @"scr_supply_drop_test", 0 );
                
                if ( !isdefined( level.recentsupplydrop ) )
                {
                    continue;
                }
                
                selectedplayer = undefined;
                
                foreach ( player in level.players )
                {
                    if ( isbot( player ) )
                    {
                        selectedplayer = player;
                        break;
                    }
                }
                
                if ( !isdefined( selectedplayer ) )
                {
                    continue;
                }
                
                forward = anglestoforward( level.recentsupplydrop.angles );
                pos = level.recentsupplydrop.origin + forward * 35;
                groundpos = br_public::droptogroundmultitrace( pos );
                selectedplayer setorigin( groundpos );
                waitframe();
                selectedplayer botlookatpoint( level.recentsupplydrop.origin, 11 );
                waitframe();
                selectedplayer botpressbutton( "<dev string:x1cd>", 20 );
            }
            
            waitframe();
        }
    }

#/
