// script_6c3d015c4415b878  (hash_6c3d015c4415b878.gscc) (size: 16611 Bytes / 0x40e3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9f739db1 (2675154353)
// size ...... 16611 (0x40e3)
// includes .. 13  (offset: 0x3d0b)
// strings ... 39  (offset: 0x3d73)
// dev strs .. 27  (offset: 0x3f87)
// exports ... 36  (offset: 0x2767)
// cseg ...... 0x296 + 0x24d1 (0x2767)
// imports ... 126 (offset: 0x2d07)
// animtree1 . 0   (offset: 0x40e3)
// animtree2 . 0   (offset: 0x40e3)
#using script_16ea1b94f0f381b3;
#using script_1d947a67914036d6;
#using script_4739bc1bf6db3b96;
#using script_50711a6f06e7b3a3;
#using script_747a3e7e01d497c7;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\weapon;

#namespace zombie_aeon;

// Namespace zombie_aeon
// Params 2
// Checksum 0x95c5f10b, Offset: 0x2b4
// Size: 0x27
function precache( classname, aitypescriptbundle )
{
    zombie_aeon_flame_tornado::precache( aitypescriptbundle );
    zombie_aeon_fireball::precache( aitypescriptbundle );
}

// Namespace zombie_aeon
// Params 1, eflags: 0x4
// Checksum 0xf03301d6, Offset: 0x2e3
// Size: 0x81
function private function_34ebc247476ce26c( params )
{
    zombie_boss_healthbar::function_f50a10314e72caa1();
    callback::get_template( self.animsetname ) callback::add( #"on_ai_killed", &function_462e8bdd6281a400 );
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_damaged", &function_3d6885c7d4f1e99c );
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &play_death_fx );
    
    /#
        init_zombie_aeon_devgui();
    #/
}

// Namespace zombie_aeon
// Params 1
// Checksum 0x1001afc, Offset: 0x36c
// Size: 0x1c2
function function_f9f0b5eb64f494bd( taskid )
{
    profilestart();
    assert( isdefined( self.zombieaisetting ) );
    zombie_init::function_5d23979c4c7c9a52( self.zombieaisetting );
    callback::add( "on_first_ai_init", &function_34ebc247476ce26c );
    thread zombie_boss_healthbar::init_zombie_boss_healthbar();
    zombie_aeon_flame_tornado::init_zombie_aeon_flame_tornado();
    zombie_aeon_fireball::init_zombie_aeon_fireball();
    self.allowfriendlyfire = 1;
    self.n_fight_phase = 1;
    self.var_13518fb33ec73cc = 30;
    self.var_317816f65dd8fd6c = 2;
    self function_43a971093c992365( 1 );
    thread init_difficulty_changes();
    self.move_velocity = ( 0, 0, 0 );
    self.rot_velocity = 0;
    self.heart_pulse_offset = 0;
    self.var_44230a4cf6857148 = 0;
    self.heart_tilt = ( 0, 0, 0 );
    self.var_6af71d680c211120 = ( 0, 0, 0 );
    self.var_26166beeb9fc4cd9 = ( 0, 0, 0 );
    self.var_e53d3e4c6139369b = ( 0, 0, 0 );
    self.var_4f6fb0ccb871d72b = undefined;
    self.nav_goal = undefined;
    self.spawn_ground_pos = playerphysicstrace( self.origin, self.origin - ( 0, 0, 2000 ) );
    thread update_transform();
    thread monitor_heart_pulse();
    zombie_utils::function_dfae6a5bd222c586( &function_f4933dd3e62ce521 );
    self.mover = utility::spawn_model( "tag_origin", self.origin, self.angles );
    self linktoblendtotag( self.mover, "tag_origin" );
    thread initscriptable();
    profilestop();
    return anim.success;
}

// Namespace zombie_aeon
// Params 1
// Checksum 0xcd43a069, Offset: 0x538
// Size: 0xa9
function set_scar_exposed_state( var_ddbcffb6aedc34e3 )
{
    if ( var_ddbcffb6aedc34e3 )
    {
        if ( !utility::ent_flag( "scar_exposed" ) )
        {
            utility::ent_flag_set( "scar_exposed" );
            utility::function_7c10ea82c1e305b8( "scar", "on" );
            utility::ent_flag_clear( "zm_mod_health_regen_disable" );
            thread zombie_aeon_metabones::function_351c63ac6de217fe( self, 3 );
            thread function_8f65e828c494cb42();
            zombie_aeon_asm::update_idle_anim( self, "combat_idle" );
        }
        
        return;
    }
    
    if ( utility::ent_flag( "scar_exposed" ) )
    {
        utility::ent_flag_clear( "scar_exposed" );
        utility::ent_flag_set( "zm_mod_health_regen_disable" );
        utility::function_7c10ea82c1e305b8( "scar", "off" );
        zombie_aeon_asm::update_idle_anim( self );
    }
}

// Namespace zombie_aeon
// Params 1
// Checksum 0x8bea5c21, Offset: 0x5e9
// Size: 0x3f
function function_9c6c273abc4252f2( intro_duration )
{
    utility::ent_flag_set( "damage_phase_intro" );
    self playsound( #"hash_154994b6a13ec3db" );
    wait intro_duration;
    utility::ent_flag_clear( "damage_phase_intro" );
    set_scar_exposed_state( 1 );
}

// Namespace zombie_aeon
// Params 0
// Checksum 0xa5d33fbc, Offset: 0x630
// Size: 0x5e
function function_71d11630a0dd05d5()
{
    set_scar_exposed_state( 0 );
    target_health = self.maxhealth * ( ( 3 - self.n_fight_phase + 1 ) * 0.33 + 0.01 );
    var_dc6a063d8c9f2b8f = self.maxhealth * 0.003;
    thread function_b4012e7b44a2739b( target_health, var_dc6a063d8c9f2b8f );
}

// Namespace zombie_aeon
// Params 0
// Checksum 0x606eb08, Offset: 0x696
// Size: 0x10
function function_7059b85a384fcc35()
{
    thread function_6fe39ecfdc91cbab();
    thread function_c0874f13026965d9();
}

// Namespace zombie_aeon
// Params 0, eflags: 0x4
// Checksum 0xfe8572d4, Offset: 0x6ae
// Size: 0x45
function private function_c0874f13026965d9()
{
    self endon( #"death" );
    self endon( #"hash_761775ec6a6d8c09" );
    utility::ent_flag_wait( "scar_exposed" );
    utility::ent_flag_waitopen_any( "scar_exposed" );
    zombie_aeon_flame_tornado::function_f7c656e727e98246();
    self notify( #"hash_761775ec6a6d8c09" );
}

// Namespace zombie_aeon
// Params 0, eflags: 0x4
// Checksum 0x55eabbe, Offset: 0x6fb
// Size: 0x14a
function private function_6fe39ecfdc91cbab()
{
    self endon( #"death" );
    self endon( #"hash_761775ec6a6d8c09" );
    self.tornado_spawn_count = 0;
    var_5c002aff00d1b4ea = self.var_5c002aff00d1b4ea ?? 0;
    var_f83db376611adf7d = self.var_f83db376611adf7d ?? 5;
    var_e39fb7c8af189a24 = var_5c002aff00d1b4ea > 0;
    
    while ( true )
    {
        wait 1;
        
        if ( !self.enemy )
        {
            continue;
        }
        
        tornado_max = min( utility::get_alive_players( 1 ).size + 1, 4 );
        self.var_5882e5e64b6302a7 = function_5713d46873b29625( self.var_5882e5e64b6302a7 );
        
        if ( self.var_5882e5e64b6302a7.size < tornado_max )
        {
            zombie_aeon_flame_tornado::spawn_flame_tornado( getrandomnavpoint( self.origin, 500 ), self.angles );
            self.tornado_spawn_count++;
            
            if ( var_e39fb7c8af189a24 && self.tornado_spawn_count >= var_5c002aff00d1b4ea )
            {
                while ( self.var_5882e5e64b6302a7.size > 0 )
                {
                    self.var_5882e5e64b6302a7 = function_5713d46873b29625( self.var_5882e5e64b6302a7 );
                    wait 0.5;
                }
                
                wait var_f83db376611adf7d;
                self.tornado_spawn_count = 0;
            }
            
            continue;
        }
        
        wait self.tornado_cooldown_s;
    }
}

// Namespace zombie_aeon
// Params 2, eflags: 0x4
// Checksum 0xda83f595, Offset: 0x84d
// Size: 0x9b
function private function_b4012e7b44a2739b( target_health, var_dc6a063d8c9f2b8f )
{
    self endon( #"death" );
    target_health = int( target_health );
    var_dc6a063d8c9f2b8f = int( max( var_dc6a063d8c9f2b8f, 1 ) );
    
    while ( self.health < target_health )
    {
        self.health = int( min( self.health + var_dc6a063d8c9f2b8f, target_health ) );
        level callback::callback( "on_boss_progress_updated", { #maxhealth:self.maxhealth, #health:self.health } );
        waitframe();
    }
}

// Namespace zombie_aeon
// Params 0, eflags: 0x4
// Checksum 0xb142f89e, Offset: 0x8f0
// Size: 0x95c
function private update_transform()
{
    self endon( #"death" );
    move_speed = getdvarfloat( @"aeon_move_speed", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.aeonmovespeed ?? 200 );
    move_accel = getdvarfloat( @"hash_42e939058a68d804", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_78e789062b15af94 ?? 200 );
    
    if ( utility::ent_flag( "scar_exposed" ) )
    {
        move_accel *= getdvarfloat( @"hash_495b4f290e7f329f", 1.5 );
    }
    
    rot_accel = getdvarfloat( @"hash_52a5fea160bf48f0", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_32cafd75aff5f152 ?? 30 );
    damage_yaw_speed = getdvarfloat( @"hash_371558881230b16b", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_9a63e8dc6adf3b15 ?? 15 );
    enemy_radius = getdvarfloat( @"hash_5636174d2aa4fdcd", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_8f127bbccfcb6d38 ?? 5000 );
    var_48ee71281f56f926 = gettime();
    
    while ( true )
    {
        waitframe();
        current_time = gettime();
        dt = ( current_time - var_48ee71281f56f926 ) / 1000;
        var_48ee71281f56f926 = current_time;
        
        if ( dt <= 0 )
        {
            continue;
        }
        
        var_5e0d7bf8ae9e4681 = isdefined( self.nav_goal );
        target_pos = self.rest_position;
        var_474e85bf19543d46 = utility::ent_flag( "damage_phase_intro" );
        do_damage_rotation = var_474e85bf19543d46 || utility::ent_flag( "scar_exposed" );
        enemies = self function_f017e352a29a57a1( self.origin, enemy_radius, 1 );
        has_enemies = enemies.size > 0;
        
        if ( var_5e0d7bf8ae9e4681 )
        {
            target_pos = self.nav_goal;
        }
        else if ( !has_enemies && isdefined( self.notarget_position ) )
        {
            target_pos = self.notarget_position;
        }
        else if ( var_474e85bf19543d46 && isdefined( self.var_f70ce8a8a2566798 ) )
        {
            var_ee90691f367ec3f6 = getdvarfloat( @"hash_abd5028aa6098452", 200 );
            target_pos = self.var_f70ce8a8a2566798 + ( 0, 0, var_ee90691f367ec3f6 );
        }
        else if ( utility::ent_flag( "scar_exposed" ) && isdefined( self.var_f70ce8a8a2566798 ) )
        {
            target_pos = self.var_f70ce8a8a2566798;
        }
        else if ( isdefined( self.rest_position ) )
        {
            target_pos = self.rest_position;
        }
        else
        {
            continue;
        }
        
        if ( !var_5e0d7bf8ae9e4681 )
        {
            target_pos += function_588ea5054afd18f7();
        }
        
        current_pos = self.mover.origin - ( 0, 0, self.var_44230a4cf6857148 ) - self.var_e53d3e4c6139369b;
        direction = target_pos - current_pos;
        distance = length( direction );
        
        if ( distance > 0.1 )
        {
            direction_norm = vectornormalize( direction );
            stopping_threshold = move_speed * move_speed / 2 * move_accel;
            
            if ( distance < stopping_threshold )
            {
                desired_speed = move_speed * sqrt( distance / stopping_threshold );
            }
            else
            {
                desired_speed = move_speed;
            }
            
            desired_velocity = direction_norm * desired_speed;
            velocity_diff = desired_velocity - self.move_velocity;
            var_1118862a2d01943a = move_accel * dt;
            
            if ( length( velocity_diff ) <= var_1118862a2d01943a )
            {
                self.move_velocity = desired_velocity;
            }
            else
            {
                self.move_velocity += vectornormalize( velocity_diff ) * var_1118862a2d01943a;
            }
            
            base_pos = current_pos + self.move_velocity * dt;
            
            if ( distance < 1 && distance( base_pos, target_pos ) > distance )
            {
                base_pos = target_pos;
            }
        }
        else
        {
            current_speed = length( self.move_velocity );
            
            if ( current_speed > 0.1 )
            {
                new_speed = max( current_speed - move_accel * dt, 0 );
                self.move_velocity = vectornormalize( self.move_velocity ) * new_speed;
            }
            else
            {
                self.move_velocity = ( 0, 0, 0 );
            }
            
            base_pos = target_pos;
        }
        
        current_angles = self.mover.angles;
        shielding_yaw_speed = getdvarfloat( @"hash_4f61d9695b82e815", 120 );
        var_2711feff9d3dc0d8 = getdvarfloat( @"hash_d967da3a5b617780", 120 );
        shielding_threshold = getdvarfloat( @"hash_92c45dd6d36b3bc1", 5 );
        
        if ( do_damage_rotation )
        {
            current_accel = rot_accel;
            
            if ( isdefined( self.var_4f6fb0ccb871d72b ) )
            {
                current_accel = var_2711feff9d3dc0d8;
                yaw_diff = angleclamp180( self.var_4f6fb0ccb871d72b - current_angles[ 1 ] );
                
                if ( yaw_diff < 0 )
                {
                    yaw_diff = 360 + yaw_diff;
                }
                
                if ( yaw_diff <= shielding_threshold )
                {
                    self.var_4f6fb0ccb871d72b = undefined;
                    var_df9adb69b75ff5f3 = damage_yaw_speed;
                }
                else
                {
                    stopping_dist = self.rot_velocity * self.rot_velocity / 2 * current_accel;
                    
                    if ( yaw_diff <= stopping_dist + shielding_threshold )
                    {
                        var_df9adb69b75ff5f3 = 0;
                    }
                    else
                    {
                        var_df9adb69b75ff5f3 = shielding_yaw_speed;
                    }
                }
            }
            else if ( var_474e85bf19543d46 )
            {
                var_1e31c61c480f70e9 = getdvarfloat( @"hash_d6e9231c0a0cb375", 180 );
                current_accel = getdvarfloat( @"hash_38b45890462698ed", 500 );
                var_df9adb69b75ff5f3 = var_1e31c61c480f70e9;
            }
            else
            {
                var_df9adb69b75ff5f3 = damage_yaw_speed;
            }
            
            vel_diff = var_df9adb69b75ff5f3 - self.rot_velocity;
            max_accel = current_accel * dt;
            
            if ( abs( vel_diff ) <= max_accel )
            {
                self.rot_velocity = var_df9adb69b75ff5f3;
            }
            else if ( vel_diff > 0 )
            {
                self.rot_velocity += max_accel;
            }
            else
            {
                self.rot_velocity -= max_accel;
            }
            
            new_yaw = angleclamp180( current_angles[ 1 ] + self.rot_velocity * dt );
        }
        else
        {
            new_yaw = current_angles[ 1 ];
            
            if ( abs( self.rot_velocity ) > 0.1 )
            {
                if ( self.rot_velocity > 0 )
                {
                    self.rot_velocity = max( self.rot_velocity - rot_accel * dt, 0 );
                }
                else
                {
                    self.rot_velocity = min( self.rot_velocity + rot_accel * dt, 0 );
                }
                
                new_yaw = angleclamp180( current_angles[ 1 ] + self.rot_velocity * dt );
            }
            
            self.var_4f6fb0ccb871d72b = undefined;
        }
        
        tilt_max = getdvarfloat( @"hash_287497d69330801", 0 );
        var_7134c4818c57928b = getdvarfloat( @"hash_3b7d0af4199ac05a", 0.1 );
        tilt_lerp_speed = getdvarfloat( @"hash_6cb2997587753788", 0.2 );
        vel_speed = length2d( self.move_velocity );
        
        if ( vel_speed > 0.1 )
        {
            vel_dir = vectornormalize( ( self.move_velocity[ 0 ], self.move_velocity[ 1 ], 0 ) );
            vel_angles = vectortoangles( vel_dir );
            yaw_delta = angleclamp180( vel_angles[ 1 ] - new_yaw );
            tilt_amt = min( vel_speed * var_7134c4818c57928b, tilt_max );
            var_fc8fe7516c546b36 = cos( yaw_delta ) * -1 * tilt_amt;
            target_roll = sin( yaw_delta ) * tilt_amt;
            self.var_6af71d680c211120 = ( var_fc8fe7516c546b36 * -1, 0, target_roll * -1 );
        }
        else
        {
            self.var_6af71d680c211120 = ( 0, 0, 0 );
        }
        
        self.heart_tilt = anglelerpquatfrac( self.heart_tilt, self.var_6af71d680c211120, tilt_lerp_speed );
        heart_height = getdvarfloat( @"hash_df27ac2f7d46d378", 200 );
        local_offset_x = heart_height * sin( self.heart_tilt[ 0 ] );
        local_offset_y = heart_height * sin( self.heart_tilt[ 2 ] );
        world_offset_x = local_offset_x * cos( new_yaw ) - local_offset_y * sin( new_yaw );
        world_offset_y = local_offset_x * sin( new_yaw ) + local_offset_y * cos( new_yaw );
        self.var_26166beeb9fc4cd9 = ( world_offset_x, world_offset_y, 0 );
        self.mover.origin = base_pos + ( 0, 0, self.heart_pulse_offset ) + self.var_26166beeb9fc4cd9;
        self.var_44230a4cf6857148 = self.heart_pulse_offset;
        self.var_e53d3e4c6139369b = self.var_26166beeb9fc4cd9;
        self.mover.angles = ( self.heart_tilt[ 0 ], new_yaw, self.heart_tilt[ 2 ] );
    }
}

// Namespace zombie_aeon
// Params 1
// Checksum 0x1673a249, Offset: 0x1254
// Size: 0x17
function set_rest_position( position )
{
    self.rest_position = position;
}

// Namespace zombie_aeon
// Params 1
// Checksum 0xd29d755a, Offset: 0x1273
// Size: 0x17
function function_71b88f65f500bd75( position )
{
    self.var_f70ce8a8a2566798 = position;
}

// Namespace zombie_aeon
// Params 1
// Checksum 0x52dcf05, Offset: 0x1292
// Size: 0x17
function function_c1536ac84038a760( var_c464a2d2aa68df50 )
{
    self.var_298d806e0fbc8a21 = var_c464a2d2aa68df50;
}

// Namespace zombie_aeon
// Params 1
// Checksum 0x7520d862, Offset: 0x12b1
// Size: 0x17
function set_notarget_position( position )
{
    self.notarget_position = position;
}

// Namespace zombie_aeon
// Params 0, eflags: 0x4
// Checksum 0xfb1e16b, Offset: 0x12d0
// Size: 0x214
function private function_588ea5054afd18f7()
{
    circle_radius = getdvarfloat( @"hash_e5e2f2827410b076", 400 );
    z_min = getdvarfloat( @"hash_e6b876bbda1e8e84", -150 );
    z_max = getdvarfloat( @"hash_e6db84bbda44f506", 100 );
    var_960d5ac1e16a4c2d = getdvarfloat( @"hash_9d5fb665be44a650", 50 );
    dist_far = getdvarfloat( @"hash_3fab0f31bf27cd6d", 1600 );
    players = self function_f017e352a29a57a1( self.origin, 5000, 1 );
    closest_player = undefined;
    closest_dist = 999999;
    
    foreach ( player in players )
    {
        dist = distance2d( player.origin, self.spawn_ground_pos );
        
        if ( dist < closest_dist )
        {
            closest_dist = dist;
            closest_player = player;
        }
    }
    
    if ( !isdefined( closest_player ) )
    {
        return ( 0, 0, 0 );
    }
    
    t = clamp( ( closest_dist - var_960d5ac1e16a4c2d ) / ( dist_far - var_960d5ac1e16a4c2d ), 0, 1 );
    dir_to_player = closest_player.origin - self.spawn_ground_pos;
    dir_to_player = ( dir_to_player[ 0 ], dir_to_player[ 1 ], 0 );
    
    if ( length( dir_to_player ) > 0.1 )
    {
        dir_to_player = vectornormalize( dir_to_player );
    }
    else
    {
        dir_to_player = ( 1, 0, 0 );
    }
    
    dir_factor = -1 + 2 * t;
    xy_offset = dir_to_player * dir_factor * circle_radius;
    z_offset = z_min + ( z_max - z_min ) * t;
    return ( xy_offset[ 0 ], xy_offset[ 1 ], z_offset );
}

// Namespace zombie_aeon
// Params 1, eflags: 0x4
// Checksum 0x16d4fef8, Offset: 0x14ed
// Size: 0x208
function private function_7ebc13ba0dd9086e( attacker_pos )
{
    aeon_center = self getcentroid();
    dir_to_attacker = attacker_pos - aeon_center;
    dir_to_attacker = ( dir_to_attacker[ 0 ], dir_to_attacker[ 1 ], 0 );
    
    if ( length( dir_to_attacker ) < 1 )
    {
        return;
    }
    
    dir_to_attacker = vectornormalize( dir_to_attacker );
    attacker_yaw = vectortoangles( dir_to_attacker )[ 1 ];
    exposed = zombie_aeon_metabones::get_exposed_weakpoints( self );
    
    if ( !isdefined( exposed ) || exposed.size == 0 )
    {
        return;
    }
    
    current_yaw = self.mover.angles[ 1 ];
    sum_x = 0;
    sum_y = 0;
    count = 0;
    
    foreach ( wp in exposed )
    {
        tag = zombie_aeon_metabones::get_weakpoint_tag( wp );
        wp_pos = self gettagorigin( tag );
        var_7d8e384c2bc5db1b = wp_pos - aeon_center;
        var_7d8e384c2bc5db1b = ( var_7d8e384c2bc5db1b[ 0 ], var_7d8e384c2bc5db1b[ 1 ], 0 );
        
        if ( length( var_7d8e384c2bc5db1b ) < 1 )
        {
            continue;
        }
        
        var_7d8e384c2bc5db1b = vectornormalize( var_7d8e384c2bc5db1b );
        wp_yaw = vectortoangles( var_7d8e384c2bc5db1b )[ 1 ];
        local_angle = angleclamp180( wp_yaw - current_yaw );
        sum_x += cos( local_angle );
        sum_y += sin( local_angle );
        count++;
    }
    
    if ( count == 0 )
    {
        return;
    }
    
    if ( abs( sum_x ) < 0.001 && abs( sum_y ) < 0.001 )
    {
        var_ce586f9066877816 = 0;
    }
    else
    {
        var_ce586f9066877816 = vectortoangles( ( sum_x, sum_y, 0 ) )[ 1 ];
    }
    
    return angleclamp180( attacker_yaw + 180 - var_ce586f9066877816 );
}

// Namespace zombie_aeon
// Params 0, eflags: 0x4
// Checksum 0x915ea599, Offset: 0x16fe
// Size: 0x2a
function private monitor_heart_pulse()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"heart_pulse" );
        thread animate_heart_pulse();
    }
}

// Namespace zombie_aeon
// Params 0, eflags: 0x4
// Checksum 0x8febd229, Offset: 0x1730
// Size: 0x141
function private animate_heart_pulse()
{
    self notify( #"hash_6f7899dcf9a7959" );
    self endon( #"hash_6f7899dcf9a7959" );
    self endon( #"death" );
    pulse_height = getdvarfloat( @"hash_ba39ffdae43cfeca", 0 );
    
    if ( utility::ent_flag( "scar_exposed" ) )
    {
        pulse_height *= getdvarfloat( @"hash_31946fb0ff72811a", 2 );
    }
    
    var_f7fec3dda235943f = getdvarfloat( @"hash_379db31ab7cafd64", 0.3 );
    pulse_down_time = getdvarfloat( @"hash_3fbfc0337b6a85ef", 0.1 );
    start_time = gettime();
    
    while ( true )
    {
        elapsed = ( gettime() - start_time ) / 1000;
        
        if ( elapsed >= var_f7fec3dda235943f )
        {
            self.heart_pulse_offset = pulse_height;
            break;
        }
        
        t = elapsed / var_f7fec3dda235943f;
        self.heart_pulse_offset = pulse_height * t;
        waitframe();
    }
    
    start_time = gettime();
    
    while ( true )
    {
        elapsed = ( gettime() - start_time ) / 1000;
        
        if ( elapsed >= pulse_down_time )
        {
            self.heart_pulse_offset = 0;
            break;
        }
        
        t = elapsed / pulse_down_time;
        self.heart_pulse_offset = pulse_height * ( 1 - t );
        waitframe();
    }
}

// Namespace zombie_aeon
// Params 0
// Checksum 0xf32b514c, Offset: 0x1879
// Size: 0x79
function function_e81e91da9d7f3d31()
{
    new_max_health = int( self.maxhealth * ( 3 - self.n_fight_phase ) * 0.33 );
    self.health = new_max_health;
    self.var_d200801f77f0de0 = new_max_health;
    self.n_fight_phase++;
    self notify( #"phase_changed" );
    callback::callback( "on_aeon_phase_changed", { #phase:self.n_fight_phase } );
}

// Namespace zombie_aeon
// Params 0, eflags: 0x4
// Checksum 0x36f6b932, Offset: 0x18fa
// Size: 0x5a
function private function_8f65e828c494cb42()
{
    self endon( #"death" );
    self endon( #"phase_changed" );
    self waittill( #"phase_weakpoints_destroyed" );
    
    if ( self.n_fight_phase >= 3 )
    {
        utility::ent_flag_set( "marked_for_death" );
        zombie_aeon_metabones::function_7fdafa1b5338fc8e( self );
        self kill();
        return;
    }
    
    function_e81e91da9d7f3d31();
}

// Namespace zombie_aeon
// Params 1, eflags: 0x4
// Checksum 0x91bd168e, Offset: 0x195c
// Size: 0xc5
function private function_462e8bdd6281a400( params )
{
    zombie_aeon_flame_tornado::function_f7c656e727e98246();
    zombie_aeon_fireball::function_6315aec8c403efb5();
    zombie_aeon_metabones::cleanup_weakpoint_pings();
    
    if ( isdefined( self.mover ) )
    {
        self.mover delete();
        self.mover = undefined;
    }
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player zombie_boss_healthbar::zombie_boss_healthbar_hide();
        }
    }
}

// Namespace zombie_aeon
// Params 1, eflags: 0x4
// Checksum 0x851952cb, Offset: 0x1a29
// Size: 0x8e
function private play_death_fx( params )
{
    if ( params.body )
    {
        params.body function_dd258a3da9a2b4a1( 20 );
        var_46063ece3767f60b = self getcentroid();
        var_46063ece3767f60b += ( 0, 0, getdvarfloat( @"hash_70710aeeffd9a32a", 0 ) );
        wait 1;
        level callback::callback( "aeon_death_explosion", { #origin:var_46063ece3767f60b } );
        waitframe();
        
        if ( params.body )
        {
            params.body delete();
        }
    }
}

// Namespace zombie_aeon
// Params 1, eflags: 0x4
// Checksum 0x13ef755f, Offset: 0x1abf
// Size: 0x1f1
function private function_3d6885c7d4f1e99c( params )
{
    if ( !isalive( self ) || self.n_fight_phase == 3 )
    {
        return;
    }
    
    b_hit_weakpoint = 0;
    
    if ( isdefined( params.metabonename ) )
    {
        if ( zombie_aeon_metabones::function_dc9f50c17f958a22( params.metabonename ) )
        {
            b_hit_weakpoint = 1;
            utility::function_32b24db3127bff40( params.metabonename + "_impact", "on" );
            
            if ( isplayer( params.eattacker ) && isdefined( params.eattacker.origin ) )
            {
                enemy_radius = getdvarfloat( @"hash_5636174d2aa4fdcd", 5000 );
                enemies = self function_f017e352a29a57a1( self.origin, enemy_radius, 1 );
                attacker_known = 0;
                
                foreach ( e in enemies )
                {
                    if ( e == params.eattacker )
                    {
                        attacker_known = 1;
                        break;
                    }
                }
                
                if ( !attacker_known )
                {
                    self.var_4f6fb0ccb871d72b = function_7ebc13ba0dd9086e( params.eattacker.origin );
                }
            }
        }
    }
    
    self notify( #"hash_a628d3786516c7ae", params.idamage, params.eattacker, b_hit_weakpoint );
    zombie_aeon_fireball::function_9e45e7dd08af62b6( params );
    
    if ( self.maxhealth - self.health > self.maxhealth * self.n_fight_phase * 0.33 )
    {
        function_e81e91da9d7f3d31();
    }
}

// Namespace zombie_aeon
// Params 0, eflags: 0x4
// Checksum 0x2488722a, Offset: 0x1cb8
// Size: 0x47
function private initscriptable()
{
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    utility::waittill_any_timeout( level.framedurationseconds, "post_spawn" );
    utility::function_7c10ea82c1e305b8( "base", "base_on" );
    zombie_aeon_metabones::init_zombie_aeon_metabones();
}

// Namespace zombie_aeon
// Params 1, eflags: 0x4
// Checksum 0x9a77ec21, Offset: 0x1d07
// Size: 0x5ce
function private function_f4933dd3e62ce521( params )
{
    if ( !utility::ent_flag( "scar_exposed" ) )
    {
        return 0;
    }
    
    var_fa73e4e06a81b041 = 0.8;
    var_cee395575559ddb9 = 3;
    damage = params.idamage;
    
    if ( !params.metabonename )
    {
        return 0;
    }
    
    if ( !zombie_aeon_metabones::function_dc9f50c17f958a22( params.metabonename ) )
    {
        return 0;
    }
    
    is_wonder = weapon::iswonderweapon( params.sweapon );
    
    if ( isdefined( params.sweapon ) && isplayer( params.eattacker ) )
    {
        paplevel = params.eattacker namespace_9d8e359c3b1041e5::function_1d4087075103b248( params.sweapon );
        
        if ( paplevel >= var_cee395575559ddb9 )
        {
            damage *= var_fa73e4e06a81b041;
        }
        
        if ( paplevel >= 4 )
        {
            damage *= 0.6;
        }
        
        rarity = params.eattacker namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( params.sweapon );
        
        if ( rarity == 5 && !is_wonder )
        {
            damage *= 0.8;
        }
    }
    
    if ( is_wonder )
    {
        damage *= getdvarfloat( @"hash_e1d43d11f541eaab", 2 );
        var_6afa0b0478dd143c = isdefined( params.sweapon.basename ) && issubstr( params.sweapon.basename, "mark2" );
        
        if ( var_6afa0b0478dd143c )
        {
            damage *= getdvarfloat( @"hash_d6c66581cc19d1b5", 0.3 );
        }
        else if ( issubstr( params.sweapon.basename, "raygun" ) )
        {
            damage *= getdvarfloat( @"hash_5bfc8131ecd1d558", 4 );
        }
        else if ( issubstr( params.sweapon.basename, "ww_mantis" ) )
        {
            damage *= 0.5;
            
            if ( params.eattacker.var_c6dc679b7c670e65 )
            {
                damage *= getdvarfloat( @"hash_99b1889591a3a22c", 5 );
            }
        }
    }
    
    if ( arraycontains( [ "mg", "smg", "rifle" ], params.sweapon.classname ) )
    {
        damage *= 1;
    }
    else if ( arraycontains( [ "pistol" ], params.sweapon.classname ) )
    {
        damage *= 1;
    }
    else if ( arraycontains( [ "spread" ], params.sweapon.classname ) )
    {
        damage *= 0.25;
    }
    else if ( arraycontains( [ "rocketlauncher", "grenade" ], params.sweapon.classname ) )
    {
        damage *= 0.125;
    }
    else if ( arraycontains( [ "turret" ], params.sweapon.classname ) )
    {
        damage *= 0.25;
        
        if ( params.biscritical && isexplosivedamagemod( params.smeansofdeath ) )
        {
            damage *= getdvarfloat( @"hash_fee128cb045e9e73", 0.4 );
        }
    }
    else if ( arraycontains( [ "throwingknife" ], params.sweapon.classname ) )
    {
        damage *= 0.1;
    }
    else if ( params.biscritical && isexplosivedamagemod( params.smeansofdeath ) && params.sweapon.damagemodcategory != #"lethal" )
    {
        damage *= getdvarfloat( @"hash_6fb71acbaf74eb56", 0.5 );
    }
    
    if ( issubstr( params.sweapon.basename, "crossbow" ) )
    {
        damage *= 0.25;
    }
    
    if ( issubstr( params.sweapon.basename, "smartgun" ) )
    {
        damage *= 0.1;
    }
    
    if ( issubstr( params.sweapon.basename, "warmachine" ) )
    {
        damage *= 0.5;
    }
    else if ( issubstr( params.sweapon.basename, "deathmachine" ) )
    {
        damage *= 0.15;
    }
    else if ( issubstr( params.sweapon.basename, "handcannon" ) )
    {
        damage *= 0.2;
    }
    
    if ( params.smeansofdeath == "MOD_MELEE" || params.sweapon.ismelee )
    {
        damage *= getdvarfloat( @"hash_a5caf50e4d1af01b", 0.35 );
    }
    
    if ( params.smeansofdeath == "MOD_BLEEDOUT" )
    {
        damage *= 0.1;
    }
    
    solo_max_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( self.subclass, zombie_utils::get_zombie_round_difficulty(), 1 );
    var_f27162ef1912d024 = 0.075 * solo_max_health / self.maxhealth;
    params.var_ff33243f5be1fe3b = min( params.var_ff33243f5be1fe3b, var_f27162ef1912d024 );
    
    if ( getdvarint( @"hash_308871e6be295b74", 0 ) )
    {
        damage *= 25;
    }
    
    return damage;
}

// Namespace zombie_aeon
// Params 0, eflags: 0x4
// Checksum 0x92c804a6, Offset: 0x22de
// Size: 0x7e
function private init_difficulty_changes()
{
    self endon( #"death" );
    waitframe();
    
    if ( isdefined( level.directed_mode ) || getdvarint( @"hash_1dcf1f9afda7d384", 0 ) )
    {
        var_2c360ac214485358 = 0.35;
        ai::set_ai_max_health( int( self.maxhealth * var_2c360ac214485358 ) );
        self.var_9dd11279d5e371c7 *= var_2c360ac214485358;
        self.health = self.maxhealth;
        return;
    }
}

/#

    // Namespace zombie_aeon
    // Params 0, eflags: 0x4
    // Checksum 0xb0ba5537, Offset: 0x2364
    // Size: 0x109, Type: dev
    function private init_zombie_aeon_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3a>", "<dev string:x4e>", &function_bd555757d7d7b25 );
        devgui::add_devgui_func( "<dev string:x68>", "<dev string:x7d>", &function_9ac1f936d714c2dd );
        devgui::add_devgui_func( "<dev string:x98>", "<dev string:xac>", &debug_spawn_flame_tornado );
        devgui::add_devgui_func( "<dev string:xc0>", "<dev string:xd5>", &function_8ecab2c375344ea1 );
        devgui::function_eaac4ba4b3caf621( "<dev string:xea>", @"scr_flame_tornado_debug" );
        devgui::add_devgui_func( "<dev string:x105>", "<dev string:x11c>", &function_e5af2ffcd09c7844 );
        devgui::add_devgui_func( "<dev string:x133>", "<dev string:x149>", &function_cd7fd32a99257c97 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x15f>", "<dev string:x171>", &function_ea7967de1aa7dee0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x18e>", "<dev string:x1a1>", &function_ea7967de1aa7dee0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1bf>", "<dev string:x1d8>", &function_ea7967de1aa7dee0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1fe>", "<dev string:x214>", &function_ea7967de1aa7dee0 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_aeon
    // Params 0, eflags: 0x4
    // Checksum 0xad1f8d9, Offset: 0x2475
    // Size: 0x51, Type: dev
    function private function_bd555757d7d7b25()
    {
        aeon = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x237>" );
        
        if ( !isdefined( aeon ) )
        {
            return;
        }
        
        aeon set_scar_exposed_state( !aeon utility::ent_flag( "<dev string:x243>" ) );
    }

    // Namespace zombie_aeon
    // Params 0, eflags: 0x4
    // Checksum 0x4695dce8, Offset: 0x24ce
    // Size: 0x43, Type: dev
    function private function_9ac1f936d714c2dd()
    {
        aeon = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x237>" );
        
        if ( !isdefined( aeon ) )
        {
            return;
        }
        
        aeon function_71d11630a0dd05d5();
    }

    // Namespace zombie_aeon
    // Params 1, eflags: 0x4
    // Checksum 0x42ea3b30, Offset: 0x2519
    // Size: 0xd6, Type: dev
    function private function_ea7967de1aa7dee0( params )
    {
        aeon = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x237>" );
        
        if ( !isdefined( aeon ) )
        {
            return;
        }
        
        if ( params[ 0 ] == "<dev string:x250>" )
        {
            n_damage = aeon.maxhealth * 0.333;
        }
        else if ( params[ 0 ] == "<dev string:x25d>" )
        {
            n_damage = aeon.maxhealth;
        }
        else
        {
            n_damage = int( params[ 0 ] );
        }
        
        aeon set_scar_exposed_state( 1 );
        aeon.var_7037157e68c4992b = n_damage;
        aeon dodamage( int( n_damage ), aeon.origin, aeon, aeon, "<dev string:x267>" );
        aeon set_scar_exposed_state( 0 );
    }

    // Namespace zombie_aeon
    // Params 0, eflags: 0x4
    // Checksum 0x86a519e8, Offset: 0x25f7
    // Size: 0x75, Type: dev
    function private debug_spawn_flame_tornado()
    {
        aeon = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x237>" );
        
        if ( !isdefined( aeon ) )
        {
            return;
        }
        
        ft = aeon zombie_aeon_flame_tornado::spawn_flame_tornado( getrandomnavpoint( aeon.origin, 500 ), aeon.angles );
        ft thread utility::delete_after_delay( 600 );
    }

    // Namespace zombie_aeon
    // Params 0, eflags: 0x4
    // Checksum 0x88552d9d, Offset: 0x2674
    // Size: 0x50, Type: dev
    function private function_8ecab2c375344ea1()
    {
        aeon = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x237>" );
        
        if ( !isdefined( aeon ) )
        {
            return;
        }
        
        aeon notify( #"hash_761775ec6a6d8c09" );
        aeon function_7059b85a384fcc35();
    }

    // Namespace zombie_aeon
    // Params 0, eflags: 0x4
    // Checksum 0xb5da3f18, Offset: 0x26cc
    // Size: 0x43, Type: dev
    function private function_e5af2ffcd09c7844()
    {
        aeon = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x237>" );
        
        if ( !isdefined( aeon ) )
        {
            return;
        }
        
        aeon zombie_aeon_fireball::function_29ce95199d42d5c4();
    }

    // Namespace zombie_aeon
    // Params 0, eflags: 0x4
    // Checksum 0xbe951e8a, Offset: 0x2717
    // Size: 0x50, Type: dev
    function private function_cd7fd32a99257c97()
    {
        aeon = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x237>" );
        
        if ( !isdefined( aeon ) )
        {
            return;
        }
        
        aeon notify( #"stop_fireballs" );
        aeon zombie_aeon_fireball::function_5ce011b9f8892d6d();
    }

#/
