// script_a968e45d71a4e1f  (hash_0a968e45d71a4e1f.gscc) (size: 1741 Bytes / 0x6cd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3f505a4b (1062230603)
// size ...... 1741 (0x6cd)
// includes .. 5   (offset: 0x5ed)
// strings ... 8   (offset: 0x615)
// dev strs .. 5   (offset: 0x691)
// exports ... 7   (offset: 0x2fd)
// cseg ...... 0xba + 0x243 (0x2fd)
// imports ... 16  (offset: 0x415)
// animtree1 . 0   (offset: 0x6cd)
// animtree2 . 0   (offset: 0x6cd)
#using script_60cc31ea91d0ad55;
#using scripts\asm\asm;
#using scripts\asm\shared\variant_asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_wander;
#using scripts\common\callbacks;

#namespace namespace_31c251633dac8f25;

// Namespace namespace_31c251633dac8f25
// Params 0
// Checksum 0x328136a8, Offset: 0xd8
// Size: 0x7c
function register_move_variant()
{
    namespace_ef0cd975820ec3b::register_anim_variant( "move", &function_83979130715e100f, &function_bf404fd24aab4c49 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( "walk" ), 1 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( "run" ), 3 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( "sprint" ), 1 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( "super_sprint" ), 1 );
}

// Namespace namespace_31c251633dac8f25
// Params 0
// Checksum 0xcad645fc, Offset: 0x15c
// Size: 0x21
function init_ztron_papaback_move()
{
    callback::add( "on_move_speed_changed", &function_826d4d7d3ddd05a3 );
    namespace_56081b33e0a40eac::function_d9c6262c2bdb331c();
    thread zombie_wander::function_c77a8eaa38883b1c();
}

// Namespace namespace_31c251633dac8f25
// Params 1, eflags: 0x4
// Checksum 0xeaad9f4a, Offset: 0x185
// Size: 0x5d
function private function_826d4d7d3ddd05a3( params )
{
    var_4dd9c210b998e030 = namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "move" );
    
    /#
        record3dtext( "<dev string:x24>" + var_4dd9c210b998e030, self.origin + ( 0, 0, 48 ), ( 1, 0, 0 ), "<dev string:x39>", self );
    #/
}

// Namespace namespace_31c251633dac8f25
// Params 1, eflags: 0x4
// Checksum 0xfce64862, Offset: 0x1ea
// Size: 0x2c
function private function_39ca1a41b0038b36( var_a0ba2bd8aec21d38 )
{
    struct = spawnstruct();
    struct.var_a0ba2bd8aec21d38 = var_a0ba2bd8aec21d38;
    return struct;
}

// Namespace namespace_31c251633dac8f25
// Params 1, eflags: 0x4
// Checksum 0xa8aa94b1, Offset: 0x21f
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

// Namespace namespace_31c251633dac8f25
// Params 1, eflags: 0x4
// Checksum 0xc4509346, Offset: 0x2b8
// Size: 0x45
function private function_bf404fd24aab4c49( alias )
{
    self function_695b8e1b655c2796( "move", alias );
    
    if ( asm::asm_currentstatehasflag( self.asmname, "move" ) )
    {
        asm::asm_fireevent_internal( self.asmname, "loop_reroll_anim" );
    }
}

