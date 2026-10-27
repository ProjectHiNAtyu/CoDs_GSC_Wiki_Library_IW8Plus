// script_5d96636dc9c4a988  (hash_5d96636dc9c4a988.gscc) (size: 18600 Bytes / 0x48a8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfa79d696 (4202288790)
// size ...... 18600 (0x48a8)
// includes .. 19  (offset: 0x4374)
// strings ... 77  (offset: 0x440c)
// dev strs .. 2   (offset: 0x4890)
// exports ... 33  (offset: 0x2e00)
// cseg ...... 0x644 + 0x27bc (0x2e00)
// imports ... 131 (offset: 0x3328)
// animtree1 . 0   (offset: 0x48a8)
// animtree2 . 0   (offset: 0x48a8)
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\ai_reinforcements;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\common\utility\inventory;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dmz\gametypes\dmz_audio;
#using scripts\mp\dmz\gametypes\dmz_safes;
#using scripts\mp\dmz\gametypes\dmz_task_utils;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\juggernaut;
#using scripts\mp\objidpoolmanager;

#namespace namespace_996bfb64308a48f2;

// Namespace namespace_996bfb64308a48f2
// Params 1
// Checksum 0xc43d5e3b, Offset: 0x662
// Size: 0x40f
function dmztask_getspawndata( data )
{
    level.demoprops = spawnstruct();
    level.demoprops.explodetime = getdvarint( @"hash_5243a49d736c276a", 45 );
    level.demoprops.planttime = getdvarint( @"hash_4bdb410d2186f5ee", 5 );
    level.demoprops.defusetime = getdvarint( @"hash_b41d9e16b59e4339", 5 );
    level.demoprops.minagents = getdvarint( @"hash_a7d16b728a6465e6", 4 );
    level.demoprops.maxagents = getdvarint( @"hash_2f3b4e80c7494134", 7 );
    level.demoprops.reinforcesites = getdvarint( @"hash_331ed4c738fc999d", 0 );
    level._effect[ "samsite_bomb_explosion" ] = loadfxasset( "vfx_iw8_mp_gamemode_search_bombsite_destroy" );
    level._effect[ "bombsite_explosion" ] = loadfxasset( "vfx_iw9_dmz_bombsite_explo" );
    level._effect[ "bombsite_sparks" ] = loadfxasset( "vfx_iw9_dmz_bombsite_spark_trails_ch" );
    potentialnodes = arrayrandomize( utility::getstructarray( "dmz_supply_site", "script_noteworthy" ) );
    var_ac8d3d93754630a = [];
    
    foreach ( node in potentialnodes )
    {
        if ( !isdefined( var_ac8d3d93754630a[ node.script_poi ] ) )
        {
            var_ac8d3d93754630a[ node.script_poi ] = [];
        }
        
        var_ac8d3d93754630a[ node.script_poi ][ var_ac8d3d93754630a[ node.script_poi ].size ] = node;
    }
    
    level.var_6e4e8935bb1a0162 = [];
    
    foreach ( arr in var_ac8d3d93754630a )
    {
        foreach ( node in arr )
        {
            if ( node.inuse )
            {
                continue;
            }
            
            foreach ( othernode in arr )
            {
                if ( node == othernode )
                {
                    continue;
                }
                
                if ( othernode.inuse )
                {
                    continue;
                }
                
                distance = distancesquared( node.origin, othernode.origin );
                
                if ( distance < 4000000 || distance > 144000000 )
                {
                    continue;
                }
                
                node.end = othernode;
                node.inuse = 1;
                othernode.inuse = 1;
                level.var_6e4e8935bb1a0162[ level.var_6e4e8935bb1a0162.size ] = node;
            }
        }
    }
    
    scriptable::scriptable_addusedcallbackbypart( "dmz_supply_site_use", &function_f4070b023a4709ce );
    activity_manager::function_f61a1f535aab4194( data, &function_b2e1fc5b8c2846af, level.var_6e4e8935bb1a0162 );
}

/#

    // Namespace namespace_996bfb64308a48f2
    // Params 0
    // Checksum 0xdfc311fb, Offset: 0xa79
    // Size: 0x16, Type: dev
    function function_746bdfc760ec9b18()
    {
        return utility::getstructarray( "<dev string:x24>", "<dev string:x34>" );
    }

#/

// Namespace namespace_996bfb64308a48f2
// Params 2
// Checksum 0x6942c840, Offset: 0xa97
// Size: 0x169
function function_b2e1fc5b8c2846af( activity, node )
{
    task = dmz_task_utils::task_create( activity );
    task.funcs[ "onInit" ] = &function_ca74c9ff038a8723;
    task.funcs[ "onTeamStart" ] = &function_e8e7ef583fc5dd50;
    task.funcs[ "onTeamAssigned" ] = &function_1c36fa7acb972364;
    task.funcs[ "onPlayerJoined" ] = &function_3e55114368f5d13b;
    task.funcs[ "onPlayerRemoved" ] = &function_21935d45e942a4da;
    task.funcs[ "onCancel" ] = &function_94d15b979611c439;
    task.ref = "dmz_demo_first";
    task.refindex = br_contract_manager::getquesttableindex( task.ref );
    task.node = node;
    task.end = node.end;
    node.task = task;
    node.end.task = task;
    
    if ( !isdefined( level.var_6a9e0b94ba6ab536 ) )
    {
        level.var_6a9e0b94ba6ab536 = 0;
    }
    
    task.assignmentname = "demoMission" + level.var_6a9e0b94ba6ab536;
    level.var_6a9e0b94ba6ab536++;
    return task;
}

// Namespace namespace_996bfb64308a48f2
// Params 0
// Checksum 0xa1ef2f16, Offset: 0xc09
// Size: 0xd1
function function_ca74c9ff038a8723()
{
    self.teams = [];
    self.bombsplanted = 0;
    self.bombsexploded = 0;
    self.node function_bea22afc0c03cf03();
    self.end function_bea22afc0c03cf03();
    self.node thread function_154300f4bfb061b2( randomintrange( level.demoprops.minagents, level.demoprops.maxagents + 1 ) );
    self.end thread function_154300f4bfb061b2( randomintrange( level.demoprops.minagents, level.demoprops.maxagents + 1 ) );
    self.initialized = 1;
    self notify( #"task_initialized" );
}

// Namespace namespace_996bfb64308a48f2
// Params 1
// Checksum 0x30ba7824, Offset: 0xce2
// Size: 0x32
function function_e8e7ef583fc5dd50( teamname )
{
    self endon( #"task_ended" );
    
    if ( !self.initialized )
    {
        self waittill( #"task_initialized" );
    }
}

// Namespace namespace_996bfb64308a48f2
// Params 1
// Checksum 0xb99943d7, Offset: 0xd1c
// Size: 0xb2
function function_1c36fa7acb972364( teamname )
{
    self endon( #"task_ended" );
    
    if ( !self.initialized )
    {
        self waittill( #"task_initialized" );
    }
    
    self.node thread function_875082db5e00860e();
    self.end thread function_875082db5e00860e();
    thread function_29dc2c728959ae04();
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"demolition_assigned", teamname, 5 );
    thread function_c01220e3266a3b33( teamname );
    waitframe();
    dmz_task_utils::task_showsplashtoteam( "dmz_demo_accept", teamname );
    dmz_audio::function_32ff837bc21a4833( teamname, "dmz_activity_start", 1.5, "dmz_activity_start_classic" );
}

// Namespace namespace_996bfb64308a48f2
// Params 1
// Checksum 0xd8814eff, Offset: 0xdd6
// Size: 0xe6
function function_3e55114368f5d13b( player )
{
    foreach ( node in [ self.node, self.end ] )
    {
        node dmz_task_utils::function_dc6a173a36eef985( player );
        node dmz_task_utils::function_6277bd2a0d5a28b9( player );
        
        if ( isdefined( node.scriptable ) )
        {
            if ( node.bombplanted )
            {
                node.scriptable disablescriptableplayeruse( player );
                continue;
            }
            
            node.scriptable enablescriptableplayeruse( player );
        }
    }
}

// Namespace namespace_996bfb64308a48f2
// Params 1
// Checksum 0x22e04ee4, Offset: 0xec4
// Size: 0xe6
function function_21935d45e942a4da( player )
{
    foreach ( node in [ self.node, self.end ] )
    {
        node dmz_task_utils::function_d8d9112f1e68fa2b( player );
        node dmz_task_utils::function_1f01bb1108ba0241( player );
        
        if ( isdefined( node.scriptable ) )
        {
            if ( node.bombplanted )
            {
                node.scriptable enablescriptableplayeruse( player );
                continue;
            }
            
            node.scriptable disablescriptableplayeruse( player );
        }
    }
}

// Namespace namespace_996bfb64308a48f2
// Params 1
// Checksum 0x8dcbd3bb, Offset: 0xfb2
// Size: 0x146
function function_94d15b979611c439( team )
{
    players = teams::getteamdata( team, "players" );
    
    foreach ( player in players )
    {
        foreach ( node in [ self.node, self.end ] )
        {
            if ( isdefined( node.scriptable ) )
            {
                node.scriptable disablescriptableplayeruse( player );
            }
        }
    }
    
    self.failure = 1;
    dmztask_cleanup();
    dmz_task_utils::task_ended();
}

// Namespace namespace_996bfb64308a48f2
// Params 0
// Checksum 0xa7595615, Offset: 0x1100
// Size: 0x22
function dmztask_cleanup()
{
    self.node cleanupbombsite();
    self.end cleanupbombsite();
}

// Namespace namespace_996bfb64308a48f2
// Params 1
// Checksum 0xc1907c24, Offset: 0x112a
// Size: 0xbb
function function_253bc25a74affa1a( teamname )
{
    self notify( #"task_ended" );
    players = teams::getteamdata( self.teams[ 0 ], "players" );
    
    foreach ( player in players )
    {
        objidpoolmanager::function_b3b969f2930890eb( 0, player );
    }
    
    dmztask_cleanup();
    dmz_task_utils::task_ended( teamname );
}

// Namespace namespace_996bfb64308a48f2
// Params 0
// Checksum 0x3d58a16f, Offset: 0x11ed
// Size: 0x17d
function function_29dc2c728959ae04()
{
    self endon( #"task_ended" );
    avgpos = ( 0, 0, 0 );
    playercount = 0;
    playersonteam = teams::getteamdata( self.teams[ 0 ], "players" );
    var_cb34383eb0b8e0a6 = undefined;
    
    foreach ( player in playersonteam )
    {
        playercount++;
        avgpos += player.origin;
    }
    
    if ( playercount > 0 )
    {
        avgpos /= playercount;
        var_cb34383eb0b8e0a6 = sortbydistance( [ self.node, self.end ], avgpos )[ 0 ];
    }
    
    self.node childthread activity_manager::function_57f52e88c7a82e87( self.teams[ 0 ], self.activity.var_48423c6dad66d9c3, self.node == var_cb34383eb0b8e0a6 );
    self.end childthread activity_manager::function_57f52e88c7a82e87( self.teams[ 0 ], self.activity.var_48423c6dad66d9c3, self.end == var_cb34383eb0b8e0a6 );
}

// Namespace namespace_996bfb64308a48f2
// Params 0
// Checksum 0x65ee34ff, Offset: 0x1372
// Size: 0x26
function function_bea22afc0c03cf03()
{
    self.site = spawnscriptable( "dmz_supply_site", self.origin, self.angles );
}

// Namespace namespace_996bfb64308a48f2
// Params 1
// Checksum 0xc5858850, Offset: 0x13a0
// Size: 0x1f3
function function_154300f4bfb061b2( numagents )
{
    basetier = utility::callsharedfunc( #"poi", #"hash_7f732c09fb6c538d", self.origin );
    aitype = ai_mp_controller::function_b86341658788836c( undefined, undefined, undefined, "short_range", undefined, basetier + 1 );
    forwarddist = anglestoforward( self.angles ) * 80;
    origin = getclosestpointonnavmesh( self.origin + forwarddist );
    agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, origin, self.angles, "high", "mission", "safeInitialGuards", undefined, undefined, undefined, self.script_poi, 0, undefined, 1 );
    
    if ( isdefined( agent ) )
    {
        thread ai_behavior::behavior_GuardStationary( agent, 0 );
    }
    
    for ( i = 0; i < numagents ; i++ )
    {
        aitype = ai_mp_controller::function_b86341658788836c( undefined, undefined, undefined, undefined, undefined, basetier );
        var_48897c2c41f79f8 = randomfloatrange( 144, 360 );
        forward = anglestoforward( self.angles ) * var_48897c2c41f79f8;
        right = vectorcross( ( 0, 0, 1 ), forward );
        facingangle = axistoangles( forward, right, ( 0, 0, 1 ) );
        rotationangle = i / numagents * 360 + randomfloatrange( -30, 30 ) % 360;
        offset = rotatepointaroundvector( ( 0, 0, 1 ), forward, rotationangle );
        origin = getclosestpointonnavmesh( self.origin + offset );
        agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, origin, facingangle, "high", "mission", "demo", undefined, undefined, undefined, self.script_poi, 0, undefined, 0 );
        
        if ( isdefined( agent ) )
        {
            thread ai_behavior::behavior_GuardStationary( agent );
        }
    }
}

// Namespace namespace_996bfb64308a48f2
// Params 1
// Checksum 0xe8a6a4d4, Offset: 0x159b
// Size: 0xc1
function function_51fae156c80324e1( time )
{
    thread function_7637d201a97aa484( time );
    starttime = gettime();
    offset = level.demoprops.defusetime;
    totaltime = time + offset;
    self.plantedbomb thread playtickingsound( time, offset );
    self.timeremaining = totaltime;
    
    while ( true )
    {
        currenttime = gettime();
        duration = ( currenttime - starttime ) / 1000;
        self.timeremaining = totaltime - duration;
        
        if ( self.timeremaining <= 0 )
        {
            self notify( #"bomb_exploded" );
            break;
        }
        
        waitframe();
    }
}

// Namespace namespace_996bfb64308a48f2
// Params 0
// Checksum 0xf5b3d745, Offset: 0x1664
// Size: 0x218
function function_631a5aeec9fb814a()
{
    if ( isdefined( self.plantedbomb ) )
    {
        effect = "samsite_bomb_explosion";
        explosionpos = self.plantedbomb.origin + ( 0, 0, 50 );
        explosioneffect = spawnfx( level._effect[ effect ], explosionpos );
        explosioneffect thread utility::delete_after_delay( 10 );
        triggerfx( explosioneffect );
        physicsexplosionsphere( explosionpos, 200, 100, 3 );
        playrumbleonposition( "grenade_rumble", self.plantedbomb.origin );
        earthquake( 0.25, 0.5, self.plantedbomb.origin, 500 );
        playsoundatpos( explosionpos, "exp_bombsite_lr" );
        self.plantedbomb radiusdamage( self.origin + ( 0, 0, 50 ), 350, 500, 10, self.plantedbomb, undefined, undefined, undefined, 0 );
        
        if ( isdefined( self.site ) )
        {
            wait 0.25;
            effect = "bombsite_explosion";
            explosionpos = self.site.origin;
            explosioneffect = spawnfx( level._effect[ effect ], explosionpos );
            explosioneffect thread utility::delete_after_delay( 10 );
            triggerfx( explosioneffect );
            physicsexplosionsphere( explosionpos, 200, 100, 3 );
            playrumbleonposition( "grenade_rumble", self.site.origin );
            earthquake( 0.75, 2, self.site.origin, 2000 );
            self.plantedbomb radiusdamage( self.origin + ( 0, 0, 50 ), 750, 500, 10, self.plantedbomb );
            self.site setscriptablepartstate( "dmz_supply_site", "destroyed" );
            wait 0.05;
            self.plantedbomb delete();
        }
    }
}

// Namespace namespace_996bfb64308a48f2
// Params 1, eflags: 0x4
// Checksum 0xa1d6f75a, Offset: 0x1884
// Size: 0x2fd
function private function_aa455168130d5589( time )
{
    level endon( #"game_ended" );
    self.task endon( #"task_ended" );
    self endon( #"bomb_defused" );
    
    /#
        sphere( self.origin + ( 0, 0, 50 ), 600, ( 1, 0, 0 ), 1, 100000 );
    #/
    
    function_51fae156c80324e1( time );
    
    foreach ( team in self.task.teams )
    {
        objective_hideprogressforteam( self.icon, team );
    }
    
    function_631a5aeec9fb814a();
    wait 0.1;
    self.task.bombsexploded++;
    cleanupbombsite();
    team = self.task.teams[ 0 ];
    
    if ( self.task.bombsexploded == 2 )
    {
        thread dmz_safes::function_e9840b595c7ed453( team, self.origin );
        utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"demolition_second_exploded", team, 1.5 );
        
        if ( getdvarint( @"hash_e9a3f2805d0f46b8", 1 ) )
        {
            utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"hash_8bd2785f5b1c0e7f", team, 4.5 );
        }
        else
        {
            utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"demolition_safe_reward_intel", team, 4.5 );
        }
        
        dmz_audio::function_32ff837bc21a4833( team, "dmz_activity_win", 1.5, "dmz_activity_win_classic" );
        self.task dmz_task_utils::function_e533421ccebd7d79( team );
        self.task dmz_task_utils::function_c64a66646904bc1( "dmz_demo_win", "demo", self.task.activity.cashreward, team );
        self.task thread function_253bc25a74affa1a( team );
        return;
    }
    
    if ( self.task.bombsexploded == 1 )
    {
        utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"demolition_first_exploded", team, 1.5 );
        self.task dmz_task_utils::task_showsplashtoteam( "dmz_demo_first_explosion", team );
        
        if ( self.task.bombsplanted == 1 )
        {
            dmz_audio::function_32ff837bc21a4833( team, "dmz_activity_start", 1.5, "dmz_activity_start_classic" );
        }
    }
}

// Namespace namespace_996bfb64308a48f2
// Params 0
// Checksum 0xc319b2dd, Offset: 0x1b89
// Size: 0x134
function function_59ce7cab39380115()
{
    self.scriptable setscriptablepartstate( "dmz_supply_site_use", "usable", 0 );
    
    foreach ( player in level.players )
    {
        self.scriptable disablescriptableplayeruse( player );
    }
    
    playersonteam = teams::getteamdata( self.task.teams[ 0 ], "players" );
    
    foreach ( player in playersonteam )
    {
        self.scriptable enablescriptableplayeruse( player );
    }
}

// Namespace namespace_996bfb64308a48f2
// Params 0
// Checksum 0xf1b30db9, Offset: 0x1cc5
// Size: 0x42
function function_d84ad5ba8f4cdd78()
{
    self.scriptable = spawnscriptable( "dmz_supply_site_use", self.origin, self.angles );
    self.scriptable.node = self;
    function_59ce7cab39380115();
}

// Namespace namespace_996bfb64308a48f2
// Params 0
// Checksum 0xe6750ca5, Offset: 0x1d0f
// Size: 0x133
function function_571b5b0f62609d77()
{
    self.scriptable setscriptablepartstate( "dmz_supply_site_use", "defusable" );
    
    foreach ( player in level.players )
    {
        self.scriptable enablescriptableplayeruse( player );
    }
    
    playersonteam = teams::getteamdata( self.task.teams[ 0 ], "players" );
    
    foreach ( player in playersonteam )
    {
        self.scriptable disablescriptableplayeruse( player );
    }
}

// Namespace namespace_996bfb64308a48f2
// Params 0
// Checksum 0x18d57307, Offset: 0x1e4a
// Size: 0x30
function function_f7ecfb4306cc27de()
{
    self.scriptable.origin = self.plantedbomb.origin;
    function_571b5b0f62609d77();
}

// Namespace namespace_996bfb64308a48f2
// Params 0
// Checksum 0x93843f4, Offset: 0x1e82
// Size: 0x271
function function_875082db5e00860e()
{
    function_d84ad5ba8f4cdd78();
    self.curorigin = self.origin;
    self.offset3d = ( 0, 0, 100 );
    dmz_task_utils::function_b3476f99a8e21fa2( self.origin + self.offset3d, "sabotage" );
    dmz_task_utils::function_ca73a4f7b8d7aacb( "Hostage_Dmz", self.origin, 1000 );
    dmz_task_utils::function_18b83232055b1325( self.task.teams[ 0 ] );
    self waittill( #"bomb_planted" );
    self.task.bombsplanted++;
    objective_position( self.icon, self.plantedbomb.origin + ( 0, 0, 50 ) );
    playersonteam = teams::getteamdata( self.task.teams[ 0 ], "players" );
    
    if ( self.task.bombsplanted == 2 )
    {
        utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"demolition_second_plant", self.plantplayer.team );
        self.task dmz_task_utils::function_844c661c74b52ce3( "dmz_demo_defend" );
    }
    else if ( self.task.bombsplanted == 1 )
    {
        utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"demolition_first_plant", self.plantplayer.team );
        self.task dmz_task_utils::function_844c661c74b52ce3( "dmz_demo_second" );
    }
    
    function_f7ecfb4306cc27de();
    thread function_36619bc368b76dc6();
    thread function_aa455168130d5589( level.demoprops.explodetime );
    dmz_audio::function_32ff837bc21a4833( self.task.teams[ 0 ], "dmz_activity_action", 0, "dmz_activity_action_classic" );
    
    if ( level.demoprops.reinforcesites )
    {
        self.stolenagents = ai_reinforcements::function_d0a9530035c6dc35( self.plantedbomb.origin, 2048, undefined, 10 );
        
        if ( self.stolenagents.size < 5 )
        {
            thread callreinforcements();
        }
    }
}

// Namespace namespace_996bfb64308a48f2
// Params 6
// Checksum 0xc92abc81, Offset: 0x20fb
// Size: 0x410
function function_f4070b023a4709ce( instance, part, state, player, bautouse, usestring )
{
    if ( part != "dmz_supply_site_use" )
    {
        return;
    }
    
    if ( state == "usable" )
    {
        instance setscriptablepartstate( "dmz_supply_site_use", "unusable" );
        node = instance.node;
        task = node.task;
        
        if ( node.planting )
        {
            return;
        }
        
        node.planting = 1;
        bomb = function_183e57e00b1d1dd0( player );
        thread dmz_task_utils::task_watchcancel( node, node, player );
        buttontime = 0;
        
        while ( buttontime < level.demoprops.planttime )
        {
            if ( node.cancel || task.failure || !player::isaliveandnotinlaststand( player ) )
            {
                node.planting = 0;
                function_915debdf87f515ac( player, bomb );
                
                if ( !task.failure )
                {
                    node function_59ce7cab39380115();
                }
                
                return;
            }
            
            buttontime += level.framedurationseconds;
            waitframe();
        }
        
        origin = player.origin;
        function_915debdf87f515ac( player, bomb );
        
        if ( task.failure )
        {
            return;
        }
        
        bombent = spawn( "script_model", origin );
        bombent setmodel( "offhand_2h_wm_briefcase_bomb_v0" );
        bombent.visuals = [];
        bombent.visuals[ 0 ] = spawn( "script_model", origin );
        bombent.visuals[ 0 ] setmodel( "tag_origin" );
        bombent.curorigin = origin;
        bombent.offset3d = ( 0, 0, 15 );
        bombent.safeorigin = origin;
        bombent.trigger = spawnstruct();
        bombent.icon = -1;
        bombent.owner = player;
        bombent gameobjects::setdropped( undefined, undefined, 1 );
        node.plantedbomb = bombent;
        node.plantedbomb.node = node;
        node.bombplanted = 1;
        node.plantplayer = player;
        node notify( #"bomb_planted" );
        return;
    }
    
    if ( state == "defusable" )
    {
        instance setscriptablepartstate( "dmz_supply_site_use", "unusable" );
        node = instance.node;
        task = node.task;
        
        if ( node.defusing )
        {
            return;
        }
        
        node.defusing = 1;
        node.plantedbomb hide();
        bomb = function_183e57e00b1d1dd0( player );
        thread dmz_task_utils::task_watchcancel( node, node, player );
        buttontime = 0;
        
        while ( buttontime < level.demoprops.defusetime )
        {
            if ( node.cancel || !player::isaliveandnotinlaststand( player ) || task.failure || player.fauxdeath )
            {
                node.defusing = 0;
                function_915debdf87f515ac( player, bomb );
                node.plantedbomb show();
                
                if ( !task.failure )
                {
                    node function_571b5b0f62609d77();
                }
                
                return;
            }
            
            buttontime += level.framedurationseconds;
            waitframe();
        }
        
        if ( task.failure )
        {
            function_915debdf87f515ac( player, bomb );
            return;
        }
        
        node notify( #"bomb_defused" );
        node.defuseplayer = player;
        function_915debdf87f515ac( player, bomb );
        node.plantedbomb show();
    }
}

// Namespace namespace_996bfb64308a48f2
// Params 0, eflags: 0x4
// Checksum 0xbf4e884, Offset: 0x2513
// Size: 0x20e
function private function_36619bc368b76dc6()
{
    level endon( #"game_ended" );
    self.task endon( #"task_ended" );
    self endon( #"bomb_exploded" );
    self waittill( #"bomb_defused" );
    self.scriptable freescriptable();
    defuseteam = self.defuseplayer.team;
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"demolition_defused_others", defuseteam, 1.5 );
    self.task dmz_task_utils::function_c64a66646904bc1( "dmz_demo_defused_win", "demo", self.task.activity.cashreward, defuseteam );
    dmz_audio::function_32ff837bc21a4833( defuseteam, "dmz_activity_win", 1.5, "dmz_activity_win_classic" );
    thread dmz_safes::function_e9840b595c7ed453( defuseteam, self.origin );
    
    if ( getdvarint( @"hash_671f3af465d66ff7", 0 ) )
    {
        utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"hash_8bd2785f5b1c0e7f", defuseteam, 4.5 );
    }
    else
    {
        utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"demolition_safe_reward_intel", defuseteam, 4.5 );
    }
    
    planterteam = self.task.teams[ 0 ];
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"demolition_defused", planterteam, 1.5 );
    self.task dmz_task_utils::function_c64a66646904bc1( "dmz_demo_defused_lose", "demo", 0, planterteam );
    dmz_audio::function_32ff837bc21a4833( planterteam, "dmz_activity_lose", 1, "dmz_activity_lose_classic" );
    self.task dmz_task_utils::function_e533421ccebd7d79( defuseteam );
    self.task thread function_253bc25a74affa1a( undefined );
    wait 10;
    self.plantedbomb delete();
}

// Namespace namespace_996bfb64308a48f2
// Params 1
// Checksum 0x1a15153d, Offset: 0x2729
// Size: 0x54
function function_7637d201a97aa484( timer )
{
    level endon( #"game_ended" );
    self.task endon( #"task_ended" );
    self endon( #"bomb_defused" );
    wait timer;
    self.scriptable setscriptablepartstate( "dmz_supply_site_use", "unusable", 0 );
}

// Namespace namespace_996bfb64308a48f2
// Params 1
// Checksum 0x5b20dcba, Offset: 0x2785
// Size: 0x5a
function function_183e57e00b1d1dd0( player )
{
    player function_5531e6d8f26f905f( 0 );
    bomb = makeweapon( "briefcase_bomb_mp" );
    player inventory_utility::_giveweapon( bomb, undefined, undefined, 0 );
    player setweaponammostock( bomb, 0 );
    player setweaponammoclip( bomb, 0 );
    player thread gameobjects::switchtouseweapon( bomb, 1, 1 );
    return bomb;
}

// Namespace namespace_996bfb64308a48f2
// Params 2
// Checksum 0x7b01cabc, Offset: 0x27e8
// Size: 0x74
function function_915debdf87f515ac( player, bomb )
{
    lastweaponobj = player inventory::getlastweapon();
    
    if ( player killstreak::isjuggernaut() )
    {
        lastweaponobj = juggernaut::jugg_getminigunweapon();
    }
    else if ( !player hasweapon( lastweaponobj ) )
    {
        lastweaponobj = player inventory::getfirstprimaryweapon();
    }
    
    player inventory_utility::domonitoredweaponswitch( lastweaponobj, 0, 1 );
    player takeweapon( bomb );
    player function_5531e6d8f26f905f( 1 );
}

// Namespace namespace_996bfb64308a48f2
// Params 0
// Checksum 0xae0c97f9, Offset: 0x2864
// Size: 0x79
function callreinforcements()
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    self endon( #"bomb_exploded" );
    agents = undefined;
    
    while ( !isdefined( agents ) )
    {
        agents = ai_reinforcements::reinforce_requestreinforcements( 5, self.origin, "medium", "mission", "demoReinforcements", undefined, undefined, 1, self.script_poi );
        
        if ( !isdefined( agents ) )
        {
            wait 1;
        }
    }
}

// Namespace namespace_996bfb64308a48f2
// Params 1, eflags: 0x4
// Checksum 0x2ad4f79d, Offset: 0x28e5
// Size: 0x16f
function private function_5531e6d8f26f905f( isallowed )
{
    val::set( "sam_holding_bomb", "allow_movement", isallowed );
    val::set( "sam_holding_bomb", "sprint", isallowed );
    val::set( "sam_holding_bomb", "fire", isallowed );
    val::set( "sam_holding_bomb", "reload", isallowed );
    val::set( "sam_holding_bomb", "weapon_pickup", isallowed );
    val::set( "sam_holding_bomb", "weapon_switch", isallowed );
    val::set( "sam_holding_bomb", "allow_jump", isallowed );
    val::set( "sam_holding_bomb", "gesture", isallowed );
    val::set( "sam_holding_bomb", "supers", isallowed );
    val::set( "sam_holding_bomb", "vehicle_use", isallowed );
    val::set( "sam_holding_bomb", "vehicle_lean_out", isallowed );
    val::set( "sam_holding_bomb", "vehicle_seat_switch", isallowed );
    val::set( "sam_holding_bomb", "ascender_use", isallowed );
    self function_60e112d2e106b00a();
    
    if ( isallowed )
    {
        utility::waittill_any_timeout( 0.8, "bomb_allow_offhands" );
    }
    
    val::set( "sam_holding_bomb", "melee", isallowed );
    val::set( "sam_holding_bomb", "mantle", isallowed );
    val::set( "sam_holding_bomb", "offhand_weapons", isallowed );
    
    if ( isallowed )
    {
        val::reset_all( "sam_holding_bomb" );
        self function_7d73d6786e51ae1f();
    }
}

// Namespace namespace_996bfb64308a48f2
// Params 2
// Checksum 0xdc1657d9, Offset: 0x2a5c
// Size: 0x1af
function playtickingsound( time, offset )
{
    self endon( #"death" );
    self endon( #"stop_ticking" );
    level endon( #"game_ended" );
    self.node endon( #"bomb_exploded" );
    self.node endon( #"bomb_defused" );
    self.node.task endon( #"task_ended" );
    time *= 1000;
    offset *= 1000;
    currenttime = gettime();
    bombendtime = currenttime + time + offset;
    var_f4f3f0356fef8102 = bombendtime - currenttime;
    
    while ( var_f4f3f0356fef8102 > 0 )
    {
        currenttime = gettime();
        var_f4f3f0356fef8102 = bombendtime - currenttime;
        
        if ( var_f4f3f0356fef8102 <= 0 + offset )
        {
            if ( var_f4f3f0356fef8102 <= 250 )
            {
                if ( soundexists( "dmz_bombsite_warning_beep_05" ) )
                {
                    self playsound( "dmz_bombsite_warning_beep_05" );
                }
            }
            else if ( var_f4f3f0356fef8102 <= 750 )
            {
                if ( soundexists( "dmz_bombsite_warning_beep_04" ) )
                {
                    self playsound( "dmz_bombsite_warning_beep_04" );
                }
            }
            else if ( var_f4f3f0356fef8102 <= 1500 )
            {
                if ( soundexists( "dmz_bombsite_warning_beep_03" ) )
                {
                    self playsound( "dmz_bombsite_warning_beep_03" );
                }
            }
            else if ( soundexists( "dmz_bombsite_warning_beep_02" ) )
            {
                self playsound( "dmz_bombsite_warning_beep_02" );
            }
            
            wait 0.25;
            continue;
        }
        
        if ( var_f4f3f0356fef8102 <= 10000 + offset )
        {
            if ( soundexists( "dmz_bombsite_warning_beep_02" ) )
            {
                self playsound( "dmz_bombsite_warning_beep_02" );
            }
            
            wait 0.5;
            continue;
        }
        
        if ( soundexists( "dmz_bombsite_warning_beep_01" ) )
        {
            self playsound( "dmz_bombsite_warning_beep_01" );
        }
        
        wait 1;
    }
}

// Namespace namespace_996bfb64308a48f2
// Params 1, eflags: 0x4
// Checksum 0xea74a62a, Offset: 0x2c13
// Size: 0x1ba
function private function_c01220e3266a3b33( team )
{
    self endon( #"task_ended" );
    var_5b6aaf11f8a8ef15 = 9000000;
    var_49ee60b444580537 = 90000;
    var_934391bb5ffe0db7 = 0;
    
    while ( true )
    {
        players = teams::getteamdata( team, "players" );
        mindistsq = 10000000000;
        
        foreach ( player in players )
        {
            if ( !player player::isreallyalive() )
            {
                continue;
            }
            
            distsq = distance2dsquared( self.node.origin, player.origin );
            
            if ( mindistsq > distsq )
            {
                mindistsq = distsq;
            }
        }
        
        if ( !var_934391bb5ffe0db7 && mindistsq < var_5b6aaf11f8a8ef15 )
        {
            utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"demolition_near", team );
            dmz_audio::function_32ff837bc21a4833( team, "dmz_activity_tension", 0, "dmz_activity_tension_classic" );
            var_934391bb5ffe0db7 = 1;
        }
        
        if ( mindistsq < var_49ee60b444580537 )
        {
            utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"demolition_approach", team );
            dmz_audio::function_32ff837bc21a4833( team, "dmz_activity_tension", 0, "dmz_activity_tension_classic" );
            return;
        }
        
        wait 1;
    }
}

// Namespace namespace_996bfb64308a48f2
// Params 0
// Checksum 0x99cf21d5, Offset: 0x2dd5
// Size: 0x2b
function cleanupbombsite()
{
    dmz_task_utils::function_3ff46488beb193c7();
    dmz_task_utils::function_e23cad864e9e2023();
    
    if ( isdefined( self.scriptable ) )
    {
        self.scriptable freescriptable();
    }
}

