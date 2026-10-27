// scripts\common\ai\aitypes\shared\zombie\zombie_frost_aoe.gsc  (hash_6b7b57fa7cab7915.gscc) (size: 5202 Bytes / 0x1452 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc3434eca (3275968202)
// size ...... 5202 (0x1452)
// includes .. 6   (offset: 0x1332)
// strings ... 14  (offset: 0x1362)
// dev strs .. 1   (offset: 0x1446)
// exports ... 10  (offset: 0xbee)
// cseg ...... 0x146 + 0xaa8 (0xbee)
// imports ... 49  (offset: 0xd7e)
// animtree1 . 0   (offset: 0x1452)
// animtree2 . 0   (offset: 0x1452)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\status_effects\effect_frost;
#using scripts\common\utility;

#namespace zombie_frost_aoe;

// Namespace zombie_frost_aoe
// Params 7
// Checksum 0x3d501d11, Offset: 0x164
// Size: 0x1df
function spawn_frost_aoe( owner, origin, angles, id, time_limit, radius, height )
{
    scriptable = owner.var_d6894f01a36b4ff3.var_f9d6065befb2111c;
    
    if ( !isdefined( scriptable ) )
    {
        return;
    }
    
    frost_aoe = spawnscriptable( scriptable, origin, angles );
    
    if ( !isdefined( frost_aoe ) )
    {
        return;
    }
    
    frost_aoe.var_de80f1299517bfab = !isdefined( time_limit );
    frost_aoe.birthtime = gettime();
    frost_aoe.id = id;
    frost_aoe.var_51cf687c0934f7b3 = owner.var_d6894f01a36b4ff3.var_1a64d2d7d519d0d3;
    frost_aoe.var_7c62339f0c01aee5 = owner.var_d6894f01a36b4ff3.var_dde072974e37cc57;
    frost_aoe.var_82025186e58ebc40 = owner.var_d6894f01a36b4ff3.var_f77af132f1b66f99;
    frost_aoe.var_465d5e906a44f6b = owner.var_d6894f01a36b4ff3.var_d85e9f25ecea856c;
    frost_aoe.move_speed_multiplier = owner.var_d6894f01a36b4ff3.var_d7a6efb158844ede;
    frost_aoe.radius = radius;
    frost_aoe.height = height;
    frost_aoe.team = owner.team;
    thread utility::function_51a662d7927dccc7( frost_aoe );
    callback::callback( "zombie_frost_aoe_spawned", { #frost_aoe:frost_aoe } );
    frost_aoe thread do_aoe_damage( owner, frost_aoe );
    frost_aoe utility::function_7c10ea82c1e305b8( "base", "on" );
    
    if ( isdefined( time_limit ) )
    {
        frost_aoe thread function_1d579489a84852bc( frost_aoe, owner, time_limit );
    }
    
    return frost_aoe;
}

// Namespace zombie_frost_aoe
// Params 3, eflags: 0x4
// Checksum 0xc1e990db, Offset: 0x34c
// Size: 0x3d
function private function_1d579489a84852bc( frost_aoe, owner, time )
{
    frost_aoe endon( #"death" );
    wait time;
    
    if ( isdefined( frost_aoe ) )
    {
        thread free_frost_aoe( frost_aoe );
    }
}

// Namespace zombie_frost_aoe
// Params 1
// Checksum 0x13eb0422, Offset: 0x391
// Size: 0x67
function free_frost_aoe( frost_aoe )
{
    frost_aoe utility::ent_flag_set( "frost_aoe_despawn" );
    
    if ( frost_aoe getscriptableparthasstate( "base", "off" ) )
    {
        frost_aoe endon( #"death" );
        frost_aoe utility::function_7c10ea82c1e305b8( "base", "off" );
        wait 5;
    }
    
    if ( isdefined( frost_aoe ) )
    {
        frost_aoe freescriptable();
    }
}

// Namespace zombie_frost_aoe
// Params 2, eflags: 0x4
// Checksum 0x7bb61e7e, Offset: 0x400
// Size: 0x2a7
function private do_aoe_damage( owner, frost_aoe )
{
    frost_aoe endon( #"death" );
    
    if ( isdefined( owner ) )
    {
        owner endon( #"death" );
    }
    
    aoe_ai_damage = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", owner.round_number ?? owner zombie_utils::get_zombie_round_difficulty() );
    target_radius = frost_aoe.radius;
    radius = 0;
    start_time = gettime();
    growth_time = 1000;
    end_time = gettime() + growth_time;
    
    while ( isdefined( frost_aoe ) && !frost_aoe utility::ent_flag( "frost_aoe_despawn" ) )
    {
        growth_time_percentage = clamp( math::lerp_fraction( start_time, end_time, gettime() ), 0, 1 );
        radius = math::lerp( 0, target_radius, growth_time_percentage );
        targets = getplayersandaiarrayinradius( frost_aoe.origin, radius );
        
        foreach ( target in targets ?? [] )
        {
            if ( target.team == owner.team && !frost_aoe.var_9722f23c01877fa2 )
            {
                continue;
            }
            
            if ( target.subclass == owner.subclass )
            {
                continue;
            }
            
            if ( abs( target.origin[ 2 ] - frost_aoe.origin[ 2 ] ) > frost_aoe.height )
            {
                continue;
            }
            
            if ( target utility::isusingremote() )
            {
                continue;
            }
            
            if ( target.var_368ce8ea173e338d )
            {
                continue;
            }
            
            set_target_in_frost_aoe( owner, target, aoe_ai_damage, frost_aoe );
        }
        
        /#
            if ( debug_frost_aoe() )
            {
                cylinder( frost_aoe.origin - ( 0, 0, frost_aoe.height ), frost_aoe.origin + ( 0, 0, frost_aoe.height ), radius, ( 0.2, 1, 0.2 ) );
                
                if ( frost_aoe.var_de80f1299517bfab )
                {
                    print3d( frost_aoe.origin, "<dev string:x24>", ( 0.2, 1, 0.2 ) );
                }
            }
        #/
        
        waitframe();
    }
}

// Namespace zombie_frost_aoe
// Params 1, eflags: 0x4
// Checksum 0xbcb7ed48, Offset: 0x6af
// Size: 0x19, Type: bool
function private is_target_in_frost_aoe( target )
{
    return target utility::ent_flag( "in_frost_aoe" );
}

// Namespace zombie_frost_aoe
// Params 4, eflags: 0x4
// Checksum 0x5e0ca1f, Offset: 0x6d1
// Size: 0x456
function private set_target_in_frost_aoe( owner, target, aoe_ai_damage, frost_aoe )
{
    if ( !target utility::ent_flag( "in_frost_aoe" ) )
    {
        if ( isplayer( target ) )
        {
            var_4885ec6aa42e2792 = istrue( target utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_phd_flopper", #"phdflopper_safe_slide" ) );
            target utility::function_7c10ea82c1e305b8( "phobos_frost_aoe", "on" );
            
            if ( isdefined( frost_aoe.var_51cf687c0934f7b3 ) )
            {
                pbgpostfxbundlestart( target, frost_aoe.var_51cf687c0934f7b3 );
            }
            
            if ( !( var_4885ec6aa42e2792 && target issprintsliding() ) )
            {
                target effect_frost::frost( "zombie_frost_aoe", frost_aoe.move_speed_multiplier );
            }
        }
        
        target utility::ent_flag_set( "in_frost_aoe" );
        target thread function_4898920a3d35f489( frost_aoe );
    }
    else
    {
        target notify( #"reapply_frost_aoe" );
    }
    
    target utility::delaythreadendon( level.framedurationseconds * 5, "reapply_frost_aoe", &utility::ent_flag_clear, "in_frost_aoe" );
    
    if ( !target utility::ent_flag( "frost_aoe_damaged" ) )
    {
        target utility::ent_flag_set( "frost_aoe_damaged" );
        target thread utility::ent_flag_clear_delayed( "frost_aoe_damaged", frost_aoe.var_7c62339f0c01aee5 );
        
        if ( isai( target ) )
        {
            damage = int( aoe_ai_damage * 0.05 );
        }
        else
        {
            if ( !isdefined( target.var_2a8afaf094b769b5 ) )
            {
                target.var_2a8afaf094b769b5 = 0;
            }
            
            if ( !isdefined( target.frost_aoe_initial_time ) )
            {
                target.frost_aoe_initial_time = 0;
            }
            
            var_44295dcc0b7398bb = gettime() - target.var_2a8afaf094b769b5;
            
            if ( var_44295dcc0b7398bb > utility::function_4b74c15943231980( frost_aoe.var_82025186e58ebc40 ) || target.inlaststand )
            {
                target.frost_aoe_initial_time = gettime();
            }
            
            target.var_2a8afaf094b769b5 = gettime();
            var_df4e6eebe810b1ea = utility::function_6f5d2e1f1ff70482( gettime() - target.frost_aoe_initial_time );
            highest_pair = undefined;
            
            foreach ( pair in frost_aoe.var_465d5e906a44f6b )
            {
                if ( !isdefined( pair.var_a95ee436898b4a2f ) )
                {
                    pair.var_a95ee436898b4a2f = 0;
                }
                
                if ( !isdefined( highest_pair ) || pair.var_a95ee436898b4a2f < var_df4e6eebe810b1ea && pair.var_a95ee436898b4a2f > highest_pair.var_a95ee436898b4a2f )
                {
                    highest_pair = pair;
                }
            }
            
            damage = highest_pair.damagetick;
        }
        
        damage_owner = owner;
        
        if ( !isalive( damage_owner ) )
        {
            if ( !isdefined( frost_aoe.damage_owner ) )
            {
                frost_aoe.damage_owner = utility::spawn_script_origin( frost_aoe.origin, frost_aoe.angles );
                assert( isdefined( frost_aoe.damage_owner ) );
                frost_aoe thread utility::delete_on_death( frost_aoe.damage_owner );
                frost_aoe.damage_owner.team = frost_aoe.team;
            }
            
            damage_owner = frost_aoe.damage_owner;
        }
        
        frost_aoe.team = utility::get_enemy_team( target.team );
        var_4885ec6aa42e2792 = 0;
        
        if ( isplayer( target ) )
        {
            var_4885ec6aa42e2792 = istrue( target utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_phd_flopper", #"phdflopper_safe_slide" ) );
        }
        
        var_dd1609612609230e = var_4885ec6aa42e2792 && target issprintsliding();
        target dodamage( damage, frost_aoe.origin, damage_owner, frost_aoe, "MOD_ELEMENTAL_COLD", isalive( owner ) ? owner.grenadeweapon : undefined, "none", undefined, 1073807360 );
    }
}

// Namespace zombie_frost_aoe
// Params 1, eflags: 0x4
// Checksum 0x5eec161d, Offset: 0xb2f
// Size: 0x5e
function private function_4898920a3d35f489( frost_aoe )
{
    self endon( #"death" );
    thread cleanup_fx_on_death();
    
    while ( utility::ent_flag( "in_frost_aoe" ) )
    {
        utility::ent_flag_waitopen_any( "in_frost_aoe" );
        waitframe();
        waittillframeend();
    }
    
    if ( isplayer( self ) )
    {
        effect_frost::stop_frost( "zombie_frost_aoe" );
    }
    
    self notify( #"hash_1d6ce40bc5719736" );
}

// Namespace zombie_frost_aoe
// Params 0, eflags: 0x4
// Checksum 0x93cc21fd, Offset: 0xb95
// Size: 0x3b
function private cleanup_fx_on_death()
{
    self endon( #"disconnect" );
    self endon( #"hash_1d6ce40bc5719736" );
    self waittill( #"death" );
    
    if ( isplayer( self ) )
    {
        effect_frost::stop_frost( "zombie_frost_aoe" );
    }
}

/#

    // Namespace zombie_frost_aoe
    // Params 0, eflags: 0x4
    // Checksum 0xd4baf6eb, Offset: 0xbd8
    // Size: 0x16, Type: dev
    function private debug_frost_aoe()
    {
        return getdvarint( @"zombie_frost_aoe", 0 ) > 0;
    }

#/
