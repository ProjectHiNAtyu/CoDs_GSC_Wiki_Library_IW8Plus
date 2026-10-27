// scripts\asm\zombie_callisto\zombie_callisto_asm.gsc  (hash_3fe1a64b5926144b.gscc) (size: 1625 Bytes / 0x659 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd8d1efb8 (3637637048)
// size ...... 1625 (0x659)
// includes .. 11  (offset: 0x5a1)
// strings ... 7   (offset: 0x5f9)
// dev strs .. 0   (offset: 0x659)
// exports ... 5   (offset: 0x2a1)
// cseg ...... 0xbd + 0x1e4 (0x2a1)
// imports ... 20  (offset: 0x369)
// animtree1 . 0   (offset: 0x659)
// animtree2 . 0   (offset: 0x659)
#using script_14b386d73d058eb8;
#using script_2cd07641bf71242a;
#using script_359b0b3edb7487ee;
#using script_4d3dfef7b417e476;
#using script_6390e8bc869949c0;
#using script_65b679adf331f917;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_callisto_asm;

// Namespace zombie_callisto_asm
// Params 2
// Checksum 0xd6229320, Offset: 0xdb
// Size: 0x15
function precache( classname, aitypescriptbundle )
{
    
}

// Namespace zombie_callisto_asm
// Params 0, eflags: 0x4
// Checksum 0xda5db9d, Offset: 0xf8
// Size: 0x63
function private function_cfbb84b3d7bc65b8()
{
    namespace_86e54fbc3f05670c::register_move_variant();
    namespace_cc86c045f1a79d83::register_melee_variant();
    namespace_86e54fbc3f05670c::function_8036d421ebeee5c7();
    namespace_cc86c045f1a79d83::function_c43078902ff61814();
    namespace_c03bf35905186301::function_f3e294e7b0c8a1b4();
    level.scr_anim[ self.animname ][ "spawn" ] = "spawn";
    level.scr_anim[ self.animname ][ "spawn_walk" ] = "spawn_walk";
}

// Namespace zombie_callisto_asm
// Params 3
// Checksum 0xb5b164d9, Offset: 0x163
// Size: 0x107
function function_b7a9383cfa4294b7( asmname, statename, params )
{
    if ( self.var_cc3703385f725b39 )
    {
        return;
    }
    
    self.var_cc3703385f725b39 = 1;
    zombie_init::zombie_init_ai_asm( &function_cfbb84b3d7bc65b8 );
    self.asm.footsteps = spawnstruct();
    self.asm.footsteps.foot = "invalid";
    self.asm.footsteps.time = 0;
    self.asm.customdata = spawnstruct();
    asm::asm_setmoveplaybackrate( 1 );
    namespace_86e54fbc3f05670c::init_zombie_callisto_move();
    namespace_cc86c045f1a79d83::init_zombie_callisto_melee();
    namespace_c03bf35905186301::init_zombie_callisto_charge();
    namespace_5a283ea68822d457::init_zombie_callisto_claw_attack();
    zombie_ranged_attack_asm::init_ranged_attack_asm();
    zombie_traverse_asm::init_zombie_traverse_asm();
    callback::add( "on_ai_init", &on_ai_init );
    utility::ent_flag_set( "zombie_asm_init_finished" );
}

// Namespace zombie_callisto_asm
// Params 1, eflags: 0x4
// Checksum 0x9b5cf432, Offset: 0x272
// Size: 0x2f
function private on_ai_init( params )
{
    zombie_utils::function_a8ce00e0448cb6f0( "run", "aitype_default", 0 );
    callback::remove( "on_ai_init", &on_ai_init );
}

