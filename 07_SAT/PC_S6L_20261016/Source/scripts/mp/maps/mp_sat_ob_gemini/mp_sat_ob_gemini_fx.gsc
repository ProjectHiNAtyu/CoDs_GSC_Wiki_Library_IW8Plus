// scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_fx.gsc  (hash_5419ae1c27c8b4ec.gscc) (size: 2725 Bytes / 0xaa5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa74aa9e7 (2806688231)
// size ...... 2725 (0xaa5)
// includes .. 0   (offset: 0x8bd)
// strings ... 40  (offset: 0x8bd)
// dev strs .. 0   (offset: 0xaa5)
// exports ... 5   (offset: 0x76d)
// cseg ...... 0x527 + 0x246 (0x76d)
// imports ... 2   (offset: 0x835)
// animtree1 . 0   (offset: 0xaa5)
// animtree2 . 0   (offset: 0xaa5)
#namespace gemini_fx;

// Namespace gemini_fx
// Params 0
// Checksum 0xaaaa1ee4, Offset: 0x545
// Size: 0x12e
function function_dde9e9b738e845df()
{
    level._effect[ "frost_floor" ] = loadfxasset( "vfx_sat_gemini_frost_decal_1" );
    level._effect[ "frost_wall" ] = loadfxasset( "vfx_sat_gemini_frost_decal_2" );
    level._effect[ "frost_ceiling" ] = loadfxasset( "vfx_sat_gemini_frost_decal_3" );
    level._effect[ "cradle_vapor_1" ] = loadfxasset( "vfx_sat_mp_ob_gem_frost_cradle_vapor_1" );
    level._effect[ "memory_cradle_dissipate_1" ] = loadfxasset( "vfx_sat_mp_ob_gem_memory_cradle_dissipate_1" );
    level._effect[ "memory_cradle_joint_1" ] = loadfxasset( "vfx_sat_mp_ob_gem_cradle_memory_joint_1" );
    level._effect[ "memory_cradle_joint_2" ] = loadfxasset( "vfx_sat_mp_ob_gem_cradle_memory_joint_2" );
    level._effect[ "memory_cradle_joint_3" ] = loadfxasset( "vfx_sat_mp_ob_gem_cradle_memory_joint_3" );
    level._effect[ "memory_eye_glow" ] = loadfxasset( "vfx_t10_levels_sp_redacted_disciple_gameplay_eyes" );
    level._effect[ "memory_projection" ] = loadfxasset( "vfx_sat_mp_ob_gem_tv_memory_projection_1" );
    level._effect[ "memory_pulse" ] = loadfxasset( "vfx_sat_mp_ob_gem_cradle_memory_pulse_1" );
    level._effect[ "memory_tv_trail" ] = loadfxasset( "vfx_sat_mp_ob_gem_memory_tv_trail_1" );
}

// Namespace gemini_fx
// Params 0
// Checksum 0x3de67c0d, Offset: 0x67b
// Size: 0x93
function function_a3f16c73525b6655()
{
    precachemodel( "loot_ammo_rocket" );
    precachemodel( "vfx_energy_beam_core" );
    level._effect[ "vfx_spawn_crawlout" ] = loadfxasset( "vfx_jup_ob_gameplay_zm_ai_zai_spawn_ground" );
    level._effect[ "vfx_cradle_vol_sm" ] = loadfxasset( "vfx_mp_wc_leo_facility_cradle_volume_sml" );
    level._effect[ "vfx_cradle_vol_md" ] = loadfxasset( "vfx_mp_wc_leo_facility_cradle_volume_med" );
    level._effect[ "vfx_cradle_vol_lg" ] = loadfxasset( "vfx_mp_wc_leo_facility_cradle_volume_lrg" );
    level._effect[ "vfx_cradle_burst" ] = loadfxasset( "vfx_sat_mp_ob_gem_frost_cradle_burst_1" );
}

// Namespace gemini_fx
// Params 0
// Checksum 0x1d05cef0, Offset: 0x716
// Size: 0x1b
function function_ff29aa5831c0eb02()
{
    level._effect[ "conceal_mist_1" ] = loadfxasset( "vfx_sat_mp_ob_gem_conceal_mist_1" );
}

// Namespace gemini_fx
// Params 0
// Checksum 0x395566bf, Offset: 0x739
// Size: 0x34
function function_3d68a0450cab12f3()
{
    level._effect[ "vfx_sat_core_weapons_muz_ar" ] = loadfxasset( "vfx_sat_core_weapons_muz_ar" );
    level._effect[ "vfx_sat_wc_ai_cradle_soldier_death_01" ] = loadfxasset( "vfx_sat_wc_ai_cradle_soldier_death_01" );
}

