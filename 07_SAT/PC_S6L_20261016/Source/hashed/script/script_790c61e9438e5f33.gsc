// script_790c61e9438e5f33  (hash_790c61e9438e5f33.gscc) (size: 8415 Bytes / 0x20df / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfde8b7d0 (4259887056)
// size ...... 8415 (0x20df)
// includes .. 11  (offset: 0x1f33)
// strings ... 13  (offset: 0x1f8b)
// dev strs .. 9   (offset: 0x2053)
// exports ... 19  (offset: 0x14a3)
// cseg ...... 0x1ed + 0x12b6 (0x14a3)
// imports ... 65  (offset: 0x179b)
// animtree1 . 0   (offset: 0x20bf)
// animtree2 . 2   (offset: 0x20bf)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\devgui;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\mutant_injection_shared;
#using scripts\mp\common\utility\player;

#namespace mutant_injection_zombies;

// Namespace mutant_injection_zombies
// Params 0
// Checksum 0xc52201a2, Offset: 0x20b
// Size: 0x7c
function init()
{
    level._effect[ "mutant_injection_zombie_annihilate" ] = loadfxasset( "vfx_t10_gameplay_zm_weapons_weap_mangler_zombie_annihilate_1" );
    
    if ( utility::issharedfuncdefined( #"zombie_utils", #"registerdamagecallback" ) )
    {
        utility::callsharedfunc( #"zombie_utils", #"registerdamagecallback", &function_65b40f31d56d5b2c );
    }
    
    /#
        function_747263780094d57();
        setdvarifuninitialized( @"hash_76a471980b295cbc", 0 );
        setdvarifuninitialized( @"hash_84c83c91094d2c8c", 0 );
    #/
}

// Namespace mutant_injection_zombies
// Params 2
// Checksum 0xd9bb3586, Offset: 0x28f
// Size: 0x128
function setcontext( config, streakinfo )
{
    micontext = self.micontext ?? {};
    micontext.var_d2526179d91798d6 = [];
    
    if ( utility::issharedfuncdefined( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb" ) && self [[ utility::getsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb" ) ]]( "specialty_m_mod" ) )
    {
        micontext.var_d2526179d91798d6[ micontext.var_d2526179d91798d6.size ] = "specialty_m_mod";
    }
    
    bundle = self.micontext.bundle;
    
    if ( bundle.mutantinjectiondata.var_a788fb2aed1e877e )
    {
        self.micontext.removeondeath = 1;
    }
    
    self.micontext.prevhealth = self.health;
    self.micontext.prevmaxhealth = self.maxhealth;
    self.micontext = micontext;
}

#using_animtree( "playerasm" );

// Namespace mutant_injection_zombies
// Params 0
// Checksum 0x4ffecf0b, Offset: 0x3bf
// Size: 0x1ea
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
    
    if ( self.micontext.removeondeath )
    {
        self.var_53fc5e1e26ae990f = &mutant_injection_shared::function_2b562b60a3d69e6f;
    }
    
    thread function_42a0f7295dcf86ed();
    thread knockbackzombies( %t10_mstr_mangler_wm_trans_02 );
    function_57d4000e937fc4dd();
}

// Namespace mutant_injection_zombies
// Params 1
// Checksum 0x829dc60e, Offset: 0x5b1
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

// Namespace mutant_injection_zombies
// Params 1
// Checksum 0xde35d2ff, Offset: 0x661
// Size: 0x15, Type: bool
function function_a3f71ecb6eb404cc( target )
{
    return !target zombie_utils::function_bf1464d09f4e4b40();
}

// Namespace mutant_injection_zombies
// Params 2
// Checksum 0xd04d7e75, Offset: 0x67f
// Size: 0x1b0
function removemutantinjection( istimeout, skipanimation )
{
    thread knockbackzombies( %t10_mstr_mangler_3p_transformation_out );
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
    
    if ( self.micontext.removeondeath )
    {
        self.micontext.removeondeath = undefined;
        
        if ( player::isreallyalive( self ) )
        {
            resetplayerhealth();
        }
    }
    
    self.var_a84311e2c57646de = undefined;
}

// Namespace mutant_injection_zombies
// Params 0, eflags: 0x4
// Checksum 0xb043303e, Offset: 0x837
// Size: 0x41
function private resetplayerhealth()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.maxhealth = self.micontext.prevmaxhealth;
    self.health = self.micontext.prevhealth;
}

// Namespace mutant_injection_zombies
// Params 1
// Checksum 0xeb5c56f0, Offset: 0x880
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

// Namespace mutant_injection_zombies
// Params 4
// Checksum 0x43712802, Offset: 0x958
// Size: 0x12e
function function_ba3d79cb556f9f5a( target, vectortotarget, dismember, damagescale )
{
    if ( target.subclass != "zombie_base" )
    {
        return;
    }
    
    n_damage = mutant_injection_shared::function_c059fcb8b93ffa03( target, damagescale );
    
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
        target thread zombie_base_dismemberment::function_14463e39cc414bab( 1 );
    }
}

// Namespace mutant_injection_zombies
// Params 2
// Checksum 0x1e443ff1, Offset: 0xa8e
// Size: 0x56
function function_c059fcb8b93ffa03( target, damagescale = 3 )
{
    round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( target.origin );
    zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
    return zombie_base_health * damagescale;
}

// Namespace mutant_injection_zombies
// Params 1, eflags: 0x4
// Checksum 0xfe33f310, Offset: 0xaed
// Size: 0x359
function private knockbackzombies( animalias )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    knock_back_time = 1;
    
    if ( animhasnotetrack( animalias, "knock_back" ) )
    {
        note_frac = getnotetracktimes( animalias, "knock_back" )[ 0 ];
        knock_back_time = getanimlength( animalias ) * note_frac;
    }
    
    wait knock_back_time;
    knock_back_pos = self.origin;
    mod = "MOD_IMPACT";
    weaponobj = self getcurrentweapon();
    
    if ( !weaponobj || isnullweapon( weaponobj ) )
    {
        weaponobj = self.micontext.weaponobj;
        
        if ( !weaponobj )
        {
            weapon_name = self.micontext.weapon ?? utility::get_scripted_weapon_name( #"mutant_injection_cannon" );
            weaponobj = makeweapon( weapon_name );
        }
    }
    
    potential_targets = mutant_injection_shared::getnearbytargets( 300 );
    
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
        
        if ( !function_a3f71ecb6eb404cc( target ) )
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
                if ( target.magic_bullet_shield || target.damageshield )
                {
                    continue;
                }
                
                target kill( target.origin, self, self, mod, weaponobj );
            }
            
            continue;
        }
        
        target dodamage( 1, target.origin + ( 0, 0, 30 ), self, self, mod, weaponobj, "torso_upper", undefined, 2147483648 );
    }
    
    potential_targets = mutant_injection_shared::getnearbytargets( 100 );
    
    foreach ( target in potential_targets )
    {
        if ( !isai( target ) )
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

// Namespace mutant_injection_zombies
// Params 2, eflags: 0x4
// Checksum 0xe1c4a59e, Offset: 0xe4e
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

// Namespace mutant_injection_zombies
// Params 0, eflags: 0x4
// Checksum 0x5441f536, Offset: 0xede
// Size: 0x1f7
function private function_42a0f7295dcf86ed()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( level.mutant_injection_zombie_annihilate_throttle ) )
    {
        level.mutant_injection_zombie_annihilate_throttle = throttle::throttle_initialize( "mutant_injection_zombie_annihilate", 1 );
    }
    
    self.var_8ebebca7f84e63b = [];
    weaponobj = self.micontext.weaponobj;
    
    if ( !weaponobj )
    {
        weapon_name = self.micontext.weapon ?? utility::get_scripted_weapon_name( #"mutant_injection_cannon" );
        weaponobj = makeweapon( weapon_name );
    }
    
    while ( isdefined( self ) && ( self.ismutantinjection || self.mutantinjectiontransformed ) )
    {
        foreach ( target_info in self.var_8ebebca7f84e63b )
        {
            self.var_8ebebca7f84e63b = arrayremove( self.var_8ebebca7f84e63b, target_info );
            target = target_info.target;
            
            if ( target.var_76bf6b08e4d3f914 && isdefined( target.func_dismember_annihilate ) )
            {
                if ( target.magic_bullet_shield || target.damageshield )
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

// Namespace mutant_injection_zombies
// Params 1, eflags: 0x4
// Checksum 0x340923b5, Offset: 0x10dd
// Size: 0x71
function private function_65b40f31d56d5b2c( params )
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

// Namespace mutant_injection_zombies
// Params 0, eflags: 0x4
// Checksum 0x488e4e03, Offset: 0x1157
// Size: 0x10
function private function_57d4000e937fc4dd()
{
    self.var_a84311e2c57646de = &function_ad0b9f242d2b58c9;
}

// Namespace mutant_injection_zombies
// Params 5
// Checksum 0x8bbdb7d4, Offset: 0x116f
// Size: 0xa3
function function_fe184eca11e17f3( var_d648d1dbc51f0b0f, reduce_time, aicategory, subclass, means_of_death )
{
    if ( !isdefined( var_d648d1dbc51f0b0f ) || !isdefined( reduce_time ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_a417b33646ddb4b3 ) )
    {
        level.var_a417b33646ddb4b3 = [];
    }
    
    level.var_a417b33646ddb4b3[ level.var_a417b33646ddb4b3.size ] = { #means_of_death:means_of_death, #subclass:subclass, #aicategory:aicategory, #reduce_time:reduce_time, #var_d648d1dbc51f0b0f:var_d648d1dbc51f0b0f };
}

// Namespace mutant_injection_zombies
// Params 1, eflags: 0x4
// Checksum 0x4ffed08d, Offset: 0x121a
// Size: 0x211
function private function_ad0b9f242d2b58c9( params )
{
    if ( isdefined( params.eattacker ) && isdefined( self.mutant_injection_end_time ) && self.ismutantinjection )
    {
        if ( utility::issharedfuncdefined( #"minj_zombies", #"hash_ca6d6fc33f98afd3" ) )
        {
            utility::callsharedfunc( #"minj_zombies", #"hash_ca6d6fc33f98afd3", params );
        }
        
        foreach ( data in level.var_a417b33646ddb4b3 )
        {
            if ( params.idamage >= data.var_d648d1dbc51f0b0f )
            {
                if ( isdefined( data.aicategory ) && isagent( params.eattacker ) && params.eattacker.aicategory != data.aicategory )
                {
                    continue;
                }
                
                if ( isdefined( data.means_of_death ) && params.smeansofdeath != data.means_of_death )
                {
                    continue;
                }
                
                if ( params.eattacker.var_c4ad96ba9582dfec )
                {
                    continue;
                }
                
                if ( isdefined( data.subclass ) && isagent( params.eattacker ) && !issubstr( params.eattacker.subclass, data.subclass ) )
                {
                    continue;
                }
                
                self.mutant_injection_end_time -= data.reduce_time;
                
                if ( self.mutant_injection_end_time < gettime() )
                {
                    self.mutant_injection_end_time = gettime();
                }
            }
        }
    }
}

/#

    // Namespace mutant_injection_zombies
    // Params 0, eflags: 0x4
    // Checksum 0xbf607f3d, Offset: 0x1433
    // Size: 0x70, Type: dev
    function private function_747263780094d57()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x41>", "<dev string:x51>", &mutant_injection_shared::function_50daa7ab3c558bab );
        devgui::add_devgui_func( "<dev string:x6f>", "<dev string:x85>", &mutant_injection_shared::function_663e93cb28525637 );
        devgui::add_devgui_func( "<dev string:xa0>", "<dev string:xb7>", &mutant_injection_shared::function_f7772824238349df );
        devgui::add_devgui_func( "<dev string:xd0>", "<dev string:xe3>", &mutant_injection_shared::function_30d6debfc33678ce );
        devgui::function_77df7fe7dd273e10();
    }

#/
