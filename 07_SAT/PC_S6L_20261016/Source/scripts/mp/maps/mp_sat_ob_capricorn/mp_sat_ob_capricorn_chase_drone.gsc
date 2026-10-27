// scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_chase_drone.gsc  (hash_2778152319859361.gscc) (size: 3788 Bytes / 0xecc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6f773b5f (1870084959)
// size ...... 3788 (0xecc)
// includes .. 1   (offset: 0xcf4)
// strings ... 30  (offset: 0xcfc)
// dev strs .. 0   (offset: 0xecc)
// exports ... 9   (offset: 0x8e8)
// cseg ...... 0x318 + 0x5d0 (0x8e8)
// imports ... 20  (offset: 0xa50)
// animtree1 . 0   (offset: 0xecc)
// animtree2 . 0   (offset: 0xecc)
#using scripts\common\vehicle_ai;

#namespace mp_sat_ob_capricorn_chase_drone;

// Namespace mp_sat_ob_capricorn_chase_drone
// Params 0
// Checksum 0x8be8aa24, Offset: 0x336
// Size: 0x23
function init()
{
    level.var_3d9fc7aa7b25b565.dronebundle = getscriptbundle( %"hash_507504286cbeef87" );
}

// Namespace mp_sat_ob_capricorn_chase_drone
// Params 1
// Checksum 0xf771dbb3, Offset: 0x361
// Size: 0xb0
function spawn_drone( struct )
{
    drone = spawnvehicle( "veh_sat_mil_air_drone_launcher_quad_capricorn", "script_vehicle", level.var_3d9fc7aa7b25b565.dronebundle.var_18f6603527072ff1, struct.origin, struct.angles ?? ( 0, 0, 0 ) );
    drone forcenetfieldhighlod( 1 );
    drone setscriptablepartstate( #"breacher_setup", #"on" );
    drone setscriptablepartstate( #"capricorn_idle", #"on" );
    drone thread function_c9ae207b56b3968( struct );
    return drone;
}

// Namespace mp_sat_ob_capricorn_chase_drone
// Params 0
// Checksum 0xc16cd39e, Offset: 0x41a
// Size: 0x1f7
function setup_pathing_component()
{
    drone = self;
    drone vehicle_ai::function_c439ae025b2bf434();
    drone addcomponent( "path" );
    drone function_eb88c4e66edbc855( "p2p", "checkStuck", 1 );
    drone function_eb88c4e66edbc855( "p2p", "stuckDistanceThreshold", 10 );
    drone function_eb88c4e66edbc855( "p2p", "automaticFast", 0 );
    drone function_eb88c4e66edbc855( "p2p", "goalThreshold", 4 );
    drone function_eb88c4e66edbc855( "p2p", "goalThresholdMin", 2 );
    drone function_eb88c4e66edbc855( "p2p", "throttleSpeedThreshold", 2 );
    drone function_eb88c4e66edbc855( "p2p", "automaticFastTopspeedFraction", 1 );
    drone function_eb88c4e66edbc855( "p2p", "steeringMultiplier", 1 );
    drone function_eb88c4e66edbc855( "p2p", "throttleSpeedFarBelow", 1 );
    drone function_eb88c4e66edbc855( "p2p", "throttleSpeedFarAbove", 4 );
    drone function_eb88c4e66edbc855( "p2p", "throttleSpeedClose", 2 );
    drone function_eb88c4e66edbc855( "p2p", "vtol3DGoalAngleAlignmentEnable", 1 );
    drone function_eb88c4e66edbc855( "p2p", "vtol3DGoalAngleAlignmentInfluenceRange", 40 );
    drone function_eb88c4e66edbc855( "p2p", "vtol3DStrafeInputEnable", 1 );
    drone function_eb88c4e66edbc855( "p2p", "vtol3DStrafeInputSlowDownDistance", 2 );
    drone function_eb88c4e66edbc855( "p2p", "vtol3DReachGoalHeightEnable", 1 );
    drone function_eb88c4e66edbc855( "p2p", "vtol3DReachGoalHeightThreshold", 2 );
    drone function_eb88c4e66edbc855( "path", "advanceOnStart", 1 );
    drone function_eb88c4e66edbc855( "path", "radiusToStep", 125 );
    drone function_eb88c4e66edbc855( "path", "warpOnStart", 0 );
    drone function_eb88c4e66edbc855( "path", "useManualSpeed", 1 );
    drone function_eb88c4e66edbc855( "path", "navSplineUseDroneStepMethod", 1 );
    drone function_eb88c4e66edbc855( "path", "stepSpeedFactor", 0 );
    drone function_eb88c4e66edbc855( "path", "stepProximityFactor", 0 );
}

// Namespace mp_sat_ob_capricorn_chase_drone
// Params 1
// Checksum 0xfd4bfe0d, Offset: 0x619
// Size: 0x74
function function_c9ae207b56b3968( struct )
{
    self endon( #"hunt_started" );
    self endon( #"death" );
    drone = self;
    drone setup_pathing_component();
    drone thread function_7a7fa4f5b2a2cd38();
    
    while ( isdefined( drone ) )
    {
        self function_eb88c4e66edbc855( "p2p", "goalPoint", struct.origin );
        self waittill( #"near_goal" );
    }
}

// Namespace mp_sat_ob_capricorn_chase_drone
// Params 0
// Checksum 0x9b2e5dbc, Offset: 0x695
// Size: 0xdd
function function_f8f3b3e5a09e898()
{
    self notify( #"hunt_started" );
    self endon( #"death" );
    drone = self;
    truck = level.var_3d9fc7aa7b25b565.truck;
    drone thread check_for_explosion();
    truckforward = vectornormalize2( anglestoforward( truck.angles ) );
    predictedpos = getclosestpointonnavmesh( truck.origin + truckforward * 350 ) + ( 0, 0, 60 );
    self function_eb88c4e66edbc855( "p2p", "goalPoint", predictedpos );
    fakestruct = spawnstruct();
    fakestruct.origin = predictedpos;
    drone waittill( #"near_goal" );
    drone thread explode();
}

// Namespace mp_sat_ob_capricorn_chase_drone
// Params 0
// Checksum 0x2b8f6361, Offset: 0x77a
// Size: 0x8c
function function_7a7fa4f5b2a2cd38()
{
    self endon( #"death" );
    level.var_3d9fc7aa7b25b565.truck endon( #"death" );
    drone = self;
    
    while ( isdefined( drone ) )
    {
        dist = distance( level.var_3d9fc7aa7b25b565.truck.origin, drone.origin );
        
        if ( dist < 2000 )
        {
            drone thread function_f8f3b3e5a09e898();
            return;
        }
        
        waitframe();
    }
}

// Namespace mp_sat_ob_capricorn_chase_drone
// Params 0
// Checksum 0xe3892d88, Offset: 0x80e
// Size: 0x6c
function check_for_explosion()
{
    self endon( #"death" );
    drone = self;
    
    while ( isdefined( drone ) )
    {
        dist = distance( level.var_3d9fc7aa7b25b565.truck.origin, self.origin );
        
        if ( dist < 300 )
        {
            drone thread explode();
            return;
        }
        
        waitframe();
    }
}

// Namespace mp_sat_ob_capricorn_chase_drone
// Params 0
// Checksum 0xabd622fe, Offset: 0x882
// Size: 0x66
function explode()
{
    self notify( #"death" );
    drone = self;
    drone radiusdamage( drone.origin, 350, 100, 100, undefined, "MOD_EXPLOSIVE" );
    drone setscriptablepartstate( #"explode", #"on" );
    wait 0.1;
    
    if ( isdefined( drone ) )
    {
        drone delete();
    }
}

