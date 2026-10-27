// scripts\mp\common\equipment\sweeper_drones.gsc  (hash_1e5583994e2068a8.gscc) (size: 36280 Bytes / 0x8db8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb5ec3d5b (3052158299)
// size ...... 36280 (0x8db8)
// includes .. 27  (offset: 0x8490)
// strings ... 113 (offset: 0x8568)
// dev strs .. 9   (offset: 0x8d30)
// exports ... 68  (offset: 0x5e68)
// cseg ...... 0x978 + 0x54f0 (0x5e68)
// imports ... 208 (offset: 0x6908)
// animtree1 . 0   (offset: 0x8db8)
// animtree2 . 0   (offset: 0x8db8)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\snapshot;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_roads;
#using scripts\common\vehicle_tracking;
#using scripts\mp\chaff_debuff;
#using scripts\mp\challenges;
#using scripts\mp\common\killstreaks\helper_drone;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damagefeedback;
#using scripts\mp\entityheadicons;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\outofbounds;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace sweeper_drones;

// Namespace sweeper_drones
// Params 0, eflags: 0x1
// Checksum 0x93d308e5, Offset: 0x996
// Size: 0x1c
function autoexec main()
{
    if ( utility::function_9e8f69121ec4b65d( #"super_sweeper_drones" ) )
    {
        return;
    }
    
    init();
}

// Namespace sweeper_drones
// Params 0
// Checksum 0x85cd4bc8, Offset: 0x9ba
// Size: 0x2d9
function init()
{
    utility::flag_wait( "supers_initialized" );
    supers_mp::function_48aaa60b2ce7b8a1( "super_sweeper_drones" );
    level.helperdronesettings[ "sweeper_drone" ] = spawnstruct();
    level.helperdronesettings[ "sweeper_drone" ].maxhealth = 1;
    level.helperdronesettings[ "sweeper_drone" ].hitstokill = 1;
    level.helperdronesettings[ "sweeper_drone" ].speed = 20;
    level.helperdronesettings[ "sweeper_drone" ].accel = 35;
    level.helperdronesettings[ "sweeper_drone" ].spawndist = 30;
    level.helperdronesettings[ "sweeper_drone" ].vehicleinfo = "veh_sweeper_drone_mp";
    level.helperdronesettings[ "sweeper_drone" ].modelbase = "veh_mil_air_seeker_drone_mp";
    level.helperdronesettings[ "sweeper_drone" ].timeout = 45;
    level.helperdronesettings[ "sweeper_drone" ].premoddamagefunc = undefined;
    level.helperdronesettings[ "sweeper_drone" ].postmoddamagefunc = &helper_drone::helperdrone_postmodifydamage;
    level.helperdronesettings[ "sweeper_drone" ].targetname = "sweeper_drone";
    level.helperdronesettings[ "sweeper_drone" ].var_17e473e12ced7138 = 1;
    level.helperdronesettings[ "sweeper_drone" ].var_47cefc5b1c8b888f = physics_createcontents( [ "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_itemclip", "physicscontents_clipshot" ] );
    level.helperdronesettings[ "sweeper_drone" ].heightoffset = getdvarfloat( @"scr_sweeper_drone_ground_offset", 52 );
    level.sweeperdrones = spawnstruct();
    level.sweeperdrones.supername = "super_sweeper_drones";
    level.sweeperdrones.superbundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_sweeper_drones" );
    
    /#
        level.helperdronesettings[ "<dev string:x24>" ].var_5656d6269df25e83 = 0;
        level.helperdronesettings[ "<dev string:x24>" ].var_63e133316b17dfbd = 0;
    #/
    
    /#
        level thread function_ccec08c945911edf( level.helperdronesettings[ "<dev string:x24>" ] );
    #/
    
    /#
        setdevdvarifuninitialized( @"hash_78c658615886f5e7", 0 );
        setdevdvarifuninitialized( @"hash_c75b26d921a6f305", 1 );
        setdevdvarifuninitialized( @"hash_e48b5e4b71466223", 0 );
    #/
    
    weapons::registerusedcallback( "sweeper_drone", &sweeperdrone_used );
}

// Namespace sweeper_drones
// Params 2
// Checksum 0x38e445f4, Offset: 0xc9b
// Size: 0x6c
function function_206528a56bc992f4( grenade, explodedata )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    childthread function_72d577718591b9a2( grenade );
    childthread function_eb745cac707869fd( grenade, explodedata );
    childthread function_680755490cb7ed46( grenade, explodedata );
    self waittill( #"hash_47439598900e7d76", position );
    grenade delete();
    return position;
}

// Namespace sweeper_drones
// Params 2
// Checksum 0x7486722b, Offset: 0xd10
// Size: 0xe4
function function_680755490cb7ed46( grenade, explodedata )
{
    self endon( #"hash_47439598900e7d76" );
    explodedata.velocity = ( 0, 0, 0 );
    
    while ( true )
    {
        if ( !isdefined( self ) )
        {
            return;
        }
        
        if ( !( isdefined( grenade ) && isdefined( grenade.origin ) ) )
        {
            return;
        }
        
        if ( !isdefined( explodedata.lastorigin ) )
        {
            explodedata.lastorigin = grenade.origin;
        }
        
        if ( explodedata.lastorigin != grenade.origin )
        {
            explodedata.velocity = ( grenade.origin - explodedata.lastorigin ) / level.framedurationseconds;
            explodedata.lastorigin = grenade.origin;
        }
        
        waitframe();
    }
}

// Namespace sweeper_drones
// Params 2
// Checksum 0x97fe903a, Offset: 0xdfc
// Size: 0x8f
function function_eb745cac707869fd( grenade, explodedata )
{
    self endon( #"hash_47439598900e7d76" );
    droneconfig = level.helperdronesettings[ "sweeper_drone" ];
    
    while ( true )
    {
        /#
            if ( droneconfig.var_5656d6269df25e83 )
            {
                level thread debug_utility::drawangles( grenade.origin, grenade.angles, 30, 2 );
            }
        #/
        
        explodedata.angles = grenade.angles;
        waitframe();
    }
}

// Namespace sweeper_drones
// Params 1
// Checksum 0xd519bf39, Offset: 0xe93
// Size: 0x59
function function_a529a6e3c3287575( grenade )
{
    self endon( #"hash_47439598900e7d76" );
    grenade waittill( #"missile_stuck" );
    position = grenade.origin + ( 0, 0, 1.5 );
    self notify( #"hash_47439598900e7d76", position );
}

// Namespace sweeper_drones
// Params 1
// Checksum 0xbe0a0a4f, Offset: 0xef4
// Size: 0x5c
function function_72d577718591b9a2( grenade )
{
    self endon( #"hash_47439598900e7d76" );
    fusetime = getdvarfloat( @"scr_sweeper_drone_fuse_time", 0.32 );
    wait fusetime;
    position = grenade.origin;
    self notify( #"hash_47439598900e7d76", position );
}

// Namespace sweeper_drones
// Params 0
// Checksum 0x8598d3e0, Offset: 0xf58
// Size: 0x2a
function function_5a37a2489ae74cd1()
{
    self endon( #"hash_cedf498d5187ede5" );
    utility::waittill_any_ents( level, "game_ended", self, "disconnect" );
    vehicle_tracking::function_4f76f5b4541acef1( 1 );
}

// Namespace sweeper_drones
// Params 1
// Checksum 0xb085ee1b, Offset: 0xf8a
// Size: 0x698
function sweeperdrone_used( grenade )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !vehicle_tracking::reserve_vehicle( 1 ) )
    {
        return 0;
    }
    
    sweeperdata = function_ee9f62709472bfad();
    
    if ( isdefined( sweeperdata ) )
    {
        foreach ( drone in sweeperdata.drones )
        {
            drone thread sweeperdrone_destroy( self );
        }
    }
    
    thread function_5a37a2489ae74cd1();
    explodedata = spawnstruct();
    position = function_206528a56bc992f4( grenade, explodedata );
    velocity = explodedata.velocity;
    anglex = getdvarfloat( @"hash_3ce93c362fcf72e1", 6 );
    anglez = getdvarfloat( @"hash_3ce93a362fcf6e7b", 10 );
    angles = ( anglex, explodedata.angles[ 1 ], anglez );
    droneconfig = level.helperdronesettings[ "sweeper_drone" ];
    contents = droneconfig.var_47cefc5b1c8b888f;
    ignorearray = [ self ];
    var_79d1e5a09c003853 = position - utility::function_68061c3d21a6d57a();
    fwddir = utility::flatten_vector( var_79d1e5a09c003853 );
    projdist = vectordot( var_79d1e5a09c003853, fwddir );
    extradist = 0;
    
    if ( projdist < droneconfig.spawndist )
    {
        extradist = droneconfig.spawndist - projdist;
    }
    
    traceforward = trace::ray_trace( position, position + fwddir * extradist, ignorearray, contents );
    
    /#
        if ( droneconfig.var_5656d6269df25e83 )
        {
            level thread debug_utility::drawangles( position, explodedata.angles, 30, 4 );
        }
    #/
    
    if ( traceforward[ "hittype" ] != "hittype_none" || self.isinsideelevator )
    {
        /#
            if ( droneconfig.var_5656d6269df25e83 )
            {
                level thread debug_utility::drawsphere( traceforward[ "<dev string:x32>" ], 2, 30, ( 1, 0, 0 ) );
            }
        #/
        
        hud_message::showerrormessage( %"hash_50fa2a9308c1186f" );
        supers_mp::refundsuper();
        return;
    }
    
    position = traceforward[ "position" ];
    orientation = vectortoangles( fwddir );
    leftdir = anglestoleft( orientation );
    rightdir = anglestoright( orientation );
    updir = anglestoup( orientation );
    downdir = anglestoup( orientation ) * -1;
    var_6f46dab7eea7751d = vectornormalize( updir + leftdir );
    uprightdir = vectornormalize( updir + rightdir );
    var_c657b7b0fb4483b3 = vectornormalize( downdir + rightdir );
    var_eea16f3afe0a8852 = vectornormalize( downdir + leftdir );
    oppositedir = vectornormalize( velocity ) * -2;
    dirvecs = [ updir, var_6f46dab7eea7751d, uprightdir, oppositedir, leftdir, rightdir, var_c657b7b0fb4483b3, var_eea16f3afe0a8852, downdir ];
    dronespawndata = [];
    var_53d03402676acb78 = trace::sphere_trace_passed( position, position, 10.55, ignorearray, contents );
    
    if ( var_53d03402676acb78 )
    {
        spawndata = spawnstruct();
        spawndata.origin = position;
        spawndata.var_1aca040d13a96ec4 = position;
        spawndata.angles = angles;
        spawndata.velocity = velocity;
        dronespawndata[ dronespawndata.size ] = spawndata;
    }
    else
    {
        var_4508c55eab7eed9c = 15.825;
        saferadius = 5.275;
        
        foreach ( dirvec in dirvecs )
        {
            if ( dronespawndata.size == 1 )
            {
                break;
            }
            
            startpos = position;
            endpos = startpos + dirvec * var_4508c55eab7eed9c;
            trace = trace::ray_trace( startpos, endpos, ignorearray, contents );
            var_b4e8bc115cca4840 = trace[ "position" ];
            enoughspace = trace::sphere_trace_passed( var_b4e8bc115cca4840, var_b4e8bc115cca4840, saferadius, ignorearray, contents );
            
            /#
                level thread debug_utility::drawsphere( var_b4e8bc115cca4840, saferadius, 2, enoughspace ? ( 0, 1, 0 ) : ( 1, 0, 0 ) );
            #/
            
            if ( enoughspace )
            {
                spawndata = spawnstruct();
                spawndata.origin = var_b4e8bc115cca4840;
                spawndata.var_1aca040d13a96ec4 = var_b4e8bc115cca4840;
                spawndata.angles = angles;
                spawndata.velocity = velocity;
                dronespawndata[ dronespawndata.size ] = spawndata;
                break;
            }
        }
    }
    
    if ( dronespawndata.size < 1 )
    {
        vehicle_tracking::function_4f76f5b4541acef1( 1 );
        hud_message::showerrormessage( %"hash_50fa2a9308c1186f" );
        supers_mp::refundsuper();
        return;
    }
    
    sweeperdata = function_ee9f62709472bfad();
    index = 0;
    
    foreach ( spawndata in dronespawndata )
    {
        sweeperdrone_createdrone( sweeperdata, spawndata, index == 1 );
        
        if ( getdvarint( @"hash_c75b26d921a6f305", 1 ) == 1 )
        {
            break;
        }
        
        index++;
        waitframe();
    }
    
    self notify( #"hash_cedf498d5187ede5" );
    waitsec = getdvarfloat( @"hash_e23fbec45526eb06", 0.2 );
    
    if ( waitsec > 0 )
    {
        wait waitsec;
    }
    
    standstill = getdvarint( @"hash_ece714e9d092001b", 0 );
    
    if ( !standstill )
    {
        sweeperdata function_4ff3f2e2b1b65567();
    }
}

// Namespace sweeper_drones
// Params 0
// Checksum 0xd7db6d80, Offset: 0x162a
// Size: 0x146
function function_665878c8d9a98d78()
{
    drone = self.drones[ 0 ];
    owner = drone.owner;
    tracecontents = physics_createcontents( [ "physicscontents_itemclip", "physicscontents_item", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_ainosight" ] );
    ignorearray = [ drone, owner ];
    origin = self.drones[ 0 ].origin;
    offset = getdvarint( @"hash_e4016cd332bddf11", 500 );
    destination = origin + anglestoforward( self.angles ) * offset;
    trace = trace::sphere_trace( origin, destination, 0.01, ignorearray, tracecontents );
    position = trace[ "position" ];
    navpoint = getclosestpointonnavmesh( position );
    level thread utility::draw_angles( owner.angles, navpoint, ( 1, 0, 0 ), 1000, 10 );
}

// Namespace sweeper_drones
// Params 3
// Checksum 0xf037cc06, Offset: 0x1778
// Size: 0x838
function sweeperdrone_createdrone( sweeperdata, spawndata, initslow )
{
    droneconfig = level.helperdronesettings[ "sweeper_drone" ];
    
    /#
        if ( droneconfig.var_5656d6269df25e83 )
        {
            level thread debug_utility::drawsphere( spawndata.origin, 5, 30, ( 0, 1, 0 ) );
        }
    #/
    
    spawndata.owner = self;
    spawndata.team = self.team;
    streakinfo = killstreak_utility::createstreakinfo( "radar_drone_recon", self );
    streakinfo.issuper = 1;
    streakinfo.debug_state = "begin_use";
    dronespeed = getdvarfloat( @"scr_sweeper_drone_speed", droneconfig.speed );
    droneaccel = getdvarfloat( @"scr_sweeper_drone_accel", droneconfig.accel );
    height = droneconfig.heightoffset;
    speedmph = dronespeed;
    speedips = utility::mph_to_ips( speedmph );
    newvel = vectornormalize( spawndata.velocity );
    coeff = clamp( length( spawndata.velocity ), 0, speedips );
    coeff *= getdvarfloat( @"hash_c569841588b8a98d", 1 );
    newvel *= coeff;
    sweeperdrone = helper_drone::createhelperdrone( spawndata.origin, spawndata.angles, "sweeper_drone", streakinfo, 0, 0, newvel );
    sweeperdrone.streakinfo = streakinfo;
    sweeperdrone.deathcallback = &sweeperdrone_destroy;
    sweeperdrone.var_a94bc4d31cd64b2f = 1;
    sweeperdata.drones[ sweeperdata.drones.size ] = sweeperdrone;
    sweeperdrone setscriptablepartstate( "sound_startup", "play_engine_start", 0 );
    sweeperdrone sethoverparams( 1, 5, 5 );
    waitframe();
    
    /#
        if ( getdvarint( @"hash_c75b26d921a6f305" ) == 1 )
        {
            if ( getdvarint( @"hash_e48b5e4b71466223" ) == 1 )
            {
                self usevehicle( sweeperdrone, 0 );
                return;
            }
        }
    #/
    
    sweeperdrone.superref = level.sweeperdrones.supername;
    sweeperdrone addcomponent( "p2p" );
    sweeperdrone addcomponent( "path" );
    sweeperdrone setconfigvalue( "p2p", "checkStuck", 1 );
    sweeperdrone setconfigvalue( "p2p", "stuckDistanceThreshold", 10 );
    sweeperdrone setconfigvalue( "p2p", "reverseGasWhileStuck", 0.8 );
    sweeperdrone setconfigvalue( "p2p", "reverseGasNormal", 0.4 );
    sweeperdrone setconfigvalue( "p2p", "brakeAtGoal", 0 );
    sweeperdrone setconfigvalue( "p2p", "automaticNormal", 1 );
    sweeperdrone setconfigvalue( "p2p", "brakeOnGoalGasbrake", 1 );
    sweeperdrone setconfigvalue( "p2p", "goalPoint", spawndata.var_1aca040d13a96ec4 );
    sweeperdrone setconfigvalue( "p2p", "goalAngles", angleclamp180( spawndata.angles ) );
    sweeperdrone setconfigvalue( "p2p", "goalThreshold", getdvarint( @"hash_8472c2493b913ca7", 4 ) );
    sweeperdrone setconfigvalue( "p2p", "goalThresholdMin", getdvarint( @"hash_345bf812ff84dfe4", 2 ) );
    sweeperdrone setconfigvalue( "p2p", "throttleSpeedClose", 1 );
    sweeperdrone setconfigvalue( "p2p", "throttleSpeedThreshold", 1 );
    sweeperdrone setconfigvalue( "p2p", "automaticFastTopspeedFraction", 1 );
    sweeperdrone setconfigvalue( "p2p", "throttleSpeedFarBelow", 1 );
    sweeperdrone setconfigvalue( "p2p", "throttleSpeedFarAbove", 4 );
    sweeperdrone setconfigvalue( "p2p", "throttleSpeedClose", 2 );
    sweeperdrone setconfigvalue( "p2p", "gasToStopMovement", 0.9 );
    sweeperdrone setconfigvalue( "p2p", "steeringMultiplier", 2.5 );
    sweeperdrone setconfigvalue( "p2p", "stopAtGoal", 0 );
    sweeperdrone setconfigvalue( "p2p", "stopAtGoalOscillationFrequency", getdvarfloat( @"hash_b0aee8bff0ae7edf", 1.6 ) );
    sweeperdrone setconfigvalue( "p2p", "aimAtGoal", 0 );
    sweeperdrone setconfigvalue( "p2p", "aimAtGoalOscillationFrequency", getdvarfloat( @"hash_625fa92c0a733b3a", 3.2 ) );
    sweeperdrone setconfigvalue( "p2p", "lookAtEntityNum", -1 );
    sweeperdrone setconfigvalue( "p2p", "vtol3DLiftValSlowDownHeight", 30 );
    sweeperdrone setconfigvalue( "p2p", "vtol3DGoalAngleAlignmentEnable", 1 );
    sweeperdrone setconfigvalue( "p2p", "vtol3DGoalAngleAlignmentInfluenceRange", getdvarfloat( @"hash_8da21116e33d27", 40 ) );
    sweeperdrone setconfigvalue( "p2p", "vtol3DStrafeInputEnable", 1 );
    sweeperdrone setconfigvalue( "p2p", "vtol3DStrafeInputSlowDownDistance", getdvarfloat( @"hash_dd970b3117de4a25", 4 ) );
    sweeperdrone setconfigvalue( "p2p", "vtol3DReachGoalHeightEnable", 1 );
    sweeperdrone setconfigvalue( "p2p", "vtol3DReachGoalHeightThreshold", 2 );
    sweeperdrone setconfigvalue( "p2p", "vtol3DReachGoalYawEnable", 0 );
    sweeperdrone setconfigvalue( "p2p", "vtol3DReachGoalYawThreshold", 15 );
    bundle = level.sweeperdrones.superbundle;
    outlineasset = bundle.var_9d17baea56fc2d2a ?? "sweeper_drone_outline";
    sweeperdrone thread outline::outlineenableforteam( sweeperdrone, self.team, outlineasset, "perk_superior" );
    
    /#
        debugcolor = ( 0, 0, 1 );
    #/
    
    sweeperdrone.debugcolor = debugcolor;
    sweeperdrone setconfigvalue( "p2p", "manualSpeed", speedips );
    sweeperdrone setconfigvalue( "path", "navSplinePathHeightOffset", height );
    sweeperdrone setconfigvalue( "path", "navSplineUseDroneStepMethod", 1 );
    sweeperdrone setconfigvalue( "path", "advanceOnStart", 1 );
    sweeperdrone setconfigvalue( "path", "radiusToStep", 120 );
    sweeperdrone setconfigvalue( "path", "stepSpeedFactor", 0 );
    sweeperdrone setconfigvalue( "path", "stepProximityFactor", 0 );
    sweeperdrone setconfigvalue( "path", "softConstrained", getdvarint( @"hash_5d7f3b4aeff18c02", 1 ) );
    sweeperdrone vehicle_setvelocity( spawndata.velocity );
    sweeperdrone vehicle_setspeed( dronespeed, droneaccel, droneaccel );
    sweeperdrone.pathspeed = dronespeed;
    vehicle_tracking::function_4f76f5b4541acef1();
    namespace_9d8e359c3b1041e5::emp_debuff_register_sharedfunc( sweeperdrone, &sweeperdrone_empapplied );
    sweeperdrone chaff_debuff::function_3860212a5ec36b56( &function_b863a0c67f53f2f1 );
    sweeperdrone chaff_debuff::function_324dd42a2703bc25( &function_99e7395ce3b30c58 );
    
    if ( utility::issharedfuncdefined( #"chaff", #"add_ent_to_overlapping_chaff_triggers" ) )
    {
        sweeperdrone [[ utility::getsharedfunc( #"chaff", #"add_ent_to_overlapping_chaff_triggers" ) ]]( sweeperdrone );
    }
    
    sweeperdrone setscriptablepartstate( "lights", "on", 1 );
    sweeperdrone setscriptablepartstate( "glint", "on", 1 );
    sweeperdrone thread function_495c37e426767119();
    sweeperdrone thread function_d5ab6af2ee9b230f();
    sweeperdrone disableaimassist();
    
    if ( getdvarint( @"hash_fc9fbb762364e601", 0 ) )
    {
        sweeperdrone thread function_9fdb11750185d83d( droneconfig );
    }
    
    if ( getdvarint( @"hash_32fe4d3ff56c3830", 1 ) == 1 )
    {
        sweeperdrone thread function_9793a6f9c6826b85();
    }
    
    sweeperdrone.owner = sweeperdata.owner;
    challenges::function_4fd386d590e901d8( sweeperdrone, #"hash_c50cf868c6994df3", #"use" );
    challengeparams = { #fieldupgraderef:"super_sweeper_drones", #fieldupgradeent:sweeperdrone, #fieldupgradeowner:sweeperdrone.owner };
    callback::callback( #"hash_2af4adf11224c49a", challengeparams );
}

// Namespace sweeper_drones
// Params 1
// Checksum 0x2f353488, Offset: 0x1fb8
// Size: 0x16c
function function_9fdb11750185d83d( droneconfig )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    defaultaccel = droneconfig.accel;
    
    while ( isdefined( self.owner ) )
    {
        minspeed = getdvarint( @"scr_sweeper_drone_min_speed", 5 );
        maxspeed = droneconfig.speed;
        var_dcea9e7ca9583ed7 = getdvarint( @"hash_f8caeda5ea0dabae", 1250 );
        var_f62f21678ce291fd = getdvarint( @"hash_3a2ed57e036a3691", 750 );
        ownerpos = self.owner.origin;
        dronepos = self.origin;
        dist = distance( ownerpos, dronepos );
        t = clamp( ( dist - var_f62f21678ce291fd ) / ( var_dcea9e7ca9583ed7 - var_f62f21678ce291fd ), 0, 1 );
        
        if ( t > 0 )
        {
            speed_t = 1 - t;
            newspeed = math::lerp( minspeed, maxspeed, speed_t );
            self vehicle_setspeed( newspeed, defaultaccel );
            speedips = utility::mph_to_ips( newspeed );
            self setconfigvalue( "p2p", "manualSpeed", speedips );
        }
        
        wait 0.25;
    }
}

// Namespace sweeper_drones
// Params 0
// Checksum 0xba2347fe, Offset: 0x212c
// Size: 0x185
function function_9793a6f9c6826b85()
{
    self endon( #"death" );
    self.doorsopened = [];
    
    while ( true )
    {
        var_38738ca0abd6cf9d = getdvarint( @"hash_c3df3a878353df9e", 75 );
        scriptablesinrange = getentitylessscriptablearray( undefined, undefined, self.origin, var_38738ca0abd6cf9d );
        doors = [];
        
        foreach ( foundentity in scriptablesinrange )
        {
            if ( foundentity scriptableisdoor() || foundentity scriptabledoorisdouble() )
            {
                doors[ doors.size ] = foundentity;
            }
        }
        
        foreach ( door in doors )
        {
            if ( arraycontains( self.doorsopened, door ) )
            {
                continue;
            }
            
            door childthread function_79db620335cd8e09( self );
            self.doorsopened[ self.doorsopened.size ] = door;
        }
        
        wait 0.25;
    }
}

// Namespace sweeper_drones
// Params 1
// Checksum 0x6e78decb, Offset: 0x22b9
// Size: 0x1c6
function function_79db620335cd8e09( drone )
{
    var_9f1f9965afa63fb9 = undefined;
    doorstate = self getscriptablepartstate( "door", 1 );
    
    if ( !isdefined( doorstate ) || issubstr( doorstate, "_90" ) || issubstr( doorstate, "ajar" ) )
    {
        return;
    }
    
    while ( true )
    {
        doorstate = self getscriptablepartstate( "door", 1 );
        
        if ( !isdefined( doorstate ) )
        {
            return;
        }
        else if ( issubstr( doorstate, "closed" ) || issubstr( doorstate, "closing" ) || issubstr( doorstate, "opening" ) || issubstr( doorstate, "0" ) && !issubstr( doorstate, "90" ) )
        {
            var_9f1f9965afa63fb9 = self.angles;
            
            if ( doorstate != "frozen" && doorstate != "locked" )
            {
                self scriptabledoorbashopen( "away", drone.origin );
            }
            else
            {
                return;
            }
        }
        else if ( issubstr( doorstate, "_90" ) || issubstr( doorstate, "ajar" ) )
        {
            var_2611f56edca50857 = getdvarint( @"hash_885e89e0d3af21bd", 15 );
            fwdoffset = getdvarint( @"hash_8758f6d76c33cd3c", 50 );
            origin = self.origin + anglestoforward( var_9f1f9965afa63fb9 ) * var_2611f56edca50857 + anglestoforward( self.angles ) * fwdoffset;
            drone.var_676faec94ee7fa19 = origin;
            drone.forcerepath = 1;
            drone notify( #"sweeperDrone_repath" );
            return;
        }
        
        waittime = getdvarfloat( @"scr_sweeper_drone_door_wait", 1 );
        wait waittime;
    }
}

// Namespace sweeper_drones
// Params 1
// Checksum 0xdbccc221, Offset: 0x2487
// Size: 0x64
function function_2712a8790498d268( ondestroy )
{
    bundle = level.sweeperdrones.superbundle;
    
    if ( !ondestroy )
    {
        self.headiconfaction = entityheadicons::setheadicon_fieldupgrade( self );
        return;
    }
    
    entityheadicons::setheadicon_deleteicon( self.headiconowner );
    entityheadicons::setheadicon_deleteicon( self.headiconfaction );
}

// Namespace sweeper_drones
// Params 2
// Checksum 0x7cf23b7c, Offset: 0x24f3
// Size: 0xcb
function function_251737479a111adc( owner, bundle )
{
    icondata = spawnstruct();
    icondata.enable = 1;
    icondata.onlyowner = 1;
    icondata.showto = owner;
    icondata.image = bundle.var_1844767cefccd0b5;
    icondata.offset = 12;
    icondata.drawthroughgeo = 1;
    icondata.maxdrawdist = 2000;
    icondata.naturaldist = getdvarint( @"hash_529e7cd5149994a9", 400 );
    icondata.var_c6bd58f878e4420a = 1;
    icondata.var_6275850de36415ea = 1;
    return icondata;
}

// Namespace sweeper_drones
// Params 0
// Checksum 0x3454f0cf, Offset: 0x25c7
// Size: 0x83
function function_aef528c48d53a50a()
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            return;
        }
        
        function_ebb9372e4646a0bd( player );
    }
}

// Namespace sweeper_drones
// Params 1
// Checksum 0xe96b41c5, Offset: 0x2652
// Size: 0xe9
function function_ebb9372e4646a0bd( player )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    idowner = self.headiconowner;
    
    if ( !isdefined( idowner ) )
    {
        return;
    }
    
    idfaction = self.headiconfaction;
    
    if ( !isdefined( idfaction ) )
    {
        return;
    }
    
    isfriendly = player_utility::isfriendly( self.owner.team, player );
    isowner = player == self.owner;
    
    if ( isowner )
    {
        entityheadicons::setheadicon_removeclientfrommask( idfaction, player );
        entityheadicons::setheadicon_addclienttomask( idowner, player );
        return;
    }
    
    if ( isfriendly )
    {
        entityheadicons::setheadicon_removeclientfrommask( idowner, player );
        entityheadicons::setheadicon_addclienttomask( idfaction, player );
        return;
    }
    
    entityheadicons::setheadicon_removeclientfrommask( idowner, player );
    entityheadicons::setheadicon_removeclientfrommask( idfaction, player );
}

// Namespace sweeper_drones
// Params 1
// Checksum 0x58188a14, Offset: 0x2743
// Size: 0x6a
function sweeperdrone_empapplied( data )
{
    attacker = data.attacker;
    
    if ( player_utility::playersareenemies( self.owner, attacker ) )
    {
        attacker thread points::doscoreevent( #"hash_5c7aad185db39626" );
    }
    
    if ( isplayer( attacker ) )
    {
        attacker damagefeedback::updatedamagefeedback( "" );
    }
    
    thread sweeperdrone_destroy( undefined, attacker );
}

// Namespace sweeper_drones
// Params 1
// Checksum 0x6fc84c6f, Offset: 0x27b5
// Size: 0x45
function function_b863a0c67f53f2f1( data )
{
    attacker = data.attacker;
    
    if ( isplayer( attacker ) )
    {
        attacker damagefeedback::updatedamagefeedback( "" );
    }
    
    self.chaffstunned = 1;
}

// Namespace sweeper_drones
// Params 1
// Checksum 0x3fba6085, Offset: 0x2802
// Size: 0x16
function function_99e7395ce3b30c58( data )
{
    self.chaffstunned = 0;
}

// Namespace sweeper_drones
// Params 0
// Checksum 0xc54fb256, Offset: 0x2820
// Size: 0x2c
function function_495c37e426767119()
{
    self endon( #"death" );
    function_af036a45e340764c( 20 );
    thread sweeperdrone_destroy( undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1 );
}

// Namespace sweeper_drones
// Params 1
// Checksum 0x78425858, Offset: 0x2854
// Size: 0x35
function function_af036a45e340764c( lifetime )
{
    self.owner endon( #"disconnect" );
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithhostmigrationpause( lifetime );
}

// Namespace sweeper_drones
// Params 0, eflags: 0x4
// Checksum 0xf14d0f9a, Offset: 0x2891
// Size: 0x8f
function private function_d5ab6af2ee9b230f()
{
    self endon( #"death" );
    var_4a0acaf5f5403144 = getdvarfloat( @"hash_4b1db0076ea90d53", 3 );
    intervalsec = 0.5;
    self.var_cf0033a5b7da734c = 0;
    
    while ( true )
    {
        wait intervalsec;
        
        if ( outofbounds::istouchingoobtrigger() )
        {
            self.var_cf0033a5b7da734c += intervalsec;
            
            if ( self.var_cf0033a5b7da734c >= var_4a0acaf5f5403144 )
            {
                thread sweeperdrone_destroy();
                return;
            }
            
            continue;
        }
        
        self.var_cf0033a5b7da734c = 0;
    }
}

// Namespace sweeper_drones
// Params 1
// Checksum 0x8d9a219, Offset: 0x2928
// Size: 0x11f
function function_3aa65a6e4a0a4789( droneconfig )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    time = getdvarfloat( @"hash_16cab926a1f9eead", 1 );
    t = 0;
    maxheight = droneconfig.heightoffset;
    minheight = maxheight / 2;
    maxspeed = getdvarfloat( @"scr_sweeper_drone_speed", droneconfig.speed );
    minspeed = maxspeed / 2;
    
    while ( t <= time )
    {
        curspeed = math::factor_value( minspeed, maxspeed, t / time );
        curheight = math::factor_value( minheight, maxheight, t / time );
        speedips = utility::mph_to_ips( curspeed );
        self setconfigvalue( "p2p", "manualSpeed", speedips );
        self setconfigvalue( "path", "navSplinePathHeightOffset", curheight );
        t += level.framedurationseconds;
        waitframe();
    }
}

// Namespace sweeper_drones
// Params 2
// Checksum 0x763df8a, Offset: 0x2a4f
// Size: 0x38
function function_b0b21aab4fe000a2( position1, position2 )
{
    return ( ( position1[ 0 ] + position2[ 0 ] ) / 2, ( position1[ 1 ] + position2[ 1 ] ) / 2, ( position1[ 2 ] + position2[ 2 ] ) / 2 );
}

// Namespace sweeper_drones
// Params 0
// Checksum 0x969d6a2f, Offset: 0x2a90
// Size: 0xae
function function_ee9f62709472bfad()
{
    if ( !isdefined( level.sweeperdronedata ) )
    {
        level.sweeperdronedata = [];
    }
    
    if ( !isdefined( level.sweeperdronedata[ self getentitynumber() ] ) )
    {
        sweeperdronedata = spawnstruct();
        sweeperdronedata.owner = self;
        sweeperdronedata.drones = [];
        sweeperdronedata.startingorientation = self.angles;
        sweeperdronedata.startingposition = self.origin;
        sweeperdronedata.markedtargets = [];
        level.sweeperdronedata[ self getentitynumber() ] = sweeperdronedata;
    }
    
    return level.sweeperdronedata[ self getentitynumber() ];
}

// Namespace sweeper_drones
// Params 0
// Checksum 0x3407b486, Offset: 0x2b47
// Size: 0x2b
function function_ec20122f62304b96()
{
    level.sweeperdronedata[ self getentitynumber() ] notify( #"death" );
    level.sweeperdronedata[ self getentitynumber() ] = undefined;
}

// Namespace sweeper_drones
// Params 1
// Checksum 0x9ee29f16, Offset: 0x2b7a
// Size: 0xc
function function_f5f3ed1b67d22e4f( sweeperdata )
{
    
}

// Namespace sweeper_drones
// Params 1
// Checksum 0x4cf39df8, Offset: 0x2b8e
// Size: 0xe3
function function_11170b93b707738d( sweeperdata )
{
    assert( sweeperdata.drones.size > 0, "<dev string:x3b>" );
    vec = ( 0, 0, 0 );
    counter = 0;
    
    foreach ( drone in sweeperdata.drones )
    {
        vec += drone.origin;
        counter++;
    }
    
    return ( vec[ 0 ] / counter, vec[ 1 ] / counter, vec[ 2 ] / counter );
}

// Namespace sweeper_drones
// Params 3
// Checksum 0x114fb72d, Offset: 0x2c7a
// Size: 0x8d
function function_e1a3620490493db2( enemy, direction, refposition )
{
    var_a497134a5f3aacae = vectornormalize( enemy.origin - refposition );
    
    if ( !isdefined( self.angledeg ) )
    {
        self.angledeg = getdvarint( @"hash_210d7399d7527fa0", 0 );
    }
    
    rads = math::degrees_to_radians( self.angledeg );
    
    if ( vectordot( direction, var_a497134a5f3aacae ) < rads )
    {
        return 0;
    }
    
    return 1;
}

// Namespace sweeper_drones
// Params 3
// Checksum 0xa95d8995, Offset: 0x2d0f
// Size: 0x3b
function function_f350c33a57a4da3( avgpos, dims, ang )
{
    /#
        orientedbox( avgpos, dims, ang, ( 1, 0, 0 ), 0, 1000 );
    #/
}

// Namespace sweeper_drones
// Params 0
// Checksum 0x962492b2, Offset: 0x2d52
// Size: 0x77
function function_241d8e596a7e703f()
{
    avgpos = function_11170b93b707738d( self );
    avgpos += self.currentdirection * 21.1 * -1;
    dims = ( 40, 250, 100 );
    ang = vectortoangles( self.currentdirection );
    self.var_bd806bf6f46d689e = createnavbadplacebybounds( avgpos, dims, ang );
    level thread function_f350c33a57a4da3( avgpos, dims, ang );
}

// Namespace sweeper_drones
// Params 2
// Checksum 0x59ee7654, Offset: 0x2dd1
// Size: 0x37
function function_1f3faf5a6f219067( a, b )
{
    if ( a.pathdistance < b.pathdistance )
    {
        return 1;
    }
    
    return 0;
}

// Namespace sweeper_drones
// Params 2
// Checksum 0xd1f95eae, Offset: 0x2e10
// Size: 0x37
function function_3e8e33be89371467( a, b )
{
    if ( a.score > b.score )
    {
        return 1;
    }
    
    return 0;
}

// Namespace sweeper_drones
// Params 3
// Checksum 0x987ab953, Offset: 0x2e4f
// Size: 0x2bd
function sweeperdrone_createpath( enemylist, var_71b88326aebc2113, startingdirection )
{
    if ( !isdefined( self.owner ) )
    {
        utility::error( "Seeker Drone doesn't have an owner for some reason. But that doesnt make any sense." );
        return;
    }
    
    if ( !isdefined( self.startingposition ) )
    {
        utility::error( "Seeker Drone doesn't have its owner's starting position. But that also doesnt make any sense" );
        return;
    }
    
    patharr = [];
    
    for ( i = 0; i < enemylist.size ; i++ )
    {
        enemy = enemylist[ i ];
        pathdata = spawnstruct();
        pathdata.pathdistance = self.var_140568b1b133d3f3[ enemy getentitynumber() ];
        assert( isdefined( pathdata.pathdistance ), "<dev string:x6e>" );
        pathdata.enemy = enemy;
        patharr[ patharr.size ] = pathdata;
    }
    
    var_8619a7e959a96f5b = arraysort( patharr, undefined, &function_1f3faf5a6f219067 );
    lastenemypathdata = var_8619a7e959a96f5b[ var_8619a7e959a96f5b.size - 1 ];
    farthestdistance = lastenemypathdata.pathdistance;
    startpos = self.startingposition;
    currentdir = self.currentdirection;
    
    foreach ( pathdata in var_8619a7e959a96f5b )
    {
        enemyposition = pathdata.enemy.origin;
        
        if ( !isdefined( enemyposition ) )
        {
            continue;
        }
        
        toenemydir = vectornormalize( utility::flatten_vector( enemyposition - startpos ) );
        dp = vectordot( self.currentdirection, toenemydir );
        t = ( dp + 1 ) / 2;
        var_854de6a75944b964 = t;
        pathdata.dirscore = t;
        pathdata.dotproduct = dp;
        var_29c31f4f68407abd = var_854de6a75944b964 * getdvarfloat( @"hash_cf04a5504d381380", 0.55 );
        var_88f166f3642e79db = 1 - pathdata.pathdistance / farthestdistance;
        var_859a143dff0d57b0 = var_88f166f3642e79db * getdvarfloat( @"hash_1643a17f06e86ff", 0.45 );
        pathdata.score = var_859a143dff0d57b0 + var_29c31f4f68407abd;
    }
    
    var_8619a7e959a96f5b = arraysort( patharr, undefined, &function_3e8e33be89371467 );
    self.pathdata = var_8619a7e959a96f5b;
    return var_8619a7e959a96f5b;
}

// Namespace sweeper_drones
// Params 2
// Checksum 0xa3561f23, Offset: 0x3115
// Size: 0x92, Type: bool
function function_564d3866025b7bfb( enemy, averagepos )
{
    droneconfig = level.helperdronesettings[ "sweeper_drone" ];
    
    if ( isdefined( self.markedtargets[ enemy getentitynumber() ] ) )
    {
        return false;
    }
    
    pathdistance = findclosestpointbyapproxpathdist( [ averagepos ], enemy.origin, 1 );
    
    if ( !isdefined( pathdistance ) || pathdistance == 0 )
    {
        return false;
    }
    
    self.var_140568b1b133d3f3[ enemy getentitynumber() ] = pathdistance;
    return true;
}

// Namespace sweeper_drones
// Params 0
// Checksum 0x5a6d21a0, Offset: 0x31b0
// Size: 0x5c6
function function_4ff3f2e2b1b65567()
{
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    level endon( #"game_ended" );
    self.currentdirection = anglestoforward( self.startingorientation );
    self.startingposition = self.owner.origin;
    
    /#
        setdevdvarifuninitialized( @"hash_4c803ba16ed42bb1", 0 );
    #/
    
    self.onpath = 0;
    enemyteams = team_utility::getenemyteams( self.owner.team, 1 );
    
    if ( isdefined( self.owner.team ) && self.owner.team != "team_hundred_ninety_four" )
    {
        enemyteams[ enemyteams.size ] = "team_hundred_ninety_four";
    }
    
    while ( true )
    {
        /#
            if ( getdvarint( @"hash_4c803ba16ed42bb1", 0 ) == 1 )
            {
                wait 1;
                continue;
            }
        #/
        
        if ( self.chaffstunned )
        {
            waitframe();
            continue;
        }
        
        while ( !self.onpath )
        {
            if ( !isdefined( self.drones ) || self.drones.size == 0 )
            {
                return;
            }
            
            avgpos = function_11170b93b707738d( self );
            enemies = getplayersandaiarrayinradius( avgpos, 2000, enemyteams );
            temparr = [];
            self.var_140568b1b133d3f3 = [];
            
            foreach ( enemy in enemies )
            {
                if ( ( self.owner.team ?? self.owner.agentteam ) != enemy.team && function_564d3866025b7bfb( enemy, avgpos ) )
                {
                    temparr[ temparr.size ] = enemy;
                }
            }
            
            foreach ( dummy in level.deployeddecoys )
            {
                if ( dummy.team != self.owner.team && function_564d3866025b7bfb( dummy, avgpos ) )
                {
                    temparr[ temparr.size ] = dummy;
                }
            }
            
            enemies = temparr;
            
            if ( enemies.size == 0 )
            {
                if ( !isdefined( self.markedtargets ) || self.markedtargets.size == 0 )
                {
                    if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
                    {
                        self.owner [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"hash_1c297c58a2827117" );
                    }
                }
                
                foreach ( drone in self.drones )
                {
                    /#
                        if ( getdvarint( @"hash_e48b5e4b71466223" ) == 1 )
                        {
                            break;
                        }
                    #/
                    
                    drone thread sweeperdrone_destroy( self );
                }
                
                return;
            }
            
            path = sweeperdrone_createpath( enemies, avgpos, self.currentdirection );
            enemies = [];
            
            for ( k = 0; k < path.size ; k++ )
            {
                enemies[ k ] = path[ k ].enemy;
            }
            
            self.onpath = 1;
        }
        
        currenttargets = [];
        enemies = arrayremove( enemies, self.markedtargets );
        avgpos = function_11170b93b707738d( self );
        
        for ( i = 0; i < enemies.size ; i++ )
        {
            player = enemies[ i ];
            
            if ( !isalive( player ) )
            {
                continue;
            }
            
            if ( isdefined( self.markedtargets[ player getentitynumber() ] ) )
            {
                /#
                    level thread debug_utility::drawsphere( player.origin, 10, 1, ( 0, 0, 0 ) );
                #/
                
                continue;
            }
            
            /#
                level thread debug_utility::drawsphere( player.origin, 10, 1, ( 0, 0, 1 ) );
            #/
            
            currenttargets[ currenttargets.size ] = player;
            break;
        }
        
        foreach ( enemy in enemies )
        {
            if ( !arraycontains( currenttargets, enemy ) )
            {
                /#
                    level thread debug_utility::drawsphere( enemy.origin, 10, 1, ( 1, 0, 0 ) );
                #/
            }
        }
        
        if ( self.onpath )
        {
            function_376a799ba246767a( currenttargets );
            self.onpath = 0;
        }
        
        waitframe();
    }
}

// Namespace sweeper_drones
// Params 1
// Checksum 0x7b6e39e, Offset: 0x377e
// Size: 0x127
function function_26a48d2895d0510d( enemy )
{
    returnplayers = [];
    avgposition = function_11170b93b707738d( self );
    
    foreach ( drone in self.drones )
    {
        midpoint = function_b0b21aab4fe000a2( drone.origin, enemy.origin );
        radius = getdvarint( @"hash_b389a1f5bc0a7824", 500 );
        players = utility::function_f754506ecfae9afb( midpoint, radius, [ self.owner, enemy ], 500 );
        returnplayers = arraycombineunique( returnplayers, players );
    }
    
    returnplayers = arrayremove( returnplayers, self.markedtargets );
    returnplayers = sortbydistance( returnplayers, avgposition );
    return returnplayers;
}

// Namespace sweeper_drones
// Params 1
// Checksum 0xc8972a8, Offset: 0x38ae
// Size: 0x1ba
function function_376a799ba246767a( enemies )
{
    counter = 0;
    directiondata = undefined;
    
    if ( enemies.size == 1 )
    {
        foreach ( enemy in enemies )
        {
            directiondata = function_3bd0b15e7b8e35d3( enemy );
        }
        
        self.var_a010c110f932c758 = 1;
    }
    else
    {
        self.var_a010c110f932c758 = 0;
        
        if ( self.drones.size > 0 )
        {
            self.drones = sortbydistance( self.drones, enemies[ 0 ].origin );
        }
    }
    
    foreach ( drone in self.drones )
    {
        if ( self.var_a010c110f932c758 )
        {
            drone thread function_c8ae2365a062880b( enemies[ 0 ], self, directiondata.destinations[ counter ] );
        }
        else
        {
            drone thread function_c8ae2365a062880b( enemies[ counter ], self );
        }
        
        counter++;
    }
    
    self waittill( #"hash_8112470b3a49b8b8", msg );
    print( "<dev string:xbb>" + gettime() );
}

// Namespace sweeper_drones
// Params 1
// Checksum 0xdebb8a7f, Offset: 0x3a70
// Size: 0x37c
function function_3bd0b15e7b8e35d3( enemy )
{
    directions = [];
    directiondata = spawnstruct();
    drone = utility::array_get_first_item( self.drones );
    horizoffset = getdvarint( @"hash_510b3100ee3125a8", 100 );
    angstep = getdvarint( @"hash_7b73a36f9bde9c4b", 30 );
    maxsteps = 360 / angstep;
    droneconfig = level.helperdronesettings[ "sweeper_drone" ];
    heightoffset = droneconfig.heightoffset;
    stepcount = 0;
    startpos = enemy.origin + ( 0, 0, heightoffset );
    refvec = undefined;
    
    if ( isplayer( enemy ) || isagent( enemy ) )
    {
        refvec = vectornormalize( enemy getvelocity() );
    }
    else
    {
        refvec = anglestoforward( enemy.angles );
    }
    
    if ( length( refvec ) == 0 )
    {
        refvec = anglestoforward( enemy.angles );
    }
    
    startorientation = vectortoangles( refvec );
    radius = 2;
    ignorearray = [ drone, enemy ];
    destinations = [];
    
    /#
        debugmode = getdvarint( @"scr_sweeper_drone_debug", 0 );
    #/
    
    while ( stepcount < maxsteps )
    {
        polarity = 1;
        
        if ( stepcount % 2 == 1 )
        {
            polarity = -1;
        }
        
        currentorientation = startorientation + ( 0, angstep * stepcount * polarity, 0 );
        testvec = anglestoforward( currentorientation );
        dest = startpos + testvec * horizoffset;
        tracepassed = trace::sphere_trace_passed( startpos, dest, radius, ignorearray, droneconfig.var_47cefc5b1c8b888f );
        success = 1;
        
        if ( !tracepassed )
        {
            success = 0;
            
            /#
                level thread utility::draw_line_for_time( startpos, dest, 1, 0, 0, 10 );
            #/
        }
        else if ( outofbounds::ispointinoutofbounds( dest ) )
        {
            success = 0;
            
            /#
                if ( debugmode )
                {
                    level thread utility::draw_line_for_time( startpos, dest, 1, 0, 1, 10 );
                }
            #/
        }
        else
        {
            /#
                if ( debugmode )
                {
                    level thread debug_utility::drawsphere( dest, 2, 10, ( 0, 0, 1 ) );
                }
            #/
            
            downoffset = ( 0, 0, -200 );
            tracedown = trace::ray_trace( dest, dest + downoffset, ignorearray, droneconfig.var_47cefc5b1c8b888f );
            var_b1fb3b2aba1dcbcf = tracedown[ "position" ];
            
            if ( !ispointonnavmesh( var_b1fb3b2aba1dcbcf ) )
            {
                /#
                    if ( debugmode )
                    {
                        level thread utility::draw_line_for_time( dest, var_b1fb3b2aba1dcbcf, 1, 0, 0, 10 );
                    }
                #/
                
                success = 0;
            }
            else
            {
                destinations = [ var_b1fb3b2aba1dcbcf ];
                
                /#
                    if ( debugmode )
                    {
                        level thread utility::draw_line_for_time( startpos, dest, 0, 1, 0, 10 );
                    }
                #/
            }
        }
        
        if ( !success )
        {
            stepcount++;
            continue;
        }
        
        break;
    }
    
    if ( destinations.size == 0 )
    {
        destinations = [ enemy.origin, enemy.origin ];
    }
    
    directiondata.directions = directions;
    directiondata.destinations = destinations;
    return directiondata;
}

// Namespace sweeper_drones
// Params 0
// Checksum 0x9da33a4f, Offset: 0x3df5
// Size: 0x216
function function_c2efa8323255068e()
{
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    droneconfig = level.helperdronesettings[ "sweeper_drone" ];
    defaultspeed = getdvarfloat( @"scr_sweeper_drone_speed", droneconfig.speed );
    defaultaccel = getdvarfloat( @"scr_sweeper_drone_accel", droneconfig.accel );
    
    while ( true )
    {
        if ( !self.var_a010c110f932c758 )
        {
            waitframe();
            continue;
        }
        
        var_3abf613543d01ab8 = 0;
        
        if ( self.drones.size != 2 )
        {
            var_3abf613543d01ab8 = 1;
        }
        
        if ( var_3abf613543d01ab8 )
        {
            foreach ( drone in self.drones )
            {
                drone vehicle_setspeed( defaultspeed, defaultaccel );
                drone.pathspeed = defaultspeed;
                return;
            }
        }
        
        sorteddrones = arraysort( self.drones, undefined, &function_dce6f39a76ab7ee0 );
        aheaddrone = sorteddrones[ 0 ];
        behinddrone = sorteddrones[ 1 ];
        
        if ( !aheaddrone.isleading )
        {
            aheaddrone.pathspeed = defaultspeed;
            aheaddrone vehicle_setspeed( defaultspeed, defaultaccel );
            aheaddrone.isleading = 1;
            behinddrone.isleading = 0;
        }
        
        time = aheaddrone.splinedistance / defaultspeed;
        
        if ( time == 0 )
        {
            behindvelocity = defaultspeed;
        }
        else
        {
            behindvelocity = behinddrone.splinedistance / time;
        }
        
        behinddrone.pathspeed = behindvelocity;
        behinddrone vehicle_setspeed( behindvelocity, defaultaccel );
        waitframe();
    }
}

// Namespace sweeper_drones
// Params 2, eflags: 0x4
// Checksum 0xa16c1390, Offset: 0x4013
// Size: 0x37
function private function_dce6f39a76ab7ee0( a, b )
{
    if ( a.splinedistance < b.splinedistance )
    {
        return 1;
    }
    
    return 0;
}

// Namespace sweeper_drones
// Params 0
// Checksum 0x693c67b9, Offset: 0x4052
// Size: 0xb
function function_4bc7921baeb85ab5()
{
    return self.var_84c118df363d5d65;
}

// Namespace sweeper_drones
// Params 2
// Checksum 0x62ad4c79, Offset: 0x4066
// Size: 0x4c
function function_d3291114af08350b( enemyplayer, destination )
{
    enemydata = spawnstruct();
    enemydata.target = enemyplayer;
    enemydata.destination = destination;
    self.var_84c118df363d5d65 = enemydata;
}

// Namespace sweeper_drones
// Params 2
// Checksum 0xebbf4007, Offset: 0x40ba
// Size: 0x4a
function function_4132c36bd5c65119( enemyplayer, destination )
{
    self.var_84c118df363d5d65.target = enemyplayer;
    self.var_84c118df363d5d65.destination = destination;
    return self.var_84c118df363d5d65;
}

// Namespace sweeper_drones
// Params 2
// Checksum 0xb7f96ceb, Offset: 0x410d
// Size: 0x216
function function_8a078e7d2f8bf61e( target, destination )
{
    if ( !isdefined( target ) )
    {
        return 0;
    }
    
    if ( !isdefined( destination ) )
    {
        destination = self.origin;
    }
    
    icansee = 0;
    tracecontents = physics_createcontents( [ "physicscontents_itemclip", "physicscontents_item", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_ainosight" ] );
    defaultorigin = target.origin;
    tracepoints = [ defaultorigin ];
    
    if ( isplayer( target ) )
    {
        headpos = target utility::function_f02ebab438642e16();
        centerpos = target utility::function_68061c3d21a6d57a();
        tracepoints = [ headpos, centerpos, defaultorigin ];
    }
    else if ( isagent( target ) )
    {
        tracepoints = [ defaultorigin + ( 0, 0, 1 ) ];
    }
    
    ignorelist = [ self, target ];
    vehicle = target vehicle::get_vehicle();
    
    if ( isdefined( vehicle ) )
    {
        ignorelist[ ignorelist.size ] = vehicle;
        vehiclechildren = vehicle getlinkedchildren( 1 );
        
        foreach ( child in vehiclechildren )
        {
            ignorelist[ ignorelist.size ] = child;
        }
    }
    
    icansee = 0;
    
    for ( i = 0; i < tracepoints.size ; i++ )
    {
        trace = trace::sphere_trace( destination, tracepoints[ i ], 0.01, ignorelist, tracecontents, undefined, 1 );
        
        if ( trace[ "hittype" ] == "hittype_none" )
        {
            icansee = 1;
            break;
        }
    }
    
    return icansee;
}

// Namespace sweeper_drones
// Params 3
// Checksum 0xdb941cf2, Offset: 0x432c
// Size: 0x116
function function_f5a24dcf17a45e67( enemydata, newenemy, newdestination )
{
    currentdestination = enemydata.destination;
    currentenemy = enemydata.target;
    
    if ( self.forcerepath )
    {
        self.forcerepath = undefined;
        return 1;
    }
    
    if ( newenemy != currentenemy )
    {
        return 1;
    }
    
    isvisible = 1;
    
    if ( isdefined( self.splinepoints ) )
    {
        isvisible = function_8a078e7d2f8bf61e( currentenemy, self.splinepoints[ self.splinepoints.size - 1 ] );
    }
    
    var_8ee6ea4a2ddd5a54 = distancesquared( self.origin, currentdestination );
    
    if ( !isvisible )
    {
        if ( var_8ee6ea4a2ddd5a54 <= 65536 )
        {
            return 1;
        }
    }
    
    repaththreshold = getdvarint( @"hash_3fe0c3025b4b9b60", 100 );
    repaththresholdsq = repaththreshold * repaththreshold;
    
    if ( distancesquared( currentdestination, newdestination ) >= repaththresholdsq )
    {
        return 1;
    }
    
    return 0;
}

// Namespace sweeper_drones
// Params 3
// Checksum 0x8715f4c0, Offset: 0x444a
// Size: 0x3ef
function function_c8ae2365a062880b( enemyplayer, sweeperdata, destination )
{
    self notify( #"hash_ea1c17fe8625ab4f" );
    self endon( #"hash_ea1c17fe8625ab4f" );
    self endon( #"hash_8112470b3a49b8b8" );
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    
    if ( !isdefined( destination ) )
    {
        destination = enemyplayer.origin;
    }
    
    shouldpath = 0;
    
    if ( !isdefined( self.var_84c118df363d5d65 ) )
    {
        enemydata = function_d3291114af08350b( enemyplayer, destination );
        shouldpath = 1;
    }
    else
    {
        enemydata = function_4bc7921baeb85ab5();
        shouldpath = function_f5a24dcf17a45e67( enemydata, enemyplayer, destination );
    }
    
    if ( shouldpath )
    {
        enemydata = function_4132c36bd5c65119( enemyplayer, destination );
    }
    
    thread function_3c77ec903982db91( enemyplayer, sweeperdata );
    thread function_66647e9cbb5bba3e( enemyplayer, sweeperdata );
    thread function_a75800bed32e4417( sweeperdata );
    thread function_a42d035da18cd23b( sweeperdata );
    
    if ( self.var_d12cbdf6a38a8be1 )
    {
        self setscriptablepartstate( "target_glint", "on", 0 );
        self setscriptablepartstate( "lasers", "marking", 0 );
    }
    else
    {
        self setscriptablepartstate( "target_glint", "off", 0 );
        self setscriptablepartstate( "lasers", "searching", 0 );
    }
    
    droneconfig = level.helperdronesettings[ "sweeper_drone" ];
    debugdraw = 0;
    
    /#
        debugdraw = getdvarint( @"hash_78c658615886f5e7", 0 );
        
        if ( droneconfig.var_c02363ae8581320a )
        {
            level thread debug_utility::drawsphere( destination, 5, 1, self.debugcolor );
        }
    #/
    
    self.splinedistance = 0;
    
    if ( shouldpath )
    {
        self setconfigvalue( "p2p", "stopAtGoal", 0 );
        self setconfigvalue( "p2p", "aimAtGoal", 0 );
        self setconfigvalue( "p2p", "lookAtEntityNum", -1 );
        splinepoints = function_fd8984a4eacb79ed( destination, enemyplayer, self.pathspeed, "soldier", debugdraw );
        self.splinepoints = splinepoints;
        
        if ( !isdefined( splinepoints ) )
        {
            sweeperdata notify( #"hash_8112470b3a49b8b8", "repath" );
            return;
        }
        
        splinedistance = 0;
        currentpoint = self.origin;
        
        foreach ( point in splinepoints )
        {
            splinedistance += distance( currentpoint, point );
            currentpoint = point;
        }
        
        self.splinedistance = splinedistance;
    }
    
    waittime = getdvarfloat( @"hash_568da1dadf8a1ff6", 0.25 );
    msg = utility::waittill_any_timeout( waittime, "vehicleNavSplineInterrupted", "vehicleStuckNavSpline", "sweeperDrone_withinMarkingRange", "sweeperDrone_cancelSearch", "sweeperDrone_usingtraversal", "sweeperDrone_repath" );
    
    if ( msg == "timeout" || msg == "vehicleNavSplineInterrupted" || msg == "vehicleStuckNavSpline" || msg == "sweeperDrone_cancelSearch" || msg == "sweeperDrone_repath" )
    {
        sweeperdata notify( #"hash_8112470b3a49b8b8", "repath" );
        return;
    }
    else if ( msg == "sweeperDrone_usingtraversal" )
    {
        while ( self issplinepathusingtraversallink() )
        {
            heightoffset = 15;
            self setconfigvalue( "path", "navSplinePathHeightOffset", heightoffset );
            waitframe();
        }
        
        heightoffset = level.helperdronesettings[ "sweeper_drone" ].heightoffset;
        self setconfigvalue( "path", "navSplinePathHeightOffset", heightoffset );
        sweeperdata notify( #"hash_8112470b3a49b8b8", "repath" );
        return;
    }
    
    thread function_e40430225168bbed( enemyplayer, sweeperdata );
}

// Namespace sweeper_drones
// Params 13
// Checksum 0x1a3a329a, Offset: 0x4841
// Size: 0x34b
function sweeperdrone_destroy( inflictor, attacker, damage, idflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname, istimeout )
{
    level endon( #"game_ended" );
    self notify( #"death" );
    
    if ( self.isdestroyed )
    {
        return 0;
    }
    
    if ( isdefined( attacker ) && isdefined( attacker.perks[ "specialty_traceback" ] ) && utility::issharedfuncdefined( #"traceback", #"try_traceback" ) )
    {
        attacker [[ utility::getsharedfunc( #"traceback", #"try_traceback" ) ]]( self );
    }
    
    self.isdestroyed = 1;
    
    if ( isdefined( self.owner ) )
    {
        sweeperdata = self.owner function_ee9f62709472bfad();
        sweeperdata.drones = arrayremove( sweeperdata.drones, self );
        
        if ( sweeperdata.drones.size == 0 )
        {
            self.owner function_ec20122f62304b96();
        }
    }
    
    function_2712a8790498d268( 1 );
    
    if ( !istimeout )
    {
        self setscriptablepartstate( "body_damage_heavy", "on", 0 );
    }
    
    self removecomponent( "path" );
    self removecomponent( "p2p" );
    
    if ( isdefined( damage ) )
    {
        maximpulse = 20;
        minimpulse = 5;
        maxdamage = 40;
        mindamage = 1;
        damageimpulse = minimpulse + ( maximpulse - minimpulse ) * ( damage - mindamage ) / ( maxdamage - mindamage );
        damageimpulse = clamp( damageimpulse, minimpulse, maximpulse );
    }
    
    impulsedir = dir ?? ( randomint( 8 ), randomint( 8 ), 1 );
    impulsestrength = damageimpulse ?? randomint( 5 );
    self vehphys_impulse( impulsedir, impulsestrength, 0 );
    self vehphys_enablecollisioncallback( 1 );
    challengeparams = { #modifiers:[], #hitloc:"", #objweapon:objweapon, #meansofdeath:"MOD_EXPLOSION", #damageflags:undefined, #damage:self.maxhealth, #attacker:attacker, #inflictor:inflictor, #victim:self };
    callback::callback( #"equipment_destroyed", challengeparams );
    msg = utility::waittill_notify_or_timeout_return( "collision", 0.5 );
    self setscriptablepartstate( "exit", "on", 0 );
    
    if ( player_utility::playersareenemies( self.owner, attacker ) )
    {
        self.bundle = level.sweeperdrones.superbundle;
        thread utility::callsharedfunc( #"supers", #"hash_28aeb93023a8a138", attacker, objweapon );
    }
    
    wait 0.25;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace sweeper_drones
// Params 1
// Checksum 0x9de89781, Offset: 0x4b94
// Size: 0x5d
function function_a75800bed32e4417( sweeperdata )
{
    self endon( #"hash_95c1ba20cf031dc6" );
    self endon( #"death" );
    self endon( #"hash_e5b814919c20ff01" );
    sweeperdata endon( #"hash_8112470b3a49b8b8" );
    
    while ( true )
    {
        if ( self issplinepathusingtraversallink() )
        {
            self notify( #"sweeperDrone_usingtraversal" );
            break;
        }
        
        waitframe();
    }
}

// Namespace sweeper_drones
// Params 1
// Checksum 0x281398c, Offset: 0x4bf9
// Size: 0x92
function function_a42d035da18cd23b( sweeperdata )
{
    self endon( #"hash_95c1ba20cf031dc6" );
    self endon( #"death" );
    self endon( #"hash_e5b814919c20ff01" );
    sweeperdata endon( #"hash_8112470b3a49b8b8" );
    
    while ( true )
    {
        heightoffset = 0;
        
        if ( self issplinepathusingtraversallink() )
        {
            heightoffset = 15;
        }
        else
        {
            heightoffset = level.helperdronesettings[ "sweeper_drone" ].heightoffset;
        }
        
        self setconfigvalue( "path", "navSplinePathHeightOffset", heightoffset );
        waitframe();
    }
}

// Namespace sweeper_drones
// Params 2
// Checksum 0x71150ff3, Offset: 0x4c93
// Size: 0x54
function function_66647e9cbb5bba3e( enemyplayer, sweeperdata )
{
    self endon( #"hash_e5b814919c20ff01" );
    self endon( #"hash_95c1ba20cf031dc6" );
    sweeperdata endon( #"hash_8112470b3a49b8b8" );
    enemyplayer waittill( #"death_or_disconnect" );
    self notify( #"sweeperDrone_cancelSearch" );
}

// Namespace sweeper_drones
// Params 5
// Checksum 0x6a98b6e3, Offset: 0x4cef
// Size: 0x351
function function_fd8984a4eacb79ed( goallocation, enemyplayer, speedmph, var_9bf7404017a1db9b, debugdraw )
{
    droneconfig = level.helperdronesettings[ "sweeper_drone" ];
    offset = droneconfig.heightoffset;
    
    if ( isdefined( self.var_676faec94ee7fa19 ) )
    {
        startlocation = self.var_676faec94ee7fa19;
        self.var_676faec94ee7fa19 = undefined;
    }
    else
    {
        startlocation = self.origin + ( 0, 0, offset ) * -1;
    }
    
    if ( !ispointonnavmesh( startlocation ) )
    {
        contents = droneconfig.var_47cefc5b1c8b888f;
        tracestart = startlocation;
        traceend = self.origin + ( 0, 0, -300 );
        trace = trace::sphere_trace( tracestart, traceend, 5.18, [ self ], contents );
        
        if ( trace[ "hittype" ] != "hittype_none" && ispointonnavmesh( trace[ "position" ] ) )
        {
            startlocation = trace[ "position" ];
            
            /#
                level thread debug_utility::drawsphere( trace[ "<dev string:x32>" ], 5.18, 1, ( 0, 1, 0 ) );
            #/
        }
        else
        {
            /#
                print( "<dev string:xd5>" );
                level thread debug_utility::drawsphere( trace[ "<dev string:x32>" ], 5.18, 1, ( 1, 0, 0 ) );
            #/
            
            startlocation = self.origin;
        }
    }
    else
    {
        tracestart = self.origin + ( 0, 0, 0.5 );
        traceend = startlocation + ( 0, 0, 200 ) * -1;
        trace = trace::ray_trace( tracestart, traceend, self, droneconfig.var_47cefc5b1c8b888f );
        
        if ( trace[ "hittype" ] != "hittype_none" )
        {
            startlocation = trace[ "position" ];
        }
    }
    
    vehicleforward = anglestoforward( self.angles );
    lookaheadoffset = getdvarfloat( @"hash_1e80daba586dbf73", 5 );
    lookaheadscalar = getdvarfloat( @"hash_767cfe11023709c", 0.25 );
    ignoretraversals = "drone soldier";
    var_6ba7397cdf0f5a11 = getdvarint( @"hash_944c483259412ac0", 1 );
    preferredradius = getdvarint( @"hash_c101972d3a75a542", 2 );
    enemylocation = goallocation;
    
    if ( isdefined( enemyplayer ) )
    {
        enemylocation = enemyplayer.origin;
    }
    
    toenemy = enemylocation - goallocation;
    toenemydir = ( 0, 0, 0 );
    
    if ( length2d( toenemy ) > 0.01 )
    {
        toenemydir = vectornormalize2( toenemy );
    }
    
    splinepoints = self findsplinepath( startlocation, goallocation, var_6ba7397cdf0f5a11, preferredradius, 2, vehicleforward, toenemydir, lookaheadoffset, lookaheadscalar, 0, ignoretraversals, var_9bf7404017a1db9b, 0, 1 );
    
    /#
        if ( isdefined( splinepoints ) && debugdraw )
        {
            thread vehicle_roads::function_2b723e6a5a86a006( splinepoints, isdefined( var_9bf7404017a1db9b ) ? ( 1, 1, 1 ) : ( 1, 0, 0 ) );
        }
    #/
    
    thread vehicle_roads::watch_stuck();
    thread vehicle_roads::watch_interrupt();
    return splinepoints;
}

// Namespace sweeper_drones
// Params 2
// Checksum 0x1b8e969c, Offset: 0x5049
// Size: 0x32a
function function_3c77ec903982db91( enemyplayer, sweeperdata )
{
    sweeperdata endon( #"hash_8112470b3a49b8b8" );
    self endon( #"hash_95c1ba20cf031dc6" );
    self endon( #"death" );
    self endon( #"hash_e5b814919c20ff01" );
    enemyplayer endon( #"death_or_disconnect" );
    markdistance = getdvarfloat( @"scr_sweeper_drone_mark_distance", 150 );
    lostime = getdvarfloat( @"hash_e4de798249f997c2", 1 );
    markdistsq = markdistance * markdistance;
    brakedist = getdvarint( @"hash_7db747fd9b77d83f", 225 );
    brakedistsq = brakedist * brakedist;
    
    if ( !isdefined( self.lostimer ) )
    {
        self.lostimer = 0;
    }
    
    if ( isdefined( self.currentenemy ) && self.currentenemy != enemyplayer )
    {
        self.lostimer = 0;
    }
    
    while ( true )
    {
        var_d049034dcd98290d = undefined;
        
        if ( isplayer( enemyplayer ) || isagent( enemyplayer ) )
        {
            var_d049034dcd98290d = distancesquared( self.origin, enemyplayer utility::function_68061c3d21a6d57a() ) <= markdistsq;
        }
        else
        {
            var_d049034dcd98290d = distancesquared( self.origin, enemyplayer.origin ) <= markdistsq;
        }
        
        visibilitypos = self.var_84c118df363d5d65.destination + ( 0, 0, level.helperdronesettings[ "sweeper_drone" ].heightoffset );
        isvisible = function_8a078e7d2f8bf61e( enemyplayer, visibilitypos );
        shouldbrake = distancesquared( self.origin, self.var_84c118df363d5d65.destination ) <= brakedistsq;
        
        if ( shouldbrake && isvisible )
        {
            self setconfigvalue( "p2p", "stopAtGoal", 1 );
            self setconfigvalue( "p2p", "aimAtGoal", 1 );
            self setconfigvalue( "p2p", "lookAtEntityNum", enemyplayer getentitynumber() );
        }
        else
        {
            self setconfigvalue( "p2p", "stopAtGoal", 0 );
            self setconfigvalue( "p2p", "aimAtGoal", 0 );
            self setconfigvalue( "p2p", "lookAtEntityNum", -1 );
        }
        
        if ( var_d049034dcd98290d && isvisible )
        {
            self.var_d12cbdf6a38a8be1 = 1;
        }
        else
        {
            if ( self.var_d12cbdf6a38a8be1 )
            {
                self notify( #"sweeperDrone_repath" );
            }
            
            self.var_d12cbdf6a38a8be1 = 0;
            self.lostimer = 0;
        }
        
        if ( self.lostimer >= lostime )
        {
            waitframe();
            self.var_d12cbdf6a38a8be1 = 0;
            self notify( #"sweeperDrone_withinMarkingRange" );
            break;
        }
        else if ( self.lostimer >= lostime / 2 && !isdefined( enemyplayer.perks[ "specialty_noscopeoutline" ] ) )
        {
            self setscriptablepartstate( "flash_glint", "on", 0 );
        }
        
        if ( self.var_d12cbdf6a38a8be1 )
        {
            self.lostimer += level.framedurationseconds;
        }
        
        waitframe();
    }
}

// Namespace sweeper_drones
// Params 2
// Checksum 0x79d9e0a7, Offset: 0x537b
// Size: 0x187
function function_6873fc1e8b025b11( enemy, sweeperdata )
{
    if ( isplayer( enemy ) || isagent( enemy ) )
    {
        if ( isplayer( enemy ) )
        {
            enemy thread outline::_hudoutlineviewmodelenable( "snapshotgrenade", 0 );
            enemy thread snapshot::function_c802f1ac50040a2c();
            enemy thread snapshot::function_23f4614f16363579();
            enemy thread function_317aad539ccf85d6();
        }
        
        enemy setscriptablepartstate( "snapshotVFX", "snapshot" );
        enemy.var_2043360363d22f5b = 1;
        enemy.var_53335d43c07de017 = self.owner;
        enemy.var_3d9ce8b820bd6625 = self;
        enemy.var_3de020a9a12fb43d[ self.owner.team ?? self.owner.agentteam ] = gettime();
        function_ad4ccc3e3ed573b( self, enemy );
    }
    
    thread function_ceb230f28c816e0b( enemy );
    triggerportableradarpingteam( enemy.origin, self.owner.team ?? self.owner.agentteam, 16, 1000, -1, 1 );
    
    if ( getdvarint( @"hash_92b7308c427aa634", 0 ) == 0 )
    {
        if ( isplayer( enemy ) )
        {
            enemy callback::add( #"player_death", &function_8bf19170a3b60365, sweeperdata );
        }
        else if ( isagent( enemy ) )
        {
            enemy callback::add( #"on_ai_killed", &function_8bf19170a3b60365, sweeperdata );
        }
    }
    
    return enemy;
}

// Namespace sweeper_drones
// Params 0
// Checksum 0x669c8f52, Offset: 0x550b
// Size: 0x24
function function_317aad539ccf85d6()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    wait 2;
    outline::_hudoutlineviewmodeldisable();
}

// Namespace sweeper_drones
// Params 0
// Checksum 0x8485778a, Offset: 0x5537
// Size: 0x5c
function function_f8f87acac8a3cd6d()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    for ( i = 0; i < 3 ; i++ )
    {
        self setscriptablepartstate( "snapshotVFX", "snapshot" );
        waitframe();
        self setscriptablepartstate( "snapshotVFX", "off" );
        wait 0.15;
    }
}

// Namespace sweeper_drones
// Params 2
// Checksum 0x7699ba7c, Offset: 0x559b
// Size: 0x3e3
function function_e40430225168bbed( enemyplayer, sweeperdata )
{
    snapshotradius = getdvarint( @"hash_ef9214f5bcef1114", 300 );
    enemiesinradius = getplayersandaiarrayinradius( self.origin, snapshotradius, enemyplayer.team );
    var_486a631926d92c71 = [];
    
    if ( getdvarint( @"hash_92b7308c427aa634", 0 ) == 0 )
    {
        sweeperdata.markedtargets[ enemyplayer getentitynumber() ] = enemyplayer;
    }
    
    var_486a631926d92c71[ var_486a631926d92c71.size ] = enemyplayer;
    
    foreach ( enemy in enemiesinradius )
    {
        if ( arraycontains( var_486a631926d92c71, enemy ) )
        {
            continue;
        }
        
        if ( !arraycontains( sweeperdata.markedtargets, enemy ) )
        {
            if ( getdvarint( @"hash_92b7308c427aa634", 0 ) == 0 )
            {
                sweeperdata.markedtargets[ enemy getentitynumber() ] = enemy;
            }
            
            var_486a631926d92c71[ var_486a631926d92c71.size ] = enemy;
        }
    }
    
    var_5c0bd856d5c2c00e = [];
    
    foreach ( var_81877ab577b1c8d5 in var_486a631926d92c71 )
    {
        if ( !isdefined( var_81877ab577b1c8d5.perks[ "specialty_noscopeoutline" ] ) )
        {
            var_5c0bd856d5c2c00e[ var_5c0bd856d5c2c00e.size ] = function_6873fc1e8b025b11( var_81877ab577b1c8d5, sweeperdata );
            sweeperdata.owner utility::delaythread( 0.1, &function_bf005970f45f01f8 );
            continue;
        }
        
        self.owner damagefeedback::updatedamagefeedback( "hitnooutline", undefined, undefined, undefined, 1 );
        var_81877ab577b1c8d5 perks::activateperk( "specialty_covert_ops" );
    }
    
    if ( var_5c0bd856d5c2c00e.size != 0 )
    {
        self setscriptablepartstate( "flash_glint", "on", 0 );
    }
    
    self notify( #"hash_e5b814919c20ff01" );
    teammates = teams::getsquadmates( self.owner.team, self.owner.sessionsquadid, 1 );
    bundle = level.sweeperdrones.superbundle;
    snapshotasset = bundle.var_894c75ef9f91749c ?? "snapshotgrenade";
    outlineduration = bundle.var_4cd88829233e5d68 ?? 0.08;
    
    /#
        if ( getdvarfloat( @"scr_sweeper_drone_outline_duration", 0 ) )
        {
            outlineduration = getdvarfloat( @"scr_sweeper_drone_outline_duration" );
        }
    #/
    
    utility::delaythread( 0.25, &sweeperdrone_resetscriptable );
    
    foreach ( drone in sweeperdata.drones )
    {
        drone.lostimer = 0;
    }
    
    sweeperdata.onpath = 0;
    sweeperdata.currentdirection = vectornormalize2( self.origin - sweeperdata.startingposition );
    sweeperdata.startingposition = self.origin;
    sweeperdata notify( #"hash_8112470b3a49b8b8", "mark" );
}

// Namespace sweeper_drones
// Params 0
// Checksum 0x8bbbef9f, Offset: 0x5986
// Size: 0x1e
function function_bf005970f45f01f8()
{
    points::doscoreevent( #"hash_7730b1d54a259f3d" );
    damagefeedback::updatedamagefeedback( "" );
}

// Namespace sweeper_drones
// Params 1
// Checksum 0xce24a043, Offset: 0x59ac
// Size: 0xf5
function function_ceb230f28c816e0b( target )
{
    level endon( #"game_ended" );
    target endon( #"disconnect" );
    owner = self.owner;
    owner endon( #"disconnect" );
    result = target utility::waittill_notify_or_timeout_return( "death", getdvarfloat( @"hash_3390d8b8dab99fc8", 5 ) );
    targetdead = result == "death" || !isalive( target );
    
    if ( targetdead && isdefined( target.lastkilledby ) && target.lastkilledby != owner )
    {
        if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
        {
            owner thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( #"sweeper_drone_assist" );
        }
    }
}

// Namespace sweeper_drones
// Params 2
// Checksum 0x332f15e9, Offset: 0x5aa9
// Size: 0x6d
function function_8bf19170a3b60365( params, sweeperdata )
{
    if ( isdefined( sweeperdata ) )
    {
        sweeperdata.markedtargets[ self getentitynumber() ] = undefined;
    }
    
    if ( isplayer( self ) )
    {
        callback::remove( #"player_death", &function_8bf19170a3b60365, sweeperdata );
        return;
    }
    
    if ( isagent( self ) )
    {
        callback::remove( #"on_ai_killed", &function_8bf19170a3b60365, sweeperdata );
    }
}

// Namespace sweeper_drones
// Params 0
// Checksum 0x99468bdc, Offset: 0x5b1e
// Size: 0x13
function sweeperdrone_resetscriptable()
{
    self setscriptablepartstate( "flash_glint", "off", 0 );
}

/#

    // Namespace sweeper_drones
    // Params 0, eflags: 0x4
    // Checksum 0xd5af9a10, Offset: 0x5b39
    // Size: 0x52, Type: dev
    function private debugdevgui()
    {
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        wait 1;
        level.var_9bf7404017a1db9b = "<dev string:x12a>";
        setdvar( @"hash_3da6063811d9bed8", 15 );
        setdvar( @"debugdevgui", 0 );
        level thread function_7a5a398dcdac1d4a();
    }

    // Namespace sweeper_drones
    // Params 0, eflags: 0x4
    // Checksum 0x87e575fd, Offset: 0x5b93
    // Size: 0x79, Type: dev
    function private function_7a5a398dcdac1d4a()
    {
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        while ( true )
        {
            cmd = getdvarint( @"debugdevgui", 0 );
            
            switch ( cmd )
            {
                case 10:
                    break;
                default:
                    break;
            }
            
            setdevdvar( @"debugdevgui", 0 );
            wait 0.5;
        }
    }

    // Namespace sweeper_drones
    // Params 1
    // Checksum 0x122943b, Offset: 0x5c14
    // Size: 0x123, Type: dev
    function function_ccec08c945911edf( droneconfig )
    {
        level endon( #"game_ended" );
        setdevdvarifuninitialized( @"scr_seeker_drone_debug", "<dev string:x138>" );
        
        while ( true )
        {
            host = level.players[ 0 ];
            dvarval = getdvar( @"scr_seeker_drone_debug", "<dev string:x138>" );
            
            if ( isdefined( host ) && dvarval != "<dev string:x138>" )
            {
                [ command ] = strtok( dvarval, "<dev string:x139>" );
                
                switch ( command )
                {
                    case #"hash_5b81492c0b31c71b":
                        droneconfig.var_5656d6269df25e83 = 1;
                        break;
                    case #"hash_831d5a0c0dd8de25":
                        droneconfig.var_c02363ae8581320a = 1;
                        break;
                    case #"hash_596ee566b5bcf839":
                        droneconfig.ignoreperks = 1;
                    default:
                        break;
                }
            }
            
            setdvar( @"scr_seeker_drone_debug", "<dev string:x138>" );
            wait 0.5;
        }
    }

#/

// Namespace sweeper_drones
// Params 2, eflags: 0x4
// Checksum 0x7caf1ae, Offset: 0x5d3f
// Size: 0x129
function private function_ad4ccc3e3ed573b( sweeperdrone, victim )
{
    if ( !isdefined( sweeperdrone.challengedata ) )
    {
        sweeperdrone.challengedata = {};
    }
    
    if ( !isdefined( sweeperdrone.challengedata.bitmodifiers ) )
    {
        sweeperdrone.challengedata.bitmodifiers = [];
    }
    
    sweeperdrone.challengedata.marked_victims = arraycombineunique( sweeperdrone.challengedata.marked_victims, [ victim ] );
    sweeperdrone.challengedata.bitmodifiers = arraycombineunique( sweeperdrone.challengedata.bitmodifiers, [ #"mark_target" ] );
    challengeparams = { #fieldupgraderef:"super_sweeper_drones", #fieldupgradeent:sweeperdrone, #victim:victim, #attacker:sweeperdrone.owner };
    callback::callback( #"field_upgrade_hit", challengeparams );
}

