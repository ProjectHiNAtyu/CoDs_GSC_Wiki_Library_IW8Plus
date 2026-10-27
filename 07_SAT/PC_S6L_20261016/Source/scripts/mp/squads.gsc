// scripts\mp\squads.gsc  (hash_6578cb0a011753f1.gscc) (size: 10928 Bytes / 0x2ab0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa7d3a7a7 (2815666087)
// size ...... 10928 (0x2ab0)
// includes .. 8   (offset: 0x2888)
// strings ... 19  (offset: 0x28c8)
// dev strs .. 16  (offset: 0x29c8)
// exports ... 21  (offset: 0x1d58)
// cseg ...... 0x1f4 + 0x1b64 (0x1d58)
// imports ... 61  (offset: 0x20a0)
// animtree1 . 0   (offset: 0x2ab0)
// animtree2 . 0   (offset: 0x2ab0)
#using script_26ccbfe3954cacf4;
#using script_2b062cc62170d7a8;
#using scripts\common\bots\bots_util;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\flags;

#namespace squads;

// Namespace squads
// Params 0
// Checksum 0xc4b472e2, Offset: 0x212
// Size: 0x151
function init()
{
    level.maxsquadsize = getdvarint( @"party_maxsquadsize", 1 );
    
    if ( level.maxsquadsize && squad_utility::function_1df8c3bebd512a8c() )
    {
        if ( level.maxteamsize <= 0 )
        {
            assertmsg( "<dev string:x24>" + level.maxsquadsize + "<dev string:x4b>" + level.maxteamsize + "<dev string:x51>" );
        }
        
        level.maxsquadsize = level.maxteamsize;
        setdvar( @"party_maxsquadsize", level.maxsquadsize );
    }
    
    if ( game_utility::function_36ce69a7be195555() )
    {
        level.maxsquadsize = 4;
        setdvar( @"party_maxsquadsize", level.maxsquadsize );
    }
    
    level.var_5546a9560c56fa0a = getdvarint( @"hash_588ca000194bdbe1", level.maxsquadsize );
    level.usesquadleader = getdvarint( @"hash_56fe5e64db58eb48", 1 );
    
    /#
        level.var_b99dac3912071e99 = getdvarint( @"hash_6768193fa3f95ba5", 0 ) != 0 ? 1 : undefined;
    #/
    
    level.var_4b6819fa0e2f84d = squad_utility::function_9019b69d85af20ec();
    
    if ( squad_utility::shouldmodesetsquads() )
    {
        initsquaddata();
    }
    
    if ( bots_util::function_deef484b5b3a3977() )
    {
        function_53ad6e8a25bde280( level.maxsquadsize );
    }
}

// Namespace squads
// Params 0
// Checksum 0x4d074b11, Offset: 0x36b
// Size: 0x95
function initsquaddata()
{
    level.squaddata = [];
    
    foreach ( entry in level.teamnamelist )
    {
        level.squaddata[ entry ] = [];
    }
    
    /#
        level thread debugprintsquads();
    #/
}

// Namespace squads
// Params 2
// Checksum 0x4bc0d287, Offset: 0x408
// Size: 0x48b
function setsquad( team, index )
{
    if ( !squad_utility::shouldmodesetsquads() )
    {
        return;
    }
    
    if ( !isdefined( team ) || team == "spectator" || team == "codcaster" )
    {
        return;
    }
    
    /#
        if ( level.var_b99dac3912071e99 && !level.gametypebundle.var_4cb896e680dd00d3 )
        {
            requestnewsquad( team, 0, 0 );
            return;
        }
    #/
    
    if ( level.gametypebundle.var_8d10b76ca727a4f7 || getdvarint( @"scr_assign_squad_from_team", 0 ) )
    {
        teamindex = 0;
        
        foreach ( index, name in level.teamnamelist )
        {
            if ( name == team )
            {
                teamindex = index;
                break;
            }
        }
        
        joinsquad( team, teamindex );
        return;
    }
    
    if ( utility::issharedfuncdefined( #"teamassim", #"hash_53643456c5b72b8f" ) )
    {
        if ( utility::callsharedfunc( #"teamassim", #"hash_53643456c5b72b8f", team, index ) )
        {
            return;
        }
        else
        {
            assertmsg( "<dev string:x69>" );
        }
    }
    
    if ( isbot( self ) && isdefined( self.bot_squad ) )
    {
        var_50e1551de4e653d2 = self.bot_squad != -1;
    }
    else
    {
        var_50e1551de4e653d2 = self.sessionsquadid != -1;
    }
    
    if ( level.matchmakingmatch && var_50e1551de4e653d2 && getdvarint( @"hash_6595c001520e3eec", 0 ) != 1 )
    {
        if ( !isdefined( index ) )
        {
            if ( isbot( self ) && isdefined( self.bot_squad ) )
            {
                index = self.bot_squad;
            }
            else
            {
                index = self.sessionsquadid;
            }
        }
        
        self.squadassignedfromlobby = 1;
        joinsquad( team, index );
        return;
    }
    
    allowsquadfill = 1;
    
    if ( isdefined( level.var_1435a39bf6ab2566 ) )
    {
        allowsquadfill = [[ level.var_1435a39bf6ab2566 ]]( self );
    }
    
    if ( level.matchmakingmatch && getdvarint( @"scr_bypass_fireteam_squads", 0 ) != 1 )
    {
        var_e4e53ce53e45ade5 = istrue( level.var_6788c60cdda51416 );
        fireteammembers = self getfireteammembers();
        
        if ( fireteammembers.size > 0 )
        {
            squadindex = undefined;
            
            foreach ( member in fireteammembers )
            {
                if ( isdefined( member ) && member.sessionsquadid != -1 )
                {
                    squadindex = member.sessionsquadid;
                    break;
                }
            }
            
            if ( isdefined( squadindex ) )
            {
                joinsquad( team, squadindex );
                
                if ( self isfireteamleader() && var_e4e53ce53e45ade5 )
                {
                    data = level.squaddata[ team ][ squadindex ];
                    data.allowfill = allowsquadfill;
                }
                
                return;
            }
        }
        
        if ( self getprivatepartysize() > 1 )
        {
            requestnewsquad( team, 1, var_e4e53ce53e45ade5 );
            return;
        }
    }
    
    foreach ( squad in level.squaddata[ team ] )
    {
        if ( !squad.allowfill )
        {
            continue;
        }
        
        if ( squad.players.size >= level.var_5546a9560c56fa0a )
        {
            continue;
        }
        
        if ( level.matchmakingmatch )
        {
            if ( squad.isfireteam && squad.players[ 0 ] getprivatepartysize() > squad.players.size )
            {
                continue;
            }
        }
        
        joinsquad( team, squad.index );
        return;
    }
    
    requestnewsquad( team, 0, allowsquadfill );
}

// Namespace squads
// Params 2
// Checksum 0xbcb7932d, Offset: 0x89b
// Size: 0x137
function createsquad( team, index )
{
    if ( !isdefined( level.uniquesquadid ) )
    {
        level.uniquesquadid = 0;
    }
    
    if ( !isdefined( index ) )
    {
        index = level.uniquesquadid;
    }
    
    data = spawnstruct();
    data.index = index;
    data.team = team;
    data.isfireteam = 0;
    data.allowfill = 1;
    data.players = [];
    data.squadleader = undefined;
    data.skydivezoneindex = undefined;
    data.properties = [];
    
    if ( !isdefined( level.squaddata[ team ] ) )
    {
        level.squaddata[ team ] = [];
    }
    
    level.squaddata[ team ][ index ] = data;
    
    if ( index >= level.uniquesquadid )
    {
        level.uniquesquadid = index + 1;
    }
    
    if ( getdvarint( @"hash_e1cce0c7778e6dd3", 0 ) )
    {
        logstring( "[SQUAD DEBUG] Squad created. team: " + team + ", Session Squad ID: " + index );
    }
    
    callback::callback( #"squad_created", data );
    return index;
}

// Namespace squads
// Params 2
// Checksum 0xe6200fd5, Offset: 0x9db
// Size: 0x5b
function freesquadindex( team, index )
{
    level.squaddata[ team ][ index ] = undefined;
    
    if ( bots_util::function_deef484b5b3a3977() )
    {
        function_28a2dfb42f7f365d( team, index );
    }
    
    if ( getdvarint( @"hash_e1cce0c7778e6dd3", 0 ) )
    {
        logstring( "[SQUAD DEBUG] Squad freed. team: " + team + ", Session Squad ID: " + index );
    }
}

// Namespace squads
// Params 3
// Checksum 0x83eb3e87, Offset: 0xa3e
// Size: 0xae
function requestnewsquad( team, isfireteam, allowfill )
{
    index = createsquad( team );
    data = level.squaddata[ team ][ index ];
    data.infil = undefined;
    
    if ( isdefined( isfireteam ) )
    {
        data.isfireteam = isfireteam;
    }
    
    if ( isdefined( allowfill ) )
    {
        data.allowfill = allowfill;
    }
    
    if ( bots_util::function_deef484b5b3a3977() )
    {
        botcreatesquad( team, index, data.isfireteam, data.allowfill );
    }
    
    joinsquad( team, index );
}

// Namespace squads
// Params 3
// Checksum 0xcbb2d114, Offset: 0xaf4
// Size: 0x19e
function joinsquad( team, index, uimemberindex = undefined )
{
    assert( isdefined( team ), "<dev string:x117>" );
    assert( isdefined( index ), "<dev string:x132>" );
    
    if ( !isdefined( level.squaddata[ team ][ index ] ) )
    {
        createsquad( team, index );
    }
    
    squad = level.squaddata[ team ][ index ];
    self.sessionsquadid = index;
    self.sessionuimemberindex = function_c67622f2aedab761( team, index, uimemberindex );
    
    if ( !isdefined( squad.players ) )
    {
        squad.players = [];
    }
    
    squad.players[ squad.players.size ] = self;
    
    if ( isdefined( self.sessionuimemberindex ) && bots_util::function_deef484b5b3a3977() )
    {
        function_113d685974b8b7f7( team, index, self );
    }
    
    choosesquadleader( team, index );
    
    if ( getdvarint( @"hash_e1cce0c7778e6dd3", 0 ) )
    {
        logstring( "[SQUAD DEBUG] Player joined squad. Player: " + self.name + ", Session Squad ID: " + self.sessionsquadid + ", Session UI Member Index: " + self.sessionuimemberindex );
    }
    
    namespace_9fd3ecf626067599::onplayerjoinsquad( self );
    callback::callback( #"hash_cc06eb1d45f33a0c", { #memberindex:self.sessionuimemberindex, #index:self.sessionsquadid, #team:team, #squad:squad } );
    self notify( #"joined_squad" );
}

// Namespace squads
// Params 2
// Checksum 0x8ae3c42c, Offset: 0xc9a
// Size: 0x380
function leavesquad( team, index )
{
    if ( !squad_utility::shouldmodesetsquads() )
    {
        return;
    }
    
    if ( !isdefined( team ) || team == "spectator" || team == "codcaster" || !( isdefined( index ) && isdefined( level.squaddata ) ) )
    {
        return;
    }
    
    assert( isdefined( level.squaddata[ team ][ index ] ), "<dev string:x14e>" );
    
    if ( !isdefined( level.squaddata[ team ][ index ] ) )
    {
        return;
    }
    
    if ( !arraycontains( level.squaddata[ team ][ index ].players, self ) )
    {
        return;
    }
    
    if ( bots_util::function_deef484b5b3a3977() )
    {
        function_3201b14d5a99ab30( team, index, self );
    }
    
    self notify( #"left_squad" );
    
    if ( level.squaddata[ team ][ index ].players.size == 1 && !manager::function_4dfbc17508653434( team, index ) )
    {
        freesquadindex( team, index );
        callback::callback( #"player_leave_squad", { #memberindex:self.sessionuimemberindex, #index:index, #team:team } );
        return;
    }
    
    if ( getdvarint( @"hash_e1cce0c7778e6dd3", 0 ) )
    {
        logstring( "[SQUAD DEBUG] PLayer leaving squad. Player: " + self.name + ", Session Squad ID: " + index + ", Session UI Member Index: " + self.sessionuimemberindex );
    }
    
    self.var_64f4581741c21af7 = self.sessionuimemberindex;
    self.sessionuimemberindex = -1;
    var_c2355e23a8e977cc = 0;
    squadleader = squad_utility::getsquadleader( team, index );
    
    if ( level.usesquadleader && squadleader == self )
    {
        level.squaddata[ team ][ index ].squadleader = undefined;
        var_c2355e23a8e977cc = 1;
        
        foreach ( player in level.squaddata[ team ][ index ].players )
        {
            player setclientomnvar( "ui_squad_leader", undefined );
        }
    }
    
    namespace_9fd3ecf626067599::function_3efb30390246d5d1( self );
    callback::callback( #"player_leave_squad", { #memberindex:self.var_64f4581741c21af7, #index:index, #team:team } );
    level.squaddata[ team ][ index ].players = arrayremove( level.squaddata[ team ][ index ].players, self );
    
    if ( var_c2355e23a8e977cc )
    {
        squadmembers = arrayrandomize( level.squaddata[ team ][ index ].players );
        
        foreach ( player in squadmembers )
        {
            if ( isdefined( player ) )
            {
                player choosesquadleader( team, index );
                break;
            }
        }
    }
}

// Namespace squads
// Params 0
// Checksum 0xa6cfb6dc, Offset: 0x1022
// Size: 0x7e
function function_bbd7c5f24d46f0c4()
{
    if ( utility::issharedfuncdefined( #"teamassim", #"isenabled" ) && [[ utility::getsharedfunc( #"teamassim", #"isenabled" ) ]]() )
    {
        if ( utility::issharedfuncdefined( #"teamassim", #"getmaxassimilationteamsize" ) )
        {
            return [[ utility::getsharedfunc( #"teamassim", #"getmaxassimilationteamsize" ) ]]();
        }
        
        return;
    }
    
    return level.maxsquadsize;
}

// Namespace squads
// Params 3
// Checksum 0x322305a3, Offset: 0x10a8
// Size: 0x18c
function function_c67622f2aedab761( team, index, uimemberindex = undefined )
{
    availableindices = [];
    
    for ( i = 0; i < function_bbd7c5f24d46f0c4() ; i++ )
    {
        availableindices[ i ] = 1;
    }
    
    assignedcount = 0;
    
    foreach ( player in level.squaddata[ team ][ index ].players )
    {
        if ( player.sessionuimemberindex >= 0 )
        {
            availableindices[ player.sessionuimemberindex ] = 0;
            assignedcount++;
        }
    }
    
    if ( availableindices[ uimemberindex ] )
    {
        return uimemberindex;
    }
    
    foreach ( index, isavailable in availableindices )
    {
        if ( isavailable )
        {
            return index;
        }
    }
    
    assertmsg( "<dev string:x171>" + availableindices.size + "<dev string:x1c0>" + assignedcount );
}

// Namespace squads
// Params 3
// Checksum 0x45b619f2, Offset: 0x123d
// Size: 0x4a
function changesquad( team, oldteam, index )
{
    if ( self.sessionsquadid == index )
    {
        return;
    }
    
    leavesquad( oldteam, self.sessionsquadid );
    joinsquad( team, index );
}

// Namespace squads
// Params 2
// Checksum 0x340a7c3, Offset: 0x128f
// Size: 0x2c3
function updatesquadomnvars( team, squadindex )
{
    if ( !squad_utility::shouldmodesetsquads() || !isdefined( level.squaddata ) )
    {
        return;
    }
    
    squadleader = squad_utility::getsquadleader( team, squadindex );
    
    foreach ( player in level.squaddata[ team ][ squadindex ].players )
    {
        var_f3c45eaf798c26a8 = squadindex;
        var_f3c45eaf798c26a8 += level.squaddata[ team ][ squadindex ].players.size << 5;
        
        if ( squadleader == player )
        {
            var_f3c45eaf798c26a8 += 256;
        }
        
        if ( level.var_4e89c723992b4c6a )
        {
            continue;
        }
        
        player setclientomnvar( "ui_squad_data", var_f3c45eaf798c26a8 );
        
        if ( level.gametype == "arm" || level.gametype == "conflict" || level.gametype == "arena" || level.gametype == "brtdm" || level.gametype == "fireteam" )
        {
            var_741da53773cce663 = player.game_extrainfo & 65528;
            player.game_extrainfo = var_741da53773cce663 | player.sessionuimemberindex + 1;
            
            if ( squadleader == player )
            {
                player.game_extrainfo |= 16384;
            }
            else
            {
                player.game_extrainfo &= ~16384;
            }
            
            squadmatemask = player getentitynumber();
            
            if ( squadleader == player )
            {
                squadmatemask += 2048;
            }
            
            if ( isalive( player ) )
            {
                squadmatemask += 4096;
            }
            
            player setclientomnvar( "ui_arm_squadmember_0", squadmatemask );
            mates = arrayremove( level.squaddata[ team ][ squadindex ].players, player );
            
            for ( i = 0; i < 3 ; i++ )
            {
                mate = mates[ i ];
                
                if ( isdefined( mate ) )
                {
                    squadmatemask = mate getentitynumber();
                    
                    if ( squadleader == mate )
                    {
                        squadmatemask += 2048;
                    }
                    
                    if ( isalive( mate ) )
                    {
                        squadmatemask += 4096;
                    }
                }
                else
                {
                    squadmatemask = -1;
                }
                
                player setclientomnvar( "ui_arm_squadmember_" + i + 1, squadmatemask );
            }
        }
    }
}

// Namespace squads
// Params 0
// Checksum 0x52712a4, Offset: 0x155a
// Size: 0x10, Type: bool
function function_69cf2efe88610e4f()
{
    return isbrgamemode() || game_utility::function_ece5a05594bcd651();
}

// Namespace squads
// Params 1
// Checksum 0xaaebc135, Offset: 0x1573
// Size: 0x35, Type: bool
function isvalidplayer( player )
{
    if ( game_utility::function_ece5a05594bcd651() )
    {
        return ( player && ( !flags::gameflag( "prematch_done" ) || isalive( player ) ) );
    }
    
    return isdefined( player );
}

// Namespace squads
// Params 2
// Checksum 0x1c624922, Offset: 0x15b1
// Size: 0x242
function choosesquadleader( team, index )
{
    if ( !level.usesquadleader )
    {
        return;
    }
    
    ispartyleader = 0;
    
    if ( level.matchmakingmatch )
    {
        fireteammembers = self getfireteammembers();
        
        if ( fireteammembers.size > 0 )
        {
            ispartyleader = self isfireteamleader();
        }
    }
    
    candidate = self;
    currentleader = squad_utility::getsquadleader( team, index );
    
    if ( !ispartyleader )
    {
        if ( function_69cf2efe88610e4f() )
        {
            if ( isvalidplayer( currentleader ) && !isai( currentleader ) )
            {
                return;
            }
            
            if ( isai( candidate ) )
            {
                var_7229579e321d0c56 = 0;
                
                foreach ( player in level.squaddata[ team ][ index ].players )
                {
                    if ( !isvalidplayer( player ) )
                    {
                        continue;
                    }
                    
                    if ( !isai( player ) || game_utility::function_ece5a05594bcd651() && isautopilot( player ) )
                    {
                        candidate = player;
                        var_7229579e321d0c56 = 1;
                        
                        if ( !isai( player ) )
                        {
                            break;
                        }
                    }
                }
                
                if ( !var_7229579e321d0c56 && isvalidplayer( currentleader ) )
                {
                    return;
                }
            }
        }
        else if ( isvalidplayer( currentleader ) )
        {
            return;
        }
    }
    
    level.squaddata[ team ][ index ].squadleader = candidate;
    
    if ( bots_util::function_deef484b5b3a3977() )
    {
        function_1ed30c5a51142384( team, index, candidate );
    }
    
    foreach ( player in level.squaddata[ team ][ index ].players )
    {
        player setclientomnvar( "ui_squad_leader", candidate );
    }
}

/#

    // Namespace squads
    // Params 0
    // Checksum 0xea355358, Offset: 0x17fb
    // Size: 0x2a1, Type: dev
    function debugprintsquads()
    {
        stepy = 25;
        
        while ( true )
        {
            if ( getdvarint( @"scr_debug_squads", 0 ) == 1 && isdefined( level.squaddata ) )
            {
                startx = 800;
                starty = 25;
                linecount = 1;
                printtoscreen2d( startx, starty, "<dev string:x1d3>", ( 1, 1, 1 ), 1 );
                
                foreach ( team, squadarray in level.squaddata )
                {
                    linecount = 1;
                    printtoscreen2d( startx, starty + stepy * linecount, "<dev string:x1de>" + team, ( 1, 1, 1 ), 1 );
                    linecount++;
                    
                    foreach ( squad in squadarray )
                    {
                        color = ( 1, 1, 1 );
                        
                        if ( isdefined( squad.activemission ) )
                        {
                            color = ( 1, 1, 0 );
                        }
                        
                        printtoscreen2d( startx + 25, starty + stepy * linecount, "<dev string:x1e5>" + squad.index, color, 1 );
                        linecount++;
                        
                        foreach ( player in squad.players )
                        {
                            color = ( 1, 1, 1 );
                            
                            if ( player.squadassignedfromlobby )
                            {
                                color = ( 0, 1, 0 );
                            }
                            
                            printtoscreen2d( startx + 50, starty + stepy * linecount, player.name, color, 1 );
                            linecount++;
                        }
                    }
                    
                    startx += 200;
                }
            }
            
            waitframe();
        }
    }

#/

// Namespace squads
// Params 3
// Checksum 0xd481ad7, Offset: 0x1aa4
// Size: 0xcd
function getsquaddata( team, sessionsquadid, property )
{
    assert( isdefined( level.squaddata[ team ][ sessionsquadid ] ), "<dev string:x1ed>" + team + "<dev string:x208>" + sessionsquadid + "<dev string:x20b>" );
    assert( function_eee6396d37a87f96( team, sessionsquadid, property ), "<dev string:x1ed>" + team + "<dev string:x208>" + sessionsquadid + "<dev string:x208>" + property + "<dev string:x20b>" );
    
    if ( isdefined( level.squaddata[ team ][ sessionsquadid ] ) && isdefined( level.squaddata[ team ][ sessionsquadid ].properties[ property ] ) )
    {
        return level.squaddata[ team ][ sessionsquadid ].properties[ property ];
    }
    
    return;
}

// Namespace squads
// Params 4
// Checksum 0x7062b0be, Offset: 0x1b79
// Size: 0x82
function function_9f63a83550fcfd48( team, sessionsquadid, property, value )
{
    assert( isdefined( level.squaddata[ team ][ sessionsquadid ] ), "<dev string:x1ed>" + team + "<dev string:x208>" + sessionsquadid + "<dev string:x20b>" );
    assert( isdefined( value ), "<dev string:x20d>" );
    level.squaddata[ team ][ sessionsquadid ].properties[ property ] = value;
}

// Namespace squads
// Params 3
// Checksum 0x8699122f, Offset: 0x1c03
// Size: 0x86, Type: bool
function function_eee6396d37a87f96( team, sessionsquadid, property )
{
    assert( isdefined( level.squaddata[ team ][ sessionsquadid ] ), "<dev string:x1ed>" + team + "<dev string:x208>" + sessionsquadid + "<dev string:x20b>" );
    
    if ( !isdefined( level.squaddata[ team ][ sessionsquadid ].properties ) )
    {
        return false;
    }
    
    return isdefined( level.squaddata[ team ][ sessionsquadid ].properties[ property ] );
}

// Namespace squads
// Params 0
// Checksum 0x920f61d8, Offset: 0x1c92
// Size: 0xc5
function function_53d0f06555f0036b()
{
    squadmemberindex = self.sessionuimemberindex;
    
    if ( !( isdefined( squadmemberindex ) && isdefined( self.team ) ) || self.isdisconnecting || squadmemberindex >= level.maxsquadsize )
    {
        squadmemberindex = undefined;
    }
    
    squadmates = level.teamdata[ self.team ][ "players" ];
    
    if ( isdefined( level.squaddata[ self.team ][ self.sessionsquadid ] ) )
    {
        squadmates = level.squaddata[ self.team ][ self.sessionsquadid ].players;
    }
    
    return [ squadmemberindex, squadmates ];
}

