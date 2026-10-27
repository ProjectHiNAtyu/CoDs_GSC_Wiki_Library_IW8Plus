// scripts\common\ai\aitypes\zombie_parasite\zombie_parasite.gsc  (hash_3118682eb7cc1408.gscc) (size: 12382 Bytes / 0x305e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfa0356db (4194522843)
// size ...... 12382 (0x305e)
// includes .. 12  (offset: 0x2bbe)
// strings ... 73  (offset: 0x2c1e)
// dev strs .. 3   (offset: 0x303a)
// exports ... 35  (offset: 0x1922)
// cseg ...... 0x51b + 0x1407 (0x1922)
// imports ... 107 (offset: 0x1e9a)
// animtree1 . 0   (offset: 0x305e)
// animtree2 . 0   (offset: 0x305e)
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_parasite\zombie_parasite_audio;
#using scripts\common\ai\aitypes\zombie_parasite\zombie_parasite_emergence_spawning;
#using scripts\common\ai\aitypes\zombie_parasite\zombie_parasite_evolve;
#using scripts\common\ai\aitypes\zombie_parasite\zombie_parasite_medal;
#using scripts\common\ai\aitypes\zombie_parasite\zombie_parasite_ranged_attack;
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_parasite;

// Namespace zombie_parasite
// Params 2
// Checksum 0x9470728c, Offset: 0x539
// Size: 0x67
function precache( classname, aitypescriptbundle )
{
    var_5aa57caf5f1a1879 = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( var_5aa57caf5f1a1879 ) && isdefined( var_5aa57caf5f1a1879.airspawnvfx ) )
    {
        utility::add_fx( "parasite_air_spawn_fx", var_5aa57caf5f1a1879.airspawnvfx );
    }
    
    zombie_parasite_ranged_attack::function_ef838b48185aceb4( aitypescriptbundle );
    zombie_parasite_evolve::function_59a9a94e2620a6e8( aitypescriptbundle );
}

// Namespace zombie_parasite
// Params 1, eflags: 0x4
// Checksum 0xc3606ffa, Offset: 0x5a8
// Size: 0x308
function private function_41179d6d1fe7fefa( params )
{
    namespace_f0e3b3e4b3226081::init_zombie_parasite_audio_global();
    zombie_parasite_emergence_spawning::function_22e6cae78206d7e9();
    zombie_parasite_medal::function_774fb122cb5c4051();
    zombie_parasite_evolve::function_22ef62a6d61cae96();
    callback::get_template( self.animsetname ) callback::add( "pre_killed_body_cloned", &function_d7992cb3cc217ca4 );
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &play_death_fx );
    callback::get_template( self.animsetname ) callback::add( "on_corpse_annihilated", &on_corpse_annihilated );
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_killed", &function_7914468a909df6cb );
    callback::get_template( self.animsetname ) callback::add( "on_turned", &on_zombie_turned );
    callback::get_template( self.animsetname ) callback::add( "poisoned", &function_91e753b101229a2 );
    callback::get_template( self.animsetname ) callback::add( "poisoned_end", &function_8c2a60ae74d8ce34 );
    callback::get_template( self.animsetname ) callback::add( "wraith_burned", &function_9a92f215ba32b261 );
    callback::get_template( self.animsetname ) callback::add( "wraith_burned_end", &function_c9afe0de75edf987 );
    callback::get_template( self.animsetname ) callback::add( "burned", &function_2080c9a8a657bc17 );
    callback::get_template( self.animsetname ) callback::add( "burned_end", &function_ef6cb4c9a207699d );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned", &function_2b8879e19ccaeef3 );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned_thermite", &function_aa4be0297708a8fa );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned_end", &function_8b959aabb4069e99 );
    callback::get_template( self.animsetname ) callback::add( "on_vortex_pull_changed", &function_7fdc2971cce4b3f4 );
    callback::get_template( self.animsetname ) callback::add( "on_vortex_pull_updated", &function_7fdc2971cce4b3f4 );
    callback::get_template( self.animsetname ) callback::add( "on_vortex_pull_ended", &on_vortex_pull_ended );
    callback::get_template( self.animsetname ) callback::add( "spawn_air_animscripted", &function_c0ba65f988769d23 );
    callback::get_template( self.animsetname ) callback::add( "on_ai_acquire_attractor", &function_9872c82a9b7e0705 );
    callback::get_template( self.animsetname ) callback::add( "on_ai_lose_attractor", &function_a81b0e7a075c2d38 );
    callback::get_template( self.animsetname ) callback::add( "on_ai_stunned", &function_c516ef198623fef9 );
    callback::get_template( self.animsetname ) callback::add( "on_ai_slowed", &function_14dfc509496c969e );
    callback::get_template( self.animsetname ) callback::add( "on_ai_slowed_end", &function_14dfc509496c969e );
}

// Namespace zombie_parasite
// Params 1
// Checksum 0x5266b6b1, Offset: 0x8b8
// Size: 0x15b
function ZombieParasiteInit( taskid )
{
    assert( isdefined( self.zombieaisetting ) );
    zombie_init::function_5d23979c4c7c9a52( self.zombieaisetting );
    assert( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ) );
    callback::add( "on_first_ai_init", &function_41179d6d1fe7fefa );
    self.allowpain = 0;
    self.allowstrafe = 0;
    self.var_b58461ff1ccb968d = 10;
    self.currentpose = "crouch";
    val::set( "ZombieParasiteInit", "script_pushable_by_ai", 0 );
    self function_786bb6aa1b76c7ee( "float_move_skip_intro_anim", 1 );
    self function_786bb6aa1b76c7ee( "default_float_height", 80 );
    self._blackboard.var_adb9ad36e14d100b = 1;
    self._blackboard.var_3b99c1a3e6725c32 = 1.33;
    self.var_a48163c16d11e1b1 = &function_f52c9285668dba42;
    self enabletraversals( 1, "zombie", "float", "climb" );
    zombie_parasite_ranged_attack::init_zombie_parasite_ranged_attack();
    namespace_f0e3b3e4b3226081::init_zombie_parasite_audio();
    zombie_parasite_emergence_spawning::init_zombie_parasite_emergence_spawning();
    zombie_parasite_evolve::init_parasite_evolution();
    thread initscriptable();
    thread function_568acbeb03c38503();
    
    if ( !isdefined( level.var_29cbaf753d01265a ) )
    {
        level.var_29cbaf753d01265a = 0;
    }
    
    level.var_29cbaf753d01265a++;
    return anim.success;
}

// Namespace zombie_parasite
// Params 1
// Checksum 0x241dba3, Offset: 0xa1c
// Size: 0x57, Type: bool
function function_a3dd2b45bc71cd28( weapon )
{
    if ( isdefined( weapon ) && function_ec5e321fe43d2fc( weapon ) )
    {
        return true;
    }
    
    if ( self.var_65522105f3bdca37 || isdefined( self.var_bd22ba6c600a23a3 ) || self.forceannihilate )
    {
        if ( !self.var_48960fedb514aedd )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zombie_parasite
// Params 0, eflags: 0x4
// Checksum 0xba7745ba, Offset: 0xa7c
// Size: 0x4a
function private initscriptable()
{
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    waitframe();
    
    if ( self.b_invisible )
    {
        return;
    }
    
    utility::function_32b24db3127bff40( "base", "base_on" );
    utility::function_32b24db3127bff40( "spit", "idle" );
}

// Namespace zombie_parasite
// Params 0, eflags: 0x4
// Checksum 0xf3bb00f7, Offset: 0xace
// Size: 0xee
function private function_568acbeb03c38503()
{
    self endon( #"death" );
    
    while ( true )
    {
        var_7d83f520111c08a5 = isdefined( self._blackboard ) && self._blackboard.var_79b2d8d61c6ef8b1;
        should_strafe = 0;
        
        if ( !var_7d83f520111c08a5 && isalive( self.enemy ) )
        {
            has_seen_enemy = self seerecently( self.enemy, 2 );
            var_bcd935941a082859 = distancesquared( self.origin, self.enemy.origin ) <= 2560000;
            should_strafe = has_seen_enemy && var_bcd935941a082859;
        }
        
        self.allowstrafe = should_strafe;
        self.var_cdf48282bb6d1237 = self aigetdesiredspeed() * ( should_strafe ? 2 : 1 );
        function_dc96ef23d61b0f20( should_strafe );
        wait 0.2;
    }
}

// Namespace zombie_parasite
// Params 1, eflags: 0x4
// Checksum 0xd7e862ce, Offset: 0xbc4
// Size: 0x25a
function private function_dc96ef23d61b0f20( should_strafe )
{
    if ( !should_strafe || self._blackboard.var_a1343e824832d912 )
    {
        self.var_610685debe870202 = undefined;
        return;
    }
    
    enemy_entity = self.enemy;
    
    if ( !isplayer( enemy_entity ) && !isagent( enemy_entity ) )
    {
        self.var_610685debe870202 = undefined;
        return;
    }
    
    var_21db003a019b038c = enemy_entity geteye();
    
    if ( enemy_entity getcamerathirdperson() )
    {
        var_21db003a019b038c = enemy_entity getcamerathirdpersonorigin();
    }
    
    enemy_angles = enemy_entity getplayerangles();
    enemy_aim = anglestoforward( enemy_angles );
    
    /#
        var_ea367d17289c994b = getdvarint( @"scr_parasite_debug", 0 ) == 1;
        
        if ( var_ea367d17289c994b )
        {
            debug_color = ( 0, 1, 0 );
            var_d4618b70ea2e3eee = 4;
        }
    #/
    
    enemy_view_dist = self getcentroid() - var_21db003a019b038c;
    var_1e2a1c4e2f050a54 = vectordot( enemy_view_dist, enemy_aim );
    
    if ( var_1e2a1c4e2f050a54 > 0 && lengthsquared( enemy_view_dist ) - var_1e2a1c4e2f050a54 * var_1e2a1c4e2f050a54 <= 1024 )
    {
        if ( self.var_610685debe870202 == enemy_entity )
        {
            if ( gettime() - self.aimed_start_time >= 800 )
            {
                self._blackboard.var_7b88cccdec53c07e = 0;
                self.aimed_start_time = gettime();
            }
        }
        else
        {
            self.var_610685debe870202 = enemy_entity;
            self.aimed_start_time = gettime();
        }
        
        /#
            if ( var_ea367d17289c994b )
            {
                aimed_entity = self.var_610685debe870202 getentitynumber();
                aimed_fraction = clamp( ( gettime() - self.aimed_start_time ) / 800, 0, 1 );
                debug_color = vectorlerp( ( 0, 1, 0 ), ( 1, 0, 0 ), aimed_fraction );
                print3d( self.origin, "<dev string:x24>" + aimed_entity + "<dev string:x33>" + int( aimed_fraction * 100 ) / 100 + "<dev string:x36>", debug_color, 1, 0.4, var_d4618b70ea2e3eee, 1 );
            }
        #/
    }
    else
    {
        self.var_610685debe870202 = undefined;
    }
    
    /#
        if ( var_ea367d17289c994b )
        {
            sphere( self getcentroid(), sqrt( 1024 ), debug_color, 1, var_d4618b70ea2e3eee );
        }
    #/
}

// Namespace zombie_parasite
// Params 0
// Checksum 0x75164c64, Offset: 0xe26
// Size: 0x78
function get_capsule_trace_params()
{
    contents = trace::create_contents( 0, 1, 1, 0, 0, 0, 1 );
    var_dbcd1330e1c3e98d = self getboundshalfsize();
    capsule_radius = max( var_dbcd1330e1c3e98d[ 0 ], var_dbcd1330e1c3e98d[ 1 ] ) + 8;
    capsule_height = var_dbcd1330e1c3e98d[ 2 ] * 2;
    return { #contents:contents, #capsule_height:capsule_height, #capsule_radius:capsule_radius };
}

// Namespace zombie_parasite
// Params 1, eflags: 0x4
// Checksum 0x7b6f6ff1, Offset: 0xea7
// Size: 0x285
function private function_d7992cb3cc217ca4( params )
{
    up_vector = ( 0, 0, 1 );
    trace_params = get_capsule_trace_params();
    trace_start = self.origin + 8 * up_vector - 16 * anglestoforward( self.angles );
    var_b58f7ac37034dbb9 = 8 + self.var_ed3c19fec55b26cc + 8;
    trace_result = trace::capsule_trace( trace_start, trace_start - var_b58f7ac37034dbb9 * up_vector, trace_params.capsule_radius, trace_params.capsule_height, undefined, self, trace_params.contents );
    
    if ( !isdefined( trace_result ) )
    {
        return;
    }
    
    drop_height = trace_result[ "fraction" ] * var_b58f7ac37034dbb9;
    surface_normal = trace_result[ "normal" ];
    is_drop_blocked = drop_height < self.var_ed3c19fec55b26cc;
    var_753ef4c77f0a2bb9 = vectordot( surface_normal, up_vector ) < 0.866;
    self.var_16e99c168b31e75d = is_drop_blocked ? 0 : var_753ef4c77f0a2bb9 ? 1 : 2;
    
    /#
        var_ce53d8f615ce4a2d = getdvarint( @"scr_parasite_debug", 0 ) == 2;
        
        if ( var_ce53d8f615ce4a2d )
        {
            end_position = trace_start - drop_height * up_vector;
            debug_color = is_drop_blocked ? ( 1, 0, 0 ) : var_753ef4c77f0a2bb9 ? ( 1, 1, 0 ) : ( 0, 1, 0 );
            var_d4618b70ea2e3eee = 100;
            cylinder( end_position + trace_params.capsule_radius * up_vector, end_position + ( trace_params.capsule_height - trace_params.capsule_radius ) * up_vector, trace_params.capsule_radius, debug_color, 1, var_d4618b70ea2e3eee );
            sphere( end_position + trace_params.capsule_radius * up_vector, trace_params.capsule_radius, debug_color, 1, var_d4618b70ea2e3eee );
            sphere( end_position + ( trace_params.capsule_height - trace_params.capsule_radius ) * up_vector, trace_params.capsule_radius, debug_color, 1, var_d4618b70ea2e3eee );
            line( trace_start, end_position, debug_color, 1, 1, var_d4618b70ea2e3eee );
            
            if ( var_753ef4c77f0a2bb9 )
            {
                line( end_position, end_position + 10 * surface_normal, ( 1, 1, 0 ), 1, 1, var_d4618b70ea2e3eee );
            }
        }
    #/
}

// Namespace zombie_parasite
// Params 1, eflags: 0x4
// Checksum 0xa1891a40, Offset: 0x1134
// Size: 0x137
function private play_death_fx( params )
{
    body = zombie_utils::function_4e99fb1239980783( params );
    utility::function_32b24db3127bff40( "base", "base_off" );
    utility::function_32b24db3127bff40( "spit", "death" );
    
    if ( isdefined( body ) && function_a3dd2b45bc71cd28( params.eattacker.currentprimaryweapon ) )
    {
        body endon( #"corpse_deleted" );
        body callback::callback( "on_annihilated" );
        body utility::function_32b24db3127bff40( "death", "death_annihilate" );
        wait 0.05;
        body delete();
        return;
    }
    
    if ( isdefined( body ) )
    {
        body utility::function_32b24db3127bff40( "death", "death" );
        
        if ( utility::ent_flag( "burned" ) )
        {
            body utility::function_32b24db3127bff40( "burned", "burned_on" );
            body thread function_fc12a24729ef4e67();
            return;
        }
        
        if ( utility::ent_flag( "napalm_burned" ) )
        {
            body utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on" );
            body thread function_a67c6606a684a2dd();
            return;
        }
        
        if ( utility::ent_flag( "dissolve_purple" ) )
        {
            body utility::function_32b24db3127bff40( "reveal_death_purple", "reveal_death_purple" );
        }
    }
}

// Namespace zombie_parasite
// Params 1, eflags: 0x4
// Checksum 0xe8671638, Offset: 0x1273
// Size: 0x49
function private function_7914468a909df6cb( params )
{
    if ( params.shitloc == "head" )
    {
        self.forceannihilate = 1;
    }
    
    level.var_29cbaf753d01265a = int( max( level.var_29cbaf753d01265a - 1, 0 ) );
}

// Namespace zombie_parasite
// Params 1, eflags: 0x4
// Checksum 0x7b5d5a1e, Offset: 0x12c4
// Size: 0xa0
function private on_corpse_annihilated( params )
{
    level endon( #"game_ended" );
    corpse = params.corpse;
    
    if ( isdefined( corpse ) )
    {
        if ( isdefined( params.annihilate_time ) )
        {
            wait_time = params.annihilate_time - level.framedurationseconds;
            
            if ( wait_time >= level.framedurationseconds )
            {
                wait wait_time;
            }
            else
            {
                waittillframeend();
            }
        }
        
        if ( isdefined( corpse ) )
        {
            corpse callback::callback( "on_annihilated" );
            corpse utility::function_32b24db3127bff40( "death", "death_annihilate" );
        }
    }
}

// Namespace zombie_parasite
// Params 1, eflags: 0x4
// Checksum 0x58956703, Offset: 0x136c
// Size: 0x30
function private on_zombie_turned( var_75e7c1be4fd022be )
{
    zombie_utils::function_a8ce00e0448cb6f0( "sprint", "turned", 26 );
    utility::function_32b24db3127bff40( "brainrot", "brainrot_on" );
}

// Namespace zombie_parasite
// Params 1, eflags: 0x4
// Checksum 0xfa66e713, Offset: 0x13a4
// Size: 0x1d
function private function_91e753b101229a2( s_burn_effect )
{
    utility::function_32b24db3127bff40( "poisoned", "poisoned_on" );
}

// Namespace zombie_parasite
// Params 1, eflags: 0x4
// Checksum 0xc7268513, Offset: 0x13c9
// Size: 0x29
function private function_8c2a60ae74d8ce34( s_burn_effect )
{
    utility::ent_flag_clear( "poisoned" );
    utility::function_7c10ea82c1e305b8( "poisoned", "poisoned_off" );
}

// Namespace zombie_parasite
// Params 1, eflags: 0x4
// Checksum 0x11434d0, Offset: 0x13fa
// Size: 0x1d
function private function_9a92f215ba32b261( s_burn_effect )
{
    utility::function_32b24db3127bff40( "wraith_burned", "wraith_burned_on" );
}

// Namespace zombie_parasite
// Params 1, eflags: 0x4
// Checksum 0xbdbb6b7b, Offset: 0x141f
// Size: 0x29
function private function_c9afe0de75edf987( s_burn_effect )
{
    utility::ent_flag_clear( "wraith_burned" );
    utility::function_7c10ea82c1e305b8( "wraith_burned", "wraith_burned_off" );
}

// Namespace zombie_parasite
// Params 1, eflags: 0x4
// Checksum 0x4c7c682a, Offset: 0x1450
// Size: 0x3f
function private function_2080c9a8a657bc17( s_burn_effect )
{
    var_7dddc60e0205506b = s_burn_effect.var_7dddc60e0205506b ?? "";
    utility::function_32b24db3127bff40( "burned" + var_7dddc60e0205506b, "burned_on" );
}

// Namespace zombie_parasite
// Params 1, eflags: 0x4
// Checksum 0x5f8a4324, Offset: 0x1497
// Size: 0x3f
function private function_ef6cb4c9a207699d( s_burn_effect )
{
    var_7dddc60e0205506b = s_burn_effect.var_7dddc60e0205506b ?? "";
    utility::function_32b24db3127bff40( "burned" + var_7dddc60e0205506b, "burned_off" );
}

// Namespace zombie_parasite
// Params 0, eflags: 0x4
// Checksum 0x9765c855, Offset: 0x14de
// Size: 0x25
function private function_fc12a24729ef4e67()
{
    self endon( #"corpse_deleted" );
    wait 3;
    utility::function_7c10ea82c1e305b8( "burned", "burned_off" );
}

// Namespace zombie_parasite
// Params 1, eflags: 0x4
// Checksum 0xb5aac891, Offset: 0x150b
// Size: 0x1d
function private function_2b8879e19ccaeef3( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on" );
}

// Namespace zombie_parasite
// Params 1, eflags: 0x4
// Checksum 0xd3436531, Offset: 0x1530
// Size: 0x1d
function private function_aa4be0297708a8fa( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on_thermite" );
}

// Namespace zombie_parasite
// Params 1, eflags: 0x4
// Checksum 0xcc94cff7, Offset: 0x1555
// Size: 0x1d
function private function_8b959aabb4069e99( s_burn_effect )
{
    utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_off" );
}

// Namespace zombie_parasite
// Params 1, eflags: 0x4
// Checksum 0x6eeda431, Offset: 0x157a
// Size: 0x37
function private function_7fdc2971cce4b3f4( params )
{
    if ( isdefined( params ) && isdefined( params.height ) )
    {
        self function_786bb6aa1b76c7ee( "vortex_pull_height", params.height );
    }
}

// Namespace zombie_parasite
// Params 1, eflags: 0x4
// Checksum 0xa7125878, Offset: 0x15b9
// Size: 0x18
function private on_vortex_pull_ended( params )
{
    self function_786bb6aa1b76c7ee( "vortex_pull_height", 0 );
}

// Namespace zombie_parasite
// Params 1, eflags: 0x4
// Checksum 0xb0a04b5c, Offset: 0x15d9
// Size: 0xad
function private function_c0ba65f988769d23( params )
{
    self endon( #"death" );
    self hide();
    val::set( "air_spawn", "damage", 0 );
    val::set( "air_spawn", "ignoreme", 1 );
    
    if ( utility::fxexists( "parasite_air_spawn_fx" ) )
    {
        playfx( utility::getfx( "parasite_air_spawn_fx" ), self.origin, anglestoforward( self.angles ) );
    }
    
    utility::waittill_any_timeout( 5, "spawn_end", "emerge" );
    self show();
    utility::function_7c10ea82c1e305b8( "air_spawned", "spawned" );
    val::reset_all( "air_spawn" );
}

// Namespace zombie_parasite
// Params 1, eflags: 0xc
// Checksum 0x31d7dc11, Offset: 0x168e
// Size: 0x4b
function private function_8413fe65c2c3e908( attractor_entity )
{
    self notify( #"hash_5a290321fd9e940c" );
    self endon( #"hash_5a290321fd9e940c" );
    self endon( #"death" );
    self setentitytarget( attractor_entity );
    self waittill( #"hash_eac322c10971ee73" );
    self clearentitytarget();
}

// Namespace zombie_parasite
// Params 1, eflags: 0x4
// Checksum 0x7c3f7ef0, Offset: 0x16e1
// Size: 0x70
function private function_9872c82a9b7e0705( params )
{
    target_attractor = params.target_attractor;
    
    if ( target_attractor.var_927d86585b9a5ff7 )
    {
        attractor_entity = target_attractor.source;
        
        if ( isent( attractor_entity ) && !issentient( attractor_entity ) )
        {
            thread function_8413fe65c2c3e908( attractor_entity );
            return;
        }
    }
    
    self notify( #"hash_eac322c10971ee73" );
}

// Namespace zombie_parasite
// Params 1, eflags: 0x4
// Checksum 0x2d04bd2a, Offset: 0x1759
// Size: 0x18
function private function_a81b0e7a075c2d38( params )
{
    self notify( #"hash_eac322c10971ee73" );
}

// Namespace zombie_parasite
// Params 1, eflags: 0x4
// Checksum 0x2ebe78b8, Offset: 0x1779
// Size: 0x60
function private function_14dfc509496c969e( params )
{
    if ( !isdefined( params.rate ) )
    {
        return;
    }
    
    if ( params.rate < 0.5 )
    {
        utility::function_7c10ea82c1e305b8( "wingflap_audio", "off" );
        return;
    }
    
    if ( !zombie_stun::is_stunned() )
    {
        utility::function_7c10ea82c1e305b8( "wingflap_audio", "on" );
    }
}

// Namespace zombie_parasite
// Params 1, eflags: 0xc
// Checksum 0xb9c6ad0a, Offset: 0x17e1
// Size: 0x55
function private function_c4d265f2504cf861( duration )
{
    self notify( #"hash_f9c9c02f16137bb2" );
    self endon( #"hash_f9c9c02f16137bb2" );
    self endon( #"death" );
    utility::function_7c10ea82c1e305b8( "wingflap_audio", "off" );
    wait duration;
    utility::function_7c10ea82c1e305b8( "wingflap_audio", "on" );
}

// Namespace zombie_parasite
// Params 1, eflags: 0x4
// Checksum 0xe888811, Offset: 0x183e
// Size: 0x2e
function private function_c516ef198623fef9( params )
{
    if ( params.duration > 0 )
    {
        thread function_c4d265f2504cf861( params.duration );
    }
}

// Namespace zombie_parasite
// Params 0, eflags: 0x4
// Checksum 0xccc26e8e, Offset: 0x1874
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

// Namespace zombie_parasite
// Params 3, eflags: 0x4
// Checksum 0x157c54b4, Offset: 0x18da
// Size: 0x47
function private function_f52c9285668dba42( damageabsorbed, attacker, smeansofdeath )
{
    if ( damageabsorbed > 0 && isdefined( attacker.var_d3a22902cf4978d5 ) )
    {
        damageabsorbed *= attacker.var_d3a22902cf4978d5;
    }
    
    return damageabsorbed;
}

