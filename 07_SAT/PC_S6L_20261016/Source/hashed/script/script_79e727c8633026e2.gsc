// script_79e727c8633026e2  (hash_79e727c8633026e2.gscc) (size: 12318 Bytes / 0x301e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x75fd109d (1979519133)
// size ...... 12318 (0x301e)
// includes .. 17  (offset: 0x2cd6)
// strings ... 51  (offset: 0x2d5e)
// dev strs .. 3   (offset: 0x2ffa)
// exports ... 24  (offset: 0x1d6e)
// cseg ...... 0x4a0 + 0x18ce (0x1d6e)
// imports ... 100 (offset: 0x212e)
// animtree1 . 0   (offset: 0x301e)
// animtree2 . 0   (offset: 0x301e)
#using script_3b0670880a9f4b4f;
#using script_65d213c1ef6ac784;
#using script_6a2ae28ba4b2c002;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_fortress;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_dmz_radiation;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dmz\gametypes\dmz_audio;
#using scripts\mp\dmz\gametypes\dmz_task_utils;
#using scripts\mp\gametypes\activity_manager;

#namespace namespace_b0d5e7f43c6af238;

// Namespace namespace_b0d5e7f43c6af238
// Params 1
// Checksum 0x6b032ac2, Offset: 0x4be
// Size: 0x127
function dmztask_getspawndata( data )
{
    spawnpoints = utility::getstructarray( "dmz_vehicledrive_start", "targetname" );
    destinations = utility::getstructarray( "dmz_vehicledrive_end", "targetname" );
    level.var_e40c20196da44a3 = [];
    
    foreach ( node in destinations )
    {
        if ( !br_dmz_radiation::function_704454416dce7454( node.origin ) )
        {
            level.var_e40c20196da44a3[ level.var_e40c20196da44a3.size ] = node;
        }
    }
    
    scriptable::scriptable_addusedcallbackbypart( "dmz_sliding_barn_door", &function_daa980c34a5280f3 );
    namespace_ae33899132c54ba6::function_4357964a6b7684ca();
    level.var_209035fc1e63a988 = utility::getstructarray( "heli_reinforceNode", "script_noteworthy" );
    thread debug_spawnvehicle();
    activity_manager::function_f61a1f535aab4194( data, &function_9af23dc37200bdfd, spawnpoints );
}

/#

    // Namespace namespace_b0d5e7f43c6af238
    // Params 0
    // Checksum 0xd323ab31, Offset: 0x5ed
    // Size: 0x16, Type: dev
    function function_746bdfc760ec9b18()
    {
        return utility::getstructarray( "<dev string:x24>", "<dev string:x3b>" );
    }

#/

// Namespace namespace_b0d5e7f43c6af238
// Params 2
// Checksum 0x187954f8, Offset: 0x60b
// Size: 0x250
function function_9af23dc37200bdfd( activity, node )
{
    task = dmz_task_utils::task_create( activity );
    task.funcs[ "onInit" ] = &function_c0464a717224b8d2;
    task.funcs[ "onPlayerJoined" ] = &function_1333983a5c3e60f0;
    task.funcs[ "onPlayerRemoved" ] = &function_9db258077dfde1db;
    task.funcs[ "onTeamAssigned" ] = &function_bb05c033d9b1cce1;
    task.funcs[ "onForceEnd" ] = &function_6c2cab40244a08f0;
    task.funcs[ "onTeamStart" ] = &function_d4a13d97c3baae0b;
    task.funcs[ "onCancel" ] = &function_e928b1812cb2ba2a;
    task.ref = "dmz_vehicledrive_explore";
    task.refindex = br_contract_manager::getquesttableindex( task.ref );
    task.node = node;
    
    if ( !isdefined( level.var_cf3c1e8f77d1ee3d ) )
    {
        level.var_cf3c1e8f77d1ee3d = 0;
    }
    
    task.assignmentname = "vehicleDriveMission" + level.var_cf3c1e8f77d1ee3d;
    level.var_cf3c1e8f77d1ee3d++;
    task.numagents = 0;
    mindist = getdvarint( @"hash_f6f97c5aeaf073ca", 30000 );
    maxdist = getdvarint( @"hash_b8ec1183dfc532cc", 60000 );
    destinations = arrayrandomize( utility::get_array_of_closest( task.node.origin, level.var_e40c20196da44a3, undefined, undefined, maxdist, mindist ) );
    
    foreach ( dest in destinations )
    {
        if ( !dest.inuse )
        {
            task.end = dest;
            dest.inuse = 1;
            break;
        }
    }
    
    return task;
}

// Namespace namespace_b0d5e7f43c6af238
// Params 0
// Checksum 0x13968a00, Offset: 0x864
// Size: 0x29b
function function_c0464a717224b8d2()
{
    if ( !isdefined( self.node ) )
    {
        return;
    }
    
    dmz_task_utils::function_b3476f99a8e21fa2( self.node.origin + ( 0, 0, 60 ) );
    
    if ( !isdefined( self.end ) || !vehicle::is_loaded( %"hash_406987d5bb9cf080" ) )
    {
        dmz_task_utils::task_ended();
        return;
    }
    
    self.activity.origin = self.node.origin;
    self.techo = function_a0d4d8c69e61721c( self.node );
    self.techo vehicleshowonminimap( 0 );
    self.techo.godmode = 1;
    self.vehicle = self.techo;
    ai_fortress::function_e71f78419c88477e( self.techo.origin, "vehicle_forts", 0, 1, 0, 0, 0 );
    vehicle_interact::allow_use( self.techo, 0 );
    function_b135c8c4417e3a26();
    garagedoors = getentitylessscriptablearray( undefined, undefined, self.node.origin, 1024, "dmz_sliding_barn_door" );
    
    if ( garagedoors.size > 0 )
    {
        self.garagedoor = garagedoors[ 0 ];
        self.garagedoor.track = spawnscriptable( "door_metal_barn_02_track", self.garagedoor.origin, self.garagedoor.angles );
        self.garagedoor setscriptablepartstate( "dmz_sliding_barn_door", "locked_unusable" );
        self.garagedoor.navblocker = createnavobstaclebybounds( self.garagedoor.origin + anglestoright( self.garagedoor.angles ) * -125, ( 10, 125, 10 ), self.garagedoor.angles );
    }
    else
    {
        assertmsg( "<dev string:x46>" + self.node.origin );
    }
    
    ai_mp_controller::function_2b1cc53b284373( &function_e9b0ab51e0750639, self );
    self.techo vehicle_settopspeedforward( 30 );
    self.techo vehicle_settopspeedreverse( 30 );
    var_805b6c95abf49bc5 = 1;
    
    if ( var_805b6c95abf49bc5 )
    {
        self.helidata = namespace_abdf64fc596be565::function_7d86b1d8eb835027();
        return;
    }
    
    self.helidata = namespace_112e5e9b0fbdf8a::function_7d86b1d8eb835027();
}

// Namespace namespace_b0d5e7f43c6af238
// Params 1
// Checksum 0x8c87853a, Offset: 0xb07
// Size: 0x18e
function function_bb05c033d9b1cce1( teamname )
{
    players = teams::getteamdata( teamname, "players" );
    dmz_task_utils::task_showsplashtoteam( "dmz_vehicledrive_assigned", teamname );
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"vehicledrive_accept", teamname, 2 );
    dmz_audio::function_32ff837bc21a4833( teamname, "dmz_activity_start", 1.5, "dmz_activity_start_classic" );
    self.garagedoor setscriptablepartstate( "dmz_sliding_barn_door", "locked" );
    
    foreach ( player in level.players )
    {
        self.garagedoor disablescriptableplayeruse( player );
    }
    
    foreach ( player in players )
    {
        self.garagedoor enablescriptableplayeruse( player );
    }
    
    thread function_79e291d7254dca7c();
    thread function_e56c1997dd37a2df();
    thread function_66413b8318f9f9a1();
}

// Namespace namespace_b0d5e7f43c6af238
// Params 1
// Checksum 0x438cf2e5, Offset: 0xc9d
// Size: 0x255
function function_d4a13d97c3baae0b( teamname )
{
    level endon( #"game_ended" );
    self.techo endon( #"death" );
    self endon( #"task_ended" );
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"vehicledrive_assign", teamname );
    dmz_audio::function_32ff837bc21a4833( teamname, "dmz_activity_tension", 0, "dmz_activity_tension_classic" );
    areaorigin = self.techo.origin;
    techodriver = undefined;
    
    while ( !isdefined( techodriver ) || isdefined( techodriver ) && isdefined( techodriver.team ) && techodriver.team != self.teams[ 0 ] )
    {
        techodriver = vehicle_occupancy::get_driver( self.techo, 1 );
        wait 0.1;
    }
    
    dmz_task_utils::function_844c661c74b52ce3( "dmz_vehicledrive" );
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"vehicledrive_destination", teamname, 3 );
    self thread [[ self.helidata.var_b1b3897987cfbae3 ]]();
    dmz_task_utils::function_c74c010e593f5ea5( self.end.origin + ( 0, 0, 50 ) );
    
    while ( isdefined( self.techo ) && distance2dsquared( self.techo.origin, areaorigin ) < 9000000 )
    {
        wait 0.1;
    }
    
    self.c4heli = self [[ self.helidata.spawnheli ]]( self.techo );
    self.techo.var_2e2ed02cfb0c625d = techodriver.team;
    self.techo makeentitysentient( self.techo.var_2e2ed02cfb0c625d );
    self.techo makeentitynomeleetarget();
    thread function_c568ca5af2f388c( teamname );
    wait 5;
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"vehicledrive_enemyheliinbound", teamname );
    dmz_audio::function_32ff837bc21a4833( teamname, "dmz_boss_chopper_combat", 1.5 );
}

// Namespace namespace_b0d5e7f43c6af238
// Params 1
// Checksum 0x7b6dd079, Offset: 0xefa
// Size: 0x21
function function_1333983a5c3e60f0( player )
{
    self.garagedoor enablescriptablepartplayeruse( "dmz_sliding_barn_door", player );
}

// Namespace namespace_b0d5e7f43c6af238
// Params 1
// Checksum 0x206f62cb, Offset: 0xf23
// Size: 0x21
function function_9db258077dfde1db( player )
{
    self.garagedoor disablescriptablepartplayeruse( "dmz_sliding_barn_door", player );
}

// Namespace namespace_b0d5e7f43c6af238
// Params 0
// Checksum 0xa5d9484e, Offset: 0xf4c
// Size: 0x9
function function_6c2cab40244a08f0()
{
    function_868fe24d51273c53();
}

// Namespace namespace_b0d5e7f43c6af238
// Params 1
// Checksum 0x426eac50, Offset: 0xf5d
// Size: 0xb4
function function_e928b1812cb2ba2a( teamname )
{
    players = teams::getteamdata( teamname, "players" );
    
    foreach ( player in players )
    {
        self.garagedoor disablescriptablepartplayeruse( "dmz_sliding_barn_door", player );
        player setplayermusicstate( "" );
    }
    
    function_2e3d50e4be2cc535();
}

// Namespace namespace_b0d5e7f43c6af238
// Params 0, eflags: 0x4
// Checksum 0xb57f1ac0, Offset: 0x1019
// Size: 0x65
function private function_868fe24d51273c53()
{
    ai_mp_controller::function_52ec288d11c14408( &function_e9b0ab51e0750639, self );
    dmz_task_utils::function_3ff46488beb193c7();
    
    if ( isdefined( self.c4heli ) )
    {
        self.c4heli thread [[ self.helidata.flyaway ]]();
    }
    
    if ( isdefined( self.extractheli ) )
    {
        self.extractheli.readytoleave = 1;
    }
}

// Namespace namespace_b0d5e7f43c6af238
// Params 1, eflags: 0x4
// Checksum 0xde4d5aad, Offset: 0x1086
// Size: 0x9c
function private function_2e3d50e4be2cc535( teamname )
{
    self endon( #"task_ended" );
    function_868fe24d51273c53();
    
    if ( isdefined( teamname ) )
    {
        utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"vehicledrive_packagesecure", teamname );
        dmz_audio::function_32ff837bc21a4833( teamname, "dmz_activity_win", 1.5, "dmz_activity_win_classic" );
        wait 5;
        dmz_task_utils::function_c64a66646904bc1( "dmz_vehicledrive_complete", "vehicledrive", self.activity.cashreward, teamname );
        dmz_task_utils::function_e533421ccebd7d79( teamname );
    }
    
    dmz_task_utils::task_ended( teamname );
}

// Namespace namespace_b0d5e7f43c6af238
// Params 1
// Checksum 0x2ac079f4, Offset: 0x112a
// Size: 0x14a
function function_a0d4d8c69e61721c( node )
{
    jltv = undefined;
    
    if ( getdvarint( @"hash_973bce2266588096" ) )
    {
        jltv = vehicle::spawn( %"hash_18c6740da7976e74", node );
        jltv.dontspawnhusk = 1;
    }
    else
    {
        node.script_modelname = "veh9_mil_lnd_jltv_turret_cargo_vehphys_mp";
        jltv = vehicle::spawn( %"hash_406987d5bb9cf080", node );
        jltv.dontspawnhusk = 1;
        jltv.var_1f4f9d64c04f05db = 1;
    }
    
    jltv.damageableparts[ "tag_bumper_front_damaged" ].healthvalue = 0;
    jltv.damageableparts[ "tag_bumper_back_damaged" ].healthvalue = 0;
    payload = spawn( "script_model", jltv.origin + ( 0, 0, 4 ) + anglestoforward( jltv.angles ) * -84 );
    payload.angles = jltv.angles;
    payload setmodel( "cargo_pallet_02_dmz_script" );
    payload linkto( jltv );
    jltv.payload = payload;
    thread function_9c477a2f0682d800( jltv );
    return jltv;
}

// Namespace namespace_b0d5e7f43c6af238
// Params 1
// Checksum 0x848c4789, Offset: 0x127d
// Size: 0xa0
function function_9c477a2f0682d800( vehicle )
{
    payload = vehicle.payload;
    vehicle waittill( #"death" );
    
    if ( isdefined( payload ) )
    {
        effect = "cargo_pallet_destruction";
        explosionpos = payload.origin;
        explosioneffect = spawnfx( level._effect[ effect ], explosionpos );
        triggerfx( explosioneffect );
        thread utility::play_sound_in_space( "mp_dmz_cargo_destroyed", explosionpos );
        payload delete();
        explosioneffect thread utility::delete_after_delay( 10 );
    }
}

// Namespace namespace_b0d5e7f43c6af238
// Params 0, eflags: 0x4
// Checksum 0x7892d1fe, Offset: 0x1325
// Size: 0x115
function private function_b135c8c4417e3a26()
{
    var_4dc19f4427afee = utility::getstructarray( "vehicledrive_guard", "targetname" );
    initiallocations = utility::get_array_of_closest( self.node.origin, var_4dc19f4427afee, undefined, undefined, 2000 );
    agents = [];
    
    for ( i = 0; i < initiallocations.size ; i++ )
    {
        angles = initiallocations[ i ].angles;
        origin = initiallocations[ i ].origin;
        aitype = ai_mp_controller::function_f7aef6871cda828( "ar" );
        agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, origin, angles, "high", "mission", "vehicleDriveGuards", undefined, undefined, undefined, self.node.script_poi );
        
        if ( isdefined( agent ) )
        {
            agents[ i ] = agent;
            thread ai_behavior::behavior_GuardStationary( agent );
        }
    }
    
    self.numagents += agents.size;
}

// Namespace namespace_b0d5e7f43c6af238
// Params 2, eflags: 0x4
// Checksum 0xddec9cb2, Offset: 0x1442
// Size: 0x54
function private function_e9b0ab51e0750639( params, task )
{
    agent = self;
    assignment = agent.assignment;
    
    if ( assignment == task.assignmentname )
    {
        task.numagents--;
    }
}

// Namespace namespace_b0d5e7f43c6af238
// Params 6, eflags: 0x4
// Checksum 0xb700eda7, Offset: 0x149e
// Size: 0x75
function private function_daa980c34a5280f3( instance, part, state, player, bautouse, usestring )
{
    instance setscriptablepartstate( "dmz_sliding_barn_door", "opening" );
    destroynavobstacle( instance.navblocker );
    instance.open = 1;
    instance notify( #"vehicledrive_dooropened" );
}

// Namespace namespace_b0d5e7f43c6af238
// Params 0
// Checksum 0x3c81dff6, Offset: 0x151b
// Size: 0xa9
function function_79e291d7254dca7c()
{
    level endon( #"game_ended" );
    self.techo endon( #"death" );
    self endon( #"task_ended" );
    
    if ( self.garagedoor.open )
    {
        vehicle_interact::allow_use( self.techo, 1 );
    }
    
    self.garagedoor waittill( #"vehicledrive_dooropened" );
    vehicle_interact::allow_use( self.techo, 1 );
    thread function_72f868a57bafa9b9();
    self.techo vehicleshowonminimap( 1 );
    self.techo.godmode = 0;
}

// Namespace namespace_b0d5e7f43c6af238
// Params 1, eflags: 0x4
// Checksum 0x7f4da41e, Offset: 0x15cc
// Size: 0x338
function private function_c568ca5af2f388c( teamname )
{
    self.techo endon( #"death" );
    self endon( #"task_ended" );
    var_edd52247474c7dab = 0;
    sqdist = squared( int( 100 ) );
    heliflyaway = 0;
    
    while ( true )
    {
        wait 0.1;
        
        if ( !( isdefined( self.techo ) && isdefined( self.techo.payload ) ) )
        {
            if ( isdefined( self.extractheli ) )
            {
                self.extractheli.readytoleave = 1;
                self.extractheli notify( #"hash_8182ff35fd9e24b8" );
            }
            
            if ( isdefined( self.c4heli ) )
            {
                self.c4heli thread [[ self.helidata.flyaway ]]();
                heliflyaway = 1;
            }
            
            return;
        }
        
        curdist = distancesquared( self.techo.payload.origin, self.end.origin );
        
        if ( curdist <= sqdist )
        {
            break;
        }
        
        if ( isdefined( self.c4heli ) && !heliflyaway && distancesquared( self.techo.origin, self.end.origin ) <= 20250000 )
        {
            self.c4heli thread [[ self.helidata.flyaway ]]();
            heliflyaway = 1;
        }
        
        if ( !var_edd52247474c7dab && curdist <= 256000000 )
        {
            players = teams::getteamdata( self.techo.var_2e2ed02cfb0c625d, "players" );
            
            if ( isdefined( players ) && players.size )
            {
                self.extractheli = players[ 0 ] namespace_ae33899132c54ba6::function_bd1f657f7943610d( self.end.origin, ( 0, 0, 80 ) );
            }
            
            utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"vehicledrive_extractinbound", self.techo.var_2e2ed02cfb0c625d );
            var_edd52247474c7dab = 1;
        }
    }
    
    self.techo.payload notsolid();
    waitframe();
    self.techo.payload unlink();
    self.techo.payload linkto( self.extractheli.crate, "tag_origin", ( 0, 0, -110 ), ( 0, 0, 0 ) );
    self notify( #"payload_delivered" );
    self.extractheli.readytoleave = 1;
    self.extractheli notify( #"hash_8182ff35fd9e24b8" );
    thread function_2e3d50e4be2cc535( self.teams[ 0 ] );
    self.extractheli.crate playsoundonmovingent( "mp_dmz_cargo_delivery_hook" );
}

// Namespace namespace_b0d5e7f43c6af238
// Params 0
// Checksum 0xb08eb2fa, Offset: 0x190c
// Size: 0x128
function function_72f868a57bafa9b9()
{
    level endon( #"game_ended" );
    self endon( #"payload_delivered" );
    self endon( #"task_ended" );
    self.techo endon( #"death" );
    
    while ( true )
    {
        if ( isdefined( self.techo ) && isdefined( self.techo.occupants ) )
        {
            driver = vehicle_occupancy::get_driver( self.techo, 1 );
            
            if ( isdefined( driver ) && isdefined( driver.team ) && driver.team != self.teams[ 0 ] )
            {
                utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"activity_failed", self.teams[ 0 ], 2 );
                dmz_task_utils::task_showsplashtoteam( "dmz_vehicledrive_fail_stolen", self.teams[ 0 ] );
                dmz_audio::function_32ff837bc21a4833( self.teams[ 0 ], "dmz_activity_lose", 1, "dmz_activity_lose_classic" );
                function_2e3d50e4be2cc535();
                return;
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_b0d5e7f43c6af238
// Params 0, eflags: 0x4
// Checksum 0x3b8f7cdb, Offset: 0x1a3c
// Size: 0xa9
function private function_e56c1997dd37a2df()
{
    level endon( #"game_ended" );
    self endon( #"payload_delivered" );
    self endon( #"task_ended" );
    self.techo waittill( #"death" );
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"activity_failed", self.teams[ 0 ], 2 );
    dmz_task_utils::task_showsplashtoteam( "dmz_vehicledrive_fail_destroyed", self.teams[ 0 ] );
    dmz_audio::function_32ff837bc21a4833( self.teams[ 0 ], "dmz_activity_lose", 1, "dmz_activity_lose_classic" );
    function_2e3d50e4be2cc535();
}

// Namespace namespace_b0d5e7f43c6af238
// Params 0
// Checksum 0x2f761055, Offset: 0x1aed
// Size: 0x10d
function function_66413b8318f9f9a1()
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    
    while ( true )
    {
        players = teams::getteamdata( self.teams[ 0 ], "players" );
        
        foreach ( player in players )
        {
            dist = distance2dsquared( player.origin, self.garagedoor.origin );
            
            if ( dist < 562500 )
            {
                utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"vehicledrive_neardoor", players );
                return;
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_b0d5e7f43c6af238
// Params 0
// Checksum 0x447bf8cf, Offset: 0x1c02
// Size: 0x16c
function debug_spawnvehicle()
{
    while ( true )
    {
        if ( getdvarint( @"hash_361e499f400fee2a", 0 ) )
        {
            setdvar( @"hash_361e499f400fee2a", 0 );
            node = spawnstruct();
            node.origin = level.players[ 0 ].origin + anglestoforward( level.players[ 0 ].angles ) * 500 + ( 0, 0, 200 );
            node.angles = level.players[ 0 ].angles;
            function_a0d4d8c69e61721c( node );
        }
        
        if ( getdvarint( @"hash_e04153469eda5d1d", 0 ) )
        {
            setdvar( @"hash_e04153469eda5d1d", 0 );
            node = spawnstruct();
            node.origin = level.players[ 0 ].origin + anglestoforward( level.players[ 0 ].angles ) * 500 + ( 0, 0, 200 );
            node.angles = level.players[ 0 ].angles;
            node namespace_ae33899132c54ba6::function_bd1f657f7943610d( node.origin, ( 0, 0, 20 ) );
        }
        
        wait 1;
    }
}

