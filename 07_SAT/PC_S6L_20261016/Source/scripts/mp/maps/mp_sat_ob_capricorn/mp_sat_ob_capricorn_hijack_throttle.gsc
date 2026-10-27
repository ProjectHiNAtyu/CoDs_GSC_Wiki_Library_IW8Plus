// scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_hijack_throttle.gsc  (hash_58d267a29a6a1d3f.gscc) (size: 5043 Bytes / 0x13b3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x97d34a9 (159200425)
// size ...... 5043 (0x13b3)
// includes .. 16  (offset: 0x11af)
// strings ... 27  (offset: 0x122f)
// dev strs .. 0   (offset: 0x13b3)
// exports ... 13  (offset: 0x9f3)
// cseg ...... 0x30a + 0x6e9 (0x9f3)
// imports ... 51  (offset: 0xbfb)
// animtree1 . 0   (offset: 0x13b3)
// animtree2 . 0   (offset: 0x13b3)
#using script_16d8789bae43669e;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\hud_util;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\interaction;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_hijack;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_hijack_vip;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_vo;

#namespace mp_sat_ob_capricorn_hijack_throttle;

// Namespace mp_sat_ob_capricorn_hijack_throttle
// Params 0, eflags: 0x5
// Checksum 0xf28eb065, Offset: 0x328
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_ob_capricorn_hijack_throttle", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace mp_sat_ob_capricorn_hijack_throttle
// Params 0, eflags: 0x4
// Checksum 0xdcfdb81a, Offset: 0x351
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_CAPRICORN_HIJACK_THROTTLE";
    activity_common::registeractivitytype( "OB_CAPRICORN_HIJACK_THROTTLE", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_CAPRICORN_HIJACK_THROTTLE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_CAPRICORN_HIJACK_THROTTLE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_CAPRICORN_HIJACK_THROTTLE", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_CAPRICORN_HIJACK_THROTTLE" );
}

// Namespace mp_sat_ob_capricorn_hijack_throttle
// Params 0
// Checksum 0x6d1bdd90, Offset: 0x3c8
// Size: 0x69
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    mp_sat_ob_capricorn::set_minimap( "hijacked" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace mp_sat_ob_capricorn_hijack_throttle
// Params 0
// Checksum 0x59eeb7e9, Offset: 0x439
// Size: 0x3d
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance main();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace mp_sat_ob_capricorn_hijack_throttle
// Params 0
// Checksum 0xdeef798c, Offset: 0x47e
// Size: 0x21
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    removeallcorpses();
}

// Namespace mp_sat_ob_capricorn_hijack_throttle
// Params 1
// Checksum 0x4875795c, Offset: 0x4a7
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread player_setup( player );
    }
}

// Namespace mp_sat_ob_capricorn_hijack_throttle
// Params 0
// Checksum 0xb6d3f43b, Offset: 0x563
// Size: 0xf
function start()
{
    activity_instance = self;
}

// Namespace mp_sat_ob_capricorn_hijack_throttle
// Params 0
// Checksum 0x79f04740, Offset: 0x57a
// Size: 0x298
function main()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    thread mp_sat_ob_capricorn_vo::function_70b337000fbf32e4();
    level waittill( #"trying_to_sink_us_done" );
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_HIJACK_THROTTLE" );
    throttle_prop = getent( "OB_CAPRICORN_HIJACK_THROTTLE_PROP", #targetname );
    throttle_prop.animname = "throttle_prop";
    throttle_prop.targetname = throttle_prop.animname;
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "capricorn_hijack_boat_throttle", { #objective:"sat_ob_objectivemarker_storymissionmain", #waypoint:"sat_ob_objectivemarker_location" }, "boat_lever_reached", undefined, undefined, 0, 1, 0, undefined, undefined, undefined, undefined, ( 0, -1.2, 16 ) );
    level thread mp_sat_ob_capricorn::function_776ea74dd9e92d46( "flag_boat_throttle_used", "capricorn_hijack_boat_throttle" );
    interact = interaction::register_interact( throttle_prop.origin + ( 0, 0, 10 ), 64, &function_ac6affd6dc1c6fb9, &"sat_ob_story_missions_capricorn/ob_capricorn_hijack_throttle_interact_title" );
    interact setcursorhint( "HINT_BUTTON" );
    level waittill( #"hash_34e06dca740f2612", throttle_player );
    interact delete();
    thread namespace_1f3f9eb1e9681da5::function_9dbeaf9ca833864( activity_instance, "player_catchup_hijack_throttle", "flag_computer_throttle_complete", 5, "flag_computer_throttle_begin", undefined, 1 );
    level utility::flag_set( "flag_boat_throttle_used" );
    thread function_9074a37b6899e0ed();
    throttle_player playrumbleonpositionforclient( "capricorn_throttle", throttle_player.origin );
    throttle_player coop::function_eb6e09941acb48e9();
    throttle_scene_struct = utility::getstruct( "sat_cin_cap_290_defend_throttle_vm" );
    throttle_scene_struct scene::play( [ throttle_prop, throttle_player ] );
    
    if ( throttle_player )
    {
        throttle_player stoprumble( "capricorn_throttle" );
    }
    
    structs = ob_story_mission_utils::get_activity_starts( "OB_CAPRICORN_FORGE" );
    utility::flag_wait( "flag_computer_throttle_complete" );
    options = spawnstruct();
    options.flag_countdown = "forge_crash_regroup_countdown_completed";
    options.flag = "forge_crash_cinematic_completed";
    options.timeout = 47;
    options.var_ba7c3b8fa9d3823 = throttle_player;
    options.structs = structs;
    options.noregroup = 1;
    level thread coop::play_cinematic( "sat_capricorn_boat_ram", options );
    utility::kill_exploder( "boats_vista" );
    utility::flag_wait( "forge_crash_regroup_countdown_completed" );
    throttle_area_swap();
    utility::flag_wait( "flag_hijack_throttle_done" );
}

// Namespace mp_sat_ob_capricorn_hijack_throttle
// Params 0, eflags: 0x4
// Checksum 0xd840c745, Offset: 0x81a
// Size: 0x135
function private function_9074a37b6899e0ed()
{
    wait 3.7;
    
    foreach ( player in level.players )
    {
        player thread hud_util::fade_out( 0.5 );
        player val::set( "cinematic", "show_hud", 0 );
    }
    
    utility::flag_wait( "forge_crash_cinematic_completed" );
    
    foreach ( player in level.players )
    {
        player thread hud_util::fade_in( 0.5 );
        player val::reset_all( "cinematic" );
    }
    
    level utility::flag_set( "flag_hijack_throttle_done" );
}

// Namespace mp_sat_ob_capricorn_hijack_throttle
// Params 1, eflags: 0x4
// Checksum 0xd424b632, Offset: 0x957
// Size: 0x1a
function private function_ac6affd6dc1c6fb9( player )
{
    level notify( #"hash_34e06dca740f2612", player );
}

// Namespace mp_sat_ob_capricorn_hijack_throttle
// Params 1, eflags: 0x4
// Checksum 0x97b8287b, Offset: 0x979
// Size: 0x34
function private player_setup( player )
{
    activity_instance = self;
    utility::callsharedfunc( #"gametype", #"hash_b64530c1428fda8", player );
}

// Namespace mp_sat_ob_capricorn_hijack_throttle
// Params 0
// Checksum 0xa6b229c5, Offset: 0x9b5
// Size: 0x3e
function throttle_area_swap()
{
    mp_sat_ob_capricorn_hijack::delete_hatch();
    mp_sat_ob_capricorn_hijack_vip::function_3016c03d17f0e3ea();
    
    if ( hasareaswap( "areaswap_capricorn_boat" ) && getareaswapstate( "areaswap_capricorn_boat" ) == "before" )
    {
        setareaswapstate( "areaswap_capricorn_boat", "after" );
    }
}

