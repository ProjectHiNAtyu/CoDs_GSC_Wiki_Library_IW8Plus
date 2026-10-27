// script_77aea2ef08e83635  (hash_77aea2ef08e83635.gscc) (size: 19049 Bytes / 0x4a69 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4a649d2f (1248107823)
// size ...... 19049 (0x4a69)
// includes .. 4   (offset: 0x46bd)
// strings ... 57  (offset: 0x46dd)
// dev strs .. 6   (offset: 0x4a19)
// exports ... 43  (offset: 0x33fd)
// cseg ...... 0x47c + 0x2f81 (0x33fd)
// imports ... 98  (offset: 0x3ab5)
// animtree1 . 0   (offset: 0x4a69)
// animtree2 . 0   (offset: 0x4a69)
#using script_3d2770dc09c1243;
#using scripts\common\trace;
#using scripts\mp\bots\bots_util;
#using scripts\mp\matchdata;

#namespace mit_windows;

// Namespace mit_windows
// Params 0
// Checksum 0x1f2f1801, Offset: 0x49a
// Size: 0x16, Type: bool
function isinitialized()
{
    return isdefined( level.mit.window );
}

// Namespace mit_windows
// Params 0
// Checksum 0x63a401f4, Offset: 0x4b9
// Size: 0x30, Type: bool
function function_119b9a096f5511d2()
{
    assert( isinitialized() );
    return level.mit.window.windows.size > 0;
}

// Namespace mit_windows
// Params 0
// Checksum 0x9a8ce2f0, Offset: 0x4f2
// Size: 0x8b
function function_8232085c6a3ac69c()
{
    const_timeout_ms = 10000;
    starttime = gettime();
    endtime = starttime + const_timeout_ms;
    
    while ( true )
    {
        result = function_5d39ec37f7d4bf07();
        
        if ( isdefined( result ) )
        {
            if ( result == 1 )
            {
                init();
                return;
            }
            
            assert( isstring( result ) );
            function_80d75f73eeda54d5( result );
            return;
        }
        
        wait 1;
        
        if ( gettime() >= endtime )
        {
            function_80d75f73eeda54d5();
            return;
        }
    }
}

// Namespace mit_windows
// Params 1, eflags: 0x4
// Checksum 0x5f856db2, Offset: 0x585
// Size: 0x58
function private function_80d75f73eeda54d5( errorstring )
{
    level.mit.window = { #windows:[] };
    reportstring = "Can not test windows.";
    
    if ( isdefined( errorstring ) )
    {
        reportstring += " " + errorstring;
    }
    
    outputlog( reportstring );
}

// Namespace mit_windows
// Params 0, eflags: 0x4
// Checksum 0xec86e7b4, Offset: 0x5e5
// Size: 0x133
function private init()
{
    level.mit.window = {};
    level.mit.window.windows = getwindows();
    
    if ( level.mit.window.windows.size == 0 )
    {
        outputlog( "No windows to test." );
        return;
    }
    
    level.mit.window.total = level.mit.window.windows.size * 2;
    level.mit.window.success = 0;
    level.mit.window.failure = 0;
    level.mit.window.var_b719ce7055051128 = [ &function_a4c94f79bc096b34, &function_84a694c01586080f, &function_b5aaa448239fe582 ];
    preprocess();
    
    /#
        thread function_c1b4d0d8588e7eac();
    #/
}

// Namespace mit_windows
// Params 0, eflags: 0x4
// Checksum 0x791e2048, Offset: 0x720
// Size: 0x379
function private preprocess()
{
    /#
        if ( mit::function_168f26942e588420() )
        {
            return;
        }
    #/
    
    traversalonly = getdvarint( @"hash_e4b76c277384c1ab", 1 );
    
    for ( wndidx = level.mit.window.windows.size - 1; wndidx >= 0 ; wndidx-- )
    {
        window = level.mit.window.windows[ wndidx ];
        
        for ( caseidx = window.testcases.size - 1; caseidx >= 0 ; caseidx-- )
        {
            testcase = window.testcases[ caseidx ];
            
            if ( traversalonly && testcase.hastraversal != 1 )
            {
                if ( caseidx >= 0 && caseidx < window.testcases.size )
                {
                    if ( caseidx < window.testcases.size - 1 )
                    {
                        window.testcases[ caseidx ] = window.testcases[ window.testcases.size - 1 ];
                    }
                    
                    window.testcases[ window.testcases.size - 1 ] = undefined;
                }
                
                if ( level.mit.window.total > 0 )
                {
                    level.mit.window.total--;
                }
                
                continue;
            }
            
            if ( function_585ac249181c7b39( window, testcase ) )
            {
                window report( testcase.failedreason, undefined, testcase );
                
                if ( caseidx >= 0 && caseidx < window.testcases.size )
                {
                    if ( caseidx < window.testcases.size - 1 )
                    {
                        window.testcases[ caseidx ] = window.testcases[ window.testcases.size - 1 ];
                    }
                    
                    window.testcases[ window.testcases.size - 1 ] = undefined;
                }
                
                level.mit.window.failure++;
            }
        }
        
        if ( window.testcases.size == 0 )
        {
            if ( wndidx >= 0 && wndidx < level.mit.window.windows.size )
            {
                if ( wndidx < level.mit.window.windows.size - 1 )
                {
                    level.mit.window.windows[ wndidx ] = level.mit.window.windows[ level.mit.window.windows.size - 1 ];
                }
                
                level.mit.window.windows[ level.mit.window.windows.size - 1 ] = undefined;
            }
        }
    }
    
    if ( level.mit.window.total > 0 )
    {
        printprogress();
    }
}

// Namespace mit_windows
// Params 2, eflags: 0x4
// Checksum 0x4969b6e5, Offset: 0xaa1
// Size: 0xd3, Type: bool
function private function_585ac249181c7b39( window, testcase )
{
    if ( !isdefined( testcase.failedreason ) )
    {
        return false;
    }
    
    foreach ( var_b5713c49dcaf124b in level.mit.window.var_b719ce7055051128 )
    {
        var_1ee3632a6282ae54 = function_34abfd71ce6b970c( window, testcase, var_b5713c49dcaf124b );
        
        if ( !isdefined( var_1ee3632a6282ae54.failedreason ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace mit_windows
// Params 0, eflags: 0x4
// Checksum 0x6dccae8, Offset: 0xb7d
// Size: 0xcc
function private getwindows()
{
    windows = [];
    
    while ( true )
    {
        edgepoints = function_85f338f1f2c83bbb();
        
        if ( !isdefined( edgepoints ) )
        {
            break;
        }
        
        assert( edgepoints.size == 6 );
        ptidx = 0;
        edges = [];
        
        for ( edgeidx = 0; edgeidx < 3 ; edgeidx++ )
        {
            edge = [ edgepoints[ ptidx ], edgepoints[ ptidx + 1 ] ];
            edges[ edges.size ] = edge;
            ptidx += 2;
        }
        
        window = getwindow( edges );
        
        if ( !isdefined( window ) )
        {
            continue;
        }
        
        if ( window function_3fe1b83a40a3bef9( windows ) )
        {
            continue;
        }
        
        windows[ windows.size ] = window;
    }
    
    return windows;
}

// Namespace mit_windows
// Params 1, eflags: 0x4
// Checksum 0xf217a858, Offset: 0xc52
// Size: 0x108
function private getwindow( edges )
{
    assert( edges.size == 3 );
    window = { #vertedges:[ edges[ 1 ], edges[ 2 ] ], #horiedge:edges[ 0 ] };
    window.height = function_1105a9c803bdd48d( window );
    
    if ( !isdefined( window.height ) )
    {
        return;
    }
    
    horivector = window.horiedge[ 1 ] - window.horiedge[ 0 ];
    horivector = vectornormalize2( horivector );
    normalvector = ( -1 * horivector[ 1 ], horivector[ 0 ], 0 );
    window.normalvector = normalvector;
    window.var_19ee8de22b08132e = ( window.horiedge[ 0 ] + window.horiedge[ 1 ] ) * 0.5;
    window.testcases = function_f5ef4a7359c6dcff( window );
    return window;
}

// Namespace mit_windows
// Params 1, eflags: 0x4
// Checksum 0x3e0dac62, Offset: 0xd63
// Size: 0x63, Type: bool
function private function_3fe1b83a40a3bef9( otherwindows )
{
    var_a14cb84e7c135560 = squared( 30 );
    
    for ( i = otherwindows.size - 1; i >= 0 ; i-- )
    {
        if ( distancesquared( otherwindows[ i ].var_19ee8de22b08132e, self.var_19ee8de22b08132e ) < var_a14cb84e7c135560 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace mit_windows
// Params 1, eflags: 0x4
// Checksum 0xc94c22ba, Offset: 0xdcf
// Size: 0x1ce
function private function_1105a9c803bdd48d( window )
{
    centerpos = ( window.vertedges[ 0 ][ 1 ] + window.vertedges[ 1 ][ 1 ] ) * 0.5;
    upperdist = window.vertedges[ 0 ][ 1 ][ 2 ] - window.vertedges[ 0 ][ 0 ][ 2 ];
    startpos = ( centerpos[ 0 ], centerpos[ 1 ], window.horiedge[ 0 ][ 2 ] + upperdist / 2 );
    endpos = startpos + ( 0, 0, upperdist * 2 );
    upresult = function_606349b60a2d126d( startpos, endpos );
    
    if ( !isdefined( upresult ) )
    {
        return;
    }
    
    var_41faa792cc995772 = 1;
    
    if ( distance2dsquared( upresult[ "shape_position" ], upresult[ "position" ] ) > var_41faa792cc995772 )
    {
        startpos = ( upresult[ "position" ][ 0 ], upresult[ "position" ][ 1 ], startpos[ 2 ] );
        endpos = startpos + ( 0, 0, upperdist * 2 );
        upresult = function_606349b60a2d126d( startpos, endpos );
        
        if ( !isdefined( upresult ) )
        {
            return;
        }
    }
    
    endpos = startpos - ( 0, 0, upperdist );
    downresult = function_606349b60a2d126d( startpos, endpos );
    
    if ( !isdefined( downresult ) )
    {
        return;
    }
    
    /#
        if ( getdvarint( @"hash_bd2dd3658c87d89c", 0 ) )
        {
            window.drawheight_startpos = startpos;
            window.var_ef0b2e0daa75b515 = upresult[ "<dev string:x24>" ];
            window.var_f06b60edfe4bb52e = upresult[ "<dev string:x33>" ];
            window.var_cc34695025aa82ba = downresult[ "<dev string:x24>" ];
            window.var_8f9143c8aa398be3 = downresult[ "<dev string:x33>" ];
        }
    #/
    
    return upresult[ "position" ][ 2 ] - downresult[ "position" ][ 2 ];
}

// Namespace mit_windows
// Params 2, eflags: 0x4
// Checksum 0xcf49631f, Offset: 0xfa6
// Size: 0x66
function private function_606349b60a2d126d( startpos, endpos )
{
    contents = physics_createcontents( [ "physicscontents_aiclip", "physicscontents_vehicle" ] );
    result = trace::sphere_trace( startpos, endpos, 13.5, undefined, contents );
    
    if ( result[ "hittype" ] == "hittype_none" )
    {
        return;
    }
    
    return result;
}

// Namespace mit_windows
// Params 1, eflags: 0x4
// Checksum 0xfef8b3c4, Offset: 0x1015
// Size: 0x1a5
function private function_f5ef4a7359c6dcff( window )
{
    var_e9e430743a5bd1c8 = 30;
    var_f8838bf62765cc98 = [ 1, -1 ];
    testcases = [];
    
    foreach ( dirmultiplier in var_f8838bf62765cc98 )
    {
        testcase = function_3fa42a693dffe676( window, window.normalvector * dirmultiplier, var_e9e430743a5bd1c8 );
        testcases[ testcases.size ] = testcase;
    }
    
    for ( i = 0; i <= 1 ; i++ )
    {
        var_edbec6990fab270f = testcases[ i ];
        
        if ( var_edbec6990fab270f.failedreason )
        {
            continue;
        }
        
        InvalidOpCode( 0x5e, 1, i );
        // Unknown operator ( 0x5e, t11, Black Ops 7 )
    }
    
    return testcases;
}

// Namespace mit_windows
// Params 2, eflags: 0x44 variadic
// Checksum 0x861aabbf, Offset: 0x11c3
// Size: 0x3c
function private function_3fa42a693dffe676( ... )
{
    testcase = {};
    testcase.failedreason = function_a885948fe8041a7a( testcase, flat_args( vararg, varargcount ) );
    return testcase;
}

// Namespace mit_windows
// Params 6, eflags: 0x4
// Checksum 0xefc75c3d, Offset: 0x1208
// Size: 0x20a
function private function_a885948fe8041a7a( testcase, window, normalvector, var_46968e0d9c688ea, var_25e60ba73eb305d5 = undefined, useshapecast = 0 )
{
    windowcenter = window.var_19ee8de22b08132e;
    
    if ( !isdefined( var_25e60ba73eb305d5 ) )
    {
        var_25e60ba73eb305d5 = windowcenter + normalvector * var_46968e0d9c688ea + ( 0, 0, 13.5 );
    }
    
    testcase.var_25e60ba73eb305d5 = var_25e60ba73eb305d5;
    testcase.forwardvector = -1 * normalvector;
    
    if ( useshapecast )
    {
        var_bf5f886705e114e6 = function_4d13d71ad147e776( var_25e60ba73eb305d5 );
    }
    else
    {
        var_bf5f886705e114e6 = function_32923acbaf5a7fb5( var_25e60ba73eb305d5 );
    }
    
    testcase.var_bf5f886705e114e6 = var_bf5f886705e114e6;
    var_d528bd4bd0fb6192 = getdvarfloat( @"hash_6de9ba74d03c1152", 70 );
    
    if ( window.height < var_d528bd4bd0fb6192 )
    {
        var_1b9c44c04b3fe28c = getdvarfloat( @"hash_124f3e04b9266f4c", 50 );
        
        if ( window.height < var_1b9c44c04b3fe28c )
        {
            function_41c7a00a88ad06ff( testcase, "lower than player crouch height: " + var_1b9c44c04b3fe28c );
        }
        else
        {
            function_41c7a00a88ad06ff( testcase, "lower than player stand height: " + var_d528bd4bd0fb6192 );
        }
    }
    
    if ( !isdefined( var_bf5f886705e114e6 ) )
    {
        return "no clip";
    }
    
    var_9467f138ea4ce063 = squared( 100 );
    var_cf3afdf8fd8a1ef = bots_util_mp::function_1882f18076610076( var_bf5f886705e114e6 );
    
    if ( !isdefined( var_cf3afdf8fd8a1ef ) || distancesquared( var_bf5f886705e114e6, var_cf3afdf8fd8a1ef ) > var_9467f138ea4ce063 )
    {
        function_41c7a00a88ad06ff( testcase, "no navmesh" );
    }
    
    var_4b8b4139d5203574 = getdvarfloat( @"hash_daa58920e36e9d34", 88 );
    var_266e12dabf9a0277 = windowcenter[ 2 ] - var_bf5f886705e114e6[ 2 ];
    
    if ( useshapecast )
    {
        var_266e12dabf9a0277 += 13.5;
    }
    
    testcase.var_266e12dabf9a0277 = var_266e12dabf9a0277;
    
    if ( var_266e12dabf9a0277 > var_4b8b4139d5203574 )
    {
        /#
            testcase.var_2d24f516c91386da = var_266e12dabf9a0277;
        #/
        
        return "not close to ground";
    }
}

// Namespace mit_windows
// Params 1, eflags: 0x4
// Checksum 0x7ccb3226, Offset: 0x141a
// Size: 0x8d
function private function_32923acbaf5a7fb5( position )
{
    var_3f4643679b6da444 = -25000;
    endposition = position + ( 0, 0, var_3f4643679b6da444 );
    contents = physics_createcontents( [ "physicscontents_aiclip", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_water" ] );
    result = trace::ray_trace( position, endposition, undefined, contents );
    
    if ( result[ "hittype" ] == "hittype_none" )
    {
        return;
    }
    
    return result[ "position" ];
}

// Namespace mit_windows
// Params 1, eflags: 0x4
// Checksum 0xa7f369b2, Offset: 0x14b0
// Size: 0x69
function private function_4d13d71ad147e776( position )
{
    var_3f4643679b6da444 = -25000;
    endposition = position + ( 0, 0, var_3f4643679b6da444 );
    result = trace::sphere_trace( position, endposition, 13.5, isbot( self ) ? self : undefined );
    
    if ( result[ "hittype" ] == "hittype_none" )
    {
        return;
    }
    
    return result[ "shape_position" ];
}

// Namespace mit_windows
// Params 2, eflags: 0x4
// Checksum 0x9f6da478, Offset: 0x1522
// Size: 0x56
function private function_41c7a00a88ad06ff( testcase, comment )
{
    if ( !isdefined( testcase.var_63918581a3ec5f55 ) )
    {
        testcase.var_63918581a3ec5f55 = comment;
        return;
    }
    
    testcase.var_63918581a3ec5f55 += ", " + comment;
}

// Namespace mit_windows
// Params 1, eflags: 0x4
// Checksum 0xc9cb4d11, Offset: 0x1580
// Size: 0x1a
function private function_a4c94f79bc096b34( testcase )
{
    return testcase.forwardvector * -1;
}

// Namespace mit_windows
// Params 1, eflags: 0x4
// Checksum 0x8eb5f466, Offset: 0x15a3
// Size: 0x2c
function private function_84a694c01586080f( testcase )
{
    return ( testcase.forwardvector[ 1 ], -1 * testcase.forwardvector[ 0 ], 0 );
}

// Namespace mit_windows
// Params 1, eflags: 0x4
// Checksum 0xb09dfad, Offset: 0x15d8
// Size: 0x2c
function private function_b5aaa448239fe582( testcase )
{
    return ( -1 * testcase.forwardvector[ 1 ], testcase.forwardvector[ 0 ], 0 );
}

// Namespace mit_windows
// Params 0, eflags: 0x4
// Checksum 0xd69e1df, Offset: 0x160d
// Size: 0x2ea
function private function_d709d81a90297a31()
{
    assert( isdefined( level.mit.window ) && level.mit.window.windows.size > 0 );
    var_952c9df95d710885 = randomint( level.mit.window.windows.size );
    targetwindow = level.mit.window.windows[ var_952c9df95d710885 ];
    var_ce208a522ee0a94d = function_88ef05a65442ca96( targetwindow );
    
    if ( !isdefined( var_ce208a522ee0a94d ) )
    {
        for ( windowindex = level.mit.window.windows.size - 1; windowindex >= 0 ; windowindex-- )
        {
            if ( windowindex == var_952c9df95d710885 )
            {
                continue;
            }
            
            window = level.mit.window.windows[ windowindex ];
            var_4c4aeaa4d6c042ee = function_88ef05a65442ca96( window );
            
            if ( isdefined( var_4c4aeaa4d6c042ee ) )
            {
                var_952c9df95d710885 = windowindex;
                targetwindow = window;
                var_ce208a522ee0a94d = var_4c4aeaa4d6c042ee;
                break;
            }
        }
    }
    
    if ( !isdefined( var_ce208a522ee0a94d ) )
    {
        return;
    }
    
    var_3272f9ed96f6f3c7 = targetwindow.testcases[ var_ce208a522ee0a94d ];
    
    if ( var_ce208a522ee0a94d >= 0 && var_ce208a522ee0a94d < targetwindow.testcases.size )
    {
        if ( var_ce208a522ee0a94d < targetwindow.testcases.size - 1 )
        {
            targetwindow.testcases[ var_ce208a522ee0a94d ] = targetwindow.testcases[ targetwindow.testcases.size - 1 ];
        }
        
        targetwindow.testcases[ targetwindow.testcases.size - 1 ] = undefined;
    }
    
    if ( targetwindow.testcases.size == 0 )
    {
        if ( var_952c9df95d710885 >= 0 && var_952c9df95d710885 < level.mit.window.windows.size )
        {
            if ( var_952c9df95d710885 < level.mit.window.windows.size - 1 )
            {
                level.mit.window.windows[ var_952c9df95d710885 ] = level.mit.window.windows[ level.mit.window.windows.size - 1 ];
            }
            
            level.mit.window.windows[ level.mit.window.windows.size - 1 ] = undefined;
        }
    }
    
    return [ targetwindow, var_3272f9ed96f6f3c7 ];
}

// Namespace mit_windows
// Params 1, eflags: 0x4
// Checksum 0xde39ffe9, Offset: 0x1900
// Size: 0x67
function private function_88ef05a65442ca96( window )
{
    if ( !function_fb843b81d6631640( window ) )
    {
        return;
    }
    
    for ( caseindex = window.testcases.size - 1; caseindex >= 0 ; caseindex-- )
    {
        testcase = window.testcases[ caseindex ];
        
        if ( function_59fbc545940135b8( testcase ) )
        {
            return caseindex;
        }
    }
}

// Namespace mit_windows
// Params 1, eflags: 0x4
// Checksum 0xd3a6ba2, Offset: 0x1970
// Size: 0xef, Type: bool
function private function_fb843b81d6631640( window )
{
    var_f3efd97cfb7f03a9 = squared( 60 );
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player.mit.var_c4a2055fc5335ca7 ) )
        {
            continue;
        }
        
        distsq = distancesquared( window.var_19ee8de22b08132e, player.mit.var_c4a2055fc5335ca7.var_19ee8de22b08132e );
        
        if ( distsq < var_f3efd97cfb7f03a9 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace mit_windows
// Params 1, eflags: 0x4
// Checksum 0x6cbd167, Offset: 0x1a68
// Size: 0xef, Type: bool
function private function_59fbc545940135b8( testcase )
{
    var_f3efd97cfb7f03a9 = squared( 50 );
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player.mit.var_edbec6990fab270f ) )
        {
            continue;
        }
        
        distsq = distancesquared( testcase.var_25e60ba73eb305d5, player.mit.var_edbec6990fab270f.var_25e60ba73eb305d5 );
        
        if ( distsq < var_f3efd97cfb7f03a9 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace mit_windows
// Params 0
// Checksum 0x11d2020, Offset: 0x1b60
// Size: 0x8d
function testprocess()
{
    result = function_d709d81a90297a31();
    
    if ( !isdefined( result ) )
    {
        var_4adbd46a987c2f21 = 100;
        var_825a07ca6f9b0139 = bots_util_mp::function_478281ff275ed942();
        mit::botteleport( var_825a07ca6f9b0139, var_4adbd46a987c2f21 );
        return;
    }
    
    self.mit.onplayerkilled = &onplayerkilled;
    [ window, testcase ] = result;
    testwindow( window, testcase );
}

// Namespace mit_windows
// Params 2
// Checksum 0x57274211, Offset: 0x1bf5
// Size: 0xf7
function testwindow( window, testcase )
{
    self.mit.var_c4a2055fc5335ca7 = window;
    
    if ( function_6890899be6e33d9f( window, testcase, 0 ) )
    {
        return;
    }
    
    foreach ( var_b5713c49dcaf124b in level.mit.window.var_b719ce7055051128 )
    {
        var_1ee3632a6282ae54 = function_34abfd71ce6b970c( window, testcase, var_b5713c49dcaf124b );
        
        if ( function_6890899be6e33d9f( window, var_1ee3632a6282ae54, 1 ) )
        {
            return;
        }
    }
    
    var_1ee3632a6282ae54 = function_e4932d15dc44d60b( window, testcase );
    function_6890899be6e33d9f( window, var_1ee3632a6282ae54, 1 );
}

// Namespace mit_windows
// Params 3, eflags: 0x4
// Checksum 0xa746db67, Offset: 0x1cf4
// Size: 0xd7
function private function_6890899be6e33d9f( window, testcase, var_7c9d559c0425d4b7 )
{
    if ( isdefined( testcase.failedreason ) )
    {
        return 0;
    }
    
    self.mit.reportdata = undefined;
    self.mit.var_edbec6990fab270f = testcase;
    self.mit.stepresult = 0;
    function_9a524db5082826c7( window, testcase, var_7c9d559c0425d4b7 );
    self.mit.var_edbec6990fab270f = undefined;
    endtest = !( isdefined( self.mit.reportdata ) && self.mit.reportdata.vararg[ 0 ] == "timeout" );
    return endtest;
}

// Namespace mit_windows
// Params 3, eflags: 0x4
// Checksum 0x4f46afaa, Offset: 0x1dd4
// Size: 0x294
function private function_9a524db5082826c7( window, testcase, var_7c9d559c0425d4b7 )
{
    startpos = testcase.var_bf5f886705e114e6;
    var_4adbd46a987c2f21 = 100;
    var_d23fed382ff6fc8 = mit::botteleport( startpos, var_4adbd46a987c2f21 );
    
    if ( isdefined( var_d23fed382ff6fc8 ) )
    {
        function_93fc4cdd034af81( 0, "teleport failed/" + var_d23fed382ff6fc8, self.origin, testcase );
        return;
    }
    
    windowcenter = window.var_19ee8de22b08132e + ( 0, 0, 10 );
    forwardvector = testcase.forwardvector;
    targetpos = windowcenter + forwardvector * 50;
    self botsetflag( "disable_movement", 1 );
    bots_util_mp::function_cdc8a7497ee4f596( targetpos );
    
    if ( var_7c9d559c0425d4b7 )
    {
        var_6a5259a568f9bc15 = 10;
        
        while ( var_6a5259a568f9bc15 > 0 && function_52959484d548f3cd( self geteye(), targetpos ) )
        {
            var_6a5259a568f9bc15--;
            weapon = self getcurrentweapon();
            self setweaponammoclip( weapon, weaponclipsize( weapon ) );
            self botpressbutton( "attack", 0.5 );
            wait 1;
        }
    }
    
    self botsetflag( "disable_movement", 0 );
    childthread lookthread( forwardvector );
    var_16843600e17c04e8 = 0.05;
    var_e106a38859e99de2 = 10;
    var_29e29035992ae27e = mit::function_39ee610d2625a324( var_e106a38859e99de2 );
    starttime = mit::function_9f2a98ba9eb78c4d();
    endtime = starttime + var_29e29035992ae27e;
    
    while ( true )
    {
        if ( mit::function_9f2a98ba9eb78c4d() >= endtime )
        {
            function_93fc4cdd034af81( 0, "timeout", self.origin, testcase, targetpos );
            return;
        }
        
        if ( function_b23593f7a29527df( forwardvector, windowcenter ) )
        {
            self setvelocity( ( 0, 0, 0 ) );
            var_27ed55f98da10f58 = self.origin;
            self setorigin( startpos );
            
            if ( isdefined( testcase.var_63918581a3ec5f55 ) )
            {
                function_93fc4cdd034af81( 0, "passed but treated as failed", self.origin, testcase, targetpos );
                return;
            }
            
            if ( testcase.hastraversal == 0 )
            {
                function_93fc4cdd034af81( 0, "no traversal", self.origin, testcase, targetpos );
                return;
            }
            
            function_93fc4cdd034af81( 1, "passed", var_27ed55f98da10f58, testcase, targetpos );
            return;
        }
        
        anglestotarget = vectortoangles( targetpos - self.origin );
        self botsetscriptmove( anglestotarget[ 1 ], var_16843600e17c04e8, 1 );
        wait var_16843600e17c04e8;
    }
}

// Namespace mit_windows
// Params 2, eflags: 0x4
// Checksum 0x3c135e5b, Offset: 0x2070
// Size: 0x52, Type: bool
function private function_52959484d548f3cd( startpos, endpos )
{
    contents = physics_createcontents( [ "physicscontents_glass" ] );
    result = trace::ray_trace( startpos, endpos, undefined, contents );
    return result[ "hittype" ] != "hittype_none";
}

// Namespace mit_windows
// Params 2, eflags: 0x4
// Checksum 0x78284b4e, Offset: 0x20cb
// Size: 0x58, Type: bool
function private function_b23593f7a29527df( forwardvector, windowcenter )
{
    const_distance_sq = squared( 5 );
    var_34c8a3093cd49452 = windowcenter - self.origin;
    
    if ( length2dsquared( var_34c8a3093cd49452 ) < const_distance_sq )
    {
        return false;
    }
    
    return vectordot2( forwardvector, var_34c8a3093cd49452, 0 ) < 0;
}

// Namespace mit_windows
// Params 1, eflags: 0x4
// Checksum 0xb5c3c159, Offset: 0x212c
// Size: 0xc2
function private lookthread( forwardvector )
{
    var_c6e672acca58fb08 = 1;
    var_ee4d3e2e3f8c6146 = 1.5;
    const_distance = 50;
    offsetindex = 0;
    var_f50788b531749b7e = [ ( 0, 0, 0 ), ( 0, 0, -1 * const_distance ), ( 0, 0, 0 ), ( 0, 0, const_distance ) ];
    
    while ( true )
    {
        var_2d345a7c008ae4f9 = var_f50788b531749b7e[ offsetindex ];
        offsetindex = ( offsetindex + 1 ) % var_f50788b531749b7e.size;
        bots_util_mp::function_26196082e7a55bbd( self geteye() + forwardvector * const_distance + var_2d345a7c008ae4f9, var_c6e672acca58fb08 );
        wait var_ee4d3e2e3f8c6146;
    }
}

// Namespace mit_windows
// Params 3, eflags: 0x4
// Checksum 0xe99aa9d5, Offset: 0x21f6
// Size: 0x7d
function private function_34abfd71ce6b970c( window, testcase, var_b5713c49dcaf124b )
{
    const_move_distance = 10;
    movedir = [[ var_b5713c49dcaf124b ]]( testcase );
    var_c152c7a2a688f3f7 = testcase.var_25e60ba73eb305d5 + movedir * const_move_distance;
    var_1ee3632a6282ae54 = function_3fa42a693dffe676( window, testcase.forwardvector * -1, 0, var_c152c7a2a688f3f7 );
    return var_1ee3632a6282ae54;
}

// Namespace mit_windows
// Params 2, eflags: 0x4
// Checksum 0xe47c53c6, Offset: 0x227c
// Size: 0x39
function private function_e4932d15dc44d60b( window, testcase )
{
    return function_3fa42a693dffe676( window, testcase.forwardvector * -1, 0, testcase.var_25e60ba73eb305d5, 1 );
}

// Namespace mit_windows
// Params 0
// Checksum 0xc3c4c00a, Offset: 0x22be
// Size: 0x104
function endhandler()
{
    if ( !isdefined( self.mit.var_c4a2055fc5335ca7 ) )
    {
        return;
    }
    
    if ( isdefined( self.mit.reportdata ) )
    {
        report( flat_args( self.mit.reportdata.vararg, self.mit.reportdata.varargcount ) );
        
        if ( self.mit.stepresult == 0 )
        {
            level.mit.window.failure++;
        }
        else
        {
            level.mit.window.success++;
        }
    }
    
    self.mit.var_c4a2055fc5335ca7 = undefined;
    self.mit.reportdata = undefined;
    self botsetflag( "disable_movement", 0 );
    printprogress();
}

// Namespace mit_windows
// Params 0, eflags: 0x4
// Checksum 0xfe61db30, Offset: 0x23ca
// Size: 0x113
function private printprogress()
{
    finished = level.mit.window.success + level.mit.window.failure;
    total = level.mit.window.total;
    ratio = finished / total;
    logstring( "MIT/Window - current progress is: " + ratio + "(" + finished + " of " + total + ")" );
    
    if ( finished >= total )
    {
        reportstring = "Test result: " + total + " test cases, " + level.mit.window.success + " successes, " + level.mit.window.failure + " failures.";
        outputlog( reportstring );
    }
}

// Namespace mit_windows
// Params 1, eflags: 0x4
// Checksum 0x3c8e4908, Offset: 0x24e5
// Size: 0x3f
function private onplayerkilled( deathdata )
{
    if ( !isbot( self ) )
    {
        return;
    }
    
    function_93fc4cdd034af81( 0, "death", self.origin, self.mit.var_edbec6990fab270f );
}

// Namespace mit_windows
// Params 3, eflags: 0x44 variadic
// Checksum 0x72ef0c06, Offset: 0x252c
// Size: 0x5f
function private function_93fc4cdd034af81( stepresult, ... )
{
    self.mit.stepresult = stepresult;
    self.mit.reportdata = { #vararg:vararg, #varargcount:varargcount };
}

// Namespace mit_windows
// Params 4, eflags: 0x4
// Checksum 0xeb532806, Offset: 0x2593
// Size: 0x5db
function private report( situation, lastposition, testcase, targetpos )
{
    if ( !level.mit.window.var_bc145a5e5382a8f9 )
    {
        header = "#time; #situation; #comment; #bot; #windowPos; #lastPosition; #startPos; #targetPos; #windowHeight; #heightFromGround; #hasTraversal";
        outputlog( header );
        level.mit.window.var_bc145a5e5382a8f9 = 1;
    }
    
    var_7ff893f1c6ad0096 = isbot( self );
    
    if ( var_7ff893f1c6ad0096 )
    {
        window = self.mit.var_c4a2055fc5335ca7;
        botid = self getentitynumber();
    }
    else
    {
        window = self;
        botid = "";
    }
    
    windowpos = window.var_19ee8de22b08132e;
    
    if ( isdefined( testcase ) )
    {
        startpos = testcase.var_bf5f886705e114e6 ?? testcase.var_25e60ba73eb305d5;
        var_56d1ae5a7b45a5fe = testcase.var_266e12dabf9a0277;
        comment = testcase.var_63918581a3ec5f55;
        hastraversal = testcase.hastraversal ?? "";
    }
    else
    {
        startpos = "";
        var_56d1ae5a7b45a5fe = "";
        hastraversal = "";
    }
    
    if ( !isdefined( lastposition ) )
    {
        lastposition = "";
    }
    
    if ( !isdefined( targetpos ) )
    {
        targetpos = "";
    }
    
    if ( !isdefined( comment ) )
    {
        comment = "";
    }
    
    situation = situation ? situation : "NO_SITUATION";
    reportstring = gettime() + ";" + situation + ";" + comment + ";" + botid + ";" + windowpos + ";" + lastposition + ";" + startpos + ";" + targetpos + ";" + window.height + ";" + var_56d1ae5a7b45a5fe + ";" + hastraversal;
    outputlog( reportstring );
    var_f61ebbaa706c6506 = mit::function_655ffb35317b1edb( windowpos, 3, [ -1, -1, -1 ] );
    var_d51e46999aca9ddb = mit::function_655ffb35317b1edb( lastposition, 3, [ -1, -1, -1 ] );
    var_cd713c89adac53a2 = mit::function_655ffb35317b1edb( startpos, 3, [ -1, -1, -1 ] );
    var_b49f24dc163d2c3d = mit::function_655ffb35317b1edb( targetpos, 3, [ -1, -1, -1 ] );
    dlog_recordevent( "dlog_event_mit_window", [ "time", matchdata::gettimefrommatchstart( gettime() ) ?? -1, "situation", situation ?? "", "comment", comment ?? "", "bot", isnumber( botid ) ? botid : -1, "window_pos_x", var_f61ebbaa706c6506[ 0 ] * 1, "window_pos_y", var_f61ebbaa706c6506[ 1 ] * 1, "window_pos_z", var_f61ebbaa706c6506[ 2 ] * 1, "last_position_x", var_d51e46999aca9ddb[ 0 ] * 1, "last_position_y", var_d51e46999aca9ddb[ 1 ] * 1, "last_position_z", var_d51e46999aca9ddb[ 2 ] * 1, "start_pos_x", var_cd713c89adac53a2[ 0 ] * 1, "start_pos_y", var_cd713c89adac53a2[ 1 ] * 1, "start_pos_z", var_cd713c89adac53a2[ 2 ] * 1, "target_pos_x", var_b49f24dc163d2c3d[ 0 ] * 1, "target_pos_y", var_b49f24dc163d2c3d[ 1 ] * 1, "target_pos_z", var_b49f24dc163d2c3d[ 2 ] * 1, "window_height", isdefined( window.height ) && isnumber( window.height ) ? window.height * 1 : -1, "height_from_ground", isnumber( var_56d1ae5a7b45a5fe ) ? var_56d1ae5a7b45a5fe * 1 : -1 ] );
    
    /#
        if ( getdvarint( @"hash_824c718cad3c0f17", 1 ) && isdefined( testcase ) && var_7ff893f1c6ad0096 )
        {
            if ( isdefined( level.mit.window.var_5d233476ee119367 ) )
            {
                level.mit.window.var_5d233476ee119367 += 1;
            }
            else
            {
                level.mit.window.var_5d233476ee119367 = 1;
            }
            
            const_distance = 40;
            const_height = 20;
            camerapos = startpos - testcase.forwardvector * const_distance + ( 0, 0, const_height );
            mit::requestscreenshot( "<dev string:x3c>", startpos, camerapos, window, level.mit.window.var_5d233476ee119367 );
        }
    #/
}

// Namespace mit_windows
// Params 1, eflags: 0x4
// Checksum 0xb22fcc90, Offset: 0x2b76
// Size: 0x1a
function private outputlog( reportstring )
{
    mit::outputlog( "Window", reportstring );
}

/#

    // Namespace mit_windows
    // Params 1
    // Checksum 0x55eb49f, Offset: 0x2b98
    // Size: 0xf2, Type: dev
    function highlightwindow( window )
    {
        self notify( #"hash_836169e8b289066d" );
        self endon( #"hash_836169e8b289066d" );
        
        while ( true )
        {
            line( window.horiedge[ 0 ], window.horiedge[ 1 ], ( 0, 0, 1 ), 1, 0, 1 );
            
            foreach ( edge in window.vertedges )
            {
                line( edge[ 0 ], edge[ 1 ], ( 0, 1, 0 ), 1, 0, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace mit_windows
    // Params 0, eflags: 0x4
    // Checksum 0xd6c44d5d, Offset: 0x2c92
    // Size: 0x76b, Type: dev
    function private function_c1b4d0d8588e7eac()
    {
        if ( !getdvarint( @"hash_bd2dd3658c87d89c", 0 ) )
        {
            return;
        }
        
        windows = level.mit.window.windows;
        
        if ( windows.size == 0 )
        {
            return;
        }
        
        duration = 1;
        defaultplayer = level.players[ 0 ];
        
        while ( true )
        {
            depthtest = getdvarint( @"hash_afa0ab48758cf927", 0 );
            var_4ac1d72ce0a73c67 = getdvarint( @"hash_47b63a7f33603249", 1 );
            var_bef23f3217f30206 = getdvarint( @"hash_c69bccbcdd1e073c", 0 );
            var_bf15513218197154 = getdvarint( @"hash_c678babcdcf797ee", 0 );
            var_a17ecd081a1e8c28 = getdvarint( @"hash_8c61ebd414fc8332", 0 );
            var_ac4f121e02827718 = getdvarint( @"hash_4bd1401cd9941bde", 0 );
            var_eac9bb313d80de66 = getdvarint( @"hash_1e69ebfde8d2ff77", 0 );
            var_8046f63ff82ed95f = getdvarfloat( @"hash_a892858b8d9cef3a", 1000 );
            var_ae5137ce593e247a = getdvarint( @"hash_a9c54ddb5a942e64", 0 );
            var_11afb5d736fb998e = getdvarint( @"hash_48bb7ce6a708421e", 0 );
            var_96d5a596611eba41 = getdvarint( @"hash_1fd38f15370ac4a2", -1 );
            maxdistance = getdvarint( @"hash_4a76d68e77915a1d", -1 );
            
            if ( maxdistance <= 0 )
            {
                maxdistancesq = 0;
            }
            else
            {
                maxdistancesq = squared( maxdistance );
            }
            
            foreach ( wndidx, window in windows )
            {
                if ( var_96d5a596611eba41 >= 0 && var_96d5a596611eba41 != wndidx )
                {
                    continue;
                }
                
                windowcenter = window.var_19ee8de22b08132e;
                
                if ( maxdistancesq > 0 && distancesquared( defaultplayer.origin, windowcenter ) > maxdistancesq )
                {
                    continue;
                }
                
                if ( var_4ac1d72ce0a73c67 )
                {
                    testcases = window.testcases;
                    allcontinue = 1;
                    
                    foreach ( testcase in testcases )
                    {
                        ifcontinue = 1;
                        failedreason = testcase.failedreason;
                        
                        if ( isdefined( failedreason ) )
                        {
                            if ( failedreason == "<dev string:x43>" )
                            {
                                startpos = testcase.var_25e60ba73eb305d5;
                                
                                if ( ( var_4ac1d72ce0a73c67 & 2 ) != 0 )
                                {
                                    ifcontinue = 0;
                                }
                            }
                            else
                            {
                                if ( failedreason == "<dev string:x4b>" )
                                {
                                    if ( ( var_4ac1d72ce0a73c67 & 4 ) != 0 )
                                    {
                                        ifcontinue = 0;
                                    }
                                }
                                
                                startpos = testcase.var_bf5f886705e114e6;
                            }
                        }
                        else
                        {
                            if ( ( var_4ac1d72ce0a73c67 & 1 ) != 0 )
                            {
                                ifcontinue = 0;
                            }
                            
                            startpos = testcase.var_bf5f886705e114e6;
                        }
                        
                        if ( isdefined( testcase.var_2d24f516c91386da ) && var_bef23f3217f30206 < var_bf15513218197154 && !( testcase.var_2d24f516c91386da >= var_bef23f3217f30206 && testcase.var_2d24f516c91386da <= var_bf15513218197154 ) )
                        {
                            ifcontinue = 1;
                        }
                        
                        if ( ifcontinue )
                        {
                            continue;
                        }
                        else
                        {
                            allcontinue = 0;
                        }
                        
                        color = isdefined( failedreason ) ? ( 1, 0, 0 ) : ( 1, 1, 0 );
                        line( startpos, windowcenter, color, 1, depthtest, duration );
                        
                        if ( var_a17ecd081a1e8c28 )
                        {
                            sphere( startpos, 10, color, depthtest, duration );
                        }
                        
                        if ( isdefined( testcase.var_2d24f516c91386da ) )
                        {
                            print3d( startpos, string( testcase.var_2d24f516c91386da ), ( 1, 1, 1 ), 1, 0.75, duration, 1 );
                        }
                        
                        if ( testcase.hastraversal )
                        {
                            if ( var_ae5137ce593e247a )
                            {
                                sphere( testcase.traversalpositions[ 0 ], var_8046f63ff82ed95f, ( 1, 0.75, 0.75 ), depthtest, duration );
                                line( window.var_19ee8de22b08132e, testcase.traversalpositions[ 0 ], ( 1, 0.75, 0.75 ), 1, depthtest, duration );
                            }
                            
                            continue;
                        }
                        
                        if ( testcase.hastraversal == 0 )
                        {
                            if ( var_11afb5d736fb998e )
                            {
                                sphere( startpos, var_8046f63ff82ed95f, ( 1, 1, 1 ), depthtest, duration );
                                line( window.var_19ee8de22b08132e, startpos + ( 0, 0, 10 ), ( 1, 1, 1 ), 1, depthtest, duration );
                            }
                        }
                    }
                    
                    if ( allcontinue )
                    {
                        continue;
                    }
                }
                
                if ( var_eac9bb313d80de66 )
                {
                    sphere( window.var_19ee8de22b08132e, var_8046f63ff82ed95f, ( 1, 0, 1 ), depthtest, duration );
                }
                
                if ( var_ac4f121e02827718 )
                {
                    sphere( window.var_ef0b2e0daa75b515, 13.5, ( 1, 0.5, 0 ), depthtest, duration );
                    line( window.var_ef0b2e0daa75b515, window.var_f06b60edfe4bb52e, ( 1, 0.75, 0.75 ), 1, depthtest, duration );
                    line( window.var_ef0b2e0daa75b515, window.drawheight_startpos, ( 0.5, 0, 1 ), 1, depthtest, duration );
                    sphere( window.var_cc34695025aa82ba, 13.5, ( 1, 0.5, 0 ), depthtest, duration );
                    line( window.var_cc34695025aa82ba, window.var_8f9143c8aa398be3, ( 1, 0.75, 0.75 ), 1, depthtest, duration );
                    line( window.var_cc34695025aa82ba, window.drawheight_startpos, ( 1, 0, 1 ), 1, depthtest, duration );
                    print3d( window.drawheight_startpos, "<dev string:x5f>" + window.var_f06b60edfe4bb52e[ 2 ] - window.var_8f9143c8aa398be3[ 2 ], ( 1, 1, 1 ), 1, 0.75, duration, 1 );
                }
                
                line( window.horiedge[ 0 ], window.horiedge[ 1 ], ( 0, 0, 1 ), 1, depthtest, duration );
                
                foreach ( edge in window.vertedges )
                {
                    line( edge[ 0 ], edge[ 1 ], ( 0, 1, 0 ), 1, depthtest, duration );
                }
            }
            
            waitframe();
        }
    }

#/
