// script_18a87900fcfe1bc  (hash_018a87900fcfe1bc.gscc) (size: 13149 Bytes / 0x335d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc0b9641e (3233375262)
// size ...... 13149 (0x335d)
// includes .. 16  (offset: 0x2f41)
// strings ... 48  (offset: 0x2fc1)
// dev strs .. 13  (offset: 0x32bd)
// exports ... 23  (offset: 0x1c99)
// cseg ...... 0x37f + 0x191a (0x1c99)
// imports ... 126 (offset: 0x2031)
// animtree1 . 0   (offset: 0x335d)
// animtree2 . 0   (offset: 0x335d)
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_traverse;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_amalgam\zombie_amalgam_parts;
#using scripts\common\ai\aitypes\zombie_amalgam\zombie_amalgam_regeneration;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\metabone;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_amalgam_grab;

// Namespace zombie_amalgam_grab
// Params 1
// Checksum 0xd1701a1, Offset: 0x39d
// Size: 0x75
function function_813e8d5ae56f2a4b( aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( settings ) )
    {
        utility::add_fx( "player_grabbed_by_amalgam_fx", settings.var_c1e92924d2bff919 );
        utility::add_fx( "player_short_grabbed_by_amalgam_fx", settings.var_461d24676ef49ce1 );
        utility::add_fx( "player_grab_bite_amalgam_fx", settings.var_3b867a987c3e4097 );
    }
    
    /#
        init_amalgam_grab_devgui();
    #/
}

// Namespace zombie_amalgam_grab
// Params 0
// Checksum 0x7aac8f7f, Offset: 0x41a
// Size: 0xe
function function_acf2298db14eb020()
{
    asm::function_7256f5ba459c840b( "grab_in" );
}

// Namespace zombie_amalgam_grab
// Params 4
// Checksum 0xdb28214e, Offset: 0x430
// Size: 0x65, Type: bool
function function_41ea93b128c2a36a( asmname, statename, tostatename, grab_type )
{
    if ( !self )
    {
        return false;
    }
    
    if ( !namespace_ef593377fdc8b4e0::has_grab_arm() || effect_slow::function_6fab6266b5f636c3() || function_dc52e01d0fda9293( asmname, statename, tostatename, grab_type ) )
    {
        return false;
    }
    
    function_e0faae367f558324( asmname, statename, tostatename, grab_type, 1 );
    return true;
}

// Namespace zombie_amalgam_grab
// Params 5
// Checksum 0x18e38f7, Offset: 0x49e
// Size: 0x2c0, Type: bool
function function_e0faae367f558324( asmname, statename, tostatename, grab_type, var_32ff12965de58db2 )
{
    if ( !var_32ff12965de58db2 && function_dc52e01d0fda9293( asmname, statename, tostatename, grab_type ) )
    {
        return false;
    }
    
    if ( isdefined( self.var_8cb3c9f5176399ed ) )
    {
        return true;
    }
    
    if ( namespace_ef593377fdc8b4e0::has_grab_arm() )
    {
        ai_settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
        var_b7767ddc4831bdce = self gettagorigin( "tag_player" );
        var_15455bbb16c7de47 = var_b7767ddc4831bdce - self.origin;
        grab_dist = length2d( var_15455bbb16c7de47 ) + 30;
        
        if ( var_32ff12965de58db2 && function_af2f4170c8a8cf2( self.var_f683e0b4d38e6176 ) )
        {
            target = self.var_f683e0b4d38e6176;
        }
        
        /#
            if ( getdvarint( @"hash_1bebd89199db7cc3", 0 ) && isdefined( target ) )
            {
                var_c13eb6c1440c8d74 = var_b7767ddc4831bdce - self.grab_loc_start;
                var_e1ba59334e283f90 = length2d( var_c13eb6c1440c8d74 );
                var_23946e2da7ed974b = length2d( var_15455bbb16c7de47 );
                var_80447287e693b568 = var_23946e2da7ed974b + 30;
                var_ee6433c31961982d = target.origin - self.origin;
                to_target_dist = length2d( var_ee6433c31961982d );
                grab_right = vectornormalize( vectorcross( var_15455bbb16c7de47, ( 0, 0, 1 ) ) );
                lateral_dist = abs( vectordot( grab_right, var_ee6433c31961982d ) );
                grab_attack_type = self getaiblackboarddynamic( "<dev string:x24>" );
                print3d( self.origin + ( 0, 0, 30 ), grab_attack_type + "<dev string:x35>" + var_e1ba59334e283f90 + "<dev string:x38>" + var_23946e2da7ed974b + "<dev string:x3a>" + to_target_dist + "<dev string:x38>" + lateral_dist, ( 1, 1, 1 ), 1, 0.5, 100, 1 );
            }
        #/
        
        if ( function_7e98ab4887c467b5( target, var_15455bbb16c7de47, grab_dist ) )
        {
            thread function_fcde6263fa4495a4( target, var_b7767ddc4831bdce, grab_type );
            return true;
        }
        
        if ( !var_32ff12965de58db2 )
        {
            if ( !zombie_utils::function_bf1464d09f4e4b40() )
            {
                target = utility::get_closest_filtered( var_b7767ddc4831bdce, level.players, ai_settings.var_db5f0e09f2fcbdf5, &function_af2f4170c8a8cf2 );
            }
            
            if ( function_7e98ab4887c467b5( target, var_15455bbb16c7de47, grab_dist ) )
            {
                thread function_fcde6263fa4495a4( target, var_b7767ddc4831bdce, grab_type );
                return true;
            }
            
            target = zombie_utils::get_closest_zombie( var_b7767ddc4831bdce, undefined, "zombie_base", ai_settings.var_db5f0e09f2fcbdf5, &function_af2f4170c8a8cf2 );
            
            if ( function_7e98ab4887c467b5( target, var_15455bbb16c7de47, grab_dist ) )
            {
                thread function_fcde6263fa4495a4( target, var_b7767ddc4831bdce, grab_type );
                return true;
            }
        }
    }
    
    return false;
}

// Namespace zombie_amalgam_grab
// Params 3, eflags: 0x4
// Checksum 0x21c5d937, Offset: 0x767
// Size: 0xae, Type: bool
function private function_7e98ab4887c467b5( target, var_15455bbb16c7de47, grab_dist )
{
    if ( isdefined( target ) )
    {
        var_ee6433c31961982d = target.origin - self.origin;
        
        if ( vectordot( var_15455bbb16c7de47, var_ee6433c31961982d ) > 0 && lengthsquared( var_ee6433c31961982d ) < squared( grab_dist ) )
        {
            grab_right = vectornormalize( vectorcross( var_15455bbb16c7de47, ( 0, 0, 1 ) ) );
            return ( abs( vectordot( grab_right, var_ee6433c31961982d ) ) <= self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_852b544862ec86ca );
        }
    }
    
    return false;
}

// Namespace zombie_amalgam_grab
// Params 4
// Checksum 0x1446bdfe, Offset: 0x81e
// Size: 0x279, Type: bool
function function_48acb5fdb6665020( asmname, statename, tostatename, grab_type )
{
    if ( !isdefined( self.enemy ) )
    {
        return false;
    }
    
    curr_time = gettime();
    
    if ( self.var_3abb5f52e3ee492a === curr_time )
    {
        return ( self.var_25d2eb5391587f4b == grab_type );
    }
    
    self.var_3abb5f52e3ee492a = curr_time;
    max_dist = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_db5f0e09f2fcbdf5;
    mid_dist = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_9c107d76e655bcef;
    close_dist = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_d41acb5777365049;
    clear_dist = function_e5b9d5865e560107( max_dist );
    
    if ( isdefined( self.grab_loc_start ) )
    {
        dist_traveled = distance( self.grab_loc_start, self.origin );
        clear_dist += dist_traveled;
    }
    
    var_dae30199e5c40196 = self.origin - self.enemy.origin;
    dist_sqr = lengthsquared( var_dae30199e5c40196 );
    predicted_dist_sqr = dist_sqr;
    var_df9adb69b75ff5f3 = self.enemy getvelocity();
    
    if ( vectordot( var_df9adb69b75ff5f3, var_dae30199e5c40196 ) < 0 )
    {
        predicted_target_loc = self.enemy.origin + var_df9adb69b75ff5f3 * 0.25;
        var_a442d1a1f056424d = predicted_target_loc - self.origin;
        predicted_dist_sqr = lengthsquared( var_a442d1a1f056424d );
    }
    
    if ( predicted_dist_sqr > mid_dist && clear_dist >= max_dist )
    {
        self.var_25d2eb5391587f4b = 2;
    }
    else if ( predicted_dist_sqr > close_dist && clear_dist >= mid_dist )
    {
        self.var_25d2eb5391587f4b = 1;
    }
    else
    {
        self.var_25d2eb5391587f4b = 0;
    }
    
    /#
        if ( getdvarint( @"hash_1bebd89199db7cc3", 0 ) )
        {
            print3d( self.origin + ( 0, 0, 60 ), "<dev string:x3e>" + self.var_25d2eb5391587f4b, ( 1, 1, 1 ), 1, 0.5, 100, 1 );
        }
    #/
    
    return self.var_25d2eb5391587f4b == grab_type;
}

// Namespace zombie_amalgam_grab
// Params 4
// Checksum 0xf5287619, Offset: 0xaa0
// Size: 0x34
function function_20eb079f03c310a8( asmname, statename, tostatename, params )
{
    return isplayer( self.var_8cb3c9f5176399ed );
}

// Namespace zombie_amalgam_grab
// Params 1
// Checksum 0x52a6588a, Offset: 0xadd
// Size: 0x8e, Type: bool
function function_af2f4170c8a8cf2( target )
{
    if ( isalive( self ) && isalive( target ) )
    {
        if ( !target val::get( "allow_grab" ) )
        {
            callback::callback( "on_target_disallow_grab", { #target:target } );
            return false;
        }
        
        return ( !isdefined( target.vehicle ) && !isdefined( target getlinkedparent() ) && !target val::get( "ignoreme" ) && ( is_valid_player_target( target ) || is_valid_zombie_target( target ) ) );
    }
    
    return false;
}

// Namespace zombie_amalgam_grab
// Params 1
// Checksum 0x81e6fb10, Offset: 0xb74
// Size: 0x48, Type: bool
function is_valid_player_target( player )
{
    return isplayer( player ) && player.sessionstate == "playing" && !player.inlaststand && !killstreak_shared::isremotekillstreakweapon( player getcurrentweapon() );
}

// Namespace zombie_amalgam_grab
// Params 1
// Checksum 0xcdff9295, Offset: 0xbc5
// Size: 0x92, Type: bool
function is_valid_zombie_target( target )
{
    return isdefined( target.subclass ) && isstartstr( target.subclass, "zombie_base" ) && !target namespace_b76ff2659823e89d::is_crawling() && ( !isdefined( target.currentpose ) || target.currentpose == "stand" ) && target val::get( "death" ) && target val::get( "damage" ) && !target zombie_traverse::is_traversing();
}

// Namespace zombie_amalgam_grab
// Params 4
// Checksum 0x357a0f3c, Offset: 0xc60
// Size: 0x139
function function_dc52e01d0fda9293( asmname, statename, tostatename, grab_type )
{
    switch ( grab_type )
    {
        case 0:
            return 0;
        case 1:
            dist = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_9c107d76e655bcef;
            break;
        case 2:
        default:
            dist = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_db5f0e09f2fcbdf5;
            break;
    }
    
    if ( isdefined( self.grab_loc_start ) )
    {
        dist_traveled = distance( self.grab_loc_start, self.origin );
        dist -= dist_traveled;
    }
    
    target = self.var_8cb3c9f5176399ed ?? self.var_f683e0b4d38e6176;
    
    if ( isdefined( target ) )
    {
        dist_to_target = distance2d( self.origin, target.origin );
        dist = min( dist, dist_to_target );
    }
    
    return function_ef05604c3ba9a8ff( dist );
}

// Namespace zombie_amalgam_grab
// Params 1
// Checksum 0xa049ff41, Offset: 0xda2
// Size: 0x17, Type: bool
function function_ef05604c3ba9a8ff( grab_distance )
{
    return function_e5b9d5865e560107( grab_distance ) < grab_distance;
}

// Namespace zombie_amalgam_grab
// Params 2
// Checksum 0x28563618, Offset: 0xdc2
// Size: 0x15b
function function_e5b9d5865e560107( grab_distance, grab_direction )
{
    var_8ca1e98f17986935 = grab_distance;
    
    if ( !isdefined( grab_direction ) )
    {
        grab_direction = anglestoforward( self.angles );
    }
    
    grab_vec = grab_direction * grab_distance;
    start_pos = self.origin + ( 0, 0, 30 );
    end_pos = start_pos + grab_vec;
    contents = trace::create_contents( 0, 1, 1, 1, 0, 1, 1 );
    clear_dist = get_trace_distance( start_pos, end_pos, contents );
    var_8ca1e98f17986935 = clear_dist ?? var_8ca1e98f17986935;
    mid_point = self.origin + ( 0, 0, 50 );
    right = anglestoright( self.angles );
    start_pos = mid_point + right * 18;
    end_pos = start_pos + grab_vec;
    clear_dist = get_trace_distance( start_pos, end_pos, contents );
    
    if ( isdefined( clear_dist ) && clear_dist + 6 < grab_distance )
    {
        var_8ca1e98f17986935 = min( var_8ca1e98f17986935, clear_dist + 6 );
    }
    
    start_pos = mid_point - right * 18;
    end_pos = start_pos + grab_vec;
    clear_dist = get_trace_distance( start_pos, end_pos, contents );
    
    if ( isdefined( clear_dist ) && clear_dist + 6 < grab_distance )
    {
        var_8ca1e98f17986935 = min( var_8ca1e98f17986935, clear_dist + 6 );
    }
    
    return var_8ca1e98f17986935;
}

// Namespace zombie_amalgam_grab
// Params 3, eflags: 0x4
// Checksum 0xcdebf766, Offset: 0xf26
// Size: 0x137
function private get_trace_distance( start_pos, end_pos, contents )
{
    trace_results = trace::ray_trace( start_pos, end_pos, undefined, contents );
    b_passed = trace_results[ "hittype" ] == "hittype_none";
    
    /#
        var_2f385dafed4699c8 = getdvarint( @"hash_1bebd89199db7cc3", 0 ) || getdvarint( @"hash_7d0d25a85963bf41", 0 );
        
        if ( var_2f385dafed4699c8 )
        {
            var_d4618b70ea2e3eee = !getdvarint( @"hash_1bebd89199db7cc3", 0 ) ? 1 : 100;
            line( start_pos, end_pos, b_passed ? ( 0, 1, 0 ) : ( 1, 0, 0 ), 1, 0, var_d4618b70ea2e3eee );
            sphere( start_pos, 5, b_passed ? ( 0, 1, 0 ) : ( 1, 0, 0 ), 0, var_d4618b70ea2e3eee );
            
            if ( !b_passed )
            {
                sphere( trace_results[ "<dev string:x4a>" ], 5, ( 1, 1, 0 ), 0, var_d4618b70ea2e3eee );
            }
        }
    #/
    
    if ( !b_passed )
    {
        return distance( start_pos, trace_results[ "position" ] );
    }
}

// Namespace zombie_amalgam_grab
// Params 3, eflags: 0x4
// Checksum 0x5243c26d, Offset: 0x1065
// Size: 0x3e7
function private function_fcde6263fa4495a4( target, var_b7767ddc4831bdce, grab_type )
{
    level endon( #"game_ended" );
    namespace_22232c840a00551b::pause_health_regen();
    grab_model = utility::spawn_model( "tag_origin", var_b7767ddc4831bdce + ( 0, 0, -55 ), ( 0, angleclamp( self.angles[ 1 ] + 180 ), 0 ) );
    thread utility::delete_on_death( grab_model );
    target thread utility::delete_on_death( grab_model );
    target val::set( "ai_amalgam_grab", "allow_grab", 0 );
    target val::set( "ai_amalgam_grab", "freezecontrols", 1 );
    target val::set( "ai_amalgam_grab", "armor", 0 );
    target val::set( "ai_amalgam_grab", "killstreaks", 0 );
    target val::set( "ai_amalgam_grab", "weapon", 0 );
    target val::set( "ai_amalgam_grab", "ignoreme", 1 );
    utility::ent_flag_set( "amalgam_in_grab" );
    target utility::ent_flag_set( "ai_amalgam_grab" );
    metabone::set_metabone_active( "grab_arm", 0 );
    self.var_8cb3c9f5176399ed = target;
    self.grabbed_player_damage = 0;
    self.var_e366c5eecacfffe9 = 1;
    target_is_player = isplayer( target );
    
    if ( target_is_player )
    {
        target val::set( "ai_amalgam_grab", "allow_melee_me", 0 );
        target setstance( "stand", 1, 1 );
        
        if ( target.insertingarmorplate )
        {
            target notify( #"try_armor_cancel", "amalgam_grab" );
        }
        
        if ( self.revivingteammate )
        {
            self.var_3ded14e19d81ef7e = 1;
        }
        
        thread function_cbc9a97ec155f5b3( target, grab_model, grab_type );
        thread function_94df9ee25463a641( grab_model, target );
    }
    else
    {
        self.var_62730a584b1747d1 = self.team == "team_hundred_eighty_nine";
        target zombie_stun::stun_ai( 5 );
        thread function_95fe743ccb0bee92( target, grab_model );
    }
    
    event = utility::waittill_any_ents_return( target, "death_or_disconnect", self, "death", self, "amalgam_grab_end", self, "amalgam_grab_throw" );
    
    if ( isdefined( target ) )
    {
        if ( target islinked() && target getlinkedparent() === grab_model )
        {
            target unlink();
        }
        
        if ( target_is_player && isalive( target ) && target.sessionstate == "playing" && isdefined( self ) )
        {
            throw_dir = anglestoforward( self.angles );
            target setorigin( target.origin + ( 0, 0, 5 ) );
            
            if ( isalive( self ) )
            {
                toss_z = tan( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_66f88079876921fe );
                target knockback( ( throw_dir[ 0 ], throw_dir[ 1 ], toss_z ), self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_d130e5c15768a1b6 );
                target thread function_f8ef3671ec42ae8b( self );
                target utility::delaythread( 0.5, &val::reset_all, "ai_amalgam_grab" );
                target utility::delaythread( 0.5, &utility::ent_flag_clear, "ai_amalgam_grab" );
                var_d0e2b67a45c02785 = 1;
            }
            else
            {
                target knockback( ( throw_dir[ 0 ], throw_dir[ 1 ], 0.25 ), 100 );
            }
        }
        
        if ( !var_d0e2b67a45c02785 )
        {
            target utility::ent_flag_clear( "ai_amalgam_grab" );
            target val::reset_all( "ai_amalgam_grab" );
        }
    }
    
    if ( isdefined( self ) )
    {
        utility::function_32b24db3127bff40( "grab_audio", "mouth_loop_off" );
        self.var_8cb3c9f5176399ed = undefined;
        self.grabbed_player_damage = undefined;
        
        if ( namespace_ef593377fdc8b4e0::has_grab_arm() )
        {
            metabone::set_metabone_active( "grab_arm", 1 );
        }
        
        namespace_22232c840a00551b::function_3b5d2318de689d26();
        utility::ent_flag_clear( "amalgam_in_grab" );
    }
    
    if ( isdefined( grab_model ) )
    {
        grab_model delete();
    }
}

// Namespace zombie_amalgam_grab
// Params 2, eflags: 0x4
// Checksum 0xca54a63e, Offset: 0x1454
// Size: 0x28d
function private function_94df9ee25463a641( grab_model, player )
{
    player endon( #"death_or_disconnect" );
    self endon( #"death" );
    self endon( #"amalgam_grab_end" );
    self endon( #"amalgam_grab_throw" );
    contents = trace::create_contents( 0, 1, 1, 1, 0, 1, 1 );
    
    while ( true )
    {
        dist_to_target = distance2d( self.origin, player.origin );
        
        if ( effect_slow::function_6fab6266b5f636c3() || function_ef05604c3ba9a8ff( dist_to_target ) )
        {
            trace = player trace::player_get_closest_point_static();
            
            if ( trace[ "hittype" ] == "hittype_none" )
            {
                asm::function_7256f5ba459c840b( "grab_miss" );
                self notify( #"amalgam_grab_end" );
                return;
            }
        }
        
        var_8e49ab98af81f4b1 = self gettagorigin( "tag_player" ) + ( 0, 0, -55 );
        grab_origin = ( self.origin[ 0 ], self.origin[ 1 ], var_8e49ab98af81f4b1[ 2 ] );
        grab_direction = anglestoforward( self.angles );
        var_4e4f0250b1750f9c = var_8e49ab98af81f4b1 - grab_origin;
        grab_dist = vectordot( var_4e4f0250b1750f9c, grab_direction );
        
        if ( grab_dist > dist_to_target )
        {
            capsule = player getcollision( "stand" );
            halfheight = capsule.capsule_halfheight + capsule.capsule_radius;
            trace_height = capsule.capsule_midpoint_height - halfheight;
            trace_offset = ( 0, 0, trace_height );
            trace_start = player.origin + trace_offset;
            trace_end = var_8e49ab98af81f4b1 + trace_offset;
            trace = trace::capsule_trace( trace_start, trace_end, capsule.capsule_radius, halfheight * 2, ( 0, 0, 0 ), player, contents );
            
            if ( trace[ "hittype" ] != "hittype_none" )
            {
                var_9fd9faa702a37cf9 = distance2d( self.origin, trace[ "shape_position" ] );
                grab_dist = max( dist_to_target, var_9fd9faa702a37cf9 - 6 );
            }
        }
        
        var_317641fa5111f8f7 = grab_origin + grab_direction * grab_dist;
        grab_model.origin = var_317641fa5111f8f7;
        grab_model.angles = ( 0, angleclamp( self.angles[ 1 ] + 180 ), 0 );
        waitframe();
    }
}

// Namespace zombie_amalgam_grab
// Params 1, eflags: 0x4
// Checksum 0x457b4d8d, Offset: 0x16e9
// Size: 0xf0
function private function_f8ef3671ec42ae8b( var_5c51666f49f49cb4 )
{
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        wait 0.1;
        a_zombies = getaiarrayinradius( self.origin, 64 );
        
        foreach ( zombie in a_zombies )
        {
            if ( isalive( zombie ) && zombie.aicategory == "normal" && !zombie zombie_knockdown::function_19d6107cb6bdff5c() )
            {
                zombie zombie_knockdown::function_6fc167d4a3590991( self.origin );
            }
        }
        
        if ( self isonground() )
        {
            break;
        }
    }
}

// Namespace zombie_amalgam_grab
// Params 3, eflags: 0x4
// Checksum 0xaf80db18, Offset: 0x17e1
// Size: 0x322
function private function_cbc9a97ec155f5b3( var_44cf1dcd0ee0d919, grab_model, grab_type )
{
    var_44cf1dcd0ee0d919 endon( #"death" );
    
    if ( !isdefined( self.var_3230a3474933ee8 ) )
    {
        self.var_3230a3474933ee8 = 0;
    }
    
    self.var_3230a3474933ee8++;
    var_44cf1dcd0ee0d919 playerlinktoblend( grab_model, "tag_origin", 0.3, 0.1, 0.05 );
    event = utility::waittill_any_timeout_no_endon_death( 0, "death", "amalgam_grab_end" );
    
    if ( !( event == "timeout" ) )
    {
        return;
    }
    
    if ( isalive( var_44cf1dcd0ee0d919 ) )
    {
        if ( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_7fcf76ca5f990199 ) && isnullweapon( var_44cf1dcd0ee0d919 gethighpriorityweapon() ) )
        {
            var_44cf1dcd0ee0d919 playviewmodelanim( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_7fcf76ca5f990199.id, 1 );
        }
        
        if ( !var_44cf1dcd0ee0d919 getcamerathirdperson() )
        {
            if ( grab_type === 0 )
            {
                playfxontagforclients( utility::getfx( "player_short_grabbed_by_amalgam_fx" ), var_44cf1dcd0ee0d919, "j_head", var_44cf1dcd0ee0d919 );
            }
            else
            {
                playfxontagforclients( utility::getfx( "player_grabbed_by_amalgam_fx" ), var_44cf1dcd0ee0d919, "j_head", var_44cf1dcd0ee0d919 );
            }
        }
        
        if ( grab_type === 0 )
        {
            var_44cf1dcd0ee0d919 playanimscriptsceneevent( "scripted_scene", "t10_mp_zm_amal_grab_01_hit_short" );
        }
        else
        {
            var_44cf1dcd0ee0d919 playanimscriptsceneevent( "scripted_scene", "t10_mp_zm_amal_grab_01_hit" );
        }
    }
    
    event = utility::waittill_any_return( "death", "amalgam_grab_end", "amalgam_grab_bite" );
    
    if ( !( event == "amalgam_grab_bite" ) || !isalive( self ) )
    {
        if ( isdefined( var_44cf1dcd0ee0d919 ) )
        {
            stopfxontagforclients( utility::getfx( "player_grabbed_by_amalgam_fx" ), var_44cf1dcd0ee0d919, "j_head", var_44cf1dcd0ee0d919 );
            var_44cf1dcd0ee0d919 stopanimscriptsceneevent();
            
            if ( var_44cf1dcd0ee0d919 isviewmodelanimplaying() )
            {
                var_44cf1dcd0ee0d919 stopviewmodelanim();
            }
        }
        
        return;
    }
    
    utility::function_32b24db3127bff40( "grab_audio", "mouth_loop_off" );
    
    if ( isalive( var_44cf1dcd0ee0d919 ) )
    {
        var_44cf1dcd0ee0d919 playrumbleonentity( "heavy_3s" );
        var_44cf1dcd0ee0d919 earthquakeforplayer( 0.5, 3, var_44cf1dcd0ee0d919.origin, 100 );
        
        if ( !var_44cf1dcd0ee0d919 getcamerathirdperson() )
        {
            playfxontagforclients( utility::getfx( "player_grab_bite_amalgam_fx" ), var_44cf1dcd0ee0d919, "j_head", var_44cf1dcd0ee0d919 );
        }
        
        utility::function_32b24db3127bff40( "grab_bite", "bite_human" );
        var_44cf1dcd0ee0d919 utility::function_32b24db3127bff40( "amalgamBiteVFX", "vfx_start" );
        grab_attack_damage = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.grabattackdamage;
        
        if ( isdefined( self.var_fe048a2106d8ef00[ #"grab" ] ) )
        {
            grab_attack_damage *= self.var_fe048a2106d8ef00[ #"grab" ];
        }
        
        namespace_22232c840a00551b::start_health_regen( 0 );
        var_44cf1dcd0ee0d919 dodamage( grab_attack_damage, self.origin, self, self, "MOD_MELEE" );
    }
    
    if ( isalive( self ) )
    {
        event = utility::waittill_any_return( "death", "amalgam_grab_end", "amalgam_grab_throw" );
    }
    
    if ( isdefined( var_44cf1dcd0ee0d919 ) )
    {
        stopfxontagforclients( utility::getfx( "player_grabbed_by_amalgam_fx" ), var_44cf1dcd0ee0d919, "j_head", var_44cf1dcd0ee0d919 );
        var_44cf1dcd0ee0d919 stopanimscriptsceneevent();
        
        if ( var_44cf1dcd0ee0d919 isviewmodelanimplaying() )
        {
            var_44cf1dcd0ee0d919 stopviewmodelanim();
        }
    }
}

// Namespace zombie_amalgam_grab
// Params 3, eflags: 0x4
// Checksum 0x2cca3fbb, Offset: 0x1b0b
// Size: 0xfe
function private function_95fe743ccb0bee92( grabbed_ai, grab_model, var_e23aa633570c3fa4 )
{
    self endon( #"death" );
    self endon( #"amalgam_grab_end" );
    grabbed_ai forceteleport( grab_model.origin, grabbed_ai.angles );
    waitframe();
    
    if ( isalive( grabbed_ai ) )
    {
        grabbed_ai linkto( grab_model, "tag_origin" );
    }
    
    self waittill( #"amalgam_grab_bite" );
    
    if ( isalive( grabbed_ai ) )
    {
        var_af1feabe896eff01 = grabbed_ai.unittype == "zombie";
        
        if ( var_af1feabe896eff01 && !zombie_utils::function_bf1464d09f4e4b40() )
        {
            var_32dbca3143d9c4a5 = level.sharedfuncs[ #"zombie" ][ #"hash_6c2d9080e508d382" ];
            
            if ( isdefined( var_32dbca3143d9c4a5 ) )
            {
                grabbed_ai [[ var_32dbca3143d9c4a5 ]]();
            }
        }
        
        grabbed_ai.forceannihilate = 1;
        grabbed_ai kill();
        namespace_22232c840a00551b::start_health_regen( var_af1feabe896eff01 );
    }
}

/#

    // Namespace zombie_amalgam_grab
    // Params 0, eflags: 0x4
    // Checksum 0x22beb158, Offset: 0x1c11
    // Size: 0x44, Type: dev
    function private init_amalgam_grab_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x53>" );
        devgui::add_devgui_func( "<dev string:x6c>", "<dev string:x77>", &function_cfde99c153593b14 );
        devgui::add_devgui_func( "<dev string:x82>", "<dev string:x93>", &function_fcf30a4600c9b9cd );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_amalgam_grab
    // Params 0, eflags: 0x4
    // Checksum 0x9e58f72b, Offset: 0x1c5d
    // Size: 0x1a, Type: dev
    function private function_cfde99c153593b14()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xa4>", @"hash_1bebd89199db7cc3" );
    }

    // Namespace zombie_amalgam_grab
    // Params 0, eflags: 0x4
    // Checksum 0x8e5c4f5d, Offset: 0x1c7f
    // Size: 0x1a, Type: dev
    function private function_fcf30a4600c9b9cd()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xb7>", @"hash_7d0d25a85963bf41" );
    }

#/
