// scripts\mp\common\weapons\lightning_chain.gsc  (hash_71be54f9648a989a.gscc) (size: 12931 Bytes / 0x3283 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x175938e1 (391723233)
// size ...... 12931 (0x3283)
// includes .. 8   (offset: 0x2fb7)
// strings ... 45  (offset: 0x2ff7)
// dev strs .. 0   (offset: 0x3283)
// exports ... 26  (offset: 0x211f)
// cseg ...... 0x4b1 + 0x1c6e (0x211f)
// imports ... 86  (offset: 0x252f)
// animtree1 . 0   (offset: 0x3283)
// animtree2 . 0   (offset: 0x3283)
#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;

#namespace lightning_chain;

// Namespace lightning_chain
// Params 0, eflags: 0x5
// Checksum 0x8166ebf, Offset: 0x4cf
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"lightning_chain", undefined, undefined, &post_main );
}

// Namespace lightning_chain
// Params 0, eflags: 0x4
// Checksum 0x462c9de5, Offset: 0x4f0
// Size: 0x22
function private post_main()
{
    common_init();
    utility::callsharedfunc( #"lightning_chain", #"init" );
}

// Namespace lightning_chain
// Params 0, eflags: 0x4
// Checksum 0x16d99898, Offset: 0x51a
// Size: 0x22b
function private common_init()
{
    level._effect[ "tesla_bolt" ] = loadfxasset( "vfx_t10_gameplay_zm_weapons_tesla_elec_bolt_01" );
    level._effect[ "tesla_shock" ] = loadfxasset( "vfx_jup_ob_gameplay_zm_tesla_shock_zmb" );
    level._effect[ "tesla_shock_eyes" ] = loadfxasset( "vfx_t10_gameplay_zm_weapons_tesla_shock_eye" );
    level._effect[ "tesla_shock_mouth" ] = loadfxasset( "vfx_t10_gameplay_zm_weapons_tesla_shock_mouth" );
    level._effect[ "tesla_shock_ground" ] = loadfxasset( "vfx_jup_ob_gameplay_zm_tesla_shock_ground" );
    level._effect[ "tesla_bolt_pap" ] = loadfxasset( "vfx_t10_gameplay_zm_weapons_tesla_elec_bolt_pap_01" );
    level._effect[ "tesla_shock_pap" ] = loadfxasset( "vfx_jup_ob_gameplay_zm_tesla_shock_ug_zmb" );
    level._effect[ "tesla_shock_eyes_pap" ] = loadfxasset( "vfx_t10_gameplay_zm_weapons_tesla_shock_eye_pap" );
    level._effect[ "tesla_shock_mouth_pap" ] = loadfxasset( "vfx_t10_gameplay_zm_weapons_tesla_shock_mouth_pap" );
    level._effect[ "tesla_shock_ground_pap" ] = loadfxasset( "vfx_jup_ob_gameplay_zm_tesla_shock_ug_ground" );
    level callback::add( "on_zombie_ai_damaged", &lc_on_ai_damage );
    level callback::add( "on_soldier_ai_damaged", &lc_on_ai_damage );
    level callback::add( #"player_laststand", &on_player_laststand );
    level callback::add( #"player_death", &on_player_death );
    level.var_cf7706e013c62841 = [];
    level.var_cf7706e013c62841[ 0 ] = 5000;
    level.var_cf7706e013c62841[ 1 ] = 10000;
    level.var_cf7706e013c62841[ 2 ] = 20000;
    level.var_cf7706e013c62841[ 3 ] = 40000;
    utility::registersharedfunc( #"lightning_chain", #"hash_1722084e0b6f97fc", &create_lightning_chain_params );
    utility::registersharedfunc( #"lightning_chain", #"lc_expand", &lc_expand );
    utility::registersharedfunc( #"lightning_chain", #"lc_stun_and_damage", &lc_stun_and_damage );
    utility::registersharedfunc( #"lightning_chain", #"lc_damage_calculation", &lc_damage_calculation );
    utility::registersharedfunc( #"lightning_chain", #"lc_play_stun_fx", &lc_play_stun_fx );
}

// Namespace lightning_chain
// Params 5
// Checksum 0x1aacb407, Offset: 0x74d
// Size: 0x88
function create_lightning_chain_params( max_enemies_killed, radius, head_gib_chance, arc_travel_time, var_dc97cf84d9220187 )
{
    lcp = spawnstruct();
    lcp.max_enemies_killed = max_enemies_killed;
    lcp.arc_radius = radius;
    lcp.head_gib_chance = head_gib_chance;
    lcp.arc_travel_time = arc_travel_time;
    lcp.var_dc97cf84d9220187 = var_dc97cf84d9220187;
    return lcp;
}

// Namespace lightning_chain
// Params 3
// Checksum 0xf63b1bc0, Offset: 0x7de
// Size: 0x16d
function arc_damage( source_enemy, player, params )
{
    if ( !isdefined( params ) )
    {
        return 0;
    }
    
    if ( !isdefined( params.team ) )
    {
        params.team = params.attacker.team ?? player.team;
    }
    
    params.attacker_origin = params.attacker.origin ?? player.origin;
    var_f191c2408c95ef7 = !params.var_bca2b52118f73;
    
    if ( !isdefined( self.lc_records ) )
    {
        self.lc_records = [];
    }
    
    if ( params.var_fb7eedda08f6ff3f )
    {
        self.lc_records = arraycombineunique( self.lc_records, [ params.lc_id ] );
    }
    else
    {
        thread utility::callsharedfunc( #"lightning_chain", #"lc_stun_and_damage", var_f191c2408c95ef7, params );
    }
    
    if ( ai::is_non_base() && !params.var_fff5dc5501f9e352 )
    {
        return 0;
    }
    
    expand_start_point = level function_edaa39ee22ae128b( source_enemy );
    return level utility::callsharedfunc( #"lightning_chain", #"lc_expand", expand_start_point, params.max_enemies_killed - 1, params );
}

// Namespace lightning_chain
// Params 1
// Checksum 0xb9a87424, Offset: 0x954
// Size: 0x82, Type: bool
function function_7060ea3387a52416( params )
{
    if ( self.lc_stunned || self.team == params.attacker.team || self.team == params.team || isdefined( self.lc_records ) && arraycontains( self.lc_records, params.lc_id ) )
    {
        return true;
    }
    
    return false;
}

// Namespace lightning_chain
// Params 3, eflags: 0x4
// Checksum 0xae12f92a, Offset: 0x9df
// Size: 0x1f2, Type: bool
function private lc_expand( start_point, count_left, params )
{
    var_d61135157d642a8f = int( min( params.var_dc97cf84d9220187, count_left ) );
    filtered_targets = [];
    targets = getplayersandaiarrayinradius( start_point, params.arc_radius );
    
    foreach ( target in targets )
    {
        if ( target function_7060ea3387a52416( params ) )
        {
            continue;
        }
        
        if ( ( isplayer( target ) || params.var_9443c6eec8f8da85 ) && !trace::ray_trace_passed( start_point, target geteye(), targets ) )
        {
            continue;
        }
        
        filtered_targets[ filtered_targets.size ] = target;
    }
    
    var_d61135157d642a8f = int( min( filtered_targets.size, var_d61135157d642a8f ) );
    
    if ( var_d61135157d642a8f == 0 )
    {
        return false;
    }
    
    filtered_targets = sortbydistance( filtered_targets, start_point );
    
    for ( i = 0; i < var_d61135157d642a8f ; i++ )
    {
        level thread function_36f0e2930c537867( start_point, filtered_targets[ i ], params );
    }
    
    if ( params.var_fff5dc5501f9e352 )
    {
        while ( i > 0 && filtered_targets[ i - 1 ] ai::is_boss() )
        {
            i--;
        }
    }
    else
    {
        while ( i > 0 && filtered_targets[ i - 1 ] ai::is_non_base() )
        {
            i--;
        }
    }
    
    if ( i == 0 )
    {
        return false;
    }
    
    next_start_point = function_edaa39ee22ae128b( filtered_targets[ i - 1 ] );
    count_left -= var_d61135157d642a8f;
    
    if ( count_left > 0 )
    {
        level thread function_dd36404d9835d6b2( params.arc_travel_time + 0.1, next_start_point, count_left, params );
    }
    
    return true;
}

// Namespace lightning_chain
// Params 4
// Checksum 0x42c8dd1c, Offset: 0xbda
// Size: 0x48
function function_dd36404d9835d6b2( waittime, start_point, count_left, params )
{
    wait waittime;
    level utility::callsharedfunc( #"lightning_chain", #"lc_expand", start_point, count_left, params );
}

// Namespace lightning_chain
// Params 1
// Checksum 0xc378c984, Offset: 0xc2a
// Size: 0x39
function function_edaa39ee22ae128b( ai_target )
{
    end_point = ai_target gettagorigin( "J_SpineUpper", 1 );
    
    if ( !isdefined( end_point ) )
    {
        end_point = ai_target.origin;
    }
    
    return end_point;
}

// Namespace lightning_chain
// Params 3
// Checksum 0x2117c656, Offset: 0xc6c
// Size: 0x144
function function_36f0e2930c537867( start_point, ai_target, params )
{
    end_point = function_edaa39ee22ae128b( ai_target );
    
    if ( !isdefined( end_point ) )
    {
        return;
    }
    
    angles = vectortoangles( vectornormalize( end_point - start_point ) );
    var_a542a8f69a73e0fa = utility::spawn_tag_origin( start_point, angles );
    var_a542a8f69a73e0fa show();
    
    if ( params.var_516d207140d59c2 > 0 )
    {
        bolt_fx = "tesla_bolt_pap";
    }
    else
    {
        bolt_fx = "tesla_bolt";
    }
    
    fx_id = level._effect[ bolt_fx ];
    
    if ( isdefined( params.var_ff926fba88e29825 ) )
    {
        fx_id = params.var_ff926fba88e29825;
    }
    
    fx = playfxontag( fx_id, var_a542a8f69a73e0fa, "tag_origin" );
    
    if ( params.play_sound )
    {
        playsoundatpos( start_point, "prj_dg2_bounce" );
    }
    
    var_a542a8f69a73e0fa moveto( end_point, params.arc_travel_time );
    var_a542a8f69a73e0fa waittill( #"movedone" );
    var_a542a8f69a73e0fa delete();
    
    if ( isalive( ai_target ) )
    {
        ai_target thread utility::callsharedfunc( #"lightning_chain", #"lc_stun_and_damage", 0, params );
    }
}

// Namespace lightning_chain
// Params 1
// Checksum 0x6f4f5f23, Offset: 0xdb8
// Size: 0xf3
function function_3dcee24de3aa889a( duration )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( self.health > 0 && !asm_bb::bb_isanimscripted() )
    {
        duration_ms = utility::function_4b74c15943231980( duration );
        first_stun_time = gettime();
        self._blackboard.var_ba9517cfc0287af8 = first_stun_time;
        self._blackboard.shockedendtime = first_stun_time + int( duration_ms );
        
        if ( self asmhaspainstate( self.asmname ) )
        {
            self asmevalpaintransition( self.asmname );
        }
        
        while ( true )
        {
            time_now = gettime();
            
            if ( time_now < first_stun_time + duration_ms )
            {
                self._blackboard.var_ba9517cfc0287af8 = time_now;
            }
            else
            {
                break;
            }
            
            wait 0.1;
        }
    }
}

// Namespace lightning_chain
// Params 1, eflags: 0x4
// Checksum 0xd7ba1a7e, Offset: 0xeb3
// Size: 0x59, Type: bool
function private should_stun_ai( params )
{
    if ( isdefined( params.var_d0449be91ab49769 ) )
    {
        if ( !self [[ params.var_d0449be91ab49769 ]]() )
        {
            return false;
        }
    }
    
    if ( ai::is_boss() )
    {
        return false;
    }
    
    if ( isdefined( params.var_a4b06b7d5862ddea ) )
    {
        return true;
    }
    
    if ( ai::is_non_base() )
    {
        return false;
    }
    
    return true;
}

// Namespace lightning_chain
// Params 2, eflags: 0x4
// Checksum 0x7e96267b, Offset: 0xf15
// Size: 0x128
function private lc_stun_and_damage_player( var_f191c2408c95ef7, params )
{
    self endon( #"death_or_disconnect" );
    self notify( #"lc_stun_and_damage" );
    self endon( #"lc_stun_and_damage" );
    
    if ( !isalive( self ) )
    {
        lc_play_stun_fx( var_f191c2408c95ef7, params );
        return;
    }
    
    params.tdot = 0;
    
    if ( !self.lc_stunned )
    {
        lc_do_damage( params );
    }
    
    self.lc_stunned = 1;
    lc_play_stun_fx( var_f191c2408c95ef7, params );
    shockdata = level function_1ec562064213fee9( params.attacker, params );
    
    if ( utility::callsharedfunc( #"shockstick", #"shockstick_canbehaywire", shockdata, 1 ) )
    {
        shockdata thread utility::callsharedfunc( #"shockstick", #"shockstick_applyhaywire", self, shockdata.weapon, 0 );
    }
    
    if ( getdvarint( @"hash_68697a8f385d5617", 1 ) )
    {
        thread lc_do_tick_damage_player( params, params.duration );
    }
    
    wait params.duration;
    self.lc_stunned = undefined;
}

// Namespace lightning_chain
// Params 2, eflags: 0x4
// Checksum 0xa5851d09, Offset: 0x1045
// Size: 0x39f
function private lc_stun_and_damage( var_f191c2408c95ef7, params )
{
    self endon( #"death" );
    
    if ( self.lc_stunned && !isplayer( self ) )
    {
        return;
    }
    
    if ( isdefined( params.var_53ad54fe8805dda3 ) )
    {
        if ( !self [[ params.var_53ad54fe8805dda3 ]]() )
        {
            return;
        }
    }
    else if ( isagent( self ) && !should_stun_ai( params ) )
    {
        lc_do_damage( params );
        
        if ( !isdefined( self.lc_records ) )
        {
            self.lc_records = [];
            return;
        }
        
        self.lc_records = arraycombineunique( self.lc_records, [ params.lc_id ] );
        return;
    }
    
    base_duration = params.stun_duration ?? ( isplayer( self ) ? getdvarint( @"hash_76b59dd07a5d1f7c", 3 ) : 3 );
    variation = params.stun_variation ?? 0.5;
    duration = base_duration + randomfloatrange( variation * -1, variation );
    params.duration = duration;
    
    if ( isplayer( self ) )
    {
        lc_stun_and_damage_player( var_f191c2408c95ef7, params );
        return;
    }
    
    if ( self.type == "zombie" && isdefined( self.aicategory ) )
    {
        if ( self.aicategory == "normal" )
        {
            duration = params.var_a4b06b7d5862ddea ?? duration;
        }
        else if ( self.aicategory == "special" )
        {
            duration = params.var_ae23bfd4b4acd418 ?? duration;
        }
        else if ( self.aicategory == "elite" || self.aicategory == "hvt" )
        {
            duration = params.var_bf1f7231596f25bc ?? duration;
        }
    }
    
    if ( params.var_7a514800b212feb9 && self.aicategory == "normal" )
    {
        thread function_63083e0eb079e32d( params, duration );
    }
    
    if ( self.type )
    {
        if ( isalive( self ) && utility::issharedfuncdefined( #"effect_stun", #"stun" ) )
        {
            utility::callsharedfunc( #"effect_stun", #"stun", params.weapon.basename, duration, params.eattacker, undefined, undefined, "electrical" );
        }
        
        self.lc_stunned = 1;
        self.var_230f79da4bf6cf4a = gettime() + utility::function_4b74c15943231980( duration );
        self notify( #"zombie_lc_stunned" );
        utility::callsharedfunc( #"lightning_chain", #"lc_play_stun_fx", var_f191c2408c95ef7, params );
    }
    
    if ( params.var_516d207140d59c2 > 0 )
    {
        self.lc_stunned_pap = 1;
        
        if ( !utility::function_32b24db3127bff40( "shocked_lightning_chain", "shocked_on_paped" ) )
        {
            utility::function_32b24db3127bff40( "shocked_tesla_storm", "shocked_tesla_storm_on" );
        }
    }
    else
    {
        self.lc_stunned_pap = 0;
        
        if ( !utility::function_32b24db3127bff40( "shocked_lightning_chain", "shocked_on" ) )
        {
            utility::function_32b24db3127bff40( "shocked_tesla_storm", "shocked_tesla_storm_on" );
        }
    }
    
    self.lc_record = params.lc_id;
    thread lc_do_tick_damage_ai( params, duration );
    wait duration;
    self.lc_stunned = 0;
    self.lc_stunned_pap = 0;
    
    if ( !utility::function_32b24db3127bff40( "shocked_lightning_chain", "shocked_off" ) )
    {
        utility::function_32b24db3127bff40( "shocked_tesla_storm", "shocked_tesla_storm_off" );
    }
}

// Namespace lightning_chain
// Params 2
// Checksum 0xfa931483, Offset: 0x13ec
// Size: 0xd4
function function_63083e0eb079e32d( params, stun_duration )
{
    self endon( #"death" );
    
    while ( stun_duration > 0 )
    {
        wait 0.1;
        closest_player = function_47c86977a18df38b( level.players, self.origin, 48 );
        
        if ( isdefined( closest_player ) )
        {
            break;
        }
        
        stun_duration -= 0.1;
    }
    
    inflictor = params.use_inflictor ? params.inflictor : params.attacker;
    
    if ( !val::get( "damageshield" ) )
    {
        self kill( self.origin, params.attacker, inflictor, "MOD_ELEMENTAL_ELEC", params.weapon );
    }
}

// Namespace lightning_chain
// Params 1
// Checksum 0x922dccae, Offset: 0x14c8
// Size: 0xbc
function lc_do_damage( params )
{
    lc_damage = utility::callsharedfunc( #"lightning_chain", #"lc_damage_calculation", params );
    self.var_6232d6ee94f13e0f = params.var_6232d6ee94f13e0f ?? 0;
    inflictor = params.use_inflictor ? params.inflictor : params.attacker;
    self dodamage( lc_damage, params.arc_origin ?? self.origin, params.attacker, inflictor, "MOD_ELEMENTAL_ELEC", params.weapon, "torso_upper" );
}

// Namespace lightning_chain
// Params 1, eflags: 0x4
// Checksum 0x8131b30, Offset: 0x158c
// Size: 0x14b
function private lc_damage_calculation( params )
{
    if ( isplayer( self ) )
    {
        if ( params.tdot )
        {
            return ( params.var_8953d5d1a11c5cfd ?? getdvarint( @"hash_e951b3efc51435d9", 25 ) );
        }
        
        return ( params.player_damage ?? getdvarint( @"hash_49d1b75ff4c19854", 75 ) );
    }
    
    if ( utility::issharedfuncdefined( #"lightning_chain", #"hash_d8c9695ff733902" ) )
    {
        n_damage = utility::callsharedfunc( #"lightning_chain", #"hash_d8c9695ff733902" );
        
        if ( isdefined( n_damage ) )
        {
            return n_damage;
        }
    }
    
    if ( isnumber( params.lc_damage ) )
    {
        return params.lc_damage;
    }
    
    if ( ai::is_non_base() && isdefined( params.var_7cae2e380e0347ab ) )
    {
        var_516d207140d59c2 = minint( params.var_516d207140d59c2 ?? 0, params.var_7cae2e380e0347ab.size - 1 );
        return params.var_7cae2e380e0347ab[ var_516d207140d59c2 ];
    }
    
    if ( ai::is_non_base() )
    {
        return level.var_cf7706e013c62841[ params.var_516d207140d59c2 ?? 0 ];
    }
    
    return self.health;
}

// Namespace lightning_chain
// Params 2
// Checksum 0x826ebdcd, Offset: 0x16df
// Size: 0x159
function lc_do_tick_damage_player( params, duration )
{
    self endon( #"death_or_disconnect" );
    
    if ( !getdvarint( @"hash_e0e2f2fc98337fb8", 1 ) )
    {
        self notify( #"lc_do_tick_damage" );
        self endon( #"lc_do_tick_damage" );
    }
    
    params.tdot = 1;
    total_ticks = getdvarint( @"hash_1f72142683105b52", 5 );
    tick_time = duration / total_ticks;
    total_damage = 0;
    lc_damage = lc_damage_calculation( params );
    params.tdot = 0;
    var_911ac5c9ec402167 = int( ceil( lc_damage / total_ticks ) );
    
    for ( tick = 0; tick < total_ticks ; tick++ )
    {
        if ( tick + 1 == total_ticks )
        {
            var_911ac5c9ec402167 = lc_damage - total_damage;
        }
        
        total_damage += var_911ac5c9ec402167;
        inflictor = params.use_inflictor ? params.inflictor : params.attacker;
        self dodamage( var_911ac5c9ec402167, self.origin, params.attacker, inflictor, "MOD_ELEMENTAL_ELEC", params.weapon, "torso_upper" );
        wait tick_time;
    }
}

// Namespace lightning_chain
// Params 2
// Checksum 0xe7932e48, Offset: 0x1840
// Size: 0x19c
function lc_do_tick_damage_ai( params, duration )
{
    self endon( #"death" );
    lc_damage = lc_damage_calculation( params );
    
    if ( !isdefined( var_911ac5c9ec402167 ) )
    {
        var_911ac5c9ec402167 = params.var_911ac5c9ec402167;
    }
    
    if ( !isnumber( params.var_911ac5c9ec402167 ) )
    {
        var_911ac5c9ec402167 = int( ceil( lc_damage / duration * 2 ) );
    }
    
    self.var_6232d6ee94f13e0f = params.var_6232d6ee94f13e0f ?? 0;
    elementtype = "MOD_ELEMENTAL_ELEC";
    
    if ( isdefined( params.var_93c94c124f42e7c9 ) )
    {
        elementtype = params.var_93c94c124f42e7c9;
    }
    
    inflictor = params.use_inflictor ? params.inflictor : params.attacker;
    elapsed_damage_time = 0;
    var_fe088909b848f89b = 0;
    var_bce806f4cd50d905 = params.num_ticks && var_fe088909b848f89b >= params.num_ticks;
    
    while ( elapsed_damage_time < duration && !var_bce806f4cd50d905 )
    {
        self dodamage( var_911ac5c9ec402167, self.origin, params.attacker, inflictor, elementtype, params.weapon, "torso_upper", undefined, 1073741824 );
        var_fe088909b848f89b++;
        var_bce806f4cd50d905 = params.num_ticks && var_fe088909b848f89b >= params.num_ticks;
        wait 0.5;
        elapsed_damage_time += 0.5;
    }
}

// Namespace lightning_chain
// Params 2, eflags: 0x4
// Checksum 0x77909e0e, Offset: 0x19e4
// Size: 0x2b6
function private lc_play_stun_fx( var_f191c2408c95ef7, params )
{
    if ( params.var_516d207140d59c2 > 0 )
    {
        paped = 1;
    }
    else
    {
        paped = 0;
    }
    
    tag = "J_SpineUpper";
    
    if ( paped )
    {
        shock_fx = "tesla_shock_pap";
    }
    else
    {
        shock_fx = "tesla_shock";
    }
    
    if ( isplayer( self ) )
    {
        if ( paped )
        {
            ground_fx = "tesla_shock_ground_pap";
        }
        else
        {
            ground_fx = "tesla_shock_ground";
        }
        
        playfxontag( level._effect[ ground_fx ], self, "tag_origin" );
        
        if ( isdefined( shock_fx ) && utility::hastag( self.model, tag ) )
        {
            playfxontag( level._effect[ shock_fx ], self, tag );
        }
        
        return;
    }
    
    if ( var_f191c2408c95ef7 )
    {
        if ( paped )
        {
            ground_fx = "tesla_shock_ground_pap";
        }
        else
        {
            ground_fx = "tesla_shock_ground";
        }
        
        ground_fx_id = level._effect[ ground_fx ];
        
        if ( isdefined( params.ground_fx_id_override ) )
        {
            ground_fx_id = params.ground_fx_id_override;
        }
        
        playfxontag( ground_fx_id, self, "tag_origin" );
    }
    else
    {
        shock_fx = undefined;
    }
    
    if ( isdefined( shock_fx ) && utility::hastag( self.model, tag ) )
    {
        shock_fx_id = level._effect[ shock_fx ];
        
        if ( isdefined( params.shock_fx_id_override ) )
        {
            shock_fx_id = params.shock_fx_id_override;
        }
        
        playfxontag( shock_fx_id, self, tag );
    }
    
    if ( params.should_gib_head && isdefined( self.aicategory ) && self.aicategory == "normal" && !self.head_gibbed )
    {
        if ( randomint( 100 ) < params.head_gib_chance )
        {
            self.var_6a6a43836cde0417 = 1;
            return;
        }
        
        if ( self tagexists( "J_EyeBall_LE" ) )
        {
            if ( paped )
            {
                eye_fx = "tesla_shock_eyes_pap";
                mouth_fx = "tesla_shock_mouth_pap";
            }
            else
            {
                eye_fx = "tesla_shock_eyes";
                mouth_fx = "tesla_shock_mouth";
            }
            
            eye_fx_id = level._effect[ eye_fx ];
            
            if ( isdefined( params.eye_fx_id_override ) )
            {
                eye_fx_id = params.eye_fx_id_override;
            }
            
            mouth_fx_id = level._effect[ mouth_fx ];
            
            if ( isdefined( params.mouth_fx_id_override ) )
            {
                mouth_fx_id = params.mouth_fx_id_override;
            }
            
            playfxontag( eye_fx_id, self, "J_EyeBall_RI" );
            playfxontag( eye_fx_id, self, "J_EyeBall_LE" );
            playfxontag( mouth_fx_id, self, "J_Head" );
        }
    }
}

// Namespace lightning_chain
// Params 1, eflags: 0x4
// Checksum 0xd06213fc, Offset: 0x1ca2
// Size: 0x60
function private lc_on_ai_damage( params )
{
    if ( params.idamage >= self.health && self.lc_stunned )
    {
        self.health = int( params.idamage ) + 2;
        
        if ( !self.var_a9c101367b31e643 )
        {
            thread lc_wait_till_stun_end();
        }
    }
}

// Namespace lightning_chain
// Params 1, eflags: 0x4
// Checksum 0xb91f8a4a, Offset: 0x1d0a
// Size: 0x22
function private on_player_laststand( params )
{
    if ( self.lc_stunned )
    {
        self.lc_stunned = undefined;
    }
}

// Namespace lightning_chain
// Params 1, eflags: 0x4
// Checksum 0x514e5dbc, Offset: 0x1d34
// Size: 0x22
function private on_player_death( params )
{
    if ( self.lc_stunned )
    {
        self.lc_stunned = undefined;
    }
}

// Namespace lightning_chain
// Params 0, eflags: 0x4
// Checksum 0xcf9e174e, Offset: 0x1d5e
// Size: 0x19a
function private lc_wait_till_stun_end()
{
    self notify( #"lc_wait_till_stun_end" );
    self endon( #"lc_wait_till_stun_end" );
    self endon( #"death" );
    self.var_a9c101367b31e643 = 1;
    
    while ( self.lc_stunned )
    {
        current_time = gettime();
        
        if ( self.var_6a6a43836cde0417 && !self.head_gibbed && isdefined( self.var_230f79da4bf6cf4a ) && self.var_230f79da4bf6cf4a - current_time <= 500 )
        {
            self.var_6a6a43836cde0417 = 0;
            
            if ( utility::issharedfuncdefined( #"zombie_dismemberment", #"dismemberhead" ) )
            {
                utility::callsharedfunc( #"zombie_dismemberment", #"dismemberhead", 1 );
            }
        }
        
        waitframe();
    }
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    var_d85c6b92e2f088f0 = isdefined( self.last_dmg_struct ) ? self.last_dmg_struct.eattacker : undefined;
    last_damage_weapon = isdefined( self.last_dmg_struct ) ? self.last_dmg_struct.objweapon : undefined;
    var_f79b0bf2f35d23cc = !self.magic_bullet_shield && !self.damageshield;
    
    if ( var_f79b0bf2f35d23cc )
    {
        self kill( self.origin, var_d85c6b92e2f088f0, undefined, undefined, last_damage_weapon );
    }
    else
    {
        self dodamage( self.maxhealth, self.origin, var_d85c6b92e2f088f0, undefined, undefined, last_damage_weapon );
    }
    
    self.var_a9c101367b31e643 = 0;
}

// Namespace lightning_chain
// Params 2, eflags: 0x4
// Checksum 0xfdaadb62, Offset: 0x1f00
// Size: 0x21e
function private function_1ec562064213fee9( attacker, params )
{
    shockdata = spawnstruct();
    shockdata.tableinfo = weapon::getequipmenttableinfo( "equip_shockstick" );
    shockdata.owner = attacker;
    shockdata.team = attacker.team ?? params.team;
    shockdata.origin = attacker.origin ?? params.attacker_origin;
    shockdata.weapon = params.weapon ?? shockdata.tableinfo.objweapon;
    shockdata.tableinfo.var_f3447a3874df563f = 0;
    shockdata.tableinfo.var_9891ed88bcd38fd2 = 1;
    shockdata.tableinfo.var_c6920ebeb7833310 = 1;
    shockdata.tableinfo.var_cd1e9f6afbf90d3a = 1;
    shockdata.tableinfo.bundle.var_f232776b54e76cfa = 0.3;
    shockdata.tableinfo.bundle.var_860545b754d7ecc0 = params.duration ?? 5;
    shockdata.tableinfo.bundle.var_c8bb02c8c8cd0442 = params.duration ?? 5;
    shockdata.tableinfo.bundle.shockstick_tickinterval = 0.2;
    shockdata.tableinfo.bundle.var_bd94b71ffdfd39c = getdvarint( @"hash_63e354fa4bd6021c", 0 );
    shockdata.tableinfo.bundle.var_4c6cc0f99efbb64f = 1;
    return shockdata;
}

