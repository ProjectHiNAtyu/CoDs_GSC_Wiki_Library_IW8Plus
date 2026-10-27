// scripts\mp\ob\contracts\sat_ob_contract_aquarius_drone.gsc  (hash_0603e083c6e59c6a.gscc) (size: 13395 Bytes / 0x3453 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf7262c9 (259154633)
// size ...... 13395 (0x3453)
// includes .. 22  (offset: 0x30ab)
// strings ... 57  (offset: 0x315b)
// dev strs .. 1   (offset: 0x3447)
// exports ... 34  (offset: 0x1fc3)
// cseg ...... 0x74f + 0x1874 (0x1fc3)
// imports ... 98  (offset: 0x2513)
// animtree1 . 0   (offset: 0x3453)
// animtree2 . 0   (offset: 0x3453)
#using script_3edd59d0d3fc3262;
#using script_60cd1c57e94be8d7;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\armor;
#using scripts\mp\class;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob;
#using scripts\mp\interaction;
#using scripts\mp\ob\contracts\ob_contract_ui_widget;
#using scripts\mp\ob\systems\ob_activity_manager;
#using scripts\mp\ob\systems\ob_exfil_trans;
#using scripts\mp\ob\systems\ob_item_select;
#using scripts\mp\overlord;

#namespace sat_ob_contract_aquarius_drone;

// Namespace sat_ob_contract_aquarius_drone
// Params 0, eflags: 0x5
// Checksum 0x7d047318, Offset: 0x76d
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_fcaa8a8a2a808f54", undefined, &function_538033a540e63c70, undefined );
}

// Namespace sat_ob_contract_aquarius_drone
// Params 0, eflags: 0x4
// Checksum 0xfff863c1, Offset: 0x78e
// Size: 0x9c
function private function_538033a540e63c70()
{
    ob_settings = ob::get_ob_settings();
    
    if ( !ob_settings.var_49178f6e5c220274 )
    {
        return;
    }
    
    activity_common::registeractivitytype( "REV_OB_AQUARIUS_DRONE", &activity_type_init );
    level callback::add( #"hash_cc06eb1d45f33a0c", &on_player_connect_squad );
    classtableentry = getscriptbundle( hashcat( %"classtableentry:", "classtableentry_sat_ob_aqua_default" ) );
    level.aqua_starting_loadout = { #loadout_key:"starting_loadout", #loadout_array:class::function_79947c7814a64d0e( classtableentry ) };
    level thread setup_respawn_points();
}

// Namespace sat_ob_contract_aquarius_drone
// Params 0
// Checksum 0x859dc50f, Offset: 0x832
// Size: 0x12b
function setup_respawn_points()
{
    level endon( #"game_ended" );
    utility::flag_wait( "aqua_activity_cs_completed" );
    
    if ( level.respawn_points_aqua )
    {
        return;
    }
    
    array_t = [ "respawn_points_gas_station", "respawn_points_pre_colosseum", "respawn_points_colosseum", "respawn_points_pre_descend", "respawn_points_post_descend", "respawn_points_post_smoke", "respawn_points_bar", "respawn_points_pre_boxing", "respawn_points_post_tablet", "respawn_points_pre_wave_defend", "respawn_points_pre_wave_defend_closer", "respawn_points_outro" ];
    level.respawn_points_aqua = [];
    
    foreach ( t in array_t )
    {
        level.respawn_points_aqua[ t ] = utility::getstructarray( t, "targetname" );
    }
}

// Namespace sat_ob_contract_aquarius_drone
// Params 4
// Checksum 0x66e45ed8, Offset: 0x965
// Size: 0x6b
function function_eff49af9973cb6e3( squad_struct, flag, respawn_target, endonstr )
{
    level endon( #"game_ended" );
    
    if ( endonstr )
    {
        level endon( endonstr );
    }
    
    utility::flag_wait( flag );
    var_64bb57aa2d6e8b35 = function_8aa672a8312c4734( squad_struct );
    var_64bb57aa2d6e8b35 story_contract_util::set_squad_respawn( get_respawn_points( respawn_target ) );
}

// Namespace sat_ob_contract_aquarius_drone
// Params 1
// Checksum 0x9d14bd4e, Offset: 0x9d8
// Size: 0x2b
function get_respawn_points( targetname )
{
    prefix = "respawn_points_";
    return level.respawn_points_aqua[ prefix + targetname ];
}

// Namespace sat_ob_contract_aquarius_drone
// Params 1
// Checksum 0x6acd7370, Offset: 0xa0c
// Size: 0x28
function function_8aa672a8312c4734( squad_struct )
{
    return teams::getsquaddata( squad_struct.team, squad_struct.sessionsquadid );
}

// Namespace sat_ob_contract_aquarius_drone
// Params 1
// Checksum 0xd9d69686, Offset: 0xa3d
// Size: 0x337
function on_player_connect_squad( params )
{
    self notify( #"hash_cb834f2b04569d48" );
    self endon( #"hash_cb834f2b04569d48" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    utility::flag_wait( "scriptables_ready" );
    story_contract_util::waittill_active( self, #"aqua_complete" );
    utility::flag_set( "cleanup_prop_only_merc_camps" );
    var_d7bca97013a2d5d4 = squad_utility::getsquadleader( self.team, self.sessionsquadid ) ?? self;
    thread function_3f8c1ad4f6f4c06c();
    ob_story_mission_utils::function_b3e9457491e7af72( %"hash_651efd01cc65d33b", [ self ] );
    struct = utility::getstruct( "aqua_sam_site_interact_struct", "targetname" );
    
    if ( !isdefined( level.var_29d7b629e0765ef9 ) )
    {
        level.var_29d7b629e0765ef9 = level ob_story_mission_utils::function_b9cb179f9577f32a( struct.origin, 51, [ self ], "sat_ob_objectivemarker_storymissionmain" );
        logstring( "[AquaDrone] Adding objective marker for player: " + level.var_29d7b629e0765ef9 + " :SID " + self.sessionsquadid );
        level.aqua_drone_activity namespace_d7fa4530141146a5::function_e27cc6376feeb35c( level.var_29d7b629e0765ef9, 0, 1 );
        level ob_story_mission_utils::objective_marker_show( level.var_29d7b629e0765ef9, [ self ] );
    }
    else
    {
        level ob_story_mission_utils::objective_marker_show( level.var_29d7b629e0765ef9, [ self ] );
        logstring( "[AquaDrone] Showing objective marker for player: " + level.var_29d7b629e0765ef9 + " :SID " + self.sessionsquadid );
    }
    
    foreach ( abilitycase in level.var_119fe64f857f4bc7 )
    {
        ob_item_select::function_923ddf97f6cdbee( abilitycase, [ self ] );
    }
    
    activity_participation::function_bc67362dace4370c( level.aqua_drone_activity, self, "PlayerJoinedInteract" );
    thread function_4a88b972a328643d();
    var_64bb57aa2d6e8b35 = teams::getsquaddata( self.team, self.sessionsquadid );
    var_d7bca97013a2d5d4 = squad_utility::getsquadleader( self.team, self.sessionsquadid ) ?? self;
    
    if ( self == var_d7bca97013a2d5d4 )
    {
        logstring( "Aqua Mission drone started for squad: " + var_d7bca97013a2d5d4.sessionsquadid );
        squad = var_d7bca97013a2d5d4 squad_utility::getsquadmembers( var_d7bca97013a2d5d4.team, 0 );
        function_7554c3fb494c7fd3( var_d7bca97013a2d5d4 );
        thread function_79549a9e5ec21f0e( var_64bb57aa2d6e8b35 );
        thread function_4b2121699ab4c14a( var_64bb57aa2d6e8b35 );
        thread function_794a1a22b06cfd23( var_64bb57aa2d6e8b35, 60 );
    }
    
    story_contract_util::waittill_not_active( self, #"aqua_complete" );
    var_d7bca97013a2d5d4 = squad_utility::getsquadleader( self.team, self.sessionsquadid ) ?? self;
    
    if ( self == var_d7bca97013a2d5d4 )
    {
        level ob_story_mission_utils::mission_objective_marker_hide( level.var_29d7b629e0765ef9, squad );
        logstring( "[AquaDrone] Hide objective marker for all players in squad: " + level.var_29d7b629e0765ef9 + " :SID" + self.sessionsquadid );
    }
}

// Namespace sat_ob_contract_aquarius_drone
// Params 2, eflags: 0x4
// Checksum 0x7e66380e, Offset: 0xd7c
// Size: 0xb6
function private function_d626cc76cae468c1( player, loadout )
{
    if ( loadout && player.current_loadout_key != loadout.loadout_key )
    {
        player thread ob_story_mission_utils::function_96a2f57e9afcdff1( player, loadout.loadout_array, 2, "primary", 1 );
        player.current_loadout_key = loadout.loadout_key;
        player armor::setarmorhealth( player.maxarmorhealth );
        platecount = player armor::function_22290101992e4874();
        platemax = 2;
        var_1fd4f9927be13502 = platemax - platecount;
        player armor::function_164c824617d7e8d7( var_1fd4f9927be13502 );
    }
}

// Namespace sat_ob_contract_aquarius_drone
// Params 0
// Checksum 0xfe789101, Offset: 0xe3a
// Size: 0xc0
function function_3f8c1ad4f6f4c06c()
{
    self notify( #"hash_5a80b5ad1ef11fd3" );
    self endon( #"hash_5a80b5ad1ef11fd3" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    player = self;
    story_contract_util::waittill_active( player, #"aqua_complete" );
    loadout = level.aqua_starting_loadout;
    
    if ( !isdefined( player ) )
    {
        player thread ob_story_mission_utils::function_96a2f57e9afcdff1( player, loadout.loadout_array, 2, "primary", 1 );
        player.current_loadout_key = loadout.loadout_key;
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    function_d626cc76cae468c1( player, level.aqua_starting_loadout );
}

// Namespace sat_ob_contract_aquarius_drone
// Params 0
// Checksum 0x819a3b7d, Offset: 0xf02
// Size: 0x3a
function function_4a88b972a328643d()
{
    self waittill( #"hash_1b6b9613636daa6a" );
    
    if ( level.var_29d7b629e0765ef9 )
    {
        level ob_story_mission_utils::objective_marker_hide( level.var_29d7b629e0765ef9, [ self ] );
    }
    
    thread on_player_connect_squad( {} );
}

// Namespace sat_ob_contract_aquarius_drone
// Params 0
// Checksum 0x34b5f314, Offset: 0xf44
// Size: 0x79
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_AQUARIUS_DRONE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_AQUARIUS_DRONE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "REV_OB_AQUARIUS_DRONE", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "REV_OB_AQUARIUS_DRONE", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "REV_OB_AQUARIUS_DRONE" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &player_left_activity, "REV_OB_AQUARIUS_DRONE" );
}

// Namespace sat_ob_contract_aquarius_drone
// Params 0
// Checksum 0xaf0cb137, Offset: 0xfc5
// Size: 0x59
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activityvariantdefinition = namespace_9085ae059032a84f::function_9129cd8075c85c09( self );
    self.var_91c91f4a631c481d = activityvariantdefinition;
    level.aqua_drone_activity = activity_instance;
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace sat_ob_contract_aquarius_drone
// Params 0
// Checksum 0xe1718014, Offset: 0x1026
// Size: 0x184
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    struct = utility::getstruct( "aqua_sam_site_interact_struct", "targetname" );
    
    if ( !isdefined( level.aqua_drone_activity.var_2129f863d77fb48b ) )
    {
        logstring( "[AquaDrone] level.aqua_drone_activity.keyboard NOT DEFINED - Aqua Drone" );
        level.aqua_drone_activity.var_2129f863d77fb48b = spawnscriptable( "sat_ob_aquarius_sam_site_keyboard", struct.origin, struct.angles );
        level.aqua_drone_activity.var_2129f863d77fb48b setscriptablepartstate( "model", "visible" );
        level.aqua_drone_activity.var_2129f863d77fb48b setscriptablepartstate( "sam_launch_interact", "usable" );
        level.aqua_drone_activity.var_2129f863d77fb48b setscriptablepartstate( "sam_hack_interact", "unusable" );
        interact = interaction::register_scriptable_interact( level.aqua_drone_activity.var_2129f863d77fb48b, &function_7428f9f6d6a14d1 );
        level.aqua_drone_activity.var_2129f863d77fb48b function_7653c765b6c7b815();
        logstring( "[AquaDrone] level.aqua_drone_activity.keyboard DEFINED - Aqua Drone" );
    }
    
    level.aqua_drone_info = level.var_e607236b193eb0c1.var_5992a4946aeeca5a[ activity_instance.varianttag ];
    thread respawn_on_destroyed( activity_instance, activity_instance.varianttag );
}

// Namespace sat_ob_contract_aquarius_drone
// Params 1
// Checksum 0xbd0cc04f, Offset: 0x11b2
// Size: 0xa7
function function_777cf72a8da2ec94( squad )
{
    self endon( #"disconnect" );
    
    if ( !level.onlinegame )
    {
        structs = utility::getstructarray( "aqua_swat_teleport_locs", "targetname" );
        options = { #timeout:90, #var_bc9975ee52154653:10, #triggerradius:400, #players:squad };
        level coop::play_cinematic( "sat_virgo_load", options );
    }
    
    namespace_b451b5202140ccde::setdifficulty( 2, squad );
    namespace_b451b5202140ccde::completed( squad, %"hash_651efd01cc65d33b", 1 );
}

// Namespace sat_ob_contract_aquarius_drone
// Params 1
// Checksum 0x2ad3b2ac, Offset: 0x1261
// Size: 0xcb
function function_7554c3fb494c7fd3( var_d7bca97013a2d5d4 )
{
    self endon( #"disconnect" );
    squad = var_d7bca97013a2d5d4 squad_utility::getsquadmembers( var_d7bca97013a2d5d4.team, 0 );
    ob_story_mission_utils::function_b3e9457491e7af72( %"hash_651efd01cc65d33b", squad );
    
    foreach ( member in level.aqua_drone_activity.playerparticipants )
    {
        thread function_64f630d7d7610832( member );
    }
}

// Namespace sat_ob_contract_aquarius_drone
// Params 1
// Checksum 0xb70f68b1, Offset: 0x1334
// Size: 0x82
function function_64f630d7d7610832( member )
{
    level endon( #"game_ended" );
    level.aqua_drone_activity endon( #"activity_ended" );
    level.aqua_drone_activity endon( #"instance_destroyed" );
    member endon( #"disconnect" );
    
    while ( !level.aqua_drone_activity.var_2129f863d77fb48b )
    {
        waitframe();
    }
    
    level.aqua_drone_activity.var_2129f863d77fb48b enablescriptableplayeruse( member );
}

// Namespace sat_ob_contract_aquarius_drone
// Params 2
// Checksum 0xd8f5e757, Offset: 0x13be
// Size: 0x12c
function function_794a1a22b06cfd23( var_64bb57aa2d6e8b35, timeout )
{
    level endon( #"game_ended" );
    
    if ( level.aqua_drone_activity )
    {
        level.aqua_drone_activity endon( #"activity_ended" );
    }
    
    while ( !isdefined( level.aqua_drone_activity.var_2129f863d77fb48b ) )
    {
        wait 1;
    }
    
    scriptable = level.aqua_drone_activity.var_2129f863d77fb48b;
    scriptable endon( #"player_interacted" );
    wait timeout;
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        scriptable disablescriptableplayeruse( player );
    }
    
    if ( var_64bb57aa2d6e8b35.players[ 0 ] )
    {
        scriptable thread function_720b2869a86123c( var_64bb57aa2d6e8b35.players[ 0 ] );
    }
}

// Namespace sat_ob_contract_aquarius_drone
// Params 1
// Checksum 0xd380021, Offset: 0x14f2
// Size: 0x5d
function function_7428f9f6d6a14d1( player )
{
    scriptable = self;
    
    if ( !isplayer( player ) || player.inlaststand || !isalive( player ) )
    {
        return;
    }
    
    scriptable disablescriptableplayeruse( player );
    scriptable notify( #"player_interacted" );
    scriptable function_720b2869a86123c( player );
}

// Namespace sat_ob_contract_aquarius_drone
// Params 1
// Checksum 0x3c517cf1, Offset: 0x1557
// Size: 0x10e
function function_720b2869a86123c( player )
{
    level endon( #"game_ended" );
    scriptable = self;
    var_d7bca97013a2d5d4 = squad_utility::getsquadleader( player.team, player.sessionsquadid ) ?? player;
    squad = var_d7bca97013a2d5d4 squad_utility::getsquadmembers( var_d7bca97013a2d5d4.team, 0 );
    
    foreach ( member in squad )
    {
        scriptable disablescriptableplayeruse( member );
    }
    
    level notify( #"sam_used" );
    var_d7bca97013a2d5d4 function_777cf72a8da2ec94( squad );
    story_contract_util::mark_complete( squad, #"aqua_complete" );
    var_d7bca97013a2d5d4 function_8d8d94b558d65ca4();
}

// Namespace sat_ob_contract_aquarius_drone
// Params 1
// Checksum 0x316043c8, Offset: 0x166d
// Size: 0x94
function function_a3f792cb5a14beb2( struct )
{
    player = self;
    squad = player squad_utility::getsquadmembers( player.team, 0 );
    level.aqua_drone_activity.sam_site_obj_id = level.aqua_drone_activity ob_story_mission_utils::function_b9cb179f9577f32a( struct.origin, 16, squad, "sat_ob_objectivemarker_storymissionmain" );
    level.aqua_drone_activity namespace_d7fa4530141146a5::function_e27cc6376feeb35c( level.aqua_drone_activity.sam_site_obj_id, 0, 1 );
}

// Namespace sat_ob_contract_aquarius_drone
// Params 0
// Checksum 0xbbc5f04f, Offset: 0x1709
// Size: 0x16b
function function_8d8d94b558d65ca4()
{
    player = self;
    activity_instance = level.aqua_drone_activity;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    squad = player squad_utility::getsquadmembers( player.team, 0 );
    story_contract_util::mark_complete( squad, #"aqua_complete" );
    story_contract_util::achievement_activities( squad, "sat_wc_mission6and7", [ #"aqua_complete", #"virgo_complete" ] );
    var_d7bca97013a2d5d4 = squad_utility::getsquadleader( self.team, self.sessionsquadid ) ?? self;
    level notify( #"hash_8ea2d5813fbf0735" );
    
    if ( level.aqua_intro_activity )
    {
        activity_instance_common::endactivity( level.aqua_intro_activity, 1 );
    }
    
    if ( level.aqua_virus_upload_activity )
    {
        activity_instance_common::endactivity( level.aqua_virus_upload_activity, 1 );
    }
    
    if ( activity_instance && activity_instance_common::getactivitystate( activity_instance ) == "Active" )
    {
        activity_instance_common::endactivity( activity_instance, 1 );
    }
    
    playlistid = var_d7bca97013a2d5d4 function_ba1793aee415985f() ? getdvarint( @"hash_76df613803e98831", 267 ) : getdvarint( @"hash_503c51da7d948c71", 269 );
    level ob_exfil_trans::exfiltrans( var_d7bca97013a2d5d4, playlistid, "sat_virgo_load" );
}

// Namespace sat_ob_contract_aquarius_drone
// Params 1
// Checksum 0xb112198f, Offset: 0x187c
// Size: 0x26
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace sat_ob_contract_aquarius_drone
// Params 2
// Checksum 0x5236f90d, Offset: 0x18aa
// Size: 0x74
function respawn_on_destroyed( activity, variant )
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance waittill( #"instance_destroyed" );
    wait 1;
    
    if ( isdefined( level.aqua_drone_info ) )
    {
        logstring( "[AquaDrone] - restarting Activty from level.aqua_drone_info" );
        level ob_activity_manager::ob_activity_instance_init( level.aqua_drone_info );
        return;
    }
    
    logstring( "[AquaDrone] - FAILED to find level.aqua_drone_info" );
}

// Namespace sat_ob_contract_aquarius_drone
// Params 0
// Checksum 0xb2d2692c, Offset: 0x1926
// Size: 0xc8
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    logstring( "[AquaDrone] DESTROYING ACTIVITY " );
    
    if ( level.aqua_drone_activity.var_2129f863d77fb48b )
    {
        level.aqua_drone_activity.var_2129f863d77fb48b freescriptable();
        level.aqua_drone_activity.var_2129f863d77fb48b = undefined;
    }
    
    if ( level.var_29d7b629e0765ef9 )
    {
        level ob_story_mission_utils::objective_marker_clear( level.var_29d7b629e0765ef9 );
        level.var_29d7b629e0765ef9 = undefined;
    }
    
    level.aqua_drone_activity namespace_d7fa4530141146a5::function_501e44ea1cb9219d( level.aqua_drone_activity.sam_site_obj_id );
    logstring( "[AquaDrone] Cleaning up Squad Struct for Activity " );
    activity_instance.active_squads = [];
}

// Namespace sat_ob_contract_aquarius_drone
// Params 1
// Checksum 0xadba0890, Offset: 0x19f6
// Size: 0x42
function player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    logstring( "[AquaDrone] PLAYER JOINED ACTIVITY AQUARIUS DRONE" );
}

// Namespace sat_ob_contract_aquarius_drone
// Params 1
// Checksum 0xc21e06a8, Offset: 0x1a40
// Size: 0x70
function player_left_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    logstring( "[AquaDrone] PLAYER LEFT ACTIVITY AQUARIUS DRONE" );
    activity_instance = self;
    
    if ( !activity_instance.playerparticipants.size )
    {
        activity_instance.active_squads = [];
        
        if ( activity_instance_common::getactivitystate( activity_instance ) == "Active" )
        {
            activity_instance_common::endactivity( activity_instance, 0 );
        }
    }
}

// Namespace sat_ob_contract_aquarius_drone
// Params 1
// Checksum 0xbbb3c5e2, Offset: 0x1ab8
// Size: 0x65
function function_79549a9e5ec21f0e( var_64bb57aa2d6e8b35 )
{
    self notify( #"hash_e50767a21e600e15" );
    self endon( #"hash_e50767a21e600e15" );
    level endon( #"sam_used" );
    nags = [ "aqua_nag_sam_site_get_to_the_launcher_01", "aqua_nag_sam_site_get_to_the_launcher_02" ];
    thread function_6d5b076c1876580a( nags, "sam_used", 45, 60, var_64bb57aa2d6e8b35, 30 );
}

// Namespace sat_ob_contract_aquarius_drone
// Params 1
// Checksum 0x3ebb43d6, Offset: 0x1b25
// Size: 0x6f
function function_4b2121699ab4c14a( var_64bb57aa2d6e8b35 )
{
    self notify( #"hash_de947b4041c89f00" );
    self endon( #"hash_de947b4041c89f00" );
    level endon( #"all_players_in_sam_area" );
    level endon( #"sam_used" );
    thread function_b0f9c2cd67fb7c51();
    nags = [ "aqua_nag_sam_site_pls_do_not_leave_01" ];
    thread function_6d5b076c1876580a( nags, "all_players_in_sam_area", 45, 60, var_64bb57aa2d6e8b35, 30 );
}

// Namespace sat_ob_contract_aquarius_drone
// Params 6
// Checksum 0xfd63451a, Offset: 0x1b9c
// Size: 0xf2
function function_6d5b076c1876580a( nags, end_flag, var_8b04137784706899, var_afe81a7ad568d937, var_64bb57aa2d6e8b35, start_delay )
{
    level endon( #"game_ended" );
    
    if ( isdefined( level.aqua_drone_activity ) )
    {
        level.aqua_drone_activity endon( #"activity_ended" );
        level.aqua_drone_activity endon( #"instance_destroyed" );
    }
    
    level endon( end_flag );
    
    if ( utility::flag( end_flag ) )
    {
        return;
    }
    
    if ( isdefined( start_delay ) )
    {
        wait start_delay;
    }
    
    while ( nags.size > 0 && var_64bb57aa2d6e8b35.players.size > 0 )
    {
        nag = utility::array_random( nags );
        level overlord::playevent( nag, var_64bb57aa2d6e8b35.players );
        arrayremove( nags, nag );
        
        if ( nags.size > 0 )
        {
            wait randomfloatrange( var_8b04137784706899, var_afe81a7ad568d937 );
        }
    }
}

// Namespace sat_ob_contract_aquarius_drone
// Params 0
// Checksum 0x5d55d51f, Offset: 0x1c96
// Size: 0xb
function get_current_activity()
{
    return level.aqua_drone_activity;
}

// Namespace sat_ob_contract_aquarius_drone
// Params 0
// Checksum 0x35f7b2d8, Offset: 0x1caa
// Size: 0xca
function get_squad_data_global()
{
    activity = get_current_activity();
    mission_structs = activity.active_squads;
    squad_datas = [];
    
    foreach ( var_cd7e11dc688992d4 in mission_structs )
    {
        var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
        squad_datas[ squad_datas.size ] = var_64bb57aa2d6e8b35;
    }
    
    return squad_datas;
}

// Namespace sat_ob_contract_aquarius_drone
// Params 1
// Checksum 0x2ea137c6, Offset: 0x1d7d
// Size: 0xfb
function function_e16b62019aa8c4f( squad_struct )
{
    players = [];
    
    if ( !squad_struct )
    {
        global_squads = get_squad_data_global();
        
        foreach ( squad in global_squads )
        {
            if ( squad.players.size > 0 )
            {
                players = arraycombineunique( players, squad.players );
            }
        }
        
        return players;
    }
    
    if ( squad_struct.players && squad_struct.players.size > 0 )
    {
        return squad_struct.players;
    }
    
    if ( players.size == 0 )
    {
        return level.players;
    }
}

// Namespace sat_ob_contract_aquarius_drone
// Params 0
// Checksum 0xbbff529e, Offset: 0x1e80
// Size: 0x143
function function_b0f9c2cd67fb7c51()
{
    level endon( #"all_players_in_sam_area" );
    level endon( #"game_ended" );
    
    if ( isdefined( level.aqua_drone_activity ) )
    {
        level.aqua_drone_activity endon( #"activity_ended" );
        level.aqua_drone_activity endon( #"instance_destroyed" );
    }
    
    sam_bounds = utility::getstruct( "trigger_sam_site_bounds", "targetname" );
    player_participants = function_e16b62019aa8c4f();
    var_7817157db1fcf1a7 = [];
    
    while ( true )
    {
        wait 0.5;
        
        foreach ( player in player_participants )
        {
            if ( player istouching( sam_bounds ) )
            {
                if ( !arraycontains( var_7817157db1fcf1a7, player ) )
                {
                    var_7817157db1fcf1a7[ var_7817157db1fcf1a7.size ] = player;
                }
                
                continue;
            }
            
            if ( arraycontains( var_7817157db1fcf1a7, player ) )
            {
                var_7817157db1fcf1a7 = arrayremove( var_7817157db1fcf1a7, player );
            }
        }
        
        if ( var_7817157db1fcf1a7.size == player_participants.size )
        {
            level notify( #"all_players_in_sam_area" );
        }
    }
}

