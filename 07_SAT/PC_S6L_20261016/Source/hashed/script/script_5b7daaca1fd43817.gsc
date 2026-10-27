// script_5b7daaca1fd43817  (hash_5b7daaca1fd43817.gscc) (size: 1273 Bytes / 0x4f9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x15188b6c (353930092)
// size ...... 1273 (0x4f9)
// includes .. 2   (offset: 0x499)
// strings ... 5   (offset: 0x4a9)
// dev strs .. 0   (offset: 0x4f9)
// exports ... 8   (offset: 0x219)
// cseg ...... 0x97 + 0x182 (0x219)
// imports ... 11  (offset: 0x359)
// animtree1 . 0   (offset: 0x4f9)
// animtree2 . 0   (offset: 0x4f9)
#using scripts\asm\shared\variant_asm;
#using scripts\common\callbacks;

#namespace namespace_3cb33073a34a0c5;

// Namespace namespace_3cb33073a34a0c5
// Params 0
// Checksum 0xa049caaf, Offset: 0xb5
// Size: 0x3f
function register_barrage_variant()
{
    namespace_ef0cd975820ec3b::register_anim_variant( "barrage", &function_1feecf1f57daa832, &function_fd678c182309a0e0 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "barrage", function_e16ccc14e2846a8b( 0 ) );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "barrage", function_e16ccc14e2846a8b( 1 ) );
}

// Namespace namespace_3cb33073a34a0c5
// Params 0
// Checksum 0x522feca6, Offset: 0xfc
// Size: 0x22
function function_29a289a7493e0b07()
{
    callback::get_template( self.animsetname ) callback::add( "on_is_moving_barrage_changed", &on_is_moving_barrage_changed );
}

// Namespace namespace_3cb33073a34a0c5
// Params 0
// Checksum 0xb3e08384, Offset: 0x126
// Size: 0xe
function init_zombie_mangler_barrage()
{
    namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "barrage" );
}

// Namespace namespace_3cb33073a34a0c5
// Params 1, eflags: 0x4
// Checksum 0x406fab0a, Offset: 0x13c
// Size: 0x18
function private on_is_moving_barrage_changed( params )
{
    namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "barrage" );
}

// Namespace namespace_3cb33073a34a0c5
// Params 1, eflags: 0x4
// Checksum 0x4f09577, Offset: 0x15c
// Size: 0x2c
function private function_e16ccc14e2846a8b( is_moving )
{
    struct = spawnstruct();
    struct.is_moving = is_moving;
    return struct;
}

// Namespace namespace_3cb33073a34a0c5
// Params 1, eflags: 0x4
// Checksum 0xb2f6564, Offset: 0x191
// Size: 0x66
function private function_1feecf1f57daa832( struct )
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

// Namespace namespace_3cb33073a34a0c5
// Params 1, eflags: 0x4
// Checksum 0xb828f7f4, Offset: 0x200
// Size: 0x19
function private function_fd678c182309a0e0( alias )
{
    self function_695b8e1b655c2796( "barrage", alias );
}

