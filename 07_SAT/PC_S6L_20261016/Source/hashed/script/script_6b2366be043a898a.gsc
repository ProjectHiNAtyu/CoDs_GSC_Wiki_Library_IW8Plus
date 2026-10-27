// script_6b2366be043a898a  (hash_6b2366be043a898a.gscc) (size: 14076 Bytes / 0x36fc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4f7ba2dc (1333502684)
// size ...... 14076 (0x36fc)
// includes .. 20  (offset: 0x32d0)
// strings ... 53  (offset: 0x3370)
// dev strs .. 3   (offset: 0x3670)
// exports ... 30  (offset: 0x20e0)
// cseg ...... 0x53a + 0x1ba6 (0x20e0)
// imports ... 112 (offset: 0x2590)
// animtree1 . 2   (offset: 0x3698)
// animtree2 . 4   (offset: 0x36b8)
#using script_3b0670880a9f4b4f;
#using script_65d213c1ef6ac784;
#using script_6a2ae28ba4b2c002;
#using script_79e727c8633026e2;
#using scripts\common\anim;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_spawn;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_dmz_radiation;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dmz\gametypes\dmz_audio;
#using scripts\mp\dmz\gametypes\dmz_task_utils;
#using scripts\mp\gametypes\activity_manager;

#namespace namespace_60341451ae3e5462;

// Namespace namespace_60341451ae3e5462
// Params 1
// Checksum 0x1c1ef802, Offset: 0x558
// Size: 0x27e
function dmztask_getspawndata( data )
{
    potentialstarts = arrayrandomize( utility::getstructarray( "dmz_boatdrive_start", "script_noteworthy" ) );
    potentialends = arrayrandomize( utility::getstructarray( "dmz_boatdrive_end", "script_noteworthy" ) );
    level.var_5b7a97ef19d32c45 = [];
    
    foreach ( node in potentialends )
    {
        if ( !br_dmz_radiation::function_704454416dce7454( node.origin ) )
        {
            level.var_5b7a97ef19d32c45[ level.var_5b7a97ef19d32c45.size ] = node;
        }
    }
    
    level.boatdrivestarts = [];
    
    foreach ( start in potentialstarts )
    {
        foreach ( end in level.var_5b7a97ef19d32c45 )
        {
            if ( end.inuse )
            {
                continue;
            }
            
            dist = distance2d( start.origin, end.origin );
            
            if ( dist > 25000 && dist < 40000 )
            {
                start.end = end;
                end.start = start;
                end.inuse = 1;
                level.boatdrivestarts[ level.boatdrivestarts.size ] = start;
            }
        }
    }
    
    function_67c4a3dfafbe5b73();
    namespace_ae33899132c54ba6::function_4357964a6b7684ca();
    
    /#
        thread function_945fbb1c05fdd626();
    #/
    
    activity_manager::function_f61a1f535aab4194( data, &function_3a6656bbc0883ac9, level.boatdrivestarts );
}

/#

    // Namespace namespace_60341451ae3e5462
    // Params 0
    // Checksum 0x41770d6b, Offset: 0x7de
    // Size: 0x16, Type: dev
    function function_746bdfc760ec9b18()
    {
        return utility::getstructarray( "<dev string:x24>", "<dev string:x38>" );
    }

#/

// Namespace namespace_60341451ae3e5462
// Params 2
// Checksum 0x9c9324ec, Offset: 0x7fc
// Size: 0x167
function function_3a6656bbc0883ac9( activity, node )
{
    task = dmz_task_utils::task_create( activity );
    task.funcs[ "onInit" ] = &function_c0464a717224b8d2;
    task.funcs[ "onPlayerJoined" ] = &function_1333983a5c3e60f0;
    task.funcs[ "onPlayerRemoved" ] = &function_9db258077dfde1db;
    task.funcs[ "onTeamAssigned" ] = &function_bb05c033d9b1cce1;
    task.funcs[ "onForceEnd" ] = &function_6c2cab40244a08f0;
    task.funcs[ "onTeamStart" ] = &function_d4a13d97c3baae0b;
    task.funcs[ "onCancel" ] = &function_e928b1812cb2ba2a;
    task.ref = "dmz_boatdrive_explore";
    task.refindex = br_contract_manager::getquesttableindex( task.ref );
    task.node = node;
    task.end = node.end;
    
    if ( !isdefined( level.var_bea294a3c2aa5137 ) )
    {
        level.var_bea294a3c2aa5137 = 0;
    }
    
    task.assignmentname = "boatDriveMission" + level.var_bea294a3c2aa5137;
    level.var_bea294a3c2aa5137++;
    task.numagents = 0;
    return task;
}

// Namespace namespace_60341451ae3e5462
// Params 0
// Checksum 0xa2bd7d34, Offset: 0x96c
// Size: 0xc7
function function_c0464a717224b8d2()
{
    if ( !isdefined( self.node ) )
    {
        return;
    }
    
    dmz_task_utils::function_b3476f99a8e21fa2( self.node.origin + ( 0, 0, 60 ) );
    
    if ( !isdefined( self.end ) || !vehicle::is_loaded( "veh9_patrol_boat" ) )
    {
        dmz_task_utils::task_ended();
        return;
    }
    
    self.activity.origin = self.node.origin;
    ai_mp_controller::function_2b1cc53b284373( &function_e9b0ab51e0750639, self );
    var_805b6c95abf49bc5 = 1;
    
    if ( var_805b6c95abf49bc5 )
    {
        self.helidata = namespace_abdf64fc596be565::function_7d86b1d8eb835027();
        return;
    }
    
    self.helidata = namespace_112e5e9b0fbdf8a::function_7d86b1d8eb835027();
}

// Namespace namespace_60341451ae3e5462
// Params 1
// Checksum 0x898cc61e, Offset: 0xa3b
// Size: 0xb0
function function_bb05c033d9b1cce1( teamname )
{
    players = teams::getteamdata( teamname, "players" );
    dmz_task_utils::task_showsplashtoteam( "dmz_boatdrive_accept", teamname );
    thread function_92dd7d79bf43252c();
    
    if ( br_gametype_dmz::function_e6d940bc5935f1ba() )
    {
        utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"boatdrive_assigned_generic", teamname, 2 );
    }
    else
    {
        utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"boatdrive_assigned", teamname, 2 );
    }
    
    dmz_audio::function_32ff837bc21a4833( teamname, "dmz_activity_start", 1.5, "dmz_activity_start_classic" );
}

// Namespace namespace_60341451ae3e5462
// Params 1
// Checksum 0x25c9c7a1, Offset: 0xaf3
// Size: 0x73
function function_d4a13d97c3baae0b( teamname )
{
    if ( isdefined( self.boat ) )
    {
        utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"boatdrive_approach", teamname );
    }
    else
    {
        utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"boatdrive_approach_dropped", teamname );
    }
    
    dmz_audio::function_32ff837bc21a4833( teamname, undefined, 0 );
}

// Namespace namespace_60341451ae3e5462
// Params 1
// Checksum 0xfb376b80, Offset: 0xb6e
// Size: 0xc
function function_1333983a5c3e60f0( player )
{
    
}

// Namespace namespace_60341451ae3e5462
// Params 1
// Checksum 0x4bdfb7ee, Offset: 0xb82
// Size: 0xc
function function_9db258077dfde1db( player )
{
    
}

// Namespace namespace_60341451ae3e5462
// Params 0
// Checksum 0x84315b33, Offset: 0xb96
// Size: 0x9
function function_6c2cab40244a08f0()
{
    function_868fe24d51273c53();
}

// Namespace namespace_60341451ae3e5462
// Params 1
// Checksum 0xa1223245, Offset: 0xba7
// Size: 0x13
function function_e928b1812cb2ba2a( teamname )
{
    function_2e3d50e4be2cc535();
}

// Namespace namespace_60341451ae3e5462
// Params 0, eflags: 0x4
// Checksum 0x949709bd, Offset: 0xbc2
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

// Namespace namespace_60341451ae3e5462
// Params 1, eflags: 0x4
// Checksum 0x93412902, Offset: 0xc2f
// Size: 0x9c
function private function_2e3d50e4be2cc535( teamname )
{
    self endon( #"task_ended" );
    function_868fe24d51273c53();
    
    if ( isdefined( teamname ) )
    {
        utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"boatdrive_heli_extracted", teamname );
        dmz_audio::function_32ff837bc21a4833( teamname, "dmz_activity_win", 1.5, "dmz_activity_win_classic" );
        wait 5;
        dmz_task_utils::function_c64a66646904bc1( "dmz_boatdrive_complete", "vehicledrive", self.activity.cashreward, teamname );
        dmz_task_utils::function_e533421ccebd7d79( teamname );
    }
    
    dmz_task_utils::task_ended( teamname );
}

// Namespace namespace_60341451ae3e5462
// Params 0
// Checksum 0x1bb46cfe, Offset: 0xcd3
// Size: 0x30e
function function_92dd7d79bf43252c()
{
    self endon( #"task_ended" );
    level endon( #"game_ended" );
    ownerplayer = undefined;
    players = teams::getteamdata( self.teams[ 0 ], "players" );
    
    if ( !isdefined( players ) )
    {
        function_2e3d50e4be2cc535();
        return;
    }
    
    for ( i = 0; i < players.size && !isdefined( ownerplayer ) ; i++ )
    {
        ownerplayer = players[ i ];
    }
    
    if ( !isdefined( ownerplayer ) )
    {
        function_2e3d50e4be2cc535();
        return;
    }
    
    self.boat = function_919309df882fdcba( self.node.origin, self.node.angles, ownerplayer );
    self.vehicle = self.boat;
    
    if ( !self.boat.deployed )
    {
        self.boat waittill( #"deployed" );
    }
    
    thread function_72f868a57bafa9b9();
    thread function_e56c1997dd37a2df();
    dmz_task_utils::function_512f23b3619333d1( self.boat, 50 );
    dmz_task_utils::function_844c661c74b52ce3( "dmz_boatdrive_wait" );
    
    for ( driver = undefined; !isdefined( driver ) ; driver = vehicle_occupancy::get_driver( self.boat, 1 ) )
    {
        wait 0.1;
    }
    
    areaorigin = self.boat.origin;
    self.boat function_c21d39b1929f7cb1( 0 );
    dmz_task_utils::function_844c661c74b52ce3( "dmz_boatdrive" );
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"boatdrive_entered", self.teams[ 0 ], 3 );
    self thread [[ self.helidata.var_b1b3897987cfbae3 ]]();
    dmz_task_utils::function_c74c010e593f5ea5( self.end.origin + ( 0, 0, 50 ) );
    self.boat.var_2e2ed02cfb0c625d = driver.team;
    self.boat makeentitysentient( self.boat.var_2e2ed02cfb0c625d );
    self.boat makeentitynomeleetarget();
    
    while ( isdefined( self.boat ) && distance2dsquared( self.boat.origin, areaorigin ) < 9000000 )
    {
        wait 0.1;
    }
    
    self.c4heli = self [[ self.helidata.spawnheli ]]( self.boat );
    thread function_c568ca5af2f388c( self.teams[ 0 ] );
    wait 5;
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"vehicledrive_enemyheliinbound", self.teams[ 0 ] );
    dmz_audio::function_32ff837bc21a4833( self.teams[ 0 ], "dmz_boss_chopper_combat", 1.5 );
}

// Namespace namespace_60341451ae3e5462
// Params 3
// Checksum 0x2bfd534d, Offset: 0xfe9
// Size: 0xb7
function function_b2678653fcff7f23( owner, pos, angles )
{
    data = spawnstruct();
    data.origin = pos;
    data.angles = angles;
    data.team = owner.team;
    data vehicle_spawn::set_flag( 6 );
    heli = vehicle::spawn( "veh9_blima", data );
    heli.animname = "blima";
    heli vehicle_damage::set_can_damage( 0 );
    heli.callingteam = owner.team;
    return heli;
}

// Namespace namespace_60341451ae3e5462
// Params 0, eflags: 0x4
// Checksum 0xeac677a4, Offset: 0x10a9
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

// Namespace namespace_60341451ae3e5462
// Params 2, eflags: 0x4
// Checksum 0x4fb83ac4, Offset: 0x11c6
// Size: 0x47
function private function_e9b0ab51e0750639( params, task )
{
    assignment = self.assignment;
    
    if ( assignment == task.assignmentname )
    {
        task.numagents--;
    }
}

// Namespace namespace_60341451ae3e5462
// Params 1, eflags: 0x4
// Checksum 0x61bd71a7, Offset: 0x1215
// Size: 0x36d
function private function_c568ca5af2f388c( teamname )
{
    self.boat endon( #"death" );
    self endon( #"task_ended" );
    var_edd52247474c7dab = 0;
    sqdist = squared( int( 100 ) );
    heliflyaway = 0;
    
    while ( true )
    {
        wait 0.1;
        
        if ( !( isdefined( self.boat ) && isdefined( self.boat.payload ) ) )
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
        
        curdist = distancesquared( self.boat.payload.origin, self.end.origin );
        
        if ( curdist <= sqdist )
        {
            break;
        }
        
        if ( isdefined( self.c4heli ) && !heliflyaway && distancesquared( self.boat.origin, self.end.origin ) <= 20250000 )
        {
            self.c4heli thread [[ self.helidata.flyaway ]]();
            heliflyaway = 1;
        }
        
        if ( !var_edd52247474c7dab && curdist <= 256000000 )
        {
            players = teams::getteamdata( self.boat.var_2e2ed02cfb0c625d, "players" );
            
            if ( isdefined( players ) && players.size )
            {
                self.extractheli = players[ 0 ] namespace_ae33899132c54ba6::function_bd1f657f7943610d( self.end.origin, ( 0, 0, 60 ) );
            }
            
            utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"boatdrive_heli_exfil", self.boat.var_2e2ed02cfb0c625d );
            var_edd52247474c7dab = 1;
        }
    }
    
    self.boat.payload notsolid();
    waitframe();
    self.boat.payload unlink();
    self.boat.payload linkto( self.extractheli.crate, "tag_origin", ( 0, 0, -110 ), ( 0, 0, 0 ) );
    self notify( #"payload_delivered" );
    self.extractheli.readytoleave = 1;
    self.extractheli notify( #"hash_8182ff35fd9e24b8" );
    backturret = vehicle::function_95e3c2e0c6eec800( self.boat, "iw9_mg_patrol_boat_back_mp" );
    backturret.exit = backturret.prevexit;
    self.extractheli.crate playsoundonmovingent( "mp_dmz_cargo_delivery_hook" );
    thread function_2e3d50e4be2cc535( self.teams[ 0 ] );
}

// Namespace namespace_60341451ae3e5462
// Params 0
// Checksum 0x2328a290, Offset: 0x158a
// Size: 0x131
function function_72f868a57bafa9b9()
{
    level endon( #"game_ended" );
    self endon( #"payload_delivered" );
    self endon( #"task_ended" );
    self.boat endon( #"death" );
    
    while ( true )
    {
        if ( isdefined( self.boat ) && isdefined( self.boat.occupants ) )
        {
            driver = vehicle_occupancy::get_driver( self.boat, 1 );
            
            if ( isdefined( driver ) && isdefined( driver.team ) && driver.team != self.teams[ 0 ] )
            {
                dmz_task_utils::function_c64a66646904bc1( "dmz_boatdrive_fail_stolen", "vehicledrive", 0, self.teams[ 0 ] );
                utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"boatdrive_boat_stolen", self.teams[ 0 ], 2 );
                dmz_audio::function_32ff837bc21a4833( self.teams[ 0 ], "dmz_activity_lose", 1, "dmz_activity_lose_classic" );
                function_2e3d50e4be2cc535();
                return;
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_60341451ae3e5462
// Params 0, eflags: 0x4
// Checksum 0x9fc950f7, Offset: 0x16c3
// Size: 0xb2
function private function_e56c1997dd37a2df()
{
    level endon( #"game_ended" );
    self endon( #"payload_delivered" );
    self endon( #"task_ended" );
    self.boat waittill( #"death" );
    dmz_task_utils::function_c64a66646904bc1( "dmz_boatdrive_fail_destroyed", "vehicledrive", 0, self.teams[ 0 ] );
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"boatdrive_boat_destroyed", self.teams[ 0 ], 2 );
    dmz_audio::function_32ff837bc21a4833( self.teams[ 0 ], "dmz_activity_lose", 1, "dmz_activity_lose_classic" );
    function_2e3d50e4be2cc535();
}

#using_animtree( "script_model" );

// Namespace namespace_60341451ae3e5462
// Params 0
// Checksum 0x9d513f4a, Offset: 0x177d
// Size: 0x6b
function function_67c4a3dfafbe5b73()
{
    level.scr_animtree[ "rope1" ] = #animtree;
    level.scr_anim[ "rope1" ][ "armored_patrol_boat_dropoff" ] = %iw9_mp_armored_patrol_boat_dropoff_rope1;
    level.scr_animtree[ "rope2" ] = #animtree;
    level.scr_anim[ "rope2" ][ "armored_patrol_boat_dropoff" ] = %iw9_mp_armored_patrol_boat_dropoff_rope2;
    function_5316bb5562b1cc45();
}

#using_animtree( "mp_vehicles_always_loaded" );

// Namespace namespace_60341451ae3e5462
// Params 0
// Checksum 0xb6e1407, Offset: 0x17f0
// Size: 0x64
function function_5316bb5562b1cc45()
{
    level.scr_animtree[ "armored_patrol_boat" ] = #animtree;
    level.scr_anim[ "armored_patrol_boat" ][ "armored_patrol_boat_dropoff" ] = %iw9_mp_armored_patrol_boat_dropoff_boat;
    level.scr_animtree[ "blima" ] = #animtree;
    level.scr_anim[ "blima" ][ "armored_patrol_boat_dropoff" ] = %iw9_mp_armored_patrol_boat_dropoff_heli;
}

// Namespace namespace_60341451ae3e5462
// Params 0
// Checksum 0x8c4e22dd, Offset: 0x185c
// Size: 0x10
function function_fe1ed433cf7a79fe()
{
    wait 18;
    self playsoundonmovingent( "iw9_drop_chute_release" );
}

// Namespace namespace_60341451ae3e5462
// Params 0
// Checksum 0x25d4a57f, Offset: 0x1874
// Size: 0x13
function function_64216b6f24a92ff0()
{
    wait 2.25;
    self playsoundonmovingent( "mp_care_package_impact_water_body" );
}

// Namespace namespace_60341451ae3e5462
// Params 0
// Checksum 0xaff4822c, Offset: 0x188f
// Size: 0x15
function sfx_boat_dropoff()
{
    wait 6;
    self setscriptablepartstate( "boat_dropoff_sfx", "on" );
}

// Namespace namespace_60341451ae3e5462
// Params 2
// Checksum 0x169666d0, Offset: 0x18ac
// Size: 0x133
function function_2093bd0236dffd4a( origin, angles )
{
    boatspawndata = spawnstruct();
    boatspawndata.origin = origin;
    boatspawndata.angles = angles;
    boat = vehicle::spawn( "veh9_patrol_boat", boatspawndata );
    boat.animname = "armored_patrol_boat";
    backturret = vehicle::function_95e3c2e0c6eec800( boat, "iw9_mg_patrol_boat_back_mp" );
    backturret.prevexit = backturret.exit;
    backturret.exit = ( -100, 45, -7 );
    payload = spawn( "script_model", boat.origin + ( 0, 0, 5 ) + anglestoforward( boat.angles ) * -90 );
    payload.angles = boat.angles;
    payload setmodel( "cargo_pallet_02_dmz_script" );
    payload linkto( boat );
    boat.payload = payload;
    thread namespace_b0d5e7f43c6af238::function_9c477a2f0682d800( boat );
    return boat;
}

// Namespace namespace_60341451ae3e5462
// Params 3
// Checksum 0x83a6e5c7, Offset: 0x19e8
// Size: 0x2e8
function function_919309df882fdcba( origin, angles, player )
{
    sceneorigin = origin - ( -49.233, 15.251, -575.692 );
    sceneangles = angles;
    forward = anglestoforward( sceneangles );
    height = 700;
    var_ff54c79b2571e327 = 0;
    
    while ( height < 3000 )
    {
        middle = sceneorigin + ( 0, 0, height );
        start = middle - forward * 3000 + ( 0, 0, 1 ) * 2000;
        end = middle + forward * 3000 + ( 0, 0, 1 ) * 2000;
        trace = trace::sphere_trace( middle, start, 500 );
        
        if ( trace[ "hittype" ] == "hittype_none" )
        {
            trace = trace::sphere_trace( middle, end, 500 );
            
            if ( trace[ "hittype" ] == "hittype_none" )
            {
                var_ff54c79b2571e327 = 1;
                break;
            }
        }
        
        height += 200;
    }
    
    if ( !var_ff54c79b2571e327 )
    {
        boat = function_2093bd0236dffd4a( origin + 3000, angles );
        boat.deployed = 1;
        boat vehicleshowonminimap( 1 );
        return boat;
    }
    
    sceneorigin += ( 0, 0, height );
    boat = function_2093bd0236dffd4a( sceneorigin + rotatevector( ( -6491.19, 8.381, 2602.64 ), sceneangles ), combineangles( sceneangles, ( 21.543, 0, 0 ) ) );
    boat vehphys_forcekeyframedmotion();
    heli = function_b2678653fcff7f23( player, sceneorigin + rotatevector( ( -6226.31, 0, 3287.4 ), sceneangles ), combineangles( sceneangles, ( 8.289, 0, 0 ) ) );
    heli vehphys_forcekeyframedmotion();
    heli function_d2b8ee2e1275daaf( 1 );
    rope1 = spawn( "script_model", sceneorigin + rotatevector( ( -6233.72, -23.428, 3195.29 ), sceneangles ) );
    rope1.angles = combineangles( sceneangles, ( 7.507, -0.229, -1.363 ) );
    rope1 setmodel( "veh9_mil_air_heli_airdrop_rig" );
    rope1.animname = "rope1";
    rope1 animation::setanimtree();
    rope1 show();
    rope2 = spawn( "script_model", sceneorigin + rotatevector( ( -6233.57, 22.939, 3194.19 ), sceneangles ) );
    rope2.angles = combineangles( sceneangles, ( 7.507, -0.229, -1.363 ) );
    rope2 setmodel( "veh9_mil_air_heli_airdrop_rig" );
    rope2.animname = "rope2";
    rope2 animation::setanimtree();
    rope2 show();
    thread function_493f32205330f4c0( heli, rope1, rope2 );
    thread function_d5535aacc171bb03( boat );
    return boat;
}

// Namespace namespace_60341451ae3e5462
// Params 3
// Checksum 0x9b034399, Offset: 0x1cd9
// Size: 0x180
function function_493f32205330f4c0( heli, rope1, rope2 )
{
    helinode = spawnstruct();
    helinode.origin = heli.origin;
    helinode.angles = heli.angles;
    var_f254e468cd3f0bb5 = spawnstruct();
    var_f254e468cd3f0bb5.origin = rope1.origin;
    var_f254e468cd3f0bb5.angles = rope1.angles;
    var_860d7a621dc27270 = spawnstruct();
    var_860d7a621dc27270.origin = rope2.origin;
    var_860d7a621dc27270.angles = rope2.angles;
    var_f254e468cd3f0bb5 animation::anim_first_frame_solo( rope1, "armored_patrol_boat_dropoff" );
    var_860d7a621dc27270 animation::anim_first_frame_solo( rope2, "armored_patrol_boat_dropoff" );
    waitframe();
    var_f254e468cd3f0bb5 thread animation::anim_single_solo( rope1, "armored_patrol_boat_dropoff" );
    var_860d7a621dc27270 thread animation::anim_single_solo( rope2, "armored_patrol_boat_dropoff" );
    heli animscripted( "notify", helinode.origin, helinode.angles, %iw9_mp_armored_patrol_boat_dropoff_heli );
    heli thread sfx_boat_dropoff();
    duration = getanimlength( level.scr_anim[ "blima" ][ "armored_patrol_boat_dropoff" ] );
    wait duration;
    heli delete();
    rope1 delete();
    rope2 delete();
}

// Namespace namespace_60341451ae3e5462
// Params 1
// Checksum 0xbdc1e8cd, Offset: 0x1e61
// Size: 0xbf
function function_d5535aacc171bb03( boat )
{
    boatnode = spawnstruct();
    boatnode.origin = boat.origin;
    boatnode.angles = boat.angles;
    boatnode animation::anim_first_frame_solo( boat, "armored_patrol_boat_dropoff" );
    waitframe();
    boatnode thread animation::anim_single_solo( boat, "armored_patrol_boat_dropoff" );
    boat thread function_fe1ed433cf7a79fe();
    waittime = 18.0333;
    wait waittime;
    boat stopanimscripted();
    boat vehphys_setdefaultmotion();
    boat vehicleshowonminimap( 1 );
    boat.deployed = 1;
    boat notify( #"deployed" );
    boat thread function_64216b6f24a92ff0();
}

/#

    // Namespace namespace_60341451ae3e5462
    // Params 0
    // Checksum 0x1f9a4a91, Offset: 0x1f28
    // Size: 0x1b8, Type: dev
    function function_945fbb1c05fdd626()
    {
        heli = undefined;
        boat = undefined;
        rope1 = undefined;
        rope2 = undefined;
        
        while ( true )
        {
            if ( getdvarint( @"hash_fb8ea82d10086841", 0 ) )
            {
                setdvar( @"hash_fb8ea82d10086841", 0 );
                forward = anglestoforward( level.players[ 0 ] getplayerangles( 0 ) );
                right = anglestoright( level.players[ 0 ].angles );
                start = level.players[ 0 ] geteye();
                trace = trace::ray_trace( start, start + forward * 1000 );
                sphere( trace[ "<dev string:x4a>" ], 10, ( 1, 0, 0 ), 0, 1000000 );
                function_919309df882fdcba( trace[ "<dev string:x4a>" ], level.players[ 0 ].angles, level.players[ 0 ] );
            }
            
            if ( getdvarint( @"hash_ea9b91e4e6ffdfe0", 0 ) )
            {
                setdvar( @"hash_ea9b91e4e6ffdfe0", 0 );
                origin = level.players[ 0 ].origin + anglestoforward( level.players[ 0 ].angles ) * 500 + ( 0, 0, 200 );
                angles = level.players[ 0 ].angles;
                function_2093bd0236dffd4a( origin, angles );
            }
            
            wait 1;
        }
    }

#/
