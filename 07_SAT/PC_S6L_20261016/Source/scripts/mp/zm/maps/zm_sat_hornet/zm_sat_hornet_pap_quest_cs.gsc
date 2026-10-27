// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_pap_quest_cs.gsc  (hash_2650e8df4add879b.gscc) (size: 8888 Bytes / 0x22b8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xedf7da09 (3992443401)
// size ...... 8888 (0x22b8)
// includes .. 2   (offset: 0x1d88)
// strings ... 69  (offset: 0x1d98)
// dev strs .. 0   (offset: 0x22b8)
// exports ... 6   (offset: 0x1ad8)
// cseg ...... 0x73f + 0x1399 (0x1ad8)
// imports ... 16  (offset: 0x1bc8)
// animtree1 . 0   (offset: 0x22b8)
// animtree2 . 0   (offset: 0x22b8)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_hornet_pap_quest_cs;

// Namespace zm_sat_hornet_pap_quest_cs
// Params 2
// Checksum 0xcc6bb491, Offset: 0x75d
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_hornet_pap_quest_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_hornet_pap_quest_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_hornet_pap_quest_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_hornet_pap_quest_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_hornet_pap_quest_cs
// Params 3, eflags: 0x4
// Checksum 0xff005617, Offset: 0x7e5
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_hornet_pap_quest_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_hornet_pap_quest_cs" );
}

// Namespace zm_sat_hornet_pap_quest_cs
// Params 3, eflags: 0x4
// Checksum 0xb8765a8c, Offset: 0x85f
// Size: 0x1259
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( -124, -23637, 194 ), ( 0, 260, 0 ), undefined, "cspf_0_auto4964331787338610372", "path_west_0" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 655, -23576, 238 ), ( 0, 280, 0 ), undefined, "cspf_0_auto16353265972465859533", "path_east_0" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( -618, -22919, 222 ), ( 0, 9, 0 ), "cspf_0_auto4964331787338610372", "cspf_0_auto6834012585205109292", "path_west_1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( -350, -19929, 817 ), ( 0, 280, 0 ), "seal_west" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 1662, -23073, 288 ), ( 0, 0, 0 ), "cspf_0_auto16353265972465859533", "cspf_0_auto1267322467100490705", "path_east_1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( -293, -19919, 817 ), ( 0, 280, 0 ), "seal_east" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( -322, -19925, 817 ), ( 0, 280, 0 ), "gate_entrance" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( -353, -19696, 768 ), ( 0, 280, 0 ), "castle_entrance", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 80, -17107.8, 1232.5 ), ( 90, 260, 70 ), "cspf_0_auto8910402664700623584" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 582.75, -17018.2, 1393.75 ), ( 20, 190, -180 ), "cspf_0_auto13011617758106810474", undefined, "embed" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( -189, -18529, 896 ), ( 0, 280, 0 ), "castle_spawn", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 557.5, -17027, 1434 ), ( 0, 8, 0 ), "cspf_0_auto202461877666712706", "cspf_0_auto13011617758106810474" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 22, -17117, 1183.51 ), ( 0, 190, 0 ), "pap_special", undefined, undefined, undefined, undefined, undefined, undefined, 360 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 596, -17016, 1344 ), ( 0, 190, 0 ), "pedestal" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 596, -17016, 1385 ), ( 0, 190, 0 ), "seed", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    s.is_cs_trigger = 1;
    s._size_max = ( 102, 4, 4 );
    s._size_min = ( 92, 4, 4 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 697, -16998, 1394 ), ( 0, 10, 0 ), "t_power_beam" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 2208, -16781, 1997 ), ( 0, 190, 0 ), "k_start", "cspf_0_auto17884864240119623525" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 853, -17003, 1616 ), ( 0, 190, 0 ), "cspf_0_auto17884864240119623525", "cspf_0_auto9116659035427913296" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 667, -17038, 1504 ), ( 0, 190, 0 ), "cspf_0_auto9116659035427913296", "cspf_0_auto6955705534454747776" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 572, -17009, 1473 ), ( 0, 190, 0 ), "cspf_0_auto6955705534454747776", "cspf_0_auto7691739496075938863" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 479, -16928, 1456 ), ( 0, 190, 0 ), "cspf_0_auto7691739496075938863", "cspf_0_auto6156936276291301814" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 805.5, -16979, 1395 ), ( 0, 190, 0 ), "pap_receptor", "cspf_0_auto4020900337728922167" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 367, -16908, 1441 ), ( 0, 190, 0 ), "cspf_0_auto6156936276291301814", "cspf_0_auto10371060834980732331" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 260, -16977, 1441 ), ( 0, 190, 0 ), "cspf_0_auto10371060834980732331", "cspf_0_auto8913128874810785968" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 235, -17104, 1441 ), ( 0, 190, 0 ), "cspf_0_auto8913128874810785968", "cspf_0_auto3055928172243489116" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 176, -17243, 1441 ), ( 0, 190, 0 ), "cspf_0_auto3055928172243489116", "cspf_0_auto6112802480694606992" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 74.71, -17108.7, 1250 ), ( 0, 190, 0 ), "pap_entrance", "cspf_0_auto8910402664700623584" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 19, -17243, 1441 ), ( 0, 190, 0 ), "cspf_0_auto6112802480694606992", "cspf_0_auto8739296227794002213" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( -97, -17165, 1441 ), ( 0, 190, 0 ), "cspf_0_auto8739296227794002213", "cspf_0_auto1077560949532350232" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( -126, -17039, 1441 ), ( 0, 190, 0 ), "cspf_0_auto1077560949532350232", "cspf_0_auto3837107872552958466" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( -79, -16927, 1452 ), ( 0, 190, 0 ), "cspf_0_auto3837107872552958466", "cspf_0_auto9938228266181449116" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 70, -16866, 1474 ), ( 0, 190, 0 ), "cspf_0_auto9938228266181449116", "cspf_0_auto15162404540471868686" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 3164.34, -22313.1, 263.5 ), ( 0, 180, 0 ), "escape_pt" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 2259.34, -21442.1, 392 ), ( 0, 180, 0 ), "escape_pt" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( -1185.66, -22110.1, 136 ), ( 0, 180, 0 ), "escape_pt" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( -3357.66, -22066.1, 114 ), ( 0, 180, 0 ), "escape_pt" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 664.5, -17004, 1344 ), ( 0, 190, 0 ), "pap_room", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 176, -16924, 1490 ), ( 0, 190, 0 ), "cspf_0_auto15162404540471868686", "cspf_0_auto1492999196054385697" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    s.is_cs_trigger = 1;
    s._size_max = ( 550, 431, 64 );
    s._size_min = ( 428, 433, 4 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 281.72, -17156, 1184 ), ( 0, 190.5, 0 ), "trigger_oni" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 410, -16996, 1521 ), ( 0, 190, 0 ), "cspf_0_auto1492999196054385697", "cspf_0_auto11189707207910154849" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 516, -17025, 1474 ), ( 0, 190, 0 ), "cspf_0_auto11189707207910154849", "cspf_0_auto202461877666712706" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 580, -17082, 1352 ), ( 0, 80, 0 ), "sq_return" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 2877, -22327, 313 ), ( 0, 255, 0 ), "cspf_0_auto1267322467100490705" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( -2477, -22695, 190 ), ( 0, -5, 0 ), "cspf_0_auto6834012585205109292" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 708.5, -16932, 1352 ), ( 0, 190, 0 ), "cspf_0_auto4020900337728922167" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 711.5, -16963, 1352 ), ( 0, 190, 0 ), "cspf_0_auto4020900337728922167" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 722.5, -17022, 1351.39 ), ( 0, 190, 0 ), "cspf_0_auto4020900337728922167" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 727.5, -17057, 1353.79 ), ( 0, 190, 0 ), "cspf_0_auto4020900337728922167" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 596, -17016, 1344 ), ( 0, 190, 0 ), "pedestal_seal" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 588, -17017, 1380 ), ( 0, 190, -180 ), "katana_impact" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( -6, -16630, 1260 ), ( 0, 190, 0 ), "oni_trail_s", "cspf_0_auto36985199668936969" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( -360, -18899, 891 ), ( 0, 10, 0 ), "pap_waypoint_west", "cspf_0_auto5997095013400353115" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( -1188, -17686, 1066 ), ( 0, 280, 0 ), "cspf_0_auto5997095013400353115" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 77, -18804, 977 ), ( 0, 190, 0 ), "pap_waypoint_east", "cspf_0_auto15695527580090193807" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 296, -17618, 1226 ), ( 0, 280, 0 ), "cspf_0_auto15695527580090193807" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( -188, -16665, 1260 ), ( 0, 227, 0 ), "cspf_0_auto36985199668936969", "cspf_0_auto6086043466263526005" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( -290, -16778, 1260 ), ( 0, 287, 0 ), "cspf_0_auto6086043466263526005", "cspf_0_auto8428255138181039200" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( -250, -16915, 1252 ), ( 0, 317, 0 ), "cspf_0_auto8428255138181039200", "cspf_0_auto10958042114628257510" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( -141, -17016, 1245 ), ( 0, 328, 0 ), "cspf_0_auto10958042114628257510", "cspf_0_auto12245564028715060497" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 20, -17117, 1245 ), ( 0, 330, 0 ), "cspf_0_auto12245564028715060497" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 858, -17204, 1260 ), ( 0, 277, 0 ), "oni_trail_w", "cspf_0_auto1095987851092075192" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 868, -17284, 1260 ), ( 0, 261, 0 ), "cspf_0_auto1095987851092075192", "cspf_0_auto10647468665180838086" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 852, -17397, 1260 ), ( 0, 182, 0 ), "cspf_0_auto10647468665180838086", "cspf_0_auto13122010782117463828" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 749, -17400, 1252 ), ( 0, 171, 0 ), "cspf_0_auto13122010782117463828", "cspf_0_auto8480116036173475817" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 502, -17363, 1245 ), ( 0, 168, 0 ), "cspf_0_auto8480116036173475817", "cspf_0_auto11736167699385891805" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 218, -17308, 1245 ), ( 0, 161, 0 ), "cspf_0_auto11736167699385891805", "cspf_0_auto14606692823703635254" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 90, -17266, 1245 ), ( 0, 115, 0 ), "cspf_0_auto14606692823703635254", "cspf_0_auto607952523836051085" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_pap_quest_cs";
    fe [[ f ]]( s, us, cf, ( 21, -17118, 1245 ), ( 0, 118, 0 ), "cspf_0_auto607952523836051085" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_hornet_pap_quest_cs
// Params 0, eflags: 0x4
// Checksum 0xbb5b4b53, Offset: 0x1ac0
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_hornet_pap_quest_cs
// Params 0
// Checksum 0x3d538b5a, Offset: 0x1aca
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_hornet_pap_quest_cs" );
}

