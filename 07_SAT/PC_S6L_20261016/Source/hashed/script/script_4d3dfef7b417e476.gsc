// script_4d3dfef7b417e476  (hash_4d3dfef7b417e476.gscc) (size: 9903 Bytes / 0x26af / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x12bf6806 (314533894)
// size ...... 9903 (0x26af)
// includes .. 10  (offset: 0x23eb)
// strings ... 43  (offset: 0x243b)
// dev strs .. 1   (offset: 0x26a3)
// exports ... 22  (offset: 0x15db)
// cseg ...... 0x348 + 0x1293 (0x15db)
// imports ... 90  (offset: 0x194b)
// animtree1 . 0   (offset: 0x26af)
// animtree2 . 0   (offset: 0x26af)
#using script_16ea1b94f0f381b3;
#using script_5dc2c78e95ce5a77;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\zombie_callisto\zombie_callisto_wound;
#using scripts\common\callbacks;
#using scripts\common\shellshock_utility;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;

#namespace namespace_c03bf35905186301;

// Namespace namespace_c03bf35905186301
// Params 0
// Checksum 0x5ed85565, Offset: 0x366
// Size: 0x22
function function_f3e294e7b0c8a1b4()
{
    callback::get_template( self.animsetname ) callback::add( "on_in_vehicle_mode_changed", &function_94abad4e4ce0ddd8 );
}

// Namespace namespace_c03bf35905186301
// Params 0
// Checksum 0x9b97319c, Offset: 0x390
// Size: 0x10
function init_zombie_callisto_charge()
{
    function_13845d2df2ccf948();
    thread function_fd3137880ce9e5d3();
}

// Namespace namespace_c03bf35905186301
// Params 1, eflags: 0x4
// Checksum 0x5e7b6b55, Offset: 0x3a8
// Size: 0x13
function private function_94abad4e4ce0ddd8( params )
{
    function_13845d2df2ccf948();
}

// Namespace namespace_c03bf35905186301
// Params 0, eflags: 0x4
// Checksum 0x430a2717, Offset: 0x3c3
// Size: 0x55
function private function_13845d2df2ccf948()
{
    featurearray = [];
    featurearray[ "vehicle_mode" ] = istrue( self getaiblackboarddynamic( "in_vehicle_attack_mode" ) );
    alias = self function_805ca5e408d630c0( self.animsetname, "charge_loop", featurearray, 0 );
    
    if ( isdefined( alias ) )
    {
        self function_695b8e1b655c2796( "charge_loop", alias );
    }
}

// Namespace namespace_c03bf35905186301
// Params 0, eflags: 0x4
// Checksum 0xe74561de, Offset: 0x420
// Size: 0x83
function private function_fd3137880ce9e5d3()
{
    self endon( #"death" );
    
    while ( true )
    {
        msg = utility::waittill_any_return( "start_charge_loop", "stop_charge_loop", "stop_charge" );
        
        switch ( msg )
        {
            case #"hash_e81ec9320281e1e7":
                start_charge_loop();
                break;
            case #"hash_d64e26569fa15bf1":
                stop_charge_loop();
                break;
            case #"hash_a8ea32669c6be46e":
                stop_charge();
                break;
        }
    }
}

// Namespace namespace_c03bf35905186301
// Params 0, eflags: 0x4
// Checksum 0x6db46195, Offset: 0x4ab
// Size: 0x32
function private start_charge_loop()
{
    self.charge_anim_mode = "gravity";
    self function_786bb6aa1b76c7ee( "in_charge_loop", 1 );
    thread function_c708f9d4c9a22254();
    thread function_14182bbdc0c97554();
    thread function_ecf055c7d55f40ae();
}

// Namespace namespace_c03bf35905186301
// Params 0, eflags: 0x4
// Checksum 0xad5bee6, Offset: 0x4e5
// Size: 0x4a
function private stop_charge_loop()
{
    self notify( #"charge_stop" );
    self.charge_anim_mode = undefined;
    self notify( #"track_charge_end" );
    self function_786bb6aa1b76c7ee( "in_charge_loop", 0 );
    self clearpath();
    self clearbtgoal( 0 );
    self setbtgoalstationary( 0 );
    self forceupdategoalpos();
}

// Namespace namespace_c03bf35905186301
// Params 0, eflags: 0x4
// Checksum 0x24bf77bd, Offset: 0x537
// Size: 0x14
function private stop_charge()
{
    namespace_7bf9c7d90634c36f::stop_charge();
    self function_f2df0257c63f229( "charge_hit_result" );
}

// Namespace namespace_c03bf35905186301
// Params 0, eflags: 0x4
// Checksum 0x8de6e840, Offset: 0x553
// Size: 0x5f
function private function_c708f9d4c9a22254()
{
    self endon( #"death" );
    utility::function_32b24db3127bff40( "charge_audio", "charge_audio_start" );
    utility::function_32b24db3127bff40( "charge_vfx", "charge_vfx_on" );
    self waittill( #"charge_stop" );
    utility::function_32b24db3127bff40( "charge_audio", "charge_audio_stop" );
    utility::function_32b24db3127bff40( "charge_vfx", "charge_vfx_off" );
}

// Namespace namespace_c03bf35905186301
// Params 0, eflags: 0x4
// Checksum 0xc9c2fd10, Offset: 0x5ba
// Size: 0x14d
function private function_ecf055c7d55f40ae()
{
    self endon( #"death" );
    self endon( #"charge_stop" );
    
    while ( true )
    {
        if ( !isalive( self.charge_target ) )
        {
            break;
        }
        
        charge_previous_pos = self.origin;
        wait 0.2;
        
        if ( !isdefined( self.charge_start_loc ) )
        {
            break;
        }
        
        charge_delta = self.origin - charge_previous_pos;
        charge_speed = length2d( charge_delta ) / 0.2;
        
        if ( charge_speed <= 7.5 )
        {
            break;
        }
        
        charge_vector = self.origin - self.charge_start_loc;
        charge_direction = vectornormalize( charge_vector );
        charged_distance = vectordot( charge_vector, charge_direction );
        
        if ( charged_distance < 100 )
        {
            continue;
        }
        
        if ( vectordot( charge_direction, charge_delta ) < 0 )
        {
            break;
        }
        
        if ( isalive( self.charge_target ) )
        {
            var_4c6b5564f4bf8f0e = charged_distance - vectordot( self.charge_target.origin - self.charge_start_loc, charge_direction );
            
            if ( var_4c6b5564f4bf8f0e > self.var_8d3ea37f47898ea )
            {
                break;
            }
        }
    }
    
    namespace_7bf9c7d90634c36f::stop_charge();
}

// Namespace namespace_c03bf35905186301
// Params 3, eflags: 0x4
// Checksum 0x3e7f3d84, Offset: 0x70f
// Size: 0x64
function private function_981ed5bd71913a88( start_pos, distscale = 0.2, overridedistance )
{
    if ( overridedistance )
    {
        probe_point = start_pos + vectornormalize( self.velocity ) * overridedistance;
    }
    else
    {
        probe_point = start_pos + self.velocity * distscale;
    }
    
    return probe_point;
}

// Namespace namespace_c03bf35905186301
// Params 2, eflags: 0x4
// Checksum 0x80dfd980, Offset: 0x77c
// Size: 0x39
function private function_a6fa419898ee6a5( flag, time )
{
    self endon( #"death" );
    utility::ent_flag_set( flag );
    self endon( flag );
    utility::ent_flag_clear_delayed( flag, time );
}

// Namespace namespace_c03bf35905186301
// Params 1, eflags: 0x4
// Checksum 0x3b7bfd32, Offset: 0x7bd
// Size: 0x13d
function private damage_vehicles( start_pos )
{
    hit_vehicle = 0;
    end_pos = function_981ed5bd71913a88( start_pos, 1, 200 );
    forward_vehicles = vehicle_getarrayinradius( end_pos, 256, self.height );
    
    if ( forward_vehicles.size > 0 )
    {
        half_size = self getboundshalfsize();
        vehicle_trace_start = start_pos;
        vehicle_trace_end = end_pos;
        var_b780695a1a999733 = half_size[ 2 ] * 0.4;
        right = anglestoright( self.angles );
        left = right * -1;
        hit_vehicle = function_4aebe7caba1b646d( vehicle_trace_start + right * var_b780695a1a999733, vehicle_trace_end + right * var_b780695a1a999733 );
        
        if ( !hit_vehicle )
        {
            hit_vehicle = function_4aebe7caba1b646d( vehicle_trace_start + left * var_b780695a1a999733, vehicle_trace_end + left * var_b780695a1a999733 );
        }
        
        /#
            if ( getdvarint( @"hash_c87d626c9fd11123" ) )
            {
                debug_color = ( 0, 0, 1 );
                cylinder( end_pos, end_pos + ( 0, 0, self.height ), 256, debug_color, 1 );
                print3d( end_pos, "<dev string:x24>" + forward_vehicles.size, debug_color );
            }
        #/
    }
    
    return hit_vehicle;
}

// Namespace namespace_c03bf35905186301
// Params 3, eflags: 0x4
// Checksum 0x2d7afbaa, Offset: 0x903
// Size: 0x1e6, Type: bool
function private function_4aebe7caba1b646d( start, end, half_size )
{
    vehicle_contents = trace::create_vehicle_contents();
    vehicle_trace_result = trace::ray_trace( start, end, self, vehicle_contents );
    vehicle_trace_hit = isdefined( vehicle_trace_result ) && isdefined( vehicle_trace_result[ "entity" ] ) && vehicle_trace_result[ "fraction" ] < 1;
    
    /#
    #/
    
    if ( vehicle_trace_hit )
    {
        vehicle = vehicle_trace_result[ "entity" ];
        
        if ( vehicle vehicle::is_vehicle() && isalive( vehicle ) && vehicle.team != self.team )
        {
            if ( !vehicle utility::ent_flag( "callisto_charge_hit" ) )
            {
                vehicle thread function_a6fa419898ee6a5( "callisto_charge_hit", 2 );
                vehicle_damage = self.var_b234910aee44c0ed;
                
                if ( isdefined( self.var_fe048a2106d8ef00[ #"charge_attack_vehicle" ] ) )
                {
                    vehicle_damage *= self.var_fe048a2106d8ef00[ #"charge_attack_vehicle" ];
                }
                
                vehicle dodamage( vehicle_damage, self.origin, self, self, "MOD_MELEE" );
                center = self getcentroid() + anglestoforward( self.angles ) * 100;
                ai_array = getaiarrayinradius( center, 70 );
                
                foreach ( ai in ai_array )
                {
                    ai notify( #"hash_a0c8fe3d0fbe8d85" );
                }
                
                zombie_callisto_wound::function_afb37cb1e8cf8ab8( center, vehicle );
            }
            
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_c03bf35905186301
// Params 2, eflags: 0x4
// Checksum 0x68710826, Offset: 0xaf2
// Size: 0x7d
function private deal_damage_to_player( player, damage )
{
    /#
        if ( getdvarint( @"hash_d8f381613441add0" ) )
        {
            damage = 999;
        }
    #/
    
    zombie_callisto_wound::apply_wound( player );
    
    if ( isdefined( self.var_fe048a2106d8ef00[ #"charge_attack_player" ] ) )
    {
        damage *= self.var_fe048a2106d8ef00[ #"charge_attack_player" ];
    }
    
    player dodamage( damage, self.origin, self, self, "MOD_IMPACT" );
}

// Namespace namespace_c03bf35905186301
// Params 3, eflags: 0x4
// Checksum 0xea28c10b, Offset: 0xb77
// Size: 0x26e
function private damage_players( damage_point, damage_radius, rumble_radius )
{
    var_b171067dd5489f35 = 0;
    forward_players = namespace_9d8e359c3b1041e5::getplayersinradiussharedfunc( damage_point, max( damage_radius, rumble_radius ) );
    
    if ( forward_players.size > 0 )
    {
        foreach ( player in forward_players )
        {
            if ( !isalive( player ) || player.team == self.team )
            {
                continue;
            }
            
            if ( player vehicle::is_in_vehicle() )
            {
                continue;
            }
            
            player_distance = distance( player.origin, damage_point );
            
            if ( player_distance <= damage_radius )
            {
                var_82f0fb6dc1c89261 = player getcentroid();
                is_unblocked = trace::ray_trace_passed( damage_point + ( 0, 0, self.height * 0.5 ), var_82f0fb6dc1c89261, [ self, player ] );
                
                if ( is_unblocked )
                {
                    if ( !player utility::ent_flag( "callisto_charge_hit" ) )
                    {
                        player thread function_a6fa419898ee6a5( "callisto_charge_hit", 2 );
                        player utility::knockback_flat( player.origin - self.origin, 1200 );
                        player earthquakeforplayer( 0.75, 0.75, damage_point, max( damage_radius, 300 ) );
                        player playrumbleonentity( "heavy_1s" );
                        player thread shellshock_utility::bloodmeleeeffect();
                        player shellshock_utility::_shellshock( %"zm_ai_callisto_stun_shock", #"stun", 2 );
                        player playsound( #"hash_75baefd1c5df2e82" );
                        player callback::callback( #"on_callisto_charge_hit" );
                        deal_damage_to_player( player, self.var_bd3d3ade9537726 );
                    }
                    
                    var_b171067dd5489f35 = 1;
                    continue;
                }
            }
            
            if ( player_distance <= rumble_radius && !player utility::ent_flag( "callisto_charge_rumble" ) )
            {
                player thread function_a6fa419898ee6a5( "callisto_charge_rumble", 2 );
                player playrumbleonentity( "light_1s" );
                player earthquakeforplayer( 0.4, 0.8, damage_point, max( rumble_radius, 300 ) );
            }
        }
    }
    
    return var_b171067dd5489f35;
}

// Namespace namespace_c03bf35905186301
// Params 3, eflags: 0x4
// Checksum 0x6b9671dd, Offset: 0xdee
// Size: 0x266
function private damage_agents( damage_point, damage_radius, var_73ab0f5e7a91fe45 )
{
    hit_elite = 0;
    var_54c59b5c9f12e05c = var_73ab0f5e7a91fe45 * var_73ab0f5e7a91fe45;
    var_cd1222864a31c491 = damage_radius * damage_radius;
    forward_agents = getaiarrayinradius( damage_point, max( damage_radius, var_73ab0f5e7a91fe45 ) );
    
    if ( isalive( self.enemy ) )
    {
        if ( issentient( self.enemy ) && !isai( self.enemy ) )
        {
            disttoenemy = distance( damage_point, self.enemy.origin );
            
            if ( disttoenemy <= damage_radius )
            {
                forward_agents[ forward_agents.size ] = self.enemy;
            }
        }
    }
    
    if ( forward_agents.size > 0 )
    {
        foreach ( agent in forward_agents )
        {
            if ( !isalive( agent ) || agent == self )
            {
                continue;
            }
            
            distance_sqrd = distancesquared( agent.origin, damage_point );
            
            if ( distance_sqrd <= var_54c59b5c9f12e05c )
            {
                if ( agent.type == "zombie" )
                {
                    if ( !agent zombie_knockdown::function_19d6107cb6bdff5c() )
                    {
                        agent zombie_knockdown::function_6fc167d4a3590991( damage_point );
                    }
                }
            }
            
            if ( distance_sqrd <= var_cd1222864a31c491 )
            {
                if ( agent.aicategory == "elite" || agent.aicategory == "hvt" )
                {
                    agent zombie_stun::stun_ai( self.var_6f4ac70819d6c334 );
                    hit_elite = 1;
                }
                
                if ( agent.team != self.team && !agent utility::ent_flag( "callisto_charge_hit" ) )
                {
                    agent thread function_a6fa419898ee6a5( "callisto_charge_hit", 2 );
                    var_2312aa2edb757e61 = self.var_bd3d3ade9537726;
                    
                    if ( isdefined( self.var_fe048a2106d8ef00[ #"charge_attack_player" ] ) )
                    {
                        var_2312aa2edb757e61 *= self.var_fe048a2106d8ef00[ #"charge_attack_player" ];
                    }
                    
                    agent dodamage( var_2312aa2edb757e61, damage_point );
                }
            }
        }
    }
    
    return hit_elite;
}

// Namespace namespace_c03bf35905186301
// Params 0, eflags: 0x4
// Checksum 0x7e286082, Offset: 0x105d
// Size: 0x13b
function private function_14182bbdc0c97554()
{
    self endon( #"death" );
    self endon( #"charge_stop" );
    
    while ( true )
    {
        start_pos = self getcentroid();
        damage_point = function_981ed5bd71913a88( start_pos, 0.25 );
        damage_radius = self.charge_damage_radius;
        rumble_radius = self.var_ad41def0c5c03519;
        var_73ab0f5e7a91fe45 = self.var_52693a700154ae1a;
        hit_vehicle = damage_vehicles( start_pos );
        var_b171067dd5489f35 = damage_players( damage_point, damage_radius, rumble_radius );
        hit_elite = damage_agents( damage_point, damage_radius, var_73ab0f5e7a91fe45 );
        hit_geo = detect_collision( start_pos );
        
        if ( hit_elite )
        {
            self function_786bb6aa1b76c7ee( "charge_hit_result", "hit_stun" );
            handle_charge_stun();
            break;
        }
        else if ( var_b171067dd5489f35 )
        {
            self function_786bb6aa1b76c7ee( "charge_hit_result", "hit" );
            thread function_f9a6d43ca30d145a();
            break;
        }
        else if ( hit_vehicle )
        {
            self function_786bb6aa1b76c7ee( "charge_hit_result", "hit_vehicle" );
            break;
        }
        else if ( hit_geo )
        {
            namespace_7bf9c7d90634c36f::stop_charge();
        }
        
        waitframe();
    }
}

// Namespace namespace_c03bf35905186301
// Params 0, eflags: 0x4
// Checksum 0x633719e5, Offset: 0x11a0
// Size: 0xd9
function private handle_charge_stun()
{
    var_899f13d46cd7e7c8 = 700;
    earthquake( 0.5, 0.4, self.origin, var_899f13d46cd7e7c8 );
    nearby_players = namespace_9d8e359c3b1041e5::getplayersinradiussharedfunc( self.origin, var_899f13d46cd7e7c8 );
    
    foreach ( player in nearby_players )
    {
        player playrumbleonentity( "artillery_rumble_heavy" );
    }
    
    utility::delaythreadendon( 0.1, "death", &utility::function_32b24db3127bff40, "charge_stun", "charge_stun" );
}

// Namespace namespace_c03bf35905186301
// Params 0, eflags: 0x4
// Checksum 0xccec8e8d, Offset: 0x1281
// Size: 0x64
function private function_f9a6d43ca30d145a()
{
    self endon( #"death" );
    self endon( #"stop_charge" );
    self endon( #"charge_end" );
    
    while ( true )
    {
        start_pos = self getcentroid();
        hit_geo = detect_collision( start_pos, 400 );
        
        if ( hit_geo )
        {
            namespace_7bf9c7d90634c36f::stop_charge();
            break;
        }
        
        waitframe();
    }
}

// Namespace namespace_c03bf35905186301
// Params 2, eflags: 0x4
// Checksum 0x13cf2b41, Offset: 0x12ed
// Size: 0x2ed
function private detect_collision( start_pos, override_dist )
{
    hit_geo = 0;
    forward_pos = function_981ed5bd71913a88( start_pos, 0.55, override_dist );
    var_5e1f2ab57fe77082 = utility::drop_to_ground( forward_pos, 200, -200 );
    move_direction = vectornormalize( self.velocity );
    nav_trace_end = var_5e1f2ab57fe77082;
    nav_trace_result = navtrace( self.origin, nav_trace_end, self, 1 );
    nav_trace_hit = nav_trace_result[ "fraction" ] < 1 && isdefined( nav_trace_result[ "normal" ] );
    
    if ( nav_trace_hit )
    {
        disable_ledge_drop = utility::ent_flag( "callisto_charge_disable_ledge_drop" );
        
        if ( !disable_ledge_drop && isdefined( nav_trace_result[ "area_usage_flags" ] ) )
        {
            if ( nav_trace_result[ "area_usage_flags" ] & 262144 )
            {
                disable_ledge_drop = 1;
            }
        }
        
        if ( !disable_ledge_drop && self.charge_anim_mode == "gravity" )
        {
            self animmode( "gravity_off_nav" );
            self.charge_anim_mode = "gravity_off_nav";
        }
        
        hit_dot = vectordot( move_direction, nav_trace_result[ "normal" ] );
        direct_hit = hit_dot < -0.5;
        
        if ( direct_hit )
        {
            physics_trace_start = start_pos;
            physics_trace_end = forward_pos;
            contents = [ "physicscontents_itemclip", "physicscontents_water", "physicscontents_aiclip", "physicscontents_glass" ];
            solid_ai_contents = physics_createcontents( contents );
            physics_trace_results = trace::ray_trace( physics_trace_start, physics_trace_end, self, solid_ai_contents );
            hit_detected = physics_trace_results[ "hittype" ] == "hittype_world" && physics_trace_results[ "fraction" ] < 1;
            
            /#
                if ( getdvarint( @"hash_c87d626c9fd11123" ) )
                {
                    line( physics_trace_start, physics_trace_end, ( 1, 0, 0 ), 1, 0, 30 );
                }
            #/
            
            if ( hit_detected )
            {
                hit_geo = 1;
            }
        }
    }
    else if ( self.charge_anim_mode == "gravity_off_nav" )
    {
        var_5c613caa0759e95d = self isonground() && ispointonnavmesh( self.origin, self, 1 );
        
        if ( var_5c613caa0759e95d || utility::ent_flag( "callisto_charge_disable_ledge_drop" ) )
        {
            self animmode( "gravity" );
            self.charge_anim_mode = "gravity";
        }
    }
    
    /#
        if ( getdvarint( @"hash_c87d626c9fd11123" ) )
        {
            debug_color = nav_trace_hit ? direct_hit ? ( 1, 0, 0 ) : ( 1, 1, 0 ) : ( 0, 1, 0 );
            utility::draw_arrow( var_5e1f2ab57fe77082, nav_trace_end, debug_color, 1, 0 );
        }
    #/
    
    return hit_geo;
}

