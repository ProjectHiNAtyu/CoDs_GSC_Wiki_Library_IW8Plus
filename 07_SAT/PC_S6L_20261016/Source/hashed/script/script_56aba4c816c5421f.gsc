// script_56aba4c816c5421f  (hash_56aba4c816c5421f.gscc) (size: 2195 Bytes / 0x893 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb45d4feb (3026014187)
// size ...... 2195 (0x893)
// includes .. 4   (offset: 0x81b)
// strings ... 5   (offset: 0x83b)
// dev strs .. 0   (offset: 0x893)
// exports ... 12  (offset: 0x37f)
// cseg ...... 0xe0 + 0x29f (0x37f)
// imports ... 25  (offset: 0x55f)
// animtree1 . 0   (offset: 0x893)
// animtree2 . 0   (offset: 0x893)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_city_ob_heli_takedown_cs;

// Namespace mp_sat_avalon_city_ob_heli_takedown_cs
// Params 0, eflags: 0x5
// Checksum 0xb3f2bd74, Offset: 0xfe
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_city_ob_heli_takedown_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_city_ob_heli_takedown_cs
// Params 0, eflags: 0x4
// Checksum 0x523f752, Offset: 0x127
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_city_ob_heli_takedown_cs
// Params 0, eflags: 0x4
// Checksum 0x801824be, Offset: 0x138
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_city_ob_heli_takedown_cs
// Params 2
// Checksum 0x4f07cb47, Offset: 0x149
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_city_ob_heli_takedown_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_city_ob_heli_takedown_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_city_ob_heli_takedown_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_city_ob_heli_takedown_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_city_ob_heli_takedown_cs
// Params 3, eflags: 0x4
// Checksum 0x39a9071, Offset: 0x1dd
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_city_ob_heli_takedown_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_city_ob_heli_takedown_cs" );
}

// Namespace mp_sat_avalon_city_ob_heli_takedown_cs
// Params 3, eflags: 0x4
// Checksum 0xd2f526e2, Offset: 0x257
// Size: 0x44
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_city_ob_heli_takedown_cs
// Params 0, eflags: 0x4
// Checksum 0x58837f0a, Offset: 0x2a3
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_city_ob_heli_takedown_cs
// Params 0
// Checksum 0xc1c94d3c, Offset: 0x2ad
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_city_ob_heli_takedown_cs" );
}

// Namespace mp_sat_avalon_city_ob_heli_takedown_cs
// Params 0
// Checksum 0x460afac2, Offset: 0x2c3
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_HELI_TAKEDOWN";
    activityinfostruct.scriptbundle = "sat_activitydef_activity_helitakedown";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_city_ob_heli_takedown_cs
// Params 4
// Checksum 0xb25def02, Offset: 0x332
// Size: 0x33
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_city_ob_heli_takedown_cs" )
{
    
}

// Namespace mp_sat_avalon_city_ob_heli_takedown_cs
// Params 0
// Checksum 0x60e7a938, Offset: 0x36d
// Size: 0x11
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    return activityinstances;
}

