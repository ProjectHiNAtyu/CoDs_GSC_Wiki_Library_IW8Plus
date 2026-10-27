// scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_chase_gdu.gsc  (hash_37a744a25af7aac9.gscc) (size: 5975 Bytes / 0x1757 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6d450a97 (1833241239)
// size ...... 5975 (0x1757)
// includes .. 11  (offset: 0x15ff)
// strings ... 19  (offset: 0x1657)
// dev strs .. 0   (offset: 0x1757)
// exports ... 20  (offset: 0xc87)
// cseg ...... 0x1f7 + 0xa90 (0xc87)
// imports ... 56  (offset: 0xfa7)
// animtree1 . 0   (offset: 0x1757)
// animtree2 . 0   (offset: 0x1757)
#using script_16ea1b94f0f381b3;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_ai;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\utility\points;
#using scripts\mp\entityheadicons;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_chase;

#namespace mp_sat_ob_capricorn_chase_gdu;

// Namespace mp_sat_ob_capricorn_chase_gdu
// Params 0
// Checksum 0xfa982692, Offset: 0x215
// Size: 0x23
function init()
{
    level.var_3d9fc7aa7b25b565.gdubundle = getscriptbundle( %"hash_268c8dddfa57ef43" );
}

// Namespace mp_sat_ob_capricorn_chase_gdu
// Params 1
// Checksum 0xeb930dc3, Offset: 0x240
// Size: 0xec
function spawn_gdu( struct )
{
    gdu = spawnvehicle( "veh_sat_mil_drone_gdu", "script_vehicle", getscriptbundle( %"hash_268c8dddfa57ef43" ).gduvehicletype, struct.origin, struct.angles ?? ( 0, 0, 0 ) );
    gdu.streakinfo = spawnstruct();
    gdu.streakinfo.streakname = "ground_drone_unit";
    vehicle_occupancy::set_team( gdu, "team_hundred_ninety" );
    gdu setscriptablepartstate( #"lights", #"on" );
    gdu setscriptablepartstate( #"alert", #"on" );
    gdu function_1ce150963f35e897();
    gdu function_9161fa2e08a9db02();
    gdu thread function_c9ae207b56b3968( struct );
    return gdu;
}

/#

    // Namespace mp_sat_ob_capricorn_chase_gdu
    // Params 0
    // Checksum 0xfa51416d, Offset: 0x335
    // Size: 0x5, Type: dev
    function function_6513d947dcf52c70()
    {
        
    }

#/

// Namespace mp_sat_ob_capricorn_chase_gdu
// Params 0
// Checksum 0xf34ded56, Offset: 0x342
// Size: 0x13c
function function_1ce150963f35e897()
{
    gdu = self;
    gdu.maxhealth = 20;
    gdu.currenthealth = 20;
    gdu vehicle_damage::set_can_damage( 1 );
    scorepopup = "destroyed_" + gdu.streakinfo.streakname;
    vodestroyed = "destroyed_" + gdu.streakinfo.streakname;
    destroyedsplash = "callout_destroyed_" + gdu.streakinfo.streakname;
    var_c96bcef6709d6df1 = &vehicle_hit_damage_override;
    var_d188942a41771ea1 = &function_699413a1967a0049;
    premoddamagecallback = &function_f40b77e4cab37b73;
    postmoddamagecallback = &function_da1cdd50d799b6f2;
    deathcallback = &handle_death_damage;
    namespace_9d8e359c3b1041e5::killstreak_setupvehicledamagefunctionalitysharedfunc( gdu.streakinfo.streakname, gdu, scorepopup, vodestroyed, destroyedsplash, var_c96bcef6709d6df1, var_d188942a41771ea1, premoddamagecallback, postmoddamagecallback, deathcallback );
    vehicle_tracking::register_instance( self, self.owner, self.owner.team );
}

// Namespace mp_sat_ob_capricorn_chase_gdu
// Params 1
// Checksum 0xf2f5d6b6, Offset: 0x486
// Size: 0xc
function vehicle_hit_damage_override( data )
{
    
}

// Namespace mp_sat_ob_capricorn_chase_gdu
// Params 1
// Checksum 0xb42fcd55, Offset: 0x49a
// Size: 0xc
function function_699413a1967a0049( data )
{
    
}

// Namespace mp_sat_ob_capricorn_chase_gdu
// Params 1
// Checksum 0x183bd266, Offset: 0x4ae
// Size: 0xa3, Type: bool
function function_f40b77e4cab37b73( data )
{
    if ( level.var_deb9d2b3de25799b )
    {
        var_2e92350940c6845e = level.sharedfuncs[ #"killstreak" ][ #"getmodifieddamageusingdamagetuning" ];
        
        if ( var_2e92350940c6845e )
        {
            data.damage = self [[ var_2e92350940c6845e ]]( data.attacker, data.objweapon, data.meansofdeath, data.damage, self.maxhealth, self.bundle.var_20cb8f4e47f3353e, data );
        }
    }
    
    return true;
}

// Namespace mp_sat_ob_capricorn_chase_gdu
// Params 1
// Checksum 0x3c688fe1, Offset: 0x55a
// Size: 0x6b, Type: bool
function function_da1cdd50d799b6f2( data )
{
    if ( data.inflictor.team == self.team )
    {
        data.damage = 0;
    }
    
    self.currenthealth -= data.damage;
    namespace_9d8e359c3b1041e5::killstreak_updatedamagestatesharedfunc( self.currenthealth );
    return true;
}

// Namespace mp_sat_ob_capricorn_chase_gdu
// Params 1
// Checksum 0x56338867, Offset: 0x5ce
// Size: 0x69, Type: bool
function handle_death_damage( data )
{
    self notify( #"death" );
    self notify( #"enemy_destroyed_equipment", data.attacker );
    vehicle_damage::set_can_damage( 0 );
    
    if ( isdefined( data.attacker ) )
    {
        data.attacker thread points::doscoreevent( #"hash_731419bf767945ec" );
    }
    
    thread explode();
    return false;
}

/#

    // Namespace mp_sat_ob_capricorn_chase_gdu
    // Params 0
    // Checksum 0xc9853c9, Offset: 0x640
    // Size: 0x5, Type: dev
    function function_8e1dc8647a911529()
    {
        
    }

#/

// Namespace mp_sat_ob_capricorn_chase_gdu
// Params 0
// Checksum 0x326cf09c, Offset: 0x64d
// Size: 0x23
function function_9161fa2e08a9db02()
{
    gdu = self;
    gdu.headiconid = entityheadicons::setheadicon_killstreak( gdu );
}

/#

    // Namespace mp_sat_ob_capricorn_chase_gdu
    // Params 0
    // Checksum 0xf0ee8a85, Offset: 0x678
    // Size: 0x5, Type: dev
    function function_571b0f15a6624e28()
    {
        
    }

#/

// Namespace mp_sat_ob_capricorn_chase_gdu
// Params 1
// Checksum 0xb95b0702, Offset: 0x685
// Size: 0xa9
function function_c9ae207b56b3968( struct )
{
    gdu = self;
    var_b9ae907c2c3b6281 = mp_sat_ob_capricorn_chase::chase_get_path_array( struct );
    gdu vehicle_ai::function_c439ae025b2bf434();
    gdu setconfigvalue( "p2p", "brakeAtGoal", 0 );
    gdu setconfigvalue( "p2p", "goalThreshold", 500 );
    gdu setconfigvalue( "p2p", "steeringMultiplier", 2 );
    gdu setconfigvalue( "p2p", "stuckTime", 4 );
    gdu thread [[ level.var_f9cd1c1793438654 ]]();
    
    if ( var_b9ae907c2c3b6281 )
    {
        gdu mp_sat_ob_capricorn_chase::chase_truck_go_to_path( var_b9ae907c2c3b6281, 150, 1, 1 );
    }
}

// Namespace mp_sat_ob_capricorn_chase_gdu
// Params 0
// Checksum 0xcb67dd4d, Offset: 0x736
// Size: 0xc7
function function_d9d4b79f80d998a2()
{
    self endon( #"death" );
    self.var_a46d3dc5e1674568 = 1;
    self setconfigvalue( "p2p", "goalThreshold", 10 );
    self vehicle_setspeed( 15 );
    childthread function_dd2505f8cb6b1510();
    
    while ( self )
    {
        near_player = utility::get_closest_player();
        
        if ( near_player )
        {
            is_facing_target = utility::within_fov( self.origin, self.angles, near_player.origin, cos( 45 ) );
            dist = distance( near_player.origin, self.origin );
            
            if ( dist < 500 && is_facing_target )
            {
                function_f8f3b3e5a09e898( near_player );
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace mp_sat_ob_capricorn_chase_gdu
// Params 0
// Checksum 0x511bebbf, Offset: 0x805
// Size: 0x35
function function_dd2505f8cb6b1510()
{
    while ( self )
    {
        players_in_radius = getplayersinradius( self.origin, 100 );
        
        if ( players_in_radius.size > 0 )
        {
            thread explode();
            return;
        }
        
        waitframe();
    }
}

// Namespace mp_sat_ob_capricorn_chase_gdu
// Params 0
// Checksum 0x7f682e66, Offset: 0x842
// Size: 0x143
function function_7a7fa4f5b2a2cd38()
{
    self endon( #"death" );
    level.var_3d9fc7aa7b25b565.truck endon( #"death" );
    gdu = self;
    truck = level.var_3d9fc7aa7b25b565.truck;
    collisioncontents = physics_createcontents( [ "physicscontents_playerclip", "physicscontents_characterproxy", "physicscontents_vehicleclip", "physicscontents_item", "physicscontents_ainoshoot", "physicscontents_playernosight" ] );
    
    while ( isdefined( gdu ) )
    {
        dist = distance( level.var_3d9fc7aa7b25b565.truck.origin, gdu.origin );
        
        if ( dist < 4000 )
        {
            hitents = physics_raycast( gdu.origin + anglestoup( gdu.angles ) * 10, truck.origin, collisioncontents, [ gdu, truck ], 0, "physicsquery_all" );
            
            if ( hitents.size == 0 )
            {
                gdu function_f8f3b3e5a09e898( truck );
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace mp_sat_ob_capricorn_chase_gdu
// Params 1
// Checksum 0x6e95435a, Offset: 0x98d
// Size: 0xd0
function function_f8f3b3e5a09e898( target )
{
    gdu = self;
    gdu setscriptablepartstate( #"hash_8bbd1e9dfde216e8", #"on" );
    predictedpos = target.origin;
    
    if ( target vehicle::is_vehicle() )
    {
        gdu thread check_for_explosion();
        truckforward = vectornormalize2( anglestoforward( target.angles ) );
        predictedpos = getclosestpointonnavmesh( target.origin + truckforward * 450 );
    }
    
    huntspeed = gdu.var_a46d3dc5e1674568 ? 50 : 300;
    gdu vehicle_ai::go_to_path( [ predictedpos ], 300, 1, 1 );
    gdu thread explode();
}

// Namespace mp_sat_ob_capricorn_chase_gdu
// Params 0
// Checksum 0xf33ab91, Offset: 0xa65
// Size: 0x176
function check_for_explosion()
{
    self endon( #"death" );
    level.var_3d9fc7aa7b25b565.truck endon( #"death" );
    gdu = self;
    
    while ( isdefined( gdu ) )
    {
        truck = level.var_3d9fc7aa7b25b565.truck;
        truck_speed = truck vehicle_getspeed();
        truck_max_speed = truck vehicle_gettopspeedforward();
        var_a4ec8f192ced84e2 = math::function_1243a6cc6a030f2a( gdu.origin, truck getcentroid(), truck getboundshalfsize(), truck.angles );
        var_af3da0fd7b8eab13 = mapfloat( 0, truck_max_speed, 75, 150, truck_speed );
        player_speed = level.var_3d9fc7aa7b25b565.truck vehicle_getvelocity();
        predicted_player_pos = var_a4ec8f192ced84e2 + player_speed * 0.2;
        dist = distance( predicted_player_pos, gdu.origin );
        test = vectornormalize( var_a4ec8f192ced84e2 - predicted_player_pos );
        test = abs( vectordot( test, anglestoforward( truck.angles ) ) );
        var_4be54a6232f335a4 = mapfloat( 0, 1, 0.45, 0.9, test );
        
        if ( dist < var_af3da0fd7b8eab13 * var_4be54a6232f335a4 )
        {
            gdu thread explode();
            return;
        }
        
        waitframe();
    }
}

// Namespace mp_sat_ob_capricorn_chase_gdu
// Params 0
// Checksum 0x6ca3f578, Offset: 0xbe3
// Size: 0xa4
function explode()
{
    self notify( #"death" );
    gdu = self;
    mindamage = gdu.var_a46d3dc5e1674568 ? 30 : 400;
    maxdamage = gdu.var_a46d3dc5e1674568 ? 45 : 400;
    gdu radiusdamage( gdu.origin, 200, maxdamage, mindamage, gdu, "MOD_EXPLOSIVE", "ground_drone_unit" );
    gdu setscriptablepartstate( #"explode", #"hash_11fe932bac158d98" );
    waitframe();
    
    if ( isdefined( gdu ) )
    {
        gdu delete();
    }
}

