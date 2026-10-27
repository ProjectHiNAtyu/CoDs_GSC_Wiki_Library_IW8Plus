// script_47c886f5c75804ca  (hash_47c886f5c75804ca.gscc) (size: 1625 Bytes / 0x659 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7c1bc3cf (2082194383)
// size ...... 1625 (0x659)
// includes .. 3   (offset: 0x605)
// strings ... 3   (offset: 0x61d)
// dev strs .. 0   (offset: 0x659)
// exports ... 9   (offset: 0x26d)
// cseg ...... 0xa6 + 0x1c7 (0x26d)
// imports ... 20  (offset: 0x3d5)
// animtree1 . 0   (offset: 0x659)
// animtree2 . 0   (offset: 0x659)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q1_ob_contract_cancer_locate_cs;

// Namespace mp_sat_avalon_q1_ob_contract_cancer_locate_cs
// Params 0, eflags: 0x5
// Checksum 0xd507aa15, Offset: 0xc4
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q1_ob_contract_cancer_locate_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q1_ob_contract_cancer_locate_cs
// Params 0, eflags: 0x4
// Checksum 0xf642b6c1, Offset: 0xe5
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q1_ob_contract_cancer_locate_cs
// Params 0, eflags: 0x4
// Checksum 0x7379652d, Offset: 0xf6
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q1_ob_contract_cancer_locate_cs
// Params 2
// Checksum 0xc3903364, Offset: 0x107
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q1_ob_contract_cancer_locate_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q1_ob_contract_cancer_locate_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q1_ob_contract_cancer_locate_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q1_ob_contract_cancer_locate_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q1_ob_contract_cancer_locate_cs
// Params 3, eflags: 0x4
// Checksum 0xf0fbd1e2, Offset: 0x18f
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q1_ob_contract_cancer_locate_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q1_ob_contract_cancer_locate_cs" );
}

// Namespace mp_sat_avalon_q1_ob_contract_cancer_locate_cs
// Params 3, eflags: 0x4
// Checksum 0x21946771, Offset: 0x209
// Size: 0x44
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q1_ob_contract_cancer_locate_cs
// Params 0, eflags: 0x4
// Checksum 0x3c9a7acf, Offset: 0x255
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q1_ob_contract_cancer_locate_cs
// Params 0
// Checksum 0x32a80caf, Offset: 0x25f
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q1_ob_contract_cancer_locate_cs" );
}

