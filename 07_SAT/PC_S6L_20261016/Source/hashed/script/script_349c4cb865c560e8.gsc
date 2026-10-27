// script_349c4cb865c560e8  (hash_349c4cb865c560e8.gscc) (size: 7574 Bytes / 0x1d96 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6f97b5ef (1872213487)
// size ...... 7574 (0x1d96)
// includes .. 3   (offset: 0x19ca)
// strings ... 22  (offset: 0x19e2)
// dev strs .. 0   (offset: 0x1d96)
// exports ... 9   (offset: 0x1632)
// cseg ...... 0x1f3 + 0x143f (0x1632)
// imports ... 20  (offset: 0x179a)
// animtree1 . 0   (offset: 0x1d96)
// animtree2 . 0   (offset: 0x1d96)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_quad_02_ob_infil_cs;

// Namespace mp_sat_avalon_quad_02_ob_infil_cs
// Params 0, eflags: 0x5
// Checksum 0x78202652, Offset: 0x211
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_quad_02_ob_infil_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_quad_02_ob_infil_cs
// Params 0, eflags: 0x4
// Checksum 0x661b063c, Offset: 0x232
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_quad_02_ob_infil_cs
// Params 0, eflags: 0x4
// Checksum 0xe320d5d0, Offset: 0x243
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_quad_02_ob_infil_cs
// Params 2
// Checksum 0x53c98399, Offset: 0x254
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_quad_02_ob_infil_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_quad_02_ob_infil_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_quad_02_ob_infil_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_quad_02_ob_infil_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_quad_02_ob_infil_cs
// Params 3, eflags: 0x4
// Checksum 0x60a2611f, Offset: 0x2dc
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_quad_02_ob_infil_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_quad_02_ob_infil_cs" );
}

// Namespace mp_sat_avalon_quad_02_ob_infil_cs
// Params 3, eflags: 0x4
// Checksum 0xe55286d, Offset: 0x356
// Size: 0x12bc
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point_aqua";
    fe [[ f ]]( s, us, cf, ( 16378.8, 23961.4, 632.87 ), ( 0, 340.01, 0 ), "ob_infil_point_aqua_intro", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point_pisces";
    s.script_priority = "2";
    fe [[ f ]]( s, us, cf, ( 42868.5, 2111, 1277.09 ), ( 355.11, 107.82, 1.96 ), "ob_infil_point_pisces_intro", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point_pisces";
    s.script_priority = "3";
    fe [[ f ]]( s, us, cf, ( 37778, 3590, 1013.5 ), ( 0, 70, 0 ), "ob_infil_point_pisces_intro", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point_pisces";
    s.script_priority = "5";
    fe [[ f ]]( s, us, cf, ( 49628, 10135, 1188.04 ), ( 0, 176, 0 ), "ob_infil_point_pisces_intro", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point_pisces";
    s.script_priority = "4";
    fe [[ f ]]( s, us, cf, ( 46210, 2349, 1293.97 ), ( 0, 122, 0 ), "ob_infil_point_pisces_intro", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point_pisces_1";
    s.script_priority = "1";
    fe [[ f ]]( s, us, cf, ( 51274.5, 7118.5, 1873.13 ), ( 0, 166.86, 0 ), "ob_infil_point_pisces_intro", "cspf_0_auto3425668870414121872", undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point_cancer";
    s.script_priority = "1";
    fe [[ f ]]( s, us, cf, ( 12270.5, 15890, 15.62 ), ( 0, 52.65, 0 ), "ob_infil_point_cancer_intro", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point_pisces";
    s.script_priority = "6";
    fe [[ f ]]( s, us, cf, ( 45092, 1967, 1412.47 ), ( 0, 106, 0 ), "ob_infil_point_pisces_intro", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point_cancer";
    s.script_priority = "3";
    fe [[ f ]]( s, us, cf, ( 13923, 16135, 19.9 ), ( 0, 107.66, 0 ), "ob_infil_point_cancer_intro", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point_cancer";
    s.script_priority = "4";
    fe [[ f ]]( s, us, cf, ( 12743.5, 15835.5, 15.62 ), ( 0, 63.12, 0 ), "ob_infil_point_cancer_intro", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point_cancer";
    s.script_priority = "2";
    fe [[ f ]]( s, us, cf, ( 10116.5, 16575, 12.87 ), ( 0, 55.34, 0 ), "ob_infil_point_cancer_intro", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_look_at_2";
    s.tier = "2";
    fe [[ f ]]( s, us, cf, ( 35497, 29860, 0 ), ( 0, 0, 0 ), "ob_infil_lookat" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 60636.6, 10572, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 60530.6, 7052.95, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 61804.6, 13219, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 60278.6, 3566.95, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 60434.6, -348.05, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 60278.6, 5233.95, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 60800.6, 8638.95, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 61457.6, 2153.95, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 61405.6, 14610, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 60246.6, 12551, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 62324.6, 20160, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 60351.6, 25306, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 60284.6, 22941, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 61306.6, 27671, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 58361.6, 30567, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 56732.6, 32769, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 52716.6, 35589, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 51368.6, 38437, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 47691.6, 40898, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 46192.6, 42660, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 44848.6, 43980, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 41524.6, 46164, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 40473.6, 47945, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 38942.6, 49452, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 37243.6, 51740, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 37516.6, 55557, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 35228.6, 54583, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 32992.6, 54712, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 28861.6, 55346, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 25774.6, 57901, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 22512.6, 58147, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 18887.6, 57936, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 14434.6, 57975, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 10740.6, 57810, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 7481.6, 58139, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point";
    fe [[ f ]]( s, us, cf, ( 4185.6, 58217, 5000 ), ( 0, 0, 0 ), "ob_infil_point" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point_pisces_1_player";
    s.script_priority = "1";
    fe [[ f ]]( s, us, cf, ( 51274.5, 7118.5, 1873.13 ), ( 0, 166.86, 0 ), "cspf_0_auto3425668870414121872", undefined, undefined, undefined, undefined, undefined, undefined, 20 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point_pisces_1_player";
    s.script_priority = "2";
    fe [[ f ]]( s, us, cf, ( 51293.2, 7197.25, 1867.9 ), ( 0, 169.29, 0 ), "cspf_0_auto3425668870414121872", undefined, undefined, undefined, undefined, undefined, undefined, 20 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point_pisces_1_player";
    s.script_priority = "3";
    fe [[ f ]]( s, us, cf, ( 51273.5, 7041.25, 1879.95 ), ( 0, 166.68, 0 ), "cspf_0_auto3425668870414121872", undefined, undefined, undefined, undefined, undefined, undefined, 20 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_point_pisces_1_player";
    s.script_priority = "4";
    fe [[ f ]]( s, us, cf, ( 51319.5, 7263.75, 1867.9 ), ( 0, 169.08, 0 ), "cspf_0_auto3425668870414121872", undefined, undefined, undefined, undefined, undefined, undefined, 20 );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_look_at_2";
    s.tier = "2";
    fe [[ f ]]( s, us, cf, ( 43520, 18779, 0 ), ( 0, 0, 0 ), "ob_infil_lookat" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_look_at_2";
    s.tier = "2";
    fe [[ f ]]( s, us, cf, ( 19699, 37220, 0 ), ( 0, 0, 0 ), "ob_infil_lookat" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_quad_02_ob_infil_cs";
    s.name = "infil_look_at_2";
    s.tier = "2";
    fe [[ f ]]( s, us, cf, ( 26058, 5791, 0 ), ( 0, 0, 0 ), "ob_infil_lookat" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_quad_02_ob_infil_cs
// Params 0, eflags: 0x4
// Checksum 0xb2ebf51, Offset: 0x161a
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_quad_02_ob_infil_cs
// Params 0
// Checksum 0xa2f1bc52, Offset: 0x1624
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_quad_02_ob_infil_cs" );
}

