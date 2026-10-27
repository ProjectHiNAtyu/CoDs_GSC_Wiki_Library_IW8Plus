// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_ee_big_mouth_cs.gsc  (hash_36ea95e3b3cfc2f8.gscc) (size: 3206 Bytes / 0xc86 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x52a263ed (1386374125)
// size ...... 3206 (0xc86)
// includes .. 3   (offset: 0xb36)
// strings ... 13  (offset: 0xb4e)
// dev strs .. 0   (offset: 0xc86)
// exports ... 9   (offset: 0x79e)
// cseg ...... 0x18e + 0x610 (0x79e)
// imports ... 20  (offset: 0x906)
// animtree1 . 0   (offset: 0xc86)
// animtree2 . 0   (offset: 0xc86)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_locust_ee_big_mouth_cs;

// Namespace zm_sat_locust_ee_big_mouth_cs
// Params 0, eflags: 0x5
// Checksum 0x27662538, Offset: 0x1ac
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_locust_ee_big_mouth_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_locust_ee_big_mouth_cs
// Params 0, eflags: 0x4
// Checksum 0x5bf4c4bf, Offset: 0x1cd
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_locust_ee_big_mouth_cs
// Params 0, eflags: 0x4
// Checksum 0xdecf1753, Offset: 0x1de
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_locust_ee_big_mouth_cs
// Params 2
// Checksum 0x6e26411a, Offset: 0x1ef
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_locust_ee_big_mouth_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_locust_ee_big_mouth_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_locust_ee_big_mouth_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_locust_ee_big_mouth_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_locust_ee_big_mouth_cs
// Params 3, eflags: 0x4
// Checksum 0x5d4da39c, Offset: 0x277
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_locust_ee_big_mouth_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_locust_ee_big_mouth_cs" );
}

// Namespace zm_sat_locust_ee_big_mouth_cs
// Params 3, eflags: 0x4
// Checksum 0xeffde8fa, Offset: 0x2f1
// Size: 0x48d
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_big_mouth_cs";
    s.name = "soul_transfer_loc";
    fe [[ f ]]( s, us, cf, ( 6052.31, 7252.86, 262.21 ), ( 0, 0, 0 ), "william_transfer", "cspf_0_auto15928469626961489871", undefined, undefined, undefined, undefined, undefined, 50 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_big_mouth_cs";
    fe [[ f ]]( s, us, cf, ( 2948.03, 2840.69, 224.06 ), ( 0, 150, 0 ), "william_mount" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_big_mouth_cs";
    fe [[ f ]]( s, us, cf, ( 5863.65, 7159.91, 262.12 ), ( 0, 135, 0 ), "william_deposit", "cspf_0_auto3224102874724000113", undefined, undefined, undefined, undefined, undefined, 70 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_big_mouth_cs";
    fe [[ f ]]( s, us, cf, ( 6518.84, 2641.62, 176.15 ), ( 67, 240, 180 ), "william_loc" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_big_mouth_cs";
    s.name = "soul_transfer_loc";
    fe [[ f ]]( s, us, cf, ( 5458.22, 7278.66, 257.14 ), ( 0, 0, 0 ), "william_transfer", "cspf_0_auto5253085986840387634", undefined, undefined, undefined, undefined, undefined, 50 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_big_mouth_cs";
    s.name = "soul_transfer_loc";
    fe [[ f ]]( s, us, cf, ( 6011.57, 6411.63, 275.17 ), ( 0, 0, 0 ), "william_transfer", "cspf_0_auto11508701687153682185", undefined, undefined, undefined, undefined, undefined, 70 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_big_mouth_cs";
    s.name = "attractor_slot";
    fe [[ f ]]( s, us, cf, ( 6045.08, 6460.76, 272.31 ), ( 0, 0, 0 ), "cspf_0_auto11508701687153682185" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_big_mouth_cs";
    s.name = "attractor_slot";
    fe [[ f ]]( s, us, cf, ( 5975.77, 6434.57, 268.05 ), ( 0, 0, 0 ), "cspf_0_auto11508701687153682185" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_big_mouth_cs";
    s.name = "attractor_slot";
    fe [[ f ]]( s, us, cf, ( 6070.37, 7221.9, 262.21 ), ( 0, 0, 0 ), "cspf_0_auto15928469626961489871" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_big_mouth_cs";
    s.name = "attractor_slot";
    fe [[ f ]]( s, us, cf, ( 6019.94, 7273.22, 262.21 ), ( 0, 0, 0 ), "cspf_0_auto15928469626961489871" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_big_mouth_cs";
    s.name = "attractor_slot";
    fe [[ f ]]( s, us, cf, ( 5489.65, 7279.48, 257.14 ), ( 0, 0, 0 ), "cspf_0_auto5253085986840387634" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_big_mouth_cs";
    s.name = "attractor_slot";
    fe [[ f ]]( s, us, cf, ( 5422.48, 7280.67, 262.43 ), ( 0, 0, 0 ), "cspf_0_auto5253085986840387634" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_big_mouth_cs";
    s.name = "attractor_slot";
    fe [[ f ]]( s, us, cf, ( 5813.49, 7146.66, 234.98 ), ( 0, 0, 0 ), "cspf_0_auto3224102874724000113" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_big_mouth_cs";
    s.name = "attractor_slot";
    fe [[ f ]]( s, us, cf, ( 5846.03, 7111.79, 235.03 ), ( 0, 0, 0 ), "cspf_0_auto3224102874724000113" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_locust_ee_big_mouth_cs
// Params 0, eflags: 0x4
// Checksum 0x5a3b38f0, Offset: 0x786
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_locust_ee_big_mouth_cs
// Params 0
// Checksum 0x9f1e7ed1, Offset: 0x790
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_locust_ee_big_mouth_cs" );
}

