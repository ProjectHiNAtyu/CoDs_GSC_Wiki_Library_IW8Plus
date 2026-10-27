// script_558c9a0b63208e80  (hash_558c9a0b63208e80.gscc) (size: 2196 Bytes / 0x894 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8bd8a0cd (2346229965)
// size ...... 2196 (0x894)
// includes .. 4   (offset: 0x81c)
// strings ... 5   (offset: 0x83c)
// dev strs .. 0   (offset: 0x894)
// exports ... 12  (offset: 0x380)
// cseg ...... 0xe1 + 0x29f (0x380)
// imports ... 25  (offset: 0x560)
// animtree1 . 0   (offset: 0x894)
// animtree2 . 0   (offset: 0x894)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_city_ob_activity_flight_school_cs;

// Namespace mp_sat_avalon_city_ob_activity_flight_school_cs
// Params 0, eflags: 0x5
// Checksum 0xe218b1b5, Offset: 0xff
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_city_ob_activity_flight_school_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_city_ob_activity_flight_school_cs
// Params 0, eflags: 0x4
// Checksum 0x50f037ee, Offset: 0x128
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_city_ob_activity_flight_school_cs
// Params 0, eflags: 0x4
// Checksum 0xd5cbe402, Offset: 0x139
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_city_ob_activity_flight_school_cs
// Params 2
// Checksum 0x71111244, Offset: 0x14a
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_city_ob_activity_flight_school_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_city_ob_activity_flight_school_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_city_ob_activity_flight_school_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_city_ob_activity_flight_school_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_city_ob_activity_flight_school_cs
// Params 3, eflags: 0x4
// Checksum 0x564950cd, Offset: 0x1de
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_city_ob_activity_flight_school_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_city_ob_activity_flight_school_cs" );
}

// Namespace mp_sat_avalon_city_ob_activity_flight_school_cs
// Params 3, eflags: 0x4
// Checksum 0x8726e65e, Offset: 0x258
// Size: 0x44
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_city_ob_activity_flight_school_cs
// Params 0, eflags: 0x4
// Checksum 0x6695a609, Offset: 0x2a4
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_city_ob_activity_flight_school_cs
// Params 0
// Checksum 0x941a8d80, Offset: 0x2ae
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_city_ob_activity_flight_school_cs" );
}

// Namespace mp_sat_avalon_city_ob_activity_flight_school_cs
// Params 0
// Checksum 0x5e8d880e, Offset: 0x2c4
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_FLIGHT_SCHOOL";
    activityinfostruct.scriptbundle = "sat_ob_activity_flight_school";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_city_ob_activity_flight_school_cs
// Params 4
// Checksum 0xe78e2fbe, Offset: 0x333
// Size: 0x33
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_city_ob_activity_flight_school_cs" )
{
    
}

// Namespace mp_sat_avalon_city_ob_activity_flight_school_cs
// Params 0
// Checksum 0x5ef1703b, Offset: 0x36e
// Size: 0x11
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    return activityinstances;
}

