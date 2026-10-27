// scripts\asm\zombie_base\zombie_base_asm.gsc  (hash_3e697e1d89438f5f.gscc) (size: 5221 Bytes / 0x1465 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4a82f51f (1250096415)
// size ...... 5221 (0x1465)
// includes .. 13  (offset: 0x10bd)
// strings ... 54  (offset: 0x1125)
// dev strs .. 0   (offset: 0x1465)
// exports ... 6   (offset: 0xcb1)
// cseg ...... 0x504 + 0x7ad (0xcb1)
// imports ... 28  (offset: 0xda1)
// animtree1 . 0   (offset: 0x1465)
// animtree2 . 0   (offset: 0x1465)
#using script_26bf705f44166c60;
#using script_2cd07641bf71242a;
#using script_359b0b3edb7487ee;
#using script_386dce0c73a2fdd4;
#using script_55418e45f89bc1e0;
#using script_608f661d4a9f5279;
#using script_66f322ebddc9485b;
#using script_78ded6cdfff8b056;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_base_asm;

// Namespace zombie_base_asm
// Params 0, eflags: 0x4
// Checksum 0xb79b06d1, Offset: 0x522
// Size: 0x5d7
function private function_cfbb84b3d7bc65b8()
{
    namespace_cea28acaed2cadc3::init_traverse_global();
    namespace_9d5bb15c1f6db1c5::init_pain_global();
    namespace_4de6ef4948d8552c::function_8bc82ab7848e6db();
    namespace_e0174a7eeed30023::init_melee_global();
    namespace_9f5c84ee2daca21b::init_idle_global();
    callback::get_template( self.animsetname ) callback::add( "on_move_speed_changed", &on_move_speed_changed );
    level.scr_anim[ self.animname ][ "spawn" ] = "spawn";
    level.scr_anim[ self.animname ][ "spawn_hop" ] = "spawn_hop";
    level.scr_anim[ self.animname ][ "spawn_portal" ] = "spawn_portal";
    level.scr_anim[ self.animname ][ "spawn_pop" ] = "spawn_pop";
    level.scr_anim[ self.animname ][ "spawn_barrel_44" ] = "spawn_barrel_44";
    level.scr_anim[ self.animname ][ "spawn_barrel_48" ] = "spawn_barrel_48";
    level.scr_anim[ self.animname ][ "spawn_ceiling_112" ] = "spawn_ceiling_112";
    level.scr_anim[ self.animname ][ "spawn_ceiling_144" ] = "spawn_ceiling_144";
    level.scr_anim[ self.animname ][ "spawn_container_36" ] = "spawn_container_36";
    level.scr_anim[ self.animname ][ "spawn_container_4" ] = "spawn_container_44";
    level.scr_anim[ self.animname ][ "spawn_fireplace" ] = "spawn_fireplace";
    level.scr_anim[ self.animname ][ "spawn_fast" ] = "spawn_fast";
    level.scr_anim[ self.animname ][ "spawn_wall" ] = "spawn_wall";
    level.scr_anim[ self.animname ][ "spawn_trashbin" ] = "spawn_trashbin";
    level.scr_anim[ self.animname ][ "spawn_under_bed" ] = "spawn_under_bed";
    level.scr_anim[ self.animname ][ "spawn_under_bed_lower" ] = "spawn_under_bed_lower";
    level.scr_anim[ self.animname ][ "spawn_abom_crawler" ] = "spawn_abom_crawler";
    level.scr_anim[ self.animname ][ "spawn_bank_window_up_92_1" ] = "spawn_bank_window_up_92_1";
    level.scr_anim[ self.animname ][ "spawn_bank_window_up_92_2" ] = "spawn_bank_window_up_92_2";
    level.scr_anim[ self.animname ][ "spawn_bank_window_up_94_1" ] = "spawn_bank_window_up_94_1";
    level.scr_anim[ self.animname ][ "spawn_bank_window_up_94_2" ] = "spawn_bank_window_up_94_2";
    level.scr_anim[ self.animname ][ "nest_crawler_idle" ] = "nest_crawler_idle";
    level.scr_anim[ self.animname ][ "nest_crawler_idle_two_drop_01" ] = "nest_crawler_idle_two_drop_01";
    level.scr_anim[ self.animname ][ "nest_crawler_idle_two_drop_02" ] = "nest_crawler_idle_two_drop_02";
    level.scr_anim[ self.animname ][ "spawn_nest_crawler_single" ] = "spawn_nest_crawler_single";
    level.scr_anim[ self.animname ][ "spawn_nest_crawler_double_01" ] = "spawn_nest_crawler_double_01";
    level.scr_anim[ self.animname ][ "spawn_nest_crawler_double_02" ] = "spawn_nest_crawler_double_02";
    level.scr_anim[ self.animname ][ "humangun_turn_from" ] = "humangun_turn_from";
    level.scr_anim[ self.animname ][ "humangun_turn_into" ] = "humangun_turn_into";
    level.scr_anim[ self.animname ][ "humangun_turned_death_outro" ] = "humangun_turned_death_outro";
    level.scr_anim[ self.animname ][ "falling" ] = "falling";
    level.scr_anim[ self.animname ][ "jump_across_128" ] = "jump_across_128";
    level.scr_anim[ self.animname ][ "brainrot_bloat" ] = "brainrot_bloat";
    level.scr_anim[ self.animname ][ "spawn_crawlout" ] = "spawn_crawlout";
    level.scr_anim[ self.animname ][ "spawn_crawlout_slide" ] = "spawn_crawlout_slide";
    level.scr_anim[ self.animname ][ "spawn_crawlout_fast_and_slow" ] = "spawn_crawlout_fast_and_slow";
    level.scr_anim[ self.animname ][ "spawn_crawlout_slow" ] = "spawn_crawlout_slow";
    level.scr_anim[ self.animname ][ "spawn_crawlout_fast" ] = "spawn_crawlout_fast";
    level.scr_anim[ self.animname ][ "spawn_crawlout_fast_belly_down" ] = "spawn_crawlout_fast_belly_down";
    level.scr_anim[ self.animname ][ "spawn_shipwreck_hole_01" ] = "spawn_shipwreck_hole_01";
    level.scr_anim[ self.animname ][ "spawn_shipwreck_hole_02" ] = "spawn_shipwreck_hole_02";
    level.scr_anim[ self.animname ][ "dance" ] = "dance";
    level.scr_anim[ self.animname ][ "disciple_injection_grabbed" ] = "disciple_injection_grabbed";
    level.scr_anim[ self.animname ][ "disciple_injection_grabbed_loop" ] = "disciple_injection_grabbed_loop";
    level.scr_anim[ self.animname ][ "firestorm_tornado_spin" ] = "firestorm_tornado_spin";
    level.scr_anim[ self.animname ][ "scarab_cyclone_spin" ] = "scarab_cyclone_spin";
}

// Namespace zombie_base_asm
// Params 3
// Checksum 0xd76f31f4, Offset: 0xb01
// Size: 0x115
function function_5e925bf657d963a( asmname, statename, params )
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
    namespace_e0174a7eeed30023::function_a887d53ac5484b73();
    namespace_4de6ef4948d8552c::init_zombie_base_move();
    zombie_traverse_asm::init_zombie_traverse_asm();
    namespace_9d5bb15c1f6db1c5::init_pain();
    namespace_cea28acaed2cadc3::function_4e89ce88f65464e3();
    zombie_ranged_attack_asm::init_ranged_attack_asm();
    namespace_7b1c2d73686554c8::function_7a6a165095e8e0e7();
    set_facial_variant();
    callback::add( "on_ai_init", &on_ai_init );
    utility::ent_flag_set( "zombie_asm_init_finished" );
}

// Namespace zombie_base_asm
// Params 1, eflags: 0x4
// Checksum 0xf910e9db, Offset: 0xc1e
// Size: 0x2f
function private on_ai_init( params )
{
    zombie_utils::function_a8ce00e0448cb6f0( "walk", "aitype_default", 0 );
    callback::remove( "on_ai_init", &on_ai_init );
}

// Namespace zombie_base_asm
// Params 1, eflags: 0x4
// Checksum 0xe0f733bd, Offset: 0xc55
// Size: 0x32
function private on_move_speed_changed( params )
{
    self._blackboard.var_a8b455f4d28765d = utility::array_random( [ 1, 0 ] );
}

// Namespace zombie_base_asm
// Params 0, eflags: 0x4
// Checksum 0xcfae505e, Offset: 0xc8f
// Size: 0x22
function private set_facial_variant()
{
    if ( self tagexists( "j_brow_le_2" ) )
    {
        self setfacialvariantindex( 2 );
        return;
    }
    
    self setfacialvariantindex( 1 );
}

