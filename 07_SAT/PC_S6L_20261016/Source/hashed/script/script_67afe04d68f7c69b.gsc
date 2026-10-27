// script_67afe04d68f7c69b  (hash_67afe04d68f7c69b.gscc) (size: 2082 Bytes / 0x822 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc903b262 (3372462690)
// size ...... 2082 (0x822)
// includes .. 6   (offset: 0x72e)
// strings ... 14  (offset: 0x75e)
// dev strs .. 0   (offset: 0x822)
// exports ... 6   (offset: 0x43a)
// cseg ...... 0x108 + 0x332 (0x43a)
// imports ... 18  (offset: 0x52a)
// animtree1 . 0   (offset: 0x822)
// animtree2 . 0   (offset: 0x822)
#using script_177dfc9a7acea84c;
#using script_28903b44edf078c7;
#using script_3865eabfc59f0765;
#using scripts\asm\asm;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace dawg_asm;

// Namespace dawg_asm
// Params 0, eflags: 0x4
// Checksum 0x5bfe0cd3, Offset: 0x126
// Size: 0xea
function private function_3816177cd7f1739()
{
    dawg_pet_asm::dawg_init();
    namespace_aafbaa6bf95d91a9::register_move_variant();
    callback::get_template( self.animsetname ) callback::add( "on_move_speed_changed", &on_move_speed_changed );
    level.scr_anim[ self.animname ][ "spawn" ] = "spawn";
    level.scr_anim[ self.animname ][ "dig" ] = "dig";
    level.scr_anim[ self.animname ][ "drop" ] = "drop";
    level.scr_anim[ self.animname ][ "spawn_ground" ] = "spawn_ground";
    level.scr_anim[ self.animname ][ "howl" ] = "howl";
    level.scr_anim[ self.animname ][ "spawn_fast" ] = "spawn";
}

// Namespace dawg_asm
// Params 1, eflags: 0x4
// Checksum 0xa7d4c5a0, Offset: 0x218
// Size: 0x54
function private first_init_ai_asm( var_fd93314a0fb374d7 )
{
    archetype = self.animsetname;
    flag_name = archetype + "_init_asm";
    
    if ( utility::flag( flag_name ) )
    {
        return;
    }
    
    utility::flag_set( flag_name );
    
    if ( isdefined( var_fd93314a0fb374d7 ) )
    {
        self [[ var_fd93314a0fb374d7 ]]();
    }
}

// Namespace dawg_asm
// Params 3
// Checksum 0xa153b422, Offset: 0x274
// Size: 0xfd
function dawginit( asmname, statename, params )
{
    if ( self.var_ebd4d0e07a669e54 )
    {
        return;
    }
    
    self.var_ebd4d0e07a669e54 = 1;
    self.animname = self.animsetname;
    first_init_ai_asm( &function_3816177cd7f1739 );
    self.asm.footsteps = spawnstruct();
    self.asm.footsteps.foot = "invalid";
    self.asm.footsteps.time = 0;
    self.asm.customdata = spawnstruct();
    asm::function_d82cb83c9c260d49( 1 );
    namespace_aafbaa6bf95d91a9::init_dawg_move();
    namespace_f39cfc607cb105c2::function_4e89ce88f65464e3();
    callback::add( "on_ai_init", &on_ai_init );
    utility::ent_flag_set( "dawg_asm_init_finished" );
}

// Namespace dawg_asm
// Params 1, eflags: 0x4
// Checksum 0x933fbd5f, Offset: 0x379
// Size: 0x1d
function private on_ai_init( params )
{
    callback::remove( "on_ai_init", &on_ai_init );
}

// Namespace dawg_asm
// Params 1, eflags: 0x4
// Checksum 0xbcbe4b52, Offset: 0x39e
// Size: 0x9c
function private on_move_speed_changed( params )
{
    movetype = asm::asm_getdemeanor();
    animrate = 1;
    
    if ( movetype == "sprint" )
    {
        animrate = self.dawgaisettings.sprintanimrate;
    }
    else if ( movetype == "run" )
    {
        animrate = self.dawgaisettings.runanimrate;
    }
    else if ( movetype == "walk" )
    {
        animrate = self.dawgaisettings.walkanimrate;
    }
    
    asm::function_d82cb83c9c260d49( animrate );
}

