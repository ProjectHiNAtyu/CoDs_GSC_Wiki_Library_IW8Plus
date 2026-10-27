// script_7439d62b3781dc9f  (hash_7439d62b3781dc9f.gscc) (size: 15416 Bytes / 0x3c38 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4df74a57 (1308052055)
// size ...... 15416 (0x3c38)
// includes .. 14  (offset: 0x3918)
// strings ... 48  (offset: 0x3988)
// dev strs .. 1   (offset: 0x3c2c)
// exports ... 27  (offset: 0x2a70)
// cseg ...... 0x435 + 0x263b (0x2a70)
// imports ... 82  (offset: 0x2ea8)
// animtree1 . 0   (offset: 0x3c38)
// animtree2 . 0   (offset: 0x3c38)
#using script_730ee2ef1439bea7;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_dmz_inventory;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dmz\gametypes\dmz_audio;
#using scripts\mp\dmz\gametypes\dmz_task_utils;
#using scripts\mp\flags;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\poi;

#namespace namespace_76299fb251d3aacd;

// Namespace namespace_76299fb251d3aacd
// Params 1
// Checksum 0x1c755be8, Offset: 0x453
// Size: 0x490
function dmztask_getspawndata( data )
{
    level.huntprops = spawnstruct();
    level.huntprops.poiradius = getdvarint( @"hash_748ab0bc80934de8", 5000 );
    level.huntprops.teamradius = getdvarint( @"hash_88a9d31f746fdcfd", 3000 );
    level.huntprops.teamradiussq = level.huntprops.teamradius * level.huntprops.teamradius;
    level.huntprops.var_14e34034f02e4ebd = getdvarint( @"hash_c110a96f83421225", 1000 );
    level.huntprops.circlepadding = getdvarint( @"hash_7dc3a9f8ffacec29", 500 );
    level.huntprops.var_2504ee4a273c8de7 = getdvarint( @"hash_8dc01b0b3abf0a38", 20 );
    level.huntprops.var_398b66b50aa9d881 = getdvarint( @"hash_34765b5b6345dae7", 5 );
    level.huntprops.timelimit = getdvarint( @"scr_dmz_hunt_time_limit", 300 );
    level.huntprops.scoremaxdist = getdvarfloat( @"hash_89b6724f76aa6e23", 80000 );
    level.huntprops.var_3347fe649d5bafb = getdvarint( @"hash_21134403816f9c13", 3000 );
    level.huntprops.var_f872edeae3d189f2 = getdvarint( @"hash_af4ffd6ef7ff488c", 8000 );
    level.huntprops.warningdist = getdvarint( @"hash_be8a7d28964a6dc2", 8000 );
    level.huntprops.distmodifier = getdvarfloat( @"hash_29632d3bfbe41a8", 240 );
    level.huntprops.var_31675339e491f1bc = getdvarfloat( @"hash_1c5b121d784df846", 40 );
    level.huntprops.civsmodifier = getdvarfloat( @"hash_e6e560e292fa7267", 50 );
    level.huntprops.agentsmodifier = getdvarfloat( @"hash_c67f8f7bb2b43236", 2.5 );
    level.huntprops.operatorsmodifier = getdvarfloat( @"hash_a46ce7a6ed335d5b", 60 );
    level.huntprops.valuablesmodifier = getdvarfloat( @"hash_db4270e079922c25", 0.05 );
    level.huntprops.showtime = getdvarint( @"hash_9ce7fc426fd9f32e", 900 );
    level.huntprops.tasks = [];
    callback::add( #"player_assimilated", &function_2550892140fff0c1 );
    validnodes = [];
    minimumdifficulty = data.difficulty;
    phones = getentitylessscriptablearray( "brloot_activity_starter_hunt" );
    
    foreach ( phone in phones )
    {
        origin = phone.origin;
        poiname = poi::poi_findpoioriginisin( origin );
        subarea = utility::callsharedfunc( #"poi", #"hash_8dbb0d45f903ae1c", origin, poiname );
        
        if ( isdefined( subarea ) && isdefined( subarea.tuning ) && subarea.tuning.difficultyrating >= minimumdifficulty )
        {
            struct = spawnstruct();
            struct.origin = origin;
            struct.script_poi = poiname;
            validnodes[ validnodes.size ] = struct;
        }
        
        /#
            if ( level.mapname == "<dev string:x24>" )
            {
                struct = spawnstruct();
                struct.origin = origin;
                validnodes[ validnodes.size ] = struct;
            }
        #/
    }
    
    activity_manager::function_f61a1f535aab4194( data, &function_26b23934b7d2a1cc, validnodes );
}

/#

    // Namespace namespace_76299fb251d3aacd
    // Params 0
    // Checksum 0x2e34ae89, Offset: 0x8eb
    // Size: 0x7, Type: dev
    function function_746bdfc760ec9b18()
    {
        return [];
    }

#/

// Namespace namespace_76299fb251d3aacd
// Params 2
// Checksum 0x4cdaac5d, Offset: 0x8fa
// Size: 0x11c
function function_26b23934b7d2a1cc( activity, node )
{
    task = dmz_task_utils::task_create( activity );
    task.funcs[ "onInit" ] = &function_4d5be1391ccd7ffb;
    task.funcs[ "onTeamStart" ] = &function_55e467afd14578d8;
    task.funcs[ "onPlayerJoined" ] = &function_fa4a62ed28a32b09;
    task.funcs[ "onPlayerRemoved" ] = &function_5b0a7549292cf2ac;
    task.funcs[ "onTeamAssigned" ] = &function_6b32ac83767b871c;
    task.funcs[ "onCancel" ] = &function_1376a45492bdb813;
    task.ref = "dmz_hunt";
    task.refindex = br_contract_manager::getquesttableindex( task.ref );
    task.node = node;
    level.huntprops.tasks[ level.huntprops.tasks.size ] = task;
    return task;
}

// Namespace namespace_76299fb251d3aacd
// Params 0
// Checksum 0x86d4b3de, Offset: 0xa1f
// Size: 0x8e
function function_4d5be1391ccd7ffb()
{
    self.activity.origin = self.node.origin;
    dmz_task_utils::function_13fe84cb824c72a8( "Hostage_Dmz", [ self.node.origin ], level.huntprops.teamradius + level.huntprops.circlepadding );
    dmz_task_utils::function_b3476f99a8e21fa2( self.node.origin );
}

// Namespace namespace_76299fb251d3aacd
// Params 1
// Checksum 0x7faac0a0, Offset: 0xab5
// Size: 0x1e
function function_fa4a62ed28a32b09( player )
{
    dmz_task_utils::function_6277bd2a0d5a28b9( player );
    dmz_task_utils::function_dc6a173a36eef985( player );
}

// Namespace namespace_76299fb251d3aacd
// Params 1
// Checksum 0xde7f59a1, Offset: 0xadb
// Size: 0x1e
function function_5b0a7549292cf2ac( player )
{
    dmz_task_utils::function_1f01bb1108ba0241( player );
    dmz_task_utils::function_d8d9112f1e68fa2b( player );
}

// Namespace namespace_76299fb251d3aacd
// Params 1
// Checksum 0x2da3d5e8, Offset: 0xb01
// Size: 0x25e
function function_2550892140fff0c1( params )
{
    player = self;
    oldteam = params.oldteam;
    newteam = params.newteam;
    
    foreach ( task in level.huntprops.tasks )
    {
        if ( isdefined( task.targetteam ) )
        {
            if ( oldteam == task.targetteam )
            {
                player.aq_targethudenabled = 0;
                player br_contract_manager::function_173bf8dac654a1e1( undefined, 0 );
                
                if ( !task.var_cec102b7fb583311 && isdefined( task.targetplayer ) && task.targetplayer == player )
                {
                    teammates = task function_2bf10de399de1b32( player.origin );
                    
                    if ( teammates.size )
                    {
                        task.targetplayer = teammates[ 0 ];
                    }
                    else if ( newteam == task.teams[ 0 ] )
                    {
                        utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"hunt_team_assimilation_all", task.teams[ 0 ] );
                        task dmz_task_utils::function_c64a66646904bc1( "dmz_hunt_lost_assimilation", "hunt", 0, task.teams[ 0 ] );
                        task function_94ffddd5f7608ba2();
                    }
                    else
                    {
                        utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"hunt_eliminated_external", task.teams[ 0 ] );
                        task dmz_task_utils::function_c64a66646904bc1( "dmz_hunt_eliminated_external", "hunt", task.activity.cashreward, task.teams[ 0 ] );
                        task function_94ffddd5f7608ba2( task.teams[ 0 ] );
                    }
                }
            }
            
            if ( newteam == task.targetteam )
            {
                task thread function_a60b81691e00c1b9( player, 0 );
            }
        }
    }
}

// Namespace namespace_76299fb251d3aacd
// Params 1
// Checksum 0xe3ebed7d, Offset: 0xd67
// Size: 0x488
function function_6b32ac83767b871c( teamname )
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    playersonteam = teams::getteamdata( teamname, "players" );
    origin = playersonteam[ 0 ].origin;
    nearestplayer = undefined;
    maxscore = -1;
    bestscoretype = "generic";
    
    foreach ( player in level.players )
    {
        if ( player.team != teamname && player player::isreallyalive() && !function_5fad9f41bbc49c5c( player.team ) && !dmz_ai_hunt_squad::function_afeca7d12fa4ef74( player.team ) )
        {
            scores = function_fcc7c3eeb5dcdf88( player, origin );
            totalplayerscore = 0;
            var_2735a4da5b11ea50 = 0;
            var_2cd1d7a3bf231774 = "generic";
            
            foreach ( type, score in scores )
            {
                totalplayerscore += score;
                
                if ( type != "generic" && score > var_2735a4da5b11ea50 )
                {
                    var_2735a4da5b11ea50 = score;
                    var_2cd1d7a3bf231774 = type;
                }
            }
            
            if ( totalplayerscore > maxscore )
            {
                maxscore = totalplayerscore;
                bestscoretype = var_2cd1d7a3bf231774;
                nearestplayer = player;
            }
        }
    }
    
    if ( !isdefined( nearestplayer ) )
    {
        dmz_task_utils::function_c64a66646904bc1( "dmz_hunt_no_targets", "hunt", self.activity.cashreward, teamname );
        function_94ffddd5f7608ba2( teamname );
        return;
    }
    
    self.teamorigins = [];
    dmz_task_utils::function_a532b7f17f4920e8( teamname, 0 );
    thread dmz_task_utils::function_6435c5abd423fd62( teamname, 0 );
    thread function_4e4a8f39ebb7328f( nearestplayer.team, 0 );
    thread function_4e4a8f39ebb7328f( teamname, 1 );
    self.huntingteam = teamname;
    self.targetteam = nearestplayer.team;
    self.targetplayer = nearestplayer;
    self.targetskilled = 0;
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", "hunt_assigned_" + bestscoretype, teamname );
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", "hunt_assigned_others_" + bestscoretype, self.targetteam );
    dmz_task_utils::task_showsplashtoteam( "dmz_hunt_assigned", teamname );
    dmz_task_utils::task_showsplashtoteam( "dmz_hunt_assigned_others", self.targetteam );
    dmz_audio::function_32ff837bc21a4833( teamname, "dmz_activity_start", 1.5, "dmz_activity_start_classic" );
    thread function_699d74018d376cf8( self.targetteam, 0 );
    targetplayers = teams::getteamdata( self.targetteam, "players" );
    self.missiontime = gettime() + level.huntprops.timelimit * 1000;
    
    foreach ( player in targetplayers )
    {
        thread function_a60b81691e00c1b9( player, 0 );
        player setclientomnvar( "ui_br_assassination_target_timer", self.missiontime );
    }
    
    foreach ( player in playersonteam )
    {
        player setclientomnvar( "ui_br_objective_countdown_timer", self.missiontime );
    }
    
    thread function_accdff2505394612( 0 );
    thread function_a2c8ed897c4036f0();
}

// Namespace namespace_76299fb251d3aacd
// Params 1
// Checksum 0x1cbebcec, Offset: 0x11f7
// Size: 0xc
function function_55e467afd14578d8( teamname )
{
    
}

// Namespace namespace_76299fb251d3aacd
// Params 1
// Checksum 0x3c22bafe, Offset: 0x120b
// Size: 0xc8
function function_1376a45492bdb813( teamname )
{
    players = teams::getteamdata( teamname, "players" );
    
    foreach ( player in players )
    {
        player setplayermusicstate( "" );
    }
    
    if ( isdefined( self.targetteam ) )
    {
        dmz_task_utils::task_showsplashtoteam( "dmz_hunt_target_survived", self.targetteam );
    }
    
    dmztask_cleanup();
    dmz_task_utils::task_ended();
}

// Namespace namespace_76299fb251d3aacd
// Params 0
// Checksum 0x12e36152, Offset: 0x12db
// Size: 0xf5
function dmztask_cleanup()
{
    self.taskended = 1;
    level.huntprops.tasks = arrayremove( level.huntprops.tasks, self );
    dmz_task_utils::function_e23cad864e9e2023();
    dmz_task_utils::function_3ff46488beb193c7();
    
    if ( isdefined( self.targetteam ) )
    {
        var_9a5cb607bfe10ee1 = teams::getteamdata( self.targetteam, "players" );
        
        foreach ( player in var_9a5cb607bfe10ee1 )
        {
            player.aq_targethudenabled = 0;
            player setclientomnvar( "ui_br_assassination_target", 0 );
        }
    }
}

// Namespace namespace_76299fb251d3aacd
// Params 1, eflags: 0x4
// Checksum 0x38301eaa, Offset: 0x13d8
// Size: 0x43
function private function_94ffddd5f7608ba2( team )
{
    dmztask_cleanup();
    
    if ( isdefined( team ) )
    {
        dmz_task_utils::function_e533421ccebd7d79( team );
        dmz_audio::function_32ff837bc21a4833( team, "dmz_activity_win", 1.5, "dmz_activity_win_classic" );
    }
    
    dmz_task_utils::task_ended( team );
}

// Namespace namespace_76299fb251d3aacd
// Params 1
// Checksum 0xef91ccfd, Offset: 0x1423
// Size: 0xbb, Type: bool
function function_5fad9f41bbc49c5c( team )
{
    foreach ( task in level.huntprops.tasks )
    {
        if ( !task.taskended && isdefined( task.targetteam ) && task.targetteam == team )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_76299fb251d3aacd
// Params 2
// Checksum 0x6e48aab9, Offset: 0x14e7
// Size: 0x212
function function_fcc7c3eeb5dcdf88( player, origin )
{
    scores = [];
    dist = distance( origin, player.origin );
    maxdist = level.huntprops.scoremaxdist;
    distscore = max( level.huntprops.distmodifier * ( 1 - dist / maxdist ), 0 );
    teamplayers = teams::getteamdata( player.team, "players" );
    var_1a2e1d26ca4d33d3 = 0;
    
    foreach ( player in teamplayers )
    {
        if ( isdefined( player.perks[ "specialty_ghost" ] ) )
        {
            var_1a2e1d26ca4d33d3++;
        }
    }
    
    var_4a4c3f5ee3595321 = level.huntprops.var_31675339e491f1bc * ( teamplayers.size - var_1a2e1d26ca4d33d3 );
    scores[ "generic" ] = distscore + var_4a4c3f5ee3595321;
    scores[ "civs" ] = level.huntprops.civsmodifier * ( player.civiliankillcount ?? 0 );
    scores[ "agents" ] = level.huntprops.agentsmodifier * ( player.agentkills ?? 0 );
    scores[ "operators" ] = level.huntprops.operatorsmodifier * ( player.pers[ "kills" ] ?? 0 );
    scores[ "valuables" ] = level.huntprops.valuablesmodifier * ( player.plundercount + player br_dmz_inventory::function_e342ce3749830a35( undefined, 1 ) );
    return scores;
}

// Namespace namespace_76299fb251d3aacd
// Params 0
// Checksum 0x7b42280e, Offset: 0x1702
// Size: 0xc2
function function_a2c8ed897c4036f0()
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    wait level.huntprops.timelimit;
    
    if ( self.taskended )
    {
        return;
    }
    
    dmz_task_utils::function_c64a66646904bc1( "dmz_hunt_lost_time", "hunt", 0, self.teams[ 0 ] );
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"hunt_lose_time", self.teams[ 0 ] );
    dmz_audio::function_32ff837bc21a4833( self.teams[ 0 ], "dmz_activity_lose", 0, "dmz_activity_lose_classic" );
    dmz_task_utils::task_showsplashtoteam( "dmz_hunt_target_survived", self.targetteam );
    function_94ffddd5f7608ba2();
}

// Namespace namespace_76299fb251d3aacd
// Params 1
// Checksum 0xc6296640, Offset: 0x17cc
// Size: 0x465
function function_accdff2505394612( teamindex )
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    playeddialog = 0;
    
    while ( true )
    {
        if ( isdefined( self.targetplayer ) && isdefined( self.targetplayer.guid ) && isdefined( self.teamorigins[ teamindex ][ self.targetplayer.guid ] ) )
        {
            playersonteam = teams::getteamdata( self.teams[ 0 ], "players" );
            closestplayer = function_47c86977a18df38b( playersonteam, self.teamorigins[ teamindex ][ self.targetplayer.guid ] );
            dist = distance( closestplayer.origin, self.teamorigins[ teamindex ][ self.targetplayer.guid ] );
            threatlevel = 0;
            
            if ( dist > level.huntprops.var_f872edeae3d189f2 )
            {
                threatlevel = 0;
            }
            else if ( dist > level.huntprops.var_3347fe649d5bafb )
            {
                threatlevel = 1;
            }
            else
            {
                threatlevel = 2;
            }
            
            if ( !playeddialog && dist < level.huntprops.warningdist )
            {
                totarget = vectornormalize2( self.teamorigins[ teamindex ][ self.targetplayer.guid ] - closestplayer.origin );
                cosangle = 0.92388;
                coshalf = 0.707107;
                alias = #"hunt_near_generic";
                
                if ( vectordot2( totarget, ( 1, 0, 0 ), 1 ) > cosangle )
                {
                    alias = #"hunt_near_east";
                }
                else if ( vectordot2( totarget, ( 0, 1, 0 ), 1 ) > cosangle )
                {
                    alias = #"hunt_near_north";
                }
                else if ( vectordot2( totarget, ( -1, 0, 0 ), 1 ) > cosangle )
                {
                    alias = #"hunt_near_west";
                }
                else if ( vectordot2( totarget, ( 0, -1, 0 ), 1 ) > cosangle )
                {
                    alias = #"hunt_near_south";
                }
                else if ( vectordot2( totarget, ( coshalf, coshalf, 0 ), 1 ) > cosangle )
                {
                    alias = #"hunt_near_northeast";
                }
                else if ( vectordot2( totarget, ( 0 - coshalf, coshalf, 0 ), 1 ) > cosangle )
                {
                    alias = #"hunt_near_northwest";
                }
                else if ( vectordot2( totarget, ( 0 - coshalf, 0 - coshalf, 0 ), 1 ) > cosangle )
                {
                    alias = #"hunt_near_southwest";
                }
                else if ( vectordot2( totarget, ( coshalf, 0 - coshalf, 0 ), 1 ) > cosangle )
                {
                    alias = #"hunt_near_southeast";
                }
                
                utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", alias, self.teams[ 0 ] );
                utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"hunt_near_others", self.targetteam );
                playeddialog = 1;
                dmz_audio::function_32ff837bc21a4833( self.teams[ 0 ], "dmz_activity_tension", 0, "dmz_activity_tension_classic" );
                dmz_audio::function_32ff837bc21a4833( self.targetteam, "dmz_activity_tension", 0, "dmz_activity_tension_classic" );
            }
            
            var_9a5cb607bfe10ee1 = teams::getteamdata( self.targetteam, "players" );
            
            foreach ( player in var_9a5cb607bfe10ee1 )
            {
                player.aq_targethudenabled = 1;
                player br_contract_manager::function_173bf8dac654a1e1( self.targetplayer, threatlevel );
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_76299fb251d3aacd
// Params 2
// Checksum 0xb16105e2, Offset: 0x1c39
// Size: 0x3bb
function function_699d74018d376cf8( team, followingteamindex )
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    var_9a5cb607bfe10ee1 = teams::getteamdata( self.targetteam, "players" );
    
    if ( !isdefined( self.targetplayer ) || self.targetplayer.team != self.targetteam )
    {
        var_cec02ab8cf16e714 = 0;
        
        foreach ( player in var_9a5cb607bfe10ee1 )
        {
            if ( player player::isreallyalive() )
            {
                self.targetplayer = player;
                var_cec02ab8cf16e714 = 1;
                break;
            }
        }
        
        if ( !var_cec02ab8cf16e714 )
        {
            return;
        }
    }
    
    self.lastposition = self.teamorigins[ followingteamindex ][ self.targetplayer.guid ];
    var_7b13d93535c91a67 = -999999;
    
    while ( true )
    {
        currenttime = gettime();
        var_9a5cb607bfe10ee1 = teams::getteamdata( self.targetteam, "players" );
        self.targetplayers = [];
        points = [];
        
        if ( !isdefined( self.targetplayer ) || self.targetplayer.team != self.targetteam )
        {
            var_cec02ab8cf16e714 = 0;
            
            foreach ( player in var_9a5cb607bfe10ee1 )
            {
                if ( player player::isreallyalive() )
                {
                    self.targetplayer = player;
                    var_cec02ab8cf16e714 = 1;
                    break;
                }
            }
            
            if ( !var_cec02ab8cf16e714 )
            {
                return;
            }
        }
        
        if ( !( isdefined( self.targetplayer ) && isdefined( self.teamorigins[ followingteamindex ][ self.targetplayer.guid ] ) ) )
        {
            return;
        }
        
        activefrequency = level.huntprops.var_2504ee4a273c8de7;
        invehicle = self.targetplayer vehicle::is_in_vehicle( 0 );
        
        if ( invehicle )
        {
            activefrequency = level.huntprops.var_398b66b50aa9d881;
        }
        
        if ( currenttime - var_7b13d93535c91a67 > activefrequency * 1000 )
        {
            radius = invehicle ? level.huntprops.var_14e34034f02e4ebd : level.huntprops.teamradius;
            circleorigin = dmz_task_utils::function_c7ccd46fc59f189d( self.lastposition, radius );
            circleorigin = ( circleorigin[ 0 ], circleorigin[ 1 ], level.huntprops.teamradius + level.huntprops.circlepadding );
            self.questcircles[ 0 ].mapcircle moveto( circleorigin, 1, 0.25, 0.25 );
            thread function_c61738258d2d02d7();
            self.lastposition = self.teamorigins[ followingteamindex ][ self.targetplayer.guid ];
            var_7b13d93535c91a67 = currenttime;
        }
        
        wait 1;
    }
}

// Namespace namespace_76299fb251d3aacd
// Params 0
// Checksum 0x2f2e8280, Offset: 0x1ffc
// Size: 0xa2
function function_c61738258d2d02d7()
{
    self endon( #"task_ended" );
    endtime = gettime() + 1200;
    
    while ( isdefined( self.questcircles[ 0 ] ) && isdefined( self.questcircles[ 0 ].mapcircle ) && isdefined( self.questcircles[ 0 ].mapcircle.origin ) && gettime() < endtime )
    {
        dmz_task_utils::function_c74c010e593f5ea5( self.questcircles[ 0 ].mapcircle.origin );
        waitframe();
    }
}

// Namespace namespace_76299fb251d3aacd
// Params 2
// Checksum 0x6ffbd53c, Offset: 0x20a6
// Size: 0x2f6
function function_a60b81691e00c1b9( targetplayer, watchingteamindex )
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    
    while ( true )
    {
        targetplayer utility::waittill_any( "death_or_disconnect", "enter_live_ragdoll", "successful_exfil", "map_to_map_warp" );
        
        if ( self.taskended )
        {
            return;
        }
        
        if ( !isdefined( targetplayer ) || isdefined( targetplayer.team ) && targetplayer.team != self.targetteam )
        {
            return;
        }
        
        if ( targetplayer.extracted || targetplayer.var_4b1f798ecbed7345 )
        {
            if ( targetplayer == self.targetplayer )
            {
                teammates = function_2bf10de399de1b32( self.teamorigins[ watchingteamindex ][ targetplayer.guid ] );
                
                if ( teammates.size == 0 )
                {
                    dmz_task_utils::function_c64a66646904bc1( "dmz_hunt_lost_exfilled", "hunt", self.activity.cashreward, self.teams[ 0 ] );
                    dmz_task_utils::task_showsplashtoteam( "dmz_hunt_target_over", self.targetteam );
                    thread function_94ffddd5f7608ba2();
                    return;
                }
                else
                {
                    self.targetplayer = teammates[ 0 ];
                }
            }
        }
        else if ( !targetplayer player::isreallyalive() )
        {
            if ( !( isdefined( targetplayer.lastkilledby ) && isdefined( targetplayer.lastkilledby.team ) ) || targetplayer.lastkilledby.team != self.teams[ 0 ] )
            {
                if ( !self.var_cec102b7fb583311 )
                {
                    teammates = function_2bf10de399de1b32( self.teamorigins[ watchingteamindex ][ targetplayer.guid ] );
                    
                    if ( targetplayer == self.targetplayer )
                    {
                        if ( teammates.size == 0 )
                        {
                            utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"hunt_eliminated_external", self.teams[ 0 ] );
                            dmz_task_utils::function_c64a66646904bc1( "dmz_hunt_eliminated_external", "hunt", self.activity.cashreward, self.teams[ 0 ] );
                            dmz_task_utils::task_showsplashtoteam( "dmz_hunt_target_over", self.targetteam );
                            thread function_94ffddd5f7608ba2( self.teams[ 0 ] );
                            return;
                        }
                        else
                        {
                            self.targetplayer = teammates[ 0 ];
                        }
                    }
                }
            }
            else
            {
                self.var_cec102b7fb583311 = 1;
                
                if ( !self.targetkilled )
                {
                    self.targetplayer = targetplayer;
                    self.targetkilled = 1;
                    thread function_51bba37a81cbb467( self.teamorigins[ watchingteamindex ][ targetplayer.guid ] );
                }
            }
        }
        
        targetplayer waittill( #"spawned" );
        
        if ( self.targetplayer == targetplayer )
        {
            self notify( #"hash_201785c42c2211a2" );
        }
    }
}

// Namespace namespace_76299fb251d3aacd
// Params 2
// Checksum 0xf98b6b31, Offset: 0x23a4
// Size: 0xe8
function function_4e4a8f39ebb7328f( team, index )
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    self.teamorigins[ index ] = [];
    
    while ( true )
    {
        players = teams::getteamdata( team, "players" );
        
        foreach ( player in players )
        {
            self.teamorigins[ index ][ player.guid ] = player.origin;
        }
        
        waitframe();
    }
}

// Namespace namespace_76299fb251d3aacd
// Params 1
// Checksum 0x5b34ee8f, Offset: 0x2494
// Size: 0x138
function function_51bba37a81cbb467( origin )
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    self endon( #"hash_201785c42c2211a2" );
    
    while ( true )
    {
        count = function_40d55513f8e97a4( origin );
        
        if ( count == 0 )
        {
            self.var_2d4963c8d03c8ffd = 1;
            
            if ( teams::getsquadmates( self.targetteam, undefined, 1 ).size )
            {
                utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"hunt_eliminated_ran_away", self.teams[ 0 ] );
                dmz_task_utils::task_showsplashtoteam( "dmz_hunt_target_over", self.targetteam );
            }
            else
            {
                utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"hunt_eliminated_no_dog_tags", self.teams[ 0 ] );
            }
            
            dmz_task_utils::function_c64a66646904bc1( "dmz_hunt_won", "hunt", self.activity.cashreward, self.teams[ 0 ] );
            function_94ffddd5f7608ba2( self.teams[ 0 ] );
        }
        
        self.previouscount = count;
        wait 1;
    }
}

// Namespace namespace_76299fb251d3aacd
// Params 1
// Checksum 0x71ffea4a, Offset: 0x25d4
// Size: 0xfb
function function_2bf10de399de1b32( origin )
{
    players = teams::getteamdata( self.targetteam, "players" );
    teammates = [];
    
    foreach ( player in players )
    {
        if ( player player::isreallyalive() && !player.extracted && !player.var_4b1f798ecbed7345 && distancesquared( player.origin, origin ) < level.huntprops.teamradiussq )
        {
            teammates[ teammates.size ] = player;
        }
    }
    
    return teammates;
}

// Namespace namespace_76299fb251d3aacd
// Params 1
// Checksum 0xdec65c69, Offset: 0x26d8
// Size: 0x15
function function_40d55513f8e97a4( origin )
{
    return function_2bf10de399de1b32( origin ).size;
}

// Namespace namespace_76299fb251d3aacd
// Params 0
// Checksum 0x41aa5f58, Offset: 0x26f6
// Size: 0x1a1
function function_abfc1364a8043fe1()
{
    if ( isdefined( level.huntprops ) && isdefined( level.huntprops.tasks ) )
    {
        foreach ( task in level.huntprops.tasks )
        {
            if ( !isdefined( task.teams[ 0 ] ) )
            {
                task.activity.activitystarter activity_manager::function_2a0e4909a5f9b6a4();
            }
        }
        
        flags::gameflagwait( "prematch_done" );
        wait level.huntprops.showtime;
        
        foreach ( task in level.huntprops.tasks )
        {
            if ( !isdefined( task.teams[ 0 ] ) )
            {
                task.activity.activitystarter activity_manager::function_a4194904aa550aab();
            }
        }
        
        br_gametype_dmz::showdmzsplash( "dmz_hunt_contracts_revealed", level.players );
    }
}

// Namespace namespace_76299fb251d3aacd
// Params 0
// Checksum 0x26e26570, Offset: 0x289f
// Size: 0xca
function function_424225e6612178eb()
{
    if ( isdefined( level.huntprops ) && isdefined( level.huntprops.tasks ) )
    {
        foreach ( task in level.huntprops.tasks )
        {
            if ( !( isdefined( task.teams ) && isdefined( task.teams[ 0 ] ) ) )
            {
                task function_94ffddd5f7608ba2();
            }
        }
    }
}

// Namespace namespace_76299fb251d3aacd
// Params 2
// Checksum 0x65df1250, Offset: 0x2971
// Size: 0xfe, Type: bool
function function_c089e3a05ab8b52( huntingteam, huntedteam )
{
    if ( !( isdefined( huntingteam ) && isdefined( huntedteam ) ) )
    {
        return false;
    }
    
    if ( !( isdefined( level.huntprops ) && isdefined( level.huntprops.tasks ) ) )
    {
        return false;
    }
    
    foreach ( task in level.huntprops.tasks )
    {
        if ( task.teams[ 0 ] == huntingteam && isdefined( task.targetteam ) && task.targetteam == huntedteam )
        {
            return true;
        }
    }
    
    return false;
}

