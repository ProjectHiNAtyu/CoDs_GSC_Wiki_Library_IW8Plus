// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_ee_richtofen_cs.gsc  (hash_6415d94484131f5e.gscc) (size: 24868 Bytes / 0x6124 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2e7c947 (48744775)
// size ...... 24868 (0x6124)
// includes .. 3   (offset: 0x5224)
// strings ... 116 (offset: 0x523c)
// dev strs .. 0   (offset: 0x6124)
// exports ... 9   (offset: 0x4e10)
// cseg ...... 0xc69 + 0x41a7 (0x4e10)
// imports ... 21  (offset: 0x4f78)
// animtree1 . 0   (offset: 0x6124)
// animtree2 . 0   (offset: 0x6124)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_locust_ee_richtofen_cs;

// Namespace zm_sat_locust_ee_richtofen_cs
// Params 0, eflags: 0x5
// Checksum 0xff2e31e2, Offset: 0xc87
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_locust_ee_richtofen_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_locust_ee_richtofen_cs
// Params 0, eflags: 0x4
// Checksum 0x6f8d4093, Offset: 0xca8
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_locust_ee_richtofen_cs
// Params 0, eflags: 0x4
// Checksum 0xeab6937f, Offset: 0xcb9
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_locust_ee_richtofen_cs
// Params 2
// Checksum 0x5a5fc536, Offset: 0xcca
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_locust_ee_richtofen_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_locust_ee_richtofen_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_locust_ee_richtofen_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_locust_ee_richtofen_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_locust_ee_richtofen_cs
// Params 3, eflags: 0x4
// Checksum 0x693427b0, Offset: 0xd52
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_locust_ee_richtofen_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_locust_ee_richtofen_cs" );
}

// Namespace zm_sat_locust_ee_richtofen_cs
// Params 3, eflags: 0x4
// Checksum 0xb9c66d8d, Offset: 0xdcc
// Size: 0x4024
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "notes";
    fe [[ f ]]( s, us, cf, ( 6028.52, 10375.9, 672 ), ( 0, 213.27, 0 ), "rr_3_note", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "notes";
    fe [[ f ]]( s, us, cf, ( 5494, 10216, 672 ), ( 0, 169.43, 0 ), "rr_3_note", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "notes";
    fe [[ f ]]( s, us, cf, ( 6624, 10252, 674 ), ( 0, 134.62, 0 ), "rr_3_note", undefined, "3" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.script_scenescriptbundle = "sat_zm_break_door";
    fe [[ f ]]( s, us, cf, ( 6550.09, 10430, 672.1 ), ( 0, 317.91, 0 ), "cspf_0_auto7205851580992670872", undefined, "shot_2" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "interacts";
    fe [[ f ]]( s, us, cf, ( 7393.73, 10249.8, 697.77 ), ( 65.92, 180, -180 ), "rr_3_intr", undefined, "3" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "interacts";
    fe [[ f ]]( s, us, cf, ( 7077.25, 10438.2, 707.5 ), ( 0, 135, 0 ), "rr_3_intr", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "interacts";
    fe [[ f ]]( s, us, cf, ( 7194.5, 10296.5, 699.5 ), ( 0, 0, 0 ), "rr_3_intr", "cspf_0_auto1718419616920527263", "1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 70, 166, 146 );
    s._size_min = ( 32, 138, 32 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 7111.41, 10284, 671 ), ( 0, 0, 0 ), "rr_3_trigger" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.script_scenescriptbundle = "sat_zm_break_door";
    fe [[ f ]]( s, us, cf, ( 6300.38, 10159.9, 672.1 ), ( 0, 92.47, 0 ), "cspf_0_auto10835352392873245189", undefined, "shot_1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.script_scenescriptbundle = "sat_zm_break_door";
    fe [[ f ]]( s, us, cf, ( 6044.9, 10159.1, 672.1 ), ( 0, 138.97, 0 ), "cspf_0_auto17826928599526248460", undefined, "shot_2" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "door_ref";
    fe [[ f ]]( s, us, cf, ( 6990, 10247, 679 ), ( 0, 0, 0 ), "door_rotate_ref_right" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "door_ref";
    fe [[ f ]]( s, us, cf, ( 6990, 10341, 679 ), ( 0, 0, 0 ), "door_rotate_ref_left" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "interacts";
    fe [[ f ]]( s, us, cf, ( 7201, 10261.5, 699.65 ), ( 270, 214.28, -145.72 ), "cspf_0_auto1718419616920527263", "cspf_0_auto5085999218950649282", "right" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.script_scenescriptbundle = "sat_zm_break_door";
    fe [[ f ]]( s, us, cf, ( 5781.34, 10434.1, 672.1 ), ( 0, 270.85, 0 ), "cspf_0_auto18190302550691167867", undefined, "shot_1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 6763.97, 10323.5, 671.5 ), ( 0, 281.06, 0 ), "rr_3_zm_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "interacts";
    fe [[ f ]]( s, us, cf, ( 7201, 10329, 699.5 ), ( 0, 0, 0 ), "cspf_0_auto1718419616920527263", "cspf_0_auto15336241731207625945", "left" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 70, 120, 146 );
    s._size_min = ( 32, 102, 32 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 6626, 10283, 671 ), ( 0, 0, 0 ), "rr_3_trigger_hallway", "cspf_0_auto7109756074630992901", "1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 70, 120, 146 );
    s._size_min = ( 32, 102, 32 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 6371, 10282, 671 ), ( 0, 0, 0 ), "rr_3_trigger_hallway", "cspf_0_auto8588899921978600345", "2" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 70, 120, 146 );
    s._size_min = ( 32, 102, 32 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 6101, 10281, 671 ), ( 0, 0, 0 ), "rr_3_trigger_hallway", "cspf_0_auto452105771131489790", "3" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    fe [[ f ]]( s, us, cf, ( 5353, 10294, 726 ), ( 0, 0, 0 ), "rr_3_exit_intr" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 6992, 10293, 730 ), ( 0, 0, 0 ), "rr_3_door_intr" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "blockers";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 5528, 10228, 706.72 ), ( 90, 0, 90 ), "rr_3_block", "cspf_0_auto14403306358817848013", "1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.script_int = int( 3000 );
    fe [[ f ]]( s, us, cf, ( -593.91, 5940.47, 307 ), ( 0, 279.8, 0 ), "rr_3_land" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "blockers";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 5527, 10354, 706.34 ), ( 90, 0, 90 ), "rr_3_block", "cspf_0_auto89192715897328278", "1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "blockers";
    fe [[ f ]]( s, us, cf, ( 5528.81, 10289.4, 744.43 ), ( -45, 90, -90 ), "cspf_0_auto14403306358817848013" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "blockers";
    fe [[ f ]]( s, us, cf, ( 5530, 10298.2, 744.77 ), ( -45, -90, -90 ), "cspf_0_auto89192715897328278" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "blockers";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 6170, 10234, 706.55 ), ( 90, 0, 90 ), "rr_3_block", "cspf_0_auto15417303340856658072", "2" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "blockers";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 6169, 10352.5, 706.36 ), ( 90, 0, 90 ), "rr_3_block", "cspf_0_auto14760928161725738483", "2" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "blockers";
    fe [[ f ]]( s, us, cf, ( 6171, 10287.3, 743.35 ), ( -45, 90, -90 ), "cspf_0_auto15417303340856658072" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "blockers";
    fe [[ f ]]( s, us, cf, ( 6172.21, 10298.2, 743.76 ), ( -45, -90, -90 ), "cspf_0_auto14760928161725738483" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "blockers";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 6809, 10228, 706.4 ), ( 90, 0, 90 ), "rr_3_block", "cspf_0_auto14349499866461759838", "3" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "blockers";
    s.name = "script_struct";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 6809, 10356.3, 706.5 ), ( 90, 0, 90 ), "rr_3_block", "cspf_0_auto720650949884131561", "3" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "blockers";
    fe [[ f ]]( s, us, cf, ( 6810.74, 10287.8, 744.79 ), ( -45, 90, -90 ), "cspf_0_auto14349499866461759838" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "blockers";
    fe [[ f ]]( s, us, cf, ( 6812, 10298.1, 742.94 ), ( -45, -90, -90 ), "cspf_0_auto720650949884131561" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "interacts";
    fe [[ f ]]( s, us, cf, ( 7193, 10265.5, 699.65 ), ( 270, 168.19, 168.19 ), "cspf_0_auto5085999218950649282", "cspf_0_auto14639335580346914608" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "interacts";
    fe [[ f ]]( s, us, cf, ( 7194.5, 10260, 699.65 ), ( 270, 7.85, 7.85 ), "cspf_0_auto5085999218950649282", "cspf_0_auto8316696840214408521" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "interacts";
    fe [[ f ]]( s, us, cf, ( 7192.5, 10324, 699.5 ), ( 0, 0, 0 ), "cspf_0_auto15336241731207625945", "cspf_0_auto10406389719251094634" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "interacts";
    fe [[ f ]]( s, us, cf, ( 7193.5, 10331.5, 699.5 ), ( 0, 0, 0 ), "cspf_0_auto15336241731207625945", "cspf_0_auto1009968832462447564" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "blockers";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 6828.85, 10277, 671.5 ), ( 0, 270, 0 ), "rr_3_block", undefined, "doorbuy_zm_sat_locust_floating_debris_ashwood_04" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "blockers";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 6184.39, 10277.2, 671.5 ), ( 0, 270, 0 ), "rr_3_block", undefined, "doorbuy_zm_sat_locust_floating_debris_ashwood_04" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "blockers";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 5545.1, 10277.2, 729.1 ), ( 0, 270, 0 ), "rr_3_block", undefined, "doorbuy_zm_sat_locust_floating_vfx" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "blockers";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 6184.64, 10277, 729.1 ), ( 0, 270, 0 ), "rr_3_block", undefined, "doorbuy_zm_sat_locust_floating_vfx" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "blockers";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 6829.1, 10276.8, 729.1 ), ( 0, 270, 0 ), "rr_3_block", undefined, "doorbuy_zm_sat_locust_floating_vfx" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 70, 120, 146 );
    s._size_min = ( 32, 102, 32 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 5406.91, 10280.8, 671 ), ( 0, 0, 0 ), "rr_3_trigger_hallway", "cspf_0_auto452105771131489790", "4" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "side_doors";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 6033.25, 10388.3, 719.25 ), ( 0, 0, 0 ), "rr_3_side", "cspf_0_auto10538794395302600106", "left" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "side_doors";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 5790.75, 10382.8, 719.5 ), ( 0, 0, 0 ), "rr_3_side", "cspf_0_auto18190302550691167867", "left" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "side_doors";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 5791, 10200.5, 719.25 ), ( 0, 0, 0 ), "rr_3_side", "cspf_0_auto8715592142248074458", "right" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "side_doors";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 6033.5, 10200.5, 719 ), ( 0, 0, 0 ), "rr_3_side", "cspf_0_auto17826928599526248460", "right" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "side_doors";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 6300, 10388.3, 719 ), ( 0, 0, 0 ), "rr_3_side", "cspf_0_auto12624489859913878808", "left" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "side_doors";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 6300.25, 10200.5, 718.75 ), ( 0, 0, 0 ), "rr_3_side", "cspf_0_auto10835352392873245189", "right" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "side_doors";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 6555.25, 10388.3, 718.75 ), ( 0, 0, 0 ), "rr_3_side", "cspf_0_auto7205851580992670872", "left" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "side_doors";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 6555.5, 10200.5, 718.5 ), ( 0, 0, 0 ), "rr_3_side", "cspf_0_auto4415159595858961639", "right" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "interacts";
    fe [[ f ]]( s, us, cf, ( 7195.5, 10305, 707.02 ), ( 0, 328.03, 0 ), "cspf_0_auto10406389719251094634", undefined, "placed" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 6849.66, 10262.4, 671.5 ), ( 0, 53.11, 0 ), "rr_3_zm_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "interacts";
    fe [[ f ]]( s, us, cf, ( 7193, 10302.5, 707.02 ), ( 0, 249.39, 0 ), "cspf_0_auto1009968832462447564", undefined, "placed" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "interacts";
    fe [[ f ]]( s, us, cf, ( 7195.75, 10301.8, 707.02 ), ( 0, 71.64, 0 ), "cspf_0_auto15336241731207625945", undefined, "placed" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "interacts";
    fe [[ f ]]( s, us, cf, ( 7195.48, 10288, 707.27 ), ( 270, 0, 0 ), "cspf_0_auto14639335580346914608", undefined, "placed" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "interacts";
    fe [[ f ]]( s, us, cf, ( 7196.21, 10291.6, 707.27 ), ( 270, 23.26, 37.91 ), "cspf_0_auto8316696840214408521", undefined, "placed" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "interacts";
    fe [[ f ]]( s, us, cf, ( 7192.31, 10291.4, 707.27 ), ( 270, 355.46, 156.45 ), "cspf_0_auto5085999218950649282", undefined, "placed" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 52, 48, 146 );
    s._size_min = ( 32, 40, 32 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 7028.49, 10396.2, 671 ), ( 0, 0, 0 ), "rr_3_trigger" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s._size_max = ( 56, 48, 146 );
    s._size_min = ( 32, 40, 32 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 7028.74, 10184.4, 671 ), ( 0, 0, 0 ), "rr_3_trigger" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.script_scenescriptbundle = "sat_cin_zm_vig_locust_richt_sq";
    fe [[ f ]]( s, us, cf, ( 7380.86, 10292.8, 690.92 ), ( 0, 180, 0 ), "rr_3_figure" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "hall_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 6716.15, 10199.2, 730.51 ), ( 270, 263.91, 6.09 ), "cspf_0_auto11456690647726193560", "cspf_0_auto1311702209887841225", "rr_3_fire" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "hall_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 6648.5, 10198.1, 752.5 ), ( 270, 277.99, -7.99 ), "cspf_0_auto1311702209887841225", "cspf_0_auto11533934137942370087", "rr_3_fire" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "zombie_spawns";
    fe [[ f ]]( s, us, cf, ( 6045.5, 10444, 671.5 ), ( 0, 0, 0 ), "cspf_0_auto10538794395302600106" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "zombie_spawns";
    fe [[ f ]]( s, us, cf, ( 5782.5, 10151, 671.5 ), ( 0, 0, 0 ), "cspf_0_auto8715592142248074458" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "zombie_spawns";
    fe [[ f ]]( s, us, cf, ( 5783.5, 10443.5, 671.5 ), ( 0, 0, 0 ), "cspf_0_auto18190302550691167867" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "zombie_spawns";
    fe [[ f ]]( s, us, cf, ( 6045.5, 10150.5, 671.5 ), ( 0, 0, 0 ), "cspf_0_auto17826928599526248460" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "zombie_spawns";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 6295, 10443.5, 671.5 ), ( 0, 0, 0 ), "cspf_0_auto12624489859913878808" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "zombie_spawns";
    fe [[ f ]]( s, us, cf, ( 6295, 10150, 671.5 ), ( 0, 0, 0 ), "cspf_0_auto10835352392873245189" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "zombie_spawns";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 6561.5, 10443, 671.5 ), ( 0, 0, 0 ), "cspf_0_auto7205851580992670872" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "zombie_spawns";
    fe [[ f ]]( s, us, cf, ( 6561.5, 10149.5, 671.5 ), ( 0, 0, 0 ), "cspf_0_auto4415159595858961639" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "hall_fire";
    fe [[ f ]]( s, us, cf, ( 6702.76, 10357.1, 671.5 ), ( 0, 0, 0 ), "cspf_0_auto11456690647726193560", "cspf_0_auto16116933113530914870", "rr_3_fire", undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "hall_fire";
    fe [[ f ]]( s, us, cf, ( 6841.33, 10220.5, 671.5 ), ( 0, 0, 0 ), "rr_3_fire", "cspf_0_auto11456690647726193560", "rr_3_fire", undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "hall_fire";
    fe [[ f ]]( s, us, cf, ( 6055.4, 10355.2, 671.5 ), ( 0, 0, 0 ), "cspf_0_auto17352254607262880111", "cspf_0_auto203701599515351256", "rr_3_fire", undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "hall_fire";
    fe [[ f ]]( s, us, cf, ( 5922.81, 10229.5, 671.5 ), ( 0, 0, 0 ), "cspf_0_auto203701599515351256", "cspf_0_auto18221978626478287425", "rr_3_fire", undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "hall_fire";
    fe [[ f ]]( s, us, cf, ( 5760.54, 10241.3, 671.5 ), ( 0, 0, 0 ), "cspf_0_auto452105771131489790", "cspf_0_auto4837017982076729706", "rr_3_fire", undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "hall_fire";
    fe [[ f ]]( s, us, cf, ( 5587, 10359, 671.5 ), ( 0, 0, 0 ), "cspf_0_auto4837017982076729706", "cspf_0_auto17313455358568318714", "rr_3_fire", undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "hall_fire";
    fe [[ f ]]( s, us, cf, ( 6520.56, 10344.9, 671.5 ), ( 0, 0, 0 ), "cspf_0_auto7109756074630992901", "cspf_0_auto6712191430340163705", "rr_3_fire", undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "hall_fire";
    fe [[ f ]]( s, us, cf, ( 6385.73, 10232.5, 671.5 ), ( 0, 0, 0 ), "cspf_0_auto6712191430340163705", "cspf_0_auto16229746575587729958", "rr_3_fire", undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "hall_fire";
    fe [[ f ]]( s, us, cf, ( 6230.81, 10213.7, 671.5 ), ( 0, 0, 0 ), "cspf_0_auto16229746575587729958", "cspf_0_auto9214924227794941246", "rr_3_fire", undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "hall_fire";
    fe [[ f ]]( s, us, cf, ( 6216.84, 10338.2, 671.5 ), ( 0, 0, 0 ), "cspf_0_auto8588899921978600345", "cspf_0_auto17352254607262880111", "rr_3_fire", undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "hall_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 6713.62, 10388.5, 752.5 ), ( 270, 83.47, 6.53 ), "cspf_0_auto16116933113530914870", "cspf_0_auto14372651936559091952", "rr_3_fire" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "hall_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 6490.67, 10389.4, 733.41 ), ( 270, 83.47, 6.53 ), "cspf_0_auto6712191430340163705", "cspf_0_auto9630050479180295296", "rr_3_fire" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "hall_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 6453.86, 10389.8, 778.47 ), ( 270, 83.47, 6.53 ), "cspf_0_auto9630050479180295296", "cspf_0_auto5606385283065104040", "rr_3_fire" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "hall_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 6399.35, 10389.9, 742.59 ), ( 270, 83.47, 6.53 ), "cspf_0_auto5606385283065104040", undefined, "rr_3_fire" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "hall_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 6200.36, 10198.1, 728.56 ), ( 270, 277.99, -7.99 ), "cspf_0_auto9214924227794941246", "cspf_0_auto12098813412302152591", "rr_3_fire" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "hall_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 6151.08, 10389, 742.59 ), ( 270, 83.47, 6.53 ), "cspf_0_auto17352254607262880111", undefined, "rr_3_fire" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "hall_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 6040.06, 10198.9, 780.55 ), ( 270, 277.99, -7.99 ), "cspf_0_auto17352254607262880111", undefined, "rr_3_fire" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "hall_fire";
    fe [[ f ]]( s, us, cf, ( 5436.16, 10353.2, 671.5 ), ( 0, 0, 0 ), "cspf_0_auto17313455358568318714", "cspf_0_auto482590571470470312", "rr_3_fire", undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "interacts";
    fe [[ f ]]( s, us, cf, ( 7216.59, 10461.7, 733.87 ), ( 0, 0, 0 ), "rr_3_swr_complete" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "interacts";
    fe [[ f ]]( s, us, cf, ( 7198.92, 10128.7, 733.87 ), ( 0, 180, 0 ), "rr_3_swr_incomplete" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "hall_fire";
    fe [[ f ]]( s, us, cf, ( 5874.44, 10345.3, 671.5 ), ( 0, 0, 0 ), "cspf_0_auto18221978626478287425", undefined, "rr_3_fire", undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    fe [[ f ]]( s, us, cf, ( -559.23, 5729.05, 346.2 ), ( 0, 0, 0 ), "sean_base" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    fe [[ f ]]( s, us, cf, ( -557.28, 5732.54, 343.1 ), ( 282.55, 140.64, -35.07 ), "rutherford_pickup" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "hall_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 5687.88, 10198.4, 733.76 ), ( 270, 277.99, -7.99 ), "cspf_0_auto4837017982076729706", "cspf_0_auto17805087451565901480", "rr_3_fire" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "hall_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 5594.42, 10198.6, 733.76 ), ( 270, 277.99, -7.99 ), "cspf_0_auto17805087451565901480", "cspf_0_auto2820709765704855623", "rr_3_fire" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "hall_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 5529.95, 10389.1, 782.93 ), ( 270, 83.47, 6.53 ), "cspf_0_auto17313455358568318714", undefined, "rr_3_fire" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "hall_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 5353.52, 10251.9, 779.64 ), ( 270, 83.41, 96.59 ), "cspf_0_auto2820709765704855623", undefined, "rr_3_fire" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "hall_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 5353.8, 10326.1, 828.32 ), ( 270, 83.41, 96.59 ), "cspf_0_auto482590571470470312", undefined, "rr_3_fire" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "hall_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 6752.82, 10197.8, 764.16 ), ( 270, 263.91, 6.09 ), "cspf_0_auto1311702209887841225", "cspf_0_auto1311702209887841225", "rr_3_fire" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "hall_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 6621.03, 10197.8, 725.17 ), ( 270, 277.99, -7.99 ), "cspf_0_auto11533934137942370087", undefined, "rr_3_fire" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "hall_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 6749.67, 10389.7, 773.64 ), ( 270, 83.47, 6.53 ), "cspf_0_auto14372651936559091952", undefined, "rr_3_fire" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "hall_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 6226.79, 10197.8, 771.01 ), ( 270, 277.99, -7.99 ), "cspf_0_auto12098813412302152591", undefined, "rr_3_fire" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "hall_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 5710.06, 10198.1, 775.1 ), ( 270, 277.99, -7.99 ), "cspf_0_auto17805087451565901480", undefined, "rr_3_fire" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.script_scenescriptbundle = "t10_cin_zm_vig_plr_dth_zmb_duo_01_global";
    fe [[ f ]]( s, us, cf, ( 5392.57, 10292.3, 671.5 ), ( 0, 225, 0 ), "t10_cin_zm_vig_plr_dth_zmb_duo_01_global" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "blockers";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 5544.85, 10277.5, 671.5 ), ( 0, 270, 0 ), "rr_3_block", undefined, "doorbuy_zm_sat_locust_floating_debris_ashwood_04" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    fe [[ f ]]( s, us, cf, ( 5307.77, 10296, 671.5 ), ( 0, 0, 0 ), "cspf_0_auto15027842417102113159" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    fe [[ f ]]( s, us, cf, ( 5307.52, 10256.1, 671.5 ), ( 0, 0, 0 ), "cspf_0_auto17243788163029647961" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    fe [[ f ]]( s, us, cf, ( 5308.02, 10340.9, 671.5 ), ( 0, 0, 0 ), "cspf_0_auto15027842417102113159" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    fe [[ f ]]( s, us, cf, ( 5267.5, 10222.6, 671.5 ), ( 0, 0, 0 ), "cspf_0_auto17243788163029647961" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    fe [[ f ]]( s, us, cf, ( 5271.64, 10290.9, 671.5 ), ( 0, 0, 0 ), "cspf_0_auto17243788163029647961" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    fe [[ f ]]( s, us, cf, ( 5239.07, 10323.7, 671.5 ), ( 0, 0, 0 ), "cspf_0_auto15027842417102113159" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    fe [[ f ]]( s, us, cf, ( 5269.61, 10360.1, 671.5 ), ( 0, 0, 0 ), "cspf_0_auto15027842417102113159" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    fe [[ f ]]( s, us, cf, ( 5320.98, 10214.9, 671.5 ), ( 0, 0, 0 ), "cspf_0_auto17243788163029647961" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    fe [[ f ]]( s, us, cf, ( 5238.94, 10257.1, 671.5 ), ( 0, 0, 0 ), "cspf_0_auto17243788163029647961" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    fe [[ f ]]( s, us, cf, ( 5319.86, 10379.2, 671.5 ), ( 0, 0, 0 ), "cspf_0_auto15027842417102113159" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "side_doors";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 5354.47, 10344.5, 719.25 ), ( 0, 0, 0 ), "rr_3_end", "cspf_0_auto15027842417102113159", "right" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "side_doors";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 5354.72, 10246.3, 719.25 ), ( 0, 0, 0 ), "rr_3_end", "cspf_0_auto17243788163029647961", "left" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "dust_falling";
    fe [[ f ]]( s, us, cf, ( 6968, 10296, 872 ), ( 0, 0, 0 ), "dust_falling", undefined, "0" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "dust_falling";
    fe [[ f ]]( s, us, cf, ( 6688, 10296, 872 ), ( 0, 0, 0 ), "dust_falling", undefined, "0" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "dust_falling";
    fe [[ f ]]( s, us, cf, ( 6432, 10296, 872 ), ( 0, 0, 0 ), "dust_falling", undefined, "1" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "dust_falling";
    fe [[ f ]]( s, us, cf, ( 6296, 10296, 872 ), ( 0, 0, 0 ), "dust_falling", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "dust_falling";
    fe [[ f ]]( s, us, cf, ( 6172, 10296, 872 ), ( 0, 0, 0 ), "dust_falling", undefined, "2" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "dust_falling";
    fe [[ f ]]( s, us, cf, ( 6044, 10296, 872 ), ( 0, 0, 0 ), "dust_falling", undefined, "3" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "dust_falling";
    fe [[ f ]]( s, us, cf, ( 5916, 10296, 872 ), ( 0, 0, 0 ), "dust_falling", undefined, "3" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "dust_falling";
    fe [[ f ]]( s, us, cf, ( 5828, 10296, 872 ), ( 0, 0, 0 ), "dust_falling", undefined, "3" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "dust_falling";
    fe [[ f ]]( s, us, cf, ( 5660, 10296, 872 ), ( 0, 0, 0 ), "dust_falling", undefined, "3" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    fe [[ f ]]( s, us, cf, ( 7226.62, 10429.5, 671.5 ), ( 0, 68.23, 0 ), "cspf_0_auto855142197185669429", "cspf_0_auto5658559996543615710", undefined, undefined, undefined, undefined, undefined, 125 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "dust_falling";
    fe [[ f ]]( s, us, cf, ( 5748, 10296, 872 ), ( 0, 0, 0 ), "dust_falling", undefined, "3" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "dust_falling";
    fe [[ f ]]( s, us, cf, ( 5596, 10296, 872 ), ( 0, 0, 0 ), "dust_falling", undefined, "3" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "dust_falling";
    fe [[ f ]]( s, us, cf, ( 5532, 10296, 872 ), ( 0, 0, 0 ), "dust_falling", undefined, "3" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "dust_falling";
    fe [[ f ]]( s, us, cf, ( 5460, 10296, 872 ), ( 0, 0, 0 ), "dust_falling", undefined, "3" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "dust_falling";
    fe [[ f ]]( s, us, cf, ( 5360, 10296, 872 ), ( 0, 0, 0 ), "dust_falling", undefined, "3" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    fe [[ f ]]( s, us, cf, ( 7318.37, 10359.5, 671.5 ), ( 0, 326.94, 0 ), "rr_3_timeout_fire", "cspf_0_auto855142197185669429", undefined, undefined, undefined, undefined, undefined, 125 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    fe [[ f ]]( s, us, cf, ( 7326.32, 10219.2, 671.5 ), ( 0, 173.57, 0 ), "cspf_0_auto855142197185669429", "cspf_0_auto14589136833733214393", undefined, undefined, undefined, undefined, undefined, 125 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    fe [[ f ]]( s, us, cf, ( 7232.84, 10154.7, 671.5 ), ( 0, 338.86, 0 ), "cspf_0_auto14589136833733214393", "cspf_0_auto14759660306643542256", undefined, undefined, undefined, undefined, undefined, 125 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    fe [[ f ]]( s, us, cf, ( 7191.12, 10272, 671.5 ), ( 0, 115.18, 0 ), "cspf_0_auto5658559996543615710", undefined, undefined, undefined, undefined, undefined, undefined, 125 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    fe [[ f ]]( s, us, cf, ( 7063.75, 10230, 671.5 ), ( 0, 115.18, 0 ), "cspf_0_auto14759660306643542256", "cspf_0_auto18296786807391830163", undefined, undefined, undefined, undefined, undefined, 125 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    fe [[ f ]]( s, us, cf, ( 7084.45, 10363.8, 671.5 ), ( 0, 115.18, 0 ), "cspf_0_auto5658559996543615710", undefined, undefined, undefined, undefined, undefined, undefined, 125 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    fe [[ f ]]( s, us, cf, ( 6951.03, 10297.3, 671.5 ), ( 0, 227.19, 0 ), "cspf_0_auto18296786807391830163", "cspf_0_auto11793150088916536361", undefined, undefined, undefined, undefined, undefined, 125 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    fe [[ f ]]( s, us, cf, ( 6843.02, 10331.3, 671.5 ), ( 0, 58, 0 ), "cspf_0_auto11793150088916536361", "cspf_0_auto9190958804178377483", undefined, undefined, undefined, undefined, undefined, 125 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    fe [[ f ]]( s, us, cf, ( 6743, 10273.6, 671.5 ), ( 0, 189.64, 0 ), "cspf_0_auto9190958804178377483", "cspf_0_auto3130977721245699911", undefined, undefined, undefined, undefined, undefined, 125 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    fe [[ f ]]( s, us, cf, ( 6620.62, 10245.9, 671.5 ), ( 0, 232.13, 0 ), "cspf_0_auto3130977721245699911", undefined, undefined, undefined, undefined, undefined, undefined, 125 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    fe [[ f ]]( s, us, cf, ( 6600.03, 10347.4, 671.5 ), ( 0, 313.19, 0 ), "cspf_0_auto3130977721245699911", "cspf_0_auto4453526055913246848", undefined, undefined, undefined, undefined, undefined, 125 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    fe [[ f ]]( s, us, cf, ( 6498.55, 10271, 671.5 ), ( 0, 30.72, 0 ), "cspf_0_auto4453526055913246848", "cspf_0_auto14849486352392881919", undefined, undefined, undefined, undefined, undefined, 125 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    fe [[ f ]]( s, us, cf, ( 6432.82, 10339.3, 671.5 ), ( 0, 180.31, 0 ), "cspf_0_auto14849486352392881919", "cspf_0_auto721833567593044204", undefined, undefined, undefined, undefined, undefined, 125 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    fe [[ f ]]( s, us, cf, ( 6312.23, 10321.7, 671.5 ), ( 0, 301.78, 0 ), "cspf_0_auto721833567593044204", "cspf_0_auto695162968960845719", undefined, undefined, undefined, undefined, undefined, 125 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    fe [[ f ]]( s, us, cf, ( 6228.99, 10273.9, 671.5 ), ( 0, 13.19, 0 ), "cspf_0_auto695162968960845719", "cspf_0_auto7993391809509172281", undefined, undefined, undefined, undefined, undefined, 125 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    fe [[ f ]]( s, us, cf, ( 6128.31, 10318.9, 671.5 ), ( 0, 18.42, 0 ), "cspf_0_auto7993391809509172281", "cspf_0_auto9860245443223368595", undefined, undefined, undefined, undefined, undefined, 125 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    fe [[ f ]]( s, us, cf, ( 6054.4, 10239.6, 671.5 ), ( 0, 53.09, 0 ), "cspf_0_auto7993391809509172281", "cspf_0_auto8062416880762358829", undefined, undefined, undefined, undefined, undefined, 125 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    fe [[ f ]]( s, us, cf, ( 5957.78, 10316.1, 671.5 ), ( 0, 48.47, 0 ), "cspf_0_auto8062416880762358829", "cspf_0_auto469747637644475544", undefined, undefined, undefined, undefined, undefined, 125 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    fe [[ f ]]( s, us, cf, ( 5842.05, 10267.6, 671.5 ), ( 0, 210.59, 0 ), "cspf_0_auto469747637644475544", "cspf_0_auto10613124936478349784", undefined, undefined, undefined, undefined, undefined, 125 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    fe [[ f ]]( s, us, cf, ( 5762.77, 10331.7, 671.5 ), ( 0, 322.76, 0 ), "cspf_0_auto469747637644475544", "cspf_0_auto8941761827901596625", undefined, undefined, undefined, undefined, undefined, 125 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    fe [[ f ]]( s, us, cf, ( 5645.62, 10266.6, 671.5 ), ( 0, 10.47, 0 ), "cspf_0_auto8941761827901596625", "cspf_0_auto9406368892980332351", undefined, undefined, undefined, undefined, undefined, 125 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    fe [[ f ]]( s, us, cf, ( 5519.62, 10281.9, 671.5 ), ( 0, 44.87, 0 ), "cspf_0_auto9406368892980332351", "cspf_0_auto5536437414563927049", undefined, undefined, undefined, undefined, undefined, 125 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    fe [[ f ]]( s, us, cf, ( 5410.3, 10247, 671.5 ), ( 0, 258.69, 0 ), "cspf_0_auto5536437414563927049", undefined, undefined, undefined, undefined, undefined, undefined, 125 );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 6922.1, 10389.5, 760.45 ), ( 270, 83.47, 6.53 ), "cspf_0_auto11793150088916536361" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 6934.51, 10197.6, 727.24 ), ( 270, 263.91, 6.09 ), "cspf_0_auto11793150088916536361" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 6819.06, 10197.3, 770.15 ), ( 270, 263.91, 6.09 ), "cspf_0_auto9190958804178377483" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 6789.75, 10389.2, 712.24 ), ( 270, 83.47, 6.53 ), "cspf_0_auto9190958804178377483" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 6653.57, 10389, 750.46 ), ( 270, 83.47, 6.53 ), "cspf_0_auto4453526055913246848" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 6488.63, 10197, 777.26 ), ( 270, 263.91, 6.09 ), "cspf_0_auto14849486352392881919" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 6214.52, 10388.7, 738.94 ), ( 270, 83.47, 6.53 ), "cspf_0_auto7993391809509172281" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 6049.46, 10388.5, 782.35 ), ( 270, 83.47, 6.53 ), "cspf_0_auto9860245443223368595" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 5939.51, 10388.2, 727.43 ), ( 270, 83.47, 6.53 ), "cspf_0_auto469747637644475544" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 5889.41, 10388, 761.47 ), ( 270, 83.47, 6.53 ), "cspf_0_auto469747637644475544" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 5718.7, 10387.8, 772.62 ), ( 270, 83.47, 6.53 ), "cspf_0_auto8941761827901596625" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 5633.75, 10387.5, 727.36 ), ( 270, 83.47, 6.53 ), "cspf_0_auto9406368892980332351" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 6400.68, 10196.8, 732.03 ), ( 270, 263.91, 6.09 ), "cspf_0_auto721833567593044204" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 6297.32, 10196.5, 780.24 ), ( 270, 263.91, 6.09 ), "cspf_0_auto695162968960845719" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 6132.83, 10196.2, 750 ), ( 270, 263.91, 6.09 ), "cspf_0_auto9860245443223368595" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 5963.57, 10195.9, 727.81 ), ( 270, 263.91, 6.09 ), "cspf_0_auto8062416880762358829", "cspf_0_auto15702713213833340738" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 5933.51, 10195.6, 764.31 ), ( 270, 263.91, 6.09 ), "cspf_0_auto15702713213833340738" );
    s = {};
    s.script_cs_flag = "zm_sat_locust_ee_richtofen_cs";
    s.groupid = "timeout_fire";
    s.script_label = "wall";
    fe [[ f ]]( s, us, cf, ( 5856.44, 10195.3, 727.83 ), ( 270, 263.91, 6.09 ), "cspf_0_auto10613124936478349784" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_locust_ee_richtofen_cs
// Params 0, eflags: 0x4
// Checksum 0xbfbce79a, Offset: 0x4df8
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_locust_ee_richtofen_cs
// Params 0
// Checksum 0xab67fafd, Offset: 0x4e02
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_locust_ee_richtofen_cs" );
}

