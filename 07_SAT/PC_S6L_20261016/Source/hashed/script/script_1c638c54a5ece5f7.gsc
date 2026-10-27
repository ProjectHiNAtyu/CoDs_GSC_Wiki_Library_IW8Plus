// script_1c638c54a5ece5f7  (hash_1c638c54a5ece5f7.gscc) (size: 1574 Bytes / 0x626 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1bd15e14 (466705940)
// size ...... 1574 (0x626)
// includes .. 4   (offset: 0x56e)
// strings ... 6   (offset: 0x58e)
// dev strs .. 5   (offset: 0x5ea)
// exports ... 7   (offset: 0x2aa)
// cseg ...... 0xa0 + 0x20a (0x2aa)
// imports ... 15  (offset: 0x3c2)
// animtree1 . 0   (offset: 0x626)
// animtree2 . 0   (offset: 0x626)
#using script_60cc31ea91d0ad55;
#using scripts\asm\asm;
#using scripts\asm\shared\variant_asm;
#using scripts\common\callbacks;

#namespace namespace_fa9d8e53d222e3e5;

// Namespace namespace_fa9d8e53d222e3e5
// Params 0
// Checksum 0x10ecded3, Offset: 0xbe
// Size: 0x4a
function register_move_variant()
{
    namespace_ef0cd975820ec3b::register_anim_variant( "move", &function_83979130715e100f, &function_bf404fd24aab4c49 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( "walk" ), 1 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( "run" ), 1 );
}

// Namespace namespace_fa9d8e53d222e3e5
// Params 0
// Checksum 0xafbd238, Offset: 0x110
// Size: 0x1a
function init_zombie_viper_move()
{
    callback::add( "on_move_speed_changed", &function_826d4d7d3ddd05a3 );
    namespace_56081b33e0a40eac::function_d9c6262c2bdb331c();
}

// Namespace namespace_fa9d8e53d222e3e5
// Params 1, eflags: 0x4
// Checksum 0x520699ee, Offset: 0x132
// Size: 0x5d
function private function_826d4d7d3ddd05a3( params )
{
    var_4dd9c210b998e030 = namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "move" );
    
    /#
        record3dtext( "<dev string:x24>" + var_4dd9c210b998e030, self.origin + ( 0, 0, 48 ), ( 1, 0, 0 ), "<dev string:x39>", self );
    #/
}

// Namespace namespace_fa9d8e53d222e3e5
// Params 1, eflags: 0x4
// Checksum 0x444d4ec6, Offset: 0x197
// Size: 0x2c
function private function_39ca1a41b0038b36( var_a0ba2bd8aec21d38 )
{
    struct = spawnstruct();
    struct.var_a0ba2bd8aec21d38 = var_a0ba2bd8aec21d38;
    return struct;
}

// Namespace namespace_fa9d8e53d222e3e5
// Params 1, eflags: 0x4
// Checksum 0x10019215, Offset: 0x1cc
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

// Namespace namespace_fa9d8e53d222e3e5
// Params 1, eflags: 0x4
// Checksum 0x7cfb95e2, Offset: 0x265
// Size: 0x45
function private function_bf404fd24aab4c49( alias )
{
    self function_695b8e1b655c2796( "move", alias );
    
    if ( asm::asm_currentstatehasflag( self.asmname, "move" ) )
    {
        asm::asm_fireevent_internal( self.asmname, "loop_reroll_anim" );
    }
}

