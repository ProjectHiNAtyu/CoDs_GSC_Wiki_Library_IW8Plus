// script_235dc73aac9ee641  (hash_235dc73aac9ee641.gscc) (size: 1166 Bytes / 0x48e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9a5e2e84 (2589863556)
// size ...... 1166 (0x48e)
// includes .. 6   (offset: 0x3fe)
// strings ... 7   (offset: 0x42e)
// dev strs .. 0   (offset: 0x48e)
// exports ... 4   (offset: 0x23e)
// cseg ...... 0xbd + 0x181 (0x23e)
// imports ... 10  (offset: 0x2de)
// animtree1 . 0   (offset: 0x48e)
// animtree2 . 0   (offset: 0x48e)
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\shared\zombie\zombie_wander;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_boss_virgil_asm;

// Namespace zombie_boss_virgil_asm
// Params 0, eflags: 0x4
// Checksum 0x86d42ea3, Offset: 0xdb
// Size: 0x40
function private function_7198bda0f5479fd6()
{
    level.scr_anim[ self.animname ][ "spawn" ] = "spawn";
    level.scr_anim[ self.animname ][ "spawn_fast" ] = "spawn_fast";
}

// Namespace zombie_boss_virgil_asm
// Params 3
// Checksum 0x48ed16d3, Offset: 0x123
// Size: 0xe4
function function_a4ec5bc6cd9af548( asmname, statename, params )
{
    if ( self.var_cc3703385f725b39 )
    {
        return;
    }
    
    self.var_cc3703385f725b39 = 1;
    zombie_init::zombie_init_ai_asm( &function_7198bda0f5479fd6 );
    self.asm.footsteps = spawnstruct();
    self.asm.footsteps.foot = "invalid";
    self.asm.footsteps.time = 0;
    self.asm.customdata = spawnstruct();
    asm::asm_setmoveplaybackrate( 1 );
    thread zombie_wander::function_c77a8eaa38883b1c();
    callback::add( "on_ai_init", &on_ai_init );
    utility::ent_flag_set( "zombie_asm_init_finished" );
}

// Namespace zombie_boss_virgil_asm
// Params 1, eflags: 0x4
// Checksum 0x83c51f1d, Offset: 0x20f
// Size: 0x2f
function private on_ai_init( params )
{
    zombie_utils::function_a8ce00e0448cb6f0( "run", "aitype_default", 0 );
    callback::remove( "on_ai_init", &on_ai_init );
}

