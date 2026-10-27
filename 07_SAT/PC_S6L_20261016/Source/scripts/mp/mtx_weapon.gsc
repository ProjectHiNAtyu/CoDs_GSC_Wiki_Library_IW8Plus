// scripts\mp\mtx_weapon.gsc  (hash_3fe8ff087627520e.gscc) (size: 102607 Bytes / 0x190cf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x17d3f662 (399767138)
// size ...... 102607 (0x190cf)
// includes .. 6   (offset: 0x172ff)
// strings ... 517 (offset: 0x1732f)
// dev strs .. 21  (offset: 0x18fb3)
// exports ... 369 (offset: 0xfc17)
// cseg ...... 0x39bf + 0xc258 (0xfc17)
// imports ... 427 (offset: 0x135bf)
// animtree1 . 0   (offset: 0x190cf)
// animtree2 . 0   (offset: 0x190cf)
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\crossbow;
#using scripts\mp\operator;

#namespace mtx_weapon;

// Namespace mtx_weapon
// Params 0
// Checksum 0x14d074a9, Offset: 0x39dd
// Size: 0x1ea1
function function_f877fea1e7d31f31()
{
    level.var_40db9032567cfca7 = [];
    level.var_2a53ffec3874a987 = [];
    level.var_6cc157c91ced44eb = [];
    level.var_839fe802490703e4 = [];
    level.var_d8010ce982c6daa5 = [];
    level.var_6cd087ff5695816b = [];
    level.var_8b428a7abd4b5588 = [];
    level.var_f1aeabe082d92591 = [];
    level.var_cc75e39215a1ee5a = [];
    level.var_7c58ad8fa1e541fa = [];
    level.var_c4d8205fc5f06ab5 = [];
    projectname = getprojectname();
    
    if ( isbrgamemode() )
    {
        level._effect[ "youveBeenNaughty_limb" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_naughty_limb" );
        level._effect[ "youveBeenNaughty_torso" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_naughty_torso" );
        level._effect[ "youveBeenNaughty_head" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_naughty_head" );
        level._effect[ "youveBeenNice_limb" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_nice_limb" );
        level._effect[ "youveBeenNice_torso" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_nice_torso" );
        level._effect[ "youveBeenNice_head" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_nice_head" );
        level._effect[ "vDay_limb" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_vday_limb" );
        level._effect[ "vDay_torso" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_vday_torso" );
        level._effect[ "vDay_head" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_vday_head" );
        level._effect[ "bCell_limb" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_bcell_limb" );
        level._effect[ "bCell_torso" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_bcell_torso" );
        level._effect[ "bCell_head" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_bcell_head" );
        level._effect[ "bCell_nogore_limb" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_bcell_nogore_limb" );
        level._effect[ "bCell_nogore_torso" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_bcell_nogore_torso" );
        level._effect[ "bCell_nogore_head" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_bcell_nogore_head" );
        level._effect[ "paddy_limb" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_paddy_limb" );
        level._effect[ "paddy_torso" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_paddy_torso" );
        level._effect[ "paddy_head" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_paddy_head" );
        level._effect[ "easter_limb" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_easter_limb" );
        level._effect[ "easter_torso" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_easter_torso" );
        level._effect[ "easter_head" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_easter_head" );
        level._effect[ "easter_nogore_limb" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_easter_nogore_limb" );
        level._effect[ "easter_nogore_torso" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_easter_nogore_torso" );
        level._effect[ "easter_nogore_head" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_easter_nogore_head" );
        level._effect[ "scifi_limb" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_scifi_limb" );
        level._effect[ "scifi_torso" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_scifi_torso" );
        level._effect[ "scifi_head" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_scifi_head" );
        level._effect[ "scifi_origin" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_scifi_death_mesh" );
        level._effect[ "scifi2_limb" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_scifi2_limb" );
        level._effect[ "scifi2_torso" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_scifi2_torso" );
        level._effect[ "scifi2_head" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_scifi2_head" );
        level._effect[ "scifi2_origin" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_scifi2_death_mesh" );
        level._effect[ "scifi3_limb" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_scifi3_limb" );
        level._effect[ "scifi3_torso" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_scifi3_torso" );
        level._effect[ "scifi3_head" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_scifi3_head" );
        level._effect[ "scifi3_origin" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_scifi3_death_mesh" );
        level._effect[ "420_death" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_fatal_weed_sh" );
        level._effect[ "hitscan" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_hitscan_fatal" );
        level._effect[ "thor" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_thor_fatal" );
        level._effect[ "thor_chest" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_thor_fatal_chest" );
        level._effect[ "golden_gun_limb" ] = loadfxasset( "vfx_jup_weapon_mtx_s1_impact_terminus_goldengun_limb" );
        level._effect[ "golden_gun_torso" ] = loadfxasset( "vfx_jup_weapon_mtx_s1_impact_terminus_goldengun_torso" );
        level._effect[ "golden_gun_head" ] = loadfxasset( "vfx_jup_weapon_mtx_s1_impact_terminus_goldengun_head" );
        level._effect[ "golden_gun_origin" ] = loadfxasset( "vfx_jup_weapon_mtx_s1_impact_terminus_goldengun_death_mesh" );
        level._effect[ "soulEater_limb" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_souleater_limb" );
        level._effect[ "soulEater_torso" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_souleater_torso" );
        level._effect[ "soulEater_head" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_souleater_head" );
        level._effect[ "soulEater_death" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_soul_fatal" );
        level._effect[ "crash_limb" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_crash_limb" );
        level._effect[ "crash_torso" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_crash_torso" );
        level._effect[ "crash_head" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_crash_head" );
        level._effect[ "cthulhu_limb" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_cthulhu_limb" );
        level._effect[ "cthulhu_torso" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_cthulhu_torso" );
        level._effect[ "cthulhu_head" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_cthulhu_head" );
        level._effect[ "cthulhu_nogore_limb" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_cthulhu_nogore_limb" );
        level._effect[ "cthulhu_nogore_torso" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_cthulhu_nogore_torso" );
        level._effect[ "cthulhu_nogore_head" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_cthulhu_nogore_head" );
        level._effect[ "akihabara_fatal" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_akihabara_fatal" );
        level._effect[ "hlander_limb" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_hlander_limb" );
        level._effect[ "hlander_torso" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_hlander_torso" );
        level._effect[ "hlander_head" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_hlander_head" );
        level._effect[ "hlander_nogore_limb" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_hlander_nogore_limb" );
        level._effect[ "hlander_nogore_torso" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_hlander_nogore_torso" );
        level._effect[ "hlander_nogore_head" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_hlander_nogore_head" );
        level._effect[ "nicki_limb" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_nicki_limb" );
        level._effect[ "nicki_torso" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_nicki_torso" );
        level._effect[ "nicki_head" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_nicki_head" );
        level._effect[ "ice_limb" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_ice_limb" );
        level._effect[ "ice_torso" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_ice_torso" );
        level._effect[ "ice_head" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_ice_head" );
        level._effect[ "ice_nogore_limb" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_ice_limb_nogore" );
        level._effect[ "ice_nogore_torso" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_ice_torso_nogore" );
        level._effect[ "tomb_limb" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_lara_fatal_limb" );
        level._effect[ "tomb_torso" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_lara_fatal_torso" );
        level._effect[ "tomb_head" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_lara_fatal_head" );
        level._effect[ "tomb_limb_nogore" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_lara_fatal_limb_nogore" );
        level._effect[ "tomb_torso_nogore" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_lara_fatal_torso_nogore" );
        level._effect[ "tomb_head_nogore" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_lara_fatal_head_nogore" );
        level._effect[ "tomb_limb" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_lara_fatal_limb" );
        level._effect[ "tomb_torso" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_lara_fatal_torso" );
        level._effect[ "tomb_head" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_lara_fatal_head" );
        level._effect[ "hips_limb" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_hips_limb" );
        level._effect[ "hips_torso" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_hips_torso" );
        level._effect[ "hips_head" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_hips_head" );
        level._effect[ "hops_limb" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_hops_limb" );
        level._effect[ "hops_torso" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_hops_torso" );
        level._effect[ "hops_head" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_hops_head" );
        level._effect[ "maze_limb" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_maze_limb" );
        level._effect[ "maze_torso" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_maze_torso" );
        level._effect[ "maze_head" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_maze_head" );
        level._effect[ "maze_nogore_limb" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_maze_nogore_limb" );
        level._effect[ "maze_nogore_torso" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_maze_nogore_torso" );
        level._effect[ "maze_nogore_head" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_maze_nogore_head" );
        level._effect[ "bcell6_limb" ] = loadfxasset( "vfx_iw9_core_operators_reactive_bcell6_mtx_fatal_explode_limb" );
        level._effect[ "bcell6_torso" ] = loadfxasset( "vfx_iw9_core_operators_reactive_bcell6_mtx_fatal_explode_torso" );
        level._effect[ "bcell6_head" ] = loadfxasset( "vfx_iw9_core_operators_reactive_bcell6_mtx_fatal_explode_head" );
        level._effect[ "lilith" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_lilith_fatal" );
        level._effect[ "inarius" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_impact_inarius_fatal" );
        level._effect[ "witch" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_witch_s6_impact_fatal" );
        level._effect[ "zombie" ] = loadfxasset( "vfx_iw9_core_weapons_impacts_mtx_zombie_s6_impact_fatal" );
        level._effect[ "boys_super_str" ] = loadfxasset( "vfx_jup_weapon_mtx_s1_death_all_purpose_dismemberment_super_str_01" );
        level._effect[ "40k" ] = loadfxasset( "vfx_jup_weapon_mtx_s2_impact_40k_flesh_fatal" );
        level._effect[ "blackcell" ] = loadfxasset( "vfx_jup_weapon_mtx_s3_impact_blackcell_flesh_fatal" );
        level._effect[ "underworld" ] = loadfxasset( "vfx_jup_weapon_mtx_s6_impact_underworld_flesh_fatal" );
        level._effect[ "wonton" ] = loadfxasset( "vfx_jup_s4_weapon_mtx_impact_dough_wonton_melee_flesh_fatal" );
        level._effect[ "mandu" ] = loadfxasset( "vfx_jup_s4_weapon_mtx_impact_dough_mandu_melee_flesh_fatal" );
        level._effect[ "tonfa" ] = loadfxasset( "vfx_jup_weapon_mtx_s2_impact_tonfa_flesh_fatal" );
        level._effect[ "blackcell_s5" ] = loadfxasset( "vfx_jup_weapon_mtx_s5_impact_blackcell_melee_flesh_fatal" );
        level._effect[ "gilman" ] = loadfxasset( "vfx_jup_weapon_mtx_s5_impact_entagled_flesh_fatal" );
        level._effect[ "shapechanger" ] = loadfxasset( "vfx_jup_weapon_mtx_s5_impact_shapechanger_melee_flesh_fatal" );
        level._effect[ "bikeMelee" ] = loadfxasset( "vfx_jup_weapon_mtx_s2_impact_michonne_flesh_fatal" );
        level._effect[ "vinyl" ] = loadfxasset( "vfx_jup_weapon_mtx_s5_impact_vinyl_flesh_fatal_melee" );
        level._effect[ "pineapple" ] = loadfxasset( "vfx_jup_equip_mtx_s3_thermo_pineapple_flesh_fatal" );
        level._effect[ "vinyl" ] = loadfxasset( "vfx_jup_weapon_mtx_s5_impact_vinyl_flesh_fatal" );
        level._effect[ "vinyl_heavy" ] = loadfxasset( "vfx_jup_weapon_mtx_s5_impact_vinyl_flesh_fatal_melee" );
        level._effect[ "voxel" ] = loadfxasset( "vfx_jup_weapon_mtx_s1_impact_arcade_flesh_fatal" );
        level._effect[ "oreZincMelee" ] = loadfxasset( "vfx_jup_weapon_mtx_s6_impact_orezinc_melee_flesh_fatal" );
        level._effect[ "mahou_limb" ] = loadfxasset( "vfx_jup_weapon_mtx_s6_death_echoendo_mahou_explo_limb" );
        level._effect[ "mahou_torso" ] = loadfxasset( "vfx_jup_weapon_mtx_s6_death_echoendo_mahou_explo_torso" );
        level._effect[ "mahou_head" ] = loadfxasset( "vfx_jup_weapon_mtx_s6_death_echoendo_mahou_explo_head" );
        level._effect[ "mahou_origin" ] = loadfxasset( "vfx_jup_weapon_mtx_s6_death_echoendo_mahou_explo_mesh" );
    }
    
    if ( projectname == "T10" || projectname == "SAT" || projectname == "WZ2" || projectname == "SAW" )
    {
        if ( level.var_6a98fcae23c2e606 )
        {
            level._effect[ "raygunRepair" ] = loadfxasset( "vfx_t10_core_mtx_dth_repair_flesh_fatal" );
        }
        
        level._effect[ "vault" ] = loadfxasset( "vfx_t10_core_weapons_mtx_death_dth_me_vault" );
        level._effect[ "vault_safe" ] = loadfxasset( "vfx_t10_core_weapons_mtx_death_dth_me_vault_safe" );
        level._effect[ "steampunk" ] = loadfxasset( "vfx_t10_dth_mtx_steampunk_fatal" );
        level._effect[ "steampunk_head" ] = loadfxasset( "vfx_t10_dth_mtx_steampunk_head" );
        level._effect[ "steampunk_torso" ] = loadfxasset( "vfx_t10_dth_mtx_steampunk_torso" );
        level._effect[ "steampunk_arm_left" ] = loadfxasset( "vfx_t10_dth_mtx_steampunk_arm_left" );
        level._effect[ "steampunk_arm_right" ] = loadfxasset( "vfx_t10_dth_mtx_steampunk_arm_right" );
        level._effect[ "steampunk_leg_left" ] = loadfxasset( "vfx_t10_dth_mtx_steampunk_leg_left" );
        level._effect[ "steampunk_leg_right" ] = loadfxasset( "vfx_t10_dth_mtx_steampunk_leg_right" );
        level._effect[ "gvibes" ] = loadfxasset( "vfx_t10_dth_mtx_good_vibes" );
        level._effect[ "deadops" ] = loadfxasset( "vfx_t10_dth_mtx_deadops_flesh_fatal" );
        level._effect[ "cartoon" ] = loadfxasset( "vfx_t10_core_weapons_mtx_death_cartoon_dth_fatal" );
        level._effect[ "tmnt_slime" ] = loadfxasset( "vfx_t10_dth_mtx_tmnt_slime_fatal" );
        level._effect[ "tmnt_don" ] = loadfxasset( "vfx_t10_dth_mtx_tmnt_donatello" );
        level._effect[ "tmnt_mike" ] = loadfxasset( "vfx_t10_dth_mtx_tmnt_michelangelo" );
        level._effect[ "tmnt_raph" ] = loadfxasset( "vfx_t10_dth_mtx_tmnt_melee_raphael" );
        level._effect[ "tmnt_leo" ] = loadfxasset( "vfx_t10_dth_mtx_tmnt_melee_leo" );
        level._effect[ "bigjoke" ] = loadfxasset( "vfx_t10_dth_mtx_bigjoke_melee" );
        level._effect[ "bbots" ] = loadfxasset( "vfx_t10_dth_mtx_bbots_flesh_fatal" );
        level._effect[ "comic_strip" ] = loadfxasset( "vfx_t10_dth_mtx_comic_strip_flesh_fatal" );
        level._effect[ "bacon" ] = loadfxasset( "vfx_t10_core_weapons_mtx_death_bacon_fatal" );
        level._effect[ "tomato" ] = loadfxasset( "vfx_t10_dth_mtx_tomato_fatal" );
        level._effect[ "ssword" ] = loadfxasset( "vfx_t10_dth_mtx_ssword_fatal" );
        level._effect[ "dino" ] = loadfxasset( "vfx_t10_dth_mtx_dino_flesh_fatal" );
        level._effect[ "corgi" ] = loadfxasset( "vfx_t10_dth_mtx_corgi_nachos" );
        level._effect[ "aqueen" ] = loadfxasset( "vfx_t10_dth_mtx_alien" );
        level._effect[ "hobbyhorse" ] = loadfxasset( "vfx_t10_mtx_hobbyhorse_impact_med_flesh_fatal" );
        level._effect[ "poodle" ] = loadfxasset( "vfx_t10_dth_mtx_poodle_fatal" );
        level._effect[ "ikwydls" ] = loadfxasset( "vfx_t10_dth_mtx_ikwydls" );
        level._effect[ "ahstormare" ] = loadfxasset( "vfx_t10_dth_mtx_ahstormare_flesh_fatal" );
        level._effect[ "tsoldier" ] = loadfxasset( "vfx_t10_dth_mtx_tsoldier_flesh_fatal" );
        level._effect[ "wninja" ] = loadfxasset( "vfx_t10_dth_mtx_wninja_flesh_fatal" );
        level._effect[ "bluntev" ] = loadfxasset( "vfx_t10_core_weapons_mtx_death_stoner_dth_fatal" );
        level._effect[ "caramel" ] = loadfxasset( "vfx_t10_dth_mtx_caramel_flesh_fatal" );
        level._effect[ "mskate" ] = loadfxasset( "vfx_t10_dth_mtx_mskate_fatal" );
        level._effect[ "bostaff_larpers" ] = loadfxasset( "vfx_t10_mtx_mpug40_death_ch" );
        level._effect[ "cer_LimbDismemberment" ] = loadfxasset( "vfx_t10_char_generic_dismemberment" );
        level._effect[ "cer_Annihilation" ] = loadfxasset( "vfx_t10_char_generic_annihilation" );
        level._effect[ "hallucin" ] = loadfxasset( "vfx_sat_dth_mtx_hallucin_flesh_fatal" );
    }
    
    function_ee3da014a4117632( #"naughtydeath", &function_3907722283e6b0f8 );
    function_ee3da014a4117632( #"nicedeath", &function_4dcedcc964c16d5f );
    function_ee3da014a4117632( #"vday", &function_b4612ce187e9d454 );
    function_ee3da014a4117632( #"pshock", &function_d5227e415aefad26 );
    function_ee3da014a4117632( #"bcell", &function_9226837f2c138ede );
    function_ee3da014a4117632( #"paddy", &function_e2b3079d82da0de6 );
    function_ee3da014a4117632( #"shredder", &function_4acec9eae72b50af );
    function_ee3da014a4117632( #"sbandit", &function_dd39f676c0c099e1 );
    function_ee3da014a4117632( #"spider", &function_2f17d26b59e4021f );
    function_ee3da014a4117632( #"arcstorm", &function_688a6360ee004683 );
    function_ee3da014a4117632( #"yokai", &function_fca1dd0006b8d105 );
    function_ee3da014a4117632( #"outbreak", &function_e0435f3257140865 );
    function_ee3da014a4117632( #"chickentendies", &function_875d9576c3d285d7 );
    function_ee3da014a4117632( #"d20", &function_bea62625173f2f22 );
    function_ee3da014a4117632( #"techwear", &function_31ad67ef393627b1 );
    function_ee3da014a4117632( #"hades_hands", &function_2a424a972b512d77 );
    function_ee3da014a4117632( #"prismatic_force", &function_47d45fb04a6a6151 );
    function_ee3da014a4117632( #"gunhead", &function_430241fe33189a30 );
    function_ee3da014a4117632( #"brassgolem", &function_78c680d497103381 );
    function_ee3da014a4117632( #"slatedprism", &function_6856bb2d373441ec );
    function_ee3da014a4117632( #"cyberviking", &function_2b8125f68ce7d135 );
    function_ee3da014a4117632( #"banshee", &function_b32af13599aae6b8 );
    function_ee3da014a4117632( #"cronen_squall", &function_517b342d8a83238e );
    function_ee3da014a4117632( #"toxic_terror", &function_b7f085a894181de2 );
    function_ee3da014a4117632( #"spectralghost", &function_ed3e40ce6e799b8c );
    function_ee3da014a4117632( #"dark_avengers", &function_8211ec22561d54ca );
    function_ee3da014a4117632( #"crytempest", &function_7d85d806fae44cb6 );
    function_ee3da014a4117632( #"rhino_armor", &function_1fe1dde207b07666 );
    function_ee3da014a4117632( #"mech", &function_d2f5fbf15fba705f );
    function_ee3da014a4117632( #"vampire_hunter", &function_f3b248f8f490901b );
    function_ee3da014a4117632( #"anime_knights", &function_4534e7fe41bc0d07 );
    function_ee3da014a4117632( #"harlequin", &function_fbb92c11b3a762ef );
    function_ee3da014a4117632( #"eldritch", &function_2dc8a868c2055cf );
    function_ee3da014a4117632( #"striker_wizards", &function_d3e15a40ed423fed );
    function_ee3da014a4117632( #"electricAnime", &function_3dd4cd23f7a40b3b );
    function_ee3da014a4117632( #"easter", &function_156d2e3a006b9e8a );
    function_ee3da014a4117632( #"scifi", &function_10befaf2d75b1318 );
    function_ee3da014a4117632( #"scifi2", &function_1e566c57e33c1b2a );
    function_ee3da014a4117632( #"scifi3", &function_71a5badf21c84daf );
    function_ee3da014a4117632( #"420", &function_7bdfb3ffd2ec0432 );
    function_ee3da014a4117632( #"hitscan", &function_b4802d28df000a50 );
    function_ee3da014a4117632( #"thor", &function_354884b05ce1e6e7 );
    function_ee3da014a4117632( #"kd", &function_ead20b21fee118f5 );
    function_ee3da014a4117632( #"cdl", &function_4a737c26e8f2af7f );
    function_ee3da014a4117632( #"soulEater", &function_8112584bc0f47cdc );
    function_ee3da014a4117632( #"crash", &mtx_crashdeath );
    function_ee3da014a4117632( #"akihabara", &function_4f239c5dd971f98c );
    function_ee3da014a4117632( #"magma", &function_6f112bc5b64c892b );
    function_ee3da014a4117632( #"cthulhu", &function_48122bf57920846d );
    function_ee3da014a4117632( #"hlander", &function_80325eed89fbbec6 );
    function_ee3da014a4117632( #"bnoir", &function_d112506f4f3a72a2 );
    function_ee3da014a4117632( #"nicki", &function_acc95e18efa344e6 );
    function_ee3da014a4117632( #"ice", &function_526ab8ba3e720951 );
    function_ee3da014a4117632( #"traider", &function_59f427e659e59656 );
    function_ee3da014a4117632( #"hips", &function_cac6c215604b1bb6 );
    function_ee3da014a4117632( #"hops", &function_5b4b07344f52aeac );
    function_ee3da014a4117632( #"blunt", &function_1e14fcd440666401 );
    function_ee3da014a4117632( #"maze", &function_b6c61638933fc2b5 );
    function_ee3da014a4117632( #"witch", &function_d29abe23b27afa99 );
    function_ee3da014a4117632( #"zombie", &function_7881cf4b9ba631d2 );
    function_ee3da014a4117632( #"zombiegun", &function_80325eed89fbbec6 );
    function_ee3da014a4117632( #"skeletor", &function_bbd222e5d970003d );
    function_ee3da014a4117632( #"bcell6", &function_f5a201517913628c );
    function_ee3da014a4117632( #"inarius", &function_d291d7954e8bd025 );
    function_ee3da014a4117632( #"lilith", &function_6ce07cbf124e29ec );
    function_ee3da014a4117632( #"souleatermelee", &function_8112584bc0f47cdc );
    function_ee3da014a4117632( #"noirmelee", &function_d112506f4f3a72a2 );
    function_ee3da014a4117632( #"icemelee", &function_526ab8ba3e720951 );
    function_ee3da014a4117632( #"traidermelee", &function_59f427e659e59656 );
    function_ee3da014a4117632( #"souleaterequip", &function_8112584bc0f47cdc );
    function_ee3da014a4117632( #"iceequip", &function_526ab8ba3e720951 );
    function_ee3da014a4117632( #"40kMelee", &function_f93e3f01a1b7a791 );
    function_ee3da014a4117632( #"blackcell_s5Melee", &function_101cbff94707b454 );
    function_ee3da014a4117632( #"underworldMelee", &function_2b9bf1a3a1bfe13e );
    function_ee3da014a4117632( #"wontonMelee", &function_5e11e3a4b3b78d7d );
    function_ee3da014a4117632( #"manduMelee", &function_fe7e870e73d2d56b );
    function_ee3da014a4117632( #"blackcellmelee", &function_58456461eb2687 );
    function_ee3da014a4117632( #"gilmanMelee", &function_e64be728c0e9123c );
    function_ee3da014a4117632( #"shapechangerMelee", &function_8480b4cc59c7eba5 );
    function_ee3da014a4117632( #"bikeMelee", &function_9e7383d20f5bf879 );
    function_ee3da014a4117632( #"pineapple", &function_ed03f0036ee25688 );
    function_ee3da014a4117632( #"tonfa", &function_d178c469de8d12f0 );
    function_ee3da014a4117632( #"vinyl", &function_7f3124192d315274 );
    function_ee3da014a4117632( #"voxel", &function_63c6b0a82b3a5e78 );
    function_ee3da014a4117632( #"oreZincMelee", &function_d7bf9ede0b764fe );
    
    if ( level.var_6a98fcae23c2e606 )
    {
        function_ee3da014a4117632( #"raygunRepair", &function_30f2d11294017281 );
    }
    
    function_ee3da014a4117632( #"hash_849214ec850729a9", &function_a039e2941d94b1fa );
    function_ee3da014a4117632( #"cerannihilate", &function_f7bf5db7589592cd );
    function_ee3da014a4117632( #"vaultmelee", &function_c4bdf31f66b16d0c );
    function_ee3da014a4117632( #"steampunkmelee", &function_8a3e94642281db28 );
    function_ee3da014a4117632( #"gvibesmelee", &function_70c79427f7f7b046 );
    function_ee3da014a4117632( #"deadopsmelee", &function_e0d25276ba90ddd2 );
    function_ee3da014a4117632( #"cartoonmelee", &function_fdef5d3b5ebecefe );
    function_ee3da014a4117632( #"hash_ef445cc36fc4f18c", &function_add52bc88c7f4b5f );
    function_ee3da014a4117632( #"hash_55b6eb9101b2e193", &function_679168476fe4e4e2 );
    function_ee3da014a4117632( #"hash_345b7545d4578762", &function_3233f38770168c37 );
    function_ee3da014a4117632( #"hash_d3b0705a5ff4f233", &function_8efa8b8c894fca98 );
    function_ee3da014a4117632( #"hash_b651841b688039e8", &function_8fcdcad357a21cb3 );
    function_ee3da014a4117632( #"bigjokemelee", &function_9ba4703156f6a935 );
    function_ee3da014a4117632( #"hash_886a93f35e370183", &function_9cd1f18cc02aa1d4 );
    function_ee3da014a4117632( #"hash_94c407fb854900cc", &function_19221b97e8a0fc0d );
    function_ee3da014a4117632( #"hash_327eb4b61aed9b6", &function_a4b186b340f4951d );
    function_ee3da014a4117632( #"baconmelee", &function_b01b5c2c9d832343 );
    function_ee3da014a4117632( #"tomatomelee", &function_f1c4db47cbe0c4da );
    function_ee3da014a4117632( #"sswordmelee", &function_88ed32f74f3bde2e );
    function_ee3da014a4117632( #"dinomelee", &function_5cd363f0519189cc );
    function_ee3da014a4117632( #"corgimelee", &function_35bdc6f5345139d8 );
    function_ee3da014a4117632( #"aqueenmelee", &function_3efb7c693ed2c9bf );
    function_ee3da014a4117632( #"hobbyhorsemelee", &function_b2235b457eb3ba6d );
    function_ee3da014a4117632( #"poodlemelee", &function_69aabe05bb1d9b65 );
    function_ee3da014a4117632( #"ikwydlsmelee", &function_90969660ae379481 );
    function_ee3da014a4117632( #"ahstormaremelee", &function_c6cd4b6cb3f433dc );
    function_ee3da014a4117632( #"tsoldiermelee", &function_a15233f558919f6a );
    function_ee3da014a4117632( #"wninjamelee", &function_ad81703b0dbdcfd7 );
    function_ee3da014a4117632( #"bluntevmelee", &function_26bd1f44452df27c );
    function_ee3da014a4117632( #"caramelmelee", &function_c408f703e9930131 );
    function_ee3da014a4117632( #"mskatemelee", &function_721f1aa368179ac3 );
    function_ee3da014a4117632( #"larpersmelee", &function_6c0a75767197569b );
    function_ee3da014a4117632( #"hallucinmelee", &function_c2248e2da31eb2d8 );
    function_d4f0e25fa6f90008( #"ufosm", &function_afd4ef408179cc, &function_80325eed89fbbec6 );
    function_d4f0e25fa6f90008( #"ufolg", &function_c6229012d9ae2e31, &function_80325eed89fbbec6 );
    function_d4f0e25fa6f90008( #"goldengun", &function_58a3eb2b8522894f, &function_3d5471b0be7f573 );
    function_d4f0e25fa6f90008( #"mahou", &function_1b40b711abb69b0a, &function_cb1be48c5e1c432e );
    function_d4f0e25fa6f90008( #"hlander", &function_2b23a8d93167aaaa, &function_80325eed89fbbec6 );
    
    if ( isbrgamemode() )
    {
        function_d4f0e25fa6f90008( #"ww_dg2", &isdg2death, &function_ff069494f4f8611b );
        function_d4f0e25fa6f90008( #"ww_raygun", &israygundeath, &function_415cef36c96147ee );
    }
    
    function_1d7e46ad31886165( #"40kmeleetakedown", &function_841b8126b9ad7ec, &function_a27cf61b0f889410 );
    function_1d7e46ad31886165( #"underworldmeleetakedown", &function_e201db4a8295f73b, &function_2b9bf1a3a1bfe13e );
    function_1d7e46ad31886165( #"wontonmeleetakedown", &function_8e7d6ecb4e9e5e08, &function_5e11e3a4b3b78d7d );
    function_1d7e46ad31886165( #"mandumeleetakedown", &function_4f86fb39c48e9806, &function_fe7e870e73d2d56b );
    function_1d7e46ad31886165( #"blackcell_s5meleetakedown", &function_339bb8a8f4bc9d61, &function_101cbff94707b454 );
    function_1d7e46ad31886165( #"gilmanmeleetakedown", &function_fa7c7cf1fd70bc59, &function_e64be728c0e9123c );
    function_1d7e46ad31886165( #"shapechangermeleetakedown", &function_838bd5b934c22dd0, &function_8480b4cc59c7eba5 );
    function_ef6181cda63ee216( #"ubsawmelee", &function_729828fcac8d474, &function_ce694afa144863b0 );
    function_694f19fbeb0f3368( #"lilithex", &function_5960fc0fb7bffe3b, &function_6203d97d033830f );
    function_bada7844f46775e6( #"electricanimeequip", &function_f4f1fcbd0e0d34f5, &function_3dd4cd23f7a40b3b );
    function_15c80b945cca8f1e( #"flameskullcharm", &function_13cb3d1273a49150, &function_35770a658413caf2 );
    function_15c80b945cca8f1e( #"crystamskullcharm", &function_a7f3d9242195ca49, &function_9ffd745177cd8ddb );
    function_15c80b945cca8f1e( #"starlightcharm", &function_61becbc5fa1954b4, &function_ae7741d6e4d1f456 );
    function_15c80b945cca8f1e( #"souleatercharm", &function_1d4b7a9f71cd1964, &function_2908752ba245a596 );
    function_15c80b945cca8f1e( #"crowfootcharm", &function_f90d9b5595a003b9, &function_fc7e6109eec28693 );
    function_15c80b945cca8f1e( #"pumpkinlanterncharm", &function_b1dd08e3d9d82da4, &function_da14b1fec376399e );
    function_15c80b945cca8f1e( #"weedcreaturecharm", &function_cb9177655cbbfa3c, &function_a577c047e5231896 );
    function_15c80b945cca8f1e( #"doomchainsaw", &isdoomchainsaw, &function_b07e6c587f6fcb2f );
    function_15c80b945cca8f1e( #"chainsword", &ischainsword, &function_a064aa18355f1b1c );
    function_15c80b945cca8f1e( #"toothfairy", &function_d7da8fc237e577f5, &function_60e04d6b4e5c151f );
    function_15c80b945cca8f1e( #"wonton_swhiskey", &function_ee1abbdbec1caece, &function_7970767ab0871d72 );
    function_e4e6636e8010b028( #"reactive_kill_streak_2stage", &function_8ae0d478f0823d1 );
    function_e4e6636e8010b028( #"reactive_kill_streak_3stage", &function_9afba82b040cd45e );
    function_e4e6636e8010b028( #"reactive_kill_streak_4stage", &function_f45ffc37d49a35b3 );
    function_e4e6636e8010b028( #"reactive_match_kills_2stage", &function_a6b273451bbcd568 );
    function_e4e6636e8010b028( #"reactive_match_kills_3stage", &function_6f778baaa85eb67b );
    function_e4e6636e8010b028( #"reactive_soul_collect_1stage", &function_e04dc23a6cbb586b );
    function_e4e6636e8010b028( #"reactive_movement", &function_33348af539a29bac );
    function_e4e6636e8010b028( #"reactive_enchantment", &function_dbafa6997df9da98 );
    function_e4e6636e8010b028( #"reactive_kill_weapon_3stage", &function_4117c7b8928e6f1d );
    function_e4e6636e8010b028( #"reactive_downgradable_kill_streak_3stage", &function_e26db89a9b95d302 );
    function_e4e6636e8010b028( #"reactive_kill_cycle_3stage", &function_641c450677a230f2 );
    function_e4e6636e8010b028( #"reactive_spawn", &function_70dbe327367e762 );
    function_e4e6636e8010b028( #"reactive_equipment_lethal_pullout", &function_8b51453f4c4e7bae );
    function_4965594dae6249f1( #"reactive_kill" );
    function_4965594dae6249f1( #"reactive_soul_collect" );
    function_4965594dae6249f1( #"reactive_damage_received" );
    function_91d94e2e3ac033ab();
    callback::add( #"player_spawned", &onplayerspawnedmtx );
    callback::add( "update_mtx_scriptable", &function_6787f99cc8476ca8 );
    
    /#
        thread function_c62e09e8e68ca737();
    #/
}

/#

    // Namespace mtx_weapon
    // Params 1, eflags: 0x4
    // Checksum 0x8b0b22ba, Offset: 0x5886
    // Size: 0x26, Type: dev
    function private function_3aa2c3b5ddc3a921( var_947251de6b33d774 )
    {
        assertmsg( "<dev string:x24>" + getxhashsourcename( var_947251de6b33d774 ) + "<dev string:x57>" );
    }

#/

// Namespace mtx_weapon
// Params 3
// Checksum 0x3e7bc058, Offset: 0x58b4
// Size: 0x5e
function function_d4f0e25fa6f90008( var_947251de6b33d774, conditionfunc, var_fec5355da8da22c7 )
{
    /#
        if ( isdefined( level.var_40db9032567cfca7[ var_947251de6b33d774 ] ) )
        {
            function_3aa2c3b5ddc3a921( var_947251de6b33d774 );
        }
    #/
    
    level.var_40db9032567cfca7[ var_947251de6b33d774 ] = { #deatheffect:var_fec5355da8da22c7, #conditions:conditionfunc };
}

// Namespace mtx_weapon
// Params 2
// Checksum 0x7aad5846, Offset: 0x591a
// Size: 0x4a
function function_ee3da014a4117632( var_947251de6b33d774, var_fec5355da8da22c7 )
{
    /#
        if ( isdefined( level.var_2a53ffec3874a987[ var_947251de6b33d774 ] ) )
        {
            function_3aa2c3b5ddc3a921( var_947251de6b33d774 );
        }
    #/
    
    level.var_2a53ffec3874a987[ var_947251de6b33d774 ] = { #deatheffect:var_fec5355da8da22c7 };
}

// Namespace mtx_weapon
// Params 3
// Checksum 0x5ec963e7, Offset: 0x596c
// Size: 0x5e
function function_ef6181cda63ee216( var_947251de6b33d774, conditionfunc, var_fec5355da8da22c7 )
{
    /#
        if ( isdefined( level.var_6cc157c91ced44eb[ var_947251de6b33d774 ] ) )
        {
            function_3aa2c3b5ddc3a921( var_947251de6b33d774 );
        }
    #/
    
    level.var_6cc157c91ced44eb[ var_947251de6b33d774 ] = { #deatheffect:var_fec5355da8da22c7, #conditions:conditionfunc };
}

// Namespace mtx_weapon
// Params 3
// Checksum 0x9e2a2010, Offset: 0x59d2
// Size: 0x5e
function function_1d7e46ad31886165( var_947251de6b33d774, conditionfunc, var_fec5355da8da22c7 )
{
    /#
        if ( isdefined( level.var_839fe802490703e4[ var_947251de6b33d774 ] ) )
        {
            function_3aa2c3b5ddc3a921( var_947251de6b33d774 );
        }
    #/
    
    level.var_839fe802490703e4[ var_947251de6b33d774 ] = { #deatheffect:var_fec5355da8da22c7, #conditions:conditionfunc };
}

// Namespace mtx_weapon
// Params 3
// Checksum 0x3b0d2e82, Offset: 0x5a38
// Size: 0x5e
function function_694f19fbeb0f3368( var_947251de6b33d774, conditionfunc, var_fec5355da8da22c7 )
{
    /#
        if ( isdefined( level.var_d8010ce982c6daa5[ var_947251de6b33d774 ] ) )
        {
            function_3aa2c3b5ddc3a921( var_947251de6b33d774 );
        }
    #/
    
    level.var_d8010ce982c6daa5[ var_947251de6b33d774 ] = { #deatheffect:var_fec5355da8da22c7, #conditions:conditionfunc };
}

// Namespace mtx_weapon
// Params 3
// Checksum 0x3b0252a4, Offset: 0x5a9e
// Size: 0x5e
function function_bada7844f46775e6( var_947251de6b33d774, conditionfunc, var_fec5355da8da22c7 )
{
    /#
        if ( isdefined( level.var_6cd087ff5695816b[ var_947251de6b33d774 ] ) )
        {
            function_3aa2c3b5ddc3a921( var_947251de6b33d774 );
        }
    #/
    
    level.var_6cd087ff5695816b[ var_947251de6b33d774 ] = { #deatheffect:var_fec5355da8da22c7, #conditions:conditionfunc };
}

// Namespace mtx_weapon
// Params 3
// Checksum 0x95c92821, Offset: 0x5b04
// Size: 0x4e
function function_15c80b945cca8f1e( var_947251de6b33d774, var_6d5927220460026c, var_9331280cb31a213d )
{
    /#
        function_f105c777ced4e078( var_947251de6b33d774 );
    #/
    
    level.var_8b428a7abd4b5588[ var_947251de6b33d774 ] = { #var_9331280cb31a213d:var_9331280cb31a213d, #conditionscharm:var_6d5927220460026c };
}

// Namespace mtx_weapon
// Params 2
// Checksum 0xb72e83e8, Offset: 0x5b5a
// Size: 0x3a
function function_e4e6636e8010b028( var_947251de6b33d774, var_9331280cb31a213d )
{
    /#
        function_f105c777ced4e078( var_947251de6b33d774 );
    #/
    
    level.var_cc75e39215a1ee5a[ var_947251de6b33d774 ] = { #var_9331280cb31a213d:var_9331280cb31a213d };
}

// Namespace mtx_weapon
// Params 1
// Checksum 0x3bcf97a0, Offset: 0x5b9c
// Size: 0x26
function function_4965594dae6249f1( var_947251de6b33d774 )
{
    /#
        function_f105c777ced4e078( var_947251de6b33d774 );
    #/
    
    level.var_c4d8205fc5f06ab5[ var_947251de6b33d774 ] = {};
}

/#

    // Namespace mtx_weapon
    // Params 1
    // Checksum 0x8720eb0f, Offset: 0x5bca
    // Size: 0x5e, Type: dev
    function function_f105c777ced4e078( var_947251de6b33d774 )
    {
        /#
            if ( isdefined( level.var_8b428a7abd4b5588[ var_947251de6b33d774 ] ) || isdefined( level.var_cc75e39215a1ee5a[ var_947251de6b33d774 ] ) || isdefined( level.var_c4d8205fc5f06ab5[ var_947251de6b33d774 ] ) )
            {
                assertmsg( "<dev string:x59>" + getxhashsourcename( var_947251de6b33d774 ) + "<dev string:x57>" );
            }
        #/
    }

#/

// Namespace mtx_weapon
// Params 0
// Checksum 0x11178aea, Offset: 0x5c30
// Size: 0x1d2
function function_91d94e2e3ac033ab()
{
    level.var_c7ae0663cc8de27c = [];
    
    if ( !isdefined( level.mapname ) )
    {
        level.mapname = getdvar( @"g_mapname" );
    }
    
    if ( issubstr( level.mapname, "frontend" ) )
    {
        level.var_c7ae0663cc8de27c[ #"match_kill_thresholds_2stage" ] = { #stage2:4, #stage1:2 };
        level.var_c7ae0663cc8de27c[ #"match_kill_thresholds_3stage" ] = { #stage3:6, #stage2:4, #stage1:2 };
        level.var_c7ae0663cc8de27c[ #"kill_streak_thresholds_2stage" ] = { #stage2:4, #stage1:2 };
        level.var_c7ae0663cc8de27c[ #"kill_streak_thresholds_3stage" ] = function_d6a206a8c16f5885();
        level.var_c7ae0663cc8de27c[ #"kill_streak_thresholds_4stage" ] = function_b18bff2aa698c276();
        level.var_c7ae0663cc8de27c[ #"kill_streak_thresholds_souleater" ] = 1;
        return;
    }
    
    level.var_c7ae0663cc8de27c[ #"match_kill_thresholds_2stage" ] = function_e394d8492212ddf3();
    level.var_c7ae0663cc8de27c[ #"match_kill_thresholds_3stage" ] = function_334808ed6fc79ab2();
    level.var_c7ae0663cc8de27c[ #"kill_streak_thresholds_2stage" ] = function_68a0237aa10a5714();
    level.var_c7ae0663cc8de27c[ #"kill_streak_thresholds_3stage" ] = function_d6a206a8c16f5885();
    level.var_c7ae0663cc8de27c[ #"kill_streak_thresholds_4stage" ] = function_b18bff2aa698c276();
    level.var_c7ae0663cc8de27c[ #"kill_streak_thresholds_souleater" ] = function_fa55d2a6d0191f9d();
    level.var_c7ae0663cc8de27c[ #"downgradable_kill_streak_thresholds_3stage" ] = function_3ac4b7797bf9b991();
}

// Namespace mtx_weapon
// Params 1
// Checksum 0xd917006c, Offset: 0x5e0a
// Size: 0x40
function onplayerspawnedmtx( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    function_eb5b8f4d7b9111b2();
    function_738493048a18f5e2();
    function_bb6fc6aabe552b3b();
    thread function_84676d67b776e68();
    thread function_c023dc8adec67cf8();
    thread function_553796ca442c42b9();
}

// Namespace mtx_weapon
// Params 0
// Checksum 0x299cf06e, Offset: 0x5e52
// Size: 0x285
function function_eb5b8f4d7b9111b2()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !function_a24e0c2dd531ae1c() )
    {
        self.var_ba0fee1a3d02f016 = [];
        function_745383dc254e8178( #"match_kills", 0 );
        function_745383dc254e8178( #"kill_streak", 0 );
        function_745383dc254e8178( #"reactive_kills", 0 );
        function_745383dc254e8178( #"souls_collected_count", 0 );
        function_745383dc254e8178( #"ghost_radar_active", 0 );
        function_745383dc254e8178( #"ghost_finder_sucking", 0 );
        function_745383dc254e8178( #"downgradable_kill_streak", 0 );
        function_745383dc254e8178( #"kill_streak_weapon", [] );
        function_745383dc254e8178( #"movement_state", #"neutral" );
        function_745383dc254e8178( #"all_scriptable_disablers", [] );
        function_745383dc254e8178( #"direct_scriptable_disablers", [] );
        function_745383dc254e8178( #"enchanted_weapons", [] );
        function_745383dc254e8178( #"soul_ents_in_flight", [] );
        function_745383dc254e8178( #"last_reactive_kill_time", -99999 );
        function_745383dc254e8178( #"last_reticle_kill_time", -99999 );
        function_745383dc254e8178( #"equipment_lethal_pullout", "off" );
        function_ce6577f1ddc5d04e( #"neutral" );
        function_849d75d167d2df2f( #"neutral" );
        self.var_ba0fee1a3d02f016[ #"mtx_scriptable_reactive_ids" ] = [];
        
        foreach ( scriptableid, scriptabledata in level.var_cc75e39215a1ee5a )
        {
            function_97bf7c711098ca98( scriptableid, #"neutral" );
        }
        
        self.var_ba0fee1a3d02f016[ #"mtx_scriptable_toggle_ids" ] = [];
        
        foreach ( scriptableid, scriptabledata in level.var_c4d8205fc5f06ab5 )
        {
            function_b282f58365d0a8eb( scriptableid );
        }
    }
    
    thread function_d6d20aeac2b839c0();
    thread function_956d4398d9f6e08d();
}

// Namespace mtx_weapon
// Params 0
// Checksum 0x1e22beb8, Offset: 0x60df
// Size: 0xc, Type: bool
function function_a24e0c2dd531ae1c()
{
    return isdefined( self.var_ba0fee1a3d02f016 );
}

// Namespace mtx_weapon
// Params 0
// Checksum 0x24c3ec2b, Offset: 0x60f4
// Size: 0x5c
function function_e394d8492212ddf3()
{
    if ( level.mtxkillthresholdstage1 > 0 && level.mtxkillthresholdstage2 > 0 )
    {
        return { #stage2:level.mtxkillthresholdstage2, #stage1:level.mtxkillthresholdstage1 };
    }
    
    return { #stage2:20, #stage1:10 };
}

// Namespace mtx_weapon
// Params 0
// Checksum 0xef9f3fe7, Offset: 0x6159
// Size: 0x88
function function_334808ed6fc79ab2()
{
    if ( level.mtxkillthresholdstage1 > 0 && level.mtxkillthresholdstage2 > 0 && level.var_5b9c78d5e5581287 > 0 )
    {
        return { #stage3:level.var_5b9c78d5e5581287, #stage2:level.mtxkillthresholdstage2, #stage1:level.mtxkillthresholdstage1 };
    }
    
    return { #stage3:30, #stage2:20, #stage1:10 };
}

// Namespace mtx_weapon
// Params 0
// Checksum 0x7aa9f6ff, Offset: 0x61ea
// Size: 0x19
function function_68a0237aa10a5714()
{
    return { #stage2:5, #stage1:2 };
}

// Namespace mtx_weapon
// Params 0
// Checksum 0xb1f52506, Offset: 0x620c
// Size: 0x24
function function_d6a206a8c16f5885()
{
    return { #stage3:3, #stage2:2, #stage1:1 };
}

// Namespace mtx_weapon
// Params 0
// Checksum 0xacf015ec, Offset: 0x6239
// Size: 0x2f
function function_b18bff2aa698c276()
{
    return { #stage4:9, #stage3:7, #stage2:5, #stage1:2 };
}

// Namespace mtx_weapon
// Params 0
// Checksum 0x60a65316, Offset: 0x6271
// Size: 0x4
function function_fa55d2a6d0191f9d()
{
    return 3;
}

// Namespace mtx_weapon
// Params 0
// Checksum 0xf37d752d, Offset: 0x627e
// Size: 0x24
function function_acb6b43a501d7519()
{
    return { #var_314daddf3f91237c:8, #stage2:5, #stage1:2 };
}

// Namespace mtx_weapon
// Params 0
// Checksum 0xe40268dd, Offset: 0x62ab
// Size: 0xb6
function function_3ac4b7797bf9b991()
{
    stage1killthreshold = 1;
    stage2killthreshold = 2;
    stage3killthreshold = 3;
    var_a30aab00db323c63 = getdvarint( @"hash_19443de5a3697190", -1 );
    var_37e93169943f7a80 = getdvarint( @"hash_7b707b9e08a2a8fd", -1 );
    var_e4051d3c50675b5 = getdvarint( @"hash_e225d9e8775ceae", -1 );
    
    if ( var_a30aab00db323c63 >= 0 )
    {
        stage1killthreshold = var_a30aab00db323c63;
    }
    
    if ( var_37e93169943f7a80 >= 0 )
    {
        stage2killthreshold = var_37e93169943f7a80;
    }
    
    if ( var_e4051d3c50675b5 >= 0 )
    {
        stage3killthreshold = var_e4051d3c50675b5;
    }
    
    return { #stage3:stage3killthreshold, #stage2:stage2killthreshold, #stage1:stage1killthreshold };
}

// Namespace mtx_weapon
// Params 1
// Checksum 0xaad0d644, Offset: 0x636a
// Size: 0x4a
function function_215f432bc7345e71( weapon )
{
    function_a047cf54a0568a91( weapon );
    function_1354def060a303cb( weapon );
    function_4715316f60336216();
    function_b4f609769b2429a3();
    function_950d6b4e4595768f( #"reactive_kill_weapon_3stage" );
    function_7b3cddcf6bfa5b4b();
    thread function_8b546220b05ec61a();
}

// Namespace mtx_weapon
// Params 0
// Checksum 0x1fc02f06, Offset: 0x63bc
// Size: 0x29
function function_8b546220b05ec61a()
{
    self endon( #"death_or_disconnect" );
    self endon( #"weapon_change" );
    waitframe();
    function_67886ef61e58e095();
    function_8d9bee5f6d9e92d();
}

// Namespace mtx_weapon
// Params 0
// Checksum 0x51f1c6e2, Offset: 0x63ed
// Size: 0x17
function function_940bfb34e152ae96()
{
    function_eb5b8f4d7b9111b2();
    function_7b3cddcf6bfa5b4b();
    function_ae9a5d4b17c9a5b9();
}

// Namespace mtx_weapon
// Params 1
// Checksum 0x431f063b, Offset: 0x640c
// Size: 0x64
function function_df0eeeccd6a86cb5( deathdata )
{
    if ( isplayer( deathdata.attacker ) )
    {
        deathdata.attacker function_ba18c5b844baaeae( self, deathdata.objweapon, deathdata.meansofdeath );
    }
    
    function_bd843c1bb194cf22( deathdata.objweapon, deathdata.meansofdeath );
}

// Namespace mtx_weapon
// Params 3
// Checksum 0x23c75038, Offset: 0x6478
// Size: 0x32
function function_49a6fc7df1c44a33( attacker, victim, weapon )
{
    if ( isplayer( attacker ) )
    {
        attacker function_b2e1577149099c4f( weapon, victim );
    }
}

// Namespace mtx_weapon
// Params 0
// Checksum 0x9d3faa64, Offset: 0x64b2
// Size: 0x11
function function_8647be440ecf68e9()
{
    if ( isplayer( self ) )
    {
        function_e57259d5b8ae715b();
    }
}

// Namespace mtx_weapon
// Params 7
// Checksum 0xd051ea5d, Offset: 0x64cb
// Size: 0x52
function function_82186dea3b314616( attacker, objweapon, meansofdeath, hitloc, inflictor, executionref, damageflags )
{
    return function_25b556f1c287bea0( attacker, objweapon, meansofdeath, hitloc, inflictor, executionref, damageflags );
}

// Namespace mtx_weapon
// Params 5
// Checksum 0xc0ae29b8, Offset: 0x6526
// Size: 0x53
function function_31632334e41cf319( attacker, objweapon, meansofdeath, hitloc, inflictor )
{
    if ( isplayer( attacker ) )
    {
        attacker function_ba18c5b844baaeae( self, objweapon, meansofdeath );
    }
    
    return function_25b556f1c287bea0( attacker, objweapon, meansofdeath, hitloc, inflictor );
}

// Namespace mtx_weapon
// Params 1
// Checksum 0x5f6decaa, Offset: 0x6582
// Size: 0x8f
function function_5da3bf4fd1233318( deathdata )
{
    if ( isplayer( deathdata.attacker ) )
    {
        deathdata.attacker function_ba18c5b844baaeae( self, deathdata.objweapon, deathdata.meansofdeath );
    }
    
    return function_25b556f1c287bea0( deathdata.attacker, deathdata.objweapon, deathdata.meansofdeath, deathdata.hitloc, deathdata.inflictor, deathdata.damageflags );
}

// Namespace mtx_weapon
// Params 0
// Checksum 0xfc12cb9a, Offset: 0x661a
// Size: 0x4a
function function_3c5b3042f8d8a4f7()
{
    self endon( #"death_or_disconnect" );
    self endon( #"shockstick_haywireapplied" );
    function_6afbbbaa99e9b63a( #"vfx_disabled_for_haywire" );
    self waittill( #"haywire_cleared" );
    wait 1;
    function_92a1d0ce843e431( #"vfx_disabled_for_haywire" );
}

// Namespace mtx_weapon
// Params 0
// Checksum 0x882c8cba, Offset: 0x666c
// Size: 0x12
function function_554ad3c9ed9bc64()
{
    function_6afbbbaa99e9b63a( #"vfx_disabled_for_jugg" );
}

// Namespace mtx_weapon
// Params 0
// Checksum 0xf944542c, Offset: 0x6686
// Size: 0x12
function function_f890ffd15106d12d()
{
    function_92a1d0ce843e431( #"vfx_disabled_for_jugg" );
}

// Namespace mtx_weapon
// Params 0
// Checksum 0x1285df53, Offset: 0x66a0
// Size: 0x12
function function_61f9d1047d33e77e()
{
    function_6afbbbaa99e9b63a( #"vfx_disabled_for_hiding" );
}

// Namespace mtx_weapon
// Params 0
// Checksum 0xaeb459ec, Offset: 0x66ba
// Size: 0x12
function function_6e83b6d312e47cb3()
{
    function_92a1d0ce843e431( #"vfx_disabled_for_hiding" );
}

// Namespace mtx_weapon
// Params 0
// Checksum 0x9f03529a, Offset: 0x66d4
// Size: 0x12
function function_4bafd0f14b064f2a()
{
    function_6afbbbaa99e9b63a( #"hash_d58327d11de60124" );
}

// Namespace mtx_weapon
// Params 0
// Checksum 0xabc0b44a, Offset: 0x66ee
// Size: 0x12
function function_7b8972f2b1aa0a67()
{
    function_92a1d0ce843e431( #"hash_d58327d11de60124" );
}

// Namespace mtx_weapon
// Params 1
// Checksum 0xa70ba65c, Offset: 0x6708
// Size: 0x24, Type: bool
function function_a7ecd67ebbd6ca43( entity )
{
    return isdefined( entity ) && entity.model == "military_shooting_target_armor_01_assembly";
}

// Namespace mtx_weapon
// Params 0
// Checksum 0x7ba4c3, Offset: 0x6735
// Size: 0x8
function function_1e26d71a360eed47()
{
    return function_e04dc23a6cbb586b();
}

// Namespace mtx_weapon
// Params 1
// Checksum 0x94c78e19, Offset: 0x6746
// Size: 0x3a, Type: bool
function function_4903b4967df7673f( objweapon )
{
    deathfxname = function_765a22b52d7fbd68( objweapon );
    
    if ( isdefined( deathfxname ) )
    {
        return ( function_765a22b52d7fbd68( objweapon ) == #"souleaterequip" );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 2
// Checksum 0x16e864cd, Offset: 0x6789
// Size: 0x4f, Type: bool
function function_7d4bcd24208138bd( meansofdeath, objweapon )
{
    if ( getdvarint( @"hash_2bb4e0ec793e3a4c", 1 ) && isbulletdeath( meansofdeath ) && function_448a388e17c007b1( objweapon ) && function_3773fda9649573ca( objweapon ) )
    {
        return true;
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 1
// Checksum 0x3558d2fc, Offset: 0x67e1
// Size: 0x1d
function function_448a388e17c007b1( weapon )
{
    if ( !isdefined( weapon ) )
    {
        return 0;
    }
    
    return function_58e17385a1fd1a9( weapon );
}

// Namespace mtx_weapon
// Params 1
// Checksum 0xbe690aa3, Offset: 0x6807
// Size: 0x3a, Type: bool
function function_5b487a3dc8c6f598( objweapon )
{
    deathfxname = function_765a22b52d7fbd68( objweapon );
    
    if ( isdefined( deathfxname ) )
    {
        return ( function_765a22b52d7fbd68( objweapon ) == #"zombiegun" );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 2
// Checksum 0xb885d671, Offset: 0x684a
// Size: 0x1c9
function function_7422699c4b8bf172( idamage, victim )
{
    if ( getdvarint( @"hash_f8094d20d531b0b5", 1 ) )
    {
        if ( isdefined( victim ) )
        {
            if ( victim.zombie )
            {
                idamage *= getdvarint( @"hash_5c741bd119d504fe", 1 );
            }
            else if ( self.issmallufo )
            {
                idamage *= getdvarint( @"hash_5b0de654fa5013ba", 1 );
            }
            else if ( victim.targetname == "veh9_ufo_lg" )
            {
                idamage *= getdvarint( @"hash_335d3b6aa7c7ac96", 1 );
            }
            else if ( victim.targetname == "saba_orb" )
            {
                idamage *= getdvarint( @"hash_bbf4ac6f9293a467", 1 );
            }
            else if ( victim.agent_type == "actor_enemy_mp_boss_mummy_minion" )
            {
                idamage *= getdvarint( @"hash_74b01cccd2b6aaf6", 1 );
            }
            else if ( isdefined( victim.agent_type ) && ( victim.agent_type == "actor_enemy_mp_ar_tier3_affected_ru" || victim.agent_type == "actor_enemy_mp_jugg_affected_ru" ) )
            {
                idamage *= getdvarint( @"hash_4d810bff1f4993c4", 1 );
            }
            else if ( victim.agent_type == "actor_enemy_mp_boss_swampmonster" )
            {
                idamage *= getdvarint( @"hash_6267ea49aa81a4d2", 1 );
            }
            else if ( victim.agent_type == "actor_enemy_mp_boss_butcher" )
            {
                idamage *= getdvarint( @"hash_b85e4b9bc8f55a8d", 1 );
            }
            else if ( victim.agent_type == "actor_enemy_mp_boss_mummy" )
            {
                idamage *= getdvarint( @"hash_ecffb3b94bcd65bd", 1 );
            }
        }
        
        return idamage;
    }
    
    return idamage;
}

// Namespace mtx_weapon
// Params 0
// Checksum 0xc6348df2, Offset: 0x6a1c
// Size: 0x12
function function_99aa382394d75e94()
{
    function_c80dc1fc69011a01( #"reactive_soul_collect" );
}

// Namespace mtx_weapon
// Params 0
// Checksum 0x5227bebf, Offset: 0x6a36
// Size: 0x5a
function function_40ef96d3093d9f1e()
{
    if ( self.var_ba0fee1a3d02f016[ #"ghost_radar_active" ] && !self.var_ba0fee1a3d02f016[ #"ghost_finder_sucking" ] )
    {
        self setscriptablepartstate( #"mtxvfxgunscreen", "ghostFinderActiveImmediate" );
        self.var_ba0fee1a3d02f016[ #"ghost_finder_sucking" ] = 1;
    }
}

// Namespace mtx_weapon
// Params 0
// Checksum 0x81448bee, Offset: 0x6a98
// Size: 0x45
function function_1f1496f03d03936d()
{
    if ( self.var_ba0fee1a3d02f016[ #"ghost_finder_sucking" ] )
    {
        self setscriptablepartstate( #"mtxvfxgunscreen", #"neutral" );
        self.var_ba0fee1a3d02f016[ #"ghost_finder_sucking" ] = 0;
    }
}

// Namespace mtx_weapon
// Params 0
// Checksum 0xfacc6e3e, Offset: 0x6ae5
// Size: 0x2c
function function_758b595af36e5a34()
{
    if ( self.var_ba0fee1a3d02f016[ #"ghost_radar_active" ] )
    {
        self setscriptablepartstate( #"mtxvfxgunscreenoneshot", "ghostFinderAbsorbed" );
    }
}

// Namespace mtx_weapon
// Params 0
// Checksum 0xadc5566e, Offset: 0x6b19
// Size: 0x51
function function_8e324d558c3fbc01()
{
    var_c1f62dac265ba909 = level.var_c4d8205fc5f06ab5[ #"reactive_damage_received" ] && self isscriptable() && self getscriptablehaspart( #"reactive_damage_received" );
    
    if ( var_c1f62dac265ba909 )
    {
        function_c80dc1fc69011a01( #"reactive_damage_received" );
    }
}

// Namespace mtx_weapon
// Params 7, eflags: 0x4
// Checksum 0x5ff724cd, Offset: 0x6b72
// Size: 0x361
function private function_25b556f1c287bea0( attacker, objweapon, meansofdeath, hitloc, inflictor, executionref, damageflags )
{
    if ( meansofdeath == "MOD_SUICIDE" )
    {
        return 0;
    }
    
    blueprintdeathfx = function_765a22b52d7fbd68( objweapon );
    
    if ( !function_c9c6145683e2af2( self, blueprintdeathfx ) )
    {
        return 0;
    }
    
    if ( !isdefined( blueprintdeathfx ) && getdvarint( @"hash_4753586a2ac8718f", 0 ) == 1 )
    {
        blueprintdeathfx = #"voxel";
    }
    
    if ( isdefined( blueprintdeathfx ) )
    {
        assert( isdefined( level.var_2a53ffec3874a987[ blueprintdeathfx ] ), "<dev string:x8f>" + getxhashsourcename( blueprintdeathfx ) + "<dev string:x99>" );
    }
    
    if ( isbulletdeath( meansofdeath ) || iscrushdeath( meansofdeath ) )
    {
        if ( isdefined( blueprintdeathfx ) )
        {
            bodydeleted = function_8aedd3bee81657a6( level.var_2a53ffec3874a987, attacker, blueprintdeathfx, hitloc, damageflags );
        }
        else
        {
            bodydeleted = function_ea37f6509c4ad7a8( level.var_40db9032567cfca7, attacker, objweapon, hitloc, damageflags );
        }
        
        return bodydeleted;
    }
    else if ( ismeleedeath( meansofdeath ) )
    {
        ismeleeweapon = istrue( objweapon.ismelee );
        
        if ( isdefined( blueprintdeathfx ) && ismeleeweapon )
        {
            return function_8aedd3bee81657a6( level.var_2a53ffec3874a987, attacker, blueprintdeathfx, hitloc, damageflags );
        }
        else if ( getdvarint( @"hash_4753586a2ac8718f", 0 ) == 1 )
        {
            blueprintdeathfx = #"voxel";
            
            if ( isdefined( level.var_2a53ffec3874a987[ blueprintdeathfx ] ) )
            {
                return function_8aedd3bee81657a6( level.var_2a53ffec3874a987, attacker, blueprintdeathfx, hitloc );
            }
        }
        else
        {
            return function_ea37f6509c4ad7a8( level.var_6cc157c91ced44eb, attacker, objweapon, hitloc, damageflags );
        }
    }
    else if ( function_df398e980fd947c5( meansofdeath ) )
    {
        ismeleeweapon = istrue( objweapon.ismelee );
        
        if ( isdefined( blueprintdeathfx ) && ismeleeweapon )
        {
            return function_8aedd3bee81657a6( level.var_2a53ffec3874a987, attacker, blueprintdeathfx, hitloc, damageflags );
        }
        else
        {
            return function_ea37f6509c4ad7a8( level.var_839fe802490703e4, attacker, objweapon, hitloc, damageflags );
        }
    }
    else if ( isexecutiondeath( meansofdeath ) && isdefined( executionref ) )
    {
        objweapon = spawnstruct();
        objweapon.executionref = executionref;
        return function_ea37f6509c4ad7a8( level.var_d8010ce982c6daa5, attacker, objweapon, hitloc, damageflags );
    }
    else if ( isequipmentdeath( meansofdeath ) )
    {
        if ( function_3e33cd3913a893a1( inflictor ) )
        {
            return function_d4ef90a55afa0767( self.body );
        }
        
        if ( isdefined( blueprintdeathfx ) )
        {
            if ( blueprintdeathfx == #"blackcell_s5Melee" )
            {
                return 0;
            }
            else if ( blueprintdeathfx == #"gilmanMelee" )
            {
                return 0;
            }
            
            return function_8aedd3bee81657a6( level.var_2a53ffec3874a987, attacker, blueprintdeathfx, hitloc, damageflags );
        }
        else
        {
            return function_ea37f6509c4ad7a8( level.var_6cd087ff5695816b, attacker, objweapon, hitloc, damageflags );
        }
    }
    else if ( level.gametype == "gold_gun" )
    {
        bodydeleted = function_ea37f6509c4ad7a8( level.var_40db9032567cfca7, attacker, objweapon, hitloc, damageflags );
        return bodydeleted;
    }
    else if ( isprojectiledeath( meansofdeath ) || iselementaldeath( meansofdeath ) )
    {
        if ( isdefined( blueprintdeathfx ) )
        {
            bodydeleted = function_8aedd3bee81657a6( level.var_2a53ffec3874a987, attacker, blueprintdeathfx, hitloc, damageflags );
        }
        else
        {
            bodydeleted = function_ea37f6509c4ad7a8( level.var_40db9032567cfca7, attacker, objweapon, hitloc, damageflags );
        }
        
        return bodydeleted;
    }
    
    return 0;
}

// Namespace mtx_weapon
// Params 2, eflags: 0x4
// Checksum 0x5ef20bc5, Offset: 0x6edc
// Size: 0xa5, Type: bool
function private function_c9c6145683e2af2( ai, blueprintdeathfx )
{
    if ( isdefined( ai ) )
    {
        if ( isdefined( ai.aicategory ) )
        {
            if ( ai.aicategory == "special" || ai.aicategory == "elite" || ai.aicategory == "hvt" || ai.aicategory == "boss" )
            {
                return false;
            }
        }
        
        if ( ai.var_7bd2fc702f01b407 )
        {
            return false;
        }
        
        if ( isdefined( ai.var_aefddffa9c30aff3[ blueprintdeathfx ] ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x32e9ea51, Offset: 0x6f8a
// Size: 0x14, Type: bool
function private ismeleedeath( meansofdeath )
{
    return meansofdeath == "MOD_MELEE";
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x246c742f, Offset: 0x6fa7
// Size: 0x14, Type: bool
function private function_df398e980fd947c5( meansofdeath )
{
    return meansofdeath == "MOD_MELEE_TAKEDOWN";
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x2de6ae31, Offset: 0x6fc4
// Size: 0x14, Type: bool
function private isexecutiondeath( meansofdeath )
{
    return meansofdeath == "MOD_EXECUTION";
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x7c108953, Offset: 0x6fe1
// Size: 0x38, Type: bool
function private isbulletdeath( meansofdeath )
{
    return meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_EXPLOSIVE_BULLET" || meansofdeath == "MOD_HEAD_SHOT" || meansofdeath == "MOD_PISTOL_BULLET";
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x5fbb73b0, Offset: 0x7022
// Size: 0x38, Type: bool
function private isequipmentdeath( meansofdeath )
{
    return meansofdeath == "MOD_IMPACT" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_FIRE" || meansofdeath == "MOD_EXPLOSIVE";
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x3cc5e5a2, Offset: 0x7063
// Size: 0x14, Type: bool
function private iscrushdeath( meansofdeath )
{
    return meansofdeath == "MOD_CRUSH";
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xbd0b3506, Offset: 0x7080
// Size: 0x20, Type: bool
function private isprojectiledeath( meansofdeath )
{
    return meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_PROJECTILE_SPLASH";
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xed3a75ac, Offset: 0x70a9
// Size: 0x50, Type: bool
function private iselementaldeath( meansofdeath )
{
    return meansofdeath == "MOD_ELEMENTAL_FIRE" || meansofdeath == "MOD_ELEMENTAL_ELEC" || meansofdeath == "MOD_ELEMENTAL_COLD" || meansofdeath == "MOD_ELEMENTAL_TOXIC" || meansofdeath == "MOD_ELEMENTAL_DARK" || meansofdeath == "MOD_ELEMENTAL_LIGHT";
}

// Namespace mtx_weapon
// Params 5, eflags: 0x4
// Checksum 0x10a23bdc, Offset: 0x7102
// Size: 0xe4
function private function_ea37f6509c4ad7a8( var_a27ab65ddffe7d6f, attacker, objweapon, hitloc, damageflags )
{
    foreach ( var_4927aa92bc02edef in var_a27ab65ddffe7d6f )
    {
        if ( [[ var_4927aa92bc02edef.conditions ]]( objweapon ) )
        {
            corpsedeleted = self [[ var_4927aa92bc02edef.deatheffect ]]( self.body, attacker, hitloc, damageflags );
            assert( isdefined( corpsedeleted ), "<dev string:xc4>" );
            return corpsedeleted;
        }
    }
    
    return 0;
}

// Namespace mtx_weapon
// Params 5, eflags: 0x4
// Checksum 0xc086ef8, Offset: 0x71ef
// Size: 0x80
function private function_8aedd3bee81657a6( var_a91bac50e79fffa8, attacker, blueprintdeathfx, hitloc, damageflags )
{
    var_fec5355da8da22c7 = var_a91bac50e79fffa8[ blueprintdeathfx ].deatheffect;
    
    if ( isdefined( var_fec5355da8da22c7 ) )
    {
        corpsedeleted = self [[ var_fec5355da8da22c7 ]]( self.body, attacker, hitloc, damageflags );
        assert( isdefined( corpsedeleted ), "<dev string:x10b>" );
        return corpsedeleted;
    }
    
    return 0;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xaac78bd9, Offset: 0x7278
// Size: 0xa8
function private function_765a22b52d7fbd68( objweapon )
{
    if ( isdefined( objweapon.modifierblueprint.deathfxname ) && objweapon.modifierblueprint.deathfxname != "" )
    {
        return objweapon.modifierblueprint.deathfxname;
    }
    
    if ( isdefined( objweapon.receiverblueprint.deathfxname ) && objweapon.receiverblueprint.deathfxname != "" )
    {
        return objweapon.receiverblueprint.deathfxname;
    }
}

// Namespace mtx_weapon
// Params 3
// Checksum 0xb849ee70, Offset: 0x7329
// Size: 0x184
function function_ba18c5b844baaeae( victim, weapon, meansofdeath )
{
    if ( !isenemykill( victim, meansofdeath ) )
    {
        return;
    }
    
    self.var_ba0fee1a3d02f016[ #"match_kills" ]++;
    self.var_ba0fee1a3d02f016[ #"kill_streak" ]++;
    setkillstreakweapon( weapon );
    self.var_ba0fee1a3d02f016[ #"downgradable_kill_streak" ]++;
    
    if ( self isscriptable() )
    {
        function_950d6b4e4595768f( #"reactive_kill_streak_2stage" );
        function_950d6b4e4595768f( #"reactive_kill_streak_3stage" );
        function_950d6b4e4595768f( #"reactive_kill_streak_4stage" );
        function_950d6b4e4595768f( #"reactive_kill_weapon_3stage" );
        function_950d6b4e4595768f( #"reactive_match_kills_2stage" );
        function_950d6b4e4595768f( #"reactive_match_kills_3stage" );
        function_950d6b4e4595768f( #"reactive_downgradable_kill_streak_3stage" );
        function_950d6b4e4595768f( #"reactive_kill_cycle_3stage" );
        thread function_b7ae5a371a7345dd();
    }
    
    if ( isdefined( weapon ) )
    {
        var_c9b45073156db3b5 = function_ebff581d2980bfd0( weapon, meansofdeath );
        
        if ( var_c9b45073156db3b5 )
        {
            thread function_ba2c8132201152f6();
        }
        
        if ( function_d84cf7c6ffe66d22( weapon ) )
        {
            thread function_98452d5852f8dbcb();
        }
    }
    
    if ( getdvarint( @"hash_69baacf228c08181", 0 ) == 1 && meansofdeath == "MOD_MELEE" && isdefined( self.perks[ "specialty_super_strength" ] ) )
    {
        weapon_utility::function_626fe75ad9d2d09b( victim, #"j_spinelower", "boys_super_str" );
    }
}

// Namespace mtx_weapon
// Params 2, eflags: 0x4
// Checksum 0x341de45c, Offset: 0x74b5
// Size: 0x82
function private function_bd843c1bb194cf22( objweapon, meansofdeath )
{
    function_826a1744af715c95();
    
    if ( self isscriptable() )
    {
        function_950d6b4e4595768f( #"reactive_kill_streak_2stage" );
        function_950d6b4e4595768f( #"reactive_kill_streak_3stage" );
        function_950d6b4e4595768f( #"reactive_kill_streak_4stage" );
        function_950d6b4e4595768f( #"reactive_kill_weapon_3stage" );
        function_950d6b4e4595768f( #"reactive_downgradable_kill_streak_3stage" );
    }
    
    function_4715316f60336216();
    function_6ce55e7812f9db35();
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xb1f83e16, Offset: 0x753f
// Size: 0xbd
function private setkillstreakweapon( weapon )
{
    sweap = function_a3021a8d293d6d0c( weapon );
    
    if ( sweap == "none" )
    {
        return;
    }
    
    if ( !isdefined( self.var_ba0fee1a3d02f016[ #"kill_streak_weapon" ][ sweap ] ) )
    {
        if ( self.var_ba0fee1a3d02f016[ #"kill_streak_weapon" ].size > 8 )
        {
            self.var_ba0fee1a3d02f016[ #"kill_streak_weapon" ] = function_ad41fa8acd40e0b9( self.var_ba0fee1a3d02f016[ #"kill_streak_weapon" ] );
        }
        
        self.var_ba0fee1a3d02f016[ #"kill_streak_weapon" ][ sweap ] = 0;
    }
    
    self.var_ba0fee1a3d02f016[ #"kill_streak_weapon" ][ sweap ]++;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x692e72f2, Offset: 0x7604
// Size: 0x47, Type: bool
function private getkillstreakweapon( weapon )
{
    sweap = function_a3021a8d293d6d0c( weapon );
    
    if ( sweap == "none" )
    {
        return false;
    }
    
    return self.var_ba0fee1a3d02f016[ #"kill_streak_weapon" ][ sweap ] ?? 0;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xe650aec6, Offset: 0x7654
// Size: 0x55
function private function_a3021a8d293d6d0c( weapon )
{
    if ( !isdefined( weapon.basename ) )
    {
        return "none";
    }
    
    if ( !isdefined( weapon.variantid ) )
    {
        return weapon.basename;
    }
    
    return weapon.basename + weapon.variantid;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x97cd890c, Offset: 0x76b2
// Size: 0x143
function private function_ad41fa8acd40e0b9( array )
{
    newarray = [];
    unequippedskipped = 0;
    primaries = self getweaponslistprimaries();
    var_c3d294ecb2eadef6 = [];
    
    foreach ( weapon in primaries )
    {
        var_c3d294ecb2eadef6[ var_c3d294ecb2eadef6.size ] = function_a3021a8d293d6d0c( weapon );
    }
    
    var_c3d294ecb2eadef6 = arrayremoveduplicates( var_c3d294ecb2eadef6 );
    
    foreach ( key, value in array )
    {
        if ( unequippedskipped < 3 )
        {
            if ( !arraycontains( var_c3d294ecb2eadef6, key ) )
            {
                unequippedskipped++;
                continue;
            }
        }
        
        newarray[ key ] = value;
    }
    
    return newarray;
}

// Namespace mtx_weapon
// Params 2, eflags: 0x4
// Checksum 0x1dc933ea, Offset: 0x77fe
// Size: 0x40, Type: bool
function private isenemykill( victim, meansofdeath )
{
    if ( !isdefined( meansofdeath ) || "meansOfDeath" == "MOD_SUICIDE" )
    {
        return false;
    }
    
    if ( !isdefined( victim ) || victim == self )
    {
        return false;
    }
    
    return true;
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0xe23612a7, Offset: 0x7847
// Size: 0x70
function private function_d6d20aeac2b839c0()
{
    self notify( #"mtx_manageoffhands" );
    self endon( #"mtx_manageoffhands" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"weapon_switch_started" );
        
        if ( self isthrowinggrenade() )
        {
            function_5c269c1df4432eb7( #"vfx_disabled_for_offhand" );
            self waittill( #"offhand_end" );
            function_16a067a89a3bca12( #"vfx_disabled_for_offhand" );
        }
    }
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0x30973e76, Offset: 0x78bf
// Size: 0xe7
function private function_956d4398d9f6e08d()
{
    self notify( #"mtx_managemovementdisable" );
    self endon( #"mtx_managemovementdisable" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        while ( !self isswimsprinting() && !self isskydiving() && !self isparachuting() )
        {
            utility::waittill_any( #"swim_sprint_begin", "skydive_deployparachute", "skydive_beginfreefall", "freefall", "open_parachute", "vehicle_enter", "vehicle_exit" );
        }
        
        function_5c269c1df4432eb7( #"vfx_disabled_for_movement" );
        
        while ( self isswimsprinting() || self isskydiving() || self isparachuting() )
        {
            utility::waittill_any( #"swim_sprint_end", "skydive_end", "parachute_landed", "parachute_complete", "mantle_start", "vehicle_enter", "vehicle_exit" );
        }
        
        function_16a067a89a3bca12( #"vfx_disabled_for_movement" );
    }
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xa7623fc8, Offset: 0x79ae
// Size: 0x77
function private function_5c269c1df4432eb7( disabler )
{
    if ( !isdefined( self.var_ba0fee1a3d02f016 ) )
    {
        return;
    }
    
    if ( disabler && !arraycontains( self.var_ba0fee1a3d02f016[ #"direct_scriptable_disablers" ], disabler ) )
    {
        self.var_ba0fee1a3d02f016[ #"direct_scriptable_disablers" ][ self.var_ba0fee1a3d02f016[ #"direct_scriptable_disablers" ].size ] = disabler;
    }
    
    function_4715316f60336216();
    function_b4f609769b2429a3();
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x36e8dd6, Offset: 0x7a2d
// Size: 0x78
function private function_16a067a89a3bca12( disabler )
{
    if ( !isdefined( self.var_ba0fee1a3d02f016 ) )
    {
        return;
    }
    
    if ( disabler && arraycontains( self.var_ba0fee1a3d02f016[ #"direct_scriptable_disablers" ], disabler ) )
    {
        self.var_ba0fee1a3d02f016[ #"direct_scriptable_disablers" ] = arrayremove( self.var_ba0fee1a3d02f016[ #"direct_scriptable_disablers" ], disabler );
    }
    
    function_67886ef61e58e095();
    function_beecabff9ba66b0c();
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x70f537b, Offset: 0x7aad
// Size: 0x77
function private function_6afbbbaa99e9b63a( disabler )
{
    if ( !isdefined( self.var_ba0fee1a3d02f016 ) )
    {
        return;
    }
    
    if ( disabler && !arraycontains( self.var_ba0fee1a3d02f016[ #"all_scriptable_disablers" ], disabler ) )
    {
        self.var_ba0fee1a3d02f016[ #"all_scriptable_disablers" ][ self.var_ba0fee1a3d02f016[ #"all_scriptable_disablers" ].size ] = disabler;
    }
    
    function_4715316f60336216();
    function_de68beacbfc3a070();
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xf116fe4b, Offset: 0x7b2c
// Size: 0x78
function private function_92a1d0ce843e431( disabler )
{
    if ( !isdefined( self.var_ba0fee1a3d02f016 ) )
    {
        return;
    }
    
    if ( disabler && arraycontains( self.var_ba0fee1a3d02f016[ #"all_scriptable_disablers" ], disabler ) )
    {
        self.var_ba0fee1a3d02f016[ #"all_scriptable_disablers" ] = arrayremove( self.var_ba0fee1a3d02f016[ #"all_scriptable_disablers" ], disabler );
    }
    
    function_67886ef61e58e095();
    function_738493048a18f5e2();
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0xb35c886a, Offset: 0x7bac
// Size: 0xd4
function private function_67886ef61e58e095()
{
    var_7103c71e537f7608 = 0;
    
    if ( isdefined( self.currentweapon ) && function_7033955c4c118f03() )
    {
        foreach ( scriptableid, scriptabledata in level.var_8b428a7abd4b5588 )
        {
            if ( [[ scriptabledata.conditionscharm ]]( self.currentweapon ) )
            {
                thread function_1f13d9d15cee4a5c( scriptableid, scriptabledata, self.currentweapon );
                var_7103c71e537f7608 = 1;
                break;
            }
        }
    }
    
    if ( !var_7103c71e537f7608 )
    {
        function_4715316f60336216();
    }
}

// Namespace mtx_weapon
// Params 3, eflags: 0x4
// Checksum 0xacf32296, Offset: 0x7c88
// Size: 0xc2
function private function_1f13d9d15cee4a5c( scriptableid, scriptabledata, weapon )
{
    if ( !isdefined( weapon ) )
    {
        return;
    }
    
    state = [[ scriptabledata.var_9331280cb31a213d ]]( weapon );
    
    if ( !self getscriptableparthasstate( #"mtxvfxcharm", state ) )
    {
        /#
            if ( !getdvarint( @"hash_808d350f6f481a67", 0 ) )
            {
                println( "<dev string:x152>" + getxhashsourcename( state ) + "<dev string:x179>" );
            }
        #/
        
        return;
    }
    
    if ( self.var_ba0fee1a3d02f016[ #"mtx_scriptable_charm_state" ] != state )
    {
        self.var_ba0fee1a3d02f016[ #"mtx_scriptable_charm_state" ] = state;
        self setscriptablepartstate( #"mtxvfxcharm", state );
    }
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0x1af438a3, Offset: 0x7d52
// Size: 0x57
function private function_4715316f60336216()
{
    if ( self.var_ba0fee1a3d02f016[ #"mtx_scriptable_charm_state" ] != #"neutral" )
    {
        self.var_ba0fee1a3d02f016[ #"mtx_scriptable_charm_state" ] = #"neutral";
        self setscriptablepartstate( #"mtxvfxcharm", #"neutral" );
    }
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0x2d6ca3b6, Offset: 0x7db1
// Size: 0x39, Type: bool
function private function_7033955c4c118f03()
{
    if ( self.var_ba0fee1a3d02f016[ #"direct_scriptable_disablers" ].size > 0 || self.var_ba0fee1a3d02f016[ #"all_scriptable_disablers" ].size > 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0x170f2f0f, Offset: 0x7df3
// Size: 0xd4
function private function_beecabff9ba66b0c()
{
    var_190dd73bba827d37 = 0;
    
    if ( isdefined( self.currentweapon ) && function_b8a09efab8d7c56e() )
    {
        foreach ( scriptableid, scriptabledata in level.var_f1aeabe082d92591 )
        {
            if ( [[ scriptabledata.conditionsgunscreen ]]( self.currentweapon ) )
            {
                thread function_cf9b62807022191f( scriptableid, scriptabledata, self.currentweapon );
                var_190dd73bba827d37 = 1;
                break;
            }
        }
    }
    
    if ( !var_190dd73bba827d37 )
    {
        function_b4f609769b2429a3();
    }
}

// Namespace mtx_weapon
// Params 3, eflags: 0x4
// Checksum 0x6b0dd639, Offset: 0x7ecf
// Size: 0x81
function private function_cf9b62807022191f( scriptableid, scriptabledata, weapon )
{
    if ( !isdefined( weapon ) )
    {
        return;
    }
    
    state = [[ scriptabledata.var_9331280cb31a213d ]]( weapon );
    
    if ( self.var_ba0fee1a3d02f016[ #"mtx_scriptable_gunscreen_state" ] != state )
    {
        self.var_ba0fee1a3d02f016[ #"mtx_scriptable_gunscreen_state" ] = state;
        self setscriptablepartstate( #"mtxvfxgunscreen", state );
    }
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0x4325f39d, Offset: 0x7f58
// Size: 0x57
function private function_b4f609769b2429a3()
{
    if ( self.var_ba0fee1a3d02f016[ #"mtx_scriptable_gunscreen_state" ] != #"neutral" )
    {
        self.var_ba0fee1a3d02f016[ #"mtx_scriptable_gunscreen_state" ] = #"neutral";
        self setscriptablepartstate( #"mtxvfxgunscreen", #"neutral" );
    }
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0x6d2c1d0, Offset: 0x7fb7
// Size: 0x39, Type: bool
function private function_b8a09efab8d7c56e()
{
    if ( self.var_ba0fee1a3d02f016[ #"direct_scriptable_disablers" ].size > 0 || self.var_ba0fee1a3d02f016[ #"all_scriptable_disablers" ].size > 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace mtx_weapon
// Params 1
// Checksum 0x775bfa6c, Offset: 0x7ff9
// Size: 0x27
function function_6787f99cc8476ca8( sparams )
{
    self endon( #"death_or_disconnect" );
    function_6afbbbaa99e9b63a();
    waitframe();
    function_92a1d0ce843e431();
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0xe47b5aad, Offset: 0x8028
// Size: 0x9d
function private function_738493048a18f5e2()
{
    if ( !function_a5fbf10a4f77ef15() )
    {
        return;
    }
    
    if ( !self isscriptable() )
    {
        return;
    }
    
    foreach ( scriptableid, scriptabledata in level.var_cc75e39215a1ee5a )
    {
        if ( function_6303e7256453d06c( scriptableid, scriptabledata ) )
        {
            function_9d423d2b8105df4e( scriptableid, scriptabledata );
        }
    }
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x1d6708b9, Offset: 0x80cd
// Size: 0x4d
function private function_950d6b4e4595768f( scriptableid )
{
    if ( !self isscriptable() )
    {
        return;
    }
    
    if ( function_a5fbf10a4f77ef15() )
    {
        scriptabledata = level.var_cc75e39215a1ee5a[ scriptableid ];
        
        if ( function_6303e7256453d06c( scriptableid, scriptabledata ) )
        {
            function_9d423d2b8105df4e( scriptableid, scriptabledata );
        }
    }
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0x6cc5a692, Offset: 0x8122
// Size: 0x86
function private function_ae9a5d4b17c9a5b9()
{
    if ( !self isscriptable() )
    {
        return;
    }
    
    foreach ( scriptableid, scriptabledata in level.var_cc75e39215a1ee5a )
    {
        function_9d423d2b8105df4e( scriptableid, scriptabledata );
    }
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xc6533219, Offset: 0x81b0
// Size: 0x2b
function private function_7f93d222d34a5a12( scriptableid )
{
    if ( !self isscriptable() )
    {
        return;
    }
    
    function_9d423d2b8105df4e( scriptableid, level.var_cc75e39215a1ee5a[ scriptableid ] );
}

// Namespace mtx_weapon
// Params 2, eflags: 0x4
// Checksum 0xea6fbd94, Offset: 0x81e3
// Size: 0x8f
function private function_9d423d2b8105df4e( scriptableid, scriptabledata )
{
    state = [[ scriptabledata.var_9331280cb31a213d ]]();
    
    if ( !self getscriptableparthasstate( scriptableid, state ) )
    {
        /#
            if ( !getdvarint( @"hash_808d350f6f481a67", 0 ) )
            {
                println( "<dev string:x152>" + getxhashsourcename( state ) + "<dev string:x19f>" + getxhashsourcename( scriptableid ) );
            }
        #/
        
        return;
    }
    
    self setscriptablepartstate( scriptableid, state );
    self.var_ba0fee1a3d02f016[ #"mtx_scriptable_reactive_ids" ][ scriptableid ] = state;
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0xd952777d, Offset: 0x827a
// Size: 0xbd
function private function_de68beacbfc3a070()
{
    foreach ( scriptableid, scriptablestate in self.var_ba0fee1a3d02f016[ #"mtx_scriptable_reactive_ids" ] )
    {
        if ( scriptablestate != #"neutral" )
        {
            self setscriptablepartstate( scriptableid, #"neutral", 0 );
            self.var_ba0fee1a3d02f016[ #"mtx_scriptable_reactive_ids" ][ scriptableid ] = #"neutral";
        }
    }
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0xdab0e601, Offset: 0x833f
// Size: 0x1f, Type: bool
function private function_a5fbf10a4f77ef15()
{
    if ( self.var_ba0fee1a3d02f016[ #"all_scriptable_disablers" ].size > 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace mtx_weapon
// Params 2, eflags: 0x4
// Checksum 0x931a9180, Offset: 0x8367
// Size: 0x46, Type: bool
function private function_6303e7256453d06c( scriptableid, scriptabledata )
{
    state = [[ scriptabledata.var_9331280cb31a213d ]]();
    return state != self.var_ba0fee1a3d02f016[ #"mtx_scriptable_reactive_ids" ][ scriptableid ];
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xe862ebee, Offset: 0x83b6
// Size: 0x8a
function private function_c80dc1fc69011a01( scriptableid )
{
    if ( function_ba9b7808408d20c2( scriptableid ) )
    {
        state = self.var_ba0fee1a3d02f016[ #"mtx_scriptable_toggle_ids" ][ scriptableid ];
        
        if ( state == #"toggle0" )
        {
            newstate = #"toggle1";
        }
        else
        {
            newstate = #"toggle0";
        }
        
        self setscriptablepartstate( scriptableid, newstate );
        self.var_ba0fee1a3d02f016[ #"mtx_scriptable_toggle_ids" ][ scriptableid ] = newstate;
    }
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x52410d43, Offset: 0x8448
// Size: 0x54, Type: bool
function private function_ba9b7808408d20c2( scriptableid )
{
    if ( self.var_ba0fee1a3d02f016[ #"all_scriptable_disablers" ].size > 0 )
    {
        return false;
    }
    
    if ( !self getscriptableparthasstate( scriptableid, #"toggle0" ) || !self getscriptableparthasstate( scriptableid, #"toggle1" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace mtx_weapon
// Params 1
// Checksum 0x7b47c4c5, Offset: 0x84a5
// Size: 0x60, Type: bool
function function_533fe8b97a62433f( weapon )
{
    if ( !isdefined( weapon ) )
    {
        return false;
    }
    
    if ( !( isdefined( weapon.basename ) && isdefined( weapon.variantid ) ) )
    {
        return false;
    }
    
    if ( weapon.basename == "iw9_me_sword01_mp" && weapon.variantid == 2 )
    {
        return true;
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xff817973, Offset: 0x850e
// Size: 0x1b
function private function_13cb3d1273a49150( weapon )
{
    return weapon hasattachmenthash( %"cos_iw9_156" );
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x3c09ad40, Offset: 0x8532
// Size: 0x11
function private function_35770a658413caf2( weapon )
{
    return "flameSkullActive";
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xd4fbb194, Offset: 0x854c
// Size: 0x1b
function private function_a7f3d9242195ca49( weapon )
{
    return weapon hasattachmenthash( %"cos_iw9_445" );
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xa652c6d6, Offset: 0x8570
// Size: 0x1b
function private function_61becbc5fa1954b4( weapon )
{
    return weapon hasattachmenthash( %"cos_iw9_465" );
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xd2e15945, Offset: 0x8594
// Size: 0x1b
function private function_1d4b7a9f71cd1964( weapon )
{
    return weapon hasattachmenthash( %"cos_iw9_446" );
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x8201d659, Offset: 0x85b8
// Size: 0x1b
function private function_f90d9b5595a003b9( weapon )
{
    return weapon hasattachmenthash( %"cos_iw9_501" );
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x23a85cb2, Offset: 0x85dc
// Size: 0x1b
function private function_b1dd08e3d9d82da4( weapon )
{
    return weapon hasattachmenthash( %"cos_iw9_500" );
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xeb29991e, Offset: 0x8600
// Size: 0x1b
function private function_cb9177655cbbfa3c( weapon )
{
    return weapon hasattachmenthash( %"cos_iw9_526" );
}

// Namespace mtx_weapon
// Params 1
// Checksum 0x2effff00, Offset: 0x8624
// Size: 0x45, Type: bool
function isdoomchainsaw( weapon )
{
    if ( isdefined( weapon.receiver ) )
    {
        if ( weapon.receiver == "rec_pickaxe" && weapon.receivervarindex == 2 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 1
// Checksum 0xfb42a3d5, Offset: 0x8672
// Size: 0x57, Type: bool
function ischainsword( weapon )
{
    if ( isdefined( weapon.receiver ) )
    {
        if ( weapon.receiver == "jup_jp23_me_swhiskey_rec" && ( weapon.receivervarindex == 1 || weapon.receivervarindex == 4 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 1
// Checksum 0x9f15c4e8, Offset: 0x86d2
// Size: 0x45, Type: bool
function function_d7da8fc237e577f5( weapon )
{
    if ( isdefined( weapon.receiver ) )
    {
        if ( weapon.receiver == "jup_evictor_rec" && weapon.receivervarindex == 3 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 1
// Checksum 0x8793ded3, Offset: 0x8720
// Size: 0x4b, Type: bool
function function_ee1abbdbec1caece( weapon )
{
    if ( isdefined( weapon ) && isdefined( weapon.receiver ) )
    {
        if ( weapon.receiver == "jup_jp23_me_swhiskey_rec" && weapon.receivervarindex == 6 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xba5ac112, Offset: 0x8774
// Size: 0x11
function private function_9ffd745177cd8ddb( weapon )
{
    return "crystalSkullActive";
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xbddf87a8, Offset: 0x878e
// Size: 0x11
function private function_ae7741d6e4d1f456( weapon )
{
    return "starlightActive";
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xf2e40dc2, Offset: 0x87a8
// Size: 0x11
function private function_2908752ba245a596( weapon )
{
    return "soulEaterActive";
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x6ee6449a, Offset: 0x87c2
// Size: 0x11
function private function_fc7e6109eec28693( weapon )
{
    return "crowFootActive";
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x59f0cc63, Offset: 0x87dc
// Size: 0x11
function private function_da14b1fec376399e( weapon )
{
    return "pumpkinLanternActive";
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xe59e45c, Offset: 0x87f6
// Size: 0x11
function private function_a577c047e5231896( weapon )
{
    return "weedCreatureActive";
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xba88e07f, Offset: 0x8810
// Size: 0x11
function private function_b07e6c587f6fcb2f( weapon )
{
    return "doomChainsawActive";
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xeb2c7446, Offset: 0x882a
// Size: 0x11
function private function_a064aa18355f1b1c( weapon )
{
    return "ChainSwordActive";
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x7f935e1a, Offset: 0x8844
// Size: 0x11
function private function_60e04d6b4e5c151f( weapon )
{
    return "ToothFairyActive";
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x5defb60, Offset: 0x885e
// Size: 0x11
function private function_7970767ab0871d72( weapon )
{
    return "WontonSwhiskeyActive";
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0x70a3a451, Offset: 0x8878
// Size: 0x123
function private function_a6b273451bbcd568()
{
    stages = level.var_c7ae0663cc8de27c[ #"match_kill_thresholds_2stage" ];
    matchkills = self.var_ba0fee1a3d02f016[ #"match_kills" ];
    
    if ( matchkills < stages.stage1 )
    {
        state = #"neutral";
    }
    else if ( matchkills < stages.stage2 )
    {
        state = #"stage1";
    }
    else
    {
        state = #"stage2";
    }
    
    /#
        debugstates = getdvarint( @"hash_a0c0a5bf060c7bf2" );
        
        if ( debugstates >= 0 )
        {
            switch ( debugstates )
            {
                case 0:
                    state = #"neutral";
                    break;
                case 1:
                    state = #"stage1";
                    break;
                case 2:
                    state = #"stage2";
                    break;
                default:
                    assertmsg( "<dev string:x1ba>" );
                    break;
            }
        }
    #/
    
    return state;
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0x190c345c, Offset: 0x89a4
// Size: 0x15c
function private function_6f778baaa85eb67b()
{
    stages = level.var_c7ae0663cc8de27c[ #"match_kill_thresholds_3stage" ];
    matchkills = self.var_ba0fee1a3d02f016[ #"match_kills" ];
    
    if ( matchkills < stages.stage1 )
    {
        state = #"neutral";
    }
    else if ( matchkills < stages.stage2 )
    {
        state = #"stage1";
    }
    else if ( matchkills < stages.stage3 )
    {
        state = #"stage2";
    }
    else
    {
        state = #"stage3";
    }
    
    /#
        debugstates = getdvarint( @"hash_a0c0a5bf060c7bf2" );
        
        if ( debugstates >= 0 )
        {
            switch ( debugstates )
            {
                case 0:
                    state = #"neutral";
                    break;
                case 1:
                    state = #"stage1";
                    break;
                case 2:
                    state = #"stage2";
                    break;
                case 3:
                    state = #"stage3";
                    break;
                default:
                    assertmsg( "<dev string:x1ba>" );
                    break;
            }
        }
    #/
    
    return state;
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0xa7037823, Offset: 0x8b09
// Size: 0x123
function private function_8ae0d478f0823d1()
{
    stages = level.var_c7ae0663cc8de27c[ #"kill_streak_thresholds_2stage" ];
    kill_streak = self.var_ba0fee1a3d02f016[ #"kill_streak" ];
    
    if ( kill_streak < stages.stage1 )
    {
        state = #"neutral";
    }
    else if ( kill_streak < stages.stage2 )
    {
        state = #"stage1";
    }
    else
    {
        state = #"stage2";
    }
    
    /#
        debugstates = getdvarint( @"hash_e5d7c5b83ec14d85" );
        
        if ( debugstates >= 0 )
        {
            switch ( debugstates )
            {
                case 0:
                    state = #"neutral";
                    break;
                case 1:
                    state = #"stage1";
                    break;
                case 2:
                    state = #"stage2";
                    break;
                default:
                    assertmsg( "<dev string:x1ba>" );
                    break;
            }
        }
    #/
    
    return state;
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0x3e3f0036, Offset: 0x8c35
// Size: 0x15c
function private function_9afba82b040cd45e()
{
    stages = level.var_c7ae0663cc8de27c[ #"kill_streak_thresholds_3stage" ];
    kill_streak = self.var_ba0fee1a3d02f016[ #"kill_streak" ];
    
    if ( kill_streak < stages.stage1 )
    {
        state = #"neutral";
    }
    else if ( kill_streak < stages.stage2 )
    {
        state = #"stage1";
    }
    else if ( kill_streak < stages.stage3 )
    {
        state = #"stage2";
    }
    else
    {
        state = #"stage3";
    }
    
    /#
        debugstates = getdvarint( @"hash_cefbf3b030b375ab" );
        
        if ( debugstates >= 0 )
        {
            switch ( debugstates )
            {
                case 0:
                    state = #"neutral";
                    break;
                case 1:
                    state = #"stage1";
                    break;
                case 2:
                    state = #"stage2";
                    break;
                case 3:
                    state = #"stage3";
                    break;
                default:
                    assertmsg( "<dev string:x1de>" );
                    break;
            }
        }
    #/
    
    return state;
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0xeab9a8a1, Offset: 0x8d9a
// Size: 0x195
function private function_f45ffc37d49a35b3()
{
    stages = level.var_c7ae0663cc8de27c[ #"kill_streak_thresholds_4stage" ];
    kill_streak = self.var_ba0fee1a3d02f016[ #"kill_streak" ];
    
    if ( kill_streak < stages.stage1 )
    {
        state = #"neutral";
    }
    else if ( kill_streak < stages.stage2 )
    {
        state = #"stage1";
    }
    else if ( kill_streak < stages.stage3 )
    {
        state = #"stage2";
    }
    else if ( kill_streak < stages.stage4 )
    {
        state = #"stage3";
    }
    else
    {
        state = #"stage4";
    }
    
    /#
        debugstates = getdvarint( @"hash_eac0e1ad1567fd42" );
        
        if ( debugstates >= 0 )
        {
            switch ( debugstates )
            {
                case 0:
                    state = #"neutral";
                    break;
                case 1:
                    state = #"stage1";
                    break;
                case 2:
                    state = #"stage2";
                    break;
                case 3:
                    state = #"stage3";
                    break;
                case 4:
                    state = #"stage4";
                    break;
                default:
                    assertmsg( "<dev string:x205>" );
                    break;
            }
        }
    #/
    
    return state;
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0xe059356e, Offset: 0x8f38
// Size: 0x11d
function private function_4117c7b8928e6f1d()
{
    state = #"neutral";
    weaponkillstreak = getkillstreakweapon( self.currentweapon );
    
    if ( weaponkillstreak >= 3 )
    {
        state = #"stage3";
    }
    else if ( weaponkillstreak >= 2 )
    {
        state = #"stage2";
    }
    else if ( weaponkillstreak >= 1 )
    {
        state = #"stage1";
    }
    
    /#
        debugstates = getdvarint( @"hash_6b3c6361f0f5fdb" );
        
        if ( debugstates >= 0 )
        {
            switch ( debugstates )
            {
                case 0:
                    state = #"neutral";
                    break;
                case 1:
                    state = #"stage1";
                    break;
                case 2:
                    state = #"stage2";
                    break;
                case 3:
                    state = #"stage3";
                    break;
                default:
                    assertmsg( "<dev string:x1de>" );
                    break;
            }
        }
    #/
    
    return state;
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0x9d3a1d3, Offset: 0x905e
// Size: 0x158
function private function_641c450677a230f2()
{
    state = #"neutral";
    
    if ( self.var_ba0fee1a3d02f016[ #"match_kills" ] == 0 || self.var_ba0fee1a3d02f016[ #"match_kills" ] % 3 == 1 )
    {
        state = #"stage1";
    }
    else if ( self.var_ba0fee1a3d02f016[ #"match_kills" ] % 3 == 2 )
    {
        state = #"stage2";
    }
    else if ( self.var_ba0fee1a3d02f016[ #"match_kills" ] % 3 == 0 )
    {
        state = #"stage3";
    }
    
    /#
        debugstates = getdvarint( @"hash_51dcebb527f3dd9b" );
        
        if ( debugstates >= 0 )
        {
            switch ( debugstates )
            {
                case 0:
                    state = #"neutral";
                    break;
                case 1:
                    state = #"stage1";
                    break;
                case 2:
                    state = #"stage2";
                    break;
                case 3:
                    state = #"stage3";
                    break;
                default:
                    assertmsg( "<dev string:x1de>" );
                    break;
            }
        }
    #/
    
    return state;
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0x661f296c, Offset: 0x91bf
// Size: 0xab
function private function_70dbe327367e762()
{
    if ( self.var_358acd34f3552d6a )
    {
        state = #"stage1";
    }
    else
    {
        state = #"neutral";
    }
    
    /#
        debugstates = getdvarint( @"hash_399fdd0fb6b02227" );
        
        if ( debugstates >= 0 )
        {
            switch ( debugstates )
            {
                case 0:
                    state = #"neutral";
                    break;
                case 1:
                    state = #"stage1";
                    break;
                default:
                    assertmsg( "<dev string:x22f>" );
                    break;
            }
        }
    #/
    
    return state;
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0x565ff906, Offset: 0x9273
// Size: 0x6e
function private function_553796ca442c42b9()
{
    self endon( #"death_or_disconnect" );
    
    if ( !( isdefined( game[ "flags" ] ) && game[ "flags" ][ "prematch_done" ] ) )
    {
        level waittill( #"prematch_done" );
    }
    
    self.var_358acd34f3552d6a = 0;
    function_950d6b4e4595768f( #"reactive_spawn" );
    waitframe();
    self.var_358acd34f3552d6a = 1;
    function_950d6b4e4595768f( #"reactive_spawn" );
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0x58eb13, Offset: 0x92e9
// Size: 0x11
function private function_e26db89a9b95d302()
{
    return function_52784db085f31ad7( #"reactive_downgradable_kill_streak_3stage" );
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x1c04bef2, Offset: 0x9303
// Size: 0x2f7
function private function_52784db085f31ad7( part )
{
    stages = level.var_c7ae0663cc8de27c[ #"downgradable_kill_streak_thresholds_3stage" ];
    
    if ( !isdefined( stages ) )
    {
        return #"neutral";
    }
    
    stage1killthreshold = stages.stage1;
    stage2killthreshold = stages.stage2;
    stage3killthreshold = stages.stage3;
    
    /#
        if ( false )
        {
            var_a30aab00db323c63 = getdvarint( @"hash_19443de5a3697190", -1 );
            var_37e93169943f7a80 = getdvarint( @"hash_7b707b9e08a2a8fd", -1 );
            var_e4051d3c50675b5 = getdvarint( @"hash_e225d9e8775ceae", -1 );
            
            if ( var_a30aab00db323c63 >= 0 )
            {
                stage1killthreshold = var_a30aab00db323c63;
            }
            
            if ( var_37e93169943f7a80 >= 0 )
            {
                stage2killthreshold = var_37e93169943f7a80;
            }
            
            if ( var_e4051d3c50675b5 >= 0 )
            {
                stage3killthreshold = var_e4051d3c50675b5;
            }
        }
    #/
    
    curstate = self isscriptable() && self getscriptablehaspart( part ) ? self getscriptablepartstate( part, 0, 1 ) : #"hash_17e2f9deb4e986ba";
    state = undefined;
    
    if ( self.var_ba0fee1a3d02f016[ #"downgradable_kill_streak" ] >= stage3killthreshold )
    {
        state = #"stage3";
    }
    else if ( self.var_ba0fee1a3d02f016[ #"downgradable_kill_streak" ] >= stage2killthreshold )
    {
        switch ( curstate )
        {
            case #"stage3":
            case #"stage2_dec":
                state = #"stage2_dec";
                break;
            default:
                state = #"stage2";
                break;
        }
    }
    else if ( self.var_ba0fee1a3d02f016[ #"downgradable_kill_streak" ] >= stage1killthreshold )
    {
        switch ( curstate )
        {
            case #"stage1_dec":
            case #"stage3":
            case #"stage2":
            case #"stage2_dec":
                state = #"stage1_dec";
                break;
            default:
                state = #"stage1";
                break;
        }
    }
    else
    {
        state = #"neutral";
    }
    
    /#
        debugstates = getdvarint( @"hash_e001a97b368816c9" );
        
        if ( debugstates >= 0 )
        {
            switch ( debugstates )
            {
                case 0:
                    state = #"neutral";
                    break;
                case 1:
                    state = #"stage1";
                    break;
                case 2:
                    state = #"stage2";
                    break;
                case 3:
                    state = #"stage3";
                    break;
                default:
                    assertmsg( "<dev string:x1de>" );
                    break;
            }
        }
    #/
    
    thread mtx_monitorReactiveKillstreak3StageDecay();
    return state;
}

// Namespace mtx_weapon
// Params 0, eflags: 0xc
// Checksum 0x9d501ce3, Offset: 0x9603
// Size: 0xca
function private mtx_monitorReactiveKillstreak3StageDecay()
{
    self notify( #"hash_d128c3fdc94fdd83" );
    self endon( #"hash_d128c3fdc94fdd83" );
    self endon( #"death_or_disconnect" );
    wait 0.1;
    decaytime = getdvarfloat( @"hash_17bc5fdc392ba0b3", 20000 ) / 1000;
    
    while ( true )
    {
        wait decaytime;
        
        /#
            debugstates = getdvarint( @"hash_e001a97b368816c9" );
            
            if ( debugstates >= 0 )
            {
                return;
            }
        #/
        
        self.var_ba0fee1a3d02f016[ #"downgradable_kill_streak" ]--;
        
        if ( self.var_ba0fee1a3d02f016[ #"downgradable_kill_streak" ] < 0 )
        {
            self.var_ba0fee1a3d02f016[ #"downgradable_kill_streak" ] = 0;
        }
        
        thread function_950d6b4e4595768f( #"reactive_downgradable_kill_streak_3stage" );
    }
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0x69b3b395, Offset: 0x96d5
// Size: 0xd2
function private function_e04dc23a6cbb586b()
{
    stage1killthreshold = level.var_c7ae0663cc8de27c[ #"kill_streak_thresholds_souleater" ];
    state = #"neutral";
    
    if ( self.var_ba0fee1a3d02f016[ #"souls_collected_count" ] >= stage1killthreshold )
    {
        state = #"stage1";
    }
    
    /#
        debugstates = getdvarint( @"hash_cf86c6012f506ac8" );
        
        if ( debugstates >= 0 )
        {
            switch ( debugstates )
            {
                case 0:
                    state = #"neutral";
                    break;
                case 1:
                    state = #"stage1";
                    break;
                default:
                    assertmsg( "<dev string:x246>" );
                    break;
            }
        }
    #/
    
    return state;
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0xf7225361, Offset: 0x97b0
// Size: 0x90
function private function_33348af539a29bac()
{
    /#
        debugstates = getdvarint( @"hash_beff73861be066d" );
        
        if ( debugstates >= 0 )
        {
            switch ( debugstates )
            {
                case 0:
                    return #"neutral";
                case 1:
                    return #"stage1";
                default:
                    assertmsg( "<dev string:x267>" + debugstates + "<dev string:x284>" );
                    break;
            }
        }
    #/
    
    return self.var_ba0fee1a3d02f016[ #"movement_state" ];
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0xc25f480f, Offset: 0x9849
// Size: 0x15
function private function_8b51453f4c4e7bae()
{
    return self.var_ba0fee1a3d02f016[ #"equipment_lethal_pullout" ];
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xec82669e, Offset: 0x9867
// Size: 0x27
function private getweaponname( weapon )
{
    if ( isdefined( weapon ) )
    {
        return weapon.basename;
    }
    
    return "NONE";
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0xc2065efb, Offset: 0x9896
// Size: 0xd5
function private function_dbafa6997df9da98()
{
    /#
        debugstates = getdvarint( @"hash_8d73f9a1e40b4f01" );
        
        if ( debugstates >= 0 )
        {
            switch ( debugstates )
            {
                case 0:
                    return #"neutral";
                case 1:
                    return #"stage1";
                default:
                    assertmsg( "<dev string:x2b5>" + debugstates + "<dev string:x284>" );
                    break;
            }
        }
    #/
    
    weaponname = getweaponname( self.currentweapon );
    weaponstate = self.var_ba0fee1a3d02f016[ #"enchanted_weapons" ][ weaponname ];
    
    if ( weaponstate == 1 )
    {
        return #"stage1";
    }
    
    return #"neutral";
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0xee9052d6, Offset: 0x9973
// Size: 0x7c, Type: bool
function private isiooperator()
{
    if ( isdefined( self.operatorcustomization ) && isdefined( self.operatorcustomization.skinref ) )
    {
        if ( isxhashasset( self.operatorcustomization.skinref ) )
        {
            return ( self.operatorcustomization.skinref == %"io_western_a" );
        }
        else
        {
            return ( self.operatorcustomization.skinref == "io_western_a" );
        }
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0x3c72c302, Offset: 0x99f8
// Size: 0x7c, Type: bool
function private isfalloperator()
{
    if ( isdefined( self.operatorcustomization ) && isdefined( self.operatorcustomization.skinref ) )
    {
        if ( isxhashasset( self.operatorcustomization.skinref ) )
        {
            return ( self.operatorcustomization.skinref == %"jup_mp_fall_skin" );
        }
        else
        {
            return ( self.operatorcustomization.skinref == "jup_mp_fall_skin" );
        }
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0x8ba31c1b, Offset: 0x9a7d
// Size: 0x7c, Type: bool
function private function_8d1f7fa9c4589345()
{
    if ( isdefined( self.operatorcustomization ) && isdefined( self.operatorcustomization.skinref ) )
    {
        if ( isxhashasset( self.operatorcustomization.skinref ) )
        {
            return ( self.operatorcustomization.skinref == %"t10_gbr_pl_ratcliff_vertigo_skin" );
        }
        else
        {
            return ( self.operatorcustomization.skinref == "t10_gbr_pl_ratcliff_vertigo_skin" );
        }
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0x6cd2db3a, Offset: 0x9b02
// Size: 0x23, Type: bool
function private ismovementoperator()
{
    if ( isiooperator() || isfalloperator() || function_8d1f7fa9c4589345() )
    {
        return true;
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xa66ed504, Offset: 0x9b2e
// Size: 0xbb, Type: bool
function private ismovementweapon( weapon )
{
    if ( isdefined( weapon ) && weapon.basename == "iw9_sm_aviktor_mp" )
    {
        return ( isdefined( weapon.variantid ) && weapon.variantid == 25 );
    }
    
    if ( isdefined( weapon ) && weapon.basename == "jup_jp25_sm_talpham_mp" )
    {
        return ( isdefined( weapon.variantid ) && weapon.variantid == 19 );
    }
    
    if ( isdefined( weapon ) && weapon.basename == "jup_jp36_sn_boscar_mp" )
    {
        return ( isdefined( weapon.variantid ) && weapon.variantid == 13 );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0xfcd3f937, Offset: 0x9bf2
// Size: 0x2e
function private function_8d9bee5f6d9e92d()
{
    if ( function_e18b3f68f5fae84f( self.currentweapon ) )
    {
        thread function_ec1d5697d6508d9c( self.currentweapon );
        return;
    }
    
    function_553856f27429d1f4();
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x53770638, Offset: 0x9c28
// Size: 0x6e, Type: bool
function private function_e18b3f68f5fae84f( weapon )
{
    /#
        bypass = getdvarint( @"hash_d5bfe694a8598141" );
        
        if ( bypass == 1 )
        {
            return true;
        }
    #/
    
    if ( isdefined( weapon ) && weapon.basename == "iw9_sn_india_mp" )
    {
        return ( isdefined( weapon.variantid ) && weapon.variantid == 14 );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x627f485c, Offset: 0x9c9f
// Size: 0xb1
function private function_ec1d5697d6508d9c( weapon )
{
    self notify( #"inspect_update_thread" );
    self endon( #"death_or_disconnect" );
    self endon( #"inspect_update_thread" );
    
    if ( !isdefined( self.var_ba0fee1a3d02f016[ #"inspect_thread" ] ) )
    {
        self.var_ba0fee1a3d02f016[ #"inspect_thread" ] = 1;
    }
    
    weaponname = weapon.basename;
    function_950d6b4e4595768f( #"reactive_enchantment" );
    
    while ( true )
    {
        self waittill( #"weapon_inspect" );
        function_9fa628511830eeac( weaponname );
        function_950d6b4e4595768f( #"reactive_enchantment" );
    }
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x145a819b, Offset: 0x9d58
// Size: 0x8c
function private function_60786a2af27d8b2c( state )
{
    if ( !function_e18b3f68f5fae84f( self.currentweapon ) || !isdefined( self.var_ba0fee1a3d02f016[ #"enchanted_weapons" ] ) )
    {
        return;
    }
    
    if ( state != 0 && state != 1 )
    {
        assertmsg( "<dev string:x2d5>" + state + "<dev string:x2f0>" );
    }
    
    self.var_ba0fee1a3d02f016[ #"enchanted_weapons" ][ getweaponname( self.currentweapon ) ] = state;
    function_a4685f262bf40708();
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x5d8422a6, Offset: 0x9dec
// Size: 0x41
function private function_9fa628511830eeac( weaponname )
{
    currentstate = function_dbafa6997df9da98();
    
    if ( currentstate == #"neutral" )
    {
        function_60786a2af27d8b2c( 1 );
        return;
    }
    
    function_60786a2af27d8b2c( 0 );
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0xa70adc97, Offset: 0x9e35
// Size: 0x37
function private function_553856f27429d1f4()
{
    if ( self.var_ba0fee1a3d02f016[ #"inspect_thread" ] )
    {
        self.var_ba0fee1a3d02f016[ #"inspect_thread" ] = undefined;
        self notify( #"inspect_update_thread" );
    }
}

// Namespace mtx_weapon
// Params 0, eflags: 0xc
// Checksum 0x330aed84, Offset: 0x9e74
// Size: 0x42
function private function_84676d67b776e68()
{
    self notify( #"hash_e34cc23168df4470" );
    self endon( #"hash_e34cc23168df4470" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"weapon_inspect" );
        function_48d94768dd9be408();
    }
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0x6fe10375, Offset: 0x9ebe
// Size: 0x58
function private function_48d94768dd9be408()
{
    weapon = self getcurrentweapon();
    
    if ( isdefined( level.var_79987b283d0c90da ) )
    {
        var_f5db50aedd501d15 = level.var_79987b283d0c90da[ weapon.receiverblueprint.attachmentdata ];
        
        if ( isdefined( var_f5db50aedd501d15 ) )
        {
            self thread [[ var_f5db50aedd501d15 ]]( weapon );
            return;
        }
    }
}

// Namespace mtx_weapon
// Params 2, eflags: 0x4
// Checksum 0xf5a7d428, Offset: 0x9f1e
// Size: 0x5d
function private function_b2e1577149099c4f( weapon, victim )
{
    if ( isdefined( level.var_fc084540b89df8e7 ) )
    {
        var_f5db50aedd501d15 = level.var_fc084540b89df8e7[ weapon.receiverblueprint.attachmentdata ];
        
        if ( isdefined( var_f5db50aedd501d15 ) )
        {
            self thread [[ var_f5db50aedd501d15 ]]( weapon, victim );
            return;
        }
    }
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0xa08b5d13, Offset: 0x9f83
// Size: 0x56
function private function_e57259d5b8ae715b()
{
    weapon = self getcurrentweapon();
    
    if ( isdefined( level.var_2b2c2b4699268bb ) )
    {
        var_f5db50aedd501d15 = level.var_2b2c2b4699268bb[ weapon.receiverblueprint.attachmentdata ];
        
        if ( isdefined( var_f5db50aedd501d15 ) )
        {
            self thread [[ var_f5db50aedd501d15 ]]();
            return;
        }
    }
}

// Namespace mtx_weapon
// Params 0, eflags: 0xc
// Checksum 0x3b95a2f5, Offset: 0x9fe1
// Size: 0xae
function private function_c023dc8adec67cf8()
{
    self notify( #"hash_d49f04f52d64b9bd" );
    self endon( #"hash_d49f04f52d64b9bd" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"grenade_pullback" );
        self.var_ba0fee1a3d02f016[ #"equipment_lethal_pullout" ] = "on";
        function_950d6b4e4595768f( #"reactive_equipment_lethal_pullout" );
        var_124efe5d2009b7f7 = 30000;
        utility::waittill_any_timeout( var_124efe5d2009b7f7, "offhand_end" );
        self.var_ba0fee1a3d02f016[ #"equipment_lethal_pullout" ] = #"neutral";
        function_950d6b4e4595768f( #"reactive_equipment_lethal_pullout" );
    }
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0xcc8151a9, Offset: 0xa097
// Size: 0x2f
function private function_7b3cddcf6bfa5b4b()
{
    if ( ismovementoperator() || ismovementweapon( self.currentweapon ) )
    {
        thread function_71237f69b09806c7();
        return;
    }
    
    function_30baeaaaef09d18();
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0xc2527c05, Offset: 0xa0ce
// Size: 0x13f
function private function_71237f69b09806c7()
{
    self notify( #"movement_update_thread" );
    self endon( #"death_or_disconnect" );
    self endon( #"movement_update_thread" );
    currentstate = self.var_ba0fee1a3d02f016[ #"movement_state" ];
    var_75af1e9cd8ca46c1 = 0;
    isfalloperator = isfalloperator();
    
    while ( true )
    {
        movement = self getnormalizedmovement();
        movement = abs( movement[ 0 ] ) + abs( movement[ 1 ] );
        var_75af1e9cd8ca46c1 = movement > 0.7 && !self playerads() > 0 && ( self getstance() == "stand" || isfalloperator );
        
        if ( self issprinting() || !self isonground() || self isdiving() || self issprintsliding() || var_75af1e9cd8ca46c1 || isfalloperator && self isshooting() )
        {
            targetstate = #"neutral";
            delaytime = 0;
        }
        else
        {
            targetstate = #"stage1";
            delaytime = 0;
        }
        
        if ( currentstate != targetstate )
        {
            childthread function_235c0aca8885c616( targetstate, delaytime );
            currentstate = targetstate;
        }
        
        wait 0.1;
    }
}

// Namespace mtx_weapon
// Params 2, eflags: 0x4
// Checksum 0x4d987f92, Offset: 0xa215
// Size: 0x56
function private function_235c0aca8885c616( state, delaytime )
{
    self notify( #"hash_d92895704be242d9" );
    self endon( #"hash_d92895704be242d9" );
    wait delaytime;
    self.var_ba0fee1a3d02f016[ #"movement_state" ] = state;
    function_950d6b4e4595768f( #"reactive_movement" );
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0xcf4d1e01, Offset: 0xa273
// Size: 0xe
function private function_30baeaaaef09d18()
{
    self notify( #"movement_update_thread" );
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0x971346b8, Offset: 0xa289
// Size: 0x110
function private function_b7ae5a371a7345dd()
{
    self notify( #"updating_reactive_kills" );
    self endon( #"death_or_disconnect" );
    self endon( #"updating_reactive_kills" );
    
    if ( !self getscriptablehaspart( #"reactive_kill" ) )
    {
        println( "<dev string:x310>" );
        return;
    }
    
    while ( true )
    {
        time = gettime();
        timesincelastkill = time - self.var_ba0fee1a3d02f016[ #"last_reactive_kill_time" ];
        
        if ( timesincelastkill >= 600 )
        {
            if ( self.var_ba0fee1a3d02f016[ #"match_kills" ] > self.var_ba0fee1a3d02f016[ #"reactive_kills" ] )
            {
                function_c80dc1fc69011a01( #"reactive_kill" );
                self.var_ba0fee1a3d02f016[ #"last_reactive_kill_time" ] = time;
                self.var_ba0fee1a3d02f016[ #"reactive_kills" ]++;
            }
            else
            {
                return;
            }
            
            waittime = 0.6;
        }
        else
        {
            waittime = ( 600 - timesincelastkill ) / 1000;
        }
        
        wait waittime;
    }
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x31b47fb9, Offset: 0xa3a1
// Size: 0xd, Type: bool
function private function_fe3c735752e99d6f( weapon )
{
    return false;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xdce1723a, Offset: 0xa3b7
// Size: 0x2a
function private function_1354def060a303cb( weapon )
{
    if ( function_25586e89a1ffe18b( weapon ) )
    {
        thread function_d50e9d52c585daa8( weapon );
        return;
    }
    
    function_5ca7f3db7a6b1830();
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xfde2aa75, Offset: 0xa3e9
// Size: 0x133
function private function_d50e9d52c585daa8( weapon )
{
    self notify( #"doom_gunscreen_thread" );
    self endon( #"death_or_disconnect" );
    self endon( #"doom_gunscreen_thread" );
    self endon( #"weapon_change" );
    
    if ( !isdefined( self.var_ba0fee1a3d02f016[ #"gunscreen_doom_hide" ] ) )
    {
        self.var_ba0fee1a3d02f016[ #"gunscreen_doom_hide" ] = 0;
    }
    
    if ( !isdefined( self.var_ba0fee1a3d02f016[ #"gunscreen_doom_active" ] ) )
    {
        self.var_ba0fee1a3d02f016[ #"gunscreen_doom_active" ] = 1;
    }
    
    while ( true )
    {
        if ( self issprinting() || self isswimsprinting() || self issprintsliding() || self isdiving() )
        {
            if ( !self.var_ba0fee1a3d02f016[ #"gunscreen_doom_hide" ] )
            {
                self.var_ba0fee1a3d02f016[ #"gunscreen_doom_hide" ] = 1;
                self setclientomnvar( "ui_doomscreen_hide", 1 );
            }
        }
        else if ( self.var_ba0fee1a3d02f016[ #"gunscreen_doom_hide" ] )
        {
            self.var_ba0fee1a3d02f016[ #"gunscreen_doom_hide" ] = 0;
            self setclientomnvar( "ui_doomscreen_hide", 0 );
        }
        
        waitframe();
    }
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0x7b3e906c, Offset: 0xa524
// Size: 0x56
function private function_5ca7f3db7a6b1830()
{
    if ( self.var_ba0fee1a3d02f016[ #"gunscreen_doom_active" ] )
    {
        self notify( #"doom_gunscreen_thread" );
        self.var_ba0fee1a3d02f016[ #"gunscreen_doom_hide" ] = undefined;
        self.var_ba0fee1a3d02f016[ #"gunscreen_doom_active" ] = undefined;
        self setclientomnvar( "ui_doomscreen_hide", 0 );
    }
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x80f336eb, Offset: 0xa582
// Size: 0x1e, Type: bool
function private function_58e17385a1fd1a9( objweapon )
{
    if ( objweapon hasattachment( "cos_iw9_screen_029" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x57897d87, Offset: 0xa5a9
// Size: 0x1e, Type: bool
function private function_25586e89a1ffe18b( objweapon )
{
    if ( objweapon hasattachment( "cos_iw9_screen_028" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x8050d516, Offset: 0xa5d0
// Size: 0x20
function private function_a047cf54a0568a91( weapon )
{
    if ( function_260ff05be50eca62( weapon ) )
    {
        function_6379d706b1b60bbd( weapon );
    }
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xe082a25e, Offset: 0xa5f8
// Size: 0x5c, Type: bool
function private function_d84cf7c6ffe66d22( weapon )
{
    if ( !isdefined( weapon ) )
    {
        return false;
    }
    
    if ( function_54d173136e22312f( weapon ) )
    {
        return true;
    }
    
    if ( function_30458c24279ff1cd( weapon ) )
    {
        return true;
    }
    
    if ( function_183e608ffd1e6ff1( weapon ) )
    {
        return true;
    }
    
    if ( function_d8fb3404421d3edf( weapon ) )
    {
        return true;
    }
    
    if ( function_712535c22d72da5( weapon ) )
    {
        return true;
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x865b222d, Offset: 0xa65d
// Size: 0x34, Type: bool
function private function_842cd4b1a8fbf411( weapon )
{
    /#
        bypass = getdvarint( @"hash_d5b99091b7c0443e" );
        
        if ( bypass == 1 )
        {
            return true;
        }
    #/
    
    return false;
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0x3a24e178, Offset: 0xa69a
// Size: 0x38
function private function_98452d5852f8dbcb()
{
    self setclientomnvar( "ui_reticle_mtx_action2", self.var_ba0fee1a3d02f016[ #"match_kills" ] );
    self.var_ba0fee1a3d02f016[ #"last_reticle_kill_time" ] = gettime();
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0x6c1b8e5, Offset: 0xa6da
// Size: 0x20
function private function_9b97bd8af57bf2a1()
{
    self setclientomnvar( "ui_reticle_mtx_action2", self.var_ba0fee1a3d02f016[ #"souls_collected_count" ] );
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0x7cb05cea, Offset: 0xa702
// Size: 0x30
function private function_a4685f262bf40708()
{
    self setclientomnvar( "ui_reticle_mtx_inspect", self.var_ba0fee1a3d02f016[ #"enchanted_weapons" ][ getweaponname( self.currentweapon ) ] );
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0xbb0a25a, Offset: 0xa73a
// Size: 0x20
function private function_762c9b4c30c3d84d()
{
    self setclientomnvar( "ui_reticle_mtx_focus", self.var_ba0fee1a3d02f016[ #"mtx_focus" ] );
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x39defaba, Offset: 0xa762
// Size: 0x67
function private function_6379d706b1b60bbd( weapon )
{
    function_745383dc254e8178( #"hearts_broken", 0 );
    function_745383dc254e8178( #"hearts_broken_incrementing", 0 );
    
    if ( function_f8a2a5fae80feee0( weapon ) )
    {
        self setclientomnvar( "ui_reticle_mtx_action2", self.var_ba0fee1a3d02f016[ #"hearts_broken" ] );
        return;
    }
    
    self setclientomnvar( "ui_reticle_mtx_action2", -1 );
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0xea2fa38, Offset: 0xa7d1
// Size: 0xb8
function private function_ba2c8132201152f6()
{
    self endon( #"death_or_disconnect" );
    self.var_ba0fee1a3d02f016[ #"hearts_broken" ]++;
    
    if ( self.var_ba0fee1a3d02f016[ #"hearts_broken_incrementing" ] )
    {
        return;
    }
    
    self.var_ba0fee1a3d02f016[ #"hearts_broken_incrementing" ] = 1;
    wait 0.1;
    
    while ( true )
    {
        currentcount = self getclientomnvar( "ui_reticle_mtx_action2" );
        
        if ( currentcount >= self.var_ba0fee1a3d02f016[ #"hearts_broken" ] )
        {
            self.var_ba0fee1a3d02f016[ #"hearts_broken_incrementing" ] = 0;
            return;
        }
        
        self setclientomnvar( "ui_reticle_mtx_action2", currentcount + 1 );
        wait 0.57;
    }
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0xaee9d61d, Offset: 0xa891
// Size: 0x43
function private function_6ce55e7812f9db35()
{
    if ( isdefined( self.var_ba0fee1a3d02f016[ #"hearts_broken" ] ) )
    {
        self.var_ba0fee1a3d02f016[ #"hearts_broken" ] = 0;
        self.var_ba0fee1a3d02f016[ #"hearts_broken_incrementing" ] = 0;
    }
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x46fd343f, Offset: 0xa8dc
// Size: 0x2f, Type: bool
function private function_260ff05be50eca62( weapon )
{
    return weapon.scope == "hybrid03" && weapon.scopevarindex == 4;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xdfa25cac, Offset: 0xa914
// Size: 0x2f, Type: bool
function private function_54d173136e22312f( weapon )
{
    return weapon.scope == "reflex02_tall" && weapon.scopevarindex == 27;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xe88fa603, Offset: 0xa94c
// Size: 0x8d, Type: bool
function private function_30458c24279ff1cd( weapon )
{
    if ( isdefined( weapon.scope ) )
    {
        if ( gettime() - self.var_ba0fee1a3d02f016[ #"last_reticle_kill_time" ] > 1770 )
        {
            if ( weapon.scope == "reflex07_tall" && weapon.scopevarindex == 18 )
            {
                return true;
            }
            
            if ( weapon.scope == "fourx02" && weapon.scopevarindex == 11 )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xc33d77b2, Offset: 0xa9e2
// Size: 0x2f, Type: bool
function private function_183e608ffd1e6ff1( weapon )
{
    return weapon.scope == "reflex02_tall" && weapon.scopevarindex == 31;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xf2c7c1a9, Offset: 0xaa1a
// Size: 0x4f
function private function_d8fb3404421d3edf( weapon )
{
    if ( gettime() - self.var_ba0fee1a3d02f016[ #"last_reticle_kill_time" ] > 1000 )
    {
        return ( weapon.scope == "vzscope_mromeo" && weapon.scopevarindex == 2 );
    }
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x91749f29, Offset: 0xaa71
// Size: 0x2f, Type: bool
function private function_712535c22d72da5( weapon )
{
    return weapon.scope == "reflex02_tall" && weapon.scopevarindex == 44;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x722d9c1e, Offset: 0xaaa9
// Size: 0x2f, Type: bool
function private function_cffba97fa52b9199( weapon )
{
    return weapon.scope == "bar_ar_longhvy_scope_p52" && weapon.scopevarindex == 1;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x3ab512cf, Offset: 0xaae1
// Size: 0x2f, Type: bool
function private function_a4fac5e935e0141e( weapon )
{
    return weapon.scope == "fourx04" && weapon.scopevarindex == 13;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xad184fac, Offset: 0xab19
// Size: 0xd, Type: bool
function private function_30b97aca831f453f( weapon )
{
    return false;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xe972e4ac, Offset: 0xab2f
// Size: 0x6e, Type: bool
function private function_db7e85ae063ff29( weapon )
{
    if ( isdefined( weapon.scope ) )
    {
        if ( weapon.scope == "holotherm" && weapon.scopevarindex == 22 )
        {
            return true;
        }
        
        if ( weapon.scope == "fourxtherm01" && weapon.scopevarindex == 2 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xf5cb5af7, Offset: 0xaba6
// Size: 0x2f, Type: bool
function private function_f8a2a5fae80feee0( weapon )
{
    return weapon.modifier == "ammo_9s" && weapon.modifiervarindex == 2;
}

// Namespace mtx_weapon
// Params 2, eflags: 0x4
// Checksum 0xd6466daa, Offset: 0xabde
// Size: 0x3c, Type: bool
function private function_ebff581d2980bfd0( weapon, meansofdeath )
{
    return function_260ff05be50eca62( weapon ) && function_f8a2a5fae80feee0( weapon ) && isdefined( meansofdeath ) && meansofdeath != "MOD_MELEE";
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x2636d75c, Offset: 0xac23
// Size: 0x2d, Type: bool
function private function_c6229012d9ae2e31( objweapon )
{
    return isdefined( objweapon.basename ) && objweapon.basename == "chopper_gunner_turret_ufo_lg_mp";
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xa31f420, Offset: 0xac59
// Size: 0x2d, Type: bool
function private function_afd4ef408179cc( objweapon )
{
    return isdefined( objweapon.basename ) && objweapon.basename == "chopper_gunner_turret_ufo_mp";
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xdd3d5553, Offset: 0xac8f
// Size: 0xd3, Type: bool
function private function_2b23a8d93167aaaa( objweapon )
{
    if ( isdefined( objweapon.basename ) && ( objweapon.basename == "super_laser_charge_mp" || objweapon.basename == "high_jump_mp" ) )
    {
        return true;
    }
    
    if ( isdefined( objweapon.modifier ) )
    {
        if ( objweapon.modifier == "ammo_556n" && objweapon.modifiervarindex == 22 )
        {
            return true;
        }
        
        if ( objweapon.modifier == "ammo_556n_p43" && objweapon.modifiervarindex == 24 )
        {
            return true;
        }
        
        if ( objweapon.modifier == "ammo_5x28" && objweapon.modifiervarindex == 3 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xcc88791d, Offset: 0xad6b
// Size: 0x1e, Type: bool
function private function_729828fcac8d474( objweapon )
{
    return isdefined( objweapon ) && objweapon hasattachment( "jup_ub_saw_01" );
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xf407c096, Offset: 0xad92
// Size: 0x68, Type: bool
function private function_841b8126b9ad7ec( objweapon )
{
    if ( !( isdefined( objweapon ) && isdefined( objweapon.basename ) && isdefined( objweapon.variantid ) ) )
    {
        return false;
    }
    
    return objweapon.basename == "jup_jp23_me_swhiskey_mp" && ( objweapon.variantid == 1 || objweapon.variantid == 2 );
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x351f9fd6, Offset: 0xae03
// Size: 0x5a, Type: bool
function private function_e201db4a8295f73b( objweapon )
{
    if ( !isdefined( objweapon ) || !isdefined( objweapon.basename ) || !isdefined( objweapon.variantid ) )
    {
        return false;
    }
    
    return objweapon.basename == "jup_jp23_me_spear_mp" && objweapon.variantid == 4;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xd054b6b, Offset: 0xae66
// Size: 0x56, Type: bool
function private function_8e7d6ecb4e9e5e08( objweapon )
{
    if ( !( isdefined( objweapon ) && isdefined( objweapon.basename ) && isdefined( objweapon.variantid ) ) )
    {
        return false;
    }
    
    return objweapon.basename == "jup_jp23_me_swhiskey_mp" && objweapon.variantid == 6;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x2ecc9350, Offset: 0xaec5
// Size: 0x56, Type: bool
function private function_4f86fb39c48e9806( objweapon )
{
    if ( !( isdefined( objweapon ) && isdefined( objweapon.basename ) && isdefined( objweapon.variantid ) ) )
    {
        return false;
    }
    
    return objweapon.basename == "iw9_me_pickaxe" && objweapon.variantid == 3;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x81793880, Offset: 0xaf24
// Size: 0x5a, Type: bool
function private function_339bb8a8f4bc9d61( objweapon )
{
    if ( !isdefined( objweapon ) || !isdefined( objweapon.basename ) || !isdefined( objweapon.variantid ) )
    {
        return false;
    }
    
    return objweapon.basename == "jup_jp23_me_swhiskey_mp" && objweapon.variantid == 10;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xd0f2993e, Offset: 0xaf87
// Size: 0x5a, Type: bool
function private function_fa7c7cf1fd70bc59( objweapon )
{
    if ( !isdefined( objweapon ) || !isdefined( objweapon.basename ) || !isdefined( objweapon.variantid ) )
    {
        return false;
    }
    
    return objweapon.basename == "jup_jp23_me_spear" && objweapon.variantid == 1;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x8699a35, Offset: 0xafea
// Size: 0x5a, Type: bool
function private function_838bd5b934c22dd0( objweapon )
{
    if ( !isdefined( objweapon ) || !isdefined( objweapon.basename ) || !isdefined( objweapon.variantid ) )
    {
        return false;
    }
    
    return objweapon.basename == "jup_jp23_me_swhiskey_mp" && objweapon.variantid == 9;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x99a45985, Offset: 0xb04d
// Size: 0x24, Type: bool
function private function_5960fc0fb7bffe3b( fakeweapon )
{
    if ( fakeweapon.executionref == "execution_061" )
    {
        return true;
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xac0b2c17, Offset: 0xb07a
// Size: 0x1e, Type: bool
function private function_3773fda9649573ca( objweapon )
{
    if ( objweapon hasattachment( "cos_iw9_screen_029" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xe1d6d803, Offset: 0xb0a1
// Size: 0x1b, Type: bool
function private function_180d748cfae605ec( objweapon )
{
    if ( function_5b487a3dc8c6f598( objweapon ) )
    {
        return true;
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x861df9, Offset: 0xb0c5
// Size: 0x24, Type: bool
function private function_58a3eb2b8522894f( objweapon )
{
    return isdefined( objweapon ) && objweapon.basename == "jup_pi_goldengun_mp";
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xb5d7c415, Offset: 0xb0f2
// Size: 0x5a, Type: bool
function private function_1b40b711abb69b0a( objweapon )
{
    if ( !isdefined( objweapon ) || !isdefined( objweapon.basename ) || !isdefined( objweapon.variantid ) )
    {
        return false;
    }
    
    return objweapon.basename == "jup_jp17_sn_hsierra_mp" && objweapon.variantid == 16;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x320864c5, Offset: 0xb155
// Size: 0x24, Type: bool
function private isdg2death( objweapon )
{
    return isdefined( objweapon ) && objweapon.basename == "jup_ar_dg2_mp";
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x18ec60e8, Offset: 0xb182
// Size: 0x24, Type: bool
function private israygundeath( objweapon )
{
    return isdefined( objweapon ) && objweapon.basename == "jup_pi_raygun_mp";
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xd13ab280, Offset: 0xb1af
// Size: 0x6e, Type: bool
function private function_f4f1fcbd0e0d34f5( objweapon )
{
    if ( isdefined( objweapon.basename ) )
    {
        switch ( objweapon.basename )
        {
            case #"hash_c7a00ceeee2cd52":
            case #"hash_9702698078eb7241":
            case #"hash_b10f0ebdc1fb569b":
            case #"hash_d8fc49c2b6acc257":
                return true;
            default:
                break;
        }
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x899105bc, Offset: 0xb226
// Size: 0x41, Type: bool
function private function_3907722283e6b0f8( corpstable, attacker, hitloc, damageflags )
{
    function_cffb5550ecd2e3eb( corpstable, "youveBeenNaughty_limb", "youveBeenNaughty_torso", "youveBeenNaughty_head" );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x642d7831, Offset: 0xb270
// Size: 0x41, Type: bool
function private function_4dcedcc964c16d5f( corpstable, attacker, hitloc, damageflags )
{
    function_cffb5550ecd2e3eb( corpstable, "youveBeenNice_limb", "youveBeenNice_torso", "youveBeenNice_head" );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x784ae6dd, Offset: 0xb2ba
// Size: 0x41, Type: bool
function private function_b4612ce187e9d454( corpstable, attacker, hitloc, damageflags )
{
    function_cffb5550ecd2e3eb( corpstable, "vDay_limb", "vDay_torso", "vDay_head" );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xc5794f47, Offset: 0xb304
// Size: 0x63, Type: bool
function private function_9226837f2c138ede( corpstable, attacker, hitloc, damageflags )
{
    if ( isdismembermentenabled() )
    {
        function_cffb5550ecd2e3eb( corpstable, "bCell_limb", "bCell_torso", "bCell_head" );
    }
    else
    {
        function_cffb5550ecd2e3eb( corpstable, "bCell_nogore_limb", "bCell_nogore_torso", "bCell_nogore_head" );
    }
    
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xf0e9d6dd, Offset: 0xb370
// Size: 0x36, Type: bool
function private function_d5227e415aefad26( corpstable, attacker, hitloc, damageflags )
{
    function_47e3b72d9cc335d0( corpstable, "purple_shock" );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xa4cd0ef9, Offset: 0xb3af
// Size: 0x41, Type: bool
function private function_e2b3079d82da0de6( corpstable, attacker, hitloc, damageflags )
{
    function_cffb5550ecd2e3eb( corpstable, "paddy_limb", "paddy_torso", "paddy_head" );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x23f30c42, Offset: 0xb3f9
// Size: 0x36, Type: bool
function private function_4acec9eae72b50af( corpstable, attacker, hitloc, damageflags )
{
    function_47e3b72d9cc335d0( corpstable, "shredder" );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x61c1e736, Offset: 0xb438
// Size: 0x49, Type: bool
function private function_dd39f676c0c099e1( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"j_spineupper", "sbandit_fatal" );
    weapon_utility::function_f1337d8a77853c84( self, corpstable );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xa4bd6a98, Offset: 0xb48a
// Size: 0x49, Type: bool
function private function_6856bb2d373441ec( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_sync", "slatedprism_fatal" );
    weapon_utility::function_f1337d8a77853c84( self, corpstable );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x50fba869, Offset: 0xb4dc
// Size: 0x49, Type: bool
function private function_2f17d26b59e4021f( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_sync", "spider_fatal" );
    weapon_utility::function_f1337d8a77853c84( self, corpstable );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x4defe488, Offset: 0xb52e
// Size: 0x3f, Type: bool
function private function_688a6360ee004683( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_sync", "arcstorm_fatal" );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xe33ef2a9, Offset: 0xb576
// Size: 0x54, Type: bool
function private function_4534e7fe41bc0d07( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_origin", "anime_knights_fatal_ground" );
    weapon_utility::function_626fe75ad9d2d09b( self, #"j_spineupper", "anime_knights_fatal" );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x1da8982e, Offset: 0xb5d3
// Size: 0x49, Type: bool
function private function_fbb92c11b3a762ef( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_sync", "harlequin_fatal" );
    weapon_utility::function_f1337d8a77853c84( self, corpstable );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x4aae9031, Offset: 0xb625
// Size: 0x49, Type: bool
function private function_31ad67ef393627b1( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_sync", "techwear_fatal" );
    weapon_utility::function_f1337d8a77853c84( self, corpstable );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x4bdf767e, Offset: 0xb677
// Size: 0x3e, Type: bool
function private function_2ba14e429a0e80ef( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_sync", "spaceignition_fatal" );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x15ec879, Offset: 0xb6be
// Size: 0x49, Type: bool
function private function_2dc8a868c2055cf( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_sync", "eldritch_fatal" );
    weapon_utility::function_f1337d8a77853c84( self, corpstable );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x4b6a9728, Offset: 0xb710
// Size: 0x48, Type: bool
function private function_e0435f3257140865( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_sync", "outbreak_fatal" );
    weapon_utility::function_f1337d8a77853c84( self, corpstable );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xcdbd800b, Offset: 0xb761
// Size: 0x3e, Type: bool
function private function_2b8125f68ce7d135( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_sync", "cyberviking_fatal" );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x6c0b2057, Offset: 0xb7a8
// Size: 0x48, Type: bool
function private function_875d9576c3d285d7( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_sync", "chickentendies_fatal" );
    weapon_utility::function_f1337d8a77853c84( self, corpstable );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x1e6c95f, Offset: 0xb7f9
// Size: 0x48, Type: bool
function private function_fca1dd0006b8d105( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"j_spineupper", "yokai_fatal" );
    weapon_utility::function_f1337d8a77853c84( self, corpstable );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xa5eb07e3, Offset: 0xb84a
// Size: 0x49, Type: bool
function private function_517b342d8a83238e( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_sync", "cronen_squall_fatal" );
    weapon_utility::function_f1337d8a77853c84( self, corpstable );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x8d9e620b, Offset: 0xb89c
// Size: 0x49, Type: bool
function private function_2a424a972b512d77( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_sync", "hades_hands_fatal" );
    weapon_utility::function_f1337d8a77853c84( self, corpstable );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x7319b968, Offset: 0xb8ee
// Size: 0x49, Type: bool
function private function_47d45fb04a6a6151( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_sync", "prismatic_force_fatal" );
    weapon_utility::function_f1337d8a77853c84( self, corpstable );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x1d4f462e, Offset: 0xb940
// Size: 0xe3, Type: bool
function private function_430241fe33189a30( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"j_head", "vfx_imp_flesh_fatal_gunhead_head" );
    weapon_utility::function_626fe75ad9d2d09b( self, #"j_spinelower", "vfx_imp_flesh_fatal_gunhead" );
    weapon_utility::function_626fe75ad9d2d09b( self, #"j_shoulder_ri", "vfx_imp_flesh_fatal_gunhead_arm" );
    weapon_utility::function_626fe75ad9d2d09b( self, #"j_shoulder_le", "vfx_imp_flesh_fatal_gunhead_arm" );
    weapon_utility::function_626fe75ad9d2d09b( self, #"j_elbow_ri", "vfx_imp_flesh_fatal_gunhead_arm" );
    weapon_utility::function_626fe75ad9d2d09b( self, #"j_elbow_le", "vfx_imp_flesh_fatal_gunhead_arm" );
    weapon_utility::function_626fe75ad9d2d09b( self, #"j_hip_ri", "vfx_imp_flesh_fatal_gunhead_leg" );
    weapon_utility::function_626fe75ad9d2d09b( self, #"j_hip_le", "vfx_imp_flesh_fatal_gunhead_leg" );
    weapon_utility::function_f1337d8a77853c84( self, corpstable );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x3911d803, Offset: 0xba2c
// Size: 0x49, Type: bool
function private function_d2f5fbf15fba705f( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_sync", "mech_fatal" );
    weapon_utility::function_f1337d8a77853c84( self, corpstable );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xbad8c8e, Offset: 0xba7e
// Size: 0x125, Type: bool
function private function_1fe1dde207b07666( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"j_spineupper", "rhino_armor_fatal" );
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_sync", "rhino_armor_fatal_ground" );
    weapon_utility::function_626fe75ad9d2d09b( self, #"j_head", "rhino_armor_fatal_head" );
    weapon_utility::function_626fe75ad9d2d09b( self, #"j_shoulder_ri", "rhino_armor_fatal_arm" );
    weapon_utility::function_626fe75ad9d2d09b( self, #"j_shoulder_le", "rhino_armor_fatal_arm" );
    weapon_utility::function_626fe75ad9d2d09b( self, #"j_elbow_ri", "rhino_armor_fatal_arm" );
    weapon_utility::function_626fe75ad9d2d09b( self, #"j_elbow_le", "rhino_armor_fatal_arm" );
    weapon_utility::function_626fe75ad9d2d09b( self, #"j_hip_ri", "rhino_armor_fatal_arm" );
    weapon_utility::function_626fe75ad9d2d09b( self, #"j_hip_le", "rhino_armor_fatal_arm" );
    weapon_utility::function_626fe75ad9d2d09b( self, #"j_knee_ri", "rhino_armor_fatal_arm" );
    weapon_utility::function_626fe75ad9d2d09b( self, #"j_knee_le", "rhino_armor_fatal_arm" );
    weapon_utility::function_f1337d8a77853c84( self, corpstable );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x6b150948, Offset: 0xbbac
// Size: 0x5f, Type: bool
function private function_f3b248f8f490901b( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"j_spineupper", "vampire_hunter_fatal" );
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_sync", "vampire_hunter_fatal_ground" );
    weapon_utility::function_f1337d8a77853c84( self, corpstable );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x2ecc23aa, Offset: 0xbc14
// Size: 0x3e, Type: bool
function private function_b7f085a894181de2( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_origin", "toxic_terror_fatal" );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x9836dd0b, Offset: 0xbc5b
// Size: 0x49, Type: bool
function private function_ed3e40ce6e799b8c( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_sync", "spectral_ghost_fatal" );
    weapon_utility::function_f1337d8a77853c84( self, corpstable );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x56f58b2c, Offset: 0xbcad
// Size: 0x5f, Type: bool
function private function_d3e15a40ed423fed( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"j_spinelower", "striker_wizards_fatal" );
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_sync", "striker_wizards_fatal_ground" );
    weapon_utility::function_f1337d8a77853c84( self, corpstable );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x8db1c3da, Offset: 0xbd15
// Size: 0x49, Type: bool
function private function_7d85d806fae44cb6( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_sync", "crytempest_fatal" );
    weapon_utility::function_f1337d8a77853c84( self, corpstable );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xaa4a9f15, Offset: 0xbd67
// Size: 0x36, Type: bool
function private function_8211ec22561d54ca( corpstable, attacker, hitloc, damageflags )
{
    function_47e3b72d9cc335d0( corpstable, "dark_avengers" );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xcc0b7b2a, Offset: 0xbda6
// Size: 0x3f, Type: bool
function private function_78c680d497103381( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_sync", "brassgolem_fatal" );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xe503fb67, Offset: 0xbdee
// Size: 0x3e, Type: bool
function private function_b32af13599aae6b8( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_sync", "banshee_fatal" );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x5ad246ca, Offset: 0xbe35
// Size: 0x48, Type: bool
function private function_bea62625173f2f22( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_sync", "d20_fatal" );
    weapon_utility::function_f1337d8a77853c84( self, corpstable );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xaa66446f, Offset: 0xbe86
// Size: 0x63, Type: bool
function private function_156d2e3a006b9e8a( corpstable, attacker, hitloc, damageflags )
{
    if ( isdismembermentenabled() )
    {
        function_cffb5550ecd2e3eb( corpstable, "easter_limb", "easter_torso", "easter_head" );
    }
    else
    {
        function_cffb5550ecd2e3eb( corpstable, "easter_nogore_limb", "easter_nogore_torso", "easter_nogore_head" );
    }
    
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xf36b9e22, Offset: 0xbef2
// Size: 0x36, Type: bool
function private function_3dd4cd23f7a40b3b( corpstable, attacker, hitloc, damageflags )
{
    function_47e3b72d9cc335d0( corpstable, "electricAnime" );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x34dd12, Offset: 0xbf31
// Size: 0x57, Type: bool
function private function_10befaf2d75b1318( corpstable, attacker, hitloc, damageflags )
{
    function_cffb5550ecd2e3eb( corpstable, "scifi_limb", "scifi_torso", "scifi_head" );
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_origin", "scifi_origin" );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x314ca460, Offset: 0xbf91
// Size: 0x57, Type: bool
function private function_1e566c57e33c1b2a( corpstable, attacker, hitloc, damageflags )
{
    function_cffb5550ecd2e3eb( corpstable, "scifi2_limb", "scifi2_torso", "scifi2_head" );
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_origin", "scifi2_origin" );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x90cd7cef, Offset: 0xbff1
// Size: 0x57, Type: bool
function private function_71a5badf21c84daf( corpstable, attacker, hitloc, damageflags )
{
    function_cffb5550ecd2e3eb( corpstable, "scifi3_limb", "scifi3_torso", "scifi3_head" );
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_origin", "scifi3_origin" );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x6d958e88, Offset: 0xc051
// Size: 0x3e, Type: bool
function private function_7bdfb3ffd2ec0432( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"j_spineupper", "420_death" );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x17a8c7df, Offset: 0xc098
// Size: 0x3e, Type: bool
function private function_b4802d28df000a50( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"j_spineupper", "hitscan" );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x18ed872c, Offset: 0xc0df
// Size: 0x49, Type: bool
function private function_d29abe23b27afa99( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"j_spine4", "witch" );
    weapon_utility::function_f1337d8a77853c84( self, corpstable );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x71d5c056, Offset: 0xc131
// Size: 0x62, Type: bool
function private function_7881cf4b9ba631d2( corpstable, attacker, hitloc, damageflags )
{
    if ( hitloc == "head" || hitloc == "helmet" )
    {
        weapon_utility::function_626fe75ad9d2d09b( self, #"j_spine4", "zombie" );
        weapon_utility::function_f1337d8a77853c84( self, corpstable );
        return true;
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x9646293c, Offset: 0xc19c
// Size: 0x5f, Type: bool
function private function_354884b05ce1e6e7( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_origin", "thor" );
    weapon_utility::function_626fe75ad9d2d09b( self, #"j_spineupper", "thor_chest" );
    weapon_utility::function_f1337d8a77853c84( self, corpstable );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x95604ce5, Offset: 0xc204
// Size: 0x36, Type: bool
function private function_ead20b21fee118f5( corpstable, attacker, hitloc, damageflags )
{
    function_47e3b72d9cc335d0( corpstable, "kd" );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x3e03f64, Offset: 0xc243
// Size: 0x36, Type: bool
function private function_4a737c26e8f2af7f( corpstable, attacker, hitloc, damageflags )
{
    function_47e3b72d9cc335d0( corpstable, "cdl" );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xdc545005, Offset: 0xc282
// Size: 0x71
function private function_8112584bc0f47cdc( corpstable, attacker, hitloc, damageflags )
{
    deletebody = 0;
    function_cffb5550ecd2e3eb( corpstable, "soulEater_limb", "soulEater_torso", "soulEater_head", undefined, deletebody );
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_origin", "soulEater_death" );
    attacker thread function_404bd1e786a6c87b( corpstable );
    return deletebody;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x969a464a, Offset: 0xc2fc
// Size: 0x41, Type: bool
function private mtx_crashdeath( corpstable, attacker, hitloc, damageflags )
{
    function_cffb5550ecd2e3eb( corpstable, "crash_limb", "crash_torso", "crash_head" );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xe701a99d, Offset: 0xc346
// Size: 0x49, Type: bool
function private function_4f239c5dd971f98c( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_origin", "akihabara_fatal" );
    weapon_utility::function_f1337d8a77853c84( self, corpstable );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x47918979, Offset: 0xc398
// Size: 0x47, Type: bool
function private function_6f112bc5b64c892b( corpstable, attacker, hitloc, damageflags )
{
    if ( corpstable isscriptable() )
    {
        corpstable setscriptablepartstate( #"burning", "flareup", 0 );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x5ca87e86, Offset: 0xc3e8
// Size: 0x63, Type: bool
function private function_48122bf57920846d( corpstable, attacker, hitloc, damageflags )
{
    if ( isdismembermentenabled() )
    {
        function_cffb5550ecd2e3eb( corpstable, "cthulhu_limb", "cthulhu_torso", "cthulhu_head" );
    }
    else
    {
        function_cffb5550ecd2e3eb( corpstable, "cthulhu_nogore_limb", "cthulhu_nogore_torso", "cthulhu_nogore_head" );
    }
    
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x7085c42f, Offset: 0xc454
// Size: 0x63, Type: bool
function private function_80325eed89fbbec6( corpstable, attacker, hitloc, damageflags )
{
    if ( isdismembermentenabled() )
    {
        function_cffb5550ecd2e3eb( corpstable, "hlander_limb", "hlander_torso", "hlander_head" );
    }
    else
    {
        function_cffb5550ecd2e3eb( corpstable, "hlander_nogore_limb", "hlander_nogore_torso", "hlander_nogore_head" );
    }
    
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xffd8a4ce, Offset: 0xc4c0
// Size: 0x52, Type: bool
function private function_d112506f4f3a72a2( corpstable, attacker, hitloc, damageflags )
{
    if ( hitloc == "head" )
    {
        function_47e3b72d9cc335d0( corpstable, "bnoir_head" );
    }
    else
    {
        function_47e3b72d9cc335d0( corpstable, "bnoir" );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x4e38e08f, Offset: 0xc51b
// Size: 0x53, Type: bool
function private function_f93e3f01a1b7a791( corpstable, attacker, hitloc, damageflags )
{
    tag = function_1c00c343fc5ff4d1( hitloc );
    playfxontag( level._effect[ "40k" ], corpstable, tag );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x2789c5e1, Offset: 0xc577
// Size: 0x53, Type: bool
function private function_2b9bf1a3a1bfe13e( corpstable, attacker, hitloc, damageflags )
{
    tag = function_1c00c343fc5ff4d1( hitloc );
    playfxontag( level._effect[ "underworld" ], corpstable, tag );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x84ca5ca8, Offset: 0xc5d3
// Size: 0x53, Type: bool
function private function_5e11e3a4b3b78d7d( corpstable, attacker, hitloc, damageflags )
{
    tag = function_1c00c343fc5ff4d1( hitloc );
    playfxontag( level._effect[ "wonton" ], corpstable, tag );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xf0b3d33f, Offset: 0xc62f
// Size: 0x53, Type: bool
function private function_fe7e870e73d2d56b( corpstable, attacker, hitloc, damageflags )
{
    tag = function_1c00c343fc5ff4d1( hitloc );
    playfxontag( level._effect[ "mandu" ], corpstable, tag );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xdc3be76, Offset: 0xc68b
// Size: 0x36, Type: bool
function private function_58456461eb2687( corpstable, attacker, hitloc, damageflags )
{
    function_47e3b72d9cc335d0( corpstable, "blackcell_s5Melee" );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x7f3bb1, Offset: 0xc6ca
// Size: 0x53, Type: bool
function private function_101cbff94707b454( corpstable, attacker, hitloc, damageflags )
{
    tag = function_1c00c343fc5ff4d1( hitloc );
    playfxontag( level._effect[ "blackcell_s5" ], corpstable, tag );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xb6970047, Offset: 0xc726
// Size: 0x36, Type: bool
function private function_e64be728c0e9123c( corpstable, attacker, hitloc, damageflags )
{
    function_47e3b72d9cc335d0( corpstable, "gilmanMelee" );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xc79a44d4, Offset: 0xc765
// Size: 0x53, Type: bool
function private function_8480b4cc59c7eba5( corpstable, attacker, hitloc, damageflags )
{
    tag = function_1c00c343fc5ff4d1( hitloc );
    playfxontag( level._effect[ "shapechanger" ], corpstable, tag );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xe68c4a07, Offset: 0xc7c1
// Size: 0x53, Type: bool
function private function_d178c469de8d12f0( corpstable, attacker, hitloc, damageflags )
{
    tag = function_1c00c343fc5ff4d1( hitloc );
    playfxontag( level._effect[ "tonfa" ], corpstable, tag );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x39019f56, Offset: 0xc81d
// Size: 0x78, Type: bool
function private function_7f3124192d315274( corpstable, attacker, hitloc, damageflags )
{
    tag = function_1c00c343fc5ff4d1( hitloc );
    
    if ( isheavymeleedamage( damageflags ) )
    {
        playfxontag( level._effect[ "vinyl_heavy" ], corpstable, tag );
    }
    else
    {
        playfxontag( level._effect[ "vinyl" ], corpstable, tag );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x72443d0b, Offset: 0xc89e
// Size: 0x36, Type: bool
function private function_a27cf61b0f889410( corpstable, attacker, hitloc, damageflags )
{
    function_47e3b72d9cc335d0( corpstable, "40kMelee" );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x4139de57, Offset: 0xc8dd
// Size: 0x36, Type: bool
function private function_4d766e72a2d5a7cf( corpstable, attacker, hitloc, damageflags )
{
    function_47e3b72d9cc335d0( corpstable, "underworldMelee" );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x555f3d70, Offset: 0xc91c
// Size: 0x36, Type: bool
function private function_9864bf3a29f8b39c( corpstable, attacker, hitloc, damageflags )
{
    function_47e3b72d9cc335d0( corpstable, "wontonMelee" );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xf587bd2c, Offset: 0xc95b
// Size: 0x36, Type: bool
function private function_acc7062661ad1992( corpstable, attacker, hitloc, damageflags )
{
    function_47e3b72d9cc335d0( corpstable, "manduMelee" );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x172df070, Offset: 0xc99a
// Size: 0x36, Type: bool
function private function_bb2096de44b38305( corpstable, attacker, hitloc, damageflags )
{
    function_47e3b72d9cc335d0( corpstable, "blackcell_s5Melee" );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x6bf0bdb7, Offset: 0xc9d9
// Size: 0x36, Type: bool
function private function_6f4b999be12a23e( corpstable, attacker, hitloc, damageflags )
{
    function_47e3b72d9cc335d0( corpstable, "gilmanMelee" );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x6a296ca1, Offset: 0xca18
// Size: 0x36, Type: bool
function private function_fa9a9781c9453b4( corpstable, attacker, hitloc, damageflags )
{
    function_47e3b72d9cc335d0( corpstable, "shapechangerMelee" );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xc1860717, Offset: 0xca57
// Size: 0x36, Type: bool
function private function_ce694afa144863b0( corpstable, attacker, hitloc, damageflags )
{
    function_47e3b72d9cc335d0( corpstable, "ubSawMelee" );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xf8ee5795, Offset: 0xca96
// Size: 0x53, Type: bool
function private function_9e7383d20f5bf879( corpstable, attacker, hitloc, damageflags )
{
    tag = function_1c00c343fc5ff4d1( hitloc );
    playfxontag( level._effect[ "bikeMelee" ], corpstable, tag );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xed9e2790, Offset: 0xcaf2
// Size: 0x54, Type: bool
function private function_d7bf9ede0b764fe( corpstable, attacker, hitloc, damageflags )
{
    tag = function_1c00c343fc5ff4d1( hitloc );
    playfxontag( level._effect[ "oreZincMelee" ], corpstable, tag );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x990f808c, Offset: 0xcb4f
// Size: 0x53, Type: bool
function private function_ed03f0036ee25688( corpstable, attacker, hitloc, damageflags )
{
    tag = function_1c00c343fc5ff4d1( hitloc );
    playfxontag( level._effect[ "pineapple" ], corpstable, tag );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x6afb5320, Offset: 0xcbab
// Size: 0x6f
function private function_3d5471b0be7f573( corpstable, attacker, hitloc, damageflags )
{
    deletedbody = 0;
    
    if ( isdismembermentenabled() )
    {
        function_cffb5550ecd2e3eb( corpstable, "golden_gun_limb", "golden_gun_torso", "golden_gun_head" );
        deletedbody = 1;
    }
    
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_origin", "golden_gun_origin" );
    return deletedbody;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x971b5194, Offset: 0xcc23
// Size: 0x6f
function private function_cb1be48c5e1c432e( corpstable, attacker, hitloc, damageflags )
{
    deletedbody = 0;
    
    if ( isdismembermentenabled() )
    {
        function_cffb5550ecd2e3eb( corpstable, "mahou_limb", "mahou_torso", "mahou_head" );
        deletedbody = 1;
    }
    
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_origin", "mahou_origin" );
    return deletedbody;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xa3bc2993, Offset: 0xcc9b
// Size: 0x41, Type: bool
function private function_acc95e18efa344e6( corpstable, attacker, hitloc, damageflags )
{
    function_cffb5550ecd2e3eb( corpstable, "nicki_limb", "nicki_torso", "nicki_head" );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x220dcbe, Offset: 0xcce5
// Size: 0x63, Type: bool
function private function_526ab8ba3e720951( corpstable, attacker, hitloc, damageflags )
{
    if ( isdismembermentenabled() )
    {
        function_cffb5550ecd2e3eb( corpstable, "ice_limb", "ice_torso", "ice_head" );
    }
    else
    {
        function_cffb5550ecd2e3eb( corpstable, "ice_nogore_limb", "ice_nogore_torso", "ice_head" );
    }
    
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xc7bc4efc, Offset: 0xcd51
// Size: 0x63, Type: bool
function private function_59f427e659e59656( corpstable, attacker, hitloc, damageflags )
{
    if ( isdismembermentenabled() )
    {
        function_cffb5550ecd2e3eb( corpstable, "tomb_limb", "tomb_torso", "tomb_head" );
    }
    else
    {
        function_cffb5550ecd2e3eb( corpstable, "tomb_limb_nogore", "tomb_torso_nogore", "tomb_head_nogore" );
    }
    
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x40b106f1, Offset: 0xcdbd
// Size: 0x41, Type: bool
function private function_cac6c215604b1bb6( corpstable, attacker, hitloc, damageflags )
{
    function_cffb5550ecd2e3eb( corpstable, "hips_limb", "hips_torso", "hips_head" );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xf5c476fc, Offset: 0xce07
// Size: 0x41, Type: bool
function private function_5b4b07344f52aeac( corpstable, attacker, hitloc, damageflags )
{
    function_cffb5550ecd2e3eb( corpstable, "hops_limb", "hops_torso", "hops_head" );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x1b17c10a, Offset: 0xce51
// Size: 0x36, Type: bool
function private function_1e14fcd440666401( corpstable, attacker, hitloc, damageflags )
{
    function_47e3b72d9cc335d0( corpstable, "blunt" );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x1e31e3a1, Offset: 0xce90
// Size: 0x63, Type: bool
function private function_b6c61638933fc2b5( corpstable, attacker, hitloc, damageflags )
{
    if ( isdismembermentenabled() )
    {
        function_cffb5550ecd2e3eb( corpstable, "maze_limb", "maze_torso", "maze_head" );
    }
    else
    {
        function_cffb5550ecd2e3eb( corpstable, "maze_nogore_limb", "maze_nogore_torso", "maze_nogore_head" );
    }
    
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xcfbbb5c, Offset: 0xcefc
// Size: 0x49, Type: bool
function private function_6ce07cbf124e29ec( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"j_spinelower", "lilith" );
    weapon_utility::function_f1337d8a77853c84( self, corpstable );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xe7793ecc, Offset: 0xcf4e
// Size: 0x49, Type: bool
function private function_6203d97d033830f( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"j_spine4", "lilith" );
    weapon_utility::function_f1337d8a77853c84( self, corpstable );
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x710a867a, Offset: 0xcfa0
// Size: 0x28, Type: bool
function private function_e67203e44711573e( corpstable, attacker, hitloc, damageflags )
{
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x2f2573b3, Offset: 0xcfd1
// Size: 0x36, Type: bool
function private function_bbd222e5d970003d( corpstable, attacker, hitloc, damageflags )
{
    function_47e3b72d9cc335d0( corpstable, "skeletor" );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x2762d9f8, Offset: 0xd010
// Size: 0x40, Type: bool
function private function_f5a201517913628c( corpstable, attacker, hitloc, damageflags )
{
    function_cffb5550ecd2e3eb( corpstable, "bcell6_limb", "bcell6_torso", "bcell6_head" );
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x6e1cbb2f, Offset: 0xd059
// Size: 0x49, Type: bool
function private function_d291d7954e8bd025( corpstable, attacker, hitloc, damageflags )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"j_spine4", "inarius" );
    weapon_utility::function_f1337d8a77853c84( self, corpstable );
    return true;
}

// Namespace mtx_weapon
// Params 3, eflags: 0x4
// Checksum 0xad900294, Offset: 0xd0ab
// Size: 0x4b, Type: bool
function private function_ff069494f4f8611b( corpstable, attacker, hitloc )
{
    weapon_utility::function_626fe75ad9d2d09b( self, #"tag_origin", "thor" );
    weapon_utility::function_626fe75ad9d2d09b( self, #"j_spineupper", "thor_chest" );
    return false;
}

// Namespace mtx_weapon
// Params 3, eflags: 0x4
// Checksum 0x993142af, Offset: 0xd0ff
// Size: 0x5a, Type: bool
function private function_415cef36c96147ee( corpstable, attacker, hitloc )
{
    if ( isdismembermentenabled() )
    {
        function_cffb5550ecd2e3eb( corpstable, "hlander_limb", "hlander_torso", "hlander_head" );
    }
    else
    {
        function_cffb5550ecd2e3eb( corpstable, "hlander_nogore_limb", "hlander_nogore_torso", "hlander_nogore_head" );
    }
    
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xe22c0808, Offset: 0xd162
// Size: 0x54, Type: bool
function private function_63c6b0a82b3a5e78( corpstable, attacker, hitloc, damageflags )
{
    tag = function_1c00c343fc5ff4d1( hitloc );
    playfxontag( level._effect[ "voxel" ], corpstable, tag );
    return true;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x6552c151, Offset: 0xd1bf
// Size: 0x3c, Type: bool
function private function_3e33cd3913a893a1( inflictor )
{
    if ( !isbrgamemode() )
    {
        return false;
    }
    
    if ( inflictor.var_358fa7a9cb9bb135 )
    {
        return true;
    }
    
    if ( weapon_utility::isinflictorstucktoplayer( inflictor, self, "equip_bunkerbuster" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x931f8c23, Offset: 0xd204
// Size: 0x33
function private function_d4ef90a55afa0767( corpstable )
{
    if ( isdismembermentenabled() )
    {
        function_cffb5550ecd2e3eb( corpstable, "hlander_limb", "hlander_torso", "hlander_head" );
        return 1;
    }
    
    return 0;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x20072b4f, Offset: 0xd23f
// Size: 0x63, Type: bool
function private function_30f2d11294017281( corpstable, attacker, hitloc, damageflags )
{
    if ( utility::percent_chance( 10 ) )
    {
        if ( self tagexists( #"j_spinelower" ) )
        {
            playfxontag( level._effect[ "raygunRepair" ], corpstable, #"j_spinelower" );
        }
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x351f4ea7, Offset: 0xd2ab
// Size: 0x7c, Type: bool
function private function_a039e2941d94b1fa( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    tag = function_1c00c343fc5ff4d1( hitloc );
    
    if ( self tagexists( tag ) )
    {
        playfxontag( level._effect[ "cer_LimbDismemberment" ], corpstable, tag );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xaaed5116, Offset: 0xd330
// Size: 0x77, Type: bool
function private function_f7bf5db7589592cd( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    if ( self tagexists( #"j_spinelower" ) )
    {
        playfxontag( level._effect[ "cer_Annihilation" ], corpstable, #"j_spinelower" );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x8fa86815, Offset: 0xd3b0
// Size: 0x69, Type: bool
function private function_c4bdf31f66b16d0c( corpstable, attacker, hitloc, damageflags )
{
    if ( isdismembermentenabled() )
    {
        weapon_utility::function_626fe75ad9d2d09b( self, #"j_spine4", "vault" );
        weapon_utility::function_f1337d8a77853c84( self, corpstable );
    }
    else
    {
        weapon_utility::function_626fe75ad9d2d09b( self, #"j_spine4", "vault_safe" );
    }
    
    return true;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x469e0d66, Offset: 0xd422
// Size: 0x7c, Type: bool
function private function_8a3e94642281db28( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    tag = function_1c00c343fc5ff4d1( hitloc );
    
    if ( self tagexists( tag ) )
    {
        playfxontag( level._effect[ "steampunk" ], corpstable, tag );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x8a4ad249, Offset: 0xd4a7
// Size: 0x90, Type: bool
function private function_70c79427f7f7b046( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    tag = function_1c00c343fc5ff4d1( hitloc );
    
    if ( isdefined( level._effect[ "gvibes" ] ) && self tagexists( tag ) )
    {
        playfxontag( level._effect[ "gvibes" ], corpstable, tag );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x71b12780, Offset: 0xd540
// Size: 0x7c, Type: bool
function private function_e0d25276ba90ddd2( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    tag = function_1c00c343fc5ff4d1( hitloc );
    
    if ( self tagexists( tag ) )
    {
        playfxontag( level._effect[ "deadops" ], corpstable, tag );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x2a628145, Offset: 0xd5c5
// Size: 0x7c, Type: bool
function private function_fdef5d3b5ebecefe( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    tag = function_1c00c343fc5ff4d1( hitloc );
    
    if ( self tagexists( tag ) )
    {
        playfxontag( level._effect[ "cartoon" ], corpstable, tag );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xbec33d4b, Offset: 0xd64a
// Size: 0x90, Type: bool
function private function_add52bc88c7f4b5f( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    tag = function_1c00c343fc5ff4d1( hitloc );
    
    if ( isdefined( level._effect[ "tmnt_slime" ] ) && self tagexists( tag ) )
    {
        playfxontag( level._effect[ "tmnt_slime" ], corpstable, tag );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x2b48d22e, Offset: 0xd6e3
// Size: 0x96, Type: bool
function private function_679168476fe4e4e2( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    tag = function_1c00c343fc5ff4d1( hitloc );
    
    if ( isdefined( level._effect[ "tmnt_don" ] ) && isdefined( tag ) && self tagexists( tag ) )
    {
        playfxontag( level._effect[ "tmnt_don" ], corpstable, tag );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x9c8a6150, Offset: 0xd782
// Size: 0x90, Type: bool
function private function_3233f38770168c37( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    tag = function_1c00c343fc5ff4d1( hitloc );
    
    if ( isdefined( level._effect[ "tmnt_mike" ] ) && self tagexists( tag ) )
    {
        playfxontag( level._effect[ "tmnt_mike" ], corpstable, tag );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x40b13e52, Offset: 0xd81b
// Size: 0x90, Type: bool
function private function_8efa8b8c894fca98( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    tag = function_1c00c343fc5ff4d1( hitloc );
    
    if ( isdefined( level._effect[ "tmnt_raph" ] ) && self tagexists( tag ) )
    {
        playfxontag( level._effect[ "tmnt_raph" ], corpstable, tag );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x597b8145, Offset: 0xd8b4
// Size: 0x90, Type: bool
function private function_8fcdcad357a21cb3( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    tag = function_1c00c343fc5ff4d1( hitloc );
    
    if ( isdefined( level._effect[ "tmnt_leo" ] ) && self tagexists( tag ) )
    {
        playfxontag( level._effect[ "tmnt_leo" ], corpstable, tag );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x4804f489, Offset: 0xd94d
// Size: 0x7c, Type: bool
function private function_9ba4703156f6a935( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    tag = function_1c00c343fc5ff4d1( hitloc );
    
    if ( self tagexists( tag ) )
    {
        playfxontag( level._effect[ "bigjoke" ], corpstable, tag );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xd9622499, Offset: 0xd9d2
// Size: 0x8b, Type: bool
function private function_9cd1f18cc02aa1d4( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    if ( isdefined( level._effect[ "tmnt_slime" ] ) && self tagexists( #"j_spinelower" ) )
    {
        playfxontag( level._effect[ "tmnt_slime" ], corpstable, #"j_spinelower" );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xe8ea61a1, Offset: 0xda66
// Size: 0x90, Type: bool
function private function_19221b97e8a0fc0d( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    tag = function_1c00c343fc5ff4d1( hitloc );
    
    if ( isdefined( level._effect[ "bbots" ] ) && self tagexists( tag ) )
    {
        playfxontag( level._effect[ "bbots" ], corpstable, tag );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xe80e5f56, Offset: 0xdaff
// Size: 0x90, Type: bool
function private function_a4b186b340f4951d( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    tag = function_1c00c343fc5ff4d1( hitloc );
    
    if ( isdefined( level._effect[ "comic_strip" ] ) && self tagexists( tag ) )
    {
        playfxontag( level._effect[ "comic_strip" ], corpstable, tag );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xdb0318, Offset: 0xdb98
// Size: 0x90, Type: bool
function private function_b01b5c2c9d832343( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    tag = function_1c00c343fc5ff4d1( hitloc );
    
    if ( isdefined( level._effect[ "bacon" ] ) && self tagexists( tag ) )
    {
        playfxontag( level._effect[ "bacon" ], corpstable, tag );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xe082c44f, Offset: 0xdc31
// Size: 0x90, Type: bool
function private function_f1c4db47cbe0c4da( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    tag = function_1c00c343fc5ff4d1( hitloc );
    
    if ( isdefined( level._effect[ "tomato" ] ) && self tagexists( tag ) )
    {
        playfxontag( level._effect[ "tomato" ], corpstable, tag );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x9e93c272, Offset: 0xdcca
// Size: 0x90, Type: bool
function private function_88ed32f74f3bde2e( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    tag = function_1c00c343fc5ff4d1( hitloc );
    
    if ( isdefined( level._effect[ "ssword" ] ) && self tagexists( tag ) )
    {
        playfxontag( level._effect[ "ssword" ], corpstable, tag );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xadd4e5c5, Offset: 0xdd63
// Size: 0x90, Type: bool
function private function_5cd363f0519189cc( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    tag = function_1c00c343fc5ff4d1( hitloc );
    
    if ( isdefined( level._effect[ "dino" ] ) && self tagexists( tag ) )
    {
        playfxontag( level._effect[ "dino" ], corpstable, tag );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x341d9152, Offset: 0xddfc
// Size: 0x90, Type: bool
function private function_35bdc6f5345139d8( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    tag = function_1c00c343fc5ff4d1( hitloc );
    
    if ( isdefined( level._effect[ "corgi" ] ) && self tagexists( tag ) )
    {
        playfxontag( level._effect[ "corgi" ], corpstable, tag );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x168c9662, Offset: 0xde95
// Size: 0x90, Type: bool
function private function_3efb7c693ed2c9bf( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    tag = function_1c00c343fc5ff4d1( hitloc );
    
    if ( isdefined( level._effect[ "aqueen" ] ) && self tagexists( tag ) )
    {
        playfxontag( level._effect[ "aqueen" ], corpstable, tag );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x75de842e, Offset: 0xdf2e
// Size: 0x90, Type: bool
function private function_b2235b457eb3ba6d( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    tag = function_1c00c343fc5ff4d1( hitloc );
    
    if ( isdefined( level._effect[ "hobbyhorse" ] ) && self tagexists( tag ) )
    {
        playfxontag( level._effect[ "hobbyhorse" ], corpstable, tag );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x20493cf0, Offset: 0xdfc7
// Size: 0x90, Type: bool
function private function_69aabe05bb1d9b65( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    tag = function_1c00c343fc5ff4d1( hitloc );
    
    if ( isdefined( level._effect[ "poodle" ] ) && self tagexists( tag ) )
    {
        playfxontag( level._effect[ "poodle" ], corpstable, tag );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x5ad7deb0, Offset: 0xe060
// Size: 0x90, Type: bool
function private function_90969660ae379481( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    tag = function_1c00c343fc5ff4d1( hitloc );
    
    if ( isdefined( level._effect[ "ikwydls" ] ) && self tagexists( tag ) )
    {
        playfxontag( level._effect[ "ikwydls" ], corpstable, tag );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x5315d1e8, Offset: 0xe0f9
// Size: 0x90, Type: bool
function private function_c6cd4b6cb3f433dc( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    tag = function_1c00c343fc5ff4d1( hitloc );
    
    if ( isdefined( level._effect[ "ahstormare" ] ) && self tagexists( tag ) )
    {
        playfxontag( level._effect[ "ahstormare" ], corpstable, tag );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xe2b2472c, Offset: 0xe192
// Size: 0x90, Type: bool
function private function_a15233f558919f6a( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    tag = function_1c00c343fc5ff4d1( hitloc );
    
    if ( isdefined( level._effect[ "tsoldier" ] ) && self tagexists( tag ) )
    {
        playfxontag( level._effect[ "tsoldier" ], corpstable, tag );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xf932e49f, Offset: 0xe22b
// Size: 0x90, Type: bool
function private function_ad81703b0dbdcfd7( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    tag = function_1c00c343fc5ff4d1( hitloc );
    
    if ( isdefined( level._effect[ "wninja" ] ) && self tagexists( tag ) )
    {
        playfxontag( level._effect[ "wninja" ], corpstable, tag );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xe1a425eb, Offset: 0xe2c4
// Size: 0x90, Type: bool
function private function_26bd1f44452df27c( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    tag = function_1c00c343fc5ff4d1( hitloc );
    
    if ( isdefined( level._effect[ "bluntev" ] ) && self tagexists( tag ) )
    {
        playfxontag( level._effect[ "bluntev" ], corpstable, tag );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xc024d196, Offset: 0xe35d
// Size: 0x90, Type: bool
function private function_721f1aa368179ac3( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    tag = function_1c00c343fc5ff4d1( hitloc );
    
    if ( isdefined( level._effect[ "mskate" ] ) && self tagexists( tag ) )
    {
        playfxontag( level._effect[ "mskate" ], corpstable, tag );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xdd162760, Offset: 0xe3f6
// Size: 0x90, Type: bool
function private function_c408f703e9930131( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    tag = function_1c00c343fc5ff4d1( hitloc );
    
    if ( isdefined( level._effect[ "caramel" ] ) && self tagexists( tag ) )
    {
        playfxontag( level._effect[ "caramel" ], corpstable, tag );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0xffa42ebc, Offset: 0xe48f
// Size: 0x90, Type: bool
function private function_6c0a75767197569b( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    tag = function_1c00c343fc5ff4d1( hitloc );
    
    if ( isdefined( level._effect[ "bostaff_larpers" ] ) && self tagexists( tag ) )
    {
        playfxontag( level._effect[ "bostaff_larpers" ], corpstable, tag );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 4, eflags: 0x4
// Checksum 0x5a497fc7, Offset: 0xe528
// Size: 0x90, Type: bool
function private function_c2248e2da31eb2d8( corpstable, attacker, hitloc, damageflags )
{
    if ( self.type == "zombie" )
    {
        if ( utility::percent_chance( 75 ) )
        {
            return false;
        }
    }
    
    tag = function_1c00c343fc5ff4d1( hitloc );
    
    if ( isdefined( level._effect[ "hallucin" ] ) && self tagexists( tag ) )
    {
        playfxontag( level._effect[ "hallucin" ], corpstable, tag );
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xdc302a80, Offset: 0xe5c1
// Size: 0x118
function private function_404bd1e786a6c87b( corpstable )
{
    waittillframeend();
    
    if ( self.var_ba0fee1a3d02f016[ #"ghost_finder_sucking" ] )
    {
        return;
    }
    
    soulent = spawn( "script_model", corpstable.origin + ( 0, 0, 40 ) );
    soulent setmodel( %"vfx_scriptable_souleater" );
    soulent function_474bcbb86b733bef( "soulEater", self.team );
    self.var_ba0fee1a3d02f016[ #"soul_ents_in_flight" ][ self.var_ba0fee1a3d02f016[ #"soul_ents_in_flight" ].size ] = soulent;
    success = function_7a929edf3ec1ac4a( soulent );
    
    if ( success )
    {
        thread souleatersuccess();
    }
    else
    {
        souleaterfail( soulent );
    }
    
    if ( isdefined( soulent ) )
    {
        if ( isdefined( self ) && isdefined( self.var_ba0fee1a3d02f016 ) )
        {
            self.var_ba0fee1a3d02f016[ #"soul_ents_in_flight" ] = arrayremove( self.var_ba0fee1a3d02f016[ #"soul_ents_in_flight" ], soulent );
        }
        
        soulent delete();
    }
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0x24a82f89, Offset: 0xe6e1
// Size: 0x74
function private function_69c7f36d235265fe()
{
    self notify( #"stop_soulweapon_swap_logic" );
    self endon( #"stop_soulweapon_swap_logic" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"weapon_switch_started", weapon );
        
        if ( function_765a22b52d7fbd68( weapon ) != #"soulEater" )
        {
            self notify( #"stop_soul_suck" );
        }
    }
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x33177c9c, Offset: 0xe75d
// Size: 0x2fe, Type: bool
function private function_7a929edf3ec1ac4a( soulent )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    var_78ec8791b63f8c69 = gettime();
    movetime = function_d3ed3d20753b49bd( soulent );
    hovertime = function_bba71cb4a381e2bc( soulent, var_78ec8791b63f8c69, movetime );
    destinationtime = var_78ec8791b63f8c69 + movetime + hovertime;
    soulent.destinationtime = destinationtime;
    soulent setscriptablepartstate( #"soulEater", "hover" );
    soulent moveto( soulent.origin + ( 0, 0, 15 ), 0.7 );
    wait hovertime / 1000;
    soulent setscriptablepartstate( #"soulEater", "suck" );
    var_a40e01b01f05959d = gettime();
    zoffsetmax = undefined;
    yoffsetmax = undefined;
    zoffset = undefined;
    yoffset = undefined;
    baseorigin = soulent.origin;
    thread function_2b1f4efb0ccea208( soulent, movetime );
    
    while ( true )
    {
        if ( !isdefined( self ) )
        {
            return false;
        }
        
        timepassed = gettime() - var_a40e01b01f05959d;
        remainingtime = movetime - timepassed;
        timefraction = min( 1, ( timepassed + level.frameduration ) / movetime );
        timeslice = level.frameduration * timefraction;
        
        if ( remainingtime > timeslice )
        {
            movefraction = timeslice / remainingtime;
        }
        else
        {
            movefraction = 1;
        }
        
        if ( remainingtime <= 0 )
        {
            break;
        }
        
        var_3da60901acbb59a7 = math::factor_value( 5, 0, self playerads() );
        f = anglestoforward( self getplayerangles() ) * 20;
        u = anglestoup( self getplayerangles() ) * -9;
        r = anglestoright( self getplayerangles() ) * var_3da60901acbb59a7;
        targetorigin = self geteye() + f + u + r;
        vectotarget = targetorigin - baseorigin;
        dirtotarget = vectornormalize( vectotarget );
        dist = length( vectotarget );
        
        if ( !isdefined( zoffsetmax ) )
        {
            zoffsetmax = function_2374da3eb027daa0( dist );
            yoffsetmax = randomfloatrange( -1.5, 1.5 ) * zoffsetmax;
        }
        
        zoffset = function_558c7bcb43027f21( movetime, timepassed + level.frameduration, zoffsetmax );
        yoffset = function_558c7bcb43027f21( movetime, timepassed + level.frameduration, yoffsetmax );
        dirr = rotatevector( dirtotarget, ( 0, 90, 0 ) );
        yoffset = dirr * yoffset;
        zoffset = ( 0, 0, zoffset );
        offset = dist * movefraction * dirtotarget;
        baseorigin += offset;
        soulent.origin = baseorigin + zoffset + yoffset;
        waitframe();
    }
    
    return true;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x7006f2e9, Offset: 0xea64
// Size: 0x5f
function private function_d3ed3d20753b49bd( soulent )
{
    dist = length( soulent.origin - self.origin );
    factor = math::normalize_value( 300, 2000, dist );
    return math::factor_value( 0.4, 1, factor ) * 1000;
}

// Namespace mtx_weapon
// Params 3, eflags: 0x4
// Checksum 0x427d6f27, Offset: 0xeacc
// Size: 0xe7
function private function_bba71cb4a381e2bc( soulent, var_78ec8791b63f8c69, movetime )
{
    self.var_ba0fee1a3d02f016[ #"soul_ents_in_flight" ] = function_5713d46873b29625( self.var_ba0fee1a3d02f016[ #"soul_ents_in_flight" ] );
    var_55bc73b91ac2704d = 700;
    
    if ( self.var_ba0fee1a3d02f016[ #"soul_ents_in_flight" ][ 0 ] == soulent )
    {
        return var_55bc73b91ac2704d;
    }
    
    var_b295f0217f2499df = self.var_ba0fee1a3d02f016[ #"soul_ents_in_flight" ][ self.var_ba0fee1a3d02f016[ #"soul_ents_in_flight" ].size - 2 ].destinationtime - var_78ec8791b63f8c69;
    var_cae40917d27e3fb4 = var_b295f0217f2499df + 300;
    var_57447b3dfe2ff593 = var_cae40917d27e3fb4 - movetime * 1000;
    return max( var_55bc73b91ac2704d, var_57447b3dfe2ff593 );
}

// Namespace mtx_weapon
// Params 1
// Checksum 0x3379b1a2, Offset: 0xebbb
// Size: 0x32
function function_2374da3eb027daa0( var_21c50c9aa2e59321 )
{
    factor = math::normalize_value( 300, 1000, var_21c50c9aa2e59321 );
    return math::factor_value( 7, 25, factor );
}

// Namespace mtx_weapon
// Params 3
// Checksum 0xc142b2ea, Offset: 0xebf6
// Size: 0x75
function function_558c7bcb43027f21( movetime, timepassed, offsetmax )
{
    if ( timepassed > movetime )
    {
        return 1;
    }
    
    halfmovetime = movetime * 0.5;
    
    if ( timepassed > halfmovetime )
    {
        frac = ( timepassed - halfmovetime ) / halfmovetime;
    }
    else
    {
        frac = timepassed / halfmovetime;
        frac = 1 - frac;
    }
    
    frac *= frac;
    frac = 1 - frac;
    return frac * offsetmax;
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0xe5f43376, Offset: 0xec74
// Size: 0x6d
function private souleatersuccess()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    function_c80dc1fc69011a01( #"reactive_soul_collect" );
    self.var_ba0fee1a3d02f016[ #"souls_collected_count" ]++;
    
    if ( function_cffba97fa52b9199( self.currentweapon ) )
    {
        function_9b97bd8af57bf2a1();
    }
    
    wait 0.3;
    function_950d6b4e4595768f( #"reactive_soul_collect_1stage" );
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x6133cdbb, Offset: 0xece9
// Size: 0x21
function private souleaterfail( soulent )
{
    soulent setscriptablepartstate( #"soulEater", "vanish" );
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x7387d72b, Offset: 0xed12
// Size: 0x11c
function private unlinkequipment( corpstable )
{
    linkedchildren = corpstable getlinkedchildren();
    
    foreach ( child in linkedchildren )
    {
        if ( child.iscrossbowbolt )
        {
            child crossbow::boltunlink();
        }
        
        if ( isdefined( child.equipmentref ) )
        {
            switch ( child.equipmentref )
            {
                case #"hash_8df9cfc147eb2d86":
                case #"hash_9ba0a6ff6081954e":
                case #"hash_d3a6dc7f9c517e66":
                case #"hash_de4641ddbc44a7ba":
                case #"hash_e156752cb79526e8":
                case #"hash_f0907f858c134cb4":
                    child unlink();
                    break;
                default:
                    break;
            }
        }
    }
}

// Namespace mtx_weapon
// Params 2, eflags: 0x4
// Checksum 0x18ef4b62, Offset: 0xee36
// Size: 0xa1
function private function_2b1f4efb0ccea208( ent, movetime )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    delay_time = ( movetime - 300 ) / 1000;
    wait delay_time;
    
    if ( getomnvar( "ui_firing_range_has_started" ) == 1 )
    {
        self playsound( #"iw9_weap_mtx_souleater_absorb" );
        return;
    }
    
    if ( isdefined( self.team ) )
    {
        self playsoundtoteam( #"iw9_weap_mtx_souleater_absorb", self.team, undefined, self );
        return;
    }
    
    self playsoundtoplayer( #"iw9_weap_mtx_souleater_absorb", self );
}

// Namespace mtx_weapon
// Params 1
// Checksum 0xecf75f94, Offset: 0xeedf
// Size: 0xaa
function function_bb6fc6aabe552b3b( params )
{
    if ( getdvarint( @"hash_cde633441920a939", 0 ) == 1 )
    {
        return;
    }
    
    if ( isdefined( self.var_234701a4011bbeed ) )
    {
        function_cbbd53b75b2e4905( self.var_89f056c02c511bec, self.var_234701a4011bbeed );
    }
    
    if ( !isdefined( self.operatorcustomization ) || self.operatorcustomization.execution != "jup_mp_execution_thyme_01" && self.operatorcustomization.execution != "jup_mp_execution_thyme_sage_01" )
    {
        return;
    }
    
    self notify( #"mimic_restart" );
    thread function_8d03dfd9b0369bbe();
    thread function_b1966d7e3804ad18();
}

// Namespace mtx_weapon
// Params 0
// Checksum 0xafdd75c8, Offset: 0xef91
// Size: 0x7a
function function_8d03dfd9b0369bbe()
{
    var_53afa5ed5ab849c5 = utility::getsharedfunc( #"customization", #"getoperatorcustomization" );
    
    if ( !isdefined( var_53afa5ed5ab849c5 ) )
    {
        return;
    }
    
    if ( isdefined( self.mimicoriginal ) )
    {
        return;
    }
    
    self [[ var_53afa5ed5ab849c5 ]]();
    self.var_89f056c02c511bec = self.operatorcustomization.operatorref;
    self.var_234701a4011bbeed = self.operatorcustomization.skinref;
}

// Namespace mtx_weapon
// Params 2
// Checksum 0x708e26b6, Offset: 0xf013
// Size: 0xba
function function_cbbd53b75b2e4905( operator, skin )
{
    var_4926928b0d22ff9d = utility::getsharedfunc( #"customization", #"setcharactermodels" );
    
    if ( !isdefined( var_4926928b0d22ff9d ) )
    {
        return;
    }
    
    models = operator::function_fb2ad6ca3c6b708d( skin );
    operator::function_44f7d464da13e4f6( operator, skin );
    self [[ var_4926928b0d22ff9d ]]( models[ 0 ], models[ 1 ], models[ 2 ] );
    reactive = operator::getreactiveoperator( skin );
    
    if ( isdefined( self.operatorcustomization ) )
    {
        self.operatorcustomization.reactiveoperator = reactive;
    }
    
    if ( isdefined( reactive ) )
    {
        self function_184d7ec010cfaa92( reactive );
        return;
    }
    
    self function_16332a7775f10aa9();
}

// Namespace mtx_weapon
// Params 0
// Checksum 0x38c57ad5, Offset: 0xf0d5
// Size: 0x2d
function mtx_mimic_execution_cancelled_watcher()
{
    self endon( #"mtx_mimic_got_a_kill" );
    
    while ( true )
    {
        if ( !self isinexecutionattack() )
        {
            self notify( #"mtx_mimic_execution_cancelled" );
            return;
        }
        
        waitframe();
    }
}

// Namespace mtx_weapon
// Params 2
// Checksum 0x870fb2ba, Offset: 0xf10a
// Size: 0x91
function function_f344e4a0bc2dbc5( operator, skin )
{
    self endon( #"mtx_mimic_execution_cancelled" );
    
    while ( true )
    {
        self waittill( #"got_a_kill", victim, sweapon, meansofdeath );
        
        if ( meansofdeath != "MOD_EXECUTION" || !isplayer( victim ) && !isbot( victim ) )
        {
            continue;
        }
        
        function_cbbd53b75b2e4905( operator, skin );
        self notify( #"mtx_mimic_got_a_kill" );
        return;
    }
}

// Namespace mtx_weapon
// Params 0
// Checksum 0xe1d0783c, Offset: 0xf1a3
// Size: 0x177
function function_b1966d7e3804ad18()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"mimic_restart" );
    var_53afa5ed5ab849c5 = utility::getsharedfunc( #"customization", #"getoperatorcustomization" );
    
    if ( !isdefined( var_53afa5ed5ab849c5 ) )
    {
        return;
    }
    
    while ( true )
    {
        self waittill( #"execution_begin", victim );
        
        if ( !isdefined( victim ) || !isplayer( victim ) && !isbot( victim ) )
        {
            continue;
        }
        
        if ( issubstr( self.suit, "juggernaut" ) )
        {
            continue;
        }
        
        executionref = self.executionref;
        
        if ( !isdefined( executionref ) && isdefined( self.operatorcustomization ) )
        {
            executionref = self.operatorcustomization.execution;
        }
        
        if ( executionref != "jup_mp_execution_thyme_01" && self.operatorcustomization.execution != "jup_mp_execution_thyme_sage_01" )
        {
            continue;
        }
        
        victim [[ var_53afa5ed5ab849c5 ]]();
        self function_d8a8c316c2436b4b( self.operatorcustomization.skinref, 1 );
        childthread mtx_mimic_execution_cancelled_watcher();
        childthread function_f344e4a0bc2dbc5( self.operatorcustomization.operatorref, self.operatorcustomization.skinref );
        utility::waittill_any( "mtx_mimic_execution_cancelled", "mtx_mimic_got_a_kill" );
    }
}

// Namespace mtx_weapon
// Params 6, eflags: 0x4
// Checksum 0x777e5e04, Offset: 0xf322
// Size: 0x52
function private function_cffb5550ecd2e3eb( corpstable, limbfx, torsofx, headfx, sfx, deletebody = 1 )
{
    weapon_utility::playdeathvfx( self, corpstable, limbfx, torsofx, headfx, sfx, deletebody );
}

// Namespace mtx_weapon
// Params 2, eflags: 0x4
// Checksum 0xd477297, Offset: 0xf37c
// Size: 0x4d
function private function_47e3b72d9cc335d0( corpstable, state )
{
    if ( corpstable isscriptable() && corpstable getscriptablehaspart( "mtxDeath" ) && corpstable getscriptableparthasstate( "mtxDeath", state ) )
    {
        corpstable setscriptablepartstate( "mtxDeath", state, 0 );
    }
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x6cd7bf6a, Offset: 0xf3d1
// Size: 0x115
function private function_1c00c343fc5ff4d1( hitloc )
{
    tag = #"j_spinelower";
    
    if ( hitloc == "head" || hitloc == "helmet" || hitloc == "neck" )
    {
        tag = #"j_head";
    }
    else if ( hitloc == "right_arm_upper" || hitloc == "right_arm_lower" || hitloc == "right_hand" )
    {
        tag = #"j_shoulder_ri";
    }
    else if ( hitloc == "left_arm_upper" || hitloc == "left_arm_lower" || hitloc == "left_hand" )
    {
        tag = #"j_shoulder_le";
    }
    else if ( hitloc == "right_leg_upper" || hitloc == "right_leg_lower" || hitloc == "right_foot" )
    {
        tag = #"j_hip_ri";
    }
    else if ( hitloc == "left_leg_upper" || hitloc == "left_leg_lower" || hitloc == "left_foot" )
    {
        tag = #"j_hip_le";
    }
    
    return tag;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x33e5f47c, Offset: 0xf4ef
// Size: 0x1b, Type: bool
function private isheavymeleedamage( damageflags )
{
    return isdefined( damageflags ) && damageflags & 131072;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xf5eb73a1, Offset: 0xf513
// Size: 0x22
function private function_ce6577f1ddc5d04e( value )
{
    self.var_ba0fee1a3d02f016[ #"mtx_scriptable_charm_state" ] = value;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0xb84a8ea0, Offset: 0xf53d
// Size: 0x22
function private function_849d75d167d2df2f( value )
{
    self.var_ba0fee1a3d02f016[ #"mtx_scriptable_gunscreen_state" ] = value;
}

// Namespace mtx_weapon
// Params 2, eflags: 0x4
// Checksum 0x6dcbf64c, Offset: 0xf567
// Size: 0x46
function private function_97bf7c711098ca98( name, value )
{
    if ( !isdefined( self.var_ba0fee1a3d02f016[ #"mtx_scriptable_reactive_ids" ][ name ] ) )
    {
        self.var_ba0fee1a3d02f016[ #"mtx_scriptable_reactive_ids" ][ name ] = value;
    }
}

// Namespace mtx_weapon
// Params 2, eflags: 0x4
// Checksum 0x7bdf658f, Offset: 0xf5b5
// Size: 0x4e
function private function_b282f58365d0a8eb( name, value )
{
    if ( !isdefined( self.var_ba0fee1a3d02f016[ #"mtx_scriptable_toggle_ids" ][ name ] ) )
    {
        self.var_ba0fee1a3d02f016[ #"mtx_scriptable_toggle_ids" ][ name ] = #"toggle0";
    }
}

// Namespace mtx_weapon
// Params 2, eflags: 0x4
// Checksum 0x2e38f33, Offset: 0xf60b
// Size: 0x23
function private function_745383dc254e8178( name, value )
{
    self.var_ba0fee1a3d02f016[ name ] = value;
}

// Namespace mtx_weapon
// Params 0, eflags: 0x4
// Checksum 0x3f7a9cb, Offset: 0xf636
// Size: 0xa7
function private function_826a1744af715c95()
{
    self.var_ba0fee1a3d02f016[ #"kill_streak" ] = 0;
    self.var_ba0fee1a3d02f016[ #"downgradable_kill_streak" ] = 0;
    self.var_ba0fee1a3d02f016[ #"reactive_kills" ] = self.var_ba0fee1a3d02f016[ #"match_kills" ];
    self.var_ba0fee1a3d02f016[ #"kill_streak_weapon" ] = [];
    self.var_ba0fee1a3d02f016[ #"all_scriptable_disablers" ] = [];
    self.var_ba0fee1a3d02f016[ #"direct_scriptable_disablers" ] = [];
    self.var_ba0fee1a3d02f016[ #"souls_collected_count" ] = 0;
}

// Namespace mtx_weapon
// Params 2, eflags: 0x4
// Checksum 0xf57c7b58, Offset: 0xf6e5
// Size: 0x20, Type: bool
function private shouldkillcycle( currentkills, targetkills )
{
    if ( currentkills >= targetkills )
    {
        return true;
    }
    
    return false;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x2ca20ace, Offset: 0xf70e
// Size: 0x19
function private killcycleincrement( ref )
{
    self.var_ba0fee1a3d02f016[ ref ]++;
}

// Namespace mtx_weapon
// Params 1, eflags: 0x4
// Checksum 0x14d97dc, Offset: 0xf72f
// Size: 0x1a
function private killcyclereset( ref )
{
    self.var_ba0fee1a3d02f016[ ref ] = 0;
}

/#

    // Namespace mtx_weapon
    // Params 0, eflags: 0x4
    // Checksum 0xab0990ac, Offset: 0xf751
    // Size: 0x323, Type: dev
    function private function_c62e09e8e68ca737()
    {
        setdvar( @"hash_a0c0a5bf060c7bf2", -1 );
        setdvar( @"hash_e5d7c5b83ec14d85", -1 );
        setdvar( @"hash_cefbf3b030b375ab", -1 );
        setdvar( @"hash_eac0e1ad1567fd42", -1 );
        setdvar( @"hash_cf86c6012f506ac8", -1 );
        setdvar( @"hash_6b3c6361f0f5fdb", -1 );
        setdvar( @"hash_beff73861be066d", -1 );
        setdvar( @"hash_4db0d2c2cd85d418", -1 );
        setdvar( @"hash_2391c05a8700227f", -1 );
        setdvar( @"hash_e001a97b368816c9", -1 );
        setdvar( @"hash_8d73f9a1e40b4f01", -1 );
        setdvar( @"hash_2ebdafd7eec10a70", -1 );
        setdvar( @"hash_51dcebb527f3dd9b", -1 );
        setdvar( @"hash_399fdd0fb6b02227", -1 );
        setdvar( @"hash_317afde463e47a0e", -1 );
        setdvar( @"hash_d5bfe694a8598141", -1 );
        setdvar( @"hash_d5b99091b7c0443e", -1 );
        var_75e3436453aef910 = -1;
        var_ca0bfad57e9cc43d = -1;
        var_e810d76c7c3efd1a = -1;
        var_c706aa344ded9407 = -1;
        var_14c052148d620505 = -1;
        souleaterstate = -1;
        movementstate = -1;
        var_8810972a8c451fde = -1;
        var_4e8a4c9a9f1fc = -1;
        var_39360cb55490c06 = -1;
        spawnstate = -1;
        
        while ( true )
        {
            var_75e3436453aef910 = function_66a3efb40d32649( #"reactive_match_kills_2stage", @"hash_a0c0a5bf060c7bf2", var_75e3436453aef910 );
            var_ca0bfad57e9cc43d = function_66a3efb40d32649( #"reactive_kill_streak_2stage", @"hash_e5d7c5b83ec14d85", var_ca0bfad57e9cc43d );
            var_e810d76c7c3efd1a = function_66a3efb40d32649( #"reactive_kill_streak_3stage", @"hash_cefbf3b030b375ab", var_e810d76c7c3efd1a );
            var_c706aa344ded9407 = function_66a3efb40d32649( #"reactive_kill_streak_4stage", @"hash_eac0e1ad1567fd42", var_c706aa344ded9407 );
            var_14c052148d620505 = function_66a3efb40d32649( #"reactive_kill_weapon_3stage", @"hash_6b3c6361f0f5fdb", var_14c052148d620505 );
            souleaterstate = function_66a3efb40d32649( #"reactive_soul_collect_1stage", @"hash_cf86c6012f506ac8", souleaterstate );
            movementstate = function_66a3efb40d32649( #"reactive_movement", @"hash_beff73861be066d", movementstate );
            var_4e8a4c9a9f1fc = function_66a3efb40d32649( #"reactive_enchantment", @"hash_8d73f9a1e40b4f01", var_4e8a4c9a9f1fc );
            var_8810972a8c451fde = function_66a3efb40d32649( #"reactive_downgradable_kill_streak_3stage", @"hash_e001a97b368816c9", var_8810972a8c451fde );
            var_39360cb55490c06 = function_66a3efb40d32649( #"reactive_kill_cycle_3stage", @"hash_51dcebb527f3dd9b", var_39360cb55490c06 );
            spawnstate = function_66a3efb40d32649( #"reactive_spawn", @"hash_399fdd0fb6b02227", spawnstate );
            function_4d0321755fadbee2( #"reactive_kill", @"hash_4db0d2c2cd85d418" );
            function_4d0321755fadbee2( #"reactive_soul_collect", @"hash_2391c05a8700227f" );
            function_4d0321755fadbee2( #"reactive_damage_received", @"hash_317afde463e47a0e" );
            waitframe();
        }
    }

    // Namespace mtx_weapon
    // Params 3, eflags: 0x4
    // Checksum 0xd42f48b, Offset: 0xfa7c
    // Size: 0xae, Type: dev
    function private function_66a3efb40d32649( key, dvar, var_74436294d8157c13 )
    {
        if ( getdvarint( dvar ) != var_74436294d8157c13 )
        {
            foreach ( player in level.players )
            {
                player function_950d6b4e4595768f( key );
            }
        }
        
        return getdvarint( dvar );
    }

    // Namespace mtx_weapon
    // Params 2, eflags: 0x4
    // Checksum 0x48fd54b9, Offset: 0xfb32
    // Size: 0xa7, Type: dev
    function private function_4d0321755fadbee2( key, dvar )
    {
        if ( getdvarint( dvar ) > -1 )
        {
            foreach ( player in level.players )
            {
                player function_c80dc1fc69011a01( key );
            }
        }
        
        setdvar( dvar, -1 );
    }

#/

// Namespace mtx_weapon
// Params 2, eflags: 0x4
// Checksum 0xc0034383, Offset: 0xfbe1
// Size: 0x36
function private function_494e1db9cf223798( corpstable, hitloc )
{
    if ( hitloc == "head" && isdismembermentenabled() )
    {
        function_47e3b72d9cc335d0( corpstable, "halloweenHeadpop" );
    }
}

