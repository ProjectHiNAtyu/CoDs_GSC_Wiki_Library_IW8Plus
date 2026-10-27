// scripts\mp\common\equipment\aether_blade.gsc  (hash_371e927366c209e7.gscc) (size: 14329 Bytes / 0x37f9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaf59a271 (2941887089)
// size ...... 14329 (0x37f9)
// includes .. 11  (offset: 0x35d5)
// strings ... 30  (offset: 0x362d)
// dev strs .. 5   (offset: 0x37bd)
// exports ... 33  (offset: 0x2421)
// cseg ...... 0x30f + 0x2112 (0x2421)
// imports ... 106 (offset: 0x2949)
// animtree1 . 0   (offset: 0x37f9)
// animtree2 . 0   (offset: 0x37f9)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player;
#using scripts\mp\equipment;
#using scripts\mp\weapons;

#namespace aether_blade;

// Namespace aether_blade
// Params 0, eflags: 0x5
// Checksum 0x6442b04c, Offset: 0x32d
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"aether_blade", undefined, undefined, &post_main );
}

// Namespace aether_blade
// Params 0, eflags: 0x4
// Checksum 0x41ff72ef, Offset: 0x34e
// Size: 0x2b
function private post_main()
{
    weapons::registerusedcallback( "aether_blade", &aether_blade_used );
    zombie_utils::function_dfae6a5bd222c586( &function_dc74ffd3df2f7a80 );
    agent_utils::register_soldier_damage_callback( &function_dc74ffd3df2f7a80 );
}

// Namespace aether_blade
// Params 1, eflags: 0x4
// Checksum 0x1f80fc84, Offset: 0x381
// Size: 0x633
function private aether_blade_used( grenade )
{
    grenade endon( #"death" );
    
    if ( false )
    {
        grenade waittill( #"missile_stuck" );
    }
    else
    {
        grenade utility::waittill_notify_or_timeout( "missile_stuck", 0.2 );
    }
    
    equipmentbundle = equipment_mp::getequipmenttableinfo( grenade.equipmentref ).bundle;
    assert( equipmentbundle, "<dev string:x24>" + grenade.equipmentref );
    
    if ( !level._effect[ "aether_blade_trail" ] )
    {
        level._effect[ "aether_blade_trail" ] = loadfxasset( equipmentbundle.aether_blade_trail_fx ?? "vfx_jup_ob_gameplay_zm_weapons_dark_aether_blade_trail" );
        level._effect[ "aether_blade_impact" ] = loadfxasset( equipmentbundle.aether_blade_impact_fx ?? "vfx_jup_ob_gameplay_zm_weapons_dark_aether_blade_impact" );
        level._effect[ "aether_blade_ambient" ] = loadfxasset( equipmentbundle.aether_blade_ambient_fx ?? "vfx_jup_ob_gameplay_zm_weapons_dark_aether_blade_ambient" );
    }
    
    if ( equipmentbundle.var_7bc4a05e34130f64 )
    {
        level._effect[ "aether_blade_fx_on_collision" ] = loadfxasset( equipmentbundle.var_7bc4a05e34130f64 );
    }
    
    var_36246edd212eee6d = equipmentbundle.var_aca6e47f1a44ceca ?? 1;
    
    if ( var_36246edd212eee6d )
    {
        self radiusdamage( grenade.origin, 10, 10, 10, self, "MOD_UNKNOWN", grenade.weapon_name );
    }
    
    grenade hide();
    grenade utility::delaycallendon( 3, "death", &delete );
    config = { #var_a99ddbc25fc2557:equipmentbundle.var_693c64b7c4f59d27, #var_aad13ff0b4645859:equipmentbundle.var_d674f0756146b118 ?? 0, #var_e467d178d0515647:equipmentbundle.var_4165f1aa805d7088, #var_c60872c6b35c3de8:equipmentbundle.var_273cabe756748679 ?? 0, #target_tags:equipmentbundle.var_d868a87e762eb462 ?? [ { #targettag:"J_SpineUpper" } ], #var_99c9632bcab2edee:equipmentbundle.var_aa4b306db13896dd ?? 0, #var_5ad799431b0aa091:equipmentbundle.aether_blade_cone_angle ?? 0, #var_68471d07d5fcf38f:equipmentbundle.var_acffd36cfa4bc02e ?? 0, #var_2a45c3901e9e8b92:equipmentbundle.var_fcae3e525e2b0f82 ?? [], #cooldown_end_sound:equipmentbundle.var_a67b5d8d0db7f188 ?? "eqp_aether_blade_plr_cooldown_end", #return_sound:equipmentbundle.var_c697fb5f95c7c17d ?? "eqp_aether_blade_plr_return", #var_a8b0cddebb6f8dfd:equipmentbundle.var_1eaad54c4d4fb9f2 ?? 1, #var_b3093f0db5ff944f:equipmentbundle.var_d6d18c87fd4874fa ?? 0, #normal_damage:equipmentbundle.var_20dfd3122aee9de8 ?? 1250, #next_targets:{ #var_c30b7e4a4f644d20:equipmentbundle.var_4ec0bd191dcec820 ?? 0, #var_ed4021c11bfd3ab9:equipmentbundle.var_59d4d02c8de36ede ?? 0, #priority_radius:equipmentbundle.var_7a30e54247f5679b ?? 0, #target_radius:equipmentbundle.var_55c35a18055c9902 ?? 300 }, #var_2ea6f6a47df28978:{ #var_c30b7e4a4f644d20:equipmentbundle.var_ff3ac537e302c9ee ?? 0, #var_ed4021c11bfd3ab9:equipmentbundle.var_1851b7c5b63c0048 ?? 0, #priority_radius:equipmentbundle.var_469cdae1e7f3a9 ?? 0, #target_radius:equipmentbundle.var_cfe700c9655e1144 ?? 300 } };
    var_83e3debba79e4480 = equipmentbundle.aether_blade_target_num ?? 3;
    aether_blade_model = spawn( "script_model", grenade.origin );
    model_name = equipmentbundle.var_8f8e7c2b40151c6e ?? "jup_2h_zmb_aether_knife";
    aether_blade_model setmodel( model_name );
    aether_blade_model show();
    outline_asset = equipmentbundle.var_16cf7eee6798d61c;
    
    if ( outline_asset )
    {
        aether_blade_model.outlineid = outline::outlineenableforplayer( aether_blade_model, self, outline_asset, #"equipment" );
    }
    
    aether_blade_model.owner = self;
    aether_blade_model.equipmentref = grenade.equipmentref;
    aether_blade_model.weaponobj = grenade.weapon_object;
    aether_blade_model.var_c517aba5080c5c45 = [];
    aether_blade_model.hit_count = 0;
    aether_blade_model thread function_fa1b3cb46c4d0d23();
    
    if ( equipmentbundle.var_f26d31e1d3c517f4 )
    {
        aether_blade_model.var_5e05300e95e52dc1 = { #var_5acc2585d2268511:equipmentbundle.var_138e1a9ab57fb313 * 1000, #var_c9c0352b4d431ba9:squared( equipmentbundle.var_c57a8a91e86c82d9 ), #var_edbe145c363397ef:equipmentbundle.var_7bc4a05e34130f64, #var_7bdbff20e2e299bd:equipmentbundle.var_cf5946c1b78fca98 };
    }
    
    playfxontag( level._effect[ "aether_blade_trail" ], aether_blade_model, "tag_origin" );
    playfxontag( level._effect[ "aether_blade_ambient" ], aether_blade_model, "tag_origin" );
    travel_sound = equipmentbundle.var_ed753793b5ef9363 ?? "eqp_aether_blade_travel_lp";
    aether_blade_model playloopsound( travel_sound );
    is_super = equipmentbundle.issuper;
    callback::callback( #"equip_aether_blade_used", { #config:config, #issuper:is_super, #var_425eb565f5fdf9c4:aether_blade_model } );
    var_64c23c58b8d5a25c = vectornormalize2( aether_blade_model.origin - self.origin );
    aether_blade_model thread function_5f6ff75db37a433a( var_83e3debba79e4480, config, undefined, self.team, var_64c23c58b8d5a25c, var_64c23c58b8d5a25c, is_super );
}

// Namespace aether_blade
// Params 3, eflags: 0x4
// Checksum 0xfc0eb45b, Offset: 0x9bc
// Size: 0x69
function private function_deea4bc1d5e2289c( owner, outline_asset, duration_seconds )
{
    self notify( #"aether_blade_target_outline_start" );
    waitframe();
    outline_id = outline::outlineenableforplayer( self, owner, outline_asset, #"equipment" );
    
    if ( !outline_id )
    {
        return;
    }
    
    utility::waittill_any_timeout( duration_seconds, "aether_blade_target_outline_start" );
    outline::outlinedisable( outline_id, self );
}

// Namespace aether_blade
// Params 0, eflags: 0x4
// Checksum 0xaaff193, Offset: 0xa2d
// Size: 0x29
function private function_3c5543bd93aa88dc()
{
    if ( self.outlineid )
    {
        outline::outlinedisable( self.outlineid, self );
        self.outlineid = undefined;
    }
}

// Namespace aether_blade
// Params 0, eflags: 0x4
// Checksum 0x237a050a, Offset: 0xa5e
// Size: 0x35
function private function_fa1b3cb46c4d0d23()
{
    self endon( #"death" );
    
    while ( true )
    {
        self rotatepitch( self.angles[ 0 ] + 180, 0.25 );
        wait 0.25;
    }
}

// Namespace aether_blade
// Params 2, eflags: 0x4
// Checksum 0xa7f7d7da, Offset: 0xa9b
// Size: 0xa8
function private function_ae9eefe07c890321( var_a9adc45b7dd9be05, normal_damage )
{
    blade_damage = normal_damage;
    current_round = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
    boss_round = isalive( self ) ? zombie_utils::get_zombie_round_difficulty() : undefined;
    
    if ( isdefined( boss_round ) )
    {
        var_4feed796664d10af = int( max( current_round, boss_round ) );
    }
    else
    {
        var_4feed796664d10af = current_round;
    }
    
    base_zombie_max_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", var_4feed796664d10af );
    
    if ( isdefined( base_zombie_max_health ) )
    {
        blade_damage = max( base_zombie_max_health * 1.25, blade_damage );
    }
    
    return blade_damage;
}

// Namespace aether_blade
// Params 3, eflags: 0x4
// Checksum 0xf0e1409c, Offset: 0xb4c
// Size: 0x47
function private function_b3307fd3bde0d19a( var_a9adc45b7dd9be05, normal_damage, var_a8b0cddebb6f8dfd )
{
    if ( isplayer( self ) )
    {
        return getdvarint( @"hash_cbebae73e53fc3c1", 40 );
    }
    
    if ( var_a8b0cddebb6f8dfd )
    {
        return function_ae9eefe07c890321( var_a9adc45b7dd9be05, normal_damage );
    }
    
    return normal_damage;
}

// Namespace aether_blade
// Params 5, eflags: 0x4
// Checksum 0x35a096c4, Offset: 0xb9c
// Size: 0x1dc
function private function_8c4e7ac8e06a7214( all_targets_data, cone_origin, var_88fb636b3bb5bc3, config, target_radius )
{
    /#
        if ( getdvarint( @"hash_9344145b737556eb", 0 ) )
        {
            thread function_7a0a17f1f5fd1061( cone_origin, var_88fb636b3bb5bc3, config.var_5ad799431b0aa091, target_radius );
        }
    #/
    
    assert( config.var_5ad799431b0aa091 > 0 && config.var_5ad799431b0aa091 <= 180, "<dev string:x6a>" );
    angle_cos = cos( config.var_5ad799431b0aa091 * 0.5 );
    cone_filtered_targets = [];
    
    foreach ( data in all_targets_data )
    {
        target_pos = function_32638b6ad669f64e( data.target, config );
        is_in_cone = utility::within_fov( cone_origin, vectortoangles( var_88fb636b3bb5bc3 ), target_pos, angle_cos );
        
        /#
            if ( getdvarint( @"hash_9344145b737556eb", 0 ) )
            {
                duration = int( 2 / level.framedurationseconds );
                color = is_in_cone ? ( 0, 1, 0 ) : ( 1, 0, 0 );
                line( cone_origin, target_pos, color, 0.5, 0, duration );
                sphere( target_pos, 1, color, 0, duration );
            }
        #/
        
        if ( is_in_cone )
        {
            cone_filtered_targets[ cone_filtered_targets.size ] = data;
        }
    }
    
    return cone_filtered_targets;
}

// Namespace aether_blade
// Params 2, eflags: 0x4
// Checksum 0x56061f8, Offset: 0xd81
// Size: 0x10e
function private function_a2f0894d0dd2f332( config, is_first_target )
{
    phase = is_first_target ? config.var_2ea6f6a47df28978 : config.next_targets;
    return { #cone_origin:phase.var_c30b7e4a4f644d20 && self.owner ? self.owner.origin : self.origin, #sort_origin:phase.var_ed4021c11bfd3ab9 && self.owner ? self.owner.origin : self.origin, #priority_radius_squared:phase.priority_radius * phase.priority_radius, #priority_radius:phase.priority_radius, #target_radius:phase.target_radius };
}

// Namespace aether_blade
// Params 7, eflags: 0x4
// Checksum 0x252ba374, Offset: 0xe98
// Size: 0x2d3
function private function_5f6ff75db37a433a( remaining_target_num, config, var_a9690b26964ab57a, player_team, var_e01865d0d4eebd12, initial_direction, is_super )
{
    if ( remaining_target_num == 0 )
    {
        thread function_ff4101c3ff89f4f6( config, is_super );
        return;
    }
    
    is_first_target = !isdefined( var_a9690b26964ab57a );
    targeting_context = function_a2f0894d0dd2f332( config, is_first_target );
    final_target_data = function_5ef52c228cecf8b5( config, var_a9690b26964ab57a, player_team, initial_direction, var_e01865d0d4eebd12, targeting_context );
    var_12d6422e678506b6 = final_target_data.target;
    damage = final_target_data.damage;
    
    if ( isdefined( var_12d6422e678506b6 ) )
    {
        end_point = function_32638b6ad669f64e( var_12d6422e678506b6, config );
        var_dd5c91422e61d737 = distance( self.origin, end_point );
        new_flight_direction = vectornormalize2( end_point - self.origin );
        self moveto( end_point, var_dd5c91422e61d737 / 1000 );
        
        if ( self.var_5e05300e95e52dc1 )
        {
            thread function_9e28fc8cdb534043( end_point );
        }
        
        if ( config.var_e467d178d0515647 && isent( var_12d6422e678506b6 ) && !var_12d6422e678506b6.var_8cb233e9d21a1bdc )
        {
            var_12d6422e678506b6 thread function_deea4bc1d5e2289c( self.owner, config.var_e467d178d0515647, config.var_aad13ff0b4645859 );
        }
        
        self waittill( #"movedone" );
        
        if ( !var_12d6422e678506b6 )
        {
            var_db9651a672b7e9e7 = remaining_target_num;
        }
        else
        {
            playfxontag( level._effect[ "aether_blade_impact" ], self, "tag_origin" );
            
            if ( isent( var_12d6422e678506b6 ) )
            {
                var_12d6422e678506b6 dodamage( damage, self.origin, self.owner, self, "MOD_ELEMENTAL_ELEC", self.weaponobj, "none" );
            }
            else if ( var_12d6422e678506b6 isscriptableinstance() )
            {
                var_12d6422e678506b6 scriptabledodamage( damage, self, self.owner, undefined, undefined, "MOD_ELEMENTAL_ELEC", self.weaponobj );
            }
            else
            {
                assertmsg( "<dev string:x9e>" );
            }
            
            self.hit_count++;
            var_db9651a672b7e9e7 = remaining_target_num - 1;
            
            if ( final_target_data.id )
            {
                self.var_c517aba5080c5c45[ final_target_data.id ] = ( self.var_c517aba5080c5c45[ final_target_data.id ] ?? 0 ) + 1;
            }
            
            self.owner callback::callback( #"equip_aether_blade_hit", { #issuper:is_super, #target:var_12d6422e678506b6, #var_425eb565f5fdf9c4:self } );
        }
    }
    else
    {
        thread function_ff4101c3ff89f4f6( config, is_super );
        return;
    }
    
    thread function_5f6ff75db37a433a( var_db9651a672b7e9e7, config, var_12d6422e678506b6, player_team, new_flight_direction, initial_direction, is_super );
}

// Namespace aether_blade
// Params 1, eflags: 0x4
// Checksum 0xbb6533e1, Offset: 0x1173
// Size: 0x104
function private function_9e28fc8cdb534043( var_f370b69d0d8846ba )
{
    self endon( #"death" );
    self endon( #"movedone" );
    prev_origin = self.origin;
    
    while ( true )
    {
        var_e6ef1231966449aa = self.origin;
        
        if ( distancesquared( prev_origin, var_e6ef1231966449aa ) > self.var_5e05300e95e52dc1.var_c9c0352b4d431ba9 )
        {
            trace_start = prev_origin;
            trace_end = var_e6ef1231966449aa;
            prev_origin = var_e6ef1231966449aa;
            var_617f2876f4b4344e = [ self, self.owner ];
            contents = trace::create_default_contents( 1 );
            forward_trace = trace::ray_trace( trace_start, trace_end, var_617f2876f4b4344e, contents, undefined, undefined, 1 );
            backward_trace = trace::ray_trace( trace_end, trace_start, var_617f2876f4b4344e, contents, undefined, undefined, 1 );
            function_485386eb22fcde9b( forward_trace );
            function_485386eb22fcde9b( backward_trace );
        }
        
        waitframe();
    }
}

// Namespace aether_blade
// Params 1, eflags: 0x4
// Checksum 0x6a6ab451, Offset: 0x127f
// Size: 0xf7
function private function_485386eb22fcde9b( trace )
{
    if ( trace[ "hittype" ] == "hittype_none" )
    {
        return;
    }
    
    current_time = gettime();
    
    if ( self.var_3e8e8d9d8322e453 )
    {
        delta_ms = current_time - self.var_3e8e8d9d8322e453;
        
        if ( delta_ms < self.var_5e05300e95e52dc1.var_5acc2585d2268511 )
        {
            return;
        }
    }
    
    self.var_3e8e8d9d8322e453 = current_time;
    self.var_a36f15517f082288 = trace[ "position" ];
    
    if ( self.var_5e05300e95e52dc1.var_edbe145c363397ef )
    {
        playfx( level._effect[ "aether_blade_fx_on_collision" ], self.var_a36f15517f082288 );
    }
    
    if ( self.var_5e05300e95e52dc1.var_7bdbff20e2e299bd )
    {
        self.owner playsoundtoplayer( self.var_5e05300e95e52dc1.var_7bdbff20e2e299bd, self.owner );
    }
}

// Namespace aether_blade
// Params 6, eflags: 0x4
// Checksum 0xcb9f540e, Offset: 0x137e
// Size: 0x96
function private function_5ef52c228cecf8b5( config, var_a9690b26964ab57a, player_team, initial_direction, var_e01865d0d4eebd12, targeting_context )
{
    candidates_data = function_4df6404bf66acdb5( config, var_a9690b26964ab57a, player_team, initial_direction, var_e01865d0d4eebd12, targeting_context );
    filtered_targets = function_ceb1e812fa373018( config, candidates_data, targeting_context, initial_direction, var_e01865d0d4eebd12 );
    ordered_targets = arraysort( filtered_targets, targeting_context.sort_origin, &function_2a4139be406bdc5c );
    
    if ( ordered_targets.size == 0 )
    {
        return;
    }
    
    return ordered_targets[ 0 ];
}

// Namespace aether_blade
// Params 6, eflags: 0x4
// Checksum 0xf4f9e7c1, Offset: 0x141d
// Size: 0x3de
function private function_4df6404bf66acdb5( config, var_a9690b26964ab57a, player_team, initial_direction, var_e01865d0d4eebd12, targeting_context )
{
    all_targets_data = [];
    all_ai_targets = function_99fb8c7007247437( player_team, config, var_a9690b26964ab57a, initial_direction, var_e01865d0d4eebd12, targeting_context );
    
    foreach ( target in all_ai_targets )
    {
        current_damage = target function_b3307fd3bde0d19a( 0, config.normal_damage, config.var_a8b0cddebb6f8dfd );
        var_868e37a07a449c7f = { #damage:current_damage, #target:target };
        all_targets_data[ all_targets_data.size ] = var_868e37a07a449c7f;
    }
    
    if ( level.var_53e40963495d2f98 )
    {
        player_final_targets = function_be8aeb2a9ff1293d( self, player_team, var_a9690b26964ab57a, targeting_context.target_radius );
        
        foreach ( target in player_final_targets )
        {
            current_damage = target function_b3307fd3bde0d19a( 0, config.normal_damage, config.var_a8b0cddebb6f8dfd );
            var_868e37a07a449c7f = { #damage:current_damage, #target:target };
            all_targets_data[ all_targets_data.size ] = var_868e37a07a449c7f;
        }
    }
    
    foreach ( extra_target_entry in config.var_2a45c3901e9e8b92 )
    {
        if ( !extra_target_entry.damage )
        {
            continue;
        }
        
        category = extra_target_entry.var_e5fd8a7061f978aa;
        assert( category, "<dev string:xe4>" );
        var_250bc7e336dba17 = extra_target_entry.var_8dd4b6e8229f3b7d;
        
        if ( var_250bc7e336dba17 && ( self.var_c517aba5080c5c45[ category ] ?? 0 ) >= var_250bc7e336dba17 )
        {
            continue;
        }
        
        filter_options = structcombine( extra_target_entry.var_2810b8cd4dcd42a2[ 0 ].variant_object, { #referenceentity:self.owner } );
        candidates = utility::callsharedfunc( category, #"get_in_radius", self.origin, targeting_context.target_radius, filter_options ) ?? [];
        
        foreach ( candidate in candidates )
        {
            if ( candidate == var_a9690b26964ab57a || candidate.kfe_ignore )
            {
                continue;
            }
            
            var_868e37a07a449c7f = { #id:category, #damage:extra_target_entry.damage, #target:candidate };
            all_targets_data[ all_targets_data.size ] = var_868e37a07a449c7f;
        }
    }
    
    return all_targets_data;
}

// Namespace aether_blade
// Params 6, eflags: 0x4
// Checksum 0x768cc27, Offset: 0x1804
// Size: 0x103
function private function_99fb8c7007247437( player_team, config, var_a9690b26964ab57a, initial_direction, var_e01865d0d4eebd12, targeting_context )
{
    ai_targets = getaiarrayinradius( self.origin, targeting_context.target_radius );
    filtered_ai_targets = [];
    
    foreach ( ai in ai_targets )
    {
        if ( ai.team == player_team || ai.kfe_ignore || ai == var_a9690b26964ab57a )
        {
            continue;
        }
        
        filtered_ai_targets[ filtered_ai_targets.size ] = ai;
    }
    
    return filtered_ai_targets;
}

// Namespace aether_blade
// Params 5, eflags: 0x4
// Checksum 0x63a4e699, Offset: 0x1910
// Size: 0x1cd
function private function_ceb1e812fa373018( config, candidates_data, targeting_context, initial_direction, var_e01865d0d4eebd12 )
{
    if ( config.var_68471d07d5fcf38f )
    {
        var_7254f8631fe6c3ee = 1;
        
        if ( targeting_context.priority_radius > 0 )
        {
            /#
                if ( getdvarint( @"hash_9344145b737556eb", 0 ) )
                {
                    duration = int( 2 / level.framedurationseconds );
                    color = ( 1, 1, 1 );
                    sphere( self.origin, targeting_context.priority_radius, color, 0, duration );
                }
            #/
            
            close_targets = [];
            
            foreach ( data in candidates_data )
            {
                target = data.target;
                
                if ( distancesquared( self.origin, target.origin ) <= targeting_context.priority_radius_squared )
                {
                    close_targets[ close_targets.size ] = data;
                }
            }
            
            if ( close_targets.size )
            {
                candidates_data = close_targets;
                var_7254f8631fe6c3ee = 0;
            }
        }
        
        if ( var_7254f8631fe6c3ee )
        {
            var_88fb636b3bb5bc3 = config.var_99c9632bcab2edee ? initial_direction : var_e01865d0d4eebd12;
            candidates_data = function_8c4e7ac8e06a7214( candidates_data, targeting_context.cone_origin, var_88fb636b3bb5bc3, config, targeting_context.target_radius );
        }
    }
    
    return candidates_data;
}

// Namespace aether_blade
// Params 3, eflags: 0x4
// Checksum 0x240c2336, Offset: 0x1ae6
// Size: 0x6e, Type: bool
function private function_2a4139be406bdc5c( data_a, data_b, origin )
{
    distance_a = distancesquared( origin, data_a.target.origin );
    distance_b = distancesquared( origin, data_b.target.origin );
    return distance_a < distance_b;
}

// Namespace aether_blade
// Params 1, eflags: 0x4
// Checksum 0x5c8b5854, Offset: 0x1b5d
// Size: 0x7a, Type: bool
function private function_3e2c99e172995675( config )
{
    if ( config.var_a99ddbc25fc2557 && self.hit_count > 0 && self.hit_count < config.var_a99ddbc25fc2557 )
    {
        return false;
    }
    
    if ( config.var_6786de64b82133b6 && !self.owner [[ config.var_6786de64b82133b6 ]]( self.hit_count ) )
    {
        return false;
    }
    
    return true;
}

// Namespace aether_blade
// Params 0, eflags: 0x4
// Checksum 0x24a764ab, Offset: 0x1be0
// Size: 0xf
function private function_ec306b5d6546fcda()
{
    function_3c5543bd93aa88dc();
    self delete();
}

// Namespace aether_blade
// Params 2, eflags: 0x4
// Checksum 0xbaf595e3, Offset: 0x1bf7
// Size: 0x17f
function private function_ff4101c3ff89f4f6( config, is_super )
{
    end_point = function_663c0256aeaf0a70();
    
    if ( !isdefined( end_point ) )
    {
        function_ec306b5d6546fcda();
    }
    else if ( !function_3e2c99e172995675( config ) )
    {
        self.owner callback::callback( #"equip_aether_blade_return", { #issuper:is_super, #var_425eb565f5fdf9c4:self } );
        function_ec306b5d6546fcda();
        return;
    }
    
    var_dd5c91422e61d737 = distance( self.origin, end_point );
    var_d524330523e6df2d = var_dd5c91422e61d737 / 1000;
    self moveto( end_point, var_d524330523e6df2d );
    
    if ( self.var_5e05300e95e52dc1 )
    {
        thread function_9e28fc8cdb534043( end_point );
    }
    
    thread function_645f2b1bdcce4dcb( var_d524330523e6df2d );
    self waittill( #"movedone" );
    
    if ( isdefined( self.owner ) )
    {
        self.owner playsoundtoplayer( config.return_sound, self.owner );
        self.owner function_879aef0a5fef56b5();
        
        if ( config.var_b3093f0db5ff944f )
        {
            self.owner thread function_841d2b4e075390db( self.equipmentref, config.cooldown_end_sound );
        }
        
        self.owner callback::callback( #"equip_aether_blade_return", { #issuper:is_super, #var_425eb565f5fdf9c4:self } );
    }
    
    function_ec306b5d6546fcda();
}

// Namespace aether_blade
// Params 0, eflags: 0x4
// Checksum 0xd2ec8588, Offset: 0x1d7e
// Size: 0x1a
function private function_879aef0a5fef56b5()
{
    utility::function_7c10ea82c1e305b8( "aether_blade_fx", "on" );
    thread function_b8fff6f117b863ca();
}

// Namespace aether_blade
// Params 0, eflags: 0x4
// Checksum 0x5ababf37, Offset: 0x1da0
// Size: 0x31
function private function_b8fff6f117b863ca()
{
    msg = utility::waittill_any_timeout( 1, "death" );
    
    if ( isdefined( self ) )
    {
        utility::function_7c10ea82c1e305b8( "aether_blade_fx", "off" );
    }
}

// Namespace aether_blade
// Params 1, eflags: 0x4
// Checksum 0x736cff4d, Offset: 0x1dd9
// Size: 0x8d
function private function_645f2b1bdcce4dcb( var_d524330523e6df2d )
{
    self endon( #"death" );
    self endon( #"movedone" );
    frame_duration = level.framedurationseconds ?? 0.05;
    fly_time_left = var_d524330523e6df2d - frame_duration;
    
    while ( fly_time_left > 0 )
    {
        waitframe();
        end_point = function_663c0256aeaf0a70();
        
        if ( !isdefined( end_point ) )
        {
            function_3c5543bd93aa88dc();
            self delete();
        }
        
        self moveto( end_point, fly_time_left );
        fly_time_left -= frame_duration;
    }
}

// Namespace aether_blade
// Params 0, eflags: 0x4
// Checksum 0xdcb5705e, Offset: 0x1e6e
// Size: 0x4c
function private function_663c0256aeaf0a70()
{
    if ( !isalive( self.owner ) )
    {
        return;
    }
    
    var_82f0fb6dc1c89261 = self.owner gettagorigin( "j_spineupper" );
    
    if ( !isdefined( var_82f0fb6dc1c89261 ) )
    {
        var_82f0fb6dc1c89261 = self.owner getcentroid();
    }
    
    return var_82f0fb6dc1c89261;
}

// Namespace aether_blade
// Params 1, eflags: 0x4
// Checksum 0x616399d2, Offset: 0x1ec2
// Size: 0x8f, Type: bool
function private function_aa2c8c826e715283( player )
{
    if ( !isplayer( player ) )
    {
        return false;
    }
    
    if ( utility::issharedfuncdefined( #"game", #"isCommonItemEnabled" ) )
    {
        if ( !utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
        {
            return false;
        }
        
        if ( !( utility::issharedfuncdefined( #"game", #"hash_6a1940cb87219089" ) && utility::issharedfuncdefined( #"game", #"getItemBundleNameFromRef" ) ) )
        {
            return false;
        }
        
        return true;
    }
    
    return false;
}

// Namespace aether_blade
// Params 2, eflags: 0x4
// Checksum 0x1728bdc0, Offset: 0x1f5a
// Size: 0xc9
function private function_fc0a6fce020512e6( equipmentref, cooldown_end_sound )
{
    if ( !isdefined( equipmentref ) || !isalive( self ) )
    {
        return;
    }
    
    if ( function_aa2c8c826e715283( self ) )
    {
        itembundlename = utility::callsharedfunc( #"game", #"getItemBundleNameFromRef", equipmentref );
        
        if ( !isdefined( itembundlename ) )
        {
            return;
        }
        
        itembundle = getscriptbundle( itembundlename );
        fakeitem = spawnstruct();
        fakeitem.count = 1;
        fakeitem.type = itembundle.scriptable;
        self playsoundtoplayer( cooldown_end_sound, self );
        utility::callsharedfunc( #"game", #"hash_6a1940cb87219089", fakeitem, 0, 1 );
    }
}

// Namespace aether_blade
// Params 2, eflags: 0x4
// Checksum 0x110fdc1c, Offset: 0x202b
// Size: 0x106
function private function_32638b6ad669f64e( ai_target, config )
{
    if ( !isent( ai_target ) )
    {
        return ai_target.origin;
    }
    
    foreach ( entry in config.target_tags )
    {
        assert( entry.targettag, "<dev string:x115>" );
        end_point = ai_target gettagorigin( entry.targettag, 1 );
        
        if ( end_point )
        {
            break;
        }
    }
    
    if ( !end_point )
    {
        end_point = config.var_c60872c6b35c3de8 ? ai_target getcentroid() : ai_target.origin;
    }
    
    return end_point;
}

// Namespace aether_blade
// Params 2, eflags: 0x4
// Checksum 0x5f67dfb0, Offset: 0x213a
// Size: 0x40
function private function_841d2b4e075390db( equipmentref, cooldown_end_sound )
{
    self endon( #"death" );
    wait 3;
    
    while ( self.isjuggernaut )
    {
        wait 1;
    }
    
    function_fc0a6fce020512e6( equipmentref, cooldown_end_sound );
}

// Namespace aether_blade
// Params 1, eflags: 0x4
// Checksum 0x7ce8c892, Offset: 0x2182
// Size: 0x79
function private function_dc74ffd3df2f7a80( params )
{
    if ( isdefined( params.objweapon ) && isplayer( params.eattacker ) && params.objweapon.basename == "iw9_knifestab_mp" && params.objweapon.variantid == 3 )
    {
        return function_b3307fd3bde0d19a( 1, 1250, 1 );
    }
    
    return -1;
}

/#

    // Namespace aether_blade
    // Params 4, eflags: 0x4
    // Checksum 0xa8abd3f8, Offset: 0x2204
    // Size: 0x127, Type: dev
    function private function_7a0a17f1f5fd1061( cone_origin, var_88fb636b3bb5bc3, var_244e33c25ff537e5, radius )
    {
        self endon( #"death" );
        duration = int( 2 / level.framedurationseconds );
        half_angle = var_244e33c25ff537e5 * 0.5;
        cone_length = radius;
        center_end = cone_origin + var_88fb636b3bb5bc3 * cone_length;
        line( cone_origin, center_end, ( 0, 1, 1 ), 0.75, 0, duration );
        left_edge_direction = rotatevector( var_88fb636b3bb5bc3, ( 0, half_angle, 0 ) );
        left_edge_end = cone_origin + left_edge_direction * cone_length;
        line( cone_origin, left_edge_end, ( 1, 1, 0 ), 1, 0, duration );
        right_edge_direction = rotatevector( var_88fb636b3bb5bc3, ( 0, half_angle * -1, 0 ) );
        right_edge_end = cone_origin + right_edge_direction * cone_length;
        line( cone_origin, right_edge_end, ( 1, 1, 0 ), 1, 0, duration );
    }

#/

// Namespace aether_blade
// Params 4, eflags: 0x4
// Checksum 0xb8610619, Offset: 0x2333
// Size: 0xed
function private function_be8aeb2a9ff1293d( var_4473dc4711666f16, player_team, var_a9690b26964ab57a, target_radius )
{
    var_7038c7cd7298e8d6 = getplayersinradius( var_4473dc4711666f16.origin, target_radius, 1000 );
    player_final_targets = [];
    
    foreach ( target in var_7038c7cd7298e8d6 )
    {
        if ( target.team == player_team || !player::isreallyalive( target ) )
        {
            continue;
        }
        
        if ( target == var_a9690b26964ab57a )
        {
            continue;
        }
        
        player_final_targets[ player_final_targets.size ] = target;
    }
    
    return player_final_targets;
}

