// scripts\mp\zm\zm_vehicle_ai_interact.gsc  (hash_18bb3fe62d9b28f2.gscc) (size: 6141 Bytes / 0x17fd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xddeb17a2 (3723171746)
// size ...... 6141 (0x17fd)
// includes .. 11  (offset: 0x174d)
// strings ... 5   (offset: 0x17a5)
// dev strs .. 2   (offset: 0x17e5)
// exports ... 17  (offset: 0xd31)
// cseg ...... 0xb9 + 0xc78 (0xd31)
// imports ... 65  (offset: 0xfd9)
// animtree1 . 0   (offset: 0x17fd)
// animtree2 . 0   (offset: 0x17fd)
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_vehicle_attack;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\common\utility\player;
#using scripts\mp\zm\zm_utility;

#namespace zm_vehicle_ai_interact;

// Namespace zm_vehicle_ai_interact
// Params 0
// Checksum 0x896f61df, Offset: 0xd7
// Size: 0x59
function init()
{
    utility::registersharedfunc( #"vehicle", #"initAIAvoidance", &init_vehicle_ai_avoidance );
    callback::add( #"vehicle_create", &on_vehicle_create );
    level.modeallowmeleevehicledamage = &zm_allow_melee_vehicle_damage;
    level.zm_vehicle_attractor_update_throttle = throttle::throttle_initialize( "zm_vehicle_attractor_update", 1 );
}

// Namespace zm_vehicle_ai_interact
// Params 1, eflags: 0x4
// Checksum 0x2afc62ab, Offset: 0x138
// Size: 0xe, Type: bool
function private zm_allow_melee_vehicle_damage( data )
{
    return true;
}

// Namespace zm_vehicle_ai_interact
// Params 0, eflags: 0x4
// Checksum 0x8186b242, Offset: 0x14f
// Size: 0xfe
function private function_6c92769d6d2c3200()
{
    self endon( #"death" );
    
    while ( true )
    {
        nearby_characters = utility::charactersnear( self.origin, self.var_183d02c9ee4eaa73.var_4ed16f63a0d8c094 );
        nearby_players = [];
        nearby_agents = [];
        
        foreach ( character in nearby_characters )
        {
            if ( isplayer( character ) )
            {
                nearby_players[ nearby_players.size ] = character;
                continue;
            }
            
            nearby_agents[ nearby_agents.size ] = character;
        }
        
        function_f6fd9116eab57de4( nearby_players );
        function_83ee25b7e5d51623( nearby_agents );
        throttle::throttle_wait_in_queue( level.zm_vehicle_attractor_update_throttle, self );
    }
}

// Namespace zm_vehicle_ai_interact
// Params 1, eflags: 0x4
// Checksum 0xb5965006, Offset: 0x255
// Size: 0xf4
function private function_f6fd9116eab57de4( nearby_players )
{
    should_attract = 0;
    vehicle_occupants = arraycopy( vehicle_occupancy::get_all_occupants( self ) );
    
    if ( vehicle_occupants.size > 0 )
    {
        should_attract = 1;
    }
    else
    {
        vehicle_occupants = [];
    }
    
    foreach ( player in nearby_players )
    {
        if ( !isalive( player ) || player::isinlaststand( player ) )
        {
            continue;
        }
        
        if ( vehicle_occupancy::function_dbf7952d671b64c( player, self ) )
        {
            should_attract = 1;
            vehicle_occupants[ vehicle_occupants.size ] = player;
        }
    }
    
    if ( should_attract )
    {
        thread create_global_attractor( vehicle_occupants );
        return;
    }
    
    self notify( #"remove_global_attractor" );
}

// Namespace zm_vehicle_ai_interact
// Params 1, eflags: 0x4
// Checksum 0x84c7cab2, Offset: 0x351
// Size: 0x155
function private function_83ee25b7e5d51623( nearby_agents )
{
    local_attractor = self.var_183d02c9ee4eaa73.local;
    local_attractor.tracked_agents = function_46f9072493651dc9( local_attractor.tracked_agents );
    
    foreach ( agent in nearby_agents )
    {
        if ( !isalive( agent ) || !isdefined( agent.team ) || agent.team != zm_utility::get_zombie_team() )
        {
            continue;
        }
        
        if ( getdvarint( @"hash_68e4237d7c1e2747", 1 ) > 0 && agent.enablemelee )
        {
            agent._blackboard.var_af89f4337e753eb4 = 1;
        }
        
        if ( !arraycontains( local_attractor.tracked_agents, agent ) )
        {
            local_attractor.tracked_agents[ local_attractor.tracked_agents.size ] = agent;
            thread function_a1752406f97ea6b7( agent );
        }
    }
}

// Namespace zm_vehicle_ai_interact
// Params 1, eflags: 0x4
// Checksum 0x3d225c5b, Offset: 0x4ae
// Size: 0xe1
function private on_vehicle_create( params )
{
    vehicle = params.vehicle;
    
    if ( !isalive( vehicle ) || vehicle vehicle::is_husk() )
    {
        return;
    }
    
    vehicle_bounds = vehicle getboundshalfsize();
    var_4ed16f63a0d8c094 = max( vehicle_bounds[ 0 ], vehicle_bounds[ 1 ] ) + 32;
    vehicle.var_183d02c9ee4eaa73 = spawnstruct();
    vehicle.var_183d02c9ee4eaa73.var_4ed16f63a0d8c094 = var_4ed16f63a0d8c094;
    vehicle.var_183d02c9ee4eaa73.global = { #var_112369a470e1652:[] };
    vehicle.var_183d02c9ee4eaa73.local = { #tracked_agents:[] };
    vehicle thread function_6c92769d6d2c3200();
    
    /#
        vehicle thread debug_vehicle_zombie_attractor();
    #/
}

// Namespace zm_vehicle_ai_interact
// Params 2, eflags: 0x4
// Checksum 0xdde198aa, Offset: 0x597
// Size: 0x58
function private function_891dca9941885be( vehicle, scalar = 1 )
{
    boundshalfsize = vehicle getboundshalfsize() * scalar;
    return math::function_1243a6cc6a030f2a( self.origin, vehicle getcentroid(), boundshalfsize, vehicle.angles );
}

// Namespace zm_vehicle_ai_interact
// Params 2, eflags: 0x4
// Checksum 0x2c7b51f5, Offset: 0x5f8
// Size: 0x6e
function private vehicle_goal_location( attractor, zombie )
{
    goal_location = zombie function_891dca9941885be( attractor.source );
    
    /#
        if ( getdvarint( @"hash_bbaa0de578f233b", 0 ) )
        {
            debugstar( goal_location, ( 0, 0, 1 ), int( 1 / level.framedurationseconds ) );
        }
    #/
    
    return goal_location;
}

// Namespace zm_vehicle_ai_interact
// Params 2, eflags: 0x4
// Checksum 0x7117170a, Offset: 0x66f
// Size: 0x3b
function private function_dc06c02d02fdb1d3( attractor, zombie )
{
    goal_location = zombie function_891dca9941885be( attractor.source, 0.75 );
    return goal_location;
}

// Namespace zm_vehicle_ai_interact
// Params 2, eflags: 0x4
// Checksum 0x644d606f, Offset: 0x6b3
// Size: 0x16c, Type: bool
function private function_3f09c9df87900dee( attractor, zombie )
{
    if ( !zombie.enablemelee )
    {
        return false;
    }
    
    var_f792509d72a84f58 = zombie.enemy;
    
    if ( zombie zombie_vehicle_attack::is_vehicle_attack_enabled() && isdefined( var_f792509d72a84f58 ) && var_f792509d72a84f58 vehicle::is_in_vehicle() )
    {
        return false;
    }
    
    vehicle = attractor.source;
    global_attractor = vehicle.var_183d02c9ee4eaa73.global;
    
    if ( global_attractor.instance === attractor )
    {
        if ( !isdefined( var_f792509d72a84f58 ) )
        {
            return false;
        }
        
        if ( !arraycontains( global_attractor.var_112369a470e1652, var_f792509d72a84f58 ) )
        {
            return false;
        }
    }
    
    if ( isdefined( var_f792509d72a84f58 ) && distancesquared( zombie.origin, var_f792509d72a84f58.origin ) < 4096 )
    {
        return false;
    }
    
    if ( zombie getgroundentity() === vehicle )
    {
        return false;
    }
    
    if ( vehicle utility::function_9f2c41c1dcc8c94( "single", "vehicle_unusable" ) )
    {
        return false;
    }
    
    closest_point = zombie function_891dca9941885be( vehicle );
    reachable_point = zombie getclosestreachablepointonnavmesh( closest_point );
    
    if ( distancesquared( closest_point, reachable_point ) > 1024 )
    {
        return false;
    }
    
    other_ai = getaiarrayinradius( reachable_point, 32 );
    other_ai = arrayremove( other_ai, zombie );
    
    if ( other_ai.size > 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_vehicle_ai_interact
// Params 1, eflags: 0x4
// Checksum 0x8bd84ad8, Offset: 0x828
// Size: 0xba
function private create_global_attractor( var_112369a470e1652 )
{
    global_attractor = self.var_183d02c9ee4eaa73.global;
    
    if ( isdefined( global_attractor.instance ) )
    {
        return;
    }
    
    var_183d02c9ee4eaa73 = level zombie_attractor_manager::add_attractor( self, 0, 1000, 1, &vehicle_goal_location, &function_3f09c9df87900dee, undefined, undefined, undefined, &function_dc06c02d02fdb1d3 );
    global_attractor.instance = var_183d02c9ee4eaa73;
    global_attractor.var_112369a470e1652 = var_112369a470e1652;
    utility::waittill_any( "death", "remove_global_attractor" );
    
    if ( isdefined( var_183d02c9ee4eaa73 ) )
    {
        level zombie_attractor_manager::remove_attractor( var_183d02c9ee4eaa73 );
    }
    
    global_attractor.instance = undefined;
    global_attractor.var_112369a470e1652 = [];
}

// Namespace zm_vehicle_ai_interact
// Params 1, eflags: 0x4
// Checksum 0xcae2fe3c, Offset: 0x8ea
// Size: 0x19b
function private function_a1752406f97ea6b7( zombie )
{
    zombie endon( #"death" );
    stuck_check = 0;
    check_range_squared = squared( self.var_183d02c9ee4eaa73.var_4ed16f63a0d8c094 );
    
    while ( isdefined( self ) && distancesquared( zombie.origin, self.origin ) <= check_range_squared )
    {
        if ( zombie codemoverequested() && lengthsquared( zombie.velocity ) >= 400 )
        {
            var_ad66de543062a7fe = zombie.origin;
            wait 1;
            
            if ( distancesquared( zombie.origin, var_ad66de543062a7fe ) <= 100 )
            {
                stuck_check++;
                
                if ( isdefined( self ) && stuck_check >= 2 )
                {
                    /#
                        if ( getdvarint( @"hash_bbaa0de578f233b", 0 ) )
                        {
                            debugstar( zombie.origin, ( 1, 1, 0 ), int( 4 / level.framedurationseconds ), "<dev string:x24>" + zombie getentitynumber() + "<dev string:x27>" );
                        }
                    #/
                    
                    zombie function_f906645b42ecb2f7( self, 4 );
                }
                else
                {
                    continue;
                }
            }
            
            stuck_check = 0;
            continue;
        }
        
        stuck_check = 0;
        wait 0.1;
    }
    
    if ( isdefined( self ) && isdefined( self.var_183d02c9ee4eaa73 ) && isdefined( zombie ) )
    {
        self.var_183d02c9ee4eaa73.local.tracked_agents = arrayremove( self.var_183d02c9ee4eaa73.local.tracked_agents, zombie );
    }
}

// Namespace zm_vehicle_ai_interact
// Params 2, eflags: 0x4
// Checksum 0xe82cb4f4, Offset: 0xa8d
// Size: 0x9a
function private function_f906645b42ecb2f7( vehicle, time )
{
    if ( isdefined( self.vehicle_attractor ) )
    {
        return;
    }
    
    vehicle_attractor = zombie_attractor_manager::function_7eb1aaa8bc7cc15( vehicle, 0, vehicle.var_183d02c9ee4eaa73.var_4ed16f63a0d8c094, 1, &vehicle_goal_location, &function_3f09c9df87900dee, undefined, undefined, undefined, &function_dc06c02d02fdb1d3 );
    self.vehicle_attractor = vehicle_attractor;
    vehicle utility::waittill_notify_or_timeout( "death", time );
    
    if ( isdefined( self ) && isdefined( vehicle_attractor ) )
    {
        zombie_attractor_manager::function_dcfb4c31f1d97cd2( vehicle_attractor );
        self.vehicle_attractor = undefined;
    }
}

// Namespace zm_vehicle_ai_interact
// Params 0, eflags: 0x4
// Checksum 0xbea60489, Offset: 0xb2f
// Size: 0x3e
function private function_661a2de9ed067b71()
{
    self waittill( #"death" );
    
    if ( isdefined( self.navobstacleid ) )
    {
        destroynavobstacle( self.navobstacleid );
        self.navobstacleid = undefined;
    }
    
    self.var_5ffed513f7372301 = undefined;
}

// Namespace zm_vehicle_ai_interact
// Params 0, eflags: 0x4
// Checksum 0x41cb486e, Offset: 0xb75
// Size: 0xe2
function private init_vehicle_ai_avoidance()
{
    self endon( #"death" );
    
    if ( self.var_5ffed513f7372301 )
    {
        return;
    }
    
    self.var_5ffed513f7372301 = 1;
    thread function_661a2de9ed067b71();
    
    while ( true )
    {
        self.navobstacleid = createnavbadplacebyent( self, 14.9 );
        
        for ( var_4205fc59322fea8d = self.origin; vehicle_code::vehicle_is_stopped( 1 ) ; var_4205fc59322fea8d = self.origin )
        {
            wait 0.5;
            
            if ( lengthsquared( self.origin - var_4205fc59322fea8d ) > 56.25 )
            {
                self.navobstacleid = function_793ef7e253521eac( self, 14.9 );
            }
        }
        
        if ( isdefined( self.navobstacleid ) )
        {
            destroynavobstacle( self.navobstacleid );
            self.navobstacleid = undefined;
        }
        
        while ( !vehicle_code::vehicle_is_stopped( 1 ) )
        {
            wait 0.1;
        }
    }
}

/#

    // Namespace zm_vehicle_ai_interact
    // Params 0, eflags: 0x4
    // Checksum 0xa2c52e9e, Offset: 0xc5f
    // Size: 0xd2, Type: dev
    function private debug_vehicle_zombie_attractor()
    {
        self endon( #"death" );
        global_attractor = self.var_183d02c9ee4eaa73.global;
        
        while ( true )
        {
            if ( getdvarint( @"hash_bbaa0de578f233b", 0 ) )
            {
                sphere( self.origin, self.var_183d02c9ee4eaa73.var_4ed16f63a0d8c094, ( 1, 1, 1 ), 1 );
                
                if ( isdefined( global_attractor.instance ) )
                {
                    sphere( self.origin, 1000, ( 1, 0, 0 ), 1 );
                    debugstar( self.origin, ( 1, 0, 0 ), 1, global_attractor.var_112369a470e1652.size );
                }
            }
            
            waitframe();
        }
    }

#/
