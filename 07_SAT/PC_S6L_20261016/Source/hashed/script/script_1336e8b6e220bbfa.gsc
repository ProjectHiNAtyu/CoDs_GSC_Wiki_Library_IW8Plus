// script_1336e8b6e220bbfa  (hash_1336e8b6e220bbfa.gscc) (size: 2960 Bytes / 0xb90 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa29202dc (2727477980)
// size ...... 2960 (0xb90)
// includes .. 3   (offset: 0xa7c)
// strings ... 16  (offset: 0xa94)
// dev strs .. 0   (offset: 0xb90)
// exports ... 10  (offset: 0x698)
// cseg ...... 0x12f + 0x569 (0x698)
// imports ... 18  (offset: 0x828)
// animtree1 . 0   (offset: 0xb90)
// animtree2 . 0   (offset: 0xb90)
#using scripts\asm\shared\variant_asm;
#using scripts\common\callbacks;
#using scripts\common\trace;

#namespace namespace_ed4c2a26601f5317;

// Namespace namespace_ed4c2a26601f5317
// Params 0
// Checksum 0xbdca94ea, Offset: 0x14d
// Size: 0xf4
function register_melee_variant()
{
    namespace_ef0cd975820ec3b::register_anim_variant( "melee", &function_a51510d63b8a632, &function_3301a5711e996c8 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "melee", function_774051f9d32fd993( undefined, undefined, 1 ) );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "melee", function_774051f9d32fd993( undefined, undefined, 0 ) );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "melee", function_774051f9d32fd993( 1, "wander", undefined ) );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "melee", function_774051f9d32fd993( 1, "walk", undefined ) );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "melee", function_774051f9d32fd993( 1, "run", undefined ) );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "melee", function_774051f9d32fd993( 1, "run_slow", undefined ) );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "melee", function_774051f9d32fd993( 1, "sprint", undefined ) );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "melee", function_774051f9d32fd993( 1, "super_sprint", undefined ) );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "melee", function_774051f9d32fd993( 0, undefined, undefined ) );
}

// Namespace namespace_ed4c2a26601f5317
// Params 0
// Checksum 0x33368cc1, Offset: 0x249
// Size: 0x41
function function_a887d53ac5484b73()
{
    callback::add( "on_is_melee_started", &hellhound_on_is_melee_started );
    callback::add( "on_move_speed_changed", &melee_on_move_speed_changed );
    callback::add( "on_is_moving_melee_changed", &function_e0d499c13803af86 );
    namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "melee" );
}

// Namespace namespace_ed4c2a26601f5317
// Params 1, eflags: 0x4
// Checksum 0x243723b4, Offset: 0x292
// Size: 0x37
function private hellhound_on_is_melee_started( params )
{
    self notify( #"melee_started" );
    namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "melee" );
    
    if ( self.is_moving_melee )
    {
        thread function_418cf85fba30e515();
    }
}

// Namespace namespace_ed4c2a26601f5317
// Params 0, eflags: 0xc
// Checksum 0x97167401, Offset: 0x2d1
// Size: 0x8e
function private function_418cf85fba30e515()
{
    self notify( #"hash_b1124f58d7ce5fa0" );
    self endon( #"hash_b1124f58d7ce5fa0" );
    self endon( #"death" );
    self waittill( #"hit_melee" );
    oldthreshold = self._blackboard.var_4f59295d1d34e1a9;
    self._blackboard.var_4f59295d1d34e1a9 = -1;
    self waittill( #"bmeleeended" );
    self._blackboard.var_4f59295d1d34e1a9 = oldthreshold;
}

// Namespace namespace_ed4c2a26601f5317
// Params 1, eflags: 0x4
// Checksum 0x9f84db78, Offset: 0x367
// Size: 0x18
function private melee_on_move_speed_changed( params )
{
    namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "melee" );
}

// Namespace namespace_ed4c2a26601f5317
// Params 1, eflags: 0x4
// Checksum 0xc4b30c93, Offset: 0x387
// Size: 0x18
function private function_e0d499c13803af86( params )
{
    namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "melee" );
}

// Namespace namespace_ed4c2a26601f5317
// Params 3, eflags: 0x4
// Checksum 0x6e0a424b, Offset: 0x3a7
// Size: 0x5a
function private function_774051f9d32fd993( is_moving_melee, var_a0ba2bd8aec21d38, is_target_prone )
{
    struct = spawnstruct();
    struct.is_moving_melee = is_moving_melee;
    struct.var_a0ba2bd8aec21d38 = var_a0ba2bd8aec21d38;
    struct.is_target_prone = is_target_prone;
    return struct;
}

// Namespace namespace_ed4c2a26601f5317
// Params 1, eflags: 0x4
// Checksum 0x32f784b6, Offset: 0x40a
// Size: 0x26c
function private function_a51510d63b8a632( struct )
{
    if ( self.is_moving_melee )
    {
        alias = "move_walk";
    }
    else
    {
        alias = "melee_default";
    }
    
    if ( !isdefined( self.var_3eaa5cd097e43179 ) )
    {
        return alias;
    }
    
    var_7cb783ab199e109e = self.var_3eaa5cd097e43179;
    
    if ( struct.is_target_prone )
    {
        if ( self.is_moving_melee )
        {
            return;
        }
        
        var_b0a681d77fccb76d = 0;
        
        if ( isent( var_7cb783ab199e109e ) )
        {
            var_b0a681d77fccb76d = var_7cb783ab199e109e.origin[ 2 ] - self.origin[ 2 ];
        }
        else if ( isvector( var_7cb783ab199e109e ) )
        {
            var_b0a681d77fccb76d = var_7cb783ab199e109e[ 2 ] - self.origin[ 2 ];
        }
        
        var_2e5f6194aada409d = 30;
        var_f75e5e2d4a5540d = undefined;
        
        if ( isent( var_7cb783ab199e109e ) )
        {
            if ( isplayer( var_7cb783ab199e109e ) )
            {
                var_f75e5e2d4a5540d = var_7cb783ab199e109e getstance();
            }
            else if ( isdefined( var_7cb783ab199e109e.currentpose ) )
            {
                var_f75e5e2d4a5540d = var_7cb783ab199e109e.currentpose;
            }
        }
        
        if ( var_b0a681d77fccb76d < var_2e5f6194aada409d && var_f75e5e2d4a5540d == "prone" )
        {
            return "melee_low";
        }
        
        return;
    }
    
    if ( isdefined( struct.is_target_prone ) && !struct.is_target_prone )
    {
        if ( self.is_moving_melee )
        {
            return;
        }
        
        if ( isent( var_7cb783ab199e109e ) )
        {
            var_2c27a21d12452a91 = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 65 );
            enemy_origin = ( var_7cb783ab199e109e.origin[ 0 ], var_7cb783ab199e109e.origin[ 1 ], var_7cb783ab199e109e.origin[ 2 ] + 32 );
            
            if ( !trace::_bullet_trace_passed( var_2c27a21d12452a91, enemy_origin, 0, self ) )
            {
                return "melee_low";
            }
        }
        
        return;
    }
    
    if ( isdefined( struct.is_moving_melee ) )
    {
        if ( self.is_moving_melee )
        {
            alias = "move";
        }
        
        if ( istrue( self.is_moving_melee ) != struct.is_moving_melee )
        {
            return;
        }
    }
    
    if ( isdefined( struct.var_a0ba2bd8aec21d38 ) )
    {
        alias += "_" + struct.var_a0ba2bd8aec21d38;
        
        if ( self._blackboard.movetype != struct.var_a0ba2bd8aec21d38 )
        {
            return;
        }
    }
    
    return alias;
}

// Namespace namespace_ed4c2a26601f5317
// Params 1, eflags: 0x4
// Checksum 0x6ce2c99c, Offset: 0x67f
// Size: 0x19
function private function_3301a5711e996c8( alias )
{
    self function_695b8e1b655c2796( "melee", alias );
}

