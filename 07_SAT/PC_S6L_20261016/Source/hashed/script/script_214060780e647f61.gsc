// script_214060780e647f61  (hash_214060780e647f61.gscc) (size: 38162 Bytes / 0x9512 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x215d2628 (559752744)
// size ...... 38162 (0x9512)
// includes .. 22  (offset: 0x8c36)
// strings ... 106 (offset: 0x8ce6)
// dev strs .. 21  (offset: 0x940a)
// exports ... 78  (offset: 0x602a)
// cseg ...... 0x8d6 + 0x5754 (0x602a)
// imports ... 241 (offset: 0x6c5a)
// animtree1 . 0   (offset: 0x9512)
// animtree2 . 0   (offset: 0x9512)
#using script_16ea1b94f0f381b3;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_bloat;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_traverse;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\mutant_injection_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\health_overcharge;
#using scripts\mp\playerhealth;

#namespace mutant_injection_disciple_zombies;

// Namespace mutant_injection_disciple_zombies
// Params 0
// Checksum 0x73c61a5b, Offset: 0x8f4
// Size: 0x8e
function init()
{
    level._effect[ "mutant_injection_zombie_annihilate" ] = loadfxasset( "vfx_t10_gameplay_zm_weapons_weap_mangler_zombie_annihilate_1" );
    utility::add_fx( "minj_disciple_lifedrain_beam_fx", "vfx_sat_gameplay_zm_weapons_dinj_drain_beam" );
    
    if ( utility::issharedfuncdefined( #"zombie_utils", #"registerdamagecallback" ) )
    {
        utility::callsharedfunc( #"zombie_utils", #"registerdamagecallback", &function_65b40f31d56d5b2c );
    }
    
    level utility::registersharedfunc( #"zm_dinj", #"hash_82f3df73536352e5", &function_e94e1748a20730a1 );
    
    /#
        function_747263780094d57();
    #/
}

// Namespace mutant_injection_disciple_zombies
// Params 2
// Checksum 0x2da88291, Offset: 0x98a
// Size: 0x135
function setcontext( config, streakinfo )
{
    micontext = self.micontext ?? {};
    micontext.var_d2526179d91798d6 = [];
    
    if ( utility::issharedfuncdefined( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb" ) && self [[ utility::getsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb" ) ]]( "specialty_m_mod" ) )
    {
        micontext.var_d2526179d91798d6[ micontext.var_d2526179d91798d6.size ] = "specialty_m_mod";
    }
    
    if ( health_overcharge::function_1c546d630583f860() && self.var_68e0e97561171104.base_max_health )
    {
        self.micontext.overcharge_sources = arraycopy( self.var_68e0e97561171104.overcharge_sources );
        self.micontext.base_max_health = self.var_68e0e97561171104.base_max_health;
    }
    else
    {
        self.micontext.prevmaxhealth = self.maxhealth;
    }
    
    self.micontext = micontext;
}

// Namespace mutant_injection_disciple_zombies
// Params 0
// Checksum 0x657506d5, Offset: 0xac7
// Size: 0x216
function starttransformation()
{
    val::set( "mutant_injection_disallow_super_point", "allow_give_super_point", 0 );
    
    if ( !isdefined( self.disallow_zombie_perks ) )
    {
        self.disallow_zombie_perks = [];
    }
    
    if ( !isdefined( self.var_91310e59e598f1e3 ) )
    {
        self.var_91310e59e598f1e3 = [];
    }
    
    if ( self.micontext.var_d2526179d91798d6.size )
    {
        foreach ( perk in self.micontext.var_d2526179d91798d6 )
        {
            for ( i = 0; i < self.perks_active.size ; i++ )
            {
                if ( perk == self.perks_active[ i ] )
                {
                    self.var_91310e59e598f1e3[ perk ] = i;
                    break;
                }
            }
            
            if ( utility::issharedfuncdefined( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb" ) && self [[ utility::getsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb" ) ]]( perk ) )
            {
                if ( utility::issharedfuncdefined( #"hash_e7a7d049d5f06935", #"hash_899320e73bb1d103" ) )
                {
                    self [[ utility::getsharedfunc( #"hash_e7a7d049d5f06935", #"hash_899320e73bb1d103" ) ]]( perk, 1 );
                }
            }
            
            self.disallow_zombie_perks = arraycombineunique( self.disallow_zombie_perks, [ perk ] );
        }
    }
    
    thread function_42a0f7295dcf86ed();
    bundle = level.streakglobals.streakbundles[ "zm_dinj" ];
    var_d85d937d78e4a8a2 = bundle.mutantinjectiondata.var_d85d937d78e4a8a2;
    xanim = var_d85d937d78e4a8a2.id;
    thread knockbackzombies( xanim );
    function_965b9d0fd3b6ecfc();
}

// Namespace mutant_injection_disciple_zombies
// Params 1
// Checksum 0x1e09f598, Offset: 0xce5
// Size: 0xa7
function getnearbytargets( radius )
{
    currentpos = self.origin;
    var_cd7fbd135a81723f = self.micontext.var_cd7fbd135a81723f;
    var_f4cfb89f123543d9 = self.micontext.var_f4cfb89f123543d9;
    
    if ( var_cd7fbd135a81723f && var_f4cfb89f123543d9 )
    {
        potentialtargets = getplayersandaiarrayinradius( currentpos, radius ) ?? [];
    }
    else if ( var_cd7fbd135a81723f )
    {
        potentialtargets = getaiarrayinradius( currentpos, radius ) ?? [];
    }
    else if ( var_f4cfb89f123543d9 )
    {
        potentialtargets = getplayersinradius( currentpos, radius ) ?? [];
    }
    
    return potentialtargets;
}

// Namespace mutant_injection_disciple_zombies
// Params 1
// Checksum 0xdc25accf, Offset: 0xd95
// Size: 0x15, Type: bool
function function_a3f71ecb6eb404cc( target )
{
    return !target zombie_utils::function_bf1464d09f4e4b40();
}

// Namespace mutant_injection_disciple_zombies
// Params 0
// Checksum 0xc7201c5f, Offset: 0xdb3
// Size: 0xd
function is_grabbed()
{
    return utility::ent_flag( "grabbed" );
}

// Namespace mutant_injection_disciple_zombies
// Params 2
// Checksum 0x5465bbbe, Offset: 0xdc9
// Size: 0x1fb
function removemutantinjection( istimeout, skipanimation )
{
    bundle = level.streakglobals.streakbundles[ "zm_dinj" ];
    var_6fe663f3fb948213 = bundle.mutantinjectiondata.var_b499cb2de0e829f;
    xanim = var_6fe663f3fb948213.id;
    thread knockbackzombies( xanim );
    micontext = self.micontext;
    
    if ( isalive( self ) && !self.inlaststand && micontext.var_d2526179d91798d6.size )
    {
        foreach ( perk in micontext.var_d2526179d91798d6 )
        {
            if ( utility::issharedfuncdefined( #"loot_perks", #"hash_d60bebeaed508539" ) )
            {
                var_27055d4be790cd0 = self.var_91310e59e598f1e3[ perk ] ?? undefined;
                self [[ utility::getsharedfunc( #"loot_perks", #"hash_d60bebeaed508539" ) ]]( perk, undefined, undefined, var_27055d4be790cd0 );
            }
            
            if ( self.disallow_zombie_perks.size > 0 )
            {
                self.disallow_zombie_perks = arrayremove( self.disallow_zombie_perks, [ perk ] );
                
                if ( self.disallow_zombie_perks.size == 0 )
                {
                    self.disallow_zombie_perks = undefined;
                }
            }
        }
    }
    
    set_allow_drain_life( undefined );
    set_allow_grab_zombie( undefined );
    set_allow_scream( undefined );
    val::reset_all( "disciple_grab_zombie" );
    
    if ( player::isreallyalive( self ) )
    {
        resetplayerhealth();
    }
    
    self.var_a84311e2c57646de = undefined;
}

// Namespace mutant_injection_disciple_zombies
// Params 0, eflags: 0x4
// Checksum 0xc53e9fa0, Offset: 0xfcc
// Size: 0xc0
function private resetplayerhealth()
{
    if ( !self || !self.micontext )
    {
        return;
    }
    
    if ( self.micontext.overcharge_sources && self.micontext.base_max_health )
    {
        thread health_overcharge::function_aaa1259d369b69ea( self.micontext.base_max_health, self.micontext.overcharge_sources );
        return;
    }
    
    if ( self.micontext.prevmaxhealth )
    {
        self.maxhealth = self.micontext.prevmaxhealth;
        self.health = self.maxhealth;
        damage_effects::onexitdeathsdoor( 1 );
    }
}

// Namespace mutant_injection_disciple_zombies
// Params 1
// Checksum 0x77c86566, Offset: 0x1094
// Size: 0xd0
function function_5da7e225cbfb13ae( target )
{
    if ( !isdefined( target.aicategory ) || target.aicategory == "normal" )
    {
        if ( !target zombie_knockdown::function_19d6107cb6bdff5c() )
        {
            currentpos = self.origin;
            forward = anglestoforward( self.angles );
            forward_end = currentpos + forward * 80 * 2;
            line_to_target = vectornormalize( vectorfromlinetopoint( forward_end, currentpos, target.origin ) );
            source_point = target.origin - line_to_target * 40;
            target zombie_knockdown::function_6fc167d4a3590991( source_point );
        }
        
        return;
    }
    
    target zombie_stun::stun_ai( 1 );
}

// Namespace mutant_injection_disciple_zombies
// Params 4
// Checksum 0xd8e52088, Offset: 0x116c
// Size: 0x12e
function function_ba3d79cb556f9f5a( target, vectortotarget, dismember, damagescale )
{
    if ( target.subclass != "zombie_base" )
    {
        return;
    }
    
    n_damage = mutant_injection_utility::function_c059fcb8b93ffa03( target, damagescale );
    
    if ( n_damage < target.health )
    {
        return;
    }
    
    target.ragdollimpactvector = ( vectortotarget[ 0 ], vectortotarget[ 1 ], 0.2 ) * 5000;
    target.ragdollhitloc = "torso_upper";
    target.do_immediate_ragdoll = 1;
    
    if ( dismember )
    {
        if ( isdefined( target.func_dismember_annihilate ) && distancesquared( target.origin, self.origin ) < 1296 && randomint( 100 ) < 65 )
        {
            target.var_4ffaa2be1f30674d = "mutant_injection_zombie_annihilate";
            target thread [[ target.func_dismember_annihilate ]]();
            throttle::throttle_wait_in_queue( level.mutant_injection_zombie_annihilate_throttle, self );
            return;
        }
        
        target utility::ent_flag_set( "weap_mangler_killed" );
        target thread namespace_b76ff2659823e89d::function_14463e39cc414bab( 1 );
    }
}

// Namespace mutant_injection_disciple_zombies
// Params 1
// Checksum 0xffcce22d, Offset: 0x12a2
// Size: 0xb5
function function_5d1c9baecab4e975( target )
{
    if ( isplayer( target ) )
    {
        return target.maxhealth;
    }
    
    if ( utility::issharedfuncdefined( #"game", #"roundNumberDifficulty" ) && utility::issharedfuncdefined( #"zombie", #"health_scaling_get_subclass_health" ) )
    {
        round_difficulty = [[ utility::getsharedfunc( #"game", #"roundNumberDifficulty" ) ]]( target.origin );
        zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
        return zombie_base_health;
    }
    
    return target.maxhealth;
}

// Namespace mutant_injection_disciple_zombies
// Params 2
// Checksum 0xaeee8a43, Offset: 0x135f
// Size: 0x36
function function_c059fcb8b93ffa03( target, damagescale = 3 )
{
    zombie_base_health = function_5d1c9baecab4e975( target );
    return zombie_base_health * damagescale;
}

// Namespace mutant_injection_disciple_zombies
// Params 0
// Checksum 0x5756e40b, Offset: 0x139e
// Size: 0x52
function function_eec781547b670f5()
{
    weaponobj = self getcurrentweapon();
    
    if ( !weaponobj )
    {
        weapon_name = self.micontext.weapon ?? utility::get_scripted_weapon_name( #"zm_dinj" );
        weaponobj = makeweapon( weapon_name );
    }
    
    return weaponobj;
}

// Namespace mutant_injection_disciple_zombies
// Params 1, eflags: 0x4
// Checksum 0x6fc301b5, Offset: 0x13f9
// Size: 0x320
function private knockbackzombies( xanim )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    knock_back_time = 1;
    
    if ( animhasnotetrack( xanim, "knock_back" ) )
    {
        note_frac = getnotetracktimes( xanim, "knock_back" )[ 0 ];
        knock_back_time = getanimlength( xanim ) * note_frac;
    }
    
    wait knock_back_time;
    knock_back_pos = self.origin;
    mod = "MOD_IMPACT";
    weaponobj = function_eec781547b670f5();
    potential_targets = mutant_injection_utility::getnearbytargets( 300 );
    
    foreach ( target in potential_targets )
    {
        if ( !isalive( target ) )
        {
            continue;
        }
        
        if ( target utility::ent_flag( "scene_ent_playing_anim" ) )
        {
            continue;
        }
        
        if ( !function_a3f71ecb6eb404cc( target ) || isplayer( target ) )
        {
            continue;
        }
        
        if ( target.aicategory == "normal" )
        {
            if ( isdefined( target.func_dismember_annihilate ) )
            {
                var_ee6433c31961982d = vectornormalize( target.origin - knock_back_pos );
                target.ragdollimpactvector = ( var_ee6433c31961982d[ 0 ], var_ee6433c31961982d[ 1 ], 0.2 ) * 2000;
                target.ragdollhitloc = "torso_upper";
                target.do_immediate_ragdoll = 1;
                target.var_4ffaa2be1f30674d = "mutant_injection_zombie_annihilate";
                function_ee6ab1e2ff0cd2c0( target, mod );
            }
            else
            {
                if ( target.magic_bullet_shield || target.damageshield || !target val::get( "death" ) )
                {
                    continue;
                }
                
                target kill( target.origin, self, self, mod, weaponobj );
            }
            
            continue;
        }
        
        target dodamage( 1, target.origin + ( 0, 0, 30 ), self, self, mod, weaponobj, "torso_upper", undefined, 2147483648 );
    }
    
    potential_targets = mutant_injection_utility::getnearbytargets( 100 );
    
    foreach ( target in potential_targets )
    {
        if ( !isai( target ) )
        {
            continue;
        }
        
        if ( isplayer( target ) )
        {
            continue;
        }
        
        if ( !isalive( target ) )
        {
            continue;
        }
        
        if ( !function_a3f71ecb6eb404cc( target ) )
        {
            continue;
        }
        
        if ( target utility::ent_flag( "scene_ent_playing_anim" ) )
        {
            continue;
        }
        
        target zombie_stun::stun_ai( 2 );
    }
}

// Namespace mutant_injection_disciple_zombies
// Params 2, eflags: 0x4
// Checksum 0xe3d4dbae, Offset: 0x1721
// Size: 0x88
function private function_ee6ab1e2ff0cd2c0( target, mod )
{
    if ( target.var_76bf6b08e4d3f914 )
    {
        return;
    }
    
    if ( !isdefined( self.var_8ebebca7f84e63b ) )
    {
        self.var_8ebebca7f84e63b = [];
    }
    
    target_info = {};
    target_info.target = target;
    target_info.mod = mod;
    self.var_8ebebca7f84e63b[ self.var_8ebebca7f84e63b.size ] = target_info;
    target.var_76bf6b08e4d3f914 = 1;
}

// Namespace mutant_injection_disciple_zombies
// Params 0, eflags: 0x4
// Checksum 0x44872027, Offset: 0x17b1
// Size: 0x1ee
function private function_42a0f7295dcf86ed()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( level.mutant_injection_zombie_annihilate_throttle ) )
    {
        level.mutant_injection_zombie_annihilate_throttle = throttle::throttle_initialize( "mutant_injection_zombie_annihilate", 1 );
    }
    
    self.var_8ebebca7f84e63b = [];
    weapon_name = self.micontext.weapon ?? utility::get_scripted_weapon_name( #"zm_dinj" );
    weaponobj = makeweapon( weapon_name );
    
    while ( isdefined( self ) && ( self.ismutantinjection || self.mutantinjectiontransformed ) )
    {
        foreach ( target_info in self.var_8ebebca7f84e63b )
        {
            self.var_8ebebca7f84e63b = arrayremove( self.var_8ebebca7f84e63b, target_info );
            target = target_info.target;
            
            if ( target.var_76bf6b08e4d3f914 && isdefined( target.func_dismember_annihilate ) )
            {
                if ( target.magic_bullet_shield || target.damageshield || !target val::get( "death" ) )
                {
                    continue;
                }
                
                target thread [[ target.func_dismember_annihilate ]]();
                target kill( target.origin, self, self, target_info.mod, weaponobj );
                target.var_76bf6b08e4d3f914 = undefined;
                throttle::throttle_wait_in_queue( level.mutant_injection_zombie_annihilate_throttle, self );
            }
        }
        
        waitframe();
    }
    
    val::reset_all( "mutant_injection_disallow_super_point" );
}

// Namespace mutant_injection_disciple_zombies
// Params 1
// Checksum 0x36195d81, Offset: 0x19a7
// Size: 0x71
function function_65b40f31d56d5b2c( params )
{
    if ( params.smeansofdeath == "MOD_MELEE" && isdefined( params.eattacker ) && params.eattacker.ismutantinjection )
    {
        if ( !self.mutant_injection_damage )
        {
            params.var_d20799805edf0194 = 1;
            return 0;
        }
    }
    
    return params.idamage;
}

// Namespace mutant_injection_disciple_zombies
// Params 0, eflags: 0x4
// Checksum 0xaeb4663f, Offset: 0x1a21
// Size: 0x89
function private function_965b9d0fd3b6ecfc()
{
    bundle = self.micontext.bundle ?? level.streakglobals.streakbundles[ "zm_dinj" ];
    self.var_a84311e2c57646de = &function_2517d13792310bd8;
    
    if ( !level.var_af56da47dc80867 )
    {
        level.var_af56da47dc80867 = 1;
        function_fe184eca11e17f3( 1, bundle.mutantinjectiondata.var_e4091068e46d716f ?? 0, undefined, undefined, 1 );
    }
}

// Namespace mutant_injection_disciple_zombies
// Params 5
// Checksum 0x1527cd4e, Offset: 0x1ab2
// Size: 0xa3
function function_fe184eca11e17f3( var_d648d1dbc51f0b0f, reduce_time, aicategory, means_of_death, var_f89e75bfc3059069 )
{
    if ( !isdefined( var_d648d1dbc51f0b0f ) || !isdefined( reduce_time ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_13528ddc387fb88f ) )
    {
        level.var_13528ddc387fb88f = [];
    }
    
    level.var_13528ddc387fb88f[ level.var_13528ddc387fb88f.size ] = { #var_f89e75bfc3059069:var_f89e75bfc3059069, #means_of_death:means_of_death, #aicategory:aicategory, #reduce_time:reduce_time, #var_d648d1dbc51f0b0f:var_d648d1dbc51f0b0f };
}

// Namespace mutant_injection_disciple_zombies
// Params 1, eflags: 0x4
// Checksum 0xc8acad16, Offset: 0x1b5d
// Size: 0x306
function private function_2517d13792310bd8( params )
{
    if ( params.eattacker != self && isplayer( params.eattacker ) && !player_utility::isenemy( params.eattacker ) )
    {
        return;
    }
    
    if ( !game_utility::function_6131f69cfe56ed90() )
    {
        if ( !isplayer( params.eattacker ) && !isagent( params.eattacker ) && params.idamage >= self.health )
        {
            if ( params.smeansofdeath == "MOD_CRUSH" || params.smeansofdeath == "MOD_FALLING" || params.smeansofdeath == "MOD_TRIGGER_HURT" )
            {
                self kill();
            }
        }
    }
    
    if ( self.ismutantinjection )
    {
        if ( isdefined( params.eattacker ) && params.eattacker.aicategory == "normal" )
        {
            params.idamage = params.idamage > 30 ? 30 : params.idamage;
        }
        
        foreach ( data in level.var_13528ddc387fb88f )
        {
            if ( params.idamage >= data.var_d648d1dbc51f0b0f )
            {
                if ( isdefined( data.aicategory ) && ( !isagent( params.eattacker ) || params.eattacker.aicategory != data.aicategory ) )
                {
                    continue;
                }
                
                if ( isdefined( data.means_of_death ) && params.smeansofdeath != data.means_of_death )
                {
                    continue;
                }
                
                if ( isdefined( params.eattacker ) && params.eattacker.var_c4ad96ba9582dfec )
                {
                    continue;
                }
                
                if ( self.mutant_injection_end_time )
                {
                    reduce_time = int( data.var_f89e75bfc3059069 ? data.reduce_time * params.idamage / data.var_d648d1dbc51f0b0f : data.reduce_time );
                    mutant_injection_utility::function_d56f1bba158cb4d6( reduce_time * -1 );
                }
                
                if ( utility::issharedfuncdefined( #"zm_dinj", #"hash_73388df4a8875c87" ) )
                {
                    self [[ utility::getsharedfunc( #"zm_dinj", #"hash_73388df4a8875c87" ) ]]( params );
                }
            }
        }
    }
}

// Namespace mutant_injection_disciple_zombies
// Params 0
// Checksum 0x6ad23813, Offset: 0x1e6b
// Size: 0x15b
function watchdrainlife()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"mutantinjection_end" );
    self.is_drain_life = 0;
    self.var_551543134a4a0a98 = 0;
    var_ebe9c6ed3a5b89c1 = 0;
    check_interval = 50;
    next_check_time = 0;
    self.var_20fc10b43d0d0632 = 1;
    var_a013bc3f1d49c41f = undefined;
    
    while ( true )
    {
        if ( !is_allow_drain_life() )
        {
            waitframe();
            continue;
        }
        
        if ( !self.is_drain_life && gettime() >= next_check_time )
        {
            next_check_time = gettime() + check_interval;
            var_a013bc3f1d49c41f = check_can_drain_life();
        }
        
        if ( self attackbuttonpressed() )
        {
            if ( !var_ebe9c6ed3a5b89c1 || gettime() >= var_ebe9c6ed3a5b89c1 )
            {
                if ( !self.is_drain_life )
                {
                    if ( var_a013bc3f1d49c41f && var_a013bc3f1d49c41f.target && gettime() - var_a013bc3f1d49c41f.time < check_interval )
                    {
                        thread startdrainlife( var_a013bc3f1d49c41f.target, var_a013bc3f1d49c41f.is_scriptable, var_a013bc3f1d49c41f.pos );
                    }
                    else
                    {
                        trydrainlife( 0 );
                    }
                    
                    var_a013bc3f1d49c41f = undefined;
                }
            }
        }
        else if ( self.is_drain_life )
        {
            end_drain_life();
            var_ebe9c6ed3a5b89c1 = gettime() + 1200;
        }
        
        waitframe();
    }
}

// Namespace mutant_injection_disciple_zombies
// Params 0, eflags: 0x4
// Checksum 0x9a4867, Offset: 0x1fce
// Size: 0xb
function private is_allow_drain_life()
{
    return self.var_20fc10b43d0d0632;
}

// Namespace mutant_injection_disciple_zombies
// Params 2, eflags: 0x4
// Checksum 0xa58992dc, Offset: 0x1fe2
// Size: 0xd2
function private set_allow_drain_life( allow, exclusive_attack )
{
    var_90570997dea07033 = "disc_cannot_drain_life";
    var_c12b10cde81b5aa7 = "disc_drain_life_no_candidate";
    
    if ( !isdefined( exclusive_attack ) )
    {
        exclusive_attack = 0;
    }
    
    str_id = exclusive_attack ? var_90570997dea07033 : var_c12b10cde81b5aa7;
    
    if ( !isdefined( allow ) )
    {
        val::reset_all( var_90570997dea07033 );
        val::reset_all( var_c12b10cde81b5aa7 );
        self.var_20fc10b43d0d0632 = undefined;
        return;
    }
    
    if ( is_grabbing_zombie() )
    {
        val::reset_all( var_90570997dea07033 );
        val::reset_all( var_c12b10cde81b5aa7 );
    }
    else if ( allow )
    {
        val::reset_all( str_id );
    }
    else
    {
        val::set( str_id, "fire", 0 );
    }
    
    self setclientomnvar( "ui_zm_dinj_can_drain_life", allow );
    
    if ( exclusive_attack )
    {
        self.var_20fc10b43d0d0632 = allow;
    }
}

// Namespace mutant_injection_disciple_zombies
// Params 0, eflags: 0x4
// Checksum 0x996fbbf6, Offset: 0x20bc
// Size: 0x3d
function private check_can_drain_life()
{
    [ can_drain_life, var_a013bc3f1d49c41f ] = trydrainlife( 1 );
    set_allow_drain_life( can_drain_life );
    return var_a013bc3f1d49c41f;
}

// Namespace mutant_injection_disciple_zombies
// Params 0, eflags: 0x4
// Checksum 0xe401f412, Offset: 0x2102
// Size: 0x42
function private end_drain_life()
{
    self.is_drain_life = 0;
    
    if ( self.ismutantinjection )
    {
        set_allow_grab_zombie( 1, 1 );
        set_allow_scream( 1, 1 );
        set_allow_drain_life( 0 );
    }
    
    self notify( #"end_drain_life" );
}

// Namespace mutant_injection_disciple_zombies
// Params 2, eflags: 0x4
// Checksum 0xde4960a1, Offset: 0x214c
// Size: 0x93
function private function_27012cbfbfa4ff05( trace_dist, var_d7764b34d9ca86cc )
{
    const_trace_distance = 300;
    
    if ( !isdefined( trace_dist ) )
    {
        trace_dist = const_trace_distance;
    }
    
    if ( !isdefined( var_d7764b34d9ca86cc ) )
    {
        var_d7764b34d9ca86cc = 0;
    }
    
    angles = self getplayerangles();
    forward = anglestoforward( angles );
    start = self getcamerathirdpersonorigin();
    end = start + trace_dist * forward;
    trace_results = trace::ray_trace_get_all_results( start, end, [ self ], undefined, 1, var_d7764b34d9ca86cc );
    return trace_results;
}

// Namespace mutant_injection_disciple_zombies
// Params 1, eflags: 0x4
// Checksum 0x7293459, Offset: 0x21e8
// Size: 0x36a
function private trydrainlife( var_99b1bf58f96e3617 = 0 )
{
    bundle = self.micontext.bundle ?? level.streakglobals.streakbundles[ "zm_dinj" ];
    drainliferange = bundle.mutantinjectiondata.var_5a371ed03f360c3c ?? 0;
    trace_results = function_27012cbfbfa4ff05( drainliferange + 450, 1 );
    self.var_8d9c68de832a27ae = undefined;
    
    foreach ( trace_result in trace_results )
    {
        if ( trace_result[ "hittype" ] == "hittype_entity" )
        {
            entity = trace_result[ "entity" ];
            
            if ( !isplayer( entity ) )
            {
                if ( !function_c9779fb8eb0ba73e( entity ) )
                {
                    continue;
                }
            }
            else if ( !function_fcd962177e8abc3b( entity ) )
            {
                continue;
            }
            
            if ( !function_a9e48e8e302ba59( entity ) )
            {
                continue;
            }
            
            /#
                if ( getdvarint( @"hash_3204b12e758bb7bb", 0 ) )
                {
                    var_71d97198b7d78dbf = 1;
                    direction = vectornormalize( entity.origin - self.origin );
                    start = self getcentroid();
                    target = start + direction * drainliferange;
                    debug::line( start, target, ( 1, 1, 1 ), 5 );
                }
            #/
            
            bound_half_size = entity getboundshalfsize();
            bound_radius = bound_half_size ? bound_half_size[ 0 ] : 0;
            drain_life_dist = drainliferange + bound_radius;
            
            if ( distancesquared( self getcentroid(), entity getcentroid() ) < drain_life_dist * drain_life_dist )
            {
                /#
                    if ( var_71d97198b7d78dbf )
                    {
                        debug::sphere( entity getcentroid(), 5, ( 0, 1, 0 ), 5 );
                    }
                #/
                
                if ( !var_99b1bf58f96e3617 )
                {
                    var_a013bc3f1d49c41f = undefined;
                    thread startdrainlife( entity );
                }
                else
                {
                    var_a013bc3f1d49c41f = { #time:gettime(), #pos:undefined, #is_scriptable:0, #target:entity };
                }
                
                return [ 1, var_a013bc3f1d49c41f ];
            }
            
            continue;
        }
        
        if ( trace_result[ "hittype" ] == "hittype_scriptable" )
        {
            scriptable = trace_result[ "scriptable" ];
            
            if ( isdefined( scriptable ) && function_38a4ef2b1343c2de( scriptable ) )
            {
                if ( !function_a9e48e8e302ba59( scriptable ) )
                {
                    continue;
                }
                
                if ( distancesquared( self getcentroid(), scriptable.origin ) < drainliferange * drainliferange )
                {
                    if ( !var_99b1bf58f96e3617 )
                    {
                        var_a013bc3f1d49c41f = undefined;
                        thread startdrainlife( scriptable, 1, trace_result[ "position" ] );
                    }
                    else
                    {
                        var_a013bc3f1d49c41f = { #time:gettime(), #pos:trace_result[ "position" ], #is_scriptable:1, #target:scriptable };
                    }
                    
                    return [ 1, var_a013bc3f1d49c41f ];
                }
            }
        }
    }
    
    return [ 0, undefined ];
}

// Namespace mutant_injection_disciple_zombies
// Params 1, eflags: 0x4
// Checksum 0xa4987aac, Offset: 0x255b
// Size: 0xc3
function private function_c9779fb8eb0ba73e( target )
{
    if ( utility::issharedfuncdefined( self.micontext.var_d31dc7187a8cc4db, #"hash_dfab93a6c53cf329" ) )
    {
        return [[ utility::getsharedfunc( self.micontext.var_d31dc7187a8cc4db, #"hash_dfab93a6c53cf329" ) ]]( target );
    }
    
    if ( !isagent( target ) )
    {
        return 0;
    }
    
    if ( !isalive( target ) )
    {
        return 0;
    }
    
    if ( target.team == self.team )
    {
        return 0;
    }
    
    if ( target.aicategory == "boss" && target.subclass != "zombie_wither_scpq" )
    {
        return 0;
    }
    
    if ( !target isscriptable() )
    {
        return 0;
    }
    
    return 1;
}

// Namespace mutant_injection_disciple_zombies
// Params 3, eflags: 0x4
// Checksum 0x6b5be18c, Offset: 0x2627
// Size: 0x26d
function private startdrainlife( target, is_scriptable, scriptable_hit_point )
{
    level endon( #"game_ended" );
    bundle = self.micontext.bundle ?? level.streakglobals.streakbundles[ "zm_dinj" ];
    self.is_drain_life = 1;
    self setclientomnvar( "ui_zm_dinj_can_drain_life", 1 );
    set_allow_grab_zombie( 0, 1 );
    set_allow_scream( 0, 1 );
    msg = utility::waittill_any_timeout_no_endon_death( bundle.mutantinjectiondata.var_1e4c7230986ef477 ?? 0, "death_or_disconnect", "mutantinjection_end", "end_drain_life" );
    
    if ( msg != "timeout" )
    {
        return;
    }
    
    if ( !is_scriptable && !isalive( target ) )
    {
        end_drain_life();
        return;
    }
    
    if ( is_scriptable )
    {
        life_target_ent = utility::spawn_model( "tag_origin", scriptable_hit_point );
    }
    else
    {
        tag = target tagexists( "j_spine4" ) ? "j_spine4" : target tagexists( "J_MainRoot" ) ? "J_MainRoot" : "tag_origin";
        life_target_ent = utility::spawn_model( "tag_origin", target gettagorigin( tag ) );
        life_target_ent linkto( target, tag );
    }
    
    life_drain_ent = playfxontagsbetweenclients( utility::getfx( "minj_disciple_lifedrain_beam_fx" ), self, "tag_weapon_right", life_target_ent, "tag_origin" );
    
    if ( isdefined( life_drain_ent ) )
    {
        life_drain_ent namespace_9d8e359c3b1041e5::forcenetfieldhighlod_sharedfunc( 1 );
    }
    
    utility::function_32b24db3127bff40( "drainlife_beam_origin", "vfx_on" );
    
    if ( is_scriptable )
    {
        thread function_14d9bb8baeffdeb8( target, scriptable_hit_point );
    }
    else if ( isplayer( target ) && !player_utility::isenemy( target ) )
    {
        thread function_5ad291b959f53c5a( target );
    }
    else
    {
        thread function_9df236ee1d6b3ca8( target );
    }
    
    if ( self.is_drain_life )
    {
        utility::waittill_any( "death_or_disconnect", "mutantinjection_end", "end_drain_life" );
        
        if ( isdefined( life_target_ent ) )
        {
            life_target_ent delete();
        }
        
        if ( isdefined( life_drain_ent ) )
        {
            life_drain_ent delete();
        }
    }
    else
    {
        if ( isdefined( life_target_ent ) )
        {
            life_target_ent utility::delaycall( 0.5, &delete );
        }
        
        if ( isdefined( life_drain_ent ) )
        {
            life_drain_ent utility::delaycall( 0.5, &delete );
        }
    }
    
    if ( isdefined( self ) )
    {
        utility::function_32b24db3127bff40( "drainlife_beam_origin", "off" );
    }
}

// Namespace mutant_injection_disciple_zombies
// Params 1, eflags: 0x4
// Checksum 0x95024965, Offset: 0x289c
// Size: 0x1f2
function private function_9df236ee1d6b3ca8( target )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"mutantinjection_end" );
    self endon( #"end_drain_life" );
    bundle = self.micontext.bundle ?? level.streakglobals.streakbundles[ "zm_dinj" ];
    thread function_a3445e9e7dbbfc9a();
    
    while ( true )
    {
        if ( !isalive( target ) || !function_a9e48e8e302ba59( target ) )
        {
            end_drain_life();
            return;
        }
        
        base_zombie_maxhealth = function_5d1c9baecab4e975( target );
        var_9b557c33cd1d8180 = bundle.mutantinjectiondata.var_8315f2d2b3d0ae0b ?? 0;
        dodrainlife( target, int( var_9b557c33cd1d8180 * base_zombie_maxhealth ), 0 );
        a_zombies = getaiarrayinradius( target.origin, bundle.mutantinjectiondata.var_3c0c194377c8847d ?? 0 );
        var_61c0e7547c5e39b9 = bundle.mutantinjectiondata.var_85caa98c2eda82d6 ?? 0;
        var_7e4b9f5c15199a83 = int( var_61c0e7547c5e39b9 * base_zombie_maxhealth );
        
        foreach ( zombie in a_zombies )
        {
            if ( zombie == target )
            {
                continue;
            }
            
            if ( !function_c9779fb8eb0ba73e( zombie ) )
            {
                continue;
            }
            
            dodrainlife( zombie, var_7e4b9f5c15199a83, 1 );
        }
        
        target utility::waittill_notify_or_timeout( "death", 0.5 );
    }
}

// Namespace mutant_injection_disciple_zombies
// Params 2, eflags: 0x4
// Checksum 0xfab028a9, Offset: 0x2a96
// Size: 0x72, Type: bool
function private function_a9e48e8e302ba59( target, min_dot )
{
    var_ee6433c31961982d = vectornormalize2( target.origin - self.origin );
    forward = anglestoforward( self.angles );
    dot = vectordot( forward, var_ee6433c31961982d );
    
    if ( !isdefined( min_dot ) )
    {
        min_dot = 0.5;
    }
    
    return dot > min_dot;
}

// Namespace mutant_injection_disciple_zombies
// Params 3, eflags: 0x4
// Checksum 0x2b845a66, Offset: 0x2b11
// Size: 0x13d
function private dodrainlife( target, damage, is_aoe )
{
    weaponobj = self getcurrentweapon();
    
    if ( target getscriptablehaspart( "disciple_injection_drain_life" ) )
    {
        if ( is_aoe && target getscriptablepartstate( "disciple_injection_drain_life" ) != "vfx_on" )
        {
            target utility::function_32b24db3127bff40( "disciple_injection_drain_life", "aoe_vfx_on" );
        }
        else
        {
            target utility::function_32b24db3127bff40( "disciple_injection_drain_life", "vfx_on" );
        }
    }
    
    target.var_eaae2dc303d38fa8 = gettime();
    
    if ( !isdefined( self.var_ffc19da7b9004b02 ) )
    {
        self.var_ffc19da7b9004b02 = [];
    }
    
    self.var_ffc19da7b9004b02 = arraycombineunique( self.var_ffc19da7b9004b02, [ target ] );
    
    if ( damage >= target.health )
    {
        target utility::ent_flag_set( "dinj_lifedrain_kill" );
    }
    
    target dodamage( damage, target.origin + ( 0, 0, 30 ), self, self, "MOD_IMPACT", weaponobj, "torso_upper", undefined, 1073807360 );
    target function_a65a94049691a4e4( 0.5 );
    
    if ( !is_aoe && !isalive( target ) )
    {
        function_31e00c35c13bd665();
    }
}

// Namespace mutant_injection_disciple_zombies
// Params 0
// Checksum 0xd82bf1ce, Offset: 0x2c56
// Size: 0xd2
function function_31e00c35c13bd665()
{
    bundle = self.micontext.bundle ?? level.streakglobals.streakbundles[ "zm_dinj" ];
    var_d2783d9add315686 = ( bundle.mutantinjectiondata.var_d2783d9add315686 ?? 0 ) * 1000;
    var_e490c39353f287f1 = ( bundle.mutantinjectiondata.var_e490c39353f287f1 ?? 0 ) * 1000;
    increase_time = int( clamp( var_d2783d9add315686 - self.var_551543134a4a0a98, 0, var_e490c39353f287f1 ) );
    
    if ( increase_time > 0 )
    {
        increase_time = mutant_injection_utility::function_d56f1bba158cb4d6( increase_time );
        self.var_551543134a4a0a98 += increase_time;
    }
}

// Namespace mutant_injection_disciple_zombies
// Params 1, eflags: 0x4
// Checksum 0x7a29b8d3, Offset: 0x2d30
// Size: 0x11b
function private function_a65a94049691a4e4( drain_life_tick )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( isplayer( self ) )
    {
        return;
    }
    
    if ( zombie_traverse::is_traversing() )
    {
        return;
    }
    
    if ( !val::get( "pain" ) )
    {
        return;
    }
    
    var_10458571ed873c1a = "bloat_in";
    locomotion_animstate = "pain_in";
    speedsqr = lengthsquared( self.velocity );
    
    if ( speedsqr < 100 && self asmhasstate( self.asmname, var_10458571ed873c1a ) )
    {
        namespace_27d28dc1345f6289::function_2cd238f58ce9245b( 0.5 );
        return;
    }
    
    if ( self asmhasstate( self.asmname, locomotion_animstate ) )
    {
        current = self asmgetcurrentstate( self.asmname );
        
        if ( self asmhasstate( self.asmname, "pain_full_moving" ) )
        {
            if ( issubstr( current, "pain_full_moving" ) )
            {
                return;
            }
        }
        else if ( issubstr( current, "pain" ) )
        {
            return;
        }
        
        self.var_5609d8c260be3f0e = 1;
        asm::function_7256f5ba459c840b( locomotion_animstate );
        self.var_5609d8c260be3f0e = 0;
    }
}

// Namespace mutant_injection_disciple_zombies
// Params 0, eflags: 0x4
// Checksum 0xe0c4ee8c, Offset: 0x2e53
// Size: 0x186
function private function_a3445e9e7dbbfc9a()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( self.var_ffc19da7b9004b02 ) )
    {
        self.var_ffc19da7b9004b02 = [];
    }
    
    var_31bb99547dcb2b33 = utility::function_4b74c15943231980( 0.5 );
    
    while ( true )
    {
        self.var_ffc19da7b9004b02 = function_5713d46873b29625( self.var_ffc19da7b9004b02 );
        mutant_injection_ended = !self.ismutantinjection;
        
        if ( !self.var_ffc19da7b9004b02.size )
        {
            if ( mutant_injection_ended )
            {
                return;
            }
            
            waitframe();
            continue;
        }
        
        foreach ( idx, zombie in self.var_ffc19da7b9004b02 )
        {
            if ( !isalive( zombie ) )
            {
                self.var_ffc19da7b9004b02[ idx ] = undefined;
                continue;
            }
            
            if ( mutant_injection_ended || zombie.var_eaae2dc303d38fa8 && gettime() - zombie.var_eaae2dc303d38fa8 > var_31bb99547dcb2b33 )
            {
                if ( zombie getscriptablehaspart( "disciple_injection_drain_life" ) )
                {
                    zombie utility::function_32b24db3127bff40( "disciple_injection_drain_life", "off" );
                }
                
                self.var_ffc19da7b9004b02[ idx ] = undefined;
            }
        }
        
        if ( mutant_injection_ended )
        {
            self.var_ffc19da7b9004b02 = [];
            return;
        }
        
        wait 0.5;
    }
}

// Namespace mutant_injection_disciple_zombies
// Params 1, eflags: 0x4
// Checksum 0xdce28c3, Offset: 0x2fe1
// Size: 0xb9, Type: bool
function private function_fcd962177e8abc3b( other_player )
{
    if ( !isalive( other_player ) )
    {
        return false;
    }
    
    if ( player_utility::isenemy( other_player ) )
    {
        return true;
    }
    
    bundle = self.micontext.bundle ?? level.streakglobals.streakbundles[ "zm_dinj" ];
    
    if ( bundle.mutantinjectiondata.var_cd7eb57b7712622e )
    {
        return false;
    }
    
    if ( player::isinlaststand( other_player ) )
    {
        return true;
    }
    
    var_f76bdc312366e021 = 150;
    
    if ( function_e41450ae33515bc2( other_player ) || other_player.health >= 150 + var_f76bdc312366e021 )
    {
        return false;
    }
    
    return true;
}

// Namespace mutant_injection_disciple_zombies
// Params 1, eflags: 0x4
// Checksum 0x50ed9794, Offset: 0x30a3
// Size: 0x306
function private function_5ad291b959f53c5a( other_player )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    forcehealthregen = 0;
    otherplayer_beingrevived = 0;
    var_2dde5e85c74f5014 = 0;
    chargedhealth = 0;
    min_dot = 0;
    
    while ( self.ismutantinjection && self.is_drain_life )
    {
        var_d533a461192b7dc9 = function_a9e48e8e302ba59( other_player, min_dot );
        
        if ( player::isinlaststand( other_player ) )
        {
            if ( !otherplayer_beingrevived && !other_player.var_5a6f47ef38f87fcd && var_d533a461192b7dc9 )
            {
                if ( !other_player.beingrevived && isdefined( other_player.laststandreviveent ) )
                {
                    otherplayer_beingrevived = 1;
                    self.b_force_gameobject_use = 1;
                    val::set( "disciple_drain_life_revive_allies", "allow_revive_teammate", 1 );
                    val::set( "disciple_drain_life_revive_allies", "toggle_remote_revive", 1 );
                    other_player.beingremoterevived = 1;
                    reviveent = other_player.laststandreviveent;
                    reviveent notify( #"trigger", self );
                }
            }
            else if ( otherplayer_beingrevived && !var_d533a461192b7dc9 )
            {
                end_drain_life();
                function_46cb6a37019f5f00( other_player );
                return;
            }
        }
        else
        {
            if ( !isalive( other_player ) || !var_d533a461192b7dc9 )
            {
                end_drain_life();
                return;
            }
            
            if ( other_player.var_d59ca4d0486808e3 > gettime() )
            {
                end_drain_life();
                return;
            }
            
            if ( !forcehealthregen && other_player.health < other_player.maxhealth )
            {
                playerhealth::forcehealthregen( other_player );
                forcehealthregen = 1;
            }
            
            if ( var_2dde5e85c74f5014 <= gettime() )
            {
                var_2dde5e85c74f5014 = gettime() + utility::function_4b74c15943231980( 0.5 );
                var_1fbf7c5cd8531620 = int( min( 10, 150 - chargedhealth ) );
                result = health_overcharge::function_f6da758a8ee4c988( other_player, "disciple_drain_life_on_allies", var_1fbf7c5cd8531620, 150 );
                
                if ( !result )
                {
                    /#
                        if ( getdvarint( @"hash_3204b12e758bb7bb", 0 ) )
                        {
                            println( "<dev string:x24>" + other_player.name + "<dev string:x43>" );
                        }
                    #/
                    
                    other_player.var_d59ca4d0486808e3 = gettime() + 10000;
                }
                else
                {
                    other_player.var_98d0b18c22a05924 = gettime();
                    chargedhealth += var_1fbf7c5cd8531620;
                    
                    if ( chargedhealth >= 150 )
                    {
                        other_player.var_d59ca4d0486808e3 = gettime() + 10000;
                    }
                }
            }
        }
        
        msg = other_player utility::waittill_any_timeout_no_endon_death( level.framedurationseconds, "death_or_disconnect", "last_stand_exit" );
        
        if ( !isdefined( self ) )
        {
            if ( isdefined( other_player ) )
            {
                other_player.beingremoterevived = undefined;
            }
            
            return;
        }
        
        if ( msg != "timeout" )
        {
            if ( otherplayer_beingrevived )
            {
                otherplayer_beingrevived = 0;
                function_46cb6a37019f5f00( other_player );
            }
            
            if ( msg == "death_or_disconnect" )
            {
                end_drain_life();
                return;
            }
        }
    }
    
    if ( otherplayer_beingrevived )
    {
        function_46cb6a37019f5f00( other_player );
    }
}

// Namespace mutant_injection_disciple_zombies
// Params 1, eflags: 0x4
// Checksum 0xb3bb3835, Offset: 0x33b1
// Size: 0x3d, Type: bool
function private function_e41450ae33515bc2( other_player )
{
    if ( other_player.var_d59ca4d0486808e3 > gettime() )
    {
        return true;
    }
    
    if ( other_player.var_98d0b18c22a05924 > gettime() - 10000 )
    {
        return true;
    }
    
    return false;
}

// Namespace mutant_injection_disciple_zombies
// Params 1, eflags: 0x4
// Checksum 0xda38d4a, Offset: 0x33f7
// Size: 0x33
function private function_46cb6a37019f5f00( other_player )
{
    if ( isdefined( other_player ) )
    {
        other_player.beingremoterevived = undefined;
    }
    
    self.b_force_gameobject_use = 0;
    val::reset_all( "disciple_drain_life_revive_allies" );
}

// Namespace mutant_injection_disciple_zombies
// Params 1, eflags: 0x4
// Checksum 0xe7a9f324, Offset: 0x3432
// Size: 0x53
function private function_38a4ef2b1343c2de( scriptable )
{
    if ( !isarray( level.var_ced5070235ce306f ) || !level.var_ced5070235ce306f.size )
    {
        return 0;
    }
    
    level.var_ced5070235ce306f = function_5713d46873b29625( level.var_ced5070235ce306f );
    return arraycontains( level.var_ced5070235ce306f, scriptable );
}

// Namespace mutant_injection_disciple_zombies
// Params 2, eflags: 0x4
// Checksum 0x50a714cf, Offset: 0x348e
// Size: 0x8c
function private function_14d9bb8baeffdeb8( scriptable, detonate_point )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"mutantinjection_end" );
    self endon( #"end_drain_life" );
    
    while ( isdefined( self ) && isdefined( scriptable ) )
    {
        if ( !function_a9e48e8e302ba59( scriptable ) )
        {
            break;
        }
        
        scriptable scriptabledodamage( 50, self, self, detonate_point, undefined, "MOD_PROJECTILE", self getcurrentweapon() );
        wait 0.5;
    }
    
    if ( isdefined( self ) )
    {
        end_drain_life();
    }
}

// Namespace mutant_injection_disciple_zombies
// Params 0
// Checksum 0x90bc5619, Offset: 0x3522
// Size: 0x22d
function function_c700123edd4ca05f()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self.var_34e5ed2f209562d9 = 0;
    zombie_grabbed = undefined;
    var_2b707d0759db3b79 = 0;
    var_3707bc359f1bbb97 = 0;
    throw_start_time = 0;
    check_interval = 50;
    next_check_time = 0;
    var_b59f95cbf4629482 = undefined;
    self.var_758083a6ed84b2e5 = 1;
    
    while ( self.ismutantinjection )
    {
        if ( var_2b707d0759db3b79 )
        {
            if ( !self adsbuttonpressed() )
            {
                var_2b707d0759db3b79 = 0;
            }
        }
        
        if ( !is_allow_grab_zombie() )
        {
            waitframe();
            continue;
        }
        
        if ( !is_grabbing_zombie() && gettime() > var_3707bc359f1bbb97 )
        {
            if ( gettime() >= next_check_time )
            {
                next_check_time = gettime() + check_interval;
                var_b59f95cbf4629482 = function_49c9acd25cda5712();
            }
            
            if ( !var_2b707d0759db3b79 && self adsbuttonpressed() )
            {
                if ( var_b59f95cbf4629482 && function_2b0a975a1895015c( var_b59f95cbf4629482.target ) && gettime() - var_b59f95cbf4629482.time < check_interval )
                {
                    zombie_grabbed = var_b59f95cbf4629482.target;
                    thread startgrab( var_b59f95cbf4629482.target, var_b59f95cbf4629482.pos );
                }
                else
                {
                    [ can_grab, zombie_grabbed, pos ] = function_1e21d59ca6c33f1f();
                }
                
                var_b59f95cbf4629482 = undefined;
                
                if ( is_grabbing_zombie() )
                {
                    self setclientomnvar( "ui_zm_dinj_grabbed_zombie", 2 );
                    var_2b707d0759db3b79 = 1;
                    throw_start_time = gettime() + 1200;
                    
                    /#
                        if ( getdvarint( @"hash_84e5fb0c47036d1b", 0 ) )
                        {
                            println( "<dev string:x6e>" + zombie_grabbed getentitynumber() );
                        }
                    #/
                }
            }
        }
        else if ( is_grabbing_zombie() && !var_2b707d0759db3b79 && ( self adsbuttonpressed() || self attackbuttonpressed() ) && gettime() > throw_start_time )
        {
            thread function_4d8bc547878676bb( zombie_grabbed, 1 );
            var_3707bc359f1bbb97 = gettime() + 1600;
            
            if ( self adsbuttonpressed() )
            {
                var_2b707d0759db3b79 = 1;
            }
        }
        
        waitframe();
    }
    
    if ( is_grabbing_zombie() )
    {
        thread function_4d8bc547878676bb( zombie_grabbed, 0 );
    }
}

// Namespace mutant_injection_disciple_zombies
// Params 0, eflags: 0x4
// Checksum 0xbeecb672, Offset: 0x3757
// Size: 0xb
function private is_allow_grab_zombie()
{
    return self.var_758083a6ed84b2e5;
}

// Namespace mutant_injection_disciple_zombies
// Params 2, eflags: 0x4
// Checksum 0x2560d2c0, Offset: 0x376b
// Size: 0xc6
function private set_allow_grab_zombie( allow, exclusive_attack )
{
    var_39791706438e83c3 = "disc_cannot_grab_zombie";
    var_f06e8757884d4fdc = "disc_grab_no_candidate";
    
    if ( !isdefined( exclusive_attack ) )
    {
        exclusive_attack = 0;
    }
    
    str_id = exclusive_attack ? var_39791706438e83c3 : var_f06e8757884d4fdc;
    
    if ( !isdefined( allow ) )
    {
        val::reset_all( var_39791706438e83c3 );
        val::reset_all( var_f06e8757884d4fdc );
        self.var_758083a6ed84b2e5 = undefined;
        return;
    }
    
    if ( allow )
    {
        val::reset_all( str_id );
    }
    else
    {
        val::set( str_id, "ads", 0 );
    }
    
    self setclientomnvar( "ui_zm_dinj_grabbed_zombie", val::get( "ads" ) ? 1 : 0 );
    
    if ( exclusive_attack )
    {
        self.var_758083a6ed84b2e5 = allow;
    }
}

// Namespace mutant_injection_disciple_zombies
// Params 0, eflags: 0x4
// Checksum 0x227f0009, Offset: 0x3839
// Size: 0xb
function private is_grabbing_zombie()
{
    return self.var_34e5ed2f209562d9;
}

// Namespace mutant_injection_disciple_zombies
// Params 0, eflags: 0x4
// Checksum 0x31073708, Offset: 0x384d
// Size: 0x8c
function private function_49c9acd25cda5712()
{
    [ can_grab, target, pos ] = function_1e21d59ca6c33f1f( 1 );
    
    if ( can_grab )
    {
        var_b59f95cbf4629482 = { #time:gettime(), #pos:pos, #target:target };
        set_allow_grab_zombie( 1 );
    }
    else
    {
        var_b59f95cbf4629482 = undefined;
        set_allow_grab_zombie( 0 );
    }
    
    return var_b59f95cbf4629482;
}

// Namespace mutant_injection_disciple_zombies
// Params 1, eflags: 0x4
// Checksum 0xe2eabbd8, Offset: 0x38e2
// Size: 0x125
function private function_1e21d59ca6c33f1f( var_99b1bf58f96e3617 )
{
    trace_results = function_27012cbfbfa4ff05();
    
    foreach ( trace_result in trace_results )
    {
        if ( trace_result[ "hittype" ] == "hittype_entity" )
        {
            entity = trace_result[ "entity" ];
            
            if ( !isagent( entity ) || !function_2b0a975a1895015c( entity ) )
            {
                continue;
            }
            
            if ( !function_a9e48e8e302ba59( entity, 0 ) )
            {
                continue;
            }
            
            if ( distancesquared( self getcentroid(), entity getcentroid() ) < 40000 )
            {
                if ( !var_99b1bf58f96e3617 )
                {
                    thread startgrab( entity, trace_result[ "position" ] );
                }
                
                return [ 1, entity, trace_result[ "position" ] ];
            }
        }
    }
    
    return [ 0, undefined, undefined ];
}

// Namespace mutant_injection_disciple_zombies
// Params 1, eflags: 0x4
// Checksum 0x28b3378c, Offset: 0x3a10
// Size: 0x17d
function private function_2b0a975a1895015c( target )
{
    if ( utility::issharedfuncdefined( self.micontext.var_d31dc7187a8cc4db, #"hash_2f14a34a4aa8f645" ) )
    {
        return [[ utility::getsharedfunc( self.micontext.var_d31dc7187a8cc4db, #"hash_2f14a34a4aa8f645" ) ]]( target );
    }
    
    if ( !isalive( target ) )
    {
        return 0;
    }
    
    if ( target.team == self.team )
    {
        return 0;
    }
    
    if ( target.disallow_grab )
    {
        return 0;
    }
    
    if ( target.magic_bullet_shield || target.damageshield || !target val::get( "death" ) )
    {
        return 0;
    }
    
    if ( isanimscripted( target ) )
    {
        return 0;
    }
    
    return target.subclass && ( issubstr( target.subclass, "zombie_base" ) || issubstr( target.subclass, "zombie_base_armored_light" ) || issubstr( target.subclass, "zombie_base_armored_heavy" ) || issubstr( target.subclass, "zombie_shade" ) || issubstr( target.subclass, "zombie_methone" ) || issubstr( target.subclass, "zombie_hellhound" ) || issubstr( target.subclass, "zombie_loom_minion" ) );
}

// Namespace mutant_injection_disciple_zombies
// Params 2, eflags: 0x4
// Checksum 0x4c42b7dc, Offset: 0x3b96
// Size: 0x2aa
function private startgrab( target, trace_pos )
{
    level endon( #"game_ended" );
    self.var_34e5ed2f209562d9 = 1;
    self setcarryobject( "zm_dinj_grab_zombie" );
    set_allow_scream( 0, 1 );
    set_allow_drain_life( 0, 1 );
    val::set( "disciple_grab_zombie", "sprint", 0 );
    target val::set( "disciple_grab_zombie", "damage", 0 );
    target val::set( "disciple_grab_zombie", "allow_brot", 0 );
    target val::set( "disciple_grab_zombie", "disallow_knockdown", 1 );
    target val::set( "disciple_grab_zombie", "disallow_stun", 1 );
    target val::set( "disciple_grab_zombie", "disable_elemental_effect", 1 );
    target utility::ent_flag_set( "grabbed" );
    
    if ( target.is_living_world_ai && !target.var_9686e1897a9ce028 )
    {
        thread function_e170ea5808b4f1a5( target );
        return;
    }
    
    if ( target.is_living_world_ai )
    {
        target.animname = target.animsetname;
    }
    
    thread function_7ddecf9351c51cdc( target, trace_pos );
    grabbed_anim = get_grabbed_anim( target );
    
    if ( target utility::callsharedfunc( #"ai", #"hash_eeabeb442ca0054", grabbed_anim ) )
    {
        target thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( grabbed_anim, "grabbed_end", target.origin, target.angles, undefined, 1 );
        target.grabbed_anim_ended = 0;
        utility::function_32b24db3127bff40( "grab_holding_vfx", "vfx_on" );
        target utility::function_32b24db3127bff40( "disciple_injection_grab_holding", "vfx_on" );
        msg = level utility::waittill_any_ents_or_timeout_return( 2, target, "grabbed_end", target, "disciple_throw_zombie", target, "death", self, "mutantinjection_end", self, "death_or_disconnect" );
        
        switch ( msg )
        {
            case #"hash_4d94fa063483a2e0":
                return;
            case #"hash_e8bc3da4af287c2d":
                thread function_d822861a89903a27();
                return;
            case #"hash_4318233c73472b69":
                return;
            case #"hash_cbbbbafae54d0dd6":
                target kill();
                return;
            default:
                target.grabbed_anim_ended = 1;
                break;
        }
    }
    
    grabbed_loop_anim = function_b2a6bd32a3498065( target );
    
    if ( target utility::callsharedfunc( #"ai", #"hash_eeabeb442ca0054", grabbed_loop_anim ) )
    {
        target thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( grabbed_loop_anim, grabbed_loop_anim, target.origin, target.angles, undefined, 1 );
    }
}

// Namespace mutant_injection_disciple_zombies
// Params 1, eflags: 0x4
// Checksum 0xd28dcf07, Offset: 0x3e48
// Size: 0x72
function private get_grabbed_anim( target )
{
    grabbed_anim = "disciple_injection_grabbed";
    target.var_a2a53228f696d97f = 0;
    
    if ( level.scr_anim[ target.animname ][ grabbed_anim + "_alt" ] && randomint( 100 ) > 50 )
    {
        grabbed_anim += "_alt";
        target.var_a2a53228f696d97f = 1;
    }
    
    return grabbed_anim;
}

// Namespace mutant_injection_disciple_zombies
// Params 1, eflags: 0x4
// Checksum 0x9a9556ae, Offset: 0x3ec3
// Size: 0x37
function private function_b2a6bd32a3498065( target )
{
    grabbed_loop_anim = "disciple_injection_grabbed_loop";
    
    if ( target.var_a2a53228f696d97f )
    {
        grabbed_loop_anim += "_alt";
    }
    
    return grabbed_loop_anim;
}

// Namespace mutant_injection_disciple_zombies
// Params 1, eflags: 0x4
// Checksum 0xc0c2f306, Offset: 0x3f03
// Size: 0xdd
function private function_e170ea5808b4f1a5( target )
{
    level endon( #"game_ended" );
    target utility::function_32b24db3127bff40( "disciple_injection_grab_holding", "vfx_on" );
    msg = level utility::waittill_any_ents_or_timeout_return( 0.1, target, "disciple_throw_zombie", target, "death", self, "mutantinjection_end", self, "death_or_disconnect" );
    
    switch ( msg )
    {
        case #"hash_4d94fa063483a2e0":
            return;
        case #"hash_e8bc3da4af287c2d":
            if ( is_grabbing_zombie() )
            {
                thread function_d822861a89903a27();
            }
            
            return;
        case #"hash_4318233c73472b69":
            return;
        case #"hash_cbbbbafae54d0dd6":
            target function_b2677b51d9d07f5b();
            return;
        default:
            break;
    }
    
    target function_b2677b51d9d07f5b( self );
    
    if ( is_grabbing_zombie() )
    {
        thread function_d822861a89903a27();
    }
}

// Namespace mutant_injection_disciple_zombies
// Params 1, eflags: 0x4
// Checksum 0x58f80b76, Offset: 0x3fe8
// Size: 0x7f
function private function_b2677b51d9d07f5b( attacker )
{
    val::reset_all( "disciple_grab_zombie" );
    val::reset_all( "scene_shot" );
    
    if ( attacker )
    {
        self kill( self.origin, attacker, attacker, "MOD_CRUSH", attacker getcurrentweapon() );
    }
    else
    {
        self kill();
    }
    
    corpse = self getcorpseentity();
    
    if ( corpse )
    {
        corpse utility::function_32b24db3127bff40( "disciple_injection_grab_holding", "vfx_on" );
        corpse startragdoll();
    }
}

// Namespace mutant_injection_disciple_zombies
// Params 2, eflags: 0x4
// Checksum 0x80dd1e9d, Offset: 0x406f
// Size: 0x9bb
function private function_7ddecf9351c51cdc( target, trace_pos )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( self ) || !self.ismutantinjection || !is_grabbing_zombie() )
    {
        return;
    }
    
    if ( !isalive( target ) )
    {
        return;
    }
    
    angles = self getplayerangles();
    grab_dist = clamp( distance( self.origin, target.origin ), 0, 200 );
    var_ee6433c31961982d = target.origin - self.origin;
    original_delta_angles = vectortoangles( var_ee6433c31961982d ) - angles;
    var_313395549b5025e1 = function_139b027f7f05bb7c( original_delta_angles );
    last_angles = angles;
    z_offset = trace_pos[ 2 ] - target.origin[ 2 ];
    var_c51215b779b5fe59 = self.origin - target.origin;
    to_player_angles = vectortoangles( var_c51215b779b5fe59 );
    facing_yaw_offset = angleclamp180( to_player_angles[ 1 ] - target.angles[ 1 ] + var_313395549b5025e1[ 1 ] - original_delta_angles[ 1 ] );
    var_5239473c3fae77e8 = utility::spawn_tag_origin( target.origin, target.angles );
    self.var_5253d29e09253a4f = var_5239473c3fae77e8;
    var_5239473c3fae77e8.grab_z_offset = z_offset;
    spine_offset = target gettagorigin( "j_spine4" ) - target.origin;
    var_5239473c3fae77e8.spine_z_offset = spine_offset[ 2 ];
    radius = target.radius ?? 15;
    var_6f6548957da2f4f2 = grab_dist;
    player_last_pos = self.origin;
    var_af0487e30a5fe543 = undefined;
    head_z_offset = 0;
    target motionwarpcancel();
    target linkto( var_5239473c3fae77e8, "tag_origin" );
    var_c5a2b60cd6b98689 = ( 0, 0, 0 );
    var_9a5f00b02e985845 = ( 0, 0, 1.5 );
    hold_yaw_offset = 0;
    hold_z_offset = 0;
    [ var_5d3f2a05ce64229, var_3c445186984a8b3a, var_28e347c3fe7f2cb7, hold_min_distance ] = target function_caeffd0247112fd1( var_313395549b5025e1[ 1 ], z_offset );
    waitframe();
    
    while ( isdefined( self ) && self.ismutantinjection && is_grabbing_zombie() )
    {
        if ( !isalive( target ) )
        {
            thread function_4d8bc547878676bb( target, 0 );
            return;
        }
        
        if ( facing_yaw_offset != 0 )
        {
            abs_offset = abs( facing_yaw_offset );
            yaw_step = int( min( abs_offset, 10 ) );
            
            if ( facing_yaw_offset < 0 )
            {
                yaw_step *= -1;
            }
            
            var_5239473c3fae77e8.angles += ( 0, yaw_step, 0 );
            facing_yaw_offset -= yaw_step;
        }
        
        if ( hold_yaw_offset != var_5d3f2a05ce64229 )
        {
            hold_yaw_offset += var_3c445186984a8b3a;
        }
        
        if ( hold_z_offset < var_28e347c3fe7f2cb7 )
        {
            hold_z_offset += 1;
            var_5239473c3fae77e8.grab_z_offset += 1;
        }
        
        angles = self getplayerangles();
        new_angles = angles + var_313395549b5025e1 + ( 0, hold_yaw_offset, 0 );
        forward = anglestoforward( new_angles );
        trace_dist = grab_dist + radius;
        pos = self.origin + trace_dist * forward + ( 0, 0, hold_z_offset );
        var_e2fb812c18e59daa = target gettagorigin( "j_head" ) - target.origin;
        head_z_offset = max( head_z_offset, var_e2fb812c18e59daa[ 2 ] + 5 );
        v_offset = ( 0, 0, head_z_offset );
        start = self.origin + v_offset;
        end = pos + v_offset;
        [ can_move, trace ] = function_872e11bb209c7ddd( start, end, radius, [ self, target ] );
        
        /#
            var_2a906a7bc70878d7 = 0;
            
            if ( getdvarint( @"hash_84e5fb0c47036d1b", 0 ) )
            {
                var_2a906a7bc70878d7 = 1;
                debug::line( start, end, can_move ? ( 1, 1, 1 ) : ( 1, 0, 0 ), 0.1 );
            }
        #/
        
        if ( can_move )
        {
            if ( target tagexists( "J_Knee_RI" ) )
            {
                knee_offset = target gettagorigin( "J_Knee_RI" ) - target.origin;
                start2 = self.origin + ( 0, 0, knee_offset[ 2 ] );
                end2 = pos + ( 0, 0, knee_offset[ 2 ] );
                [ var_9df146cb06a46e96, trace2 ] = function_872e11bb209c7ddd( start2, end2, radius, [ self, target ] );
                
                if ( !var_9df146cb06a46e96 )
                {
                    collided_dist = trace2[ "fraction" ] * trace_dist - radius;
                    
                    if ( collided_dist > 50 )
                    {
                        can_move = 1;
                        pos = self.origin + collided_dist * forward + ( 0, 0, hold_z_offset );
                        var_6f6548957da2f4f2 = collided_dist;
                    }
                    else
                    {
                        can_move = 0;
                        trace = trace2;
                        v_offset = ( 0, 0, knee_offset[ 2 ] );
                    }
                }
                
                /#
                    if ( var_2a906a7bc70878d7 )
                    {
                        debug::line( start2, end2, var_9df146cb06a46e96 ? ( 1, 1, 1 ) : ( 1, 0, 0 ), 0.1 );
                    }
                #/
            }
        }
        
        if ( !can_move )
        {
            /#
                if ( var_2a906a7bc70878d7 )
                {
                    debug::sphere( trace[ "<dev string:x85>" ], 5, ( 1, 0, 0 ), 0.1 );
                }
            #/
            
            if ( trace[ "fraction" ] * trace_dist < 50 )
            {
                thread function_4d8bc547878676bb( target, 0 );
                
                /#
                    if ( var_2a906a7bc70878d7 )
                    {
                        println( "<dev string:x8e>" );
                    }
                #/
                
                break;
            }
            else
            {
                collided_dist = trace[ "fraction" ] * trace_dist - radius;
                collided_pos = self.origin + collided_dist * forward + v_offset;
                
                /#
                    if ( var_2a906a7bc70878d7 )
                    {
                        var_27f9e1ed860652f3 = 3;
                        debug::line( target.origin + v_offset, collided_pos, ( 0, 1, 0 ), var_27f9e1ed860652f3 );
                    }
                #/
                
                [ can_move, trace ] = function_872e11bb209c7ddd( target.origin + v_offset, collided_pos, radius, [ self, target ] );
                
                if ( !can_move )
                {
                    if ( collided_dist < var_6f6548957da2f4f2 )
                    {
                        last_dir = vectornormalize( target.origin - player_last_pos );
                        mid_point = player_last_pos + collided_dist * last_dir + v_offset;
                    }
                    else
                    {
                        mid_point = self.origin + var_6f6548957da2f4f2 * forward + v_offset;
                    }
                    
                    [ can_move, trace ] = function_872e11bb209c7ddd( mid_point, collided_pos, radius, [ self, target ] );
                    
                    /#
                        if ( var_2a906a7bc70878d7 )
                        {
                            var_27f9e1ed860652f3 = can_move ? 3 : 10;
                            color = can_move ? ( 0, 1, 0 ) : ( 1, 0, 0 );
                            debug::line( mid_point, collided_pos, color, var_27f9e1ed860652f3 );
                            
                            if ( !can_move )
                            {
                                if ( isdefined( trace[ "<dev string:x85>" ] ) )
                                {
                                    debug::sphere( trace[ "<dev string:x85>" ], 5, color, var_27f9e1ed860652f3 );
                                }
                                
                                debug::sphere( mid_point, 5, ( 0, 1, 1 ), var_27f9e1ed860652f3 );
                                debug::sphere( collided_pos, 5, color, var_27f9e1ed860652f3 );
                            }
                        }
                    #/
                }
                
                if ( can_move )
                {
                    pos = collided_pos - v_offset;
                    var_6f6548957da2f4f2 = collided_dist;
                }
                else
                {
                    thread function_4d8bc547878676bb( target, 0 );
                    break;
                }
            }
        }
        else
        {
            if ( grab_dist < hold_min_distance )
            {
                move_away_dist = 5;
                camera_forward = forward;
                end = pos + ( move_away_dist + radius ) * camera_forward;
                [ can_move, trace ] = function_872e11bb209c7ddd( pos + v_offset, end + v_offset, radius, [ self, target ] );
                
                if ( can_move )
                {
                    pos += move_away_dist * camera_forward;
                    grab_dist = distance( self.origin, pos );
                    var_ee6433c31961982d = pos - self.origin;
                    var_313395549b5025e1 = function_139b027f7f05bb7c( vectortoangles( var_ee6433c31961982d ) - angles );
                }
            }
            
            var_6f6548957da2f4f2 = grab_dist;
        }
        
        passed = function_df96459039712340( target, pos + v_offset, radius );
        
        if ( !passed )
        {
            var_af0487e30a5fe543 = pos;
            var_c5a2b60cd6b98689 += var_9a5f00b02e985845;
            pos += var_c5a2b60cd6b98689;
        }
        else if ( var_c5a2b60cd6b98689[ 2 ] > 0 )
        {
            if ( var_af0487e30a5fe543[ 2 ] < pos[ 2 ] - var_9a5f00b02e985845[ 2 ] )
            {
                var_c5a2b60cd6b98689 -= var_9a5f00b02e985845;
            }
            
            pos += var_c5a2b60cd6b98689;
        }
        
        var_5239473c3fae77e8.origin = pos;
        var_5239473c3fae77e8.angles += ( 0, angles[ 1 ] - last_angles[ 1 ], 0 );
        var_5239473c3fae77e8.angles = angleclamp180( var_5239473c3fae77e8.angles );
        last_angles = angles;
        player_last_pos = self.origin;
        
        /#
            if ( var_2a906a7bc70878d7 )
            {
                debug::sphere( pos + v_offset, 5, ( 0, 1, 0 ), 0.05 );
            }
        #/
        
        waitframe();
    }
    
    if ( isdefined( target ) && target islinked() )
    {
        target unlink();
    }
}

// Namespace mutant_injection_disciple_zombies
// Params 1, eflags: 0x4
// Checksum 0x5fae3869, Offset: 0x4a32
// Size: 0x47
function private function_139b027f7f05bb7c( var_313395549b5025e1 )
{
    var_23a7ec979fd4a84c = clamp( angleclamp180( var_313395549b5025e1[ 0 ] ), -40, 0 );
    var_dfd81338b20e87b1 = clamp( angleclamp180( var_313395549b5025e1[ 1 ] ), -30, 0 );
    return ( var_23a7ec979fd4a84c, var_dfd81338b20e87b1, var_313395549b5025e1[ 2 ] );
}

// Namespace mutant_injection_disciple_zombies
// Params 2, eflags: 0x4
// Checksum 0xab2bad0d, Offset: 0x4a82
// Size: 0xd5
function private function_caeffd0247112fd1( delta_yaw, grab_z_offset )
{
    height = self.height ?? 70;
    max_z_offset = grab_z_offset / height * 30;
    
    if ( self.subclass == "zombie_shade" )
    {
        max_z_offset *= 0.5;
    }
    
    if ( delta_yaw > -25 )
    {
        var_5d3f2a05ce64229 = 13;
        var_3c445186984a8b3a = 1;
        var_28e347c3fe7f2cb7 = int( max_z_offset );
        hold_min_distance = 100;
    }
    else
    {
        var_5d3f2a05ce64229 = -13;
        var_3c445186984a8b3a = -1;
        var_28e347c3fe7f2cb7 = int( max_z_offset * 0.65 );
        hold_min_distance = int( 65 );
    }
    
    return [ var_5d3f2a05ce64229, var_3c445186984a8b3a, var_28e347c3fe7f2cb7, hold_min_distance ];
}

// Namespace mutant_injection_disciple_zombies
// Params 5, eflags: 0x4
// Checksum 0x6d1bca7f, Offset: 0x4b60
// Size: 0xc4
function private function_872e11bb209c7ddd( start, end, radius, ignore_entities, ignore_characters = 1 )
{
    if ( !isdefined( level.var_93786901d31235cb ) || level.var_9525ea6f99fe94e3 != ignore_characters )
    {
        level.var_93786901d31235cb = trace::create_default_contents( ignore_characters ) | trace::create_solid_ai_contents( ignore_characters );
        level.var_9525ea6f99fe94e3 = ignore_characters;
    }
    
    trace = trace::ray_trace( start, end, ignore_entities, level.var_93786901d31235cb, 1, undefined, 1 );
    passed = trace[ "fraction" ] >= 0.95;
    return [ passed, trace ];
}

// Namespace mutant_injection_disciple_zombies
// Params 3, eflags: 0x4
// Checksum 0xed8176d7, Offset: 0x4c2d
// Size: 0x127
function private function_df96459039712340( target, pos, radius )
{
    assert( isalive( target ) );
    
    if ( target tagexists( "j_ball_ri" ) )
    {
        foot_pos = target gettagorigin( "j_ball_ri" );
        end_pos = ( pos[ 0 ], pos[ 1 ], foot_pos[ 2 ] );
        [ passed, trace ] = function_872e11bb209c7ddd( pos - ( 0, 0, 10 ), end_pos - ( 0, 0, 5 ), radius, [ self, target ] );
        
        /#
            if ( getdvarint( @"hash_84e5fb0c47036d1b", 0 ) )
            {
                color = passed ? ( 0, 1, 0 ) : ( 1, 0, 0 );
                debug::line( pos, end_pos, color, 0.05 );
                debug::sphere( end_pos, 5, color, 0.05 );
            }
        #/
        
        return passed;
    }
    
    return 1;
}

// Namespace mutant_injection_disciple_zombies
// Params 1, eflags: 0x4
// Checksum 0x7c3c8e15, Offset: 0x4d5d
// Size: 0xc5
function private function_d822861a89903a27( is_thrown )
{
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( is_thrown ) )
    {
        is_thrown = 0;
    }
    
    self.var_34e5ed2f209562d9 = 0;
    self resetcarryobject();
    
    if ( self getscriptablehaspart( "grab_holding_vfx" ) )
    {
        utility::function_32b24db3127bff40( "grab_holding_vfx", "off" );
    }
    
    if ( !self.ismutantinjection )
    {
        return;
    }
    
    set_allow_grab_zombie( 0 );
    msg = undefined;
    
    if ( is_thrown )
    {
        msg = utility::waittill_notify_or_timeout_return( "mutantinjection_end", utility::function_6f5d2e1f1ff70482( 1600 ) );
    }
    
    if ( self && ( !msg || msg == "timeout" ) )
    {
        val::reset_all( "disciple_grab_zombie" );
        set_allow_scream( 1, 1 );
        set_allow_drain_life( 1, 1 );
    }
}

// Namespace mutant_injection_disciple_zombies
// Params 2, eflags: 0x4
// Checksum 0xf593e44f, Offset: 0x4e2a
// Size: 0x7e4
function private function_4d8bc547878676bb( target, is_thrown )
{
    if ( !is_grabbing_zombie() )
    {
        return;
    }
    
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    /#
        if ( getdvarint( @"hash_84e5fb0c47036d1b", 0 ) )
        {
            println( "<dev string:xc4>" );
        }
    #/
    
    thread function_d822861a89903a27( is_thrown );
    
    if ( !isdefined( target ) )
    {
        if ( self.var_5253d29e09253a4f )
        {
            self.var_5253d29e09253a4f delete();
        }
        
        return;
    }
    
    if ( self getscriptablehaspart( "grab_throw" ) )
    {
        utility::function_32b24db3127bff40( "grab_throw", "vfx_on" );
    }
    
    target notify( #"disciple_throw_zombie" );
    target utility::ent_flag_clear( "grabbed" );
    throw_end_pos = function_f4db8a266d0c1fd7( target );
    var_73e00b64c68884c5 = 5;
    
    if ( isalive( target ) )
    {
        spine_pos = target gettagorigin( "j_spine4" );
        dir = vectornormalize( throw_end_pos - spine_pos );
        maxhealth = function_5d1c9baecab4e975( target );
        spine_offset = target gettagorigin( "j_spine4" ) - target.origin;
        spine_z_offset = spine_offset[ 2 ];
        
        if ( target getscriptablehaspart( "disciple_injection_grab_holding" ) )
        {
            target utility::function_32b24db3127bff40( "disciple_injection_grab_holding", "off" );
        }
        
        blackboard_data = target.var_a2a53228f696d97f > 0 ? 2 : 1;
        target function_786bb6aa1b76c7ee( "death_disc_thrown", blackboard_data );
        
        if ( target.subclass && ( issubstr( target.subclass, "zombie_methone" ) || issubstr( target.subclass, "zombie_hellhound" ) ) )
        {
            target.explode_time_override = var_73e00b64c68884c5;
        }
        
        target.script_noragdoll = 1;
        target.iscorpsefalling = 0;
        target kill( target.origin, self, self, "MOD_CRUSH", self getcurrentweapon() );
    }
    else
    {
        var_4c4e176066702e93 = 1;
    }
    
    corpse = target getcorpseentity();
    
    if ( !isdefined( corpse ) )
    {
        if ( self.var_5253d29e09253a4f )
        {
            self.var_5253d29e09253a4f delete();
        }
        
        return;
    }
    
    mover = self.var_5253d29e09253a4f;
    corpse.angles = mover.angles ?? target.angles;
    
    if ( var_4c4e176066702e93 || !is_thrown )
    {
        spine_pos = corpse gettagorigin( "j_spine4" );
        dir = ( 0, 0, -1 );
        spine_offset = spine_pos - corpse.origin;
        spine_z_offset = spine_offset[ 2 ];
        maxhealth = function_5d1c9baecab4e975( target );
    }
    
    if ( corpse getscriptablehaspart( "disciple_injection_grab_throw" ) )
    {
        corpse utility::function_32b24db3127bff40( "disciple_injection_grab_throw", "vfx_on" );
    }
    
    corpse endon( #"death" );
    corpse function_dd258a3da9a2b4a1( 20 );
    function_b13ff6775073b85f( corpse );
    
    if ( !mover )
    {
        mover = utility::spawn_tag_origin( corpse.origin, corpse.angles );
        mover.grab_z_offset = 0;
        mover.spine_z_offset = 0;
    }
    
    var_90d8291f2dce34c9 = target.subclass != "zombie_loom_minion";
    corpse unlink();
    
    if ( var_90d8291f2dce34c9 )
    {
        corpse startragdoll();
    }
    
    if ( var_4c4e176066702e93 || !is_thrown )
    {
        mover.origin = corpse.origin;
    }
    else
    {
        z_offset = mover.grab_z_offset + spine_z_offset - mover.spine_z_offset;
        mover.origin += ( 0, 0, z_offset );
    }
    
    self.var_5253d29e09253a4f = undefined;
    waitframe();
    
    if ( var_90d8291f2dce34c9 )
    {
        if ( corpse tagexists( "j_spinelower" ) )
        {
            constraint = spawnragdollconstraint( corpse, "torso_lower", "j_spinelower", ( 0, 0, 0 ), 0 );
        }
        else
        {
            constraint = spawnragdollconstraint( corpse, "neck", "j_neck", ( 0, 0, 0 ), 0 );
        }
        
        constraint.origin = mover.origin;
        constraint.angles = mover.angles;
        constraint linkto( mover );
    }
    else
    {
        corpse enablelinkto();
        corpse linkto( mover );
    }
    
    thread function_16a74d1950d0137b( "mi_disc_zombie_thrown", corpse, mover, constraint );
    gravity = is_thrown ? 0 : getdvarfloat( @"bg_lowgravity", 400 );
    velocity = is_thrown ? 700 : 0;
    v_dir = dir * velocity;
    last_pos = mover.origin;
    move_max_time = gettime() + utility::function_4b74c15943231980( var_73e00b64c68884c5 );
    
    while ( mover && gettime() < move_max_time )
    {
        v_dir -= ( 0, 0, gravity * level.framedurationseconds );
        pos = mover.origin + v_dir * level.framedurationseconds;
        [ passed, trace ] = function_872e11bb209c7ddd( mover.origin, pos, 0, [ self, corpse ], 0 );
        
        if ( !passed && ( trace[ "hittype" ] != "hittype_entity" || isagent( trace[ "entity" ] ) || isagent( trace[ "entity" ].owner ) ) )
        {
            /#
                if ( getdvarint( @"hash_84e5fb0c47036d1b", 0 ) )
                {
                    println( "<dev string:xda>" + trace[ "<dev string:x85>" ] + "<dev string:x100>" + trace[ "<dev string:x10c>" ] );
                }
            #/
            
            break;
        }
        
        mover.origin = pos;
        last_pos = pos;
        
        /#
            if ( getdvarint( @"hash_84e5fb0c47036d1b", 0 ) )
            {
                println( "<dev string:x114>" + mover.origin );
                debug::sphere( pos, 5, ( 1, 0, 0 ), 0.05 );
                debug::sphere( constraint.origin, 5, ( 0, 1, 0 ), 0.05 );
                var_1ee9c6a8673436fa = corpse gettagorigin( "<dev string:x13a>" );
                debug::sphere( var_1ee9c6a8673436fa, 5, ( 0, 0, 1 ), 0.05 );
            }
        #/
        
        waitframe();
    }
    
    corpse notify( #"corpse_thrown_explode", last_pos );
    
    if ( corpse )
    {
        corpse utility::function_32b24db3127bff40( "disciple_injection_throw_explosion", "vfx_on" );
    }
    
    data = { #should_explode:1, #passed:passed, #trace:trace, #mover:mover, #target:target, #corpse:corpse, #player:self };
    callback::callback( #"hash_2ae271dee4ec81dc", data );
    
    if ( isdefined( self ) && data.should_explode )
    {
        var_6a02108301e17dc = 2.5 * maxhealth;
        var_578d71b7c00fc4ba = 0.75 * maxhealth;
        self radiusdamage( last_pos, 200, var_6a02108301e17dc, var_578d71b7c00fc4ba, self, "MOD_IMPACT", self getcurrentweapon() );
    }
    
    self notify( #"mi_disc_zombie_thrown" );
    
    if ( corpse )
    {
        corpse utility::delaycall( 0.25, &delete );
    }
}

// Namespace mutant_injection_disciple_zombies
// Params 1, eflags: 0x4
// Checksum 0x97fbb41d, Offset: 0x5616
// Size: 0x13c
function private function_f4db8a266d0c1fd7( grabbed_zombie )
{
    angles = self getplayerangles();
    forward = anglestoforward( angles );
    start = self getcamerathirdpersonorigin();
    end = start + forward * 1000;
    [ passed, trace ] = function_872e11bb209c7ddd( start, end, 0, [ self, grabbed_zombie ] );
    
    if ( !passed && trace[ "position" ] )
    {
        end = trace[ "position" ];
    }
    
    params = { #player:self, #trace:trace, #passed:passed, #end:end };
    grabbed_zombie callback::callback( #"hash_495068f01155197e", params );
    
    if ( params.end != end )
    {
        end = params.end;
    }
    
    /#
        if ( getdvarint( @"hash_84e5fb0c47036d1b", 0 ) )
        {
            debug::sphere( end, 10, ( 1, 1, 0 ), 10 );
        }
    #/
    
    return end;
}

// Namespace mutant_injection_disciple_zombies
// Params 1, eflags: 0x4
// Checksum 0x933faddf, Offset: 0x575b
// Size: 0x8d
function private function_b13ff6775073b85f( corpse )
{
    level endon( #"game_ended" );
    corpse endon( #"death" );
    start_ragdoll_time = 0.45;
    deathanim = corpse getcorpseanim();
    startragdollnotetracks = getnotetracktimes( deathanim, "StartRagdoll" );
    
    if ( startragdollnotetracks.size > 0 )
    {
        animlength = getanimlength( deathanim );
        start_ragdoll_time = max( startragdollnotetracks[ 0 ] * animlength - 0.1, 0.05 );
    }
    
    wait start_ragdoll_time;
}

// Namespace mutant_injection_disciple_zombies
// Params 4, eflags: 0x4
// Checksum 0x93527ec5, Offset: 0x57f0
// Size: 0x62
function private function_16a74d1950d0137b( msg, corpse, mover, constraint )
{
    level endon( #"game_ended" );
    level utility::waittill_any_ents( self, "death_or_disconnect", self, msg, corpse, "death" );
    
    if ( constraint )
    {
        constraint delete();
    }
    
    if ( mover )
    {
        mover delete();
    }
}

// Namespace mutant_injection_disciple_zombies
// Params 0
// Checksum 0xa3cef401, Offset: 0x585a
// Size: 0x9
function function_ba1287ece709a0eb()
{
    thread watch_scream();
}

// Namespace mutant_injection_disciple_zombies
// Params 0, eflags: 0x4
// Checksum 0xe19e595d, Offset: 0x586b
// Size: 0xd
function private is_allow_scream()
{
    return val::get( "melee" );
}

// Namespace mutant_injection_disciple_zombies
// Params 2, eflags: 0x4
// Checksum 0x6f92dde9, Offset: 0x5881
// Size: 0xaa
function private set_allow_scream( allow, exclusive_attack )
{
    var_73e7ba25d662067b = "disc_cannot_scream";
    var_a0e909417548875 = "disc_scream_cooldown";
    
    if ( !isdefined( exclusive_attack ) )
    {
        exclusive_attack = 0;
    }
    
    str_id = exclusive_attack ? var_73e7ba25d662067b : var_a0e909417548875;
    
    if ( !isdefined( allow ) )
    {
        val::reset_all( var_73e7ba25d662067b );
        val::reset_all( var_a0e909417548875 );
        return;
    }
    
    if ( allow )
    {
        self setclientomnvar( "ui_zm_dinj_scream_cooldown_alpha", 1 );
        val::reset_all( str_id );
        return;
    }
    
    self setclientomnvar( "ui_zm_dinj_scream_cooldown_alpha", 0.5 );
    val::set( str_id, "melee", 0 );
}

// Namespace mutant_injection_disciple_zombies
// Params 0, eflags: 0x4
// Checksum 0x527f674f, Offset: 0x5933
// Size: 0xa
function private scream_on_cooldown()
{
    set_allow_scream( 0 );
}

// Namespace mutant_injection_disciple_zombies
// Params 0, eflags: 0x4
// Checksum 0x35b35f15, Offset: 0x5945
// Size: 0x17
function private scream_cooldown_end()
{
    self notify( #"hash_6b94989a44d4f1b6" );
    set_allow_scream( 1 );
}

// Namespace mutant_injection_disciple_zombies
// Params 1, eflags: 0x4
// Checksum 0x61c3fd84, Offset: 0x5964
// Size: 0x19
function private function_4199e3ec74a800c7( progress )
{
    self setclientomnvar( "ui_zm_dinj_scream_cooldown_progress", progress );
}

// Namespace mutant_injection_disciple_zombies
// Params 1, eflags: 0x4
// Checksum 0xa75dbb3, Offset: 0x5985
// Size: 0xb3
function private function_13dd3edb1193c976( waittime )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"mutantinjection_end" );
    self endon( #"hash_6b94989a44d4f1b6" );
    timestart = gettime();
    
    while ( true )
    {
        currenttime = gettime();
        timespent = currenttime - timestart;
        progress = 1;
        waittime_ms = waittime * 1000;
        
        if ( timespent < waittime_ms && waittime_ms != 0 )
        {
            progress = clamp( timespent, 0, waittime_ms ) / waittime_ms;
        }
        
        function_4199e3ec74a800c7( progress );
        waitframe();
    }
}

// Namespace mutant_injection_disciple_zombies
// Params 0, eflags: 0x4
// Checksum 0xe147612a, Offset: 0x5a40
// Size: 0xd8
function private watch_scream()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    set_allow_scream( 1 );
    thread function_bee4699ad619c71b( "disc_scream" );
    function_4199e3ec74a800c7( 1 );
    
    while ( true )
    {
        msg = utility::waittill_any_return( "disc_scream", "mutantinjection_end" );
        
        if ( msg == "mutantinjection_end" )
        {
            break;
        }
        
        if ( !is_allow_scream() )
        {
            waitframe();
            continue;
        }
        
        thread do_scream();
        wait 0.5;
        
        if ( !self.ismutantinjection )
        {
            break;
        }
        
        scream_on_cooldown();
        time_to_wait = 4.5;
        thread function_13dd3edb1193c976( time_to_wait );
        msg = utility::waittill_notify_or_timeout_return( "mutantinjection_end", time_to_wait );
        
        if ( msg == "mutantinjection_end" )
        {
            break;
        }
        
        scream_cooldown_end();
    }
}

// Namespace mutant_injection_disciple_zombies
// Params 1, eflags: 0x4
// Checksum 0xa23f845a, Offset: 0x5b20
// Size: 0x62
function private function_bee4699ad619c71b( scream_notify )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"mutantinjection_end" );
    melee_button_pressed = 0;
    
    while ( true )
    {
        if ( self meleebuttonpressed() )
        {
            melee_button_pressed = 1;
        }
        else if ( melee_button_pressed )
        {
            melee_button_pressed = 0;
            self notify( scream_notify );
        }
        
        waitframe();
    }
}

// Namespace mutant_injection_disciple_zombies
// Params 0, eflags: 0x4
// Checksum 0x41ec356, Offset: 0x5b8a
// Size: 0x30c
function private do_scream()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"mutantinjection_end" );
    function_4199e3ec74a800c7( 0 );
    scream_time = 1.5;
    anim_length = 2;
    bundle = level.streakglobals.streakbundles[ "zm_dinj" ];
    var_395e150ca0fe39a4 = bundle.mutantinjectiondata.var_395e150ca0fe39a4;
    
    if ( var_395e150ca0fe39a4 )
    {
        xanim = var_395e150ca0fe39a4.id;
        
        if ( animhasnotetrack( xanim, "scream_start_fx" ) )
        {
            scream_frac = getnotetracktimes( xanim, "scream_start_fx" )[ 0 ];
            anim_length = getanimlength( xanim );
            scream_time = anim_length * scream_frac;
        }
    }
    
    thread function_bed0085ee111bc7b( anim_length );
    wait scream_time;
    
    if ( self getscriptablehaspart( "scream_vfx" ) )
    {
        utility::function_32b24db3127bff40( "scream_vfx", "vfx_on" );
    }
    
    targets = getnearbytargets( 275 );
    min_dot = cos( 60 );
    
    foreach ( target in targets )
    {
        if ( !isalive( target ) || target.team == self.team )
        {
            continue;
        }
        
        if ( !function_a9e48e8e302ba59( target, min_dot ) )
        {
            continue;
        }
        
        var_772501ce9a0c24da = 0;
        
        if ( isdefined( target.aicategory ) )
        {
            switch ( target.aicategory )
            {
                case #"hash_84fcf5e68d7230b2":
                    var_772501ce9a0c24da = bundle.mutantinjectiondata.var_8cc4f2e1a7680adf ?? 5;
                    break;
                case #"hash_8c089e813083e510":
                    var_772501ce9a0c24da = bundle.mutantinjectiondata.var_6de248cbc44e014e ?? 3;
                    break;
                case #"hash_7b0e2f2ed84f34":
                case #"hash_4e47eb6c32f5b165":
                    var_772501ce9a0c24da = bundle.mutantinjectiondata.var_aa1785a9f412d7ca ?? 3;
                    break;
                case #"hash_7e8a002ed096276c":
                    break;
                default:
                    break;
            }
        }
        
        if ( var_772501ce9a0c24da > 0 )
        {
            target zombie_stun::stun_ai( var_772501ce9a0c24da, "stunned_on" );
            target thread function_b65ec43a6daafcd5( var_772501ce9a0c24da );
        }
        
        if ( utility::issharedfuncdefined( self.micontext.var_d31dc7187a8cc4db, #"hash_630da97e3b3ba2d6" ) )
        {
            self thread [[ utility::getsharedfunc( self.micontext.var_d31dc7187a8cc4db, #"hash_630da97e3b3ba2d6" ) ]]( target );
        }
    }
}

// Namespace mutant_injection_disciple_zombies
// Params 1
// Checksum 0x8b34e4b0, Offset: 0x5e9e
// Size: 0x54
function function_b65ec43a6daafcd5( var_772501ce9a0c24da )
{
    self notify( #"hash_5d41f531ab9febb3" );
    self endon( #"hash_5d41f531ab9febb3" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self.var_455a1156e4873285 = 1;
    wait var_772501ce9a0c24da;
    self.var_455a1156e4873285 = 0;
}

// Namespace mutant_injection_disciple_zombies
// Params 1, eflags: 0x4
// Checksum 0xe26d5300, Offset: 0x5efa
// Size: 0x71
function private function_bed0085ee111bc7b( anim_length )
{
    level endon( #"game_ended" );
    set_allow_drain_life( 0, 1 );
    set_allow_grab_zombie( 0, 1 );
    msg = utility::waittill_any_timeout( anim_length, "mutantinjection_end", "death_or_disconnect" );
    
    if ( isdefined( self ) && msg == "timeout" )
    {
        set_allow_drain_life( 1, 1 );
        set_allow_grab_zombie( 1, 1 );
    }
}

// Namespace mutant_injection_disciple_zombies
// Params 1
// Checksum 0x31c8dd35, Offset: 0x5f73
// Size: 0x39
function function_e94e1748a20730a1( scriptable )
{
    if ( !isdefined( level.var_ced5070235ce306f ) )
    {
        level.var_ced5070235ce306f = [];
    }
    
    level.var_ced5070235ce306f[ level.var_ced5070235ce306f.size ] = scriptable;
}

/#

    // Namespace mutant_injection_disciple_zombies
    // Params 0, eflags: 0x4
    // Checksum 0x89e43559, Offset: 0x5fb4
    // Size: 0x76, Type: dev
    function private function_747263780094d57()
    {
        devgui::function_9082edeb5db93280( "<dev string:x143>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x161>", "<dev string:x171>" + "<dev string:x194>", &mutant_injection_utility::function_50daa7ab3c558bab );
        devgui::add_devgui_func( "<dev string:x19c>", "<dev string:x1b2>", &mutant_injection_utility::function_663e93cb28525637 );
        devgui::add_devgui_func( "<dev string:x1d1>", "<dev string:x1e8>", &mutant_injection_utility::function_f7772824238349df );
        devgui::add_devgui_func( "<dev string:x205>", "<dev string:x218>", &mutant_injection_utility::function_30d6debfc33678ce );
        devgui::function_77df7fe7dd273e10();
    }

#/
