// scripts\common\ai\aitypes\zombie_shade\zombie_shade_loot_consume.gsc  (hash_64242b56109110ca.gscc) (size: 29010 Bytes / 0x7152 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5cb56d54 (1555393876)
// size ...... 29010 (0x7152)
// includes .. 17  (offset: 0x6a2a)
// strings ... 86  (offset: 0x6ab2)
// dev strs .. 30  (offset: 0x6fae)
// exports ... 57  (offset: 0x4ca6)
// cseg ...... 0x7ea + 0x44bc (0x4ca6)
// imports ... 164 (offset: 0x558e)
// animtree1 . 0   (offset: 0x7152)
// animtree2 . 0   (offset: 0x7152)
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_bloat;
#using scripts\common\ai\aitypes\shared\zombie\zombie_cannonball;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\shared\zombie\zombie_vehicle_attack;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vortex;
#using scripts\common\weapon;

#namespace zombie_shade_loot_consume;

// Namespace zombie_shade_loot_consume
// Params 0
// Checksum 0xaeb2ffad, Offset: 0x808
// Size: 0x80
function init_zombie_shade_loot_consume_global()
{
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_killed", &function_235d5af87d482e9f );
    callback::get_template( self.animsetname ) callback::add( "on_turned", &function_9aa35441ce7c4080 );
    callback::get_template( self.animsetname ) callback::add( "on_loot_consumed", &function_9c81001a758da650 );
    level.var_2b9fc8aec2cf8250 = throttle::throttle_initialize( "zombie_shade_escape_location_search" );
    
    /#
        setup_loot_consume_devgui();
    #/
}

// Namespace zombie_shade_loot_consume
// Params 0
// Checksum 0x947d543f, Offset: 0x890
// Size: 0x1df
function init_zombie_shade_loot_consume()
{
    shade_settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    assert( isdefined( shade_settings ) );
    self.loot_consume = {};
    self.loot_consume.loot_cache = [];
    self.loot_consume.fullness = 0;
    thread init_loot_anchor();
    self.loot_consume.var_67f9e5a5f6aed92 = shade_settings.var_6c7aa2c4ad6c039f;
    self.loot_consume.var_5e6aa2a6ac3be739 = shade_settings.var_595b817d30a40eb0;
    self.loot_consume.escape_countdown_time = shade_settings.var_43dca5187c675079;
    self.loot_consume.escape_max_dist = shade_settings.escapemaxdistance;
    self.loot_consume.escape_min_dist = shade_settings.var_89307d12b223b1b0;
    self.loot_consume.max_fullness = shade_settings.var_bc861ac75005b13a;
    self.loot_consume.var_a301e88487b5ae27 = shade_settings.var_8149624f9b0371df;
    self.loot_consume.item_rules = shade_settings.var_84adcd85f04b82c8;
    self function_786bb6aa1b76c7ee( "loot_consume_no_enemy_range", shade_settings.var_8f7e419458108cd8 );
    self function_786bb6aa1b76c7ee( "escape_play_normal_despawn_percentage", getdvarfloat( @"hash_d5cb7020fd1b069b", 100 - shade_settings.var_18adb97e435b4b41 ) / 100 );
    utility::ent_flag_set( "loot_consume_init_data_completed" );
    
    if ( !level.var_5764917dcaa613ac.completely )
    {
        thread function_53eb747fa0c2f11e();
        thread function_ac088600a648f5ad();
    }
    
    /#
        thread function_b7030e165389ba05();
    #/
}

// Namespace zombie_shade_loot_consume
// Params 5
// Checksum 0x1c7a9689, Offset: 0xa77
// Size: 0x161
function function_2c1c775b372991b0( completely, category, rarity, subtype, scriptable )
{
    if ( !isdefined( level.var_5764917dcaa613ac ) )
    {
        level.var_5764917dcaa613ac = {};
    }
    
    if ( completely )
    {
        level.var_5764917dcaa613ac.completely = 1;
        var_d3bf5c32e7a64eb1 = getaispeciesarray( undefined, "zombie" );
        
        foreach ( zombie in var_d3bf5c32e7a64eb1 )
        {
            if ( isalive( zombie ) || zombie.subclass == "zombie_shade" )
            {
                zombie notify( #"hash_adf928d9c1f2ebce" );
            }
        }
    }
    
    level.var_5764917dcaa613ac.category = category;
    level.var_5764917dcaa613ac.rarity = rarity;
    level.var_5764917dcaa613ac.subtype = subtype;
    level.var_5764917dcaa613ac.scriptable = scriptable;
}

// Namespace zombie_shade_loot_consume
// Params 0
// Checksum 0x88ad25c1, Offset: 0xbe0
// Size: 0xdc
function function_b818e48f9610532c()
{
    if ( level.var_5764917dcaa613ac.completely )
    {
        var_d3bf5c32e7a64eb1 = getaispeciesarray( undefined, "zombie" );
        
        foreach ( zombie in var_d3bf5c32e7a64eb1 )
        {
            if ( isalive( zombie ) || zombie.subclass == "zombie_shade" )
            {
                zombie thread function_53eb747fa0c2f11e();
                zombie thread function_ac088600a648f5ad();
            }
        }
    }
    
    if ( isdefined( level.var_5764917dcaa613ac ) )
    {
        level.var_5764917dcaa613ac = undefined;
    }
}

// Namespace zombie_shade_loot_consume
// Params 2
// Checksum 0x3a5197d4, Offset: 0xcc4
// Size: 0x51a, Type: bool
function function_358b866c88d3f426( loot, rarityoverride )
{
    assert( self.subclass == "<dev string:x24>", "<dev string:x31>" );
    
    if ( loot.var_7a65426f252841e7 || function_2ac060959800f785( loot ) )
    {
        return false;
    }
    
    nav_loc = function_c59ed25bf6a98518( loot );
    
    if ( !isdefined( nav_loc ) )
    {
        return false;
    }
    
    if ( level.var_5764917dcaa613ac.completely || self.loot_consume.var_5764917dcaa613ac.completely )
    {
        thread function_53eb747fa0c2f11e();
        thread function_ac088600a648f5ad();
    }
    
    self.loot_consume.favorite_loot = loot;
    
    if ( isdefined( loot.var_6828becb300b1c44 ) )
    {
        var_57fdcc855c1a3725 = { #type:loot.var_6828becb300b1c44.baseweapon, #rarity:rarityoverride ?? loot.var_6828becb300b1c44.rarity ?? 0 };
        
        if ( isdefined( loot.weaponobj ) && weapon::iswonderweapon( loot.weaponobj ) )
        {
            var_57fdcc855c1a3725.subtype = "ww";
        }
        
        function_c4d8da13da22efe8( var_57fdcc855c1a3725 );
    }
    else if ( isdefined( loot.type ) && issubstr( loot.type, "zmloot" ) && ( issubstr( loot.type, "killstreak" ) || issubstr( loot.type, "perk" ) || issubstr( loot.type, "armor_vest" ) || issubstr( loot.type, "aether_crystal" ) || issubstr( loot.type, "aether_tool" ) || issubstr( loot.type, "ammomod" ) ) )
    {
        bundle_cache = level.var_3e82f98749e6c569[ loot.type ];
        
        if ( !isdefined( bundle_cache ) )
        {
            bundle_cache = { #rarity:loot get_zmloot_rarity( loot.type ) };
            function_c4d8da13da22efe8( bundle_cache );
            level.var_3e82f98749e6c569[ loot.type ] = bundle_cache;
        }
        
        var_57fdcc855c1a3725 = { #consume_time:bundle_cache.consume_time, #consume_fullness:bundle_cache.consume_fullness, #rarity:rarityoverride ?? bundle_cache.rarity };
    }
    else
    {
        bundle_cache = level.var_3e82f98749e6c569[ loot.type ];
        
        if ( !isdefined( bundle_cache ) )
        {
            loot_bundle = level utility::callsharedfunc( #"game", #"hash_4aa5275ed9e408f4", loot.type );
            
            if ( isdefined( loot_bundle ) )
            {
                bundle_cache = { #subtype:loot_bundle.subtype, #rarity:rarityoverride ?? loot_bundle.rarity ?? 0 };
                function_c4d8da13da22efe8( bundle_cache );
                var_57fdcc855c1a3725 = { #consume_time:bundle_cache.consume_time, #consume_fullness:bundle_cache.consume_fullness, #subtype:bundle_cache.subtype, #rarity:bundle_cache.rarity };
            }
        }
    }
    
    if ( !isdefined( var_57fdcc855c1a3725 ) )
    {
        var_57fdcc855c1a3725 = { #subtype:"ww", #rarity:-1 };
        function_c4d8da13da22efe8( var_57fdcc855c1a3725 );
    }
    
    var_57fdcc855c1a3725.loot = loot;
    var_57fdcc855c1a3725.score = max( var_57fdcc855c1a3725.consume_fullness, 0.01 ) / max( var_57fdcc855c1a3725.consume_time, 1 );
    
    /#
        var_1056b101d8460b51 = isdefined( loot.owningplayer ) ? "<dev string:x9d>" + loot.owningplayer getentitynumber() : "<dev string:xa0>";
        var_57fdcc855c1a3725.name = "<dev string:xa1>" + var_57fdcc855c1a3725.loot.index + ( loot.var_7a65426f252841e7 ? "<dev string:xa5>" + var_1056b101d8460b51 + "<dev string:xae>" : "<dev string:xa0>" ) + "<dev string:xb0>" + ( isdefined( loot.var_6828becb300b1c44 ) ? loot.var_6828becb300b1c44.baseweapon : loot.type );
    #/
    
    var_57fdcc855c1a3725.nav_loc = nav_loc;
    self.loot_consume.loot_cache = [ var_57fdcc855c1a3725 ];
    self function_786bb6aa1b76c7ee( "has_loot_nearby", 1 );
    self function_786bb6aa1b76c7ee( "force_consume_loot", 1 );
    return true;
}

// Namespace zombie_shade_loot_consume
// Params 5
// Checksum 0x10e53219, Offset: 0x11e7
// Size: 0x10c
function function_20b7d83929d84799( completely, category, rarity, subtype, scriptable )
{
    if ( !isdefined( self.loot_consume.var_5764917dcaa613ac ) )
    {
        self.loot_consume.var_5764917dcaa613ac = {};
    }
    
    if ( completely )
    {
        self.loot_consume.var_5764917dcaa613ac.completely = 1;
        self notify( #"hash_adf928d9c1f2ebce" );
    }
    
    self.loot_consume.var_5764917dcaa613ac.category = category;
    self.loot_consume.var_5764917dcaa613ac.rarity = rarity;
    self.loot_consume.var_5764917dcaa613ac.subtype = subtype;
    self.loot_consume.var_5764917dcaa613ac.scriptable = scriptable;
}

// Namespace zombie_shade_loot_consume
// Params 0
// Checksum 0x2930a0a3, Offset: 0x12fb
// Size: 0x5a
function function_7b93a5cdf96e7c8d()
{
    if ( self.loot_consume.var_5764917dcaa613ac.completely )
    {
        thread function_53eb747fa0c2f11e();
        thread function_ac088600a648f5ad();
    }
    
    if ( isdefined( self.loot_consume.var_5764917dcaa613ac ) )
    {
        self.loot_consume.var_5764917dcaa613ac = undefined;
    }
}

// Namespace zombie_shade_loot_consume
// Params 1
// Checksum 0xe91fe3e, Offset: 0x135d
// Size: 0x1a
function set_max_fullness( fullness )
{
    thread function_1c90e4b1fdbad9e1( "loot_consume_max_fullness", fullness );
}

// Namespace zombie_shade_loot_consume
// Params 1
// Checksum 0x25b286ce, Offset: 0x137f
// Size: 0x38
function function_78a1195600802b3e( distance )
{
    assert( distance >= self.loot_consume.escape_min_dist );
    thread function_1c90e4b1fdbad9e1( "escape_max_dist", distance );
}

// Namespace zombie_shade_loot_consume
// Params 1
// Checksum 0xa954782a, Offset: 0x13bf
// Size: 0x38
function function_e0048c23359f51bc( distance )
{
    assert( distance <= self.loot_consume.escape_max_dist );
    thread function_1c90e4b1fdbad9e1( "escape_min_dist", distance );
}

// Namespace zombie_shade_loot_consume
// Params 1
// Checksum 0xe33aa638, Offset: 0x13ff
// Size: 0x1a
function set_play_special_despawn_percentage( percentage )
{
    thread function_1c90e4b1fdbad9e1( "play_special_despawn_percentage", percentage );
}

// Namespace zombie_shade_loot_consume
// Params 0
// Checksum 0x41d1ea40, Offset: 0x1421
// Size: 0x8b
function function_4dfb06dcc4d8d032()
{
    loot_target = self.loot_consume.target_data.loot;
    
    if ( isdefined( loot_target ) && loot_target.var_ee6ebfea66bb219e == self )
    {
        loot_target.var_ee6ebfea66bb219e = undefined;
    }
    
    function_b28479ffb94894e4( 0 );
    
    if ( isdefined( self.loot_consume.target_data ) )
    {
        self.loot_consume.target_data = undefined;
    }
    
    self notify( #"loot_target_cleared" );
}

// Namespace zombie_shade_loot_consume
// Params 1
// Checksum 0xf5e6d4ea, Offset: 0x14b4
// Size: 0x5d
function function_b28479ffb94894e4( var_56b7251bafa5b3c6 )
{
    self._blackboard.var_9c38e049b407d5eb = var_56b7251bafa5b3c6;
    
    if ( var_56b7251bafa5b3c6 )
    {
        val::set( "loot_consume_target", "disallow_zombie_spreader", 1 );
        self function_b1fcfc3cc2092665( 1 );
        return;
    }
    
    val::reset( "loot_consume_target", "disallow_zombie_spreader" );
    self function_b1fcfc3cc2092665( 0 );
}

// Namespace zombie_shade_loot_consume
// Params 3
// Checksum 0x5fdbb604, Offset: 0x1519
// Size: 0x101
function function_6fcd6de63ff02786( var_a893d970dfe07798, var_c73bd95a555a454b, var_a58e45dc2a8c3687 )
{
    if ( !isdefined( self.loot_consume.var_5764917dcaa613ac ) )
    {
        self.loot_consume.var_5764917dcaa613ac = {};
    }
    
    if ( !isdefined( self.loot_consume.var_5764917dcaa613ac.exclusion_zones ) )
    {
        self.loot_consume.var_5764917dcaa613ac.exclusion_zones = [];
    }
    
    var_e6177610da53a853 = spawnstruct();
    var_e6177610da53a853.exclusion_zone_name = var_a893d970dfe07798;
    var_e6177610da53a853.exclusion_origin = var_c73bd95a555a454b;
    var_e6177610da53a853.exclusion_radius = var_a58e45dc2a8c3687;
    self.loot_consume.var_5764917dcaa613ac.exclusion_zones[ self.loot_consume.var_5764917dcaa613ac.exclusion_zones.size ] = var_e6177610da53a853;
}

// Namespace zombie_shade_loot_consume
// Params 1
// Checksum 0xf64fa72a, Offset: 0x1622
// Size: 0xe2, Type: bool
function function_1da40d3c211112b9( loot )
{
    if ( isdefined( self.loot_consume.var_5764917dcaa613ac.exclusion_zones ) )
    {
        foreach ( exclusionzone in self.loot_consume.var_5764917dcaa613ac.exclusion_zones )
        {
            if ( distance2dsquared( exclusionzone.exclusion_origin, loot.origin ) <= squared( exclusionzone.exclusion_radius ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace zombie_shade_loot_consume
// Params 1
// Checksum 0x6aa6f681, Offset: 0x170d
// Size: 0x109
function function_9c9941b36dcb13e0( var_a893d970dfe07798 )
{
    assert( isdefined( self.loot_consume.var_5764917dcaa613ac.exclusion_zones ) );
    
    foreach ( Exclusion_Zone in self.loot_consume.var_5764917dcaa613ac.exclusion_zones )
    {
        if ( Exclusion_Zone.exclusion_zone_name == var_a893d970dfe07798 )
        {
            self.loot_consume.var_5764917dcaa613ac.exclusion_zones = arrayremove( self.loot_consume.var_5764917dcaa613ac.exclusion_zones, Exclusion_Zone );
            return;
        }
    }
}

// Namespace zombie_shade_loot_consume
// Params 0
// Checksum 0xad0102c5, Offset: 0x181e
// Size: 0x40
function function_34e65b2d2c9dea18()
{
    if ( isdefined( self.loot_consume.var_5764917dcaa613ac.exclusion_zones ) )
    {
        self.loot_consume.var_5764917dcaa613ac.exclusion_zones = undefined;
    }
}

// Namespace zombie_shade_loot_consume
// Params 0
// Checksum 0xe489e438, Offset: 0x1866
// Size: 0xd
function function_1365927dc6b61e82()
{
    level.var_9f30d0b5ac49cedf = 1;
}

// Namespace zombie_shade_loot_consume
// Params 2, eflags: 0x4
// Checksum 0xd7853a70, Offset: 0x187b
// Size: 0xd2
function private function_1c90e4b1fdbad9e1( key, value )
{
    self endon( #"death" );
    utility::ent_flag_wait( "loot_consume_init_data_completed" );
    
    switch ( key )
    {
        case #"hash_c3bf97424267f1b6":
            self.loot_consume.max_fullness = int( value );
            break;
        case #"hash_6188a1e5390fa754":
            self.loot_consume.escape_max_dist = value;
            break;
        case #"hash_43dadd5bcbc8810a":
            self.loot_consume.escape_min_dist = value;
            break;
        case #"hash_978efb76f9c5e303":
            self function_786bb6aa1b76c7ee( "escape_play_normal_despawn_percentage", ( 100 - value ) / 100 );
            break;
    }
}

// Namespace zombie_shade_loot_consume
// Params 0, eflags: 0x4
// Checksum 0x68b77dda, Offset: 0x1955
// Size: 0x57
function private init_loot_anchor()
{
    self endon( #"death" );
    
    while ( !isdefined( self.loot_consume.anchor ) )
    {
        loot_anchor = utility::spawn_model( "tag_origin" );
        waitframe();
        self.loot_consume.anchor = loot_anchor;
    }
}

// Namespace zombie_shade_loot_consume
// Params 1, eflags: 0x4
// Checksum 0xdf47bf86, Offset: 0x19b4
// Size: 0x1c8
function private function_c4d8da13da22efe8( loot_struct )
{
    if ( !isdefined( self.loot_consume.item_rules ) )
    {
        return;
    }
    
    best_rule = undefined;
    best_match = 0;
    
    foreach ( item_rule in self.loot_consume.item_rules )
    {
        match_flags = 0;
        
        if ( isdefined( item_rule.lootrarity ) && item_rule.lootrarity != loot_struct.rarity || isdefined( item_rule.lootsubtype ) && item_rule.lootsubtype != loot_struct.subtype )
        {
            continue;
        }
        
        if ( item_rule.lootrarity == loot_struct.rarity )
        {
            match_flags |= 1;
        }
        
        if ( item_rule.lootsubtype == loot_struct.subtype )
        {
            match_flags |= 2;
        }
        
        if ( !isdefined( best_rule ) || match_flags > best_match )
        {
            best_rule = item_rule;
            best_match = match_flags;
        }
    }
    
    if ( isdefined( best_rule ) )
    {
        loot_struct.consume_fullness = best_rule.consumefullness;
        loot_struct.consume_time = best_rule.consumetime ?? 0;
        return;
    }
    
    logstring( "Loot consume tried to consume: " + loot_struct.type + " and failed to do so." );
}

// Namespace zombie_shade_loot_consume
// Params 1, eflags: 0x4
// Checksum 0x9952e41, Offset: 0x1b84
// Size: 0x6f
function private function_235d5af87d482e9f( params )
{
    function_4dfb06dcc4d8d032();
    
    if ( isdefined( self.loot_consume.anchor ) )
    {
        self.loot_consume.anchor utility::delaycallendon( 1, "death", &delete );
    }
    
    if ( !self.var_a13bed1ac47e1b2c || self.var_d26d1e568f55c0e4 )
    {
        function_70c0f08710222ed();
    }
}

// Namespace zombie_shade_loot_consume
// Params 1, eflags: 0x4
// Checksum 0x18fd3e55, Offset: 0x1bfb
// Size: 0x6f
function private function_9aa35441ce7c4080( params )
{
    function_4dfb06dcc4d8d032();
    self notify( #"hash_b4431cab512ad1e1" );
    self.loot_consume.var_8a3636a21636e0b1 = undefined;
    
    /#
        self.loot_consume.escape_countdown_start = undefined;
        self.loot_consume.escape_location = undefined;
    #/
    
    self function_f2df0257c63f229( "escape_after_consumption" );
    function_20b7d83929d84799( 1 );
}

// Namespace zombie_shade_loot_consume
// Params 1, eflags: 0x4
// Checksum 0x56dc5526, Offset: 0x1c72
// Size: 0x26f
function private function_9c81001a758da650( params )
{
    if ( self._blackboard.var_ea5eb773cb969ee1 )
    {
        return;
    }
    
    if ( self.loot_consume.fullness >= 1 && self.loot_consume.fullness <= 19 )
    {
        if ( val::get( "allow_change_zombie_eye_glow" ) )
        {
            utility::function_32b24db3127bff40( "base", "fullness_stage_one" );
        }
        
        utility::function_32b24db3127bff40( "loot_consume_stage", "stage_one" );
    }
    else if ( self.loot_consume.fullness >= 20 && self.loot_consume.fullness <= 39 )
    {
        if ( val::get( "allow_change_zombie_eye_glow" ) )
        {
            utility::function_32b24db3127bff40( "base", "fullness_stage_two" );
        }
        
        utility::function_32b24db3127bff40( "loot_consume_stage", "stage_two" );
    }
    else if ( self.loot_consume.fullness >= 40 )
    {
        if ( val::get( "allow_change_zombie_eye_glow" ) )
        {
            utility::function_32b24db3127bff40( "base", "fullness_stage_three" );
        }
        
        utility::function_32b24db3127bff40( "loot_consume_stage", "stage_three" );
    }
    
    if ( self.loot_consume.fullness >= self.loot_consume.max_fullness && !utility::ent_flag_exist( "loot_consume_max_fullness_reached" ) )
    {
        utility::ent_flag_set( "loot_consume_max_fullness_reached" );
    }
    
    if ( isdefined( self.loot_consume.favorite_loot ) && utility::ent_flag( "force_loot_consume_on_favorite_loot_start" ) )
    {
        utility::ent_flag_clear( "force_loot_consume_on_favorite_loot_start", 1 );
        utility::ent_flag_set( "force_loot_consume_on_favorite_loot_complete" );
        self.loot_consume.favorite_loot = undefined;
        
        if ( level.var_5764917dcaa613ac.completely || self.loot_consume.var_5764917dcaa613ac.completely )
        {
            self notify( #"hash_adf928d9c1f2ebce" );
        }
    }
    
    if ( self.loot_consume.fullness > 0 && !self.loot_consume.var_8a3636a21636e0b1 && !level.var_9f30d0b5ac49cedf )
    {
        self.loot_consume.var_8a3636a21636e0b1 = 1;
        thread function_6c84e72e9f1134();
    }
}

// Namespace zombie_shade_loot_consume
// Params 0, eflags: 0x4
// Checksum 0x20da0297, Offset: 0x1ee9
// Size: 0x130
function private function_6c84e72e9f1134()
{
    self endon( #"death" );
    self endon( #"hash_b4431cab512ad1e1" );
    
    /#
        self.loot_consume.escape_countdown_start = gettime();
    #/
    
    if ( self.loot_consume.escape_countdown_time > 0 )
    {
        if ( !utility::ent_flag_exist( "loot_consume_max_fullness_reached" ) )
        {
            var_cab618be4c8db326 = utility::waittill_any_timeout( self.loot_consume.escape_countdown_time, "loot_consume_max_fullness_reached" );
        }
        
        if ( var_cab618be4c8db326 == "timeout" && utility::ent_flag( "going_to_or_loot_consuming_currently" ) )
        {
            var_7fde7f67a087bda0 = 15;
            utility::ent_flag_waitopen_or_timeout( "going_to_or_loot_consuming_currently", var_7fde7f67a087bda0 );
        }
    }
    
    escape_location = calculate_escape_location();
    
    if ( isdefined( escape_location ) )
    {
        /#
            self.loot_consume.escape_location = escape_location;
        #/
        
        self function_786bb6aa1b76c7ee( "escape_after_consumption", 1 );
        
        while ( true )
        {
            self setbtgoalpos( 0, escape_location );
            
            if ( distancesquared( self.origin, escape_location ) <= 4096 )
            {
                break;
            }
            
            wait 0.2;
        }
        
        thread function_bc466cf6b6a6101f();
    }
}

// Namespace zombie_shade_loot_consume
// Params 0, eflags: 0x4
// Checksum 0xcc93b274, Offset: 0x2021
// Size: 0x78
function private function_bc466cf6b6a6101f()
{
    self endon( #"death" );
    zombie_utils::try_despawn_zombie();
    self.var_9a93aafdc3867e2b = asm::function_27be172b46a89235();
    
    if ( !callback::exists( "on_zombie_ai_damaged", &function_22ee4065bb94c490 ) )
    {
        callback::add( "on_zombie_ai_damaged", &function_22ee4065bb94c490 );
        val::set( "loot_consume_escaping", "disallow_knockdown", 1 );
    }
    
    thread function_b8857bf3f7b22b77();
    thread function_99de151c59c8d8fc();
    thread function_c6259025bb7f9e1b();
    thread function_1fa418fe9e34ab73();
}

// Namespace zombie_shade_loot_consume
// Params 1, eflags: 0x4
// Checksum 0x7ca2eb5f, Offset: 0x20a1
// Size: 0xc0
function private function_22ee4065bb94c490( params )
{
    if ( !isdefined( self.var_451d1e2f8d74587f ) )
    {
        self.var_451d1e2f8d74587f = spawnstruct();
    }
    
    self.var_451d1e2f8d74587f.attacker = params.eattacker;
    self.var_451d1e2f8d74587f.inflictor = params.einflictor;
    self.var_451d1e2f8d74587f.meansofdeath = params.smeansofdeath;
    self.var_451d1e2f8d74587f.objweapon = params.objweapon;
    
    if ( !self.var_644aab63d61b8a84 )
    {
        self.var_644aab63d61b8a84 = 1;
        thread function_e84eff9e0cc8f1c3();
    }
}

// Namespace zombie_shade_loot_consume
// Params 0, eflags: 0x4
// Checksum 0x92ee0737, Offset: 0x2169
// Size: 0xa4
function private function_e84eff9e0cc8f1c3()
{
    self endon( #"death" );
    self.var_9a93aafdc3867e2b = asm::function_27be172b46a89235();
    
    while ( true )
    {
        if ( self.var_9a93aafdc3867e2b != asm::function_27be172b46a89235() && !val::get( "damageshield" ) )
        {
            self kill( self.origin, self.var_451d1e2f8d74587f.attacker, self.var_451d1e2f8d74587f.inflictor, self.var_451d1e2f8d74587f.meansofdeath, self.var_451d1e2f8d74587f.objweapon );
        }
        
        waitframe();
    }
}

// Namespace zombie_shade_loot_consume
// Params 0, eflags: 0x4
// Checksum 0x6ad5e980, Offset: 0x2215
// Size: 0x205
function private function_b8857bf3f7b22b77()
{
    self endon( #"death" );
    self endon( #"hash_3c02553158e385bb" );
    self waittill( #"spawn_escape_portal" );
    utility::function_32b24db3127bff40( "base", "base_off" );
    utility::function_32b24db3127bff40( "loot_consume_stage", "off" );
    utility::function_32b24db3127bff40( "eyes", "off" );
    utility::function_32b24db3127bff40( "fog", "off" );
    thread function_c07965d9fcab150f();
    var_ebf2aa633b366069 = 40;
    
    if ( asm::asm_getcurrentstatename( self.asmname ) == "despawn" )
    {
        var_4337f12e6a292e07 = rotatepointaroundvector( anglestoup( self.angles ), anglestoforward( self.angles ) * var_ebf2aa633b366069, 18 );
        selfcentroid = self getcentroid();
        var_270f1deef15e8c18 = selfcentroid + var_4337f12e6a292e07;
    }
    else if ( asm::asm_getcurrentstatename( self.asmname ) == "special_despawn" )
    {
        var_4337f12e6a292e07 = rotatepointaroundvector( anglestoup( self.angles ), anglestoforward( self.angles ) * var_ebf2aa633b366069, -8 );
        selfcentroid = self getcentroid();
        var_270f1deef15e8c18 = selfcentroid + var_4337f12e6a292e07;
    }
    
    params = spawnstruct();
    var_68439d8c844908ed = utility::drop_to_ground( var_270f1deef15e8c18, 80, -1000, undefined, undefined, self, 1 );
    
    if ( isdefined( var_68439d8c844908ed ) )
    {
        params.portalspawnpoint = var_68439d8c844908ed[ 0 ];
        callback::callback( "escape_portal_spawned", params );
        var_5e68816568b9748c = self.origin - var_68439d8c844908ed[ 0 ];
        var_fb33adcf22faeb49 = vectorcross( var_5e68816568b9748c, var_68439d8c844908ed[ 1 ] );
        portalangles = axistoangles( var_5e68816568b9748c, var_fb33adcf22faeb49, var_68439d8c844908ed[ 1 ] );
        var_1bb9e8d8e3bf94fa = spawnscriptable( "scriptable_zombie_shade_escape_portal", var_68439d8c844908ed[ 0 ], portalangles );
        
        if ( isdefined( var_1bb9e8d8e3bf94fa ) )
        {
            var_1bb9e8d8e3bf94fa thread function_d7c118ba50f5f329();
        }
        
        return;
    }
    
    params.portalspawnpoint = var_270f1deef15e8c18;
    callback::callback( "escape_portal_spawned", params );
}

// Namespace zombie_shade_loot_consume
// Params 0, eflags: 0x4
// Checksum 0x5701c1bc, Offset: 0x2422
// Size: 0x3c
function private function_d7c118ba50f5f329()
{
    var_3e0cacf0dcb2e24e = 5;
    self setscriptablepartstate( "portal", "portal" );
    wait var_3e0cacf0dcb2e24e;
    self setscriptablepartstate( "portal", "off" );
    self freescriptable();
}

// Namespace zombie_shade_loot_consume
// Params 0, eflags: 0x4
// Checksum 0x289e18fe, Offset: 0x2466
// Size: 0xad
function private function_c07965d9fcab150f()
{
    self endon( #"death" );
    self endon( #"hash_3c02553158e385bb" );
    self waittill( #"escape_hide_healthbar" );
    val::set_array( "loot_consume_escaping", [ "show_healthbar", "disallow_stun" ], 0 );
    statename = self asmgetcurrentstate( self.asmname );
    
    if ( statename == "despawn" )
    {
        utility::function_32b24db3127bff40( "loot_consume_escape_dissolve", "normal_despawn_dissolve" );
    }
    else
    {
        utility::function_32b24db3127bff40( "loot_consume_escape_dissolve", "special_despawn_dissolve" );
        utility::function_32b24db3127bff40( "loot_consume_escape_special", "off" );
    }
    
    self.var_a13bed1ac47e1b2c = 1;
}

// Namespace zombie_shade_loot_consume
// Params 0, eflags: 0x4
// Checksum 0xdb937188, Offset: 0x251b
// Size: 0x38
function private function_99de151c59c8d8fc()
{
    self endon( #"death" );
    self endon( #"hash_3c02553158e385bb" );
    self waittill( #"escape_attach_cymbals" );
    utility::function_32b24db3127bff40( "loot_consume_escape_special", "cymbals" );
}

// Namespace zombie_shade_loot_consume
// Params 0, eflags: 0x4
// Checksum 0x4066aa7c, Offset: 0x255b
// Size: 0x6b
function private function_c6259025bb7f9e1b()
{
    self endon( #"death" );
    self endon( #"escape_hide_healthbar" );
    
    while ( true )
    {
        if ( zombie_stun::is_stunned() )
        {
            self notify( #"hash_3c02553158e385bb" );
            
            while ( true )
            {
                if ( !zombie_stun::is_stunned() )
                {
                    self._blackboard.var_903cd88c07cfc16b = 0;
                    thread function_bc466cf6b6a6101f();
                    return;
                }
                
                waitframe();
            }
            
            break;
        }
        
        waitframe();
    }
}

// Namespace zombie_shade_loot_consume
// Params 0, eflags: 0x4
// Checksum 0xee63a659, Offset: 0x25ce
// Size: 0x5d
function private function_1fa418fe9e34ab73()
{
    self endon( #"death" );
    self endon( #"hash_3c02553158e385bb" );
    self waittill( #"despawn_complete" );
    
    if ( val::get( "damageshield" ) )
    {
        val::set( "loot_consume_despawn", "damageshield_allow_delete", 1 );
    }
    
    asm::asm_fireevent( self.asmname, "despawn_complete" );
}

// Namespace zombie_shade_loot_consume
// Params 0, eflags: 0x4
// Checksum 0xc0b96080, Offset: 0x2633
// Size: 0x2ce
function private function_70c0f08710222ed()
{
    var_a301e88487b5ae27 = self.loot_consume.var_a301e88487b5ae27;
    
    if ( var_a301e88487b5ae27.size > 0 )
    {
        var_569d77b7b3eaf146 = 80;
        var_c907ff9af97d0daf = 1;
        var_5dff249792fe9564 = 0.1;
        var_2b30de004cb0239e = undefined;
        var_b02043b48bed3a3f = getaiarrayinradius( self.origin, self.loot_consume.var_67f9e5a5f6aed92, self.team );
        
        foreach ( nearbyai in var_b02043b48bed3a3f )
        {
            var_bd44167bd5c1fcc4 = nearbyai.loot_consume.fullness < nearbyai.loot_consume.max_fullness;
            
            if ( var_bd44167bd5c1fcc4 )
            {
                var_2424a18151d3c35 = "shade_dropped_rewards_exclusion_zone_" + self getentitynumber();
                nearbyai function_6fcd6de63ff02786( var_2424a18151d3c35, self.origin, var_569d77b7b3eaf146 );
                nearbyai thread function_2dd60ff8d16a777f( var_2424a18151d3c35 );
            }
        }
        
        for ( i = var_a301e88487b5ae27.size - 1; i >= 0 ; i-- )
        {
            if ( var_a301e88487b5ae27[ i ].fullnessthreshold >= var_2b30de004cb0239e )
            {
                assert( "<dev string:xb3>" + ( self.var_d6894f01a36b4ff3.var_394d3c5e6fa40c50 ?? "<dev string:xa0>" ) );
                break;
            }
            
            if ( self.loot_consume.fullness >= var_a301e88487b5ae27[ i ].fullnessthreshold )
            {
                if ( var_a301e88487b5ae27[ i ].itemdropcount > 0 && isdefined( var_a301e88487b5ae27[ i ].itemdroplist ) )
                {
                    spawn_options = level utility::callsharedfunc( #"game", #"initSpawnOptions_SpawnFromPosition", self.origin, self.angles );
                    spawn_options.var_50e31f8c119ef961 = 1;
                    level utility::callsharedfunc( #"game", #"hash_a7fdfd9b3e54da61", var_5dff249792fe9564, var_a301e88487b5ae27[ i ].itemdropcount, var_a301e88487b5ae27[ i ].itemdroplist, spawn_options );
                    var_cb0f5ba4eca08886 = var_a301e88487b5ae27[ i ].itemdropcount * var_5dff249792fe9564 + var_c907ff9af97d0daf;
                    level thread function_bd77b332286bf19d();
                    level thread function_f124664d395ad0b1( var_cb0f5ba4eca08886 );
                }
                
                return;
            }
            
            var_2b30de004cb0239e = var_a301e88487b5ae27[ i ].fullnessthreshold;
        }
    }
}

// Namespace zombie_shade_loot_consume
// Params 1, eflags: 0x4
// Checksum 0x3aeecab5, Offset: 0x2909
// Size: 0x33
function private function_2dd60ff8d16a777f( var_2424a18151d3c35 )
{
    self endon( #"death" );
    level utility::waittill_any( "shade_loot_consume_delayed_drop_rewards_complete", "shade_loot_consume_delayed_drop_rewards_timeout" );
    function_9c9941b36dcb13e0( var_2424a18151d3c35 );
}

// Namespace zombie_shade_loot_consume
// Params 0, eflags: 0x4
// Checksum 0x6319c455, Offset: 0x2944
// Size: 0xa8
function private function_bd77b332286bf19d()
{
    level endon( #"shade_loot_consume_delayed_drop_rewards_timeout" );
    level waittill( #"hash_19c9a695e7ebc5cc", var_7b7356588f3234fa );
    
    foreach ( spawneditem in var_7b7356588f3234fa )
    {
        spawneditem.var_2de515a319394610 = 1;
    }
    
    level notify( #"shade_loot_consume_delayed_drop_rewards_complete" );
}

// Namespace zombie_shade_loot_consume
// Params 1, eflags: 0x4
// Checksum 0x7508d9c0, Offset: 0x29f4
// Size: 0x27
function private function_f124664d395ad0b1( var_cb0f5ba4eca08886 )
{
    level endon( #"shade_loot_consume_delayed_drop_rewards_complete" );
    wait var_cb0f5ba4eca08886;
    level notify( #"shade_loot_consume_delayed_drop_rewards_timeout" );
}

// Namespace zombie_shade_loot_consume
// Params 0, eflags: 0x4
// Checksum 0x4fd9a650, Offset: 0x2a23
// Size: 0x267
function private calculate_escape_location()
{
    while ( true )
    {
        sample_locations = ai::function_7bcb54b16c07d1ec( 8, self.origin, 0, self.loot_consume.escape_max_dist, self.loot_consume.escape_min_dist );
        
        if ( sample_locations.size > 0 )
        {
            escape_vectors = [];
            
            if ( isdefined( self.enemy ) )
            {
                agent_enemy = self.enemy;
            }
            
            escape_origin = isdefined( agent_enemy ) ? agent_enemy.origin : self.origin;
            
            foreach ( location in sample_locations )
            {
                escape_vectors[ escape_vectors.size ] = location - escape_origin;
            }
            
            escape_vectors = arraysort( escape_vectors, undefined, undefined, isdefined( agent_enemy ) );
            
            for ( i = 0; i < escape_vectors.size ; i++ )
            {
                throttle::throttle_wait_in_queue( level.var_2b9fc8aec2cf8250, self );
                escape_location = escape_origin + escape_vectors[ i ];
                reachable_point = self getclosestreachablepointonnavmesh( escape_location, 0 );
                
                if ( isdefined( reachable_point ) && distancesquared( reachable_point, escape_location ) <= 256 )
                {
                    reachable_point = utility::drop_to_ground( reachable_point, 80, -1000, undefined, undefined );
                    var_693d7a1b7f64ced3 = 80;
                    trace = physics_getclosestpointtocharacter( reachable_point, self, 0, self.angles, var_693d7a1b7f64ced3, trace::create_default_contents( 1 ), self, "physicsquery_all" );
                    var_940f5290250cc042 = 1;
                    
                    foreach ( trace_result in trace )
                    {
                        if ( trace_result[ "distance" ] > 0 )
                        {
                            var_940f5290250cc042 = 0;
                            break;
                        }
                    }
                    
                    if ( var_940f5290250cc042 )
                    {
                        return reachable_point;
                    }
                }
            }
            
            continue;
        }
        
        waitframe();
    }
}

// Namespace zombie_shade_loot_consume
// Params 0, eflags: 0xc
// Checksum 0xdece1fda, Offset: 0x2c92
// Size: 0x62
function private function_a3dc88f4dc60e1f8()
{
    self notify( #"hash_e869b723db1c20c5" );
    self endon( #"hash_e869b723db1c20c5" );
    self endon( #"death" );
    self endon( #"loot_target_cleared" );
    self.loot_consume.target_data.loot waittill( #"death" );
    thread function_4dfb06dcc4d8d032();
}

// Namespace zombie_shade_loot_consume
// Params 0, eflags: 0x4
// Checksum 0xa54f59e1, Offset: 0x2cfc
// Size: 0x84
function private function_432d4a73bf9e15f5()
{
    self endon( #"death" );
    self endon( #"loot_target_cleared" );
    self endon( #"consume_loot_end" );
    self endon( #"attach_loot_item" );
    loot_target = self.loot_consume.target_data.loot;
    
    while ( isdefined( loot_target ) )
    {
        if ( isdefined( loot_target.linkedparent ) )
        {
            function_a4cd379454f69dee();
            waitframe();
            continue;
        }
        
        wait 0.5;
    }
}

// Namespace zombie_shade_loot_consume
// Params 1, eflags: 0x4
// Checksum 0x57747572, Offset: 0x2d88
// Size: 0x8f
function private function_205c12d88f5303a3( target_data )
{
    assert( !isdefined( self.loot_consume.target_data ) );
    target_data.loot.var_ee6ebfea66bb219e = self;
    self.loot_consume.target_data = target_data;
    self._blackboard.var_caf0150a850955bd = target_data.loot.origin;
    function_b28479ffb94894e4( 1 );
    thread function_a3dc88f4dc60e1f8();
}

// Namespace zombie_shade_loot_consume
// Params 0, eflags: 0x4
// Checksum 0xa492740, Offset: 0x2e1f
// Size: 0xa1
function private function_a4cd379454f69dee()
{
    loot_target = self.loot_consume.target_data.loot;
    
    if ( isdefined( loot_target ) && loot_target.var_ee6ebfea66bb219e == self )
    {
        nav_loc = function_c59ed25bf6a98518( loot_target );
        
        if ( isdefined( nav_loc ) )
        {
            self.loot_consume.target_data.nav_loc = nav_loc;
            self._blackboard.var_caf0150a850955bd = loot_target.origin;
            return;
        }
    }
    
    function_4dfb06dcc4d8d032();
}

// Namespace zombie_shade_loot_consume
// Params 1, eflags: 0x4
// Checksum 0xcc3a8f49, Offset: 0x2ec8
// Size: 0x1f6
function private function_c59ed25bf6a98518( loot )
{
    if ( !loot || !loot.origin )
    {
        return;
    }
    
    reachable_point = function_9ad7279ee518d022( loot.origin, self );
    
    if ( !reachable_point )
    {
        return;
    }
    
    nearbyvehicles = getentitiesinradiusfrompartitiongrid( self.origin, self.loot_consume.var_67f9e5a5f6aed92, createentitytypemask( [ "etype_vehicle" ] ), undefined );
    
    if ( nearbyvehicles.size > 0 )
    {
        var_3623011ce61832ba = 0.95;
        var_2454d7823a11e912 = 1.5;
        
        foreach ( nearbyvehicle in nearbyvehicles )
        {
            if ( nearbyvehicle && nearbyvehicle.origin && nearbyvehicle.angles )
            {
                var_6c6164b85d880bbb = nearbyvehicle getboundshalfsize();
                var_3e9a4c4de7d2cc40 = var_6c6164b85d880bbb[ 0 ] * var_3623011ce61832ba;
                var_3e9a4d4de7d2ce73 = var_6c6164b85d880bbb[ 1 ] * var_2454d7823a11e912;
                var_3e9a4e4de7d2d0a6 = var_6c6164b85d880bbb[ 2 ] * var_2454d7823a11e912;
                var_7f05799d472f4845 = ( var_3e9a4c4de7d2cc40, var_3e9a4d4de7d2ce73, var_3e9a4e4de7d2d0a6 );
                var_819f9e1c4127d91e = function_98ac53340703457d( self.origin, reachable_point, nearbyvehicle.origin, nearbyvehicle.angles, nearbyvehicle getboundsmidpoint(), var_7f05799d472f4845 );
                
                if ( var_819f9e1c4127d91e )
                {
                    return;
                }
            }
        }
    }
    
    if ( distance2dsquared( loot.origin, reachable_point ) <= 256 && abs( loot.origin[ 2 ] - reachable_point[ 2 ] ) <= 30 )
    {
        return reachable_point;
    }
}

// Namespace zombie_shade_loot_consume
// Params 1, eflags: 0x4
// Checksum 0xce90a819, Offset: 0x30c7
// Size: 0x18f, Type: bool
function private function_2ac060959800f785( current_loot )
{
    if ( isdefined( self.loot_consume ) && isdefined( self.loot_consume.var_5e6aa2a6ac3be739 ) )
    {
        nearby_loot = getlootscriptablearrayinradius( undefined, undefined, current_loot.origin, self.loot_consume.var_5e6aa2a6ac3be739 );
        
        foreach ( loot in nearby_loot )
        {
            if ( loot != current_loot && loot.var_ee6ebfea66bb219e )
            {
                return true;
            }
        }
        
        var_aa99aa4e004e6a0a = getentitylessscriptablearray( undefined, undefined, current_loot.origin, self.loot_consume.var_5e6aa2a6ac3be739 );
        
        foreach ( zm_loot in var_aa99aa4e004e6a0a )
        {
            if ( zm_loot != current_loot && zm_loot.var_ee6ebfea66bb219e )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace zombie_shade_loot_consume
// Params 0, eflags: 0x4
// Checksum 0xa41d102d, Offset: 0x325f
// Size: 0x2cd
function private function_ac088600a648f5ad()
{
    self endon( #"death" );
    self endon( #"hash_adf928d9c1f2ebce" );
    
    while ( self.loot_consume.fullness < self.loot_consume.max_fullness )
    {
        if ( self getaiblackboarddynamic( "escape_after_consumption" ) )
        {
            break;
        }
        
        self waittill( #"consume_loot_start" );
        function_a4cd379454f69dee();
        
        if ( isdefined( self.loot_consume.target_data ) )
        {
            function_b28479ffb94894e4( 1 );
        }
        else if ( isdefined( self.loot_consume.favorite_loot ) )
        {
            function_205c12d88f5303a3( self.loot_consume.loot_cache[ 0 ] );
            utility::ent_flag_set( "force_loot_consume_on_favorite_loot_start" );
        }
        else if ( self.loot_consume.loot_cache.size > 0 )
        {
            best_loot = undefined;
            var_bfd488d68d6ff0f9 = 0;
            
            foreach ( var_57fdcc855c1a3725 in self.loot_consume.loot_cache )
            {
                if ( !isdefined( var_57fdcc855c1a3725.loot ) )
                {
                    continue;
                }
                
                if ( !isdefined( var_57fdcc855c1a3725.loot.var_ee6ebfea66bb219e ) && var_57fdcc855c1a3725.score > var_bfd488d68d6ff0f9 )
                {
                    best_loot = var_57fdcc855c1a3725;
                    var_bfd488d68d6ff0f9 = var_57fdcc855c1a3725.score;
                }
            }
            
            if ( isdefined( best_loot ) )
            {
                function_205c12d88f5303a3( best_loot );
            }
        }
        
        self._blackboard.var_d9ef8cb5302fd1b1 = 0;
        
        if ( isdefined( self.loot_consume.target_data ) )
        {
            thread function_432d4a73bf9e15f5();
        }
        
        if ( !isdefined( self.var_943ad14007148d84 ) || self.var_943ad14007148d84 == 0 )
        {
            if ( !utility::ent_flag_exist( "going_to_or_loot_consuming_currently" ) )
            {
                utility::ent_flag_set( "going_to_or_loot_consuming_currently" );
            }
            
            self.var_943ad14007148d84 = 1;
        }
        else
        {
            self.var_943ad14007148d84++;
        }
        
        self waittill( #"consume_loot_end" );
        utility::delaythreadendon( 3, [ "death", "loot_target_cleared", "consume_loot_start" ], &function_4dfb06dcc4d8d032 );
    }
    
    if ( isdefined( self.loot_consume.anchor ) )
    {
        self.loot_consume.anchor utility::delaycallendon( 1, "death", &delete );
    }
}

// Namespace zombie_shade_loot_consume
// Params 0, eflags: 0x4
// Checksum 0xbe866005, Offset: 0x3534
// Size: 0x9f2
function private function_53eb747fa0c2f11e()
{
    self endon( #"death" );
    self endon( #"hash_adf928d9c1f2ebce" );
    wait 1;
    
    if ( !isdefined( level.loot_consume_scan_for_loot_throttle ) )
    {
        level.loot_consume_scan_for_loot_throttle = throttle::throttle_initialize( "loot_consume_scan_for_loot_throttle", 1, 0.5 );
    }
    
    while ( self.loot_consume.fullness < self.loot_consume.max_fullness )
    {
        if ( self getaiblackboarddynamic( "escape_after_consumption" ) || self._blackboard.var_ea5eb773cb969ee1 || vortex::is_pulled() || zombie_bloat::function_515d0ff3aa6cc5d2() )
        {
            break;
        }
        
        if ( zombie_vehicle_attack::is_in_vehicle_attack() || zombie_knockdown::function_19d6107cb6bdff5c() || zombie_cannonball::function_aa1319badace3306() || zombie_stun::is_stunned() || self._blackboard.var_ee63c958d4e84c96 )
        {
            utility::waittill_any_in_array( [ "vehicle_attack_end", "knockdown_end", "cannonball_end", "consume_loot_end", "zombie_stun_end" ] );
            continue;
        }
        
        if ( isdefined( self.loot_consume.favorite_loot ) )
        {
            utility::ent_flag_wait( "force_loot_consume_on_favorite_loot_complete" );
            utility::ent_flag_clear( "force_loot_consume_on_favorite_loot_complete", 1 );
            continue;
        }
        
        nearby_loot = getlootscriptablearrayinradius( undefined, undefined, self.origin, self.loot_consume.var_67f9e5a5f6aed92 );
        var_aa99aa4e004e6a0a = getentitylessscriptablearray( undefined, undefined, self.origin, self.loot_consume.var_67f9e5a5f6aed92 );
        var_2d6c7713a01b907c = 1 / squared( self.loot_consume.var_67f9e5a5f6aed92 );
        var_d50d5cbd27eed81e = var_2d6c7713a01b907c * 100;
        
        /#
            if ( getdvarint( @"hash_1ecba8c2522dfcd2" ) )
            {
                var_d4618b70ea2e3eee = int( 0.5 / level.framedurationseconds );
                sphere( self.origin, self.loot_consume.var_67f9e5a5f6aed92, ( 1, 1, 0 ), 1, var_d4618b70ea2e3eee );
                var_1d6118b10851f39 = 0;
            }
        #/
        
        loot_cache = [];
        
        foreach ( zm_loot in var_aa99aa4e004e6a0a )
        {
            if ( !isdefined( zm_loot.type ) )
            {
                continue;
            }
            
            if ( function_2ac060959800f785( zm_loot ) )
            {
                continue;
            }
            
            if ( isdefined( zm_loot.var_6828becb300b1c44 ) )
            {
                var_57fdcc855c1a3725 = { #type:zm_loot.var_6828becb300b1c44.baseweapon, #rarity:zm_loot.var_6828becb300b1c44.rarity ?? 0 };
                
                if ( isdefined( zm_loot.weaponobj ) && weapon::iswonderweapon( zm_loot.weaponobj ) )
                {
                    var_57fdcc855c1a3725.subtype = "ww";
                }
            }
            else if ( isdefined( zm_loot.type ) && issubstr( zm_loot.type, "zmloot" ) && ( issubstr( zm_loot.type, "killstreak" ) || issubstr( zm_loot.type, "perk" ) || issubstr( zm_loot.type, "armor_vest" ) || issubstr( zm_loot.type, "aether_crystal" ) || issubstr( zm_loot.type, "aether_tool" ) || issubstr( zm_loot.type, "ammomod" ) ) )
            {
                bundle_cache = level.var_3e82f98749e6c569[ zm_loot.type ];
                
                if ( !isdefined( bundle_cache ) )
                {
                    bundle_cache = { #rarity:zm_loot get_zmloot_rarity( zm_loot.type ) };
                    function_c4d8da13da22efe8( bundle_cache );
                    level.var_3e82f98749e6c569[ zm_loot.type ] = bundle_cache;
                }
                
                var_57fdcc855c1a3725 = { #consume_time:bundle_cache.consume_time, #consume_fullness:bundle_cache.consume_fullness, #rarity:bundle_cache.rarity };
            }
            else
            {
                continue;
            }
            
            var_57fdcc855c1a3725.loot = zm_loot;
            
            if ( should_skip_loot( var_57fdcc855c1a3725 ) )
            {
                continue;
            }
            
            var_57fdcc855c1a3725.score = 0;
            function_c4d8da13da22efe8( var_57fdcc855c1a3725 );
            
            if ( !zm_loot.var_7a65426f252841e7 && var_57fdcc855c1a3725.consume_fullness >= 0 )
            {
                nav_loc = function_c59ed25bf6a98518( zm_loot );
                
                if ( isdefined( nav_loc ) )
                {
                    var_57fdcc855c1a3725.nav_loc = nav_loc;
                    fullness_rate = max( var_57fdcc855c1a3725.consume_fullness, 0.01 ) / max( var_57fdcc855c1a3725.consume_time, 1 );
                    var_5a954f203991cd88 = distancesquared( nav_loc, self.origin );
                    
                    if ( var_5a954f203991cd88 == 0 )
                    {
                        continue;
                    }
                    
                    distance_penalty = mapfloat( var_2d6c7713a01b907c, var_d50d5cbd27eed81e, 0.01, 1, 1 / var_5a954f203991cd88 );
                    var_57fdcc855c1a3725.score = fullness_rate * distance_penalty;
                    loot_cache[ loot_cache.size ] = var_57fdcc855c1a3725;
                }
            }
            
            /#
                function_24d5926ef624f5fa( var_57fdcc855c1a3725, var_1d6118b10851f39, var_d4618b70ea2e3eee );
            #/
        }
        
        foreach ( loot in nearby_loot )
        {
            if ( !isdefined( loot.type ) )
            {
                continue;
            }
            
            if ( function_2ac060959800f785( loot ) )
            {
                continue;
            }
            
            if ( isdefined( loot.var_6828becb300b1c44 ) )
            {
                var_57fdcc855c1a3725 = { #type:loot.var_6828becb300b1c44.baseweapon, #rarity:loot.var_6828becb300b1c44.rarity ?? 0 };
                
                if ( isdefined( loot.weaponobj ) && weapon::iswonderweapon( loot.weaponobj ) )
                {
                    var_57fdcc855c1a3725.subtype = "ww";
                }
                
                function_c4d8da13da22efe8( var_57fdcc855c1a3725 );
            }
            else
            {
                bundle_cache = level.var_3e82f98749e6c569[ loot.type ];
                
                if ( !isdefined( bundle_cache ) )
                {
                    loot_bundle = level utility::callsharedfunc( #"game", #"hash_4aa5275ed9e408f4", loot.type );
                    
                    if ( !isdefined( loot_bundle ) )
                    {
                        continue;
                    }
                    
                    bundle_cache = { #subtype:loot_bundle.subtype, #rarity:loot_bundle.rarity ?? 0 };
                    function_c4d8da13da22efe8( bundle_cache );
                    level.var_3e82f98749e6c569[ loot.type ] = bundle_cache;
                }
                
                var_57fdcc855c1a3725 = { #consume_time:bundle_cache.consume_time, #consume_fullness:bundle_cache.consume_fullness, #subtype:bundle_cache.subtype, #rarity:bundle_cache.rarity };
            }
            
            var_57fdcc855c1a3725.loot = loot;
            
            if ( should_skip_loot( var_57fdcc855c1a3725 ) )
            {
                continue;
            }
            
            var_57fdcc855c1a3725.score = 0;
            
            /#
                var_1056b101d8460b51 = isdefined( loot.owningplayer ) ? "<dev string:x9d>" + loot.owningplayer getentitynumber() : "<dev string:xa0>";
                var_57fdcc855c1a3725.name = "<dev string:xa1>" + var_57fdcc855c1a3725.loot.index + ( loot.var_7a65426f252841e7 ? "<dev string:xa5>" + var_1056b101d8460b51 + "<dev string:xae>" : "<dev string:xa0>" ) + "<dev string:xb0>" + ( isdefined( loot.var_6828becb300b1c44 ) ? loot.var_6828becb300b1c44.baseweapon : loot.type );
            #/
            
            if ( !loot.var_7a65426f252841e7 && var_57fdcc855c1a3725.consume_fullness >= 0 )
            {
                nav_loc = function_c59ed25bf6a98518( loot );
                
                if ( isdefined( nav_loc ) )
                {
                    var_57fdcc855c1a3725.nav_loc = nav_loc;
                    fullness_rate = max( var_57fdcc855c1a3725.consume_fullness, 0.01 ) / max( var_57fdcc855c1a3725.consume_time, 1 );
                    var_5a954f203991cd88 = distancesquared( nav_loc, self.origin );
                    
                    if ( var_5a954f203991cd88 == 0 )
                    {
                        continue;
                    }
                    
                    distance_penalty = mapfloat( var_2d6c7713a01b907c, var_d50d5cbd27eed81e, 0.01, 1, 1 / var_5a954f203991cd88 );
                    var_57fdcc855c1a3725.score = fullness_rate * distance_penalty;
                    loot_cache[ loot_cache.size ] = var_57fdcc855c1a3725;
                }
            }
            
            /#
                function_24d5926ef624f5fa( var_57fdcc855c1a3725, var_1d6118b10851f39, var_d4618b70ea2e3eee );
            #/
        }
        
        self.loot_consume.loot_cache = loot_cache;
        self function_786bb6aa1b76c7ee( "has_loot_nearby", loot_cache.size > 0 );
        throttle::throttle_wait_in_queue( level.loot_consume_scan_for_loot_throttle, self );
    }
    
    self.loot_consume.loot_cache = [];
    self function_786bb6aa1b76c7ee( "has_loot_nearby", 0 );
}

// Namespace zombie_shade_loot_consume
// Params 1, eflags: 0x4
// Checksum 0xce48ee79, Offset: 0x3f2e
// Size: 0x5bc, Type: bool
function private should_skip_loot( var_57fdcc855c1a3725 )
{
    if ( var_57fdcc855c1a3725.loot.var_2de515a319394610 )
    {
        return true;
    }
    
    if ( var_57fdcc855c1a3725.loot.var_86918c8abfcc1332 )
    {
        return true;
    }
    
    if ( function_1da40d3c211112b9( var_57fdcc855c1a3725.loot ) )
    {
        return true;
    }
    
    if ( isdefined( level.var_5764917dcaa613ac.category ) || isdefined( self.loot_consume.var_5764917dcaa613ac.category ) )
    {
        var_dddac8b3dba8766b = [];
        var_dddac8b3dba8766b = arraycombineunique( level.var_5764917dcaa613ac.category, self.loot_consume.var_5764917dcaa613ac.category );
        
        foreach ( exclusioncategory in var_dddac8b3dba8766b )
        {
            if ( exclusioncategory == "weapon" && isdefined( var_57fdcc855c1a3725.loot.var_6828becb300b1c44 ) )
            {
                return true;
            }
            
            if ( isdefined( var_57fdcc855c1a3725.loot.type ) && issubstr( var_57fdcc855c1a3725.loot.type, "zmloot" ) )
            {
                switch ( exclusioncategory )
                {
                    case #"hash_1cac65e1b8bf24a7":
                        if ( issubstr( var_57fdcc855c1a3725.loot.type, "killstreak" ) )
                        {
                            return true;
                        }
                    case #"hash_ab671284a3fc4e3d":
                        if ( issubstr( var_57fdcc855c1a3725.loot.type, "perk" ) )
                        {
                            return true;
                        }
                    case #"hash_fb23dc93e1203c67":
                        if ( issubstr( var_57fdcc855c1a3725.loot.type, "armor_vest" ) )
                        {
                            return true;
                        }
                    case #"hash_adc62d5f9e33418d":
                        if ( issubstr( var_57fdcc855c1a3725.loot.type, "aether_crystal" ) )
                        {
                            return true;
                        }
                    case #"hash_3488d0fc5a0e9293":
                        if ( issubstr( var_57fdcc855c1a3725.loot.type, "aether_tool" ) )
                        {
                            return true;
                        }
                    case #"hash_657e2b6e3f6d663d":
                        if ( issubstr( var_57fdcc855c1a3725.loot.type, "ammomod" ) )
                        {
                            return true;
                        }
                        
                        break;
                }
            }
        }
    }
    
    if ( isdefined( level.var_5764917dcaa613ac.rarity ) || isdefined( self.loot_consume.var_5764917dcaa613ac.rarity ) )
    {
        var_233282535f71bc56 = [];
        var_233282535f71bc56 = arraycombineunique( level.var_5764917dcaa613ac.rarity, self.loot_consume.var_5764917dcaa613ac.rarity );
        
        foreach ( exclusionrarity in var_233282535f71bc56 )
        {
            if ( exclusionrarity == var_57fdcc855c1a3725.rarity )
            {
                return true;
            }
        }
    }
    
    if ( ( isdefined( level.var_5764917dcaa613ac.subtype ) || isdefined( self.loot_consume.var_5764917dcaa613ac.subtype ) ) && isdefined( var_57fdcc855c1a3725.subtype ) )
    {
        var_181ae8321c0b6155 = [];
        var_181ae8321c0b6155 = arraycombineunique( level.var_5764917dcaa613ac.subtype, self.loot_consume.var_5764917dcaa613ac.subtype );
        
        foreach ( exclusionsubtype in var_181ae8321c0b6155 )
        {
            if ( exclusionsubtype == var_57fdcc855c1a3725.subtype )
            {
                return true;
            }
        }
    }
    
    if ( isdefined( level.var_5764917dcaa613ac.scriptable ) || isdefined( self.loot_consume.var_5764917dcaa613ac.scriptable ) )
    {
        var_8e270b894c9600d2 = [];
        var_8e270b894c9600d2 = arraycombineunique( level.var_5764917dcaa613ac.scriptable, self.loot_consume.var_5764917dcaa613ac.scriptable );
        
        foreach ( exclusionscriptable in var_8e270b894c9600d2 )
        {
            if ( exclusionscriptable == var_57fdcc855c1a3725.loot )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace zombie_shade_loot_consume
// Params 1, eflags: 0x4
// Checksum 0xe74f04ef, Offset: 0x44f3
// Size: 0x68
function private get_zmloot_rarity( killstreaktype )
{
    if ( self getscriptablehaspart( killstreaktype ) )
    {
        if ( self getscriptableparthasstate( killstreaktype, "dropped_pfxtrail_uncommon" ) )
        {
            return 1;
        }
        else if ( self getscriptableparthasstate( killstreaktype, "dropped_pfxtrail_rare" ) )
        {
            return 2;
        }
        else if ( self getscriptableparthasstate( killstreaktype, "dropped_pfxtrail_epic" ) )
        {
            return 3;
        }
        else if ( self getscriptableparthasstate( killstreaktype, "dropped_pfxtrail_legendary" ) )
        {
            return 4;
        }
    }
    
    return 0;
}

/#

    // Namespace zombie_shade_loot_consume
    // Params 3, eflags: 0x4
    // Checksum 0x17bd51eb, Offset: 0x4564
    // Size: 0x1a5, Type: dev
    function private function_24d5926ef624f5fa( var_57fdcc855c1a3725, var_1d6118b10851f39, var_d4618b70ea2e3eee )
    {
        if ( getdvarint( @"hash_1ecba8c2522dfcd2" ) )
        {
            if ( var_57fdcc855c1a3725.score == 0 )
            {
                debug_color = ( 1, 0, 0 );
            }
            else if ( var_57fdcc855c1a3725.subtype == "<dev string:x11f>" )
            {
                debug_color = ( 1, 1, 0 );
            }
            else
            {
                switch ( var_57fdcc855c1a3725.rarity )
                {
                    case 0:
                        debug_color = ( 1, 1, 1 );
                        break;
                    case 1:
                        debug_color = ( 0, 0.75, 0 );
                        break;
                    case 2:
                        debug_color = ( 0.5, 0.5, 1 );
                        break;
                    case 3:
                        debug_color = ( 0.5, 0, 1 );
                        break;
                    case 4:
                        debug_color = ( 1, 0.5, 0 );
                        break;
                    default:
                        debug_color = ( 1, 1, 1 );
                        break;
                }
            }
            
            debug_offset = ( 0, 0, 4 );
            print3d( self.origin - var_1d6118b10851f39 * debug_offset, var_57fdcc855c1a3725.name + "<dev string:x122>" + var_57fdcc855c1a3725.score + "<dev string:xae>", debug_color, 1, 0.3, var_d4618b70ea2e3eee );
            var_1d6118b10851f39++;
        }
    }

    // Namespace zombie_shade_loot_consume
    // Params 0, eflags: 0x4
    // Checksum 0x9a55d3d3, Offset: 0x4711
    // Size: 0x338, Type: dev
    function private function_b7030e165389ba05()
    {
        self endon( #"death" );
        debug_target_offset = ( 0, 0, 8 );
        debug_arrow_offset = ( 0, 0, 16 );
        var_f07d60c28974a526 = ( 0, 0, 16 );
        var_6add1cefbdca4739 = ( 0, 0, 10 );
        
        while ( true )
        {
            if ( getdvarint( @"hash_1ecba8c2522dfcd2" ) )
            {
                if ( isdefined( self.loot_consume.target_data ) )
                {
                    print3d( self.origin + debug_target_offset, "<dev string:x12b>" + self.loot_consume.target_data.name, ( 1, 1, 0 ), 1, 0.5, 1 );
                    debug::debug_draw_arrow( self.origin + debug_arrow_offset, self.loot_consume.target_data.loot.origin, ( 1, 1, 0 ), 1, 1, 1 );
                }
                
                centroid = self getcentroid();
                fullness_frac = self.loot_consume.fullness / self.loot_consume.max_fullness;
                fullness_color = vectorlerp( ( 0, 1, 0 ), ( 1, 0, 0 ), clamp( fullness_frac, 0, 1 ) );
                print3d( centroid + var_f07d60c28974a526, "<dev string:x12d>" + self.loot_consume.fullness + "<dev string:x137>" + self.loot_consume.max_fullness + ( fullness_frac >= 1 ? "<dev string:x139>" : "<dev string:xa0>" ), fullness_color, 1, 0.5, 1 );
                
                if ( isdefined( self.loot_consume.escape_countdown_start ) )
                {
                    escape_countdown = max( self.loot_consume.escape_countdown_time - utility::function_6f5d2e1f1ff70482( gettime() - self.loot_consume.escape_countdown_start ), 0 );
                    countdown_frac = self.loot_consume.escape_countdown_time > 0 ? escape_countdown / self.loot_consume.escape_countdown_time : 0;
                    countdown_color = vectorlerp( ( 1, 0, 0 ), ( 0, 1, 0 ), clamp( countdown_frac, 0, 1 ) );
                    print3d( centroid + var_6add1cefbdca4739, "<dev string:x141>" + escape_countdown + "<dev string:x154>", countdown_color, 1, 0.5, 1 );
                    
                    if ( isdefined( self.loot_consume.escape_location ) )
                    {
                        debug::debug_draw_arrow( self.origin, self.loot_consume.escape_location, ( 1, 0, 0 ), 1, 1, 1 );
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace zombie_shade_loot_consume
    // Params 0
    // Checksum 0xcb9873a2, Offset: 0x4a51
    // Size: 0x86, Type: dev
    function setup_loot_consume_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x156>" );
        devgui::add_devgui_func( "<dev string:x17a>", "<dev string:x18c>", &function_21cad289582712c8 );
        devgui::add_devgui_func( "<dev string:x1ac>", "<dev string:x1ba>", &debug_force_consume_loot );
        devgui::add_devgui_func( "<dev string:x1d3>", "<dev string:x1e0>", &function_73a864b5ed664865 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1f3>", "<dev string:x204>", &function_165c63868bfb8938 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x21b>", "<dev string:x22c>", &function_165c63868bfb8938 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_shade_loot_consume
    // Params 0, eflags: 0x4
    // Checksum 0x41488122, Offset: 0x4adf
    // Size: 0x2f, Type: dev
    function private function_21cad289582712c8()
    {
        debug_loot_consume = getdvarint( @"hash_1ecba8c2522dfcd2" );
        setdevdvar( @"hash_1ecba8c2522dfcd2", !debug_loot_consume );
    }

    // Namespace zombie_shade_loot_consume
    // Params 0, eflags: 0x4
    // Checksum 0x4f2a4512, Offset: 0x4b16
    // Size: 0x5c, Type: dev
    function private debug_force_consume_loot()
    {
        shade = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x24>" );
        
        if ( isdefined( shade ) )
        {
            force_consume = shade getaiblackboarddynamic( "<dev string:x243>" );
            shade function_786bb6aa1b76c7ee( "<dev string:x243>", !force_consume );
        }
    }

    // Namespace zombie_shade_loot_consume
    // Params 0, eflags: 0x4
    // Checksum 0x33f3d251, Offset: 0x4b7a
    // Size: 0x8a, Type: dev
    function private function_73a864b5ed664865()
    {
        shade = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x24>" );
        
        if ( isdefined( shade ) && !shade.loot_consume.var_8a3636a21636e0b1 )
        {
            shade.loot_consume.var_8a3636a21636e0b1 = 1;
            shade.loot_consume.escape_countdown_time = 0;
            shade thread function_6c84e72e9f1134();
        }
    }

    // Namespace zombie_shade_loot_consume
    // Params 1, eflags: 0x4
    // Checksum 0x1e8e47d2, Offset: 0x4c0c
    // Size: 0x9a, Type: dev
    function private function_165c63868bfb8938( params )
    {
        fullness = int( params[ 0 ] );
        shade = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x24>" );
        
        if ( isdefined( shade ) )
        {
            shade.loot_consume.fullness += fullness;
            shade callback::callback( "<dev string:x256>", { #loot:undefined } );
        }
    }

#/
