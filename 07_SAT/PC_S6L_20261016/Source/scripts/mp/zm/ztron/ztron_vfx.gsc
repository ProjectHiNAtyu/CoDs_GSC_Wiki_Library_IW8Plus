// scripts\mp\zm\ztron\ztron_vfx.gsc  (hash_46a67238111daff0.gscc) (size: 17183 Bytes / 0x431f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3f972f68 (1066872680)
// size ...... 17183 (0x431f)
// includes .. 2   (offset: 0x376f)
// strings ... 236 (offset: 0x377f)
// dev strs .. 6   (offset: 0x42c7)
// exports ... 16  (offset: 0x2ef7)
// cseg ...... 0x1e3e + 0x10b9 (0x2ef7)
// imports ... 36  (offset: 0x3177)
// animtree1 . 0   (offset: 0x431f)
// animtree2 . 0   (offset: 0x431f)
#using scripts\common\devgui;
#using scripts\common\utility;

#namespace ztron_vfx;

// Namespace ztron_vfx
// Params 0
// Checksum 0xcbb689bd, Offset: 0x1e5c
// Size: 0x852
function init()
{
    utility::add_fx( "ztron_player_shield_long_LP", "vfx_sat_shield_zdo_loop_ztron" );
    utility::add_fx( "ztron_player_shield_short", "vfx_sat_shield_gone_zdo_ztron" );
    utility::add_fx( "ztron_player_shield_long_sideView_LP", "vfx_sat_shield_side_zdo_loop_ztron" );
    utility::add_fx( "ztron_player_shield_short_sideView", "vfx_sat_shield_gone_side_zdo_ztron" );
    utility::add_fx( "ztron_player_heli_hit_damage_sideView", "vfx_sat_zm_heli_hit_damage_explo_ztron" );
    utility::add_fx( "ztron_player_trail_green", "vfx_sat_trail_player_green_ztron" );
    utility::add_fx( "ztron_player_trail_blue", "vfx_sat_trail_player_blue_ztron" );
    utility::add_fx( "ztron_player_trail_red", "vfx_sat_trail_player_red_ztron" );
    utility::add_fx( "ztron_player_trail_yellow", "vfx_sat_trail_player_yellow_ztron" );
    utility::add_fx( "ztron_player_respawn_green", "vfx_sat_player_respawn_ztron" );
    utility::add_fx( "ztron_player_respawn_blue", "vfx_sat_player_respawn_blue_ztron" );
    utility::add_fx( "ztron_player_respawn_red", "vfx_sat_player_respawn_red_ztron" );
    utility::add_fx( "ztron_player_respawn_yellow", "vfx_sat_player_respawn_yellow_ztron" );
    utility::add_fx( "ztron_player_reviving", "vfx_sat_zm_ui_heal_aura_os_red_ztron" );
    utility::add_fx( "ztron_player_ammo_unlimited", "vfx_sat_zm_ammo_ztron" );
    utility::add_fx( "ztron_barrel_fire", "vfx_sat_fire_barrel_red_os_ztron" );
    utility::add_fx( "ztron_barrel_fire_top", "vfx_sat_red_barrel_fire_os_ztron" );
    utility::add_fx( "ztron_explode_red_barrel", "vfx_sat_zm_prop_script_red_barrel_explo_ztron" );
    utility::add_fx( "ztron_explosive_warning_light", "vfx_sat_explosive_barrel_light_red_ztron" );
    utility::add_fx( "ztron_hazard_electric_trap_green", "vfx_sat_trap_green_light_ztron" );
    utility::add_fx( "ztron_hazard_electric_trap_red", "vfx_sat_trap_red_light_ztron" );
    utility::add_fx( "ztron_hazard_electric_trap_active", "vfx_sat_electric_trap_zdo_ztron" );
    utility::add_fx( "ztron_hazard_electric", "vfx_sat_elec_sparks_burst_med_os_ztron" );
    utility::add_fx( "ztron_hazard_electric_shock", "vfx_t10_gameplay_zm_tesla_shock_zmb" );
    utility::add_fx( "ztron_hazard_electric_shock_ground", "vfx_t10_gameplay_zm_tesla_shock_ground" );
    utility::add_fx( "ztron_hazard_electric_shock_eyes", "vfx_t10_gameplay_zm_tesla_shock_eyes_zmb" );
    utility::add_fx( "nova_juice_me_aura_fx", "vfx_sat_zm_nova_crawler_aura_ztron" );
    utility::add_fx( "fungus_spore_fx", "vfx_sat_zm_ai_zai_gas_torso_purple_ztron" );
    utility::add_fx( "ztron_hazard_lawn_mower_debris", "vfx_sat_zm_debris_lawn_mower_ztron" );
    utility::add_fx( "ztron_hazard_rune_statue_activate", "vfx_jup_level_mp_underpass_lightningbolt_a" );
    utility::add_fx( "ztron_hazard_pungi_hint", "vfx_sat_zm_trap_spike_tell_ztron" );
    utility::add_fx( "ztron_hazard_pungi_activate", "vfx_sat_zm_trap_spike_damage_ztron" );
    utility::add_fx( "ztron_hazard_pungi_damage", "vfx_sat_zm_trap_spike_damage_player_ztron" );
    utility::add_fx( "ztron_hazard_laser_trap", "vfx_sat_zm_trap_energy_beam_purple_ztron" );
    utility::add_fx( "ztron_hazard_laser_trap_hint", "vfx_sat_zm_lase_trap_beam_o_ztron" );
    utility::add_fx( "ztron_hazard_laser_trap_red", "vfx_sat_zm_trap_energy_beam_red_ztron" );
    utility::add_fx( "ztron_hazard_enemy_spawner_explode", "vfx_sat_zm_bee_hive_exp_ztron" );
    utility::add_fx( "ztron_egg_explode", "vfx_sat_zm_bee_hive_exp_ztron" );
    utility::add_fx( "ztron_boxing_pow", "vfx_sat_zm_powerup_boxer_gloves_pow_ztron" );
    utility::add_fx( "ztron_boxing_stars", "vfx_sat_zm_powerup_boxer_gloves_impact_ztron" );
    utility::add_fx( "ztron_arena_exit", "vfx_sat_zm_arena_exit_smk_ztron" );
    utility::add_fx( "ztron_arena_teleporter", "vfx_sat_zm_arena_teleporter_marker_ztron" );
    utility::add_fx( "ztron_burn_fire_limb_left", "vfx_sat_zm_fire_arm_left_os_ztron" );
    utility::add_fx( "ztron_burn_fire_limb_right", "vfx_sat_zm_fire_arm_right_os_ztron" );
    utility::add_fx( "ztron_burn_fire_torso", "vfx_sat_zm_fire_torso_os_ztron" );
    utility::add_fx( "ztron_exp_lg", "vfx_sat_zm_transitions_smk_cam_ztron" );
    utility::add_fx( "ztron_protal_radial_burst", "vfx_sat_zm_elec_burst_radial_os_ztron" );
    utility::add_fx( "ztron_fall_hundred_broken_platform", "vfx_sat_zm_platform_board_fall_ztron" );
    utility::add_fx( "ztron_fall_hundred_winning", "vfx_iw9_level_party_prty_firework_ch_red" );
    utility::add_fx( "ztron_fate_removal", "vfx_sat_zm_fate_removal_ztron" );
    utility::add_fx( "ztron_shooter_abort_plank_death", "vfx_sat_zm_props_barrier_exp_ztron" );
    utility::add_fx( "ztron_lava_cave_exit", "vfx_sat_zm_dark_aether_portal_doorway_pupre_ztron" );
    utility::add_fx( "ztron_brimestone_explo2", "vfx_t10_gameplay_zm_weapons_equip_thermobaric_fireball_abom" );
    utility::add_fx( "ztron_brimestone_explo", "vfx_sat_zm_aether_charge_explode_ztron" );
    utility::add_fx( "ztron_brimestone_body", "vfx_sat_zm_gameplay_fire_trail" );
    utility::add_fx( "ztron_radial_purple_128", "vfx_t10_gameplay_zm_fld_energy_mine_explo_ring_128" );
    utility::add_fx( "ztron_radial_purple_256", "vfx_t10_gameplay_zm_fld_energy_mine_explo_ring_250" );
    utility::add_fx( "ztron_shield_break", "vfx_t10_levels_zm_topaz_limq_hvt_shield_break_explo" );
    utility::add_fx( "ztron_explo_purple_256", "vfx_t10_levels_zm_opal_dig_power_beam_impact_explo" );
    utility::add_fx( "ztron_explo_gold", "vfx_t10_levels_zm_topaz_limq_ghost_dth_exp" );
    utility::add_fx( "ztron_explo_blue", "vfx_t10_levels_zm_topaz_limq_ghost_dth_exp_blue" );
    utility::add_fx( "ztron_explo_purple", "vfx_t10_levels_zm_topaz_limq_ghost_dth_exp_purple" );
    utility::add_fx( "ztron_fire_ethereal_purple", "vfx_t10_gameplay_zm_aether_canisters_energy_lg" );
    utility::add_fx( "ztron_wisp_ethereal_purple", "vfx_t10_levels_zm_topaz_wwq_plasma_pulse_ch" );
    utility::add_fx( "ztron_wisp_ethereal_orange", "vfx_t10_gameplay_zm_rampage_inducer_lg_ground_orange" );
    utility::add_fx( "ztron_lava_ball", "vfx_t10_gameplay_zm_fire_trail" );
    utility::add_fx( "player_fast_feet", "vfx_sat_zm_boots_trail_purple_ztron" );
    utility::add_fx( "lightning_a", "vfx_t10_levels_zm_quartz_lightning_03_strike_1" );
    utility::add_fx( "lightning_b", "vfx_t10_levels_zm_quartz_lightning_06_strike_a" );
    utility::add_fx( "lightning_ground", "vfx_t10_levels_zm_quartz_chest_lightning_storm_strike_ground" );
    utility::add_fx( "lightning_strike", "vfx_t10_levels_zm_quartz_chest_lightning_storm_strike" );
    utility::add_fx( "lightning_spawn", "vfx_t10_gameplay_zm_ai_spawn_lightning_strike_elec" );
    utility::add_fx( "red_portal_sphere", "vfx_zm_janus_container_portal_spawn" );
    utility::add_fx( "papaback_intro", "vfx_t10_gameplay_zm_ai_dead_wire_lightning_strike" );
    utility::add_fx( "papaback_intro_exit", "vfx_t10_levels_zm_quartz_term_boss_portal_ground" );
    utility::add_fx( "ztron_papaback_shield", "vfx_sat_zm_shield_red_ztron" );
    utility::add_fx( "ztron_papaback_launch", "vfx_sat_spawn_dirt_hand_burst_ztron" );
    utility::add_fx( "ztron_papaback_land", "vfx_sat_debris_body_nuke_dust_ztron" );
    utility::add_fx( "ztron_papaback_banana_explo", "vfx_t10_gameplay_zm_ai_zai_phobos_gas_pool_128" );
    utility::add_fx( "ztron_papaback_berserk_eye_le", "vfx_sat_zm_simianaut_eye_glow_red_le" );
    utility::add_fx( "ztron_papaback_berserk_eye_ri", "vfx_sat_zm_simianaut_eye_glow_red_ri" );
    utility::add_fx( "ztron_papaback_boost_trail", "vfx_sat_zm_boost_trail_red_ztron" );
    utility::add_fx( "turret_impact", "vfx_sat_zm_impact_turret_land_ztron" );
    utility::add_fx( "zombie_generator_die", "vfx_sat_zm_exp_skull_blood_ztron" );
    utility::add_fx( "chicken_explode", "vfx_sat_zm_bio_chicken_death_ztron" );
    utility::add_fx( "lightningStrike", "vfx_sat_zm_dog_lightning_spawn_ztron" );
    utility::add_fx( "stun_head", "vfx_t10_gameplay_zm_weapons_flashbang_stun_head" );
    utility::add_fx( "raygun_impact", "vfx_t10_gameplay_zm_ww_raygun_proj_impact" );
    utility::add_fx( "big_chicken_explode", "vfx_t10_gameplay_zm_ai_zai_abom_death_explo" );
    utility::add_fx( "attackerhighlightSentient", "vfx_sat_zm_wispy_smk_trail_red_ztron" );
    utility::add_fx( "heavyZombie_land", "vfx_sat_zm_impact_turret_land_ztron" );
    utility::add_fx( "heavyZombie_land_hintMarker", "vfx_sat_zm_heavyzombie_hint_red_ztron" );
    utility::add_fx( "heavyZombie_trail", "vfx_sat_zm_heavyzombie_smk_trail_ztron" );
    utility::add_fx( "concussion_explo", "vfx_sat_zm_air_horn_shock_once_ztron" );
    utility::add_fx( "lava_explo", "vfx_sat_zm_lava_leap_slam_ztron" );
    utility::add_fx( "glow_blue", "vfx_sat_light_doa_pickup_glow_blue_ztron" );
    utility::add_fx( "glow_yellow", "vfx_sat_light_doa_pickup_glow_gold_ztron" );
    utility::add_fx( "glow_green", "vfx_sat_light_doa_pickup_glow_green_ztron" );
    utility::add_fx( "glow_red", "vfx_sat_light_doa_pickup_glow_red_ztron" );
    utility::add_fx( "glow_white", "vfx_sat_light_doa_pickup_glow_white_ztron" );
    utility::add_fx( "feet_upgrade_firetrailLP", "vfx_sat_zm_assault_energy_purple_loop_ztron" );
    utility::add_fx( "feet_upgrade_firetrailDone", "vfx_sat_zm_assault_energy_purple_despawn_ztron" );
    utility::add_fx( "slayer_store_reward_impact", "vfx_sat_zm_shop_reward_imp_ztron" );
    utility::add_fx( "slayer_store_reward_pkg_trail", "vfx_sat_zm_shop_reward_trail_ztron" );
    utility::add_fx( "slayer_store_aura", "vfx_sat_zm_machine_props_vending_active_ztron" );
    utility::add_fx( "vehicle_flares", "vfx_iw8_mp_strk_apache_angel_flares" );
    utility::add_fx( "vehicle_light_green", "vfx_sat_zm_heli_light_green_ztron" );
    utility::add_fx( "vehicle_light_blue", "vfx_sat_zm_heli_light_blue_ztron" );
    utility::add_fx( "vehicle_light_red", "vfx_sat_zm_heli_light_red_ztron" );
    utility::add_fx( "vehicle_light_yellow", "vfx_sat_zm_heli_light_yellow_ztron" );
    utility::add_fx( "crab_bubbles", "vfx_sat_zm_gobblegums_bubbles_ztron" );
    utility::add_fx( "silverback_uplight", "vfx_sat_gameplay_zm_light_generic" );
    level.ztron.var_57f84155982b146c = [ utility::getfx( "ztron_burn_fire_limb_left" ), utility::getfx( "ztron_burn_fire_limb_right" ), utility::getfx( "ztron_burn_fire_torso" ), utility::getfx( "ztron_burn_fire_limb_left" ), utility::getfx( "ztron_burn_fire_limb_right" ) ];
    level.ztron.var_b06b32766aaa0b3 = [ "j_elbow_le", "j_elbow_ri", "j_spine4", "j_knee_le", "j_knee_ri" ];
    level.ztron.var_aadb3cff0c9f9ff6 = [ 8, 8, 8, 8, 8 ];
    
    /#
        level thread function_ac7ee3673d6e340d();
    #/
}

// Namespace ztron_vfx
// Params 2
// Checksum 0xa511f423, Offset: 0x26b6
// Size: 0x38
function function_574a3236c59da7d8( fxname, origin )
{
    fx = spawnfx( utility::getfx( fxname ), origin );
    triggerfx( fx );
    return fx;
}

// Namespace ztron_vfx
// Params 1
// Checksum 0x53dc3228, Offset: 0x26f7
// Size: 0x19
function function_4abb26b271676888( fx )
{
    if ( isdefined( fx ) )
    {
        fx delete();
    }
}

// Namespace ztron_vfx
// Params 1
// Checksum 0xfdc0fe3f, Offset: 0x2719
// Size: 0xba
function function_b63ffc146fbe05b5( shortshield = 1 )
{
    self endon( #"disconnect" );
    utility::function_7c10ea82c1e305b8( "ztron_player_shield", "off" );
    waitframe();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( shortshield )
    {
        if ( !level.ztron.sideviewactive )
        {
            utility::function_7c10ea82c1e305b8( "ztron_player_shield", "short" );
        }
        else
        {
            utility::function_7c10ea82c1e305b8( "ztron_player_shield", "short_sideview" );
        }
        
        return;
    }
    
    if ( !level.ztron.sideviewactive )
    {
        utility::function_7c10ea82c1e305b8( "ztron_player_shield", "long" );
        return;
    }
    
    utility::function_7c10ea82c1e305b8( "ztron_player_shield", "long_sideview" );
}

// Namespace ztron_vfx
// Params 0
// Checksum 0x81066661, Offset: 0x27db
// Size: 0x13
function function_f1048dd5d33090f8()
{
    utility::function_7c10ea82c1e305b8( "ztron_player_shield", "off" );
}

// Namespace ztron_vfx
// Params 0
// Checksum 0x67833d4e, Offset: 0x27f6
// Size: 0x104
function function_d97767dbf49f31f5()
{
    ent = self;
    ztronstruct = self.ztron;
    
    if ( !isalive( ent ) )
    {
        ent = self getcorpseentity();
        
        if ( !isdefined( ztronstruct ) )
        {
            ztronstruct = ent.ztron;
        }
    }
    
    if ( isdefined( ent ) && isdefined( ztronstruct.var_72db97854a9e0a84 ) )
    {
        foreach ( key in getarraykeys( ztronstruct.var_72db97854a9e0a84 ) )
        {
            tag = ztronstruct.var_72db97854a9e0a84[ key ];
            
            if ( ent tagexists( tag ) )
            {
                killfxontag( key, ent, tag );
            }
        }
        
        ztronstruct.var_72db97854a9e0a84 = undefined;
    }
}

// Namespace ztron_vfx
// Params 4
// Checksum 0x5ceda499, Offset: 0x2902
// Size: 0xfc
function function_a2884eba34f8ea6b( id, ent, tag, var_8a058f4318431f03 = 1 )
{
    index = ent gettagindex( tag );
    
    if ( !isdefined( index ) )
    {
        return;
    }
    
    playfxontag( id, ent, tag );
    
    if ( var_8a058f4318431f03 )
    {
        if ( !isdefined( ent.ztron ) )
        {
            ent.ztron = spawnstruct();
        }
        
        if ( !isdefined( ent.ztron.var_72db97854a9e0a84 ) )
        {
            ent.ztron.var_72db97854a9e0a84 = [];
        }
        
        if ( isdefined( ent.ztron.var_72db97854a9e0a84[ id ] ) )
        {
            stopfxontag( id, ent, ent.ztron.var_72db97854a9e0a84[ id ] );
        }
        
        ent.ztron.var_72db97854a9e0a84[ id ] = tag;
    }
}

// Namespace ztron_vfx
// Params 3
// Checksum 0x27d9c57d, Offset: 0x2a06
// Size: 0x58
function aistopfxontag( id, ent, tag )
{
    stopfxontag( id, ent, tag );
    
    if ( isdefined( ent.ztron.var_72db97854a9e0a84 ) )
    {
        ent.ztron.var_72db97854a9e0a84[ id ] = undefined;
    }
}

// Namespace ztron_vfx
// Params 0
// Checksum 0x2a4926b8, Offset: 0x2a66
// Size: 0x57
function burn()
{
    if ( isdefined( self.no_burn ) )
    {
        return;
    }
    
    if ( isai( self ) )
    {
        utility::function_7c10ea82c1e305b8( "burned", "burned_on" );
        return;
    }
    
    if ( !isdefined( self.var_8c62bc506b721c62 ) )
    {
        self.var_8c62bc506b721c62 = [];
    }
    
    if ( self.var_8c62bc506b721c62.size > 0 )
    {
        return;
    }
    
    thread burninternal();
}

// Namespace ztron_vfx
// Params 1
// Checksum 0x46776508, Offset: 0x2ac5
// Size: 0xc2
function burninternal( index )
{
    self endon( #"death" );
    mask = randomint( 1 << level.ztron.var_57f84155982b146c.size );
    idx = 0;
    
    while ( mask > 0 && isdefined( self ) )
    {
        if ( mask & 1 )
        {
            function_a2884eba34f8ea6b( level.ztron.var_57f84155982b146c[ idx ], self, level.ztron.var_b06b32766aaa0b3[ idx ], 0 );
            self.var_8c62bc506b721c62[ self.var_8c62bc506b721c62.size ] = idx;
            thread function_86273716b9855e51( idx );
        }
        
        mask >>= 1;
        idx++;
        waitframe();
    }
}

// Namespace ztron_vfx
// Params 0
// Checksum 0x2694a154, Offset: 0x2b8f
// Size: 0xdc
function stopburn()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isai( self ) )
    {
        utility::function_7c10ea82c1e305b8( "burned", "burned_off" );
        return;
    }
    
    self notify( #"stop_burn" );
    
    foreach ( idx in self.var_8c62bc506b721c62 )
    {
        aistopfxontag( level.ztron.var_57f84155982b146c[ idx ], self, level.ztron.var_b06b32766aaa0b3[ idx ] );
        thread function_77daa552574911f5( idx );
    }
}

// Namespace ztron_vfx
// Params 1, eflags: 0x4
// Checksum 0x54460131, Offset: 0x2c73
// Size: 0x37
function private function_77daa552574911f5( idx )
{
    waitframe();
    
    if ( isdefined( self ) && isdefined( self.var_8c62bc506b721c62 ) )
    {
        self.var_8c62bc506b721c62 = arrayremove( self.var_8c62bc506b721c62, idx );
    }
}

// Namespace ztron_vfx
// Params 1, eflags: 0x4
// Checksum 0xc245ea27, Offset: 0x2cb2
// Size: 0x9c
function private function_86273716b9855e51( idx )
{
    self endon( #"death", #"stop_burn", #"disconnect" );
    duration = level.ztron.var_aadb3cff0c9f9ff6[ idx ] ?? 8;
    utility::waittill_any_timeout( duration );
    
    if ( isdefined( self ) )
    {
        aistopfxontag( level.ztron.var_57f84155982b146c[ idx ], self, level.ztron.var_b06b32766aaa0b3[ idx ] );
        thread function_77daa552574911f5( idx );
    }
}

/#

    // Namespace ztron_vfx
    // Params 1
    // Checksum 0xdd75bec6, Offset: 0x2d56
    // Size: 0xb7, Type: dev
    function debug_play_vfx( params )
    {
        player = level.players[ 0 ];
        
        if ( isdefined( player.ztron.debugvfx ) )
        {
            stopfxontag( player.ztron.debugvfx, player, "<dev string:x24>" );
        }
        
        effectname = params[ 0 ];
        
        if ( effectname != "<dev string:x2f>" )
        {
            player.ztron.debugvfx = utility::getfx( effectname );
            playfxontag( player.ztron.debugvfx, player, "<dev string:x24>" );
        }
    }

    // Namespace ztron_vfx
    // Params 0
    // Checksum 0x8a17c0e3, Offset: 0x2e15
    // Size: 0xe2, Type: dev
    function function_ac7ee3673d6e340d()
    {
        wait 1;
        devgui::function_9082edeb5db93280( "<dev string:x39>" );
        effectname = "<dev string:x2f>";
        devgui::function_cd4e263c1f3018ae( "<dev string:x46>" + effectname, "<dev string:x50>" + effectname, &debug_play_vfx );
        
        foreach ( effectname, _ in level._effect )
        {
            if ( isstring( effectname ) && issubstr( effectname, "<dev string:x60>" ) )
            {
                devgui::function_cd4e263c1f3018ae( "<dev string:x46>" + effectname, "<dev string:x50>" + effectname, &debug_play_vfx );
            }
        }
        
        devgui::function_77df7fe7dd273e10();
    }

#/
