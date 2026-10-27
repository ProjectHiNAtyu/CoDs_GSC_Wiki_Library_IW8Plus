// script_65b679adf331f917  (hash_65b679adf331f917.gscc) (size: 1562 Bytes / 0x61a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6612c790 (1712506768)
// size ...... 1562 (0x61a)
// includes .. 4   (offset: 0x57e)
// strings ... 8   (offset: 0x59e)
// dev strs .. 0   (offset: 0x61a)
// exports ... 8   (offset: 0x29e)
// cseg ...... 0xba + 0x1e4 (0x29e)
// imports ... 14  (offset: 0x3de)
// animtree1 . 0   (offset: 0x61a)
// animtree2 . 0   (offset: 0x61a)
#using script_60cc31ea91d0ad55;
#using scripts\asm\asm;
#using scripts\asm\shared\variant_asm;
#using scripts\common\callbacks;

#namespace namespace_86e54fbc3f05670c;

// Namespace namespace_86e54fbc3f05670c
// Params 0
// Checksum 0x3028de83, Offset: 0xd8
// Size: 0x74
function register_move_variant()
{
    namespace_ef0cd975820ec3b::register_anim_variant( "move", &function_83979130715e100f, &function_bf404fd24aab4c49 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( "walk" ) );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( "run" ) );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( "sprint" ) );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( "super_sprint" ) );
}

// Namespace namespace_86e54fbc3f05670c
// Params 0
// Checksum 0xb83f9441, Offset: 0x154
// Size: 0x22
function function_8036d421ebeee5c7()
{
    callback::get_template( self.animsetname ) callback::add( "on_move_speed_changed", &function_826d4d7d3ddd05a3 );
}

// Namespace namespace_86e54fbc3f05670c
// Params 0
// Checksum 0x290480ab, Offset: 0x17e
// Size: 0x9
function init_zombie_callisto_move()
{
    namespace_56081b33e0a40eac::function_d9c6262c2bdb331c();
}

// Namespace namespace_86e54fbc3f05670c
// Params 1, eflags: 0x4
// Checksum 0xc1bff261, Offset: 0x18f
// Size: 0x23
function private function_826d4d7d3ddd05a3( params )
{
    var_4dd9c210b998e030 = namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "move" );
}

// Namespace namespace_86e54fbc3f05670c
// Params 1, eflags: 0x4
// Checksum 0xe22d08, Offset: 0x1ba
// Size: 0x2c
function private function_39ca1a41b0038b36( var_a0ba2bd8aec21d38 )
{
    struct = spawnstruct();
    struct.var_a0ba2bd8aec21d38 = var_a0ba2bd8aec21d38;
    return struct;
}

// Namespace namespace_86e54fbc3f05670c
// Params 1, eflags: 0x4
// Checksum 0x3278755d, Offset: 0x1ef
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

// Namespace namespace_86e54fbc3f05670c
// Params 1, eflags: 0x4
// Checksum 0x3854f62c, Offset: 0x259
// Size: 0x45
function private function_bf404fd24aab4c49( alias )
{
    self function_695b8e1b655c2796( "move", alias );
    
    if ( asm::asm_currentstatehasflag( self.asmname, "move" ) )
    {
        asm::asm_fireevent_internal( self.asmname, "loop_reroll_anim" );
    }
}

