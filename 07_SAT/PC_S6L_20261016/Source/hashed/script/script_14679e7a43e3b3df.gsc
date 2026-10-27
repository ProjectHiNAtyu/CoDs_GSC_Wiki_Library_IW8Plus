// script_14679e7a43e3b3df  (hash_14679e7a43e3b3df.gscc) (size: 1628 Bytes / 0x65c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9512a1e0 (2501026272)
// size ...... 1628 (0x65c)
// includes .. 8   (offset: 0x56c)
// strings ... 12  (offset: 0x5ac)
// dev strs .. 0   (offset: 0x65c)
// exports ... 4   (offset: 0x358)
// cseg ...... 0x127 + 0x231 (0x358)
// imports ... 13  (offset: 0x3f8)
// animtree1 . 0   (offset: 0x65c)
// animtree2 . 0   (offset: 0x65c)
#using script_1301524c1c5465db;
#using script_2cd07641bf71242a;
#using script_6b518f9d5a2dd127;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_vermin_asm;

// Namespace zombie_vermin_asm
// Params 0, eflags: 0x4
// Checksum 0xe1b79dfc, Offset: 0x145
// Size: 0xe2
function private function_b6861f92da3ebf0c()
{
    namespace_f8183ce4e15db3da::function_b1c1009e68f9b112();
    level.scr_anim[ self.animname ][ "spawn" ] = "spawn";
    level.scr_anim[ self.animname ][ "spawn_fast" ] = "spawn_fast";
    level.scr_anim[ self.animname ][ "spawn_wall" ] = "spawn_wall";
    level.scr_anim[ self.animname ][ "spawn_standing_emergence" ] = "spawn_standing_emergence";
    level.scr_anim[ self.animname ][ "spawn_collapsing_emergence" ] = "spawn_collapsing_emergence";
    level.scr_anim[ self.animname ][ "scare_jump_01" ] = "scare_jump_01";
    level.scr_anim[ self.animname ][ "scare_jump_02" ] = "scare_jump_02";
}

// Namespace zombie_vermin_asm
// Params 3
// Checksum 0xcf6daf3b, Offset: 0x22f
// Size: 0xf2
function function_c27b70c619647d79( asmname, statename, params )
{
    if ( self.var_cc3703385f725b39 )
    {
        return;
    }
    
    self.var_cc3703385f725b39 = 1;
    namespace_7e98bc5e3517bf83::zombie_init_ai_asm( &function_b6861f92da3ebf0c );
    self.asm.footsteps = spawnstruct();
    self.asm.footsteps.foot = "invalid";
    self.asm.footsteps.time = 0;
    self.asm.customdata = spawnstruct();
    asm::asm_setmoveplaybackrate( 1 );
    namespace_f8183ce4e15db3da::init_zombie_vermin_move();
    namespace_c05812b5323b8226::init_zombie_vermin_leap_attack();
    zombie_traverse_asm::init_zombie_traverse_asm();
    callback::add( "on_ai_init", &on_ai_init );
    utility::ent_flag_set( "zombie_asm_init_finished" );
}

// Namespace zombie_vermin_asm
// Params 1, eflags: 0x4
// Checksum 0x21738b1, Offset: 0x329
// Size: 0x2f
function private on_ai_init( params )
{
    zombie_utils::function_a8ce00e0448cb6f0( "run", "aitype_default", 0 );
    callback::remove( "on_ai_init", &on_ai_init );
}

