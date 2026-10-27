// script_32afdce0bcb863d1  (hash_32afdce0bcb863d1.gscc) (size: 1739 Bytes / 0x6cb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf77023f (259457599)
// size ...... 1739 (0x6cb)
// includes .. 9   (offset: 0x5c3)
// strings ... 13  (offset: 0x60b)
// dev strs .. 0   (offset: 0x6cb)
// exports ... 4   (offset: 0x377)
// cseg ...... 0x119 + 0x25e (0x377)
// imports ... 15  (offset: 0x417)
// animtree1 . 0   (offset: 0x6cb)
// animtree2 . 0   (offset: 0x6cb)
#using script_2cd07641bf71242a;
#using script_359b0b3edb7487ee;
#using script_4f7d7bc345ea15d2;
#using script_96f7305c40cc74d;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_galileo_asm;

// Namespace zombie_galileo_asm
// Params 0, eflags: 0x4
// Checksum 0x807c7dc8, Offset: 0x137
// Size: 0x108
function private function_7db8204263687cfe()
{
    namespace_c1b8689546c46bf1::function_6dd40c049ad344c0();
    namespace_1ce9f4c8d67c396e::function_d0eff41dd77b3b53();
    level.scr_anim[ self.animname ][ "spawn" ] = "spawn";
    level.scr_anim[ self.animname ][ "deploy_drones" ] = "deploy_drones";
    level.scr_anim[ self.animname ][ "combat_engaged" ] = "combat_engaged";
    level.scr_anim[ self.animname ][ "combat_exit" ] = "combat_exit";
    level.scr_anim[ self.animname ][ "teleport" ] = "teleport";
    level.scr_anim[ self.animname ][ "shield_broken" ] = "shield_broken";
    level.scr_anim[ self.animname ][ "power_up" ] = "power_up";
    level.scr_anim[ self.animname ][ "power_down" ] = "power_down";
}

// Namespace zombie_galileo_asm
// Params 3
// Checksum 0x155916ba, Offset: 0x247
// Size: 0xf9
function function_beddf72430c0f9c3( asmname, statename, params )
{
    if ( self.var_cc3703385f725b39 )
    {
        return;
    }
    
    self.var_cc3703385f725b39 = 1;
    zombie_init::zombie_init_ai_asm( &function_7db8204263687cfe );
    self.asm.footsteps = spawnstruct();
    self.asm.footsteps.foot = "invalid";
    self.asm.footsteps.time = 0;
    self.asm.customdata = spawnstruct();
    asm::asm_setmoveplaybackrate( 1 );
    namespace_1ce9f4c8d67c396e::init_zombie_galileo_move();
    namespace_c1b8689546c46bf1::init_zombie_galileo_melee();
    zombie_ranged_attack_asm::init_ranged_attack_asm();
    zombie_traverse_asm::init_zombie_traverse_asm();
    callback::add( "on_ai_init", &on_ai_init );
    utility::ent_flag_set( "zombie_asm_init_finished" );
}

// Namespace zombie_galileo_asm
// Params 1, eflags: 0x4
// Checksum 0xad09f532, Offset: 0x348
// Size: 0x2f
function private on_ai_init( params )
{
    zombie_utils::function_a8ce00e0448cb6f0( "walk", "aitype_default", 0 );
    callback::remove( "on_ai_init", &on_ai_init );
}

