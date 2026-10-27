// scripts\asm\zombie_disciple\zombie_disciple_asm.gsc  (hash_59c7d01d8fe455f7.gscc) (size: 2468 Bytes / 0x9a4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6ea92299 (1856578201)
// size ...... 2468 (0x9a4)
// includes .. 13  (offset: 0x894)
// strings ... 13  (offset: 0x8fc)
// dev strs .. 0   (offset: 0x9a4)
// exports ... 8   (offset: 0x400)
// cseg ...... 0x10d + 0x2f3 (0x400)
// imports ... 30  (offset: 0x540)
// animtree1 . 0   (offset: 0x9a4)
// animtree2 . 0   (offset: 0x9a4)
#using script_2cd07641bf71242a;
#using script_3e4f26df9dc4b465;
#using script_4d5690421d14cda9;
#using script_4fa22bc28608e9bd;
#using script_63647a1499c0ba49;
#using script_7729cb692e91498a;
#using scripts\asm\asm;
#using scripts\asm\shared\utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\shared\zombie\zombie_wander;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_disciple_asm;

// Namespace zombie_disciple_asm
// Params 0, eflags: 0x4
// Checksum 0x97039174, Offset: 0x12b
// Size: 0x7c
function private function_cfbb84b3d7bc65b8()
{
    namespace_5b988172ec655354::function_9461e7d5fe219c8f();
    namespace_d4e7a14ee55bd048::function_475849a0c68c6e47();
    namespace_6825c954c0756ce0::function_63f5a985c0b6a5bb();
    namespace_f2cf5f122ca519c4::function_b1296c984f82ea69();
    level.scr_anim[ self.animname ][ "spawn" ] = "spawn";
    level.scr_anim[ self.animname ][ "spawn_fast" ] = "spawn_fast";
    callback::get_template( self.animsetname ) callback::add( "on_move_speed_changed", &on_move_speed_changed );
}

// Namespace zombie_disciple_asm
// Params 3
// Checksum 0x89716444, Offset: 0x1af
// Size: 0x10e
function function_93a92cb56526c031( asmname, statename, params )
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
    thread zombie_wander::wander_listener();
    zombie_traverse_asm::init_zombie_traverse_asm();
    namespace_5b988172ec655354::init_zombie_disciple_life_drain();
    namespace_d4e7a14ee55bd048::init_zombie_disciple_bind();
    namespace_6825c954c0756ce0::init_zombie_disciple_summon();
    namespace_f2cf5f122ca519c4::function_bbf58926498fae95();
    namespace_a081b0c1b6e9c2c7::init_zombie_disciple_scream_attack();
    callback::add( "on_ai_init", &on_ai_init );
    utility::ent_flag_set( "zombie_asm_init_finished" );
}

// Namespace zombie_disciple_asm
// Params 1, eflags: 0x4
// Checksum 0x6137a70c, Offset: 0x2c5
// Size: 0x2f
function private on_ai_init( params )
{
    zombie_utils::function_a8ce00e0448cb6f0( "run", "aitype_default", 0 );
    callback::remove( "on_ai_init", &on_ai_init );
}

// Namespace zombie_disciple_asm
// Params 1
// Checksum 0xb2e38a11, Offset: 0x2fc
// Size: 0x1a
function on_move_speed_changed( params )
{
    self.var_cdf48282bb6d1237 = self aigetdesiredspeed();
}

// Namespace zombie_disciple_asm
// Params 3
// Checksum 0xcaf7d8e1, Offset: 0x31e
// Size: 0x63
function choosedeathanim( asmname, statename, params )
{
    alias = "death";
    
    if ( issubstr( self.subclass, "skoll" ) )
    {
        alias += "_skoll";
    }
    
    deathanim = asm::asm_lookupanimfromalias( statename, alias );
    return deathanim;
}

// Namespace zombie_disciple_asm
// Params 3
// Checksum 0xf2f649a0, Offset: 0x38a
// Size: 0x3e
function playdeathanim( asmname, statename, params )
{
    self animmode( "gravity" );
    self animmode( "angle deltas" );
    utility::playanim( asmname, statename );
}

// Namespace zombie_disciple_asm
// Params 3
// Checksum 0x519084d9, Offset: 0x3d0
// Size: 0x30
function function_3c87a8704927a1eb( asmname, statename, params )
{
    thread namespace_f2cf5f122ca519c4::zombie_disciple_force_evolution_loop();
    asm::asm_playanimstate( asmname, statename, params );
}

