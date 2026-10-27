// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_quest_ee_dblink_cs.gsc  (hash_0dc3d30fc6223a53.gscc) (size: 3261 Bytes / 0xcbd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x16a45e8d (379870861)
// size ...... 3261 (0xcbd)
// includes .. 3   (offset: 0xb3d)
// strings ... 15  (offset: 0xb55)
// dev strs .. 0   (offset: 0xcbd)
// exports ... 9   (offset: 0x7a5)
// cseg ...... 0x17a + 0x62b (0x7a5)
// imports ... 20  (offset: 0x90d)
// animtree1 . 0   (offset: 0xcbd)
// animtree2 . 0   (offset: 0xcbd)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_mantis_quest_ee_dblink_cs;

// Namespace zm_sat_mantis_quest_ee_dblink_cs
// Params 0, eflags: 0x5
// Checksum 0xfa1724d, Offset: 0x198
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_mantis_quest_ee_dblink_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_mantis_quest_ee_dblink_cs
// Params 0, eflags: 0x4
// Checksum 0x3721bcf, Offset: 0x1b9
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_mantis_quest_ee_dblink_cs
// Params 0, eflags: 0x4
// Checksum 0x8649c823, Offset: 0x1ca
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_mantis_quest_ee_dblink_cs
// Params 2
// Checksum 0x36a09e6a, Offset: 0x1db
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_mantis_quest_ee_dblink_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_mantis_quest_ee_dblink_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_mantis_quest_ee_dblink_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_mantis_quest_ee_dblink_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_mantis_quest_ee_dblink_cs
// Params 3, eflags: 0x4
// Checksum 0x5cb7cec, Offset: 0x263
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_mantis_quest_ee_dblink_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_mantis_quest_ee_dblink_cs" );
}

// Namespace zm_sat_mantis_quest_ee_dblink_cs
// Params 3, eflags: 0x4
// Checksum 0x414dd96, Offset: 0x2dd
// Size: 0x4a8
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_dblink_cs";
    s.script_label = "m2";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 78205.8, -31326.2, -87.66 ), ( 0, 249.7, 0 ), "past", "cspf_0_auto14169780487724450918", "db_ee_m_loc_past" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_dblink_cs";
    s.script_label = "m1";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 76813.1, -33433.6, -127.1 ), ( 0, 134.7, 0 ), undefined, "cspf_0_auto11515511605148953639", "db_ee_m_loc_past" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_dblink_cs";
    s.script_label = "m1";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 53813.8, -31337.2, -124.51 ), ( 0, 93.21, 0 ), undefined, undefined, "db_ee_m_loc_future" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_dblink_cs";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 78270.5, -31371.1, -113.51 ), ( 0, 323.6, 0 ), "cspf_0_auto14169780487724450918" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_dblink_cs";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 76751.5, -33398.9, -116.84 ), ( 0, 310.1, 0 ), "cspf_0_auto11515511605148953639" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_dblink_cs";
    s.script_label = "m3";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 53813.4, -31339.4, -124.67 ), ( 0, 95.8, 0 ), undefined, undefined, "db_ee_m_loc_future" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_dblink_cs";
    s.script_label = "m4";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 53812.5, -31340.8, -124.21 ), ( 0, 97.54, 0 ), undefined, undefined, "db_ee_m_loc_future" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_dblink_cs";
    s.script_label = "m2";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 53813.9, -31335.1, -122.7 ), ( 0, 95.26, 0 ), undefined, undefined, "db_ee_m_loc_future" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_dblink_cs";
    s.script_label = "m3";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 76961.1, -30063.2, -120.96 ), ( 0, 108.5, 0 ), "past", "cspf_0_auto12330392192497876442", "db_ee_m_loc_past" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_dblink_cs";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 76934.1, -29997.4, -115.61 ), ( 0, 118.7, 0 ), "cspf_0_auto12330392192497876442" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_dblink_cs";
    s.script_label = "m4";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 77909, -32223.3, 86.43 ), ( 0, 137.6, 0 ), "past", "cspf_0_auto11382276242882596388", "db_ee_m_loc_past" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_dblink_cs";
    s.script_poi = "dmztest";
    fe [[ f ]]( s, us, cf, ( 77716.1, -32290.4, -113.51 ), ( 0, 323.6, 0 ), "cspf_0_auto11382276242882596388" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_mantis_quest_ee_dblink_cs
// Params 0, eflags: 0x4
// Checksum 0x5fe1e2c7, Offset: 0x78d
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_mantis_quest_ee_dblink_cs
// Params 0
// Checksum 0xc798a1a1, Offset: 0x797
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_mantis_quest_ee_dblink_cs" );
}

