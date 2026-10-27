// scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_fx.gsc  (hash_6b49335f7b9a1336.gscc) (size: 3697 Bytes / 0xe71 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9b8345fe (2609071614)
// size ...... 3697 (0xe71)
// includes .. 0   (offset: 0xc11)
// strings ... 42  (offset: 0xc11)
// dev strs .. 0   (offset: 0xe71)
// exports ... 2   (offset: 0xb21)
// cseg ...... 0x7af + 0x372 (0xb21)
// imports ... 1   (offset: 0xb71)
// animtree1 . 0   (offset: 0xe71)
// animtree2 . 0   (offset: 0xe71)
#namespace mp_sat_ob_libra_fx;

// Namespace mp_sat_ob_libra_fx
// Params 0
// Checksum 0xe042d963, Offset: 0x7cd
// Size: 0x354
function main()
{
    level._effect[ "vfx_sat_levels_mp_ob_libra_processing_door_explo" ] = loadfxasset( "vfx_sat_levels_mp_ob_libra_processing_door_explo" );
    level._effect[ "vfx_sat_levels_mp_ob_libra_door_gush_01" ] = loadfxasset( "vfx_sat_levels_mp_ob_libra_door_gush_01" );
    level._effect[ "vfx_sat_levels_mp_ob_libra_porthole_gush_01" ] = loadfxasset( "vfx_sat_levels_mp_ob_libra_porthole_gush_01" );
    level._effect[ "vfx_sat_levels_mp_ob_libra_underwater_halluc_cam_debris_dirty" ] = loadfxasset( "vfx_sat_levels_mp_ob_libra_underwater_halluc_cam_debris_dirty" );
    level._effect[ "vfx_sat_wc_igc_muz_ar_enemy" ] = loadfxasset( "vfx_sat_wc_igc_muz_ar_enemy" );
    level._effect[ "vfx_sat_core_impacts_impact_concrete_med" ] = loadfxasset( "vfx_sat_core_impacts_impact_concrete_med" );
    level._effect[ "vfx_sat_core_impacts_impact_metal_nonpen_med" ] = loadfxasset( "vfx_sat_core_impacts_impact_metal_nonpen_med" );
    level._effect[ "vfx_sat_wc_igc_muz_sm_zebra" ] = loadfxasset( "vfx_sat_wc_igc_muz_sm_zebra" );
    level._effect[ "vfx_sat_wc_igc_muz_ar_condor" ] = loadfxasset( "vfx_sat_wc_igc_muz_ar_condor" );
    level._effect[ "vfx_sat_wc_igc_muz_ar_falcon" ] = loadfxasset( "vfx_sat_wc_igc_muz_ar_falcon" );
    level._effect[ "vfx_sat_wc_igc_muz_dm_scotia" ] = loadfxasset( "vfx_sat_wc_igc_muz_dm_scotia" );
    level._effect[ "vfx_sat_levels_mp_ob_libra_igc_misc_muz_enemy_ar" ] = loadfxasset( "vfx_sat_levels_mp_ob_libra_igc_misc_muz_enemy_ar" );
    level._effect[ "vfx_sat_levels_mp_ob_libra_igc_misc_muz_samuels" ] = loadfxasset( "vfx_sat_levels_mp_ob_libra_igc_misc_muz_samuels" );
    level._effect[ "vfx_sat_levels_mp_ob_libra_igc_misc_muz_harper" ] = loadfxasset( "vfx_sat_levels_mp_ob_libra_igc_misc_muz_harper" );
    level._effect[ "vfx_sat_levels_mp_ob_libra_igc_misc_muz_mason" ] = loadfxasset( "vfx_sat_levels_mp_ob_libra_igc_misc_muz_mason" );
    level._effect[ "vfx_sat_levels_mp_ob_libra_igc_misc_muz_5050" ] = loadfxasset( "vfx_sat_levels_mp_ob_libra_igc_misc_muz_5050" );
    level._effect[ "vfx_sat_levels_mp_ob_libra_processing_sphere_water_shed_main" ] = loadfxasset( "vfx_sat_levels_mp_ob_libra_processing_sphere_water_shed_main" );
    level._effect[ "vfx_sat_levels_mp_ob_libra_vistaroom_breath_bubbles" ] = loadfxasset( "vfx_sat_levels_mp_ob_libra_vistaroom_breath_bubbles" );
    level._effect[ "vfx_sat_levels_mp_ob_libra_vistaroom_cradle_sphere_valve_leak_underwater_1" ] = loadfxasset( "vfx_sat_levels_mp_ob_libra_vistaroom_cradle_sphere_valve_leak_underwater_1" );
    level._effect[ "vfx_sat_levels_mp_ob_libra_cradle_sphere_valve_leak_upper_2" ] = loadfxasset( "vfx_sat_levels_mp_ob_libra_cradle_sphere_valve_leak_upper_2" );
    level._effect[ "boss_panel_destruction" ] = loadfxasset( "vfx_t10_core_impacts_impact_equip_explo_frag_metal" );
    level._effect[ "vfx_sat_levels_mp_ob_libra_cradle_sphere_valve_release_1" ] = loadfxasset( "vfx_sat_levels_mp_ob_libra_cradle_sphere_valve_release_1" );
    level._effect[ "vfx_sat_storage_lift_bot_platform" ] = loadfxasset( "vfx_sat_storage_lift_bot_platform" );
    level._effect[ "vfx_sat_storage_canister_cradle_01_b" ] = loadfxasset( "vfx_sat_storage_canister_cradle_01_b" );
    level._effect[ "vfx_sat_machinery_cradle_loader_01_glass" ] = loadfxasset( "vfx_sat_machinery_cradle_loader_01_glass" );
    level._effect[ "cradle_sphere_water_drips" ] = loadfxasset( "vfx_sat_levels_mp_ob_libra_processing_sphere_water_shed_main" );
    level._effect[ "vfx_sat_levels_mp_ob_libra_vistaroom_bubbles_surfacebursts_ch_3" ] = loadfxasset( "vfx_sat_levels_mp_ob_libra_vistaroom_bubbles_surfacebursts_ch_3" );
    level._effect[ "cradle_sphere_ring_light" ] = loadfxasset( "vfx_sat_levels_mp_ob_libra_processing_lf_grime_sphere_ringlights" );
    level._effect[ "cradle_sphere_center_light" ] = loadfxasset( "vfx_sat_levels_mp_ob_libra_processing_lf_sphere_centerlight" );
    level._effect[ "escape_ring_window_light" ] = loadfxasset( "vfx_sat_levels_mp_ob_libra_escape_window_light" );
    level._effect[ "blinking_white_light" ] = loadfxasset( "vfx_core_vehicle_aircraft_light_white_blink_lit" );
    level._effect[ "boss_cradle_bomb_cloud" ] = loadfxasset( "vfx_mp_wc_leo_facility_cradle_volume_lrg" );
    level._effect[ "boss_cradle_bomb_explode" ] = loadfxasset( "vfx_sat_wc_ai_cradle_spawn_ground_impact_01" );
    level._effect[ "proc_door_explode" ] = loadfxasset( "vfx_t10_core_script_hed_rdt_toxic_barrel_01" );
}

