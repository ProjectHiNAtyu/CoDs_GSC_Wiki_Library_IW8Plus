// scripts\mp\common\perks\zombie\perk_m_mod.gsc  (hash_03643f31d2cb3f26.gscc) (size: 17334 Bytes / 0x43b6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x865aaa05 (2254088709)
// size ...... 17334 (0x43b6)
// includes .. 16  (offset: 0x3e4a)
// strings ... 67  (offset: 0x3eca)
// dev strs .. 0   (offset: 0x43b6)
// exports ... 26  (offset: 0x28f6)
// cseg ...... 0x6cf + 0x2227 (0x28f6)
// imports ... 141 (offset: 0x2d06)
// animtree1 . 0   (offset: 0x43b6)
// animtree2 . 0   (offset: 0x43b6)
#using script_16ea1b94f0f381b3;
#using scripts\anim\utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\metabone;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\currency;

#namespace perk_m_mod;

// Namespace perk_m_mod
// Params 0, eflags: 0x5
// Checksum 0x991339f9, Offset: 0x6ed
// Size: 0x15
function private autoexec __init__system__()
{
    system::register( "specialty_m_mod", undefined, &__init__, undefined );
}

// Namespace perk_m_mod
// Params 0, eflags: 0x1
// Checksum 0xc8ebe2ca, Offset: 0x70a
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_3530ceeaeabd3af5 );
}

// Namespace perk_m_mod
// Params 0
// Checksum 0x581903a1, Offset: 0x72a
// Size: 0xa
function __init__()
{
    level thread function_4d9f8718e4807b0();
}

// Namespace perk_m_mod
// Params 1
// Checksum 0xa0d45d24, Offset: 0x73c
// Size: 0x5e
function function_3530ceeaeabd3af5( params )
{
    bundle = level.perkbundles[ "specialty_m_mod" ];
    
    if ( !bundle )
    {
        return;
    }
    
    if ( isfunction( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_m_mod", &function_a83a14617a6b9969, &function_40be123087ac0173 );
    }
}

// Namespace perk_m_mod
// Params 0
// Checksum 0x8fe0854e, Offset: 0x7a2
// Size: 0x165
function function_4d9f8718e4807b0()
{
    if ( !level.zombie_perks_in_use )
    {
        return;
    }
    
    level endon( #"game_ended" );
    level utility::flag_init( "specialty_m_mod" + "init_complete" );
    level utility::flag_wait_all( "StartGameTypeCallbackFinished", "zombie_perks_init_complete" );
    str_currency = currency::get_perk_machine_currency( "specialty_m_mod" );
    var_fcb7626c79b3c98f = currency::get_perk_machine_cost( "specialty_m_mod" );
    level._effect[ "m_mod_hit_zombie" ] = loadfxasset( "vfx_t10_gameplay_zm_perk_machine_melee_macchiato_gloves_hit_zombies" );
    level._effect[ "zombie_blood" ] = loadfxasset( "vfx_t10_gameplay_zm_punching_blood" );
    level._effect[ "player_camera_blood" ] = loadfxasset( "vfx_t10_gameplay_zm_punching_blood_camera" );
    level._effect[ "player_punch_camera" ] = loadfxasset( "vfx_t10_gameplay_zm_punching_camera" );
    level._effect[ "player_punch_nothing_camera" ] = loadfxasset( "vfx_t10_gameplay_zm_punching_variant_camera" );
    var_7c0c0569bf2695fb = var_fcb7626c79b3c98f ?? 2000;
    level thread zombie_perks::enable_perk_for_level( "specialty_m_mod", str_currency, var_7c0c0569bf2695fb, &function_a83a14617a6b9969, &function_40be123087ac0173, 1 );
    zombie_utils::function_dfae6a5bd222c586( &function_17fdfda41f9aa95a );
    agent_utils::register_soldier_damage_callback( &function_17fdfda41f9aa95a );
    scriptable::scriptable_addnotifycallback( "m_mod_punch", &function_b4d54ecd0903cbe2 );
    scriptable::scriptable_addnotifycallback( "m_mod_punch_stop", &function_302051863d7df500 );
    level utility::flag_set( "specialty_m_mod" + "init_complete" );
}

// Namespace perk_m_mod
// Params 0
// Checksum 0xafb6c219, Offset: 0x90f
// Size: 0xb4
function function_a83a14617a6b9969()
{
    utility::ent_flag_set( "perk_m_mod_active" );
    melee_weapon_dmg_multiplier = 3;
    var_fbbb1259b16d80fc = 1.5;
    var_913e73538232df23 = 2;
    
    if ( isdefined( melee_weapon_dmg_multiplier ) )
    {
        self.var_614432bb9af09520 = melee_weapon_dmg_multiplier;
    }
    
    if ( isdefined( var_fbbb1259b16d80fc ) )
    {
        self.var_fbbb1259b16d80fc = var_fbbb1259b16d80fc;
    }
    
    if ( isdefined( var_913e73538232df23 ) )
    {
        self.var_913e73538232df23 = var_913e73538232df23;
    }
    
    if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_m_mod", #"m_mod_panic_knife" ) )
    {
        if ( !self hasperk( "specialty_melee_without_swap" ) )
        {
            perk::giveperk( "specialty_melee_without_swap" );
        }
    }
    
    thread m_mod_think();
}

// Namespace perk_m_mod
// Params 4
// Checksum 0x266073dc, Offset: 0x9cb
// Size: 0xbf
function function_40be123087ac0173( var_d93428f5ff5cb05d, str_perk, str_result, var_e97a4f4962bc3f25 )
{
    utility::ent_flag_clear( "perk_m_mod_active" );
    utility::ent_flag_clear( "allow_play_punch_animations" );
    self notify( #"end_m_mod" );
    val::reset_all( "specialty_m_mod" );
    val::reset_all( "specialty_m_mod_allow_fire" );
    val::reset( "specialty_m_mod", "melee" );
    self.b_in_m_mod_punch = 0;
    self.var_23c08b8d00196b63 = 0;
    self.var_614432bb9af09520 = undefined;
    self.var_fbbb1259b16d80fc = undefined;
    self.var_913e73538232df23 = undefined;
    
    if ( self hasperk( "specialty_melee_without_swap" ) )
    {
        perk::removeperk( "specialty_melee_without_swap" );
    }
}

// Namespace perk_m_mod
// Params 0
// Checksum 0xfa8a5a9c, Offset: 0xa92
// Size: 0xd
function function_6755e68908f3fde7()
{
    return utility::ent_flag( "perk_m_mod_active" );
}

// Namespace perk_m_mod
// Params 1
// Checksum 0xa1ec3762, Offset: 0xaa8
// Size: 0x58, Type: bool
function function_dc2626f05ee229f9( weapon )
{
    return weapon.basename == "sat_ar_falcon_mp" && weapon hasattachmenthash( %"sat_bar_spear_ar_falcon" ) || weapon.basename == "sat_sm_serval_mp" && weapon hasattachmenthash( %"hash_6867e986d0f605d2" );
}

// Namespace perk_m_mod
// Params 1, eflags: 0x4
// Checksum 0xc361ec4, Offset: 0xb09
// Size: 0x65
function private function_17fdfda41f9aa95a( params )
{
    if ( isdefined( params.eattacker ) && params.eattacker function_6755e68908f3fde7() && params.smeansofdeath == "MOD_MELEE" )
    {
        damage = params.idamage ?? 0;
        return damage;
    }
    
    return -1;
}

// Namespace perk_m_mod
// Params 0, eflags: 0x4
// Checksum 0xb51b2270, Offset: 0xb77
// Size: 0x3a9
function private m_mod_think()
{
    self notify( #"start_m_mod" );
    self endon( #"start_m_mod" );
    self endon( #"end_m_mod" );
    self endon( #"disconnect" );
    
    if ( isbot( self ) )
    {
        return;
    }
    
    val::reset_all( "specialty_m_mod" );
    self notifyonplayercommand( "use_m_mod", "-melee_zoom" );
    anim_index = 0;
    m_mod_punch_animations = [ "cer_zm_vm_ges_melee_macchiato_punch_01", "cer_zm_vm_ges_melee_macchiato_punch_02", "cer_zm_vm_ges_melee_macchiato_punch_03", "cer_zm_vm_ges_melee_macchiato_punch_04", "cer_zm_vm_ges_melee_macchiato_punch_05" ];
    
    if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_m_mod", #"m_mod_faster_melee" ) || self.var_17f492ff119958ff )
    {
        for ( n = 0; n < m_mod_punch_animations.size ; n++ )
        {
            m_mod_punch_animations[ n ] += "_speedup";
        }
    }
    
    thread m_mod_weapon_check();
    
    if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_m_mod", #"m_mod_panic_knife" ) )
    {
        if ( !self hasperk( "specialty_melee_without_swap" ) )
        {
            perk::giveperk( "specialty_melee_without_swap" );
        }
    }
    
    weapon = self getcurrentweapon();
    
    while ( true )
    {
        self waittill( #"use_m_mod" );
        waitframe();
        
        if ( level.var_eeb6ebe322e71cd1 || self.var_eeb6ebe322e71cd1 || player::isinlaststand( self ) || self isonladder() || self isonascender() || self.var_d1c4c78b9fb7d153 || self.is_crafting || self isoffhandweaponreadytothrow() || self isthrowinggrenade() || player::isreviving() || self ismantling() || self isswitchingweapon() || self isdiving() || self ismeleeing() || vehicle::is_in_vehicle() || self.geigercounterstruct.pulledout || self isgestureplaying() && !self issprintsliding() || self isemoteactive() || self.var_368d507d011a22b2 || !val::get_ignore_ids( "melee", [ "specialty_m_mod" ] ) || player::isplayerads() || self isinexecutionattack() || self getcurrentweapon() === self.var_cc1262e66dbb1c79 )
        {
            continue;
        }
        
        if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_m_mod", #"m_mod_panic_knife" ) )
        {
            return;
        }
        
        if ( utility::ent_flag( "allow_play_punch_animations" ) && !self.b_in_m_mod_punch )
        {
            val::set( "specialty_m_mod_allow_fire", "fire", 0 );
            self.b_in_m_mod_punch = 1;
            self takeweapon( m_mod_punch_animations[ anim_index ? anim_index - 1 : m_mod_punch_animations.size - 1 ] );
            melee_animation = m_mod_punch_animations[ anim_index ];
            anim_index++;
            
            if ( anim_index > m_mod_punch_animations.size - 1 )
            {
                anim_index = 0;
            }
            
            callback::callback( "on_m_mod_punch" );
            level thread function_89c9432244f6c10( self, self issprinting() );
            thread utility::function_72b6372d2d8c997( melee_animation, 1, 1 );
            var_caaca764beec6965 = strtoksubstr( melee_animation, "cer_zm_vm_ges_melee_macchiato_punch" );
            current_gesture = "cer_zm_vm_ges_m_mod_melee" + var_caaca764beec6965[ 0 ];
            var_2098f7bb5e8c6f96 = self getgestureanimlength( current_gesture );
            wait var_2098f7bb5e8c6f96;
            self.b_in_m_mod_punch = 0;
            self.var_23c08b8d00196b63 = 0;
            val::reset_all( "specialty_m_mod_allow_fire" );
        }
    }
}

// Namespace perk_m_mod
// Params 0
// Checksum 0x3b8ee0a9, Offset: 0xf28
// Size: 0x253
function m_mod_weapon_check()
{
    level endon( #"game_ended" );
    self endon( #"end_m_mod", #"disconnect" );
    utility::ent_flag_init( "allow_play_punch_animations" );
    
    while ( true )
    {
        if ( !isdefined( self ) )
        {
            waitframe();
            continue;
        }
        
        if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_m_mod", #"m_mod_panic_knife" ) )
        {
            if ( !self hasperk( "specialty_melee_without_swap" ) )
            {
                perk::giveperk( "specialty_melee_without_swap" );
            }
            
            val::set( "specialty_m_mod", "melee", 1 );
            utility::ent_flag_clear( "allow_play_punch_animations" );
            self notifyonplayercommandremove( "use_m_mod", "+attack" );
            self notifyonplayercommandremove( "use_m_mod", "+speed_throw" );
            return;
        }
        
        current_weapon = self getcurrentweapon();
        
        if ( current_weapon === self.var_cc1262e66dbb1c79 || player::isinlaststand( self ) || self isswimming() || current_weapon.basename == "t10_la_mangler_cannon_mp" || issubstr( current_weapon.basename, "t10_la_p19_opalww" ) || issubstr( current_weapon.basename, "sat_ww_firefly" ) || issubstr( current_weapon.basename, "sat_ww_hornet" ) || function_dc2626f05ee229f9( current_weapon ) || utility::callsharedfunc( #"mutant_injection", #"hash_c578992dd449ebb6" ) )
        {
            val::set( "specialty_m_mod", "melee", 1 );
            utility::ent_flag_clear( "allow_play_punch_animations" );
            self notifyonplayercommandremove( "use_m_mod", "+attack" );
            self notifyonplayercommandremove( "use_m_mod", "+speed_throw" );
        }
        else if ( current_weapon == level.defaultfist )
        {
            val::set( "specialty_m_mod", "melee", 0 );
            utility::ent_flag_set( "allow_play_punch_animations" );
            self notifyonplayercommand( "use_m_mod", "+attack" );
            self notifyonplayercommand( "use_m_mod", "+speed_throw" );
        }
        else
        {
            val::set( "specialty_m_mod", "melee", 0 );
            utility::ent_flag_set( "allow_play_punch_animations" );
            self notifyonplayercommandremove( "use_m_mod", "+attack" );
            self notifyonplayercommandremove( "use_m_mod", "+speed_throw" );
        }
        
        wait 0.1;
    }
}

// Namespace perk_m_mod
// Params 4
// Checksum 0x5963d8a1, Offset: 0x1183
// Size: 0xa6
function function_b4d54ecd0903cbe2( eattacker, note, param, var_64ffacba090c91be )
{
    eattacker endon( #"hash_b4015e5ae9dc42df" );
    level endon( #"game_ended" );
    eattacker.left_touch_volume = spawn( "trigger_radius", eattacker.entity gettagorigin( "j_base_hand_le" ), 0, 25, 25 );
    eattacker.right_touch_volume = spawn( "trigger_radius", eattacker.entity gettagorigin( "j_base_hand_ri" ), 0, 25, 25 );
    level thread m_mod_punch_zombies( eattacker );
}

// Namespace perk_m_mod
// Params 1
// Checksum 0x79ec506d, Offset: 0x1231
// Size: 0xcd
function m_mod_punch_zombies( eattacker )
{
    level endon( #"game_ended" );
    eattacker endon( #"hash_b4015e5ae9dc42df" );
    
    while ( true )
    {
        level waittill( #"m_mod_punch", var_b3c36a0d3c8029f, var_b3c37a0d3c804d2, var_b3c38a0d3c80705 );
        
        if ( !isdefined( var_b3c36a0d3c8029f ) )
        {
            continue;
        }
        
        /#
            iprintlnbold( var_b3c36a0d3c8029f );
        #/
        
        if ( var_b3c36a0d3c8029f == "left" || var_b3c36a0d3c8029f == "right" )
        {
            bone_name = var_b3c36a0d3c8029f == "left" ? "j_base_hand_le" : "j_base_hand_ri";
            trace_position = eattacker.entity gettagorigin( bone_name );
            level thread function_37adbcd36538ec37( eattacker, trace_position );
        }
    }
}

// Namespace perk_m_mod
// Params 2
// Checksum 0xb59d6d6a, Offset: 0x1306
// Size: 0xb4
function function_89c9432244f6c10( eattacker, var_4320d5be338c5025 )
{
    level endon( #"game_ended" );
    eattacker endon( #"death_or_disconnect" );
    eattacker utility::waittill_any_timeout( 2, "offhand_pullback" );
    eattacker.var_23c08b8d00196b63 = 1;
    trace_position_start = anglestoforward( eattacker getplayerangles() ) * 10 + eattacker geteye();
    
    if ( var_4320d5be338c5025 )
    {
        trace_position_end = anglestoforward( eattacker getplayerangles() ) * 60 + eattacker geteye();
    }
    else
    {
        trace_position_end = anglestoforward( eattacker getplayerangles() ) * 20 + eattacker geteye();
    }
    
    level thread function_37adbcd36538ec37( eattacker, trace_position_start, trace_position_end );
}

// Namespace perk_m_mod
// Params 3
// Checksum 0x97cf9e53, Offset: 0x13c2
// Size: 0x84d
function function_37adbcd36538ec37( eattacker, trace_position, trace_position_end )
{
    level endon( #"game_ended" );
    
    if ( isplayer( eattacker ) )
    {
        eattacker endon( #"death_or_disconnect" );
    }
    
    punch_radius = eattacker.m_mod_overrides.punch_radius ?? level.perkbundles[ "specialty_m_mod" ].punchradius ?? 30;
    b_hit_anything = 0;
    
    if ( !isdefined( trace_position_end ) )
    {
        trace_position_end = trace_position;
    }
    
    if ( isdefined( eattacker ) && !isent( eattacker ) )
    {
        trace = trace::sphere_trace_get_all_results( trace_position, trace_position_end, punch_radius, eattacker.entity, undefined, undefined, 1 );
    }
    else
    {
        trace = trace::sphere_trace_get_all_results( trace_position, trace_position_end, punch_radius, eattacker, undefined, undefined, 1 );
        a_damage_triggers = getentarrayinradius( "trigger_damage", #classname, trace_position, punch_radius );
        
        foreach ( trigger in a_damage_triggers )
        {
            trigger notify( #"damage", 50, eattacker, trace_position - eattacker.origin, trace_position, "MOD_MELEE" );
            b_hit_anything = 1;
        }
    }
    
    zombies = [];
    hit_players = [];
    hit_entities = [];
    hit_scriptables = [];
    
    foreach ( trace_result in trace )
    {
        if ( isplayer( trace_result[ "entity" ] ) && trace_result[ "entity" ].team != eattacker.team )
        {
            hit_players[ hit_players.size ] = trace_result[ "entity" ];
            b_hit_anything = 1;
            continue;
        }
        
        if ( isai( trace_result[ "entity" ] ) && isalive( trace_result[ "entity" ] ) && !isdefined( trace_result[ "entity" ].var_bd22ba6c600a23a3 ) )
        {
            if ( trace_result[ "entity" ] val::get( "damage" ) )
            {
                zombies[ zombies.size ] = trace_result[ "entity" ];
                b_hit_anything = 1;
            }
            
            continue;
        }
        
        if ( isent( trace_result[ "entity" ] ) )
        {
            hit_entities[ hit_entities.size ] = trace_result[ "entity" ];
            b_hit_anything = 1;
            continue;
        }
        
        if ( isdefined( trace_result[ "scriptable" ] ) )
        {
            hit_scriptables[ hit_scriptables.size ] = trace_result[ "scriptable" ];
            b_hit_anything = 1;
        }
    }
    
    if ( isplayer( eattacker ) && isalive( eattacker ) && !eattacker getcamerathirdperson() )
    {
        if ( b_hit_anything )
        {
            eattacker playrumbleonentity( "damage_heavy" );
            waitframe();
            
            if ( isplayer( eattacker ) && isalive( eattacker ) )
            {
                playfxontagforclients( level._effect[ "player_punch_camera" ], eattacker, "j_head", eattacker );
            }
        }
        else
        {
            eattacker playrumbleonentity( "damage_light" );
            waitframe();
            
            if ( isplayer( eattacker ) && isalive( eattacker ) )
            {
                playfxontagforclients( level._effect[ "player_punch_nothing_camera" ], eattacker, "j_head", eattacker );
            }
        }
    }
    
    waitframe();
    
    if ( isplayer( eattacker ) && isalive( eattacker ) )
    {
        eattacker radiusdamage( trace_position, punch_radius, 100, 100, eattacker, "MOD_MELEE", "<explicitweaponnone>", 1 );
    }
    
    foreach ( player in hit_players )
    {
        if ( isalive( player ) )
        {
            player dodamage( 100, eattacker.origin, eattacker, eattacker, "MOD_MELEE", "<explicitweaponnone>" );
        }
    }
    
    foreach ( entity in hit_entities )
    {
        if ( isent( entity ) )
        {
            if ( entity vehicle::is_vehicle() && !entity vehicle::is_husk() && isplayer( eattacker ) && !entity.var_8839162ef17bfbc1 )
            {
                if ( entity vehicle_getspeed() < 1 )
                {
                    if ( entity.occupants.size <= 0 )
                    {
                        if ( isdefined( entity.origin ) && isdefined( trace_position ) )
                        {
                            entity vehphys_impulse( vectornormalize2( entity.origin - trace_position ), 30 );
                        }
                    }
                }
            }
            
            entity dodamage( 50, eattacker.origin, eattacker, eattacker, "MOD_MELEE", "<explicitweaponnone>" );
        }
    }
    
    foreach ( scriptable in hit_scriptables )
    {
        if ( isdefined( scriptable ) )
        {
            scriptable scriptabledodamage( 100, eattacker, eattacker, undefined, undefined, "MOD_MELEE", "<explicitweaponnone>" );
        }
    }
    
    zombies = utility::array_removedead_or_dying( zombies );
    enemy_zombies = [];
    
    foreach ( zombie in zombies )
    {
        if ( zombie zombie_utils::function_bf1464d09f4e4b40() || zombie.team == eattacker.team )
        {
            continue;
        }
        
        enemy_zombies[ enemy_zombies.size ] = zombie;
    }
    
    zombies = enemy_zombies;
    
    if ( eattacker utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_m_mod", #"m_mod_overwhelming_force" ) )
    {
        punch_radius *= level.zombie_augments[ #"m_mod_overwhelming_force" ].var_be3537b487a3b954 ?? 15;
        n_sound_count = 0;
        
        for ( n = 0; n < 3 ; n++ )
        {
            zombie = eattacker utility::function_4113d68e8e0a401f( zombies );
            
            if ( isdefined( zombie ) )
            {
                n_sound_count++;
            }
            
            if ( n_sound_count == 3 )
            {
                eattacker playsoundonmovingent( #"hash_13e2d833079d2fbe" );
            }
            
            level thread function_528fae578354c46a( zombie, eattacker, trace_position, punch_radius );
            zombies = utility::array_removedead_or_dying( zombies );
        }
    }
    else
    {
        if ( isent( eattacker ) )
        {
            if ( isplayer( eattacker ) )
            {
                huge_zombies = function_6c3cedaa21c9c8e0( zombies );
                zombies = utility::get_array_of_closest( eattacker.origin, zombies, undefined, undefined, 100 );
                
                if ( huge_zombies.size > 0 )
                {
                    zombies = arraycombineunique( zombies, huge_zombies );
                }
                
                var_f792509d72a84f58 = eattacker function_a6b07e59fe0d8016( zombies );
            }
            else
            {
                var_f792509d72a84f58 = eattacker utility::function_4113d68e8e0a401f( zombies );
            }
        }
        else
        {
            var_f792509d72a84f58 = eattacker.entity utility::function_4113d68e8e0a401f( zombies );
        }
        
        level thread function_528fae578354c46a( var_f792509d72a84f58, eattacker, trace_position, punch_radius );
    }
    
    if ( zombies.size != 0 )
    {
        if ( isplayer( eattacker ) && isalive( eattacker ) && !eattacker getcamerathirdperson() )
        {
            waitframe();
            
            if ( isplayer( eattacker ) && isalive( eattacker ) )
            {
                playfxontagforclients( level._effect[ "player_camera_blood" ], eattacker, "j_head", eattacker );
            }
        }
    }
}

// Namespace perk_m_mod
// Params 1
// Checksum 0x18086535, Offset: 0x1c17
// Size: 0xb8
function function_6c3cedaa21c9c8e0( zombies )
{
    huge_zombies = [];
    
    foreach ( zombie in zombies )
    {
        if ( issubstr( zombie.subclass, "zombie_abom" ) || issubstr( zombie.subclass, "zombie_callisto" ) )
        {
            huge_zombies[ huge_zombies.size ] = zombie;
        }
    }
    
    return huge_zombies;
}

// Namespace perk_m_mod
// Params 4
// Checksum 0xd459be9d, Offset: 0x1cd8
// Size: 0x543
function function_528fae578354c46a( zombie, eattacker, trace_position = undefined, punch_radius )
{
    if ( isai( zombie ) && isalive( zombie ) && isdefined( zombie.subclass ) )
    {
        if ( isdefined( trace_position ) )
        {
            playfx( level._effect[ "m_mod_hit_zombie" ], trace_position );
        }
        
        if ( !isdefined( eattacker.m_mod_overrides.damage ) )
        {
            max_damage_round = level.perkbundles[ "specialty_m_mod" ].maxdamageround ?? 30;
            current_round = undefined;
            
            if ( zombie.type == "zombie" )
            {
                current_round = zombie zombie_utils::get_zombie_round_difficulty();
            }
            else
            {
                current_round = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( zombie.origin );
            }
            
            base_zombie_max_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", current_round );
            
            if ( eattacker utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_m_mod", #"m_mod_pressure_points" ) && isdefined( level.zombie_augments[ #"m_mod_pressure_points" ].var_214cc1d3e160728c ) && isplayer( eattacker ) )
            {
                var_3f03aa5d85b59f0b = level.zombie_augments[ #"m_mod_pressure_points" ].var_214cc1d3e160728c ?? 5;
                max_damage_round += var_3f03aa5d85b59f0b;
            }
            
            var_6a02108301e17dc = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", int( max_damage_round ) ) ?? 1635;
            n_damage = current_round <= max_damage_round ? int( base_zombie_max_health ) : int( var_6a02108301e17dc );
            
            if ( n_damage < 525 )
            {
                n_damage = 525;
            }
        }
        else
        {
            n_damage = eattacker.m_mod_overrides.damage;
        }
        
        victim_aicategory = zombie.aicategory;
        victim_subclass = zombie.subclass;
        zombie.killed_by_melee_macchiato = 1;
        
        switch ( zombie.subclass )
        {
            case #"hash_1380581f5144c465":
            case #"hash_44aaeb0edd152195":
            case #"hash_95ca02b3cab53ad5":
            case #"hash_c8364cded587d807":
                if ( zombie.health > n_damage )
                {
                    zombie dodamage( n_damage, trace_position, eattacker, eattacker, "MOD_MELEE", "<explicitweaponnone>", trace_position, undefined, 1073741824 );
                }
                else
                {
                    zombie thread impact_zombie( n_damage, eattacker.origin, eattacker, trace_position );
                }
                
                break;
            case #"hash_99a38be9e88b5244":
            case #"hash_f297af39454fdc7b":
                if ( zombie.health > n_damage )
                {
                    zombie dodamage( n_damage, trace_position, eattacker, eattacker, "MOD_MELEE", "<explicitweaponnone>", trace_position, undefined, 1073741824 );
                    zombie thread damage_zombie_armor();
                }
                else
                {
                    zombie thread impact_zombie( n_damage, eattacker.origin, eattacker, trace_position );
                }
                
                break;
            case #"hash_495efa282c276f6a":
                zombie dodamage( n_damage, trace_position, eattacker, eattacker, "MOD_MELEE", "<explicitweaponnone>", trace_position, undefined, 1073741824 );
                break;
            case #"hash_3d51cb1a1a5f356b":
            case #"hash_7ba1ac4906d2dfde":
                target_head = function_8157e5f47eb4f74b( zombie, trace_position, punch_radius );
                function_d7400fc515dae67e( eattacker, zombie, target_head );
                zombie dodamage( n_damage, trace_position, eattacker, eattacker, "MOD_MELEE", "<explicitweaponnone>", trace_position, undefined, 1073741824 );
                break;
            case #"hash_2f5c52f1e6ef9284":
                if ( !isdefined( zombie.var_f5b407724684cb72 ) )
                {
                    zombie.var_f5b407724684cb72 = 0;
                }
                
                zombie.var_f5b407724684cb72++;
                
                if ( zombie.var_f5b407724684cb72 == 1 )
                {
                    zombie dodamage( n_damage, trace_position, eattacker, eattacker, "MOD_MELEE", "<explicitweaponnone>", trace_position, undefined, 1073741824 );
                    zombie thread metabone::destroy_metabone( "armored_head" );
                }
                else if ( zombie.var_f5b407724684cb72 >= 2 && zombie.health > n_damage )
                {
                    zombie dodamage( n_damage, trace_position, eattacker, eattacker, "MOD_MELEE", "<explicitweaponnone>", trace_position, undefined, 1073741824 );
                    zombie thread metabone::destroy_metabone( "armored_torso" );
                }
                else
                {
                    zombie thread impact_zombie( n_damage, eattacker.origin, eattacker, trace_position );
                }
                
                break;
            default:
                if ( zombie.health > n_damage )
                {
                    zombie dodamage( n_damage, trace_position, eattacker, eattacker, "MOD_MELEE" );
                }
                else
                {
                    zombie thread impact_zombie( n_damage, eattacker.origin, eattacker, trace_position );
                }
                
                break;
        }
        
        if ( !isalive( zombie ) )
        {
            params = spawnstruct();
            params.player = eattacker;
            params.victim_aicategory = victim_aicategory;
            params.victim_subclass = victim_subclass;
            callback::callback( #"melee_macchiato_kill", params );
            return;
        }
        
        zombie.killed_by_melee_macchiato = undefined;
    }
}

// Namespace perk_m_mod
// Params 1, eflags: 0x4
// Checksum 0xb4eb0f1a, Offset: 0x2223
// Size: 0x79
function private function_dee7f642539eb113( damage )
{
    level endon( #"game_ended" );
    
    if ( damage >= self.health )
    {
        while ( true )
        {
            entity = self getcorpseentity();
            
            if ( isdefined( entity ) )
            {
                break;
            }
            
            waitframe();
        }
        
        if ( entity && entity tagexists( "j_head" ) )
        {
            playfxontag( level._effect[ "zombie_blood" ], entity, "j_head" );
        }
    }
}

// Namespace perk_m_mod
// Params 6, eflags: 0x4
// Checksum 0xa676bce1, Offset: 0x22a4
// Size: 0x117
function private impact_zombie( damage, original_pos, eattacker, trace_position, z_offset = 30, override_impact = 7000 )
{
    level endon( #"game_ended" );
    aicategory = self.aicategory;
    subclass = self.subclass;
    
    if ( val::get( "allow_secondary_attack_damage" ) )
    {
        position_offset = ( 0, 0, z_offset );
        impact_vector = vectornormalize( self.origin + position_offset - original_pos ) * override_impact;
        self.ragdollimpactvector = impact_vector;
        self.ragdollhitloc = "torso_upper";
        self.do_immediate_ragdoll = 1;
    }
    
    self dodamage( damage, trace_position, eattacker, eattacker, "MOD_MELEE", "<explicitweaponnone>", "body" );
    
    if ( self.subclass == "zombie_base" )
    {
        function_dee7f642539eb113( damage );
    }
}

// Namespace perk_m_mod
// Params 0, eflags: 0x4
// Checksum 0xe99f359c, Offset: 0x23c3
// Size: 0xe4
function private damage_zombie_armor()
{
    armored_parts = [ "armored_head", "armored_torso" ];
    
    foreach ( part in armored_parts )
    {
        if ( isdefined( self.metabones.info[ part ] ) )
        {
            thread metabone::destroy_metabone( part );
        }
    }
    
    if ( self.health / 3 > 10 )
    {
        self dodamage( self.health / 3, self.origin, self, self, "MOD_MELEE", "<explicitweaponnone>" );
    }
}

// Namespace perk_m_mod
// Params 3, eflags: 0x4
// Checksum 0xaf5d3f06, Offset: 0x24af
// Size: 0x1ff
function private function_8157e5f47eb4f74b( zombie, trace_position, punch_radius )
{
    closest_metabone = undefined;
    closest_metabone_dist_sq = 0;
    metabones_def = zombie metabone::get_metabones_def( zombie.metabones.bundle_name );
    
    foreach ( metabone in metabones_def.metabones )
    {
        if ( !zombie.metabones.info[ metabone.name ].is_active )
        {
            continue;
        }
        
        if ( zombie metabone::is_metabone_destroyed( metabone.name ) )
        {
            continue;
        }
        
        if ( !isdefined( metabone.tags ) )
        {
            continue;
        }
        
        foreach ( tag in metabone.tags )
        {
            tag_origin = zombie gettagorigin( tag.tagname );
            tag_radius_sq = squared( punch_radius );
            dist_sq = distancesquared( trace_position, tag_origin );
            
            if ( dist_sq <= tag_radius_sq && ( !isdefined( closest_metabone ) || dist_sq < closest_metabone_dist_sq ) )
            {
                closest_metabone = metabone;
                closest_metabone_dist_sq = dist_sq;
            }
        }
    }
    
    if ( isdefined( closest_metabone ) )
    {
        return closest_metabone;
    }
}

// Namespace perk_m_mod
// Params 3, eflags: 0x4
// Checksum 0x62eb76bd, Offset: 0x26b6
// Size: 0xe4
function private function_d7400fc515dae67e( eattacker, zombie, target_head )
{
    if ( isdefined( target_head ) )
    {
        head = target_head.name;
        var_e8b483d049d7276b = level.var_2aeaf66762db8e14[ head ];
        
        if ( utility::issharedfuncdefined( #"zombie_abom_metabones", #"hash_7dd1871877d05ca4" ) && self [[ utility::getsharedfunc( #"zombie_abom_metabones", #"hash_7dd1871877d05ca4" ) ]]( zombie, var_e8b483d049d7276b ) )
        {
            if ( zombie metabone::get_metabone_state_name( head ) == "open" )
            {
                var_d5fe158ae1ee58f6 = zombie metabone::get_metabone_state_name( head );
                health = zombie metabone::get_metabone_health( head, "open" );
                zombie metabone::destroy_metabone( head, eattacker, eattacker );
                n_damage = health;
            }
        }
    }
}

// Namespace perk_m_mod
// Params 4
// Checksum 0x1c06cc4, Offset: 0x27a2
// Size: 0x34
function function_302051863d7df500( eattacker, note, param, var_64ffacba090c91be )
{
    eattacker notify( #"hash_b4015e5ae9dc42df" );
}

// Namespace perk_m_mod
// Params 1
// Checksum 0xa453727, Offset: 0x27de
// Size: 0x117
function function_a6b07e59fe0d8016( array )
{
    assert( isdefined( self.origin ) && isdefined( self.angles ) );
    closest_dot = -1;
    closest_object = undefined;
    
    if ( isplayer( self ) )
    {
        forward = anglestoforward( self getplayerangles() );
        
        foreach ( object in array )
        {
            dir = vectornormalize( ( object gettagorigin( "j_spine4", 1 ) ?? object.origin ) - self geteye() );
            dot = vectordot( forward, dir );
            
            if ( dot >= closest_dot )
            {
                closest_dot = dot;
                closest_object = object;
            }
        }
    }
    
    return closest_object;
}

