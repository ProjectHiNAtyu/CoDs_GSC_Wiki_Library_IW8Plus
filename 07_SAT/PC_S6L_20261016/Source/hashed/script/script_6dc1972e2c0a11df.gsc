// script_6dc1972e2c0a11df  (hash_6dc1972e2c0a11df.gscc) (size: 11321 Bytes / 0x2c39 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd232b5ca (3526538698)
// size ...... 11321 (0x2c39)
// includes .. 3   (offset: 0x2541)
// strings ... 57  (offset: 0x2559)
// dev strs .. 0   (offset: 0x2c39)
// exports ... 9   (offset: 0x21a9)
// cseg ...... 0x5d6 + 0x1bd3 (0x21a9)
// imports ... 20  (offset: 0x2311)
// animtree1 . 0   (offset: 0x2c39)
// animtree2 . 0   (offset: 0x2c39)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_wz2_sierra_downtown_s4_cs;

// Namespace mp_wz2_sierra_downtown_s4_cs
// Params 0, eflags: 0x5
// Checksum 0x318a5157, Offset: 0x5f4
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_wz2_sierra_downtown_s4_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_wz2_sierra_downtown_s4_cs
// Params 0, eflags: 0x4
// Checksum 0xe3e4373c, Offset: 0x615
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_wz2_sierra_downtown_s4_cs
// Params 0, eflags: 0x4
// Checksum 0x66dfe4d0, Offset: 0x626
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_wz2_sierra_downtown_s4_cs
// Params 2
// Checksum 0xd636b299, Offset: 0x637
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_wz2_sierra_downtown_s4_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_wz2_sierra_downtown_s4_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_wz2_sierra_downtown_s4_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_wz2_sierra_downtown_s4_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_wz2_sierra_downtown_s4_cs
// Params 3, eflags: 0x4
// Checksum 0xe55d501f, Offset: 0x6bf
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_wz2_sierra_downtown_s4_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_wz2_sierra_downtown_s4_cs" );
}

// Namespace mp_wz2_sierra_downtown_s4_cs
// Params 3, eflags: 0x4
// Checksum 0x1899e006, Offset: 0x739
// Size: 0x1a50
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "crane_cs";
    fe [[ f ]]( s, us, cf, ( 18517.8, -10797, 312.5 ), ( 0, 45, 0 ), "crane_destination_tower_southwest" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "crane_cs";
    fe [[ f ]]( s, us, cf, ( 19358.1, -13560.8, 4400.5 ), ( 0, -90, 0 ), "crane_destination_tower_tower_southwest", undefined, "crane_destination_default" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "crane_cs";
    fe [[ f ]]( s, us, cf, ( 21460.6, -18475.6, 997 ), ( 0, 225, 0 ), "crane_destination_tower_northeast" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "crane_cs";
    fe [[ f ]]( s, us, cf, ( 20624.1, -16706.8, 4536.75 ), ( 0, 90, 0 ), "crane_destination_tower_tower_northeast", undefined, "crane_destination_default" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "crane_cs";
    s.script_parameters = "300";
    fe [[ f ]]( s, us, cf, ( 18643.6, -18468.3, 1041 ), ( 0, 135, 0 ), "crane_destination_tower_southeast" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "crane_cs";
    fe [[ f ]]( s, us, cf, ( 20629.8, -13529.5, 4400.5 ), ( 0, 270, 0 ), "crane_destination_tower_tower_northwest", undefined, "crane_destination_default" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "crane_cs";
    fe [[ f ]]( s, us, cf, ( 19356.1, -16691.1, 4536.75 ), ( 0, 90, 0 ), "crane_destination_tower_tower_southeast", undefined, "crane_destination_default" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "crane_cs";
    s.script_parameters = "crane_nest";
    fe [[ f ]]( s, us, cf, ( 19882.1, -11790, 4382.5 ), ( 0, 0, 0 ), "crane_console_interact_noent", undefined, "crane_destination_tower_tower_northwest" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "crane_cs";
    fe [[ f ]]( s, us, cf, ( 21046.3, -10631.5, 1812.75 ), ( 0, 0, 0 ), "crane_destination_tower_northwest" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "crane_cs";
    fe [[ f ]]( s, us, cf, ( 20668.8, -14165, 4329.5 ), ( 0, 179.47, 0 ), "crane_console_interact_noent", undefined, "crane_destination_tower_tower_northwest" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "crane_cs";
    fe [[ f ]]( s, us, cf, ( 21369.3, -10655.7, 1441.5 ), ( 0, 359.75, 0 ), "crane_console_interact_noent", undefined, "crane_destination_tower_northwest" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "crane_cs";
    fe [[ f ]]( s, us, cf, ( 18390.6, -10643.2, -102.5 ), ( 0, 136.09, 0 ), "crane_console_interact_noent", undefined, "crane_destination_tower_southwest" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "crane_cs";
    s.script_parameters = "crane_nest";
    fe [[ f ]]( s, us, cf, ( 19815.1, -11790, 4382.5 ), ( 0, 0, 0 ), "crane_console_interact_noent", undefined, "crane_destination_tower_tower_southwest" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "crane_cs";
    fe [[ f ]]( s, us, cf, ( 19425.1, -16210.8, 4330 ), ( 0, 92.19, 0 ), "crane_console_interact_noent", undefined, "crane_destination_tower_tower_southeast" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "crane_cs";
    s.script_parameters = "crane_nest";
    fe [[ f ]]( s, us, cf, ( 19938.1, -18418.6, 4579.25 ), ( 0, 0, 0 ), "crane_console_interact_noent", undefined, "crane_destination_tower_tower_southeast" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "crane_cs";
    fe [[ f ]]( s, us, cf, ( 18504.1, -18661.2, 657.5 ), ( 0, 225.68, 0 ), "crane_console_interact_noent", undefined, "crane_destination_tower_southeast" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "crane_cs";
    fe [[ f ]]( s, us, cf, ( 21587.3, -18618.2, 609.5 ), ( 0, 312.35, 0 ), "crane_console_interact_noent", undefined, "crane_destination_tower_northeast" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "crane_cs";
    s.script_parameters = "crane_nest";
    fe [[ f ]]( s, us, cf, ( 20005.1, -18418.6, 4579.25 ), ( 0, 0, 0 ), "crane_console_interact_noent", undefined, "crane_destination_tower_tower_northeast" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "crane_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 19550, -14134, 4649.5 ), ( 0, 266.5, 0 ), "crane_console_interact_noent", undefined, "crane_destination_tower_tower_southwest" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "crane_cs";
    fe [[ f ]]( s, us, cf, ( 20929.6, -16105.8, 4489.5 ), ( 0, 358.55, 0 ), "crane_console_interact_noent", undefined, "crane_destination_tower_tower_northeast" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_balls_debug";
    fe [[ f ]]( s, us, cf, ( 20408, -14155, 4321 ), ( 90, 180, 220 ), "quest_wz_panic_room_numbers", undefined, "3" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_balls_debug";
    fe [[ f ]]( s, us, cf, ( 20402.3, -14160.6, 4321 ), ( 90, 180, 220 ), "quest_wz_panic_room_numbers", undefined, "1" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_balls_debug";
    fe [[ f ]]( s, us, cf, ( 20405.2, -14157.8, 4321 ), ( 90, 180, 220 ), "quest_wz_panic_room_numbers", undefined, "2" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_balls_debug";
    fe [[ f ]]( s, us, cf, ( 20399.5, -14163.5, 4321 ), ( 90, 180, 220 ), "quest_wz_panic_room_numbers", undefined, "0" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_balls_rack";
    fe [[ f ]]( s, us, cf, ( 20711, -14154, 4509 ), ( 75, 90, -90 ), "quest_panic_room_rack_ball", undefined, "3" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_interacts";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 20328, -14238, 4344 ), ( 0, 0, 0 ), "quest_wz_panic_room_keypad", undefined, "0" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "SAM";
    s.name = "SAM";
    fe [[ f ]]( s, us, cf, ( 30960, -17361, -64 ), ( 0, 181, 0 ), "sam_turret", undefined, undefined, undefined, undefined, undefined, undefined, 9000 );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "SAM";
    s.name = "SAM";
    fe [[ f ]]( s, us, cf, ( 18975, -25346, -242.55 ), ( 0, 227, 0 ), "sam_turret", undefined, undefined, undefined, undefined, undefined, undefined, 9000 );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "SAM";
    s.name = "SAM";
    fe [[ f ]]( s, us, cf, ( 9883, -13999, -288 ), ( 0, 360, 0 ), "sam_turret", undefined, undefined, undefined, undefined, undefined, undefined, 9000 );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_balls_rack";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 20711, -14146, 4515.25 ), ( 60, 270, 90 ), "quest_panic_room_rack_ball", undefined, "0" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_balls_rack";
    fe [[ f ]]( s, us, cf, ( 20711, -14152, 4503 ), ( 75, 90, -90 ), "quest_panic_room_rack_ball", undefined, "4" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_balls_rack";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 20711, -14150, 4515.25 ), ( 75, 90, -90 ), "quest_panic_room_rack_ball", undefined, "1" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_balls_penthouse";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 19513.5, -14790, 4457.25 ), ( 42.23, 60.08, -20.34 ), "quest_panic_room_hidden_ball_penthouse", undefined, "1" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_balls_penthouse";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 21067.7, -15623.7, 4297 ), ( 50.77, 202.23, -26.7 ), "quest_panic_room_hidden_ball_penthouse", undefined, "2" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_balls_penthouse";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 19262, -16201, 4485.25 ), ( 47.27, 86.87, 49.33 ), "quest_panic_room_hidden_ball_penthouse", undefined, "0" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_balls_atrium";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 19090.3, -14192, 2697 ), ( 47.37, 249.64, 19.09 ), "quest_panic_room_hidden_ball_atrium", undefined, "1" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_balls_atrium";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 19989.5, -14973, 2755 ), ( 44.67, 255.47, 13.98 ), "quest_panic_room_hidden_ball_atrium", undefined, "2" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_balls_atrium";
    fe [[ f ]]( s, us, cf, ( 20146.8, -15136.8, 3367.25 ), ( 26.74, 317.13, -21.16 ), "quest_panic_room_hidden_ball_atrium", undefined, "0" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_balls_rack";
    fe [[ f ]]( s, us, cf, ( 20711, -14150, 4509 ), ( 45, 90, -90 ), "quest_panic_room_rack_ball", undefined, "2" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_balls_rack";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 20711, -14156, 4503 ), ( 45, 270, 90 ), "quest_panic_room_rack_ball", undefined, "5" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_balls_lobby";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 20496.7, -14796.9, -50.22 ), ( 18.62, 26.31, 2.58 ), "quest_panic_room_hidden_ball_lobby", undefined, "0" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_balls_lobby";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 19548.7, -14216, -13.46 ), ( 56.84, 281.84, 25.41 ), "quest_panic_room_hidden_ball_lobby", undefined, "1" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_balls_lobby";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 20228, -15967.8, 147.24 ), ( 356.87, 357.6, 0.99 ), "quest_panic_room_hidden_ball_lobby", undefined, "2" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_balls_debug";
    fe [[ f ]]( s, us, cf, ( 20410.8, -14152.2, 4321 ), ( 90, 180, 220 ), "quest_wz_panic_room_numbers", undefined, "4" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_balls_debug";
    fe [[ f ]]( s, us, cf, ( 20413.7, -14149.4, 4321 ), ( 90, 180, 220 ), "quest_wz_panic_room_numbers", undefined, "5" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_interacts";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 20706, -14153, 4508.25 ), ( 0, 180, 0 ), "quest_wz_panic_room_rack_interact" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_loot";
    s.script_parameters = "brloot_killstreak_hand_cannon";
    fe [[ f ]]( s, us, cf, ( 20285, -14553, 4334 ), ( 0, 338.72, 0 ), "panic_room", undefined, "staged_item" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_loot";
    s.script_parameters = "brloot_plunder_cash_uncommon_3";
    fe [[ f ]]( s, us, cf, ( 19987.8, -14491.8, 4329.25 ), ( 0, 25.98, 0 ), "panic_room", undefined, "staged_item" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_loot";
    s.script_parameters = "brloot_plunder_cash_uncommon_2";
    fe [[ f ]]( s, us, cf, ( 19991, -14544, 4329.25 ), ( 0, 12.09, 0 ), "panic_room", undefined, "staged_item" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_loot";
    s.script_parameters = "brloot_plunder_cash_uncommon_1";
    fe [[ f ]]( s, us, cf, ( 19974.1, -14511, 4329.25 ), ( 0, 239.96, 0 ), "panic_room", undefined, "staged_item" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_loot";
    s.script_parameters = "brloot_plunder_cash_uncommon_1";
    fe [[ f ]]( s, us, cf, ( 19991.3, -14573, 4329.25 ), ( 0, 239.96, 0 ), "panic_room", undefined, "staged_item" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_loot";
    s.script_parameters = "brloot_super_armorbox";
    fe [[ f ]]( s, us, cf, ( 19951.8, -14607.7, 4329.25 ), ( 0, 135, 0 ), "panic_room", undefined, "staged_item" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_loot";
    s.script_parameters = "brloot_plunder_cash_uncommon_1";
    fe [[ f ]]( s, us, cf, ( 19961.3, -14461, 4329.25 ), ( 0, 269.68, 0 ), "panic_room", undefined, "staged_item" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_loot";
    s.script_parameters = "brloot_plunder_cash_uncommon_1";
    fe [[ f ]]( s, us, cf, ( 19961.3, -14436, 4329.25 ), ( 0, 146.71, 0 ), "panic_room", undefined, "staged_item" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_loot";
    s.script_parameters = "brloot_plunder_cash_uncommon_1";
    fe [[ f ]]( s, us, cf, ( 19945.8, -14449.8, 4329.25 ), ( 0, 320.08, 0 ), "panic_room", undefined, "staged_item" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_loot";
    s.script_parameters = "brloot_weapon_la_polis_unco";
    fe [[ f ]]( s, us, cf, ( 20144.8, -14528.3, 4323.25 ), ( 273.31, 194.76, -94.66 ), "panic_room", undefined, "staged_item" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_loot";
    s.name = "script_struct";
    s.script_parameters = "brloot_weapon_la_polis_unco";
    fe [[ f ]]( s, us, cf, ( 19821.8, -14527.8, 4322.75 ), ( 274.76, 193.33, -93.24 ), "panic_room", undefined, "staged_item" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_loot";
    s.script_parameters = "brloot_killstreak_uav";
    fe [[ f ]]( s, us, cf, ( 19685, -14246, 4337 ), ( 0, 205.54, 0 ), "panic_room", undefined, "staged_item" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_loot";
    s.script_parameters = "brloot_offhand_c4_sat";
    fe [[ f ]]( s, us, cf, ( 19821.6, -14482.5, 4305 ), ( 0, 239.96, 0 ), "panic_room", undefined, "staged_item" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_loot";
    s.script_parameters = "brloot_super_munitionsbox";
    fe [[ f ]]( s, us, cf, ( 19663.8, -14556.7, 4318.25 ), ( 0, 87, 0 ), "panic_room", undefined, "staged_item" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_keycards";
    fe [[ f ]]( s, us, cf, ( 21071, -16740, -135.75 ), ( 0, 0, 0 ), "panic_room_brloot_key_elevator", undefined, "burger_town" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_keycards";
    fe [[ f ]]( s, us, cf, ( 19483, -14102, -16 ), ( 0, 0, 0 ), "panic_room_brloot_key_elevator", undefined, "fridge" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_keycards";
    fe [[ f ]]( s, us, cf, ( 19389, -15694.8, -33.75 ), ( 0, 0, 0 ), "panic_room_brloot_key_elevator", undefined, "elevator" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_loot";
    fe [[ f ]]( s, us, cf, ( 19976, -14822, 4294 ), ( 0, 0, 0 ), "br_loot_cache_locked", undefined, "1" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_loot";
    fe [[ f ]]( s, us, cf, ( 20194, -14822, 4294 ), ( 0, 0, 0 ), "br_loot_cache_locked", undefined, "0" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "SAM";
    s.name = "SAM";
    fe [[ f ]]( s, us, cf, ( 19648, -2260, -499.54 ), ( 0, 322, 0 ), "sam_turret", undefined, undefined, undefined, undefined, undefined, undefined, 9000 );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_loot";
    fe [[ f ]]( s, us, cf, ( 19758, -14822, 4294 ), ( 0, 0, 0 ), "br_loot_cache_locked", undefined, "2" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "panic_room_loot";
    s.script_parameters = "brloot_plunder_cash_uncommon_2";
    fe [[ f ]]( s, us, cf, ( 19953.1, -14494, 4329.25 ), ( 0, 239.96, 0 ), "panic_room", undefined, "staged_item" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "lobby_staged_items";
    s.script_parameters = "brloot_plunder_cash_uncommon_3";
    fe [[ f ]]( s, us, cf, ( 19648.7, -14680.6, -56 ), ( 0, 320.78, 0 ), "panic_room", undefined, "staged_item" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "lobby_staged_items";
    s.script_parameters = "brloot_plunder_cash_uncommon_1";
    fe [[ f ]]( s, us, cf, ( 19665.5, -14643.6, -56 ), ( 0, 204.48, 0 ), "panic_room", undefined, "staged_item" );
    s = {};
    s.script_cs_flag = "mp_wz2_sierra_downtown_s4_cs";
    s.groupid = "lobby_staged_items";
    s.script_parameters = "brloot_plunder_cash_uncommon_2";
    fe [[ f ]]( s, us, cf, ( 19632.1, -14650, -56 ), ( 0, 174.76, 0 ), "panic_room", undefined, "staged_item" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_wz2_sierra_downtown_s4_cs
// Params 0, eflags: 0x4
// Checksum 0xbfb4dee6, Offset: 0x2191
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_wz2_sierra_downtown_s4_cs
// Params 0
// Checksum 0x270e8d52, Offset: 0x219b
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_wz2_sierra_downtown_s4_cs" );
}

