// script_1d947a67914036d6  (hash_1d947a67914036d6.gscc) (size: 12516 Bytes / 0x30e4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3611fd83 (907148675)
// size ...... 12516 (0x30e4)
// includes .. 5   (offset: 0x2f04)
// strings ... 25  (offset: 0x2f2c)
// dev strs .. 6   (offset: 0x309c)
// exports ... 32  (offset: 0x1f60)
// cseg ...... 0x1e9 + 0x1d77 (0x1f60)
// imports ... 88  (offset: 0x2460)
// animtree1 . 0   (offset: 0x30e4)
// animtree2 . 0   (offset: 0x30e4)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\math;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_aeon_flame_tornado;

// Namespace zombie_aeon_flame_tornado
// Params 1
// Checksum 0x6fe34288, Offset: 0x207
// Size: 0x84
function precache( aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( !isdefined( settings ) )
    {
        return;
    }
    
    utility::add_fx( "aeon_lightning_air_beam_fx", settings.var_43278f7b7eb7d95c );
    utility::add_fx( "aeon_lightning_ground_beam_fx", settings.var_7e1c0ebef933fdc5 );
    utility::add_fx( "aeon_lightning_cloud_fx", settings.var_6aad9b569827cd57 );
    utility::add_fx( "aeon_lightning_danger_fx", settings.var_29b7466f5f846385 );
}

// Namespace zombie_aeon_flame_tornado
// Params 0
// Checksum 0x656b1e29, Offset: 0x293
// Size: 0x2b1
function init_zombie_aeon_flame_tornado()
{
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    self.var_5882e5e64b6302a7 = [];
    self.var_a8740501b4b2341d = settings.tornadolifetime;
    self.tornado_cooldown_s = settings.tornadocooldown;
    self.var_a67857a3fa174b79 = settings.var_ade159a6b27ffd4f;
    self.var_edc867ae18c479e2 = settings.var_25e7d039e22982a2;
    self.var_2beb6141e3ce659e = settings.var_eaf867b988ca366d;
    self.var_51d75edb71552fcc = settings.var_9b710b212c80d63c;
    self.var_a221500bc6423651 = squared( settings.tornadodamageradius );
    self.var_283013fea80042cf = settings.var_dd99906788c15b95 ?? 300;
    self.var_7ae6ecea390c6778 = squared( self.var_283013fea80042cf );
    self.var_b263d8f01cb56381 = settings.var_e6a8c182f0e6901d;
    self.tornado_damage_player = settings.var_b29749631d9f0bff * 0.5;
    self.var_304cb68d55c81b28 = squared( settings.var_a4af7d404c2a92a5 );
    self.var_1e0e473fc77a1461 = [ settings.var_b90a70db81c84c0d, settings.var_b90a6ddb81c84574, settings.var_b90a6edb81c847a7 ];
    self.var_9b008da44e591709 = settings.var_fe12bfa8542e7e5d ?? 500;
    self.var_18d0e3dfbddd2707 = settings.var_9a1d4ab1db3bd7af ?? 2000;
    self.var_898f423f55f0bccf = settings.var_ea022a0944ad3fcc ?? 0.5;
    self.var_ce4ef88711fac0d9 = settings.var_adca1a32a7df5d82 ?? 1.5;
    self.var_2128f88ab96db134 = settings.var_988e1bfb776e699b ?? 3;
    self.var_5ba0b6dc6ed52f5d = settings.var_d9037c74882a3b18 ?? 0.25;
    self.tornado_slow_rate = settings.var_f2cfcf474f508c9c ?? 0.6;
    self.var_ec27eae9ef025773 = settings.var_3a5a42d20f66895b ?? 1;
    self.var_7ff307fb172e4d11 = settings.var_c4bd7e49583497f4 ?? 300;
    self.var_ec21413753af15ac = settings.var_10c97cdb05c79ce1 ?? 800;
    self.var_146c1cb092dccf23 = settings.var_707c906407d968a4 ?? 200;
    self.var_344c3026f4786710 = 0;
    self.var_f80a192a1f0f0cf0 = settings.var_a5a4e39aeb96e4ad ?? 1.5;
}

// Namespace zombie_aeon_flame_tornado
// Params 1
// Checksum 0xa39430f, Offset: 0x54c
// Size: 0x17
function function_e20231e798d819c3( var_5061852a2493cce8 )
{
    self.var_8ec9ee2d8052ecc2 = var_5061852a2493cce8;
}

// Namespace zombie_aeon_flame_tornado
// Params 2
// Checksum 0x21e2896, Offset: 0x56b
// Size: 0x1c8
function spawn_flame_tornado( spawn_pos, spawn_angles )
{
    self endon( #"death" );
    assert( isdefined( self.var_a67857a3fa174b79 ), "<dev string:x24>" );
    tornado = utility::spawn_model( self.var_a67857a3fa174b79, utility::groundpos( spawn_pos ?? self.origin ), spawn_angles ?? ( 0, 0, 0 ) );
    
    if ( !isdefined( self.var_5882e5e64b6302a7 ) )
    {
        self.var_5882e5e64b6302a7 = [];
    }
    
    self.var_5882e5e64b6302a7[ self.var_5882e5e64b6302a7.size ] = tornado;
    tornado.owner = self;
    tornado.team = self.team;
    tornado.speed = self.var_1e0e473fc77a1461[ self.n_fight_phase - 1 ];
    tornado.speed *= self.var_8ec9ee2d8052ecc2 ?? 1;
    tornado.var_956c1fab341d0053 = tornado.speed;
    tornado.var_addf6e7213daa07a = self.n_fight_phase >= 3;
    tornado.offset_direction = self.var_344c3026f4786710 % 3;
    self.var_344c3026f4786710++;
    tornado play_spawn_vfx( self );
    tornado setscriptablepartstate( "impact", "on" );
    wait 0.1;
    tornado setscriptablepartstate( "base", "move" );
    tornado thread function_93703f136dfd888f();
    wait 3;
    tornado thread function_6ac109db6cf262d6();
    tornado thread function_da0045d3b708ad59();
    tornado thread function_d23a28cd0096a389();
    tornado thread ft_watch_timeout();
    return tornado;
}

// Namespace zombie_aeon_flame_tornado
// Params 1, eflags: 0x4
// Checksum 0x8a84fc06, Offset: 0x73c
// Size: 0x106
function private play_spawn_vfx( aeon )
{
    playfx( utility::getfx( "aeon_lightning_danger_fx" ), self.origin, ( 1, 0, 0 ), ( 0, 0, 1 ) );
    cloud = utility::spawn_model( "tag_origin", aeon.origin + ( 0, 0, 1000 ) );
    aeon thread utility::delete_on_death( cloud );
    waitframe();
    var_8d825c658f75501f = playfxontagsbetweenclients( utility::getfx( "aeon_lightning_air_beam_fx" ), aeon, "tag_fx", cloud, "tag_origin" );
    var_8d825c658f75501f thread utility::delete_after_delay( 3 );
    waitframe();
    playfxontag( utility::getfx( "aeon_lightning_cloud_fx" ), cloud, "tag_origin" );
    wait 0.5;
    var_8d825d658f755252 = playfxontagsbetweenclients( utility::getfx( "aeon_lightning_ground_beam_fx" ), cloud, "tag_origin", self, "tag_origin" );
    var_8d825d658f755252 thread utility::delete_after_delay( 3 );
    waitframe();
    wait 3;
    cloud delete();
}

// Namespace zombie_aeon_flame_tornado
// Params 0
// Checksum 0xcdabb85e, Offset: 0x84a
// Size: 0x91
function function_f7c656e727e98246()
{
    self.var_5882e5e64b6302a7 = function_5713d46873b29625( self.var_5882e5e64b6302a7 );
    
    foreach ( ft in self.var_5882e5e64b6302a7 )
    {
        ft free_flame_tornado();
    }
}

// Namespace zombie_aeon_flame_tornado
// Params 0
// Checksum 0xc3eda32c, Offset: 0x8e3
// Size: 0x173
function free_flame_tornado()
{
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            if ( player.var_3b92fa992d67f94b == self )
            {
                player.var_3b92fa992d67f94b = undefined;
            }
            
            if ( player.tornado_damage_source == self )
            {
                player.tornado_damage_source = undefined;
                function_3e0280f09919165f( player );
            }
        }
    }
    
    if ( self.toss_zombies.size )
    {
        self.toss_zombies = function_46f9072493651dc9( self.toss_zombies );
        
        foreach ( zombie in self.toss_zombies )
        {
            zombie kill( zombie.origin );
        }
    }
    
    self setscriptablepartstate( "base", "despawn" );
    thread utility::delete_after_delay( 1 );
}

// Namespace zombie_aeon_flame_tornado
// Params 0, eflags: 0x4
// Checksum 0x8d41b89c, Offset: 0xa5e
// Size: 0x29
function private ft_watch_timeout()
{
    self endon( #"death" );
    wait self.owner.var_a8740501b4b2341d;
    free_flame_tornado();
}

// Namespace zombie_aeon_flame_tornado
// Params 0, eflags: 0x4
// Checksum 0x5ff3e5a, Offset: 0xa8f
// Size: 0x2f
function private function_d23a28cd0096a389()
{
    self endon( #"death" );
    self.owner utility::ent_flag_wait( "scar_exposed" );
    
    if ( self.var_addf6e7213daa07a )
    {
    }
}

// Namespace zombie_aeon_flame_tornado
// Params 0, eflags: 0x4
// Checksum 0xd5e2809a, Offset: 0xac6
// Size: 0xb9
function private function_da0045d3b708ad59()
{
    self endon( #"death" );
    self.destination = function_29e2096e5db49199();
    thread function_cb1fa6c1ddb656d9();
    thread function_f99635e79261bef6();
    
    while ( true )
    {
        /#
            function_4a559b3503e2acc4();
        #/
        
        function_9d9d7b7350a1b584();
        result = utility::waittill_any_timeout( 60, "find_target", "find_new_path", "reload_path" );
        
        if ( result == "find_new_path" || result == "find_target" )
        {
            self.destination = function_29e2096e5db49199();
            
            /#
                ft_debug_print( "<dev string:x5e>" );
            #/
            
            continue;
        }
        
        if ( result == "reload_path" )
        {
            /#
                ft_debug_print( "<dev string:x79>" );
            #/
        }
    }
}

// Namespace zombie_aeon_flame_tornado
// Params 0, eflags: 0x4
// Checksum 0xb63f7fc8, Offset: 0xb87
// Size: 0x4c
function private function_29e2096e5db49199()
{
    if ( isalive( self.enemy ) )
    {
        return self.enemy.origin;
    }
    
    return getrandomnavpoint( self.owner.origin, 300 ) ?? self.origin;
}

// Namespace zombie_aeon_flame_tornado
// Params 0, eflags: 0x4
// Checksum 0xd57f683c, Offset: 0xbdc
// Size: 0x132
function private function_3062a36338a41836()
{
    if ( !isalive( self.enemy ) )
    {
        self.speed = self.var_956c1fab341d0053;
        return;
    }
    
    if ( !isalive( self.owner ) )
    {
        self.speed = self.var_956c1fab341d0053;
        return;
    }
    
    dist = distance( self.origin, self.enemy.origin );
    speed_mult = math::remap( clamp( dist, self.owner.var_9b008da44e591709 ?? 0, self.owner.var_18d0e3dfbddd2707 ?? 1 ), self.owner.var_9b008da44e591709 ?? 0, self.owner.var_18d0e3dfbddd2707 ?? 1, self.owner.var_898f423f55f0bccf ?? 0.5, self.owner.var_ce4ef88711fac0d9 ?? 1 );
    self.speed = self.var_956c1fab341d0053 * speed_mult;
}

// Namespace zombie_aeon_flame_tornado
// Params 1, eflags: 0x4
// Checksum 0x68a3858b, Offset: 0xd16
// Size: 0x1c8
function private function_e9a2dd18e17d3872( destination )
{
    if ( self.offset_direction == 2 )
    {
        return destination;
    }
    
    dist_to_target = distance( self.origin, destination );
    
    if ( !isalive( self.owner ) )
    {
        return destination;
    }
    
    if ( dist_to_target <= self.owner.var_146c1cb092dccf23 )
    {
        return destination;
    }
    
    separation_end = self.owner.var_146c1cb092dccf23 ?? 1;
    separation_start = self.owner.var_ec21413753af15ac ?? 2;
    
    if ( separation_end >= separation_start )
    {
        return destination;
    }
    
    offset_scale = math::remap( clamp( dist_to_target, separation_end, separation_start ), separation_end, separation_start, 0, 1 );
    dir_to_target = vectornormalize( destination - self.origin );
    perpendicular = vectorcross( dir_to_target, ( 0, 0, 1 ) );
    offset_amount = ( self.owner.var_7ff307fb172e4d11 ?? 0 ) * offset_scale;
    
    if ( self.offset_direction == 0 )
    {
        offset_amount *= -1;
    }
    
    new_destination = destination + perpendicular * offset_amount;
    trace_result = navtrace( self.origin, new_destination, undefined, 1 );
    
    if ( trace_result[ "fraction" ] < 1 )
    {
        if ( trace_result[ "fraction" ] > 0.3 )
        {
            new_destination = trace_result[ "position" ] - perpendicular * 50;
        }
        else
        {
            return destination;
        }
    }
    
    var_4d7d4fdebb3384d2 = getclosestpointonnavmesh( new_destination, self.origin, 200 );
    return var_4d7d4fdebb3384d2 ?? destination;
}

// Namespace zombie_aeon_flame_tornado
// Params 0, eflags: 0x4
// Checksum 0x2a17a590, Offset: 0xee7
// Size: 0x19a
function private function_9d9d7b7350a1b584()
{
    function_3062a36338a41836();
    
    if ( self.forced_destination )
    {
        self.destination = self.forced_destination;
    }
    
    adjusted_destination = function_e9a2dd18e17d3872( self.destination );
    
    /#
        function_fa9d108e4df83f98( adjusted_destination );
    #/
    
    var_b0afbe385bf12ec3 = distance( self.origin, adjusted_destination );
    var_acd1d0de24cfedd6 = var_b0afbe385bf12ec3 < 500 ? var_b0afbe385bf12ec3 / 10 : 50;
    
    if ( var_b0afbe385bf12ec3 > 4000 )
    {
        adjusted_destination = self.origin + vectornormalize( adjusted_destination - self.origin ) * 4000 * 0.5;
    }
    
    spline_points = self findsplinepath( getclosestpointonnavmesh( self.origin ), getclosestpointonnavmesh( adjusted_destination ), 200, 200, var_acd1d0de24cfedd6, anglestoforward( self.angles ), ( 0, 0, 0 ), 100, 0.25, 0, "small_veh_jump", undefined, 0, 2 );
    
    if ( !spline_points || spline_points.size <= 2 )
    {
        return;
    }
    
    if ( spline_points.size >= 48 )
    {
        spline_points = utility::array_slice( spline_points, 0, 47 );
    }
    
    spline_points[ spline_points.size - 1 ] = undefined;
    move_time = function_5fb18068f9b8d623( spline_points, self.speed );
    
    if ( move_time )
    {
        self notify( #"stop_curve" );
        thread utility::function_2159dd4196ff4b81( spline_points, move_time, 1, 1, 1, 0.5, 0.5, getdvarint( @"scr_flame_tornado_debug" ) );
        self.destination = spline_points[ spline_points.size - 1 ];
    }
}

// Namespace zombie_aeon_flame_tornado
// Params 2, eflags: 0x4
// Checksum 0xed9f5a1d, Offset: 0x1089
// Size: 0x6b
function private function_5fb18068f9b8d623( spline_points, speed )
{
    if ( spline_points.size < 2 )
    {
        return 0;
    }
    
    time = 0;
    
    for ( i = 0; i < spline_points.size - 1 ; i++ )
    {
        time += max( distance( spline_points[ i ], spline_points[ i + 1 ] ) / speed, 0.05 );
    }
    
    return time;
}

// Namespace zombie_aeon_flame_tornado
// Params 0, eflags: 0xc
// Checksum 0xc13a2e80, Offset: 0x10fd
// Size: 0x6b
function private function_cb1fa6c1ddb656d9()
{
    self notify( #"hash_b1e3171e274ea833" );
    self endon( #"hash_b1e3171e274ea833" );
    self endon( #"death" );
    
    while ( true )
    {
        if ( isdefined( self.destination ) && distancesquared( self.origin, self.destination ) < 400 )
        {
            self notify( #"find_new_path" );
        }
        
        wait 0.5;
    }
}

// Namespace zombie_aeon_flame_tornado
// Params 0, eflags: 0xc
// Checksum 0x2349e345, Offset: 0x1170
// Size: 0x1b2
function private function_f99635e79261bef6()
{
    self notify( #"hash_e0a38474b040a17e" );
    self endon( #"hash_e0a38474b040a17e" );
    self endon( #"death" );
    stuck_dist = getdvarint( @"hash_8e6400dc15a9d65c", 100 );
    var_21cfe31a5e93b9b9 = getdvarint( @"hash_1af498e207745b7a", 1000 );
    max_enemy_time = getdvarint( @"scr_ft_enemy_time", 10000 );
    var_ce7466ebc75c58cf = getdvarint( @"hash_b1394997aa5cb9e2", 5 );
    cur_time = gettime();
    last_pos = self.origin;
    stuck_time = cur_time;
    enemy_time = cur_time;
    moving_dist = 0;
    stuck_count = 0;
    
    while ( true )
    {
        moving_dist += distance( last_pos, self.origin );
        last_pos = self.origin;
        cur_time = gettime();
        
        if ( cur_time > stuck_time + var_21cfe31a5e93b9b9 )
        {
            stuck_time = cur_time;
            moving_dist = 0;
            stuck_count++;
            self notify( #"reload_path" );
            
            if ( stuck_count > var_ce7466ebc75c58cf )
            {
                free_flame_tornado();
                return;
            }
        }
        else if ( cur_time > enemy_time + max_enemy_time )
        {
            free_flame_tornado();
            return;
        }
        
        if ( moving_dist > stuck_dist )
        {
            stuck_time = cur_time;
            moving_dist = 0;
            stuck_count = 0;
        }
        
        if ( isalive( self.enemy ) )
        {
            enemy_time = cur_time;
            
            if ( distancesquared( self.enemy.origin, self.origin ) < self.owner.var_a221500bc6423651 )
            {
                stuck_time = cur_time;
            }
        }
        
        wait 0.2;
    }
}

// Namespace zombie_aeon_flame_tornado
// Params 0, eflags: 0x4
// Checksum 0x88c9cbb8, Offset: 0x132a
// Size: 0x1f1
function private function_6ac109db6cf262d6()
{
    self endon( #"death" );
    
    while ( true )
    {
        potential_target = undefined;
        closest_dist_sq = undefined;
        var_c856392cb70eff5c = self.owner function_f017e352a29a57a1( self.origin, 5000, 1 );
        
        foreach ( player in var_c856392cb70eff5c )
        {
            dist_sq = distancesquared( player.origin, self.origin );
            
            if ( dist_sq > self.owner.var_304cb68d55c81b28 )
            {
                continue;
            }
            
            if ( !function_62e84f00996f4c1e( player, 1 ) )
            {
                continue;
            }
            
            if ( !isdefined( closest_dist_sq ) || dist_sq < closest_dist_sq )
            {
                potential_target = player;
                closest_dist_sq = dist_sq;
            }
        }
        
        if ( !potential_target )
        {
            foreach ( player in var_c856392cb70eff5c )
            {
                dist_sq = distancesquared( player.origin, self.origin );
                
                if ( dist_sq > self.owner.var_304cb68d55c81b28 )
                {
                    continue;
                }
                
                if ( !function_62e84f00996f4c1e( player, 0 ) )
                {
                    continue;
                }
                
                if ( !isdefined( closest_dist_sq ) || dist_sq < closest_dist_sq )
                {
                    potential_target = player;
                    closest_dist_sq = dist_sq;
                }
            }
        }
        
        function_73283d540f51143c( potential_target );
        wait 0.1;
    }
}

// Namespace zombie_aeon_flame_tornado
// Params 2, eflags: 0x4
// Checksum 0x3a5b84ca, Offset: 0x1523
// Size: 0xb1, Type: bool
function private function_62e84f00996f4c1e( ent, var_aa4a062c0bd5aac3 = 0 )
{
    if ( !isdefined( ent.team ) || ent.team == self.team )
    {
        return false;
    }
    
    if ( var_aa4a062c0bd5aac3 )
    {
        if ( isdefined( ent.seeking_ft ) && ent.seeking_ft != self )
        {
            if ( distancesquared( self.origin, ent.origin ) >= distancesquared( ent.seeking_ft.origin, ent.origin ) )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace zombie_aeon_flame_tornado
// Params 1, eflags: 0x4
// Checksum 0xae101e78, Offset: 0x15dd
// Size: 0x123
function private function_73283d540f51143c( ent )
{
    if ( isdefined( ent ) )
    {
        if ( isdefined( ent.seeking_ft ) && ent.seeking_ft != self )
        {
            ent.seeking_ft function_73283d540f51143c();
        }
        
        if ( isdefined( self.enemy ) && ent != self.enemy )
        {
            function_73283d540f51143c();
        }
        
        self.enemy = ent;
        ent.seeking_ft = self;
        
        if ( !isdefined( self.var_ce528ede38ece10e ) || distancesquared( self.var_ce528ede38ece10e, ent.origin ) > 4000 )
        {
            self.var_ce528ede38ece10e = ent.origin;
            self notify( #"find_target" );
        }
        
        /#
            ft_debug_print( "<dev string:x8b>" );
        #/
        
        return;
    }
    
    if ( isdefined( self.enemy ) )
    {
        self.enemy.seeking_ft = undefined;
        self.enemy = undefined;
        self.var_ce528ede38ece10e = undefined;
        
        /#
            ft_debug_print( "<dev string:x9d>" );
        #/
    }
}

// Namespace zombie_aeon_flame_tornado
// Params 0, eflags: 0x4
// Checksum 0x9062df49, Offset: 0x1708
// Size: 0x2cc
function private function_93703f136dfd888f()
{
    self endon( #"death" );
    damage_start_time = [];
    
    while ( true )
    {
        wait 0.5;
        
        if ( !isalive( self.owner ) )
        {
            continue;
        }
        
        a_players_in_range = getplayersinradius( self.origin, self.owner.var_283013fea80042cf ?? 1 );
        
        foreach ( player in a_players_in_range )
        {
            if ( !isalive( player ) || player.inlaststand || !player val::get( "damage" ) )
            {
                continue;
            }
            
            in_damage_range = function_74f1fbc9d92e49f( player );
            
            if ( in_damage_range )
            {
                function_87e353d8b15947f1( player, "damage" );
                player.var_3b92fa992d67f94b = self;
                function_fa6319b17023d734( player, self.owner );
                
                if ( self.owner.var_ec27eae9ef025773 )
                {
                    function_815b730b6e361e29( player );
                }
                
                if ( !isdefined( player.tornado_damage_source ) || player.tornado_damage_source == self )
                {
                    player.tornado_damage_source = self;
                    
                    if ( !isdefined( damage_start_time[ player getentitynumber() ] ) )
                    {
                        damage_start_time[ player getentitynumber() ] = gettime();
                    }
                    
                    damage = function_abe0fad0e3eaebb1( damage_start_time[ player getentitynumber() ] );
                    self.owner.ignore_turtle_shell = 1;
                    var_c3c510ec65b4bddc = self.owner.armor_health_damage_multiplier;
                    self.owner.armor_health_damage_multiplier = ( var_c3c510ec65b4bddc ?? 1 ) * self.owner.var_f80a192a1f0f0cf0;
                    player dodamage( damage, self.origin, self.owner, self, "MOD_ELEMENTAL_FIRE" );
                    self.owner.armor_health_damage_multiplier = var_c3c510ec65b4bddc;
                    self.owner.ignore_turtle_shell = 0;
                }
                
                continue;
            }
            
            function_87e353d8b15947f1( player, "warn" );
            player.var_3b92fa992d67f94b = self;
            function_fa6319b17023d734( player, self.owner );
            
            if ( player.tornado_damage_source == self )
            {
                player.tornado_damage_source = undefined;
            }
            
            damage_start_time[ player getentitynumber() ] = undefined;
            function_3e0280f09919165f( player );
        }
    }
}

// Namespace zombie_aeon_flame_tornado
// Params 2, eflags: 0x4
// Checksum 0xa466efdb, Offset: 0x19dc
// Size: 0x3d
function private function_fa6319b17023d734( player, aeon )
{
    if ( player.var_edf97dcd538f4ac0 )
    {
        return;
    }
    
    player.var_edf97dcd538f4ac0 = 1;
    level thread function_634e019c7dad6ca5( player, aeon );
}

// Namespace zombie_aeon_flame_tornado
// Params 2, eflags: 0x4
// Checksum 0x3a42b848, Offset: 0x1a21
// Size: 0x172
function private function_634e019c7dad6ca5( player, aeon )
{
    player notify( #"hash_9edc5f5c847696e" );
    player endon( #"hash_9edc5f5c847696e" );
    
    while ( true )
    {
        wait 0.5;
        
        if ( !isdefined( player ) )
        {
            return;
        }
        
        if ( !isalive( player ) )
        {
            player.var_edf97dcd538f4ac0 = undefined;
            return;
        }
        
        var_80a813ef6e2b6552 = 0;
        
        if ( isdefined( aeon ) && isdefined( aeon.var_5882e5e64b6302a7 ) )
        {
            foreach ( tornado in aeon.var_5882e5e64b6302a7 )
            {
                if ( isdefined( tornado ) && distance2dsquared( tornado.origin, player.origin ) < aeon.var_7ae6ecea390c6778 )
                {
                    var_80a813ef6e2b6552 = 1;
                    break;
                }
            }
        }
        
        if ( !var_80a813ef6e2b6552 )
        {
            function_87e353d8b15947f1( player, "off" );
            player.var_3b92fa992d67f94b = undefined;
            
            if ( isdefined( player.tornado_damage_source ) )
            {
                player.tornado_damage_source = undefined;
            }
            
            function_3e0280f09919165f( player );
            player.var_edf97dcd538f4ac0 = undefined;
            return;
        }
    }
}

// Namespace zombie_aeon_flame_tornado
// Params 1, eflags: 0x4
// Checksum 0xffc98df1, Offset: 0x1b9b
// Size: 0x7a, Type: bool
function private function_74f1fbc9d92e49f( player )
{
    if ( distance2dsquared( self.origin, player.origin ) >= self.owner.var_a221500bc6423651 )
    {
        return false;
    }
    
    var_b0a681d77fccb76d = player.origin[ 2 ] - self.origin[ 2 ];
    return var_b0a681d77fccb76d < self.owner.var_b263d8f01cb56381;
}

// Namespace zombie_aeon_flame_tornado
// Params 1, eflags: 0x4
// Checksum 0x89d7d7d8, Offset: 0x1c1e
// Size: 0x72
function private function_abe0fad0e3eaebb1( start_time )
{
    var_5454f57201136c19 = self.owner.tornado_damage_player;
    time_in_tornado = ( gettime() - start_time ) / 1000;
    
    if ( time_in_tornado <= self.owner.var_2128f88ab96db134 )
    {
        return var_5454f57201136c19;
    }
    
    return var_5454f57201136c19 * self.owner.var_5ba0b6dc6ed52f5d;
}

// Namespace zombie_aeon_flame_tornado
// Params 1, eflags: 0x4
// Checksum 0x11200939, Offset: 0x1c99
// Size: 0xcc
function private function_815b730b6e361e29( player )
{
    has_environmentalist = istrue( player utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_phd_flopper", #"phdflopper_safe_slide" ) );
    var_f6c68b423a455057 = player issprintsliding();
    is_low_health = player.health / player.maxhealth < 0.25;
    
    if ( !player effect_slow::function_c1be3c9f2d0b92d2( "flame_tornado_slow" ) && !( has_environmentalist && var_f6c68b423a455057 ) && !is_low_health )
    {
        player effect_slow::slow( "flame_tornado_slow", self.owner.tornado_slow_rate, 0.6, self.owner );
    }
}

// Namespace zombie_aeon_flame_tornado
// Params 1, eflags: 0x4
// Checksum 0x97e60593, Offset: 0x1d6d
// Size: 0x2a
function private function_3e0280f09919165f( player )
{
    if ( player effect_slow::function_c1be3c9f2d0b92d2( "flame_tornado_slow" ) )
    {
        player effect_slow::function_80a4bd13b5ba303a( "flame_tornado_slow" );
    }
}

// Namespace zombie_aeon_flame_tornado
// Params 2, eflags: 0x4
// Checksum 0xf6b40f71, Offset: 0x1d9f
// Size: 0x44
function private function_87e353d8b15947f1( player, state )
{
    if ( player.flame_tornado_state != state )
    {
        player.flame_tornado_state = state;
        player utility::function_7c10ea82c1e305b8( "flame_tornado", state );
    }
}

/#

    // Namespace zombie_aeon_flame_tornado
    // Params 1, eflags: 0x4
    // Checksum 0x689b3175, Offset: 0x1deb
    // Size: 0x32, Type: dev
    function private ft_debug_print( message )
    {
        if ( getdvarint( @"scr_flame_tornado_debug" ) )
        {
            iprintln( self getentitynumber() + "<dev string:xac>" + message );
        }
    }

    // Namespace zombie_aeon_flame_tornado
    // Params 0, eflags: 0x4
    // Checksum 0x4ce916cf, Offset: 0x1e25
    // Size: 0x43, Type: dev
    function private function_4a559b3503e2acc4()
    {
        if ( getdvarint( @"scr_flame_tornado_debug" ) && isdefined( self.destination ) )
        {
            sphere( self.destination, 10, ( 1, 0, 0 ), 0, 30 );
        }
    }

    // Namespace zombie_aeon_flame_tornado
    // Params 1, eflags: 0x4
    // Checksum 0xb76ae777, Offset: 0x1e70
    // Size: 0xf0, Type: dev
    function private function_fa9d108e4df83f98( adjusted_dest )
    {
        if ( !getdvarint( @"scr_flame_tornado_debug" ) )
        {
            return;
        }
        
        line( self.origin, adjusted_dest, ( 1, 1, 0 ), 1, 30 );
        
        switch ( self.offset_direction )
        {
            case 0:
                color = ( 1, 0, 0 );
                break;
            case 1:
                color = ( 0, 1, 0 );
                break;
            default:
                color = ( 0, 0, 1 );
                break;
        }
        
        sphere( adjusted_dest, 30, color, 1 );
        
        if ( isdefined( self.destination ) )
        {
            sphere( self.destination, 20, ( 1, 1, 1 ), 1 );
        }
    }

#/
