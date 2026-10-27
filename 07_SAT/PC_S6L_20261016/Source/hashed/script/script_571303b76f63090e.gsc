// script_571303b76f63090e  (hash_571303b76f63090e.gscc) (size: 7244 Bytes / 0x1c4c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x309ddff5 (815652853)
// size ...... 7244 (0x1c4c)
// includes .. 10  (offset: 0x1b70)
// strings ... 5   (offset: 0x1bc0)
// dev strs .. 6   (offset: 0x1c04)
// exports ... 15  (offset: 0x110c)
// cseg ...... 0xc1 + 0x104b (0x110c)
// imports ... 69  (offset: 0x1364)
// animtree1 . 0   (offset: 0x1c4c)
// animtree2 . 0   (offset: 0x1c4c)
#using script_2202b0478c57bf0d;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\airdrop_scriptbundle;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\outofbounds;

#namespace namespace_53e78d0e3aa56732;

// Namespace namespace_53e78d0e3aa56732
// Params 0, eflags: 0x5
// Checksum 0x72f5bb35, Offset: 0xdf
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_be920b15eded9ec1", #"airdrop_scriptbundle", &pre_main, undefined );
}

// Namespace namespace_53e78d0e3aa56732
// Params 0, eflags: 0x4
// Checksum 0x831214a2, Offset: 0x108
// Size: 0x42
function private pre_main()
{
    if ( !level.package_airdrop.enabled )
    {
        return;
    }
    
    utility::registersharedfunc( #"start_airdrop", #"hash_f82cfa5aa048f078", &function_a6b97d86b3d5be99 );
    
    /#
        initdevgui();
    #/
}

// Namespace namespace_53e78d0e3aa56732
// Params 1, eflags: 0x4
// Checksum 0x3cbe19e, Offset: 0x152
// Size: 0x1b3
function private function_a6b97d86b3d5be99( airdropsettings )
{
    var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    groundlocation = airdrop_scriptbundle::function_15ad4ce1fcf6748f( airdropsettings.droparea.origin ) ?? airdropsettings.droparea.origin;
    dropheight = airdropsettings.overrideoptions.dropheight ?? var_ef8325c1086c2688.dropheight;
    droplocation = ( groundlocation[ 0 ], groundlocation[ 1 ], groundlocation[ 2 ] + dropheight );
    startinglocation = function_8ef70a4df6596aed( var_ef8325c1086c2688, droplocation );
    angles = generateaxisanglesfromforwardvector( droplocation - startinglocation, ( 0, 0, 1 ) );
    goto = { #angles:angles, #exit:startinglocation, #groundorigin:groundlocation, #origin:droplocation };
    drone = namespace_df4ff65d6946b16b::spawndrone( goto, airdropsettings );
    
    /#
        if ( getdvarint( @"hash_c1f2af137f3c7dd3", 0 ) )
        {
            line( goto.exit, goto.origin, ( 0, 1, 0 ), undefined, undefined, int( 60 / level.framedurationseconds ) );
        }
    #/
    
    drone function_189d2f8a4ccd9ccf();
    return [ drone.package ];
}

// Namespace namespace_53e78d0e3aa56732
// Params 2, eflags: 0x4
// Checksum 0x4a180415, Offset: 0x30e
// Size: 0x176
function private function_8ef70a4df6596aed( var_ef8325c1086c2688, droplocation )
{
    direction = anglestoforward( ( 0, randomfloatrange( 0, 360 ), 0 ) );
    mapcorners = [ level.mapcorners[ 0 ].origin - ( 1, 1, 0 ) * var_ef8325c1086c2688.var_c19302c2e279c016, level.mapcorners[ 1 ].origin + ( 1, 1, 0 ) * var_ef8325c1086c2688.var_c19302c2e279c016 ];
    mapcenter = lerp( mapcorners[ 0 ], mapcorners[ 1 ], 0.5 );
    mapradius = distance2d( mapcorners[ 0 ], mapcorners[ 1 ] ) * 0.5;
    startinglocation = mapcenter + direction * ( mapradius + var_ef8325c1086c2688.var_c19302c2e279c016 );
    startinglocation = function_e0921f2068b7c24e( startinglocation, mapcorners[ 0 ], mapcorners[ 1 ] );
    
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.dangercircleent ) )
    {
        startinglocation = function_c5c62ef62fb61858( startinglocation, br_circle::getdangercircleorigin(), br_circle::getdangercircleradius() + var_ef8325c1086c2688.var_c19302c2e279c016 );
    }
    
    startinglocation = function_83ec641b3775a747( startinglocation ) + ( 0, 0, var_ef8325c1086c2688.var_bde4c92c3498277a );
    assert( isdefined( startinglocation ) );
    return startinglocation;
}

// Namespace namespace_53e78d0e3aa56732
// Params 2, eflags: 0x4
// Checksum 0xcd9c5988, Offset: 0x48d
// Size: 0x6e
function private function_83ec641b3775a747( position, fallbackz )
{
    result = br_public::function_3881e27a5abdb6ff( position, 30000, undefined, trace::create_contents( 0, 1, 1, 1, 0, 0, 0 ) );
    highestpoint = result[ "position" ];
    
    if ( result[ "fraction" ] == 0 )
    {
        return ( highestpoint[ 0 ], highestpoint[ 1 ], fallbackz ?? highestpoint[ 2 ] );
    }
    
    return highestpoint;
}

// Namespace namespace_53e78d0e3aa56732
// Params 3, eflags: 0x4
// Checksum 0xc23ec85e, Offset: 0x504
// Size: 0xbd, Type: bool
function private function_ac45fa86bb645272( start, end, ignored_entities = [] )
{
    trace_radius = 50;
    contents = trace::create_contents( 0, 1, 1, 1, 0, 0, 0 );
    result = trace::sphere_trace( start, end, trace_radius, ignored_entities, contents );
    
    /#
        if ( getdvarint( @"hash_c1f2af137f3c7dd3", 0 ) && result[ "<dev string:x24>" ] != 1 )
        {
            sphere( result[ "<dev string:x2d>" ], trace_radius, ( 1, 0, 0 ), undefined, int( 60 / level.framedurationseconds ) );
        }
    #/
    
    return result[ "fraction" ] == 1;
}

// Namespace namespace_53e78d0e3aa56732
// Params 0
// Checksum 0xf0e81521, Offset: 0x5ca
// Size: 0x241
function function_189d2f8a4ccd9ccf()
{
    drone = self;
    level endon( #"game_ended" );
    drone endon( #"entitydeleted" );
    drone endon( #"drone_emp_leave" );
    drone.var_a1e594c2cae42e0b = 0;
    var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ drone.airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
    direction = vectornormalize2( drone.goto.origin - drone.goto.exit );
    
    while ( true )
    {
        var_cc74f38abceb6551 = [ drone ];
        
        if ( drone.package )
        {
            var_cc74f38abceb6551[ var_cc74f38abceb6551.size ] = drone.package;
        }
        
        nextpoint = function_aae058ee004d27b1( drone.origin, direction, var_ef8325c1086c2688, var_cc74f38abceb6551 );
        drone function_394780a9bd37051d( nextpoint.origin, var_ef8325c1086c2688.var_b23dd50afb4efe09 * 20 );
        var_30c021a7337760a4 = vectordot( direction, drone.goto.origin - nextpoint.origin ) < 0;
        
        if ( var_30c021a7337760a4 )
        {
            drone namespace_df4ff65d6946b16b::function_273cf4bf486db488( var_ef8325c1086c2688 );
        }
        
        if ( nextpoint.var_81c9eba782bceba && var_30c021a7337760a4 )
        {
            break;
        }
        
        if ( nextpoint.origin[ 2 ] > br_public::function_b4d14b7b48e551af() + var_ef8325c1086c2688.var_bde4c92c3498277a )
        {
            break;
        }
    }
    
    exitlocation = drone.origin + direction * 3000 + ( 0, 0, var_ef8325c1086c2688.var_bde4c92c3498277a - var_ef8325c1086c2688.dropheight );
    drone function_394780a9bd37051d( exitlocation, var_ef8325c1086c2688.var_b23dd50afb4efe09 * 20 );
    airdrop_scriptbundle::function_e9dbf2aaef9f1c96( drone.airdropsettings, #"hash_82fb75eefaf0a89a", drone );
    drone namespace_df4ff65d6946b16b::function_526012cdc7caf315();
    namespace_df4ff65d6946b16b::deletedrone( drone );
}

// Namespace namespace_53e78d0e3aa56732
// Params 4, eflags: 0x4
// Checksum 0x60c9e466, Offset: 0x813
// Size: 0x2b1
function private function_aae058ee004d27b1( start, direction, var_ef8325c1086c2688, ignored_entities = [] )
{
    step_size = 3000;
    var_72f51b2376d602e2 = outofbounds::ispointinoutofbounds( start );
    nextorigin = undefined;
    var_84c4e7670ed495fa = 0;
    
    foreach ( yawoffset in [ 0, -22.5, 22.5, -45, 45, -85, 85 ] )
    {
        var_40bae6c80e0ca7b3 = start[ 2 ] - var_ef8325c1086c2688.dropheight;
        var_a54b537f18f96fa6 = function_83ec641b3775a747( start + rotatevector( direction * step_size, ( 0, yawoffset, 0 ) ), var_40bae6c80e0ca7b3 ) + ( 0, 0, var_ef8325c1086c2688.dropheight );
        overshootdistance = var_ef8325c1086c2688.var_b23dd50afb4efe09 * 20 * 1;
        var_91988695d86c7d9b = var_a54b537f18f96fa6 + vectornormalize( var_a54b537f18f96fa6 - start ) * overshootdistance;
        
        if ( var_72f51b2376d602e2 || function_ac45fa86bb645272( start, var_91988695d86c7d9b, ignored_entities ) )
        {
            nextorigin = var_a54b537f18f96fa6;
            var_84c4e7670ed495fa = yawoffset == 0;
            break;
        }
        
        /#
            if ( getdvarint( @"hash_c1f2af137f3c7dd3", 0 ) )
            {
                line( start, var_a54b537f18f96fa6, ( 1, 0, 0 ), undefined, undefined, int( 60 / level.framedurationseconds ) );
            }
        #/
    }
    
    if ( !isdefined( nextorigin ) )
    {
        nextorigin = start + ( 0, 0, 1000 );
    }
    
    var_81c9eba782bceba = outofbounds::ispointinoutofbounds( nextorigin );
    var_39f26ca6ba7bde46 = 3000;
    
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.dangercircleent ) )
    {
        var_81c9eba782bceba |= !br_circle::function_52d62d96409e20b( nextorigin, var_39f26ca6ba7bde46 );
    }
    
    /#
        if ( getdvarint( @"hash_c1f2af137f3c7dd3", 0 ) )
        {
            line( start, nextorigin, var_81c9eba782bceba ? ( 1, 1, 0 ) : ( 0, 1, 0 ), undefined, undefined, int( 60 / level.framedurationseconds ) );
        }
    #/
    
    return { #var_81c9eba782bceba:var_81c9eba782bceba, #var_84c4e7670ed495fa:var_84c4e7670ed495fa, #origin:nextorigin };
}

// Namespace namespace_53e78d0e3aa56732
// Params 2, eflags: 0xc
// Checksum 0x5587bce9, Offset: 0xacd
// Size: 0x271
function private function_394780a9bd37051d( end, speed )
{
    self notify( #"hash_94316aa43ae7c788" );
    self endon( #"hash_94316aa43ae7c788" );
    angle_factor_acceleration = 0.25;
    angle_factor_velocity = 0.25;
    drone = self;
    
    if ( !isdefined( drone.velocity ) )
    {
        drone.velocity = ( 0, 0, 0 );
    }
    
    startvelocity = drone.velocity;
    start = drone.origin;
    drone setscriptablepartstate( "redeploy_drone_relocation_sfx", "kiosk_drone_move_sfx" );
    blendduration = 1.5;
    blendsteps = 10;
    prevposition = start;
    
    for ( i = 1; i <= blendsteps ; i++ )
    {
        blend = float( i ) / blendsteps;
        position = math::smoothstep( start + startvelocity * blend * blendduration, math::function_b642fd3e37ae7eb4( start, end, blend * blendduration * speed ), blend );
        movetime = blendduration / blendsteps;
        prevvelocity = drone.velocity;
        drone.velocity = ( position - prevposition ) / movetime;
        var_dd55a8ea4917a292 = vectornormalize( ( 0, 0, 1 ) + angle_factor_acceleration * ( drone.velocity - prevvelocity ) / movetime / speed + angle_factor_velocity * drone.velocity / speed );
        prevposition = position;
        drone moveto( position, movetime );
        drone rotateto( generateaxisanglesfromupvector( var_dd55a8ea4917a292, drone.angles ), movetime );
        wait movetime;
    }
    
    movetime = distance( drone.origin, end ) / speed;
    drone.velocity = ( end - drone.origin ) / movetime;
    var_dd55a8ea4917a292 = vectornormalize( ( 0, 0, 1 ) + angle_factor_velocity * drone.velocity / speed );
    drone moveto( end, movetime );
    drone rotateto( generateaxisanglesfromupvector( var_dd55a8ea4917a292, drone.angles ), min( blendduration, movetime ) );
    wait movetime;
    drone setscriptablepartstate( "redeploy_drone_relocation_sfx", "kiosk_drone_idle_sfx" );
}

// Namespace namespace_53e78d0e3aa56732
// Params 1, eflags: 0x4
// Checksum 0x889eed66, Offset: 0xd46
// Size: 0x1e
function private droneemp( data )
{
    thread namespace_df4ff65d6946b16b::dronedestroyed( data.attacker );
}

// Namespace namespace_53e78d0e3aa56732
// Params 3, eflags: 0x4
// Checksum 0xd0c383a8, Offset: 0xd6c
// Size: 0x146
function private function_e0921f2068b7c24e( position, mincorner, maxcorner )
{
    profilestart();
    minx = min( mincorner[ 0 ], maxcorner[ 0 ] );
    maxx = max( mincorner[ 0 ], maxcorner[ 0 ] );
    miny = min( mincorner[ 1 ], maxcorner[ 1 ] );
    maxy = max( mincorner[ 1 ], maxcorner[ 1 ] );
    x = clamp( position[ 0 ], minx, maxx );
    y = clamp( position[ 1 ], miny, maxy );
    z = position[ 2 ];
    result = ( x, y, z );
    
    /#
        if ( getdvarint( @"hash_c1f2af137f3c7dd3", 0 ) )
        {
            orientedbox( lerp( ( minx, miny, z ), ( maxx, maxy, z ), 0.5 ), ( maxx - minx, maxy - miny, 0 ), ( 0, 0, 0 ), ( 0, 1, 0 ), undefined, int( 60 / level.framedurationseconds ) );
            line( position, result, ( 0, 1, 0 ), undefined, undefined, int( 60 / level.framedurationseconds ) );
        }
    #/
    
    profilestop();
    return result;
}

// Namespace namespace_53e78d0e3aa56732
// Params 3, eflags: 0x4
// Checksum 0x4be02d6d, Offset: 0xebc
// Size: 0xd4
function private function_c5c62ef62fb61858( position, center, radius )
{
    profilestart();
    distancesq = distance2dsquared( position, center );
    
    if ( distancesq > squared( radius ) )
    {
        result = center + vectornormalize2( position - center ) * radius;
        result = ( result[ 0 ], result[ 1 ], position[ 2 ] );
        
        /#
            if ( getdvarint( @"hash_c1f2af137f3c7dd3", 0 ) )
            {
                circle( center, radius, undefined, ( 0, 1, 0 ), undefined, int( 60 / level.framedurationseconds ), 32 );
                line( position, result, ( 0, 1, 0 ), undefined, undefined, int( 60 / level.framedurationseconds ) );
            }
        #/
        
        profilestop();
        return result;
    }
    else
    {
        profilestop();
        return position;
    }
    
    profilestop();
}

/#

    // Namespace namespace_53e78d0e3aa56732
    // Params 0, eflags: 0x4
    // Checksum 0x2a919fee, Offset: 0xf98
    // Size: 0x2e, Type: dev
    function private initdevgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x3c>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x5a>", "<dev string:x7a>", &function_fbc90b1faef1d768 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_53e78d0e3aa56732
    // Params 1, eflags: 0x4
    // Checksum 0x4607753d, Offset: 0xfce
    // Size: 0x13e, Type: dev
    function private function_fbc90b1faef1d768( params )
    {
        airdropsettings = level.package_airdrop.airdroptypes[ "<dev string:x97>" ];
        var_ef8325c1086c2688 = level.package_airdrop.airdroptypes[ airdropsettings.airdropidentifier ].airdropbehavior[ 0 ].variant_object;
        
        for ( i = 0; i < int( params[ 0 ] ) ; i++ )
        {
            droplocation = airdrop_scriptbundle::function_4c196eb0fa6f3ddb();
            prev = function_8ef70a4df6596aed( var_ef8325c1086c2688, droplocation );
            direction = vectornormalize2( droplocation - prev );
            
            for ( j = 0; j < int( params[ 1 ] ) ; j++ )
            {
                nextpoint = function_aae058ee004d27b1( prev, direction, var_ef8325c1086c2688 );
                prev = nextpoint.origin;
                waitframe();
                var_30c021a7337760a4 = vectordot( direction, droplocation - nextpoint.origin ) < 0;
                
                if ( nextpoint.var_81c9eba782bceba && var_30c021a7337760a4 )
                {
                    break;
                }
            }
        }
    }

#/
