// script_101c433f9a28837  (hash_0101c433f9a28837.gscc) (size: 1405 Bytes / 0x57d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf90e8a79 (4178479737)
// size ...... 1405 (0x57d)
// includes .. 7   (offset: 0x4c5)
// strings ... 9   (offset: 0x4fd)
// dev strs .. 0   (offset: 0x57d)
// exports ... 4   (offset: 0x2b1)
// cseg ...... 0xdd + 0x1d4 (0x2b1)
// imports ... 13  (offset: 0x351)
// animtree1 . 0   (offset: 0x57d)
// animtree2 . 0   (offset: 0x57d)
#using script_2cd07641bf71242a;
#using script_ee229ad7da44d53;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_parasite_asm;

// Namespace zombie_parasite_asm
// Params 0, eflags: 0x4
// Checksum 0x7916d407, Offset: 0xfb
// Size: 0x8c
function private function_41179d6d1fe7fefa()
{
    namespace_4154dd0f3deedad4::function_cba7159554197958();
    namespace_4154dd0f3deedad4::function_d517b4a2bc50095b();
    level.scr_anim[ self.animname ][ "spawn" ] = "spawn";
    level.scr_anim[ self.animname ][ "spawn_wall" ] = "spawn_wall";
    level.scr_anim[ self.animname ][ "spawn_air" ] = "spawn_air";
    level.scr_anim[ self.animname ][ "spawn_emergence" ] = "spawn_emergence";
}

// Namespace zombie_parasite_asm
// Params 3
// Checksum 0x350419cd, Offset: 0x18f
// Size: 0xeb
function function_a4eccf64588c5f6b( asmname, statename, params )
{
    if ( self.var_cc3703385f725b39 )
    {
        return;
    }
    
    self.var_cc3703385f725b39 = 1;
    namespace_7e98bc5e3517bf83::zombie_init_ai_asm( &function_41179d6d1fe7fefa );
    self.asm.footsteps = spawnstruct();
    self.asm.footsteps.foot = "invalid";
    self.asm.footsteps.time = 0;
    self.asm.customdata = spawnstruct();
    asm::asm_setmoveplaybackrate( 1 );
    namespace_4154dd0f3deedad4::init_zombie_parasite_move();
    zombie_traverse_asm::init_zombie_traverse_asm();
    callback::add( "on_ai_init", &on_ai_init );
    utility::ent_flag_set( "zombie_asm_init_finished" );
}

// Namespace zombie_parasite_asm
// Params 1, eflags: 0x4
// Checksum 0x9206a058, Offset: 0x282
// Size: 0x2f
function private on_ai_init( params )
{
    zombie_utils::function_a8ce00e0448cb6f0( "run", "aitype_default", 0 );
    callback::remove( "on_ai_init", &on_ai_init );
}

