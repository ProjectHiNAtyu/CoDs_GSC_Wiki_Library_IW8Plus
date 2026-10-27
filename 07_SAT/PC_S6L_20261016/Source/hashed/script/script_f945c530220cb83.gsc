// script_f945c530220cb83  (hash_0f945c530220cb83.gscc) (size: 1320 Bytes / 0x528 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7ff50c11 (2146765841)
// size ...... 1320 (0x528)
// includes .. 10  (offset: 0x48c)
// strings ... 6   (offset: 0x4dc)
// dev strs .. 0   (offset: 0x528)
// exports ... 4   (offset: 0x224)
// cseg ...... 0xb2 + 0x172 (0x224)
// imports ... 16  (offset: 0x2c4)
// animtree1 . 0   (offset: 0x528)
// animtree2 . 0   (offset: 0x528)
#using script_2cd07641bf71242a;
#using script_359b0b3edb7487ee;
#using script_612247297c9694c8;
#using script_769dd81873f99e4f;
#using scripts\asm\asm;
#using scripts\asm\shared\variant_asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_amalgam_asm;

// Namespace zombie_amalgam_asm
// Params 0, eflags: 0x4
// Checksum 0x1e542afc, Offset: 0xd0
// Size: 0x10
function private function_cfbb84b3d7bc65b8()
{
    namespace_a60ccad3ba8b2b4f::function_8bf5e3edf86ea58d();
    namespace_14bc21a938ce7ab8::function_59a7855b0081fa78();
}

// Namespace zombie_amalgam_asm
// Params 3
// Checksum 0xc76fa598, Offset: 0xe8
// Size: 0x105
function function_81aa6d5dd7d092d8( asmname, statename, params )
{
    if ( self.var_cc3703385f725b39 )
    {
        return;
    }
    
    self.var_cc3703385f725b39 = 1;
    namespace_7e98bc5e3517bf83::zombie_init_ai_asm( &function_cfbb84b3d7bc65b8 );
    self.asm.footsteps = spawnstruct();
    self.asm.footsteps.foot = "invalid";
    self.asm.footsteps.time = 0;
    self.asm.customdata = spawnstruct();
    asm::asm_setmoveplaybackrate( 1 );
    namespace_ef0cd975820ec3b::function_1e9b4a2fe400d128( "melee" );
    namespace_14bc21a938ce7ab8::init_zombie_amalgam_move();
    namespace_a60ccad3ba8b2b4f::init_zombie_amalgam_melee();
    zombie_ranged_attack_asm::init_ranged_attack_asm();
    zombie_traverse_asm::init_zombie_traverse_asm();
    callback::add( "on_ai_init", &on_ai_init );
    utility::ent_flag_set( "zombie_asm_init_finished" );
}

// Namespace zombie_amalgam_asm
// Params 1, eflags: 0x4
// Checksum 0xe78552c9, Offset: 0x1f5
// Size: 0x2f
function private on_ai_init( params )
{
    zombie_utils::function_a8ce00e0448cb6f0( "sprint", "aitype_default", 0 );
    callback::remove( "on_ai_init", &on_ai_init );
}

