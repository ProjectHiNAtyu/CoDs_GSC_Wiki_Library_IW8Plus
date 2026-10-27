// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_script_exfil_cs.gsc  (hash_7a29f2740d076a81.gscc) (size: 5081 Bytes / 0x13d9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcb0a3c80 (3406445696)
// size ...... 5081 (0x13d9)
// includes .. 3   (offset: 0x112d)
// strings ... 23  (offset: 0x1145)
// dev strs .. 0   (offset: 0x13d9)
// exports ... 9   (offset: 0xd95)
// cseg ...... 0x26e + 0xb27 (0xd95)
// imports ... 20  (offset: 0xefd)
// animtree1 . 0   (offset: 0x13d9)
// animtree2 . 0   (offset: 0x13d9)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_scarab_script_exfil_cs;

// Namespace zm_sat_scarab_script_exfil_cs
// Params 0, eflags: 0x5
// Checksum 0x452e7606, Offset: 0x28c
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_scarab_script_exfil_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_scarab_script_exfil_cs
// Params 0, eflags: 0x4
// Checksum 0xb57c9998, Offset: 0x2ad
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_scarab_script_exfil_cs
// Params 0, eflags: 0x4
// Checksum 0x30474a74, Offset: 0x2be
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_scarab_script_exfil_cs
// Params 2
// Checksum 0x80ae1c3d, Offset: 0x2cf
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_scarab_script_exfil_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_scarab_script_exfil_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_scarab_script_exfil_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_scarab_script_exfil_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_scarab_script_exfil_cs
// Params 3, eflags: 0x4
// Checksum 0xb3c5febb, Offset: 0x357
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_scarab_script_exfil_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_scarab_script_exfil_cs" );
}

// Namespace zm_sat_scarab_script_exfil_cs
// Params 3, eflags: 0x4
// Checksum 0xdfe32d8b, Offset: 0x3d1
// Size: 0x9a4
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_exfil_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 917.44, -1010.75, 1302 ), ( 0, 180.04, 0 ), "cspf_0_auto16911536170443586329" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_exfil_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 960, -944, 1366 ), ( 0, 180, 0 ), "cspf_0_auto1284933450841619039", undefined, "interact" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_exfil_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 904.14, -932.32, 1405.03 ), ( 0, 195.44, 0 ), "cspf_0_auto1284933450841619039", "cspf_0_auto16911536170443586329", "teleport_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_exfil_cs";
    s.name = "script_struct";
    s.script_int = "120";
    s.script_label = "zombie_mangler_hvt";
    s.script_radius = "9000";
    s.script_timer = "30";
    fe [[ f ]]( s, us, cf, ( 0, -236, 1807.5 ), ( 0, 0, 0 ), "zm_exfil", "cspf_0_auto3212570331569737626" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_exfil_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 913.36, -932.07, 1302 ), ( 0, 180.04, 0 ), "cspf_0_auto16911536170443586329" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_exfil_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 913.97, -975.15, 1302 ), ( 0, 180.04, 0 ), "cspf_0_auto16911536170443586329" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_exfil_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 909.89, -896.46, 1302 ), ( 0, 180.04, 0 ), "cspf_0_auto16911536170443586329" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_exfil_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 992, -944, 1309.5 ), ( 0, 180, 0 ), "cspf_0_auto3212570331569737626", "cspf_0_auto1284933450841619039", "zone_nexus_exterior_ring" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_exfil_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 560, -944, 1304 ), ( 0, 0, 0 ), "cspf_0_auto1284933450841619039", undefined, "hvt_spawn_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_exfil_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 0, -952, 1296 ), ( 0, 0, 0 ), "cspf_0_auto1284933450841619039", undefined, "override_exfil_center", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_exfil_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 952, 4026, 1855 ), ( 0, 269.04, 0 ), "cspf_0_auto15450665455789967623" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_exfil_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 730, 3988, 1918 ), ( 0, 271, 0 ), "cspf_0_auto3771889767420960039", undefined, "interact" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_exfil_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 893.11, 4023.76, 1963.03 ), ( 0, 201.04, 0 ), "cspf_0_auto3771889767420960039", "cspf_0_auto15450665455789967623", "teleport_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_exfil_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 873.26, 4023.3, 1855 ), ( 0, 269.04, 0 ), "cspf_0_auto15450665455789967623" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_exfil_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 916.34, 4023.15, 1855 ), ( 0, 269.04, 0 ), "cspf_0_auto15450665455789967623" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_exfil_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 837.59, 4020.45, 1855 ), ( 0, 269.04, 0 ), "cspf_0_auto15450665455789967623" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_exfil_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 729.44, 4020, 1854 ), ( 0, 271, 0 ), "cspf_0_auto3212570331569737626", "cspf_0_auto3771889767420960039", "zone_n_transition_island_north" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_exfil_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 442.36, 3272.95, 1865 ), ( 0, 0, 0 ), "cspf_0_auto3771889767420960039", undefined, "hvt_spawn_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_exfil_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 451.07, 3310.01, 1729 ), ( 0, 0, 0 ), "cspf_0_auto3771889767420960039", undefined, "override_exfil_center", undefined, undefined, undefined, undefined, 1000 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_exfil_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 4105.55, 1036.93, 1743 ), ( 0, 291.04, -0 ), "cspf_0_auto8367643770877928253" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_exfil_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3961.95, 996.54, 1810 ), ( 4, 293, 0 ), "cspf_0_auto3262640780085499208", undefined, "interact" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_exfil_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3993.78, 1034.8, 1861.03 ), ( 0, 223.04, 0 ), "cspf_0_auto3262640780085499208", "cspf_0_auto8367643770877928253", "teleport_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_exfil_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 4033.55, 1004.93, 1743 ), ( 0, 291.04, -0 ), "cspf_0_auto8367643770877928253" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_exfil_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 4073.55, 1020.93, 1743 ), ( 0, 291.04, -0 ), "cspf_0_auto8367643770877928253" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_exfil_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 4001.55, 988.93, 1743 ), ( 0, 291.04, -0 ), "cspf_0_auto8367643770877928253" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_exfil_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3951.73, 1020.04, 1742.39 ), ( 4, 293, 0 ), "cspf_0_auto3212570331569737626", "cspf_0_auto3262640780085499208", "zone_e_transition_island" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_exfil_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 3950.36, 532.95, 1577 ), ( 0, 0, 0 ), "cspf_0_auto3262640780085499208", undefined, "hvt_spawn_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_script_exfil_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 4190.57, 657.01, 1571 ), ( 0, 0, 0 ), "cspf_0_auto3262640780085499208", undefined, "override_exfil_center", undefined, undefined, undefined, undefined, 1000 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_scarab_script_exfil_cs
// Params 0, eflags: 0x4
// Checksum 0xc439cbd, Offset: 0xd7d
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_scarab_script_exfil_cs
// Params 0
// Checksum 0x719623f6, Offset: 0xd87
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_scarab_script_exfil_cs" );
}

