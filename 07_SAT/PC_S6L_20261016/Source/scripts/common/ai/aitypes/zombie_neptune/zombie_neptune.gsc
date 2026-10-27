// scripts\common\ai\aitypes\zombie_neptune\zombie_neptune.gsc  (hash_630a77a502f15d9e.gscc) (size: 24918 Bytes / 0x6156 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1dbe127c (498995836)
// size ...... 24918 (0x6156)
// includes .. 19  (offset: 0x5cbe)
// strings ... 66  (offset: 0x5d56)
// dev strs .. 1   (offset: 0x614a)
// exports ... 53  (offset: 0x3f1a)
// cseg ...... 0x4bb + 0x3a5f (0x3f1a)
// imports ... 168 (offset: 0x4762)
// animtree1 . 0   (offset: 0x6156)
// animtree2 . 0   (offset: 0x6156)
#using script_68af0df7ea34684e;
#using script_fd54ba823d404ad;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_neptune\zombie_neptune_melee;
#using scripts\common\ai\aitypes\zombie_neptune\zombie_neptune_metabones;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\math;
#using scripts\common\shellshock_utility;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\overlord;

#namespace zombie_neptune;

// Namespace zombie_neptune
// Params 1
// Checksum 0x76cdb464, Offset: 0x4d9
// Size: 0x17
function function_2f461442ab5ed82a( var_8ebabdbe6230b14a )
{
    self.var_359628f853423187 = var_8ebabdbe6230b14a;
}

// Namespace zombie_neptune
// Params 2
// Checksum 0x902a25f0, Offset: 0x4f8
// Size: 0x73
function precache( classname, aitypescriptbundle )
{
    specific_settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( specific_settings )
    {
        utility::add_fx( "ground_slam_ground_impact_vfx", specific_settings.var_b34ca80287f28b13 );
        utility::add_fx( "ground_slam_concussive_wave_vfx", specific_settings.var_cccced5706d662e7 );
        utility::add_fx( "ground_slam_impact_screen_vfx", specific_settings.var_b683f3c2291a38f6 );
    }
}

// Namespace zombie_neptune
// Params 1, eflags: 0x4
// Checksum 0x46d04576, Offset: 0x573
// Size: 0x10a
function private function_47ab8eee43cf9fca( params )
{
    template = callback::get_template( self.animsetname );
    template callback::add( #"on_ai_killed", &on_boss_killed );
    template callback::add( "killed_body_cloned", &play_death_fx );
    template callback::add( #"hash_696b6f168d1d9c5c", &function_661647e972f0e686 );
    zombie_boss_healthbar::function_f50a10314e72caa1( &function_aa647407d5c4af0 );
    zombie_neptune_melee::function_a38858e4f5328064();
    template callback::add( #"on_ai_damaged", &function_ce93de696bf1f34 );
    utility::registersharedfunc( #"zombie_neptune", #"hash_eb8d89c8bd2c4362", &hibernation_start );
    utility::registersharedfunc( #"zombie_neptune", #"hash_cf482ff582551787", &hibernation_end );
    utility::registersharedfunc( #"zombie_neptune", #"hash_de07abc80a636fba", &function_2bb6d4b0c3fecc1a );
    utility::registersharedfunc( #"zombie_neptune", #"hash_5bde7c89509f5672", &set_transition_explode );
}

// Namespace zombie_neptune
// Params 1, eflags: 0x4
// Checksum 0xcb14f4d5, Offset: 0x685
// Size: 0x9f
function private on_boss_killed( params )
{
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player zombie_boss_healthbar::zombie_boss_healthbar_hide();
        }
    }
    
    zombie_neptune_metabones::function_4b681aa0314b80e3();
    level utility::flag_set( "boss_killed" );
}

// Namespace zombie_neptune
// Params 1
// Checksum 0x852628d5, Offset: 0x72c
// Size: 0x32, Type: bool
function can_attack_target( target )
{
    return isalive( target ) && !target.inlaststand && !target.ignoreme;
}

// Namespace zombie_neptune
// Params 1
// Checksum 0x103350bb, Offset: 0x767
// Size: 0x10b
function function_2b29c3dcc52e96d8( taskid )
{
    profilestart();
    assert( isdefined( self.zombieaisetting ) );
    callback::add( "on_first_ai_init", &function_47ab8eee43cf9fca );
    zombie_init::function_5d23979c4c7c9a52( self.zombieaisetting );
    self.disable_brain_rot = 1;
    self.var_cdf48282bb6d1237 = 100;
    self.allowstrafe = 0;
    self.n_fight_phase = 1;
    self.var_13518fb33ec73cc = 30;
    self.var_317816f65dd8fd6c = 2;
    self.noragdoll = 1;
    self.script_noragdoll = 1;
    self.var_190f8e8daa83f8c = 1;
    self.var_7ee152b43c7188e1 = 1;
    self.nocorpse = undefined;
    self.allowfriendlyfire = 1;
    self pushplayer( 1 );
    self disableaimassist();
    thread init_scriptable();
    thread manage_strafe();
    thread function_1f626596bfbcff38();
    init_behavior_data();
    thread init_difficulty_changes();
    zombie_neptune_melee::init_zombie_neptune_melee();
    zombie_neptune_metabones::init_zombie_neptune_metabones();
    profilestop();
    return anim.success;
}

// Namespace zombie_neptune
// Params 0, eflags: 0x4
// Checksum 0xd1d47072, Offset: 0x87c
// Size: 0x91
function private init_scriptable()
{
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    waitframe();
    
    if ( self.b_invisible )
    {
        return;
    }
    
    utility::function_32b24db3127bff40( "base", "base_phase1" );
    
    if ( !self.suppress_minimap_icon )
    {
        utility::function_32b24db3127bff40( "boss_icon", "phase1" );
    }
    
    utility::function_32b24db3127bff40( "eye", "on_1" );
    utility::function_32b24db3127bff40( "movement", "on_1" );
    utility::function_32b24db3127bff40( "spawn", "on" );
    thread function_81de786f9b4262c9();
}

// Namespace zombie_neptune
// Params 0, eflags: 0x4
// Checksum 0xe5c33a00, Offset: 0x915
// Size: 0x58
function private function_81de786f9b4262c9()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        utility::waittill_any_in_array( [ "spawn_end", "neptune_hibernation_end" ] );
        behavior_start_cooldown( "Common" );
        
        if ( self.n_fight_phase >= 3 )
        {
            return;
        }
    }
}

// Namespace zombie_neptune
// Params 0, eflags: 0x4
// Checksum 0x104d51ed, Offset: 0x975
// Size: 0x107
function private init_behavior_data()
{
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    self.behaviors = [];
    self.behaviors[ "Common" ] = function_45299cf5b695870a( settings.commoncooldown, undefined );
    self.behaviors[ "SpeedBoost" ] = function_45299cf5b695870a( settings.speedboostcooldown, settings.speedboostduration );
    self.behaviors[ "GroundSlam" ] = function_45299cf5b695870a( settings.var_c244b0bc3f1e4031, undefined );
    self.behaviors[ "GroundSlamMulti" ] = function_45299cf5b695870a( settings.var_9cc82db0f518d78, undefined );
    self.behaviors[ "ThrowRocks" ] = function_45299cf5b695870a( settings.var_deb702555f053bf5, undefined );
    self.behaviors[ "CheckForLargeRockAoe" ] = function_45299cf5b695870a( settings.var_deb702555f053bf5 * 0.5, undefined );
}

// Namespace zombie_neptune
// Params 0, eflags: 0x4
// Checksum 0x6235743e, Offset: 0xa84
// Size: 0x49f
function private init_difficulty_changes()
{
    self.neptune_damage_scalar = 1;
    
    if ( isdefined( level.directed_mode ) || getdvarint( @"hash_b397850099975023", 0 ) )
    {
        switch ( level.players.size )
        {
            case 1:
            case 2:
                var_3c6bbda7968697b = 0.35;
                break;
            default:
                var_3c6bbda7968697b = 0.25;
                break;
        }
        
        ai::set_ai_max_health( int( self.maxhealth * var_3c6bbda7968697b ) );
        self.var_9dd11279d5e371c7 *= var_3c6bbda7968697b;
        self.health = self.maxhealth;
        self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_3f3464bd27e1fca5 *= getdvarfloat( @"hash_26ad59e009f7cbfc", 1 );
        self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_fd30fc2c42eaf0d2 *= getdvarfloat( @"hash_543f72aff2340885", 1 );
        self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_3f736ab24483c153 *= getdvarfloat( @"hash_d3bb24c3f10fbbae", 1 );
        self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_b954b4bb5b2ca820 *= getdvarfloat( @"hash_ceda89f54295e7dc", 0.85 );
        self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_f5dff19e7e31971d *= getdvarfloat( @"hash_366cf5faba94203b", 0.85 );
        self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_6b74d55315902350 *= getdvarfloat( @"hash_f1b2179c07b70033", 0.85 );
        self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_5195a386770990a2 *= getdvarfloat( @"hash_8ad65c10188ab975", 0.85 );
        self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_7dd6e862fc7ed6b5 *= getdvarfloat( @"hash_34c5d70d0529c340", 0.85 );
        self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_7fbeda66536f327b *= getdvarfloat( @"hash_6def65e949accd96", 0.85 );
        self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_83b0766f821a32a *= getdvarfloat( @"hash_a160596e2999ef9", 0.85 );
        self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_ff8be28c4f205768 *= getdvarfloat( @"hash_3e18f842d4e6f9ff", 0.85 );
        self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_a1a411b0c824e59c *= getdvarfloat( @"hash_fa9575d488b3ea17", 0.6 );
        return;
    }
    
    round_difficulty = zombie_utils::get_zombie_round_difficulty();
    
    if ( round_difficulty >= 100 )
    {
        self.var_5dcdf9e6531ec8a8 = 0;
        self.var_c4e05d5d2ab0f78f = 2;
        self.neptune_damage_scalar = 1.25;
    }
}

// Namespace zombie_neptune
// Params 2, eflags: 0x4
// Checksum 0x3db61d45, Offset: 0xf2b
// Size: 0x50
function private function_45299cf5b695870a( cooldown_sec, duration_sec )
{
    behavior = spawnstruct();
    behavior.cooldown_sec = cooldown_sec;
    behavior.duration_sec = duration_sec;
    behavior.var_5a4e1b29b5d9d41a = 0;
    return behavior;
}

// Namespace zombie_neptune
// Params 1, eflags: 0x4
// Checksum 0xd114182e, Offset: 0xf84
// Size: 0x66, Type: bool
function private function_f6c349069f5e79ab( behavior )
{
    if ( self.behaviors[ behavior ].var_5a4e1b29b5d9d41a == 0 )
    {
        return false;
    }
    
    if ( gettime() - self.behaviors[ behavior ].var_5a4e1b29b5d9d41a < self.behaviors[ behavior ].cooldown_sec * 1000 )
    {
        return true;
    }
    
    return false;
}

// Namespace zombie_neptune
// Params 1, eflags: 0x4
// Checksum 0x548a5f43, Offset: 0xff3
// Size: 0x27
function private behavior_start_cooldown( behavior )
{
    self.behaviors[ behavior ].var_5a4e1b29b5d9d41a = gettime();
}

// Namespace zombie_neptune
// Params 1, eflags: 0x4
// Checksum 0x9efd7a86, Offset: 0x1022
// Size: 0x9d
function private play_death_fx( params )
{
    if ( isdefined( params.body ) )
    {
        params.body endon( #"corpse_deleted" );
        animid = asm::asm_getanim( self.asmname, "death" );
        deathanim = asm::asm_getxanim( "death", animid );
        deathanimlength = getanimlength( deathanim );
        params.body function_dd258a3da9a2b4a1( deathanimlength );
        wait deathanimlength;
        params.body delete();
    }
}

// Namespace zombie_neptune
// Params 0, eflags: 0x4
// Checksum 0xe5728b2e, Offset: 0x10c7
// Size: 0xe7
function private manage_strafe()
{
    self endon( #"death" );
    
    while ( true )
    {
        var_7d83f520111c08a5 = isdefined( self._blackboard ) && self._blackboard.var_79b2d8d61c6ef8b1;
        should_strafe = 0;
        
        if ( !var_7d83f520111c08a5 && can_attack_target( self.enemy ) )
        {
            has_seen_enemy = self seerecently( self.enemy, 5 );
            var_bcd935941a082859 = distancesquared( self.origin, self.enemy.origin ) <= 2560000;
            should_strafe = has_seen_enemy && var_bcd935941a082859;
        }
        
        self.allowstrafe = should_strafe;
        self.var_cdf48282bb6d1237 = self aigetdesiredspeed() * ( should_strafe ? 2 : 1 );
        wait 0.2;
    }
}

// Namespace zombie_neptune
// Params 1, eflags: 0x4
// Checksum 0x368ab03d, Offset: 0x11b6
// Size: 0x9f
function private function_ce93de696bf1f34( params )
{
    if ( !utility::ent_flag( "neptune_phase_disable" ) )
    {
        if ( !self.in_phase_transition && self.n_fight_phase < 3 )
        {
            if ( self.health < self.maxhealth - self.maxhealth / 3 * self.n_fight_phase )
            {
                self.in_phase_transition = 1;
                zombie_neptune_metabones::set_weakpoint_destroyed();
                asm::function_7256f5ba459c840b( "special_pain_in" );
                callback::callback( #"hash_b5e0b8a43edf3a0a" );
                behavior_start_cooldown( "Common" );
            }
        }
    }
}

// Namespace zombie_neptune
// Params 1
// Checksum 0xa0acebd7, Offset: 0x125d
// Size: 0xf9
function function_aa647407d5c4af0( params )
{
    if ( self.var_474e63113b850e5d )
    {
        var_47c35ddc0630df4 = self.maxhealth;
        health_to_show = self.health;
    }
    else
    {
        var_47c35ddc0630df4 = self.maxhealth / 3;
        health_to_show = self.health - var_47c35ddc0630df4 * ( 3 - self.n_fight_phase );
    }
    
    if ( health_to_show <= 0 )
    {
        health_to_show = 0;
    }
    
    foreach ( player in level.players )
    {
        player zombie_boss_healthbar::healthbar_set_health( health_to_show, var_47c35ddc0630df4 );
        player zombie_boss_healthbar::function_db02000f515bd5c6( health_to_show );
    }
}

// Namespace zombie_neptune
// Params 2
// Checksum 0x741a3276, Offset: 0x135e
// Size: 0xd4
function melee_update( taskid, params )
{
    if ( isdefined( self.enemy ) || isdefined( self.var_5c63f9b326faec9a ) )
    {
        disttotargetsq = distancesquared( self.enemy.origin, self.origin );
        moving_melee = namespace_45591fb25244d549::calculate_is_moving_melee( self.var_5c63f9b326faec9a ?? self.enemy );
        
        if ( moving_melee && disttotargetsq <= squared( self.var_94e31772fab0c17b ) )
        {
            return anim.success;
        }
        else if ( !moving_melee && disttotargetsq <= squared( self.var_abf0b408c96a796 ) )
        {
            return anim.success;
        }
    }
    
    return anim.failure;
}

// Namespace zombie_neptune
// Params 2
// Checksum 0xe39e5c7d, Offset: 0x143b
// Size: 0x40b
function function_33bd46e1157defd8( taskid, params )
{
    if ( self function_88d2c65d5eed0e87() <= 0 )
    {
        return anim.failure;
    }
    
    if ( self.var_de0f7ff276508c57 )
    {
        if ( self._blackboard.var_65f32caa86b87a2 )
        {
            return anim.running;
        }
        else
        {
            behavior_start_cooldown( "Common" );
            return anim.success;
        }
    }
    
    self.var_af954c6a58743ed = self.var_373e34e4a1fad173 ?? self.enemy;
    
    if ( !can_attack_target( self.var_af954c6a58743ed ) )
    {
        if ( self.var_af954c6a58743ed == self.var_373e34e4a1fad173 )
        {
            self.var_373e34e4a1fad173 = undefined;
        }
        
        return anim.failure;
    }
    
    if ( !function_243f048b959c59f5( self.var_af954c6a58743ed ) )
    {
        return anim.failure;
    }
    
    if ( self.n_fight_phase > 1 )
    {
        var_9f98f9ebe2d06bf2 = 150;
        var_692061e5cc2c2314 = 70;
        var_ce54a50cafea24a5 = 200;
        var_75faae8630fd0687 = utility::drop_to_ground( self.origin + anglestoforward( self.angles ) * var_692061e5cc2c2314, var_9f98f9ebe2d06bf2 );
        
        if ( abs( self.origin[ 2 ] - var_75faae8630fd0687[ 2 ] ) > var_ce54a50cafea24a5 )
        {
            return anim.failure;
        }
    }
    
    if ( self.var_af954c6a58743ed == self.var_373e34e4a1fad173 )
    {
        self notify( #"hash_83ee5e30f2584fb0" );
        stop_movement();
        self.var_de0f7ff276508c57 = 1;
        return anim.running;
    }
    
    var_f4858b1e2608d933 = self.var_359628f853423187 ?? 2;
    var_5c3d84ae102f3d1b = 2;
    
    if ( !isdefined( self.var_97e71e4e20536fd ) )
    {
        self.var_97e71e4e20536fd = 0;
    }
    
    var_cfbc6efb306cf84a = zombie_neptune_asm::can_aoe() && level.var_8171a2558d74c3e0.size > var_f4858b1e2608d933;
    
    if ( !zombie_neptune_asm::can_aoe() || var_cfbc6efb306cf84a || self.var_97e71e4e20536fd >= var_5c3d84ae102f3d1b )
    {
        if ( function_f6c349069f5e79ab( "Common" ) )
        {
            return anim.failure;
        }
        
        if ( function_f6c349069f5e79ab( "ThrowRocks" ) )
        {
            return anim.failure;
        }
        
        var_23b7c6513e4b95bc = 1;
    }
    else if ( !var_cfbc6efb306cf84a && self.var_97e71e4e20536fd < var_5c3d84ae102f3d1b )
    {
        if ( function_f6c349069f5e79ab( "CheckForLargeRockAoe" ) )
        {
            return anim.failure;
        }
        
        self.var_97e71e4e20536fd++;
    }
    
    if ( gettime() < self.var_fd6a8086655085f8 )
    {
        return anim.failure;
    }
    
    var_b1c6801ab578e761 = 500;
    var_e0ddaaf6b1180c80 = 2;
    var_f141618f57c2f64 = self.var_abf0b408c96a796 * 1.5;
    
    if ( distancesquared( self.origin, self.enemy.origin ) < var_f141618f57c2f64 && self.var_13074e3f42234f07 <= var_e0ddaaf6b1180c80 )
    {
        var_f94281509c5def5 = getdvarfloat( @"hash_346bfd47215d456d", 250 );
        is_recently_damaged = isdefined( self.last_dmg_struct.timehit ) && gettime() - self.last_dmg_struct.timehit < var_f94281509c5def5;
        
        if ( is_recently_damaged )
        {
            self.var_13074e3f42234f07++;
            self.var_fd6a8086655085f8 = gettime() + getdvarfloat( @"hash_acbbc7fe5eed359f", var_b1c6801ab578e761 );
            return anim.failure;
        }
    }
    
    if ( var_23b7c6513e4b95bc && self.var_97e71e4e20536fd >= var_5c3d84ae102f3d1b )
    {
        self.var_97e71e4e20536fd = 0;
    }
    
    behavior_start_cooldown( "ThrowRocks" );
    self notify( #"hash_83ee5e30f2584fb0" );
    stop_movement();
    self.var_de0f7ff276508c57 = 1;
    self.var_13074e3f42234f07 = 0;
    return anim.running;
}

// Namespace zombie_neptune
// Params 2
// Checksum 0x7e95e21d, Offset: 0x184e
// Size: 0x5c
function function_c4aff604d8aefb40( taskid, params )
{
    if ( self.var_af954c6a58743ed == self.var_373e34e4a1fad173 )
    {
        self.var_373e34e4a1fad173 = undefined;
        self function_786bb6aa1b76c7ee( "neptune_throw_faraway_enemy", 0 );
    }
    
    self.var_af954c6a58743ed = undefined;
    recover_movement();
    self.var_de0f7ff276508c57 = undefined;
}

// Namespace zombie_neptune
// Params 1, eflags: 0x4
// Checksum 0xb5c0dd07, Offset: 0x18b2
// Size: 0x429, Type: bool
function private function_243f048b959c59f5( target )
{
    var_b3b6fd15e8ca737f = 30;
    var_257455908776e428 = 55;
    var_4a9c5bc83a480351 = 70;
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    
    switch ( self.n_fight_phase )
    {
        case 1:
            var_1f211e61df818fdc = ( 0, 0, 150 ) + anglestoright( vectortoangles( target.origin - self.origin ) ) * 90;
            self.grenadeweapon = settings.var_5752d6ade6f9d0dc;
            var_5fe784492bbc09fe = var_b3b6fd15e8ca737f;
            break;
        case 2:
            var_1f211e61df818fdc = ( 0, 0, 300 ) + anglestoforward( vectortoangles( target.origin - self.origin ) ) * 50;
            self.grenadeweapon = settings.var_9954d6711e13b266;
            var_5fe784492bbc09fe = var_257455908776e428;
            break;
        case 3:
            var_1f211e61df818fdc = ( 0, 0, 320 ) + anglestoforward( vectortoangles( target.origin - self.origin ) ) * 50;
            self.grenadeweapon = settings.var_8521787d422f164;
            var_5fe784492bbc09fe = var_4a9c5bc83a480351;
            break;
    }
    
    throw_start_pos = self.origin + var_1f211e61df818fdc;
    trace_result = trace::capsule_get_closest_point( throw_start_pos, var_5fe784492bbc09fe, var_5fe784492bbc09fe * 2, undefined, 0, [ self ], trace::create_solid_ai_contents() );
    
    if ( trace_result[ "hittype" ] == "hittype_world" )
    {
        return false;
    }
    
    gravity = self function_88d2c65d5eed0e87() * self.grenadeweapon.var_4b34df4cbe697f89;
    var_267d01d2be2d145 = zombie_neptune_asm::calc_velocity( throw_start_pos, target.origin, gravity );
    var_11b18f1ac6dc624b = var_267d01d2be2d145[ 2 ];
    deltaz = squared( var_11b18f1ac6dc624b ) / 2 * gravity;
    var_cdbee3e0b3f58c66 = throw_start_pos[ 2 ] + deltaz;
    var_2628fd2aed22397b = ( target.origin - throw_start_pos ) * 0.5;
    var_2628fd2aed22397b = throw_start_pos + var_2628fd2aed22397b;
    var_2628fd2aed22397b = ( var_2628fd2aed22397b[ 0 ], var_2628fd2aed22397b[ 1 ], var_cdbee3e0b3f58c66 );
    
    /#
        if ( getdvarfloat( @"hash_9436a16f50968ec2", 0 ) )
        {
            line( throw_start_pos + ( 0, 0, 10 ), var_2628fd2aed22397b, ( 0, 1, 0 ), 1, 0, 5 );
            line( var_2628fd2aed22397b, target.origin + ( 0, 0, 10 ), ( 0, 1, 0 ), 1, 0, 5 );
        }
    #/
    
    contents = trace::create_solid_ai_contents( 1 );
    result = trace::ray_trace( throw_start_pos + ( 0, 0, 10 ), var_2628fd2aed22397b, [ self, target ], contents );
    
    if ( result[ "fraction" ] != 1 )
    {
        return false;
    }
    
    if ( self.n_fight_phase == 1 )
    {
        var_1f211e61df818fdc = ( 0, 0, 150 ) + anglestoleft( vectortoangles( target.origin - self.origin ) ) * 90;
        throw_start_pos = self.origin + var_1f211e61df818fdc;
        
        /#
            if ( getdvarfloat( @"hash_9436a16f50968ec2", 0 ) )
            {
                line( throw_start_pos + ( 0, 0, 10 ), var_2628fd2aed22397b, ( 0, 1, 0 ), 1, 0, 5 );
            }
        #/
        
        result = trace::ray_trace( throw_start_pos + ( 0, 0, 10 ), var_2628fd2aed22397b, [ self, target ], contents );
        
        if ( result[ "fraction" ] != 1 )
        {
            return false;
        }
    }
    
    result = trace::ray_trace( var_2628fd2aed22397b, target.origin + ( 0, 0, 10 ), [ self, target ], contents );
    
    if ( result[ "fraction" ] != 1 )
    {
        return false;
    }
    
    return true;
}

// Namespace zombie_neptune
// Params 2
// Checksum 0xd9cadb79, Offset: 0x1ce4
// Size: 0xd5
function speedboost_update( taskid, params )
{
    if ( self.n_fight_phase < 3 )
    {
        return anim.failure;
    }
    
    if ( self.start_speed_boost )
    {
        if ( self getaiblackboarddynamic( "in_speed_boost" ) )
        {
            return anim.running;
        }
        else
        {
            behavior_start_cooldown( "Common" );
            return anim.success;
        }
    }
    
    if ( function_f6c349069f5e79ab( "Common" ) )
    {
        return anim.failure;
    }
    
    if ( function_f6c349069f5e79ab( "SpeedBoost" ) )
    {
        return anim.failure;
    }
    
    behavior_start_cooldown( "SpeedBoost" );
    thread do_speed_boost();
    stop_movement();
    self.start_speed_boost = 1;
    self function_786bb6aa1b76c7ee( "in_speed_boost", 1 );
    return anim.running;
}

// Namespace zombie_neptune
// Params 2
// Checksum 0x11e9f2ae, Offset: 0x1dc2
// Size: 0x26
function speedboost_terminate( taskid, params )
{
    recover_movement();
    self.start_speed_boost = undefined;
}

// Namespace zombie_neptune
// Params 0
// Checksum 0x457f0848, Offset: 0x1df0
// Size: 0xe7
function do_speed_boost()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    asm::function_7256f5ba459c840b( "speed_boost_in" );
    self waittill( #"speed_boost_end" );
    
    if ( !self.var_d1956a34643e2530 )
    {
        self.var_d1956a34643e2530 = asm::function_27be172b46a89235();
    }
    
    self aisetdesiredspeed( 130 );
    self setscriptablepartstate( "speed_boost", "on" );
    self setscriptablepartstate( "eye", "off" );
    
    while ( true )
    {
        if ( gettime() - self.behaviors[ "SpeedBoost" ].var_5a4e1b29b5d9d41a > self.behaviors[ "SpeedBoost" ].duration_sec * 1000 )
        {
            self aisetdesiredspeed( 70 );
            self setscriptablepartstate( "speed_boost", "to_eye_on_3" );
            self.var_d1956a34643e2530 = undefined;
            return;
        }
        
        wait 0.1;
    }
}

// Namespace zombie_neptune
// Params 1, eflags: 0x4
// Checksum 0xb7585863, Offset: 0x1edf
// Size: 0x8a
function private function_1ee22348ced85e75( ground_contact_point )
{
    up_vec = ( 0, 0, 1 );
    var_2f966e0c4cb4d21f = ground_contact_point + up_vec * 150;
    var_4e3bbb991557ad9c = ground_contact_point + -1 * up_vec * 150;
    var_c563b215b9d1ddb7 = trace::ray_trace( var_2f966e0c4cb4d21f, var_4e3bbb991557ad9c, [ self ], trace::create_solid_ai_contents( 1 ) );
    
    if ( var_c563b215b9d1ddb7[ "hittype" ] != "hittype_none" )
    {
        ground_contact_point = var_c563b215b9d1ddb7[ "position" ];
    }
    
    return ground_contact_point;
}

// Namespace zombie_neptune
// Params 2
// Checksum 0xef6c1a0f, Offset: 0x1f72
// Size: 0x163
function groundslam_update( taskid, params )
{
    if ( self.n_fight_phase <= ( self.var_5dcdf9e6531ec8a8 ?? 1 ) )
    {
        return anim.failure;
    }
    
    if ( self.start_ground_slam )
    {
        if ( self getaiblackboarddynamic( "in_ground_slam" ) )
        {
            return anim.running;
        }
        else
        {
            behavior_start_cooldown( "Common" );
            return anim.success;
        }
    }
    
    if ( function_f6c349069f5e79ab( "Common" ) )
    {
        return anim.failure;
    }
    
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    var_e712924c3e6e72d9 = max( 300, settings.var_e363b985435a2de6 - 100 );
    var_34255da0ea5cb866 = var_e712924c3e6e72d9 * var_e712924c3e6e72d9;
    
    if ( !function_d04162e094e615ac( var_34255da0ea5cb866 ) )
    {
        return anim.failure;
    }
    
    [ can_slam, pitch ] = function_453044a736fb459a();
    
    if ( !can_slam )
    {
        return anim.failure;
    }
    
    self function_a8fe8d86843b9cee( pitch );
    thread do_ground_slam();
    stop_movement();
    self.start_ground_slam = 1;
    self function_786bb6aa1b76c7ee( "in_ground_slam", 1 );
    return anim.running;
}

// Namespace zombie_neptune
// Params 0
// Checksum 0x774cf3f7, Offset: 0x20de
// Size: 0x577
function function_453044a736fb459a()
{
    forward = anglestoforward( self.angles );
    offset = ( 0, 0, 50 );
    dist = 80;
    var_368a210eeb0d1c6e = cos( 50 );
    var_5375d9fd9ef73a20 = 0;
    obstacle_in_front = 0;
    
    if ( self.n_fight_phase == 3 )
    {
        offset = ( 0, 0, 70 );
        dist = 140;
        var_5375d9fd9ef73a20 = 1;
    }
    
    /#
        if ( getdvarint( @"hash_a09a75a71f415bee", 0 ) )
        {
            var_41c5aafc1fd04439 = 1;
        }
        
        if ( getdvarint( @"hash_b183403076c40e9e", 0 ) > 0 )
        {
            offset = ( 0, 0, getdvarint( @"hash_b183403076c40e9e", 0 ) );
        }
        
        if ( getdvarint( @"hash_38d17a976081dab3", 0 ) > 0 )
        {
            dist = getdvarint( @"hash_38d17a976081dab3", 0 );
        }
        
        if ( getdvarint( @"hash_70201637afb38ee2", 0 ) > 0 )
        {
            slope_angle = getdvarint( @"hash_70201637afb38ee2", 0 );
            var_368a210eeb0d1c6e = cos( slope_angle );
        }
    #/
    
    start = self.origin + offset;
    end = start + forward * dist;
    trace_result = trace::ray_trace( start, end, self, trace::create_solid_ai_contents( 1 ) );
    trace_passed = trace_result[ "fraction" ] > 0.95;
    
    if ( !trace_passed )
    {
        up_vector = ( 0, 0, 1 );
        surface_normal = trace_result[ "normal" ];
        
        if ( vectordot( surface_normal, up_vector ) < var_368a210eeb0d1c6e )
        {
            /#
                if ( var_41c5aafc1fd04439 )
                {
                    debug::line( start, end, ( 1, 0, 0 ), 5 );
                }
            #/
            
            return [ 0, 0 ];
        }
        
        dist = trace_result[ "fraction" ] * dist;
    }
    
    /#
        if ( var_41c5aafc1fd04439 )
        {
            debug::line( start, start + forward * dist, ( 0, 1, 0 ), 5 );
        }
    #/
    
    right_dist = 50;
    
    /#
        if ( getdvarint( @"hash_3f27ab58bd0c4ae8", 0 ) > 0 )
        {
            right_dist = getdvarint( @"hash_3f27ab58bd0c4ae8", 0 );
        }
    #/
    
    right = anglestoright( self.angles );
    var_2a40e0063f47037 = start + right * right_dist;
    end_right = var_2a40e0063f47037 + forward * dist;
    trace_passed = trace::ray_trace_passed( var_2a40e0063f47037, end_right, self, trace::create_solid_ai_contents( 1 ) );
    
    /#
        if ( var_41c5aafc1fd04439 )
        {
            debug::line( var_2a40e0063f47037, end_right, trace_passed ? ( 0, 1, 0 ) : ( 1, 0, 0 ), 5 );
        }
    #/
    
    if ( !trace_passed )
    {
        if ( !var_5375d9fd9ef73a20 )
        {
            return [ 0, 0 ];
        }
        else
        {
            obstacle_in_front |= 2;
        }
    }
    
    var_4f853fcbcf44e4ca = start - right * right_dist;
    end_left = var_4f853fcbcf44e4ca + forward * dist;
    trace_passed = trace::ray_trace_passed( var_4f853fcbcf44e4ca, end_left, self, trace::create_solid_ai_contents( 1 ) );
    
    /#
        if ( var_41c5aafc1fd04439 )
        {
            debug::line( var_4f853fcbcf44e4ca, end_left, trace_passed ? ( 0, 1, 0 ) : ( 1, 0, 0 ), 5 );
        }
    #/
    
    if ( !trace_passed )
    {
        if ( !var_5375d9fd9ef73a20 )
        {
            return [ 0, 0 ];
        }
        else
        {
            obstacle_in_front |= 1;
        }
    }
    
    if ( var_5375d9fd9ef73a20 )
    {
        if ( obstacle_in_front & 2 && obstacle_in_front & 1 )
        {
            return [ 0, 0 ];
        }
        
        self function_786bb6aa1b76c7ee( "ground_slam_dir", obstacle_in_front );
    }
    else
    {
        self function_786bb6aa1b76c7ee( "ground_slam_dir", 0 );
    }
    
    var_f0683561707017d6 = 100;
    var_39466e549b32d294 = 200;
    var_bfd5f8bac6416bff = utility::drop_to_ground( self.origin + var_f0683561707017d6 * 0.5 * forward, var_39466e549b32d294, var_39466e549b32d294 * -1 );
    var_bfd5f9bac6416e32 = utility::drop_to_ground( self.origin + var_f0683561707017d6 * forward, var_39466e549b32d294, var_39466e549b32d294 * -1 );
    
    /#
        if ( var_41c5aafc1fd04439 )
        {
            debug::sphere( var_bfd5f8bac6416bff, 5, ( 0, 0, 1 ), 5 );
            debug::sphere( var_bfd5f9bac6416e32, 5, ( 0, 0, 1 ), 5 );
        }
    #/
    
    var_c13caadab138ea87 = angleclamp180( vectortopitch( var_bfd5f8bac6416bff - self.origin ) * -1 );
    var_c13cabdab138ecba = angleclamp180( vectortopitch( var_bfd5f9bac6416e32 - self.origin ) * -1 );
    
    if ( self.n_fight_phase == 3 && abs( var_c13caadab138ea87 ) < 5 && var_c13cabdab138ecba < -40 )
    {
        return [ 0, 0 ];
    }
    
    if ( var_c13caadab138ea87 > 0 && var_c13cabdab138ecba > 0 )
    {
        pitch = max( var_c13caadab138ea87, var_c13cabdab138ecba );
    }
    else if ( var_c13caadab138ea87 < 0 && var_c13cabdab138ecba < 0 )
    {
        pitch = max( var_c13caadab138ea87, var_c13cabdab138ecba );
    }
    else
    {
        pitch = ( var_c13caadab138ea87 + var_c13cabdab138ecba ) * 0.5;
    }
    
    if ( pitch > 45 || pitch < -50 )
    {
        return [ 0, 0 ];
    }
    
    if ( pitch > 15 )
    {
        pitch += 10;
    }
    else if ( pitch < -15 )
    {
        pitch += 10;
    }
    else if ( pitch < -10 )
    {
        pitch += 5;
    }
    
    return [ 1, pitch ];
}

// Namespace zombie_neptune
// Params 2
// Checksum 0xfd7a0e50, Offset: 0x265e
// Size: 0x26
function groundslam_terminate( taskid, params )
{
    recover_movement();
    self.start_ground_slam = undefined;
}

// Namespace zombie_neptune
// Params 0, eflags: 0x4
// Checksum 0x92d370c1, Offset: 0x268c
// Size: 0x107
function private function_1f626596bfbcff38()
{
    self endon( #"death" );
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    var_4b0e4d3472495c2d = utility::function_4b74c15943231980( settings.var_7d40999167602189 );
    
    while ( true )
    {
        self waittill( #"ground_slam_end" );
        
        foreach ( player in level.players )
        {
            if ( isdefined( player.var_71ef7e54d65ba63d ) && gettime() - player.var_71ef7e54d65ba63d >= var_4b0e4d3472495c2d )
            {
                player.var_432977c006af3db0 = undefined;
                player.var_71ef7e54d65ba63d = undefined;
            }
        }
    }
}

// Namespace zombie_neptune
// Params 3, eflags: 0x4
// Checksum 0x673774f8, Offset: 0x279b
// Size: 0x8b, Type: bool
function private function_fa64735d901c5196( main_target_pos, var_b5edb9d32db1f2e0, range_squared )
{
    if ( function_f6c349069f5e79ab( "GroundSlam" ) )
    {
        return false;
    }
    
    if ( self.enemy.inlaststand )
    {
        return false;
    }
    
    var_db0b462881225cb9 = squared( 40 );
    
    if ( distancesquared( self.origin, main_target_pos ) <= range_squared && distancesquared( main_target_pos, var_b5edb9d32db1f2e0 ) <= var_db0b462881225cb9 )
    {
        behavior_start_cooldown( "GroundSlam" );
        return true;
    }
    
    return false;
}

// Namespace zombie_neptune
// Params 3, eflags: 0x4
// Checksum 0x3aa9e9cb, Offset: 0x282f
// Size: 0x79, Type: bool
function private function_7133bf710a8d829d( target_pos, target_ground_pos, range_squared )
{
    if ( function_f6c349069f5e79ab( "GroundSlamMulti" ) )
    {
        return false;
    }
    
    if ( level.players.size <= 1 )
    {
        return false;
    }
    
    var_db0b462881225cb9 = squared( 40 );
    
    if ( distancesquared( self.origin, target_pos ) <= range_squared && distancesquared( target_pos, target_ground_pos ) <= var_db0b462881225cb9 )
    {
        return true;
    }
    
    return false;
}

// Namespace zombie_neptune
// Params 3, eflags: 0x4
// Checksum 0x8a474ded, Offset: 0x28b1
// Size: 0x149, Type: bool
function private function_6a795f1692113518( target, range_squared, is_main_target )
{
    var_6388f3755349f1d1 = 2.5;
    targetvelocity = target getvelocity();
    var_53a1f4017c65ddad = target.origin + targetvelocity * var_6388f3755349f1d1;
    nav_trace_results = navtrace( target.origin, var_53a1f4017c65ddad, undefined, 1 );
    
    if ( isdefined( nav_trace_results[ "position" ] ) && nav_trace_results[ "fraction" ] < 1 )
    {
        var_53a1f4017c65ddad = nav_trace_results[ "position" ];
    }
    
    var_d03a8cf681fcaa04 = utility::drop_to_ground( var_53a1f4017c65ddad, 250 );
    
    /#
        if ( getdvarfloat( @"hash_9436a16f50968ec2", 0 ) )
        {
            sphere( target.origin, 5, ( 1, 0, 0 ), 0, 100 );
            sphere( var_53a1f4017c65ddad, 5, ( 0, 0, 1 ), 0, 100 );
            sphere( var_d03a8cf681fcaa04, 5, ( 0, 1, 0 ), 0, 100 );
        }
    #/
    
    if ( is_main_target && function_fa64735d901c5196( var_53a1f4017c65ddad, var_d03a8cf681fcaa04, range_squared ) )
    {
        return true;
    }
    else if ( !is_main_target && function_7133bf710a8d829d( var_53a1f4017c65ddad, var_d03a8cf681fcaa04, range_squared ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zombie_neptune
// Params 1, eflags: 0x4
// Checksum 0x784d7b35, Offset: 0x2a03
// Size: 0x14a, Type: bool
function private function_d04162e094e615ac( range_squared )
{
    var_af944def739663bf = 3000;
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    var_fd59212f9b3274c1 = 0;
    var_546d1eee960cd044 = self function_f017e352a29a57a1( self.origin, var_af944def739663bf, 1 );
    
    foreach ( enemy in var_546d1eee960cd044 )
    {
        if ( !isalive( enemy ) || enemy.inlaststand )
        {
            continue;
        }
        
        var_99eb17e8c554eb15 = enemy == self.enemy;
        
        if ( function_6a795f1692113518( enemy, range_squared, var_99eb17e8c554eb15 ) )
        {
            behavior_start_cooldown( "GroundSlam" );
            return true;
        }
        
        if ( function_6a795f1692113518( enemy, range_squared, !var_99eb17e8c554eb15 ) )
        {
            var_fd59212f9b3274c1++;
        }
    }
    
    if ( var_fd59212f9b3274c1 >= settings.var_7aa7add610a23a2f )
    {
        behavior_start_cooldown( "GroundSlamMulti" );
        return true;
    }
    
    return false;
}

// Namespace zombie_neptune
// Params 0
// Checksum 0x7821cf27, Offset: 0x2b56
// Size: 0x16f
function do_ground_slam()
{
    self endon( #"death" );
    self endon( #"ground_slam_end" );
    var_76735964bdab362a = 150;
    asm::function_7256f5ba459c840b( "ground_slam_in" );
    thread function_534b542aa5ccf22f( self.angles[ 1 ] );
    
    if ( randomint( 100 ) < 20 )
    {
        level thread overlord::playconversation( "ruby_boss_neptune_ground_slam" );
    }
    
    self waittill( #"ground_slam_impact", impact_tag );
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    
    if ( isdefined( impact_tag ) && self tagexists( impact_tag ) )
    {
        ground_contact_point = self gettagorigin( impact_tag );
    }
    else
    {
        ground_contact_point = self.origin;
    }
    
    var_1ee22348ced85e75 = utility::drop_to_ground( ground_contact_point, var_76735964bdab362a );
    
    /#
        if ( getdvarfloat( @"hash_43623b8eade85d39", 0 ) )
        {
            sphere( ground_contact_point, 25, ( 0, 0, 1 ), 0, 100 );
            sphere( var_1ee22348ced85e75, 30, ( 0, 1, 0 ), 0, 100 );
        }
    #/
    
    radius_ground_impact( var_1ee22348ced85e75, settings.var_e363b985435a2de6, "MOD_EXPLOSIVE", settings.var_b954b4bb5b2ca820, settings.var_f5dff19e7e31971d, settings.var_c5f498ecc084c28a, settings.var_7e7f1f5e93670598, settings.var_fe8dd3226c3899f6, 1 );
}

// Namespace zombie_neptune
// Params 1, eflags: 0x4
// Checksum 0x7c348197, Offset: 0x2ccd
// Size: 0x45
function private function_534b542aa5ccf22f( angle )
{
    self endon( #"death" );
    self endon( #"ground_slam_impact" );
    self endon( #"ground_slam_end" );
    
    while ( self )
    {
        self orientmode( "face angle", angle );
        waitframe();
    }
}

// Namespace zombie_neptune
// Params 9, eflags: 0x4
// Checksum 0xa641b5ac, Offset: 0x2d1a
// Size: 0xd1
function private radius_ground_impact( var_1ee22348ced85e75, concussive_wave_radius, means_of_death, var_bab023799132ce46, var_14ac138b2d79fe35, player_slow_rate, var_4fe76d6acabc802a, zombie_stun_duration, var_a913d11c9e8d362a )
{
    function_700a81dca0bd312f( var_1ee22348ced85e75, concussive_wave_radius, means_of_death, var_bab023799132ce46, var_14ac138b2d79fe35, player_slow_rate, var_4fe76d6acabc802a, zombie_stun_duration );
    
    if ( var_a913d11c9e8d362a )
    {
        if ( !isdefined( earthquake_radius ) )
        {
            earthquake_radius = 2800;
        }
        
        if ( !isdefined( earthquake_scale ) )
        {
            earthquake_scale = 0.34;
        }
        
        if ( !isdefined( earthquake_duration ) )
        {
            earthquake_duration = 1.25;
        }
        
        playrumbleonposition( "zombie_neptune_ground_slam_rumble", var_1ee22348ced85e75 );
        earthquakeadvanced( earthquake_scale, earthquake_scale / 2, earthquake_scale / 4, earthquake_duration, var_1ee22348ced85e75, earthquake_radius / 4, earthquake_radius / 2, earthquake_radius );
    }
}

// Namespace zombie_neptune
// Params 8, eflags: 0x4
// Checksum 0x3b83323c, Offset: 0x2df3
// Size: 0x441
function private function_700a81dca0bd312f( var_1ee22348ced85e75, concussive_wave_radius, means_of_death, var_bab023799132ce46, var_14ac138b2d79fe35, player_slow_rate, var_4fe76d6acabc802a, zombie_stun_duration )
{
    assert( var_14ac138b2d79fe35 >= var_bab023799132ce46, "<dev string:x24>" );
    var_77eff4b64bee0803 = 3000;
    var_db0b462881225cb9 = squared( 40 );
    center = level.var_4cf3138664b652b6.origin ?? self.origin;
    nearby_target_ents = getplayersandaiarrayinradius( center, var_77eff4b64bee0803 );
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    var_264798a7a3b439c1 = concussive_wave_radius / 2;
    powermultiplier = getdvarfloat( @"hash_69e6e5c5651658f1", 1 );
    
    if ( nearby_target_ents.size > 0 )
    {
        foreach ( potential_target in nearby_target_ents )
        {
            if ( potential_target == self || !isalive( potential_target ) )
            {
                continue;
            }
            
            if ( potential_target.subclass == "zombie_galileo" || potential_target.subclass == "zombie_galileo_drone" )
            {
                continue;
            }
            
            target_is_player = isplayer( potential_target );
            var_673d0cac66f6df35 = distance2d( var_1ee22348ced85e75, potential_target.origin );
            
            if ( var_673d0cac66f6df35 <= concussive_wave_radius )
            {
                var_88af99d81742be03 = math::lerp_fraction( 0, concussive_wave_radius, var_673d0cac66f6df35 );
                
                if ( !target_is_player && var_673d0cac66f6df35 < var_264798a7a3b439c1 )
                {
                    damage_to_ai = zombie_neptune_asm::function_e7b2933ee390e524( var_88af99d81742be03, potential_target.aicategory, potential_target.maxhealth );
                    
                    if ( damage_to_ai > potential_target.health )
                    {
                        dir = vectornormalize( potential_target.origin - var_1ee22348ced85e75 + ( 0, 0, 10 ) );
                        power = math::lerp( settings.var_471fc8650c796c00, settings.var_46fcde650c5354aa, var_88af99d81742be03 );
                        potential_target.ragdollimpactvector = dir * power * powermultiplier;
                        potential_target.ragdollhitloc = "torso_upper";
                    }
                    else
                    {
                        potential_target zombie_knockdown::function_6fc167d4a3590991( var_1ee22348ced85e75 );
                    }
                    
                    potential_target dodamage( damage_to_ai, self.origin, undefined, undefined, means_of_death, undefined, "torso_upper" );
                    continue;
                }
                
                if ( target_is_player && !potential_target.inlaststand )
                {
                    var_9a7b1aa99fa43005 = utility::drop_to_ground( potential_target.origin, 100 );
                    var_992152e003af2d7d = distancesquared( var_9a7b1aa99fa43005, potential_target.origin ) < var_db0b462881225cb9;
                    
                    if ( var_992152e003af2d7d )
                    {
                        potential_target.var_71ef7e54d65ba63d = gettime();
                        
                        if ( !isdefined( potential_target.var_432977c006af3db0 ) )
                        {
                            potential_target.var_432977c006af3db0 = -1;
                        }
                        
                        potential_target.var_432977c006af3db0 = min( potential_target.var_432977c006af3db0 + 1, settings.var_14471300da685722 - 1 );
                        var_8c9b3345c7faf48d = int( math::lerp( var_bab023799132ce46, var_14ac138b2d79fe35, var_88af99d81742be03 ) * self.neptune_damage_scalar );
                        var_8c9b3345c7faf48d += int( var_8c9b3345c7faf48d * settings.var_495bdd69d38154d2 * potential_target.var_432977c006af3db0 );
                        var_92c3a231c0cf9658 = var_4fe76d6acabc802a + var_4fe76d6acabc802a * settings.var_55caff2c89d412ce * potential_target.var_432977c006af3db0;
                        thread function_7954493cecf568c6( potential_target );
                        potential_target dodamage( var_8c9b3345c7faf48d, self.origin, self, self, means_of_death, undefined, "torso_upper" );
                        potential_target thread slow_player( player_slow_rate, var_92c3a231c0cf9658 );
                        potential_target thread function_b831ea031f82655b( var_92c3a231c0cf9658 );
                    }
                }
            }
        }
    }
    
    function_16446293c4fe6111( var_1ee22348ced85e75 );
    self notify( #"hash_c01b3baee08c531c" );
}

// Namespace zombie_neptune
// Params 1, eflags: 0x4
// Checksum 0xd3bac8bb, Offset: 0x323c
// Size: 0x100
function private function_7954493cecf568c6( target )
{
    if ( target.concussionimmune || !target val::get( "stunned" ) )
    {
        return 0;
    }
    
    level endon( #"game_ended" );
    target endon( #"death_or_disconnect" );
    shockasset = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_ae483f7c94ada120;
    shockduration = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_ec8b1a98f83a546;
    
    /#
        shockduration = getdvarfloat( @"hash_86f20dab831db524", shockduration );
    #/
    
    target shellshock_utility::_shellshock( shockasset, #"stun", shockduration, 1, 500 );
    target notify( #"concussed", self );
    target utility::setplayerstunned();
    wait shockduration;
    
    if ( !target || !isdefined( target.isstunned ) )
    {
        return;
    }
    
    target utility::setplayerunstunned();
}

// Namespace zombie_neptune
// Params 1, eflags: 0x4
// Checksum 0xe0b12b7, Offset: 0x3344
// Size: 0x57
function private function_b831ea031f82655b( var_4fe76d6acabc802a )
{
    impact_screenfx = "ground_slam_impact_screen_vfx";
    impact_vfx_id = utility::getfx( impact_screenfx );
    
    if ( impact_vfx_id )
    {
        playfxontagforclients( impact_vfx_id, self, "j_head", self );
    }
    
    wait var_4fe76d6acabc802a;
    
    if ( self )
    {
        stopfxontagforclients( impact_vfx_id, self, "j_head", self );
    }
}

// Namespace zombie_neptune
// Params 1, eflags: 0x4
// Checksum 0x651faa80, Offset: 0x33a3
// Size: 0xae
function private function_16446293c4fe6111( impact_pos )
{
    ground_impact_fx = "ground_slam_ground_impact_vfx";
    concussive_wave_fx = "ground_slam_concussive_wave_vfx";
    impact_vfx_id = utility::getfx( ground_impact_fx );
    forward_vec = anglestoforward( self.angles );
    impact_normal = ( 0, 0, 1 );
    
    if ( impact_vfx_id )
    {
        playfx( impact_vfx_id, impact_pos, forward_vec, impact_normal );
    }
    
    if ( isdefined( level._effect[ concussive_wave_fx ] ) )
    {
        var_f6e5fff437ec8d7b = utility::getfx( concussive_wave_fx );
        
        if ( var_f6e5fff437ec8d7b )
        {
            playfx( var_f6e5fff437ec8d7b, impact_pos, forward_vec, impact_normal );
        }
    }
}

// Namespace zombie_neptune
// Params 2, eflags: 0x4
// Checksum 0x20e19f92, Offset: 0x3459
// Size: 0x48
function private slow_player( var_8f69c955fdeea3da, slow_duration )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self setmovespeedscale( var_8f69c955fdeea3da );
    wait slow_duration;
    
    if ( isdefined( self ) )
    {
        self setmovespeedscale( 1 );
    }
}

// Namespace zombie_neptune
// Params 0, eflags: 0x4
// Checksum 0x622a2505, Offset: 0x34a9
// Size: 0x1f
function private stop_movement()
{
    self setbtgoalpos( 0, self.origin );
    self function_786bb6aa1b76c7ee( "neptune_disable_move", 1 );
}

// Namespace zombie_neptune
// Params 0, eflags: 0x4
// Checksum 0xd0abbace, Offset: 0x34d0
// Size: 0xe
function private recover_movement()
{
    self function_786bb6aa1b76c7ee( "neptune_disable_move", 0 );
}

// Namespace zombie_neptune
// Params 2
// Checksum 0xd16f517d, Offset: 0x34e6
// Size: 0x234
function function_a0705ba4e9fcb31f( taskid, params )
{
    if ( self getaiblackboarddynamic( "neptune_disable_move" ) )
    {
        return anim.success;
    }
    
    if ( getdvarfloat( @"hash_3f0d3a2d3b10d7ef", 0 ) > 0 )
    {
        return anim.success;
    }
    
    var_d4e520db9bfb3a9c = squared( 150 );
    var_31939aa673b45135 = 1000;
    var_803df3ec502db250 = 100;
    
    if ( !isdefined( self.var_38da254f19742dcf ) )
    {
        self.var_38da254f19742dcf = gettime() + var_31939aa673b45135;
    }
    
    if ( !isdefined( self.neptune_last_pos ) )
    {
        self.neptune_last_pos = self.origin;
    }
    
    if ( gettime() > self.var_38da254f19742dcf )
    {
        if ( distancesquared( self.origin, self.neptune_last_pos ) <= var_803df3ec502db250 )
        {
            if ( isdefined( self.spawnpos ) && distancesquared( self.origin, self.spawnpos ) > var_d4e520db9bfb3a9c )
            {
                zombie_utils::update_bt_goal( self.spawnpos );
                self.var_aedd65e692a5fce3 = self.spawnpos;
            }
        }
        
        self.var_38da254f19742dcf = gettime() + var_31939aa673b45135;
        self.neptune_last_pos = self.origin;
        return anim.success;
    }
    
    if ( self.var_a0abce1d579b794d && distancesquared( self.origin, self.var_aedd65e692a5fce3 ) > var_d4e520db9bfb3a9c )
    {
        return anim.running;
    }
    else
    {
        self.var_a0abce1d579b794d = 0;
    }
    
    self.var_aedd65e692a5fce3 = function_c6861d04ef1fe32c();
    
    if ( !isdefined( self.var_aedd65e692a5fce3 ) )
    {
        if ( isdefined( self.spawnpos ) && distancesquared( self.origin, self.spawnpos ) > var_d4e520db9bfb3a9c )
        {
            zombie_utils::update_bt_goal( self.spawnpos );
            self.var_aedd65e692a5fce3 = self.spawnpos;
        }
        
        return anim.success;
    }
    
    zombie_utils::update_bt_goal( self.var_aedd65e692a5fce3 );
    self.var_7ffcd22c2a1e2c76 = 0;
    self.var_a0abce1d579b794d = 1;
    return anim.success;
}

// Namespace zombie_neptune
// Params 0, eflags: 0x4
// Checksum 0xc6018aa1, Offset: 0x3723
// Size: 0x8d
function private function_c6861d04ef1fe32c()
{
    goal_pos = self getgoalpos();
    recalculate_dist = asm_bb::bb_movetyperequested( "run" ) ? 300 : 600;
    recalculate_dist = getdvarfloat( @"hash_d2aa6bb905670722", recalculate_dist );
    
    if ( isdefined( goal_pos ) && self pathdisttogoal() > recalculate_dist && !self.var_7ffcd22c2a1e2c76 )
    {
        return;
    }
    
    goal_pos = function_290f8c14dbc57398( self );
    
    if ( goal_pos == self.origin )
    {
        self.var_f9a759bcc48cca8f = gettime();
    }
    
    return goal_pos;
}

// Namespace zombie_neptune
// Params 2
// Checksum 0xdabcd149, Offset: 0x37b9
// Size: 0x2bd
function function_290f8c14dbc57398( ai_entity, var_cfb5dc6e8df2500f = asm_bb::bb_movetyperequested( "run" ) ? 600 : 800 )
{
    var_cfb5dc6e8df2500f = getdvarfloat( @"hash_9fc4dd1925ddc9a7", var_cfb5dc6e8df2500f );
    top_x = getdvarfloat( @"hash_9c193f874738202e", 5 );
    max_bounces = getdvarfloat( @"hash_5eacbd87d3262aa3", 1 );
    var_e6ef1231966449aa = ai_entity.origin;
    base_angles = ai_entity.angles;
    forward_dir = anglestoforward( base_angles );
    
    for ( b = 0; b < max_bounces ; b++ )
    {
        trace_results = [];
        
        for ( i = 0; i < 8 ; i++ )
        {
            if ( i == 3 || i == 5 )
            {
                trace_results[ i ] = [ var_e6ef1231966449aa, -999999, -999999 ];
                continue;
            }
            
            test_yaw = base_angles[ 1 ] + i * 45;
            test_angles = ( base_angles[ 0 ], test_yaw, base_angles[ 2 ] );
            check_dir = anglestoforward( test_angles );
            check_end = var_e6ef1231966449aa + check_dir * var_cfb5dc6e8df2500f;
            nav_end = getclosestpointonnavmesh( check_end, ai_entity, 1, 1, 0, 0 );
            
            if ( !isdefined( nav_end ) || distance( nav_end, var_e6ef1231966449aa ) < 200 )
            {
                trace_results[ i ] = [ var_e6ef1231966449aa, -999999, -999999 ];
                continue;
            }
            
            distance_val = distance( var_e6ef1231966449aa, nav_end );
            dot_val = vectordot( forward_dir, check_dir );
            trace_results[ i ] = [ nav_end, distance_val, dot_val ];
        }
        
        sorted_results = arraysort( trace_results, undefined, &function_17d0c9b38758e5a8 );
        best_position = var_e6ef1231966449aa;
        found_valid = 0;
        max_candidates = min( top_x, sorted_results.size );
        
        while ( !found_valid )
        {
            var_e3eab751eefd3bd0 = -999999;
            best_dot_index = -1;
            
            for ( m = 0; m < max_candidates ; m++ )
            {
                dot_val = sorted_results[ m ][ 2 ];
                
                if ( dot_val > var_e3eab751eefd3bd0 )
                {
                    var_e3eab751eefd3bd0 = dot_val;
                    best_dot_index = m;
                }
            }
            
            if ( best_dot_index <= -1 )
            {
                break;
            }
            
            var_35b8f54c259f8b32 = sorted_results[ best_dot_index ][ 0 ];
            best_position = var_35b8f54c259f8b32;
            found_valid = 1;
        }
        
        if ( !found_valid || best_position == var_e6ef1231966449aa )
        {
            break;
        }
        
        var_e6ef1231966449aa = best_position;
    }
    
    return var_e6ef1231966449aa;
}

// Namespace zombie_neptune
// Params 2, eflags: 0x4
// Checksum 0x10b9ed48, Offset: 0x3a7f
// Size: 0x1e, Type: bool
function private function_17d0c9b38758e5a8( a, b )
{
    return a[ 1 ] >= b[ 1 ];
}

// Namespace zombie_neptune
// Params 0
// Checksum 0x2529ed60, Offset: 0x3aa6
// Size: 0x68
function hibernation_start()
{
    if ( level.var_4cf3138664b652b6.angles[ 1 ] )
    {
        self orientmode( "face angle", level.var_4cf3138664b652b6.angles[ 1 ] );
    }
    
    self setbtgoalstationary( 0 );
    zombie_neptune_metabones::reset_metabones();
    zombie_neptune_metabones::function_4f4390eb16a079e7();
    self.var_69bdeb508231beb4 = 1;
    asm::function_7256f5ba459c840b( "hibernation_in" );
}

// Namespace zombie_neptune
// Params 0
// Checksum 0x9caf3698, Offset: 0x3b16
// Size: 0x2f
function hibernation_end()
{
    self clearbtgoal( 0 );
    asm::asm_fireevent( self.asmname, "end_neptune_hibernation" );
    self.var_69bdeb508231beb4 = 0;
    zombie_neptune_metabones::function_df24f103eff2798b();
}

// Namespace zombie_neptune
// Params 1, eflags: 0x4
// Checksum 0xff0fa705, Offset: 0x3b4d
// Size: 0xc9
function private function_661647e972f0e686( params )
{
    switch ( self.n_fight_phase )
    {
        case 1:
            self setnavlayer( "zombie_large" );
            break;
        case 2:
            utility::function_32b24db3127bff40( "base", "base_phase2" );
            
            if ( !self.suppress_minimap_icon )
            {
                utility::function_32b24db3127bff40( "boss_icon", "phase2" );
            }
            
            self setnavlayer( "zombie_large" );
            break;
        case 3:
            utility::function_32b24db3127bff40( "base", "base_phase3" );
            
            if ( !self.suppress_minimap_icon )
            {
                utility::function_32b24db3127bff40( "boss_icon", "phase3" );
            }
            
            self setnavlayer( "zombie_large_wide" );
            break;
    }
}

// Namespace zombie_neptune
// Params 0, eflags: 0x4
// Checksum 0xbafcb60b, Offset: 0x3c1e
// Size: 0x2b2
function private function_2bb6d4b0c3fecc1a()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    var_7aeec95d122be7c7 = self tagexists( "j_spine4" ) ? self gettagorigin( "j_spine4" ) : self.origin;
    neptune_spawn_struct = level.var_4cf3138664b652b6 ?? self;
    boss_height = var_7aeec95d122be7c7[ 2 ] - self.origin[ 2 ];
    target_pos = neptune_spawn_struct.origin + ( 0, 0, boss_height );
    self.var_2f050223e0caa40b = [];
    trail_num = randomintrange( settings.var_144b932d5b3dd885, settings.var_146e9d2d5b64363b + 1 );
    
    for ( i = 0; i < trail_num ; i++ )
    {
        trail = utility::spawn_model( "sat_zombie_neptune_trail", var_7aeec95d122be7c7 );
        self.var_2f050223e0caa40b[ self.var_2f050223e0caa40b.size ] = trail;
        trail utility::function_32b24db3127bff40( "transition_trail", "on" );
    }
    
    var_dd0f62546f87db3d = 300;
    
    foreach ( trail in self.var_2f050223e0caa40b )
    {
        control_pos = ( target_pos + trail.origin ) / 2 + ( randomintrange( var_dd0f62546f87db3d * -1, var_dd0f62546f87db3d ), randomintrange( var_dd0f62546f87db3d * -1, var_dd0f62546f87db3d ), randomintrange( int( var_dd0f62546f87db3d / 2 ), var_dd0f62546f87db3d * 2 ) );
        trail thread utility::function_8001268940441423( trail.origin, target_pos, control_pos, settings.var_8a231135c1e3eac7, 0, 1, 1 );
    }
    
    wait settings.var_8a231135c1e3eac7;
    
    foreach ( trail in self.var_2f050223e0caa40b )
    {
        trail utility::function_32b24db3127bff40( "transition_trail", "off" );
        trail delete();
    }
    
    self notify( #"transition_trails_done" );
}

// Namespace zombie_neptune
// Params 0
// Checksum 0x300d88a, Offset: 0x3ed8
// Size: 0x42
function set_transition_explode()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self waittill( #"transition_explode" );
    utility::function_32b24db3127bff40( "transition_explode", "on_" + self.n_fight_phase );
}

