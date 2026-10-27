// script_608f661d4a9f5279  (hash_608f661d4a9f5279.gscc) (size: 779 Bytes / 0x30b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf1b7e881 (4055361665)
// size ...... 779 (0x30b)
// includes .. 2   (offset: 0x2e3)
// strings ... 2   (offset: 0x2f3)
// dev strs .. 0   (offset: 0x30b)
// exports ... 5   (offset: 0x16f)
// cseg ...... 0x73 + 0xfc (0x16f)
// imports ... 6   (offset: 0x237)
// animtree1 . 0   (offset: 0x30b)
// animtree2 . 0   (offset: 0x30b)
#using scripts\asm\asm;
#using scripts\common\callbacks;

#namespace namespace_7b1c2d73686554c8;

// Namespace namespace_7b1c2d73686554c8
// Params 0
// Checksum 0x28eb02e7, Offset: 0x91
// Size: 0x2c
function function_7a6a165095e8e0e7()
{
    callback::add( #"hash_ac987ecfe2199639", &on_start_grab );
    callback::add( #"hash_1422ba4cf377766c", &on_start_pull );
}

// Namespace namespace_7b1c2d73686554c8
// Params 1, eflags: 0x4
// Checksum 0xe08f6adc, Offset: 0xc5
// Size: 0x1f
function private on_start_grab( params )
{
    update_state_animations();
    asm::asm_setstate( "grab_chunk" );
}

// Namespace namespace_7b1c2d73686554c8
// Params 1, eflags: 0x4
// Checksum 0x59549110, Offset: 0xec
// Size: 0x21
function private on_start_pull( params )
{
    asm::asm_fireevent( self.asmname, "exit_loop" );
}

// Namespace namespace_7b1c2d73686554c8
// Params 0
// Checksum 0x87c3eafc, Offset: 0x115
// Size: 0x5a
function update_state_animations()
{
    self._blackboard.var_71e4226249c26ebf = self.barricade_data.var_83b2651228d887a3;
    self._blackboard.var_b05be297c2f48b10 = self.barricade_data.chunk.index;
}

