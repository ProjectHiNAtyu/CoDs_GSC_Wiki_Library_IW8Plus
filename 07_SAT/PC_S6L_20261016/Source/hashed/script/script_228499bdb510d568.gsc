// script_228499bdb510d568  (hash_228499bdb510d568.gscc) (size: 5402 Bytes / 0x151a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd79feb4d (3617581901)
// size ...... 5402 (0x151a)
// includes .. 3   (offset: 0x12ae)
// strings ... 10  (offset: 0x12c6)
// dev strs .. 0   (offset: 0x151a)
// exports ... 9   (offset: 0xf16)
// cseg ...... 0x11a + 0xdfc (0xf16)
// imports ... 20  (offset: 0x107e)
// animtree1 . 0   (offset: 0x151a)
// animtree2 . 0   (offset: 0x151a)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_quad_04_ob_infil_cs;

// Namespace mp_sat_avalon_quad_04_ob_infil_cs
// Params 0, eflags: 0x5
// Checksum 0xa58f17f3, Offset: 0x138
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_04_ob_infil_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_04_ob_infil_cs
// Params 0, eflags: 0x4
// Checksum 0xb70c7733, Offset: 0x159
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_04_ob_infil_cs
// Params 0, eflags: 0x4
// Checksum 0x3237a4df, Offset: 0x16a
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_quad_04_ob_infil_cs
// Params 2
// Checksum 0x82def296, Offset: 0x17b
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_04_ob_infil_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_quad_04_ob_infil_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_04_ob_infil_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_04_ob_infil_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_04_ob_infil_cs
// Params 3, eflags: 0x4
// Checksum 0xb1b51010, Offset: 0x203
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_04_ob_infil_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_04_ob_infil_cs" );
}

// Namespace mp_sat_avalon_quad_04_ob_infil_cs
// Params 3, eflags: 0x4
// Checksum 0x7c8c162d, Offset: 0x27d
// Size: 0xc79
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point_aries";
    fe [[ f ]]( s, us, cf, ( 33508, -42204, 1088 ), ( 360, 0, -0 ), "ob_infil_point_aries_launch", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point_aries";
    fe [[ f ]]( s, us, cf, ( 31472, -41860, 1087.97 ), ( 0, 0, 0 ), "ob_infil_point_aries_launch", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point_aries";
    fe [[ f ]]( s, us, cf, ( 32332, -43020, 1088 ), ( 0, 0, -0 ), "ob_infil_point_aries_launch", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 9638, -50883.1, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 9454, -48234.1, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 13495, -43784.1, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 1944, -43209.1, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 17618, -41303.1, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_look_at_1";
    s.tier = "1";
    fe [[ f ]]( s, us, cf, ( 44939, 1359, 0 ), ( 0, 0, 0 ), "ob_infil_lookat" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 59781, -37108, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 20350, -53922, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 60774, -10075, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 61881, -12137, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 57101, -52127, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 55040, -55386, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 62958, -14943, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 22879, -55416, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 50426, -53441, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 52839, -51567, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 60409, -7189, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 62940, -17911, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 62835, -21592, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 24638, -56920, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 60361, -4417, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 61552, -25494, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 62441, -29388, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 60385, -34996, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 57783, -2818, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 61333, -32679, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 60235, -41546, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 61283, -43222, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 58946, -46478, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 55989, -49949, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 52708, -52997, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 50915, -56809, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 48227, -59601, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 43358, -59227, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_look_at_1";
    s.tier = "1";
    fe [[ f ]]( s, us, cf, ( 44573, -15945, 0 ), ( 0, 0, 0 ), "ob_infil_lookat" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_04_ob_infil_cs";
    s.name = "infil_look_at_1";
    s.tier = "1";
    fe [[ f ]]( s, us, cf, ( 37890, -29267, 0 ), ( 0, 0, 0 ), "ob_infil_lookat" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_04_ob_infil_cs
// Params 0, eflags: 0x4
// Checksum 0x7adc1183, Offset: 0xefe
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_04_ob_infil_cs
// Params 0
// Checksum 0x73e6cd5d, Offset: 0xf08
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_04_ob_infil_cs" );
}

