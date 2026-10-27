// script_4ef4db19236bd197  (hash_4ef4db19236bd197.gscc) (size: 2861 Bytes / 0xb2d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x50ebbb49 (1357626185)
// size ...... 2861 (0xb2d)
// includes .. 3   (offset: 0xa0d)
// strings ... 10  (offset: 0xa25)
// dev strs .. 0   (offset: 0xb2d)
// exports ... 9   (offset: 0x675)
// cseg ...... 0x134 + 0x541 (0x675)
// imports ... 20  (offset: 0x7dd)
// animtree1 . 0   (offset: 0xb2d)
// animtree2 . 0   (offset: 0xb2d)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_sat_avalon_q4_ob_activity_pisces_aqua_duct_cs;

// Namespace mp_sat_avalon_q4_ob_activity_pisces_aqua_duct_cs
// Params 0, eflags: 0x5
// Checksum 0x93c50fdf, Offset: 0x152
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_sat_avalon_q4_ob_activity_pisces_aqua_duct_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_sat_avalon_q4_ob_activity_pisces_aqua_duct_cs
// Params 0, eflags: 0x4
// Checksum 0x47606f5b, Offset: 0x173
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_sat_avalon_q4_ob_activity_pisces_aqua_duct_cs
// Params 0, eflags: 0x4
// Checksum 0xc25bbcb7, Offset: 0x184
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_sat_avalon_q4_ob_activity_pisces_aqua_duct_cs
// Params 2
// Checksum 0x72b2eafe, Offset: 0x195
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_sat_avalon_q4_ob_activity_pisces_aqua_duct_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_sat_avalon_q4_ob_activity_pisces_aqua_duct_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_sat_avalon_q4_ob_activity_pisces_aqua_duct_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_sat_avalon_q4_ob_activity_pisces_aqua_duct_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_sat_avalon_q4_ob_activity_pisces_aqua_duct_cs
// Params 3, eflags: 0x4
// Checksum 0x41d90878, Offset: 0x21d
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_sat_avalon_q4_ob_activity_pisces_aqua_duct_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_sat_avalon_q4_ob_activity_pisces_aqua_duct_cs" );
}

// Namespace mp_sat_avalon_q4_ob_activity_pisces_aqua_duct_cs
// Params 3, eflags: 0x4
// Checksum 0x9fb9edac, Offset: 0x297
// Size: 0x3be
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_aqua_duct_cs";
    s.name = "turret";
    fe [[ f ]]( s, us, cf, ( 36285.2, -2555, 313.5 ), ( 4.69, 85.44, -0.97 ), "s_pisces_turret" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_aqua_duct_cs";
    s.name = "turret";
    fe [[ f ]]( s, us, cf, ( 51836.1, -2423.15, 866.51 ), ( 345.49, 73.75, 2.01 ), "s_pisces_turret" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_aqua_duct_cs";
    s.name = "cache";
    fe [[ f ]]( s, us, cf, ( 39586.5, -3044, 479.34 ), ( 348.33, 355.08, 6.67 ), "pisces_aquaduct_weapon_cache", undefined, "ob_sat_item_select_weapon_sm_long_green" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_aqua_duct_cs";
    s.name = "mine";
    fe [[ f ]]( s, us, cf, ( 48581.2, -2605, 512.89 ), ( 353.46, 270.23, -1.73 ), "s_pisces_mines" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_aqua_duct_cs";
    s.name = "mine";
    fe [[ f ]]( s, us, cf, ( 48463.2, -2519, 505.16 ), ( 350.99, 270.43, -2.48 ), "s_pisces_mines" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_aqua_duct_cs";
    s.name = "mine";
    fe [[ f ]]( s, us, cf, ( 48347.2, -2577, 520.48 ), ( 352.04, 270.58, -4.05 ), "s_pisces_mines" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_aqua_duct_cs";
    s.name = "mine";
    fe [[ f ]]( s, us, cf, ( 48851.2, -2506, 502.53 ), ( 354.73, 270.19, 1.8 ), "s_pisces_mines" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_aqua_duct_cs";
    s.name = "mine";
    fe [[ f ]]( s, us, cf, ( 47960.2, -2521, 550.78 ), ( 351.02, 270.58, -5.83 ), "s_pisces_mines" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_aqua_duct_cs";
    s.name = "cache";
    fe [[ f ]]( s, us, cf, ( 40617, -3192, 1231.5 ), ( 0, 270.2, 0 ), "pisces_aquaduct_weapon_cache", undefined, "ob_sat_item_select_weapon_sm_long_green" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_aqua_duct_cs";
    s.name = "cache";
    fe [[ f ]]( s, us, cf, ( 45153, -3193, 1231.5 ), ( 0, 269.2, 0 ), "pisces_aquaduct_weapon_cache", undefined, "ob_sat_item_select_weapon_sm_long_green" );
    s = {};
    s.script_cs_flag = "mp_sat_avalon_q4_ob_activity_pisces_aqua_duct_cs";
    s.name = "cache";
    fe [[ f ]]( s, us, cf, ( 48810, -3040, 511.19 ), ( 358.7, 181.46, -4.73 ), "pisces_aquaduct_weapon_cache", undefined, "ob_sat_item_select_weapon_sm_long_green" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_sat_avalon_q4_ob_activity_pisces_aqua_duct_cs
// Params 0, eflags: 0x4
// Checksum 0xf89dc3f5, Offset: 0x65d
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_sat_avalon_q4_ob_activity_pisces_aqua_duct_cs
// Params 0
// Checksum 0x838ad535, Offset: 0x667
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_sat_avalon_q4_ob_activity_pisces_aqua_duct_cs" );
}

