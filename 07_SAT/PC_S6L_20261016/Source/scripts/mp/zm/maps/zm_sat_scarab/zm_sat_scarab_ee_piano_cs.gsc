// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_ee_piano_cs.gsc  (hash_56bc49d24c445545.gscc) (size: 1953 Bytes / 0x7a1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x98900936 (2559576374)
// size ...... 1953 (0x7a1)
// includes .. 3   (offset: 0x711)
// strings ... 7   (offset: 0x729)
// dev strs .. 0   (offset: 0x7a1)
// exports ... 9   (offset: 0x379)
// cseg ...... 0xed + 0x28c (0x379)
// imports ... 20  (offset: 0x4e1)
// animtree1 . 0   (offset: 0x7a1)
// animtree2 . 0   (offset: 0x7a1)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_scarab_ee_piano_cs;

// Namespace zm_sat_scarab_ee_piano_cs
// Params 0, eflags: 0x5
// Checksum 0x3be075f2, Offset: 0x10b
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_scarab_ee_piano_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_scarab_ee_piano_cs
// Params 0, eflags: 0x4
// Checksum 0x8b0949b8, Offset: 0x12c
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_scarab_ee_piano_cs
// Params 0, eflags: 0x4
// Checksum 0xe329a54, Offset: 0x13d
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_scarab_ee_piano_cs
// Params 2
// Checksum 0xbedbcc1d, Offset: 0x14e
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_scarab_ee_piano_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_scarab_ee_piano_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_scarab_ee_piano_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_scarab_ee_piano_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_scarab_ee_piano_cs
// Params 3, eflags: 0x4
// Checksum 0x8db02e9b, Offset: 0x1d6
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_scarab_ee_piano_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_scarab_ee_piano_cs" );
}

// Namespace zm_sat_scarab_ee_piano_cs
// Params 3, eflags: 0x4
// Checksum 0x3ad6b16f, Offset: 0x250
// Size: 0x109
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_piano_cs";
    fe [[ f ]]( s, us, cf, ( 240.95, -3988.74, 1769.63 ), ( 352.8, 232.99, 0.13 ), "ee_piano_rewards" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_piano_cs";
    fe [[ f ]]( s, us, cf, ( 245, -4030, 1773 ), ( 5.24, 99.91, 5.29 ), "piano_sbl_pos", undefined, "sat_zm_sat_scriptable_mantis_piano" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_ee_piano_cs";
    fe [[ f ]]( s, us, cf, ( 242.81, -4016.02, 1804.39 ), ( 0.26, 101.9, 1.85 ), "ee_piano_pos" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_scarab_ee_piano_cs
// Params 0, eflags: 0x4
// Checksum 0x56971ffd, Offset: 0x361
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_scarab_ee_piano_cs
// Params 0
// Checksum 0x4fe3f3d6, Offset: 0x36b
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_scarab_ee_piano_cs" );
}

