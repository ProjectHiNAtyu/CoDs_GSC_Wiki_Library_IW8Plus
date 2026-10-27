// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_survival_cs.gsc  (hash_532c14faaca97283.gscc) (size: 10028 Bytes / 0x272c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf20ce5ba (4060931514)
// size ...... 10028 (0x272c)
// includes .. 3   (offset: 0x21d4)
// strings ... 44  (offset: 0x21ec)
// dev strs .. 0   (offset: 0x272c)
// exports ... 9   (offset: 0x1e3c)
// cseg ...... 0x5cb + 0x1871 (0x1e3c)
// imports ... 20  (offset: 0x1fa4)
// animtree1 . 0   (offset: 0x272c)
// animtree2 . 0   (offset: 0x272c)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_firefly_script_survival_cs;

// Namespace zm_sat_firefly_script_survival_cs
// Params 0, eflags: 0x5
// Checksum 0xa077d8e7, Offset: 0x5e9
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_script_survival_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_firefly_script_survival_cs
// Params 0, eflags: 0x4
// Checksum 0xc90e11e0, Offset: 0x60a
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_firefly_script_survival_cs
// Params 0, eflags: 0x4
// Checksum 0x4c35c20c, Offset: 0x61b
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_firefly_script_survival_cs
// Params 2
// Checksum 0xfcdc9445, Offset: 0x62c
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_script_survival_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_firefly_script_survival_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_script_survival_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_script_survival_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_script_survival_cs
// Params 3, eflags: 0x4
// Checksum 0xcfb776c3, Offset: 0x6b4
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_script_survival_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_script_survival_cs" );
}

// Namespace zm_sat_firefly_script_survival_cs
// Params 3, eflags: 0x4
// Checksum 0xaa963592, Offset: 0x72e
// Size: 0x16ee
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.var_89414bc0a9512fc2 = "baseSpec,highSpec,lowSpec,veryLowSpec";
    s.groupid = "zone_farm";
    s.script_power = "power_on2";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 13109, -4990, 776 ), ( 0, 45, 0 ), "survival_pap_set_zone_farm" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    fe [[ f ]]( s, us, cf, ( 3142, 775.48, 472.19 ), ( 0, 270.18, 0 ), "cspf_0_auto5669506968194244766" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_farm";
    fe [[ f ]]( s, us, cf, ( 14081, -3804, 1440.5 ), ( 0, 0, 0 ), undefined, "cspf_0_auto8378338777510331198", "survival_zone_farm" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    fe [[ f ]]( s, us, cf, ( 3116.5, 825, 645 ), ( 0, 0, 0 ), "survival_ashwood_player_spawn_point", "cspf_0_auto5669506968194244766" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    fe [[ f ]]( s, us, cf, ( 3210, 774.5, 472.5 ), ( 0, 270.18, 0 ), "cspf_0_auto5669506968194244766" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    fe [[ f ]]( s, us, cf, ( 3080.25, 778.85, 475.84 ), ( 0, 270.18, 0 ), "cspf_0_auto5669506968194244766" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_launchpad";
    fe [[ f ]]( s, us, cf, ( -8267.5, -6166.5, 2182.5 ), ( 0, 0, 0 ), undefined, "cspf_0_auto5729458777203229549", "survival_zone_launchpad" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    fe [[ f ]]( s, us, cf, ( 3020.18, 782.89, 474.38 ), ( 0, 270.18, 0 ), "cspf_0_auto5669506968194244766" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.var_89414bc0a9512fc2 = "baseSpec,highSpec,lowSpec,veryLowSpec";
    s.groupid = "zone_launchpad";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -9216.91, -5010.29, 1576 ), ( 0, 52.29, 0 ), "survival_pap_set_zone_launchpad" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_farm";
    fe [[ f ]]( s, us, cf, ( 3763.55, 324.33, 533.12 ), ( 0, 0, 0 ), "survival_round_accelerant_ashwood" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.var_89414bc0a9512fc2 = "baseSpec,highSpec,lowSpec,veryLowSpec";
    s.groupid = "zone_exit115";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -11715.4, 3695.81, 488 ), ( 0, 307.35, 0 ), "survival_pap_set_zone_exit115" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_exit115";
    fe [[ f ]]( s, us, cf, ( -12948, 3554.5, 1257 ), ( 0, 0, 0 ), undefined, "cspf_0_auto15481123091441776390", "survival_zone_exit115" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.var_89414bc0a9512fc2 = "baseSpec,highSpec,lowSpec,veryLowSpec";
    s.groupid = "zone_farm";
    s.script_power = "power_on3";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 4136.59, -3434.41, 439.82 ), ( 0, 95.91, 2.84 ), "survival_pap_set_ashwood" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_exit115";
    fe [[ f ]]( s, us, cf, ( -12933, 3907, 889 ), ( 0, 0, 0 ), "cspf_0_auto15481123091441776390", "cspf_0_auto7195151182126362948", "survival_wallbuy_set_zone_exit115" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.script_gameobjectname = "zm_rb_survival,zm_rb_r_mod_survival";
    fe [[ f ]]( s, us, cf, ( -10773.5, 3929, 749.5 ), ( 13.9, 171.2, -0 ), "intermission_camera_zone_exit115" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_farm";
    fe [[ f ]]( s, us, cf, ( 14424, -3811, 1213.5 ), ( 0, 0, 0 ), "survival_spawn_set_zone_farm", "cspf_0_auto16996643888685245619", "survival_spawn_set_zone_farm" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_farm";
    fe [[ f ]]( s, us, cf, ( 14582, -4591.64, 550.18 ), ( 359.26, 129.62, 0 ), "cspf_0_auto16996643888685245619" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_farm";
    fe [[ f ]]( s, us, cf, ( 14693.5, -4493.7, 549.78 ), ( 357.71, 130.48, 0 ), "cspf_0_auto16996643888685245619" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.script_gameobjectname = "zm_rb_survival,zm_rb_r_mod_survival";
    fe [[ f ]]( s, us, cf, ( -7885.5, -3408, 2790.5 ), ( 6.66, 260.76, 0 ), "intermission_camera_zone_launchpad" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.script_gameobjectname = "zm_rb_survival,zm_rb_r_mod_survival";
    fe [[ f ]]( s, us, cf, ( 2790.86, 543.25, 696.5 ), ( 5.91, 305.72, -0 ), "intermission_camera_ashwood" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_farm";
    fe [[ f ]]( s, us, cf, ( 14657.5, -4523.7, 553.19 ), ( 357.71, 130.48, 0 ), "cspf_0_auto16996643888685245619" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_farm";
    fe [[ f ]]( s, us, cf, ( 14621.5, -4554.7, 554.27 ), ( 357.71, 130.48, 0 ), "cspf_0_auto16996643888685245619" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_launchpad";
    fe [[ f ]]( s, us, cf, ( -8557, -5869, 2107.5 ), ( 0, 0, 0 ), "survival_spawn_set_zone_launchpad", "cspf_0_auto4790359655907303652", "survival_spawn_set_zone_launchpad" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_launchpad";
    fe [[ f ]]( s, us, cf, ( -9245.5, -5245, 1449.98 ), ( 359.77, 314.97, -2.61 ), "cspf_0_auto4790359655907303652" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_launchpad";
    fe [[ f ]]( s, us, cf, ( -9230.5, -5364.5, 1449.98 ), ( 357.36, 333.12, 0.29 ), "cspf_0_auto4790359655907303652" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_launchpad";
    fe [[ f ]]( s, us, cf, ( -9150, -5410, 1462.62 ), ( 359.83, 344.99, 1.35 ), "cspf_0_auto4790359655907303652" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_launchpad";
    fe [[ f ]]( s, us, cf, ( -9160.5, -5293, 1449.98 ), ( 2.09, 323.61, 0.59 ), "cspf_0_auto4790359655907303652" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_launchpad";
    fe [[ f ]]( s, us, cf, ( -9358.5, -5302, 1449.98 ), ( 358.31, 334.65, 0.06 ), "cspf_0_auto4790359655907303652" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_launchpad";
    fe [[ f ]]( s, us, cf, ( -9338, -5192, 1449.98 ), ( 358.47, 324.89, 0.72 ), "cspf_0_auto4790359655907303652" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_exit115";
    fe [[ f ]]( s, us, cf, ( -10774, 3458.61, 405.29 ), ( 1.08, 158.09, 0.31 ), "cspf_0_auto18352204950315266981" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_exit115";
    fe [[ f ]]( s, us, cf, ( -11780.5, 4207, 1012 ), ( 0, 0, 0 ), "survival_spawn_set_zone_exit115", "cspf_0_auto18352204950315266981", "survival_spawn_set_zone_exit115" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_exit115";
    fe [[ f ]]( s, us, cf, ( -10805, 3546.5, 405.35 ), ( 358.63, 161.9, -1.28 ), "cspf_0_auto18352204950315266981" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_exit115";
    fe [[ f ]]( s, us, cf, ( -10732, 3415, 406.12 ), ( 0.29, 163.71, 0.5 ), "cspf_0_auto18352204950315266981" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_exit115";
    fe [[ f ]]( s, us, cf, ( -10712.5, 3554, 405.04 ), ( 0.67, 164.97, 0.35 ), "cspf_0_auto18352204950315266981" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_exit115";
    fe [[ f ]]( s, us, cf, ( -10672.5, 3492, 405.74 ), ( 0.07, 164.69, 0.32 ), "cspf_0_auto18352204950315266981" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_exit115";
    fe [[ f ]]( s, us, cf, ( -10653.5, 3387, 406.38 ), ( 0.14, 160.41, 0.36 ), "cspf_0_auto18352204950315266981" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_farm";
    fe [[ f ]]( s, us, cf, ( 13956.4, -3429.81, 702.3 ), ( 0, 0, 0 ), "survival_round_accelerant_zone_farm" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_launchpad";
    fe [[ f ]]( s, us, cf, ( -9296.88, -5050.73, 1491.79 ), ( 0, 180, 0 ), "survival_round_accelerant_zone_launchpad" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_exit115";
    fe [[ f ]]( s, us, cf, ( -11374.1, 2827.19, 519.3 ), ( 0, 0, 0 ), "survival_round_accelerant_zone_exit115" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_farm";
    fe [[ f ]]( s, us, cf, ( 14556, -3605.5, 1184 ), ( 0, 0, 0 ), "cspf_0_auto8378338777510331198", "cspf_0_auto12034270058412759297", "anywhere_but_here_spawn_set_zone_farm" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_farm";
    fe [[ f ]]( s, us, cf, ( 14314.5, -4732, 554 ), ( 0, 0, 0 ), "cspf_0_auto12034270058412759297" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_farm";
    fe [[ f ]]( s, us, cf, ( 14391, -4643.5, 546 ), ( 0, 0, 0 ), "cspf_0_auto12034270058412759297" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_farm";
    fe [[ f ]]( s, us, cf, ( 15232.5, -3950, 574.5 ), ( 0, 190.8, 0 ), "cspf_0_auto12034270058412759297" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_farm";
    fe [[ f ]]( s, us, cf, ( 15213, -4032.5, 579 ), ( 0, 183.4, 0 ), "cspf_0_auto12034270058412759297" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_farm";
    fe [[ f ]]( s, us, cf, ( 14024, -3062, 638.5 ), ( 0, 0, 0 ), "cspf_0_auto12034270058412759297" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_farm";
    fe [[ f ]]( s, us, cf, ( 13956.5, -3105, 639 ), ( 0, 0, 0 ), "cspf_0_auto12034270058412759297" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_farm";
    fe [[ f ]]( s, us, cf, ( 13254, -4009, 617.5 ), ( 0, 0, 0 ), "cspf_0_auto12034270058412759297" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_farm";
    fe [[ f ]]( s, us, cf, ( 13241, -3954.5, 620 ), ( 0, 0, 0 ), "cspf_0_auto12034270058412759297" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_launchpad";
    fe [[ f ]]( s, us, cf, ( -8017.5, -5950.5, 2061 ), ( 0, 0, 0 ), "cspf_0_auto5729458777203229549", "cspf_0_auto12495457697343830252", "anywhere_but_here_spawn_set_zone_launchpad" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_launchpad";
    fe [[ f ]]( s, us, cf, ( -7801, -5552.5, 1640 ), ( 0, 0, 0 ), "cspf_0_auto12495457697343830252" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_launchpad";
    fe [[ f ]]( s, us, cf, ( -7736, -5599.5, 1640 ), ( 0, 0, 0 ), "cspf_0_auto12495457697343830252" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_launchpad";
    fe [[ f ]]( s, us, cf, ( -8783, -5003, 1576 ), ( 0, 0, 0 ), "cspf_0_auto12495457697343830252" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_launchpad";
    fe [[ f ]]( s, us, cf, ( -8709, -5019.5, 1576 ), ( 0, 0, 0 ), "cspf_0_auto12495457697343830252" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_launchpad";
    fe [[ f ]]( s, us, cf, ( -8158.5, -6751.5, 1640 ), ( 0, 0, 0 ), "cspf_0_auto12495457697343830252" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_launchpad";
    fe [[ f ]]( s, us, cf, ( -8224.5, -6733, 1640 ), ( 0, 0, 0 ), "cspf_0_auto12495457697343830252" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_launchpad";
    fe [[ f ]]( s, us, cf, ( -7035.5, -6431, 1576 ), ( 0, 0, 0 ), "cspf_0_auto12495457697343830252" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_launchpad";
    fe [[ f ]]( s, us, cf, ( -7054.5, -6389.5, 1576 ), ( 0, 0, 0 ), "cspf_0_auto12495457697343830252" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_launchpad";
    fe [[ f ]]( s, us, cf, ( -6556.5, -7323, 1430 ), ( 0, 0, 0 ), "cspf_0_auto12495457697343830252" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_launchpad";
    fe [[ f ]]( s, us, cf, ( -6552.5, -7267, 1427 ), ( 0, 0, 0 ), "cspf_0_auto12495457697343830252" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_exit115";
    fe [[ f ]]( s, us, cf, ( -12162, 4244, 983.5 ), ( 0, 0, 0 ), "cspf_0_auto15481123091441776390", "cspf_0_auto17616158697168175949", "anywhere_but_here_spawn_set_zone_exit115" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_exit115";
    fe [[ f ]]( s, us, cf, ( -11015.5, 3389.5, 405 ), ( 0, 0, 0 ), "cspf_0_auto17616158697168175949" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_exit115";
    fe [[ f ]]( s, us, cf, ( -10973.5, 3443, 406.5 ), ( 0, 0, 0 ), "cspf_0_auto17616158697168175949" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_exit115";
    fe [[ f ]]( s, us, cf, ( -11751, 4568.5, 417 ), ( 0, 0, 0 ), "cspf_0_auto17616158697168175949" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_exit115";
    fe [[ f ]]( s, us, cf, ( -11718, 4552.5, 417 ), ( 0, 0, 0 ), "cspf_0_auto17616158697168175949" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_exit115";
    fe [[ f ]]( s, us, cf, ( -13393.5, 4694.5, 417 ), ( 0, 0, 0 ), "cspf_0_auto17616158697168175949" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_exit115";
    fe [[ f ]]( s, us, cf, ( -13384, 4612, 417 ), ( 0, 0, 0 ), "cspf_0_auto17616158697168175949" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_exit115";
    fe [[ f ]]( s, us, cf, ( -13434, 3914, 591 ), ( 0, 0, 0 ), "cspf_0_auto17616158697168175949" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_exit115";
    fe [[ f ]]( s, us, cf, ( -13396, 3862, 591 ), ( 0, 0, 0 ), "cspf_0_auto17616158697168175949" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_exit115";
    fe [[ f ]]( s, us, cf, ( -12699, 2735, 416.5 ), ( 0, 0, 0 ), "cspf_0_auto17616158697168175949" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_exit115";
    fe [[ f ]]( s, us, cf, ( -12637.5, 2745.5, 417.5 ), ( 0, 0, 0 ), "cspf_0_auto17616158697168175949" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_exit115";
    fe [[ f ]]( s, us, cf, ( -13694.5, 2389.5, 419.5 ), ( 0, 0, 0 ), "cspf_0_auto17616158697168175949" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_survival_cs";
    s.groupid = "zone_exit115";
    fe [[ f ]]( s, us, cf, ( -13599.5, 2418, 418 ), ( 0, 0, 0 ), "cspf_0_auto17616158697168175949" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_script_survival_cs
// Params 0, eflags: 0x4
// Checksum 0xa749f42c, Offset: 0x1e24
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_script_survival_cs
// Params 0
// Checksum 0xde4ab8e, Offset: 0x1e2e
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_script_survival_cs" );
}

