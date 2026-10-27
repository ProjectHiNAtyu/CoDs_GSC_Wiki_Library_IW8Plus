// script_757c5556b557b97d  (hash_757c5556b557b97d.gscc) (size: 1691 Bytes / 0x69b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd406d3b3 (3557217203)
// size ...... 1691 (0x69b)
// includes .. 9   (offset: 0x5b3)
// strings ... 11  (offset: 0x5fb)
// dev strs .. 0   (offset: 0x69b)
// exports ... 4   (offset: 0x367)
// cseg ...... 0x147 + 0x220 (0x367)
// imports ... 15  (offset: 0x407)
// animtree1 . 0   (offset: 0x69b)
// animtree2 . 0   (offset: 0x69b)
#using script_2cd07641bf71242a;
#using script_359b0b3edb7487ee;
#using script_65058944addea649;
#using script_7e9448c78316ed34;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_shade_asm;

// Namespace zombie_shade_asm
// Params 0, eflags: 0x4
// Checksum 0xfd567070, Offset: 0x165
// Size: 0xca
function private function_b9893aed75d07b8e()
{
    namespace_d598cc4fc9febb8e::function_c808d3dbda1b17ff();
    namespace_8af0ba1beb6dc587::init_swipe_global();
    level.scr_anim[ self.animname ][ "spawn" ] = "spawn";
    level.scr_anim[ self.animname ][ "spawn_fast" ] = "spawn_fast";
    level.scr_anim[ self.animname ][ "disciple_injection_grabbed" ] = "disciple_injection_grabbed";
    level.scr_anim[ self.animname ][ "disciple_injection_grabbed_loop" ] = "disciple_injection_grabbed_loop";
    level.scr_anim[ self.animname ][ "disciple_injection_grabbed_alt" ] = "disciple_injection_grabbed_alt";
    level.scr_anim[ self.animname ][ "disciple_injection_grabbed_loop_alt" ] = "disciple_injection_grabbed_loop_alt";
}

// Namespace zombie_shade_asm
// Params 3
// Checksum 0x51b9d851, Offset: 0x237
// Size: 0xf9
function function_ba9c77c3543843ef( asmname, statename, params )
{
    if ( self.var_cc3703385f725b39 )
    {
        return;
    }
    
    self.var_cc3703385f725b39 = 1;
    zombie_init::zombie_init_ai_asm( &function_b9893aed75d07b8e );
    self.asm.footsteps = spawnstruct();
    self.asm.footsteps.foot = "invalid";
    self.asm.footsteps.time = 0;
    self.asm.customdata = spawnstruct();
    asm::asm_setmoveplaybackrate( 1 );
    zombie_traverse_asm::init_zombie_traverse_asm();
    namespace_8af0ba1beb6dc587::init_swipe();
    namespace_d598cc4fc9febb8e::init_zombie_shade_move();
    zombie_ranged_attack_asm::init_ranged_attack_asm();
    callback::add( "on_ai_init", &on_ai_init );
    utility::ent_flag_set( "zombie_asm_init_finished" );
}

// Namespace zombie_shade_asm
// Params 1, eflags: 0x4
// Checksum 0x18505b33, Offset: 0x338
// Size: 0x2f
function private on_ai_init( params )
{
    zombie_utils::function_a8ce00e0448cb6f0( "run", "aitype_default", 0 );
    callback::remove( "on_ai_init", &on_ai_init );
}

