// scripts\common\ai\aitypes\zombie_amalgam\zombie_amalgam.gsc  (hash_192ca5245c01accc.gscc) (size: 17021 Bytes / 0x427d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdfd01081 (3754954881)
// size ...... 17021 (0x427d)
// includes .. 18  (offset: 0x3c5d)
// strings ... 68  (offset: 0x3ced)
// dev strs .. 25  (offset: 0x412d)
// exports ... 36  (offset: 0x27ad)
// cseg ...... 0x4e7 + 0x22c6 (0x27ad)
// imports ... 117 (offset: 0x2d4d)
// animtree1 . 0   (offset: 0x427d)
// animtree2 . 0   (offset: 0x427d)
#using script_18a87900fcfe1bc;
#using scripts\asm\asm;
#using scripts\asm\shared\variant_asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_melee;
#using scripts\common\ai\aitypes\shared\zombie\zombie_ranged_attack;
#using scripts\common\ai\aitypes\shared\zombie\zombie_traverse;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_amalgam\zombie_amalgam_audio;
#using scripts\common\ai\aitypes\zombie_amalgam\zombie_amalgam_medal;
#using scripts\common\ai\aitypes\zombie_amalgam\zombie_amalgam_parts;
#using scripts\common\ai\aitypes\zombie_amalgam\zombie_amalgam_regeneration;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_amalgam;

// Namespace zombie_amalgam
// Params 2
// Checksum 0x1e2d446, Offset: 0x505
// Size: 0x66
function precache( classname, aitypescriptbundle )
{
    zombie_amalgam_grab::function_813e8d5ae56f2a4b( aitypescriptbundle );
    var_4b4d72d84afd1ebd = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( var_4b4d72d84afd1ebd ) )
    {
        utility::add_fx( "amalgam_death_ground_fx", var_4b4d72d84afd1ebd.var_b8d49ee554b382d );
        utility::add_fx( "amalgam_death_small_ground_fx", var_4b4d72d84afd1ebd.var_92366a2ab00f3280 );
    }
}

// Namespace zombie_amalgam
// Params 1
// Checksum 0x44ed30c2, Offset: 0x573
// Size: 0x219
function function_cfbb84b3d7bc65b8( params )
{
    zombie_melee::init_zombie_melee_global();
    namespace_ef593377fdc8b4e0::init_zombie_amalgam_parts_global();
    namespace_22232c840a00551b::function_840215f8bcd481f6();
    namespace_e34daa855be4fe3c::init_zombie_amalgam_audio_global();
    
    /#
        init_amalgam_devgui();
    #/
    
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &play_death_fx );
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_killed", &function_3df69063bb77d164 );
    callback::get_template( self.animsetname ) callback::add( "shocked", &function_ce4fe5b7b95b73f6 );
    callback::get_template( self.animsetname ) callback::add( "shocked_end", &function_f8cbef2738adcd18 );
    callback::get_template( self.animsetname ) callback::add( "poisoned", &function_91e753b101229a2 );
    callback::get_template( self.animsetname ) callback::add( "poisoned_end", &function_8c2a60ae74d8ce34 );
    callback::get_template( self.animsetname ) callback::add( "wraith_burned", &function_9a92f215ba32b261 );
    callback::get_template( self.animsetname ) callback::add( "wraith_burned_end", &function_c9afe0de75edf987 );
    callback::get_template( self.animsetname ) callback::add( "burned", &function_2080c9a8a657bc17 );
    callback::get_template( self.animsetname ) callback::add( "burned_end", &function_ef6cb4c9a207699d );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned", &function_2b8879e19ccaeef3 );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned_thermite", &function_aa4be0297708a8fa );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned_end", &function_8b959aabb4069e99 );
    callback::get_template( self.animsetname ) callback::add( "on_turned", &on_zombie_turned );
    callback::get_template( self.animsetname ) callback::add( "on_brainrot_end", &function_16751232a9e10970 );
    zombie_amalgam_medal::function_3e2ebd0315b2a350();
}

// Namespace zombie_amalgam
// Params 1
// Checksum 0x955eaff8, Offset: 0x794
// Size: 0x162
function function_81aa6d5dd7d092d8( taskid )
{
    assert( isdefined( self.zombieaisetting ) );
    zombie_init::function_5d23979c4c7c9a52( self.zombieaisetting );
    assert( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ) );
    callback::add( "on_first_ai_init", &function_cfbb84b3d7bc65b8 );
    callback::add( "on_zombie_init_restore_metabones", &namespace_ef593377fdc8b4e0::restore_metabones );
    zombie_melee::init_zombie_melee();
    namespace_96f746e657c877bf::init_zombie_ranged_attack();
    namespace_e34daa855be4fe3c::init_zombie_amalgam_audio();
    namespace_22232c840a00551b::init_zombie_amalgam_regeneration();
    thread namespace_ef593377fdc8b4e0::init_zombie_amalgam_parts();
    thread init_scriptable();
    self function_10006c8216ad87fd( "focus_behaviors", "fsm", "no_focus" );
    self function_ff32ea59b2119107();
    self.var_fa5af4b8fd716cf5 = 0;
    self.var_20117f0b983110f3 = gettime() + self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_1cf7d5666acd07a4 * 1000;
    self.allowpain = 0;
    self.allowfriendlyfire = 1;
    self._blackboard.var_224d529c5512a171 = 1;
    self.nododgemove = 1;
    
    if ( !isdefined( level.var_9335940a4e492645 ) )
    {
        level.var_9335940a4e492645 = 0;
    }
    
    level.var_9335940a4e492645++;
    val::set( "amalgam_init", "damage_knockback", 0 );
    thread function_e036d053e06747ff();
    return anim.success;
}

// Namespace zombie_amalgam
// Params 0, eflags: 0x4
// Checksum 0xefa620e3, Offset: 0x8ff
// Size: 0xd7
function private init_scriptable()
{
    self endon( #"death" );
    self function_786bb6aa1b76c7ee( "in_spawn_reveal", 1 );
    utility::flag_wait( "scriptables_ready" );
    waitframe();
    var_4fa532b4c6657721 = 0;
    
    if ( self.b_evolved )
    {
        asm::function_7256f5ba459c840b( "roar_in" );
    }
    
    if ( self isscriptable() )
    {
        utility::function_32b24db3127bff40( "base", "base_on" );
        
        if ( self.b_evolved )
        {
            utility::function_32b24db3127bff40( "spawn_reveal", "spawn_reveal_evo" );
        }
        else if ( !self.disable_spawn_vfx )
        {
            utility::function_32b24db3127bff40( "spawn_reveal", "spawn_reveal" );
        }
        else
        {
            utility::function_32b24db3127bff40( "spawn_reveal", "spawn_reveal_audio_only" );
        }
        
        wait 1;
        utility::function_32b24db3127bff40( "spawn_reveal", "off" );
    }
    
    self function_f2df0257c63f229( "in_spawn_reveal" );
}

// Namespace zombie_amalgam
// Params 0, eflags: 0x4
// Checksum 0xb7dc2b42, Offset: 0x9de
// Size: 0xea
function private function_e036d053e06747ff()
{
    self endon( #"death" );
    ai_settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    wait ai_settings.var_20a0b2d46b6b1b96;
    
    while ( true )
    {
        if ( self.team != "team_hundred_eighty_nine" && !zombie_utils::function_bf1464d09f4e4b40() && self.health < self.maxhealth && self.var_fa5af4b8fd716cf5 < gettime() )
        {
            target = function_34444a2421806e2a();
            
            if ( isdefined( target ) )
            {
                allow_opportunistic_attack( target );
                wait ai_settings.var_ba57255e7169f6e;
                
                if ( self.team == "team_hundred_eighty_nine" )
                {
                    reset_opportunistic_attack();
                }
                
                wait max( 1, ai_settings.var_20a0b2d46b6b1b96 - ai_settings.var_ba57255e7169f6e );
            }
        }
        
        waitframe();
    }
}

// Namespace zombie_amalgam
// Params 1
// Checksum 0x6d8de9c2, Offset: 0xad0
// Size: 0x80
function allow_opportunistic_attack( target_ent )
{
    assert( !zombie_utils::function_bf1464d09f4e4b40() );
    self.var_dae90b63fe19f38d = self.team;
    self.team = "team_hundred_eighty_nine";
    utility::callsharedfunc( #"ai", #"hash_d1ade7b3c059cba9", "amalgam_opportunistic_attack", 1 );
    
    if ( isdefined( target_ent ) )
    {
        zombie_utils::set_ai_target_priority( target_ent, "opportunistic_target", 99999 );
    }
    
    utility::ent_flag_set( "opportunistic_attack" );
}

// Namespace zombie_amalgam
// Params 1
// Checksum 0xf8ff1dd8, Offset: 0xb58
// Size: 0x7d
function reset_opportunistic_attack( var_3ec7444e5bce7d0a )
{
    self.team = var_3ec7444e5bce7d0a ?? self.var_dae90b63fe19f38d;
    assert( self.team );
    utility::callsharedfunc( #"ai", #"hash_d1ade7b3c059cba9", "amalgam_opportunistic_attack", 0 );
    zombie_utils::set_ai_target_priority( undefined, "opportunistic_target", 99999 );
    namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "melee" );
    utility::ent_flag_clear( "opportunistic_attack" );
}

// Namespace zombie_amalgam
// Params 0, eflags: 0x4
// Checksum 0xdea31490, Offset: 0xbdd
// Size: 0x13f
function private function_34444a2421806e2a()
{
    ai_settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    var_d3bf5c32e7a64eb1 = getaispeciesarray( "all", "zombie" );
    best_zombie = undefined;
    best_dist_sqr = squared( ai_settings.var_ff117d8293aa2ce4 );
    
    foreach ( zombie in var_d3bf5c32e7a64eb1 )
    {
        to_zombie = zombie.origin - self.origin;
        dist_sqr = lengthsquared( to_zombie );
        
        if ( dist_sqr >= best_dist_sqr )
        {
            continue;
        }
        
        if ( !zombie_amalgam_grab::function_af2f4170c8a8cf2( zombie ) )
        {
            continue;
        }
        
        if ( absangleclamp180( vectortoyaw( to_zombie ) - self.angles[ 1 ] ) > ai_settings.var_a20fed1fcca495a )
        {
            continue;
        }
        
        best_zombie = zombie;
        best_dist_sqr = dist_sqr;
    }
    
    return best_zombie;
}

// Namespace zombie_amalgam
// Params 1
// Checksum 0x114d20fb, Offset: 0xd25
// Size: 0x2a
function function_3df69063bb77d164( params )
{
    level.var_9335940a4e492645 = int( max( level.var_9335940a4e492645 - 1, 0 ) );
}

// Namespace zombie_amalgam
// Params 1, eflags: 0x4
// Checksum 0x8f401c69, Offset: 0xd57
// Size: 0x2d1
function private play_death_fx( params )
{
    var_d85b3a96021e46b9 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.deathduration;
    var_65f5be31372bc0db = istrue( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_19a690b105e873ca );
    var_e2ea26ca9ad15079 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_66c04861d54b87d0;
    var_377e93c56edb1234 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_e2450f3d61711e4b;
    var_ed4b789c9c9e31f5 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_3505e19679ea919d;
    utility::function_32b24db3127bff40( "base", "base_off" );
    body = zombie_utils::function_4e99fb1239980783( params );
    
    if ( isdefined( body ) )
    {
        body endon( #"corpse_deleted" );
        body utility::function_32b24db3127bff40( "base", "base_off" );
        
        if ( utility::ent_flag( "burned" ) )
        {
            body utility::function_32b24db3127bff40( "burned", "burned_on" );
            body thread function_fc12a24729ef4e67();
        }
        else if ( utility::ent_flag( "napalm_burned" ) )
        {
            body utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on" );
            body thread function_a67c6606a684a2dd();
        }
        
        b_annihilate = self.forceannihilate || zombie_traverse::is_traversing();
        
        if ( !b_annihilate )
        {
            if ( var_65f5be31372bc0db )
            {
                ground_pos = utility::drop_to_ground( self.origin, 30, -100 );
                
                if ( isdefined( ground_pos ) )
                {
                    result = body get_average_ground_normal( var_377e93c56edb1234 );
                    
                    if ( result.normal != ( 0, 0, 0 ) )
                    {
                        if ( result.dist_sqr < squared( var_ed4b789c9c9e31f5 ) )
                        {
                            var_62e858c45bbf3f11 = utility::getfx( "amalgam_death_small_ground_fx" );
                        }
                        else
                        {
                            var_62e858c45bbf3f11 = utility::getfx( "amalgam_death_ground_fx" );
                        }
                        
                        if ( var_62e858c45bbf3f11 )
                        {
                            body utility::function_32b24db3127bff40( "death_reveal", "death_reveal" );
                            wait var_e2ea26ca9ad15079;
                            right_dir = anglestoright( self.angles );
                            forward_dir = vectorcross( result.normal, right_dir );
                            playfx( var_62e858c45bbf3f11, ground_pos, forward_dir, result.normal );
                            wait var_d85b3a96021e46b9 - var_e2ea26ca9ad15079;
                        }
                        else
                        {
                            b_annihilate = 1;
                        }
                    }
                }
                else
                {
                    body utility::function_32b24db3127bff40( "death_reveal", "death_reveal" );
                    wait var_d85b3a96021e46b9;
                }
            }
        }
        
        if ( b_annihilate )
        {
            body utility::function_32b24db3127bff40( "death_reveal", "annihilate" );
            wait 0.1;
        }
        
        body delete();
    }
}

// Namespace zombie_amalgam
// Params 2, eflags: 0x4
// Checksum 0xfa59eabe, Offset: 0x1030
// Size: 0x2a4
function private get_average_ground_normal( radius, var_d4618b70ea2e3eee )
{
    if ( radius > 0 )
    {
        forward_positions = get_ground_positions( anglestoforward( self.angles ), radius, var_d4618b70ea2e3eee );
        
        if ( isdefined( forward_positions ) && forward_positions.pos_a != forward_positions.pos_b )
        {
            right_positions = get_ground_positions( anglestoright( self.angles ), radius, var_d4618b70ea2e3eee );
            
            if ( isdefined( right_positions ) && right_positions.pos_a != right_positions.pos_b )
            {
                forward_ground = forward_positions.pos_a - forward_positions.pos_b;
                right_ground = right_positions.pos_a - right_positions.pos_b;
                ground_normal = vectornormalize( vectorcross( right_ground, forward_ground ) );
                min_dist_sqr = squared( radius );
                dist_sqr = distancesquared( self.origin, forward_positions.pos_a );
                
                if ( dist_sqr < min_dist_sqr )
                {
                    min_dist_sqr = dist_sqr;
                }
                
                dist_sqr = distancesquared( self.origin, forward_positions.pos_b );
                
                if ( dist_sqr < min_dist_sqr )
                {
                    min_dist_sqr = dist_sqr;
                }
                
                dist_sqr = distancesquared( self.origin, right_positions.pos_a );
                
                if ( dist_sqr < min_dist_sqr )
                {
                    min_dist_sqr = dist_sqr;
                }
                
                dist_sqr = distancesquared( self.origin, right_positions.pos_b );
                
                if ( dist_sqr < min_dist_sqr )
                {
                    min_dist_sqr = dist_sqr;
                }
                
                /#
                    if ( var_d4618b70ea2e3eee >= 0 )
                    {
                        line( forward_positions.pos_a, forward_positions.pos_b, ( 1, 0, 0 ), 1, 0, var_d4618b70ea2e3eee );
                        line( right_positions.pos_a, right_positions.pos_b, ( 0, 1, 0 ), 1, 0, var_d4618b70ea2e3eee );
                        line( self.origin, self.origin + ground_normal * 50, ( 0, 1, 0 ), 1, 0, var_d4618b70ea2e3eee );
                        cylinder( self.origin - ground_normal * 10, self.origin + ground_normal * 10, radius, ( 1, 1, 1 ), 0, var_d4618b70ea2e3eee );
                    }
                #/
                
                return { #dist_sqr:min_dist_sqr, #normal:ground_normal };
            }
        }
    }
    
    return { #dist_sqr:0, #normal:( 0, 0, 0 ) };
}

// Namespace zombie_amalgam
// Params 3, eflags: 0x4
// Checksum 0xc54deee5, Offset: 0x12dd
// Size: 0x238
function private get_ground_positions( direction, dist, var_d4618b70ea2e3eee )
{
    offset = direction * dist;
    pos_a = self.origin + offset;
    pos_b = self.origin - offset;
    nav_trace_results = navtrace( self.origin, pos_a, self, 1 );
    
    if ( isdefined( nav_trace_results[ "position" ] ) && nav_trace_results[ "fraction" ] < 1 )
    {
        pos_a = nav_trace_results[ "position" ];
    }
    
    nav_trace_results = navtrace( self.origin, pos_b, self, 1 );
    
    if ( isdefined( nav_trace_results[ "position" ] ) && nav_trace_results[ "fraction" ] < 1 )
    {
        pos_b = nav_trace_results[ "position" ];
    }
    
    if ( distancesquared( pos_a, pos_b ) >= 25 )
    {
        vertical_offset = ( 0, 0, dist * 1.5 );
        solid_ai_contents = trace::create_solid_ai_contents( 1 );
        ray_trace_a = trace::ray_trace( pos_a + vertical_offset, pos_a - vertical_offset, undefined, solid_ai_contents );
        ray_trace_b = trace::ray_trace( pos_b + vertical_offset, pos_b - vertical_offset, undefined, solid_ai_contents );
        pos_a_ground = ray_trace_a[ "hittype" ] != "hittype_none" ? ray_trace_a[ "position" ] : self.origin;
        pos_b_ground = ray_trace_b[ "hittype" ] != "hittype_none" ? ray_trace_b[ "position" ] : self.origin;
        
        /#
            if ( var_d4618b70ea2e3eee >= 0 )
            {
                line( pos_a + vertical_offset, pos_a - vertical_offset, ray_trace_a[ "<dev string:x24>" ] != "<dev string:x2c>" ? ( 1, 1, 0 ) : ( 1, 0, 0 ), 1, 0, var_d4618b70ea2e3eee );
                line( pos_b + vertical_offset, pos_b - vertical_offset, ray_trace_b[ "<dev string:x24>" ] != "<dev string:x2c>" ? ( 1, 0, 1 ) : ( 1, 0, 0 ), 1, 0, var_d4618b70ea2e3eee );
            }
        #/
        
        return { #pos_b:pos_b_ground, #pos_a:pos_a_ground };
    }
}

// Namespace zombie_amalgam
// Params 0, eflags: 0x4
// Checksum 0xf0381ed9, Offset: 0x151e
// Size: 0x72
function private function_fc12a24729ef4e67()
{
    self endon( #"corpse_deleted" );
    wait 3;
    utility::function_7c10ea82c1e305b8( "burned", "burned_off" );
    var_80f3576404b5eba0 = 0;
    var_80f3576404b5eba0 = utility::function_7c10ea82c1e305b8( "burned", "burned_dead" );
    
    if ( var_80f3576404b5eba0 )
    {
        return;
    }
    
    utility::function_7c10ea82c1e305b8( "burned", "burned_dead" );
    wait 3;
    utility::function_7c10ea82c1e305b8( "burned", "burned_off" );
}

// Namespace zombie_amalgam
// Params 0, eflags: 0x4
// Checksum 0xdd73fe47, Offset: 0x1598
// Size: 0x5e
function private function_a67c6606a684a2dd()
{
    self endon( #"corpse_deleted" );
    wait 3.7;
    var_80f3576404b5eba0 = utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_dead" );
    
    if ( var_80f3576404b5eba0 )
    {
        return;
    }
    
    utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_end" );
    wait 3;
    utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_off" );
}

// Namespace zombie_amalgam
// Params 1, eflags: 0x4
// Checksum 0x74a3d83d, Offset: 0x15fe
// Size: 0x1d5
function private on_zombie_turned( var_75e7c1be4fd022be )
{
    if ( utility::ent_flag( "opportunistic_attack" ) )
    {
        if ( isdefined( self.status_effects[ "charm" ] ) )
        {
            foreach ( var_6bee30cd741982fb in self.status_effects[ "charm" ] )
            {
                var_6bee30cd741982fb.var_ee6f6b2cdf5ddbd7 = self.var_dae90b63fe19f38d;
            }
        }
        
        reset_opportunistic_attack( self.team );
    }
    
    utility::function_32b24db3127bff40( "brainrot", "brainrot_on" );
    
    foreach ( index in self.var_522914c02132cc64 )
    {
        utility::function_32b24db3127bff40( namespace_ef593377fdc8b4e0::function_9f0edc5183cdd55e( index ), "brainrot" );
    }
    
    foreach ( index in self.var_24c5169d1d7aa136 )
    {
        utility::function_32b24db3127bff40( namespace_ef593377fdc8b4e0::function_c65f9af3c4269498( index ), "brainrot" );
    }
}

// Namespace zombie_amalgam
// Params 1, eflags: 0x4
// Checksum 0xee771a17, Offset: 0x17db
// Size: 0x11b
function private function_16751232a9e10970( params )
{
    utility::function_32b24db3127bff40( "brainrot", "brainrot_off" );
    
    foreach ( index in self.var_522914c02132cc64 )
    {
        utility::function_32b24db3127bff40( namespace_ef593377fdc8b4e0::function_9f0edc5183cdd55e( index ), "on" );
    }
    
    foreach ( index in self.var_24c5169d1d7aa136 )
    {
        utility::function_32b24db3127bff40( namespace_ef593377fdc8b4e0::function_c65f9af3c4269498( index ), "on" );
    }
}

// Namespace zombie_amalgam
// Params 1, eflags: 0x4
// Checksum 0x8c69f346, Offset: 0x18fe
// Size: 0x1d
function private function_ce4fe5b7b95b73f6( s_shock_effect )
{
    utility::function_32b24db3127bff40( "shocked", "shocked_on" );
}

// Namespace zombie_amalgam
// Params 1, eflags: 0x4
// Checksum 0x1bf854f6, Offset: 0x1923
// Size: 0x1d
function private function_f8cbef2738adcd18( s_shock_effect )
{
    utility::function_7c10ea82c1e305b8( "shocked", "shocked_off" );
}

// Namespace zombie_amalgam
// Params 1, eflags: 0x4
// Checksum 0xebd777da, Offset: 0x1948
// Size: 0x1d
function private function_91e753b101229a2( s_burn_effect )
{
    utility::function_32b24db3127bff40( "poisoned", "poisoned_on" );
}

// Namespace zombie_amalgam
// Params 1, eflags: 0x4
// Checksum 0xd69715da, Offset: 0x196d
// Size: 0x29
function private function_8c2a60ae74d8ce34( s_burn_effect )
{
    utility::ent_flag_clear( "poisoned" );
    utility::function_7c10ea82c1e305b8( "poisoned", "poisoned_off" );
}

// Namespace zombie_amalgam
// Params 1, eflags: 0x4
// Checksum 0x10a5a419, Offset: 0x199e
// Size: 0x1d
function private function_9a92f215ba32b261( s_burn_effect )
{
    utility::function_32b24db3127bff40( "wraith_burned", "wraith_burned_on" );
}

// Namespace zombie_amalgam
// Params 1, eflags: 0x4
// Checksum 0xac0afbb2, Offset: 0x19c3
// Size: 0x29
function private function_c9afe0de75edf987( s_burn_effect )
{
    utility::ent_flag_clear( "wraith_burned" );
    utility::function_7c10ea82c1e305b8( "wraith_burned", "wraith_burned_off" );
}

// Namespace zombie_amalgam
// Params 1, eflags: 0x4
// Checksum 0x5dcdf8e3, Offset: 0x19f4
// Size: 0x3f
function private function_2080c9a8a657bc17( s_burn_effect )
{
    var_7dddc60e0205506b = s_burn_effect.var_7dddc60e0205506b ?? "";
    utility::function_32b24db3127bff40( "burned" + var_7dddc60e0205506b, "burned_on" );
}

// Namespace zombie_amalgam
// Params 1, eflags: 0x4
// Checksum 0x4e3bd3ed, Offset: 0x1a3b
// Size: 0x3f
function private function_ef6cb4c9a207699d( s_burn_effect )
{
    var_7dddc60e0205506b = s_burn_effect.var_7dddc60e0205506b ?? "";
    utility::function_32b24db3127bff40( "burned" + var_7dddc60e0205506b, "burned_off" );
}

// Namespace zombie_amalgam
// Params 1, eflags: 0x4
// Checksum 0xa41b5858, Offset: 0x1a82
// Size: 0x1d
function private function_2b8879e19ccaeef3( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on" );
}

// Namespace zombie_amalgam
// Params 1, eflags: 0x4
// Checksum 0xc2f2f5f8, Offset: 0x1aa7
// Size: 0x1d
function private function_aa4be0297708a8fa( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on_thermite" );
}

// Namespace zombie_amalgam
// Params 1, eflags: 0x4
// Checksum 0xdd255f3e, Offset: 0x1acc
// Size: 0x1d
function private function_8b959aabb4069e99( s_burn_effect )
{
    utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_off" );
}

// Namespace zombie_amalgam
// Params 2
// Checksum 0x7a30399, Offset: 0x1af1
// Size: 0x90f, Type: bool
function function_91bb38b63b6c6f13( taskid, params )
{
    if ( isdefined( self.var_8cb3c9f5176399ed ) || effect_slow::function_6fab6266b5f636c3() || self.b_in_spawn_closet || self.var_ec1bfc54caa257ab )
    {
        return false;
    }
    
    /#
        b_debug_fails = getdvarint( @"hash_7d0d25a85963bf41", 0 );
    #/
    
    /#
        b_debug_grab = getdvarint( @"hash_1bebd89199db7cc3", 0 );
    #/
    
    if ( !namespace_ef593377fdc8b4e0::has_grab_arm() )
    {
        /#
            if ( b_debug_fails )
            {
                print3d( self.origin + ( 0, 0, 50 ), "<dev string:x39>", ( 1, 1, 1 ), 1, 0.5, 1, 1 );
            }
        #/
        
        return false;
    }
    
    curr_time = gettime();
    
    if ( self.var_fa5af4b8fd716cf5 > curr_time )
    {
        /#
            if ( b_debug_fails )
            {
                print3d( self.origin + ( 0, 0, 50 ), "<dev string:x45>" + self.var_fa5af4b8fd716cf5 - curr_time, ( 1, 1, 1 ), 1, 0.5, 1, 1 );
            }
        #/
        
        return false;
    }
    
    if ( level.var_fa5af4b8fd716cf5 > curr_time )
    {
        /#
            if ( b_debug_fails )
            {
                print3d( self.origin + ( 0, 0, 50 ), "<dev string:x55>" + level.var_fa5af4b8fd716cf5 - curr_time, ( 1, 1, 1 ), 1, 0.5, 1, 1 );
            }
        #/
        
        return false;
    }
    
    if ( !zombie_amalgam_grab::function_af2f4170c8a8cf2( self.enemy ) )
    {
        /#
            if ( b_debug_fails )
            {
                print3d( self.origin + ( 0, 0, 50 ), "<dev string:x6c>", ( 1, 1, 1 ), 1, 0.5, 1, 1 );
            }
        #/
        
        return false;
    }
    
    if ( self.team == "team_hundred_eighty_nine" && self.var_20117f0b983110f3 > curr_time && !isplayer( self.enemy ) )
    {
        /#
            if ( b_debug_fails )
            {
                print3d( self.origin + ( 0, 0, 50 ), "<dev string:x8b>" + self.var_20117f0b983110f3 - curr_time, ( 1, 1, 1 ), 1, 0.5, 1, 1 );
            }
        #/
        
        return false;
    }
    
    ai_settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    var_ee6433c31961982d = self.enemy.origin - self.origin;
    yaw_to_enemy = absangleclamp180( vectortoyaw( var_ee6433c31961982d ) - self.angles[ 1 ] );
    
    if ( yaw_to_enemy > ai_settings.var_a0cc94c4c1fdbb35 )
    {
        /#
            if ( b_debug_fails )
            {
                print3d( self.origin + ( 0, 0, 50 ), "<dev string:xa2>" + yaw_to_enemy + "<dev string:xb4>" + ai_settings.var_a0cc94c4c1fdbb35, ( 1, 1, 1 ), 1, 0.5, 1, 1 );
            }
        #/
        
        return false;
    }
    
    dist_sqr = lengthsquared( var_ee6433c31961982d );
    
    if ( dist_sqr > squared( ai_settings.var_db5f0e09f2fcbdf5 ) )
    {
        /#
            if ( b_debug_fails )
            {
                print3d( self.origin + ( 0, 0, 50 ), "<dev string:xb8>" + sqrt( dist_sqr ) + "<dev string:xb4>" + ai_settings.var_db5f0e09f2fcbdf5, ( 1, 1, 1 ), 1, 0.5, 1, 1 );
            }
        #/
        
        return false;
    }
    
    var_b0a681d77fccb76d = var_ee6433c31961982d[ 2 ];
    
    if ( var_b0a681d77fccb76d > 0 && var_b0a681d77fccb76d > ai_settings.var_afe78d76ca77f484 )
    {
        /#
            if ( b_debug_fails )
            {
                print3d( self.origin + ( 0, 0, 50 ), "<dev string:xce>" + var_b0a681d77fccb76d + "<dev string:xb4>" + ai_settings.var_afe78d76ca77f484, ( 1, 1, 1 ), 1, 0.5, 1, 1 );
            }
        #/
        
        return false;
    }
    
    if ( var_b0a681d77fccb76d < 0 && var_b0a681d77fccb76d < ai_settings.var_1d78f9980a6474bc * -1 )
    {
        /#
            if ( b_debug_fails )
            {
                print3d( self.origin + ( 0, 0, 50 ), "<dev string:xe5>" + var_b0a681d77fccb76d + "<dev string:xfc>" + ai_settings.var_1d78f9980a6474bc, ( 1, 1, 1 ), 1, 0.5, 1, 1 );
            }
        #/
        
        return false;
    }
    
    predicted_dist_sqr = dist_sqr;
    var_df9adb69b75ff5f3 = self.enemy getvelocity();
    
    if ( vectordot( var_df9adb69b75ff5f3, var_ee6433c31961982d ) > 0 )
    {
        predicted_target_loc = self.enemy.origin + var_df9adb69b75ff5f3 * 0.75;
        var_a442d1a1f056424d = predicted_target_loc - self.origin;
        predicted_dist_sqr = lengthsquared( var_a442d1a1f056424d );
    }
    
    if ( predicted_dist_sqr > squared( ai_settings.var_db5f0e09f2fcbdf5 ) )
    {
        /#
            if ( b_debug_fails )
            {
                print3d( self.origin + ( 0, 0, 50 ), "<dev string:x101>" + sqrt( predicted_dist_sqr ), ( 1, 1, 1 ), 1, 0.5, 1, 1 );
            }
        #/
        
        return false;
    }
    
    nav_loc = getclosestpointonnavmesh( self.origin, self, 0, 1, 0, 1 );
    
    if ( !isdefined( nav_loc ) )
    {
        return false;
    }
    
    dist_sqr_navmesh = distance2dsquared( nav_loc, self.origin );
    
    if ( dist_sqr_navmesh > 25 )
    {
        return false;
    }
    
    min_dist = ai_settings.var_9c107d76e655bcef;
    max_dist = ai_settings.var_db5f0e09f2fcbdf5;
    var_ecb76e9d5126c952 = vectornormalize2( var_ee6433c31961982d );
    clear_dist = zombie_amalgam_grab::function_e5b9d5865e560107( max_dist + 30, var_ecb76e9d5126c952 );
    var_65b6b613066ff9fd = clear_dist < max_dist + 30;
    max_range_sqr = squared( var_65b6b613066ff9fd ? max_dist : ( max_dist + min_dist ) * 0.5 );
    min_range_sqr = squared( min_dist );
    
    if ( predicted_dist_sqr > min_range_sqr && predicted_dist_sqr <= max_range_sqr )
    {
        if ( clear_dist >= max_dist )
        {
            self function_786bb6aa1b76c7ee( "grab_attack_type", 1 );
            
            /#
                if ( b_debug_grab )
                {
                    print3d( self.origin + ( 0, 0, 70 ), "<dev string:x122>" + sqrt( predicted_dist_sqr ), ( 1, 1, 1 ), 1, 0.5, 100, 1 );
                }
            #/
            
            return true;
        }
        else
        {
            /#
                if ( b_debug_fails )
                {
                    print3d( self.origin + ( 0, 0, 50 ), "<dev string:x122>" + sqrt( predicted_dist_sqr ) + "<dev string:x128>", ( 1, 1, 1 ), 1, 0.5, 1, 1 );
                }
            #/
            
            return false;
        }
    }
    
    min_dist = ai_settings.var_d41acb5777365049;
    max_dist = ai_settings.var_9c107d76e655bcef;
    var_65b6b613066ff9fd = clear_dist < max_dist + 30;
    max_range_sqr = squared( var_65b6b613066ff9fd ? max_dist : ( max_dist + min_dist ) * 0.5 );
    min_range_sqr = squared( min_dist );
    
    if ( predicted_dist_sqr > min_range_sqr && predicted_dist_sqr <= max_range_sqr )
    {
        if ( clear_dist >= max_dist )
        {
            self function_786bb6aa1b76c7ee( "grab_attack_type", 1 );
            
            /#
                if ( b_debug_grab )
                {
                    print3d( self.origin + ( 0, 0, 70 ), "<dev string:x147>" + sqrt( predicted_dist_sqr ), ( 1, 1, 1 ), 1, 0.5, 100, 1 );
                }
            #/
            
            return true;
        }
        else
        {
            /#
                if ( b_debug_fails )
                {
                    print3d( self.origin + ( 0, 0, 50 ), "<dev string:x147>" + sqrt( predicted_dist_sqr ) + "<dev string:x128>", ( 1, 1, 1 ), 1, 0.5, 1, 1 );
                }
            #/
            
            return false;
        }
    }
    
    max_dist = ai_settings.var_d41acb5777365049;
    var_65b6b613066ff9fd = clear_dist < max_dist + 30;
    max_range_sqr = squared( var_65b6b613066ff9fd ? max_dist : max_dist - 10 );
    
    if ( predicted_dist_sqr <= max_range_sqr )
    {
        if ( clear_dist >= max_dist )
        {
            self function_786bb6aa1b76c7ee( "grab_attack_type", 0 );
            
            /#
                if ( b_debug_grab )
                {
                    print3d( self.origin + ( 0, 0, 70 ), "<dev string:x14d>" + sqrt( predicted_dist_sqr ), ( 1, 1, 1 ), 1, 0.5, 100, 1 );
                }
            #/
            
            return true;
        }
        else
        {
            /#
                if ( b_debug_fails )
                {
                    print3d( self.origin + ( 0, 0, 50 ), "<dev string:x14d>" + sqrt( predicted_dist_sqr ) + "<dev string:x128>", ( 1, 1, 1 ), 1, 0.5, 1, 1 );
                }
            #/
            
            return false;
        }
    }
    
    return false;
}

// Namespace zombie_amalgam
// Params 2
// Checksum 0x96bf7a82, Offset: 0x2409
// Size: 0xc1
function function_6c7ec2b4230f0cbe( taskid, params )
{
    self.var_e366c5eecacfffe9 = 0;
    self.grab_loc_start = self.origin;
    self.var_f683e0b4d38e6176 = self.enemy;
    zombie_amalgam_grab::function_acf2298db14eb020();
    var_aead62e4adde9ac3 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_94ba1a44137cba42;
    
    if ( var_aead62e4adde9ac3 > 0 )
    {
        var_fa5af4b8fd716cf5 = gettime() + var_aead62e4adde9ac3 * 1000;
        
        if ( !isdefined( level.var_fa5af4b8fd716cf5 ) || var_fa5af4b8fd716cf5 > level.var_fa5af4b8fd716cf5 )
        {
            level.var_fa5af4b8fd716cf5 = var_fa5af4b8fd716cf5;
        }
    }
    
    return anim.success;
}

// Namespace zombie_amalgam
// Params 2
// Checksum 0x323deace, Offset: 0x24d3
// Size: 0x37
function function_c113ff496e38bd37( taskid, params )
{
    if ( self getaiblackboarddynamic( "in_grab_attack" ) <= 0 )
    {
        return anim.success;
    }
    
    return anim.running;
}

// Namespace zombie_amalgam
// Params 2
// Checksum 0xf6988f9b, Offset: 0x2513
// Size: 0x18f
function function_b9230c8f9aa09939( taskid, params )
{
    if ( zombie_utils::function_bf1464d09f4e4b40() )
    {
        cooldown = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_f614cbce3efbd42c;
        self.var_fa5af4b8fd716cf5 = gettime() + cooldown * 1000;
    }
    else if ( self.var_62730a584b1747d1 )
    {
        cooldown = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_1cf7d5666acd07a4;
        self.var_20117f0b983110f3 = gettime() + cooldown * 1000;
    }
    else
    {
        cooldown = self.var_e366c5eecacfffe9 ? self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_31a40bedc3f70876 : self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_ac24fe149c9846ed;
        self.var_fa5af4b8fd716cf5 = gettime() + cooldown * 1000;
        var_aead62e4adde9ac3 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_94ba1a44137cba42;
        
        if ( var_aead62e4adde9ac3 > 0 )
        {
            var_fa5af4b8fd716cf5 = gettime() + var_aead62e4adde9ac3 * 1000;
            
            if ( !isdefined( level.var_fa5af4b8fd716cf5 ) || var_fa5af4b8fd716cf5 > level.var_fa5af4b8fd716cf5 )
            {
                level.var_fa5af4b8fd716cf5 = var_fa5af4b8fd716cf5;
            }
        }
    }
    
    self.var_62730a584b1747d1 = undefined;
    self.grab_loc_start = undefined;
    self.var_f683e0b4d38e6176 = undefined;
    self clearpath();
}

/#

    // Namespace zombie_amalgam
    // Params 0
    // Checksum 0x16426d69, Offset: 0x26aa
    // Size: 0x5d, Type: dev
    function get_closest_amalgam()
    {
        amalgam = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x155>" );
        
        if ( !isdefined( amalgam ) )
        {
            amalgam = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x164>" );
        }
        
        return amalgam;
    }

    // Namespace zombie_amalgam
    // Params 0, eflags: 0x4
    // Checksum 0x1044f0af, Offset: 0x270f
    // Size: 0x44, Type: dev
    function private init_amalgam_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x17a>" );
        devgui::add_devgui_func( "<dev string:x193>", "<dev string:x1a7>", &start_opportunistic_attack );
        devgui::add_devgui_func( "<dev string:x1bb>", "<dev string:x1ce>", &stop_opportunistic_attack );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_amalgam
    // Params 0, eflags: 0x4
    // Checksum 0x44f42d4f, Offset: 0x275b
    // Size: 0x25, Type: dev
    function private start_opportunistic_attack()
    {
        amalgam = get_closest_amalgam();
        
        if ( amalgam )
        {
            amalgam allow_opportunistic_attack();
        }
    }

    // Namespace zombie_amalgam
    // Params 0, eflags: 0x4
    // Checksum 0x172c6562, Offset: 0x2788
    // Size: 0x25, Type: dev
    function private stop_opportunistic_attack()
    {
        amalgam = get_closest_amalgam();
        
        if ( amalgam )
        {
            amalgam reset_opportunistic_attack();
        }
    }

#/
