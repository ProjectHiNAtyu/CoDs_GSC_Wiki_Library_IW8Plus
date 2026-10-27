// script_2b848668600efa30  (hash_2b848668600efa30.gscc) (size: 1911 Bytes / 0x777 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8a885369 (2324190057)
// size ...... 1911 (0x777)
// includes .. 2   (offset: 0x6af)
// strings ... 11  (offset: 0x6bf)
// dev strs .. 0   (offset: 0x777)
// exports ... 9   (offset: 0x3c7)
// cseg ...... 0xdc + 0x2eb (0x3c7)
// imports ... 12  (offset: 0x52f)
// animtree1 . 0   (offset: 0x777)
// animtree2 . 0   (offset: 0x777)
#using scripts\asm\shared\variant_asm;
#using scripts\common\callbacks;

#namespace namespace_5327d50d93090f10;

// Namespace namespace_5327d50d93090f10
// Params 0
// Checksum 0xe3e17a72, Offset: 0xfa
// Size: 0x91
function register_melee_variant()
{
    namespace_ef0cd975820ec3b::register_anim_variant( "melee", &function_a51510d63b8a632, &function_3301a5711e996c8 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "melee", function_774051f9d32fd993( 0, undefined, 0 ) );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "melee", function_774051f9d32fd993( 0, undefined, 1 ) );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "melee", function_774051f9d32fd993( 1, "walk", undefined ) );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "melee", function_774051f9d32fd993( 1, "run", undefined ) );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "melee", function_774051f9d32fd993( 1, "sprint", undefined ) );
}

// Namespace namespace_5327d50d93090f10
// Params 0
// Checksum 0x94dae63a, Offset: 0x193
// Size: 0x42
function function_34a612cca324de27()
{
    callback::get_template( self.animsetname ) callback::add( "on_is_moving_melee_changed", &function_e0d499c13803af86 );
    callback::get_template( self.animsetname ) callback::add( "on_move_speed_changed", &melee_on_move_speed_changed );
}

// Namespace namespace_5327d50d93090f10
// Params 0
// Checksum 0x4494b9a7, Offset: 0x1dd
// Size: 0xe
function init_zombie_mangler_melee()
{
    namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "melee" );
}

// Namespace namespace_5327d50d93090f10
// Params 1, eflags: 0x4
// Checksum 0x37a55094, Offset: 0x1f3
// Size: 0x18
function private function_e0d499c13803af86( params )
{
    namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "melee" );
}

// Namespace namespace_5327d50d93090f10
// Params 1, eflags: 0x4
// Checksum 0x6c92877f, Offset: 0x213
// Size: 0x18
function private melee_on_move_speed_changed( params )
{
    namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "melee" );
}

// Namespace namespace_5327d50d93090f10
// Params 3, eflags: 0x4
// Checksum 0x6d729bdb, Offset: 0x233
// Size: 0x5a
function private function_774051f9d32fd993( is_moving_melee, var_a0ba2bd8aec21d38, is_single_armed )
{
    struct = spawnstruct();
    struct.is_moving_melee = is_moving_melee;
    struct.var_a0ba2bd8aec21d38 = var_a0ba2bd8aec21d38;
    struct.is_single_armed = is_single_armed;
    return struct;
}

// Namespace namespace_5327d50d93090f10
// Params 1, eflags: 0x4
// Checksum 0xeae62326, Offset: 0x296
// Size: 0x10f
function private function_a51510d63b8a632( struct )
{
    alias = "";
    
    if ( isdefined( struct.is_moving_melee ) )
    {
        alias += self.is_moving_melee ? "move" : "static";
        
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
    
    if ( isdefined( struct.is_single_armed ) )
    {
        alias += struct.is_single_armed ? ( alias != "" ? "_" : "" ) + "single_armed" : "";
        
        if ( self.gun_arm_destroyed != struct.is_single_armed )
        {
            return;
        }
    }
    
    return alias;
}

// Namespace namespace_5327d50d93090f10
// Params 1, eflags: 0x4
// Checksum 0x884276f0, Offset: 0x3ae
// Size: 0x19
function private function_3301a5711e996c8( alias )
{
    self function_695b8e1b655c2796( "melee", alias );
}

