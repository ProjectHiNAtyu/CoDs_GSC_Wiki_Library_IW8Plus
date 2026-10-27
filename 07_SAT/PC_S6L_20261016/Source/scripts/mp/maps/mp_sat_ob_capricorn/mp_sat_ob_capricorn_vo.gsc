// scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_vo.gsc  (hash_0b15152321286ea3.gscc) (size: 19651 Bytes / 0x4cc3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe4577df1 (3830939121)
// size ...... 19651 (0x4cc3)
// includes .. 3   (offset: 0x427f)
// strings ... 198 (offset: 0x4297)
// dev strs .. 0   (offset: 0x4cc3)
// exports ... 61  (offset: 0x2ec7)
// cseg ...... 0x162d + 0x189a (0x2ec7)
// imports ... 62  (offset: 0x384f)
// animtree1 . 0   (offset: 0x4cc3)
// animtree2 . 0   (offset: 0x4cc3)
#using scripts\common\utility;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_audio;
#using scripts\mp\overlord;

#namespace mp_sat_ob_capricorn_vo;

/#

    // Namespace mp_sat_ob_capricorn_vo
    // Params 0
    // Checksum 0xa486fe0f, Offset: 0x164b
    // Size: 0x5, Type: dev
    function function_becc256d8063b1e4()
    {
        
    }

#/

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0xe0e4d282, Offset: 0x1658
// Size: 0x96
function function_54aedada81a53a9e()
{
    level notify( #"hash_579fd1702d3a0678" );
    level endon( #"hash_579fd1702d3a0678" );
    level endon( #"hijack_stealth_lost" );
    wait 0.5;
    thread function_78d79145eed25e6e();
    
    if ( !utility::flag( "flag_hijacked_upper_vo_setup" ) )
    {
        thread function_74baa68ac6330f31();
        overlord::playconversation( "long_meeting" );
        level thread utility::flag_set_delayed( "active_camo_vo_done", 1.5 );
        overlord::playconversation( "active_camo" );
        level utility::flag_set( "flag_hijacked_upper_vo_setup" );
    }
    
    if ( !utility::flag( "hijack_vo_stealth_regained_done" ) )
    {
        childthread function_7c9bfa0c3c06bb84();
    }
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0x8bf9a271, Offset: 0x16f6
// Size: 0x51
function function_74baa68ac6330f31()
{
    level endon( #"hash_f5e61985274d6283" );
    level utility::flag_wait( "flag_vo_hijacked_office_location" );
    thread function_4fe800b160fb526d();
    
    if ( level.var_3d9fc7aa7b25b565.currently_stealthy )
    {
        overlord::playconversation( "office_lower_level" );
        level utility::flag_set( "office_lower_level_vo_done" );
    }
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0xc5ee2c46, Offset: 0x174f
// Size: 0x8e
function function_4fe800b160fb526d()
{
    level endon( #"hash_f5e61985274d6283" );
    level utility::flag_wait( "office_lower_level_vo_done" );
    level utility::flag_clear( "flag_vo_hijacked_hatch_callout" );
    level utility::flag_wait( "flag_vo_hijacked_hatch_callout" );
    
    if ( utility::flag( "flag_hijack_deck_cleared" ) || level.var_3d9fc7aa7b25b565.currently_stealthy )
    {
        overlord::function_be2d6dc71f97faa6( "access_hatch_here" );
        return;
    }
    
    overlord::function_be2d6dc71f97faa6( "access_hatch_here_detected" );
    level utility::flag_wait( "flag_hijack_hatch_used" );
    overlord::function_be2d6dc71f97faa6( "access_hatch_here" );
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0xcc10bfdf, Offset: 0x17e5
// Size: 0x43
function function_1c1517482ac28436()
{
    level notify( #"hash_579fd1702d3a0678" );
    level endon( #"hash_579fd1702d3a0678" );
    level endon( #"hijack_stealth_lost" );
    thread function_78d79145eed25e6e();
    
    if ( utility::flag( "hijack_vo_stealth_regained_done" ) )
    {
        return;
    }
    
    childthread function_7c9bfa0c3c06bb84();
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0x570546f4, Offset: 0x1830
// Size: 0x74
function function_7c9bfa0c3c06bb84()
{
    level endon( #"hash_f5e61985274d6283" );
    level endon( #"hijack_stealth_lost" );
    
    if ( !utility::flag( "vo_stealth_agents_eliminated" ) )
    {
        level utility::flag_wait( "vo_stealth_agents_eliminated" );
        postfix = level.var_3d9fc7aa7b25b565.currently_stealthy ? "" : "_detected";
        overlord::playconversation( "clear_upper_deck" + postfix );
    }
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0x19f4ef60, Offset: 0x18ac
// Size: 0x91
function function_78d79145eed25e6e()
{
    level endon( #"hash_579fd1702d3a0678" );
    
    while ( true )
    {
        level waittill( #"hijack_stealth_lost", var_ea57a162fa2807a );
        
        if ( var_ea57a162fa2807a )
        {
            overlord::playconversation( "so_much_for_low_profile" );
        }
        
        level utility::flag_wait( "flag_hijack_deck_cleared" );
        
        if ( !utility::flag( "office_lower_level_vo_done" ) )
        {
            overlord::playconversation( "stealth_regained_marking_hatch" );
            level utility::flag_set( "office_lower_level_vo_done" );
        }
        else
        {
            overlord::playconversation( "stealth_regained" );
        }
        
        level utility::flag_set( "hijack_vo_stealth_regained_done" );
    }
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0xbb8152bd, Offset: 0x1945
// Size: 0xe
function function_77e90a7ddc10cee5()
{
    overlord::playconversation( "enemies_investigating" );
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0xb8356b75, Offset: 0x195b
// Size: 0xea
function function_ed3ccaf93d404bfd()
{
    level notify( #"hash_579fd1702d3a0678" );
    level endon( #"hash_579fd1702d3a0678" );
    childthread function_87b190fd803c934f();
    level utility::flag_wait( "flag_vo_hijacked_below_deck_callout" );
    level notify( #"hash_f5e61985274d6283" );
    postfix = level.var_3d9fc7aa7b25b565.currently_stealthy ? "" : "_detected";
    overlord::playconversation( "contact_below" + postfix );
    
    if ( postfix == "_detected" )
    {
        level utility::flag_wait( "flag_vo_lower_deck_enemies" );
        overlord::function_be2d6dc71f97faa6( "guild_below_watch_your_corners" );
    }
    
    level utility::flag_set( "flag_vo_hijacked_below_deck_callout_done" );
    level utility::flag_wait( "flag_vo_hijacked_office_callout" );
    postfix = level.var_3d9fc7aa7b25b565.currently_stealthy ? "" : "_detected";
    overlord::playconversation( "he_must_hear_us" + postfix );
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0, eflags: 0x4
// Checksum 0xb6b815dc, Offset: 0x1a4d
// Size: 0x4d
function private function_87b190fd803c934f()
{
    while ( true )
    {
        level waittill( #"hijack_stealth_lost", var_ea57a162fa2807a );
        
        if ( var_ea57a162fa2807a )
        {
            overlord::playconversation( "so_much_for_low_profile" );
        }
        
        level waittill( #"hijack_vo_stealth_regained" );
        overlord::playconversation( "stealth_regained" );
    }
}

// Namespace mp_sat_ob_capricorn_vo
// Params 2
// Checksum 0xbfe94361, Offset: 0x1aa2
// Size: 0x103
function function_7a1349e4446a1b89( agent, eattacker )
{
    if ( level.var_3d9fc7aa7b25b565.var_ca4d33c68cd82653 && level.var_3d9fc7aa7b25b565.var_ca4d33c68cd82653 + 15000 > gettime() )
    {
        return;
    }
    
    var_6838d5e3827188e6 = "stealth_kill_reaction_";
    
    for ( var_f7d7f31b0d92ec76 = randomintrange( 1, 9 ); var_f7d7f31b0d92ec76 == level.var_3d9fc7aa7b25b565.var_493a1fde4406ea4e ; var_f7d7f31b0d92ec76 = randomintrange( 1, 9 ) )
    {
    }
    
    wait 0.8;
    
    if ( !level.var_3d9fc7aa7b25b565.currently_stealthy )
    {
        return;
    }
    
    if ( overlord::function_dce0a14273dfa0a8( level.players ) )
    {
        return;
    }
    
    level.var_3d9fc7aa7b25b565.var_493a1fde4406ea4e = var_f7d7f31b0d92ec76;
    level.var_3d9fc7aa7b25b565.var_ca4d33c68cd82653 = gettime();
    overlord::function_be2d6dc71f97faa6( "stealth_kill_reaction_" + var_f7d7f31b0d92ec76 );
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0x54e85bd0, Offset: 0x1bad
// Size: 0x26
function function_4e424ef6fb2890c9()
{
    level notify( #"hash_579fd1702d3a0678" );
    level endon( #"hash_579fd1702d3a0678" );
    overlord::playconversation( "plan_c" );
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0x56f6e406, Offset: 0x1bdb
// Size: 0x45
function function_70b337000fbf32e4()
{
    level notify( #"hash_579fd1702d3a0678" );
    level endon( #"hash_579fd1702d3a0678" );
    overlord::playconversation( "trying_to_sink_us" );
    level notify( #"trying_to_sink_us_done" );
    thread function_fa23253124ecf126();
    overlord::playconversation( "vtol_missile_barrage" );
}

/#

    // Namespace mp_sat_ob_capricorn_vo
    // Params 0
    // Checksum 0x9620a612, Offset: 0x1c28
    // Size: 0x5, Type: dev
    function function_30e75f7924f1d947()
    {
        
    }

#/

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0x785e3944, Offset: 0x1c35
// Size: 0x1e
function function_fa23253124ecf126()
{
    level waittill( #"hash_579fd1702d3a0678" );
    wait 2;
    overlord::playconversation( "well_it_was_effective" );
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0xaeeb1a7f, Offset: 0x1c5b
// Size: 0x3a
function function_b7b1f84516c76aba()
{
    level notify( #"hash_579fd1702d3a0678" );
    level endon( #"hash_579fd1702d3a0678" );
    level utility::flag_wait( "flag_vo_forge_hostiles_callout" );
    overlord::function_be2d6dc71f97faa6( "hostiles_below" );
    thread function_3b9361c3d6ba1cf5();
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0x95b4bbcf, Offset: 0x1c9d
// Size: 0x38
function function_3b9361c3d6ba1cf5()
{
    level endon( #"hash_76b4e9772fd8b453" );
    level utility::flag_wait_all( "forge_infiltrate_encounter_completed", "encounter_forge_arena_ambient_completed" );
    level notify( #"hash_df21172b42d83eed" );
    overlord::playconversation( "if_karma_could_hack" );
}

// Namespace mp_sat_ob_capricorn_vo
// Params 1
// Checksum 0x803ed057, Offset: 0x1cdd
// Size: 0x10a
function function_65f98bae67c258f8( var_f2bb8a544f0bad81 )
{
    level endon( #"hash_df21172b42d83eed" );
    level utility::flag_wait( "flag_vo_forge_infiltrate_bots_activating" );
    overlord::function_be2d6dc71f97faa6( "forge_blackhat_hint", undefined, 1.5 );
    wait 1;
    
    if ( gettime() < var_f2bb8a544f0bad81 + 10000 )
    {
        foreach ( player in level.players )
        {
            player utility::callsharedfunc( #"hint", #"close", "hint_active_roll", 1 );
        }
    }
    
    wait 0.5;
    level notify( #"vo_forge_blackhat_hint" );
    level utility::flag_wait_or_timeout( "flag_vo_forge_infiltrate_reinforcements", 8.5 );
    overlord::playconversation( "testing_area_enemies" );
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0x9e440167, Offset: 0x1def
// Size: 0x16f
function function_9b983e53f389b1d2()
{
    level notify( #"hash_579fd1702d3a0678" );
    level endon( #"hash_579fd1702d3a0678" );
    level utility::flag_wait( "flag_elevator_first_interact" );
    level notify( #"hash_76b4e9772fd8b453" );
    capricorn_audio::function_9e5691439028c657();
    wait 2.25;
    overlord::playconversation( "elevators_locked_down" );
    level utility::flag_set( "flag_elevator_lockdown_vo_finished" );
    thread function_1967bfebc076cebd();
    level utility::flag_wait( "flag_vo_forge_elevator_reinforcement" );
    overlord::function_be2d6dc71f97faa6( "forge_ambush_1_start", undefined, 0.2 );
    level utility::flag_wait( "flag_vo_forge_before_security_room" );
    overlord::playconversation( "security_room_enemies" );
    wait 1;
    level utility::flag_wait_any( "flag_vo_forge_security_clear_enemies", "forge_encounter_showroom_completed" );
    
    if ( !utility::flag( "forge_encounter_showroom_completed" ) )
    {
        overlord::function_be2d6dc71f97faa6( "clear_the_room_of_hostiles" );
        level utility::flag_wait( "forge_encounter_showroom_completed" );
    }
    
    if ( !utility::flag( "flag_forge_computer_room_unlocked" ) )
    {
        overlord::function_be2d6dc71f97faa6( "get_that_door_open" );
    }
    
    if ( !utility::flag( "flag_vo_hacking_started" ) )
    {
        level utility::flag_wait( "flag_forge_computer_room_unlocked" );
        overlord::playconversation( "security_room_terminal" );
    }
    
    if ( !utility::flag( "flag_vo_hacking_started" ) )
    {
        nags = [ "nag_hack_terminal" ];
        childthread function_e912963a5aaf5005( nags, "forge_security_computer_activated", 60, 60 );
    }
    
    thread function_3a7ce40fb526664f();
    level utility::flag_wait( "flag_vo_hacking_started" );
    overlord::playconversation( "hack_start" );
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0x2810b2c9, Offset: 0x1f66
// Size: 0x71
function function_1967bfebc076cebd()
{
    level endon( #"hash_af5e7ccf327edd3a" );
    level utility::flag_wait( "flag_vo_forge_first_forcefield" );
    triggers = getnoentvolumearray( "trigger_forge_disable_ff_vo", #targetname );
    
    if ( triggers[ 0 ] )
    {
        triggers[ 0 ] waittill( #"trigger", player );
        overlord::function_be2d6dc71f97faa6( "plasma_field_2" );
        level utility::flag_set( "flag_forge_plasma_field_1_vo_done" );
    }
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0x3ac6935e, Offset: 0x1fdf
// Size: 0x28
function function_3a7ce40fb526664f()
{
    level waittill( #"hash_579fd1702d3a0678" );
    level utility::flag_wait( "flag_3rd_computer_completed" );
    thread overlord::playconversation( "lockdown_lifted" );
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0x99af4807, Offset: 0x200f
// Size: 0x5f
function function_28b4b60636d0796f()
{
    level notify( #"hash_579fd1702d3a0678" );
    level endon( #"hash_579fd1702d3a0678" );
    level utility::flag_wait( "forge_turret_intro" );
    childthread function_8c0950b3582ab9c7();
    childthread function_778e51980da8cb4a();
    childthread function_9284ca6c0faab41e();
    capricorn_audio::function_43582e4ab39b18d9();
    wait 2;
    overlord::playconversation( "turret_boss_activated" );
    level utility::flag_set( "vo_turret_intro_done" );
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0xfd97f60e, Offset: 0x2076
// Size: 0xf7
function function_743fe0fa381b8be4()
{
    level notify( #"hash_579fd1702d3a0678" );
    level endon( #"hash_579fd1702d3a0678" );
    level utility::flag_wait_any( "flag_forge_turret_destroyed", "forge_elevator_vo_going_down" );
    
    if ( !utility::flag( "forge_elevator_vo_going_down" ) )
    {
        overlord::playconversation( "turret_boss_defeated" );
    }
    
    level utility::flag_wait( "forge_elevator_vo_going_down" );
    overlord::playconversation( "heading_down" );
    level utility::flag_wait( "forge_ambush_2_start" );
    overlord::playconversation( "forge_ambush_2_start" );
    level utility::flag_wait_any( "flag_vo_forge_elevator_clear_enemies", "forge_elevator_encounter_completed" );
    
    if ( !utility::flag( "forge_elevator_encounter_completed" ) )
    {
        overlord::function_be2d6dc71f97faa6( "take_em_down" );
        level utility::flag_wait( "forge_elevator_encounter_completed" );
    }
    
    overlord::function_be2d6dc71f97faa6( "forge_ambush_2_clear" );
    thread function_5af03e0e432dd98c();
    nags = [ "nag_elevator_forge_1", "nag_elevator_forge_2" ];
    thread function_e912963a5aaf5005( nags, "flag_forge_elevator_interact_done", 60, 60 );
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0xcfa8c1f6, Offset: 0x2175
// Size: 0x37
function function_778e51980da8cb4a()
{
    level endon( #"hash_98cc0511f21cc2e" );
    level utility::flag_wait( "vo_turret_intro_done" );
    wait 10;
    overlord::playconversation( "weve_gotta_drop_the_field" );
    level utility::flag_set( "vo_turret_shield_hint_done" );
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0x7b2a9c9a, Offset: 0x21b4
// Size: 0x69
function function_8c0950b3582ab9c7()
{
    phase_number = 0;
    
    while ( phase_number < 3 )
    {
        level utility::flag_wait( "flag_vo_forge_turret_shield_down" );
        
        if ( phase_number == 0 )
        {
            level notify( #"hash_98cc0511f21cc2e" );
        }
        
        phase_number += 1;
        overlord::function_be2d6dc71f97faa6( "turret_boss_shield_down" );
        overlord::function_be2d6dc71f97faa6( "turret_boss_vulnerable_" + phase_number );
        level utility::flag_clear( "flag_vo_forge_turret_shield_down" );
    }
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0xd71df87a, Offset: 0x2225
// Size: 0x4a
function function_9284ca6c0faab41e()
{
    first_time_shield_up = 1;
    
    while ( true )
    {
        level utility::flag_wait( "flag_vo_forge_turret_shield_up" );
        
        if ( !first_time_shield_up )
        {
            overlord::function_be2d6dc71f97faa6( "turret_boss_shield_up" );
        }
        else
        {
            first_time_shield_up = 0;
        }
        
        level utility::flag_clear( "flag_vo_forge_turret_shield_up" );
    }
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0xdddf4d28, Offset: 0x2277
// Size: 0x27
function function_a0e90de16ea81efb()
{
    level endon( #"hash_942bc6ae535ab0c4" );
    level utility::flag_wait( "flag_vo_forge_shipping_clear_enemies" );
    overlord::function_be2d6dc71f97faa6( "clear_out_this_room" );
}

/#

    // Namespace mp_sat_ob_capricorn_vo
    // Params 0
    // Checksum 0x580ca99a, Offset: 0x22a6
    // Size: 0x5, Type: dev
    function function_96b62ba5913a2777()
    {
        
    }

#/

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0x4d4e613f, Offset: 0x22b3
// Size: 0x53
function function_5af03e0e432dd98c()
{
    level endon( #"hash_c9c9cc25d216ce46" );
    level waittill( #"hash_579fd1702d3a0678" );
    level utility::flag_set( "flag_vo_restricted_elevator_dialogue" );
    wait 0.5;
    overlord::playconversation( "if_we_get_exposed" );
    level utility::flag_clear( "flag_vo_restricted_elevator_dialogue" );
    level notify( #"hash_68d37a25ad6f80cc" );
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0x6c363460, Offset: 0x230e
// Size: 0x93
function function_181bcaf98baacce2()
{
    level notify( #"hash_579fd1702d3a0678" );
    level endon( #"hash_579fd1702d3a0678" );
    childthread function_bbc22bd633e2c59f();
    level utility::flag_wait( "flag_vo_restricted_area_cooling_room" );
    level notify( #"hash_c9c9cc25d216ce46" );
    overlord::function_be2d6dc71f97faa6( "cooling_room" );
    level utility::flag_wait_any( "flag_vo_security_area_cooling_room_exit", "flag_vo_restricted_area_cooling_room_clear" );
    
    if ( !utility::flag( "flag_vo_restricted_area_cooling_room_clear" ) )
    {
        overlord::function_be2d6dc71f97faa6( "cooling_room_clear_the_room" );
        level utility::flag_wait( "flag_vo_restricted_area_cooling_room_clear" );
    }
    
    overlord::function_be2d6dc71f97faa6( "cooling_room_push_ahead" );
    thread function_b300bf6910105273();
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0xe9864c7d, Offset: 0x23a9
// Size: 0x1b
function function_b300bf6910105273()
{
    level utility::flag_wait( "flag_vo_restricted_area_computer_callout" );
    overlord::function_be2d6dc71f97faa6( "quantum_computer_dead_ahead" );
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0x722dde79, Offset: 0x23cc
// Size: 0xf6
function function_1d318dd57a696070()
{
    level notify( #"hash_579fd1702d3a0678" );
    level endon( #"hash_579fd1702d3a0678" );
    nags = [ "nag_drive_1" ];
    thread function_e912963a5aaf5005( nags, "flag_vo_quantum_computer_interact", 60, 0 );
    level utility::flag_wait( "flag_vo_quantum_computer_interact" );
    overlord::function_be2d6dc71f97faa6( "decryption_initiating" );
    level waittill( #"notetrack_vo_drive_in" );
    capricorn_audio::function_38dad91c7a2f349e();
    overlord::playconversation( "decryption_defense_start", undefined, 3 );
    level utility::flag_wait( "flag_computer_defense_wave_01_start" );
    overlord::function_be2d6dc71f97faa6( "decryption_defense_first_wave" );
    level utility::flag_wait( "flag_computer_defense_wave_02_start" );
    overlord::playconversation( "decryption_defense_progress" );
    thread function_581b1ae4a01fc9c8();
    level utility::flag_wait( "flag_restricted_computer_encounter_done" );
    capricorn_audio::function_2ff8989577abc3ce();
    overlord::function_be2d6dc71f97faa6( "decryption_defense_complete", undefined, 1 );
    nags = [ "nag_retrieve_1" ];
    thread function_e912963a5aaf5005( nags, "flag_restricted_quantum_computer_interact_completed", 45, 0 );
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0x47be56c2, Offset: 0x24ca
// Size: 0x45
function function_bbc22bd633e2c59f()
{
    level endon( #"hash_c9c9cc25d216ce46" );
    level utility::flag_wait( "flag_vo_restricted_area_experimental_tech" );
    
    if ( utility::flag( "flag_vo_restricted_elevator_dialogue" ) )
    {
        level waittill( #"hash_68d37a25ad6f80cc" );
        wait 1;
    }
    
    overlord::playconversation( "wonder_what_kind_of_stuff" );
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0x48dab22b, Offset: 0x2517
// Size: 0x1e
function function_581b1ae4a01fc9c8()
{
    level waittill( #"notetrack_vo_drive_retrieved" );
    overlord::playconversation( "decrypted_drive_retrieved", undefined, 1 );
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0xd1aba7ea, Offset: 0x253d
// Size: 0x41
function function_c0ac404eaba06846()
{
    level notify( #"hash_579fd1702d3a0678" );
    level endon( #"hash_579fd1702d3a0678" );
    level utility::flag_wait( "flag_vo_restricted_area_garage_drones_spawned" );
    overlord::function_be2d6dc71f97faa6( "drones_in_the_air" );
    childthread function_9f46fb2a7e0d61b8();
    thread function_6d08b3c7d9bf2bb1();
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0xfbe0c6b9, Offset: 0x2586
// Size: 0x4f
function function_9f46fb2a7e0d61b8()
{
    level endon( #"flag_vo_restricted_area_garage_door" );
    level utility::flag_wait_or_timeout( "flag_vo_restricted_area_garage_open_nag", 300 );
    nags = [ "nag_garage_door_1", "nag_garage_door_2" ];
    thread function_e912963a5aaf5005( nags, "flag_vo_restricted_area_garage_door", 90, 30 );
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0x30c5388a, Offset: 0x25dd
// Size: 0x20
function function_6d08b3c7d9bf2bb1()
{
    level utility::flag_wait_any( "flag_vo_restricted_area_garage_open_nag", "flag_vo_restricted_area_garage_door" );
    overlord::playconversation( "garage_section_2" );
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0x988175ae, Offset: 0x2605
// Size: 0x96
function function_d8700cb3aac99139()
{
    level notify( #"hash_579fd1702d3a0678" );
    level endon( #"hash_579fd1702d3a0678" );
    level utility::flag_wait( "flag_vo_restricted_area_escape" );
    overlord::playconversation( "where_do_we_go" );
    level utility::flag_wait( "flag_vo_restricted_area_walljump" );
    overlord::playconversation( "walljump_tutorial_hint", undefined, undefined, 1 );
    level utility::flag_wait( "flag_vo_restricted_area_subway" );
    capricorn_audio::function_f91f4c7051e3eb95();
    wait 1;
    thread overlord::playconversation( "an_empty_subway_station" );
    level utility::flag_wait( "flag_vo_restricted_area_subway_flashbang_ambush" );
    wait 0.5;
    overlord::playconversation( "subway_flashbang_ambush", undefined, 0, 1 );
}

/#

    // Namespace mp_sat_ob_capricorn_vo
    // Params 0
    // Checksum 0xbf37f37b, Offset: 0x26a3
    // Size: 0x5, Type: dev
    function function_2e0780d8e73cdd12()
    {
        
    }

#/

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0xc1a4a64a, Offset: 0x26b0
// Size: 0x94
function function_4b74802884508537()
{
    level notify( #"hash_579fd1702d3a0678" );
    level endon( #"hash_579fd1702d3a0678" );
    level utility::flag_wait( "flag_vo_roji_find_the_tallest" );
    overlord::playconversation( "find_the_tallest_roof" );
    level utility::flag_wait( "flag_roji_near_trainstation" );
    overlord::function_be2d6dc71f97faa6( "roji_first_building_ground_level" );
    wait 3;
    overlord::playconversation( "everywhere_we_go_more_guild" );
    level utility::flag_wait( "flag_vo_roji_train_station_tangos" );
    overlord::function_be2d6dc71f97faa6( "more_tangos" );
    level utility::flag_wait( "flag_vo_roji_trainstation_scaffolding" );
    overlord::function_be2d6dc71f97faa6( "scaffolding_we_need_to_go_up" );
    thread function_a4198b6257cc5eef();
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0xc0385469, Offset: 0x274c
// Size: 0x1b
function function_a4198b6257cc5eef()
{
    level waittill( #"hash_579fd1702d3a0678" );
    overlord::playconversation( "roji_drone_callout" );
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0x72a252ea, Offset: 0x276f
// Size: 0x43
function function_a6f4336c43443f42()
{
    level notify( #"hash_579fd1702d3a0678" );
    level endon( #"hash_579fd1702d3a0678" );
    level utility::flag_init( "flag_vo_roof_encourage_active" );
    childthread function_35150a796cad2720();
    childthread function_be3ee64be3f0a587();
    childthread function_5443328abeb0fee();
    thread function_e193ad2087d5eec6();
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0x6d856eb4, Offset: 0x27ba
// Size: 0x62
function function_35150a796cad2720()
{
    while ( true )
    {
        level utility::flag_wait( "flag_vo_roji_encourage_1" );
        
        if ( !utility::flag( "flag_vo_roof_encourage_active" ) )
        {
            level utility::flag_set( "flag_vo_roof_encourage_active" );
            overlord::function_be2d6dc71f97faa6( "roof_encourage_1" );
            wait 5;
            level utility::flag_clear( "flag_vo_roof_encourage_active" );
            return;
        }
        
        wait 1;
        utility::flag_clear( "flag_vo_roji_encourage_1" );
    }
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0x1fbb840d, Offset: 0x2824
// Size: 0x62
function function_be3ee64be3f0a587()
{
    while ( true )
    {
        level utility::flag_wait( "flag_vo_roji_encourage_2" );
        
        if ( !utility::flag( "flag_vo_roof_encourage_active" ) )
        {
            level utility::flag_set( "flag_vo_roof_encourage_active" );
            overlord::function_be2d6dc71f97faa6( "roof_encourage_2" );
            wait 5;
            level utility::flag_clear( "flag_vo_roof_encourage_active" );
            return;
        }
        
        wait 1;
        utility::flag_clear( "flag_vo_roji_encourage_2" );
    }
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0x877edfa5, Offset: 0x288e
// Size: 0x62
function function_5443328abeb0fee()
{
    while ( true )
    {
        level utility::flag_wait( "flag_vo_roji_encourage_3" );
        
        if ( !utility::flag( "flag_vo_roof_encourage_active" ) )
        {
            level utility::flag_set( "flag_vo_roof_encourage_active" );
            overlord::function_be2d6dc71f97faa6( "roof_encourage_3" );
            wait 5;
            level utility::flag_clear( "flag_vo_roof_encourage_active" );
            return;
        }
        
        wait 1;
        utility::flag_clear( "flag_vo_roji_encourage_3" );
    }
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0xa210684e, Offset: 0x28f8
// Size: 0x21
function function_e193ad2087d5eec6()
{
    level waittill( #"hash_579fd1702d3a0678" );
    overlord::function_be2d6dc71f97faa6( "move_speed_upgrade", undefined, 0.1 );
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0x59c581d1, Offset: 0x2921
// Size: 0x61
function function_8f79c47dd1e9da71()
{
    level notify( #"hash_579fd1702d3a0678" );
    level endon( #"hash_579fd1702d3a0678" );
    childthread function_1947b7761b5dd59d();
    childthread function_fde65284c2158d95();
    childthread function_8171b0f0c2a61294();
    level utility::flag_wait( "flag_vo_roji_pursuit" );
    overlord::playconversation( "guild_soldiers_are_everywhere" );
    level utility::flag_wait( "flag_vo_roji_elevator_callout" );
    overlord::function_be2d6dc71f97faa6( "we_gotta_get_up_there" );
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0xfb690228, Offset: 0x298a
// Size: 0x74
function function_1947b7761b5dd59d()
{
    while ( true )
    {
        level utility::flag_wait( "flag_vo_roji_billboard" );
        hinttimeout = 0;
        
        while ( overlord::function_dce0a14273dfa0a8() && hinttimeout <= 0.3 )
        {
            wait 0.1;
            hinttimeout += 0.1;
        }
        
        if ( hinttimeout <= 0.3 )
        {
            overlord::function_be2d6dc71f97faa6( "wall_jump_across_gap" );
            return;
        }
        
        level utility::flag_clear( "flag_vo_roji_billboard" );
    }
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0x58578f17, Offset: 0x2a06
// Size: 0x42
function function_fde65284c2158d95()
{
    level utility::flag_wait( "flag_vo_roji_encourage_4" );
    
    if ( !overlord::function_dce0a14273dfa0a8() && !utility::flag( "flag_vo_dont_look_down_used" ) )
    {
        overlord::function_be2d6dc71f97faa6( "roof_encourage_4" );
        level utility::flag_set( "flag_vo_dont_look_down_used" );
    }
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0x599b8505, Offset: 0x2a50
// Size: 0x42
function function_8171b0f0c2a61294()
{
    level utility::flag_wait( "flag_vo_roji_encourage_6" );
    
    if ( !overlord::function_dce0a14273dfa0a8() && !utility::flag( "flag_vo_dont_look_down_used" ) )
    {
        overlord::function_be2d6dc71f97faa6( "roof_encourage_4" );
        level utility::flag_set( "flag_vo_dont_look_down_used" );
    }
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0xa3a8de6, Offset: 0x2a9a
// Size: 0x69
function function_eb81b3d5f6e6df7a()
{
    level utility::flag_wait( "flag_roji_hotel_elevator" );
    overlord::function_be2d6dc71f97faa6( "rooftop_elevator_callout" );
    level utility::flag_wait( "flag_vo_roji_ascenders_nag" );
    nags = [ "nag_elevator_rooftop_1", "nag_elevator_rooftop_2", "nag_elevator_rooftop_3" ];
    thread function_e912963a5aaf5005( nags, "roji_roof_elevator_interact_inside_done", 90, 60 );
    thread function_1603facb8f27366();
}

/#

    // Namespace mp_sat_ob_capricorn_vo
    // Params 0
    // Checksum 0x1c596e09, Offset: 0x2b0b
    // Size: 0x5, Type: dev
    function function_f85fc174cd3182fe()
    {
        
    }

#/

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0xd0b99619, Offset: 0x2b18
// Size: 0x1e
function function_1603facb8f27366()
{
    level waittill( #"hash_579fd1702d3a0678" );
    wait 1;
    overlord::playconversation( "colonel_were_in_position" );
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0x11be5468, Offset: 0x2b3e
// Size: 0x80
function function_53347a20ac46aab3()
{
    level notify( #"hash_579fd1702d3a0678" );
    level endon( #"hash_579fd1702d3a0678" );
    childthread function_f1bfea74e3ea1ceb();
    level waittill( #"notetrack_vo_vtol_arrival" );
    overlord::playconversation( "the_winged_demon_returns" );
    childthread function_eaac89820cd805ea();
    level utility::flag_wait( "flag_roof_ground_enemies_1" );
    wait 1;
    overlord::playconversation( "vtol_reinforcement_1" );
    level utility::flag_wait( "flag_roof_ground_enemies_2" );
    wait 1;
    overlord::playconversation( "vtol_reinforcement_2" );
    thread function_54a155aa0611cae5();
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0xc7c4a167, Offset: 0x2bc6
// Size: 0x57
function function_eaac89820cd805ea()
{
    for ( bombingrunvo = 1; true ; bombingrunvo = 1 )
    {
        level waittill( #"vo_bombing_run" );
        wait 0.5;
        
        if ( !overlord::function_dce0a14273dfa0a8() )
        {
            overlord::function_be2d6dc71f97faa6( "vtol_bombing_" + bombingrunvo );
            bombingrunvo += 1;
            
            if ( bombingrunvo > 4 )
            {
            }
        }
    }
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0x36274633, Offset: 0x2c25
// Size: 0x34
function function_54a155aa0611cae5()
{
    level utility::flag_set( "flag_vo_emp_plan_wait" );
    level waittill( #"hash_579fd1702d3a0678" );
    overlord::playconversation( "vtol_shields_up" );
    utility::flag_set( "flag_plant_emp_vo_finished" );
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0xf61eeb44, Offset: 0x2c61
// Size: 0x15a
function function_67d5bc2ad61d01da()
{
    level notify( #"hash_579fd1702d3a0678" );
    level endon( #"hash_579fd1702d3a0678" );
    
    if ( !utility::flag( "flag_vo_emp_plan_wait" ) )
    {
        utility::flag_set( "flag_plant_emp_vo_finished" );
    }
    
    nags = [ "nag_emp_1", "nag_emp_2", "nag_emp_3" ];
    thread function_e912963a5aaf5005( nags, "flag_vo_emp_planting", 45, 30 );
    level waittill( #"hash_e085f424ab4a1c14" );
    overlord::function_be2d6dc71f97faa6( "initiating_en12_charge" );
    level utility::flag_wait( "flag_vo_emp_planted" );
    overlord::playconversation( "en12_charging" );
    level utility::flag_wait( "flag_vo_halfway_charged" );
    overlord::function_be2d6dc71f97faa6( "charging_50_percent" );
    level utility::flag_wait( "flag_vo_position_for_exfil" );
    overlord::playconversation( "colonel_tell_that_transport" );
    level utility::flag_wait( "flag_vo_emp_charged" );
    overlord::function_be2d6dc71f97faa6( "en12_charge_activate" );
    level utility::flag_wait( "flag_emp_animation_completed" );
    overlord::playconversation( "it_worked" );
    level utility::flag_wait( "flag_vtol_crash_done" );
    overlord::playconversation( "vtol_defeated" );
    level utility::flag_set( "flag_vtol_defeated_vo_complete" );
    level utility::flag_wait( "flag_vo_roof_exfil" );
    overlord::playconversation( "theres_our_ride", undefined, 1 );
    wait 0.3;
    level utility::flag_set( "flag_exfil_vo_complete" );
}

// Namespace mp_sat_ob_capricorn_vo
// Params 0
// Checksum 0xf76d5428, Offset: 0x2dc3
// Size: 0x1b
function function_f1bfea74e3ea1ceb()
{
    level utility::flag_wait( "flag_vo_roof_boss_reinforced_hull" );
    overlord::playconversation( "vtol_reinforced_hull" );
}

// Namespace mp_sat_ob_capricorn_vo
// Params 4
// Checksum 0xf5801f1d, Offset: 0x2de6
// Size: 0xb7
function function_e912963a5aaf5005( nags, endflag, waittime, waittimeincrease )
{
    level endon( #"hash_bc93fe3c0f35bfcb" );
    childthread function_2884c73b4e25481c( endflag );
    
    foreach ( nagevent in nags )
    {
        wait waittime;
        overlord::function_be2d6dc71f97faa6( nagevent );
        waittime += waittimeincrease;
    }
}

// Namespace mp_sat_ob_capricorn_vo
// Params 1
// Checksum 0x633bf9bc, Offset: 0x2ea5
// Size: 0x22
function function_2884c73b4e25481c( endflag )
{
    level utility::flag_wait( endflag );
    level notify( #"hash_bc93fe3c0f35bfcb" );
}

