// scripts\common\ai\aitypes\shared\zombie\zombie_toxic_gas.gsc  (hash_0d6d19e875fd7d86.gscc) (size: 6921 Bytes / 0x1b09 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9d8afcc (165195724)
// size ...... 6921 (0x1b09)
// includes .. 7   (offset: 0x193d)
// strings ... 25  (offset: 0x1975)
// dev strs .. 2   (offset: 0x1af1)
// exports ... 12  (offset: 0x10a9)
// cseg ...... 0x1bb + 0xeee (0x10a9)
// imports ... 57  (offset: 0x1289)
// animtree1 . 0   (offset: 0x1b09)
// animtree2 . 0   (offset: 0x1b09)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\ai_utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_toxic_gas;

// Namespace zombie_toxic_gas
// Params 13
// Checksum 0x44b69097, Offset: 0x1d9
// Size: 0x289
function spawn_toxic_gas( owner, origin, angles, id, time_limit, radius, height, var_ee3f4c4e2d0abb32, should_slow, inflictor_override, settings_override, fixed_damage, var_9e573b758f2fd1f4 )
{
    settings = settings_override ?? owner.var_d6894f01a36b4ff3;
    scriptable = settings.var_fda156cf6c87580d;
    
    if ( !isdefined( scriptable ) )
    {
        return;
    }
    
    toxic_gas = spawnscriptable( scriptable, origin, angles );
    
    if ( !isdefined( toxic_gas ) )
    {
        return;
    }
    
    toxic_gas.var_de80f1299517bfab = !isdefined( time_limit );
    toxic_gas.birthtime = gettime();
    toxic_gas.id = id;
    toxic_gas.var_51cf687c0934f7b3 = settings.var_daeac9b9c25be92e;
    toxic_gas.var_154ae54fe81648eb = settings.var_b925ce26d4355322;
    toxic_gas.var_e775fce2d39c7d52 = settings.var_50dff0e4a666eb78;
    toxic_gas.var_465d5e906a44f6b = settings.var_224b8ea7b39db70f;
    toxic_gas.ai_damage_data = settings.var_459ee696dfd8814a;
    toxic_gas.damage_tick_audio = settings.var_28bf3e2551be542c;
    toxic_gas.var_c65714fa25d48f1c = settings.var_6270243427c9d95d;
    toxic_gas.radius = radius;
    toxic_gas.height = height;
    toxic_gas.should_slow = should_slow ?? 0;
    toxic_gas.team = owner.team;
    toxic_gas.inflictor_override = inflictor_override;
    toxic_gas.fixed_damage = fixed_damage;
    toxic_gas.var_9e573b758f2fd1f4 = var_9e573b758f2fd1f4;
    thread utility::function_51a662d7927dccc7( toxic_gas );
    callback::callback( "zombie_toxic_gas_spawned", { #toxic_gas:toxic_gas } );
    toxic_gas thread function_c562014685ace753( owner, toxic_gas );
    
    if ( isdefined( time_limit ) )
    {
        if ( isdefined( radius ) )
        {
            toxic_gas utility::function_7c10ea82c1e305b8( "base", "on_" + radius );
        }
        
        toxic_gas thread function_786a431ef0a68605( toxic_gas, owner, var_ee3f4c4e2d0abb32, time_limit );
    }
    else
    {
        toxic_gas utility::function_7c10ea82c1e305b8( "base", "on_" + toxic_gas.radius );
    }
    
    return toxic_gas;
}

// Namespace zombie_toxic_gas
// Params 4, eflags: 0x4
// Checksum 0x9c1e8008, Offset: 0x46b
// Size: 0x52
function private function_786a431ef0a68605( toxic_gas, owner, var_ee3f4c4e2d0abb32, time )
{
    toxic_gas endon( #"death" );
    
    if ( isdefined( var_ee3f4c4e2d0abb32 ) )
    {
        owner waittill( var_ee3f4c4e2d0abb32 );
    }
    
    wait time;
    
    if ( isdefined( toxic_gas ) )
    {
        thread free_toxic_gas( toxic_gas );
    }
}

// Namespace zombie_toxic_gas
// Params 1
// Checksum 0xd34a4ee3, Offset: 0x4c5
// Size: 0x7f
function free_toxic_gas( toxic_gas )
{
    toxic_gas utility::ent_flag_set( "toxic_gas_despawn" );
    
    if ( toxic_gas getscriptableparthasstate( "base", "off_" + toxic_gas.radius ) )
    {
        toxic_gas endon( #"death" );
        toxic_gas utility::function_7c10ea82c1e305b8( "base", "off_" + toxic_gas.radius );
        wait 5;
    }
    
    if ( isdefined( toxic_gas ) )
    {
        toxic_gas freescriptable();
    }
}

// Namespace zombie_toxic_gas
// Params 2, eflags: 0x4
// Checksum 0x5ead9b95, Offset: 0x54c
// Size: 0x2f9
function private function_c562014685ace753( owner, toxic_gas )
{
    toxic_gas endon( #"death" );
    
    if ( isdefined( owner ) )
    {
        owner endon( #"death" );
    }
    
    gas_ai_damage = toxic_gas.fixed_damage;
    
    if ( !gas_ai_damage )
    {
        current_round = owner.round_number ?? ( isai( owner ) ? owner zombie_utils::get_zombie_round_difficulty() : namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( toxic_gas.origin ) );
        gas_ai_damage = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", current_round );
    }
    
    var_33e3fd370908c00b = owner.var_6246066f668ccf57 ?? 1;
    target_radius = toxic_gas.radius;
    radius = 0;
    start_time = gettime();
    growth_time = 1000;
    end_time = gettime() + growth_time;
    
    while ( isdefined( toxic_gas ) && !toxic_gas utility::ent_flag( "toxic_gas_despawn" ) )
    {
        growth_time_percentage = clamp( math::lerp_fraction( start_time, end_time, gettime() ), 0, 1 );
        radius = math::lerp( 0, target_radius, growth_time_percentage );
        targets = getplayersandaiarrayinradius( toxic_gas.origin, radius );
        
        foreach ( target in targets ?? [] )
        {
            if ( target.team == owner.team && !toxic_gas.var_9722f23c01877fa2 )
            {
                continue;
            }
            
            if ( target.subclass == owner.subclass )
            {
                continue;
            }
            
            if ( abs( target.origin[ 2 ] - toxic_gas.origin[ 2 ] ) > toxic_gas.height )
            {
                continue;
            }
            
            if ( target utility::isusingremote() )
            {
                continue;
            }
            
            set_target_in_toxic_gas( owner, target, gas_ai_damage, toxic_gas, var_33e3fd370908c00b, isdefined( toxic_gas.fixed_damage ) );
        }
        
        /#
            if ( debug_toxic_gas() )
            {
                cylinder( toxic_gas.origin - ( 0, 0, toxic_gas.height ), toxic_gas.origin + ( 0, 0, toxic_gas.height ), radius, ( 0.2, 1, 0.2 ) );
                
                if ( toxic_gas.var_de80f1299517bfab )
                {
                    print3d( toxic_gas.origin, "<dev string:x24>", ( 0.2, 1, 0.2 ) );
                }
            }
        #/
        
        waitframe();
    }
}

// Namespace zombie_toxic_gas
// Params 1, eflags: 0x4
// Checksum 0xdb22c5df, Offset: 0x84d
// Size: 0x19
function private is_target_in_toxic_gas( target )
{
    return target utility::ent_flag( "in_toxic_gas" );
}

// Namespace zombie_toxic_gas
// Params 6, eflags: 0x4
// Checksum 0x39251b7, Offset: 0x86f
// Size: 0x53e
function private set_target_in_toxic_gas( owner, target, gas_ai_damage, toxic_gas, var_33e3fd370908c00b, var_d1f6bea2f31a92ae )
{
    if ( target.var_ee697eaba1724382 )
    {
        return;
    }
    
    if ( !target utility::ent_flag( "in_toxic_gas" ) )
    {
        if ( isplayer( target ) )
        {
            var_4885ec6aa42e2792 = istrue( target utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_phd_flopper", #"phdflopper_safe_slide" ) );
            target utility::function_7c10ea82c1e305b8( "phobos_toxic_gas", "on" );
            
            if ( isdefined( toxic_gas.var_51cf687c0934f7b3 ) )
            {
                pbgpostfxbundlestart( target, toxic_gas.var_51cf687c0934f7b3 );
            }
            
            if ( !var_4885ec6aa42e2792 && toxic_gas.should_slow == 0 )
            {
                target val::set( "toxic_gas", "sprint", 0 );
            }
        }
        
        target utility::ent_flag_set( "in_toxic_gas" );
        target thread cleanup_in_gas_effects( toxic_gas );
    }
    else
    {
        target notify( #"reapply_toxic_gas" );
    }
    
    target utility::delaythreadendon( level.framedurationseconds * 5, "reapply_toxic_gas", &utility::ent_flag_clear, "in_toxic_gas" );
    
    if ( isdefined( toxic_gas.damage_tick_audio ) && isdefined( toxic_gas.var_c65714fa25d48f1c ) )
    {
        if ( !target utility::ent_flag( "toxic_gas_damaged_audio" ) )
        {
            target utility::ent_flag_set( "toxic_gas_damaged_audio" );
            target thread utility::ent_flag_clear_delayed( "toxic_gas_damaged_audio", toxic_gas.var_c65714fa25d48f1c );
            target playlocalsound( toxic_gas.damage_tick_audio );
        }
    }
    
    if ( !target utility::ent_flag( "toxic_gas_damaged" ) )
    {
        target utility::ent_flag_set( "toxic_gas_damaged" );
        target thread utility::ent_flag_clear_delayed( "toxic_gas_damaged", toxic_gas.var_154ae54fe81648eb );
        
        if ( isai( target ) )
        {
            var_ab98a896c3190bf9 = toxic_gas.var_9e573b758f2fd1f4[ target.type ] ?? gas_ai_damage;
            damage = function_f141034519d9e088( target, toxic_gas.ai_damage_data, var_ab98a896c3190bf9 );
        }
        else
        {
            if ( !isdefined( target.var_c35539f716ad7430 ) )
            {
                target.var_c35539f716ad7430 = 0;
            }
            
            if ( !isdefined( target.toxic_gas_initial_time ) )
            {
                target.toxic_gas_initial_time = 0;
            }
            
            var_44295dcc0b7398bb = gettime() - target.var_c35539f716ad7430;
            
            if ( var_44295dcc0b7398bb > utility::function_4b74c15943231980( toxic_gas.var_e775fce2d39c7d52 ) || target.inlaststand )
            {
                target.toxic_gas_initial_time = gettime();
            }
            
            target.var_c35539f716ad7430 = gettime();
            var_2e5e2b7a7afe4598 = utility::function_6f5d2e1f1ff70482( gettime() - target.toxic_gas_initial_time );
            highest_pair = undefined;
            
            foreach ( pair in toxic_gas.var_465d5e906a44f6b )
            {
                if ( !isdefined( pair.var_a95ee436898b4a2f ) )
                {
                    pair.var_a95ee436898b4a2f = 0;
                }
                
                if ( !isdefined( highest_pair ) || pair.var_a95ee436898b4a2f < var_2e5e2b7a7afe4598 && pair.var_a95ee436898b4a2f > highest_pair.var_a95ee436898b4a2f )
                {
                    highest_pair = pair;
                }
            }
            
            damage = highest_pair.damagetick * var_33e3fd370908c00b;
        }
        
        damage_owner = owner;
        
        if ( !isalive( damage_owner ) )
        {
            if ( !isdefined( toxic_gas.damage_owner ) )
            {
                toxic_gas.damage_owner = utility::spawn_script_origin( toxic_gas.origin, toxic_gas.angles );
                assert( isdefined( toxic_gas.damage_owner ) );
                toxic_gas thread utility::delete_on_death( toxic_gas.damage_owner );
                toxic_gas.damage_owner.team = toxic_gas.team;
            }
            
            damage_owner = toxic_gas.damage_owner;
        }
        
        toxic_gas.team = utility::get_enemy_team( target.team );
        var_4885ec6aa42e2792 = 0;
        
        if ( isplayer( target ) )
        {
            var_4885ec6aa42e2792 = istrue( target utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_phd_flopper", #"phdflopper_safe_slide" ) );
        }
        
        var_dd1609612609230e = var_4885ec6aa42e2792 && target issprintsliding();
        var_50780cffb1e9be07 = 1073741824;
        
        if ( !var_d1f6bea2f31a92ae )
        {
            var_50780cffb1e9be07 |= 65536;
        }
        
        target dodamage( damage, toxic_gas.origin, damage_owner, toxic_gas.inflictor_override ?? toxic_gas, "MOD_ELEMENTAL_TOXIC", isalive( owner ) ? owner.grenadeweapon : undefined, "none", undefined, var_50780cffb1e9be07 );
    }
}

// Namespace zombie_toxic_gas
// Params 1, eflags: 0x4
// Checksum 0x8e5fafd5, Offset: 0xdb5
// Size: 0x7f
function private function_93c24e32daa6b491( tier )
{
    switch ( tier )
    {
        case 1:
            return "normal";
        case 2:
            return "special";
        case 3:
            return "elite";
        case 4:
            return "boss";
        default:
            assertmsg( "<dev string:x2e>" + tier );
            break;
    }
    
    return "normal";
}

// Namespace zombie_toxic_gas
// Params 3, eflags: 0x4
// Checksum 0xd272d91e, Offset: 0xe3d
// Size: 0x14d
function private function_f141034519d9e088( target, ai_damage_data, var_ab98a896c3190bf9 )
{
    damage = int( var_ab98a896c3190bf9 * 0.05 );
    
    if ( target.type == "zombie" )
    {
        effective_category = target.aicategory;
    }
    else if ( target.type == "human" )
    {
        var_8fda4a0b6ae538e4 = target ai_utility::get_power_tier();
        
        if ( var_8fda4a0b6ae538e4 )
        {
            effective_category = function_93c24e32daa6b491( var_8fda4a0b6ae538e4 );
        }
    }
    
    foreach ( pair in ai_damage_data )
    {
        if ( pair.damagecategory == effective_category )
        {
            if ( pair.damagetick > 1 )
            {
                damage = int( pair.damagetick );
            }
            else
            {
                damage = int( var_ab98a896c3190bf9 * pair.damagetick );
            }
            
            break;
        }
    }
    
    return damage;
}

// Namespace zombie_toxic_gas
// Params 1, eflags: 0x4
// Checksum 0xe488b7ac, Offset: 0xf93
// Size: 0xa8
function private cleanup_in_gas_effects( toxic_gas )
{
    self endon( #"death" );
    toxic_gas_bundle = toxic_gas.var_51cf687c0934f7b3;
    thread cleanup_fx_on_death( toxic_gas_bundle );
    
    while ( utility::ent_flag( "in_toxic_gas" ) )
    {
        utility::ent_flag_waitopen_any( "in_toxic_gas" );
        waitframe();
        waittillframeend();
    }
    
    val::reset_all( "toxic_gas" );
    
    if ( isplayer( self ) && isdefined( toxic_gas_bundle ) )
    {
        pbgpostfxbundleend( self, toxic_gas_bundle );
    }
    
    utility::function_7c10ea82c1e305b8( "phobos_toxic_gas", "deactivate" );
    utility::function_7c10ea82c1e305b8( "phobos_toxic_gas", "off" );
    self notify( #"hash_61d160c6bfe37bdc" );
}

// Namespace zombie_toxic_gas
// Params 1, eflags: 0x4
// Checksum 0x5444efd0, Offset: 0x1043
// Size: 0x48
function private cleanup_fx_on_death( toxic_gas_bundle )
{
    self endon( #"disconnect" );
    self endon( #"hash_61d160c6bfe37bdc" );
    self waittill( #"death" );
    
    if ( isplayer( self ) && isdefined( toxic_gas_bundle ) )
    {
        pbgpostfxbundleend( self, toxic_gas_bundle );
    }
}

/#

    // Namespace zombie_toxic_gas
    // Params 0, eflags: 0x4
    // Checksum 0xa975ead3, Offset: 0x1093
    // Size: 0x16, Type: dev
    function private debug_toxic_gas()
    {
        return getdvarint( @"zombie_toxic_gas", 0 ) > 0;
    }

#/
