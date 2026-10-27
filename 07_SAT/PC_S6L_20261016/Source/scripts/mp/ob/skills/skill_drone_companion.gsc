// scripts\mp\ob\skills\skill_drone_companion.gsc  (hash_78be558e352d46ea.gscc) (size: 19910 Bytes / 0x4dc6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x33484b89 (860375945)
// size ...... 19910 (0x4dc6)
// includes .. 16  (offset: 0x47fa)
// strings ... 53  (offset: 0x487a)
// dev strs .. 48  (offset: 0x4b86)
// exports ... 44  (offset: 0x2d62)
// cseg ...... 0x457 + 0x290b (0x2d62)
// imports ... 160 (offset: 0x3442)
// animtree1 . 0   (offset: 0x4dc6)
// animtree2 . 0   (offset: 0x4dc6)
#using script_2fe74ee229c972c3;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_roads;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\damage;
#using scripts\mp\ob\systems\ob_flying_drone;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\sentientpoolmanager;

#namespace skill_drone_companion;

// Namespace skill_drone_companion
// Params 0, eflags: 0x1
// Checksum 0x36f2f431, Offset: 0x475
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"drone_companion", &init );
}

// Namespace skill_drone_companion
// Params 0
// Checksum 0xb61a8069, Offset: 0x494
// Size: 0x8f
function init()
{
    utility::registersharedfunc( #"drone_companion", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    utility::registersharedfunc( #"drone_companion", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"drone_companion", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    utility::registersharedfunc( #"drone_companion", #"hash_8698c290a2e85469", &get_skill_weapons );
    callback::add( #"on_ai_killed", &function_8c5e06ee1e60aeb7 );
}

// Namespace skill_drone_companion
// Params 1, eflags: 0x4
// Checksum 0x56506b89, Offset: 0x52b
// Size: 0x5e
function private function_1321989bae991e4f( skill_bundle )
{
    if ( skill_bundle.var_9f2c1496d319bef7 )
    {
        skill_bundle.var_e5fa38064edcaa07 = skill_bundle.var_9f2c1496d319bef7 * 1000;
    }
    
    if ( skill_bundle.var_bfe893e5cbc72ceb )
    {
        skill_bundle.var_854e6a42d4364673 = skill_bundle.var_bfe893e5cbc72ceb * 1000;
    }
}

// Namespace skill_drone_companion
// Params 1, eflags: 0x4
// Checksum 0x30643ce, Offset: 0x591
// Size: 0x4bc, Type: bool
function private on_give_skill( skill_bundle )
{
    assert( skill_bundle.var_e3a33a48e9428509, "<dev string:x24>" );
    assert( skill_bundle.var_56b4fe85aff71e97, "<dev string:x58>" );
    assert( skill_bundle.var_dd9e21cac2fe18d3, "<dev string:x8f>" );
    assert( skill_bundle.var_2a9d98d1449ebe10, "<dev string:xc4>" );
    assert( skill_bundle.var_bfaad1d177706108, "<dev string:xfa>" );
    assert( skill_bundle.var_e5053155f53071f8, "<dev string:x12e>" );
    assert( skill_bundle.var_dac9bca6f181ec91, "<dev string:x176>" );
    assert( skill_bundle.var_c35cfcb60885743e, "<dev string:x1bc>" );
    assert( skill_bundle.var_717add2864ffb021, "<dev string:x1f0>" );
    assert( skill_bundle.var_6d23ca33df9082ac, "<dev string:x229>" );
    assert( skill_bundle.var_7da5af163ee74928, "<dev string:x25a>" );
    assert( skill_bundle.var_272a663c7a820a95, "<dev string:x28d>" );
    assert( skill_bundle.var_affbf8d02162a105, "<dev string:x2c6>" );
    assert( skill_bundle.var_a56db147d4a00501, "<dev string:x2ff>" );
    assert( skill_bundle.var_9b46cad3b4e86bf0, "<dev string:x33b>" );
    assert( skill_bundle.var_610fd1e6d75f95e0, "<dev string:x379>" );
    assert( skill_bundle.var_35370ebf0aa354f9, "<dev string:x3ba>" );
    assert( skill_bundle.var_a19009c12b6693f8, "<dev string:x3fb>" );
    assert( skill_bundle.var_483879bbd76fcbcb, "<dev string:x431>" );
    assert( skill_bundle.var_9b70776f091b2dd8, "<dev string:x467>" );
    assert( skill_bundle.var_535d0f2cedae5095, "<dev string:x49a>" );
    assert( skill_bundle.var_f4b9502716dc6cdb, "<dev string:x4d5>" );
    assert( skill_bundle.var_f4eb1a6d4f54c45b, "<dev string:x513>" );
    assert( skill_bundle.var_29e0d75cb1e81d03, "<dev string:x551>" );
    assert( skill_bundle.var_1649c58c8ac04535, "<dev string:x58d>" );
    assert( skill_bundle.var_9b414d1200306b42, "<dev string:x5c4>" );
    assert( skill_bundle.var_e5fa38064edcaa07, "<dev string:x600>" );
    assert( skill_bundle.var_854e6a42d4364673, "<dev string:x63e>" );
    assert( skill_bundle.var_166ed755fce4a9e8, "<dev string:x674>" );
    assert( skill_bundle.var_9cfa43646b6e25fb, "<dev string:x6af>" );
    assert( skill_bundle.var_f419a85f98a488ed, "<dev string:x6ee>" );
    assert( skill_bundle.var_c8a556a588250e45, "<dev string:x72a>" );
    assert( skill_bundle.var_9ef0ba4b578d416b, "<dev string:x76e>" );
    assert( skill_bundle.var_51524d6eb8c2f483, "<dev string:x7b0>" );
    assert( skill_bundle.var_d53f8f48b1beb402, "<dev string:x7eb>" );
    assert( skill_bundle.var_5f889be4e54da2cf, "<dev string:x82a>" );
    assert( skill_bundle.var_89fe55f45a242f06, "<dev string:x869>" );
    assert( skill_bundle.var_fbe614c0ffad5a64, "<dev string:x8ac>" );
    assert( skill_bundle.var_ae6747c960b78a7f, "<dev string:x8ec>" );
    assert( skill_bundle.var_f2a301fbb057f7e1, "<dev string:x930>" );
    assert( skill_bundle.var_9e69f5ff04932bda, "<dev string:x96a>" );
    assert( skill_bundle.var_9986e5c8ac206511, "<dev string:x9aa>" );
    
    /#
        if ( skill_bundle.var_be811cda862af307 )
        {
            assert( skill_bundle.var_eb8ff29ee313f7a1, "<dev string:x9ee>" );
            assert( skill_bundle.var_a355fc7afb8aa8da, "<dev string:xa25>" );
        }
    #/
    
    self.var_589b85476f3adda3 = { #var_38ab74b0227b60d6:[], #var_fbde591a2641e256:0, #companiondrone:undefined, #bundle:skill_bundle };
    
    if ( !callback::exists( #"hash_2346898712859996", &function_613b69355f0a964 ) )
    {
        callback::add( #"hash_2346898712859996", &function_613b69355f0a964 );
    }
    
    /#
        if ( getdvarint( @"scr_skill_drone_companion_debug", 0 ) )
        {
            thread function_35dbec12ee857763( skill_bundle );
        }
    #/
    
    return true;
}

// Namespace skill_drone_companion
// Params 1, eflags: 0x4
// Checksum 0xf87db34, Offset: 0xa56
// Size: 0x1d1
function private function_8c5e06ee1e60aeb7( params )
{
    attacker = params.eattacker;
    var_da55798eb12048a0 = attacker.var_589b85476f3adda3;
    
    if ( !var_da55798eb12048a0 || var_da55798eb12048a0.companiondrone )
    {
        return;
    }
    
    bundle = var_da55798eb12048a0.bundle;
    current_time = gettime();
    is_in_cooldown = current_time < var_da55798eb12048a0.var_fbde591a2641e256 + bundle.var_854e6a42d4364673;
    
    if ( var_da55798eb12048a0.var_fbde591a2641e256 && is_in_cooldown )
    {
        return;
    }
    
    if ( bundle.var_4ce3646937d5ca43 && attacker function_b44b73fa6251ea51( params ) )
    {
        return;
    }
    
    var_da55798eb12048a0.var_38ab74b0227b60d6[ var_da55798eb12048a0.var_38ab74b0227b60d6.size ] = current_time;
    
    if ( bundle.var_e5fa38064edcaa07 )
    {
        var_d30e5c3d1ae57c0d = current_time - bundle.var_e5fa38064edcaa07;
        var_d6c77036808a7aa = [];
        
        foreach ( timestamp in var_da55798eb12048a0.var_38ab74b0227b60d6 )
        {
            if ( timestamp >= var_d30e5c3d1ae57c0d )
            {
                var_d6c77036808a7aa[ var_d6c77036808a7aa.size ] = timestamp;
            }
        }
        
        var_da55798eb12048a0.var_38ab74b0227b60d6 = var_d6c77036808a7aa;
    }
    
    if ( var_da55798eb12048a0.var_38ab74b0227b60d6.size >= bundle.var_9b414d1200306b42 )
    {
        attacker spawn_drone_companion( var_da55798eb12048a0, bundle );
        var_da55798eb12048a0.var_38ab74b0227b60d6 = [];
    }
}

/#

    // Namespace skill_drone_companion
    // Params 1, eflags: 0x4
    // Checksum 0x42275a79, Offset: 0xc2f
    // Size: 0xa0, Type: dev
    function private function_35dbec12ee857763( bundle )
    {
        self endon( #"death_or_disconnect", #"end_drone_companion" );
        var_da55798eb12048a0 = self.var_589b85476f3adda3;
        
        while ( true )
        {
            var_7a45497f61c23f35 = 0;
            
            if ( var_da55798eb12048a0.var_fbde591a2641e256 )
            {
                var_f3fc960cfe1a56c6 = gettime() - var_da55798eb12048a0.var_fbde591a2641e256;
                var_7a45497f61c23f35 = max( 0, bundle.var_854e6a42d4364673 - var_f3fc960cfe1a56c6 );
            }
            
            self iprintlnbold( "<dev string:xa62>" + var_7a45497f61c23f35 * 0.001 );
            wait 1;
        }
    }

#/

// Namespace skill_drone_companion
// Params 1, eflags: 0x4
// Checksum 0x89670505, Offset: 0xcd7
// Size: 0x7b
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self notify( #"end_drone_companion" );
    drone = self.var_589b85476f3adda3.companiondrone;
    
    if ( drone )
    {
        drone thread explode_drone();
    }
    
    if ( callback::exists( #"hash_2346898712859996", &function_613b69355f0a964 ) )
    {
        callback::remove( #"hash_2346898712859996", &function_613b69355f0a964 );
    }
    
    self.var_589b85476f3adda3 = undefined;
}

// Namespace skill_drone_companion
// Params 1, eflags: 0x4
// Checksum 0x67fbf7ab, Offset: 0xd5a
// Size: 0xc9
function private function_613b69355f0a964( params )
{
    inflictor = params.einflictor;
    victim = params.victim;
    
    if ( !inflictor || !isplayer( victim ) || !player_utility::isfriendly( inflictor.team, victim ) )
    {
        return;
    }
    
    companion_drone = self.var_589b85476f3adda3.companiondrone;
    companion_turret = companion_drone.turret;
    var_ad676164a532aab0 = inflictor.targetname == "skill_drone_companion" || inflictor == companion_turret;
    
    if ( var_ad676164a532aab0 )
    {
        params.idamage = 0;
    }
}

// Namespace skill_drone_companion
// Params 2, eflags: 0x4
// Checksum 0x9655a12f, Offset: 0xe2b
// Size: 0x123
function private spawn_drone_companion( var_da55798eb12048a0, bundle )
{
    spawn_origin = function_7dcd5a9f676027b( bundle );
    
    if ( !spawn_origin )
    {
        return;
    }
    
    spawn_data = { #modelname:bundle.var_dd9e21cac2fe18d3, #vehicletype:bundle.var_56b4fe85aff71e97, #targetname:"skill_drone_companion", #angles:( 0, self getplayerangles()[ 1 ], 0 ), #origin:spawn_origin };
    fail_data = {};
    drone_companion = vehicle_tracking::spawn_vehicle( spawn_data, fail_data );
    
    if ( !drone_companion )
    {
        assert( drone_companion, "<dev string:xa7f>" );
        return;
    }
    
    setup_drone_companion( drone_companion, var_da55798eb12048a0, bundle );
    drone_companion setscriptablepartstate( bundle.var_51524d6eb8c2f483, bundle.var_d53f8f48b1beb402, 0 );
    drone_companion setscriptablepartstate( bundle.var_166ed755fce4a9e8, bundle.var_9cfa43646b6e25fb, 0 );
    var_da55798eb12048a0.companiondrone = drone_companion;
    thread function_c6e2f0303763f3f5( drone_companion, bundle );
}

// Namespace skill_drone_companion
// Params 1, eflags: 0x4
// Checksum 0x9d88612a, Offset: 0xf56
// Size: 0x13b
function private function_7dcd5a9f676027b( bundle )
{
    player_pos = self.origin;
    forward_vector = anglestoforward( self getplayerangles() );
    trace_start = self geteye();
    current_angle = bundle.var_6d23ca33df9082ac;
    angle_increment = 20;
    var_4d020ff6a53caedb = 4;
    
    for ( i = 0; i < var_4d020ff6a53caedb ; i++ )
    {
        spawn_angles = ( 0, current_angle, 0 );
        rotated_vector = rotatevector( forward_vector, spawn_angles * -1 );
        candidate_pos = player_pos + vectornormalize( rotated_vector ) * bundle.var_c35cfcb60885743e + ( 0, 0, bundle.var_717add2864ffb021 );
        result = trace::ray_trace( trace_start, candidate_pos, self, undefined, 0, 0, 0, undefined, self.team );
        
        if ( result[ "fraction" ] > 0.9 )
        {
            return candidate_pos;
        }
        else
        {
            /#
                debugstar( result[ "<dev string:xaa7>" ], ( 1, 0, 0 ), 100, "<dev string:xab0>" );
            #/
        }
        
        current_angle += angle_increment;
    }
}

// Namespace skill_drone_companion
// Params 3, eflags: 0x4
// Checksum 0x26608e89, Offset: 0x109a
// Size: 0x182
function private setup_drone_companion( drone, var_da55798eb12048a0, bundle )
{
    drone.targetname = "skill_drone_companion";
    drone.owner = self;
    drone.team = self.team;
    drone setotherent( self );
    drone setvehicleteam( self.team );
    vehicle_occupancy::register_instance( drone );
    drone vehicle_damage::set_can_damage( 1 );
    drone enableaimassist();
    drone enableplayermarks( #"air_killstreak" );
    
    if ( level.teambased )
    {
        drone filteroutplayermarks( self.team );
    }
    else
    {
        drone filteroutplayermarks( self );
    }
    
    drone sentientpoolmanager::registersentient( "Drone", self );
    drone function_ebe1c45c9667070b( self );
    drone thread damage::monitordamage( drone.maxhealth, "hitequip", &function_631adee9b13ab24e, &function_55f7469d9cc19fbb, 0, undefined, undefined, 0 );
    drone setup_companion_pathing( bundle );
    function_b5c9c37cd08d88a7( drone, bundle );
    function_a56384645868237a( drone, bundle );
    create_squad_objective( drone, bundle );
    drone thread turret_attack_loop( self, bundle );
    drone thread navigate( self, bundle );
    drone thread function_b290501e20b2596b();
    drone thread vehicle_roads::watch_stuck();
    drone thread vehicle_roads::watch_interrupt();
    drone thread function_6830ce310fe742ff();
    drone thread monitor_detach( self, bundle );
    drone.var_7316d111af7090c5 = 1;
    vehicle_tracking::register_instance( drone );
}

// Namespace skill_drone_companion
// Params 1, eflags: 0x4
// Checksum 0x22d9958, Offset: 0x1224
// Size: 0x2c2
function private setup_companion_pathing( bundle )
{
    if ( !self hascomponent( "p2p" ) )
    {
        self addcomponent( "p2p" );
    }
    
    if ( !self hascomponent( "path" ) )
    {
        self addcomponent( "path" );
    }
    
    height_offset = bundle.var_9b70776f091b2dd8;
    speed_mph = self vehicle_gettopspeedforward( 1 );
    self vehicle_setspeed( speed_mph );
    self function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( speed_mph ) );
    self function_eb88c4e66edbc855( "p2p", "checkStuck", 1 );
    self function_eb88c4e66edbc855( "p2p", "stuckDistanceThreshold", 5 );
    self function_eb88c4e66edbc855( "p2p", "automaticFast", 0 );
    self function_eb88c4e66edbc855( "p2p", "goalThreshold", 30 );
    self function_eb88c4e66edbc855( "p2p", "throttleSpeedThreshold", 2 );
    self function_eb88c4e66edbc855( "p2p", "automaticFastTopspeedFraction", 1 );
    self function_eb88c4e66edbc855( "p2p", "steeringMultiplier", 1 );
    self function_eb88c4e66edbc855( "p2p", "throttleSpeedFarBelow", 1 );
    self function_eb88c4e66edbc855( "p2p", "throttleSpeedFarAbove", 4 );
    self function_eb88c4e66edbc855( "p2p", "throttleSpeedClose", 2 );
    self function_eb88c4e66edbc855( "p2p", "vtol3DGoalAngleAlignmentEnable", 1 );
    self function_eb88c4e66edbc855( "p2p", "vtol3DGoalAngleAlignmentInfluenceRange", 40 );
    self function_eb88c4e66edbc855( "p2p", "vtol3DStrafeInputEnable", 1 );
    self function_eb88c4e66edbc855( "p2p", "vtol3DStrafeInputSlowDownDistance", 2 );
    self function_eb88c4e66edbc855( "p2p", "vtol3DReachGoalHeightEnable", 1 );
    self function_eb88c4e66edbc855( "p2p", "vtol3DReachGoalHeightThreshold", 2 );
    self function_eb88c4e66edbc855( "path", "advanceOnStart", 1 );
    self function_eb88c4e66edbc855( "path", "navSplinePathHeightOffset", height_offset );
    self function_eb88c4e66edbc855( "path", "radiusToStep", 125 );
    self function_eb88c4e66edbc855( "path", "warpOnStart", 1 );
    self function_eb88c4e66edbc855( "path", "useManualSpeed", 1 );
    self function_eb88c4e66edbc855( "path", "navSplineUseDroneStepMethod", 1 );
    self function_eb88c4e66edbc855( "path", "stepSpeedFactor", 0 );
    self function_eb88c4e66edbc855( "path", "stepProximityFactor", 0 );
    forward_dir = anglestoforward( self.owner getplayerangles() );
    initial_dest = getclosestpointonnavmesh( self.owner.origin + forward_dir * bundle.var_535d0f2cedae5095 );
    
    if ( !isdefined( initial_dest ) )
    {
        initial_dest = getclosestpointonnavmesh( self.owner.origin );
    }
    
    if ( initial_dest )
    {
        self.destination = initial_dest;
        function_2a6572d7207259d5();
    }
}

// Namespace skill_drone_companion
// Params 2, eflags: 0x4
// Checksum 0x68c1dc52, Offset: 0x14ee
// Size: 0x102
function private function_b5c9c37cd08d88a7( drone, bundle )
{
    turret = spawnturret( "misc_turret", drone.origin, bundle.var_7da5af163ee74928 );
    turret setmodel( bundle.var_272a663c7a820a95 );
    turret.angles = drone.angles;
    turret linkto( drone );
    turret turretfireenable();
    turret setdefaultdroppitch( 0 );
    turret setmode( "manual" );
    turret setnodeploy( 1 );
    turret maketurretinoperable();
    turret setusableenabled( 0 );
    turret setturretteam( self.team );
    turret.team = self.team;
    turret setturretowner( self );
    turret setotherent( self );
    turret.owner = self;
    turret.var_7ee4a7c2b172b5a7 = 1;
    drone.turret = turret;
}

// Namespace skill_drone_companion
// Params 2, eflags: 0x4
// Checksum 0x1ba695c, Offset: 0x15f8
// Size: 0x105
function private turret_attack_loop( owner, bundle )
{
    self endon( #"death" );
    owner endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    waitframe();
    self.turret laseroff();
    
    while ( true )
    {
        target = turret_find_target( bundle.var_affbf8d02162a105 );
        
        if ( target )
        {
            turret_fire( target, bundle.var_9b46cad3b4e86bf0, bundle.var_610fd1e6d75f95e0, bundle );
            self setscriptablepartstate( bundle.var_f419a85f98a488ed, bundle.var_c8a556a588250e45, 0 );
            wait bundle.var_a56db147d4a00501;
            continue;
        }
        
        self.turret cleartargetentity();
        self.turret laseroff();
        self setscriptablepartstate( bundle.var_f419a85f98a488ed, bundle.var_9ef0ba4b578d416b, 0 );
        wait bundle.var_35370ebf0aa354f9;
    }
}

// Namespace skill_drone_companion
// Params 1, eflags: 0x4
// Checksum 0x5b032a5e, Offset: 0x1705
// Size: 0x131
function private turret_find_target( var_a7c29cfa649167e0 )
{
    var_fdc5e4472f1e2a76 = get_enemies_in_radius( var_a7c29cfa649167e0 );
    closest_target = undefined;
    closest_dist_sq = var_a7c29cfa649167e0 * var_a7c29cfa649167e0;
    
    foreach ( ai in var_fdc5e4472f1e2a76 )
    {
        dist_sq = distancesquared( self.origin, ai.origin );
        
        if ( dist_sq >= closest_dist_sq )
        {
            continue;
        }
        
        target_pos = ai geteye() ?? ai.origin;
        ray_result = trace::ray_trace_passed( self.origin, target_pos, [ self, self.turret, ai ] );
        
        if ( !ray_result )
        {
            continue;
        }
        
        closest_target = ai;
        closest_dist_sq = dist_sq;
    }
    
    return closest_target;
}

// Namespace skill_drone_companion
// Params 1, eflags: 0x4
// Checksum 0xd0106094, Offset: 0x183f
// Size: 0xcb
function private get_enemies_in_radius( radius )
{
    var_fdc5e4472f1e2a76 = getaiarrayinradius( self.origin, radius );
    var_4181133b64550dd7 = [];
    
    foreach ( ai in var_fdc5e4472f1e2a76 )
    {
        if ( ai.team == self.team )
        {
            continue;
        }
        
        if ( ai ai::get_ignoreme() )
        {
            continue;
        }
        
        var_4181133b64550dd7[ var_4181133b64550dd7.size ] = ai;
    }
    
    return var_4181133b64550dd7;
}

// Namespace skill_drone_companion
// Params 4, eflags: 0x4
// Checksum 0x34eeab50, Offset: 0x1913
// Size: 0x118
function private turret_fire( target, rounds, var_d997b48e53abf122, bundle )
{
    self endon( #"death" );
    self.turret endon( #"death", #"entitydeleted" );
    
    if ( !self.turret )
    {
        return;
    }
    
    self.turret laseron();
    
    for ( i = 0; i < rounds ; i++ )
    {
        if ( !isalive( target ) )
        {
            self.turret cleartargetentity();
            self.turret laseroff();
            break;
        }
        
        target_loc = target gettagorigin( "j_spine4", 1 ) ?? target.origin;
        height_offset = target_loc - target.origin;
        self.turret snaptotargetentity( target, height_offset );
        function_2455aed2ef78af6d( target, bundle );
        self.turret shootturret();
        wait var_d997b48e53abf122;
    }
}

// Namespace skill_drone_companion
// Params 2, eflags: 0x4
// Checksum 0xa61d127a, Offset: 0x1a33
// Size: 0x1fe
function private function_2455aed2ef78af6d( target, bundle )
{
    if ( !isalive( target ) )
    {
        return;
    }
    
    if ( !bundle.var_be811cda862af307 )
    {
        return;
    }
    
    if ( !utility::issharedfuncdefined( #"skills", #"hash_79530ea7319d30d6" ) )
    {
        return;
    }
    
    owner = self.owner;
    var_7bf66648a3f62aa9 = { #skill_name:#"drone_companion", #cooldown:bundle.var_eb8ff29ee313f7a1, #var_3b55b60765b98d29:[], #weights_table:bundle.var_cf30bdd7c98de8d3 ?? [], #objweapon:self.turret function_aa407dc4c571d4a4(), #partname:"", #modelindex:0, #timeoffset:0, #shitloc:"", #vdir:( 0, 0, 0 ), #vpoint:target.origin, #idflags:0, #idamage:0, #inflictor:owner, #probability:bundle.var_be811cda862af307, #player:owner };
    var_c04e417f8531bdb5 = bundle.var_a355fc7afb8aa8da;
    
    if ( var_c04e417f8531bdb5 >= 1 )
    {
        var_7bf66648a3f62aa9.var_3b55b60765b98d29[ var_7bf66648a3f62aa9.var_3b55b60765b98d29.size ] = 1;
    }
    
    if ( var_c04e417f8531bdb5 >= 2 )
    {
        var_7bf66648a3f62aa9.var_3b55b60765b98d29[ var_7bf66648a3f62aa9.var_3b55b60765b98d29.size ] = 2;
    }
    
    if ( var_c04e417f8531bdb5 >= 3 )
    {
        var_7bf66648a3f62aa9.var_3b55b60765b98d29[ var_7bf66648a3f62aa9.var_3b55b60765b98d29.size ] = 3;
    }
    
    target utility::callsharedfunc( #"skills", #"hash_79530ea7319d30d6", var_7bf66648a3f62aa9 );
}

// Namespace skill_drone_companion
// Params 2, eflags: 0x4
// Checksum 0x2ac3027a, Offset: 0x1c39
// Size: 0x61
function private monitor_detach( owner, bundle )
{
    self endon( #"death" );
    owner endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self.is_detached = 0;
    
    while ( true )
    {
        self.is_detached = owner function_7e9517507815b29e( bundle );
        wait 1;
    }
}

// Namespace skill_drone_companion
// Params 1, eflags: 0x4
// Checksum 0xfae596e9, Offset: 0x1ca2
// Size: 0x60, Type: bool
function private function_7e9517507815b29e( bundle )
{
    if ( vehicle::is_in_vehicle() )
    {
        return true;
    }
    
    if ( !self isonground() )
    {
        ground_pos = getgroundposition( self.origin, 1 );
        
        if ( self.origin[ 2 ] - ground_pos[ 2 ] > bundle.var_2a9d98d1449ebe10 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace skill_drone_companion
// Params 2, eflags: 0x4
// Checksum 0xefb9ab13, Offset: 0x1d0b
// Size: 0x227
function private navigate( owner, bundle )
{
    self endon( #"death" );
    owner endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    smooth_yaw = owner getplayerangles()[ 1 ];
    first_path = 1;
    
    while ( true )
    {
        target_yaw = owner getplayerangles()[ 1 ];
        yaw_diff = angleclamp180( target_yaw - smooth_yaw );
        smooth_yaw = angleclamp180( smooth_yaw + yaw_diff * 0.15 );
        forward_dir = anglestoforward( ( 0, smooth_yaw, 0 ) );
        target_ground = owner function_5a47f0ed8782463e( forward_dir, bundle.var_535d0f2cedae5095, bundle.var_9b70776f091b2dd8 );
        
        if ( !target_ground )
        {
            wait bundle.var_29e0d75cb1e81d03;
            continue;
        }
        
        if ( self.is_detached )
        {
            self vehicle_setspeed( 0 );
            wait bundle.var_29e0d75cb1e81d03;
            continue;
        }
        
        distance = distance2d( self.origin, target_ground );
        
        if ( distance >= bundle.var_f4b9502716dc6cdb )
        {
            companion_teleport( owner, bundle, target_ground );
        }
        
        speed_mph = self vehicle_gettopspeedforward( 1 );
        self vehicle_setspeed( speed_mph );
        
        if ( distance > bundle.var_f4eb1a6d4f54c45b )
        {
            self.destination = target_ground;
            function_2a6572d7207259d5();
            
            if ( first_path )
            {
                self function_eb88c4e66edbc855( "path", "warpOnStart", 0 );
                first_path = 0;
            }
            
            utility::waittill_any_timeout( 5, "reached_end_node", "companion_repath" );
        }
        else
        {
            wait 2;
            drift_angle = randomfloatrange( 0, 360 );
            drift_dir = anglestoforward( ( 0, drift_angle, 0 ) );
            drift_dest = getclosestpointonnavmesh( target_ground + drift_dir * bundle.var_1649c58c8ac04535 );
            
            if ( drift_dest )
            {
                self.destination = drift_dest;
                function_2a6572d7207259d5();
                utility::waittill_any_timeout( 5, "reached_end_node", "companion_repath" );
            }
        }
        
        wait bundle.var_29e0d75cb1e81d03;
    }
}

// Namespace skill_drone_companion
// Params 3, eflags: 0x4
// Checksum 0x1ca02b23, Offset: 0x1f3a
// Size: 0x94
function private companion_teleport( owner, bundle, target_ground )
{
    companion_fade_out( bundle );
    self vehicle_setspeed( 0 );
    self.origin = target_ground + ( 0, 0, bundle.var_9b70776f091b2dd8 );
    self.angles = ( 0, vectortoyaw( owner.origin - self.origin ), 0 );
    speed_mph = self vehicle_gettopspeedforward( 1 );
    self vehicle_setspeed( speed_mph );
    wait 1;
    companion_fade_in( bundle );
}

// Namespace skill_drone_companion
// Params 3, eflags: 0x4
// Checksum 0x4fc80f22, Offset: 0x1fd6
// Size: 0x117
function private function_5a47f0ed8782463e( forward_dir, front_distance, height )
{
    right_dir = ( forward_dir[ 1 ] * -1, forward_dir[ 0 ], 0 );
    back_dir = ( forward_dir[ 0 ] * -1, forward_dir[ 1 ] * -1, 0 );
    left_dir = ( forward_dir[ 1 ], forward_dir[ 0 ] * -1, 0 );
    eye_pos = self geteye();
    offsets = [];
    offsets[ 0 ] = forward_dir * front_distance + right_dir * front_distance * 0.2;
    offsets[ 1 ] = forward_dir * front_distance;
    offsets[ 2 ] = right_dir * front_distance;
    offsets[ 3 ] = left_dir * front_distance;
    offsets[ 4 ] = back_dir * front_distance;
    
    for ( i = 0; i < offsets.size ; i++ )
    {
        var_4d7d4fdebb3384d2 = getclosestpointonnavmesh( self.origin + offsets[ i ] );
        
        if ( !var_4d7d4fdebb3384d2 )
        {
            continue;
        }
        
        if ( trace::ray_trace_passed( eye_pos, var_4d7d4fdebb3384d2 + ( 0, 0, height ), self ) )
        {
            return var_4d7d4fdebb3384d2;
        }
    }
    
    return getclosestpointonnavmesh( self.origin );
}

// Namespace skill_drone_companion
// Params 0, eflags: 0x4
// Checksum 0x2239579b, Offset: 0x20f6
// Size: 0x10b
function private function_2a6572d7207259d5()
{
    forward_vector = anglestoforward( self.angles );
    start_position = getclosestpointonnavmesh( self.origin );
    
    if ( !start_position )
    {
        return;
    }
    
    goal_position = self.destination;
    var_b0afbe385bf12ec3 = distance( start_position, goal_position );
    var_acd1d0de24cfedd6 = 50;
    
    if ( var_b0afbe385bf12ec3 < 500 )
    {
        var_acd1d0de24cfedd6 = var_b0afbe385bf12ec3 / 10;
    }
    
    spline_points = self findsplinepath( start_position, goal_position, 200, 500, var_acd1d0de24cfedd6, forward_vector, ( 0, 0, 0 ), 50, 0.25, 0, "drone", "human", 1, 1 );
    
    if ( !spline_points )
    {
        spline_points = self findsplinepath( start_position, goal_position, 200, 500, var_acd1d0de24cfedd6, forward_vector, ( 0, 0, 0 ), 50, 0.25, 1, "drone", "human", 1, 1 );
    }
    
    if ( !spline_points )
    {
        wait 0.5;
        self notify( #"companion_repath" );
        return;
    }
}

// Namespace skill_drone_companion
// Params 0, eflags: 0x4
// Checksum 0xa92a5465, Offset: 0x2209
// Size: 0xba
function private function_b290501e20b2596b()
{
    self endon( #"death" );
    self.owner endon( #"death_or_disconnect" );
    
    while ( true )
    {
        ground_pos = getclosestpointonnavmesh( self.owner.origin ) ?? self.owner.origin;
        function_32c6b72c11005722( ground_pos, 150 );
        
        if ( self.destination )
        {
            var_dd2a2d1f98740710 = vectornormalize( self.destination - ground_pos );
            lookahead_pos = getclosestpointonnavmesh( ground_pos + var_dd2a2d1f98740710 * 200 );
            
            if ( lookahead_pos )
            {
                function_32c6b72c11005722( lookahead_pos, 150 );
            }
        }
        
        waitframe();
    }
}

// Namespace skill_drone_companion
// Params 2, eflags: 0x4
// Checksum 0xb541950e, Offset: 0x22cb
// Size: 0x173
function private function_32c6b72c11005722( position, radius )
{
    entityless_doors = getentitylessscriptablearray( undefined, undefined, position, radius, "door" );
    
    foreach ( door in entityless_doors )
    {
        if ( door.origin && abs( door.origin[ 2 ] - position[ 2 ] ) > 72 )
        {
            continue;
        }
        
        if ( door.sliding_door )
        {
            door.sliding_door notify( #"trigger", self );
            continue;
        }
        
        if ( door.var_e958f5af05f687d1 )
        {
            door.var_e958f5af05f687d1 notify( #"trigger", self );
        }
    }
    
    nearest_door = function_6cf720856f2ecd74( position, radius );
    
    if ( isdefined( nearest_door ) && nearest_door isscriptableinstance() && nearest_door scriptabledoorisclosed() && !nearest_door function_4f79c45e0fd47b7f() )
    {
        if ( abs( nearest_door.origin[ 2 ] - position[ 2 ] ) <= 72 )
        {
            nearest_door scriptabledooropen( "away", position );
        }
    }
}

// Namespace skill_drone_companion
// Params 0, eflags: 0x4
// Checksum 0x555534fb, Offset: 0x2446
// Size: 0x48
function private function_6830ce310fe742ff()
{
    self endon( #"death" );
    self.owner endon( #"death_or_disconnect" );
    
    while ( true )
    {
        utility::waittill_any( "vehicleNavSplineInterrupted", "vehicleStuckNavSpline" );
        self notify( #"companion_repath" );
        waitframe();
    }
}

// Namespace skill_drone_companion
// Params 0, eflags: 0x4
// Checksum 0x1cbc1c70, Offset: 0x2496
// Size: 0x1f1
function private explode_drone()
{
    level endon( #"game_ended" );
    
    if ( self.is_being_destroyed )
    {
        return;
    }
    
    self.is_being_destroyed = 1;
    var_da55798eb12048a0 = self.owner.var_589b85476f3adda3;
    bundle = var_da55798eb12048a0.bundle;
    var_da55798eb12048a0.companiondrone = undefined;
    var_da55798eb12048a0.var_fbde591a2641e256 = gettime();
    self setcandamage( 0 );
    self notify( #"death" );
    enemy_ai = get_enemies_in_radius( bundle.var_483879bbd76fcbcb );
    
    foreach ( enemy in enemy_ai )
    {
        attacker = isalive( self.owner ) ? self.owner : self;
        enemy dodamage( bundle.var_a19009c12b6693f8, self.origin, attacker, self, "MOD_EXPLOSIVE", bundle.var_7da5af163ee74928, "torso_upper" );
    }
    
    self.var_c0b2e8ebae7fced0 = &ignore_vehicle_damage;
    self radiusdamage( self.origin, bundle.var_483879bbd76fcbcb, bundle.var_a19009c12b6693f8, 1, attacker, "MOD_MELEE", "<explicitweaponnone>", 1 );
    self.var_c0b2e8ebae7fced0 = undefined;
    self.var_7316d111af7090c5 = undefined;
    self notify( #"death" );
    self setscriptablepartstate( bundle.var_5f889be4e54da2cf, bundle.var_89fe55f45a242f06, 0 );
    wait 0.5;
    cleanup_drone();
}

// Namespace skill_drone_companion
// Params 1, eflags: 0x4
// Checksum 0x2a411110, Offset: 0x268f
// Size: 0x65, Type: bool
function private ignore_vehicle_damage( vehicle )
{
    if ( !isalive( self.owner ) )
    {
        return false;
    }
    
    if ( self.owner player_utility::function_cb195d25060312a( vehicle ) )
    {
        return true;
    }
    
    if ( self.owner player_utility::function_36e9830807a5007( vehicle ) )
    {
        return true;
    }
    
    if ( self.owner player_utility::function_452d7021e128ff08( vehicle ) )
    {
        return true;
    }
    
    return false;
}

// Namespace skill_drone_companion
// Params 1, eflags: 0x4
// Checksum 0x361485a1, Offset: 0x26fd
// Size: 0x80
function private companion_fade_out( bundle )
{
    self setscriptablepartstate( bundle.var_166ed755fce4a9e8, #"off", 0 );
    self setscriptablepartstate( bundle.var_f419a85f98a488ed, #"off", 0 );
    self setscriptablepartstate( bundle.var_fbe614c0ffad5a64, #"off", 0 );
    self setscriptablepartstate( bundle.var_9e69f5ff04932bda, #"off", 0 );
    ob_flying_drone::drone_startcamo( self );
}

// Namespace skill_drone_companion
// Params 1, eflags: 0x4
// Checksum 0x1a85b046, Offset: 0x2785
// Size: 0x4e
function private companion_fade_in( bundle )
{
    self setscriptablepartstate( bundle.var_166ed755fce4a9e8, bundle.var_9cfa43646b6e25fb, 0 );
    self setscriptablepartstate( bundle.var_f419a85f98a488ed, bundle.var_9ef0ba4b578d416b, 0 );
    ob_flying_drone::function_9022369d3fc8a419( self );
}

// Namespace skill_drone_companion
// Params 2, eflags: 0x4
// Checksum 0x9fde505e, Offset: 0x27db
// Size: 0x45
function private function_a56384645868237a( drone, bundle )
{
    drone.owner_objective = function_6ae004ca2f6fdaca( drone, 255, 255, 0, 1, bundle );
    objidpoolmanager::objective_playermask_addshowplayer( drone.owner_objective, self );
}

// Namespace skill_drone_companion
// Params 1, eflags: 0x4
// Checksum 0x5c1b3319, Offset: 0x2828
// Size: 0x1c
function private get_skill_weapons( skill_bundle )
{
    return [ skill_bundle.var_7da5af163ee74928 ];
}

// Namespace skill_drone_companion
// Params 2, eflags: 0x4
// Checksum 0xa1136467, Offset: 0x284d
// Size: 0xc5
function private create_squad_objective( drone, bundle )
{
    drone.squad_objective = function_6ae004ca2f6fdaca( drone, 0, 128, 255, 0, bundle );
    var_538c0694c880e740 = squad_utility::getsquadmembers();
    
    foreach ( member in var_538c0694c880e740 )
    {
        if ( member != self )
        {
            objidpoolmanager::objective_playermask_addshowplayer( drone.squad_objective, member );
        }
    }
}

// Namespace skill_drone_companion
// Params 6, eflags: 0x4
// Checksum 0xc5e5b5d5, Offset: 0x291a
// Size: 0x114
function private function_6ae004ca2f6fdaca( drone, tint_r, tint_g, tint_b, is_owner, bundle )
{
    objective_id = objidpoolmanager::requestobjectiveid( 0 );
    var_b862b7ade8aec0ec = is_owner ? "current" : "invisible";
    objidpoolmanager::objective_add_objective( objective_id, var_b862b7ade8aec0ec, drone.origin, bundle.var_bfaad1d177706108, "icon_regular" );
    objidpoolmanager::update_objective_setzoffset( objective_id, 20 );
    objidpoolmanager::update_objective_setbackground( objective_id, 1 );
    function_e79ad5f5fb225e7c( objective_id, is_owner );
    objidpoolmanager::objective_playermask_hidefromall( objective_id );
    objidpoolmanager::function_373aaf492aabde6f( objective_id, tint_r, tint_g, tint_b, 1 );
    objidpoolmanager::objective_showdistance( objective_id, 0 );
    objidpoolmanager::update_objective_onentity( objective_id, drone );
    objidpoolmanager::objective_set_play_intro( objective_id, is_owner );
    objidpoolmanager::function_79ca076cf9eccbd9( objective_id, !is_owner );
    
    if ( !is_owner )
    {
        objidpoolmanager::function_de3fb937d4f45f38( objective_id, bundle.var_e5053155f53071f8, bundle.var_dac9bca6f181ec91 );
    }
    
    return objective_id;
}

// Namespace skill_drone_companion
// Params 0, eflags: 0x4
// Checksum 0x1d61d2b7, Offset: 0x2a37
// Size: 0x4e
function private cleanup_drone_objective()
{
    if ( self.owner_objective )
    {
        objidpoolmanager::returnobjectiveid( self.owner_objective );
        self.owner_objective = undefined;
    }
    
    if ( self.squad_objective )
    {
        objidpoolmanager::returnobjectiveid( self.squad_objective );
        self.squad_objective = undefined;
    }
}

// Namespace skill_drone_companion
// Params 0, eflags: 0x4
// Checksum 0x37eda886, Offset: 0x2a8d
// Size: 0x34
function private cleanup_companion_turret()
{
    if ( self.turret )
    {
        self.turret laseroff();
        self.turret delete();
        self.turret = undefined;
    }
}

// Namespace skill_drone_companion
// Params 2, eflags: 0x4
// Checksum 0x181cbd82, Offset: 0x2ac9
// Size: 0x4e
function private function_c6e2f0303763f3f5( drone, bundle )
{
    self endon( #"end_drone_companion" );
    drone endon( #"death" );
    utility::waittill_any_timeout( bundle.var_e3a33a48e9428509, "death_or_disconnect" );
    drone thread explode_drone();
}

// Namespace skill_drone_companion
// Params 1, eflags: 0x4
// Checksum 0xd35f76c2, Offset: 0x2b1f
// Size: 0xf7
function private function_55f7469d9cc19fbb( params )
{
    if ( !params.attacker )
    {
        return params.damage;
    }
    
    bundle = self.owner.var_589b85476f3adda3.bundle;
    self setscriptablepartstate( bundle.var_9e69f5ff04932bda, bundle.var_9986e5c8ac206511, 0 );
    var_ede25c242323d9c = self.damagetaken + params.damage;
    health_fraction = 1 - var_ede25c242323d9c / self.maxhealth;
    
    if ( !self.is_low_health && health_fraction <= bundle.var_f2a301fbb057f7e1 )
    {
        self.is_low_health = 1;
        self setscriptablepartstate( bundle.var_fbe614c0ffad5a64, bundle.var_ae6747c960b78a7f, 0 );
    }
    
    return params.damage;
}

// Namespace skill_drone_companion
// Params 1, eflags: 0x4
// Checksum 0xfd2e5191, Offset: 0x2c1f
// Size: 0x13
function private function_631adee9b13ab24e( damage_data )
{
    thread explode_drone();
}

// Namespace skill_drone_companion
// Params 1, eflags: 0x4
// Checksum 0xdc26d309, Offset: 0x2c3a
// Size: 0x68
function private function_ebe1c45c9667070b( owner )
{
    if ( owner.var_f6ce3f6c3c2ead86.bundle.var_1127434ea7296f8 )
    {
        self.health = owner.var_f6ce3f6c3c2ead86.bundle.var_1127434ea7296f8;
    }
    
    self.maxhealth = self.health;
}

// Namespace skill_drone_companion
// Params 0, eflags: 0x4
// Checksum 0x2610af8c, Offset: 0x2caa
// Size: 0x2f
function private cleanup_drone()
{
    cleanup_drone_objective();
    cleanup_companion_turret();
    sentientpoolmanager::unregistersentient();
    vehicle_occupancy::deregister_instance( self );
    vehicle_tracking::deregister_instance( self );
    vehicle_tracking::delete_vehicle( self );
}

// Namespace skill_drone_companion
// Params 1, eflags: 0x4
// Checksum 0xb2a3dde, Offset: 0x2ce1
// Size: 0x80, Type: bool
function private function_b44b73fa6251ea51( dmg_struct )
{
    if ( dmg_struct.smeansofdeath != "MOD_CRUSH" )
    {
        return false;
    }
    
    inflictor = dmg_struct.einflictor;
    
    if ( !inflictor || !inflictor vehicle::is_vehicle() && inflictor.classname != "script_vehicle" )
    {
        return false;
    }
    
    driver = vehicle_occupancy::get_driver( inflictor );
    
    if ( driver != self )
    {
        return false;
    }
    
    return true;
}

