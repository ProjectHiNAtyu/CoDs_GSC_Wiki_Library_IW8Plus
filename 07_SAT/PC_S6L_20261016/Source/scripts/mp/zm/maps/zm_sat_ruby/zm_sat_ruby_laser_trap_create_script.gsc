// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_laser_trap_create_script.gsc  (hash_03663fae2db4f8c6.gscc) (size: 11993 Bytes / 0x2ed9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf498939a (4103639962)
// size ...... 11993 (0x2ed9)
// includes .. 2   (offset: 0x26c9)
// strings ... 71  (offset: 0x26d9)
// dev strs .. 0   (offset: 0x2ed9)
// exports ... 6   (offset: 0x2419)
// cseg ...... 0x706 + 0x1d13 (0x2419)
// imports ... 16  (offset: 0x2509)
// animtree1 . 0   (offset: 0x2ed9)
// animtree2 . 0   (offset: 0x2ed9)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_ruby_laser_trap_create_script;

// Namespace zm_sat_ruby_laser_trap_create_script
// Params 2
// Checksum 0x3a257b54, Offset: 0x724
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_ruby_laser_trap_create_script" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_ruby_laser_trap_create_script" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_ruby_laser_trap_create_script" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_ruby_laser_trap_create_script" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_ruby_laser_trap_create_script
// Params 3, eflags: 0x4
// Checksum 0x94e99d2, Offset: 0x7ac
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_ruby_laser_trap_create_script" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_ruby_laser_trap_create_script" );
}

// Namespace zm_sat_ruby_laser_trap_create_script
// Params 3, eflags: 0x4
// Checksum 0xbbe61b08, Offset: 0x826
// Size: 0x1bd3
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 482.77, 1533.32, 826 ), ( 63.6, 37.09, 32.86 ), "cspf_0_auto11957023009301816474", "cspf_0_auto265628337617427549" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.name = "laser_trap_switch";
    s.script_label = "sat_zm_laser_trap";
    fe [[ f ]]( s, us, cf, ( 663.79, 1630.35, 252.5 ), ( 0, 7.37, 0 ), "cspf_0_auto15489704099563132452", undefined, "switch" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.name = "script_struct_emitter";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 665.45, 1565.21, 348.65 ), ( 345.17, 255.94, 7.47 ), "cspf_0_auto15489704099563132452", "cspf_0_auto16832229126328325580", "trap" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.name = "script_struct_emitter";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 669.95, 1569.71, 356.65 ), ( 312, 274.39, -0 ), "cspf_0_auto15489704099563132452", "cspf_0_auto14330107637507397218", "trap" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 432.77, 1391.32, 243 ), ( 278.48, 45.16, -44.84 ), "cspf_0_auto265628337617427549", "cspf_0_auto11026522428168671077" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 866.77, 1327.32, 579 ), ( 13.56, 120.55, -78.77 ), "cspf_0_auto11026522428168671077", "cspf_0_auto1599971328208561631" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 950.77, 1423.32, 249 ), ( 286.93, 147.05, 75.16 ), "cspf_0_auto1599971328208561631", "cspf_0_auto1991941748229408253" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 707.91, 1267.33, 554.61 ), ( 25.7, 110.59, 90.18 ), "cspf_0_auto14330107637507397218", "cspf_0_auto7218265797363826042" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 862.77, 1459.32, 769 ), ( 52.19, 127.3, 83.01 ), "cspf_0_auto1991941748229408253", "cspf_0_auto15129638376505713127" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 801.51, 1373.19, 238 ), ( 280, 143.08, -143.08 ), "cspf_0_auto7218265797363826042", "cspf_0_auto17018012120821169261" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 684.77, 1439.32, 221 ), ( 270, 0, 0 ), "cspf_0_auto15129638376505713127", "cspf_0_auto15385871674197372206" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 728.77, 1323.32, 689 ), ( 25.58, 101.1, -85.16 ), "cspf_0_auto15385871674197372206", "cspf_0_auto18019194214158551470" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 758.77, 1407.32, 227 ), ( 277.66, 96.26, -87.25 ), "cspf_0_auto18019194214158551470", "cspf_0_auto14220841631426683201" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 988.77, 1441.32, 581 ), ( 16.58, 137.07, 166.05 ), "cspf_0_auto14220841631426683201", "cspf_0_auto17069949028722984556" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 616.24, 1264.04, 358.88 ), ( 15.68, 87.37, -90.4 ), "cspf_0_auto16832229126328325580", "cspf_0_auto1201621540471318645" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.name = "script_struct_emitter";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 673.38, 1569.82, 348.51 ), ( 348.73, 296.71, -4.16 ), "cspf_0_auto15489704099563132452", "cspf_0_auto8884868853650401203", "trap" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 444.77, 1359.32, 248 ), ( 270, 0, 0 ), "cspf_0_auto1201621540471318645", "cspf_0_auto11957023009301816474" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.name = "laser";
    s.script_cost = "1000";
    s.script_duration = "20";
    s.script_timeout = "60";
    fe [[ f ]]( s, us, cf, ( 654.77, 1665.33, 321.14 ), ( 0, 6.91, 0 ), "laser_trap_switch", "cspf_0_auto15489704099563132452", "zone_planetarium", undefined, undefined, undefined, undefined, 80 );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 798.41, 1284.83, 370.11 ), ( 29.25, 133.28, 90.62 ), "cspf_0_auto8884868853650401203", "cspf_0_auto18208374194804638480" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 970.77, 1455.32, 247 ), ( 281.36, 143.94, 176.71 ), "cspf_0_auto17069949028722984556", "cspf_0_auto9918874291232643360" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 383.51, 1375.19, 252 ), ( 270, 0, 0 ), "cspf_0_auto18208374194804638480", "cspf_0_auto1039000113312104613" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 948.77, 1531.32, 739 ), ( 41.32, 161.51, -164.69 ), "cspf_0_auto9918874291232643360", "cspf_0_auto2405304496916592819" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 916.77, 1473.32, 241 ), ( 292, 149.68, -174.21 ), "cspf_0_auto2405304496916592819", "cspf_0_auto12466741302776906630" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 762.77, 1365.32, 735 ), ( 35.33, 101.78, 105.48 ), "cspf_0_auto12466741302776906630" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.name = "script_struct_emitter";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 659.7, 1570.71, 355.65 ), ( 337.87, 237.96, -0.5 ), "cspf_0_auto15489704099563132452", "laser6_1", "trap" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 619.51, 1285.19, 620 ), ( 27.75, 86.19, -99.02 ), "cspf_0_auto17018012120821169261", "cspf_0_auto7629473070361104492" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 647.51, 1319.19, 242 ), ( 295.93, 89.08, 111.04 ), "cspf_0_auto7629473070361104492", "cspf_0_auto13778550070318315739" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 643.51, 1557.19, 874 ), ( 73.76, 89.41, 72.42 ), "cspf_0_auto13778550070318315739", "cspf_0_auto1872096006178189142" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 591.51, 1419.19, 222 ), ( 279.86, 74.32, 120.9 ), "cspf_0_auto1872096006178189142", "cspf_0_auto5054730929411898478" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 561.51, 1293.19, 616 ), ( 28.52, 71.86, 91.91 ), "cspf_0_auto5054730929411898478" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 475.51, 1302.69, 494.5 ), ( 354.89, 61.5, -87.23 ), "laser6_1", "laser6_2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 671.51, 1291.19, 638 ), ( 8, 90, -90 ), "cspf_0_auto1039000113312104613", "cspf_0_auto5736793119234964333" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 1011.51, 1477.19, 252 ), ( 270, 293.5, 66.5 ), "cspf_0_auto5736793119234964333" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.name = "script_struct_emitter";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 667.38, 1568.32, 340.26 ), ( 29.53, 261.77, -4.54 ), "cspf_0_auto15489704099563132452", "cspf_0_auto743701339808625897", "trap" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    s.script_parameters = "20";
    fe [[ f ]]( s, us, cf, ( 666.51, 1401.19, 220 ), ( 270, 0, 0 ), "cspf_0_auto743701339808625897", "cspf_0_auto948940871013514547", "moveable" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.is_cs_model = 1;
    s.model = "sat_electronics_led_screen_display_dmg_solid";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 833.72, 1302.31, 511 ), ( 270, 0, -67.4 ), undefined, undefined, "corridor_ent" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    s.script_parameters = "10";
    fe [[ f ]]( s, us, cf, ( 801.51, 1372.19, 510 ), ( 90, 0, 0 ), "cspf_0_auto948940871013514547", "cspf_0_auto16177605276072775852", "moveable" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    s.script_parameters = "40";
    fe [[ f ]]( s, us, cf, ( 849.51, 1484.44, 220 ), ( 270, 0, 0 ), "cspf_0_auto16177605276072775852", undefined, "moveable" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.name = "script_struct_emitter";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 675.88, 1572.82, 339.01 ), ( 26.33, 309.25, -1.06 ), "cspf_0_auto15489704099563132452", "cspf_0_auto14561949876664711312", "trap" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.name = "script_struct";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    s.script_parameters = "20";
    fe [[ f ]]( s, us, cf, ( 763.01, 1443.44, 219.75 ), ( 270, 0, 0 ), "cspf_0_auto14561949876664711312", "cspf_0_auto9369324241390778605", "moveable" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.is_cs_model = 1;
    s.model = "sat_electronics_led_screen_display_dmg_solid";
    s.var_8ef9cdfc2a34bab3 = "1";
    fe [[ f ]]( s, us, cf, ( 497.52, 1296.41, 514 ), ( 270, 359.7, -110.8 ), undefined, undefined, "corridor_ent" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    s.script_parameters = "10";
    fe [[ f ]]( s, us, cf, ( 522.51, 1369.19, 513 ), ( 90, 179.7, -136.6 ), "cspf_0_auto9369324241390778605", "cspf_0_auto15845950306363568919", "moveable" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.name = "script_struct";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    s.script_parameters = "40";
    fe [[ f ]]( s, us, cf, ( 520.76, 1447.44, 220.5 ), ( 270, 0, 0 ), "cspf_0_auto15845950306363568919", undefined, "moveable" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 489.02, 1677.82, 251.75 ), ( 270.37, 18.04, -9.06 ), "laser6_2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.name = "script_struct_emitter";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 678.95, 1573.21, 355.4 ), ( 339.84, 321.27, 0.82 ), "cspf_0_auto15489704099563132452", "laser7_1", "trap" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 918.26, 1365.94, 506.75 ), ( 7.44, 131.56, -93.94 ), "laser7_1", "laser7_2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 853.52, 1641.32, 250.75 ), ( 270.37, 18.04, -9.06 ), "laser7_2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.name = "script_struct_emitter";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 673.45, 1576.71, 362.4 ), ( 298.41, 313.09, -18.83 ), "cspf_0_auto15489704099563132452", "laser8_1", "trap" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    s.script_parameters = "20";
    fe [[ f ]]( s, us, cf, ( 820.26, 1392.19, 739.5 ), ( 6.82, 123.55, -94.93 ), "laser8_1", "laser8_2", "moveable" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    s.script_parameters = "20";
    fe [[ f ]]( s, us, cf, ( 768.27, 1714.07, 251 ), ( 270.37, 18.04, -9.06 ), "laser8_2", undefined, "moveable" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.name = "script_struct_emitter";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 657.2, 1579.46, 359.65 ), ( 324.49, 204.42, 65.15 ), "cspf_0_auto15489704099563132452", "laser9_1", "trap" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    s.script_parameters = "20";
    fe [[ f ]]( s, us, cf, ( 349.76, 1481.19, 684 ), ( 357.13, 31.56, -85.05 ), "laser9_1", "laser9_2", "moveable" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    s.script_parameters = "20";
    fe [[ f ]]( s, us, cf, ( 548.52, 1700.32, 251.25 ), ( 270.37, 18.04, -9.06 ), "laser9_2", undefined, "moveable" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.name = "script_struct_emitter";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 665.45, 1584.21, 364.9 ), ( 280.54, 223.99, 63.68 ), "cspf_0_auto15489704099563132452", "laser10_1", "trap" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 644.01, 1586.44, 882.5 ), ( 84.81, 53.68, -160.53 ), "laser10_1", "laser10_2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 482.02, 1628.82, 251.5 ), ( 270.37, 18.04, -9.06 ), "laser10_2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.name = "script_struct_emitter";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 652.95, 1577.21, 350.9 ), ( 343.7, 199.42, 85.16 ), "cspf_0_auto15489704099563132452", "laser11_1", "trap" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 309.76, 1449.19, 426 ), ( 359.37, 28.53, -176.54 ), "laser11_1", "laser11_2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 611.27, 1836.07, 251 ), ( 270.37, 18.04, -9.06 ), "laser11_2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.name = "script_struct_emitter";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 683.95, 1580.71, 350.9 ), ( 350.2, 346.71, -7.86 ), "cspf_0_auto15489704099563132452", "laser12_1", "trap" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 1047.26, 1529.19, 434 ), ( 358.63, 175.38, 179.78 ), "laser12_1", "laser12_2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 848.52, 1742.32, 251 ), ( 270.37, 18.04, -9.06 ), "laser12_2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.name = "script_struct_emitter";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 681.7, 1588.96, 354.9 ), ( 340.91, 27.15, -12.85 ), "cspf_0_auto15489704099563132452", "laser13_1", "trap" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 1057.01, 1770.69, 571 ), ( 359.1, 215.51, 178.94 ), "laser13_1", "laser13_2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_laser_trap_create_script";
    s.script_label = "sat_laser_beam_scriptable";
    s.script_modelname = "sat_laser_trap_beam_launcher";
    fe [[ f ]]( s, us, cf, ( 718.52, 1815.57, 250.5 ), ( 270.37, 18.04, -9.06 ), "laser13_2" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_ruby_laser_trap_create_script
// Params 0, eflags: 0x4
// Checksum 0x1c50c406, Offset: 0x2401
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_ruby_laser_trap_create_script
// Params 0
// Checksum 0xcb1d449f, Offset: 0x240b
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_ruby_laser_trap_create_script" );
}

