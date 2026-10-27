// script_159e69834267c720  (hash_159e69834267c720.gscc) (size: 1504 Bytes / 0x5e0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd3d043fa (3553641466)
// size ...... 1504 (0x5e0)
// includes .. 2   (offset: 0x564)
// strings ... 7   (offset: 0x574)
// dev strs .. 0   (offset: 0x5e0)
// exports ... 9   (offset: 0x294)
// cseg ...... 0xb5 + 0x1df (0x294)
// imports ... 12  (offset: 0x3fc)
// animtree1 . 0   (offset: 0x5e0)
// animtree2 . 0   (offset: 0x5e0)
#using scripts\asm\shared\variant_asm;
#using scripts\common\callbacks;

#namespace namespace_e60d35adb067df4c;

// Namespace namespace_e60d35adb067df4c
// Params 0
// Checksum 0xc95a6487, Offset: 0xd3
// Size: 0x45
function register_melee_variant()
{
    namespace_ef0cd975820ec3b::register_anim_variant( "melee", &function_a51510d63b8a632, &function_3301a5711e996c8 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "melee", function_774051f9d32fd993( 0, undefined ) );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "melee", function_774051f9d32fd993( 1, "run" ) );
}

// Namespace namespace_e60d35adb067df4c
// Params 0
// Checksum 0xb740a65e, Offset: 0x120
// Size: 0x42
function init_melee_global()
{
    callback::get_template( self.animsetname ) callback::add( "on_move_speed_changed", &melee_on_move_speed_changed );
    callback::get_template( self.animsetname ) callback::add( "on_is_moving_melee_changed", &function_e0d499c13803af86 );
}

// Namespace namespace_e60d35adb067df4c
// Params 0
// Checksum 0x96df9876, Offset: 0x16a
// Size: 0xe
function function_a887d53ac5484b73()
{
    namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "melee" );
}

// Namespace namespace_e60d35adb067df4c
// Params 1, eflags: 0x4
// Checksum 0x4ffc5723, Offset: 0x180
// Size: 0x18
function private melee_on_move_speed_changed( params )
{
    namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "melee" );
}

// Namespace namespace_e60d35adb067df4c
// Params 1, eflags: 0x4
// Checksum 0x14cb80c8, Offset: 0x1a0
// Size: 0x18
function private function_e0d499c13803af86( params )
{
    namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "melee" );
}

// Namespace namespace_e60d35adb067df4c
// Params 2, eflags: 0x4
// Checksum 0x66cabb2c, Offset: 0x1c0
// Size: 0x43
function private function_774051f9d32fd993( is_moving_melee, var_a0ba2bd8aec21d38 )
{
    struct = spawnstruct();
    struct.is_moving_melee = is_moving_melee;
    struct.var_a0ba2bd8aec21d38 = var_a0ba2bd8aec21d38;
    return struct;
}

// Namespace namespace_e60d35adb067df4c
// Params 1, eflags: 0x4
// Checksum 0x599a79e3, Offset: 0x20c
// Size: 0x66
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
    
    return alias;
}

// Namespace namespace_e60d35adb067df4c
// Params 1, eflags: 0x4
// Checksum 0x394ebf5d, Offset: 0x27b
// Size: 0x19
function private function_3301a5711e996c8( alias )
{
    self function_695b8e1b655c2796( "melee", alias );
}

