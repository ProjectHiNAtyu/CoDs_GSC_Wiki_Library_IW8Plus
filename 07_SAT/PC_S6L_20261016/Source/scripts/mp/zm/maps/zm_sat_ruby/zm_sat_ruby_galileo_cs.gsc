// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_galileo_cs.gsc  (hash_30ac16ed93dcfadc.gscc) (size: 12193 Bytes / 0x2fa1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe1f34b53 (3790818131)
// size ...... 12193 (0x2fa1)
// includes .. 3   (offset: 0x2871)
// strings ... 91  (offset: 0x2889)
// dev strs .. 0   (offset: 0x2fa1)
// exports ... 9   (offset: 0x24d9)
// cseg ...... 0xc5e + 0x187b (0x24d9)
// imports ... 20  (offset: 0x2641)
// animtree1 . 0   (offset: 0x2fa1)
// animtree2 . 0   (offset: 0x2fa1)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_ruby_galileo_cs;

// Namespace zm_sat_ruby_galileo_cs
// Params 0, eflags: 0x5
// Checksum 0xfb09f86a, Offset: 0xc7c
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_ruby_galileo_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_ruby_galileo_cs
// Params 0, eflags: 0x4
// Checksum 0x36fda817, Offset: 0xc9d
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_ruby_galileo_cs
// Params 0, eflags: 0x4
// Checksum 0xb3c67bfb, Offset: 0xcae
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_ruby_galileo_cs
// Params 2
// Checksum 0x32f2db2, Offset: 0xcbf
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_ruby_galileo_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_ruby_galileo_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_ruby_galileo_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_ruby_galileo_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_ruby_galileo_cs
// Params 3, eflags: 0x4
// Checksum 0x3044cf34, Offset: 0xd47
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_ruby_galileo_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_ruby_galileo_cs" );
}

// Namespace zm_sat_ruby_galileo_cs
// Params 3, eflags: 0x4
// Checksum 0x454104de, Offset: 0xdc1
// Size: 0x16f8
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 4308.13, 93.88, -48.84 ), ( 0, 360, 0 ), "cspf_0_auto6417205894324194281", "cspf_0_auto18127366397477971204" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 3905.89, 675.07, -50.5 ), ( 0, 360, 0 ), "cspf_0_auto18127366397477971204", "cspf_0_auto15058133428074556346" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 3512.6, 591.34, -48.33 ), ( 0, 360, 0 ), "cspf_0_auto15058133428074556346", "cspf_0_auto6909493600702381142" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 2732.33, 915.35, -35.58 ), ( 0, 360, 0 ), "cspf_0_auto6909493600702381142", "cspf_0_auto281651594830832143" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 2254.26, 1157.86, 125.96 ), ( 0, 360, 0 ), "cspf_0_auto281651594830832143", "cspf_0_auto9767426195821254672" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 1911.61, 1359.2, 248 ), ( 0, 360, 0 ), "cspf_0_auto9767426195821254672", "cspf_0_auto8614336730260259444" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 1553.84, 1315.6, 252 ), ( 0, 360, 0 ), "cspf_0_auto8614336730260259444", "cspf_0_auto5927251567774048700" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 1525.14, 1732.61, 252 ), ( 0, 360, 0 ), "cspf_0_auto5927251567774048700", "cspf_0_auto2924014714375591404" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 1219.21, 1726.89, 252 ), ( 0, 360, 0 ), "cspf_0_auto2924014714375591404", "cspf_0_auto41654952382015907" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 968.72, -76.31, 240 ), ( 0, 0, 0 ), "cspf_0_auto13750003267717425715", "cspf_0_auto15860543055523051823" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 1893.05, -754.99, -16 ), ( 0, 0, 0 ), "cspf_0_auto11371031396006185902", "cspf_0_auto4689611187331876628" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 3418.66, -1121.38, 17.04 ), ( 0, 0, 0 ), "cspf_0_auto9745261070936642941", "cspf_0_auto10768705204419840902" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 3725.9, -1171.39, 16 ), ( 0, 0, 0 ), "cspf_0_auto10768705204419840902", "cspf_0_auto11582601877278370706" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 3923.65, -1646.31, 16 ), ( 0, 0, 0 ), "cspf_0_auto11582601877278370706", "cspf_0_auto16933810398073686818" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 4270.18, -1769.69, 16 ), ( 0, 0, 0 ), "cspf_0_auto16933810398073686818", "cspf_0_auto17393255369678528281" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 4104.07, -2510.88, 0 ), ( 0, 0, 0 ), "cspf_0_auto12244768647297323059", "cspf_0_auto8183090036940632640" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 2775.66, -2253.99, -67.83 ), ( 0, 0, 0 ), "cspf_0_auto15459604354903527682", "cspf_0_auto9435754660997566561" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 2379.82, -3019.17, 8 ), ( 0, 0, 0 ), "cspf_0_auto9435754660997566561", "cspf_0_auto11863628605508487399" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 1952.6, -3012.2, 8 ), ( 0, 0, 0 ), "cspf_0_auto11863628605508487399", "cspf_0_auto12530965404951172399" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 2029.39, -2582.3, 56 ), ( 0, 0, 0 ), "cspf_0_auto12530965404951172399", "cspf_0_auto3851170667629652075" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 1807.36, -2565.53, 56 ), ( 0, 0, 0 ), "cspf_0_auto3851170667629652075", "cspf_0_auto6837430197868278692" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 1435.42, -2711.8, 56 ), ( 0, 0, 0 ), "cspf_0_auto6837430197868278692", "cspf_0_auto14228099624440929899" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 1413.86, -2519.1, 72 ), ( 0, 0, 0 ), "cspf_0_auto14228099624440929899", "cspf_0_auto14141075239751011265" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 1027.77, -2327.52, 200 ), ( 0, 0, 0 ), "cspf_0_auto6966960799338408653", "cspf_0_auto9219946397442606891" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 1118.85, -1874.02, 200 ), ( 0, 0, 0 ), "cspf_0_auto9219946397442606891", "cspf_0_auto8995441012180971475" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 4458.76, -192.25, -48.02 ), ( 0, 360, 0 ), "cspf_0_auto17420140403547756459", "cspf_0_auto6417205894324194281" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 1151.48, -1514.61, 200 ), ( 0, 0, 0 ), "cspf_0_auto8995441012180971475", "cspf_0_auto11600604278733217356" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 1044.07, 1210.4, 252 ), ( 0, 0, 0 ), "cspf_0_auto41654952382015907", "cspf_0_auto18423810304549169728" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 777, 684.06, 236 ), ( 0, 0, 0 ), "cspf_0_auto2298681841261522583", "cspf_0_auto2957010248407187279" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 806.03, 286.07, 252 ), ( 0, 0, 0 ), "cspf_0_auto2957010248407187279", "cspf_0_auto13750003267717425715" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 4629.65, -455.18, 16 ), ( 0, 105, 0 ), "cspf_0_auto2129719548892515750", "cspf_0_auto17420140403547756459" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 1674.65, -1128.15, 72 ), ( 0, 0, 0 ), "cspf_0_auto11600604278733217356", "cspf_0_auto11489135587448060358" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 1857.49, -590.24, -8.11 ), ( 0, 0, 0 ), "cspf_0_auto11489135587448060358", "cspf_0_auto13434462288411267628" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 947.37, -67.6, 240 ), ( 0, 0, 0 ), "cspf_0_auto13434462288411267628", "cspf_0_auto17912170750258709523" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 801, 286.14, 252 ), ( 0, 0, 0 ), "cspf_0_auto17912170750258709523", "cspf_0_auto17653754843418059067" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 717.63, 1049.39, 251 ), ( 0, 0, 0 ), "cspf_0_auto17653754843418059067", "cspf_0_auto6712208746950867688" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 112.85, 1168.43, 252 ), ( 0, 0, 0 ), "cspf_0_auto11821792360079631277", "cspf_0_auto3369311133208603081" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( -628.86, 1056.79, 247.81 ), ( 0, 0, 0 ), "cspf_0_auto3279177147829417858", "cspf_0_auto11557639446840097958" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( -1050.57, 1011.38, 243.34 ), ( 0, 0, 0 ), "cspf_0_auto11557639446840097958" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( -1764.09, 433.46, 185.15 ), ( 0, 0, 0 ), "cspf_0_auto16056735543409386545", "cspf_0_auto1084127322545228809" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( -2723.03, 193.76, 0.71 ), ( 0, 0, 0 ), "cspf_0_auto18172184854631088532", "cspf_0_auto18131759325575015688" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( -2897.55, -404.4, -11.68 ), ( 0, 0, 0 ), "cspf_0_auto18131759325575015688", "cspf_0_auto45237349050850378" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( -1436.93, -393.18, 240.02 ), ( 0, 0, 0 ), "cspf_0_auto12924522186296160296", "cspf_0_auto3883511866492889753" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( -1124.14, -258.35, 253 ), ( 0, 0, 0 ), "cspf_0_auto3883511866492889753", "cspf_0_auto16856691609834064483" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( -728.3, -341.51, 252 ), ( 0, 0, 0 ), "cspf_0_auto16856691609834064483", "cspf_0_auto13534111573891946222" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( -129.34, -768.56, 252 ), ( 0, 0, 0 ), "cspf_0_auto9628577073742471085", "cspf_0_auto4406712268844354556" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( -81.05, -1177.85, 252.21 ), ( 0, 0, 0 ), "cspf_0_auto4406712268844354556", "cspf_0_auto6205117584945489106" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 4.8, -1707.48, 200 ), ( 0, 0, 0 ), "cspf_0_auto6205117584945489106", "cspf_0_auto8230842181483212611" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 100.72, -2097.99, 200 ), ( 0, 0, 0 ), "cspf_0_auto8230842181483212611", "cspf_0_auto16863289980459926233" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 596.95, -2347.01, 200 ), ( 0, 0, 0 ), "cspf_0_auto16863289980459926233", "cspf_0_auto17226921667380058956" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 419.8, -2879.43, 200 ), ( 0, 0, 0 ), "cspf_0_auto17286733075301295967", "cspf_0_auto6594911464746702637" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 930.86, -3092.28, 200 ), ( 0, 0, 0 ), "cspf_0_auto6594911464746702637", "cspf_0_auto13974999635287341055" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 1362.75, -2956.17, 72 ), ( 0, 0, 0 ), "cspf_0_auto9700666892967879777", "cspf_0_auto16418076303654518416" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 1432.57, -2734.21, 56 ), ( 0, 0, 0 ), "cspf_0_auto16418076303654518416", "cspf_0_auto5999434432283293020" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 1792.34, -2749.27, 56 ), ( 0, 0, 0 ), "cspf_0_auto5999434432283293020", "cspf_0_auto4662740676132236521" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 2021.05, -2784.23, 56 ), ( 0, 0, 0 ), "cspf_0_auto4662740676132236521", "cspf_0_auto14981351129362895178" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 1988.49, -3012.82, 8 ), ( 0, 0, 0 ), "cspf_0_auto14981351129362895178", "cspf_0_auto12691491669283229539" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 2386.74, -3004.08, 8 ), ( 0, 0, 0 ), "cspf_0_auto12691491669283229539", "cspf_0_auto4977728667486838580" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 3180.22, -2488.02, -116.22 ), ( 0, 0, 0 ), "cspf_0_auto4977728667486838580", "cspf_0_auto370218908407426792" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 4027.77, -2168.96, 0 ), ( 0, 0, 0 ), "cspf_0_auto370218908407426792", "cspf_0_auto13108821868521570013" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 4283.17, -1777.32, 16 ), ( 0, 0, 0 ), "cspf_0_auto3546353598400236828", "cspf_0_auto8385995143954427733" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 4713.05, -1747.7, 16 ), ( 0, 0, 0 ), "cspf_0_auto8385995143954427733", "cspf_0_auto8676872529941420952" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 830.76, 957.68, 236 ), ( 0, 0, 0 ), "cspf_0_auto18423810304549169728", "cspf_0_auto2298681841261522583" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 1309.63, -247.06, 105.25 ), ( 0, 0, 0 ), "cspf_0_auto15860543055523051823", "cspf_0_auto8959804167627061493" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 1439.55, -394.39, 96.67 ), ( 0, 0, 0 ), "cspf_0_auto8959804167627061493", "cspf_0_auto5448836464521283238" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 1718.84, -531.81, 3.64 ), ( 0, 0, 0 ), "cspf_0_auto5448836464521283238", "cspf_0_auto11371031396006185902" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 2459.73, -815.47, -0.5 ), ( 0, 0, 0 ), "cspf_0_auto4689611187331876628", "cspf_0_auto18327461318399525597" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 2900.56, -1010.71, -8.25 ), ( 0, 0, 0 ), "cspf_0_auto18327461318399525597", "cspf_0_auto9745261070936642941" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 1261.09, -2377.65, 133 ), ( 0, 0, 0 ), "cspf_0_auto14141075239751011265", "cspf_0_auto6966960799338408653" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 4794.39, -872.22, 16 ), ( 358.35, 118.98, 1.25 ), "cspf_0_auto9336750901187647114", "cspf_0_auto150261961150963527" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 1205.18, 1380.58, 251.5 ), ( 0, 0, 0 ), "cspf_0_auto6712208746950867688", "cspf_0_auto1504450261174976984" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( -303.12, 1020.96, 252.1 ), ( 0, 0, 0 ), "cspf_0_auto3369311133208603081", "cspf_0_auto3279177147829417858" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( -1166.94, 931.51, 238.55 ), ( 0, 0, 0 ), "cspf_0_auto12280931529279538651", "cspf_0_auto16056735543409386545" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( -2221.24, 319.6, 53.92 ), ( 0, 0, 0 ), "cspf_0_auto1084127322545228809", "cspf_0_auto18172184854631088532" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( -2046.21, -433.06, 50.23 ), ( 0, 0, 0 ), "cspf_0_auto45237349050850378", "cspf_0_auto16939011798027938867" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( -1707.41, -457.36, 176.21 ), ( 0, 0, 0 ), "cspf_0_auto16939011798027938867", "cspf_0_auto12924522186296160296" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( -510.09, -638.56, 252 ), ( 0, 0, 0 ), "cspf_0_auto13534111573891946222", "cspf_0_auto9628577073742471085" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 416.89, -2539.85, 200 ), ( 0, 0, 0 ), "cspf_0_auto17226921667380058956", "cspf_0_auto17286733075301295967" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 1159.85, -3062.91, 147.51 ), ( 0, 0, 0 ), "cspf_0_auto13974999635287341055", "cspf_0_auto9700666892967879777" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 4236.02, -2040.32, 16 ), ( 0, 0, 0 ), "cspf_0_auto17393255369678528281", "cspf_0_auto12244768647297323059" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 4223.09, -2037.86, 16 ), ( 0, 0, 0 ), "cspf_0_auto13108821868521570013", "cspf_0_auto3546353598400236828" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 4845.33, -1508.35, 16 ), ( 0, 0, 0 ), "cspf_0_auto8676872529941420952", "cspf_0_auto9336750901187647114" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 4635.07, -583.29, 16 ), ( 0.54, 199.51, -0.51 ), "cspf_0_auto150261961150963527", "cspf_0_auto2129719548892515750" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( -898.57, 373.38, 243.34 ), ( 0, 174, 0 ), undefined, "cspf_0_auto12280931529279538651", "galileo_patrol_start_point" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 3469.07, -2794.88, -4.07 ), ( 0, 0, 0 ), "cspf_0_auto8183090036940632640", "cspf_0_auto15459604354903527682" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 1140.18, 2094.58, 284 ), ( 0, 0, 0 ), "cspf_0_auto1504450261174976984", "cspf_0_auto6563248819314766665" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 646.18, 2208.58, 284 ), ( 0, 0, 0 ), "cspf_0_auto6563248819314766665", "cspf_0_auto14970947159718856469" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_galileo_cs";
    fe [[ f ]]( s, us, cf, ( 571.18, 1495.58, 220 ), ( 0, 0, 0 ), "cspf_0_auto14970947159718856469", "cspf_0_auto11821792360079631277" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_ruby_galileo_cs
// Params 0, eflags: 0x4
// Checksum 0x2f6611a8, Offset: 0x24c1
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_ruby_galileo_cs
// Params 0
// Checksum 0xf2171279, Offset: 0x24cb
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_ruby_galileo_cs" );
}

