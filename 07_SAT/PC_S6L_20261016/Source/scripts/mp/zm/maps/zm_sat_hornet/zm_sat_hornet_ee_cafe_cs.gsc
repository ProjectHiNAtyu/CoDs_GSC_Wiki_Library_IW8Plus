// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ee_cafe_cs.gsc  (hash_344bfd1ab3b7d37d.gscc) (size: 9251 Bytes / 0x2423 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xec7872bd (3967316669)
// size ...... 9251 (0x2423)
// includes .. 2   (offset: 0x1e3f)
// strings ... 55  (offset: 0x1e4f)
// dev strs .. 0   (offset: 0x2423)
// exports ... 6   (offset: 0x1b8f)
// cseg ...... 0x36b + 0x1824 (0x1b8f)
// imports ... 16  (offset: 0x1c7f)
// animtree1 . 0   (offset: 0x2423)
// animtree2 . 0   (offset: 0x2423)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_hornet_ee_cafe_cs;

// Namespace zm_sat_hornet_ee_cafe_cs
// Params 2
// Checksum 0xa8e89e3a, Offset: 0x389
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_hornet_ee_cafe_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_hornet_ee_cafe_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_hornet_ee_cafe_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_hornet_ee_cafe_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_hornet_ee_cafe_cs
// Params 3, eflags: 0x4
// Checksum 0x9b837cbc, Offset: 0x411
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_hornet_ee_cafe_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_hornet_ee_cafe_cs" );
}

// Namespace zm_sat_hornet_ee_cafe_cs
// Params 3, eflags: 0x4
// Checksum 0x6113c813, Offset: 0x48b
// Size: 0x16e4
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "table";
    fe [[ f ]]( s, us, cf, ( -1624, -20711, 284 ), ( 0, 352.2, 0 ), "cc_prop", undefined, "low_ta" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "table";
    fe [[ f ]]( s, us, cf, ( -1622, -20665, 284 ), ( 0, 289.9, 0 ), "cc_prop", undefined, "low_ch" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "khau";
    fe [[ f ]]( s, us, cf, ( -1710.5, -20624.2, 296.7 ), ( 0, 4.3, 0 ), "cc_hau_ins" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "toy";
    fe [[ f ]]( s, us, cf, ( -1633, -20710, 303.56 ), ( 0, 93.6, 0 ), "cc_prop", undefined, "cc_b1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "tow";
    fe [[ f ]]( s, us, cf, ( -1454, -20667, 281.63 ), ( 0, 275.3, 0 ), "cc_prop", undefined, "cc_t1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "toy";
    fe [[ f ]]( s, us, cf, ( -1710, -20623, 293.67 ), ( 0, 80.1, 0 ), "cc_prop", undefined, "cc_b3" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "tow";
    fe [[ f ]]( s, us, cf, ( -1565, -20579, 285.8 ), ( 0, 3.6, 0 ), "cc_prop", undefined, "cc_t1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "table";
    fe [[ f ]]( s, us, cf, ( -1629, -20757, 286 ), ( 0, 66.6, 0 ), "cc_prop", undefined, "low_ch" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "toy";
    fe [[ f ]]( s, us, cf, ( -1694, -20692, 320.82 ), ( 0, 93.6, 0 ), "cc_prop", undefined, "cc_ba2" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "toy";
    fe [[ f ]]( s, us, cf, ( -1701, -20691, 316.91 ), ( 0, 12.9, 0 ), "cc_prop", undefined, "cc_b2" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 128;
    fe [[ f ]]( s, us, cf, ( -1445, -20665, 357 ), ( 0, 0, 0 ), "cc_pusht", undefined, undefined, undefined, undefined, undefined, undefined, 30 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "wal";
    fe [[ f ]]( s, us, cf, ( -1635, -20560, 348 ), ( 0, 5, 0 ), "cc_prop", undefined, "cc_sig" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "table";
    fe [[ f ]]( s, us, cf, ( -1626, -20731, 303.42 ), ( 0, 352.2, 0 ), "cc_prop", undefined, "sus_02" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "table";
    fe [[ f ]]( s, us, cf, ( -1619, -20692, 303 ), ( 0, 348.3, 0 ), "cc_prop", undefined, "sus_01" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "toy";
    fe [[ f ]]( s, us, cf, ( -1709, -20626, 296.47 ), ( 0, 3.6, 0 ), "cc_prop", undefined, "cc_ba2" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "toy";
    fe [[ f ]]( s, us, cf, ( -1454.48, -20675.1, 339.56 ), ( 0, 286.5, 0 ), "cc_prop", undefined, "mo_to" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "toy";
    fe [[ f ]]( s, us, cf, ( -1614, -20714, 303.56 ), ( 0, 293.8, 0 ), "cc_prop", undefined, "cc_mo1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "toy";
    fe [[ f ]]( s, us, cf, ( -1623, -20727, 284.51 ), ( 0, 310.9, 0 ), "cc_prop", undefined, "cc_ba1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    fe [[ f ]]( s, us, cf, ( -1558, -20655, 407 ), ( 0, 0, 0 ), "cc_prop", undefined, "cc_lit" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 128;
    s.length = "128";
    s.name = "noent_volume_trigger_box";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -1577, -20821, 261 ), ( 0, 0, 0 ), "cc_thau", undefined, undefined, undefined, undefined, undefined, undefined, 650 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 128;
    fe [[ f ]]( s, us, cf, ( -1563, -20569, 357 ), ( 0, 0, 0 ), "cc_pusht", undefined, undefined, undefined, undefined, undefined, undefined, 30 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "sus";
    fe [[ f ]]( s, us, cf, ( -1702.33, -20711.2, 344.31 ), ( 0, 106.1, 0 ), "cc_prop", undefined, "sus_cat" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "sus";
    fe [[ f ]]( s, us, cf, ( -1702.07, -20711.8, 344.31 ), ( 0, 106.1, 0 ), "cc_prop", undefined, "sus_ro" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "wal";
    fe [[ f ]]( s, us, cf, ( -1435.38, -20645.1, 369 ), ( 359.2, 185, -0.28 ), "cc_prop", undefined, "cc_pain" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "wal";
    fe [[ f ]]( s, us, cf, ( -1432.38, -20679.1, 354 ), ( 359.2, 185, -0.28 ), "cc_prop", undefined, "cc_pain" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "wal";
    fe [[ f ]]( s, us, cf, ( -1438.38, -20611.1, 354 ), ( 359.2, 185, -0.28 ), "cc_prop", undefined, "cc_pain" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "kloc";
    fe [[ f ]]( s, us, cf, ( -1377, -23551, 314.01 ), ( 0, 180, 0 ), "cc_lookit", "cspf_0_auto12472817113467871892", "dark" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "kloc";
    fe [[ f ]]( s, us, cf, ( -2094, -21388, 450 ), ( 0, 90, 0 ), "cc_lookit", "cspf_0_auto5382895645839128848" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "kloc";
    fe [[ f ]]( s, us, cf, ( 1546, -23450, 232 ), ( 0, 180, 0 ), "cc_lookit", "cspf_0_auto234072284845792163", "sand" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "kloc";
    fe [[ f ]]( s, us, cf, ( 1431, -22685, 225.39 ), ( 0, 307, 0 ), "cc_lookit", "cspf_0_auto15098422749772140268", "sand" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "kloc";
    fe [[ f ]]( s, us, cf, ( 2462, -21847, 418 ), ( 0, 180.9, 0 ), "cc_lookit", "cspf_0_auto14476865466433002094", "dark" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "khau";
    fe [[ f ]]( s, us, cf, ( -1634.63, -20662.6, 523.86 ), ( 0, 278.5, 0 ), "cc_hau" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "khau";
    fe [[ f ]]( s, us, cf, ( -1614.56, -20660.9, 523.86 ), ( 0, 278.5, 0 ), "cc_hau" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "khau";
    fe [[ f ]]( s, us, cf, ( -1594.48, -20659.1, 523.86 ), ( 0, 278.5, 0 ), "cc_hau" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "khau";
    fe [[ f ]]( s, us, cf, ( -1574.06, -20657.4, 523.86 ), ( 0, 278.5, 0 ), "cc_hau" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "khau";
    fe [[ f ]]( s, us, cf, ( -1556.36, -20654.4, 523.86 ), ( 0, 278.5, 0 ), "cc_hau" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "kloc";
    fe [[ f ]]( s, us, cf, ( 785, -19969, 649.13 ), ( 0, 122.8, 0 ), "cc_lookit", "cspf_0_auto17620749757609089173", "orange" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "kloc";
    fe [[ f ]]( s, us, cf, ( -548, -19687, 933.13 ), ( 0, 349.3, 0 ), "cc_lookit", "cspf_0_auto6288229511486445827", "orange" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "kloc";
    fe [[ f ]]( s, us, cf, ( 349, -18124, 1312 ), ( 0, 195.3, 0 ), "cc_lookit", "cspf_0_auto12617911437775307725" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "spa";
    fe [[ f ]]( s, us, cf, ( -1591, -21085, 281.13 ), ( 0, 90, 0 ), "cc_plsp" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 136, 128, 128 );
    s._size_min = ( 178, 128, 196 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -1554, -20639, 283 ), ( 0, 0, 0 ), "cc_hhdea" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "spa";
    fe [[ f ]]( s, us, cf, ( -1640, -21085, 273.8 ), ( 0, 90, 0 ), "cc_plsp" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "spa";
    fe [[ f ]]( s, us, cf, ( -1536, -21085, 294.94 ), ( 0, 90, 0 ), "cc_plsp" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "spa";
    fe [[ f ]]( s, us, cf, ( -1480, -21085, 311.36 ), ( 0, 90, 0 ), "cc_plsp" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "mloc";
    fe [[ f ]]( s, us, cf, ( -1425, -23680, 149.83 ), ( 0, 238, 0 ), "cspf_0_auto12472817113467871892", undefined, "cc_findmo" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "mloc";
    fe [[ f ]]( s, us, cf, ( -2092, -21531, 293.5 ), ( 0, 47.4, 0 ), "cspf_0_auto5382895645839128848", undefined, "cc_findmo" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "mloc";
    fe [[ f ]]( s, us, cf, ( 1525, -23267, 226 ), ( 0, 145.6, 0 ), "cspf_0_auto234072284845792163", undefined, "cc_findmo" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "mloc";
    fe [[ f ]]( s, us, cf, ( 1732, -22648, 225.57 ), ( 0, 57.5, 0 ), "cspf_0_auto15098422749772140268", undefined, "cc_findmo" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "mloc";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 2725, -21700, 408 ), ( 0, 187.3, 0 ), "cspf_0_auto14476865466433002094", undefined, "cc_findmo" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "mloc";
    fe [[ f ]]( s, us, cf, ( 412, -20307, 599.39 ), ( 0, 257.1, 0 ), "cspf_0_auto17620749757609089173", undefined, "cc_findmo" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "mloc";
    fe [[ f ]]( s, us, cf, ( -447, -19592, 786.82 ), ( 0, 41.4, 0 ), "cspf_0_auto6288229511486445827", undefined, "cc_findmo" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "mloc";
    fe [[ f ]]( s, us, cf, ( 453, -17986, 1203 ), ( 0, 303, 0 ), "cspf_0_auto12617911437775307725", undefined, "cc_findmo" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "toy";
    fe [[ f ]]( s, us, cf, ( -1633, -20711, 306.82 ), ( 0, 145.3, 0 ), "cc_prop", undefined, "mo_to" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "khau";
    fe [[ f ]]( s, us, cf, ( -1700.22, -20690.5, 320.86 ), ( 0, 282.5, 0 ), "cc_hau_ins" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "khau";
    fe [[ f ]]( s, us, cf, ( -1633.5, -20710.2, 307.86 ), ( 0, 12.5, 0 ), "cc_hau_ins" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "khau";
    fe [[ f ]]( s, us, cf, ( -1557.78, -20582.5, 362.86 ), ( 0, 300.9, 0 ), "cc_hau_ins" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "khau";
    fe [[ f ]]( s, us, cf, ( -1452.66, -20665.3, 338.86 ), ( 0, 239.4, 0 ), "cc_hau_ins" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "khau";
    fe [[ f ]]( s, us, cf, ( -1456.9, -20658.9, 306.86 ), ( 0, 153.8, 0 ), "cc_hau_ins" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "table";
    fe [[ f ]]( s, us, cf, ( -1627, -20697, 306 ), ( 0, 352.2, 0 ), "cc_pk_rw" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "table";
    fe [[ f ]]( s, us, cf, ( -1635, -20726, 306 ), ( 0, 262.2, 0 ), "cc_pk_rw" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "found";
    fe [[ f ]]( s, us, cf, ( -1695, -20738, 315.82 ), ( 0, 71.3, 0 ), "cc_fo_loc", undefined, "mo_to" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "found";
    fe [[ f ]]( s, us, cf, ( -1695, -20724, 315.82 ), ( 0, 98.5, 0 ), "cc_fo_loc", undefined, "mo_to" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "found";
    fe [[ f ]]( s, us, cf, ( -1690, -20735, 315.82 ), ( 0, 3.6, 0 ), "cc_fo_loc", undefined, "mo_to" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "found";
    fe [[ f ]]( s, us, cf, ( -1691, -20731, 315.82 ), ( 0, 126.1, 0 ), "cc_fo_loc", undefined, "mo_to" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "found";
    fe [[ f ]]( s, us, cf, ( -1692, -20727, 315.82 ), ( 0, 84.7, 0 ), "cc_fo_loc", undefined, "mo_to" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "wal";
    fe [[ f ]]( s, us, cf, ( -1439.38, -20573.1, 334 ), ( 359.61, 185.05, -4.86 ), "cc_prop", undefined, "cc_pain" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_cafe_cs";
    s.groupid = "wal";
    fe [[ f ]]( s, us, cf, ( -1432.38, -20707.1, 303 ), ( 347.64, 184.92, 8.06 ), "cc_prop", undefined, "cc_pain" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_hornet_ee_cafe_cs
// Params 0, eflags: 0x4
// Checksum 0xfc014ee5, Offset: 0x1b77
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_hornet_ee_cafe_cs
// Params 0
// Checksum 0x59d0a1f1, Offset: 0x1b81
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_hornet_ee_cafe_cs" );
}

