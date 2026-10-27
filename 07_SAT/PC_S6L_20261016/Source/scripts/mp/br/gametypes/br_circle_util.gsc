// scripts\mp\br\gametypes\br_circle_util.gsc  (hash_7acec0c0a67ad677.gscc) (size: 12536 Bytes / 0x30f8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x47f6bca4 (1207352484)
// size ...... 12536 (0x30f8)
// includes .. 7   (offset: 0x2f70)
// strings ... 15  (offset: 0x2fa8)
// dev strs .. 9   (offset: 0x3070)
// exports ... 49  (offset: 0x1f08)
// cseg ...... 0x17c + 0x1d8c (0x1f08)
// imports ... 73  (offset: 0x26b0)
// animtree1 . 0   (offset: 0x30f8)
// animtree2 . 0   (offset: 0x30f8)
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_multi_circle;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\flags;

#namespace br_circle_util;

// Namespace br_circle_util
// Params 5
// Checksum 0x876f13d7, Offset: 0x19a
// Size: 0x2b9
function calcsafecirclecenters( origin, circleradii, circleclosetimes, nodlog, var_17fd4487022823f )
{
    if ( !isdefined( circleradii ) || circleradii.size < 2 || circleradii[ 0 ] <= 0 )
    {
        return;
    }
    
    var_f5661efe10a6d8d5 = getdvarint( @"hash_67a8c844bad5a45b", 0 );
    
    if ( !var_f5661efe10a6d8d5 && br_gametypes::isfeatureenabled( #"circlesnaptonavmesh" ) )
    {
        var_f5661efe10a6d8d5 = 1;
    }
    
    circlecenters = [];
    circlecenters[ 0 ] = ( origin[ 0 ], origin[ 1 ], 0 );
    radius = circleradii[ 0 ];
    maxpct = 1 - circleradii[ 1 ] / radius;
    lastcircleindex = circleradii.size - 1;
    circlecenters[ lastcircleindex ] = br_circle::getrandompointinboundscircle( origin, radius, 0, maxpct, 1, var_f5661efe10a6d8d5, 1 );
    
    if ( var_17fd4487022823f )
    {
        return circlecenters;
    }
    
    playerspeed = getdvarfloat( @"scr_br_circle_max_speed", 200 );
    var_2fa0821fba9a90e8 = getdvarint( @"scr_br_circle_clamp_max_circle_speed", 0 );
    
    for ( circleindex = lastcircleindex - 1; circleindex >= 0 ; circleindex-- )
    {
        origin = circlecenters[ circleindex + 1 ];
        radius = circleradii[ circleindex ];
        minpct = 0;
        maxpct = 1 - circleradii[ circleindex + 1 ] / radius;
        pct = minpct + randomfloat( maxpct - minpct );
        closetime = circleclosetimes[ circleindex ];
        prevradius = circleradii[ circleindex + 1 ];
        deltaradius = radius - prevradius;
        radiusspeed = deltaradius / closetime;
        maxmovespeed = max( 0, playerspeed - radiusspeed );
        maxmovedist = maxmovespeed * closetime;
        var_e1eb29d231c0441c = maxmovedist / radius;
        var_cea5ca4e5dcb3be1 = pct > var_e1eb29d231c0441c;
        
        if ( var_cea5ca4e5dcb3be1 && !nodlog )
        {
            circlespeed = radiusspeed + pct * radius / closetime;
            dlog_recordevent( "dlog_event_br_circle_speed_warning", [ "player_speed", playerspeed, "circle_speed", circlespeed, "circle_close_time", float( closetime ), "circle_current_radius", float( radius ), "circle_next_radius", float( prevradius ) ] );
        }
        
        if ( circleindex )
        {
            if ( var_2fa0821fba9a90e8 && var_cea5ca4e5dcb3be1 )
            {
                pct = minpct + randomfloat( var_e1eb29d231c0441c - minpct );
            }
            
            circlecenters[ circleindex ] = br_circle::getrandompointinboundscircle( origin, radius, pct, pct, 1, var_f5661efe10a6d8d5, 1 );
        }
    }
    
    return circlecenters;
}

// Namespace br_circle_util
// Params 4
// Checksum 0xc9b2545d, Offset: 0x45c
// Size: 0xe3
function function_8bf41372019ee411( requestedcount, circlecenters, circleradii, var_f5661efe10a6d8d5 )
{
    movingcircles = [];
    
    for ( circleindex = 1; circleindex <= requestedcount ; circleindex++ )
    {
        prev_circle_radius = circleradii[ circleindex - 1 ];
        prev_circle_origin = circlecenters[ circleindex - 1 ];
        current_circle_radius = circleradii[ circleindex ];
        mindist = prev_circle_radius + current_circle_radius + level.br_level.br_movingcirclemovedistmin;
        maxdist = prev_circle_radius + current_circle_radius + level.br_level.br_movingcirclemovedistmax;
        movingcircles[ circleindex - 1 ] = br_circle::getrandompointinboundscircle( prev_circle_origin, maxdist, mindist / maxdist, 1, 1, var_f5661efe10a6d8d5, 1 );
    }
    
    return movingcircles;
}

// Namespace br_circle_util
// Params 0
// Checksum 0x5033d1e5, Offset: 0x548
// Size: 0x24
function function_7c3401c47d505872()
{
    if ( !level.br_multi_circle_enabled )
    {
        return 0;
    }
    
    return level.br_multi_circle.circlecount;
}

// Namespace br_circle_util
// Params 0
// Checksum 0xd74dc534, Offset: 0x575
// Size: 0x39, Type: bool
function function_209532a1558406f()
{
    return function_7c3401c47d505872() > 1 && level.br_circle.circleindex + 1 == level.br_multi_circle.mergeindex;
}

// Namespace br_circle_util
// Params 0
// Checksum 0xd26cdf19, Offset: 0x5b7
// Size: 0x1e
function function_23705baf6673b0ed()
{
    return function_22abcafc992ddca7( level.br_circle.circleindex + 1 );
}

// Namespace br_circle_util
// Params 1
// Checksum 0x3b9b798c, Offset: 0x5de
// Size: 0x78
function function_22abcafc992ddca7( circleindex )
{
    if ( isdefined( level.br_multi_circle.var_23705baf6673b0ed ) )
    {
        return [[ level.br_multi_circle.var_23705baf6673b0ed ]]( circleindex );
    }
    
    return function_7c3401c47d505872() > 1 && ( circleindex < level.br_multi_circle.splitindex || circleindex > level.br_multi_circle.mergeindex );
}

// Namespace br_circle_util
// Params 1
// Checksum 0x3be4f2a1, Offset: 0x65f
// Size: 0x86
function function_ea3debeb59476d66( circleindex )
{
    var_50d8d96499063904 = level.br_level.br_circleshowdelaydanger[ circleindex ];
    
    if ( var_50d8d96499063904 > 0 )
    {
        br_circle::hidedangercircle();
        utility::delaythread( var_50d8d96499063904, &br_circle::showdangercircle );
    }
    
    var_a63487c39a86bdd2 = level.br_level.br_circleshowdelaysafe[ circleindex ];
    
    if ( var_a63487c39a86bdd2 > 0 )
    {
        br_circle::hidesafecircle();
        utility::delaythread( var_a63487c39a86bdd2, &br_circle::showsafecircle );
    }
}

// Namespace br_circle_util
// Params 2
// Checksum 0xf3841adc, Offset: 0x6ed
// Size: 0x52
function playcircleopendialog( circleindex, var_fade5044da9ae670 )
{
    if ( br_circle::canplaycircleopendialog( circleindex ) )
    {
        if ( var_fade5044da9ae670 )
        {
            br_public::brleaderdialog( "first_circle", 1, undefined, undefined, 0.5 );
            return;
        }
        
        br_public::brleaderdialog( "new_circle", 1, undefined, undefined, 0.5 );
    }
}

// Namespace br_circle_util
// Params 2
// Checksum 0xd93c1654, Offset: 0x747
// Size: 0x83
function playcircleclosedialog( circleindex, var_b2827c0c6de965f2 )
{
    if ( br_circle::canplaycircleclosedialog( circleindex ) )
    {
        if ( var_b2827c0c6de965f2 )
        {
            br_public::brleaderdialog( "final_circle", 1, undefined, undefined, 0.5, undefined, level.brgametype.dialogprefix );
            return;
        }
        
        br_public::brleaderdialog( "circle_closing", 1, undefined, undefined, 0.5, undefined, level.brgametype.dialogprefix );
        thread br_circle::brcirclebattlechatter( circleindex );
    }
}

// Namespace br_circle_util
// Params 1
// Checksum 0xab3424e3, Offset: 0x7d2
// Size: 0xc
function function_4ffc65880523009b( circleindex )
{
    
}

// Namespace br_circle_util
// Params 1
// Checksum 0x26129d29, Offset: 0x7e6
// Size: 0xc
function function_6440ee282f0837ff( circleindex )
{
    
}

// Namespace br_circle_util
// Params 0
// Checksum 0x40642e15, Offset: 0x7fa
// Size: 0x10
function function_62474efd1bbaa12d()
{
    return getdvarint( @"hash_afe2a26cda0aaf42", 0 );
}

// Namespace br_circle_util
// Params 3
// Checksum 0xb2e7aba7, Offset: 0x813
// Size: 0xa4
function function_d9144b81cd9502a9( dangercircleorigin, dangercircleradius, thresholdradius )
{
    if ( isdefined( level.dangercircletickcallbacks ) )
    {
        foreach ( callback in level.dangercircletickcallbacks )
        {
            [[ callback ]]( dangercircleorigin, dangercircleradius, thresholdradius );
        }
    }
}

// Namespace br_circle_util
// Params 0
// Checksum 0xdbba76a3, Offset: 0x8bf
// Size: 0xcc
function function_cfd14b927e016846()
{
    /#
    #/
    
    if ( isdefined( level.var_6b09a5bedb4b1dd9 ) )
    {
        foreach ( var_51b8d621f112d544, callback in level.var_6b09a5bedb4b1dd9 )
        {
            hiddenobjects = [[ callback ]]();
            
            if ( hiddenobjects.size > 0 && !function_62474efd1bbaa12d() )
            {
                hiddenobjects = arrayremoveduplicates( hiddenobjects );
                level.var_af97f7342b1418a9[ var_51b8d621f112d544 ] = arraycombineunique( level.var_af97f7342b1418a9[ var_51b8d621f112d544 ], hiddenobjects );
            }
        }
    }
    
    /#
    #/
}

// Namespace br_circle_util
// Params 1
// Checksum 0xc80ef942, Offset: 0x993
// Size: 0xf2
function function_614ad7680d84e36e( circleindex )
{
    if ( !( isdefined( level.br_multi_circle ) && isdefined( level.br_multi_circle.circles[ circleindex ] ) && isdefined( level.br_multi_circle.circles[ circleindex ].entdata ) ) )
    {
        return ( 0, 0, 0 );
    }
    
    entdata = level.br_multi_circle.circles[ circleindex ].entdata;
    
    if ( !isdefined( entdata ) )
    {
        return ( 0, 0, 0 );
    }
    
    safecircle = entdata.safeent;
    
    if ( !isdefined( safecircle ) )
    {
        return ( 0, 0, 0 );
    }
    
    return ( safecircle.origin[ 0 ], safecircle.origin[ 1 ], 0 );
}

// Namespace br_circle_util
// Params 1
// Checksum 0x2574869a, Offset: 0xa8e
// Size: 0x75
function function_6f1e39c56a1f50fa( circleindex )
{
    entdata = level.br_multi_circle.circles[ circleindex ].entdata;
    
    if ( !isdefined( entdata ) )
    {
        return 0;
    }
    
    safecircle = entdata.safeent;
    
    if ( !isdefined( safecircle ) )
    {
        return 0;
    }
    
    return safecircle.origin[ 2 ];
}

// Namespace br_circle_util
// Params 1
// Checksum 0x30ee3e02, Offset: 0xb0c
// Size: 0x98
function function_ca4e814b4282e560( circleindex )
{
    entdata = level.br_multi_circle.circles[ circleindex ].entdata;
    
    if ( !isdefined( entdata ) )
    {
        return ( 0, 0, 0 );
    }
    
    dangercircle = entdata.dangerent;
    
    if ( !isdefined( dangercircle ) )
    {
        return ( 0, 0, 0 );
    }
    
    return ( dangercircle.origin[ 0 ], dangercircle.origin[ 1 ], 0 );
}

// Namespace br_circle_util
// Params 1
// Checksum 0xbc40fe0c, Offset: 0xbad
// Size: 0x75
function function_bb587506a3fc32d4( circleindex )
{
    entdata = level.br_multi_circle.circles[ circleindex ].entdata;
    
    if ( !isdefined( entdata ) )
    {
        return 0;
    }
    
    dangercircle = entdata.dangerent;
    
    if ( !isdefined( dangercircle ) )
    {
        return 0;
    }
    
    return dangercircle.origin[ 2 ];
}

// Namespace br_circle_util
// Params 3
// Checksum 0x24747d9e, Offset: 0xc2b
// Size: 0x49
function function_b957f8171f4facfb( origin, index, gracedistance )
{
    if ( !level.br_multi_circle_enabled )
    {
        return 0;
    }
    
    return function_a1e9f823dc5b8bb6( origin, level.br_multi_circle.circles, index, gracedistance );
}

// Namespace br_circle_util
// Params 2
// Checksum 0x273e1d10, Offset: 0xc7d
// Size: 0x3f
function ispointinmulticircledanger( origin, gracedistance )
{
    if ( !level.br_multi_circle_enabled )
    {
        return 0;
    }
    
    return function_b5d06748a6540874( origin, level.br_multi_circle.circles, gracedistance );
}

// Namespace br_circle_util
// Params 3
// Checksum 0x29899d0c, Offset: 0xcc5
// Size: 0x49
function function_4266883c02ceeb35( origin, index, gracedistance )
{
    if ( !level.br_multi_circle_enabled )
    {
        return 0;
    }
    
    return function_f64e321007276d10( origin, level.br_multi_circle.circles, index, gracedistance );
}

// Namespace br_circle_util
// Params 2
// Checksum 0x12de630a, Offset: 0xd17
// Size: 0x3f
function function_7dba95e6f0e08799( origin, gracedistance )
{
    if ( !level.br_multi_circle_enabled )
    {
        return 0;
    }
    
    return function_70701a467a8635d2( origin, level.br_multi_circle.circles, gracedistance );
}

// Namespace br_circle_util
// Params 3
// Checksum 0xe82e9d2b, Offset: 0xd5f
// Size: 0x49
function function_554002773c2c21f7( point1, point2, bufferdist )
{
    if ( !level.br_multi_circle_enabled )
    {
        return 0;
    }
    
    return function_7fbd0858705d896d( point1, point2, level.br_multi_circle.circles, bufferdist );
}

// Namespace br_circle_util
// Params 0
// Checksum 0xa078c20f, Offset: 0xdb1
// Size: 0x6e
function function_a698f8bf61cd6736()
{
    multicirclecount = function_7c3401c47d505872();
    
    if ( multicirclecount > 1 )
    {
        var_5e5d05e9bb81b73a = [];
        
        for ( i = 0; i < multicirclecount ; i++ )
        {
            safeorigin = function_614ad7680d84e36e( i );
            var_5e5d05e9bb81b73a[ var_5e5d05e9bb81b73a.size ] = safeorigin;
        }
        
        return var_5e5d05e9bb81b73a;
    }
    
    safeorigin = br_circle::getsafecircleorigin();
    return [ safeorigin ];
}

// Namespace br_circle_util
// Params 0
// Checksum 0x2df6236a, Offset: 0xe27
// Size: 0x6e
function function_803e68e98c8f47a8()
{
    multicirclecount = function_7c3401c47d505872();
    
    if ( multicirclecount > 1 )
    {
        safecircleradii = [];
        
        for ( i = 0; i < multicirclecount ; i++ )
        {
            saferadius = function_6f1e39c56a1f50fa( i );
            safecircleradii[ safecircleradii.size ] = saferadius;
        }
        
        return safecircleradii;
    }
    
    saferadius = br_circle::getsafecircleradius();
    return [ saferadius ];
}

// Namespace br_circle_util
// Params 0
// Checksum 0x1e1f2e13, Offset: 0xe9d
// Size: 0x6e
function function_af7123cc5e0fb96c()
{
    multicirclecount = function_7c3401c47d505872();
    
    if ( multicirclecount > 1 )
    {
        var_7f3d100d4b810850 = [];
        
        for ( i = 0; i < multicirclecount ; i++ )
        {
            dangerorigin = function_ca4e814b4282e560( i );
            var_7f3d100d4b810850[ var_7f3d100d4b810850.size ] = dangerorigin;
        }
        
        return var_7f3d100d4b810850;
    }
    
    dangerorigin = br_circle::getdangercircleorigin();
    return [ dangerorigin ];
}

// Namespace br_circle_util
// Params 0
// Checksum 0xec174bfe, Offset: 0xf13
// Size: 0x6e
function function_1a92b7a87aa9aec6()
{
    multicirclecount = function_7c3401c47d505872();
    
    if ( multicirclecount > 1 )
    {
        dangercircleradii = [];
        
        for ( i = 0; i < multicirclecount ; i++ )
        {
            dangerradius = function_bb587506a3fc32d4( i );
            dangercircleradii[ dangercircleradii.size ] = dangerradius;
        }
        
        return dangercircleradii;
    }
    
    dangerradius = br_circle::getdangercircleradius();
    return [ dangerradius ];
}

// Namespace br_circle_util
// Params 1
// Checksum 0xd4748159, Offset: 0xf89
// Size: 0x3f
function function_3199bf5530fd0bc2( point )
{
    if ( level.br_circle_disabled )
    {
        return 1;
    }
    
    if ( function_7c3401c47d505872() > 1 )
    {
        return function_7dba95e6f0e08799( point );
    }
    
    return br_circle::ispointincurrentsafecircle( point );
}

// Namespace br_circle_util
// Params 2
// Checksum 0xf661e9a9, Offset: 0xfd0
// Size: 0x54
function ispointindangercircle( point, gracedistance )
{
    if ( level.br_circle_disabled || function_32ead8efde5943f5() )
    {
        return 1;
    }
    
    if ( function_7c3401c47d505872() > 1 )
    {
        return ispointinmulticircledanger( point, gracedistance );
    }
    
    return br_circle::function_52d62d96409e20b( point, gracedistance );
}

// Namespace br_circle_util
// Params 2
// Checksum 0xa5226bc9, Offset: 0x102c
// Size: 0xb3, Type: bool
function function_4c6afbf2b757376a( point, checkinclusion = 0 )
{
    foreach ( zone in level.exclusionzones )
    {
        if ( checkinclusion == function_a34dbb66685ce642( zone ) )
        {
            var_421b4e5ea3d799f5 = function_b88d02630ba5e4ec( zone, point );
            
            if ( var_421b4e5ea3d799f5 )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace br_circle_util
// Params 2
// Checksum 0x3b7883ea, Offset: 0x10e8
// Size: 0x2b
function function_9c40d80155aa568e( origin, radius )
{
    if ( isdefined( radius ) )
    {
        radius *= -1;
    }
    
    return ispointindangercircle( origin, radius );
}

// Namespace br_circle_util
// Params 0
// Checksum 0x2445ee9e, Offset: 0x111c
// Size: 0x33
function function_32ead8efde5943f5()
{
    if ( level.br_circle_disabled )
    {
        return 0;
    }
    
    return level.br_circle.dangercircleent.hidden > 0;
}

// Namespace br_circle_util
// Params 0
// Checksum 0x9778a680, Offset: 0x1157
// Size: 0xa4
function logtotalmatchtime()
{
    totaltime = 0;
    
    for ( i = 0; i < level.br_level.br_circleclosetimes.size ; i++ )
    {
        totaltime += level.br_level.br_circleclosetimes[ i ];
    }
    
    for ( i = 0; i < level.br_level.br_circledelaytimes.size ; i++ )
    {
        totaltime += level.br_level.br_circledelaytimes[ i ];
    }
    
    logstring( "br_circle_util::logTotalMatchTime = " + totaltime + " seconds" );
}

// Namespace br_circle_util
// Params 2
// Checksum 0x4965e6bf, Offset: 0x1203
// Size: 0x19a
function function_472c93858e491e0a( testpoint, var_72db3f5cb47f55fd )
{
    if ( br_gametypes::isfeatureenabled( #"hash_7bf340059947e149" ) )
    {
        flags::gameflagwait( "customGametypeCirclesInit" );
    }
    
    if ( level.br_multi_circle_enabled )
    {
        circleinfo = level.br_multi_circle;
    }
    else
    {
        circleinfo = spawnstruct();
        circleinfo.circles[ 0 ] = spawnstruct();
        circleinfo.circles[ 0 ].circlecenters = level.br_level.br_circlecenters;
    }
    
    var_28b10a6ebf033cf9 = br_circle::function_9448d46c0e4395c1();
    
    if ( isdefined( var_28b10a6ebf033cf9 ) )
    {
        return function_75bb47b2efe01017( testpoint, circleinfo.circles, level.br_level.br_circleradii, level.br_level.br_circledelaytimes, level.br_level.br_circleclosetimes, var_72db3f5cb47f55fd, var_28b10a6ebf033cf9, level.br_level.var_c0b6a8a6ac25a9fa, level.br_level.var_40380d99600dbf9, level.br_level.var_9a633989648fd22, level.br_level.var_4589b8916defbe51 );
    }
    
    return function_75bb47b2efe01017( testpoint, circleinfo.circles, level.br_level.br_circleradii, level.br_level.br_circledelaytimes, level.br_level.br_circleclosetimes, var_72db3f5cb47f55fd );
}

// Namespace br_circle_util
// Params 1
// Checksum 0xd871e25f, Offset: 0x13a5
// Size: 0x28
function gettimetilldangerforpoint( testpoint )
{
    times = function_472c93858e491e0a( testpoint );
    return function_b880c0f9998fdd69( times );
}

// Namespace br_circle_util
// Params 1
// Checksum 0xa41ac46a, Offset: 0x13d6
// Size: 0x16
function function_b880c0f9998fdd69( times )
{
    return function_47a14355e28e7a6f( times, 1 );
}

// Namespace br_circle_util
// Params 1
// Checksum 0xe90649d0, Offset: 0x13f5
// Size: 0x28
function function_7d356b8881fbc2ca( testpoint )
{
    times = function_472c93858e491e0a( testpoint );
    return function_ec360f9cd29ebd37( times );
}

// Namespace br_circle_util
// Params 1
// Checksum 0x49f288f9, Offset: 0x1426
// Size: 0x15
function function_ec360f9cd29ebd37( times )
{
    return function_47a14355e28e7a6f( times, 0 );
}

// Namespace br_circle_util
// Params 2
// Checksum 0x94cf6f1d, Offset: 0x1444
// Size: 0xd3
function function_47a14355e28e7a6f( times, state )
{
    circlestarttime = level.br_circle.circleinittime;
    
    if ( !isdefined( circlestarttime ) )
    {
        circlestarttime = gettime();
    }
    
    currentsecs = ( gettime() - circlestarttime ) / 1000;
    time_index = 0;
    
    for ( i = 1; i < times.size ; i++ )
    {
        if ( times[ i ].time <= currentsecs )
        {
            time_index = i;
        }
    }
    
    if ( times[ time_index ].state == state )
    {
        return 0;
    }
    
    if ( time_index == times.size - 1 )
    {
        return 999999;
    }
    
    return times[ time_index + 1 ].time - currentsecs;
}

// Namespace br_circle_util
// Params 2
// Checksum 0x1ce54dba, Offset: 0x151f
// Size: 0x32
function function_b9385c27e6459e42( testpoint, offsetsec )
{
    times = function_472c93858e491e0a( testpoint );
    return function_2ca061d5a99a2a9f( times, offsetsec );
}

// Namespace br_circle_util
// Params 2
// Checksum 0xbe62e60f, Offset: 0x155a
// Size: 0xfa
function function_2ca061d5a99a2a9f( times, offsetsec = 0 )
{
    circlestarttime = level.br_circle.circleinittime;
    
    if ( !isdefined( circlestarttime ) )
    {
        circlestarttime = gettime();
    }
    
    currentsecs = ( gettime() - circlestarttime ) / 1000 + offsetsec;
    time_index = 0;
    
    for ( i = 1; i < times.size ; i++ )
    {
        if ( times[ i ].time <= currentsecs )
        {
            time_index = i;
        }
    }
    
    if ( times[ time_index ].state == 1 )
    {
        return times[ time_index ].circleindex;
    }
    
    if ( time_index == times.size - 1 )
    {
        return ( level.br_level.br_circleradii.size - 1 );
    }
    
    return times[ time_index + 1 ].circleindex;
}

// Namespace br_circle_util
// Params 3, eflags: 0x4
// Checksum 0xa8b33347, Offset: 0x165c
// Size: 0x5a
function private function_ab1a12dfeeeb135f( time, state, circleindex )
{
    s = spawnstruct();
    s.time = time;
    s.state = state;
    s.circleindex = circleindex;
    return s;
}

// Namespace br_circle_util
// Params 2, eflags: 0x4
// Checksum 0xbd36aa72, Offset: 0x16bf
// Size: 0x54, Type: bool
function private function_90531c4463ed1d0e( left, right )
{
    if ( left.time == right.time )
    {
        return ( left.state == 0 );
    }
    
    return left.time <= right.time;
}

// Namespace br_circle_util
// Params 1
// Checksum 0x9220997a, Offset: 0x171c
// Size: 0x3e2
function function_7c14e40ea1f91eac( time )
{
    starttime = level.br_circle.circleinittime;
    
    if ( !isdefined( starttime ) )
    {
        return;
    }
    
    if ( level.br_multi_circle_enabled )
    {
        circleinfo = level.br_multi_circle;
    }
    else
    {
        circleinfo = spawnstruct();
        circleinfo.circles[ 0 ] = spawnstruct();
        circleinfo.circles[ 0 ].circlecenters = level.br_level.br_circlecenters;
    }
    
    circlelist = [];
    
    for ( multicirclecount = 0; multicirclecount < circleinfo.circles.size ; multicirclecount++ )
    {
        deltaseconds = ( time - starttime ) / 1000;
        circledata = spawnstruct();
        circlecenters = circleinfo.circles[ multicirclecount ].circlecenters;
        
        for ( i = 0; i < circlecenters.size - 1 ; i++ )
        {
            if ( br_circle::function_a860b6cc615c4bdb( i ) )
            {
                var_925da1cdaa57c436 = level.br_level.var_4589b8916defbe51[ i ].firstidx;
                var_4b7c960b2e2531df = level.br_level.var_4589b8916defbe51[ i ].lastidx;
                
                for ( segmentidx = var_925da1cdaa57c436; segmentidx <= var_4b7c960b2e2531df ; segmentidx++ )
                {
                    segmenttime = level.br_level.var_9a633989648fd22[ segmentidx ];
                    currentorigin = level.br_level.var_c0b6a8a6ac25a9fa[ segmentidx ];
                    nextorigin = level.br_level.var_c0b6a8a6ac25a9fa[ segmentidx + 1 ];
                    currentradius = level.br_level.var_40380d99600dbf9[ segmentidx ];
                    nextradius = level.br_level.var_40380d99600dbf9[ segmentidx + 1 ];
                    deltaseconds -= segmenttime;
                    
                    if ( deltaseconds <= 0 )
                    {
                        frac = ( deltaseconds + segmenttime ) / segmenttime;
                        frac = clamp( frac, 0, 1 );
                        circledata.origin = vectorlerp( currentorigin, nextorigin, frac );
                        circledata.radius = math::lerp( currentradius, nextradius, frac );
                        break;
                    }
                }
                
                continue;
            }
            
            currentorigin = circlecenters[ i ];
            currentradius = level.br_level.br_circleradii[ i ];
            deltaseconds -= level.br_level.br_circledelaytimes[ i ];
            
            if ( deltaseconds <= 0 )
            {
                circledata.origin = currentorigin;
                circledata.radius = currentradius;
                break;
            }
            
            closetime = level.br_level.br_circleclosetimes[ i ];
            deltaseconds -= closetime;
            
            if ( deltaseconds <= 0 )
            {
                frac = ( deltaseconds + closetime ) / closetime;
                frac = clamp( frac, 0, 1 );
                nextorigin = circlecenters[ i + 1 ];
                circledata.origin = vectorlerp( currentorigin, nextorigin, frac );
                nextradius = level.br_level.br_circleradii[ i + 1 ];
                circledata.radius = math::lerp( currentradius, nextradius, frac );
                break;
            }
        }
        
        if ( deltaseconds > 0 )
        {
            circledata.origin = circlecenters[ circlecenters.size - 1 ];
            circledata.radius = level.br_level.br_circleradii[ circlecenters.size - 1 ];
        }
        
        circlelist[ multicirclecount ] = circledata;
    }
    
    return circlelist;
}

// Namespace br_circle_util
// Params 0
// Checksum 0x73154ab, Offset: 0x1b07
// Size: 0x117
function function_4608172a74445990()
{
    level endon( #"game_ended" );
    level endon( #"prematch_fade_done" );
    
    while ( true )
    {
        name = getdvar( @"hash_7e84750fce4b4038", "" );
        
        if ( name != "" )
        {
            setdvar( @"hash_7e84750fce4b4038", "" );
            function_e45919ed902e208b( name );
        }
        
        origin = getdvar( @"hash_b4e2504b30a81b5d", "" );
        
        if ( origin != "" )
        {
            setdvar( @"hash_b4e2504b30a81b5d", "" );
            output = ( 0, 0, 0 );
            values = strtok( origin, " " );
            
            for ( i = 0; i < 3 ; i++ )
            {
                if ( !isdefined( values[ i ] ) )
                {
                    values[ i ] = 0;
                }
            }
            
            output = ( float( values[ 0 ] ), float( values[ 1 ] ), float( values[ 2 ] ) );
            function_c67d5801bdecca( output );
        }
        
        waitframe();
    }
}

// Namespace br_circle_util
// Params 1, eflags: 0x4
// Checksum 0x90457445, Offset: 0x1c26
// Size: 0x9f
function private function_e45919ed902e208b( name )
{
    foreach ( location in level.var_a2763e53b6bed1ee )
    {
        if ( location.name == name )
        {
            function_c67d5801bdecca( location.origin );
        }
    }
}

// Namespace br_circle_util
// Params 1, eflags: 0x4
// Checksum 0xfac43898, Offset: 0x1ccd
// Size: 0x93
function private function_c67d5801bdecca( origin )
{
    level.br_circle.br_finalcircleoverride = origin;
    br_circle::applycirclesettings();
    level thread br_circle::_precalcsafecirclecenters( level.br_circle.br_finalcircleoverride );
    level thread br_multi_circle::function_b8bba7914486922b();
    
    if ( utility::issharedfuncdefined( #"gametype", #"createc130pathstruct" ) )
    {
        level.infilstruct.c130pathstruct = utility::callsharedfunc( #"gametype", #"createc130pathstruct" );
    }
}

/#

    // Namespace br_circle_util
    // Params 0
    // Checksum 0x1afa6bb6, Offset: 0x1d68
    // Size: 0x1a0, Type: dev
    function savecircles()
    {
        println( "<dev string:x43>" );
        println( "<dev string:x90>" );
        
        for ( i = 0; i < level.br_level.br_circlecenters.size ; i++ )
        {
            origin = level.br_level.br_circlecenters[ i ];
            println( "<dev string:x91>" + i + "<dev string:xb3>" + origin + "<dev string:xb9>" );
            waitframe();
        }
        
        println( "<dev string:x90>" );
        
        for ( i = 0; i < level.br_level.br_circleradii.size ; i++ )
        {
            radius = level.br_level.br_circleradii[ i ];
            println( "<dev string:xbb>" + i + "<dev string:xb3>" + radius + "<dev string:xb9>" );
            waitframe();
        }
        
        println( "<dev string:x90>" );
        multicirclecount = function_7c3401c47d505872();
        
        for ( i = 0; i < multicirclecount ; i++ )
        {
            for ( j = 0; j < level.br_level.br_circlecenters.size ; j++ )
            {
                origin = level.br_multi_circle.circles[ i ].circlecenters[ j ];
                println( "<dev string:xdb>" + i + "<dev string:xfb>" + j + "<dev string:xb3>" + origin + "<dev string:xb9>" );
                waitframe();
            }
        }
        
        println( "<dev string:x90>" );
        println( "<dev string:x10e>" );
    }

#/
