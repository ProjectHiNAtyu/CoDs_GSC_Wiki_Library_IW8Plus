// scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_vo.gsc  (hash_74256c1eb0dd700f.gscc) (size: 28026 Bytes / 0x6d7a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x699250a9 (1771196585)
// size ...... 28026 (0x6d7a)
// includes .. 9   (offset: 0x5efa)
// strings ... 279 (offset: 0x5f42)
// dev strs .. 0   (offset: 0x6d7a)
// exports ... 135 (offset: 0x3f82)
// cseg ...... 0x1c90 + 0x22f2 (0x3f82)
// imports ... 58  (offset: 0x549a)
// animtree1 . 0   (offset: 0x6d7a)
// animtree2 . 0   (offset: 0x6d7a)
#using script_636bd827a012af12;
#using scripts\anim\dialogue;
#using scripts\common\ai\ai_utility;
#using scripts\common\ai\stealth\utility;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\waypoint_objective_handler;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_util;
#using scripts\mp\overlord;

#namespace mp_sat_ob_libra_vo;

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xf07a3ba1, Offset: 0x1cae
// Size: 0x14
function libra_infil()
{
    wait 2;
    overlord::function_be2d6dc71f97faa6( "libra_infil" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x1b405c2c, Offset: 0x1cca
// Size: 0xe
function infil_analysis_enemy_callout()
{
    overlord::playconversation( "infil_analysis_enemy_callout" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb7cb6e7e, Offset: 0x1ce0
// Size: 0x1d
function infil_analysis_enemy_falling_back()
{
    overlord::playconversation( "infil_analysis_enemy_falling_back" );
    wait 2;
    overlord::playconversation( "analysis_keep_pushing" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x4cfd7533, Offset: 0x1d05
// Size: 0x1c
function function_9f3e772fdda470fe()
{
    level utility::flag_wait_all( "flag_infil_analysis_guy_01_spawned", "flag_infil_analysis_guy_02_spawned" );
    level thread function_adeea487542f3762();
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xba82e5ae, Offset: 0x1d29
// Size: 0xde
function function_adeea487542f3762()
{
    level.infil_analysis_guy_01 endon( #"death" );
    level.infil_analysis_guy_02 endon( #"death" );
    level.infil_analysis_guy_01 endon( #"stop_conversation" );
    level.infil_analysis_guy_02 endon( #"stop_conversation" );
    level.infil_analysis_guy_01 thread function_46ce9803d147aa66();
    level.infil_analysis_guy_02 thread function_46ce9703d147a833();
    wait 3;
    level.infil_analysis_guy_01 dialogue::say( "dx_wc_ibra_anal_guie_thatswhatshewantsits" );
    wait 0.5;
    level.infil_analysis_guy_02 dialogue::say( "dx_wc_ibra_anal_guig_isshecrazyhowmanyuni" );
    wait 0.5;
    level.infil_analysis_guy_01 dialogue::say( "dx_wc_ibra_anal_guie_threehundredcratesto" );
    wait 0.5;
    level.infil_analysis_guy_02 dialogue::say( "dx_wc_ibra_anal_guig_sheiscrazyfineletsge" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xaf77aae2, Offset: 0x1e0f
// Size: 0xa1
function function_46ce9803d147aa66()
{
    utility::waittill_any( "stop_conversation", "stealth_curious", "death", "stealth_combat", "combat", "cover_blown", "event_combat", "investigate" );
    level utility::flag_set( "flag_analysis_alerted" );
    
    if ( isdefined( level.infil_analysis_guy_02 ) )
    {
        level.infil_analysis_guy_02 notify( #"stop_conversation" );
    }
    
    if ( isalive( self ) )
    {
        self endon( #"death" );
        self notify( #"stop_conversation" );
        dialogue::stop_all_dialogue();
        self stopsounds();
        dialogue::say( "dx_wc_ibra_anal_guie_huh" );
        utility::set_battlechatter( 1 );
    }
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x84c58801, Offset: 0x1eb8
// Size: 0xa1
function function_46ce9703d147a833()
{
    utility::waittill_any( "stop_conversation", "stealth_curious", "death", "stealth_combat", "combat", "cover_blown", "event_combat", "investigate" );
    level utility::flag_set( "flag_analysis_alerted" );
    
    if ( isdefined( level.infil_analysis_guy_01 ) )
    {
        level.infil_analysis_guy_01 notify( #"stop_conversation" );
    }
    
    if ( isalive( self ) )
    {
        self endon( #"death" );
        self notify( #"stop_conversation" );
        dialogue::stop_all_dialogue();
        self stopsounds();
        dialogue::say( "dx_wc_ibra_anal_guig_guardsguards" );
        utility::set_battlechatter( 1 );
    }
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x234c35e4, Offset: 0x1f61
// Size: 0x98
function analysis_pa()
{
    level utility::flag_wait( "flag_analysis_alerted" );
    
    if ( isalive( level.infil_analysis_guy_01 ) )
    {
        level.infil_analysis_guy_01 utility::function_227c1c2c6c7ebd6a( "combat" );
    }
    
    if ( isalive( level.infil_analysis_guy_02 ) )
    {
        level.infil_analysis_guy_02 utility::function_227c1c2c6c7ebd6a( "combat" );
    }
    
    wait 2;
    apositions = utility::getstructarray( "analysis_pa_org" );
    function_141bf08d084d7caf( apositions, "dx_wc_ibra_anal_gpa1_dangerthreatdetected" );
    wait 4;
    function_141bf08d084d7caf( apositions, "dx_wc_ibra_anal_gpa1_emergencyprotocoleng" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x2217548b, Offset: 0x2001
// Size: 0x34
function infil_data_center()
{
    level utility::flag_wait( "flag_analysis_entry_vo" );
    overlord::playconversation( "infil_data_center" );
    level utility::flag_set( "flag_infil_data_center_done" );
    ob_story_mission_utils::objective_text_show( "ob_libra_infil_analysis_investigate" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xa940c448, Offset: 0x203d
// Size: 0x1b
function storage_intro()
{
    overlord::playconversation( "storage_intro" );
    level utility::flag_set( "flag_storage_intro_done" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x9b97cc, Offset: 0x2060
// Size: 0x5d
function function_1ace583b05093a83()
{
    level.var_ad944ad4f49676f4 endon( #"death" );
    level.var_ad944dd4f4967d8d endon( #"death" );
    wait 2;
    level.var_ad944ad4f49676f4 dialogue::say( "dx_wc_ibra_anal_guif_itsthem" );
    wait 0.5;
    level.var_ad944dd4f4967d8d dialogue::say( "dx_wc_ibra_anal_guif_sealtheroom" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x7426827f, Offset: 0x20c5
// Size: 0x1b
function storage_other_control_room()
{
    overlord::playevent( "libra_storage_other_control_room", level.players, undefined, undefined, 1 );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb97e772f, Offset: 0x20e8
// Size: 0x1b
function storage_combat_mop_them_up()
{
    overlord::playevent( "storage_combat_mop_them_up", level.players, undefined, undefined, 1 );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x4ebc2951, Offset: 0x210b
// Size: 0x2e
function storage_combat_clear()
{
    wait 1;
    overlord::playevent( "storage_combat_clear", level.players, undefined, undefined, 1 );
    level utility::flag_set( "flag_storage_combat_clear_done" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x1b405c2c, Offset: 0x2141
// Size: 0xe
function storage_exit()
{
    overlord::playconversation( "storage_exit" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb97e772f, Offset: 0x2157
// Size: 0x1b
function storage_shut_down_robotic_lines()
{
    overlord::playevent( "storage_shut_down_robotic_lines", level.players, undefined, undefined, 1 );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x37ad86f, Offset: 0x217a
// Size: 0x37
function storage_one_line_disabled()
{
    overlord::playevent( "storage_one_line_disabled", level.players, undefined, undefined, 1 );
    wait 1;
    overlord::playevent( "libra_storage_other_control_room", level.players, undefined, undefined, 1 );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb97e772f, Offset: 0x21b9
// Size: 0x1b
function storage_one_more_left()
{
    overlord::playevent( "storage_one_more_left", level.players, undefined, undefined, 1 );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb9444e7d, Offset: 0x21dc
// Size: 0x28
function storage_all_lines_disabled()
{
    overlord::playevent( "storage_all_lines_disabled", level.players, undefined, undefined, 1 );
    level utility::flag_set( "flag_storage_all_lines_disabled_done" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x1b405c2c, Offset: 0x220c
// Size: 0xe
function storage_end_karma_update()
{
    overlord::playconversation( "storage_end_karma_update" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x978573c4, Offset: 0x2222
// Size: 0x2b
function storage_end_hallucination()
{
    if ( !level utility::flag( "flag_storage_end_hallucination_vo_played" ) )
    {
        level utility::flag_set( "flag_storage_end_hallucination_vo_played" );
        overlord::playconversation( "storage_end_hallucination" );
    }
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x89bbe514, Offset: 0x2255
// Size: 0x14
function function_fcdbcf5317d4606c()
{
    wait 1;
    overlord::playconversation( "armor_upgrade_3" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xfa6ec788, Offset: 0x2271
// Size: 0x33
function packing_intro_contact_weapons_free()
{
    level utility::flag_wait( "flag_spawn_packing_room_1" );
    wait 1.5;
    overlord::playconversation( "packing_intro_contact" );
    wait 0.5;
    overlord::playconversation( "packing_intro_weapons_free" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x126bd399, Offset: 0x22ac
// Size: 0x149
function packing_intro_enemy_conversation()
{
    level.packing_intro_enemy_01 endon( #"death" );
    level.packing_intro_enemy_02 endon( #"death" );
    level.packing_intro_enemy_01 endon( #"stop_conversation" );
    level.packing_intro_enemy_02 endon( #"stop_conversation" );
    level.var_d5bd0c331c36de44 = [ "stop_conversation", "new_enemy", "damage", "ally_damaged", "bulletwhizby", "grenade_danger", "explosion", "gunshot", "gunshot_impact", "stealth_curious", "death", "stealth_combat", "combat", "cover_blown", "event_combat", "investigate" ];
    level.packing_intro_enemy_01 thread function_e2db08aa28ffe747();
    level.packing_intro_enemy_02 thread function_e2db09aa28ffe97a();
    level utility::flag_wait( "flag_packing_entrance_door_opened" );
    level.packing_intro_enemy_02 dialogue::say( "dx_wc_ibra_anal_guia_whatdoyoumeanstayher" );
    wait 0.5;
    level.packing_intro_enemy_01 dialogue::say( "dx_wc_ibra_anal_guig_youwanttofacethemorf" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xab84f72b, Offset: 0x23fd
// Size: 0x10a
function function_e2db08aa28ffe747()
{
    level utility::flag_wait( "flag_packing_entrance_door_opened" );
    utility::waittill_any_in_array( level.var_d5bd0c331c36de44 );
    
    if ( isdefined( level.packing_intro_enemy_02 ) )
    {
        level.packing_intro_enemy_02 notify( #"stop_conversation" );
    }
    
    if ( isalive( self ) )
    {
        self endon( #"death" );
        self notify( #"stop_conversation" );
        self.scene_root scene::stop();
        self stopanimscripted();
        self notify( #"stop_loop" );
        self notify( #"stop_animmode" );
        self setgoalpos( self.origin );
        self.newenemyreaction = 1;
        self.forcenewenemyreaction = 1;
        self.dodangerreact = 1;
        self.dangerreactduration = 3000;
        dialogue::stop_all_dialogue();
        self stopsounds();
        level utility::delaythread( 0.5, &utility::flag_set, "flag_spawn_packing_room_1" );
        dialogue::say( "dx_wc_ibra_anal_guia_theyrehere" );
        utility::set_battlechatter( 1 );
        thread ai_utility::go_to_node();
    }
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x9804db6e, Offset: 0x250f
// Size: 0x110
function function_e2db09aa28ffe97a()
{
    level utility::flag_wait( "flag_packing_entrance_door_opened" );
    utility::waittill_any_in_array( level.var_d5bd0c331c36de44 );
    
    if ( isdefined( level.packing_intro_enemy_01 ) )
    {
        level.packing_intro_enemy_01 notify( #"stop_conversation" );
    }
    
    if ( isalive( self ) )
    {
        self endon( #"death" );
        self notify( #"stop_conversation" );
        self.scene_root scene::stop();
        self stopanimscripted();
        self notify( #"stop_loop" );
        self notify( #"stop_animmode" );
        self setgoalpos( self.origin );
        self.newenemyreaction = 1;
        self.forcenewenemyreaction = 1;
        self.dodangerreact = 1;
        self.dangerreactduration = 2000;
        dialogue::stop_all_dialogue();
        self stopsounds();
        level utility::delaythread( 0.5, &utility::flag_set, "flag_spawn_packing_room_1" );
        wait 1;
        dialogue::say( "dx_wc_ibra_anal_guig_theyllruineverything" );
        utility::set_battlechatter( 1 );
        thread ai_utility::go_to_node();
    }
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x7bd19ce3, Offset: 0x2627
// Size: 0x1b
function robotic_arm_callout()
{
    overlord::playconversation( "robotic_arm_callout" );
    level utility::flag_set( "flag_robotic_arm_callout_done" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb07e4cf3, Offset: 0x264a
// Size: 0x1b
function robotic_arm_upper_complete()
{
    overlord::playconversation( "robotic_arm_upper_complete" );
    level utility::flag_set( "flag_robotic_arm_upper_complete_done" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xe286678e, Offset: 0x266d
// Size: 0x1b
function robotic_arm_second_callout()
{
    overlord::playconversation( "robotic_arm_second_callout" );
    level utility::flag_set( "flag_robotic_arm_second_callout_done" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xcca66c98, Offset: 0x2690
// Size: 0x20
function one_module_left()
{
    level utility::flag_wait_any( "flag_packing_robotic_arms_group_02_group_destroyed", "flag_packing_robotic_arms_group_03_group_destroyed" );
    overlord::playconversation( "one_module_left" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x3a265158, Offset: 0x26b8
// Size: 0x19c
function function_63b3f54e8edb4941()
{
    msg = level utility::flag_wait_any_return( "flag_all_robotic_packing_modules_destroyed", "flag_packing_2_combat_done" );
    
    if ( msg == "flag_all_robotic_packing_modules_destroyed" )
    {
        overlord::playevent( "robotic_arms_destroyed", level.players, undefined, undefined, 1 );
        wait 0.5;
        
        if ( !level utility::flag( "flag_packing_2_combat_done" ) )
        {
            overlord::playevent( "good_work_finish_guild", level.players, undefined, undefined, 1 );
            ob_story_mission_utils::objective_text_show( "ob_libra_infil_storage_clean_up" );
            level utility::flag_wait( "flag_packing_2_combat_done" );
            wait 0.5;
            overlord::playevent( "packing_area_clear", level.players, undefined, undefined, 1 );
            ob_story_mission_utils::objective_text_show( "ob_libra_infil_analysis_investigate" );
        }
        else
        {
            overlord::playevent( "packing_area_clear", level.players, undefined, undefined, 1 );
            ob_story_mission_utils::objective_text_show( "ob_libra_infil_analysis_investigate" );
        }
    }
    else
    {
        overlord::playevent( "packing_area_clear", level.players, undefined, undefined, 1 );
        wait 0.5;
        
        if ( !level utility::flag( "flag_all_robotic_packing_modules_destroyed" ) )
        {
            level utility::flag_wait( "flag_all_robotic_packing_modules_destroyed" );
            wait 0.5;
            overlord::playevent( "robotic_arms_destroyed", level.players, undefined, undefined, 1 );
            ob_story_mission_utils::objective_text_show( "ob_libra_infil_analysis_investigate" );
        }
        else
        {
            overlord::playevent( "robotic_arms_destroyed", level.players, undefined, undefined, 1 );
            ob_story_mission_utils::objective_text_show( "ob_libra_infil_analysis_investigate" );
        }
    }
    
    wait 0.5;
    overlord::playevent( "packing_nice_work", level.players, undefined, undefined, 1 );
    level utility::flag_set( "flag_packing_nice_work_done" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xbc772531, Offset: 0x285c
// Size: 0x4d
function function_18a76214127aea90()
{
    level waittill( #"vo_karma_patchmein" );
    overlord::function_be2d6dc71f97faa6( "vo_karma_patchmein" );
    level waittill( #"vo_karma_alot" );
    overlord::function_be2d6dc71f97faa6( "vo_karma_alot" );
    level waittill( #"vo_karma_bioreactor" );
    overlord::function_be2d6dc71f97faa6( "vo_karma_bioreactor" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xe7d1bc90, Offset: 0x28b1
// Size: 0x2e
function ambush_intro()
{
    wait 1;
    level utility::flag_set( "flag_ambush_intro_vo_start" );
    overlord::playconversation( "ambush_intro" );
    level utility::flag_set( "flag_ambush_intro_vo_done" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x2d9571e2, Offset: 0x28e7
// Size: 0x4d
function ambush_kagan()
{
    level utility::flag_wait( "flag_ambush_guild_bots_incoming_vo_done" );
    wait 1;
    overlord::playconversation( "ambush_need_an_exit_new" );
    level utility::flag_set( "flag_ambush_new_exit" );
    wait 2;
    overlord::playconversation( "ambush_kagan" );
    level utility::flag_set( "flag_ambush_kagan_done" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x9e7c8a8, Offset: 0x293c
// Size: 0x59
function function_21fdf872c3bfa9e2()
{
    overlord::playconversation( "ambush_feels_like_a_trap" );
    level utility::flag_set( "flag_activate_ambush_gas" );
    wait 1;
    overlord::playconversation( "ambush_definitely_a_trap" );
    level utility::flag_set( "ff_intro_vo_done" );
    wait 0.5;
    overlord::playconversation( "ff_everywhere" );
    level utility::flag_set( "flag_ff_everywhere_vo_done" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xfb60366b, Offset: 0x299d
// Size: 0x20
function ambush_ff_hint()
{
    level utility::flag_wait_all( "flag_ambush_kagan_done", "flag_ambush_ff_powersource_hint" );
    overlord::playconversation( "ff_powersource_hint" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xd26279c0, Offset: 0x29c5
// Size: 0x46
function ambush_guild_bots_incoming()
{
    apositions = utility::getstructarray( "ambush_intro_pa_org" );
    function_141bf08d084d7caf( apositions, "dx_wc_ibra_prep_gpa1_emergencyprotocoleng" );
    wait 4;
    overlord::playconversation( "ambush_guild_bots_incoming" );
    level utility::flag_set( "flag_ambush_guild_bots_incoming_vo_done" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x52c91b4f, Offset: 0x2a13
// Size: 0x1b
function ambush_kagan_taunt_01()
{
    level utility::flag_wait( "flag_ambush_kagan_taunt_01" );
    overlord::playconversation( "ambush_kagan_taunt_01" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xcbc04af5, Offset: 0x2a36
// Size: 0x1b
function ambush_kagan_taunt_02()
{
    level utility::flag_wait( "flag_ambush_kagan_taunt_02" );
    overlord::playconversation( "ambush_kagan_taunt_02" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xf07120b9, Offset: 0x2a59
// Size: 0x7d
function ambush_final_ff_hint()
{
    level endon( #"flag_ambush_exit_accessible" );
    level utility::flag_wait( "flag_ambush_final_ff_hint" );
    overlord::playconversation( "ambush_final_ff_hint_01" );
    wait 8;
    overlord::playconversation( "ambush_final_ff_hint_02" );
    level notify( #"end_ambush_exit_access_waypoint_org_canceler" );
    level thread waypoint_objective_handler::waypoint_objective_handler_cancel( "ambush_exit_access_waypoint_org" );
    level thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "ambush_final_ff_hint_waypoint_org", undefined, "ambush_final_ff_hint_waypoint_org_waypoint_done", undefined, undefined, 1, 0 );
    level thread mp_sat_ob_libra_util::function_776ea74dd9e92d46( "flag_ambush_exit_accessible", "ambush_final_ff_hint_waypoint_org" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x1b405c2c, Offset: 0x2ade
// Size: 0xe
function ambush_exit_intro()
{
    overlord::playconversation( "ambush_exit_intro" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x1b405c2c, Offset: 0x2af4
// Size: 0xe
function ambush_exit_outro()
{
    overlord::playconversation( "ambush_exit_outro" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xfe7218f7, Offset: 0x2b0a
// Size: 0x28
function ambush_exit_tunnel()
{
    level utility::flag_wait( "flag_ambush_exit_tunnel_vo" );
    overlord::playconversation( "ambush_exit_tunnel" );
    level utility::flag_set( "flag_ambush_exit_tunnel_vo_done" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xba93a31, Offset: 0x2b3a
// Size: 0x20
function armory_prepare()
{
    level utility::flag_wait_all( "flag_ambush_exit_tunnel_vo_done", "flag_armory_entered" );
    overlord::playconversation( "armory_prepare" );
}

// Namespace mp_sat_ob_libra_vo
// Params 1
// Checksum 0xab587f56, Offset: 0x2b62
// Size: 0x18
function armory_access_denied( position )
{
    playsoundatpos( position, "dx_wc_ibra_prep_gpa1_accessdenied" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x57d77d42, Offset: 0x2b82
// Size: 0x1f
function function_7d261949ca5c976c()
{
    playsoundatpos( level.mech_activation_button.origin, "dx_wc_ibra_prep_gpa1_mechdiagnosticcontro_01" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xa80573f3, Offset: 0x2ba9
// Size: 0x31
function armory_to_processing_intro()
{
    if ( !level utility::flag( "flag_armory_to_processing_intro_played" ) )
    {
        wait 1;
        overlord::playconversation( "armory_to_processing_intro" );
        level utility::flag_set( "flag_armory_to_processing_intro_played" );
    }
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x946f2ed2, Offset: 0x2be2
// Size: 0x1b
function armory_prepare_mech_online()
{
    level utility::flag_wait( "flag_armory_to_processing_intro_played" );
    overlord::playconversation( "armory_prepare_mech_online" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xda4e5de8, Offset: 0x2c05
// Size: 0x48
function fire_at_the_door()
{
    if ( level utility::flag( "flag_armory_to_processing_door_destroyed" ) )
    {
        return;
    }
    
    if ( !level utility::flag( "flag_fire_at_the_door_played" ) )
    {
        level utility::flag_set( "flag_fire_at_the_door_played" );
        overlord::playevent( "fire_at_the_door", level.players, undefined, undefined, 1 );
    }
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x89ddab1c, Offset: 0x2c55
// Size: 0x57
function bring_the_heat()
{
    if ( level utility::flag( "flag_armory_to_processing_door_destroyed" ) )
    {
        return;
    }
    
    if ( level utility::flag( "flag_fire_at_the_door_played" ) )
    {
        if ( !level utility::flag( "flag_bring_the_heat_played" ) )
        {
            level utility::flag_set( "flag_bring_the_heat_played" );
            overlord::playevent( "bring_the_heat", level.players, undefined, undefined, 1 );
        }
    }
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xda4e5de8, Offset: 0x2cb4
// Size: 0x48
function wrong_door()
{
    if ( level utility::flag( "flag_armory_to_processing_door_destroyed" ) )
    {
        return;
    }
    
    if ( !level utility::flag( "flag_wrong_door_played" ) )
    {
        level utility::flag_set( "flag_wrong_door_played" );
        overlord::playevent( "wrong_door", level.players, undefined, undefined, 1 );
    }
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x9e62b463, Offset: 0x2d04
// Size: 0x1d
function function_7ff852a04609d104()
{
    if ( level utility::flag( "flag_armory_to_processing_intro_played" ) )
    {
        overlord::playconversation( "armory_prepare_door_open" );
    }
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x9a815f8e, Offset: 0x2d29
// Size: 0x48
function function_2ccb8eb3d3d3a28b()
{
    level utility::flag_wait( "flag_armory_to_processing_door_destroyed" );
    apositions = utility::getstructarray( "armory_pa_position" );
    function_141bf08d084d7caf( apositions, "dx_wc_ibra_prep_gpa1_emergencyprotocoleng" );
    wait 3;
    function_141bf08d084d7caf( apositions, "dx_wc_ibra_prep_gpa1_attackattackattack" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x1b405c2c, Offset: 0x2d79
// Size: 0xe
function last_of_them()
{
    overlord::playconversation( "last_of_them" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xab315755, Offset: 0x2d8f
// Size: 0x1b
function armory_prepare_checkin()
{
    level utility::flag_wait( "flag_armory_prepare_lab_checkin" );
    overlord::playconversation( "armory_prepare_outro" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x771d6375, Offset: 0x2db2
// Size: 0x4f
function function_f89e87cea1bfa588()
{
    apositions = utility::getstructarray( "backtrack_pa_position" );
    level waittill( #"pa_vo_caution" );
    function_141bf08d084d7caf( apositions, "dx_wc_ibra_proc_gpa1_caution" );
    level waittill( #"pa_vo_standclear" );
    function_141bf08d084d7caf( apositions, "dx_wc_ibra_proc_gpa1_standclearofbaydoors" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x1b405c2c, Offset: 0x2e09
// Size: 0xe
function processing_enemies_enter()
{
    overlord::playconversation( "processing_enemies_enter" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb97e772f, Offset: 0x2e1f
// Size: 0x1b
function karma_door_hatch_intro()
{
    overlord::playevent( "karma_door_hatch_intro", level.players, undefined, undefined, 1 );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xd92983a2, Offset: 0x2e42
// Size: 0xe
function get_the_hatch_open()
{
    overlord::playconversation( "processing_doors_intro" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb07a3b96, Offset: 0x2e58
// Size: 0xe
function last_chance_walk_away()
{
    overlord::function_be2d6dc71f97faa6( "last_chance_walk_away" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb07a3b96, Offset: 0x2e6e
// Size: 0xe
function set_up_a_perimeter()
{
    overlord::function_be2d6dc71f97faa6( "set_up_a_perimeter" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb07a3b96, Offset: 0x2e84
// Size: 0xe
function someone_get_the_hatch_open()
{
    overlord::function_be2d6dc71f97faa6( "someone_get_the_hatch_open" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb07a3b96, Offset: 0x2e9a
// Size: 0xe
function open_the_hatch()
{
    overlord::function_be2d6dc71f97faa6( "open_the_hatch" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb07a3b96, Offset: 0x2eb0
// Size: 0xe
function just_walk_away()
{
    overlord::function_be2d6dc71f97faa6( "just_walk_away" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb07a3b96, Offset: 0x2ec6
// Size: 0xe
function doesnt_have_to_end_like_this()
{
    overlord::function_be2d6dc71f97faa6( "doesnt_have_to_end_like_this" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x307537e3, Offset: 0x2edc
// Size: 0xe
function function_d01c999544f8769b()
{
    overlord::playconversation( "processing_hatch_stopped1" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x307537e3, Offset: 0x2ef2
// Size: 0xe
function function_d01c9a9544f878ce()
{
    overlord::playconversation( "processing_hatch_stopped2" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb07a3b96, Offset: 0x2f08
// Size: 0xe
function open_the_hatch_nag_1()
{
    overlord::function_be2d6dc71f97faa6( "open_the_hatch_nag_1" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb07a3b96, Offset: 0x2f1e
// Size: 0xe
function open_the_hatch_nag_2()
{
    overlord::function_be2d6dc71f97faa6( "open_the_hatch_nag_2" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb07a3b96, Offset: 0x2f34
// Size: 0xe
function one_side_is_open()
{
    overlord::function_be2d6dc71f97faa6( "one_side_is_open" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb07a3b96, Offset: 0x2f4a
// Size: 0xe
function one_side_needs_attention()
{
    overlord::function_be2d6dc71f97faa6( "one_side_needs_attention" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb07a3b96, Offset: 0x2f60
// Size: 0xe
function one_side_stopped()
{
    overlord::function_be2d6dc71f97faa6( "one_side_stopped" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb07a3b96, Offset: 0x2f76
// Size: 0xe
function both_sides_stopped()
{
    overlord::function_be2d6dc71f97faa6( "both_sides_stopped" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb07a3b96, Offset: 0x2f8c
// Size: 0xe
function get_both_opening()
{
    overlord::function_be2d6dc71f97faa6( "get_both_opening" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x1b405c2c, Offset: 0x2fa2
// Size: 0xe
function processing_doors_done()
{
    overlord::playconversation( "processing_doors_done" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x1b405c2c, Offset: 0x2fb8
// Size: 0xe
function processing_lift_intro()
{
    overlord::playconversation( "processing_lift_intro" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb07a3b96, Offset: 0x2fce
// Size: 0xe
function raise_the_bioreactor_initial_nag()
{
    overlord::function_be2d6dc71f97faa6( "raise_the_bioreactor_initial_nag" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb7cfa187, Offset: 0x2fe4
// Size: 0xe
function raise_the_bioreactor_initial_press()
{
    overlord::function_be2d6dc71f97faa6( "its_working" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x1b405c2c, Offset: 0x2ffa
// Size: 0xe
function raise_the_bioreactor_fakeout()
{
    overlord::playconversation( "raise_the_bioreactor_fakeout" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x1b405c2c, Offset: 0x3010
// Size: 0xe
function raise_the_bioreactor_fakeout2()
{
    overlord::playconversation( "raise_the_bioreactor_fakeout2" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x9cd0ffc, Offset: 0x3026
// Size: 0x1b
function function_5f84a16cb0dd4025()
{
    level waittill( #"sphere_dropping" );
    overlord::playconversation( "bioreactor_dropping" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb07a3b96, Offset: 0x3049
// Size: 0xe
function someone_get_on_a_wheel()
{
    overlord::function_be2d6dc71f97faa6( "someone_get_on_a_wheel" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x1b405c2c, Offset: 0x305f
// Size: 0xe
function bioreactor_raised()
{
    overlord::playconversation( "bioreactor_raised" );
}

// Namespace mp_sat_ob_libra_vo
// Params 1
// Checksum 0x304cc993, Offset: 0x3075
// Size: 0x116
function bioreactor_wheel_nag( dropping = 0 )
{
    wheel_nags = [ "bioreactor_wheel_nag1", "bioreactor_wheel_nag2", "bioreactor_wheel_nag3", "bioreactor_wheel_nag4" ];
    dropping_nags = [ "bioreactor_dropping_wheel_nag1", "bioreactor_dropping_wheel_nag2", "bioreactor_dropping_wheel_nag3", "bioreactor_dropping_wheel_nag4" ];
    
    if ( !isdefined( level.var_3eced10f7fd20dff ) )
    {
        level.var_3cbbf0b3b728123f = 0;
    }
    
    if ( !isdefined( level.var_b53b97a18337a9c3 ) )
    {
        level.var_b53b97a18337a9c3 = 0;
    }
    
    if ( level.var_3eced10f7fd20dff > wheel_nags.size )
    {
        level.var_3eced10f7fd20dff = 0;
    }
    
    if ( level.var_b53b97a18337a9c3 > dropping_nags.size )
    {
        level.var_b53b97a18337a9c3 = 0;
    }
    
    if ( dropping )
    {
        overlord::function_be2d6dc71f97faa6( dropping_nags[ level.var_b53b97a18337a9c3 ] );
        level.var_b53b97a18337a9c3++;
        return;
    }
    
    overlord::function_be2d6dc71f97faa6( wheel_nags[ level.var_b53b97a18337a9c3 ] );
    level.var_b53b97a18337a9c3++;
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x1b405c2c, Offset: 0x3193
// Size: 0xe
function pump_intro()
{
    overlord::playconversation( "pump_intro" );
}

// Namespace mp_sat_ob_libra_vo
// Params 1
// Checksum 0xb918132b, Offset: 0x31a9
// Size: 0x43
function function_8947cee07a7554a2( flagname )
{
    nags = [ "terminal_nag_1", "terminal_nag_2", "terminal_nag_3" ];
    function_a42a4ebb7fd9eb2( nags, flagname, 6, 24, 0 );
}

// Namespace mp_sat_ob_libra_vo
// Params 1
// Checksum 0x9ad7710f, Offset: 0x31f4
// Size: 0x2c
function hack_nags( flagname )
{
    nags = [ "terminal_hack_nag_1" ];
    function_a42a4ebb7fd9eb2( nags, flagname );
}

// Namespace mp_sat_ob_libra_vo
// Params 1
// Checksum 0x11babd94, Offset: 0x3228
// Size: 0x3e
function function_6eef5d7f759f2d0f( flagname )
{
    nags = [ "terminal_nag_50_1", "terminal_nag_50_2", "terminal_nag_50_3" ];
    function_a42a4ebb7fd9eb2( nags, flagname );
}

// Namespace mp_sat_ob_libra_vo
// Params 1
// Checksum 0xb0c80aad, Offset: 0x326e
// Size: 0x47
function function_4b06d8d9452f636d( flagname )
{
    nags = [ "terminal_nag_75_1", "terminal_nag_75_2", "terminal_nag_75_3", "terminal_nag_final" ];
    function_a42a4ebb7fd9eb2( nags, flagname );
}

// Namespace mp_sat_ob_libra_vo
// Params 1
// Checksum 0x989187df, Offset: 0x32bd
// Size: 0x2c
function function_7bef0b49cdca7ab3( flagname )
{
    nags = [ "terminal_nag_50_1" ];
    function_a42a4ebb7fd9eb2( nags, flagname );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x1c30106a, Offset: 0x32f1
// Size: 0x2c
function hack_intro()
{
    level notify( #"audio_hack_intro" );
    overlord::playconversation( "hack_intro" );
    thread overlord::playconversation( "hack_intro2" );
    wait 0.5;
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb07a3b96, Offset: 0x3325
// Size: 0xe
function we_are_in()
{
    overlord::function_be2d6dc71f97faa6( "we_are_in" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb07a3b96, Offset: 0x333b
// Size: 0xe
function pressure_systems_disabled()
{
    overlord::function_be2d6dc71f97faa6( "pressure_systems_disabled" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb07a3b96, Offset: 0x3351
// Size: 0xe
function starting_to_heat_up()
{
    overlord::function_be2d6dc71f97faa6( "starting_to_heat_up" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x28568d47, Offset: 0x3367
// Size: 0x18
function pressure_25()
{
    overlord::playconversation( "pressure_25" );
    wait 2;
    releasing_the_pressure();
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb07a3b96, Offset: 0x3387
// Size: 0xe
function releasing_the_pressure()
{
    overlord::function_be2d6dc71f97faa6( "releasing_the_pressure" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xc08639be, Offset: 0x339d
// Size: 0x18
function pressure_50()
{
    overlord::playconversation( "pressure_50" );
    wait 2;
    interfering_with_the_pressure();
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb07a3b96, Offset: 0x33bd
// Size: 0xe
function interfering_with_the_pressure()
{
    overlord::function_be2d6dc71f97faa6( "interfering_with_the_pressure" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb07a3b96, Offset: 0x33d3
// Size: 0xe
function pressure_rising_again()
{
    overlord::function_be2d6dc71f97faa6( "pressure_rising_again" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xc08639be, Offset: 0x33e9
// Size: 0x18
function pressure_75()
{
    overlord::playconversation( "pressure_75" );
    wait 2;
    interfering_with_the_pressure();
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x1b405c2c, Offset: 0x3409
// Size: 0xe
function restart_pressure_initial()
{
    overlord::playconversation( "restart_pressure_initial" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb07a3b96, Offset: 0x341f
// Size: 0xe
function pressure_less_than_50_restart_it()
{
    overlord::function_be2d6dc71f97faa6( "pressure_less_than_50_restart_it" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb07a3b96, Offset: 0x3435
// Size: 0xe
function pressure_between_50_and_75_restart_it()
{
    overlord::function_be2d6dc71f97faa6( "pressure_between_50_and_75_restart_it" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb07a3b96, Offset: 0x344b
// Size: 0xe
function pressure_between_75_and_90_restart_it()
{
    overlord::function_be2d6dc71f97faa6( "pressure_between_75_and_90_restart_it" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb07a3b96, Offset: 0x3461
// Size: 0xe
function pressure_between_90_and_100_restart_it()
{
    overlord::function_be2d6dc71f97faa6( "pressure_between_90_and_100_restart_it" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x1b405c2c, Offset: 0x3477
// Size: 0xe
function pressure_critical()
{
    overlord::playconversation( "pressure_critical" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x86fe7718, Offset: 0x348d
// Size: 0x21
function backtrack_taunt()
{
    wait 1;
    overlord::playevent( "backtrack_taunt", level.players, undefined, undefined, 1 );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xb97e772f, Offset: 0x34b6
// Size: 0x1b
function backtrack_everyone_out()
{
    overlord::playevent( "backtrack_everyone_out", level.players, undefined, undefined, 1 );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x28c9a382, Offset: 0x34d9
// Size: 0x4a
function function_ae9d00c72f92ab8d()
{
    utility::flag_wait( "flag_backtrack_dont_stop" );
    overlord::function_be2d6dc71f97faa6( "backtrack_dont_stop" );
    utility::flag_wait( "flag_backtrack_keep_moving" );
    overlord::function_be2d6dc71f97faa6( "backtrack_keep_moving" );
    utility::flag_wait( "flag_backtrack_final_stretch" );
    overlord::playconversation( "backtrack_final_stretch" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x6f0caed5, Offset: 0x352b
// Size: 0xa8
function function_797b343d16462f92()
{
    level endon( #"flag_backtrack_done" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    wait 1;
    apositions = utility::getstructarray( "backtrack_pa_position" );
    
    if ( isdefined( apositions ) )
    {
        backtrack_everyone_out();
        level thread function_ae9d00c72f92ab8d();
        wait 1;
        function_141bf08d084d7caf( apositions, "dx_wc_ibra_back_gpa1_danger" );
        wait 1.25;
        function_141bf08d084d7caf( apositions, "dx_wc_ibra_back_gpa1_systemfailureimminen" );
        wait 8;
        function_141bf08d084d7caf( apositions, "dx_wc_ibra_back_gpa1_warning" );
        wait 8;
        function_141bf08d084d7caf( apositions, "dx_wc_ibra_back_gpa1_evacuateimmediately" );
    }
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xd23224d0, Offset: 0x35db
// Size: 0x12b
function function_1055913c2de99997()
{
    level endon( #"hash_9a5dcc9c994ec18b" );
    level endon( #"flag_escape_done" );
    apositions = utility::getstructarray( "escape_pa_position" );
    waitframe();
    
    if ( isdefined( apositions ) )
    {
        if ( !isdefined( level.var_501353d53c9fee5a ) )
        {
            level.var_501353d53c9fee5a = [];
            
            foreach ( position in apositions )
            {
                ent = position utility::spawn_script_origin();
                level.var_501353d53c9fee5a[ level.var_501353d53c9fee5a.size ] = ent;
            }
        }
        
        function_141bf08d084d7caf( level.var_501353d53c9fee5a, "dx_wc_ibra_back_gpa1_systemfailureimminen" );
        wait 5;
        function_141bf08d084d7caf( level.var_501353d53c9fee5a, "dx_wc_ibra_back_gpa1_warning" );
        wait 1.5;
        function_141bf08d084d7caf( level.var_501353d53c9fee5a, "dx_wc_ibra_back_gpa1_evacuateimmediately" );
    }
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x5b405c1b, Offset: 0x370e
// Size: 0x14
function escape_intro()
{
    wait 2;
    overlord::playconversation( "escape_intro" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x79085f7b, Offset: 0x372a
// Size: 0x27
function escape_taking_on_water()
{
    utility::flag_wait( "flag_escape_gauntlet_catwalk_01" );
    level notify( #"hash_61db21d769f4ca03" );
    waitframe();
    overlord::playconversation( "escape_taking_on_water" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x8b76171c, Offset: 0x3759
// Size: 0x27
function escape_under_water()
{
    utility::flag_wait( "flag_escape_under_water" );
    level notify( #"hash_61db21d769f4ca03" );
    waitframe();
    overlord::playconversation( "escape_under_water" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xf9f3057b, Offset: 0x3788
// Size: 0x86
function function_4e092d323fe15060()
{
    if ( isdefined( level.var_501353d53c9fee5a ) )
    {
        foreach ( ent in level.var_501353d53c9fee5a )
        {
            ent stopsounds();
        }
    }
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x1b405c2c, Offset: 0x3816
// Size: 0xe
function boss1_intro()
{
    overlord::playconversation( "boss1_intro" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x1b405c2c, Offset: 0x382c
// Size: 0xe
function boss2_intro()
{
    overlord::playconversation( "boss2_intro" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x1b405c2c, Offset: 0x3842
// Size: 0xe
function boss3_intro()
{
    overlord::playconversation( "boss3_intro" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x1b405c2c, Offset: 0x3858
// Size: 0xe
function boss1_disabled()
{
    overlord::playconversation( "boss1_disabled" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x1b405c2c, Offset: 0x386e
// Size: 0xe
function boss2_disabled()
{
    overlord::playconversation( "boss2_disabled" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x1b405c2c, Offset: 0x3884
// Size: 0xe
function boss3_disabled()
{
    overlord::playconversation( "boss3_disabled" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x1b405c2c, Offset: 0x389a
// Size: 0xe
function boss1_gone()
{
    overlord::playconversation( "boss1_gone" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x1b405c2c, Offset: 0x38b0
// Size: 0xe
function boss2_gone()
{
    overlord::playconversation( "boss2_gone" );
}

// Namespace mp_sat_ob_libra_vo
// Params 3
// Checksum 0x765ba0cd, Offset: 0x38c6
// Size: 0x2f
function function_7238a3a74c67a4c0( delay, var_34faf19a73b4b970, var_d31690ba97fe1586 )
{
    level endon( var_d31690ba97fe1586 );
    wait delay;
    overlord::function_be2d6dc71f97faa6( var_34faf19a73b4b970 );
}

// Namespace mp_sat_ob_libra_vo
// Params 3
// Checksum 0x74e88887, Offset: 0x38fd
// Size: 0xbc
function finish_mech_vo( var_63db04cb080a1079, initial_vo, nags )
{
    level endon( #"finished_mech" );
    
    if ( !isarray( initial_vo ) )
    {
        initial_vo = [ initial_vo ];
    }
    
    foreach ( var_34faf19a73b4b970 in initial_vo )
    {
        overlord::function_be2d6dc71f97faa6( var_34faf19a73b4b970 );
    }
    
    function_a42a4ebb7fd9eb2( nags, var_63db04cb080a1079, undefined, undefined, 0 );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x71ca857d, Offset: 0x39c1
// Size: 0x1d8
function function_f1436a95780d3552()
{
    if ( !isdefined( level.vo_handled ) )
    {
        level.vo_handled = 1;
    }
    else
    {
        return;
    }
    
    level thread function_52da046ab79eb38e();
    nags = [ "mech_moved_center1", "mech_moved_center2", "mech_moved_center3", "mech_moved_center4", "mech_moved_center5", "mech_moved_center6" ];
    level thread nag_on_notify( nags, "player_downed", 10, "stop_mech_vo" );
    nags = [ "mech_moved_center1", "mech_moved_center2", "mech_moved_center3", "mech_moved_center4", "mech_moved_center5", "mech_moved_center6" ];
    level thread nag_on_notify( nags, "mech_in_middle", 0, "stop_mech_vo" );
    nags = [ "new_mech1", "new_mech2" ];
    level thread nag_on_notify( nags, "new_mech", 0, "stop_mech_vo" );
    nags = [ "mech_cant_damage1", "mech_cant_damage2", "mech_cant_damage3" ];
    level thread nag_on_notify( nags, "cant_damage_mech", 8, "stop_mech_vo" );
    thread supply_drop_vo();
    nags = [ "mech_beam1", "mech_beam2", "mech_beam3" ];
    level thread nag_on_notify( nags, "mech_beam_hit_player", 8, "stop_mech_vo" );
    nags = [ "mech_repulsor1", "mech_repulsor2" ];
    level thread nag_on_notify( nags, "mech_repulsed", 20, "stop_mech_vo" );
    nags = [ "focus_on_mech1", "focus_on_mech2", "focus_on_mech3", "focus_on_mech4", "focus_on_mech5" ];
    level thread nag_on_notify( nags, "grunt_killed", 30, "stop_mech_vo" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x301f44a0, Offset: 0x3ba1
// Size: 0x49
function function_52da046ab79eb38e()
{
    if ( !isarray( level.players ) || !isdefined( level.players[ 0 ] ) )
    {
        return;
    }
    
    utility::waittill_any_ents_array( level.players, "last_stand_enter" );
    wait 2;
    overlord::function_be2d6dc71f97faa6( "boss_banter1" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0xbab6a291, Offset: 0x3bf2
// Size: 0x6e
function function_67e8df158fe9ce29()
{
    self endon( #"death" );
    
    if ( !isdefined( level.var_1eadc2badd6a74af ) )
    {
        while ( true )
        {
            self waittill( #"hash_736596c3509c4217", var_35069c22d08b1f24 );
            
            if ( var_35069c22d08b1f24 > 0.01 && var_35069c22d08b1f24 <= 0.25 )
            {
                break;
            }
        }
        
        level.var_1eadc2badd6a74af = 1;
        overlord::function_be2d6dc71f97faa6( "boss_banter2" );
    }
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x5b205c4e, Offset: 0x3c68
// Size: 0x14
function boss_forcefields_activate()
{
    wait 3.5;
    overlord::playconversation( "boss_forcefields_activate" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x1b405c40, Offset: 0x3c84
// Size: 0x11
function boss_cradle_bombs_explode()
{
    wait 2;
    overlord::playconversation( "boss_cradle_bombs_explode" );
}

// Namespace mp_sat_ob_libra_vo
// Params 0
// Checksum 0x499062e0, Offset: 0x3c9d
// Size: 0xf3
function supply_drop_vo()
{
    level waittill( #"supply_drop" );
    overlord::playconversation( "first_boss_supply_drop" );
    wait 15;
    nags = [ "mech_supply_crate1", "mech_supply_crate2", "mech_supply_crate3", "mech_supply_crate4", "mech_supply_crate5", "mech_supply_crate6", "mech_supply_crate7", "mech_supply_crate9", "mech_supply_crate10", "mech_supply_crate11" ];
    level thread nag_on_notify( nags, "supply_drop", 15, "stop_supply_drop_vo", "pause_supply_drop_vo" );
    
    while ( !utility::flag( "stage3_done" ) )
    {
        level waittill( #"finish_mech" );
        utility::flag_set( "pause_supply_drop_vo" );
        level waittill( #"new_mech_started" );
        wait 5;
        utility::flag_clear( "pause_supply_drop_vo" );
    }
    
    level notify( #"stop_supply_drop_vo" );
}

// Namespace mp_sat_ob_libra_vo
// Params 2
// Checksum 0x961aebf, Offset: 0x3d98
// Size: 0xad
function function_141bf08d084d7caf( apositions, alias )
{
    if ( soundexists( alias ) )
    {
        foreach ( pos in apositions )
        {
            if ( isent( pos ) )
            {
                pos playsound( alias );
                continue;
            }
            
            playsoundatpos( pos.origin, alias );
        }
    }
}

// Namespace mp_sat_ob_libra_vo
// Params 5
// Checksum 0xca7bd8f2, Offset: 0x3e4d
// Size: 0xad
function function_a42a4ebb7fd9eb2( nags, flagname, delay = 6, max_delay = 18, immediate_nag = 1 )
{
    level endon( flagname );
    
    if ( !immediate_nag )
    {
        wait delay;
    }
    else
    {
        delay /= 2;
    }
    
    i = 0;
    
    while ( !utility::flag( flagname ) )
    {
        overlord::function_be2d6dc71f97faa6( nags[ i ] );
        delay *= 2;
        
        if ( delay > max_delay )
        {
            delay = max_delay;
        }
        
        i++;
        
        if ( i >= nags.size )
        {
            i = 0;
        }
        
        wait delay;
    }
}

// Namespace mp_sat_ob_libra_vo
// Params 5
// Checksum 0xabf36a9e, Offset: 0x3f02
// Size: 0x80
function nag_on_notify( nags, notify_str, var_ace252447b09b3d3, var_d31690ba97fe1586, pause_flag )
{
    level endon( var_d31690ba97fe1586 );
    
    for ( i = 0; true ; i = 0 )
    {
        self waittill( notify_str );
        
        if ( !isdefined( pause_flag ) || !utility::flag( pause_flag ) )
        {
            overlord::function_be2d6dc71f97faa6( nags[ i ] );
            wait var_ace252447b09b3d3;
            i++;
            
            if ( i >= nags.size )
            {
            }
        }
    }
}

