// scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_vehicle.gsc  (hash_6f42bff616db8bc3.gscc) (size: 19258 Bytes / 0x4b3a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2a2003c2 (706741186)
// size ...... 19258 (0x4b3a)
// includes .. 10  (offset: 0x469a)
// strings ... 48  (offset: 0x46ea)
// dev strs .. 31  (offset: 0x49c2)
// exports ... 35  (offset: 0x2d4e)
// cseg ...... 0x46d + 0x28e1 (0x2d4e)
// imports ... 154 (offset: 0x32c6)
// animtree1 . 0   (offset: 0x4b3a)
// animtree2 . 0   (offset: 0x4b3a)
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_metabones;
#using scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_summon;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\common\vehicle_occupancy;

#namespace zombie_hermes_vehicle;

// Namespace zombie_hermes_vehicle
// Params 0
// Checksum 0xf54413cf, Offset: 0x48b
// Size: 0xbb
function function_b963907716ab4fd()
{
    foreach ( player in level.players )
    {
        function_71c1b85766dfe6a0( player );
    }
    
    callback::add( #"player_connect", &hermes_on_player_connected );
    callback::add( #"player_vehicle_exit", &function_d1fdc2dc13c7220e );
    level callback::add( #"player_damaged", &hermes_on_player_damaged );
}

// Namespace zombie_hermes_vehicle
// Params 0
// Checksum 0x59cd80bc, Offset: 0x54e
// Size: 0x50
function init_zombie_hermes_vehicle()
{
    grab_brushmodel( "hermes_script_brushmodel" );
    grab_brushmodel( "hermes_vehicle_script_brushmodel" );
    utility::callsharedfunc( #"vehicle", #"hash_d619f6815b2b6782", &function_fb7051f02b736e79 );
    thread function_50b4b1ce4c8e5562();
    thread function_a7e50f54e8ae473c();
    
    /#
        function_72d0a2d25adc068d();
    #/
}

// Namespace zombie_hermes_vehicle
// Params 3
// Checksum 0x7638c4f3, Offset: 0x5a6
// Size: 0x7b1
function function_3b675e9a0c959e1d( hermes, vehicle, dmg_struct )
{
    damage_mult = 1;
    var_e0dbf04e31b92c3c = vehicle vehicle_getspeed() > 25;
    var_17c0464370153965 = vehicle isboosting();
    hermes_is_spinning = hermes utility::ent_flag( "hermes_gamera_spin_fast" );
    
    if ( var_e0dbf04e31b92c3c )
    {
        damage_mult = 150 * hermes.hermes_health_scalar;
        
        if ( var_17c0464370153965 )
        {
            damage_mult *= 1.4;
        }
        
        if ( dmg_struct.metabonename && zombie_hermes_metabones::function_579ea20e41126f88( dmg_struct.metabonename ) )
        {
            damage_mult *= 1.5;
            dmg_struct.var_4f9d5587bf9a2b1e = 1;
        }
        
        if ( dmg_struct.metabonename && zombie_hermes_metabones::function_343158931a6545a6( dmg_struct.metabonename ) )
        {
            damage_mult *= 2.85;
            dmg_struct.biscritical = 1;
        }
        
        var_fdc5e4472f1e2a76 = getplayersinradius( hermes.origin, 3000 );
        
        if ( var_fdc5e4472f1e2a76 && var_fdc5e4472f1e2a76.size > 1 )
        {
            var_93c867f111ae739d = var_fdc5e4472f1e2a76.size - 1;
            damage_mult *= 1 + var_93c867f111ae739d * 0.5;
        }
        
        if ( vehicle utility::ent_flag( "aetheric_energy_imbued" ) )
        {
            damage_mult *= 1.1;
        }
    }
    
    all_occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( vehicle, 0 );
    
    foreach ( occupant in all_occupants )
    {
        function_83bb63594df2b595( occupant, undefined, 0 );
    }
    
    vehicle_dir = vectornormalize( vehicle vehicle_getvelocity() );
    to_hermes = hermes.origin - vehicle.origin;
    var_990a3f100149493e = hermes.hermes_velocity;
    var_2efecaefbcb1d611 = to_hermes[ 2 ] > 50;
    var_df814321779f1968 = undefined;
    hermes_pushback = getdvarfloat( @"hash_6bbe78f5cccd6d18", 0.1 );
    
    if ( !var_e0dbf04e31b92c3c )
    {
        hermes_pushback *= 0.5;
    }
    
    var_df814321779f1968 = to_hermes * hermes_pushback;
    up_sign = math::function_84e592007021cc09( vehicle_dir, to_hermes ) ? -1 : 1;
    side_vec = vectorcross( to_hermes, ( 0, 0, up_sign ) );
    
    if ( var_17c0464370153965 && !hermes_is_spinning )
    {
        var_2076b6add47a008e = getdvarfloat( @"hash_39f3233b2fc6c1cc", 0.025 );
        var_df814321779f1968 = to_hermes * var_2076b6add47a008e + to_hermes * hermes_pushback * 0.75;
    }
    
    var_df814321779f1968 = math::function_235fe1fdb403e4b2( var_df814321779f1968, 40 );
    impulse_force = getdvarfloat( @"hash_beb95e293475908b", 190 );
    impulse_num = 2;
    var_f591aa042b547daa = ( 0, 0, 0 );
    var_f591aa042b547daa = utility::flat_origin( to_hermes * -1 );
    
    if ( lengthsquared( var_f591aa042b547daa ) > 1 )
    {
        var_f591aa042b547daa = math::function_235fe1fdb403e4b2( var_f591aa042b547daa, getdvarfloat( @"hash_674757fae4b47572", -45 ) );
    }
    
    if ( hermes_is_spinning )
    {
        impulse_num += 2;
    }
    
    if ( var_2efecaefbcb1d611 )
    {
        impulse_force = 0;
    }
    
    for ( impulse_i = 0; impulse_i < impulse_num ; impulse_i++ )
    {
        if ( var_f591aa042b547daa != ( 0, 0, 0 ) )
        {
            vehicle vehphys_impulse( var_f591aa042b547daa, impulse_force, 1 );
        }
    }
    
    dmg_struct.vpoint = calculate_impact_point( hermes, vehicle );
    hood_pos = vehicle getcentroid() + anglestoforward( vehicle.angles ) * 30;
    force_pos = coordtransformtranspose( dmg_struct.vpoint, vehicle.origin, vehicle.angles );
    var_25ef6d069ed29105 = coordtransformtranspose( hood_pos, vehicle.origin, vehicle.angles );
    bounds_mid = vehicle getboundsmidpoint();
    bounds_size = vehicle getboundshalfsize();
    impact_point_on_vehicle = math::function_1243a6cc6a030f2a( force_pos, bounds_mid, bounds_size, vehicle.angles );
    thread function_8c14316ecb4425fe( hermes, vehicle, var_f591aa042b547daa, impulse_force, var_e0dbf04e31b92c3c, var_17c0464370153965, hermes_is_spinning, var_df814321779f1968, dmg_struct );
    thread function_df6d74a07cd9e01a( hermes, vehicle, var_e0dbf04e31b92c3c );
    thread knockback_nearby_ai( hermes, vehicle );
    rumble = var_17c0464370153965 || var_e0dbf04e31b92c3c ? "heavy_1s" : "light_1s";
    earthquake_scale = var_17c0464370153965 || var_e0dbf04e31b92c3c ? 0.4 : 0.2;
    all_occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( vehicle, 0 );
    
    foreach ( occupant in all_occupants )
    {
        if ( isplayer( occupant ) )
        {
            occupant playrumbleonentity( rumble );
            occupant earthquakeforplayer( earthquake_scale, 0.6, calculate_impact_point( hermes, vehicle ), 1000 );
            
            if ( occupant.vehicle && occupant isinvehicleleanout() )
            {
                occupant_dist = distance( occupant geteye(), dmg_struct.vpoint );
                
                if ( occupant_dist < getdvarfloat( @"hash_dbcb08dd085d6161", 180 ) )
                {
                    occupant dodamage( 100, dmg_struct.vpoint, hermes, hermes, "MOD_IMPACT" );
                    occupant function_489f17e5a9fe932a();
                }
                
                /#
                    if ( function_d0af3b3dd125072e() )
                    {
                        line( occupant geteye(), dmg_struct.vpoint, ( 1, 0.2, 0.3 ) );
                        print3d( averagepoint( [ occupant geteye(), dmg_struct.vpoint ] ), "<dev string:x24>" + occupant_dist, ( 1, 0.2, 0.3 ) );
                    }
                #/
            }
        }
    }
    
    earthquake( earthquake_scale, 0.6, calculate_impact_point( hermes, vehicle ), 600 );
    vehicle notify( #"vehicle_collides_hermes" );
    
    if ( var_17c0464370153965 )
    {
        hermes.var_a1b7a38728db98eb = gettime();
    }
    
    damage_to_vehicle = 2000;
    vehicle dodamage( damage_to_vehicle, hermes.origin, hermes, hermes, "MOD_IMPACT" );
    
    /#
        if ( function_d0af3b3dd125072e() )
        {
            line( vehicle.origin, vehicle.origin + var_f591aa042b547daa, ( 1, 0, 0.5 ) );
            var_6e5f6cfab653af = ( !var_e0dbf04e31b92c3c ? "<dev string:x33>" : "<dev string:x45>" ) + ( var_2efecaefbcb1d611 ? "<dev string:x46>" : "<dev string:x45>" );
            print3d( vehicle.origin + var_f591aa042b547daa, "<dev string:x52>" + impulse_force + "<dev string:x6b>" + var_6e5f6cfab653af, ( 1, 0, 0.5 ) );
            line( hermes.origin, hermes.origin + hermes.hermes_velocity, ( 0.3, 1, 0.5 ) );
            print3d( hermes.origin + hermes.hermes_velocity, "<dev string:x6d>", ( 0.3, 1, 0.5 ) );
        }
    #/
    
    return damage_mult;
}

// Namespace zombie_hermes_vehicle
// Params 1
// Checksum 0x33cdc107, Offset: 0xd60
// Size: 0x16a
function is_valid_vehicle_hit( dmg_struct )
{
    if ( !dmg_struct.eattacker.vehicletype )
    {
        return 0;
    }
    
    if ( !arraycontains( [ "MOD_CRUSH" ], dmg_struct.smeansofdeath ) )
    {
        return 0;
    }
    
    vehicle = dmg_struct.eattacker;
    hermes = self;
    var_c4e64499999d2417 = math::function_1243a6cc6a030f2a( vehicle getcentroid(), hermes getcentroid(), hermes getboundshalfsize(), hermes.angles );
    closest_point_on_vehicle = math::function_1243a6cc6a030f2a( var_c4e64499999d2417, vehicle getcentroid(), vehicle getboundshalfsize(), vehicle.angles );
    var_f1b807e36f506e21 = distance2d( closest_point_on_vehicle, var_c4e64499999d2417 );
    result = 0;
    
    if ( var_f1b807e36f506e21 < getdvarfloat( @"hash_1cc0ef72f34e9725", 100 ) )
    {
        result = 1;
    }
    
    /#
        if ( function_d0af3b3dd125072e() )
        {
            col = result ? ( 0, 1, 0 ) : ( 0.4, 0.6, 0 );
            utility::draw_entity_bounds( vehicle, level.framedurationseconds, col );
            line( closest_point_on_vehicle, var_c4e64499999d2417, col );
            print3d( averagepoint( [ var_c4e64499999d2417, closest_point_on_vehicle ] ), "<dev string:x7c>" + var_f1b807e36f506e21, col );
        }
    #/
    
    return result;
}

// Namespace zombie_hermes_vehicle
// Params 1, eflags: 0x4
// Checksum 0x1896b7b1, Offset: 0xed3
// Size: 0x494
function private function_fb7051f02b736e79( dmg_struct )
{
    if ( !isai( dmg_struct.attacker ) || dmg_struct.attacker.subclass != "zombie_hermes" )
    {
        return dmg_struct.damage;
    }
    
    if ( dmg_struct.inflictor.classname == "rocket" )
    {
        is_splash = dmg_struct.meansofdeath == "MOD_PROJECTILE_SPLASH";
        
        if ( !utility::ent_flag( "hermes_missile_impulse_launched" ) )
        {
            impulse_angles = dmg_struct.inflictor.angles;
            
            if ( is_splash )
            {
                impulse_angles = vectortoangles( self getcentroid() - dmg_struct.point );
            }
            
            var_b317db1338c99c4 = impulse_angles;
            impulse_angles = ( clamp( impulse_angles[ 0 ], -40, 40 ), impulse_angles[ 1 ], impulse_angles[ 2 ] );
            impulse_vec = anglestoright( impulse_angles ) * utility::array_random( [ -1, 1 ] );
            force = getdvarfloat( @"hash_8f8690381d7e4591", 90 );
            
            if ( is_splash )
            {
                force = int( force * 0 );
            }
            else
            {
                self vehphys_impulse( impulse_vec, force, 1 );
                self vehphys_impulse( impulse_vec, force, 1 );
                self vehphys_impulse( impulse_vec, force, 1 );
                self vehphys_impulse( impulse_vec * -1, force * 0.25, 0 );
            }
            
            logstring( "Hermes Missile Impulse Vector: " + impulse_vec + " - Preclamped Impulse Angles: " + var_b317db1338c99c4 );
            player_damage_multiplier = 1;
            
            if ( !is_splash )
            {
                dmg_struct.damage *= getdvarfloat( @"hash_a6d7262cfea2b7fc", 26 );
                player_damage_multiplier *= 0.192;
                utility::ent_flag_set( "hermes_missile_impulse_launched" );
                thread utility::ent_flag_clear_delayed( "hermes_missile_impulse_launched", 3 );
            }
            else
            {
                dmg_struct.damage *= getdvarfloat( @"hash_166c0bc4c4460de4", 3.6 );
                player_damage_multiplier *= 0.83;
                dmg_struct.meansofdeath = "MOD_IMPACT";
            }
            
            occupants = vehicle_occupancy::get_all_occupants( self, 0 );
            
            foreach ( occupant in occupants )
            {
                occupant.var_da9b6be11a3d40b6 = 1;
                occupant dodamage( int( dmg_struct.damage * player_damage_multiplier ), dmg_struct.point, dmg_struct.attacker, dmg_struct.inflictor, dmg_struct.meansofdeath );
                occupant.var_da9b6be11a3d40b6 = undefined;
            }
            
            if ( utility::ent_flag( "vehicle_collision_missile_protection" ) )
            {
                dmg_struct.damage *= dmg_struct.attacker.var_45dd78b65ba72097 ?? 0.5;
            }
            
            if ( dmg_struct.attacker.var_f290c89ef95473b8 && self.var_e2c27eded7998a2c && !utility::time_has_passed( self.var_e2c27eded7998a2c, 5 ) )
            {
                dmg_struct.damage *= 0.25;
            }
        }
    }
    else if ( dmg_struct.meansofdeath == "MOD_PROJECTILE" )
    {
        dmg_struct.damage = getdvarfloat( @"hash_220df6c1cea4495d", 500 );
        
        if ( self.var_e2c27eded7998a2c && !utility::time_has_passed( self.var_e2c27eded7998a2c, 5 ) )
        {
            dmg_struct.damage *= 0.25;
        }
    }
    
    if ( dmg_struct.attacker.var_c036c75be54bf29f )
    {
        dmg_struct.damage *= dmg_struct.attacker.var_c036c75be54bf29f;
    }
    
    dmg_struct.damage = int( max( min( self.health - 50, dmg_struct.damage ), 0 ) );
    return dmg_struct.damage;
}

// Namespace zombie_hermes_vehicle
// Params 0, eflags: 0x4
// Checksum 0xa2034b0b, Offset: 0x1370
// Size: 0x3d5
function private function_50b4b1ce4c8e5562()
{
    self endon( #"death" );
    
    while ( true )
    {
        nearby_vehicles = vehicle_getarrayinradius( self.origin, 2000 );
        
        foreach ( vehicle in nearby_vehicles )
        {
            if ( !vehicle vehicle_isphysveh() )
            {
                /#
                    vehicle print_vehicle( "<dev string:x87>" );
                #/
                
                continue;
            }
            
            vehicle thread function_a1e4a1f967e237bd( vehicle );
            
            if ( !vehicle vehicle_isonground() )
            {
                /#
                    vehicle print_vehicle( "<dev string:x9b>" );
                #/
                
                continue;
            }
            
            if ( angleclamp180( vehicle.angles[ 0 ] ) > -10 )
            {
                /#
                    vehicle print_vehicle( "<dev string:xa9>" + angleclamp180( vehicle.angles[ 0 ] ) );
                #/
                
                continue;
            }
            
            var_67201f1c3d36a958 = vectornormalize2( vehicle vehicle_getvelocity() );
            var_f2c7c6d538b4d3ea = vectordot( vectornormalize2( self.origin - vehicle.origin ), var_67201f1c3d36a958 );
            
            if ( var_f2c7c6d538b4d3ea < 0.93 )
            {
                /#
                    vehicle print_vehicle( "<dev string:xba>" + var_f2c7c6d538b4d3ea );
                #/
                
                continue;
            }
            
            var_4c9c337d6d4882c5 = vectordot( vectornormalize2( self.arena_center_pos - vehicle.origin ), var_67201f1c3d36a958 );
            
            if ( var_4c9c337d6d4882c5 < 0.9 )
            {
                /#
                    vehicle print_vehicle( "<dev string:xd5>" + var_f2c7c6d538b4d3ea );
                #/
                
                continue;
            }
            
            if ( vehicle vehicle_getspeed() < 5 )
            {
                /#
                    vehicle print_vehicle( "<dev string:xfd>" + vehicle vehicle_getspeed() );
                #/
                
                continue;
            }
            
            var_e4e47cbe7913775e = distance2d( self.origin, vehicle.origin );
            
            if ( var_e4e47cbe7913775e > 800 )
            {
                /#
                    vehicle print_vehicle( "<dev string:x10e>" + var_e4e47cbe7913775e );
                #/
                
                continue;
            }
            
            if ( gettime() < vehicle.var_1a6a77103388069b )
            {
                /#
                    vehicle print_vehicle( "<dev string:x127>" + gettime() - vehicle.var_1a6a77103388069b );
                #/
                
                continue;
            }
            
            if ( !self.var_97c3df14b06d14ca || utility::time_has_passed( self.var_97c3df14b06d14ca, 0.25 ) )
            {
                /#
                    vehicle print_vehicle( "<dev string:x135>" );
                #/
                
                continue;
            }
            
            time = getdvarfloat( @"hash_c09fc1200f4cee39", 2 );
            speed_boost = int( getdvarfloat( @"hash_bc1e30ac54627799", 100 ) );
            hood_pos = vehicle getcentroid() + anglestoforward( vehicle.angles ) * 50;
            var_25ef6d069ed29105 = coordtransformtranspose( hood_pos, vehicle.origin, vehicle.angles );
            vehicle vehphys_force( ( getdvarfloat( @"hash_dc813ae7196035e1", 500000 ), 0, -1 * getdvarfloat( @"hash_ccdda0894b61d088", 0 ) ), var_25ef6d069ed29105, getdvarfloat( @"hash_1574ca273398eeac", 1 ) );
            
            /#
                if ( function_d0af3b3dd125072e() )
                {
                    print_vehicle( "<dev string:x14e>" + var_f2c7c6d538b4d3ea + "<dev string:x169>" + var_4c9c337d6d4882c5, ( 0, 1, 0 ) );
                }
            #/
            
            vehicle thread increase_vehicle_speed( vehicle, speed_boost, time );
            level callback::callback( "hermes_vehicle_modified", { #vehicle:vehicle } );
            vehicle.var_1a6a77103388069b = gettime() + getdvarfloat( @"hash_69844f82eeec2f0f", 2000 );
        }
        
        waitframe();
    }
}

// Namespace zombie_hermes_vehicle
// Params 0, eflags: 0x4
// Checksum 0x85bdef2b, Offset: 0x174d
// Size: 0x180
function private function_a7e50f54e8ae473c()
{
    self endon( #"death" );
    radius = 400;
    
    while ( true )
    {
        nearby_vehicles = vehicle_getarrayinradius( self.origin, radius );
        
        foreach ( vehicle in nearby_vehicles )
        {
            players = vehicle_occupancy::function_8ed9bcd8e9ea74f5( vehicle, 0 );
            
            foreach ( player in players )
            {
                if ( !player utility::ent_flag( "hermes_vehicle_shake" ) )
                {
                    player utility::ent_flag_set( "hermes_vehicle_shake" );
                    player thread utility::ent_flag_clear_delayed( "hermes_vehicle_shake", 1 );
                    player earthquakeforplayer( 0.2, 1, self.origin, radius * 2 );
                    player playrumbleonpositionforclient( "light_1s", self.origin );
                }
            }
        }
        
        waitframe();
    }
}

// Namespace zombie_hermes_vehicle
// Params 1, eflags: 0x4
// Checksum 0x62a7cca8, Offset: 0x18d5
// Size: 0x139
function private function_a1e4a1f967e237bd( vehicle )
{
    vehicle endon( #"death" );
    
    if ( vehicle utility::ent_flag( "hermes_monitoring_collisions" ) )
    {
        return;
    }
    
    vehicle utility::ent_flag_set( "hermes_monitoring_collisions" );
    
    while ( true )
    {
        vehicle waittill( #"collision", body0, body1, flag0, flag1, position, normal, impulse, ent, collzone );
        
        if ( ent && ent.targetname == "hermes_vehicle_script_brushmodel" )
        {
            ent notsolid();
            
            while ( true )
            {
                dist2d = distance2d( ent.origin, vehicle.origin );
                
                if ( dist2d > 500 )
                {
                    /#
                        if ( function_d0af3b3dd125072e() )
                        {
                            print3d( ent.origin, "<dev string:x17d>", ( 1, 0.2, 0.2 ) );
                        }
                    #/
                    
                    break;
                }
                
                waitframe();
            }
            
            ent solid();
        }
    }
}

// Namespace zombie_hermes_vehicle
// Params 3, eflags: 0x4
// Checksum 0xfea7323f, Offset: 0x1a16
// Size: 0xda
function private increase_vehicle_speed( vehicle, speed_boost, time )
{
    vehicle endon( #"death" );
    var_7cddadbe0195d28b = vehicle vehicle_gettopspeedforward();
    var_433b39112f3e7d60 = int( var_7cddadbe0195d28b + speed_boost );
    vehicle.var_68c6a01ce741b3f8 = 1;
    vehicle vehicle_settopspeedforward( var_433b39112f3e7d60 );
    vehicle utility::waittill_notify_or_timeout( "vehicle_collides_hermes", time );
    vehicle notify( #"hash_7e2220d729fcacbd" );
    vehicle.var_68c6a01ce741b3f8 = 0;
    var_8b6b1e531818c4ff = vehicle vehicle_gettopspeedforward();
    
    if ( var_8b6b1e531818c4ff > speed_boost )
    {
        vehicle vehicle_settopspeedforward( int( var_8b6b1e531818c4ff - speed_boost ) );
    }
    
    /#
        if ( function_d0af3b3dd125072e() )
        {
            print_vehicle( "<dev string:x196>", ( 0.5, 0.2, 0 ) );
        }
    #/
}

// Namespace zombie_hermes_vehicle
// Params 9, eflags: 0x4
// Checksum 0xa92b90c4, Offset: 0x1af8
// Size: 0x151
function private function_8c14316ecb4425fe( hermes, vehicle, var_f591aa042b547daa, impulse_force, var_e0dbf04e31b92c3c, var_17c0464370153965, hermes_is_spinning, var_df814321779f1968, dmg_struct )
{
    vehicle endon( #"death" );
    wait getdvarfloat( @"hash_8e8f13abeab3d31c", 0.1 );
    thread function_56337bdeece45a8e( hermes, vehicle, var_e0dbf04e31b92c3c, var_17c0464370153965, dmg_struct );
    impulse_force = getdvarfloat( @"hash_aa1a788606ffb2b1", 255 );
    var_f591aa042b547daa = utility::flat_origin( var_f591aa042b547daa );
    var_f591aa042b547daa = math::function_235fe1fdb403e4b2( var_f591aa042b547daa, getdvarfloat( @"hash_3da6822c48d29b58", 1 ) );
    impulse_num = getdvarint( @"hash_83b99570abcc7037", 0 );
    
    if ( hermes_is_spinning )
    {
        impulse_num += 3;
    }
    
    if ( var_17c0464370153965 )
    {
        impulse_num += 0;
    }
    
    for ( impulse_i = 0; impulse_i < impulse_num ; impulse_i++ )
    {
        if ( var_f591aa042b547daa != ( 0, 0, 0 ) )
        {
            vehicle vehphys_impulse( var_f591aa042b547daa, impulse_force, 1 );
        }
    }
    
    if ( var_df814321779f1968 )
    {
        hermes.hermes_velocity = var_df814321779f1968;
    }
    
    hermes utility::ent_flag_set( "hermes_pushback_recently" );
    hermes thread utility::ent_flag_clear_delayed( "hermes_pushback_recently", 1.5 );
}

// Namespace zombie_hermes_vehicle
// Params 2, eflags: 0x4
// Checksum 0xee214076, Offset: 0x1c51
// Size: 0x133
function private function_e0b41caf654c3cc5( var_f870f618524229fc, targetname )
{
    self endon( #"death" );
    
    while ( true )
    {
        var_b44147cf877e9402 = var_f870f618524229fc.health;
        var_f870f618524229fc waittill( #"damage", idamage, eattacker, direction_vec, damagelocation, smeansofdeath, modelname, attachtagname, partname, dflags, objweapon, origin, angles, normal, einflictor, time );
        
        if ( smeansofdeath == "MOD_CRUSH" )
        {
            if ( targetname != "hermes_vehicle_script_brushmodel" )
            {
                var_f870f618524229fc.health = var_b44147cf877e9402;
                continue;
            }
            
            idamage = 200;
        }
        
        self dodamage( idamage, damagelocation, eattacker, einflictor, smeansofdeath, objweapon, "torso_upper", undefined, dflags );
        var_f870f618524229fc.health = var_b44147cf877e9402;
    }
}

// Namespace zombie_hermes_vehicle
// Params 3, eflags: 0x4
// Checksum 0xdf60bdeb, Offset: 0x1d8c
// Size: 0xbe
function private function_83bb63594df2b595( player, hermes, lockon )
{
    if ( getdvarint( @"hermes_vehicle_lock_on", 1 ) <= 0 )
    {
        return;
    }
    
    vehicle = player.vehicle;
    
    if ( !vehicle )
    {
        return;
    }
    
    if ( vehicle.occupants.size <= 0 )
    {
        return;
    }
    
    if ( lockon )
    {
        if ( !hermes )
        {
            return;
        }
        
        player function_2c809dbea97c1579( hermes );
        player utility::ent_flag_set( "hermes_camera_locked_on" );
        player utility::ent_flag_set( "hermes_camera_locked_off_disabled" );
        player thread utility::ent_flag_clear_delayed( "hermes_camera_locked_off_disabled", 0.25 );
        return;
    }
    
    player function_2c809dbea97c1579();
    player utility::ent_flag_clear( "hermes_camera_locked_on" );
}

// Namespace zombie_hermes_vehicle
// Params 1, eflags: 0x4
// Checksum 0xed9ce790, Offset: 0x1e52
// Size: 0x79
function private function_3b32534d6bc6f915( player )
{
    if ( !player.vehicle )
    {
        return;
    }
    
    is_locked_on = player utility::ent_flag( "hermes_camera_locked_on" );
    
    if ( !is_locked_on )
    {
        hermes = zombie_utils::get_closest_zombie( player.origin, undefined, "zombie_hermes", 4000 );
        function_83bb63594df2b595( player, hermes, 1 );
        return;
    }
    
    function_83bb63594df2b595( player, undefined, 0 );
}

// Namespace zombie_hermes_vehicle
// Params 1, eflags: 0x4
// Checksum 0x147f4722, Offset: 0x1ed3
// Size: 0x4c
function private function_71c1b85766dfe6a0( player )
{
    player notifyonplayercommand( "hermes_vehicle_lock_on", "+speed_throw" );
    player notifyonplayercommand( "hermes_vehicle_lock_off", "-speed_throw" );
    level thread function_2b0860c32e57f0ae( player );
    level thread function_fb3aa53eeb406350( player );
    level thread function_54d2198d0214b015( player );
}

// Namespace zombie_hermes_vehicle
// Params 1, eflags: 0x4
// Checksum 0xd4c3ba00, Offset: 0x1f27
// Size: 0x5e
function private function_2b0860c32e57f0ae( player )
{
    while ( player )
    {
        player waittill( #"hermes_vehicle_lock_on" );
        
        if ( player )
        {
            hermes = zombie_utils::get_closest_zombie( player.origin, undefined, "zombie_hermes", 4000 );
            
            if ( hermes )
            {
                function_83bb63594df2b595( player, hermes, 1 );
            }
        }
    }
}

// Namespace zombie_hermes_vehicle
// Params 1, eflags: 0x4
// Checksum 0xb6898873, Offset: 0x1f8d
// Size: 0x40
function private function_fb3aa53eeb406350( player )
{
    while ( player )
    {
        player waittill( #"hermes_vehicle_lock_off" );
        
        if ( player )
        {
            player utility::ent_flag_waitopen_any( "hermes_camera_locked_off_disabled" );
            function_83bb63594df2b595( player, undefined, 0 );
        }
    }
}

// Namespace zombie_hermes_vehicle
// Params 1, eflags: 0x4
// Checksum 0x9670972e, Offset: 0x1fd5
// Size: 0x11c
function private function_54d2198d0214b015( player )
{
    var_e81dabb532b35dfb = 1;
    var_4fc9a6101bbe709d = 0;
    
    while ( player )
    {
        if ( !player.vehicle )
        {
            waitframe();
            continue;
        }
        
        if ( !player usinggamepad() )
        {
            waitframe();
            continue;
        }
        
        hermes = zombie_utils::get_closest_zombie( player.origin, undefined, "zombie_hermes", 4000 );
        
        if ( !hermes )
        {
            waitframe();
            continue;
        }
        
        if ( !player jumpbuttonpressed() )
        {
            var_e81dabb532b35dfb = 1;
        }
        
        if ( player jumpbuttonpressed() && var_e81dabb532b35dfb )
        {
            if ( !player utility::ent_flag( "hermes_camera_locked_on" ) )
            {
                function_83bb63594df2b595( player, hermes, 1 );
                var_e81dabb532b35dfb = 0;
            }
            else
            {
                function_83bb63594df2b595( player, undefined, 0 );
                var_e81dabb532b35dfb = 0;
            }
            
            waitframe();
            continue;
        }
        
        yaw_move = player getyawmove();
        
        if ( yaw_move != 0 || var_4fc9a6101bbe709d != 0 )
        {
            if ( player utility::ent_flag( "hermes_camera_locked_on" ) )
            {
                if ( abs( yaw_move ) >= 0.1 )
                {
                    function_83bb63594df2b595( player, undefined, 0 );
                }
            }
        }
        
        var_4fc9a6101bbe709d = yaw_move;
        waitframe();
    }
}

// Namespace zombie_hermes_vehicle
// Params 1, eflags: 0x4
// Checksum 0x5bac264a, Offset: 0x20f9
// Size: 0x1d
function private hermes_on_player_connected( params )
{
    if ( !isbot( self ) )
    {
        function_71c1b85766dfe6a0( self );
    }
}

// Namespace zombie_hermes_vehicle
// Params 1, eflags: 0x4
// Checksum 0xa5084c6a, Offset: 0x211e
// Size: 0x30
function private function_d1fdc2dc13c7220e( params )
{
    function_83bb63594df2b595( self, undefined, 0 );
    utility::ent_flag_set( "hermes_exit_vehicle_recently" );
    thread utility::ent_flag_clear_delayed( "hermes_exit_vehicle_recently", 2 );
}

// Namespace zombie_hermes_vehicle
// Params 4, eflags: 0x4
// Checksum 0xa925d5eb, Offset: 0x2156
// Size: 0xdf
function private brushmodel_update_position( hermes, var_f870f618524229fc, targetname, offset )
{
    hermes endon( #"death" );
    hermes endon( #"fake_death" );
    hermes notify( "brushmodel_update_position_" + targetname );
    hermes endon( "brushmodel_update_position_" + targetname );
    
    while ( true )
    {
        if ( !isdefined( var_f870f618524229fc ) )
        {
            assertmsg( "<dev string:x1a4>" );
            return;
        }
        
        z_offset = offset[ 2 ];
        z_offset_vector = anglestoup( hermes.angles ) * z_offset;
        var_f870f618524229fc.origin = hermes.origin + z_offset_vector;
        
        if ( targetname != "hermes_vehicle_script_brushmodel" )
        {
            var_f870f618524229fc.angles = hermes.angles;
        }
        
        waitframe();
    }
}

// Namespace zombie_hermes_vehicle
// Params 1, eflags: 0x4
// Checksum 0xf1bc85a3, Offset: 0x223d
// Size: 0x131
function private grab_brushmodel( targetname )
{
    var_a296c67ce781657d = getentarray( targetname, "targetname" );
    var_f870f618524229fc = isarray( var_a296c67ce781657d ) ? var_a296c67ce781657d[ 0 ] : undefined;
    
    if ( isdefined( var_f870f618524229fc ) )
    {
        self.hermes_brush_model[ targetname ] = var_f870f618524229fc;
        
        if ( !isdefined( level.var_b5572645bd2e3f88 ) )
        {
            level.var_b5572645bd2e3f88 = var_f870f618524229fc.origin;
        }
        
        var_f870f618524229fc.origin = ( 0, 0, 0 );
        var_f870f618524229fc.health = 1000000;
        offset = ( 0, 0, getdvarfloat( @"hash_5a5901704a8d06f1", 300 ) );
        
        if ( targetname == "hermes_vehicle_script_brushmodel" )
        {
            offset = ( 0, 0, getdvarfloat( @"hash_ae764eea725beb7a", 200 ) );
        }
        
        var_f870f618524229fc setcandamage( 1 );
        var_f870f618524229fc solid();
        thread function_e0b41caf654c3cc5( var_f870f618524229fc, targetname );
        level thread brushmodel_update_position( self, var_f870f618524229fc, targetname, offset );
        var_f870f618524229fc.owner = self;
        thread utility::thread_on_notify_no_endon_death( "death", &reset_brushmodel, var_f870f618524229fc );
        thread utility::thread_on_notify_no_endon_death( "fake_death", &reset_brushmodel, var_f870f618524229fc );
    }
}

// Namespace zombie_hermes_vehicle
// Params 0, eflags: 0x4
// Checksum 0x9184c7b6, Offset: 0x2376
// Size: 0x2c
function private reset_brushmodel()
{
    assert( isdefined( level.var_b5572645bd2e3f88 ) );
    self unlink();
    self.origin = level.var_b5572645bd2e3f88;
}

// Namespace zombie_hermes_vehicle
// Params 2, eflags: 0x4
// Checksum 0x5da739e2, Offset: 0x23aa
// Size: 0x12f
function private calculate_impact_point( hermes, vehicle )
{
    closest_point_on_vehicle = math::function_1243a6cc6a030f2a( hermes getcentroid(), vehicle getcentroid(), vehicle getboundshalfsize(), vehicle.angles );
    var_c4e64499999d2417 = math::function_1243a6cc6a030f2a( vehicle getcentroid(), hermes getcentroid(), hermes getboundshalfsize(), hermes.angles );
    var_c4e64499999d2417 = ( var_c4e64499999d2417[ 0 ], var_c4e64499999d2417[ 1 ], hermes getcentroid()[ 2 ] );
    impact_point = averagepoint( [ var_c4e64499999d2417, closest_point_on_vehicle ] );
    
    /#
        if ( function_d0af3b3dd125072e() )
        {
            sphere( impact_point, 15, ( 1, 0, 0 ) );
            print3d( impact_point, "<dev string:x1c4>", ( 1, 0, 0 ) );
            line( var_c4e64499999d2417, closest_point_on_vehicle, ( 1, 0, 0 ) );
            line( var_c4e64499999d2417, hermes getcentroid(), ( 1, 0, 0 ), 0.3 );
            line( closest_point_on_vehicle, vehicle getcentroid(), ( 1, 0, 0 ), 0.3 );
        }
    #/
    
    return impact_point;
}

// Namespace zombie_hermes_vehicle
// Params 3, eflags: 0x4
// Checksum 0x4c246444, Offset: 0x24e2
// Size: 0xf2
function private function_df6d74a07cd9e01a( hermes, vehicle, var_88839c319e8d83bd )
{
    scriptable_def = hermes.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_21d5352af4a1a4b;
    
    if ( !isdefined( scriptable_def ) )
    {
        return;
    }
    
    impact_point = calculate_impact_point( hermes, vehicle );
    impact_scriptable = spawnscriptable( scriptable_def, impact_point, ( 0, 0, 0 ) );
    
    if ( !isdefined( impact_scriptable ) )
    {
        return;
    }
    
    state = "explode_small";
    
    if ( vehicle utility::ent_flag( "aetheric_energy_imbued" ) )
    {
        state = "explode_aetheric_energy";
    }
    else if ( vehicle isboosting() )
    {
        state = "explode_boost";
    }
    else if ( var_88839c319e8d83bd )
    {
        state = "explode_large";
    }
    
    impact_scriptable utility::function_7c10ea82c1e305b8( "base", state );
    wait 5;
    
    if ( isdefined( impact_scriptable ) )
    {
        impact_scriptable freescriptable();
    }
}

// Namespace zombie_hermes_vehicle
// Params 5, eflags: 0x4
// Checksum 0x7f4b48c3, Offset: 0x25dc
// Size: 0x21a
function private function_56337bdeece45a8e( hermes, vehicle, var_88839c319e8d83bd, is_boosting, dmg_struct )
{
    if ( !is_boosting && !vehicle utility::ent_flag( "aetheric_energy_imbued" ) )
    {
        return;
    }
    
    if ( hermes utility::ent_flag( "hermes_beaming" ) )
    {
        return;
    }
    
    if ( !isalive( hermes ) )
    {
        return;
    }
    
    vehicle_dir = vectornormalize( vehicle vehicle_getvelocity() );
    vehicle_center = vehicle getcentroid();
    projection_dist = 500;
    detection_radius = 150;
    head = dmg_struct.metabonename ?? zombie_hermes_metabones::function_778957e7241af296( dmg_struct, vehicle_center, vehicle_dir, projection_dist, detection_radius );
    
    if ( !head )
    {
        return;
    }
    
    head_tag = zombie_hermes_metabones::get_head_tag( head );
    var_f06c3d8143b76949 = hermes gettagorigin( head_tag );
    head_yaw = vectortoyaw( var_f06c3d8143b76949 - hermes getcentroid() );
    new_yaw = vectortoyaw( hermes.hermes_velocity * -1 );
    new_yaw = angleclamp( new_yaw - head_yaw );
    var_3effc124ba9a831a = [];
    var_3effc124ba9a831a[ "head" ] = head;
    head_alias = hermes function_805ca5e408d630c0( hermes.animsetname, "impact", var_3effc124ba9a831a );
    hermes function_695b8e1b655c2796( "head", head_alias );
    hermes.var_31dccc1abe7714d0 = gettime();
    hermes asm::function_7256f5ba459c840b( "impact_in" );
    hermes zombie_hermes_summon::function_4862cc542f273305( self, "head_middle_le", 1 );
    hermes zombie_hermes_summon::function_4862cc542f273305( self, "head_middle_ri", 1 );
    
    /#
        if ( function_d0af3b3dd125072e() )
        {
            line( hermes getcentroid(), var_f06c3d8143b76949, ( 0, 0, 1 ) );
            print3d( var_f06c3d8143b76949, "<dev string:x1cb>" + head, ( 0, 0, 1 ) );
        }
    #/
    
    wait 4;
    hermes zombie_hermes_summon::function_4862cc542f273305( self, "head_middle_le", 0 );
    hermes zombie_hermes_summon::function_4862cc542f273305( self, "head_middle_ri", 0 );
}

// Namespace zombie_hermes_vehicle
// Params 2
// Checksum 0x7e9cac7e, Offset: 0x27fe
// Size: 0x20f
function function_14dc876b923f0ccd( hermes, var_31102a7982c7e389 )
{
    self endon( #"death" );
    self waittill( #"collision", body0, body1, flag0, flag1, position, normal, impulse, ent, collzone );
    self vehphys_impulse( ( 0, 0, 1 ), 255, 1 );
    earthquake( 1, 0.5, position, 2000 );
    self.health = 50;
    self dodamage( 1, position, hermes, hermes, "MOD_IMPACT" );
    utility::function_32b24db3127bff40( "hermes_ufo", "off" );
    var_fdc5e4472f1e2a76 = hermes function_f017e352a29a57a1( position, 700 );
    
    foreach ( enemy in var_fdc5e4472f1e2a76 )
    {
        if ( isplayer( enemy ) )
        {
            enemy_dist = distance( enemy.origin, position );
            enemy playrumbleonentity( "heavy_1s" );
            var_f36ebd40103c13a5 = vectordot( enemy.origin - position, var_31102a7982c7e389 ) > 0;
            radius_check = 400;
            
            if ( var_f36ebd40103c13a5 )
            {
                radius_check = 600;
            }
            
            if ( enemy_dist < radius_check )
            {
                enemy dodamage( 100, position, hermes, hermes, "MOD_IMPACT" );
                knockback_dir = vectornormalize( enemy.origin - position );
                knockback_dir = math::function_235fe1fdb403e4b2( knockback_dir, 45 );
                enemy knockback( knockback_dir, 700, 1 );
            }
        }
    }
}

// Namespace zombie_hermes_vehicle
// Params 2, eflags: 0x4
// Checksum 0xacdcecce, Offset: 0x2a15
// Size: 0xce
function private knockback_nearby_ai( hermes, vehicle )
{
    if ( !vehicle utility::ent_flag( "aetheric_energy_imbued" ) )
    {
        return;
    }
    
    impact_pos = calculate_impact_point( hermes, vehicle );
    nearby_ai = getaiarrayinradius( impact_pos, 500 );
    
    foreach ( ai in nearby_ai )
    {
        if ( isalive( ai ) )
        {
            ai zombie_knockdown::function_6fc167d4a3590991( impact_pos, 200, 45 );
        }
        
        waitframe();
    }
}

// Namespace zombie_hermes_vehicle
// Params 1, eflags: 0x4
// Checksum 0xcb677157, Offset: 0x2aeb
// Size: 0xc6
function private hermes_on_player_damaged( params )
{
    if ( isai( params.eattacker ) && params.eattacker.subclass == "zombie_hermes" )
    {
        if ( self.vehicle && self isinvehicleleanout() && !utility::ent_flag( "hermes_leanout_danger" ) )
        {
            var_2473d656b09d6dd4 = self.health / self.maxhealth <= 0.5;
            
            if ( var_2473d656b09d6dd4 )
            {
                utility::ent_flag_set( "hermes_leanout_danger" );
                thread utility::ent_flag_clear_delayed( "hermes_leanout_danger", 40 );
                utility::ent_flag_set( "hermes_vehice_passenger_safe_from_damage" );
                thread utility::ent_flag_clear_delayed( "hermes_vehice_passenger_safe_from_damage", 5 );
                self function_489f17e5a9fe932a();
            }
        }
    }
}

// Namespace zombie_hermes_vehicle
// Params 0, eflags: 0x4
// Checksum 0x7b202917, Offset: 0x2bb9
// Size: 0x12, Type: bool
function private function_d0af3b3dd125072e()
{
    return getdvarint( @"hash_15f0d99249b5a47b", 0 ) > 0;
}

/#

    // Namespace zombie_hermes_vehicle
    // Params 0, eflags: 0x4
    // Checksum 0xdae8711b, Offset: 0x2bd4
    // Size: 0x59, Type: dev
    function private function_72d0a2d25adc068d()
    {
        devgui::function_9082edeb5db93280( "<dev string:x1d6>" );
        devgui::add_devgui_func( "<dev string:x1ee>", "<dev string:x1fc>", &function_11b5dc638bc68e95, 1 );
        devgui::add_devgui_func( "<dev string:x211>", "<dev string:x22e>", &function_fde4952944814a37, 1 );
        devgui::function_77df7fe7dd273e10();
        
        if ( function_d0af3b3dd125072e() )
        {
            level thread function_5349248757cb2210();
        }
    }

    // Namespace zombie_hermes_vehicle
    // Params 1, eflags: 0x4
    // Checksum 0x6fdd0db9, Offset: 0x2c35
    // Size: 0x44, Type: dev
    function private function_11b5dc638bc68e95( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x252>", @"hash_15f0d99249b5a47b" );
        
        if ( function_d0af3b3dd125072e() )
        {
            level thread function_5349248757cb2210();
            return;
        }
        
        level notify( #"hash_14799791fcda75b" );
    }

    // Namespace zombie_hermes_vehicle
    // Params 0, eflags: 0x4
    // Checksum 0x126ef4d, Offset: 0x2c81
    // Size: 0x17, Type: dev
    function private function_fde4952944814a37()
    {
        function_3b32534d6bc6f915( level.players[ 0 ] );
    }

    // Namespace zombie_hermes_vehicle
    // Params 0, eflags: 0x4
    // Checksum 0x8e1041b9, Offset: 0x2ca0
    // Size: 0x52, Type: dev
    function private function_5349248757cb2210()
    {
        level endon( #"hash_14799791fcda75b" );
        
        while ( true )
        {
            hermes = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x267>" );
            
            if ( !isdefined( hermes ) )
            {
                waitframe();
                continue;
            }
            
            waitframe();
        }
    }

    // Namespace zombie_hermes_vehicle
    // Params 2, eflags: 0x4
    // Checksum 0x40b26fdf, Offset: 0x2cfa
    // Size: 0x54, Type: dev
    function private print_vehicle( text, col )
    {
        if ( !isdefined( col ) )
        {
            col = ( 1, 0, 0 );
        }
        
        if ( function_d0af3b3dd125072e() )
        {
            print3d( self.origin + ( 0, 0, 70 ), text, col );
        }
    }

#/
