// script_299b5dbadaf2b146  (hash_299b5dbadaf2b146.gscc) (size: 10849 Bytes / 0x2a61 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x41d22602 (1104291330)
// size ...... 10849 (0x2a61)
// includes .. 15  (offset: 0x2705)
// strings ... 42  (offset: 0x277d)
// dev strs .. 8   (offset: 0x29f9)
// exports ... 18  (offset: 0x19d9)
// cseg ...... 0x389 + 0x1650 (0x19d9)
// imports ... 89  (offset: 0x1ca9)
// animtree1 . 0   (offset: 0x2a61)
// animtree2 . 0   (offset: 0x2a61)
#using script_599653855a4317f1;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_fortress;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\ai_reinforcements;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_dmz_extract;
#using scripts\mp\dmz\gametypes\dmz_audio;
#using scripts\mp\dmz\gametypes\dmz_task_utils;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\loot\common_cache;
#using scripts\mp\objidpoolmanager;

#namespace namespace_a7cd3da1542a2432;

// Namespace namespace_a7cd3da1542a2432
// Params 1
// Checksum 0xd533c687, Offset: 0x3a7
// Size: 0x137
function dmztask_getspawndata( data )
{
    level.safeprops = spawnstruct();
    level.safeprops.capturetime = getdvarint( @"scr_dmz_safe_capture_time", 75 );
    level.safeprops.captureradius = getdvarint( @"scr_dmz_safe_capture_radius", 150 );
    safelocations = utility::getstructarray( "dmz_safe", "script_noteworthy" );
    validlocations = [];
    
    foreach ( safelocation in safelocations )
    {
        fortress = ai_fortress::function_386da8b7d1afe346( safelocation.origin );
        
        if ( !isdefined( fortress ) )
        {
            validlocations[ validlocations.size ] = safelocation;
        }
    }
    
    scriptable::scriptable_addusedcallbackbypart( "safe", &function_ae6b49a1b1c968bf );
    activity_manager::function_f61a1f535aab4194( data, &function_3a301a13efdb81a4, validlocations );
}

/#

    // Namespace namespace_a7cd3da1542a2432
    // Params 0
    // Checksum 0xbb637d3b, Offset: 0x4e6
    // Size: 0x16, Type: dev
    function function_746bdfc760ec9b18()
    {
        return utility::getstructarray( "<dev string:x24>", "<dev string:x2d>" );
    }

#/

// Namespace namespace_a7cd3da1542a2432
// Params 2
// Checksum 0x13ffe47c, Offset: 0x504
// Size: 0xda
function function_3a301a13efdb81a4( activity, node )
{
    task = dmz_task_utils::task_create( activity );
    task.funcs[ "onInit" ] = &function_ad3a73b8be470893;
    task.funcs[ "onTeamStart" ] = &function_bca0daf35fbaa0e0;
    task.funcs[ "onPlayerJoined" ] = &function_30b994f69a4a8b11;
    task.funcs[ "onPlayerRemoved" ] = &function_ced8602ba7e1d6a4;
    task.funcs[ "onTeamAssigned" ] = &function_25ebed2ef8681514;
    task.ref = "dmz_safe_find";
    task.refindex = br_contract_manager::getquesttableindex( task.ref );
    task.node = node;
    return task;
}

// Namespace namespace_a7cd3da1542a2432
// Params 0
// Checksum 0x3759d19b, Offset: 0x5e7
// Size: 0x2f8
function function_ad3a73b8be470893()
{
    if ( !isdefined( self.node ) )
    {
        return;
    }
    
    self.safe = spawnscriptable( "dmz_safe", self.node.origin, self.node.angles );
    self.safe.task = self;
    self.capturetime = level.safeprops.capturetime;
    
    /#
        dmz_logging::addlogevent( "<dev string:x3f>", self.activity.name, undefined, "<dev string:x24>", undefined, undefined, self.activity.script_poi, self.node.origin );
    #/
    
    /#
        dmz_logging::addlogevent( "<dev string:x3f>", self.activity.name, undefined, "<dev string:x50>", undefined, undefined, self.activity.script_poi, self.node.origin );
    #/
    
    trigger = spawn( "trigger_radius", self.node.origin, 0, int( level.safeprops.captureradius ), int( level.safeprops.captureradius ) );
    trigger utility::trigger_off();
    self.trigger = trigger;
    
    /#
        dmz_logging::addlogevent( "<dev string:x5e>", self.activity.name, undefined, "<dev string:x6b>", undefined, undefined, self.activity.script_poi, self.node.origin );
    #/
    
    self.curorigin = self.node.origin;
    self.offset3d = ( 0, 0, 60 );
    gameobjects::requestid( 1, 1 );
    objidpoolmanager::update_objective_icon( self.objidnum, "ui_map_icon_obj_recover" );
    objidpoolmanager::update_objective_setbackground( self.objidnum, 4 );
    objidpoolmanager::objective_set_play_intro( self.objidnum, 1 );
    objidpoolmanager::objective_set_play_outro( self.objidnum, 0 );
    objidpoolmanager::objective_playermask_hidefromall( self.objidnum );
    objective_setshowprogress( self.objidnum, 1 );
    
    /#
        dmz_logging::addlogevent( "<dev string:x7a>", self.activity.name, undefined, "<dev string:x8c>", undefined, undefined, self.activity.script_poi, self.node.origin );
    #/
    
    function_2e1b492595a096dd( 2 );
    thread function_e3c86bdf8c768930();
    thread function_7f2498e71b0e60fd( trigger, level.safeprops.captureradius );
}

// Namespace namespace_a7cd3da1542a2432
// Params 1
// Checksum 0xda60bb1f, Offset: 0x8e7
// Size: 0x32
function function_25ebed2ef8681514( teamname )
{
    dmz_task_utils::task_showsplashtoteam( "dmz_safe_defend_assigned", teamname );
    dmz_audio::function_32ff837bc21a4833( teamname, "dmz_activity_start", 1.5, "dmz_activity_start_classic" );
}

// Namespace namespace_a7cd3da1542a2432
// Params 1
// Checksum 0xe91b27c0, Offset: 0x921
// Size: 0x28
function function_30b994f69a4a8b11( player )
{
    if ( self.started )
    {
        self.safe enablescriptableplayeruse( player );
    }
}

// Namespace namespace_a7cd3da1542a2432
// Params 1
// Checksum 0x2e19c2da, Offset: 0x951
// Size: 0x1c
function function_ced8602ba7e1d6a4( player )
{
    self.safe disablescriptableplayeruse( player );
}

// Namespace namespace_a7cd3da1542a2432
// Params 1
// Checksum 0xc6934a13, Offset: 0x975
// Size: 0xf1
function function_bca0daf35fbaa0e0( teamname )
{
    if ( self.safe getscriptablepartstate( "safe" ) == "waiting" )
    {
        self.safe setscriptablepartstate( "safe", "usable" );
    }
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) && isdefined( player.team ) && !arraycontains( self.teams, player.team ) )
        {
            self.safe disablescriptableplayeruse( player );
        }
    }
}

// Namespace namespace_a7cd3da1542a2432
// Params 1
// Checksum 0x85e9ac06, Offset: 0xa6e
// Size: 0xb3
function function_3882020ed4abad8a( teamname )
{
    gameobjects::releaseid();
    
    foreach ( team in self.teams )
    {
        dmz_task_utils::task_showsplashtoteam( "dmz_safe_defend_complete", teamname );
        dmz_audio::function_32ff837bc21a4833( teamname, "dmz_activity_win", 1.5, "dmz_activity_win_classic" );
    }
    
    waitframe();
    dmz_task_utils::task_ended( teamname );
}

// Namespace namespace_a7cd3da1542a2432
// Params 6
// Checksum 0x696412a5, Offset: 0xb29
// Size: 0x2d6
function function_ae6b49a1b1c968bf( instance, part, state, player, bautouse, usestring )
{
    if ( state == "usable" )
    {
        instance setscriptablepartstate( part, "unusable" );
        var_5acbc570e1ddad66 = arraycontains( instance.task.teams, player.team );
        
        foreach ( team in instance.task.teams )
        {
            instance.task dmz_task_utils::task_showsplashtoteam( "dmz_safe_defend_started", team );
        }
        
        if ( !var_5acbc570e1ddad66 )
        {
            instance.task dmz_task_utils::task_showsplashtoteam( "dmz_safe_defend_started", player.team );
        }
        
        waitframe();
        instance.task.trigger utility::trigger_on();
        instance.task dmz_task_utils::function_844c661c74b52ce3( "dmz_safe_defend" );
        
        if ( !var_5acbc570e1ddad66 )
        {
            instance.task.activity activity_manager::activity_assign( player.team, undefined, player );
        }
        
        foreach ( team in instance.task.teams )
        {
            if ( team == player.team )
            {
                br_dmz_extract::function_83a0b4b45262d77c( team, "dmz_mission_safe_opening" );
                dmz_audio::function_32ff837bc21a4833( team, "dmz_activity_action", 1, "dmz_activity_action_classic" );
                continue;
            }
            
            br_dmz_extract::function_83a0b4b45262d77c( team, "dmz_mission_safe_opening_other_team" );
        }
        
        return;
    }
    
    if ( state == "open_usable" )
    {
        if ( !isdefined( instance.contents ) )
        {
            instance.contents = function_ea8081e1bb5c69f5();
            instance.containertype = 4;
            common_cache::function_60ce579fa7d3b6da( instance, part, state, player, bautouse, usestring );
            instance.task function_3882020ed4abad8a( player.team );
            return;
        }
        
        common_cache::function_60ce579fa7d3b6da( instance, part, state, player, bautouse, usestring );
    }
}

// Namespace namespace_a7cd3da1542a2432
// Params 1, eflags: 0x4
// Checksum 0xdffbd08e, Offset: 0xe07
// Size: 0x2d3
function private function_2e1b492595a096dd( var_1a81764900af82ee )
{
    self.agents = [];
    forwarddist = anglestoforward( self.safe.angles ) * 80;
    origin = getclosestpointonnavmesh( self.safe.origin + forwarddist );
    agent = ai_mp_controller::ai_mp_requestspawnagent( ai_mp_controller::function_b86341658788836c( undefined, undefined, undefined, "short_range", undefined, 2 ), origin, self.safe.angles, "high", "mission", "safeInitialGuards", undefined, undefined, undefined, self.script_poi, 1 );
    
    if ( isdefined( agent ) )
    {
        self.agents[ 0 ] = agent;
        agent thread ai_behavior::behavior_GuardStationary( agent, 0 );
        
        if ( isagent( agent ) )
        {
            agent ai_behavior::function_4a3c03bb49dd5d76( origin, 64 );
            agent allowedstances( "stand" );
        }
    }
    
    for ( i = 0; i < var_1a81764900af82ee ; i++ )
    {
        agenttype = ai_mp_controller::function_b86341658788836c( undefined, undefined, undefined, "short_range" );
        var_48897c2c41f79f8 = randomfloatrange( 144, 360 );
        forward = anglestoforward( self.safe.angles ) * var_48897c2c41f79f8;
        right = vectorcross( ( 0, 0, 1 ), forward );
        facingangle = axistoangles( forward, right, ( 0, 0, 1 ) );
        rotationangle = i / var_1a81764900af82ee * 360 + randomfloatrange( -30, 30 ) % 360;
        offset = rotatepointaroundvector( ( 0, 0, 1 ), forward, rotationangle );
        origin = getclosestpointonnavmesh( self.safe.origin + offset );
        agent = ai_mp_controller::ai_mp_requestspawnagent( agenttype, origin, facingangle, "high", "mission", "safe", undefined, undefined, undefined, self.script_poi );
        
        if ( isdefined( agent ) )
        {
            self.agents[ self.agents.size ] = agent;
            agent thread ai_behavior::behavior_GuardStationary( agent );
        }
    }
    
    if ( isdefined( self.agents ) )
    {
        foreach ( agent in self.agents )
        {
            if ( isagent( agent ) )
            {
                agent.assignment = self.assignmentname;
            }
        }
    }
}

// Namespace namespace_a7cd3da1542a2432
// Params 0, eflags: 0x4
// Checksum 0xefec13b5, Offset: 0x10e2
// Size: 0x377
function private function_e3c86bdf8c768930()
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    self.progress = 0;
    var_1eda12d2d7580054 = 0;
    var_34b5ad0f0ab2605f = undefined;
    intervalindex = 0;
    alertradius = 512;
    helicalled = 0;
    shownplayers = [];
    
    while ( true )
    {
        if ( isdefined( self.trigger ) && !self.trigger.trigger_off )
        {
            if ( !isdefined( var_34b5ad0f0ab2605f ) )
            {
                var_34b5ad0f0ab2605f = [ 0, self.capturetime / 4, self.capturetime / 2, self.capturetime / 100 * 75 ];
            }
            
            if ( self.nearbyplayers.size > 0 )
            {
                progressbefore = self.progress;
                self.progress = min( self.capturetime, self.progress + level.framedurationseconds );
            }
            else
            {
                progressbefore = self.progress;
                self.progress = max( 0, self.progress - level.framedurationseconds * 2 );
            }
            
            shownplayers = function_1cb2f2a03dcd9bbb( self.nearbyplayers, shownplayers );
            objidpoolmanager::objective_set_progress( self.objidnum, self.progress / self.capturetime );
            
            if ( self.progress >= self.capturetime )
            {
                function_ad822ac4e07d48bd();
            }
            else if ( self.nearbyplayers.size > 0 && isdefined( var_34b5ad0f0ab2605f[ intervalindex ] ) && self.progress >= var_34b5ad0f0ab2605f[ intervalindex ] )
            {
                intervalindex++;
                alertradius += 768;
                
                if ( alertradius > 2816 )
                {
                    alertradius = 2816;
                }
                
                agents = ai_reinforcements::function_d0a9530035c6dc35( self.node.origin, alertradius, undefined, 3, undefined, 64, 128 );
                
                if ( isdefined( agents ) )
                {
                    self.agents = arraycombine( self.agents, agents );
                    var_1eda12d2d7580054 += agents.size;
                }
                
                if ( !helicalled && intervalindex == 1 && var_1eda12d2d7580054 < 4 )
                {
                    heliagents = ai_reinforcements::reinforce_requestreinforcements( 5, self.node.origin, "high", "mission", "safeReinforcements", undefined, undefined, 1, self.node.script_poi, "Helicopter", 32, 64, [ "shotgun" ] );
                    
                    if ( heliagents.size > 0 )
                    {
                        helicalled = 1;
                        self.agents = arraycombine( self.agents, heliagents );
                    }
                }
            }
            else if ( self.nearbyplayers.size == 0 && intervalindex > 0 )
            {
                intervalindex = 0;
                alertradius = 512;
                
                foreach ( agent in self.agents )
                {
                    agent.var_1e0ecc16c74773d8 = 0;
                }
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_a7cd3da1542a2432
// Params 2, eflags: 0x4
// Checksum 0x363fb929, Offset: 0x1461
// Size: 0x115
function private function_1cb2f2a03dcd9bbb( nearbyplayers, shownplayers )
{
    allplayers = arraycombine( nearbyplayers, shownplayers );
    
    foreach ( player in allplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !arraycontains( shownplayers, player ) && arraycontains( nearbyplayers, player ) )
        {
            objidpoolmanager::objective_pin_player( self.objidnum, player );
            objidpoolmanager::function_b3b969f2930890eb( 2, player );
            objidpoolmanager::function_9d3f184285ca25e4( &"mp_dmz_missions/opening_safe", player );
            continue;
        }
        
        if ( arraycontains( shownplayers, player ) && !arraycontains( nearbyplayers, player ) )
        {
            objidpoolmanager::objective_unpin_player( self.objidnum, player );
            objidpoolmanager::function_b3b969f2930890eb( 0, player );
        }
    }
    
    return nearbyplayers;
}

// Namespace namespace_a7cd3da1542a2432
// Params 0, eflags: 0x4
// Checksum 0x8d5cf9, Offset: 0x157f
// Size: 0x16c
function private function_ad822ac4e07d48bd()
{
    self.trigger delete();
    dmz_task_utils::function_2a90a77ea074c9c2( self.objidnum, self.teams );
    
    foreach ( agent in self.agents )
    {
        agent.var_1e0ecc16c74773d8 = 0;
    }
    
    foreach ( team in self.teams )
    {
        dmz_task_utils::task_showsplashtoteam( "dmz_safe_defend_unlocked", team );
        dmz_audio::function_32ff837bc21a4833( team, "dmz_activity_tension", 1, "dmz_activity_tension_classic" );
        br_dmz_extract::function_83a0b4b45262d77c( team, "dmz_mission_safe_unlocked" );
    }
    
    self.safe setscriptablepartstate( "safe", "open_usable" );
    dmz_task_utils::function_844c661c74b52ce3( "dmz_safe_loot" );
}

// Namespace namespace_a7cd3da1542a2432
// Params 2, eflags: 0x4
// Checksum 0x24660980, Offset: 0x16f3
// Size: 0x9b
function private function_7f2498e71b0e60fd( trigger, radius )
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    self.nearbyplayers = [];
    
    while ( true )
    {
        trigger waittill( #"trigger", player );
        
        if ( !isplayer( player ) || arraycontains( self.nearbyplayers, player ) )
        {
            continue;
        }
        
        self.nearbyplayers[ self.nearbyplayers.size ] = player;
        thread function_200af3825af2d750( trigger, player, radius );
    }
}

// Namespace namespace_a7cd3da1542a2432
// Params 0, eflags: 0x4
// Checksum 0x19bf4f76, Offset: 0x1796
// Size: 0x1bd
function private function_ea8081e1bb5c69f5()
{
    contents = [];
    var_42f1cbc85798693d = randomintrange( 50, 75 );
    contents[ 0 ][ "quantity" ] = var_42f1cbc85798693d;
    contents[ 0 ][ "lootID" ] = 8395;
    contents[ 1 ][ "quantity" ] = 125 - var_42f1cbc85798693d;
    contents[ 1 ][ "lootID" ] = 8395;
    
    if ( randomint( 2 ) > 0 )
    {
        contents[ 2 ][ "quantity" ] = 1;
        contents[ 2 ][ "lootID" ] = 9230;
    }
    else
    {
        contents[ 2 ][ "quantity" ] = 1;
        contents[ 2 ][ "lootID" ] = 9224;
    }
    
    randomint = randomint( 3 );
    
    if ( randomint == 0 )
    {
        contents[ 3 ][ "quantity" ] = 5;
        contents[ 3 ][ "lootID" ] = 9111;
    }
    else if ( randomint == 1 )
    {
        contents[ 3 ][ "quantity" ] = 1;
        contents[ 3 ][ "lootID" ] = 8548;
        contents[ 4 ][ "quantity" ] = 1;
        contents[ 4 ][ "lootID" ] = 8548;
    }
    else
    {
        contents[ 3 ][ "quantity" ] = 5;
        contents[ 3 ][ "lootID" ] = 8372;
    }
    
    if ( randomfloat( 1 ) < 0.2 )
    {
        randomint = randomint( 3 );
        index = contents.size;
        
        if ( randomint == 0 )
        {
            contents[ index ][ "quantity" ] = 1;
            contents[ index ][ "lootID" ] = 8089;
        }
        else if ( randomint == 1 )
        {
            contents[ index ][ "quantity" ] = 1;
            contents[ index ][ "lootID" ] = 3200;
        }
        else
        {
            contents[ index ][ "quantity" ] = 1;
            contents[ index ][ "lootID" ] = 2696;
        }
    }
    
    return arrayrandomize( contents );
}

// Namespace namespace_a7cd3da1542a2432
// Params 3, eflags: 0x4
// Checksum 0x8768236a, Offset: 0x195c
// Size: 0x7d
function private function_200af3825af2d750( trigger, player, radius )
{
    while ( isalive( player ) && isdefined( self.trigger ) && distance( trigger.origin, player.origin ) < radius * 1.2 )
    {
        wait 0.2;
    }
    
    self.nearbyplayers = arrayremove( self.nearbyplayers, player );
}

