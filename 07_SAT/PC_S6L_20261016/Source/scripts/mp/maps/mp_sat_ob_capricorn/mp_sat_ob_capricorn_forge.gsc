// scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_forge.gsc  (hash_58d817120ad72b81.gscc) (size: 33351 Bytes / 0x8247 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4298aa2c (1117301292)
// size ...... 33351 (0x8247)
// includes .. 27  (offset: 0x7713)
// strings ... 179 (offset: 0x77eb)
// dev strs .. 3   (offset: 0x8223)
// exports ... 69  (offset: 0x4fd3)
// cseg ...... 0x13ab + 0x3c28 (0x4fd3)
// imports ... 234 (offset: 0x5a9b)
// animtree1 . 0   (offset: 0x8247)
// animtree2 . 0   (offset: 0x8247)
#using script_16d8789bae43669e;
#using script_35713297c4efa490;
#using script_636bd827a012af12;
#using scripts\common\active_env\moving_platforms;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\damage_effects;
#using scripts\common\puzzles\connection_puzzle;
#using scripts\common\scene;
#using scripts\common\snd\snd;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\visibility_mode;
#using scripts\mp\common\supers\black_hat;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\coop;
#using scripts\mp\damagefeedback;
#using scripts\mp\interaction;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_audio;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_hijack_throttle;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_vo;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_util;
#using scripts\mp\ob\systems\ob_item_select;
#using scripts\mp\supers;

#namespace mp_sat_ob_capricorn_forge;

// Namespace mp_sat_ob_capricorn_forge
// Params 0, eflags: 0x5
// Checksum 0x22e68ca7, Offset: 0x13c9
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_ob_capricorn_forge", #"activity_common", &function_1e7f6850227284c4, undefined );
}

// Namespace mp_sat_ob_capricorn_forge
// Params 0, eflags: 0x4
// Checksum 0xd9eedb4b, Offset: 0x13f2
// Size: 0x14c
function private function_1e7f6850227284c4()
{
    ob_story_mission_activity_setup::function_a27e17544ac7654a( "CAPRICORN_FORGE", "OB_CAPRICORN_FORGE", [ { #result:undefined, #var_de54801bc657ab2c:&function_43fa818b9114dcd4 }, { #result:undefined, #var_de54801bc657ab2c:&function_1213856f9b639e35 } ] );
    ob_story_mission_activity_setup::function_a27e17544ac7654a( "CAPRICORN_FORGE", "OB_CAPRICORN_FORGE_01", [ { #result:undefined, #var_de54801bc657ab2c:&function_c53e85e24d9fa95b }, { #result:undefined, #var_de54801bc657ab2c:&function_6d3f60d3486aad57 }, { #result:&function_227b576a77bba81e, #var_de54801bc657ab2c:&function_a8863010c50e2c62 } ] );
    ob_story_mission_activity_setup::function_a27e17544ac7654a( "CAPRICORN_FORGE", "OB_CAPRICORN_FORGE_02", [ { #result:undefined, #var_de54801bc657ab2c:&function_d27e99530e486ded } ] );
    ob_story_mission_activity_setup::function_a27e17544ac7654a( "CAPRICORN_FORGE", "OB_CAPRICORN_FORGE_RETURN_TO_ELEVATOR", [ { #result:undefined, #var_de54801bc657ab2c:&function_dc072b67f948fc47 } ] );
    ob_story_mission_activity_setup::function_13cff85d193f6c27( "CAPRICORN_FORGE", &function_4ac31767ba64e331 );
    ob_story_mission_activity_setup::function_159af14427677b6c( "CAPRICORN_FORGE", &function_814ddcdf12398796 );
    ob_story_mission_activity_setup::function_2f991abf23ddce4c( "CAPRICORN_FORGE", &forge_player_setup );
}

// Namespace mp_sat_ob_capricorn_forge
// Params 0, eflags: 0x4
// Checksum 0xbd54c5af, Offset: 0x1546
// Size: 0x283
function private function_4ac31767ba64e331()
{
    mp_sat_ob_capricorn::set_minimap( "forge" );
    mp_sat_ob_capricorn_hijack_throttle::throttle_area_swap();
    level.request_ids = undefined;
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_c64b9e01025b34ef" ][ #"lock" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( "forge_door_turret_to_elevator_passage" );
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_c64b9e01025b34ef" ][ #"lock" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( "forge_door_turret_to_showroom" );
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_c64b9e01025b34ef" ][ #"lock" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( "forge_computer_room_door" );
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_c64b9e01025b34ef" ][ #"unlock" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( "forge_door_server_to_showroom" );
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_c64b9e01025b34ef" ][ #"unlock" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( "forge_door_turret_to_server" );
    }
    
    thread ob_story_mission_utils::item_spawn_weapon( "p1_activity_forge_weapons", "forge_staged_gear_clean_up", 1 );
    thread ob_story_mission_utils::item_spawn_equipment( "p1_activity_forge_equipment", "forge_staged_gear_clean_up", 1 );
    thread ob_story_mission_utils::function_fa27c4afc0f886da( "p1_activity_forge_item", "forge_staged_gear_clean_up", 1 );
    thread activity_ai_encounters::function_79c1b913ce172ac5( self, "forge_encounter_trigger", &function_b37b0a952c8737f1, &activity_ai_encounters::function_952687d67d74fdef, undefined, 1 );
    thread ob_story_mission_utils::function_e6799e9a19df2365( "capricorn_forge_caches" );
    
    if ( level.current_activity.type != "OB_CAPRICORN_FORGE" )
    {
        case_struct = utility::getstruct( "forge_black_hat_ability_case", "targetname" );
        thread ob_item_select::function_95f9ecc2af4693f6( case_struct.origin, "super_vision_pulse", "super_survival_life_drain", #"default" );
    }
    
    utility::trigger_off( "forge_turret_intro_trigger", #targetname );
    
    if ( level.current_activity.type == "OB_CAPRICORN_FORGE_02" || level.current_activity.type == "OB_CAPRICORN_FORGE_RETURN_TO_ELEVATOR" )
    {
        utility::trigger_off( "forge_encounter_showroom", #script_noteworthy );
        utility::trigger_off( "forge_encounter_turret", #script_noteworthy );
        utility::trigger_off( "ai_encounter_capricorn_forge_office", #script_noteworthy );
    }
    
    capricorn_forge_cleanup();
    level thread setup_force_fields();
    level thread function_b9a5374454ab942f();
    thread mp_sat_ob_capricorn::encounter_create_squad( "forge_encounter_showroom" );
}

// Namespace mp_sat_ob_capricorn_forge
// Params 3, eflags: 0x4
// Checksum 0xd2a6676a, Offset: 0x17d1
// Size: 0x2d
function private function_b37b0a952c8737f1( activity_instance, encounter_name, player )
{
    utility::flag_set( encounter_name + "_triggered" );
}

// Namespace mp_sat_ob_capricorn_forge
// Params 0, eflags: 0x4
// Checksum 0xe7aace8c, Offset: 0x1806
// Size: 0x9b
function private function_814ddcdf12398796()
{
    if ( isdefined( level.var_3d9fc7aa7b25b565.var_e86ebbbb4a2df1 ) )
    {
        if ( isdefined( level.var_3d9fc7aa7b25b565.var_e86ebbbb4a2df1.shield ) )
        {
            remove_turret_shield( level.var_3d9fc7aa7b25b565.var_e86ebbbb4a2df1.shield );
        }
        
        level.var_3d9fc7aa7b25b565.var_e86ebbbb4a2df1 delete();
        level.var_3d9fc7aa7b25b565.var_e86ebbbb4a2df1 = undefined;
    }
    
    level utility::flag_set( "forge_staged_gear_clean_up" );
    removeallcorpses();
}

// Namespace mp_sat_ob_capricorn_forge
// Params 1, eflags: 0x4
// Checksum 0x832a0d40, Offset: 0x18a9
// Size: 0x8d
function private forge_player_setup( player )
{
    loadout_recovery_struct = utility::getstruct( "forge_loadout_recovery_struct", "targetname" );
    
    if ( loadout_recovery_struct && !player.loot_crate_scriptable )
    {
        payload = [ #"teamselect", player getentitynumber() ];
        player.loot_crate_scriptable = spawnscriptable( "ob_gemini_oneclient_loot_crate", loadout_recovery_struct.origin, loadout_recovery_struct.angles, undefined, payload );
    }
}

/#

    // Namespace mp_sat_ob_capricorn_forge
    // Params 0
    // Checksum 0xec9a2a86, Offset: 0x193e
    // Size: 0x5, Type: dev
    function function_fb233985d1018fd7()
    {
        
    }

#/

// Namespace mp_sat_ob_capricorn_forge
// Params 0, eflags: 0x4
// Checksum 0x5ab86d97, Offset: 0x194b
// Size: 0x132
function private function_43fa818b9114dcd4()
{
    thread mp_sat_ob_capricorn_vo::function_b7b1f84516c76aba();
    level.var_5b5e33f91adb40b0 = [];
    thread function_87bb8dbaf8307267( "forge_arena_bot" );
    
    if ( !level.is_squad_size_small )
    {
        thread function_87bb8dbaf8307267( "forge_arena_bot_large" );
    }
    else
    {
        thread function_87bb8dbaf8307267( "forge_arena_bot_small" );
    }
    
    foreach ( player in level.players )
    {
        player childthread monitor_infiltrate_waypoint_reached();
    }
    
    thread function_a094dce6fab5504();
    thread function_a75d87418ecd3ffd();
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_FORGE_INFILTRATE" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "capricorn_forge_infil", { #objective:"sat_ob_objectivemarker_storymissionmain", #waypoint:"sat_ob_objectivemarker_location" }, "infiltrate_waypoint_reached", "player_infiltrate_waypoint_reached", undefined, 1, 1, 0, undefined, undefined, undefined, undefined, ( 0, -1.2, 16 ) );
    level waittill( #"forge_reached" );
}

// Namespace mp_sat_ob_capricorn_forge
// Params 0, eflags: 0x4
// Checksum 0x45d73f2e, Offset: 0x1a85
// Size: 0x40
function private monitor_infiltrate_waypoint_reached()
{
    level endon( #"infiltrate_waypoint_reached" );
    level endon( #"forge_reached" );
    self waittill( #"player_infiltrate_waypoint_reached" );
    level thread mp_sat_ob_capricorn::cancel_waypoint_objective_handler( "capricorn_forge_infil" );
    level notify( #"forge_reached" );
}

// Namespace mp_sat_ob_capricorn_forge
// Params 0, eflags: 0x4
// Checksum 0xd6b4fec7, Offset: 0x1acd
// Size: 0xb5
function private function_a094dce6fab5504()
{
    level utility::flag_wait( "flag_forge_combat_roll_hint" );
    
    foreach ( player in level.players )
    {
        player utility::callsharedfunc( #"hint", #"add_simple", "hint_active_roll", &"sat_ob_story_missions_capricorn/ob_capricorn_active_roll_hint", 10 );
    }
    
    thread mp_sat_ob_capricorn_vo::function_65f98bae67c258f8( gettime() );
}

// Namespace mp_sat_ob_capricorn_forge
// Params 0, eflags: 0x4
// Checksum 0xb0ca0d1c, Offset: 0x1b8a
// Size: 0x9d
function private function_1213856f9b639e35()
{
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_FORGE_ELIMINATE_ENCOUNTER" );
    thread capricorn_audio::function_651013b66eeaa979();
    thread mp_sat_ob_capricorn_vo::function_a0e90de16ea81efb();
    level utility::flag_wait( "flag_forge_arena_bot_done" );
    thread activity_ai_encounters::function_e9091e3a4b3537eb( self, "encounter_forge_infiltrate_room", "forge_infiltrate_encounter_completed", 4 );
    level utility::flag_set( "flag_vo_forge_infiltrate_reinforcements" );
    level utility::flag_wait_all( "forge_infiltrate_encounter_completed", "encounter_forge_arena_ambient_completed" );
    case_struct = utility::getstruct( "forge_black_hat_ability_case", "targetname" );
    thread ob_item_select::function_95f9ecc2af4693f6( case_struct.origin, "super_vision_pulse", "super_survival_life_drain", #"default" );
}

// Namespace mp_sat_ob_capricorn_forge
// Params 0, eflags: 0x4
// Checksum 0xd712711c, Offset: 0x1c2f
// Size: 0xa6
function private function_c53e85e24d9fa95b()
{
    level notify( #"hash_942bc6ae535ab0c4" );
    thread mp_sat_ob_capricorn_vo::function_9b983e53f389b1d2();
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_FORGE_ELEVATOR_RESTRICTED_AREA" );
    infiltrate_struct_origin = utility::getstruct( "interact_forge_infiltrate" ).origin;
    function_7e932e688a9b94f9( infiltrate_struct_origin, self, "flag_elevator_first_interact", "capricorn_forge_elevator" );
    function_c1412872e70aa28b( "capricorn_forge_elevator_button_outside", "declined" );
    thread ob_story_mission_utils::function_273dfd9583646854( "forge_trail_vtol_turret", undefined, undefined, undefined, 140, 180, 0, 120, 60, undefined, 1 );
    capricorn_audio::function_4c1fa399f9b361f3( infiltrate_struct_origin - ( 35, 0, 0 ) );
    level utility::flag_wait( "flag_elevator_lockdown_vo_finished" );
}

// Namespace mp_sat_ob_capricorn_forge
// Params 0, eflags: 0x4
// Checksum 0x240a037d, Offset: 0x1cdd
// Size: 0x69
function private function_6e7c8fc6cbfb021()
{
    utility::flag_set( "flag_1st_computer_completed" );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_c64b9e01025b34ef" ][ #"unlock" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( "forge_door_turret_to_elevator_passage" );
    }
    
    thread capricorn_audio::function_2ddf9442133d01ae( ( -6883, -24890, 752 ) );
    level utility::flag_set( "flag_vo_forge_elevator_reinforcement" );
}

/#

    // Namespace mp_sat_ob_capricorn_forge
    // Params 0
    // Checksum 0xf4eb771f, Offset: 0x1d4e
    // Size: 0x5, Type: dev
    function function_92cf7c3ba277b46f()
    {
        
    }

#/

// Namespace mp_sat_ob_capricorn_forge
// Params 0, eflags: 0x4
// Checksum 0xf4c42bd7, Offset: 0x1d5b
// Size: 0x304
function private function_6d3f60d3486aad57()
{
    thread forge_encounter_arena_respawn();
    wait 0.1;
    function_6e7c8fc6cbfb021();
    childthread function_a66c3f5775406209();
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_FORGE_SECURITY_ROOM" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "capricorn_forge_turret_forcefield", { #objective:"sat_ob_objectivemarker_storymissionmain", #waypoint:"sat_ob_objectivemarker_location" }, "capricorn_forge_security_room_button_done", undefined, undefined, 1, 1, 0, undefined, undefined, undefined, undefined, ( 0, -1.2, 16 ) );
    level thread mp_sat_ob_capricorn::function_776ea74dd9e92d46( "flag_forge_center_ff_destroyed", "capricorn_forge_turret_forcefield" );
    utility::flag_wait( "flag_forge_center_ff_destroyed" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "capricorn_forge_security_room_button", { #objective:"sat_ob_objectivemarker_storymissionmain", #waypoint:"sat_ob_objectivemarker_location" }, "capricorn_forge_security_room_button_done", undefined, undefined, 1, 1, 0, undefined, undefined, undefined, undefined, ( 0, -1.2, 16 ) );
    level thread mp_sat_ob_capricorn::function_776ea74dd9e92d46( "forge_encounter_showroom_triggered", "capricorn_forge_security_room_button" );
    utility::flag_wait( "forge_encounter_showroom_triggered" );
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_FORGE_CLEAR_SHOWROOM" );
    utility::flag_wait( "forge_encounter_showroom_completed" );
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_FORGE_SECURITY_ROOM" );
    interactstruct = utility::getstruct( "forge_computer_room_interact" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "capricorn_forge_security_room_button", { #objective:"sat_ob_objectivemarker_storymissionmain", #waypoint:"sat_ob_objectivemarker_location" }, "capricorn_forge_security_room_button_done", undefined, undefined, 0, 1, 0, undefined, undefined, undefined, undefined, ( 0, -1.2, 16 ) );
    level thread mp_sat_ob_capricorn::function_776ea74dd9e92d46( "flag_forge_computer_room_unlocked", "capricorn_forge_security_room_button" );
    interact = interaction::register_interact( interactstruct.origin, 64, &function_36878d5b0205f128, &"jup_ob_objectives/interact_activate" );
    interact setcursorhint( "HINT_BUTTON" );
    level waittill( #"flag_forge_computer_room_unlocked", player );
    var_678759dcf4f532b7 = namespace_1f3f9eb1e9681da5::function_ffc96a24d6f74919( "player_catchup_computer_03", self, "flag_computer_catchup_complete", 5, "flag_computer_catchup_begin" );
    var_ba7c3b8fa9d3823 = spawnstruct();
    var_ba7c3b8fa9d3823.origin = ( -5828.99, -22861.6, 694.48 );
    options = spawnstruct();
    options.flag_completed = "player_regroup_forge_computer_room_completed";
    options.fadestartnone = 1;
    options.var_227ead15d2892709 = 1;
    options.var_ba7c3b8fa9d3823 = var_ba7c3b8fa9d3823;
    options.triggerradius = 400;
    options.teleport_structs = var_678759dcf4f532b7.teleport_structs;
    options.var_560eecb53e318cbf = 1;
    options.var_2b79828dcc50cbcc = 1;
    options.ignore_cleanup = 1;
    thread coop::function_ca1c6723a350447f( options );
    level utility::flag_wait( "player_regroup_forge_computer_room_completed" );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_c64b9e01025b34ef" ][ #"lock" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( "forge_door_turret_to_elevator_passage" );
    }
}

// Namespace mp_sat_ob_capricorn_forge
// Params 0, eflags: 0x4
// Checksum 0x1efcc514, Offset: 0x2067
// Size: 0xf
function private forge_encounter_arena_respawn()
{
    spawnaiencounter( "forge_encounter_arena_respawn", self );
}

// Namespace mp_sat_ob_capricorn_forge
// Params 0, eflags: 0x4
// Checksum 0x54840b5e, Offset: 0x207e
// Size: 0xdc
function private function_a75d87418ecd3ffd()
{
    level endon( #"flag_forge_computer_room_unlocked" );
    level waittill( #"vo_forge_blackhat_hint" );
    
    foreach ( player in level.players )
    {
        super = player supers_mp::getcurrentsuperref( #"tactical" );
        
        if ( super == "super_black_hat" )
        {
            player utility::callsharedfunc( #"hint", #"add_simple", "hint_black_hat", &"sat_ob_story_missions_capricorn/black_hat_hint", 10 );
        }
    }
}

// Namespace mp_sat_ob_capricorn_forge
// Params 0, eflags: 0x4
// Checksum 0x98725732, Offset: 0x2162
// Size: 0xaa
function private function_a66c3f5775406209()
{
    level utility::flag_wait( "flag_forge_plasma_field_1_vo_done" );
    
    foreach ( player in level.players )
    {
        player utility::callsharedfunc( #"hint", #"add_simple", "hint_plasma_field", &"sat_ob_story_missions_capricorn/plasma_field_hint", 10 );
    }
}

// Namespace mp_sat_ob_capricorn_forge
// Params 1, eflags: 0x4
// Checksum 0xa9eff4c4, Offset: 0x2214
// Size: 0x6a
function private function_36878d5b0205f128( player )
{
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_c64b9e01025b34ef" ][ #"unlock" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( "forge_computer_room_door" );
    }
    
    utility::flag_set( "flag_forge_computer_room_unlocked", player );
    thread capricorn_audio::function_e5ef3603af687f1b( self.origin );
    self delete();
}

// Namespace mp_sat_ob_capricorn_forge
// Params 0, eflags: 0x4
// Checksum 0xb01e2fa6, Offset: 0x2286
// Size: 0xa2
function private function_a8863010c50e2c62()
{
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_FORGE_COMPUTER_3" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "capricorn_forge_security_room_computer", { #objective:"sat_ob_objectivemarker_storymissionmain", #waypoint:"sat_ob_objectivemarker_location" }, "capricorn_forge_security_room_computer_done", undefined, undefined, 1, 1, 0, undefined, undefined, undefined, undefined, ( 0, -1.2, 16 ) );
    level thread mp_sat_ob_capricorn::function_776ea74dd9e92d46( "flag_3rd_computer_completed", "capricorn_forge_security_room_computer" );
    setup_puzzle_computer( "interact_forge_disable_security_3rd_computer", "capricorn_1", "computer_3" );
    level waittill( #"hash_3293189006eb45ee", puzzle_player );
    level notify( #"hash_e9d8f99b4699a0e2" );
}

// Namespace mp_sat_ob_capricorn_forge
// Params 0, eflags: 0x4
// Checksum 0x6759904f, Offset: 0x2330
// Size: 0x11c
function private function_227b576a77bba81e()
{
    level utility::flag_set( "flag_3rd_computer_completed" );
    thread ob_story_mission_utils::item_spawn_equipment( "p1_activity_forge_equipment_turret_fight", undefined, 1 );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_c64b9e01025b34ef" ][ #"unlock" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( "forge_door_turret_to_showroom" );
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_c64b9e01025b34ef" ][ #"force_open" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( "forge_computer_room_door" );
    }
    
    lockdown_security_lights = getscriptablearray( "forge_lockdown_security_lights", #targetname );
    
    foreach ( light in lockdown_security_lights )
    {
        light setscriptablepartstate( "base", "alert_off" );
    }
}

/#

    // Namespace mp_sat_ob_capricorn_forge
    // Params 0
    // Checksum 0x727f05b1, Offset: 0x2454
    // Size: 0x5, Type: dev
    function function_ad3e23838639fa8()
    {
        
    }

#/

// Namespace mp_sat_ob_capricorn_forge
// Params 1, eflags: 0x4
// Checksum 0x8233966a, Offset: 0x2461
// Size: 0x3b
function private function_9c9cfeb53c7bd46( struct )
{
    player = self;
    player ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_capricorn_turret", struct );
    player ob_story_mission_utils::player_boss_healthbar_show();
    player ob_story_mission_utils::player_boss_healthbar_immune();
}

// Namespace mp_sat_ob_capricorn_forge
// Params 1, eflags: 0x4
// Checksum 0x78cdc876, Offset: 0x24a4
// Size: 0x104
function private function_73b87cfe02a19e1e( struct )
{
    struct.health = 99999999;
    struct.maxhealth = struct.health;
    
    foreach ( player in level.players )
    {
        player thread function_9c9cfeb53c7bd46( struct );
    }
    
    if ( !isdefined( struct.shield ) )
    {
        shield = spawnscriptable( "capricorn_turret_shield", struct.origin );
        struct.shield = shield;
    }
    
    struct.shield setscriptablepartstate( "shield_base", "shield_activate" );
}

// Namespace mp_sat_ob_capricorn_forge
// Params 1, eflags: 0x4
// Checksum 0x8918e83e, Offset: 0x25b0
// Size: 0xad
function private function_20736b27337d3559( struct )
{
    if ( struct.shield )
    {
        struct.shield utility::delaycall( 1.25, &freescriptable );
    }
    
    foreach ( player in level.players )
    {
        player thread ob_story_mission_utils::function_5a707116af438c92();
    }
}

// Namespace mp_sat_ob_capricorn_forge
// Params 0, eflags: 0x4
// Checksum 0x811a7d23, Offset: 0x2665
// Size: 0x398
function private function_d27e99530e486ded()
{
    function_c1412872e70aa28b( "capricorn_forge_elevator_button_outside", "unlocked" );
    thread mp_sat_ob_capricorn_vo::function_28b4b60636d0796f();
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "capricorn_forge_elevator", { #objective:"sat_ob_objectivemarker_storymissionmain", #waypoint:"sat_ob_objectivemarker_location" }, "capricorn_forge_security_room_computer_done", undefined, undefined, 1, 1, 0, undefined, undefined, undefined, undefined, ( 0, -1.2, 16 ) );
    level thread mp_sat_ob_capricorn::function_776ea74dd9e92d46( "forge_turret_fight_start", "capricorn_forge_elevator" );
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_FORGE_REACH_ELEVATOR" );
    
    foreach ( player in level.players )
    {
        player thread ob_story_mission_utils::function_6d307def1435e5d5();
    }
    
    utility::trigger_on( "forge_turret_intro_trigger", #targetname );
    level waittill( #"forge_turret_intro" );
    level utility::flag_set( "forge_turret_fight_start" );
    turret_col = getent( "capricorne_forge_turret_collision", "targetname" );
    turret_col show();
    turret_placement_struct = utility::getstruct( "forge_turret_placement", "targetname" );
    utility::delaythread( 1.25, &function_73b87cfe02a19e1e, turret_placement_struct );
    scene_struct = utility::getstruct( "sat_cin_cap_310_forge_turret_intro" );
    scene_props = getentarray( "scene_prop_forge_turret_intro", #targetname );
    playrumblelooponposition( "damage_light", scene_struct.origin );
    scene_struct scene::play( scene_props );
    stopallrumbles();
    function_20736b27337d3559( turret_placement_struct );
    level.var_3d9fc7aa7b25b565.var_e86ebbbb4a2df1 = function_a6312b3128e81e5();
    thread function_bc832bac939dba19( level.var_3d9fc7aa7b25b565.var_e86ebbbb4a2df1 );
    thread function_9ca0ce7e2d3b5f68( level.var_3d9fc7aa7b25b565.var_e86ebbbb4a2df1 );
    add_turret_shield( level.var_3d9fc7aa7b25b565.var_e86ebbbb4a2df1 );
    level thread moving_platforms::moving_platforms_init();
    a_moving_platforms = getentarray( "moving_platform", #script_noteworthy )[ 0 ];
    
    foreach ( wall in a_moving_platforms.var_bef131da06a9a52e )
    {
        wall thread play_loop_sound_on_wall();
    }
    
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_FORGE_DESTROY_TURRET" );
    level.var_3d9fc7aa7b25b565.var_e86ebbbb4a2df1 setturretholdstill( 0 );
    level.var_3d9fc7aa7b25b565.var_e86ebbbb4a2df1.is_fight_started = 1;
    utility::flag_wait( "flag_forge_turret_destroyed" );
    
    foreach ( player in level.players )
    {
        player thread ob_story_mission_utils::function_2e1c3a1a4f92857d();
    }
}

// Namespace mp_sat_ob_capricorn_forge
// Params 0, eflags: 0x4
// Checksum 0xe21f752b, Offset: 0x2a05
// Size: 0x49
function private play_loop_sound_on_wall()
{
    level endon( #"game_ended" );
    level endon( #"forge_activity_complete" );
    soundlength = lookupsoundlength( "emt_forge_turret_wall_lp" ) / 1000;
    
    while ( true )
    {
        self playsoundonmovingent( "emt_forge_turret_wall_lp" );
        wait soundlength;
    }
}

// Namespace mp_sat_ob_capricorn_forge
// Params 0, eflags: 0x4
// Checksum 0x10004cce, Offset: 0x2a56
// Size: 0x4e3
function private function_dc072b67f948fc47()
{
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_c64b9e01025b34ef" ][ #"unlock" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( "forge_door_turret_to_elevator_passage" );
    }
    
    thread mp_sat_ob_capricorn_vo::function_743fe0fa381b8be4();
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_FORGE_REACH_ELEVATOR" );
    function_7e932e688a9b94f9( utility::getstruct( "interact_forge_infiltrate" ).origin, self, "flag_elevator_second_interact", "capricorn_forge_elevator" );
    function_c1412872e70aa28b( "capricorn_forge_elevator_button_outside", "accepted" );
    var_ae6ffb7208c71 = utility::getstructarray( "interact_forge_infiltrate", "targetname" );
    
    if ( isdefined( var_ae6ffb7208c71 ) && var_ae6ffb7208c71.size > 0 )
    {
        capricorn_audio::function_fe35739e161d0c5d( var_ae6ffb7208c71[ 0 ].origin - ( 30, 0, 0 ) );
    }
    
    elevator_door = getscriptablearray( "forge_arena_lift_door", "targetname" );
    
    if ( isdefined( elevator_door ) && elevator_door.size > 0 )
    {
        capricorn_audio::function_4537eb28a10b8825( elevator_door[ 0 ].origin );
    }
    
    level utility::flag_set( "forge_elevator_vo_going_down" );
    wait 3;
    playrumbleonposition( "capricorn_world_light", var_ae6ffb7208c71[ 0 ].origin );
    elevator_doors = getscriptablearray( "forge_arena_lift_door", #targetname );
    var_a7165335e6116f30 = getent( "forge_elevator_door_down", "targetname" );
    var_f4ad079a3e073cc8 = getent( "forge_elevator_door_top", "targetname" );
    var_a7165335e6116f30 linkto( elevator_doors[ 0 ], "j_door_02" );
    var_f4ad079a3e073cc8 linkto( elevator_doors[ 0 ], "j_door_01" );
    var_a7165335e6116f30 connectpaths();
    var_f4ad079a3e073cc8 connectpaths();
    level thread utility::flag_set_delayed( "forge_ambush_2_start", 0.5 );
    
    foreach ( door in elevator_doors )
    {
        door setscriptablepartstate( "main", "open" );
    }
    
    thread activity_ai_encounters::function_e9091e3a4b3537eb( self, "forge_encounter_elevator", "forge_elevator_encounter_completed", 4 );
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_FORGE_USE_ELEVATOR" );
    level utility::flag_wait( "forge_elevator_encounter_completed" );
    restricted_area_elevator_doors = getscriptablearray( "restricted_area_elevator_door", #targetname );
    
    foreach ( player in level.players )
    {
        player setadditionalstreamposuntilcleared( restricted_area_elevator_doors[ 0 ].origin );
    }
    
    interactstruct = utility::getstruct( "interact_forge_elevator" );
    interact = interaction::register_interact( interactstruct.origin, 64, &function_319b660aad98ed4e, &"jup_ob_objectives/interact_activate" );
    interact setcursorhint( "HINT_BUTTON" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "capricorn_forge_elevator_inside", { #objective:"sat_ob_objectivemarker_storymissionmain", #waypoint:"sat_ob_objectivemarker_location" }, "capricorn_forge_elevator_inside_done", undefined, undefined, 1, 1, 0, undefined, undefined, undefined, undefined, ( 0, -1.2, 16 ) );
    level thread mp_sat_ob_capricorn::function_776ea74dd9e92d46( "flag_forge_elevator_interact_done", "capricorn_forge_elevator_inside" );
    level waittill( #"flag_forge_elevator_interact_done", player );
    thread capricorn_audio::function_fe35739e161d0c5d( ( -6555, -25518, 740 ) );
    var_ba7c3b8fa9d3823 = spawnstruct();
    var_ba7c3b8fa9d3823.origin = ( -6623.75, -25520.6, 690 );
    options = spawnstruct();
    options.flag_countdown = "player_regroup_forge_elevator_completed";
    options.var_ba7c3b8fa9d3823 = var_ba7c3b8fa9d3823;
    options.fadestartnone = 1;
    options.var_227ead15d2892709 = 1;
    options.var_560eecb53e318cbf = 1;
    options.triggerradius = 400;
    thread coop::function_164d95b45992525( options );
    level utility::flag_wait( "player_regroup_forge_elevator_completed" );
    
    foreach ( player in level.players )
    {
        level thread game_utility::fadetoblackforplayer( player, 1, 1 );
    }
    
    wait 1;
}

// Namespace mp_sat_ob_capricorn_forge
// Params 4, eflags: 0x4
// Checksum 0x9b0cb547, Offset: 0x2f41
// Size: 0xb5
function private function_7ecf430fe977196b( activity_instance, center_struct_targetname, flag_on_complete, countdown_time = 5 )
{
    var_30be74fbdfe5bbae = utility::getstruct( center_struct_targetname, "targetname" );
    teleport_structs = var_30be74fbdfe5bbae utility::get_linked_structs();
    var_678759dcf4f532b7 = { #var_30be74fbdfe5bbae:var_30be74fbdfe5bbae, #teleport_structs:teleport_structs, #seconds_before_teleport:countdown_time, #countdown_time:countdown_time, #flag_on_complete:flag_on_complete, #activity_instance:activity_instance, #id:center_struct_targetname };
    return var_678759dcf4f532b7;
}

// Namespace mp_sat_ob_capricorn_forge
// Params 3, eflags: 0x4
// Checksum 0x7787160b, Offset: 0x2fff
// Size: 0xb3
function private setup_puzzle_computer( struct_targetname, puzzle_layout, var_490060d47d9e122a )
{
    interactstruct = utility::getstruct( struct_targetname );
    connection_puzzle_init( puzzle_layout, var_490060d47d9e122a );
    interactstruct.interact = interaction::register_interact( interactstruct.origin, 64, &function_3c166d76f9c020be, &"jup_ob_objectives/interact_activate" );
    interactstruct.interact setcursorhint( "HINT_BUTTON" );
    interactstruct.interact thread ob_story_mission_utils::function_e89ed2a08ce38bbf( struct_targetname, level.connection_puzzle_asset );
    interactstruct.interact.var_490060d47d9e122a = var_490060d47d9e122a;
}

// Namespace mp_sat_ob_capricorn_forge
// Params 2
// Checksum 0x7f041fad, Offset: 0x30ba
// Size: 0x56
function connection_puzzle_init( puzzle_layout, var_490060d47d9e122a )
{
    asset = hashcat( %"scriptedwidget:", "scripted_widget_connection_puzzle_3side_4player_sat_default" );
    thread connection_puzzle::init_from_layout( asset, puzzle_layout, var_490060d47d9e122a, undefined, "scripted_widget_connection_puzzle_3side_4player_sat_default_spectator" );
    level.connection_puzzle_asset = asset;
    thread function_2e122204a2a9f941();
}

// Namespace mp_sat_ob_capricorn_forge
// Params 0, eflags: 0x4
// Checksum 0x73a32830, Offset: 0x3118
// Size: 0xac
function private function_2e122204a2a9f941()
{
    level endon( #"death" );
    
    while ( true )
    {
        level waittill( #"ConnectionPuzzleCompleted", data );
        
        foreach ( player in data.players )
        {
            player notify( #"ConnectionPuzzleCompleted" );
        }
    }
}

// Namespace mp_sat_ob_capricorn_forge
// Params 1, eflags: 0x4
// Checksum 0x5dfc7cc8, Offset: 0x31cc
// Size: 0x2f3
function private function_3c166d76f9c020be( puzzle_player )
{
    if ( !val::get( "allow_connection_puzzle" ) )
    {
        return;
    }
    
    self makeunusable();
    level utility::flag_set( "flag_vo_hacking_started" );
    level notify( #"forge_security_computer_activated" );
    puzzle_player thread mp_sat_ob_libra_util::start_interact_scene( "capricorn_puzzle_interact_scene" );
    
    if ( puzzle_player connection_puzzle::open( level.connection_puzzle_asset, self.var_490060d47d9e122a ) )
    {
        [ var_190f59357d8260f7 ] = getscriptablearray( "forge_puzzle_console", "targetname" );
        var_190f59357d8260f7 setscriptablepartstate( #"base", #"hash_cacbbd1f76200a42" );
        
        foreach ( spectator in level.players )
        {
            if ( spectator != puzzle_player )
            {
                spectator thread connection_puzzle::open( level.connection_puzzle_asset, self.var_490060d47d9e122a, 1 );
            }
        }
        
        finished = puzzle_player utility::waittill_any_return( "ConnectionPuzzleClosed", "ConnectionPuzzleCompleted", "death_or_disconnect" );
        
        if ( puzzle_player )
        {
            puzzle_player mp_sat_ob_libra_util::function_d68eec31414afe2e( "capricorn_puzzle_interact_scene" );
        }
        
        if ( finished == "ConnectionPuzzleCompleted" || connection_puzzle::is_instance_complete( level.connection_puzzle_asset, self.var_490060d47d9e122a ) )
        {
            var_190f59357d8260f7 setscriptablepartstate( #"base", #"circuit_operational" );
            
            foreach ( player in level.players )
            {
                if ( player == puzzle_player )
                {
                    player connection_puzzle::close();
                    continue;
                }
                
                player connection_puzzle::close_spectator( level.connection_puzzle_asset, self.var_490060d47d9e122a );
            }
            
            level notify( #"hash_3293189006eb45ee", puzzle_player );
            level.activity_instance ob_story_mission_utils::objective_marker_clear( self.objective );
            self delete();
        }
        else
        {
            waitframe();
            
            if ( var_190f59357d8260f7 )
            {
                var_190f59357d8260f7 setscriptablepartstate( #"base", #"circuit_interrupted" );
            }
            
            self makeusable();
            interaction::set_interact_hint_string( &"jup_ob_objectives/interact_activate" );
        }
        
        return;
    }
    
    if ( puzzle_player )
    {
        puzzle_player mp_sat_ob_libra_util::function_d68eec31414afe2e( "capricorn_puzzle_interact_scene" );
    }
    
    waitframe();
    var_190f59357d8260f7 setscriptablepartstate( #"base", #"circuit_interrupted" );
    self makeusable();
    interaction::set_interact_hint_string( &"jup_ob_objectives/interact_activate" );
}

// Namespace mp_sat_ob_capricorn_forge
// Params 1, eflags: 0x4
// Checksum 0xc2d093e9, Offset: 0x34c7
// Size: 0x32
function private function_319b660aad98ed4e( player )
{
    function_c1412872e70aa28b( "capricorn_forge_elevator_button_inside", "accepted" );
    level utility::flag_set( "flag_forge_elevator_interact_done", player );
    self delete();
}

// Namespace mp_sat_ob_capricorn_forge
// Params 0, eflags: 0x4
// Checksum 0x5743ca5c, Offset: 0x3501
// Size: 0x112
function private capricorn_forge_cleanup()
{
    past_activity_array = [ "OB_CAPRICORN_INTRO", "OB_CAPRICORN_BOAT", "OB_CAPRICORN_HIJACK", "OB_CAPRICORN_HIJACK_VIP", "OB_CAPRICORN_HIJACK_BOSS", "OB_CAPRICORN_HIJACK_THROTTLE" ];
    
    foreach ( activity in past_activity_array )
    {
        if ( level.activities.types[ activity ] && level.activities.types[ activity ].commonfunctions[ 9 ] )
        {
            [[ level.activities.types[ activity ].commonfunctions[ 9 ] ]]();
        }
    }
}

// Namespace mp_sat_ob_capricorn_forge
// Params 3, eflags: 0x4
// Checksum 0xd945ac1c, Offset: 0x361b
// Size: 0xca
function private spawnaiencounter( encounter_targetname, activity_instance, shutdown_callback = undefined )
{
    encounter_ids = activity_instance activity_ai_encounters::function_dd54dae45031dade( encounter_targetname, 1, 1, 2, 1 );
    
    foreach ( encounter_id in encounter_ids )
    {
        activity_ai_encounters::function_202051e510314502( encounter_id, &function_10ce9a6dcccdd4a0, activity_instance );
        
        if ( isdefined( shutdown_callback ) )
        {
            ai_spawn_director::function_a49c35b72d6b6fea( encounter_id, shutdown_callback );
        }
    }
}

// Namespace mp_sat_ob_capricorn_forge
// Params 2, eflags: 0x4
// Checksum 0xd5a51d43, Offset: 0x36ed
// Size: 0x1f
function private function_10ce9a6dcccdd4a0( request_id, activity_instance )
{
    activity_instance activity_ai_encounters::function_43917fc6522a277( request_id );
}

// Namespace mp_sat_ob_capricorn_forge
// Params 0, eflags: 0x4
// Checksum 0x4c966337, Offset: 0x3714
// Size: 0x278
function private function_a6312b3128e81e5()
{
    turret_placement_struct = utility::getstruct( "forge_turret_placement", "targetname" );
    turret = spawnturret( "misc_turret", turret_placement_struct.origin, "sat_turret_capricorn_forge", 1, 0, 0 );
    turret setmodel( "sat_machinery_turret_capricorn_01" );
    turret setturretteam( "team_hundred_ninety" );
    turret setmode( "sentry" );
    turret maketurretinoperable();
    turret turretfireenable();
    turret laseron();
    turret shootturret();
    turret.empapplycallback = &turret_emp_callback;
    turret.using_fake_health = 1;
    turret.is_fight_started = 0;
    var_cfe0f5bcb6672c23 = level.players.size;
    turret.maxhealth = 4200 * var_cfe0f5bcb6672c23;
    turret.health = turret.maxhealth;
    turret.var_d165d33ad4f00e17 = turret.maxhealth;
    turret.var_cce7c67ea2da8902 = turret.var_d165d33ad4f00e17;
    
    foreach ( player in level.players )
    {
        player thread function_9c9cfeb53c7bd46( turret );
    }
    
    level.var_3d9fc7aa7b25b565.var_4ebc9132080845b1 = 1;
    level.var_3d9fc7aa7b25b565.turret_firerate = 0.15;
    waitframe();
    turret.team = "team_hundred_ninety";
    visibility_mode::function_3afc3bc470c80e61( turret, turret.team );
    level notify( #"highvis_reload_outline", turret.team, [ turret ] );
    
    if ( level.current_activity.type != "OB_CAPRICORN_FORGE_02" )
    {
        turret utility::delaycall( 2, &setturretholdstill, 1 );
    }
    
    disable_turret_damage( turret );
    turret utility::callsharedfunc( #"gametype", #"hash_cbc683d4d23144e5", "ob_capricorn_forge_turret" );
    utility::registersharedfunc( "ob_capricorn_forge_turret", #"hack", &function_9722fb2aa5869114 );
    return turret;
}

// Namespace mp_sat_ob_capricorn_forge
// Params 1, eflags: 0x4
// Checksum 0x87092873, Offset: 0x3995
// Size: 0x108
function private add_turret_shield( turret )
{
    if ( !isdefined( turret.shield ) )
    {
        shield = spawnscriptable( "capricorn_turret_shield", turret.origin );
        turret.shield = shield;
    }
    
    foreach ( player in level.players )
    {
        player ob_story_mission_utils::player_boss_healthbar_immune();
    }
    
    turret.shield setscriptablepartstate( "shield_base", "shield_activate" );
    disable_turret_damage( turret );
    thread turret_shield_hint_think( turret );
    level utility::flag_set( "flag_vo_forge_turret_shield_up" );
    turret.shield_activated = 1;
}

// Namespace mp_sat_ob_capricorn_forge
// Params 1, eflags: 0x4
// Checksum 0xb31401e, Offset: 0x3aa5
// Size: 0xcf
function private remove_turret_shield( turret )
{
    turret.shield setscriptablepartstate( "shield_base", "shield_deactivate" );
    
    foreach ( player in level.players )
    {
        player ob_story_mission_utils::player_boss_healthbar_show();
    }
    
    enable_turret_damage( turret );
    turret notify( #"hash_9053d0f833e0330c" );
    level utility::flag_set( "flag_vo_forge_turret_shield_down" );
    turret.shield_activated = 0;
}

// Namespace mp_sat_ob_capricorn_forge
// Params 1, eflags: 0x4
// Checksum 0xdd9d516d, Offset: 0x3b7c
// Size: 0x294
function private function_9ca0ce7e2d3b5f68( turret )
{
    level endon( #"game_ended" );
    turret endon( #"delete" );
    var_75c29438c0eea557 = 0;
    reinforcement_thresholds = [ 0.6, 0.3 ];
    var_aa5f9f1f01fab7ef = 0;
    damage_thresholds = [ 0.75, 0.5, 0.25 ];
    var_e468bc5a04ba0028 = [ 1, 1.25, 1.5, 2 ];
    
    while ( true )
    {
        turret waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath );
        
        if ( damage_effects::function_ae27c589e09c3181( meansofdeath ) )
        {
            explosive_multiplier = 3 * var_e468bc5a04ba0028[ level.players.size - 1 ];
            extra_explosive_damage = int( damage * explosive_multiplier );
            turret.health -= extra_explosive_damage;
        }
        
        turret.var_cce7c67ea2da8902 = turret.health;
        is_dead = turret.health <= 0;
        function_11ed6b0fa420b128( attacker, turret, is_dead );
        var_b5c2fe7aa3f65b1b = turret.health / turret.maxhealth;
        
        foreach ( player in level.players )
        {
            player ob_story_mission_utils::function_e231206f1628d4c6( 1 );
        }
        
        if ( var_b5c2fe7aa3f65b1b <= reinforcement_thresholds[ var_75c29438c0eea557 ] )
        {
            var_75c29438c0eea557++;
            thread function_a78f47162649441d( var_75c29438c0eea557 );
        }
        
        if ( var_b5c2fe7aa3f65b1b <= damage_thresholds[ var_aa5f9f1f01fab7ef ] )
        {
            var_aa5f9f1f01fab7ef++;
            turret setscriptablepartstate( "damage_state", "damage_state_" + var_aa5f9f1f01fab7ef );
            turret playrumbleonentity( "damage_med" );
            
            /#
                iprintlnbold( "<dev string:x24>" + var_aa5f9f1f01fab7ef + "<dev string:x32>" );
            #/
        }
        
        if ( is_dead )
        {
            thread function_13619740100486b( turret );
            turret playrumbleonentity( "damage_heavy" );
            visibility_mode::function_4e6c654251b854e0( turret );
            break;
        }
    }
}

// Namespace mp_sat_ob_capricorn_forge
// Params 1, eflags: 0x4
// Checksum 0x760ea4f6, Offset: 0x3e18
// Size: 0x11e
function private function_a78f47162649441d( reinforcement_wave_number )
{
    add_turret_shield( level.var_3d9fc7aa7b25b565.var_e86ebbbb4a2df1 );
    scene_struct = utility::getstruct( "sat_scene_cin_forge_turret_flyover_vtol" );
    scene_struct thread scene::play();
    level waittill( #"305_drop_bot" );
    wave_name = "forge_encounter_turret_wave_0" + reinforcement_wave_number;
    [ id, bots ] = activity_ai_encounters::function_e9091e3a4b3537eb( self, wave_name, wave_name + "_completed", 4 );
    
    foreach ( bot in bots )
    {
        bot thread function_50e63e1edbbfc24b();
    }
    
    /#
        iprintlnbold( wave_name + "<dev string:x40>" );
    #/
}

// Namespace mp_sat_ob_capricorn_forge
// Params 0, eflags: 0x4
// Checksum 0x8d499482, Offset: 0x3f3e
// Size: 0xae
function private function_50e63e1edbbfc24b()
{
    self endon( #"death" );
    level.var_3d9fc7aa7b25b565.var_e86ebbbb4a2df1 endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker );
        
        if ( attacker == level.var_3d9fc7aa7b25b565.var_e86ebbbb4a2df1 )
        {
            extra_damage = damage * 3;
            
            if ( self.health - extra_damage <= 0 )
            {
                self kill();
                continue;
            }
            
            self.health -= extra_damage;
        }
    }
}

// Namespace mp_sat_ob_capricorn_forge
// Params 1, eflags: 0x4
// Checksum 0x4d25380c, Offset: 0x3ff4
// Size: 0x199
function private turret_shield_hint_think( turret )
{
    turret endon( #"hash_9053d0f833e0330c" );
    level utility::flag_wait_any( "vo_turret_shield_hint_done", "flag_vo_forge_turret_shield_down" );
    
    if ( !level.var_fe17a6b46d22b55b )
    {
        foreach ( player in level.players )
        {
            player utility::callsharedfunc( #"hint", #"add_simple", "hint_turret_shield", &"sat_ob_story_missions_capricorn/turret_shield_hint", 10 );
        }
        
        level.var_fe17a6b46d22b55b = 1;
    }
    
    while ( true )
    {
        if ( !turret.shield_activated )
        {
            level waittill( #"flag_vo_forge_turret_shield_up" );
        }
        
        wait 15;
        
        foreach ( player in level.players )
        {
            player utility::callsharedfunc( #"hint", #"add_simple", "hint_turret_shield", &"sat_ob_story_missions_capricorn/turret_shield_hint", 10 );
        }
        
        wait 10;
    }
}

// Namespace mp_sat_ob_capricorn_forge
// Params 1
// Checksum 0xfa7f4945, Offset: 0x4195
// Size: 0x4c
function turret_emp_callback( data )
{
    turret = data.victim;
    
    if ( !turret.is_fight_started || !turret.shield_activated )
    {
        return;
    }
    
    remove_turret_shield( turret );
}

// Namespace mp_sat_ob_capricorn_forge
// Params 2
// Checksum 0x65cfe93f, Offset: 0x41e9
// Size: 0x3a
function function_9722fb2aa5869114( hack_effect, attacker )
{
    if ( hack_effect.var_bdd964bba0312052 )
    {
        thread function_b45b439eb61905d0( hack_effect, attacker );
        return;
    }
    
    thread function_9fcec6eda030ccee( hack_effect, attacker );
}

// Namespace mp_sat_ob_capricorn_forge
// Params 2
// Checksum 0xd929eab8, Offset: 0x422b
// Size: 0x4d
function function_b45b439eb61905d0( hack_effect, attacker )
{
    self notify( #"turret_hacked" );
    self endon( #"turret_hacked" );
    function_318599ef0afe4b25();
    wait hack_effect.hackduration * 0.001;
    function_9496a0dcac06e0ac();
}

// Namespace mp_sat_ob_capricorn_forge
// Params 2
// Checksum 0xdb92c0f0, Offset: 0x4280
// Size: 0x13e
function function_9fcec6eda030ccee( hack_effect, attacker )
{
    self notify( #"turret_hacked" );
    self cleartargetentity();
    self setturretteam( attacker.team );
    self.team = attacker.team;
    self.owningteam = attacker.team;
    level.var_3d9fc7aa7b25b565.var_4ebc9132080845b1 = 7;
    level.var_3d9fc7aa7b25b565.turret_firerate = 0.05;
    utility::ent_flag_set( "turned" );
    function_9496a0dcac06e0ac();
    wait hack_effect.hackduration * 0.001;
    self setmode( "sentry_offline" );
    self cleartargetentity();
    wait 0.5;
    self setmode( "sentry" );
    black_hat::function_c01f5daeb3575bca( self );
    self cleartargetentity();
    self setturretteam( "team_hundred_ninety" );
    self.team = undefined;
    self.owningteam = undefined;
    level.var_3d9fc7aa7b25b565.var_4ebc9132080845b1 = 1;
    level.var_3d9fc7aa7b25b565.turret_firerate = 0.15;
    utility::ent_flag_clear( "turned" );
}

// Namespace mp_sat_ob_capricorn_forge
// Params 0, eflags: 0x4
// Checksum 0x8e29a8f8, Offset: 0x43c6
// Size: 0x33
function private function_318599ef0afe4b25()
{
    self setturretholdstill( 1 );
    self setmode( "sentry_offline" );
    self setscriptablepartstate( "empd", "active", 0 );
    self cleartargetentity();
    self function_e00f522b371cd46d( 0 );
}

// Namespace mp_sat_ob_capricorn_forge
// Params 0, eflags: 0x4
// Checksum 0xf09d900e, Offset: 0x4401
// Size: 0x22
function private function_2c9b2a36bcbe1ece()
{
    self setturretholdstill( 1 );
    self setmode( "sentry_offline" );
    self cleartargetentity();
    self function_e00f522b371cd46d( 0 );
}

// Namespace mp_sat_ob_capricorn_forge
// Params 0, eflags: 0x4
// Checksum 0x291abf30, Offset: 0x442b
// Size: 0x33
function private function_9496a0dcac06e0ac()
{
    self cleartargetentity();
    self setturretholdstill( 0 );
    self setmode( "sentry" );
    self setscriptablepartstate( "empd", "neutral", 0 );
    self function_e00f522b371cd46d( 1 );
}

// Namespace mp_sat_ob_capricorn_forge
// Params 1, eflags: 0x4
// Checksum 0xd29b811c, Offset: 0x4466
// Size: 0x34
function private enable_turret_damage( turret )
{
    if ( !isstruct( turret ) )
    {
        turret setcandamage( 1 );
    }
    
    turret val::set( "turret", "show_healthbar", 1 );
}

// Namespace mp_sat_ob_capricorn_forge
// Params 1, eflags: 0x4
// Checksum 0x1ac52556, Offset: 0x44a2
// Size: 0x32
function private disable_turret_damage( turret )
{
    if ( !isstruct( turret ) )
    {
        turret setcandamage( 0 );
    }
    
    turret val::set( "turret", "show_healthbar", 0 );
}

// Namespace mp_sat_ob_capricorn_forge
// Params 3, eflags: 0x4
// Checksum 0xe1dbd1bd, Offset: 0x44dc
// Size: 0x74
function private function_11ed6b0fa420b128( attacker, victim, is_dead )
{
    if ( isplayer( attacker ) )
    {
        attacker damagefeedback::updatehitmarker( "standard", is_dead, 0, 0, undefined, undefined, undefined, undefined, 1, undefined, 1 );
        attacker utility::callsharedfunc( #"hud", #"hash_84d4f784de00c6af", is_dead ? 1 : 0, { #victimentity:victim } );
    }
}

// Namespace mp_sat_ob_capricorn_forge
// Params 1, eflags: 0x4
// Checksum 0xfa416e2c, Offset: 0x4558
// Size: 0x1a1
function private function_13619740100486b( turret )
{
    turret notify( #"death" );
    turret laseroff();
    
    foreach ( player in level.players )
    {
        player ob_story_mission_utils::function_5a707116af438c92();
    }
    
    if ( isdefined( level._effect[ "vfx_sat_ob_capricorn_turret_destroy" ] ) )
    {
        playfxontag( level._effect[ "vfx_sat_ob_capricorn_turret_destroy" ], turret, "tag_fx" );
    }
    
    turret setscriptablepartstate( "damage_state", "husk" );
    utility::flag_set( "flag_forge_turret_destroyed" );
    disable_turret_damage( turret );
    turret function_2c9b2a36bcbe1ece();
    turret.empapplycallback = undefined;
    turret.shield freescriptable();
    turret.shield = undefined;
    
    foreach ( player in level.players )
    {
        player thread points::doscoreevent( #"elimination_kill_boss" );
    }
    
    turret notify( #"hash_9053d0f833e0330c" );
}

// Namespace mp_sat_ob_capricorn_forge
// Params 1, eflags: 0x4
// Checksum 0x9649d921, Offset: 0x4701
// Size: 0x12a
function private function_bc832bac939dba19( turret )
{
    level endon( #"game_ended" );
    turret endon( #"delete" );
    turret endon( #"death" );
    turret endon( #"disable" );
    last_valid_target = undefined;
    
    while ( true )
    {
        turret waittill( #"turret_on_target" );
        target = turret getturrettarget( 0 );
        
        if ( last_valid_target != target )
        {
            wait function_7f588dac1c054f43( 0.3, 0.3 );
        }
        
        if ( isalive( target ) )
        {
            turret settargetentity( target );
            last_valid_target = target;
            var_ff6e823332ba408e = function_7f588dac1c054f43( 10, 10 ) * level.var_3d9fc7aa7b25b565.var_4ebc9132080845b1;
            
            for ( i = 0; i < var_ff6e823332ba408e ; i++ )
            {
                turret shootturret();
                wait level.var_3d9fc7aa7b25b565.turret_firerate;
            }
            
            wait function_7f588dac1c054f43( 0, 0 );
            
            if ( !isdefined( turret getturrettarget( 1 ) ) || target.ignoreme )
            {
                last_valid_target = undefined;
                turret cleartargetentity();
            }
        }
    }
}

// Namespace mp_sat_ob_capricorn_forge
// Params 3, eflags: 0x4
// Checksum 0x22d46fd0, Offset: 0x4833
// Size: 0x31
function private function_7af53bcf78c900ef( window, var_440f94388d9864a2, time )
{
    window movez( var_440f94388d9864a2, time );
    wait time;
    window delete();
}

// Namespace mp_sat_ob_capricorn_forge
// Params 2, eflags: 0x4
// Checksum 0x760e5cf7, Offset: 0x486c
// Size: 0x100
function private movewindows( window_targetname, fallback_z_offset )
{
    window_entities = getentarray( window_targetname, #targetname );
    
    foreach ( window in window_entities )
    {
        sound_alias = window.script_parameters;
        
        if ( sound_alias )
        {
            snd::play( sound_alias, window.origin );
        }
        
        window_z_offset = window.script_noteworthy ? float( window.script_noteworthy ) : fallback_z_offset;
        thread function_7af53bcf78c900ef( window, window_z_offset, window_z_offset / 50 );
    }
}

// Namespace mp_sat_ob_capricorn_forge
// Params 2, eflags: 0x4
// Checksum 0x5e5049f8, Offset: 0x4974
// Size: 0x35
function private function_7f588dac1c054f43( min, max )
{
    var_ddf24b010015c8af = min;
    
    if ( min != max )
    {
        var_ddf24b010015c8af = randomintrange( min, max );
    }
    
    return var_ddf24b010015c8af;
}

// Namespace mp_sat_ob_capricorn_forge
// Params 4, eflags: 0x4
// Checksum 0x7bf0e10a, Offset: 0x49b2
// Size: 0xd7
function private function_7e932e688a9b94f9( var_cbf2696af3924e4b, activity_instance, flag_set_on_interact, waypoint_struct_targetname )
{
    interact = interaction::register_interact( var_cbf2696af3924e4b, 64, &function_6d623f7ffc160e54, &"jup_ob_objectives/interact_activate" );
    interact setcursorhint( "HINT_BUTTON" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, waypoint_struct_targetname, { #objective:"sat_ob_objectivemarker_storymissionmain", #waypoint:"sat_ob_objectivemarker_location" }, waypoint_struct_targetname + "_done", undefined, undefined, 1, 1, 0, undefined, undefined, undefined, undefined, ( 0, -1.2, 16 ) );
    level thread mp_sat_ob_capricorn::function_776ea74dd9e92d46( flag_set_on_interact, waypoint_struct_targetname );
    interact.activity_instance = self;
    
    if ( flag_set_on_interact )
    {
        interact.flag_set_on_interact = flag_set_on_interact;
    }
    
    interact waittill( #"trigger" );
}

// Namespace mp_sat_ob_capricorn_forge
// Params 1, eflags: 0x4
// Checksum 0x30dabe7, Offset: 0x4a91
// Size: 0x2e
function private function_6d623f7ffc160e54( player )
{
    if ( self.flag_set_on_interact )
    {
        utility::flag_set( self.flag_set_on_interact );
    }
    
    self delete();
}

// Namespace mp_sat_ob_capricorn_forge
// Params 0
// Checksum 0xfebfe6f0, Offset: 0x4ac7
// Size: 0x7e
function setup_force_fields()
{
    mp_sat_ob_libra_util::function_7e4765db24e0ee73( "on", "forge_ff", #targetname );
    
    if ( level.current_activity.type != "OB_CAPRICORN_FORGE_02" && level.current_activity.type != "OB_CAPRICORN_FORGE_RETURN_TO_ELEVATOR" )
    {
        mp_sat_ob_libra_util::function_7e4765db24e0ee73( "on", "forge_center_ff", #targetname );
        return;
    }
    
    mp_sat_ob_capricorn::function_d1e2187515b5099f( "forge_center_ff" );
}

// Namespace mp_sat_ob_capricorn_forge
// Params 2, eflags: 0x4
// Checksum 0xd4f5ea27, Offset: 0x4b4d
// Size: 0xa6
function private function_c1412872e70aa28b( targetname, state )
{
    buttons = getentitylessscriptablearray( targetname, #targetname );
    waitframe();
    
    foreach ( button in buttons )
    {
        button setscriptablepartstate( "base", state );
    }
}

// Namespace mp_sat_ob_capricorn_forge
// Params 1, eflags: 0x4
// Checksum 0x18fa8c42, Offset: 0x4bfb
// Size: 0x172
function private function_87bb8dbaf8307267( bot_targetname )
{
    forge_bots = utility::getstructarray( bot_targetname, "targetname" );
    
    foreach ( forge_bot in forge_bots )
    {
        forge_bot scene::add_spawn_function( &function_a39253451a32d0b, "Types_Actor" );
        forge_bot thread scene::play( undefined, "idle" );
    }
    
    var_6052b7a0ae05f74a = getnoentvolumearray( "encounter_forge_arena_bot", #targetname )[ 0 ];
    var_6052b7a0ae05f74a waittill( #"trigger" );
    level utility::flag_set( "flag_vo_forge_infiltrate_bots_activating" );
    
    foreach ( forge_bot in forge_bots )
    {
        delay_time = int( forge_bot.script_noteworthy ) ?? 0;
        forge_bot utility::delaythread( delay_time, &function_e8ebb051c1643ea7 );
    }
}

// Namespace mp_sat_ob_capricorn_forge
// Params 0, eflags: 0x4
// Checksum 0x4a72579d, Offset: 0x4d75
// Size: 0xdf
function private function_a39253451a32d0b()
{
    level.var_5b5e33f91adb40b0[ level.var_5b5e33f91adb40b0.size ] = self;
    self.var_c3c4d711e69d5ab9 = 1;
    self.ignoreme = 1;
    self.ignoreall = 1;
    self.kfe_ignore = 1;
    self.var_24954f14e27b448d = 0;
    self.var_2fc3a5fb762afb6e = 1;
    level notify( #"highvis_reload_outline", undefined, [ self ] );
    level utility::flag_wait( "flag_vo_forge_infiltrate_bots_activating" );
    utility::ent_flag_waitopen_any( "scene_active" );
    self.var_c3c4d711e69d5ab9 = 0;
    self.ignoreme = 0;
    self.ignoreall = 0;
    self.var_2fc3a5fb762afb6e = 0;
    level notify( #"highvis_reload_outline", undefined, [ self ] );
    self.var_24954f14e27b448d = 1;
    self waittill( #"death" );
    function_87c9dc12f3244d2d();
}

// Namespace mp_sat_ob_capricorn_forge
// Params 0, eflags: 0x4
// Checksum 0x4c8ad93d, Offset: 0x4e5c
// Size: 0x37
function private function_87c9dc12f3244d2d()
{
    level.var_5b5e33f91adb40b0 = utility::array_removedead_or_dying( level.var_5b5e33f91adb40b0 );
    
    if ( level.var_5b5e33f91adb40b0.size < 1 )
    {
        level utility::flag_set( "flag_forge_arena_bot_done" );
    }
}

// Namespace mp_sat_ob_capricorn_forge
// Params 0, eflags: 0x4
// Checksum 0xf8225180, Offset: 0x4e9b
// Size: 0x26
function private function_e8ebb051c1643ea7()
{
    exit_anim = "exit_0" + randomintrange( 1, 5 );
    thread scene::play( undefined, exit_anim );
}

// Namespace mp_sat_ob_capricorn_forge
// Params 0, eflags: 0x4
// Checksum 0x1506b6fa, Offset: 0x4ec9
// Size: 0x10a
function private function_b9a5374454ab942f()
{
    var_3d42f2a0af214c2a = getglassarray( "destroyedglass" );
    
    if ( level.current_activity.type == "OB_CAPRICORN_FORGE" )
    {
        foreach ( glass in var_3d42f2a0af214c2a )
        {
            destroyglass( glass );
        }
        
        return;
    }
    
    foreach ( glass in var_3d42f2a0af214c2a )
    {
        function_8630a81a78e13af7( glass );
    }
}

