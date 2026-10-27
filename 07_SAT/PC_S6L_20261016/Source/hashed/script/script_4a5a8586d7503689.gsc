// script_4a5a8586d7503689  (hash_4a5a8586d7503689.gscc) (size: 2160 Bytes / 0x870 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2b9e5584 (731796868)
// size ...... 2160 (0x870)
// includes .. 11  (offset: 0x73c)
// strings ... 15  (offset: 0x794)
// dev strs .. 0   (offset: 0x870)
// exports ... 5   (offset: 0x438)
// cseg ...... 0x14a + 0x2ee (0x438)
// imports ... 20  (offset: 0x500)
// animtree1 . 0   (offset: 0x870)
// animtree2 . 0   (offset: 0x870)
#using script_1336e8b6e220bbfa;
#using script_23b580b08abe064f;
#using script_2cd07641bf71242a;
#using script_359b0b3edb7487ee;
#using script_3fe2c7524c8d3505;
#using script_56e851046f535a9a;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_hellhound_asm;

// Namespace zombie_hellhound_asm
// Params 0, eflags: 0x4
// Checksum 0xa24a6332, Offset: 0x168
// Size: 0x128
function private function_cfbb84b3d7bc65b8()
{
    namespace_ed4c2a26601f5317::register_melee_variant();
    namespace_6d185782b9282850::register_move_variant();
    callback::get_template( self.animsetname ) callback::add( "on_move_speed_changed", &on_move_speed_changed );
    level.scr_anim[ self.animname ][ "spawn" ] = "spawn";
    level.scr_anim[ self.animname ][ "dig" ] = "dig";
    level.scr_anim[ self.animname ][ "drop" ] = "drop";
    level.scr_anim[ self.animname ][ "spawn_ground" ] = "spawn_ground";
    level.scr_anim[ self.animname ][ "howl" ] = "howl";
    level.scr_anim[ self.animname ][ "spawn_fast" ] = "spawn";
    level.scr_anim[ self.animname ][ "disciple_injection_grabbed" ] = "disciple_injection_grabbed";
    level.scr_anim[ self.animname ][ "disciple_injection_grabbed_loop" ] = "disciple_injection_grabbed_loop";
}

// Namespace zombie_hellhound_asm
// Params 3
// Checksum 0xa774ac4, Offset: 0x298
// Size: 0x107
function function_cc6153da512d645( asmname, statename, params )
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
    namespace_ed4c2a26601f5317::function_a887d53ac5484b73();
    namespace_6d185782b9282850::init_zombie_hellhound_move();
    zombie_traverse_asm::init_zombie_traverse_asm();
    namespace_5e5380f1b9942207::function_4e89ce88f65464e3();
    zombie_hellhound_pet_asm::init_zombie_hellhound_pet();
    zombie_ranged_attack_asm::init_ranged_attack_asm();
    callback::add( "on_ai_init", &on_ai_init );
    utility::ent_flag_set( "zombie_asm_init_finished" );
}

// Namespace zombie_hellhound_asm
// Params 1, eflags: 0x4
// Checksum 0xa98756d, Offset: 0x3a7
// Size: 0x7d
function private on_ai_init( params )
{
    if ( self._blackboard.var_e9288b4c21f355a9 >= ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_6baf80f51bf165e3 ?? 1 ) )
    {
        zombie_utils::function_a8ce00e0448cb6f0( "run", "aitype_default", 0 );
    }
    else
    {
        zombie_utils::function_a8ce00e0448cb6f0( "run_slow", "aitype_default", 0 );
    }
    
    callback::remove( "on_ai_init", &on_ai_init );
}

// Namespace zombie_hellhound_asm
// Params 1, eflags: 0x4
// Checksum 0x79df2848, Offset: 0x42c
// Size: 0xc
function private on_move_speed_changed( params )
{
    
}

