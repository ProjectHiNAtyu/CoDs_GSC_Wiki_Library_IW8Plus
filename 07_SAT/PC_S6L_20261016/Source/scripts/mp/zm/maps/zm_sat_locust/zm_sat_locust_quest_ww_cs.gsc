// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_quest_ww_cs.gsc  (hash_18eeee6202e0a7c2.gscc) (size: 9635 Bytes / 0x25a3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd839b01b (3627659291)
// size ...... 9635 (0x25a3)
// includes .. 3   (offset: 0x213b)
// strings ... 41  (offset: 0x2153)
// dev strs .. 0   (offset: 0x25a3)
// exports ... 9   (offset: 0x1d6b)
// cseg ...... 0x326 + 0x1a45 (0x1d6b)
// imports ... 21  (offset: 0x1ed3)
// animtree1 . 0   (offset: 0x25a3)
// animtree2 . 0   (offset: 0x25a3)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_locust_quest_ww_cs;

// Namespace zm_sat_locust_quest_ww_cs
// Params 0, eflags: 0x5
// Checksum 0x9cd8795a, Offset: 0x344
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_locust_quest_ww_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_locust_quest_ww_cs
// Params 0, eflags: 0x4
// Checksum 0xe5baa787, Offset: 0x365
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_locust_quest_ww_cs
// Params 0, eflags: 0x4
// Checksum 0x6081746b, Offset: 0x376
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_locust_quest_ww_cs
// Params 2
// Checksum 0xd0682222, Offset: 0x387
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_locust_quest_ww_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_locust_quest_ww_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_locust_quest_ww_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_locust_quest_ww_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_locust_quest_ww_cs
// Params 3, eflags: 0x4
// Checksum 0xe303c0a4, Offset: 0x40f
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_locust_quest_ww_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_locust_quest_ww_cs" );
}

// Namespace zm_sat_locust_quest_ww_cs
// Params 3, eflags: 0x4
// Checksum 0x17634c2, Offset: 0x489
// Size: 0x18c2
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.name = "Crypt Loot Chain";
    fe [[ f ]]( s, us, cf, ( 681.59, 3330.27, 185.99 ), ( 0, 30, 0 ), "ww_ch_li" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.groupid = "Crypt Code Wall";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 6570.74, 6938.84, 55.5 ), ( 350, 90, 0 ), "cr_co_wa" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.groupid = "Bait";
    fe [[ f ]]( s, us, cf, ( 1223, 7608, 511 ), ( 354, 0, 0 ), "ww_ba_lo" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    fe [[ f ]]( s, us, cf, ( 7035.41, 1292.11, 1652 ), ( 0, 190.9, 0 ), "li_ww_lo" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.groupid = "Bait";
    fe [[ f ]]( s, us, cf, ( 4786, 5440, 277 ), ( 0, 323, 0 ), "ww_ba_tr" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.groupid = "Bait";
    s.script_animation = "spawn";
    fe [[ f ]]( s, us, cf, ( 5944, 5646, 134.6 ), ( 0, 190, 0 ), "ww_ca" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.name = "Crypt Door Chain Placement";
    fe [[ f ]]( s, us, cf, ( 5938, 6958, 288 ), ( 0, 0, 0 ), "cr_do_ch" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.name = "Crypt Lantern";
    fe [[ f ]]( s, us, cf, ( 6572, 6896, 77 ), ( 0, 270, 0 ), "cr_la_lo", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    fe [[ f ]]( s, us, cf, ( 5947, 6891, 325 ), ( 0, 180, 0 ), "cr_do_fx" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 548, 246, 576 );
    s._size_min = ( 192, 116, -224 );
    s.groupid = "WW Kill Triggers";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 4960, 2592, 32 ), ( 0, 345, 0 ), "ww_kill_trigger" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    fe [[ f ]]( s, us, cf, ( 5246, 5554, 224 ), ( 0, 0, 0 ), "ww_bu_fa" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 352, 384, 544 );
    s._size_min = ( 320, 384, 192 );
    s.groupid = "Lighthouse Top";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 7155, 1327, 1600 ), ( 0, 0, 0 ), "ww_lighthouse_top" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    fe [[ f ]]( s, us, cf, ( 6984, 1456, 1008 ), ( 0, 0, 0 ), "ww_li_ba_pl", undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 216, 224, 48 );
    s._size_min = ( 168, 112, 32 );
    s.groupid = "WW Kill Triggers";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 6185.71, 2571.09, 380.94 ), ( 0, 0, 0 ), "ww_kill_trigger" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.groupid = "Platform 1";
    fe [[ f ]]( s, us, cf, ( 4878, 2560, 320 ), ( 0, 0, 0 ), "cspf_0_auto10793072749253841519" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.groupid = "Platform 1";
    fe [[ f ]]( s, us, cf, ( 4714, 2568, 216 ), ( 0, 180, 0 ), "ww_platform_1", "cspf_0_auto17977391610098995967" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.groupid = "Platform 1";
    fe [[ f ]]( s, us, cf, ( 4856, 2532, 320 ), ( 0, 0, 0 ), "cspf_0_auto17977391610098995967", "cspf_0_auto10793072749253841519" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.groupid = "Platform 1";
    fe [[ f ]]( s, us, cf, ( 4878, 2592, 320 ), ( 0, 0, 0 ), "cspf_0_auto10793072749253841519" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.groupid = "Platform 1";
    fe [[ f ]]( s, us, cf, ( 4878, 2490, 320 ), ( 0, 0, 0 ), "cspf_0_auto10793072749253841519" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.groupid = "Platform 1";
    fe [[ f ]]( s, us, cf, ( 4878, 2522, 320 ), ( 0, 0, 0 ), "cspf_0_auto10793072749253841519" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 192, 320, 576 );
    s._size_min = ( 224, 224, 32 );
    s.groupid = "WW Kill Triggers";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 5760, 2784, 32 ), ( 0, 0, 0 ), "ww_kill_trigger" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 160, 128, 32 );
    s._size_min = ( 184, 160, 32 );
    s.groupid = "WW Kill Triggers";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 6496, 2304, 496 ), ( 0, 0, 0 ), "ww_kill_trigger" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.groupid = "Platform 2";
    fe [[ f ]]( s, us, cf, ( 6975.63, 1011.29, 694 ), ( 0, 278, 0 ), "cspf_0_auto2188627573495793110" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.groupid = "Platform 2";
    fe [[ f ]]( s, us, cf, ( 7139.24, 1102.83, 750.06 ), ( 0, 0, 0 ), "ww_platform_2", "cspf_0_auto11794597763793603497" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.groupid = "Platform 2";
    fe [[ f ]]( s, us, cf, ( 6954.84, 1029.18, 694 ), ( 0, 278, 0 ), "cspf_0_auto11794597763793603497", "cspf_0_auto2188627573495793110" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.groupid = "Platform 2";
    fe [[ f ]]( s, us, cf, ( 7007.32, 1015.74, 694 ), ( 0, 278, 0 ), "cspf_0_auto2188627573495793110" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.groupid = "Platform 2";
    fe [[ f ]]( s, us, cf, ( 6906.31, 1001.55, 694 ), ( 0, 278, 0 ), "cspf_0_auto2188627573495793110" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.groupid = "Platform 2";
    fe [[ f ]]( s, us, cf, ( 6938, 1006, 694 ), ( 0, 278, 0 ), "cspf_0_auto2188627573495793110" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 160, 140, 32 );
    s._size_min = ( 160, 192, 32 );
    s.groupid = "WW Kill Triggers";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 6944, 928, 704 ), ( 0, 0, 0 ), "ww_kill_trigger" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 128, 192, 32 );
    s._size_min = ( 96, 224, 32 );
    s.groupid = "WW Kill Triggers";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 6464, 1888, 544 ), ( 0, 0, 0 ), "ww_kill_trigger" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.groupid = "Crypt Code Wall";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 6573.39, 6851.34, 55.5 ), ( 350, 270, 0 ), "cr_co_wa" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.groupid = "Crypt Code Wall";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 6596.1, 6897, 55.5 ), ( 351, 0, 0 ), "cr_co_wa" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 64, 64, 32 );
    s._size_min = ( 96, 96, 32 );
    s.groupid = "WW Kill Triggers";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 6432, 1600, 640 ), ( 0, 0, 0 ), "ww_kill_trigger" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.groupid = "Crypt Code Site";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 6592, 6884, 74 ), ( 270, 0, 0 ), "cr_co_si" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.groupid = "Crypt Code Site";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 6592, 6860, 74 ), ( 270, 0, 0 ), "cr_co_si" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.groupid = "Crypt Code Site";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 6592, 6908, 74 ), ( 270, 0, 0 ), "cr_co_si" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.groupid = "Crypt Code Site";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 6592, 6932, 74 ), ( 270, 0, 0 ), "cr_co_si" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    fe [[ f ]]( s, us, cf, ( 7035, 1294, 1615 ), ( 0, 13.2, 0 ), "li_de_in" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.name = "Crane Interact";
    fe [[ f ]]( s, us, cf, ( 152, 3746, 204 ), ( 0, 210, 0 ), "ww_cr_us" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.groupid = "Crypt Code Wall";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 6546.5, 6895.41, 55.5 ), ( 349.5, 180, 0 ), "cr_co_wa" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 176, 246, 300 );
    s._size_min = ( 176, 192, 80 );
    s.groupid = "Life Brush Wall Jump";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 864, 3388, 64 ), ( 0, 30, 0 ), "wall_jump_life" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 128, 128, 32 );
    s._size_min = ( 192, 160, 32 );
    s.groupid = "WW Kill Triggers";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 7320, 876, 540 ), ( 0, 0, 0 ), "ww_kill_trigger" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 160, 160, 32 );
    s._size_min = ( 160, 128, 32 );
    s.groupid = "WW Kill Triggers";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 7648, 1184, 640 ), ( 0, 0, 0 ), "ww_kill_trigger" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 128, 128, 32 );
    s._size_min = ( 192, 160, 32 );
    s.groupid = "WW Kill Triggers";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 7616, 1568, 704 ), ( 0, 0, 0 ), "ww_kill_trigger" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 224, 288, 32 );
    s._size_min = ( 224, 224, 32 );
    s.groupid = "WW Kill Triggers";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 7584, 896, 896 ), ( 0, 0, 0 ), "ww_kill_trigger" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 96, 160, 32 );
    s._size_min = ( 192, 160, 32 );
    s.groupid = "WW Kill Triggers";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 6944, 864, 992 ), ( 0, 0, 0 ), "ww_kill_trigger" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 96, 96, 32 );
    s._size_min = ( 64, 64, 32 );
    s.groupid = "WW Kill Triggers";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 6772, 1120, 1016 ), ( 0, 0, 0 ), "ww_kill_trigger" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 96, 144, 32 );
    s._size_min = ( 96, 112, 32 );
    s.groupid = "WW Kill Triggers";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 6800, 1408, 1008 ), ( 0, 0, 0 ), "ww_kill_trigger" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 112, 96, 32 );
    s._size_min = ( 48, 80, 32 );
    s.groupid = "WW Kill Triggers";
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 6880, 1568, 992 ), ( 0, 0, 0 ), "ww_kill_trigger" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_quest_ww_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 424, 448, 368 );
    s._size_min = ( 456, 608, 40 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 7152, 1328, 1024 ), ( 0, 0, 0 ), "ww_lighthouse_middle" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_locust_quest_ww_cs
// Params 0, eflags: 0x4
// Checksum 0x364aa002, Offset: 0x1d53
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_locust_quest_ww_cs
// Params 0
// Checksum 0x21501de9, Offset: 0x1d5d
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_locust_quest_ww_cs" );
}

