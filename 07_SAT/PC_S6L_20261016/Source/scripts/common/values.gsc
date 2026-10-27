// scripts\common\values.gsc  (hash_3b64eb40368c1450.gscc) (size: 71635 Bytes / 0x117d3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x30740842 (812910658)
// size ...... 71635 (0x117d3)
// includes .. 10  (offset: 0xfd13)
// strings ... 314 (offset: 0xfd63)
// dev strs .. 50  (offset: 0x11523)
// exports ... 276 (offset: 0x921b)
// cseg ...... 0x18de + 0x793d (0x921b)
// imports ... 507 (offset: 0xbd3b)
// animtree1 . 0   (offset: 0x117d3)
// animtree2 . 0   (offset: 0x117d3)
#using script_16ea1b94f0f381b3;
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\hud_util;
#using scripts\common\omnvar_utility;
#using scripts\common\string;
#using scripts\common\system;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\common\vehicle;

#namespace val;

// Namespace val
// Params 0, eflags: 0x5
// Checksum 0x16da0e92, Offset: 0x18fc
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"val", undefined, &pre_main, undefined );
}

// Namespace val
// Params 0
// Checksum 0xbda9210f, Offset: 0x191d
// Size: 0x1ea8
function pre_main()
{
    if ( isdefined( level.values_pre_main ) )
    {
        return;
    }
    
    level.values_pre_main = 1;
    register( "breath_system", 1, 0, "$self", &set_breath_system, "$value" );
    register( "damage", 1, 0, "$self", &set_allow_damage, "$value" );
    register( "death", 1, 0, "$self", &set_allow_death, "$value" );
    register( "damageshield", 0, 1, "$self", &set_damage_shield, "$value" );
    register( "damageshield_allow_delete", 0, 1, "$self", &function_3989c921a5ce2836, "$value" );
    register( "damageshield_allow_quest_kill", 0, 1, "$self", &function_2cc84418ce760d76, "$value" );
    register( "deathShieldThreshold", -1, -1, "$self", &function_c24a1bd2d82db73d, "$value" );
    register( "trigger_hurt_damage", 1, 0, "$self", &set_allow_trigger_hurt_damage, "$value" );
    register( "interacts_with_oob_triggers", 1, 0 );
    register( "ignoresuppression", 0, 1, "$self", &set_ignore_suppression, "$value" );
    register( "whizby", 1, 0 );
    register( "dontevershoot", 0, 1, "$self", &function_2551fdd9c40d52f3, "$value" );
    register( "disabledropfromcombat", 0, 1, "$self", &function_a1cfac759300de04, "$value" );
    register( "dontmeleeme", 0, 1, "$self", &function_d57d9fe126620696, "$value" );
    register( "ignoreme", 0, 1, "$self", &set_ignore_me, "$value" );
    register( "ignoreall", 0, 1, "$self", &set_ignore_all, "$value" );
    register( "take_weapons", 0, 1, "$self", &set_takeweapons, "$value" );
    register( "weapon", 1, 0, "$self", &set_allow_weapons, "$value" );
    register( "weapon_switch", 1, 0, "$self", &set_allow_weapon_switch, "$value" );
    register( "weapon_switch_clip", 1, 0, "$self", &function_69663cfde5a760c0, "$value" );
    register( "script_weapon_switch", 0, 1 );
    register( "reload", 1, 0, "$self", &function_774a7b576d576eac, "$value" );
    register( "reload_speed", 1, 1, "$self", &function_a72eede1b3cfd014, "$value" );
    register( "weapon_pickup", 1, 0, "$self", &function_e208c91eb84ed565, "$value" );
    register( "fire", 1, 0, "$self", &function_14a1b35a268ca4b9, "$value" );
    register( "weapon_motion", 1, 0, "$self", &function_5547a4a6e441ba87, "$value" );
    register( "weapon_motion_ik", 1, 0, "$self", &function_d7a1169db9553b28, "$value" );
    register( "autoreload", 1, 0, "$self", &function_1fd9d609b5af3807, "$value" );
    register( "weapon_first_raise_anims", 1, 0, "$self", &function_f61e0e9b7270852f, "$value" );
    register( "weapon_inspect", 1, 0, "$self", &set_allow_weapon_inspect, "$value" );
    register( "offhand_weapons", 1, 0, "$self", &function_a1162f2424489dd0, "$value" );
    register( "force_enable_offhand_sprays", 0, 0, "$self", &set_force_enable_offhand_sprays, "$value" );
    register( "toggle_remote_revive", 0, 1, "$self", &set_remote_revive, "$value" );
    register( "toggle_remote_self_revive", 0, 1, "$self", &set_remote_self_revive, "$value" );
    register( "ignore_afk", 0, 1, "$self", &set_self_ignore_afk, "$value" );
    register( "dont_evolve", 0, 1, "$self", &set_dont_evolve, "$value" );
    register( "item_pickup", 1, 0, "$self", &set_allow_item_pickup, "$value" );
    register( "disallow_weapon_wallbuy", 0, 1, "$self", &disallow_weapon_wallbuy, "$value" );
    register( "disallow_wallbuy", 0, 1, "$self", &disallow_wallbuy, "$value" );
    register( "disallow_magicbox", 0, 1, "$self", &disallow_magicbox, "$value" );
    register( "ignore_blackhole_bomb", 0, 1, "$self", &set_ignore_blackhole_bomb, "$value" );
    
    if ( !isdefined( level.ismp ) || level.ismp == 0 )
    {
        link( "offhand_weapons", "offhand_shield_weapons" );
    }
    
    register( "offhand_primary_weapons", 1, 0, "$self", &function_62d014caf91572e2, "$value" );
    register( "offhand_secondary_weapons", 1, 0, "$self", &function_36cea73c3b5fd96e, "$value" );
    link( "offhand_secondary_weapons", "offhand_shield_weapons" );
    register( "offhand_shield_weapons", 1, 0, "$self", &function_20012a3279532ca5, "$value" );
    register( "offhand_throwback", 1, 0, "$self", &set_allow_offhand_throwback, "$value" );
    register( "allow_offhand_special", 1, 0, "$self", &set_allow_offhand_special, "$value" );
    register( "allow_aim_assist", 1, 0, "$self", &set_allow_aim_assist, "$value" );
    register( "usability", 1, 0, "$self", &set_allow_usability, "$value" );
    register( "disallow_loot_but_auto_loot", 0, 1, "$self", &disallow_loot_but_auto_loot, "$value" );
    register( "disallow_usability_but_loot", 0, 1, "$self", &disallow_usability_but_loot, "$value" );
    register( "disallow_cache_use", 0, 1, "$self" );
    register( "powerup_pickup", 1, 0, "$self" );
    register( "freezecontrols", 0, 1, "$self", &set_freeze_controls, "$value" );
    register( "freezecontrols_allowlook", 0, 1, "$self", &function_d9233b319f90661, "$value" );
    register( "hide", 0, 1, "$self", &set_hide, "$value" );
    register( "non_deletable", 0, 1, "$self", &set_non_deletable, "$value" );
    register( "health_regen", 1, 0, "$self", &set_health_regen, "$value" );
    register( "allow_health_regen_delay", 1, 0, "$self", &set_allow_health_regen_delay, "$value" );
    register( "ignore_health_regen_delay", 0, 1, "$self", &set_ignore_health_regen_delay, "$value" );
    register( "allow_last_stand", 0, 0 );
    register( "stealth_social_reveal", 0, 1, "$self", &set_social_reveal, "$value" );
    register( "show_hud", 1, 0, "$self", &set_hud_visible, "$value" );
    register( "show_weapon_hud", 1, 0, "$self", &set_weapon_hud_visible, "$value" );
    register( "show_dpad_hud", 1, 0, "$self", &function_c5e5bd6fb67422ed, "$value" );
    register( "show_targetmarker", 1, 0, "$self", &set_targetmarker_visible, "$value" );
    register( "world_fade", 0, 1, "$self", &set_world_fade, "$value", 0 );
    register( "total_fade", 0, 1, "$self", &set_total_fade, "$value", 0 );
    register( "hide_danger_indicator", 0, 1, "$self", &set_hide_danger_indicator, "$value" );
    register( "allow_jump", 1, 0, "$self", &set_allowjump, "$value" );
    register( "allow_double_jump", 1, 0, "$self", &set_allowdoublejump, "$value" );
    register( "crouch", 1, 0, "$self", &set_allowcrouch, "$value" );
    register( "prone", 1, 0, "$self", &set_allowprone, "$value" );
    register( "stance_change", 1, 0, "$self", &function_1ae65704940e4424, "$value" );
    register( "melee", 1, 0, "$self", &set_allowmelee, "$value" );
    register( "lean", 1, 0, "$self", &set_allowlean, "$value" );
    register( "allow_melee_victim", 1, 0, "$self", &allow_melee_victim, "$value" );
    register( "mantle", 1, 0, "$self", &set_allowmantle, "$value" );
    register( "ledgehang", 1, 0, "$self", &function_5e9e3b2f69f6f529, "$value" );
    register( "mount_top", 1, 0, "$self", &set_allowmounttop, "$value" );
    register( "mount_side", 1, 0, "$self", &set_allowmountside, "$value" );
    register( "sprint", 1, 0, "$self", &set_allowsprint, "$value" );
    register( "jog", 1, 0, "$self", &set_allowjog, "$value" );
    register( "ads", 1, 0, "$self", &set_allowads, "$value" );
    register( "stand", 1, 0, "$self", &set_allowstand, "$value" );
    register( "allow_movement", 1, 0, "$self", &set_allowmovement, "$value" );
    register( "ladder", 1, 0, "$self", &set_allowladder, "$value" );
    register( "swimming", 1, 0, "$self", &function_a8117c7579bc7929, "$value" );
    register( "swimming_underwater", 1, 0, "$self", &function_7ab726a64720c8a4, "$value" );
    register( "swimming_sprint", 1, 0, "$self", &function_48acf32c9c54465c, "$value" );
    register( "swimming_jump", 1, 0, "$self", &function_115021318817a3e4, "$value" );
    register( "base_jumping", 1, 0, "$self", &function_a4ce58974995b16f, "$value" );
    register( "dtp", 1, 0, "$self", &function_1c864094a7f7b03c, "$value" );
    register( "allow_thrusters", 1, 0, "$self", &function_f345c8f327eec46e, "$value" );
    register( "desired_speed", 0, 0, "$self", &set_desiredspeed, "$value" );
    register( "goalradius", 2048, 2048, "$self", &function_cc381b7879a5f0d6, "$value" );
    register( "push_player", 0, 1, "$self", &set_pushplayer, "$value" );
    register( "skip_death", 0, 1, "$self", &set_skip_death, "$value" );
    register( "skip_scene_death", 0, 1, "$self", &set_skip_scene_death, "$value" );
    register( "supers", 1, 0, "$self", &set_allow_supers, "$value" );
    register( "super_pickup", 1, 1, "$self", &set_allow_super_pickup, "$value" );
    register( "super_switching", 1, 0, "$self", &set_allow_super_switching, "$value" );
    register( "wallrun", 1, 0, "$self", &set_allow_wallrun, "$value" );
    register( "doublejump", 1, 0, "$self", &set_allow_doublejump, "$value" );
    register( "slide", 1, 0, "$self", &set_allow_slide, "$value" );
    register( "scripted_melee", 1, 0, "$self", &set_allow_scripted_melee, "$value" );
    register( "execution_attack", 1, 0, "$self", &set_allow_execution_attack, "$value" );
    register( "execution_victim", 1, 0, "$self", &set_allow_execution_victim, "$value" );
    register( "meatshield_attacker", 1, 0, "$self", &set_allow_meatshield_attacker, "$value" );
    register( "meatshield_victim", 1, 0, "$self", &set_allow_meatshield_victim, "$value" );
    register( "heavy_melee_execution_victim", 1, 0, "$self", &set_allow_heavy_melee_execution_victim, "$value" );
    register( "vehicle_use", 1, 0, "$self", &set_allow_vehicle_use, "$value" );
    register( "vehicle_lean_out", 1, 0, "$self", &set_allow_vehicle_lean_out, "$value" );
    register( "vehicle_seat_switch", 1, 0, "$self", &set_allow_vehicle_seat_switch, "$value" );
    register( "vehicle_exit", 1, 0 );
    register( "vehicle_predictive_ragdoll", 1, 0, "$self", &set_allow_vehicle_predictive_ragdoll, "$value" );
    register( "nvg", 1, 0, "$self", &function_bb0d10ecbfbeaeb9, "$value" );
    register( "supersprint", 1, 0, "$self", &set_allow_supersprint, "$value" );
    register( "shellshock", 1, 0, "$self", &set_allow_shellshock, "$value" );
    register( "cinematic_motion", 1, 0, "$self", &set_allow_cinematic_motion, "$value" );
    register( "armor", 1, 0, "$self", &set_allow_armor, "$value" );
    register( "door_frozen", 0, 1, "$self", &set_door_frozen, "$value" );
    register( "interactions", 1, 0, "$self", &set_allow_interactions, "$value" );
    register( "action_slot_weapon", 1, 0, "$self", &set_allow_action_slot_weapon, "$value" );
    register( "disallow_body_carry", 0, 1, "$self", &set_disallow_body_carry, "$value" );
    register( "disallow_body_shield", 0, 1, "$self", &set_disallow_body_shield, "$value" );
    register( "no_bullet_miss_fx", 0, 1, "$self", &function_f01949d7ffcf11f7, "$value" );
    register( "allow_wall_jump", 1, 1, "$self", &function_df742befdf77ed04, "$value" );
    register( "allow_active_roll", 1, 1, "$self", &function_21ceb22acb454b71, "$value" );
    register( "allow_meleegrapple", 0, 0, "$self", &set_allowmeleegrapple, "$value" );
    register( "allow_throwweapon", 1, 0, "$self", &function_2df100288e495588, "$value" );
    register( "allow_free_fire", 0, 0, "$self", &function_38e816a25d06e176, "$value" );
    register( "move_speed_scale", 1, 1, "$self", &set_movespeedscale, "$value" );
    register( "move_speed_scale_mult", 1, 1, "$self", &set_movespeedscalemult, "$value" );
    link( "move_speed_scale", "move_speed_scale_mult", undefined, 1 );
    register( "equipment_primary", 1, 0, "$self", &set_allow_equipment_primary, "$value" );
    register( "equipment_secondary", 1, 0, "$self", &set_allow_equipment_secondary, "$value" );
    register( "overlord_locked_priority", 0, 0, "$self", &set_overlord_locked_priority, "$value" );
    register( "backpack_inventory", 1, 0, "$self", &set_allow_backpack_inventory, "$value" );
    register( "tacmap_scoreboard", 1, 0, "$self", &set_allow_tacmap_scoreboard, "$value" );
    register( "demeanor", "", "", "$self", &set_demeanor, "$value" );
    register( "pain", 1, 0, "$self", &set_allow_pain, "$value" );
    register( "special_pain", 1, 0, "$self", &set_allow_special_pain, "$value" );
    register( "infinite_ammo", 0, 1, "$self", &set_infinite_ammo, "$value" );
    register( "kill_on_damage", 0, 0, "$self", &set_kill_on_damage, "$value" );
    register( "reduce_damage_effects", 0, 0, "$self", &set_reduce_damage_effects, "$value" );
    register( "collide_with_players", 1, 1, "$self", &set_solid_collide_with_players, "$value" );
    register( "ignore_ascender_collision", 0, 0, "$self", &set_ignore_ascender_collision, "$value" );
    register( "skydive_force_script_collide", 0, 0, "$self", &set_skydive_force_script_collide, "$value" );
    register( "collide_with_ai_allies", 1, 0, "$self", &set_collide_with_ai_allies, "$value" );
    register( "collide_with_ai_allies_smaller", 1, 0, "$self", &function_d85355fb917b4bdd, "$value" );
    register( "script_pushable_by_ai", 1, 0, "$self", &function_a7120a590add6c5a, "$value" );
    register( "script_pushable", 1, 0, "$self", &set_script_pushable, "$value" );
    register( "hide_operator_backpack", 0, 1, "$self", &set_hide_operator_backpack, "$value" );
    register( "show_operator_pet", 1, 0, "$self", &set_show_operator_pet, "$value" );
    register( "allow_give_point", 1, 1, "$self", &set_allow_give_point, "$value" );
    register( "allow_give_super_point", 1, 1, "$self", &set_allow_give_super_point, "$value" );
    register( "pause_zombie_spawning", 0, 0, "$self", &set_pause_zombie_spawning, "$value" );
    register( "show_healthbar", 1, 1, "$self", &set_show_healthbar, "$value" );
    register( "force_show_healthbar_distance", 0, 300, "$self", &function_9f3b98d1081b9f, "$value" );
    register( "play_ambient_vo", 1, 1, "$self", &set_ambient_vo, "$value" );
    register( "allow_vo", 1, 1, "$self", &set_allow_vo, "$value" );
    register( "toggle_eye_glow", 1, 1, "$self", &toggle_zmb_eye_glow, "$value" );
    register( "allow_unreachable_attack", 1, 1, "$self", &set_allow_unreachable_attack, "$value" );
    register( "trial_logic_activate", 1, 1, "$self", &set_trial_logic_activate, "$value" );
    register( "task_logic_activate", 1, 1, "$self", &set_task_logic_activate, "$value" );
    register( "allow_combat_attractors", 1, 1, "$self", &set_allow_combat_attractors, "$value" );
    register( "slide_boost", 1, 1 );
    register( "ignore_playable_area_check", 0, 1 );
    register( "allow_zm_perks", 1, 1, "$self", &set_allow_perks, "$value" );
    register( "show_perks", 1, 1, "$self", &set_show_perks, "$value" );
    register( "show_perk_decay", 1, 1, "$self", &set_perk_decay, "$value" );
    register( "show_quest_ui", 1, 1, "$self", &set_show_quest_ui, "$value" );
    register( "show_trials_ui", 1, 1, "$self", &set_show_trials_ui, "$value" );
    register( "allow_reload_without_reserve_ammo", 0, 0, "$self", &set_allow_reload_without_reserve_ammo, "$value" );
    register( "allow_reload_when_clip_full", 0, 0, "$self", &set_allow_reload_when_clip_full, "$value" );
    register( "allow_full_ammo_powerup", 1, 1, "$self", &set_allow_full_ammo, "$value" );
    register( "attackeraccuracy", 1, 1, "$self", &set_attacker_accuracy, "$value" );
    register( "ascender_use", 1, 0 );
    register( "crate_use", 1, 0 );
    register( "cough_gesture", 1, 0 );
    register( "ladder_placement", 1, 0 );
    register( "allow_consumables", 1, 0 );
    register( "killstreaks", 1, 0, "$self", &function_a887952f6b595ba4, [ "killstreaks", "$value" ] );
    register( "remote_killstreaks", 1, 0, "$self", &function_a887952f6b595ba4, [ "remote_killstreaks", "$value" ] );
    register( "one_hit_melee_victim", 1, 0 );
    register( "flashed", 1, 0 );
    register( "stunned", 1, 0 );
    register( "stick_kill", 1, 0 );
    register( "unresolved_collisions", 1, 0 );
    register( "allow_toggle_third_person", 1, 0, "$self", &set_allow_third_person_toggle, "$value" );
    register( "wounded_movement", 1, 0, "$self", &set_wounded_movement, "$value" );
    register( "allow_ping", 1, 0, "$self", &set_allow_ping, "$value" );
    register( "disallow_knockdown", 0, 1, "$self", &set_disallow_knockdown, "$value" );
    register( "disallow_stun", 0, 1, "$self", &set_disallow_stun, "$value" );
    register( "postpone_stun", 0, 1, "$self", &set_postpone_stun, "$value" );
    register( "disallow_despawn", 0, 1, "$self", &set_disallow_despawn, "$value" );
    register( "disallow_bloat", 0, 1, "$self", &set_disallow_bloat, "$value" );
    register( "postpone_vortex_pull", 0, 1, "$self", &set_postpone_vortex_pull, "$value" );
    register( "disallow_slow", 0, 1, "$self", &set_disallow_slow, "$value" );
    register( "ignore_ai_collision", 0, 1, "$self", &set_ignore_ai_collision, "$value" );
    register( "ammomod_immune", 0, 1, "$self", &set_ammomod_immune, "$value" );
    register( "shadow_rift_lethal_tele_immune", 0, 1, "$self", &set_shadow_rift_lethal_tele_immune, "$value" );
    register( "ignore_instakill_powerup", 0, 1, "$self", &set_ignore_instakill_powerup, "$value" );
    register( "allow_dismember", 1, 0, "$self", &function_8c020e6b3e6f4762, "$value" );
    register( "allow_secondary_attack_damage", 1, 0, "$self", &function_d7aa041f31d7e32f, "$value" );
    register( "ignore_cleanup", 0, 0, "$self", &function_ef6599a498d90267, "$value" );
    register( "cleanup_dist_override", undefined, undefined, "$self", &function_ed3094fbf0019db1, "$value" );
    register( "round_spawning_ignore_player", 0, 0, "$self", &function_19b7ea3ee49651d7, "$value" );
    register( "cinematics_participant", 0, 1, "$self", &set_participating_cinematics, "$value" );
    register( "overlord_speaker", "", "", "$self", &set_overlord_speaker, "$value" );
    register( "ai_corpse_sync", 0, 1, "$self", &function_2e0d6f33b91fc4f0, "$value" );
    register( "show_stealth_indicator", 1, 1, "$self", &set_show_stealth_indicators, "$value" );
    register( "show_ui_objectives", 0, 1, "$self", &set_show_ui_objectives, "$value" );
    register( "show_ui_gasmask_overlay", 0, 1, "$self", &function_1dee1f1db2f63c5f, "$value" );
    register( "enable_nuke_flash_and_sound", 1, 1, "$self", &function_8da692007ff8058f, "$value" );
    register( "show_ui_out_of_bounds", 0, 1, "$self", &set_show_ui_out_of_bounds, "$value" );
    register( "cast_shadow", 1, 0, "$self", &function_61ad072a9fc2be42, "$value" );
    register( "allow_grab", 1, 0 );
    register( "allow_brot", 1, 1 );
    register( "allow_melee_me", 1, 1, "$self", &set_allow_melee_me, "$value" );
    register( "look_behavior", "", "", "$self", &set_look_behavior, "$value" );
    register( "allow_compass_messaging", 1, 0, "$self", &function_a887952f6b595ba4, [ "allow_compass_messaging", "$value" ] );
    register( "ai_lightweight", 0, 1, "$self", &set_ai_lightweight, "$value" );
    register( "lerp_fov_scale", [ 1, 0.25 ], [ 0, 0.25 ], "$self", &set_lerp_fov_scale, "$value" );
    register( "xp_scale", 1, 1, "$self", &set_xp_scale, "$value" );
    register( "allow_scripted_bgb_use", 1, 0, "$self", &set_allow_scripted_bgb_use, "$value" );
    register( "allow_revive_teammate", 1, 0 );
    register( "damage_knockback", 1, 1 );
    group_register( "allow_hud_in_cinematic_sequence", [ "show_hud", "show_hud_names", "cg_drawcrosshair" ] );
    register( "allow_emote", 1, 0 );
    register( "bypass_saving_throws", 0, 0 );
    register( "w_mod_ignore_target", 0, 1 );
    register( "allow_teleport", 1, 1 );
    register( "allow_exfil", 1, 1 );
    register( "in_interactive_UI", 0, 1, "$self", &function_a887952f6b595ba4, [ "in_interactive_UI", "$value" ] );
    register( "allow_change_zombie_eye_glow", 1, 1 );
    register( "atak", 1, 1 );
    register( "disable_elemental_effect", 0, 0 );
    
    foreach ( val in [ "allow_equipment_wheel", "allow_spy_cam", "allow_interactive_map", "allow_lockpick", "allow_keypad_puzzle", "allow_frequency_puzzle", "allow_cipher_puzzle", "allow_skill_select", "allow_reward_select", "allow_connection_puzzle" ] )
    {
        register( val, 1, 0, "$self", &function_a887952f6b595ba4, [ val, "$value" ] );
    }
    
    register( "high_net_lod", 0, 1, "$self", &set_high_net_lod, "$value" );
    register( "ks_dont_forget", 0, 0, "$self", &set_ks_dont_forget, "$value" );
    register( "ai_eventlist", "", "", undefined, &set_ai_eventlist, "$value" );
    register( "stealth_ttlt_lkp", 8000, 8000, "$self", &set_ttlt_lkp, "$value" );
    register( "stealth_ttlt_not_lkp", 3000, 3000, "$self", &function_458fa5173d52d835, "$value" );
    register( "default_time_to_drop_threat_sight", 10000, 10000, "$self", &set_drop_threat_sight, "$value" );
    register( "global_esc_total_combat_time", -1, -1, "$self", &function_19800d31ca9a012e, "$value" );
    register( "global_esc_percent_threshold", 0.8, 0.8, "$self", &function_e3ffb01ce831f16a, "$value" );
    register( "vehicle_disallow_lockon", 0, 1, "$self", &set_vehicle_disallow_lockon, "$value" );
    register( "ignore_triggers", 0, 1, "$self", &set_ignore_triggers, "$value" );
    register( "hide_stowed_weapon", 0, 1, "$self", &set_hide_stowed_weapon, "$value" );
    register( "allow_battlechatter_vo", 1, 1, "$self", &set_allow_battlechatter_vo, "$value" );
    register( "fire_time_scale", -1, 100, "$self", &set_firetimescale, "$value" );
    register( "zombie_damage_to_player_multiplier", 1, 1, "$self", &set_zombie_damage_to_player_multiplier, "$value" );
    register( "damage_protection_omnvar", "", "", "$self", &set_damage_protection_omnvar, "$value" );
    register( "damage_protection_pgb_post_fx", "", "", "$self", &function_3caa771970487b66, "$value" );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_228e40841793f3bb", &function_9f44c474895e8804 );
    
    /#
        level thread debug_values();
        validate( "<dev string:x24>", "<dev string:x2b>", &validate_allow_damage );
        validate( "<dev string:x31>", "<dev string:x2b>", &function_f38faee63109c0a7 );
        validate( "<dev string:x37>", "<dev string:x2b>", &function_bba57c2f7dfb0704 );
        validate( "<dev string:x44>", "<dev string:x2b>", &function_3c1ac553b8892be8 );
        validate( "<dev string:x5e>", "<dev string:x2b>", &function_3494b36da8305b6c );
    #/
}

// Namespace val
// Params 7
// Checksum 0x2e2e53, Offset: 0x37cd
// Size: 0x138
function register( str_name, default_value, default_set_value, call_on, func, args, var_595adb29a2481183 )
{
    assert( isstring( str_name ) );
    
    if ( !isdefined( level.values_ref ) )
    {
        level.values_ref = [];
    }
    
    if ( isdefined( level.values_ref[ str_name ] ) )
    {
        assertmsg( "<dev string:x7c>" + str_name + "<dev string:x84>" );
        return;
    }
    
    if ( isdefined( args ) )
    {
        if ( !isarray( args ) )
        {
            args = [ args ];
        }
        
        if ( args.size == 1 && args[ 0 ] == "$value" )
        {
            args = undefined;
        }
    }
    
    level.values_ref[ str_name ] = { #on_set_handlers:[], #var_595adb29a2481183:var_595adb29a2481183 ?? 1, #a_args:args, #default_set_value:default_set_value, #default_value:default_value, #func:func, #call_on:call_on == "$self" ? undefined : call_on, #str_name:str_name };
}

// Namespace val
// Params 1
// Checksum 0x22db1aa6, Offset: 0x390d
// Size: 0x25
function unregister( str_name )
{
    if ( isdefined( level.values_ref ) )
    {
        level.values_ref[ str_name ] = undefined;
    }
}

// Namespace val
// Params 1
// Checksum 0x1d652264, Offset: 0x393a
// Size: 0x19, Type: bool
function is_registered( str_name )
{
    return isdefined( level.values_ref[ str_name ] );
}

// Namespace val
// Params 2
// Checksum 0x2982f56a, Offset: 0x395c
// Size: 0x39
function group_register( group_name, value_names )
{
    if ( !isdefined( level.value_groups ) )
    {
        level.value_groups = [];
    }
    
    level.value_groups[ group_name ] = value_names;
}

// Namespace val
// Params 2
// Checksum 0xd220feab, Offset: 0x399d
// Size: 0x65
function group_set( group_name, value )
{
    assert( isdefined( level.value_groups[ group_name ] ), "<dev string:x9a>" + group_name + "<dev string:xc7>" );
    str_id = "_group_" + group_name;
    set_array( str_id, level.value_groups[ group_name ], value );
}

// Namespace val
// Params 1
// Checksum 0xad289121, Offset: 0x3a0a
// Size: 0x29
function group_reset( group_name )
{
    str_id = "_group_" + group_name;
    reset_all( str_id );
}

// Namespace val
// Params 4
// Checksum 0xff5f384e, Offset: 0x3a3b
// Size: 0x9b
function default_func( str_name, call_on, value, args )
{
    if ( isdefined( level.values_ref[ str_name ] ) )
    {
        if ( isdefined( args ) && !isarray( args ) )
        {
            args = [ args ];
        }
        
        if ( !isdefined( args ) )
        {
            args = [];
        }
        
        s_value = level.values_ref[ str_name ];
        s_value.default_call_on = call_on;
        s_value.default_value = value;
        s_value.default_args = args;
    }
}

// Namespace val
// Params 4
// Checksum 0x82d94a92, Offset: 0x3ade
// Size: 0x90
function link( str_name, str_link_name, func, type = 0 )
{
    if ( isdefined( level.values_ref[ str_name ] ) )
    {
        s_value = level.values_ref[ str_name ];
        s_value.links[ str_link_name ] = { #type:type, #func:func ?? &simple_link, #name:str_link_name };
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xe6060204, Offset: 0x3b76
// Size: 0xe
function private simple_link( b_value )
{
    return b_value;
}

// Namespace val
// Params 2
// Checksum 0xc51f92e6, Offset: 0x3b8d
// Size: 0x55
function register_on_set_handler( str_name, handler )
{
    if ( isdefined( level.values_ref[ str_name ] ) )
    {
        level.values_ref[ str_name ].on_set_handlers[ level.values_ref[ str_name ].on_set_handlers.size ] = handler;
    }
}

// Namespace val
// Params 2
// Checksum 0x14708f20, Offset: 0x3bea
// Size: 0x57
function function_ec802d0a95cd1144( str_name, handler )
{
    if ( isdefined( level.values_ref[ str_name ] ) )
    {
        level.values_ref[ str_name ].on_set_handlers = arrayremove( level.values_ref[ str_name ].on_set_handlers, handler );
    }
}

// Namespace val
// Params 3
// Checksum 0x1799ed31, Offset: 0x3c49
// Size: 0x17f
function set( str_id, str_name, value )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( level.values_ref[ str_name ] ) )
    {
        if ( !isdefined( value ) )
        {
            value = level.values_ref[ str_name ].default_set_value;
        }
        
        push_value( str_id, str_name, value );
        set_value( str_name, value );
        links = level.values_ref[ str_name ].links;
        
        if ( isarray( links ) )
        {
            foreach ( s_link in links )
            {
                switch ( s_link.type )
                {
                    case 0:
                        set( str_id, s_link.name, [[ s_link.func ]]( value ) );
                        break;
                    case 1:
                        set( str_id, s_link.name, [[ s_link.func ]]( get( s_link.name ) ) );
                        break;
                }
            }
        }
    }
}

// Namespace val
// Params 3
// Checksum 0x827da8a4, Offset: 0x3dd0
// Size: 0x92
function set_array( str_id, str_name_array, value )
{
    foreach ( str_name in str_name_array )
    {
        set( str_id, str_name, value );
    }
}

// Namespace val
// Params 2
// Checksum 0x927ebbfd, Offset: 0x3e6a
// Size: 0x88
function reset_array( str_id, str_name_array )
{
    foreach ( str_name in str_name_array )
    {
        reset( str_id, str_name );
    }
}

// Namespace val
// Params 2
// Checksum 0xd41fd49d, Offset: 0x3efa
// Size: 0x159
function get_ignore_ids( str_name, var_dfccd81e6793f145 )
{
    if ( isdefined( level.values_ref[ str_name ] ) )
    {
        if ( isdefined( self.values[ str_name ] ) )
        {
            if ( self.values[ str_name ].size )
            {
                saved_vals = self.values[ str_name ];
                
                foreach ( str_id, val in self.values[ str_name ] )
                {
                    foreach ( ignore_id in var_dfccd81e6793f145 )
                    {
                        if ( str_id == ignore_id )
                        {
                            saved_vals[ str_id ] = undefined;
                        }
                    }
                }
                
                if ( saved_vals.size )
                {
                    return saved_vals[ getlastarraykey( saved_vals ) ];
                }
            }
        }
        
        return get_default( str_name );
    }
}

// Namespace val
// Params 2
// Checksum 0x6239fef4, Offset: 0x405b
// Size: 0x4f
function get_specific_id( str_name, str_id )
{
    if ( isdefined( level.values_ref[ str_name ] ) )
    {
        valuestates = self.values[ str_name ];
        
        if ( isdefined( valuestates ) && valuestates.size )
        {
            return valuestates[ str_id ];
        }
    }
}

// Namespace val
// Params 1
// Checksum 0xe3241b40, Offset: 0x40b2
// Size: 0x53
function get( str_name )
{
    if ( isdefined( level.values_ref[ str_name ] ) )
    {
        valuestates = self.values[ str_name ];
        
        if ( isdefined( valuestates ) && valuestates.size )
        {
            return valuestates[ getlastarraykey( valuestates ) ];
        }
        
        return get_default( str_name );
    }
}

// Namespace val
// Params 2
// Checksum 0x892c8075, Offset: 0x410d
// Size: 0x24
function set_radiant( str_name, value )
{
    set( "radiant", str_name, value );
}

// Namespace val
// Params 4
// Checksum 0x483f12d7, Offset: 0x4139
// Size: 0x4b
function set_for_time( n_time, str_id, str_name, value )
{
    self endon( #"death" );
    set( str_id, str_name, value );
    wait n_time;
    reset( str_id, str_name );
}

// Namespace val
// Params 2
// Checksum 0xbca3e984, Offset: 0x418c
// Size: 0x29
function reset( str_id, str_name )
{
    remove_value( str_id, str_name );
    reset_internal( str_id, str_name );
}

// Namespace val
// Params 2, eflags: 0x4
// Checksum 0x4806833c, Offset: 0x41bd
// Size: 0x127
function private reset_internal( str_id, str_name )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    valuestates = self.values[ str_name ];
    lastkey = undefined;
    
    if ( isdefined( valuestates ) )
    {
        lastkey = getlastarraykey( valuestates );
        
        if ( isdefined( lastkey ) )
        {
            value = valuestates[ lastkey ];
            set_value( str_name, value );
        }
    }
    
    if ( !isdefined( lastkey ) )
    {
        set_default( str_name );
    }
    
    if ( isarray( level.values_ref[ str_name ].links ) )
    {
        foreach ( s_link in level.values_ref[ str_name ].links )
        {
            reset( str_id, s_link.name );
        }
    }
}

// Namespace val
// Params 1
// Checksum 0x9aae9f5f, Offset: 0x42ec
// Size: 0xcf
function reset_all( str_id )
{
    if ( !( isdefined( self ) && isdefined( self.values ) ) )
    {
        return;
    }
    
    foreach ( str_name, valuestates in self.values )
    {
        lastkey = getlastarraykey( valuestates );
        
        if ( isdefined( self.values[ str_name ] ) )
        {
            self.values[ str_name ][ str_id ] = undefined;
        }
        
        if ( lastkey === str_id )
        {
            reset_internal( str_id, str_name );
        }
    }
}

// Namespace val
// Params 1
// Checksum 0x310f3f00, Offset: 0x43c3
// Size: 0x1a
function reset_radiant( str_name )
{
    reset( "radiant", str_name );
}

// Namespace val
// Params 1
// Checksum 0xb26743f9, Offset: 0x43e5
// Size: 0x47
function nuke( str_name )
{
    if ( isdefined( self.values ) )
    {
        self.values[ str_name ] = undefined;
    }
    
    if ( level.values_ref[ str_name ].var_595adb29a2481183 )
    {
        set_default( str_name );
    }
}

// Namespace val
// Params 0
// Checksum 0x7b2bbffc, Offset: 0x4434
// Size: 0xfb
function nuke_all()
{
    if ( !isdefined( self.values ) )
    {
        return;
    }
    
    str_name_list = [];
    
    foreach ( str_name, value in self.values )
    {
        str_name_list[ str_name_list.size ] = str_name;
    }
    
    foreach ( str_name in str_name_list )
    {
        nuke( str_name );
    }
}

// Namespace val
// Params 1
// Checksum 0xad7b294, Offset: 0x4537
// Size: 0x192
function log_value( str_name )
{
    self_log = isent( self ) ? "Entity " + self getentitynumber() : "self";
    
    if ( !isdefined( self.values ) )
    {
        logstring( "[LOG_VALUE] " + self_log + " does not contain any values" );
        return;
    }
    
    if ( !isdefined( str_name ) )
    {
        logstring( "[LOG_VALUE] " + self_log + " contains the following values:" );
        
        foreach ( name, value_array in self.values )
        {
            if ( value_array.size > 0 )
            {
                log_value( name );
            }
        }
        
        return;
    }
    
    logstring( "[LOG_VALUE]     Logging IDs and Value for type:" + str_name );
    
    foreach ( key, value in self.values[ str_name ] )
    {
        if ( isdefined( key ) && isdefined( value ) )
        {
            logstring( "[LOG_VALUE]         ID: " + key + " -- Value: " + value );
        }
    }
}

// Namespace val
// Params 3, eflags: 0x4
// Checksum 0x8a04b7bf, Offset: 0x46d1
// Size: 0x68
function private push_value( str_id, str_name, value )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.values ) )
    {
        self.values = [];
    }
    
    if ( !isdefined( self.values[ str_name ] ) )
    {
        self.values[ str_name ] = [];
    }
    
    self.values[ str_name ][ str_id ] = value;
}

// Namespace val
// Params 2, eflags: 0x4
// Checksum 0x387dd37, Offset: 0x4741
// Size: 0x6f
function private remove_value( str_id, str_name )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( self.values[ str_name ] ) )
    {
        self.values[ str_name ][ str_id ] = undefined;
        
        if ( !self.values[ str_name ].size )
        {
            self.values[ str_name ] = undefined;
            
            if ( !self.values.size )
            {
                self.values = undefined;
            }
        }
    }
}

// Namespace val
// Params 2, eflags: 0x4
// Checksum 0x16fabdb9, Offset: 0x47b8
// Size: 0x134
function private set_value( str_name, value )
{
    if ( isplayer( self ) )
    {
        self endon( #"disconnect" );
    }
    
    s_value = level.values_ref[ str_name ];
    
    if ( isdefined( s_value.func ) )
    {
        call_on = s_value.call_on ?? self;
        
        if ( isdefined( s_value.a_args ) )
        {
            utility::single_func_argarray( call_on, s_value.func, replace_values( s_value.a_args, value ) );
        }
        else
        {
            call_on [[ s_value.func ]]( value );
        }
    }
    
    foreach ( handler in level.values_ref[ str_name ].on_set_handlers )
    {
        [[ handler ]]( value );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x80b12e51, Offset: 0x48f4
// Size: 0xb5
function private get_default( str_name )
{
    default_value = undefined;
    s_value = level.values_ref[ str_name ];
    
    if ( isdefined( s_value.default_value ) )
    {
        if ( isfunction( s_value.default_value ) )
        {
            call_on = s_value.default_call_on == "$self" ? self : s_value.default_call_on;
            default_value = utility::single_func_argarray( call_on, s_value.default_value, replace_values( s_value.default_args ) );
        }
        else
        {
            default_value = s_value.default_value;
        }
    }
    
    return default_value;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xc0a70e80, Offset: 0x49b2
// Size: 0x30
function private set_default( str_name )
{
    default_value = get_default( str_name );
    
    if ( isdefined( default_value ) )
    {
        set_value( str_name, default_value );
    }
}

// Namespace val
// Params 3, eflags: 0x4
// Checksum 0x5ea9654f, Offset: 0x49ea
// Size: 0xa8
function private function_de40350986e56615( array, str_value, replacement )
{
    array = arraycopy( array );
    
    foreach ( i, val in array )
    {
        if ( isstring( val ) && val == str_value )
        {
            array[ i ] = replacement;
        }
    }
    
    return array;
}

// Namespace val
// Params 2, eflags: 0x4
// Checksum 0xf421166b, Offset: 0x4a9b
// Size: 0x3e
function private replace_values( a_args, value )
{
    if ( isdefined( a_args ) )
    {
        a_args = function_de40350986e56615( a_args, "$self", self );
        a_args = function_de40350986e56615( a_args, "$value", value );
    }
    
    return a_args;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x442ef4b2, Offset: 0x4ae2
// Size: 0x135
function private function_9f44c474895e8804( params )
{
    str_name = params[ 0 ];
    
    foreach ( player in level.players )
    {
        player log_value( str_name );
    }
    
    ai_array = getaiarray();
    
    foreach ( ai in ai_array )
    {
        logstring( "[LOG_VALUE] Logging AI (" + ai getentitynumber() + ") of aitype: " + ai.agent_type );
        ai log_value( str_name );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xcf4c41e9, Offset: 0x4c1f
// Size: 0x6e
function private set_allow_damage( b_value = 0 )
{
    if ( isplayer( self ) )
    {
        if ( utility::issp() )
        {
            if ( b_value )
            {
                self disableinvulnerability();
            }
            else
            {
                self enableinvulnerability();
            }
        }
        else if ( level.var_c998633bab11f3f8 )
        {
            self.takedamage = b_value;
        }
        else
        {
            /#
                iprintln( "<dev string:xc9>" );
            #/
        }
        
        return;
    }
    
    self setcandamage( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x62ea0b86, Offset: 0x4c95
// Size: 0x31
function private set_allow_trigger_hurt_damage( b_value = 0 )
{
    if ( b_value )
    {
        self.b_skip_trigger_hurt_damage = undefined;
        return;
    }
    
    self.b_skip_trigger_hurt_damage = 1;
}

// Namespace val
// Params 0, eflags: 0x4
// Checksum 0xfa9024e0, Offset: 0x4cce
// Size: 0x1a
function private validate_allow_damage()
{
    if ( isplayer( self ) )
    {
        return !self isinvulnerable();
    }
    
    return self getcandamage();
}

// Namespace val
// Params 1
// Checksum 0x2b53db02, Offset: 0x4cf0
// Size: 0x4f
function set_allow_death( b_value = 0 )
{
    if ( isdefined( self.deathshieldfunc ) )
    {
        self [[ self.deathshieldfunc ]]( !b_value );
    }
    
    if ( isagent( self ) )
    {
        self.var_62591663e6a187ce = b_value;
    }
    
    self.allowdeath = b_value;
}

// Namespace val
// Params 0, eflags: 0x4
// Checksum 0x605aebc5, Offset: 0x4d47
// Size: 0xb
function private function_f38faee63109c0a7()
{
    return self.allowdeath;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x3f1bfa7d, Offset: 0x4d5b
// Size: 0x20
function private set_damage_shield( b_value = 1 )
{
    self.damageshield = b_value;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x375caae3, Offset: 0x4d83
// Size: 0x20
function private function_3989c921a5ce2836( b_value = 1 )
{
    self.var_28b46b2e5b442ef3 = b_value;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x83d528d3, Offset: 0x4dab
// Size: 0x20
function private function_2cc84418ce760d76( b_value = 1 )
{
    self.var_23e899b240b64709 = b_value;
}

// Namespace val
// Params 0, eflags: 0x4
// Checksum 0xe8dcc714, Offset: 0x4dd3
// Size: 0xb
function private function_bba57c2f7dfb0704()
{
    return self.damageshield;
}

// Namespace val
// Params 0, eflags: 0x4
// Checksum 0xa8cbf5a0, Offset: 0x4de7
// Size: 0xb
function private function_3c1ac553b8892be8()
{
    return self.var_28b46b2e5b442ef3;
}

// Namespace val
// Params 0, eflags: 0x4
// Checksum 0x54e3833d, Offset: 0x4dfb
// Size: 0xb
function private function_3494b36da8305b6c()
{
    return self.var_23e899b240b64709;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x8c5f7a8, Offset: 0x4e0f
// Size: 0x34
function private function_c24a1bd2d82db73d( b_value = undefined )
{
    self.deathshieldthreshold = isnumber( b_value ) && b_value >= 0 ? b_value : undefined;
}

// Namespace val
// Params 0, eflags: 0x4
// Checksum 0xcfab87de, Offset: 0x4e4b
// Size: 0x7
function private function_5ebabb94fa03eaa7()
{
    return self islookcontrolsfrozen();
}

// Namespace val
// Params 1
// Checksum 0x626d3e07, Offset: 0x4e5b
// Size: 0x1f
function set_ignore_suppression( b_value = 0 )
{
    self.ignoresuppression = b_value;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x725af91c, Offset: 0x4e82
// Size: 0x188
function private set_takeweapons_thread( b_value )
{
    self notify( #"set_takeweapons_thread" );
    self endon( #"set_takeweapons_thread" );
    self endon( #"death_or_disconnect" );
    wait level.framedurationseconds * 3;
    
    if ( b_value )
    {
        if ( !isdefined( self.val_takeweapons ) )
        {
            self.val_takeweapons = { #current:self getcurrentweapon(), #weapons:self getweaponslistall() };
        }
        
        self takeallweapons();
        return;
    }
    
    if ( isdefined( self.val_takeweapons ) )
    {
        weaponselect = self.val_takeweapons.current;
        fallbackprimary = undefined;
        
        foreach ( weapon in self.val_takeweapons.weapons )
        {
            self giveweapon( weapon );
            
            if ( !isdefined( fallbackprimary ) && weapon.type == "bullet" )
            {
                fallbackprimary = weapon;
            }
        }
        
        if ( isdefined( fallbackprimary ) && weaponselect.basename == "none" )
        {
            weaponselect = fallbackprimary;
        }
        
        self switchtoweaponimmediate( weaponselect );
        self.val_takeweapons = undefined;
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x9e2087c6, Offset: 0x5012
// Size: 0x71
function private set_takeweapons( b_value = 1 )
{
    if ( isplayer( self ) )
    {
        thread set_takeweapons_thread( b_value );
        return;
    }
    
    if ( b_value )
    {
        ai::gun_remove();
        
        if ( isdefined( anim.var_5458eb88a5c60307 ) )
        {
            self [[ anim.var_5458eb88a5c60307 ]]();
        }
        
        return;
    }
    
    ai::gun_recall();
    
    if ( isdefined( anim.var_a539877b0796cf31 ) )
    {
        self [[ anim.var_a539877b0796cf31 ]]();
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x2f27350c, Offset: 0x508b
// Size: 0x62
function private set_allow_weapons( value = 0 )
{
    if ( value != 1 )
    {
        self disableweapons();
        
        if ( isdefined( level.allow_weapon_mp ) )
        {
            self [[ level.allow_weapon_mp ]]( 0 );
        }
        
        return;
    }
    
    self enableweapons();
    
    if ( isdefined( level.allow_weapon_mp ) )
    {
        self [[ level.allow_weapon_mp ]]( 1 );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x66df1073, Offset: 0x50f5
// Size: 0x28
function private set_allow_weapon_switch( b_value = 0 )
{
    if ( b_value )
    {
        self enableweaponswitch();
        return;
    }
    
    self disableweaponswitch();
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x8e2abe4b, Offset: 0x5125
// Size: 0x2b
function private function_69663cfde5a760c0( b_value = 0 )
{
    if ( b_value )
    {
        self disableemptyclipweaponswitch( 0 );
        return;
    }
    
    self disableemptyclipweaponswitch( 1 );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xfb09c71a, Offset: 0x5158
// Size: 0x2b
function private function_14a1b35a268ca4b9( b_value = 0 )
{
    if ( b_value )
    {
        self allowfire( 1 );
        return;
    }
    
    self allowfire( 0 );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x998c1966, Offset: 0x518b
// Size: 0x2b
function private function_5547a4a6e441ba87( b_value = 0 )
{
    if ( b_value )
    {
        self function_4936e2e9ac3c9825( 1 );
        return;
    }
    
    self function_4936e2e9ac3c9825( 0 );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x55864cb, Offset: 0x51be
// Size: 0x40
function private function_d7a1169db9553b28( b_value = 0 )
{
    assert( isplayer( self ) );
    assert( utility::issp() );
    setsaveddvar( @"hash_4f25696e26f5208b", !b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xef2eb8df, Offset: 0x5206
// Size: 0x7c
function private function_774a7b576d576eac( b_value = 0 )
{
    if ( b_value != 1 )
    {
        self allowreload( 0 );
        
        if ( b_value != -1 )
        {
            self cancelreload();
            telemetrydata = { #reloadcanceltime:getsystemtimeinmicroseconds(), #cancelreason:"ENTER_VEHICLE", #player:self };
            telemetry_utils::function_af2d366f9522f76f( "callback_on_reload_cancel", telemetrydata );
        }
        
        return;
    }
    
    self allowreload( 1 );
}

// Namespace val
// Params 1
// Checksum 0x2ae56437, Offset: 0x528a
// Size: 0x10c
function function_a72eede1b3cfd014( value = 1 )
{
    assert( isplayer( self ) );
    assert( utility::issp() );
    scale = 1;
    valuestates = self.values[ "reload_speed" ];
    
    if ( isdefined( valuestates ) && valuestates.size )
    {
        foreach ( value in valuestates )
        {
            scale *= float( value );
        }
    }
    
    setsaveddvar( @"perk_weapreloadmultiplier", scale );
    
    if ( scale != 1 )
    {
        self setperk( "specialty_fastreload", 1 );
        return;
    }
    
    self unsetperk( "specialty_fastreload", 1 );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xb0d53eb, Offset: 0x539e
// Size: 0x28
function private function_e208c91eb84ed565( b_value = 0 )
{
    if ( b_value )
    {
        self enableweaponpickup();
        return;
    }
    
    self disableweaponpickup();
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x57039e89, Offset: 0x53ce
// Size: 0x28
function private function_1fd9d609b5af3807( b_value = 0 )
{
    if ( b_value )
    {
        self enableautoreload();
        return;
    }
    
    self disableautoreload();
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x2ca12467, Offset: 0x53fe
// Size: 0x28
function private function_a1162f2424489dd0( b_value = 0 )
{
    if ( b_value )
    {
        self enableoffhandweapons();
        return;
    }
    
    self disableoffhandweapons();
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xcca38af, Offset: 0x542e
// Size: 0x28
function private function_62d014caf91572e2( b_value = 0 )
{
    if ( b_value )
    {
        self enableoffhandprimaryweapons();
        return;
    }
    
    self disableoffhandprimaryweapons();
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xc232b77d, Offset: 0x545e
// Size: 0x28
function private function_36cea73c3b5fd96e( b_value = 0 )
{
    if ( b_value )
    {
        self enableoffhandsecondaryweapons();
        return;
    }
    
    self disableoffhandsecondaryweapons();
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x5a5c127c, Offset: 0x548e
// Size: 0x1c
function private function_20012a3279532ca5( b_value = 0 )
{
    self allowoffhandshieldweapons( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x24c3c694, Offset: 0x54b2
// Size: 0x29
function private set_allow_offhand_throwback( b_value = 1 )
{
    if ( b_value )
    {
        self enableoffhandthrowback();
        return;
    }
    
    self disableoffhandthrowback();
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xcb2c4f63, Offset: 0x54e3
// Size: 0x19
function private set_allow_offhand_special( b_value )
{
    assertmsg( "<dev string:x13d>" );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x2957415a, Offset: 0x5504
// Size: 0x1c
function private set_force_enable_offhand_sprays( b_value = 0 )
{
    self function_9d8fefb12cdb497c( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xe21568fd, Offset: 0x5528
// Size: 0x3d
function private set_allow_aim_assist( b_value = 0 )
{
    if ( utility::issp() )
    {
        self setaimassistdisabled( !b_value );
        return;
    }
    
    if ( b_value )
    {
        self enableaimassist();
        return;
    }
    
    self disableaimassist();
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xab297afe, Offset: 0x556d
// Size: 0x36
function private set_allow_usability( b_value = 0 )
{
    if ( b_value )
    {
        self enableusability();
    }
    else
    {
        self disableusability();
    }
    
    self notify( #"usability", b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xbf17c3f7, Offset: 0x55ab
// Size: 0x29
function private disallow_loot_but_auto_loot( b_value = 1 )
{
    if ( b_value )
    {
        self function_604255f312e3443e();
        return;
    }
    
    self function_5326242d9dc65aed();
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x8f351edc, Offset: 0x55dc
// Size: 0x29
function private disallow_usability_but_loot( b_value = 1 )
{
    if ( b_value )
    {
        self function_b57dcb79e0b62bb5();
        return;
    }
    
    self function_a2dc8e29134063ac();
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x623c8b35, Offset: 0x560d
// Size: 0x32
function private set_dont_evolve( b_value = 1 )
{
    if ( b_value )
    {
        self.dont_evolve = 1;
        return;
    }
    
    self.dont_evolve = undefined;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x3ee36f74, Offset: 0x5647
// Size: 0x20
function private set_allow_item_pickup( b_value = 0 )
{
    self.var_84b0d4b6eb9e7cbc = istrue( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xb1852c8b, Offset: 0x566f
// Size: 0x21
function private disallow_weapon_wallbuy( b_value = 1 )
{
    self.var_83480e7607063d3f = istrue( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x66f2d727, Offset: 0x5698
// Size: 0x21
function private disallow_wallbuy( b_value = 1 )
{
    self.var_e830497a1d286f74 = istrue( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x3343b1e3, Offset: 0x56c1
// Size: 0x21
function private disallow_magicbox( b_value = 1 )
{
    self.var_432159241a2f9367 = istrue( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xb8a478b0, Offset: 0x56ea
// Size: 0x21
function private set_ignore_blackhole_bomb( b_value = 1 )
{
    self.var_19238dbcc969affa = !b_value;
}

// Namespace val
// Params 1
// Checksum 0x54d6eeea, Offset: 0x5713
// Size: 0x47
function set_remote_revive( b_value = 1 )
{
    if ( b_value )
    {
        self.var_73fc3c02a3004c94 = 1;
        self.usingremoterevive = 1;
        return;
    }
    
    self.var_73fc3c02a3004c94 = undefined;
    self.usingremoterevive = undefined;
}

// Namespace val
// Params 1
// Checksum 0xc7e13415, Offset: 0x5762
// Size: 0x32
function set_remote_self_revive( b_value = 1 )
{
    if ( b_value )
    {
        self.var_885f2644ce3eb19e = 1;
        return;
    }
    
    self.var_885f2644ce3eb19e = undefined;
}

// Namespace val
// Params 1
// Checksum 0xa5f96eff, Offset: 0x579c
// Size: 0x32
function set_self_ignore_afk( b_value = 1 )
{
    if ( b_value )
    {
        self.ignoreafkcheck = b_value;
        return;
    }
    
    self.ignoreafkcheck = undefined;
}

// Namespace val
// Params 1
// Checksum 0x63fa789a, Offset: 0x57d6
// Size: 0x20
function set_ignore_me( b_value = 1 )
{
    self.ignoreme = b_value;
}

// Namespace val
// Params 1
// Checksum 0xdf6b71bc, Offset: 0x57fe
// Size: 0x3f
function function_2551fdd9c40d52f3( b_value = 1 )
{
    assert( !isplayer( self ), "<dev string:x167>" + "<dev string:x185>" + "<dev string:x18a>" );
    self.dontevershoot = b_value;
}

// Namespace val
// Params 1
// Checksum 0x67c04722, Offset: 0x5845
// Size: 0x31
function function_a1cfac759300de04( b_value = 0 )
{
    assert( isagent( self ), "<dev string:x197>" );
    self.disabledropfromcombat = b_value;
}

// Namespace val
// Params 1
// Checksum 0x7d0f3e3, Offset: 0x587e
// Size: 0x32
function function_d57d9fe126620696( b_value = 1 )
{
    assert( isplayer( self ), "<dev string:x1ea>" );
    self.dontmeleeme = b_value;
}

// Namespace val
// Params 1
// Checksum 0xaf375e65, Offset: 0x58b8
// Size: 0x20
function set_ignore_all( b_value = 1 )
{
    self.ignoreall = b_value;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x51f59a2, Offset: 0x58e0
// Size: 0x3f
function private set_show_hit_marker( b_value = 1 )
{
    assert( isplayer( self ) );
    
    if ( b_value )
    {
        self.nohitmarkers = undefined;
        return;
    }
    
    self.nohitmarkers = 1;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x2a2eb0ed, Offset: 0x5927
// Size: 0x124
function private set_hide( value = 1 )
{
    if ( isarray( value ) )
    {
        if ( !isplayer( self ) )
        {
            self hide();
        }
        
        foreach ( player in value )
        {
            if ( !isplayer( player ) )
            {
                continue;
            }
            
            if ( !isplayer( self ) )
            {
                self showtoplayer( player );
            }
        }
        
        return;
    }
    
    if ( value )
    {
        var_f097c55b7de07a4d = value == 2;
        
        if ( isplayer( self ) )
        {
            self playerhide( var_f097c55b7de07a4d );
        }
        else if ( isagent( self ) )
        {
            self invisiblenotsolid( var_f097c55b7de07a4d );
        }
        else
        {
            self hide( var_f097c55b7de07a4d );
        }
        
        return;
    }
    
    if ( isplayer( self ) )
    {
        self playershow();
        return;
    }
    
    if ( isagent( self ) )
    {
        self visiblesolid();
        return;
    }
    
    self show();
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x333c5f15, Offset: 0x5a53
// Size: 0x1d
function private set_non_deletable( b_value = 1 )
{
    self setnondeletable( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x5f1830ab, Offset: 0x5a78
// Size: 0x32
function private set_health_regen( b_value = 1 )
{
    if ( b_value )
    {
        self.disable_health_regen = undefined;
        return;
    }
    
    self.disable_health_regen = 1;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xee637066, Offset: 0x5ab2
// Size: 0x31
function private set_allow_health_regen_delay( b_value = 0 )
{
    if ( b_value )
    {
        self.disable_health_regen_delay = undefined;
        return;
    }
    
    self.disable_health_regen_delay = 1;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xce6a71e3, Offset: 0x5aeb
// Size: 0x32
function private set_ignore_health_regen_delay( b_value = 1 )
{
    if ( b_value )
    {
        self.ignore_health_regen_delay = 1;
        return;
    }
    
    self.ignore_health_regen_delay = 0;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xcc2eafe, Offset: 0x5b25
// Size: 0x8c
function private function_cc381b7879a5f0d6( val )
{
    if ( isdefined( val ) )
    {
        self.goalradius = val;
        return;
    }
    
    if ( isdefined( self.radius ) )
    {
        self.goalradius = float( self.radius );
        return;
    }
    
    if ( isdefined( self.spawner.radius ) )
    {
        self.goalradius = float( self.spawner.radius );
        return;
    }
    
    self.goalradius = 2048;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x4dde4fc6, Offset: 0x5bb9
// Size: 0x29
function private set_skip_death( b_value = 1 )
{
    self.skipdeath = b_value ? 1 : 0;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x9bfceceb, Offset: 0x5bea
// Size: 0x29
function private set_skip_scene_death( b_value = 1 )
{
    self.skipscenedeath = b_value ? 1 : undefined;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xfc34d9a1, Offset: 0x5c1b
// Size: 0x14
function private set_breath_system( b_allow )
{
    self enableplayerbreathsystem( b_allow );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xec9b19eb, Offset: 0x5c37
// Size: 0x14
function private set_freeze_controls( b_freeze )
{
    self freezecontrols( b_freeze );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xda892691, Offset: 0x5c53
// Size: 0x14
function private function_d9233b319f90661( b_freeze )
{
    self freezelookcontrols( b_freeze );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xcd79ae83, Offset: 0x5c6f
// Size: 0x50
function private set_social_reveal( b_value = 1 )
{
    if ( !utility::ent_flag_exist( "stealth_social_reveal" ) )
    {
        utility::ent_flag_init( "stealth_social_reveal" );
    }
    
    if ( b_value )
    {
        utility::ent_flag_set( "stealth_social_reveal" );
        return;
    }
    
    utility::ent_flag_clear( "stealth_social_reveal" );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x1cf86219, Offset: 0x5cc7
// Size: 0x30
function private set_hud_visible( b_value )
{
    if ( b_value )
    {
        b_value = 0;
    }
    else
    {
        b_value = 1;
    }
    
    if ( isplayer( self ) )
    {
        self setclientomnvar( "ui_hide_hud", b_value );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x6187ebab, Offset: 0x5cff
// Size: 0x30
function private set_weapon_hud_visible( b_value )
{
    if ( b_value )
    {
        b_value = 0;
    }
    else
    {
        b_value = 1;
    }
    
    if ( isplayer( self ) )
    {
        self setclientomnvar( "ui_hide_weapon_info", b_value );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xd5bb9c82, Offset: 0x5d37
// Size: 0x30
function private function_c5e5bd6fb67422ed( b_value )
{
    if ( b_value )
    {
        b_value = 0;
    }
    else
    {
        b_value = 1;
    }
    
    if ( isplayer( self ) )
    {
        self setclientomnvar( "ui_hide_dpad_hud", b_value );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xd3912c1b, Offset: 0x5d6f
// Size: 0x20
function private set_targetmarker_visible( b_value = 1 )
{
    self.var_c0f4dea5ee8c15f0 = b_value;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x5695403b, Offset: 0x5d97
// Size: 0x75
function private set_world_fade( f_value = 0 )
{
    if ( isplayer( self ) )
    {
        setval = clamp( get_max_value( "world_fade" ) ?? f_value, 0, 1 );
        
        if ( hasomnvar( "ui_world_fade" ) )
        {
            self setclientomnvar( "ui_world_fade", setval );
            return;
        }
        
        hud_util::fade_out( 0, "black", setval );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x5695403b, Offset: 0x5e14
// Size: 0x75
function private set_total_fade( f_value = 0 )
{
    if ( isplayer( self ) )
    {
        setval = clamp( get_max_value( "total_fade" ) ?? f_value, 0, 1 );
        
        if ( hasomnvar( "ui_total_fade" ) )
        {
            self setclientomnvar( "ui_total_fade", setval );
            return;
        }
        
        hud_util::fade_out( 0, "black", setval );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x3f4b717b, Offset: 0x5e91
// Size: 0x2e
function private set_hide_danger_indicator( b_value = 1 )
{
    if ( hasomnvar( "ui_hide_danger_indicator" ) )
    {
        self setclientomnvar( "ui_hide_danger_indicator", b_value );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xa70495f6, Offset: 0x5ec7
// Size: 0x29
function private allow_melee_victim( b_value = 1 )
{
    self.canbemeleed = b_value ? 1 : 0;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x10f049bd, Offset: 0x5ef8
// Size: 0x1d
function private set_allowjump( b_value = 1 )
{
    self allowjump( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x8386ede5, Offset: 0x5f1d
// Size: 0x1d
function private set_allowdoublejump( b_value = 1 )
{
    self allowdoublejump( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x7891768a, Offset: 0x5f42
// Size: 0x1d
function private set_allowcrouch( b_value = 1 )
{
    self allowcrouch( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x45acdb69, Offset: 0x5f67
// Size: 0x28
function private set_allowprone( b_value = 1 )
{
    self.var_b64b12f21408f6b3 = b_value;
    self allowprone( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xc512a9f6, Offset: 0x5f97
// Size: 0x143
function private function_1ae65704940e4424( b_value = 1 )
{
    if ( b_value )
    {
        if ( get( "stand" ) )
        {
            self allowstand( 1 );
        }
        
        if ( get( "crouch" ) )
        {
            self allowcrouch( 1 );
        }
        
        if ( get( "prone" ) )
        {
            self allowprone( 1 );
        }
        
        return;
    }
    
    current = self getstance();
    
    foreach ( stance in arrayremove( [ "stand", "crouch", "prone" ], current ) )
    {
        switch ( stance )
        {
            case #"hash_c6775c88e38f7803":
                self allowstand( 0 );
                break;
            case #"hash_3fed0cbd303639eb":
                self allowcrouch( 0 );
                break;
            case #"hash_d91940431ed7c605":
                self allowprone( 0 );
                break;
        }
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x52bc1146, Offset: 0x60e2
// Size: 0x1d
function private set_allowmelee( b_value = 1 )
{
    self allowmelee( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x10f049bd, Offset: 0x6107
// Size: 0x1c
function private set_allowlean( b_value = 0 )
{
    self allowlean( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x7891768a, Offset: 0x612b
// Size: 0x1d
function private set_allowmantle( b_value = 1 )
{
    self allowmantle( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x914f2c7, Offset: 0x6150
// Size: 0x1d
function private function_5e9e3b2f69f6f529( b_value = 1 )
{
    self allowledgehang( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x66bdd502, Offset: 0x6175
// Size: 0x1c
function private set_allowmounttop( b_value = 0 )
{
    self allowmounttop( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x914f2c7, Offset: 0x6199
// Size: 0x1c
function private set_allowmountside( b_value = 0 )
{
    self allowmountside( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x7891768a, Offset: 0x61bd
// Size: 0x1d
function private set_allowsprint( b_value = 1 )
{
    self allowsprint( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xee30de94, Offset: 0x61e2
// Size: 0x1d
function private set_allowjog( b_value = 1 )
{
    self allowjog( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x52bc1146, Offset: 0x6207
// Size: 0x1d
function private set_allowstand( b_value = 1 )
{
    self allowstand( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x5ef093e2, Offset: 0x622c
// Size: 0x1d
function private set_allowmovement( b_value = 1 )
{
    self allowmovement( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x7891768a, Offset: 0x6251
// Size: 0x1d
function private set_allowladder( b_value = 1 )
{
    self allowladder( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xfec23cdc, Offset: 0x6276
// Size: 0x1d
function private function_df742befdf77ed04( b_value = 1 )
{
    self allowwalljump( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x8386ede5, Offset: 0x629b
// Size: 0x1d
function private function_21ceb22acb454b71( b_value = 1 )
{
    self function_a6d285c122d6432a( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x135969fb, Offset: 0x62c0
// Size: 0x1d
function private set_allowmeleegrapple( b_value = 1 )
{
    self allowmeleegrapple( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xf1f29416, Offset: 0x62e5
// Size: 0x1d
function private function_2df100288e495588( b_value = 1 )
{
    self allowthrowweapon( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x6f863095, Offset: 0x630a
// Size: 0x51
function private function_38e816a25d06e176( b_value = 0 )
{
    if ( b_value )
    {
        if ( !self hasperk( "specialty_freefire" ) )
        {
            self setperk( "specialty_freefire", 1 );
        }
        
        return;
    }
    
    if ( self hasperk( "specialty_freefire" ) )
    {
        self unsetperk( "specialty_freefire", 1 );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x5ef093e2, Offset: 0x6363
// Size: 0x1d
function private function_a8117c7579bc7929( b_value = 1 )
{
    self allowswimming( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xf572245d, Offset: 0x6388
// Size: 0x1d
function private function_7ab726a64720c8a4( b_value = 1 )
{
    self allowswimmingunderwater( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x241847ed, Offset: 0x63ad
// Size: 0x1d
function private function_48acf32c9c54465c( b_value = 1 )
{
    self function_5e3d4215e59b4473( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xfec23cdc, Offset: 0x63d2
// Size: 0x1d
function private function_115021318817a3e4( b_value = 1 )
{
    self function_6af484c18f98020b( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xf41abb95, Offset: 0x63f7
// Size: 0x1d
function private function_a4ce58974995b16f( b_value = 1 )
{
    self skydive_setbasejumpingstatus( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xd077d2a9, Offset: 0x641c
// Size: 0x1d
function private function_1c864094a7f7b03c( b_value = 1 )
{
    self allowdive( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xa9265df9, Offset: 0x6441
// Size: 0x1d
function private function_f345c8f327eec46e( b_value = 1 )
{
    self allowthrusters( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xffbdb8a6, Offset: 0x6466
// Size: 0x39
function private set_movespeedscale( val = 1 )
{
    if ( isai( self ) )
    {
        asm::asm_setmoveplaybackrate( val );
        return;
    }
    
    if ( isplayer( self ) )
    {
        self setmovespeedscale( val );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xa7001633, Offset: 0x64a7
// Size: 0xc4
function private set_movespeedscalemult( val )
{
    scale = get( "move_speed_scale" );
    valuestates = self.values[ "move_speed_scale_mult" ];
    
    if ( isdefined( valuestates ) && valuestates.size )
    {
        foreach ( value in valuestates )
        {
            scale *= float( value );
        }
    }
    
    set_movespeedscale( scale );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x67a79352, Offset: 0x6573
// Size: 0x43
function private set_desiredspeed( val = 0 )
{
    if ( !isai( self ) )
    {
        assertmsg( "<dev string:x228>" );
        return;
    }
    
    if ( val > 0 )
    {
        self aisetdesiredspeed( val );
        return;
    }
    
    self aiclearscriptdesiredspeed();
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x94d13b74, Offset: 0x65be
// Size: 0x1d
function private set_pushplayer( b_value = 1 )
{
    self pushplayer( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x605392, Offset: 0x65e3
// Size: 0x28
function private set_allow_supers( b_value = 0 )
{
    if ( b_value )
    {
        self enableoffhandspecialweapons();
        return;
    }
    
    self disableoffhandspecialweapons();
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x307040d8, Offset: 0x6613
// Size: 0x1d
function private set_allow_super_pickup( b_value = 0 )
{
    self function_4d8e8ea22028572( !b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x5bb8ee61, Offset: 0x6638
// Size: 0x4a
function private set_allow_super_switching( b_value = 1 )
{
    if ( b_value )
    {
        utility::ent_flag_set( "super_switching" );
    }
    else
    {
        utility::ent_flag_clear( "super_switching" );
    }
    
    if ( isplayer( self ) )
    {
        self setclientomnvar( "ui_super_switching_allowed", b_value );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x8c173475, Offset: 0x668a
// Size: 0x68
function private set_hide_operator_backpack( b_value = 0 )
{
    if ( b_value )
    {
        if ( self tagexists( "TAG_STOWED_BACKPACK_HIDE" ) )
        {
            if ( self.operatorcustomization.body != "body_mp_gus_iw9_1_1" )
            {
                self hidepart( "TAG_STOWED_BACKPACK_HIDE" );
            }
        }
        
        return;
    }
    
    if ( self tagexists( "TAG_STOWED_BACKPACK_HIDE" ) )
    {
        self showpart( "TAG_STOWED_BACKPACK_HIDE" );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x7db798c7, Offset: 0x66fa
// Size: 0x1d
function private set_show_operator_pet( b_value = 0 )
{
    self function_768e7142f48e0374( !b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x485151e5, Offset: 0x671f
// Size: 0x1c
function private set_allow_wallrun( b_value = 0 )
{
    self allowwallrun( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x9554c388, Offset: 0x6743
// Size: 0x8d
function private set_allow_doublejump( b_value = 0 )
{
    if ( b_value )
    {
        self energy_setenergy( 0, self.doublejumpenergy );
        self energy_setrestorerate( 0, self.doublejumpenergyrestorerate );
        self.doublejumpenergy = undefined;
        self.doublejumpenergyrestorerate = undefined;
        self allowdoublejump( 1 );
        return;
    }
    
    self.doublejumpenergy = self energy_getenergy( 0 );
    self.doublejumpenergyrestorerate = self energy_getrestorerate( 0 );
    self energy_setenergy( 0, 0 );
    self energy_setrestorerate( 0, 0 );
    self allowdoublejump( 0 );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xa2d53a7f, Offset: 0x67d8
// Size: 0x1c
function private set_allow_slide( b_value = 0 )
{
    self allowslide( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x10c4ce45, Offset: 0x67fc
// Size: 0x1d
function private set_allow_scripted_melee( b_value = 0 )
{
    utility::scripted_melee_enable( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x656b38a3, Offset: 0x6821
// Size: 0x36
function private set_allow_execution_attack( b_value = 0 )
{
    if ( b_value )
    {
        self [[ level.enableexecutionattackfunc ]]();
        return;
    }
    
    self [[ level.disableexecutionattackfunc ]]();
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xea0ed282, Offset: 0x685f
// Size: 0x45
function private set_allow_execution_victim( b_value = 0 )
{
    if ( !isdefined( level.enableexecutionvictimfunc ) )
    {
        return;
    }
    
    if ( b_value )
    {
        self [[ level.enableexecutionvictimfunc ]]();
        return;
    }
    
    self [[ level.disableexecutionvictimfunc ]]();
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x90914831, Offset: 0x68ac
// Size: 0x45
function private set_allow_heavy_melee_execution_victim( b_value = 0 )
{
    if ( !isdefined( level.var_b25384e76c9c75c8 ) )
    {
        return;
    }
    
    if ( b_value )
    {
        self builtin [[ level.var_b25384e76c9c75c8 ]]();
        return;
    }
    
    self builtin [[ level.var_a12d26bb8ce6fde1 ]]();
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x303cca6d, Offset: 0x68f9
// Size: 0x32
function private set_allow_meatshield_attacker( b_value = 0 )
{
    if ( !isdefined( level.var_30443771afd8aeec ) )
    {
        return;
    }
    
    self [[ level.var_30443771afd8aeec ]]( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xfe763d87, Offset: 0x6933
// Size: 0x32
function private set_allow_meatshield_victim( b_value = 0 )
{
    if ( !isdefined( level.var_c01db9496d27edfb ) )
    {
        return;
    }
    
    self [[ level.var_c01db9496d27edfb ]]( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xeaacf3c, Offset: 0x696d
// Size: 0x1c
function private set_allow_vehicle_use( b_value = 0 )
{
    vehicle_allowplayeruse( self, b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x96d511d4, Offset: 0x6991
// Size: 0x1c
function private set_allow_vehicle_lean_out( b_value = 0 )
{
    self function_b100a7701a3ca96f( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xa3e28951, Offset: 0x69b5
// Size: 0x28
function private set_allow_vehicle_seat_switch( b_value = 0 )
{
    self.var_9b6d5e24d8eed7c4 = b_value ? undefined : 1;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x8d323690, Offset: 0x69e5
// Size: 0x1c
function private set_allow_vehicle_predictive_ragdoll( b_value = 0 )
{
    self allowvehiclepredictiveragdoll( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x75aaa637, Offset: 0x6a09
// Size: 0x56
function private function_bb0d10ecbfbeaeb9( b_value = 0 )
{
    nvgslot = 2;
    
    if ( b_value )
    {
        if ( !isai( self ) )
        {
            self setactionslot( nvgslot, "nightvision" );
        }
        
        return;
    }
    
    if ( !isai( self ) )
    {
        self setactionslot( nvgslot, "" );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x90d01209, Offset: 0x6a67
// Size: 0x1c
function private set_allow_supersprint( b_value = 0 )
{
    self allowsupersprint( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x694e5c7d, Offset: 0x6a8b
// Size: 0x50
function private set_allow_shellshock( b_value = 0 )
{
    if ( b_value )
    {
        if ( isdefined( level.enableshellshockfunc ) )
        {
            self [[ level.enableshellshockfunc ]]();
        }
        
        return;
    }
    
    if ( isdefined( level.disableshellshockfunc ) )
    {
        self [[ level.disableshellshockfunc ]]();
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x9e834a30, Offset: 0x6ae3
// Size: 0x75
function private set_allow_cinematic_motion( b_value = 0 )
{
    if ( isinfrontend() )
    {
        return;
    }
    
    if ( b_value )
    {
        if ( self.var_bc911f2808c4ce06 )
        {
            self.var_bc911f2808c4ce06 = undefined;
            
            if ( isdefined( self.cinematicmotionoverride ) )
            {
                self setcinematicmotionoverride( self.cinematicmotionoverride );
            }
            else
            {
                self clearcinematicmotionoverride();
            }
        }
        
        return;
    }
    
    self setcinematicmotionoverride( "disabled" );
    self.var_bc911f2808c4ce06 = 1;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xcf1f348d, Offset: 0x6b60
// Size: 0x70
function private set_allow_armor( b_value = 0 )
{
    if ( isdefined( self.armor.toggleuifunc ) )
    {
        self [[ self.armor.toggleuifunc ]]( b_value );
    }
    
    if ( isbot( self ) && isdefined( self._blackboard ) )
    {
        self._blackboard.var_50edfe96f927ca5 = b_value;
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x77ea780, Offset: 0x6bd8
// Size: 0x5a
function private function_82e13e9ae938b8e9( ref )
{
    if ( isdefined( ref ) && !isdefined( level.equipment.table[ ref ] ) )
    {
        assertmsg( "<dev string:x25a>" + ref + "<dev string:x2ad>" );
    }
    
    return level.equipment.table[ ref ];
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xf5f51099, Offset: 0x6c3b
// Size: 0x27
function private function_e67eeb83d8502ab2( slot )
{
    if ( !isdefined( self.equipment ) )
    {
        return;
    }
    
    return self.equipment[ slot ];
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xf1b88da9, Offset: 0x6c6b
// Size: 0x45
function private disableslotinternal( slot )
{
    if ( slot == "primary" )
    {
        self clearoffhandprimary();
        return;
    }
    
    if ( slot == "secondary" )
    {
        self clearoffhandsecondary();
        return;
    }
    
    if ( slot == "super" )
    {
        self clearoffhandspecial();
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xb8c3859f, Offset: 0x6cb8
// Size: 0x35c
function private enableslotinternal( slot )
{
    ref = function_e67eeb83d8502ab2( slot );
    equipmentlist = self getweaponslistoffhands();
    weapon = undefined;
    
    if ( !isdefined( ref ) )
    {
        return;
    }
    
    found = 0;
    
    foreach ( equip in equipmentlist )
    {
        equipref = undefined;
        
        foreach ( tableinfo in level.equipment.table )
        {
            if ( tableinfo.objweapon.basename == equip.basename )
            {
                equipref = tableinfo.ref;
                break;
            }
        }
        
        if ( equipref == ref )
        {
            if ( !isdefined( equip.basename ) )
            {
                return;
            }
            
            found = 1;
            attachments = equip.attachments ?? [];
            variantid = equip.variantid;
            
            if ( variantid > 0 )
            {
                weapon = makeweapon( equip.basename, attachments, undefined, undefined, variantid );
                svariantid = equip.basename + "|" + variantid;
                variantattachments = level.equipmentblueprints[ svariantid ] ?? [];
                
                foreach ( attachment, variant in variantattachments )
                {
                    weapon = weapon withattachment( attachment, variant );
                }
            }
            else if ( attachments.size > 0 )
            {
                defaultattachments = getweapondefaultattachments( equip.basename );
                weapon = makeweapon( equip.basename, defaultattachments );
                weapon = weapon withattachments( attachments );
            }
            else
            {
                tableinfo = function_82e13e9ae938b8e9( ref );
                weapon = tableinfo.objweapon;
            }
            
            break;
        }
    }
    
    tableinfo = function_82e13e9ae938b8e9( ref );
    
    if ( !found )
    {
        weapon = tableinfo.objweapon;
    }
    
    if ( isdefined( weapon ) && self hasweapon( weapon ) )
    {
        if ( isdefined( weapon ) && !tableinfo.ispassive )
        {
            if ( slot == "primary" )
            {
                self assignweaponoffhandprimary( weapon );
                return;
            }
            
            if ( slot == "secondary" )
            {
                self assignweaponoffhandsecondary( weapon );
                return;
            }
            
            if ( slot == "super" )
            {
                self assignweaponoffhandspecial( weapon );
            }
        }
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xe3f0c455, Offset: 0x701c
// Size: 0x47
function private set_allow_equipment_primary( b_value = 0 )
{
    if ( utility::issp() )
    {
        function_62d014caf91572e2( b_value );
        return;
    }
    
    if ( b_value )
    {
        enableslotinternal( "primary" );
        return;
    }
    
    disableslotinternal( "primary" );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x90aa019a, Offset: 0x706b
// Size: 0x47
function private set_allow_equipment_secondary( b_value = 0 )
{
    if ( utility::issp() )
    {
        function_36cea73c3b5fd96e( b_value );
        return;
    }
    
    if ( b_value )
    {
        enableslotinternal( "secondary" );
        return;
    }
    
    disableslotinternal( "secondary" );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xff57b14, Offset: 0x70ba
// Size: 0x25
function private function_f61e0e9b7270852f( b_value = 0 )
{
    setsaveddvar( @"bg_disableweaponfirstraiseanims", !b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x42b30a98, Offset: 0x70e7
// Size: 0x28
function private set_allow_weapon_inspect( b_value = 0 )
{
    if ( b_value )
    {
        self function_7d73d6786e51ae1f();
        return;
    }
    
    self function_60e112d2e106b00a();
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x3ea7d819, Offset: 0x7117
// Size: 0x1d
function private set_door_frozen( b_value = 1 )
{
    self scriptabledoorfreeze( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x987bd0f1, Offset: 0x713c
// Size: 0x31
function private set_allow_interactions( b_value = 0 )
{
    if ( b_value )
    {
        self.interactions_disabled = undefined;
        return;
    }
    
    self.interactions_disabled = 1;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x24b037d6, Offset: 0x7175
// Size: 0x38
function private set_allow_backpack_inventory( b_value = 0 )
{
    if ( isplayer( self ) && self function_5c766d1d0140b86( "ui_br_inventory_disabled" ) )
    {
        self setclientomnvar( "ui_br_inventory_disabled", !b_value );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xf1d01677, Offset: 0x71b5
// Size: 0xc
function private set_allow_tacmap_scoreboard( b_value )
{
    
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xbf446fbe, Offset: 0x71c9
// Size: 0x34
function private function_962996b296b33a29( b_value = 0 )
{
    if ( b_value )
    {
        utility::flag_clear( "weapon_scanning_off" );
        return;
    }
    
    utility::flag_set( "weapon_scanning_off" );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x9726ffc2, Offset: 0x7205
// Size: 0x4d
function private set_allow_action_slot_weapon( b_value = 0 )
{
    if ( b_value && isdefined( self.actionslotweapon ) )
    {
        self setactionslot( 1, "weapon", self.actionslotweapon );
        return;
    }
    
    self setactionslot( 1, "" );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xf91ecb62, Offset: 0x725a
// Size: 0x34
function private set_disallow_body_carry( b_value = 0 )
{
    if ( b_value )
    {
        utility::ent_flag_set( "disallow_body_carry" );
        return;
    }
    
    utility::ent_flag_clear( "disallow_body_carry" );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x7adb5d3b, Offset: 0x7296
// Size: 0x34
function private set_disallow_body_shield( b_value = 0 )
{
    if ( b_value )
    {
        utility::ent_flag_set( "disallow_body_shield" );
        return;
    }
    
    utility::ent_flag_clear( "disallow_body_shield" );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x51d67438, Offset: 0x72d2
// Size: 0x6e
function private set_demeanor( str_value )
{
    if ( isai( self ) )
    {
        if ( !isdefined( str_value ) || str_value == "" )
        {
            utility::clear_demeanor_override();
        }
        else
        {
            utility::demeanor_override( str_value );
        }
        
        return;
    }
    
    if ( isplayer( self ) && isdefined( level.var_d904ea5b8076658c ) && str_value != "" )
    {
        self [[ level.var_d904ea5b8076658c ]]( str_value );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xf1d06bb, Offset: 0x7348
// Size: 0x1f
function private set_allow_pain( b_value )
{
    if ( isai( self ) )
    {
        self.allowpain = b_value;
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x7d14adf1, Offset: 0x736f
// Size: 0x1f
function private set_allow_special_pain( b_value )
{
    if ( isai( self ) )
    {
        self.allowspecialpain = b_value;
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x3a1fd4c9, Offset: 0x7396
// Size: 0x3d
function private set_infinite_ammo( b_value = 1 )
{
    if ( !isplayer( self ) && !isagent( self ) )
    {
        assertmsg( "<dev string:x2af>" );
    }
    
    self setinfiniteammo( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x49d470f0, Offset: 0x73db
// Size: 0x28
function private set_overlord_locked_priority( val )
{
    if ( isdefined( level.setoverlordlockedpriority ) )
    {
        self [[ level.setoverlordlockedpriority ]]( val );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x80656620, Offset: 0x740b
// Size: 0x29
function private set_kill_on_damage( b_value )
{
    if ( isai( self ) && isalive( self ) )
    {
        self.killondamage = istrue( b_value );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x85715cf0, Offset: 0x743c
// Size: 0x33
function private set_reduce_damage_effects( b_value )
{
    if ( !isplayer( self ) || isbot( self ) || issimulationplayer( self ) )
    {
        return;
    }
    
    self.reduceddamageeffects = b_value;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xbdc1a5b1, Offset: 0x7477
// Size: 0x1d
function private set_solid_collide_with_players( b_value )
{
    if ( isplayer( self ) )
    {
        self setsolid( istrue( b_value ) );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x2f0cb59b, Offset: 0x749c
// Size: 0x1d
function private set_ignore_ascender_collision( b_value )
{
    if ( isplayer( self ) )
    {
        self setascenderignorecollision( istrue( b_value ) );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xcc46ff93, Offset: 0x74c1
// Size: 0x1d
function private set_skydive_force_script_collide( b_value )
{
    if ( isplayer( self ) )
    {
        self function_7f4d86c520742c2c( istrue( b_value ) );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x6ce4b1bc, Offset: 0x74e6
// Size: 0x20
function private set_collide_with_ai_allies( b_value )
{
    if ( isai( self ) )
    {
        self.collide_with_ai_allies = istrue( b_value );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x8ccb37d1, Offset: 0x750e
// Size: 0x20
function private function_d85355fb917b4bdd( b_value )
{
    if ( isai( self ) )
    {
        self.collide_with_ai_allies_smaller = istrue( b_value );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xd6f842ef, Offset: 0x7536
// Size: 0x20
function private function_a7120a590add6c5a( b_value )
{
    if ( isai( self ) )
    {
        self.script_pushable_by_ai = istrue( b_value );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x15bc73b7, Offset: 0x755e
// Size: 0x20
function private set_script_pushable( b_value )
{
    if ( isai( self ) )
    {
        self.script_pushable = istrue( b_value );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x2b2cf46e, Offset: 0x7586
// Size: 0x3a
function private set_allow_give_super_point( b_value )
{
    if ( isplayer( self ) || isai( self ) )
    {
        if ( b_value )
        {
            self.var_2364be08b6facb67 = 0;
            return;
        }
        
        self.var_2364be08b6facb67 = 1;
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xbefe88ce, Offset: 0x75c8
// Size: 0x32
function private set_allow_give_point( b_value = 1 )
{
    if ( isplayer( self ) || isai( self ) )
    {
        self.var_97027ab26a161eef = !b_value;
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x8b5b0e97, Offset: 0x7602
// Size: 0x18
function private set_pause_zombie_spawning( b_value )
{
    self.b_value_pause_zombie_spawning = istrue( b_value );
}

// Namespace val
// Params 2
// Checksum 0x748fa1cf, Offset: 0x7622
// Size: 0x134
function function_b8033e083072d1d6( str_id, value )
{
    if ( value )
    {
        set( str_id, "fire", !value );
        set( str_id, "offhand_weapons", !value );
        set( str_id, "allow_movement", !value );
        set( str_id, "allow_jump", !value );
        set( str_id, "melee", !value );
        set( str_id, "sprint", !value );
        set( str_id, "prone", !value );
        set( str_id, "allow_scripted_bgb_use", !value );
        set( str_id, "killstreaks", !value );
        return;
    }
    
    reset( str_id, "fire" );
    reset( str_id, "offhand_weapons" );
    reset( str_id, "allow_movement" );
    reset( str_id, "allow_jump" );
    reset( str_id, "melee" );
    reset( str_id, "sprint" );
    reset( str_id, "prone" );
    reset( str_id, "allow_scripted_bgb_use" );
    reset( str_id, "killstreaks" );
}

// Namespace val
// Params 2
// Checksum 0x15db0b7a, Offset: 0x775e
// Size: 0xb8
function function_ea6a6a9e43fc8c3f( str_id, value )
{
    if ( value )
    {
        set( str_id, "offhand_weapons", !value );
        set( str_id, "allow_movement", !value );
        set( str_id, "allow_jump", !value );
        set( str_id, "melee", !value );
        set( str_id, "sprint", !value );
        return;
    }
    
    reset( str_id, "offhand_weapons" );
    reset( str_id, "allow_movement" );
    reset( str_id, "allow_jump" );
    reset( str_id, "melee" );
    reset( str_id, "sprint" );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xee30de94, Offset: 0x781e
// Size: 0x1d
function private set_allowads( b_value = 1 )
{
    self allowads( b_value );
}

// Namespace val
// Params 2, eflags: 0x4
// Checksum 0xf1ef03b9, Offset: 0x7843
// Size: 0x1b
function private function_a887952f6b595ba4( s_notify, b_value )
{
    self notify( s_notify, b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xfe5d47f6, Offset: 0x7866
// Size: 0x1f
function private set_disallow_knockdown( b_value )
{
    if ( isai( self ) )
    {
        self.disallow_knockdown = b_value;
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xded3c322, Offset: 0x788d
// Size: 0x1f
function private set_disallow_stun( b_value )
{
    if ( isai( self ) )
    {
        self.disallow_stun = b_value;
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xded3c322, Offset: 0x78b4
// Size: 0x1f
function private set_postpone_stun( b_value )
{
    if ( isai( self ) )
    {
        self.postpone_stun = b_value;
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x9972c61, Offset: 0x78db
// Size: 0x1f
function private set_disallow_despawn( b_value )
{
    if ( isai( self ) )
    {
        self.disallow_despawn = b_value;
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x5282edcc, Offset: 0x7902
// Size: 0x1f
function private set_disallow_bloat( b_value )
{
    if ( isai( self ) )
    {
        self.disallow_bloat = b_value;
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x1a3d1431, Offset: 0x7929
// Size: 0x1f
function private set_postpone_vortex_pull( b_value )
{
    if ( isai( self ) )
    {
        self.postpone_vortex_pull = b_value;
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xded3c322, Offset: 0x7950
// Size: 0x1f
function private set_disallow_slow( b_value )
{
    if ( isai( self ) )
    {
        self.disallow_slow = b_value;
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x89f0d992, Offset: 0x7977
// Size: 0x29
function private set_ignore_ai_collision( b_value )
{
    if ( isai( self ) )
    {
        self enableavoidance( !b_value );
        self.collide_with_ai = !b_value;
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xbeddd784, Offset: 0x79a8
// Size: 0x1f
function private set_ammomod_immune( b_value )
{
    if ( isai( self ) )
    {
        self.var_eb92c31552620100 = b_value;
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x5c395eed, Offset: 0x79cf
// Size: 0x1f
function private set_shadow_rift_lethal_tele_immune( b_value )
{
    if ( isai( self ) )
    {
        self.var_727de1a2150faf1b = b_value;
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x78178161, Offset: 0x79f6
// Size: 0x1f
function private set_ignore_instakill_powerup( b_value )
{
    if ( isai( self ) )
    {
        self.b_ignore_instakill_powerup = b_value;
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x70b625e3, Offset: 0x7a1d
// Size: 0x17
function private set_show_stealth_indicators( b_value )
{
    self.show_stealth_indicators = b_value;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x25e06fb5, Offset: 0x7a3c
// Size: 0x37
function private set_show_ui_objectives( b_value )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( b_value )
    {
        self setclientomnvar( "ui_show_objectives", 1 );
        return;
    }
    
    self setclientomnvar( "ui_show_objectives", 0 );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x43e03cf3, Offset: 0x7a7b
// Size: 0x25
function private function_1dee1f1db2f63c5f( b_value )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    omnvar_utility::function_58bd31d56367a73d( "ui_br_player_is_in_gas", istrue( b_value ) );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xd1af9d6a, Offset: 0x7aa8
// Size: 0x35
function private function_8da692007ff8058f( b_value = 1 )
{
    if ( b_value )
    {
        utility::ent_flag_set( "enable_nuke_flash_and_sound" );
        return;
    }
    
    utility::ent_flag_clear( "enable_nuke_flash_and_sound" );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x1de778aa, Offset: 0x7ae5
// Size: 0x31
function private set_show_ui_out_of_bounds( b_value )
{
    if ( isplayer( self ) )
    {
        self setclientomnvar( "ui_out_of_bounds_countdown", b_value );
    }
    
    self notify( #"show_ui_out_of_bounds", b_value > 0 );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x85b1d534, Offset: 0x7b1e
// Size: 0x20
function private function_61ad072a9fc2be42( b_value )
{
    if ( b_value )
    {
        self castshadows();
        return;
    }
    
    self dontcastshadows();
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x9b205a83, Offset: 0x7b46
// Size: 0x1f
function private set_show_healthbar( b_value = 0 )
{
    self.showhealthbar = b_value;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x4ce222ae, Offset: 0x7b6d
// Size: 0x1f
function private function_9f3b98d1081b9f( dist = 0 )
{
    self.var_10906dc66b1c7aaf = dist;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x99c85a4, Offset: 0x7b94
// Size: 0x35
function private set_ambient_vo( b_value = 1 )
{
    if ( b_value )
    {
        utility::ent_flag_set( "play_ambient_vo" );
        return;
    }
    
    utility::ent_flag_clear( "play_ambient_vo" );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x8d5062e2, Offset: 0x7bd1
// Size: 0x35
function private set_allow_vo( b_value = 1 )
{
    if ( b_value )
    {
        utility::ent_flag_set( "allow_vo" );
        return;
    }
    
    utility::ent_flag_clear( "allow_vo" );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x44a5772a, Offset: 0x7c0e
// Size: 0x74
function private toggle_zmb_eye_glow( b_turn_on = 1 )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( !utility::ent_flag_exist( "toggle_eye_glow" ) )
    {
        utility::ent_flag_init( "toggle_eye_glow" );
    }
    
    if ( b_turn_on )
    {
        utility::ent_flag_set( "toggle_eye_glow" );
    }
    else
    {
        utility::ent_flag_clear( "toggle_eye_glow" );
    }
    
    if ( isdefined( self.fn_toggle_eye_glow ) )
    {
        self [[ self.fn_toggle_eye_glow ]]();
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x210df11e, Offset: 0x7c8a
// Size: 0x2b
function private set_allow_unreachable_attack( b_value = 1 )
{
    self._blackboard.var_252b33de40638a50 = b_value;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xcdfa963e, Offset: 0x7cbd
// Size: 0x35
function private set_trial_logic_activate( b_value = 1 )
{
    if ( b_value )
    {
        utility::ent_flag_set( "trial_logic_activate" );
        return;
    }
    
    utility::ent_flag_clear( "trial_logic_activate" );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xe43041d9, Offset: 0x7cfa
// Size: 0x35
function private set_task_logic_activate( b_value = 1 )
{
    if ( b_value )
    {
        utility::ent_flag_set( "task_logic_activate" );
        return;
    }
    
    utility::ent_flag_clear( "task_logic_activate" );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x9b374573, Offset: 0x7d37
// Size: 0x32
function private set_allow_combat_attractors( b_value = 1 )
{
    if ( b_value )
    {
        self.var_840153567385cc6b = undefined;
        return;
    }
    
    self.var_840153567385cc6b = 1;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x7e98b13b, Offset: 0x7d71
// Size: 0x17
function private set_attacker_accuracy( b_value )
{
    self.attackeraccuracy = b_value;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x3f8e47a6, Offset: 0x7d90
// Size: 0x47
function private function_8c020e6b3e6f4762( b_value )
{
    if ( !utility::ent_flag_exist( "allow_dismember" ) )
    {
        utility::ent_flag_init( "allow_dismember" );
    }
    
    if ( b_value )
    {
        utility::ent_flag_set( "allow_dismember" );
        return;
    }
    
    utility::ent_flag_clear( "allow_dismember" );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xe2357459, Offset: 0x7ddf
// Size: 0x2c
function private function_d7aa041f31d7e32f( b_value )
{
    if ( b_value )
    {
        utility::ent_flag_set( "allow_secondary_attack_damage" );
        return;
    }
    
    utility::ent_flag_clear( "allow_secondary_attack_damage" );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xf26d0337, Offset: 0x7e13
// Size: 0x17
function private function_ef6599a498d90267( b_value )
{
    self.b_ignore_cleanup = b_value;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x4ecf4f98, Offset: 0x7e32
// Size: 0x1b
function private function_ed3094fbf0019db1( overridedist )
{
    self.var_52cc30b67469d423 = squared( overridedist );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x561a3fa9, Offset: 0x7e55
// Size: 0x17
function private function_19b7ea3ee49651d7( b_value )
{
    self.var_5cbeb35a4d5900e9 = b_value;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x348907dc, Offset: 0x7e74
// Size: 0x51
function private set_participating_cinematics( b_value )
{
    b_value = istrue( b_value );
    prev = self function_e7d19d7e4403c48();
    self function_589df9c1869fcee4( b_value );
    
    if ( prev != b_value )
    {
        if ( b_value )
        {
            self notify( #"set_participating_cinematics_true" );
            return;
        }
        
        self notify( #"set_participating_cinematics_false" );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x3dd500fb, Offset: 0x7ecd
// Size: 0x58
function private set_overlord_speaker( var_85f9b34a2668217c )
{
    if ( !isdefined( var_85f9b34a2668217c ) || var_85f9b34a2668217c == "" )
    {
        if ( isdefined( level.var_8b4ae0e9bea5384c ) )
        {
            self [[ level.var_8b4ae0e9bea5384c ]]();
        }
        
        return;
    }
    
    if ( isdefined( level.var_e0b31e63f5a29e85 ) )
    {
        self [[ level.var_e0b31e63f5a29e85 ]]( var_85f9b34a2668217c );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xd9d080b6, Offset: 0x7f2d
// Size: 0x1d
function private function_2e0d6f33b91fc4f0( b_value )
{
    setsaveddvar( @"ai_corpsesynch", istrue( b_value ) );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xb2c8248b, Offset: 0x7f52
// Size: 0x31
function private set_vehicle_disallow_lockon( b_disable_lockon )
{
    if ( vehicle::is_vehicle() )
    {
        self.disablelockon = b_disable_lockon;
        
        if ( b_disable_lockon )
        {
            self notify( #"disable_lockon" );
        }
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x9ca7a3b0, Offset: 0x7f8b
// Size: 0x47
function private set_allow_third_person_toggle( b_value )
{
    if ( isplayer( self ) )
    {
        if ( self.disable_third_person_toggle && b_value )
        {
            self.var_ca6ca955f2c4c8af = gettime();
        }
        
        self.disable_third_person_toggle = b_value ? undefined : 1;
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xc83bb19b, Offset: 0x7fda
// Size: 0x24
function private set_high_net_lod( b_value = 0 )
{
    if ( isent( self ) )
    {
        self forcenetfieldhighlod( b_value );
    }
}

// Namespace val
// Params 1
// Checksum 0x8d050d24, Offset: 0x8006
// Size: 0x1f
function set_ks_dont_forget( value = 0 )
{
    self.ksdontforget = value;
}

// Namespace val
// Params 1
// Checksum 0xeaa1251f, Offset: 0x802d
// Size: 0x26
function set_ai_eventlist( eventlist )
{
    if ( eventlist == "" )
    {
        function_117415769484a82c();
        return;
    }
    
    function_f750be7c4e3a297b( eventlist );
}

// Namespace val
// Params 1
// Checksum 0xc9ff9615, Offset: 0x805b
// Size: 0x13
function set_ttlt_lkp( val )
{
    stealthsettimetolosetargetatlkp( val );
}

// Namespace val
// Params 1
// Checksum 0x39c3c06, Offset: 0x8076
// Size: 0x13
function function_458fa5173d52d835( val )
{
    stealthsettimetolosetargetnotatlkp( val );
}

// Namespace val
// Params 1
// Checksum 0x417dfe49, Offset: 0x8091
// Size: 0x13
function set_drop_threat_sight( val )
{
    stealthsetdefaulttimetodropthreatsight( val );
}

// Namespace val
// Params 1
// Checksum 0xf9ca870c, Offset: 0x80ac
// Size: 0x13
function function_19800d31ca9a012e( val )
{
    setglobalescalationtotalcombattime( val );
}

// Namespace val
// Params 1
// Checksum 0x6e269abf, Offset: 0x80c7
// Size: 0x13
function function_e3ffb01ce831f16a( val )
{
    setglobalescalationcombatpercentagethreshold( val );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x54ef7e76, Offset: 0x80e2
// Size: 0x38
function private set_allow_ping( b_value )
{
    if ( isplayer( self ) )
    {
        utility::callsharedfunc( #"ping", #"hash_93794a5055a44ce1", b_value ? 1 : 0 );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x4b99246b, Offset: 0x8122
// Size: 0x28
function private set_wounded_movement( val )
{
    if ( isdefined( level.var_2464e8c70801e60f ) )
    {
        self [[ level.var_2464e8c70801e60f ]]( val );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x224db992, Offset: 0x8152
// Size: 0x28
function private set_allow_melee_me( b_value = 0 )
{
    if ( issentient( self ) )
    {
        self.dontmeleeme = !b_value;
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x5b6999c, Offset: 0x8182
// Size: 0x29
function private set_ignore_triggers( b_value = 1 )
{
    self.ignoretriggers = b_value ? 1 : 0;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xfea014f6, Offset: 0x81b3
// Size: 0x32
function private set_look_behavior( value = "ai_default" )
{
    if ( isai( self ) )
    {
        self function_10006c8216ad87fd( "focus_behaviors", "look_state", value );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x863c60d6, Offset: 0x81ed
// Size: 0x27
function private set_ai_lightweight( b_value = 1 )
{
    if ( !isai( self ) )
    {
        return;
    }
    
    self function_97a9712d0b90aae9( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xabe3a8d6, Offset: 0x821c
// Size: 0x68
function private set_lerp_fov_scale( arraytargettime )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    defval = [ 1, 0.25 ];
    
    if ( !isdefined( arraytargettime ) )
    {
        arraytargettime = defval;
    }
    
    if ( !isarray( arraytargettime ) )
    {
        arraytargettime = [ arraytargettime ];
    }
    
    self lerpfovscalefactor( arraytargettime[ 0 ] ?? defval[ 0 ], arraytargettime[ 1 ] ?? defval[ 1 ] );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x5f61cff2, Offset: 0x828c
// Size: 0x36
function private set_xp_scale( val )
{
    if ( isdefined( val ) && val != 1 )
    {
        self.var_cbb73538dc6fd584 = val;
        return;
    }
    
    self.var_cbb73538dc6fd584 = undefined;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xbea63556, Offset: 0x82ca
// Size: 0x31
function private set_allow_scripted_bgb_use( b_value = 0 )
{
    if ( b_value )
    {
        self.var_eeb6ebe322e71cd1 = undefined;
        return;
    }
    
    self.var_eeb6ebe322e71cd1 = 1;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xc0a153e5, Offset: 0x8303
// Size: 0x23
function private set_hide_stowed_weapon( b_value )
{
    if ( b_value )
    {
        self setstowedweaponvisibility( 0 );
        return;
    }
    
    self setstowedweaponvisibility( 1 );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x81cd73d5, Offset: 0x832e
// Size: 0x5d
function private set_allow_battlechatter_vo( b_value = 1 )
{
    if ( b_value )
    {
        if ( isplayer( self ) )
        {
            self.bcdisabled = undefined;
        }
        else
        {
            self.battlechatterallowed = 1;
        }
        
        return;
    }
    
    if ( isplayer( self ) )
    {
        self.bcdisabled = 1;
        return;
    }
    
    self.battlechatterallowed = undefined;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xc29f9b85, Offset: 0x8393
// Size: 0x29
function private function_f01949d7ffcf11f7( b_value = 1 )
{
    if ( issentient( self ) )
    {
        self.var_9f4e3f5817d5c92b = istrue( b_value );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x58db8032, Offset: 0x83c4
// Size: 0x21
function private set_allow_perks( b_value = 1 )
{
    self.var_b5253a6833765cd2 = istrue( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x75991f68, Offset: 0x83ed
// Size: 0x37
function private set_show_perks( b_value = 1 )
{
    if ( isplayer( self ) && hasomnvar( "ui_visibility_perks" ) )
    {
        self setclientomnvar( "ui_visibility_perks", b_value );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xe997d4d9, Offset: 0x842c
// Size: 0x38
function private set_show_quest_ui( b_value = 1 )
{
    if ( isplayer( self ) && hasomnvar( "ui_zm_quest_hide_hud" ) )
    {
        self setclientomnvar( "ui_zm_quest_hide_hud", !b_value );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x884d526b, Offset: 0x846c
// Size: 0x38
function private set_show_trials_ui( b_value = 1 )
{
    if ( isplayer( self ) && hasomnvar( "ui_zm_trial_hide_hud" ) )
    {
        self setclientomnvar( "ui_zm_trial_hide_hud", !b_value );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xba9f68ed, Offset: 0x84ac
// Size: 0x37
function private set_perk_decay( b_value = 1 )
{
    if ( isplayer( self ) && hasomnvar( "ui_perk_decay_active" ) )
    {
        self setclientomnvar( "ui_perk_decay_active", b_value );
    }
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x50940414, Offset: 0x84eb
// Size: 0x1c
function private set_allow_reload_without_reserve_ammo( b_value = 0 )
{
    self function_81e34c49e8541eb4( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x62af3222, Offset: 0x850f
// Size: 0x1c
function private set_allow_reload_when_clip_full( b_value = 0 )
{
    self function_cf98a32f2bcfc7dd( b_value );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x453602b, Offset: 0x8533
// Size: 0x34
function private set_allow_full_ammo( b_value = 0 )
{
    if ( b_value )
    {
        utility::ent_flag_set( "allow_full_ammo_powerup" );
        return;
    }
    
    utility::ent_flag_clear( "allow_full_ammo_powerup" );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x1f12db49, Offset: 0x856f
// Size: 0x24
function private set_firetimescale( val )
{
    if ( val < 0 )
    {
        self setfiretimescaleoff();
        return;
    }
    
    self setfiretimescaleon( val );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x861a9b4d, Offset: 0x859b
// Size: 0x17
function private set_zombie_damage_to_player_multiplier( val )
{
    level.var_3f27e31a208b760f = val;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x3090a9f9, Offset: 0x85ba
// Size: 0xaa
function private set_damage_protection_omnvar( s_value )
{
    prev_values = self.values[ "damage_protection_omnvar" ];
    
    if ( prev_values.size == 1 && !self.val_damage_protection_omnvar )
    {
        self setclientomnvar( s_value, 1 );
        self.val_damage_protection_omnvar = s_value;
    }
    else if ( !prev_values && self.val_damage_protection_omnvar )
    {
        self setclientomnvar( self.val_damage_protection_omnvar, 0 );
        self.val_damage_protection_omnvar = undefined;
    }
    
    assert( !self.val_damage_protection_omnvar || self.val_damage_protection_omnvar == s_value, "<dev string:x2ee>" );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0xa11c9dfa, Offset: 0x866c
// Size: 0xe5
function private function_3caa771970487b66( s_value )
{
    prev_values = self.values[ "damage_protection_pgb_post_fx" ];
    
    if ( prev_values.size == 1 && !self.var_c2e09cd562ffa911 )
    {
        utility::callsharedfunc( #"fullscreenfx", #"hash_382df7654f0561bd", { #postfxbundlename:s_value }, 1, 1 );
        self.var_c2e09cd562ffa911 = s_value;
    }
    else if ( !prev_values && self.var_c2e09cd562ffa911 )
    {
        utility::callsharedfunc( #"fullscreenfx", #"hash_494b07757cd511a5", { #postfxbundlename:self.var_c2e09cd562ffa911 } );
        self.var_c2e09cd562ffa911 = undefined;
    }
    
    assert( !self.var_c2e09cd562ffa911 || self.var_c2e09cd562ffa911 == s_value, "<dev string:x330>" );
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x46e50fae, Offset: 0x8759
// Size: 0xb2
function private get_max_value( str_name )
{
    result = undefined;
    
    if ( self.values[ str_name ] )
    {
        foreach ( val in self.values[ str_name ] )
        {
            if ( !isdefined( result ) )
            {
                result = val;
                continue;
            }
            
            result = max( val, result );
        }
    }
    
    return result;
}

// Namespace val
// Params 1, eflags: 0x4
// Checksum 0x53a09ef0, Offset: 0x8814
// Size: 0xb2
function private get_min_value( str_name )
{
    result = undefined;
    
    if ( self.values[ str_name ] )
    {
        foreach ( val in self.values[ str_name ] )
        {
            if ( !isdefined( result ) )
            {
                result = val;
                continue;
            }
            
            result = min( val, result );
        }
    }
    
    return result;
}

/#

    // Namespace val
    // Params 3, eflags: 0x4
    // Checksum 0x53c6ee46, Offset: 0x88cf
    // Size: 0x8b, Type: dev
    function private validate( str_name, call_on, func )
    {
        if ( !isdefined( level.values_ref[ str_name ] ) )
        {
            assertmsg( "<dev string:x7c>" + str_name + "<dev string:x377>" );
            return;
        }
        
        s_value = level.values_ref[ str_name ];
        s_value.b_validate = 1;
        s_value.func_validate = func;
        s_value.validate_call_on = call_on;
    }

    // Namespace val
    // Params 3, eflags: 0x4
    // Checksum 0xa998a4a, Offset: 0x8962
    // Size: 0x11c, Type: dev
    function private validate_value( str_name, value, b_assert )
    {
        if ( !isdefined( b_assert ) )
        {
            b_assert = 0;
        }
        
        s_value = level.values_ref[ str_name ];
        current_value = undefined;
        
        if ( isdefined( s_value.func_validate ) )
        {
            call_on = s_value.validate_call_on == "<dev string:x2b>" ? self : s_value.validate_call_on;
            
            if ( isdefined( s_value.validate_args ) )
            {
                current_value = utility::single_func_argarray( call_on, s_value.func_validate, replace_values( s_value.validate_args ) );
            }
            else
            {
                current_value = utility::single_func_argarray( call_on, s_value.func_validate, [] );
            }
        }
        else
        {
            current_value = 0;
        }
        
        b_match = current_value == value;
        
        if ( b_assert )
        {
            assert( b_match, "<dev string:x389>" + str_name + "<dev string:x39c>" + current_value + "<dev string:x3a3>" + value + "<dev string:x3b5>" );
        }
        
        return b_match;
    }

    // Namespace val
    // Params 0, eflags: 0x4
    // Checksum 0x5bd8862e, Offset: 0x8a86
    // Size: 0x537, Type: dev
    function private debug_values()
    {
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        setdvarifuninitialized( @"scr_debug_values", 0 );
        setdvarifuninitialized( @"scr_debug_values_filter", "<dev string:x3b8>" );
        waitframe();
        scr_debug_values = 0;
        scr_debug_values_next = -1;
        var_78f285248caec26c = undefined;
        
        while ( true )
        {
            if ( gettime() > scr_debug_values_next )
            {
                scr_debug_values = getdvarint( @"scr_debug_values" );
                scr_debug_values_next = gettime() + 1000;
            }
            
            if ( !scr_debug_values )
            {
                if ( level.valuesdebug )
                {
                    level.valuesdebug destroy();
                    level.valuesdebug = undefined;
                }
                
                level.var_82d07382ebcd1cae = undefined;
                waitframe();
                continue;
            }
            
            level.var_82d07382ebcd1cae = level.var_ae866e1b43eacb0a;
            hud_ent = undefined;
            str_label = "<dev string:x3b9>";
            str_debug_values_entity = string::to_string( getdvar( @"scr_debug_values_entity", "<dev string:x3b8>" ) );
            
            if ( str_debug_values_entity == "<dev string:x3b8>" || str_debug_values_entity == "<dev string:x3da>" || str_debug_values_entity == "<dev string:x3dd>" )
            {
                clientnum = int( getdvar( @"hash_13d8008e8edc58d5", "<dev string:x3da>" ) );
                
                if ( clientnum != -1 )
                {
                    setdvar( @"hash_13d8008e8edc58d5", "<dev string:x3da>" );
                    client = utility::function_3bc2c606a1c39e2f( clientnum );
                    
                    if ( isplayer( client ) )
                    {
                        var_78f285248caec26c = client;
                    }
                }
                
                if ( isplayer( var_78f285248caec26c ) )
                {
                    hud_ent = var_78f285248caec26c;
                    str_label = "<dev string:x3e2>" + hud_ent getentitynumber() + "<dev string:x403>" + ( hud_ent.name ?? "<dev string:x406>" );
                }
                else
                {
                    hud_ent = level.host ?? level.player ?? level.players[ 0 ];
                    
                    if ( isplayer( hud_ent ) )
                    {
                        str_label = "<dev string:x409>" + hud_ent getentitynumber() + "<dev string:x403>" + ( hud_ent.name ?? "<dev string:x406>" );
                    }
                }
            }
            else
            {
                str_value = str_debug_values_entity;
                str_key = "<dev string:x429>";
                
                if ( issubstr( str_value, "<dev string:x434>" ) )
                {
                    a_toks = strtok( str_value, "<dev string:x434>" );
                    str_value = a_toks[ 0 ];
                    str_key = a_toks[ 1 ];
                }
                
                hud_ent = getent( str_value, str_key, 1 );
                
                if ( hud_ent )
                {
                    str_label = "<dev string:x436>" + hud_ent getentitynumber() + "<dev string:x403>" + str_value + "<dev string:x434>" + str_key;
                }
            }
            
            level.var_ae866e1b43eacb0a = str_label + "<dev string:x44a>";
            a_all_ents = getentarray();
            
            foreach ( ent in a_all_ents )
            {
                if ( isdefined( ent.values ) )
                {
                    i = 1;
                    
                    foreach ( str_name, a_value in ent.values )
                    {
                        key = getlastarraykey( a_value );
                        
                        if ( !isdefined( key ) )
                        {
                            continue;
                        }
                        
                        top_value = a_value[ key ];
                        
                        if ( isdefined( top_value ) )
                        {
                            b_valid = 1;
                            
                            if ( level.values_ref[ str_name ].b_validate )
                            {
                                b_assert = getdvarint( @"scr_debug_values", 0 ) > 1;
                                b_valid = ent validate_value( str_name, top_value, b_assert );
                            }
                            
                            ent display_value( i, str_name, key, top_value, isdefined( hud_ent ) && b_valid, hud_ent == ent );
                            i++;
                        }
                    }
                }
            }
            
            if ( !isdefined( level.valuesdebug ) )
            {
                hudelem = newhudelem();
                hudelem.alignx = "<dev string:x44c>";
                hudelem.aligny = "<dev string:x451>";
                hudelem.foreground = 1;
                hudelem.fontscale = 1.2;
                hudelem.scramblerdisabled = 1;
                hudelem.x = 80;
                hudelem.y = 100;
                hudelem.color = ( 1, 1, 1 );
                hudelem setdevtext( "<dev string:x455>" );
                level.valuesdebug = hudelem;
            }
            
            if ( !level.var_82d07382ebcd1cae || level.var_82d07382ebcd1cae != level.var_ae866e1b43eacb0a )
            {
                level.valuesdebug setdevtext( level.var_ae866e1b43eacb0a );
            }
            
            waitframe();
        }
    }

    // Namespace val
    // Params 6, eflags: 0x4
    // Checksum 0x1e435d0c, Offset: 0x8fc5
    // Size: 0x256, Type: dev
    function private display_value( index, str_name, str_id, value, b_valid, on_hud )
    {
        if ( !isdefined( on_hud ) )
        {
            on_hud = 0;
        }
        
        if ( isxhash( str_id ) )
        {
            str_id = getxhashsourcename( str_id );
        }
        
        str_value = "<dev string:x3b8>";
        
        if ( string::to_string( str_name ) != "<dev string:x3b8>" )
        {
            str_value = string::rjust( str_name, 10 );
            
            if ( isarray( value ) )
            {
                str_value += "<dev string:x466>";
                
                foreach ( item in value )
                {
                    str_value += "<dev string:x46b>" + item + "<dev string:x46b>";
                }
                
                str_value += "<dev string:x46d>";
            }
            else if ( isdefined( value ) )
            {
                str_value += "<dev string:x46f>" + value;
            }
            
            str_value += "<dev string:x473>" + string::ljust( string( str_id ) + "<dev string:x476>", 15 );
        }
        
        color = b_valid ? ( 1, 1, 1 ) : ( 1, 0, 0 );
        filter = getdvar( @"scr_debug_values_filter", "<dev string:x3b8>" );
        
        if ( filter != "<dev string:x3b8>" && !issubstr( str_value, filter ) )
        {
            return;
        }
        
        if ( on_hud )
        {
            newvalue = level.var_ae866e1b43eacb0a + str_value + "<dev string:x44a>";
            
            if ( newvalue.size <= 850 )
            {
                level.var_ae866e1b43eacb0a = newvalue;
            }
            else if ( getsubstr( level.var_ae866e1b43eacb0a, level.var_ae866e1b43eacb0a.size - 7, level.var_ae866e1b43eacb0a.size ) != "<dev string:x478>" )
            {
                level.var_ae866e1b43eacb0a += "<dev string:x478>";
            }
            
            return;
        }
        
        print3d( self.origin - ( 0, 0, index * 8 ), str_value, color, 1.5, 0.3, 1 );
    }

#/
