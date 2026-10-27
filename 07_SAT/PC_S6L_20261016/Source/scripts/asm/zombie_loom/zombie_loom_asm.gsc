// scripts\asm\zombie_loom\zombie_loom_asm.gsc  (hash_4cc0b2b69ae5e8b3.gscc) (size: 1270 Bytes / 0x4f6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x83e235ad (2212640173)
// size ...... 1270 (0x4f6)
// includes .. 7   (offset: 0x46e)
// strings ... 6   (offset: 0x4a6)
// dev strs .. 0   (offset: 0x4f6)
// exports ... 5   (offset: 0x24e)
// cseg ...... 0xaf + 0x19f (0x24e)
// imports ... 12  (offset: 0x316)
// animtree1 . 0   (offset: 0x4f6)
// animtree2 . 0   (offset: 0x4f6)
#using script_2cd07641bf71242a;
#using script_359b0b3edb7487ee;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_loom_asm;

// Namespace zombie_loom_asm
// Params 2
// Checksum 0xe7f3e084, Offset: 0xcd
// Size: 0x15
function precache( classname, aitypescriptbundle )
{
    
}

// Namespace zombie_loom_asm
// Params 0, eflags: 0x4
// Checksum 0x11a70cd5, Offset: 0xea
// Size: 0x21
function private function_cfbb84b3d7bc65b8()
{
    level.scr_anim[ self.animname ][ "spawn" ] = "spawn";
}

// Namespace zombie_loom_asm
// Params 3
// Checksum 0xcfc7f174, Offset: 0x113
// Size: 0x104
function function_b1c0bc59875b871b( asmname, statename, params )
{
    if ( self.var_cc3703385f725b39 )
    {
        return;
    }
    
    self.var_cc3703385f725b39 = 1;
    zombie_init::zombie_init_ai_asm( &function_cfbb84b3d7bc65b8 );
    zombie_ranged_attack_asm::init_ranged_attack_asm();
    self.asm.footsteps = spawnstruct();
    self.asm.footsteps.foot = "invalid";
    self.asm.footsteps.time = 0;
    self.asm.customdata = spawnstruct();
    asm::asm_setmoveplaybackrate( 1 );
    zombie_traverse_asm::init_zombie_traverse_asm();
    self.var_8f42fb436afef718 = &zombie_traverse_asm::function_f91a43bc37888ed3;
    self.var_b8a25dd1082321c8 = 1;
    callback::add( "on_ai_init", &on_ai_init );
    utility::ent_flag_set( "zombie_asm_init_finished" );
}

// Namespace zombie_loom_asm
// Params 1, eflags: 0x4
// Checksum 0xbd0e9344, Offset: 0x21f
// Size: 0x2f
function private on_ai_init( params )
{
    zombie_utils::function_a8ce00e0448cb6f0( "run", "aitype_default", 0 );
    callback::remove( "on_ai_init", &on_ai_init );
}

