// script_4587bd251caefd78  (hash_4587bd251caefd78.gscc) (size: 1092 Bytes / 0x444 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x97b132f0 (2544972528)
// size ...... 1092 (0x444)
// includes .. 7   (offset: 0x3cc)
// strings ... 5   (offset: 0x404)
// dev strs .. 0   (offset: 0x444)
// exports ... 4   (offset: 0x1f0)
// cseg ...... 0xa6 + 0x14a (0x1f0)
// imports ... 11  (offset: 0x290)
// animtree1 . 0   (offset: 0x444)
// animtree2 . 0   (offset: 0x444)
#using script_2cd07641bf71242a;
#using script_780a4ae7fab11b56;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_galileo_drone_asm;

// Namespace zombie_galileo_drone_asm
// Params 0, eflags: 0x4
// Checksum 0x58a17bc4, Offset: 0xc4
// Size: 0x9
function private function_c6d71513acb07c95()
{
    namespace_6d408b858fdc9ee1::init_zombie_galileo_drone_move();
}

// Namespace zombie_galileo_drone_asm
// Params 3
// Checksum 0x756c5092, Offset: 0xd5
// Size: 0xe4
function function_9f018855976702df( asmname, statename, params )
{
    if ( self.var_cc3703385f725b39 )
    {
        return;
    }
    
    self.var_cc3703385f725b39 = 1;
    zombie_init::zombie_init_ai_asm( &function_c6d71513acb07c95 );
    self.asm.footsteps = spawnstruct();
    self.asm.footsteps.foot = "invalid";
    self.asm.footsteps.time = 0;
    self.asm.customdata = spawnstruct();
    asm::asm_setmoveplaybackrate( 1 );
    zombie_traverse_asm::init_zombie_traverse_asm();
    callback::add( "on_ai_init", &on_ai_init );
    utility::ent_flag_set( "zombie_asm_init_finished" );
}

// Namespace zombie_galileo_drone_asm
// Params 1, eflags: 0x4
// Checksum 0x43710ef2, Offset: 0x1c1
// Size: 0x2f
function private on_ai_init( params )
{
    zombie_utils::function_a8ce00e0448cb6f0( "run", "aitype_default", 0 );
    callback::remove( "on_ai_init", &on_ai_init );
}

