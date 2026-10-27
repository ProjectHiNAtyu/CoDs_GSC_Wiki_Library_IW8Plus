// script_2986aa4b0ff2bddf  (hash_2986aa4b0ff2bddf.gscc) (size: 16854 Bytes / 0x41d6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc7eb6193 (3354091923)
// size ...... 16854 (0x41d6)
// includes .. 6   (offset: 0x3dfe)
// strings ... 65  (offset: 0x3e2e)
// dev strs .. 3   (offset: 0x41b2)
// exports ... 33  (offset: 0x2c4e)
// cseg ...... 0x472 + 0x27dc (0x2c4e)
// imports ... 104 (offset: 0x3176)
// animtree1 . 0   (offset: 0x41d6)
// animtree2 . 0   (offset: 0x41d6)
#using script_3d2770dc09c1243;
#using scripts\common\utility;
#using scripts\mp\bots\bots_gametype_super_shared;
#using scripts\mp\bots\bots_util;
#using scripts\mp\matchdata;
#using scripts\mp\outofbounds;

#namespace mit_roaming;

// Namespace mit_roaming
// Params 0
// Checksum 0x5bed9d77, Offset: 0x490
// Size: 0x11f
function init()
{
    level.mit.roaming = { #skipped:0, #failure:0, #success:0, #reportedpositions:[] };
    
    /#
        if ( mit::function_168f26942e588420() )
        {
            level.mit.roaming.var_1295dfc4513e569d = 0;
            return;
        }
    #/
    
    function_b21c29a84df522();
    level.mit.roaming.var_1295dfc4513e569d = mit_getedgecount() > 0;
    
    if ( level.mit.roaming.var_1295dfc4513e569d )
    {
        level.mit.roaming.var_54434bdae59bbde4 = mit_getedgecount();
        level.mit.roaming.reversededges = [];
    }
    
    logstring( "MIT/Roaming - level.MIT.Roaming.IsConnectivityTest=" + level.mit.roaming.var_1295dfc4513e569d );
}

// Namespace mit_roaming
// Params 0, eflags: 0x4
// Checksum 0x4abe4656, Offset: 0x5b7
// Size: 0x106
function private function_b21c29a84df522()
{
    exclusioncenters = [];
    
    foreach ( gulag in utility::getstructarray( "gulag", "targetname" ) )
    {
        exclusioncenters[ exclusioncenters.size ] = gulag.origin;
    }
    
    var_ab702906cb49ca78 = getdvarfloat( @"hash_eeafa4170c1c43c2", 0.1 );
    
    if ( exclusioncenters.size == 0 )
    {
        mit_initializeedgesdata( var_ab702906cb49ca78 );
        return;
    }
    
    var_b78054f7c212e772 = getdvarfloat( @"hash_4e1bd7e9f708b12", 1500 );
    var_7412c7bb93a738cf = getdvarfloat( @"hash_9e7ca2260359bf6f", 600 );
    mit_initializeedgesdata( var_ab702906cb49ca78, exclusioncenters, var_b78054f7c212e772, var_7412c7bb93a738cf );
}

// Namespace mit_roaming
// Params 0
// Checksum 0x65a8588c, Offset: 0x6c5
// Size: 0xf8
function function_119b9a096f5511d2()
{
    if ( level.mit.roaming.var_1295dfc4513e569d && level.mit.roaming.reversededges.size == 0 && !mit_hasnextedge() )
    {
        return 0;
    }
    
    if ( !isdefined( level.mit.roaming.starttime ) )
    {
        level.mit.roaming.starttime = getsystemtime();
    }
    
    roamingduration = getdvarint( @"scr_mit_roaming_duration", -1 );
    
    if ( roamingduration < 0 )
    {
        return 1;
    }
    
    if ( roamingduration == 0 )
    {
        return 0;
    }
    
    duration = getsystemtime() - level.mit.roaming.starttime;
    return duration <= roamingduration;
}

// Namespace mit_roaming
// Params 1
// Checksum 0xb07255d8, Offset: 0x7c5
// Size: 0x339
function testprocess( var_ddf067edb7389ca0 )
{
    const_goal_radius = 32;
    self.mit.onplayerkilled = &onplayerkilled;
    self.mit.roamingfinished = 0;
    self.mit.var_4795d97b7d75c854 = undefined;
    self.mit.var_be31251c72bb48ed = undefined;
    destination = undefined;
    
    if ( isdefined( var_ddf067edb7389ca0 ) )
    {
        destination = var_ddf067edb7389ca0;
    }
    else if ( level.mit.roaming.var_1295dfc4513e569d )
    {
        [ startpos, destination, edgeindex, var_40aada8f4cbfe585 ] = getnextedge();
        self.mit.var_be31251c72bb48ed = var_40aada8f4cbfe585;
        self.mit.edgeindex = edgeindex;
        success = resetposition( startpos );
        
        if ( !success )
        {
            return;
        }
    }
    else
    {
        if ( getdvarint( @"hash_568a0d6a4a05aea4", 0 ) == 0 )
        {
            const_drop_height = 100;
            startpos = bots_util_mp::function_478281ff275ed942();
            success = resetposition( startpos, const_drop_height );
            
            if ( !success )
            {
                return;
            }
        }
        
        destination = function_1265c6a6af1c5c3e();
    }
    
    assert( isdefined( destination ) );
    self.mit.botstartpos = self.origin;
    self.mit.botendpos = destination;
    enableparachute( 0 );
    self botsetdifficultysetting( "slideChance", 0 );
    namespace_ef4547f85724edd1::setscriptgoal( destination, const_goal_radius );
    childthread function_70cfbf48a84dc28e();
    childthread function_ea477aecb4e05f00( destination );
    childthread function_e230cd8806912753( destination );
    childthread function_fc3a0a255a31c4df( destination );
    check_end_notify = [ "custom_fall_check_finished", "custom_stuck_check_finished", "path_event_check_finished" ];
    utility::waittill_any_in_array( check_end_notify );
    
    if ( self.mit.var_4795d97b7d75c854 == "try_reversed_path" )
    {
        reversededge = [ self.mit.botendpos, self.mit.botstartpos, self.mit.edgeindex ];
        level.mit.roaming.reversededges[ level.mit.roaming.reversededges.size ] = reversededge;
    }
    else if ( self.mit.var_4795d97b7d75c854 != "goal" )
    {
        if ( isdefined( var_ddf067edb7389ca0 ) )
        {
            freezebot( 1 );
            
            while ( true )
            {
                wait 60;
            }
        }
        
        /#
            waitforscreenshot( self.mit.var_4795d97b7d75c854 != "<dev string:x24>" );
        #/
    }
    
    self.mit.roamingfinished = 1;
}

// Namespace mit_roaming
// Params 0
// Checksum 0x4d361219, Offset: 0xb06
// Size: 0x64
function endhandler()
{
    if ( !self.mit.roamingfinished && namespace_ef4547f85724edd1::isaliveplayer( self ) )
    {
        report( "unexpectedly", self, [ function_9abb8a5256f7be57( "botPos", self.origin ) ] );
    }
    
    printprogress();
    self.mit.edgeindex = undefined;
}

// Namespace mit_roaming
// Params 0, eflags: 0x4
// Checksum 0xa7b0c8ae, Offset: 0xb72
// Size: 0x390
function private printprogress()
{
    if ( !isdefined( level.mit.roaming.var_a786e2c602b82e11 ) )
    {
        level.mit.roaming.var_a786e2c602b82e11 = getsystemtime();
    }
    
    switch ( self.mit.var_4795d97b7d75c854 )
    {
        case #"hash_cca707fc9f8c931":
            edgestatus = undefined;
            return;
        case #"hash_8d43150f19c69bd6":
            level.mit.roaming.success++;
            edgestatus = 1;
            break;
        case #"hash_c2ee5d89fcc2af22":
            level.mit.roaming.skipped++;
            edgestatus = 3;
            break;
        default:
            level.mit.roaming.failure++;
            edgestatus = 2;
            break;
    }
    
    reportsummary = 0;
    var_2571725b33b0a619 = 0;
    
    if ( isdefined( edgestatus ) && isdefined( self.mit.edgeindex ) )
    {
        function_bb28fce52cca3130( self.mit.edgeindex, edgestatus );
    }
    
    finished = level.mit.roaming.success + level.mit.roaming.failure;
    
    if ( level.mit.roaming.var_1295dfc4513e569d )
    {
        total = level.mit.roaming.var_54434bdae59bbde4;
        finished += level.mit.roaming.skipped;
        
        if ( finished >= total )
        {
            reportsummary = 1;
            var_2571725b33b0a619 = 1;
        }
        
        summaryinterval = getdvarint( @"hash_43e58e4246e249d8", 20 );
        
        if ( getsystemtime() - level.mit.roaming.var_a786e2c602b82e11 >= summaryinterval )
        {
            level.mit.roaming.var_a786e2c602b82e11 = getsystemtime();
            logstring( "MIT/Roaming - current progress is: " + round( 100 * finished / total ) + "% (" + finished + " of " + total + ")" );
        }
    }
    else
    {
        total = finished;
    }
    
    if ( reportsummary )
    {
        reportstring = "Test result: " + total + " roaming cases, " + level.mit.roaming.success + " successes, " + level.mit.roaming.failure + " failures";
        
        if ( level.mit.roaming.var_1295dfc4513e569d )
        {
            reportstring += ", " + level.mit.roaming.skipped + " skipped";
        }
        
        reportstring += ".";
        mit::outputlog( "Roaming", reportstring );
    }
    
    if ( var_2571725b33b0a619 )
    {
        mit::outputlog( "Roaming", "All done." );
    }
}

// Namespace mit_roaming
// Params 0, eflags: 0x4
// Checksum 0xbcca66a8, Offset: 0xf0a
// Size: 0x18a
function private getnextedge()
{
    assert( level.mit.roaming.var_1295dfc4513e569d && ( level.mit.roaming.reversededges.size > 0 || mit_hasnextedge() ) );
    
    if ( level.mit.roaming.reversededges.size == 0 )
    {
        var_40aada8f4cbfe585 = 1;
        edgeinfo = mit_getnextedge();
        startpos = edgeinfo.startpos;
        endpos = edgeinfo.endpos;
        edgeindex = edgeinfo.index;
    }
    else
    {
        var_40aada8f4cbfe585 = 0;
        [ startpos, endpos, edgeindex ] = level.mit.roaming.reversededges[ level.mit.roaming.reversededges.size - 1 ];
        level.mit.roaming.reversededges[ level.mit.roaming.reversededges.size - 1 ] = undefined;
    }
    
    return [ startpos, endpos, edgeindex, var_40aada8f4cbfe585 ];
}

// Namespace mit_roaming
// Params 1, eflags: 0x4
// Checksum 0xbec29ce8, Offset: 0x109d
// Size: 0xfb
function private onplayerkilled( deathdata )
{
    if ( !isbot( self ) )
    {
        return;
    }
    
    interestingpos = [];
    interestingpos[ interestingpos.size ] = function_9abb8a5256f7be57( "deathPos", self.lastdeathpos );
    
    if ( outofbounds::ispointinoutofbounds( self.lastdeathpos, self.team ) )
    {
        report( "killed_by_oob", self, interestingpos, self.mit.botendpos, undefined, deathdata.meansofdeath );
    }
    else
    {
        if ( isdefined( self.mit.var_594e2cb72a55127b ) )
        {
            interestingpos[ interestingpos.size ] = function_9abb8a5256f7be57( "startFall", self.mit.var_594e2cb72a55127b );
        }
        
        report( "death", self, interestingpos, self.mit.botendpos, undefined, deathdata.meansofdeath );
    }
    
    enableparachute( 1 );
}

// Namespace mit_roaming
// Params 0, eflags: 0x4
// Checksum 0x2e10d70e, Offset: 0x11a0
// Size: 0xa3
function private function_70cfbf48a84dc28e()
{
    var_8639449008493175 = 0.5;
    lastorigin = self.origin;
    self.mit.var_5d7906f2287d6c6e = [ lastorigin ];
    
    while ( true )
    {
        wait var_8639449008493175;
        var_2f26cf0f3bbb45e6 = 100;
        
        if ( distancesquared( lastorigin, self.origin ) > var_2f26cf0f3bbb45e6 )
        {
            lastorigin = self.origin;
            self.mit.var_5d7906f2287d6c6e[ self.mit.var_5d7906f2287d6c6e.size ] = lastorigin;
        }
    }
}

// Namespace mit_roaming
// Params 1, eflags: 0x4
// Checksum 0xd10b552f, Offset: 0x124b
// Size: 0x140
function private function_ea477aecb4e05f00( target )
{
    var_a04539910366d1b8 = 0.5;
    var_8155d3bafe2934bc = 100;
    var_a997df807e040651 = 4;
    lastpos = undefined;
    startfalltime = undefined;
    var_47a15440b51d52ee = mit::function_39ee610d2625a324( var_a997df807e040651 );
    
    while ( true )
    {
        wait var_a04539910366d1b8;
        
        if ( self isonground() || self isswimming() || self botisdoingtraversal() )
        {
            lastpos = undefined;
            startfalltime = undefined;
            continue;
        }
        
        curpos = self.origin;
        
        if ( isdefined( lastpos ) )
        {
            fallingspeed = ( lastpos[ 2 ] - curpos[ 2 ] ) / var_a04539910366d1b8;
            
            if ( fallingspeed > var_8155d3bafe2934bc )
            {
                if ( !isdefined( startfalltime ) )
                {
                    startfalltime = mit::function_9f2a98ba9eb78c4d();
                    self.mit.var_594e2cb72a55127b = lastpos;
                }
                
                if ( mit::function_9f2a98ba9eb78c4d() - startfalltime >= var_47a15440b51d52ee )
                {
                    report( "custom_fall", self, [ function_9abb8a5256f7be57( "startFalling", self.mit.var_594e2cb72a55127b ) ], target, undefined, undefined );
                    self notify( #"custom_fall_check_finished" );
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

// Namespace mit_roaming
// Params 1, eflags: 0x4
// Checksum 0x99143ac4, Offset: 0x1393
// Size: 0x10e
function private function_e230cd8806912753( target )
{
    self endon( #"end_custom_stuck" );
    var_f5352a4f83a8a2eb = 10;
    var_b2a5f4f245014251 = 32;
    var_c42fbbbe4fe54e35 = 64;
    var_22e77dfa23655c91 = 5000;
    
    for ( lastpos = self.origin; true ; lastpos = self.origin )
    {
        wait var_f5352a4f83a8a2eb;
        var_4c8e53392bd0506b = mit::function_9f2a98ba9eb78c4d();
        
        while ( distance( lastpos, self.origin ) < var_b2a5f4f245014251 )
        {
            if ( mit::function_9f2a98ba9eb78c4d() - var_4c8e53392bd0506b < var_22e77dfa23655c91 )
            {
                waitframe();
                continue;
            }
            
            reason = detectdoor( self, var_c42fbbbe4fe54e35 );
            
            if ( !isdefined( reason ) )
            {
                reason = detectladder( self, var_c42fbbbe4fe54e35 );
            }
            
            report( "custom_stuck", self, [ function_9abb8a5256f7be57( "botPos", self.origin ) ], target, self botgetpath(), reason );
            self notify( #"custom_stuck_check_finished" );
            return;
        }
    }
}

// Namespace mit_roaming
// Params 1, eflags: 0x4
// Checksum 0x9d0f936f, Offset: 0x14a9
// Size: 0x168
function private function_fc3a0a255a31c4df( target )
{
    var_8e7d5d3e5b5506ef = 2;
    var_588c868b60eba6e5 = 120;
    var_29e29035992ae27e = mit::function_39ee610d2625a324( var_588c868b60eba6e5 );
    starttime = mit::function_9f2a98ba9eb78c4d();
    endtime = starttime + var_29e29035992ae27e;
    path = undefined;
    var_13cf9d9913c07433 = undefined;
    
    while ( true )
    {
        result = mit::function_adbdc8fee4453bd7( self, var_8e7d5d3e5b5506ef );
        newpath = self botgetpath();
        
        if ( isdefined( newpath ) )
        {
            path = newpath;
        }
        
        switch ( result )
        {
            case #"hash_d4dde12b38318c68":
                if ( mit::function_9f2a98ba9eb78c4d() < endtime )
                {
                    continue;
                }
                
                break;
            case #"hash_8d43150f19c69bd6":
                var_13cf9d9913c07433 = result;
                break;
            case #"hash_3d838be743e788a":
                if ( self.mit.var_be31251c72bb48ed )
                {
                    var_13cf9d9913c07433 = "try_reversed_path";
                }
                
                break;
            default:
                break;
        }
        
        if ( isdefined( var_13cf9d9913c07433 ) )
        {
            self.mit.var_4795d97b7d75c854 = var_13cf9d9913c07433;
        }
        else
        {
            report( result, self, [ function_9abb8a5256f7be57( "botPos", self.origin ) ], target, path );
        }
        
        self notify( #"path_event_check_finished" );
        return;
    }
}

// Namespace mit_roaming
// Params 6, eflags: 0x4
// Checksum 0xcf028883, Offset: 0x1619
// Size: 0x65f
function private report( situation, bot, position, target, path, comment )
{
    if ( !level.mit.roaming.var_8666f68112c4ad64 )
    {
        header = "#time; #situation; #bot; #position; #begin; #end; #pathFind; #comment; #track";
        mit::outputlog( "Roaming", header );
        level.mit.roaming.var_8666f68112c4ad64 = 1;
    }
    
    assert( isarray( position ) );
    
    if ( function_727fcac2b8f08b1( position[ 0 ].origin, path ) )
    {
        self.mit.var_4795d97b7d75c854 = "skip";
        return;
    }
    
    situation = situation ? situation : "NO_SITUATION";
    self.mit.var_4795d97b7d75c854 = situation;
    posstr = "";
    
    foreach ( pos in position )
    {
        posstr += pos.posdescription + pos.origin + " ";
    }
    
    pathstr = "";
    
    if ( isdefined( path ) )
    {
        for ( i = 0; i < path.size ; i++ )
        {
            pathstr += path[ i ];
        }
    }
    
    reportstring = gettime() + "; " + situation + "; " + bot getentitynumber() + "; " + posstr + "; " + ( bot.mit.botstartpos ?? "" ) + "; " + ( target ?? "" ) + "; " + pathstr + "; " + ( comment ?? "" ) + ";";
    var_39d8cf1403d26bf4 = 4096;
    lineindex = 0;
    trackstring = "";
    
    if ( isarray( self.mit.var_5d7906f2287d6c6e ) )
    {
        foreach ( path in self.mit.var_5d7906f2287d6c6e )
        {
            pathstr = path + "";
            
            if ( reportstring.size + pathstr.size >= var_39d8cf1403d26bf4 )
            {
                mit::outputlog( "Roaming", reportstring, lineindex > 0 );
                reportstring = "";
                lineindex++;
            }
            
            trackstring += pathstr;
            reportstring += pathstr;
        }
    }
    
    mit::outputlog( "Roaming", reportstring, lineindex > 0 );
    var_81df7f83601be0e9 = mit::function_655ffb35317b1edb( position[ 0 ].origin, 3, [ -1, -1, -1 ] );
    var_28a230212facea93 = mit::function_655ffb35317b1edb( bot.mit.botstartpos, 3, [ -1, -1, -1 ] );
    var_b49f24dc163d2c3d = mit::function_655ffb35317b1edb( target, 3, [ -1, -1, -1 ] );
    dlog_recordevent( "dlog_event_mit_roaming", [ "time", matchdata::gettimefrommatchstart( gettime() ) ?? -1, "situation", situation ?? "", "bot", bot getentitynumber() ?? -1, "position_x", var_81df7f83601be0e9[ 0 ] * 1, "position_y", var_81df7f83601be0e9[ 1 ] * 1, "position_z", var_81df7f83601be0e9[ 2 ] * 1, "begin_x", var_28a230212facea93[ 0 ] * 1, "begin_y", var_28a230212facea93[ 1 ] * 1, "begin_z", var_28a230212facea93[ 2 ] * 1, "end_x", var_b49f24dc163d2c3d[ 0 ] * 1, "end_y", var_b49f24dc163d2c3d[ 1 ] * 1, "end_z", var_b49f24dc163d2c3d[ 2 ] * 1, "path_find", pathstr ?? "", "comment", comment ?? "", "track", trackstring ?? "" ] );
    extrareport( situation, bot, position, target, path, comment );
    
    /#
        if ( getdvarint( @"hash_824c718cad3c0f17", 1 ) )
        {
            if ( isdefined( level.mit.roaming.var_5d233476ee119367 ) )
            {
                level.mit.roaming.var_5d233476ee119367 += 1;
            }
            else
            {
                level.mit.roaming.var_5d233476ee119367 = 1;
            }
            
            mit::requestscreenshot( "<dev string:x29>", position[ 0 ].origin, position[ 0 ].origin + ( 0, 0, 100 ), undefined, level.mit.roaming.var_5d233476ee119367 );
        }
    #/
}

// Namespace mit_roaming
// Params 6, eflags: 0x4
// Checksum 0x181dfdfd, Offset: 0x1c80
// Size: 0x15e
function private extrareport( situation, bot, position, target, path, comment )
{
    reportstring = "";
    
    switch ( situation )
    {
        case #"hash_e8bc3da4af287c2d":
            var_2d733f8db9bb3f09 = isarray( position ) && isdefined( position[ 1 ] ) && position[ 1 ].posdescription == "startFall" && position[ 0 ].origin[ 2 ] < level.mit.var_ab856b914f0c2035;
            
            if ( var_2d733f8db9bb3f09 )
            {
                reportstring += "death_bot_fell_in_hole, " + position[ 0 ].posdescription + position[ 0 ].origin + ", " + position[ 1 ].posdescription + position[ 1 ].origin;
            }
            
            break;
        case #"hash_c023be270799b5f9":
            if ( isdefined( comment ) )
            {
                reportstring += "custom_stuck_by_" + comment;
                reportstring += ", " + position[ 0 ].origin;
            }
            
            break;
    }
    
    if ( reportstring != "" )
    {
        mit::outputlog( "Roaming_Bug", reportstring );
    }
}

// Namespace mit_roaming
// Params 2, eflags: 0x4
// Checksum 0xec0be963, Offset: 0x1de6
// Size: 0x37, Type: bool
function private function_727fcac2b8f08b1( position, path )
{
    return function_8365f2dce54e4c32( position ) || function_4b5caea236d96ab7( position, path ) || function_c7aa9fedf00f8d17( position, path );
}

// Namespace mit_roaming
// Params 1, eflags: 0x4
// Checksum 0x9bb16e3c, Offset: 0x1e26
// Size: 0xec, Type: bool
function private function_8365f2dce54e4c32( position )
{
    var_2f26cf0f3bbb45e6 = 100;
    
    foreach ( reportedpos in level.mit.roaming.reportedpositions )
    {
        if ( distancesquared( reportedpos, position ) < var_2f26cf0f3bbb45e6 )
        {
            return true;
        }
    }
    
    level.mit.roaming.reportedpositions[ level.mit.roaming.reportedpositions.size ] = position;
    return false;
}

// Namespace mit_roaming
// Params 2, eflags: 0x4
// Checksum 0x1f102ba5, Offset: 0x1f1b
// Size: 0x1d8, Type: bool
function private function_4b5caea236d96ab7( position, path )
{
    if ( !isdefined( level.mit.door ) || !isarray( level.mit.door.var_a752a51f6436637c ) )
    {
        return false;
    }
    
    const_distance_threshold = 64;
    subpaths = function_822aba6c5c71e5fb( position, path, const_distance_threshold, 1 );
    
    if ( !isdefined( subpaths ) )
    {
        return false;
    }
    
    foreach ( doorinfo in level.mit.door.var_a752a51f6436637c )
    {
        var_b5783c36c6e1d6c9 = 64;
        var_d49178107e605b6e = doorinfo.door.origin;
        var_fde5ed9eb3095cdb = var_d49178107e605b6e + anglestoforward( doorinfo.originangle ) * var_b5783c36c6e1d6c9;
        
        foreach ( subpath in subpaths )
        {
            intersected = mit::function_57b388b15cd6d2a5( subpath[ 0 ], subpath[ 1 ], var_d49178107e605b6e, var_fde5ed9eb3095cdb );
            
            if ( intersected )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace mit_roaming
// Params 2, eflags: 0x4
// Checksum 0x592413b5, Offset: 0x20fc
// Size: 0x1bc, Type: bool
function private function_c7aa9fedf00f8d17( position, path )
{
    if ( !isdefined( level.mit.traversal ) || !isarray( level.mit.traversal.var_205c9224a684088c ) )
    {
        return false;
    }
    
    const_distance_threshold = 64;
    subpaths = function_822aba6c5c71e5fb( position, path, const_distance_threshold, 0 );
    
    if ( !isdefined( subpaths ) )
    {
        return false;
    }
    
    foreach ( traversalinfo in level.mit.traversal.var_205c9224a684088c )
    {
        traversalstart = traversalinfo[ 0 ].origin;
        traversalend = traversalinfo[ 1 ].origin;
        
        foreach ( subpath in subpaths )
        {
            var_c145a46124d4c40e = function_c145a46124d4c40e( traversalstart, traversalend, subpath[ 0 ], subpath[ 1 ] );
            
            if ( var_c145a46124d4c40e )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace mit_roaming
// Params 4, eflags: 0x4
// Checksum 0xdc3c7886, Offset: 0x22c1
// Size: 0xef
function private function_822aba6c5c71e5fb( position, path, thresholddist, var_bac0ac51c3678ea2 )
{
    if ( !( isdefined( position ) && isdefined( path ) ) || !isarray( path ) || path.size < 2 )
    {
        return;
    }
    
    if ( !isdefined( thresholddist ) )
    {
        thresholddist = 64;
    }
    
    res = [];
    
    for ( i = 0; i < path.size - 1 ; i++ )
    {
        p1 = path[ i ];
        p2 = path[ i + 1 ];
        
        if ( var_bac0ac51c3678ea2 && i == 0 )
        {
            d12 = vectornormalize( p1 - p2 );
            p1 += d12 * thresholddist;
        }
        
        if ( function_fba0bc27de72f4ed( position, p1, p2, thresholddist ) )
        {
            res[ res.size ] = [ p1, p2 ];
        }
    }
    
    if ( res.size > 0 )
    {
        return res;
    }
}

// Namespace mit_roaming
// Params 4, eflags: 0x4
// Checksum 0x53d15833, Offset: 0x23b9
// Size: 0x6d, Type: bool
function private function_fba0bc27de72f4ed( position, start, end, thresholddist )
{
    subpathlength = length2d( end - start );
    var_6ac923ad6f6a23cc = length2d( position - start );
    var_4b8d8258d154af95 = length2d( position - end );
    return abs( var_6ac923ad6f6a23cc + var_4b8d8258d154af95 - subpathlength ) < thresholddist;
}

// Namespace mit_roaming
// Params 4, eflags: 0x4
// Checksum 0x9b3dbef, Offset: 0x242f
// Size: 0x4e, Type: bool
function private function_c145a46124d4c40e( traversalstart, traversalend, subpathstart, subpathend )
{
    var_e8f932ed82568202 = 1024;
    return distancesquared( traversalstart, subpathstart ) < var_e8f932ed82568202 && distancesquared( traversalend, subpathend ) < var_e8f932ed82568202;
}

// Namespace mit_roaming
// Params 0, eflags: 0x4
// Checksum 0xed46792f, Offset: 0x2486
// Size: 0x20
function private function_1265c6a6af1c5c3e()
{
    if ( getdvarint( @"scr_mit_roaming_in_range", 0 ) )
    {
        return function_cbdbbae721afa68e();
    }
    
    return bots_util_mp::function_478281ff275ed942();
}

// Namespace mit_roaming
// Params 0, eflags: 0x4
// Checksum 0x556bbeaf, Offset: 0x24af
// Size: 0x285
function private function_cbdbbae721afa68e()
{
    const_max_attempts = 5;
    var_26640f37db9792b5 = [ 30, 60, 90, 145, 180 ];
    var_2b5f5595a57a410 = [ 500, 1000, 1500, 2000, 2500 ];
    assert( var_26640f37db9792b5.size == const_max_attempts && var_2b5f5595a57a410.size == const_max_attempts );
    var_2878d5b3cdb38212 = 0.5;
    var_2855dfb3cd8d5058 = 1;
    var_de286c7079c33a22 = 1600;
    var_f8336917a79b402 = 200;
    yaw = self.angles[ 1 ];
    attempts = 0;
    finalpoint = undefined;
    
    while ( attempts < const_max_attempts )
    {
        leftangle = angleclamp180( yaw - var_26640f37db9792b5[ attempts ] );
        rightangle = angleclamp180( yaw + var_26640f37db9792b5[ attempts ] );
        anglediff = anglesdelta( ( 0, leftangle, 0 ), ( 0, rightangle, 0 ) );
        theta = leftangle + randomfloat( anglediff );
        radius = var_2b5f5595a57a410[ attempts ] * randomfloatrange( var_2878d5b3cdb38212, var_2855dfb3cd8d5058 );
        offset = radius * ( cos( theta ), sin( theta ), 0 );
        desiredpoint = self.origin + offset;
        clippedpoint = bots_util_mp::function_1882f18076610076( desiredpoint );
        randompoints = getrandomnavpoints( clippedpoint, var_f8336917a79b402, 3, self );
        prevdistsq = -1;
        candidatepoint = undefined;
        
        foreach ( point in randompoints )
        {
            distsq = lengthsquared( point - clippedpoint );
            
            if ( distsq > prevdistsq )
            {
                candidatepoint = point;
                prevdistsq = distsq;
            }
        }
        
        /#
            function_5d7c75578b8dc856( desiredpoint, clippedpoint, candidatepoint );
        #/
        
        if ( lengthsquared( candidatepoint - self.origin ) > var_de286c7079c33a22 )
        {
            finalpoint = candidatepoint;
            break;
        }
        
        attempts++;
    }
    
    if ( !isdefined( finalpoint ) )
    {
        finalpoint = bots_util_mp::function_478281ff275ed942();
    }
    
    return finalpoint;
}

// Namespace mit_roaming
// Params 1, eflags: 0x4
// Checksum 0xf534a99, Offset: 0x273d
// Size: 0x33
function private enableparachute( enabled )
{
    self skydive_setdeploymentstatus( enabled );
    self skydive_setbasejumpingstatus( enabled );
    
    if ( enabled == 1 )
    {
        self skydive_cutautodeployon();
        return;
    }
    
    self skydive_cutautodeployoff();
}

// Namespace mit_roaming
// Params 1, eflags: 0x4
// Checksum 0x52d23b32, Offset: 0x2778
// Size: 0x4a
function private freezebot( freeze )
{
    self botsetflag( "disable_movement", freeze );
    self botsetflag( "disable_rotation", freeze );
    
    if ( freeze )
    {
        self notify( #"end_custom_stuck" );
        self setvelocity( ( 0, 0, 0 ) );
    }
}

// Namespace mit_roaming
// Params 2, eflags: 0x4
// Checksum 0x77f57ced, Offset: 0x27ca
// Size: 0x64, Type: bool
function private resetposition( startpos, var_d27633705e390ce )
{
    var_4adbd46a987c2f21 = 50;
    failedresult = mit::botteleport( startpos, var_4adbd46a987c2f21, var_d27633705e390ce );
    
    if ( isdefined( failedresult ) )
    {
        report( "failed_teleport", self, [ function_9abb8a5256f7be57( "newPoint", startpos ) ], undefined, undefined, failedresult );
        return false;
    }
    
    return true;
}

// Namespace mit_roaming
// Params 2, eflags: 0x4
// Checksum 0xc2c54ac6, Offset: 0x2837
// Size: 0xc7
function private detectladder( bot, dist )
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

// Namespace mit_roaming
// Params 2, eflags: 0x4
// Checksum 0xb7ba1fa2, Offset: 0x2907
// Size: 0x134
function private detectdoor( bot, dist )
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

// Namespace mit_roaming
// Params 2, eflags: 0x4
// Checksum 0xd818be9f, Offset: 0x2a44
// Size: 0x2c
function private function_9abb8a5256f7be57( description, origin )
{
    return { #origin:origin, #posdescription:description };
}

/#

    // Namespace mit_roaming
    // Params 1, eflags: 0x4
    // Checksum 0x55c28277, Offset: 0x2a79
    // Size: 0x81, Type: dev
    function private waitforscreenshot( takescreenshot )
    {
        if ( takescreenshot && getdvarint( @"hash_824c718cad3c0f17", 1 ) && isdefined( level.mit.roaming.var_5d233476ee119367 ) )
        {
            freezebot( 1 );
            level waittill( "<dev string:x31>" + level.mit.roaming.var_5d233476ee119367 );
            freezebot( 0 );
        }
    }

    // Namespace mit_roaming
    // Params 3, eflags: 0x4
    // Checksum 0x62bb16f2, Offset: 0x2b02
    // Size: 0xfb, Type: dev
    function private function_5d7c75578b8dc856( desiredpoint, clippedpoint, candidatepoint )
    {
        drawoption = getdvarint( @"hash_e58e30094d98d46e", 0 );
        
        if ( drawoption <= 0 )
        {
            return;
        }
        
        if ( drawoption > 1 && getdvarint( @"hash_72c1d25dd9519ff0", 0 ) != self getentitynumber() )
        {
            return;
        }
        
        var_d56d7093903d75cd = 200;
        yellow = ( 1, 1, 0 );
        red = ( 1, 0, 0 );
        green = ( 0, 1, 0 );
        sphere( desiredpoint, 10, yellow, 0, var_d56d7093903d75cd );
        sphere( clippedpoint, 10, red, 0, var_d56d7093903d75cd );
        line( desiredpoint, clippedpoint, yellow, 1, 0, var_d56d7093903d75cd );
        sphere( candidatepoint, 10, green, 0, var_d56d7093903d75cd );
        line( clippedpoint, candidatepoint, green, 1, 0, var_d56d7093903d75cd );
    }

    // Namespace mit_roaming
    // Params 1
    // Checksum 0x5a2a0ddc, Offset: 0x2c05
    // Size: 0x49, Type: dev
    function function_ba0ca1493008e3( stuckpos )
    {
        self notify( #"hash_712325551cd1c325" );
        self endon( #"hash_712325551cd1c325" );
        
        while ( true )
        {
            sphere( stuckpos, 6, ( 1, 0, 0 ), 0, 1 );
            waitframe();
        }
    }

#/
