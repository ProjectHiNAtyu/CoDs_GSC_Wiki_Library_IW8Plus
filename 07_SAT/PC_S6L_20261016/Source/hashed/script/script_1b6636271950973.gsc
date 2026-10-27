// script_1b6636271950973  (hash_01b6636271950973.gscc) (size: 2411 Bytes / 0x96b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xae3e09fa (2923301370)
// size ...... 2411 (0x96b)
// includes .. 3   (offset: 0x8a3)
// strings ... 9   (offset: 0x8bb)
// dev strs .. 0   (offset: 0x96b)
// exports ... 9   (offset: 0x50b)
// cseg ...... 0x16a + 0x3a1 (0x50b)
// imports ... 20  (offset: 0x673)
// animtree1 . 0   (offset: 0x96b)
// animtree2 . 0   (offset: 0x96b)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_hornet_survival_castle_cs;

// Namespace zm_sat_hornet_survival_castle_cs
// Params 0, eflags: 0x5
// Checksum 0xf09283b4, Offset: 0x188
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_hornet_survival_castle_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_hornet_survival_castle_cs
// Params 0, eflags: 0x4
// Checksum 0xf473f103, Offset: 0x1a9
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_hornet_survival_castle_cs
// Params 0, eflags: 0x4
// Checksum 0x714822ef, Offset: 0x1ba
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_hornet_survival_castle_cs
// Params 2
// Checksum 0xc1a174a6, Offset: 0x1cb
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_hornet_survival_castle_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_hornet_survival_castle_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_hornet_survival_castle_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_hornet_survival_castle_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_hornet_survival_castle_cs
// Params 3, eflags: 0x4
// Checksum 0xf2ca9620, Offset: 0x253
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_hornet_survival_castle_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_hornet_survival_castle_cs" );
}

// Namespace zm_sat_hornet_survival_castle_cs
// Params 3, eflags: 0x4
// Checksum 0x3fc9e5ee, Offset: 0x2cd
// Size: 0x21e
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_hornet_survival_castle_cs";
    fe [[ f ]]( s, us, cf, ( -33.25, -19662.4, 768 ), ( 0, 106.57, 0 ), "cspf_0_auto10304980549125902884" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_survival_castle_cs";
    fe [[ f ]]( s, us, cf, ( 16, -19683, 846.5 ), ( 0, 0, 0 ), "survival_spawn_set_zone_castle", "cspf_0_auto10304980549125902884" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_survival_castle_cs";
    fe [[ f ]]( s, us, cf, ( -108, -19677.5, 768 ), ( 0, 106.57, 0 ), "cspf_0_auto10304980549125902884" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_survival_castle_cs";
    fe [[ f ]]( s, us, cf, ( 41.77, -19649.5, 768 ), ( 0, 106.57, 0 ), "cspf_0_auto10304980549125902884" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_survival_castle_cs";
    fe [[ f ]]( s, us, cf, ( 123.52, -19631.9, 768 ), ( 0, 106.57, 0 ), "cspf_0_auto10304980549125902884" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_survival_castle_cs";
    s.name = "script_struct (rampage inducer)";
    fe [[ f ]]( s, us, cf, ( -426.76, -19891.3, 805.27 ), ( 0, 108.6, 0 ), "survival_round_accelerant_castle" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_survival_castle_cs";
    s.script_gameobjectname = "zm_rb_survival,zm_rb_r_mod_survival";
    fe [[ f ]]( s, us, cf, ( 70, -19546.5, 1574.5 ), ( 24.68, 112.06, -0 ), "intermission_camera_castle" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_hornet_survival_castle_cs
// Params 0, eflags: 0x4
// Checksum 0x93907e5e, Offset: 0x4f3
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_hornet_survival_castle_cs
// Params 0
// Checksum 0x30994b6d, Offset: 0x4fd
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_hornet_survival_castle_cs" );
}

