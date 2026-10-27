// script_14f857806c1ea0cc  (hash_14f857806c1ea0cc.gscc) (size: 15672 Bytes / 0x3d38 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x801bacb7 (2149297335)
// size ...... 15672 (0x3d38)
// includes .. 11  (offset: 0x3aac)
// strings ... 27  (offset: 0x3b04)
// dev strs .. 17  (offset: 0x3c68)
// exports ... 35  (offset: 0x2890)
// cseg ...... 0x231 + 0x265f (0x2890)
// imports ... 100 (offset: 0x2e08)
// animtree1 . 0   (offset: 0x3d38)
// animtree2 . 0   (offset: 0x3d38)
#using script_16ea1b94f0f381b3;
#using script_5d3960c405a24eb9;
#using script_640b69521097c6a5;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace zombie_weyward_skull;

/#

    // Namespace zombie_weyward_skull
    // Params 0
    // Checksum 0xb3dc3f5f, Offset: 0x24f
    // Size: 0xc, Type: dev
    function function_6473f38b50cfcaf7()
    {
        function_145e15b58b7a5e82();
    }

#/

// Namespace zombie_weyward_skull
// Params 0
// Checksum 0x575e3863, Offset: 0x263
// Size: 0x3ee
function init_zombie_weyward_skull()
{
    self.var_bfec04d50947b318 = [];
    self.var_b4ef6b85d1b78ed4 = 0;
    callback::add( "weyward_enter_immune_phase", &function_c2d564fa68251d13 );
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    self.var_f2ef47102ea95ad = [ settings.var_f421275748e3e347 ?? 1, settings.var_f421285748e3e57a ?? 2, settings.var_f421295748e3e7ad ?? 3, settings.var_c98c849aebdd954a ?? 4 ];
    self.var_3a061eee09619ff = settings.var_21ccac2b8fb5eeb9 ?? 1;
    self.skull_spawn_interval = settings.var_a582b5d5146b6c33 ?? 8;
    self.skull_spawn_height = settings.var_987184c5ac9a7f6d ?? 500;
    self.var_a1be981d65934a4f = settings.var_cb49b6cefac542cb ?? 200;
    self.var_274756c0007192d6 = settings.var_325da88150d955a ?? 100;
    self.var_65cc93bd8f4e89ec = settings.var_e388312a76fb68b8 ?? 21.25;
    self.var_800e6ab463bc3282 = settings.var_5019009cba85e5c9 ?? 200;
    self.var_fd3250321e5d5963 = settings.var_75b3f9ed09a7e21e ?? 600;
    self.var_bc9657cd64bf84b1 = settings.var_f72a028b5420ef65 ?? 300;
    self.var_c22b410d21a907db = settings.var_f9d532f15f4fde42 ?? 0.3;
    self.var_43ce29244bc23ee3 = settings.var_9f4a13515c4ec4ae ?? 3;
    self.var_125bd6f218871034 = settings.var_8332ca343a768f4d ?? 1.5;
    self.var_7ef322d13cd33732 = settings.var_bd5aa990cc317171 ?? 300;
    self.var_77e0874502df83c4 = settings.var_c45f4c871287ec54 ?? 90;
    self.var_a98d26764590901c = settings.var_2b10db87e9b00880 ?? 15;
    self.var_ef13082eaadeb06c = settings.var_e4b7f9407d20ed90 ?? 0.4;
    self.var_e82e9f786dc70bce = settings.var_be32fdf56a1281e4 ?? 10;
    self.var_49529e4e7f055c3a = settings.var_7a1cacd5f416ec14 ?? 0.3;
    self.var_7aeafbfdcd60370e = settings.var_cccf5761d362d08c ?? 0.6;
    self.var_7582bb8fa4153ccd = settings.var_572b7c7c067041ea ?? 20;
    self.skull_enabled = settings.skullenabled ?? 1;
    self.var_430a5e50a9fca0f2 = [ settings.var_cde22b651aea8d1a ?? 15, settings.var_cde22a651aea8ae7 ?? 10, settings.var_cde229651aea88b4 ?? 8 ];
    self.var_469e8377c1bd7134 = settings.var_35fcdb9b4200abff ?? 0.15;
    self.var_3ba85a0e70506113 = settings.var_b4b2db0e7f40cc33 ?? 3;
    self.var_a1731a69bfd64a78 = settings.var_c5982c8a5104a277 ?? self.var_3ba85a0e70506113;
    self.var_11992c1f9218a502 = settings.var_20d895c5d848d322 ?? 10;
    self.var_31ad88819ce2c83f = settings.var_cee21a3640f92b7c ?? 0.4;
    self.var_fd85d970a2ca241c = settings.var_1e73ee477339f596 ?? 0;
    self.var_7cfde576cfb85922 = 0;
    self.var_2e74df3df468259f = 0;
    thread skull_spawn_loop();
    thread function_6c173f94031f55d0();
    thread function_adc8117008944d9a();
    callback::add( "new_weyward_phase", &function_7abcdab864fa43fe );
}

// Namespace zombie_weyward_skull
// Params 0
// Checksum 0x6d73c362, Offset: 0x659
// Size: 0x13
function function_4a4306933ef021b1()
{
    function_12f95b6d27d22f55();
    return self.var_bfec04d50947b318.size;
}

// Namespace zombie_weyward_skull
// Params 0
// Checksum 0x9762097d, Offset: 0x675
// Size: 0xb8
function function_3321fee4b8702a40()
{
    if ( !self.var_7cfde576cfb85922 || !self.shadow_soul_shield_active )
    {
        return;
    }
    
    foreach ( wither in self.var_bfec04d50947b318 )
    {
        if ( isalive( wither ) )
        {
            wither.shadow_soul_shield_active = 1;
            wither utility::function_7c10ea82c1e305b8( "boss_fight_shield", "shielded" );
        }
    }
}

// Namespace zombie_weyward_skull
// Params 0
// Checksum 0x3b71ef47, Offset: 0x735
// Size: 0x8e
function function_9ca1d6c21ef9f3ac()
{
    foreach ( var_6fd95b8f4f5f8d63 in self.var_bfec04d50947b318 )
    {
        if ( isalive( var_6fd95b8f4f5f8d63 ) )
        {
            var_6fd95b8f4f5f8d63 utility::function_7c10ea82c1e305b8( "wither_fx", "ambient_empowered" );
        }
    }
}

// Namespace zombie_weyward_skull
// Params 1
// Checksum 0x66fbf805, Offset: 0x7cb
// Size: 0x66
function function_99d24b01ae59404f( make_empowered )
{
    var_9ef50e35e9c3c9df = function_4f32d8364fba0b5f();
    function_12f95b6d27d22f55();
    
    while ( self.var_bfec04d50947b318.size < var_9ef50e35e9c3c9df )
    {
        wither = spawn_wither( 1, make_empowered );
        function_12f95b6d27d22f55();
        wither utility::waittill_notify_or_timeout( "decent_start", 0.5 );
    }
}

// Namespace zombie_weyward_skull
// Params 0, eflags: 0x4
// Checksum 0x681a3c62, Offset: 0x839
// Size: 0x69
function private function_4f32d8364fba0b5f()
{
    if ( self.fake_death_triggered )
    {
        var_9ef50e35e9c3c9df = self.var_f2ef47102ea95ad[ 3 ];
    }
    else
    {
        var_9ef50e35e9c3c9df = self.var_f2ef47102ea95ad[ self.shadow_soul_phase - 1 ];
    }
    
    if ( level.players.size > 1 )
    {
        var_9ef50e35e9c3c9df += self.var_3a061eee09619ff;
    }
    
    return clamp( var_9ef50e35e9c3c9df, 1, 4 );
}

// Namespace zombie_weyward_skull
// Params 1, eflags: 0x4
// Checksum 0x58a9a737, Offset: 0x8ab
// Size: 0x16
function private function_7abcdab864fa43fe( params )
{
    self.var_9d03bfa39f830704 = 0;
}

// Namespace zombie_weyward_skull
// Params 0, eflags: 0x4
// Checksum 0x84ec633, Offset: 0x8c9
// Size: 0x104
function private skull_spawn_loop()
{
    self endon( #"death" );
    spawn_interval = getdvarfloat( @"hash_1337f9cccb81e67b", self.skull_spawn_interval );
    
    while ( true )
    {
        wait spawn_interval;
        
        if ( !getdvarint( @"hash_1c4a4eba9dccf683", self.skull_enabled ) )
        {
            continue;
        }
        
        if ( self.shadow_soul_immune )
        {
            continue;
        }
        
        if ( self.var_9d03bfa39f830704 )
        {
            continue;
        }
        
        if ( zombie_stun::is_stunned() )
        {
            continue;
        }
        
        function_12f95b6d27d22f55();
        var_9ef50e35e9c3c9df = function_4f32d8364fba0b5f();
        
        if ( self.var_bfec04d50947b318.size >= var_9ef50e35e9c3c9df )
        {
            self.var_9d03bfa39f830704 = 1;
            continue;
        }
        
        if ( utility::flag( "playing_game_over_scene" ) )
        {
            function_108016ad3901d6d();
            continue;
        }
        
        utility::ent_flag_waitopen_any( "scene_active" );
        function_12f95b6d27d22f55();
        spawn_wither();
        
        if ( self.var_bfec04d50947b318.size >= var_9ef50e35e9c3c9df )
        {
            self.var_9d03bfa39f830704 = 1;
        }
    }
}

// Namespace zombie_weyward_skull
// Params 2, eflags: 0x4
// Checksum 0xbb0e1d83, Offset: 0x9d5
// Size: 0x37d
function private spawn_wither( speed_up_descent, make_empowered )
{
    spawn_height = getdvarfloat( @"hash_1d8da39d3dcd8895", self.skull_spawn_height );
    spawn_pos = self.origin + ( 0, 0, spawn_height );
    wither = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( function_b3988325430ce242( "zombie_wither_boss_fight" ), spawn_pos, ( 0, 0, 0 ), self.team );
    
    while ( !wither )
    {
        zombies = arrayrandomize( getaiarray( "team_two_hundred" ) );
        
        foreach ( zombie in zombies )
        {
            if ( !isalive( zombie ) || issubstr( zombie.subclass, "zombie_weyward" ) || issubstr( zombie.subclass, "zombie_wither" ) || issubstr( zombie.subclass, "hvt" ) )
            {
                continue;
            }
            
            zombie.nocorpse = 1;
            zombie kill();
            waitframe();
            waitframe();
            break;
        }
        
        wither = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( function_b3988325430ce242( "zombie_wither_boss_fight" ), spawn_pos, ( 0, 0, 0 ), self.team );
        
        if ( wither )
        {
            break;
        }
        
        waitframe();
    }
    
    if ( self.fake_death_triggered && ( make_empowered || self.shadow_soul_shield_active ) || self.var_7cfde576cfb85922 && self.shadow_soul_shield_active )
    {
        wither.shadow_soul_shield_active = 1;
        wither utility::function_7c10ea82c1e305b8( "boss_fight_shield", "shielded" );
    }
    
    wither.skull_owner = self;
    wither.skull_orbiting = 0;
    wither.var_990324c31d3215c5 = 1;
    wither callback::add( "on_zombie_ai_killed", &function_14f03f5b08346c19 );
    
    if ( getdvarint( @"hash_d11acbd5d09538a", 0 ) )
    {
        wither.skull_carrier = utility::spawn_model( "sat_zm_armored_cage", spawn_pos, self.angles );
    }
    else
    {
        wither.skull_carrier = utility::function_1808878d1c511ce8( spawn_pos, self.angles );
    }
    
    wither thread utility::delete_on_death( wither.skull_carrier );
    wither linktomoveoffset( wither.skull_carrier );
    wither.skull_velocity = ( 0, 0, 0 );
    wither.skull_start_time = gettime();
    wither.var_3603dc80b0ba795c = 0;
    wither.var_6f4879abfd998738 = getdvarfloat( @"hash_8b7bda7210b63a89", self.var_a1be981d65934a4f );
    self.var_bfec04d50947b318[ self.var_bfec04d50947b318.size ] = wither;
    callback::callback( "on_summoned_by_weyward", { #ent:wither } );
    thread wither_descend( wither, speed_up_descent );
    thread function_6341c392a7f7383c( wither );
    
    /#
        if ( debug_skull() )
        {
            println( "<dev string:x24>" + spawn_pos + "<dev string:x40>" + self.var_bfec04d50947b318.size );
        }
    #/
    
    return wither;
}

// Namespace zombie_weyward_skull
// Params 1, eflags: 0x4
// Checksum 0xe22761f5, Offset: 0xd5b
// Size: 0x39
function private function_14f03f5b08346c19( params )
{
    wither = self;
    
    if ( wither.skull_owner )
    {
        wither.skull_owner thread function_67c522936317aa();
    }
}

// Namespace zombie_weyward_skull
// Params 0, eflags: 0x4
// Checksum 0x6d8e79e9, Offset: 0xd9c
// Size: 0xb1
function private function_67c522936317aa()
{
    if ( self.var_ff54e8028dad17ce || !self.var_9d03bfa39f830704 )
    {
        return;
    }
    
    self.var_ff54e8028dad17ce = 1;
    self endon( #"death" );
    cooldown_time = self.var_430a5e50a9fca0f2[ self.shadow_soul_phase - 1 ];
    
    if ( self.var_469e8377c1bd7134 && level.players.size > 1 )
    {
        cooldown_time -= cooldown_time * ( level.players.size - 1 ) * self.var_469e8377c1bd7134;
    }
    
    cooldown_time = max( cooldown_time, 0 );
    wait cooldown_time;
    self.var_9d03bfa39f830704 = 0;
    self.var_ff54e8028dad17ce = 0;
}

// Namespace zombie_weyward_skull
// Params 2, eflags: 0x4
// Checksum 0x8488073a, Offset: 0xe55
// Size: 0x55e
function private wither_descend( wither, speed_up_descent )
{
    self endon( #"death" );
    wither endon( #"death" );
    wait speed_up_descent ? 0.1 : 1;
    orbit_radius = getdvarfloat( @"hash_8b7bda7210b63a89", self.var_a1be981d65934a4f );
    arrival_threshold = orbit_radius * getdvarfloat( @"hash_e962d57fec2b2d7e", self.var_125bd6f218871034 );
    var_956c1fab341d0053 = getdvarfloat( @"hash_3d94097072911264", speed_up_descent ? self.var_800e6ab463bc3282 * 1.75 : self.var_800e6ab463bc3282 );
    max_speed = getdvarfloat( @"hash_323459e6e5bcf381", self.var_fd3250321e5d5963 );
    accel = getdvarfloat( @"hash_4a8f4321dd396137", self.var_bc9657cd64bf84b1 );
    var_913034dd2a3a074c = getdvarfloat( @"hash_8cdb97e58aa73799", self.var_c22b410d21a907db );
    var_21ee8b7a0c67b3e8 = getdvarfloat( @"hash_53ae02a19778bec", self.var_7aeafbfdcd60370e );
    decel_mult = getdvarfloat( @"hash_3d2da83d4baf1915", self.var_43ce29244bc23ee3 );
    orbit_height = getdvarfloat( @"hash_db3a73aeebddaf04", self.var_274756c0007192d6 );
    goal_pos = self.origin + ( 0, 0, orbit_height );
    total_dist = distance( wither.skull_carrier.origin, goal_pos );
    wither.skull_velocity = ( 0, 0, 0 );
    var_48ee71281f56f926 = gettime();
    
    while ( true )
    {
        current_time = gettime();
        dt = ( current_time - var_48ee71281f56f926 ) / 1000;
        var_48ee71281f56f926 = current_time;
        
        if ( dt <= 0 )
        {
            waitframe();
            continue;
        }
        
        goal_pos = self.origin + ( 0, 0, orbit_height );
        
        if ( distance( wither.skull_carrier.origin, self.origin ) <= arrival_threshold )
        {
            break;
        }
        
        dir_to_goal = goal_pos - wither.skull_carrier.origin;
        dist_to_goal = length( dir_to_goal );
        
        if ( dist_to_goal > 0.1 )
        {
            dir_to_goal = vectornormalize( dir_to_goal );
        }
        else
        {
            dir_to_goal = ( 0, 0, -1 );
        }
        
        progress = clamp( 1 - dist_to_goal / total_dist, 0, 1 );
        target_speed = math::lerp( var_956c1fab341d0053, max_speed, sin( progress * 180 ) );
        decel_accel = accel * decel_mult;
        stopping_dist = target_speed * target_speed / 2 * decel_accel;
        
        if ( dist_to_goal < stopping_dist && stopping_dist > 0 )
        {
            target_speed *= max( sqrt( dist_to_goal / stopping_dist ), 0.15 );
        }
        
        desired_velocity = dir_to_goal * target_speed;
        velocity_diff = desired_velocity - wither.skull_velocity;
        current_speed = length( wither.skull_velocity );
        is_braking = target_speed < current_speed;
        max_steer = ( is_braking ? decel_accel : accel ) * dt;
        
        if ( length( velocity_diff ) <= max_steer )
        {
            wither.skull_velocity = desired_velocity;
        }
        else
        {
            wither.skull_velocity += vectornormalize( velocity_diff ) * max_steer;
        }
        
        current_speed = length( wither.skull_velocity );
        
        if ( current_speed > 0.1 )
        {
            current_dir = vectornormalize( wither.skull_velocity );
            blended_dir = lerp( current_dir, dir_to_goal, var_913034dd2a3a074c );
            wither.skull_velocity = vectornormalize( blended_dir ) * current_speed;
        }
        
        new_pos = wither.skull_carrier.origin + wither.skull_velocity * dt;
        bounce_result = function_15658def388ba1f6( wither, wither.skull_carrier.origin, new_pos, var_21ee8b7a0c67b3e8 );
        new_pos = bounce_result.position;
        
        if ( bounce_result.bounced )
        {
            wither.skull_velocity = bounce_result.velocity;
        }
        
        wither.skull_carrier.origin = new_pos;
        
        /#
            if ( debug_skull() )
            {
                line( wither.skull_carrier.origin, goal_pos, ( 1, 0.5, 0 ) );
                sphere( wither.skull_carrier.origin, 10, ( 1, 0.5, 0 ) );
            }
        #/
        
        waitframe();
    }
    
    wither notify( #"decent_start" );
    wither.skull_orbiting = 1;
    wither.var_3603dc80b0ba795c = function_ca02418f282ead1d();
    thread orbit_wither( wither );
}

// Namespace zombie_weyward_skull
// Params 0, eflags: 0x4
// Checksum 0x195133d7, Offset: 0x13bb
// Size: 0x7e
function private function_6c173f94031f55d0()
{
    self endon( #"death" );
    
    while ( true )
    {
        orbit_speed = getdvarfloat( @"hash_899630af00893856", self.var_65cc93bd8f4e89ec );
        self.var_b4ef6b85d1b78ed4 += orbit_speed * level.framedurationseconds;
        
        if ( self.var_b4ef6b85d1b78ed4 >= 360 )
        {
            self.var_b4ef6b85d1b78ed4 -= 360;
        }
        
        waitframe();
    }
}

// Namespace zombie_weyward_skull
// Params 1, eflags: 0x4
// Checksum 0xeb6c6b97, Offset: 0x1441
// Size: 0x690
function private orbit_wither( wither )
{
    self endon( #"death" );
    wither endon( #"death" );
    var_48ee71281f56f926 = gettime();
    var_42c8c98cd389e2f8 = gettime();
    var_200985a4ee0c1633 = 2000;
    
    while ( true )
    {
        current_time = gettime();
        dt = ( current_time - var_48ee71281f56f926 ) / 1000;
        var_48ee71281f56f926 = current_time;
        
        if ( dt <= 0 )
        {
            waitframe();
            continue;
        }
        
        orbit_radius = getdvarfloat( @"hash_8b7bda7210b63a89", self.var_a1be981d65934a4f );
        orbit_height = getdvarfloat( @"hash_db3a73aeebddaf04", self.var_274756c0007192d6 );
        var_e5bcedf0231124f = getdvarfloat( @"hash_d7019060ca5f6d78", self.var_7ef322d13cd33732 );
        angle_lerp_speed = getdvarfloat( @"hash_21aaa0299430c316", self.var_77e0874502df83c4 );
        wall_margin = getdvarfloat( @"hash_78509ccd25d5abc3", self.var_7582bb8fa4153ccd );
        orbit_index = function_c269ef9bf6797bcc( wither );
        orbit_count = function_6fa028124c7bc85f();
        
        if ( orbit_count > 0 )
        {
            ideal_offset = 360 * orbit_index / orbit_count;
        }
        else
        {
            ideal_offset = 0;
        }
        
        ideal_angle = self.var_b4ef6b85d1b78ed4 + ideal_offset;
        
        if ( ideal_angle >= 360 )
        {
            ideal_angle -= 360;
        }
        
        angle_diff = ideal_angle - wither.var_3603dc80b0ba795c;
        
        while ( angle_diff > 180 )
        {
            angle_diff -= 360;
        }
        
        while ( angle_diff < -180 )
        {
            angle_diff += 360;
        }
        
        max_angle_step = angle_lerp_speed * dt;
        
        if ( abs( angle_diff ) <= max_angle_step )
        {
            wither.var_3603dc80b0ba795c = ideal_angle;
        }
        else if ( angle_diff > 0 )
        {
            wither.var_3603dc80b0ba795c += max_angle_step;
        }
        else
        {
            wither.var_3603dc80b0ba795c -= max_angle_step;
        }
        
        if ( wither.var_3603dc80b0ba795c >= 360 )
        {
            wither.var_3603dc80b0ba795c -= 360;
        }
        
        if ( wither.var_3603dc80b0ba795c < 0 )
        {
            wither.var_3603dc80b0ba795c += 360;
        }
        
        angle = wither.var_3603dc80b0ba795c;
        orbit_x = cos( angle ) * orbit_radius;
        orbit_y = sin( angle ) * orbit_radius;
        target_pos = self.origin + ( orbit_x, orbit_y, orbit_height );
        trace_start = self.origin + ( 0, 0, orbit_height );
        trace_contents = trace::create_contents( 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0 );
        trace_result = trace::ray_trace( trace_start, target_pos, undefined, trace_contents );
        traced_radius = orbit_radius;
        
        if ( trace_result[ "fraction" ] < 1 )
        {
            traced_radius = orbit_radius * trace_result[ "fraction" ] - wall_margin;
            traced_radius = max( traced_radius, 30 );
        }
        
        radius_lerp_speed = 5 * dt;
        wither.var_6f4879abfd998738 += ( traced_radius - wither.var_6f4879abfd998738 ) * clamp( radius_lerp_speed, 0, 1 );
        effective_radius = wither.var_6f4879abfd998738;
        
        if ( effective_radius != orbit_radius )
        {
            orbit_x = cos( angle ) * effective_radius;
            orbit_y = sin( angle ) * effective_radius;
            target_pos = self.origin + ( orbit_x, orbit_y, orbit_height );
        }
        
        if ( isdefined( wither.v_target_pos_override ) )
        {
            target_pos = wither.v_target_pos_override;
        }
        
        wither.skull_carrier.angles = self.angles;
        dir_to_target = target_pos - wither.skull_carrier.origin;
        dist_to_target = length( dir_to_target );
        
        if ( gettime() - var_42c8c98cd389e2f8 < var_200985a4ee0c1633 )
        {
            var_e5bcedf0231124f *= getdvarfloat( @"hash_dde3967bbfe90ce", 0.5 );
        }
        
        if ( dist_to_target > 0.1 )
        {
            smooth_factor = clamp( var_e5bcedf0231124f * dt / dist_to_target, 0, 0.5 );
            movement = dir_to_target * smooth_factor;
        }
        else
        {
            movement = dir_to_target;
        }
        
        wobble_offset = function_4ca355a9377b620e( wither, current_time ) * dt;
        bob_offset = function_1006013d1e5dbaa2( wither, current_time ) * dt;
        
        if ( isdefined( wither.v_target_pos_override ) || wither.var_175f2edcb822a477 )
        {
            wobble_offset = ( 0, 0, 0 );
            bob_offset = ( 0, 0, 0 );
        }
        
        if ( wither.var_b4a2ac2812cf870e )
        {
            wither.skull_carrier dontinterpolate();
            wither.skull_carrier.origin = target_pos;
            wither.var_b4a2ac2812cf870e = undefined;
        }
        else
        {
            wither.skull_carrier.origin = wither.skull_carrier.origin + movement + wobble_offset + bob_offset;
        }
        
        /#
            if ( debug_skull() )
            {
                line( self.origin + ( 0, 0, orbit_height ), target_pos, ( 0, 1, 1 ) );
                line( wither.skull_carrier.origin, target_pos, ( 0.2, 0.5, 1 ) );
                sphere( target_pos, 15, ( 0, 1, 0 ) );
                sphere( wither.skull_carrier.origin, 10, ( 1, 1, 0 ) );
                sphere( wither.origin, 10, ( 1, 0, 0 ) );
                print3d( target_pos + ( 0, 0, 30 ), "<dev string:x4a>" + int( angle ) + "<dev string:x52>" + int( effective_radius ), ( 0, 1, 1 ), 0.5, 0.5 );
            }
        #/
        
        waitframe();
    }
}

// Namespace zombie_weyward_skull
// Params 2, eflags: 0xc
// Checksum 0x6e04d4a9, Offset: 0x1ad9
// Size: 0xdc
function private function_5615cc72320a705b( closest_player, n_time = 0.25 )
{
    self notify( #"hash_3c5acbed88592b04" );
    self endon( #"hash_3c5acbed88592b04" );
    self endon( #"death" );
    self.var_fea53606bc2a770f = 1;
    yaw_target = vectortoyaw( closest_player.origin - self.skull_carrier.origin );
    self.skull_carrier rotateto( ( self.skull_carrier.angles[ 0 ], yaw_target, self.skull_carrier.angles[ 2 ] ), n_time );
    self.skull_carrier waittill( #"rotatedone" );
    self.var_fea53606bc2a770f = undefined;
}

// Namespace zombie_weyward_skull
// Params 4, eflags: 0x4
// Checksum 0x8d3fc191, Offset: 0x1bbd
// Size: 0x192
function private function_15658def388ba1f6( wither, old_pos, new_pos, var_21ee8b7a0c67b3e8 )
{
    result = spawnstruct();
    result.position = new_pos;
    result.velocity = wither.skull_velocity;
    result.bounced = 0;
    trace_contents = trace::create_contents( 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0 );
    trace_result = trace::ray_trace( old_pos, new_pos, undefined, trace_contents );
    
    if ( trace_result[ "fraction" ] < 1 )
    {
        result.bounced = 1;
        hit_pos = trace_result[ "position" ];
        var_3cb607c143ecc1a3 = trace_result[ "normal" ];
        
        if ( !isdefined( var_3cb607c143ecc1a3 ) || length( var_3cb607c143ecc1a3 ) < 0.1 )
        {
            result.velocity = wither.skull_velocity * var_21ee8b7a0c67b3e8 * -1;
            result.position = old_pos;
            return result;
        }
        
        var_4b93e11d422da79d = vectordot( wither.skull_velocity, var_3cb607c143ecc1a3 );
        reflected_vel = wither.skull_velocity - var_3cb607c143ecc1a3 * 2 * var_4b93e11d422da79d;
        result.velocity = reflected_vel * var_21ee8b7a0c67b3e8;
        result.position = hit_pos + var_3cb607c143ecc1a3 * 10;
        
        /#
            if ( debug_skull() )
            {
                println( "<dev string:x57>" );
            }
        #/
    }
    
    return result;
}

// Namespace zombie_weyward_skull
// Params 2, eflags: 0x4
// Checksum 0x8d882fed, Offset: 0x1d58
// Size: 0xa5
function private function_4ca355a9377b620e( wither, current_time )
{
    wobble_amp = getdvarfloat( @"hash_c28cf43c78bbdf52", self.var_a98d26764590901c );
    wobble_freq = getdvarfloat( @"hash_78b9a4b873a84afe", self.var_ef13082eaadeb06c );
    time_s = ( current_time - wither.skull_start_time ) / 1000;
    wobble_phase = time_s * wobble_freq * 360;
    return ( sin( wobble_phase ) * wobble_amp, cos( wobble_phase * 1.3 ) * wobble_amp * 0.7, 0 );
}

// Namespace zombie_weyward_skull
// Params 2, eflags: 0x4
// Checksum 0xd8e4f82e, Offset: 0x1e06
// Size: 0x85
function private function_1006013d1e5dbaa2( wither, current_time )
{
    bob_amp = getdvarfloat( @"hash_f878c576bc7fc62c", self.var_e82e9f786dc70bce );
    bob_freq = getdvarfloat( @"hash_a0e78632e99789fc", self.var_49529e4e7f055c3a );
    time_s = current_time / 1000;
    bob_phase = time_s * bob_freq * 360;
    return ( 0, 0, sin( bob_phase ) * bob_amp );
}

// Namespace zombie_weyward_skull
// Params 1, eflags: 0x4
// Checksum 0x1dd10f00, Offset: 0x1e94
// Size: 0x45
function private get_wither_slot_index( wither )
{
    for ( i = 0; i < self.var_bfec04d50947b318.size ; i++ )
    {
        if ( self.var_bfec04d50947b318[ i ] == wither )
        {
            return i;
        }
    }
    
    return 0;
}

// Namespace zombie_weyward_skull
// Params 0, eflags: 0x4
// Checksum 0x6ebfa756, Offset: 0x1ee2
// Size: 0x9a
function private function_6fa028124c7bc85f()
{
    count = 0;
    
    foreach ( w in self.var_bfec04d50947b318 )
    {
        if ( isalive( w ) && w.skull_orbiting )
        {
            count++;
        }
    }
    
    return count;
}

// Namespace zombie_weyward_skull
// Params 1, eflags: 0x4
// Checksum 0x72dcac4d, Offset: 0x1f85
// Size: 0xad
function private function_c269ef9bf6797bcc( wither )
{
    index = 0;
    
    foreach ( w in self.var_bfec04d50947b318 )
    {
        if ( isalive( w ) && w.skull_orbiting )
        {
            if ( w == wither )
            {
                return index;
            }
            
            index++;
        }
    }
    
    return 0;
}

// Namespace zombie_weyward_skull
// Params 0, eflags: 0x4
// Checksum 0xb8696ba5, Offset: 0x203b
// Size: 0x161
function private function_ca02418f282ead1d()
{
    angles = [];
    
    foreach ( w in self.var_bfec04d50947b318 )
    {
        if ( isalive( w ) && w.skull_orbiting )
        {
            angles[ angles.size ] = int( w.var_3603dc80b0ba795c );
        }
    }
    
    if ( angles.size == 0 )
    {
        return 0;
    }
    
    arraysort( angles );
    best_gap = 0;
    best_mid = 0;
    
    for ( i = 0; i < angles.size ; i++ )
    {
        next_i = ( i + 1 ) % angles.size;
        
        if ( next_i == 0 )
        {
            gap = angles[ 0 ] + 360 - angles[ i ];
        }
        else
        {
            gap = angles[ next_i ] - angles[ i ];
        }
        
        if ( gap > best_gap )
        {
            best_gap = gap;
            mid = angles[ i ] + gap * 0.5;
            
            if ( mid >= 360 )
            {
                mid -= 360;
            }
            
            best_mid = mid;
        }
    }
    
    return best_mid;
}

// Namespace zombie_weyward_skull
// Params 1, eflags: 0x4
// Checksum 0x6eb4b366, Offset: 0x21a5
// Size: 0x1d8
function private function_6341c392a7f7383c( wither )
{
    self endon( #"death" );
    self endon( #"begin_fake_death" );
    self endon( #"begin_real_death" );
    wither waittill( #"death" );
    
    if ( isdefined( wither.skull_carrier ) )
    {
        wither.skull_carrier delete();
    }
    
    playworldsound( wither.origin, #"hash_ce836a53a47fe5ac" );
    function_12f95b6d27d22f55();
    
    if ( self.var_bfec04d50947b318 && self.var_bfec04d50947b318.size > 0 && !utility::flag( "playing_game_over_scene" ) )
    {
        utility::function_7c10ea82c1e305b8( "empowerment_status", "level_4" );
    }
    else
    {
        utility::function_7c10ea82c1e305b8( "empowerment_status", "off" );
    }
    
    if ( !self.shadow_soul_immune )
    {
        stun_cooldown = getdvarfloat( @"hash_75439b7d4995847c", self.var_11992c1f9218a502 );
        var_aab6eaacaae295db = self.var_31ad88819ce2c83f;
        
        if ( var_aab6eaacaae295db && level.players.size > 1 )
        {
            stun_cooldown += stun_cooldown * ( level.players.size - 1 ) * var_aab6eaacaae295db;
        }
        
        if ( self.var_bfec04d50947b318.size == 0 && utility::time_has_passed( self.var_2e74df3df468259f, stun_cooldown ) )
        {
            function_a3bd693e43c9a008();
        }
        else
        {
            wither_yaw = vectortoyaw( wither.origin - self.origin );
            yaw_diff = angleclamp180( wither_yaw - self.angles[ 1 ] );
            zombie_weyward_asm::function_ba47976c06174596( self, yaw_diff > 0 );
        }
    }
    
    /#
        if ( debug_skull() )
        {
            println( "<dev string:x78>" + self.var_bfec04d50947b318.size );
        }
    #/
}

// Namespace zombie_weyward_skull
// Params 0, eflags: 0x4
// Checksum 0xbade85d2, Offset: 0x2385
// Size: 0x13d
function private function_a3bd693e43c9a008()
{
    if ( utility::flag( "playing_game_over_scene" ) || self getaiblackboarddynamic( "in_real_death" ) || self getaiblackboarddynamic( "in_fake_death" ) )
    {
        return;
    }
    
    stun_duration = getdvarfloat( @"hash_40025e2f8a950bc1", self.var_3ba85a0e70506113 );
    
    if ( self.shadow_soul_phase >= 3 || self.fake_death_triggered )
    {
        stun_duration = getdvarfloat( @"hash_70ca992a539d2676", self.var_a1731a69bfd64a78 );
    }
    
    spike_damage = getdvarfloat( @"hash_e654dc802379c2fe", self.var_fd85d970a2ca241c );
    self.var_2e74df3df468259f = gettime();
    self._blackboard.var_32718cfc9c01dd9b = 1;
    self._blackboard.var_adea0ee486214124 = gettime() + int( stun_duration * 1000 );
    asm::function_7256f5ba459c840b( "stun_in" );
    zombie_weyward_metabones::function_995b6dfb3ab95f0c();
    
    if ( spike_damage > 0 )
    {
        self dodamage( spike_damage, self.origin, self, self, "MOD_UNKNOWN" );
    }
    
    /#
        if ( debug_skull() )
        {
            println( "<dev string:x9a>" + stun_duration + "<dev string:xcc>" + spike_damage );
        }
    #/
}

// Namespace zombie_weyward_skull
// Params 0, eflags: 0x4
// Checksum 0x2bac96d3, Offset: 0x24ca
// Size: 0x98
function private function_12f95b6d27d22f55()
{
    var_108e06f117a45608 = [];
    
    foreach ( wither in self.var_bfec04d50947b318 )
    {
        if ( isalive( wither ) )
        {
            var_108e06f117a45608[ var_108e06f117a45608.size ] = wither;
        }
    }
    
    self.var_bfec04d50947b318 = var_108e06f117a45608;
}

// Namespace zombie_weyward_skull
// Params 0, eflags: 0x4
// Checksum 0xcb5899c0, Offset: 0x256a
// Size: 0x22
function private function_adc8117008944d9a()
{
    level endon( #"game_ended" );
    self waittill( #"death" );
    function_108016ad3901d6d();
}

// Namespace zombie_weyward_skull
// Params 0, eflags: 0x4
// Checksum 0x6bddd890, Offset: 0x2594
// Size: 0xca
function private function_108016ad3901d6d()
{
    foreach ( wither in self.var_bfec04d50947b318 )
    {
        if ( isalive( wither ) )
        {
            if ( isdefined( wither.skull_carrier ) )
            {
                wither unlink();
                wither.skull_carrier delete();
            }
            
            wither.forceannihilate = 1;
            wither kill( self.origin, self );
        }
    }
    
    self.var_bfec04d50947b318 = [];
}

// Namespace zombie_weyward_skull
// Params 1, eflags: 0x4
// Checksum 0x63b990e3, Offset: 0x2666
// Size: 0x13
function private function_c2d564fa68251d13( params )
{
    function_108016ad3901d6d();
}

/#

    // Namespace zombie_weyward_skull
    // Params 0, eflags: 0x4
    // Checksum 0x339eb7e4, Offset: 0x2681
    // Size: 0x5a, Type: dev
    function private function_145e15b58b7a5e82()
    {
        devgui::function_9082edeb5db93280( "<dev string:xde>" );
        devgui::add_devgui_func( "<dev string:xfd>", "<dev string:x110>", &force_spawn_wither );
        devgui::add_devgui_func( "<dev string:x12a>", "<dev string:x13b>", &function_a7ab2e443487c141 );
        devgui::add_devgui_func( "<dev string:x154>", "<dev string:x160>", &function_227df69fdd0cfa94 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_weyward_skull
    // Params 1, eflags: 0x4
    // Checksum 0x29c80cb8, Offset: 0x26e3
    // Size: 0x4b, Type: dev
    function private force_spawn_wither( params )
    {
        weyward = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x17b>" );
        
        if ( isdefined( weyward ) )
        {
            weyward spawn_wither();
        }
    }

    // Namespace zombie_weyward_skull
    // Params 1, eflags: 0x4
    // Checksum 0x9ef3a118, Offset: 0x2736
    // Size: 0x110, Type: dev
    function private function_a7ab2e443487c141( params )
    {
        weyward = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x17b>" );
        
        if ( isdefined( weyward ) )
        {
            foreach ( wither in weyward.var_bfec04d50947b318 )
            {
                if ( isalive( wither ) )
                {
                    if ( isdefined( wither.skull_carrier ) )
                    {
                        wither unlink();
                        wither.skull_carrier delete();
                    }
                    
                    wither.forceannihilate = 1;
                    wither kill( weyward.origin, weyward );
                }
            }
            
            weyward.var_bfec04d50947b318 = [];
        }
    }

    // Namespace zombie_weyward_skull
    // Params 1, eflags: 0x4
    // Checksum 0x2a3ae74e, Offset: 0x284e
    // Size: 0x24, Type: dev
    function private function_227df69fdd0cfa94( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x18a>", @"hash_9908fcb8b41e3af1" );
    }

    // Namespace zombie_weyward_skull
    // Params 0, eflags: 0x4
    // Checksum 0x2f7a5f8c, Offset: 0x287a
    // Size: 0x16, Type: dev
    function private debug_skull()
    {
        return getdvarint( @"hash_9908fcb8b41e3af1", 0 ) > 0;
    }

#/
