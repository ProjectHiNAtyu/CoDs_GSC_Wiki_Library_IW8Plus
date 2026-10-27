// script_47e50634bcd54a6d  (hash_47e50634bcd54a6d.gscc) (size: 12020 Bytes / 0x2ef4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4abeed3f (1254026559)
// size ...... 12020 (0x2ef4)
// includes .. 4   (offset: 0x2b78)
// strings ... 57  (offset: 0x2b98)
// dev strs .. 3   (offset: 0x2ebc)
// exports ... 22  (offset: 0x20bc)
// cseg ...... 0x41a + 0x1ca2 (0x20bc)
// imports ... 61  (offset: 0x242c)
// animtree1 . 0   (offset: 0x2ef4)
// animtree2 . 0   (offset: 0x2ef4)
#using script_3d2770dc09c1243;
#using scripts\common\utility;
#using scripts\mp\bots\bots_gametype_super_shared;
#using scripts\mp\matchdata;

#namespace mit_traversals;

// Namespace mit_traversals
// Params 0
// Checksum 0x1f8616c2, Offset: 0x438
// Size: 0x123
function init()
{
    level.mit.traversal = spawnstruct();
    level.mit.traversal.traversals = collecttraversals( function_bbc6bec2d9bd9f19() );
    level.mit.traversal.total = level.mit.traversal.traversals.size;
    
    if ( level.mit.traversal.total == 0 )
    {
        mit::outputlog( "Traversal", "No traversals to test." );
        return;
    }
    
    /#
        level thread function_5eb9ea70fe6f8717();
    #/
    
    level.mit.traversal.success = 0;
    level.mit.traversal.traversalhistory = [];
    level.mit.traversal.var_205c9224a684088c = [];
    thread function_1d28c180d7bfddab();
}

// Namespace mit_traversals
// Params 1, eflags: 0x4
// Checksum 0x392e27f1, Offset: 0x563
// Size: 0x41
function private function_9b915e47e38c485( ladderpoint )
{
    closestnavmeshpoint = getclosestpointonnavmesh( ladderpoint, undefined, 1, undefined, undefined, undefined, 1, 1 );
    
    if ( !isdefined( closestnavmeshpoint ) )
    {
        return 1;
    }
    
    return distancesquared( ladderpoint, closestnavmeshpoint ) > 1600;
}

// Namespace mit_traversals
// Params 0, eflags: 0x4
// Checksum 0x15e4a4da, Offset: 0x5ac
// Size: 0x2c4
function private function_1d28c180d7bfddab()
{
    wait 0.1;
    ascenders = function_f972efbcd627033e();
    
    foreach ( node in ascenders )
    {
        name = "[" + node.scriptableindex + "]" + node.scriptablename;
        p0 = { #targetname:name, #origin:node.start };
        p1 = { #targetname:name, #origin:node.end };
        report( "ascender_no_traversal", undefined, undefined, [ p0, p1 ] );
    }
    
    ladders = function_4cf22774d398c3f5( 210 );
    ladders = function_7243d45b5d82f431( ladders, #distanceScore, 4 );
    
    foreach ( node in ladders )
    {
        name = "hash_" + node.hash;
        p0 = { #targetname:name, #origin:node.start };
        p1 = { #targetname:name, #origin:node.end };
        isInWater = utility::ispointinwater( node.start ) || utility::ispointinwater( node.end );
        var_c1da9c4cf706f4dd = function_9b915e47e38c485( node.start ) && function_9b915e47e38c485( node.end );
        extracomment = ( isInWater ? " in_water" : "" ) + ( var_c1da9c4cf706f4dd ? " far_from_navmesh" : "" );
        report( "ladder_no_traversal", undefined, undefined, [ p0, p1 ], "distanceScore=" + node.distanceScore + " closestNavlink=" + node.navlinkstart + extracomment );
    }
}

// Namespace mit_traversals
// Params 1, eflags: 0x4
// Checksum 0x299de6da, Offset: 0x878
// Size: 0x343
function private collecttraversals( nodearray )
{
    beginnode = [];
    endnode = [];
    
    foreach ( node in nodearray )
    {
        if ( !isdefined( node.type ) )
        {
            continue;
        }
        
        nodename = function_fd54071006f0517b( node );
        
        if ( !isdefined( nodename ) )
        {
            continue;
        }
        
        if ( node.type == "Begin" )
        {
            if ( isdefined( beginnode[ nodename ] ) )
            {
                report( "duplicated name: " + nodename + ", node1:" + node.origin + ", node2:" + beginnode[ nodename ].origin );
                continue;
            }
            
            beginnode[ nodename ] = node;
            continue;
        }
        
        if ( node.type == "End" )
        {
            if ( isdefined( endnode[ nodename ] ) )
            {
                report( "duplicated name: " + nodename + ", node1:" + node.origin + ", node2:" + endnode[ nodename ].origin );
                continue;
            }
            
            endnode[ nodename ] = node;
        }
    }
    
    namekeys = getarraykeys( beginnode );
    result = [];
    
    foreach ( name in namekeys )
    {
        if ( isdefined( endnode[ name ] ) )
        {
            size = result.size;
            result[ size ] = [];
            result[ size ][ 0 ] = beginnode[ name ];
            result[ size ][ 1 ] = endnode[ name ];
            beginnode[ name ] = undefined;
            endnode[ name ] = undefined;
        }
    }
    
    if ( beginnode.size > 0 )
    {
        foreach ( key, value in beginnode )
        {
            report( "unpaired begin node: " + key + ", " + value.origin );
        }
    }
    
    if ( endnode.size > 0 )
    {
        foreach ( key, value in endnode )
        {
            report( "unpaired end node: " + key + ", " + value.origin );
        }
    }
    
    return result;
}

// Namespace mit_traversals
// Params 0, eflags: 0x4
// Checksum 0x5f0b3ac0, Offset: 0xbc4
// Size: 0xe2
function private function_bbc6bec2d9bd9f19()
{
    nodearray = [];
    traversalpairs = getalltraversals();
    
    foreach ( pair in traversalpairs )
    {
        if ( !( pair.usageflag & 1032192 ) )
        {
            continue;
        }
        
        nodebegin = pair.nodebegin;
        
        if ( isdefined( nodebegin ) )
        {
            nodearray[ nodearray.size ] = nodebegin;
        }
        
        nodeend = pair.nodeend;
        
        if ( isdefined( nodeend ) )
        {
            nodearray[ nodearray.size ] = nodeend;
        }
    }
    
    return nodearray;
}

// Namespace mit_traversals
// Params 5, eflags: 0x4
// Checksum 0x3189e83e, Offset: 0xcaf
// Size: 0x514
function private report( situation, bot, position, traversaltarget, commentoverride )
{
    if ( !level.mit.traversal.var_f4f0b83fe0d4622f )
    {
        header = "#time; #situation; #bot; #lastPosition; #traversalName; #traversalType; #traversalBegin; #traversalEnd; #comment";
        mit::outputlog( "Traversal", header );
        level.mit.traversal.var_f4f0b83fe0d4622f = 1;
    }
    
    botentitynumber = "";
    
    if ( isdefined( bot ) )
    {
        botentitynumber = bot getentitynumber();
    }
    
    lastposition = "";
    
    if ( isdefined( position ) )
    {
        lastposition = position;
    }
    
    traversalname = "";
    beginposition = "";
    endposition = "";
    traversaltype = "";
    situation = situation ? situation : "NO_SITUATION";
    
    if ( isdefined( traversaltarget ) )
    {
        traversalname = function_fd54071006f0517b( traversaltarget[ 0 ] );
        beginposition = traversaltarget[ 0 ].origin;
        endposition = traversaltarget[ 1 ].origin;
        traversaltype = traversaltarget[ 0 ].animscript ?? "";
        
        if ( situation != "passed" && situation != "ascender_no_traversal" && situation != "ladder_no_traversal" )
        {
            level.mit.traversal.var_205c9224a684088c[ level.mit.traversal.var_205c9224a684088c.size ] = traversaltarget;
        }
    }
    
    comment = "";
    
    if ( isdefined( commentoverride ) )
    {
        comment = commentoverride;
    }
    else if ( isdefined( bot.mit.comment ) )
    {
        comment = bot.mit.comment;
    }
    
    reportstring = gettime() + "; " + situation + "; " + botentitynumber + "; " + lastposition + "; " + traversalname + "; " + traversaltype + "; " + beginposition + "; " + endposition + "; " + comment;
    mit::outputlog( "Traversal", reportstring );
    var_d51e46999aca9ddb = mit::function_655ffb35317b1edb( lastposition, 3, [ -1, -1, -1 ] );
    var_93c06ebd39a8462a = mit::function_655ffb35317b1edb( beginposition, 3, [ -1, -1, -1 ] );
    var_7703496ab1a80a7a = mit::function_655ffb35317b1edb( endposition, 3, [ -1, -1, -1 ] );
    dlog_recordevent( "dlog_event_mit_traversal", [ "time", matchdata::gettimefrommatchstart( gettime() ) ?? -1, "situation", situation ?? "", "bot", isnumber( botentitynumber ) ? botentitynumber : -1, "last_position_x", var_d51e46999aca9ddb[ 0 ] * 1, "last_position_y", var_d51e46999aca9ddb[ 1 ] * 1, "last_position_z", var_d51e46999aca9ddb[ 2 ] * 1, "traversal_name", traversalname ?? "", "traversal_type", traversaltype ?? "", "traversal_begin_x", var_93c06ebd39a8462a[ 0 ] * 1, "traversal_begin_y", var_93c06ebd39a8462a[ 1 ] * 1, "traversal_begin_z", var_93c06ebd39a8462a[ 2 ] * 1, "traversal_end_x", var_7703496ab1a80a7a[ 0 ] * 1, "traversal_end_y", var_7703496ab1a80a7a[ 1 ] * 1, "traversal_end_z", var_7703496ab1a80a7a[ 2 ] * 1, "comment", comment ?? "" ] );
    
    /#
        if ( isdefined( level.mit.traversal.var_5d233476ee119367 ) )
        {
            level.mit.traversal.var_5d233476ee119367 += 1;
        }
        else
        {
            level.mit.traversal.var_5d233476ee119367 = 1;
        }
        
        if ( isdefined( traversaltarget ) )
        {
            mit::requestscreenshot( "<dev string:x24>", endposition, endposition + ( 0, 0, 100 ), traversaltarget, level.mit.traversal.var_5d233476ee119367 );
        }
    #/
}

// Namespace mit_traversals
// Params 2, eflags: 0x4
// Checksum 0x2ab9945, Offset: 0x11cb
// Size: 0x60
function private retryreport( situation, bot )
{
    if ( !function_5041a5eeaee1486( bot.mit.traversal, situation ) )
    {
        report( situation, bot, bot.origin, bot.mit.traversal );
    }
}

// Namespace mit_traversals
// Params 1, eflags: 0x4
// Checksum 0xdf258a7b, Offset: 0x1233
// Size: 0x42
function private function_fd54071006f0517b( node )
{
    var_7237854e3be197ca = node.target;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    var_7237854e3be197ca = node.targetname;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
}

// Namespace mit_traversals
// Params 0
// Checksum 0x29365466, Offset: 0x127d
// Size: 0x139
function testprocess()
{
    assert( !isdefined( self.mit.traversal ) );
    self botsetdifficultysetting( "slideChance", 0 );
    self.mit.traversal = taketraversal();
    
    if ( !isdefined( self.mit.traversal ) )
    {
        return;
    }
    
    self.mit.onplayerkilled = &onplayerkilled;
    var_4adbd46a987c2f21 = 25;
    const_drop_height = 50;
    failedresult = mit::botteleport( self.mit.traversal[ 0 ].origin, var_4adbd46a987c2f21, const_drop_height );
    
    if ( isdefined( failedresult ) )
    {
        if ( isstartstr( failedresult, "inaccurate" ) )
        {
            self.mit.comment = failedresult;
        }
        else
        {
            retryreport( "teleport failed/" + failedresult, self );
            return;
        }
    }
    
    /#
        thread function_cd1aea26e26d352a( self.mit.traversal );
    #/
    
    gotoendposition( self, self.mit.traversal );
}

// Namespace mit_traversals
// Params 0, eflags: 0x4
// Checksum 0xd5be0368, Offset: 0x13be
// Size: 0x161
function private taketraversal()
{
    /#
        tpos = getdvarvector( @"hash_19539497cc24bc9" );
        
        if ( isdefined( tpos ) && level.players.size == 2 )
        {
            level.mit.traversal.traversalhistory = [];
            return function_5e1273b959afec72( tpos );
        }
    #/
    
    if ( level.mit.traversal.traversals.size == 0 )
    {
        return;
    }
    
    assert( level.mit.traversal.traversals.size > 0 );
    
    for ( index = 0; index < level.mit.traversal.traversals.size ; index++ )
    {
        current = level.mit.traversal.traversals[ index ];
        
        if ( function_ba6af382eecb3c7( current ) )
        {
            level.mit.traversal.traversals[ index ] = undefined;
            
            if ( isint( index ) )
            {
                function_cdc669dbc8ea2101( level.mit.traversal.traversals );
            }
            
            return current;
        }
    }
}

// Namespace mit_traversals
// Params 1, eflags: 0x4
// Checksum 0x66b40aaa, Offset: 0x1528
// Size: 0x13e, Type: bool
function private function_ba6af382eecb3c7( traversal )
{
    var_af20fe0545650ff1 = 64;
    
    foreach ( player in level.players )
    {
        if ( !isbot( player ) || !namespace_ef4547f85724edd1::isaliveplayer( player ) )
        {
            continue;
        }
        
        if ( isdefined( player.mit.traversal ) )
        {
            isclose = distance( traversal[ 0 ].origin, player.mit.traversal[ 1 ].origin ) < var_af20fe0545650ff1 || distance( traversal[ 1 ].origin, player.mit.traversal[ 0 ].origin ) < var_af20fe0545650ff1;
            
            if ( isclose )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace mit_traversals
// Params 2, eflags: 0x4
// Checksum 0x6cb50908, Offset: 0x166f
// Size: 0x272
function private gotoendposition( bot, traversal )
{
    const_goal_radius = 30;
    var_1ff34906b829e56b = 60;
    endposition = bot.mit.traversal[ 1 ].origin;
    begintime = mit::function_9f2a98ba9eb78c4d();
    dist = distance( bot.mit.traversal[ 0 ].origin, endposition );
    expectedduration = ( dist / var_1ff34906b829e56b + 1 ) * 1000;
    bot namespace_ef4547f85724edd1::setscriptgoal( endposition, const_goal_radius );
    var_278b5b3b8cdf80a3 = 0;
    var_1b852134f0974d0a = 15000;
    
    while ( true )
    {
        result = mit::function_adbdc8fee4453bd7( bot, 0.1 );
        
        if ( result == "goal" )
        {
            timeused = mit::function_9f2a98ba9eb78c4d() - begintime;
            timerate = timeused / 1000 + "/" + expectedduration / 1000;
            
            if ( !var_278b5b3b8cdf80a3 )
            {
                retryreport( "never used traversal", bot );
            }
            else
            {
                if ( timeused <= expectedduration )
                {
                    function_f048686fa0b468cf( bot.mit.traversal, "on time goal " + timerate );
                }
                else
                {
                    function_f048686fa0b468cf( bot.mit.traversal, "late goal " + timerate );
                }
                
                report( "passed", bot, bot.origin, bot.mit.traversal );
                level.mit.traversal.success++;
            }
            
            break;
        }
        
        if ( result == "timeout" )
        {
            if ( !var_278b5b3b8cdf80a3 )
            {
                var_278b5b3b8cdf80a3 = bot botisdoingtraversal();
            }
            
            timeused = mit::function_9f2a98ba9eb78c4d() - begintime;
            
            if ( gettimescale() == 4 )
            {
                limitduration = var_1b852134f0974d0a * 5.5 / var_1b852134f0974d0a / 1000 / 4;
            }
            else
            {
                limitduration = var_1b852134f0974d0a;
            }
            
            if ( timeused > limitduration )
            {
                retryreport( "time > " + var_1b852134f0974d0a / 1000 + "s", bot );
                break;
            }
            
            continue;
        }
        
        retryreport( result, bot );
        break;
    }
}

// Namespace mit_traversals
// Params 1, eflags: 0x4
// Checksum 0xd631df8f, Offset: 0x18e9
// Size: 0x43
function private onplayerkilled( deathdata )
{
    if ( isdefined( self.mit.traversal ) )
    {
        retryreport( "death", self );
        self.mit.traversal = undefined;
    }
}

// Namespace mit_traversals
// Params 0
// Checksum 0x1aa1cdb7, Offset: 0x1934
// Size: 0x10f
function endhandler()
{
    if ( level.mit.traversal.success + level.mit.traversal.var_205c9224a684088c.size >= level.mit.traversal.total )
    {
        reportstring = "Test result: " + level.mit.traversal.total + " traversals, " + level.mit.traversal.success + " successes, " + level.mit.traversal.var_205c9224a684088c.size + " failures.";
        mit::outputlog( "Traversal", reportstring );
    }
    
    if ( isdefined( self ) )
    {
        self botsetflag( "disable_movement", 0 );
        self.mit.traversal = undefined;
    }
}

// Namespace mit_traversals
// Params 0
// Checksum 0x256ebbca, Offset: 0x1a4b
// Size: 0x22, Type: bool
function function_119b9a096f5511d2()
{
    return level.mit.traversal.traversals.size > 0;
}

/#

    // Namespace mit_traversals
    // Params 0, eflags: 0x4
    // Checksum 0xdcf888ad, Offset: 0x1a76
    // Size: 0x2b9, Type: dev
    function private function_5eb9ea70fe6f8717()
    {
        level endon( #"game_ended" );
        traversalposition = [];
        traversaltype = [];
        
        foreach ( trvs in level.mit.traversal.traversals )
        {
            name = function_fd54071006f0517b( trvs[ 0 ] );
            traversalposition[ name ] = trvs[ 0 ].origin;
            traversaltype[ name ] = trvs[ 0 ].animscript;
        }
        
        while ( true )
        {
            wait 20;
            runningtask = 0;
            
            foreach ( player in level.players )
            {
                if ( !isbot( player ) )
                {
                    continue;
                }
                
                if ( isdefined( player.mit.traversal ) )
                {
                    runningtask = 1;
                    break;
                }
            }
            
            if ( !runningtask && level.mit.traversal.traversals.size == 0 )
            {
                break;
            }
        }
        
        foreach ( k, v in level.mit.traversal.traversalhistory )
        {
            outputstring = v.size + "<dev string:x2e>" + k + "<dev string:x2e>" + traversalposition[ k ] + "<dev string:x2e>" + traversaltype[ k ] + "<dev string:x2e>";
            outputstring += function_5d044133536d0766( "<dev string:x2e>", v );
            
            for ( i = 0; i < 3 - v.size ; i++ )
            {
                outputstring += "<dev string:x2e>";
            }
            
            mit::outputlog( "<dev string:x30>", outputstring );
        }
    }

#/

// Namespace mit_traversals
// Params 2, eflags: 0x4
// Checksum 0x245bb208, Offset: 0x1d37
// Size: 0x9e, Type: bool
function private function_5041a5eeaee1486( traversal, str )
{
    function_f048686fa0b468cf( traversal, str );
    currentlength = level.mit.traversal.traversalhistory[ function_fd54071006f0517b( traversal[ 0 ] ) ].size;
    
    if ( currentlength < 3 )
    {
        level.mit.traversal.traversals[ level.mit.traversal.traversals.size ] = traversal;
        return true;
    }
    
    return false;
}

// Namespace mit_traversals
// Params 2, eflags: 0x4
// Checksum 0x56eba87d, Offset: 0x1dde
// Size: 0xb3
function private function_f048686fa0b468cf( traversal, str )
{
    name = function_fd54071006f0517b( traversal[ 0 ] );
    
    if ( !isdefined( level.mit.traversal.traversalhistory[ name ] ) )
    {
        level.mit.traversal.traversalhistory[ name ] = [];
    }
    
    level.mit.traversal.traversalhistory[ name ][ level.mit.traversal.traversalhistory[ name ].size ] = str;
}

/#

    // Namespace mit_traversals
    // Params 1, eflags: 0x4
    // Checksum 0x822638af, Offset: 0x1e99
    // Size: 0xb0, Type: dev
    function private function_5e1273b959afec72( pos )
    {
        foreach ( trvs in level.mit.traversal.traversals )
        {
            if ( distance( pos, trvs[ 0 ].origin ) < 8 )
            {
                return trvs;
            }
        }
        
        return;
    }

    // Namespace mit_traversals
    // Params 1, eflags: 0x4
    // Checksum 0x8301fa53, Offset: 0x1f51
    // Size: 0xa6, Type: dev
    function private function_8c16de74fee863f3( name )
    {
        foreach ( trvs in level.mit.traversal.traversals )
        {
            if ( name == function_fd54071006f0517b( trvs[ 0 ] ) )
            {
                return trvs;
            }
        }
        
        return;
    }

    // Namespace mit_traversals
    // Params 1
    // Checksum 0x83d5dd38, Offset: 0x1fff
    // Size: 0xbd, Type: dev
    function function_cd1aea26e26d352a( traversal )
    {
        if ( !getdvarint( @"hash_c3b2324ea1cbb0b1", 0 ) )
        {
            return;
        }
        
        self notify( #"hash_a8943b863532ffbb" );
        self endon( #"hash_a8943b863532ffbb" );
        
        while ( true )
        {
            sphere( traversal[ 0 ].origin, 30, ( 0, 1, 0 ), 0, 1 );
            sphere( traversal[ 1 ].origin, 30, ( 0, 0, 1 ), 0, 1 );
            utility::draw_arrow_time( traversal[ 0 ].origin, traversal[ 1 ].origin, ( 1, 0, 0 ), 1 );
            waitframe();
        }
    }

#/
