// script_266a29f99f6b0133  (hash_266a29f99f6b0133.gscc) (size: 670 Bytes / 0x29e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd4ac8e54 (3568078420)
// size ...... 670 (0x29e)
// includes .. 5   (offset: 0x26a)
// strings ... 1   (offset: 0x292)
// dev strs .. 0   (offset: 0x29e)
// exports ... 3   (offset: 0x112)
// cseg ...... 0x74 + 0x9e (0x112)
// imports ... 8   (offset: 0x18a)
// animtree1 . 0   (offset: 0x29e)
// animtree2 . 0   (offset: 0x29e)
#using script_5cf687c0317fe818;
#using script_a968e45d71a4e1f;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\utility;

#namespace ztron_papaback_asm;

// Namespace ztron_papaback_asm
// Params 0, eflags: 0x4
// Checksum 0x6b37169a, Offset: 0x92
// Size: 0x10
function private function_cfbb84b3d7bc65b8()
{
    namespace_31c251633dac8f25::register_move_variant();
    namespace_245308063ee5298c::register_melee_variant();
}

// Namespace ztron_papaback_asm
// Params 3
// Checksum 0x1e3ce8f4, Offset: 0xaa
// Size: 0x68
function function_c94fe648ad5b0806( asmname, statename, params )
{
    if ( self.var_cc3703385f725b39 )
    {
        return;
    }
    
    self.var_cc3703385f725b39 = 1;
    zombie_init::zombie_init_ai_asm( &function_cfbb84b3d7bc65b8 );
    asm::asm_setmoveplaybackrate( 1 );
    namespace_31c251633dac8f25::init_ztron_papaback_move();
    namespace_245308063ee5298c::init_ztron_papaback_melee();
    utility::ent_flag_set( "zombie_asm_init_finished" );
}

