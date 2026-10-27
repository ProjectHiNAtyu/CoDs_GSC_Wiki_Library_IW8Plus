// scripts\mp\common\equipment\pathing_drone.gsc  (hash_480f4885c4c584df.gscc) (size: 18563 Bytes / 0x4883 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x98772de1 (2557947361)
// size ...... 18563 (0x4883)
// includes .. 15  (offset: 0x42cb)
// strings ... 79  (offset: 0x4343)
// dev strs .. 5   (offset: 0x4843)
// exports ... 32  (offset: 0x3013)
// cseg ...... 0x679 + 0x299a (0x3013)
// imports ... 105 (offset: 0x3513)
// animtree1 . 0   (offset: 0x4883)
// animtree2 . 0   (offset: 0x4883)
#using script_16ea1b94f0f381b3;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_roads;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\killstreaks\helper_drone;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\damagefeedback;
#using scripts\mp\hostmigration;
#using scripts\mp\outofbounds;

#namespace pathing_drone;

// Namespace pathing_drone
// Params 3
// Checksum 0x4bd9090f, Offset: 0x697
// Size: 0x247
function function_995a83bf25d44995( ref, super_name, bundle )
{
    pathingstruct = spawnstruct();
    pathingstruct.supername = super_name;
    pathingstruct.superbundle = bundle;
    pathingstruct.speed = bundle.var_cd4c82b3b10ba1f6 ?? 10;
    pathingstruct.accel = bundle.var_aa7f0d0f7ad45b65 ?? 30;
    pathingstruct.goal_radius = bundle.var_caf562c8eb9623ef ?? 300;
    pathingstruct.heightoffset = bundle.var_400cc1a4debaf73e ?? 30;
    pathingstruct.drone_height = bundle.var_4c0033ff1f819624 ?? 5.18;
    pathingstruct.drone_length = bundle.var_1b3657b383814383 ?? 21.1;
    pathingstruct.drone_width = bundle.var_6b0d31f9432fc4d ?? 3.84;
    pathingstruct.callbacks = [];
    helperstruct = spawnstruct();
    helperstruct.maxhealth = bundle.maxhealth ?? 10;
    helperstruct.hitstokill = 1;
    helperstruct.spawndist = 30;
    helperstruct.vehicleinfo = bundle.var_d9a7a81faf90219;
    helperstruct.modelbase = bundle.pathing_drone_model;
    helperstruct.timeout = bundle.var_783db5101c19ba77 ?? 45;
    helperstruct.premoddamagefunc = undefined;
    helperstruct.postmoddamagefunc = &helper_drone::helperdrone_postmodifydamage;
    helperstruct.targetname = ref;
    helperstruct.var_17e473e12ced7138 = 1;
    helperstruct.var_47cefc5b1c8b888f = physics_createcontents( [ "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_itemclip", "physicscontents_clipshot" ] );
    level.pathingdrones[ ref ] = pathingstruct;
    level.helperdronesettings[ ref ] = helperstruct;
}

// Namespace pathing_drone
// Params 3
// Checksum 0xf15cd13b, Offset: 0x8e6
// Size: 0x38
function function_5c1dec5deefca293( ref, event, callback )
{
    level.pathingdrones[ ref ].callbacks[ event ] = callback;
}

// Namespace pathing_drone
// Params 0
// Checksum 0xd6b84ae3, Offset: 0x926
// Size: 0x2a
function function_fd568f1170ca636b()
{
    self endon( #"hash_53104ce06d3b320f" );
    utility::waittill_any_ents( level, "game_ended", self, "disconnect" );
    vehicle_tracking::function_4f76f5b4541acef1( 1 );
}

// Namespace pathing_drone
// Params 2
// Checksum 0x22e65ac0, Offset: 0x958
// Size: 0x765
function pathingdrone_createdrone( dronedata, spawndata )
{
    droneconfig = level.helperdronesettings[ dronedata.drone_ref ];
    pathingconfig = level.pathingdrones[ dronedata.drone_ref ];
    
    /#
        if ( droneconfig.var_5656d6269df25e83 )
        {
            level thread debug_utility::drawsphere( spawndata.origin, 5, 30, ( 0, 1, 0 ) );
        }
    #/
    
    spawndata.owner = self;
    spawndata.team = self.team;
    streakinfo = undefined;
    dronespeed = getdvarfloat( @"hash_27414ffeb1f39e41", pathingconfig.speed );
    droneaccel = getdvarfloat( @"hash_45d02fb56e7f79b2", pathingconfig.accel );
    height = pathingconfig.heightoffset;
    speedmph = dronespeed;
    speedips = utility::mph_to_ips( speedmph );
    newvel = vectornormalize( spawndata.velocity );
    coeff = clamp( length( spawndata.velocity ), 0, speedips );
    coeff *= getdvarfloat( @"hash_908b6d31ec13c71b", 1 );
    newvel *= coeff;
    pathing_drone = helper_drone::createhelperdrone( spawndata.origin, spawndata.angles, dronedata.drone_ref, streakinfo, 0, 0, newvel );
    pathing_drone.streakinfo = streakinfo;
    pathing_drone.owner.vehicle = undefined;
    pathing_drone.deathcallback = &pathingdrone_destroy;
    pathing_drone.var_a94bc4d31cd64b2f = 1;
    dronedata.drone = pathing_drone;
    pathing_drone sethoverparams( 1, 5, 5 );
    waitframe();
    pathing_drone.superref = level.pathingdrones[ dronedata.drone_ref ].supername;
    pathing_drone addcomponent( "p2p" );
    pathing_drone addcomponent( "path" );
    pathing_drone function_eb88c4e66edbc855( "p2p", "checkStuck", 1 );
    pathing_drone function_eb88c4e66edbc855( "p2p", "stuckDistanceThreshold", 10 );
    pathing_drone function_eb88c4e66edbc855( "p2p", "reverseGasWhileStuck", 0.8 );
    pathing_drone function_eb88c4e66edbc855( "p2p", "reverseGasNormal", 0.4 );
    pathing_drone function_eb88c4e66edbc855( "p2p", "brakeAtGoal", 0 );
    pathing_drone function_eb88c4e66edbc855( "p2p", "automaticNormal", 1 );
    pathing_drone function_eb88c4e66edbc855( "p2p", "brakeOnGoalGasbrake", 1 );
    pathing_drone function_eb88c4e66edbc855( "p2p", "goalPoint", spawndata.var_1aca040d13a96ec4 );
    pathing_drone function_eb88c4e66edbc855( "p2p", "goalAngles", angleclamp180( spawndata.angles ) );
    pathing_drone function_eb88c4e66edbc855( "p2p", "goalThreshold", getdvarint( @"hash_753ce9ff871a1745", 4 ) );
    pathing_drone function_eb88c4e66edbc855( "p2p", "goalThresholdMin", getdvarint( @"hash_f6c34b8f88ed3e9a", 2 ) );
    pathing_drone function_eb88c4e66edbc855( "p2p", "throttleSpeedClose", 1 );
    pathing_drone function_eb88c4e66edbc855( "p2p", "throttleSpeedThreshold", 1 );
    pathing_drone function_eb88c4e66edbc855( "p2p", "automaticFastTopspeedFraction", 1 );
    pathing_drone function_eb88c4e66edbc855( "p2p", "throttleSpeedFarBelow", 1 );
    pathing_drone function_eb88c4e66edbc855( "p2p", "throttleSpeedFarAbove", 4 );
    pathing_drone function_eb88c4e66edbc855( "p2p", "throttleSpeedClose", 2 );
    pathing_drone function_eb88c4e66edbc855( "p2p", "gasToStopMovement", 0.9 );
    pathing_drone function_eb88c4e66edbc855( "p2p", "steeringMultiplier", 2.5 );
    pathing_drone function_eb88c4e66edbc855( "p2p", "stopAtGoal", 0 );
    pathing_drone function_eb88c4e66edbc855( "p2p", "stopAtGoalOscillationFrequency", getdvarfloat( @"hash_bc1777d27fa04c39", 1.2 ) );
    pathing_drone function_eb88c4e66edbc855( "p2p", "aimAtGoal", 0 );
    pathing_drone function_eb88c4e66edbc855( "p2p", "lookAtEntityNum", -1 );
    pathing_drone function_eb88c4e66edbc855( "p2p", "vtol3DLiftValSlowDownHeight", 30 );
    pathing_drone function_eb88c4e66edbc855( "p2p", "vtol3DGoalAngleAlignmentEnable", 1 );
    pathing_drone function_eb88c4e66edbc855( "p2p", "vtol3DGoalAngleAlignmentInfluenceRange", getdvarfloat( @"hash_fe3346abebe17ebd", 40 ) );
    pathing_drone function_eb88c4e66edbc855( "p2p", "vtol3DStrafeInputEnable", 1 );
    pathing_drone function_eb88c4e66edbc855( "p2p", "vtol3DStrafeInputSlowDownDistance", getdvarfloat( @"hash_ce2f0ae6be536f6b", 4 ) );
    pathing_drone function_eb88c4e66edbc855( "p2p", "vtol3DReachGoalHeightEnable", 1 );
    pathing_drone function_eb88c4e66edbc855( "p2p", "vtol3DReachGoalHeightThreshold", 20 );
    pathing_drone function_eb88c4e66edbc855( "p2p", "vtol3DReachGoalYawEnable", 0 );
    pathing_drone function_eb88c4e66edbc855( "p2p", "vtol3DReachGoalYawThreshold", 15 );
    bundle = level.pathingdrones[ dronedata.drone_ref ].superbundle;
    outlineasset = bundle.var_9d17baea56fc2d2a ?? "sweeper_drone_outline";
    pathing_drone thread outline::outlineenableforteam( pathing_drone, self.team, outlineasset, "perk_superior" );
    
    /#
        debugcolor = ( 0, 0, 1 );
    #/
    
    pathing_drone.debugcolor = debugcolor;
    pathing_drone function_eb88c4e66edbc855( "p2p", "manualSpeed", speedips );
    pathing_drone function_eb88c4e66edbc855( "path", "navSplinePathHeightOffset", height );
    pathing_drone function_eb88c4e66edbc855( "path", "navSplineUseDroneStepMethod", 1 );
    pathing_drone function_eb88c4e66edbc855( "path", "advanceOnStart", 1 );
    pathing_drone function_eb88c4e66edbc855( "path", "radiusToStep", 120 );
    pathing_drone function_eb88c4e66edbc855( "path", "stepSpeedFactor", 0 );
    pathing_drone function_eb88c4e66edbc855( "path", "stepProximityFactor", 0 );
    pathing_drone vehicle_setvelocity( spawndata.velocity );
    pathing_drone vehicle_setspeed( dronespeed, droneaccel, droneaccel );
    pathing_drone.pathspeed = dronespeed;
    vehicle_tracking::function_4f76f5b4541acef1();
    namespace_9d8e359c3b1041e5::emp_debuff_register_sharedfunc( pathing_drone, &pathingdrone_empapplied );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"push_zone" ][ #"hash_4f146fe3a20624d1" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        pathing_drone [[ var_32dbca3143d9c4a5 ]]( &pathingdrone_destroy );
    }
    
    pathing_drone thread function_9f859850c9d180bb( dronedata.timeout );
    pathing_drone thread function_ebc86daf151664d9();
    
    if ( getdvarint( @"hash_e544d208acff452f", 0 ) )
    {
        pathing_drone thread function_449e78f0d8465133( droneconfig );
    }
    
    if ( getdvarint( @"hash_6a23cf050245af32", 1 ) == 1 && bundle.var_8b30cddb8450ae89 )
    {
        pathing_drone thread function_c665ac5d97cf0fb3();
    }
    
    self notify( #"hash_53104ce06d3b320f" );
    callback = level.pathingdrones[ dronedata.drone_ref ].callbacks[ "onSpawn" ];
    
    if ( callback )
    {
        pathing_drone thread [[ callback ]]( dronedata );
    }
    
    return pathing_drone;
}

// Namespace pathing_drone
// Params 1
// Checksum 0x4bb02893, Offset: 0x10c6
// Size: 0x17f
function function_449e78f0d8465133( droneconfig )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    defaultaccel = level.pathingdrones[ droneconfig.drone_ref ].accel;
    
    while ( self.owner )
    {
        minspeed = getdvarint( @"hash_cdcb4ce91692d2a", 5 );
        maxspeed = droneconfig.speed;
        var_dcea9e7ca9583ed7 = getdvarint( @"hash_6749c433183892a4", 1250 );
        var_f62f21678ce291fd = getdvarint( @"hash_3173a8fea3d48913", 750 );
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
            self function_eb88c4e66edbc855( "p2p", "manualSpeed", speedips );
        }
        
        wait 0.25;
    }
}

// Namespace pathing_drone
// Params 0
// Checksum 0x5726bbd8, Offset: 0x124d
// Size: 0x185
function function_c665ac5d97cf0fb3()
{
    self endon( #"death" );
    self.doorsopened = [];
    
    while ( true )
    {
        var_38738ca0abd6cf9d = getdvarint( @"hash_f3d0b016c34bf38c", 75 );
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
            
            door childthread function_361d3b04e892435f( self );
            self.doorsopened[ self.doorsopened.size ] = door;
        }
        
        wait 0.25;
    }
}

// Namespace pathing_drone
// Params 1
// Checksum 0xe3e90770, Offset: 0x13da
// Size: 0x1c6
function function_361d3b04e892435f( drone )
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
            var_2611f56edca50857 = getdvarint( @"hash_628a3e14532039bf", 15 );
            fwdoffset = getdvarint( @"hash_7f58e35f0f366a3a", 50 );
            origin = self.origin + anglestoforward( var_9f1f9965afa63fb9 ) * var_2611f56edca50857 + anglestoforward( self.angles ) * fwdoffset;
            drone.var_676faec94ee7fa19 = origin;
            drone.forcerepath = 1;
            drone notify( #"pathingDrone_repath" );
            return;
        }
        
        waittime = getdvarfloat( @"hash_86a2dc6687d42a4e", 1 );
        wait waittime;
    }
}

// Namespace pathing_drone
// Params 1
// Checksum 0x3fdfdc97, Offset: 0x15a8
// Size: 0x6a
function pathingdrone_empapplied( data )
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
    
    thread pathingdrone_destroy( undefined, attacker );
}

// Namespace pathing_drone
// Params 1
// Checksum 0xaf8bf29, Offset: 0x161a
// Size: 0x3b
function function_9f859850c9d180bb( lifetime )
{
    self endon( #"death" );
    function_db2621c74989e87a( lifetime ?? 45 );
    thread pathingdrone_destroy( undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1 );
}

// Namespace pathing_drone
// Params 1
// Checksum 0x4de2dcd5, Offset: 0x165d
// Size: 0x35
function function_db2621c74989e87a( lifetime )
{
    self.owner endon( #"disconnect" );
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithhostmigrationpause( lifetime );
}

// Namespace pathing_drone
// Params 0, eflags: 0x4
// Checksum 0x5b00bd9f, Offset: 0x169a
// Size: 0x8f
function private function_ebc86daf151664d9()
{
    self endon( #"death" );
    var_4a0acaf5f5403144 = getdvarfloat( @"hash_719faa210312193d", 3 );
    intervalsec = 0.5;
    self.var_be2dfc582f71acfa = 0;
    
    while ( true )
    {
        wait intervalsec;
        
        if ( outofbounds::istouchingoobtrigger() )
        {
            self.var_be2dfc582f71acfa += intervalsec;
            
            if ( self.var_be2dfc582f71acfa >= var_4a0acaf5f5403144 )
            {
                thread pathingdrone_destroy();
                return;
            }
            
            continue;
        }
        
        self.var_be2dfc582f71acfa = 0;
    }
}

// Namespace pathing_drone
// Params 1
// Checksum 0x1ee6c9d5, Offset: 0x1731
// Size: 0x12b
function function_c16277c5bf2c724e( drone_ref )
{
    if ( !drone_ref )
    {
        assert( drone_ref, "<dev string:x24>" );
        drone_ref = "default";
    }
    
    if ( !level.pathingdronedata[ drone_ref ] )
    {
        level.pathingdronedata[ drone_ref ] = [];
    }
    
    if ( !level.pathingdronedata[ drone_ref ][ self getentitynumber() ] )
    {
        pathingdronedata = spawnstruct();
        pathingdronedata.owner = self;
        pathingdronedata.startingorientation = self.angles;
        pathingdronedata.startingposition = self.origin;
        pathingdronedata.markedtargets = [];
        pathingdronedata.drone_ref = drone_ref;
        pathingdronedata.bundle = level.pathingdrones[ drone_ref ].superbundle;
        pathingdronedata.timeout = pathingdronedata.bundle.var_783db5101c19ba77;
        level.pathingdronedata[ drone_ref ][ self getentitynumber() ] = pathingdronedata;
    }
    
    return level.pathingdronedata[ drone_ref ][ self getentitynumber() ];
}

// Namespace pathing_drone
// Params 1
// Checksum 0xa39ce767, Offset: 0x1865
// Size: 0x5a
function function_85c6fe4d792db7d1( drone_ref )
{
    if ( !drone_ref )
    {
        assert( drone_ref, "<dev string:x5e>" );
        drone_ref = "default";
    }
    
    level.pathingdronedata[ drone_ref ][ self getentitynumber() ] notify( #"death" );
    level.pathingdronedata[ drone_ref ][ self getentitynumber() ] = undefined;
}

// Namespace pathing_drone
// Params 3
// Checksum 0xe6d66607, Offset: 0x18c7
// Size: 0x3b
function function_f350c33a57a4da3( dronepos, dims, ang )
{
    /#
        orientedbox( dronepos, dims, ang, ( 1, 0, 0 ), 0, 1000 );
    #/
}

// Namespace pathing_drone
// Params 0
// Checksum 0xa7d1e792, Offset: 0x190a
// Size: 0xa3
function function_73a843ddccd4b09()
{
    length = level.pathingdrones[ self.drone_ref ].drone_length;
    dronepos = self.drone.origin + self.currentdirection * length * -1;
    dims = ( 40, 250, 100 );
    ang = vectortoangles( self.currentdirection );
    self.var_bd806bf6f46d689e = createnavbadplacebybounds( dronepos, dims, ang );
    level thread function_f350c33a57a4da3( dronepos, dims, ang );
}

// Namespace pathing_drone
// Params 2
// Checksum 0x1c0ce4be, Offset: 0x19b5
// Size: 0x37
function function_d614d561430658a( a, b )
{
    if ( a.dist < b.dist )
    {
        return 1;
    }
    
    return 0;
}

// Namespace pathing_drone
// Params 2
// Checksum 0x54410bdd, Offset: 0x19f4
// Size: 0x95, Type: bool
function function_e0b93f4007bd29ee( enemy, dronepos )
{
    droneconfig = level.helperdronesettings[ self.drone_ref ];
    pathdistance = findclosestpointbyapproxpathdist( [ dronepos ], enemy.origin, 1 );
    
    if ( !isdefined( pathdistance ) )
    {
        return false;
    }
    
    entnum = enemy getentitynumber();
    self.var_140568b1b133d3f3[ entnum ] = { #player:enemy, #dist:pathdistance };
    return true;
}

// Namespace pathing_drone
// Params 0
// Checksum 0xfcf755f1, Offset: 0x1a92
// Size: 0xd8
function function_d0d273e359b931b2()
{
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    level endon( #"game_ended" );
    self.currentdirection = anglestoforward( self.startingorientation );
    self.startingposition = self.owner.origin;
    
    /#
        setdevdvarifuninitialized( @"hash_4c803ba16ed42bb1", 0 );
    #/
    
    while ( true )
    {
        /#
            if ( getdvarint( @"hash_4c803ba16ed42bb1", 0 ) == 1 )
            {
                wait 1;
                continue;
            }
        #/
        
        if ( !self.currenttarget )
        {
            self.onpath = 0;
        }
        
        if ( self.onpath )
        {
            function_a8757141586574de( self.currenttarget );
            self.onpath = 0;
        }
        
        waitframe();
    }
}

// Namespace pathing_drone
// Params 1
// Checksum 0x7206c4d1, Offset: 0x1b72
// Size: 0x67
function function_a8757141586574de( target )
{
    directiondata = function_345f38a6f524a7dd( target );
    self.drone thread function_a2fc59f27f0e6f28( target, self, directiondata.destination );
    self waittill( #"hash_bb263c881ca88aff", msg );
    print( "<dev string:x9a>" + gettime() );
}

// Namespace pathing_drone
// Params 1
// Checksum 0x7601411c, Offset: 0x1be1
// Size: 0x3b3
function function_345f38a6f524a7dd( target )
{
    directiondata = spawnstruct();
    horizoffset = getdvarint( @"hash_e2b27aa5d9e8ec96", self.bundle.var_caf562c8eb9623ef ?? 300 );
    angstep = getdvarint( @"hash_9975870114032849", 30 );
    maxsteps = 360 / angstep;
    droneconfig = level.helperdronesettings[ self.drone_ref ];
    pathingconfig = level.pathingdrones[ self.drone_ref ];
    heightoffset = pathingconfig.heightoffset;
    stepcount = 0;
    
    if ( isent( target ) )
    {
        startpos = target.origin + ( 0, 0, heightoffset );
        refvec = vectornormalize( target getvelocity() );
        
        if ( length( refvec ) == 0 )
        {
            refvec = anglestoforward( target.angles );
        }
        
        ignorearray = [ self.drone, target ];
    }
    else
    {
        startpos = target + ( 0, 0, heightoffset );
        refvec = ( 0, 0, 0 );
        ignorearray = [ self.drone ];
    }
    
    startorientation = vectortoangles( refvec );
    radius = 2;
    
    /#
        debugmode = getdvarint( @"hash_e0dd29213037f6e9", 0 );
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
                destination = var_b1fb3b2aba1dcbcf;
                
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
    
    if ( !destination )
    {
        if ( isent( target ) )
        {
            destination = target.origin;
        }
        else
        {
            destination = target;
        }
    }
    
    if ( target == self.owner )
    {
        destination = self.drone.spawndata.origin;
    }
    
    directiondata.destination = destination;
    return directiondata;
}

// Namespace pathing_drone
// Params 0
// Checksum 0xfea2e46f, Offset: 0x1f9d
// Size: 0xb
function function_e0d353c57e505877()
{
    return self.var_84c118df363d5d65;
}

// Namespace pathing_drone
// Params 2
// Checksum 0x22f0dadd, Offset: 0x1fb1
// Size: 0x4c
function function_da17c6c20b4d0211( target, destination )
{
    enemydata = spawnstruct();
    enemydata.target = target;
    enemydata.destination = destination;
    self.var_84c118df363d5d65 = enemydata;
}

// Namespace pathing_drone
// Params 2
// Checksum 0x49dd9531, Offset: 0x2005
// Size: 0x4a
function function_9d40f3cfe8a21abb( target, destination )
{
    self.var_84c118df363d5d65.target = target;
    self.var_84c118df363d5d65.destination = destination;
    return self.var_84c118df363d5d65;
}

// Namespace pathing_drone
// Params 2
// Checksum 0xba66001a, Offset: 0x2058
// Size: 0x259
function function_ecff7f571478e9d0( target, destination )
{
    if ( !target )
    {
        return 0;
    }
    
    if ( !destination )
    {
        if ( isent( target ) )
        {
            destination = self.origin;
        }
        else
        {
            destination = target;
        }
    }
    
    icansee = 0;
    tracecontents = physics_createcontents( [ "physicscontents_itemclip", "physicscontents_item", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_ainosight" ] );
    
    if ( isent( target ) )
    {
        defaultorigin = target.origin;
    }
    else
    {
        defaultorigin = target;
    }
    
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
    else
    {
        tracepoints = [ defaultorigin + ( 0, 0, 10 ) ];
    }
    
    ignorelist = [ self ];
    
    if ( isent( target ) )
    {
        ignorelist[ ignorelist.size ] = target;
        vehicle = target vehicle::get_vehicle();
    }
    
    if ( vehicle )
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

// Namespace pathing_drone
// Params 3
// Checksum 0x40ab48bc, Offset: 0x22ba
// Size: 0x158
function function_f5e493dd258735d1( enemydata, newtarget, newdestination )
{
    currentdestination = enemydata.destination;
    currenttarget = enemydata.target;
    
    if ( self.forcerepath )
    {
        self.forcerepath = undefined;
        return 1;
    }
    
    if ( newtarget != currenttarget )
    {
        return 1;
    }
    
    isvisible = 1;
    
    if ( self.splinepoints )
    {
        isvisible = function_ecff7f571478e9d0( currenttarget, self.splinepoints[ self.splinepoints.size - 1 ] );
    }
    
    var_8ee6ea4a2ddd5a54 = distancesquared( self.origin, currentdestination );
    
    if ( !isvisible )
    {
        var_bd50e9adf64db363 = level.pathingdrones[ self.helperdronetype ].detection_radius ?? getdvarint( @"hash_450a64c213d21839", 100 );
        check_dist_sq = var_bd50e9adf64db363 * var_bd50e9adf64db363;
        
        if ( var_8ee6ea4a2ddd5a54 <= check_dist_sq )
        {
            return 1;
        }
    }
    
    repaththreshold = getdvarint( @"hash_5d002dd4b59e344e", 100 );
    repaththresholdsq = repaththreshold * repaththreshold;
    
    if ( distancesquared( currentdestination, newdestination ) >= repaththresholdsq )
    {
        return 1;
    }
    
    return 0;
}

// Namespace pathing_drone
// Params 3
// Checksum 0xfd843ea3, Offset: 0x241a
// Size: 0x355
function function_a2fc59f27f0e6f28( target, dronedata, destination )
{
    self notify( #"hash_6ff5bbb02d1b1e1c" );
    self endon( #"hash_6ff5bbb02d1b1e1c" );
    self endon( #"hash_bb263c881ca88aff" );
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    
    if ( !destination )
    {
        if ( isent( target ) )
        {
            destination = target.origin;
        }
        else
        {
            destination = target;
        }
    }
    
    shouldpath = 0;
    
    if ( !self.var_84c118df363d5d65 )
    {
        enemydata = function_da17c6c20b4d0211( target, destination );
        shouldpath = 1;
    }
    else
    {
        enemydata = function_e0d353c57e505877();
        shouldpath = function_f5e493dd258735d1( enemydata, target, destination );
    }
    
    if ( shouldpath )
    {
        enemydata = function_9d40f3cfe8a21abb( target, destination );
    }
    
    if ( isent( target ) )
    {
        thread function_fa2d10b0cd8dd8e8( target, dronedata );
    }
    
    thread function_a0e63053d32cb546( target, dronedata );
    thread function_e980919f21305f2d( dronedata );
    droneconfig = level.helperdronesettings[ dronedata.drone_ref ];
    debugdraw = 0;
    
    /#
        debugdraw = getdvarint( @"hash_c059c9b22bfc94a6", 0 );
        
        if ( droneconfig.var_c02363ae8581320a )
        {
            level thread debug_utility::drawsphere( destination, 5, 1, self.debugcolor );
        }
    #/
    
    self.splinedistance = 0;
    
    if ( shouldpath )
    {
        self function_eb88c4e66edbc855( "p2p", "stopAtGoal", 0 );
        self function_eb88c4e66edbc855( "p2p", "aimAtGoal", 0 );
        self function_eb88c4e66edbc855( "p2p", "lookAtEntityNum", -1 );
        splinepoints = function_cc77c0e59446225b( destination, target, self.pathspeed, "soldier", debugdraw, dronedata );
        self.splinepoints = splinepoints;
        
        if ( !splinepoints )
        {
            dronedata notify( #"hash_bb263c881ca88aff", "repath" );
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
    
    waittime = getdvarfloat( @"hash_c3a4407bf1393e48", 0.25 );
    msg = utility::waittill_any_timeout( waittime, "vehicleNavSplineInterrupted", "vehicleStuckNavSpline", "pathingDrone_cancelSearch", "pathingDrone_usingtraversal", "pathingDrone_repath" );
    
    if ( msg == "timeout" || msg == "vehicleNavSplineInterrupted" || msg == "vehicleStuckNavSpline" || msg == "pathingDrone_cancelSearch" || msg == "pathingDrone_repath" )
    {
        dronedata notify( #"hash_bb263c881ca88aff", "repath" );
        return;
    }
    
    if ( msg == "pathingDrone_usingtraversal" )
    {
        while ( self issplinepathusingtraversallink() )
        {
            waitframe();
        }
        
        dronedata notify( #"hash_bb263c881ca88aff", "repath" );
        return;
    }
}

// Namespace pathing_drone
// Params 13
// Checksum 0xed9da2ce, Offset: 0x2777
// Size: 0x20e
function pathingdrone_destroy( inflictor, attacker, damage, idflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname, istimeout )
{
    level endon( #"game_ended" );
    self notify( #"death" );
    
    if ( self.isdestroyed )
    {
        return 0;
    }
    
    self.isdestroyed = 1;
    callback = level.pathingdrones[ self.helperdronetype ].callbacks[ "onDestroy" ];
    
    if ( callback )
    {
        dronedata = level.pathingdrones[ self.helperdronetype ];
        self thread [[ callback ]]( dronedata, inflictor, attacker, damage, idflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname, istimeout );
    }
    
    if ( self.owner )
    {
        self.owner function_85c6fe4d792db7d1( self.helperdronetype );
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
    utility::waittill_notify_or_timeout( "collision", 0.5 );
    wait 0.25;
    
    if ( self )
    {
        self delete();
    }
}

// Namespace pathing_drone
// Params 1
// Checksum 0x2a1d43c3, Offset: 0x298d
// Size: 0x51
function function_e980919f21305f2d( dronedata )
{
    self endon( #"hash_b92e95aeb973e43c" );
    self endon( #"death" );
    dronedata endon( #"hash_bb263c881ca88aff" );
    
    while ( true )
    {
        if ( self issplinepathusingtraversallink() )
        {
            self notify( #"pathingDrone_usingtraversal" );
            break;
        }
        
        waitframe();
    }
}

// Namespace pathing_drone
// Params 2
// Checksum 0x62f813ce, Offset: 0x29e6
// Size: 0x54
function function_fa2d10b0cd8dd8e8( enemyplayer, dronedata )
{
    self endon( #"death" );
    self endon( #"hash_b92e95aeb973e43c" );
    dronedata endon( #"hash_bb263c881ca88aff" );
    enemyplayer waittill( #"death_or_disconnect" );
    self notify( #"pathingDrone_cancelSearch" );
}

// Namespace pathing_drone
// Params 6
// Checksum 0x5a4f2ba5, Offset: 0x2a42
// Size: 0x3cf
function function_cc77c0e59446225b( goallocation, target, speedmph, var_9bf7404017a1db9b, debugdraw, dronedata )
{
    droneconfig = level.helperdronesettings[ dronedata.drone_ref ];
    pathingconfig = level.pathingdrones[ dronedata.drone_ref ];
    offset = pathingconfig.heightoffset;
    
    if ( self.var_676faec94ee7fa19 )
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
        height = level.pathingdrones[ dronedata.drone_ref ].drone_height;
        trace = trace::sphere_trace( tracestart, traceend, height, [ self ], contents );
        
        if ( trace[ "hittype" ] != "hittype_none" && ispointonnavmesh( trace[ "position" ] ) )
        {
            startlocation = trace[ "position" ];
            
            /#
                level thread debug_utility::drawsphere( trace[ "<dev string:xb4>" ], height, 1, ( 0, 1, 0 ) );
            #/
        }
        else
        {
            /#
                print( "<dev string:xbd>" );
                level thread debug_utility::drawsphere( trace[ "<dev string:xb4>" ], height, 1, ( 1, 0, 0 ) );
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
    lookaheadoffset = getdvarfloat( @"hash_d7e9993c12c93e49", 5 );
    lookaheadscalar = getdvarfloat( @"hash_5a3fc3bf6a3e5166", 0.25 );
    ignoretraversals = getdvarint( @"hash_fa67eeaebc6f49ee", 0 );
    var_6ba7397cdf0f5a11 = getdvarint( @"hash_cf1ffa3d4f428ae6", 1 );
    preferredradius = getdvarint( @"hash_b11122390844709c", 2 );
    enemylocation = goallocation;
    
    if ( target )
    {
        if ( isent( target ) )
        {
            enemylocation = target.origin;
        }
        else
        {
            enemylocation = target;
        }
    }
    
    if ( dronedata.bundle.var_415a7eb88487b2f6 )
    {
        goallocation = enemylocation;
    }
    
    toenemy = enemylocation - goallocation;
    toenemydir = ( 0, 0, 0 );
    
    if ( length2d( toenemy ) > 0.01 )
    {
        toenemydir = vectornormalize2( toenemy );
    }
    
    splinepoints = self findsplinepath( startlocation, goallocation, var_6ba7397cdf0f5a11, preferredradius, 2, vehicleforward, toenemydir, lookaheadoffset, lookaheadscalar, 0, ignoretraversals, var_9bf7404017a1db9b, 0, 1 );
    
    /#
        if ( splinepoints && debugdraw )
        {
            thread vehicle_roads::function_2b723e6a5a86a006( splinepoints, var_9bf7404017a1db9b ? ( 1, 1, 1 ) : ( 1, 0, 0 ) );
        }
    #/
    
    thread vehicle_roads::watch_stuck();
    thread vehicle_roads::watch_interrupt();
    return splinepoints;
}

// Namespace pathing_drone
// Params 2
// Checksum 0xd961fa99, Offset: 0x2e1a
// Size: 0x1f9
function function_a0e63053d32cb546( target, dronedata )
{
    dronedata endon( #"hash_bb263c881ca88aff" );
    self endon( #"hash_b92e95aeb973e43c" );
    self endon( #"death" );
    
    if ( isent( target ) )
    {
        target endon( #"death_or_disconnect" );
    }
    
    lostime = getdvarfloat( @"hash_f8baba21409d6e44", 1 );
    brakedist = level.pathingdrones[ dronedata.drone_ref ].goal_radius ?? getdvarint( @"hash_450a64c213d21839", 100 );
    brakedistsq = brakedist * brakedist;
    
    if ( !self.lostimer )
    {
        self.lostimer = 0;
    }
    
    if ( self.currenttarget != target )
    {
        self.lostimer = 0;
    }
    
    while ( true )
    {
        visibilitypos = self.var_84c118df363d5d65.destination + ( 0, 0, level.pathingdrones[ dronedata.drone_ref ].heightoffset );
        isvisible = function_ecff7f571478e9d0( target, visibilitypos );
        shouldbrake = distancesquared( self.origin, self.var_84c118df363d5d65.destination ) <= brakedistsq;
        
        if ( shouldbrake && isvisible )
        {
            self function_eb88c4e66edbc855( "p2p", "stopAtGoal", 1 );
            self function_eb88c4e66edbc855( "p2p", "aimAtGoal", 1 );
            
            if ( isent( target ) )
            {
                self function_eb88c4e66edbc855( "p2p", "lookAtEntityNum", target getentitynumber() );
            }
        }
        else
        {
            self function_eb88c4e66edbc855( "p2p", "stopAtGoal", 0 );
            self function_eb88c4e66edbc855( "p2p", "aimAtGoal", 0 );
            self function_eb88c4e66edbc855( "p2p", "lookAtEntityNum", -1 );
        }
        
        waitframe();
    }
}

