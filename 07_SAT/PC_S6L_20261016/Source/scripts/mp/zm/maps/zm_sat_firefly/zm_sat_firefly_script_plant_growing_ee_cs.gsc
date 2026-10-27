// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_plant_growing_ee_cs.gsc  (hash_262bb2dbcf09549f.gscc) (size: 6862 Bytes / 0x1ace / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe521043e (3844146238)
// size ...... 6862 (0x1ace)
// includes .. 3   (offset: 0x177a)
// strings ... 21  (offset: 0x1792)
// dev strs .. 0   (offset: 0x1ace)
// exports ... 9   (offset: 0x13e2)
// cseg ...... 0x2a1 + 0x1141 (0x13e2)
// imports ... 20  (offset: 0x154a)
// animtree1 . 0   (offset: 0x1ace)
// animtree2 . 0   (offset: 0x1ace)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_firefly_script_plant_growing_ee_cs;

// Namespace zm_sat_firefly_script_plant_growing_ee_cs
// Params 0, eflags: 0x5
// Checksum 0x60dc10e0, Offset: 0x2bf
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_script_plant_growing_ee_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_firefly_script_plant_growing_ee_cs
// Params 0, eflags: 0x4
// Checksum 0xfeb15a43, Offset: 0x2e0
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_firefly_script_plant_growing_ee_cs
// Params 0, eflags: 0x4
// Checksum 0x7b8a89af, Offset: 0x2f1
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_firefly_script_plant_growing_ee_cs
// Params 2
// Checksum 0xcb63dfe6, Offset: 0x302
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_script_plant_growing_ee_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_firefly_script_plant_growing_ee_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_script_plant_growing_ee_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_script_plant_growing_ee_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_script_plant_growing_ee_cs
// Params 3, eflags: 0x4
// Checksum 0xf8083d60, Offset: 0x38a
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_script_plant_growing_ee_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_script_plant_growing_ee_cs" );
}

// Namespace zm_sat_firefly_script_plant_growing_ee_cs
// Params 3, eflags: 0x4
// Checksum 0x97385126, Offset: 0x404
// Size: 0xfbe
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    fe [[ f ]]( s, us, cf, ( -12697.7, 2907.13, 417.29 ), ( 0, 63.44, 0 ), undefined, "cspf_0_auto16563527296095327881", "ee_plant_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    fe [[ f ]]( s, us, cf, ( 13436, -4168.12, 792.95 ), ( 0, 0, 0 ), undefined, undefined, "ee_plant_fc_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    fe [[ f ]]( s, us, cf, ( 13341.6, -3863.53, 631.81 ), ( 0, 63.44, 0 ), undefined, "cspf_0_auto6339492938110982871", "ee_plant_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    fe [[ f ]]( s, us, cf, ( 13348.1, -3866.53, 631.81 ), ( 0, 63.44, 0 ), undefined, "cspf_0_auto6339492938110982871", "ee_plant_loc_survival" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_label = "disable_in_battlemode";
    fe [[ f ]]( s, us, cf, ( 24532.2, 792.16, 379.53 ), ( 0, 63.44, 0 ), undefined, "cspf_0_auto4119749688414372652", "ee_plant_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_label = "disable_in_battlemode";
    fe [[ f ]]( s, us, cf, ( 24975.8, 20.9, 414.14 ), ( 0, 63.44, 0 ), undefined, "cspf_0_auto16896084330960379358", "ee_plant_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    fe [[ f ]]( s, us, cf, ( -13019.2, 4738.45, 417.95 ), ( 0, 99.9, 0 ), undefined, "cspf_0_auto5715952172446812869", "ee_plant_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    fe [[ f ]]( s, us, cf, ( 12976.5, 2642.14, 1024.63 ), ( 0, 63.44, 0 ), undefined, "cspf_0_auto9193234221379824308", "ee_plant_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    fe [[ f ]]( s, us, cf, ( 14883.2, 2206.07, 900.65 ), ( 1.4, 63.34, -2.83 ), undefined, "cspf_0_auto15469442855259194373", "ee_plant_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    fe [[ f ]]( s, us, cf, ( 2887.17, -3156.7, 425.94 ), ( 0, 63.44, 0 ), undefined, "cspf_0_auto7341632354855363469", "ee_plant_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    fe [[ f ]]( s, us, cf, ( 2794.7, 204.09, 474.7 ), ( 0, 63.44, 0 ), undefined, "cspf_0_auto5229459599152170833", "ee_plant_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    fe [[ f ]]( s, us, cf, ( 14059.5, -3151.82, 636.53 ), ( 0, 63.44, 0 ), undefined, "cspf_0_auto14676321087327851549", "ee_plant_loc_survival" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    fe [[ f ]]( s, us, cf, ( 14977.5, -3224.75, 605.5 ), ( 0, 63.44, 0 ), undefined, "cspf_0_auto1937261023226621078", "ee_plant_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    fe [[ f ]]( s, us, cf, ( 14984, -3227.75, 605.5 ), ( 0, 63.44, 0 ), undefined, "cspf_0_auto1937261023226621078", "ee_plant_loc_survival" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    fe [[ f ]]( s, us, cf, ( 14729.2, -3271.66, 652.38 ), ( 0, 0, 0 ), undefined, undefined, "ee_plant_fc_loc_sm" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    fe [[ f ]]( s, us, cf, ( 13758.6, -3420.12, 726.43 ), ( 0, 0, 0 ), undefined, undefined, "ee_plant_fc_loc_sm" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    fe [[ f ]]( s, us, cf, ( 13855.8, -3995.51, 412.31 ), ( 0, 0, 0 ), undefined, undefined, "ee_plant_fc_loc_sm" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    fe [[ f ]]( s, us, cf, ( 12721.8, 3054.39, 1071.45 ), ( 0, 105.78, 0 ), undefined, undefined, "ee_plant_fc_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 13608.8, -4084.84, 605.96 ), ( 0, 133.1, 0 ), "cspf_0_auto6339492938110982871" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 13024.7, -4125.82, 614.25 ), ( 0, 43.5, 0 ), "cspf_0_auto6339492938110982871" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 13158.8, -3601.71, 645.84 ), ( 0, 313, 0 ), "cspf_0_auto6339492938110982871" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 13700.2, -3087.28, 644.31 ), ( 0, 360, 0 ), "cspf_0_auto14676321087327851549" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 13987, -2852.53, 648.49 ), ( 0, 270, 0 ), "cspf_0_auto14676321087327851549" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_label = "disable_in_sm";
    fe [[ f ]]( s, us, cf, ( 2966.12, -2672.81, 549.12 ), ( 356, 326.03, -9.97 ), undefined, undefined, "ee_plant_fc_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 14391.2, -3192.25, 621.6 ), ( 0, 165, 0 ), "cspf_0_auto14676321087327851549" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 14914, -3088.71, 613.65 ), ( 0, 270, 0 ), "cspf_0_auto1937261023226621078" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 14460.1, -3359.05, 612.92 ), ( 0, 353.5, 0 ), "cspf_0_auto1937261023226621078" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 14978.9, -3709.34, 604.39 ), ( 0, 108.1, 0 ), "cspf_0_auto1937261023226621078" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 24510.9, -44.85, 385.1 ), ( 0, 3.9, 0 ), "cspf_0_auto16896084330960379358" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 25189.6, 617.48, 421.91 ), ( 0, 270.3, 0 ), "cspf_0_auto16896084330960379358" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 25432.4, 58.53, 448.06 ), ( 0, 184.4, 0 ), "cspf_0_auto16896084330960379358" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 24265.2, 288.47, 316.51 ), ( 0, 65.2, 0 ), "cspf_0_auto4119749688414372652" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 24760.2, 626.02, 420.62 ), ( 0, 178.6, 0 ), "cspf_0_auto4119749688414372652" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 24616.8, 1401.86, 322.33 ), ( 0, 256.4, 0 ), "cspf_0_auto4119749688414372652" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 3187.94, -2871.9, 419.7 ), ( 0, 255, 0 ), "cspf_0_auto7341632354855363469" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 2585.63, -3384.79, 496.44 ), ( 0, 25.4, 0 ), "cspf_0_auto7341632354855363469" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 3049.99, -3574.3, 498.81 ), ( 0, 105, 0 ), "cspf_0_auto7341632354855363469" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 2404, 329.56, 587.39 ), ( 0, 345, 0 ), "cspf_0_auto5229459599152170833" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 2621.85, -91.29, 373.07 ), ( 0, 30.3, 0 ), "cspf_0_auto5229459599152170833" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 3387.64, 482.19, 483.28 ), ( 0, 195, 0 ), "cspf_0_auto5229459599152170833" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 12497.8, 2627.87, 1031.88 ), ( 0, 358.98, 0 ), "cspf_0_auto9193234221379824308" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 13081.4, 3131.62, 905.03 ), ( 0, 264.2, 0 ), "cspf_0_auto9193234221379824308" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 12582.4, 2445.18, 1031.68 ), ( 0, 29.3, 0 ), "cspf_0_auto9193234221379824308" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 14390.3, 1997.22, 931.08 ), ( 0, 2.6, 0 ), "cspf_0_auto15469442855259194373" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 14836.7, 2609.92, 899.37 ), ( 0, 279.6, 0 ), "cspf_0_auto15469442855259194373" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 14539.8, 1808.78, 942.14 ), ( 0, 56.2, 0 ), "cspf_0_auto15469442855259194373" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( -12554.5, 3312.93, 431.61 ), ( 0, 237.2, 0 ), "cspf_0_auto16563527296095327881" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( -12962.6, 2675.28, 436.44 ), ( 0, 45.2, 0 ), "cspf_0_auto16563527296095327881" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( -12354.1, 2902.55, 428.89 ), ( 0, 151.4, 0 ), "cspf_0_auto16563527296095327881" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( -12964.6, 4220.84, 424.3 ), ( 0, 74.2, 0 ), "cspf_0_auto5715952172446812869" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_label = "disable_in_battlemode";
    fe [[ f ]]( s, us, cf, ( 24685.8, 857.48, 384 ), ( 0, 0, 0 ), undefined, undefined, "ee_plant_fc_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( -13332, 4696.62, 425.27 ), ( 0, 7.86, 0 ), "cspf_0_auto5715952172446812869" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_plant_growing_ee_cs";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( -12510, 4657.56, 428.31 ), ( 0, 182.3, 0 ), "cspf_0_auto5715952172446812869" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_script_plant_growing_ee_cs
// Params 0, eflags: 0x4
// Checksum 0xcd5f45b8, Offset: 0x13ca
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_script_plant_growing_ee_cs
// Params 0
// Checksum 0x3a5be02d, Offset: 0x13d4
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_script_plant_growing_ee_cs" );
}

