// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_sq_echoes_cs.gsc  (hash_6f7f9b88d57c2feb.gscc) (size: 7992 Bytes / 0x1f38 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x705e3593 (1885222291)
// size ...... 7992 (0x1f38)
// includes .. 3   (offset: 0x1a98)
// strings ... 58  (offset: 0x1ab0)
// dev strs .. 0   (offset: 0x1f38)
// exports ... 9   (offset: 0x1700)
// cseg ...... 0x45c + 0x12a4 (0x1700)
// imports ... 20  (offset: 0x1868)
// animtree1 . 0   (offset: 0x1f38)
// animtree2 . 0   (offset: 0x1f38)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_ruby_sq_echoes_cs;

// Namespace zm_sat_ruby_sq_echoes_cs
// Params 0, eflags: 0x5
// Checksum 0x7f99a67, Offset: 0x47a
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_ruby_sq_echoes_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_ruby_sq_echoes_cs
// Params 0, eflags: 0x4
// Checksum 0xd65bb97d, Offset: 0x49b
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_ruby_sq_echoes_cs
// Params 0, eflags: 0x4
// Checksum 0x53606a91, Offset: 0x4ac
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_ruby_sq_echoes_cs
// Params 2
// Checksum 0xe3893cd8, Offset: 0x4bd
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_ruby_sq_echoes_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_ruby_sq_echoes_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_ruby_sq_echoes_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_ruby_sq_echoes_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_ruby_sq_echoes_cs
// Params 3, eflags: 0x4
// Checksum 0xd0e2de5e, Offset: 0x545
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_ruby_sq_echoes_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_ruby_sq_echoes_cs" );
}

// Namespace zm_sat_ruby_sq_echoes_cs
// Params 3, eflags: 0x4
// Checksum 0x208f090e, Offset: 0x5bf
// Size: 0x1121
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "toy";
    fe [[ f ]]( s, us, cf, ( 2681.61, 731.54, 20.4 ), ( 348.69, 2.31, -98.76 ), "sq_echoes_toy" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 128;
    s.name = "trigger_D";
    fe [[ f ]]( s, us, cf, ( 2175, 308, -714 ), ( 0, 0, 0 ), "sq_echoes_trigger_objects_d", undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "enter";
    fe [[ f ]]( s, us, cf, ( 2956, 359, -714 ), ( 0, 270, 0 ), "sq_echoes_cave" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.script_scenescriptbundle = "sat_zm_ruby_hallucination_enter_cave";
    fe [[ f ]]( s, us, cf, ( 2678.5, 725.5, 25 ), ( 0, 0, 0 ), "ruby_echoes_enter_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "drawing_interact";
    fe [[ f ]]( s, us, cf, ( 2944.85, 84.74, -673 ), ( 343.42, 267.08, 0 ), "sq_echoes_cave_interact" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "shade_spawn";
    fe [[ f ]]( s, us, cf, ( 2651, 711, -709 ), ( 0, 270, 0 ), "echoes_shade_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "exit";
    fe [[ f ]]( s, us, cf, ( 2707, 852, -22.2 ), ( 0, 47.01, 0 ), "sq_echoes_cave_exit" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "shade_spawn";
    fe [[ f ]]( s, us, cf, ( 2385, 686, -713 ), ( 0, 90, 0 ), "echoes_shade_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "shade_spawn";
    fe [[ f ]]( s, us, cf, ( 2509, 729, -709 ), ( 0, 270, 0 ), "echoes_shade_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "shade_spawn";
    fe [[ f ]]( s, us, cf, ( 2575, 683, -709 ), ( 0, 90, 0 ), "echoes_shade_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "shade_spawn";
    fe [[ f ]]( s, us, cf, ( 2614, -113, -714 ), ( 0, 80.9, 0 ), "echoes_shade_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "shade_spawn";
    fe [[ f ]]( s, us, cf, ( 2247, -69, -713 ), ( 0, 63.6, 0 ), "echoes_shade_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "shade_spawn";
    fe [[ f ]]( s, us, cf, ( 2368, -91, -709 ), ( 0, 157.8, 0 ), "echoes_shade_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "shade_spawn";
    fe [[ f ]]( s, us, cf, ( 2587.64, -59.89, -711 ), ( 0, 243.7, 0 ), "echoes_shade_spawn", undefined, "15" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "shade_spawn";
    fe [[ f ]]( s, us, cf, ( 2163, 165, -715 ), ( 0, 180, 0 ), "echoes_shade_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "shade_spawn";
    fe [[ f ]]( s, us, cf, ( 2163, 409, -715 ), ( 0, 360, 0 ), "echoes_shade_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "shade_spawn";
    fe [[ f ]]( s, us, cf, ( 2197, 307, -709 ), ( 0, 180, 0 ), "echoes_shade_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "shade_spawn";
    fe [[ f ]]( s, us, cf, ( 2144, 243, -714.82 ), ( 0, 360, 0 ), "echoes_shade_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "shade_spawn";
    fe [[ f ]]( s, us, cf, ( 2967, 209, -709 ), ( 0, 180, 0 ), "echoes_shade_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "shade_spawn";
    fe [[ f ]]( s, us, cf, ( 2967, 425, -709 ), ( 0, 360, 0 ), "echoes_shade_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "shade_spawn";
    fe [[ f ]]( s, us, cf, ( 3001, 351, -709 ), ( 0, 180, 0 ), "echoes_shade_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "shade_spawn";
    fe [[ f ]]( s, us, cf, ( 2929, 285, -709 ), ( 0, 360, 0 ), "echoes_shade_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "toor_bala";
    fe [[ f ]]( s, us, cf, ( 2943.75, 55.75, -650 ), ( 40, 90.39, 0.25 ), "sq_echoes_cave_monster" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 128;
    s.name = "trigger_A";
    fe [[ f ]]( s, us, cf, ( 2898, -21, -714 ), ( 0, 90, 0 ), "sq_echoes_trigger_objects_a", undefined, undefined, undefined, undefined, undefined, undefined, 256 );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 128;
    s.name = "trigger_B";
    fe [[ f ]]( s, us, cf, ( 2226, 650, -714 ), ( 0, 90, 0 ), "sq_echoes_trigger_objects_b", undefined, undefined, undefined, undefined, undefined, undefined, 256 );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "toyMove";
    fe [[ f ]]( s, us, cf, ( 2624, 714, 30 ), ( 355.54, 237.32, -0.58 ), "sq_echoes_toy_move", "cspf_0_auto5759475990260425712" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "skull";
    fe [[ f ]]( s, us, cf, ( 2944.5, 62, -643 ), ( 45, 90, 0 ), "sq_echoes_cave_skull" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 128;
    s.name = "trigger_C";
    fe [[ f ]]( s, us, cf, ( 2944, 346, -714 ), ( 0, 0, 0 ), "sq_echoes_trigger_objects_c", undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "toor_bala_scene";
    fe [[ f ]]( s, us, cf, ( 2160, 323, -651 ), ( 22, 292.64, 0 ), "sq_echoes_cave_monster_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 128;
    s.name = "trigger_vision_A1";
    fe [[ f ]]( s, us, cf, ( 2402.71, 718.06, -714 ), ( 0, 90, 0 ), "sq_echoes_trigger_vision", "vision_target_a1", "a1", undefined, undefined, undefined, undefined, 150 );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 128;
    s.name = "trigger_vision_B2";
    fe [[ f ]]( s, us, cf, ( 2949.43, 25.07, -714 ), ( 0, 245, 0 ), "sq_echoes_trigger_vision", "vision_target_b2", "b2", undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "vision_target";
    fe [[ f ]]( s, us, cf, ( 2489.19, 792.26, -680.52 ), ( 0, 241, 0 ), "vision_target_a1" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "vision_target";
    fe [[ f ]]( s, us, cf, ( 2820.73, -48.34, -635.52 ), ( 0, 45, 0 ), "vision_target_b2", undefined, "30" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 128;
    s.name = "trigger_vision_A2";
    fe [[ f ]]( s, us, cf, ( 2478, 719, -714 ), ( 0, 90, 0 ), "sq_echoes_trigger_vision", "vision_target_a2", "a2", undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "vision_target";
    fe [[ f ]]( s, us, cf, ( 2504.85, 788.87, -643.66 ), ( 0, 221.85, 0 ), "vision_target_a1", undefined, "20" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "vision_target";
    s.script_label = "move";
    fe [[ f ]]( s, us, cf, ( 2940.54, -35.21, -711.12 ), ( 0, 45, 0 ), "vision_target_b2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "vision_target";
    fe [[ f ]]( s, us, cf, ( 2879, -46, -713 ), ( 0, 45, 0 ), "vision_target_b2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "vision_target";
    fe [[ f ]]( s, us, cf, ( 2833.47, 33.14, -710.99 ), ( 0, 45, 0 ), "vision_target_b2", undefined, "15" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "vision_target";
    s.script_label = "move";
    fe [[ f ]]( s, us, cf, ( 2495, 753, -710.43 ), ( 0, 0, 0 ), "vision_target_a2", undefined, "16" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "vision_target";
    fe [[ f ]]( s, us, cf, ( 2458, 761, -708 ), ( 0, 0, 0 ), "vision_target_a2", undefined, "8" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 128;
    s.name = "trigger_vision_B3";
    fe [[ f ]]( s, us, cf, ( 2945, 119, -714 ), ( 0, 245, 0 ), "sq_echoes_trigger_vision", "vision_target_b3", "b3", undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 128;
    s.name = "trigger_vision_A2_alt";
    fe [[ f ]]( s, us, cf, ( 2171, 260, -722 ), ( 0, 90, 0 ), "sq_echoes_trigger_vision", "vision_target_a2_alt", "a2", undefined, undefined, undefined, undefined, 96 );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "vision_target";
    fe [[ f ]]( s, us, cf, ( 2944.37, 53.24, -648 ), ( 0, 92.23, 0 ), "vision_target_b3", undefined, "25" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 128;
    s.name = "trigger_vision_A3";
    fe [[ f ]]( s, us, cf, ( 2830, 664, -714 ), ( 0, 90, 0 ), "sq_echoes_trigger_vision", "vision_target_a3", "a3", undefined, undefined, undefined, undefined, 96 );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "vision_target";
    s.script_label = "move";
    fe [[ f ]]( s, us, cf, ( 2161.42, 310.58, -713.52 ), ( 0, 0, 0 ), "vision_target_a2_alt", undefined, "16" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    s.name = "vision_target";
    fe [[ f ]]( s, us, cf, ( 3003, 559, -683 ), ( 0, 0, 0 ), "vision_target_a3", undefined, "20" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_sq_echoes_cs";
    fe [[ f ]]( s, us, cf, ( 2546, 599, 47 ), ( 0, 0, 0 ), "cspf_0_auto5759475990260425712" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_ruby_sq_echoes_cs
// Params 0, eflags: 0x4
// Checksum 0xfdacf2ff, Offset: 0x16e8
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_ruby_sq_echoes_cs
// Params 0
// Checksum 0x12b10313, Offset: 0x16f2
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_ruby_sq_echoes_cs" );
}

