// script_1f827eec11f3e4ef  (hash_1f827eec11f3e4ef.gscc) (size: 1269 Bytes / 0x4f5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1cb5a6b5 (481666741)
// size ...... 1269 (0x4f5)
// includes .. 2   (offset: 0x495)
// strings ... 5   (offset: 0x4a5)
// dev strs .. 0   (offset: 0x4f5)
// exports ... 8   (offset: 0x215)
// cseg ...... 0x93 + 0x182 (0x215)
// imports ... 11  (offset: 0x355)
// animtree1 . 0   (offset: 0x4f5)
// animtree2 . 0   (offset: 0x4f5)
#using scripts\asm\shared\variant_asm;
#using scripts\common\callbacks;

#namespace namespace_3d3dd05aed5a95f5;

// Namespace namespace_3d3dd05aed5a95f5
// Params 0
// Checksum 0x9e870684, Offset: 0xb1
// Size: 0x3f
function register_shoot_variant()
{
    namespace_ef0cd975820ec3b::register_anim_variant( "shoot", &function_df4450ed1d513d49, &function_ba54aead6a9b2fc3 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "shoot", function_3cb9785ade78985a( 0 ) );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "shoot", function_3cb9785ade78985a( 1 ) );
}

// Namespace namespace_3d3dd05aed5a95f5
// Params 0
// Checksum 0x625b6f4d, Offset: 0xf8
// Size: 0x22
function function_721fd881a662eeaa()
{
    callback::get_template( self.animsetname ) callback::add( "on_is_moving_shoot_changed", &on_is_moving_shoot_changed );
}

// Namespace namespace_3d3dd05aed5a95f5
// Params 0
// Checksum 0x3ac72342, Offset: 0x122
// Size: 0xe
function init_zombie_mangler_shoot()
{
    namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "shoot" );
}

// Namespace namespace_3d3dd05aed5a95f5
// Params 1, eflags: 0x4
// Checksum 0xa00f77db, Offset: 0x138
// Size: 0x18
function private on_is_moving_shoot_changed( params )
{
    namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "shoot" );
}

// Namespace namespace_3d3dd05aed5a95f5
// Params 1, eflags: 0x4
// Checksum 0x8d381bbd, Offset: 0x158
// Size: 0x2c
function private function_3cb9785ade78985a( is_moving )
{
    struct = spawnstruct();
    struct.is_moving = is_moving;
    return struct;
}

// Namespace namespace_3d3dd05aed5a95f5
// Params 1, eflags: 0x4
// Checksum 0x55431c8a, Offset: 0x18d
// Size: 0x66
function private function_df4450ed1d513d49( struct )
{
    alias = "";
    
    if ( isdefined( struct.is_moving ) )
    {
        alias += self.is_moving_shoot ? "walk" : "idle";
        
        if ( istrue( self.is_moving ) != struct.is_moving )
        {
            return;
        }
    }
    
    return alias;
}

// Namespace namespace_3d3dd05aed5a95f5
// Params 1, eflags: 0x4
// Checksum 0xdbc78187, Offset: 0x1fc
// Size: 0x19
function private function_ba54aead6a9b2fc3( alias )
{
    self function_695b8e1b655c2796( "shoot", alias );
}

