// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_script_radiation_cloud_cs.gsc  (hash_09b0985f0e3febb6.gscc) (size: 20824 Bytes / 0x5158 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa9252661 (2837784161)
// size ...... 20824 (0x5158)
// includes .. 3   (offset: 0x450c)
// strings ... 113 (offset: 0x4524)
// dev strs .. 0   (offset: 0x5158)
// exports ... 9   (offset: 0x4174)
// cseg ...... 0x1391 + 0x2de3 (0x4174)
// imports ... 20  (offset: 0x42dc)
// animtree1 . 0   (offset: 0x5158)
// animtree2 . 0   (offset: 0x5158)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_mantis_script_radiation_cloud_cs;

// Namespace zm_sat_mantis_script_radiation_cloud_cs
// Params 0, eflags: 0x5
// Checksum 0x4aabaa37, Offset: 0x13af
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_mantis_script_radiation_cloud_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_mantis_script_radiation_cloud_cs
// Params 0, eflags: 0x4
// Checksum 0xf6cd6a88, Offset: 0x13d0
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_mantis_script_radiation_cloud_cs
// Params 0, eflags: 0x4
// Checksum 0x73f6b964, Offset: 0x13e1
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_mantis_script_radiation_cloud_cs
// Params 2
// Checksum 0xc31fef2d, Offset: 0x13f2
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_mantis_script_radiation_cloud_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_mantis_script_radiation_cloud_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_mantis_script_radiation_cloud_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_mantis_script_radiation_cloud_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_mantis_script_radiation_cloud_cs
// Params 3, eflags: 0x4
// Checksum 0xf0740dab, Offset: 0x147a
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_mantis_script_radiation_cloud_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_mantis_script_radiation_cloud_cs" );
}

// Namespace zm_sat_mantis_script_radiation_cloud_cs
// Params 3, eflags: 0x4
// Checksum 0x658de03d, Offset: 0x14f4
// Size: 0x2c60
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_1";
    s.name = "Radiation_Cloud_Future_NT_culdesac";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 55053, -31371, -124.9 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_culdesac", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_2";
    s.name = "Radiation_Cloud_Future_NT_culdesac";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 55143, -30748, -124.1 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_culdesac", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_3";
    s.name = "Radiation_Cloud_Future_NT_backyard_2";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 54589, -30287, -122.1 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_backyard_2", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_4";
    s.name = "Radiation_Cloud_Future_NT_backyard_2";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 54422, -29922, -124.2 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_backyard_2", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_5";
    s.name = "Radiation_Cloud_Future_NT_backyard_2";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 55142, -29810, -129.4 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_backyard_2", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_6";
    s.name = "Radiation_Cloud_Future_NT_backyard_2";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 55206, -29445, -127.4 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_backyard_2", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_7";
    s.name = "Radiation_Cloud_Future_NT_culdesac";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 55991, -30423, -126.8 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_culdesac", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_8";
    s.name = "Radiation_Cloud_Future_NT_culdesac";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 55835, -31568, -127.21 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_culdesac", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_9";
    s.name = "Radiation_Cloud_Future_NT_culdesac";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 56325, -30842, -127 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_culdesac", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_10";
    s.name = "Radiation_Cloud_Future_NT_culdesac";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 56372, -31079, -118.09 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_culdesac", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_11";
    s.name = "Radiation_Cloud_Future_NT_backyard_1";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 56811, -31179, -128.9 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_future_backyard_1", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_12";
    s.name = "Radiation_Cloud_Future_NT_backyard_1";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 57163, -31480.3, -120.6 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_future_backyard_1", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_13";
    s.name = "Radiation_Cloud_Future_NT_backyard_1";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 57107, -32062.3, -126.3 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_future_backyard_1", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_14";
    s.name = "Radiation_Cloud_Future_NT_backyard_1";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 56463, -32147.3, -127.2 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_future_backyard_1", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_15";
    s.name = "Radiation_Cloud_Future_NT_culdesac";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 55821, -31273.3, -132.9 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_culdesac", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_16";
    s.name = "Radiation_Cloud_Future_NT_culdesac";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 55804, -30719.3, -125 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_culdesac", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_17";
    s.name = "Radiation_Cloud_Past_NT_culdesac";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 77657, -31515, -124.9 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_culdesac", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_18";
    s.name = "Radiation_Cloud_Past_NT_culdesac";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 77673, -30778, -124.1 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_culdesac", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_19";
    s.name = "Radiation_Cloud_Past_NT_backyard_2";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 77065, -30273, -122.1 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_backyard_2", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_20";
    s.name = "Radiation_Cloud_Past_NT_backyard_2";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 76968, -29854, -124.2 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_backyard_2", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_21";
    s.name = "Radiation_Cloud_Past_NT_backyard_2";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 77488, -29648, -129.4 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_backyard_2", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_22";
    s.name = "Radiation_Cloud_Past_NT_backyard_2";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 77674, -29845, -127.4 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_backyard_2", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_23";
    s.name = "Radiation_Cloud_Past_NT_culdesac";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 78291, -30277, -126.8 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_culdesac", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_24";
    s.name = "Radiation_Cloud_Past_NT_culdesac";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 78375, -31564, -120 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_culdesac", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_25";
    s.name = "Radiation_Cloud_Past_NT_culdesac";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 78841, -30774, -127 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_culdesac", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_26";
    s.name = "Radiation_Cloud_Past_NT_culdesac";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 78942, -31091, -128 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_culdesac", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_27";
    s.name = "Radiation_Cloud_Past_NT_backyard_1";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 79463, -31241, -128.9 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_backyard_1", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_28";
    s.name = "Radiation_Cloud_Past_NT_backyard_1";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 79619, -31866.3, -120.6 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_backyard_1", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_29";
    s.name = "Radiation_Cloud_Past_NT_backyard_1";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 79799, -32152.3, -126.3 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_backyard_1", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_30";
    s.name = "Radiation_Cloud_Past_NT_backyard_1";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 79269, -32273.3, -127.2 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_backyard_1", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_31";
    s.name = "Radiation_Cloud_Past_NT_culdesac";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 78349, -31273.3, -134.9 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_culdesac", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_32";
    s.name = "Radiation_Cloud_Past_NT_culdesac";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 78332, -30719.3, -125 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_culdesac", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_33";
    s.name = "Radiation_Cloud_Future_NT_backyard_1";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 56941, -32372.3, -126.3 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_future_backyard_1", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_34";
    s.name = "Radiation_Cloud_Future_NT_backyard_1";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 57269, -31732.3, -120.6 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_future_backyard_1", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_35";
    s.name = "Radiation_Cloud_Future_NT_backyard_1";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 56675, -31588.3, -120.6 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_future_backyard_1", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_36";
    s.name = "Radiation_Cloud_Future_NT_backyard_1";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 56985, -31824.3, -120.6 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_future_backyard_1", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_37";
    s.name = "Radiation_Cloud_Future_NT_backyard_1";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 56247, -31943.3, -127.2 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_future_backyard_1", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_38";
    s.name = "Radiation_Cloud_Future_NT_culdesac";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 56025, -30972, -127 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_culdesac", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_39";
    s.name = "Radiation_Cloud_Future_NT_culdesac";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 55345, -31478, -127.21 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_culdesac", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_40";
    s.name = "Radiation_Cloud_Future_NT_backyard_2";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 54881, -30690, -124.1 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_backyard_2", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_41";
    s.name = "Radiation_Cloud_Future_NT_culdesac";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 55414, -30885.3, -127 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_culdesac", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_42";
    s.name = "Radiation_Cloud_Future_NT_culdesac";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 55679, -30483, -126.8 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_culdesac", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_43";
    s.name = "Radiation_Cloud_Future_NT_culdesac";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 55556, -31299.3, -127 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_culdesac", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_44";
    s.name = "Radiation_Cloud_Future_NT_backyard_2";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 55392, -29937, -127.4 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_backyard_2", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_45";
    s.name = "Radiation_Cloud_Future_NT_backyard_2";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 55602, -30139, -127.4 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_backyard_2", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_46";
    s.name = "Radiation_Cloud_Future_NT_backyard_2";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 54765, -30399, -122.1 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_backyard_2", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_47";
    s.name = "Radiation_Cloud_Future_NT_backyard_2";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 54981, -30095, -122.1 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_backyard_2", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_48";
    s.name = "Radiation_Cloud_Future_NT_backyard_2";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 54755, -29681, -122.1 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_backyard_2", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_49";
    s.name = "Radiation_Cloud_Future_NT_backyard_2";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 54762, -29961, -127.4 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_backyard_2", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_50";
    s.name = "Radiation_Cloud_Future_NT_street";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 54875, -31735, -124.9 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_street", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_51";
    s.name = "Radiation_Cloud_Future_NT_street";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 54605, -31625, -124.9 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_street", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_52";
    s.name = "Radiation_Cloud_Future_NT_street";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 55063, -32063, -124.9 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_street", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_53";
    s.name = "Radiation_Cloud_Future_NT_street";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 54661, -32439, -124.9 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_street", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_54";
    s.name = "Radiation_Cloud_Future_NT_street";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 54501, -33007, -124.9 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_street", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_55";
    s.name = "Radiation_Cloud_Future_NT_street";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 54149, -32915, -124.9 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_street", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_56";
    s.name = "Radiation_Cloud_Future_NT_street";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 53927, -32411, -124.9 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_street", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_57";
    s.name = "Radiation_Cloud_Future_NT_street";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 54031, -31925, -124.9 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_street", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_58";
    s.name = "Radiation_Cloud_Future_NT_street";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 54363, -32129, -124.9 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_street", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_59";
    s.name = "Radiation_Cloud_Future_NT_street";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 55131, -32579, -124.9 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_street", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_60";
    s.name = "Radiation_Cloud_Future_NT_street";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 53737, -31565, -124.9 ), ( 0, 0, 0 ), "radiation_cloud_spot1", undefined, "radiation_cloud_spot_future_street", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_61";
    s.name = "Radiation_Cloud_Past_NT_culdesac";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 78575, -30956, -127 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_culdesac", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_62";
    s.name = "Radiation_Cloud_Past_NT_culdesac";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 77921, -31509.3, -134.9 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_culdesac", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_63";
    s.name = "Radiation_Cloud_Past_NT_culdesac";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 78025, -30811.3, -134.9 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_culdesac", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_64";
    s.name = "Radiation_Cloud_Past_NT_culdesac";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 77417, -30692, -124.1 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_culdesac", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_65";
    s.name = "Radiation_Cloud_Past_NT_culdesac";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 78175, -30583, -126.8 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_culdesac", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_66";
    s.name = "Radiation_Cloud_Past_NT_culdesac";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 78559, -30423, -126.8 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_culdesac", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_67";
    s.name = "Radiation_Cloud_Past_NT_backyard_2";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 77285, -30409, -122.1 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_backyard_2", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_68";
    s.name = "Radiation_Cloud_Past_NT_backyard_2";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 77537, -30083, -122.1 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_backyard_2", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_69";
    s.name = "Radiation_Cloud_Past_NT_backyard_2";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 77231, -29737, -122.1 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_backyard_2", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_70";
    s.name = "Radiation_Cloud_Past_NT_backyard_2";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 78134, -30114, -129.4 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_backyard_2", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_71";
    s.name = "Radiation_Cloud_Past_NT_backyard_2";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 77912, -29926, -129.4 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_backyard_2", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_72";
    s.name = "Radiation_Cloud_Past_NT_backyard_2";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 77838, -29650, -129.4 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_backyard_2", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_73";
    s.name = "Radiation_Cloud_Past_NT_backyard_1";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 79225, -31255, -128.9 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_backyard_1", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_74";
    s.name = "Radiation_Cloud_Past_NT_backyard_1";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 79195, -31655, -128.9 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_backyard_1", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_75";
    s.name = "Radiation_Cloud_Past_NT_backyard_1";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 79657, -31531, -128.9 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_backyard_1", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_76";
    s.name = "Radiation_Cloud_Past_NT_backyard_1";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 79333, -31965.3, -127.2 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_backyard_1", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_77";
    s.name = "Radiation_Cloud_Past_NT_backyard_1";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 79091, -31991.3, -127.2 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_backyard_1", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_78";
    s.name = "Radiation_Cloud_Past_NT_backyard_1";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 78723, -32017.3, -127.2 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_backyard_1", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_79";
    s.name = "Radiation_Cloud_Past_NT_backyard_1";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 78523, -31759.3, -127.2 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_backyard_1", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_80";
    s.name = "Radiation_Cloud_Past_NT_street";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 77101, -31641, -124.9 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_street", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_81";
    s.name = "Radiation_Cloud_Past_NT_street";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 76941, -31981, -124.9 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_street", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_82";
    s.name = "Radiation_Cloud_Past_NT_street";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 77243, -32369, -124.9 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_street", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_83";
    s.name = "Radiation_Cloud_Past_NT_street";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 77661, -32559, -124.9 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_street", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_84";
    s.name = "Radiation_Cloud_Past_NT_street";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 77621, -32177, -124.9 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_street", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_85";
    s.name = "Radiation_Cloud_Past_NT_street";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 77031, -32973, -124.9 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_street", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_86";
    s.name = "Radiation_Cloud_Past_NT_street";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 76693, -32873, -124.9 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_street", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_87";
    s.name = "Radiation_Cloud_Past_NT_street";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 76667, -32255, -124.9 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_street", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_88";
    s.name = "Radiation_Cloud_Past_NT_street";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 76269, -32307, -124.9 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_street", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_89";
    s.name = "Radiation_Cloud_Past_NT_street";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 76549, -31941, -124.9 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_street", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_90";
    s.name = "Radiation_Cloud_Past_NT_street";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 76397, -31659, -124.9 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_street", undefined, undefined, undefined, undefined, 64 );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_script_radiation_cloud_cs";
    s.entity_id = "zm_sat_mantis_script_radiation_cloud_cs_91";
    s.name = "Radiation_Cloud_Past_NT_street";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 77395, -31839, -124.9 ), ( 0, 0, 0 ), "radiation_cloud_spot2", undefined, "radiation_cloud_spot_past_street", undefined, undefined, undefined, undefined, 64 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_mantis_script_radiation_cloud_cs
// Params 0, eflags: 0x4
// Checksum 0xc2f4afe8, Offset: 0x415c
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_mantis_script_radiation_cloud_cs
// Params 0
// Checksum 0x3227d0e6, Offset: 0x4166
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_mantis_script_radiation_cloud_cs" );
}

