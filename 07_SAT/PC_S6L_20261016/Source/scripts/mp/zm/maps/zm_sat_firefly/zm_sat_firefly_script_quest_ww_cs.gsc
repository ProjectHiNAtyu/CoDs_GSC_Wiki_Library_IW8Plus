// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_quest_ww_cs.gsc  (hash_79001e05e0e90ad2.gscc) (size: 6631 Bytes / 0x19e7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe9d945dd (3923330525)
// size ...... 6631 (0x19e7)
// includes .. 3   (offset: 0x1657)
// strings ... 44  (offset: 0x166f)
// dev strs .. 0   (offset: 0x19e7)
// exports ... 9   (offset: 0x12bf)
// cseg ...... 0x3d9 + 0xee6 (0x12bf)
// imports ... 20  (offset: 0x1427)
// animtree1 . 0   (offset: 0x19e7)
// animtree2 . 0   (offset: 0x19e7)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_firefly_script_quest_ww_cs;

// Namespace zm_sat_firefly_script_quest_ww_cs
// Params 0, eflags: 0x5
// Checksum 0x57ad9b9a, Offset: 0x3f7
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_script_quest_ww_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_firefly_script_quest_ww_cs
// Params 0, eflags: 0x4
// Checksum 0x5cb35b78, Offset: 0x418
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_firefly_script_quest_ww_cs
// Params 0, eflags: 0x4
// Checksum 0xd9888894, Offset: 0x429
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_firefly_script_quest_ww_cs
// Params 2
// Checksum 0x6961dedd, Offset: 0x43a
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_script_quest_ww_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_firefly_script_quest_ww_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_script_quest_ww_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_script_quest_ww_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_script_quest_ww_cs
// Params 3, eflags: 0x4
// Checksum 0x5a0a3c5b, Offset: 0x4c2
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_script_quest_ww_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_script_quest_ww_cs" );
}

// Namespace zm_sat_firefly_script_quest_ww_cs
// Params 3, eflags: 0x4
// Checksum 0x5e49c412, Offset: 0x53c
// Size: 0xd63
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "fww_failsafe_loc";
    fe [[ f ]]( s, us, cf, ( 3352, -1992, -136 ), ( 0, 0, 0 ), "fww_failsafe_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "fww_failsafe_loc";
    fe [[ f ]]( s, us, cf, ( 3504, -1880, -256 ), ( 0, 0, 0 ), "fww_failsafe_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "fww_failsafe_loc";
    fe [[ f ]]( s, us, cf, ( 3456, -1888, -184 ), ( 0, 0, 0 ), "fww_failsafe_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 32, 144, 94 );
    s._size_min = ( 32, 126, 44 );
    s.height = 128;
    s.length = "128";
    s.name = "Summoning Circle Failsafe";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 13944, -3936, 432 ), ( 0, 315, 0 ), "fww_sum_failsafe" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    fe [[ f ]]( s, us, cf, ( 13228, -4330, 644 ), ( 0, 0, 0 ), "fww_doors" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    fe [[ f ]]( s, us, cf, ( 13764, -4330, 660 ), ( 0, 0, 0 ), "fww_doors" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "Security Scan Aether Barrel";
    fe [[ f ]]( s, us, cf, ( -7771.62, -5547.6, 1432 ), ( 0, 324, 0 ), "fww_sec_ab" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "Vault_Retrievable_1";
    fe [[ f ]]( s, us, cf, ( 13550, -4068, 530 ), ( 0, 300, 0 ), "fww_v_rs" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "Security Scan Circle";
    fe [[ f ]]( s, us, cf, ( -7862, -5658, 1376 ), ( 0, 0, 0 ), "fww_sec_c" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "Farm AED Aether Barrel";
    fe [[ f ]]( s, us, cf, ( 14892, -3886, 626 ), ( 0, 348, 0 ), "fww_f_ab" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "Town AED Aether Barrel";
    fe [[ f ]]( s, us, cf, ( 2915, -1547, 244 ), ( 0, 270, 0 ), "fww_t_ab" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "Lake AED Aether Barrel";
    fe [[ f ]]( s, us, cf, ( 12296, 1974, 1062 ), ( 0, 36, 0 ), "fww_l_ab" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "Vault_Retrievable_3";
    fe [[ f ]]( s, us, cf, ( 14066, -3576, 536 ), ( 0, 300, 0 ), "fww_v_rs" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "Vault_Retrievable_2";
    fe [[ f ]]( s, us, cf, ( 13270, -3249.91, 622 ), ( 0, 332, 0 ), "fww_v_rs" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "Vault_Retrievable_4";
    fe [[ f ]]( s, us, cf, ( 14012, -3522, 448 ), ( 0, 300, 0 ), "fww_v_rs" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "Vault_Retrievable_5";
    fe [[ f ]]( s, us, cf, ( 13501.8, -3707.71, 548 ), ( 0, 98, 0 ), "fww_v_rs" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "Vault_Retrievable_6";
    fe [[ f ]]( s, us, cf, ( 13687.8, -4203.71, 518 ), ( 0, 98, 0 ), "fww_v_rs" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "fww_failsafe_loc";
    fe [[ f ]]( s, us, cf, ( 3416, -1928, -160 ), ( 0, 0, 0 ), "fww_failsafe_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "fww_failsafe_loc";
    fe [[ f ]]( s, us, cf, ( 3296, -2064, -88 ), ( 0, 0, 0 ), "fww_failsafe_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "fww_failsafe_loc";
    fe [[ f ]]( s, us, cf, ( 3232, -2144, -88 ), ( 0, 0, 0 ), "fww_failsafe_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "Vault_Retrievable_Start1";
    fe [[ f ]]( s, us, cf, ( 13849.9, -3826.28, 466 ), ( 0, 315, 0 ), "fww_v_r_s1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "Vault_Retrievable_Start2";
    fe [[ f ]]( s, us, cf, ( 13922.1, -3897.12, 468 ), ( 0, 315, 0 ), "fww_v_r_s2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "Vault_Retrievable_7";
    fe [[ f ]]( s, us, cf, ( 13574, -4092, 450 ), ( 0, 300, 0 ), "fww_v_rs" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "Vault_Retrievable_10";
    fe [[ f ]]( s, us, cf, ( 13652, -3394, 520 ), ( 0, 300, 0 ), "fww_v_rs" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "Vault_Retrievable_9";
    fe [[ f ]]( s, us, cf, ( 13572, -3314, 616 ), ( 0, 300, 0 ), "fww_v_rs" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "Vault_Retrievable_8";
    fe [[ f ]]( s, us, cf, ( 13340, -3537.75, 608 ), ( 0, 30, 0 ), "fww_v_rs" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "Vault_Retrievable_11";
    fe [[ f ]]( s, us, cf, ( 14094, -3752, 450 ), ( 0, 300, 0 ), "fww_v_rs" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    fe [[ f ]]( s, us, cf, ( 13524, -3058, 660 ), ( 0, 0, 0 ), "fww_doors" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "Security Scanner";
    fe [[ f ]]( s, us, cf, ( -7779.83, -5559.93, 1526 ), ( 0, 234, 0 ), "fww_sec_s" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "fww_failsafe_loc";
    fe [[ f ]]( s, us, cf, ( 3336, -2024, -104 ), ( 0, 0, 0 ), "fww_failsafe_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "fww_failsafe_loc";
    fe [[ f ]]( s, us, cf, ( 3392, -1960, -136 ), ( 0, 0, 0 ), "fww_failsafe_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "Prism Vault Symbol Right";
    fe [[ f ]]( s, us, cf, ( 13836.4, -3827.78, 469 ), ( 0, 225, 0 ), "fww_v_r_s" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "Prism Vault Symbol Back";
    fe [[ f ]]( s, us, cf, ( 13836.4, -3811.08, 469 ), ( 0, 135, 0 ), "fww_v_b_s" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "Prism Vault Symbol Left";
    fe [[ f ]]( s, us, cf, ( 13853.1, -3811.98, 469 ), ( 0, 45, 0 ), "fww_v_l_s" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "Prism Vault Symbol Front";
    fe [[ f ]]( s, us, cf, ( 13853.4, -3828.78, 466 ), ( 0, 315, 0 ), "fww_v_f_s" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "fww_failsafe_loc";
    fe [[ f ]]( s, us, cf, ( 3304, -1920, -176 ), ( 0, 0, 0 ), "fww_failsafe_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "fww_failsafe_loc";
    fe [[ f ]]( s, us, cf, ( 3408, -1816, -224 ), ( 0, 0, 0 ), "fww_failsafe_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "fww_failsafe_loc";
    fe [[ f ]]( s, us, cf, ( 3368, -1856, -200 ), ( 0, 0, 0 ), "fww_failsafe_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "fww_failsafe_loc";
    fe [[ f ]]( s, us, cf, ( 3248, -1992, -128 ), ( 0, 0, 0 ), "fww_failsafe_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "fww_failsafe_loc";
    fe [[ f ]]( s, us, cf, ( 3184, -2072, -128 ), ( 0, 0, 0 ), "fww_failsafe_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "fww_failsafe_loc";
    fe [[ f ]]( s, us, cf, ( 3288, -1952, -144 ), ( 0, 0, 0 ), "fww_failsafe_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_quest_ww_cs";
    s.name = "fww_failsafe_loc";
    fe [[ f ]]( s, us, cf, ( 3344, -1888, -176 ), ( 0, 0, 0 ), "fww_failsafe_loc" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_script_quest_ww_cs
// Params 0, eflags: 0x4
// Checksum 0xa4cb3de5, Offset: 0x12a7
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_script_quest_ww_cs
// Params 0
// Checksum 0x9859e116, Offset: 0x12b1
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_script_quest_ww_cs" );
}

