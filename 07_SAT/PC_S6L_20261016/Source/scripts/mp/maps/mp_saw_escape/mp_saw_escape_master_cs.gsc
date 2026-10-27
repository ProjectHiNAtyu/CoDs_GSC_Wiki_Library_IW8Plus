// scripts\mp\maps\mp_saw_escape\mp_saw_escape_master_cs.gsc  (hash_0f783f9f605ddb97.gscc) (size: 8026 Bytes / 0x1f5a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x31fc11a (52412698)
// size ...... 8026 (0x1f5a)
// includes .. 2   (offset: 0x1b12)
// strings ... 43  (offset: 0x1b22)
// dev strs .. 0   (offset: 0x1f5a)
// exports ... 6   (offset: 0x1862)
// cseg ...... 0x411 + 0x1451 (0x1862)
// imports ... 16  (offset: 0x1952)
// animtree1 . 0   (offset: 0x1f5a)
// animtree2 . 0   (offset: 0x1f5a)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace mp_saw_escape_master_cs;

// Namespace mp_saw_escape_master_cs
// Params 2
// Checksum 0xfd65315e, Offset: 0x42f
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_saw_escape_master_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_saw_escape_master_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_saw_escape_master_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_saw_escape_master_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_saw_escape_master_cs
// Params 3, eflags: 0x4
// Checksum 0xce0ed3d8, Offset: 0x4b7
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_saw_escape_master_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_saw_escape_master_cs" );
}

// Namespace mp_saw_escape_master_cs
// Params 3, eflags: 0x4
// Checksum 0x31c2bb6a, Offset: 0x531
// Size: 0x1311
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.script_parameters = "brloot_self_revive";
    fe [[ f ]]( s, us, cf, ( -4522.25, 4331.75, 652.06 ), ( 0, 346.11, 0 ), "staged_items", undefined, "staged_item", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.script_parameters = "brloot_super_munitionsbox";
    fe [[ f ]]( s, us, cf, ( -4126, 7300, 324.16 ), ( 0, 78, 0 ), "staged_items", undefined, "staged_item", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.script_parameters = "brloot_super_armorbox";
    fe [[ f ]]( s, us, cf, ( -4277, 7762, 323.76 ), ( 0, 258, 0 ), "staged_items", undefined, "staged_item", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.script_parameters = "brloot_equip_gasmask";
    fe [[ f ]]( s, us, cf, ( -2035, 6654.39, 585 ), ( 5, 165, 270 ), "staged_items", undefined, "staged_item", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.script_parameters = "brloot_super_utilitybox";
    fe [[ f ]]( s, us, cf, ( -2957.67, 12205, 136.7 ), ( 0, 45, 0 ), "staged_items", undefined, "staged_item", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.script_parameters = "brloot_equip_gasmask";
    fe [[ f ]]( s, us, cf, ( -2452, 9560, 862.5 ), ( 19.6, 201.21, -2.85 ), "staged_items", undefined, "staged_item", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.script_parameters = "brloot_self_revive";
    fe [[ f ]]( s, us, cf, ( 1481.91, 7731.91, 929.77 ), ( 0, 105, 0 ), "staged_items", undefined, "staged_item", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.script_parameters = "brloot_super_munitionsbox";
    fe [[ f ]]( s, us, cf, ( 3525.66, 1544.99, 697.4 ), ( 0, 290, 0 ), "staged_items", undefined, "staged_item", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.script_parameters = "brloot_super_utilitybox";
    fe [[ f ]]( s, us, cf, ( 3070.11, 7617.08, 89.49 ), ( 0, 110, 0 ), "staged_items", undefined, "staged_item", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.script_parameters = "brloot_equip_gasmask";
    fe [[ f ]]( s, us, cf, ( 3649, -1622, 562 ), ( 0, 85, 270 ), "staged_items", undefined, "staged_item", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.script_parameters = "brloot_self_revive";
    fe [[ f ]]( s, us, cf, ( 176, -2672, 1578 ), ( 0, 185, -15 ), "staged_items", undefined, "staged_item", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.script_parameters = "brloot_plunder_cash_epic_2";
    fe [[ f ]]( s, us, cf, ( 3005, -5982, 606 ), ( 0, 57, 0 ), "staged_items", undefined, "staged_item", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.script_parameters = "brloot_super_utilitybox";
    fe [[ f ]]( s, us, cf, ( -1442.75, -6002.8, 741.78 ), ( 0, 310, 0 ), "staged_items", undefined, "staged_item", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.script_parameters = "brloot_self_revive";
    fe [[ f ]]( s, us, cf, ( 873, -5367, 748 ), ( 0, 176, 0 ), "staged_items", undefined, "staged_item", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.script_parameters = "brloot_super_utilitybox";
    fe [[ f ]]( s, us, cf, ( 4014, -8583, 87.1 ), ( 0, 50, 0 ), "staged_items", undefined, "staged_item", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.script_parameters = "brloot_self_revive";
    fe [[ f ]]( s, us, cf, ( -2962, -3809, 732 ), ( 0, 179, 0 ), "staged_items", undefined, "staged_item", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.script_parameters = "brloot_super_armorbox";
    fe [[ f ]]( s, us, cf, ( -4740, -4200, 223 ), ( 0, 349, 0 ), "staged_items", undefined, "staged_item", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.script_parameters = "brloot_self_revive";
    fe [[ f ]]( s, us, cf, ( -84, 1927, 1620 ), ( 2, 76, 0 ), "staged_items", undefined, "staged_item", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.script_parameters = "brloot_super_utilitybox";
    fe [[ f ]]( s, us, cf, ( 2951.02, 4368.85, 413.1 ), ( 0, 240, 0 ), "staged_items", undefined, "staged_item", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.script_parameters = "brloot_super_munitionsbox";
    fe [[ f ]]( s, us, cf, ( -7980.38, -296.59, -370.19 ), ( 356, 340.97, 0.37 ), "staged_items", undefined, "staged_item", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.script_parameters = "brloot_super_armorbox";
    fe [[ f ]]( s, us, cf, ( -7795.96, -127.09, -349.77 ), ( 359.05, 246.5, 20 ), "staged_items", undefined, "staged_item", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.challenge = "escape_bonote_3";
    s.name = "escape_note_3";
    fe [[ f ]]( s, us, cf, ( -2090, 10079, 852.7 ), ( 0.2, 213.6, -0 ), "escape_note_3", undefined, "stationary_note", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.name = "escape_hint_e";
    fe [[ f ]]( s, us, cf, ( 3812, -2525.25, 540 ), ( 270, 0, 76.77 ), "escape_hint_e", undefined, "stationary_note", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.name = "escape_hint_d";
    fe [[ f ]]( s, us, cf, ( 3354.75, 6014, 372 ), ( 270, 0, 96.88 ), "escape_hint_d", undefined, "stationary_note", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.challenge = "escape_bonote_7";
    s.name = "escape_note_7";
    fe [[ f ]]( s, us, cf, ( 3012, -5146, 612.5 ), ( 90, 35.8, 0 ), "escape_note_7", undefined, "stationary_note", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.name = "escape_hint_g";
    fe [[ f ]]( s, us, cf, ( -1811.5, 7868.5, 738.75 ), ( 270, 0, 91.79 ), "escape_hint_g", undefined, "stationary_note", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.name = "escape_hint_h";
    fe [[ f ]]( s, us, cf, ( 1492, -2324.25, 1561.5 ), ( 359.23, 88.21, -0 ), "escape_hint_h", undefined, "stationary_note", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.challenge = "escape_bonote_1";
    s.name = "escape_note_1";
    fe [[ f ]]( s, us, cf, ( -6612, -2008.25, 485 ), ( 7.93, 118.15, -0.39 ), "escape_note_1", undefined, "stationary_note", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.challenge = "escape_bonote_2";
    s.name = "escape_note_2";
    fe [[ f ]]( s, us, cf, ( -4461, 4433.75, 232.5 ), ( 357.67, 292.43, -0.22 ), "escape_note_2", undefined, "stationary_note", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.challenge = "escape_bonote_4";
    s.name = "escape_note_4";
    fe [[ f ]]( s, us, cf, ( 1423, 7726.75, 951.5 ), ( 0, 99.3, 90 ), "escape_note_4", undefined, "stationary_note", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.challenge = "escape_bonote_5";
    s.name = "escape_note_5";
    fe [[ f ]]( s, us, cf, ( 3962, -1966.25, 714 ), ( 357.86, 7.25, -21.62 ), "escape_note_5", undefined, "stationary_note", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.challenge = "escape_bonote_6";
    s.name = "escape_note_6";
    fe [[ f ]]( s, us, cf, ( 2278, -7970.25, 633.5 ), ( 358.6, 296.9, -0 ), "escape_note_6", undefined, "stationary_note", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.script_parameters = "brloot_weapon_sm_p04_chuck9_paintball";
    fe [[ f ]]( s, us, cf, ( -4282.25, 4633.25, 633.25 ), ( 339.11, 172.82, 78.09 ), "staged_blueprint", undefined, "staged_item", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.compositemodel = "1";
    s.script_parameters = "brloot_weapon_dm_scromeo_v6";
    fe [[ f ]]( s, us, cf, ( 2532.88, -8039.54, 635 ), ( 291.44, 298.33, -0.29 ), "staged_blueprint", undefined, "staged_item", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.compositemodel = "1";
    s.script_parameters = "brloot_weapon_sm_p12_roger31_flower";
    fe [[ f ]]( s, us, cf, ( -57, 897, 1545 ), ( 354.44, 1.54, -72.16 ), "staged_blueprint", undefined, "staged_item", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.compositemodel = "1";
    s.script_parameters = "brloot_weapon_ar_helima_v1";
    fe [[ f ]]( s, us, cf, ( -1079, -9437, 363 ), ( 359.04, 341.85, -85.57 ), "staged_blueprint", undefined, "staged_item", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.areaswap_name = "saw_escape_water_tower";
    s.areaswap_state = "Default";
    s.script_parameters = "brloot_weapon_sn_india_v13";
    fe [[ f ]]( s, us, cf, ( 197, 5143, 2516.25 ), ( 343.1, 9.76, -1.4 ), "staged_blueprint", undefined, "staged_item", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.script_parameters = "brloot_weapon_cp15_lm_mkilo3_v3016";
    fe [[ f ]]( s, us, cf, ( 2772, -1429, 220 ), ( 283.19, 76.44, -1.49 ), "staged_blueprint", undefined, "staged_item", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.areaswap_name = "saw_escape_lighthouse";
    s.areaswap_state = "Default";
    s.script_parameters = "brloot_weapon_jp37_dm_kappa98_v6519";
    fe [[ f ]]( s, us, cf, ( 368, -2611.25, 2529.5 ), ( 282.07, 299.31, 53.1 ), "staged_blueprint", undefined, "staged_item", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_escape_master_cs";
    s.script_parameters = "brloot_weapon_ar_p45_kent_swolf";
    fe [[ f ]]( s, us, cf, ( -3323.09, -3196, 1055 ), ( 0.2, 136.74, -88.21 ), "staged_blueprint", undefined, "staged_item", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_saw_escape_master_cs
// Params 0, eflags: 0x4
// Checksum 0x6de63481, Offset: 0x184a
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_saw_escape_master_cs
// Params 0
// Checksum 0xc5d0e95, Offset: 0x1854
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_saw_escape_master_cs" );
}

