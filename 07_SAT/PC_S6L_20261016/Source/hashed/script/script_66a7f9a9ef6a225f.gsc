// script_66a7f9a9ef6a225f  (hash_66a7f9a9ef6a225f.gscc) (size: 1731 Bytes / 0x6c3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb999ed08 (3113872648)
// size ...... 1731 (0x6c3)
// includes .. 5   (offset: 0x5ef)
// strings ... 7   (offset: 0x617)
// dev strs .. 5   (offset: 0x687)
// exports ... 7   (offset: 0x2e7)
// cseg ...... 0xaa + 0x23d (0x2e7)
// imports ... 17  (offset: 0x3ff)
// animtree1 . 0   (offset: 0x6c3)
// animtree2 . 0   (offset: 0x6c3)
#using script_60cc31ea91d0ad55;
#using scripts\asm\asm;
#using scripts\asm\shared\variant_asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_wander;
#using scripts\common\callbacks;

#namespace namespace_5d23f6b6f9512991;

// Namespace namespace_5d23f6b6f9512991
// Params 0
// Checksum 0xd41f4118, Offset: 0xc8
// Size: 0x76
function register_move_variant()
{
    namespace_ef0cd975820ec3b::register_anim_variant( "move", &function_83979130715e100f, &function_bf404fd24aab4c49 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( "walk" ), 1 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( "run" ), 1 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( "sprint" ), 1 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( undefined ) );
}

// Namespace namespace_5d23f6b6f9512991
// Params 0
// Checksum 0xda773806, Offset: 0x146
// Size: 0x21
function init_zombie_karkinos_move()
{
    callback::add( "on_move_speed_changed", &function_826d4d7d3ddd05a3 );
    namespace_56081b33e0a40eac::function_d9c6262c2bdb331c();
    thread zombie_wander::wander_listener();
}

// Namespace namespace_5d23f6b6f9512991
// Params 1, eflags: 0x4
// Checksum 0xd8c31822, Offset: 0x16f
// Size: 0x5d
function private function_826d4d7d3ddd05a3( params )
{
    var_4dd9c210b998e030 = namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "move" );
    
    /#
        record3dtext( "<dev string:x24>" + var_4dd9c210b998e030, self.origin + ( 0, 0, 48 ), ( 1, 0, 0 ), "<dev string:x39>", self );
    #/
}

// Namespace namespace_5d23f6b6f9512991
// Params 1, eflags: 0x4
// Checksum 0xce88cf0a, Offset: 0x1d4
// Size: 0x2c
function private function_39ca1a41b0038b36( var_a0ba2bd8aec21d38 )
{
    struct = spawnstruct();
    struct.var_a0ba2bd8aec21d38 = var_a0ba2bd8aec21d38;
    return struct;
}

// Namespace namespace_5d23f6b6f9512991
// Params 1, eflags: 0x4
// Checksum 0x9ac413d9, Offset: 0x209
// Size: 0x90
function private function_83979130715e100f( struct )
{
    alias = "";
    
    if ( isdefined( struct.var_a0ba2bd8aec21d38 ) )
    {
        alias += struct.var_a0ba2bd8aec21d38;
        
        if ( self._blackboard.movetype != struct.var_a0ba2bd8aec21d38 )
        {
            return;
        }
    }
    
    assert( alias != "<dev string:x40>", "<dev string:x41>" + self._blackboard.movetype + "<dev string:x65>" );
    return alias;
}

// Namespace namespace_5d23f6b6f9512991
// Params 1, eflags: 0x4
// Checksum 0xf63e142e, Offset: 0x2a2
// Size: 0x45
function private function_bf404fd24aab4c49( alias )
{
    self function_695b8e1b655c2796( "move", alias );
    
    if ( asm::asm_currentstatehasflag( self.asmname, "move" ) )
    {
        asm::asm_fireevent_internal( self.asmname, "loop_reroll_anim" );
    }
}

