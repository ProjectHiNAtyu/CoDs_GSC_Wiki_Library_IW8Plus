// script_1b7827fd8582e06b  (hash_1b7827fd8582e06b.gscc) (size: 1451 Bytes / 0x5ab / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4f4cf9e8 (1330444776)
// size ...... 1451 (0x5ab)
// includes .. 8   (offset: 0x4eb)
// strings ... 9   (offset: 0x52b)
// dev strs .. 0   (offset: 0x5ab)
// exports ... 4   (offset: 0x2d7)
// cseg ...... 0xfe + 0x1d9 (0x2d7)
// imports ... 13  (offset: 0x377)
// animtree1 . 0   (offset: 0x5ab)
// animtree2 . 0   (offset: 0x5ab)
#using script_2cd07641bf71242a;
#using script_4046370003980477;
#using script_5fbb037f63a7a8a1;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_loom_minion_asm;

// Namespace zombie_loom_minion_asm
// Params 0, eflags: 0x4
// Checksum 0xe842ca33, Offset: 0x11c
// Size: 0x85
function private function_f8cdf8e79ef07eb1()
{
    namespace_456e43ba4bdef145::function_7c1f29ee2fca907e();
    level.scr_anim[ self.animname ][ "spawn" ] = "spawn";
    level.scr_anim[ self.animname ][ "spawn_fast" ] = "spawn_fast";
    level.scr_anim[ self.animname ][ "disciple_injection_grabbed" ] = "disciple_injection_grabbed";
    level.scr_anim[ self.animname ][ "disciple_injection_grabbed_loop" ] = "disciple_injection_grabbed_loop";
}

// Namespace zombie_loom_minion_asm
// Params 3
// Checksum 0x7c21402c, Offset: 0x1a9
// Size: 0xf7
function function_8c30141cd5f1d75( asmname, statename, params )
{
    if ( self.var_cc3703385f725b39 )
    {
        return;
    }
    
    self.var_cc3703385f725b39 = 1;
    zombie_init::zombie_init_ai_asm( &function_f8cdf8e79ef07eb1 );
    self.asm.footsteps = spawnstruct();
    self.asm.footsteps.foot = "invalid";
    self.asm.footsteps.time = 0;
    self.asm.customdata = spawnstruct();
    asm::asm_setmoveplaybackrate( 1 );
    namespace_456e43ba4bdef145::init_zombie_loom_minion_move();
    zombie_leap_attack_asm::function_3d8cd69a5c5394a0( 64 );
    zombie_traverse_asm::init_zombie_traverse_asm();
    callback::add( "on_ai_init", &on_ai_init );
    utility::ent_flag_set( "zombie_asm_init_finished" );
}

// Namespace zombie_loom_minion_asm
// Params 1, eflags: 0x4
// Checksum 0x5d3b72c5, Offset: 0x2a8
// Size: 0x2f
function private on_ai_init( params )
{
    zombie_utils::function_a8ce00e0448cb6f0( "run", "aitype_default", 0 );
    callback::remove( "on_ai_init", &on_ai_init );
}

