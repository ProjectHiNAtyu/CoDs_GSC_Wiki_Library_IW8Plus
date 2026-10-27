// scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_vo.gsc  (hash_0b6e1b91bd537d5b.gscc) (size: 24823 Bytes / 0x60f7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x90275eea (2418499306)
// size ...... 24823 (0x60f7)
// includes .. 6   (offset: 0x54bf)
// strings ... 240 (offset: 0x54ef)
// dev strs .. 1   (offset: 0x60eb)
// exports ... 67  (offset: 0x3fcb)
// cseg ...... 0x207f + 0x1f4c (0x3fcb)
// imports ... 68  (offset: 0x4a43)
// animtree1 . 0   (offset: 0x60f7)
// animtree2 . 0   (offset: 0x60f7)
#using script_66878054d141dbc0;
#using scripts\anim\dialogue;
#using scripts\common\snd\snd;
#using scripts\common\utility;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_audio;
#using scripts\mp\overlord;

#namespace mp_sat_ob_leo_vo;

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x1776dccc, Offset: 0x209d
// Size: 0xd0
function function_8cf7281eaa34cdc4()
{
    if ( !isdefined( level.mason_radio ) )
    {
        level.mason_radio = spawnstruct();
        level.mason_radio.team = "allies";
        level.mason_radio.name = "David";
    }
    
    if ( !isdefined( level.operator ) )
    {
        level.operator = spawnstruct();
        level.operator.team = "allies";
        level.operator.name = "Hero";
    }
    
    if ( !isdefined( level.var_babe049872e2f6e ) )
    {
        level.var_babe049872e2f6e = spawnstruct();
        level.var_babe049872e2f6e.name = "";
    }
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x7f515a31, Offset: 0x2175
// Size: 0x81
function facility_intro_vo()
{
    level endon( #"flag_central_player_entered_space" );
    level utility::flag_wait( "flag_intro_encounter_start" );
    wait 3;
    overlord::playconversation( "guild_intro_start" );
    utility::flag_set( "flag_stealth_vo_said" );
    utility::flag_wait( "flag_atrium1_stealth_broke" );
    wait 1.5;
    overlord::playconversation( "guild_intro_combat_goinghot" );
    wait 1;
    overlord::playconversation( "enter_atrium" );
    utility::flag_wait( "flag_atrium_encounter_done" );
    wait 1.6;
    overlord::playconversation( "atrium1_complete_alldead" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x9562c8cd, Offset: 0x21fe
// Size: 0x9f
function function_31edf6edcc0d5b29()
{
    level endon( #"flag_atrium1_stealth_broke" );
    level endon( #"twoguard_death" );
    struct = utility::getstruct( "twoguard_struct_intro", "targetname" );
    level thread twoguard_struct_intro( struct );
    trig = getent( "trig_twoguard_intro", "targetname" );
    trig waittill( #"trigger" );
    function_bff5063e5cb50c64( "dx_wc_mleo_lprc_guif_maniskaganaslavedriv", "twoguard_struct_intro" );
    wait 1;
    function_bff5063e5cb50c64( "dx_wc_mleo_lprc_guia_alotbutshesaidweregu", "twoguard_struct_intro" );
    wait 1;
    function_bff5063e5cb50c64( "dx_wc_mleo_lprc_guif_yeahyeahshesalwaysta", "twoguard_struct_intro" );
}

// Namespace mp_sat_ob_leo_vo
// Params 1
// Checksum 0xe50197e1, Offset: 0x22a5
// Size: 0x37
function twoguard_struct_intro( struct )
{
    ai = getaiarrayinradius( struct.origin, 128 );
    utility::array_thread( ai, &function_880c551c3b291b82 );
}

// Namespace mp_sat_ob_leo_vo
// Params 1
// Checksum 0x960ee552, Offset: 0x22e4
// Size: 0x37
function function_ddca16a1d42a4c14( struct )
{
    ai = getaiarrayinradius( struct.origin, 128 );
    utility::array_thread( ai, &function_1a9efde59cdf89d4 );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x2f8c434b, Offset: 0x2323
// Size: 0x1b
function function_880c551c3b291b82()
{
    self waittill( #"death" );
    level notify( #"twoguard_death" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0xc1865d81, Offset: 0x2346
// Size: 0x1b
function function_1a9efde59cdf89d4()
{
    self waittill( #"death" );
    level notify( #"threeguard_death" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0xa1d03818, Offset: 0x2369
// Size: 0x157
function function_992fc75ffb5cde03()
{
    level endon( #"flag_atrium1_stealth_broke" );
    level endon( #"threeguard_death" );
    struct = utility::getstruct( "three_guard_struct_intro", "targetname" );
    level thread function_ddca16a1d42a4c14( struct );
    trig = getent( "trig_threeguard_intro", "targetname" );
    trig waittill( #"trigger" );
    function_bff5063e5cb50c64( "dx_wc_mleo_lprc_guig_youhearanythingfromt", "three_guard_struct_intro" );
    wait 1;
    function_bff5063e5cb50c64( "dx_wc_mleo_lprc_guif_nahtheyvebeensuperti", "three_guard_struct_intro" );
    wait 1;
    function_bff5063e5cb50c64( "dx_wc_mleo_lprc_guie_youthinkitsjustsomek", "three_guard_struct_intro" );
    wait 0.6;
    function_bff5063e5cb50c64( "dx_wc_mleo_lprc_guig_nahiheardtheybrought", "three_guard_struct_intro" );
    wait 0.8;
    function_bff5063e5cb50c64( "dx_wc_mleo_lprc_guie_noshitwellbiochemist", "three_guard_struct_intro" );
    wait 0.6;
    function_bff5063e5cb50c64( "dx_wc_mleo_lprc_guif_bionicsmaybelikecybe", "three_guard_struct_intro" );
    wait 0.9;
    function_bff5063e5cb50c64( "dx_wc_mleo_lprc_guig_hellidgoforsomeupgra", "three_guard_struct_intro" );
    wait 1;
    function_bff5063e5cb50c64( "dx_wc_mleo_lprc_guie_metoohundredpercent", "three_guard_struct_intro" );
    wait 0.5;
    function_bff5063e5cb50c64( "dx_wc_mleo_lprc_guif_notmemanthatkindathi", "three_guard_struct_intro" );
    wait 0.6;
    function_bff5063e5cb50c64( "dx_wc_mleo_lprc_guig_wuss", "three_guard_struct_intro" );
    wait 0.5;
    function_bff5063e5cb50c64( "dx_wc_mleo_lprc_guia_chuckle", "three_guard_struct_intro" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x29ec6ae5, Offset: 0x24c8
// Size: 0xe
function function_cb8d3d0fb7f83140()
{
    overlord::function_be2d6dc71f97faa6( "searching_enemies_left" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x5144c831, Offset: 0x24de
// Size: 0xb1
function facility_presentation_vo()
{
    level endon( #"flag_central_player_exiting" );
    level utility::flag_wait( "flag_central_encounter_start" );
    thread function_1557bea1390ec1ae();
    thread function_25e7e6b7b6f65efe();
    thread function_c38c273a4357984d();
    thread function_6cfbce6b99a02394();
    thread function_4f9dd18af778eae7();
    level utility::flag_wait( "flag_central_player_entered_space" );
    overlord::function_be2d6dc71f97faa6( "guild_presentation_soundstage" );
    wait 1;
    level utility::flag_set( "flag_central_initial_vo_done" );
    wait 1.5;
    thread leo_audio::function_f098c4894a2adcfa();
    function_bff5063e5cb50c64( "dx_wc_mleo_scrn_oney_thankstoyoutheguilds_01", "pa_struct_stage" );
    wait 1;
    level utility::flag_set( "flag_stage_bots_vo_done" );
    level utility::flag_wait( "flag_central_guild_bots_dead" );
    wait 20;
    overlord::function_be2d6dc71f97faa6( "guild_destroy_nodes_done" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x97edc353, Offset: 0x2597
// Size: 0x40
function function_1557bea1390ec1ae()
{
    level endon( #"flag_central_player_entered_space" );
    overlord::playconversation( "guild_atrium" );
    level utility::flag_set( "flag_connection_puzzle_vo_said" );
    level utility::flag_wait( "flag_presentation_puzzle_opened" );
    overlord::playconversation( "guild_presentation_hack" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x36945a17, Offset: 0x25df
// Size: 0x7b
function function_25e7e6b7b6f65efe()
{
    level thread function_1cd6e26e2a62b10a();
    level endon( #"flag_presentation_ff_destroyed" );
    level utility::flag_wait( "flag_central_player_exiting" );
    wait 1;
    overlord::function_be2d6dc71f97faa6( "guild_forcefield_eliminate" );
    wait 10;
    level utility::flag_set( "flag_presentation_ff_nag_said" );
    overlord::function_be2d6dc71f97faa6( "guild_forcefield_kill_power" );
    wait 5;
    overlord::function_be2d6dc71f97faa6( "guild_forcefield_follow_wires" );
    wait 5;
    overlord::function_be2d6dc71f97faa6( "guild_forcefield_far_side" );
    wait 5;
    overlord::function_be2d6dc71f97faa6( "guild_forcefield_shoot_power" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0xc0fddf25, Offset: 0x2662
// Size: 0x1b
function function_1cd6e26e2a62b10a()
{
    level utility::flag_wait( "flag_presentation_ff_destroyed" );
    overlord::playconversation( "ff_destroyed" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x67c10046, Offset: 0x2685
// Size: 0x38
function function_c38c273a4357984d()
{
    level utility::flag_wait( "flag_stage_bots_activated" );
    function_bff5063e5cb50c64( "dx_wc_mleo_lprc_gpa1_securityprotocolacti", "pa_struct_stage" );
    overlord::function_be2d6dc71f97faa6( "guild_presentation_machines_active" );
    overlord::function_be2d6dc71f97faa6( "guild_presentation_machines_clear" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x140f43b8, Offset: 0x26c5
// Size: 0x2d
function function_6cfbce6b99a02394()
{
    level endon( #"flag_presentation_ff_destroyed" );
    level utility::flag_wait( "flag_central_player_exiting" );
    wait 0.5;
    overlord::playconversation( "guild_destroy_nodes_reinforcements" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0xcf76dac4, Offset: 0x26fa
// Size: 0x1e
function function_4f9dd18af778eae7()
{
    level utility::flag_wait( "flag_central_guild_bots_dead" );
    wait 1;
    overlord::playconversation( "guild_presentation_post_combat" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0xac508957, Offset: 0x2720
// Size: 0x2a
function function_8502c26b5c1ac5f4()
{
    level utility::flag_wait( "flag_central_nodes_interact_used" );
    level endon( #"hash_7a1b12252ccffc0a" );
    wait 20;
    overlord::playconversation( "guild_destroy_nodes_nag" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0xe363f9ab, Offset: 0x2752
// Size: 0x1b
function function_e8cd5e78115a7b7b()
{
    level endon( #"hash_7de5bb91c19d9b4b" );
    level waittill( #"hash_446bd2704ac8667d" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x71c63e20, Offset: 0x2775
// Size: 0x118
function function_eb8dcfcada984e40()
{
    level.var_6f1a5d8af14fe5b1 = [];
    level.var_6f1a5d8af14fe5b1[ level.var_6f1a5d8af14fe5b1.size ] = "dx_wc_mleo_scrn_oney_theguildwillbringpea";
    level.var_6f1a5d8af14fe5b1[ level.var_6f1a5d8af14fe5b1.size ] = "dx_wc_mleo_scrn_oney_powerrestswiththosew";
    level.var_6f1a5d8af14fe5b1[ level.var_6f1a5d8af14fe5b1.size ] = "dx_wc_mleo_scrn_oney_withyourhardworktheg";
    level.var_6f1a5d8af14fe5b1[ level.var_6f1a5d8af14fe5b1.size ] = "dx_wc_mleo_scrn_oney_togetherweareforging";
    level.var_6f1a5d8af14fe5b1[ level.var_6f1a5d8af14fe5b1.size ] = "dx_wc_mleo_scrn_oney_whensecuritymatterst";
    screen_triggers = getnoentvolumearray( "guild_facility_tv_triggers", "targetname" );
    
    foreach ( screen_trigger in screen_triggers )
    {
        screen_trigger thread function_e5155030a5aebde0();
    }
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x8afb4662, Offset: 0x2895
// Size: 0xb4
function function_e5155030a5aebde0()
{
    self waittill( #"trigger" );
    var_ed92d3edd3eded9 = utility::getstruct( self.target );
    
    if ( isdefined( var_ed92d3edd3eded9.script_noteworthy ) )
    {
        vo = var_ed92d3edd3eded9.script_noteworthy;
    }
    else
    {
        vo = utility::array_random( level.var_6f1a5d8af14fe5b1 );
        level.var_6f1a5d8af14fe5b1 = arrayremove( level.var_6f1a5d8af14fe5b1, vo );
    }
    
    if ( utility::cointoss() )
    {
        snd::play( "evt_leo_guild_jingle", var_ed92d3edd3eded9.targetname );
        wait 2.5;
    }
    
    function_bff5063e5cb50c64( vo, var_ed92d3edd3eded9.targetname );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x5b408fdd, Offset: 0x2951
// Size: 0x55
function facility_labs_vo()
{
    level endon( #"hash_28c90132a4185056" );
    thread function_738712d5faa5fa22();
    level utility::flag_wait( "flag_labs_start_vignettes" );
    overlord::playconversation( "guild_labs_scientists" );
    thread function_1420feba1e607c43();
    thread function_be132ac8dfd64343();
    level utility::flag_wait( "flag_guild_labs_player_near_exit" );
    overlord::function_be2d6dc71f97faa6( "guild_labs_end" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x2c3542fb, Offset: 0x29ae
// Size: 0x54
function function_738712d5faa5fa22()
{
    level endon( #"hash_c62b8cbe72c79838" );
    level endon( #"hash_e2e5e8364f47e9ed" );
    level utility::flag_wait( "flag_labs_forcefields_start" );
    wait 2;
    overlord::function_be2d6dc71f97faa6( "guild_forcefield_cut_power" );
    wait 10;
    overlord::function_be2d6dc71f97faa6( "guild_forcefield_get_through" );
    wait 10;
    overlord::function_be2d6dc71f97faa6( "guild_forcefield_check_security" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x45365a79, Offset: 0x2a0a
// Size: 0x27
function function_1420feba1e607c43()
{
    level endon( #"hash_28c90132a4185056" );
    level utility::flag_wait( "flag_guild_labs_player_near_vats" );
    overlord::playconversation( "guild_labs_vats" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0xc577b160, Offset: 0x2a39
// Size: 0x27
function function_be132ac8dfd64343()
{
    level endon( #"hash_28c90132a4185056" );
    level utility::flag_wait( "flag_guild_labs_player_near_bodies" );
    overlord::playconversation( "guild_labs_bodies" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0xc3ca004f, Offset: 0x2a68
// Size: 0x74
function facility_macguffin_vo()
{
    wait 1;
    overlord::playconversation( "guild_quantum_enter" );
    level utility::flag_wait( "facility_macguffin_core_tried" );
    function_bff5063e5cb50c64( "dx_wc_mleo_lprc_gpa1_noaccesslockdowninef", "quantum_hatch_struct" );
    overlord::playconversation( "guild_quantum_core_tried" );
    level utility::flag_wait( "flag_quantum_one_console_interacted" );
    overlord::function_be2d6dc71f97faa6( "guild_hacking_protocols" );
    level utility::flag_wait( "flag_quantum_one_console_overriden" );
    overlord::playconversation( "guild_quantum_first_terminal" );
    thread function_4d2a8803120b0263();
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x3142854a, Offset: 0x2ae4
// Size: 0x38
function function_667070c25a48438e()
{
    level endon( #"hash_4769c5989f8bd1ae" );
    level endon( #"hash_30b0bdb74c933413" );
    wait 30;
    overlord::function_be2d6dc71f97faa6( "guild_forcefield_way_up" );
    wait 20;
    overlord::function_be2d6dc71f97faa6( "guild_forcefield_climb_up" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0xe55b9e93, Offset: 0x2b24
// Size: 0x1d
function function_4d2a8803120b0263()
{
    level endon( #"hash_30b0bdb74c933413" );
    wait 20;
    overlord::function_be2d6dc71f97faa6( "guild_quantum_nag" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x9a27b097, Offset: 0x2b49
// Size: 0xae
function facility_macguffin_core_vo()
{
    overlord::playconversation( "guild_quantum_drive_exposed" );
    level utility::flag_wait( "facility_macguffin_core_item_acquired" );
    overlord::function_be2d6dc71f97faa6( "guild_quantum_bots_spawned" );
    level utility::flag_wait( "facility_macguffin_core_start_plant" );
    wait 1;
    overlord::playconversation( "guild_quantum_grabbed_drive" );
    thread function_259e6ff864b3d275();
    level utility::flag_wait( "flag_quantum_one_explosive_planted" );
    overlord::function_be2d6dc71f97faa6( "guild_quantum_first_explosive" );
    level utility::flag_wait( "flag_quantum_two_explosives_planted" );
    overlord::function_be2d6dc71f97faa6( "guild_quantum_second_explosive" );
    level utility::flag_wait( "flag_quantum_three_explosives_planted" );
    overlord::function_be2d6dc71f97faa6( "guild_quantum_third_explosive" );
    level utility::flag_wait( "flag_quantum_all_explosives_planted" );
    overlord::function_be2d6dc71f97faa6( "guild_quantum_all_explosives" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0xa7a964b5, Offset: 0x2bff
// Size: 0x3b
function function_259e6ff864b3d275()
{
    level endon( #"flag_quantum_all_explosives_planted" );
    wait 20;
    overlord::playconversation( "guild_quantum_explosives_nag_1" );
    wait 20;
    overlord::playconversation( "guild_quantum_explosives_nag_2" );
    wait 20;
    overlord::playconversation( "guild_quantum_explosives_nag_3" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0xdd55ef04, Offset: 0x2c42
// Size: 0x76
function function_94fcafe7f38c8407()
{
    level utility::flag_wait( "flag_labs_escape_encounter_start" );
    wait 5;
    overlord::function_be2d6dc71f97faa6( "guild_escape_1_lotta_guys" );
    wait 5;
    overlord::playconversation( "guild_escape_1_combat" );
    level utility::flag_wait( "flag_escape_1_door_1_closed" );
    thread function_bff5063e5cb50c64( "dx_wc_mleo_lprc_gpa1_alertsecuritybreachd", "pa_struct_labs" );
    overlord::function_be2d6dc71f97faa6( "guild_labs_hard_lock" );
    level utility::flag_wait( "flag_escape_1_door_3_closed" );
    wait 0.5;
    overlord::playconversation( "guild_escape_1_doors" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x719bc721, Offset: 0x2cc0
// Size: 0x2
function facility_cradle_vo()
{
    
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x10179710, Offset: 0x2cca
// Size: 0x3a
function function_45e8bdf7946d2ae7()
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance childthread function_5a618ffb1ca251c4();
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0xec40f1a4, Offset: 0x2d0c
// Size: 0xfa
function function_5a618ffb1ca251c4()
{
    level endon( #"facility_escape_2_complete" );
    level utility::flag_set( "flag_nm_gassed" );
    overlord::playconversation( "guild_post_cradle_hall" );
    function_bff5063e5cb50c64( "dx_wc_mleo_lptc_gpa1_containmentbreachall", "pa_struct_cradle" );
    overlord::playconversation( "guild_containment_failure" );
    level utility::flag_wait( "flag_central_escape_enemies_spawned" );
    overlord::playconversation( "guild_exfil_cradle_react" );
    level utility::flag_wait( "flag_central_escape_enemies_spawned_2" );
    overlord::playconversation( "guild_exfil_cradle_react_2" );
    wait 1;
    overlord::playconversation( "guild_exfil_menendez_react" );
    childthread function_f4e889b1fce69e0a();
    level utility::flag_wait( "flag_atrium_escape_encounter_start" );
    wait 2;
    overlord::playconversation( "guild_exfil_menendez_thats_enough" );
    childthread function_b67530aa14985ceb();
    level utility::flag_wait( "flag_escape_2_player_near_nic_exit" );
    overlord::function_be2d6dc71f97faa6( "guild_exfil_exit" );
    level utility::flag_wait( "flag_escape_2_player_near_nic_exit" );
    overlord::playconversation( "guild_nic_transition" );
    level utility::flag_wait( "flag_escape_2_player_in_trippy_hall" );
    overlord::function_be2d6dc71f97faa6( "guild_exfil_levels_spiking" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x4a97cc4, Offset: 0x2e0e
// Size: 0x2a
function function_ab00d45482a86e6()
{
    central_to_cradle_door = getent( "central_to_cradle_door", "script_noteworthy" );
    central_to_cradle_door waittill( #"trigger" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x811c007c, Offset: 0x2e40
// Size: 0x1d
function function_f4e889b1fce69e0a()
{
    level endon( #"flag_atrium_escape_encounter_start" );
    wait 15;
    overlord::playconversation( "guild_didnt_forget" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0xae250ba1, Offset: 0x2e65
// Size: 0x1d
function function_b67530aa14985ceb()
{
    level endon( #"flag_escape_2_player_in_trippy_hall" );
    wait 10;
    overlord::playconversation( "guild_exfil_menendez_dont_listen" );
}

// Namespace mp_sat_ob_leo_vo
// Params 1
// Checksum 0x3dcd54b2, Offset: 0x2e8a
// Size: 0x7d
function function_8532b0cfc0c248a( agent )
{
    lines = [ "dx_wc_mleo_lptc_guia_ahhahhhhnofuck", "dx_wc_mleo_lptc_guia_gahhhhh", "dx_wc_mleo_lptc_guia_ahhhhhhhwhatthefuck", "dx_wc_mleo_lptc_guia_getawayfrommeaghhh", "dx_wc_mleo_lptc_guie_nononoo", "dx_wc_mleo_lptc_guie_whatthefuckareyoudoi", "dx_wc_mleo_lptc_guie_wahhhhh", "dx_wc_mleo_lptc_guie_ohgodahhhhhh" ];
    alias = utility::array_random( lines );
    agent dialogue::say( alias );
}

// Namespace mp_sat_ob_leo_vo
// Params 1
// Checksum 0x274a6bfa, Offset: 0x2f0f
// Size: 0x7d
function function_115cf73d8205c888( agent )
{
    lines = [ "dx_wc_mleo_lptc_guif_fuckingkillyougrahh", "dx_wc_mleo_lptc_guif_diediegrahh", "dx_wc_mleo_lptc_guif_graghhhh", "dx_wc_mleo_lptc_guif_gahhgraaghhhh", "dx_wc_mleo_lptc_guif_ahhhhhhhh", "dx_wc_mleo_lptc_guig_fuckingpieceofgrahhh", "dx_wc_mleo_lptc_guig_killgrahhallyou", "dx_wc_mleo_lptc_guig_aghhhhh" ];
    alias = utility::array_random( lines );
    agent dialogue::say( alias );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0xdf794565, Offset: 0x2f94
// Size: 0x47
function function_5bd091dd6159ca17()
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance childthread jungle_intro_vo();
    level utility::flag_set( "flag_nm_jungle_start" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x487e404d, Offset: 0x2fe3
// Size: 0x4b
function jungle_intro_vo()
{
    wait 1;
    overlord::playconversation( "jungle_intro" );
    level utility::flag_set( "jungle_intro_vo_complete" );
    wait 2;
    
    if ( !utility::flag( "flag_jungle_intro_player_has_ability" ) )
    {
        overlord::playconversation( "jungle_intro_ability_crate" );
        wait 2;
    }
    
    overlord::playconversation( "jungle_intro_floating_rocks" );
}

// Namespace mp_sat_ob_leo_vo
// Params 1
// Checksum 0xbc67f0d6, Offset: 0x3036
// Size: 0x12e
function function_b14917005280c04e( var_ca908a6a83b8fb50 )
{
    self endon( #"death" );
    var_e37202d52b131f70 = [];
    var_e37202d52b131f70[ var_e37202d52b131f70.size ] = "dx_wc_mleo_lcbt_mend_sufferdavidsuffernow";
    var_e37202d52b131f70[ var_e37202d52b131f70.size ] = "dx_wc_mleo_lcbt_mend_thereisnoescapingme";
    var_e37202d52b131f70[ var_e37202d52b131f70.size ] = "dx_wc_mleo_lcbt_mend_iamwithyounowforever";
    var_e37202d52b131f70[ var_e37202d52b131f70.size ] = "dx_wc_mleo_lcbt_mend_areyousureyousawthel";
    var_e37202d52b131f70[ var_e37202d52b131f70.size ] = "dx_wc_mleo_lcbt_mend_iwillnotgoquietly";
    var_e37202d52b131f70[ var_e37202d52b131f70.size ] = "dx_wc_mleo_lcbt_mend_youwillnotforgetme";
    var_e37202d52b131f70[ var_e37202d52b131f70.size ] = "dx_wc_mleo_lcbt_mend_ifeelyourfeardavid";
    var_e37202d52b131f70[ var_e37202d52b131f70.size ] = "dx_wc_mleo_lcbt_mend_yourlineiscursed";
    var_e37202d52b131f70[ var_e37202d52b131f70.size ] = "dx_wc_mleo_lcbt_mend_iwillnotletyourest";
    var_10930a70287a7731 = var_e37202d52b131f70;
    var_54895679b8e8f90d = undefined;
    
    if ( isdefined( var_ca908a6a83b8fb50 ) )
    {
        level utility::flag_wait( var_ca908a6a83b8fb50 );
    }
    
    randomfloatrange( 3.5, 5.5 );
    
    while ( true )
    {
        arrayrandomize( var_10930a70287a7731 );
        vo = utility::array_random( var_10930a70287a7731 );
        
        if ( vo == var_54895679b8e8f90d )
        {
            while ( true )
            {
                vo = utility::array_random( var_10930a70287a7731 );
                
                if ( vo != var_54895679b8e8f90d )
                {
                    break;
                }
                
                waitframe();
            }
        }
        
        dialogue::say( vo );
        var_54895679b8e8f90d = vo;
        var_10930a70287a7731 = arrayremove( var_10930a70287a7731, vo );
        
        if ( var_10930a70287a7731.size == 0 )
        {
            var_10930a70287a7731 = var_e37202d52b131f70;
        }
        
        wait randomintrange( 12, 14 );
    }
}

// Namespace mp_sat_ob_leo_vo
// Params 2
// Checksum 0xf40b830a, Offset: 0x316c
// Size: 0x50
function jungle_menendez_taunt( str_conversation_name, var_ca908a6a83b8fb50 )
{
    if ( isdefined( var_ca908a6a83b8fb50 ) )
    {
        level utility::flag_wait( var_ca908a6a83b8fb50 );
    }
    
    thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "light", 3, undefined, level.players, undefined, undefined, 1 );
    
    if ( isdefined( str_conversation_name ) )
    {
        overlord::playconversation( str_conversation_name );
    }
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x5c68ee39, Offset: 0x31c4
// Size: 0x3a
function function_d80456549097a669()
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance childthread jungle_village_vo();
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x1fa40d28, Offset: 0x3206
// Size: 0x114
function jungle_village_vo()
{
    overlord::playconversation( "jungle_village_intro_nicaragua" );
    level utility::flag_wait( "flag_jungle_village_combat_start" );
    wait 2;
    overlord::playconversation( "jungle_village_guild_appears" );
    level thread jungle_village_first_kill();
    level utility::flag_wait_any( "flag_jungle_village_hill_enc_retreat", "flag_jungle_village_start_first_machete_attack" );
    level utility::flag_set( "flag_nm_machete_comment" );
    machete_target_scriptable = utility::function_30dbabe3200518b( "machete_target_tutorial", #targetname );
    
    while ( true )
    {
        machete_target_scriptable_state = machete_target_scriptable getscriptablepartstate( "impact", 1 );
        
        if ( machete_target_scriptable_state == "show" )
        {
            break;
        }
        
        wait 0.5;
    }
    
    overlord::playconversation( "jungle_village_machete_attack" );
    level utility::flag_wait( "flag_jungle_village_second_machete_attack" );
    overlord::function_be2d6dc71f97faa6( "jungle_village_second_machete_attack" );
    level utility::flag_wait( "flag_jungle_village_center_approach_enc_spawn" );
    overlord::playconversation( "jungle_village_combat_banter" );
    level utility::flag_wait( "flag_jungle_village_center_enc_spawn" );
    overlord::function_be2d6dc71f97faa6( "jungle_village_making_progress" );
    level utility::flag_wait( "jungle_village_combat_done" );
    overlord::playconversation( "jungle_village_combat_done" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x68ca3f6c, Offset: 0x3322
// Size: 0x27
function jungle_village_first_kill()
{
    level endon( #"flag_jungle_village_hill_enc_retreat" );
    level utility::flag_wait( "flag_jungle_village_first_kill" );
    overlord::playconversation( "jungle_village_taking_out_guild_enemies" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0xbabe399f, Offset: 0x3351
// Size: 0x5d
function function_a1ae4f6c7232a3e7()
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance childthread jungle_mansion_defend_vo();
    function_53ad5f2b62284499();
    function_276cd63e44b103b2();
    function_357d9a5c08dc58be();
    function_24bc62d309c352e8();
    function_94980c1bbf96a6bd();
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x363399db, Offset: 0x33b6
// Size: 0x1e
function jungle_mansion_defend_vo()
{
    wait 1;
    overlord::function_be2d6dc71f97faa6( "menendez_battle_start" );
    level utility::flag_set( "menendez_said_opening_line" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x352c0879, Offset: 0x33dc
// Size: 0x1c6
function function_53ad5f2b62284499()
{
    level.var_fe9f3dc96b8294f4 = [];
    level.var_fe9f3dc96b8294f4[ level.var_fe9f3dc96b8294f4.size ] = "dx_wc_mleo_lcbt_mend_ifeelyourfeardavid";
    level.var_fe9f3dc96b8294f4[ level.var_fe9f3dc96b8294f4.size ] = "dx_wc_mleo_lcbt_mend_thiswillbetheendofyo";
    level.var_fe9f3dc96b8294f4[ level.var_fe9f3dc96b8294f4.size ] = "dx_wc_mleo_lcbt_mend_makeyourpeacewithdea";
    level.var_fe9f3dc96b8294f4[ level.var_fe9f3dc96b8294f4.size ] = "dx_wc_mleo_lcbt_mend_iwillnotletyourest";
    level.var_fe9f3dc96b8294f4[ level.var_fe9f3dc96b8294f4.size ] = "dx_wc_mleo_lcbt_mend_thereisnoescapingme";
    level.var_fe9f3dc96b8294f4[ level.var_fe9f3dc96b8294f4.size ] = "dx_wc_mleo_lcbt_mend_iamwithyounowforever";
    level.var_fe9f3dc96b8294f4[ level.var_fe9f3dc96b8294f4.size ] = "dx_wc_mleo_lcbt_mend_yourlineiscursed";
    level.var_fe9f3dc96b8294f4[ level.var_fe9f3dc96b8294f4.size ] = "dx_wc_mleo_lcbt_mend_hahaha";
    level.var_fe9f3dc96b8294f4[ level.var_fe9f3dc96b8294f4.size ] = "dx_wc_mleo_lcbt_mend_ahahaha";
    level.var_fe9f3dc96b8294f4[ level.var_fe9f3dc96b8294f4.size ] = "dx_wc_mleo_lcbt_mend_hahahaha";
    level.var_fe9f3dc96b8294f4[ level.var_fe9f3dc96b8294f4.size ] = "dx_wc_mleo_lcbt_mend_ahahahaha";
    level.var_fe9f3dc96b8294f4[ level.var_fe9f3dc96b8294f4.size ] = "dx_wc_mleo_lcbt_mend_hahahahaha";
    level.var_fe9f3dc96b8294f4[ level.var_fe9f3dc96b8294f4.size ] = "dx_wc_mleo_lcbt_mend_ahahahahaha";
    level.var_fe9f3dc96b8294f4[ level.var_fe9f3dc96b8294f4.size ] = "dx_wc_mleo_lcbt_mend_hehhehhehhehheh";
    level.var_fe9f3dc96b8294f4[ level.var_fe9f3dc96b8294f4.size ] = "dx_wc_mleo_lcbt_mend_hehhehhehhehhehheh";
    level.var_fe9f3dc96b8294f4[ level.var_fe9f3dc96b8294f4.size ] = "dx_wc_mleo_lcbt_mend_ohhohhohhahaha";
    level.var_fe9f3dc96b8294f4[ level.var_fe9f3dc96b8294f4.size ] = "dx_wc_mleo_lcbt_mend_ohhohhohhahahaha";
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0xf73ccd49, Offset: 0x35aa
// Size: 0xcd
function function_a641d59919b24d4d()
{
    if ( level.var_fe9f3dc96b8294f4.size < 1 )
    {
        function_53ad5f2b62284499();
    }
    
    if ( !utility::flag( "flag_played_first_menendez_cant_be_hurt_line" ) )
    {
        utility::flag_set( "flag_played_first_menendez_cant_be_hurt_line" );
        vo = level.var_fe9f3dc96b8294f4[ 0 ];
        level.var_fe9f3dc96b8294f4 = arrayremove( level.var_fe9f3dc96b8294f4, vo );
    }
    else
    {
        vo = utility::array_random( level.var_fe9f3dc96b8294f4 );
        level.var_fe9f3dc96b8294f4 = arrayremove( level.var_fe9f3dc96b8294f4, vo );
    }
    
    level.var_9e7341878cf5e3cc waittill( #"teleport_done" );
    
    if ( level.var_9e7341878cf5e3cc.summoning )
    {
        return;
    }
    
    level.var_9e7341878cf5e3cc dialogue::say( vo );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x13489bda, Offset: 0x367f
// Size: 0x110
function function_276cd63e44b103b2()
{
    level.var_a274327ad123708b = [];
    level.var_a274327ad123708b[ level.var_a274327ad123708b.size ] = "dx_wc_mleo_lcbt_mend_hahaha";
    level.var_a274327ad123708b[ level.var_a274327ad123708b.size ] = "dx_wc_mleo_lcbt_mend_ahahaha";
    level.var_a274327ad123708b[ level.var_a274327ad123708b.size ] = "dx_wc_mleo_lcbt_mend_hahahaha";
    level.var_a274327ad123708b[ level.var_a274327ad123708b.size ] = "dx_wc_mleo_lcbt_mend_ahahahaha";
    level.var_a274327ad123708b[ level.var_a274327ad123708b.size ] = "dx_wc_mleo_lcbt_mend_hahahahaha";
    level.var_a274327ad123708b[ level.var_a274327ad123708b.size ] = "dx_wc_mleo_lcbt_mend_ahahahahaha";
    level.var_a274327ad123708b[ level.var_a274327ad123708b.size ] = "dx_wc_mleo_lcbt_mend_hehhehhehhehheh";
    level.var_a274327ad123708b[ level.var_a274327ad123708b.size ] = "dx_wc_mleo_lcbt_mend_hehhehhehhehhehheh";
    level.var_a274327ad123708b[ level.var_a274327ad123708b.size ] = "dx_wc_mleo_lcbt_mend_ohhohhohhahaha";
    level.var_a274327ad123708b[ level.var_a274327ad123708b.size ] = "dx_wc_mleo_lcbt_mend_ohhohhohhahahaha";
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0xf8ee71c8, Offset: 0x3797
// Size: 0x73
function function_c832989d0bf1b212()
{
    if ( level.var_a274327ad123708b.size < 1 )
    {
        function_276cd63e44b103b2();
    }
    
    vo = utility::array_random( level.var_a274327ad123708b );
    level.var_a274327ad123708b = arrayremove( level.var_a274327ad123708b, vo );
    level.var_9e7341878cf5e3cc waittill( #"teleport_done" );
    level.var_9e7341878cf5e3cc dialogue::say( vo );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x5b432f8e, Offset: 0x3812
// Size: 0x110
function function_357d9a5c08dc58be()
{
    level.var_428861369ef3c321 = [];
    level.var_428861369ef3c321[ level.var_428861369ef3c321.size ] = "dx_wc_mleo_lcbt_mend_arisesoldiersitistim";
    level.var_428861369ef3c321[ level.var_428861369ef3c321.size ] = "dx_wc_mleo_lcbt_mend_iwillbringyousuchpai";
    level.var_428861369ef3c321[ level.var_428861369ef3c321.size ] = "dx_wc_mleo_lcbt_mend_thesemonstersfightfo";
    level.var_428861369ef3c321[ level.var_428861369ef3c321.size ] = "dx_wc_mleo_lcbt_mend_cometomeyoumonstrous";
    level.var_428861369ef3c321[ level.var_428861369ef3c321.size ] = "dx_wc_mleo_lcbt_mend_riseupanddomybidding";
    level.var_428861369ef3c321[ level.var_428861369ef3c321.size ] = "dx_wc_mleo_lcbt_mend_comecomeanddoyourblo";
    level.var_428861369ef3c321[ level.var_428861369ef3c321.size ] = "dx_wc_mleo_lcbt_mend_awakenandshedsomeblo";
    level.var_428861369ef3c321[ level.var_428861369ef3c321.size ] = "dx_wc_mleo_lcbt_mend_thatsitfightfightfor";
    level.var_428861369ef3c321[ level.var_428861369ef3c321.size ] = "dx_wc_mleo_lcbt_mend_youllneverleaveherea";
    level.var_428861369ef3c321[ level.var_428861369ef3c321.size ] = "dx_wc_mleo_lcbt_mend_myforcesareendless";
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0xc19664f8, Offset: 0x392a
// Size: 0xb5
function function_84f64aba9bceb39c()
{
    if ( level.var_428861369ef3c321.size < 1 )
    {
        function_357d9a5c08dc58be();
    }
    
    if ( !utility::flag( "flag_played_first_menendez_summoning_line" ) )
    {
        utility::flag_set( "flag_played_first_menendez_summoning_line" );
        vo = level.var_428861369ef3c321[ 0 ];
        level.var_428861369ef3c321 = arrayremove( level.var_428861369ef3c321, vo );
    }
    else
    {
        vo = utility::array_random( level.var_428861369ef3c321 );
        level.var_428861369ef3c321 = arrayremove( level.var_428861369ef3c321, vo );
    }
    
    level.var_9e7341878cf5e3cc dialogue::say( vo );
    level.var_9e7341878cf5e3cc notify( #"hash_7ddd46c98c8920a1" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x6b690e9a, Offset: 0x39e7
// Size: 0xa8
function function_24bc62d309c352e8()
{
    level.var_3b1fbdf7e84ead3 = [];
    level.var_3b1fbdf7e84ead3[ level.var_3b1fbdf7e84ead3.size ] = "dx_wc_mleo_lcbt_mend_bladesfalltotheearth";
    level.var_3b1fbdf7e84ead3[ level.var_3b1fbdf7e84ead3.size ] = "dx_wc_mleo_lcbt_mend_imgoingtocutyouthefu";
    level.var_3b1fbdf7e84ead3[ level.var_3b1fbdf7e84ead3.size ] = "dx_wc_mleo_lcbt_mend_youwillbeslicedtorib";
    level.var_3b1fbdf7e84ead3[ level.var_3b1fbdf7e84ead3.size ] = "dx_wc_mleo_lcbt_mend_iwillslityourgoddamn";
    level.var_3b1fbdf7e84ead3[ level.var_3b1fbdf7e84ead3.size ] = "dx_wc_mleo_lcbt_mend_fallfallnow";
    level.var_3b1fbdf7e84ead3[ level.var_3b1fbdf7e84ead3.size ] = "dx_wc_mleo_lcbt_mend_illsliceyoufromearto";
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x21fd6810, Offset: 0x3a97
// Size: 0xb5
function function_bafe23e84f513772()
{
    if ( level.var_3b1fbdf7e84ead3.size < 1 )
    {
        function_24bc62d309c352e8();
    }
    
    if ( !utility::flag( "flag_played_first_menendez_machete_line" ) )
    {
        utility::flag_set( "flag_played_first_menendez_machete_line" );
        vo = level.var_3b1fbdf7e84ead3[ 0 ];
        level.var_3b1fbdf7e84ead3 = arrayremove( level.var_3b1fbdf7e84ead3, vo );
    }
    else
    {
        vo = utility::array_random( level.var_3b1fbdf7e84ead3 );
        level.var_3b1fbdf7e84ead3 = arrayremove( level.var_3b1fbdf7e84ead3, vo );
    }
    
    level.var_9e7341878cf5e3cc dialogue::say( vo );
    level.var_9e7341878cf5e3cc notify( #"hash_7ddd46c98c8920a1" );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0xb5255388, Offset: 0x3b54
// Size: 0x9e
function function_810032fd4c26542c()
{
    if ( !isdefined( level.var_8d21d3de30793054 ) )
    {
        level.var_8d21d3de30793054 = 8;
    }
    
    if ( level.var_8d21d3de30793054 > 0 )
    {
        overlord::playconversation( "jungle_mansion_defend_ally_machete_" + level.var_8d21d3de30793054 );
        level.var_8d21d3de30793054--;
        wait 1;
    }
    
    if ( !isdefined( level.machete_line_num ) )
    {
        level.machete_line_num = 1;
    }
    
    overlord::playconversation( "jungle_mansion_defend_machetes_falling_" + level.machete_line_num );
    
    if ( level.machete_line_num > 4 )
    {
        level.machete_line_num = 1;
        return;
    }
    
    level.machete_line_num++;
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x3fa32aa0, Offset: 0x3bfa
// Size: 0x88
function function_a65dfef372c1f7be()
{
    level endon( #"hash_aab34fe95e899cdf" );
    
    while ( true )
    {
        level utility::flag_wait( "all_machetes_landed" );
        level utility::flag_clear( "all_machetes_landed" );
        overlord::playconversation( "jungle_mansion_defend_machete_pickup_nag_1" );
        level utility::flag_wait( "all_machetes_landed" );
        level utility::flag_clear( "all_machetes_landed" );
        overlord::playconversation( "jungle_mansion_defend_machete_pickup_nag_2" );
        level utility::flag_wait( "all_machetes_landed" );
        level utility::flag_clear( "all_machetes_landed" );
        overlord::playconversation( "jungle_mansion_defend_machete_pickup_nag_3" );
    }
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0xe2621eac, Offset: 0x3c8a
// Size: 0x55
function function_8c2446115a20c61f()
{
    level endon( #"player_used_machete" );
    nag = 1;
    
    while ( true )
    {
        level waittill( #"hash_aab34fe95e899cdf" );
        overlord::playconversation( "jungle_mansion_defend_machete_use_nag_" + nag );
        
        if ( nag > 5 )
        {
            nag = 1;
        }
        else
        {
            nag++;
        }
        
        wait 10;
    }
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x5602a46b, Offset: 0x3ce7
// Size: 0x8e
function function_94980c1bbf96a6bd()
{
    level.var_8e31e1aade8004e8 = [];
    level.var_8e31e1aade8004e8[ level.var_8e31e1aade8004e8.size ] = "dx_wc_mleo_lcbt_mend_imbaaack";
    level.var_8e31e1aade8004e8[ level.var_8e31e1aade8004e8.size ] = "dx_wc_mleo_lcbt_mend_cantgetridofmethatea";
    level.var_8e31e1aade8004e8[ level.var_8e31e1aade8004e8.size ] = "dx_wc_mleo_lcbt_mend_iwillalwayscomeback";
    level.var_8e31e1aade8004e8[ level.var_8e31e1aade8004e8.size ] = "dx_wc_mleo_lcbt_mend_illneverstaydead";
    level.var_8e31e1aade8004e8[ level.var_8e31e1aade8004e8.size ] = "dx_wc_mleo_lcbt_mend_asalwaysireturn";
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0xc8a9e79c, Offset: 0x3d7d
// Size: 0xd1
function function_a23c5819c07794c4()
{
    if ( !isdefined( level.hit_line_num ) )
    {
        level.hit_line_num = 1;
    }
    
    overlord::playconversation( "jungle_mansion_defend_menendez_hit_" + level.hit_line_num );
    thread function_8d316e797eb4240( level.hit_line_num );
    
    if ( level.hit_line_num > 4 )
    {
        level.hit_line_num = 1;
    }
    else
    {
        level.hit_line_num++;
    }
    
    level.var_9e7341878cf5e3cc waittill( #"teleport_done" );
    
    if ( level.var_8e31e1aade8004e8.size < 1 )
    {
        return;
    }
    
    vo = utility::array_random( level.var_8e31e1aade8004e8 );
    level.var_8e31e1aade8004e8 = arrayremove( level.var_8e31e1aade8004e8, vo );
    level.var_9e7341878cf5e3cc dialogue::say( vo );
}

// Namespace mp_sat_ob_leo_vo
// Params 1
// Checksum 0xc25e69b0, Offset: 0x3e56
// Size: 0x27
function function_8d316e797eb4240( var_bcef8c0fd0cddd5f )
{
    if ( var_bcef8c0fd0cddd5f > 4 )
    {
        return;
    }
    
    wait 1;
    overlord::playconversation( "jungle_mansion_defend_ally_reinforcement_" + var_bcef8c0fd0cddd5f );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x5ded2caf, Offset: 0x3e85
// Size: 0x3f
function function_1e0ad802a1e58250()
{
    if ( !isdefined( level.var_43643d2170c118c1 ) )
    {
        level.var_43643d2170c118c1 = 1;
    }
    
    if ( level.var_43643d2170c118c1 > 4 )
    {
        return;
    }
    
    overlord::playconversation( "jungle_mansion_defend_ally_missed_" + level.var_43643d2170c118c1 );
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0x9386bab4, Offset: 0x3ecc
// Size: 0x3a
function function_1d1ed620cc2b6a30()
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance childthread function_b690d0bbc0f6e7bb();
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0xc98957dc, Offset: 0x3f0e
// Size: 0xf
function function_b690d0bbc0f6e7bb()
{
    level utility::flag_set( "flag_jungle_escape_end_vo_complete" );
}

// Namespace mp_sat_ob_leo_vo
// Params 2
// Checksum 0xf533a9b0, Offset: 0x3f25
// Size: 0x89
function function_bff5063e5cb50c64( alias, var_e3f9bd1dd3e18f7f )
{
    if ( !isdefined( var_e3f9bd1dd3e18f7f ) )
    {
        source = level.players[ 0 ];
    }
    else
    {
        source = utility::getstruct( var_e3f9bd1dd3e18f7f );
    }
    
    if ( !isdefined( source ) )
    {
        /#
            iprintlnbold( "<dev string:x24>" + var_e3f9bd1dd3e18f7f );
        #/
        
        return;
    }
    
    ent = spawn( "script_origin", source.origin );
    ent dialogue::say( alias );
    ent thread cleanup_basic_line();
}

// Namespace mp_sat_ob_leo_vo
// Params 0
// Checksum 0xe899c427, Offset: 0x3fb6
// Size: 0x15
function cleanup_basic_line()
{
    while ( dialogue::is_speaking() )
    {
        waitframe();
    }
    
    self delete();
}

