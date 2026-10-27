// scripts\mp\ob\contracts\sat_ob_contract_cancer_confront.gsc  (hash_13d1045efbac1c12.gscc) (size: 52879 Bytes / 0xce8f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x86696cf (140941007)
// size ...... 52879 (0xce8f)
// includes .. 36  (offset: 0xc333)
// strings ... 171 (offset: 0xc453)
// dev strs .. 13  (offset: 0xcdef)
// exports ... 135 (offset: 0x85a7)
// cseg ...... 0x136b + 0x723c (0x85a7)
// imports ... 322 (offset: 0x9abf)
// animtree1 . 0   (offset: 0xce8f)
// animtree2 . 0   (offset: 0xce8f)
#using script_2399696a9d953451;
#using script_3edd59d0d3fc3262;
#using script_60cd1c57e94be8d7;
#using script_636bd827a012af12;
#using script_66878054d141dbc0;
#using scripts\anim\shared;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\ai;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\hud_util;
#using scripts\common\math;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\common\equipment\at_mine;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob;
#using scripts\mp\interaction;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\contracts\ob_contract_ui_widget;
#using scripts\mp\ob\ob_interactions_util;
#using scripts\mp\ob\ob_soldier_util;
#using scripts\mp\ob\systems\ob_humans;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\overlord;
#using scripts\mp\weapons;

#namespace cancer_confront;

// Namespace cancer_confront
// Params 0, eflags: 0x5
// Checksum 0x28616e21, Offset: 0x1389
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"sat_ob_contract_cancer_confront", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace cancer_confront
// Params 0, eflags: 0x4
// Checksum 0xf0e53d84, Offset: 0x13b2
// Size: 0x35
function private function_538033a540e63c70()
{
    ob_settings = ob::get_ob_settings();
    
    if ( !ob_settings.var_49178f6e5c220274 )
    {
        return;
    }
    
    activity_common::registeractivitytype( "REV_OB_CANCER_CONFRONT", &activity_type_init );
}

// Namespace cancer_confront
// Params 0
// Checksum 0x4eae4488, Offset: 0x13ef
// Size: 0xf6
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_CANCER_CONFRONT", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_CANCER_CONFRONT", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "REV_OB_CANCER_CONFRONT", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "REV_OB_CANCER_CONFRONT", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "REV_OB_CANCER_CONFRONT" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &player_left_activity, "REV_OB_CANCER_CONFRONT" );
    level._effect[ "cancer_capture_ring" ] = loadfxasset( "vfx_sat_sco_capture_zone_1" );
    level._effect[ "vfx_cancer_cradle_shatter_01" ] = loadfxasset( "vfx_sat_levels_mp_sat_avalon_cradle_shattered_01" );
    level._effect[ "vfx_cancer_cradle_shatter_04" ] = loadfxasset( "vfx_sat_levels_mp_sat_avalon_cradle_shattered_crack_04_med_low_vapor" );
    level._effect[ "vfx_cancer_cradle_shatter_05" ] = loadfxasset( "vfx_sat_levels_mp_sat_avalon_cradle_shattered_crack_05_med_low_vapor" );
    level._effect[ "vfx_cancer_cradle_shatter_06" ] = loadfxasset( "vfx_sat_levels_mp_sat_avalon_cradle_shattered_crack_06_sml_low_vapor" );
}

// Namespace cancer_confront
// Params 0
// Checksum 0x242c41f, Offset: 0x14ed
// Size: 0xa7
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.mines = [];
    activity_instance.sentries = [];
    activity_instance.fake_falkner = {};
    activity_instance.fake_falkner.should_spawn = 0;
    activity_instance.fake_falkner.should_shutdown = 0;
    activity_instance.fake_falkner.a_spawned_ai = [];
    activity_instance thread activity_starter_setup();
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace cancer_confront
// Params 0
// Checksum 0x5792bd03, Offset: 0x159c
// Size: 0x2b
function function_477932e3884ea1fd()
{
    activity_instance = self;
    level.cancer_confront_starter = undefined;
    activity_instance thread function_46b8f4111ca6fb33();
    activity_instance thread activity_main();
}

// Namespace cancer_confront
// Params 0
// Checksum 0xaa941a19, Offset: 0x15cf
// Size: 0x45d
function activity_main()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance endon( #"hash_7c23a60301f5800e" );
    level utility::flag_clear( "flag_cancer_resort_elevator_reveal" );
    level utility::flag_clear( "flag_cancer_penthouse_saferoom_vo_done" );
    level utility::flag_clear( "flag_cancer_cradle_influence_end" );
    level callback::add( #"player_spawned", &confront_on_player_spawn, activity_instance );
    cancer_mission = level.cancer_missions[ activity_instance.playerparticipants[ 0 ].sessionsquadid ];
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    teleport_structs = utility::getstructarray( "cancer_saferoom_teleport", "targetname" );
    var_64bb57aa2d6e8b35 story_contract_util::set_squad_respawn( teleport_structs, 0.33 );
    cancer_mission = level.cancer_missions[ activity_instance.playerparticipants[ 0 ].sessionsquadid ];
    cancer_mission notify( #"hash_12d5cf384c4e5158" );
    namespace_b451b5202140ccde::function_dac15947c2d451e9( var_64bb57aa2d6e8b35.players );
    overlord::function_e155a19c69aed191( activity_instance.playerparticipants );
    
    if ( level.var_30e6c9f02fa6bf2c )
    {
        foreach ( player in activity_instance.playerparticipants )
        {
            objidpoolmanager::objective_playermask_hidefrom( level.var_30e6c9f02fa6bf2c, player );
        }
    }
    
    initiator_struct = utility::getstruct( "sat_ob_cancer_confront_start_marker", "targetname" );
    var_64bb57aa2d6e8b35 coop::play_cinematic( "sat_cancer_prelude", { #timeout:26, #var_ba7c3b8fa9d3823:initiator_struct, #structs:teleport_structs, #players:activity_instance.playerparticipants } );
    cancer_mission notify( #"hash_8dfc963adcf4bf" );
    cancer_mission notify( #"hash_924bee8343f36b42" );
    activity_instance thread function_c4bb1f257f6bd2ce();
    activity_instance.should_shutdown = 0;
    activity_instance thread function_f9bb89bde044aebd();
    activity_instance childthread function_4b3fada1990a8b35( "trig_cancer_penthouse_bookcase", "notify_cancer_office_exited" );
    activity_instance childthread function_f5f96308c887d27d();
    activity_instance childthread function_1d9cf241bd68265c();
    activity_instance childthread setup_radio_tower();
    activity_instance thread function_cef440c15147d666( cancer_mission );
    activity_instance thread function_fced7f97646c55fd();
    activity_instance waittill( #"hash_30feb2f649d146d9" );
    activity_instance childthread function_93a8fc2b2e83fe15();
    activity_instance waittill( #"hash_f0c47e3beabb6cb0" );
    cancer_mission notify( #"hash_426247e792ae6db7" );
    activity_instance waittill( #"hash_5ac7d5a544c10b7d" );
    activity_instance childthread spawn_hvt_encounter();
    cancer_mission notify( #"music_hvt_spawned" );
    activity_instance utility::flag_wait( "notify_cancer_falkner_defeated" );
    cancer_mission notify( #"hash_c9d94531e9824938" );
    activity_instance waittill( #"hvt_confirmed" );
    cancer_mission notify( #"hash_77a5c5df855b8aab" );
    level utility::flag_clear( "flag_cancer_falkner_bodyguards_defeated" );
    level utility::flag_clear( "notify_cancer_falkner_defeated" );
    level utility::flag_clear( "hvt_spawned" );
    initiator_struct = {};
    initiator_struct.origin = activity_instance.falkner_animnode.origin;
    teleport_structs = utility::getstructarray( "cancer_post_confront_teleport", "targetname" );
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        player coop::function_eb6e09941acb48e9();
    }
    
    var_64bb57aa2d6e8b35 coop::play_cinematic( "sat_cancer_closer", { #noregroup:1, #timeout:75, #var_ba7c3b8fa9d3823:initiator_struct, #structs:teleport_structs, #players:var_64bb57aa2d6e8b35.players } );
    level thread cancer_confront_end( activity_instance, var_64bb57aa2d6e8b35 );
}

// Namespace cancer_confront
// Params 2
// Checksum 0x5bb95b77, Offset: 0x1a34
// Size: 0xb9
function cancer_confront_end( activity_instance, var_64bb57aa2d6e8b35 )
{
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        activity_participation::function_61aa2b2879f2c0a2( activity_instance, player, 1 );
    }
    
    story_contract_util::mark_complete( var_64bb57aa2d6e8b35.players, #"cancer_confront" );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace cancer_confront
// Params 1
// Checksum 0x493844a1, Offset: 0x1af5
// Size: 0x26
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace cancer_confront
// Params 0
// Checksum 0x63626281, Offset: 0x1b23
// Size: 0x25
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    activity_instance thread activity_cleanup();
}

// Namespace cancer_confront
// Params 0
// Checksum 0x6a4c83fd, Offset: 0x1b50
// Size: 0x32a
function activity_cleanup()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    level utility::flag_clear( "flag_cancer_falkner_bodyguards_defeated" );
    level utility::flag_clear( "notify_cancer_falkner_defeated" );
    level utility::flag_clear( "hvt_spawned" );
    level utility::flag_clear( "flag_cancer_penthouse_saferoom_vo_done" );
    level.cancer_confront_starter = undefined;
    level callback::remove( #"player_spawned", &confront_on_player_spawn );
    activity_instance thread function_bfb3870ecd5ba9cd();
    activity_instance thread function_fa0284c050f31749();
    level utility::flag_set( "flag_cancer_cradle_influence_end" );
    
    foreach ( sentry in activity_instance.sentries )
    {
        if ( isdefined( sentry ) )
        {
            sentry notify( #"kill_turret", 0, 1 );
        }
    }
    
    foreach ( mine in activity_instance.mines )
    {
        if ( isdefined( mine ) )
        {
            mine thread at_mine::at_mine_destroy();
        }
    }
    
    if ( activity_instance.interact_scriptable )
    {
        activity_instance.interact_scriptable freescriptable();
    }
    
    if ( activity_instance.var_75b078357b73a0e7 )
    {
        activity_instance.var_75b078357b73a0e7 freescriptable();
    }
    
    if ( activity_instance.var_75b078357b73a0e7.tower_markup )
    {
        activity_instance.var_75b078357b73a0e7.tower_markup hide();
        activity_instance.var_75b078357b73a0e7.tower_markup connectpaths();
    }
    
    if ( activity_instance.radio_marker )
    {
        activity_instance namespace_d7fa4530141146a5::function_501e44ea1cb9219d( activity_instance.radio_marker );
    }
    
    if ( activity_instance.circle_fx )
    {
        activity_instance.circle_fx delete();
    }
    
    if ( activity_instance.cradle_shatters )
    {
        activity_instance function_fa0284c050f31749();
    }
    
    if ( activity_instance.reset_scriptable )
    {
        activity_instance.reset_scriptable freescriptable();
    }
    
    if ( isdefined( activity_instance.falkner_animnode ) )
    {
        activity_instance.falkner_animnode scene::stop();
        activity_instance.falkner_animnode scene::cleanup( 1 );
    }
    
    if ( activity_instance.obj_circle )
    {
        ob_story_mission_utils::function_352aa3aab98a0618( activity_instance.obj_circle );
    }
    
    if ( isalive( activity_instance.fake_falkner_initial ) )
    {
        activity_instance.fake_falkner_initial dodamage( 1, activity_instance.fake_falkner_initial.origin );
    }
    
    activity_instance thread activity_ai_encounters::function_2574b40bde3bd456( 1 );
}

// Namespace cancer_confront
// Params 0
// Checksum 0x9ecdb7e0, Offset: 0x1e82
// Size: 0xf
function get_activity_center_point()
{
    return ( 0, 0, 0 );
}

// Namespace cancer_confront
// Params 0
// Checksum 0x590c1a11, Offset: 0x1e9a
// Size: 0x44
function function_470b4f0cecef4cf4()
{
    var_983974fc347bb3cb = spawnstruct();
    var_983974fc347bb3cb.origin = ( 0, 0, 0 );
    var_983974fc347bb3cb.angles = ( 0, 0, 0 );
}

// Namespace cancer_confront
// Params 1
// Checksum 0xecc3fa54, Offset: 0x1ee6
// Size: 0x2d8
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    
    foreach ( player in player_list )
    {
        if ( player.var_1348ae8d95a313d0 && player.objective_marker_ids )
        {
            objidpoolmanager::objective_playermask_hidefrom( player.var_1348ae8d95a313d0, player );
            function_2b8e3d3ae2a6414a( player.var_1348ae8d95a313d0, 1 );
            player.objective_marker_ids = arrayremove( player.objective_marker_ids, player.var_1348ae8d95a313d0 );
            objective_delete( player.var_1348ae8d95a313d0 );
        }
    }
    
    if ( !activity_instance.radio_tower_complete && activity_instance.var_75b078357b73a0e7 )
    {
        foreach ( player in player_list )
        {
            activity_instance.var_75b078357b73a0e7 enablescriptableplayeruse( player );
        }
    }
    
    if ( activity_instance.var_dc21504e32f2eda6 && isent( activity_instance.var_dc21504e32f2eda6 ) )
    {
        foreach ( player in player_list )
        {
            activity_instance.var_dc21504e32f2eda6 showtoplayer( player );
        }
    }
    
    if ( activity_instance.obj_circle && isent( activity_instance.obj_circle ) )
    {
        foreach ( player in player_list )
        {
            activity_instance.obj_circle showtoplayer( player );
        }
    }
    
    if ( activity_instance.health_struct )
    {
        activity_instance thread update_healthbar();
    }
}

// Namespace cancer_confront
// Params 1
// Checksum 0xbfebf542, Offset: 0x21c6
// Size: 0x24f
function player_left_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    
    if ( activity_instance.var_75b078357b73a0e7 )
    {
        foreach ( player in player_list )
        {
            activity_instance.var_75b078357b73a0e7 disablescriptableplayeruse( player );
        }
    }
    
    if ( activity_instance.var_dc21504e32f2eda6 && isent( activity_instance.var_dc21504e32f2eda6 ) )
    {
        foreach ( player in player_list )
        {
            activity_instance.var_dc21504e32f2eda6 hidefromplayer( player );
        }
    }
    
    if ( activity_instance.obj_circle && isent( activity_instance.obj_circle ) )
    {
        foreach ( player in player_list )
        {
            activity_instance.obj_circle hidefromplayer( player );
        }
    }
    
    if ( activity_instance.health_struct )
    {
        foreach ( player in player_list )
        {
            player ob_story_mission_utils::function_5a707116af438c92();
        }
    }
}

// Namespace cancer_confront
// Params 0
// Checksum 0x96ce6223, Offset: 0x241d
// Size: 0x56
function function_46b8f4111ca6fb33()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    while ( true )
    {
        if ( activity_instance.playerparticipants.size <= 0 )
        {
            activity_instance_common::endactivity( activity_instance, 1 );
            break;
        }
        
        wait 1;
    }
}

// Namespace cancer_confront
// Params 0
// Checksum 0x5507c111, Offset: 0x247b
// Size: 0x11e
function activity_starter_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance endon( #"activity_started" );
    starter = undefined;
    
    while ( !starter )
    {
        if ( isarray( activity_instance.var_d916a0349fb35326 ) )
        {
            foreach ( struct in activity_instance.var_d916a0349fb35326 )
            {
                if ( struct.scriptable.type == "sat_ob_cancer_confront_activity_starter" )
                {
                    starter = struct.scriptable;
                    break;
                }
            }
        }
        
        waitframe();
    }
    
    starter function_7653c765b6c7b815();
    starter setscriptablepartstate( "nexus_activity_joiner_phone", "hidden" );
    level.cancer_confront_starter = starter;
}

/#

    // Namespace cancer_confront
    // Params 0
    // Checksum 0xc85f0f9, Offset: 0x25a1
    // Size: 0x5, Type: dev
    function function_2721dd94e149d6a5()
    {
        
    }

#/

// Namespace cancer_confront
// Params 0
// Checksum 0xaebc8c5f, Offset: 0x25ae
// Size: 0x53
function function_1d9cf241bd68265c()
{
    activity_instance = self;
    wait 1;
    activity_instance.cradle_shatters = [];
    activity_instance.cradle_fogs = [];
    activity_instance function_5ac80c784a4a1c9f();
    activity_instance thread function_51b65bc6737c4b1f();
    activity_instance childthread function_ad97f98bdb704596();
    activity_instance childthread spawn_initial_fake_falkner();
}

// Namespace cancer_confront
// Params 0, eflags: 0x4
// Checksum 0x98c17c8f, Offset: 0x2609
// Size: 0x2c9
function private function_5ac80c784a4a1c9f()
{
    activity_instance = self;
    a_trig_cancer_ambush_lab = getnoentvolumearray( "trig_cancer_ambush_lab", #targetname );
    a_trig_cancer_ambush_bookcase = getnoentvolumearray( "trig_cancer_ambush_bookcase", #targetname );
    var_4686a019ad67b7ef = getnoentvolumearray( "trig_cancer_ambush_transmitter_visible", #targetname );
    var_6323fe90cce1856 = getnoentvolumearray( "trig_cancer_ambush_initial_enc", #targetname );
    var_2e09b992c3710f85 = getnoentvolumearray( "trig_cancer_ambush_cannon_enc", #targetname );
    
    foreach ( trigger in a_trig_cancer_ambush_lab )
    {
        activity_instance childthread function_4b3fada1990a8b35( trigger, "notify_cancer_ambush_zombie_lab" );
    }
    
    foreach ( trigger in a_trig_cancer_ambush_bookcase )
    {
        activity_instance childthread function_4b3fada1990a8b35( trigger, "notify_cancer_ambush_zombie_bookcase" );
    }
    
    foreach ( trigger in var_4686a019ad67b7ef )
    {
        activity_instance childthread function_4b3fada1990a8b35( trigger, "notify_ambush_transmitter_visible" );
    }
    
    foreach ( trigger in var_6323fe90cce1856 )
    {
        activity_instance childthread function_4b3fada1990a8b35( trigger, "notify_cancer_ambush_zombie_intro" );
    }
    
    foreach ( trigger in var_2e09b992c3710f85 )
    {
        activity_instance childthread function_4b3fada1990a8b35( trigger, "notify_cancer_ambush_zombie_cannon" );
    }
}

// Namespace cancer_confront
// Params 0
// Checksum 0x2eb7cf11, Offset: 0x28da
// Size: 0x136
function function_ad97f98bdb704596()
{
    activity_instance = self;
    requestid = activity_instance activity_ai_encounters::function_92b671064b0b1ce2( "cancer_confront_ambush_enc", 0, 0, 1, 0 );
    activity_instance.ambush_encounter = {};
    activity_instance.ambush_encounter.requestid = requestid;
    data = function_9b649316adcccbaa( activity_instance.ambush_encounter.requestid );
    
    if ( data.status == 1 )
    {
        activity_instance.ambush_encounter.should_spawn = 0;
        activity_instance.ambush_encounter.should_shutdown = 0;
        function_ef57f478f96b050c( requestid, 1 );
        activity_instance activity_ai_encounters::function_d33de057e760c97b( requestid, &should_shutdown_ambush_encounter, activity_instance.ambush_encounter );
        activity_instance activity_ai_encounters::function_dcf6bdb6ee9d1ca0( requestid, &should_spawn_ambush_encounter, activity_instance.ambush_encounter );
        activity_instance activity_ai_encounters::function_202051e510314502( requestid, &function_461ac0c9d89c858e, activity_instance.ambush_encounter );
        activity_instance activity_ai_encounters::function_52d1342183200a8f( requestid, &function_1643d2f9b4e4119f, activity_instance );
    }
    
    activity_instance function_acd307eb7ceacc0e();
    activity_instance utility::delaythread( 3, &function_c3405e0bcb4c2965 );
}

// Namespace cancer_confront
// Params 0, eflags: 0x4
// Checksum 0xb2af4145, Offset: 0x2a18
// Size: 0x84
function private function_acd307eb7ceacc0e()
{
    activity_instance = self;
    activity_instance waittill( #"notify_cancer_ambush_zombie_lab" );
    activity_instance function_eeccad9106d24b5a( activity_instance.ambush_encounter, "cancer_ambush_topofstairs" );
    activity_instance waittill( #"notify_cancer_ambush_zombie_bookcase" );
    activity_instance function_eeccad9106d24b5a( activity_instance.ambush_encounter, "cancer_ambush_crawlout" );
    activity_instance waittill( #"notify_cancer_ambush_zombie_intro" );
    activity_instance function_eeccad9106d24b5a( activity_instance.ambush_encounter, "cancer_ambush_cannon" );
}

// Namespace cancer_confront
// Params 2, eflags: 0x4
// Checksum 0xac2b261f, Offset: 0x2aa4
// Size: 0x3b
function private should_shutdown_ambush_encounter( requestid, userdata )
{
    if ( userdata.should_shutdown )
    {
        ai_spawn_director::cancel_spawn_request( requestid, 1, 1 );
    }
    
    return userdata.should_shutdown;
}

// Namespace cancer_confront
// Params 2, eflags: 0x4
// Checksum 0x645397a4, Offset: 0x2ae8
// Size: 0x20
function private should_spawn_ambush_encounter( requestid, userdata )
{
    return userdata.should_spawn;
}

// Namespace cancer_confront
// Params 2, eflags: 0x4
// Checksum 0xa92fe9c8, Offset: 0x2b11
// Size: 0x29
function private function_461ac0c9d89c858e( requestid, userdata )
{
    userdata.should_spawn = 0;
    function_fbe9bb47edbe2d7c( requestid );
}

// Namespace cancer_confront
// Params 4, eflags: 0x4
// Checksum 0xf3c821bf, Offset: 0x2b42
// Size: 0x67
function private function_1643d2f9b4e4119f( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    activity_instance = userdata;
    activity_instance.ambush_encounter.should_spawn = 0;
    userdata function_9c01a6fc5e8fa884( requestid, userdata, agent, data );
}

// Namespace cancer_confront
// Params 3, eflags: 0x4
// Checksum 0x592d6da0, Offset: 0x2bb1
// Size: 0xfa
function private function_eeccad9106d24b5a( encounter, buckettag, hasrumble = 0 )
{
    activity_instance = self;
    
    if ( !encounter )
    {
        /#
            iprintlnbold( "<dev string:x24>" );
        #/
        
        return;
    }
    
    if ( isdefined( encounter.buckettag ) )
    {
        function_1a9d724a960fa19d( encounter.requestid, encounter.buckettag, 0 );
    }
    
    encounter.buckettag = buckettag;
    function_1a9d724a960fa19d( encounter.requestid, buckettag, 1 );
    encounter.should_spawn = 1;
    
    if ( hasrumble )
    {
        center = utility::getstruct( activity_instance.varianttag + "_center" );
        earthquake( 0.2, 0.75, center.origin, 600 );
        playrumbleonposition( "damage_light", center.origin );
    }
}

// Namespace cancer_confront
// Params 3, eflags: 0x4
// Checksum 0xb40f6cbd, Offset: 0x2cb3
// Size: 0x1c6
function private function_5371438b128a23fb( targetname, hasdelay = 0, hasrumble = 0 )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    var_9d4a56f1d3c95270 = getentitylessscriptablearray( targetname, #targetname );
    
    if ( var_9d4a56f1d3c95270.size > 0 )
    {
        foreach ( var_485aac139ab53a3 in var_9d4a56f1d3c95270 )
        {
            var_485aac139ab53a3 setscriptablepartstate( "vfx", var_485aac139ab53a3.script_noteworthy );
        }
        
        return;
    }
    
    cradle_shatters_structs = utility::getstructarray( targetname, "targetname" );
    
    foreach ( cradle_shatters_struct in cradle_shatters_structs )
    {
        cradle_shatters_struct function_7f678f0e36a3acf9( 1, hasrumble );
        playsoundatpos( cradle_shatters_struct.origin, "evt_cancer_cradle_shatter_init" );
        activity_instance.cradle_shatters[ activity_instance.cradle_shatters.size ] = cradle_shatters_struct;
        
        if ( hasdelay )
        {
            wait randomfloatrange( 0.35, 0.65 );
        }
    }
}

// Namespace cancer_confront
// Params 0, eflags: 0x4
// Checksum 0x518e9ffb, Offset: 0x2e81
// Size: 0x144
function private function_fa0284c050f31749()
{
    activity_instance = self;
    
    if ( activity_instance.cradle_shatters )
    {
        foreach ( cradle_shatters_struct in activity_instance.cradle_shatters )
        {
            cradle_shatters_struct function_7f678f0e36a3acf9( 0 );
        }
        
        activity_instance.cradle_shatters = [];
    }
    
    var_c792430326eb9b8f = getentitylessscriptablearray( activity_instance.varianttag + "_cancer_ambush_cradle_shatters", #targetname );
    
    foreach ( var_851db4ff8d073d46 in var_c792430326eb9b8f )
    {
        var_851db4ff8d073d46 setscriptablepartstate( "vfx", "off" );
    }
}

// Namespace cancer_confront
// Params 2, eflags: 0x4
// Checksum 0x6425be2b, Offset: 0x2fcd
// Size: 0x166
function private function_7f678f0e36a3acf9( var_bcbff0270055a8e5 = 1, shouldrumble = 0 )
{
    particle_struct = self;
    
    if ( var_bcbff0270055a8e5 )
    {
        if ( !particle_struct.active_fx )
        {
            if ( !isdefined( level._effect[ particle_struct.script_noteworthy ] ) )
            {
                assertmsg( "<dev string:x38>" + ( isxhash( particle_struct.script_noteworthy ) ? getxhashsourcename( particle_struct.script_noteworthy ) : particle_struct.script_noteworthy ) + "<dev string:x3c>" );
                return;
            }
            
            particle_struct.active_fx = spawnfx( utility::getfx( particle_struct.script_noteworthy ), particle_struct.origin, anglestoforward( particle_struct.angles ) );
        }
        
        triggerfx( particle_struct.active_fx, -2 );
        
        if ( shouldrumble && utility::cointoss() )
        {
            earthquake( 0.05, 0.1, particle_struct.origin, 500 );
            playrumbleonposition( "damage_light", particle_struct.origin );
        }
        
        return;
    }
    
    if ( !var_bcbff0270055a8e5 && particle_struct.active_fx )
    {
        particle_struct.active_fx delete();
        particle_struct.active_fx = undefined;
    }
}

// Namespace cancer_confront
// Params 1, eflags: 0x4
// Checksum 0xabdc35e7, Offset: 0x313b
// Size: 0x1a6
function private function_ad3a2bbd5a53814e( targetname )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    fog_scriptables = getentitylessscriptablearray( targetname, #targetname );
    
    if ( fog_scriptables.size > 0 )
    {
        foreach ( fog_scriptable in fog_scriptables )
        {
            fog_scriptable setscriptablepartstate( "vfx", "on" );
            wait 0.5;
        }
        
        return;
    }
    
    fog_structs = utility::getstructarray( targetname, "targetname" );
    
    foreach ( fog_struct in fog_structs )
    {
        fog_scriptable = spawnscriptable( "sat_ob_cancer_cradle_fog", fog_struct.origin, fog_struct.angles );
        fog_scriptable setscriptablepartstate( "vfx", "on" );
        activity_instance.cradle_fogs[ activity_instance.cradle_fogs.size ] = fog_scriptable;
        wait 0.5;
    }
}

// Namespace cancer_confront
// Params 0, eflags: 0x4
// Checksum 0xe70bc62a, Offset: 0x32e9
// Size: 0x141
function private function_bfb3870ecd5ba9cd()
{
    activity_instance = self;
    
    if ( activity_instance.cradle_fogs )
    {
        foreach ( cradle_fog in activity_instance.cradle_fogs )
        {
            cradle_fog freescriptable();
        }
        
        activity_instance.cradle_fogs = [];
    }
    
    var_c792430326eb9b8f = getentitylessscriptablearray( activity_instance.varianttag + "_cancer_ambush_cradle_shatters", #targetname );
    
    foreach ( var_851db4ff8d073d46 in var_c792430326eb9b8f )
    {
        var_851db4ff8d073d46 setscriptablepartstate( "vfx", "off" );
    }
}

// Namespace cancer_confront
// Params 0, eflags: 0x4
// Checksum 0x8dea205b, Offset: 0x3432
// Size: 0xfd
function private function_51b65bc6737c4b1f()
{
    activity_instance = self;
    activity_instance utility::delaythread( 0.5, &function_5371438b128a23fb, "cancer_ambush_cradle_shatters_intro_lab", 1, 1 );
    activity_instance waittill( #"notify_cancer_ambush_zombie_lab" );
    activity_instance thread function_5371438b128a23fb( activity_instance.varianttag + "_cancer_ambush_cradle_shatters_lab", 1, 1 );
    activity_instance thread function_ad3a2bbd5a53814e( activity_instance.varianttag + "_cancer_ambush_cradle_fog_bookcase" );
    activity_instance waittill( #"notify_cancer_ambush_zombie_bookcase" );
    activity_instance thread function_5371438b128a23fb( activity_instance.varianttag + "_cancer_ambush_cradle_shatters_bookcase", 1, 1 );
    activity_instance thread function_ad3a2bbd5a53814e( activity_instance.varianttag + "_cancer_ambush_cradle_fog_bathroom" );
    activity_instance waittill( #"notify_cancer_ambush_zombie_intro" );
    activity_instance thread function_5371438b128a23fb( activity_instance.varianttag + "_cancer_ambush_cradle_shatters", 1, 1 );
    activity_instance thread function_ad3a2bbd5a53814e( activity_instance.varianttag + "_cancer_ambush_cradle_fog" );
}

// Namespace cancer_confront
// Params 0
// Checksum 0x57b63e63, Offset: 0x3537
// Size: 0x101
function function_f9bb89bde044aebd()
{
    activity_instance = self;
    duration = 6;
    level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "medium", duration, undefined, activity_instance.playerparticipants, undefined, undefined, 1 );
    
    foreach ( player in activity_instance.playerparticipants )
    {
        player thread function_d73bf81f4b6169be( activity_instance );
        player playlocalsound( "evt_cancer_feedback_lr" );
    }
    
    wait duration;
    level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "light", duration, "flag_cancer_cradle_influence_end", activity_instance.playerparticipants, undefined, undefined, 1 );
    activity_instance waittill( #"hash_30feb2f649d146d9" );
    level utility::flag_set( "flag_cancer_cradle_influence_end" );
}

// Namespace cancer_confront
// Params 1
// Checksum 0xe53543df, Offset: 0x3640
// Size: 0xaa
function function_d73bf81f4b6169be( activity_instance )
{
    player = self;
    player endon( #"death_or_disconnect" );
    player function_16ebcc5ed60568e5();
    player thread function_1850847b8fb181d8( activity_instance );
    player thread player_change_speed( 0.8, 6, "cancer_ambush_move_scalar", activity_instance );
    player val::set( "cancer_confront_post_stun", "sprint", 0 );
    activity_instance utility::waittill_notify_or_timeout( "notify_cancer_office_exited", 20 );
    player notify( #"cancel_change_speed" );
    waitframe();
    player val::reset_all( "cancer_confront_post_stun" );
    player weapons::function_986fc44dada307f4( "cancer_ambush_move_scalar" );
    player weapons::updatemovespeedscale();
}

// Namespace cancer_confront
// Params 1
// Checksum 0x605cea73, Offset: 0x36f2
// Size: 0x8f
function function_1850847b8fb181d8( activity_instance )
{
    player = self;
    player endon( #"death_or_disconnect" );
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance endon( #"hash_30feb2f649d146d9" );
    activity_instance endon( #"hash_7c23a60301f5800e" );
    
    while ( true )
    {
        player earthquakeforplayer( 0.3, 3, player.origin, 128 );
        player playrumbleonentity( "light_2s" );
        wait 6;
    }
}

// Namespace cancer_confront
// Params 4
// Checksum 0xc2384e22, Offset: 0x3789
// Size: 0x13a
function player_change_speed( end_speed_scale = 0.8, total_duration = 5, speed_id = "cancer_ambush_move_scalar", activity_instance )
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player endon( #"cancel_change_speed" );
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance endon( #"notify_cancer_office_exited" );
    activity_instance endon( #"hash_7c23a60301f5800e" );
    start_speed_scale = 0.3;
    var_1c83185125fa8090 = utility::function_4b74c15943231980( total_duration );
    timeelapsed = 0;
    starttime = gettime();
    
    while ( true )
    {
        timeelapsed = gettime() - starttime;
        frac = min( 1, timeelapsed / var_1c83185125fa8090 );
        scalar = math::lerp( start_speed_scale, end_speed_scale, frac );
        player weapons::function_4512b7715789e4cf( speed_id, scalar );
        player weapons::updatemovespeedscale();
        waitframe();
    }
}

// Namespace cancer_confront
// Params 1
// Checksum 0x58edb33, Offset: 0x38cb
// Size: 0x222
function function_16ebcc5ed60568e5( duration = 7 )
{
    player = self;
    player endon( #"death_or_disconnect" );
    gestureref = "vm_ges_shockstick_react";
    player thread function_afc2e004153810a2();
    player thread function_7ef4461c28419b11();
    player val::set( "cancer_confront_stun", "damage", 0 );
    player val::set( "cancer_confront_stun", "allow_movement", 0 );
    player val::set( "cancer_confront_stun", "allow_jump", 0 );
    player val::set( "cancer_confront_stun", "crouch", 0 );
    player val::set( "cancer_confront_stun", "freezecontrols", 1 );
    player val::set( "cancer_confront_stun", "freezecontrols_allowlook", 1 );
    player val::set( "cancer_confront_stun", "weapon_switch", 0 );
    player val::set( "cancer_confront_stun", "fire", 0 );
    player val::set( "cancer_confront_stun", "reload", 0 );
    player val::set( "cancer_confront_stun", "equipment_primary", 0 );
    player val::set( "cancer_confront_stun", "equipment_secondary", 0 );
    player val::set( "cancer_confront_stun", "supers", 0 );
    player val::set( "cancer_confront_stun", "killstreaks", 0 );
    wait 0.1;
    
    if ( isalive( player ) && player.sessionstate == "playing" && !player.inlaststand )
    {
        curweapon = player getcurrentweapon();
        
        if ( isdefined( curweapon ) )
        {
            if ( weapon::isfistweapon( curweapon ) )
            {
                gestureref = "vm_ges_shockstick_react_fists";
            }
            
            while ( isalive( player ) && player.sessionstate == "playing" && !player isgestureplaying( gestureref ) && !player.inlaststand )
            {
                player forceplaygestureviewmodel( gestureref );
                waitframe();
            }
        }
    }
    
    wait duration;
    player thread function_a22ddb7f43e91c06( gestureref );
    player notify( #"hash_aa17555d868cde42" );
    player notify( #"hash_44eca903866c7b31" );
}

// Namespace cancer_confront
// Params 0, eflags: 0xc
// Checksum 0x2a148f1e, Offset: 0x3af5
// Size: 0x33
function private function_afc2e004153810a2()
{
    self notify( #"hash_465607e640211339" );
    self endon( #"hash_465607e640211339" );
    self waittill( #"hash_aa17555d868cde42" );
    val::reset_all( "cancer_confront_stun" );
}

// Namespace cancer_confront
// Params 0, eflags: 0xc
// Checksum 0xe2cf6aab, Offset: 0x3b30
// Size: 0x4b
function private function_7ef4461c28419b11()
{
    self notify( #"hash_7d64a6f6e09ad07b" );
    self endon( #"hash_7d64a6f6e09ad07b" );
    self endon( #"hash_44eca903866c7b31" );
    self endon( #"disconnect" );
    self waittill( #"death" );
    val::reset_all( "cancer_confront_stun" );
}

// Namespace cancer_confront
// Params 1, eflags: 0xc
// Checksum 0xaea714c6, Offset: 0x3b83
// Size: 0x2c
function private function_a22ddb7f43e91c06( gestureref )
{
    self notify( #"hash_daab43ba12bfac03" );
    self endon( #"hash_daab43ba12bfac03" );
    self stopgestureviewmodel( gestureref );
}

// Namespace cancer_confront
// Params 0
// Checksum 0x4f2db828, Offset: 0x3bb7
// Size: 0x7e
function give_upgrade()
{
    activity_instance = self;
    wait 1.5;
    player = activity_instance.playerparticipants[ 0 ];
    var_64bb57aa2d6e8b35 = teams::getsquaddata( player.team, player.sessionsquadid );
    
    if ( var_64bb57aa2d6e8b35 )
    {
        ob_story_mission_utils::function_eee81c6c2c7fdb3( var_64bb57aa2d6e8b35 );
        level thread overlord::playevent( "tacb_wcarmorupgrade", var_64bb57aa2d6e8b35.players, 1, 1, 1 );
    }
}

// Namespace cancer_confront
// Params 2
// Checksum 0x526600c3, Offset: 0x3c3d
// Size: 0xd9
function confront_on_player_spawn( params, activity_instance )
{
    player = self;
    
    if ( arraycontains( activity_instance.playerparticipants, player ) )
    {
        agents = getaiarrayinradius( player.origin, 300, "team_hundred_ninety" );
        
        foreach ( agent in agents )
        {
            if ( agent.type == "zombie" )
            {
                agent kill();
            }
        }
    }
}

/#

    // Namespace cancer_confront
    // Params 0
    // Checksum 0xe98a07f, Offset: 0x3d1e
    // Size: 0x5, Type: dev
    function function_c4c9f5094bc12298()
    {
        
    }

#/

// Namespace cancer_confront
// Params 0
// Checksum 0xf9c77d9f, Offset: 0x3d2b
// Size: 0x1ab
function setup_radio_tower()
{
    activity_instance = self;
    spawn_struct = utility::getstruct( activity_instance.varianttag + "_radio_tower_spawn_struct", "targetname" );
    var_c5c81b268e1c2b87 = getent( "cancer_radio_tower_markup", #targetname );
    var_c5c81b268e1c2b87 show();
    var_c5c81b268e1c2b87 disconnectpaths();
    var_75b078357b73a0e7 = spawnscriptable( "sat_ob_cancer_radio_tower", spawn_struct.origin, spawn_struct.angles );
    var_75b078357b73a0e7.activity_instance = activity_instance;
    activity_instance.var_75b078357b73a0e7 = var_75b078357b73a0e7;
    activity_instance.var_75b078357b73a0e7.tower_markup = var_c5c81b268e1c2b87;
    var_75b078357b73a0e7 setscriptablepartstate( "music", "on" );
    activity_instance childthread function_6aa395fb6a2e1ffc();
    activity_instance childthread function_2deee207b2e394fe();
    activity_instance waittill( #"hash_125a9ce8a272461d" );
    interaction::register_scriptable_interact( var_75b078357b73a0e7, &function_9ee58626462e166c );
    var_75b078357b73a0e7 setscriptablepartstate( "interact", "usable" );
    var_75b078357b73a0e7 function_7653c765b6c7b815();
    
    foreach ( player in activity_instance.playerparticipants )
    {
        var_75b078357b73a0e7 enablescriptableplayeruse( player );
    }
    
    radio_marker = function_455e8fb262f93e43( var_75b078357b73a0e7 );
    activity_instance.radio_marker = radio_marker;
}

// Namespace cancer_confront
// Params 1
// Checksum 0xcb2e6bc5, Offset: 0x3ede
// Size: 0x134
function function_9ee58626462e166c( player )
{
    self endon( #"death" );
    scriptable = self;
    scriptable function_7653c765b6c7b815();
    var_fab006cdb4f6e516 = ob_interactions_util::function_c7b5806740384a61( "earpiece_press_sat_ob", player, 2, undefined, 1, 1, 1, -1, "ClinkInteractions" );
    
    if ( var_fab006cdb4f6e516 )
    {
        scriptable.activity_instance notify( #"hash_30feb2f649d146d9" );
        scriptable function_7653c765b6c7b815();
        scriptable.activity_instance.radio_tower_complete = 1;
        scriptable.activity_instance namespace_d7fa4530141146a5::function_501e44ea1cb9219d( scriptable.activity_instance.radio_marker );
        return;
    }
    
    foreach ( player in scriptable.activity_instance.playerparticipants )
    {
        scriptable enablescriptableplayeruse( player );
    }
}

// Namespace cancer_confront
// Params 0
// Checksum 0xa517904b, Offset: 0x401a
// Size: 0x148
function function_6aa395fb6a2e1ffc()
{
    activity_instance = self;
    activity_instance endon( #"hash_f0c47e3beabb6cb0" );
    activity_instance endon( #"hash_7c23a60301f5800e" );
    dist_far = 562500;
    var_570640a265b13e3d = 1562500;
    
    while ( activity_instance.var_75b078357b73a0e7 )
    {
        foreach ( player in activity_instance.playerparticipants )
        {
            player_dist = distancesquared( player.origin, activity_instance.var_75b078357b73a0e7.origin );
            
            if ( player_dist > dist_far && player_dist < var_570640a265b13e3d )
            {
                level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "light", 2, undefined, [ player ], undefined, undefined, 1 );
                continue;
            }
            
            if ( player_dist > var_570640a265b13e3d )
            {
                level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "medium", 2, undefined, [ player ], undefined, undefined, 1 );
            }
        }
        
        wait 8;
    }
}

// Namespace cancer_confront
// Params 0
// Checksum 0x7addf6a4, Offset: 0x416a
// Size: 0xfb
function function_2deee207b2e394fe()
{
    activity_instance = self;
    activity_instance endon( #"hash_f0c47e3beabb6cb0" );
    activity_instance endon( #"hash_7c23a60301f5800e" );
    center_origin = activity_instance.var_75b078357b73a0e7.origin;
    
    while ( true )
    {
        nearby_players = function_d63fe6a4c08ba6f5( center_origin, 3000, 1000, 0 );
        
        /#
        #/
        
        foreach ( player in activity_instance.playerparticipants )
        {
            if ( !arraycontains( nearby_players, player ) )
            {
                activity_instance thread function_7b53a62e7291eca2( [ player ] );
            }
        }
        
        wait 1;
    }
}

/#

    // Namespace cancer_confront
    // Params 0
    // Checksum 0x3cdad0e0, Offset: 0x426d
    // Size: 0x5, Type: dev
    function function_55a11af1ddb5ab60()
    {
        
    }

#/

// Namespace cancer_confront
// Params 0
// Checksum 0x2315ccb9, Offset: 0x427a
// Size: 0x1a8
function function_93a8fc2b2e83fe15()
{
    activity_instance = self;
    vfx_struct = utility::getstruct( activity_instance.varianttag + "_capture_vfx_location", "targetname" );
    activity_instance.vfx_struct = vfx_struct;
    activity_instance.circle_fx = spawnfx( utility::getfx( "cancer_capture_ring" ), vfx_struct.origin, anglestoforward( vfx_struct.angles ) );
    triggerfx( activity_instance.circle_fx );
    activity_instance.var_dc21504e32f2eda6 = function_4c3e50b4ca2f6d55( activity_instance.var_75b078357b73a0e7.origin, activity_instance.playerparticipants, 350, "sat_ob_objectivemarker_storymissionmain" );
    
    foreach ( player in activity_instance.playerparticipants )
    {
        player utility::callsharedfunc( #"hint", #"add_simple", "hint_defend_circles", &"sat_ob/hint_defend_circles", 10 );
    }
    
    activity_instance mission_ui::function_759924b87215156b( 0, 100, activity_instance.playerparticipants );
    activity_instance childthread function_1af1993440aa0f29( vfx_struct.origin );
    activity_instance childthread function_f29c4219343e7f3c();
    activity_instance.holdout_active = 1;
    activity_instance function_7042d4fe06a09786();
}

/#

    // Namespace cancer_confront
    // Params 0
    // Checksum 0xf1b978d4, Offset: 0x442a
    // Size: 0x5, Type: dev
    function function_221345a4ede0abb4()
    {
        
    }

#/

// Namespace cancer_confront
// Params 0, eflags: 0x4
// Checksum 0xdcfab529, Offset: 0x4437
// Size: 0x13f
function private function_c3405e0bcb4c2965()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance endon( #"hash_7c23a60301f5800e" );
    activity_instance endon( #"hash_f0c47e3beabb6cb0" );
    requestid = activity_instance activity_ai_encounters::function_92b671064b0b1ce2( activity_instance.varianttag + "_holdout_floodfill", 1, 0, 1, 0 );
    activity_instance.holdout_floodfill = {};
    activity_instance.holdout_floodfill.requestid = requestid;
    activity_instance.holdout_floodfill.should_spawn = 0;
    activity_instance.holdout_floodfill.should_shutdown = 0;
    activity_instance.holdout_floodfill.spawn_cadence = 7.5;
    activity_instance.holdout_floodfill.a_spawned_ai = [];
    activity_instance activity_ai_encounters::function_d33de057e760c97b( requestid, &should_shutdown_holdout_floodfill, activity_instance.holdout_floodfill );
    activity_instance activity_ai_encounters::function_dcf6bdb6ee9d1ca0( requestid, &should_spawn_holdout_floodfill, activity_instance.holdout_floodfill );
    activity_instance activity_ai_encounters::function_52d1342183200a8f( requestid, &function_f07d2f8c91ac04fe, activity_instance );
    activity_instance childthread function_6c2840fa71e49550();
}

// Namespace cancer_confront
// Params 2, eflags: 0x4
// Checksum 0x1c634b17, Offset: 0x457e
// Size: 0x3a
function private should_shutdown_holdout_floodfill( requestid, userdata )
{
    if ( userdata.should_shutdown )
    {
        ai_spawn_director::cancel_spawn_request( requestid, 1, 0 );
    }
    
    return userdata.should_shutdown;
}

// Namespace cancer_confront
// Params 2, eflags: 0x4
// Checksum 0x2927d450, Offset: 0x45c1
// Size: 0x20
function private should_spawn_holdout_floodfill( requestid, userdata )
{
    return userdata.should_spawn;
}

// Namespace cancer_confront
// Params 4, eflags: 0x4
// Checksum 0x3d1a4603, Offset: 0x45ea
// Size: 0x96
function private function_f07d2f8c91ac04fe( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    activity_instance = userdata;
    activity_instance.holdout_floodfill.should_spawn = 0;
    activity_instance.holdout_floodfill.a_spawned_ai[ activity_instance.holdout_floodfill.a_spawned_ai.size ] = agent;
    userdata function_9c01a6fc5e8fa884( requestid, userdata, agent, data );
}

// Namespace cancer_confront
// Params 0, eflags: 0x4
// Checksum 0x6a5ded3a, Offset: 0x4688
// Size: 0xc5
function private function_6c2840fa71e49550()
{
    activity_instance = self;
    
    while ( !activity_instance.holdout_floodfill.should_shutdown )
    {
        activity_instance.holdout_floodfill.should_spawn = 1;
        spawn_buffer = 0;
        
        if ( activity_instance.playerparticipants.size <= 2 )
        {
            spawn_buffer += 2.5;
        }
        
        if ( !activity_instance.player_in_zone )
        {
            spawn_buffer += 3.5;
        }
        
        iprintlnbold( "buffer: " + spawn_buffer );
        
        if ( !activity_instance.holdout_active )
        {
            wait 15;
            continue;
        }
        
        wait activity_instance.holdout_floodfill.spawn_cadence + spawn_buffer;
    }
}

/#

    // Namespace cancer_confront
    // Params 0
    // Checksum 0x3fbdfa2f, Offset: 0x4755
    // Size: 0x5, Type: dev
    function function_8f09f7111144e180()
    {
        
    }

#/

// Namespace cancer_confront
// Params 0, eflags: 0x4
// Checksum 0xe7515514, Offset: 0x4762
// Size: 0x101
function private function_7042d4fe06a09786()
{
    activity_instance = self;
    requestid = activity_instance activity_ai_encounters::function_92b671064b0b1ce2( activity_instance.varianttag + "_holdout_waves", 1, 0, 1, 0 );
    activity_instance.holdout_waves = {};
    activity_instance.holdout_waves.requestid = requestid;
    activity_instance.holdout_waves.should_spawn = 0;
    activity_instance.holdout_waves.should_shutdown = 0;
    activity_instance.holdout_waves.a_spawned_ai = [];
    activity_instance activity_ai_encounters::function_d33de057e760c97b( requestid, &should_shutdown_holdout_waves, activity_instance.holdout_waves );
    activity_instance activity_ai_encounters::function_dcf6bdb6ee9d1ca0( requestid, &should_spawn_holdout_waves, activity_instance.holdout_waves );
    activity_instance activity_ai_encounters::function_202051e510314502( requestid, &function_a7ffbf5e70ac5e1e, activity_instance.holdout_waves );
    activity_instance activity_ai_encounters::function_52d1342183200a8f( requestid, &function_446dc86a22b8e2a1, activity_instance );
}

// Namespace cancer_confront
// Params 2, eflags: 0x4
// Checksum 0xa2718264, Offset: 0x486b
// Size: 0x3a
function private should_shutdown_holdout_waves( requestid, userdata )
{
    if ( userdata.should_shutdown )
    {
        ai_spawn_director::cancel_spawn_request( requestid, 1, 0 );
    }
    
    return userdata.should_shutdown;
}

// Namespace cancer_confront
// Params 2, eflags: 0x4
// Checksum 0xf5f8f3b0, Offset: 0x48ae
// Size: 0x20
function private should_spawn_holdout_waves( requestid, userdata )
{
    return userdata.should_spawn;
}

// Namespace cancer_confront
// Params 2, eflags: 0x4
// Checksum 0x76a84b8f, Offset: 0x48d7
// Size: 0x29
function private function_a7ffbf5e70ac5e1e( requestid, userdata )
{
    userdata.should_spawn = 0;
    function_fbe9bb47edbe2d7c( requestid );
}

// Namespace cancer_confront
// Params 4, eflags: 0x4
// Checksum 0x4f296a7e, Offset: 0x4908
// Size: 0x96
function private function_446dc86a22b8e2a1( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    activity_instance = userdata;
    activity_instance.holdout_waves.should_spawn = 0;
    activity_instance.holdout_waves.a_spawned_ai[ activity_instance.holdout_waves.a_spawned_ai.size ] = agent;
    userdata function_9c01a6fc5e8fa884( requestid, userdata, agent, data );
}

// Namespace cancer_confront
// Params 4, eflags: 0x4
// Checksum 0x87d6410f, Offset: 0x49a6
// Size: 0xf3
function private function_9c01a6fc5e8fa884( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    activity_instance = self;
    agent forcethreatupdate();
    struct = utility::getstruct( activity_instance.varianttag + "_center" );
    agent function_fa32376aaa88a7a2( struct.origin, 2000 );
    
    if ( activity_instance.holdout_active )
    {
        agent zombie_utils::function_a8ce00e0448cb6f0( "run", activity_instance.varianttag, 10 );
    }
    else
    {
        agent zombie_utils::function_a8ce00e0448cb6f0( "walk", activity_instance.varianttag, 10 );
    }
    
    if ( agent.classname == "actor_sat_spawner_zombie_base_ob_falkner" )
    {
        agent.nocorpse = 1;
        agent childthread fake_falkner_damage_watcher( activity_instance );
    }
}

// Namespace cancer_confront
// Params 0
// Checksum 0x4bcbb3b3, Offset: 0x4aa1
// Size: 0x2dd
function function_f29c4219343e7f3c()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance endon( #"hash_f0c47e3beabb6cb0" );
    activity_instance endon( #"hash_7c23a60301f5800e" );
    activity_instance waittill( #"NOTIFY_HOLDOUT_PROGRESS_CHECKPOINT_10" );
    
    /#
        iprintlnbold( "<dev string:x5e>" );
    #/
    
    activity_instance function_442d869007ff5215();
    activity_instance waittill( #"NOTIFY_HOLDOUT_PROGRESS_CHECKPOINT_20" );
    
    /#
        iprintlnbold( "<dev string:x76>" );
    #/
    
    if ( activity_instance.holdout_floodfill )
    {
        activity_instance.holdout_floodfill.spawn_cadence -= 0.85;
    }
    
    if ( activity_instance.playerparticipants.size > 2 )
    {
        activity_instance function_eeccad9106d24b5a( activity_instance.holdout_waves, "cancer_holdout_small_horde", 1 );
    }
    
    activity_instance waittill( #"NOTIFY_HOLDOUT_PROGRESS_CHECKPOINT_40" );
    
    /#
        iprintlnbold( "<dev string:x8e>" );
    #/
    
    if ( activity_instance.holdout_floodfill )
    {
        activity_instance.holdout_floodfill.spawn_cadence -= 0.85;
    }
    
    if ( activity_instance.playerparticipants.size > 2 )
    {
        activity_instance function_eeccad9106d24b5a( activity_instance.holdout_waves, "cancer_holdout_medium_horde", 1 );
    }
    else
    {
        activity_instance function_eeccad9106d24b5a( activity_instance.holdout_waves, "cancer_holdout_small_horde", 1 );
    }
    
    activity_instance waittill( #"NOTIFY_HOLDOUT_PROGRESS_CHECKPOINT_60" );
    
    /#
        iprintlnbold( "<dev string:xa6>" );
    #/
    
    if ( activity_instance.holdout_floodfill )
    {
        activity_instance.holdout_floodfill.spawn_cadence -= 0.85;
    }
    
    if ( activity_instance.playerparticipants.size > 2 )
    {
        activity_instance function_eeccad9106d24b5a( activity_instance.holdout_waves, "cancer_holdout_horde", 1 );
    }
    else
    {
        activity_instance function_eeccad9106d24b5a( activity_instance.holdout_waves, "cancer_holdout_medium_horde", 1 );
    }
    
    activity_instance waittill( #"NOTIFY_HOLDOUT_PROGRESS_CHECKPOINT_80" );
    
    /#
        iprintlnbold( "<dev string:xbe>" );
    #/
    
    if ( activity_instance.holdout_floodfill )
    {
        activity_instance.holdout_floodfill.spawn_cadence -= 0.85;
    }
    
    if ( activity_instance.playerparticipants.size > 2 )
    {
        activity_instance function_eeccad9106d24b5a( activity_instance.holdout_waves, "cancer_holdout_horde", 1 );
        return;
    }
    
    activity_instance function_eeccad9106d24b5a( activity_instance.holdout_waves, "cancer_holdout_horde", 1 );
}

// Namespace cancer_confront
// Params 1
// Checksum 0x1910b466, Offset: 0x4d86
// Size: 0x2b4
function function_1af1993440aa0f29( center_origin )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.holdout_progress = 0;
    progress = 0;
    activity_instance childthread function_e8e6f4bbc3752e65( 10, "NOTIFY_HOLDOUT_PROGRESS_CHECKPOINT_10" );
    activity_instance childthread function_e8e6f4bbc3752e65( 20, "NOTIFY_HOLDOUT_PROGRESS_CHECKPOINT_20" );
    activity_instance childthread function_e8e6f4bbc3752e65( 40, "NOTIFY_HOLDOUT_PROGRESS_CHECKPOINT_40" );
    activity_instance childthread function_e8e6f4bbc3752e65( 60, "NOTIFY_HOLDOUT_PROGRESS_CHECKPOINT_60" );
    activity_instance childthread function_e8e6f4bbc3752e65( 80, "NOTIFY_HOLDOUT_PROGRESS_CHECKPOINT_80" );
    activity_instance childthread function_e8e6f4bbc3752e65( 90, "NOTIFY_HOLDOUT_PROGRESS_CHECKPOINT_90" );
    
    while ( progress < 90 )
    {
        result = activity_instance players_in_area( activity_instance.playerparticipants, center_origin );
        
        if ( result )
        {
            activity_instance notify( #"hash_241b818bca64b25f" );
            progress += 1;
            activity_instance.player_in_zone = 1;
        }
        else
        {
            activity_instance notify( #"hash_286f42bd15b9b009" );
            activity_instance.player_in_zone = 0;
        }
        
        progress = max( progress, 0 );
        ui_val = mapfloat( 0, 90, 0, 100, progress );
        ui_val = int( ui_val );
        activity_instance.holdout_progress = ui_val;
        
        if ( activity_instance.playerparticipants.size > 0 )
        {
            activity_instance mission_ui::function_759924b87215156b( ui_val, 100, activity_instance.playerparticipants );
        }
        
        if ( progress >= 90 )
        {
            break;
        }
        
        /#
            cylinder( center_origin - ( 0, 0, 100 ), center_origin + ( 0, 0, 100 ), 300, ( 1, 0, 1 ), 0, 5 );
        #/
        
        wait 1;
    }
    
    ob_story_mission_utils::objective_marker_clear( activity_instance.var_dc21504e32f2eda6, activity_instance.playerparticipants );
    activity_instance.circle_fx delete();
    activity_instance.var_75b078357b73a0e7 setscriptablepartstate( "music", "off" );
    
    if ( activity_instance.holdout_floodfill )
    {
        activity_instance.holdout_floodfill.should_shutdown = 1;
    }
    
    if ( activity_instance.holdout_waves )
    {
        activity_instance.holdout_waves.should_shutdown = 1;
    }
    
    if ( activity_instance.holdout_waves )
    {
        activity_instance.holdout_waves.should_shutdown = 1;
    }
    
    activity_instance thread function_bfb3870ecd5ba9cd();
    activity_instance thread function_fa0284c050f31749();
    activity_instance function_7b905484e4beb72e( center_origin );
    activity_instance notify( #"hash_f0c47e3beabb6cb0" );
}

// Namespace cancer_confront
// Params 2
// Checksum 0xb6767a33, Offset: 0x5042
// Size: 0x41
function function_e8e6f4bbc3752e65( checkpoint_checkpoint, checkpoint_notify )
{
    activity_instance = self;
    
    while ( activity_instance.holdout_progress < checkpoint_checkpoint )
    {
        wait 1;
    }
    
    activity_instance notify( checkpoint_notify );
}

// Namespace cancer_confront
// Params 1
// Checksum 0x91b9363c, Offset: 0x508b
// Size: 0xec
function function_7b905484e4beb72e( center_origin )
{
    activity_instance = self;
    var_731b96fe729ebbf9 = [];
    
    if ( activity_instance.holdout_floodfill )
    {
        activity_instance.holdout_floodfill.a_spawned_ai = utility::array_removedead_or_dying( activity_instance.holdout_floodfill.a_spawned_ai );
        var_731b96fe729ebbf9 = arraycombine( var_731b96fe729ebbf9, activity_instance.holdout_floodfill.a_spawned_ai );
    }
    
    if ( activity_instance.holdout_waves )
    {
        activity_instance.holdout_waves.a_spawned_ai = utility::array_removedead_or_dying( activity_instance.holdout_waves.a_spawned_ai );
        var_731b96fe729ebbf9 = arraycombine( var_731b96fe729ebbf9, activity_instance.holdout_waves.a_spawned_ai );
    }
    
    activity_instance childthread function_b95c324c7b2d9f63( center_origin, 400, undefined, var_731b96fe729ebbf9 );
}

// Namespace cancer_confront
// Params 0
// Checksum 0xb86dc138, Offset: 0x517f
// Size: 0x168
function function_fced7f97646c55fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance endon( #"hash_f0c47e3beabb6cb0" );
    max_time = 140;
    current_time = max_time;
    current_time = int( current_time );
    mission_ui::function_1ee77ed07dcad9b7( current_time, activity_instance.playerparticipants );
    activity_instance.approaching_fail = 0;
    
    while ( true )
    {
        if ( !activity_instance.player_in_zone )
        {
            current_time -= 1;
            current_time = int( current_time );
            
            if ( activity_instance.playerparticipants.size > 0 )
            {
                mission_ui::function_2b2cdf8a2b3a224c( 0, activity_instance.playerparticipants );
                mission_ui::function_1ee77ed07dcad9b7( current_time, activity_instance.playerparticipants );
            }
        }
        else if ( activity_instance.playerparticipants.size > 0 )
        {
            mission_ui::function_2b2cdf8a2b3a224c( 1, activity_instance.playerparticipants );
        }
        
        if ( current_time <= 0 )
        {
            break;
        }
        else if ( current_time > 10 && current_time <= 30 )
        {
            activity_instance notify( #"notify_cancer_transmitter_timer_warning" );
        }
        else if ( current_time > 0 && current_time <= 10 )
        {
            activity_instance notify( #"hash_4a3475f29233abbf" );
            activity_instance.approaching_fail = 1;
        }
        
        wait 1;
    }
    
    activity_instance thread function_9ce9acaa4892b39();
}

// Namespace cancer_confront
// Params 0
// Checksum 0x42bb280e, Offset: 0x52ef
// Size: 0x22a
function function_9ce9acaa4892b39()
{
    activity_instance = self;
    activity_instance notify( #"hash_7c23a60301f5800e" );
    teleport_structs = utility::getstructarray( "cancer_saferoom_reset_teleport", "targetname" );
    activity_instance thread function_7b53a62e7291eca2( activity_instance.playerparticipants, 1 );
    activity_instance thread function_f5949e380a725462();
    wait 1.3;
    activity_instance thread activity_cleanup();
    activity_instance thread activity_ai_encounters::function_2574b40bde3bd456( 1 );
    wait 0.25;
    cancer_mission = level.cancer_missions[ activity_instance.playerparticipants[ 0 ].sessionsquadid ];
    
    if ( cancer_mission )
    {
        namespace_b451b5202140ccde::function_16223345ffbb5859( %"hash_7e8e22c6486bac0c", activity_instance.playerparticipants );
        cancer_mission.mission_ui = { #difficulty:3, #state:2, #name:%"hash_7e8e22c6486bac0c" };
        activity_instance thread function_cc9842ce1393d06( cancer_mission );
    }
    
    level ob_story_mission_utils::mission_objective_marker_show( level.var_30e6c9f02fa6bf2c, activity_instance.playerparticipants );
    interact_struct = utility::getstruct( "cancer_confront_reset_interact", "targetname" );
    reset_scriptable = spawnscriptable( "sat_ob_cancer_confront_activity_starter", interact_struct.origin, interact_struct.angles );
    reset_scriptable setscriptablepartstate( "nexus_activity_joiner_phone", "visible" );
    interaction::register_scriptable_interact( reset_scriptable, &reset_on_interact );
    reset_scriptable function_7653c765b6c7b815();
    
    foreach ( player in activity_instance.playerparticipants )
    {
        reset_scriptable enablescriptableplayeruse( player );
    }
    
    activity_instance thread function_bfb3870ecd5ba9cd();
    activity_instance thread function_fa0284c050f31749();
    reset_scriptable.activity_instance = activity_instance;
    activity_instance.reset_scriptable = reset_scriptable;
}

// Namespace cancer_confront
// Params 2
// Checksum 0xfdca2614, Offset: 0x5521
// Size: 0x1ca
function function_7b53a62e7291eca2( players, reset = 0 )
{
    activity_instance = self;
    teleport_structs = utility::getstructarray( "cancer_saferoom_teleport", "targetname" );
    
    if ( reset )
    {
        teleport_structs = utility::getstructarray( "cancer_saferoom_reset_teleport", "targetname" );
    }
    
    foreach ( player in players )
    {
        player thread hud_util::fade_out( 0.1, "white" );
    }
    
    wait 0.1;
    coop::teleport_players( players, teleport_structs );
    
    foreach ( player in players )
    {
        player thread function_16ebcc5ed60568e5( 2 );
    }
    
    wait 1.3;
    
    foreach ( player in players )
    {
        player thread hud_util::fade_in( 1, "white" );
    }
}

// Namespace cancer_confront
// Params 1
// Checksum 0x443994ea, Offset: 0x56f3
// Size: 0x32
function reset_on_interact( player )
{
    scriptable = self;
    scriptable.activity_instance thread activity_main();
    scriptable freescriptable();
}

// Namespace cancer_confront
// Params 2
// Checksum 0xe9717203, Offset: 0x572d
// Size: 0xa3, Type: bool
function players_in_area( activity_players, center_origin )
{
    nearby_players = function_d63fe6a4c08ba6f5( center_origin, 300, 100, 1 );
    
    foreach ( player in nearby_players )
    {
        if ( arraycontains( activity_players, player ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace cancer_confront
// Params 0
// Checksum 0x1a79e21e, Offset: 0x57d9
// Size: 0x1de
function spawn_defenses()
{
    activity_instance = self;
    mine_structs = utility::getstructarray( activity_instance.varianttag + "_mine", "targetname" );
    
    if ( isdefined( mine_structs ) )
    {
        foreach ( struct in mine_structs )
        {
            trap_owner = ob_activity_utility::function_d12ca4c58fe5faf0();
            mine = ob_soldier_util::ob_mine_spawn( struct.origin, undefined, trap_owner, undefined, struct.angles, 1 );
            activity_instance.mines[ activity_instance.mines.size ] = mine;
        }
    }
    
    turret_structs = utility::getstructarray( activity_instance.varianttag + "_turret", "targetname" );
    
    if ( isdefined( turret_structs ) )
    {
        foreach ( struct in turret_structs )
        {
            struct.allowemp = 1;
            sentry = ob_soldier_util::ob_sentry_turret_spawn( struct );
            
            if ( isdefined( sentry.colmodel ) )
            {
                sentry.colmodel show();
            }
            
            activity_instance.sentries[ activity_instance.sentries.size ] = sentry;
        }
    }
}

/#

    // Namespace cancer_confront
    // Params 0
    // Checksum 0x1ccf898a, Offset: 0x59bf
    // Size: 0x5, Type: dev
    function function_a5ce46fad935c62()
    {
        
    }

#/

// Namespace cancer_confront
// Params 0
// Checksum 0xce0c7d59, Offset: 0x59cc
// Size: 0xb3
function spawn_initial_fake_falkner()
{
    activity_instance = self;
    spawn_struct = utility::getstruct( activity_instance.varianttag + "_initial_fake_falkner", "targetname" );
    activity_instance.initial_fake_falkner_id = ai_spawn_director::function_e19f6a00c4bb7490( activity_instance.varianttag + "initial_fake_falkner", 0, 1, 1 );
    ai_spawn_director::function_35aa3b1d92cd8207( "OnSpawned", activity_instance.initial_fake_falkner_id, &function_c28dc00f966257e2, activity_instance );
    ai_spawn_director::function_9893a28f1d682a28( activity_instance.initial_fake_falkner_id, "sat_ob_enemy_hvt_heavytactician_falkner", spawn_struct.origin, spawn_struct.angles, 1, 1, 1, "team_hundred_ninety" );
}

// Namespace cancer_confront
// Params 0
// Checksum 0x346bdf45, Offset: 0x5a87
// Size: 0xab
function function_442d869007ff5215()
{
    activity_instance = self;
    requestid = activity_instance activity_ai_encounters::function_92b671064b0b1ce2( activity_instance.varianttag + "_fake_falkners", 1, 0, 1, 0 );
    activity_instance.fake_falkner.requestid = requestid;
    activity_instance activity_ai_encounters::function_52d1342183200a8f( requestid, &fake_falkner_on_spawn, activity_instance );
    activity_instance activity_ai_encounters::function_dcf6bdb6ee9d1ca0( requestid, &should_spawn_fake_falkners, activity_instance.fake_falkner );
    activity_instance activity_ai_encounters::function_d33de057e760c97b( requestid, &should_shutdown_fake_falkners, activity_instance.fake_falkner );
    activity_instance childthread function_150fe2cd00b5c8d9();
    activity_instance notify( #"hash_a69a534c97cff15" );
}

// Namespace cancer_confront
// Params 4
// Checksum 0x9dcd1b13, Offset: 0x5b3a
// Size: 0xf8
function fake_falkner_on_spawn( requestid, activity_instance, agent, data )
{
    activity_instance.fake_falkner.should_spawn = 0;
    activity_instance.fake_falkner.a_spawned_ai[ activity_instance.fake_falkner.a_spawned_ai.size ] = agent;
    agent.nocorpse = 1;
    agent.allowpain = 0;
    agent.var_70fbc1727d54c322 = 1;
    struct = utility::getstruct( activity_instance.varianttag + "_center" );
    agent function_fa32376aaa88a7a2( struct.origin, 500 );
    agent thread function_58bd72761958941( activity_instance );
    agent utility::set_battlechatter( 0 );
    agent thread fake_falkner_damage_watcher( activity_instance );
    agent thread function_90f42231951d362c( activity_instance );
}

// Namespace cancer_confront
// Params 4
// Checksum 0x98a226be, Offset: 0x5c3a
// Size: 0x94
function function_c28dc00f966257e2( requestid, activity_instance, agent, data )
{
    agent.nocorpse = 1;
    agent.ignoreall = 1;
    agent.allowpain = 0;
    agent.var_70fbc1727d54c322 = 1;
    agent utility::set_battlechatter( 0 );
    agent thread fake_falkner_damage_watcher( activity_instance );
    agent thread function_90f42231951d362c( activity_instance );
    agent thread function_c9718673d8ade24c( activity_instance );
    activity_instance.fake_falkner_initial = agent;
}

// Namespace cancer_confront
// Params 1
// Checksum 0x97d80f89, Offset: 0x5cd6
// Size: 0x52
function function_c9718673d8ade24c( activity_instance )
{
    self.animname = "scene_sat_cin_cancer_terminal_idle";
    animnode = utility::getstruct( "scene_sat_cin_cancer_terminal_idle", "targetname" );
    animnode thread scene::play( [ self ], "Idle" );
    self setcandamage( 1 );
}

// Namespace cancer_confront
// Params 2
// Checksum 0xad4b91bd, Offset: 0x5d30
// Size: 0x20
function should_spawn_fake_falkners( requestid, userdata )
{
    return userdata.should_spawn;
}

// Namespace cancer_confront
// Params 2
// Checksum 0xfac2e069, Offset: 0x5d59
// Size: 0x3a
function should_shutdown_fake_falkners( requestid, userdata )
{
    if ( userdata.should_shutdown )
    {
        ai_spawn_director::cancel_spawn_request( requestid, 1, 0 );
    }
    
    return userdata.should_shutdown;
}

// Namespace cancer_confront
// Params 1
// Checksum 0xc21178c3, Offset: 0x5d9c
// Size: 0x16a
function function_58bd72761958941( activity_instance )
{
    self endon( #"death" );
    self.fixednode = 1;
    
    if ( self.directorspawndata.script_noteworthy == "fake_falkner_static" || !self.directorspawndata.script_noteworthy )
    {
        self.dontevershoot = 1;
        self.var_c21ab247b16d758e = 0;
        self setallowshooting( 0 );
    }
    else if ( self.directorspawndata.script_noteworthy == "fake_falkner_shooter" )
    {
        if ( activity_instance.playerparticipants )
        {
            if ( activity_instance.playerparticipants.size == 0 )
            {
                /#
                    iprintln( "<dev string:xd6>" );
                #/
            }
            else if ( activity_instance.playerparticipants.size < 3 )
            {
                self.baseaccuracy = 0.25;
            }
        }
        
        self.ignoreall = utility::cointoss();
    }
    
    while ( true )
    {
        if ( self.directorspawndata.script_noteworthy == "fake_falkner_static" || !self.directorspawndata.script_noteworthy )
        {
            break;
        }
        
        if ( self.ignoreall )
        {
            wait 2;
        }
        else
        {
            wait 6;
        }
        
        if ( self.directorspawndata.script_noteworthy == "fake_falkner_shooter" )
        {
            self.ignoreall = 0;
        }
    }
}

// Namespace cancer_confront
// Params 0
// Checksum 0x8cc32332, Offset: 0x5f0e
// Size: 0x1aa
function function_150fe2cd00b5c8d9()
{
    activity_instance = self;
    
    while ( !activity_instance.fake_falkner.should_shutdown )
    {
        if ( isdefined( activity_instance.fake_falkner.a_spawned_ai ) )
        {
            activity_instance.fake_falkner.has_shooter = 0;
            
            foreach ( guy in activity_instance.fake_falkner.a_spawned_ai )
            {
                if ( guy.directorspawndata.script_noteworthy == "fake_falkner_shooter" && isalive( guy ) )
                {
                    activity_instance.fake_falkner.has_shooter = 1;
                }
            }
        }
        
        activity_instance.fake_falkner.should_spawn = !activity_instance.fake_falkner.has_shooter;
        wait 1;
        
        if ( activity_instance.fake_falkner.a_spawned_ai.size > 0 )
        {
            activity_instance.fake_falkner.a_spawned_ai = utility::array_removedead_or_dying( activity_instance.fake_falkner.a_spawned_ai );
        }
        
        wait 18;
    }
    
    activity_instance.fake_falkner.should_spawn = 0;
}

// Namespace cancer_confront
// Params 1
// Checksum 0xb55023e7, Offset: 0x60c0
// Size: 0x216
function fake_falkner_damage_watcher( activity_instance )
{
    agent = self;
    agent endon( #"death" );
    agent waittill( #"damage", damage, attacker, direction_vec, point, damagetype, modelname, tagname, partname, idflags, objweapon );
    level thread function_6be7bc069ebb77a3( agent.origin + ( 0, 0, 15 ), agent.angles );
    wait 0.6;
    animnode = utility::getstruct( "scene_sat_cin_cancer_terminal_idle", "targetname" );
    animnode scene::stop();
    animnode scene::cleanup();
    
    if ( agent.basearchetype == "soldier" )
    {
        if ( agent.directorspawndata.script_noteworthy == "fake_falkner_shooter" )
        {
            activity_instance notify( #"hash_762172a6f05a544b" );
            
            if ( activity_instance.fake_falkner.a_spawned_ai.size > 0 )
            {
                foreach ( decoy in activity_instance.fake_falkner.a_spawned_ai )
                {
                    decoy dodamage( 1, agent.origin );
                }
            }
        }
        
        activity_instance.fake_falkner.a_spawned_ai = arrayremove( activity_instance.fake_falkner.a_spawned_ai, agent );
    }
    
    agent kill();
}

// Namespace cancer_confront
// Params 1
// Checksum 0x78483b2b, Offset: 0x62de
// Size: 0x104
function function_90f42231951d362c( activity_instance )
{
    agent = self;
    agent endon( #"death" );
    dist = 90000;
    too_close = 0;
    
    while ( !too_close && isalive( agent ) )
    {
        foreach ( player in activity_instance.playerparticipants )
        {
            if ( distancesquared( player.origin, agent.origin ) < dist )
            {
                agent dodamage( 1, agent.origin );
                too_close = 1;
                break;
            }
        }
        
        wait 0.1;
    }
}

/#

    // Namespace cancer_confront
    // Params 0
    // Checksum 0x43e91270, Offset: 0x63ea
    // Size: 0x5, Type: dev
    function function_b22d2b4dc37a2466()
    {
        
    }

#/

// Namespace cancer_confront
// Params 0
// Checksum 0xc6b63bb1, Offset: 0x63f7
// Size: 0x8d
function spawn_hvt_encounter()
{
    activity_instance = self;
    activity_instance.falkner_soldiers = [];
    var_836b80285d028ab3 = activity_instance activity_ai_encounters::function_92b671064b0b1ce2( activity_instance.varianttag + "_encounter_hvt", 0, 0, 1, 0 );
    activity_instance activity_ai_encounters::function_52d1342183200a8f( var_836b80285d028ab3, &soldier_on_spawn, activity_instance );
    activity_instance activity_ai_encounters::function_6bf4ff2fbde584ee( var_836b80285d028ab3, &encounter_finished_spawning, activity_instance );
    function_ef57f478f96b050c( var_836b80285d028ab3, 1 );
    function_64ac8c4e752f4dca( var_836b80285d028ab3, 0 );
    activity_instance notify( #"hash_40d3780ca9146bfe" );
    activity_instance thread function_3e5bdc56e04b9f0d();
}

// Namespace cancer_confront
// Params 2
// Checksum 0xa6dcb4af, Offset: 0x648c
// Size: 0x43
function encounter_finished_spawning( request_id, activity_instance )
{
    maxhealth = activity_instance.hvts[ 0 ].maxhealth;
    activity_instance setup_healthbar( maxhealth, maxhealth );
}

// Namespace cancer_confront
// Params 4
// Checksum 0x5f7dd035, Offset: 0x64d7
// Size: 0xff
function soldier_on_spawn( requestid, activity_instance, agent, data )
{
    activity_instance.falkner_soldiers[ activity_instance.falkner_soldiers.size ] = agent;
    
    if ( data.script_noteworthy )
    {
        switch ( data.script_noteworthy )
        {
            case #"hash_28474aab2b1db048":
                hvt_on_spawn( requestid, activity_instance, agent, data );
                anchor_ai = agent;
                break;
            default:
                break;
        }
    }
    else
    {
        if ( !isdefined( var_822d6cf18bd306b1 ) )
        {
            var_822d6cf18bd306b1 = [];
        }
        
        var_822d6cf18bd306b1[ var_822d6cf18bd306b1.size ] = agent;
        agent utility::set_battlechatter( 1 );
    }
    
    if ( anchor_ai && var_822d6cf18bd306b1 )
    {
        ob_humans::function_6198eaa0deba2b53( anchor_ai, var_822d6cf18bd306b1 );
        
        /#
            iprintln( "<dev string:x113>" + anchor_ai.classname );
        #/
        
        return;
    }
    
    /#
        iprintlnbold( "<dev string:x128>" );
    #/
}

// Namespace cancer_confront
// Params 0
// Checksum 0xd38882de, Offset: 0x65de
// Size: 0xa6
function function_3e5bdc56e04b9f0d()
{
    activity_instance = self;
    activity_instance endon( #"notify_cancer_falkner_defeated" );
    
    while ( !activity_instance.falkner_soldiers || activity_instance.falkner_soldiers.size <= 1 )
    {
        waitframe();
    }
    
    while ( activity_instance.falkner_soldiers.size > 1 )
    {
        activity_instance.falkner_soldiers = utility::array_removedead_or_dying( activity_instance.falkner_soldiers );
        waitframe();
    }
    
    activity_instance notify( #"notify_cancer_falkner_bodyguards_defeated" );
    level utility::flag_set( "flag_cancer_falkner_bodyguards_defeated" );
    activity_instance.var_32c2e3f15a29e202 = 1;
    activity_instance thread function_49fe020b562fe385();
}

// Namespace cancer_confront
// Params 0
// Checksum 0x15c7e298, Offset: 0x668c
// Size: 0xcf
function function_49fe020b562fe385()
{
    activity_instance = self;
    activity_instance endon( #"hvt_confirmed" );
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    dist = 50;
    dist_sqrd = dist * dist;
    wait 5;
    
    while ( activity_instance.falkner )
    {
        nav_position = getclosestpointonnavmesh( activity_instance.falkner.origin );
        
        if ( distancesquared( nav_position, activity_instance.falkner.origin ) > dist_sqrd )
        {
            break;
        }
        
        wait 0.1;
    }
    
    activity_instance utility::flag_set( "notify_cancer_falkner_defeated" );
    activity_instance notify( #"hvt_confirmed" );
}

// Namespace cancer_confront
// Params 4
// Checksum 0x1d207831, Offset: 0x6763
// Size: 0x158
function hvt_on_spawn( requestid, activity_instance, agent, data )
{
    activity_instance utility::flag_set( "hvt_spawned" );
    agent.nocorpse = 1;
    agent.var_24954f14e27b448d = 0;
    agent.var_e94a0381e288005e = #"activity_scorpio_interior";
    
    if ( activity_instance.playerparticipants.size > 2 )
    {
        agent.maxhealth *= 4;
        agent.health = agent.maxhealth;
        agent.armorhealth *= 4;
    }
    
    activity_instance.falkner = agent;
    
    if ( !isdefined( activity_instance.hvts ) )
    {
        activity_instance.hvts = [];
    }
    
    activity_instance.hvts[ activity_instance.hvts.size ] = agent;
    activity_instance thread function_e3bbc2d827a20273( agent );
    activity_instance thread function_a008810195f3a277( agent );
    agent utility::set_battlechatter( 0 );
    
    if ( isdefined( agent.battlechatter.npcid ) )
    {
        agent.battlechatter.npcid = "1";
    }
}

// Namespace cancer_confront
// Params 1
// Checksum 0x75e8c4be, Offset: 0x68c3
// Size: 0xac
function hvt_set_weapon( data )
{
    if ( !isdefined( data.script_noteworthy ) )
    {
        data.script_noteworthy = "";
    }
    
    switch ( data.script_noteworthy )
    {
        case #"hash_fa4dbdf6bd80bf52":
            weapon = weapon_utility::function_d2c8356dc369d9ce( "sat_pi_timir_mp" );
            self giveweapon( weapon );
            shared::forceuseweapon( weapon, "primary" );
            break;
        case #"hash_fa50b4f6bd82efbe":
            weapon = weapon_utility::function_d2c8356dc369d9ce( "sat_sh_husky_mp" );
            self giveweapon( weapon );
            shared::forceuseweapon( weapon, "primary" );
            break;
    }
}

// Namespace cancer_confront
// Params 1
// Checksum 0xfac8fcdd, Offset: 0x6977
// Size: 0xf6
function function_e3bbc2d827a20273( hvt )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    while ( isalive( hvt ) )
    {
        hvt waittill( #"damage", damage, attacker, direction_vec, point, damagetype, modelname, tagname, partname, idflags, objweapon );
        
        if ( activity_instance.health_struct )
        {
            activity_instance.health_struct.health -= damage;
            activity_instance update_healthbar();
        }
    }
}

// Namespace cancer_confront
// Params 1
// Checksum 0x8cc32cc1, Offset: 0x6a75
// Size: 0x31a
function function_a008810195f3a277( hvt )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    hvt ai::disable_long_death();
    hvt ai::magic_bullet_shield();
    total_damage = 0;
    
    while ( true )
    {
        hvt waittill( #"damage" );
        
        if ( activity_instance.health_struct.health <= 10 )
        {
            break;
        }
    }
    
    activity_instance.health_struct = undefined;
    
    foreach ( player in activity_instance.playerparticipants )
    {
        player ob_story_mission_utils::function_5a707116af438c92();
    }
    
    activity_instance notify( #"hash_6d758e050a7b3154" );
    hvt.animname = "falkner_downed";
    animnode = { #angles:hvt.angles, #origin:hvt.origin };
    animnode scene::set_scriptbundle( "scene_sat_cancer_confront_falkner_downed" );
    animnode thread scene::play( hvt );
    activity_instance.falkner_animnode = animnode;
    
    if ( !activity_instance.var_32c2e3f15a29e202 )
    {
        if ( activity_instance.falkner_soldiers )
        {
            activity_instance.falkner_soldiers = utility::array_removedead_or_dying( activity_instance.falkner_soldiers );
            
            foreach ( agent in activity_instance.falkner_soldiers )
            {
                agent thread function_fb37fc9d3df4f2fc();
            }
        }
        
        if ( activity_instance.falkner_soldiers.size )
        {
            activity_instance utility::waittill_notify_or_timeout( "notify_cancer_falkner_bodyguards_defeated", 30 );
        }
    }
    
    if ( activity_instance.falkner_soldiers )
    {
        activity_instance.falkner_soldiers = utility::array_removedead_or_dying( activity_instance.falkner_soldiers );
        
        foreach ( agent in activity_instance.falkner_soldiers )
        {
            if ( !agent.magic_bullet_shield )
            {
                agent kill();
            }
        }
    }
    
    activity_instance utility::flag_set( "notify_cancer_falkner_defeated" );
    activity_instance thread give_upgrade();
    create_hvt_interact( animnode );
}

// Namespace cancer_confront
// Params 1
// Checksum 0x614eb73b, Offset: 0x6d97
// Size: 0x130
function create_hvt_interact( hvt )
{
    activity_instance = self;
    cancer_mission = level.cancer_missions[ activity_instance.playerparticipants[ 0 ].sessionsquadid ];
    interact_scriptable = spawnscriptable( "sat_ob_cancer_hvt_interact", hvt.origin, hvt.angles );
    interact_scriptable setscriptablepartstate( "interact", "usable" );
    activity_instance.interact_scriptable = interact_scriptable;
    interact = interaction::register_scriptable_interact( interact_scriptable, &on_hvt_interact );
    interact.activity_instance = activity_instance;
    interact_scriptable disableplayeruseforallplayers();
    
    foreach ( player in activity_instance.playerparticipants )
    {
        interact_scriptable enableplayeruse( player );
    }
}

// Namespace cancer_confront
// Params 1
// Checksum 0x57b0f92d, Offset: 0x6ecf
// Size: 0x89
function on_hvt_interact( player )
{
    interact = self;
    interact.activity_instance notify( #"hvt_confirmed" );
    interact freescriptable();
    
    if ( isdefined( interact.activity_instance.falkner_animnode ) )
    {
        interact.activity_instance.falkner_animnode scene::stop();
        interact.activity_instance.falkner_animnode scene::cleanup( 1 );
    }
}

// Namespace cancer_confront
// Params 2
// Checksum 0xabc3591b, Offset: 0x6f60
// Size: 0x54
function function_6be7bc069ebb77a3( origin, angles )
{
    scriptable = spawnscriptable( "ob_sat_cradle_spawn_vfx", origin, angles );
    scriptable setscriptablepartstate( "body", "cradle_spawn_start" );
    wait randomfloatrange( 3.5, 5 );
    scriptable freescriptable();
}

// Namespace cancer_confront
// Params 0
// Checksum 0x8060d8cc, Offset: 0x6fbc
// Size: 0x171
function function_fb37fc9d3df4f2fc()
{
    self endon( #"death" );
    assert( self.unittype != "<dev string:x13a>" );
    
    while ( !function_889d56bd1e8182a5( self ) )
    {
        var_fb82ea42f3461323 = 0;
        
        while ( isalive( self.enemy ) && isplayer( self.enemy ) && distancesquared( self.origin, self.enemy.origin ) <= 262144 )
        {
            var_fb82ea42f3461323 = 1;
            self.pathenemyfightdist = 0;
            self.pathenemylookahead = 0;
            self.var_b35099cc0a791f1b = 0;
            self setbtgoalradius( 2, 256 );
            self setbtgoalpos( 2, self.enemy.origin );
            wait 5;
        }
        
        if ( var_fb82ea42f3461323 )
        {
            continue;
        }
        
        despawnpos = function_27714d830591cc56( self );
        starttime = gettime();
        
        if ( isdefined( despawnpos ) )
        {
            self setbtgoalpos( 2, despawnpos );
            self setbtgoalradius( 2, 256 );
            self waittill( #"bt_goal" );
        }
        
        waittime = getdvarfloat( @"hash_273a7f3e61e64e35", 10 );
        timediffseconds = ( gettime() - starttime ) / 1000;
        
        if ( timediffseconds < waittime )
        {
            wait waittime - timediffseconds;
        }
    }
    
    soldier_kill();
}

// Namespace cancer_confront
// Params 0
// Checksum 0x3ddb4360, Offset: 0x7135
// Size: 0x77
function soldier_kill()
{
    self endon( #"death" );
    assert( self.unittype != "<dev string:x13a>" );
    self.death_source = "despawn";
    self.nocorpse = 1;
    self.var_a13bed1ac47e1b2c = 1;
    self.dropweapon = 0;
    self.nodrop = 1;
    
    if ( self.magic_bullet_shield )
    {
        ai::stop_magic_bullet_shield();
    }
    
    self kill();
}

// Namespace cancer_confront
// Params 2
// Checksum 0x9ef5f6f8, Offset: 0x71b4
// Size: 0xda
function setup_healthbar( health, maxhealth )
{
    activity_instance = self;
    health_struct = spawnstruct();
    health_struct.health = health;
    health_struct.maxhealth = maxhealth;
    
    foreach ( player in activity_instance.playerparticipants )
    {
        player ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_falkner", health_struct );
    }
    
    activity_instance.health_struct = health_struct;
}

// Namespace cancer_confront
// Params 1
// Checksum 0xc2272c39, Offset: 0x7296
// Size: 0xc5
function update_healthbar( isimmune = 0 )
{
    activity_instance = self;
    
    foreach ( player in activity_instance.playerparticipants )
    {
        player ob_story_mission_utils::function_e231206f1628d4c6( 1 );
        
        if ( isimmune )
        {
            player ob_story_mission_utils::player_boss_healthbar_immune();
            continue;
        }
        
        if ( isdefined( player.var_71c37977095602df ) )
        {
            player ob_story_mission_utils::player_boss_healthbar_show();
        }
    }
}

/#

    // Namespace cancer_confront
    // Params 0
    // Checksum 0x7c8a94b1, Offset: 0x7363
    // Size: 0x5, Type: dev
    function function_db28ca36c8436e26()
    {
        
    }

#/

// Namespace cancer_confront
// Params 0, eflags: 0x4
// Checksum 0xdc1c88d8, Offset: 0x7370
// Size: 0x57
function private function_f5f96308c887d27d()
{
    activity_instance = self;
    activity_instance childthread function_8b8ded6761f22fc7();
    activity_instance childthread function_6c261791242d1444();
    activity_instance childthread function_4e464e105ab731a1();
    activity_instance childthread function_fda68ab933819bf4();
    activity_instance childthread function_3feb2abf67b0ca0f();
    activity_instance childthread function_67dc8899ad00b720();
    activity_instance childthread function_1909c06d324df85b();
    activity_instance thread function_2763e3c748581c92();
}

// Namespace cancer_confront
// Params 0, eflags: 0x4
// Checksum 0x4e4f0ec7, Offset: 0x73cf
// Size: 0x33
function private function_8b8ded6761f22fc7()
{
    activity_instance = self;
    overlord::playconversation( "cancer_penthouse_saferoom_disruption_conversation", activity_instance.playerparticipants );
    activity_instance notify( #"hash_843baf00e2f1d4dc" );
}

// Namespace cancer_confront
// Params 0, eflags: 0x4
// Checksum 0x475a2099, Offset: 0x740a
// Size: 0x34
function private function_6c261791242d1444()
{
    activity_instance = self;
    activity_instance waittill( #"notify_cancer_ambush_zombie_bookcase" );
    overlord::playevent( "cancer_penthouse_hostiles_detected", activity_instance.playerparticipants );
}

// Namespace cancer_confront
// Params 0, eflags: 0x4
// Checksum 0x9eb960c6, Offset: 0x7446
// Size: 0xa3
function private function_4e464e105ab731a1()
{
    activity_instance = self;
    activity_instance endon( #"hash_30feb2f649d146d9" );
    activity_instance waittill( #"notify_ambush_transmitter_visible" );
    overlord::playconversation( "cancer_penthouse_transmitter_encountered_conversation", activity_instance.playerparticipants );
    activity_instance notify( #"hash_125a9ce8a272461d" );
    activity_instance utility::waittill_notify_or_timeout( "notify_cancer_transmitter_timer_warning", 15 );
    overlord::playevent( "dx_wc_wcan_cflf_davi_letsmove", activity_instance.playerparticipants );
    
    if ( activity_instance.radio_marker )
    {
        ob_story_mission_utils::objective_marker_ping( activity_instance.radio_marker, activity_instance.playerparticipants );
    }
}

// Namespace cancer_confront
// Params 0, eflags: 0x4
// Checksum 0xd88bb692, Offset: 0x74f1
// Size: 0x65
function private function_fda68ab933819bf4()
{
    activity_instance = self;
    activity_instance endon( #"hash_f0c47e3beabb6cb0" );
    activity_instance waittill( #"hash_30feb2f649d146d9" );
    overlord::playevent( "cancer_transmitter_hack_start", activity_instance.playerparticipants );
    activity_instance childthread function_2957e30377a8ab0b();
    activity_instance childthread function_ec16ab41c25ca1b8();
    activity_instance childthread function_e962d0847cd76f90();
    activity_instance childthread function_d6442249af359d44();
}

// Namespace cancer_confront
// Params 0, eflags: 0x4
// Checksum 0x96e92025, Offset: 0x755e
// Size: 0xc3
function private function_2957e30377a8ab0b()
{
    activity_instance = self;
    var_a1163c8eec5c1da4 = 5;
    var_fc86114500827599 = 15;
    var_fd50fd72773c570a = 30;
    
    while ( true )
    {
        activity_instance waittill( #"hash_286f42bd15b9b009" );
        
        if ( !activity_instance.approaching_fail )
        {
            activity_instance childthread function_76f6428f6988e8b0( 1, var_a1163c8eec5c1da4 );
            activity_instance childthread function_76f6428f6988e8b0( 2, var_fc86114500827599 );
            activity_instance childthread function_76f6428f6988e8b0( 3, var_fd50fd72773c570a );
        }
        else
        {
            activity_instance childthread function_76f6428f6988e8b0( 2, var_a1163c8eec5c1da4 );
        }
        
        activity_instance waittill( #"hash_241b818bca64b25f" );
        ob_story_mission_utils::function_6c52650cb36dd9d3( activity_instance.var_dc21504e32f2eda6, activity_instance.playerparticipants );
    }
}

// Namespace cancer_confront
// Params 2, eflags: 0x4
// Checksum 0xa1fabccc, Offset: 0x7629
// Size: 0xd7
function private function_76f6428f6988e8b0( nag_type, timeout )
{
    activity_instance = self;
    activity_instance endon( #"hash_241b818bca64b25f" );
    wait timeout;
    ob_story_mission_utils::objective_marker_ping( activity_instance.var_dc21504e32f2eda6, activity_instance.playerparticipants );
    
    switch ( nag_type )
    {
        case 1:
            overlord::playevent( "cancer_nag_transmitter_left_1", activity_instance.playerparticipants );
            break;
        case 2:
            overlord::playevent( "cancer_nag_transmitter_left_2", activity_instance.playerparticipants );
            break;
        case 3:
        default:
            overlord::playevent( "cancer_nag_transmitter_left_3", activity_instance.playerparticipants );
            break;
    }
}

// Namespace cancer_confront
// Params 0, eflags: 0x4
// Checksum 0x82cc4688, Offset: 0x7708
// Size: 0x41
function private function_ec16ab41c25ca1b8()
{
    activity_instance = self;
    activity_instance endon( #"hash_762172a6f05a544b" );
    activity_instance waittill( #"hash_a69a534c97cff15" );
    overlord::playconversation( "cancer_penthouse_transmitter_fake_falkner_encountered_conversation", activity_instance.playerparticipants );
}

// Namespace cancer_confront
// Params 0, eflags: 0x4
// Checksum 0x2f53aeff, Offset: 0x7751
// Size: 0x34
function private function_e962d0847cd76f90()
{
    activity_instance = self;
    activity_instance waittill( #"hash_762172a6f05a544b" );
    overlord::playconversation( "cancer_penthouse_transmitter_fake_falkner_killed_conversation", activity_instance.playerparticipants );
}

// Namespace cancer_confront
// Params 0, eflags: 0x4
// Checksum 0x2614639b, Offset: 0x778d
// Size: 0x59
function private function_d6442249af359d44()
{
    activity_instance = self;
    activity_instance waittill( #"NOTIFY_HOLDOUT_PROGRESS_CHECKPOINT_40" );
    overlord::playevent( "cancer_penthouse_cradle_zombies_sky", activity_instance.playerparticipants );
    activity_instance waittill( #"NOTIFY_HOLDOUT_PROGRESS_CHECKPOINT_80" );
    overlord::playconversation( "cancer_penthouse_transmitter_near_complete_conversation", activity_instance.playerparticipants );
}

// Namespace cancer_confront
// Params 0, eflags: 0x4
// Checksum 0x8aa63f22, Offset: 0x77ee
// Size: 0x45
function private function_3feb2abf67b0ca0f()
{
    activity_instance = self;
    activity_instance waittill( #"hash_f0c47e3beabb6cb0" );
    overlord::playevent( "cancer_transmitter_signal_deactivated", activity_instance.playerparticipants, undefined, undefined, 1 );
    activity_instance notify( #"hash_5ac7d5a544c10b7d" );
}

// Namespace cancer_confront
// Params 0, eflags: 0x4
// Checksum 0x8292b43, Offset: 0x783b
// Size: 0x65
function private function_67dc8899ad00b720()
{
    activity_instance = self;
    activity_instance endon( #"hash_6d758e050a7b3154", #"notify_cancer_falkner_defeated" );
    activity_instance utility::flag_wait( "hvt_spawned" );
    activity_instance childthread function_2985833c0ce2f9c0();
    overlord::playconversation( "cancer_falkner_battle_intro_conversation", activity_instance.playerparticipants, 1.5 );
    activity_instance notify( #"NOTIFY_FALKNER_BATTLE_INTRO_VO_COMPLETED" );
}

// Namespace cancer_confront
// Params 0, eflags: 0x4
// Checksum 0x75d47227, Offset: 0x78a8
// Size: 0x89
function private function_2985833c0ce2f9c0()
{
    activity_instance = self;
    notify_msg = activity_instance utility::waittill_any_return( "NOTIFY_FALKNER_BATTLE_INTRO_VO_COMPLETED", "notify_cancer_falkner_bodyguards_defeated" );
    
    if ( notify_msg != "notify_cancer_falkner_bodyguards_defeated" )
    {
        overlord::playevent( "cancer_falkner_battle_hes_not_alone", activity_instance.playerparticipants );
        activity_instance waittill( #"notify_cancer_falkner_bodyguards_defeated" );
    }
    else
    {
        activity_instance waittill( #"NOTIFY_FALKNER_BATTLE_INTRO_VO_COMPLETED" );
    }
    
    wait 1.5;
    overlord::playevent( "cancer_falkner_battle_taunt", activity_instance.playerparticipants );
}

// Namespace cancer_confront
// Params 0, eflags: 0x4
// Checksum 0xb047526, Offset: 0x7939
// Size: 0xa2
function private function_1909c06d324df85b()
{
    activity_instance = self;
    activity_instance endon( #"hvt_confirmed" );
    activity_instance waittill( #"hash_6d758e050a7b3154" );
    overlord::playconversation( "cancer_falkner_battle_end_conversation", activity_instance.playerparticipants );
    
    if ( !utility::flag( "flag_cancer_falkner_bodyguards_defeated" ) )
    {
        overlord::playevent( "cancer_falkner_clear_bodyguards", activity_instance.playerparticipants );
        level utility::flag_wait( "flag_cancer_falkner_bodyguards_defeated" );
        overlord::playevent( "cancer_skyscraper_theyre_down", activity_instance.playerparticipants );
    }
    
    overlord::playevent( "cancer_grab_falkner", activity_instance.playerparticipants );
}

// Namespace cancer_confront
// Params 1, eflags: 0x4
// Checksum 0x4480c8a2, Offset: 0x79e3
// Size: 0x54
function private function_cc9842ce1393d06( cancer_mission )
{
    cancer_mission endon( #"hash_12d5cf384c4e5158" );
    activity_instance = self;
    overlord::playevent( "cancer_penthouse_saferoom_terminal_found_falkner_lab", activity_instance.playerparticipants );
    overlord::playevent( "cancer_penthouse_saferoom_worth_taking_look", activity_instance.playerparticipants );
}

// Namespace cancer_confront
// Params 0, eflags: 0x4
// Checksum 0xe13251a, Offset: 0x7a3f
// Size: 0x73
function private function_2763e3c748581c92()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed", #"hash_f0c47e3beabb6cb0" );
    activity_instance waittill( #"hash_7c23a60301f5800e" );
    overlord::function_e155a19c69aed191( activity_instance.playerparticipants );
    
    if ( activity_instance.radio_tower_complete )
    {
        overlord::playevent( "cancer_transmitter_deactivation_failed", activity_instance.playerparticipants );
    }
}

/#

    // Namespace cancer_confront
    // Params 0
    // Checksum 0x49afb1f1, Offset: 0x7aba
    // Size: 0x5, Type: dev
    function function_24839ae3697b8e50()
    {
        
    }

#/

// Namespace cancer_confront
// Params 1
// Checksum 0x8adb8658, Offset: 0x7ac7
// Size: 0x79
function function_cef440c15147d666( cancer_mission )
{
    activity_instance = self;
    activity_instance waittill( #"hash_843baf00e2f1d4dc" );
    activity_instance thread function_79539bba143d761e( cancer_mission );
    activity_instance waittill( #"hash_30feb2f649d146d9" );
    activity_instance thread function_426e8c11386496d5( cancer_mission );
    activity_instance utility::flag_wait( "hvt_spawned" );
    activity_instance thread function_31a69e85d814a1d3( cancer_mission );
    activity_instance utility::flag_wait( "notify_cancer_falkner_defeated" );
    activity_instance thread function_60697390b25a90c8( cancer_mission );
}

// Namespace cancer_confront
// Params 1
// Checksum 0x77fba8e4, Offset: 0x7b48
// Size: 0x11c
function function_79539bba143d761e( cancer_mission )
{
    activity_instance = self;
    namespace_b451b5202140ccde::function_16223345ffbb5859( %"hash_6648e994a1070671", activity_instance.playerparticipants );
    cancer_mission.mission_ui = { #difficulty:3, #state:2, #name:%"hash_6648e994a1070671" };
    activity_instance.obj_circle = ob_story_mission_utils::function_ab06e28322870f4( activity_instance.var_75b078357b73a0e7.origin, 1250, activity_instance.playerparticipants );
    activity_instance waittill( #"notify_ambush_transmitter_visible" );
    ob_story_mission_utils::function_352aa3aab98a0618( activity_instance.obj_circle );
    activity_instance waittill( #"hash_125a9ce8a272461d" );
    namespace_b451b5202140ccde::function_16223345ffbb5859( %"hash_455cc9bf715d136f", activity_instance.playerparticipants );
    cancer_mission.mission_ui = { #difficulty:3, #state:2, #name:%"hash_455cc9bf715d136f" };
}

// Namespace cancer_confront
// Params 1
// Checksum 0x3541065e, Offset: 0x7c6c
// Size: 0x97
function function_426e8c11386496d5( cancer_mission )
{
    activity_instance = self;
    namespace_b451b5202140ccde::function_16223345ffbb5859( %"hash_700ae1f21ec781d5", activity_instance.playerparticipants );
    cancer_mission.mission_ui = { #difficulty:3, #state:2, #name:%"hash_700ae1f21ec781d5" };
    activity_instance waittill( #"hash_f0c47e3beabb6cb0" );
    cancer_mission notify( #"hash_cb417506fb764fb2" );
    mission_ui::function_1ee77ed07dcad9b7( 0, activity_instance.playerparticipants );
}

// Namespace cancer_confront
// Params 1
// Checksum 0x8c7f67c3, Offset: 0x7d0b
// Size: 0x98
function function_31a69e85d814a1d3( cancer_mission )
{
    activity_instance = self;
    namespace_b451b5202140ccde::function_16223345ffbb5859( %"hash_3dd6831ddb99619f", activity_instance.playerparticipants );
    cancer_mission.mission_ui = { #difficulty:3, #state:2, #name:%"hash_3dd6831ddb99619f" };
    activity_instance.var_dc21504e32f2eda6 = function_5fc29e832e1dc539( activity_instance.falkner, activity_instance.playerparticipants, 85, "sat_ob_objectivemarker_boss" );
}

// Namespace cancer_confront
// Params 1
// Checksum 0x7b6544f0, Offset: 0x7dab
// Size: 0xfd
function function_60697390b25a90c8( cancer_mission )
{
    activity_instance = self;
    ob_story_mission_utils::objective_marker_clear( activity_instance.var_dc21504e32f2eda6, activity_instance.playerparticipants );
    namespace_b451b5202140ccde::function_16223345ffbb5859( %"hash_61780a086802dd0c", activity_instance.playerparticipants );
    cancer_mission.mission_ui = { #difficulty:3, #state:2, #name:%"hash_61780a086802dd0c" };
    
    while ( !activity_instance.interact_scriptable )
    {
        waitframe();
    }
    
    activity_instance.var_dc21504e32f2eda6 = function_4c3e50b4ca2f6d55( activity_instance.interact_scriptable.origin, activity_instance.playerparticipants, 40, "sat_ob_objectivemarker_storymissionmain" );
    activity_instance waittill( #"hvt_confirmed" );
    ob_story_mission_utils::objective_marker_clear( activity_instance.var_dc21504e32f2eda6, activity_instance.playerparticipants );
}

/#

    // Namespace cancer_confront
    // Params 0
    // Checksum 0x9161a06b, Offset: 0x7eb0
    // Size: 0x5, Type: dev
    function function_ebe88782cc2865e4()
    {
        
    }

#/

// Namespace cancer_confront
// Params 1
// Checksum 0xbad8149b, Offset: 0x7ebd
// Size: 0x96
function function_455e8fb262f93e43( scriptable_radio_tower )
{
    activity_instance = self;
    radio_marker = activity_instance namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_objectivemarker_storymissionmain", 1, 1 );
    v_forward = anglestoforward( scriptable_radio_tower.angles );
    marker_origin = scriptable_radio_tower.origin + v_forward * 30 + ( 0, 0, 60 );
    objidpoolmanager::objective_set_play_intro( radio_marker, 0 );
    objidpoolmanager::objective_set_play_outro( radio_marker, 0 );
    objidpoolmanager::update_objective_position( radio_marker, marker_origin );
    return radio_marker;
}

// Namespace cancer_confront
// Params 4
// Checksum 0x8a15b92a, Offset: 0x7f5c
// Size: 0xbd
function function_5fc29e832e1dc539( entity, squad, z_offset, obj_marker_bundle )
{
    activity_instance = self;
    
    if ( !isdefined( activity_instance.a_obj_id ) )
    {
        activity_instance.a_obj_id = [];
    }
    
    var_dc21504e32f2eda6 = activity_instance namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_objectivemarker_boss" );
    activity_instance.a_obj_id[ activity_instance.a_obj_id.size ] = var_dc21504e32f2eda6;
    objidpoolmanager::objective_set_play_intro( var_dc21504e32f2eda6, 0 );
    objidpoolmanager::objective_set_play_outro( var_dc21504e32f2eda6, 0 );
    objidpoolmanager::update_objective_onentity( var_dc21504e32f2eda6, entity );
    objidpoolmanager::update_objective_setzoffset( var_dc21504e32f2eda6, z_offset );
    ob_story_mission_utils::objective_marker_show( var_dc21504e32f2eda6, squad );
    function_2b8e3d3ae2a6414a( var_dc21504e32f2eda6, 0 );
    return var_dc21504e32f2eda6;
}

// Namespace cancer_confront
// Params 4
// Checksum 0xc085751f, Offset: 0x8022
// Size: 0xca
function function_4c3e50b4ca2f6d55( obj_marker_pos, squad, z_offset, obj_marker_bundle = "sat_ob_objectivemarker_storymissionmain" )
{
    activity_instance = self;
    
    if ( !isdefined( activity_instance.a_obj_id ) )
    {
        activity_instance.a_obj_id = [];
    }
    
    var_dc21504e32f2eda6 = namespace_d7fa4530141146a5::function_de87bf7072515cd3( obj_marker_bundle );
    activity_instance.a_obj_id[ activity_instance.a_obj_id.size ] = var_dc21504e32f2eda6;
    objidpoolmanager::objective_set_play_intro( var_dc21504e32f2eda6, 0 );
    objidpoolmanager::objective_set_play_outro( var_dc21504e32f2eda6, 0 );
    objidpoolmanager::update_objective_position( var_dc21504e32f2eda6, obj_marker_pos + ( 0, 0, z_offset ) );
    objidpoolmanager::objective_playermask_hidefromallplayers( var_dc21504e32f2eda6 );
    ob_story_mission_utils::objective_marker_show( var_dc21504e32f2eda6, squad, 0 );
    function_2b8e3d3ae2a6414a( var_dc21504e32f2eda6, 0 );
    return var_dc21504e32f2eda6;
}

/#

    // Namespace cancer_confront
    // Params 0
    // Checksum 0xb6da1cb9, Offset: 0x80f5
    // Size: 0x5, Type: dev
    function function_6947009142975441()
    {
        
    }

#/

// Namespace cancer_confront
// Params 0
// Checksum 0xc4fce4cc, Offset: 0x8102
// Size: 0x99
function function_c4bb1f257f6bd2ce()
{
    activity_instance = self;
    
    foreach ( player in activity_instance.playerparticipants )
    {
        player setsoundsubmix( "mp_sat_ob_cancer_saferoom_mx_mute" );
        player setsoundsubmix( "mp_sat_ob_cancer_saferoom_occ_mx_mute", 1 );
    }
}

// Namespace cancer_confront
// Params 0
// Checksum 0x67a0fdfc, Offset: 0x81a3
// Size: 0x9b
function function_f5949e380a725462()
{
    activity_instance = self;
    
    foreach ( player in activity_instance.playerparticipants )
    {
        player clearsoundsubmix( "mp_sat_ob_cancer_saferoom_mx_mute", 1 );
        player setsoundsubmix( "mp_sat_ob_cancer_saferoom_occ_mx_mute", 1 );
    }
}

/#

    // Namespace cancer_confront
    // Params 0
    // Checksum 0xeffa8f89, Offset: 0x8246
    // Size: 0x5, Type: dev
    function function_9a0936d2fa27ef7()
    {
        
    }

#/

// Namespace cancer_confront
// Params 2
// Checksum 0x694cb946, Offset: 0x8253
// Size: 0x121
function function_4b3fada1990a8b35( trigger_name, mission_notify )
{
    activity_instance = self;
    activity_instance endon( mission_notify );
    
    if ( isstring( trigger_name ) )
    {
        trigger = getnoentvolumearray( trigger_name, #targetname )[ 0 ];
    }
    else
    {
        trigger = trigger_name;
    }
    
    if ( !trigger )
    {
        assertmsg( "<dev string:x141>" + trigger_name );
        return;
    }
    
    player_arrived = 0;
    
    while ( !player_arrived )
    {
        trigger waittill( #"trigger", ent );
        
        if ( isplayer( ent ) )
        {
            foreach ( player in activity_instance.playerparticipants )
            {
                if ( player == ent )
                {
                    player_arrived = 1;
                    break;
                }
            }
        }
    }
    
    activity_instance notify( mission_notify );
}

// Namespace cancer_confront
// Params 6
// Checksum 0x8e36ad60, Offset: 0x837c
// Size: 0x22b
function function_b95c324c7b2d9f63( origin, radius, staggered_delay = 0.05, var_d8d89c6a1e17cfff, shouldstun = 0, stun_duration = 5 )
{
    activity_instance = self;
    
    foreach ( fake_falkner in activity_instance.fake_falkner.a_spawned_ai )
    {
        if ( isalive( fake_falkner ) )
        {
            fake_falkner dodamage( 1, fake_falkner.origin );
        }
    }
    
    ai_in_radius = getaiarrayinradius( origin, radius, [ "team_hundred_ninety", "team_two_hundred" ] );
    
    if ( isarray( var_d8d89c6a1e17cfff ) )
    {
        foreach ( agent in var_d8d89c6a1e17cfff )
        {
            if ( isai( agent ) && !agent.magic_bullet_shield )
            {
                ai_in_radius = arraycombineunique( ai_in_radius, [ agent ] );
            }
        }
    }
    
    if ( ai_in_radius.size > 0 )
    {
        ai_in_radius = sortbydistance( ai_in_radius, origin );
        
        for ( i = 0; i < ai_in_radius.size ; i++ )
        {
            if ( isdefined( ai_in_radius[ i ] ) )
            {
                agent = ai_in_radius[ i ];
                
                if ( shouldstun )
                {
                    agent zombie_stun::stun_ai( stun_duration + randomfloatrange( 0.5, 1.5 ) );
                }
                else
                {
                    agent.forceannihilate = 1;
                    agent kill();
                }
                
                wait staggered_delay;
            }
        }
    }
}

