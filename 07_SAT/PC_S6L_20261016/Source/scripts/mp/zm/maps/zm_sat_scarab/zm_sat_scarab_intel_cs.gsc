// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_intel_cs.gsc  (hash_10743e3cbf52a73f.gscc) (size: 2928 Bytes / 0xb70 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1f57f63a (525858362)
// size ...... 2928 (0xb70)
// includes .. 3   (offset: 0xa4c)
// strings ... 15  (offset: 0xa64)
// dev strs .. 0   (offset: 0xb70)
// exports ... 9   (offset: 0x6b4)
// cseg ...... 0x1e5 + 0x4cf (0x6b4)
// imports ... 20  (offset: 0x81c)
// animtree1 . 0   (offset: 0xb70)
// animtree2 . 0   (offset: 0xb70)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_scarab_intel_cs;

// Namespace zm_sat_scarab_intel_cs
// Params 0, eflags: 0x5
// Checksum 0x3bfcbce4, Offset: 0x203
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_scarab_intel_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_scarab_intel_cs
// Params 0, eflags: 0x4
// Checksum 0xb7ff4ff4, Offset: 0x224
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_scarab_intel_cs
// Params 0, eflags: 0x4
// Checksum 0x32c49c18, Offset: 0x235
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_scarab_intel_cs
// Params 2
// Checksum 0x822dca51, Offset: 0x246
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_scarab_intel_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_scarab_intel_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_scarab_intel_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_scarab_intel_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_scarab_intel_cs
// Params 3, eflags: 0x4
// Checksum 0xb14628d7, Offset: 0x2ce
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_scarab_intel_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_scarab_intel_cs" );
}

// Namespace zm_sat_scarab_intel_cs
// Params 3, eflags: 0x4
// Checksum 0xdb00cf8e, Offset: 0x348
// Size: 0x34c
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_scarab_intel_cs";
    s.script_string = "zmintel_sat_scarab_document_2";
    fe [[ f ]]( s, us, cf, ( 832.75, 3457, 1862.25 ), ( 0, 131.93, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_intel_cs";
    s.script_string = "zmintel_sat_scarab_document_1";
    fe [[ f ]]( s, us, cf, ( -4785.75, 852, 1957 ), ( 0, 195.64, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_intel_cs";
    s.script_string = "zmintel_sat_scarab_document_3";
    fe [[ f ]]( s, us, cf, ( 2891.75, 910.25, 1923 ), ( 0, 304.31, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_intel_cs";
    s.script_string = "zmintel_sat_scarab_audiolog_1";
    fe [[ f ]]( s, us, cf, ( -6667.25, -2215, 1530.75 ), ( 0, 325.35, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_intel_cs";
    s.name = "script_struct_zombie_intel";
    s.script_string = "zmintel_sat_scarab_audiolog_2";
    fe [[ f ]]( s, us, cf, ( -2862, 2745.5, 1552.25 ), ( 0, 41.74, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_intel_cs";
    s.script_string = "zmintel_sat_scarab_audiolog_5";
    fe [[ f ]]( s, us, cf, ( 2412, 2309.5, 1967 ), ( 0, 190, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_intel_cs";
    s.script_string = "zmintel_sat_scarab_audiolog_4";
    fe [[ f ]]( s, us, cf, ( 3127.25, -1171.25, 1509.5 ), ( 0, 22.45, 0 ), undefined, undefined, "zombie_intel" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_intel_cs";
    fe [[ f ]]( s, us, cf, ( 482.5, -3807.5, 1995 ), ( 356.06, 281.38, 0 ), "bed_jump_trigger", undefined, undefined, undefined, undefined, undefined, undefined, 35 );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_intel_cs";
    fe [[ f ]]( s, us, cf, ( 449.5, -3809.5, 1882.5 ), ( 356.06, 281.38, 0 ), "scarab_document_6_landing" );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_intel_cs";
    fe [[ f ]]( s, us, cf, ( 243.75, -4022.25, 1817.75 ), ( 83.88, 179.85, 80.87 ), "scarab_doc_5" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_scarab_intel_cs
// Params 0, eflags: 0x4
// Checksum 0x4f063d55, Offset: 0x69c
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_scarab_intel_cs
// Params 0
// Checksum 0x7315f59a, Offset: 0x6a6
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_scarab_intel_cs" );
}

