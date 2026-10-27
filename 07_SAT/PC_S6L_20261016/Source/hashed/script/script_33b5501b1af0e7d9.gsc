// script_33b5501b1af0e7d9  (hash_33b5501b1af0e7d9.gscc) (size: 4991 Bytes / 0x137f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4db01f4c (1303387980)
// size ...... 4991 (0x137f)
// includes .. 8   (offset: 0x11cf)
// strings ... 26  (offset: 0x120f)
// dev strs .. 0   (offset: 0x137f)
// exports ... 13  (offset: 0xb33)
// cseg ...... 0x371 + 0x7c2 (0xb33)
// imports ... 39  (offset: 0xd3b)
// animtree1 . 0   (offset: 0x137f)
// animtree2 . 0   (offset: 0x137f)
#using script_35efc59124dbb5db;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis;
#using scripts\mp\zm\systems\zm_interaction;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;

#namespace namespace_575f4843912c9847;

// Namespace namespace_575f4843912c9847
// Params 0
// Checksum 0x90310585, Offset: 0x38f
// Size: 0x53
function init()
{
    data = { #past_truck:setup_past_truck(), #future_truck:setup_future_truck() };
    level.mantis_pap_quest.var_1e5d973acb8a3591 = data;
    utility::flag_set( #"hash_1493705bf8ae8a10" );
}

// Namespace namespace_575f4843912c9847
// Params 2
// Checksum 0xb9419c77, Offset: 0x3ea
// Size: 0x49
function execute( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    utility::flag_wait( #"hash_1493705bf8ae8a10" );
    function_db2a85e7c1b59a61();
    utility::flag_wait_any( "papq_truck_engine_started", "open_sesame" );
}

// Namespace namespace_575f4843912c9847
// Params 2
// Checksum 0xe9fdbefe, Offset: 0x43b
// Size: 0x32
function cleanup( skipped, save_restored )
{
    utility::flag_set( "papq_truck_engine_started" );
    function_575f4843912c9847( !save_restored );
    clear_objective_marks();
}

// Namespace namespace_575f4843912c9847
// Params 0, eflags: 0x4
// Checksum 0xe40cba77, Offset: 0x475
// Size: 0x96
function private setup_future_truck()
{
    truck = utility::getent_or_struct( "pap_quest_step_2_spawn_node_truck_future", "script_noteworthy" );
    truck_destination_node = utility::getstruct( "pap_quest_step_2_dest_node_truck_future", "script_noteworthy" );
    
    if ( !isdefined( truck ) )
    {
        return;
    }
    
    truck scriptmodelplayanimdeltamotionfrompos( "sat_fxanim_zm_truck_mil_move_start", truck.origin, truck.angles );
    truck.var_404b0ba467e79637 = truck_destination_node;
    truck_collision = getent( "pap_quest_step_2_collision_truck_future", #script_noteworthy );
    truck_collision linkto( truck );
    return truck;
}

// Namespace namespace_575f4843912c9847
// Params 0, eflags: 0x4
// Checksum 0x9246c334, Offset: 0x514
// Size: 0xdc
function private setup_past_truck()
{
    truck = utility::getent_or_struct( "pap_quest_step_2_spawn_node_truck_past", "script_noteworthy" );
    truck_destination_node = utility::getstruct( "pap_quest_step_2_dest_node_truck_past", "script_noteworthy" );
    truck_interaction_node = utility::getstruct( "pap_quest_step_2_truck_interaction", "script_noteworthy" );
    
    if ( !isdefined( truck ) )
    {
        return;
    }
    
    truck scriptmodelplayanimdeltamotionfrompos( "sat_fxanim_zm_truck_mil_move_start", truck.origin, truck.angles );
    truck.var_404b0ba467e79637 = truck_destination_node;
    truck.interaction = zm_quest::function_91f9590e98d57ff6( truck_interaction_node.origin, &truck_interaction, &truck_interaction_hint, "small" );
    truck_collision = getent( "pap_quest_step_2_collision_truck_past", #script_noteworthy );
    truck_collision linkto( truck );
    return truck;
}

// Namespace namespace_575f4843912c9847
// Params 1, eflags: 0x4
// Checksum 0xb2d24d3b, Offset: 0x5f9
// Size: 0x121
function private truck_interaction( player )
{
    if ( self.in_use || isdefined( player ) && player.interactions_disabled || !player has_keys() )
    {
        return;
    }
    
    self.in_use = 1;
    player val::set( "using_papq_truck", "killstreaks", 0 );
    player zm_interaction::function_307c21197e0798d4( &"zm_sat_mantis/papq_starting_truck" );
    player zm_quest::function_eb3a5a6c3f4f3ba6( { #craft_reason:"using_papq_truck" } );
    result = player zm_interaction::function_df340931f1a0fe6e( 1, self, self.interact_use_range );
    player zm_quest::function_b94186b3fb991490( { #craft_reason:"using_papq_truck" } );
    player zm_interaction::function_7c7ed762cd4d0333();
    
    if ( result )
    {
        zm_quest::function_9170db4686f796e2();
        wait 1;
        utility::flag_set( "papq_truck_engine_started" );
        thread function_fe70f17765654562( player, level.mantis_pap_quest.var_1e5d973acb8a3591.past_truck.origin );
        return;
    }
    
    wait 1;
    self.in_use = 0;
}

// Namespace namespace_575f4843912c9847
// Params 2, eflags: 0x4
// Checksum 0xfe5e98c9, Offset: 0x722
// Size: 0xea
function private truck_interaction_hint( interact, player )
{
    if ( isdefined( player ) && player.interactions_disabled || interact.in_use )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    hint = { #icon:"alien_perk_engineer", #buttoncallout:&"shared_hintstrings/hint_interact", #description:&"zm_sat_mantis/papq_start_truck", #title:&"zm_sat_mantis/papq_truck", #type:"HINT_BUTTON" };
    
    if ( !player has_keys() )
    {
        hint.aux_text = &"zm_sat_mantis/papq_need_truck_keys";
        hint.interactable = 0;
    }
    
    return hint;
}

// Namespace namespace_575f4843912c9847
// Params 0, eflags: 0x4
// Checksum 0xe43bb68e, Offset: 0x815
// Size: 0x1c
function private has_keys()
{
    return zm_quest::function_6b5f09e88a4edfce( #"mantis_instruments", 0, #"sat_zm_quest_mantis_papq_truck_keys", self );
}

// Namespace namespace_575f4843912c9847
// Params 1, eflags: 0x4
// Checksum 0xad95147c, Offset: 0x83a
// Size: 0x170
function private function_575f4843912c9847( do_sounds = 1 )
{
    past_truck = level.mantis_pap_quest.var_1e5d973acb8a3591.past_truck;
    future_truck = level.mantis_pap_quest.var_1e5d973acb8a3591.future_truck;
    past_zone = zone_manager::function_90e5c3e2272b0130( past_truck.origin );
    future_zone = zone_manager::function_90e5c3e2272b0130( future_truck.origin );
    past_truck.interaction zm_quest::function_9170db4686f796e2();
    
    if ( do_sounds )
    {
        past_truck playsoundonmovingent( "evt_quest_pap_mantis_truck_unlock" );
    }
    
    past_truck scriptmodelplayanimdeltamotionfrompos( "sat_fxanim_zm_truck_mil_move", past_truck.origin, past_truck.angles );
    future_truck scriptmodelplayanimdeltamotionfrompos( "sat_fxanim_zm_truck_mil_move", future_truck.origin, future_truck.angles );
    past_truck_collision = getent( "pap_quest_step_2_collision_truck_past", #script_noteworthy );
    future_truck_collision = getent( "pap_quest_step_2_collision_truck_future", #script_noteworthy );
    past_truck_collision connectpaths();
    future_truck_collision connectpaths();
    zone_manager::set_zone_enabled( past_zone.script_zone_name, 1 );
    zone_manager::set_zone_enabled( future_zone.script_zone_name, 1 );
}

// Namespace namespace_575f4843912c9847
// Params 0, eflags: 0x4
// Checksum 0xce85396c, Offset: 0x9b2
// Size: 0x92
function private function_db2a85e7c1b59a61()
{
    if ( level zm_sat_mantis::function_80daf2f20b4e6e6d() )
    {
        return;
    }
    
    past_truck = level.mantis_pap_quest.var_1e5d973acb8a3591.past_truck;
    namespace_a7211835085600d5::add_objective_mark( #"mantis_pap_quest", past_truck, "papq_truck", 150, 1, { #timetravel_step:{ #future:#"hash_a580f6b981b231ff", #past:#"hash_f71e6b42189a1a3c" }, #var_7be076c9078045aa:#"hash_28d63457c71bcedb" } );
}

// Namespace namespace_575f4843912c9847
// Params 1, eflags: 0x4
// Checksum 0x5dc7ba41, Offset: 0xa4c
// Size: 0x1c
function private clear_objective_marks( params )
{
    namespace_a7211835085600d5::clear_objective_marks( #"mantis_pap_quest" );
}

// Namespace namespace_575f4843912c9847
// Params 2, eflags: 0x4
// Checksum 0x6d70a805, Offset: 0xa70
// Size: 0xc3
function private function_fe70f17765654562( player, location )
{
    utility::flag_waitopen_all_array( [ "mantis_vo_twins_banter_active", "end_of_round_vo_playing" ] );
    utility::flag_set( "mantis_vo_twins_banter_active" );
    twins_banter = randomint( 2 );
    
    if ( twins_banter == 0 )
    {
        playsoundatpos( location, "dx_zm_mpwp_mapp_lvtw_mpp1sttrka1ln1" );
        wait 2.5;
        playsoundatpos( location, "dx_zm_mpwp_mapp_detw_mpp1sttrka1ln2" );
        wait 3.5;
    }
    else
    {
        playsoundatpos( location, "dx_zm_mpwp_mapp_detw_mpp1sttrka2ln1" );
        wait 6.5;
        playsoundatpos( location, "dx_zm_mpwp_mapp_lvtw_mpp1sttrka2ln2" );
        wait 4;
    }
    
    player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_28d63457c71bcedb", #"bc_flavor_player_positive" );
    utility::flag_clear( "mantis_vo_twins_banter_active" );
}

