// scripts\autotests\mp\test_mp_mit_roaming.gsc  (hash_4f9b7a84a26783dc.gscc) (size: 8988 Bytes / 0x231c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa35d91e0 (2740818400)
// size ...... 8988 (0x231c)
// includes .. 5   (offset: 0x2010)
// strings ... 56  (offset: 0x2038)
// dev strs .. 0   (offset: 0x231c)
// exports ... 20  (offset: 0x14d8)
// cseg ...... 0x50d + 0xfcb (0x14d8)
// imports ... 70  (offset: 0x17f8)
// animtree1 . 0   (offset: 0x231c)
// animtree2 . 0   (offset: 0x231c)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility_player;
#using scripts\autotests\mp\autotests_utility_mit;
#using scripts\common\bots\bots_util;
#using scripts\common\utility;

#namespace test_mp_mit_roaming;

// Namespace test_mp_mit_roaming/testautomation
// Params 0, eflags: 0x20
// Checksum 0xdc209a04, Offset: 0x52b
// Size: 0x18
function event_handler[testautomation] main()
{
    autotests_utility_mit::function_45effcfcc139e74a( "scripts/autotests/mp/test_mp_mit_roaming.gsc", &start_test, &parameterize );
}

// Namespace test_mp_mit_roaming
// Params 1, eflags: 0x4
// Checksum 0x5aeee16, Offset: 0x54b
// Size: 0x5f
function private parameterize( test_setup )
{
    if ( getdvarint( @"hash_19b4bb343765193f", 1 ) == 1 )
    {
        return [];
    }
    
    parsed = test_setup.var_875fc462a0bca171;
    base = function_442610a81ceb0394( parsed );
    return autotests_utility_mit::function_b9d5c5769852731d( base, parsed.paramsuffix );
}

// Namespace test_mp_mit_roaming
// Params 1, eflags: 0x4
// Checksum 0x4f48e92a, Offset: 0x5b3
// Size: 0x7f
function private function_442610a81ceb0394( parsed )
{
    level.mit_lookup = undefined;
    range = autotests_utility_mit::function_49ecc308f2226722( parsed );
    
    if ( isdefined( range ) )
    {
        return range;
    }
    
    sample = parsed.named[ "sample" ] ?? "connectivity";
    level.mit_lookup = _build_lookup( sample, parsed.named );
    return getarraykeys( level.mit_lookup );
}

// Namespace test_mp_mit_roaming
// Params 0
// Checksum 0x95301d9b, Offset: 0x63b
// Size: 0xd1
function start_test()
{
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Has parameter?", self.parameters.size >= 1, "scripts/autotests/mp/test_mp_mit_roaming.gsc", 63 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    params = self._mit_mode.params;
    sample = params.named[ "sample" ] ?? "connectivity";
    
    if ( params.arenaindex < 0 )
    {
        if ( !isdefined( level.mit_lookup ) )
        {
            level.mit_lookup = _build_lookup( sample, params.named );
        }
    }
    
    autotests_utility_mit::function_a10f1915e22ab0d4( _get_config() );
}

// Namespace test_mp_mit_roaming
// Params 0, eflags: 0x4
// Checksum 0x4b881f4b, Offset: 0x714
// Size: 0x3b
function private _get_config()
{
    return { #sourcefile:"scripts/autotests/mp/test_mp_mit_roaming.gsc", #var_6b7f0911cb91054a:"roaming_event", #var_db86da194d47f8f2:&function_35de770b321171d7, #var_4182163638fd37ed:&function_b42686ac93216910 };
}

// Namespace test_mp_mit_roaming
// Params 2, eflags: 0x4
// Checksum 0xcc4ac1fb, Offset: 0x758
// Size: 0x9a
function private _build_lookup( sample, named )
{
    if ( sample == "random" )
    {
        count = int( named[ "count" ] ?? 50 );
        foundindex = autotests_utility_mit::function_35af25b427c6e001();
        
        if ( foundindex != -1 )
        {
            var_c5067745bf09ec8f = getxhash( "multi_arena_map_" + foundindex );
            level.var_3f72be11636d5c5c = count;
            return autotests_utility_mit::function_662871d9ef7d6a6c( var_c5067745bf09ec8f, &function_69e2d5fc2fd7a8a9 );
        }
        
        return autotests_utility_mit::function_8adc45a70f34952d( count, undefined, undefined );
    }
    
    return autotests_utility_mit::build_lookup( _get_config() );
}

// Namespace test_mp_mit_roaming
// Params 2, eflags: 0x4
// Checksum 0xebb8c601, Offset: 0x7fb
// Size: 0x39
function private function_69e2d5fc2fd7a8a9( minbounds, maxbounds )
{
    count = level.var_3f72be11636d5c5c ?? 50;
    return autotests_utility_mit::function_8adc45a70f34952d( count, minbounds, maxbounds );
}

// Namespace test_mp_mit_roaming
// Params 2
// Checksum 0xcb2e9592, Offset: 0x83d
// Size: 0x103
function function_b42686ac93216910( minbounds, maxbounds )
{
    var_c00f525c21927ad0 = [];
    function_7ca38f9f69bb3e7c( minbounds, maxbounds );
    
    while ( mit_hasnextedge() )
    {
        edgeinfo = mit_getnextedge();
        startpos = edgeinfo.startpos;
        endpos = edgeinfo.endpos;
        
        if ( minbounds && maxbounds )
        {
            if ( !function_65dadd7c402358e7( startpos, minbounds, maxbounds ) || !function_65dadd7c402358e7( endpos, minbounds, maxbounds ) )
            {
                continue;
            }
        }
        
        id = autotests_utility_mit::function_dc2e211727d1d124( startpos ) + "_to_" + autotests_utility_mit::function_dc2e211727d1d124( endpos );
        edge = spawnstruct();
        edge.startpos = startpos;
        edge.endpos = endpos;
        edge.edgeindex = edgeinfo.index;
        var_c00f525c21927ad0[ id ] = edge;
    }
    
    return var_c00f525c21927ad0;
}

// Namespace test_mp_mit_roaming
// Params 2, eflags: 0x4
// Checksum 0x7e1c6bc3, Offset: 0x949
// Size: 0x13b
function private function_7ca38f9f69bb3e7c( minbounds = undefined, maxbounds = undefined )
{
    if ( minbounds && maxbounds )
    {
        z = level.var_c9730d48ae5087bf ?? 0;
        var_1242bdda5611f171 = ( minbounds[ 0 ], minbounds[ 1 ], z );
        var_be028c9439f58c73 = ( maxbounds[ 0 ], maxbounds[ 1 ], z );
        function_ebf5a806f463e44d( var_1242bdda5611f171, var_be028c9439f58c73, 0.1 );
        return;
    }
    
    exclusioncenters = [];
    
    foreach ( gulag in utility::getstructarray( "gulag", "targetname" ) )
    {
        exclusioncenters[ exclusioncenters.size ] = gulag.origin;
    }
    
    if ( exclusioncenters.size == 0 )
    {
        mit_initializeedgesdata( 0.1 );
        return;
    }
    
    mit_initializeedgesdata( 0.1, exclusioncenters, 1500, 600 );
}

// Namespace test_mp_mit_roaming
// Params 3, eflags: 0x4
// Checksum 0x4b2dd3f0, Offset: 0xa8c
// Size: 0x4a, Type: bool
function private function_65dadd7c402358e7( pos, minbounds, maxbounds )
{
    return pos[ 0 ] >= minbounds[ 0 ] && pos[ 0 ] <= maxbounds[ 0 ] && pos[ 1 ] >= minbounds[ 1 ] && pos[ 1 ] <= maxbounds[ 1 ];
}

// Namespace test_mp_mit_roaming
// Params 2
// Checksum 0xe97990ca, Offset: 0xadf
// Size: 0x93
function function_35de770b321171d7( player, var_70031b9244365f37 )
{
    autotests::set_current_asset_name( var_70031b9244365f37 );
    edge = level.mit_lookup[ var_70031b9244365f37 ];
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Edge found?|edge_found", edge, "scripts/autotests/mp/test_mp_mit_roaming.gsc", 187 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    function_628909df3176a421( player, var_70031b9244365f37, edge.startpos, edge.endpos );
}

// Namespace test_mp_mit_roaming
// Params 4, eflags: 0x4
// Checksum 0xf523c09d, Offset: 0xb7a
// Size: 0x391
function private function_628909df3176a421( player, var_70031b9244365f37, startpos, endpos )
{
    player autotests_utility_player::set_player_position( startpos );
    player botsetpathingstyle( "scripted" );
    player botsetdifficultysetting( "slideChance", 0 );
    player botsetscriptgoal( endpos, 32, "tactical" );
    player botsetshorttermgoal( 1 );
    player.var_5d7906f2287d6c6e = [ startpos ];
    player.roamingsituation = undefined;
    player.roamingcomment = undefined;
    player.var_b3fae8081f376f0a = undefined;
    player childthread function_8ce92892a08d5915();
    player childthread function_f8ff99d5c8ad4770( endpos );
    player childthread function_770f0ae41bf1d343( endpos );
    player childthread function_f7ff8c4b3ca6a912( endpos );
    player utility::waittill_any_in_array( [ "roaming_fall_check_done", "roaming_stuck_check_done", "roaming_path_check_done" ] );
    player notify( #"hash_31a0b91a4646d799" );
    situation = player.roamingsituation;
    comment = player.roamingcomment;
    
    if ( situation == "bad_path_no_path_to_script_goal" )
    {
        reversedresult = function_c9b6697f593d5c1b( player, endpos, startpos );
        
        if ( reversedresult == "goal" )
        {
            situation = "bad_path_no_path_to_script_goal_reversed_ok";
            comment = "forward had no path; reverse succeeded";
        }
    }
    
    result = situation == "goal" || situation == "bad_path_no_path_to_script_goal_reversed_ok" ? 0 : 1;
    autotests_utility_mit::function_51e9e46c136ac9c3( player, "bot_position", "Player position when test ended", player.origin );
    autotests_utility_mit::function_51e9e46c136ac9c3( player, "start_position", "Edge start (teleport position)", startpos );
    autotests_utility_mit::function_51e9e46c136ac9c3( player, "end_position", "Edge end (script goal)", endpos );
    autotests_utility_mit::function_51e9e46c136ac9c3( player, "fall_position", "Position where fall was first detected (-1,-1,-1 if none)", player.var_b3fae8081f376f0a );
    trackstr = "";
    
    if ( isdefined( player.var_5d7906f2287d6c6e ) )
    {
        foreach ( point in player.var_5d7906f2287d6c6e )
        {
            trackstr += point + " ";
        }
        
        if ( trackstr.size > 800 )
        {
            var_c3be793a88709116 = player.var_5d7906f2287d6c6e;
            step = int( max( 1, var_c3be793a88709116.size / 26.6667 ) );
            trackstr = "";
            i = 0;
            
            while ( i < var_c3be793a88709116.size )
            {
                trackstr += var_c3be793a88709116[ i ] + " ";
                i += step;
            }
        }
    }
    
    autotests_utility_mit::function_fc203072b5b37c65( player, "situation", situation ?? "" );
    autotests_utility_mit::function_fc203072b5b37c65( player, "comment", comment ?? "" );
    autotests_utility_mit::function_fc203072b5b37c65( player, "track", trackstr );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Reached goal?|goal_reached", result, 0, "scripts/autotests/mp/test_mp_mit_roaming.gsc", 254 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    player.roamingsituation = undefined;
    player.roamingcomment = undefined;
    player.var_5d7906f2287d6c6e = undefined;
    player.var_b3fae8081f376f0a = undefined;
}

// Namespace test_mp_mit_roaming
// Params 3, eflags: 0x4
// Checksum 0x12335d6e, Offset: 0xf13
// Size: 0x4a
function private function_c9b6697f593d5c1b( player, revstart, revend )
{
    player autotests_utility_player::set_player_position( revstart );
    player botsetscriptgoal( revend, 32, "tactical" );
    player botsetshorttermgoal( 1 );
    return player bots_util::bot_waittill_goal_or_fail( 120 );
}

// Namespace test_mp_mit_roaming
// Params 0, eflags: 0x4
// Checksum 0xd5dcc757, Offset: 0xf66
// Size: 0x68
function private function_8ce92892a08d5915()
{
    self endon( #"hash_31a0b91a4646d799" );
    lastorigin = self.origin;
    
    while ( true )
    {
        wait 0.5;
        
        if ( distancesquared( lastorigin, self.origin ) > 100 )
        {
            lastorigin = self.origin;
            self.var_5d7906f2287d6c6e[ self.var_5d7906f2287d6c6e.size ] = lastorigin;
        }
    }
}

// Namespace test_mp_mit_roaming
// Params 1, eflags: 0x4
// Checksum 0xc58052f9, Offset: 0xfd6
// Size: 0xf0
function private function_f8ff99d5c8ad4770( target )
{
    self endon( #"hash_31a0b91a4646d799" );
    lastpos = undefined;
    startfalltime = undefined;
    
    while ( true )
    {
        wait 0.5;
        
        if ( self isonground() || self isswimming() || self botisdoingtraversal() )
        {
            lastpos = undefined;
            startfalltime = undefined;
            continue;
        }
        
        curpos = self.origin;
        
        if ( isdefined( lastpos ) )
        {
            fallingspeed = ( lastpos[ 2 ] - curpos[ 2 ] ) / 0.5;
            
            if ( fallingspeed > 100 )
            {
                if ( !isdefined( startfalltime ) )
                {
                    startfalltime = gettime();
                    self.var_b3fae8081f376f0a = lastpos;
                }
                
                if ( gettime() - startfalltime >= 4000 )
                {
                    self.roamingsituation = "custom_fall";
                    self.roamingcomment = undefined;
                    self notify( #"roaming_fall_check_done" );
                    return;
                }
            }
            else
            {
                startfalltime = undefined;
            }
        }
        
        lastpos = curpos;
    }
}

// Namespace test_mp_mit_roaming
// Params 1, eflags: 0x4
// Checksum 0xb82bc85, Offset: 0x10ce
// Size: 0xc4
function private function_770f0ae41bf1d343( target )
{
    self endon( #"hash_31a0b91a4646d799" );
    
    for ( lastpos = self.origin; true ; lastpos = self.origin )
    {
        wait 10;
        stuckstarttime = gettime();
        
        while ( distance( lastpos, self.origin ) < 32 )
        {
            if ( gettime() - stuckstarttime < 5000 )
            {
                waitframe();
                continue;
            }
            
            reason = function_4d9c50f9a7a17f5c( self, 64 );
            
            if ( !isdefined( reason ) )
            {
                reason = function_111ec4c1057da138( self, 64 );
            }
            
            self.roamingsituation = "custom_stuck";
            self.roamingcomment = reason;
            self notify( #"roaming_stuck_check_done" );
            return;
        }
    }
}

// Namespace test_mp_mit_roaming
// Params 1, eflags: 0x4
// Checksum 0x386f2c25, Offset: 0x119a
// Size: 0x131
function private function_f7ff8c4b3ca6a912( target )
{
    self endon( #"hash_31a0b91a4646d799" );
    pathevents = [ "goal", "off_navmesh", "bad_path_door_blocker_door_owner", "bad_path_door_blocker_invalid_client", "bad_path_stuck", "bad_path_stuck_in_traversal", "bad_path_fell_over_edge", "bad_path_fell_over_edge_when_jumping", "bad_path_no_path_to_script_goal", "bad_path_no_path_to_zone_goal", "bad_path_goal_cleared", "bad_path_owner_collide", "bad_path_tacpoint_invalid", "bad_path_no_tac_point", "bad_path_dvar" ];
    endtime = gettime() + 120000;
    
    while ( true )
    {
        result = utility::waittill_any_in_array_or_timeout( pathevents, 2 );
        
        if ( result == "timeout" )
        {
            if ( gettime() < endtime )
            {
                continue;
            }
            
            self.roamingsituation = "timeout";
            self.roamingcomment = undefined;
        }
        else
        {
            self.roamingsituation = result;
            self.roamingcomment = undefined;
        }
        
        self notify( #"roaming_path_check_done" );
        return;
    }
}

// Namespace test_mp_mit_roaming
// Params 2, eflags: 0x4
// Checksum 0xfdffc9dd, Offset: 0x12d3
// Size: 0xc7
function private function_111ec4c1057da138( bot, dist )
{
    nodes = getnodesinradius( bot.origin, dist, 0 );
    
    foreach ( node in nodes )
    {
        if ( isdefined( node.animscript ) && issubstr( node.animscript, "ladder" ) )
        {
            return "ladder";
        }
    }
}

// Namespace test_mp_mit_roaming
// Params 2, eflags: 0x4
// Checksum 0x1587014, Offset: 0x13a3
// Size: 0x134
function private function_4d9c50f9a7a17f5c( bot, dist )
{
    traceresult = navtrace( bot.origin, anglestoforward( bot.angles ) * dist + bot.origin );
    
    if ( traceresult )
    {
        doors = getentitylessscriptablearray( undefined, undefined, bot.origin, dist, "door" );
        
        foreach ( door in doors )
        {
            includedangle = anglesdelta( door.angles, bot.angles );
            var_7708693957d4270e = includedangle < 100 && includedangle > 80;
            
            if ( var_7708693957d4270e )
            {
                return ( door scriptabledoorisclosed() ? "closed_door" : "opened_door" );
            }
        }
    }
}

