// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_quest_ee_alchemy_cs.gsc  (hash_4a5766403f3aebea.gscc) (size: 5424 Bytes / 0x1530 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x51d61838 (1372985400)
// size ...... 5424 (0x1530)
// includes .. 3   (offset: 0x123c)
// strings ... 33  (offset: 0x1254)
// dev strs .. 0   (offset: 0x1530)
// exports ... 9   (offset: 0xea4)
// cseg ...... 0x2e7 + 0xbbd (0xea4)
// imports ... 20  (offset: 0x100c)
// animtree1 . 0   (offset: 0x1530)
// animtree2 . 0   (offset: 0x1530)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_mantis_quest_ee_alchemy_cs;

// Namespace zm_sat_mantis_quest_ee_alchemy_cs
// Params 0, eflags: 0x5
// Checksum 0x5ff917c2, Offset: 0x305
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_mantis_quest_ee_alchemy_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_mantis_quest_ee_alchemy_cs
// Params 0, eflags: 0x4
// Checksum 0x38b344a9, Offset: 0x326
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_mantis_quest_ee_alchemy_cs
// Params 0, eflags: 0x4
// Checksum 0xbd889745, Offset: 0x337
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_mantis_quest_ee_alchemy_cs
// Params 2
// Checksum 0xd61c10c, Offset: 0x348
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_mantis_quest_ee_alchemy_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_mantis_quest_ee_alchemy_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_mantis_quest_ee_alchemy_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_mantis_quest_ee_alchemy_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_mantis_quest_ee_alchemy_cs
// Params 3, eflags: 0x4
// Checksum 0x3e0a238a, Offset: 0x3d0
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_mantis_quest_ee_alchemy_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_mantis_quest_ee_alchemy_cs" );
}

// Namespace zm_sat_mantis_quest_ee_alchemy_cs
// Params 3, eflags: 0x4
// Checksum 0x27c30061, Offset: 0x44a
// Size: 0xa3a
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_alchemy_cs";
    s.groupid = "material";
    s.name = "meat";
    s.script_label = "meat";
    fe [[ f ]]( s, us, cf, ( 77915.9, -30124.5, -83.26 ), ( 0, 240, 0 ), undefined, undefined, "alchemy_ee_material_meat" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_alchemy_cs";
    s.groupid = "material";
    s.name = "metal";
    s.script_label = "metal";
    fe [[ f ]]( s, us, cf, ( 79202.9, -31323.7, -121 ), ( 0, 330, 0 ), undefined, undefined, "alchemy_ee_material_metal" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_alchemy_cs";
    s.groupid = "material";
    s.name = "battery";
    s.script_label = "battery";
    fe [[ f ]]( s, us, cf, ( 78413.8, -30947.8, -95.87 ), ( 272.5, 180, -75 ), undefined, undefined, "alchemy_ee_material_battery" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_alchemy_cs";
    s.groupid = "material";
    s.name = "blood";
    s.script_label = "blood";
    fe [[ f ]]( s, us, cf, ( 53708.4, -32627.4, -119.25 ), ( 0, 13.9, 0 ), undefined, undefined, "alchemy_ee_material_blood" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_alchemy_cs";
    s.groupid = "material";
    s.name = "collar";
    s.script_label = "collar";
    fe [[ f ]]( s, us, cf, ( 77534.8, -32811.8, -126.41 ), ( 0, 146.4, 0 ), undefined, undefined, "alchemy_ee_material_collar" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_alchemy_cs";
    s.groupid = "material";
    s.name = "skull";
    s.script_label = "skull";
    fe [[ f ]]( s, us, cf, ( 55023.4, -33246.4, -83.75 ), ( 0, 345, 0 ), undefined, undefined, "alchemy_ee_material_skull" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_alchemy_cs";
    s.groupid = "drop";
    s.name = "battery";
    s.script_label = "battery";
    fe [[ f ]]( s, us, cf, ( 54474.4, -29989.6, -118.5 ), ( 0, 176.2, -0 ), "cspf_0_auto13459615646600970452" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_alchemy_cs";
    s.groupid = "drop";
    s.name = "bowl";
    fe [[ f ]]( s, us, cf, ( 54488.8, -29999.8, -122 ), ( 90, 173.45, 56.25 ), undefined, "cspf_0_auto13459615646600970452", "alchemy_bowl" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_alchemy_cs";
    s.name = "cyst";
    fe [[ f ]]( s, us, cf, ( 54463, -30017, -97.25 ), ( 0, 115.25, 0 ), undefined, undefined, "alchemy_cyst" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_alchemy_cs";
    s.groupid = "drop";
    s.name = "blood";
    s.script_label = "blood";
    fe [[ f ]]( s, us, cf, ( 54447.2, -29981.9, -121 ), ( 0, 356.99, -0 ), "cspf_0_auto13459615646600970452" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_alchemy_cs";
    s.groupid = "drop";
    s.name = "bone";
    s.script_label = "bone";
    fe [[ f ]]( s, us, cf, ( 54441.2, -29998.8, -118.75 ), ( 24.13, 84.96, -87.89 ), "cspf_0_auto13459615646600970452" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_alchemy_cs";
    s.groupid = "drop";
    s.name = "collar";
    s.script_label = "collar";
    fe [[ f ]]( s, us, cf, ( 54429.8, -29999.8, -120 ), ( 0, 176.2, -0 ), "cspf_0_auto13459615646600970452" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_alchemy_cs";
    s.groupid = "drop";
    s.name = "meat";
    s.script_label = "meat";
    fe [[ f ]]( s, us, cf, ( 54466, -29978.3, -119.25 ), ( 346.5, 180, -3.8 ), "cspf_0_auto13459615646600970452" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_alchemy_cs";
    s.groupid = "drop";
    s.name = "metal";
    s.script_label = "metal";
    fe [[ f ]]( s, us, cf, ( 54434.2, -30016.3, -120 ), ( 0, 116.2, -0 ), "cspf_0_auto13459615646600970452" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_alchemy_cs";
    s.groupid = "drop";
    s.name = "skull";
    s.script_label = "skull";
    fe [[ f ]]( s, us, cf, ( 54430.2, -29979.8, -118.5 ), ( 356.42, 178.74, -70.56 ), "cspf_0_auto13459615646600970452" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_alchemy_cs";
    fe [[ f ]]( s, us, cf, ( 54454, -29980, -108 ), ( 0, 120, 0 ), undefined, undefined, "alchemy_bowl_interact" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_alchemy_cs";
    fe [[ f ]]( s, us, cf, ( 54880.5, -29848.5, -100 ), ( 0, 120, 0 ), undefined, undefined, "alchemy_zombie_base_armored_heavy" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_alchemy_cs";
    s.groupid = "spawner";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 54695, -29933, -131 ), ( 0, 0, 0 ), "cspf_0_auto14625874852195518393" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_alchemy_cs";
    s.groupid = "spawner";
    fe [[ f ]]( s, us, cf, ( 54509, -29816, 139 ), ( 0, 0, 0 ), undefined, "cspf_0_auto14625874852195518393", "alchemy_spawner" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_alchemy_cs";
    s.groupid = "spawner";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 54574, -29849, -130 ), ( 0, 0, 0 ), "cspf_0_auto14625874852195518393" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_alchemy_cs";
    s.groupid = "spawner";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 54712, -29777, -131 ), ( 0, 0, 0 ), "cspf_0_auto14625874852195518393" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_alchemy_cs";
    s.groupid = "spawner";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 54497, -29779, -132 ), ( 0, 0, 0 ), "cspf_0_auto14625874852195518393" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_alchemy_cs";
    s.groupid = "material";
    s.name = "bone";
    s.script_label = "bone";
    fe [[ f ]]( s, us, cf, ( 54447.2, -29613.7, -124.19 ), ( 282.91, 0, 0 ), undefined, undefined, "alchemy_ee_material_bone" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_alchemy_cs";
    fe [[ f ]]( s, us, cf, ( 54919.5, -29758.8, -100 ), ( 0, 120, 0 ), undefined, undefined, "alchemy_zombie_methone" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_alchemy_cs";
    fe [[ f ]]( s, us, cf, ( 54814.8, -29730.8, -100 ), ( 0, 120, 0 ), undefined, undefined, "alchemy_zombie_mimic_hvt" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_alchemy_cs";
    fe [[ f ]]( s, us, cf, ( 54786.6, -29822.8, -100 ), ( 0, 120, 0 ), undefined, undefined, "alchemy_zombie_ghoul_hvt" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_mantis_quest_ee_alchemy_cs
// Params 0, eflags: 0x4
// Checksum 0xb406da44, Offset: 0xe8c
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_mantis_quest_ee_alchemy_cs
// Params 0
// Checksum 0xfc59fec7, Offset: 0xe96
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_mantis_quest_ee_alchemy_cs" );
}

