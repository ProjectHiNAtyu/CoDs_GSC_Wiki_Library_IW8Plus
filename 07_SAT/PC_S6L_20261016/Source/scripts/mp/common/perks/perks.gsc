// scripts\mp\common\perks\perks.gsc  (hash_4ca4a30b15eb95bb.gscc) (size: 55292 Bytes / 0xd7fc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xedc9c4bd (3989423293)
// size ...... 55292 (0xd7fc)
// includes .. 17  (offset: 0xbe7c)
// strings ... 473 (offset: 0xbf04)
// dev strs .. 10  (offset: 0xd784)
// exports ... 62  (offset: 0x7c18)
// cseg ...... 0x3147 + 0x4ad1 (0x7c18)
// imports ... 452 (offset: 0x85c8)
// animtree1 . 0   (offset: 0xd7fc)
// animtree2 . 0   (offset: 0xd7fc)
#using script_70ac8a06d80020b0;
#using scripts\common\callbacks;
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\mp\armor;
#using scripts\mp\class;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\perks\perk_equipmentping;
#using scripts\mp\common\perks\perkfunctions;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\stealth\utility;
#using scripts\mp\talking_gun;
#using scripts\mp\weapons;

#namespace perks;

// Namespace perks
// Params 0
// Checksum 0x2ebb5470, Offset: 0x3165
// Size: 0x2176
function init()
{
    level thread perkfunctions::supersprintkillrefresh_init();
    level thread perkfunctions::lrdetector_think();
    level thread perkfunctions::signalJammer_think();
    level thread perkfunctions::cricketinit();
    perk_equipmentping::init();
    level.scriptperks = [];
    level.codeperks = [];
    level.perksetfuncs = [];
    level.perkunsetfuncs = [];
    level.extraperkmap = [];
    level.menurigperks = [];
    level.var_101584e8c0a24f05 = [];
    level.var_ff0d4d8bcaeda64a = [];
    game[ "dialog" ][ "specialty_restock" ] = "iw9_perk_prks_uktl_pers";
    game[ "dialog" ][ "specialty_hardline" ] = "iw9_perk_prks_uktl_pehl";
    game[ "dialog" ][ "specialty_tactical_recon" ] = "iw9_perk_prks_uktl_pesp";
    game[ "dialog" ][ "specialty_focus" ] = "iw9_perk_prks_uktl_pefc";
    game[ "dialog" ][ "specialty_warhead" ] = "iw9_perk_prks_uktl_pefh";
    game[ "dialog" ][ "specialty_quick_fix" ] = "iw9_perk_prks_uktl_peqf";
    game[ "dialog" ][ "specialty_surveillance" ] = "iw9_perk_prks_uktl_peha";
    game[ "dialog" ][ "specialty_guerrilla" ] = "iw9_perk_prks_uktl_pegh";
    game[ "dialog" ][ "specialty_overwatch" ] = "iw9_perk_prks_uktl_pebe";
    game[ "dialog" ][ "specialty_survivor" ] = "iw9_perk_prks_uktl_pesv";
    game[ "dialog" ][ "specialty_overcharge_field_upgrade" ] = "iw9_perk_prks_uktl_peoc";
    game[ "dialog" ][ "specialty_combat_medic" ] = "iw9_perk_prks_uktl_pecm";
    
    if ( perk::function_93baad77ae8e5757() )
    {
        level.useperkpackage = 1;
    }
    
    level.var_6be22fc94dc3b131 = getdvarfloat( @"hash_bb66c3a69c1f7a8f", 1.5 );
    level.var_f069716209ee75db = getdvarint( @"hash_f8af3c2d327b9c23", 50 );
    level.headhuntermaxrange = getdvarfloat( @"hash_5ec956fb006e323b", 1000 );
    level.var_eb0cb5067c72f229 = getdvarfloat( @"hash_8a028a50e729f737", 1500 );
    level.var_2ab3ff8456131beb = getdvarfloat( @"hash_a94acd8cd69c8ec1", 1.25 );
    level.var_1099f076e66a8a09 = getdvarfloat( @"hash_2a137455a7c25493", 1 );
    function_1819f1ec76eb45a5();
    registerscriptperk( "specialty_fasterlockon", undefined, undefined );
    registerscriptperk( "specialty_rex_default_perks", undefined, undefined, [ "specialty_pistoldraw", "specialty_fasterlockon" ] );
    registerscriptperk( "specialty_ub_guided_missile", undefined, undefined );
    registerscriptperk( "specialty_cricket", undefined, undefined );
    registerscriptperk( "specialty_stamina_refresh", undefined, undefined );
    registerscriptperk( "specialty_weight_swift", undefined, undefined, [ "specialty_supersprint_enhanced" ] );
    registerscriptperk( "specialty_weight_encumbered", undefined, undefined, [ "specialty_supersprint_encumbered" ] );
    registerscriptperk( "specialty_eod_with_self_protection", undefined, undefined, [ "specialty_eod" ] );
    registerscriptperk( "specialty_dmz_impact_smokes", &perkfunctions::function_f36e2e30ffc151f2, &perkfunctions::function_f78a5439fa7b5357 );
    registerscriptperk( "specialty_dmz_overwatch_radio", &perkfunctions::function_271ba0f1374e2e9c, &perkfunctions::function_854fff275d22cb93 );
    registerscriptperk( "specialty_dmz_search_kit", &perkfunctions::function_fa766b2eb1ff9cba, &perkfunctions::function_44d850ab2447eca9 );
    registerscriptperk( "specialty_dmz_thermal_tracker", undefined, undefined, [ "specialty_tracker_pro" ] );
    registerscriptperk( "specialty_dmz_sensor_cam", undefined, undefined, [ "specialty_sixth_sense" ] );
    registerscriptperk( "specialty_dmz_plate_pouch", &perkfunctions::function_c775dc12e5354b5d, &perkfunctions::function_59a67331f0cb8998 );
    registerscriptperk( "specialty_dmz_first_aid_pouch", undefined, undefined, [ "specialty_revived_faster", "specialty_revive_teammates_faster" ] );
    registerscriptperk( "specialty_dmz_modular_ghillie", undefined, undefined, [ "specialty_ghost" ] );
    registerscriptperk( "specialty_infinite_tacsprint", undefined, undefined, [ "specialty_infinitestamina" ] );
    registerscriptperk( "specialty_loadout_slow", undefined, undefined, [] );
    registerscriptperk( "specialty_loadout_fast", undefined, undefined, [ "specialty_longslide" ] );
    registerscriptperk( "specialty_loadout_veryfast", undefined, undefined, [ "specialty_longslide", "specialty_infinite_tacsprint" ] );
    registerscriptperk( "specialty_gunfight_perks", &perkfunctions::function_a3f92efd68179bc7, undefined, [ "specialty_blastshield", "specialty_tac_resist", "specialty_recharge_equipment" ] );
    registerscriptperk( "specialty_infantry_vest", undefined, undefined, [ "specialty_supersprint_enhanced" ] );
    registerscriptperk( "specialty_grenadier_vest", undefined, undefined, [ "specialty_recharge_equipment" ] );
    registerscriptperk( "specialty_overkill_vest", undefined, undefined, [ "specialty_quickswap", "specialty_munitions_2", "specialty_sprintreload" ] );
    registerscriptperk( "specialty_tac_vest", undefined, undefined, [ "specialty_engineer", "specialty_markequipment", "specialty_faster_field_upgrade", "specialty_improved_field_upgrades" ] );
    registerscriptperk( "specialty_gunner_vest", undefined, undefined, [ "specialty_munitions_2", "specialty_extraammo", "specialty_fastreload" ] );
    registerscriptperk( "specialty_cct_vest", &perkfunctions::function_dbb41248e5cce834, &perkfunctions::function_d84740731971dc17, [ "specialty_acousticSensor", "specialty_intel_jacker", "specialty_expanded_minimap" ] );
    registerscriptperk( "specialty_scout_vest", undefined, undefined, [ "specialty_silentkill", "specialty_ghost" ] );
    registerscriptperk( "specialty_marksman_vest", undefined, undefined, [ "specialty_viewkickoverride" ] );
    registerscriptperk( "specialty_ninja_vest", undefined, undefined, [ "specialty_quieter", "specialty_no_battle_chatter", "specialty_recharge_equipment", "specialty_extra_deadly", "specialty_dauntless" ] );
    registerscriptperk( "specialty_pistol_vest", undefined, undefined, [ "specialty_super_sprint_kill_refresh", "specialty_fastreload", "specialty_extraammo", "specialty_sprintreload", "specialty_quickswap" ] );
    registerscriptperk( "specialty_compression_carrier_vest", undefined, undefined, [ "specialty_regen_on_kill", "specialty_regen_on_objective_capture", "specialty_tac_mask" ] );
    registerscriptperk( "specialty_rhino_rig", undefined, undefined, [ "specialty_extraammo", "specialty_scavenger_equipment", "specialty_scavenger" ] );
    registerscriptperk( "specialty_tac_mask", &perkfunctions::settacmask, &perkfunctions::unsettacmask );
    registerscriptperk( "specialty_blacklight_flashlight", undefined, undefined, [ "specialty_tracker" ] );
    registerscriptperk( "specialty_bone_conduction", &perkfunctions::function_f1b0da7787d1de76, &perkfunctions::function_951916310f2669b3 );
    registerscriptperk( "specialty_lr_detector", &perkfunctions::setlrdetector, &perkfunctions::unsetlrdetector );
    registerscriptperk( "specialty_eod_vest", undefined, undefined, [ "specialty_blastshield", "specialty_shrapnel_resist" ] );
    registerscriptperk( "specialty_ghost_camo", undefined, undefined, [ "specialty_ghost", "specialty_heartbreaker" ] );
    registerscriptperk( "specialty_fast_reload", undefined, undefined, [ "specialty_fastreload" ] );
    registerscriptperk( "specialty_high_gain_antenna", &perkfunctions::function_dbb41248e5cce834, &perkfunctions::function_d84740731971dc17, [ "specialty_expanded_minimap" ] );
    registerscriptperk( "specialty_compression_plate", undefined, undefined, [ "specialty_regen_on_kill", "specialty_regen_on_objective_capture" ] );
    registerscriptperk( "specialty_dex_gloves", undefined, undefined, [ "specialty_fastoffhand", "specialty_pitcher", "specialty_throwback" ] );
    registerscriptperk( "specialty_tac_gloves", undefined, undefined, [ "specialty_jump_aim_scale" ] );
    registerscriptperk( "specialty_silicon_gloves", undefined, undefined, [ "specialty_sprintreload" ] );
    registerscriptperk( "specialty_marksman_gloves", undefined, undefined, [ "specialty_viewkickoverride", "specialty_reducedsway" ] );
    registerscriptperk( "specialty_ninja_gloves", undefined, undefined, [ "specialty_extendedmelee", "specialty_mantle_scale", "specialty_fastladderclimb" ] );
    registerscriptperk( "specialty_canvas_sneakers", undefined, undefined, [ "specialty_quieter", "specialty_no_battle_chatter" ] );
    registerscriptperk( "specialty_ultra_light_boots", undefined, undefined, [ "specialty_lightweight", "specialty_maritime_boots" ] );
    registerscriptperk( "specialty_tac_pads", undefined, undefined, [ "specialty_fastcrouchmovement", "specialty_longslide", "specialty_fasttransition", "specialty_sliding_ads" ] );
    registerscriptperk( "specialty_running_sneakers", undefined, undefined, [ "specialty_supersprint_enhanced" ] );
    registerscriptperk( "specialty_treadless_boots", undefined, undefined, [ "specialty_mantle_scale", "specialty_fastladderclimb", "specialty_fall_damage_scale" ] );
    registerscriptperk( "specialty_stalker_boots", undefined, undefined, [ "specialty_strafe_and_ads_move_speed", "specialty_ads_bob_scale" ] );
    registerscriptperk( "specialty_dauntless_boots", undefined, undefined, [ "specialty_dauntless" ] );
    registerscriptperk( "specialty_super_strength", undefined, undefined );
    registerscriptperk( "specialty_durability", &perkfunctions::setdurability, &perkfunctions::unsetdurability );
    registerscriptperk( "specialty_super_speed", &perkfunctions::setsuperspeed, &perkfunctions::unsetsuperspeed );
    registerscriptperk( "specialty_enhanced_minimap", &perkfunctions::function_dbb41248e5cce834, &perkfunctions::function_d84740731971dc17, [ "specialty_expanded_minimap" ] );
    registerscriptperk( "specialty_acoustic_sensor", undefined, undefined, [ "specialty_acousticSensor" ] );
    registerscriptperk( "specialty_signal_jammer", &perkfunctions::setsignaljammer, &perkfunctions::unsetsignaljammer, [ "specialty_delaymine" ] );
    registerscriptperk( "specialty_radio_intercept", undefined, undefined );
    registerscriptperk( "specialty_shielded_electronics", undefined, undefined, [ "specialty_shock_immunity", "specialty_emp_immunity" ] );
    registerscriptperk( "specialty_thermal_insulation", undefined, undefined, [ "specialty_coldblooded" ] );
    registerscriptperk( "specialty_extra_plate", &perkfunctions::function_a38118f90c3fdb8, &perkfunctions::function_20920d82ddd7f555 );
    registerscriptperk( "specialty_monomer_plate", undefined, undefined, [ "specialty_blastshield", "specialty_shrapnel_resist" ] );
    registerscriptperk( "specialty_thermal_camo", undefined, undefined, [ "specialty_ghost" ] );
    registerscriptperk( "specialty_elasomer_pads", &perkfunctions::function_c33564fdb1204df2, &perkfunctions::function_af8e0c9892ab706f );
    registerscriptperk( "specialty_flame_res_insulation", undefined, undefined, [ "specialty_coldblooded" ] );
    registerscriptperk( "specialty_shock_immunity", undefined, undefined );
    registerscriptperk( "specialty_fast_armor", undefined, undefined );
    registerscriptperk( "specialty_lightweight_vest", undefined, undefined, [ "specialty_lightweight", "specialty_maritime_boots" ] );
    registerscriptperk( "specialty_impact_res_gloves", undefined, undefined, [ "specialty_fastermelee", "specialty_extendedmelee" ] );
    registerscriptperk( "specialty_maritime_boots", &perkfunctions::function_ae30c17379be69cd, &perkfunctions::function_fba0a841ec46489a, [ "specialty_quietswim" ] );
    registerscriptperk( "specialty_nods", &perkfunctions::setnods, &perkfunctions::unsetnods );
    registerscriptperk( "specialty_taccom_system", &perkfunctions::settaccom, &perkfunctions::unsettaccom );
    registerscriptperk( "specialty_assault_gloves", undefined, undefined, [ "specialty_fastsprintrecovery" ] );
    registerscriptperk( "specialty_dauntless", undefined, undefined );
    registerscriptperk( "specialty_compression_carrier", undefined, undefined, [ "specialty_elasomer_pads", "specialty_regen_on_kill" ] );
    registerscriptperk( "specialty_custom_gloves", undefined, undefined, [ "specialty_quickswap", "specialty_fastoffhand" ] );
    registerscriptperk( "specialty_hijacked_iff_strobe", undefined, undefined, [ "specialty_noplayertarget", "specialty_blindeye", "specialty_noscopeoutline" ] );
    registerscriptperk( "specialty_br_movement_mod", &perkfunctions::function_fff7a0358ed34419, &perkfunctions::function_2536cd7a9a7c0c2, [ "specialty_quickswap", "specialty_melee_infinite_tac_sprint" ] );
    
    if ( !isbrgamemode() )
    {
        registerscriptperk( "specialty_outlander", &perkfunctions::setoutlander, &perkfunctions::unsetoutlander );
        registerscriptperk( "specialty_shroud" );
    }
    
    registerscriptperk( "specialty_adrenaline", &perkfunctions::function_1b294f1fd95a639c, &perkfunctions::function_d6a26ff0ffbcca13, [ "specialty_fastcrouch" ] );
    registerscriptperk( "specialty_uav_tower_discount", &perkfunctions::function_9bbd59fb188c4958, &perkfunctions::function_b18dc1eb47068b19 );
    registerscriptperk( "specialty_contract_payout", &perkfunctions::function_3c706efa8353065e, &perkfunctions::function_d23a839bdb7c5657, [ "specialty_uav_tower_discount" ] );
    registerscriptperk( "specialty_lightweight_br", &perkfunctions::function_97390db64b0bcff6, &perkfunctions::function_1623f7e271aa7855 );
    registerscriptperk( "specialty_reduce_vehicle_repair_time", &perkfunctions::function_bce2a7da8e9aaa18, &perkfunctions::function_a0eaacbeb295e85b );
    registerscriptperk( "specialty_reduce_vehicle_refill_time", &perkfunctions::function_63dd61f2bb756611, &perkfunctions::function_f763b10a60848216 );
    registerscriptperk( "specialty_reduce_vehicle_fuel_usage", &perkfunctions::function_d10786a48612f59f, &perkfunctions::function_cadc32058803b5e );
    registerscriptperk( "specialty_mechanic", undefined, undefined, [ "specialty_reduce_vehicle_repair_time", "specialty_reduce_vehicle_refill_time", "specialty_reduce_vehicle_fuel_usage" ] );
    registerscriptperk( "specialty_scavenger_br", &perkfunctions::setscavenger, &perkfunctions::unsetscavenger, [ "specialty_scavenger" ] );
    registerscriptperk( "specialty_restock_br", undefined, undefined, [ "specialty_recharge_equipment" ] );
    registerscriptperk( "specialty_shrapnel_br", undefined, undefined, [ "specialty_explosive_slow", "specialty_explosive_regen_delay" ] );
    registerscriptperk( "specialty_treadless_boots_br", undefined, undefined, [ "specialty_fall_reduction" ] );
    registerscriptperk( "specialty_tac_pads_br", undefined, undefined, [ "specialty_sliding_ads" ] );
    registerscriptperk( "specialty_silicon_gloves_br", undefined, undefined, [ "specialty_bone_conduction", "specialty_signal_jammer" ] );
    registerscriptperk( "specialty_battlerage_reduce_damage", undefined, undefined );
    registerscriptperk( "specialty_tempered_br", undefined, undefined, [ "specialty_tempered_effect" ] );
    registerscriptperk( "specialty_reduced_death_tax", &perkfunctions::function_28838db7975c4ab, &perkfunctions::function_e25a8e4383767e44 );
    registerscriptperk( "specialty_revive_teammates_faster", &perkfunctions::function_8a08a6e976d284cf, &perkfunctions::function_41291b8a52213092 );
    registerscriptperk( "specialty_survivor_br", undefined, undefined, [ "specialty_revived_faster", "specialty_revive_teammates_faster", "specialty_reduced_death_tax", "specialty_faster_health_regen", "specialty_ping_attacker_on_laststand" ] );
    registerscriptperk( "specialty_snapshot_counter_smoke", undefined, undefined );
    registerscriptperk( "specialty_explosive_regen_halt", &perkfunctions::setexplosiveregenhalt, &perkfunctions::unsetexplosiveregenhalt );
    registerscriptperk( "specialty_battle_ready", &perkfunctions::function_83dbfe8dfca4da8b, &perkfunctions::function_de1a45cc0c81a0c4 );
    registerscriptperk( "specialty_bandolier", &perkfunctions::setbandolier, &perkfunctions::unsetbandolier );
    registerscriptperk( "specialty_ante_up", &perkfunctions::setanteup, &perkfunctions::unsetanteup );
    registerscriptperk( "specialty_scavenger_ammo_and_equipment", undefined, undefined, [ "specialty_scavenger" ] );
    registerscriptperk( "specialty_outline_killstreak_distance_limited", undefined, undefined, [ "specialty_outlinekillstreaks" ] );
    registerscriptperk( "specialty_support_streaker", &perkfunctions::function_d216200231680410, &perkfunctions::function_1e1efff76d8a2fcf, [ "specialty_killstreak_to_scorestreak" ], &perkfunctions::function_6a537b8942d4f8ea );
    
    if ( !level.var_60698a0462b4bdcc )
    {
        registerscriptperk( "specialty_emp_immunity" );
    }
    
    registerscriptperk( "specialty_gas_immunity" );
    registerscriptperk( "specialty_hallucination_immunity" );
    registerscriptperk( "specialty_coldblooded_and_hidden", undefined, undefined, [ "specialty_blindeye", "specialty_noscopeoutline", "specialty_coldblooded", "specialty_noplayertarget" ] );
    registercodeperkinfo( "specialty_combat_medic", &perkfunctions::setcombatmedic, &perkfunctions::unsetcombatmedic, [ "specialty_reduce_regen_delay_on_objective" ] );
    registerscriptperk( "specialty_headhunter", undefined, undefined, undefined );
    registerscriptperk( "specialty_armored", &perkfunctions::setarmored, &perkfunctions::unsetarmored, undefined );
    registerscriptperk( "specialty_surveillance", undefined, undefined, [ "specialty_sixth_sense" ] );
    registercodeperkinfo( "specialty_snakecam", undefined, undefined, undefined );
    registerscriptperk( "specialty_pc_medic", undefined, undefined, [ "specialty_revived_faster", "specialty_revive_teammates_faster", "specialty_reduced_death_tax", "specialty_faster_health_regen", "specialty_ping_attacker_on_laststand" ] );
    registerscriptperk( "specialty_pc_comms", &perkfunctions::function_271ba0f1374e2e9c, &perkfunctions::function_854fff275d22cb93 );
    registerscriptperk( "specialty_pc_stealth", &perkfunctions::function_72fbe49594529b4a, &perkfunctions::function_a43e4b2108c33369, [ "specialty_ghost", "specialty_heartbreaker" ] );
    registerscriptperk( "specialty_pc_tempered", undefined, undefined, [ "specialty_tempered_effect" ] );
    registerscriptperk( "specialty_pc_high_capacity", &perkfunctions::function_454a06381c946fbb, &perkfunctions::function_4217611c148026a6 );
    registerscriptperk( "specialty_super_protection" );
    registerscriptperk( "specialty_heavy_metal", undefined, undefined, [ "specialty_chain_killstreaks", "specialty_br_extra_killstreak_chance" ] );
    registerscriptperk( "specialty_strategist", undefined, undefined, [ "specialty_killstreak_to_scorestreak", "specialty_br_better_mission_rewards" ] );
    registerscriptperk( "specialty_third_person", &perkfunctions::setthirdpersonmode, &perkfunctions::function_1a8b6c7b9a39972 );
    registerscriptperk( "specialty_tune_up", undefined, undefined, [ "specialty_improved_field_upgrades", "specialty_faster_field_upgrade", "specialty_25_percent_faster_revive" ] );
    registerscriptperk( "specialty_extra_shrapnel", undefined, undefined, [ "specialty_extra_deadly", "specialty_shrapnel" ] );
    registerscriptperk( "specialty_specialist_bonus", &perkfunctions::setspecialistbonus, &perkfunctions::unsetspecialistbonus );
    registerscriptperk( "specialty_sonar", undefined, undefined, [ "specialty_always_minimap" ] );
    registerscriptperk( "specialty_healer", &perkfunctions::sethealer, &perkfunctions::unsethealer );
    registerscriptperk( "specialty_breacher", &perkfunctions::setbreacher, &perkfunctions::unsetbreacher );
    registerscriptperk( "specialty_door_breach", &perkfunctions::setdoorbreach, &perkfunctions::unsetdoorbreach );
    registerscriptperk( "specialty_killstreak_to_scorestreak", &perkfunctions::setkillstreaktoscorestreak, &perkfunctions::unsetkillstreaktoscorestreak );
    registerscriptperk( "specialty_super_sprint_kill_refresh" );
    registerscriptperk( "specialty_scrap_weapons", &perkfunctions::setscrapweapons, &perkfunctions::unsetscrapweapons );
    registerscriptperk( "specialty_door_alarm", &perkfunctions::setdooralarm, &perkfunctions::unsetdooralarm );
    registerscriptperk( "specialty_always_minimap", &perkfunctions::setalwaysminimap, &perkfunctions::unsetalwaysminimap );
    registerscriptperk( "specialty_shrapnel" );
    registerscriptperk( "specialty_team_scavenger" );
    registerscriptperk( "specialty_fastreload_launchers", &perkfunctions::setfastreloadlaunchers, &perkfunctions::unsetfastreloadlaunchers );
    registerscriptperk( "speciality_undying", &perkfunctions::setundying, &perkfunctions::unsetundying );
    registerscriptperk( "specialty_br_cheaper_kiosk" );
    registerscriptperk( "specialty_25_percent_faster_revive" );
    registerscriptperk( "specialty_br_better_mission_rewards", &perkfunctions::setbettermissionrewards, &perkfunctions::unsetbettermissionrewards );
    registerscriptperk( "specialty_br_extra_killstreak_chance" );
    registerscriptperk( "specialty_regenfaster", &perkfunctions::setregenfaster, &perkfunctions::unsetregenfaster );
    registerscriptperk( "specialty_medic" );
    registerscriptperk( "specialty_can_be_revived" );
    registerscriptperk( "specialty_ads_mark_target", &perkfunctions::setadsmarktarget, &perkfunctions::unsetadsmarktarget );
    registerscriptperk( "specialty_armorvest", &perkfunctions::setarmorvest, &perkfunctions::unsetarmorvest );
    registerscriptperk( "specialty_helmet", &perkfunctions::sethelmet, &perkfunctions::unsethelmet );
    registerscriptperk( "specialty_extra_deadly", undefined, undefined );
    registerscriptperk( "specialty_remote_defuse", &perkfunctions::setremotedefuse, &perkfunctions::unsetremotedefuse );
    registerscriptperk( "specialty_improved_target_mark" );
    registerscriptperk( "specialty_door_sense", &perkfunctions::setdoorsense, &perkfunctions::unsetdoorsense );
    registerscriptperk( "specialty_worsenedgunkick", &perkfunctions::setworsenedgunkick, &perkfunctions::unsetworsenedgunkick );
    registerscriptperk( "specialty_ammo_disabling" );
    registerscriptperk( "specialty_gunperk_xp" );
    registerscriptperk( "specialty_swimming", undefined, undefined, [ "specialty_spygame", "specialty_coldblooded" ] );
    registerscriptperk( "specialty_afterburner", &perkfunctions::setafterburner, &perkfunctions::unsetafterburner, [ "specialty_thruster" ] );
    registerscriptperk( "specialty_autospot", &perkfunctions::setautospot, &perkfunctions::unsetautospot );
    registerscriptperk( "specialty_boom", &perkfunctions::setboom, &perkfunctions::unsetboom );
    registerscriptperk( "specialty_delaymine", &perkfunctions::setdelaymine, &perkfunctions::unsetdelaymine );
    registerscriptperk( "specialty_hardwired", undefined, undefined, [ "specialty_tracker_jammer", "specialty_noscopeoutline", "specialty_empimmune" ] );
    registerscriptperk( "specialty_empimmune", &perkfunctions::setempimmune, &perkfunctions::unsetempimmune );
    registerscriptperk( "specialty_explosivedamage" );
    registerscriptperk( "specialty_falldamage", &perkfunctions::setfreefall, &perkfunctions::unsetfreefall );
    registerscriptperk( "specialty_powercell", &perkfunctions::setpowercell, &perkfunctions::unsetpowercell );
    registerscriptperk( "specialty_incog", &perkfunctions::setincog, &perkfunctions::unsetincog );
    registerscriptperk( "specialty_localjammer", &perkfunctions::setlocaljammer, &perkfunctions::unsetlocaljammer );
    registerscriptperk( "specialty_overclock", &perkfunctions::setoverclock, &perkfunctions::unsetoverclock );
    registerscriptperk( "specialty_pitcher", &perkfunctions::setpitcher, &perkfunctions::unsetpitcher, [ "specialty_throwback" ] );
    registerscriptperk( "specialty_bullet_outline", &perkfunctions::setbulletoutline, &perkfunctions::unsetbulletoutline );
    registerscriptperk( "specialty_activereload", &perkfunctions::setactivereload, &perkfunctions::unsetactivereload );
    registerscriptperk( "specialty_enhanced_sixth_sense", &perkfunctions::setenhancedsixthsense, &perkfunctions::unsetenhancedsixthsense );
    registerscriptperk( "specialty_meleekill", &perkfunctions::setmeleekill, &perkfunctions::unsetmeleekill );
    registerscriptperk( "specialty_gung_ho" );
    registerscriptperk( "specialty_man_at_arms", &perkfunctions::setmanatarms, &perkfunctions::unsetmanatarms, [ "specialty_extraammo", "specialty_overrideweaponspeed" ] );
    registerscriptperk( "specialty_momentum", &perkfunctions::setmomentum, &perkfunctions::unsetmomentum );
    registerscriptperk( "specialty_improvedmelee", &perkfunctions::setimprovedmelee, &perkfunctions::unsetimprovedmelee, [ "specialty_extendedmelee", "specialty_fastermelee", "specialty_thief" ] );
    registerscriptperk( "specialty_thief", &perkfunctions::setthief, &perkfunctions::unsetthief );
    registerscriptperk( "specialty_silentkill" );
    registerscriptperk( "specialty_armorpiercingks" );
    registerscriptperk( "specialty_fastcrouch", &perkfunctions::setfastcrouch, &perkfunctions::unsetfastcrouch );
    registerscriptperk( "specialty_bulletdamage", undefined, undefined, [ "specialty_overcharge", "specialty_worsenedgunkick" ] );
    registerscriptperk( "specialty_solobuddyboost", &perkfunctions::setsolobuddyboost, &perkfunctions::unsetsolobuddyboost );
    registerscriptperk( "specialty_offhand_provider", &perkfunctions::setoffhandprovider, &perkfunctions::unsetoffhandprovider );
    registerscriptperk( "specialty_glintreduce" );
    registerscriptperk( "specialty_extra_planted_equipment" );
    registerscriptperk( "specialty_bulletsuppress", &perkfunctions::setbulletsuppress, &perkfunctions::unsetbulletsuppress );
    registercodeperkinfo( "specialty_spawn_protection" );
    registerscriptperk( "specialty_battleslide", &perkfunctions::setbattleslide, &perkfunctions::unsetbattleslide );
    registerscriptperk( "specialty_battleslide_offense", &perkfunctions::setbattleslideoffense, &perkfunctions::unsetbattleslideoffense );
    registerscriptperk( "specialty_battleslide_shield", &perkfunctions::setbattleslideshield, &perkfunctions::unsetbattleslideshield );
    registerscriptperk( "specialty_disruptor_punch", &perkfunctions::setdisruptorpunch, &perkfunctions::unsetdisruptorpunch );
    registerscriptperk( "specialty_ground_pound", &perkfunctions::setgroundpound, &perkfunctions::unsetgroundpound );
    registerscriptperk( "specialty_ground_pound_shield", &perkfunctions::setgroundpoundshield, &perkfunctions::unsetgroundpoundshield );
    registerscriptperk( "specialty_ground_pound_shock", &perkfunctions::setgroundpoundshock, &perkfunctions::unsetgroundpoundshock );
    registerscriptperk( "specialty_thruster", &perkfunctions::setthruster, &perkfunctions::unsetthruster );
    registerscriptperk( "specialty_dodge", &perkfunctions::setdodge, &perkfunctions::unsetdodge );
    registerscriptperk( "specialty_extra_dodge", &perkfunctions::setextradodge, &perkfunctions::unsetextradodge );
    registerscriptperk( "specialty_extend_dodge", &perkfunctions::setextenddodge, &perkfunctions::unsetextenddodge );
    registerscriptperk( "specialty_phase_slide", &perkfunctions::setphaseslide, &perkfunctions::unsetphaseslide );
    registerscriptperk( "specialty_tele_slide", &perkfunctions::setteleslide, &perkfunctions::unsetteleslide );
    registerscriptperk( "specialty_phaseslash", undefined, undefined, [ "specialty_phaseslash_rephase" ] );
    registerscriptperk( "specialty_phaseslash_rephase", &perkfunctions::setphaseslashrephase, &perkfunctions::unsetphaseslashrephase );
    registerscriptperk( "specialty_phase_fall", &perkfunctions::setphasefall, &perkfunctions::unsetphasefall );
    registerscriptperk( "specialty_aura_quickswap", &perkfunctions::setauraquickswap, &perkfunctions::unsetauraquickswap );
    registerscriptperk( "specialty_aura_speed", &perkfunctions::setauraspeed, &perkfunctions::unsetauraspeed );
    registerscriptperk( "specialty_mark_targets", &perkfunctions::setmarktargets, &perkfunctions::unsetmarktargets );
    registerscriptperk( "specialty_batterypack", &perkfunctions::setbatterypack, &perkfunctions::unsetbatterypack );
    registerscriptperk( "specialty_camo_elite", &perkfunctions::setcamoelite, &perkfunctions::unsetcamoelite );
    registerscriptperk( "specialty_scorestreakpack", &perkfunctions::setscorestreakpack, &perkfunctions::unsetscorestreakpack );
    registerscriptperk( "specialty_superpack", &perkfunctions::setsuperpack, &perkfunctions::unsetsuperpack );
    registerscriptperk( "specialty_dodge_defense", &perkfunctions::setdodgedefense, &perkfunctions::unsetdodgedefense );
    registerscriptperk( "specialty_spawncloak", &perkfunctions::setspawncloak, &perkfunctions::unsetspawncloak );
    registerscriptperk( "specialty_commando" );
    registerscriptperk( "specialty_personal_trophy", &perkfunctions::setpersonaltrophy, &perkfunctions::unsetpersonaltrophy );
    registerscriptperk( "specialty_equipment_ping", &perkfunctions::setequipmentping, &perkfunctions::unsetequipmentping, [ "specialty_paint" ] );
    registerscriptperk( "specialty_cloak", &perkfunctions::setcloak, &perkfunctions::unsetcloak );
    registerscriptperk( "specialty_wall_lock", &perkfunctions::setwalllock, &perkfunctions::unsetwalllock );
    registerscriptperk( "specialty_rush", &perkfunctions::setrush, &perkfunctions::unsetrush );
    registerscriptperk( "specialty_hover", &perkfunctions::sethover, &perkfunctions::unsethover );
    registerscriptperk( "specialty_scavenger_eqp", &perkfunctions::setscavengereqp, &perkfunctions::unsetscavengereqp );
    registerscriptperk( "specialty_spawnview", &perkfunctions::setspawnview, &perkfunctions::unsetspawnview );
    registerscriptperk( "specialty_headgear", &perkfunctions::setheadgear, &perkfunctions::unsetheadgear );
    registerscriptperk( "specialty_ftlslide", &perkfunctions::setftlslide, &perkfunctions::unsetftlslide );
    registerscriptperk( "specialty_improved_prone", &perkfunctions::setimprovedprone, &perkfunctions::unsetimprovedprone );
    registerscriptperk( "specialty_support_killstreaks", &perkfunctions::setsupportkillstreaks, &perkfunctions::unsetsupportkillstreaks );
    registerscriptperk( "specialty_overrideweaponspeed", &perkfunctions::setoverrideweaponspeed, &perkfunctions::unsetoverrideweaponspeed );
    registerscriptperk( "specialty_cloak_aerial", &perkfunctions::setcloakaerial, &perkfunctions::unsetcloakaerial );
    registerscriptperk( "specialty_spawn_radar", &perkfunctions::setspawnradar, &perkfunctions::unsetspawnradar );
    registerscriptperk( "specialty_ads_awareness", &perkfunctions::setadsawareness, &perkfunctions::unsetadsawareness );
    registerscriptperk( "specialty_rearguard", &perkfunctions::setrearguard, &perkfunctions::unsetrearguard );
    registerscriptperk( "specialty_rugged_eqp" );
    registerscriptperk( "specialty_sharp_focus", &perkfunctions::setsharpfocus, &perkfunctions::unsetsharpfocus );
    registerscriptperk( "specialty_bling" );
    registerscriptperk( "specialty_comexp", &perkfunctions::setcomexp, &perkfunctions::unsetcomexp );
    registerscriptperk( "specialty_paint" );
    registerscriptperk( "specialty_paint_pro" );
    registerscriptperk( "specialty_steadyaimpro", &perkfunctions::setsteadyaimpro, &perkfunctions::unsetsteadyaimpro );
    registerscriptperk( "specialty_block_health_regen", &perkfunctions::setblockhealthregen, &perkfunctions::unsetblockhealthregen );
    registerscriptperk( "specialty_rshieldradar", &perkfunctions::setrshieldradar, &perkfunctions::unsetrshieldradar );
    registerscriptperk( "specialty_rshieldscrambler", &perkfunctions::setrshieldscrambler, &perkfunctions::unsetrshieldscrambler );
    registerscriptperk( "specialty_delayhealing" );
    registerscriptperk( "specialty_wounding" );
    registerscriptperk( "specialty_explosivebullet" );
    registerscriptperk( "specialty_armorpiercing" );
    registerscriptperk( "specialty_hardmelee" );
    registerscriptperk( "specialty_highlight" );
    registerscriptperk( "specialty_incendiary" );
    registerscriptperk( "specialty_incendiary_alt" );
    registerscriptperk( "specialty_ub_flamethrower" );
    registerscriptperk( "specialty_glintxsml" );
    registerscriptperk( "specialty_glintsml" );
    registerscriptperk( "specialty_glintmed" );
    registerscriptperk( "specialty_glintlrg" );
    registerscriptperk( "specialty_glintxlrg" );
    registerscriptperk( "specialty_glint_shotgun_strobe" );
    registerscriptperk( "specialty_extraclip" );
    registerscriptperk( "specialty_smags" );
    registerscriptperk( "specialty_akimbo" );
    registerscriptperk( "specialty_gunmelee" );
    registerscriptperk( "specialty_gunshield" );
    registerscriptperk( "specialty_magwell", undefined, undefined, [ "specialty_fastreload" ] );
    registerscriptperk( "specialty_molotov_shots", &perkfunctions::function_17340d217eb1c8ad, &perkfunctions::function_90048b4936a8e84c );
    registerscriptperk( "specialty_stealth_shot" );
    registerscriptperk( "specialty_doublebarrel", &perkfunctions::setdoublebarrel, &perkfunctions::unsetdoublebarrel );
    registerscriptperk( "specialty_targetfinder" );
    registerscriptperk( "specialty_range_indicator" );
    registerscriptperk( "specialty_dive_fire", &perkfunctions::setdivefire, &perkfunctions::unsetdivefire );
    registerscriptperk( "specialty_ammo_uranium" );
    registerscriptperk( "specialty_super_sniper" );
    registerscriptperk( "specialty_dynamic_stance", &perkfunctions::function_451bb0f2335700f7, &perkfunctions::function_214dadcb1c3f25a4 );
    registerscriptperk( "specialty_heavy_sniper", &perkfunctions::function_343e6628f48d83ce, &perkfunctions::function_66423ea5dee68a31 );
    registerscriptperk( "specialty_heavy_launcher", &perkfunctions::function_fe4bee78e7a77d39, &perkfunctions::function_90071494daf5b7de );
    registerscriptperk( "specialty_ub_conc" );
    registerscriptperk( "specialty_ub_db" );
    registerscriptperk( "specialty_ub_drill" );
    registerscriptperk( "specialty_ub_flash" );
    registerscriptperk( "specialty_ub_gas" );
    registerscriptperk( "specialty_ub_semtex" );
    registerscriptperk( "specialty_ub_shock" );
    registerscriptperk( "specialty_ub_smoke" );
    registerscriptperk( "specialty_ub_snap" );
    registerscriptperk( "specialty_ub_crossbow" );
    registerscriptperk( "specialty_combathigh", &perkfunctions::setcombathigh, &perkfunctions::unsetcombathigh );
    registerscriptperk( "specialty_juiced", &perkfunctions::setjuiced, &perkfunctions::unsetjuiced );
    registerscriptperk( "specialty_revenge", &perkfunctions::setrevenge, &perkfunctions::unsetrevenge );
    registerscriptperk( "specialty_light_armor", &perkfunctions::setlightarmor, &perkfunctions::unsetlightarmor );
    registerscriptperk( "specialty_carepackage", &perkfunctions::setcarepackage, &perkfunctions::unsetcarepackage );
    registerscriptperk( "specialty_stopping_power" );
    registerscriptperk( "specialty_uav", &perkfunctions::setuav, &perkfunctions::unsetuav );
    registerscriptperk( "specialty_viewkickoverride", &perkfunctions::setviewkickoverride, &perkfunctions::unsetviewkickoverride );
    registerscriptperk( "specialty_affinityspeedboost", &perkfunctions::setaffinityspeedboost, &perkfunctions::unsetaffinityspeedboost );
    registerscriptperk( "specialty_affinityextralauncher", &perkfunctions::setaffinityextralauncher, &perkfunctions::unsetaffinityextralauncher );
    registerscriptperk( "specialty_equip_throwingKnife", &perkfunctions::setthrowingknifemelee, &perkfunctions::unsetthrowingknifemelee );
    registerscriptperk( "specialty_tacticalinsertion", &perkfunctions::settacticalinsertion, &perkfunctions::unsettacticalinsertion );
    registerscriptperk( "specialty_rogue_snapshotkills", undefined, undefined );
    registerscriptperk( "specialty_rogue_smokeheals", undefined, undefined );
    registerscriptperk( "specialty_rogue_infinitetacsprint", undefined, undefined );
    registerscriptperk( "specialty_rogue_instantsmoke", undefined, undefined );
    registerscriptperk( "specialty_rogue_shockstickkills", undefined, undefined );
    registerscriptperk( "specialty_talkinggun_test1", &perkfunctions::function_36736e40b14d6fa6, &perkfunctions::unsettalkinggun );
    registerscriptperk( "specialty_talkinggun_test2", &perkfunctions::function_36736d40b14d6d73, &perkfunctions::unsettalkinggun );
    registerscriptperk( "specialty_talkinggun_test3", &perkfunctions::function_36736c40b14d6b40, &perkfunctions::unsettalkinggun );
    registerscriptperk( "specialty_talkinggun_test4", &perkfunctions::function_36737340b14d7aa5, &perkfunctions::unsettalkinggun );
    registerscriptperk( "specialty_talkinggun_announcer", &perkfunctions::function_6b2a299d4c0ef3c6, &perkfunctions::unsettalkinggun );
    registerscriptperk( "specialty_talkinggun_robot", &perkfunctions::function_db94b7f360ebac2d, &perkfunctions::unsettalkinggun );
    registerscriptperk( "specialty_talkinggun_blackcell", &talking_gun::function_73c9168087346b36, &talking_gun::unsettalkinggun );
    registerscriptperk( "specialty_talkinggun_npc", &talking_gun::function_15e3538fe309e206, &talking_gun::unsettalkinggun );
    registerscriptperk( "specialty_talkinggun_cat", &talking_gun::function_cd149d8fad91add9, &talking_gun::unsettalkinggun );
    registerscriptperk( "specialty_talkinggun_dog", &talking_gun::function_bc4d618fa06fea5f, &talking_gun::unsettalkinggun );
    registerscriptperk( "specialty_doomscreen", &talking_gun::function_eb8115c4726caa5a, &talking_gun::doomscreen_removeplayer );
    registerscriptperk( "specialty_ai_stealth_sixth_sense", &utility::function_eb7bf654aceb23c5, &utility::function_f63fbae3ac4450a0 );
    registerscriptperk( "specialty_null" );
    registercodeperkinfo( "specialty_thermal", &perkfunctions::setthermal, &perkfunctions::unsetthermal );
    registercodeperkinfo( "specialty_lightweight", undefined, undefined );
    registercodeperkinfo( "specialty_steelnerves", &perkfunctions::setsteelnerves, &perkfunctions::unsetsteelnerves );
    registercodeperkinfo( "specialty_saboteur", &perkfunctions::setsaboteur, &perkfunctions::unsetsaboteur );
    registercodeperkinfo( "specialty_endgame", &perkfunctions::setendgame, &perkfunctions::unsetendgame );
    registercodeperkinfo( "specialty_onemanarmy", &perkfunctions::setonemanarmy, &perkfunctions::unsetonemanarmy );
    registercodeperkinfo( "specialty_weaponlaser", &perkfunctions::setweaponlaser, &perkfunctions::unsetweaponlaser );
    registercodeperkinfo( "specialty_marksman", &perkfunctions::setmarksman, &perkfunctions::unsetmarksman );
    registercodeperkinfo( "specialty_holdbreath", undefined, undefined );
    registercodeperkinfo( "specialty_fastermelee", undefined, undefined );
    registercodeperkinfo( "specialty_double_load", &perkfunctions::setdoubleload, &perkfunctions::unsetdoubleload );
    registercodeperkinfo( "specialty_overkill_pro", &perkfunctions::setoverkillpro, &perkfunctions::unsetoverkillpro );
    registercodeperkinfo( "specialty_refill_grenades", &perkfunctions::setrefillgrenades, &perkfunctions::unsetrefillgrenades );
    registercodeperkinfo( "specialty_refill_ammo", &perkfunctions::setrefillammo, &perkfunctions::unsetrefillammo );
    registercodeperkinfo( "specialty_combat_speed", &perkfunctions::setcombatspeed, &perkfunctions::unsetcombatspeed );
    registercodeperkinfo( "specialty_tagger", &perkfunctions::settagger, &perkfunctions::unsettagger );
    registercodeperkinfo( "specialty_triggerhappy", &perkfunctions::settriggerhappy, &perkfunctions::unsettriggerhappy );
    registercodeperkinfo( "specialty_quickswap", &perkfunctions::setquickswap, &perkfunctions::unsetquickswap );
    registercodeperkinfo( "specialty_extra_equipment" );
    registercodeperkinfo( "specialty_lifepack", &perkfunctions::setlifepack, &perkfunctions::unsetlifepack );
    registercodeperkinfo( "specialty_toughenup", &perkfunctions::settoughenup, &perkfunctions::unsettoughenup );
    registercodeperkinfo( "specialty_scoutping", &perkfunctions::setscoutping, &perkfunctions::unsetscoutping );
    registercodeperkinfo( "specialty_phase_speed", &perkfunctions::setphasespeed, &perkfunctions::unsetphasespeed );
    registercodeperkinfo( "specialty_camo_clone", &perkfunctions::setcamoclone, &perkfunctions::unsetcamoclone );
    registercodeperkinfo( "specialty_improvedgunkick" );
    registercodeperkinfo( "specialty_sprintfire" );
    registercodeperkinfo( "specialty_overcharge", &perkfunctions::setovercharge, &perkfunctions::unsetovercharge );
    registercodeperkinfo( "specialty_noscopeoutline", &perkfunctions::setnoscopeoutline, &perkfunctions::unsetnoscopeoutline );
    registercodeperkinfo( "specialty_spygame" );
    registercodeperkinfo( "specialty_dexterity" );
    registercodeperkinfo( "specialty_criticalaim" );
    registercodeperkinfo( "specialty_self_tracked", undefined, undefined );
    registerperkparams = spawnstruct();
    registerperkparams.var_bf34439fc0ca3cec = &registerscriptperk;
    registerperkparams.var_a2358848c4408242 = &registercodeperkinfo;
    registerperkparams.var_5109b530c69d18a1 = &function_87bac4ebd8ae0c75;
    registerperkparams.var_e70a4bc6bfd6dbc = &function_91641a8b00f51d90;
    callback::callback( #"register_perk", registerperkparams );
    callback::remove( #"register_perk", #"all" );
    initperkdvars();
    level thread onplayerconnect();
}

// Namespace perks
// Params 5
// Checksum 0x6f1d0ba, Offset: 0x52e3
// Size: 0x41
function registerscriptperk( perkname, setfunc, unsetfunc, extraperkmap, initfunc )
{
    registerperk( perkname, 1, setfunc, unsetfunc, extraperkmap, initfunc );
}

// Namespace perks
// Params 5
// Checksum 0x65cc811a, Offset: 0x532c
// Size: 0x40
function registercodeperkinfo( perkname, setfunc, unsetfunc, extraperkmap, initfunc )
{
    registerperk( perkname, 0, setfunc, unsetfunc, extraperkmap, initfunc );
}

// Namespace perks
// Params 6
// Checksum 0x3ab9a9ff, Offset: 0x5374
// Size: 0x21d
function registerperk( perkname, var_aecfe35a5ddcafb5, setfunc, unsetfunc, extraperkmap, initfunc )
{
    assert( isdefined( perkname ) );
    assert( isarray( level.perkbundles ), "<dev string:x24>" );
    
    if ( function_18992260198358cb( perkname ) && !isdefined( level.perkbundles[ perkname ] ) )
    {
        return;
    }
    
    assert( !isdefined( level.scriptperks[ perkname ] ), "<dev string:x61>" + perkname );
    
    if ( var_aecfe35a5ddcafb5 )
    {
        level.scriptperks[ perkname ] = 1;
    }
    else
    {
        level.codeperks[ perkname ] = 1;
    }
    
    if ( isdefined( setfunc ) )
    {
        assert( isfunction( setfunc ) );
        level.perksetfuncs[ perkname ] = setfunc;
    }
    
    if ( isdefined( unsetfunc ) )
    {
        assert( isfunction( unsetfunc ) );
        level.perkunsetfuncs[ perkname ] = unsetfunc;
    }
    
    var_2979799f4026fe76 = level.perkbundles[ perkname ].specialties;
    
    if ( var_2979799f4026fe76.size > 0 )
    {
        specialties = [];
        
        foreach ( entry in var_2979799f4026fe76 )
        {
            if ( entry.ref == "specialty_none" )
            {
                continue;
            }
            
            specialties[ specialties.size ] = entry.ref;
        }
        
        if ( specialties.size > 0 )
        {
            level.extraperkmap[ perkname ] = specialties;
        }
    }
    else if ( isdefined( extraperkmap ) )
    {
        assert( isarray( extraperkmap ) );
        level.extraperkmap[ perkname ] = extraperkmap;
    }
    
    if ( isdefined( initfunc ) )
    {
        assert( isfunction( initfunc ) );
        level [[ initfunc ]]();
    }
}

// Namespace perks
// Params 2
// Checksum 0xc3927d98, Offset: 0x5599
// Size: 0x47
function function_87bac4ebd8ae0c75( perkname, onkillcallback )
{
    assert( isdefined( perkname ) );
    assert( isfunction( onkillcallback ) );
    level.var_101584e8c0a24f05[ perkname ] = { #var_d3a2a267bf4c73d8:onkillcallback };
}

// Namespace perks
// Params 2
// Checksum 0x87c07c9a, Offset: 0x55e8
// Size: 0x31
function function_91641a8b00f51d90( perkname, var_9287235a47bfdafd )
{
    assert( isfunction( var_9287235a47bfdafd ) );
    level.var_ff0d4d8bcaeda64a[ perkname ] = var_9287235a47bfdafd;
}

// Namespace perks
// Params 1
// Checksum 0xd2328682, Offset: 0x5621
// Size: 0x2a, Type: bool
function function_ae69f867e887ac4a( perkname )
{
    return isdefined( level.scriptperks[ perkname ] ) || isdefined( level.codeperks[ perkname ] );
}

// Namespace perks
// Params 1
// Checksum 0xb0bc6870, Offset: 0x5654
// Size: 0x19, Type: bool
function function_18992260198358cb( perkname )
{
    return isdefined( level.cacperks[ perkname ] );
}

// Namespace perks
// Params 0
// Checksum 0x36ac425e, Offset: 0x5676
// Size: 0xdc
function function_1819f1ec76eb45a5()
{
    if ( !isdefined( level.perkbundles ) )
    {
        level.perkbundles = [];
    }
    
    level.var_918d3444c8676d26 = [];
    level.var_d16acbef1602ec53 = [];
    level.cacperks = [];
    level.var_fadc1b38f6006441 = [];
    var_c741d5499c5302ce = undefined;
    str_list = level.gametypebundle.perk_list ?? level.gamemodebundle.perk_list;
    assert( isdefined( str_list ), "<dev string:x89>" );
    var_c741d5499c5302ce = getscriptbundle( "perklist:" + str_list );
    assert( isdefined( var_c741d5499c5302ce ), "<dev string:xd6>" );
    assert( isdefined( var_c741d5499c5302ce.perk_list ) );
    
    if ( !isdefined( var_c741d5499c5302ce.perk_list ) )
    {
        return;
    }
    
    function_57f498240cd883a3( var_c741d5499c5302ce );
}

// Namespace perks
// Params 1, eflags: 0x4
// Checksum 0x23fd6011, Offset: 0x575a
// Size: 0x430
function private function_57f498240cd883a3( var_c741d5499c5302ce )
{
    level.var_6e428b8946955e28 = var_c741d5499c5302ce.bonus_perk_list;
    var_8df066fb78a2ff90 = [];
    
    if ( isdefined( level.var_6e428b8946955e28 ) )
    {
        foreach ( var_8ce8d93781ae0220 in level.var_6e428b8946955e28 )
        {
            if ( isdefined( var_8ce8d93781ae0220.bundle ) )
            {
                var_8df066fb78a2ff90[ var_8ce8d93781ae0220.bundle ] = 1;
            }
        }
    }
    
    init_specialty_null = 1;
    validid = 0;
    var_5db40ce354acf098 = 0;
    var_5c27c837e8fbbd3c = getdvarint( @"hash_dd35c46527e7cb11", 1 );
    
    foreach ( id, var_e21f9eb0a8bbe316 in var_c741d5499c5302ce.perk_list )
    {
        if ( !isdefined( var_e21f9eb0a8bbe316 ) )
        {
            continue;
        }
        
        perkref = var_e21f9eb0a8bbe316.ref;
        
        if ( !isdefined( perkref ) )
        {
            continue;
        }
        
        if ( !var_e21f9eb0a8bbe316.var_cf6ea49a9c245dfb )
        {
            level.cacperks[ perkref ] = perkref;
        }
        
        if ( init_specialty_null == 0 && perkref == "specialty_null" )
        {
            continue;
        }
        
        perkbundlename = var_e21f9eb0a8bbe316.bundle;
        
        if ( !isdefined( perkbundlename ) )
        {
            continue;
        }
        
        if ( perkbundlename == "replace_me" )
        {
            continue;
        }
        
        if ( perkbundlename == %"hash_3636afb8639a35a5" )
        {
            bundle = { #unused:1 };
        }
        else
        {
            bundle = function_568f797e7642c672( "perk", perkbundlename );
            
            if ( var_5c27c837e8fbbd3c )
            {
                bundle.brdesc = undefined;
                bundle.cpdesc = undefined;
                bundle.displayname = undefined;
                bundle.unlocktype = undefined;
                bundle.rarity = undefined;
                bundle.visibilitylevel = undefined;
                bundle.availableprojects = undefined;
                bundle.unlockableprojects = undefined;
                bundle.availableoffline = undefined;
                bundle.var_15642e668475ba1a = undefined;
                bundle.availablegamemodes = undefined;
                bundle.var_7352c2073d1e6cec = undefined;
                bundle.var_5cfb1af2fd2e5eac = undefined;
                bundle.image = undefined;
                bundle.bwimage = undefined;
                bundle.progressionimage = undefined;
                bundle.var_218b0b7f7d2fb507 = undefined;
                bundle.specialistmodel = undefined;
                bundle.skillcategory = undefined;
                bundle.var_51105b5ef8a7b11d = undefined;
                bundle.var_dd2ca46c476bca0c = undefined;
                bundle.var_69de9b67bcea4ffe = undefined;
                bundle.gunbenchoffsets = undefined;
                bundle.currencycost = undefined;
                bundle.var_52ec9d15cbe72a7b = undefined;
                bundle.var_4e7f78dc38b740d6 = undefined;
                bundle.var_79be7a4f24551746 = undefined;
                bundle.var_23a6bc800441f3fe = undefined;
                bundle.var_6c914eeb973e2cbf = undefined;
                bundle.var_b1301cd4c50e8692 = undefined;
            }
        }
        
        if ( !isdefined( bundle ) )
        {
            continue;
        }
        
        if ( var_8df066fb78a2ff90[ perkbundlename ] )
        {
            level.var_5ca0738fa58d5896[ perkbundlename ] = perkref;
        }
        
        level.perkbundles[ perkref ] = bundle;
        level.var_918d3444c8676d26[ perkref ] = perkbundlename;
        level.var_d16acbef1602ec53[ perkref ] = id;
        level.var_fadc1b38f6006441[ perkref ] = validid;
        validid++;
        
        if ( common_item::items_isenabled() )
        {
            bundlename = common_item_database::function_a4f0a21951180013( perkref );
        }
        
        if ( isdefined( bundlename ) )
        {
            level.var_d97c85f03eff6eca[ perkref ] = var_5db40ce354acf098;
            var_5db40ce354acf098++;
        }
        
        if ( isdefined( bundle.specialistvo ) )
        {
            game[ "dialog" ][ perkref ] = bundle.specialistvo;
        }
    }
}

// Namespace perks
// Params 0
// Checksum 0x4e9e72e5, Offset: 0x5b92
// Size: 0x4a
function initspecialistkillstreaks()
{
    killstreaks::registerkillstreak( "specialist_perk_1", undefined, &onspecialistkillstreakavailable );
    killstreaks::registerkillstreak( "specialist_perk_2", undefined, &onspecialistkillstreakavailable );
    killstreaks::registerkillstreak( "specialist_perk_3", undefined, &onspecialistkillstreakavailable );
    killstreaks::registerkillstreak( "specialist_perk_bonus", undefined, &onspecialistbonusavailable );
}

// Namespace perks
// Params 1
// Checksum 0x77937db0, Offset: 0x5be4
// Size: 0x4a
function onspecialistkillstreakavailable( streakitem )
{
    perk = getspecialistperkforstreak( streakitem.streakname );
    assert( isdefined( perk ), "<dev string:x10b>" );
    
    if ( !isdefined( perk ) )
    {
        return;
    }
    
    perk::giveperk( perk );
}

// Namespace perks
// Params 1
// Checksum 0x50c07bb5, Offset: 0x5c36
// Size: 0x3f
function getspecialistperkforstreak( streakname )
{
    specialistindex = getspecialistindexforstreak( streakname );
    
    if ( specialistindex == -1 )
    {
        return;
    }
    
    return self.classstruct.loadoutextraperks[ specialistindex ];
}

// Namespace perks
// Params 1
// Checksum 0xc27a3c66, Offset: 0x5c7e
// Size: 0x4b
function getspecialistindexforstreak( streakname )
{
    if ( !isdefined( streakname ) )
    {
        return -1;
    }
    
    if ( streakname == "specialist_perk_1" )
    {
        return 0;
    }
    
    if ( streakname == "specialist_perk_2" )
    {
        return 1;
    }
    
    if ( streakname == "specialist_perk_3" )
    {
        return 2;
    }
    
    return -1;
}

// Namespace perks
// Params 1
// Checksum 0x92340299, Offset: 0x5cd1
// Size: 0x57
function isspecialiststreak( streakname )
{
    switch ( streakname )
    {
        case #"hash_25daf4f1a090db48":
        case #"hash_25daf5f1a090dcdb":
        case #"hash_25daf7f1a090e001":
        case #"hash_894c703f54088bdd":
            return 1;
        default:
            return 0;
    }
}

// Namespace perks
// Params 1
// Checksum 0xb01df0aa, Offset: 0x5d30
// Size: 0x13
function onspecialistbonusavailable( streakitem )
{
    addspecialistbonus();
}

// Namespace perks
// Params 0
// Checksum 0x9fc3ae64, Offset: 0x5d4b
// Size: 0xc8
function addspecialistbonus()
{
    isbr = isbrgamemode();
    
    foreach ( perk, bundle in level.perkbundles )
    {
        var_49bcbabb372980c3 = isbr ? istrue( bundle.specialistbr ) : istrue( bundle.specialist );
        
        if ( !var_49bcbabb372980c3 )
        {
            continue;
        }
        
        if ( perkisrestricted( perk ) )
        {
            continue;
        }
        
        perk::giveperk( perk );
    }
}

// Namespace perks
// Params 0
// Checksum 0x5740e5b9, Offset: 0x5e1b
// Size: 0xc8
function removespecialistbonus()
{
    isbr = isbrgamemode();
    
    foreach ( perk, bundle in level.perkbundles )
    {
        var_49bcbabb372980c3 = isbr ? istrue( bundle.specialistbr ) : istrue( bundle.specialist );
        
        if ( !var_49bcbabb372980c3 )
        {
            continue;
        }
        
        if ( perkisrestricted( perk ) )
        {
            continue;
        }
        
        perk::removeperk( perk );
    }
}

// Namespace perks
// Params 0
// Checksum 0xb4149633, Offset: 0x5eeb
// Size: 0xc1
function getavailableperks()
{
    availableperks = [];
    
    foreach ( perkref in level.cacperks )
    {
        if ( isdefined( self.perks[ perkref ] ) )
        {
            continue;
        }
        
        bundle = level.perkbundles[ perkref ];
        
        if ( !bundle.var_883566fc1e9d2da3 )
        {
            continue;
        }
        
        availableperks[ availableperks.size ] = perkref;
    }
    
    return availableperks;
}

// Namespace perks
// Params 0
// Checksum 0xf9fc741a, Offset: 0x5fb5
// Size: 0xb7
function function_73c2b12682fac654()
{
    if ( !level.var_d7d40d3f55e9fae4 )
    {
        level.var_d7d40d3f55e9fae4 = [];
        
        foreach ( perkref, perkbundle in level.perkbundles )
        {
            if ( perkbundle.var_883566fc1e9d2da3 )
            {
                level.var_d7d40d3f55e9fae4[ level.var_d7d40d3f55e9fae4.size ] = perkref;
            }
        }
    }
    
    return level.var_d7d40d3f55e9fae4;
}

// Namespace perks
// Params 1
// Checksum 0x9737618b, Offset: 0x6075
// Size: 0x22
function getperkslot( perkref )
{
    return level.perkbundles[ perkref ].menuslot;
}

// Namespace perks
// Params 1
// Checksum 0xabbadf6e, Offset: 0x60a0
// Size: 0x22
function function_a9816793933d64bb( perkref )
{
    return level.perkbundles[ perkref ].var_a362c1b75ace930f;
}

// Namespace perks
// Params 1
// Checksum 0x12670455, Offset: 0x60cb
// Size: 0x22
function function_fb163b91d0e32565( perkref )
{
    return level.perkbundles[ perkref ].var_a5109ca42cf62f91;
}

// Namespace perks
// Params 0
// Checksum 0x28d3ada9, Offset: 0x60f6
// Size: 0x82
function onplayerconnect()
{
    for ( ;; )
    {
        level waittill( #"connected", player );
        player.perks = [];
        player.perksblocked = [];
        player.weaponlist = [];
        
        if ( level.var_23fd0662f9c4b4a1 )
        {
            player.pers[ "perkPackageTier3State" ] = 2;
            player.pers[ "perkPackageTier2Earned" ] = 1;
        }
        
        function_9d8f7b75857e27d4( player );
    }
}

// Namespace perks
// Params 1
// Checksum 0xdf7786be, Offset: 0x6180
// Size: 0xef
function function_9d8f7b75857e27d4( newplayer )
{
    totalcharge = 0;
    
    foreach ( player in level.players )
    {
        if ( isdefined( player.pers[ "perkPackageProgress" ] ) )
        {
            totalcharge += player.pers[ "perkPackageProgress" ];
        }
    }
    
    averagecharge = 0;
    
    if ( level.players.size > 0 )
    {
        averagecharge = totalcharge / level.players.size;
    }
    
    newplayer.pers[ "perkPackageProgress" ] = averagecharge;
}

// Namespace perks
// Params 0
// Checksum 0x3009a673, Offset: 0x6277
// Size: 0x18f
function initperkdvars()
{
    level.graceperiodgrenademod = 0.08;
    level.armorpiercingmod = 1.5;
    level.incendiaryammomod = 1.5;
    level.explosiveammomod = 1.75;
    level.regenfasterhealthmod = dvars::getintproperty( @"perk_fastregenrate", 2 );
    level.explosivedamagemod = dvars::getintproperty( @"perk_explosivedamage", 40 ) / 100;
    level.riotshieldmod = dvars::getintproperty( @"perk_riotshield", 100 ) / 100;
    level.armorvestbulletdelta = dvars::getintproperty( @"perk_armorvest", 1 );
    level.var_845b45f01d427c37 = dvars::getfloatproperty( @"hash_811e77d419715fbc", 0.8 );
    level.minspeed = dvars::getintproperty( @"perk_gpsjammer_min_speed", 100 );
    level.mindistance = dvars::getintproperty( @"perk_gpsjammer_min_distance", 10 );
    level.timeperiod = dvars::getintproperty( @"perk_gpsjammer_time_period", 200 ) / 1000;
    level.minspeedsq = level.minspeed * level.minspeed;
    level.mindistancesq = level.mindistance * level.mindistance;
    
    if ( namespace_5ab67a14d18bea3f::function_43c57123ed24d409() && !isdvardefined( @"hash_de884e7ed943c255" ) )
    {
        level.var_eb62b8140e51bb38 = 0;
        return;
    }
    
    level.var_eb62b8140e51bb38 = getdvarint( @"hash_de884e7ed943c255", 1 );
}

// Namespace perks
// Params 1
// Checksum 0xd95dad84, Offset: 0x640e
// Size: 0x95
function giveperks( loadoutperks )
{
    foreach ( perk in loadoutperks )
    {
        if ( perk != "none" && perk != "specialty_null" )
        {
            class::loadout_giveperk( perk );
        }
    }
}

// Namespace perks
// Params 2
// Checksum 0xb0084c75, Offset: 0x64ab
// Size: 0x10e
function _setperk( perkname, var_4b2b3dc56d37a58 )
{
    assert( isdefined( perkname ), "<dev string:x156>" + perkname + "<dev string:x16a>" );
    
    if ( !isdefined( self.perks ) )
    {
        self.perks = [];
    }
    
    if ( !isdefined( var_4b2b3dc56d37a58 ) )
    {
        var_4b2b3dc56d37a58 = "";
    }
    
    if ( !isdefined( self.perks[ perkname ] ) )
    {
        self.perks[ perkname ] = [];
        self.perks[ perkname ][ var_4b2b3dc56d37a58 ] = 1;
    }
    else if ( !isdefined( self.perks[ perkname ][ var_4b2b3dc56d37a58 ] ) )
    {
        self.perks[ perkname ][ var_4b2b3dc56d37a58 ] = 1;
    }
    else
    {
        self.perks[ perkname ][ var_4b2b3dc56d37a58 ]++;
    }
    
    if ( !perk::function_2f0f457290bf8326( perkname ) )
    {
        if ( function_74d8a2083b4dba89( perkname ) )
        {
            var_4b2b3dc56d37a58 = function_5f3646eb13ddcac4( perkname );
        }
        
        _setperkinternal( perkname, var_4b2b3dc56d37a58 );
    }
    
    if ( level.var_4a80db199e77d451 )
    {
        level notify( #"hash_a62eebca5ebf646b", self, perkname );
    }
    
    /#
        level notify( #"hash_b21f590d1568ec6d" );
    #/
}

// Namespace perks
// Params 2
// Checksum 0x8f6dc4d1, Offset: 0x65c1
// Size: 0x70
function _setperkinternal( perkname, var_4b2b3dc56d37a58 )
{
    perksetfunc = level.perksetfuncs[ perkname ];
    
    if ( isdefined( perksetfunc ) )
    {
        self thread [[ perksetfunc ]]();
    }
    
    var_4b2b3dc56d37a58 = var_4b2b3dc56d37a58 == "" ? undefined : var_4b2b3dc56d37a58;
    self setperk( perkname, !isdefined( level.scriptperks[ perkname ] ), var_4b2b3dc56d37a58 );
    level.var_31086716d15138bb = gettime();
}

// Namespace perks
// Params 2
// Checksum 0x937f51a4, Offset: 0x6639
// Size: 0x196
function _setextraperks( perkname, var_4b2b3dc56d37a58 )
{
    perkbundle = level.perkbundles[ perkname ];
    var_eab6ad569b951ac4 = perkbundle.var_a5d76fb18838d51d == #"hash_9afdde78a1557103";
    var_bfd84e0a2871c4f2 = perkbundle.var_823806fcd58043fb ?? 1;
    
    if ( var_bfd84e0a2871c4f2 )
    {
        if ( isdefined( level.extraperkmap[ perkname ] ) )
        {
            foreach ( extraperk in level.extraperkmap[ perkname ] )
            {
                if ( var_eab6ad569b951ac4 )
                {
                    self.var_9842326056fd7207 = level.perkbundles[ extraperk ] ?? perkbundle;
                    
                    if ( self.var_9842326056fd7207 )
                    {
                        self.var_9842326056fd7207.ref = level.perkbundles[ extraperk ] ? extraperk : perkname;
                    }
                }
                
                _setperk( extraperk, var_4b2b3dc56d37a58 );
                _setextraperks( extraperk, var_4b2b3dc56d37a58 );
            }
        }
        
        if ( var_eab6ad569b951ac4 )
        {
            self.var_9842326056fd7207 = perkbundle;
            
            if ( self.var_9842326056fd7207 )
            {
                self.var_9842326056fd7207.ref = perkname;
            }
        }
    }
    
    /#
        level notify( #"hash_b21f590d1568ec6d" );
    #/
}

// Namespace perks
// Params 2
// Checksum 0x12fbc1ed, Offset: 0x67d7
// Size: 0xe1
function _unsetextraperks( perkname, var_4b2b3dc56d37a58 )
{
    perkbundle = level.perkbundles[ perkname ];
    var_bfd84e0a2871c4f2 = perkbundle.var_823806fcd58043fb ?? 1;
    
    if ( var_bfd84e0a2871c4f2 )
    {
        if ( isdefined( level.extraperkmap[ perkname ] ) )
        {
            foreach ( extraperk in level.extraperkmap[ perkname ] )
            {
                _unsetperk( extraperk, var_4b2b3dc56d37a58 );
                _unsetextraperks( extraperk, var_4b2b3dc56d37a58 );
            }
        }
    }
}

// Namespace perks
// Params 2
// Checksum 0x2b47e491, Offset: 0x68c0
// Size: 0x13f
function _unsetperk( perkname, var_4b2b3dc56d37a58 )
{
    if ( !isdefined( self.perks[ perkname ] ) )
    {
        return;
    }
    
    assert( function_80dd74eda1e2dfc6( perkname ) > 0 || isdefined( level.perks_suppressasserts ), "<dev string:x186>" + perkname );
    
    if ( !isdefined( var_4b2b3dc56d37a58 ) )
    {
        var_4b2b3dc56d37a58 = "";
    }
    
    self.perks[ perkname ][ var_4b2b3dc56d37a58 ]--;
    
    if ( function_7f2569ef0f6dd6ff( perkname, var_4b2b3dc56d37a58 ) == 0 )
    {
        self.perks[ perkname ][ var_4b2b3dc56d37a58 ] = undefined;
        
        if ( !perk::function_2f0f457290bf8326( perkname ) )
        {
            _unsetperkinternal( perkname );
        }
        
        var_a22b8f3431f99dd2 = function_80dd74eda1e2dfc6( perkname );
        
        if ( var_a22b8f3431f99dd2 == 0 )
        {
            self.perks[ perkname ] = undefined;
        }
        else if ( var_a22b8f3431f99dd2 == 1 )
        {
            _setperkinternal( perkname, getfirstarraykey( self.perks[ perkname ] ) );
        }
        else if ( function_74d8a2083b4dba89( perkname ) )
        {
            var_4b2b3dc56d37a58 = function_5f3646eb13ddcac4( perkname );
            _setperkinternal( perkname, var_4b2b3dc56d37a58 );
        }
    }
    
    if ( level.var_4a80db199e77d451 )
    {
        level notify( #"hash_35294f60ed646d06", self, perkname );
    }
    
    level.var_31086716d15138bb = gettime();
    
    /#
        level notify( #"hash_b21f590d1568ec6d" );
    #/
}

// Namespace perks
// Params 1
// Checksum 0x9c216d03, Offset: 0x6a07
// Size: 0x42
function _unsetperkinternal( perkname )
{
    if ( isdefined( level.perkunsetfuncs[ perkname ] ) )
    {
        self thread [[ level.perkunsetfuncs[ perkname ] ]]();
    }
    
    self unsetperk( perkname, !isdefined( level.scriptperks[ perkname ] ) );
}

// Namespace perks
// Params 1
// Checksum 0xb68b051, Offset: 0x6a51
// Size: 0x17, Type: bool
function function_74d8a2083b4dba89( perkname )
{
    return function_80dd74eda1e2dfc6( perkname ) >= 2;
}

// Namespace perks
// Params 1
// Checksum 0x9fb65e7c, Offset: 0x6a71
// Size: 0x42
function function_5f3646eb13ddcac4( perkname )
{
    var_9287235a47bfdafd = level.var_ff0d4d8bcaeda64a[ perkname ];
    assert( isdefined( var_9287235a47bfdafd ), "<dev string:x1b5>" + perkname + "<dev string:x1f9>" );
    return self [[ var_9287235a47bfdafd ]]();
}

// Namespace perks
// Params 0
// Checksum 0xc7e20f09, Offset: 0x6abc
// Size: 0x106
function _clearperks()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( self.perks ) )
    {
        foreach ( perkname, perkvalue in self.perks )
        {
            if ( isdefined( level.perkunsetfuncs[ perkname ] ) )
            {
                self [[ level.perkunsetfuncs[ perkname ] ]]();
                
                if ( !self )
                {
                    if ( !isdefined( var_dda5793d34876a87 ) )
                    {
                        var_dda5793d34876a87 = "<none>";
                    }
                    
                    script::function_2e2007575f92910d( "_clearPerks: self was undefined after calling the unset function for '" + perkname + "'. Previous unset was '" + var_dda5793d34876a87 + "'" );
                    return;
                }
                
                var_dda5793d34876a87 = perkname;
            }
        }
    }
    
    self.perks = [];
    self.perksblocked = [];
    self.weaponperks = [];
    self clearperks();
}

// Namespace perks
// Params 0
// Checksum 0x7376a7ac, Offset: 0x6bca
// Size: 0xef
function function_ba54294fdf887724()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    var_dd190e172ec5777a = arraycopy( self.perks );
    
    foreach ( perkname, perkvalue in var_dd190e172ec5777a )
    {
        if ( weapons::weapon_hasperk( perkname ) )
        {
            continue;
        }
        
        if ( isdefined( level.perkunsetfuncs[ perkname ] ) )
        {
            self [[ level.perkunsetfuncs[ perkname ] ]]();
        }
        
        self.perks[ perkname ] = undefined;
        self unsetperk( perkname, !isdefined( level.scriptperks[ perkname ] ) );
    }
    
    self.perks = function_f943bef551ff028c( self.perks );
}

// Namespace perks
// Params 0
// Checksum 0x2e0d5bed, Offset: 0x6cc1
// Size: 0xff
function function_aa47e658394516c1()
{
    if ( !isdefined( self ) || !isdefined( self.perks ) )
    {
        return;
    }
    
    var_dd190e172ec5777a = arraycopy( self.perks );
    
    foreach ( perkname, perkvalue in var_dd190e172ec5777a )
    {
        if ( !weapons::weapon_hasperk( perkname ) )
        {
            continue;
        }
        
        if ( isdefined( level.perkunsetfuncs[ perkname ] ) )
        {
            self [[ level.perkunsetfuncs[ perkname ] ]]();
        }
        
        self.perks[ perkname ] = undefined;
        self unsetperk( perkname, !isdefined( level.scriptperks[ perkname ] ) );
    }
    
    self.perks = function_f943bef551ff028c( self.perks );
}

// Namespace perks
// Params 0
// Checksum 0x929b8bf9, Offset: 0x6dc8
// Size: 0xc4
function giveperksafterspawn()
{
    self endon( #"death_or_disconnect" );
    self endon( #"joined_spectators" );
    self endon( #"giveloadout_start" );
    self endon( #"loadout_perks_cleared" );
    activespawnprotection = spawnstruct();
    activespawnprotection.perks = [];
    function_1b2d74e64268e159( activespawnprotection, "specialty_blindeye" );
    function_1b2d74e64268e159( activespawnprotection, "specialty_gpsjammer" );
    function_1b2d74e64268e159( activespawnprotection, "specialty_noscopeoutline" );
    function_1b2d74e64268e159( activespawnprotection, "specialty_gas_grenade_resist" );
    function_1b2d74e64268e159( activespawnprotection, "specialty_spawn_protection" );
    perkfunctions::function_43f07b5bbe813394( self.avoidkillstreakonspawntimer );
    self.avoidkillstreakonspawntimer = undefined;
    function_1f68dcaacf9be9f7( activespawnprotection );
    self notify( #"hash_8546449be1f6bef9" );
}

// Namespace perks
// Params 2
// Checksum 0xb5cc64d9, Offset: 0x6e94
// Size: 0x42
function function_1b2d74e64268e159( activespawnprotection, perkname )
{
    activespawnprotection.perks[ activespawnprotection.perks.size ] = perkname;
    _setperk( perkname );
    _setextraperks( perkname );
}

// Namespace perks
// Params 1
// Checksum 0x2e545105, Offset: 0x6ede
// Size: 0x9b
function function_1f68dcaacf9be9f7( activespawnprotection )
{
    foreach ( perkname in activespawnprotection.perks )
    {
        _unsetperk( perkname );
        _unsetextraperks( perkname );
    }
    
    activespawnprotection.perks = undefined;
}

// Namespace perks
// Params 8
// Checksum 0xe33c165e, Offset: 0x6f81
// Size: 0x340
function updateactiveperks( einflictor, attacker, victim, idamage, smeansofdeath, objweapon, shitloc, vdir )
{
    var_b96f96baf7dd109b = isplayer( einflictor );
    var_43788540dda8c517 = weapon::function_e1a6c47f66c6de20( objweapon );
    var_aee30680fae0c4a5 = var_43788540dda8c517 && isdefined( einflictor ) && isdefined( einflictor.classname ) && einflictor.classname == "grenade";
    var_da7932e22db79808 = isplayer( attacker ) && attacker != victim;
    
    if ( var_da7932e22db79808 && ( var_b96f96baf7dd109b || var_aee30680fae0c4a5 ) )
    {
        attacker.lastgunkilltime = gettime();
        
        if ( isdefined( attacker.perks[ "specialty_triggerhappy" ] ) )
        {
            attacker thread perkfunctions::settriggerhappyinternal();
        }
        
        if ( isdefined( attacker.perks[ "specialty_boom" ] ) )
        {
            victim thread perkfunctions::setboominternal( attacker );
        }
        
        if ( isdefined( attacker.perks[ "specialty_deadeye" ] ) )
        {
            attacker.deadeyekillcount++;
        }
        
        if ( isdefined( attacker.perks[ "specialty_stamina_refresh" ] ) )
        {
            attacker thread perkfunctions::refreshstamina();
        }
        
        var_3669c8cc07cb8d11 = attacker.pers[ "abilityRecharging" ];
        
        if ( var_3669c8cc07cb8d11 )
        {
            attacker notify( #"hash_c001b900d858f49a" );
        }
        
        var_e5a5c21458bc209a = attacker.pers[ "abilityOn" ];
        
        if ( var_e5a5c21458bc209a )
        {
            attacker notify( #"hash_d3e64ee74f99103c" );
        }
        
        if ( isdefined( attacker.perks[ "specialty_super_sprint_kill_refresh" ] ) )
        {
            attacker perkfunctions::supersprintkillrefresh_onkill();
        }
        
        if ( isdefined( attacker.perks[ "specialty_reduce_regen_delay_on_kill" ] ) )
        {
            attacker utility::callsharedfunc( #"specialty_reduce_regen_delay_on_kill", #"reduceregendelayonkill" );
        }
        
        if ( isdefined( attacker.perks[ "specialty_regen_on_kill" ] ) )
        {
            attacker utility::callsharedfunc( #"specialty_regen_on_kill", #"hash_cb25570acaf94493" );
        }
        
        if ( isdefined( attacker.perks[ "specialty_armored" ] ) && attacker getammocount( "bandage_br" ) < 1 )
        {
            attacker armor::function_164c824617d7e8d7( 1 );
        }
        
        if ( level.var_101584e8c0a24f05.size > 0 )
        {
            var_d5d94f12cdf2756 = { #objweapon:objweapon, #smeansofdeath:smeansofdeath };
            onkillkeys = getarraykeys( level.var_101584e8c0a24f05 );
            
            foreach ( perkname in onkillkeys )
            {
                if ( isdefined( attacker.perks[ perkname ] ) )
                {
                    attacker thread [[ level.var_101584e8c0a24f05[ perkname ].var_d3a2a267bf4c73d8 ]]( var_d5d94f12cdf2756 );
                }
            }
        }
    }
}

// Namespace perks
// Params 1
// Checksum 0x21a93b02, Offset: 0x72c9
// Size: 0x2d
function function_8165040202c6ebe5( perksarray )
{
    index = class::function_c7dba280a2e3e52e( perksarray );
    self setclientomnvar( "ui_perk_package_bundle_index", index );
}

// Namespace perks
// Params 3
// Checksum 0x9d287eea, Offset: 0x72fe
// Size: 0x2b8
function setomnvarsforperklist( omnvarbase, perklist, extraperkslist )
{
    var_cd6dbf2e5dac532a = [];
    var_58bf58e910a8f049 = [];
    var_b9b6183a1b19943b = 0;
    
    foreach ( perk in perklist )
    {
        if ( !function_ae69f867e887ac4a( perk ) )
        {
            continue;
        }
        
        if ( !function_18992260198358cb( perk ) )
        {
            continue;
        }
        
        slot = getperkslot( perk );
        
        if ( !isdefined( slot ) )
        {
            continue;
        }
        
        if ( !isdefined( var_cd6dbf2e5dac532a[ slot ] ) )
        {
            var_cd6dbf2e5dac532a[ slot ] = [];
        }
        
        var_58bf58e910a8f049[ var_58bf58e910a8f049.size ] = perk;
        var_cd6dbf2e5dac532a[ slot ][ var_cd6dbf2e5dac532a[ slot ].size ] = perk;
        var_b9b6183a1b19943b++;
    }
    
    if ( isdefined( extraperkslist ) )
    {
        foreach ( perk in extraperkslist )
        {
            if ( !function_ae69f867e887ac4a( perk ) )
            {
                continue;
            }
            
            slot = getperkslot( perk );
            
            if ( !isdefined( slot ) )
            {
                continue;
            }
            
            if ( !isdefined( var_cd6dbf2e5dac532a[ slot ] ) )
            {
                var_cd6dbf2e5dac532a[ slot ] = [];
            }
            
            var_cd6dbf2e5dac532a[ slot ][ var_cd6dbf2e5dac532a[ slot ].size ] = perk;
            var_b9b6183a1b19943b++;
        }
    }
    
    loopcount = max( 4, var_b9b6183a1b19943b );
    sortedperks = [];
    
    for ( slot = 1; slot < loopcount ; slot++ )
    {
        if ( isdefined( var_cd6dbf2e5dac532a[ slot ] ) )
        {
            foreach ( perk in var_cd6dbf2e5dac532a[ slot ] )
            {
                sortedperks[ sortedperks.size ] = perk;
            }
        }
    }
    
    var_a47eed025ad81952 = class::function_facf39de1a82731a() == "wildcard_perk_greed";
    
    for ( omnvarindex = 0; omnvarindex < 7 ; omnvarindex++ )
    {
        if ( var_a47eed025ad81952 )
        {
            omnvarvalue = var_58bf58e910a8f049[ omnvarindex ];
        }
        else
        {
            omnvarvalue = sortedperks[ omnvarindex ];
        }
        
        if ( !isdefined( omnvarvalue ) )
        {
            omnvarvalue = "none";
        }
        
        self setclientomnvar( omnvarbase + omnvarindex, omnvarvalue );
    }
    
    self setclientomnvar( "ui_spawn_perks_updated", gettime() );
}

// Namespace perks
// Params 1
// Checksum 0x886102a7, Offset: 0x75be
// Size: 0x99, Type: bool
function isperkinloadout( perk )
{
    perks = self.pers[ "loadoutPerks" ];
    
    foreach ( loadoutperk in perks )
    {
        if ( loadoutperk == perk )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace perks
// Params 1
// Checksum 0x84c9a56f, Offset: 0x7660
// Size: 0x3b
function getperkid( perkref )
{
    if ( !isdefined( perkref ) )
    {
        return 0;
    }
    
    perkid = level.var_d16acbef1602ec53[ perkref ];
    
    if ( !isnumber( perkid ) )
    {
        return 0;
    }
    
    return perkid;
}

// Namespace perks
// Params 1
// Checksum 0x86e576d6, Offset: 0x76a4
// Size: 0x3b
function function_95981724c25c1835( perkref )
{
    if ( !isdefined( perkref ) )
    {
        return 0;
    }
    
    perkid = level.var_fadc1b38f6006441[ perkref ];
    
    if ( !isnumber( perkid ) )
    {
        return 0;
    }
    
    return perkid;
}

// Namespace perks
// Params 1
// Checksum 0x4aad3256, Offset: 0x76e8
// Size: 0x3b
function function_6a1d4ff37648a594( perkref )
{
    if ( !isdefined( perkref ) )
    {
        return 0;
    }
    
    perkid = level.var_d97c85f03eff6eca[ perkref ];
    
    if ( !isnumber( perkid ) )
    {
        return 0;
    }
    
    return perkid;
}

// Namespace perks
// Params 1
// Checksum 0xcb2c7d09, Offset: 0x772c
// Size: 0x2c
function function_80dd74eda1e2dfc6( perkname )
{
    if ( !isdefined( self.perks[ perkname ] ) )
    {
        return 0;
    }
    
    return self.perks[ perkname ].size;
}

// Namespace perks
// Params 2
// Checksum 0xfe238769, Offset: 0x7761
// Size: 0x38
function function_7f2569ef0f6dd6ff( perkname, var_4b2b3dc56d37a58 )
{
    if ( !isdefined( self.perks[ perkname ][ var_4b2b3dc56d37a58 ] ) )
    {
        return 0;
    }
    
    return self.perks[ perkname ][ var_4b2b3dc56d37a58 ];
}

// Namespace perks
// Params 1
// Checksum 0x129779a3, Offset: 0x77a2
// Size: 0x5b
function function_70e4256c5fb41ada( specialtyref )
{
    if ( !isdefined( self.var_773b81cf576594e5 ) )
    {
        self.var_773b81cf576594e5 = [];
    }
    
    if ( self.var_9842326056fd7207.var_ee1c92198ad66b2f.size > 0 )
    {
        self.var_773b81cf576594e5[ specialtyref ] = self.var_9842326056fd7207.ref;
    }
}

// Namespace perks
// Params 2
// Checksum 0x98c9bf9f, Offset: 0x7805
// Size: 0x8c
function activateperk( perkref, var_f79322810142292e = 0 )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    notifyomnvar = var_f79322810142292e ? "ui_perk_activation_on_enemy_notify" : "ui_perk_activation_notify";
    var_2868a895a76a5dac = var_f79322810142292e ? "ui_perk_activation_on_enemy" : "ui_perk_activation";
    
    if ( !hasomnvar( var_2868a895a76a5dac ) || !hasomnvar( notifyomnvar ) )
    {
        return;
    }
    
    self setclientomnvar( var_2868a895a76a5dac, perkref );
    self setclientomnvar( notifyomnvar, gettime() );
}

// Namespace perks
// Params 0
// Checksum 0x4a34d00d, Offset: 0x7899
// Size: 0x81
function clearperkpackage()
{
    foreach ( perk in self.pers[ "loadoutPerks" ] )
    {
        perk::removeperk( perk );
    }
}

// Namespace perks
// Params 2, eflags: 0x4
// Checksum 0xe5aad63a, Offset: 0x7922
// Size: 0xe7
function private function_87fbffde5bdf759( var_33cfdff03a573935, var_491ec6b18f085a1 )
{
    if ( !isdefined( var_33cfdff03a573935.var_bf637226066bc737 ) )
    {
        var_33cfdff03a573935.var_bf637226066bc737 = [];
    }
    
    if ( !isdefined( var_33cfdff03a573935.var_bf637226066bc737[ var_491ec6b18f085a1 ] ) )
    {
        foreach ( buffindex, buff in var_33cfdff03a573935.var_ee1c92198ad66b2f )
        {
            if ( buff.var_fbd59bd982c1fe7c == var_491ec6b18f085a1 )
            {
                var_33cfdff03a573935.var_bf637226066bc737[ var_491ec6b18f085a1 ] = buffindex;
                break;
            }
        }
    }
    
    return var_33cfdff03a573935.var_bf637226066bc737[ var_491ec6b18f085a1 ];
}

// Namespace perks
// Params 2
// Checksum 0x80b7d0a3, Offset: 0x7a12
// Size: 0x58
function notifyperkbuffactive( var_33cfdff03a573935, var_491ec6b18f085a1 )
{
    buffindex = function_87fbffde5bdf759( var_33cfdff03a573935, var_491ec6b18f085a1 );
    
    if ( isdefined( buffindex ) )
    {
        value = self getclientomnvar( "ui_perk_bonus_buff_" + buffindex );
        self setclientomnvar( "ui_perk_bonus_buff_" + buffindex, !value );
    }
}

// Namespace perks
// Params 3
// Checksum 0x80de62ce, Offset: 0x7a72
// Size: 0x49
function setperkbuffactive( var_33cfdff03a573935, var_491ec6b18f085a1, isactive )
{
    buffindex = function_87fbffde5bdf759( var_33cfdff03a573935, var_491ec6b18f085a1 );
    
    if ( isdefined( buffindex ) )
    {
        self setclientomnvar( "ui_perk_bonus_buff_" + buffindex, isactive );
    }
}

// Namespace perks
// Params 1
// Checksum 0x77a8c82, Offset: 0x7ac3
// Size: 0x70
function function_4b67efa5b1316d06( perkref )
{
    var_222e15f0ab6a381c = arraycombine( self.pers[ "loadoutPerks" ], self.perkstreaks );
    
    for ( slot = 0; slot < var_222e15f0ab6a381c.size ; slot++ )
    {
        loadoutperk = var_222e15f0ab6a381c[ slot ];
        
        if ( loadoutperk == perkref )
        {
            return ( slot + 1 );
        }
    }
    
    return getperkslot( perkref );
}

// Namespace perks
// Params 2
// Checksum 0x5489d80c, Offset: 0x7b3c
// Size: 0x3f
function function_ef056eae4d523635( perkref, isactive )
{
    perkindex = function_4b67efa5b1316d06( perkref );
    
    if ( isdefined( perkindex ) )
    {
        self setclientomnvar( "ui_perk_bonus_buff_slot_" + perkindex, isactive );
    }
}

// Namespace perks
// Params 1
// Checksum 0x6a17deff, Offset: 0x7b83
// Size: 0x42
function function_142df1226093bce0( perkref )
{
    perkindex = function_4b67efa5b1316d06( perkref );
    
    if ( isdefined( perkindex ) )
    {
        self setclientomnvar( "ui_perk_slot_buff", perkindex );
        self setclientomnvar( "ui_perk_slot_buff_notify", gettime() );
    }
}

// Namespace perks
// Params 1
// Checksum 0x1e9d32b0, Offset: 0x7bcd
// Size: 0x35
function function_387a7a1ee90cd5bd( perkref )
{
    perkindex = function_4b67efa5b1316d06( perkref );
    
    if ( isdefined( perkindex ) )
    {
        return self getclientomnvar( "ui_perk_bonus_buff_slot_" + perkindex );
    }
    
    return 0;
}

// Namespace perks
// Params 0
// Checksum 0x6e214c6a, Offset: 0x7c0b
// Size: 0xc, Type: bool
function function_6b274562a4cedd09()
{
    return istrue( self.cricket );
}

