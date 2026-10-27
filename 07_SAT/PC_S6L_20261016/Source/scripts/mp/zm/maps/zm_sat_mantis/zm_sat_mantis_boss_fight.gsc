// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_boss_fight.gsc  (hash_307695074c174f9c.gscc) (size: 62551 Bytes / 0xf457 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe4dc3a1c (3839638044)
// size ...... 62551 (0xf457)
// includes .. 66  (offset: 0xe2bb)
// strings ... 195 (offset: 0xe4cb)
// dev strs .. 63  (offset: 0xf11b)
// exports ... 84  (offset: 0xa31b)
// cseg ...... 0x110b + 0x9210 (0xa31b)
// imports ... 383 (offset: 0xb03b)
// animtree1 . 0   (offset: 0xf457)
// animtree2 . 0   (offset: 0xf457)
#using script_16ea1b94f0f381b3;
#using script_1d947a67914036d6;
#using script_2c0d2bdaac4d051d;
#using script_3b63a3e0026b877b;
#using script_4478f81b31480314;
#using script_4739bc1bf6db3b96;
#using script_480bb8d22e030f14;
#using script_50711a6f06e7b3a3;
#using script_6c3d015c4415b878;
#using script_747a3e7e01d497c7;
#using script_7573db1b78c0c729;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\common\scene;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\ammo_cache;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\armor;
#using scripts\mp\arsenal;
#using scripts\mp\augments\zombie_augments;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\compass;
#using scripts\mp\crafting_table;
#using scripts\mp\currency;
#using scripts\mp\destructibles\destructibles;
#using scripts\mp\equipment;
#using scripts\mp\interaction;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\magicbox;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\overlord;
#using scripts\mp\pack_a_punch;
#using scripts\mp\perk_machines;
#using scripts\mp\playerlogic;
#using scripts\mp\wallbuy;
#using scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis;
#using scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_boss_fight_twins;
#using scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_radiation_cloud;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\time_travel;
#using scripts\mp\zm\systems\time_travel_timewarps;
#using scripts\mp\zm\systems\zm_armor;
#using scripts\mp\zm\systems\zm_exfil_sat;
#using scripts\mp\zm\systems\zm_fasttravel_core;
#using scripts\mp\zm\systems\zm_lighting_visionset;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\tedd_tasks;
#using scripts\mp\zm\zm;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_mantis_boss_fight;

// Namespace zm_sat_mantis_boss_fight
// Params 0, eflags: 0x5
// Checksum 0x8904120f, Offset: 0x1129
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"mantis_boss_fight", undefined, &pre_init, &init_boss_fight );
}

// Namespace zm_sat_mantis_boss_fight
// Params 0
// Checksum 0x32a96f10, Offset: 0x114e
// Size: 0x1be
function pre_init()
{
    level._effect[ "dark_heart_cloud_vfx" ] = loadfxasset( "vfx_sat_levels_zm_mantis_boss_ff_cloud" );
    level._effect[ "dark_heart_cloud_fade_out_vfx" ] = loadfxasset( "vfx_sat_levels_zm_mantis_boss_ff_cloud_fade_out" );
    level._effect[ "dark_heart_shield_vfx" ] = loadfxasset( "vfx_sat_gameplay_zm_ai_galileo_shield" );
    level._effect[ "dark_heart_shield_damaged_vfx" ] = loadfxasset( "vfx_sat_gameplay_zm_ai_galileo_shield_damaged" );
    level._effect[ "dark_energy_default_beam" ] = loadfxasset( "vfx_sat_gameplay_zm_ai_aeon_tethers_beam" );
    level._effect[ "dark_energy_activate_beam" ] = loadfxasset( "vfx_sat_gameplay_zm_ai_aeon_tethers_beam_activate" );
    level._effect[ "musical_item_charged_vfx" ] = loadfxasset( "vfx_t10_gameplay_zm_resonator_elec_ball" );
    level._effect[ "twins_shield_idle" ] = loadfxasset( "vfx_t10_levels_zm_topaz_limq_hvt_shield_start_light" );
    level._effect[ "twins_shield_dmg" ] = loadfxasset( "vfx_sat_gameplay_aeon_twins_shield_zm_impact" );
    level._effect[ "twins_shield_expo" ] = loadfxasset( "vfx_t10_levels_zm_topaz_limq_hvt_shield_break_light" );
    level._effect[ "empowered_ai_beam" ] = loadfxasset( "vfx_sat_levels_zm_mantis_wwq_zombie_tether_beam" );
    level._effect[ "empowered_ai_tornado" ] = loadfxasset( "vfx_sat_gameplay_zm_ai_aeon_flame_tornado" );
    level._effect[ "empowered_ai_tornado_spawn" ] = loadfxasset( "vfx_sat_gameplay_zm_ai_aeon_flame_tornado_spawn" );
    level._effect[ "empowered_ai_aura" ] = loadfxasset( "vfx_sat_levels_zm_mantis_wwq_zombie_tether_torso" );
    level._effect[ "cyst_tether_beam" ] = loadfxasset( "vfx_sat_mantis_loot_cyst_tether_beam" );
    level._effect[ "aeon_ball_hit_impact_heart" ] = loadfxasset( "vfx_sat_gameplay_aeon_ball_hit_impact_heart" );
    scene::add_scene_func( "sat_cin_zm_vig_plr_dth_drk_hrt", &function_4c5fef7fc72ae65a, "callback_play" );
    scene::add_scene_func( "sat_cin_zm_vig_plr_dth_drk_hrt", &function_db017c5415354548, "callback_done" );
}

// Namespace zm_sat_mantis_boss_fight
// Params 0
// Checksum 0x339ecaa0, Offset: 0x1314
// Size: 0x96
function init_boss_fight()
{
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"start_mantis_boss_fight", &function_e83b11eb8fabc062 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_7d1b4b7b23fd890d", &function_e83b11eb8fabc062 );
    level.s_dark_heart = utility::getstruct( "dark_heart", "targetname" );
    function_aab4b169152f5aa();
    level callback::add( "aeon_death_explosion", &on_aeon_death_explosion );
    
    if ( !callback::exists( #"player_spawned", &on_player_spawned ) )
    {
        level callback::add( #"player_spawned", &on_player_spawned );
    }
    
    /#
        init_boss_fight_devgui();
    #/
}

// Namespace zm_sat_mantis_boss_fight
// Params 1
// Checksum 0x28108e15, Offset: 0x13b2
// Size: 0x6c6
function start_boss_fight( params )
{
    level endon( #"game_ended" );
    init_boss_fight_data();
    minimap_volumes = getnoentvolumearray( "noent_volume_minimap", #classname );
    
    foreach ( player in level.players )
    {
        minimap_image = "compass_map_zm_sat_mantis_floor_3";
        self.minimap_data = { #override_volume:minimap_volumes[ 1 ], #map_material:minimap_image };
        compass::setupminimap( minimap_image, undefined, undefined, minimap_volumes[ 1 ] );
        player setsoundsubmix( "sat_zm_mantis_boss" );
        player.var_7ab4c9acb317c405 = utility::getstruct( "final_teleport_pos", "targetname" ).origin;
    }
    
    if ( !utility::flag( "start_boss_fight" ) )
    {
        utility::flag_set( "start_boss_fight" );
    }
    
    function_213ac91cf90bae85();
    zm_lighting_visionset::function_48532c8b58f4b0b3();
    level notify( #"hash_15b37960176646dd" );
    utility::flag_set( "disable_special_round_visionset" );
    level.s_dark_heart.cloud_scriptable = spawnscriptable( %"sat_zm_mantis_boss_cloud", level.s_dark_heart.origin );
    activateworldevent( "we_vfx_nuke_town_future_boss_fight_area" );
    deactivateworldevent( "we_lgt_truck_future", 1 );
    level thread zm_quest::cleanup_zombies_manually( 1, undefined, undefined, undefined, 0, 1, 0 );
    function_8b15006049502df0();
    zm_sat_mantis::function_ae0561e420148611();
    zm_sat_mantis::function_97f071991b379f23();
    level thread zm_round_spawning::pause_round_spawning( 1, "mantis_boss_fight" );
    function_199554ef8113dca1();
    
    if ( getdvarint( @"hash_febdbb4cb19936b2", 0 ) > 0 )
    {
        level thread function_d1ae908624012179();
    }
    
    level.players[ 0 ] utility::waittill_notify_or_timeout( "fasttravel_finished", 10 );
    wait 2;
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"boss_start" );
    level thread revive_all_players();
    level.s_dark_heart.boss_agent = agent_manager::spawn_agent( "zombie_aeon", level.s_dark_heart.origin + ( 0, 0, 300 ), ( 0, 0, 0 ), zm_utility::get_zombie_team() );
    level.s_dark_heart.boss_agent playsound( #"hash_21819960f5506666" );
    
    if ( !level.s_dark_heart.boss_agent )
    {
        return;
    }
    
    level.s_dark_heart.boss_agent callback::add( #"on_ai_killed", &function_462e8bdd6281a400 );
    
    if ( level.s_dark_heart.boss_agent zombie_utils::get_zombie_round_difficulty() < function_b80976b7930587b4() )
    {
        level.s_dark_heart.boss_agent zombie_utils::set_zombie_round_difficulty( function_b80976b7930587b4() );
    }
    
    level.s_dark_heart.boss_agent.targetname = "dark_heart_boss";
    level.s_dark_heart.boss_agent.var_1f6335e27ced5dca = 1;
    level.s_dark_heart.boss_agent.var_5c002aff00d1b4ea = function_32ec661281f1622f();
    level.s_dark_heart.boss_agent.var_f83db376611adf7d = function_c4f4abcd0b650f8a();
    level.s_dark_heart.boss_agent zombie_aeon::set_rest_position( level.s_dark_heart.origin + ( 0, 0, getdvarfloat( @"hash_611134735972432f", -375 ) ) );
    level.s_dark_heart.boss_agent zombie_aeon::set_notarget_position( level.s_dark_heart.origin + ( 0, 0, getdvarfloat( @"hash_3c1992b0e975fc3b", -300 ) ) );
    level.s_dark_heart.boss_agent zombie_aeon::function_71b88f65f500bd75( level.s_dark_heart.origin + ( 0, 0, getdvarfloat( @"hash_eba944342dc0b695", -375 ) ) );
    level.s_dark_heart.boss_agent thread function_92dfa2f6bc9a3a8();
    
    if ( getdvarint( @"hash_191b6dd4228fa507", 1 ) > 0 )
    {
        level.s_dark_heart.boss_agent thread spawn_black_ichor_puddle();
    }
    
    foreach ( player in level.players )
    {
        player zombie_boss_healthbar::zombie_boss_healthbar_hide();
    }
    
    zombie_aeon_navigation::init_aeon_navigation( level.s_dark_heart.origin, level.s_dark_heart.var_dd5147eb36a3795b );
    wait getdvarfloat( @"hash_a0c1d695e6bad24f", 8 );
    function_6b01801b08f66717();
    level.s_dark_heart.boss_agent thread zombie_boss_healthbar::init_zombie_boss_healthbar();
    waitframe();
    function_9cc2b48802345520();
    waitframe();
    function_9cc2b48802345520();
    level thread boss_fight_phase_check();
    utility::callsharedfunc( #"zm_laststand", #"hash_7f936b8cb61507e7", level.s_dark_heart.boss_agent.subclass );
    level.var_9c0d12c8f8edeb3d = "sat_cin_zm_vig_plr_dth_drk_hrt";
    level.s_game_over_scene_override = utility::getstruct( "sat_cin_zm_vig_plr_dth_drk_hrt", "targetname" );
    level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_a2930ec6cb893fb5", #"hash_a2930bc6cb893a9c", #"hash_a2930cc6cb893c4f", #"hash_a29309c6cb893736" ] );
    level thread function_d55d67950127527f();
    level thread function_72b1eb65d3d1fda9();
    level thread function_279b889e364dad0d();
    level thread function_f8534495c90f25bb();
    level thread function_ff0253f22edf0d9a();
    level thread function_2740e3d5aa98d37d();
    
    if ( !callback::exists( #"player_damaged", &function_d22fb7443c607c54 ) )
    {
        level callback::add( #"player_damaged", &function_d22fb7443c607c54 );
    }
    
    level.s_dark_heart.boss_agent waittill( #"death" );
}

// Namespace zm_sat_mantis_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x10571928, Offset: 0x1a80
// Size: 0x86
function private function_213ac91cf90bae85()
{
    foreach ( index, var_576d220b01160c72 in level.s_dark_heart.var_dd5147eb36a3795b )
    {
        var_576d220b01160c72 thread namespace_a2abfdbbd7a98995::init_musical_item( index );
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 0
// Checksum 0x65a70bc4, Offset: 0x1b0e
// Size: 0xcd
function function_d55d67950127527f()
{
    level.s_dark_heart.boss_agent endon( #"death" );
    level.s_dark_heart.boss_agent utility::ent_flag_wait( "scar_exposed" );
    level.s_dark_heart.boss_agent utility::ent_flag_waitopen_any( "scar_exposed" );
    wait 2;
    level thread zm_quest::play_vo_events( [ #"hash_94617c3abb70226b" ] );
    level.s_dark_heart.boss_agent utility::ent_flag_wait( "scar_exposed" );
    level.s_dark_heart.boss_agent utility::ent_flag_waitopen_any( "scar_exposed" );
    wait 2;
    zm_quest::play_vo_events( [ #"hash_94617d3abb70241e" ] );
}

// Namespace zm_sat_mantis_boss_fight
// Params 0
// Checksum 0xaca6857, Offset: 0x1be3
// Size: 0x1c5
function function_72b1eb65d3d1fda9()
{
    var_c8de8ba475fc1ca3 = 45000;
    var_ed984f474b1be2f3 = 90000;
    var_e1fca5af87a7a98c = undefined;
    var_66ba259d593ffb88 = undefined;
    level.s_dark_heart.boss_agent endon( #"death" );
    wait 6;
    
    while ( true )
    {
        var_ced2dcf86077f1f0 = undefined;
        var_461bcdb2a9183d44 = undefined;
        level.s_dark_heart.boss_agent waittill( #"hash_a628d3786516c7ae", n_damage, attacker, b_hit_weakpoint );
        
        if ( n_damage == 0 && isplayer( attacker ) && !attacker.var_ced2dcf86077f1f0 && !zm_quest::is_vo_active() && ( !isdefined( var_e1fca5af87a7a98c ) || gettime() > var_e1fca5af87a7a98c + var_c8de8ba475fc1ca3 ) )
        {
            utility::flag_set( "boss_fight_damage_vo_playing" );
            wait 1;
            
            if ( isplayer( attacker ) )
            {
                var_ced2dcf86077f1f0 = attacker namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"boss_invulnerable", #"bc_flavor_player_negative" );
                
                if ( isplayer( attacker ) )
                {
                    attacker.var_ced2dcf86077f1f0 = var_ced2dcf86077f1f0;
                }
            }
            
            if ( var_ced2dcf86077f1f0 )
            {
                var_e1fca5af87a7a98c = gettime();
            }
            
            continue;
        }
        
        if ( b_hit_weakpoint && isplayer( attacker ) && !zm_quest::is_vo_active() && ( !isdefined( var_66ba259d593ffb88 ) || gettime() > var_66ba259d593ffb88 + var_ed984f474b1be2f3 ) )
        {
            wait 1;
            
            if ( isplayer( attacker ) )
            {
                var_461bcdb2a9183d44 = attacker namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_9c55697e84cc4df7", #"bc_flavor_player_positive" );
                
                if ( isplayer( attacker ) )
                {
                    attacker.var_461bcdb2a9183d44 = var_461bcdb2a9183d44;
                }
            }
            
            if ( var_461bcdb2a9183d44 )
            {
                var_66ba259d593ffb88 = gettime();
            }
        }
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 0
// Checksum 0x1ed6287b, Offset: 0x1db0
// Size: 0x1fe
function function_279b889e364dad0d()
{
    level.s_dark_heart.boss_agent endon( #"death" );
    level waittill( #"hash_810948727828101d" );
    a_alive_players = utility::get_alive_players( 0 );
    player = utility::array_random( a_alive_players );
    
    if ( isplayer( player ) )
    {
        player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_b85c3f95cb56d425", #"bc_flavor_player_positive", undefined, 1 );
    }
    
    var_92d01eb9d5c0b03e = [ #"hash_6b6298a75323ec44", #"hash_6b629ba75323f15d", #"hash_6b629aa75323efaa", #"hash_6b6295a75323e72b" ];
    var_61f9dce5f8d8ccde = [ #"hash_8f607003085cbad8", #"hash_8f607303085cbff1", #"hash_8f607203085cbe3e", #"hash_8f607503085cc357" ];
    var_2d53e0892b387af4 = undefined;
    var_4b8f77c02b3b6200 = undefined;
    var_685e16c7e802c6b1 = 30000;
    var_92045e5c43b63df5 = 30000;
    
    while ( true )
    {
        level waittill( #"boss_fight_defend_start" );
        
        if ( var_92d01eb9d5c0b03e.size && ( !isdefined( var_2d53e0892b387af4 ) || gettime() > var_2d53e0892b387af4 + var_685e16c7e802c6b1 ) )
        {
            var_cb32765d0d4dcda9 = utility::array_random( var_92d01eb9d5c0b03e );
            var_92d01eb9d5c0b03e = arrayremove( var_92d01eb9d5c0b03e, var_cb32765d0d4dcda9 );
            level thread zm_quest::function_d5ef98341fd6a057( [ var_cb32765d0d4dcda9 ] );
            var_2d53e0892b387af4 = gettime();
        }
        
        msg = level utility::waittill_any_return( "boss_fight_defend_fail", "boss_fight_instrument_defend_success", "twins_shield_75_percent_health" );
        
        if ( msg == "twins_shield_75_percent_health" && var_61f9dce5f8d8ccde.size && ( !isdefined( var_4b8f77c02b3b6200 ) || gettime() > var_4b8f77c02b3b6200 + var_92045e5c43b63df5 ) )
        {
            var_482c521e2b8daa1d = utility::array_random( var_61f9dce5f8d8ccde );
            var_61f9dce5f8d8ccde = arrayremove( var_61f9dce5f8d8ccde, var_482c521e2b8daa1d );
            level thread zm_quest::function_d5ef98341fd6a057( [ var_482c521e2b8daa1d ] );
            var_4b8f77c02b3b6200 = gettime();
        }
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 0
// Checksum 0xc02c0f55, Offset: 0x1fb6
// Size: 0x224
function function_f8534495c90f25bb()
{
    level.s_dark_heart.boss_agent endon( #"death" );
    var_d87deead03a3576 = 0;
    var_a0e7b46c4a113f52 = undefined;
    var_5be148743fd629b1 = undefined;
    var_c328a7c9ab83e533 = 30000;
    var_e0adeed92bfd42db = [ #"hash_30401ea35f2fb4a2", #"hash_30401da35f2fb2ef", #"hash_30401ca35f2fb13c", #"hash_30401ba35f2faf89" ];
    
    while ( true )
    {
        msg = level utility::waittill_any_return( "boss_fight_instrument_defend_success", "boss_fight_defend_fail", "boss_fight_phase3_release_musical_items" );
        
        switch ( msg )
        {
            case #"hash_46d98e7b55badb4c":
                var_d87deead03a3576++;
                
                if ( var_d87deead03a3576 == 1 )
                {
                    level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_cc0df4439f65e689", #"hash_cc0df1439f65e170", #"hash_cc0df2439f65e323", #"hash_cc0df7439f65eba2" ] );
                }
                else if ( var_d87deead03a3576 == 3 )
                {
                    level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_6ac76bab21f1cf3", #"hash_6ac77bab21f1ea6", #"hash_6ac78bab21f2059", #"hash_6ac79bab21f220c" ] );
                }
                
                break;
            case #"hash_bd28799f7e27fa73":
                if ( var_e0adeed92bfd42db.size && ( !isdefined( var_a0e7b46c4a113f52 ) || gettime() > var_a0e7b46c4a113f52 + var_c328a7c9ab83e533 ) )
                {
                    var_3e38cbd9af6cfa2f = utility::array_random( var_e0adeed92bfd42db );
                    var_e0adeed92bfd42db = arrayremove( var_e0adeed92bfd42db, var_3e38cbd9af6cfa2f );
                    level thread zm_quest::function_d5ef98341fd6a057( [ var_3e38cbd9af6cfa2f ] );
                    var_a0e7b46c4a113f52 = gettime();
                }
                
                break;
            case #"hash_d1a0e162d5a064fa":
                if ( !isdefined( var_5be148743fd629b1 ) || gettime() > var_5be148743fd629b1 + var_c328a7c9ab83e533 )
                {
                    a_players = utility::get_alive_players( 0 );
                    player = utility::array_random( a_players );
                    player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_230bc8ab0cfdb9af", #"bc_flavor_player_positive", undefined, 1 );
                    var_5be148743fd629b1 = gettime();
                }
                
                break;
        }
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 0
// Checksum 0xfb0bcba1, Offset: 0x21e2
// Size: 0x8e
function function_2740e3d5aa98d37d()
{
    level.s_dark_heart.boss_agent endon( #"death" );
    n_cooldown_vo = 30;
    
    while ( true )
    {
        level waittill( #"hash_49a826a8a8eb3ea2", params );
        
        if ( isplayer( params.attacker ) )
        {
            wait 1;
            var_db75d3de862ce072 = params.attacker namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_ff71e9ddcd2ae95b" );
            
            if ( var_db75d3de862ce072 )
            {
                wait n_cooldown_vo;
            }
        }
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 1
// Checksum 0x7a3c949f, Offset: 0x2278
// Size: 0xec
function function_d22fb7443c607c54( params )
{
    n_cooldown_vo = 60;
    
    if ( !utility::flag( "flame_tornado_damage_vo" ) && isdefined( level.s_dark_heart.boss_agent.var_5882e5e64b6302a7 ) && isdefined( params.einflictor ) && arraycontains( level.s_dark_heart.boss_agent.var_5882e5e64b6302a7, params.einflictor ) )
    {
        utility::flag_set( "flame_tornado_damage_vo" );
        wait 0.5;
        
        if ( isplayer( self ) )
        {
            var_db75d3de862ce072 = namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"boss_flame_tornado", #"bc_flavor_player_negative", undefined, 1 );
        }
        
        if ( var_db75d3de862ce072 )
        {
            wait n_cooldown_vo;
            utility::flag_clear( "flame_tornado_damage_vo" );
            return;
        }
        
        utility::flag_clear( "flame_tornado_damage_vo" );
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 0
// Checksum 0x20392fae, Offset: 0x236c
// Size: 0xd9
function function_ff0253f22edf0d9a()
{
    level.s_dark_heart.boss_agent endon( #"death" );
    var_ea6bac88f1e89e1c = [ #"hash_3db503046d83b3da", #"hash_3db502046d83b227", #"hash_3db501046d83b074", #"hash_3db500046d83aec1" ];
    var_8d070faea3fb047d = undefined;
    var_c328a7c9ab83e533 = 30000;
    
    while ( true )
    {
        level waittill( #"hash_c7c160a672d4726a" );
        
        if ( var_ea6bac88f1e89e1c.size && ( !isdefined( var_8d070faea3fb047d ) || gettime() > var_8d070faea3fb047d + var_c328a7c9ab83e533 ) )
        {
            var_8d668cbb8ad34540 = utility::array_random( var_ea6bac88f1e89e1c );
            var_ea6bac88f1e89e1c = arrayremove( var_ea6bac88f1e89e1c, var_8d668cbb8ad34540 );
            level thread zm_quest::function_d5ef98341fd6a057( [ var_8d668cbb8ad34540 ] );
            var_8d070faea3fb047d = gettime();
        }
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 1
// Checksum 0x2d9a4d65, Offset: 0x244d
// Size: 0x75
function vo_boss_death( var_1d0b08fe550caf30 )
{
    wait 0.5;
    zm_quest::play_vo_events( [ #"warden_zero_health" ] );
    
    if ( !isplayer( var_1d0b08fe550caf30 ) )
    {
        a_alive_players = utility::get_alive_players( 0 );
        var_1d0b08fe550caf30 = utility::array_random( a_alive_players );
    }
    
    if ( isplayer( var_1d0b08fe550caf30 ) )
    {
        var_1d0b08fe550caf30 namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"boss_defeated" );
    }
    
    utility::flag_set( "boss_fight_vo_done" );
}

// Namespace zm_sat_mantis_boss_fight
// Params 0
// Checksum 0x80e2c656, Offset: 0x24ca
// Size: 0x8d
function function_4c5fef7fc72ae65a()
{
    if ( level.s_dark_heart.boss_agent )
    {
        level.s_dark_heart.boss_agent unlink();
        level.s_dark_heart.boss_agent.var_66127c9c960b6878 = 1;
    }
    
    if ( !utility::flag( "start_boss_fight" ) )
    {
        activateworldevent( "we_vfx_nuke_town_future_boss_fight_area" );
        deactivateworldevent( "we_lgt_truck_future", 1 );
        function_8b15006049502df0( 1 );
        zm_sat_mantis::function_ae0561e420148611();
        zm_sat_mantis::function_97f071991b379f23( 0 );
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 0
// Checksum 0xe029298a, Offset: 0x255f
// Size: 0xcc
function function_db017c5415354548()
{
    if ( level.s_dark_heart.boss_agent )
    {
        level.s_dark_heart.boss_agent.var_66127c9c960b6878 = undefined;
        
        if ( level.s_dark_heart.boss_agent.mover )
        {
            level.s_dark_heart.boss_agent linktoblendtotag( level.s_dark_heart.boss_agent.mover, "tag_origin" );
        }
    }
    
    if ( !utility::flag( "start_boss_fight" ) )
    {
        deactivateworldevent( "we_vfx_nuke_town_future_boss_fight_area" );
        activateworldevent( "we_lgt_truck_future", 1 );
        function_8b15006049502df0( 0 );
        zm_sat_mantis::function_a15e37d395e34804();
        zm_sat_mantis::function_97f071991b379f23( 1 );
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xce0cbf87, Offset: 0x2633
// Size: 0xec
function private function_92dfa2f6bc9a3a8()
{
    level.s_dark_heart.boss_agent endon( #"death" );
    
    while ( true )
    {
        level.s_dark_heart.boss_agent zombie_aeon::set_rest_position( level.s_dark_heart.origin + ( 0, 0, getdvarfloat( @"hash_611134735972432f", -375 ) ) );
        level.s_dark_heart.boss_agent zombie_aeon::set_notarget_position( level.s_dark_heart.origin + ( 0, 0, getdvarfloat( @"hash_3c1992b0e975fc3b", -300 ) ) );
        level.s_dark_heart.boss_agent zombie_aeon::function_71b88f65f500bd75( level.s_dark_heart.origin + ( 0, 0, getdvarfloat( @"hash_eba944342dc0b695", -375 ) ) );
        waitframe();
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x6a2245be, Offset: 0x2727
// Size: 0x48
function private function_35cbed5ec70ac10e()
{
    self endon( #"hash_fe42b70a485ecf86" );
    self endon( #"death" );
    var_da3a1cbbe694b617 = getdvarfloat( @"hash_4c91c0e14db4e000", 660 );
    
    while ( true )
    {
        wait var_da3a1cbbe694b617;
        zombie_aeon::function_7059b85a384fcc35();
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 1
// Checksum 0x2270e539, Offset: 0x2777
// Size: 0x211c
function function_8b15006049502df0( b_hide = 1 )
{
    if ( b_hide == level.var_87bccbaa031f150f )
    {
        return;
    }
    
    level.var_87bccbaa031f150f = b_hide;
    destructible::hide_destructibles( b_hide );
    
    if ( !isdefined( level.s_dark_heart ) )
    {
        level.s_dark_heart = utility::getstruct( "dark_heart", "targetname" );
    }
    
    if ( !isdefined( level.s_dark_heart.hidden_props ) )
    {
        level.s_dark_heart.hidden_props = [];
    }
    
    if ( b_hide )
    {
        zm_sat_mantis::set_boss_fight_clips( 1 );
        level.var_d88cef28da748af0 = [];
        level.var_d88cef28da748af0 = arraycombine( level.var_d88cef28da748af0, zone_manager::function_f9e008bb6267b256( "house1" ) );
        level.var_d88cef28da748af0 = arraycombine( level.var_d88cef28da748af0, zone_manager::function_f9e008bb6267b256( "house2" ) );
        
        foreach ( s_magic_box in level.var_1bbb5557537e2c0c )
        {
            level.var_70c5979783790e1b = 1;
            
            if ( s_magic_box.mdl_magicbox callback::exists( #"on_ping", &magicbox::magicbox_on_ping ) )
            {
                s_magic_box.mdl_magicbox callback::remove( #"on_ping", &magicbox::magicbox_on_ping );
            }
            
            s_magic_box magicbox::hide_magicbox( 1 );
            
            if ( isdefined( s_magic_box.mdl_magicbox ) )
            {
                if ( isent( s_magic_box.mdl_magicbox ) )
                {
                    s_magic_box.mdl_magicbox delete();
                }
                else
                {
                    s_magic_box.mdl_magicbox freescriptable();
                }
            }
            
            if ( !isdefined( level.s_dark_heart.hidden_props[ "magic_box" ] ) )
            {
                level.s_dark_heart.hidden_props[ "magic_box" ] = [];
            }
            
            level.s_dark_heart.hidden_props[ "magic_box" ][ level.s_dark_heart.hidden_props[ "magic_box" ].size ] = s_magic_box;
        }
        
        foreach ( s_perk_machine in level.a_s_perk_machines )
        {
            if ( !isdefined( s_perk_machine.mdl_perk_machine ) )
            {
                continue;
            }
            
            if ( isdefined( s_perk_machine.mdl_perk_machine.jingle_trigger ) )
            {
                s_perk_machine.mdl_perk_machine.jingle_trigger delete();
            }
            
            if ( isent( s_perk_machine.mdl_perk_machine ) )
            {
                s_perk_machine.mdl_perk_machine.interact delete();
            }
            
            if ( isent( s_perk_machine.mdl_perk_machine ) )
            {
                s_perk_machine.mdl_perk_machine delete();
            }
            else if ( s_perk_machine.mdl_perk_machine )
            {
                s_perk_machine.mdl_perk_machine freescriptable();
            }
            
            level notify( s_perk_machine.script_noteworthy + "_power_thread_end" );
            
            if ( !isdefined( level.s_dark_heart.hidden_props[ "perk_machine" ] ) )
            {
                level.s_dark_heart.hidden_props[ "perk_machine" ] = [];
            }
            
            level.s_dark_heart.hidden_props[ "perk_machine" ][ level.s_dark_heart.hidden_props[ "perk_machine" ].size ] = s_perk_machine;
        }
        
        foreach ( s_arsenal_location in level.var_52e94a468e66d601 )
        {
            if ( isdefined( s_arsenal_location.mdl_arsenal ) )
            {
                if ( isent( s_arsenal_location.mdl_arsenal ) )
                {
                    s_arsenal_location.mdl_arsenal.interact freescriptable();
                    s_arsenal_location.mdl_arsenal delete();
                }
                else
                {
                    s_arsenal_location.mdl_arsenal.interact freescriptable();
                    s_arsenal_location.mdl_arsenal freescriptable();
                }
                
                if ( !isdefined( level.s_dark_heart.hidden_props[ "arsenal" ] ) )
                {
                    level.s_dark_heart.hidden_props[ "arsenal" ] = [];
                }
                
                level.s_dark_heart.hidden_props[ "arsenal" ][ level.s_dark_heart.hidden_props[ "arsenal" ].size ] = s_arsenal_location;
            }
        }
        
        foreach ( var_6eb44bcc018fedcb in level.var_e0910c7bd4aab6fc )
        {
            if ( isdefined( var_6eb44bcc018fedcb.mdl_bgb_machine ) )
            {
                if ( isent( var_6eb44bcc018fedcb.mdl_bgb_machine ) )
                {
                    var_6eb44bcc018fedcb.mdl_bgb_machine.interact delete();
                    
                    if ( isdefined( var_6eb44bcc018fedcb.mdl_bgb_machine ) )
                    {
                        var_6eb44bcc018fedcb.mdl_bgb_machine delete();
                    }
                }
                else
                {
                    var_6eb44bcc018fedcb.mdl_bgb_machine freescriptable();
                }
                
                if ( !isdefined( level.s_dark_heart.hidden_props[ "bgb" ] ) )
                {
                    level.s_dark_heart.hidden_props[ "bgb" ] = [];
                }
                
                level.s_dark_heart.hidden_props[ "bgb" ][ level.s_dark_heart.hidden_props[ "bgb" ].size ] = var_6eb44bcc018fedcb;
            }
        }
        
        foreach ( instance in level.contentmanager.spawnedinstances[ "wallbuy" ] )
        {
            if ( isdefined( instance.var_1d6cddfc47031bff ) && instance.var_1d6cddfc47031bff.size > 0 )
            {
                foreach ( wallbuy_spawn in instance.var_1d6cddfc47031bff[ "wallbuy_spawn" ] )
                {
                    if ( isdefined( wallbuy_spawn.wallbuy_scriptable ) )
                    {
                        wallbuy_spawn.wallbuy_scriptable freescriptable();
                        
                        if ( !isdefined( level.s_dark_heart.hidden_props[ "wallbuy" ] ) )
                        {
                            level.s_dark_heart.hidden_props[ "wallbuy" ] = [];
                        }
                        
                        level.s_dark_heart.hidden_props[ "wallbuy" ][ level.s_dark_heart.hidden_props[ "wallbuy" ].size ] = wallbuy_spawn;
                    }
                }
            }
        }
        
        foreach ( s_pap_location in level.var_db52bcfd04d45a7a )
        {
            if ( isent( s_pap_location.var_370acb837a3a86c3.interact ) )
            {
                s_pap_location.var_370acb837a3a86c3.interact delete();
            }
            else if ( isdefined( s_pap_location.var_370acb837a3a86c3.interact ) )
            {
                s_pap_location.var_370acb837a3a86c3.interact freescriptable();
            }
            
            if ( isdefined( s_pap_location.var_370acb837a3a86c3 ) )
            {
                if ( isent( s_pap_location.var_370acb837a3a86c3 ) )
                {
                    s_pap_location.var_370acb837a3a86c3 delete();
                }
                else
                {
                    s_pap_location.var_370acb837a3a86c3 freescriptable();
                }
                
                s_pap_location.var_370acb837a3a86c3 = undefined;
            }
            
            if ( !isdefined( level.s_dark_heart.hidden_props[ "pap" ] ) )
            {
                level.s_dark_heart.hidden_props[ "pap" ] = [];
            }
            
            level.s_dark_heart.hidden_props[ "pap" ][ level.s_dark_heart.hidden_props[ "pap" ].size ] = s_pap_location;
        }
        
        zm_exfil_sat::zm_exfil_objective_icon( 0 );
        
        foreach ( sub_exfil in level.s_zm_exfil.var_c7cfc464905e7bcd )
        {
            if ( isdefined( sub_exfil.scriptable ) )
            {
                sub_exfil.scriptable freescriptable();
            }
            
            if ( isdefined( sub_exfil.interact ) )
            {
                sub_exfil.interact freescriptable();
            }
            
            if ( !isdefined( level.s_dark_heart.hidden_props[ "exfil" ] ) )
            {
                level.s_dark_heart.hidden_props[ "exfil" ] = [];
            }
            
            level.s_dark_heart.hidden_props[ "exfil" ][ level.s_dark_heart.hidden_props[ "exfil" ].size ] = sub_exfil;
        }
        
        level callback::remove( "on_round_start", &zm_exfil_sat::on_round_start );
        level callback::remove( "on_round_end", &zm_exfil_sat::on_round_end );
        
        foreach ( mdl_intel in level.var_bb461868542d6ed3 )
        {
            if ( mdl_intel utility::function_9f2c41c1dcc8c94( mdl_intel.type, "visible" ) )
            {
                mdl_intel utility::function_7c10ea82c1e305b8( mdl_intel.type, "hidden" );
                mdl_intel.var_62a9bdaf94475db8 = 1;
            }
        }
        
        foreach ( s_ammo_box in level._ammo_cache_info.var_ea07e36d8fd28578 )
        {
            if ( s_ammo_box function_b06e2126ef7c4b3c() )
            {
                if ( isdefined( s_ammo_box.ammocache_trigger ) )
                {
                    if ( isdefined( s_ammo_box.ammocache_trigger.var_a3338cc37b82b7b3 ) )
                    {
                        if ( isent( s_ammo_box.ammocache_trigger.var_a3338cc37b82b7b3 ) )
                        {
                            s_ammo_box.ammocache_trigger.var_a3338cc37b82b7b3 delete();
                        }
                        else
                        {
                            s_ammo_box.ammocache_trigger.var_a3338cc37b82b7b3 freescriptable();
                        }
                        
                        if ( !isdefined( level.s_dark_heart.hidden_props[ "ammo_box" ] ) )
                        {
                            level.s_dark_heart.hidden_props[ "ammo_box" ] = [];
                        }
                        
                        level.s_dark_heart.hidden_props[ "ammo_box" ][ level.s_dark_heart.hidden_props[ "ammo_box" ].size ] = s_ammo_box;
                    }
                }
            }
        }
        
        foreach ( s_crafting_table in level.a_s_crafting_tables )
        {
            if ( isdefined( s_crafting_table.var_7fac639c5e7fd54.interact ) )
            {
                s_crafting_table.var_7fac639c5e7fd54.interact freescriptable();
            }
            
            if ( isdefined( s_crafting_table.var_7fac639c5e7fd54 ) )
            {
                s_crafting_table.var_7fac639c5e7fd54 delete();
            }
            
            if ( !isdefined( level.s_dark_heart.hidden_props[ "crafting_table" ] ) )
            {
                level.s_dark_heart.hidden_props[ "crafting_table" ] = [];
            }
            
            level.s_dark_heart.hidden_props[ "crafting_table" ][ level.s_dark_heart.hidden_props[ "crafting_table" ].size ] = s_crafting_table;
        }
        
        switchs = utility::getstructarray( "electro_shock_trap_switch", "targetname" );
        
        foreach ( switch_pos in switchs )
        {
            foreach ( sub_switch_pos in switch_pos.a_switch_pos )
            {
                if ( isdefined( sub_switch_pos.switch_scriptable ) && isdefined( sub_switch_pos.interact ) )
                {
                    sub_switch_pos.switch_scriptable setscriptablepartstate( "icon", "idle" );
                }
            }
        }
        
        switchs = utility::getstructarray( "electro_shock_trap_garage_switch", "targetname" );
        
        foreach ( switch_pos in switchs )
        {
            foreach ( sub_switch_pos in switch_pos.a_switch_pos )
            {
                if ( isdefined( sub_switch_pos.switch_scriptable ) && isdefined( sub_switch_pos.interact ) )
                {
                    sub_switch_pos.switch_scriptable setscriptablepartstate( "icon", "idle" );
                }
            }
        }
        
        future_crafting_table = getent( "ww_quest_crafting_table_future", "script_noteworthy" );
        
        if ( isent( future_crafting_table ) )
        {
            future_crafting_table hide();
            
            if ( !isdefined( level.s_dark_heart.hidden_props[ "ww_crafting_table" ] ) )
            {
                level.s_dark_heart.hidden_props[ "ww_crafting_table" ] = [];
            }
            
            level.s_dark_heart.hidden_props[ "ww_crafting_table" ][ level.s_dark_heart.hidden_props[ "ww_crafting_table" ].size ] = future_crafting_table;
        }
        
        if ( isdefined( level.var_a3eb428773fa9129 ) )
        {
            level.s_dark_heart.hidden_props[ "teddtask" ] = level.var_a3eb428773fa9129;
            level.var_d1b86166c79a010b = level.var_a3eb428773fa9129;
            level.var_8cff5e93e7f5e8 = undefined;
            level.var_a3eb428773fa9129 teddtasks::hide_teddtask( 1 );
            level.var_a3eb428773fa9129 = undefined;
            level.var_55239d3fb3c08d7a = 0;
        }
        
        if ( level.s_rampage )
        {
            level.s_rampage.mdl hide();
            level.s_rampage.interact disableplayeruseforallplayers();
        }
        
        a_clips = getentarray( "interactable_clip", #targetname );
        
        foreach ( clip in a_clips )
        {
            clip hide();
            clip connectpaths();
        }
        
        a_clips = getentarray( "perk_machine_choice_clip", #targetname );
        
        foreach ( clip in a_clips )
        {
            clip hide();
            clip connectpaths();
        }
        
        namespace_24edb5d87524aa7f::function_1648acfd459e6d51();
        var_7d1749d76868cceb = utility::getstructarray( "pu_ee_spawn", "targetname" );
        
        foreach ( powerup_struct in var_7d1749d76868cceb )
        {
            if ( powerup_struct.scriptable )
            {
                powerup_struct.scriptable.origin = powerup_struct.origin - ( 0, 0, 50000 );
            }
        }
        
        return;
    }
    
    zm_sat_mantis::set_boss_fight_clips( 0 );
    
    if ( isdefined( level.var_d88cef28da748af0 ) )
    {
        foreach ( zone_name in level.var_d88cef28da748af0 )
        {
            zone_manager::set_zone_enabled( zone_name, 1 );
        }
        
        level.var_d88cef28da748af0 = undefined;
    }
    
    if ( isdefined( level.s_dark_heart.hidden_props[ "magic_box" ] ) )
    {
        level.var_70c5979783790e1b = 0;
        
        foreach ( s_magic_box in level.s_dark_heart.hidden_props[ "magic_box" ] )
        {
            s_magic_box magicbox::function_ab59e6993557d5b6();
            
            if ( s_magic_box.var_f14b2b4820b635e7 )
            {
                s_magic_box magicbox::show_magicbox( 0 );
                continue;
            }
            
            s_magic_box magicbox::hide_magicbox( 0 );
        }
    }
    
    if ( isdefined( level.s_dark_heart.hidden_props[ "ammo_box" ] ) )
    {
        foreach ( s_ammo_box in level.s_dark_heart.hidden_props[ "ammo_box" ] )
        {
            level thread ammo_cache::function_48881059553792e5( s_ammo_box );
        }
    }
    
    if ( isdefined( level.s_dark_heart.hidden_props[ "perk_machine" ] ) )
    {
        foreach ( s_perk_machine in level.s_dark_heart.hidden_props[ "perk_machine" ] )
        {
            if ( s_perk_machine.content_key == "perk_machine_choice_spawn" )
            {
                s_perk_machine thread namespace_34fc1661493f2405::function_e3d3bfcc06c89350( s_perk_machine );
                continue;
            }
            
            s_perk_machine thread namespace_34fc1661493f2405::function_9a3e81eb8357ad32( s_perk_machine );
        }
    }
    
    if ( isdefined( level.s_dark_heart.hidden_props[ "arsenal" ] ) )
    {
        foreach ( s_arsenal_location in level.s_dark_heart.hidden_props[ "arsenal" ] )
        {
            s_arsenal_location thread arsenal::init_arsenal_machine();
        }
    }
    
    if ( isdefined( level.s_dark_heart.hidden_props[ "bgb" ] ) )
    {
        foreach ( var_6eb44bcc018fedcb in level.s_dark_heart.hidden_props[ "bgb" ] )
        {
            var_6eb44bcc018fedcb thread bgb_machine::function_9a3e81eb8357ad32();
            time_travel::register_timetravel_entity( var_6eb44bcc018fedcb );
            time_travel::register_timetravel_entity( var_6eb44bcc018fedcb.mdl_bgb_machine );
        }
    }
    
    if ( isdefined( level.s_dark_heart.hidden_props[ "wallbuy" ] ) )
    {
        foreach ( wallbuy_spawn in level.s_dark_heart.hidden_props[ "wallbuy" ] )
        {
            thread wallbuy::function_c2a9b9b2e4b90c0a( wallbuy_spawn );
        }
    }
    
    if ( isdefined( level.s_dark_heart.hidden_props[ "pap" ] ) )
    {
        foreach ( pap_spawn in level.s_dark_heart.hidden_props[ "pap" ] )
        {
            pap_spawn thread pack_a_punch::init_pap_machine();
            
            while ( !isdefined( pap_spawn.var_370acb837a3a86c3 ) )
            {
                waitframe();
            }
            
            if ( !isdefined( pap_spawn ) || !isdefined( pap_spawn.var_370acb837a3a86c3 ) )
            {
                return;
            }
            
            time_travel::register_timetravel_entity( pap_spawn );
            time_travel::register_timetravel_entity( pap_spawn.var_370acb837a3a86c3 );
        }
    }
    
    if ( isdefined( level.s_dark_heart.hidden_props[ "exfil" ] ) )
    {
        foreach ( exfil_spawn in level.s_dark_heart.hidden_props[ "exfil" ] )
        {
            exfil_spawn.states = "disable";
            exfil_spawn zm_exfil_sat::function_50e4131b11f82b59();
            exfil_spawn.scriptable = spawnscriptable( level.s_zm_exfil.var_60451de0b132b4cd, exfil_spawn.origin, exfil_spawn.angles );
            exfil_spawn.interact = spawnscriptable( "zm_sat_exfil_scriptable_interact", exfil_spawn.var_b03fab8f4be015ad.origin );
            
            if ( !isdefined( exfil_spawn.script_radius ) )
            {
                exfil_spawn.script_radius = 10000;
            }
            
            exfil_spawn.exfil_radius = level.s_zm_exfil.var_10c0281725395dde[ exfil_spawn.script_noteworthy ].sublocationsize ?? 1250;
            
            if ( isdefined( exfil_spawn.interact ) )
            {
                exfil_spawn.interact.s_exfil = exfil_spawn;
                interaction::register_scriptable_interact( exfil_spawn.interact, &zm_exfil_sat::on_exfil_interact_used, undefined, undefined, &zm_exfil_sat::exfil_interact_hint_callback );
                exfil_spawn.interact interaction::function_e4a4753e6eac02d7();
            }
            
            exfil_spawn utility::callsharedfunc( #"zombie", #"hash_896b88a46f6a4c15", "exfil" );
        }
        
        zm_exfil_sat::function_e6d25909c7962ebf( "disable" );
    }
    
    if ( !level callback::exists( "on_round_start", &zm_exfil_sat::on_round_start ) )
    {
        level callback::add( "on_round_start", &zm_exfil_sat::on_round_start );
    }
    
    if ( !level callback::exists( "on_round_end", &zm_exfil_sat::on_round_end ) )
    {
        level callback::add( "on_round_end", &zm_exfil_sat::on_round_end );
    }
    
    if ( isdefined( level.s_dark_heart.hidden_props[ "crafting_table" ] ) )
    {
        foreach ( s_crafting_table in level.s_dark_heart.hidden_props[ "crafting_table" ] )
        {
            s_crafting_table thread crafting_table::spawn_crafting_table();
        }
    }
    
    if ( isdefined( level.s_dark_heart.hidden_props[ "ww_crafting_table" ] ) )
    {
        level.s_dark_heart.hidden_props[ "ww_crafting_table" ][ 0 ] show();
    }
    
    switchs = utility::getstructarray( "electro_shock_trap_switch", "targetname" );
    
    foreach ( switch_pos in switchs )
    {
        foreach ( sub_switch_pos in switch_pos.a_switch_pos )
        {
            if ( isdefined( sub_switch_pos.switch_scriptable ) && isdefined( sub_switch_pos.interact ) )
            {
                sub_switch_pos.switch_scriptable setscriptablepartstate( "icon", "active" );
            }
        }
    }
    
    switchs = utility::getstructarray( "electro_shock_trap_garage_switch", "targetname" );
    
    foreach ( switch_pos in switchs )
    {
        foreach ( sub_switch_pos in switch_pos.a_switch_pos )
        {
            if ( isdefined( sub_switch_pos.switch_scriptable ) && isdefined( sub_switch_pos.interact ) )
            {
                sub_switch_pos.switch_scriptable setscriptablepartstate( "icon", "active" );
            }
        }
    }
    
    if ( level.s_rampage )
    {
        level.s_rampage.mdl show();
        level.s_rampage.interact enableplayeruseforallplayers();
    }
    
    a_clips = getentarray( "interactable_clip", #targetname );
    
    foreach ( clip in a_clips )
    {
        clip show();
        clip disconnectpaths();
    }
    
    a_clips = getentarray( "perk_machine_choice_clip", #targetname );
    
    foreach ( clip in a_clips )
    {
        clip show();
        clip disconnectpaths();
    }
    
    foreach ( mdl_intel in level.var_bb461868542d6ed3 )
    {
        if ( mdl_intel.var_f6fb87fac0412713 )
        {
            mdl_intel utility::function_7c10ea82c1e305b8( mdl_intel.type, "visible" );
            mdl_intel.var_62a9bdaf94475db8 = undefined;
        }
    }
    
    namespace_24edb5d87524aa7f::function_d8e84003f6104768();
    var_7d1749d76868cceb = utility::getstructarray( "pu_ee_spawn", "targetname" );
    
    foreach ( powerup_struct in var_7d1749d76868cceb )
    {
        if ( powerup_struct.scriptable )
        {
            powerup_struct.scriptable.origin = powerup_struct.origin;
        }
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 0
// Checksum 0xfe4372f, Offset: 0x489b
// Size: 0x47
function function_34e1f438c139fd40()
{
    level endon( #"game_ended" );
    utility::ent_flag_wait( "exfil_phone_booth_active" );
    
    if ( !objidpoolmanager::function_fb05d646a96ed99e( self.var_c6883f07ae9a466 ) )
    {
        objidpoolmanager::returnobjectiveid( self.var_c6883f07ae9a466 );
    }
    
    self.var_c6883f07ae9a466 = undefined;
}

// Namespace zm_sat_mantis_boss_fight
// Params 0
// Checksum 0x9be25393, Offset: 0x48ea
// Size: 0x64, Type: bool
function function_b06e2126ef7c4b3c()
{
    zone_struct = zone_manager::function_90e5c3e2272b0130( self.origin );
    var_74fcf906cce39d69 = [ "zone_culdesac_4_f", "zone_culdesac_3_f", "zone_culdesac_2_f", "zone_culdesac_1_f" ];
    
    if ( arraycontains( var_74fcf906cce39d69, zone_struct.zone_name ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_sat_mantis_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x1892213e, Offset: 0x4957
// Size: 0x159
function private function_5597c1d89e08301e()
{
    possible_bundles = [];
    
    if ( isdefined( level.directed_mode ) || getdvarint( @"hash_1dcf1f9afda7d384", 0 ) )
    {
        possible_bundles[ possible_bundles.size ] = "zm_guided";
    }
    else if ( level.var_8a98c33a6b47db4a )
    {
        if ( zm_utility::get_round_number() >= 100 )
        {
            possible_bundles[ possible_bundles.size ] = "zm_rb_r_mod_round100";
        }
        
        possible_bundles[ possible_bundles.size ] = "zm_rb_r_mod";
    }
    else if ( zm_utility::get_round_number() >= 100 )
    {
        possible_bundles[ possible_bundles.size ] = "round100";
    }
    
    possible_bundles[ possible_bundles.size ] = "default";
    var_86976c7090853462 = getscriptbundlenames( "mantisbossfightsetting" );
    
    for ( bundle_i = 0; bundle_i < var_86976c7090853462.size ; bundle_i++ )
    {
        var_1f839ab22d85993e = possible_bundles[ bundle_i ];
        
        if ( isdefined( var_1f839ab22d85993e ) )
        {
            foreach ( bundle_name in var_86976c7090853462 )
            {
                selectorid = getscriptbundlefieldvalue( bundle_name, "selectorID" );
                
                if ( var_1f839ab22d85993e == selectorid )
                {
                    return getscriptbundle( bundle_name );
                }
            }
        }
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 0
// Checksum 0x703fec05, Offset: 0x4ab9
// Size: 0x8cc
function init_boss_fight_data()
{
    if ( !isdefined( level.s_dark_heart ) )
    {
        level.s_dark_heart = utility::getstruct( "dark_heart", "targetname" );
    }
    
    level.s_dark_heart.empowered_ai_spawn_pos = utility::getstruct( level.s_dark_heart.target, "targetname" );
    level.s_dark_heart.empowered_ai_spawn_pos.origin = playerphysicstrace( level.s_dark_heart.empowered_ai_spawn_pos.origin, level.s_dark_heart.empowered_ai_spawn_pos.origin - ( 0, 0, 2000 ) );
    level.s_dark_heart.var_dd5147eb36a3795b = utility::getstructarray( "hold_out_pos", "targetname" );
    var_713e58edbcfc94fd = function_5597c1d89e08301e();
    level.s_dark_heart.var_6b7fb2da3cdf5121 = var_713e58edbcfc94fd.var_6b7fb2da3cdf5121;
    level.s_dark_heart.var_6b83b8da3ce3542a = var_713e58edbcfc94fd.var_6b83b8da3ce3542a;
    level.s_dark_heart.var_6b889eda3ce943d3 = var_713e58edbcfc94fd.var_6b889eda3ce943d3;
    level.s_dark_heart.var_6b8ca4da3ced46dc = var_713e58edbcfc94fd.var_6b8ca4da3ced46dc;
    level.s_dark_heart.addlootdrop = var_713e58edbcfc94fd.addlootdrop;
    level.s_dark_heart.var_2d7524092817db6 = var_713e58edbcfc94fd.var_2d7524092817db6;
    level.s_dark_heart.var_cca965b84c48b00f = var_713e58edbcfc94fd.var_cca965b84c48b00f;
    level.s_dark_heart.var_e7ac82c3d3ba5912 = var_713e58edbcfc94fd.var_e7ac82c3d3ba5912;
    level.s_dark_heart.var_d07e037c6b464a34 = var_713e58edbcfc94fd.var_d07e037c6b464a34;
    level.s_dark_heart.var_866c19b01728299d = var_713e58edbcfc94fd.var_866c19b01728299d;
    level.s_dark_heart.var_ed986d78eb317490 = var_713e58edbcfc94fd.var_ed986d78eb317490;
    level.s_dark_heart.var_ac3a72eca9614929 = var_713e58edbcfc94fd.var_ac3a72eca9614929;
    level.s_dark_heart.var_e6ce268bfd284469 = var_713e58edbcfc94fd.var_e6ce268bfd284469;
    level.s_dark_heart.var_e3c2ac9fcfd8c969 = var_713e58edbcfc94fd.var_e3c2ac9fcfd8c969;
    level.s_dark_heart.var_aef1ddbdd1302ad = var_713e58edbcfc94fd.var_aef1ddbdd1302ad;
    level.s_dark_heart.var_f669562d26db78fb = var_713e58edbcfc94fd.var_f669562d26db78fb;
    level.s_dark_heart.var_4d7e6e82d94ec102 = var_713e58edbcfc94fd.var_4d7e6e82d94ec102;
    level.s_dark_heart.var_5a7fba6ed06b555 = var_713e58edbcfc94fd.var_5a7fba6ed06b555;
    level.s_dark_heart.var_51b0a88b4cbc8abd = var_713e58edbcfc94fd.var_51b0a88b4cbc8abd;
    level.s_dark_heart.var_80b660108d58f4b = var_713e58edbcfc94fd.var_80b660108d58f4b;
    level.s_dark_heart.var_ebe0609bbd5a07fb = var_713e58edbcfc94fd.var_ebe0609bbd5a07fb;
    level.s_dark_heart.var_44377bd2d6893340 = var_713e58edbcfc94fd.var_44377bd2d6893340;
    level.s_dark_heart.var_b57ab356d9dfe739 = var_713e58edbcfc94fd.var_b57ab356d9dfe739;
    level.s_dark_heart.var_80e2f41143cffee8 = var_713e58edbcfc94fd.var_80e2f41143cffee8;
    level.s_dark_heart.var_19e016cb93c64f32 = var_713e58edbcfc94fd.var_19e016cb93c64f32;
    level.s_dark_heart.var_3df2fc04bcb8c892 = var_713e58edbcfc94fd.var_3df2fc04bcb8c892;
    level.s_dark_heart.var_f65206af4898988a = var_713e58edbcfc94fd.var_f65206af4898988a;
    level.s_dark_heart.var_b318cf494148e84a = var_713e58edbcfc94fd.var_b318cf494148e84a;
    level.s_dark_heart.var_6d40b3416ad02400 = var_713e58edbcfc94fd.var_6d40b3416ad02400;
    level.s_dark_heart.var_b88224dba6887bbf = var_713e58edbcfc94fd.var_b88224dba6887bbf;
    level.s_dark_heart.var_d605a9a2b97e045d = var_713e58edbcfc94fd.var_d605a9a2b97e045d;
    level.s_dark_heart.var_c2bc6cf99d373c89 = var_713e58edbcfc94fd.var_c2bc6cf99d373c89;
    level.s_dark_heart.var_4fb44c4b10c953f7 = var_713e58edbcfc94fd.var_4fb44c4b10c953f7;
    level.s_dark_heart.var_309ee00c69f0c927 = var_713e58edbcfc94fd.var_309ee00c69f0c927;
    level.s_dark_heart.var_3091ce0c69e28d0c = var_713e58edbcfc94fd.var_3091ce0c69e28d0c;
    level.s_dark_heart.var_3095d40c69e69015 = var_713e58edbcfc94fd.var_3095d40c69e69015;
    level.s_dark_heart.var_3088e20c69d89a5a = var_713e58edbcfc94fd.var_3088e20c69d89a5a;
    level.s_dark_heart.var_f1523af5d7397654 = var_713e58edbcfc94fd.var_f1523af5d7397654;
    level.s_dark_heart.var_f15f2cf5d7476c0f = var_713e58edbcfc94fd.var_f15f2cf5d7476c0f;
    level.s_dark_heart.var_f15b26f5d7436906 = var_713e58edbcfc94fd.var_f15b26f5d7436906;
    level.s_dark_heart.var_f14528f5d72b3a39 = var_713e58edbcfc94fd.var_f14528f5d72b3a39;
    level.s_dark_heart.phase_data = [];
    level.s_dark_heart.phase_data[ "phase_1" ] = var_713e58edbcfc94fd.var_2853cead7dfe6e74;
    level.s_dark_heart.phase_data[ "phase_2" ] = var_713e58edbcfc94fd.var_e9eefe2f49d85025;
    level.s_dark_heart.phase_data[ "phase_3" ] = var_713e58edbcfc94fd.var_2c15462ad77ff0c2;
    
    foreach ( var_576d220b01160c72 in level.s_dark_heart.var_dd5147eb36a3795b )
    {
        var_3010f232fa3880d9 = utility::getstructarray( var_576d220b01160c72.target, "targetname" );
        
        foreach ( pos in var_3010f232fa3880d9 )
        {
            if ( pos.script_noteworthy == "phase_1" )
            {
                var_576d220b01160c72.var_5374fb111c0954f1 = utility::getstructarray( pos.target, "targetname" );
                continue;
            }
            
            if ( pos.script_noteworthy == "phase_2" )
            {
                var_576d220b01160c72.var_6b70d581e6e6843c = utility::getstructarray( pos.target, "targetname" );
                continue;
            }
            
            if ( pos.script_noteworthy == "twins_pos" )
            {
                var_576d220b01160c72.twins_positions = utility::getstructarray( pos.target, "targetname" );
            }
        }
    }
    
    if ( level.timetravel )
    {
        foreach ( s_timeline in level.timetravel.timelines )
        {
            if ( s_timeline.name == "future" )
            {
                level.timetravel.timeline = s_timeline;
                break;
            }
        }
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 0
// Checksum 0x901ea9f4, Offset: 0x538d
// Size: 0x12a
function function_199554ef8113dca1()
{
    foreach ( phase_name, phase_data in level.s_dark_heart.phase_data )
    {
        foreach ( index, spawnlist in phase_data.zombiespawnlist )
        {
            spawn_amount = function_d290ffaebf93d4d6( spawnlist );
            zm_quest::function_f3521e80c38a757e( phase_name, index, spawn_amount, spawnlist.spawninterval, spawnlist.type, spawnlist.spawnweight );
        }
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 0
// Checksum 0x75c11bb5, Offset: 0x54bf
// Size: 0x5be
function boss_fight_phase_check()
{
    level endon( #"game_ended" );
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
    
    level thread init_boss_fight_phase( "phase_1" );
    thread zm_quest::update_guidance( [ [ level.s_dark_heart.var_dd5147eb36a3795b[ 0 ].var_5374fb111c0954f1[ 0 ] ], [ level.s_dark_heart.var_dd5147eb36a3795b[ 1 ].var_5374fb111c0954f1[ 0 ] ], [ level.s_dark_heart.var_dd5147eb36a3795b[ 2 ].var_5374fb111c0954f1[ 0 ] ] ], #"mantis_mq_guidance", #"hash_2779d097f29bfd9a" );
    level utility::flag_wait( "musical_item_ready" );
    level utility::flag_set( "boss_fight_phase_1_start" );
    level.s_dark_heart.boss_agent thread function_35cbed5ec70ac10e();
    level utility::flag_wait( "boss_fight_phase_1_done" );
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_54533f623f808a30" );
    level notify( #"end_twins_charge_check" );
    zm_sat_mantis_boss_fight_twins::function_dc1f2f5a8607c47();
    level.s_dark_heart.boss_agent notify( #"hash_fe42b70a485ecf86" );
    level.s_dark_heart.boss_agent setscriptablepartstate( "sound_spirit_converge_riser", "start" );
    function_751266bed71d935b( "phase_1" );
    function_1d105e8b51d70eff( "phase_1" );
    level notify( #"hash_c7c160a672d4726a" );
    function_9ac001a7367271d4( 1, "phase_1" );
    thread zm_quest::update_guidance( undefined, #"mantis_mq_guidance", #"boss_attack" );
    
    if ( level.s_dark_heart.boss_agent.n_fight_phase <= 1 )
    {
        level.s_dark_heart.boss_agent waittill( #"phase_changed" );
    }
    
    level zm_quest::clear_all_guidance();
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_ec949966bce6b5e4" );
    function_9ac001a7367271d4( 0 );
    level thread zm_quest::cleanup_zombies_manually( 1, undefined, undefined, undefined, 0, 1, 0, undefined, undefined, undefined, 1 );
    zm_quest::stop_wave_spawner( "phase_1", undefined, 1 );
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x33>" );
    #/
    
    level.s_dark_heart.boss_agent thread function_35cbed5ec70ac10e();
    level thread init_boss_fight_phase( "phase_2" );
    powerup_origin = utility::getstruct( "bf_fullammo_phase2", "script_noteworthy" ).origin;
    level powerups::powerup_drop( "full_ammo", powerup_origin, 60, undefined, "boss" );
    
    if ( !level.var_8a98c33a6b47db4a )
    {
        level powerups::powerup_drop( "full_armor", powerup_origin + utility::function_9e0df7b136ab833c() * 100, 60, undefined, "boss" );
    }
    
    level utility::flag_wait( "boss_fight_phase_2_done" );
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_545342623f808f49" );
    level notify( #"end_twins_charge_check" );
    zm_sat_mantis_boss_fight_twins::function_dc1f2f5a8607c47();
    level.s_dark_heart.boss_agent notify( #"hash_fe42b70a485ecf86" );
    level.s_dark_heart.boss_agent setscriptablepartstate( "sound_spirit_converge_riser", "start" );
    function_751266bed71d935b( "phase_2" );
    function_1d105e8b51d70eff( "phase_2" );
    level notify( #"hash_c7c160a672d4726a" );
    function_9ac001a7367271d4( 1, "phase_2" );
    thread zm_quest::update_guidance( undefined, #"mantis_mq_guidance", #"boss_attack" );
    
    if ( level.s_dark_heart.boss_agent.n_fight_phase <= 2 )
    {
        level.s_dark_heart.boss_agent waittill( #"phase_changed" );
    }
    
    level zm_quest::clear_all_guidance();
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_ec949a66bce6b797" );
    function_9ac001a7367271d4( 0 );
    level thread zm_quest::cleanup_zombies_manually( 1, undefined, undefined, undefined, 0, 1, 0, undefined, undefined, undefined, 1 );
    zm_quest::stop_wave_spawner( "phase_2", undefined, 1 );
    wait 1;
    thread zm_quest::update_guidance( undefined, #"mantis_mq_guidance", #"hash_2779ce97f29bfa34" );
    
    /#
        iprintlnbold( "<dev string:x42>" );
    #/
    
    level.s_dark_heart.boss_agent thread function_35cbed5ec70ac10e();
    level thread init_boss_fight_phase( "phase_3" );
    powerup_origin = utility::getstruct( "bf_fullammo_phase2", "script_noteworthy" ).origin;
    level powerups::powerup_drop( "full_ammo", powerup_origin, 60, undefined, "boss" );
    
    if ( !level.var_8a98c33a6b47db4a )
    {
        level powerups::powerup_drop( "full_armor", powerup_origin + utility::function_9e0df7b136ab833c() * 100, 60, undefined, "boss" );
    }
    
    level utility::flag_wait( "boss_fight_phase_3_done" );
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_545341623f808d96" );
    level notify( #"end_twins_charge_check" );
    zm_sat_mantis_boss_fight_twins::function_dc1f2f5a8607c47();
    level.s_dark_heart.boss_agent notify( #"hash_fe42b70a485ecf86" );
    level.s_dark_heart.boss_agent setscriptablepartstate( "sound_spirit_converge_riser", "start" );
    function_751266bed71d935b( "phase_3" );
    function_1d105e8b51d70eff( "phase_3" );
    level notify( #"hash_c7c160a672d4726a" );
    function_9ac001a7367271d4( 1, "phase_3" );
    thread zm_quest::update_guidance( undefined, #"mantis_mq_guidance", #"boss_attack" );
}

// Namespace zm_sat_mantis_boss_fight
// Params 1
// Checksum 0xe6d09ce5, Offset: 0x5a85
// Size: 0xdb
function function_462e8bdd6281a400( params )
{
    params = spawnstruct();
    params.timestamp = gettime();
    params.questname = #"zm_sat_mantis_mq";
    params.is_main_quest = 1;
    
    if ( isdefined( level.players ) )
    {
        level.players = function_5713d46873b29625( level.players );
        params.var_be82617e5e8087bd = level.players;
        level callback::callback( #"zm_mq_quest_complete", params );
        params.event = #"zm_mq_quest_complete";
        level callback::callback( #"hash_6c71d319dc089c27", params );
    }
    
    level thread function_63696a4351c63dd7();
    level thread vo_boss_death( params.eattacker );
    level zm_quest::clear_all_guidance();
}

// Namespace zm_sat_mantis_boss_fight
// Params 0
// Checksum 0x350c32ee, Offset: 0x5b68
// Size: 0x2b5
function function_63696a4351c63dd7()
{
    revive_all_players();
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"boss_outro" );
    
    if ( isdefined( level.s_dark_heart.fireball ) )
    {
        level.s_dark_heart.fireball delete();
    }
    
    zm_quest::stop_wave_spawner( "phase_1", 1, 0 );
    zm_quest::stop_wave_spawner( "phase_2", 1, 0 );
    zm_quest::stop_wave_spawner( "phase_3", 1, 0 );
    level thread zm_quest::cleanup_zombies_manually( 1, undefined, undefined, undefined, 0, 1, 1 );
    level.s_dark_heart notify( #"stop_health_listener" );
    playsoundatpos( level.s_dark_heart.boss_agent.origin, #"evt_mantis_boss_heart_death" );
    utility::flag_wait_or_timeout( "boss_fight_vo_done", 20 );
    wait 1;
    
    foreach ( player in level.players )
    {
        level thread game_utility::fadetoblackforplayer( player, 1, 2 );
    }
    
    wait 1.5;
    
    if ( level.s_dark_heart.black_ichor_puddle )
    {
        level.s_dark_heart.black_ichor_puddle delete();
    }
    
    wait 0.5;
    deactivateworldevent( "we_vfx_nuke_town_future_boss_fight_area" );
    function_9504b8fbe743abec();
    
    foreach ( player in level.players )
    {
        if ( player::isinlaststand( player ) )
        {
            player laststand::exit( "last_stand_revived", player );
        }
    }
    
    foreach ( player in level.players )
    {
        level thread game_utility::fadetoblackforplayer( player, 0, 0.5 );
    }
    
    cleanup_boss_fight();
    level utility::flag_set( "boss_fight_done" );
}

// Namespace zm_sat_mantis_boss_fight
// Params 1
// Checksum 0x4e04cb88, Offset: 0x5e25
// Size: 0x2eb
function init_boss_fight_phase( phase_name )
{
    level endon( #"game_ended" );
    var_1c98bd8307f669a3 = [];
    var_e3b8c9c29afc055a = [];
    
    foreach ( var_576d220b01160c72 in level.s_dark_heart.var_dd5147eb36a3795b )
    {
        var_576d220b01160c72.var_6eb21481f208c57f = 0;
        var_576d220b01160c72.b_released = 0;
        level utility::flag_clear( var_576d220b01160c72.script_noteworthy + "_finish_charge" );
        var_1c98bd8307f669a3[ var_1c98bd8307f669a3.size ] = var_576d220b01160c72.script_noteworthy + "_finish_charge";
        level utility::flag_clear( var_576d220b01160c72.script_noteworthy + "_finish_released" );
        var_e3b8c9c29afc055a[ var_e3b8c9c29afc055a.size ] = var_576d220b01160c72.script_noteworthy + "_finish_released";
    }
    
    foreach ( var_576d220b01160c72 in level.s_dark_heart.var_dd5147eb36a3795b )
    {
        var_576d220b01160c72.mdl.sbl setscriptablepartstate( "vfx", "dome" );
        var_576d220b01160c72.mdl.sbl setscriptablepartstate( "defend", "off" );
    }
    
    for ( var_86a8b6de8f7a9ab7 = level.s_dark_heart.var_dd5147eb36a3795b.size - 1; var_86a8b6de8f7a9ab7 >= 0 ; var_86a8b6de8f7a9ab7-- )
    {
        var_576d220b01160c72 = level.s_dark_heart.var_dd5147eb36a3795b[ var_86a8b6de8f7a9ab7 ];
        var_576d220b01160c72 thread function_b7b948c5250821a4();
        wait 2;
    }
    
    if ( phase_name == "phase_2" )
    {
        var_844a74aceafb732f = arrayrandomize( level.s_dark_heart.var_dd5147eb36a3795b );
        level thread namespace_a2abfabbd7a982fc::function_a110c6bb969aea4d( var_844a74aceafb732f );
    }
    
    if ( phase_name == "phase_3" )
    {
        level.s_dark_heart thread namespace_a2abfbbbd7a9852f::function_26586a1abc6350ac();
    }
    
    level thread function_1d105e8b51d70eff( phase_name );
    level utility::flag_wait_all_array( var_e3b8c9c29afc055a );
    level notify( #"hash_45c8729688962b7d" );
    level notify( #"boss_fight_defend_start" );
    level thread zm_sat_mantis_boss_fight_twins::function_59ca73d464acf47d( phase_name );
    level utility::flag_wait_all_array( var_1c98bd8307f669a3 );
    level zm_quest::clear_all_guidance();
    level utility::flag_set( "boss_fight_" + phase_name + "_done" );
    
    /#
        iprintlnbold( phase_name + "<dev string:x51>" );
    #/
}

// Namespace zm_sat_mantis_boss_fight
// Params 0
// Checksum 0xec75f190, Offset: 0x6118
// Size: 0x3f0
function cleanup_boss_fight()
{
    level utility::flag_clear( "start_boss_fight" );
    level notify( #"end_boss_attack" );
    
    if ( level.s_dark_heart.damage_proxy )
    {
        level.s_dark_heart.damage_proxy delete();
    }
    
    if ( level.s_dark_heart.cloud_scriptable )
    {
        level.s_dark_heart.cloud_scriptable freescriptable();
    }
    
    foreach ( var_576d220b01160c72 in level.s_dark_heart.var_dd5147eb36a3795b )
    {
        foreach ( souleater in var_576d220b01160c72.var_5374fb111c0954f1 )
        {
            if ( isdefined( souleater.sbl ) )
            {
                souleater.sbl freescriptable();
            }
        }
        
        if ( isdefined( var_576d220b01160c72.mdl.sbl ) )
        {
            var_576d220b01160c72.mdl.sbl freescriptable();
        }
        
        if ( isdefined( var_576d220b01160c72.mdl ) )
        {
            var_576d220b01160c72.mdl delete();
        }
        
        if ( isdefined( var_576d220b01160c72.var_a5f3683b57323812.mdl.sbl ) )
        {
            var_576d220b01160c72.var_a5f3683b57323812.mdl.sbl freescriptable();
        }
        
        if ( isdefined( var_576d220b01160c72.var_a5f3683b57323812.mdl ) )
        {
            var_576d220b01160c72.var_a5f3683b57323812.mdl delete();
        }
        
        if ( isdefined( var_576d220b01160c72.black_chulk ) )
        {
            var_576d220b01160c72.black_chulk freescriptable();
        }
        
        if ( isdefined( var_576d220b01160c72.black_dome.clip ) )
        {
            var_576d220b01160c72.black_dome.clip delete();
        }
        
        if ( isdefined( var_576d220b01160c72.black_dome ) )
        {
            var_576d220b01160c72.black_dome freescriptable();
        }
    }
    
    if ( level.s_dark_heart.black_ichor_puddle )
    {
        level.s_dark_heart.black_ichor_puddle delete();
    }
    
    foreach ( player in level.players )
    {
        player compass::function_d397f80372a5b227( 1 );
        player clearsoundsubmix( "sat_zm_mantis_boss" );
        player.var_7ab4c9acb317c405 = undefined;
    }
    
    removeallcorpses();
    zm_quest::function_2850bf8c7015dc92( [ "zone_culdesac_1_f", "zone_culdesac_2_f", "zone_culdesac_3_f", "zone_culdesac_4_f" ] );
    level.var_9c0d12c8f8edeb3d = undefined;
    level.s_game_over_scene_override = undefined;
    
    if ( callback::exists( "wave_spawner_zombie_spawned", &function_333ec2b69dfebcc5 ) )
    {
        callback::remove( "wave_spawner_zombie_spawned", &function_333ec2b69dfebcc5 );
    }
    
    utility::flag_clear( "disable_special_round_visionset" );
}

// Namespace zm_sat_mantis_boss_fight
// Params 1
// Checksum 0xac5aaae9, Offset: 0x6510
// Size: 0x165
function function_cf748d91cfe5fdcd( override_beam_vfx )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( override_beam_vfx ) )
    {
        override_beam_vfx = "dark_energy_default_beam";
    }
    
    foreach ( var_576d220b01160c72 in level.s_dark_heart.var_dd5147eb36a3795b )
    {
        var_576d220b01160c72.beam_vfx = playfxontagsbetweenclients( level._effect[ override_beam_vfx ], level.s_dark_heart.boss_agent, "tag_origin", var_576d220b01160c72.mdl, "tag_origin" );
    }
    
    wait 3;
    
    foreach ( var_576d220b01160c72 in level.s_dark_heart.var_dd5147eb36a3795b )
    {
        var_576d220b01160c72.beam_vfx delete();
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 1
// Checksum 0x6322fffd, Offset: 0x667d
// Size: 0x25f
function function_751266bed71d935b( phase_name )
{
    level endon( #"game_ended" );
    a_orbs = [];
    var_2f053bc0c21de249 = [ "tag_fx_artery_1", "tag_fx_artery_2", "tag_fx_artery_3" ];
    var_da1be300c89d31f7 = function_3105bc9ab0403481( level.s_dark_heart.var_dd5147eb36a3795b );
    orb_kill_radius = getdvarfloat( @"hash_ae7defbb15fa51c3", 1000 );
    orb_launch_force = getdvarfloat( @"hash_ded3f6e6f85f62cf", 800 );
    b_first_orb = 1;
    
    foreach ( var_576d220b01160c72 in var_da1be300c89d31f7 )
    {
        if ( b_first_orb && isdefined( phase_name ) )
        {
            zm_quest::stop_wave_spawner( phase_name, undefined, 1 );
            b_first_orb = 0;
        }
        
        function_1ba2391749408110( var_576d220b01160c72.origin, orb_kill_radius, orb_launch_force );
        var_c84e4aa5d17eebe4 = function_2b72987abf6f2cc9( var_576d220b01160c72.origin, var_2f053bc0c21de249 );
        orb = utility::spawn_model( level.s_dark_heart.var_2d7524092817db6, var_576d220b01160c72.origin, ( 0, 0, 0 ) );
        orb utility::ent_flag_init( "arc_complete" );
        a_orbs[ a_orbs.size ] = orb;
        beam = undefined;
        orb thread function_6d42cc056aa84b69( var_576d220b01160c72.origin, var_c84e4aa5d17eebe4, beam, 6 );
        wait getdvarfloat( @"hash_c02a53e2ed30521d", 1.5 );
    }
    
    foreach ( orb in a_orbs )
    {
        if ( isdefined( orb ) )
        {
            orb utility::ent_flag_wait( "arc_complete" );
        }
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 3, eflags: 0x4
// Checksum 0xe4726e93, Offset: 0x68e4
// Size: 0x161
function private function_1ba2391749408110( origin, radius, launch_force )
{
    a_zombies = getaiarrayinradius( origin, radius, zm_utility::get_zombie_team() );
    n_ragdolls = 0;
    max_ragdolls = undefined;
    
    foreach ( zombie in a_zombies )
    {
        if ( !isalive( zombie ) )
        {
            continue;
        }
        
        if ( zombie == level.s_dark_heart.boss_agent )
        {
            continue;
        }
        
        dir_away = vectornormalize( zombie.origin - origin );
        dir_away = ( dir_away[ 0 ], dir_away[ 1 ], randomfloatrange( 0.5, 1 ) );
        zombie.death_source = "orb_kill";
        zombie kill();
        
        if ( !max_ragdolls || n_ragdolls < max_ragdolls )
        {
            corpse = zombie getcorpseentity();
            
            if ( isdefined( corpse ) )
            {
                corpse startragdollfromimpact( "torso_lower", dir_away * launch_force );
                n_ragdolls++;
            }
        }
        
        waitframe();
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 2, eflags: 0x4
// Checksum 0xb6de219b, Offset: 0x6a4d
// Size: 0xe5
function private function_2b72987abf6f2cc9( origin, var_2f053bc0c21de249 )
{
    closest_dist = 999999;
    closest_tag = var_2f053bc0c21de249[ 0 ];
    
    foreach ( tag in var_2f053bc0c21de249 )
    {
        tag_pos = level.s_dark_heart.boss_agent gettagorigin( tag );
        
        if ( isdefined( tag_pos ) )
        {
            dist = distance( tag_pos, origin );
            
            if ( dist < closest_dist )
            {
                closest_dist = dist;
                closest_tag = tag;
            }
        }
    }
    
    return closest_tag;
}

// Namespace zm_sat_mantis_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xc4e69b28, Offset: 0x6b3b
// Size: 0x223
function private function_3105bc9ab0403481( var_ca064db41c1c93d1 )
{
    if ( !isdefined( level.players ) || level.players.size == 0 )
    {
        return var_ca064db41c1c93d1;
    }
    
    a_distances = [];
    
    foreach ( var_576d220b01160c72 in var_ca064db41c1c93d1 )
    {
        closest_dist = 999999;
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) && player.sessionstate != "spectator" )
            {
                dist = distance( var_576d220b01160c72.origin, player.origin );
                
                if ( dist < closest_dist )
                {
                    closest_dist = dist;
                }
            }
        }
        
        a_distances[ a_distances.size ] = closest_dist;
    }
    
    a_sorted = [];
    var_d26964b5b0d32d8c = [];
    
    for ( i = 0; i < var_ca064db41c1c93d1.size ; i++ )
    {
        hold_out = var_ca064db41c1c93d1[ i ];
        dist = a_distances[ i ];
        insert_idx = a_sorted.size;
        
        for ( j = 0; j < a_sorted.size ; j++ )
        {
            if ( dist < var_d26964b5b0d32d8c[ j ] )
            {
                insert_idx = j;
                break;
            }
        }
        
        for ( j = a_sorted.size; j > insert_idx ; j-- )
        {
            a_sorted[ j ] = a_sorted[ j - 1 ];
            var_d26964b5b0d32d8c[ j ] = var_d26964b5b0d32d8c[ j - 1 ];
        }
        
        a_sorted[ insert_idx ] = hold_out;
        var_d26964b5b0d32d8c[ insert_idx ] = dist;
    }
    
    return a_sorted;
}

// Namespace zm_sat_mantis_boss_fight
// Params 4, eflags: 0x4
// Checksum 0x502ee81, Offset: 0x6d67
// Size: 0x582
function private function_6d42cc056aa84b69( start_pos, artery_tag, beam, duration )
{
    self endon( #"death" );
    spiral_height = getdvarfloat( @"hash_d8831c0be0fa6d27", 400 );
    spiral_radius = getdvarfloat( @"hash_3ba725bbdf367f6a", 80 );
    spiral_rotations = getdvarfloat( @"hash_f6d029ca87ec1bf3", 2 );
    var_956c1fab341d0053 = getdvarfloat( @"hash_b3ddf7099f8dda23", 100 );
    max_speed = getdvarfloat( @"hash_69f570adcb687b84", 800 );
    accel = getdvarfloat( @"hash_b5a8b719181d7676", 300 );
    var_913034dd2a3a074c = getdvarfloat( @"hash_bdd8154711cb7ed0", 0.3 );
    var_c1cc55df874fb57a = getdvarfloat( @"hash_4d28dc36b7582d2c", 200 );
    var_e1d5569952aaf3f4 = getdvarfloat( @"hash_621fd6552439ea8", 0.1 );
    var_6cb939899733cabd = getdvarfloat( @"hash_7cbdc6280e4995d1", 0.4 );
    var_686aa6deacb3c649 = duration * var_e1d5569952aaf3f4;
    var_6849a10f0e79fa02 = duration * var_6cb939899733cabd;
    end_pos = level.s_dark_heart.boss_agent gettagorigin( artery_tag );
    spiral_end_pos = start_pos + ( 0, 0, spiral_height );
    midpoint_pos = lerp( spiral_end_pos, end_pos, 0.5 );
    self.orb_velocity = ( 0, 0, spiral_height / var_686aa6deacb3c649 );
    start_time = gettime();
    var_48ee71281f56f926 = start_time;
    
    while ( true )
    {
        current_time = gettime();
        dt = ( current_time - var_48ee71281f56f926 ) / 1000;
        var_48ee71281f56f926 = current_time;
        
        if ( dt <= 0 )
        {
            waitframe();
            continue;
        }
        
        elapsed = ( current_time - start_time ) / 1000;
        
        if ( elapsed < var_686aa6deacb3c649 )
        {
            phase_t = elapsed / var_686aa6deacb3c649;
            target_speed = max_speed * 0.6;
            angle = phase_t * spiral_rotations * 360;
            spiral_offset = ( cos( angle ) * spiral_radius * ( 1 - phase_t ), sin( angle ) * spiral_radius * ( 1 - phase_t ), 0 );
            target_pos = lerp( start_pos, spiral_end_pos, phase_t ) + spiral_offset;
        }
        else if ( elapsed < var_686aa6deacb3c649 + var_6849a10f0e79fa02 )
        {
            phase_t = ( elapsed - var_686aa6deacb3c649 ) / var_6849a10f0e79fa02;
            target_pos = midpoint_pos;
            target_speed = var_956c1fab341d0053;
            arc_offset = 4 * var_c1cc55df874fb57a * phase_t * ( 1 - phase_t );
            target_pos += ( 0, 0, arc_offset );
        }
        else
        {
            end_pos = level.s_dark_heart.boss_agent gettagorigin( artery_tag );
            target_pos = end_pos;
            target_speed = max_speed;
        }
        
        dir_to_target = target_pos - self.origin;
        dist_to_target = length( dir_to_target );
        
        if ( dist_to_target > 1 )
        {
            dir_to_target = vectornormalize( dir_to_target );
        }
        
        desired_velocity = dir_to_target * target_speed;
        velocity_diff = desired_velocity - self.orb_velocity;
        max_steer = accel * dt;
        
        if ( length( velocity_diff ) <= max_steer )
        {
            self.orb_velocity = desired_velocity;
        }
        else
        {
            self.orb_velocity += vectornormalize( velocity_diff ) * max_steer;
        }
        
        current_speed = length( self.orb_velocity );
        
        if ( current_speed > 1 )
        {
            current_dir = vectornormalize( self.orb_velocity );
            blended_dir = lerp( current_dir, dir_to_target, var_913034dd2a3a074c );
            self.orb_velocity = vectornormalize( blended_dir ) * current_speed;
        }
        
        self.origin += self.orb_velocity * dt;
        
        if ( distance( self.origin, end_pos ) < 30 )
        {
            break;
        }
        
        waitframe();
    }
    
    if ( isdefined( beam ) )
    {
        beam delete();
    }
    
    level.s_dark_heart.boss_agent setscriptablepartstate( "sound_spirit_converge_riser", "off" );
    playfxontag( utility::getfx( "aeon_ball_hit_impact_heart" ), level.s_dark_heart.boss_agent, "tag_origin" );
    playsoundatpos( self.origin, "evt_mantis_boss_spirit_impact_heart" );
    zombie_aeon_asm::function_69ff524cca32dbff( level.s_dark_heart.boss_agent, start_pos );
    heart_centroid = level.s_dark_heart.boss_agent gettagorigin( "j_mainroot" );
    var_7e73ee8f896fe29e = getdvarfloat( @"hash_ac91a0d1b5a39789", 0.3 );
    start_pos_enter = self.origin;
    start_time_enter = gettime();
    
    while ( ( gettime() - start_time_enter ) / 1000 < var_7e73ee8f896fe29e )
    {
        t = ( gettime() - start_time_enter ) / 1000 / var_7e73ee8f896fe29e;
        t = clamp( t, 0, 1 );
        heart_centroid = level.s_dark_heart.boss_agent gettagorigin( "j_mainroot" );
        self.origin = lerp( start_pos_enter, heart_centroid, t );
        waitframe();
    }
    
    utility::ent_flag_set( "arc_complete" );
    self delete();
}

// Namespace zm_sat_mantis_boss_fight
// Params 1
// Checksum 0xfe23aaee, Offset: 0x72f1
// Size: 0xf7
function function_1d105e8b51d70eff( phase_name )
{
    level endon( #"game_ended" );
    level utility::flag_wait( "boss_fight_phase_1_start" );
    
    if ( !getdvarint( @"hash_ffcbf794cfa6a866", 1 ) )
    {
        return;
    }
    
    wave_spawn_interval = function_fa97fb842a7ca263( level.s_dark_heart.phase_data[ phase_name ] );
    max_alive = level.s_dark_heart.phase_data[ phase_name ].var_f69a07035e9429ea;
    round_difficulty = function_b80976b7930587b4();
    
    if ( max_alive == 0 )
    {
        max_alive = undefined;
    }
    
    if ( zm_utility::get_round_number() > round_difficulty )
    {
        round_difficulty = zm_utility::get_round_number();
    }
    
    if ( !callback::exists( "wave_spawner_zombie_spawned", &function_333ec2b69dfebcc5 ) )
    {
        callback::add( "wave_spawner_zombie_spawned", &function_333ec2b69dfebcc5 );
    }
    
    level thread zm_quest::function_c058b90bfd86cc05( phase_name, wave_spawn_interval, round_difficulty, 1, &get_add_loot_drop, 0, 0, max_alive, 1 );
}

// Namespace zm_sat_mantis_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xcd2f2bc7, Offset: 0x73f0
// Size: 0x93
function private function_333ec2b69dfebcc5( params )
{
    params.zombie.no_powerups = 1;
    params.zombie.var_50c96a5c56dab386 = &get_add_loot_drop;
    params.zombie.mantis_boss_fight_add = 1;
    
    if ( params.zombie.subclass == "zombie_methone" )
    {
        params.zombie zombie_utils::function_a8ce00e0448cb6f0( "run", "zm_quest", 6 );
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x1919871, Offset: 0x748b
// Size: 0x7a
function private get_add_loot_drop()
{
    drop_list = level.s_dark_heart.addlootdrop;
    var_245f1c4b1d5b3e81 = 1;
    zombie_droppos = self.origin;
    zombie_droplist_params = { #droppos:zombie_droppos ?? self.origin, #dropquantity:var_245f1c4b1d5b3e81, #droplist:drop_list };
    return zombie_droplist_params;
}

// Namespace zm_sat_mantis_boss_fight
// Params 2
// Checksum 0x68b28b96, Offset: 0x750e
// Size: 0x1ff
function function_3176083662ac618d( var_f1fbc291f2430b1e, var_5814fe12b7d50d9a = 1 )
{
    if ( self.black_dome && self.black_dome.clip )
    {
        if ( var_f1fbc291f2430b1e )
        {
            if ( var_5814fe12b7d50d9a )
            {
                self.black_dome setscriptablepartstate( "model", "init" );
            }
            else
            {
                self.black_dome setscriptablepartstate( "model", "hide" );
                release_holdout( self );
            }
            
            self.black_dome.clip.origin = self.black_dome.clip.original_position;
            self.black_dome.origin = self.black_dome.original_position;
            self.black_dome.clip solid();
            self.black_dome.clip disconnectpaths();
            thread function_673276582f1dc018();
            return;
        }
        
        self.black_dome setscriptablepartstate( "model", "hide" );
        self notify( #"hash_96224f6d3d98da8b" );
        release_holdout( self );
        wait 4;
        self.black_dome.origin = self.black_dome.original_position + ( 0, 0, 1000 );
        self.black_dome.clip notsolid();
        self.black_dome.clip connectpaths();
        self.black_dome.clip.origin = self.black_dome.clip.original_position + ( 0, 0, 1000 );
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xb5533e4d, Offset: 0x7715
// Size: 0x114
function private function_673276582f1dc018()
{
    self endon( #"hash_96224f6d3d98da8b" );
    wait 1;
    
    while ( true )
    {
        a_players_inside = getplayersinradius( self.origin, 100 );
        
        foreach ( player in a_players_inside )
        {
            direction = vectornormalize2( player.origin - self.origin );
            dist = distance2d( player.origin, self.origin );
            player setorigin( getclosestpointonnavmesh( player.origin + direction * ( 150 - dist ) + ( 0, 0, 20 ) ), 0 );
        }
        
        wait 0.5;
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 0
// Checksum 0x2189f12, Offset: 0x7831
// Size: 0x255
function function_b7b948c5250821a4()
{
    if ( level.s_dark_heart.boss_agent.subclass != "zombie_aeon" )
    {
        return;
    }
    
    zombie_aeon_asm::function_a31680b57c8f7950( level.s_dark_heart.boss_agent );
    level.s_dark_heart.boss_agent waittill( #"aeon_projectile_shoot" );
    target_pos = self.origin;
    var_2f053bc0c21de249 = [ "tag_fx_artery_1", "tag_fx_artery_2", "tag_fx_artery_3" ];
    var_4c19c47296b0ea53 = [ "artery1_flash", "artery2_flash", "artery3_flash" ];
    closest_dist = 999999;
    launch_pos = level.s_dark_heart.boss_agent.origin;
    var_fe461e08bb25eb94 = undefined;
    
    for ( idx = 0; idx < var_2f053bc0c21de249.size ; idx++ )
    {
        tag = var_2f053bc0c21de249[ idx ];
        tag_pos = level.s_dark_heart.boss_agent gettagorigin( tag );
        
        if ( isdefined( tag_pos ) )
        {
            dist = distance( tag_pos, target_pos );
            
            if ( dist < closest_dist )
            {
                closest_dist = dist;
                launch_pos = tag_pos;
                var_fe461e08bb25eb94 = idx;
            }
        }
    }
    
    if ( isdefined( var_fe461e08bb25eb94 ) )
    {
        level.s_dark_heart.boss_agent utility::function_7c10ea82c1e305b8( var_4c19c47296b0ea53[ var_fe461e08bb25eb94 ], "on_ichor" );
    }
    
    ball = utility::spawn_model( level.s_dark_heart.var_cca965b84c48b00f, launch_pos, ( 0, 0, 0 ) );
    arc_height = 100;
    arc_duration = 2;
    playsoundatpos( launch_pos, #"hash_6c5264ff1c9cb011" );
    ball thread function_ccddf77015a51d32( launch_pos, target_pos, arc_height, arc_duration );
    ball waittill( #"arc_complete" );
    ball.origin = target_pos;
    ball setscriptablepartstate( "base", "explode" );
    function_3176083662ac618d( 1 );
    wait 0.5;
    
    if ( isdefined( ball ) )
    {
        ball delete();
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 4, eflags: 0x4
// Checksum 0xf68c22ac, Offset: 0x7a8e
// Size: 0xea
function private function_ccddf77015a51d32( start_pos, end_pos, arc_height, duration )
{
    self endon( #"death" );
    start_time = gettime();
    end_time = start_time + duration * 1000;
    
    while ( gettime() < end_time )
    {
        current_time = gettime();
        t = ( current_time - start_time ) / duration * 1000;
        t = clamp( t, 0, 1 );
        horiz_pos = lerp( start_pos, end_pos, t );
        arc_offset = 4 * arc_height * t * ( 1 - t );
        self.origin = ( horiz_pos[ 0 ], horiz_pos[ 1 ], horiz_pos[ 2 ] + arc_offset );
        waitframe();
    }
    
    self.origin = end_pos;
    self notify( #"arc_complete" );
}

// Namespace zm_sat_mantis_boss_fight
// Params 1
// Checksum 0xf690d97e, Offset: 0x7b80
// Size: 0x47
function release_holdout( s_holdout )
{
    released_flag = s_holdout.script_noteworthy + "_finish_released";
    
    if ( isdefined( released_flag ) )
    {
        level utility::flag_set( released_flag );
    }
    
    s_holdout.b_released = 1;
}

// Namespace zm_sat_mantis_boss_fight
// Params 0
// Checksum 0xf3579f51, Offset: 0x7bcf
// Size: 0x169
function function_d1ae908624012179()
{
    var_ebf5dd32e0a9ded3 = utility::getent_or_struct_array( "boss_fight_barrier", "script_noteworthy" );
    
    foreach ( brushmodel_collision_ent in var_ebf5dd32e0a9ded3 )
    {
        brushmodel_collision_ent show();
        brushmodel_collision_ent disconnectpaths();
    }
    
    a_barriers = utility::getstructarray( "boss_fight_barrier", "targetname" );
    
    foreach ( barrier in a_barriers )
    {
        if ( !isdefined( barrier.sbl ) )
        {
            barrier.sbl = spawnscriptable( "sat_zm_sat_scriptable_mantis_boss_fight_energy_barrier", barrier.origin, barrier.angles );
            barrier.sbl setscriptablepartstate( "base", "boss_barrier" );
        }
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 0
// Checksum 0x5661e166, Offset: 0x7d40
// Size: 0x133
function function_908d83d7abfab440()
{
    var_ebf5dd32e0a9ded3 = utility::getent_or_struct_array( "boss_fight_barrier", "script_noteworthy" );
    
    foreach ( brushmodel_collision_ent in var_ebf5dd32e0a9ded3 )
    {
        brushmodel_collision_ent hide();
        brushmodel_collision_ent connectpaths();
    }
    
    a_barriers = utility::getstructarray( "boss_fight_barrier", "targetname" );
    
    foreach ( barrier in a_barriers )
    {
        if ( isdefined( barrier.sbl ) )
        {
            barrier.sbl freescriptable();
        }
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 2
// Checksum 0x838887e7, Offset: 0x7e7b
// Size: 0x1b7
function function_9ac001a7367271d4( var_2b7348b1806f5bd3, phase_name )
{
    level.s_dark_heart.boss_agent thread utility::thread_on_notify( "scar_exposed", &function_9cc2b48802345520 );
    
    if ( var_2b7348b1806f5bd3 )
    {
        intro_duration = getdvarfloat( @"hash_56251d7344b2f255", 3 );
        level.s_dark_heart.boss_agent thread zombie_aeon::function_9c6c273abc4252f2( intro_duration );
        phase_data = level.s_dark_heart.phase_data[ phase_name ];
        
        if ( isdefined( phase_data ) )
        {
            level.s_dark_heart.boss_agent zombie_aeon_flame_tornado::function_e20231e798d819c3( phase_data.var_f39854a7b3fd8dd8 ?? 1 );
        }
        
        level.s_dark_heart.boss_agent thread utility::delaythread( 5, &zombie_aeon::function_7059b85a384fcc35 );
        level.s_dark_heart.boss_agent thread utility::delaythread( 5, &zombie_aeon_fireball::function_5ce011b9f8892d6d );
        level.s_dark_heart thread boss_health_listener( phase_name );
        return;
    }
    
    level.s_dark_heart notify( #"stop_health_listener" );
    level.s_dark_heart.boss_agent thread zombie_aeon_fireball::function_6315aec8c403efb5();
    level.s_dark_heart.boss_agent thread zombie_aeon_metabones::function_54ad3980e4eebee7( level.s_dark_heart.boss_agent );
    level.s_dark_heart.boss_agent utility::ent_flag_clear( "damage_phase_intro" );
    level.s_dark_heart.boss_agent zombie_aeon::set_scar_exposed_state( 0 );
}

// Namespace zm_sat_mantis_boss_fight
// Params 1
// Checksum 0x6d92755f, Offset: 0x803a
// Size: 0x15a
function boss_health_listener( phase_name )
{
    level endon( #"game_ended" );
    self endon( #"stop_health_listener" );
    
    while ( true )
    {
        self.boss_agent waittill( #"hash_a628d3786516c7ae", amount, attacker );
        
        if ( !isplayer( attacker ) || ( amount ?? 0 ) == 0 )
        {
            continue;
        }
        
        if ( isdefined( phase_name ) )
        {
            current_health_perc = self.boss_agent.health / self.boss_agent.maxhealth;
            
            if ( current_health_perc <= self.phase_data[ phase_name ].healthpercentage )
            {
                self.boss_agent.health = clamp( self.boss_agent.health, int( self.phase_data[ phase_name ].healthpercentage * self.boss_agent.maxhealth ), self.boss_agent.maxhealth );
                var_494f354dfe56bbcb = 1;
            }
        }
        
        if ( var_494f354dfe56bbcb )
        {
            level.s_dark_heart.boss_agent zombie_aeon::function_e81e91da9d7f3d31();
        }
        
        waitframe();
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x4e54c20b, Offset: 0x819c
// Size: 0x8c
function private on_aeon_death_explosion( params )
{
    wait getdvarfloat( @"hash_b0b9dc2378d3dcf2", 0.5 );
    var_b0ea067682dddd6d = params.origin;
    death_floor_pos = playerphysicstrace( var_b0ea067682dddd6d, var_b0ea067682dddd6d - ( 0, 0, 2000 ) );
    death_energy = utility::spawn_model( "tag_origin_mantis_boss_death_energy", death_floor_pos );
    wait getdvarfloat( @"hash_19ef9f03f3e1191b", 15.5 );
    
    if ( death_energy )
    {
        death_energy delete();
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xa44a271d, Offset: 0x8230
// Size: 0x408
function private spawn_black_ichor_puddle()
{
    level endon( #"game_ended" );
    ground_pos = playerphysicstrace( self.origin, self.origin - ( 0, 0, 2000 ) );
    ground_pos -= ( 0, 0, getdvarint( @"hash_deca469a3de25818", 5 ) );
    puddle = utility::spawn_model( level.s_dark_heart.var_e7ac82c3d3ba5912, ground_pos, ( 0, 0, 0 ) );
    
    if ( !isdefined( puddle ) )
    {
        return;
    }
    
    puddle endon( #"death" );
    level.s_dark_heart.black_ichor_puddle = puddle;
    puddle_radius = getdvarfloat( @"black_ichor_puddle_radius", level.s_dark_heart.var_6d40b3416ad02400 ?? 220 );
    puddle_tick_rate = getdvarfloat( @"black_ichor_puddle_tick_rate", level.s_dark_heart.var_d605a9a2b97e045d ?? 0.5 );
    
    /#
        puddle thread black_ichor_puddle_debug_draw( puddle_radius );
    #/
    
    if ( getdvarint( @"hash_a38ca78064323ed9", 0 ) <= 0 )
    {
        return;
    }
    
    while ( isdefined( puddle ) )
    {
        puddle_radius = getdvarfloat( @"black_ichor_puddle_radius", level.s_dark_heart.var_6d40b3416ad02400 ?? 300 );
        puddle_damage = getdvarint( @"black_ichor_puddle_damage", level.s_dark_heart.var_b88224dba6887bbf ?? 60 );
        puddle_slow_rate = getdvarfloat( @"black_ichor_puddle_slow_rate", level.s_dark_heart.var_c2bc6cf99d373c89 ?? 0.5 );
        var_7ea92afcdfa95db7 = getdvarfloat( @"hash_e39a5626287ab1e1", level.s_dark_heart.var_4fb44c4b10c953f7 ?? 1 );
        puddle_tick_rate = getdvarfloat( @"black_ichor_puddle_tick_rate", level.s_dark_heart.var_d605a9a2b97e045d ?? 0.5 );
        
        foreach ( player in level.players )
        {
            if ( !isalive( player ) )
            {
                continue;
            }
            
            var_e0741adefdb3d35b = distance2d( player.origin, puddle.origin );
            
            if ( var_e0741adefdb3d35b <= puddle_radius )
            {
                is_safe_sliding = player utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_phd_flopper", #"phdflopper_safe_slide" ) && player issprintsliding();
                
                if ( player isonground() && !is_safe_sliding )
                {
                    if ( !player utility::ent_flag( "ichor_puddle_damaged" ) )
                    {
                        player utility::ent_flag_set( "ichor_puddle_damaged" );
                        player thread utility::ent_flag_clear_delayed( "ichor_puddle_damaged", puddle_tick_rate );
                        level.s_dark_heart.boss_agent.ignore_turtle_shell = 1;
                        player dodamage( puddle_damage, puddle.origin, level.s_dark_heart.boss_agent, self, "MOD_TRIGGER_HURT", "none" );
                        level.s_dark_heart.boss_agent.ignore_turtle_shell = 0;
                        player effect_slow::slow( "black_ichor_puddle", puddle_slow_rate, var_7ea92afcdfa95db7, self );
                    }
                }
                else if ( player effect_slow::function_c1be3c9f2d0b92d2( "black_ichor_puddle" ) )
                {
                    player effect_slow::function_80a4bd13b5ba303a( "black_ichor_puddle" );
                }
                
                continue;
            }
            
            if ( player effect_slow::function_c1be3c9f2d0b92d2( "black_ichor_puddle" ) )
            {
                player effect_slow::function_80a4bd13b5ba303a( "black_ichor_puddle" );
            }
        }
        
        waitframe();
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x99e067f3, Offset: 0x8640
// Size: 0x34
function private function_6b01801b08f66717()
{
    if ( zm_utility::get_round_number() >= 100 )
    {
        zm_lighting_visionset::set_special_round_visionset();
        overlord::playevent( "zm_special_round_start_vo", level.players, undefined, 1 );
        zm_sat_mantis_radiation_cloud::radiation_cloud_round_start();
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x5d2136be, Offset: 0x867c
// Size: 0x21
function private function_9504b8fbe743abec()
{
    if ( zm_utility::get_round_number() >= 100 )
    {
        zm_lighting_visionset::function_48532c8b58f4b0b3();
        level notify( #"hash_15b37960176646dd" );
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 0
// Checksum 0x2c325ef1, Offset: 0x86a5
// Size: 0x9b
function function_b80976b7930587b4()
{
    assert( isdefined( level.s_dark_heart ) );
    num_players = level.players.size;
    
    if ( num_players <= 1 )
    {
        return level.s_dark_heart.var_6b7fb2da3cdf5121;
    }
    
    if ( num_players <= 2 )
    {
        return level.s_dark_heart.var_6b83b8da3ce3542a;
    }
    
    if ( num_players <= 3 )
    {
        return level.s_dark_heart.var_6b889eda3ce943d3;
    }
    
    return level.s_dark_heart.var_6b8ca4da3ced46dc;
}

// Namespace zm_sat_mantis_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xdc757ff, Offset: 0x8748
// Size: 0x114
function private function_aab4b169152f5aa()
{
    var_bad061196adfcf56 = getdvarfloat( @"hash_9b67bd32fb2f3b8b", -300 );
    s_final_teleport_pos = utility::getstruct( "final_teleport_pos", "targetname" );
    sub_locations = utility::getstructarray( s_final_teleport_pos.target, "targetname" );
    
    foreach ( pos in sub_locations )
    {
        if ( pos.script_noteworthy == "player_position" )
        {
            to_dark_heart = level.s_dark_heart.origin + ( 0, 0, var_bad061196adfcf56 ) - pos.origin;
            pos.angles = vectortoangles( to_dark_heart );
        }
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xfb59604c, Offset: 0x8864
// Size: 0x2b
function private on_player_spawned( params )
{
    if ( utility::flag( "start_boss_fight" ) )
    {
        zombie_boss_healthbar::zombie_boss_healthbar_hide();
        wait 1;
        function_9cc2b48802345520();
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x20891647, Offset: 0x8897
// Size: 0x128
function private function_9cc2b48802345520()
{
    is_immune = isalive( level.s_dark_heart.boss_agent ) && !level.s_dark_heart.boss_agent utility::ent_flag( "scar_exposed" );
    
    if ( !is_immune && isalive( level.s_dark_heart.boss_agent ) )
    {
        level.s_dark_heart.boss_agent thread zombie_boss_healthbar::init_zombie_boss_healthbar();
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( isalive( level.s_dark_heart.boss_agent ) )
        {
            if ( is_immune )
            {
                player zombie_boss_healthbar::zombie_boss_healthbar_immune();
            }
            
            continue;
        }
        
        player zombie_boss_healthbar::zombie_boss_healthbar_hide();
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x6e39a13b, Offset: 0x89c7
// Size: 0x149
function private revive_all_players()
{
    foreach ( player in level.players )
    {
        if ( !isalive( player ) || player.sessionstate == "spectator" )
        {
            player lower_message::setlowermessageomnvar( "clear_lower_msg" );
            player thread playerlogic::spawnplayer();
            
            if ( !isalive( player ) || player.sessionstate == "spectator" )
            {
                player utility::waittill_any_timeout( 5, "spawned_player" );
            }
        }
        
        if ( player::isinlaststand( player ) )
        {
            player laststand::exit( "last_stand_revived", player );
        }
        
        if ( !isalive( player ) || player.sessionstate == "spectator" )
        {
            player thread playerlogic::spawnplayer();
            
            if ( !isalive( player ) || player.sessionstate == "spectator" )
            {
                player utility::waittill_any_timeout( 5, "spawned_player" );
            }
        }
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 1
// Checksum 0xa8553e6d, Offset: 0x8b18
// Size: 0x6c
function function_fa97fb842a7ca263( phase_data )
{
    values = [ phase_data.var_40e398426f4b9df9, phase_data.var_40e89e426f51d402, phase_data.var_40eca4426f55d70b, phase_data.var_40f0aa426f59da14 ];
    return values[ clamp( level.players.size, 1, 4 ) - 1 ];
}

// Namespace zm_sat_mantis_boss_fight
// Params 1
// Checksum 0xf866b414, Offset: 0x8b8d
// Size: 0x6c
function function_d290ffaebf93d4d6( spawnlist )
{
    values = [ spawnlist.var_aa9fc89d1348d2a0, spawnlist.var_aaacda9d13570ebb, spawnlist.var_aaa7d49d1350d8b2, spawnlist.var_aab5e69d136147cd ];
    return values[ clamp( level.players.size, 1, 4 ) - 1 ];
}

// Namespace zm_sat_mantis_boss_fight
// Params 1
// Checksum 0x7868110f, Offset: 0x8c02
// Size: 0x6c
function function_d15951201200bcaa( phase_data )
{
    values = [ phase_data.var_c45010eddd8b39bc, phase_data.var_c45d22eddd9975d7, phase_data.var_c4591ceddd9572ce, phase_data.var_c4431eeddd7d4401 ];
    return values[ clamp( level.players.size, 1, 4 ) - 1 ];
}

// Namespace zm_sat_mantis_boss_fight
// Params 0
// Checksum 0x5da9e617, Offset: 0x8c77
// Size: 0x82
function function_32ec661281f1622f()
{
    values = [ level.s_dark_heart.var_309ee00c69f0c927, level.s_dark_heart.var_3091ce0c69e28d0c, level.s_dark_heart.var_3095d40c69e69015, level.s_dark_heart.var_3088e20c69d89a5a ];
    return values[ clamp( level.players.size, 1, 4 ) - 1 ];
}

// Namespace zm_sat_mantis_boss_fight
// Params 0
// Checksum 0x6415d3a7, Offset: 0x8d02
// Size: 0x82
function function_c4f4abcd0b650f8a()
{
    values = [ level.s_dark_heart.var_f1523af5d7397654, level.s_dark_heart.var_f15f2cf5d7476c0f, level.s_dark_heart.var_f15b26f5d7436906, level.s_dark_heart.var_f14528f5d72b3a39 ];
    return values[ clamp( level.players.size, 1, 4 ) - 1 ];
}

// Namespace zm_sat_mantis_boss_fight
// Params 1, eflags: 0x4
// Checksum 0xd752b3d0, Offset: 0x8d8d
// Size: 0x1f5
function private function_e83b11eb8fabc062( params = [] )
{
    if ( arraycontains( params, "weapons" ) )
    {
        level thread function_5f0a50b61f3da74c();
        params = arrayremove( params, "weapons" );
    }
    
    zm_utility::open_sesame();
    init_boss_fight_data();
    n_round = function_b80976b7930587b4();
    
    foreach ( param in params )
    {
        if ( issubstr( param, "round" ) )
        {
            n_round = int( removesubstr( param, "round" ) );
        }
    }
    
    zm_round_logic::function_68bdb49c82c0f892( n_round );
    
    if ( arraycontains( params, "natural" ) )
    {
        wait 5;
        zm_quest::function_11b75e2232ce3d4( [ "prepare_final_fight", 1 ] );
        wait 2;
        level utility::flag_set( "twins_warning_vo_done" );
        level utility::flag_set( "start_boss_fight" );
        return;
    }
    
    s_final_teleport_pos = utility::getstruct( "final_teleport_pos", "targetname" );
    
    foreach ( player in level.players )
    {
        level thread zm_fasttravel_core::function_cbb08198e7c84adf( s_final_teleport_pos, player, undefined, undefined, 0.25, 0.25 );
    }
    
    wait 1;
    level zm_quest::clear_all_guidance();
    level thread start_boss_fight();
    level.players[ 0 ] waittill( #"fasttravel_finished" );
}

// Namespace zm_sat_mantis_boss_fight
// Params 0, eflags: 0x4
// Checksum 0x2db01635, Offset: 0x8f8a
// Size: 0x7b
function private function_5f0a50b61f3da74c()
{
    foreach ( player in level.players )
    {
        player thread function_e5292169f3b94171();
    }
}

// Namespace zm_sat_mantis_boss_fight
// Params 1, eflags: 0x4
// Checksum 0x24085ef9, Offset: 0x900d
// Size: 0x24
function private dev_kill_boss( params )
{
    level.s_dark_heart.boss_agent kill();
}

// Namespace zm_sat_mantis_boss_fight
// Params 0, eflags: 0xc
// Checksum 0x5ffb9885, Offset: 0x9039
// Size: 0x3b5
function private function_e5292169f3b94171()
{
    self notify( #"hash_1fc5fbf429c777da" );
    self endon( #"hash_1fc5fbf429c777da" );
    player = self;
    player zombie_augments::function_eae5368ab01aaa9f();
    player zombie_augments::function_6dec499dd490fc54();
    player zombie_augments::function_ae34f860566cce0b( 3, 1 );
    player equipment_mp::giveequipment( "equip_decoy", "secondary" );
    
    if ( getdvarint( @"hash_348d280a97829389", 0 ) || getdvarint( @"hash_6dc3ee14c4a05c36", 0 ) )
    {
        var_1ae6ccd39356a608 = 3;
        n_power_level = 2;
    }
    else
    {
        var_1ae6ccd39356a608 = 4;
        n_power_level = 3;
    }
    
    ammo_mods = [ "brainrot", "deadwire", "napalmburst", "cryofreeze", "shadowvortex", "lightray" ];
    killstreaks = [ "dawg" ];
    super_power = utility::array_random( [ "super_aether_shroud" ] );
    thread perkpackage::perkpackage_givedebug( super_power );
    
    if ( laststand::function_7072b516e6cffb7c() == 0 )
    {
        player laststand::function_a2e03a85015b1897();
    }
    
    player zombie_perks::take_all_perks();
    player zombie_perks::give_perk( "specialty_juggernog" );
    player zombie_perks::give_perk( "specialty_quickrevive" );
    player zombie_perks::give_perk( "specialty_speedcola" );
    player zombie_perks::give_perk( "specialty_staminup" );
    player zombie_perks::give_perk( "specialty_elemental_pop" );
    player zombie_perks::give_perk( "specialty_phd_flopper" );
    player zombie_perks::give_perk( "specialty_death_perception" );
    player zombie_perks::give_perk( "specialty_deadshot" );
    player zombie_perks::give_perk( "specialty_m_mod" );
    player zombie_perks::give_perk( "specialty_d_mod" );
    player zombie_perks::give_perk( "specialty_w_mod" );
    player zombie_perks::give_perk( "specialty_vulture_aid" );
    player zombie_perks::give_perk( "specialty_z_mod" );
    player namespace_74c85f0ddf2d285f::function_fdbe2cad6d8bb7e7( 3 );
    player armor::setarmorhealth( player.maxarmorhealth );
    player armor::function_164c824617d7e8d7( armor::function_db9ebf086f67fe92() );
    player currency::add_currency_amount( #"essence", 50000 );
    player killstreaks::awardkillstreak( utility::array_random( killstreaks ), "other", undefined, undefined, undefined, 1 );
    player thread zm::function_a0f3dbdf8009cf91();
    weapon = player function_cb38c050042391c5();
    player item_weapon::function_40e1cbd0e1f47d1a( weapon, var_1ae6ccd39356a608 );
    weapon = player pack_a_punch::pap_weapon( weapon, int( max( n_power_level - 1, 0 ) ) );
    player function_692765e1fece04ba( weapon, ammo_mods );
    
    if ( isarray( weapon ) && isweapon( weapon[ 1 ] ) )
    {
        weapon = weapon[ 1 ];
    }
    else
    {
        weapon = player function_cb38c050042391c5();
    }
    
    weapon = player pack_a_punch::pap_weapon( weapon, int( max( n_power_level - 1, 0 ) ) );
    player item_weapon::function_40e1cbd0e1f47d1a( weapon, var_1ae6ccd39356a608 );
    player function_692765e1fece04ba( weapon, ammo_mods );
    wait 10;
    player thread zm::function_1693f9e934b707ea( undefined, n_power_level );
    player thread zm::function_1693f9e934b707ea( undefined, n_power_level );
    drop_pos = ( 0, 0, 0 );
    forward = anglestoforward( player getplayerangles() );
    drop_pos = player.origin + forward * 100;
    drop_pos = utility::drop_to_ground( drop_pos, 100 ) + ( 0, 0, 8 );
    item_bundle_name = "zm_sat_item_weapon_ww_mantis_upgraded";
    item_bundle = getscriptbundle( hashcat( %"itemspawnentry:", item_bundle_name ) );
    spawn_options = common_item::items_initspawnoptions_spawnfromentity( player );
    spawn_options.overridepaplvl = 3;
    common_item::function_61c2c0251e742ffd( item_bundle, 1, spawn_options );
}

// Namespace zm_sat_mantis_boss_fight
// Params 2, eflags: 0x4
// Checksum 0x91e16119, Offset: 0x93f6
// Size: 0x6a
function private function_692765e1fece04ba( weapon, ammo_mods )
{
    ammomodname = utility::array_random( ammo_mods );
    var_ace202d0c6b9306a = 0;
    
    while ( !isdefined( level.ammo_mods[ ammomodname ] ) )
    {
        ammomodname = utility::array_random( ammo_mods );
        var_ace202d0c6b9306a++;
        
        if ( var_ace202d0c6b9306a > 10 )
        {
            ammomodname = undefined;
        }
    }
    
    ammo_mod::add_ammo_mod_to_weapon( weapon, ammomodname );
}

// Namespace zm_sat_mantis_boss_fight
// Params 0, eflags: 0x4
// Checksum 0xc75792fa, Offset: 0x9468
// Size: 0x35
function private function_cb38c050042391c5()
{
    self endon( #"disconnect" );
    currentweapon = self getcurrentweapon();
    
    while ( isnullweapon( currentweapon ) )
    {
        currentweapon = self getcurrentweapon();
        waitframe();
    }
    
    return currentweapon;
}

/#

    // Namespace zm_sat_mantis_boss_fight
    // Params 0
    // Checksum 0xc6db8c37, Offset: 0x94a6
    // Size: 0x23e, Type: dev
    function init_boss_fight_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x58>" );
        devgui::add_devgui_func( "<dev string:x77>", "<dev string:x77>", &function_e83b11eb8fabc062 );
        devgui::add_devgui_func( "<dev string:x88>", "<dev string:x88>", &dev_kill_boss );
        devgui::add_devgui_func( "<dev string:x92>", "<dev string:x92>", &function_d1ae908624012179 );
        devgui::add_devgui_func( "<dev string:xa7>", "<dev string:xa7>", &function_908d83d7abfab440 );
        devgui::add_devgui_func( "<dev string:xbc>", "<dev string:xbc>", &function_d608e6ed62154c86 );
        devgui::add_devgui_func( "<dev string:xd1>", "<dev string:xd1>", &function_69cb12bb29bf866d );
        devgui::add_devgui_func( "<dev string:xe4>", "<dev string:xe4>", &function_80b35ac313e6a8e2 );
        devgui::add_devgui_func( "<dev string:xfb>", "<dev string:xfb>", &function_226bc3f3cca50b35 );
        devgui::add_devgui_func( "<dev string:x10a>", "<dev string:x10a>", &test_empowered_ai );
        devgui::add_devgui_func( "<dev string:x11c>", "<dev string:x11c>", &zm_sat_mantis::function_a15e37d395e34804 );
        devgui::add_devgui_func( "<dev string:x12f>", "<dev string:x12f>", &zm_sat_mantis::function_ae0561e420148611 );
        devgui::add_devgui_func( "<dev string:x142>", "<dev string:x142>", &function_a1ec0ac5f4056638 );
        devgui::add_devgui_func( "<dev string:x15a>", "<dev string:x15a>", &function_8c47fd1ce0207927 );
        devgui::add_devgui_func( "<dev string:x172>", "<dev string:x172>", &function_8c5cef3223543e2b );
        devgui::add_devgui_func( "<dev string:x18a>", "<dev string:x18a>", &zm_sat_mantis_boss_fight_twins::function_9f561d4f4d60fb3a );
        devgui::add_devgui_func( "<dev string:x1a2>", "<dev string:x1b9>", &function_cf8939edc623b5df );
        devgui::add_devgui_func( "<dev string:x1d0>", "<dev string:x1e1>", &function_3cd7c9d7154b92f5 );
        devgui::add_devgui_func( "<dev string:x1f2>", "<dev string:x20d>", &zm_sat_mantis_boss_fight_twins::function_e98f3fbae03fdc2d );
        devgui::add_devgui_func( "<dev string:x228>", "<dev string:x240>", &zm_sat_mantis_boss_fight_twins::function_f482f48de1d461b0 );
        devgui::add_devgui_func( "<dev string:x258>", "<dev string:x277>", &zm_sat_mantis_boss_fight_twins::function_47f12e7413a9f3ba );
        devgui::add_devgui_func( "<dev string:x295>", "<dev string:x2b1>", &function_e0596c10bb37dba1 );
        devgui::add_devgui_func( "<dev string:x2ce>", "<dev string:x2e8>", &function_b6f95c18c9ad3d6d );
        devgui::add_devgui_func( "<dev string:x308>", "<dev string:x31c>", &toggle_add_spawning );
        devgui::add_devgui_func( "<dev string:x330>", "<dev string:x349>", &function_594001b7886fd315 );
        devgui::add_devgui_func( "<dev string:x362>", "<dev string:x379>", &function_6e91b80c77b8fa47 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_mantis_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x38caad92, Offset: 0x96ec
    // Size: 0x15, Type: dev
    function private test_empowered_ai()
    {
        level.s_dark_heart thread namespace_a2abfbbbd7a9852f::function_26586a1abc6350ac();
    }

    // Namespace zm_sat_mantis_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x82bf896a, Offset: 0x9709
    // Size: 0x22e, Type: dev
    function private function_69cb12bb29bf866d()
    {
        foreach ( var_576d220b01160c72 in level.s_dark_heart.var_dd5147eb36a3795b )
        {
            foreach ( cyst_struct in var_576d220b01160c72.var_5374fb111c0954f1 )
            {
                if ( cyst_struct.sbl )
                {
                    cyst_struct.sbl destructible::destroy();
                }
            }
        }
        
        foreach ( var_576d220b01160c72 in level.s_dark_heart.var_dd5147eb36a3795b )
        {
            release_holdout( var_576d220b01160c72 );
        }
        
        foreach ( var_576d220b01160c72 in level.s_dark_heart.var_dd5147eb36a3795b )
        {
            level utility::flag_set( var_576d220b01160c72.script_noteworthy + "<dev string:x39c>" );
        }
        
        wait 5;
        level.s_dark_heart.boss_agent zombie_aeon::function_e81e91da9d7f3d31();
    }

    // Namespace zm_sat_mantis_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x45ca6de5, Offset: 0x993f
    // Size: 0x40, Type: dev
    function private function_d608e6ed62154c86()
    {
        s_heart = utility::getstruct( "<dev string:x3ab>", "<dev string:x3b6>" );
        playfx( level._effect[ "<dev string:x3c1>" ], s_heart.origin );
    }

    // Namespace zm_sat_mantis_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0xa1f0378f, Offset: 0x9987
    // Size: 0xfa, Type: dev
    function private function_80b35ac313e6a8e2()
    {
        foreach ( var_576d220b01160c72 in level.s_dark_heart.var_dd5147eb36a3795b )
        {
            foreach ( time_knot in var_576d220b01160c72.var_6b70d581e6e6843c )
            {
                time_knot thread namespace_a2abfabbd7a982fc::cannonball_zombies( 5 );
            }
        }
    }

    // Namespace zm_sat_mantis_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0xdbd42ff3, Offset: 0x9a89
    // Size: 0xfc, Type: dev
    function private function_226bc3f3cca50b35()
    {
        foreach ( var_576d220b01160c72 in level.s_dark_heart.var_dd5147eb36a3795b )
        {
            foreach ( time_knot in var_576d220b01160c72.var_6b70d581e6e6843c )
            {
                time_knot thread namespace_a2abfabbd7a982fc::spawn_time_knot( 100, 5 );
            }
        }
    }

    // Namespace zm_sat_mantis_boss_fight
    // Params 0
    // Checksum 0xa393418a, Offset: 0x9b8d
    // Size: 0xc, Type: dev
    function function_a1ec0ac5f4056638()
    {
        function_8b15006049502df0();
    }

    // Namespace zm_sat_mantis_boss_fight
    // Params 0
    // Checksum 0xb7718f0e, Offset: 0x9ba1
    // Size: 0xd, Type: dev
    function function_8c47fd1ce0207927()
    {
        function_8b15006049502df0( 0 );
    }

    // Namespace zm_sat_mantis_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0xc51ec03a, Offset: 0x9bb6
    // Size: 0x9b, Type: dev
    function private function_8c5cef3223543e2b()
    {
        foreach ( var_576d220b01160c72 in level.s_dark_heart.var_dd5147eb36a3795b )
        {
            level utility::flag_set_array( var_576d220b01160c72.wait_flags );
            release_holdout( var_576d220b01160c72 );
        }
    }

    // Namespace zm_sat_mantis_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x3365817d, Offset: 0x9c59
    // Size: 0x26, Type: dev
    function private function_3cd7c9d7154b92f5()
    {
        spawnscriptable( %"sat_zm_sat_scriptable_mantis_boss_dome", devgui::function_97024c0a6d1256a6(), ( 0, 0, 0 ) );
    }

    // Namespace zm_sat_mantis_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0xd4d9d24c, Offset: 0x9c87
    // Size: 0x2a2, Type: dev
    function private function_cf8939edc623b5df()
    {
        if ( !isdefined( level.var_b7a212a3dc7dfc05 ) )
        {
            level.var_b7a212a3dc7dfc05 = 0;
        }
        
        if ( !level utility::flag( "<dev string:x3d6>" ) )
        {
            level thread start_boss_fight();
            level utility::flag_wait( "<dev string:x3ec>" );
            level utility::flag_set( "<dev string:x3d6>" );
        }
        
        level.var_b7a212a3dc7dfc05 = !level.var_b7a212a3dc7dfc05;
        
        if ( level.var_b7a212a3dc7dfc05 )
        {
            foreach ( var_576d220b01160c72 in level.s_dark_heart.var_dd5147eb36a3795b )
            {
                var_576d220b01160c72 function_3176083662ac618d( 0, 0 );
            }
            
            foreach ( var_576d220b01160c72 in level.s_dark_heart.var_dd5147eb36a3795b )
            {
                var_576d220b01160c72.beam_vfx = playfxontagsbetweenclients( utility::getfx( "<dev string:x405>" ), level.s_dark_heart.boss_agent, "<dev string:x41f>", var_576d220b01160c72.mdl, "<dev string:x41f>" );
            }
            
            return;
        }
        
        foreach ( var_576d220b01160c72 in level.s_dark_heart.var_dd5147eb36a3795b )
        {
            var_576d220b01160c72 function_3176083662ac618d( 0, 0 );
        }
        
        foreach ( var_576d220b01160c72 in level.s_dark_heart.var_dd5147eb36a3795b )
        {
            var_576d220b01160c72.beam_vfx delete();
        }
    }

    // Namespace zm_sat_mantis_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x3b502880, Offset: 0x9f31
    // Size: 0x59, Type: dev
    function private toggle_add_spawning()
    {
        b_current = getdvarint( @"hash_ffcbf794cfa6a866", 1 );
        b_new = !b_current;
        setdvar( @"hash_ffcbf794cfa6a866", b_new );
        
        if ( b_new )
        {
            iprintlnbold( "<dev string:x42a>" );
            return;
        }
        
        iprintlnbold( "<dev string:x446>" );
    }

    // Namespace zm_sat_mantis_boss_fight
    // Params 0
    // Checksum 0xd8943d75, Offset: 0x9f92
    // Size: 0x17a, Type: dev
    function function_e0596c10bb37dba1()
    {
        if ( !isdefined( level.s_dark_heart ) || !isdefined( level.s_dark_heart.var_dd5147eb36a3795b ) )
        {
            iprintlnbold( "<dev string:x463>" );
            return;
        }
        
        if ( !isdefined( level.players ) || level.players.size == 0 )
        {
            iprintlnbold( "<dev string:x485>" );
            return;
        }
        
        player_origin = level.players[ 0 ].origin;
        var_16977da367f2ad2 = level.s_dark_heart.var_dd5147eb36a3795b;
        closest_holdout = undefined;
        closest_dist_sq = 999999999;
        
        foreach ( s_holdout in var_16977da367f2ad2 )
        {
            dist_sq = distancesquared( player_origin, s_holdout.origin );
            
            if ( dist_sq < closest_dist_sq )
            {
                closest_dist_sq = dist_sq;
                closest_holdout = s_holdout;
            }
        }
        
        if ( !isdefined( closest_holdout ) )
        {
            iprintlnbold( "<dev string:x49d>" );
            return;
        }
        
        closest_holdout thread function_b7b948c5250821a4();
        iprintlnbold( "<dev string:x4b6>" + closest_holdout.script_noteworthy );
    }

    // Namespace zm_sat_mantis_boss_fight
    // Params 1, eflags: 0x4
    // Checksum 0x4c3a2207, Offset: 0xa114
    // Size: 0xc3, Type: dev
    function private black_ichor_puddle_debug_draw( default_radius )
    {
        self endon( #"death" );
        color_puddle = ( 0.2, 0, 0.3 );
        
        while ( true )
        {
            if ( !getdvarint( @"black_ichor_puddle_debug" ) )
            {
                waitframe();
                continue;
            }
            
            radius = getdvarfloat( @"black_ichor_puddle_radius", default_radius );
            circle( self.origin + ( 0, 0, 5 ), radius, undefined, color_puddle, 1 );
            print3d( self.origin + ( 0, 0, 50 ), "<dev string:x4db>" + int( radius ), color_puddle, 1, 0.8, 1, 1 );
            waitframe();
        }
    }

    // Namespace zm_sat_mantis_boss_fight
    // Params 0
    // Checksum 0x4526a6b5, Offset: 0xa1df
    // Size: 0x58, Type: dev
    function function_b6f95c18c9ad3d6d()
    {
        current = getdvarint( @"black_ichor_puddle_debug", 0 );
        new_value = !current;
        setdvar( @"black_ichor_puddle_debug", new_value );
        
        if ( new_value )
        {
            iprintlnbold( "<dev string:x4eb>" );
            return;
        }
        
        iprintlnbold( "<dev string:x508>" );
    }

    // Namespace zm_sat_mantis_boss_fight
    // Params 0
    // Checksum 0x552b91b7, Offset: 0xa23f
    // Size: 0x97, Type: dev
    function function_594001b7886fd315()
    {
        if ( !isdefined( level.s_dark_heart ) || !isdefined( level.s_dark_heart.var_dd5147eb36a3795b ) )
        {
            iprintlnbold( "<dev string:x463>" );
            return;
        }
        
        if ( !isdefined( level.s_dark_heart.boss_agent ) )
        {
            iprintlnbold( "<dev string:x526>" );
            return;
        }
        
        iprintlnbold( "<dev string:x545>" );
        level.s_dark_heart.boss_agent setscriptablepartstate( "<dev string:x565>", "<dev string:x581>" );
        function_751266bed71d935b();
        iprintlnbold( "<dev string:x587>" );
    }

    // Namespace zm_sat_mantis_boss_fight
    // Params 0, eflags: 0x4
    // Checksum 0x1341ecc4, Offset: 0xa2de
    // Size: 0x3d, Type: dev
    function private function_6e91b80c77b8fa47()
    {
        level zombie_aeon_navigation::init_aeon_navigation( level.s_dark_heart.origin, level.s_dark_heart.var_dd5147eb36a3795b );
        iprintlnbold( "<dev string:x5a4>" );
    }

#/
