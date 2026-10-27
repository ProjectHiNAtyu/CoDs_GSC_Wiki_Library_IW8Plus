// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_script_exfil_cs.gsc  (hash_11568943b881efad.gscc) (size: 6236 Bytes / 0x185c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa83ef321 (2822697761)
// size ...... 6236 (0x185c)
// includes .. 3   (offset: 0x1518)
// strings ... 30  (offset: 0x1530)
// dev strs .. 0   (offset: 0x185c)
// exports ... 9   (offset: 0x115c)
// cseg ...... 0x378 + 0xde4 (0x115c)
// imports ... 21  (offset: 0x12c4)
// animtree1 . 0   (offset: 0x185c)
// animtree2 . 0   (offset: 0x185c)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_locust_script_exfil_cs;

// Namespace zm_sat_locust_script_exfil_cs
// Params 0, eflags: 0x5
// Checksum 0xdd295cff, Offset: 0x396
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_locust_script_exfil_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_locust_script_exfil_cs
// Params 0, eflags: 0x4
// Checksum 0xc493aa2d, Offset: 0x3b7
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_locust_script_exfil_cs
// Params 0, eflags: 0x4
// Checksum 0x41a879c1, Offset: 0x3c8
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_locust_script_exfil_cs
// Params 2
// Checksum 0xf1412f88, Offset: 0x3d9
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_locust_script_exfil_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_locust_script_exfil_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_locust_script_exfil_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_locust_script_exfil_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_locust_script_exfil_cs
// Params 3, eflags: 0x4
// Checksum 0xc22acd0e, Offset: 0x461
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_locust_script_exfil_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_locust_script_exfil_cs" );
}

// Namespace zm_sat_locust_script_exfil_cs
// Params 3, eflags: 0x4
// Checksum 0x14c54e7e, Offset: 0x4db
// Size: 0xc61
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 3507.79, 3092.85, 103.21 ), ( 0, 196.04, 0 ), "cspf_0_auto10305019339124426960" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 3466.71, 3172.68, 190.65 ), ( 0, 196.04, 0 ), "cspf_0_auto1583949018310689612", "cspf_0_auto10305019339124426960", "teleport_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 3013.61, 378.17, 232.24 ), ( 0, 126.04, 0 ), "cspf_0_auto9849545907979105015" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 3486.03, 3167.57, 107.65 ), ( 0, 196.04, 0 ), "cspf_0_auto10305019339124426960" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 3401.92, 3076.84, 102.73 ), ( 0, 16.08, 0 ), "cspf_0_auto11469877783748546374", "cspf_0_auto2578739801796784356", "zone_downtown" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 3426.07, 3083.45, 161.75 ), ( 0, 288.86, 0 ), "cspf_0_auto2578739801796784356", "cspf_0_auto1583949018310689612", "interact" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 3921.72, 3469.17, 98.7 ), ( 0, 16.08, 0 ), "cspf_0_auto2578739801796784356", undefined, "hvt_spawn_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 3074.56, 444.08, 345.03 ), ( 0, 126.04, 0 ), "cspf_0_auto10907529007934853197", "cspf_0_auto9849545907979105015", "teleport_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 3076.38, 424.19, 232.24 ), ( 0, 126.04, 0 ), "cspf_0_auto9849545907979105015" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    s.script_int = int( 120 );
    s.script_label = "zombie_mangler_hvt";
    s.script_radius = int( 9000 );
    s.script_timer = int( 30 );
    fe [[ f ]]( s, us, cf, ( -754.9, -631.2, 838.86 ), ( 0, 0, 0 ), "zm_exfil", "cspf_0_auto11469877783748546374" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 2959.88, 515.63, 222.73 ), ( 0, 306.08, 0 ), "cspf_0_auto11469877783748546374", "cspf_0_auto1284933450841619039", "zone_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 2974.34, 495.19, 281.75 ), ( 0, 218.86, 0 ), "cspf_0_auto1284933450841619039", "cspf_0_auto10907529007934853197", "interact" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 3548.31, 454.78, 159.54 ), ( 0, 272.08, 0 ), "cspf_0_auto1284933450841619039", undefined, "hvt_spawn_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 3042.72, 398.23, 232.24 ), ( 0, 126.04, 0 ), "cspf_0_auto9849545907979105015" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 3106.17, 447.54, 232.24 ), ( 0, 126.04, 0 ), "cspf_0_auto9849545907979105015" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 3498.9, 3127.07, 104.33 ), ( 0, 196.04, 0 ), "cspf_0_auto10305019339124426960" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 3474.27, 3203.55, 103.65 ), ( 0, 196.04, 0 ), "cspf_0_auto10305019339124426960" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( -1013.91, 4431.27, 160 ), ( 0, 211.04, 0 ), "cspf_0_auto10773635258313611036" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( -1000.83, 4494.67, 264 ), ( 0, 211.04, 0 ), "cspf_0_auto17403224167532996700", "cspf_0_auto10773635258313611036", "teleport_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( -1054.28, 4497.81, 160 ), ( 0, 211.04, 0 ), "cspf_0_auto10773635258313611036" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( -1212.7, 4349.14, 158.73 ), ( 0, 351.08, 0 ), "cspf_0_auto11469877783748546374", "cspf_0_auto18350268680556385178", "zone_foundry" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( -1204.49, 4338.78, 217.75 ), ( 0, 258.86, 0 ), "cspf_0_auto18350268680556385178", "cspf_0_auto17403224167532996700", "interact" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( -840.22, 4675.38, 160 ), ( 0, 231.08, 0 ), "cspf_0_auto18350268680556385178", undefined, "hvt_spawn_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( -1031.36, 4462.01, 160 ), ( 0, 211.04, 0 ), "cspf_0_auto10773635258313611036" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( -1074.95, 4529.52, 160 ), ( 0, 211.04, 0 ), "cspf_0_auto10773635258313611036" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 6964.26, 2755.3, 96 ), ( 0, 21.04, 0 ), "cspf_0_auto10097522273415094141" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 7015.21, 2681.94, 217.03 ), ( 0, 21.04, 0 ), "cspf_0_auto6842159007178911196", "cspf_0_auto10097522273415094141", "teleport_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 6992.46, 2682.77, 96 ), ( 0, 21.04, 0 ), "cspf_0_auto10097522273415094141" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 7143.01, 2779.99, 94.73 ), ( 0, 201.07, 0 ), "cspf_0_auto11469877783748546374", "cspf_0_auto358139403134816036", "zone_lighthouse" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 7119.53, 2771.31, 153.75 ), ( 0, 113.85, 0 ), "cspf_0_auto358139403134816036", "cspf_0_auto6842159007178911196", "interact" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 7084.85, 2030.86, 121.17 ), ( 0, 106.08, 0 ), "cspf_0_auto358139403134816036", undefined, "hvt_spawn_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 6976.1, 2722.01, 96 ), ( 0, 21.04, 0 ), "cspf_0_auto10097522273415094141" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 7007.31, 2647.95, 96 ), ( 0, 21.04, 0 ), "cspf_0_auto10097522273415094141" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 2481.17, 5458.67, 295.56 ), ( 0, 271.04, 0 ), "cspf_0_auto16919469686870356636" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 2394.8, 5435.88, 377.03 ), ( 0, 271.04, 0 ), "cspf_0_auto1023451049317651300", "cspf_0_auto16919469686870356636", "teleport_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 2403.36, 5456.98, 288.43 ), ( 0, 271.04, 0 ), "cspf_0_auto16919469686870356636" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 2411.14, 5314.18, 254.73 ), ( 0, 89.08, 0 ), "cspf_0_auto11469877783748546374", "cspf_0_auto17354565455755984037", "zone_fishery" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 2411.9, 5339.2, 313.75 ), ( 0, 1.85, 0 ), "cspf_0_auto17354565455755984037", "cspf_0_auto1023451049317651300", "interact" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 1705.97, 5876.29, 52.62 ), ( 0, 271.07, 0 ), "cspf_0_auto17354565455755984037", undefined, "hvt_spawn_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 2445.83, 5458.93, 292.52 ), ( 0, 271.04, 0 ), "cspf_0_auto16919469686870356636" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 2365.56, 5454.93, 284.73 ), ( 0, 271.04, 0 ), "cspf_0_auto16919469686870356636" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 3712, 248, 160 ), ( 0, 306.08, 0 ), "cspf_0_auto1284933450841619039", undefined, "override_exfil_center" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 3674, 3406, 96 ), ( 0, 306.08, 0 ), "cspf_0_auto2578739801796784356", undefined, "override_exfil_center" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( -591.69, 4530.78, 192 ), ( 0, 306.08, 0 ), "cspf_0_auto18350268680556385178", undefined, "override_exfil_center" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 1898.31, 5840.78, 55.6 ), ( 0, 306.08, 0 ), "cspf_0_auto17354565455755984037", undefined, "override_exfil_center" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_script_exfil_cs";
    fe [[ f ]]( s, us, cf, ( 6768, 1726, 130 ), ( 0, 286.08, 0 ), "cspf_0_auto358139403134816036", undefined, "override_exfil_center" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_locust_script_exfil_cs
// Params 0, eflags: 0x4
// Checksum 0x242814ed, Offset: 0x1144
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_locust_script_exfil_cs
// Params 0
// Checksum 0x791043, Offset: 0x114e
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_locust_script_exfil_cs" );
}

