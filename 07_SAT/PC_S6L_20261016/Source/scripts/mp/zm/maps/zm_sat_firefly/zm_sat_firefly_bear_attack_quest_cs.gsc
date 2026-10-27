// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_bear_attack_quest_cs.gsc  (hash_706f729308a4e563.gscc) (size: 4338 Bytes / 0x10f2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa21510ff (2719289599)
// size ...... 4338 (0x10f2)
// includes .. 3   (offset: 0xeea)
// strings ... 26  (offset: 0xf02)
// dev strs .. 0   (offset: 0x10f2)
// exports ... 9   (offset: 0xb52)
// cseg ...... 0x36b + 0x7e7 (0xb52)
// imports ... 20  (offset: 0xcba)
// animtree1 . 0   (offset: 0x10f2)
// animtree2 . 0   (offset: 0x10f2)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_firefly_bear_attack_quest_cs;

// Namespace zm_sat_firefly_bear_attack_quest_cs
// Params 0, eflags: 0x5
// Checksum 0xc3f77d38, Offset: 0x389
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_bear_attack_quest_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_firefly_bear_attack_quest_cs
// Params 0, eflags: 0x4
// Checksum 0x3849b0af, Offset: 0x3aa
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_firefly_bear_attack_quest_cs
// Params 0, eflags: 0x4
// Checksum 0xbd726343, Offset: 0x3bb
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_firefly_bear_attack_quest_cs
// Params 2
// Checksum 0xd9b350a, Offset: 0x3cc
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_bear_attack_quest_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_firefly_bear_attack_quest_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_bear_attack_quest_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_bear_attack_quest_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_bear_attack_quest_cs
// Params 3, eflags: 0x4
// Checksum 0x3ef0d78c, Offset: 0x454
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_bear_attack_quest_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_bear_attack_quest_cs" );
}

// Namespace zm_sat_firefly_bear_attack_quest_cs
// Params 3, eflags: 0x4
// Checksum 0x61097e9f, Offset: 0x4ce
// Size: 0x664
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_bear_attack_quest_cs";
    fe [[ f ]]( s, us, cf, ( -1313.91, -5510.44, 724.01 ), ( 355.25, 57.89, -2.83 ), "cspf_0_auto6331187674119366434" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_bear_attack_quest_cs";
    fe [[ f ]]( s, us, cf, ( -1084.33, 421.97, 112.77 ), ( 10.33, 168.36, 0.44 ), undefined, "cspf_0_auto13251383654275557984", "ba_ee_1st_fp_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_bear_attack_quest_cs";
    fe [[ f ]]( s, us, cf, ( -2675.8, 1106.51, -143.2 ), ( 357.01, 142.03, 3.12 ), "cspf_0_auto14693276468085083938", "cspf_0_auto4044977251881518895" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_bear_attack_quest_cs";
    fe [[ f ]]( s, us, cf, ( -3408.47, 1547.25, -155.45 ), ( 357.51, 92.28, 1.52 ), "cspf_0_auto4044977251881518895", "cspf_0_auto10883523974986492722" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_bear_attack_quest_cs";
    fe [[ f ]]( s, us, cf, ( -3664.52, 2687.76, -155.81 ), ( 356.54, 101.09, 0.37 ), "cspf_0_auto10883523974986492722", "cspf_0_auto9198907305098778795" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_bear_attack_quest_cs";
    fe [[ f ]]( s, us, cf, ( -3858.09, 3238.35, -147.58 ), ( 1.21, 116.6, -2.21 ), "cspf_0_auto9198907305098778795" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_bear_attack_quest_cs";
    fe [[ f ]]( s, us, cf, ( -1472.8, 8756.02, 319.31 ), ( 0, 0, 90 ), "sq_bear_attack_center_cave" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_bear_attack_quest_cs";
    fe [[ f ]]( s, us, cf, ( -2058.72, 680.6, -117.72 ), ( 9.59, 159.46, -0.59 ), "cspf_0_auto13251383654275557984", "cspf_0_auto14693276468085083938" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_bear_attack_quest_cs";
    fe [[ f ]]( s, us, cf, ( -1522.27, 9539.2, 310.68 ), ( 0, 264.27, 0 ), "sq_bear_attack_bear_cave_spawn_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_bear_attack_quest_cs";
    fe [[ f ]]( s, us, cf, ( -1540.7, 8029.23, 309.07 ), ( 0, 90.58, 0 ), "sq_bear_attack_player_cave_spawn_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_bear_attack_quest_cs";
    fe [[ f ]]( s, us, cf, ( -1410.31, 8674.19, 315.57 ), ( 355.7, 57.18, 0 ), "sq_bear_attack_chest" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_bear_attack_quest_cs";
    fe [[ f ]]( s, us, cf, ( -4152.87, 3012.71, -107.22 ), ( 0, 24.08, 0 ), undefined, undefined, "ba_ee_return_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_bear_attack_quest_cs";
    fe [[ f ]]( s, us, cf, ( -1412.5, 8675.91, 317 ), ( 0, 235, -32.08 ), undefined, undefined, "ba_ee_necklace_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_bear_attack_quest_cs";
    fe [[ f ]]( s, us, cf, ( 1083.92, -2748.51, -53.78 ), ( 355.35, 236.08, -0.69 ), undefined, "cspf_0_auto4929001926231759672", "ba_ee_1st_fp_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_bear_attack_quest_cs";
    fe [[ f ]]( s, us, cf, ( -1403.39, 8687.38, 323.3 ), ( 0, 135, 0 ), undefined, undefined, "ba_ee_common_reward_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_bear_attack_quest_cs";
    fe [[ f ]]( s, us, cf, ( 530.63, -3777.34, 95.04 ), ( 349.87, 213.48, 1.68 ), "cspf_0_auto4929001926231759672", "cspf_0_auto6217257560524589818" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_bear_attack_quest_cs";
    fe [[ f ]]( s, us, cf, ( -608.93, -4458.11, 309.43 ), ( 349.83, 212.68, 3.4 ), "cspf_0_auto6217257560524589818", "cspf_0_auto16970319403647750926" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_bear_attack_quest_cs";
    fe [[ f ]]( s, us, cf, ( -1880.74, -5123.93, 634.81 ), ( 355.71, 255.87, -6.27 ), "cspf_0_auto16970319403647750926", "cspf_0_auto2513605891726887883" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_bear_attack_quest_cs";
    fe [[ f ]]( s, us, cf, ( -1968.07, -5805.81, 752.89 ), ( 357.44, 0.78, -10.03 ), "cspf_0_auto2513605891726887883", "cspf_0_auto6331187674119366434" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_bear_attack_quest_cs";
    fe [[ f ]]( s, us, cf, ( -10606.3, -2597.91, 1303.58 ), ( 2.77, 86.74, -7.04 ), undefined, "cspf_0_auto1741928954482172226", "ba_ee_1st_fp_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_bear_attack_quest_cs";
    fe [[ f ]]( s, us, cf, ( -10720.3, -1854.3, 1197.46 ), ( 7.59, 106.94, -4.64 ), "cspf_0_auto1741928954482172226", "cspf_0_auto12077899422883944933" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_bear_attack_quest_cs";
    fe [[ f ]]( s, us, cf, ( -10892.5, -1089.36, 1086.99 ), ( 12.18, 141.47, 1.53 ), "cspf_0_auto12077899422883944933", "cspf_0_auto1281300119154301664" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_bear_attack_quest_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -11524.4, -828.86, 977.81 ), ( 356.64, 237.03, 10.92 ), "cspf_0_auto1281300119154301664", "cspf_0_auto3904060850292085356" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_bear_attack_quest_cs";
    fe [[ f ]]( s, us, cf, ( -11810.4, -1361.74, 1025.62 ), ( 355.43, 237.59, 7.15 ), "cspf_0_auto3904060850292085356" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_bear_attack_quest_cs
// Params 0, eflags: 0x4
// Checksum 0x45333b8c, Offset: 0xb3a
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_bear_attack_quest_cs
// Params 0
// Checksum 0xfca30ac1, Offset: 0xb44
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_bear_attack_quest_cs" );
}

