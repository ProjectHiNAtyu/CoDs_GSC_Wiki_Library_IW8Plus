// scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_move.gsc  (hash_3606140c3075cf8a.gscc) (size: 30871 Bytes / 0x7897 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd8b47910 (3635706128)
// size ...... 30871 (0x7897)
// includes .. 16  (offset: 0x7283)
// strings ... 48  (offset: 0x7303)
// dev strs .. 47  (offset: 0x761b)
// exports ... 54  (offset: 0x5343)
// cseg ...... 0x406 + 0x4f3d (0x5343)
// imports ... 148 (offset: 0x5bb3)
// animtree1 . 0   (offset: 0x7897)
// animtree2 . 0   (offset: 0x7897)
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\shared\zombie\zombie_vox;
#using scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_beam_attack;
#using scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_metabones;
#using scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_missile;
#using scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_summon;
#using scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_vehicle;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\easing;
#using scripts\common\math;
#using scripts\common\metabone;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle_occupancy;

#namespace zombie_hermes_move;

/#

    // Namespace zombie_hermes_move
    // Params 0
    // Checksum 0x986428e9, Offset: 0x424
    // Size: 0xc, Type: dev
    function function_9950dcd423bda79c()
    {
        function_faffc764fc576c9a();
    }

#/

// Namespace zombie_hermes_move
// Params 0
// Checksum 0x9d595eb7, Offset: 0x438
// Size: 0xd6
function init_zombie_hermes_move()
{
    var_4c1cb74fbd599725 = self;
    var_4c1cb74fbd599725.hermes_velocity = ( 0, 0, 0 );
    var_4c1cb74fbd599725.hermes_target_vel = ( 0, 0, 0 );
    var_4c1cb74fbd599725.var_c756062136c44231 = 0;
    var_4c1cb74fbd599725.hermes_tilt = ( 0, 0, 0 );
    var_4c1cb74fbd599725.var_81170b2300e32aa2 = ( 0, 0, 0 );
    self.var_c550c76e4b35da96 = 1;
    self.var_42cb564b2b24ad9a = 1;
    arena_center_struct = utility::getstruct( "boss_arena_center" );
    self.arena_center_pos = arena_center_struct.origin ?? ( 11991, 1860, 382 );
    thread function_5acc037c143ce189();
}

// Namespace zombie_hermes_move
// Params 2
// Checksum 0xb3646bef, Offset: 0x516
// Size: 0x2cc
function function_6fbe89b26d3312( taskid, params )
{
    ent = self.enemy;
    
    if ( !isdefined( ent ) )
    {
        return anim.failure;
    }
    
    start_pos = self.origin - ( 0, 0, 70 );
    goal_point = get_goal_point( self );
    dist = distance( start_pos, goal_point );
    dist_to_target = distance( start_pos, ent.origin );
    
    /#
        if ( debug_move() )
        {
            print3d( self.origin + ( 0, 0, 100 ), "<dev string:x24>" + dist, ( 1, 0, 0 ) );
            print3d( self.origin + ( 0, 0, 200 ), "<dev string:x33>" + dist_to_target, ( 1, 0, 0 ) );
            sphere( goal_point, 10, ( 1, 0, 0 ) );
            print3d( goal_point + ( 0, 0, 30 ), "<dev string:x44>", ( 1, 0, 0 ) );
        }
    #/
    
    goal_point += ( 0, 0, 70 );
    var_4c1cb74fbd599725 = self;
    move_props = get_movement_properties( self );
    min_range = move_props.min_range;
    var_87dc7c3440796378 = move_props.var_87dc7c3440796378;
    accel = move_props.accel;
    
    if ( var_4c1cb74fbd599725 utility::ent_flag( "hermes_summon_zombies" ) )
    {
        goal_point += ( 0, 0, 150 );
    }
    
    to_goal_pos = goal_point - var_4c1cb74fbd599725.origin;
    max_speed = function_f40072531d9a1109( to_goal_pos, move_props );
    to_target_ent = ent.origin - var_4c1cb74fbd599725.origin;
    retreat_pos = undefined;
    
    if ( dist_to_target > min_range && dist < var_87dc7c3440796378 )
    {
        var_f69827bbfb33eb2b = ( 0, 0, 0 );
    }
    else
    {
        var_f69827bbfb33eb2b = vectornormalize( to_goal_pos );
        
        if ( dist_to_target < min_range )
        {
            backwards_vel = vectornormalize( utility::flatten_vector( var_f69827bbfb33eb2b ) ) * -500;
            retreat_pos = getclosestpointonnavmesh( var_4c1cb74fbd599725.origin + backwards_vel ) + ( 0, 0, 70 );
            var_f69827bbfb33eb2b = vectornormalize( retreat_pos - var_4c1cb74fbd599725.origin );
        }
        
        var_f69827bbfb33eb2b *= max_speed;
    }
    
    function_9e70f4e55d08dd55( var_4c1cb74fbd599725, var_f69827bbfb33eb2b, accel );
    return anim.success;
}

// Namespace zombie_hermes_move
// Params 2
// Checksum 0x20de6bdf, Offset: 0x7eb
// Size: 0x196
function function_d1d3e87e1f079d0b( taskid, params )
{
    bump_target = get_bump_target( self );
    
    if ( !isdefined( bump_target ) || !bump_target.vehicletype )
    {
        return anim.failure;
    }
    
    cooldown_s = getdvarfloat( @"hash_740b3efd3c52a005", 5 );
    
    if ( utility::ent_flag( "hermes_gamera_spin_fast" ) )
    {
        if ( level.var_81dc9de2fda86a3f )
        {
            cooldown_s = getdvarfloat( @"hash_3d7832a92e2337c6", 3 );
        }
        else
        {
            cooldown_s = getdvarfloat( @"hash_3d7832a92e2337c6", 15 );
        }
    }
    
    if ( !utility::time_has_passed( self.var_ac4fd9079a8b8079 ?? 0, cooldown_s ) )
    {
        /#
            if ( debug_move() )
            {
                print3d( self.origin + ( 0, 0, 200 ), "<dev string:x50>", ( 1, 0, 0 ) );
            }
        #/
        
        return anim.failure;
    }
    
    z_delta = bump_target.origin[ 2 ] - self.origin[ 2 ];
    var_3416f8db6876d623 = getdvarfloat( @"hash_520ab4858fa0ba68", 100 );
    
    if ( z_delta < var_3416f8db6876d623 * -1 )
    {
        /#
            if ( debug_move() )
            {
                print3d( self.origin + ( 0, 0, 200 ), "<dev string:x69>" + z_delta, ( 1, 0, 0 ) );
            }
        #/
        
        return anim.failure;
    }
    
    return anim.success;
}

// Namespace zombie_hermes_move
// Params 2
// Checksum 0x87b9b205, Offset: 0x98a
// Size: 0x113
function function_cb455d83602057e1( taskid, params )
{
    bump_target = get_bump_target( self );
    self.var_80588a9923944853 = bump_target;
    bump_target_dir = vectornormalize( bump_target vehicle_getvelocity() );
    var_a9fd7fe4f73eb7ad = vectornormalize2( bump_target vehicle_getvelocity() );
    self.var_f12294bf760b45ec = bump_target.origin + vectordot( bump_target_dir, self.origin - bump_target.origin ) * var_a9fd7fe4f73eb7ad + var_a9fd7fe4f73eb7ad * getdvarfloat( @"hash_e9b05aa2065ecac3", 50 );
    targetpos_nav = getclosestpointonnavmesh( self.var_f12294bf760b45ec );
    
    if ( targetpos_nav )
    {
        var_ab90f4813f81edc3 = targetpos_nav[ 2 ] + getdvarint( @"hash_fe1ffb83009d41f1", 0 );
        self.var_f12294bf760b45ec = ( self.var_f12294bf760b45ec[ 0 ], self.var_f12294bf760b45ec[ 1 ], var_ab90f4813f81edc3 );
    }
    
    self.var_e43c37a00de288 = gettime();
    return anim.success;
}

// Namespace zombie_hermes_move
// Params 2
// Checksum 0x73a7aeb8, Offset: 0xaa6
// Size: 0x17b
function function_42b881a65453a937( taskid, params )
{
    bump_target_pos = self.var_f12294bf760b45ec;
    move_to_point( self, self.var_f12294bf760b45ec, 100, getdvarfloat( @"hash_e8ba9d172f83c2a5", 3 ) );
    
    /#
        col = ( 1, 0, 1 );
        
        if ( debug_move() )
        {
            sphere( self.var_f12294bf760b45ec, 10, col );
            print3d( self.var_f12294bf760b45ec, "<dev string:x88>", col );
        }
    #/
    
    if ( distance2dsquared( self.var_f12294bf760b45ec, self.origin ) < squared( 10 ) )
    {
        return anim.success;
    }
    
    if ( utility::time_has_passed( self.var_e43c37a00de288, 2 ) )
    {
        /#
            col = ( 1, 0, 1 );
            
            if ( debug_move() )
            {
                print3d( self.var_f12294bf760b45ec + ( 0, 0, 30 ), "<dev string:x96>", col );
            }
        #/
        
        return anim.success;
    }
    
    if ( utility::ent_flag( "hit_by_vehicle_recently" ) )
    {
        /#
            col = ( 1, 0, 1 );
            
            if ( debug_move() )
            {
                print3d( self.var_f12294bf760b45ec + ( 0, 0, 30 ), "<dev string:xa5>", col );
            }
        #/
        
        return anim.success;
    }
    
    return anim.running;
}

// Namespace zombie_hermes_move
// Params 2
// Checksum 0x6e7486c8, Offset: 0xc2a
// Size: 0x32
function function_332cb9a6b65f4692( taskid, params )
{
    self.var_f12294bf760b45ec = undefined;
    self.var_e43c37a00de288 = undefined;
    return anim.success;
}

// Namespace zombie_hermes_move
// Params 2
// Checksum 0x27d29efe, Offset: 0xc65
// Size: 0xd6
function function_5fbb9c43757c2c90( taskid, params )
{
    if ( !self.var_80588a9923944853 )
    {
        bump_target = get_bump_target( self );
        self.var_80588a9923944853 = bump_target;
    }
    
    self.var_fd7d881c9868e18e = self.var_80588a9923944853.origin;
    self.var_fd7d881c9868e18e += ( 0, 0, getdvarfloat( @"hash_5dfc0a02e264ffa", 40 ) );
    var_4c1cb74fbd599725 = self;
    var_e3896c2a424cef09 = self.var_fd7d881c9868e18e - var_4c1cb74fbd599725.origin;
    var_4c1cb74fbd599725.hermes_velocity = vectornormalize( var_e3896c2a424cef09 ) * getdvarfloat( @"hash_b12dd31c2b0733f5", 20 );
    return anim.success;
}

// Namespace zombie_hermes_move
// Params 2
// Checksum 0x21ee1aff, Offset: 0xd44
// Size: 0x1fd
function function_1555958e6baa7fa( taskid, params )
{
    bump_target_pos = self.var_fd7d881c9868e18e;
    var_4c1cb74fbd599725 = self;
    var_e3896c2a424cef09 = bump_target_pos - var_4c1cb74fbd599725.origin;
    var_7f40b74ec061c076 = length( var_e3896c2a424cef09 );
    dist_to_target = distance( self.var_80588a9923944853.origin ?? var_4c1cb74fbd599725.origin, var_4c1cb74fbd599725.origin );
    
    /#
        if ( debug_move() )
        {
            line( var_4c1cb74fbd599725.origin, bump_target_pos, ( 1, 0, 0 ) );
            sphere( bump_target_pos, 10, ( 1, 0, 0 ) );
            print3d( bump_target_pos, "<dev string:xbd>" + var_7f40b74ec061c076 + "<dev string:xe2>" + dist_to_target, ( 1, 0, 0 ) );
        }
    #/
    
    function_9e70f4e55d08dd55( var_4c1cb74fbd599725, var_4c1cb74fbd599725.hermes_velocity, 100 );
    var_d9e3ae01579fa1ad = vectordot( var_e3896c2a424cef09, var_4c1cb74fbd599725.hermes_velocity );
    
    if ( var_d9e3ae01579fa1ad <= 0 && !utility::ent_flag( "hit_by_vehicle_recently" ) )
    {
        return anim.success;
    }
    
    if ( utility::ent_flag( "hermes_pushback_recently" ) )
    {
        return anim.success;
    }
    
    if ( isdefined( self.var_80588a9923944853 ) )
    {
        if ( utility::ent_flag( "hit_by_vehicle_recently" ) )
        {
            /#
                if ( debug_move() )
                {
                    line( var_4c1cb74fbd599725.origin, bump_target_pos, ( 0.8, 0.2, 0 ) );
                    sphere( bump_target_pos, 10, ( 1, 0, 0 ) );
                    print3d( bump_target_pos + ( 0, 0, 100 ), "<dev string:xf6>", ( 1, 0, 0 ) );
                }
            #/
            
            return anim.success;
        }
    }
    
    return anim.running;
}

// Namespace zombie_hermes_move
// Params 2
// Checksum 0xae6fd2f6, Offset: 0xf4a
// Size: 0x35
function function_db2d019d6fb92bed( taskid, params )
{
    self.var_80588a9923944853 = undefined;
    self.var_ac4fd9079a8b8079 = gettime();
    return anim.success;
}

// Namespace zombie_hermes_move
// Params 2
// Checksum 0x13ae8c44, Offset: 0xf88
// Size: 0xd9
function function_511feffe28b18acd( taskid, params )
{
    start_pos = getclosestpointonnavmesh( self.origin );
    self.var_f66c1e7ad27d733a = start_pos;
    
    if ( !isdefined( self.var_3411a0b12dcff442 ) )
    {
        self.var_3411a0b12dcff442 = 600;
    }
    
    if ( !isdefined( self.var_1501a8d58612508d ) )
    {
        self.var_1501a8d58612508d = self.arena_center_pos[ 2 ] + self.var_3411a0b12dcff442;
    }
    
    self.var_4640c5211d404c26 = getdvarfloat( @"hash_e1d3063c29744bc6", 3 );
    self.var_36d3935163cc7539 = ( start_pos[ 0 ], start_pos[ 1 ], self.var_1501a8d58612508d );
    self.var_340397b47fb47aee = self.origin[ 2 ];
    self.var_9c4c897ee0261599 = gettime();
    return anim.success;
}

// Namespace zombie_hermes_move
// Params 2
// Checksum 0x122d1269, Offset: 0x106a
// Size: 0xe2
function function_e258d62a41013cd3( taskid, params )
{
    var_4c1cb74fbd599725 = self;
    pct = clamp( math::remap( gettime(), self.var_9c4c897ee0261599, self.var_9c4c897ee0261599 + utility::function_4b74c15943231980( self.var_4640c5211d404c26 ), 0, 1 ), 0, 1 );
    new_z = easing::ease_sine( self.var_340397b47fb47aee, self.var_1501a8d58612508d, pct, 1, 1 );
    new_origin = ( self.origin[ 0 ], self.origin[ 1 ], new_z );
    var_4c1cb74fbd599725 forceteleport( new_origin, var_4c1cb74fbd599725.angles );
    function_9e70f4e55d08dd55( var_4c1cb74fbd599725, ( 0, 0, 0 ), 100 );
    return anim.running;
}

// Namespace zombie_hermes_move
// Params 2
// Checksum 0x295ffdb4, Offset: 0x1155
// Size: 0x3e
function function_6458283809535918( taskid, params )
{
    self.var_97c3df14b06d14ca = gettime();
    move_to_point( self, self.arena_center_pos, 100 );
    return anim.success;
}

// Namespace zombie_hermes_move
// Params 2
// Checksum 0x313e4671, Offset: 0x119c
// Size: 0x44e
function function_3cf05b537bfaab55( taskid, params )
{
    padding_radius = 400;
    vehicle = get_vehicle_target( self );
    
    if ( !vehicle )
    {
        return anim.failure;
    }
    
    if ( !self.arena_center_pos )
    {
        return anim.failure;
    }
    
    if ( utility::ent_flag( "hermes_gamera_spin" ) && !vehicle utility::ent_flag( "aetheric_energy_imbued" ) )
    {
        return anim.failure;
    }
    
    var_29a854e4eea0df7d = distance2d( self.arena_center_pos, vehicle.origin );
    var_848404b2488d9abd = clamp( math::remap( var_29a854e4eea0df7d, 400, 1100, 1, -1 ), -1, 1 );
    var_7fb0341426e92695 = vectornormalize2( self.origin - vehicle.origin );
    var_88d64ea5ef4734b4 = self.arena_center_pos + var_7fb0341426e92695 * padding_radius * var_848404b2488d9abd;
    var_102af7be8478549c = vectornormalize2( vehicle vehicle_getvelocity() );
    using_intersection_point = 0;
    var_a0b4d811ec584fcd = self.arena_center_pos + var_102af7be8478549c * padding_radius * var_848404b2488d9abd;
    
    if ( length( var_102af7be8478549c ) > 0 )
    {
        var_34052cd8673eb929 = math::function_14a305b0209b352c( vehicle.origin - var_102af7be8478549c * padding_radius * 2, vehicle.origin + var_102af7be8478549c * padding_radius * 2, self.arena_center_pos, padding_radius );
        
        if ( var_34052cd8673eb929 && var_34052cd8673eb929.size > 0 )
        {
            var_a0b4d811ec584fcd = var_34052cd8673eb929[ 1 ];
            using_intersection_point = 1;
        }
    }
    
    calculated_goal_pos = var_88d64ea5ef4734b4;
    var_dab462ea24b5f4bf = 0;
    
    if ( var_848404b2488d9abd > 0.75 && vehicle.var_68c6a01ce741b3f8 )
    {
        calculated_goal_pos = vectorlerp( calculated_goal_pos, var_a0b4d811ec584fcd, math::remap( var_848404b2488d9abd, 0.75, 1, 0, 1 ) );
        var_dab462ea24b5f4bf = 1;
        
        if ( !utility::ent_flag( "hermes_face_vehicle" ) )
        {
            utility::ent_flag_set( "hermes_face_vehicle" );
            thread utility::ent_flag_clear_delayed( "hermes_face_vehicle", 2 );
            var_cc62445e986357e6 = zombie_hermes_metabones::function_934d2362690f401e( self, vehicle getcentroid(), var_102af7be8478549c );
            
            if ( var_cc62445e986357e6 )
            {
                var_10917cadbc538237 = vehicle getcentroid() - var_a0b4d811ec584fcd + self.origin;
                thread function_42a8778d1dbccf41( self, var_cc62445e986357e6, var_10917cadbc538237, 10 );
            }
        }
    }
    
    var_3a2bf0e08f9d5a16 = getdvarfloat( @"hash_d432a461b983886a", 100 );
    z_increase = math::remap( abs( var_848404b2488d9abd ), 0, 1, var_3a2bf0e08f9d5a16, 0 );
    
    if ( var_848404b2488d9abd > 0 )
    {
        if ( vehicle.var_68c6a01ce741b3f8 )
        {
            var_d270769f83ff4b5f = getdvarfloat( @"hash_b24738d24ac164db", -100 );
            z_increase = math::remap( abs( var_848404b2488d9abd ), 0, 1, var_3a2bf0e08f9d5a16, var_d270769f83ff4b5f );
        }
        else
        {
            z_increase = math::remap( abs( var_848404b2488d9abd ), 0, 1, 0, var_3a2bf0e08f9d5a16 );
        }
    }
    
    calculated_goal_pos += ( 0, 0, z_increase );
    speed_mult = 1;
    
    if ( var_848404b2488d9abd > -0.85 )
    {
        speed_mult = 3.5;
    }
    
    self.var_97c3df14b06d14ca = gettime();
    move_to_point( self, calculated_goal_pos, 50, speed_mult );
    
    /#
        if ( debug_move() )
        {
            line( self.origin, vehicle.origin, ( 0.8, 0.2, 0 ) );
            print3d( averagepoint( [ self.origin, vehicle.origin ] ), "<dev string:xfd>" + var_29a854e4eea0df7d + "<dev string:x118>" + var_848404b2488d9abd, ( 1, 0, 0 ) );
            print3d( calculated_goal_pos, "<dev string:x128>" + ( var_dab462ea24b5f4bf ? "<dev string:x140>" : "<dev string:x151>" ) + ( using_intersection_point ? "<dev string:x152>" : "<dev string:x151>" ), ( 0.8, 0.2, 0 ) );
            line( var_88d64ea5ef4734b4, var_a0b4d811ec584fcd, ( 0.6, 0.4, 0 ) );
            line( calculated_goal_pos, calculated_goal_pos - ( 0, 0, z_increase ), ( 0.6, 0.4, 0 ) );
            
            if ( var_34052cd8673eb929 && var_34052cd8673eb929.size > 0 )
            {
                line( var_34052cd8673eb929[ 0 ], var_34052cd8673eb929[ 1 ], ( 0.6, 0.5, 0 ) );
            }
        }
    #/
    
    return anim.success;
}

// Namespace zombie_hermes_move
// Params 2
// Checksum 0xea484599, Offset: 0x15f3
// Size: 0x1f0
function function_6614050e0057c809( taskid, params )
{
    padding_radius = 600;
    
    if ( !self.arena_center_pos )
    {
        return anim.failure;
    }
    
    speed_mult = 1;
    beam_target = zombie_hermes_beam_attack::function_e8b70ddc1ddd4be1( self );
    
    if ( beam_target )
    {
        var_45a2f7fac780921b = distance2d( self.arena_center_pos, beam_target.origin );
        var_848404b2488d9abd = clamp( math::remap( var_45a2f7fac780921b, 400, 1100, 1, -1 ), -1, 1 );
        var_e150634a26351b07 = vectornormalize2( self.origin - beam_target.origin );
        var_df0e56dad7f6e9b2 = self.arena_center_pos + var_e150634a26351b07 * padding_radius * var_848404b2488d9abd;
        calculated_goal_pos = var_df0e56dad7f6e9b2;
        var_3a2bf0e08f9d5a16 = getdvarfloat( @"hash_6be7c4e557cd948", 200 );
        z_increase = math::remap( var_848404b2488d9abd, -1, 1, 0, var_3a2bf0e08f9d5a16 );
        calculated_goal_pos += ( 0, 0, z_increase );
        
        if ( var_848404b2488d9abd > -0.8 )
        {
            speed_mult = 4;
        }
    }
    
    self.var_97c3df14b06d14ca = gettime();
    move_to_point( self, calculated_goal_pos ?? self.arena_center_pos, 50, speed_mult );
    
    /#
        if ( debug_move() )
        {
            if ( beam_target )
            {
                print3d( averagepoint( [ self.origin, beam_target.origin ] ), "<dev string:xfd>" + var_45a2f7fac780921b + "<dev string:x118>" + var_848404b2488d9abd, ( 1, 0, 0 ) );
                print3d( calculated_goal_pos, "<dev string:x16d>", ( 0.8, 0.2, 0 ) );
                line( calculated_goal_pos, calculated_goal_pos - ( 0, 0, z_increase ), ( 0.6, 0.4, 0 ) );
            }
        }
    #/
    
    return anim.success;
}

// Namespace zombie_hermes_move
// Params 2
// Checksum 0x121880ba, Offset: 0x17ec
// Size: 0x21d
function function_2ed5ab3f35a203cb( taskid, params )
{
    padding_radius = 1000;
    
    if ( !self.arena_center_pos )
    {
        return anim.failure;
    }
    
    calculated_goal_pos = undefined;
    speed_mult = 1;
    var_426e85ed1013fd66 = zombie_hermes_missile::get_big_missile_target( self );
    
    if ( !var_426e85ed1013fd66 )
    {
        return anim.failure;
    }
    
    var_e150634a26351b07 = vectornormalize2( self.origin - var_426e85ed1013fd66.origin );
    z_offset = getdvarfloat( @"hash_dac668e99db1f28b", 400 );
    calculated_goal_pos = self.arena_center_pos + var_e150634a26351b07 * padding_radius + ( 0, 0, z_offset );
    var_e270ecd43b3e0f33 = distance2d( calculated_goal_pos, self.origin );
    var_c2f97ff7d1ede284 = vectordot2( calculated_goal_pos - self.origin, var_426e85ed1013fd66.origin - self.origin );
    zombie_vox::function_5ac4bed4a907abf5( "big_missile_attack_vox" );
    
    if ( var_e270ecd43b3e0f33 < getdvarfloat( @"hash_52fc2eedd072e881", 500 ) || var_c2f97ff7d1ede284 > 0 || utility::ent_flag( "hermes_big_missile_attack" ) || utility::ent_flag( "hermes_big_missile_charge" ) )
    {
        tilt_to_point( self, var_426e85ed1013fd66.origin, getdvarfloat( @"hash_1b8d68065c91a3f9", 80 ), 40, getdvarfloat( @"hash_a6a60cd8d07c68f8", 0.075 ) );
        zombie_vox::function_5ac4bed4a907abf5( "big_missile_attack_end_vox" );
    }
    
    move_to_point( self, calculated_goal_pos ?? self.arena_center_pos, 100, speed_mult );
    
    /#
        if ( debug_move() )
        {
            if ( var_426e85ed1013fd66 )
            {
                print3d( averagepoint( [ self.origin, var_426e85ed1013fd66.origin ] ), "<dev string:x18a>", ( 1, 0, 0 ) );
                print3d( calculated_goal_pos, "<dev string:x19b>", ( 0.8, 0.2, 0 ) );
            }
        }
    #/
    
    return anim.success;
}

// Namespace zombie_hermes_move
// Params 2
// Checksum 0x65e426e1, Offset: 0x1a12
// Size: 0x1f1
function function_7e6bc6cf1359eacb( taskid, params )
{
    target = get_ufo_target( self );
    
    if ( !target )
    {
        return anim.failure;
    }
    
    if ( !self.arena_center_pos )
    {
        return anim.failure;
    }
    
    force_ufo = getdvarint( @"hermes_ufo_force", 0 ) > 0;
    
    if ( force_ufo )
    {
        return anim.success;
    }
    
    disable_ufo = getdvarint( @"hermes_ufo_disable", 0 ) > 0;
    
    if ( disable_ufo )
    {
        return anim.failure;
    }
    
    if ( utility::ent_flag( "hermes_beaming" ) || self getaiblackboarddynamic( "in_beam_charge" ) > 0 )
    {
        return anim.failure;
    }
    
    if ( utility::ent_flag( "hermes_big_missile_charge" ) || utility::ent_flag( "hermes_big_missile_attack" ) )
    {
        return anim.failure;
    }
    
    var_fdc5e4472f1e2a76 = self function_f017e352a29a57a1( target.origin, 1200 );
    
    foreach ( enemy in var_fdc5e4472f1e2a76 )
    {
        if ( enemy != target && isplayer( enemy ) && ( self.var_42cb564b2b24ad9a || !enemy utility::ent_flag( "aether_shroud_in_use" ) ) )
        {
            /#
                if ( debug_move() )
                {
                    print3d( self.origin + ( 0, 0, 100 ), "<dev string:x1b2>", ( 1, 0, 0 ) );
                }
            #/
            
            return anim.failure;
        }
    }
    
    return anim.success;
}

// Namespace zombie_hermes_move
// Params 2
// Checksum 0xfa6948e8, Offset: 0x1c0c
// Size: 0x135
function function_1eb96221a2021df( taskid, params )
{
    target = get_ufo_target( self );
    
    if ( !target )
    {
        return anim.failure;
    }
    
    if ( !self.arena_center_pos )
    {
        return anim.failure;
    }
    
    force_ufo = getdvarint( @"hermes_ufo_force", 0 ) > 0;
    
    if ( self.hermes_ufo_release_time && !utility::time_has_passed( self.hermes_ufo_release_time, 10 ) )
    {
        return anim.failure;
    }
    
    if ( !force_ufo && self.var_cfa0db3603c4af98 && !utility::time_has_passed( self.var_cfa0db3603c4af98, 60 ) )
    {
        return anim.failure;
    }
    
    var_b7db05329facd08 = ( 0, 0, 50 );
    move_to_point( self, target.origin + var_b7db05329facd08, 50, 1 );
    
    if ( distance2d( self.origin, target.origin ) < 75 )
    {
        self.hermes_ufo_target = target;
        return anim.success;
    }
    
    return anim.running;
}

// Namespace zombie_hermes_move
// Params 2
// Checksum 0x7b809c5f, Offset: 0x1d4a
// Size: 0x1d8
function function_352dd809e98eb666( taskid, params )
{
    target = self.hermes_ufo_target;
    
    if ( !target )
    {
        return anim.failure;
    }
    
    utility::function_32b24db3127bff40( "vehicle_attack", "grab" );
    target utility::function_32b24db3127bff40( "hermes_ufo", "grab" );
    utility::function_32b24db3127bff40( "belly", "exposed_tractor" );
    metabone::set_metabone_active( "belly", 1 );
    
    if ( target.vehicletype && target vehicle_isphysveh() )
    {
        target utility::function_7c10ea82c1e305b8( "single", "vehicle_unusable" );
        target function_3054541584df8ab4( 1 );
        target function_d2b8ee2e1275daaf( 1 );
    }
    else
    {
        target linkto( self, "tag_origin", anglestoup( self.angles ) * -100, ( 0, 0, 0 ) );
    }
    
    self.var_3c8a3678a0a31bdb = 0;
    self.var_c75028d95f8fe299 = gettime() + getdvarfloat( @"hash_95a9af6410b4e0d1", 3000 );
    self.var_4f111436b7c76cde = gettime();
    self.var_2fc18ab75a18f45 = self.var_c75028d95f8fe299 + getdvarfloat( @"hash_57e68f15c7c8121a", 3000 );
    self.var_eeaf0c2c810c9ef2 = self.var_2fc18ab75a18f45 + getdvarfloat( @"hash_21e960896241b3cc", 50 );
    self.var_53ec8d43373f8c63 = self.origin - self.arena_center_pos;
    self.hermes_ufo_thrown = 0;
    self.var_66f7b5c9bc58945e = target.angles;
    self function_786bb6aa1b76c7ee( "ufo_throw_attack", 1 );
    utility::ent_flag_set( "hermes_ufo_active" );
    level callback::callback( "vo_ufo_attack" );
    target utility::ent_flag_set( "hermes_ufo_activated" );
    return anim.success;
}

// Namespace zombie_hermes_move
// Params 2
// Checksum 0x9a6f9c62, Offset: 0x1f2b
// Size: 0x339
function function_18e22e1d01cda1a4( taskid, params )
{
    target = self.hermes_ufo_target;
    
    if ( !target )
    {
        return anim.failure;
    }
    
    if ( !self.arena_center_pos )
    {
        return anim.failure;
    }
    
    if ( self.var_3c8a3678a0a31bdb > self.maxhealth * getdvarfloat( @"hash_811709d8220db0a0", 0.01 ) )
    {
        return anim.failure;
    }
    
    var_76af8187404125b4 = math::lerp_fraction( self.var_4f111436b7c76cde, self.var_c75028d95f8fe299, gettime() );
    
    if ( gettime() < self.var_2fc18ab75a18f45 )
    {
        end_pos = self.arena_center_pos + ( 0, 0, 300 );
        spiral_offset = ( 0, 0, 0 );
        
        if ( var_76af8187404125b4 < 1 )
        {
            spiral_offset = function_845f3c4a54dc895a( var_76af8187404125b4, 1, self.var_53ec8d43373f8c63 );
        }
        else
        {
            if ( !isdefined( self.var_57b145b2fa2d41b4 ) )
            {
                self.var_57b145b2fa2d41b4 = function_2a905d02f6815bc6( self );
            }
            
            if ( self.var_57b145b2fa2d41b4 && distance2d( self.var_57b145b2fa2d41b4.origin, self.origin ) > 200 )
            {
                self.var_a081c17ae9863616 = vectornormalize( self.var_57b145b2fa2d41b4.origin - self.origin );
            }
            else if ( !isdefined( self.var_a081c17ae9863616 ) )
            {
                self.var_a081c17ae9863616 = vectornormalize( utility::function_9e0df7b136ab833c() );
            }
            
            var_76af8187404125b4 = math::lerp_fraction( self.var_c75028d95f8fe299, self.var_2fc18ab75a18f45, gettime() );
            
            if ( var_76af8187404125b4 > 0.5 )
            {
                tilt_to_point( self, self.origin + self.var_a081c17ae9863616, 60, 20, getdvarfloat( @"hash_6e00d7e353481b44", 0.1 ) );
            }
        }
        
        goal_pos = end_pos + spiral_offset;
        move_to_point( self, goal_pos, 100, getdvarfloat( @"hash_a30233a67aa0ed73", 2 ) );
    }
    else
    {
        var_76af8187404125b4 = math::lerp_fraction( self.var_2fc18ab75a18f45, self.var_eeaf0c2c810c9ef2, gettime() );
        
        if ( var_76af8187404125b4 > 0 )
        {
            self.hermes_velocity = self.var_a081c17ae9863616 * getdvarfloat( @"hash_ad195c68b02c026c", 50 );
            tilt_to_point( self, self.origin + self.var_a081c17ae9863616, -60, 10, getdvarfloat( @"hash_4366880a6a580a7a", 0.2 ) );
            function_9e70f4e55d08dd55( self, self.hermes_velocity, 100 );
            
            if ( var_76af8187404125b4 >= 1 )
            {
                self.hermes_ufo_thrown = 1;
                return anim.success;
            }
        }
    }
    
    if ( target.vehicletype )
    {
        target vehicle_teleport( self.origin + anglestoup( self.angles ) * -100, self.var_66f7b5c9bc58945e - ( self.angles[ 0 ], 0, self.angles[ 2 ] ), 1 );
    }
    
    return anim.running;
}

// Namespace zombie_hermes_move
// Params 2
// Checksum 0xa7188502, Offset: 0x226d
// Size: 0x33e
function function_a60e241eafb3c2db( taskid, params )
{
    if ( self.hermes_ufo_thrown )
    {
        if ( self.hermes_ufo_target )
        {
            if ( self.hermes_ufo_target.vehicletype && self.hermes_ufo_target vehicle_isphysveh() )
            {
                self.hermes_ufo_target function_3054541584df8ab4( 0 );
                self.hermes_ufo_target function_d2b8ee2e1275daaf( 0 );
                veh_force = getdvarfloat( @"hash_18cc4061f263bbc4", 255 );
                var_31102a7982c7e389 = math::function_235fe1fdb403e4b2( self.hermes_velocity, getdvarfloat( @"hash_79c0dd4094d6a15d", 4 ) );
                self.hermes_ufo_target vehphys_impulse( var_31102a7982c7e389, veh_force, 1 );
                self.hermes_ufo_target vehphys_impulse( var_31102a7982c7e389, veh_force, 1 );
                self.hermes_ufo_target vehphys_impulse( var_31102a7982c7e389, veh_force, 1 );
                self.hermes_ufo_target vehphys_impulse( var_31102a7982c7e389, veh_force, 1 );
                self.hermes_ufo_target thread zombie_hermes_vehicle::function_14dc876b923f0ccd( self, var_31102a7982c7e389 );
                self.hermes_ufo_target utility::function_32b24db3127bff40( "hermes_ufo", "throw" );
            }
            else
            {
                self.hermes_ufo_target unlink();
            }
        }
        
        if ( self.hermes_ufo_target utility::ent_flag_exist( "hermes_ufo_activated" ) )
        {
            self.hermes_ufo_target utility::ent_flag_clear( "hermes_ufo_activated" );
        }
        
        self.hermes_velocity *= 0.75;
        self.var_a081c17ae9863616 = undefined;
        self.hermes_ufo_target = undefined;
        self.var_3c8a3678a0a31bdb = undefined;
        self.var_cfa0db3603c4af98 = gettime();
        utility::function_32b24db3127bff40( "belly", "off" );
        utility::function_32b24db3127bff40( "vehicle_attack", "throw" );
    }
    else
    {
        if ( self.hermes_ufo_target && self.hermes_ufo_target.vehicletype )
        {
            self.hermes_ufo_target function_3054541584df8ab4( 0 );
            self.hermes_ufo_target function_d2b8ee2e1275daaf( 0 );
            self.hermes_ufo_target vehphys_impulse( ( 0, 0, -1 ), 255, 1 );
            self.hermes_ufo_target utility::function_32b24db3127bff40( "hermes_ufo", "off" );
        }
        
        utility::function_32b24db3127bff40( "belly", "explode" );
    }
    
    if ( self.hermes_ufo_target.vehicletype )
    {
        self.hermes_ufo_target utility::function_7c10ea82c1e305b8( "single", "vehicle_use" );
    }
    
    self.hermes_ufo_release_time = gettime();
    self.var_57b145b2fa2d41b4 = undefined;
    nearby_players = getplayersinradius( self.origin, 3000 );
    aether_shroud_chance = nearby_players.size <= 1 ? 0.1 : 0.25;
    
    if ( randomfloat( 1 ) < aether_shroud_chance )
    {
        self.var_42cb564b2b24ad9a = 0;
    }
    else
    {
        self.var_42cb564b2b24ad9a = 1;
    }
    
    self function_786bb6aa1b76c7ee( "ufo_throw_attack", 0 );
    utility::ent_flag_clear( "hermes_ufo_active" );
    self.hermes_ufo_last_time = gettime();
    metabone::set_metabone_active( "belly", 0 );
    return anim.success;
}

// Namespace zombie_hermes_move
// Params 2
// Checksum 0xf2e47ca2, Offset: 0x25b4
// Size: 0x5e
function function_79cb6bdb5a763cff( taskid, params )
{
    if ( !self.arena_center_pos )
    {
        return anim.failure;
    }
    
    self.var_3bb5238250345301 = self.origin - self.arena_center_pos;
    self.var_9e497853b35c931c = gettime();
    return anim.success;
}

// Namespace zombie_hermes_move
// Params 2
// Checksum 0x45e8b68d, Offset: 0x261b
// Size: 0x197
function function_e6e145c33a166601( taskid, params )
{
    if ( !self.arena_center_pos )
    {
        return anim.failure;
    }
    
    if ( getdvarint( @"hash_ef05e540fca01018", 0 ) > 0 )
    {
        return anim.failure;
    }
    
    if ( !utility::time_has_passed( self.var_9e497853b35c931c, 1 ) )
    {
        function_9e70f4e55d08dd55( self, ( 0, 0, 0 ), 1 );
        return anim.running;
    }
    
    var_cfef509ae4139a15 = getdvarfloat( @"hash_ea32c6be008e3f3b", 5 );
    var_76af8187404125b4 = gettime() * 0.001 * 1 / var_cfef509ae4139a15 % 1;
    z_offset = ( 0, 0, sin( gettime() * 0.04 ) * 300 );
    end_pos = self.arena_center_pos + ( 0, 0, 500 );
    spiral_offset = ( 0, 0, 0 );
    self.var_3bb5238250345301 = self.origin - self.arena_center_pos;
    radius_max = 1400;
    var_4fb722231eba8427 = vectornormalize2( self.var_3bb5238250345301 ) * radius_max;
    spiral_offset = function_217ede6000f26bb3( var_76af8187404125b4, 1, var_4fb722231eba8427 );
    goal_pos = end_pos + spiral_offset + z_offset;
    move_to_point( self, goal_pos, 100, getdvarfloat( @"hash_356df47946372f27", 1.5 ) );
    return anim.running;
}

// Namespace zombie_hermes_move
// Params 2
// Checksum 0xe846ea43, Offset: 0x27bb
// Size: 0x83
function function_ebe01d7a2f829147( taskid, params )
{
    if ( !utility::ent_flag( "marked_for_death" ) )
    {
        return anim.failure;
    }
    
    floor_point = utility::drop_to_ground( self.origin + ( 0, 0, 100 ), 0, -4000 ) - ( 0, 0, 100 );
    move_to_point( self, floor_point, 50, 0.5 );
    return anim.running;
}

// Namespace zombie_hermes_move
// Params 2
// Checksum 0x3cc2d15f, Offset: 0x2847
// Size: 0x54
function function_9057660f75c173b5( taskid, params )
{
    if ( getdvarint( @"hash_71645e18c1dffe8e", 0 ) <= 0 )
    {
        return anim.failure;
    }
    
    if ( self.var_ed249d811e1a617b >= 2 )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace zombie_hermes_move
// Params 2
// Checksum 0xc06bac12, Offset: 0x28a4
// Size: 0x2bd
function function_c31eeebc451fef36( taskid, params )
{
    padding_radius = 400;
    vehicle = get_vehicle_target( self );
    
    if ( !vehicle )
    {
        return anim.failure;
    }
    
    if ( !self.arena_center_pos )
    {
        return anim.failure;
    }
    
    if ( utility::ent_flag( "hermes_gamera_spin" ) && !vehicle utility::ent_flag( "aetheric_energy_imbued" ) )
    {
        return anim.failure;
    }
    
    var_29a854e4eea0df7d = distance2d( self.arena_center_pos, vehicle.origin );
    var_848404b2488d9abd = clamp( math::remap( var_29a854e4eea0df7d, 400, 1100, 1, -1 ), -1, 1 );
    var_7fb0341426e92695 = vectornormalize2( self.origin - vehicle.origin );
    var_88d64ea5ef4734b4 = self.arena_center_pos + var_7fb0341426e92695 * padding_radius * 1;
    var_102af7be8478549c = vectornormalize2( vehicle vehicle_getvelocity() );
    var_a0b4d811ec584fcd = self.arena_center_pos + var_102af7be8478549c * padding_radius * var_848404b2488d9abd;
    
    if ( length( var_102af7be8478549c ) > 0 )
    {
        var_34052cd8673eb929 = math::function_14a305b0209b352c( vehicle.origin - var_102af7be8478549c * padding_radius, vehicle.origin + var_102af7be8478549c * padding_radius, self.arena_center_pos, padding_radius );
        
        if ( var_34052cd8673eb929 && var_34052cd8673eb929.size > 0 )
        {
            var_a0b4d811ec584fcd = var_34052cd8673eb929[ 1 ];
        }
    }
    
    calculated_goal_pos = var_88d64ea5ef4734b4;
    var_3a2bf0e08f9d5a16 = getdvarfloat( @"hash_d432a461b983886a", 100 );
    z_increase = var_3a2bf0e08f9d5a16;
    calculated_goal_pos += ( 0, 0, z_increase );
    speed_mult = 2;
    move_to_point( self, calculated_goal_pos, 50, speed_mult );
    
    /#
        if ( debug_move() )
        {
            line( self.origin, vehicle.origin, ( 0.8, 0.2, 0 ) );
            print3d( averagepoint( [ self.origin, vehicle.origin ] ), "<dev string:xfd>" + var_29a854e4eea0df7d + "<dev string:x118>" + var_848404b2488d9abd, ( 1, 0, 0 ) );
            line( var_88d64ea5ef4734b4, var_a0b4d811ec584fcd, ( 0.6, 0.4, 0 ) );
            line( calculated_goal_pos, calculated_goal_pos - ( 0, 0, z_increase ), ( 0.6, 0.4, 0 ) );
            
            if ( var_34052cd8673eb929 && var_34052cd8673eb929.size > 0 )
            {
                line( var_34052cd8673eb929[ 0 ], var_34052cd8673eb929[ 1 ], ( 0.6, 0.5, 0 ) );
            }
        }
    #/
    
    return anim.success;
}

// Namespace zombie_hermes_move
// Params 1, eflags: 0x4
// Checksum 0xa2c6b1f3, Offset: 0x2b6a
// Size: 0x194
function private get_movement_properties( hermes )
{
    var_10ceb6b70c29c3b9 = {};
    var_10ceb6b70c29c3b9.min_range = 0;
    var_10ceb6b70c29c3b9.var_87dc7c3440796378 = 100;
    var_10ceb6b70c29c3b9.max_speed = getdvarfloat( @"hash_1714a40f2520153", 6 );
    var_10ceb6b70c29c3b9.accel = getdvarfloat( @"hash_e69c1e688a1e8b1", 1 );
    var_10ceb6b70c29c3b9.var_c75d8bd66ee23e11 = getdvarfloat( @"hash_d19af75c0ae23f74", 100 );
    var_10ceb6b70c29c3b9.var_1d900ecc45384e17 = getdvarfloat( @"hash_45811b9939875d76", 500 );
    var_10ceb6b70c29c3b9.var_bfa8c719d50fc54d = getdvarfloat( @"hash_bc8f74189e7b95ca", 4 );
    
    switch ( hermes.var_3196011060b46013 )
    {
        case 1:
            break;
        case 2:
            var_10ceb6b70c29c3b9.max_speed = 6.5;
            var_10ceb6b70c29c3b9.var_bfa8c719d50fc54d = 6;
            var_10ceb6b70c29c3b9.var_c75d8bd66ee23e11 = 300;
            var_10ceb6b70c29c3b9.var_1d900ecc45384e17 = 700;
            var_10ceb6b70c29c3b9.accel = 1.35;
            break;
        case 3:
            var_10ceb6b70c29c3b9.max_speed = 7;
            var_10ceb6b70c29c3b9.var_bfa8c719d50fc54d = 7;
            var_10ceb6b70c29c3b9.var_c75d8bd66ee23e11 = 600;
            var_10ceb6b70c29c3b9.var_1d900ecc45384e17 = 900;
            var_10ceb6b70c29c3b9.accel = 3;
            break;
    }
    
    return var_10ceb6b70c29c3b9;
}

// Namespace zombie_hermes_move
// Params 3, eflags: 0x4
// Checksum 0x4329ebe4, Offset: 0x2d07
// Size: 0x1b8
function private function_9e70f4e55d08dd55( var_4c1cb74fbd599725, var_f69827bbfb33eb2b, accel )
{
    var_4c1cb74fbd599725.hermes_velocity = math::function_b642fd3e37ae7eb4( var_4c1cb74fbd599725.hermes_velocity, var_f69827bbfb33eb2b, accel );
    new_vel_z = math::function_b77296185c2d6c26( var_4c1cb74fbd599725.hermes_velocity[ 2 ], var_f69827bbfb33eb2b[ 2 ], accel * 0.5 );
    var_4c1cb74fbd599725.hermes_velocity = ( var_4c1cb74fbd599725.hermes_velocity[ 0 ], var_4c1cb74fbd599725.hermes_velocity[ 1 ], new_vel_z );
    current_speed = length( var_4c1cb74fbd599725.hermes_velocity );
    new_origin = var_4c1cb74fbd599725.origin + var_4c1cb74fbd599725.hermes_velocity;
    var_4c1cb74fbd599725.origin = new_origin;
    function_9ef4aabfd3bc06dd( var_4c1cb74fbd599725, var_f69827bbfb33eb2b );
    function_6aca403a19bcb4a( var_4c1cb74fbd599725 );
    spin_speed = getdvarfloat( @"hash_da20b91a55c06da1", -1 );
    
    if ( spin_speed < 0 )
    {
        spin_speed = var_4c1cb74fbd599725.var_c756062136c44231;
    }
    
    modified_angles = 0;
    new_angles = ( 0, var_4c1cb74fbd599725.angles[ 1 ], 0 );
    
    if ( spin_speed != 0 )
    {
        new_angles += ( 0, spin_speed * level.framedurationseconds, 0 );
        modified_angles = 1;
    }
    
    if ( var_4c1cb74fbd599725.hermes_tilt != ( 0, 0, 0 ) )
    {
        new_angles += var_4c1cb74fbd599725.hermes_tilt;
        modified_angles = 1;
    }
    
    if ( modified_angles )
    {
        var_4c1cb74fbd599725 forceteleport( var_4c1cb74fbd599725.origin, new_angles );
    }
    
    var_4c1cb74fbd599725.hermes_target_vel = var_f69827bbfb33eb2b;
}

// Namespace zombie_hermes_move
// Params 2, eflags: 0x4
// Checksum 0x5b6ab565, Offset: 0x2ec7
// Size: 0x8a
function private function_f40072531d9a1109( to_goal_pos, move_props )
{
    max_speed = move_props.max_speed;
    dist_to_goal = length( to_goal_pos );
    speedup_multiplier = clamp( math::remap( dist_to_goal, move_props.var_c75d8bd66ee23e11, move_props.var_1d900ecc45384e17, 1, move_props.var_bfa8c719d50fc54d ), 1, move_props.var_bfa8c719d50fc54d );
    max_speed *= speedup_multiplier;
    return max_speed;
}

// Namespace zombie_hermes_move
// Params 1, eflags: 0x4
// Checksum 0x6551b046, Offset: 0x2f5a
// Size: 0x38e
function private get_goal_point( hermes )
{
    target = hermes.enemy;
    
    if ( !isdefined( target ) )
    {
        return;
    }
    
    circle_points = get_circle_points( hermes, target );
    var_df9adb69b75ff5f3 = target getvelocity();
    
    if ( lengthsquared( var_df9adb69b75ff5f3 ) > 0 && 0 )
    {
        normalized_velocity = vectornormalize( var_df9adb69b75ff5f3 );
        right_velocity = vectorcross( ( 0, 0, 1 ), normalized_velocity );
        left_velocity = right_velocity * -1;
        offset = 1000;
        closest_point_forward = function_b21056d585c710d( circle_points, hermes.origin );
        closest_point = function_b21056d585c710d( [ closest_point_forward ], hermes.origin );
        velocity_offset = getdvarfloat( @"hash_e4d310d01447d703", 500 );
        closest_point.origin += normalized_velocity * velocity_offset;
        
        /#
            if ( debug_move() )
            {
                line( closest_point.origin, closest_point.origin - normalized_velocity * velocity_offset, ( 0, 0.2, 1 ) );
            }
        #/
    }
    else
    {
        closest_point = function_b21056d585c710d( circle_points, hermes.origin );
    }
    
    closest_point_on_navmesh = getclosestpointonnavmesh( closest_point.origin );
    
    /#
        if ( debug_move() )
        {
            line( closest_point_on_navmesh, hermes.origin, ( 0, 0.4, 0.8 ) );
            print3d( closest_point_on_navmesh, "<dev string:x1c8>", ( 0, 0.4, 0.8 ) );
        }
    #/
    
    closest_point_on_navmesh = function_7dd3747e8dbfac11( hermes, closest_point_on_navmesh );
    forward_dist = 200;
    var_72ba7c45632cbb74 = math::function_b642fd3e37ae7eb4( hermes.origin, closest_point_on_navmesh, forward_dist );
    var_985134d949a7d0c4 = get_circle_points( hermes, { #origin:var_72ba7c45632cbb74 }, self getboundshalfsize()[ 1 ] );
    highest_z = closest_point_on_navmesh[ 2 ];
    
    foreach ( point in var_985134d949a7d0c4 )
    {
        nav_pos = getclosestpointonnavmesh( point.origin );
        
        if ( isdefined( nav_pos ) )
        {
            if ( !isdefined( highest_z ) || nav_pos[ 2 ] > highest_z )
            {
                highest_z = nav_pos[ 2 ];
            }
            
            /#
                if ( debug_move() )
                {
                    sphere( nav_pos, 15, ( 0.6, 0.3, 0.4 ) );
                }
            #/
        }
    }
    
    closest_point_on_ground = ( closest_point_on_navmesh[ 0 ], closest_point_on_navmesh[ 1 ], highest_z );
    
    /#
        if ( debug_move() )
        {
            sphere( closest_point_on_ground, 10, ( 0.3, 0.4, 0.4 ) );
            print3d( closest_point_on_ground, "<dev string:x1dc>", ( 0.3, 0.4, 0.4 ), 1, 0.4 );
            print3d( closest_point.origin, "<dev string:x1ed>", ( 0, 0.6, 0.3 ), 1, 0.7 );
            print3d( closest_point_on_navmesh, "<dev string:x201>", ( 0, 0.6, 0.4 ), 1, 0.7 );
        }
    #/
    
    return closest_point_on_ground;
}

// Namespace zombie_hermes_move
// Params 2, eflags: 0x4
// Checksum 0xbf755701, Offset: 0x32f1
// Size: 0x367
function private function_7dd3747e8dbfac11( hermes, target_pos )
{
    fixed_trace_offset = ( 0, 0, 200 );
    padding = getdvarfloat( @"hash_8232d95ffab3bf75", 400 );
    physics_contents = physics_createcontents( [ "physicscontents_aiclip" ] );
    to_target_pos = target_pos - hermes.origin;
    var_5438fc6c50b2639b = vectornormalize( to_target_pos );
    right_offset = vectorcross( var_5438fc6c50b2639b, ( 0, 0, 1 ) ) * getdvarfloat( @"hash_1cda4a9a2f51b05f", 100 );
    trace_offsets = [ ( 0, 0, 0 ), right_offset, right_offset * -1 ];
    ignore_list = arraycombine( hermes.hermes_brush_model, [ hermes.hermes_missile_turret, hermes.var_8361d0196aa3fa4f ] );
    fixed_trace_offset = ( 0, 0, 320 );
    sphere_origin = hermes.origin + fixed_trace_offset;
    sphere_radius = 300;
    trace_start = sphere_origin + var_5438fc6c50b2639b * max( length( hermes.hermes_velocity ), 100 );
    trace_end = target_pos + fixed_trace_offset + ( 0, 0, 70 );
    trace_dir = vectornormalize( trace_end - trace_start );
    sphere_trace = trace::sphere_trace( trace_start, trace_end, sphere_radius, ignore_list, physics_contents );
    sphere_trace_normal = utility::flatten_vector( sphere_trace[ "contact_normal" ] );
    
    if ( length2dsquared( sphere_trace_normal ) <= 0 )
    {
        closest_point_on_line = math::function_2e0e9b10b9c74d9e( sphere_trace[ "position" ], trace_start, trace_end );
        sphere_trace_normal = utility::flatten_vector( closest_point_on_line - sphere_trace[ "position" ] );
    }
    
    var_e3413ffc094b80d9 = sphere_trace[ "fraction" ] < 1;
    var_84688c61ac81230a = vectordot( sphere_trace[ "position" ] - trace_start, trace_dir ) * trace_dir + trace_start;
    var_c38cb7ef38af3276 = distance( var_84688c61ac81230a, trace_end );
    
    /#
        if ( debug_move() )
        {
            trace_col = var_e3413ffc094b80d9 ? ( 1, 0, 0 ) : ( 0, 1, 0 );
            sphere( trace_start, sphere_radius, trace_col );
            sphere( trace_end, sphere_radius, trace_col );
            sphere( sphere_trace[ "<dev string:x21b>" ], 15, trace_col );
            line( sphere_trace[ "<dev string:x21b>" ], sphere_trace[ "<dev string:x21b>" ] + sphere_trace_normal * 200, trace_col );
            line( sphere_trace[ "<dev string:x21b>" ], trace_end, trace_col, 0.3 );
            print3d( sphere_trace[ "<dev string:x21b>" ], "<dev string:x224>" + var_c38cb7ef38af3276 + "<dev string:x236>", trace_col, 1, 0.7 );
        }
    #/
    
    if ( var_e3413ffc094b80d9 )
    {
        var_f8d3b1c4cf8fd5d1 = sphere_trace[ "position" ] + sphere_trace_normal * padding;
        target_pos_on_navmesh = getclosestpointonnavmesh( var_f8d3b1c4cf8fd5d1 );
        
        if ( isfunction( self.var_870c37c6f0744773 ) )
        {
            if ( ![[ self.var_870c37c6f0744773 ]]( target_pos_on_navmesh ) )
            {
                return target_pos;
            }
        }
        
        if ( var_c38cb7ef38af3276 < 500 )
        {
            target_pos = target_pos_on_navmesh;
        }
        else
        {
            z_pad = 0;
            target_pos = target_pos_on_navmesh;
        }
        
        return target_pos;
    }
    
    return target_pos;
}

// Namespace zombie_hermes_move
// Params 3, eflags: 0x4
// Checksum 0xf62738fc, Offset: 0x3661
// Size: 0x16e
function private get_circle_points( hermes, target, radius )
{
    var_b0d5cd39c09706b0 = 8;
    radius = radius ?? getdvarfloat( @"hash_dda883aac8a24ef3", 1000 );
    
    if ( hermes utility::ent_flag( "hermes_summon_zombies" ) )
    {
        radius *= 0.5;
    }
    
    var_66f0bcd0ba4c8203 = [];
    slot_i = 0;
    
    while ( slot_i < var_b0d5cd39c09706b0 )
    {
        to_target_angles = vectortoangles( target.origin - hermes.origin );
        angle_deg = 0;
        angle_deg += 360 / var_b0d5cd39c09706b0 * slot_i;
        dir = anglestoforward( ( 0, angle_deg, 0 ) );
        circle_point = target.origin + dir * radius;
        point_struct = { #var_5241ba87f67e6575:slot_i, #origin:circle_point };
        
        if ( isfunction( self.var_870c37c6f0744773 ) )
        {
            jumpiffalse(![[ self.var_870c37c6f0744773 ]]( circle_point )) LOC_00000129;
        }
        else
        {
        LOC_00000129:
            var_66f0bcd0ba4c8203[ var_66f0bcd0ba4c8203.size ] = point_struct;
        }
        
        slot_i += 1;
    }
    
    if ( var_66f0bcd0ba4c8203.size <= 0 )
    {
        point_struct = { #var_5241ba87f67e6575:slot_i, #origin:hermes.origin };
        var_66f0bcd0ba4c8203[ var_66f0bcd0ba4c8203.size ] = point_struct;
    }
    
    return var_66f0bcd0ba4c8203;
}

// Namespace zombie_hermes_move
// Params 1, eflags: 0x4
// Checksum 0x443be1ce, Offset: 0x37d8
// Size: 0x233
function private get_bump_target( hermes )
{
    ent = hermes.enemy;
    var_fdc5e4472f1e2a76 = hermes function_f017e352a29a57a1( self.origin, 2000, 1 );
    
    foreach ( enemy in var_fdc5e4472f1e2a76 ?? [] )
    {
        if ( enemy.vehicle )
        {
            ent = enemy;
            break;
        }
    }
    
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    bump_target = ent.vehicle;
    vehicle = ent.vehicle;
    
    if ( !isdefined( bump_target ) )
    {
        return;
    }
    
    vehicle_velocity = vehicle vehicle_getvelocity();
    var_e804f0a5dce2fe2e = length( vehicle_velocity );
    
    if ( var_e804f0a5dce2fe2e < 100 )
    {
        return;
    }
    
    vehicle_dir = vectornormalize( vehicle_velocity );
    to_vehicle = vehicle.origin - hermes.origin;
    
    if ( vectordot( to_vehicle, vehicle_dir ) >= 0 )
    {
        return;
    }
    
    dist_to_vehicle = distance( vehicle.origin, hermes.origin );
    var_4193955b25309ca2 = getdvarfloat( @"hash_7cfafd01ebe8bb47", 750 );
    
    if ( hermes utility::ent_flag( "hermes_gamera_spin_fast" ) )
    {
        var_4193955b25309ca2 = getdvarfloat( @"hash_c457a724c4114310", 1000 );
    }
    
    if ( dist_to_vehicle > var_4193955b25309ca2 )
    {
        return;
    }
    
    /#
        if ( debug_move() )
        {
            col = ( 0.9, 0.4, 0 );
            utility::draw_circle( hermes.origin, var_4193955b25309ca2, col );
            print3d( hermes.origin + ( 0, 0, -100 ), "<dev string:x238>", col, 0.8, 0.7 );
        }
    #/
    
    return vehicle;
}

// Namespace zombie_hermes_move
// Params 1, eflags: 0x4
// Checksum 0x870f66d3, Offset: 0x3a14
// Size: 0xe8
function private get_vehicle_target( hermes )
{
    ent = hermes.enemy;
    var_fdc5e4472f1e2a76 = hermes function_f017e352a29a57a1( self.origin, 6000, 1 );
    
    foreach ( enemy in var_fdc5e4472f1e2a76 ?? [] )
    {
        if ( enemy.vehicle )
        {
            ent = enemy;
            break;
        }
    }
    
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    vehicle = ent.vehicle;
    
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    return vehicle;
}

// Namespace zombie_hermes_move
// Params 1, eflags: 0x4
// Checksum 0x76c18f2e, Offset: 0x3b05
// Size: 0xf6
function private get_ufo_target( hermes )
{
    vehicles = vehicle_getarrayinradius( hermes.origin, 3000 );
    
    if ( vehicles.size > 0 )
    {
        target_vehicle = undefined;
        
        foreach ( vehicle in vehicles )
        {
            if ( !vehicle vehicle_isphysveh() )
            {
                continue;
            }
            
            if ( vehicle.vehicletype == %"veh_rcxd" )
            {
                continue;
            }
            
            occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( vehicle, 0 );
            
            if ( occupants.size <= 0 )
            {
                target_vehicle = vehicle;
                break;
            }
        }
        
        if ( target_vehicle )
        {
            return target_vehicle;
        }
    }
}

// Namespace zombie_hermes_move
// Params 1, eflags: 0x4
// Checksum 0x7a8dc4a0, Offset: 0x3c04
// Size: 0xdd
function private function_2a905d02f6815bc6( hermes )
{
    var_fdc5e4472f1e2a76 = hermes function_f017e352a29a57a1( hermes.origin, 3000, 1 );
    smallest_speed = undefined;
    slowest_enemy = undefined;
    
    foreach ( enemy in var_fdc5e4472f1e2a76 )
    {
        enemy_speed = length( enemy getvelocity() );
        
        if ( !smallest_speed || enemy_speed < smallest_speed )
        {
            smallest_speed = enemy_speed;
            slowest_enemy = enemy;
        }
    }
    
    if ( slowest_enemy )
    {
        return slowest_enemy;
    }
}

// Namespace zombie_hermes_move
// Params 4, eflags: 0x4
// Checksum 0x1c8fd5e1, Offset: 0x3cea
// Size: 0xd5
function private function_845f3c4a54dc895a( var_76af8187404125b4, num_turns = 1, var_64f5c465d19507dd, radius_end = 0 )
{
    var_2c7f6da0fe0c9e0f = 1 - cos( var_76af8187404125b4 * 90 );
    var_9cb7c9391783189f = isvector( var_64f5c465d19507dd ) ? length2d( var_64f5c465d19507dd ) : var_64f5c465d19507dd;
    radius = math::lerp( var_9cb7c9391783189f, radius_end, var_2c7f6da0fe0c9e0f );
    angle_start_offset = isvector( var_64f5c465d19507dd ) ? vectortoyaw( var_64f5c465d19507dd ) : 0;
    angle = 360 * num_turns * var_76af8187404125b4 + angle_start_offset;
    offset = ( radius * cos( angle ), radius * sin( angle ), 0 );
    return offset;
}

// Namespace zombie_hermes_move
// Params 3, eflags: 0x4
// Checksum 0xcd58f8a7, Offset: 0x3dc8
// Size: 0xa6
function private function_217ede6000f26bb3( var_76af8187404125b4, num_turns = 1, var_64f5c465d19507dd )
{
    var_9cb7c9391783189f = isvector( var_64f5c465d19507dd ) ? length2d( var_64f5c465d19507dd ) : var_64f5c465d19507dd;
    radius = var_9cb7c9391783189f;
    angle_start_offset = isvector( var_64f5c465d19507dd ) ? vectortoyaw( var_64f5c465d19507dd ) : 0;
    angle = 360 * num_turns * var_76af8187404125b4 + angle_start_offset;
    offset = ( radius * cos( angle ), radius * sin( angle ), 0 );
    return offset;
}

// Namespace zombie_hermes_move
// Params 4, eflags: 0x4
// Checksum 0x283a608, Offset: 0x3e77
// Size: 0x1ee
function private move_to_point( hermes, goal_pos, slowdown_dist, speed_mult = 1 )
{
    assert( goal_pos );
    
    if ( !goal_pos )
    {
        return;
    }
    
    start_pos = getclosestpointonnavmesh( self.origin );
    dist = distance( start_pos, goal_pos );
    
    /#
        if ( debug_move() )
        {
            print3d( self.origin + ( 0, 0, 100 ), "<dev string:x24>" + dist, ( 1, 0, 0 ) );
            sphere( goal_pos, 10, ( 1, 0, 0 ) );
            print3d( goal_pos + ( 0, 0, 30 ), "<dev string:x44>", ( 1, 0, 0 ) );
        }
    #/
    
    goal_pos += ( 0, 0, 70 );
    var_4c1cb74fbd599725 = self;
    move_props = get_movement_properties( self );
    min_range = move_props.min_range;
    var_87dc7c3440796378 = move_props.var_87dc7c3440796378;
    accel = move_props.accel;
    
    if ( utility::ent_flag( "hermes_pushback_recently" ) )
    {
        accel *= 0.2;
    }
    
    to_goal_pos = goal_pos - var_4c1cb74fbd599725.origin;
    max_speed = function_f40072531d9a1109( to_goal_pos, move_props );
    dist_to_goal = length( to_goal_pos );
    
    if ( dist_to_goal < slowdown_dist )
    {
        max_speed *= math::remap( dist_to_goal, 0, slowdown_dist, 0, 1 );
    }
    
    max_speed *= speed_mult;
    accel *= speed_mult;
    var_f69827bbfb33eb2b = vectornormalize( to_goal_pos );
    var_f69827bbfb33eb2b *= max_speed;
    function_9e70f4e55d08dd55( var_4c1cb74fbd599725, var_f69827bbfb33eb2b, accel );
    return 1;
}

// Namespace zombie_hermes_move
// Params 5, eflags: 0x4
// Checksum 0xf4210b6, Offset: 0x406e
// Size: 0x38c, Type: bool
function private tilt_to_point( hermes, tilt_to_pos, tilt_angles, slowdown_angles, speed_mult = 1 )
{
    hermes.var_a5c4eb35e30da059 = gettime();
    start_pos = getclosestpointonnavmesh( self.origin );
    var_14f45c888dee2dd1 = vectortoangles( tilt_to_pos - hermes.origin );
    target_yaw = angleclamp180( var_14f45c888dee2dd1[ 1 ] - hermes.angles[ 1 ] );
    pitch_deg = round( cos( target_yaw ) * -1 * tilt_angles );
    roll_deg = round( sin( target_yaw ) * tilt_angles );
    hermes.var_81170b2300e32aa2 = ( pitch_deg, 0, roll_deg ) * -1;
    angles_to_goal = anglesdelta( hermes.var_81170b2300e32aa2, hermes.hermes_tilt );
    tilt_speed = speed_mult;
    
    if ( angles_to_goal < slowdown_angles )
    {
    }
    
    lerped_angles = anglelerpquatfrac( hermes.hermes_tilt, hermes.var_81170b2300e32aa2, tilt_speed );
    p = angleclamp180( lerped_angles[ 0 ] );
    y = angleclamp180( lerped_angles[ 1 ] );
    r = angleclamp180( lerped_angles[ 2 ] );
    
    if ( abs( y ) > 90 )
    {
        y += y > 0 ? -180 : 180;
        r += 180;
    }
    
    p = angleclamp180( p );
    r = angleclamp180( r );
    hermes.hermes_tilt = ( p, 0, r );
    
    /#
        if ( debug_move() )
        {
            print3d( self.origin + ( 0, 0, 200 ), "<dev string:x24b>" + tilt_speed + "<dev string:x258>" + angles_to_goal + "<dev string:x26c>" + target_yaw, ( 1, 0.2, 0.2 ) );
            print3d( self.origin + ( 0, 0, 250 ), "<dev string:x27d>" + hermes.angles[ 0 ] + "<dev string:x28f>" + hermes.angles[ 1 ] + "<dev string:x28f>" + hermes.angles[ 2 ] + "<dev string:x236>", ( 1, 0.2, 0.2 ) );
            print3d( self.origin + ( 0, 0, 300 ), "<dev string:x291>" + hermes.hermes_tilt[ 0 ] + "<dev string:x28f>" + hermes.hermes_tilt[ 1 ] + "<dev string:x28f>" + hermes.hermes_tilt[ 2 ] + "<dev string:x236>", ( 1, 0.2, 0.2 ) );
            line( self.origin, self.origin + anglestoforward( var_14f45c888dee2dd1 ) * 500, ( 1, 0.2, 0.2 ) );
            line( self.origin, self.origin + anglestoforward( hermes.angles ) * 500, ( 0.2, 0.2, 1 ) );
            line( self.origin, self.origin + anglestoforward( ( 0, hermes.angles[ 1 ], 0 ) ) * 500, ( 0.2, 1, 0.2 ) );
        }
    #/
    
    return true;
}

// Namespace zombie_hermes_move
// Params 1
// Checksum 0xee58f9ed, Offset: 0x4403
// Size: 0x29d
function function_7115fba9ef789d9( hermes )
{
    hermes endon( #"death" );
    
    if ( hermes utility::ent_flag( "marked_for_death" ) )
    {
        return;
    }
    
    hermes utility::ent_flag_set( "hermes_gamera_spin" );
    hermes endon( #"hermes_gamera_spin" );
    hermes function_786bb6aa1b76c7ee( "is_spinning", 1 );
    hermes asm::function_7256f5ba459c840b( "spin_in" );
    hermes utility::ent_flag_set( "zm_mod_health_regen_disable" );
    var_107188671fe90184 = [ 200, 350, 650 ];
    var_e5c505801437db87 = [ gettime() + 50, gettime() + 1000, gettime() + 3000 ];
    var_f15429d62926aac9 = 75;
    start_speed = 100;
    start_time = gettime();
    spin_speed = 0;
    spin_index = 0;
    
    while ( spin_index < var_107188671fe90184.size )
    {
        while ( var_e5c505801437db87[ spin_index ] && gettime() > var_e5c505801437db87[ spin_index ] )
        {
            spin_index++;
        }
        
        if ( spin_index >= 2 )
        {
            var_e03a976980256ff1 = zombie_hermes_metabones::get_all_heads( hermes );
            var_628c056734fea0a3 = 1;
            
            foreach ( head in var_e03a976980256ff1 )
            {
                hermes utility::function_32b24db3127bff40( head + "_spin", "spin" );
                var_628c056734fea0a3 = !var_628c056734fea0a3;
            }
            
            hermes utility::ent_flag_set( "hermes_gamera_spin_immune" );
            hermes utility::ent_flag_set( "hermes_gamera_spin_fast" );
            hermes callback::callback( "on_hermes_gamera_spin_immune" );
            zombie_hermes_metabones::function_5ae8f1abadd9aea6( hermes, 1 );
        }
        
        var_a69a372cc48f15c1 = var_107188671fe90184[ spin_index - 1 ] ?? start_speed;
        var_a684c3c17f27d320 = var_107188671fe90184[ spin_index ] ?? var_107188671fe90184[ spin_index - 1 ];
        spin_time_start = ( var_e5c505801437db87[ spin_index ] ?? var_e5c505801437db87[ spin_index - 1 ] ) - var_f15429d62926aac9;
        spin_time_end = ( var_e5c505801437db87[ spin_index ] ?? var_e5c505801437db87[ spin_index - 1 ] ) + 1;
        var_36a1fd3159326b3f = clamp( math::lerp_fraction( spin_time_start, spin_time_end, gettime() ), 0, 1 );
        spin_speed = easing::ease_sine( var_a69a372cc48f15c1, var_a684c3c17f27d320, var_36a1fd3159326b3f, 1, 1 );
        hermes.var_c756062136c44231 = spin_speed;
        waitframe();
    }
}

// Namespace zombie_hermes_move
// Params 2
// Checksum 0x5c8f75ef, Offset: 0x46a8
// Size: 0x163
function function_5308069777f513f1( hermes, var_67d351a7f9128818 = 0 )
{
    if ( !hermes utility::ent_flag( "hermes_gamera_spin" ) )
    {
        return;
    }
    
    hermes utility::ent_flag_clear( "hermes_gamera_spin" );
    hermes utility::ent_flag_clear( "hermes_gamera_spin_immune" );
    hermes utility::ent_flag_clear( "hermes_gamera_spin_fast" );
    hermes utility::ent_flag_clear( "zm_mod_health_regen_disable" );
    hermes function_786bb6aa1b76c7ee( "is_spinning", 0 );
    var_e03a976980256ff1 = zombie_hermes_metabones::get_all_heads( hermes );
    
    foreach ( head in var_e03a976980256ff1 )
    {
        hermes utility::function_32b24db3127bff40( head + "_spin", "off" );
    }
    
    if ( !var_67d351a7f9128818 )
    {
        hermes.var_c756062136c44231 = 0;
        return;
    }
    
    hermes endon( #"death" );
    
    while ( hermes.var_c756062136c44231 > 0 )
    {
        hermes.var_c756062136c44231 = math::lerp( hermes.var_c756062136c44231, 0, level.framedurationseconds );
        waitframe();
    }
}

// Namespace zombie_hermes_move
// Params 3
// Checksum 0xff04e258, Offset: 0x4813
// Size: 0x23a
function function_b7220f627ff98dd5( hermes, head, target_ent )
{
    hermes endon( #"death" );
    
    if ( hermes utility::ent_flag( "hermes_gamera_spin" ) )
    {
        waitframe();
        hermes notify( #"hermes_can_summon" );
        return;
    }
    
    if ( hermes utility::ent_flag( "hermes_beaming" ) || hermes getaiblackboarddynamic( "in_beam_charge" ) > 0 )
    {
        waitframe();
        hermes notify( #"hermes_can_summon" );
        return;
    }
    
    var_72649bf3c2f92442 = undefined;
    level callback::callback( "vo_launch_zombie_attack" );
    
    while ( target_ent && hermes utility::ent_flag( "hermes_summon_zombies" ) )
    {
        predicted_origin = target_ent.origin;
        
        if ( target_ent.vehicle )
        {
            predicted_origin += target_ent.vehicle vehicle_getvelocity();
        }
        else if ( isplayer( target_ent ) )
        {
            predicted_origin += target_ent getvelocity();
        }
        
        hermes thread function_42a8778d1dbccf41( hermes, head, predicted_origin, 10 );
        hermes thread tilt_to_point( hermes, predicted_origin, 20, 2, 0.2 );
        to_target_ent = utility::flatten_vector( predicted_origin - self.origin );
        var_6a1cfc5c28a478f4 = vectortoangles( to_target_ent );
        head_tag = zombie_hermes_metabones::get_head_tag( head );
        var_cbae022e329d2a51 = hermes gettagangles( head_tag );
        angle_yaw_delta = angleclamp180( var_6a1cfc5c28a478f4[ 1 ] - var_cbae022e329d2a51[ 1 ] );
        angle_yaw_sign = utility::sign( angle_yaw_delta );
        
        if ( abs( angle_yaw_delta ) < getdvarfloat( @"hash_f040403a8ac89427", 20 ) )
        {
            hermes notify( #"hermes_can_summon" );
        }
        
        waitframe();
    }
    
    hermes notify( #"hash_82b74369c8ef96dc" );
    
    while ( abs( hermes.var_c756062136c44231 ) > 0 )
    {
        var_fee2680f31c57f3e = getdvarfloat( @"hash_a0cb32056bf02b2f", 4 );
        
        if ( !hermes utility::ent_flag( "hermes_gamera_spin" ) )
        {
            hermes.var_c756062136c44231 = math::function_b77296185c2d6c26( hermes.var_c756062136c44231, 0, var_fee2680f31c57f3e );
        }
        
        waitframe();
    }
    
    hermes utility::ent_flag_clear( "hermes_summon_spin" );
}

// Namespace zombie_hermes_move
// Params 4
// Checksum 0xab399da2, Offset: 0x4a55
// Size: 0x207
function function_42a8778d1dbccf41( hermes, head, target_pos, slowdown_angles = 10 )
{
    self notify( #"hash_e4c3ee6ed4468208" );
    self endon( #"hash_e4c3ee6ed4468208" );
    hermes endon( #"death" );
    hermes endon( #"hash_82b74369c8ef96dc" );
    
    if ( hermes utility::ent_flag( "hermes_gamera_spin" ) )
    {
        return;
    }
    
    to_target_pos = utility::flatten_vector( target_pos - self.origin );
    var_6dfabfa84d298a25 = vectortoangles( to_target_pos );
    
    while ( true )
    {
        if ( hermes utility::ent_flag( "hermes_gamera_spin" ) )
        {
            return;
        }
        
        head_tag = zombie_hermes_metabones::get_head_tag( head );
        var_f06c3d8143b76949 = hermes gettagorigin( head_tag );
        var_cbae022e329d2a51 = ( 0, vectortoyaw( var_f06c3d8143b76949 - self.origin ), 0 );
        angle_yaw_delta = angleclamp180( var_6dfabfa84d298a25[ 1 ] - var_cbae022e329d2a51[ 1 ] );
        angle_yaw_sign = utility::sign( angle_yaw_delta );
        max_rotation_speed = getdvarfloat( @"hash_7359629c8e591e70", 180 );
        rotation_accel = getdvarfloat( @"hash_d7e7390d6904381e", 9 );
        
        if ( abs( angle_yaw_delta ) < slowdown_angles )
        {
            max_rotation_speed *= math::remap( abs( angle_yaw_delta ), 0, slowdown_angles, 0, 1 );
        }
        
        if ( abs( angle_yaw_delta ) < 1 )
        {
            hermes.var_c756062136c44231 = 0;
            return;
        }
        
        hermes.var_c756062136c44231 = math::function_b77296185c2d6c26( hermes.var_c756062136c44231, max_rotation_speed * angle_yaw_sign, rotation_accel );
        
        /#
            if ( debug_move() )
            {
                line( var_f06c3d8143b76949, var_f06c3d8143b76949 + anglestoforward( var_6dfabfa84d298a25 ) * 100, ( 0.8, 0.1, 0.1 ) );
                print3d( var_f06c3d8143b76949 + anglestoforward( var_6dfabfa84d298a25 ) * 100, "<dev string:x2a0>" + angle_yaw_delta, ( 0.8, 0.1, 0.1 ) );
            }
        #/
        
        waitframe();
    }
}

// Namespace zombie_hermes_move
// Params 2, eflags: 0x4
// Checksum 0xbc27ee21, Offset: 0x4c64
// Size: 0x205
function private function_9ef4aabfd3bc06dd( hermes, var_f69827bbfb33eb2b )
{
    if ( hermes utility::ent_flag( "hermes_gamera_spin" ) )
    {
        return;
    }
    
    if ( hermes utility::ent_flag( "hermes_beaming" ) )
    {
        return;
    }
    
    if ( hermes utility::ent_flag( "hermes_summon_zombies" ) )
    {
        return;
    }
    
    if ( hermes.var_a5c4eb35e30da059 == gettime() )
    {
        return;
    }
    
    if ( !isdefined( hermes.hermes_spin_dir ) )
    {
        hermes.hermes_spin_dir = 1;
    }
    
    is_sharp_turn = 0;
    
    if ( vectordot( hermes.hermes_target_vel, var_f69827bbfb33eb2b ) < 0 )
    {
        is_sharp_turn = 1;
    }
    
    hermes_dir = vectornormalize2( hermes.hermes_velocity );
    var_f7d0ad07cdcbb49b = vectordot( vectornormalize2( var_f69827bbfb33eb2b ), hermes_dir );
    var_c78fe091cb77a6b0 = var_f7d0ad07cdcbb49b * -1;
    abs_dot_product = abs( var_c78fe091cb77a6b0 );
    max_spin = getdvarfloat( @"hash_8269721654500d21", 240 );
    var_d754aeb6682a298a = getdvarfloat( @"hash_dc3c50aebeb929c6", 4 );
    var_fee2680f31c57f3e = getdvarfloat( @"hash_e3f9c6f58509c732", 2 );
    spin_to_add = 0;
    
    if ( var_c78fe091cb77a6b0 > -0.8 && hermes_dir != ( 0, 0, 0 ) )
    {
        hermes.var_c756062136c44231 = math::function_b77296185c2d6c26( hermes.var_c756062136c44231, max_spin * hermes.hermes_spin_dir, var_d754aeb6682a298a * abs_dot_product );
    }
    else
    {
        hermes.var_c756062136c44231 = math::function_b77296185c2d6c26( hermes.var_c756062136c44231, 0, var_fee2680f31c57f3e );
    }
    
    /#
        if ( debug_move() )
        {
            print3d( hermes.origin + ( 0, 0, 300 ), "<dev string:x2b5>" + hermes.var_c756062136c44231 + "<dev string:x2c2>" + var_c78fe091cb77a6b0, ( 0, 0, 1 ) );
        }
    #/
}

// Namespace zombie_hermes_move
// Params 1, eflags: 0x4
// Checksum 0xe2ddf5b4, Offset: 0x4e71
// Size: 0x1dc
function private function_6aca403a19bcb4a( hermes )
{
    if ( hermes.var_a5c4eb35e30da059 == gettime() )
    {
        return;
    }
    
    hermes_dir = vectornormalize2( hermes.hermes_target_vel );
    hermes_speed = length( hermes.hermes_target_vel );
    tilt_speed = getdvarfloat( @"hash_2d16a5c9a560352", 0.1 );
    var_d96bb9b123d5222f = getdvarfloat( @"hash_150c37cb47bd8d4f", 30 );
    var_7134c4818c57928b = getdvarfloat( @"hash_7d516e30aa883934", 0.5 );
    
    if ( hermes utility::ent_flag( "hermes_gamera_spin_fast" ) )
    {
        tilt_speed = getdvarfloat( @"hash_309f062ba1610a54", 0.3 );
        var_d96bb9b123d5222f = getdvarfloat( @"hash_7dd71aecbe10def3", 60 );
    }
    
    if ( hermes_speed <= 0 )
    {
        hermes.var_81170b2300e32aa2 = ( 0, 0, 0 );
        hermes.hermes_tilt = anglelerpquatfrac( hermes.hermes_tilt, hermes.var_81170b2300e32aa2, tilt_speed );
        return;
    }
    
    var_14f45c888dee2dd1 = vectortoangles( hermes_dir );
    yaw_delta = angleclamp180( var_14f45c888dee2dd1 - hermes.angles[ 1 ] )[ 1 ];
    var_87bf6371fd21907b = min( hermes_speed * var_7134c4818c57928b, var_d96bb9b123d5222f );
    pitch_deg = round( cos( yaw_delta ) * -1 * var_87bf6371fd21907b );
    roll_deg = round( sin( yaw_delta ) * var_87bf6371fd21907b );
    hermes.var_81170b2300e32aa2 = ( pitch_deg, 0, roll_deg ) * -1;
    hermes.hermes_tilt = anglelerpquatfrac( hermes.hermes_tilt, hermes.var_81170b2300e32aa2, tilt_speed );
}

// Namespace zombie_hermes_move
// Params 0, eflags: 0x4
// Checksum 0xb995fdaa, Offset: 0x5055
// Size: 0x7c
function private function_5acc037c143ce189()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hermes_movement_start" );
        utility::ent_flag_set( "in_movement_animation" );
        zombie_hermes_summon::function_20830766f3579f29( self, "head_middle_le" );
        zombie_hermes_summon::function_20830766f3579f29( self, "head_middle_ri" );
        self waittill( #"hermes_movement_end" );
        utility::ent_flag_clear( "in_movement_animation" );
        zombie_hermes_summon::function_20830766f3579f29( self, "head_middle_le" );
        zombie_hermes_summon::function_20830766f3579f29( self, "head_middle_ri" );
    }
}

// Namespace zombie_hermes_move
// Params 0, eflags: 0x4
// Checksum 0xe2250813, Offset: 0x50d9
// Size: 0x12, Type: bool
function private debug_move()
{
    return getdvarint( @"hash_85865bf1ec114518", 0 ) > 0;
}

/#

    // Namespace zombie_hermes_move
    // Params 0, eflags: 0x4
    // Checksum 0x4e5f264b, Offset: 0x50f4
    // Size: 0x71, Type: dev
    function private function_faffc764fc576c9a()
    {
        devgui::function_9082edeb5db93280( "<dev string:x2dd>" );
        devgui::add_devgui_func( "<dev string:x2f5>", "<dev string:x300>", &function_d6977cca359c0286, 1 );
        devgui::add_devgui_func( "<dev string:x312>", "<dev string:x324>", &function_f916f802a8107629, 1 );
        devgui::add_devgui_func( "<dev string:x336>", "<dev string:x347>", &function_52583fb01da08181, 1 );
        devgui::function_77df7fe7dd273e10();
        
        if ( debug_move() )
        {
            level thread function_c89f823ec139304d();
        }
    }

    // Namespace zombie_hermes_move
    // Params 1, eflags: 0x4
    // Checksum 0x8262571b, Offset: 0x516d
    // Size: 0x44, Type: dev
    function private function_d6977cca359c0286( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x358>", @"hash_85865bf1ec114518" );
        
        if ( debug_move() )
        {
            level thread function_c89f823ec139304d();
            return;
        }
        
        level notify( #"hash_b0c92f6698269bf8" );
    }

    // Namespace zombie_hermes_move
    // Params 0, eflags: 0x4
    // Checksum 0xa0638a0f, Offset: 0x51b9
    // Size: 0x3b, Type: dev
    function private function_f916f802a8107629()
    {
        hermes = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x36a>" );
        function_7115fba9ef789d9( hermes );
    }

    // Namespace zombie_hermes_move
    // Params 0, eflags: 0x4
    // Checksum 0x4695eb17, Offset: 0x51fc
    // Size: 0x3b, Type: dev
    function private function_52583fb01da08181()
    {
        hermes = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x36a>" );
        function_5308069777f513f1( hermes );
    }

    // Namespace zombie_hermes_move
    // Params 0, eflags: 0x4
    // Checksum 0x47caddb5, Offset: 0x523f
    // Size: 0x104, Type: dev
    function private function_c89f823ec139304d()
    {
        level endon( #"hash_b0c92f6698269bf8" );
        
        while ( true )
        {
            hermes = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x36a>" );
            
            if ( !isdefined( hermes ) )
            {
                waitframe();
                continue;
            }
            
            if ( isdefined( hermes.enemy ) )
            {
                circle_points = get_circle_points( hermes, hermes.enemy );
                
                foreach ( point in circle_points )
                {
                    sphere( point.origin, 10, ( 1, 0, 0 ) );
                }
            }
            
            waitframe();
        }
    }

#/
