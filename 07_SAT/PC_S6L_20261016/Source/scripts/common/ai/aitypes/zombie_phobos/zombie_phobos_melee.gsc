// scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_melee.gsc  (hash_38bf59b696e85857.gscc) (size: 11173 Bytes / 0x2ba5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcecce02f (3469533231)
// size ...... 11173 (0x2ba5)
// includes .. 12  (offset: 0x2901)
// strings ... 18  (offset: 0x2961)
// dev strs .. 22  (offset: 0x2a95)
// exports ... 22  (offset: 0x17f9)
// cseg ...... 0x15a + 0x169f (0x17f9)
// imports ... 107 (offset: 0x1b69)
// animtree1 . 0   (offset: 0x2ba5)
// animtree2 . 0   (offset: 0x2ba5)
#using script_16ea1b94f0f381b3;
#using script_290c63919fb4afde;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_leap_attack;
#using scripts\common\ai\aitypes\shared\zombie\zombie_melee;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_collision;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_metabones;
#using scripts\common\devgui;
#using scripts\common\easing;
#using scripts\common\math;
#using scripts\common\utility;

#namespace zombie_phobos_melee;

/#

    // Namespace zombie_phobos_melee
    // Params 0
    // Checksum 0x80ae1a28, Offset: 0x178
    // Size: 0xc, Type: dev
    function function_929bce1856d7c942()
    {
        function_91ca21c79b1e67fb();
    }

#/

// Namespace zombie_phobos_melee
// Params 0
// Checksum 0xebc9fd02, Offset: 0x18c
// Size: 0x1e
function init_zombie_phobos_melee()
{
    zombie_melee::init_zombie_melee();
    self.var_d4a397a6f6cddafa = &function_d4a397a6f6cddafa;
    thread function_5db0b76b4fe4a1e2();
}

// Namespace zombie_phobos_melee
// Params 2
// Checksum 0x56daf382, Offset: 0x1b2
// Size: 0x126
function function_94f988a5504e751f( taskid, params )
{
    assert( isalive( self ) && isai( self ) );
    
    if ( !isalive( self ) || !isai( self ) )
    {
        return anim.failure;
    }
    
    if ( asm::asm_getcurrentstatename( self.asmname ) == "melee" )
    {
        return anim.running;
    }
    
    if ( !isdefined( self.enemy ) )
    {
        return anim.failure;
    }
    
    targets = self function_f017e352a29a57a1( self.origin, 2000, 1 );
    
    foreach ( target in targets )
    {
        if ( function_57e187248ca7b774( target ) )
        {
            return anim.success;
        }
    }
    
    return anim.failure;
}

// Namespace zombie_phobos_melee
// Params 1, eflags: 0x4
// Checksum 0x18922887, Offset: 0x2e1
// Size: 0x2ec, Type: bool
function private function_57e187248ca7b774( target )
{
    if ( zombie_phobos_collision::is_player_attached( target ) )
    {
        return false;
    }
    
    if ( zombie_leap_attack::is_in_leap_attack() )
    {
        return true;
    }
    
    if ( utility::ent_flag( "post_leap_attack" ) || utility::ent_flag( "in_phobos_leap" ) )
    {
        return false;
    }
    
    if ( self getaiblackboarddynamic( "in_turning" ) == 1 )
    {
        return true;
    }
    
    if ( self getaiblackboarddynamic( "in_exit" ) == 1 )
    {
        return true;
    }
    
    target_pos = target.origin;
    to_yaw = utility::getyawtospot( target_pos );
    
    /#
        if ( debug_melee() )
        {
            print3d( target_pos + ( 0, 0, 130 ), "<dev string:x24>" + to_yaw, ( 1, 0.2, 0 ) );
        }
    #/
    
    var_c9087d8d74ef13f3 = abs( to_yaw ) > getdvarfloat( @"hash_39bbeff99aac61b", 150 );
    
    if ( abs( to_yaw ) > getdvarfloat( @"hash_c4679693bcb86e7e", 75 ) && !var_c9087d8d74ef13f3 )
    {
        return false;
    }
    
    dist = distance( target_pos, self.origin );
    
    /#
        if ( debug_melee() )
        {
            print3d( target_pos + ( 0, 0, 100 ), "<dev string:x37>" + dist, ( 1, 0.2, 0 ) );
        }
    #/
    
    if ( dist < getdvarfloat( @"hash_27f244d09b77a2fb", 230 ) && !var_c9087d8d74ef13f3 )
    {
        return false;
    }
    
    max_trigger_dist = getdvarfloat( @"hash_b1ee9d940ab64f2a", 400 );
    var_df9adb69b75ff5f3 = target getvelocity();
    var_65d1ff2692ab8da9 = vectordot2( vectornormalize2( self.origin - target_pos ), var_df9adb69b75ff5f3, 0 );
    
    if ( var_65d1ff2692ab8da9 > 0 )
    {
        range_boost = getdvarfloat( @"hash_88a0cce547f6848e", 300 );
        max_trigger_dist += clamp( math::remap( var_65d1ff2692ab8da9, getdvarfloat( @"hash_8ed88cd3a2c17ca1", 50 ), getdvarfloat( @"hash_8efb7ed3a2e7a58f", 300 ), 0, range_boost ), 0, range_boost );
    }
    else if ( var_65d1ff2692ab8da9 < 0 )
    {
        range_penalty = getdvarfloat( @"hash_32b11f2512603e0c", 70 );
        max_trigger_dist -= clamp( math::remap( var_65d1ff2692ab8da9, getdvarfloat( @"hash_84a03e39f23b29d7", -50 ), getdvarfloat( @"hash_71226252de8c2385", -100 ), 0, range_penalty ), 0, range_penalty );
    }
    
    /#
        if ( debug_melee() )
        {
            print3d( target_pos + ( 0, 0, 200 ), "<dev string:x4b>" + var_65d1ff2692ab8da9 + "<dev string:x5d>" + max_trigger_dist );
        }
    #/
    
    if ( dist < max_trigger_dist )
    {
        /#
            if ( debug_melee() )
            {
                print3d( target_pos, "<dev string:x76>" + to_yaw );
            }
        #/
        
        self._blackboard.meleerequestedtarget = target;
        self notify( #"hash_9f6d1fd5ff565730" );
        return true;
    }
    
    return false;
}

// Namespace zombie_phobos_melee
// Params 2
// Checksum 0xcf93fa6c, Offset: 0x5d6
// Size: 0x283
function function_1d351ffacd9a8dc4( taskid, params )
{
    assert( isalive( self ) && isai( self ) );
    
    if ( !isalive( self ) || !isai( self ) )
    {
        return anim.failure;
    }
    
    if ( asm::asm_getcurrentstatename( self.asmname ) == "melee" )
    {
        return anim.running;
    }
    
    if ( zombie_leap_attack::is_in_leap_attack() )
    {
        return anim.failure;
    }
    
    if ( utility::ent_flag( "post_leap_attack" ) || utility::ent_flag( "in_phobos_leap" ) )
    {
        return anim.failure;
    }
    
    if ( self getaiblackboarddynamic( "in_turning" ) == 1 )
    {
        return anim.success;
    }
    
    if ( self getaiblackboarddynamic( "in_exit" ) == 1 )
    {
        return anim.success;
    }
    
    if ( zombie_phobos_metabones::function_d106078919e7275f() > 1 )
    {
        return anim.failure;
    }
    
    dist_to_goal = self pathdisttogoal();
    
    if ( dist_to_goal < 200 )
    {
        return anim.failure;
    }
    
    var_ebc34b520297d1df = self getposonpath( 300 );
    ai_scan_radius = 100;
    all_ai_array = getaiarrayinradius( var_ebc34b520297d1df, ai_scan_radius );
    ai_array = [];
    
    foreach ( ai in all_ai_array )
    {
        if ( ai.team === self.team && ai.aicategory === "normal" )
        {
            if ( !ai utility::ent_flag( "phobos_empowered" ) )
            {
                ai_array[ ai_array.size ] = ai;
            }
        }
    }
    
    /#
        if ( debug_melee() )
        {
            print3d( var_ebc34b520297d1df + ( 0, 0, 50 ), "<dev string:x8d>" + ai_array.size, ( 0.5, 0.2, 0.2 ) );
            utility::draw_circle( var_ebc34b520297d1df, ai_scan_radius, ( 0.5, 0.2, 0.2 ) );
        }
    #/
    
    if ( ai_array.size <= 0 )
    {
        return anim.failure;
    }
    
    self._blackboard.meleerequestedtarget = ai_array[ 0 ];
    self notify( #"hash_9f6d1fd5ff565730" );
    return anim.success;
}

// Namespace zombie_phobos_melee
// Params 2
// Checksum 0x66ee9462, Offset: 0x862
// Size: 0x35
function function_9323516403589409( taskid, params )
{
    melee_score = getdvarfloat( @"hash_4220710c597139bf", 0.5 );
    return melee_score;
}

// Namespace zombie_phobos_melee
// Params 2
// Checksum 0x7062dcc6, Offset: 0x8a0
// Size: 0x1c
function function_d4a397a6f6cddafa( msg, var_efc8748fdbf5d5f8 )
{
    thread function_a33d2fc313459239();
}

// Namespace zombie_phobos_melee
// Params 0, eflags: 0x4
// Checksum 0x190f6d4f, Offset: 0x8c4
// Size: 0x87
function private function_a33d2fc313459239()
{
    self endon( #"bmeleeended" );
    self endon( #"death" );
    self endon( #"hit_end" );
    
    if ( namespace_2823e49aa0908abb::function_e0f08ce5957fca9f() )
    {
        return;
    }
    
    thread utility::thread_on_notify( "hit_end", &function_941200dbe1fd1445, self, self, [ "bmeleeended" ], self, 1.7 );
    thread utility::thread_on_notify( "hit_end", &on_hit_end, self, self, [ "bmeleeended" ], self );
    
    while ( true )
    {
        function_941200dbe1fd1445( self, 1.3 );
        waitframe();
    }
}

// Namespace zombie_phobos_melee
// Params 2, eflags: 0x4
// Checksum 0x63ceaabe, Offset: 0x953
// Size: 0x29d
function private function_941200dbe1fd1445( phobos, melee_range_multiplier = 1 )
{
    assert( isdefined( self.var_401534fee836a334 ) && isdefined( self.var_6c41e8e873b7594e ) );
    var_7cb783ab199e109e = self.var_3eaa5cd097e43179;
    var_6c41e8e873b7594e = self.var_6c41e8e873b7594e;
    
    if ( self._blackboard.var_606bf8ea1f70975d > 0 )
    {
        var_6c41e8e873b7594e *= self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_40372f826703a5e;
    }
    
    var_840926d75db91652 = function_305f5a4d542ab84b( self, melee_range_multiplier );
    
    foreach ( var_90ec0886f9ccf215 in var_840926d75db91652 )
    {
        if ( var_90ec0886f9ccf215 utility::ent_flag( "phobos_meleed" ) )
        {
            continue;
        }
        
        var_90ec0886f9ccf215 utility::ent_flag_set( "phobos_meleed" );
        var_90ec0886f9ccf215 thread utility::ent_flag_clear_delayed( "phobos_meleed", 2 );
        self.var_e93cc47a6f947ce5 = gettime();
        
        if ( isplayer( var_90ec0886f9ccf215 ) )
        {
            var_90ec0886f9ccf215 dodamage( var_6c41e8e873b7594e, self.origin, self, self, "MOD_MELEE" );
            var_90ec0886f9ccf215 function_64f1800c957cf63c();
            knockback_player( self, var_90ec0886f9ccf215 );
            phobos utility::ent_flag_set( "phobos_melee_hit_succesful" );
            var_90ec0886f9ccf215 namespace_9d8e359c3b1041e5::shellshocksharedfunc( phobos.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.melee_shock, #"damage", 0.35 );
            continue;
        }
        
        if ( isai( var_90ec0886f9ccf215 ) )
        {
            if ( var_90ec0886f9ccf215.team === self.team && var_90ec0886f9ccf215.aicategory === "normal" )
            {
                if ( !var_90ec0886f9ccf215 utility::ent_flag( "phobos_empowered" ) )
                {
                    var_90ec0886f9ccf215.forceannihilate = 1;
                    var_90ec0886f9ccf215 kill( self.origin, self, self, "MOD_MELEE" );
                    zombie_phobos_metabones::function_9824f865944fa41d( self, 2 );
                    phobos utility::ent_flag_set( "phobos_melee_hit_succesful" );
                }
                
                continue;
            }
            
            var_90ec0886f9ccf215 dodamage( var_6c41e8e873b7594e * self.var_42ddbc8ee376c279, self.origin, self, self, "MOD_MELEE" );
        }
    }
    
    if ( phobos utility::ent_flag( "phobos_melee_hit_succesful" ) )
    {
        phobos utility::function_7c10ea82c1e305b8( "bite", "hit" );
    }
}

// Namespace zombie_phobos_melee
// Params 2, eflags: 0x4
// Checksum 0x4b1f756, Offset: 0xbf8
// Size: 0x375
function private function_305f5a4d542ab84b( phobos, melee_range_multiplier = 1 )
{
    targets = [];
    cone_up = ( 0, 0, 1 );
    cone_origin = phobos gettagorigin( "j_head", 0, 0, 0 );
    var_cbae022e329d2a51 = phobos gettagangles( "j_head" );
    cone_pitch = var_cbae022e329d2a51[ 0 ] + getdvarfloat( @"hash_3fc47b87c9e9448e", 30 );
    target = phobos._blackboard.meleerequestedtarget;
    
    if ( isdefined( target ) )
    {
        target_cone_pitch = vectortoangles( target.origin - cone_origin )[ 0 ];
        cone_pitch = math::function_27800ff2fd4867c6( cone_pitch, target_cone_pitch, getdvarfloat( @"hash_cdc4786df21f5343", 30 ) );
    }
    
    cone_angles = ( cone_pitch, ( phobos.head_yaw ?? 0 ) * -1 + phobos.angles[ 1 ], var_cbae022e329d2a51[ 2 ] );
    cone_forward = anglestoforward( cone_angles );
    var_1d4601ed154a2d08 = 0;
    
    if ( abs( phobos.head_yaw ) > getdvarfloat( @"hash_cf6c04c8a2e411e8", 80 ) )
    {
        var_1d4601ed154a2d08 = getdvarfloat( @"hash_cf6c04c8a2e411e8", 1 );
    }
    
    cone_length = phobos.var_401534fee836a334 * ( melee_range_multiplier + var_1d4601ed154a2d08 );
    var_244e33c25ff537e5 = 25;
    potential_targets = getplayersandaiarrayinradius( cone_origin, cone_length );
    
    foreach ( target in potential_targets )
    {
        if ( target == phobos )
        {
            continue;
        }
        
        if ( isplayer( target ) && target.team == phobos.team )
        {
            continue;
        }
        
        if ( isplayer( target ) && target issprintsliding() )
        {
            if ( length( target getvelocity() ) > 100 )
            {
                continue;
            }
            
            slim_cone_angle = 10;
            
            if ( !math::pointvscone( target getcentroid(), cone_origin, cone_forward, cone_up, cone_length, 0, slim_cone_angle ) && !math::pointvscone( target getcentroid() - target getboundshalfsize(), cone_origin, cone_forward, cone_up, cone_length, 0, slim_cone_angle ) )
            {
                continue;
            }
            
            var_244e33c25ff537e5 = slim_cone_angle;
        }
        else if ( !math::pointvscone( target getcentroid(), cone_origin, cone_forward, cone_up, cone_length, 0, var_244e33c25ff537e5 ) && !math::pointvscone( target getcentroid() + target getboundshalfsize(), cone_origin, cone_forward, cone_up, cone_length, 0, var_244e33c25ff537e5 ) && !math::pointvscone( target getcentroid() - target getboundshalfsize(), cone_origin, cone_forward, cone_up, cone_length, 0, var_244e33c25ff537e5 ) )
        {
            continue;
        }
        
        targets[ targets.size ] = target;
        
        /#
            if ( debug_melee() )
            {
                line( target getcentroid(), cone_origin, ( 1, 0, 0 ) );
            }
        #/
    }
    
    /#
        if ( debug_melee() )
        {
            utility::draw_cone( cone_origin, cone_forward, cone_length, var_244e33c25ff537e5 );
            line( cone_origin, cone_origin + cone_up * 10 );
            line( cone_origin, cone_origin + cone_forward * 10, ( 0.6, 0.7, 0.7 ) );
        }
    #/
    
    return targets;
}

// Namespace zombie_phobos_melee
// Params 1, eflags: 0x4
// Checksum 0xd4d04af5, Offset: 0xf76
// Size: 0x61
function private on_hit_end( phobos )
{
    phobos endon( #"death" );
    waitframe();
    
    if ( !phobos utility::ent_flag( "phobos_melee_hit_succesful" ) )
    {
        phobos utility::function_7c10ea82c1e305b8( "bite", "miss" );
    }
    
    phobos utility::ent_flag_clear( "phobos_melee_hit_succesful" );
    phobos._blackboard.meleerequestedtarget = undefined;
}

// Namespace zombie_phobos_melee
// Params 2, eflags: 0x4
// Checksum 0x9d2e6372, Offset: 0xfdf
// Size: 0x99
function private knockback_player( phobos, player )
{
    if ( player.inlaststand )
    {
        return;
    }
    
    var_c51215b779b5fe59 = vectornormalize2( player.origin - phobos.origin );
    to_player_perp = anglestoright( vectortoangles( var_c51215b779b5fe59 ) );
    knockback_dir = rotatepointaroundvector( to_player_perp, var_c51215b779b5fe59, getdvarfloat( @"hash_bbf3c308d5177a13", 30 ) );
    player knockback( knockback_dir, getdvarfloat( @"phobos_melee_knockback", 700 ), 1 );
}

// Namespace zombie_phobos_melee
// Params 0, eflags: 0x4
// Checksum 0xad2a2316, Offset: 0x1080
// Size: 0x3e
function private function_5db0b76b4fe4a1e2()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hash_9f6d1fd5ff565730" );
        thread on_melee_start();
        self waittill( #"bmeleeended" );
        thread on_melee_end();
    }
}

// Namespace zombie_phobos_melee
// Params 0, eflags: 0x4
// Checksum 0xd27ecf5c, Offset: 0x10c6
// Size: 0x26
function private on_melee_start()
{
    self endon( #"death" );
    self endon( #"bmeleeended" );
    utility::ent_flag_set( "in_melee" );
}

// Namespace zombie_phobos_melee
// Params 0, eflags: 0x4
// Checksum 0x4b58e07b, Offset: 0x10f4
// Size: 0xe
function private on_melee_end()
{
    utility::ent_flag_clear( "in_melee" );
}

// Namespace zombie_phobos_melee
// Params 0, eflags: 0xc
// Checksum 0xd69129a2, Offset: 0x110a
// Size: 0x582
function private update_head()
{
    self notify( #"hash_46daafdc3a909aa4" );
    self endon( #"hash_46daafdc3a909aa4" );
    self endon( #"bmeleeended" );
    xanim = undefined;
    
    do
    {
        self function_536f8624346a747b( self.angles[ 1 ] );
        statename = self asmgetcurrentstate( self.asmname );
        
        if ( issubstr( statename, "melee" ) )
        {
            animid = asm::asm_getanim( self.asmname, statename );
            xanim = asm::asm_getxanim( statename, animid );
        }
        
        waitframe();
    }
    while ( !isdefined( xanim ) || !animhasnotetrack( xanim, "hit" ) );
    
    if ( namespace_2823e49aa0908abb::function_e0f08ce5957fca9f() )
    {
        return;
    }
    
    anim_length = getanimlength( xanim ) * 1000;
    end_time = gettime() + anim_length / asm::function_27be172b46a89235();
    self.head_pitch = 0;
    self.head_yaw = 0;
    start_melee_time = gettime();
    hit_times = getnotetracktimes( xanim, "hit" );
    hit_time = hit_times[ 0 ] * anim_length / asm::function_27be172b46a89235() + gettime();
    hit_time += getdvarfloat( @"hash_7aeeb1807a9939ed", 700 );
    restore_head_rotation_times = getnotetracktimes( xanim, "restore_head_rotation" );
    end_time = restore_head_rotation_times[ 0 ] * anim_length / asm::function_27be172b46a89235() + gettime() + getdvarfloat( @"hash_f3944568b158dc9c", 0 );
    
    while ( gettime() < hit_time )
    {
        var_446541454a40caf9 = clamp( math::remap( gettime(), start_melee_time, hit_time, 0, 1 ), 0, 1 );
        target_pos = isent( self.var_3eaa5cd097e43179 ) ? self.var_3eaa5cd097e43179.origin : self.enemy.origin;
        
        if ( !isdefined( target_pos ) )
        {
            waitframe();
            continue;
        }
        
        var_ee6433c31961982d = target_pos - self.origin;
        target_dist_right = vectordot( anglestoright( self.angles ), var_ee6433c31961982d );
        target_dist_foward = vectordot( anglestoforward( self.angles ), var_ee6433c31961982d );
        forward_norm = clamp( math::remap( target_dist_foward, getdvarfloat( @"hash_a86f08c12e937754", 100 ), getdvarfloat( @"hash_8660898e88ee7637", 400 ), 0, 1 ), 0, 1 );
        right_norm = clamp( math::remap( target_dist_right, getdvarfloat( @"hash_2a324c7c04609a7a", 100 ) * -1, getdvarfloat( @"hash_2a324c7c04609a7a", 100 ), -1, 1 ), -1, 1 );
        var_4824bad95495b903 = math::remap( forward_norm, 0, 1, 10, 0 );
        var_3e0ca513fb0e4b82 = math::remap( right_norm, -1, 1, -45, 45 ) * -1;
        var_3e0ca513fb0e4b82 = angleclamp180( var_3e0ca513fb0e4b82 + self.angles[ 1 ] );
        self.head_pitch = easing::ease_sine( 0, var_4824bad95495b903, var_446541454a40caf9, 1 );
        var_784af90734f04305 = easepower( var_446541454a40caf9, 1.5, 0, 1 );
        var_55b17f1c10269247 = anglelerpquatfrac( ( 0, self.angles[ 1 ], 0 ), ( 0, var_3e0ca513fb0e4b82, 0 ), var_784af90734f04305 );
        self.head_yaw = angleclamp180( var_55b17f1c10269247[ 1 ] );
        self function_536f8624346a747b( self.head_yaw );
        self function_51d4a57cf1dde916( self.head_pitch );
        
        /#
            if ( debug_melee() )
            {
                col = ( 1, 0.2, 0 );
                line( self.origin, target_pos, col, 1, 1 );
                print3d( vectorlerp( self.origin, target_pos, 0.5 ), "<dev string:x97>" + forward_norm + "<dev string:xa1>" + right_norm + "<dev string:xae>" + self.head_yaw, col, 1 );
                print3d( vectorlerp( self.origin, target_pos, 0.5 ) + ( 0, 0, 60 ), "<dev string:xbc>" + var_3e0ca513fb0e4b82 + "<dev string:xc8>" + var_446541454a40caf9, col, 1 );
            }
        #/
        
        waitframe();
    }
    
    if ( isdefined( var_4824bad95495b903 ) )
    {
        self function_51d4a57cf1dde916( var_4824bad95495b903 );
    }
    
    self waittill( #"hit_end" );
    hit_head_pitch = self.head_pitch;
    hit_head_yaw = self.head_yaw;
    
    while ( gettime() < end_time )
    {
        var_a8834eb007faa5ce = clamp( math::remap( gettime(), hit_time, end_time, 0, 1 ), 0, 1 );
        self.head_pitch = easing::ease_sine( hit_head_pitch, 0, var_a8834eb007faa5ce, 0, 1 );
        var_784af90734f04305 = easepower( var_446541454a40caf9, 1.5, 1, 0 );
        var_55b17f1c10269247 = anglelerpquatfrac( ( 0, hit_head_yaw, 0 ), ( 0, self.angles[ 1 ], 0 ), var_784af90734f04305 );
        self.head_yaw = angleclamp180( var_55b17f1c10269247[ 1 ] );
        self function_536f8624346a747b( self.head_yaw );
        self function_51d4a57cf1dde916( self.head_pitch );
        
        /#
            if ( debug_melee() )
            {
                col = ( 0.5, 0.4, 0 );
                print3d( vectorlerp( self.origin, target_pos ?? self.origin, 0.5 ), "<dev string:xd0>" + hit_head_pitch + "<dev string:xe1>" + hit_head_yaw + "<dev string:xc8>" + var_a8834eb007faa5ce, col, 1 );
            }
        #/
        
        waitframe();
    }
}

/#

    // Namespace zombie_phobos_melee
    // Params 0, eflags: 0x4
    // Checksum 0xb1bd537d, Offset: 0x1694
    // Size: 0x5a, Type: dev
    function private function_91ca21c79b1e67fb()
    {
        devgui::function_9082edeb5db93280( "<dev string:xf5>" );
        devgui::add_devgui_func( "<dev string:x10d>", "<dev string:x119>", &force_melee );
        devgui::add_devgui_func( "<dev string:x12c>", "<dev string:x140>", &function_27ad9366310434f5 );
        devgui::add_devgui_func( "<dev string:x15b>", "<dev string:x167>", &toggle_melee_debug );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_phobos_melee
    // Params 1, eflags: 0x4
    // Checksum 0x8992bfcb, Offset: 0x16f6
    // Size: 0x4f, Type: dev
    function private force_melee( params )
    {
        phobos = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x181>" );
        
        if ( isdefined( phobos ) )
        {
            phobos notify( #"hash_9f6d1fd5ff565730" );
        }
    }

    // Namespace zombie_phobos_melee
    // Params 1, eflags: 0x4
    // Checksum 0xe7a02968, Offset: 0x174d
    // Size: 0x62, Type: dev
    function private function_27ad9366310434f5( params )
    {
        phobos = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x181>" );
        
        if ( isdefined( phobos ) )
        {
            phobos function_68f2f6fd8a4ffcae( 0, 0 );
            waitframe();
            phobos function_68f2f6fd8a4ffcae( 0, 1 );
            wait 5;
            phobos function_68f2f6fd8a4ffcae( 0, 0 );
        }
    }

    // Namespace zombie_phobos_melee
    // Params 1, eflags: 0x4
    // Checksum 0x7ff1c8c4, Offset: 0x17b7
    // Size: 0x24, Type: dev
    function private toggle_melee_debug( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x18f>", @"hash_580d9102a16ab90a" );
    }

    // Namespace zombie_phobos_melee
    // Params 0, eflags: 0x4
    // Checksum 0x8d9a3cc2, Offset: 0x17e3
    // Size: 0x16, Type: dev
    function private debug_melee()
    {
        return getdvarint( @"hash_580d9102a16ab90a", 0 ) > 0;
    }

#/
