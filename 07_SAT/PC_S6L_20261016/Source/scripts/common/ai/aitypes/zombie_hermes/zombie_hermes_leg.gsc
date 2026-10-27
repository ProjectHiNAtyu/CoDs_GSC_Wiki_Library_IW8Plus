// scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_leg.gsc  (hash_34e282c8975f89d3.gscc) (size: 6902 Bytes / 0x1af6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc47decc5 (3296586949)
// size ...... 6902 (0x1af6)
// includes .. 4   (offset: 0x1a7e)
// strings ... 0   (offset: 0x1a9e)
// dev strs .. 7   (offset: 0x1a9e)
// exports ... 17  (offset: 0x1212)
// cseg ...... 0x58 + 0x11ba (0x1212)
// imports ... 47  (offset: 0x14ba)
// animtree1 . 0   (offset: 0x1af6)
// animtree2 . 0   (offset: 0x1af6)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\utility;

#namespace zombie_hermes_leg;

// Namespace zombie_hermes_leg
// Params 0
// Checksum 0xed6fbf19, Offset: 0x76
// Size: 0x21f
function init_zombie_hermes_leg()
{
    if ( getdvarint( @"hash_cd11081ca06dcc8f", 0 ) <= 0 )
    {
        return;
    }
    
    legxmodel = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.legmodel;
    leg_length = getdvarfloat( @"hash_7dc3fa1f9b118820", 600 );
    self.leg_lengths = [ leg_length, leg_length, leg_length ];
    self.var_186a7d5f1221620f = [ 50, 90, 180 ];
    self.var_9fb8ab00758753b3 = [];
    self.var_c75bce65ff240bf5 = [];
    self.var_bc6c9b9cb55f949 = 0;
    self.var_33cb2653fd21d125 = 0;
    leg_i = 0;
    
    while ( leg_i < 4 )
    {
        self.leg_state[ leg_i ] = 2;
        self.var_c75bce65ff240bf5[ leg_i ] = self.origin;
        self.var_52137224dddc4f68[ leg_i ] = 0;
        self.var_4d6f6f298abe5889[ leg_i ] = self.origin;
        self.var_a296d6682834e215[ leg_i ] = self.origin;
        self.var_9fb8ab00758753b3[ leg_i ] = [];
        var_882bcfaba3f2a4a0 = 0;
        
        while ( var_882bcfaba3f2a4a0 < 3 )
        {
            self.var_9fb8ab00758753b3[ leg_i ][ var_882bcfaba3f2a4a0 ] = utility::spawn_model( legxmodel, self.origin, self.angles );
            self.var_9fb8ab00758753b3[ leg_i ][ var_882bcfaba3f2a4a0 ].length = self.leg_lengths[ var_882bcfaba3f2a4a0 ];
            self.var_9fb8ab00758753b3[ leg_i ][ var_882bcfaba3f2a4a0 ].local_angles = ( 0, 0, 0 );
            self.var_9fb8ab00758753b3[ leg_i ][ var_882bcfaba3f2a4a0 ].planted_location = ( 0, 0, 0 );
            self.var_9fb8ab00758753b3[ leg_i ][ var_882bcfaba3f2a4a0 ] notsolid();
            var_882bcfaba3f2a4a0 += 1;
        }
        
        leg_i += 1;
    }
    
    thread update_legs( self );
    
    /#
        function_5f5a8579a978dc9d();
    #/
}

// Namespace zombie_hermes_leg
// Params 1, eflags: 0x4
// Checksum 0xd2f6d25f, Offset: 0x29d
// Size: 0x15a
function private update_legs( hermes )
{
    hermes endon( #"death" );
    
    while ( true )
    {
        function_60c6c9df7a14620b( hermes );
        leg_i = 0;
        
        while ( leg_i < 4 )
        {
            hermes.var_9fb8ab00758753b3[ leg_i ][ 0 ].origin = function_f28a9e9920944f82( hermes, leg_i );
            hermes.var_c75bce65ff240bf5[ leg_i ] = function_9152186a92b9c31f( hermes, leg_i );
            
            for ( var_882bcfaba3f2a4a0 = 2; var_882bcfaba3f2a4a0 >= 0 ; var_882bcfaba3f2a4a0-- )
            {
                hermes.var_9fb8ab00758753b3[ leg_i ][ var_882bcfaba3f2a4a0 ].local_angles = ( 0, 0, 0 );
            }
            
            hermes.var_9fb8ab00758753b3[ leg_i ][ 0 ].angles = ( 0, 0, 0 );
            function_c0137b9497ae619c( hermes, hermes.var_9fb8ab00758753b3[ leg_i ], 0 );
            leg_i += 1;
        }
        
        leg_i = 0;
        
        while ( leg_i < 4 )
        {
            function_198f659958845007( hermes, hermes.var_9fb8ab00758753b3[ leg_i ], hermes.var_c75bce65ff240bf5[ leg_i ], leg_i );
            function_c0137b9497ae619c( hermes, hermes.var_9fb8ab00758753b3[ leg_i ], 0 );
            leg_i += 1;
        }
        
        waitframe();
    }
}

// Namespace zombie_hermes_leg
// Params 4, eflags: 0x4
// Checksum 0x9650d137, Offset: 0x3ff
// Size: 0x37a
function private function_198f659958845007( hermes, leg_ent_array, target_pos, leg_index )
{
    max_iterations = getdvarint( @"hash_90bc43bfebbabd0e", 2 );
    var_4cfd95e927697102 = getdvarint( @"hash_1a9ae6a6e31d1ea0", 0 );
    hermes_forward = anglestoforward( hermes.angles );
    joint_pos = leg_ent_array[ 0 ].origin;
    to_target_pos = vectornormalize( target_pos - joint_pos );
    to_target_pos = target_pos - joint_pos;
    var_1f6394c55da15efc = utility::flatten_vector( to_target_pos );
    pole_vector = vectornormalize( vectorcross( var_1f6394c55da15efc, ( 0, 0, 1 ) ) );
    iter = 0;
    
    while ( iter < max_iterations )
    {
        for ( leg_i = 2; leg_i >= var_4cfd95e927697102 ; leg_i-- )
        {
            end_pos = function_a2c022a2d21f6e1b( hermes, leg_ent_array[ 2 ] );
            joint_pos = leg_ent_array[ leg_i ].origin;
            to_end_pos = end_pos - joint_pos;
            to_target_pos = target_pos - joint_pos;
            to_end_pos = vectornormalize( to_end_pos );
            to_target_pos = vectornormalize( to_target_pos );
            axis = vectorcross( to_end_pos, to_target_pos );
            parent_angles = leg_i > 0 ? leg_ent_array[ leg_i - 1 ].angles : leg_ent_array[ 0 ].angles;
            var_f6a9e15819e1abca = function_cff07be0058cd021( to_target_pos, leg_ent_array[ leg_i ].angles, pole_vector, parent_angles, 1 );
            var_ecf56319c44b70d1 = function_cff07be0058cd021( to_end_pos, leg_ent_array[ leg_i ].angles, pole_vector, parent_angles, 1 );
            var_40d3d3d9181ac1e = combineanglesinverted( var_ecf56319c44b70d1, var_f6a9e15819e1abca );
            local_angles = var_40d3d3d9181ac1e;
            limit = getdvarfloat( @"hash_26110e939443470b", 110 );
            clamped_z = 0;
            target_angle = angleclamp180( leg_ent_array[ leg_i ].local_angles[ 2 ] + local_angles[ 2 ] );
            new_angle = undefined;
            clamp = [ limit * -1, limit ];
            backwards_limit = leg_i == 0 ? 30 : 0;
            
            if ( leg_index == 0 || 2 )
            {
                clamp = [ backwards_limit * -1, limit ];
            }
            else
            {
                clamp = [ limit * -1, backwards_limit ];
            }
            
            if ( target_angle > clamp[ 0 ] && target_angle < clamp[ 1 ] )
            {
                new_angle = target_angle;
            }
            else
            {
                new_angle = clamp( target_angle, clamp[ 0 ], clamp[ 1 ] );
            }
            
            clamped_angles = ( local_angles[ 0 ], var_ecf56319c44b70d1[ 1 ] + local_angles[ 1 ], new_angle );
            leg_ent_array[ leg_i ].local_angles = clamped_angles;
            leg_ent_array[ leg_i ].angles = parent_angles + clamped_angles;
            function_c0137b9497ae619c( hermes, leg_ent_array, leg_i );
        }
        
        iter += 1;
    }
    
    /#
        if ( debug_legs() )
        {
            line( joint_pos, joint_pos + pole_vector * 100, ( 0, 1, 0 ) );
            print3d( joint_pos, "<dev string:x24>" + pole_vector[ 0 ] + "<dev string:x2f>" + pole_vector[ 1 ] + "<dev string:x2f>" + pole_vector[ 2 ] );
        }
    #/
}

// Namespace zombie_hermes_leg
// Params 3, eflags: 0x4
// Checksum 0xdf487e2e, Offset: 0x781
// Size: 0xdb
function private function_c0137b9497ae619c( hermes, leg_ent_array, var_aab6e240fcc7e5ef )
{
    iter = var_aab6e240fcc7e5ef + 1;
    
    while ( iter < 3 )
    {
        parent_angles = leg_ent_array[ iter - 1 ].angles;
        new_pos = function_a2c022a2d21f6e1b( hermes, leg_ent_array[ iter - 1 ] );
        leg_ent_array[ iter ].origin = new_pos;
        var_bc17867937da92dc = leg_ent_array[ iter ].angles;
        leg_ent_array[ iter ].angles = ( parent_angles[ 0 ] + leg_ent_array[ iter ].local_angles[ 0 ], parent_angles[ 1 ], parent_angles[ 2 ] + leg_ent_array[ iter ].local_angles[ 2 ] );
        iter += 1;
    }
}

// Namespace zombie_hermes_leg
// Params 5, eflags: 0x4
// Checksum 0xda596cd0, Offset: 0x864
// Size: 0xae
function private function_cff07be0058cd021( to_vec, global_angles, forward_vec, parent_angles, should_flatten )
{
    if ( should_flatten )
    {
        var_e573c337fd79453e = math::vector_project_onto_plane( to_vec, forward_vec );
    }
    
    new_forward = var_e573c337fd79453e ?? to_vec;
    new_up = vectorcross( new_forward, forward_vec );
    new_right = vectorcross( new_forward, new_up );
    var_bc17867937da92dc = global_angles;
    new_angles = axistoangles( new_right, new_up, new_forward );
    local_angles = combineanglesinverted( parent_angles, new_angles );
    return local_angles;
}

// Namespace zombie_hermes_leg
// Params 4, eflags: 0x4
// Checksum 0x26dc51b7, Offset: 0x91b
// Size: 0x72
function private function_c8f68d949d7c86bb( joint_pos, target_pos, pole_vector, computed_axis )
{
    pole_target = joint_pos + pole_vector;
    var_916c9ff18ad752d7 = vectornormalize( pole_target - joint_pos );
    vec_to_target = vectornormalize( target_pos - joint_pos );
    desired_axis = vectornormalize( vectorcross( vec_to_target, var_916c9ff18ad752d7 ) );
    return desired_axis;
}

// Namespace zombie_hermes_leg
// Params 2, eflags: 0x4
// Checksum 0x6c1b22e6, Offset: 0x996
// Size: 0x3c
function private function_a2c022a2d21f6e1b( hermes, leg )
{
    return leg.origin + anglestoup( leg.angles ) * leg.length;
}

// Namespace zombie_hermes_leg
// Params 2, eflags: 0x4
// Checksum 0x3c27bcc3, Offset: 0x9db
// Size: 0x142
function private function_f28a9e9920944f82( hermes, leg_i )
{
    base_pos = hermes.origin + ( 0, 0, getdvarfloat( @"hash_ac80b76b68ea6daf", -40 ) );
    hermes_angles = hermes.angles;
    hip_pos = base_pos;
    var_68997cc5611b6ed9 = 300;
    right_offset = 220;
    
    switch ( leg_i )
    {
        case 0:
            hip_pos = hip_pos + anglestoright( hermes_angles ) * right_offset * -1 + anglestoforward( hermes_angles ) * var_68997cc5611b6ed9;
            break;
        case 1:
            hip_pos = hip_pos + anglestoright( hermes_angles ) * right_offset * 1 + anglestoforward( hermes_angles ) * var_68997cc5611b6ed9;
            break;
        case 2:
            hip_pos = hip_pos + anglestoright( hermes_angles ) * right_offset * -1 + anglestoforward( hermes_angles ) * var_68997cc5611b6ed9 * -1;
            break;
        case 3:
            hip_pos = hip_pos + anglestoright( hermes_angles ) * right_offset * 1 + anglestoforward( hermes_angles ) * var_68997cc5611b6ed9 * -1;
            break;
        default:
            break;
    }
    
    return hip_pos;
}

// Namespace zombie_hermes_leg
// Params 2, eflags: 0x4
// Checksum 0x502e031a, Offset: 0xb26
// Size: 0x223
function private function_9152186a92b9c31f( hermes, leg_i )
{
    base_pos = function_f28a9e9920944f82( hermes, leg_i );
    hermes_angles = hermes.angles;
    target_origin = base_pos;
    var_68997cc5611b6ed9 = 0;
    right_offset = 500;
    hermes_forward = anglestoforward( hermes_angles );
    hermes_right = anglestoright( hermes_angles );
    
    if ( hermes.leg_state[ leg_i ] == 2 )
    {
        target_origin = function_74363dee90c3d663( hermes, leg_i );
        hermes.leg_state[ leg_i ] = 0;
        hermes.var_4d6f6f298abe5889[ leg_i ] = target_origin;
        return target_origin;
    }
    
    planted_pos = hermes.var_4d6f6f298abe5889[ leg_i ];
    distance_from_body = distance( base_pos, planted_pos );
    
    if ( hermes.leg_state[ leg_i ] == 0 && function_f0f4f292b155e91f( hermes, leg_i ) )
    {
        target_origin = function_74363dee90c3d663( hermes, leg_i );
        hermes.var_52137224dddc4f68[ leg_i ] = gettime();
        hermes.leg_state[ leg_i ] = 1;
        hermes.var_a296d6682834e215[ leg_i ] = target_origin;
    }
    
    if ( hermes.leg_state[ leg_i ] == 1 )
    {
        t = ( gettime() - hermes.var_52137224dddc4f68[ leg_i ] ) / 1000;
        vertical_offset = sin( t * 180 ) * 500;
        current_target = vectorlerp( planted_pos, hermes.var_a296d6682834e215[ leg_i ], t );
        current_target = ( current_target[ 0 ], current_target[ 1 ], current_target[ 2 ] + vertical_offset );
        target_origin = current_target;
        
        if ( t >= 1 )
        {
            hermes.leg_state[ leg_i ] = 0;
            hermes.var_4d6f6f298abe5889[ leg_i ] = hermes.var_a296d6682834e215[ leg_i ];
        }
    }
    else if ( hermes.leg_state[ leg_i ] == 0 )
    {
        target_origin = planted_pos;
    }
    
    return target_origin;
}

// Namespace zombie_hermes_leg
// Params 2, eflags: 0x4
// Checksum 0x87ebe44a, Offset: 0xd52
// Size: 0x110
function private function_74363dee90c3d663( hermes, leg_i )
{
    base_pos = function_f28a9e9920944f82( hermes, leg_i );
    hermes_angles = hermes.angles;
    target_origin = base_pos;
    var_68997cc5611b6ed9 = 0;
    right_offset = 600;
    hermes_forward = anglestoforward( hermes_angles );
    hermes_right = anglestoright( hermes_angles );
    
    switch ( leg_i )
    {
        case 0:
        case 2:
            target_origin += anglestoright( hermes_angles ) * right_offset * -1;
            break;
        case 1:
        case 3:
            target_origin += anglestoright( hermes_angles ) * right_offset * 1;
            break;
        default:
            break;
    }
    
    target_origin += hermes_forward * 300;
    target_origin = getgroundposition( target_origin, 5, 500, 2500 );
    return target_origin;
}

// Namespace zombie_hermes_leg
// Params 1, eflags: 0x4
// Checksum 0x6ec5dac, Offset: 0xe6b
// Size: 0x164
function private function_60c6c9df7a14620b( hermes )
{
    if ( !hermes.var_33cb2653fd21d125 )
    {
        if ( hermes.var_bc6c9b9cb55f949 == 0 )
        {
            if ( hermes.leg_state[ 0 ] == 1 || hermes.leg_state[ 3 ] == 1 )
            {
                hermes.var_33cb2653fd21d125 = 1;
            }
        }
        else if ( hermes.var_bc6c9b9cb55f949 == 1 )
        {
            if ( hermes.leg_state[ 1 ] == 1 || hermes.leg_state[ 2 ] == 1 )
            {
                hermes.var_33cb2653fd21d125 = 1;
            }
        }
    }
    
    if ( hermes.var_33cb2653fd21d125 )
    {
        if ( hermes.var_bc6c9b9cb55f949 == 0 )
        {
            if ( hermes.leg_state[ 0 ] != 1 && hermes.leg_state[ 3 ] != 1 )
            {
                hermes.var_33cb2653fd21d125 = 0;
                hermes.var_bc6c9b9cb55f949 = 1;
            }
            
            return;
        }
        
        if ( hermes.var_bc6c9b9cb55f949 == 1 )
        {
            if ( hermes.leg_state[ 1 ] != 1 && hermes.leg_state[ 2 ] != 1 )
            {
                hermes.var_33cb2653fd21d125 = 0;
                hermes.var_bc6c9b9cb55f949 = 0;
            }
        }
    }
}

// Namespace zombie_hermes_leg
// Params 2, eflags: 0x4
// Checksum 0x18fdf991, Offset: 0xfd7
// Size: 0x6b, Type: bool
function private function_f0f4f292b155e91f( hermes, leg_i )
{
    if ( hermes.var_bc6c9b9cb55f949 == 0 )
    {
        if ( arraycontains( [ 0, 3 ], leg_i ) )
        {
            return true;
        }
    }
    else if ( hermes.var_bc6c9b9cb55f949 == 1 )
    {
        if ( arraycontains( [ 1, 2 ], leg_i ) )
        {
            return true;
        }
    }
    
    return false;
}

/#

    // Namespace zombie_hermes_leg
    // Params 0, eflags: 0x4
    // Checksum 0x62d6e455, Offset: 0x104b
    // Size: 0x41, Type: dev
    function private function_5f5a8579a978dc9d()
    {
        devgui::function_9082edeb5db93280( "<dev string:x31>" );
        devgui::add_devgui_func( "<dev string:x49>", "<dev string:x54>", &function_ce2752785cd41119, 1 );
        devgui::function_77df7fe7dd273e10();
        
        if ( debug_legs() )
        {
            level thread function_a0aaab29d81f9132();
        }
    }

    // Namespace zombie_hermes_leg
    // Params 1, eflags: 0x4
    // Checksum 0xc49d482d, Offset: 0x1094
    // Size: 0x44, Type: dev
    function private function_ce2752785cd41119( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x66>", @"hash_b107a4dce689f83b" );
        
        if ( debug_legs() )
        {
            level thread function_a0aaab29d81f9132();
            return;
        }
        
        level notify( #"hash_ebca4e5a99e969b" );
    }

    // Namespace zombie_hermes_leg
    // Params 0, eflags: 0x4
    // Checksum 0x4b1c7781, Offset: 0x10e0
    // Size: 0x16, Type: dev
    function private debug_legs()
    {
        return getdvarint( @"hash_b107a4dce689f83b", 0 ) > 0;
    }

    // Namespace zombie_hermes_leg
    // Params 0, eflags: 0x4
    // Checksum 0xe2d99f97, Offset: 0x10fe
    // Size: 0x114, Type: dev
    function private function_a0aaab29d81f9132()
    {
        level endon( #"hash_ebca4e5a99e969b" );
        
        while ( true )
        {
            hermes = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x77>" );
            
            if ( !isdefined( hermes ) )
            {
                waitframe();
                continue;
            }
            
            foreach ( target_pos in hermes.var_c75bce65ff240bf5 )
            {
                sphere( target_pos, 15, ( 1, 0, 0 ), 1 );
            }
            
            leg_i = 0;
            
            while ( leg_i < 4 )
            {
                sphere( function_f28a9e9920944f82( hermes, leg_i ), 10, ( 0, 1, 0.2 ) );
                leg_i += 1;
            }
            
            waitframe();
        }
    }

#/
