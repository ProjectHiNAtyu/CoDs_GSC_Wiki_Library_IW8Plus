// scripts\autotests\mp\test_mp_mit_windows.gsc  (hash_4df8072ffb1f966e.gscc) (size: 10179 Bytes / 0x27c3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7c9688dc (2090240220)
// size ...... 10179 (0x27c3)
// includes .. 5   (offset: 0x24a7)
// strings ... 51  (offset: 0x24cf)
// dev strs .. 0   (offset: 0x27c3)
// exports ... 23  (offset: 0x18af)
// cseg ...... 0x44a + 0x1465 (0x18af)
// imports ... 69  (offset: 0x1c47)
// animtree1 . 0   (offset: 0x27c3)
// animtree2 . 0   (offset: 0x27c3)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility_player;
#using scripts\autotests\mp\autotests_utility_mit;
#using scripts\common\trace;
#using scripts\mp\bots\bots_util;

#namespace test_mp_mit_windows;

// Namespace test_mp_mit_windows/testautomation
// Params 0, eflags: 0x20
// Checksum 0x89b7da6a, Offset: 0x468
// Size: 0x18
function event_handler[testautomation] main()
{
    autotests_utility_mit::function_45effcfcc139e74a( "scripts/autotests/mp/test_mp_mit_windows.gsc", &start_test, &parameterize );
}

// Namespace test_mp_mit_windows
// Params 2, eflags: 0x4
// Checksum 0x4a95a84, Offset: 0x488
// Size: 0xe5
function private function_c44561de03d437e2( player, var_6e5da55073c7411a )
{
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Valid Window ID?|id_valid", var_6e5da55073c7411a, "scripts/autotests/mp/test_mp_mit_windows.gsc", 21 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    window = level.mit_lookup[ var_6e5da55073c7411a ];
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Window found?|win_found", window, "scripts/autotests/mp/test_mp_mit_windows.gsc", 24 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests::set_current_asset_name( var_6e5da55073c7411a );
    
    for ( caseindex = 0; caseindex < window.testcases.size ; caseindex++ )
    {
        function_2ce360df08a13111( player, var_6e5da55073c7411a, window, window.testcases[ caseindex ], caseindex );
    }
}

// Namespace test_mp_mit_windows
// Params 5, eflags: 0x4
// Checksum 0xf033c048, Offset: 0x575
// Size: 0x618
function private function_2ce360df08a13111( player, var_6e5da55073c7411a, window, testcase, caseindex )
{
    fullid = var_6e5da55073c7411a + "_" + caseindex;
    autotests::set_current_asset_name( fullid );
    autotests_utility_mit::function_e017acd43781f5a3( player );
    autotests_utility_mit::function_fc203072b5b37c65( player, "window_id", var_6e5da55073c7411a );
    autotests_utility_mit::function_fc203072b5b37c65( player, "case_index", caseindex );
    autotests_utility_mit::function_fc203072b5b37c65( player, "window_origin_x", window.var_19ee8de22b08132e[ 0 ] * 1 );
    autotests_utility_mit::function_fc203072b5b37c65( player, "window_origin_y", window.var_19ee8de22b08132e[ 1 ] * 1 );
    autotests_utility_mit::function_fc203072b5b37c65( player, "window_origin_z", window.var_19ee8de22b08132e[ 2 ] * 1 );
    autotests_utility_mit::function_fc203072b5b37c65( player, "window_height", isnumber( window.height ) ? window.height * 1 : -1 );
    autotests_utility_mit::function_fc203072b5b37c65( player, "has_traversal", testcase.hastraversal ?? 0 );
    autotests_utility_mit::function_fc203072b5b37c65( player, "script_noteworthy", level.script_noteworthy ?? "" );
    autotests_utility_mit::function_fc203072b5b37c65( player, "script_parameters", level.script_parameters ?? "" );
    
    if ( isdefined( testcase.failedreason ) )
    {
        var_cd713c89adac53a2 = testcase.var_bf5f886705e114e6 ?? testcase.var_25e60ba73eb305d5;
        autotests_utility_mit::function_51e9e46c136ac9c3( player, "start_pos", "Test start position on ground", var_cd713c89adac53a2 );
        autotests_utility_mit::function_51e9e46c136ac9c3( player, "window_center", "Window horizontal edge center", window.var_19ee8de22b08132e );
        autotests_utility_mit::function_fc203072b5b37c65( player, "height_from_ground", isnumber( testcase.var_266e12dabf9a0277 ) ? testcase.var_266e12dabf9a0277 * 1 : -1 );
        autotests_utility_mit::function_fc203072b5b37c65( player, "situation", testcase.failedreason );
        autotests_utility_mit::function_fc203072b5b37c65( player, "comment", testcase.failedreason );
        autotests_utility_mit::function_3ccb8044cdb16827( player, "window_event", "scripts/autotests/mp/test_mp_mit_windows.gsc", 1 );
        var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Window passable? (" + testcase.failedreason + ")|win_passable", 0, "scripts/autotests/mp/test_mp_mit_windows.gsc", 62 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    
    startpos = testcase.var_bf5f886705e114e6;
    forwardvector = testcase.forwardvector;
    windowcenter = window.var_19ee8de22b08132e + ( 0, 0, 10 );
    targetpos = windowcenter + forwardvector * 50;
    autotests_utility_mit::function_51e9e46c136ac9c3( player, "start_pos", "Test start position on ground", startpos );
    autotests_utility_mit::function_51e9e46c136ac9c3( player, "window_center", "Window horizontal edge center", window.var_19ee8de22b08132e );
    autotests_utility_mit::function_fc203072b5b37c65( player, "height_from_ground", isnumber( testcase.var_266e12dabf9a0277 ) ? testcase.var_266e12dabf9a0277 * 1 : -1 );
    player autotests_utility_player::set_player_position( startpos );
    player botsetpathingstyle( "scripted" );
    player botsetflag( "disable_movement", 1 );
    player bots_util_mp::function_cdc8a7497ee4f596( targetpos );
    var_6a5259a568f9bc15 = 10;
    
    while ( var_6a5259a568f9bc15 > 0 && function_52959484d548f3cd( player geteye(), targetpos ) )
    {
        var_6a5259a568f9bc15--;
        weapon = player getcurrentweapon();
        player setweaponammoclip( weapon, weaponclipsize( weapon ) );
        player botpressbutton( "attack", 0.5 );
        wait 1;
    }
    
    player botsetflag( "disable_movement", 0 );
    player thread lookthread( forwardvector );
    starttime = gettime();
    endtime = starttime + 10000;
    timedout = 0;
    passed = 0;
    lastpos = player.origin;
    
    while ( true )
    {
        if ( gettime() >= endtime )
        {
            timedout = 1;
            break;
        }
        
        if ( player function_b23593f7a29527df( forwardvector, windowcenter ) )
        {
            player setvelocity( ( 0, 0, 0 ) );
            lastpos = player.origin;
            player setorigin( startpos );
            passed = 1;
            break;
        }
        
        anglestotarget = vectortoangles( targetpos - player.origin );
        player botsetscriptmove( anglestotarget[ 1 ], 0.05, 1 );
        wait 0.05;
    }
    
    player notify( #"hash_ba6db43b77bed4ba" );
    situation = "unknown";
    
    if ( timedout )
    {
        situation = "timeout";
    }
    else if ( passed )
    {
        if ( isdefined( testcase.var_63918581a3ec5f55 ) )
        {
            situation = "passed but treated as failed";
        }
        else if ( testcase.hastraversal == 0 )
        {
            situation = "no traversal";
        }
        else
        {
            situation = "pass";
        }
    }
    
    autotests_utility_mit::function_51e9e46c136ac9c3( player, "target_pos", "Movement target through window", targetpos );
    autotests_utility_mit::function_51e9e46c136ac9c3( player, "last_pos", "Player position after test", lastpos );
    autotests_utility_mit::function_fc203072b5b37c65( player, "situation", situation );
    autotests_utility_mit::function_fc203072b5b37c65( player, "comment", testcase.var_63918581a3ec5f55 ?? "" );
    caseresult = situation == "pass" ? 0 : 1;
    autotests_utility_mit::function_3ccb8044cdb16827( player, "window_event", "scripts/autotests/mp/test_mp_mit_windows.gsc", caseresult );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Window traversal result?|mantle_result", situation, "pass", "scripts/autotests/mp/test_mp_mit_windows.gsc", 147 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace test_mp_mit_windows
// Params 2, eflags: 0x4
// Checksum 0xaa9585d1, Offset: 0xb95
// Size: 0x52, Type: bool
function private function_52959484d548f3cd( startpos, endpos )
{
    contents = physics_createcontents( [ "physicscontents_glass" ] );
    result = trace::ray_trace( startpos, endpos, undefined, contents );
    return result[ "hittype" ] != "hittype_none";
}

// Namespace test_mp_mit_windows
// Params 2, eflags: 0x4
// Checksum 0xeeae90c4, Offset: 0xbf0
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

// Namespace test_mp_mit_windows
// Params 1, eflags: 0x4
// Checksum 0x54fbcee9, Offset: 0xc51
// Size: 0xce
function private lookthread( forwardvector )
{
    self endon( #"hash_ba6db43b77bed4ba" );
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

// Namespace test_mp_mit_windows
// Params 0, eflags: 0x4
// Checksum 0xff8020b, Offset: 0xd27
// Size: 0x6c
function private function_c248f0c81495959e()
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
                return getwindows();
            }
            
            return [];
        }
        
        wait 1;
        
        if ( gettime() >= endtime )
        {
            return [];
        }
    }
}

// Namespace test_mp_mit_windows
// Params 0, eflags: 0x4
// Checksum 0x9a1667e8, Offset: 0xd9b
// Size: 0xf1
function private getwindows()
{
    windows = [];
    yield_stride = 100;
    yieldcounter = 0;
    
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
        yieldcounter++;
        
        if ( yieldcounter >= yield_stride )
        {
            yieldcounter = 0;
            waitframe();
        }
    }
    
    return windows;
}

// Namespace test_mp_mit_windows
// Params 1, eflags: 0x4
// Checksum 0x6edd057f, Offset: 0xe95
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

// Namespace test_mp_mit_windows
// Params 1, eflags: 0x4
// Checksum 0xa2c70145, Offset: 0xfa6
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

// Namespace test_mp_mit_windows
// Params 1, eflags: 0x4
// Checksum 0x4e92b74c, Offset: 0x1012
// Size: 0x160
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
    
    return upresult[ "position" ][ 2 ] - downresult[ "position" ][ 2 ];
}

// Namespace test_mp_mit_windows
// Params 2, eflags: 0x4
// Checksum 0x59cfb895, Offset: 0x117b
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

// Namespace test_mp_mit_windows
// Params 1, eflags: 0x4
// Checksum 0x6b8452a4, Offset: 0x11ea
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

// Namespace test_mp_mit_windows
// Params 2, eflags: 0x44 variadic
// Checksum 0x109c7035, Offset: 0x1398
// Size: 0x3c
function private function_3fa42a693dffe676( ... )
{
    testcase = {};
    testcase.failedreason = function_a885948fe8041a7a( testcase, flat_args( vararg, varargcount ) );
    return testcase;
}

// Namespace test_mp_mit_windows
// Params 6, eflags: 0x4
// Checksum 0xf5feba14, Offset: 0x13dd
// Size: 0x1ea
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
    testcase.var_266e12dabf9a0277 = var_266e12dabf9a0277;
    
    if ( var_266e12dabf9a0277 > var_4b8b4139d5203574 )
    {
        return "not close to ground";
    }
}

// Namespace test_mp_mit_windows
// Params 1, eflags: 0x4
// Checksum 0xea4de9ac, Offset: 0x15cf
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

// Namespace test_mp_mit_windows
// Params 1, eflags: 0x4
// Checksum 0x6c1a98bf, Offset: 0x1665
// Size: 0x5d
function private function_4d13d71ad147e776( position )
{
    var_3f4643679b6da444 = -25000;
    endposition = position + ( 0, 0, var_3f4643679b6da444 );
    result = trace::sphere_trace( position, endposition, 13.5, undefined );
    
    if ( result[ "hittype" ] == "hittype_none" )
    {
        return;
    }
    
    return result[ "shape_position" ];
}

// Namespace test_mp_mit_windows
// Params 2, eflags: 0x4
// Checksum 0x3a7095f, Offset: 0x16cb
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

// Namespace test_mp_mit_windows
// Params 2, eflags: 0x4
// Checksum 0x67b5a82b, Offset: 0x1729
// Size: 0x107
function private function_b167eba2e2f30061( minbounds, maxbounds )
{
    var_c00f525c21927ad0 = [];
    windows = function_c248f0c81495959e();
    
    foreach ( window in windows )
    {
        center = window.var_19ee8de22b08132e;
        
        if ( isdefined( minbounds ) && isdefined( maxbounds ) )
        {
            if ( center[ 0 ] < minbounds[ 0 ] || center[ 0 ] > maxbounds[ 0 ] || center[ 1 ] < minbounds[ 1 ] || center[ 1 ] > maxbounds[ 1 ] )
            {
                continue;
            }
        }
        
        id = autotests_utility_mit::function_dc2e211727d1d124( center );
        var_c00f525c21927ad0[ id ] = window;
    }
    
    return var_c00f525c21927ad0;
}

// Namespace test_mp_mit_windows
// Params 0, eflags: 0x4
// Checksum 0x621855e0, Offset: 0x1839
// Size: 0x3b
function private get_config()
{
    return { #sourcefile:"scripts/autotests/mp/test_mp_mit_windows.gsc", #var_6b7f0911cb91054a:"window_event", #var_db86da194d47f8f2:&function_c44561de03d437e2, #var_4182163638fd37ed:&function_b167eba2e2f30061 };
}

// Namespace test_mp_mit_windows
// Params 1, eflags: 0x4
// Checksum 0xb1296804, Offset: 0x187d
// Size: 0x1a
function private parameterize( test_setup )
{
    return autotests_utility_mit::function_b7fe9eed6b7b2a72( test_setup, get_config() );
}

// Namespace test_mp_mit_windows
// Params 0
// Checksum 0xb3430b08, Offset: 0x18a0
// Size: 0xf
function start_test()
{
    autotests_utility_mit::function_a10f1915e22ab0d4( get_config() );
}

