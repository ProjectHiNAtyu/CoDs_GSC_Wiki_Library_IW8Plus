// scripts\autotests\mp\test_mp_mit_traversals.gsc  (hash_028c6ea90cdefcb0.gscc) (size: 7019 Bytes / 0x1b6b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd4781880 (3564640384)
// size ...... 7019 (0x1b6b)
// includes .. 4   (offset: 0x18b7)
// strings ... 41  (offset: 0x18d7)
// dev strs .. 0   (offset: 0x1b6b)
// exports ... 12  (offset: 0x116b)
// cseg ...... 0x3ea + 0xd81 (0x116b)
// imports ... 44  (offset: 0x134b)
// animtree1 . 0   (offset: 0x1b6b)
// animtree2 . 0   (offset: 0x1b6b)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility_player;
#using scripts\autotests\mp\autotests_utility_mit;
#using scripts\common\bots\bots_util;

#namespace test_mp_mit_traversals;

// Namespace test_mp_mit_traversals/testautomation
// Params 0, eflags: 0x20
// Checksum 0xc3c5daed, Offset: 0x408
// Size: 0x18
function event_handler[testautomation] main()
{
    autotests_utility_mit::function_45effcfcc139e74a( "scripts/autotests/mp/test_mp_mit_traversals.gsc", &start_test, &parameterize );
}

// Namespace test_mp_mit_traversals
// Params 2, eflags: 0x4
// Checksum 0x82d7d852, Offset: 0x428
// Size: 0x3de
function private function_1e189454fa9b104( player, var_83b8b49ebb084874 )
{
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Valid Traversal ID?|id_valid", var_83b8b49ebb084874, "scripts/autotests/mp/test_mp_mit_traversals.gsc", 23 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    traversal = level.mit_lookup[ var_83b8b49ebb084874 ];
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Traversal found?|trav_found", traversal, "scripts/autotests/mp/test_mp_mit_traversals.gsc", 26 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests_utility_mit::function_51e9e46c136ac9c3( player, "begin_position", "Traversal begin position", traversal.nodebegin.origin );
    autotests_utility_mit::function_51e9e46c136ac9c3( player, "end_position", "Traversal end position", traversal.nodeend.origin );
    autotests_utility_mit::function_fc203072b5b37c65( player, "traversal_type", traversal.nodebegin.animscript ?? "" );
    autotests_utility_mit::function_fc203072b5b37c65( player, "bot_entity", player getentitynumber() );
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "traversal.startSegmentStart defined?|start_seg_defined", traversal.var_138cf94d3ecdae0d, "scripts/autotests/mp/test_mp_mit_traversals.gsc", 33 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "traversal.endSegmentEnd defined?|end_seg_defined", traversal.var_1009da0b020c58e5, "scripts/autotests/mp/test_mp_mit_traversals.gsc", 34 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "traversal.navLinkId defined?|navlink_defined", traversal.navlinkid, "scripts/autotests/mp/test_mp_mit_traversals.gsc", 35 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    startpos = traversal.var_138cf94d3ecdae0d;
    endpos = traversal.var_1009da0b020c58e5;
    autotests::function_d84657f448aaeef6( "Start on NavMesh|start_on_nav", ispointonnavmesh( startpos, player ), "scripts/autotests/mp/test_mp_mit_traversals.gsc", 41 );
    autotests::function_d84657f448aaeef6( "End on NavMesh|end_on_nav", ispointonnavmesh( endpos, player ), "scripts/autotests/mp/test_mp_mit_traversals.gsc", 42 );
    starttoend = endpos - startpos;
    targetangles = vectortoangles( starttoend - ( 0, 0, 60 ) );
    player setplayerangles( targetangles );
    dropposition = startpos + ( 0, 0, 32 ) - vectornormalize2( starttoend ) * 16;
    var_219c344edbc6895b = getgroundposition( dropposition, 15 );
    player autotests_utility_player::set_player_position( var_219c344edbc6895b );
    player botsetpathingstyle( "scripted" );
    player function_90b3ed62e6d125e9( 1 );
    player botsetscriptgoal( endpos, 32, "tactical" );
    player botsetshorttermgoal( 1 );
    player.didtraversal = 0;
    player thread function_33e303076af75275( traversal );
    results = player bots_util::bot_waittill_goal_or_fail( 4 );
    player notify( #"hash_bcfca485846c3cf3" );
    autotests_utility_mit::function_51e9e46c136ac9c3( player, "last_position", "Bot position before traversal event", player.origin );
    autotests_utility_mit::function_fc203072b5b37c65( player, "bot_path_result", results );
    autotests_utility_mit::function_fc203072b5b37c65( player, "did_traversal", player.didtraversal );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Reached goal position|goal_reached", results, "goal", "scripts/autotests/mp/test_mp_mit_traversals.gsc", 67 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Did a traversal?|trav_used", player.didtraversal, "scripts/autotests/mp/test_mp_mit_traversals.gsc", 68 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace test_mp_mit_traversals
// Params 1, eflags: 0x4
// Checksum 0xde999792, Offset: 0x80e
// Size: 0x3b
function private function_33e303076af75275( traversal )
{
    self endon( #"hash_bcfca485846c3cf3" );
    
    while ( !self botisdoingtraversal( traversal.navlinkid ) )
    {
        waitframe();
    }
    
    self.didtraversal = 1;
}

// Namespace test_mp_mit_traversals
// Params 2, eflags: 0x4
// Checksum 0xa2321d44, Offset: 0x851
// Size: 0x96
function private function_dac81a146a1b98db( minbounds, maxbounds )
{
    const_timeout_ms = 10000;
    starttime = gettime();
    endtime = starttime + const_timeout_ms;
    
    while ( true )
    {
        if ( minbounds && maxbounds )
        {
            result = function_697f36edcf3f254f( minbounds, maxbounds );
        }
        else
        {
            result = function_697f36edcf3f254f();
        }
        
        if ( isdefined( result ) )
        {
            if ( result == 1 )
            {
                return fetchtraversals();
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

// Namespace test_mp_mit_traversals
// Params 0, eflags: 0x4
// Checksum 0x7055bb7e, Offset: 0x8ef
// Size: 0xb3
function private fetchtraversals()
{
    var_c00f525c21927ad0 = [];
    var_cfe194ca492ff52c = 122880;
    
    while ( true )
    {
        traversal = function_c55a3d225ff5d027();
        
        if ( !isdefined( traversal ) )
        {
            break;
        }
        
        if ( !( traversal.usageflag & var_cfe194ca492ff52c ) )
        {
            continue;
        }
        
        id = string( traversal.navlinkid );
        
        if ( isdefined( traversal.nodebegin ) && isdefined( traversal.nodebegin.target ) )
        {
            id = traversal.nodebegin.target;
        }
        
        var_c00f525c21927ad0[ id ] = traversal;
    }
    
    return var_c00f525c21927ad0;
}

// Namespace test_mp_mit_traversals
// Params 0, eflags: 0x4
// Checksum 0xbf524360, Offset: 0x9ab
// Size: 0x22e
function private function_1d28c180d7bfddab()
{
    wait 0.1;
    ascenders = function_f972efbcd627033e();
    
    foreach ( node in ascenders )
    {
        name = "[" + node.scriptableindex + "]" + node.scriptablename;
        p0 = { #targetname:name, #origin:node.start };
        p1 = { #targetname:name, #origin:node.end };
        function_adec9d9b9593ac2( "ascender_no_traversal", [ p0, p1 ] );
    }
    
    ladders = function_4cf22774d398c3f5( 210 );
    ladders = function_7243d45b5d82f431( ladders, #distanceScore, 4 );
    
    foreach ( node in ladders )
    {
        name = "hash_" + node.hash;
        p0 = { #targetname:name, #origin:node.start };
        p1 = { #targetname:name, #origin:node.end };
        function_adec9d9b9593ac2( "ladder_no_traversal", [ p0, p1 ], "distanceScore=" + node.distanceScore + " closestNavlink=" + node.navlinkstart );
    }
}

// Namespace test_mp_mit_traversals
// Params 4, eflags: 0x4
// Checksum 0xe55ddb28, Offset: 0xbe1
// Size: 0x28c
function private function_b3a0945da58bc585( situation, traversalid, traversal, comment )
{
    if ( situation != "pass" )
    {
        result = 1;
    }
    else
    {
        result = 0;
    }
    
    botentitynumber = self getentitynumber();
    traversaltype = traversal.nodebegin.animscript ?? "";
    var_d51e46999aca9ddb = autotests_utility_mit::validatevector( self.origin );
    var_93c06ebd39a8462a = autotests_utility_mit::validatevector( traversal.nodebegin.origin );
    var_7703496ab1a80a7a = autotests_utility_mit::validatevector( traversal.nodeend.origin );
    traversal_positions = [ var_d51e46999aca9ddb, var_93c06ebd39a8462a, var_7703496ab1a80a7a ];
    var_210fff1f5e19cace = [ { #description:"Bot position before traversal event", #type:"last_position" }, { #description:"Traversal begin position", #type:"begin_position" }, { #description:"Traversal end position", #type:"end_position" } ];
    metadefs = [ { #value:botentitynumber, #key:"bot_entity" }, { #value:situation, #key:"situation" }, { #value:level.script_noteworthy ?? "", #key:"script_noteworthy" }, { #value:level.script_parameters ?? "", #key:"script_parameters" }, { #value:traversalid ?? "", #key:"traversal_name" }, { #value:traversaltype ?? "", #key:"traversal_type" }, { #value:result, #key:"result" } ];
    autotests_utility_mit::send_spatial_event( "traversal_event", "scripts/autotests/mp/test_mp_mit_traversals.gsc", result, traversal_positions, var_210fff1f5e19cace, metadefs );
}

// Namespace test_mp_mit_traversals
// Params 3, eflags: 0x4
// Checksum 0xf68bd916, Offset: 0xe75
// Size: 0x278
function private function_adec9d9b9593ac2( situation = "unknown", traversaltarget, commentoverride )
{
    comment = commentoverride ?? #"";
    
    if ( situation != "pass" )
    {
        result = 1;
    }
    else
    {
        result = 0;
    }
    
    traversalname = traversaltarget[ 0 ].targetname ?? #"";
    traversaltype = #"";
    beginposition = traversaltarget[ 0 ].origin;
    endposition = traversaltarget[ 1 ].origin;
    var_93c06ebd39a8462a = autotests_utility_mit::validatevector( beginposition );
    var_7703496ab1a80a7a = autotests_utility_mit::validatevector( endposition );
    traversal_positions = [ var_93c06ebd39a8462a, var_7703496ab1a80a7a ];
    var_210fff1f5e19cace = [ { #description:"Traversal begin position", #type:"begin_position" }, { #description:"Traversal end position", #type:"end_position" } ];
    metadefs = [ { #value:-1, #key:"bot_entity" }, { #value:situation, #key:"situation" }, { #value:level.script_noteworthy ?? "", #key:"script_noteworthy" }, { #value:level.script_parameters ?? "", #key:"script_parameters" }, { #value:traversalname ?? "", #key:"traversal_name" }, { #value:traversaltype ?? "", #key:"traversal_type" }, { #value:comment ?? "", #key:"comment" } ];
    autotests_utility_mit::send_spatial_event( "traversal_event_missing", "scripts/autotests/mp/test_mp_mit_traversals.gsc", result, traversal_positions, var_210fff1f5e19cace, metadefs );
}

// Namespace test_mp_mit_traversals
// Params 0, eflags: 0x4
// Checksum 0xed2df2d1, Offset: 0x10f5
// Size: 0x3b
function private get_config()
{
    return { #sourcefile:"scripts/autotests/mp/test_mp_mit_traversals.gsc", #var_6b7f0911cb91054a:"traversal_event", #var_db86da194d47f8f2:&function_1e189454fa9b104, #var_4182163638fd37ed:&function_dac81a146a1b98db };
}

// Namespace test_mp_mit_traversals
// Params 1, eflags: 0x4
// Checksum 0x7fb9cb7b, Offset: 0x1139
// Size: 0x1a
function private parameterize( test_setup )
{
    return autotests_utility_mit::function_b7fe9eed6b7b2a72( test_setup, get_config() );
}

// Namespace test_mp_mit_traversals
// Params 0
// Checksum 0x7dd3a877, Offset: 0x115c
// Size: 0xf
function start_test()
{
    autotests_utility_mit::function_a10f1915e22ab0d4( get_config() );
}

