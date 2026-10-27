// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_ltm_echo_cs.gsc  (hash_692a327a68604abe.gscc) (size: 11920 Bytes / 0x2e90 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4a4ab62d (1246410285)
// size ...... 11920 (0x2e90)
// includes .. 2   (offset: 0x28ac)
// strings ... 27  (offset: 0x28bc)
// dev strs .. 0   (offset: 0x2e90)
// exports ... 6   (offset: 0x251c)
// cseg ...... 0x2b2 + 0x226a (0x251c)
// imports ... 17  (offset: 0x260c)
// animtree1 . 0   (offset: 0x2e90)
// animtree2 . 0   (offset: 0x2e90)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_ruby_ltm_echo_cs;

// Namespace zm_sat_ruby_ltm_echo_cs
// Params 2
// Checksum 0x107f842a, Offset: 0x2d0
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_ruby_ltm_echo_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_ruby_ltm_echo_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_ruby_ltm_echo_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_ruby_ltm_echo_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_ruby_ltm_echo_cs
// Params 3, eflags: 0x4
// Checksum 0x231466ac, Offset: 0x358
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_ruby_ltm_echo_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_ruby_ltm_echo_cs" );
}

// Namespace zm_sat_ruby_ltm_echo_cs
// Params 3, eflags: 0x4
// Checksum 0x14bce3e3, Offset: 0x3d2
// Size: 0x212a
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 4352.54, -216.71, -48.26 ), ( 0, 114.3, 0 ), "echo_portal_spawn", undefined, "cliffside" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 4425.45, -183.79, -47.09 ), ( 0, 114.3, 0 ), "echo_portal_spawn", undefined, "cliffside" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 4279.62, -249.62, -47.8 ), ( 0, 114.35, 0 ), "echo_portal_spawn", undefined, "cliffside" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 4571.27, -117.95, -47.73 ), ( 0, 114.3, 0 ), "echo_portal_spawn", undefined, "cliffside" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 4498.36, -150.86, -49.08 ), ( 0, 114.3, 0 ), "echo_portal_spawn", undefined, "cliffside" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 4415.74, -162.11, -34.08 ), ( 0, 215.32, 0 ), "player_echo_reward_point", "cspf_0_auto5119450679971373829", "cliffside" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 4274.82, -2.29, -47.19 ), ( 0, 308.7, 0 ), "cspf_0_auto5119450679971373829" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 4434.94, 61.77, -50.49 ), ( 0, 268.29, 0 ), "cspf_0_auto5119450679971373829" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 4203.49, -34.84, -45.36 ), ( 0, 322.04, 0 ), "cspf_0_auto5119450679971373829" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 4361.6, 27.12, -48.29 ), ( 0, 284.47, 0 ), "cspf_0_auto5119450679971373829" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 2808.07, 1056.71, -36.69 ), ( 0, 326.3, 0 ), "echo_portal_spawn", undefined, "cliffside2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 2763.69, 990.15, -38.94 ), ( 0, 326.3, 0 ), "echo_portal_spawn", undefined, "cliffside2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 2852.47, 1123.25, -43.63 ), ( 0, 326.35, 0 ), "echo_portal_spawn", undefined, "cliffside2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 2674.91, 857.04, -24.25 ), ( 0, 326.3, 0 ), "echo_portal_spawn", undefined, "cliffside2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 2719.3, 923.59, -34.9 ), ( 0, 326.3, 0 ), "echo_portal_spawn", undefined, "cliffside2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 2783.41, 976.91, -21.05 ), ( 0, 67.32, 0 ), "player_echo_reward_point", "cspf_0_auto8732286565942601196", "cliffside2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 2987.61, 916.05, -44.44 ), ( 0, 160.7, 0 ), "cspf_0_auto8732286565942601196" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 2885.77, 776.87, -39.71 ), ( 0, 120.29, 0 ), "cspf_0_auto8732286565942601196" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 3030.85, 981.45, -47.73 ), ( 0, 174.04, 0 ), "cspf_0_auto8732286565942601196" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 2929.6, 845.12, -40.71 ), ( 0, 136.47, 0 ), "cspf_0_auto8732286565942601196" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 2447.93, -186.61, 51.24 ), ( 0, 240.3, 0 ), "echo_portal_spawn", undefined, "courtyard" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 2378.44, -146.97, 51.26 ), ( 0, 240.3, 0 ), "echo_portal_spawn", undefined, "courtyard" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 2517.41, -226.26, 51.29 ), ( 0, 240.34, 0 ), "echo_portal_spawn", undefined, "courtyard" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 2239.46, -67.7, 51.3 ), ( 0, 240.3, 0 ), "echo_portal_spawn", undefined, "courtyard" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 2308.95, -107.34, 51.95 ), ( 0, 240.3, 0 ), "echo_portal_spawn", undefined, "courtyard" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 2366.61, -167.58, 113.04 ), ( 0, 341.32, 0 ), "player_echo_reward_point", "cspf_0_auto15562749280655818551", "courtyard" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 2343.15, -316.53, 54.75 ), ( 0, 74.7, 0 ), "cspf_0_auto15562749280655818551" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 2204.2, -224.64, 52.65 ), ( 0, 34.29, 0 ), "cspf_0_auto15562749280655818551" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 2425.4, -330.1, 50.8 ), ( 0, 88.04, 0 ), "cspf_0_auto15562749280655818551" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( -3056.69, -435.68, -13.74 ), ( 0, 62, 0 ), "echo_portal_spawn", undefined, "start" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( -2986.06, -473.24, -21.63 ), ( 0, 62, 0 ), "echo_portal_spawn", undefined, "start" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( -3127.33, -398.12, -10.01 ), ( 0, 62, 0 ), "echo_portal_spawn", undefined, "start" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( -2845.72, -550.12, -11.31 ), ( 0, 62, 0 ), "echo_portal_spawn", undefined, "start" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( -2916.36, -512.56, -12.36 ), ( 0, 62, 0 ), "echo_portal_spawn", undefined, "start" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 2268.34, -263.6, 50.13 ), ( 0, 50.47, 0 ), "cspf_0_auto15562749280655818551" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 4462.5, -692.89, 16.5 ), ( 0, 262.3, 0 ), "echo_portal_spawn", undefined, "telescope" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 4383.22, -682.18, 16 ), ( 0, 262.3, 0 ), "echo_portal_spawn", undefined, "telescope" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 4541.77, -703.63, 16.5 ), ( 0, 262.35, 0 ), "echo_portal_spawn", undefined, "telescope" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 4224.67, -660.74, 16.5 ), ( 0, 262.3, 0 ), "echo_portal_spawn", undefined, "telescope" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 4303.94, -671.46, 16.5 ), ( 0, 262.3, 0 ), "echo_portal_spawn", undefined, "telescope" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 4379.97, -705.71, 16 ), ( 0, 3.32, 0 ), "player_echo_reward_point", "cspf_0_auto41427408555726232", "telescope" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 4378.79, -995.92, 61 ), ( 0, 92.7, 0 ), "cspf_0_auto41427408555726232" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 4331.05, -1035.4, 61 ), ( 0, 74.29, 0 ), "cspf_0_auto41427408555726232" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 4370.52, -1046.12, 60 ), ( 0, 92.04, 0 ), "cspf_0_auto41427408555726232" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 4335.6, -988.88, 61 ), ( 0, 72.47, 0 ), "cspf_0_auto41427408555726232" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 1430.79, -2791.92, 56 ), ( 0, 178.3, 0 ), "echo_portal_spawn", undefined, "orrery" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 1433.16, -2711.95, 56 ), ( 0, 178.3, 0 ), "echo_portal_spawn", undefined, "orrery" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 1432.71, -2854.55, 56 ), ( 0, 178.34, 0 ), "echo_portal_spawn", undefined, "orrery" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 1437.91, -2574.02, 56 ), ( 0, 178.3, 0 ), "echo_portal_spawn", undefined, "orrery" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 1441.53, -2631.98, 56 ), ( 0, 178.3, 0 ), "echo_portal_spawn", undefined, "orrery" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 1409.41, -2711.18, 74 ), ( 0, 279.32, 0 ), "player_echo_reward_point", "cspf_0_auto16321282705294011603", "orrery" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 1203.99, -2767.78, 64 ), ( 0, 12.7, 0 ), "cspf_0_auto16321282705294011603" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 1216.6, -2595.78, 72 ), ( 0, 332.29, 0 ), "cspf_0_auto16321282705294011603" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 1201.98, -2846.15, 72 ), ( 0, 26.04, 0 ), "cspf_0_auto16321282705294011603" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 1215.6, -2676.88, 64 ), ( 0, 348.47, 0 ), "cspf_0_auto16321282705294011603" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 4042.14, -42061.9, -12932 ), ( 0, 90.3, 0 ), "echo_portal_spawn", undefined, "mars" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 4122.14, -42026.5, -12932 ), ( 0, 90.3, 0 ), "echo_portal_spawn", undefined, "mars" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 3962.15, -42030.4, -12932 ), ( 0, 90.34, 0 ), "echo_portal_spawn", undefined, "mars" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 4282.14, -42028.7, -12932 ), ( 0, 90.3, 0 ), "echo_portal_spawn", undefined, "mars" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 4202.15, -42061.1, -12932 ), ( 0, 90.3, 0 ), "echo_portal_spawn", undefined, "mars" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 4122.08, -42005.8, -12916 ), ( 0, 191.32, 0 ), "player_echo_reward_point", "cspf_0_auto13176713343861881176", "mars" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 4058.35, -41802.4, -12932 ), ( 0, 284.7, 0 ), "cspf_0_auto13176713343861881176" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 4230.68, -41809.1, -12932 ), ( 0, 244.29, 0 ), "cspf_0_auto13176713343861881176" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 3979.96, -41803.2, -12932 ), ( 0, 298.04, 0 ), "cspf_0_auto13176713343861881176" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 4149.6, -41810.9, -12932 ), ( 0, 260.47, 0 ), "cspf_0_auto13176713343861881176" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( -853.06, -492.71, 252 ), ( 0, 6, 0 ), "echo_portal_spawn", undefined, "mainhall" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( -844.69, -572.27, 252 ), ( 0, 6, 0 ), "echo_portal_spawn", undefined, "mainhall" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( -861.4, -413.15, 252 ), ( 0, 6.05, 0 ), "echo_portal_spawn", undefined, "mainhall" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( -827.97, -731.4, 252 ), ( 0, 6, 0 ), "echo_portal_spawn", undefined, "mainhall" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( -836.33, -651.83, 252 ), ( 0, 6, 0 ), "echo_portal_spawn", undefined, "mainhall" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -821.06, -569.87, 276 ), ( 0, 107.02, 0 ), "player_echo_reward_point", "cspf_0_auto10196530458741599711", "mainhall" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -625.08, -486.25, 252 ), ( 0, 200.4, 0 ), "cspf_0_auto10196530458741599711" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -614.53, -658.39, 252 ), ( 0, 159.99, 0 ), "cspf_0_auto10196530458741599711" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -633.58, -408.31, 236 ), ( 0, 213.74, 0 ), "cspf_0_auto10196530458741599711" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -624.4, -577.88, 252 ), ( 0, 176.17, 0 ), "cspf_0_auto10196530458741599711" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 1634.26, 1684.96, 252 ), ( 0, 186, 0 ), "echo_portal_spawn", undefined, "planetarium" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 1625.89, 1764.52, 252 ), ( 0, 186, 0 ), "echo_portal_spawn", undefined, "planetarium" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 1642.6, 1605.39, 252 ), ( 0, 186.05, 0 ), "echo_portal_spawn", undefined, "planetarium" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 1609.17, 1923.64, 252 ), ( 0, 186, 0 ), "echo_portal_spawn", undefined, "planetarium" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 1617.53, 1844.08, 252 ), ( 0, 186, 0 ), "echo_portal_spawn", undefined, "planetarium" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 1602.26, 1762.11, 276 ), ( 0, 287.02, 0 ), "player_echo_reward_point", "cspf_0_auto7069225887097014494", "planetarium" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 1406.28, 1760.49, 252 ), ( 0, 358.4, 0 ), "cspf_0_auto7069225887097014494" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 1397.73, 1886.63, 252 ), ( 0, 339.99, 0 ), "cspf_0_auto7069225887097014494" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 1412.78, 1692.55, 252 ), ( 0, 13.74, 0 ), "cspf_0_auto7069225887097014494" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 1401.6, 1826.12, 252 ), ( 0, 356.17, 0 ), "cspf_0_auto7069225887097014494" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -1491.04, 679.44, 269.13 ), ( 0, 343.32, 0 ), "curse_inducer", undefined, "start" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 401.96, -584.56, 279.13 ), ( 0, 185.32, 0 ), "curse_inducer", undefined, "mainhall" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 1120.96, -1700.56, 227.13 ), ( 0, 267.32, 0 ), "curse_inducer", undefined, "orrery" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 1534.96, -90.56, 137.13 ), ( 0, 249.32, 0 ), "curse_inducer", undefined, "courtyard" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 3666.96, -1668.56, 49.13 ), ( 0, 353.32, 0 ), "curse_inducer", undefined, "telescope" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 2634.96, 740.44, 1.13 ), ( 0, 61.71, 0 ), "curse_inducer", undefined, "cliffside" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 934.96, 2053.44, 329.13 ), ( 0, 21.32, 0 ), "curse_inducer", undefined, "planetarium" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 4120.96, -41265.6, -12770.9 ), ( 0, 90, 0 ), "curse_inducer", undefined, "mars" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -1615.71, 60.12, 193.76 ), ( 1.73, 234.97, 0.85 ), "loot_buddy_chompy" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -523.72, 1463.88, 252 ), ( 0, 278, 0 ), "loot_buddy_chompy" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -289.72, -176.12, 220 ), ( 0, 292, 0 ), "loot_buddy_chompy" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 1008.28, -2388.12, 72 ), ( 0, 264, 0 ), "loot_buddy_chompy" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 916.28, -212.12, 240.79 ), ( 0, 126, 0 ), "loot_buddy_chompy" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 4464.28, 788.88, -47 ), ( 0, 268, 0 ), "loot_buddy_chompy" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 4826.28, -661.12, 16 ), ( 0, 239.51, 0 ), "loot_buddy_chompy" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 4950.28, -42709.1, -12996 ), ( 0, 86, 0 ), "loot_buddy_chompy" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -2946.43, -435.51, -0.75 ), ( 0, 177.02, 0 ), "player_echo_reward_point", "cspf_0_auto2729693277323456838", "start" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -2936.59, -299.6, -28.36 ), ( 358.01, 272.14, 2.34 ), "cspf_0_auto2729693277323456838" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -2771, -348.57, -34.24 ), ( 1.44, 32.73, -0.99 ), "cspf_0_auto2729693277323456838" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -3012.47, -281.11, -24.66 ), ( 357.86, 153.51, 0.74 ), "cspf_0_auto2729693277323456838" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -2849.99, -330.36, -24.2 ), ( 1.63, 71.16, -1.36 ), "cspf_0_auto2729693277323456838" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( -1422.14, -161.64, 240 ), ( 0, 346, 0 ), "echo_portal_spawn", undefined, "start2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( -1441.49, -239.27, 240.38 ), ( 0, 346, 0 ), "echo_portal_spawn", undefined, "start2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( -1402.77, -84.02, 240 ), ( 0, 346.05, 0 ), "echo_portal_spawn", undefined, "start2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( -1480.2, -394.51, 238.66 ), ( 0, 346, 0 ), "echo_portal_spawn", undefined, "start2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( -1460.84, -316.89, 240.66 ), ( 0, 346, 0 ), "echo_portal_spawn", undefined, "start2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -1418.46, -245.09, 259.67 ), ( 0, 87.02, 0 ), "player_echo_reward_point", "cspf_0_auto9730177006438236041", "start2" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -1205.7, -233.54, 251.72 ), ( 0, 180.4, 0 ), "cspf_0_auto9730177006438236041" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -1254.66, -398.91, 244 ), ( 0, 139.99, 0 ), "cspf_0_auto9730177006438236041" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -1187.03, -157.39, 261.66 ), ( 0, 193.74, 0 ), "cspf_0_auto9730177006438236041" );
    s = {};
    s.script_cs_flag = "zm_sat_ruby_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -1236.4, -319.88, 244 ), ( 0, 156.17, 0 ), "cspf_0_auto9730177006438236041" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_ruby_ltm_echo_cs
// Params 0, eflags: 0x4
// Checksum 0x7a8f4c6c, Offset: 0x2504
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_ruby_ltm_echo_cs
// Params 0
// Checksum 0xe147bbe1, Offset: 0x250e
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_ruby_ltm_echo_cs" );
}

