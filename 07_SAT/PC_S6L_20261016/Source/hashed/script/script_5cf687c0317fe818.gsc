// script_5cf687c0317fe818  (hash_5cf687c0317fe818.gscc) (size: 1774 Bytes / 0x6ee / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x37395e41 (926506561)
// size ...... 1774 (0x6ee)
// includes .. 2   (offset: 0x636)
// strings ... 11  (offset: 0x646)
// dev strs .. 0   (offset: 0x6ee)
// exports ... 9   (offset: 0x34e)
// cseg ...... 0xdc + 0x272 (0x34e)
// imports ... 12  (offset: 0x4b6)
// animtree1 . 0   (offset: 0x6ee)
// animtree2 . 0   (offset: 0x6ee)
#using scripts\asm\shared\variant_asm;
#using scripts\common\callbacks;

#namespace namespace_245308063ee5298c;

// Namespace namespace_245308063ee5298c
// Params 0
// Checksum 0xb4841408, Offset: 0xfa
// Size: 0x90
function register_melee_variant()
{
    namespace_ef0cd975820ec3b::register_anim_variant( "melee", &function_a51510d63b8a632, &function_3301a5711e996c8 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "melee", function_774051f9d32fd993( 0, undefined ) );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "melee", function_774051f9d32fd993( 1, "walk" ) );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "melee", function_774051f9d32fd993( 1, "run" ) );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "melee", function_774051f9d32fd993( 1, "sprint" ) );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "melee", function_774051f9d32fd993( 1, "super_sprint" ) );
}

// Namespace namespace_245308063ee5298c
// Params 0
// Checksum 0x59744aad, Offset: 0x192
// Size: 0x42
function function_a4788d12c4ff81ef()
{
    callback::get_template( self.animsetname ) callback::add( "on_is_moving_melee_changed", &function_e0d499c13803af86 );
    callback::get_template( self.animsetname ) callback::add( "on_move_speed_changed", &melee_on_move_speed_changed );
}

// Namespace namespace_245308063ee5298c
// Params 0
// Checksum 0xeabe9cc4, Offset: 0x1dc
// Size: 0xe
function init_ztron_papaback_melee()
{
    namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "melee" );
}

// Namespace namespace_245308063ee5298c
// Params 1, eflags: 0x4
// Checksum 0x9a497608, Offset: 0x1f2
// Size: 0x18
function private function_e0d499c13803af86( params )
{
    namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "melee" );
}

// Namespace namespace_245308063ee5298c
// Params 1, eflags: 0x4
// Checksum 0xc17ea1e3, Offset: 0x212
// Size: 0x18
function private melee_on_move_speed_changed( params )
{
    namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "melee" );
}

// Namespace namespace_245308063ee5298c
// Params 2, eflags: 0x4
// Checksum 0xa2c0cdc7, Offset: 0x232
// Size: 0x43
function private function_774051f9d32fd993( is_moving_melee, var_a0ba2bd8aec21d38 )
{
    struct = spawnstruct();
    struct.is_moving_melee = is_moving_melee;
    struct.var_a0ba2bd8aec21d38 = var_a0ba2bd8aec21d38;
    return struct;
}

// Namespace namespace_245308063ee5298c
// Params 1, eflags: 0x4
// Checksum 0xe05bd800, Offset: 0x27e
// Size: 0xae
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
    
    return alias;
}

// Namespace namespace_245308063ee5298c
// Params 1, eflags: 0x4
// Checksum 0xfd44c9b6, Offset: 0x335
// Size: 0x19
function private function_3301a5711e996c8( alias )
{
    self function_695b8e1b655c2796( "melee", alias );
}

