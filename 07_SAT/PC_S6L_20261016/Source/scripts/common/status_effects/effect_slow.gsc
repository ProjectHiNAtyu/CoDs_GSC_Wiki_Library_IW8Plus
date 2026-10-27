// scripts\common\status_effects\effect_slow.gsc  (hash_58682e6578ce0515.gscc) (size: 4512 Bytes / 0x11a0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3c0ddefd (1007542013)
// size ...... 4512 (0x11a0)
// includes .. 9   (offset: 0x1090)
// strings ... 6   (offset: 0x10d8)
// dev strs .. 3   (offset: 0x1170)
// exports ... 11  (offset: 0xa68)
// cseg ...... 0xb5 + 0x9b3 (0xa68)
// imports ... 36  (offset: 0xc20)
// animtree1 . 0   (offset: 0x11a0)
// animtree2 . 0   (offset: 0x11a0)
#using script_16ea1b94f0f381b3;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_emergence_spawning;
#using scripts\common\callbacks;
#using scripts\common\status_effects\status_effects;
#using scripts\common\utility;
#using scripts\common\values;

#namespace effect_slow;

// Namespace effect_slow
// Params 9
// Checksum 0x92fb2868, Offset: 0xd3
// Size: 0x172
function slow( var_40668aa4c0a87533, var_37363d52762f695e, var_7ac040448f8ace66, var_1e4624a03ea41715, endcallback, var_35e9f0e661545a34, var_749345f344f55b77, payload, cooldowns )
{
    assert( isstring( var_40668aa4c0a87533 ), "<dev string:x24>" );
    assert( isnumber( var_37363d52762f695e ), "<dev string:x45>" );
    assert( isnumber( var_7ac040448f8ace66 ), "<dev string:x64>" );
    
    if ( isai( self ) && !function_64adf2cc9d3408ad( var_35e9f0e661545a34 ) )
    {
        return 0;
    }
    
    if ( !status_effects::has_status_effect_type( "slow" ) )
    {
        self.var_e105f3af9b5e5e9b = asm::asm_getmoveplaybackrate();
    }
    
    effect = status_effects::function_93edde8d0fe48bb6( "slow", var_7ac040448f8ace66, var_40668aa4c0a87533, &function_f6e0bafa05a4dbb2, &function_b2a0a6c2de8bd645, var_749345f344f55b77, cooldowns );
    effect.var_1e4624a03ea41715 = var_1e4624a03ea41715;
    effect.rate = var_37363d52762f695e;
    effect.var_ec9eab1b0cf732fb = endcallback;
    effect.payload = payload;
    
    if ( isai( self ) && isplayer( var_1e4624a03ea41715 ) && var_749345f344f55b77 == "cold" )
    {
        if ( !isdefined( var_40668aa4c0a87533 ) || !status_effects::function_fa35fc2723e956eb( "slow", var_40668aa4c0a87533 ) )
        {
            var_1e4624a03ea41715 namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"frozen" );
        }
    }
    
    return status_effects::function_3747671c47b03216( effect );
}

// Namespace effect_slow
// Params 1
// Checksum 0x2c9baac9, Offset: 0x24e
// Size: 0x71, Type: bool
function function_64adf2cc9d3408ad( var_35e9f0e661545a34 )
{
    return isai( self ) && ( var_35e9f0e661545a34 || isdefined( self.aisettings ) && self.aisettings.var_3dae55586fee0a61 ) && !val::get( "disallow_slow" ) && !asm_bb::bb_isanimscripted() && !ai::is_doing_traversal( self ) && !self.is_traversing;
}

// Namespace effect_slow
// Params 1, eflags: 0x4
// Checksum 0xc0e94e97, Offset: 0x2c8
// Size: 0x1c9
function private function_f6e0bafa05a4dbb2( effect )
{
    n_time = gettime();
    var_3d46d3ed2467e8d8 = undefined;
    var_77dc4b9513d669d7 = undefined;
    
    foreach ( effect in self.status_effects[ "slow" ] )
    {
        if ( !isdefined( var_77dc4b9513d669d7 ) || effect.rate < var_77dc4b9513d669d7.rate )
        {
            var_77dc4b9513d669d7 = effect;
        }
        
        if ( effect.end_time > 0 && ( !isdefined( var_3d46d3ed2467e8d8 ) || effect.end_time < var_3d46d3ed2467e8d8 ) )
        {
            var_3d46d3ed2467e8d8 = effect.end_time;
        }
    }
    
    if ( isai( self ) && zombie_emergence_spawning::is_emergence_spawning_enabled() )
    {
        self.var_214fa57be3687ca6 = 1;
        zombie_emergence_spawning::function_80623a2279a4d888();
    }
    
    if ( isdefined( var_77dc4b9513d669d7 ) && n_time < var_3d46d3ed2467e8d8 )
    {
        if ( isai( self ) )
        {
            function_abcd722e23b31c8c( var_77dc4b9513d669d7.rate );
            callback::callback( "on_ai_slowed", { #rate:var_77dc4b9513d669d7.rate } );
            return;
        }
        
        if ( isplayer( self ) )
        {
            if ( !namespace_9d8e359c3b1041e5::function_698ebbcc057b168f( "genericEffectSlowMod" ) )
            {
                namespace_9d8e359c3b1041e5::function_3533667d928bc2cf( "genericEffectSlowMod", var_77dc4b9513d669d7.rate );
            }
            
            utility::callsharedfunc( #"weapons", #"hash_4ccf3b3fcf5ae366", "genericEffectSlowMod", var_77dc4b9513d669d7.rate );
            namespace_9d8e359c3b1041e5::function_f44fe9161043ae23();
        }
    }
}

// Namespace effect_slow
// Params 1, eflags: 0x4
// Checksum 0xa9f6d728, Offset: 0x499
// Size: 0x1ee
function private function_b2a0a6c2de8bd645( effect )
{
    if ( !( isdefined( self ) && isdefined( self.status_effects ) && isdefined( effect ) ) )
    {
        return;
    }
    
    current_time = gettime();
    var_46c52fe4b84fc183 = self.var_e105f3af9b5e5e9b ?? 1;
    self.var_e105f3af9b5e5e9b = undefined;
    
    foreach ( var_c6321cb8cd32b6a0 in self.status_effects[ "slow" ] )
    {
        if ( effect.unique_id == var_c6321cb8cd32b6a0.unique_id )
        {
            return;
        }
        
        if ( var_c6321cb8cd32b6a0.rate < var_46c52fe4b84fc183 && var_c6321cb8cd32b6a0.end_time > current_time )
        {
            var_46c52fe4b84fc183 = var_c6321cb8cd32b6a0.rate;
        }
    }
    
    if ( isai( self ) )
    {
        function_abcd722e23b31c8c( var_46c52fe4b84fc183 );
        callback::callback( "on_ai_slowed_end", { #rate:var_46c52fe4b84fc183 } );
        
        if ( self.var_214fa57be3687ca6 )
        {
            self.var_214fa57be3687ca6 = undefined;
            zombie_emergence_spawning::enable_emergence_spawning();
        }
    }
    else if ( isplayer( self ) )
    {
        if ( namespace_9d8e359c3b1041e5::function_698ebbcc057b168f( "genericEffectSlowMod" ) )
        {
            namespace_9d8e359c3b1041e5::function_e1ac55197494863e( "genericEffectSlowMod" );
            
            if ( var_46c52fe4b84fc183 != 1 )
            {
                namespace_9d8e359c3b1041e5::function_3533667d928bc2cf( "genericEffectSlowMod", var_46c52fe4b84fc183 );
            }
        }
        
        utility::callsharedfunc( #"weapons", #"hash_4ccf3b3fcf5ae366", "genericEffectSlowMod", var_46c52fe4b84fc183 );
        namespace_9d8e359c3b1041e5::function_f44fe9161043ae23();
    }
    
    if ( isdefined( effect.var_ec9eab1b0cf732fb ) )
    {
        self [[ effect.var_ec9eab1b0cf732fb ]]( effect.payload );
    }
}

// Namespace effect_slow
// Params 1, eflags: 0x4
// Checksum 0x8995840d, Offset: 0x68f
// Size: 0x52
function private function_abcd722e23b31c8c( n_ratescale )
{
    if ( !isagent( self ) )
    {
        return;
    }
    
    if ( asm::function_27be172b46a89235() == n_ratescale )
    {
        return;
    }
    
    asm::function_d82cb83c9c260d49( n_ratescale );
    
    if ( !self.var_71690721303970f4 && gettime() > self.birthtime )
    {
        asm::function_24133a663bba593c();
    }
}

// Namespace effect_slow
// Params 1
// Checksum 0xdc41f2cc, Offset: 0x6e9
// Size: 0xe0
function function_80a4bd13b5ba303a( var_40668aa4c0a87533 )
{
    assert( isstring( var_40668aa4c0a87533 ), "<dev string:x24>" );
    
    if ( !( isdefined( self ) && isdefined( self.status_effects ) ) )
    {
        return;
    }
    
    if ( !isarray( self.status_effects[ "slow" ] ) )
    {
        return;
    }
    
    foreach ( var_c6321cb8cd32b6a0 in self.status_effects[ "slow" ] )
    {
        if ( var_40668aa4c0a87533 == var_c6321cb8cd32b6a0.unique_id )
        {
            var_c6321cb8cd32b6a0.end_time = -1;
        }
    }
}

// Namespace effect_slow
// Params 0
// Checksum 0xfb58a1f3, Offset: 0x7d1
// Size: 0xb2
function stop_all_slows()
{
    if ( !( isdefined( self ) && isdefined( self.status_effects ) ) )
    {
        return;
    }
    
    if ( !isarray( self.status_effects[ "slow" ] ) )
    {
        return;
    }
    
    foreach ( var_c6321cb8cd32b6a0 in self.status_effects[ "slow" ] )
    {
        var_c6321cb8cd32b6a0.end_time = -1;
    }
}

// Namespace effect_slow
// Params 2
// Checksum 0xe1b37718, Offset: 0x88b
// Size: 0x3a
function function_6fab6266b5f636c3( effect_id, include_cooldown )
{
    if ( effect_id )
    {
        return status_effects::function_fa35fc2723e956eb( "slow", effect_id, include_cooldown );
    }
    
    return status_effects::has_status_effect_type( "slow", include_cooldown );
}

// Namespace effect_slow
// Params 1
// Checksum 0x6760bda1, Offset: 0x8cd
// Size: 0xbb, Type: bool
function function_c1be3c9f2d0b92d2( var_40668aa4c0a87533 )
{
    assert( isstring( var_40668aa4c0a87533 ), "<dev string:x24>" );
    
    if ( !status_effects::has_status_effect_type( "slow" ) )
    {
        return false;
    }
    
    foreach ( var_c6321cb8cd32b6a0 in self.status_effects[ "slow" ] )
    {
        if ( var_40668aa4c0a87533 == var_c6321cb8cd32b6a0.unique_id )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace effect_slow
// Params 2
// Checksum 0x3b144892, Offset: 0x991
// Size: 0xd6, Type: bool
function function_e91f0595ade60e84( var_1e4624a03ea41715, var_40668aa4c0a87533 )
{
    assert( isstring( var_40668aa4c0a87533 ), "<dev string:x24>" );
    
    if ( !status_effects::has_status_effect_type( "slow" ) )
    {
        return false;
    }
    
    foreach ( var_c6321cb8cd32b6a0 in self.status_effects[ "slow" ] )
    {
        if ( var_40668aa4c0a87533 == var_c6321cb8cd32b6a0.unique_id && var_1e4624a03ea41715 == var_c6321cb8cd32b6a0.var_1e4624a03ea41715 )
        {
            return true;
        }
    }
    
    return false;
}

