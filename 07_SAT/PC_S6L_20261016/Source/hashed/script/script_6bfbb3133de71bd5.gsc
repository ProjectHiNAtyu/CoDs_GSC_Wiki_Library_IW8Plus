// script_6bfbb3133de71bd5  (hash_6bfbb3133de71bd5.gscc) (size: 14549 Bytes / 0x38d5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9d4fa56e (2639242606)
// size ...... 14549 (0x38d5)
// includes .. 2   (offset: 0x32f9)
// strings ... 47  (offset: 0x3309)
// dev strs .. 0   (offset: 0x38d5)
// exports ... 6   (offset: 0x3065)
// cseg ...... 0x614 + 0x2a51 (0x3065)
// imports ... 15  (offset: 0x3155)
// animtree1 . 0   (offset: 0x38d5)
// animtree2 . 0   (offset: 0x38d5)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace cp01_tent_a_centered_cs;

// Namespace cp01_tent_a_centered_cs
// Params 2
// Checksum 0xa60272a5, Offset: 0x632
// Size: 0x70
function main( unused, unused2 )
{
    if ( utility::flag_exist( "cp01_tent_a_centered_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "cp01_tent_a_centered_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "cp01_tent_a_centered_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace cp01_tent_a_centered_cs
// Params 3, eflags: 0x4
// Checksum 0xc8c22f9d, Offset: 0x6aa
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "cp01_tent_a_centered_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "cp01_tent_a_centered_cs" );
}

// Namespace cp01_tent_a_centered_cs
// Params 3, eflags: 0x4
// Checksum 0x1e9761e5, Offset: 0x724
// Size: 0x2921
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "military_squad_loot_box_black";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1684.97, -1077.68, 264.75 ), ( 0, 315.58, -0.75 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "ammo_unspent_762s_fe";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1751.44, -954.3, 289.73 ), ( 0, 0, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "t10_fabric_tarp_hanging_02_fxsim";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1743.35, -1151.37, 352.43 ), ( 359.51, 44.65, 9.25 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "lm_military_wood_support_tent_03";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1600.15, -1114.37, 383.5 ), ( 0, 309.91, 180 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "military_squad_loot_box_black";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1684.97, -1077.68, 271.5 ), ( 0, 315.58, -0.75 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "un_military_storage_container_03";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1675.33, -1163.74, 289.74 ), ( 1.3, 29.56, -0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "electronics_surveillance_monitor_01";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1703.41, -1031.04, 280.38 ), ( 0, 215.22, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "lm_military_wood_support_tent_03";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1687.69, -1205.2, 238.72 ), ( 0, 321.56, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "lm_military_wood_support_tent_05";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1596.59, -1113.61, 383.5 ), ( 0, 45.3, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "military_guntable_piled_stuff_01";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1594.77, -895.13, 289.43 ), ( 359.63, 327.91, -0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "lm_military_wood_support_tent_05";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1598.59, -1115.61, 383.5 ), ( 0, 45.3, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "lm_military_wood_support_tent_03";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1869.82, -1026.27, 238.72 ), ( 0, 321.56, -1.47 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "military_pile_01_mp";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1617.39, -1123.24, 256 ), ( 0, 318.95, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "lm_hur_table_folding_medical_02";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1658.43, -1096.15, 276.08 ), ( 358.86, 40.83, -0.04 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "military_squad_loot_box";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1659.19, -1080.49, 256.75 ), ( 0.26, 134.48, 0.34 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "lm_hur_table_folding_medical_01_frontend";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1752.99, -973.99, 256.25 ), ( 1.55, 46.36, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "lm_hur_table_folding_medical_02";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1682.17, -1063.11, 280.83 ), ( 0.53, 314.12, -1.98 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "military_loot_crate_01_br_large_sandbox";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1680.42, -1055.21, 256.75 ), ( 0, 317.62, -3.49 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "box_wooden_grenade_01";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1660.27, -1080.13, 267.03 ), ( 359.83, 302.64, -0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.lgvdensity = "16";
    s.var_a9cc4ebeaa2a05a = "1";
    s.model = "t10_storage_crate_tarp_02_fxsim";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1560.52, -863.73, 254.25 ), ( 0, 244.4, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "lm_military_rope_tent_01";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1685.78, -1202.22, 365.91 ), ( 314.57, 330.32, -6.31 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "military_squad_loot_box_black";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1654.37, -1110.71, 265.94 ), ( 0, 315.58, -0.75 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "military_squad_loot_box";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1642.62, -1094.71, 257 ), ( 358.51, 310.51, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "t10_decor_hanging_coiled_rope_01_sml_fxsim";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1598.85, -1116.05, 385.47 ), ( 0, 42.55, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "box_wooden_grenade_01";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1643.21, -1096.74, 267.03 ), ( 0, 48.17, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "military_guntable_piled_stuff_02";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1596.54, -918.98, 256 ), ( 0, 329.71, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "un_military_storage_container_03";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1678.66, -871.43, 256 ), ( 0, 318.5, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "military_crafting_crate_01_padlock";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1602.38, -890.27, 276.21 ), ( 0, 235.36, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "military_crate_large_stackable_01";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1592.95, -891.84, 256 ), ( 0, 237.03, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "un_military_storage_container_03";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1565.01, -891.76, 256 ), ( 0, 243.76, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "military_loot_crate_regular_ch3";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1756.32, -953.92, 256 ), ( 0, 326.57, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "military_squad_loot_box_black";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1646.02, -1163.41, 288.98 ), ( 359.36, 103.97, 0.4 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "military_pile_04";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1757.34, -955.01, 273.18 ), ( 0, 149.24, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "military_crafting_crate_01_padlock";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1722.35, -1009.19, 280.2 ), ( 0, 313.85, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "military_dmz_loot_crate";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1713.24, -1020.18, 256 ), ( 0, 314.73, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "military_loot_crate_regular_ch3";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1725.54, -976.61, 256 ), ( 0, 40.81, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "s4_ger_crate_ammo_02_open_full_b";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1732.58, -1080.61, 289.56 ), ( 0, 316.55, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "ground_wires_01_multicolored";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1770.95, -922.29, 255.75 ), ( 0, 145.55, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "military_guntable_piled_stuff_01";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1738.5, -944, 256 ), ( 0, 314.09, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "military_pile_01_mp";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1697.53, -1007.67, 256 ), ( 0, 315.81, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "military_guntable_piled_stuff_02";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1728, -978, 273.25 ), ( 0, 223.12, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "ground_wires_01_short";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1641.75, -1054.5, 256 ), ( 0, 122.69, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "military_pile_04";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1627.35, -1127.04, 265.25 ), ( 0, 329.24, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "military_crafting_crate_01_padlock";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1581.02, -900.37, 276.21 ), ( 0, 146.07, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "lm_military_wood_support_tent_03";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1776.54, -939.56, 383.5 ), ( 0, 132.89, -180 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "structural_broadcast_antenna_bracket_flat";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1598.75, -1115.5, 383.25 ), ( 0, 307.65, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "military_equipment_vintage_2_off";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1681.86, -1072.92, 284.77 ), ( 1.96, 46.2, 0.6 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "t10_electronics_monitor_surveillance_01_on";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    s.var_a56fc80ec1e8e888 = "sfh_static";
    fe [[ f ]]( s, us, cf, ( -1706.92, -1026.06, 296.46 ), ( 0, 34.05, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "t10_storage_box_tool_01_open_tool_fe";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1571.01, -908.37, 274.25 ), ( 0.99, 52.26, -0.17 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "t10_electronics_monitor_surveillance_01_on";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    s.var_a56fc80ec1e8e888 = "sfh_static";
    fe [[ f ]]( s, us, cf, ( -1700.04, -1040.32, 296.46 ), ( 0, 43.28, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "military_uploadstation_01";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1649.32, -1096.44, 285.1 ), ( 350.33, 42.41, -1.35 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "t10_electronics_monitor_surveillance_01_on";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    s.var_a56fc80ec1e8e888 = "sfh_static";
    fe [[ f ]]( s, us, cf, ( -1657.81, -1078.76, 283.85 ), ( 0.01, 23.4, -0.01 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "electronics_walkie_talkie_01";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1652.41, -1078.98, 296.85 ), ( 270.03, 359.69, -21.93 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "t10_storage_box_tool_01_open_tool_fe";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1686.13, -1049.98, 284.77 ), ( 0.16, 109.8, 4.63 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "weapon_wm_ar_scharlie_brprop_nophys";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1771.4, -949.04, 290.82 ), ( 0.57, 198.55, 89.73 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "ammo_unspent_762s_fe";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1751.81, -958.81, 289.79 ), ( 0, 93.67, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "t10_storage_box_tool_01_screwdriver_06_fe";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1674.39, -1056.12, 284.8 ), ( 2.03, 21.71, -0.26 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "misc_tools_wrench_01_fe";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1669.21, -1051.75, 284.11 ), ( 0.65, 317.59, -1.94 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "electronics_walkie_talkie_01";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1664.98, -1058.19, 284.08 ), ( 1.79, 0.1, -0.99 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "military_pile_04";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1743.39, -989.09, 290.46 ), ( 0, 313.78, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "parts_jup_magazines_akslabside";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1754.36, -950.93, 290.25 ), ( 358.99, 313.49, 88.6 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "lm_hur_table_folding_medical_02";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1657.4, -1094.57, 280.08 ), ( 359.58, 307.53, 1.2 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "lm_military_awning_tent_02";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1777.05, -933.93, 269.75 ), ( 0, 314.68, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "parts_jup_magazines_akslabside";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1755.25, -969, 290.75 ), ( 357.43, 270.04, 88.75 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "wall_wood_stud_2x6_16_old";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1645.43, -1086.45, 284.21 ), ( 359.02, 306.75, 0.01 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "t10_per_fabric_radar_camo_netting_05_fxsim";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1684.82, -1024.91, 387.13 ), ( 0, 225.33, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "structural_broadcast_antenna_bracket_flat";
    s.var_4a62bf732f3923cb = "1";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1777.75, -938.25, 383.25 ), ( 0, 130.64, 0 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "weapon_wm_ar_scharlie_brprop_nophys";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1770.65, -960.54, 290.82 ), ( 0.46, 180.25, 89.57 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "t10_fabric_tarp_hanging_06_fxsim";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1776.03, -936.56, 257 ), ( 359.54, 324.43, -0.08 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    s = {};
    s.script_cs_flag = "cp01_tent_a_centered_cs";
    s.is_cs_model = 1;
    s.model = "wall_wood_stud_2x6_16_old";
    s.reflectionprobefilter = "0";
    fe [[ f ]]( s, us, cf, ( -1645.43, -1086.46, 284.21 ), ( 359.02, 306.75, 0.01 ), undefined, undefined, undefined, undefined, undefined, ( -30976, -55423, 16 ), ( 0, 75, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace cp01_tent_a_centered_cs
// Params 0, eflags: 0x4
// Checksum 0x17b1614, Offset: 0x304d
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace cp01_tent_a_centered_cs
// Params 0
// Checksum 0xa91f2d0, Offset: 0x3057
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "cp01_tent_a_centered_cs" );
}

