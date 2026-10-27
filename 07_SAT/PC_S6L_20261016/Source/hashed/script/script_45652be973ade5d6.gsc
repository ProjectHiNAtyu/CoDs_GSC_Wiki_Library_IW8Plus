// script_45652be973ade5d6  (hash_45652be973ade5d6.gscc) (size: 4281 Bytes / 0x10b9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x529ea1a1 (1386127777)
// size ...... 4281 (0x10b9)
// includes .. 3   (offset: 0xed9)
// strings ... 8   (offset: 0xef1)
// dev strs .. 0   (offset: 0x10b9)
// exports ... 9   (offset: 0xb41)
// cseg ...... 0xe6 + 0xa5b (0xb41)
// imports ... 20  (offset: 0xca9)
// animtree1 . 0   (offset: 0x10b9)
// animtree2 . 0   (offset: 0x10b9)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_quad_03_ob_infil_cs;

// Namespace mp_sat_avalon_quad_03_ob_infil_cs
// Params 0, eflags: 0x5
// Checksum 0x40c6380b, Offset: 0x104
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_03_ob_infil_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_03_ob_infil_cs
// Params 0, eflags: 0x4
// Checksum 0x31aa149e, Offset: 0x125
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_03_ob_infil_cs
// Params 0, eflags: 0x4
// Checksum 0xb491c772, Offset: 0x136
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_quad_03_ob_infil_cs
// Params 2
// Checksum 0x478913b, Offset: 0x147
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_03_ob_infil_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_quad_03_ob_infil_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_03_ob_infil_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_03_ob_infil_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_03_ob_infil_cs
// Params 3, eflags: 0x4
// Checksum 0x371373bd, Offset: 0x1cf
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_03_ob_infil_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_03_ob_infil_cs" );
}

// Namespace mp_sat_avalon_quad_03_ob_infil_cs
// Params 3, eflags: 0x4
// Checksum 0x37f56734, Offset: 0x249
// Size: 0x8d8
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_infil_cs";
    s.name = "infil_point";
    s.tier = "4";
    fe [[ f ]]( s, us, cf, ( -58675, -578, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_infil_cs";
    s.name = "infil_point";
    s.tier = "4";
    fe [[ f ]]( s, us, cf, ( -56102, -1135, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_infil_cs";
    s.name = "infil_point";
    s.tier = "4";
    fe [[ f ]]( s, us, cf, ( -53456, -926, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_infil_cs";
    s.name = "infil_point";
    s.tier = "4";
    fe [[ f ]]( s, us, cf, ( -55124, -2638, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_infil_cs";
    s.name = "infil_point";
    s.tier = "4";
    fe [[ f ]]( s, us, cf, ( -57342, -3532, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_infil_cs";
    s.name = "infil_point";
    s.tier = "4";
    fe [[ f ]]( s, us, cf, ( -46701, -11704, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_infil_cs";
    s.name = "infil_point";
    s.tier = "4";
    fe [[ f ]]( s, us, cf, ( -44118, -13924, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_infil_cs";
    s.name = "infil_point";
    s.tier = "4";
    fe [[ f ]]( s, us, cf, ( -48650, -17364, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_infil_cs";
    s.name = "infil_point";
    s.tier = "4";
    fe [[ f ]]( s, us, cf, ( -43963, -20015, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_infil_cs";
    s.name = "infil_point";
    s.tier = "4";
    fe [[ f ]]( s, us, cf, ( -48778, -24223, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_infil_cs";
    s.name = "infil_point";
    s.tier = "4";
    fe [[ f ]]( s, us, cf, ( -49102, -28883, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_infil_cs";
    s.name = "infil_point";
    s.tier = "4";
    fe [[ f ]]( s, us, cf, ( -48172, -31710, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_infil_cs";
    s.name = "infil_point";
    s.tier = "4";
    fe [[ f ]]( s, us, cf, ( -40622, -26726, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -43289, -37447, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -41430, -38365, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -40388, -40505, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -38792, -43184, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -36782, -43776, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -38654, -47013, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -35226, -46919, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_infil_cs";
    s.name = "infil_look_at_4";
    s.tier = "4";
    fe [[ f ]]( s, us, cf, ( -31950, -31360, 0 ), ( 0, 0, 0 ), "ob_infil_lookat" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -35923, -40338, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -37549, -42520, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -35957, -42075, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_03_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( -36495, -38138, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_03_ob_infil_cs
// Params 0, eflags: 0x4
// Checksum 0x81097476, Offset: 0xb29
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_03_ob_infil_cs
// Params 0
// Checksum 0xf540aef0, Offset: 0xb33
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_03_ob_infil_cs" );
}

