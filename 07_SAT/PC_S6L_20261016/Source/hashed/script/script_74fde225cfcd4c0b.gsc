// script_74fde225cfcd4c0b  (hash_74fde225cfcd4c0b.gscc) (size: 1226 Bytes / 0x4ca / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3108e79e (822667166)
// size ...... 1226 (0x4ca)
// includes .. 10  (offset: 0x43a)
// strings ... 4   (offset: 0x48a)
// dev strs .. 1   (offset: 0x4be)
// exports ... 5   (offset: 0x1ae)
// cseg ...... 0x9c + 0x112 (0x1ae)
// imports ... 16  (offset: 0x276)
// animtree1 . 0   (offset: 0x4ca)
// animtree2 . 0   (offset: 0x4ca)
#using script_1b934ce5a518748;
#using script_2bc77267b8616bd7;
#using script_31af9060592e982c;
#using script_6b56d7e66ae770bc;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\shared\zombie\zombie_wander;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;

#namespace zombie_phobos_asm;

// Namespace zombie_phobos_asm
// Params 0, eflags: 0x4
// Checksum 0xacbafd21, Offset: 0xba
// Size: 0x1a
function private function_ef1baed3c21a54e0()
{
    namespace_5d8c8e7c63b470d5::function_54867ff0ab30fc90();
    namespace_c0f9e550c4119589::function_6730a542a916ec66();
    
    /#
        init_zombie_phobos_devgui();
    #/
}

// Namespace zombie_phobos_asm
// Params 3
// Checksum 0xc4d122af, Offset: 0xdc
// Size: 0x7b
function function_c2c68cdfecacff49( asmname, statename, params )
{
    if ( self.var_cc3703385f725b39 )
    {
        return;
    }
    
    self.var_cc3703385f725b39 = 1;
    zombie_init::zombie_init_ai_asm( &function_ef1baed3c21a54e0 );
    thread zombie_wander::wander_listener();
    callback::add( "on_ai_init", &on_ai_init );
    namespace_4971355493d96d89::function_1adf760b26931d8a();
    zombie_phobos_move::init_zombie_phobos_move();
    namespace_c0f9e550c4119589::init_zombie_phobos_jumpout();
    utility::ent_flag_set( "zombie_asm_init_finished" );
}

// Namespace zombie_phobos_asm
// Params 1, eflags: 0x4
// Checksum 0x9995609, Offset: 0x15f
// Size: 0x2f
function private on_ai_init( params )
{
    zombie_utils::function_a8ce00e0448cb6f0( "walk", "aitype_default", 0 );
    callback::remove( "on_ai_init", &on_ai_init );
}

/#

    // Namespace zombie_phobos_asm
    // Params 0, eflags: 0x4
    // Checksum 0x666eb794, Offset: 0x196
    // Size: 0x18, Type: dev
    function private init_zombie_phobos_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_77df7fe7dd273e10();
    }

#/
