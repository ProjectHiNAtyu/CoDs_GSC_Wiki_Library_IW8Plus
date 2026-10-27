// script_72af5a878a9d3397  (hash_72af5a878a9d3397.gscc) (size: 31013 Bytes / 0x7925 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x85f52adb (2247437019)
// size ...... 31013 (0x7925)
// includes .. 14  (offset: 0x6e01)
// strings ... 178 (offset: 0x6e71)
// dev strs .. 9   (offset: 0x78b9)
// exports ... 77  (offset: 0x4b21)
// cseg ...... 0x8fd + 0x4224 (0x4b21)
// imports ... 164 (offset: 0x5729)
// animtree1 . 0   (offset: 0x7925)
// animtree2 . 0   (offset: 0x7925)
#using script_2444b97a3516cbb0;
#using script_26ccbfe3954cacf4;
#using script_d74ae0b4aa21186;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\bots\bots_util;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\bots\bots_gametype_br_super;
#using scripts\mp\bots\bots_gametype_super_shared;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\game_utility;

#namespace namespace_ddca46d216b096e2;

// Namespace namespace_ddca46d216b096e2
// Params 0, eflags: 0x5
// Checksum 0xe2f653, Offset: 0x91b
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_8cb8ba48ea6f1008", undefined, undefined, &postmain );
}

// Namespace namespace_ddca46d216b096e2
// Params 0
// Checksum 0x45409119, Offset: 0x93c
// Size: 0x1b
function postmain()
{
    initialize();
    
    if ( !isenabled() )
    {
        return;
    }
    
    thread onStartGameTypeFinished();
}

// Namespace namespace_ddca46d216b096e2
// Params 0, eflags: 0x4
// Checksum 0x733084d0, Offset: 0x95f
// Size: 0x225
function private initialize()
{
    var_b104e1144c93d5 = getdvarint( @"scr_bots_behavior_analyzer_enabled", 0 );
    
    if ( var_b104e1144c93d5 && !isdefined( level.mapcorners ) )
    {
        logstring( "ERROR: scr_bots_behavior_analyzer_enabled is enabled but BBA will not be functional because level.mapCorners are not defined. Disabling BBA." );
        setdvar( @"scr_bots_behavior_analyzer_enabled", 0 );
        var_b104e1144c93d5 = 0;
    }
    
    logstring( "Initialize BBA: enabled = " + var_b104e1144c93d5 );
    
    if ( !var_b104e1144c93d5 )
    {
        return;
    }
    
    level.var_9bffc1c7425dcc18 = spawnstruct();
    level.var_9bffc1c7425dcc18.var_dcc5d33aff6c5500 = getdvarint( @"hash_cdd059b09c8bb733", 5 );
    level.var_9bffc1c7425dcc18.var_ff700063b6b1ca71 = getdvarint( @"hash_9ee63ccca325c7f", 10 );
    level.var_9bffc1c7425dcc18.players = [];
    level.var_9bffc1c7425dcc18.var_33f298d178d0c62c = getdvarint( @"hash_f1872e31a04a0a3b", 0 );
    level.var_9bffc1c7425dcc18.var_4c6574d1c68ecce8 = getdvarint( @"hash_c927497e5000d3d3", 0 );
    level.var_9bffc1c7425dcc18.var_5ba95c7590874925 = 0;
    level.var_9bffc1c7425dcc18.agents = [];
    level.var_9bffc1c7425dcc18.var_9cc231b1436a4b5b = 0;
    level.var_9bffc1c7425dcc18.runtimedisabled = 0;
    level.var_9bffc1c7425dcc18.var_2658a65dbe161c9f = [ "giveLoadout", "weapon_change", "pickedupweapon" ];
    level.var_9bffc1c7425dcc18.playerevents = [ "enter_gulag", "gulag_end", "pull_out_of_gulag", "initPlayerArena", "gulagRespawn", "gulag_auto_win" ];
    botsbehavioranalyzerinitialize();
    headerstr = "Header log_version=" + 28 + ";anchorTime=" + gettime();
    botsbehavioranalyzerlog( headerstr, 0 );
    function_ddaf81252fb5aa23( level.script, level.mapcorners );
    function_11b5b9fe7619787f();
}

// Namespace namespace_ddca46d216b096e2
// Params 1
// Checksum 0x610c3bba, Offset: 0xb8c
// Size: 0x24, Type: bool
function function_416aca1f95e3970e( flag )
{
    return ( level.var_9bffc1c7425dcc18.var_33f298d178d0c62c & flag ) != 0;
}

// Namespace namespace_ddca46d216b096e2
// Params 0, eflags: 0x4
// Checksum 0x43c0008a, Offset: 0xbb9
// Size: 0x16
function private onStartGameTypeFinished()
{
    level utility::flag_wait( "onStartGameTypeFinished" );
    start();
}

// Namespace namespace_ddca46d216b096e2
// Params 0, eflags: 0x4
// Checksum 0xeb34413e, Offset: 0xbd7
// Size: 0xbf
function private start()
{
    loggamestarted();
    thread function_bcf38177f0966103();
    thread function_45aeadafe3cb6396();
    thread function_7f9e62e6d7edd9e0();
    function_faa7337679cc3bb8( 1 );
    
    if ( manager::isenabled() && function_416aca1f95e3970e( 2 ) )
    {
        thread function_f016559dc4437d00();
    }
    
    if ( isbrgamemode() )
    {
        thread function_66df94be1e669a0f();
        
        if ( level.br_pe_enabled )
        {
            utility::registersharedfunc( #"gametype", #"onpublicevent", &logpublicevent );
        }
        
        utility::registersharedfunc( #"gametype", #"onplayerteleport", &onplayerteleport );
        
        if ( !level.br_circle_disabled )
        {
            thread function_f33506b0dd5e645b();
        }
    }
    
    if ( function_416aca1f95e3970e( 16 ) )
    {
        thread function_12b9ec375968d26d();
    }
}

// Namespace namespace_ddca46d216b096e2
// Params 0, eflags: 0x4
// Checksum 0x8380bfa4, Offset: 0xc9e
// Size: 0xe5
function private function_66df94be1e669a0f()
{
    level endon( #"game_ended" );
    level endon( #"hash_776de611ecfe9598" );
    
    if ( level.var_9bffc1c7425dcc18.var_9cc231b1436a4b5b || function_a82e8ac40cc433f() )
    {
        level.var_9bffc1c7425dcc18.var_9cc231b1436a4b5b = 1;
        return;
    }
    
    while ( true )
    {
        msg = level utility::waittill_any_in_array_or_timeout( [ "prematch_over" ], 5 );
        
        if ( level.var_9bffc1c7425dcc18.var_9cc231b1436a4b5b )
        {
            return;
        }
        
        if ( msg == "prematch_over" )
        {
            if ( function_a82e8ac40cc433f() )
            {
                level.var_9bffc1c7425dcc18.var_9cc231b1436a4b5b = 1;
                return;
            }
            
            level.var_9bffc1c7425dcc18.runtimedisabled = 1;
            function_faa7337679cc3bb8( 0 );
            level notify( #"hash_776de611ecfe9598" );
            return;
        }
    }
}

// Namespace namespace_ddca46d216b096e2
// Params 1, eflags: 0x4
// Checksum 0xf153433, Offset: 0xd8b
// Size: 0x220
function private function_faa7337679cc3bb8( register )
{
    if ( register )
    {
        callback::add( #"player_spawned", &onentityspawned );
        callback::add( #"player_damaged", &onentitydamaged );
        callback::add( #"player_death", &onplayerdeath );
        callback::add( #"player_laststand", &onplayerlaststand );
        callback::add( "on_zombie_ai_spawned", &onentityspawned );
        callback::add( "on_zombie_ai_killed", &onagentkilled );
        callback::add( #"on_ai_damaged", &onentitydamaged );
        callback::add( #"on_spawn_agent", &onentityspawned );
        callback::add( #"on_ai_killed", &onagentkilled );
        
        if ( utility::flag( "ai_spawn_director_initialized" ) )
        {
            ai_spawn_director::function_c83497dcedebe189( &function_e3ef90e403109610 );
        }
        
        if ( isdefined( level.mind ) )
        {
            mind::registercallback( "OnBotActionStart", &onbotactionstart );
            mind::registercallback( "OnBotActionEnd", &onbotactionend );
        }
        
        return;
    }
    
    callback::remove( #"player_spawned", &onentityspawned );
    callback::remove( #"player_damaged", &onentitydamaged );
    callback::remove( #"player_death", &onplayerdeath );
    callback::remove( #"player_laststand", &onplayerlaststand );
    callback::remove( "on_zombie_ai_spawned", &onentityspawned );
    callback::remove( "on_zombie_ai_killed", &onagentkilled );
    callback::remove( #"on_ai_damaged", &onentitydamaged );
    callback::remove( #"on_spawn_agent", &onentityspawned );
    callback::remove( #"on_ai_killed", &onagentkilled );
    
    if ( utility::flag( "ai_spawn_director_initialized" ) )
    {
        ai_spawn_director::function_1b7d6a5e85cd61b6( &function_e3ef90e403109610 );
    }
    
    if ( isdefined( level.mind ) )
    {
        level.mind.callbacks[ "OnBotActionStart" ] = undefined;
        level.mind.callbacks[ "OnBotActionEnd" ] = undefined;
    }
}

// Namespace namespace_ddca46d216b096e2
// Params 0, eflags: 0x4
// Checksum 0x84f2f65f, Offset: 0xfb3
// Size: 0x8e, Type: bool
function private function_a82e8ac40cc433f()
{
    foreach ( player in level.players )
    {
        if ( player.connected && isbot( player ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_ddca46d216b096e2
// Params 0
// Checksum 0x61e35250, Offset: 0x104a
// Size: 0x1c5
function function_4cf99c9de20b6df0()
{
    points = level.var_4b340b623e2f11b4.points;
    
    if ( !isdefined( points ) )
    {
        return;
    }
    
    assert( isdefined( level.br_circle.circleinittime ) );
    var_8f49c19044f87615 = [];
    
    for ( i = 0; i < points.size ; i++ )
    {
        point = points[ i ];
        time = point[ #"time" ];
        alivecount = point[ #"alive_count" ];
        maxalivecount = point[ #"max_alive_count" ];
        var_d4441a2319b5a1d6 = point[ #"min_alive_count" ];
        uibotcount = point[ #"ui_bot_count" ];
        threshold = 100 * max( maxalivecount - alivecount, alivecount - var_d4441a2319b5a1d6 ) / alivecount;
        x = int( ( time - level.br_circle.circleinittime ) * 0.001 );
        y = int( alivecount );
        z = int( uibotcount ) * 100 + int( threshold );
        pointstr = strjoin( ",", string( x ), string( y ), string( z ) );
        var_8f49c19044f87615[ i ] = pointstr;
    }
    
    dict = [];
    dict[ "C" ] = level.br_circle.circleinittime;
    dict[ "B" ] = formatstring( function_5d044133536d0766( "%", var_8f49c19044f87615 ) );
    logdictionary( 24, dict );
}

// Namespace namespace_ddca46d216b096e2
// Params 0, eflags: 0x4
// Checksum 0xe2f71ca7, Offset: 0x1217
// Size: 0xf2
function private function_12b9ec375968d26d()
{
    level endon( #"game_ended" );
    level endon( #"hash_776de611ecfe9598" );
    
    while ( true )
    {
        level waittill( #"hash_81b357d197c48279", naveventlist );
        assert( naveventlist );
        
        foreach ( navevent in naveventlist )
        {
            if ( !navevent )
            {
                continue;
            }
            
            if ( navevent.eventtype == "obstacle_added_to_space" )
            {
                function_6393c0cf96c5f982( navevent );
                continue;
            }
            
            if ( navevent.eventtype == "obstacle_removed_from_space" )
            {
                function_3651a8e37c4f92c4( navevent );
            }
        }
    }
}

// Namespace namespace_ddca46d216b096e2
// Params 1, eflags: 0x4
// Checksum 0x8ba9ce2e, Offset: 0x1311
// Size: 0x1dd
function private function_6393c0cf96c5f982( navevent )
{
    assert( navevent );
    var_f82ce5306aa77209 = [];
    var_f82ce5306aa77209[ "P" ] = formatstring( navevent.eventtype );
    var_f82ce5306aa77209[ "R" ] = navevent.obstacleindex;
    var_f82ce5306aa77209[ "Q" ] = navevent.obstacleid;
    var_f82ce5306aa77209[ "S" ] = istrue( navevent.glass );
    var_f82ce5306aa77209[ "T" ] = formatstring( navevent.spacename );
    var_f82ce5306aa77209[ "l" ] = navevent.pos;
    var_f82ce5306aa77209[ "U" ] = navevent.angles;
    var_f82ce5306aa77209[ "X" ] = navevent.layermask;
    var_f82ce5306aa77209[ "W" ] = navevent.var_389de4615f93fed2;
    
    if ( isdefined( navevent.extents ) )
    {
        var_f82ce5306aa77209[ "Y" ] = navevent.extents;
    }
    else if ( navevent.boundaryplanes && navevent.boundaryplanes.size > 0 )
    {
        foreach ( planeidx, plane in navevent.boundaryplanes )
        {
            assert( plane );
            var_f82ce5306aa77209[ "plane_" + planeidx + "_normal" ] = plane.normal;
            var_f82ce5306aa77209[ "plane_" + planeidx + "_distFromCenter" ] = plane.distfromcenter;
        }
    }
    
    logdictionary( 5, var_f82ce5306aa77209 );
}

// Namespace namespace_ddca46d216b096e2
// Params 1, eflags: 0x4
// Checksum 0xfe308bf6, Offset: 0x14f6
// Size: 0x81
function private function_3651a8e37c4f92c4( navevent )
{
    assert( navevent );
    var_f82ce5306aa77209 = [];
    var_f82ce5306aa77209[ "P" ] = formatstring( navevent.eventtype );
    var_f82ce5306aa77209[ "Q" ] = navevent.obstacleid;
    var_f82ce5306aa77209[ "R" ] = navevent.obstacleindex;
    var_f82ce5306aa77209[ "S" ] = istrue( navevent.glass );
    logdictionary( 7, var_f82ce5306aa77209 );
}

// Namespace namespace_ddca46d216b096e2
// Params 2
// Checksum 0x524305ac, Offset: 0x157f
// Size: 0x76
function onmarkplayeraseliminated( player, eliminated )
{
    if ( !isenabled() )
    {
        return;
    }
    
    dict = [];
    cachedplayer = function_f28ab20fd8d44630( player );
    
    if ( function_969ab419a5e4ec4c( cachedplayer, "q", eliminated ) )
    {
        dict[ "a" ] = function_4a8b8b259c1819c7( player );
        dict[ "q" ] = eliminated;
        logdictionary( 17, dict );
    }
}

// Namespace namespace_ddca46d216b096e2
// Params 2
// Checksum 0xb7d1cff9, Offset: 0x15fd
// Size: 0x4d
function logpublicevent( eventtype, eventstatus )
{
    dict = [];
    dict[ "g" ] = formatstring( eventtype );
    dict[ "K" ] = formatstring( eventstatus );
    logdictionary( 12, dict );
}

// Namespace namespace_ddca46d216b096e2
// Params 1
// Checksum 0x8279a69, Offset: 0x1652
// Size: 0xb8
function onentitydamaged( params )
{
    if ( !isenabled() )
    {
        return;
    }
    
    victim = undefined;
    
    if ( isdefined( params.victim ) )
    {
        victim = params.victim;
    }
    else if ( isagent( self ) )
    {
        victim = self;
        
        if ( !isdefined( self.bba_id ) )
        {
            return;
        }
    }
    
    if ( !isdefined( victim ) )
    {
        logstring( "Unexpected OnEntityDamaged, params.sMeansOfDeath: " + ( params.smeansofdeath ?? "" ) );
        return;
    }
    
    logplayerdamage( victim, params.eattacker, params.smeansofdeath, params.idamage, params.shitloc );
}

// Namespace namespace_ddca46d216b096e2
// Params 3, eflags: 0x4
// Checksum 0x832645e4, Offset: 0x1712
// Size: 0x28
function private function_e3ef90e403109610( agent, requestid, spawndata )
{
    agent onentityspawned( spawndata );
}

// Namespace namespace_ddca46d216b096e2
// Params 1
// Checksum 0x1d0150c0, Offset: 0x1742
// Size: 0x3a7
function onentityspawned( param )
{
    if ( !isenabled() )
    {
        return;
    }
    
    function_30b9db7247f23009();
    
    if ( isbot( self ) )
    {
        level.var_9bffc1c7425dcc18.var_9cc231b1436a4b5b = 1;
    }
    
    dict = [];
    cachedplayer = function_f28ab20fd8d44630( self );
    
    if ( isbot( self ) )
    {
        if ( function_969ab419a5e4ec4c( cachedplayer, "g", self.name ) )
        {
            dict[ "g" ] = formatstring( self.name );
        }
    }
    else if ( isagent( self ) )
    {
        level.var_9bffc1c7425dcc18.agents[ level.var_9bffc1c7425dcc18.agents.size ] = self;
        agentname = self.persistent_unique_id;
        waitframe();
        
        if ( isdefined( self.unittype ) )
        {
            dict[ "L" ] = formatstring( self.unittype );
        }
        
        if ( self.bossinstance.bundle.islieutenant )
        {
            dict[ "L" ] = formatstring( "lieutenant" );
        }
        
        if ( self.category == "reinforcements" || self.category == "starSystemReinforcements" )
        {
            dict[ "L" ] = formatstring( "reinforcements" );
        }
        
        if ( function_969ab419a5e4ec4c( cachedplayer, "g", agentname ) )
        {
            dict[ "g" ] = formatstring( agentname );
        }
    }
    else
    {
        unoid = self getplayerunoid();
        assert( unoid != "<dev string:x24>" );
        
        if ( function_969ab419a5e4ec4c( cachedplayer, "h", unoid ) )
        {
            dict[ "h" ] = formatstring( unoid );
        }
        
        if ( function_969ab419a5e4ec4c( cachedplayer, "g", self.name ) )
        {
            dict[ "g" ] = formatstring( self.name, 1 );
        }
    }
    
    if ( self.team )
    {
        if ( function_969ab419a5e4ec4c( cachedplayer, "f", self.team ) )
        {
            dict[ "f" ] = formatstring( self.team );
        }
    }
    
    if ( isbot( self ) )
    {
        difficulty = self botgetdifficulty();
        
        if ( function_969ab419a5e4ec4c( cachedplayer, "i", difficulty ) )
        {
            dict[ "i" ] = formatstring( difficulty );
        }
    }
    
    if ( isdefined( self.origin ) )
    {
        dict[ "e" ] = self.origin;
    }
    
    if ( br_public::isplayerinorgoingtogulag() )
    {
        dict[ "r" ] = self.arena.gulagindex;
        function_969ab419a5e4ec4c( cachedplayer, "r", self.arena.gulagindex );
    }
    else
    {
        function_969ab419a5e4ec4c( cachedplayer, "r", -1 );
    }
    
    if ( isbrgamemode() )
    {
        isghost = br_public::function_f15af281b8fa7b96();
        
        if ( function_969ab419a5e4ec4c( cachedplayer, "d", isghost ) )
        {
            dict[ "d" ] = isghost;
        }
    }
    
    if ( function_969ab419a5e4ec4c( cachedplayer, "c", self.health ) )
    {
        dict[ "c" ] = self.health;
    }
    
    dict[ "b" ] = getplayerdirection( self );
    
    if ( dict.size > 0 )
    {
        dict[ "a" ] = function_4a8b8b259c1819c7( self );
        logdictionary( 17, dict );
    }
    
    if ( isbot( self ) )
    {
        thread function_7fd96f49496d09d();
        thread function_2ca4f4f595463c5b();
    }
    
    if ( isplayer( self ) )
    {
        thread function_adaeafd9a3879ee4();
        thread function_feb9ecefa689870();
    }
}

// Namespace namespace_ddca46d216b096e2
// Params 1, eflags: 0x4
// Checksum 0xd219f82e, Offset: 0x1af1
// Size: 0x56
function private onagentkilled( param )
{
    if ( !isenabled() )
    {
        return;
    }
    
    onentitydamaged( param );
    onmarkplayeraseliminated( self, 1 );
    level.var_9bffc1c7425dcc18.agents = arrayremove( level.var_9bffc1c7425dcc18.agents, self );
}

// Namespace namespace_ddca46d216b096e2
// Params 2
// Checksum 0xa29a1f4a, Offset: 0x1b4f
// Size: 0x4c
function function_19394aaace4ec400( minz, maxz )
{
    if ( !isenabled() )
    {
        return;
    }
    
    level.var_9bffc1c7425dcc18.minz = minz;
    level.var_9bffc1c7425dcc18.maxz = maxz;
}

// Namespace namespace_ddca46d216b096e2
// Params 2, eflags: 0x4
// Checksum 0x127c5902, Offset: 0x1ba3
// Size: 0x143
function private function_ddaf81252fb5aa23( mapname, mapcorners )
{
    minz = level.var_9bffc1c7425dcc18.minz ?? 0;
    maxz = level.var_9bffc1c7425dcc18.maxz ?? 0;
    northwest = mapcorners[ 0 ].origin;
    southeast = mapcorners[ 1 ].origin;
    boundmin = ( northwest[ 0 ], northwest[ 1 ], minz );
    boundmax = ( southeast[ 0 ], southeast[ 1 ], maxz );
    northyaw = getnorthyaw();
    x = cos( northyaw );
    y = sin( northyaw );
    flt_epsilon = 1.19209e-07;
    
    if ( abs( x ) <= flt_epsilon )
    {
        x = 0;
    }
    
    if ( abs( y ) <= flt_epsilon )
    {
        y = 0;
    }
    
    northstr = function_91623df0765605e4( x, y );
    rawoutput( "LoadMap", strjoin( "#", mapname, string( boundmin ), string( boundmax ), northstr ) );
}

// Namespace namespace_ddca46d216b096e2
// Params 0, eflags: 0x4
// Checksum 0x83594067, Offset: 0x1cee
// Size: 0x2b3
function private function_11b5b9fe7619787f()
{
    floortriggers = getentarray( "trigger_multiple_set_minimap_floor", #classname );
    
    if ( !isdefined( floortriggers ) || floortriggers.size <= 0 )
    {
        return;
    }
    
    floornumbers = [];
    
    foreach ( trigger in floortriggers )
    {
        floor = trigger.script_floor_number;
        
        if ( isdefined( floor ) && !arraycontains( floornumbers, floor ) )
        {
            floornumbers[ floornumbers.size ] = floor;
        }
    }
    
    if ( floornumbers.size <= 1 )
    {
        return;
    }
    
    var_a7d5adc1091dbe67 = 0;
    
    foreach ( trigger in floortriggers )
    {
        if ( isdefined( trigger.script_floor_number ) )
        {
            var_a7d5adc1091dbe67++;
        }
    }
    
    var_8f5a60b454758cf0 = [];
    var_8f5a60b454758cf0[ var_8f5a60b454758cf0.size ] = "floorCount";
    var_8f5a60b454758cf0[ var_8f5a60b454758cf0.size ] = floornumbers.size;
    var_8f5a60b454758cf0[ var_8f5a60b454758cf0.size ] = "regionCount";
    var_8f5a60b454758cf0[ var_8f5a60b454758cf0.size ] = var_a7d5adc1091dbe67;
    regionidx = 0;
    
    foreach ( trigger in floortriggers )
    {
        floor = trigger.script_floor_number;
        
        if ( !isdefined( floor ) )
        {
            continue;
        }
        
        prefix = "region" + regionidx;
        var_8f5a60b454758cf0[ var_8f5a60b454758cf0.size ] = prefix + "Floor";
        var_8f5a60b454758cf0[ var_8f5a60b454758cf0.size ] = floor;
        var_8f5a60b454758cf0[ var_8f5a60b454758cf0.size ] = prefix + "GeometryType";
        var_8f5a60b454758cf0[ var_8f5a60b454758cf0.size ] = formatstring( "origin" );
        var_8f5a60b454758cf0[ var_8f5a60b454758cf0.size ] = prefix + "Origin";
        var_8f5a60b454758cf0[ var_8f5a60b454758cf0.size ] = trigger.origin;
        
        if ( isdefined( trigger.script_label ) )
        {
            var_8f5a60b454758cf0[ var_8f5a60b454758cf0.size ] = prefix + "Label";
            var_8f5a60b454758cf0[ var_8f5a60b454758cf0.size ] = formatstring( trigger.script_label );
        }
        
        regionidx++;
    }
    
    function_529e97514b934b19( "LoadMapMinimapBoundaries", var_8f5a60b454758cf0 );
}

// Namespace namespace_ddca46d216b096e2
// Params 0, eflags: 0x4
// Checksum 0xbef710a5, Offset: 0x1fa9
// Size: 0xc0
function private function_7f9e62e6d7edd9e0()
{
    level utility::flag_wait( "flag_minimap_triggers_initialized" );
    
    if ( !isarray( level.minimap_floor_triggers ) || level.minimap_floor_triggers.size <= 0 )
    {
        return;
    }
    
    level.var_9bffc1c7425dcc18.var_774cf1ddf299263b = 1;
    
    foreach ( trigger in level.minimap_floor_triggers )
    {
        thread function_901baea3643ded9f( trigger );
    }
}

// Namespace namespace_ddca46d216b096e2
// Params 1, eflags: 0x4
// Checksum 0xe5a23f4d, Offset: 0x2071
// Size: 0x7a
function private function_901baea3643ded9f( trigger )
{
    level endon( #"game_ended" );
    level endon( #"hash_776de611ecfe9598" );
    floor = trigger.script_floor_number;
    
    if ( !isdefined( floor ) )
    {
        return;
    }
    
    while ( true )
    {
        trigger waittill( #"trigger", ent );
        
        if ( isagent( ent ) )
        {
            ent.bba_floor_number = floor;
        }
    }
}

// Namespace namespace_ddca46d216b096e2
// Params 0
// Checksum 0x5fb772bb, Offset: 0x20f3
// Size: 0xc0
function loggamestarted()
{
    if ( isdefined( level.gulag ) && isdefined( level.gulag.arenas ) )
    {
        gulagnum = level.gulag.arenas.size;
    }
    else
    {
        gulagnum = 0;
    }
    
    gametypestr = game_utility::getgametype();
    matchid = getonlinematchid();
    bottype = "script";
    
    if ( isdefined( level.mind ) )
    {
        bottype = "mind";
    }
    else if ( bots_util::function_deef484b5b3a3977() )
    {
        bottype = "btree";
    }
    
    rawoutput( "GameStart", strjoin( "#", gametypestr, string( gulagnum ), matchid, bottype ) );
}

// Namespace namespace_ddca46d216b096e2
// Params 0
// Checksum 0xd9d2506, Offset: 0x21bb
// Size: 0x10a
function function_bcf38177f0966103()
{
    level endon( #"hash_776de611ecfe9598" );
    notifyarray = [ "start_prematch", "prematch_over", "game_ended", "gulag_closed", "respawn_disabled", "dmz_radiation_started" ];
    
    while ( true )
    {
        msg = utility::waittill_any_in_array_return( notifyarray );
        
        if ( msg == "start_prematch" )
        {
            function_529e97514b934b19( "PrematchStart" );
            continue;
        }
        
        if ( msg == "prematch_over" )
        {
            function_529e97514b934b19( "PrematchEnd" );
            continue;
        }
        
        if ( msg == "game_ended" )
        {
            function_529e97514b934b19( "GameEnd" );
            return;
        }
        
        if ( msg == "gulag_closed" )
        {
            function_529e97514b934b19( "GulagClose" );
            continue;
        }
        
        if ( msg == "respawn_disabled" )
        {
            function_529e97514b934b19( "RespawnDisabled" );
            continue;
        }
        
        if ( msg == "dmz_radiation_started" )
        {
            logpublicevent( "radiation", "start" );
        }
    }
}

// Namespace namespace_ddca46d216b096e2
// Params 1
// Checksum 0x326356e6, Offset: 0x22cd
// Size: 0x3b
function function_f28ab20fd8d44630( player )
{
    bbaid = function_6943b5b53808407d( player );
    
    if ( !isdefined( bbaid ) )
    {
        bbaid = "bad_" + player getentitynumber();
    }
    
    return function_2a06462c9cc9f539( bbaid );
}

// Namespace namespace_ddca46d216b096e2
// Params 1
// Checksum 0xd2dcda8c, Offset: 0x2311
// Size: 0x81
function function_2a06462c9cc9f539( bbaid )
{
    cachedplayer = level.var_9bffc1c7425dcc18.players[ bbaid ];
    
    if ( !isdefined( cachedplayer ) )
    {
        cachedplayer = spawnstruct();
        cachedplayer.id = bbaid;
        cachedplayer.props = [];
        cachedplayer.isagent = isagent( self );
        level.var_9bffc1c7425dcc18.players[ bbaid ] = cachedplayer;
    }
    
    return cachedplayer;
}

// Namespace namespace_ddca46d216b096e2
// Params 3
// Checksum 0x5e159504, Offset: 0x239b
// Size: 0x51, Type: bool
function function_969ab419a5e4ec4c( cachedplayer, key, value )
{
    assert( isdefined( cachedplayer ) );
    
    if ( cachedplayer.props[ key ] == value )
    {
        return false;
    }
    
    cachedplayer.props[ key ] = value;
    return true;
}

// Namespace namespace_ddca46d216b096e2
// Params 0
// Checksum 0x928db8bb, Offset: 0x23f5
// Size: 0x115
function function_7fd96f49496d09d()
{
    level endon( #"game_ended" );
    level endon( #"hash_776de611ecfe9598" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"bot_difficulty_updated" );
        bbaid = function_6943b5b53808407d( self );
        assert( isdefined( bbaid ) );
        
        if ( !isdefined( bbaid ) || !function_e32b33378061fa43( self ) || !isdefined( level.var_9bffc1c7425dcc18.players[ bbaid ] ) )
        {
            continue;
        }
        
        str = "";
        difficulty = self botgetdifficulty();
        cachedplayer = function_f28ab20fd8d44630( self );
        
        if ( function_969ab419a5e4ec4c( cachedplayer, "i", difficulty ) )
        {
            str += ";difficulty=" + formatstring( difficulty );
        }
        
        if ( str.size > 0 )
        {
            playername = function_4a8b8b259c1819c7( self );
            str = "id=" + playername + str;
            logarray( 17, [ str ] );
        }
    }
}

// Namespace namespace_ddca46d216b096e2
// Params 0
// Checksum 0xc2b3c8e, Offset: 0x2512
// Size: 0x8c
function function_2ca4f4f595463c5b()
{
    level endon( #"game_ended" );
    level endon( #"hash_776de611ecfe9598" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"stuck_traversal", startpos, endpos );
        var_f4d71b9bb0feb65c = [];
        var_f4d71b9bb0feb65c[ "F" ] = self.origin;
        var_f4d71b9bb0feb65c[ "E" ] = startpos;
        var_f4d71b9bb0feb65c[ "D" ] = endpos;
        logdictionary( 25, var_f4d71b9bb0feb65c );
    }
}

// Namespace namespace_ddca46d216b096e2
// Params 0, eflags: 0x4
// Checksum 0x1848dcdb, Offset: 0x25a6
// Size: 0xab
function private function_feb9ecefa689870()
{
    level endon( #"game_ended" );
    level endon( #"hash_776de611ecfe9598" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        event = utility::waittill_any_in_array_return( level.var_9bffc1c7425dcc18.playerevents );
        cachedplayer = function_f28ab20fd8d44630( self );
        
        if ( function_969ab419a5e4ec4c( cachedplayer, "p", event ) )
        {
            dict = [];
            dict[ "a" ] = function_4a8b8b259c1819c7( self );
            dict[ "p" ] = formatstring( event );
            logdictionary( 17, dict );
        }
    }
}

// Namespace namespace_ddca46d216b096e2
// Params 1, eflags: 0x4
// Checksum 0x3db63b37, Offset: 0x2659
// Size: 0x5d
function private onplayerdeath( deathdata )
{
    if ( !isenabled() )
    {
        return;
    }
    
    dict = [];
    dict[ "a" ] = function_4a8b8b259c1819c7( self );
    dict[ "p" ] = formatstring( "dead:" + deathdata.meansofdeath );
    logdictionary( 17, dict );
}

// Namespace namespace_ddca46d216b096e2
// Params 1, eflags: 0x4
// Checksum 0xe1eabd74, Offset: 0x26be
// Size: 0x25
function private onplayerlaststand( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    function_9370024843ceea2( self, "laststand", undefined, undefined );
}

// Namespace namespace_ddca46d216b096e2
// Params 4, eflags: 0x4
// Checksum 0xaeb4668, Offset: 0x26eb
// Size: 0xf7
function private function_9370024843ceea2( player, eventname, targetlocation, cash )
{
    if ( !isenabled() || !isplayer( player ) )
    {
        return;
    }
    
    bbaid = function_6943b5b53808407d( player );
    
    if ( !isdefined( bbaid ) )
    {
        return;
    }
    
    dict = [];
    dict[ "a" ] = function_4a8b8b259c1819c7( player );
    dict[ "p" ] = formatstring( eventname );
    dict[ "N" ] = getplayerposition( player );
    dict[ "b" ] = getplayerdirection( player );
    
    if ( isdefined( player.team ) )
    {
        dict[ "f" ] = formatstring( player.team );
    }
    
    if ( isdefined( targetlocation ) )
    {
        dict[ "Z" ] = targetlocation;
    }
    
    if ( isdefined( cash ) )
    {
        dict[ "M" ] = cash;
    }
    
    logdictionary( 17, dict );
}

// Namespace namespace_ddca46d216b096e2
// Params 2
// Checksum 0xddbd1db5, Offset: 0x27ea
// Size: 0x26
function function_202945eb201d3e81( player, exfilpos )
{
    function_9370024843ceea2( player, "exfil_start", exfilpos, undefined );
}

// Namespace namespace_ddca46d216b096e2
// Params 1
// Checksum 0x30b49046, Offset: 0x2818
// Size: 0x5a
function function_d276eb6bb422bfee( player )
{
    cashval = 0;
    
    if ( isdefined( player.currency[ #"cash" ] ) )
    {
        cashval = player.currency[ #"cash" ];
    }
    
    function_9370024843ceea2( player, "exfil_success", undefined, cashval );
}

// Namespace namespace_ddca46d216b096e2
// Params 2
// Checksum 0xd3bd409, Offset: 0x287a
// Size: 0x26
function function_f20afdfa0c002126( player, containerorigin )
{
    function_9370024843ceea2( player, "loot", containerorigin, undefined );
}

// Namespace namespace_ddca46d216b096e2
// Params 0
// Checksum 0x4234a9c3, Offset: 0x28a8
// Size: 0xf3
function function_adaeafd9a3879ee4()
{
    level endon( #"game_ended" );
    level endon( #"hash_776de611ecfe9598" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        event = utility::waittill_any_in_array_return( level.var_9bffc1c7425dcc18.var_2658a65dbe161c9f );
        weaponobj = self getcurrentweapon();
        
        if ( !isdefined( weaponobj ) )
        {
            weaponname = "undefined";
        }
        else if ( isnullweapon( weaponobj ) )
        {
            weaponname = "NullWeapon";
        }
        else
        {
            weaponname = weaponobj.basename;
        }
        
        cachedplayer = function_f28ab20fd8d44630( self );
        
        if ( function_969ab419a5e4ec4c( cachedplayer, "m", weaponname ) )
        {
            dict = [];
            dict[ "a" ] = function_4a8b8b259c1819c7( self );
            dict[ "m" ] = formatstring( weaponname );
            logdictionary( 21, dict );
        }
    }
}

// Namespace namespace_ddca46d216b096e2
// Params 2
// Checksum 0x9672196e, Offset: 0x29a3
// Size: 0xfb
function function_4833f43f9011ad9f( to, from )
{
    if ( !isenabled() )
    {
        return;
    }
    
    if ( !isdefined( from ) )
    {
        from = "active";
        
        if ( manager::function_5c79ebe77f7d0528() )
        {
            from = "dormant";
        }
        else if ( manager::isuibot() )
        {
            from = "uibot";
        }
    }
    
    if ( from == to )
    {
        return;
    }
    
    dict = [];
    dict[ "a" ] = function_4a8b8b259c1819c7( self );
    dict[ "o" ] = formatstring( from );
    dict[ "n" ] = formatstring( to );
    
    if ( to == "active" && from == "uibot" )
    {
        assert( isdefined( self.origin ) );
        dict[ "l" ] = self.origin;
    }
    
    cachedplayer = function_f28ab20fd8d44630( self );
    function_969ab419a5e4ec4c( cachedplayer, "botStatus", to );
    logdictionary( 15, dict );
}

// Namespace namespace_ddca46d216b096e2
// Params 3
// Checksum 0x487829d3, Offset: 0x2aa6
// Size: 0xc4
function function_4b93c7b7fe71290c( botprofile, to, from )
{
    if ( !isenabled() )
    {
        return;
    }
    
    assert( isdefined( botprofile ) && isdefined( botprofile.bba_id ) );
    bbaid = botprofile.bba_id;
    dict = [];
    dict[ "a" ] = function_c80a4abe3aa8041d( bbaid, 1 );
    dict[ "o" ] = formatstring( from );
    dict[ "n" ] = formatstring( to );
    cachedplayer = function_2a06462c9cc9f539( bbaid );
    function_969ab419a5e4ec4c( cachedplayer, "botStatus", to );
    logdictionary( 15, dict );
}

// Namespace namespace_ddca46d216b096e2
// Params 0
// Checksum 0xd2f514ad, Offset: 0x2b72
// Size: 0x15b
function function_45aeadafe3cb6396()
{
    level endon( #"game_ended" );
    level endon( #"hash_776de611ecfe9598" );
    
    while ( true )
    {
        updatedplayers = [];
        
        for ( i = 0; i < level.players.size ; i++ )
        {
            player = level.players[ i ];
            
            if ( !function_e32b33378061fa43( player ) || player br_public::isplayerinorgoingtogulag() )
            {
                continue;
            }
            
            bbaid = function_6943b5b53808407d( player );
            
            if ( !isdefined( bbaid ) || !isdefined( level.var_9bffc1c7425dcc18.players[ bbaid ] ) )
            {
                assert( isdefined( bbaid ) );
                continue;
            }
            
            info = {};
            info.id = player getentitynumber();
            info.name = function_4a8b8b259c1819c7( player );
            info.path = function_cca0f5f9095b3d41( player );
            updatedplayers[ updatedplayers.size ] = info;
        }
        
        if ( updatedplayers.size > 0 )
        {
            function_ba903946077c9e55( 18, updatedplayers );
            function_df0e66c0286548c4( level.players, 1 );
        }
        
        if ( function_416aca1f95e3970e( 8 ) )
        {
            function_fc5e6af03e56e8d4( updatedplayers );
        }
        
        wait level.var_9bffc1c7425dcc18.var_dcc5d33aff6c5500;
    }
}

// Namespace namespace_ddca46d216b096e2
// Params 0
// Checksum 0x5e7d87c, Offset: 0x2cd5
// Size: 0x14b
function function_9b517574879db1a8()
{
    level endon( #"game_ended" );
    level endon( #"hash_776de611ecfe9598" );
    
    while ( true )
    {
        updatedplayers = [];
        
        foreach ( agent in level.var_9bffc1c7425dcc18.agents )
        {
            if ( agent.isactive && isalive( agent ) )
            {
                info = {};
                info.id = agent getentitynumber();
                info.name = function_4a8b8b259c1819c7( agent );
                info.path = function_cca0f5f9095b3d41( agent );
                updatedplayers[ updatedplayers.size ] = info;
            }
        }
        
        if ( updatedplayers.size > 0 )
        {
            function_ba903946077c9e55( 19, updatedplayers );
            function_df0e66c0286548c4( level.var_9bffc1c7425dcc18.agents, 0 );
        }
        
        wait level.var_9bffc1c7425dcc18.var_dcc5d33aff6c5500;
    }
}

// Namespace namespace_ddca46d216b096e2
// Params 2, eflags: 0x4
// Checksum 0xb1c123bd, Offset: 0x2e28
// Size: 0x273
function private function_df0e66c0286548c4( entities, var_91ca9606b50bef07 )
{
    if ( !level.var_9bffc1c7425dcc18.var_774cf1ddf299263b )
    {
        return;
    }
    
    var_8f5a60b454758cf0 = [];
    count = 0;
    
    foreach ( ent in entities )
    {
        if ( var_91ca9606b50bef07 )
        {
            if ( !function_e32b33378061fa43( ent ) || ent br_public::isplayerinorgoingtogulag() )
            {
                continue;
            }
            
            bbaid = function_6943b5b53808407d( ent );
            
            if ( !isdefined( bbaid ) || !isdefined( level.var_9bffc1c7425dcc18.players[ bbaid ] ) )
            {
                continue;
            }
            
            floor = ent.player_floor_number;
        }
        else
        {
            if ( !ent.isactive || !isalive( ent ) )
            {
                continue;
            }
            
            floor = ent.bba_floor_number;
        }
        
        if ( !isdefined( floor ) )
        {
            continue;
        }
        
        prefix = "e" + count;
        var_8f5a60b454758cf0[ var_8f5a60b454758cf0.size ] = prefix + "Id";
        var_8f5a60b454758cf0[ var_8f5a60b454758cf0.size ] = function_4a8b8b259c1819c7( ent );
        var_8f5a60b454758cf0[ var_8f5a60b454758cf0.size ] = prefix + "Floor";
        var_8f5a60b454758cf0[ var_8f5a60b454758cf0.size ] = floor;
        count++;
    }
    
    if ( count > 0 )
    {
        batchsize = 30;
        
        for ( batchstart = 0; batchstart < count ; batchstart = batchend )
        {
            batchend = batchstart + batchsize;
            
            if ( batchend > count )
            {
                batchend = count;
            }
            
            var_17fd5db510a9a8d3 = [];
            
            for ( i = batchstart; i < batchend ; i++ )
            {
                prefix = "e" + i - batchstart;
                srcbase = i * 4;
                var_17fd5db510a9a8d3[ var_17fd5db510a9a8d3.size ] = prefix + "Id";
                var_17fd5db510a9a8d3[ var_17fd5db510a9a8d3.size ] = var_8f5a60b454758cf0[ srcbase + 1 ];
                var_17fd5db510a9a8d3[ var_17fd5db510a9a8d3.size ] = prefix + "Floor";
                var_17fd5db510a9a8d3[ var_17fd5db510a9a8d3.size ] = var_8f5a60b454758cf0[ srcbase + 3 ];
            }
            
            var_17fd5db510a9a8d3[ var_17fd5db510a9a8d3.size ] = "count";
            var_17fd5db510a9a8d3[ var_17fd5db510a9a8d3.size ] = batchend - batchstart;
            function_529e97514b934b19( "UpdateFloor", var_17fd5db510a9a8d3 );
        }
    }
}

// Namespace namespace_ddca46d216b096e2
// Params 1
// Checksum 0x4d3b7360, Offset: 0x30a3
// Size: 0x193
function function_cca0f5f9095b3d41( player )
{
    if ( level.var_9bffc1c7425dcc18.var_4c6574d1c68ecce8 <= 0 )
    {
        return "";
    }
    
    isbot = isbot( player ) && !player manager::isuibot();
    isagent = isagent( player );
    curgoal = undefined;
    
    if ( isbot )
    {
        if ( player bothasscriptgoal() )
        {
            curgoal = player botgetscriptgoal();
        }
    }
    else if ( isagent )
    {
        if ( isdefined( player.goalpos ) )
        {
            curgoal = player.goalpos;
        }
    }
    else
    {
        return "";
    }
    
    if ( player.var_c1c5352343004665 === curgoal )
    {
        return "";
    }
    
    player.var_c1c5352343004665 = curgoal;
    
    if ( !isdefined( curgoal ) )
    {
        return "";
    }
    
    append = ";goal=" + curgoal;
    path = player getpath();
    
    if ( isdefined( path ) && path.size > 0 )
    {
        var_eb512ba029b9c09f = min( path.size, level.var_9bffc1c7425dcc18.var_4c6574d1c68ecce8 );
        append += ";pathlength=" + var_eb512ba029b9c09f + ";path=";
        
        for ( i = 0; i < var_eb512ba029b9c09f ; i++ )
        {
            if ( i > 0 )
            {
                append += "/";
            }
            
            append += path[ i ][ 0 ] + "," + path[ i ][ 1 ] + "," + path[ i ][ 2 ];
        }
    }
    
    return append;
}

// Namespace namespace_ddca46d216b096e2
// Params 2
// Checksum 0x1358be19, Offset: 0x323f
// Size: 0x252
function onbotactionstart( bot, action )
{
    dict = [];
    dict[ "id" ] = function_4a8b8b259c1819c7( bot );
    suspendedstr = "";
    
    if ( isdefined( bot.uibot ) && bot.uibot.issuspended )
    {
        suspendedstr = "suspended-";
    }
    
    var_60ea789328f81d85 = bot.mind.var_60ea789328f81d85;
    
    for ( i = 0; i < var_60ea789328f81d85.actions.size ; i++ )
    {
        act = var_60ea789328f81d85.actions[ i ];
        key = "action" + i;
        str = formatstring( suspendedstr + act.description, 1 );
        dict[ key ] = str;
        
        if ( isdefined( act.lasterror ) )
        {
            dict[ "lastError" + i ] = formatstring( act.lasterror, 1 );
        }
    }
    
    var_992292637bfcfc42 = mind::function_913cc9cac6344be( bot.mind.decisionmaker.decisions );
    decisioncount = min( var_992292637bfcfc42.size, 3 );
    
    for ( i = 0; i < decisioncount ; i++ )
    {
        decision = var_992292637bfcfc42[ i ];
        key = "decision" + i;
        description = "";
        
        if ( isdefined( decision.generatedaction ) && isdefined( decision.generatedaction.description ) && decision.generatedaction.description.size > 0 )
        {
            description = decision.generatedaction.description;
        }
        else
        {
            description = decision.name;
        }
        
        str = formatstring( decision.score + "/" + description, 1 );
        dict[ key ] = str;
    }
    
    dict[ "direction" ] = getplayerdirection( bot );
    logdictionary( 3, dict );
}

// Namespace namespace_ddca46d216b096e2
// Params 2
// Checksum 0x292e7795, Offset: 0x3499
// Size: 0x1bb
function onbotactionend( bot, action )
{
    var_60ea789328f81d85 = bot.mind.var_60ea789328f81d85;
    
    for ( i = 0; i < var_60ea789328f81d85.actions.size ; i++ )
    {
        act = var_60ea789328f81d85.actions[ i ];
        
        if ( act.exclusivegroup == action.exclusivegroup && act.description == action.description )
        {
            actionindex = i;
            break;
        }
    }
    
    if ( !isdefined( actionindex ) )
    {
        assertmsg( "<dev string:x25>" + action.name + "<dev string:x2e>" );
        return;
    }
    
    dict = [];
    dict[ "id" ] = function_4a8b8b259c1819c7( bot );
    suspendedstr = "";
    
    if ( isdefined( bot.uibot ) && bot.uibot.issuspended )
    {
        suspendedstr = "suspended-";
    }
    
    key = "action" + actionindex;
    str = formatstring( "end " + suspendedstr + action.description, 1 );
    dict[ key ] = str;
    
    if ( isdefined( action.lasterror ) )
    {
        dict[ "lastError" + actionindex ] = formatstring( action.lasterror, 1 );
    }
    
    dict[ "direction" ] = getplayerdirection( bot );
    logdictionary( 3, dict );
}

// Namespace namespace_ddca46d216b096e2
// Params 4
// Checksum 0xce2c405d, Offset: 0x365c
// Size: 0xa9
function onplayerteleport( player, prevpos, teleportpos, reason )
{
    if ( !isenabled() )
    {
        return;
    }
    
    if ( !function_e32b33378061fa43( player, 1 ) || player br_public::isplayerinorgoingtogulag() )
    {
        return;
    }
    
    dict = [];
    dict[ "a" ] = function_4a8b8b259c1819c7( player );
    dict[ "b" ] = getplayerdirection( player );
    dict[ "l" ] = prevpos;
    dict[ "k" ] = teleportpos;
    dict[ "j" ] = formatstring( reason );
    logdictionary( 18, dict );
}

// Namespace namespace_ddca46d216b096e2
// Params 2
// Checksum 0xe32ede99, Offset: 0x370d
// Size: 0x3d, Type: bool
function function_e32b33378061fa43( player, var_48c8a67af489e3af )
{
    return bots_gametype_super_shared::isaliveplayer( player ) && !player bots_gametype_br_super::iseliminated() && ( var_48c8a67af489e3af || !player manager::isuibot() );
}

// Namespace namespace_ddca46d216b096e2
// Params 1
// Checksum 0xaec595e1, Offset: 0x3753
// Size: 0x1f
function getplayerdirection( player )
{
    return vectornormalize( anglestoforward( player.angles ) );
}

// Namespace namespace_ddca46d216b096e2
// Params 1
// Checksum 0xd093d7ff, Offset: 0x377b
// Size: 0x55
function getplayerposition( player )
{
    if ( isdefined( player.c130 ) )
    {
        c130 = level.br_ac130 ?? player.c130;
        return c130.origin;
    }
    
    return player.origin;
}

// Namespace namespace_ddca46d216b096e2
// Params 0
// Checksum 0x9cbe136d, Offset: 0x37d9
// Size: 0x116
function function_f016559dc4437d00()
{
    level endon( #"game_ended" );
    level endon( #"hash_776de611ecfe9598" );
    wait 1;
    
    while ( true )
    {
        wait level.var_9bffc1c7425dcc18.var_dcc5d33aff6c5500;
        uibots = manager::function_cda6de7e2ba52066();
        stringarray = [];
        
        foreach ( botprofile in uibots )
        {
            botid = function_c80a4abe3aa8041d( botprofile.bba_id, 1 );
            str = "id=" + botid + ";name=" + formatstring( botprofile.name );
            stringarray[ stringarray.size ] = str;
        }
        
        logarray( 27, stringarray );
    }
}

// Namespace namespace_ddca46d216b096e2
// Params 0
// Checksum 0xb8c219f8, Offset: 0x38f7
// Size: 0x90
function function_f33506b0dd5e645b()
{
    level endon( #"game_ended" );
    level endon( #"hash_776de611ecfe9598" );
    var_9960239c90d931d8 = [ "br_circle_set", "br_circle_started", "br_circle_closed", "circle_paused", "circle_unpaused" ];
    
    while ( true )
    {
        utility::waittill_any_in_array_or_timeout( var_9960239c90d931d8, level.var_9bffc1c7425dcc18.var_ff700063b6b1ca71 );
        
        if ( !isdefined( level.br_circle ) )
        {
            continue;
        }
        
        function_aef8e1e11b480149();
    }
}

// Namespace namespace_ddca46d216b096e2
// Params 0
// Checksum 0x789fa4b2, Offset: 0x398f
// Size: 0x1e9
function function_aef8e1e11b480149()
{
    circleindex = level.br_circle.circleindex;
    
    if ( !isdefined( circleindex ) || circleindex < 0 )
    {
        return;
    }
    
    if ( level.br_multi_circle_enabled && isdefined( level.br_multi_circle ) )
    {
        for ( index = 0; index < level.br_multi_circle.circlecount ; index++ )
        {
            circlepos = br_circle_util::function_ca4e814b4282e560( index );
            circlepos = function_91623df0765605e4( circlepos[ 0 ], circlepos[ 1 ] );
            circleradius = br_circle_util::function_bb587506a3fc32d4( index );
            targetpos = br_circle_util::function_614ad7680d84e36e( index );
            targetpos = function_91623df0765605e4( targetpos[ 0 ], targetpos[ 1 ] );
            targetradius = br_circle_util::function_6f1e39c56a1f50fa( index );
            function_529e97514b934b19( "UpdateCircle", [ "a", circleindex, "G", index, "l", circlepos, "H", circleradius, "I", targetpos, "J", targetradius ] );
        }
        
        return;
    }
    
    circlepos = br_circle::getdangercircleorigin();
    circlepos = function_91623df0765605e4( circlepos[ 0 ], circlepos[ 1 ] );
    circleradius = br_circle::getdangercircleradius();
    targetpos = br_circle::getsafecircleorigin();
    targetpos = function_91623df0765605e4( targetpos[ 0 ], targetpos[ 1 ] );
    targetradius = br_circle::getsafecircleradius();
    function_529e97514b934b19( "UpdateCircle", [ "a", circleindex, "G", 0, "l", circlepos, "H", circleradius, "I", targetpos, "J", targetradius ] );
}

// Namespace namespace_ddca46d216b096e2
// Params 5
// Checksum 0x17acdb82, Offset: 0x3b80
// Size: 0x13a
function logplayerdamage( victim, attacker, meansofdeath, damage, hitloc )
{
    dict = [];
    assert( isdefined( victim ) );
    dict[ "v" ] = formatentityname( victim );
    dict[ "z" ] = getplayerdirection( victim );
    
    if ( isdefined( attacker ) )
    {
        dict[ "u" ] = formatentityname( attacker );
        
        if ( isplayer( attacker ) || isagent( attacker ) )
        {
            dict[ "A" ] = getplayerdirection( attacker );
        }
    }
    
    assert( isdefined( meansofdeath ) );
    dict[ "x" ] = formatstring( meansofdeath, 1 );
    assert( isdefined( damage ) );
    dict[ "w" ] = damage;
    
    if ( isdefined( hitloc ) )
    {
        dict[ "y" ] = formatstring( hitloc );
    }
    
    dict[ "c" ] = victim.health;
    
    if ( isplayer( victim ) )
    {
        cachedplayer = function_f28ab20fd8d44630( victim );
        function_969ab419a5e4ec4c( cachedplayer, "c", victim.health );
    }
    
    logdictionary( 0, dict );
}

// Namespace namespace_ddca46d216b096e2
// Params 4
// Checksum 0x84cf05a1, Offset: 0x3cc2
// Size: 0xcc
function logplayerkilled( attacker, victim, meansofdeath, damage )
{
    if ( !isenabled() )
    {
        return;
    }
    
    dict = [];
    dict[ "v" ] = formatentityname( victim );
    
    if ( isdefined( attacker ) )
    {
        dict[ "u" ] = formatentityname( attacker );
    }
    
    if ( isdefined( meansofdeath ) )
    {
        dict[ "t" ] = formatstring( meansofdeath, 1 );
    }
    
    if ( isdefined( damage ) )
    {
        dict[ "s" ] = damage;
    }
    
    if ( isplayer( victim ) )
    {
        cachedplayer = function_f28ab20fd8d44630( victim );
        function_969ab419a5e4ec4c( cachedplayer, "c", victim.health );
    }
    
    logdictionary( 9, dict );
}

// Namespace namespace_ddca46d216b096e2
// Params 2
// Checksum 0x407d2dda, Offset: 0x3d96
// Size: 0x89
function function_8c422f920ddf62cb( botprofile, reason )
{
    if ( !isenabled() || !function_416aca1f95e3970e( 2 ) )
    {
        return;
    }
    
    dict = [];
    dict[ "a" ] = function_c80a4abe3aa8041d( botprofile.bba_id, 1 );
    dict[ "g" ] = formatstring( botprofile.name );
    dict[ "O" ] = formatstring( reason );
    logdictionary( 29, dict );
}

// Namespace namespace_ddca46d216b096e2
// Params 3
// Checksum 0xfc27b3a, Offset: 0x3e27
// Size: 0xa7
function function_a8bd6173ca7191ff( status, reason, deploycount )
{
    if ( !isenabled() || !function_416aca1f95e3970e( 2 ) )
    {
        return;
    }
    
    assert( manager::isenabled() );
    dict = [];
    dict[ "K" ] = formatstring( status );
    dict[ "O" ] = formatstring( reason );
    uibots = manager::function_cda6de7e2ba52066();
    dict[ "remain" ] = uibots.size;
    
    if ( isdefined( deploycount ) )
    {
        dict[ "deployCount" ] = deploycount;
    }
    
    logdictionary( 30, dict );
}

// Namespace namespace_ddca46d216b096e2
// Params 1
// Checksum 0x7edae128, Offset: 0x3ed6
// Size: 0x207
function debuglogforceendgame( method )
{
    if ( !isenabled() || !function_416aca1f95e3970e( 4 ) )
    {
        return;
    }
    
    stringarray = [];
    str = "method=" + method;
    stringarray[ 0 ] = str;
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        playerid = function_4a8b8b259c1819c7( player );
        str = "id=" + playerid;
        str += ";isAlive=" + bots_gametype_super_shared::isaliveplayer( player );
        str += ";eliminated=" + player bots_gametype_br_super::iseliminated();
        
        if ( isbrgamemode() )
        {
            str += ";ghost=" + player br_public::function_f15af281b8fa7b96();
        }
        
        str += ";UIBot=" + player manager::isuibot();
        
        if ( player br_public::isplayerinorgoingtogulag() )
        {
            str += ";gulagId=" + player.arena.gulagindex;
        }
        else
        {
            str += ";gulagId=-1";
        }
        
        stringarray[ stringarray.size ] = str;
    }
    
    if ( manager::isenabled() )
    {
        uibots = manager::function_cda6de7e2ba52066();
        
        foreach ( botprofile in uibots )
        {
            botid = function_c80a4abe3aa8041d( botprofile.bba_id, 1 );
            str = "uibot=1;id=" + botid + ";name=" + formatstring( botprofile.name );
            stringarray[ stringarray.size ] = str;
        }
    }
    
    if ( stringarray.size > 0 )
    {
        logarray( 28, stringarray );
    }
}

// Namespace namespace_ddca46d216b096e2
// Params 1
// Checksum 0xddb0720, Offset: 0x40e5
// Size: 0x24c
function function_fc5e6af03e56e8d4( updatedplayers )
{
    foreach ( key, cachedplayer in level.var_9bffc1c7425dcc18.players )
    {
        if ( cachedplayer.isagent )
        {
            continue;
        }
        
        if ( ( cachedplayer.props[ "c" ] ?? -1 ) <= 0 )
        {
            continue;
        }
        
        if ( ( cachedplayer.props[ "q" ] ?? 0 ) == 1 )
        {
            continue;
        }
        
        if ( ( cachedplayer.props[ "r" ] ?? -1 ) >= 0 )
        {
            continue;
        }
        
        status = cachedplayer.props[ "botStatus" ] ?? "";
        
        if ( status == "kickout" || status == "uibot" )
        {
            continue;
        }
        
        if ( !isdefined( updatedplayers[ key ] ) )
        {
            for ( i = 0; i < level.players.size ; i++ )
            {
                player = level.players[ i ];
                bba_id = function_6943b5b53808407d( player );
                
                if ( bba_id == cachedplayer.id )
                {
                    dict = [];
                    dict[ "a" ] = function_4a8b8b259c1819c7( player );
                    dict[ "isAlive" ] = bots_gametype_super_shared::isaliveplayer( player );
                    dict[ "isEliminated" ] = player bots_gametype_br_super::iseliminated();
                    
                    if ( isbrgamemode() )
                    {
                        dict[ "isGhost" ] = player br_public::function_f15af281b8fa7b96();
                    }
                    
                    dict[ "isUIBot" ] = player manager::isuibot();
                    dict[ "c" ] = player.health;
                    
                    if ( player br_public::isplayerinorgoingtogulag() )
                    {
                        dict[ "r" ] = player.arena.gulagindex;
                    }
                    
                    logdictionary( 31, dict );
                    break;
                }
            }
            
            assertmsg( "<dev string:x56>" );
        }
    }
}

// Namespace namespace_ddca46d216b096e2
// Params 2
// Checksum 0xf728a2a8, Offset: 0x4339
// Size: 0x46
function logdictionary( type, dictionary )
{
    if ( !isenabled() )
    {
        return;
    }
    
    if ( !isdefined( dictionary ) || dictionary.size == 0 )
    {
        return rawoutput( type, "" );
    }
    
    function_34458eed565d6ece( type, dictionary );
}

// Namespace namespace_ddca46d216b096e2
// Params 2
// Checksum 0x92556927, Offset: 0x4387
// Size: 0x11d
function function_a7d100dc69c01a62( ent, customproperties )
{
    if ( !isenabled() )
    {
        return;
    }
    
    dict = [];
    dict[ "id" ] = function_4a8b8b259c1819c7( ent );
    
    if ( isdefined( customproperties ) && customproperties.size > 0 )
    {
        foreach ( key, value in customproperties )
        {
            if ( !isdefined( key ) || !isstring( key ) )
            {
                assertmsg( "<dev string:x72>" );
                continue;
            }
            
            if ( function_cff9581923a65393( key ) )
            {
                continue;
            }
            
            if ( !isdefined( value ) )
            {
                dict[ key ] = value;
                continue;
            }
            
            normalizedvalue = function_1c618c8b58c6bf79( key, value );
            
            if ( isdefined( normalizedvalue ) )
            {
                dict[ key ] = normalizedvalue;
            }
        }
    }
    
    logdictionary( 22, dict );
}

// Namespace namespace_ddca46d216b096e2
// Params 1, eflags: 0x4
// Checksum 0x8a42688e, Offset: 0x44ac
// Size: 0x18, Type: bool
function private function_cff9581923a65393( key )
{
    return tolower( key ) == "id";
}

// Namespace namespace_ddca46d216b096e2
// Params 2, eflags: 0x4
// Checksum 0xe63922ee, Offset: 0x44cd
// Size: 0x59
function private function_1c618c8b58c6bf79( key, value )
{
    if ( isint( value ) || isfloat( value ) || isvector( value ) )
    {
        return value;
    }
    
    if ( isstring( value ) )
    {
        return formatstring( value, 1 );
    }
    
    assertmsg( "<dev string:xae>" + key );
}

// Namespace namespace_ddca46d216b096e2
// Params 2
// Checksum 0xac4b4bcb, Offset: 0x452f
// Size: 0x93
function function_529e97514b934b19( type, var_6b4eab70d6e131eb )
{
    if ( !isenabled() )
    {
        return;
    }
    
    if ( !isdefined( var_6b4eab70d6e131eb ) || var_6b4eab70d6e131eb.size == 0 )
    {
        return rawoutput( type, "" );
    }
    
    arraystr = function_5632f9690da945c8( var_6b4eab70d6e131eb );
    unfinished = 1;
    
    for ( i = 0; i < arraystr.size ; i++ )
    {
        if ( i == arraystr.size - 1 )
        {
            unfinished = 0;
        }
        
        rawoutput( type, arraystr[ i ], unfinished );
    }
}

// Namespace namespace_ddca46d216b096e2
// Params 2
// Checksum 0x283d4d43, Offset: 0x45ca
// Size: 0x46
function logarray( type, stringarray )
{
    if ( !isenabled() )
    {
        return;
    }
    
    if ( !isdefined( stringarray ) || stringarray.size == 0 )
    {
        return rawoutput( type, "" );
    }
    
    function_a821b7f3b954b60b( type, stringarray );
}

// Namespace namespace_ddca46d216b096e2
// Params 3
// Checksum 0x8fbabf3e, Offset: 0x4618
// Size: 0x73
function rawoutput( type, string, unfinished )
{
    if ( !isenabled() )
    {
        return;
    }
    
    connectstr = " ";
    
    if ( unfinished )
    {
        connectstr = "/ ";
    }
    
    outputstr = connectstr + type + " " + string;
    assert( outputstr.size < 2048 );
    botsbehavioranalyzerlog( outputstr );
}

// Namespace namespace_ddca46d216b096e2
// Params 1
// Checksum 0x60b03c2a, Offset: 0x4693
// Size: 0xe5
function function_5632f9690da945c8( var_6b4eab70d6e131eb )
{
    assert( isarray( var_6b4eab70d6e131eb ) );
    assert( var_6b4eab70d6e131eb.size % 2 == 0 );
    ret = [];
    
    if ( var_6b4eab70d6e131eb.size == 0 )
    {
        return ret;
    }
    
    str = "";
    i = 0;
    
    while ( i < var_6b4eab70d6e131eb.size )
    {
        key = var_6b4eab70d6e131eb[ i ];
        val = var_6b4eab70d6e131eb[ i + 1 ];
        
        if ( !isdefined( key ) )
        {
            assertmsg( "<dev string:xee>" + i );
            break;
        }
        
        attendstr = formatkeyvalue( key, val );
        
        if ( str.size + attendstr.size >= 1920 )
        {
            ret[ ret.size ] = str;
            str = "";
        }
        
        str += attendstr;
        i += 2;
    }
    
    ret[ ret.size ] = str;
    return ret;
}

// Namespace namespace_ddca46d216b096e2
// Params 2
// Checksum 0x892a6bf0, Offset: 0x4781
// Size: 0x93
function formatkeyvalue( key, val )
{
    assert( isstring( key ) );
    result = key + "=";
    
    if ( !isdefined( val ) )
    {
        result += "undefined;";
    }
    else if ( isint( val ) || isfloat( val ) || isvector( val ) || isstring( val ) )
    {
        result += val + ";";
    }
    else
    {
        assertmsg( "<dev string:x107>" + key );
    }
    
    return result;
}

// Namespace namespace_ddca46d216b096e2
// Params 1
// Checksum 0x9fb8a3e, Offset: 0x481d
// Size: 0x6b
function formatentityname( ent )
{
    if ( isplayer( ent ) || isagent( ent ) )
    {
        return function_4a8b8b259c1819c7( ent );
    }
    
    prefix = ent.classname + ": ";
    id = ent getentitynumber();
    idstr = formatstring( prefix + id );
    return idstr;
}

// Namespace namespace_ddca46d216b096e2
// Params 1
// Checksum 0x1eb106c3, Offset: 0x4891
// Size: 0x4b
function function_4a8b8b259c1819c7( player )
{
    if ( !isdefined( player.var_8dc2f17bb1ace10f ) )
    {
        player.var_8dc2f17bb1ace10f = function_c80a4abe3aa8041d( function_6943b5b53808407d( player ), isbot( player ), isagent( player ) );
    }
    
    return player.var_8dc2f17bb1ace10f;
}

// Namespace namespace_ddca46d216b096e2
// Params 1
// Checksum 0x54d92774, Offset: 0x48e5
// Size: 0x71
function function_6943b5b53808407d( player )
{
    bba_id = undefined;
    
    if ( !isai( player ) )
    {
        bba_id = player getentitynumber();
    }
    else if ( isagent( player ) || !isdefined( player.uibotprofile ) )
    {
        bba_id = player.bba_id;
    }
    else
    {
        bba_id = player.uibotprofile.bba_id;
    }
    
    return bba_id;
}

// Namespace namespace_ddca46d216b096e2
// Params 3
// Checksum 0xde6f387c, Offset: 0x495f
// Size: 0x74
function function_c80a4abe3aa8041d( bbaid, isbot, isagent )
{
    prefix = isagent ? "a_" : isbot ? "b_" : "h_";
    
    if ( !isdefined( bbaid ) )
    {
        logstring( "FormatBBAId: bbaId is undefined, isBot=", isbot, ", isAgent=", isagent );
        bbaid = "undefined";
    }
    
    return formatstring( prefix + bbaid );
}

// Namespace namespace_ddca46d216b096e2
// Params 2
// Checksum 0xc985ab1f, Offset: 0x49dc
// Size: 0x57
function formatstring( str, strip = 0 )
{
    if ( !isstring( str ) )
    {
        assertmsg( "<dev string:x121>" );
        return "";
    }
    
    if ( strip )
    {
        str = function_2d8979cbbb7c6008( str );
    }
    
    return "\"" + str + "\"";
}

// Namespace namespace_ddca46d216b096e2
// Params 2
// Checksum 0x3f18d492, Offset: 0x4a3c
// Size: 0x2c
function function_91623df0765605e4( x, y )
{
    return "(" + x + ", " + y + ")";
}

// Namespace namespace_ddca46d216b096e2
// Params 1
// Checksum 0xb994917c, Offset: 0x4a71
// Size: 0xaf
function function_2d8979cbbb7c6008( str )
{
    chars = [ "|", ";", "\"", "#" ];
    
    foreach ( ch in chars )
    {
        str = removesubstr( str, ch );
    }
    
    return str;
}

