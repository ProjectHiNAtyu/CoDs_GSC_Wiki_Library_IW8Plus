// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_sq_quest_cs.gsc  (hash_37692ff157bf561e.gscc) (size: 11636 Bytes / 0x2d74 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x79fecb4d (2046741325)
// size ...... 11636 (0x2d74)
// includes .. 2   (offset: 0x2720)
// strings ... 77  (offset: 0x2730)
// dev strs .. 0   (offset: 0x2d74)
// exports ... 6   (offset: 0x2470)
// cseg ...... 0x668 + 0x1e08 (0x2470)
// imports ... 16  (offset: 0x2560)
// animtree1 . 0   (offset: 0x2d74)
// animtree2 . 0   (offset: 0x2d74)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace zm_sat_hornet_sq_quest_cs;

// Namespace zm_sat_hornet_sq_quest_cs
// Params 2
// Checksum 0x5d4d86dd, Offset: 0x686
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_hornet_sq_quest_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_hornet_sq_quest_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_hornet_sq_quest_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_hornet_sq_quest_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_hornet_sq_quest_cs
// Params 3, eflags: 0x4
// Checksum 0x6e26645b, Offset: 0x70e
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_hornet_sq_quest_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_hornet_sq_quest_cs" );
}

// Namespace zm_sat_hornet_sq_quest_cs
// Params 3, eflags: 0x4
// Checksum 0xf3805b0e, Offset: 0x788
// Size: 0x1cc8
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19780.6, -55542.6, 3018.71 ), ( 0, 235, 0 ), "sq_pos" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -20115, -56974, 3020 ), ( 0, 58, 0 ), "arena_1_spawn", "cspf_0_auto9889129048831807835" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -94, -17292.1, 1210.13 ), ( -15, 170, 180 ), "sq_trigger_item" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18200.5, -58115.4, 3142.22 ), ( 0, 189.5, 0 ), "arena_fire_approach", "cspf_0_auto1012836500647896021" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19777, -56902, 3022 ), ( 0, 106, 0 ), "arena_1_spawn", "cspf_0_auto3823578707461270572" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -20168, -56778, 3001 ), ( 0, 53, 0 ), "arena_1_spawn", "cspf_0_auto17567967018807939364" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19878.5, -56745.7, 2999 ), ( 0, 109.5, 0 ), "arena_1_center", undefined, "hellhound", undefined, undefined, undefined, undefined, 400 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18613.9, -58122.1, 3125.47 ), ( 0, 189.5, 0 ), "cspf_0_auto1012836500647896021" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19969.8, -57103, 3003.3 ), ( 0, 84.5, 0 ), "arena_1_spawn_1st", "cspf_0_auto9206066124475085400" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18769.4, -58064, 3125.26 ), ( 0, 109.5, 0 ), "arena_2_center", undefined, "fire_approach", undefined, undefined, undefined, undefined, 400 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18404, -58087, 3135 ), ( 0, 177, 0 ), "arena_2_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -20149, -57348, 3034 ), ( 0, -54, 0 ), "transition_start", "cspf_0_auto5904456264609524249" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18334, -58045, 3138 ), ( 0, 185, 0 ), "arena_2_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18217, -58096, 3152 ), ( 0, 180, 0 ), "arena_2_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18571, -58102, 3120 ), ( 0, 170, 0 ), "fire_exit_2", undefined, undefined, undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18831, -57687, 3128 ), ( 0, 280, 0 ), "arena_2_spawn_reinforce" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18727, -58373, 3126 ), ( 0, 120, 0 ), "arena_2_spawn_reinforce" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19698.8, -56307.1, 3001.23 ), ( 0, 254.5, 0 ), "fire_entrance_1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18556, -57771, 3127 ), ( 0, 230, 0 ), "arena_2_spawn_reinforce" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    s.is_cs_trigger = 1;
    s._size_max = ( 100, 200, 100 );
    s._size_min = ( 100, 200, 100 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -17891.6, -58081.4, 3215 ), ( 0, 0, 0 ), "t_fire_exit" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19777, -56220, 2996 ), ( 0, 264, 0 ), "tree_0" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19850, -56226, 2996 ), ( 0, 84, 0 ), "tree_0" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19886, -56222, 3008 ), ( 0, 266, 0 ), "tree_0" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19736, -56233, 2998 ), ( 0, 86, 0 ), "tree_0" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19956, -56946, 3001 ), ( 0, 45, 0 ), "tree_1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19901, -56946, 3002 ), ( 0, 0, 0 ), "tree_1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -20006, -56926, 3005 ), ( 0, 90, 0 ), "tree_1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19257, -58049, 3126 ), ( 0, 135, 0 ), "tree_2" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19240, -58099, 3136 ), ( 0, 90, 0 ), "tree_2" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18536, -58109, 3120 ), ( 0, 180, 0 ), "tree_3" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18545, -58047, 3128 ), ( 0, 90, 0 ), "tree_3" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -16072, -59790, 3255 ), ( 0, 100, 0 ), "tree_4" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -16117, -59762, 3251 ), ( 0, 55, 0 ), "tree_4" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -16162, -59742, 3248 ), ( 0, 10, 0 ), "tree_4" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -16544, -60110, 3256.38 ), ( 0, 10, 0 ), "arena_3_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19261, -58001, 3131 ), ( 0, 180, 0 ), "tree_2" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -16485, -60198, 3252 ), ( 0, 25, 0 ), "arena_3_reinforce" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -15894, -60216, 3256.37 ), ( 0, 135, 0 ), "arena_3_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -16129, -59154, 3254.65 ), ( 0, 265, 0 ), "arena_3_reinforce" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18551, -58145, 3122 ), ( 0, 360, 0 ), "tree_3" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    s.is_cs_trigger = 1;
    s._size_max = ( 100, 200, 100 );
    s._size_min = ( 100, 200, 100 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -16573.7, -58409.9, 3215 ), ( 0, 315, 0 ), "t_wall_jump" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19702, -57968, 3064 ), ( 0, -2, 0 ), "cspf_0_auto3248776589924635935", "cspf_0_auto16233656848196271994" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19077, -58076, 3132 ), ( 0, -2, 0 ), "cspf_0_auto17029326926432609215", "cspf_0_auto13882638435569849794" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19239, -58048, 3125 ), ( 0, 179.5, 0 ), "fire_exit_intro" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19020, -58377, 3142 ), ( 0, 55, 0 ), "arena_2_spawn_reinforce" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19943, -57747, 3034 ), ( 0, -54, 0 ), "cspf_0_auto5904456264609524249", "cspf_0_auto3248776589924635935" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -20047.3, -56943.4, 3005 ), ( 0, 315, 0 ), "tree_1" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19932, -56932, 3002 ), ( 0, 89.5, 0 ), "fire_exit_1", undefined, undefined, undefined, undefined, undefined, undefined, 80 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18511.4, -57995.7, 3128 ), ( 0, 225, 0 ), "tree_3" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18536, -58198, 3122 ), ( 0, 180, 0 ), "tree_3" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -20058.5, -57018.7, 3023.96 ), ( 0, 109.5, 0 ), "arena_1_fire_1", undefined, undefined, undefined, undefined, undefined, undefined, 50 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19625, -56804, 3026 ), ( 0, 123.5, 0 ), "arena_1_spawn", "cspf_0_auto12247767063694585635" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19720.1, -56665, 2998.95 ), ( 0, 114.5, 0 ), "cspf_0_auto12247767063694585635", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19799.5, -56792.3, 2999.34 ), ( 0, 99.5, 0 ), "cspf_0_auto3823578707461270572", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19944.4, -56837, 3001.84 ), ( 0, 84.5, 0 ), "cspf_0_auto9206066124475085400", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19998.8, -56792, 2998.49 ), ( 0, 69.5, 0 ), "cspf_0_auto9889129048831807835", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18203.8, -58062.6, 3139.43 ), ( 0, 184.5, 0 ), "arena_fire_approach", "cspf_0_auto1054097243672138171" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18612.9, -58067, 3125.53 ), ( 0, 184.5, 0 ), "cspf_0_auto1054097243672138171" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -20109.9, -56684.5, 2998.8 ), ( 0, 59.5, 0 ), "cspf_0_auto17567967018807939364", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -20183.5, -56806.7, 2995.63 ), ( 0, 109.5, 0 ), "arena_1_fire_2", undefined, undefined, undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19383, -58055, 3126 ), ( 0, -2, 0 ), "cspf_0_auto16233656848196271994", "cspf_0_auto17029326926432609215", "start_fires" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -20229.5, -56596.7, 2995.63 ), ( 0, 109.5, 0 ), "arena_1_fire_3", undefined, undefined, undefined, undefined, undefined, undefined, 120 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -20176.5, -56406.7, 3011.39 ), ( 0, 109.5, 0 ), "arena_1_fire_4", undefined, undefined, undefined, undefined, undefined, undefined, 120 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -20055.5, -56289.7, 3026.69 ), ( 0, 109.5, 0 ), "arena_1_fire_5", undefined, undefined, undefined, undefined, undefined, undefined, 120 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19603.5, -56350.7, 3026.69 ), ( 0, 109.5, 0 ), "arena_1_fire_6", undefined, undefined, undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19572.5, -56503.7, 3026.69 ), ( 0, 109.5, 0 ), "arena_1_fire_7", undefined, undefined, undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19585.5, -56667.7, 3035.63 ), ( 0, 109.5, 0 ), "arena_1_fire_8", undefined, undefined, undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19668.5, -56817.7, 3036.23 ), ( 0, 109.5, 0 ), "arena_1_fire_9", undefined, undefined, undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19766.5, -56923.7, 3051.36 ), ( 0, 109.5, 0 ), "arena_1_fire_10", undefined, undefined, undefined, undefined, undefined, undefined, 110 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18968, -57757, 3129 ), ( 0, 109.5, 0 ), "arena_2_fire_9", undefined, undefined, undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -16155, -60238.8, 3251.35 ), ( 0, 109.5, 0 ), "arena_3_center", undefined, "final_battle", undefined, undefined, undefined, undefined, 400 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -16280, -60369, 3250.98 ), ( 0, 80, 0 ), "arena_3_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -15899, -60354, 3263 ), ( 0, 120, 0 ), "arena_3_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -16181, -60370, 3252.6 ), ( 0, 90, 0 ), "arena_3_spawn" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -16132.3, -60129.5, 3251.35 ), ( 0, 0, 0 ), "sq_boss" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18808, -57719, 3128 ), ( 0, 109.5, 0 ), "arena_2_fire_10", undefined, undefined, undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18652, -57773, 3124 ), ( 0, 109.5, 0 ), "arena_2_fire_11", undefined, undefined, undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18558, -57888, 3130 ), ( 0, 109.5, 0 ), "arena_2_fire_12", undefined, undefined, undefined, undefined, undefined, undefined, 110 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -16216, -59786, 3257 ), ( 0, 145, 0 ), "tree_4" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18437, -57932, 3143 ), ( 0, 109.5, 0 ), "arena_2_fire_13", undefined, undefined, undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18236, -57927, 3136 ), ( 0, 109.5, 0 ), "arena_2_fire_14", undefined, undefined, undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18070, -57906, 3136 ), ( 0, 109.5, 0 ), "arena_2_fire_15", undefined, undefined, undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -17926, -57904, 3127 ), ( 0, 109.5, 0 ), "arena_2_fire_16", undefined, undefined, undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18098, -58198, 3183 ), ( 0, 109.5, 0 ), "arena_2_fire_1", undefined, undefined, undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18291, -58222, 3177 ), ( 0, 109.5, 0 ), "arena_2_fire_2", undefined, undefined, undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18458, -58241, 3188 ), ( 0, 109.5, 0 ), "arena_2_fire_3", undefined, undefined, undefined, undefined, undefined, undefined, 110 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18624, -58278, 3131 ), ( 0, 109.5, 0 ), "arena_2_fire_4", undefined, undefined, undefined, undefined, undefined, undefined, 110 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18735, -58373, 3130 ), ( 0, 109.5, 0 ), "arena_2_fire_5", undefined, undefined, undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18901, -58430, 3132 ), ( 0, 109.5, 0 ), "arena_2_fire_6", undefined, undefined, undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19105, -58330, 3130 ), ( 0, 109.5, 0 ), "arena_2_fire_7", undefined, undefined, undefined, undefined, undefined, undefined, 100 );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -16698, -59573, 3540 ), ( 0, 306, 0 ), "arena_3_reinforce" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -16884.3, -59747, 3532.93 ), ( 0, 319, 0 ), "arena_3_reinforce" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -16131.6, -60106.8, 3272 ), ( 340, 289.5, -180 ), "sq_exit_item" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -16160, -59257, 3259.03 ), ( 0, 265, 0 ), "arena_3_reinforce" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    s.is_cs_trigger = 1;
    s._size_max = ( 1114, 2471, 170 );
    s._size_min = ( 968, 1160, 170 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -16668.6, -58037.4, 2793 ), ( 0, 244.5, 0 ), "t_return" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    s.is_cs_trigger = 1;
    s._size_max = ( 550, 431, 64 );
    s._size_min = ( 428, 433, 4 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( 281.72, -17156, 1184 ), ( 0, 190.5, 0 ), "t_second_floor" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -15922.2, -60122.2, 3251.84 ), ( 0, 165, 0 ), "arena_3_final" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -16303.9, -59953.1, 3251.72 ), ( 0, 315, 0 ), "arena_3_final" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -16017.8, -59889.9, 3255.57 ), ( 0, 244.5, 0 ), "arena_3_final" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -16261.9, -60303.9, 3251.29 ), ( 0, 64.5, 0 ), "arena_3_final" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -16014.3, -60262.1, 3251.35 ), ( 0, 130, 0 ), "arena_3_final" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -16397.1, -60119.7, 3251.35 ), ( 0, 0, 0 ), "arena_3_final" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18748, -58072, 3128 ), ( 0, -2, 0 ), "cspf_0_auto13882638435569849794", "cspf_0_auto3522053175810861930" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18375, -58084, 3135 ), ( 0, -1, 0 ), "cspf_0_auto3522053175810861930", "cspf_0_auto15995050660240903233" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -18175, -58100, 3133 ), ( 0, -4, 0 ), "cspf_0_auto15995050660240903233" );
    s = {};
    s.script_cs_flag = "zm_sat_hornet_sq_quest_cs";
    fe [[ f ]]( s, us, cf, ( -19131, -57816, 3139 ), ( 0, 109.5, 0 ), "arena_2_fire_8", undefined, undefined, undefined, undefined, undefined, undefined, 100 );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_hornet_sq_quest_cs
// Params 0, eflags: 0x4
// Checksum 0xb0704044, Offset: 0x2458
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_hornet_sq_quest_cs
// Params 0
// Checksum 0xac75b916, Offset: 0x2462
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_hornet_sq_quest_cs" );
}

