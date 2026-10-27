// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ee_bat_cs.gsc  (hash_6d9bbce3e3f41c83.gscc) (size: 4113 Bytes / 0x1011 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcd258b2e (3441789742)
// size ...... 4113 (0x1011)
// includes .. 2   (offset: 0xdd5)
// strings ... 25  (offset: 0xde5)
// dev strs .. 0   (offset: 0x1011)
// exports ... 6   (offset: 0xb25)
// cseg ...... 0x205 + 0x920 (0xb25)
// imports ... 16  (offset: 0xc15)
// animtree1 . 0   (offset: 0x1011)
// animtree2 . 0   (offset: 0x1011)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_hornet_ee_bat_cs;

// Namespace zm_sat_hornet_ee_bat_cs
// Params 2
// Checksum 0x49953ec1, Offset: 0x223
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_hornet_ee_bat_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_hornet_ee_bat_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_hornet_ee_bat_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_hornet_ee_bat_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_hornet_ee_bat_cs
// Params 3, eflags: 0x4
// Checksum 0x7afedc47, Offset: 0x2ab
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_hornet_ee_bat_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_hornet_ee_bat_cs" );
}

// Namespace zm_sat_hornet_ee_bat_cs
// Params 3, eflags: 0x4
// Checksum 0x21c99af0, Offset: 0x325
// Size: 0x7e0
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_bat_cs";
    s.groupid = "corpse1";
    fe [[ f ]]( s, us, cf, ( 2269.53, -23763.3, 155.35 ), ( 345.49, 110.36, -83.1 ), "kb_dpos_tr", "cspf_0_auto10827454058858765934" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_bat_cs";
    s.groupid = "corpse1";
    fe [[ f ]]( s, us, cf, ( 2276.81, -23741.6, 157.99 ), ( 287.99, 281.72, 44.5 ), "cspf_0_auto3449471892280867051", undefined, "vmini_la" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_bat_cs";
    s.groupid = "corpse1";
    fe [[ f ]]( s, us, cf, ( 2267.72, -23781.2, 149.68 ), ( 314.94, 22.54, -82.59 ), "cspf_0_auto16274745140250054717", "cspf_0_auto627673969656277796", "vmini_rl" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_bat_cs";
    s.groupid = "isl_sp";
    fe [[ f ]]( s, us, cf, ( -8828.46, -15.88, 166.39 ), ( 353.32, 167.96, -0.1 ), "zs_kju_sp", "zs_kju_att" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_bat_cs";
    s.groupid = "watch";
    fe [[ f ]]( s, us, cf, ( -8984.98, 328.1, 156.43 ), ( 351.13, 210.04, -1.24 ), "ab_sp_watch" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_bat_cs";
    s.groupid = "isl_sp";
    fe [[ f ]]( s, us, cf, ( -9194.3, 632.23, 172.15 ), ( 348.93, 298.63, -0 ), "ab_kju_sp", "ab_kju_att" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_bat_cs";
    s.groupid = "watch";
    fe [[ f ]]( s, us, cf, ( -8983.76, 323.12, 156.61 ), ( 351.13, 186.74, -1.24 ), "ab_sp_watch" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_bat_cs";
    s.groupid = "watch";
    fe [[ f ]]( s, us, cf, ( -8988.98, 332.1, 156.43 ), ( 351.13, 210.04, -1.24 ), "ab_sp_watch" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_bat_cs";
    s.groupid = "watch";
    fe [[ f ]]( s, us, cf, ( -8992.11, 335.42, 157.01 ), ( 351.13, 231.94, -1.24 ), "ab_sp_watch" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_bat_cs";
    s.groupid = "isl_sp";
    fe [[ f ]]( s, us, cf, ( -9290.72, 86.7, 172.63 ), ( 349.7, 55.35, -1.53 ), "rr_isl_sp" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_bat_cs";
    s.groupid = "corpse1";
    fe [[ f ]]( s, us, cf, ( 2251.01, -23757.8, 158.04 ), ( 339.71, 5.31, -69.54 ), "cspf_0_auto10827454058858765934", "cspf_0_auto16274745140250054717", "vmini_ra" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_bat_cs";
    s.groupid = "corpse1";
    fe [[ f ]]( s, us, cf, ( 2289.97, -23774.8, 151.09 ), ( 358.8, 36.45, -85.47 ), "cspf_0_auto627673969656277796", "cspf_0_auto3449471892280867051", "vmini_ll" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_bat_cs";
    s.is_cs_trigger = 1;
    s.is_cs_noent_volume = 1;
    s.height = 300;
    fe [[ f ]]( s, us, cf, ( 287, -20691, 639 ), ( 0, 0, 0 ), "disallow_rr_area", undefined, undefined, undefined, undefined, undefined, undefined, 128 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_bat_cs";
    s.groupid = "isl_sp";
    fe [[ f ]]( s, us, cf, ( -8927.69, 89.72, 190.01 ), ( 353.32, 167.96, -0.1 ), "zs_kju_att" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_bat_cs";
    fe [[ f ]]( s, us, cf, ( 2307, -24205, -14 ), ( 356.18, 79.44, 7.82 ), "bat_kl_init_sp" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_bat_cs";
    s.groupid = "isl_sp";
    fe [[ f ]]( s, us, cf, ( -9107.44, 495.21, 196.1 ), ( 348.93, 323.33, 0 ), "ab_kju_att" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_bat_cs";
    s.groupid = "spwn";
    fe [[ f ]]( s, us, cf, ( 2204.95, -24240.8, -58 ), ( 0, 16.44, 0 ), "bat_kl_ex_sp" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_bat_cs";
    s.groupid = "spwn";
    fe [[ f ]]( s, us, cf, ( 2164.49, -24150.4, -58 ), ( 0, 16.44, 0 ), "bat_kl_ex_sp" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_bat_cs";
    s.groupid = "spwn";
    fe [[ f ]]( s, us, cf, ( 2184.62, -24191.8, -58 ), ( 0, 16.44, 0 ), "bat_kl_ex_sp" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_bat_cs";
    s.groupid = "spwn";
    fe [[ f ]]( s, us, cf, ( 2144.17, -24101.4, -58 ), ( 0, 16.44, 0 ), "bat_kl_ex_sp" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_bat_cs";
    s.groupid = "spwn";
    fe [[ f ]]( s, us, cf, ( 2420.93, -24321.4, -58 ), ( 0, 82.64, 0 ), "bat_kl_ex_sp" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_bat_cs";
    s.groupid = "spwn";
    fe [[ f ]]( s, us, cf, ( 2321.92, -24322, -58 ), ( 0, 82.64, 0 ), "bat_kl_ex_sp" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_bat_cs";
    s.groupid = "spwn";
    fe [[ f ]]( s, us, cf, ( 2367.91, -24320.3, -58 ), ( 0, 82.64, 0 ), "bat_kl_ex_sp" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ee_bat_cs";
    s.groupid = "spwn";
    fe [[ f ]]( s, us, cf, ( 2268.9, -24320.8, -58 ), ( 0, 82.64, 0 ), "bat_kl_ex_sp" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_hornet_ee_bat_cs
// Params 0, eflags: 0x4
// Checksum 0x25e79b5, Offset: 0xb0d
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_hornet_ee_bat_cs
// Params 0
// Checksum 0xb8ad010a, Offset: 0xb17
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_hornet_ee_bat_cs" );
}

