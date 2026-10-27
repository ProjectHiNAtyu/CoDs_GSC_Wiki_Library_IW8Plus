// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_ee_jumpscare_cs.gsc  (hash_025b87b491b8aad6.gscc) (size: 16668 Bytes / 0x411c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7d304ef5 (2100317941)
// size ...... 16668 (0x411c)
// includes .. 3   (offset: 0x362c)
// strings ... 79  (offset: 0x3644)
// dev strs .. 0   (offset: 0x411c)
// exports ... 9   (offset: 0x3294)
// cseg ...... 0x89e + 0x29f6 (0x3294)
// imports ... 20  (offset: 0x33fc)
// animtree1 . 0   (offset: 0x411c)
// animtree2 . 0   (offset: 0x411c)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_scarab_ee_jumpscare_cs;

// Namespace zm_sat_scarab_ee_jumpscare_cs
// Params 0, eflags: 0x5
// Checksum 0x60308a19, Offset: 0x8bc
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_scarab_ee_jumpscare_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_scarab_ee_jumpscare_cs
// Params 0, eflags: 0x4
// Checksum 0x91241cb4, Offset: 0x8dd
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_scarab_ee_jumpscare_cs
// Params 0, eflags: 0x4
// Checksum 0x141fcf58, Offset: 0x8ee
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_scarab_ee_jumpscare_cs
// Params 2
// Checksum 0xa4f69911, Offset: 0x8ff
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_scarab_ee_jumpscare_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_scarab_ee_jumpscare_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_scarab_ee_jumpscare_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_scarab_ee_jumpscare_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_scarab_ee_jumpscare_cs
// Params 3, eflags: 0x4
// Checksum 0x979d7b97, Offset: 0x987
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_scarab_ee_jumpscare_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_scarab_ee_jumpscare_cs" );
}

// Namespace zm_sat_scarab_ee_jumpscare_cs
// Params 3, eflags: 0x4
// Checksum 0x4b4d940e, Offset: 0xa01
// Size: 0x2873
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_forest";
    fe [[ f ]]( s, us, cf, ( -401.85, 3965.94, 1663.25 ), ( 0, 56.9, 0 ), "digging_mound", "cspf_0_auto7021375462521940225", "forest" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_forest";
    fe [[ f ]]( s, us, cf, ( -403.5, 3969.25, 1678.25 ), ( 0, 78, 0 ), "cspf_0_auto7021375462521940225", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_nw_temple";
    fe [[ f ]]( s, us, cf, ( -2262.77, 929.09, 1746 ), ( 0, 202, 0 ), "cocoon_2", "cspf_0_auto241477120766711891", "nw_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_nw_temple";
    fe [[ f ]]( s, us, cf, ( -2244.72, 947.92, 1789.11 ), ( 0, 310, -180 ), "cspf_0_auto241477120766711891", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_nw_temple";
    fe [[ f ]]( s, us, cf, ( -2262.72, 929.92, 1779.11 ), ( 0, 310, -180 ), "cspf_0_auto241477120766711891", undefined, "mote_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_forest";
    fe [[ f ]]( s, us, cf, ( 378.81, 3341.35, 1727.25 ), ( 0, 298.9, 0 ), "digging_mound", "cspf_0_auto17932124721804409601", "forest" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_forest";
    fe [[ f ]]( s, us, cf, ( 382.5, 3341.25, 1742.25 ), ( 0, 320, 0 ), "cspf_0_auto17932124721804409601", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_ne_temple";
    fe [[ f ]]( s, us, cf, ( 463.2, 550.63, 1664 ), ( 0, 90, -0 ), "cocoon_1", "cspf_0_auto2357437656582767090", "ne_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_ne_temple";
    fe [[ f ]]( s, us, cf, ( 487.9, 528.68, 1703.11 ), ( 0, 321, 0 ), "cspf_0_auto2357437656582767090", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_ne_temple";
    fe [[ f ]]( s, us, cf, ( 463.9, 550.68, 1695.11 ), ( 0, 135, 0 ), "cspf_0_auto2357437656582767090", undefined, "mote_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_forest";
    fe [[ f ]]( s, us, cf, ( 791.61, 2516.95, 1855.25 ), ( 0, 338.9, 0 ), "digging_mound", "cspf_0_auto16824843695674791995", "forest" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_forest";
    fe [[ f ]]( s, us, cf, ( 794.5, 2519.25, 1870.25 ), ( 0, 0, 0 ), "cspf_0_auto16824843695674791995", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_ne_temple";
    fe [[ f ]]( s, us, cf, ( 835.82, 673.79, 1569.25 ), ( 0, 256.9, 0 ), "digging_mound", "cspf_0_auto16852711103165395942", "ne_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_ne_temple";
    fe [[ f ]]( s, us, cf, ( 838.5, 671.25, 1584.25 ), ( 0, 278, 0 ), "cspf_0_auto16852711103165395942", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_forest";
    fe [[ f ]]( s, us, cf, ( -373.79, 3101.59, 1856.25 ), ( 0, 140.9, 0 ), "digging_mound", "cspf_0_auto13357958348417152334", "forest" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_forest";
    fe [[ f ]]( s, us, cf, ( -369, 3100, 1871.25 ), ( 0, 162, 0 ), "cspf_0_auto13357958348417152334", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_ne_temple";
    fe [[ f ]]( s, us, cf, ( 711.96, 88.54, 1573.25 ), ( 0, 140.9, 0 ), "digging_mound", "cspf_0_auto17278773825870453148", "ne_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_ne_temple";
    fe [[ f ]]( s, us, cf, ( 708.5, 87.25, 1588.25 ), ( 0, 162, 0 ), "cspf_0_auto17278773825870453148", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_nw_temple";
    fe [[ f ]]( s, us, cf, ( -3048.72, 2325.92, 1514.59 ), ( 0, 158, -180 ), "cspf_0_auto1945351111358374057", undefined, "item_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_ne_temple";
    fe [[ f ]]( s, us, cf, ( 2913.9, 3486.68, 1814 ), ( 0, 135, 0 ), "cspf_0_auto11401027277085433377", undefined, "item_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_forest";
    s.script_scenescriptbundle = "cin_scarab_vermin_scare_jump";
    fe [[ f ]]( s, us, cf, ( 667.68, 2911.99, 1728 ), ( 0, 0, 0 ), "vig_vermin_scare_jump" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_runias";
    fe [[ f ]]( s, us, cf, ( 3757.61, 834.95, 1719.25 ), ( 0, 338.9, 0 ), "digging_mound", "cspf_0_auto8055483338483813937", "runias" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_runias";
    fe [[ f ]]( s, us, cf, ( 3760.5, 837.25, 1734.25 ), ( 0, 0, 0 ), "cspf_0_auto8055483338483813937", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_temple_4";
    fe [[ f ]]( s, us, cf, ( 2306.82, -2339.05, 1395.25 ), ( 0, 304.9, 0 ), "digging_mound", "cspf_0_auto1252576860123796821", "temple_4" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_temple_4";
    fe [[ f ]]( s, us, cf, ( 2310.5, -2338.75, 1410.25 ), ( 0, 326, 0 ), "cspf_0_auto1252576860123796821", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_temple_4";
    fe [[ f ]]( s, us, cf, ( 3487.97, -2720, 1392.39 ), ( 0, 0, 0 ), "cocoon_2", "cspf_0_auto7610825713951628164", "temple_4" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_temple_4";
    fe [[ f ]]( s, us, cf, ( 3530, -2695.75, 1423.5 ), ( 360, 66, -0 ), "cspf_0_auto7610825713951628164", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_temple_4";
    fe [[ f ]]( s, us, cf, ( 3402.39, -697.61, 1802.66 ), ( 359.95, 343.65, -0.52 ), "cocoon_2", "cspf_0_auto7302635297281851339", "temple_4" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_ne_temple";
    fe [[ f ]]( s, us, cf, ( 493.9, 512.68, 1573.14 ), ( 0, 321, 0 ), "cspf_0_auto2357437656582767090", undefined, "item_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_nw_temple";
    fe [[ f ]]( s, us, cf, ( -2638.3, 3575.51, 1746 ), ( 360, 69.89, -0 ), "cocoon_2", "cspf_0_auto10149957032400820673", "nw_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_temple_4";
    fe [[ f ]]( s, us, cf, ( 3403.53, -729.33, 1835.75 ), ( 358.19, 183.65, -0.21 ), "cspf_0_auto7302635297281851339", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_rock";
    fe [[ f ]]( s, us, cf, ( -5462.65, 514.9, 1784.25 ), ( 90, 0, 12 ), "cspf_0_auto14331559409242177987", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_temple_4";
    fe [[ f ]]( s, us, cf, ( 4240.99, -2238.38, 1462.39 ), ( 0, 358, 0 ), "cocoon_2", "cspf_0_auto4391114178373202159", "temple_4" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_temple_4";
    fe [[ f ]]( s, us, cf, ( 4216.25, -2210.5, 1503.5 ), ( 90, 132.3, -135.7 ), "cspf_0_auto4391114178373202159", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_runias";
    fe [[ f ]]( s, us, cf, ( 3976.9, 278.44, 1553.25 ), ( 0, 70.9, 0 ), "digging_mound", "cspf_0_auto8519292114913068664", "runias" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_runias";
    fe [[ f ]]( s, us, cf, ( 3974.5, 281.25, 1568.25 ), ( 0, 92, 0 ), "cspf_0_auto8519292114913068664", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_ne_temple";
    fe [[ f ]]( s, us, cf, ( 3113.35, 1671.38, 1768 ), ( 0, 0, 0 ), "cocoon_2", "cspf_0_auto482297674281552040", "ne_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_ne_temple";
    fe [[ f ]]( s, us, cf, ( 3123.4, 1754.68, 1799.11 ), ( 0, 45, -0 ), "cspf_0_auto482297674281552040", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_ne_temple";
    fe [[ f ]]( s, us, cf, ( 1577.85, 609.38, 2182 ), ( 0, 16, 0 ), "cocoon_1", "cspf_0_auto7839596180442651345", "ne_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_ne_temple";
    fe [[ f ]]( s, us, cf, ( 1595.73, 632.01, 2215.11 ), ( 0, 61, -0 ), "cspf_0_auto7839596180442651345", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_ne_temple";
    fe [[ f ]]( s, us, cf, ( 2939.2, 3512.63, 2126 ), ( 0, 90, -0 ), "cocoon_1", "cspf_0_auto11401027277085433377", "ne_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_ne_temple";
    fe [[ f ]]( s, us, cf, ( 2919.9, 3498.68, 2161.11 ), ( 0, 135, 0 ), "cspf_0_auto11401027277085433377", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_runias";
    fe [[ f ]]( s, us, cf, ( 4123.2, 242.63, 1780 ), ( 0, 90, -0 ), "cocoon_1", "cspf_0_auto6739684423277768230", "runias" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_runias";
    fe [[ f ]]( s, us, cf, ( 4123.9, 244.68, 1815.11 ), ( 0, 321, 0 ), "cspf_0_auto6739684423277768230", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_nw_temple";
    fe [[ f ]]( s, us, cf, ( -2999, 2313.21, 2054 ), ( 0, 256, 0 ), "cocoon_1", "cspf_0_auto1945351111358374057", "nw_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_nw_temple";
    fe [[ f ]]( s, us, cf, ( -3048.72, 2325.92, 2089.11 ), ( 0, 158, -180 ), "cspf_0_auto1945351111358374057", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_nw_temple";
    fe [[ f ]]( s, us, cf, ( -2294.25, 3106, 1764.25 ), ( 0, 0, 0 ), "cocoon_2", "cspf_0_auto7831454145019129197", "nw_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_nw_temple";
    fe [[ f ]]( s, us, cf, ( -2293.25, 3104.3, 1799.36 ), ( 0, 180, -180 ), "cspf_0_auto7831454145019129197", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_sw_temple";
    fe [[ f ]]( s, us, cf, ( -1238, -1302.9, 1572.9 ), ( 0, 0, 0 ), "digging_mound", "cspf_0_auto8351789588808404793", "sw_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_sw_temple";
    fe [[ f ]]( s, us, cf, ( -1235.11, -1296.55, 1590.68 ), ( 0, 0, 0 ), "cspf_0_auto8351789588808404793", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_sw_temple";
    fe [[ f ]]( s, us, cf, ( -4986.75, -2861.03, 1658 ), ( 0, 112, -0 ), "cocoon_2", "cspf_0_auto6446332115853614978", "sw_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_sw_temple";
    fe [[ f ]]( s, us, cf, ( -4983.83, -2823.36, 1696 ), ( 0, 88, 0 ), "cspf_0_auto6446332115853614978", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_runias";
    fe [[ f ]]( s, us, cf, ( 4123.9, 242.68, 1809.11 ), ( 0, 135, 0 ), "cspf_0_auto6739684423277768230", undefined, "mote_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_runias";
    fe [[ f ]]( s, us, cf, ( 3665.61, 410.95, 1749.25 ), ( 0, 338.9, 0 ), "digging_mound", "cspf_0_auto2740211045251053828", "runias" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_rock";
    fe [[ f ]]( s, us, cf, ( -5483.39, 521.72, 1747.14 ), ( 0, 0, 0 ), "cocoon_1", "cspf_0_auto14331559409242177987", "rock" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_rock";
    fe [[ f ]]( s, us, cf, ( -5498.75, 39.25, 1648.75 ), ( 0, 0, 0 ), "cspf_0_auto3671734881509426402", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_rock";
    fe [[ f ]]( s, us, cf, ( -5507.64, 50.95, 1633.75 ), ( 0, 338.9, 0 ), "digging_mound", "cspf_0_auto3671734881509426402", "rock" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_runias";
    fe [[ f ]]( s, us, cf, ( 3668.5, 413.25, 1764.25 ), ( 0, 0, 0 ), "cspf_0_auto2740211045251053828", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_runias";
    fe [[ f ]]( s, us, cf, ( 4743.2, 544.63, 1732 ), ( 0, 90, -0 ), "cocoon_1", "cspf_0_auto9862806817581839522", "runias" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_rock";
    fe [[ f ]]( s, us, cf, ( -5167.75, 227.75, 1639.25 ), ( 0, 0, 0 ), "cspf_0_auto595166476096504353", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_runias";
    fe [[ f ]]( s, us, cf, ( 4741.9, 544.68, 1767.11 ), ( 0, 321, 0 ), "cspf_0_auto9862806817581839522", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_runias";
    fe [[ f ]]( s, us, cf, ( 4743.9, 544.68, 1765.11 ), ( 0, 135, 0 ), "cspf_0_auto9862806817581839522", undefined, "mote_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_nw_temple";
    fe [[ f ]]( s, us, cf, ( -955.55, 869.97, 1950 ), ( 0, 112, -0 ), "cocoon_1", "cspf_0_auto14075845883272859057", "nw_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_nw_temple";
    fe [[ f ]]( s, us, cf, ( -956.72, 871.92, 1981.11 ), ( 0, 220, -180 ), "cspf_0_auto14075845883272859057", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_ne_temple";
    fe [[ f ]]( s, us, cf, ( 3661.95, 1731.98, 1898 ), ( 0, 180, 0 ), "cocoon_2", "cspf_0_auto15148012412077741925", "ne_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_ne_temple";
    fe [[ f ]]( s, us, cf, ( 3639.9, 1758.68, 1947.11 ), ( 0, 225, 0 ), "cspf_0_auto15148012412077741925", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_nw_temple";
    fe [[ f ]]( s, us, cf, ( -954.72, 871.92, 1983.11 ), ( 0, 220, -180 ), "cspf_0_auto14075845883272859057", undefined, "mote_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_nw_temple";
    fe [[ f ]]( s, us, cf, ( -1455.32, 1495.79, 1652.9 ), ( 0, 330, 0 ), "digging_mound", "cspf_0_auto10719038246956944103", "nw_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_nw_temple";
    fe [[ f ]]( s, us, cf, ( -1459.11, 1491.45, 1670.68 ), ( 0, 330, 0 ), "cspf_0_auto10719038246956944103", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_nw_temple";
    fe [[ f ]]( s, us, cf, ( -713.32, 1403.79, 1816.9 ), ( 0, 330, 0 ), "digging_mound", "cspf_0_auto7477558365896199592", "nw_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_nw_temple";
    fe [[ f ]]( s, us, cf, ( -711.11, 1403.45, 1834.68 ), ( 0, 330, 0 ), "cspf_0_auto7477558365896199592", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_nw_temple";
    fe [[ f ]]( s, us, cf, ( -501.47, 987.66, 1900.9 ), ( 0, 258, 0 ), "digging_mound", "cspf_0_auto9155995798310081934", "nw_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_nw_temple";
    fe [[ f ]]( s, us, cf, ( -501.11, 985.45, 1918.68 ), ( 0, 258, 0 ), "cspf_0_auto9155995798310081934", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_nw_temple";
    fe [[ f ]]( s, us, cf, ( -804.89, 499.73, 1882.9 ), ( 0, 166, 0 ), "digging_mound", "cspf_0_auto12731923882512545262", "nw_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_nw_temple";
    fe [[ f ]]( s, us, cf, ( -807.11, 499.45, 1900.68 ), ( 0, 166, 0 ), "cspf_0_auto12731923882512545262", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_temple_4";
    fe [[ f ]]( s, us, cf, ( 1641.49, -2126.61, 1257.25 ), ( 0, 264.9, 0 ), "digging_mound", "cspf_0_auto11475210994859343156", "temple_4" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_nw_temple";
    fe [[ f ]]( s, us, cf, ( -2636.43, 3549.5, 1789.11 ), ( 0, 177.9, 180 ), "cspf_0_auto10149957032400820673", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_nw_temple";
    fe [[ f ]]( s, us, cf, ( -2637.72, 3574.92, 1779.11 ), ( 0, 177.9, 180 ), "cspf_0_auto10149957032400820673", undefined, "mote_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_temple_4";
    fe [[ f ]]( s, us, cf, ( 1644.5, -2128.75, 1272.25 ), ( 0, 286, 0 ), "cspf_0_auto11475210994859343156", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_sw_temple";
    fe [[ f ]]( s, us, cf, ( -1640, -1424.9, 1578.9 ), ( 0, 0, 0 ), "digging_mound", "cspf_0_auto11527085450599898140", "sw_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_sw_temple";
    fe [[ f ]]( s, us, cf, ( -1637.11, -1418.55, 1596.68 ), ( 0, 0, 0 ), "cspf_0_auto11527085450599898140", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_sw_temple";
    fe [[ f ]]( s, us, cf, ( -1158, -2058.9, 1354.9 ), ( 0, 0, 0 ), "digging_mound", "cspf_0_auto9126624580506808122", "sw_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_sw_temple";
    fe [[ f ]]( s, us, cf, ( -1155.11, -2052.55, 1372.68 ), ( 0, 0, 0 ), "cspf_0_auto9126624580506808122", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_sw_temple";
    fe [[ f ]]( s, us, cf, ( -2542, -1550.9, 1508.9 ), ( 0, 0, 0 ), "digging_mound", "cspf_0_auto8277791636799337077", "sw_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_rock";
    fe [[ f ]]( s, us, cf, ( -5168.64, 227.45, 1624.25 ), ( 0, 338.9, 0 ), "digging_mound", "cspf_0_auto595166476096504353", "rock" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_rock";
    fe [[ f ]]( s, us, cf, ( -5019.75, 1115.75, 1663.25 ), ( 0, 0, 0 ), "cspf_0_auto12358810609675847067", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_rock";
    fe [[ f ]]( s, us, cf, ( -5020.64, 1115.45, 1648.25 ), ( 0, 338.9, 0 ), "digging_mound", "cspf_0_auto12358810609675847067", "rock" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_rock";
    fe [[ f ]]( s, us, cf, ( -4668.24, 1027.5, 1890.25 ), ( 90, 0, 46 ), "cspf_0_auto18271298357349110738", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_rock";
    fe [[ f ]]( s, us, cf, ( -4668.88, 1030.08, 1851.14 ), ( 0, 0, 0 ), "cocoon_1", "cspf_0_auto18271298357349110738", "rock" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_sw_temple";
    fe [[ f ]]( s, us, cf, ( -2539.11, -1544.55, 1526.68 ), ( 0, 0, 0 ), "cspf_0_auto8277791636799337077", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_sw_temple";
    fe [[ f ]]( s, us, cf, ( -1940, -2398.9, 1514.9 ), ( 0, 0, 0 ), "digging_mound", "cspf_0_auto18306937270511965246", "sw_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_sw_temple";
    fe [[ f ]]( s, us, cf, ( -1937.11, -2392.55, 1532.68 ), ( 0, 0, 0 ), "cspf_0_auto18306937270511965246", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_sw_temple";
    fe [[ f ]]( s, us, cf, ( -2049.73, -2954.34, 1262.9 ), ( 0, 276, 0 ), "digging_mound", "cspf_0_auto3797401687507828567", "sw_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_sw_temple";
    fe [[ f ]]( s, us, cf, ( -2051.11, -2956.55, 1280.68 ), ( 0, 276, 0 ), "cspf_0_auto3797401687507828567", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_sw_temple";
    fe [[ f ]]( s, us, cf, ( -1501.73, -2686.34, 1344.9 ), ( 0, 276, 0 ), "digging_mound", "cspf_0_auto6708759494943254002", "sw_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_sw_temple";
    fe [[ f ]]( s, us, cf, ( -1503.11, -2688.55, 1362.68 ), ( 0, 276, 0 ), "cspf_0_auto6708759494943254002", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_forest";
    fe [[ f ]]( s, us, cf, ( 1198, 3297.23, 1968.8 ), ( 360, 248, -0 ), "cocoon_1", "cspf_0_auto1006513809224390686", "forest" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_forest";
    fe [[ f ]]( s, us, cf, ( 1197, 3297.75, 2002.5 ), ( 0, 338, -90 ), "cspf_0_auto1006513809224390686", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_forest";
    fe [[ f ]]( s, us, cf, ( 1072.64, 3856.67, 1978.8 ), ( 360, 186, 0 ), "cocoon_1", "cspf_0_auto9825547051321335949", "forest" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_forest";
    fe [[ f ]]( s, us, cf, ( 1073, 3855.75, 2010.5 ), ( 360, 276, -90 ), "cspf_0_auto9825547051321335949", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_sw_temple";
    fe [[ f ]]( s, us, cf, ( -5949.61, -3576.69, 1679.5 ), ( 0, 252.95, -0 ), "cocoon_2", "cspf_0_auto15083097855427445283", "sw_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_sw_temple";
    fe [[ f ]]( s, us, cf, ( -5979.21, -3547, 1720.61 ), ( 360, 162.95, -0 ), "cspf_0_auto15083097855427445283", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "mound_sw_temple";
    fe [[ f ]]( s, us, cf, ( -4899.44, -3724.99, 1342 ), ( 0, 268, 0 ), "cocoon_2", "cspf_0_auto7401333655880358822", "sw_temple" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_sw_temple";
    fe [[ f ]]( s, us, cf, ( -4899.36, -3751.3, 1373.11 ), ( 0, 178, -0 ), "cspf_0_auto7401333655880358822", undefined, "zombie_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_forest";
    fe [[ f ]]( s, us, cf, ( 1196.61, 3297.86, 2000.5 ), ( 0, 338, -90 ), "cspf_0_auto1006513809224390686", undefined, "mote_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_forest";
    fe [[ f ]]( s, us, cf, ( 1073, 3857.75, 2012.5 ), ( 360, 276, -90 ), "cspf_0_auto9825547051321335949", undefined, "mote_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_ne_temple";
    fe [[ f ]]( s, us, cf, ( 3115.4, 1668.68, 1801.11 ), ( 0, 45, -0 ), "cspf_0_auto482297674281552040", undefined, "mote_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_ne_temple";
    fe [[ f ]]( s, us, cf, ( 1579.78, 608.93, 2211.11 ), ( 0, 61, -0 ), "cspf_0_auto7839596180442651345", undefined, "mote_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_ne_temple";
    fe [[ f ]]( s, us, cf, ( 2939.9, 3514.68, 2155.11 ), ( 0, 135, 0 ), "cspf_0_auto11401027277085433377", undefined, "mote_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_ne_temple";
    fe [[ f ]]( s, us, cf, ( 3661.9, 1732.68, 1929.11 ), ( 0, 225, 0 ), "cspf_0_auto15148012412077741925", undefined, "mote_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_nw_temple";
    fe [[ f ]]( s, us, cf, ( -3000.21, 2313.51, 2087.11 ), ( 0, 4, 180 ), "cspf_0_auto1945351111358374057", undefined, "mote_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_nw_temple";
    fe [[ f ]]( s, us, cf, ( -2293.25, 3104.3, 1797.36 ), ( 0, 180, -180 ), "cspf_0_auto7831454145019129197", undefined, "mote_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_rock";
    fe [[ f ]]( s, us, cf, ( -5484.65, 520.9, 1776.25 ), ( 90, 0, 12 ), "cspf_0_auto14331559409242177987", undefined, "mote_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_rock";
    fe [[ f ]]( s, us, cf, ( -4666.24, 1027.5, 1888.25 ), ( 90, 0, 46 ), "cspf_0_auto18271298357349110738", undefined, "mote_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_sw_temple";
    fe [[ f ]]( s, us, cf, ( -4986.82, -2858.05, 1691.11 ), ( 0, 88, 0 ), "cspf_0_auto6446332115853614978", undefined, "mote_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_sw_temple";
    fe [[ f ]]( s, us, cf, ( -5950.65, -3576.68, 1716.61 ), ( 360, 162.95, -0 ), "cspf_0_auto15083097855427445283", undefined, "mote_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_sw_temple";
    fe [[ f ]]( s, us, cf, ( -4898.52, -3727.32, 1379.11 ), ( 0, 178, -0 ), "cspf_0_auto7401333655880358822", undefined, "mote_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_temple_4";
    fe [[ f ]]( s, us, cf, ( 3488.96, -2721.31, 1423.5 ), ( 360, 66, -0 ), "cspf_0_auto7610825713951628164", undefined, "mote_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_temple_4";
    fe [[ f ]]( s, us, cf, ( 3402.79, -700.44, 1837.32 ), ( 358.19, 183.65, -0.21 ), "cspf_0_auto7302635297281851339", undefined, "mote_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_jumpscare_cs";
    s.groupid = "loc_temple_4";
    fe [[ f ]]( s, us, cf, ( 4241.26, -2239.39, 1493.5 ), ( 90, 132.3, -135.7 ), "cspf_0_auto4391114178373202159", undefined, "mote_pos" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_scarab_ee_jumpscare_cs
// Params 0, eflags: 0x4
// Checksum 0x6a1982ca, Offset: 0x327c
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_scarab_ee_jumpscare_cs
// Params 0
// Checksum 0x55cea6da, Offset: 0x3286
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_scarab_ee_jumpscare_cs" );
}

