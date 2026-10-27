// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ltm_echo_cs.gsc  (hash_5803e34c2aa664ce.gscc) (size: 10059 Bytes / 0x274b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9b73ee81 (2608066177)
// size ...... 10059 (0x274b)
// includes .. 2   (offset: 0x225f)
// strings ... 23  (offset: 0x226f)
// dev strs .. 0   (offset: 0x274b)
// exports ... 6   (offset: 0x1ef7)
// cseg ...... 0x253 + 0x1ca4 (0x1ef7)
// imports ... 17  (offset: 0x1fe7)
// animtree1 . 0   (offset: 0x274b)
// animtree2 . 0   (offset: 0x274b)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_hornet_ltm_echo_cs;

// Namespace zm_sat_hornet_ltm_echo_cs
// Params 2
// Checksum 0xaa97bfb6, Offset: 0x271
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_hornet_ltm_echo_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_hornet_ltm_echo_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_hornet_ltm_echo_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_hornet_ltm_echo_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_hornet_ltm_echo_cs
// Params 3, eflags: 0x4
// Checksum 0x99fc5d30, Offset: 0x2f9
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_hornet_ltm_echo_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_hornet_ltm_echo_cs" );
}

// Namespace zm_sat_hornet_ltm_echo_cs
// Params 3, eflags: 0x4
// Checksum 0x2e0d820, Offset: 0x373
// Size: 0x1b64
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 33.96, -22511.5, 171.67 ), ( 0, 226.19, 0 ), "echo_portal_spawn", undefined, "stables" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( -23.68, -22456.2, 162.84 ), ( 0, 226.19, 0 ), "echo_portal_spawn", undefined, "stables" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 91.78, -22566.9, 181.37 ), ( 0, 226.24, 0 ), "echo_portal_spawn", undefined, "stables" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( -139.17, -22345.3, 154.03 ), ( 0, 226.19, 0 ), "echo_portal_spawn", undefined, "stables" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( -81.43, -22400.8, 155.84 ), ( 0, 226.19, 0 ), "echo_portal_spawn", undefined, "stables" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -67.71, -22505.5, 199.66 ), ( 0, 327.22, 0 ), "player_echo_reward_point", "cspf_0_auto7921758555593595005", "stables" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -145.67, -22652.7, 139.62 ), ( 0, 60.6, 0 ), "cspf_0_auto7921758555593595005" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -264.76, -22528.2, 135.84 ), ( 0, 20.18, 0 ), "cspf_0_auto7921758555593595005" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -88.84, -22706.7, 143.67 ), ( 0, 73.94, 0 ), "cspf_0_auto7921758555593595005" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -205.31, -22583.2, 137.35 ), ( 0, 36.37, 0 ), "cspf_0_auto7921758555593595005" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -2210.7, -23391.2, 171.57 ), ( 0, 66, 0 ), "loot_buddy_chompy" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 296.7, -22488, 217.13 ), ( 0, 179.73, 0 ), "curse_inducer", undefined, "stables" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( -2899.7, -22665, 127.43 ), ( 0, 84.2, 0 ), "echo_portal_spawn", undefined, "training" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( -2820.22, -22673.1, 128 ), ( 0, 84.2, 0 ), "echo_portal_spawn", undefined, "training" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( -2979.4, -22656.9, 129.88 ), ( 0, 84.24, 0 ), "echo_portal_spawn", undefined, "training" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( -2660.95, -22689.4, 128 ), ( 0, 84.2, 0 ), "echo_portal_spawn", undefined, "training" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( -2740.63, -22681.2, 128 ), ( 0, 84.2, 0 ), "echo_portal_spawn", undefined, "training" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -2815.9, -22607.2, 172 ), ( 0, 185.22, 0 ), "player_echo_reward_point", "cspf_0_auto13540515169575577221", "training" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -2845.11, -22443.1, 130.8 ), ( 0, 278.6, 0 ), "cspf_0_auto13540515169575577221" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -2674.57, -22468, 135.94 ), ( 0, 238.18, 0 ), "cspf_0_auto13540515169575577221" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -2923.15, -22435.6, 128 ), ( 0, 291.94, 0 ), "cspf_0_auto13540515169575577221" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -2755.31, -22461.2, 128 ), ( 0, 254.37, 0 ), "cspf_0_auto13540515169575577221" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -3528.7, -21869.2, 52 ), ( 0, 10.41, 4 ), "loot_buddy_chompy" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -1409.3, -21790, 289.13 ), ( 0, 89.73, 0 ), "curse_inducer", undefined, "training" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( -470.07, -20960.1, 533.06 ), ( 0, 358.19, 0 ), "echo_portal_spawn", undefined, "central" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( -472.6, -21039.9, 525.22 ), ( 0, 358.19, 0 ), "echo_portal_spawn", undefined, "central" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( -467.59, -20880, 537.74 ), ( 0, 358.24, 0 ), "echo_portal_spawn", undefined, "central" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( -477.74, -21199.9, 523.49 ), ( 0, 358.19, 0 ), "echo_portal_spawn", undefined, "central" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( -475.13, -21119.9, 523.48 ), ( 0, 358.19, 0 ), "echo_portal_spawn", undefined, "central" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -406.5, -21039.6, 592.23 ), ( 0, 99.22, 0 ), "player_echo_reward_point", "cspf_0_auto8108665138955276030", "central" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -244.94, -20999.1, 548.92 ), ( 0, 192.6, 0 ), "cspf_0_auto8108665138955276030" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -257.78, -21170.9, 531.06 ), ( 0, 152.18, 0 ), "cspf_0_auto8108665138955276030" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -242.84, -20920.7, 555.07 ), ( 0, 205.94, 0 ), "cspf_0_auto8108665138955276030" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -256.69, -21089.9, 544.22 ), ( 0, 168.37, 0 ), "cspf_0_auto8108665138955276030" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -630.3, -20508, 589.13 ), ( 0, 357.73, 0 ), "curse_inducer", undefined, "central" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 1275.3, -21007.2, 512.03 ), ( 0, 162.41, 4 ), "loot_buddy_chompy" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 3120.67, -22524.1, 257.64 ), ( 0, 268.19, 0 ), "echo_portal_spawn", undefined, "garden" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 3040.83, -22521.6, 258.38 ), ( 0, 268.19, 0 ), "echo_portal_spawn", undefined, "garden" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 3200.71, -22526.6, 257.87 ), ( 0, 268.24, 0 ), "echo_portal_spawn", undefined, "garden" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 2880.81, -22516.4, 261.9 ), ( 0, 268.19, 0 ), "echo_portal_spawn", undefined, "garden" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 2960.85, -22519.1, 258.26 ), ( 0, 268.19, 0 ), "echo_portal_spawn", undefined, "garden" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 3041.1, -22587.7, 304.39 ), ( 0, 9.22, 0 ), "player_echo_reward_point", "cspf_0_auto11002578452968005295", "garden" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 3081.66, -22749.2, 256.18 ), ( 0, 102.6, 0 ), "cspf_0_auto11002578452968005295" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 2909.85, -22736.4, 234.28 ), ( 0, 62.18, 0 ), "cspf_0_auto11002578452968005295" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 3160.03, -22751.3, 258.2 ), ( 0, 115.94, 0 ), "cspf_0_auto11002578452968005295" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 2990.84, -22737.5, 245.4 ), ( 0, 78.37, 0 ), "cspf_0_auto11002578452968005295" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 1762.7, -22486, 270.13 ), ( 0, 13.73, 0 ), "curse_inducer", undefined, "garden" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 3639.3, -23727.2, 61.84 ), ( 350.48, 162.21, 1.22 ), "loot_buddy_chompy" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 2893.57, -20830.4, 387.27 ), ( 0, 164.19, 0 ), "echo_portal_spawn", undefined, "kitchens" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 2915.34, -20753.6, 383.07 ), ( 0, 164.19, 0 ), "echo_portal_spawn", undefined, "kitchens" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 2871.81, -20907.5, 391.05 ), ( 0, 164.24, 0 ), "echo_portal_spawn", undefined, "kitchens" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 2959.05, -20599.5, 382.99 ), ( 0, 164.19, 0 ), "echo_portal_spawn", undefined, "kitchens" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 2937.15, -20676.6, 382.99 ), ( 0, 164.19, 0 ), "echo_portal_spawn", undefined, "kitchens" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 2851.14, -20737.8, 409.99 ), ( 0, 265.22, 0 ), "player_echo_reward_point", "cspf_0_auto8914441678853088820", "kitchens" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 2434.57, -20662.1, 397.07 ), ( 0, 358.6, 0 ), "cspf_0_auto8914441678853088820" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 2488.59, -20498.5, 400.65 ), ( 0, 318.18, 0 ), "cspf_0_auto8914441678853088820" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 2413.58, -20737.6, 397.06 ), ( 0, 11.94, 0 ), "cspf_0_auto8914441678853088820" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 2467.94, -20576.8, 401.88 ), ( 0, 334.37, 0 ), "cspf_0_auto8914441678853088820" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 1212.7, -21354, 539.13 ), ( 0, 45.73, 0 ), "curse_inducer", undefined, "kitchens" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 2169.3, -19987.2, 407.39 ), ( 359.34, 298.41, 0.71 ), "loot_buddy_chompy" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( -54.24, -19765.1, 770.4 ), ( 0, 98.19, 0 ), "echo_portal_spawn", undefined, "baths" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 24.83, -19753.8, 768 ), ( 0, 98.19, 0 ), "echo_portal_spawn", undefined, "baths" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( -133.49, -19776.6, 768 ), ( 0, 98.24, 0 ), "echo_portal_spawn", undefined, "baths" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 183.32, -19731, 768 ), ( 0, 98.19, 0 ), "echo_portal_spawn", undefined, "baths" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 104.04, -19742.4, 768 ), ( 0, 98.19, 0 ), "echo_portal_spawn", undefined, "baths" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 13.09, -19688.7, 808 ), ( 0, 199.22, 0 ), "player_echo_reward_point", "cspf_0_auto3291096137172710168", "baths" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -54.91, -19536.7, 771.42 ), ( 0, 292.6, 0 ), "cspf_0_auto3291096137172710168" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 1080.9, -23006.9, 132.9 ), ( 0, 0.2, 0 ), "echo_portal_spawn", undefined, "outerward" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 116.52, -19519.5, 771.48 ), ( 0, 252.18, 0 ), "cspf_0_auto3291096137172710168" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -132.45, -19548.2, 771.15 ), ( 0, 305.94, 0 ), "cspf_0_auto3291096137172710168" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 36.58, -19532.4, 771.31 ), ( 0, 268.37, 0 ), "cspf_0_auto3291096137172710168" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -479.3, -18562, 919.13 ), ( 348.25, 99.99, -2.47 ), "curse_inducer", undefined, "baths" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -30.7, -18051.2, 896 ), ( 0, 194.41, 4 ), "loot_buddy_chompy" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 3 );
    fe [[ f ]]( s, us, cf, ( 32.04, -17030.2, 1184 ), ( 0, 190.19, 0 ), "echo_portal_spawn", undefined, "castle" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 17.91, -16951.6, 1183.03 ), ( 0, 190.19, 0 ), "echo_portal_spawn", undefined, "castle" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 46.25, -17109.1, 1182.92 ), ( 0, 190.24, 0 ), "echo_portal_spawn", undefined, "castle" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( -10.33, -16794, 1185.64 ), ( 0, 190.19, 0 ), "echo_portal_spawn", undefined, "castle" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 3.75, -16872.9, 1185.01 ), ( 0, 190.19, 0 ), "echo_portal_spawn", undefined, "castle" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -46.69, -16965.6, 1203.83 ), ( 0, 291.22, 0 ), "player_echo_reward_point", "cspf_0_auto9077900758903532029", "castle" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -196.28, -17038.9, 1184 ), ( 0, 24.6, 0 ), "cspf_0_auto9077900758903532029" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -219.45, -16868.2, 1183.81 ), ( 0, 344.18, 0 ), "cspf_0_auto9077900758903532029" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -182.04, -17116, 1182.62 ), ( 0, 37.94, 0 ), "cspf_0_auto9077900758903532029" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -203.68, -16947.6, 1184 ), ( 0, 0.37, 0 ), "cspf_0_auto9077900758903532029" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -225.3, -17524, 1211.13 ), ( 0, 9.73, 0 ), "curse_inducer", undefined, "castle" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( -1286.79, -17845.3, 1185.13 ), ( 1.82, 5.46, 0.25 ), "loot_buddy_chompy" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 2 );
    fe [[ f ]]( s, us, cf, ( 1081.13, -23086.8, 128.11 ), ( 0, 0.2, 0 ), "echo_portal_spawn", undefined, "outerward" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 4 );
    fe [[ f ]]( s, us, cf, ( 1080.61, -22926.8, 125.88 ), ( 0, 0.24, 0 ), "echo_portal_spawn", undefined, "outerward" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 0 );
    fe [[ f ]]( s, us, cf, ( 1081.59, -23246.9, 136.6 ), ( 0, 0.2, 0 ), "echo_portal_spawn", undefined, "outerward" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    s.script_index = int( 1 );
    fe [[ f ]]( s, us, cf, ( 1081.42, -23166.8, 130.38 ), ( 0, 0.2, 0 ), "echo_portal_spawn", undefined, "outerward" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 1147.21, -23084.2, 162.58 ), ( 0, 101.22, 0 ), "player_echo_reward_point", "cspf_0_auto5740635107105931247", "outerward" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 1307.27, -23038, 130.49 ), ( 0, 194.6, 0 ), "cspf_0_auto5740635107105931247" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 1300.4, -23210.2, 131.51 ), ( 0, 154.18, 0 ), "cspf_0_auto5740635107105931247" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 1306.65, -22959.6, 130.49 ), ( 0, 207.94, 0 ), "cspf_0_auto5740635107105931247" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 1298.69, -23129.2, 131.7 ), ( 0, 170.37, 0 ), "cspf_0_auto5740635107105931247" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 521.3, -23007.2, 152.21 ), ( 0, 30.41, 4 ), "loot_buddy_chompy" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_ltm_echo_cs";
    fe [[ f ]]( s, us, cf, ( 30.7, -24986, 395.13 ), ( 22, 89.73, 0 ), "curse_inducer", undefined, "outerward" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_hornet_ltm_echo_cs
// Params 0, eflags: 0x4
// Checksum 0x51191388, Offset: 0x1edf
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_hornet_ltm_echo_cs
// Params 0
// Checksum 0x5baf807d, Offset: 0x1ee9
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_hornet_ltm_echo_cs" );
}

