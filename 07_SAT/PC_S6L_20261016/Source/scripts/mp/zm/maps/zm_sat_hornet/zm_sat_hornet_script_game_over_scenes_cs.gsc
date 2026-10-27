// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_script_game_over_scenes_cs.gsc  (hash_734a72450f1409d6.gscc) (size: 7821 Bytes / 0x1e8d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9e44fd14 (2655321364)
// size ...... 7821 (0x1e8d)
// includes .. 2   (offset: 0x1aa5)
// strings ... 15  (offset: 0x1ab5)
// dev strs .. 0   (offset: 0x1e8d)
// exports ... 6   (offset: 0x17f5)
// cseg ...... 0x208 + 0x15ed (0x17f5)
// imports ... 16  (offset: 0x18e5)
// animtree1 . 0   (offset: 0x1e8d)
// animtree2 . 0   (offset: 0x1e8d)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_hornet_script_game_over_scenes_cs;

// Namespace zm_sat_hornet_script_game_over_scenes_cs
// Params 2
// Checksum 0x2f8065db, Offset: 0x226
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_hornet_script_game_over_scenes_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_hornet_script_game_over_scenes_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_hornet_script_game_over_scenes_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_hornet_script_game_over_scenes_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_hornet_script_game_over_scenes_cs
// Params 3, eflags: 0x4
// Checksum 0x1ceb875d, Offset: 0x2ae
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_hornet_script_game_over_scenes_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_hornet_script_game_over_scenes_cs" );
}

// Namespace zm_sat_hornet_script_game_over_scenes_cs
// Params 3, eflags: 0x4
// Checksum 0xc40f8d8a, Offset: 0x328
// Size: 0x14ad
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.groupid = "BlackList";
    s.script_string = "fire,orion";
    fe [[ f ]]( s, us, cf, ( 53.8, -22295.7, 183.71 ), ( 6.12, 217.15, -0.84 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.groupid = "BlackList";
    s.script_string = "fire,orion";
    fe [[ f ]]( s, us, cf, ( 2879.92, -20672.6, 383.38 ), ( 1.09, 258.71, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.groupid = "BlackList";
    s.script_string = "fire,orion";
    fe [[ f ]]( s, us, cf, ( -1430.02, -21661.6, 260.87 ), ( 359.93, 177.81, -1.11 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.script_parameters = "zombie_orion|zombie_orion_hvt_mq|zombie_orion_hvt_sq";
    fe [[ f ]]( s, us, cf, ( 675.79, -23767.5, 175.49 ), ( 0, 85.89, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.script_parameters = "zombie_hellhound";
    fe [[ f ]]( s, us, cf, ( 1146.28, -23062.9, 132.58 ), ( 0, 180, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.groupid = "BlackList";
    s.script_string = "fire,orion";
    fe [[ f ]]( s, us, cf, ( -209.14, -19021.6, 831.41 ), ( 0.12, 122.42, -0.56 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.groupid = "BlackList";
    s.script_string = "fire,orion";
    fe [[ f ]]( s, us, cf, ( -819.3, -17962.5, 1190.57 ), ( 359.92, 102.97, -0.57 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.script_string = "fire,orion";
    fe [[ f ]]( s, us, cf, ( 266.01, -17303, 1344 ), ( 0, 283.01, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.script_parameters = "zombie_orion|zombie_orion_hvt_mq|zombie_orion_hvt_sq";
    fe [[ f ]]( s, us, cf, ( 1238.78, -23062.9, 132.58 ), ( 0, 180, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.groupid = "BlackList";
    s.script_string = "fire,orion,duo_02";
    fe [[ f ]]( s, us, cf, ( -1313.17, -17064.2, 1184.01 ), ( 0.57, 192.97, -0.08 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.script_string = "fire,orion";
    fe [[ f ]]( s, us, cf, ( 25.05, -17399.7, 1183.91 ), ( 0, 0, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.script_parameters = "zombie_orion|zombie_orion_hvt_mq|zombie_orion_hvt_sq";
    fe [[ f ]]( s, us, cf, ( 3168.34, -22557, 258.4 ), ( 0, 90, -0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.script_string = "fire,orion";
    fe [[ f ]]( s, us, cf, ( 33767, 43262.5, 16722.5 ), ( 0, 255.15, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.script_parameters = "zombie_hellhound";
    fe [[ f ]]( s, us, cf, ( 3153.84, -22630, 258.4 ), ( 0, 90, -0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.script_string = "fire,orion";
    fe [[ f ]]( s, us, cf, ( 32368, -32560, 2096 ), ( 0, 0, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.groupid = "BlackList";
    s.script_string = "fire,solo_01,solo_02,orion";
    fe [[ f ]]( s, us, cf, ( 231.06, -24459.2, 229.29 ), ( 0, 292.8, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.script_parameters = "zombie_hellhound";
    fe [[ f ]]( s, us, cf, ( 2883.33, -20678, 383.67 ), ( 0, 220.31, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.groupid = "BlackList";
    s.script_string = "fire,orion,solo_01";
    fe [[ f ]]( s, us, cf, ( 688.39, -23687.5, 173.79 ), ( 0, 183.2, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.groupid = "BlackList";
    s.script_string = "fire,orion";
    fe [[ f ]]( s, us, cf, ( 2964.42, -23747.9, 81.67 ), ( 0, 90, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.groupid = "BlackList";
    s.script_string = "fire,orion";
    fe [[ f ]]( s, us, cf, ( 1812.4, -23061.4, 226.65 ), ( 360, 0, -0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.groupid = "BlackList";
    s.script_string = "fire,orion";
    fe [[ f ]]( s, us, cf, ( 2894.34, -22557, 258.4 ), ( 0, 90, -0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.script_parameters = "zombie_orion|zombie_orion_hvt_mq|zombie_orion_hvt_sq";
    fe [[ f ]]( s, us, cf, ( 1520.26, -21014.7, 513.27 ), ( 1.11, 267.62, -0.07 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.groupid = "BlackList";
    s.script_string = "fire,orion";
    fe [[ f ]]( s, us, cf, ( 936.15, -22571.6, 144 ), ( 359.92, 102.97, -0.57 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.groupid = "BlackList";
    s.script_string = "fire,orion";
    fe [[ f ]]( s, us, cf, ( -498.57, -22952.7, 166.09 ), ( 0, 92.82, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.script_parameters = "zombie_orion|zombie_orion_hvt_mq|zombie_orion_hvt_sq|zombie_hellhound";
    fe [[ f ]]( s, us, cf, ( 33732.8, 43252.5, 16724 ), ( 0, 312.64, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.script_parameters = "zombie_orion|zombie_orion_hvt_mq|zombie_orion_hvt_sq|zombie_hellhound";
    fe [[ f ]]( s, us, cf, ( -2029.42, -22743.9, 128.74 ), ( 0, 2.82, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.script_parameters = "zombie_orion|zombie_orion_hvt_mq|zombie_orion_hvt_sq";
    fe [[ f ]]( s, us, cf, ( -231, -22440, 139.71 ), ( 0, 270.1, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.groupid = "BlackList";
    s.script_string = "fire,orion";
    fe [[ f ]]( s, us, cf, ( -18804.3, -58097, 3125.65 ), ( 0, 50.8, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.groupid = "BlackList";
    s.script_string = "fire,orion";
    fe [[ f ]]( s, us, cf, ( -2067.13, -21619.6, 290.25 ), ( 0, 173.02, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.groupid = "BlackList";
    s.script_string = "fire,orion";
    fe [[ f ]]( s, us, cf, ( -752.14, -20790.8, 543.12 ), ( 360, 181.39, -1.11 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.groupid = "BlackList";
    s.script_string = "fire,orion";
    fe [[ f ]]( s, us, cf, ( -522.75, -21152.4, 525.62 ), ( 358.89, 91.39, -0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.groupid = "BlackList";
    s.script_string = "fire,orion";
    fe [[ f ]]( s, us, cf, ( 508.11, -20072.9, 640 ), ( 359.18, 48.97, 0.75 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.groupid = "BlackList";
    s.script_string = "fire,orion,duo_02";
    fe [[ f ]]( s, us, cf, ( -680.86, -20150, 640.24 ), ( 359.92, 5.28, 1.11 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.script_parameters = "zombie_orion|zombie_orion_hvt_mq|zombie_orion_hvt_sq";
    fe [[ f ]]( s, us, cf, ( -18826.8, -58051, 3123 ), ( 0, 0, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.script_parameters = "zombie_hellhound";
    fe [[ f ]]( s, us, cf, ( 42.05, -22280.2, 183.96 ), ( 6.12, 217.15, -0.84 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.groupid = "BlackList";
    s.script_string = "fire,orion,solo_01,solo_02";
    fe [[ f ]]( s, us, cf, ( 805.34, -20869.5, 522.33 ), ( 0.76, 224.68, -0.81 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.groupid = "BlackList";
    s.script_string = "fire,orion";
    fe [[ f ]]( s, us, cf, ( 1519.76, -21008.7, 512.27 ), ( 0, 5.28, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.groupid = "BlackList";
    s.script_string = "fire,orion";
    fe [[ f ]]( s, us, cf, ( 2076.83, -20914.5, 387.31 ), ( 359.59, 159.63, -1.03 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.groupid = "BlackList";
    s.script_string = "fire,orion";
    fe [[ f ]]( s, us, cf, ( 2642.56, -20196.6, 400.04 ), ( 359.84, 173.2, -1.1 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.groupid = "BlackList";
    s.script_string = "fire,orion";
    fe [[ f ]]( s, us, cf, ( 3321.65, -20887.3, 395.34 ), ( 2.79, 200.81, 4.7 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.script_string = "fire,orion";
    fe [[ f ]]( s, us, cf, ( -278.92, -19699.8, 768 ), ( 0, 11.01, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.groupid = "BlackList";
    s.script_string = "fire,orion";
    fe [[ f ]]( s, us, cf, ( 175.61, -18780.8, 1184.5 ), ( 0.28, 261.51, 0.5 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.groupid = "BlackList";
    s.script_string = "fire,orion,solo_03";
    fe [[ f ]]( s, us, cf, ( 265.42, -17776.9, 1184.5 ), ( 0.19, 271.22, 0.54 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.script_string = "fire,orion";
    fe [[ f ]]( s, us, cf, ( -1101.21, -18217.8, 1024 ), ( 0, 98.69, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.script_string = "fire,orion";
    fe [[ f ]]( s, us, cf, ( -819.34, -18940.4, 1024 ), ( 0, 188.69, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.groupid = "BlackList";
    s.script_string = "fire,orion";
    fe [[ f ]]( s, us, cf, ( -429.43, -17200.2, 1184.01 ), ( 359.92, 102.97, -0.57 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.script_string = "fire,orion";
    fe [[ f ]]( s, us, cf, ( 1146.28, -23062.9, 130.83 ), ( 0, 180, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.script_string = "fire,orion";
    fe [[ f ]]( s, us, cf, ( -2852.17, -22607.4, 128 ), ( 0, 359.67, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.groupid = "BlackList";
    s.script_string = "fire,orion";
    fe [[ f ]]( s, us, cf, ( -2029.42, -22743.9, 128.73 ), ( 0, 2.82, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.script_parameters = "zombie_hellhound";
    fe [[ f ]]( s, us, cf, ( -2833.17, -22564.4, 129.45 ), ( 0, 44.67, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.script_parameters = "zombie_orion|zombie_orion_hvt_mq|zombie_orion_hvt_sq";
    fe [[ f ]]( s, us, cf, ( -2878.42, -22623.4, 129.45 ), ( 0, 44.67, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.script_parameters = "zombie_orion|zombie_orion_hvt_mq|zombie_orion_hvt_sq";
    fe [[ f ]]( s, us, cf, ( -522.75, -21152.4, 525.62 ), ( 358.89, 91.39, -0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.script_parameters = "zombie_hellhound";
    fe [[ f ]]( s, us, cf, ( 144.55, -19581.9, 768 ), ( 359.67, 163.48, -1.06 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.script_parameters = "zombie_orion|zombie_orion_hvt_mq|zombie_orion_hvt_sq";
    fe [[ f ]]( s, us, cf, ( 175.61, -18780.8, 1184.5 ), ( 0.28, 261.51, 0.5 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.script_parameters = "zombie_orion|zombie_orion_hvt_mq|zombie_orion_hvt_sq";
    fe [[ f ]]( s, us, cf, ( -1101.21, -18217.8, 1024 ), ( 0, 98.69, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.script_parameters = "zombie_orion|zombie_orion_hvt_mq|zombie_orion_hvt_sq";
    fe [[ f ]]( s, us, cf, ( 492.52, -17097.8, 1344 ), ( 0, 0, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.script_parameters = "zombie_hellhound";
    fe [[ f ]]( s, us, cf, ( 566.52, -17104.7, 1344 ), ( 0, 195.3, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.script_parameters = "zombie_hellhound";
    fe [[ f ]]( s, us, cf, ( -18919.2, -57987.2, 3123.97 ), ( 0, 332.41, 0 ), undefined, undefined, "zombie_game_over_scene" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_script_game_over_scenes_cs";
    s.name = "sat_cin_zm_vig_plr_dth_diana";
    s.script_scenescriptbundle = "sat_cin_zm_vig_plr_dth_diana";
    fe [[ f ]]( s, us, cf, ( 33761, 43259, 16722.3 ), ( 0, 149.19, 0 ), "sat_cin_zm_vig_plr_dth_diana", undefined, "zombie_game_over_scene" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_hornet_script_game_over_scenes_cs
// Params 0, eflags: 0x4
// Checksum 0x9d72bfce, Offset: 0x17dd
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_hornet_script_game_over_scenes_cs
// Params 0
// Checksum 0xdeb85a10, Offset: 0x17e7
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_hornet_script_game_over_scenes_cs" );
}

