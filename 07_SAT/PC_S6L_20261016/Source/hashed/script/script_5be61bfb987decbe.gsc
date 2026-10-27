// script_5be61bfb987decbe  (hash_5be61bfb987decbe.gscc) (size: 3270 Bytes / 0xcc6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4701408b (1191264395)
// size ...... 3270 (0xcc6)
// includes .. 8   (offset: 0xb96)
// strings ... 6   (offset: 0xbd6)
// dev strs .. 14  (offset: 0xc1e)
// exports ... 14  (offset: 0x4f6)
// cseg ...... 0xe9 + 0x40d (0x4f6)
// imports ... 39  (offset: 0x726)
// animtree1 . 0   (offset: 0xcc6)
// animtree2 . 0   (offset: 0xcc6)
#using script_1eeb27472f818925;
#using script_35efc59124dbb5db;
#using script_6f175ab567ad9495;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;

#namespace namespace_b059317c43d6d0fe;

// Namespace namespace_b059317c43d6d0fe
// Params 0, eflags: 0x5
// Checksum 0x56177a17, Offset: 0x107
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_fceafdb93947e902", undefined, undefined, &init );
}

// Namespace namespace_b059317c43d6d0fe
// Params 0
// Checksum 0x5495f6a3, Offset: 0x128
// Size: 0xbd
function init()
{
    if ( level.mapname != "zm_sat_mantis" || getdvarint( @"hash_bb4d4e9d5661c0f9", 1 ) == 0 )
    {
        return;
    }
    
    level utility::flag_wait( "zm_quest_initialized" );
    register_quest_steps();
    level utility::flag_wait_all( "scriptables_ready", "destructibles_ready", "subclass_to_aitype_map_initialized" );
    level utility::registersharedfunc( #"zm_quest", #"hash_26021a109fbc8bae", &is_quest_complete );
    level.var_ebfb26f91bd45893 = zm_quest::get_quest( #"hash_fceafdb93947e902" );
    init_quest_steps();
    
    /#
        init_dev_commands();
    #/
    
    level zm_save::function_1f44a48caae2acbf();
    level thread zm_quest::start_quest( #"hash_fceafdb93947e902" );
    thread function_4e7e6dd52c2e7070();
}

// Namespace namespace_b059317c43d6d0fe
// Params 0
// Checksum 0xb0aff324, Offset: 0x1ed
// Size: 0x11
function is_quest_complete()
{
    return zm_quest::is_quest_complete( #"hash_fceafdb93947e902" );
}

// Namespace namespace_b059317c43d6d0fe
// Params 0, eflags: 0x4
// Checksum 0xe0db65e7, Offset: 0x207
// Size: 0x10
function private init_quest_steps()
{
    namespace_e5bec19a2173f137::init();
    charge_the_weapon::init();
}

// Namespace namespace_b059317c43d6d0fe
// Params 0, eflags: 0x4
// Checksum 0x57bede0b, Offset: 0x21f
// Size: 0x58
function private register_quest_steps()
{
    zm_quest::function_3c363613c60958f5( #"hash_fceafdb93947e902" );
    zm_quest::register_quest_step( #"hash_fceafdb93947e902", #"hash_6c2da3f3db4721a8", &namespace_e5bec19a2173f137::execute, &namespace_e5bec19a2173f137::cleanup );
    zm_quest::register_quest_step( #"hash_fceafdb93947e902", #"hash_66d91a1c9c39b198", &charge_the_weapon::execute, &charge_the_weapon::cleanup );
}

// Namespace namespace_b059317c43d6d0fe
// Params 0, eflags: 0x4
// Checksum 0xb8f27963, Offset: 0x27f
// Size: 0xfc
function private function_4e7e6dd52c2e7070()
{
    if ( !zm_quest::function_b0a5181ebe7bb905() )
    {
        return;
    }
    
    level endon( #"game_ended", #"start_boss_fight" );
    
    if ( !isdefined( level.directed_mode ) )
    {
        level.directed_mode = {};
    }
    
    if ( !isdefined( level.directed_mode.var_f1879f50f4eeaca3 ) )
    {
        level.directed_mode.var_f1879f50f4eeaca3 = [];
    }
    
    gate_quest = zm_quest::get_quest( #"mantis_ww_quest" );
    gate_quest utility::ent_flag_wait( "zm_quest_completed" );
    guidance_steps = [ { #execute:&namespace_e5bec19a2173f137::function_bcdd8958faa3f63b, #step_ref:#"hash_6c2da3f3db4721a8" }, { #execute:&charge_the_weapon::function_bcdd8958faa3f63b, #step_ref:#"hash_66d91a1c9c39b198" } ];
    namespace_a7211835085600d5::function_670daf9bf33064ab( #"hash_fceafdb93947e902", #"hash_4670d9548e1da722", guidance_steps );
}

/#

    // Namespace namespace_b059317c43d6d0fe
    // Params 0, eflags: 0x4
    // Checksum 0x589bc6a, Offset: 0x383
    // Size: 0x9c, Type: dev
    function private init_dev_commands()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x45>", "<dev string:x5c>", &function_d44c9471b7df7072 );
        devgui::add_devgui_func( "<dev string:x77>", "<dev string:x96>", &function_b86441d9db5fc360 );
        devgui::add_devgui_func( "<dev string:xb7>", "<dev string:xda>", &function_5ec173d5f2e32b2b );
        devgui::add_devgui_func( "<dev string:xfd>", "<dev string:x121>", &function_5ec174d5f2e32d5e );
        devgui::add_devgui_func( "<dev string:x144>", "<dev string:x169>", &function_5ec175d5f2e32f91 );
        devgui::add_devgui_func( "<dev string:x18c>", "<dev string:x1b3>", &function_ea30fa4215322518 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_b059317c43d6d0fe
    // Params 0, eflags: 0x4
    // Checksum 0x2d05acbd, Offset: 0x427
    // Size: 0x31, Type: dev
    function private function_d44c9471b7df7072()
    {
        params = { #var_84ea737025f04638:1, #dev_force:1 };
        namespace_e5bec19a2173f137::function_c2bbf456e65f6d7( params );
    }

    // Namespace namespace_b059317c43d6d0fe
    // Params 0, eflags: 0x4
    // Checksum 0x92d78c68, Offset: 0x460
    // Size: 0x3f, Type: dev
    function private function_b86441d9db5fc360()
    {
        params = { #var_97be5bd2da2f08be:"<dev string:x1d4>", #var_84ea737025f04638:1, #dev_force:1 };
        namespace_e5bec19a2173f137::function_c2bbf456e65f6d7( params );
    }

    // Namespace namespace_b059317c43d6d0fe
    // Params 0, eflags: 0x4
    // Checksum 0x58f11a27, Offset: 0x4a7
    // Size: 0xe, Type: dev
    function private function_5ec173d5f2e32b2b()
    {
        namespace_e5bec19a2173f137::function_f456a8cc7447551e( 1 );
    }

    // Namespace namespace_b059317c43d6d0fe
    // Params 0, eflags: 0x4
    // Checksum 0xc1f84b9e, Offset: 0x4bd
    // Size: 0xe, Type: dev
    function private function_5ec174d5f2e32d5e()
    {
        namespace_e5bec19a2173f137::function_f456a8cc7447551e( 2 );
    }

    // Namespace namespace_b059317c43d6d0fe
    // Params 0, eflags: 0x4
    // Checksum 0xb6ff7b09, Offset: 0x4d3
    // Size: 0xe, Type: dev
    function private function_5ec175d5f2e32f91()
    {
        namespace_e5bec19a2173f137::function_f456a8cc7447551e( 3 );
    }

    // Namespace namespace_b059317c43d6d0fe
    // Params 0, eflags: 0x4
    // Checksum 0x96193827, Offset: 0x4e9
    // Size: 0xd, Type: dev
    function private function_ea30fa4215322518()
    {
        namespace_e5bec19a2173f137::function_f456a8cc7447551e( 0 );
    }

#/
