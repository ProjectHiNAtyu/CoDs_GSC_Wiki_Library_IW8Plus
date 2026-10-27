// script_769dd81873f99e4f  (hash_769dd81873f99e4f.gscc) (size: 2119 Bytes / 0x847 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x923c0b (9583627)
// size ...... 2119 (0x847)
// includes .. 6   (offset: 0x75b)
// strings ... 8   (offset: 0x78b)
// dev strs .. 5   (offset: 0x80b)
// exports ... 10  (offset: 0x36f)
// cseg ...... 0xbc + 0x2b3 (0x36f)
// imports ... 21  (offset: 0x4ff)
// animtree1 . 0   (offset: 0x847)
// animtree2 . 0   (offset: 0x847)
#using script_60cc31ea91d0ad55;
#using scripts\asm\asm;
#using scripts\asm\shared\variant_asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\shared\zombie\zombie_wander;
#using scripts\common\callbacks;

#namespace namespace_14bc21a938ce7ab8;

// Namespace namespace_14bc21a938ce7ab8
// Params 0
// Checksum 0xcd88710, Offset: 0xda
// Size: 0x29
function function_59a7855b0081fa78()
{
    callback::get_template( self.animsetname ) callback::add( "on_move_speed_changed", &on_move_speed_changed );
    function_92324f04c88491bc();
}

// Namespace namespace_14bc21a938ce7ab8
// Params 0
// Checksum 0x459f93f7, Offset: 0x10b
// Size: 0x10
function init_zombie_amalgam_move()
{
    namespace_56081b33e0a40eac::function_d9c6262c2bdb331c();
    thread zombie_wander::wander_listener();
}

// Namespace namespace_14bc21a938ce7ab8
// Params 0
// Checksum 0x1864dde7, Offset: 0x123
// Size: 0x9
function function_a5316e87722b6ac4()
{
    thread function_8d70515506fdb6e0();
}

// Namespace namespace_14bc21a938ce7ab8
// Params 0, eflags: 0x4
// Checksum 0x91dbb94a, Offset: 0x134
// Size: 0x50
function private function_8d70515506fdb6e0()
{
    self endon( #"death" );
    waitframe();
    
    if ( !isdefined( self.extra_leg_count ) || self.extra_leg_count < 2 )
    {
        zombie_utils::function_a8ce00e0448cb6f0( "run", "legs_destroyed", 15 );
        return;
    }
    
    zombie_utils::function_a8ce00e0448cb6f0( undefined, "legs_destroyed" );
}

// Namespace namespace_14bc21a938ce7ab8
// Params 0, eflags: 0x4
// Checksum 0x8a43f751, Offset: 0x18c
// Size: 0x63
function private function_92324f04c88491bc()
{
    namespace_ef0cd975820ec3b::register_anim_variant( "move", &function_83979130715e100f, &function_bf404fd24aab4c49 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( "walk" ), 1 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( "run" ), 1 );
    namespace_ef0cd975820ec3b::function_6ffb0fbe59bdcb82( "move", function_39ca1a41b0038b36( "sprint" ), 1 );
}

// Namespace namespace_14bc21a938ce7ab8
// Params 1, eflags: 0x4
// Checksum 0xe58599c9, Offset: 0x1f7
// Size: 0x5d
function private on_move_speed_changed( params )
{
    move_anim_alias = namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "move" );
    
    /#
        record3dtext( "<dev string:x24>" + move_anim_alias, self.origin + ( 0, 0, 48 ), ( 1, 0, 0 ), "<dev string:x39>", self );
    #/
}

// Namespace namespace_14bc21a938ce7ab8
// Params 1, eflags: 0x4
// Checksum 0xa5290558, Offset: 0x25c
// Size: 0x2c
function private function_39ca1a41b0038b36( var_a0ba2bd8aec21d38 )
{
    struct = spawnstruct();
    struct.var_a0ba2bd8aec21d38 = var_a0ba2bd8aec21d38;
    return struct;
}

// Namespace namespace_14bc21a938ce7ab8
// Params 1, eflags: 0x4
// Checksum 0xf165d98b, Offset: 0x291
// Size: 0x90
function private function_83979130715e100f( struct )
{
    alias = "";
    
    if ( isdefined( struct.var_a0ba2bd8aec21d38 ) )
    {
        if ( self._blackboard.movetype != struct.var_a0ba2bd8aec21d38 )
        {
            return;
        }
        
        alias += struct.var_a0ba2bd8aec21d38;
    }
    
    assert( alias != "<dev string:x40>", "<dev string:x41>" + self._blackboard.movetype + "<dev string:x65>" );
    return alias;
}

// Namespace namespace_14bc21a938ce7ab8
// Params 1, eflags: 0x4
// Checksum 0x9d9fde7c, Offset: 0x32a
// Size: 0x45
function private function_bf404fd24aab4c49( alias )
{
    self function_695b8e1b655c2796( "move", alias );
    
    if ( asm::asm_currentstatehasflag( self.asmname, "move" ) )
    {
        asm::asm_fireevent_internal( self.asmname, "loop_reroll_anim" );
    }
}

