// script_1301524c1c5465db  (hash_1301524c1c5465db.gscc) (size: 1563 Bytes / 0x61b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x89ef559e (2314163614)
// size ...... 1563 (0x61b)
// includes .. 5   (offset: 0x56f)
// strings ... 7   (offset: 0x597)
// dev strs .. 2   (offset: 0x603)
// exports ... 7   (offset: 0x2a3)
// cseg ...... 0xaa + 0x1f9 (0x2a3)
// imports ... 15  (offset: 0x3bb)
// animtree1 . 0   (offset: 0x61b)
// animtree2 . 0   (offset: 0x61b)
#using script_60cc31ea91d0ad55;
#using scripts\asm\asm;
#using scripts\asm\shared\variant_asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_wander;
#using scripts\common\callbacks;

#namespace namespace_f8183ce4e15db3da;

// Namespace namespace_f8183ce4e15db3da
// Params 0
// Checksum 0xdf721236, Offset: 0xc8
// Size: 0x5d
function function_b1c1009e68f9b112()
{
    namespace_ef0cd975820ec3b::register_anim_variant( "move", &function_83979130715e100f, &function_bf404fd24aab4c49 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( "walk" ) );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( "run" ) );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( "sprint" ) );
}

// Namespace namespace_f8183ce4e15db3da
// Params 0
// Checksum 0x1f338e73, Offset: 0x12d
// Size: 0x21
function init_zombie_vermin_move()
{
    callback::add( "on_move_speed_changed", &on_move_speed_changed );
    namespace_56081b33e0a40eac::function_d9c6262c2bdb331c();
    thread zombie_wander::function_c77a8eaa38883b1c();
}

// Namespace namespace_f8183ce4e15db3da
// Params 1
// Checksum 0x92e14535, Offset: 0x156
// Size: 0x61
function on_move_speed_changed( params )
{
    self.var_8276841ec402381f = namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "move" );
    
    /#
        record3dtext( "<dev string:x24>" + self.var_8276841ec402381f, self.origin + ( 0, 0, 48 ), ( 1, 0, 0 ), "<dev string:x39>", self );
    #/
}

// Namespace namespace_f8183ce4e15db3da
// Params 1, eflags: 0x4
// Checksum 0xd24dd9a0, Offset: 0x1bf
// Size: 0x2c
function private function_39ca1a41b0038b36( var_a0ba2bd8aec21d38 )
{
    struct = spawnstruct();
    struct.var_a0ba2bd8aec21d38 = var_a0ba2bd8aec21d38;
    return struct;
}

// Namespace namespace_f8183ce4e15db3da
// Params 1, eflags: 0x4
// Checksum 0xec20a18b, Offset: 0x1f4
// Size: 0x61
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
    
    return alias;
}

// Namespace namespace_f8183ce4e15db3da
// Params 1, eflags: 0x4
// Checksum 0xeafb0284, Offset: 0x25e
// Size: 0x45
function private function_bf404fd24aab4c49( alias )
{
    self function_695b8e1b655c2796( "move", alias );
    
    if ( asm::asm_currentstatehasflag( self.asmname, "move" ) )
    {
        asm::asm_fireevent_internal( self.asmname, "loop_reroll_anim" );
    }
}

