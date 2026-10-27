// scripts\common\ai\aitypes\zombie_viper_mini\zombie_viper_mini.gsc  (hash_6a3265fb13279b84.gscc) (size: 11112 Bytes / 0x2b68 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd400f4f6 (3556832502)
// size ...... 11112 (0x2b68)
// includes .. 16  (offset: 0x2684)
// strings ... 78  (offset: 0x2704)
// dev strs .. 0   (offset: 0x2b68)
// exports ... 27  (offset: 0x171c)
// cseg ...... 0x57e + 0x119e (0x171c)
// imports ... 92  (offset: 0x1b54)
// animtree1 . 0   (offset: 0x2b68)
// animtree2 . 0   (offset: 0x2b68)
#using script_16ea1b94f0f381b3;
#using script_9add55567111158;
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_projectile_attack;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_viper_mini\zombie_viper_mini_audio;
#using scripts\common\ai\aitypes\zombie_viper_mini\zombie_viper_mini_shield;
#using scripts\common\callbacks;
#using scripts\common\metabone;
#using scripts\common\shellshock_utility;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_viper_mini;

// Namespace zombie_viper_mini
// Params 2
// Checksum 0x89144175, Offset: 0x59c
// Size: 0x80
function precache( classname, aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    zombie_projectile_attack::precache( aitypescriptbundle );
    namespace_55d38ee0bc42059f::precache( aitypescriptbundle );
    var_22e5e17527a4b653 = getscriptbundle( "zombieaisettings:" + aitypescriptbundle.zombieaisetting );
    
    if ( isdefined( var_22e5e17527a4b653.var_797c1121c94f9afb ) )
    {
        utility::add_fx( "zombie_viper_mini_damage_impact_shield", var_22e5e17527a4b653.var_797c1121c94f9afb );
    }
}

// Namespace zombie_viper_mini
// Params 1, eflags: 0x4
// Checksum 0x9623928b, Offset: 0x624
// Size: 0x1fa
function private function_b80edc60f9e6ee6f( params )
{
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &play_death_fx );
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_damaged", &function_41e3bd7068227e98 );
    callback::get_template( self.animsetname ) callback::add( "on_turned", &on_zombie_turned );
    callback::get_template( self.animsetname ) callback::add( "on_brainrot_end", &function_16751232a9e10970 );
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
    zombie_projectile_attack::init_global();
    zombie_viper_mini_audio::init_global();
}

// Namespace zombie_viper_mini
// Params 1
// Checksum 0x13b3bb2b, Offset: 0x826
// Size: 0xb0
function function_bc5712cc209b5631( taskid )
{
    assert( isdefined( self.zombieaisetting ) );
    callback::add( "on_first_ai_init", &function_b80edc60f9e6ee6f );
    callback::add( "on_move_speed_changed", &on_move_speed_changed );
    zombie_init::function_5d23979c4c7c9a52( self.zombieaisetting );
    zombie_projectile_attack::init();
    zombie_viper_mini_audio::init();
    self.var_cdf48282bb6d1237 = 75;
    self.allowstrafe = 0;
    self function_786bb6aa1b76c7ee( "float_move_skip_intro_anim", 1 );
    thread init_scriptable();
    thread self_destruct_watcher();
    self._blackboard.var_3b99c1a3e6725c32 = 1.05;
    return anim.success;
}

// Namespace zombie_viper_mini
// Params 0, eflags: 0x4
// Checksum 0x2caa1a30, Offset: 0x8df
// Size: 0x7d
function private init_scriptable()
{
    self endon( #"death" );
    waitframe();
    
    if ( !self.var_92ac8cd80988b8be && utility::callsharedfunc( #"ai", #"hash_eeabeb442ca0054", "spawn_portal" ) )
    {
        thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "spawn_portal", "spawn_portal", undefined, undefined, "spawn_animating" );
    }
    
    utility::flag_wait( "scriptables_ready" );
    waitframe();
    
    if ( self.b_invisible )
    {
        return;
    }
    
    thread spawn_reveal();
    thread manage_strafe();
}

// Namespace zombie_viper_mini
// Params 0, eflags: 0x4
// Checksum 0x811e08ac, Offset: 0x964
// Size: 0xcb
function private spawn_reveal()
{
    self endon( #"death" );
    utility::function_32b24db3127bff40( "base", "base_on" );
    
    if ( !self.var_92ac8cd80988b8be )
    {
        self clearpath();
        self setbtgoalstationary( 0 );
        self function_786bb6aa1b76c7ee( "in_spawn_reveal", 1 );
        
        if ( !self.disable_spawn_vfx )
        {
            utility::function_32b24db3127bff40( "spawn_reveal", "spawn_reveal" );
        }
        else
        {
            utility::function_32b24db3127bff40( "spawn_reveal", "spawn_reveal_audio_only" );
        }
        
        if ( utility::ent_flag( "stealth_enabled" ) )
        {
            self.stealth_enabled = 0;
        }
        
        wait 1.2;
        self function_f2df0257c63f229( "in_spawn_reveal" );
        utility::function_32b24db3127bff40( "spawn_reveal", "off" );
    }
    
    if ( utility::ent_flag( "stealth_enabled" ) )
    {
        self.stealth_enabled = 1;
    }
}

// Namespace zombie_viper_mini
// Params 1, eflags: 0x4
// Checksum 0xd0f23f2f, Offset: 0xa37
// Size: 0x95
function private play_death_fx( params )
{
    body = zombie_utils::function_4e99fb1239980783( params );
    
    if ( isdefined( body ) )
    {
        body utility::function_32b24db3127bff40( "base", "base_off" );
        
        if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.disableragdoll )
        {
            body utility::function_32b24db3127bff40( "death_reveal", "death_reveal_explo" );
            wait 0.1;
            
            if ( isdefined( body ) )
            {
                body delete();
            }
            
            return;
        }
        
        body utility::function_32b24db3127bff40( "death_reveal", "death_reveal" );
    }
}

// Namespace zombie_viper_mini
// Params 0, eflags: 0x4
// Checksum 0x450a5aae, Offset: 0xad4
// Size: 0x19a
function private manage_strafe()
{
    self endon( #"death" );
    last_move_speed = "run";
    zombie_utils::function_a8ce00e0448cb6f0( "run", "aitype_default", 0 );
    
    while ( true )
    {
        var_7d83f520111c08a5 = isdefined( self._blackboard ) && self._blackboard.var_79b2d8d61c6ef8b1;
        should_strafe = 0;
        desired_move_speed = "run";
        
        if ( !var_7d83f520111c08a5 && isalive( self.enemy ) )
        {
            has_seen_enemy = self seerecently( self.enemy, 1 );
            var_4b2ce735265d99f8 = self.enemy.origin - self.origin;
            dist_sqr = lengthsquared( var_4b2ce735265d99f8 );
            should_strafe = has_seen_enemy && dist_sqr < 2560000;
            
            if ( should_strafe )
            {
                if ( self.var_a4d7ad445f64c817 )
                {
                    var_aae9e7f102accf7b = self pathdisttogoal( 1 );
                    
                    if ( var_aae9e7f102accf7b < 100 )
                    {
                        should_strafe = 0;
                    }
                }
                
                if ( should_strafe && isdefined( self.smartfacingpos ) )
                {
                    var_f47fe178ccb1c333 = self.smartfacingpos - self.origin;
                    
                    if ( vectordot( var_f47fe178ccb1c333, var_4b2ce735265d99f8 ) <= 0 )
                    {
                        should_strafe = 0;
                    }
                }
            }
            
            if ( dist_sqr > 490000 )
            {
                desired_move_speed = "sprint";
            }
        }
        
        self.allowstrafe = should_strafe;
        
        if ( last_move_speed != desired_move_speed )
        {
            last_move_speed = desired_move_speed;
            zombie_utils::function_a8ce00e0448cb6f0( desired_move_speed, "aitype_default", 0 );
        }
        
        waitframe();
    }
}

// Namespace zombie_viper_mini
// Params 1, eflags: 0x4
// Checksum 0xa2e934a2, Offset: 0xc76
// Size: 0x38
function private on_move_speed_changed( params )
{
    if ( asm::asm_currentstatehasflag( self.asmname, "move" ) )
    {
        asm::asm_fireevent_internal( self.asmname, "loop_reroll_anim" );
    }
}

// Namespace zombie_viper_mini
// Params 1, eflags: 0x4
// Checksum 0x705b4d1, Offset: 0xcb6
// Size: 0x31
function private function_41e3bd7068227e98( params )
{
    if ( params.metabonename == "chest_reactor" )
    {
        utility::function_32b24db3127bff40( "reactor_impact", "reactor_impact" );
    }
}

// Namespace zombie_viper_mini
// Params 0, eflags: 0x4
// Checksum 0xa69d749f, Offset: 0xcef
// Size: 0x1dc
function private self_destruct_watcher()
{
    self endon( #"death" );
    self endon( #"cancel_self_destruct" );
    self function_786bb6aa1b76c7ee( "self_destruct_health_threshold", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_504bea73f92e7263 );
    self waittill( #"self_destruct_approach" );
    self.self_destruct_initiated = 1;
    self setscriptablepartstate( "self_destruct", "start" );
    self setscriptablepartstate( "base", "self_destruct" );
    
    if ( !self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_b17258776a94529f )
    {
        zombie_viper_mini_shield::activate_chest_reactor_shield( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_504bea73f92e7263 );
    }
    
    metabone::set_metabone_state( "chest_reactor", "exposed" );
    metabone::set_metabone_active( "chest_reactor", 1 );
    zombie_utils::function_a8ce00e0448cb6f0( "sprint", "self_destruct", 30 );
    thread zombie_knockdown::function_a0c03faf3694150c();
    zombie_viper_mini_audio::function_726ea9c78a3aeb64();
    utility::waittill_any_timeout( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.selfdestructtimeout, "self_destruct" );
    self function_70576dbab4f88e19( #"hash_c8d360d1e1c9a480", 1 );
    self setscriptablepartstate( "self_destruct", "rise" );
    asm::function_7256f5ba459c840b( "self_destruct_in" );
    msg = utility::waittill_any_timeout( 5, "self_destruct_explode" );
    
    if ( msg != "timeout" )
    {
        self setscriptablepartstate( "self_destruct", "explode" );
        self_destruct_explode();
        wait 0.2;
    }
    
    if ( isalive( self ) )
    {
        self.nocorpse = 1;
        
        if ( self.magic_bullet_shield )
        {
            ai::stop_magic_bullet_shield();
        }
        
        if ( val::get( "damageshield" ) )
        {
            val::nuke( "damageshield" );
        }
        
        self kill();
    }
}

// Namespace zombie_viper_mini
// Params 1, eflags: 0x4
// Checksum 0x18a062ae, Offset: 0xed3
// Size: 0x523
function private self_destruct_explode( damage_point )
{
    damage_radius = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.selfdestructdamageradius;
    rumble_radius = max( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.selfdestructrumbleradius, damage_radius );
    var_73ab0f5e7a91fe45 = max( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_27fca7ff87fe5434, damage_radius );
    player_damage = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.selfdestructplayerdamage * ( self.var_fe048a2106d8ef00[ #"self_destruct" ] ?? 1 );
    damage_point = self.origin;
    self.var_cab75db7e9e5b64c = undefined;
    players = namespace_9d8e359c3b1041e5::getplayersinradiussharedfunc( damage_point, rumble_radius );
    
    if ( players.size > 0 )
    {
        foreach ( player in players )
        {
            var_1f1605854588df22 = damage_point - player.origin;
            var_27419f7ebc5d2950 = lengthsquared( var_1f1605854588df22 );
            var_c14efa20e5f66fa4 = var_27419f7ebc5d2950 <= squared( damage_radius );
            var_8eba82ead0f19157 = 0;
            
            if ( var_c14efa20e5f66fa4 )
            {
                var_29d80535d06f807a = player utility::function_f02ebab438642e16( "prone" );
                contents = trace::create_contents( 0, 1, 1, 1, 0, 1, 1 );
                var_8eba82ead0f19157 = trace::ray_trace_passed( damage_point, var_29d80535d06f807a, undefined, contents );
                
                if ( var_8eba82ead0f19157 )
                {
                    player utility::knockback_flat( player.origin - damage_point, 400 );
                    player earthquakeforplayer( 0.8, 0.8, damage_point, damage_radius );
                    player playrumbleonentity( "heavy_1s" );
                    player thread shellshock_utility::bloodmeleeeffect();
                    player shellshock_utility::_shellshock( %"shock_zombie_viper_mini", #"explosion", 2 );
                    player dodamage( player_damage, damage_point, self, self, "MOD_EXPLOSIVE", "<explicitweaponnone>", undefined, undefined, 65536 );
                }
            }
            
            if ( !var_8eba82ead0f19157 )
            {
                player playrumbleonentity( "light_1s" );
                player earthquakeforplayer( 0.4, 0.8, damage_point, rumble_radius );
            }
        }
    }
    
    ai_in_radius = getaiarrayinradius( damage_point, var_73ab0f5e7a91fe45 );
    
    foreach ( ai in ai_in_radius )
    {
        if ( isalive( ai ) && ai != self && ai.subclass != "zombie_viper_mini_hvt_wwq" && ai.subclass != "zombie_viper_hvt_wwq_for" )
        {
            if ( ( !isdefined( ai.aicategory ) || ai.aicategory == "normal" ) && !ai zombie_knockdown::function_19d6107cb6bdff5c() )
            {
                ai zombie_knockdown::function_6fc167d4a3590991( damage_point );
            }
            
            var_27419f7ebc5d2950 = distancesquared( damage_point, ai.origin );
            var_c14efa20e5f66fa4 = var_27419f7ebc5d2950 <= squared( damage_radius );
            ai_damage_test = ai.maxhealth * 0.1;
            
            if ( var_c14efa20e5f66fa4 )
            {
                if ( ai.aicategory == "elite" || ai.aicategory == "hvt" )
                {
                    ai_damage = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_3066be23909978f2 * ai.maxhealth;
                }
                else if ( ai.aicategory == "special" )
                {
                    ai_damage = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_6477332c3d506a52 * ai.maxhealth;
                }
                else
                {
                    ai_damage = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_166c9c31a990125a * ai.maxhealth;
                }
                
                ai.var_c513c9032dfc2f0d = self.subclass;
                ai.var_cda6c8bc587acedf = self.a_n_player_damage;
                ai dodamage( ai_damage, damage_point, self, self, "MOD_EXPLOSIVE", "<explicitweaponnone>" );
                
                if ( isalive( ai ) )
                {
                    ai.var_c513c9032dfc2f0d = undefined;
                    ai.var_cda6c8bc587acedf = undefined;
                }
            }
        }
    }
    
    var_6f88a6bfefadea5e = { #damage_point:damage_point, #attacker:self };
    level callback::callback( #"hash_ed1524659474f73", var_6f88a6bfefadea5e );
}

// Namespace zombie_viper_mini
// Params 0
// Checksum 0x72a7929a, Offset: 0x13fe
// Size: 0x65
function force_self_destruct()
{
    if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_504bea73f92e7263 > 0 )
    {
        self.health = int( min( self.health, self.maxhealth * self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_504bea73f92e7263 ) );
    }
}

// Namespace zombie_viper_mini
// Params 0
// Checksum 0xeb8e5b02, Offset: 0x146b
// Size: 0x74
function force_shield()
{
    zombie_viper_mini_shield::activate_chest_reactor_shield( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_504bea73f92e7263 );
    utility::function_32b24db3127bff40( "chest_reactor_armor", "destroyed" );
    metabone::set_metabone_state( "chest_reactor_armor", "destroyed" );
    metabone::set_metabone_active( "chest_reactor_armor", 0 );
    metabone::set_metabone_state( "chest_reactor", "exposed" );
    metabone::set_metabone_active( "chest_reactor", 1 );
}

// Namespace zombie_viper_mini
// Params 1, eflags: 0x4
// Checksum 0x91cd9806, Offset: 0x14e7
// Size: 0x1d
function private on_zombie_turned( var_75e7c1be4fd022be )
{
    utility::function_32b24db3127bff40( "brainrot", "brainrot_on" );
}

// Namespace zombie_viper_mini
// Params 1, eflags: 0x4
// Checksum 0x53720811, Offset: 0x150c
// Size: 0x1d
function private function_16751232a9e10970( params )
{
    utility::function_7c10ea82c1e305b8( "brainrot", "brainrot_off" );
}

// Namespace zombie_viper_mini
// Params 1, eflags: 0x4
// Checksum 0x8b9a6ed8, Offset: 0x1531
// Size: 0x1d
function private function_ce4fe5b7b95b73f6( s_shock_effect )
{
    utility::function_32b24db3127bff40( "shocked", "shocked_on" );
}

// Namespace zombie_viper_mini
// Params 1, eflags: 0x4
// Checksum 0x1c0bc968, Offset: 0x1556
// Size: 0x1d
function private function_f8cbef2738adcd18( s_shock_effect )
{
    utility::function_7c10ea82c1e305b8( "shocked", "shocked_off" );
}

// Namespace zombie_viper_mini
// Params 1, eflags: 0x4
// Checksum 0xec24ea44, Offset: 0x157b
// Size: 0x1d
function private function_91e753b101229a2( s_burn_effect )
{
    utility::function_32b24db3127bff40( "poisoned", "poisoned_on" );
}

// Namespace zombie_viper_mini
// Params 1, eflags: 0x4
// Checksum 0xd1648844, Offset: 0x15a0
// Size: 0x29
function private function_8c2a60ae74d8ce34( s_burn_effect )
{
    utility::ent_flag_clear( "poisoned" );
    utility::function_7c10ea82c1e305b8( "poisoned", "poisoned_off" );
}

// Namespace zombie_viper_mini
// Params 1, eflags: 0x4
// Checksum 0x17563987, Offset: 0x15d1
// Size: 0x1d
function private function_9a92f215ba32b261( s_burn_effect )
{
    utility::function_32b24db3127bff40( "wraith_burned", "wraith_burned_on" );
}

// Namespace zombie_viper_mini
// Params 1, eflags: 0x4
// Checksum 0xabf9662c, Offset: 0x15f6
// Size: 0x29
function private function_c9afe0de75edf987( s_burn_effect )
{
    utility::ent_flag_clear( "wraith_burned" );
    utility::function_7c10ea82c1e305b8( "wraith_burned", "wraith_burned_off" );
}

// Namespace zombie_viper_mini
// Params 1, eflags: 0x4
// Checksum 0x5a3e657d, Offset: 0x1627
// Size: 0x3f
function private function_2080c9a8a657bc17( s_burn_effect )
{
    var_7dddc60e0205506b = s_burn_effect.var_7dddc60e0205506b ?? "";
    utility::function_32b24db3127bff40( "burned" + var_7dddc60e0205506b, "burned_on" );
}

// Namespace zombie_viper_mini
// Params 1, eflags: 0x4
// Checksum 0xa83b9ebc, Offset: 0x166e
// Size: 0x3f
function private function_ef6cb4c9a207699d( s_burn_effect )
{
    var_7dddc60e0205506b = s_burn_effect.var_7dddc60e0205506b ?? "";
    utility::function_7c10ea82c1e305b8( "burned" + var_7dddc60e0205506b, "burned_off" );
}

// Namespace zombie_viper_mini
// Params 1, eflags: 0x4
// Checksum 0xa3e8c5c6, Offset: 0x16b5
// Size: 0x1d
function private function_2b8879e19ccaeef3( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on" );
}

// Namespace zombie_viper_mini
// Params 1, eflags: 0x4
// Checksum 0xc5016866, Offset: 0x16da
// Size: 0x1d
function private function_aa4be0297708a8fa( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on_thermite" );
}

// Namespace zombie_viper_mini
// Params 1, eflags: 0x4
// Checksum 0xdad6c2a0, Offset: 0x16ff
// Size: 0x1d
function private function_8b959aabb4069e99( s_burn_effect )
{
    utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_off" );
}

