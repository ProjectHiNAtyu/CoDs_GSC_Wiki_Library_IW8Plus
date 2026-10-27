// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_vdm_ee_cs.gsc  (hash_46e658c0ee0e0639.gscc) (size: 2395 Bytes / 0x95b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5ca2ad25 (1554165029)
// size ...... 2395 (0x95b)
// includes .. 3   (offset: 0x88f)
// strings ... 9   (offset: 0x8a7)
// dev strs .. 0   (offset: 0x95b)
// exports ... 9   (offset: 0x4f7)
// cseg ...... 0x10e + 0x3e9 (0x4f7)
// imports ... 20  (offset: 0x65f)
// animtree1 . 0   (offset: 0x95b)
// animtree2 . 0   (offset: 0x95b)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_firefly_script_vdm_ee_cs;

// Namespace zm_sat_firefly_script_vdm_ee_cs
// Params 0, eflags: 0x5
// Checksum 0xbbc3b9ce, Offset: 0x12c
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_script_vdm_ee_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_firefly_script_vdm_ee_cs
// Params 0, eflags: 0x4
// Checksum 0x5fa069ab, Offset: 0x14d
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_firefly_script_vdm_ee_cs
// Params 0, eflags: 0x4
// Checksum 0xda9bba47, Offset: 0x15e
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_firefly_script_vdm_ee_cs
// Params 2
// Checksum 0x6a72ec0e, Offset: 0x16f
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_firefly_script_vdm_ee_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_firefly_script_vdm_ee_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_firefly_script_vdm_ee_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_firefly_script_vdm_ee_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_firefly_script_vdm_ee_cs
// Params 3, eflags: 0x4
// Checksum 0x59190e88, Offset: 0x1f7
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_firefly_script_vdm_ee_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_firefly_script_vdm_ee_cs" );
}

// Namespace zm_sat_firefly_script_vdm_ee_cs
// Params 3, eflags: 0x4
// Checksum 0xbdca8552, Offset: 0x271
// Size: 0x266
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_vdm_ee_cs";
    s.script_label = "vdm_gas";
    fe [[ f ]]( s, us, cf, ( -13277.6, 4414.06, 422.89 ), ( 0, 47.82, 0 ), undefined, undefined, "vdm_ee_machine" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_vdm_ee_cs";
    s.script_label = "vdm_tower";
    fe [[ f ]]( s, us, cf, ( 25305.5, 667.23, 439.77 ), ( 0, 270.24, 0 ), undefined, undefined, "vdm_ee_machine" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_vdm_ee_cs";
    fe [[ f ]]( s, us, cf, ( -13269.6, 4416.96, 435.14 ), ( 0, 48.3, 0 ), undefined, undefined, "vdm_ee_drop_source" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_vdm_ee_cs";
    fe [[ f ]]( s, us, cf, ( 25301.6, 659.85, 453.34 ), ( 0, 270, 0 ), undefined, undefined, "vdm_ee_drop_source" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_vdm_ee_cs";
    fe [[ f ]]( s, us, cf, ( 25306.1, 617.62, 444.06 ), ( 0, 270, 0 ), undefined, undefined, "vdm_ee_drop_destination" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_vdm_ee_cs";
    fe [[ f ]]( s, us, cf, ( -13246.7, 4448.93, 422.42 ), ( 0, 48.3, 0 ), undefined, undefined, "vdm_ee_drop_destination" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_vdm_ee_cs";
    fe [[ f ]]( s, us, cf, ( -13254.4, 4429.09, 445.95 ), ( 0, 47.9, 0 ), undefined, undefined, "vdm_ee_food_drop_source" );
    s = {};
    s.script_cs_flag = "zm_sat_firefly_script_vdm_ee_cs";
    fe [[ f ]]( s, us, cf, ( 25294.9, 640.7, 464.11 ), ( 0, 270.4, 0 ), undefined, undefined, "vdm_ee_food_drop_source" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_firefly_script_vdm_ee_cs
// Params 0, eflags: 0x4
// Checksum 0x456a48be, Offset: 0x4df
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_firefly_script_vdm_ee_cs
// Params 0
// Checksum 0x9b4ad3c5, Offset: 0x4e9
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_firefly_script_vdm_ee_cs" );
}

