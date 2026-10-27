// script_56c614ebddc1ff7  (hash_056c614ebddc1ff7.gscc) (size: 723 Bytes / 0x2d3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x77dad741 (2010830657)
// size ...... 723 (0x2d3)
// includes .. 1   (offset: 0x29f)
// strings ... 3   (offset: 0x2a7)
// dev strs .. 0   (offset: 0x2d3)
// exports ... 4   (offset: 0x187)
// cseg ...... 0x7a + 0x10d (0x187)
// imports ... 4   (offset: 0x227)
// animtree1 . 0   (offset: 0x2d3)
// animtree2 . 0   (offset: 0x2d3)
#using scripts\common\callbacks;

#namespace boss_pops_asm;

// Namespace boss_pops_asm
// Params 0, eflags: 0x4
// Checksum 0x82904c44, Offset: 0x98
// Size: 0x21
function private function_69bc49ae1be3a626()
{
    level.scr_anim[ self.animname ][ "spawn" ] = "spawn";
}

// Namespace boss_pops_asm
// Params 3
// Checksum 0x9a64daaf, Offset: 0xc1
// Size: 0xa1
function function_21563b860ead0e69( asmname, statename, params )
{
    self.asm.footsteps = spawnstruct();
    self.asm.footsteps.foot = "invalid";
    self.asm.footsteps.time = 0;
    self.asm.customdata = spawnstruct();
    callback::add( "on_ai_init", &on_ai_init );
}

// Namespace boss_pops_asm
// Params 1, eflags: 0x4
// Checksum 0x997c0873, Offset: 0x16a
// Size: 0x1d
function private on_ai_init( params )
{
    callback::remove( "on_ai_init", &on_ai_init );
}

