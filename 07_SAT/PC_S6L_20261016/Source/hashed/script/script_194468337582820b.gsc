// script_194468337582820b  (hash_194468337582820b.gscc) (size: 2140 Bytes / 0x85c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x82408c1f (2185268255)
// size ...... 2140 (0x85c)
// includes .. 4   (offset: 0x7e8)
// strings ... 5   (offset: 0x808)
// dev strs .. 0   (offset: 0x85c)
// exports ... 12  (offset: 0x368)
// cseg ...... 0xd9 + 0x28f (0x368)
// imports ... 24  (offset: 0x548)
// animtree1 . 0   (offset: 0x85c)
// animtree2 . 0   (offset: 0x85c)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_city_ob_merc_camp_parent_cs;

// Namespace mp_sat_avalon_city_ob_merc_camp_parent_cs
// Params 0, eflags: 0x5
// Checksum 0xfb926049, Offset: 0xf7
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_city_ob_merc_camp_parent_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_city_ob_merc_camp_parent_cs
// Params 0, eflags: 0x4
// Checksum 0x8c762325, Offset: 0x120
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_city_ob_merc_camp_parent_cs
// Params 0, eflags: 0x4
// Checksum 0x6eafff16, Offset: 0x131
// Size: 0x15
function private structs_init()
{
    main();
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
}

// Namespace mp_sat_avalon_city_ob_merc_camp_parent_cs
// Params 2
// Checksum 0x6ebb79a3, Offset: 0x14e
// Size: 0x70
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_city_ob_merc_camp_parent_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_city_ob_merc_camp_parent_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_city_ob_merc_camp_parent_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_city_ob_merc_camp_parent_cs
// Params 3, eflags: 0x4
// Checksum 0x8acf4406, Offset: 0x1c6
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_city_ob_merc_camp_parent_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_city_ob_merc_camp_parent_cs" );
}

// Namespace mp_sat_avalon_city_ob_merc_camp_parent_cs
// Params 3, eflags: 0x4
// Checksum 0x5ba0f295, Offset: 0x240
// Size: 0x44
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_city_ob_merc_camp_parent_cs
// Params 0, eflags: 0x4
// Checksum 0xc9c21d12, Offset: 0x28c
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_city_ob_merc_camp_parent_cs
// Params 0
// Checksum 0x489c994b, Offset: 0x296
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_city_ob_merc_camp_parent_cs" );
}

// Namespace mp_sat_avalon_city_ob_merc_camp_parent_cs
// Params 0
// Checksum 0xbe2038f3, Offset: 0x2ac
// Size: 0x66
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.name = "REV_OB_MERC_CAMP";
    activityinfostruct.scriptbundle = "sat_activitydefinition_merccamp";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_city_ob_merc_camp_parent_cs
// Params 4
// Checksum 0x3b083b75, Offset: 0x31b
// Size: 0x33
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_city_ob_merc_camp_parent_cs" )
{
    
}

// Namespace mp_sat_avalon_city_ob_merc_camp_parent_cs
// Params 0
// Checksum 0xf1a6cb20, Offset: 0x356
// Size: 0x11
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    return activityinstances;
}

