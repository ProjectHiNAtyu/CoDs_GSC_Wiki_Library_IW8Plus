// script_730ee2ef1439bea7  (hash_730ee2ef1439bea7.gscc) (size: 11534 Bytes / 0x2d0e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x53e1a89d (1407297693)
// size ...... 11534 (0x2d0e)
// includes .. 9   (offset: 0x2b12)
// strings ... 29  (offset: 0x2b5a)
// dev strs .. 0   (offset: 0x2d0e)
// exports ... 23  (offset: 0x1f86)
// cseg ...... 0x23e + 0x1d48 (0x1f86)
// imports ... 62  (offset: 0x231e)
// animtree1 . 0   (offset: 0x2d0e)
// animtree2 . 0   (offset: 0x2d0e)
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_reinforcements;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\common\utility\player;
#using scripts\mp\dmz\gametypes\dmz_audio;
#using scripts\mp\dmz\gametypes\dmz_bounty;

#namespace dmz_ai_hunt_squad;

// Namespace dmz_ai_hunt_squad
// Params 0
// Checksum 0x4f5c74b2, Offset: 0x25c
// Size: 0x1b1
function hsquad_init()
{
    if ( getdvarint( @"hash_6e8e023ec4104c6b", 1 ) == 0 )
    {
        return;
    }
    
    level.huntsquads = spawnstruct();
    level.huntsquads.watchedteams = [];
    level.huntsquads.huntedteams = [];
    level.huntsquads.squads = [];
    level.huntsquads.var_cf06763ee71ce31a = 36000000;
    level.huntsquads.activationscore = getdvarint( @"hash_5a55c9e713f5a065", 4 );
    level.huntsquads.var_69b7fddaec50062a = getdvarint( @"hash_ea5ca0afeab8e384", 3 );
    level.huntsquads.var_577f8f2b6a330f68 = getdvarint( @"hash_8dfdc1bd2a887ac2", 6 );
    level.huntsquads.var_535e9baf2486a441 = getdvarint( @"hash_cb63f8cb9e4e1def", 300 ) * 1000;
    level.huntsquads.var_5bd5cdf78beb4ca7 = getdvarint( @"hash_b5d7e9e85ab3c104", 3 );
    level.huntsquads.var_e5d652661b989bf3 = getdvarint( @"hash_2b11b9aca19ce8cb", 500 );
    level.huntsquads.var_3347fe649d5bafb = getdvarint( @"hash_21134403816f9c13", 3000 );
    level.huntsquads.var_f872edeae3d189f2 = getdvarint( @"hash_af4ffd6ef7ff488c", 8000 );
    level waittill( #"matchstarttimer_done" );
    level thread function_432aaef0faee2aa0();
}

// Namespace dmz_ai_hunt_squad
// Params 0
// Checksum 0xa2085a63, Offset: 0x415
// Size: 0x5a9
function function_432aaef0faee2aa0()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( teamname, team in level.teamdata )
        {
            if ( team[ "players" ].size >= level.huntsquads.var_5bd5cdf78beb4ca7 )
            {
                if ( !arraycontains( level.huntsquads.watchedteams, teamname ) )
                {
                    level.huntsquads.watchedteams[ level.huntsquads.watchedteams.size ] = teamname;
                }
                
                continue;
            }
            
            if ( arraycontains( level.huntsquads.watchedteams, teamname ) )
            {
                level.huntsquads.watchedteams = arrayremove( level.huntsquads.watchedteams, teamname );
            }
        }
        
        foreach ( teamname in level.huntsquads.watchedteams )
        {
            var_91af1afa7a6add96 = 0;
            
            foreach ( player in level.teamdata[ teamname ][ "players" ] )
            {
                var_e1eed2b1f42d40be = dmz_bounty::function_66fcbf6381df44de( player );
                var_91af1afa7a6add96 += var_e1eed2b1f42d40be;
            }
            
            var_cf794f5107130a41 = var_91af1afa7a6add96 / level.teamdata[ teamname ][ "players" ].size;
            
            if ( var_cf794f5107130a41 > level.huntsquads.activationscore && !arraycontains( level.huntsquads.huntedteams, teamname ) )
            {
                level.huntsquads.huntedteams[ level.huntsquads.huntedteams.size ] = teamname;
            }
        }
        
        foreach ( teamname in level.huntsquads.huntedteams )
        {
            if ( !isdefined( level.huntsquads.squads[ teamname ] ) || isdefined( level.huntsquads.squads[ teamname ] ) && level.huntsquads.squads[ teamname ].agents.size == 0 && level.huntsquads.squads[ teamname ].lastendtime + level.huntsquads.var_535e9baf2486a441 < gettime() )
            {
                [ agents, targetplayer ] = hsquad_spawn( teamname );
                
                if ( agents.size > 0 )
                {
                    var_4c3ca46d62c3e12 = spawnstruct();
                    var_4c3ca46d62c3e12.agents = agents;
                    var_4c3ca46d62c3e12.lastspawntime = gettime();
                    var_4c3ca46d62c3e12.lastendtime = undefined;
                    var_4c3ca46d62c3e12.targetplayer = targetplayer;
                    var_4c3ca46d62c3e12.huntedteam = teamname;
                    var_4c3ca46d62c3e12.var_11ba9afe34d485db = gettime() + getdvarint( @"hash_8f091e5825453d52", 300 ) * 1000;
                    var_4c3ca46d62c3e12.endhunt = 0;
                    task = spawnstruct();
                    task.taskended = 0;
                    task.targetteam = teamname;
                    var_4c3ca46d62c3e12.task = task;
                    level.huntsquads.squads[ teamname ] = var_4c3ca46d62c3e12;
                    level thread function_801641805e4141e4( var_4c3ca46d62c3e12 );
                    level thread function_9c49149ea9671153( var_4c3ca46d62c3e12 );
                    function_b073f6f9587a6d98( var_4c3ca46d62c3e12 );
                    level thread function_769474ce08b22657( var_4c3ca46d62c3e12 );
                }
            }
        }
        
        foreach ( teamname, var_4c3ca46d62c3e12 in level.huntsquads.squads )
        {
            if ( var_4c3ca46d62c3e12.agents.size == 0 )
            {
                level.huntsquads.huntedteams = arrayremove( level.huntsquads.huntedteams, teamname );
            }
        }
        
        wait 5;
    }
}

// Namespace dmz_ai_hunt_squad
// Params 1
// Checksum 0x2fb0c7bc, Offset: 0x9c6
// Size: 0x5f
function function_769474ce08b22657( var_4c3ca46d62c3e12 )
{
    level endon( #"game_ended" );
    continuetracking = 1;
    
    while ( continuetracking )
    {
        if ( var_4c3ca46d62c3e12.endhunt )
        {
            return;
        }
        
        if ( gettime() >= var_4c3ca46d62c3e12.var_11ba9afe34d485db )
        {
            break;
        }
        
        wait 1;
    }
    
    function_55dd289e94cccd( var_4c3ca46d62c3e12 );
}

// Namespace dmz_ai_hunt_squad
// Params 1
// Checksum 0x690cf2a, Offset: 0xa2d
// Size: 0x89
function function_9c49149ea9671153( var_4c3ca46d62c3e12 )
{
    foreach ( agent in var_4c3ca46d62c3e12.agents )
    {
        level thread function_81cb190f54a20164( agent, var_4c3ca46d62c3e12 );
    }
}

// Namespace dmz_ai_hunt_squad
// Params 1
// Checksum 0x3bd6878e, Offset: 0xabe
// Size: 0xe6
function function_64afd4366be6d24b( var_4c3ca46d62c3e12 )
{
    level endon( #"game_ended" );
    var_577ec20ab2677ab6 = 1;
    
    while ( var_577ec20ab2677ab6 )
    {
        if ( var_4c3ca46d62c3e12.endhunt )
        {
            return;
        }
        
        players = level.teamdata[ var_4c3ca46d62c3e12.huntedteam ][ "players" ];
        var_577ec20ab2677ab6 = 0;
        
        foreach ( player in players )
        {
            if ( isalive( player ) )
            {
                var_577ec20ab2677ab6 = 1;
                break;
            }
        }
        
        waitframe();
    }
    
    function_55dd289e94cccd( var_4c3ca46d62c3e12 );
}

// Namespace dmz_ai_hunt_squad
// Params 1
// Checksum 0xf9ef3e6a, Offset: 0xbac
// Size: 0x12f
function function_55dd289e94cccd( var_4c3ca46d62c3e12 )
{
    var_4c3ca46d62c3e12.endhunt = 1;
    var_4c3ca46d62c3e12.lastendtime = gettime();
    players = level.teamdata[ var_4c3ca46d62c3e12.huntedteam ][ "players" ];
    
    if ( var_4c3ca46d62c3e12.agents.size > 0 )
    {
        level thread hsquad_vanish( var_4c3ca46d62c3e12 );
    }
    
    foreach ( player in players )
    {
        player.aq_targethudenabled = 0;
        player setclientomnvar( "ui_br_assassination_target", 0 );
    }
    
    var_4c3ca46d62c3e12.task.taskended = 1;
    br_gametype_dmz::showdmzsplash( "dmz_hunt_target_survived", players );
    dmz_audio::function_32ff837bc21a4833( var_4c3ca46d62c3e12.huntedteam, "dmz_activity_win", 1 );
}

// Namespace dmz_ai_hunt_squad
// Params 2
// Checksum 0x62a44c32, Offset: 0xce3
// Size: 0x5a
function function_81cb190f54a20164( agent, var_4c3ca46d62c3e12 )
{
    agent waittill( #"death" );
    var_4c3ca46d62c3e12.agents = arrayremove( var_4c3ca46d62c3e12.agents, agent );
    
    if ( var_4c3ca46d62c3e12.agents.size == 0 )
    {
        function_55dd289e94cccd( var_4c3ca46d62c3e12 );
    }
}

// Namespace dmz_ai_hunt_squad
// Params 1
// Checksum 0x1c3e5ed6, Offset: 0xd45
// Size: 0x267
function hsquad_spawn( playerteamname )
{
    var_3579d677f32e6f25 = function_51a397a844b41355( playerteamname );
    var_ed7af5cbb797a6f0 = [ "ar", "sniper", "lmg", "sniper", "sniper", "lmg", "ar", "lmg" ];
    agentrequests = [];
    
    foreach ( reinforcementtype in var_ed7af5cbb797a6f0 )
    {
        agentrequests[ agentrequests.size ] = ai_reinforcements::function_f5e5b01238f335a0( reinforcementtype, 3 );
    }
    
    var_6fc710600b539c60 = ai_reinforcements::function_f5e5b01238f335a0( agentrequests );
    team = level.var_7ba393bd5b21cc2d;
    agents = ai_reinforcements::function_1faa63a0b398c676( level.huntsquads.var_577f8f2b6a330f68, var_3579d677f32e6f25.origin, "absolute", "huntSquad", undefined, undefined, team, undefined, undefined, "closet", undefined, undefined, var_6fc710600b539c60 );
    
    if ( !isdefined( agents ) || agents.size == 0 )
    {
        agents = ai_reinforcements::function_1faa63a0b398c676( level.huntsquads.var_577f8f2b6a330f68, var_3579d677f32e6f25.origin, "absolute", "huntSquad", undefined, undefined, team, undefined, undefined, "heli", undefined, undefined, var_6fc710600b539c60 );
    }
    
    if ( !isdefined( agents ) || agents.size == 0 )
    {
        return [];
    }
    
    foreach ( agent in agents )
    {
        if ( !isint( agent ) && isalive( agent ) )
        {
            agent thread hsquad_overrideagent( agent );
            agent_utils::function_3d1ccb7ed2f7c332( agent, "hSquad_overrideAgent", &hsquad_overrideagent );
        }
    }
    
    return [ agents, var_3579d677f32e6f25 ];
}

// Namespace dmz_ai_hunt_squad
// Params 2
// Checksum 0xac49f5a, Offset: 0xfb5
// Size: 0xf1
function function_51a397a844b41355( playerteamname, playerlist )
{
    var_3579d677f32e6f25 = undefined;
    mostkills = 0;
    
    if ( isdefined( playerlist ) )
    {
        var_b7ee2dc230ac3386 = playerlist;
    }
    else
    {
        if ( !isdefined( playerteamname ) )
        {
            return;
        }
        
        var_b7ee2dc230ac3386 = level.teamdata[ playerteamname ][ "players" ];
    }
    
    foreach ( player in var_b7ee2dc230ac3386 )
    {
        if ( !isdefined( var_3579d677f32e6f25 ) || player.kills > mostkills )
        {
            var_3579d677f32e6f25 = player;
            mostkills = player.kills;
        }
    }
    
    return var_3579d677f32e6f25;
}

// Namespace dmz_ai_hunt_squad
// Params 2
// Checksum 0x1df09b67, Offset: 0x10af
// Size: 0xe2
function function_ddcf87fa5df3ca1b( playerteamname, origin )
{
    var_b7ee2dc230ac3386 = level.teamdata[ playerteamname ][ "players" ];
    closeplayers = [];
    
    foreach ( player in var_b7ee2dc230ac3386 )
    {
        distsq = distancesquared( player.origin, origin );
        
        if ( level.huntsquads.var_cf06763ee71ce31a > distsq )
        {
            closeplayers[ closeplayers.size ] = player;
        }
    }
    
    return closeplayers;
}

// Namespace dmz_ai_hunt_squad
// Params 1
// Checksum 0x81964027, Offset: 0x119a
// Size: 0xa9
function function_75a9888ee871c8a( agents )
{
    agentorigins = [];
    
    foreach ( agent in agents )
    {
        if ( isalive( agent ) )
        {
            agentorigins[ agentorigins.size ] = agent.origin;
        }
    }
    
    if ( agentorigins.size == 0 )
    {
        return;
    }
    
    return averagepoint( agentorigins );
}

// Namespace dmz_ai_hunt_squad
// Params 1
// Checksum 0x9f6c1949, Offset: 0x124c
// Size: 0x446
function function_801641805e4141e4( var_4c3ca46d62c3e12 )
{
    var_51b627c8972cf99 = 1;
    dmz_audio::function_32ff837bc21a4833( var_4c3ca46d62c3e12.huntedteam, "dmz_activity_tension", 1 );
    players = level.teamdata[ var_4c3ca46d62c3e12.huntedteam ][ "players" ];
    
    foreach ( player in players )
    {
        agent_utils::function_3d40319b594473cb( player, "hs", 0 );
        group = agent_utils::function_35d561fbfa55ea02( player );
        agent_utils::function_33f83956b1b9af77( player, group );
        br_gametype_dmz::showdmzsplash( "dmz_hunt_assigned_others", [ player ] );
        function_29f5889665f36e78( player, var_4c3ca46d62c3e12 );
        player.var_deb9f34843d1d6f4 = 1;
    }
    
    while ( true )
    {
        if ( var_4c3ca46d62c3e12.endhunt )
        {
            return;
        }
        
        var_6d9bebd8285abc11 = 0;
        
        foreach ( agent in var_4c3ca46d62c3e12.agents )
        {
            if ( isdefined( agent.vehicle ) )
            {
                var_6d9bebd8285abc11 = 1;
                break;
            }
        }
        
        if ( !var_6d9bebd8285abc11 )
        {
            break;
        }
        
        wait 1;
    }
    
    level thread function_64afd4366be6d24b( var_4c3ca46d62c3e12 );
    
    while ( var_51b627c8972cf99 )
    {
        if ( var_4c3ca46d62c3e12.endhunt )
        {
            return;
        }
        
        players = level.teamdata[ var_4c3ca46d62c3e12.huntedteam ][ "players" ];
        
        foreach ( player in players )
        {
            if ( isalive( player ) && player.var_deb9f34843d1d6f4 )
            {
                continue;
            }
            
            agent_utils::function_3d40319b594473cb( player, "hs", 0 );
            group = agent_utils::function_35d561fbfa55ea02( player );
            agent_utils::function_33f83956b1b9af77( player, group );
            player.var_deb9f34843d1d6f4 = 1;
        }
        
        squadorigin = function_75a9888ee871c8a( var_4c3ca46d62c3e12.agents );
        closeplayers = function_ddcf87fa5df3ca1b( var_4c3ca46d62c3e12.huntedteam, squadorigin );
        
        if ( !isdefined( closeplayers ) || closeplayers.size == 0 )
        {
            function_55dd289e94cccd( var_4c3ca46d62c3e12 );
            var_51b627c8972cf99 = 0;
            continue;
        }
        
        var_4c3ca46d62c3e12.targetplayer = function_51a397a844b41355( var_4c3ca46d62c3e12.playerteamname, closeplayers );
        
        foreach ( agent in var_4c3ca46d62c3e12.agents )
        {
            if ( isdefined( agent.vehicle ) )
            {
                continue;
            }
            
            disttotargetsq = distancesquared( agent.origin, var_4c3ca46d62c3e12.targetplayer.origin );
            
            if ( disttotargetsq < level.huntsquads.var_cf06763ee71ce31a )
            {
                rushdist = function_3601087033b9e883( agent.agent_type );
                agent thread ai_behavior::behavior_combatRushOrigin( agent, var_4c3ca46d62c3e12.targetplayer.origin, rushdist, rushdist, 32, 1 );
                continue;
            }
            
            agent thread ai_behavior::behavior_combatRushOrigin( agent, squadorigin, 32, 32, 32, 1 );
        }
        
        wait 10;
    }
}

// Namespace dmz_ai_hunt_squad
// Params 1
// Checksum 0xe841561a, Offset: 0x169a
// Size: 0xfd
function hsquad_vanish( var_4c3ca46d62c3e12 )
{
    squadorigin = function_75a9888ee871c8a( var_4c3ca46d62c3e12.agents );
    fortress = ai_reinforcements::function_90692244f4131ed5( squadorigin, undefined, undefined, 8000, undefined );
    
    foreach ( agent in var_4c3ca46d62c3e12.agents )
    {
        origin = undefined;
        
        if ( isdefined( fortress ) )
        {
            origin = utility::array_random( fortress.spawnclosetnodes ).origin;
            agent thread ai_behavior::behavior_combatRushOrigin( agent, origin, 32, 32, 32, 1 );
        }
        
        agent thread function_4ab46c2c08c75f93( agent, origin );
    }
}

// Namespace dmz_ai_hunt_squad
// Params 2
// Checksum 0x4ed9fa8e, Offset: 0x179f
// Size: 0x122
function function_4ab46c2c08c75f93( agent, origin )
{
    agent endon( #"death" );
    distsq = 225000000;
    
    if ( isdefined( origin ) )
    {
        distsq = distancesquared( agent.origin, origin );
    }
    
    targetdist = 16384;
    timepassed = 0;
    interval = 5;
    
    while ( distsq > targetdist )
    {
        if ( isdefined( origin ) )
        {
            agent thread ai_behavior::behavior_combatRushOrigin( agent, origin, 32, 32, 32, 1 );
        }
        
        wait interval;
        players = getentarrayinradius( "player", #classname, agent.origin, 2056 );
        
        if ( players.size == 0 )
        {
            break;
        }
        
        if ( isdefined( origin ) )
        {
            distsq = distancesquared( agent.origin, origin );
        }
    }
    
    agent.nocorpse = 1;
    agent.noloot = 1;
    agent.dontdroploot = 1;
    agent.shoulddropweapon = 0;
    agent kill();
}

// Namespace dmz_ai_hunt_squad
// Params 1
// Checksum 0xbd294518, Offset: 0x18c9
// Size: 0x82
function function_3601087033b9e883( aitype )
{
    if ( !isdefined( aitype ) )
    {
        return;
    }
    
    if ( issubstr( aitype, "_ar" ) )
    {
        return 256;
    }
    
    if ( issubstr( aitype, "_lmg" ) || issubstr( aitype, "_sniper" ) )
    {
        return 768;
    }
    
    if ( issubstr( aitype, "_smg" ) || issubstr( aitype, "_shotgun" ) )
    {
        return 128;
    }
    
    if ( issubstr( aitype, "_rpg" ) )
    {
        return 512;
    }
}

// Namespace dmz_ai_hunt_squad
// Params 1
// Checksum 0xdbdc7ad3, Offset: 0x1953
// Size: 0xcf, Type: bool
function function_afeca7d12fa4ef74( team )
{
    if ( isdefined( level.huntsquads ) && isdefined( level.huntsquads.squads ) )
    {
        foreach ( struct in level.huntsquads.squads )
        {
            if ( team == struct.targetteam && !struct.endhunt )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace dmz_ai_hunt_squad
// Params 0
// Checksum 0x86d09ddc, Offset: 0x1a2b
// Size: 0x5a
function function_57644551485e614c()
{
    wait 5;
    player = level.players[ 0 ];
    agent_utils::function_3d40319b594473cb( player, "hs", 0 );
    group = agent_utils::function_35d561fbfa55ea02( player );
    agent_utils::function_33f83956b1b9af77( player, group );
    level thread hsquad_spawn( player.team );
}

// Namespace dmz_ai_hunt_squad
// Params 1
// Checksum 0xeb32ccb1, Offset: 0x1a8d
// Size: 0x58
function function_5fddddaff7861538( agent )
{
    agent endon( #"death" );
    
    while ( true )
    {
        if ( !isint( agent ) && isalive( agent ) )
        {
            /#
                sphere( agent.origin, 64, ( 1, 0, 0 ) );
            #/
        }
        
        waitframe();
    }
}

// Namespace dmz_ai_hunt_squad
// Params 1
// Checksum 0x85ef751d, Offset: 0x1aed
// Size: 0x14c
function hsquad_overrideagent( agent )
{
    wait 1;
    helmet = level.var_dd60cff6560fb12b[ "tier3" ];
    agent function_501782d2596f4016( 1 );
    agent_utils::function_4ba92f680237cedb( agent, "huntSquad" );
    agent.var_4f8a92ebabf37ee = 0;
    
    if ( utility::cointoss() )
    {
        body = "body_mp_koenig_iw9_7_1";
        head = "head_mp_koenig_iw9_7_1";
    }
    else
    {
        body = "body_mp_stiletto_iw9_8_1";
        head = "head_mp_stiletto_iw9_8_1";
    }
    
    agent agent_utils::overrideagentsettings( body, head, undefined, undefined, undefined, level.huntsquads.var_e5d652661b989bf3, helmet, 1 );
    agent.baseaccuracy = getdvarfloat( @"hash_c7631ad6f642733b", 2.2 );
    agent.var_1bf926518b0cb33 = 1;
    agent.var_4d3dee2aa67fa6a0 = 1;
    agent.var_38a06ee92c60ee9e = 1;
    agent.revive_bleedouttime = 12000;
    agent.allowlongdeath = 1;
    agent.forcelongdeath = 1;
    agent setengagementmindist( 1024, 256 );
    agent setengagementmaxdist( 6000, 9000 );
    agent function_2ef9eb3349906d00( 4500 );
    agent thread function_5fddddaff7861538( agent );
}

// Namespace dmz_ai_hunt_squad
// Params 1
// Checksum 0x75f80aeb, Offset: 0x1c41
// Size: 0xb2
function function_b073f6f9587a6d98( var_4c3ca46d62c3e12 )
{
    players = level.teamdata[ var_4c3ca46d62c3e12.huntedteam ][ "players" ];
    br_gametype_dmz::showdmzsplash( "dmz_hunt_assigned_others", players );
    
    foreach ( player in players )
    {
        function_29f5889665f36e78( player, var_4c3ca46d62c3e12 );
    }
}

// Namespace dmz_ai_hunt_squad
// Params 2
// Checksum 0xa26bc767, Offset: 0x1cfb
// Size: 0x44
function function_29f5889665f36e78( player, var_4c3ca46d62c3e12 )
{
    player setclientomnvar( "ui_br_assassination_target_timer", var_4c3ca46d62c3e12.var_11ba9afe34d485db );
    player.aq_targethudenabled = 1;
    player thread function_f9da38919e6efa06( var_4c3ca46d62c3e12 );
}

// Namespace dmz_ai_hunt_squad
// Params 1
// Checksum 0x8d33c756, Offset: 0x1d47
// Size: 0x23f
function function_f9da38919e6efa06( var_4c3ca46d62c3e12 )
{
    while ( true )
    {
        if ( var_4c3ca46d62c3e12.endhunt )
        {
            return;
        }
        
        players = level.teamdata[ var_4c3ca46d62c3e12.huntedteam ][ "players" ];
        
        if ( !isdefined( var_4c3ca46d62c3e12.lastthreatlevel ) )
        {
            var_4c3ca46d62c3e12.lastthreatlevel = [];
        }
        
        threatlevel = undefined;
        
        if ( !isdefined( var_4c3ca46d62c3e12.targetplayer ) )
        {
            squadorigin = function_75a9888ee871c8a( var_4c3ca46d62c3e12.agents );
            closeplayers = function_ddcf87fa5df3ca1b( var_4c3ca46d62c3e12.huntedteam, squadorigin );
            var_4c3ca46d62c3e12.targetplayer = function_51a397a844b41355( var_4c3ca46d62c3e12.playerteamname, closeplayers );
        }
        
        dist = distance( var_4c3ca46d62c3e12.targetplayer.origin, function_75a9888ee871c8a( var_4c3ca46d62c3e12.agents ) );
        threatlevel = 0;
        
        if ( dist > level.huntsquads.var_f872edeae3d189f2 )
        {
            threatlevel = 0;
        }
        else if ( dist > level.huntsquads.var_3347fe649d5bafb )
        {
            threatlevel = 1;
            dmz_audio::function_32ff837bc21a4833( var_4c3ca46d62c3e12.huntedteam, "dmz_activity_tension", 0, "dmz_activity_tension_classic" );
        }
        else
        {
            threatlevel = 2;
        }
        
        foreach ( player in players )
        {
            playerid = player player::getuniqueid();
            
            if ( !isdefined( var_4c3ca46d62c3e12.lastthreatlevel[ playerid ] ) )
            {
                var_4c3ca46d62c3e12.lastthreatlevel[ playerid ] = 0;
            }
            
            if ( !isdefined( threatlevel ) )
            {
                threatlevel = var_4c3ca46d62c3e12.lastthreatlevel[ playerid ];
            }
            
            var_4c3ca46d62c3e12.lastthreatlevel[ playerid ] = threatlevel;
            player br_contract_manager::function_173bf8dac654a1e1( player, threatlevel );
        }
        
        wait 2;
    }
}

