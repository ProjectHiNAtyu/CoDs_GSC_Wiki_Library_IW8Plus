// scripts\asm\zombie_abom\zombie_abom_asm.gsc  (hash_6a1593331aebf847.gscc) (size: 1397 Bytes / 0x575 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x18a32e25 (413347365)
// size ...... 1397 (0x575)
// includes .. 10  (offset: 0x4e5)
// strings ... 5   (offset: 0x535)
// dev strs .. 0   (offset: 0x575)
// exports ... 5   (offset: 0x239)
// cseg ...... 0xa6 + 0x193 (0x239)
// imports ... 17  (offset: 0x301)
// animtree1 . 0   (offset: 0x575)
// animtree2 . 0   (offset: 0x575)
#using script_13d927d1fbe8598c;
#using script_25a541cdebf5c6ce;
#using script_2cd07641bf71242a;
#using script_3b7ffa11ee92fc3;
#using script_4e131720d70aa378;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_abom_asm;

// Namespace zombie_abom_asm
// Params 2
// Checksum 0xac5a5f97, Offset: 0xc4
// Size: 0x1e
function precache( classname, aitypescriptbundle )
{
    namespace_ce58d65bf2615c99::function_c3efc774d7b1d266( aitypescriptbundle );
}

// Namespace zombie_abom_asm
// Params 0, eflags: 0x4
// Checksum 0x193d7921, Offset: 0xea
// Size: 0x10
function private function_cfbb84b3d7bc65b8()
{
    namespace_727d0e47a23f487a::register_move_variant();
    namespace_727d0e47a23f487a::function_fabff9bb707db7b5();
}

// Namespace zombie_abom_asm
// Params 3
// Checksum 0x599b5fe0, Offset: 0x102
// Size: 0x100
function function_9bcfe8897caa468d( asmname, statename, params )
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
    namespace_727d0e47a23f487a::init_zombie_abom_move();
    namespace_de55c573adee23bd::init_zombie_abom_melee();
    namespace_a572abe18fc0aa97::init_zombie_abom_bull_charge();
    namespace_ce58d65bf2615c99::init_zombie_abom_beam_attack();
    zombie_traverse_asm::init_zombie_traverse_asm();
    callback::add( "on_ai_init", &on_ai_init );
    utility::ent_flag_set( "zombie_asm_init_finished" );
}

// Namespace zombie_abom_asm
// Params 1, eflags: 0x4
// Checksum 0x8d299c1f, Offset: 0x20a
// Size: 0x2f
function private on_ai_init( params )
{
    zombie_utils::function_a8ce00e0448cb6f0( "run", "aitype_default", 0 );
    callback::remove( "on_ai_init", &on_ai_init );
}

