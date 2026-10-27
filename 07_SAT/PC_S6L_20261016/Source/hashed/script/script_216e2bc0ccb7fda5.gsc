// script_216e2bc0ccb7fda5  (hash_216e2bc0ccb7fda5.gscc) (size: 2081 Bytes / 0x821 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xecc20ffb (3972141051)
// size ...... 2081 (0x821)
// includes .. 4   (offset: 0x7c1)
// strings ... 3   (offset: 0x7e1)
// dev strs .. 0   (offset: 0x821)
// exports ... 12  (offset: 0x325)
// cseg ...... 0xa8 + 0x27d (0x325)
// imports ... 25  (offset: 0x505)
// animtree1 . 0   (offset: 0x821)
// animtree2 . 0   (offset: 0x821)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q1_ob_contract_cancer_confront_cs;

// Namespace mp_sat_avalon_q1_ob_contract_cancer_confront_cs
// Params 0, eflags: 0x5
// Checksum 0x2e0b5806, Offset: 0xc6
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q1_ob_contract_cancer_confront_cs", #"activity_common", &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q1_ob_contract_cancer_confront_cs
// Params 0, eflags: 0x4
// Checksum 0x2556ad2c, Offset: 0xef
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q1_ob_contract_cancer_confront_cs
// Params 0, eflags: 0x4
// Checksum 0xa06d7ec0, Offset: 0x100
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q1_ob_contract_cancer_confront_cs
// Params 2
// Checksum 0xf845359d, Offset: 0x111
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q1_ob_contract_cancer_confront_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q1_ob_contract_cancer_confront_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q1_ob_contract_cancer_confront_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q1_ob_contract_cancer_confront_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q1_ob_contract_cancer_confront_cs
// Params 3, eflags: 0x4
// Checksum 0x23efca0f, Offset: 0x1a5
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q1_ob_contract_cancer_confront_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q1_ob_contract_cancer_confront_cs" );
}

// Namespace mp_sat_avalon_q1_ob_contract_cancer_confront_cs
// Params 3, eflags: 0x4
// Checksum 0xf2807c9c, Offset: 0x21f
// Size: 0x44
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q1_ob_contract_cancer_confront_cs
// Params 0, eflags: 0x4
// Checksum 0xefc181d0, Offset: 0x26b
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q1_ob_contract_cancer_confront_cs
// Params 0
// Checksum 0xe1bc1742, Offset: 0x275
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q1_ob_contract_cancer_confront_cs" );
}

// Namespace mp_sat_avalon_q1_ob_contract_cancer_confront_cs
// Params 0
// Checksum 0x35991de3, Offset: 0x28b
// Size: 0x44
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_sat_avalon_q1_ob_contract_cancer_confront_cs
// Params 4
// Checksum 0x9228b57c, Offset: 0x2d8
// Size: 0x33
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_sat_avalon_q1_ob_contract_cancer_confront_cs" )
{
    
}

// Namespace mp_sat_avalon_q1_ob_contract_cancer_confront_cs
// Params 0
// Checksum 0xd7a557e2, Offset: 0x313
// Size: 0x11
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    return activityinstances;
}

