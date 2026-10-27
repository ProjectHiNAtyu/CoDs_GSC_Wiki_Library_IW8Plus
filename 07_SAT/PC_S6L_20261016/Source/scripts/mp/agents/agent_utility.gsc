// scripts\mp\agents\agent_utility.gsc  (hash_2df9d011999f18c5.gscc) (size: 6884 Bytes / 0x1ae4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa95d4a6a (2841463402)
// size ...... 6884 (0x1ae4)
// includes .. 6   (offset: 0x197c)
// strings ... 21  (offset: 0x19ac)
// dev strs .. 1   (offset: 0x1ad8)
// exports ... 24  (offset: 0x1118)
// cseg ...... 0x13f + 0xfd9 (0x1118)
// imports ... 39  (offset: 0x14d8)
// animtree1 . 0   (offset: 0x1ae4)
// animtree2 . 0   (offset: 0x1ae4)
#using scripts\common\game_utility;
#using scripts\common\values;
#using scripts\mp\common\utility\player;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\common;
#using scripts\mp\spawnlogic;

#namespace agent_utility;

// Namespace agent_utility
// Params 1
// Checksum 0x7516f719, Offset: 0x15d
// Size: 0xc5
function agentfunc( func_name )
{
    assert( isagent( self ) );
    assert( isdefined( func_name ) );
    assert( isdefined( self.agent_type ) );
    assert( isdefined( level.agent_funcs[ self.agent_type ] ) );
    assert( isdefined( level.agent_funcs[ self.agent_type ][ func_name ] ) );
    
    if ( isdefined( self.unittype ) && isdefined( level.agent_funcs[ self.unittype ][ func_name ] ) )
    {
        return level.agent_funcs[ self.unittype ][ func_name ];
    }
    
    return level.agent_funcs[ self.agent_type ][ func_name ];
}

// Namespace agent_utility
// Params 1
// Checksum 0x1fad6992, Offset: 0x22b
// Size: 0x52
function function_1d67c3e48637c5d6( func_name )
{
    assert( isdefined( func_name ) );
    
    if ( isdefined( level.lw_agent_funcs[ "player" ][ func_name ] ) )
    {
        return level.lw_agent_funcs[ "player" ][ func_name ];
    }
    
    return level.lw_agent_funcs[ "player" ][ func_name ];
}

// Namespace agent_utility
// Params 2
// Checksum 0x76faddf2, Offset: 0x286
// Size: 0x58
function set_agent_team( team, optional_owner )
{
    self.team = team;
    self.agentteam = team;
    self.pers[ "team" ] = team;
    self.owner = optional_owner;
    self setotherent( optional_owner );
    self setentityowner( optional_owner );
}

// Namespace agent_utility
// Params 0
// Checksum 0x23270a3b, Offset: 0x2e6
// Size: 0xa4
function initagentscriptvariables()
{
    self.agent_type = "player";
    self.pers = [];
    self.hasdied = 0;
    self.isactive = 0;
    self.isagent = 1;
    self.wasti = 0;
    self.entity_number = self getentitynumber();
    self.agent_teamparticipant = 0;
    self.agent_gameparticipant = 0;
    self.agentname = undefined;
    self.ignoreall = istrue( level.var_df336712f37ebfc0 );
    self.ignoreme = 0;
    self detachall();
    self.headmodel = undefined;
    initplayerscriptvariables( 0 );
}

// Namespace agent_utility
// Params 1
// Checksum 0x79d3c295, Offset: 0x392
// Size: 0x1a2
function initplayerscriptvariables( asplayer )
{
    if ( !asplayer )
    {
        self.class = undefined;
        self.lastclass = undefined;
        self.movespeedscaler = undefined;
        self.avoidkillstreakonspawntimer = undefined;
        self.guid = undefined;
        self.name = undefined;
        self.perks = undefined;
        self.weaponlist = undefined;
        self.objectivescaler = undefined;
        self.touchtriggers = undefined;
        self.carryobject = undefined;
        self.canpickupobject = undefined;
        self.sessionteam = undefined;
        self.sessionstate = undefined;
        self.lastspawntime = undefined;
        self.lastspawnpoint = undefined;
        val::nuke( "weapon" );
        val::nuke( "weapon_switch" );
        val::nuke( "offhand_weapons" );
        val::nuke( "usability" );
        self.shieldbullethits = undefined;
        self.recentshieldxp = undefined;
        return;
    }
    
    self.movespeedscaler = 1;
    
    if ( common::function_8ff835bf23198a0( "moveSpeedScaler" ) )
    {
        common::function_d85a92c557ea5a52( "moveSpeedScaler" );
    }
    
    self.avoidkillstreakonspawntimer = level.spawnprotectiontimer;
    self.guid = player::getuniqueid();
    self.name = self.guid;
    self.sessionteam = self.team;
    self.sessionstate = "playing";
    self.shieldbullethits = 0;
    self.recentshieldxp = 0;
    self.agent_gameparticipant = 1;
    self.objectivescaler = 1;
    gameobjects::init_player_gameobjects();
}

// Namespace agent_utility
// Params 0
// Checksum 0x7d198365, Offset: 0x53c
// Size: 0x38
function activateagent()
{
    /#
        if ( !self.isactive )
        {
            assert( self.connecttime == gettime(), "<dev string:x24>" );
        }
    #/
    
    self.isactive = 1;
}

// Namespace agent_utility
// Params 0
// Checksum 0x570c5080, Offset: 0x57c
// Size: 0x9
function deactivateagent()
{
    thread deactivateagentdelayed();
}

// Namespace agent_utility
// Params 0
// Checksum 0xc4f3d518, Offset: 0x58d
// Size: 0x196
function deactivateagentdelayed()
{
    self notify( #"hash_d0d9ad4b9d87f60e" );
    self endon( #"hash_d0d9ad4b9d87f60e" );
    
    if ( game_utility_common::isgameparticipant( self ) )
    {
        game_utility_common::removefromparticipantsarray();
    }
    
    game_utility_common::removefromcharactersarray();
    wait 0.05;
    self.isactive = 0;
    self.hasdied = 0;
    self.owner = undefined;
    self.connecttime = undefined;
    
    foreach ( character in level.characters )
    {
        if ( isdefined( character.attackers ) )
        {
            foreach ( index, attacker in character.attackers )
            {
                if ( attacker == self )
                {
                    character.attackers[ index ] = undefined;
                }
            }
        }
    }
    
    if ( isdefined( self.headmodel ) )
    {
        self detach( self.headmodel );
        self.headmodel = undefined;
    }
    
    self notify( #"disconnect" );
}

// Namespace agent_utility
// Params 1
// Checksum 0xcdb4b8b7, Offset: 0x72b
// Size: 0x2f
function getnumactiveagents( type = "all" )
{
    agents = getactiveagentsoftype( type );
    return agents.size;
}

// Namespace agent_utility
// Params 1
// Checksum 0x32dfffa7, Offset: 0x763
// Size: 0xfb
function getactiveagentsoftype( type )
{
    assert( isdefined( type ) );
    agents = [];
    
    if ( !isdefined( level.agentarray ) )
    {
        return agents;
    }
    
    foreach ( agent in level.agentarray )
    {
        if ( agent.isactive )
        {
            if ( type == "all" || agent.agent_type == type || agent.subclass == type || agent.type == type )
            {
                agents[ agents.size ] = agent;
            }
        }
    }
    
    return agents;
}

// Namespace agent_utility
// Params 1
// Checksum 0x919f7cce, Offset: 0x867
// Size: 0x19
function getnumownedactiveagents( player )
{
    return getnumownedactiveagentsbytype( player, "all" );
}

// Namespace agent_utility
// Params 2
// Checksum 0xaaf0b053, Offset: 0x889
// Size: 0x102
function getnumownedactiveagentsbytype( player, type )
{
    assert( isdefined( type ) );
    numownedactiveagents = 0;
    
    if ( !isdefined( level.agentarray ) )
    {
        return numownedactiveagents;
    }
    
    foreach ( agent in level.agentarray )
    {
        if ( agent.isactive )
        {
            if ( agent.owner == player )
            {
                if ( type == "all" && agent.agent_type != "alien" || agent.agent_type == type )
                {
                    numownedactiveagents++;
                }
            }
        }
    }
    
    return numownedactiveagents;
}

// Namespace agent_utility
// Params 2
// Checksum 0xaa23a6d5, Offset: 0x994
// Size: 0x108
function getnumownedagentsonteambytype( team, type )
{
    assert( isdefined( team ) && isdefined( type ) );
    numownedactiveagents = 0;
    
    if ( !isdefined( level.agentarray ) )
    {
        return numownedactiveagents;
    }
    
    foreach ( agent in level.agentarray )
    {
        if ( agent.isactive )
        {
            if ( agent.team == team )
            {
                if ( type == "all" && agent.agent_type != "alien" || agent.agent_type == type )
                {
                    numownedactiveagents++;
                }
            }
        }
    }
    
    return numownedactiveagents;
}

// Namespace agent_utility
// Params 2
// Checksum 0x73c74faf, Offset: 0xaa5
// Size: 0x393
function getvalidspawnpathnodenearplayer( var_503e0e32b4b7bd4f, var_ce7f334c87ea1444 )
{
    assert( isplayer( self ) );
    nodearray = getnodesinradius( self.origin, 350, 64, 128, "Path" );
    
    if ( !isdefined( nodearray ) || nodearray.size == 0 )
    {
        return;
    }
    
    if ( isdefined( level.waterdeletez ) && isdefined( level.trigunderwater ) )
    {
        var_bac2304f5225d4c8 = nodearray;
        nodearray = [];
        
        foreach ( node in var_bac2304f5225d4c8 )
        {
            if ( node.origin[ 2 ] > level.waterdeletez || !ispointinvolume( node.origin, level.trigunderwater ) )
            {
                nodearray[ nodearray.size ] = node;
            }
        }
    }
    
    playerdirection = anglestoforward( self.angles );
    bestdot = -10;
    playerheight = spawnlogic::getplayertraceheight( self );
    zoffset = ( 0, 0, playerheight );
    
    if ( !isdefined( var_503e0e32b4b7bd4f ) )
    {
        var_503e0e32b4b7bd4f = 0;
    }
    
    if ( !isdefined( var_ce7f334c87ea1444 ) )
    {
        var_ce7f334c87ea1444 = 0;
    }
    
    var_6cf435845c89e428 = [];
    var_817982811baae1e = [];
    
    foreach ( pathnode in nodearray )
    {
        if ( !pathnode doesnodeallowstance( "stand" ) || isdefined( pathnode.no_agent_spawn ) )
        {
            continue;
        }
        
        var_16ed23c977a1370a = vectornormalize( pathnode.origin - self.origin );
        dot = vectordot( playerdirection, var_16ed23c977a1370a );
        
        for ( i = 0; i < var_817982811baae1e.size ; i++ )
        {
            if ( dot > var_817982811baae1e[ i ] )
            {
                for ( j = var_817982811baae1e.size; j > i ; j-- )
                {
                    var_817982811baae1e[ j ] = var_817982811baae1e[ j - 1 ];
                    var_6cf435845c89e428[ j ] = var_6cf435845c89e428[ j - 1 ];
                }
                
                break;
            }
        }
        
        var_6cf435845c89e428[ i ] = pathnode;
        var_817982811baae1e[ i ] = dot;
    }
    
    for ( i = 0; i < var_6cf435845c89e428.size ; i++ )
    {
        pathnode = var_6cf435845c89e428[ i ];
        tracestart = self.origin + zoffset;
        traceend = pathnode.origin + zoffset;
        
        if ( i > 0 )
        {
            wait 0.05;
        }
        
        if ( !sighttracepassed( tracestart, traceend, 0, self ) )
        {
            continue;
        }
        
        if ( var_ce7f334c87ea1444 )
        {
            if ( i > 0 )
            {
                wait 0.05;
            }
            
            hitpos = playerphysicstrace( pathnode.origin + zoffset, pathnode.origin );
            
            if ( distancesquared( hitpos, pathnode.origin ) > 1 )
            {
                continue;
            }
        }
        
        if ( var_503e0e32b4b7bd4f )
        {
            if ( i > 0 )
            {
                wait 0.05;
            }
            
            hitpos = physicstrace( tracestart, traceend );
            
            if ( distancesquared( hitpos, traceend ) > 1 )
            {
                continue;
            }
        }
        
        return pathnode;
    }
}

// Namespace agent_utility
// Params 0
// Checksum 0x3b4d0af4, Offset: 0xe40
// Size: 0x8d
function function_305eb563bc53733d()
{
    if ( self getstance() == "crouch" )
    {
        center = self.origin + 0.5 * ( 0, 0, 50 );
    }
    else if ( self getstance() == "prone" )
    {
        center = self.origin + 0.5 * ( 0, 0, 48 );
    }
    else
    {
        center = self.origin + 0.5 * ( 0, 0, 72 );
    }
    
    return center;
}

// Namespace agent_utility
// Params 0
// Checksum 0xc0c1c2, Offset: 0xed6
// Size: 0x7b
function function_fa6ba9e10b560337()
{
    if ( self getstance() == "crouch" )
    {
        center = self.origin + ( 0, 0, 50 );
    }
    else if ( self getstance() == "prone" )
    {
        center = self.origin + ( 0, 0, 48 );
    }
    else
    {
        center = self.origin + ( 0, 0, 72 );
    }
    
    return center;
}

// Namespace agent_utility
// Params 1
// Checksum 0x9dae703d, Offset: 0xf5a
// Size: 0x54
function killagent( agent )
{
    for ( giveup = 5; isalive( agent ) && giveup > 0 ; giveup-- )
    {
        agent dodamage( agent.health + 5000000, agent.origin );
    }
}

// Namespace agent_utility
// Params 0
// Checksum 0x279230a, Offset: 0xfb6
// Size: 0x4a
function killdog()
{
    self [[ agentfunc( "on_damaged" ) ]]( level, undefined, self.health + 1, 0, "MOD_CRUSH", "none", ( 0, 0, 0 ), ( 0, 0, 0 ), "none", 0 );
}

// Namespace agent_utility
// Params 1
// Checksum 0x19d90758, Offset: 0x1008
// Size: 0x18, Type: bool
function isspecifiedunittype( unittype )
{
    return self.unittype == unittype;
}

// Namespace agent_utility
// Params 1
// Checksum 0x40d5ca34, Offset: 0x1029
// Size: 0x2b, Type: bool
function iscivilian( agent )
{
    budgettype = agent.category;
    return budgettype == "civilian";
}

// Namespace agent_utility
// Params 1
// Checksum 0x2920089d, Offset: 0x105d
// Size: 0x38
function function_9ebab4dc1b64e765( agent )
{
    if ( !( isdefined( agent ) && isdefined( agent.agent_type ) ) )
    {
        return 0;
    }
    
    return issubstr( agent.agent_type, "_merc" );
}

// Namespace agent_utility
// Params 1
// Checksum 0xef57888b, Offset: 0x109e
// Size: 0x38
function iskonni( agent )
{
    if ( !( isdefined( agent ) && isdefined( agent.agent_type ) ) )
    {
        return 0;
    }
    
    return issubstr( agent.agent_type, "_ru" );
}

// Namespace agent_utility
// Params 1
// Checksum 0x8c4c8938, Offset: 0x10df
// Size: 0x38
function istier3( agent )
{
    if ( !( isdefined( agent ) && isdefined( agent.agent_type ) ) )
    {
        return 0;
    }
    
    return issubstr( agent.agent_type, "tier3" );
}

