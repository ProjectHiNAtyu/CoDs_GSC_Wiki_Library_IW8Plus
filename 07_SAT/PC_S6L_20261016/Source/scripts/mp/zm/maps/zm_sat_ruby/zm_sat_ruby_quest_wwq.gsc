// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_quest_wwq.gsc  (hash_079789cc24b3c9f6.gscc) (size: 35887 Bytes / 0x8c2f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc9e381bc (3387130300)
// size ...... 35887 (0x8c2f)
// includes .. 34  (offset: 0x7fbf)
// strings ... 145 (offset: 0x80cf)
// dev strs .. 33  (offset: 0x8aa3)
// exports ... 66  (offset: 0x5657)
// cseg ...... 0xb63 + 0x4af4 (0x5657)
// imports ... 230 (offset: 0x60a7)
// animtree1 . 0   (offset: 0x8c2f)
// animtree2 . 0   (offset: 0x8c2f)
#using script_16ea1b94f0f381b3;
#using scripts\anim\dialogue;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_galileo\zombie_galileo;
#using scripts\common\ai\aitypes\zombie_shade\zombie_shade_loot_consume;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\hud_util;
#using scripts\common\scriptable;
#using scripts\common\status_effects\effect_burn;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\status_effects\effect_stun;
#using scripts\common\status_effects\effect_wound;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\ammomods\cryofreeze;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\damagefeedback;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\magicbox;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_galileo;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_telescope;
#using scripts\mp\zm\spawners\agent_spawner;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\traps\traps;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_ruby_quest_wwq;

// Namespace zm_sat_ruby_quest_wwq
// Params 0
// Checksum 0x486b5b81, Offset: 0xb81
// Size: 0x266
function init()
{
    if ( !getdvarint( @"hash_3a9ff30b9c2ea1f1", 0 ) )
    {
        return;
    }
    
    if ( isusingmatchrulesdata() && !getmatchrulesdata( "zmData", "wwQuest" ) )
    {
        return;
    }
    
    level thread ruby_wwq_complete_monitor();
    level utility::flag_wait( "zm_quest_initialized" );
    level utility::flag_wait( "zm_sat_ruby_quest_wwq_cs_completed" );
    level callback::add( "quest_item_used", &function_f50c14c277e59d6e );
    level callback::add( "on_zombie_ai_spawned", &function_612d2be546d16155 );
    level callback::add( "on_zombie_ai_killed", &function_f12fd00a1031d504 );
    level._effect[ "ice_trap_fx" ] = loadfxasset( "vfx_sat_zm_ruby_wwq_museum_ice_trap_thruster_impact" );
    level._effect[ "heat_beam_end" ] = loadfxasset( "vfx_sat_zm_ruby_wwq_telescope_heat_beam_loop_impact" );
    level._effect[ "sun_flare" ] = loadfxasset( "vfx_sat_zm_ruby_wwq_telescope_sunflare" );
    level magicbox::function_2e49cd8681e36211( 1 );
    level.ruby_wwq = zm_quest::get_quest( #"ruby_wwq" );
    zm_quest::register_quest_step( #"ruby_wwq", #"unlock_scope", &function_d3dcc769d7e543c, &function_61e5b348e99af311 );
    zm_quest::register_quest_step( #"ruby_wwq", #"heat_trap", &function_e510f3083ac0a49f, &function_61e5b048e99aec78 );
    zm_quest::register_quest_step( #"ruby_wwq", #"ice_trap", &function_a7a4e1453a6c767e, &function_61e5b148e99aeeab );
    zm_quest::register_quest_step( #"ruby_wwq", #"collect_wiring", &function_f6bb9e28336e7c99, &function_61e5b648e99af9aa );
    zm_quest::register_quest_step( #"ruby_wwq", #"collect_battery", &function_28ba7d8a3ea17038, &function_61e5b748e99afbdd );
    zm_quest::register_quest_step( #"ruby_wwq", #"collect_drone", &function_26a3e16a73985cdb, &cleanup_step_6 );
    zm_quest::register_quest_step( #"ruby_wwq", #"electric_trap", &function_48267b097b3b433a, &function_ad3ef189af8b4373 );
    level.ruby_wwq.var_e5c94f867b9ccfd3 = 0;
    level.ruby_wwq.zombie_kill_throttle = throttle::throttle_initialize( "frozen_zombies", 1, level.framedurationseconds ?? 0.1 );
    level utility::flag_wait( "begin_round_logic" );
    level utility::flag_wait( "ruby_papq_complete" );
    level thread zm_quest::start_quest( #"ruby_wwq" );
    
    /#
        function_433c32532761fa5e();
    #/
}

// Namespace zm_sat_ruby_quest_wwq
// Params 0
// Checksum 0xb0af1795, Offset: 0xdef
// Size: 0x774
function function_af37f1cf8a3e9a22()
{
    if ( !utility::flag( "ruby_papq_complete" ) || utility::flag( "ruby_wwq_complete" ) || !zm_quest::function_b0a5181ebe7bb905() )
    {
        return;
    }
    
    if ( !utility::flag( "wwq_step_1_complete" ) )
    {
        thread zm_quest::update_guidance( [ [ level.ruby_wwq.next_panel ] ], #"ruby_wwq_guidance", #"heat_1" );
        return;
    }
    
    if ( !utility::flag( "wwq_step_2_complete" ) && level.ruby_wwq.telescope_cooldown )
    {
        thread zm_quest::update_guidance( undefined, #"ruby_wwq_guidance", #"cooldown" );
        return;
    }
    
    if ( !isalive( level.ruby_wwq.oscar ) && !utility::flag( "wwq_step_2_complete" ) )
    {
        thread zm_quest::update_guidance( undefined, #"ruby_wwq_guidance", #"oscar_return" );
        return;
    }
    
    if ( !utility::flag( "wwq_step_2_complete" ) && !level.ruby_wwq.var_6a61a3b8d520aafb )
    {
        thread zm_quest::update_guidance( [ [ utility::getstruct( "telescope_interact", "targetname" ) ], [ level.ruby_wwq.oscar, 110 ] ], #"ruby_wwq_guidance", #"heat_2" );
        return;
    }
    
    if ( !utility::flag( "wwq_step_2_complete" ) )
    {
        thread zm_quest::update_guidance( [ [ utility::getstruct( "heat_beam_target" ), 0, 130 ], [ level.ruby_wwq.oscar, 110 ] ], #"ruby_wwq_guidance", #"heat_3" );
        return;
    }
    
    if ( !isalive( level.ruby_wwq.oscar ) && !utility::flag( "drone_dropped" ) )
    {
        thread zm_quest::update_guidance( undefined, #"ruby_wwq_guidance", #"oscar_return" );
        return;
    }
    
    if ( !utility::flag( "drone_dropped" ) )
    {
        thread zm_quest::update_guidance( [ [ level.ruby_wwq.oscar, 110 ] ], #"ruby_wwq_guidance", #"laser_1", 1 );
        return;
    }
    
    if ( !utility::flag( "wwq_step_6_complete" ) )
    {
        thread zm_quest::update_guidance( [ [ level.ruby_wwq.items[ %"ruby_wwq_drone_scriptable" ] ] ], #"ruby_wwq_guidance", #"laser_1", 1 );
        return;
    }
    
    if ( !utility::flag( "wiring_dropped" ) )
    {
        thread zm_quest::update_guidance( [ [ level.ruby_wwq.aberrant_lamp ] ], #"ruby_wwq_guidance", #"laser_2" );
        return;
    }
    
    if ( !utility::flag( "wwq_step_4_complete" ) )
    {
        thread zm_quest::update_guidance( [ [ level.ruby_wwq.items[ %"ruby_wwq_wiring_scriptable" ] ] ], #"ruby_wwq_guidance", #"laser_2" );
        return;
    }
    
    if ( !utility::flag( "battery_dropped" ) )
    {
        thread zm_quest::update_guidance( [ [ utility::getstruct( "battery_spawn", "targetname" ).origin ], [ level.ruby_wwq.var_3507280b31511341, 0, 300 ] ], #"ruby_wwq_guidance", #"laser_3" );
        return;
    }
    
    if ( !utility::flag( "wwq_step_5_complete" ) )
    {
        thread zm_quest::update_guidance( [ [ level.ruby_wwq.items[ %"ruby_wwq_battery_scriptable" ] ] ], #"ruby_wwq_guidance", #"laser_3" );
        return;
    }
    
    if ( !utility::flag( "wwq_step_7_complete" ) && !isdefined( level.ruby_wwq.megalaser_battery ) )
    {
        thread zm_quest::update_guidance( [ [ level.ruby_wwq.var_4864846e68915351, 0 ] ], #"ruby_wwq_guidance", #"laser_4" );
        return;
    }
    
    if ( !utility::flag( "wwq_step_7_complete" ) && level.ruby_wwq.laser_cooldown )
    {
        thread zm_quest::update_guidance( undefined, #"ruby_wwq_guidance", #"cooldown" );
        return;
    }
    
    if ( !isalive( level.ruby_wwq.oscar ) && !utility::flag( "wwq_step_7_complete" ) )
    {
        thread zm_quest::update_guidance( undefined, #"ruby_wwq_guidance", #"oscar_return" );
        return;
    }
    
    if ( !utility::flag( "wwq_step_7_complete" ) )
    {
        thread zm_quest::update_guidance( [ [ utility::getstruct( "megalaser_center", "targetname" ), 0, 400 ], [ level.ruby_wwq.oscar, 110 ], [ level.ruby_wwq.megalaser_interact, 0 ] ], #"ruby_wwq_guidance", #"laser_5" );
        return;
    }
    
    if ( !utility::flag( "wwq_step_3_complete" ) && level.ruby_wwq.var_82d0405caaf0f78f < 3 )
    {
        thread zm_quest::update_guidance( undefined, #"ruby_wwq_guidance", #"ice_1" );
        level zm_quest::function_9f49b2a045ece8ae( level.ruby_wwq.var_82d0405caaf0f78f, 1, #"ruby_wwq_guidance", #"ice_1" );
        level zm_quest::function_c2af37f835cd840b( 3, 1, #"ruby_wwq_guidance", #"ice_1" );
        return;
    }
    
    if ( !isalive( level.ruby_wwq.oscar ) && !utility::flag( "wwq_step_3_complete" ) )
    {
        thread zm_quest::update_guidance( undefined, #"ruby_wwq_guidance", #"oscar_return" );
        return;
    }
    
    if ( !utility::flag( "wwq_step_3_complete" ) )
    {
        thread zm_quest::update_guidance( [ [ utility::getstruct( "ice_trap", "targetname" ), 0, 160 ], [ utility::getstruct( "ruby_museum_rocket", "script_noteworthy" ) ], [ level.ruby_wwq.oscar, 110 ], [ utility::getstruct( "vo_rocket", "script_noteworthy" ) ] ], #"ruby_wwq_guidance", #"ice_2" );
        return;
    }
    
    thread zm_quest::update_guidance( [ [ level.ruby_wwq.var_dbd81ae37963526a ] ], #"ruby_wwq_guidance", #"grab_ww" );
}

// Namespace zm_sat_ruby_quest_wwq
// Params 2, eflags: 0x4
// Checksum 0x4e824141, Offset: 0x156b
// Size: 0x7a
function private function_d3dcc769d7e543c( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
    
    level.ruby_wwq.panel_attempts = 0;
    level scriptable::scriptable_adddamagedcallback( &observatory_panel_shot );
    level thread function_c3d61371c8ea9c88();
    waitframe();
    function_af37f1cf8a3e9a22();
    level utility::flag_wait( "wwq_step_1_complete" );
    
    /#
        iprintlnbold( "<dev string:x39>" );
    #/
}

// Namespace zm_sat_ruby_quest_wwq
// Params 1, eflags: 0x4
// Checksum 0x33944db3, Offset: 0x15ed
// Size: 0x114
function private function_c3d61371c8ea9c88( cooldown_duration = 0.01 )
{
    level endon( #"game_ended" );
    level.ruby_wwq.var_df89fab950c8f474 = getentitylessscriptablearray( "observatory_panel", #script_noteworthy );
    level.ruby_wwq.panels_activated = 0;
    
    foreach ( panel in level.ruby_wwq.var_df89fab950c8f474 )
    {
        panel setscriptablepartstate( "fx", "off" );
        panel setscriptablepartstate( "health", "idle" );
    }
    
    wait cooldown_duration;
    
    if ( !utility::flag( "wwq_step_1_complete" ) )
    {
        activate_next_panel();
    }
}

// Namespace zm_sat_ruby_quest_wwq
// Params 0, eflags: 0x4
// Checksum 0x975b88d6, Offset: 0x1709
// Size: 0xb8
function private activate_next_panel()
{
    level.ruby_wwq.next_panel = utility::array_random( level.ruby_wwq.var_df89fab950c8f474 );
    level.ruby_wwq.next_panel setscriptablepartstate( "fx", "next" );
    level.ruby_wwq.next_panel setscriptablepartstate( "health", "damageable" );
    level.ruby_wwq.var_df89fab950c8f474 = arrayremove( level.ruby_wwq.var_df89fab950c8f474, level.ruby_wwq.next_panel );
    function_af37f1cf8a3e9a22();
}

// Namespace zm_sat_ruby_quest_wwq
// Params 11, eflags: 0x4
// Checksum 0xaf578a6c, Offset: 0x17c9
// Size: 0x1b8
function private observatory_panel_shot( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != %"ruby_wwq_observatory_panel" || !isdefined( smeansofdeath ) )
    {
        return;
    }
    
    if ( !isplayer( eattacker ) )
    {
        instance setscriptablepartstate( "health", "damageable" );
        return;
    }
    
    eattacker damagefeedback::updatehitmarker( "standard", 0, 0, 0, undefined );
    instance setscriptablepartstate( "fx", "shot" );
    level.ruby_wwq.panels_activated++;
    
    /#
        iprintlnbold( "<dev string:x4e>" + level.ruby_wwq.panels_activated );
    #/
    
    if ( level.ruby_wwq.panels_activated >= 5 )
    {
        level utility::flag_set( "wwq_step_1_complete" );
        playsoundatpos( utility::getstruct( "telescope_interact", "targetname" ).origin, "evt_wwq_panel_success_on_telescope" );
        eattacker namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_4e68a048f9c38129", #"bc_flavor_player_positive" );
        return;
    }
    
    if ( level.ruby_wwq.panels_activated == 1 && level.ruby_wwq.panel_attempts == 0 )
    {
        level thread battlechatter_mp::trysaylocalsound( eattacker, #"bc_flavor_player_positive" );
    }
    
    level activate_next_panel();
    level thread function_b21ff63da19f656e();
}

// Namespace zm_sat_ruby_quest_wwq
// Params 0, eflags: 0xc
// Checksum 0x68c0f47e, Offset: 0x1989
// Size: 0x19d
function private function_b21ff63da19f656e()
{
    self notify( #"hash_894584303b8a9129" );
    self endon( #"hash_894584303b8a9129" );
    level endon( #"game_ended" );
    reset_time = 15 + minint( level.ruby_wwq.panel_attempts, 5 );
    
    if ( level.players.size == 1 )
    {
        reset_time += 5;
    }
    
    wait reset_time;
    
    if ( !utility::flag( "wwq_step_1_complete" ) )
    {
        zm_quest::function_b5d75b34f712db9a();
        var_f6ef1a31438751bd = utility::getstruct( "heat_beam_target" ).origin;
        level thread zm_utility::function_1d82e63812f9640a( var_f6ef1a31438751bd, 1500, 1, "heavy_1s", 0.3, 1500, "heavy_1s", 0.3 );
        playsoundatpos( utility::getstruct( "telescope_interact", "targetname" ).origin, "evt_wwq_panel_fail_on_telescope" );
        level.ruby_wwq.panel_attempts++;
        level thread function_c3d61371c8ea9c88( 30 );
        wait 2;
        
        if ( isalive( level.ruby_wwq.oscar ) )
        {
            if ( distance2d( level.ruby_wwq.oscar.origin, var_f6ef1a31438751bd ) > 1000 )
            {
                level.ruby_wwq.oscar zm_sat_ruby_galileo::function_84919f8f8db67077( var_f6ef1a31438751bd );
            }
            
            level.ruby_wwq.oscar zombie_galileo::function_d317ff95fb386140( level.ruby_wwq.oscar utility::get_closest_player(), 5 );
        }
    }
}

// Namespace zm_sat_ruby_quest_wwq
// Params 2, eflags: 0x4
// Checksum 0xeaf91de3, Offset: 0x1b2e
// Size: 0x42
function private function_61e5b348e99af311( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "wwq_step_1_complete" );
        level thread function_c3d61371c8ea9c88();
    }
    
    level scriptable::function_dc174fecebb79952( &observatory_panel_shot );
}

// Namespace zm_sat_ruby_quest_wwq
// Params 2, eflags: 0x4
// Checksum 0x3d86ff31, Offset: 0x1b78
// Size: 0x63
function private function_e510f3083ac0a49f( b_skipped, b_save_restored )
{
    spawn_sun();
    
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level utility::flag_wait( "wwq_step_1_complete" );
    function_af37f1cf8a3e9a22();
    
    /#
        iprintlnbold( "<dev string:x60>" );
    #/
    
    level utility::flag_wait( "wwq_step_2_complete" );
    
    /#
        iprintlnbold( "<dev string:x75>" );
    #/
}

// Namespace zm_sat_ruby_quest_wwq
// Params 0, eflags: 0x4
// Checksum 0xc59f3ee4, Offset: 0x1be3
// Size: 0x77
function private spawn_sun()
{
    level.ruby_wwq.m_sun = utility::spawn_model( "sat_zm_pipe_organ_regurgirator_sun" );
    playfxontag( utility::getfx( "sun_flare" ), level.ruby_wwq.m_sun, "tag_origin" );
    zm_sat_ruby_telescope::function_b095db21aed570fe( level.ruby_wwq.m_sun, 1 );
    level callback::add( "telescope_target_acquired", &sun_spotted );
}

// Namespace zm_sat_ruby_quest_wwq
// Params 1, eflags: 0x4
// Checksum 0x39533645, Offset: 0x1c62
// Size: 0x1ae
function private sun_spotted( params )
{
    if ( params.ent == level.ruby_wwq.m_sun )
    {
        /#
            iprintlnbold( "<dev string:x8a>" );
        #/
        
        level.ruby_wwq.var_6a61a3b8d520aafb = 1;
        function_af37f1cf8a3e9a22();
        wait 0.5;
        zm_sat_ruby_telescope::disable_telescope();
        
        if ( isalive( level.ruby_wwq.oscar ) && level.players.size == 1 )
        {
            var_1ef12d041f68b1f0 = distance2d( level.ruby_wwq.oscar.origin, level.players[ 0 ].origin );
            
            if ( var_1ef12d041f68b1f0 < 1300 )
            {
                if ( var_1ef12d041f68b1f0 > 600 )
                {
                    a_teleport_locs = utility::getstructarray( "oscar_solo_telescope_teleport", "targetname" );
                    level.ruby_wwq.oscar.origin = utility::array_random( a_teleport_locs ).origin;
                    waitframe();
                }
                
                level.ruby_wwq.oscar thread zombie_galileo::function_d317ff95fb386140( level.players[ 0 ], 5 );
            }
        }
        
        wait 1;
        level thread activate_heat_trap();
        
        if ( !utility::flag( "sun_spotted_vo_played" ) )
        {
            var_db75d3de862ce072 = params.spotter namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_cfc4460246280085", #"hash_5212ed7ec42f115a" );
            
            if ( var_db75d3de862ce072 )
            {
                utility::flag_set( "sun_spotted_vo_played" );
            }
        }
    }
}

// Namespace zm_sat_ruby_quest_wwq
// Params 0, eflags: 0x4
// Checksum 0x8d2d52f2, Offset: 0x1e18
// Size: 0x253
function private activate_heat_trap()
{
    level endon( #"game_ended" );
    v_beam_end = utility::getstruct( "heat_beam_target" ).origin;
    level.ruby_telescope.scriptable utility::function_7c10ea82c1e305b8( "beam", "wwq_beam_active" );
    level.ruby_wwq.heat_beam_end = utility::spawn_model( "tag_origin", v_beam_end );
    playfxontag( utility::getfx( "heat_beam_end" ), level.ruby_wwq.heat_beam_end, "tag_origin" );
    base_zombie_maxhealth = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", zm_round_logic::get_rb_round_number() );
    heat_beam_timer = 0;
    level.ruby_wwq.var_2df3a575292743 = 0;
    
    while ( heat_beam_timer < 40 && !utility::flag( "wwq_step_2_complete" ) )
    {
        heat_trap_zombies = getaiarrayinradius( v_beam_end, 130, "team_two_hundred" );
        
        foreach ( zombie in heat_trap_zombies )
        {
            zombie thread effect_burn::burn( 3, base_zombie_maxhealth * 0.05, 1 );
            
            if ( zombie.subclass == "zombie_galileo_drone" )
            {
                zombie kill();
            }
        }
        
        foreach ( player in getplayersinradius( v_beam_end, 130 ) )
        {
            player dodamage( 10, v_beam_end, player, player, "MOD_FIRE", level.weaponnone, "none", undefined, 65536 );
        }
        
        function_76df56b3bea5dd45( v_beam_end );
        wait 0.5;
        heat_beam_timer += 0.5;
    }
    
    deactivate_heat_trap();
}

// Namespace zm_sat_ruby_quest_wwq
// Params 1, eflags: 0x4
// Checksum 0x9e6f6450, Offset: 0x2073
// Size: 0x2f7
function private function_76df56b3bea5dd45( beam_loc )
{
    if ( !isalive( level.ruby_wwq.oscar ) || utility::flag( "wwq_step_2_complete" ) )
    {
        return;
    }
    
    if ( distance2dsquared( level.ruby_wwq.oscar.origin, beam_loc ) < 16900 )
    {
        level.ruby_wwq.var_2df3a575292743 += 0.5;
        level.ruby_wwq.oscar.aisettings.var_3dae55586fee0a61 = 1;
        level.ruby_wwq.oscar effect_slow::slow( "heat_beam", 0.5, 0.5 );
    }
    else
    {
        level.ruby_wwq.var_2df3a575292743 = max( level.ruby_wwq.var_2df3a575292743 - 0.15, 0 );
        
        if ( utility::flag( "wwq_step_3_complete" ) )
        {
            level.ruby_wwq.oscar.aisettings.var_3dae55586fee0a61 = 0;
        }
    }
    
    heat_pct = round( level.ruby_wwq.var_2df3a575292743 / 8, 0.01 );
    
    /#
        iprintln( "<dev string:x96>" + heat_pct );
    #/
    
    heat_state = string( round( heat_pct, 0.2 ) * 100 );
    level.ruby_wwq.oscar function_70576dbab4f88e19( "snd_modifier_oscar_heat_pct", heat_pct );
    level.ruby_wwq.oscar utility::function_32b24db3127bff40( "heat_glow", heat_state );
    level.ruby_wwq.oscar utility::function_32b24db3127bff40( "sfx_overheat", "on" );
    
    if ( level.ruby_wwq.var_2df3a575292743 >= 8 )
    {
        level utility::flag_set( "wwq_step_2_complete" );
        level.ruby_wwq.oscar playsound( "evt_wwq_oscar_overheat_disappear" );
        level.ruby_wwq.oscar thread function_2dfdc65b0a07a785( "heat" );
        
        foreach ( zombie in getaiarrayinradius( beam_loc, 250, "team_two_hundred" ) )
        {
            if ( zombie.subclass != "zombie_galileo" )
            {
                zombie kill();
            }
        }
    }
}

// Namespace zm_sat_ruby_quest_wwq
// Params 0, eflags: 0x4
// Checksum 0x1688447e, Offset: 0x2372
// Size: 0x129
function private deactivate_heat_trap()
{
    if ( isdefined( level.ruby_wwq.oscar ) )
    {
        level.ruby_wwq.oscar utility::function_32b24db3127bff40( "heat_glow", "0" );
        level.ruby_wwq.oscar utility::function_32b24db3127bff40( "sfx_overheat", "off" );
    }
    
    level.ruby_telescope.scriptable utility::function_7c10ea82c1e305b8( "beam", "wwq_beam_end" );
    stopfxontag( utility::getfx( "heat_beam_end" ), level.ruby_wwq.heat_beam_end, "tag_origin" );
    playfxontag( utility::getfx( "cooldown_smoke" ), level.var_d4d3b5b9c13ddd56, "tag_origin" );
    zm_sat_ruby_telescope::function_e31deed3aaa2f253( 5, 5 );
    level.ruby_wwq.var_6a61a3b8d520aafb = 0;
    level.ruby_wwq.telescope_cooldown = 1;
    
    if ( !utility::flag( "wwq_step_2_complete" ) )
    {
        function_af37f1cf8a3e9a22();
    }
    
    level callback::add( "on_round_start", &restart_telescope );
}

// Namespace zm_sat_ruby_quest_wwq
// Params 1, eflags: 0x4
// Checksum 0xe69885f0, Offset: 0x24a3
// Size: 0x7e
function private restart_telescope( var_8582cc5f29b6732c )
{
    zm_sat_ruby_telescope::enable_telescope();
    level.ruby_wwq.telescope_cooldown = 0;
    stopfxontag( utility::getfx( "cooldown_smoke" ), level.var_d4d3b5b9c13ddd56, "tag_origin" );
    
    if ( utility::flag( "wwq_step_2_complete" ) )
    {
        level.var_d4d3b5b9c13ddd56 delete();
    }
    else
    {
        function_af37f1cf8a3e9a22();
    }
    
    level callback::remove( "on_round_start", &restart_telescope );
}

// Namespace zm_sat_ruby_quest_wwq
// Params 2, eflags: 0x4
// Checksum 0x906f40e6, Offset: 0x2529
// Size: 0x96
function private function_61e5b048e99aec78( b_skipped, b_save_restored )
{
    zm_sat_ruby_telescope::function_b28785f5286548e3( level.ruby_wwq.m_sun );
    level callback::remove( "telescope_target_acquired", &sun_spotted );
    level.ruby_wwq.var_e5c94f867b9ccfd3++;
    level thread zm_quest::update_round_cap( 7 + level.ruby_wwq.var_e5c94f867b9ccfd3 * 2 );
    
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "wwq_step_2_complete" );
        waitframe();
        function_af37f1cf8a3e9a22();
    }
}

// Namespace zm_sat_ruby_quest_wwq
// Params 2, eflags: 0x4
// Checksum 0xb7d5a225, Offset: 0x25c7
// Size: 0xdc
function private function_a7a4e1453a6c767e( b_skipped, b_save_restored )
{
    level.ruby_wwq.var_e8979f64de7b469a = zm_quest::function_73720cdf21c3cfd7( #"ruby_wwq", #"ice_fragment" ) ?? 0;
    level.ruby_wwq.var_82d0405caaf0f78f = zm_quest::function_73720cdf21c3cfd7( #"ruby_wwq", #"ice_fragment" ) ?? 0;
    zm_quest::function_b57dfe9625966b0b( #"ruby_ww", 0, #"ice_fragment", level.ruby_wwq.var_82d0405caaf0f78f );
    setup_ice_trap();
    
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    /#
        iprintlnbold( "<dev string:xa9>" );
    #/
    
    level utility::flag_wait( "wwq_step_3_complete" );
    
    /#
        iprintlnbold( "<dev string:xbe>" );
    #/
}

// Namespace zm_sat_ruby_quest_wwq
// Params 1, eflags: 0x4
// Checksum 0x5e0c7954, Offset: 0x26ab
// Size: 0x236
function private aether_crystal_destroyed( params )
{
    if ( isplayer( params.var_64ffacba090c91be ) && level.ruby_wwq.var_e8979f64de7b469a < 3 )
    {
        if ( params.var_64ffacba090c91be namespace_9d8e359c3b1041e5::function_30cd19b8533d27d2( params.var_64ffacba090c91be.currentweapon ) == "cryofreeze" )
        {
            level thread function_d3fce780a8c0a776( %"ruby_wwq_abs_zero_fragment_scriptable", params.instance.origin, undefined, &function_ac58634bab644e1d );
            level.ruby_wwq.var_e8979f64de7b469a++;
            return;
        }
        
        if ( zm_quest::function_b0a5181ebe7bb905() && utility::flag( "wwq_step_2_complete" ) && utility::flag( "wwq_step_7_complete" ) && level.ruby_wwq.var_e8979f64de7b469a == 0 && !level.ruby_wwq.var_1d021d8a5b078d11 )
        {
            foreach ( player in level.players )
            {
                foreach ( weap in player.equippedweapons )
                {
                    if ( player namespace_9d8e359c3b1041e5::function_30cd19b8533d27d2( weap ) == "cryofreeze" )
                    {
                        return;
                    }
                }
            }
            
            level.ruby_wwq.var_1d021d8a5b078d11 = 1;
            spawnoptions = common_item::items_initspawnoptions_spawnfromentity( params.instance );
            common_item::items_spawnitemfromscriptable( "zmloot_ammomod_cryofreeze", 1, spawnoptions );
        }
    }
}

// Namespace zm_sat_ruby_quest_wwq
// Params 0, eflags: 0x4
// Checksum 0x85fc1776, Offset: 0x28e9
// Size: 0x37
function private function_ac58634bab644e1d()
{
    self freescriptable();
    level.ruby_wwq.var_e8979f64de7b469a = maxint( level.ruby_wwq.var_e8979f64de7b469a - 1, 0 );
}

// Namespace zm_sat_ruby_quest_wwq
// Params 0, eflags: 0x4
// Checksum 0x5116853f, Offset: 0x2928
// Size: 0x4e
function private setup_ice_trap()
{
    level.ruby_wwq.museum_trap = getentitylessscriptablearray( "rocket_exhibit", #targetname )[ 0 ];
    level callback::add( "museum_exhibit_interact", &on_rocket_exhibit_interact );
    level callback::add( "loot_crystal_destroyed", &aether_crystal_destroyed );
}

// Namespace zm_sat_ruby_quest_wwq
// Params 1, eflags: 0x4
// Checksum 0xdb7eca2a, Offset: 0x297e
// Size: 0x54
function private on_rocket_exhibit_interact( params )
{
    if ( params.exhibit_name != "ruby_museum_rocket" )
    {
        return;
    }
    
    if ( level.ruby_wwq.var_82d0405caaf0f78f == 3 )
    {
        level.ruby_wwq.museum_trap thread trigger_ice_trap();
    }
}

// Namespace zm_sat_ruby_quest_wwq
// Params 0, eflags: 0x4
// Checksum 0x446a13dd, Offset: 0x29da
// Size: 0x297
function private trigger_ice_trap()
{
    level endon( #"game_ended" );
    level.ruby_wwq.var_e8979f64de7b469a = 0;
    level.ruby_wwq.var_82d0405caaf0f78f = 0;
    zm_quest::function_b57dfe9625966b0b( #"ruby_ww", 0, #"ice_fragment", 0 );
    zm_quest::function_4eefe6de31f5ddab( #"ruby_wwq", #"ice_fragment", level.ruby_wwq.var_82d0405caaf0f78f );
    self setscriptablepartstate( "fx", "countdown" );
    ice_trap_origin = utility::getstruct( "ice_trap", "targetname" ).origin;
    wait 7.25;
    self setscriptablepartstate( "fx", "blastoff" );
    playfx( utility::getfx( "ice_trap_fx" ), ice_trap_origin );
    base_zombie_maxhealth = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", zm_round_logic::get_rb_round_number() );
    ice_trap_zombies = getaiarrayinradius( ice_trap_origin, 160 );
    
    foreach ( zombie in ice_trap_zombies )
    {
        if ( isalive( zombie ) )
        {
            if ( zombie == level.ruby_wwq.oscar )
            {
                level utility::flag_set( "wwq_step_3_complete" );
                level.ruby_wwq.oscar thread function_2dfdc65b0a07a785( "ice" );
            }
            else
            {
                zombie dodamage( base_zombie_maxhealth * 0.5, zombie.origin, undefined, undefined, undefined, undefined, undefined, undefined, 1073741824 );
                zombie cryofreeze::function_78dcfeb8fef113fb( 0, self, undefined, "<explicitweaponnone>", zombie getcentroid(), undefined, undefined, 20, 0.01 );
            }
        }
        
        throttle::throttle_wait_in_queue( level.ruby_wwq.zombie_kill_throttle, zombie );
    }
    
    if ( !utility::flag( "wwq_step_3_complete" ) && zm_quest::function_b0a5181ebe7bb905() )
    {
        function_af37f1cf8a3e9a22();
        level zm_quest::function_9f49b2a045ece8ae( level.ruby_wwq.var_82d0405caaf0f78f, 1, #"ruby_wwq_guidance", #"ice_1" );
    }
    
    wait 5;
    level.ruby_wwq.museum_trap setscriptablepartstate( "fx", "idle" );
}

// Namespace zm_sat_ruby_quest_wwq
// Params 2, eflags: 0x4
// Checksum 0x74c5570d, Offset: 0x2c79
// Size: 0x8d
function private function_61e5b148e99aeeab( b_skipped, b_save_restored )
{
    level callback::remove( "loot_crystal_destroyed", &aether_crystal_destroyed );
    level callback::remove( "museum_exhibit_interact", &on_rocket_exhibit_interact );
    level.ruby_wwq.var_e5c94f867b9ccfd3++;
    level thread zm_quest::update_round_cap( 7 + level.ruby_wwq.var_e5c94f867b9ccfd3 * 2 );
    
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "wwq_step_3_complete" );
        function_af37f1cf8a3e9a22();
    }
}

// Namespace zm_sat_ruby_quest_wwq
// Params 2, eflags: 0x4
// Checksum 0x9fccc52e, Offset: 0x2d0e
// Size: 0x4f
function private function_f6bb9e28336e7c99( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    setup_aberrant_lamp();
    
    /#
        iprintlnbold( "<dev string:xd3>" );
    #/
    
    level utility::flag_wait( "wwq_step_4_complete" );
    
    /#
        iprintlnbold( "<dev string:xe8>" );
    #/
}

// Namespace zm_sat_ruby_quest_wwq
// Params 0, eflags: 0x4
// Checksum 0xa918609c, Offset: 0x2d65
// Size: 0x113
function private setup_aberrant_lamp()
{
    a_s_lamps = utility::getstructarray( "aberrant_lamp", "targetname" );
    s_aberrant_lamp = utility::array_random( a_s_lamps );
    level.ruby_wwq.aberrant_lamp = spawnscriptable( "ruby_wwq_aberrant_lamp", s_aberrant_lamp.origin, s_aberrant_lamp.angles );
    level.ruby_wwq.aberrant_lamp.noteworthy = s_aberrant_lamp.script_noteworthy;
    level.ruby_wwq.aberrant_lamp.wire_landing = utility::getstruct( s_aberrant_lamp.script_noteworthy + "_landing", "targetname" ).origin;
    scriptable::scriptable_adddamagedcallback( &aberrant_lamp_shot );
    activateworldevent( "we_lgt_wwq_" + s_aberrant_lamp.script_noteworthy );
    level callback::add( #"player_connect", &function_d46296fb140ba54e, s_aberrant_lamp.script_noteworthy );
}

// Namespace zm_sat_ruby_quest_wwq
// Params 2, eflags: 0x4
// Checksum 0xbba4c253, Offset: 0x2e80
// Size: 0x32
function private function_d46296fb140ba54e( params, lamp )
{
    self waittill( #"spawned_player" );
    activateworldevent( "we_lgt_wwq_" + lamp, 1, self );
}

// Namespace zm_sat_ruby_quest_wwq
// Params 11, eflags: 0x4
// Checksum 0xf562306b, Offset: 0x2eba
// Size: 0x11c
function private aberrant_lamp_shot( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance getscriptablehaspart( "aberrant_lamp_base" ) )
    {
        if ( instance getscriptablepartstate( "aberrant_lamp_base" ) == "intact" )
        {
            /#
                iprintlnbold( "<dev string:xfd>" );
            #/
            
            instance setscriptablepartstate( "aberrant_lamp_base", "destroyed" );
            deactivateworldevent( "we_lgt_wwq_" + instance.noteworthy );
            level callback::remove( #"player_connect", &function_d46296fb140ba54e );
            scriptable::function_dc174fecebb79952( &aberrant_lamp_shot );
            level thread function_d3fce780a8c0a776( %"ruby_wwq_wiring_scriptable", instance.origin, instance.wire_landing );
            level utility::flag_set( "wiring_dropped" );
            wait 1;
            function_af37f1cf8a3e9a22();
        }
    }
}

// Namespace zm_sat_ruby_quest_wwq
// Params 2, eflags: 0x4
// Checksum 0x4dd5a29e, Offset: 0x2fde
// Size: 0xb3
function private function_61e5b648e99af9aa( b_skipped, b_save_restored )
{
    if ( isdefined( level.ruby_wwq.aberrant_lamp ) )
    {
        level.ruby_wwq.aberrant_lamp freescriptable();
    }
    
    if ( b_skipped || b_save_restored )
    {
        zm_quest::function_b57dfe9625966b0b( #"ruby_ww", 0, #"wiring", 1 );
        zm_quest::function_4eefe6de31f5ddab( #"ruby_wwq", #"wiring", 1 );
        scriptable::function_dc174fecebb79952( &aberrant_lamp_shot );
        level utility::flag_set( "wiring_dropped" );
        level utility::flag_set( "wwq_step_4_complete" );
    }
    
    function_af37f1cf8a3e9a22();
}

// Namespace zm_sat_ruby_quest_wwq
// Params 2, eflags: 0x4
// Checksum 0x462dce23, Offset: 0x3099
// Size: 0x9f
function private function_28ba7d8a3ea17038( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level.ruby_wwq.var_3507280b31511341 = getent( "vehicle_damage_trigger", #targetname );
    
    if ( isdefined( level.ruby_wwq.var_3507280b31511341 ) )
    {
        level.ruby_wwq.var_3507280b31511341 thread tessie_damage_watcher();
    }
    
    /#
        iprintlnbold( "<dev string:x110>" );
    #/
    
    level utility::flag_wait( "wwq_step_5_complete" );
    
    /#
        iprintlnbold( "<dev string:x125>" );
    #/
}

// Namespace zm_sat_ruby_quest_wwq
// Params 0, eflags: 0x4
// Checksum 0xef9e4afa, Offset: 0x3140
// Size: 0x1b7
function private tessie_damage_watcher()
{
    self endon( #"death" );
    level endon( #"hash_e1fba10c82375793" );
    tessie_punched = 0;
    tessie = getent( "ruby_crashed_vehicle", #targetname );
    
    while ( tessie_punched == 0 )
    {
        self waittill( #"damage", idamage, eattacker, vdir, vpoint, smeansofdeath, smodelname, stagname, spartname, idflags, objweapon, origin, angles, normal, einflictor, eventid );
        
        if ( eattacker namespace_9d8e359c3b1041e5::function_1d4087075103b248( objweapon ) > 0 && distance2dsquared( self.origin, eattacker.origin ) < 90000 )
        {
            tessie utility::function_7c10ea82c1e305b8( "hood", "hood_pop" );
            playsoundatpos( self.origin, "evt_wwq_tessie_alarm" );
            level thread function_d3fce780a8c0a776( %"ruby_wwq_battery_scriptable", utility::getstruct( "battery_spawn", "targetname" ).origin, utility::getstruct( "battery_landing", "targetname" ).origin );
            level thread function_f16409a53c5a6aa( eattacker );
            thread function_38f816afbfe2eef2();
            tessie_punched = 1;
        }
    }
    
    level utility::flag_set( "battery_dropped" );
    wait 1;
    function_af37f1cf8a3e9a22();
}

// Namespace zm_sat_ruby_quest_wwq
// Params 0, eflags: 0x4
// Checksum 0x42dac998, Offset: 0x32ff
// Size: 0xb
function private function_38f816afbfe2eef2()
{
    wait 15;
    self delete();
}

// Namespace zm_sat_ruby_quest_wwq
// Params 1, eflags: 0x4
// Checksum 0x3bd7dd76, Offset: 0x3312
// Size: 0x15a
function private function_f16409a53c5a6aa( var_64ffacba090c91be )
{
    level endon( #"game_ended" );
    zombie_type = function_b3988325430ce242( "zombie_base" );
    zone_spawners = zone_spawner::function_20c574a6ba7cc5c6( [ "zone_landing", "zone_landing_upper" ], zombie_type );
    
    for ( i = 0; i < 12 + level.players.size * 2 ; i++ )
    {
        spawn_quest_zombie( zombie_type, utility::array_random( zone_spawners ) );
    }
    
    wait 2;
    
    if ( isalive( level.ruby_wwq.oscar ) && !level.ruby_wwq.oscar zombie_galileo::is_in_combat() )
    {
        if ( distance2d( level.ruby_wwq.oscar.origin, utility::getstruct( "battery_spawn", "targetname" ).origin ) > 2000 )
        {
            level.ruby_wwq.oscar zm_sat_ruby_galileo::function_84919f8f8db67077( utility::getstruct( "tessie_ambush_oscar_spawn", "targetname" ).origin, 0 );
        }
        
        level.ruby_wwq.oscar zombie_galileo::function_d317ff95fb386140( var_64ffacba090c91be, 5 );
    }
}

// Namespace zm_sat_ruby_quest_wwq
// Params 2, eflags: 0x4
// Checksum 0x27c645c3, Offset: 0x3474
// Size: 0xb3
function private function_61e5b748e99afbdd( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        zm_quest::function_b57dfe9625966b0b( #"ruby_ww", 0, #"battery", 1 );
        zm_quest::function_4eefe6de31f5ddab( #"ruby_wwq", #"battery", 1 );
        level notify( #"hash_e1fba10c82375793" );
        level utility::flag_set( "battery_dropped" );
        level utility::flag_set( "wwq_step_5_complete" );
        
        if ( isdefined( level.ruby_wwq.var_3507280b31511341 ) )
        {
            level.ruby_wwq.var_3507280b31511341 delete();
        }
    }
    
    function_af37f1cf8a3e9a22();
}

// Namespace zm_sat_ruby_quest_wwq
// Params 2, eflags: 0x4
// Checksum 0x6c2ef279, Offset: 0x352f
// Size: 0x5a
function private function_26a3e16a73985cdb( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level callback::add( "on_zombie_ai_killed", &function_631adee9b13ab24e );
    
    /#
        iprintlnbold( "<dev string:x13a>" );
    #/
    
    level utility::flag_wait( "wwq_step_6_complete" );
    
    /#
        iprintlnbold( "<dev string:x14f>" );
    #/
}

// Namespace zm_sat_ruby_quest_wwq
// Params 1, eflags: 0x4
// Checksum 0x226f8c50, Offset: 0x3591
// Size: 0x87
function private function_631adee9b13ab24e( params )
{
    if ( self.subclass == "zombie_galileo_drone" && !utility::flag( "drone_dropped" ) )
    {
        if ( isplayer( params.eattacker ) || self.killed_by_trap == 1 )
        {
            level utility::flag_set( "drone_dropped" );
            level thread function_d3fce780a8c0a776( %"ruby_wwq_drone_scriptable", self.origin, undefined, &function_948bb6daba32a705 );
            wait 1;
            function_af37f1cf8a3e9a22();
        }
    }
}

// Namespace zm_sat_ruby_quest_wwq
// Params 0, eflags: 0xc
// Checksum 0xacf5382c, Offset: 0x3620
// Size: 0x34
function private function_948bb6daba32a705()
{
    self notify( #"hash_8cfe73f340ac0f12" );
    self endon( #"hash_8cfe73f340ac0f12" );
    self freescriptable();
    level utility::flag_clear( "drone_dropped" );
    function_af37f1cf8a3e9a22();
}

// Namespace zm_sat_ruby_quest_wwq
// Params 2, eflags: 0x4
// Checksum 0xa8474314, Offset: 0x365c
// Size: 0x8a
function private cleanup_step_6( b_skipped, b_save_restored )
{
    level callback::remove( "on_zombie_ai_killed", &function_631adee9b13ab24e );
    
    if ( b_skipped || b_save_restored )
    {
        zm_quest::function_b57dfe9625966b0b( #"ruby_ww", 0, #"drone", 1 );
        zm_quest::function_4eefe6de31f5ddab( #"ruby_wwq", #"drone", 1 );
        level utility::flag_set( "drone_dropped" );
        level utility::flag_set( "wwq_step_6_complete" );
    }
    
    function_af37f1cf8a3e9a22();
}

// Namespace zm_sat_ruby_quest_wwq
// Params 2, eflags: 0x4
// Checksum 0x85dcfd27, Offset: 0x36ee
// Size: 0x72
function private function_48267b097b3b433a( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level utility::flag_wait_all( "wwq_step_4_complete", "wwq_step_5_complete", "wwq_step_6_complete", "laser_trap_switch_trap_init_finished" );
    setup_megalaser_trap();
    function_af37f1cf8a3e9a22();
    
    /#
        iprintlnbold( "<dev string:x164>" );
    #/
    
    level utility::flag_wait( "wwq_step_7_complete" );
    
    /#
        iprintlnbold( "<dev string:x179>" );
    #/
}

// Namespace zm_sat_ruby_quest_wwq
// Params 0, eflags: 0x4
// Checksum 0xb57ff2a, Offset: 0x3768
// Size: 0xe3
function private setup_megalaser_trap()
{
    traps::function_477b6dafe486c6b0( "laser_trap_switch", 1 );
    level.var_f301c0b95ea728e2[ 1 ].a_switch_pos[ 0 ].switch_scriptable setscriptablepartstate( "base", "ready" );
    level.ruby_wwq.var_4864846e68915351 = spawnscriptable( "ruby_scriptable_interact", utility::getstruct( "megalaser_parts_interact", "targetname" ).origin, utility::getstruct( "megalaser_parts_interact", "targetname" ).angles );
    level.ruby_wwq.var_4864846e68915351 = interaction::register_scriptable_interact( level.ruby_wwq.var_4864846e68915351, &function_7f0fae8c158847de );
    level.ruby_wwq.var_4864846e68915351 interaction::set_interact_hint_callback( &function_55d07d0249a680c2 );
}

// Namespace zm_sat_ruby_quest_wwq
// Params 2, eflags: 0x4
// Checksum 0xf12036e0, Offset: 0x3853
// Size: 0x89
function private function_55d07d0249a680c2( usable, player )
{
    if ( zm_quest::function_b0a5181ebe7bb905() && !player.interactions_disabled )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby/wwq_step_7_parts", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_ruby_quest_wwq
// Params 1, eflags: 0x4
// Checksum 0x8581508b, Offset: 0x38e4
// Size: 0x1b1
function private function_7f0fae8c158847de( player )
{
    level.ruby_wwq.megalaser_battery = utility::spawn_model( "sat_zm_projector_laser_trap_battery", utility::getstruct( "battery_insert", "targetname" ).origin, utility::getstruct( "battery_insert", "targetname" ).angles );
    level.ruby_wwq.megalaser_drone = utility::spawn_model( "offhand_sat_zm_ufo_small_01_fxanim", utility::getstruct( "drone_insert", "targetname" ).origin, utility::getstruct( "drone_insert", "targetname" ).angles );
    playsoundatpos( utility::getstruct( "battery_insert", "targetname" ).origin, #"hash_b410eb3153bce48b" );
    level.ruby_wwq.megalaser_interact = spawnscriptable( "ruby_scriptable_interact", utility::getstruct( "megalaser_interact", "targetname" ).origin, utility::getstruct( "megalaser_interact", "targetname" ).angles );
    level.ruby_wwq.megalaser_interact = interaction::register_scriptable_interact( level.ruby_wwq.megalaser_interact, &activate_megalaser_trap );
    level.ruby_wwq.megalaser_interact interaction::set_interact_hint_callback( &megalaser_interact_hint );
    level.ruby_wwq.var_2c9ab4e8cbdf0a24 = utility::spawn_model( "tag_origin", self.origin );
    function_af37f1cf8a3e9a22();
    self freescriptable();
}

// Namespace zm_sat_ruby_quest_wwq
// Params 2, eflags: 0x4
// Checksum 0x7513666, Offset: 0x3a9d
// Size: 0x7f
function private megalaser_interact_hint( usable, player )
{
    if ( !player.interactions_disabled )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby/wwq_step_7_activate", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_ruby_quest_wwq
// Params 1, eflags: 0x4
// Checksum 0x87c4e7c9, Offset: 0x3b24
// Size: 0x3a3
function private activate_megalaser_trap( params )
{
    /#
        iprintlnbold( "<dev string:x18e>" );
    #/
    
    activateworldevent( "we_lgt_laser_trap" );
    level.laser_trap_emitter setscriptablepartstate( "fx", "megalaser_on" );
    level.laser_trap_coil setscriptablepartstate( "fx", "megalaser_start" );
    level.var_f301c0b95ea728e2[ 1 ].a_switch_pos[ 0 ].switch_scriptable setscriptablepartstate( "base", "activate" );
    level.ruby_wwq.megalaser_interact function_7653c765b6c7b815();
    level.ruby_wwq.b_megalaser_active = 1;
    zm_quest::function_5b5c737326035ea( 2 );
    v_megalaser_center = utility::getstruct( "megalaser_center", "targetname" ).origin;
    level thread function_fe2b2362b43c1c5( v_megalaser_center );
    level thread function_3839773166e3f987( v_megalaser_center );
    wait 40.5;
    
    /#
        iprintlnbold( "<dev string:x1a6>" );
    #/
    
    deactivateworldevent( "we_lgt_laser_trap" );
    level.laser_trap_emitter setscriptablepartstate( "fx", "off" );
    level.laser_trap_coil setscriptablepartstate( "fx", "end" );
    level.var_f301c0b95ea728e2[ 1 ].a_switch_pos[ 0 ].switch_scriptable setscriptablepartstate( "base", "cooldown" );
    level.ruby_wwq.b_megalaser_active = 0;
    level notify( #"megalaser_ended" );
    
    if ( level.ruby_wwq.var_ed0b6e3a754977ce >= 39 )
    {
        level utility::flag_set( "wwq_step_7_complete" );
        
        if ( !zm_quest::function_b0a5181ebe7bb905() )
        {
            waitframe();
            level zm_quest::function_fb3af5600f6a9441( 4, 1, #"ruby_wwq", #"electric_trap_progress" );
        }
        
        level.ruby_wwq.oscar thread function_2dfdc65b0a07a785( "elec" );
        
        foreach ( zombie in getaiarrayinradius( v_megalaser_center, 400, "team_two_hundred" ) )
        {
            zombie thread megalaser_shock( 15, 17 );
        }
        
        foreach ( zombie in getaiarrayinradius( v_megalaser_center, 1600, "team_two_hundred" ) )
        {
            if ( zombie.kiastring == #"zombie_kia_mission_kill" && distance2d( zombie.origin, v_megalaser_center ) > 400 )
            {
                zombie kill();
            }
        }
        
        return;
    }
    
    level callback::add( "on_round_start", &reactivate_megalaser_trap );
    level.ruby_wwq.laser_cooldown = 1;
    playfxontag( utility::getfx( "cooldown_smoke" ), level.ruby_wwq.var_2c9ab4e8cbdf0a24, "tag_origin" );
    level zm_quest::function_fb3af5600f6a9441( 3, 1, #"ruby_wwq", #"electric_trap_progress" );
    function_af37f1cf8a3e9a22();
}

// Namespace zm_sat_ruby_quest_wwq
// Params 1, eflags: 0x4
// Checksum 0x74664b51, Offset: 0x3ecf
// Size: 0x14c
function private function_fe2b2362b43c1c5( v_megalaser_center )
{
    level endon( #"game_ended" );
    level endon( #"megalaser_ended" );
    var_e04d9cfdf75617a = 0;
    level.ruby_wwq.var_ed0b6e3a754977ce = 0;
    
    while ( level.ruby_wwq.b_megalaser_active )
    {
        if ( isalive( level.ruby_wwq.oscar ) )
        {
            if ( distance2dsquared( level.ruby_wwq.oscar.origin, v_megalaser_center ) < 160000 )
            {
                if ( var_e04d9cfdf75617a == 0 )
                {
                    var_e04d9cfdf75617a = 1;
                    zm_quest::function_cd1f2fee4749fb0a( 1, #"ruby_wwq", #"electric_trap_progress" );
                    zm_quest::function_c2af37f835cd840b( 39, 1, #"ruby_wwq", #"electric_trap_progress" );
                }
                else
                {
                    zm_quest::function_9f49b2a045ece8ae( level.ruby_wwq.var_ed0b6e3a754977ce, 1, #"ruby_wwq", #"electric_trap_progress" );
                    level.ruby_wwq.var_ed0b6e3a754977ce += 0.25;
                }
            }
        }
        
        wait 0.25;
    }
}

// Namespace zm_sat_ruby_quest_wwq
// Params 1, eflags: 0x4
// Checksum 0xe8a527ff, Offset: 0x4023
// Size: 0x198
function private function_3839773166e3f987( v_megalaser_center )
{
    level endon( #"game_ended" );
    level endon( #"megalaser_ended" );
    zombie_type = function_b3988325430ce242( "zombie_base" );
    planetarium_spawners = zone_spawner::function_20c574a6ba7cc5c6( [ "zone_planetarium", "zone_planetarium_hallway_01", "zone_planetarium_hallway_03" ], zombie_type );
    
    while ( level.ruby_wwq.b_megalaser_active )
    {
        megalaser_zombies = getaiarrayinradius( v_megalaser_center, 400, "team_two_hundred" );
        
        for ( i = 0; i < int( megalaser_zombies.size / 4 ) ; i++ )
        {
            shocked_zombie = utility::array_random( megalaser_zombies );
            shocked_zombie thread megalaser_shock( 1, 3 );
        }
        
        if ( isalive( level.ruby_wwq.oscar ) )
        {
            var_f229e374c6e20aa2 = getaiarrayinradius( v_megalaser_center, 1000, "team_two_hundred" ) ?? [];
            
            if ( var_f229e374c6e20aa2.size < 6 + level.players.size && arraycontains( var_f229e374c6e20aa2, level.ruby_wwq.oscar ) )
            {
                n_zombies_to_spawn = 6 + level.players.size - var_f229e374c6e20aa2.size;
                
                for ( i = 0; i < minint( n_zombies_to_spawn, level.players.size + 1 ) ; i++ )
                {
                    spawn_quest_zombie( zombie_type, utility::array_random( planetarium_spawners ) );
                }
            }
        }
        
        wait 2;
    }
}

// Namespace zm_sat_ruby_quest_wwq
// Params 2, eflags: 0x4
// Checksum 0x3c90ac44, Offset: 0x41c3
// Size: 0xde
function private megalaser_shock( var_f1acc2b2d9cfea3f, shock_time_max )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    if ( self.subclass != "zombie_galileo" )
    {
        wait randomfloat( 1 );
        
        if ( !isalive( self ) )
        {
            return;
        }
        
        shock_time = randomfloatrange( var_f1acc2b2d9cfea3f, shock_time_max );
        namespace_f4f7019540228268::stun( "deadwire", shock_time, undefined, "shocked_on", undefined, "electrical" );
        var_78a1a9cabfc4d42e = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", zm_round_logic::get_rb_round_number() );
        effect_wound::function_da75b75f8002aa71( shock_time, shock_time, 0, 0, var_78a1a9cabfc4d42e * 0.04, 0.5 );
        utility::function_7c10ea82c1e305b8( "shocked", "shocked_on" );
        wait shock_time;
        
        if ( isalive( self ) )
        {
            utility::function_7c10ea82c1e305b8( "shocked", "shocked_off" );
        }
    }
}

// Namespace zm_sat_ruby_quest_wwq
// Params 1, eflags: 0x4
// Checksum 0x74667fe0, Offset: 0x42a9
// Size: 0xb8
function private reactivate_megalaser_trap( params )
{
    /#
        iprintlnbold( "<dev string:x1c0>" );
    #/
    
    level.ruby_wwq.laser_cooldown = 0;
    level.ruby_wwq.megalaser_interact function_e203bba36cfb19d0();
    level.var_f301c0b95ea728e2[ 1 ].a_switch_pos[ 0 ].switch_scriptable setscriptablepartstate( "base", "ready" );
    stopfxontag( utility::getfx( "cooldown_smoke" ), level.ruby_wwq.var_2c9ab4e8cbdf0a24, "tag_origin" );
    function_af37f1cf8a3e9a22();
    level callback::remove( "on_round_start", &reactivate_megalaser_trap );
}

// Namespace zm_sat_ruby_quest_wwq
// Params 2, eflags: 0x4
// Checksum 0x4307ee0c, Offset: 0x4369
// Size: 0x144
function private function_ad3ef189af8b4373( b_skipped, b_save_restored )
{
    level callback::remove( "on_round_start", &reactivate_megalaser_trap );
    traps::function_477b6dafe486c6b0( "laser_trap_switch", 0 );
    level.ruby_wwq.var_e5c94f867b9ccfd3++;
    level thread zm_quest::update_round_cap( 7 + level.ruby_wwq.var_e5c94f867b9ccfd3 * 2 );
    
    if ( isdefined( level.ruby_wwq.var_2c9ab4e8cbdf0a24 ) )
    {
        level.ruby_wwq.var_2c9ab4e8cbdf0a24 delete();
    }
    
    if ( isdefined( level.ruby_wwq.megalaser_battery ) )
    {
        level.ruby_wwq.megalaser_battery delete();
    }
    
    if ( isdefined( level.ruby_wwq.megalaser_drone ) )
    {
        level.ruby_wwq.megalaser_drone delete();
    }
    
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "wwq_step_7_complete" );
        
        if ( isdefined( level.ruby_wwq.var_4864846e68915351 ) )
        {
            level.ruby_wwq.var_4864846e68915351 freescriptable();
        }
        
        function_af37f1cf8a3e9a22();
    }
}

// Namespace zm_sat_ruby_quest_wwq
// Params 0, eflags: 0x4
// Checksum 0x4f3133a6, Offset: 0x44b5
// Size: 0x5c
function private ruby_wwq_complete_monitor()
{
    level endon( #"game_ended" );
    utility::flag_wait_all( "wwq_step_2_complete", "wwq_step_3_complete", "wwq_step_7_complete" );
    magicbox::function_2e49cd8681e36211( 0 );
    
    if ( !isdefined( level.ruby_wwq.oscar ) )
    {
        utility::flag_set( "ruby_wwq_complete" );
        utility::flag_set( "wwq_oscar_gone" );
    }
}

// Namespace zm_sat_ruby_quest_wwq
// Params 1, eflags: 0x4
// Checksum 0x939da228, Offset: 0x4519
// Size: 0x1aa
function private function_612d2be546d16155( params )
{
    if ( self.subclass === "zombie_galileo" )
    {
        if ( utility::flag( "wwq_step_2_complete" ) )
        {
            self.aisettings.var_652102b804cce911 = 0;
            self.var_471cead65a38b788 = 1;
        }
        
        if ( utility::flag( "wwq_step_3_complete" ) )
        {
            self.aisettings.var_3dae55586fee0a61 = 0;
        }
        
        if ( utility::flag( "wwq_step_7_complete" ) )
        {
            self.aisettings.var_b11b8458c44f3024 = 0;
            self.var_91eefe62b94cf0c6 = 1;
        }
        
        if ( self.spawn_source != "zm_cleanup" )
        {
            ai::set_ai_max_health( int( self.maxhealth * ( 2 + 0.5 * level.ruby_wwq.var_e5c94f867b9ccfd3 ) ) );
            self.health = self.maxhealth;
        }
        
        if ( isdefined( level.ruby_wwq.var_42965453ccff4b8 ) )
        {
            switch ( level.ruby_wwq.var_42965453ccff4b8 )
            {
                case #"hash_b107a5547c7543f3":
                    dialogue::say( "dx_zm_ruwn_rbyw_gali_rw1hbr", 1 );
                    break;
                case #"hash_47276d6c2f4cfd60":
                    dialogue::say( "dx_zm_ruwn_rbyw_gali_rw2rrtn", 1 );
                    break;
                case #"hash_7590cd03ed93bd30":
                    dialogue::say( "dx_zm_ruwn_rbyw_gali_rw3ptr", 1 );
                    break;
            }
            
            level.ruby_wwq.var_42965453ccff4b8 = undefined;
        }
        
        level.ruby_wwq.oscar = self;
        function_af37f1cf8a3e9a22();
    }
}

// Namespace zm_sat_ruby_quest_wwq
// Params 1, eflags: 0x4
// Checksum 0x4595782f, Offset: 0x46cb
// Size: 0x25
function private function_f12fd00a1031d504( params )
{
    if ( self.subclass === "zombie_galileo" )
    {
        function_af37f1cf8a3e9a22();
    }
}

// Namespace zm_sat_ruby_quest_wwq
// Params 1, eflags: 0x4
// Checksum 0x4441bc21, Offset: 0x46f8
// Size: 0x2db
function private function_2dfdc65b0a07a785( n_damage_source )
{
    zm_quest::clear_all_guidance();
    level.ruby_wwq.oscar zm_sat_ruby_galileo::function_b7fa26641ae94e30();
    level thread zm_utility::function_1d82e63812f9640a( self.origin, 600, 1, "heavy_1s", 0.3, 600, "heavy_1s", 0.3 );
    thread function_bf33cb5a241f324f( n_damage_source );
    var_6704836566a2e713 = 6;
    
    if ( utility::flag( "wwq_step_2_complete" ) && utility::flag( "wwq_step_3_complete" ) && utility::flag( "wwq_step_7_complete" ) )
    {
        oscar_dead = 1;
        var_6704836566a2e713 += 10;
    }
    
    foreach ( player in level.players )
    {
        player thread function_c473ef2ca3032767( 0.3, 1 );
        
        if ( distance2d( self.origin, player.origin ) < 400 )
        {
            player thread function_677fe9c5c769777b( var_6704836566a2e713 );
        }
    }
    
    if ( oscar_dead )
    {
        self.var_b2712afddb13f3a4 = 2;
        level callback::remove( "on_zombie_ai_spawned", &function_612d2be546d16155 );
        level callback::remove( "on_zombie_ai_killed", &function_f12fd00a1031d504 );
        wait 3;
        self function_68f2f6fd8a4ffcae( 0, 2 );
        spawn_ruby_ww( self.origin );
        wait 1;
        function_af37f1cf8a3e9a22();
        wait 30;
        level utility::flag_set( "wwq_oscar_gone" );
    }
    else
    {
        level.ruby_wwq.var_42965453ccff4b8 = n_damage_source;
        var_4bf237523633a0de = getaiarrayinradius( self.origin, 100 );
        
        foreach ( oscar_friend in var_4bf237523633a0de )
        {
            if ( oscar_friend.subclass == "zombie_galileo_drone" )
            {
                oscar_friend.killed_by_trap = 1;
                oscar_friend kill();
            }
        }
        
        self.var_b2712afddb13f3a4 = 1;
        wait 1.5;
    }
    
    level callback::callback( "oscar_trap_success", { #oscar:self } );
    zm_sat_ruby_galileo::function_84919f8f8db67077( utility::getstruct( "oscar_retreat", "targetname" ).origin, 1 );
    wait 2;
    self kill();
}

// Namespace zm_sat_ruby_quest_wwq
// Params 1, eflags: 0x4
// Checksum 0xc0841b10, Offset: 0x49db
// Size: 0x2e
function private function_677fe9c5c769777b( flee_time )
{
    val::set( "oscar_flee", "ignoreme", 1 );
    wait flee_time;
    val::reset_all( "oscar_flee" );
}

// Namespace zm_sat_ruby_quest_wwq
// Params 1, eflags: 0x4
// Checksum 0xe39527f0, Offset: 0x4a11
// Size: 0xd9
function private function_bf33cb5a241f324f( n_damage_source )
{
    level endon( #"game_ended" );
    players_near_oscar = getplayersinradius( self.origin, 700 );
    
    if ( players_near_oscar.size > 0 )
    {
        vo_player = utility::array_random( players_near_oscar );
        wait 3;
        
        switch ( n_damage_source )
        {
            case #"hash_b107a5547c7543f3":
                vo_player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_e01cc1b6aae17f22", #"bc_flavor_player_positive" );
                break;
            case #"hash_47276d6c2f4cfd60":
                vo_player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_3acb0a8af13d633b", #"bc_flavor_player_positive" );
                break;
            case #"hash_7590cd03ed93bd30":
                vo_player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_b7ba4bd5f9a614bb", #"bc_flavor_player_positive" );
                break;
        }
    }
}

// Namespace zm_sat_ruby_quest_wwq
// Params 1, eflags: 0x4
// Checksum 0xa5601914, Offset: 0x4af2
// Size: 0xff
function private spawn_ruby_ww( location )
{
    s_weapon_spawn = getscriptbundle( "itemspawnentry:zm_sat_item_weapon_ww_ruby" );
    spawnoptions = common_item::function_f5dfaa3bbdf99a33( getclosestpointonnavmesh( location + anglestoforward( level.ruby_wwq.oscar.angles ) * 50 ), location + ( 0, 0, 38 ) );
    spawnoptions.var_fd47e835523b473f = 1;
    spawnoptions.critical = 1;
    level.ruby_wwq.var_dbd81ae37963526a = item_weapon::function_b960bc85ea91de14( s_weapon_spawn, spawnoptions );
    level zombie_shade_loot_consume::function_2c1c775b372991b0( 0, undefined, undefined, undefined, [ level.ruby_wwq.var_dbd81ae37963526a ] );
    level.ruby_wwq.var_dbd81ae37963526a.from_ww_quest = 1;
    level callback::add( #"item_weapon_picked_up", &function_424373572bd861ac );
}

// Namespace zm_sat_ruby_quest_wwq
// Params 1, eflags: 0x4
// Checksum 0x7f5a1627, Offset: 0x4bf9
// Size: 0x13b
function private function_424373572bd861ac( params )
{
    if ( issubstr( params.item.customweaponname, "ww_ruby" ) && params.loot_source != "magicbox" )
    {
        level callback::remove( #"item_weapon_picked_up", &function_424373572bd861ac );
        utility::flag_set( "ruby_wwq_complete" );
        
        foreach ( player in level.players )
        {
            player utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_ruby_artifact_2" );
        }
        
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            zm_quest::function_fb3af5600f6a9441( 4, 1, #"ruby_wwq_guidance", #"grab_ww" );
            zm_quest::function_5b5c737326035ea( 0 );
        }
        
        namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"ruby_wwq_pick_up_ww", #"bc_flavor_player_positive" );
    }
}

// Namespace zm_sat_ruby_quest_wwq
// Params 4, eflags: 0x4
// Checksum 0x1e5f600c, Offset: 0x4d3c
// Size: 0xbd
function private function_d3fce780a8c0a776( item, spawn_pos, end_pos, despawn_callback )
{
    waitframe();
    
    if ( isdefined( end_pos ) )
    {
        spawnoptions = common_item::function_f5dfaa3bbdf99a33( end_pos, spawn_pos );
    }
    else
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( spawn_pos, ( 0, 200, 0 ) );
    }
    
    spawnoptions.var_fd47e835523b473f = 1;
    spawnoptions.critical = 1;
    spawned_item = common_item::items_spawnitemfromscriptable( item, 1, spawnoptions );
    level.ruby_wwq.items[ item ] = spawned_item;
    
    if ( isdefined( despawn_callback ) )
    {
        wait 300;
        
        if ( isdefined( spawned_item ) )
        {
            spawned_item thread [[ despawn_callback ]]();
        }
    }
}

// Namespace zm_sat_ruby_quest_wwq
// Params 1, eflags: 0x4
// Checksum 0xa06ffef5, Offset: 0x4e01
// Size: 0x3b8
function private function_f50c14c277e59d6e( params )
{
    switch ( params.bundle.scriptable )
    {
        case %"ruby_wwq_abs_zero_fragment_scriptable":
            level.ruby_wwq.var_82d0405caaf0f78f++;
            zm_quest::function_b57dfe9625966b0b( #"ruby_ww", 0, #"ice_fragment", level.ruby_wwq.var_82d0405caaf0f78f );
            zm_quest::show_splash_item_picked_up( #"ruby_ww", #"ice_fragment", level.ruby_wwq.var_82d0405caaf0f78f, params.player );
            zm_quest::function_4eefe6de31f5ddab( #"ruby_wwq", #"ice_fragment", level.ruby_wwq.var_82d0405caaf0f78f );
            
            if ( level.ruby_wwq.var_82d0405caaf0f78f == 1 )
            {
                level thread battlechatter_mp::trysaylocalsound( params.player, #"hash_5212ed7ec42f115a" );
            }
            
            if ( zm_quest::function_b0a5181ebe7bb905() )
            {
                level zm_quest::function_9f49b2a045ece8ae( level.ruby_wwq.var_82d0405caaf0f78f, 1, #"ruby_wwq_guidance", #"ice_1" );
            }
            
            if ( level.ruby_wwq.var_82d0405caaf0f78f >= 3 )
            {
                function_af37f1cf8a3e9a22();
            }
            
            break;
        case %"ruby_wwq_wiring_scriptable":
            zm_quest::function_b57dfe9625966b0b( #"ruby_ww", 0, #"wiring", 1 );
            zm_quest::show_splash_item_picked_up( #"ruby_ww", #"wiring", 1, params.player );
            zm_quest::function_4eefe6de31f5ddab( #"ruby_wwq", #"wiring", 1 );
            level thread battlechatter_mp::trysaylocalsound( params.player, #"bc_flavor_player_positive" );
            level utility::flag_set( "wwq_step_4_complete" );
            break;
        case %"ruby_wwq_battery_scriptable":
            zm_quest::function_b57dfe9625966b0b( #"ruby_ww", 0, #"battery", 1 );
            zm_quest::show_splash_item_picked_up( #"ruby_ww", #"battery", 1, params.player );
            zm_quest::function_4eefe6de31f5ddab( #"ruby_wwq", #"battery", 1 );
            level thread battlechatter_mp::trysaylocalsound( params.player, #"bc_flavor_player_positive" );
            level utility::flag_set( "wwq_step_5_complete" );
            break;
        case %"ruby_wwq_drone_scriptable":
            zm_quest::function_b57dfe9625966b0b( #"ruby_ww", 0, #"drone", 1 );
            zm_quest::show_splash_item_picked_up( #"ruby_ww", #"drone", 1, params.player );
            zm_quest::function_4eefe6de31f5ddab( #"ruby_wwq", #"drone", 1 );
            level thread battlechatter_mp::trysaylocalsound( params.player, #"hash_5212ed7ec42f115a" );
            level utility::flag_set( "wwq_step_6_complete" );
            
            foreach ( player in level.players )
            {
                player utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_ruby_artifact_1" );
            }
            
            break;
    }
}

// Namespace zm_sat_ruby_quest_wwq
// Params 3, eflags: 0x4
// Checksum 0x912ce54a, Offset: 0x51c1
// Size: 0x1d0
function private spawn_quest_zombie( zombie_type, s_spawn, n_difficulty_round )
{
    zombie = agent_manager::spawn_agent( zombie_type, s_spawn.origin, s_spawn.angles, "team_two_hundred" );
    
    if ( !isdefined( n_difficulty_round ) )
    {
        n_difficulty_round = zm_round_logic::get_rb_round_number();
    }
    
    if ( isdefined( zombie ) )
    {
        zombie utility::function_7c10ea82c1e305b8( "base", "base_purple_eyes" );
        zombie.no_powerups = 1;
        zombie zombie_utils::set_zombie_round_difficulty( n_difficulty_round );
        zombie.b_cleanup_no_respawn = 1;
        zombie.var_825b17c932865df = 1;
        zombie.var_15598d8e493afe88 = 1;
        zombie.ignore_enemy_count = 1;
        zombie.b_disable_annihilate = 1;
        zombie.var_5a9c952260ab1cf = 1;
        zombie.var_f7fb30c6fe83c8e3 = 1;
        zombie.kiastring = #"zombie_kia_mission_kill";
        zombie thread agent_spawner::function_ce10e453e7f7bb8e( s_spawn );
        zombie zombie_utils::function_a8ce00e0448cb6f0( level.gametypebundle.var_25934546ad2751f3 && level.gametypebundle.var_ed84de94958fe6c0 && ( "sprint" == "super_sprint" || "sprint" == "sprint" ) ? "run" : level.gametypebundle.var_25934546ad2751f3 && "sprint" == "super_sprint" ? "sprint" : level.gametypebundle.var_ed84de94958fe6c0 && "sprint" == "sprint" ? "run" : "sprint", "default", 6 );
    }
    
    return zombie;
}

// Namespace zm_sat_ruby_quest_wwq
// Params 3, eflags: 0x4
// Checksum 0x9d4084b5, Offset: 0x539a
// Size: 0x3e
function private function_c473ef2ca3032767( fade_out_time, fade_in_time, var_280fc6a5f41ac78 = "white" )
{
    hud_util::fade_out( fade_out_time, var_280fc6a5f41ac78 );
    hud_util::fade_in( fade_in_time, var_280fc6a5f41ac78 );
}

/#

    // Namespace zm_sat_ruby_quest_wwq
    // Params 0, eflags: 0x4
    // Checksum 0xf7b2b0bb, Offset: 0x53e0
    // Size: 0x78, Type: dev
    function private function_433c32532761fa5e()
    {
        devgui::function_9082edeb5db93280( "<dev string:x1d8>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1f1>", "<dev string:x203>", &function_3823514641479f54, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x215>", "<dev string:x222>", &function_afbcbbe64f27d141, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x22c>", "<dev string:x23d>", &function_3f17c54f52b4a36c, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x248>", "<dev string:x25a>", &function_cff5403e4f690114, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_ruby_quest_wwq
    // Params 1, eflags: 0x4
    // Checksum 0x63bdd3a4, Offset: 0x5460
    // Size: 0x79, Type: dev
    function private function_3823514641479f54( params )
    {
        level.ruby_wwq.var_e8979f64de7b469a = 3;
        level.ruby_wwq.var_82d0405caaf0f78f = 3;
        zm_quest::function_b57dfe9625966b0b( #"ruby_ww", 0, #"ice_fragment", 3 );
        zm_quest::function_4eefe6de31f5ddab( #"ruby_wwq", #"ice_fragment", 3 );
        function_af37f1cf8a3e9a22();
    }

    // Namespace zm_sat_ruby_quest_wwq
    // Params 1, eflags: 0x4
    // Checksum 0xfb2ffd24, Offset: 0x54e1
    // Size: 0x4e, Type: dev
    function private function_afbcbbe64f27d141( params )
    {
        warp_pos = getclosestpointonnavmesh( level.ruby_wwq.aberrant_lamp.origin );
        level.players[ 0 ] setorigin( warp_pos );
    }

    // Namespace zm_sat_ruby_quest_wwq
    // Params 1, eflags: 0x4
    // Checksum 0x3df3ce26, Offset: 0x5537
    // Size: 0x6c, Type: dev
    function private function_3f17c54f52b4a36c( params )
    {
        if ( isalive( level.ruby_wwq.oscar ) )
        {
            level.ruby_wwq.oscar.origin = level.players[ 0 ].origin;
            return;
        }
        
        /#
            iprintln( "<dev string:x26c>" );
        #/
    }

    // Namespace zm_sat_ruby_quest_wwq
    // Params 1, eflags: 0x4
    // Checksum 0x74840060, Offset: 0x55ab
    // Size: 0xac, Type: dev
    function private function_cff5403e4f690114( params )
    {
        foreach ( step in level.ruby_wwq.steps )
        {
            level zm_quest::function_e65609834444650c( step, 0 );
        }
        
        utility::flag_set( "<dev string:x288>" );
        utility::flag_set( "<dev string:x29a>" );
    }

#/
