// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_br_cs.gsc  (hash_37964905501d8805.gscc) (size: 8257 Bytes / 0x2041 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x338ce63e (864871998)
// size ...... 8257 (0x2041)
// includes .. 3   (offset: 0x1cb5)
// strings ... 33  (offset: 0x1ccd)
// dev strs .. 0   (offset: 0x2041)
// exports ... 9   (offset: 0x191d)
// cseg ...... 0x32d + 0x15f0 (0x191d)
// imports ... 20  (offset: 0x1a85)
// animtree1 . 0   (offset: 0x2041)
// animtree2 . 0   (offset: 0x2041)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_scarab_br_cs;

// Namespace zm_sat_scarab_br_cs
// Params 0, eflags: 0x5
// Checksum 0xbba8b6ba, Offset: 0x34b
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_scarab_br_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_scarab_br_cs
// Params 0, eflags: 0x4
// Checksum 0xf4d60364, Offset: 0x36c
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_scarab_br_cs
// Params 0, eflags: 0x4
// Checksum 0x71edd088, Offset: 0x37d
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_scarab_br_cs
// Params 2
// Checksum 0xc10486c1, Offset: 0x38e
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_scarab_br_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_scarab_br_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_scarab_br_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_scarab_br_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_scarab_br_cs
// Params 3, eflags: 0x4
// Checksum 0xf26f6447, Offset: 0x416
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_scarab_br_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_scarab_br_cs" );
}

// Namespace zm_sat_scarab_br_cs
// Params 3, eflags: 0x4
// Checksum 0xdfe8e63e, Offset: 0x490
// Size: 0x146d
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    fe [[ f ]]( s, us, cf, ( 29409, -28965, 2077 ), ( 0, 90, 0 ), "br_warp_loc", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    fe [[ f ]]( s, us, cf, ( 29515, -28965, 2084 ), ( 0, 90, 0 ), "br_warp_loc", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    fe [[ f ]]( s, us, cf, ( 29624, -28965, 2082 ), ( 0, 90, 0 ), "br_warp_loc", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    fe [[ f ]]( s, us, cf, ( 29421, -27412, 2212 ), ( 0, 270, 0 ), "br_boss_spawn", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    fe [[ f ]]( s, us, cf, ( 29421, -27111.5, 2204 ), ( 0, 0, 0 ), "center_north", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "post_br_teleport";
    fe [[ f ]]( s, us, cf, ( -93, -1700, 1294 ), ( 0, 84.92, 0 ), "pbr_teleport_pos", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    fe [[ f ]]( s, us, cf, ( 248.5, -3981, 1964 ), ( 0, 2.12, 0 ), "scarab_br_box", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "post_br_teleport";
    fe [[ f ]]( s, us, cf, ( -22.25, -1623.75, 1302.75 ), ( 0, 0, 0 ), "post_br_teleport_struct", "pbr_teleport_pos", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "post_br_teleport";
    fe [[ f ]]( s, us, cf, ( -160, -1694, 1294 ), ( 0, 84.92, 0 ), "pbr_teleport_pos", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "post_br_teleport";
    fe [[ f ]]( s, us, cf, ( 23.75, -1710.25, 1294 ), ( 0, 84.92, 0 ), "pbr_teleport_pos", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "post_br_teleport";
    fe [[ f ]]( s, us, cf, ( 176.75, -1711.25, 1294 ), ( 0, 84.92, 0 ), "pbr_teleport_pos", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    fe [[ f ]]( s, us, cf, ( 29336, -28965, 2077 ), ( 0, 90, 0 ), "br_warp_loc", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    fe [[ f ]]( s, us, cf, ( 29736.2, -27426.8, 2204 ), ( 0, 270, 0 ), "center_east", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    fe [[ f ]]( s, us, cf, ( 29411.2, -27730.6, 2204 ), ( 0, 180, 0 ), "center_south", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    fe [[ f ]]( s, us, cf, ( 29114.7, -27406.1, 2204 ), ( 0, 90, 0 ), "center_west", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "urchin_spawns";
    fe [[ f ]]( s, us, cf, ( 31502.5, -27429.3, 2249 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "urchin_spawns";
    fe [[ f ]]( s, us, cf, ( 30657.8, -28784.8, 2049.75 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "urchin_spawns";
    fe [[ f ]]( s, us, cf, ( 29426.6, -28946.6, 2065.25 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "urchin_spawns";
    fe [[ f ]]( s, us, cf, ( 28107.6, -28727.6, 2074.75 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "urchin_spawns";
    fe [[ f ]]( s, us, cf, ( 27757.6, -27417.6, 2101.5 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "urchin_spawns";
    fe [[ f ]]( s, us, cf, ( 28139.1, -26210.3, 2086.25 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "urchin_spawns";
    fe [[ f ]]( s, us, cf, ( 29415.8, -25788.8, 2009.25 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "urchin_spawns";
    fe [[ f ]]( s, us, cf, ( 30609.8, -26083.3, 2023.75 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "urchin_spawns";
    fe [[ f ]]( s, us, cf, ( 30281.5, -27429.3, 2103.25 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "urchin_spawns";
    fe [[ f ]]( s, us, cf, ( 30167.2, -28364.8, 2063 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "urchin_spawns";
    fe [[ f ]]( s, us, cf, ( 29434.2, -28632.8, 2065 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "urchin_spawns";
    fe [[ f ]]( s, us, cf, ( 28416.7, -28365.1, 2078.5 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "urchin_spawns";
    fe [[ f ]]( s, us, cf, ( 28416.7, -27409.6, 2104.75 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "urchin_spawns";
    fe [[ f ]]( s, us, cf, ( 28543.4, -26587.8, 2042.25 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "urchin_spawns";
    fe [[ f ]]( s, us, cf, ( 29435.9, -26433.6, 2103.25 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "urchin_spawns";
    fe [[ f ]]( s, us, cf, ( 30204.7, -26645.3, 2056 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "urchin_spawns";
    fe [[ f ]]( s, us, cf, ( 29420.9, -27410.8, 2195.75 ), ( 0, 0, 0 ), "urchin_spawn_boss", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "barnacle_spawns";
    fe [[ f ]]( s, us, cf, ( 30479.5, -26842.6, 2058.75 ), ( 0, 0, 0 ), "barnacle_boss_spawn", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "barnacle_spawns";
    fe [[ f ]]( s, us, cf, ( 30054, -26301.8, 2014 ), ( 0, 0, 0 ), "barnacle_boss_spawn", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "barnacle_spawns";
    fe [[ f ]]( s, us, cf, ( 30678, -27906.6, 2052.25 ), ( 0, 0, 0 ), "barnacle_boss_spawn", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "barnacle_spawns";
    fe [[ f ]]( s, us, cf, ( 29922.5, -28655.6, 2118.5 ), ( 0, 0, 0 ), "barnacle_boss_spawn", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "barnacle_spawns";
    fe [[ f ]]( s, us, cf, ( 29028.8, -28655.6, 2077.25 ), ( 0, 0, 0 ), "barnacle_boss_spawn", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "barnacle_spawns";
    fe [[ f ]]( s, us, cf, ( 28351.6, -27876.6, 2033 ), ( 0, 86.32, 0 ), "barnacle_boss_spawn", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "barnacle_spawns";
    fe [[ f ]]( s, us, cf, ( 28379.8, -26990.6, 2029.25 ), ( 0, 0, 0 ), "barnacle_boss_spawn", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "barnacle_spawns";
    fe [[ f ]]( s, us, cf, ( 28984.1, -26385.8, 2024 ), ( 0, 0, 0 ), "barnacle_boss_spawn", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "weyward_warp_pos";
    fe [[ f ]]( s, us, cf, ( 30487.5, 30108.2, 1555.75 ), ( 0, 90, 0 ), "weyward_warp_pos", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "weyward_warp_pos";
    fe [[ f ]]( s, us, cf, ( 31135.5, 30108.2, 1555.75 ), ( 0, 90, 0 ), "weyward_warp_pos", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "weyward_warp_pos";
    fe [[ f ]]( s, us, cf, ( 30951.5, 30018.2, 1555.75 ), ( 0, 90, 0 ), "weyward_warp_pos", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "weyward_warp_pos";
    fe [[ f ]]( s, us, cf, ( 30661.5, 30016.2, 1555.75 ), ( 0, 90, 0 ), "weyward_warp_pos", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "game_over_scenes";
    s.name = "neptune_death_scene_struct";
    s.script_scenescriptbundle = "sat_cin_zm_vig_player_dth_neptune";
    fe [[ f ]]( s, us, cf, ( 29421, -27412, 2212 ), ( 0, 270, 0 ), "neptune_game_over_scene", undefined, "zombie_game_over_scene", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "game_over_scenes";
    s.name = "triton_death_scene_struct";
    s.script_scenescriptbundle = "cin_t10_zm_vig_player_dth_keep_boss";
    fe [[ f ]]( s, us, cf, ( 29421, -27412, 2219.5 ), ( 0, 270, 0 ), "triton_game_over_scene", undefined, "zombie_game_over_scene", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.groupid = "game_over_scenes";
    s.name = "phobos_death_scene_struct";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_phobos_01";
    fe [[ f ]]( s, us, cf, ( 29421, -27412, 2212 ), ( 0, 270, 0 ), "phobos_game_over_scene", undefined, "zombie_game_over_scene", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "zm_sat_scarab_br_cs";
    s.script_modelname = "packapunch_sat_zm_scarab_br";
    s.script_start = "1";
    fe [[ f ]]( s, us, cf, ( 29430, -29663, 2118 ), ( 0, 90, 0 ), "br_pap", undefined, "pack_a_punch_machine", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_scarab_br_cs
// Params 0, eflags: 0x4
// Checksum 0xbb60e059, Offset: 0x1905
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_scarab_br_cs
// Params 0
// Checksum 0x303cb90a, Offset: 0x190f
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_scarab_br_cs" );
}

