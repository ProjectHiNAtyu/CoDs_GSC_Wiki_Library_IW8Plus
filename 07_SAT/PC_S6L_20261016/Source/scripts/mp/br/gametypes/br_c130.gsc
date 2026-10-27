// scripts\mp\br\gametypes\br_c130.gsc  (hash_4bff9d64f9f711a3.gscc) (size: 33095 Bytes / 0x8147 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5d4a254f (1565140303)
// size ...... 33095 (0x8147)
// includes .. 22  (offset: 0x7bcb)
// strings ... 67  (offset: 0x7c7b)
// dev strs .. 19  (offset: 0x802b)
// exports ... 68  (offset: 0x5307)
// cseg ...... 0x569 + 0x4d9e (0x5307)
// imports ... 234 (offset: 0x5da7)
// animtree1 . 0   (offset: 0x8147)
// animtree2 . 0   (offset: 0x8147)
#using scripts\common\debug;
#using scripts\common\math;
#using scripts\common\scripted_widgets;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_gametype_truckwar;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_infils_legacy;
#using scripts\mp\br\gametypes\br_infils_util;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\parachute;

#namespace br_c130;

// Namespace br_c130
// Params 0
// Checksum 0xa399ce32, Offset: 0x587
// Size: 0x22
function init()
{
    flags::gameflaginit( "br_ready_to_jump", 0 );
    setdvarifuninitialized( @"hash_4ae50abb410517ab", 2 );
}

// Namespace br_c130
// Params 2
// Checksum 0x258dc732, Offset: 0x5b1
// Size: 0x3e
function spawnc130pathstruct( centeroverride, radiusoverride )
{
    pathparamsstruct = makepathparamsstruct( centeroverride, radiusoverride );
    pathstruct = makepathstruct( pathparamsstruct );
    return pathstruct;
}

// Namespace br_c130
// Params 2
// Checksum 0xa296a197, Offset: 0x5f8
// Size: 0x122
function makepathparamsstruct( centeroverride, radiusoverride )
{
    var_f89d5be7cd32a682 = 160;
    var_f87a45e7cd0c2e68 = 200;
    
    if ( isdefined( centeroverride ) )
    {
        centerpt = centeroverride;
    }
    else
    {
        centerpt = ( 0, 0, 0 );
    }
    
    if ( level.mapname == "mp_torez" )
    {
        var_f89d5be7cd32a682 = 165;
        var_f87a45e7cd0c2e68 = 195;
        centerpt = ( 3000, -2000, 0 );
    }
    
    twopi = 6.28318;
    randomangle = randomfloatrange( 0, 360 );
    endangleoffset = randomfloatrange( var_f89d5be7cd32a682, var_f87a45e7cd0c2e68 );
    
    if ( isdefined( radiusoverride ) )
    {
        r = radiusoverride;
    }
    else
    {
        r = level.br_level.br_circleradii[ 0 ];
    }
    
    paramstruct = spawnstruct();
    paramstruct.r = r;
    paramstruct.randomangle = randomangle;
    paramstruct.endangleoffset = endangleoffset;
    paramstruct.centerpt = centerpt;
    return paramstruct;
}

// Namespace br_c130
// Params 1
// Checksum 0xfe05ee47, Offset: 0x723
// Size: 0x123
function makepathstruct( pathparamsstruct )
{
    r = pathparamsstruct.r;
    randomangle = pathparamsstruct.randomangle;
    endangleoffset = pathparamsstruct.endangleoffset;
    centerpt = pathparamsstruct.centerpt;
    endangle = ( randomangle + endangleoffset ) % 360;
    startpt = ( r * cos( randomangle ), r * sin( randomangle ), parachute::getc130height() ) + centerpt;
    endpt = ( r * cos( endangle ), r * sin( endangle ), parachute::getc130height() ) + centerpt;
    pathdir = vectornormalize( endpt - startpt );
    endpt += pathdir * r;
    startpt -= pathdir * r * 2;
    pathstruct = spawnstruct();
    pathstruct.startpt = startpt;
    pathstruct.endpt = endpt;
    pathstruct.angle = vectortoangles( pathdir );
    return pathstruct;
}

// Namespace br_c130
// Params 1
// Checksum 0x30303204, Offset: 0x84f
// Size: 0xab
function snappointtomapbounds2d( point )
{
    bounds = level.br_level.br_mapbounds;
    
    if ( point[ 0 ] < bounds[ 1 ][ 0 ] )
    {
        point = ( bounds[ 1 ][ 0 ], point[ 1 ], point[ 2 ] );
    }
    else if ( point[ 0 ] > bounds[ 0 ][ 0 ] )
    {
        point = ( bounds[ 0 ][ 0 ], point[ 1 ], point[ 2 ] );
    }
    
    if ( point[ 1 ] < bounds[ 1 ][ 1 ] )
    {
        point = ( point[ 0 ], bounds[ 1 ][ 1 ], point[ 2 ] );
    }
    else if ( point[ 1 ] > bounds[ 0 ][ 1 ] )
    {
        point = ( point[ 0 ], bounds[ 0 ][ 1 ], point[ 2 ] );
    }
    
    return point;
}

// Namespace br_c130
// Params 3
// Checksum 0xa11dff08, Offset: 0x903
// Size: 0x17a
function ray_trace_trigger_radius_2d( start, end, triggerradiusents )
{
    points = [];
    
    foreach ( triggerradiusent in triggerradiusents )
    {
        assert( triggerradiusent.classname == "<dev string:x24>" );
        point = math::function_d7775bc5c201ec83( start, end, triggerradiusent.origin, triggerradiusent.radius );
        points[ points.size ] = point;
    }
    
    closestpt = undefined;
    var_27a4a2c57f9c2b1 = 0;
    
    foreach ( point in points )
    {
        distsq = distance2dsquared( start, point );
        
        if ( !isdefined( closestpt ) || distsq < var_27a4a2c57f9c2b1 )
        {
            closestpt = point;
            var_27a4a2c57f9c2b1 = distsq;
        }
    }
    
    return closestpt;
}

// Namespace br_c130
// Params 2
// Checksum 0xa8b0007c, Offset: 0xa86
// Size: 0x13b
function snappointtooutofboundstriggertrace( startpoint, var_2f76852c884431d9 )
{
    if ( !isdefined( level.outofboundstriggers ) || level.outofboundstriggers.size == 0 )
    {
        return snappointtomapbounds2d( var_2f76852c884431d9 );
    }
    
    if ( !isdefined( level.outofboundstriggersplanetrace ) )
    {
        level.outofboundstriggersplanetrace = level.outofboundstriggers;
    }
    
    contents = physics_createcontents( [ "physicscontents_trigger" ] );
    trace = trace::ray_trace_ents( startpoint, var_2f76852c884431d9, level.outofboundstriggersplanetrace, contents, undefined, undefined, 1 );
    
    if ( trace[ "fraction" ] < 1 )
    {
        var_2f76852c884431d9 = trace[ "position" ];
    }
    
    if ( isdefined( level.outofboundstriggersspawned ) && level.outofboundstriggersspawned.size > 0 && getdvarint( @"hash_b6f6771f7d380c01", 0 ) == 0 )
    {
        var_57ee359f4798a043 = ray_trace_trigger_radius_2d( startpoint, var_2f76852c884431d9, level.outofboundstriggersspawned );
        
        if ( isdefined( var_57ee359f4798a043 ) )
        {
            distsqtrace = distance2dsquared( startpoint, var_2f76852c884431d9 );
            var_a21a4ede4c9e409f = distance2dsquared( startpoint, var_57ee359f4798a043 );
            
            if ( var_a21a4ede4c9e409f < distsqtrace )
            {
                var_2f76852c884431d9 = ( var_57ee359f4798a043[ 0 ], var_57ee359f4798a043[ 1 ], var_2f76852c884431d9[ 2 ] );
            }
        }
    }
    
    return var_2f76852c884431d9;
}

// Namespace br_c130
// Params 1
// Checksum 0x51d18a5d, Offset: 0xbca
// Size: 0xcb
function getplanepathsaferadiusfromcenter( radiusoverride )
{
    var_1fcfc8a1b18f7a7b = level.br_level.var_a8250ecaf9608f68 ?? 0.7;
    var_eb01e133a7abe899 = ( level.br_level.br_mapsize[ 0 ] / 2 + level.br_level.br_mapsize[ 1 ] / 2 ) / 2;
    var_7369adca4b6a4983 = getdvarfloat( @"hash_3c1aaa97c32d3ae2", -1 );
    
    if ( var_7369adca4b6a4983 > 0 )
    {
        var_1fcfc8a1b18f7a7b = var_7369adca4b6a4983;
    }
    
    if ( isdefined( radiusoverride ) )
    {
        var_eb01e133a7abe899 = radiusoverride;
    }
    else if ( isdefined( level.var_8787421bc2a28389 ) )
    {
        var_eb01e133a7abe899 = level.var_8787421bc2a28389;
    }
    
    saferadius = var_1fcfc8a1b18f7a7b * var_eb01e133a7abe899;
    return saferadius;
}

// Namespace br_c130
// Params 0
// Checksum 0x7271a6fd, Offset: 0xc9e
// Size: 0x8c
function function_40c70dc273b74619()
{
    offset = ( 0, 0, 0 );
    
    if ( getdvarint( @"hash_b394d0e649406cc1", 1 ) == 0 )
    {
        return offset;
    }
    
    if ( isdefined( level.br_level.var_b87f1926d764d03a ) )
    {
        offset = level.br_level.var_b87f1926d764d03a;
    }
    
    if ( getdvar( @"hash_ab9afcc6db47793e", "" ) != "" )
    {
        offset = getdvarvector( @"hash_ab9afcc6db47793e", offset );
    }
    
    return offset;
}

// Namespace br_c130
// Params 1
// Checksum 0x3c934084, Offset: 0xd33
// Size: 0x5b, Type: bool
function iswithinplanepathsaferadius( pt )
{
    centerpt = level.br_level.br_mapcenter;
    centerpt += function_40c70dc273b74619();
    saferadius = getplanepathsaferadiusfromcenter();
    dist = distance2d( centerpt, pt );
    return dist < saferadius;
}

// Namespace br_c130
// Params 4
// Checksum 0x85bb4966, Offset: 0xd97
// Size: 0x354
function spawnc130pathstructnew( var_a3c9ad165e5a13d7, radiusoverride, mapcenteroverride, var_a509af2362b11bb2 )
{
    centerpt = level.br_level.br_mapcenter;
    
    if ( getdvarint( @"hash_7bcd9309c87506", 1 ) == 1 )
    {
        if ( br_gametypes::isfeatureenabled( #"hash_157c5a44d6ce8df6" ) )
        {
            centerpt = level.br_level.br_circlecenters[ 1 ];
        }
    }
    
    if ( isdefined( var_a3c9ad165e5a13d7 ) )
    {
        centerpt = var_a3c9ad165e5a13d7;
    }
    else
    {
        centerpt += function_40c70dc273b74619();
    }
    
    saferadius = getplanepathsaferadiusfromcenter( radiusoverride );
    randomyaw = randomfloat( 360 );
    
    if ( br_public::isbrpracticemode() )
    {
        if ( isdefined( level.infilplaneyaw ) )
        {
            randomyaw = level.infilplaneyaw;
        }
        else
        {
            randomyaw = 75;
        }
    }
    
    offsetvec = anglestoforward( ( 0, randomyaw, 0 ) );
    offsetvec *= saferadius * randomfloatrange( -1, 1 );
    offsetvec += ( 0, 0, getc130knownsafeheight() );
    
    if ( !br_gametypes::isfeaturedisabled( #"randomizecirclecenter" ) )
    {
        centerpt += offsetvec;
    }
    
    if ( !br_public::isbrpracticemode() && !br_public::isdmzbotpracticematch() )
    {
        centerpt = getdvarvector( @"hash_3956f0ca6c9c5f89", centerpt );
    }
    
    randomangles = ( 0, randomfloatrange( 0, 360 ), 0 );
    
    if ( br_gametypes::isfeaturedisabled( #"randomizecirclecenter" ) )
    {
        if ( isdefined( var_a509af2362b11bb2 ) )
        {
            offsetvec = anglestoforward( ( 0, randomyaw, 0 ) ) * var_a509af2362b11bb2;
            offsetvec += ( 0, 0, getc130knownsafeheight() );
        }
        
        var_9ba8b2b3b7e42137 = level.br_level.br_mapcenter + offsetvec;
        
        if ( isdefined( mapcenteroverride ) )
        {
            var_9ba8b2b3b7e42137 = mapcenteroverride + offsetvec;
        }
        
        planedir = centerpt - var_9ba8b2b3b7e42137;
        
        if ( utility::cointoss() && getdvarint( @"hash_4a9026a0d0f3719a", 0 ) == 0 )
        {
            planedir *= -1;
        }
        
        planeyaw = vectortoyaw( planedir );
        randomangles = ( 0, planeyaw, 0 );
    }
    
    if ( br_public::isbrpracticemode() )
    {
        randomangles = ( 0, 75, 0 );
    }
    else
    {
        randomangles = ( 0, getdvarfloat( @"hash_7343d5620b46bbc3", randomangles[ 1 ] ), 0 );
    }
    
    var_34c22c12b7584968 = 0;
    
    if ( getdvarint( @"hash_7bcd9309c87506", 1 ) == 1 )
    {
        if ( br_gametypes::isfeatureenabled( #"hash_157c5a44d6ce8df6" ) )
        {
            var_34c22c12b7584968 = 1;
        }
    }
    
    circleradius = level.br_level.br_circleradii[ var_34c22c12b7584968 ];
    
    if ( isdefined( radiusoverride ) )
    {
        circleradius = radiusoverride;
    }
    
    pathradius = circleradius * 2;
    
    if ( br_gametypes::isfeatureenabled( #"planeusecircleradius" ) )
    {
        pathradius = circleradius;
    }
    
    c130height = parachute::getc130height();
    pathstruct = spawnc130pathstructnewinternal( centerpt, randomangles, c130height, pathradius );
    
    /#
        println( "<dev string:x33>" + pathstruct.startpt + "<dev string:x46>" + centerpt + "<dev string:x51>" + pathstruct.endpt );
        println( "<dev string:x60>" + randomangles[ 1 ] + "<dev string:x73>" + pathstruct.pathdir + "<dev string:x7c>" + pathradius );
    #/
    
    return pathstruct;
}

// Namespace br_c130
// Params 4
// Checksum 0xadbd8c6a, Offset: 0x10f4
// Size: 0x268
function spawnc130pathstructnewinternal( centerpt, angles, planeheight, pathradius )
{
    pathdir = anglestoforward( angles );
    
    if ( !isdefined( pathradius ) )
    {
        pathradius = level.br_level.br_circleradii[ 0 ] * 2;
        
        if ( br_public::isbrpracticemode() )
        {
            pathradius = level.br_level.br_circleradii[ 2 ] * 2;
        }
    }
    
    if ( isdefined( level.infil_obstructions ) )
    {
        centerpt = function_f032b4f66402c297( centerpt, pathradius + getc130speed() * getdvarfloat( @"hash_a7872d3e53452e4e", 10 ) );
        pathdir = function_ab4a8ed318d03b04( centerpt, pathdir, pathradius + getc130speed() * getdvarfloat( @"hash_a7872d3e53452e4e", 10 ) );
    }
    
    startpt = centerpt - pathdir * pathradius;
    endpt = centerpt + pathdir * pathradius;
    
    if ( br_gametypes::isfeatureenabled( #"infiluseplaneheightoob" ) )
    {
        startpt += ( 0, 0, planeheight );
        endpt += ( 0, 0, planeheight );
    }
    
    if ( !br_gametypes::isfeaturedisabled( #"planesnaptooob" ) )
    {
        startpt = snappointtooutofboundstriggertrace( centerpt, startpt );
        endpt = snappointtooutofboundstriggertrace( centerpt, endpt );
    }
    
    startptui = startpt;
    endptui = endpt;
    
    if ( br_gametypes::isfeaturedisabled( #"planesnaptooob" ) )
    {
        if ( !ispointinbounds( startpt ) )
        {
            startptui = snappointtooutofboundstriggertrace( centerpt, startpt );
        }
        
        if ( !ispointinbounds( endpt ) )
        {
            endptui = snappointtooutofboundstriggertrace( centerpt, endpt );
        }
    }
    
    pathdir = vectornormalize( endpt - startpt );
    flyintime = function_1a0e2af4b3229059();
    startpt -= pathdir * getc130speed() * flyintime;
    endpt += pathdir * 100000;
    
    if ( br_public::isbrpracticemode() )
    {
        startpt -= pathdir * getc130speed() * 20;
    }
    
    pathstruct = spawnstruct();
    pathstruct.startpt = ( startpt[ 0 ], startpt[ 1 ], planeheight );
    pathstruct.endpt = ( endpt[ 0 ], endpt[ 1 ], planeheight );
    pathstruct.startptui = startptui;
    pathstruct.endptui = endptui;
    pathstruct.angle = angles;
    pathstruct.pathdir = pathdir;
    pathstruct.centerpt = centerpt;
    return pathstruct;
}

// Namespace br_c130
// Params 0
// Checksum 0xfb61c7b9, Offset: 0x1365
// Size: 0x7b
function function_1a0e2af4b3229059()
{
    flyintime = getdvarfloat( @"hash_a7872d3e53452e4e", 10 );
    
    if ( game_utility::getgametype() == "mini" )
    {
        flyintime = getdvarfloat( @"hash_599be2cfeff57084", 2 );
    }
    
    if ( isdefined( level.infilstruct ) && isdefined( level.infilstruct.var_a72a5e92d12b538a ) )
    {
        flyintime += level.infilstruct.var_a72a5e92d12b538a;
    }
    
    return flyintime;
}

// Namespace br_c130
// Params 0
// Checksum 0xfc762974, Offset: 0x13e9
// Size: 0x8e
function getc130speed()
{
    speed = getdvarint( @"hash_4f7a3e87feacf190", -1 );
    
    if ( speed > 0 )
    {
        return speed;
    }
    
    if ( isdefined( level.br_level ) && isdefined( level.br_level.c130_speedoverride ) )
    {
        return level.br_level.c130_speedoverride;
    }
    
    /#
        setdvarifuninitialized( @"hash_c25457fbe123d92f", "<dev string:x87>" );
        
        if ( getdvarint( @"hash_c25457fbe123d92f" ) > 0 )
        {
            return 12000;
        }
    #/
    
    return 3044;
}

// Namespace br_c130
// Params 0
// Checksum 0x20d36c5b, Offset: 0x1480
// Size: 0x5
function getc130knownsafeheight()
{
    return 8000;
}

// Namespace br_c130
// Params 2
// Checksum 0xfa8a91ed, Offset: 0x148e
// Size: 0x6d
function setc130heightoverrides( heightoverride, sealeveloverride )
{
    if ( isdefined( heightoverride ) )
    {
        level.br_level.c130_heightoverride = heightoverride;
    }
    
    if ( isdefined( sealeveloverride ) )
    {
        level.br_level.c130_sealeveloverride = sealeveloverride;
    }
    
    setomnvar( "ui_br_altimeter_c130_height", parachute::getc130height() );
    setomnvar( "ui_br_altimeter_sea_height", parachute::getc130sealevel() );
}

// Namespace br_c130
// Params 1
// Checksum 0x404d9ae1, Offset: 0x1503
// Size: 0xb1
function updatec130pathomnvars( c130path )
{
    if ( !isdefined( c130path ) )
    {
        return;
    }
    
    if ( !( isdefined( c130path.startpt ) && isdefined( c130path.endpt ) && isdefined( c130path.angle ) ) )
    {
        return;
    }
    
    setomnvar( "ui_br_c130_path_start_x", int( c130path.startptui[ 0 ] ) );
    setomnvar( "ui_br_c130_path_start_y", int( c130path.startptui[ 1 ] ) );
    setomnvar( "ui_br_c130_path_end_x", int( c130path.endptui[ 0 ] ) );
    setomnvar( "ui_br_c130_path_end_y", int( c130path.endptui[ 1 ] ) );
}

// Namespace br_c130
// Params 4
// Checksum 0x5f5dbc3a, Offset: 0x15bc
// Size: 0xc9
function createtestc130path( var_a3c9ad165e5a13d7, radiusoverride, mapcenteroverride, var_a509af2362b11bb2 )
{
    self notify( #"hash_c7866a074ee8aff2" );
    
    if ( isdefined( level.br_level.br_mapcenter ) && isdefined( level.br_level.br_mapsize ) )
    {
        pathstruct = spawnc130pathstructnew( var_a3c9ad165e5a13d7, radiusoverride, mapcenteroverride, var_a509af2362b11bb2 );
        level thread br_analytics::branalytics_planepath( pathstruct.centerpt, pathstruct.angle[ 1 ], pathstruct.startptui, pathstruct.endptui );
    }
    else
    {
        pathstruct = spawnc130pathstruct( var_a3c9ad165e5a13d7, radiusoverride );
    }
    
    updatec130pathomnvars( pathstruct );
    return pathstruct;
}

// Namespace br_c130
// Params 2
// Checksum 0xd30bb682, Offset: 0x168e
// Size: 0xce
function register_obstruction( origin, radius )
{
    if ( !isdefined( level.infil_obstructions ) )
    {
        level.infil_obstructions = [];
    }
    
    var_33c577bd26434e24 = { #radius_sq:squared( radius ), #radius:radius, #origin:( origin[ 0 ], origin[ 1 ], parachute::getc130height() ) };
    
    /#
        if ( getdvar( @"hash_8b5049db7521ffbb" ) )
        {
            debug::cylinder( var_33c577bd26434e24.origin, var_33c577bd26434e24.origin + ( 0, 0, 1 ), var_33c577bd26434e24.radius, "<dev string:x88>" );
        }
    #/
    
    level.infil_obstructions[ level.infil_obstructions.size ] = var_33c577bd26434e24;
}

// Namespace br_c130
// Params 2
// Checksum 0x57d81270, Offset: 0x1764
// Size: 0x16e
function register_obstruction_structs( value, key )
{
    if ( !isdefined( level.infil_obstructions ) )
    {
        level.infil_obstructions = [];
    }
    
    var_4f37297c69d386ed = utility::getstructarray( value, key );
    
    foreach ( struct in var_4f37297c69d386ed )
    {
        var_33c577bd26434e24 = { #radius_sq:squared( struct.radius ), #radius:struct.radius, #origin:( struct.origin[ 0 ], struct.origin[ 1 ], parachute::getc130height() ) };
        
        /#
            if ( getdvar( @"hash_8b5049db7521ffbb" ) )
            {
                debug::cylinder( var_33c577bd26434e24.origin, var_33c577bd26434e24.origin + ( 0, 0, 1 ), var_33c577bd26434e24.radius, "<dev string:x88>" );
            }
        #/
        
        level.infil_obstructions[ level.infil_obstructions.size ] = var_33c577bd26434e24;
    }
}

// Namespace br_c130
// Params 2
// Checksum 0x670b125c, Offset: 0x18da
// Size: 0x179
function function_f032b4f66402c297( centerpt, pathradius )
{
    centerpt = ( centerpt[ 0 ], centerpt[ 1 ], parachute::getc130height() );
    
    foreach ( var_33c577bd26434e24 in level.infil_obstructions )
    {
        if ( distancesquared( centerpt, var_33c577bd26434e24.origin ) < var_33c577bd26434e24.radius_sq )
        {
            /#
                if ( getdvar( @"hash_8b5049db7521ffbb" ) )
                {
                    og_center = centerpt;
                    debug::sphere( centerpt, 100, "<dev string:x88>" );
                }
            #/
            
            var_ad2fcbf325b39601 = randomint( 360 );
            pathstruct = function_d17e8047ce0b14e7( var_ad2fcbf325b39601, var_33c577bd26434e24, pathradius );
            
            /#
                if ( getdvar( @"hash_8b5049db7521ffbb" ) )
                {
                    debug::line( og_center, pathstruct.centerpt, "<dev string:x8c>" );
                }
            #/
            
            while ( get_path_obstruction( pathstruct.startpt, pathstruct.endpt ) )
            {
                var_ad2fcbf325b39601 += 10;
                pathstruct = function_d17e8047ce0b14e7( var_ad2fcbf325b39601, var_33c577bd26434e24, pathradius );
                centerpt = pathstruct.centerpt;
            }
        }
    }
    
    return centerpt;
}

// Namespace br_c130
// Params 3
// Checksum 0xba3d8a35, Offset: 0x1a5c
// Size: 0x97
function function_d17e8047ce0b14e7( var_ad2fcbf325b39601, var_33c577bd26434e24, pathradius )
{
    centerpt = var_33c577bd26434e24.origin + anglestoforward( ( 0, var_ad2fcbf325b39601, 0 ) ) * ( var_33c577bd26434e24.radius + 100 );
    pathdir = anglestoright( ( 0, var_ad2fcbf325b39601, 0 ) );
    pathstruct = { #endpt:centerpt + pathdir * pathradius, #centerpt:centerpt, #startpt:centerpt - pathdir * pathradius };
    return pathstruct;
}

// Namespace br_c130
// Params 3
// Checksum 0x5c70e7fb, Offset: 0x1afc
// Size: 0x69
function function_ab4a8ed318d03b04( centerpt, pathdir, pathradius )
{
    startpt = centerpt - pathdir * pathradius;
    endpt = centerpt + pathdir * pathradius;
    var_33c577bd26434e24 = get_path_obstruction( startpt, endpt );
    
    if ( var_33c577bd26434e24 )
    {
        return function_bb9f40ca8b2f9f75( var_33c577bd26434e24, centerpt, startpt, endpt, pathdir, pathradius );
    }
    
    return pathdir;
}

// Namespace br_c130
// Params 2
// Checksum 0x14aebb61, Offset: 0x1b6e
// Size: 0x2ce
function get_path_obstruction( startpt, endpt )
{
    /#
        debug_obstruction = undefined;
    #/
    
    start_adjusted = ( startpt[ 0 ], startpt[ 1 ], parachute::getc130height() );
    end_adjusted = ( endpt[ 0 ], endpt[ 1 ], parachute::getc130height() );
    center_adjusted = ( start_adjusted + end_adjusted ) / 2;
    pathradius = distance2d( start_adjusted, center_adjusted );
    
    foreach ( var_33c577bd26434e24 in level.infil_obstructions )
    {
        if ( math::function_f0bb04c1592d3497( start_adjusted, end_adjusted, var_33c577bd26434e24.origin ) < var_33c577bd26434e24.radius_sq )
        {
            if ( distance2d( center_adjusted, var_33c577bd26434e24.origin ) - var_33c577bd26434e24.radius > pathradius )
            {
                continue;
            }
            
            /#
                if ( getdvar( @"hash_8b5049db7521ffbb" ) )
                {
                    debug::sphere( ( startpt[ 0 ], startpt[ 1 ], parachute::getc130height() ), 100, ( 0, 0.3, 0 ) );
                    debug::sphere( ( endpt[ 0 ], endpt[ 1 ], parachute::getc130height() ), 100, ( 0.3, 0, 0 ) );
                    debug::line( ( startpt[ 0 ], startpt[ 1 ], parachute::getc130height() ), ( endpt[ 0 ], endpt[ 1 ], parachute::getc130height() ), ( 0.3, 0, 0 ) );
                    debug::print3d( ( ( startpt[ 0 ] + endpt[ 0 ] ) / 2, ( startpt[ 1 ] + endpt[ 1 ] ) / 2, parachute::getc130height() ), int( vectortoangles( endpt - startpt )[ 1 ] ), ( 0.3, 0, 0 ), undefined, undefined, undefined, undefined, 50, -2000 );
                }
                
                debug_obstruction = var_33c577bd26434e24;
                continue;
            #/
            
            return var_33c577bd26434e24;
        }
    }
    
    /#
        if ( isdefined( debug_obstruction ) )
        {
            return debug_obstruction;
        }
        
        if ( getdvar( @"hash_8b5049db7521ffbb" ) )
        {
            debug::sphere( ( ( startpt[ 0 ], startpt[ 1 ], parachute::getc130height() ) + ( endpt[ 0 ], endpt[ 1 ], parachute::getc130height() ) ) / 2, 100, "<dev string:x93>" );
            debug::sphere( ( startpt[ 0 ], startpt[ 1 ], parachute::getc130height() ), 100, ( 0, 0.5, 0 ) );
            debug::sphere( ( endpt[ 0 ], endpt[ 1 ], parachute::getc130height() ), 100, ( 0.5, 0, 0 ) );
            debug::line( ( startpt[ 0 ], startpt[ 1 ], parachute::getc130height() ), ( endpt[ 0 ], endpt[ 1 ], parachute::getc130height() ), ( 0.5, 0.5, 0.5 ) );
        }
    #/
}

// Namespace br_c130
// Params 6
// Checksum 0x8d6a423d, Offset: 0x1e45
// Size: 0x861
function function_bb9f40ca8b2f9f75( var_33c577bd26434e24, centerpt, startpt, endpt, pathdir, pathradius )
{
    var_27802af6ba865f36 = [];
    corrected_center = ( centerpt[ 0 ], centerpt[ 1 ], parachute::getc130height() );
    
    foreach ( var_33c577bd26434e24 in level.infil_obstructions )
    {
        var_45b6a1dadf2ebe3a = vectortoangles( var_33c577bd26434e24.origin - corrected_center )[ 1 ];
        dist = distance2d( var_33c577bd26434e24.origin, corrected_center );
        
        if ( distance2d( corrected_center, var_33c577bd26434e24.origin ) - var_33c577bd26434e24.radius > pathradius )
        {
            continue;
        }
        
        yaw_delta = asin( var_33c577bd26434e24.radius / dist );
        s_invalid = { #yaw_max:( var_45b6a1dadf2ebe3a + yaw_delta + 360 ) % 360, #yaw_min:( var_45b6a1dadf2ebe3a - yaw_delta + 360 ) % 360 };
        var_27802af6ba865f36[ var_27802af6ba865f36.size ] = s_invalid;
        s_invalid = { #yaw_max:( var_45b6a1dadf2ebe3a + yaw_delta + 180 + 360 ) % 360, #yaw_min:( var_45b6a1dadf2ebe3a - yaw_delta + 180 + 360 ) % 360 };
        var_27802af6ba865f36[ var_27802af6ba865f36.size ] = s_invalid;
    }
    
    updated = 1;
    
    while ( updated && var_27802af6ba865f36.size >= 2 )
    {
        updated = 0;
        
        for ( i = 0; i < var_27802af6ba865f36.size - 1 ; i++ )
        {
            for ( j = 1; j < var_27802af6ba865f36.size ; j++ )
            {
                corrected_center = ( centerpt[ 0 ], centerpt[ 1 ], parachute::getc130height() );
                var_50211745afbe0e97 = corrected_center + anglestoforward( ( 0, var_27802af6ba865f36[ i ].yaw_min, 0 ) ) * pathradius + ( 0, 0, -1000 );
                var_6ce8c3684e374a01 = corrected_center + anglestoforward( ( 0, var_27802af6ba865f36[ i ].yaw_max, 0 ) ) * pathradius + ( 0, 0, -1000 );
                var_565184cb1963c56 = corrected_center + anglestoforward( ( 0, var_27802af6ba865f36[ j ].yaw_min, 0 ) ) * pathradius + ( 0, 0, -1000 );
                var_2501fa6e7e70d98c = corrected_center + anglestoforward( ( 0, var_27802af6ba865f36[ j ].yaw_max, 0 ) ) * pathradius + ( 0, 0, -1000 );
                var_924416d00a3cd260 = vectornormalize( ( var_50211745afbe0e97 + var_6ce8c3684e374a01 ) / 2 - corrected_center );
                i_min_dot = vectordot( vectornormalize( var_50211745afbe0e97 - corrected_center ), var_924416d00a3cd260 );
                i_max_dot = vectordot( vectornormalize( var_6ce8c3684e374a01 - corrected_center ), var_924416d00a3cd260 );
                j_min_dot = vectordot( vectornormalize( var_565184cb1963c56 - corrected_center ), var_924416d00a3cd260 );
                j_max_dot = vectordot( vectornormalize( var_2501fa6e7e70d98c - corrected_center ), var_924416d00a3cd260 );
                
                if ( i_min_dot < j_min_dot && i_max_dot < j_max_dot )
                {
                    var_27802af6ba865f36 = arrayremove( var_27802af6ba865f36, var_27802af6ba865f36[ j ] );
                    updated = 1;
                    break;
                }
                
                var_92497b78465a1339 = vectornormalize( ( var_565184cb1963c56 + var_2501fa6e7e70d98c ) / 2 - corrected_center );
                i_min_dot = vectordot( vectornormalize( var_50211745afbe0e97 - corrected_center ), var_92497b78465a1339 );
                i_max_dot = vectordot( vectornormalize( var_6ce8c3684e374a01 - corrected_center ), var_92497b78465a1339 );
                j_min_dot = vectordot( vectornormalize( var_565184cb1963c56 - corrected_center ), var_92497b78465a1339 );
                j_max_dot = vectordot( vectornormalize( var_2501fa6e7e70d98c - corrected_center ), var_92497b78465a1339 );
                
                if ( i_min_dot > j_min_dot && i_max_dot > j_max_dot )
                {
                    var_27802af6ba865f36 = arrayremove( var_27802af6ba865f36, var_27802af6ba865f36[ i ] );
                    updated = 1;
                    break;
                }
                
                if ( i_min_dot > j_min_dot && i_max_dot < j_max_dot )
                {
                    var_3106fb9d2e34caa7 = { #yaw_max:var_27802af6ba865f36[ i ].yaw_max, #yaw_min:var_27802af6ba865f36[ j ].yaw_min };
                    var_27802af6ba865f36 = arrayremove( var_27802af6ba865f36, var_27802af6ba865f36[ j ] );
                    var_27802af6ba865f36[ i ] = var_3106fb9d2e34caa7;
                    updated = 1;
                    break;
                }
                
                if ( i_min_dot < j_min_dot && i_max_dot > j_max_dot )
                {
                    var_3106fb9d2e34caa7 = { #yaw_max:var_27802af6ba865f36[ j ].yaw_max, #yaw_min:var_27802af6ba865f36[ i ].yaw_min };
                    var_27802af6ba865f36[ i ] = var_3106fb9d2e34caa7;
                    var_27802af6ba865f36 = arrayremove( var_27802af6ba865f36, var_27802af6ba865f36[ j ] );
                    updated = 1;
                    break;
                }
            }
            
            if ( updated )
            {
                break;
            }
        }
    }
    
    /#
        if ( getdvar( @"hash_8b5049db7521ffbb" ) )
        {
            foreach ( s in var_27802af6ba865f36 )
            {
                corrected_center = ( centerpt[ 0 ], centerpt[ 1 ], parachute::getc130height() );
                debug::line( corrected_center, corrected_center + anglestoforward( ( 0, s.yaw_min, 0 ) ) * pathradius, "<dev string:x99>" );
                debug::line( corrected_center, corrected_center + anglestoforward( ( 0, s.yaw_max, 0 ) ) * pathradius, "<dev string:x99>" );
                debug::line( corrected_center + anglestoforward( ( 0, s.yaw_min, 0 ) ) * pathradius, corrected_center + anglestoforward( ( 0, s.yaw_max, 0 ) ) * pathradius, "<dev string:x88>" );
                debug::print3d( corrected_center + anglestoforward( ( 0, s.yaw_min, 0 ) ) * pathradius, int( s.yaw_min ), "<dev string:x88>", undefined, undefined, undefined, undefined, 50 );
                debug::print3d( corrected_center + anglestoforward( ( 0, s.yaw_max, 0 ) ) * pathradius, int( s.yaw_max ), "<dev string:x88>", undefined, undefined, undefined, undefined, 50 );
            }
        }
    #/
    
    var_1b04e2c6ae4d58d = 360;
    
    foreach ( var_4834e88ec6c91b65 in var_27802af6ba865f36 )
    {
        diff = var_4834e88ec6c91b65.yaw_max - var_4834e88ec6c91b65.yaw_min;
        
        if ( diff < 0 )
        {
            diff += 360;
        }
        
        var_1b04e2c6ae4d58d -= diff;
    }
    
    var_27802af6ba865f36 = arraysort( var_27802af6ba865f36, undefined, &function_77ce7cb91781434b );
    var_339ae55119864ecf = randomfloat( var_1b04e2c6ae4d58d );
    yaw = 0;
    
    for ( i = 0; i < var_27802af6ba865f36.size ; i++ )
    {
        if ( isdefined( var_27802af6ba865f36[ i + 1 ] ) )
        {
            diff = var_27802af6ba865f36[ i + 1 ].yaw_min - var_27802af6ba865f36[ i ].yaw_max;
            
            if ( diff < 0 )
            {
                diff += 360;
            }
            
            if ( var_339ae55119864ecf < diff )
            {
                yaw = var_27802af6ba865f36[ i ].yaw_max + var_339ae55119864ecf;
                break;
            }
            else
            {
                var_339ae55119864ecf -= diff;
            }
            
            continue;
        }
        
        yaw = var_27802af6ba865f36[ i ].yaw_max + var_339ae55119864ecf;
    }
    
    pathdir = anglestoforward( ( 0, yaw, 0 ) );
    
    /#
        if ( getdvar( @"hash_8b5049db7521ffbb" ) )
        {
            corrected_center = ( centerpt[ 0 ], centerpt[ 1 ], parachute::getc130height() );
            debug::line( corrected_center + anglestoforward( ( 0, yaw, 0 ) ) * pathradius, corrected_center + -1 * anglestoforward( ( 0, yaw, 0 ) ) * pathradius, "<dev string:x9e>" );
            debug::sphere( corrected_center, 100, "<dev string:x93>" );
            debug::sphere( corrected_center + anglestoforward( ( 0, yaw, 0 ) ) * pathradius, 100, "<dev string:x88>" );
            debug::sphere( corrected_center + -1 * anglestoforward( ( 0, yaw, 0 ) ) * pathradius, 100, "<dev string:x9e>" );
            debug::print3d( corrected_center, yaw, "<dev string:x9e>", undefined, undefined, undefined, undefined, 50, 500 );
        }
    #/
    
    return pathdir;
}

// Namespace br_c130
// Params 2
// Checksum 0x32490797, Offset: 0x26af
// Size: 0x2c, Type: bool
function function_77ce7cb91781434b( struct_a, struct_b )
{
    return struct_a.yaw_max < struct_b.yaw_max;
}

// Namespace br_c130
// Params 7
// Checksum 0x5065c6ca, Offset: 0x26e4
// Size: 0xd0
function spawnc130( planemodel, var_f5576feec9bc607c, var_126599f183b9e231, objectiveicon, pathstruct, handlemovementfunc, soundalias )
{
    dist = distance( pathstruct.startpt, pathstruct.endpt );
    time = dist / getc130speed();
    var_51a368f8cb1a9054 = 1;
    level.br_ac130 = gunship_spawn( planemodel, var_f5576feec9bc607c, var_126599f183b9e231, objectiveicon, pathstruct.startpt, pathstruct.endpt, time, var_51a368f8cb1a9054, handlemovementfunc, soundalias );
    level.br_ac130.pathstruct = pathstruct;
    return time;
}

// Namespace br_c130
// Params 0
// Checksum 0xa19a330a, Offset: 0x27bd
// Size: 0xf6
function spawnplayertoc130()
{
    if ( level.infil_vignette_anim_type == "script_model" )
    {
        self unlink();
    }
    
    br_infils_util::endprematchskydiving();
    thread playerputinc130( level.br_ac130 );
    
    /#
        if ( self isnoclip() )
        {
            self noclip();
        }
        
        if ( self isufo() )
        {
            self ufo();
        }
    #/
    
    self.brneverlanded = 1;
    self.var_fec1009788ed39b6 = 1;
    issolo = game_utility::function_f24780eadd3fb772() == 1 || isdefined( self.team ) && teams::getteamdata( self.team, "players" ).size == 1;
    
    if ( self.isbrsquadleader && !level.brgametype.var_6c04507ebf9c1226 && !issolo )
    {
        level br_public::brleaderdialogplayer( "deploy_squad_leader", self, 1, 0, undefined, undefined, level.brgametype.dialogprefix );
    }
}

// Namespace br_c130
// Params 1
// Checksum 0x2421a6c0, Offset: 0x28bb
// Size: 0xc5
function playerputinc130( c130 )
{
    self.angles = c130.angles;
    self allowcrouch( 0 );
    self allowprone( 0 );
    self allowfire( 0 );
    self allowmelee( 0 );
    thread listenjump( c130, 0 );
    thread listenkick( c130, 0 );
    self.br_infil_type = "c130";
    
    if ( !getdvarint( @"hash_187e8c5233803ac8", 0 ) )
    {
        thread orbitcam( c130 );
    }
    
    self setclientomnvar( "ui_hide_nameplate_strings", 1 );
    
    if ( getdvarint( @"hash_976e5e0349a9a3ad", 0 ) != 0 )
    {
        sw_challenges = scripted_widgets::function_652736891a41e948( "scripted_widget_challenges" );
        scripted_widgets::create( "sw_challenges", sw_challenges );
    }
    
    thread br::function_61e2f390df19d678();
}

// Namespace br_c130
// Params 1
// Checksum 0x26c49021, Offset: 0x2988
// Size: 0x11a
function orbitcam( gunship )
{
    self endon( #"death" );
    
    if ( level.infil_vignette_anim_type == "script_model" )
    {
        self.angles = gunship.angles;
        self playerlinkto( gunship, "" );
        player_utility::function_dbe5a52a6654a982();
        player_utility::function_9d378d725bb4831e( "br_c130::orbitCam()" );
    }
    
    basevisionset = "";
    basetime = 0;
    
    if ( isdefined( level.var_cd027313d113e09b ) )
    {
        basevisionset = level.var_cd027313d113e09b;
        basetime = 1;
    }
    
    if ( !isai( self ) )
    {
        self visionsetnakedforplayer( basevisionset, basetime );
    }
    
    self setplayerangles( gunship.angles );
    cameraassetname = undefined;
    
    if ( br_infils_legacy::function_bb14cfd60cc8058() )
    {
        slotnumber = 1;
        
        if ( isdefined( self.infilanimindex ) )
        {
            slotnumber = self.infilanimindex;
        }
        
        if ( slotnumber >= 5 )
        {
            slotnumber = 1;
        }
        
        cameraassetname = "cam_orbit_br_ac130_player" + slotnumber;
    }
    else
    {
        cameraassetname = br_infils_util::function_33bc0165dc649d12();
    }
    
    self cameraset( cameraassetname );
}

// Namespace br_c130
// Params 1, eflags: 0x4
// Checksum 0xf0ab0113, Offset: 0x2aaa
// Size: 0x2d
function private gunship_sound( soundalias )
{
    self endon( #"death" );
    self waittill( #"start_moving" );
    self playloopsound( soundalias );
}

// Namespace br_c130
// Params 10
// Checksum 0x63017818, Offset: 0x2adf
// Size: 0x283
function gunship_spawn( planemodel, var_f5576feec9bc607c, var_126599f183b9e231, objectiveicon, startpt, endpt, time, var_51a368f8cb1a9054, handlemovementfunc, soundalias )
{
    if ( !isdefined( planemodel ) )
    {
        planemodel = "veh8_mil_air_acharlie130_magma_animated";
        var_f5576feec9bc607c = "veh8_mil_air_acharlie130_magma_rigid";
    }
    
    if ( !isdefined( var_51a368f8cb1a9054 ) )
    {
        var_51a368f8cb1a9054 = 1;
    }
    
    if ( !isdefined( objectiveicon ) )
    {
        objectiveicon = "hud_icon_minimap_killstreak_gunship";
    }
    
    gunship = spawn( "script_model", startpt );
    gunship setmodel( planemodel );
    gunship forcenetfieldhighlod( 1 );
    gunship setcandamage( 0 );
    gunship.maxhealth = 100000;
    gunship.health = gunship.maxhealth;
    gunship.cleanme = 1;
    gunship.startpt = startpt;
    
    if ( isstring( soundalias ) )
    {
        gunship thread gunship_sound( soundalias );
    }
    
    gunship.dir = vectornormalize( endpt - startpt );
    gunship.angles = vectortoangles( gunship.dir );
    
    if ( isdefined( var_f5576feec9bc607c ) )
    {
        if ( !isdefined( var_126599f183b9e231 ) )
        {
            var_126599f183b9e231 = "";
        }
        
        gunship.innards = spawn( "script_model", startpt );
        gunship.innards setmodel( var_f5576feec9bc607c );
        gunship.innards forcenetfieldhighlod( 1 );
        gunship.innards.cleanme = 1;
        gunship.innards linkto( gunship, var_126599f183b9e231, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
    
    gunship.playeroffsets = [ ( 32, 30, -500 ), ( -32, 30, -500 ), ( 0, 30, -500 ), ( 16, 30, -500 ), ( -16, 30, -500 ) ];
    gunship.currentplayeroffset = 0;
    
    if ( var_51a368f8cb1a9054 )
    {
        gunship thread kickwhenoutofbounds( "c130" );
    }
    
    if ( isdefined( handlemovementfunc ) )
    {
        gunship thread [[ handlemovementfunc ]]( endpt, time );
    }
    else
    {
        gunship thread gunship_handlemovement( endpt, time );
    }
    
    gunship thread function_25057578e4168ad0( objectiveicon );
    gunship thread function_bb2baa15b6e96769();
    return gunship;
}

// Namespace br_c130
// Params 1, eflags: 0x4
// Checksum 0x58389787, Offset: 0x2d6b
// Size: 0x3a
function private function_25057578e4168ad0( objectiveicon )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self waittill( #"start_moving" );
    gunship_spawnobjective( objectiveicon );
}

// Namespace br_c130
// Params 0, eflags: 0x4
// Checksum 0x2dd56205, Offset: 0x2dad
// Size: 0x30
function private function_d76260fc75848c()
{
    gunship = self;
    
    if ( isdefined( gunship.objectiveid ) )
    {
        objidpoolmanager::returnobjectiveid( gunship.objectiveid );
    }
}

// Namespace br_c130
// Params 1, eflags: 0x4
// Checksum 0xe6fdafe6, Offset: 0x2de5
// Size: 0x5b
function private gunship_spawnobjective( objectiveicon )
{
    gunship = self;
    gunship function_d76260fc75848c();
    gunship.objectiveid = gunship objidpoolmanager::createobjective( objectiveicon, undefined, undefined, 1, 1, "icon_regular" );
    objective_setlabel( gunship.objectiveid, &"MP_BR_INGAME/PLANE_CALLOUT" );
}

// Namespace br_c130
// Params 2
// Checksum 0xe1c2bd7e, Offset: 0x2e48
// Size: 0xb4
function gunship_handlemovement( movedestination, movetime )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self hide();
    
    if ( isdefined( self.innards ) )
    {
        self.innards hide();
    }
    
    self waittill( #"start_moving" );
    self show();
    
    if ( isdefined( self.innards ) )
    {
        self.innards show();
    }
    
    self moveto( movedestination, movetime );
    
    /#
        if ( getdvarint( @"hash_c25457fbe123d92f" ) )
        {
            movetime -= 10;
        }
    #/
    
    thread killaftertime( movetime, "c130" );
    thread gunship_spawnvfx();
}

// Namespace br_c130
// Params 0
// Checksum 0xc284d4f9, Offset: 0x2f04
// Size: 0x6f
function gunship_spawnvfx()
{
    level endon( #"game_ended" );
    
    if ( !br_infils_legacy::function_bb14cfd60cc8058() )
    {
        return;
    }
    
    if ( isbrgamemode() )
    {
        wait 0.1;
        self setscriptablepartstate( "br_fx", "clouds" );
        return;
    }
    
    cloudfx = level._effect[ "vfx_snatch_ac130_clouds" ];
    
    if ( !isdefined( cloudfx ) )
    {
        return;
    }
    
    wait 0.1;
    playfxontag( cloudfx, self, "tag_body" );
}

// Namespace br_c130
// Params 0, eflags: 0x4
// Checksum 0x89d3ff80, Offset: 0x2f7b
// Size: 0x32
function private function_bb2baa15b6e96769()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self waittill( #"start_moving" );
    self.var_2c86924721507731 = 1;
}

// Namespace br_c130
// Params 1
// Checksum 0xa7991753, Offset: 0x2fb5
// Size: 0xf5
function inmapbounds( pt )
{
    bounds = level.br_level.br_mapbounds;
    
    if ( isdefined( level.br_level.br_mapboundsfull ) )
    {
        bounds = level.br_level.br_mapboundsfull;
    }
    
    if ( ( br_public::isdmzbotpracticematch() || br_public::isbrpracticemode() ) && isdefined( level.br_ac130 ) )
    {
        inmapbounds = pt[ 0 ] < bounds[ 1 ][ 0 ] && pt[ 0 ] > bounds[ 0 ][ 0 ] && pt[ 1 ] < bounds[ 1 ][ 1 ] && pt[ 1 ] > bounds[ 0 ][ 1 ];
    }
    else
    {
        inmapbounds = pt[ 0 ] < bounds[ 0 ][ 0 ] && pt[ 0 ] > bounds[ 1 ][ 0 ] && pt[ 1 ] < bounds[ 0 ][ 1 ] && pt[ 1 ] > bounds[ 1 ][ 1 ];
    }
    
    return inmapbounds;
}

// Namespace br_c130
// Params 2
// Checksum 0xecfef32e, Offset: 0x30b3
// Size: 0x156
function ispointinbounds( pt, checkplayerradius )
{
    inmapbounds = inmapbounds( pt );
    
    if ( ( br_public::isbrpracticemode() || br_public::isdmzbotpracticematch() ) && isdefined( level.br_ac130 ) )
    {
        return inmapbounds;
    }
    
    if ( !inmapbounds )
    {
        return 0;
    }
    
    if ( iswithinplanepathsaferadius( pt ) )
    {
        return 1;
    }
    
    outofbounds = outofbounds::ispointinoutofbounds( pt );
    
    if ( outofbounds )
    {
        return 0;
    }
    
    if ( checkplayerradius )
    {
        player_radius = 16;
        contents = physics_createcontents( [ "physicscontents_trigger" ] );
        results = physics_spherecast( pt, pt, player_radius, contents, undefined, "physicsquery_all" );
        
        foreach ( result in results )
        {
            ent = result[ "entity" ];
            
            if ( isdefined( ent ) && ent.targetname == "OutOfBounds" )
            {
                return 0;
            }
        }
    }
    
    return 1;
}

/#

    // Namespace br_c130
    // Params 0
    // Checksum 0xbe269fff, Offset: 0x3212
    // Size: 0x3f, Type: dev
    function function_3817a624426a8b3()
    {
        if ( !isdefined( level.var_3817a624426a8b3 ) )
        {
            level.var_3817a624426a8b3 = 1;
            level thread function_630d20d372ba56e2();
            return;
        }
        
        level notify( #"hash_7526a1e34e43ac74" );
        level.var_3817a624426a8b3 = undefined;
    }

    // Namespace br_c130
    // Params 0
    // Checksum 0x2710c876, Offset: 0x3259
    // Size: 0xc9, Type: dev
    function function_630d20d372ba56e2()
    {
        level endon( #"hash_7526a1e34e43ac74" );
        host = gamelogic_mp::gethostplayer();
        
        if ( !isdefined( host ) )
        {
            return;
        }
        
        while ( true )
        {
            angles = host getplayerangles();
            dir = anglestoforward( angles );
            eye = host geteye();
            testpoint = eye + dir * 50;
            inbounds = ispointinbounds( host.origin, 1 );
            color = inbounds ? ( 0, 1, 0 ) : ( 1, 0, 0 );
            sphere( testpoint, 5, color );
            waitframe();
        }
    }

#/

// Namespace br_c130
// Params 0
// Checksum 0x56a5df83, Offset: 0x332a
// Size: 0x7c
function planewaittillcandrop()
{
    assert( isdefined( self.pathstruct ) );
    planedir = anglestoforward( self.angles );
    
    while ( true )
    {
        tostart = vectornormalize( self.pathstruct.startptui - self.origin );
        paststart = vectordot( planedir, tostart ) < 0;
        
        if ( paststart )
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace br_c130
// Params 3
// Checksum 0x9e8e2e89, Offset: 0x33ae
// Size: 0xf5
function function_500f3f43cc65814a( players, flighttype, frames )
{
    if ( frames <= 0 )
    {
        function_18bde48c632c3922( players, flighttype );
        level.var_9273c8c213ba56ec = undefined;
        return;
    }
    
    assert( isdefined( level.var_9273c8c213ba56ec ) );
    
    for ( i = frames - 1; i >= 0 ; i-- )
    {
        if ( i == 0 )
        {
            function_18bde48c632c3922( players, flighttype );
        }
        else
        {
            function_69474c1110cec6f4( players, flighttype );
            
            for ( animindex = 0; animindex < 4 ; animindex++ )
            {
                if ( level.var_9273c8c213ba56ec[ animindex ].size > i )
                {
                    player = level.var_9273c8c213ba56ec[ animindex ][ 0 ];
                    player.jumptype = "outOfBounds";
                    player notify( #"halo_kick_c130" );
                }
            }
        }
        
        waitframe();
    }
    
    level.var_9273c8c213ba56ec = undefined;
}

// Namespace br_c130
// Params 2
// Checksum 0x2fef6a7e, Offset: 0x34ab
// Size: 0xc5
function function_18bde48c632c3922( players, flighttype )
{
    foreach ( player in players )
    {
        if ( isdefined( player ) && player.br_infil_type == flighttype && !isdefined( player.jumptype ) )
        {
            player.jumptype = "outOfBounds";
            player notify( #"halo_kick_c130" );
        }
    }
}

// Namespace br_c130
// Params 2
// Checksum 0x54805479, Offset: 0x3578
// Size: 0x174
function function_69474c1110cec6f4( players, flighttype )
{
    level.var_9273c8c213ba56ec = [ [], [], [], [] ];
    
    foreach ( player in players )
    {
        if ( isdefined( player ) && isdefined( player.infilanimindex ) )
        {
            if ( isdefined( player.jumptype ) )
            {
                continue;
            }
            
            if ( isdefined( player.br_infil_type ) && player.br_infil_type != flighttype )
            {
                continue;
            }
            
            animindex = player.infilanimindex % 4 + 1;
            assert( animindex > 0 && animindex <= 4 );
            level.var_9273c8c213ba56ec[ animindex - 1 ][ level.var_9273c8c213ba56ec[ animindex - 1 ].size ] = player;
        }
    }
    
    maxcount = 0;
    
    for ( i = 0; i < 4 ; i++ )
    {
        maxcount = maxint( maxcount, level.var_9273c8c213ba56ec[ i ].size );
    }
    
    return maxcount;
}

// Namespace br_c130
// Params 1
// Checksum 0x626689e1, Offset: 0x36f5
// Size: 0x3e2
function kickwhenoutofbounds( flighttype )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( !game_utility::function_d3f8957534dc62af() )
    {
        setomnvarforallclients( "ui_hide_minimap", 1 );
    }
    
    waitframe();
    planewaittillcandrop();
    c130knownsafeheight = getc130knownsafeheight();
    
    while ( !ispointinbounds( ( self.origin[ 0 ], self.origin[ 1 ], c130knownsafeheight ) ) )
    {
        waitframe();
    }
    
    var_c0d36e9165875af5 = getdvarint( @"hash_3ade460504ff5346", 1 );
    
    if ( var_c0d36e9165875af5 )
    {
        while ( true )
        {
            circleactive = 1;
            circleradii = br_circle_util::function_1a92b7a87aa9aec6();
            
            foreach ( circleradius in circleradii )
            {
                if ( circleradius <= 0 )
                {
                    circleactive = 0;
                }
            }
            
            if ( !circleactive || br_circle_util::ispointindangercircle( self.origin ) )
            {
                break;
            }
            
            waitframe();
        }
    }
    
    level.br_latejoininfilready = 1;
    level.c130inbounds = 1;
    level notify( #"br_c130_in_bounds" );
    println( "<dev string:xa4>" );
    
    if ( !game_utility::function_d3f8957534dc62af() )
    {
        setomnvarforallclients( "ui_hide_minimap", 0 );
    }
    
    while ( true )
    {
        planedir = anglestoforward( self.angles );
        tocenter = vectornormalize( self.pathstruct.centerpt - self.origin );
        pasthalfway = vectordot( planedir, tocenter ) < 0;
        
        if ( pasthalfway )
        {
            break;
        }
        
        waitframe();
    }
    
    var_161ebf5f1f5d2368 = getdvarint( @"hash_44a8d75a62db0d9d", 1 );
    var_5e3759a510027715 = 0;
    var_8cdcdbf6c9ecee1d = getdvarint( @"scr_br_project_kick", 3500 );
    
    while ( true )
    {
        if ( var_161ebf5f1f5d2368 )
        {
            var_5e3759a510027715 = function_69474c1110cec6f4( level.players, flighttype );
            var_b18e2f7448945a78 = var_5e3759a510027715 * level.framedurationseconds * getc130speed();
        }
        else
        {
            var_b18e2f7448945a78 = 0;
        }
        
        planedir = anglestoforward( self.angles );
        var_a9db05832be82251 = self.origin + planedir * ( var_8cdcdbf6c9ecee1d + var_b18e2f7448945a78 );
        var_a9db05832be82251 = ( var_a9db05832be82251[ 0 ], var_a9db05832be82251[ 1 ], c130knownsafeheight );
        
        if ( !ispointinbounds( var_a9db05832be82251 ) )
        {
            level.br_c130spawndone = 1;
            level function_500f3f43cc65814a( level.players, flighttype, var_5e3759a510027715 );
            break;
        }
        
        if ( var_c0d36e9165875af5 )
        {
            circleactive = 1;
            circleradii = br_circle_util::function_1a92b7a87aa9aec6();
            
            foreach ( circleradius in circleradii )
            {
                if ( circleradius <= 0 )
                {
                    circleactive = 0;
                }
            }
            
            if ( circleactive && !br_circle_util::ispointindangercircle( var_a9db05832be82251 ) )
            {
                level.br_c130spawndone = 1;
                level function_500f3f43cc65814a( level.players, flighttype, var_5e3759a510027715 );
                break;
            }
        }
        
        waitframe();
    }
    
    level.c130inbounds = undefined;
    level notify( #"br_c130_left_bounds" );
    level.infilstruct.playersinc130 = 0;
    setomnvar( "ui_br_players_left_in_plane", level.infilstruct.playersinc130 );
    println( "<dev string:xcd>" );
}

// Namespace br_c130
// Params 2
// Checksum 0xdf395853, Offset: 0x3adf
// Size: 0x1c8
function killaftertime( time, flighttype )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    wait time;
    
    if ( isdefined( self.players ) )
    {
        function_18bde48c632c3922( self.players, flighttype );
    }
    else
    {
        function_18bde48c632c3922( level.players, flighttype );
    }
    
    function_d76260fc75848c();
    self stoploopsound();
    
    if ( isdefined( self.animstruct.var_751e0e63f6c6f6ec ) )
    {
        self [[ self.animstruct.var_751e0e63f6c6f6ec ]]();
    }
    
    wait 0.1;
    
    if ( isdefined( self.animstruct ) )
    {
        var_676eaa49920d233e = 1;
        
        while ( var_676eaa49920d233e )
        {
            var_676eaa49920d233e = 0;
            
            foreach ( player in level.players )
            {
                if ( isdefined( player.br_infil_type ) )
                {
                    var_676eaa49920d233e = 1;
                    break;
                }
            }
            
            if ( var_676eaa49920d233e )
            {
                wait 0.5;
            }
        }
        
        if ( isdefined( self.animstruct.cleanupfunc ) )
        {
            self.animstruct thread [[ self.animstruct.cleanupfunc ]]();
        }
        else
        {
            level thread br_public::cleanac130struct( self.animstruct );
        }
        
        return;
    }
    
    if ( isdefined( self.innards ) )
    {
        self.innards delete();
    }
    
    self delete();
}

// Namespace br_c130
// Params 0
// Checksum 0xe914dae2, Offset: 0x3caf
// Size: 0x2a
function calctrailpoint()
{
    droppoint = self.origin - anglestoforward( self.angles ) * 150;
    return droppoint;
}

// Namespace br_c130
// Params 2
// Checksum 0x46acef1f, Offset: 0x3ce2
// Size: 0x90
function listenkick( c130, forcechute )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"cancel_c130" );
    self endon( #"br_jump" );
    self waittill( #"halo_kick_c130", viewanglesoverride );
    
    if ( !isdefined( viewanglesoverride ) )
    {
        viewanglesoverride = ( 0, c130.angles[ 1 ] + 180, 0 );
    }
    
    self.brkickedfromplane = 1;
    thread leaveplane( c130, forcechute, viewanglesoverride, 0 );
}

// Namespace br_c130
// Params 1
// Checksum 0xc8a2e9cd, Offset: 0x3d7a
// Size: 0xae
function function_1021438640ffb82a( teammates )
{
    retteammates = [];
    
    foreach ( player in teammates )
    {
        if ( player == self )
        {
            continue;
        }
        
        if ( !player br_public::function_e6445d548e426852() )
        {
            continue;
        }
        
        if ( isbot( player ) )
        {
            continue;
        }
        
        retteammates[ retteammates.size ] = player;
    }
    
    return retteammates;
}

// Namespace br_c130
// Params 2
// Checksum 0x8b4eeee3, Offset: 0x3e31
// Size: 0x3fd
function listenjump( c130, var_3a969995f41ba818 )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"cancel_c130" );
    self endon( #"br_jump" );
    var_75a668e52554375 = undefined;
    self.redeployenabled = 0;
    var_e45d660c455f3324 = getdvarint( @"hash_5c93dcd7535822e6", 0 );
    c130 planewaittillcandrop();
    
    while ( true )
    {
        result = utility::waittill_any_return( "halo_jump_c130", "halo_jump_solo_c130", "halo_jump_parachute_c130", "halo_jump_parachute_solo_c130" );
        
        if ( !isdefined( result ) )
        {
            result = "halo_jump_c130";
        }
        
        /#
            var_e45d660c455f3324 = getdvarint( @"hash_5c93dcd7535822e6", 0 );
        #/
        
        teammates = teams::function_d032b36d01bbbab3( self.team, self.sessionsquadid );
        
        if ( !var_e45d660c455f3324 )
        {
            var_75a668e52554375 = c130 calctrailpoint();
            
            if ( ispointinbounds( var_75a668e52554375 ) )
            {
                self.jumptype = "solo";
                self notify( #"halo_kick_c130" );
                utility::thread_on_notify( "infil_jump_done", &br_public::updatebrscoreboardstat, undefined, undefined, undefined, "jumpMasterState", 0 );
                break;
            }
            else
            {
                self iprintlnbold( &"mp_br_ingame/not_playable" );
            }
            
            continue;
        }
        
        squadleader = br_public::isplayerbrsquadleader() || self.sessionuimemberindex == 0;
        
        if ( !squadleader && teammates.size > 1 )
        {
            if ( result == "halo_jump_solo_c130" || !br_public::function_e6445d548e426852() )
            {
                var_75a668e52554375 = c130 calctrailpoint();
                
                if ( ispointinbounds( var_75a668e52554375 ) )
                {
                    self.jumptype = "solo";
                    self notify( #"halo_kick_c130" );
                    utility::thread_on_notify( "infil_jump_done", &br_public::updatebrscoreboardstat, undefined, undefined, undefined, "jumpMasterState", 0 );
                    break;
                }
                else
                {
                    self iprintlnbold( &"mp_br_ingame/not_playable" );
                }
            }
            
            continue;
        }
        
        var_75a668e52554375 = c130 calctrailpoint();
        
        if ( ispointinbounds( var_75a668e52554375 ) )
        {
            if ( squadleader )
            {
                self.jumptype = "leader";
                usingsquads = isdefined( level.squaddata );
                
                if ( usingsquads )
                {
                    squad = level.squaddata[ self.team ][ self.sessionsquadid ];
                    teammates = squad.players;
                }
                
                foreach ( player in teammates )
                {
                    if ( player != self && isdefined( player.br_infil_type ) && !isdefined( player.jumptype ) )
                    {
                        player.jumptype = "follower";
                        player notify( #"halo_kick_c130", self getplayerangles() );
                    }
                }
                
                if ( result != "halo_jump_solo_c130" && getdvarint( @"hash_d649575e14a3dc9f", 0 ) )
                {
                    thread holdteammatestosquadleader( teammates );
                }
                else
                {
                    foreach ( player in teammates )
                    {
                        if ( isdefined( player.br_infil_type ) )
                        {
                            setteammateomnvarsforplayer( player, teammates, 0 );
                        }
                    }
                }
            }
            
            break;
        }
        else
        {
            self iprintlnbold( &"mp_br_ingame/not_playable" );
        }
        
        var_75a668e52554375 = c130 calctrailpoint();
        waitframe();
    }
    
    thread leaveplane( c130, var_3a969995f41ba818, self getplayerangles(), 0 );
    println( "<dev string:xfa>" );
}

// Namespace br_c130
// Params 4
// Checksum 0xf7d48617, Offset: 0x4236
// Size: 0x260
function leaveplane( c130, forcechute, viewanglesoverride, inheritvelocity )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"cancel_c130" );
    setdvarifuninitialized( @"scr_br_infil_hudoutline", 1 );
    assert( isdefined( self.jumptype ) );
    self notify( #"br_jump" );
    self allowcrouch( 1 );
    self allowprone( 1 );
    self allowfire( 1 );
    self allowmelee( 1 );
    self.plotarmor = undefined;
    self.c130 = undefined;
    br_public::updatebrscoreboardstat( "isInInfilPlane", 0 );
    
    if ( isdefined( level.infilstruct ) && level.infilstruct.playersinc130 > 0 )
    {
        level.infilstruct.playersinc130--;
    }
    
    if ( getdvarint( @"hash_57377f405b99ecd2", 0 ) && isdefined( level.infilstruct.var_8d204c31b1b2bdde ) && level.infilstruct.var_8d204c31b1b2bdde > 0 )
    {
        level.infilstruct.var_8d204c31b1b2bdde--;
    }
    
    self notifyonplayercommandremove( "halo_jump_c130", "+gostand" );
    self notifyonplayercommandremove( "halo_jump_solo_c130", "+gostand" );
    
    if ( !isbot( self ) )
    {
        self notifyonplayercommandremove( "halo_jump_parachute_c130", "+open_parachute" );
        self notifyonplayercommandremove( "halo_jump_parachute_solo_c130", "+open_parachute" );
    }
    
    self notifyonplayercommandremove( "abandon_fireteam_leader", "+frag" );
    self notifyonplayercommandremove( "br_pass_squad_leader", "+usereload" );
    self notifyonplayercommandremove( "br_pass_squad_leader", "+activate" );
    self waittill( #"infil_jump_done" );
    self cameradefault();
    self.br_infil_type = undefined;
    self function_11d1451480b85d27( 1 );
    
    if ( getdvarint( @"hash_976e5e0349a9a3ad", 0 ) != 0 )
    {
        scripted_widgets::destroy( "sw_challenges" );
    }
    
    thread parachute( c130, forcechute, viewanglesoverride, inheritvelocity );
    
    if ( game_utility::getgametype() == "truckwar" )
    {
        br_gametype_truckwar::getspawnpoint( 1 );
        self setorigin( self.redeployspawn.origin, 1 );
        self setplayerangles( self.redeployspawn.angles );
    }
}

// Namespace br_c130
// Params 1
// Checksum 0xbd79dc57, Offset: 0x449e
// Size: 0x26d
function holdteammatestosquadleader( teammates )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    thread watchforsquadleaddisconnect( teammates );
    squadleader = self;
    wait 0.2;
    spots = [ ( -250, 0, 0 ), ( -150, -150, 0 ), ( -150, 150, 0 ) ];
    num = 0;
    
    foreach ( player in teammates )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( player != squadleader )
        {
            if ( isdefined( player.jumptype ) && player.jumptype != "solo" )
            {
                player thread pushplayertoplayeroffset( squadleader, spots[ num ] );
                num++;
                continue;
            }
            
            setteammateomnvarsforplayer( player, teammates, 0 );
        }
    }
    
    deployheight = 2700;
    offground = 999999999;
    
    while ( !self usebuttonpressed() && offground > deployheight )
    {
        gpos = utility::groundpos( squadleader.origin );
        offground = squadleader.origin[ 2 ] - gpos[ 2 ];
        
        if ( squadleader isparachuting() )
        {
            break;
        }
        
        waitframe();
    }
    
    foreach ( teammate in teammates )
    {
        if ( !isalive( teammate ) )
        {
            continue;
        }
        
        if ( teammate != self && teammate.beingpushed )
        {
            teammate notify( #"stop_push" );
            teammate.beingpushed = undefined;
        }
        
        setteammateomnvarsforplayer( teammate, teammates, 0 );
    }
    
    self notify( #"hold_teammates_complete" );
}

// Namespace br_c130
// Params 1
// Checksum 0xf80280f1, Offset: 0x4713
// Size: 0xe1
function watchforsquadleaddisconnect( teammates )
{
    level endon( #"game_ended" );
    self endon( #"hold_teammates_complete" );
    utility::waittill_any( "death", "disconnect" );
    
    foreach ( teammate in teammates )
    {
        if ( !isdefined( teammate ) )
        {
            continue;
        }
        
        if ( teammate != self && teammate.beingpushed )
        {
            teammate notify( #"stop_push" );
            teammate.beingpushed = undefined;
        }
        
        setteammateomnvarsforplayer( teammate, teammates, 0 );
    }
}

// Namespace br_c130
// Params 3
// Checksum 0xc434437b, Offset: 0x47fc
// Size: 0x4c
function setteammateomnvarsforplayer( player, teamplayers, defaultvalue )
{
    attachedvalue = player br_public::isplayerbrsquadleader() ? 2 : defaultvalue;
    player br_public::updatebrscoreboardstat( "jumpMasterState", attachedvalue );
}

// Namespace br_c130
// Params 0
// Checksum 0xdfdc7e0f, Offset: 0x4850
// Size: 0x5e
function playerparachutedetachresetomnvars()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"stop_push" );
    self waittill( #"skydive_deployparachute" );
    teammates = teams::getteamdata( self.team, "players" );
    setteammateomnvarsforplayer( self, teammates, 0 );
}

// Namespace br_c130
// Params 1
// Checksum 0x29f0f44f, Offset: 0x48b6
// Size: 0x8d
function function_41d963a517bef64f( squadleader )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"stop_push" );
    
    while ( !self isonground() && isdefined( squadleader ) && self != squadleader )
    {
        if ( squadleader isparachuting() && !self isparachuting() )
        {
            self notify( #"skydive_deployparachute" );
            self skydive_deployparachute();
        }
        else if ( !squadleader isparachuting() && self isparachuting() )
        {
            self function_5777e2cf26388d15();
        }
        
        waitframe();
    }
}

// Namespace br_c130
// Params 0
// Checksum 0x7b3dd388, Offset: 0x494b
// Size: 0x6b
function function_ff444c4e6280ff75()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self waittill( #"stop_push" );
    self.beingpushed = undefined;
    teammates = teams::getteamdata( self.team, "players" );
    setteammateomnvarsforplayer( self, teammates, 0 );
    self function_ca5b467fc63e424a( 0 );
    br_public::function_63526e8677d58de8( 0 );
}

// Namespace br_c130
// Params 2
// Checksum 0xfa1414ec, Offset: 0x49be
// Size: 0x167
function pushplayertoplayeroffset( squadleader, offset )
{
    level endon( #"game_ended" );
    self.beingpushed = 1;
    linkedplayer = self;
    linkedplayer endon( #"death_or_disconnect" );
    linkedplayer endon( #"stop_push" );
    linkedplayer thread playerparachutedetachresetomnvars();
    offsetlength = length( offset );
    
    while ( !linkedplayer isonground() && !linkedplayer usebuttonpressed() && isdefined( squadleader ) && !linkedplayer isparachuting() )
    {
        angle = squadleader getplayerangles();
        newoffset = rotatepointaroundvector( ( 0, 0, 1 ), offset, angle[ 1 ] );
        forcevector = squadleader.origin + newoffset - linkedplayer.origin;
        dist = length( forcevector );
        
        if ( dist > offsetlength )
        {
            var_6d8f3b482935d48 = linkedplayer getvelocity();
            linkedplayer setvelocity( forcevector + var_6d8f3b482935d48 * 0.9 );
        }
        
        waitframe();
    }
    
    linkedplayer notify( #"stop_push" );
    linkedplayer.beingpushed = undefined;
    teammates = teams::getteamdata( linkedplayer.team, "players" );
    setteammateomnvarsforplayer( linkedplayer, teammates, 0 );
}

// Namespace br_c130
// Params 4
// Checksum 0xedeb7b62, Offset: 0x4b2d
// Size: 0x16f
function parachute( c130, var_3a969995f41ba818, var_f727b9f5d8e087b, inheritvelocity )
{
    self endon( #"disconnect" );
    self setclientomnvar( "ui_br_infiled", 1 );
    
    if ( self function_5c766d1d0140b86( "ui_hide_nameplate_strings" ) )
    {
        self setclientomnvar( "ui_hide_nameplate_strings", 0 );
    }
    
    self unlink();
    
    if ( isdefined( self.br_orbitcam ) )
    {
        self.br_orbitcam delete();
    }
    
    thread infilfreefallparachuteaudio( c130 );
    var_6d75568296c9af6d = getmatchrulesdata( "commonOption", "disableExecutionOnPlaneJumpTime" );
    
    if ( var_6d75568296c9af6d > 0 )
    {
        val::set( "plane_exit", "execution_victim", 0 );
        utility::delaythread( var_6d75568296c9af6d, &val::reset_all, "plane_exit" );
    }
    
    waitframe();
    player_utility::function_b54a1e23734ef07( 1 );
    
    if ( isdefined( var_f727b9f5d8e087b ) )
    {
        self setplayerangles( var_f727b9f5d8e087b );
    }
    
    if ( isbrgamemode() )
    {
        self.br_isplayerbeforeinitialinfildeploy = undefined;
        br_analytics::branalytics_deploytriggered( self );
    }
    
    velocity = ( 0, 0, 0 );
    
    if ( inheritvelocity )
    {
        velocity = anglestoforward( c130.angles ) * getc130speed();
    }
    
    self.ignorefalldamagetime = gettime() + 5000;
    self skydive_setdeploymentstatus( 0 );
    var_d63bff38e54eb6e9 = getdvarfloat( @"hash_4ae50abb410517ab", 2 );
    thread parachute::startfreefall( var_d63bff38e54eb6e9, var_3a969995f41ba818, undefined, velocity );
}

// Namespace br_c130
// Params 1
// Checksum 0x162ce9bb, Offset: 0x4ca4
// Size: 0xa5
function infilfreefallparachuteaudio( c130 )
{
    self endon( #"disconnect" );
    player = self;
    
    if ( isdefined( c130 ) )
    {
        flyby_soundalias = "veh_br_c17_flyby";
        
        if ( isdefined( c130.model ) )
        {
            if ( issubstr( c130.model, "130" ) )
            {
                flyby_soundalias = "br_ac130_flyby";
            }
            else if ( issubstr( c130.model, "heli" ) )
            {
                flyby_soundalias = "veh_br_heli_flyby";
            }
        }
        
        c130 playsoundtoplayer( flyby_soundalias, player, c130 );
    }
    
    wait 1;
    player clearclienttriggeraudiozone( 1 );
}

// Namespace br_c130
// Params 1
// Checksum 0x84ee089b, Offset: 0x4d51
// Size: 0x41
function setplayervarinrespawnc130( value )
{
    if ( isdefined( self.inrespawnc130 ) && self.inrespawnc130 == value )
    {
        return;
    }
    
    self.inrespawnc130 = value;
    level notify( #"hash_7f6b2a7b2d05df3e" );
}

// Namespace br_c130
// Params 0
// Checksum 0x44ee8eb4, Offset: 0x4d9a
// Size: 0x110
function waittoplayinfildialog()
{
    level endon( #"game_ended" );
    assert( isdefined( level.br_ac130 ) );
    level.br_ac130 endon( #"death" );
    level.br_ac130 planewaittillcandrop();
    
    while ( true )
    {
        var_75a668e52554375 = level.br_ac130 calctrailpoint();
        
        if ( ispointinbounds( var_75a668e52554375 ) )
        {
            foreach ( player in level.players )
            {
                if ( isplayer( player ) )
                {
                    player playlocalsound( "evt_br_infil_jump_buzzer" );
                }
            }
            
            wait 1;
            flags::gameflagset( "br_ready_to_jump" );
            br_analytics::branalytics_deployallowed();
            return;
        }
        
        waitframe();
    }
}

/#

    // Namespace br_c130
    // Params 0
    // Checksum 0x96a997c0, Offset: 0x4eb2
    // Size: 0x191, Type: dev
    function function_f30ca7005ed4e05b()
    {
        host = gamelogic_mp::gethostplayer();
        
        if ( !isdefined( level.var_b00856f48aa7a56c ) )
        {
            if ( isdefined( host ) )
            {
                host setclientomnvar( "<dev string:x11b>", 0 );
            }
            
            level.var_b00856f48aa7a56c = 1;
            level endon( #"hash_1be83a1d49c97e01" );
        }
        else
        {
            if ( isdefined( host ) )
            {
                host setclientomnvar( "<dev string:x11b>", 1 );
            }
            
            level.var_b00856f48aa7a56c = undefined;
            level notify( #"hash_1be83a1d49c97e01" );
            return;
        }
        
        while ( true )
        {
            host = gamelogic_mp::gethostplayer();
            
            if ( isdefined( host ) )
            {
                pathradius = level.br_level.br_circleradii[ 0 ] * 2;
                c130height = parachute::getc130height();
                pathstruct = spawnc130pathstructnewinternal( host.origin, host.angles, c130height, pathradius );
                host updatec130pathomnvars( pathstruct );
                var_8cdcdbf6c9ecee1d = 600;
                dir = anglestoforward( host.angles );
                forwardorg = host.origin + dir * getdvarint( @"scr_br_project_kick", 3500 );
                inbounds = ispointinbounds( forwardorg );
                color = ( 0, 1, 0 );
                
                if ( !inbounds )
                {
                    color = ( 1, 0, 0 );
                }
                
                sphere( forwardorg, 10, color );
            }
            
            waitframe();
        }
    }

    // Namespace br_c130
    // Params 1
    // Checksum 0xa4ff2bed, Offset: 0x504b
    // Size: 0xec, Type: dev
    function function_ef24f22c617da156( host )
    {
        if ( level.var_ef24f22c617da156 )
        {
            if ( isdefined( level.var_885a98380b9fc123 ) )
            {
                level.var_885a98380b9fc123 delete();
            }
            
            level.var_ef24f22c617da156 = undefined;
            level notify( #"hash_a96f546f0a0776bf" );
            return;
        }
        
        level endon( #"hash_a96f546f0a0776bf" );
        level.var_ef24f22c617da156 = 1;
        centerpt = level.br_level.br_mapcenter + ( 0, 0, parachute::getc130height() );
        centerpt += function_40c70dc273b74619();
        saferadius = getplanepathsaferadiusfromcenter();
        level.var_885a98380b9fc123 = spawnquestcircle( "<dev string:x129>", centerpt[ 0 ], centerpt[ 1 ], saferadius, host );
        
        while ( true )
        {
            utility::draw_circle( centerpt, saferadius, ( 0, 1, 0 ), 1, 0, 1 );
            waitframe();
        }
    }

    // Namespace br_c130
    // Params 1
    // Checksum 0x3806225d, Offset: 0x513f
    // Size: 0x1c8, Type: dev
    function function_e5ae8db74e375db2( num )
    {
        level notify( #"hash_a65a02fb1c4a0363" );
        level endon( #"hash_a65a02fb1c4a0363" );
        host = gamelogic_mp::gethostplayer();
        
        if ( !isdefined( host ) )
        {
            return;
        }
        
        if ( !level.var_ef24f22c617da156 )
        {
            thread function_ef24f22c617da156( host );
        }
        
        if ( !isdefined( num ) )
        {
            num = 1000;
        }
        else
        {
            num = int( num );
        }
        
        host setclientomnvar( "<dev string:x11b>", 1 );
        smallestdist = undefined;
        chosenpath = undefined;
        
        for ( i = 0; i < num ; i++ )
        {
            originoverride = undefined;
            radiusoverride = undefined;
            
            if ( br_gametypes::isfeaturedisabled( #"randomizecirclecenter" ) )
            {
                originoverride = ( level.br_level.br_circlecenters[ 1 ][ 0 ], level.br_level.br_circlecenters[ 1 ][ 1 ], 0 );
                radiusoverride = level.br_level.br_circleradii[ 1 ];
            }
            
            pathstruct = spawnc130pathstructnew( originoverride, radiusoverride );
            distsq = distance2d( pathstruct.startptui, pathstruct.endptui );
            
            if ( !isdefined( smallestdist ) || distsq < smallestdist )
            {
                chosenpath = pathstruct;
                smallestdist = distsq;
            }
            
            if ( i % 100 == 0 )
            {
                host setclientomnvar( "<dev string:x11b>", 0 );
                host updatec130pathomnvars( chosenpath );
                waitframe();
            }
        }
        
        host setclientomnvar( "<dev string:x11b>", 0 );
        host updatec130pathomnvars( chosenpath );
        host iprintlnbold( "<dev string:x134>" );
        level.infilstruct.c130pathstruct = chosenpath;
    }

#/
