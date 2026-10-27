// scripts\mp\maps\mp_saw_sierra\mp_saw_sierra_sidequest_s1.gsc  (hash_11b0fcc15cd6db58.gscc) (size: 14255 Bytes / 0x37af / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xab7d178f (2877101967)
// size ...... 14255 (0x37af)
// includes .. 3   (offset: 0x2f4f)
// strings ... 117 (offset: 0x2f67)
// dev strs .. 0   (offset: 0x37af)
// exports ... 9   (offset: 0x2bb7)
// cseg ...... 0xeff + 0x1cb8 (0x2bb7)
// imports ... 20  (offset: 0x2d1f)
// animtree1 . 0   (offset: 0x37af)
// animtree2 . 0   (offset: 0x37af)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_saw_sierra_sidequest_s1;

// Namespace mp_saw_sierra_sidequest_s1
// Params 0, eflags: 0x5
// Checksum 0xccc3f036, Offset: 0xf1d
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_saw_sierra_sidequest_s1", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_saw_sierra_sidequest_s1
// Params 0, eflags: 0x4
// Checksum 0xa0568bd0, Offset: 0xf3e
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_saw_sierra_sidequest_s1
// Params 0, eflags: 0x4
// Checksum 0x256d583c, Offset: 0xf4f
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_saw_sierra_sidequest_s1
// Params 2
// Checksum 0x95840e75, Offset: 0xf60
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_saw_sierra_sidequest_s1" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_saw_sierra_sidequest_s1" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_saw_sierra_sidequest_s1" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_saw_sierra_sidequest_s1" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_saw_sierra_sidequest_s1
// Params 3, eflags: 0x4
// Checksum 0xa6efecf3, Offset: 0xfe8
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_saw_sierra_sidequest_s1" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_saw_sierra_sidequest_s1" );
}

// Namespace mp_saw_sierra_sidequest_s1
// Params 3, eflags: 0x4
// Checksum 0xcb4c3669, Offset: 0x1062
// Size: 0x1b35
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_grave_looter_spawnpoint_0";
    fe [[ f ]]( s, us, cf, ( 31101, 32595, 892 ), ( 360, 70, 90 ), "interactsidequest_grave_looter_spawnpoint_0" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( 41905, -41297, -591 ), ( 0, 139, 0 ), "interactsidequest_woodenshed_prison_interact" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_grave_interact";
    fe [[ f ]]( s, us, cf, ( -17049, -1661, -245 ), ( 0, 139, 0 ), "interactsidequest_grave_interact" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_grave_loot_spawnpoint";
    fe [[ f ]]( s, us, cf, ( -17049, -1661.1, -254.5 ), ( 0, 139, 0 ), "interactsidequest_grave_loot_spawnpoint" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_grave_looter_spawnpoint_1";
    fe [[ f ]]( s, us, cf, ( -37321.5, 26005, 997 ), ( 0, 115, 90 ), "interactsidequest_grave_looter_spawnpoint_1" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_grave_looter_spawnpoint_2";
    fe [[ f ]]( s, us, cf, ( -1013.25, 11869, -267.29 ), ( 360, 25, 90 ), "interactsidequest_grave_looter_spawnpoint_2" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_grave_looter_spawnpoint_3";
    fe [[ f ]]( s, us, cf, ( 31042.8, -976.75, -670 ), ( 0, 205, 90 ), "interactsidequest_grave_looter_spawnpoint_3" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_grave_looter_spawnpoint_4";
    fe [[ f ]]( s, us, cf, ( 20548.5, -14615.5, -31 ), ( 360, 50.4, 90 ), "interactsidequest_grave_looter_spawnpoint_4" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_grave_looter_spawnpoint_5";
    fe [[ f ]]( s, us, cf, ( -16274.8, -32443.5, 250 ), ( 360, 70, 90 ), "interactsidequest_grave_looter_spawnpoint_5" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_dissolving_chemical_centrifuge";
    fe [[ f ]]( s, us, cf, ( 8123, -11574, -244 ), ( 0, 88, 0 ), "interactsidequest_dissolving_chemical_centrifuge" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( 41940, -41257, -591 ), ( 0, 139, 0 ), "interactsidequest_woodenshed_prison_door" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( 20887, 16615, 244 ), ( 0, 158.7, 0 ), "interactsidequest_woodenshed_tv_door" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( 20901, 16645, 244 ), ( 0, 158.7, 0 ), "interactsidequest_woodenshed_tv_interact" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( 47136, -10701, 124 ), ( 0, 0, 0 ), "interactsidequest_woodenshed_farm_door" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( 47181, -10696, 124 ), ( 0, 0, 0 ), "interactsidequest_woodenshed_farm_interact" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( 21234, 16598, 246 ), ( 0, 0, 0 ), "interactsidequest_woodenshed_tv_door" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( 21247, 16634, 246 ), ( 0, 0, 0 ), "interactsidequest_woodenshed_tv_interact" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_wine_bottle_interact";
    fe [[ f ]]( s, us, cf, ( -31298, 33617, 710 ), ( 0, 332.8, 0 ), "interactsidequest_winebottle_interact" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_superstore_desk_interact";
    fe [[ f ]]( s, us, cf, ( -15338.2, 7681.25, -346 ), ( 360, 326.5, -0 ), "interactsidequest_superstore_desk_interact" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_floating_door_spawn_2";
    fe [[ f ]]( s, us, cf, ( 49869, -38785, 504 ), ( 0, 0, 90 ), "floating_door_image_loc" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_dissolving_chemical_interact";
    fe [[ f ]]( s, us, cf, ( 8123.25, -11566.2, -235.75 ), ( 0, 88, 0 ), "interactsidequest_dissolving_chemical_interact" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_dissolving_chemical_spawn";
    fe [[ f ]]( s, us, cf, ( 35102.2, 45653.5, 1315 ), ( 0, 282.06, 0 ), "interactsidequest_dissolving_chemical_vial_spawn" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_dissolving_chemical_loot";
    fe [[ f ]]( s, us, cf, ( 8127.95, -11575, -230.5 ), ( 0, 88.41, 0 ), "interactsidequest_dissolving_chemical_loot" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_floating_door_spawn_1";
    fe [[ f ]]( s, us, cf, ( 48316, -39680, 497 ), ( 0, 180, 90 ), "floating_door_image_loc" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( 22357, -19716, -203 ), ( 0, 45, 0 ), "biometric_scan_bank_vault" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_wine_bottle_loot_spawnpoint";
    fe [[ f ]]( s, us, cf, ( -31244.2, 33656.3, 702.25 ), ( 359.2, 318.5, -0 ), "interactsidequest_winebottle_loot" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( 7847, -36147, -650.18 ), ( 357.46, 66.77, -3.68 ), "chance_token_loc" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( 22849, -35211, -607 ), ( 357.46, 66.77, -3.68 ), "chance_token_loc" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( 24807, -34975, -632 ), ( 344.29, 67.64, -3.82 ), "chance_token_loc" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( -14172, -45777, -590 ), ( 354.27, 68.3, 3.65 ), "chance_token_loc" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( -8590, -43613, -628.25 ), ( 354.27, 68.3, -3.95 ), "chance_token_loc" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( 2945, -39709, -566 ), ( 354.27, 68.3, 7.55 ), "chance_token_loc" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( 8650, -35774, -640 ), ( 358.02, 70.05, 7.02 ), "chance_token_loc" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_floating_door_spawn_3";
    fe [[ f ]]( s, us, cf, ( 48501, -38443, 698 ), ( 0, 90, 90 ), "floating_door_image_loc" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( 39134, -43891, -608.95 ), ( 354.85, 139.24, -5.63 ), "chance_token_loc" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_floating_door_spawn_4";
    fe [[ f ]]( s, us, cf, ( 49474, -40104, 704 ), ( 0, 180, 90 ), "floating_door_image_loc" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_floating_door_spawn_8";
    fe [[ f ]]( s, us, cf, ( 50777, -40059, 466 ), ( 0, 294.14, 0 ), "floating_door_image_loc" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( 15233, 16875, 180 ), ( 272.16, 179.98, 137.46 ), "sierra_kyh_hint_a", undefined, "stationary_note" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( 22309, -19647, -165 ), ( 0, 225, 0 ), "bank_vault_door_drill" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( 14949, 17081, 188 ), ( 272.16, 179.99, -93 ), "sierra_kyh_hint_b", undefined, "stationary_note" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( 15006, 17221, 192 ), ( 272.16, 179.98, 71.42 ), "sierra_kyh_hint_c", undefined, "stationary_note" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( 15152, 17203, 152 ), ( 272.16, 179.98, 46.05 ), "sierra_kyh_hint_d", undefined, "stationary_note" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_floating_door_spawn_5";
    fe [[ f ]]( s, us, cf, ( 50045, -39165, 314 ), ( 0, 134.2, 90 ), "floating_door_image_loc" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_superstore_desk_keycard_loot_to_pos";
    fe [[ f ]]( s, us, cf, ( -15346, 7658, -350 ), ( 0, 144, 0 ), "interactsidequest_superstore_desk_keycard_loot_to_pos" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_floating_door_spawn_6";
    fe [[ f ]]( s, us, cf, ( 51029, -39011, 332 ), ( 0, 0, 90 ), "floating_door_image_loc" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_floating_door_spawn_7";
    fe [[ f ]]( s, us, cf, ( 51075, -40319, 1022 ), ( 0, 180, 90 ), "floating_door_image_loc" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( -40800.5, -1769.25, 111.25 ), ( 0, 346.31, 0 ), "bunker_staged_reward_vault_2", undefined, "brloot_killstreak_auav" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( 36768.8, 13003.2, -133 ), ( 0, 231.6, 0 ), "bunker_staged_reward_vault_7", undefined, "brloot_killstreak_auav" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( 35511.1, 13214, 9 ), ( 0, 191.64, 0 ), "bunker_staged_reward_vault_8", undefined, "brloot_killstreak_auav" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( -16325, 45864, -212 ), ( 0, 196.57, 0 ), "bunker_staged_reward_vault_4", undefined, "brloot_killstreak_auav" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( -1108, 40850, 1451 ), ( 0, -139, 0 ), "bunker_staged_reward_vault_5", undefined, "brloot_killstreak_auav" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( 49632, 35309.2, 128 ), ( 0, 274.07, 0 ), "bunker_staged_reward_vault_6", undefined, "brloot_killstreak_auav" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( 53235.2, -32260.1, -252 ), ( 0, 255.91, 0 ), "bunker_staged_reward_vault_9", undefined, "brloot_killstreak_auav" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( -5162.05, 62257.4, 572 ), ( 0, 318.5, 0 ), "bunker_staged_reward_number_station", undefined, "brloot_killstreak_auav" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( -3567.55, 62206.4, 543.5 ), ( 0, 5.26, 0 ), "bunker_staged_reward_number_station", undefined, "brloot_perk_specialist_saw" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( -3941.05, 62640.4, 585 ), ( 360, 175, -90 ), "bunker_staged_reward_number_station", undefined, "brloot_weapon_sm_zebra_lege" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( -3929.75, 62614.7, 585 ), ( 360, 165, -90 ), "bunker_staged_reward_number_station", undefined, "brloot_weapon_sm_zebra_lege" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( -13766, 17992, -939 ), ( 0, 197, 0 ), "bunker_staged_reward_parliament_puzzle", undefined, "brloot_perk_specialist_saw" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( -13061, 18663, -941 ), ( 353, 149, 0 ), "bunker_staged_reward_parliament_puzzle", undefined, "brloot_weapon_lm_hades_lege" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( 21709, -19618, -172 ), ( 0, 275, 0 ), "bunker_staged_reward_bank_vault", undefined, "brloot_killstreak_supply_sweep" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( -26338, -12078, -55 ), ( 0, 0, 0 ), "bunker_staged_reward_loadout_crush", undefined, "brloot_offhand_flash_sat" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( -26366.7, -12061, -51 ), ( 0, 0, 0 ), "bunker_staged_reward_loadout_crush", undefined, "brloot_offhand_semtex_sat" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( -26428.9, -12110.2, -52.5 ), ( 0, 0, 0 ), "bunker_staged_reward_loadout_crush", undefined, "brloot_plunder_cash_uncommon_2" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( -26408.4, -12066, -52.5 ), ( 0, 0, 0 ), "bunker_staged_reward_loadout_crush", undefined, "brloot_weapon_sm_zebra_rare" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( -9965, -11114, 77 ), ( 0, 0, 0 ), "bunker_staged_reward_exhibit", undefined, "brloot_offhand_smoke_sat" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( -10479, -10380.2, 92.5 ), ( 285.7, 172.92, -5.36 ), "bunker_staged_reward_exhibit", undefined, "brloot_weapon_sm_zebra_rare" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( -9798, -11352, 77 ), ( 0, 35, 0 ), "bunker_staged_reward_exhibit", undefined, "brloot_offhand_c4_sat" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( -10332.2, -10590, 77.87 ), ( 360, 35.03, -0 ), "bunker_staged_reward_exhibit", undefined, "brloot_offhand_semtex_sat" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( -10167.2, -10824.5, 78 ), ( -45, 125, 0 ), "bunker_staged_reward_exhibit", undefined, "brloot_offhand_heartbeatsensor" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( 38991.2, -43988.8, -638.25 ), ( 0, 0, 0 ), "bunker_staged_reward_vodianov", undefined, "brloot_health_adrenaline_saw" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( 38933.2, -43995.2, -641 ), ( 0, 0, 0 ), "bunker_staged_reward_vodianov", undefined, "brloot_health_adrenaline_saw" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( 22998, -20276, -80 ), ( 0, 135, 0 ), "biometric_scan_bank_vault" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( 21685, -19134, 50 ), ( 0, 45, 0 ), "biometric_scan_bank_vault" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( 23118, -20419, 179 ), ( 0, 225, 0 ), "biometric_scan_bank_vault" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_floating_door_position";
    fe [[ f ]]( s, us, cf, ( 61059.6, -44053, 792 ), ( 0, 21, 0 ), "floating_door_location", undefined, "7" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_floating_door_position";
    fe [[ f ]]( s, us, cf, ( 60930.2, -44084.6, 756 ), ( 0, 21, 0 ), "floating_door_location", undefined, "6" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_floating_door_position";
    fe [[ f ]]( s, us, cf, ( 60832.1, -44120.6, 779 ), ( 0, 21, 0 ), "floating_door_location", undefined, "5" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_floating_door_position";
    fe [[ f ]]( s, us, cf, ( 60750.3, -44162.7, 740 ), ( 0, 21, 0 ), "floating_door_location", undefined, "4" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_floating_door_position";
    fe [[ f ]]( s, us, cf, ( 61029.3, -44015.1, 659 ), ( 0, 21, 0 ), "floating_door_location", undefined, "3" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_floating_door_position";
    fe [[ f ]]( s, us, cf, ( 60957.2, -44046.3, 624 ), ( 0, 21, 0 ), "floating_door_location", undefined, "2" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_floating_door_position";
    fe [[ f ]]( s, us, cf, ( 60871.2, -44074.9, 643 ), ( 0, 21, 0 ), "floating_door_location", undefined, "1" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_floating_door_position";
    fe [[ f ]]( s, us, cf, ( 60740.8, -44118.8, 624 ), ( 0, 21, 0 ), "floating_door_location", undefined, "0" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.challenge = "sierra_sidequest_53";
    s.name = "script_struct_note_53";
    fe [[ f ]]( s, us, cf, ( 48251, -39430, 470.5 ), ( 270, 0, 64.6 ), "sierra_sidequest_53", undefined, "stationary_note" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.challenge = "sierra_sidequest_59";
    s.name = "script_struct_note_59";
    fe [[ f ]]( s, us, cf, ( -9436, -11749, 71.5 ), ( 272.33, 319.25, 168.88 ), "sierra_sidequest_59", undefined, "stationary_note" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.challenge = "sierra_sidequest_52";
    s.name = "script_struct_note_52";
    fe [[ f ]]( s, us, cf, ( 17436, 5980, -337.23 ), ( 270, 0, 154.4 ), "sierra_sidequest_52", undefined, "stationary_note" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.challenge = "sierra_sidequest_54";
    s.name = "script_struct_note_54";
    fe [[ f ]]( s, us, cf, ( 12641, 34888, 2226.5 ), ( 270, 0, 64.6 ), "sierra_sidequest_54", undefined, "stationary_note" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.challenge = "sierra_sidequest_55";
    s.name = "script_struct_note_55";
    fe [[ f ]]( s, us, cf, ( 31101, 32578, 944 ), ( 0, 115.8, 0 ), "sierra_sidequest_55", undefined, "stationary_note" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.challenge = "sierra_sidequest_56";
    s.name = "script_struct_note_56";
    fe [[ f ]]( s, us, cf, ( 8109, -10331, 88.5 ), ( 270, 0, -127 ), "sierra_sidequest_56", undefined, "stationary_note" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.challenge = "sierra_sidequest_57";
    s.name = "script_struct_note_57";
    fe [[ f ]]( s, us, cf, ( -26396, -12087, -64.34 ), ( 274.18, 260.01, -58.06 ), "sierra_sidequest_57", undefined, "stationary_note" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.challenge = "sierra_sidequest_58";
    s.name = "script_struct_note_58";
    fe [[ f ]]( s, us, cf, ( 39175, -43847, -590.5 ), ( 274.69, 217.6, -70.69 ), "sierra_sidequest_58", undefined, "stationary_note" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_note_23";
    fe [[ f ]]( s, us, cf, ( -26461, 10453, -275 ), ( 278.53, 245.83, -75.11 ), "sierra_sidequest_23", undefined, "stationary_note" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_note_33";
    fe [[ f ]]( s, us, cf, ( -31323, 33597, 710 ), ( 270, 0, 11.4 ), "sierra_sidequest_33", undefined, "stationary_note" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    s.name = "script_struct_note_25";
    fe [[ f ]]( s, us, cf, ( 8095, -11575, -244 ), ( 270, 0, 41.4 ), "sierra_sidequest_25", undefined, "stationary_note" );
    s = {};
    s.script_cs_flag = "mp_saw_sierra_sidequest_s1";
    fe [[ f ]]( s, us, cf, ( 361, 233, -1165 ), ( 0, 0, 0 ), "quest_test" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_saw_sierra_sidequest_s1
// Params 0, eflags: 0x4
// Checksum 0xb77b8137, Offset: 0x2b9f
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_saw_sierra_sidequest_s1
// Params 0
// Checksum 0x64bc31be, Offset: 0x2ba9
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_saw_sierra_sidequest_s1" );
}

