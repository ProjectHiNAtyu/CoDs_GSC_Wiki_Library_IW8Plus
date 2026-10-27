// script_2c49ffacfba1c673  (hash_2c49ffacfba1c673.gscc) (size: 1257 Bytes / 0x4e9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb6733718 (3061004056)
// size ...... 1257 (0x4e9)
// includes .. 10  (offset: 0x459)
// strings ... 5   (offset: 0x4a9)
// dev strs .. 0   (offset: 0x4e9)
// exports ... 4   (offset: 0x20d)
// cseg ...... 0xa7 + 0x166 (0x20d)
// imports ... 15  (offset: 0x2ad)
// animtree1 . 0   (offset: 0x4e9)
// animtree2 . 0   (offset: 0x4e9)
#using script_2cd07641bf71242a;
#using script_311d9b04cdffeb58;
#using script_33781ab60ef13663;
#using script_5fbb037f63a7a8a1;
#using script_66a7f9a9ef6a225f;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_karkinos_asm;

// Namespace zombie_karkinos_asm
// Params 0, eflags: 0x4
// Checksum 0x8136882c, Offset: 0xc5
// Size: 0x10
function private function_cfbb84b3d7bc65b8()
{
    namespace_5d23f6b6f9512991::register_move_variant();
    namespace_7e2991bc3f84c62a::function_b53ccf032ed6922f();
}

// Namespace zombie_karkinos_asm
// Params 3
// Checksum 0xef9d1a47, Offset: 0xdd
// Size: 0xf9
function function_578ab4484fe483c( asmname, statename, params )
{
    if ( self.var_cc3703385f725b39 )
    {
        return;
    }
    
    self.var_cc3703385f725b39 = 1;
    zombie_init::zombie_init_ai_asm( &function_cfbb84b3d7bc65b8 );
    zombie_leap_attack_asm::function_3d8cd69a5c5394a0();
    self.asm.footsteps = spawnstruct();
    self.asm.footsteps.foot = "invalid";
    self.asm.footsteps.time = 0;
    self.asm.customdata = spawnstruct();
    asm::asm_setmoveplaybackrate( 1 );
    namespace_1dae79e17ca61fd8::init_zombie_karkinos_melee();
    namespace_5d23f6b6f9512991::init_zombie_karkinos_move();
    zombie_traverse_asm::init_zombie_traverse_asm();
    callback::add( "on_ai_init", &on_ai_init );
    utility::ent_flag_set( "zombie_asm_init_finished" );
}

// Namespace zombie_karkinos_asm
// Params 1, eflags: 0x4
// Checksum 0xc0115025, Offset: 0x1de
// Size: 0x2f
function private on_ai_init( params )
{
    zombie_utils::function_a8ce00e0448cb6f0( "walk", "aitype_default", 0 );
    callback::remove( "on_ai_init", &on_ai_init );
}

