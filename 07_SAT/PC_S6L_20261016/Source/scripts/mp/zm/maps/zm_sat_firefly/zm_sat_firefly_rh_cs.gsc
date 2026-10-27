// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_rh_cs.gsc  (hash_2b1210b02e0b43f1.gscc) (size: 5364 Bytes / 0x14f4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7e576817 (2119657495)
// size ...... 5364 (0x14f4)
// includes .. 3   (offset: 0x11c4)
// strings ... 40  (offset: 0x11dc)
// dev strs .. 0   (offset: 0x14f4)
// exports ... 9   (offset: 0xe2c)
// cseg ...... 0x295 + 0xb97 (0xe2c)
// imports ... 20  (offset: 0xf94)
// animtree1 . 0   (offset: 0x14f4)
// animtree2 . 0   (offset: 0x14f4)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_firefly_rh_cs;

// Namespace zm_sat_firefly_rh_cs
// Params 0, eflags: 0x5
// Checksum 0x54b5c3bf, Offset: 0x2b3
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_rh_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_firefly_rh_cs
// Params 0, eflags: 0x4
// Checksum 0x9eb8eb78, Offset: 0x2d4
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_firefly_rh_cs
// Params 0, eflags: 0x4
// Checksum 0x1b833894, Offset: 0x2e5
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_firefly_rh_cs
// Params 2
// Checksum 0xab6a6edd, Offset: 0x2f6
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_rh_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_firefly_rh_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_rh_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_rh_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_rh_cs
// Params 3, eflags: 0x4
// Checksum 0x98018c5b, Offset: 0x37e
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_rh_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_rh_cs" );
}

// Namespace zm_sat_firefly_rh_cs
// Params 3, eflags: 0x4
// Checksum 0xe93e45ce, Offset: 0x3f8
// Size: 0xa14
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_rh_cs";
    s.name = "nail_item_1";
    fe [[ f ]]( s, us, cf, ( 8130.5, -5412.25, 803.75 ), ( 0, 0, 0 ), "nail_item_1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_rh_cs";
    s.name = "nail_item_1";
    fe [[ f ]]( s, us, cf, ( 10131.2, 1994.25, 785 ), ( 0, 0, 0 ), "nail_item_1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_rh_cs";
    s.name = "nail_item_1";
    fe [[ f ]]( s, us, cf, ( 2049.95, -777.25, 507.5 ), ( 0, 0, 0 ), "nail_item_1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_rh_cs";
    s.name = "nail_item_2";
    fe [[ f ]]( s, us, cf, ( 13122.2, -4988.75, 1172 ), ( 5.09, 264.45, -0.49 ), "nail_item_2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_rh_cs";
    s.name = "coffin_item_1";
    fe [[ f ]]( s, us, cf, ( 13304.5, -5544.75, 1306.25 ), ( 355.1, 27.59, 2.06 ), "coffin_item_1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_rh_cs";
    s.name = "coffin_item_2";
    fe [[ f ]]( s, us, cf, ( 13674, -5428.75, 818.5 ), ( 0.98, 309.79, 5.23 ), "coffin_item_2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_rh_cs";
    s.name = "coffin_item_3";
    fe [[ f ]]( s, us, cf, ( 13722.2, -5375.75, 613.25 ), ( 0.92, 315.39, 0.71 ), "coffin_item_3" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_rh_cs";
    s.name = "coffin_item_4";
    fe [[ f ]]( s, us, cf, ( 13722.2, -5375, 574.5 ), ( 0.92, 315.39, 0.71 ), "coffin_item_4" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_rh_cs";
    s.name = "lh44_item_3";
    fe [[ f ]]( s, us, cf, ( 17070.7, 1999.25, 1438.5 ), ( 306.26, 336.23, -58.32 ), "lh44_item", undefined, "3" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_rh_cs";
    s.name = "lh44_item_2";
    fe [[ f ]]( s, us, cf, ( 18113.7, 2882.25, 864.5 ), ( 276.91, 53.55, 83.25 ), "lh44_item", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_rh_cs";
    s.name = "lh44_item_1";
    fe [[ f ]]( s, us, cf, ( 21905.9, 3719.75, 881.25 ), ( 357.84, 147.56, -81.34 ), "lh44_item", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_rh_cs";
    s.name = "cl16_item_1";
    fe [[ f ]]( s, us, cf, ( 21488.2, 3673.75, 269 ), ( 358.88, 106.82, -82.33 ), "cl16_item", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_rh_cs";
    s.name = "cl16_item_2";
    fe [[ f ]]( s, us, cf, ( 18104.2, 2634, 562.75 ), ( 7.38, 18.34, -90.02 ), "cl16_item", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_rh_cs";
    s.name = "cl16_item_3";
    fe [[ f ]]( s, us, cf, ( 16958.9, 2184.25, 814.5 ), ( 2.75, 18.34, -90.02 ), "cl16_item", undefined, "3" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_rh_cs";
    s.name = "mt_mo_1";
    fe [[ f ]]( s, us, cf, ( 17773.7, 4829.95, 4929 ), ( 0, 0, 0 ), "mt_mo_1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_rh_cs";
    s.name = "lh44_item_1_anim";
    fe [[ f ]]( s, us, cf, ( 21885.9, 3687.75, 887 ), ( 357.84, 147.56, -81.34 ), "lh44_item_anim", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_rh_cs";
    s.name = "lh44_item_2_anim";
    fe [[ f ]]( s, us, cf, ( 18141.7, 2856.25, 865 ), ( 276.91, 53.55, 83.25 ), "lh44_item_anim", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_rh_cs";
    s.name = "mt_mo_2";
    fe [[ f ]]( s, us, cf, ( 15346.9, 1438.75, 837.25 ), ( 0, 0, -59.27 ), "mt_mo_2" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_rh_cs";
    s.name = "lh44_item_3_anim";
    fe [[ f ]]( s, us, cf, ( 17068.9, 2036.25, 1450.5 ), ( 306.26, 336.23, -58.32 ), "lh44_item_anim", undefined, "3" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_rh_cs";
    s.name = "mt_item";
    fe [[ f ]]( s, us, cf, ( 15346.2, 1438.75, 822.25 ), ( 282.6, 0, 0 ), "mt_item" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_rh_cs";
    s.name = "nail_item_3";
    fe [[ f ]]( s, us, cf, ( 13844.2, -5294.75, 577.5 ), ( 4.27, 303.4, 2.81 ), "nail_item_3" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_rh_cs";
    s.name = "lh44_item_4";
    fe [[ f ]]( s, us, cf, ( 21227.9, 3287.75, 886.75 ), ( 351.18, 215.03, -88.67 ), "lh44_item", undefined, "4" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_rh_cs";
    s.name = "lh44_item_4_anim";
    fe [[ f ]]( s, us, cf, ( 21248.4, 3258.75, 887.5 ), ( 351.18, 215.03, -88.67 ), "lh44_item_anim", undefined, "4" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_rh_cs";
    s.name = "cl16_item_4";
    fe [[ f ]]( s, us, cf, ( 21428.2, 3160.75, 225.5 ), ( 4.73, 106.84, -88.67 ), "cl16_item", undefined, "4" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_rh_cs";
    s.name = "lh44_item_5";
    fe [[ f ]]( s, us, cf, ( 20125.7, 2243.75, 733.75 ), ( 28.76, 340.77, -98.71 ), "lh44_item", undefined, "5" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_rh_cs";
    s.name = "lh44_item_5_anim";
    fe [[ f ]]( s, us, cf, ( 20139.4, 2294.75, 726.75 ), ( 28.76, 340.77, -98.71 ), "lh44_item_anim", undefined, "5" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_rh_cs";
    s.name = "lh44_item_6";
    fe [[ f ]]( s, us, cf, ( 17401.2, 3310.5, 1154 ), ( 304.68, 8.44, 134.25 ), "lh44_item", undefined, "6" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_rh_cs";
    s.name = "lh44_item_6_anim";
    fe [[ f ]]( s, us, cf, ( 17401.2, 3310.5, 1154 ), ( 304.68, 8.44, 134.25 ), "lh44_item_anim", undefined, "6" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_rh_cs";
    s.name = "cl16_item_5";
    fe [[ f ]]( s, us, cf, ( 20114.7, 2521.5, 296.5 ), ( 4.47, 18.34, -90.02 ), "cl16_item", undefined, "5" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_rh_cs";
    s.name = "cl16_item_6";
    fe [[ f ]]( s, us, cf, ( 17611.4, 3230, 659.25 ), ( 10.77, 18.34, -90.02 ), "cl16_item", undefined, "6" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_rh_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_rh_cs
// Params 0, eflags: 0x4
// Checksum 0xcc280a26, Offset: 0xe14
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_rh_cs
// Params 0
// Checksum 0x5a525116, Offset: 0xe1e
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_rh_cs" );
}

