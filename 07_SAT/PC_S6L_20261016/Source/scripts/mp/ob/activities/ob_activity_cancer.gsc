// scripts\mp\ob\activities\ob_activity_cancer.gsc  (hash_1d4614daf2e76036.gscc) (size: 78278 Bytes / 0x131c6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1f38fdaf (523828655)
// size ...... 78278 (0x131c6)
// includes .. 30  (offset: 0x11d3e)
// strings ... 293 (offset: 0x11e2e)
// dev strs .. 8   (offset: 0x13162)
// exports ... 185 (offset: 0xca8e)
// cseg ...... 0x272e + 0xa360 (0xca8e)
// imports ... 400 (offset: 0xe776)
// animtree1 . 0   (offset: 0x131c6)
// animtree2 . 0   (offset: 0x131c6)
#using script_3edd59d0d3fc3262;
#using script_636bd827a012af12;
#using scripts\anim\dialogue;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\ai;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\ai_spawn_director_utility;
#using scripts\common\ai\ai_utility;
#using scripts\common\callbacks;
#using scripts\common\chyron;
#using scripts\common\puzzles\connection_puzzle;
#using scripts\common\snd\snd;
#using scripts\common\snd\snd_utility;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\waypoint_objective_handler;
#using scripts\mp\armor;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\coop;
#using scripts\mp\equipment;
#using scripts\mp\gametypes\ob;
#using scripts\mp\interaction;
#using scripts\mp\ob\contracts\ob_contract_ui_widget;
#using scripts\mp\ob\systems\ob_activity_manager;
#using scripts\mp\ob\systems\ob_exfil_trans;
#using scripts\mp\ob\systems\ob_item_select;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\overlord;
#using scripts\mp\snd\snd_ob;

#namespace cancer;

// Namespace cancer
// Params 0, eflags: 0x5
// Checksum 0xe2226e94, Offset: 0x274c
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_7b842898f5abb88d", undefined, &init, undefined );
}

// Namespace cancer
// Params 0
// Checksum 0xeb9c1a9e, Offset: 0x276d
// Size: 0x33
function init()
{
    ob_settings = ob::get_ob_settings();
    
    if ( !ob_settings.var_49178f6e5c220274 )
    {
        thread function_f8b07947b934d579();
        return;
    }
    
    level thread setup();
}

// Namespace cancer
// Params 1
// Checksum 0x722d17e9, Offset: 0x27a8
// Size: 0x144
function function_c871dbbe5173d823( params )
{
    player = self;
    cancer_mission = level.cancer_missions[ player.sessionsquadid ];
    
    if ( !isdefined( cancer_mission ) || cancer_mission.resetting )
    {
        cancer_mission = {};
        cancer_mission.team = player.team;
        cancer_mission.sessionsquadid = player.sessionsquadid;
        level.cancer_missions[ player.sessionsquadid ] = cancer_mission;
        level thread start( cancer_mission );
    }
    
    objective_add_player( cancer_mission, player );
    function_910d23500d2edeac( cancer_mission, player );
    player endon( #"disconnect" );
    
    while ( getbuildversion() != "SHIP" )
    {
        player waittill( #"hash_1b6b9613636daa6a" );
        cancer_mission notify( #"reset" );
        waitframe();
        logstring( "[Cancer] Restarting for squad ", player.sessionsquadid, " since progress was reset for ", player.name );
        
        if ( player == ( squad_utility::getsquadleader( cancer_mission.team, cancer_mission.sessionsquadid ) ?? player ) )
        {
            level thread start( cancer_mission );
        }
    }
}

// Namespace cancer
// Params 1
// Checksum 0xcabe3648, Offset: 0x28f4
// Size: 0x147
function on_player_leave( params )
{
    player = self;
    cancer_mission = level.cancer_missions[ player.sessionsquadid ];
    var_64bb57aa2d6e8b35 = teams::getsquaddata( player.team, player.sessionsquadid );
    player clear_objective_client( player.var_1348ae8d95a313d0 );
    player remove_objective_client( level.var_30e6c9f02fa6bf2c );
    player remove_objective_client( cancer_mission.var_1348ae8d95a313d0, cancer_mission.bookcase_circle );
    
    if ( !isdefined( var_64bb57aa2d6e8b35 ) || var_64bb57aa2d6e8b35.players.size == 0 )
    {
        logstring( "[Cancer] Resetting for squad ", player.sessionsquadid, " since all players left the match." );
        
        if ( cancer_mission )
        {
            cancer_mission notify( #"reset" );
            cancer_mission.resetting = 1;
            clear_all_objectives( cancer_mission );
            
            if ( cancer_mission.step_index == 2 )
            {
                function_8233f91da3a1a43e();
            }
            
            session_id = player.sessionsquadid;
            waitframe();
            
            if ( cancer_mission.resetting )
            {
                level.cancer_missions[ session_id ] = undefined;
            }
        }
    }
}

// Namespace cancer
// Params 1
// Checksum 0x7fee26df, Offset: 0x2a43
// Size: 0x9f
function start( cancer_mission )
{
    cancer_mission endon( #"reset" );
    level utility::flag_wait( "flag_cancer_setup_complete" );
    clear_all_objectives( cancer_mission );
    logstring( "Cancer started for squad: " + cancer_mission.sessionsquadid );
    childthread function_1206da2d7cde55d6( cancer_mission );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    var_64bb57aa2d6e8b35 utility::ent_flag_wait( "squad_play_begin" );
    childthread intro( cancer_mission );
    childthread confront( cancer_mission );
    childthread outro( cancer_mission );
}

// Namespace cancer
// Params 1
// Checksum 0xbe5074a1, Offset: 0x2aea
// Size: 0x266
function intro( cancer_mission )
{
    cancer_mission endon( #"reset" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    cancer_mission story_contract_util::function_800aae15896dfec6( var_64bb57aa2d6e8b35.players, #"cancer_intro" );
    cancer_mission.is_active = 1;
    cancer_mission.step_index = 0;
    cancer_mission notify( #"hash_94cce38bfd23e76c" );
    var_64bb57aa2d6e8b35 thread cancer_music( cancer_mission );
    level thread function_cddb50034003950e( cancer_mission );
    
    foreach ( abilitycase in level.var_cfc7b4f833215f35 )
    {
        ob_item_select::function_923ddf97f6cdbee( abilitycase, var_64bb57aa2d6e8b35.players );
    }
    
    level thread function_5532d53cd7c7e1e();
    var_64bb57aa2d6e8b35 coop::play_cinematic( "sat_cancer_flyover", { #countdown:0, #fadeendnone:1, #fadestartnone:1, #timeout:21, #players:var_64bb57aa2d6e8b35.players } );
    var_64bb57aa2d6e8b35 coop::play_cinematic( "sat_cancer_load", { #countdown:0, #fadestartnone:1, #timeout:33, #players:var_64bb57aa2d6e8b35.players } );
    cancer_mission notify( #"cancer_intro_bink_complete" );
    level utility::flag_set( "cancer_spawn_resort_guards" );
    var_64bb57aa2d6e8b35.players[ 0 ] thread namespace_78b1c18caf50ee83::function_a6d314bf326b0e52( "cancer_intro" );
    cancer_mission thread function_61662a38bc9a6ef8();
    cancer_mission thread function_33cc9bc0687d7103();
    cancer_mission thread function_6fe5aa19daafbc5c();
    level thread function_24937c38eca312d6( cancer_mission );
    cancer_mission thread function_fde859de4858f491( var_64bb57aa2d6e8b35.players, "hint_displacer_field", &"sat_ob/hint_displacer_field_gamepad", &"sat_ob/hint_displacer_field_kbm", 8 );
    cancer_mission waittill( #"notify_cancer_penthouse_saferoom_entered" );
    story_contract_util::mark_complete( var_64bb57aa2d6e8b35.players, #"cancer_intro" );
}

// Namespace cancer
// Params 2, eflags: 0x4
// Checksum 0xd8af6265, Offset: 0x2d58
// Size: 0x8a
function private function_e2d81aff8efd0dd9( state, squad )
{
    switch ( state )
    {
        case #"hash_1c39674e5b0de0f3":
            snd_ob::squad_music( squad, "mx_avalon_restricted_area_b_lp" );
            break;
        case #"hash_9e02cd4a0f3ca981":
            snd_ob::squad_music_with_boost( squad, "mx_avalon_restricted_combat_b_lp", 2, 72, 2, 8, 32 );
            break;
        case #"hash_3015d6b4c9f55525":
        case #"hash_7b6614415d1b2e48":
        default:
            break;
    }
}

// Namespace cancer
// Params 1, eflags: 0x4
// Checksum 0x53bf00ae, Offset: 0x2dea
// Size: 0xbc
function private function_e6a89b1246b14995( squad )
{
    assert( snd::issquad( squad ) );
    
    while ( true )
    {
        wingsuit_count = 0;
        
        foreach ( player in squad.players )
        {
            if ( player iswingsuitdeployed() )
            {
                wingsuit_count += 1;
            }
        }
        
        if ( wingsuit_count == 0 )
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace cancer
// Params 1
// Checksum 0xe2b68e6b, Offset: 0x2eae
// Size: 0x317
function cancer_music( cancer_mission )
{
    level endon( #"game_ended" );
    self notify( #"hash_89a7d04b767c4897" );
    self endon( #"hash_89a7d04b767c4897" );
    cancer_mission endon( #"reset" );
    squad = self;
    assert( snd::issquad( squad ) );
    assert( isplayer( squad.players[ 0 ] ) );
    var_950c5eed6692bff6 = story_contract_util::function_35a4b91d1599df3e( squad.players[ 0 ] );
    
    if ( !arraycontains( [ "cancer_intro", "cancer_confront", "cancer_outro" ], var_950c5eed6692bff6.ddl_bit ) )
    {
        return;
    }
    
    waittillframeend();
    assert( isplayer( squad.players[ 0 ] ) );
    var_950c5eed6692bff6 = story_contract_util::function_35a4b91d1599df3e( squad.players[ 0 ] );
    assert( isstruct( var_950c5eed6692bff6 ) && isstring( var_950c5eed6692bff6.ddl_bit ) );
    
    switch ( var_950c5eed6692bff6.ddl_bit )
    {
        case #"hash_aebb739b7e169f48":
        default:
            story_contract_util::function_800aae15896dfec6( squad.players, #"cancer_intro" );
            level utility::flag_wait( "ob_infil_completed" );
            cancer_mission waittill( #"cancer_intro_bink_complete" );
            snd_ob::squad_combat_state( squad, &function_e2d81aff8efd0dd9, 0, 3.33333 );
            cancer_mission waittill( #"notify_cancer_resort_approached" );
            cancer_mission waittill( #"notify_cancer_lobby_entered" );
            cancer_mission waittill( #"notify_cancer_elevator_shaft_entered" );
            cancer_mission waittill( #"notify_cancer_penthouse_entered" );
            snd_ob::squad_combat_state_stop( squad );
            snd_ob::squad_music_stop( squad );
            break;
        case #"hash_f5dd9ea6baf15895":
            story_contract_util::function_800aae15896dfec6( squad.players, #"cancer_confront" );
            cancer_mission waittill( #"hash_8dfc963adcf4bf" );
            snd_ob::squad_music( squad, "mx_aries_fresh_hell_lp" );
            wait 16;
            snd_ob::squad_music_stop( squad );
            cancer_mission waittill( #"hash_426247e792ae6db7" );
            snd_ob::squad_music_with_boost( squad, "mx_avalon_contract_accept_c", 3, 120, 0, 12, 8 );
            cancer_mission waittill( #"music_hvt_spawned" );
            wait 4.8;
            snd_ob::squad_music_with_boost( squad, "mx_avalon_combat_e_lp", 3, 155, 14, 28, 56 );
            cancer_mission waittill( #"hash_c9d94531e9824938" );
            snd_ob::squad_music_stop( squad );
            cancer_mission waittill( #"hash_77a5c5df855b8aab" );
            break;
        case #"hash_27e185242c731efd":
            story_contract_util::function_800aae15896dfec6( squad.players, #"cancer_outro" );
            snd_ob::squad_music_with_boost( squad, "mx_gemini_incoming_lp", 4, 116, 4, 16, 48 );
            function_e6a89b1246b14995( squad );
            cancer_mission waittill( #"notify_cancer_skyscraper_sanctum_reached" );
            wait 3;
            snd_ob::squad_music_stop( squad );
            cancer_mission waittill( #"hash_59db8a35650dc4" );
            break;
    }
}

// Namespace cancer
// Params 1
// Checksum 0x4a8e3b03, Offset: 0x31cd
// Size: 0x154
function confront( cancer_mission )
{
    cancer_mission endon( #"reset" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    cancer_mission story_contract_util::function_800aae15896dfec6( var_64bb57aa2d6e8b35.players, #"cancer_confront" );
    cancer_mission.is_active = 1;
    cancer_mission.step_index = 1;
    cancer_mission notify( #"hash_94cce38bfd23e76c" );
    function_b10ce1ca3b3c42ab();
    var_64bb57aa2d6e8b35 thread cancer_music( cancer_mission );
    
    while ( !level.cancer_confront_starter )
    {
        waitframe();
    }
    
    cancer_mission utility::waittill_notify_or_timeout( "notify_cancer_enable_computer_interact", 30 );
    level.cancer_confront_starter setscriptablepartstate( "nexus_activity_joiner_phone", "visible" );
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        level.cancer_confront_starter enablescriptableplayeruse( player );
    }
}

// Namespace cancer
// Params 1
// Checksum 0x9362bf63, Offset: 0x3329
// Size: 0x405
function outro( cancer_mission )
{
    cancer_mission endon( #"reset" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    cancer_mission story_contract_util::function_800aae15896dfec6( var_64bb57aa2d6e8b35.players, #"cancer_outro" );
    thread function_ba5de45a742651a4( 1 );
    thread function_32493132174c387d( 1 );
    thread function_629a1fcdca83a336( 1 );
    thread function_fe8a217a216aa549( 1 );
    thread function_ef17e3aaa2a3c254( 1 );
    thread function_d4fcc1eecd0a48f4( 1 );
    thread function_b15a1a19f750abd5( 1 );
    thread function_5f33f32b562a4dbe( 1 );
    thread function_cfd6c319693e822e( 1 );
    level thread function_5532d53cd7c7e1e();
    level thread function_b10ce1ca3b3c42ab();
    respawn_structs = utility::getstructarray( "cancer_skyscraper_respawn_point", "targetname" );
    var_64bb57aa2d6e8b35 story_contract_util::set_squad_respawn( respawn_structs, 0.66 );
    cancer_mission.is_active = 1;
    cancer_mission.step_index = 2;
    cancer_mission notify( #"hash_94cce38bfd23e76c" );
    var_64bb57aa2d6e8b35 thread cancer_music( cancer_mission );
    teleport_structs = utility::getstructarray( "cancer_post_confront_teleport", "targetname" );
    
    if ( !teleport_structs )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    teleport_structs = utility::getstructarray( "cancer_post_confront_teleport", "targetname" );
    coop::teleport_struct_prepare( var_64bb57aa2d6e8b35, teleport_structs );
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        coop::teleport_struct_teleport( var_64bb57aa2d6e8b35, player );
    }
    
    waitframe();
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        forward = anglestoforward( player.angles );
        player setvelocity( forward * 800 );
        player skydive_beginfreefall();
        player skydive_setdeploymentstatus( 1 );
        player skydive_deployparachute();
    }
    
    level thread function_dd2132f1499c3a68( cancer_mission );
    level thread function_a45de09128efe060( cancer_mission );
    cancer_mission thread function_e21b276e97639607();
    cancer_mission thread function_c21e560d945e8a0c();
    cancer_mission thread function_250269d940d7a6d3();
    level utility::flag_set( "flag_cancer_skyscrapper_spawn_enemies" );
    cancer_mission waittill( #"hash_59db8a35650dc4" );
    story_contract_util::mark_complete( var_64bb57aa2d6e8b35.players, #"cancer_outro" );
    story_contract_util::achievement_activities( var_64bb57aa2d6e8b35.players, "sat_wc_mission8and9", [ #"cancer_outro", #"gemini_complete" ] );
    party_leader = var_64bb57aa2d6e8b35.players[ 0 ];
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        if ( player isfireteamleader() )
        {
            party_leader = player;
            break;
        }
    }
    
    cancer_mission notify( #"hash_dba872feb5950e79" );
    function_8233f91da3a1a43e();
    playlistid = party_leader function_ba1793aee415985f() ? getdvarint( @"hash_a82a427d7c689951", 270 ) : getdvarint( @"hash_e31f787a43f4e011", 272 );
    level ob_exfil_trans::exfiltrans( party_leader, playlistid, "sat_gemini_intro_antechamber" );
}

// Namespace cancer
// Params 0
// Checksum 0x97af456d, Offset: 0x3736
// Size: 0x129
function setup()
{
    if ( getdvarint( @"hash_f04a59c64f211d19", 0 ) )
    {
        return;
    }
    
    if ( level.is_quest_story_mission )
    {
        return;
    }
    
    level.cancer_missions = [];
    level callback::add( #"hash_cc06eb1d45f33a0c", &function_c871dbbe5173d823 );
    level callback::add( #"player_disconnect", &on_player_leave );
    level callback::add( #"player_leave_squad", &on_player_leave );
    utility::flag_wait( "scriptables_ready" );
    function_96f789141c171703();
    function_db15637eb5b72565();
    function_74cf581ac7358b88();
    remove_ambients();
    disable_ascenders();
    function_9c302c61f914a6af();
    hide_cancer_collision();
    thread function_293349321a6b7a44();
    
    if ( !level.cancer_encounter_manager )
    {
        level.cancer_encounter_manager = spawnstruct();
        level.cancer_encounter_manager.active_encounters = [];
        level.cancer_encounter_manager.resetting_encounters = [];
    }
    
    level thread lab_door_setup();
    level thread setup_audio_emitters();
    thread function_339bb5247b45d056();
    level thread function_e6799e9a19df2365();
    level thread function_9e184a05a15fe947();
    level utility::flag_set( "flag_cancer_setup_complete" );
}

// Namespace cancer
// Params 0
// Checksum 0x82735847, Offset: 0x3867
// Size: 0x108
function function_96f789141c171703()
{
    interact_struct = utility::getstruct( "sat_ob_cancer_outro_interact", "targetname" );
    
    if ( interact_struct )
    {
        interact_offset = ( 0, 0, -16 );
        interaction_size = 72;
        teleport_structs = utility::getstructarray( interact_struct.target, "targetname" );
        level.var_71feac8fdd772584 = interaction::register_interact( interact_struct.origin + interact_offset, interaction_size, &outro_on_interact );
        level.var_71feac8fdd772584.teleport_structs = teleport_structs;
        level.var_71feac8fdd772584 interaction::set_interact_hint_callback( &set_outro_interact_hint );
        level.var_71feac8fdd772584 sethintdisplayrange( 200 );
        level.var_71feac8fdd772584 sethintdisplayfov( 360 );
        level.var_71feac8fdd772584 setusefov( 45 );
        level.var_71feac8fdd772584 setuseholdduration( 600 );
        level.var_71feac8fdd772584 disableplayeruseforallplayers();
    }
}

// Namespace cancer
// Params 0
// Checksum 0x85faf0e, Offset: 0x3977
// Size: 0x250
function disable_ascenders()
{
    structs = utility::getstructarray( "cancer_penthouse_ascender", "targetname" );
    
    foreach ( struct in structs )
    {
        scriptables = getentitylessscriptablearray( undefined, undefined, struct.origin, 200 );
        
        foreach ( scriptable in scriptables )
        {
            if ( scriptable.classname == "scriptable_t10_ascender_zipline_01" && scriptable getscriptableparthasstate( "top", "off" ) )
            {
                scriptable setscriptablepartstate( "top", "off" );
            }
        }
    }
    
    scriptables = getentitylessscriptablearray( "cancer_skyscraper_ascender", #script_noteworthy );
    
    foreach ( scriptable in scriptables )
    {
        scriptable setscriptablepartstate( "model", "hidden" );
    }
    
    collision_ents = getentarray( "cancer_skyscraper_ascender_collision", #targetname );
    
    foreach ( ent in collision_ents )
    {
        ent delete();
    }
}

// Namespace cancer
// Params 0
// Checksum 0x95cdd8ee, Offset: 0x3bcf
// Size: 0x119
function function_9c302c61f914a6af()
{
    structs = utility::getstructarray( "CANCER_RESORT_LOBBY_DOOR", "targetname" );
    
    foreach ( struct in structs )
    {
        scriptables = getentitylessscriptablearray( undefined, undefined, struct.origin, 200 );
        
        foreach ( scriptable in scriptables )
        {
            if ( scriptable scriptableisdoor() )
            {
                scriptable scriptabledoorfreeze();
            }
        }
    }
}

// Namespace cancer
// Params 0
// Checksum 0x56c024cb, Offset: 0x3cf0
// Size: 0xbb
function setup_audio_emitters()
{
    level.var_3c860ae2ecac1274 = spawn( "script_origin", ( 0, 0, 0 ) );
    level.var_3c860de2ecac190d = spawn( "script_origin", ( 0, 0, 0 ) );
    var_c987612067cca48c = utility::getstructarray( "penthouse_horror_audio_location_01", "targetname" );
    var_c987642067ccab25 = utility::getstructarray( "penthouse_horror_audio_location_02", "targetname" );
    
    if ( var_c987612067cca48c.size > 0 )
    {
        level thread function_bb3bc91ea7e32d3b( level.var_3c860ae2ecac1274, var_c987612067cca48c );
    }
    
    wait randomfloatrange( 3, 5 );
    
    if ( var_c987642067ccab25.size > 0 )
    {
        level thread function_bb3bc91ea7e32d3b( level.var_3c860de2ecac190d, var_c987642067ccab25 );
    }
}

// Namespace cancer
// Params 0
// Checksum 0xf2994b1e, Offset: 0x3db3
// Size: 0x110
function function_db15637eb5b72565()
{
    level.var_cfc7b4f833215f35 = [];
    crate_struct = utility::getstruct( "cancer_locate_ability_crate", "targetname" );
    
    if ( crate_struct )
    {
        level.cancer_locate_ability_crate = ob_item_select::function_95f9ecc2af4693f6( crate_struct.origin, "super_survival_life_drain", "super_war_machine", #"default", crate_struct.angles );
        ob_item_select::function_1dfd8b3bc8e33dd8( level.cancer_locate_ability_crate );
        level.var_cfc7b4f833215f35[ level.var_cfc7b4f833215f35.size ] = level.cancer_locate_ability_crate;
    }
    
    crate_struct = utility::getstruct( "cancer_outro_ability_crate", "targetname" );
    
    if ( crate_struct )
    {
        level.cancer_outro_ability_crate = ob_item_select::function_95f9ecc2af4693f6( crate_struct.origin, "super_grappling_hook_sm", "super_teleport", #"tactical", crate_struct.angles );
        ob_item_select::function_1dfd8b3bc8e33dd8( level.cancer_outro_ability_crate );
        level.var_cfc7b4f833215f35[ level.var_cfc7b4f833215f35.size ] = level.cancer_outro_ability_crate;
    }
}

// Namespace cancer
// Params 0
// Checksum 0x3c0405e2, Offset: 0x3ecb
// Size: 0xb9
function remove_ambients()
{
    structs = utility::getstructarray( "cancer_objective_location", "targetname" );
    
    foreach ( struct in structs )
    {
        radius = struct.radius ?? 1000;
        function_1c4c7ef874191be2( "cancer_objective_location", struct.origin, radius, 1 );
    }
}

// Namespace cancer
// Params 1
// Checksum 0x1e6dc0e4, Offset: 0x3f8c
// Size: 0xed
function outro_on_interact( player )
{
    interact = self;
    cancer_mission = level.cancer_missions[ player.sessionsquadid ];
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        interact disableplayeruse( player );
    }
    
    if ( isdefined( cancer_mission ) )
    {
        cancer_mission notify( #"hash_59db8a35650dc4" );
    }
    
    level notify( #"hash_59db8a35650dc4" );
}

// Namespace cancer
// Params 2
// Checksum 0x327fa616, Offset: 0x4081
// Size: 0x8e
function set_outro_interact_hint( interact, player )
{
    var_950c5eed6692bff6 = story_contract_util::function_35a4b91d1599df3e( player );
    
    if ( var_950c5eed6692bff6.ddl_bit == "cancer_outro" )
    {
        return { #var_26bbd300351fde34:0, #string:&"sat_ob_activities/cancer_open", #type:"HINT_BUTTON" };
    }
    
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace cancer
// Params 3
// Checksum 0x65cac76b, Offset: 0x4117
// Size: 0x58
function function_64d1ec601ac62333( var_310c26e7749060f2, radius = 1000, player )
{
    requestid = ai_spawn_director::spawn_request( "ai_encounter:enc_cancer_safehouse", var_310c26e7749060f2, radius, 1, 1, 1 );
    ai_spawn_director::function_5a08798970350207( requestid, &function_9b05c38e528168df, player );
}

// Namespace cancer
// Params 2
// Checksum 0x4684403c, Offset: 0x4177
// Size: 0x2a
function function_9b05c38e528168df( requestid, userdata )
{
    while ( !ai_spawn_director::function_16096fa7d6fa6642( requestid, 0, 1 ) )
    {
        wait 1;
    }
}

// Namespace cancer
// Params 0
// Checksum 0x4847d6ee, Offset: 0x41a9
// Size: 0xf
function function_e6799e9a19df2365()
{
    level thread ob_story_mission_utils::function_e6799e9a19df2365( "s_cancer_resort_caches" );
}

// Namespace cancer
// Params 0
// Checksum 0xf038b635, Offset: 0x41c0
// Size: 0x28
function function_74cf581ac7358b88()
{
    thread ob_story_mission_utils::item_spawn_weapon( "s_cancer_penthouse_weapon", "flag_cancer_skyscrapper_spawn_enemies", 1 );
    thread ob_story_mission_utils::item_spawn_equipment( "s_cancer_penthouse_equipment", "flag_cancer_skyscrapper_spawn_enemies", 1 );
}

// Namespace cancer
// Params 1
// Checksum 0x6eb7f0f4, Offset: 0x41f0
// Size: 0xbb
function function_1206da2d7cde55d6( cancer_mission )
{
    cancer_mission waittill( #"hash_94cce38bfd23e76c" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        function_4b2b323f40370860( player );
    }
}

// Namespace cancer
// Params 1
// Checksum 0x967af675, Offset: 0x42b3
// Size: 0x31
function function_4b2b323f40370860( player )
{
    player ob_story_mission_utils::function_3b9c5aa009cba304( "classtable_sat_ob_cancer", 0, 2 );
    player armor::setarmorhealth( player.maxarmorhealth );
}

// Namespace cancer
// Params 5
// Checksum 0xb9989bb4, Offset: 0x42ec
// Size: 0x113
function function_fde859de4858f491( players, toast_hint = "hint_wingsuit_deploy", toast_text = &"sat_ob/bigmap_avalon", var_d0f27fc78fd36d9a, delay = 0 )
{
    wait delay;
    
    foreach ( player in players )
    {
        if ( var_d0f27fc78fd36d9a && !player usinggamepad() )
        {
            player utility::callsharedfunc( #"hint", #"add_simple", toast_hint, var_d0f27fc78fd36d9a, 10 );
            continue;
        }
        
        player utility::callsharedfunc( #"hint", #"add_simple", toast_hint, toast_text, 10 );
    }
}

// Namespace cancer
// Params 0
// Checksum 0xcb59d0fd, Offset: 0x4407
// Size: 0x11a
function lab_door_setup()
{
    if ( !level.var_3e88d7f87549a4be )
    {
        level.var_3e88d7f87549a4be = getentitylessscriptablearray( "sat_ob_cancer_lab_bookshelf", #targetname )[ 0 ];
        
        if ( level.var_3e88d7f87549a4be )
        {
            level.var_2ea72b2277dea2b5 = getent( "sat_ob_cancer_lab_bookshelf_clip", #targetname );
            level.var_3e88d7f87549a4be setscriptablepartstate( "interact", "usable" );
            level.var_3e88d7f87549a4be setscriptablepartstate( "case", "closed" );
            level.var_2ea72b2277dea2b5 connectpaths();
            level.var_2ea72b2277dea2b5 movex( -100, 1 );
            wait 1;
            level.var_2ea72b2277dea2b5 disconnectpaths();
            interaction::register_scriptable_interact( level.var_3e88d7f87549a4be, &lab_door_interact );
            level.var_3e88d7f87549a4be.var_490060d47d9e122a = "cancer";
            function_f0944e129708e75d( level.var_3e88d7f87549a4be.var_490060d47d9e122a );
            level.var_3e88d7f87549a4be thread ob_story_mission_utils::function_e89ed2a08ce38bbf( "cancer_lab_door", level.connection_puzzle_asset );
        }
    }
}

// Namespace cancer
// Params 1
// Checksum 0xa6fdb4b5, Offset: 0x4529
// Size: 0x115
function lab_door_interact( player )
{
    level.var_3e88d7f87549a4be setscriptablepartstate( "interact", "unusable" );
    player thread connection_puzzle::open( level.connection_puzzle_asset, self.var_490060d47d9e122a );
    finished = level utility::waittill_any_return( "ConnectionPuzzleFailed", "ConnectionPuzzleCompleted", "ConnectionPuzzleClosed", "death_or_disconnect" );
    
    if ( finished == "ConnectionPuzzleCompleted" || connection_puzzle::is_instance_complete( level.connection_puzzle_asset, self.var_490060d47d9e122a ) )
    {
        player connection_puzzle::close();
        level.var_2ea72b2277dea2b5 connectpaths();
        level.var_2ea72b2277dea2b5 movex( 100, 1 );
        self setscriptablepartstate( "case", "open" );
        level.var_3e88d7f87549a4be thread ob_story_mission_utils::remove_connection_puzzle_streaming_volume();
        level utility::flag_set( "flag_cancer_saferoom_bookcase_opening" );
        wait 1;
        level utility::flag_set( "flag_cancer_saferoom_bookcase_open" );
        level.var_2ea72b2277dea2b5 disconnectpaths();
        return;
    }
    
    waitframe();
    self setscriptablepartstate( "interact", "usable" );
}

// Namespace cancer
// Params 1
// Checksum 0xae8623b0, Offset: 0x4646
// Size: 0x41
function function_f0944e129708e75d( var_490060d47d9e122a )
{
    asset = hashcat( %"scriptedwidget:", "scripted_widget_connection_puzzle_3side_4player_sat_default" );
    level thread connection_puzzle::init_from_layout( asset, var_490060d47d9e122a, var_490060d47d9e122a );
    level.connection_puzzle_asset = asset;
}

// Namespace cancer
// Params 0
// Checksum 0xd01e5714, Offset: 0x468f
// Size: 0xcb
function reset_lab_door()
{
    if ( level.var_3e88d7f87549a4be getscriptablepartstate( "case" ) == "open" )
    {
        level.var_3e88d7f87549a4be setscriptablepartstate( "interact", "usable" );
        level.var_3e88d7f87549a4be setscriptablepartstate( "case", "closed" );
        level.var_2ea72b2277dea2b5 connectpaths();
        level.var_2ea72b2277dea2b5 movex( -100, 1 );
        wait 1;
        level.var_2ea72b2277dea2b5 disconnectpaths();
        connection_puzzle::reset_layout( level.connection_puzzle_asset, level.var_3e88d7f87549a4be.var_490060d47d9e122a );
        level.var_3e88d7f87549a4be thread ob_story_mission_utils::function_e89ed2a08ce38bbf( "cancer_lab_door", level.connection_puzzle_asset );
        utility::flag_clear( "flag_cancer_saferoom_bookcase_open" );
    }
}

// Namespace cancer
// Params 2
// Checksum 0xb6afa87b, Offset: 0x4762
// Size: 0x629
function set_elevator_door_state( var_6b5e62d83b7f270 = 1, cancer_mission )
{
    var_5a349ab68e4b2fdf = 2;
    
    if ( !isdefined( level.var_564973691d5f1f77 ) )
    {
        level.var_564973691d5f1f77 = 0;
    }
    
    if ( var_6b5e62d83b7f270 == level.var_564973691d5f1f77 )
    {
        return;
    }
    
    e_cancer_sky_ele_a_l = getent( "e_cancer_sky_ele_a_l", #targetname );
    e_cancer_sky_ele_a_r = getent( "e_cancer_sky_ele_a_r", #targetname );
    e_cancer_sky_ele_b_l = getent( "e_cancer_sky_ele_b_l", #targetname );
    e_cancer_sky_ele_b_r = getent( "e_cancer_sky_ele_b_r", #targetname );
    e_cancer_sky_ele_a_col = getent( "e_cancer_sky_ele_a_col", #targetname );
    e_cancer_sky_ele_b_col = getent( "e_cancer_sky_ele_b_col", #targetname );
    e_cancer_sky_ele_clip_a_l = getent( "e_cancer_sky_ele_clip_a_l", #targetname );
    e_cancer_sky_ele_clip_a_r = getent( "e_cancer_sky_ele_clip_a_r", #targetname );
    e_cancer_sky_ele_clip_b_l = getent( "e_cancer_sky_ele_clip_b_l", #targetname );
    e_cancer_sky_ele_clip_b_r = getent( "e_cancer_sky_ele_clip_b_r", #targetname );
    var_ff676ea5b5eb51e5 = getentarray( "e_cancer_sky_ele_mid_l", #targetname );
    var_ff6780a5b5eb797b = getentarray( "e_cancer_sky_ele_mid_r", #targetname );
    var_32ffcd4a2d28503b = getentarray( "e_cancer_sky_ele_mid_col", #targetname );
    var_7a2bcd9a227e2f1 = [ e_cancer_sky_ele_a_l, e_cancer_sky_ele_b_l ];
    var_7a2bcd9a227e2f1 = arraycombine( var_7a2bcd9a227e2f1, var_ff676ea5b5eb51e5 );
    var_7a2c6d9a227f8ef = [ e_cancer_sky_ele_a_r, e_cancer_sky_ele_b_r ];
    var_7a2c6d9a227f8ef = arraycombine( var_7a2c6d9a227f8ef, var_ff6780a5b5eb797b );
    var_64dff157d2b0733c = [ e_cancer_sky_ele_clip_a_l, e_cancer_sky_ele_clip_b_l ];
    var_64dfe757d2b05d3e = [ e_cancer_sky_ele_clip_a_r, e_cancer_sky_ele_clip_b_r ];
    var_b8e7d91015b3f91a = anglestoright( e_cancer_sky_ele_a_l.angles );
    
    foreach ( door in var_7a2c6d9a227f8ef )
    {
        var_4f933cdd84f69d03 = anglestoright( door.angles );
        multiplier = var_6b5e62d83b7f270 ? 40 : -40;
        move_location = door.origin + var_4f933cdd84f69d03 * multiplier;
        door moveto( move_location, var_5a349ab68e4b2fdf, 0.5, 0.5 );
        
        if ( var_6b5e62d83b7f270 )
        {
            playsoundatpos( door.origin + ( 0, 0, 50 ), "evt_cancer_elevator_door_open" );
        }
    }
    
    foreach ( door in var_7a2bcd9a227e2f1 )
    {
        var_4f933cdd84f69d03 = anglestoright( door.angles );
        multiplier = var_6b5e62d83b7f270 ? -40 : 40;
        move_location = door.origin + var_4f933cdd84f69d03 * multiplier;
        door moveto( move_location, var_5a349ab68e4b2fdf, 0.5, 0.5 );
    }
    
    foreach ( col in var_32ffcd4a2d28503b )
    {
        if ( var_6b5e62d83b7f270 )
        {
            col notsolid();
            continue;
        }
        
        col solid();
    }
    
    foreach ( clip in var_64dfe757d2b05d3e )
    {
        multiplier = var_6b5e62d83b7f270 ? 40 : -40;
        clip thread move_elevator_clip( var_b8e7d91015b3f91a, multiplier, var_5a349ab68e4b2fdf );
    }
    
    foreach ( clip in var_64dff157d2b0733c )
    {
        multiplier = var_6b5e62d83b7f270 ? -40 : 40;
        clip thread move_elevator_clip( var_b8e7d91015b3f91a, multiplier, var_5a349ab68e4b2fdf );
    }
    
    var_d9db838faf5d9d46 = var_6b5e62d83b7f270 ? 80 : -80;
    col_b_multiplier = -1 * var_d9db838faf5d9d46;
    var_c44f071ae7a67cfb = e_cancer_sky_ele_a_col.origin + var_b8e7d91015b3f91a * var_d9db838faf5d9d46;
    var_c44f081ae7a67f2e = e_cancer_sky_ele_b_col.origin + var_b8e7d91015b3f91a * col_b_multiplier;
    e_cancer_sky_ele_a_col moveto( var_c44f071ae7a67cfb, 2, 0.5, 0.5 );
    e_cancer_sky_ele_b_col moveto( var_c44f081ae7a67f2e, 2, 0.5, 0.5 );
    level.var_564973691d5f1f77 = var_6b5e62d83b7f270;
    
    if ( var_6b5e62d83b7f270 && cancer_mission )
    {
        var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
        overlord::playconversation( "cancer_skyscraper_terrace_outro_conversation", var_64bb57aa2d6e8b35.players );
    }
}

// Namespace cancer
// Params 3
// Checksum 0x9928ce0d, Offset: 0x4d93
// Size: 0x5a
function move_elevator_clip( var_b8e7d91015b3f91a, multiplier, wait_duration )
{
    self connectpaths();
    move_location = self.origin + var_b8e7d91015b3f91a * multiplier;
    self moveto( move_location, wait_duration, 0.5, 0.5 );
    wait wait_duration;
    self disconnectpaths();
}

// Namespace cancer
// Params 1
// Checksum 0x7c3e039a, Offset: 0x4df5
// Size: 0x128
function function_dd2132f1499c3a68( cancer_mission )
{
    cancer_mission endon( #"reset" );
    var_ad14a62e207ad093 = utility::getstructarray( "cancer_wingsuit_magic_bullet", "targetname" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    shots_fired = 0;
    
    while ( shots_fired < 15 )
    {
        rand_target = utility::array_random( var_64bb57aa2d6e8b35.players );
        target_right = anglestoright( rand_target.origin );
        target_up = anglestoup( rand_target.origin );
        target_location = rand_target.origin + target_right * randomfloatrange( -250, 250 ) + target_up * randomfloatrange( -1200, -900 );
        rand_start = utility::array_random( var_ad14a62e207ad093 );
        magicbullet( "sat_ar_hawk_mp", rand_start.origin, target_location );
        shots_fired++;
        wait randomfloatrange( 0.3, 0.5 );
    }
}

// Namespace cancer
// Params 1
// Checksum 0xdbd7bf2b, Offset: 0x4f25
// Size: 0x164
function function_a45de09128efe060( cancer_mission )
{
    cancer_mission endon( #"reset" );
    rocket_structs = utility::getstructarray( "cancer_wingsuit_magic_rocket", "targetname" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    
    foreach ( rocket_struct in rocket_structs )
    {
        rand_target = utility::array_random( var_64bb57aa2d6e8b35.players );
        target_right = anglestoright( rand_target.origin );
        target_up = anglestoup( rand_target.origin );
        target_location = rand_target.origin + target_right * randomfloatrange( -250, 250 ) + target_up * randomfloatrange( -2000, -1600 );
        magicbullet( "sat_la_fang_mp", rocket_struct.origin, target_location );
        wait randomfloatrange( 1, 1.5 );
    }
}

// Namespace cancer
// Params 1
// Checksum 0xcad2f8d, Offset: 0x5091
// Size: 0x49
function hide_cancer_collision( should_delete )
{
    var_c5c81b268e1c2b87 = getent( "cancer_radio_tower_markup", #targetname );
    
    if ( var_c5c81b268e1c2b87 )
    {
        var_c5c81b268e1c2b87 hide();
        var_c5c81b268e1c2b87 connectpaths();
        
        if ( should_delete )
        {
            var_c5c81b268e1c2b87 delete();
        }
    }
}

// Namespace cancer
// Params 0
// Checksum 0xa687173c, Offset: 0x50e2
// Size: 0x5bd
function function_f8b07947b934d579()
{
    level endon( #"game_ended" );
    e_cancer_sky_ele_a_l = getent( "e_cancer_sky_ele_a_l", #targetname );
    e_cancer_sky_ele_a_r = getent( "e_cancer_sky_ele_a_r", #targetname );
    e_cancer_sky_ele_b_l = getent( "e_cancer_sky_ele_b_l", #targetname );
    e_cancer_sky_ele_b_r = getent( "e_cancer_sky_ele_b_r", #targetname );
    e_cancer_sky_ele_a_col = getent( "e_cancer_sky_ele_a_col", #targetname );
    e_cancer_sky_ele_b_col = getent( "e_cancer_sky_ele_b_col", #targetname );
    e_cancer_sky_ele_clip_a_l = getent( "e_cancer_sky_ele_clip_a_l", #targetname );
    e_cancer_sky_ele_clip_a_r = getent( "e_cancer_sky_ele_clip_a_r", #targetname );
    e_cancer_sky_ele_clip_b_l = getent( "e_cancer_sky_ele_clip_b_l", #targetname );
    e_cancer_sky_ele_clip_b_r = getent( "e_cancer_sky_ele_clip_b_r", #targetname );
    var_ff676ea5b5eb51e5 = getentarray( "e_cancer_sky_ele_mid_l", #targetname );
    var_ff6780a5b5eb797b = getentarray( "e_cancer_sky_ele_mid_r", #targetname );
    var_32ffcd4a2d28503b = getentarray( "e_cancer_sky_ele_mid_col", #targetname );
    elevator_ents = [ e_cancer_sky_ele_a_l, e_cancer_sky_ele_a_r, e_cancer_sky_ele_b_l, e_cancer_sky_ele_b_r, e_cancer_sky_ele_a_col, e_cancer_sky_ele_b_col, e_cancer_sky_ele_clip_a_l, e_cancer_sky_ele_clip_a_r, e_cancer_sky_ele_clip_b_l, e_cancer_sky_ele_clip_b_r ];
    elevator_ents = arraycombine( elevator_ents, var_ff676ea5b5eb51e5, var_ff6780a5b5eb797b, var_32ffcd4a2d28503b );
    
    foreach ( ent in elevator_ents )
    {
        if ( ent )
        {
            ent delete();
        }
    }
    
    e_cancer_sky_stairwell_01 = getent( "e_cancer_sky_stairwell_01", #targetname );
    e_cancer_sky_stairwell_col = getent( "e_cancer_sky_stairwell_col", #targetname );
    stairwell_blockers = [ e_cancer_sky_stairwell_01, e_cancer_sky_stairwell_col ];
    
    foreach ( blocker in stairwell_blockers )
    {
        if ( blocker )
        {
            blocker delete();
        }
    }
    
    hide_cancer_collision( 1 );
    ents = getentarray( "cancer_collision", #targetname );
    
    foreach ( ent in ents )
    {
        ent delete();
    }
    
    ents = getentarray( "cancer_collision", #script_noteworthy );
    
    foreach ( ent in ents )
    {
        ent delete();
    }
    
    volumes = getentarray( "cancer_goal_volume", #targetname );
    
    foreach ( volume in volumes )
    {
        volume delete();
    }
    
    utility::flag_wait( "scriptables_ready" );
    scriptables = getentitylessscriptablearray( "cancer_scriptables", #script_noteworthy );
    
    foreach ( scriptable in scriptables )
    {
        scriptable setscriptablepartstate( "model", "hidden" );
    }
    
    scriptable_ents = getentarray( "cancer_scriptables", #script_noteworthy );
    
    foreach ( scriptable_ent in scriptable_ents )
    {
        scriptable_ent delete();
    }
}

/#

    // Namespace cancer
    // Params 0
    // Checksum 0xcb7eeacd, Offset: 0x56a7
    // Size: 0x5, Type: dev
    function function_6b9d01c283ebe5e7()
    {
        
    }

#/

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0x4e33ba3, Offset: 0x56b4
// Size: 0x59c
function private function_61662a38bc9a6ef8()
{
    cancer_mission = self;
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    var_6a8f96c924ddeccb = getnoentvolumearray( "trig_cancer_resort_locked_entrance", #targetname );
    var_e141dfcc71e84060 = getnoentvolumearray( "trig_cancer_garage_enter", #targetname );
    var_9b1a9ec060d2b6d8 = getnoentvolumearray( "trig_cancer_garage_escalators", #targetname );
    var_7143e049e8fe7277 = getnoentvolumearray( "trig_cancer_lobby_enter", #targetname );
    var_671031fe95d5a16d = getnoentvolumearray( "trig_cancer_elevator_shaft_approach", #targetname );
    var_84000bf670b9aa94 = getnoentvolumearray( "trig_cancer_penthouse_enter", #targetname );
    level thread function_4b3fada1990a8b35( cancer_mission, "trig_cancer_resort_approach", "notify_cancer_resort_approached" );
    
    foreach ( trigger in var_6a8f96c924ddeccb )
    {
        level thread function_4b3fada1990a8b35( cancer_mission, trigger, "notify_cancer_resort_locked_entrance" );
    }
    
    foreach ( trigger in var_e141dfcc71e84060 )
    {
        level thread function_4b3fada1990a8b35( cancer_mission, trigger, "notify_cancer_garage_entered" );
    }
    
    foreach ( trigger in var_9b1a9ec060d2b6d8 )
    {
        level thread function_4b3fada1990a8b35( cancer_mission, trigger, "notify_cancer_garage_escalators_reached" );
    }
    
    foreach ( trigger in var_7143e049e8fe7277 )
    {
        level thread function_4b3fada1990a8b35( cancer_mission, trigger, "notify_cancer_lobby_entered" );
    }
    
    foreach ( trigger in var_671031fe95d5a16d )
    {
        level thread function_4b3fada1990a8b35( cancer_mission, trigger, "notify_cancer_elevator_shaft_approached" );
        
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            player thread function_c27766d3e5ce65b5( cancer_mission, trigger, "notify_cancer_elevator_shaft_approached" );
        }
    }
    
    level thread function_4b3fada1990a8b35( cancer_mission, "trig_cancer_elevator_shaft_enter", "notify_cancer_elevator_shaft_entered" );
    level thread function_4b3fada1990a8b35( cancer_mission, "trig_cancer_elevator_shaft_ascend", "notify_cancer_elevator_shaft_ascent" );
    level thread function_4b3fada1990a8b35( cancer_mission, "trig_cancer_penthouse_doors", "notify_cancer_penthouse_doors" );
    
    foreach ( trigger in var_84000bf670b9aa94 )
    {
        level thread function_4b3fada1990a8b35( cancer_mission, trigger, "notify_cancer_penthouse_entered" );
        
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            player thread function_c27766d3e5ce65b5( cancer_mission, trigger, "notify_cancer_penthouse_entered" );
        }
    }
    
    level thread function_4b3fada1990a8b35( cancer_mission, "trig_cancer_penthouse_bookcase", "notify_cancer_penthouse_bookcase_approached" );
    level thread function_4b3fada1990a8b35( cancer_mission, "trig_cancer_penthouse_saferoom_terminal", "notify_cancer_penthouse_saferoom_entered" );
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        player thread function_c27766d3e5ce65b5( cancer_mission, "trig_cancer_elevator_shaft_ascend", "notify_cancer_elevator_shaft_ascent" );
        player thread function_c27766d3e5ce65b5( cancer_mission, "trig_cancer_penthouse_bookcase", "notify_cancer_penthouse_bookcase_approached" );
        player thread function_c27766d3e5ce65b5( cancer_mission, "trig_cancer_penthouse_saferoom_terminal", "notify_cancer_penthouse_saferoom_entered" );
    }
    
    cancer_mission thread function_dbb611101636eb40();
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0x87b3ce1b, Offset: 0x5c58
// Size: 0x1ef
function private function_dbb611101636eb40()
{
    cancer_mission = self;
    objective_notifies = [ "notify_cancer_resort_approached", "notify_cancer_garage_entered", "notify_cancer_lobby_entered", "notify_cancer_penthouse_entered", "notify_cancer_penthouse_saferoom_entered" ];
    var_2c71c43e8063bfa3 = [ "notify_cancer_resort_approached" ];
    var_915bc5f2f1a3b975 = [ "notify_cancer_resort_locked_entrance", "notify_cancer_garage_entered" ];
    var_6c68298a03491a06 = [ "notify_cancer_garage_escalators_reached", "notify_cancer_lobby_entered" ];
    var_1da8043da522cfc3 = [ "notify_cancer_elevator_shaft_entered", "notify_cancer_elevator_shaft_ascent", "notify_cancer_penthouse_doors", "notify_cancer_penthouse_entered" ];
    sub_notifies = [ var_2c71c43e8063bfa3, var_915bc5f2f1a3b975, var_6c68298a03491a06, var_1da8043da522cfc3 ];
    current_objective_index = -1;
    
    while ( true )
    {
        objective_notify = cancer_mission utility::waittill_any_in_array_return( objective_notifies );
        new_objective_index = function_f02c63b99c9614c9( objective_notifies, objective_notify );
        
        if ( new_objective_index > current_objective_index )
        {
            if ( current_objective_index < 0 )
            {
                current_objective_index = 0;
            }
            
            for ( i = current_objective_index; i < new_objective_index ; i++ )
            {
                foreach ( sub_notify in sub_notifies[ i ] )
                {
                    cancer_mission notify( "cancel_watcher" + sub_notify );
                    
                    if ( i == 2 )
                    {
                        cancer_mission notify( #"hash_8faf577ca2d97574" );
                        level notify( #"hash_f69d932f551d724b" );
                    }
                }
            }
            
            current_objective_index = new_objective_index;
            
            if ( current_objective_index >= objective_notifies.size - 1 )
            {
                return;
            }
        }
    }
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0xab5f70d5, Offset: 0x5e4f
// Size: 0x1c0
function private function_d6efc599c2911bed()
{
    cancer_mission = self;
    cancer_mission endon( #"hash_59db8a35650dc4" );
    objective_notifies = [ "notify_cancer_skyscraper_lobby_reached", "notify_cancer_skyscraper_lobby_elevators_entered", "notify_cancer_skyscraper_terrace_elevators_entered", "notify_cancer_skyscraper_sanctum_reached" ];
    var_686717ddfbcecf67 = [ "notify_cancer_skyscraper_lobby_reached" ];
    var_9aaf6b8eff93a860 = [ "notify_cancer_skyscraper_lobby_elevators_reached", "notify_cancer_skyscraper_lobby_elevators_entered", "notify_cancer_skyscraper_lobby_elevators_ascent" ];
    var_b9e20a60e7503c69 = [ "notify_cancer_skyscraper_terrace_elevators_entered", "notify_cancer_skyscraper_terrace_elevators_ascent" ];
    var_41a5ffde528b15ec = [ "notify_cancer_skyscraper_sanctum_reached" ];
    sub_notifies = [ var_686717ddfbcecf67, var_9aaf6b8eff93a860, var_b9e20a60e7503c69, var_41a5ffde528b15ec ];
    current_objective_index = -1;
    
    while ( true )
    {
        objective_notify = cancer_mission utility::waittill_any_in_array_return( objective_notifies );
        new_objective_index = function_f02c63b99c9614c9( objective_notifies, objective_notify );
        
        if ( new_objective_index > current_objective_index )
        {
            if ( current_objective_index < 0 )
            {
                current_objective_index = 0;
            }
            
            for ( i = current_objective_index; i < new_objective_index ; i++ )
            {
                foreach ( sub_notify in sub_notifies[ i ] )
                {
                    cancer_mission notify( "cancel_watcher" + sub_notify );
                }
            }
            
            current_objective_index = new_objective_index;
            
            if ( current_objective_index >= objective_notifies.size - 1 )
            {
                return;
            }
        }
    }
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0x98d11848, Offset: 0x6017
// Size: 0xee
function private function_e21b276e97639607()
{
    cancer_mission = self;
    cancer_mission endon( #"hash_59db8a35650dc4" );
    cancer_mission thread function_d6efc599c2911bed();
    level thread function_8f027ec67b543dff( cancer_mission, "s_cancer_skyscraper_center", "notify_cancer_skyscraper_approached" );
    level childthread function_4b3fada1990a8b35( cancer_mission, "trig_cancer_skyscraper_lobby", "notify_cancer_skyscraper_lobby_reached" );
    level childthread function_4b3fada1990a8b35( cancer_mission, "trig_cancer_skyscraper_lobby_elevators", "notify_cancer_skyscraper_lobby_elevators_reached" );
    level childthread function_4b3fada1990a8b35( cancer_mission, "trig_cancer_skyscraper_lobby_elevators_entered", "notify_cancer_skyscraper_lobby_elevators_entered" );
    level childthread function_4b3fada1990a8b35( cancer_mission, "trig_cancer_skyscraper_lobby_elevators_ascent", "notify_cancer_skyscraper_lobby_elevators_ascent" );
    level childthread function_4b3fada1990a8b35( cancer_mission, "trig_cancer_skyscraper_terrace", "notify_cancer_skyscraper_terrace_reached", 0 );
    level childthread function_4b3fada1990a8b35( cancer_mission, "trig_cancer_skyscraper_terrace_elevators_entered", "notify_cancer_skyscraper_terrace_elevators_entered" );
    level childthread function_4b3fada1990a8b35( cancer_mission, "trig_cancer_skyscraper_terrace_elevators_ascent", "notify_cancer_skyscraper_terrace_elevators_ascent" );
    level childthread function_4b3fada1990a8b35( cancer_mission, "trig_cancer_skyscraper_roof", "notify_cancer_skyscraper_roof_reached" );
    level childthread function_4b3fada1990a8b35( cancer_mission, "trig_cancer_skyscraper_sanctum", "notify_cancer_skyscraper_sanctum_reached" );
}

/#

    // Namespace cancer
    // Params 0
    // Checksum 0x2daeb99, Offset: 0x610d
    // Size: 0x5, Type: dev
    function function_7dc9e3027f815539()
    {
        
    }

#/

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0x85e3f8d1, Offset: 0x611a
// Size: 0x9a
function private function_6fe5aa19daafbc5c()
{
    cancer_mission = self;
    cancer_mission endon( #"hash_12d5cf384c4e5158" );
    cancer_mission thread function_3832c53d1a4e6418();
    cancer_mission childthread function_6a0200253bae669b();
    cancer_mission childthread function_aa0591fec335d398();
    cancer_mission childthread function_a7674856335697ea();
    cancer_mission childthread function_814b5fb60aed952();
    cancer_mission childthread function_f405e2478b4c7735();
    cancer_mission childthread function_f8a18a3dd8aaf148();
    cancer_mission childthread function_98d786ccd1542575();
    cancer_mission childthread function_d09f1845e67a52ed();
    cancer_mission childthread function_2920bea57f242052();
    cancer_mission childthread function_b16895f409c0ded0();
    cancer_mission childthread function_ec748334803d62c5();
    cancer_mission childthread function_b6f238a4d827f2f();
    cancer_mission childthread function_2534a89fa2c9f203();
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0xa42b0943, Offset: 0x61bc
// Size: 0xe2
function private function_3832c53d1a4e6418()
{
    cancer_mission = self;
    objective_notifies = [ "notify_cancer_garage_entered", "notify_cancer_lobby_entered", "notify_cancer_elevator_shaft_entered", "notify_cancer_elevator_shaft_ascent", "notify_cancer_penthouse_doors", "notify_cancer_penthouse_entered", "notify_cancer_penthouse_bookcase_approached", "notify_cancer_penthouse_saferoom_entered" ];
    current_objective_index = -1;
    
    while ( true )
    {
        objective_notify = cancer_mission utility::waittill_any_in_array_return( objective_notifies );
        new_objective_index = function_f02c63b99c9614c9( objective_notifies, objective_notify );
        
        if ( new_objective_index > current_objective_index )
        {
            if ( current_objective_index < 0 )
            {
                current_objective_index = 0;
            }
            
            for ( i = current_objective_index; i < new_objective_index ; i++ )
            {
                cancer_mission notify( "cancel_vo_watcher" + objective_notifies[ i ] );
            }
            
            current_objective_index = new_objective_index;
            
            if ( current_objective_index >= objective_notifies.size - 1 )
            {
                return;
            }
        }
    }
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0xd8ee42f8, Offset: 0x62a6
// Size: 0x5f
function private function_6a0200253bae669b()
{
    cancer_mission = self;
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    wait 1;
    overlord::playconversation( "cancer_intro_conversation", var_64bb57aa2d6e8b35.players );
    cancer_mission notify( #"notify_cancer_intro_beach_vo_complete" );
}

// Namespace cancer
// Params 1, eflags: 0x4
// Checksum 0x87c44d2f, Offset: 0x630d
// Size: 0x8d
function private function_aa0591fec335d398( squad )
{
    cancer_mission = self;
    cancer_mission endon( #"notify_cancer_resort_approached", "cancel_vo_watcher" + "notify_cancer_garage_entered" );
    level endon( #"notify_cancer_guard_entered_combat" );
    cancer_mission waittill( #"notify_cancer_intro_beach_vo_complete" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    overlord::playconversation( "cancer_intro_banter_conversation", var_64bb57aa2d6e8b35.players, 0.5 );
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0xb5328d92, Offset: 0x63a2
// Size: 0xd0
function private function_a7674856335697ea()
{
    cancer_mission = self;
    cancer_mission endon( "cancel_vo_watcher" + "notify_cancer_garage_entered" );
    level endon( #"notify_cancer_guard_entered_combat" );
    cancer_mission waittill( #"notify_cancer_resort_approached" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    function_7cd194ee5a43a421( var_64bb57aa2d6e8b35.players, 1, "dx_wc_wcan_cfhp_guif_howmanymorecratesdow", "enc_cancer_initial_resort_guards", "3" );
    function_7cd194ee5a43a421( var_64bb57aa2d6e8b35.players, 1.5, "dx_wc_wcan_cfhp_guie_allofthembosswantsth", "enc_cancer_initial_resort_guards", "2" );
    function_7cd194ee5a43a421( var_64bb57aa2d6e8b35.players, 1.5, "dx_wc_wcan_cfhp_guif_cantwaittobedonewith", "enc_cancer_initial_resort_guards", "3" );
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0xcdb04bba, Offset: 0x647a
// Size: 0x12c
function private function_814b5fb60aed952()
{
    cancer_mission = self;
    cancer_mission endon( "cancel_vo_watcher" + "notify_cancer_garage_entered" );
    cancer_mission endon( #"notify_cancer_garage_entered" );
    notify_msg = utility::waittill_any_ents_return( cancer_mission, "notify_cancer_intro_beach_vo_complete", level, "notify_cancer_guard_entered_combat" );
    cancer_mission childthread function_6c1479a84a58d085();
    wait 0.5;
    function_e1ab9f0b70970c1b( "enc_cancer_initial_resort_guards" );
    
    if ( notify_msg == "notify_cancer_intro_beach_vo_complete" )
    {
        level waittill( #"notify_cancer_guard_entered_combat" );
        var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
        overlord::function_e155a19c69aed191( var_64bb57aa2d6e8b35.players );
        wait 0.5;
    }
    
    while ( overlord::function_dce0a14273dfa0a8( var_64bb57aa2d6e8b35.players ) )
    {
        waitframe();
    }
    
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    overlord::playevent( "cancer_skyscraper_engage", var_64bb57aa2d6e8b35.players );
    function_7cd194ee5a43a421( var_64bb57aa2d6e8b35.players, 1, "dx_wc_wcan_cfhp_guia_itsmasonsteamtakeemo", "enc_cancer_initial_resort_guards", "1" );
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0xd78c9ae1, Offset: 0x65ae
// Size: 0x9b
function private function_6c1479a84a58d085()
{
    cancer_mission = self;
    cancer_mission endon( "cancel_vo_watcher" + "notify_cancer_garage_entered" );
    cancer_mission endon( #"hash_8faf577ca2d97574" );
    level waittill( #"NOTIFY_CANCER_RESORT_RETREAT_00" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    function_7cd194ee5a43a421( var_64bb57aa2d6e8b35.players, 1, "dx_wc_wcan_cfhp_gui6_dontletthemin", "enc_cancer_initial_resort_guards", "6" );
    overlord::playevent( "cancer_resort_right_place", var_64bb57aa2d6e8b35.players );
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0x6a30f1f6, Offset: 0x6651
// Size: 0x76
function private function_f405e2478b4c7735()
{
    cancer_mission = self;
    cancer_mission endon( "cancel_vo_watcher" + "notify_cancer_garage_entered" );
    cancer_mission endon( #"notify_cancer_garage_entered" );
    cancer_mission waittill( #"notify_cancer_resort_locked_entrance" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    overlord::playconversation( "cancer_lobby_locked_conversation", var_64bb57aa2d6e8b35.players );
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0xd5ea322a, Offset: 0x66cf
// Size: 0xbc
function private function_f8a18a3dd8aaf148()
{
    cancer_mission = self;
    cancer_mission endon( "cancel_vo_watcher" + "notify_cancer_lobby_entered" );
    level endon( #"NOTIFY_CANCER_RESORT_RETREAT_02" );
    cancer_mission waittill( #"notify_cancer_garage_entered" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    function_7cd194ee5a43a421( var_64bb57aa2d6e8b35.players, 1, "dx_wc_wcan_cfhp_guie_holdthembackkeepthem", "enc_cancer_initial_resort_guards", "2" );
    wait 15;
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    overlord::playevent( "cancer_garage_push_forward", var_64bb57aa2d6e8b35.players );
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0x8db689e7, Offset: 0x6793
// Size: 0xc3
function private function_98d786ccd1542575()
{
    cancer_mission = self;
    cancer_mission endon( "cancel_vo_watcher" + "notify_cancer_lobby_entered" );
    cancer_mission endon( #"notify_cancer_lobby_entered" );
    cancer_mission waittill( #"notify_cancer_garage_entered" );
    level utility::flag_wait( "NOTIFY_CANCER_RESORT_RETREAT_02" );
    cancer_mission childthread function_67ec180f8c7376b4();
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    function_7cd194ee5a43a421( var_64bb57aa2d6e8b35.players, 1.5, "dx_wc_wcan_cfhp_guig_pullbacknow", "enc_cancer_initial_resort_guards", "4" );
    overlord::playconversation( "cancer_garage_retreat_conversation", var_64bb57aa2d6e8b35.players, 2 );
    level notify( #"notify_cancer_garage_retreat_vo_complete" );
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0x8e681df6, Offset: 0x685e
// Size: 0xb5
function private function_67ec180f8c7376b4()
{
    cancer_mission = self;
    cancer_mission endon( "cancel_vo_watcher" + "notify_cancer_lobby_entered" );
    cancer_mission endon( #"notify_cancer_lobby_entered" );
    notify_msg = level utility::waittill_any_return( "NOTIFY_CANCER_RESORT_RETREAT_03", "notify_cancer_garage_bot_damaged", "notify_cancer_garage_retreat_vo_complete" );
    
    if ( notify_msg != "notify_cancer_garage_retreat_vo_complete" )
    {
        level waittill( #"notify_cancer_garage_retreat_vo_complete" );
    }
    else
    {
        level utility::waittill_any( "NOTIFY_CANCER_RESORT_RETREAT_03", "notify_cancer_garage_bot_damaged" );
    }
    
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    overlord::playevent( "cancer_garage_shit_more_robots", var_64bb57aa2d6e8b35.players );
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0x220b160, Offset: 0x691b
// Size: 0xac
function private function_d09f1845e67a52ed()
{
    cancer_mission = self;
    cancer_mission endon( "cancel_vo_watcher" + "notify_cancer_elevator_shaft_entered" );
    cancer_mission endon( #"notify_cancer_elevator_shaft_entered" );
    cancer_mission waittill( #"notify_cancer_lobby_entered" );
    cancer_mission thread function_6e844cff391eb946();
    cancer_mission thread function_bf804054429aca0a();
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    overlord::playconversation( "cancer_lobby_enter_conversation", var_64bb57aa2d6e8b35.players );
    level utility::flag_set( "flag_cancer_resort_elevator_reveal" );
    overlord::playevent( "cancer_lobby_use_elevator", var_64bb57aa2d6e8b35.players );
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0x8aa0cb02, Offset: 0x69cf
// Size: 0xa0
function private function_6e844cff391eb946()
{
    cancer_mission = self;
    cancer_mission endon( "cancel_vo_watcher" + "notify_cancer_skyscraper_lobby_elevators_ascent" );
    cancer_mission endon( #"notify_cancer_skyscraper_lobby_elevators_ascent" );
    cancer_mission waittill( #"notify_cancer_elevator_shaft_approached" );
    level utility::flag_set( "flag_cancer_resort_elevator_reveal" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    
    while ( overlord::function_dce0a14273dfa0a8( var_64bb57aa2d6e8b35.players ) )
    {
        waitframe();
    }
    
    overlord::playconversation( "cancer_lobby_elevator_malfunctioning_conversation", var_64bb57aa2d6e8b35.players, 1 );
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0xbbc8c035, Offset: 0x6a77
// Size: 0x6c
function private function_bf804054429aca0a()
{
    cancer_mission = self;
    cancer_mission endon( "cancel_vo_watcher" + "notify_cancer_penthouse_entered" );
    cancer_mission endon( #"notify_cancer_penthouse_entered" );
    wait 300;
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    overlord::playevent( "cancer_nag_get_to_penthouse", var_64bb57aa2d6e8b35.players );
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0x8a85c9c6, Offset: 0x6aeb
// Size: 0x76
function private function_2920bea57f242052()
{
    cancer_mission = self;
    cancer_mission endon( "cancel_vo_watcher" + "notify_cancer_penthouse_entered" );
    cancer_mission endon( #"notify_cancer_penthouse_entered" );
    cancer_mission waittill( #"notify_cancer_penthouse_doors" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    overlord::playevent( "cancer_shaft_get_doors_open", var_64bb57aa2d6e8b35.players );
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0x1db67153, Offset: 0x6b69
// Size: 0xef
function private function_b16895f409c0ded0()
{
    cancer_mission = self;
    cancer_mission endon( "cancel_vo_watcher" + "notify_cancer_penthouse_bookcase_approached" );
    cancer_mission endon( #"notify_cancer_penthouse_bookcase_approached" );
    cancer_mission waittill( #"notify_cancer_penthouse_entered" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    overlord::playevent( "cancer_penthouse_check_your_corners", var_64bb57aa2d6e8b35.players );
    wait 10;
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    overlord::playconversation( "cancer_penthouse_arrived_conversation", var_64bb57aa2d6e8b35.players );
    wait 15;
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    overlord::playconversation( "cancer_penthouse_search_conversation", var_64bb57aa2d6e8b35.players );
    cancer_mission childthread function_1eff5233e5a0d5f();
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0x813d29c1, Offset: 0x6c60
// Size: 0x6c
function private function_1eff5233e5a0d5f()
{
    cancer_mission = self;
    cancer_mission endon( "cancel_vo_watcher" + "notify_cancer_penthouse_bookcase_approached" );
    cancer_mission endon( #"notify_cancer_penthouse_bookcase_approached" );
    wait 300;
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    overlord::playevent( "cancer_nag_search_penthouse", var_64bb57aa2d6e8b35.players );
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0x808d5a54, Offset: 0x6cd4
// Size: 0x76
function private function_ec748334803d62c5()
{
    cancer_mission = self;
    cancer_mission endon( #"notify_cancer_penthouse_saferoom_entered" );
    cancer_mission waittill( #"notify_cancer_penthouse_bookcase_approached" );
    
    if ( utility::flag( "flag_cancer_saferoom_bookcase_open" ) )
    {
        return;
    }
    
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    overlord::playconversation( "cancer_penthouse_bookcase_conversation", var_64bb57aa2d6e8b35.players );
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0x4a2382ef, Offset: 0x6d52
// Size: 0x85
function private function_b6f238a4d827f2f()
{
    cancer_mission = self;
    cancer_mission endon( #"notify_cancer_penthouse_saferoom_entered" );
    cancer_mission waittill( #"notify_cancer_penthouse_bookcase_approached" );
    
    if ( utility::flag( "flag_cancer_saferoom_bookcase_open" ) )
    {
        return;
    }
    else
    {
        utility::flag_wait( "flag_cancer_saferoom_bookcase_open" );
    }
    
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    overlord::playevent( "cancer_penthouse_saferoom_found_bingo", var_64bb57aa2d6e8b35.players );
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0x4b7a8906, Offset: 0x6ddf
// Size: 0x86
function private function_2534a89fa2c9f203()
{
    cancer_mission = self;
    cancer_mission waittill( #"notify_cancer_penthouse_saferoom_entered" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    overlord::playevent( "cancer_penthouse_saferoom_terminal_found_falkner_lab", var_64bb57aa2d6e8b35.players, 1, undefined, 1 );
    level utility::flag_set( "flag_cancer_penthouse_saferoom_vo_done" );
    overlord::playevent( "cancer_penthouse_saferoom_worth_taking_look", var_64bb57aa2d6e8b35.players );
}

/#

    // Namespace cancer
    // Params 0
    // Checksum 0x65232860, Offset: 0x6e6d
    // Size: 0x5, Type: dev
    function function_1eb3e9b156ca2e4e()
    {
        
    }

#/

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0xd4db0f6d, Offset: 0x6e7a
// Size: 0x7f
function private function_250269d940d7a6d3()
{
    cancer_mission = self;
    cancer_mission endon( #"hash_59db8a35650dc4" );
    cancer_mission thread function_44305d7e3a8e81ab();
    cancer_mission childthread function_6dfa94b62984e459();
    cancer_mission childthread function_e64291c03959e14();
    cancer_mission childthread function_93f93142dc3da2af();
    cancer_mission childthread function_fc2a548e6254c7f3();
    cancer_mission childthread function_c5d42f6cb4c7a553();
    cancer_mission childthread function_1cdeb793268a8c1c();
    cancer_mission childthread function_ec05e44dbe884d3e();
    cancer_mission childthread function_9a7eb409c29e3225();
    cancer_mission childthread function_95917b762bc0a4a8();
    cancer_mission childthread function_899d65c84fddbbc8();
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0x95fe7063, Offset: 0x6f01
// Size: 0xd0
function private function_44305d7e3a8e81ab()
{
    cancer_mission = self;
    objective_notifies = [ "notify_cancer_skyscraper_entrance_enemy_spawn", "notify_cancer_skyscraper_lobby_reached", "notify_cancer_skyscraper_lobby_elevators_reached", "notify_cancer_skyscraper_lobby_elevators_ascent", "notify_cancer_skyscraper_terrace_elevators_ascent", "notify_cancer_skyscraper_sanctum_reached" ];
    current_objective_index = -1;
    
    while ( true )
    {
        objective_notify = cancer_mission utility::waittill_any_in_array_return( objective_notifies );
        new_objective_index = function_f02c63b99c9614c9( objective_notifies, objective_notify );
        
        if ( new_objective_index > current_objective_index )
        {
            if ( current_objective_index < 0 )
            {
                current_objective_index = 0;
            }
            
            for ( i = current_objective_index; i < new_objective_index ; i++ )
            {
                cancer_mission notify( "cancel_vo_watcher" + objective_notifies[ i ] );
            }
            
            current_objective_index = new_objective_index;
            
            if ( current_objective_index >= objective_notifies.size - 1 )
            {
                return;
            }
        }
    }
}

// Namespace cancer
// Params 1, eflags: 0x4
// Checksum 0x2bc01ec3, Offset: 0x6fd9
// Size: 0x64
function private function_6dfa94b62984e459( squad )
{
    cancer_mission = self;
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    overlord::playconversation( "cancer_skyscraper_approach_conversation", var_64bb57aa2d6e8b35.players );
    cancer_mission childthread function_a0c3284b8225dff5( "notify_cancer_skyscraper_lobby_reached" );
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0x1f451c0e, Offset: 0x7045
// Size: 0xfc
function private function_e64291c03959e14()
{
    cancer_mission = self;
    cancer_mission endon( "cancel_vo_watcher" + "notify_cancer_skyscraper_entrance_enemy_spawn" );
    cancer_mission endon( #"notify_cancer_skyscraper_entrance_enemy_spawn" );
    guard_entered_combat = 0;
    skyscraper_approached = 0;
    
    while ( !guard_entered_combat || !skyscraper_approached )
    {
        notify_message = utility::waittill_any_ents_return( level, "notify_cancer_guard_entered_combat", cancer_mission, "notify_cancer_skyscraper_approached" );
        
        if ( notify_message == "notify_cancer_skyscraper_approached" )
        {
            skyscraper_approached = 1;
        }
        else
        {
            guard_entered_combat = 1;
        }
        
        wait 0.5;
    }
    
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    function_7cd194ee5a43a421( var_64bb57aa2d6e8b35.players, 3, "dx_wc_wcan_csta_guia_itsthem", "enc_cancer_skyscrapper_parking_lot_guards", "1" );
    function_7cd194ee5a43a421( var_64bb57aa2d6e8b35.players, 1, "dx_wc_wcan_csta_guig_takeemdown", "enc_cancer_skyscrapper_parking_lot_guards", "4" );
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0xe261063f, Offset: 0x7149
// Size: 0x76
function private function_93f93142dc3da2af()
{
    cancer_mission = self;
    cancer_mission endon( "cancel_vo_watcher" + "notify_cancer_skyscraper_roof_reached" );
    cancer_mission endon( #"notify_cancer_skyscraper_sanctum_reached" );
    cancer_mission waittill( #"notify_cancer_skyscraper_roof_reached" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    overlord::playconversation( "cancer_skyscraper_roof_conversation", var_64bb57aa2d6e8b35.players );
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0xdae4a85c, Offset: 0x71c7
// Size: 0x9e
function private function_fc2a548e6254c7f3()
{
    cancer_mission = self;
    cancer_mission endon( "cancel_vo_watcher" + "notify_cancer_skyscraper_entrance_enemy_spawn" );
    cancer_mission endon( #"notify_cancer_skyscraper_lobby_reached" );
    cancer_mission waittill( #"notify_cancer_skyscraper_entrance_enemy_spawn" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    overlord::playconversation( "cancer_skyscraper_perimeter_reinforcements_conversation", var_64bb57aa2d6e8b35.players, 5 );
    function_7cd194ee5a43a421( var_64bb57aa2d6e8b35.players, 1, "dx_wc_wcan_csta_guie_lockitdowndontletthe", "enc_cancer_skyscraper_parking_lot_entrance", "2" );
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0x112622ea, Offset: 0x726d
// Size: 0xca
function private function_c5d42f6cb4c7a553()
{
    cancer_mission = self;
    cancer_mission endon( "cancel_vo_watcher" + "notify_cancer_skyscraper_lobby_reached" );
    cancer_mission endon( #"notify_cancer_skyscraper_lobby_elevators_reached" );
    cancer_mission waittill( #"notify_cancer_skyscraper_lobby_reached" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    overlord::playevent( "cancer_skyscraper_sanctum_top_floor", var_64bb57aa2d6e8b35.players, undefined, undefined, 1 );
    function_7cd194ee5a43a421( var_64bb57aa2d6e8b35.players, 1, "dx_wc_wcan_csta_guie_cutemdownstopthemher", "enc_cancer_skyscraper_lobby", "2" );
    overlord::playevent( "cancer_skyscraper_more_guild_inbound", var_64bb57aa2d6e8b35.players );
    cancer_mission utility::delay_notify( 10, "notify_cancer_skyscraper_lobby_elevators_reached" );
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0xa8abe24, Offset: 0x733f
// Size: 0xa0
function private function_1cdeb793268a8c1c()
{
    cancer_mission = self;
    cancer_mission endon( "cancel_vo_watcher" + "notify_cancer_skyscraper_lobby_elevators_reached" );
    cancer_mission waittill( #"notify_cancer_skyscraper_lobby_elevators_reached" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    
    if ( !utility::flag( "flag_cancer_skyscraper_holdout_complete" ) )
    {
        overlord::playconversation( "cancer_skyscraper_terrace_intro_conversation", var_64bb57aa2d6e8b35.players );
        cancer_mission notify( #"notify_cancer_outro_holdout_hack_start" );
        level utility::flag_wait( "flag_cancer_skyscraper_holdout_complete" );
        cancer_mission childthread function_a0c3254b8225d95c( "notify_cancer_skyscraper_sanctum_reached" );
    }
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0xf239db16, Offset: 0x73e7
// Size: 0x9e
function private function_ec05e44dbe884d3e()
{
    cancer_mission = self;
    cancer_mission endon( "cancel_vo_watcher" + "notify_cancer_skyscraper_lobby_elevators_ascent" );
    cancer_mission waittill( #"notify_cancer_skyscraper_lobby_elevators_ascent" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    function_7cd194ee5a43a421( var_64bb57aa2d6e8b35.players, 0.5, "dx_wc_wcan_csta_guia_withdrawandhold", "enc_cancer_skyscraper_mid_level_holdout", "1" );
    function_7cd194ee5a43a421( var_64bb57aa2d6e8b35.players, 0.5, "dx_wc_wcan_csta_guia_moving", "enc_cancer_skyscraper_mid_level_holdout", "1" );
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0xdf16833f, Offset: 0x748d
// Size: 0x105
function private function_9a7eb409c29e3225()
{
    cancer_mission = self;
    cancer_mission endon( "cancel_vo_watcher" + "notify_cancer_skyscraper_terrace_reached" );
    cancer_mission endon( #"notify_cancer_skyscraper_sanctum_reached" );
    cancer_mission waittill( #"notify_cancer_skyscraper_terrace_reached" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    function_e1ab9f0b70970c1b( "enc_cancer_skyscraper_mid_level_holdout" );
    waitframe();
    function_7cd194ee5a43a421( var_64bb57aa2d6e8b35.players, 1, "dx_wc_wcan_csta_guia_theyrepushingonus", "enc_cancer_skyscraper_mid_level_holdout", "1" );
    function_7cd194ee5a43a421( var_64bb57aa2d6e8b35.players, 1, "dx_wc_wcan_csta_guif_shitgetback", "enc_cancer_skyscraper_mid_level_holdout", "3" );
    wait 1;
    
    if ( !utility::flag( "flag_cancer_outro_terrace_encounter_cleared" ) )
    {
        overlord::playevent( "cancer_skyscraper_push_through", var_64bb57aa2d6e8b35.players );
    }
    
    level utility::flag_wait( "flag_cancer_outro_terrace_encounter_cleared" );
    overlord::playevent( "cancer_skyscraper_theyre_down", var_64bb57aa2d6e8b35.players );
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0x2511b3a7, Offset: 0x759a
// Size: 0x8a
function private function_95917b762bc0a4a8()
{
    cancer_mission = self;
    cancer_mission endon( "cancel_vo_watcher" + "notify_cancer_skyscraper_terrace_elevators_ascent" );
    cancer_mission waittill( #"notify_cancer_skyscraper_terrace_elevators_ascent" );
    
    while ( !level.cancer_encounter_manager.sanctum_guard )
    {
        waitframe();
    }
    
    level.cancer_encounter_manager.sanctum_guard dialogue::say_self( "dx_wc_wcan_csta_guif_whatdoyoumeantheyrei" );
    level.cancer_encounter_manager.sanctum_guard dialogue::say_self_delayed( 0.5, "dx_wc_wcan_csta_guif_idontcarewhatyouseal" );
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0xb2d732fc, Offset: 0x762c
// Size: 0xbc
function private function_899d65c84fddbbc8()
{
    cancer_mission = self;
    cancer_mission waittill( #"notify_cancer_skyscraper_sanctum_reached" );
    level utility::waittill_notify_or_timeout( "notify_cancer_guard_entered_combat", 3 );
    level.cancer_encounter_manager.sanctum_guard dialogue::stop_dialogue();
    level.cancer_encounter_manager.sanctum_guard dialogue::say_self_delayed( 0.5, "dx_wc_wcan_csta_guig_theyrehere" );
    level utility::flag_wait( "flag_cancer_outro_boardroom_encounter_cleared" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    overlord::playconversation( "cancer_skyscraper_sanctum_conversation", var_64bb57aa2d6e8b35.players, 1.5 );
}

// Namespace cancer
// Params 1, eflags: 0x4
// Checksum 0xee7265f, Offset: 0x76f0
// Size: 0x6b
function private function_a0c3284b8225dff5( notify_endon )
{
    cancer_mission = self;
    cancer_mission endon( "cancel_vo_watcher" + notify_endon );
    cancer_mission endon( notify_endon );
    wait 300;
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    overlord::playevent( "cancer_nag_find_sanctum", var_64bb57aa2d6e8b35.players );
}

// Namespace cancer
// Params 1, eflags: 0x4
// Checksum 0x5438e47d, Offset: 0x7763
// Size: 0x6b
function private function_a0c3254b8225d95c( notify_endon )
{
    cancer_mission = self;
    cancer_mission endon( "cancel_vo_watcher" + notify_endon );
    cancer_mission endon( notify_endon );
    wait 300;
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    overlord::playevent( "cancer_nag_get_to_sanctum", var_64bb57aa2d6e8b35.players );
}

/#

    // Namespace cancer
    // Params 0
    // Checksum 0x56d69bad, Offset: 0x77d6
    // Size: 0x5, Type: dev
    function function_4a004f7afd34648e()
    {
        
    }

#/

// Namespace cancer
// Params 5
// Checksum 0x3f40dcaa, Offset: 0x77e3
// Size: 0xc9
function function_7cd194ee5a43a421( squad, var_222727ae51abda5a, vo_alias, enc_name, var_ecab00da5a323542 )
{
    wait var_222727ae51abda5a;
    count = 0;
    
    while ( count < 5 )
    {
        guild_soldier_closest = function_7bce28700ba989da( squad, enc_name );
        
        if ( guild_soldier_closest && isalive( guild_soldier_closest ) )
        {
            guild_soldier_closest endon( #"death" );
            guild_soldier_closest.battlechatterallowed = 0;
            guild_soldier_closest dialogue::say_self( vo_alias, 0 );
            
            if ( var_ecab00da5a323542 )
            {
                guild_soldier_closest.battlechatter.npcid = var_ecab00da5a323542;
            }
            
            guild_soldier_closest.battlechatterallowed = 1;
            break;
        }
        
        count++;
        wait 0.1;
    }
}

// Namespace cancer
// Params 1
// Checksum 0xaea018a, Offset: 0x78b4
// Size: 0xba
function function_e1ab9f0b70970c1b( encounter_targetname )
{
    requestid = ai_spawn_director::lookup_spawn_request( encounter_targetname );
    requestdata = function_9b649316adcccbaa( requestid );
    
    if ( isdefined( requestdata ) )
    {
        foreach ( ai in requestdata.ai )
        {
            if ( ai dialogue::is_speaking() )
            {
                ai dialogue::stop_dialogue();
            }
        }
    }
}

/#

    // Namespace cancer
    // Params 0
    // Checksum 0x7cccac6e, Offset: 0x7976
    // Size: 0x5, Type: dev
    function function_7931afb046853863()
    {
        
    }

#/

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0xf91c3eb, Offset: 0x7983
// Size: 0x175
function private function_29e51afa00ecdd1b()
{
    cancer_mission = self;
    objective_notifies = [ "notify_cancer_garage_entered", "notify_cancer_lobby_entered", "notify_cancer_penthouse_entered", "notify_cancer_penthouse_bookcase_approached", "notify_cancer_penthouse_saferoom_entered" ];
    current_objective_index = -1;
    breadcrumbs_cleared = 0;
    
    while ( true )
    {
        objective_notify = cancer_mission utility::waittill_any_in_array_return( objective_notifies );
        new_objective_index = function_f02c63b99c9614c9( objective_notifies, objective_notify );
        
        if ( new_objective_index > current_objective_index )
        {
            if ( current_objective_index < 0 )
            {
                current_objective_index = 0;
            }
            
            for ( i = current_objective_index; i < new_objective_index ; i++ )
            {
                cancer_mission notify( "cancel_objective_watcher" + objective_notifies[ i ] );
            }
            
            current_objective_index = new_objective_index;
            var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
            cancer_mission thread function_20d85e440957d181( objective_notify, var_64bb57aa2d6e8b35.players );
            
            if ( current_objective_index >= 1 && !breadcrumbs_cleared )
            {
                var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
                cancer_mission thread waypoint_objective_handler::waypoint_objective_handler_cancel( "cancer_intro_waypoint_lobby", { #squad:cancer_mission.sessionsquadid, #team:cancer_mission.team } );
                breadcrumbs_cleared = 1;
            }
            
            if ( current_objective_index >= objective_notifies.size - 1 )
            {
                return;
            }
        }
    }
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0x3d48855e, Offset: 0x7b00
// Size: 0xc7
function private function_44541415e621a155()
{
    player = self;
    objective_notifies = [ "notify_cancer_penthouse_entered", "notify_cancer_penthouse_bookcase_approached", "notify_cancer_penthouse_saferoom_entered" ];
    current_objective_index = -1;
    breadcrumbs_cleared = 0;
    
    while ( true )
    {
        objective_notify = player utility::waittill_any_in_array_return( objective_notifies );
        new_objective_index = function_f02c63b99c9614c9( objective_notifies, objective_notify );
        
        if ( new_objective_index > current_objective_index )
        {
            if ( current_objective_index < 0 )
            {
                current_objective_index = 0;
            }
            
            for ( i = current_objective_index; i < new_objective_index ; i++ )
            {
                player notify( "cancel_objective_watcher" + objective_notifies[ i ] );
            }
            
            current_objective_index = new_objective_index;
            player thread function_beaef0d23f0f13d8( objective_notify );
            
            if ( current_objective_index >= objective_notifies.size )
            {
                return;
            }
        }
    }
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0xbbea62c, Offset: 0x7bcf
// Size: 0x1eb
function private function_33cc9bc0687d7103()
{
    cancer_mission = self;
    cancer_mission endon( #"hash_12d5cf384c4e5158" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    var_1646669c40467190 = utility::getstruct( "sat_ob_cancer_confront_start_marker", "targetname" );
    
    if ( var_1646669c40467190 )
    {
        level.var_30e6c9f02fa6bf2c = create_objective_marker( var_1646669c40467190.origin, var_64bb57aa2d6e8b35.players, undefined, "sat_ob_objectivemarker_storymissionmain" );
    }
    
    namespace_b451b5202140ccde::function_bb923ce693c606f9( %"hash_540becff28dc440e", var_64bb57aa2d6e8b35.players, { #difficulty:3, #state:1 } );
    cancer_mission.mission_ui = { #difficulty:3, #state:1, #name:%"hash_540becff28dc440e" };
    cancer_mission childthread ob_story_mission_utils::function_56960723e6738b6c( undefined, "cancer_intro_waypoint_lobby", "sat_ob_objectivemarker_location", "notify_cancer_lobby_entered", undefined, { #squad:cancer_mission.sessionsquadid, #team:cancer_mission.team }, 0, 0, 64, 1, 1, undefined, undefined, ( 0, 0, 16 ) );
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        cancer_mission childthread function_6bc8d20f1ef0dc55( player );
    }
    
    cancer_mission childthread function_ee6da15ce5abd443();
    cancer_mission childthread function_99ebe9abaaaf9760();
    cancer_mission childthread function_9bb4556162f76a21();
    cancer_mission childthread function_29e51afa00ecdd1b();
}

// Namespace cancer
// Params 1, eflags: 0x4
// Checksum 0xe8bff3d6, Offset: 0x7dc2
// Size: 0x36
function private function_6bc8d20f1ef0dc55( player )
{
    cancer_mission = self;
    player thread function_25fd26e33e4608f9( cancer_mission );
    player thread function_9907b8f61eb43fe( cancer_mission );
    player thread function_44541415e621a155();
}

// Namespace cancer
// Params 1, eflags: 0x4
// Checksum 0xd53e8c3b, Offset: 0x7e00
// Size: 0xae
function private function_beaef0d23f0f13d8( mission_notify )
{
    player = self;
    
    switch ( mission_notify )
    {
        case #"hash_8ba4f6295fad9731":
            namespace_b451b5202140ccde::function_16223345ffbb5859( %"hash_72bb3c7d9a0ec4ff", [ player ] );
            break;
        case #"hash_75a554be97929545":
            if ( !utility::flag( "flag_cancer_saferoom_bookcase_open" ) )
            {
                namespace_b451b5202140ccde::function_16223345ffbb5859( %"hash_6e22c3669e004af5", [ player ] );
                level utility::flag_wait( "flag_cancer_saferoom_bookcase_open" );
            }
        case #"hash_2ce2559ddfd78eb8":
            namespace_b451b5202140ccde::function_16223345ffbb5859( %"hash_7e8e22c6486bac0c", [ player ] );
            break;
    }
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0xf24c2dc6, Offset: 0x7eb6
// Size: 0x6b
function private function_ee6da15ce5abd443()
{
    cancer_mission = self;
    cancer_mission endon( "cancel_objective_watcher" + "notify_cancer_lobby_entered" );
    cancer_mission waittill( #"notify_cancer_lobby_entered" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    cancer_mission thread waypoint_objective_handler::waypoint_objective_handler_cancel( "cancer_intro_waypoint_lobby", var_64bb57aa2d6e8b35.players );
}

// Namespace cancer
// Params 1, eflags: 0x4
// Checksum 0x744f37dc, Offset: 0x7f29
// Size: 0xac
function private function_25fd26e33e4608f9( cancer_mission )
{
    player = self;
    player endon( #"disconnect" );
    player endon( "cancel_objective_watcher" + "notify_cancer_penthouse_entered" );
    player endon( #"notify_cancer_penthouse_entered" );
    level utility::flag_wait( "flag_cancer_resort_elevator_reveal" );
    var_1646669c40467190 = utility::getstruct( "cancer_breadcrumb_elevator_shaft", "targetname" );
    player.var_1348ae8d95a313d0 = create_objective_marker( var_1646669c40467190.origin, [ player ], 120 );
    player thread add_objective_client( player.var_1348ae8d95a313d0 );
    player childthread function_1a6408cf636c3174();
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0xc076c067, Offset: 0x7fdd
// Size: 0x85
function private function_1a6408cf636c3174()
{
    player = self;
    player waittill( #"notify_cancer_elevator_shaft_ascent" );
    clear_objective_client( player.var_1348ae8d95a313d0 );
    var_1646669c40467190 = utility::getstruct( "cancer_intro_waypoint_penthouse", "targetname" );
    player.var_1348ae8d95a313d0 = create_objective_marker( var_1646669c40467190.origin, [ player ], undefined, "sat_ob_objectivemarker_storymissionmain" );
    add_objective_client( player.var_1348ae8d95a313d0 );
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0x36291638, Offset: 0x806a
// Size: 0x199
function private function_99ebe9abaaaf9760()
{
    cancer_mission = self;
    cancer_mission endon( "cancel_objective_watcher" + "notify_cancer_penthouse_entered" );
    cancer_mission waittill( #"notify_cancer_penthouse_entered" );
    cancer_mission.var_66ba198d514b0772 = 1;
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    waypoint_struct = utility::getstruct( "sat_ob_cancer_penthouse_marker", "targetname" );
    
    if ( level.var_3e88d7f87549a4be )
    {
        circle_origin = level.var_3e88d7f87549a4be.origin;
    }
    else
    {
        circle_origin = waypoint_struct.origin;
    }
    
    cancer_mission.bookcase_circle = ob_story_mission_utils::function_ab06e28322870f4( circle_origin, 2000, var_64bb57aa2d6e8b35.players );
    level thread function_df1fb95e56c9f336( cancer_mission, cancer_mission.bookcase_circle, circle_origin );
    add_objective( cancer_mission, undefined, cancer_mission.bookcase_circle );
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        cancer_mission.bookcase_circle hidefromplayer( player );
    }
    
    cancer_mission thread function_b83e6faf34c6d2c8();
    cancer_mission notify( #"notify_cancer_penthouse_obj_setup_complete" );
}

// Namespace cancer
// Params 1, eflags: 0x4
// Checksum 0x85ba9b3, Offset: 0x820b
// Size: 0x92
function private function_9907b8f61eb43fe( cancer_mission )
{
    player = self;
    player endon( #"disconnect" );
    player endon( "cancel_objective_watcher" + "notify_cancer_penthouse_entered" );
    player waittill( #"notify_cancer_penthouse_entered" );
    clear_objective_client( player.var_1348ae8d95a313d0 );
    cancer_mission utility::waittill_notify_or_timeout( "notify_cancer_penthouse_obj_setup_complete", 1 );
    
    if ( cancer_mission.bookcase_circle )
    {
        cancer_mission.bookcase_circle showtoplayer( player );
    }
    
    player thread function_83aa79d85a25f327( cancer_mission );
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0x926fa530, Offset: 0x82a5
// Size: 0x5f
function private function_9bb4556162f76a21()
{
    cancer_mission = self;
    cancer_mission endon( "cancel_objective_watcher" + "notify_cancer_penthouse_bookcase_approached" );
    cancer_mission utility::waittill_any( "notify_cancer_penthouse_bookcase_approached", "notify_cancer_penthouse_bookcase_pity_timeout" );
    
    if ( cancer_mission.bookcase_circle )
    {
        clear_objective( cancer_mission, undefined, cancer_mission.bookcase_circle );
        cancer_mission.bookcase_circle = undefined;
    }
}

// Namespace cancer
// Params 1, eflags: 0x4
// Checksum 0x550095c7, Offset: 0x830c
// Size: 0x180
function private function_83aa79d85a25f327( cancer_mission )
{
    player = self;
    player endon( #"disconnect" );
    
    if ( cancer_mission.bookcase_circle )
    {
        notify_msg = cancer_mission utility::waittill_any_return( "notify_cancer_penthouse_bookcase_approached", "notify_cancer_penthouse_bookcase_pity_timeout" );
        var_19e3098851f4a2cb = 0;
        
        if ( notify_msg == "notify_cancer_penthouse_bookcase_pity_timeout" )
        {
            var_19e3098851f4a2cb = 1;
        }
    }
    
    if ( !utility::flag( "flag_cancer_saferoom_bookcase_open" ) )
    {
        player.var_1348ae8d95a313d0 = create_objective_marker( level.var_3e88d7f87549a4be.origin, [ player ], 75, "sat_ob_objectivemarker_storymissionmain", var_19e3098851f4a2cb );
        add_objective_client( player.var_1348ae8d95a313d0 );
        level utility::flag_wait( "flag_cancer_saferoom_bookcase_open" );
        clear_objective_client( player.var_1348ae8d95a313d0 );
    }
    
    var_1646669c40467190 = utility::getstruct( "cancer_breadcrumb_office", "targetname" );
    player.var_1348ae8d95a313d0 = create_objective_marker( var_1646669c40467190.origin, [ player ], 40 );
    add_objective_client( player.var_1348ae8d95a313d0 );
    player waittill( #"notify_cancer_penthouse_saferoom_entered" );
    clear_objective_client( player.var_1348ae8d95a313d0 );
    level utility::flag_wait_or_timeout( "flag_cancer_penthouse_saferoom_vo_done", 8 );
    cancer_mission notify( #"notify_cancer_enable_computer_interact" );
    add_objective_client( level.var_30e6c9f02fa6bf2c );
}

/#

    // Namespace cancer
    // Params 0
    // Checksum 0xb8ca1f15, Offset: 0x8494
    // Size: 0x5, Type: dev
    function function_74c874a4877ddf46()
    {
        
    }

#/

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0x3d84cce5, Offset: 0x84a1
// Size: 0x15a
function private function_f19be56bda383508()
{
    cancer_mission = self;
    objective_notifies = [ "notify_cancer_skyscraper_approached", "notify_cancer_skyscraper_lobby_reached", "notify_cancer_outro_holdout_hack_start", "notify_cancer_skyscraper_holdout_complete", "notify_cancer_skyscraper_lobby_elevators_entered", "notify_cancer_skyscraper_terrace_reached", "notify_cancer_skyscraper_terrace_elevators_entered", "notify_cancer_skyscraper_sanctum_reached" ];
    current_objective_index = -1;
    
    while ( true )
    {
        objective_notify = cancer_mission utility::waittill_any_in_array_return( objective_notifies );
        
        if ( objective_notify == "notify_cancer_skyscraper_terrace_reached" && !utility::flag( "flag_cancer_skyscraper_holdout_complete" ) )
        {
            continue;
        }
        
        new_objective_index = function_f02c63b99c9614c9( objective_notifies, objective_notify );
        
        if ( new_objective_index > current_objective_index )
        {
            if ( current_objective_index < 0 )
            {
                current_objective_index = 0;
            }
            
            for ( i = current_objective_index; i < new_objective_index ; i++ )
            {
                cancer_mission notify( "cancel_objective_watcher" + objective_notifies[ i ] );
            }
            
            current_objective_index = new_objective_index;
            var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
            cancer_mission thread function_20d85e440957d181( objective_notify, var_64bb57aa2d6e8b35.players );
            
            if ( current_objective_index >= 4 )
            {
                set_elevator_door_state( 1, cancer_mission );
                utility::flag_set( "flag_cancer_skyscraper_holdout_complete" );
            }
            
            if ( current_objective_index >= objective_notifies.size - 1 )
            {
                return;
            }
        }
    }
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0x5a5ce967, Offset: 0x8603
// Size: 0xdf
function private function_c21e560d945e8a0c()
{
    cancer_mission = self;
    cancer_mission endon( #"hash_59db8a35650dc4" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    cancer_mission thread function_f19be56bda383508();
    namespace_b451b5202140ccde::function_bb923ce693c606f9( %"hash_2b2db6084d32ee11", var_64bb57aa2d6e8b35.players, { #difficulty:3, #state:1 } );
    cancer_mission.mission_ui = { #difficulty:3, #state:1, #name:%"hash_2b2db6084d32ee11" };
    cancer_mission childthread function_aa939723fecb26ed();
    cancer_mission childthread function_f1d249812e5c8c8();
    cancer_mission childthread function_5d27350c55439f27();
    cancer_mission thread function_c1dbef6004296557();
    cancer_mission childthread function_ac35be921ba7f926();
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0x118ab46d, Offset: 0x86ea
// Size: 0x112
function private function_aa939723fecb26ed()
{
    cancer_mission = self;
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        level.var_71feac8fdd772584 enableplayeruse( player );
    }
    
    var_1646669c40467190 = utility::getstruct( "sat_ob_cancer_skyscraper_skyscraper_marker", "targetname" );
    cancer_mission.var_1348ae8d95a313d0 = create_objective_marker( var_1646669c40467190.origin, var_64bb57aa2d6e8b35.players, 250, "sat_ob_objectivemarker_storymissionmain" );
    add_objective( cancer_mission, cancer_mission.var_1348ae8d95a313d0 );
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0x7e0cc15b, Offset: 0x8804
// Size: 0xcc
function private function_f1d249812e5c8c8()
{
    cancer_mission = self;
    cancer_mission endon( "cancel_objective_watcher" + "notify_cancer_skyscraper_approached" );
    cancer_mission waittill( #"notify_cancer_skyscraper_approached" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    
    if ( cancer_mission.var_1348ae8d95a313d0 )
    {
        clear_objective( cancer_mission, cancer_mission.var_1348ae8d95a313d0 );
    }
    
    var_1646669c40467190 = utility::getstruct( "sat_ob_cancer_skyscraper_lobby_marker", "targetname" );
    cancer_mission.var_1348ae8d95a313d0 = create_objective_marker( var_1646669c40467190.origin, var_64bb57aa2d6e8b35.players, 75 );
    add_objective( cancer_mission, cancer_mission.var_1348ae8d95a313d0 );
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0xacdbc4d4, Offset: 0x88d8
// Size: 0xff
function private function_5d27350c55439f27()
{
    cancer_mission = self;
    cancer_mission endon( "cancel_objective_watcher" + "notify_cancer_skyscraper_lobby_elevators_entered" );
    cancer_mission waittill( #"notify_cancer_skyscraper_lobby_reached" );
    
    if ( !utility::flag( "flag_cancer_skyscraper_holdout_complete" ) )
    {
        cancer_mission childthread function_1938dab65ed06a57();
        level utility::flag_wait( "flag_cancer_skyscraper_holdout_complete" );
    }
    
    cancer_mission waittill( #"notify_cancer_skyscraper_lobby_elevators_entered" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    
    if ( cancer_mission.var_1348ae8d95a313d0 )
    {
        clear_objective( cancer_mission, cancer_mission.var_1348ae8d95a313d0 );
    }
    
    var_1646669c40467190 = utility::getstruct( "sat_ob_cancer_skyscraper_terrace_marker", "targetname" );
    cancer_mission.var_1348ae8d95a313d0 = create_objective_marker( var_1646669c40467190.origin, var_64bb57aa2d6e8b35.players, 75 );
    add_objective( cancer_mission, cancer_mission.var_1348ae8d95a313d0 );
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0x71de2f5e, Offset: 0x89df
// Size: 0x15f
function private function_1938dab65ed06a57()
{
    cancer_mission = self;
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    
    if ( cancer_mission.var_1348ae8d95a313d0 )
    {
        clear_objective( cancer_mission, cancer_mission.var_1348ae8d95a313d0 );
    }
    
    var_1646669c40467190 = utility::getstruct( "sat_ob_cancer_skyscraper_holdout_marker", "targetname" );
    cancer_mission.var_1348ae8d95a313d0 = create_objective_marker( var_1646669c40467190.origin, var_64bb57aa2d6e8b35.players, 75 );
    add_objective( cancer_mission, cancer_mission.var_1348ae8d95a313d0 );
    cancer_mission waittill( #"notify_cancer_outro_holdout_hack_start" );
    level utility::flag_wait_or_timeout( "flag_cancer_skyscraper_holdout_titan_dead", 45 );
    wait 3.5;
    level thread set_elevator_door_state( 1, cancer_mission );
    clear_objective( cancer_mission, cancer_mission.var_1348ae8d95a313d0 );
    var_1646669c40467190 = utility::getstruct( "sat_ob_cancer_skyscraper_lobby_elevators_marker", "targetname" );
    cancer_mission.var_1348ae8d95a313d0 = create_objective_marker( var_1646669c40467190.origin, var_64bb57aa2d6e8b35.players, 75 );
    add_objective( cancer_mission, cancer_mission.var_1348ae8d95a313d0 );
    cancer_mission notify( #"notify_cancer_skyscraper_holdout_complete" );
    level utility::flag_set( "flag_cancer_skyscraper_holdout_complete" );
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0xb2183a78, Offset: 0x8b46
// Size: 0xe5
function private function_ac35be921ba7f926()
{
    cancer_mission = self;
    cancer_mission endon( "cancel_objective_watcher" + "notify_cancer_skyscraper_terrace_reached" );
    level utility::flag_wait( "flag_cancer_skyscraper_holdout_complete" );
    cancer_mission waittill( #"notify_cancer_skyscraper_terrace_reached" );
    level notify( #"hash_beea93fe5d82a483" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    
    if ( cancer_mission.var_1348ae8d95a313d0 )
    {
        clear_objective( cancer_mission, cancer_mission.var_1348ae8d95a313d0 );
    }
    
    var_1646669c40467190 = utility::getstruct( "sat_ob_cancer_skyscraper_terrace_elevators_marker", "targetname" );
    cancer_mission.var_1348ae8d95a313d0 = create_objective_marker( var_1646669c40467190.origin, var_64bb57aa2d6e8b35.players, 75 );
    add_objective( cancer_mission, cancer_mission.var_1348ae8d95a313d0 );
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0x6f235cce, Offset: 0x8c33
// Size: 0x115
function private function_c1dbef6004296557()
{
    cancer_mission = self;
    cancer_mission endon( "cancel_objective_watcher" + "notify_cancer_skyscraper_sanctum_reached" );
    cancer_mission utility::waittill_any( "notify_cancer_skyscraper_terrace_elevators_entered", "notify_cancer_skyscraper_sanctum_reached" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    
    if ( cancer_mission.var_1348ae8d95a313d0 )
    {
        clear_objective( cancer_mission, cancer_mission.var_1348ae8d95a313d0 );
    }
    
    var_1646669c40467190 = utility::getstruct( "sat_ob_cancer_outro_interact", "targetname" );
    cancer_mission.var_1348ae8d95a313d0 = create_objective_marker( var_1646669c40467190.origin, var_64bb57aa2d6e8b35.players, undefined, "sat_ob_objectivemarker_storymissionmain" );
    add_objective( cancer_mission, cancer_mission.var_1348ae8d95a313d0 );
    cancer_mission waittill( #"hash_59db8a35650dc4" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    clear_objective( cancer_mission, cancer_mission.var_1348ae8d95a313d0 );
}

/#

    // Namespace cancer
    // Params 0
    // Checksum 0xe9370ce1, Offset: 0x8d50
    // Size: 0x5, Type: dev
    function function_ebe88782cc2865e4()
    {
        
    }

#/

// Namespace cancer
// Params 2, eflags: 0xc
// Checksum 0x737f70f9, Offset: 0x8d5d
// Size: 0x254
function private function_20d85e440957d181( mission_notify, squad )
{
    self notify( #"hash_432b72063826d815" );
    self endon( #"hash_432b72063826d815" );
    cancer_mission = self;
    
    switch ( mission_notify )
    {
        case #"hash_2fd0a36685f1d83":
            namespace_b451b5202140ccde::function_16223345ffbb5859( %"hash_2eafa40ccd804409", squad );
            cancer_mission.mission_ui = { #difficulty:3, #state:2, #name:%"hash_2eafa40ccd804409" };
            break;
        case #"hash_e757b13eca675de2":
            namespace_b451b5202140ccde::function_16223345ffbb5859( %"hash_2d15161cbee6ddfc", squad );
            cancer_mission.mission_ui = { #difficulty:3, #state:2, #name:%"hash_2d15161cbee6ddfc" };
            break;
        case #"hash_c734acb82ff902b1":
            namespace_b451b5202140ccde::function_16223345ffbb5859( %"hash_7f658a35f67cfb36", squad );
            cancer_mission.mission_ui = { #difficulty:3, #state:2, #name:%"hash_7f658a35f67cfb36" };
            break;
        case #"hash_b5f5291a579f1c74":
            namespace_b451b5202140ccde::function_16223345ffbb5859( %"hash_3f35a14d25fc643e", squad );
            cancer_mission.mission_ui = { #difficulty:3, #state:2, #name:%"hash_bb40b528b5b6f52" };
            break;
        case #"hash_d26a05735bb8343":
        case #"hash_30bdbe99f6763067":
            namespace_b451b5202140ccde::function_16223345ffbb5859( %"hash_7f658a35f67cfb36", squad );
            cancer_mission.mission_ui = { #difficulty:3, #state:2, #name:%"hash_7f658a35f67cfb36" };
            break;
        case #"hash_7ee1bd798ef1e55a":
            namespace_b451b5202140ccde::function_16223345ffbb5859( %"hash_7a178675e8f1442b", squad );
            cancer_mission.mission_ui = { #difficulty:3, #state:2, #name:%"hash_7a178675e8f1442b" };
            break;
    }
}

// Namespace cancer
// Params 5
// Checksum 0xfbe506be, Offset: 0x8fb9
// Size: 0x67
function create_objective_marker( origin, squad, marker_z_offset, marker_asset = "sat_ob_objectivemarker_location", b_intro_outro = 0 )
{
    objectivemarkerid = level ob_story_mission_utils::function_b9cb179f9577f32a( origin, marker_z_offset, squad, marker_asset, b_intro_outro );
    objective_removeallfrommask( objectivemarkerid );
    return objectivemarkerid;
}

// Namespace cancer
// Params 3
// Checksum 0x5a88c46c, Offset: 0x9029
// Size: 0x1c5
function add_objective( cancer_mission, var_1348ae8d95a313d0, obj_circle )
{
    if ( !isdefined( cancer_mission.objective_marker_ids ) )
    {
        cancer_mission.objective_marker_ids = [];
    }
    
    if ( !isdefined( cancer_mission.a_obj_circle ) )
    {
        cancer_mission.a_obj_circle = [];
    }
    
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    
    if ( var_1348ae8d95a313d0 )
    {
        logstring( "[Cancer] Adding an objective marker: " + var_1348ae8d95a313d0 );
        
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            objidpoolmanager::objective_playermask_addshowplayer( var_1348ae8d95a313d0, player );
        }
        
        function_2b8e3d3ae2a6414a( var_1348ae8d95a313d0, 0 );
        cancer_mission.objective_marker_ids[ cancer_mission.objective_marker_ids.size ] = var_1348ae8d95a313d0;
    }
    
    if ( obj_circle )
    {
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            obj_circle showtoplayer( player );
        }
        
        logstring( "[Cancer] Adding an objective circle" );
        cancer_mission.a_obj_circle[ cancer_mission.a_obj_circle.size ] = obj_circle;
    }
}

// Namespace cancer
// Params 2
// Checksum 0x9cb06cec, Offset: 0x91f6
// Size: 0xc9
function add_objective_client( var_1348ae8d95a313d0, obj_circle )
{
    player = self;
    
    if ( !isdefined( player.objective_marker_ids ) )
    {
        player.objective_marker_ids = [];
    }
    
    if ( !isdefined( player.a_obj_circle ) )
    {
        player.a_obj_circle = [];
    }
    
    if ( var_1348ae8d95a313d0 )
    {
        logstring( "[Cancer] Adding an objective marker: " + var_1348ae8d95a313d0 );
        objidpoolmanager::objective_playermask_addshowplayer( var_1348ae8d95a313d0, player );
        function_2b8e3d3ae2a6414a( var_1348ae8d95a313d0, 0 );
        player.objective_marker_ids[ player.objective_marker_ids.size ] = var_1348ae8d95a313d0;
    }
    
    if ( obj_circle )
    {
        logstring( "[Cancer] Adding an objective circle" );
        obj_circle showtoplayer( player );
        player.a_obj_circle[ player.a_obj_circle.size ] = obj_circle;
    }
}

// Namespace cancer
// Params 3
// Checksum 0xbee4f3cc, Offset: 0x92c7
// Size: 0x19b
function remove_objective( cancer_mission, var_1348ae8d95a313d0, obj_circle )
{
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    
    if ( var_1348ae8d95a313d0 && cancer_mission.objective_marker_ids )
    {
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            objidpoolmanager::objective_playermask_hidefrom( var_1348ae8d95a313d0, player );
        }
        
        function_2b8e3d3ae2a6414a( var_1348ae8d95a313d0, 1 );
        cancer_mission.objective_marker_ids = arrayremove( cancer_mission.objective_marker_ids, var_1348ae8d95a313d0 );
    }
    
    if ( obj_circle && cancer_mission.a_obj_circle )
    {
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            obj_circle hidefromplayer( player );
        }
        
        cancer_mission.a_obj_circle = arrayremove( cancer_mission.a_obj_circle, obj_circle );
    }
}

// Namespace cancer
// Params 2
// Checksum 0x9742fbef, Offset: 0x946a
// Size: 0x9f
function remove_objective_client( var_1348ae8d95a313d0, obj_circle )
{
    player = self;
    
    if ( var_1348ae8d95a313d0 && player.objective_marker_ids )
    {
        objidpoolmanager::objective_playermask_hidefrom( var_1348ae8d95a313d0, player );
        function_2b8e3d3ae2a6414a( var_1348ae8d95a313d0, 1 );
        player.objective_marker_ids = arrayremove( player.objective_marker_ids, var_1348ae8d95a313d0 );
    }
    
    if ( obj_circle && player.a_obj_circle )
    {
        obj_circle hidefromplayer( player );
        player.a_obj_circle = arrayremove( player.a_obj_circle, obj_circle );
    }
}

// Namespace cancer
// Params 3
// Checksum 0x90ee783, Offset: 0x9511
// Size: 0x41
function clear_objective( cancer_mission, var_1348ae8d95a313d0, obj_circle )
{
    remove_objective( cancer_mission, var_1348ae8d95a313d0, obj_circle );
    
    if ( var_1348ae8d95a313d0 )
    {
        objective_delete( var_1348ae8d95a313d0 );
    }
    
    if ( obj_circle )
    {
        obj_circle delete();
    }
}

// Namespace cancer
// Params 2
// Checksum 0x95d38f6c, Offset: 0x955a
// Size: 0x44
function clear_objective_client( var_1348ae8d95a313d0, obj_circle )
{
    player = self;
    remove_objective_client( var_1348ae8d95a313d0, obj_circle );
    
    if ( var_1348ae8d95a313d0 )
    {
        objective_delete( var_1348ae8d95a313d0 );
    }
    
    if ( obj_circle )
    {
        obj_circle delete();
    }
}

// Namespace cancer
// Params 1
// Checksum 0x93d81ca4, Offset: 0x95a6
// Size: 0x116
function clear_all_objectives( cancer_mission )
{
    foreach ( var_1348ae8d95a313d0 in cancer_mission.objective_marker_ids )
    {
        objective_delete( var_1348ae8d95a313d0 );
    }
    
    foreach ( obj_circle in cancer_mission.a_obj_circle )
    {
        obj_circle delete();
    }
    
    cancer_mission.objective_marker_ids = [];
    cancer_mission.a_obj_circle = [];
}

// Namespace cancer
// Params 2
// Checksum 0xf96d441c, Offset: 0x96c4
// Size: 0x1a3
function objective_add_player( cancer_mission, player )
{
    foreach ( var_1348ae8d95a313d0 in cancer_mission.objective_marker_ids )
    {
        objidpoolmanager::objective_playermask_addshowplayer( var_1348ae8d95a313d0, player );
    }
    
    foreach ( obj_circle in cancer_mission.a_obj_circle )
    {
        obj_circle showtoplayer( player );
    }
    
    if ( cancer_mission.mission_ui )
    {
        namespace_b451b5202140ccde::function_bb923ce693c606f9( cancer_mission.mission_ui.name, [ player ], { #difficulty:cancer_mission.mission_ui.difficulty, #state:cancer_mission.mission_ui.state } );
        
        if ( cancer_mission.mission_ui.name == %"hash_540becff28dc440e" )
        {
            cancer_mission thread function_6bc8d20f1ef0dc55( player );
        }
    }
}

// Namespace cancer
// Params 2
// Checksum 0xdf63b85e, Offset: 0x986f
// Size: 0x16f
function function_910d23500d2edeac( cancer_mission, player )
{
    if ( cancer_mission.is_active )
    {
        function_4b2b323f40370860( player );
        
        foreach ( abilitycase in level.var_cfc7b4f833215f35 )
        {
            ob_item_select::function_923ddf97f6cdbee( abilitycase, [ player ] );
        }
        
        player function_95c8146c48e8b44f( cancer_mission );
    }
    else
    {
        foreach ( abilitycase in level.var_cfc7b4f833215f35 )
        {
            ob_item_select::function_a499824164a33b4f( abilitycase, [ player ] );
        }
    }
    
    if ( level.var_30e6c9f02fa6bf2c )
    {
        objidpoolmanager::objective_playermask_hidefrom( level.var_30e6c9f02fa6bf2c, player );
    }
    
    while ( !isdefined( level.cancer_confront_starter ) )
    {
        waitframe();
    }
    
    level.cancer_confront_starter disablescriptableplayeruse( player );
}

// Namespace cancer
// Params 4, eflags: 0x4
// Checksum 0x2110a6b0, Offset: 0x99e6
// Size: 0x16a
function private function_df1fb95e56c9f336( cancer_mission, obj_circle, target_origin, var_a489514894de55fa )
{
    cancer_mission endon( #"reset" );
    
    if ( var_a489514894de55fa )
    {
        cancer_mission endon( var_a489514894de55fa );
    }
    
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    radius = obj_circle.origin[ 2 ];
    current_layer = 0;
    
    while ( obj_circle )
    {
        search_radius = radius * radius / 3;
        
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            if ( distancesquared( target_origin, player.origin ) <= search_radius )
            {
                radius /= 2;
                circle_spawn_point = target_origin + vectornormalize( utility::function_9e0df7b136ab833c() ) * radius / 2;
                obj_circle.origin = ( circle_spawn_point[ 0 ], circle_spawn_point[ 1 ], radius );
                current_layer++;
            }
        }
        
        waitframe();
    }
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0x789fcc01, Offset: 0x9b58
// Size: 0xde
function private function_b83e6faf34c6d2c8()
{
    cancer_mission = self;
    cancer_mission endon( "cancel_objective_watcher" + "notify_cancer_penthouse_bookcase_approached" );
    cancer_mission endon( #"notify_cancer_penthouse_bookcase_approached" );
    wait 90;
    cancer_mission notify( #"notify_cancer_penthouse_bookcase_pity_timeout" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        player notify( #"notify_cancer_penthouse_bookcase_pity_timeout" );
    }
}

/#

    // Namespace cancer
    // Params 0
    // Checksum 0x97ac2303, Offset: 0x9c3e
    // Size: 0x5, Type: dev
    function function_9a0936d2fa27ef7()
    {
        
    }

#/

// Namespace cancer
// Params 4
// Checksum 0xb20a75c1, Offset: 0x9c4b
// Size: 0x16f
function function_4b3fada1990a8b35( cancer_mission, trigger_name, mission_notify, var_bb9a9864b211302a = 1 )
{
    cancer_mission endon( #"reset" );
    cancer_mission endon( #"hash_dba872feb5950e79" );
    cancer_mission endon( "cancel_watcher" + mission_notify );
    
    if ( var_bb9a9864b211302a )
    {
        cancer_mission endon( mission_notify );
    }
    
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
        return;
    }
    
    player_arrived = 0;
    
    while ( !player_arrived )
    {
        trigger waittill( #"trigger", ent );
        
        if ( isplayer( ent ) )
        {
            var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
            
            foreach ( player in var_64bb57aa2d6e8b35.players )
            {
                if ( player == ent )
                {
                    player_arrived = var_bb9a9864b211302a;
                    cancer_mission notify( mission_notify );
                }
            }
        }
    }
}

// Namespace cancer
// Params 3
// Checksum 0x3d4eeafd, Offset: 0x9dc2
// Size: 0xbb
function function_c27766d3e5ce65b5( cancer_mission, trigger_name, mission_notify )
{
    cancer_mission endon( #"reset" );
    cancer_mission endon( #"hash_dba872feb5950e79" );
    player = self;
    player endon( mission_notify );
    
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
        return;
    }
    
    player_arrived = 0;
    
    while ( !player_arrived )
    {
        trigger waittill( #"trigger", ent );
        
        if ( player == ent )
        {
            player_arrived = 1;
            break;
        }
    }
    
    player notify( mission_notify );
}

// Namespace cancer
// Params 3
// Checksum 0xaca91aa8, Offset: 0x9e85
// Size: 0xbd
function function_29ce94ac71862940( trigger_name, level_notify, is_flag = 0 )
{
    level endon( level_notify );
    level endon( #"hash_f69d932f551d724b" );
    
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
        return;
    }
    
    player_arrived = 0;
    
    while ( !player_arrived )
    {
        trigger waittill( #"trigger", ent );
        
        if ( isplayer( ent ) )
        {
            player_arrived = 1;
            break;
        }
    }
    
    if ( is_flag )
    {
        utility::flag_set( level_notify );
        return;
    }
    
    level notify( level_notify );
}

// Namespace cancer
// Params 4
// Checksum 0xb8f44ea2, Offset: 0x9f4a
// Size: 0x16f
function function_8f027ec67b543dff( cancer_mission, var_e1ae3a7d876c13ca, mission_notify, min_dist )
{
    cancer_mission endon( #"reset", mission_notify );
    struct = utility::getstruct( var_e1ae3a7d876c13ca, "targetname" );
    
    if ( !struct || !struct.radius )
    {
        return;
    }
    
    if ( !isdefined( min_dist ) )
    {
        min_dist = struct.radius;
    }
    
    min_dist_squared = squared( min_dist );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    player_arrived = 0;
    
    while ( !player_arrived )
    {
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            f_dist_squared = distance2dsquared( struct.origin, player.origin );
            
            if ( f_dist_squared < min_dist_squared )
            {
                player_arrived = 1;
                break;
            }
        }
        
        waitframe();
    }
    
    cancer_mission notify( mission_notify );
    level notify( mission_notify );
}

// Namespace cancer
// Params 2
// Checksum 0x327ac351, Offset: 0xa0c1
// Size: 0xab
function function_7bce28700ba989da( squad, encounter_targetname )
{
    a_ai_soldier = ai_spawn_director::function_5d069e637e2d0a05( encounter_targetname );
    
    if ( !squad || squad.size < 1 || !a_ai_soldier || a_ai_soldier.size < 1 )
    {
        return;
    }
    
    var_5f62d2f1c3725618 = ai_spawn_director::get_encounter_data( encounter_targetname );
    
    if ( !var_5f62d2f1c3725618 )
    {
        return;
    }
    
    a_squad_sorted = function_628bac9faa9d1e86( squad, var_5f62d2f1c3725618.origin );
    [ ai_soldier_closest ] = function_628bac9faa9d1e86( a_ai_soldier, a_squad_sorted[ 0 ].origin );
    return ai_soldier_closest;
}

// Namespace cancer
// Params 1
// Checksum 0x6b122b04, Offset: 0xa175
// Size: 0x9b
function function_fc9e9e2d9f68fa94( mission_step )
{
    level endon( #"notify_cancer_guard_entered_combat" );
    agent = self;
    
    while ( true )
    {
        agent waittill( #"enemy" );
        
        if ( isplayer( agent.enemy ) )
        {
            player = agent.enemy;
            var_950c5eed6692bff6 = story_contract_util::function_35a4b91d1599df3e( player );
            
            if ( var_950c5eed6692bff6.ddl_bit == mission_step )
            {
                agent dialogue::stop_dialogue();
                level notify( #"notify_cancer_guard_entered_combat" );
            }
        }
        
        waitframe();
    }
}

/#

    // Namespace cancer
    // Params 0
    // Checksum 0xff080c14, Offset: 0xa218
    // Size: 0x5, Type: dev
    function function_b7beb9b5c0ccf2bd()
    {
        
    }

#/

// Namespace cancer
// Params 1
// Checksum 0xc217cda9, Offset: 0xa225
// Size: 0xb3
function function_339bb5247b45d056( reset_encounter = 0 )
{
    level utility::flag_clear( "notify_cancer_garage_bot_reveal" );
    level utility::flag_clear( "NOTIFY_CANCER_RESORT_RETREAT_02" );
    level utility::flag_wait( "cancer_spawn_resort_guards" );
    level.cancer_encounter_manager thread request_encounter( "enc_cancer_initial_resort_guards", reset_encounter, 0, &function_bc3a998c5347dc3b );
    function_b5760ea0fd42ff6d();
    function_e9bf7f3c3d2f00c0();
    childthread function_64f79685e5104466();
    
    if ( reset_encounter )
    {
        utility::flag_clear( "NOTIFY_CANCER_RESORT_GUARD_FIRST_DEATH" );
    }
    
    requestid = ai_spawn_director::lookup_spawn_request( "enc_cancer_initial_resort_guards" );
    
    if ( requestid )
    {
        childthread utility::function_5085f5ebc9b25c97( "NOTIFY_CANCER_RESORT_GUARD_FIRST_DEATH", 0.2, &ai_spawn_director::function_580d43812763f207, requestid, 0 );
    }
}

// Namespace cancer
// Params 0
// Checksum 0xb719a0d7, Offset: 0xa2e0
// Size: 0x236
function function_b5760ea0fd42ff6d()
{
    var_f9c7ff66596425c9 = getnoentvolumearray( "trig_cancer_initial_resort_guard_retreat_00", #targetname );
    var_f9c7fe6659642396 = getnoentvolumearray( "trig_cancer_initial_resort_guard_retreat_01", #targetname );
    var_f9c7fd6659642163 = getnoentvolumearray( "trig_cancer_initial_resort_guard_retreat_02", #targetname );
    var_f9c7fc6659641f30 = getnoentvolumearray( "trig_cancer_initial_resort_guard_retreat_03", #targetname );
    
    foreach ( trigger in var_f9c7ff66596425c9 )
    {
        level thread function_29ce94ac71862940( trigger, "NOTIFY_CANCER_RESORT_RETREAT_00" );
    }
    
    foreach ( trigger in var_f9c7fe6659642396 )
    {
        level thread function_29ce94ac71862940( trigger, "NOTIFY_CANCER_RESORT_RETREAT_01" );
    }
    
    foreach ( trigger in var_f9c7fd6659642163 )
    {
        level thread function_29ce94ac71862940( trigger, "NOTIFY_CANCER_RESORT_RETREAT_02", 1 );
    }
    
    foreach ( trigger in var_f9c7fc6659641f30 )
    {
        level thread function_29ce94ac71862940( trigger, "NOTIFY_CANCER_RESORT_RETREAT_03" );
    }
}

// Namespace cancer
// Params 0
// Checksum 0x4f832e39, Offset: 0xa51e
// Size: 0x3b
function function_e9bf7f3c3d2f00c0()
{
    level thread function_c143e27cbdf8b2c4( "NOTIFY_CANCER_RESORT_RETREAT_00", "NOTIFY_CANCER_RESORT_GUARD_FIRST_DEATH" );
    level thread function_c143e27cbdf8b2c4( "NOTIFY_CANCER_RESORT_RETREAT_01" );
    level thread function_c143e27cbdf8b2c4( "NOTIFY_CANCER_RESORT_RETREAT_02" );
    level thread function_c143e27cbdf8b2c4( "NOTIFY_CANCER_RESORT_RETREAT_03" );
}

// Namespace cancer
// Params 2
// Checksum 0x78708b51, Offset: 0xa561
// Size: 0x116
function function_c143e27cbdf8b2c4( retreat_notify, extra_flag )
{
    level endon( #"hash_f69d932f551d724b" );
    level waittill( retreat_notify );
    
    if ( extra_flag )
    {
        utility::flag_wait( "NOTIFY_CANCER_RESORT_GUARD_FIRST_DEATH" );
    }
    
    remaining_guards = utility::array_removedead_or_dying( ai_spawn_director::function_5d069e637e2d0a05( "enc_cancer_initial_resort_guards" ) );
    
    foreach ( guard in remaining_guards )
    {
        if ( guard.retreat_notify && guard.retreat_notify == retreat_notify )
        {
            wait randomfloatrange( 0.1, 0.45 );
            
            if ( isalive( guard ) )
            {
                guard thread function_5e5fec2fcf9a5368();
            }
        }
        
        if ( retreat_notify == "NOTIFY_CANCER_RESORT_RETREAT_03" )
        {
            guard utility::ent_flag_set( "ENT_FLAG_CANCER_GUARD_RETREAT_ONLY" );
        }
    }
}

// Namespace cancer
// Params 4
// Checksum 0x80397e16, Offset: 0xa67f
// Size: 0x248
function function_bc3a998c5347dc3b( requestid, userdata, agent, data )
{
    agent.script_noteworthy = data.script_noteworthy;
    agent thread function_fc9e9e2d9f68fa94( "cancer_intro" );
    cancer_resort_garage_awareness_vol = getnoentvolumearray( "cancer_resort_garage_awareness_vol", #targetname )[ 0 ];
    
    if ( cancer_resort_garage_awareness_vol )
    {
        agent function_23741795e43fc95c( cancer_resort_garage_awareness_vol );
    }
    
    if ( agent.script_noteworthy )
    {
        switch ( agent.script_noteworthy )
        {
            case #"hash_13e5e7c8b1684d24":
                agent.goal_b = 1;
            case #"hash_240821eda20bcd05":
                agent.retreat_notify = "NOTIFY_CANCER_RESORT_RETREAT_00";
                break;
            case #"hash_a9190c8ac0391ef":
                agent.goal_b = 1;
            case #"hash_240820eda20bcb72":
                agent.retreat_notify = "NOTIFY_CANCER_RESORT_RETREAT_01";
                agent thread function_974b3d0acfab52e6( [ "NOTIFY_CANCER_RESORT_RETREAT_00", "NOTIFY_CANCER_RESORT_GUARD_FIRST_DEATH" ], "NOTIFY_CANCER_RESORT_RETREAT_01" );
                break;
            case #"hash_2d0fdc8a7dd3fc6":
                agent.goal_b = 1;
            case #"hash_24081feda20bc9df":
                agent.retreat_notify = "NOTIFY_CANCER_RESORT_RETREAT_02";
                agent.var_acf026e860480aa1 = 1;
                agent.var_fec54ea248ceba8e = 1;
                break;
            case #"hash_fbd8a6c8a45389d1":
                agent.goal_b = 1;
            case #"hash_24081eeda20bc84c":
                agent.retreat_notify = "NOTIFY_CANCER_RESORT_RETREAT_03";
                agent.var_acf026e860480aa1 = 1;
                agent.var_fec54ea248ceba8e = 1;
                agent thread function_974b3d0acfab52e6( [ "NOTIFY_CANCER_RESORT_RETREAT_00" ], "NOTIFY_CANCER_RESORT_RETREAT_03" );
                break;
            case #"hash_9bb1e2fd05365254":
                if ( data.script_parameters )
                {
                    data.script_parameters = agent.script_parameters;
                }
                
                agent thread function_104e48827b4f435e();
                agent thread function_4e130dd71d0794dc();
                break;
            default:
                break;
        }
    }
}

// Namespace cancer
// Params 0
// Checksum 0x513a7306, Offset: 0xa8cf
// Size: 0x385
function function_5e5fec2fcf9a5368()
{
    self endon( #"death" );
    var_3009552061473f4b = 0.2;
    cancer_resort_guards_retreat_goal_lobby = getent( "cancer_resort_guards_retreat_goal_lobby", #targetname );
    cancer_resort_guards_retreat_goal_garage = getent( "cancer_resort_guards_retreat_goal_garage", #targetname );
    cancer_resort_guards_retreat_goal_garage_b = getent( "cancer_resort_guards_retreat_goal_garage_b", #targetname );
    cancer_resort_guards_retreat_goal_lobby_door = getent( "cancer_resort_guards_retreat_goal_lobby_door", #targetname );
    cancer_resort_guards_retreat_goal_lobby_door_b = getent( "cancer_resort_guards_retreat_goal_lobby_door_b", #targetname );
    utility::demeanor_override( "sprint" );
    self.stealth_enabled = 0;
    
    if ( !self.goal_b && cancer_resort_guards_retreat_goal_garage )
    {
        self setgoalvolumeauto( cancer_resort_guards_retreat_goal_garage );
    }
    else if ( cancer_resort_guards_retreat_goal_garage_b )
    {
        self setgoalvolumeauto( cancer_resort_guards_retreat_goal_garage_b );
    }
    else
    {
        /#
            iprintlnbold( "<dev string:xc3>" );
        #/
    }
    
    utility::waittill_notify_or_timeout_return( "goal", 8 );
    var_9797ee1f9f2db5c6 = randomfloat( 1 );
    
    if ( var_9797ee1f9f2db5c6 > var_3009552061473f4b && self.retreat_notify != "NOTIFY_CANCER_RESORT_RETREAT_00" )
    {
        self.ignoreall = 0;
        self.goalradius = 250;
        self.var_acf026e860480aa1 = 1;
        self.var_fec54ea248ceba8e = 1;
        utility::demeanor_override( "combat" );
        utility::ent_flag_wait( "ENT_FLAG_CANCER_GUARD_RETREAT_ONLY" );
    }
    
    foreach ( cancer_mission in level.cancer_missions )
    {
        cancer_mission notify( #"notify_cancer_garage_retreat" );
    }
    
    self.ignoreall = 1;
    ai::set_forcegoal();
    self.allowstrafe = 0;
    thread nerf_ai();
    utility::demeanor_override( "sprint" );
    utility::delaythread( 1.5, &function_6c7ae3d48a89e677 );
    
    if ( cancer_resort_guards_retreat_goal_lobby )
    {
        self setgoalvolumeauto( cancer_resort_guards_retreat_goal_lobby );
        
        if ( !self.goal_b && cancer_resort_guards_retreat_goal_lobby_door )
        {
            self waittill( #"goal" );
            self setgoalvolumeauto( cancer_resort_guards_retreat_goal_lobby_door );
        }
        else if ( cancer_resort_guards_retreat_goal_lobby_door_b )
        {
            self waittill( #"goal" );
            self setgoalvolumeauto( cancer_resort_guards_retreat_goal_lobby_door_b );
        }
    }
    else
    {
        /#
            iprintlnbold( "<dev string:xc3>" );
        #/
    }
    
    self waittill( #"goal" );
    near_players = sortbydistancecullbyradius( level.players, self.origin, 1000 );
    
    foreach ( player in near_players )
    {
        if ( self seerecently( player, 0.85 ) )
        {
            if ( !self.goal_b && cancer_resort_guards_retreat_goal_lobby_door )
            {
                level notify( #"NOTIFY_CANCER_RESORT_LOBBY_SMOKE_RETREAT" );
            }
            else if ( cancer_resort_guards_retreat_goal_lobby_door_b )
            {
                level notify( #"NOTIFY_CANCER_RESORT_LOBBY_SMOKE_RETREAT_B" );
            }
            
            wait 1.25;
            break;
        }
    }
    
    ai::function_dd7b3233e5b07718( 1 );
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0x78ed82a9, Offset: 0xac5c
// Size: 0xc2
function private function_6c7ae3d48a89e677()
{
    self endon( #"death" );
    
    while ( true )
    {
        near_players = sortbydistancecullbyradius( level.players, self.origin, 2000 );
        
        foreach ( player in near_players )
        {
            if ( !self seerecently( player, 2 ) )
            {
                ai::function_dd7b3233e5b07718( 1 );
                return;
            }
        }
        
        wait 0.5;
    }
}

// Namespace cancer
// Params 2
// Checksum 0x9d235ce5, Offset: 0xad26
// Size: 0xdb
function function_974b3d0acfab52e6( var_1c036940646042ce, reinforce_endon )
{
    self endon( #"death" );
    self endon( reinforce_endon );
    self.ignoreall = 1;
    self.goalradius = 64;
    self.fixednode = 1;
    level utility::waittill_any_in_array( var_1c036940646042ce );
    self.ignoreall = 0;
    self.fixednode = 0;
    
    if ( self.script_parameters )
    {
        goal = utility::getstruct( self.script_parameters, "targetname" );
        
        if ( goal )
        {
            self function_fa32376aaa88a7a2( goal.origin, 3000 );
            ai_utility::go_to_node( goal );
            self setgoalpos( goal.origin, goal.radius );
            level notify( #"hash_2dbeb7f127d286c3" );
        }
    }
}

// Namespace cancer
// Params 0
// Checksum 0x4590d459, Offset: 0xae09
// Size: 0xe7
function function_104e48827b4f435e()
{
    self endon( #"death" );
    self.ignoreall = 1;
    self.goalradius = 64;
    self.fixednode = 1;
    self.var_ee914ad666562200 = 1;
    level waittill( #"NOTIFY_CANCER_RESORT_RETREAT_02" );
    level utility::waittill_notify_or_timeout( "NOTIFY_CANCER_RESORT_RETREAT_03", 3.5 );
    self.ignoreall = 0;
    
    if ( self.script_parameters )
    {
        goal = utility::getstruct( self.script_parameters, "targetname" );
        
        if ( goal )
        {
            ai_utility::go_to_node( goal );
            self setgoalpos( goal.origin, goal.radius );
            level utility::flag_set( "notify_cancer_garage_bot_reveal" );
            self waittill( #"goal" );
            self.var_ee914ad666562200 = 0;
            self.fixednode = 0;
        }
    }
}

// Namespace cancer
// Params 0
// Checksum 0x83b63ba8, Offset: 0xaef8
// Size: 0x4f
function function_4e130dd71d0794dc()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker );
        
        if ( isplayer( attacker ) )
        {
            level notify( #"notify_cancer_garage_bot_damaged" );
        }
        
        waitframe();
    }
}

// Namespace cancer
// Params 0
// Checksum 0xf1cc8f34, Offset: 0xaf4f
// Size: 0x1a6
function function_64f79685e5104466()
{
    self notify( #"hash_5a5e79159a49ab54" );
    self endon( #"hash_5a5e79159a49ab54" );
    cancer_resort_guards_retreat_goal_lobby = getent( "cancer_resort_guards_retreat_goal_lobby", #targetname );
    cancer_resort_guards_retreat_goal_lobby_door = getent( "cancer_resort_guards_retreat_goal_lobby_door", #targetname );
    cancer_resort_guards_retreat_goal_lobby_door_b = getent( "cancer_resort_guards_retreat_goal_lobby_door_b", #targetname );
    level waittill( #"NOTIFY_CANCER_RESORT_RETREAT_03" );
    smokegrenadeweapon = equipment_mp::getweaponfromequipmentref( "equip_smoke" );
    
    if ( !smokegrenadeweapon )
    {
        return;
    }
    
    while ( true )
    {
        msg = level utility::waittill_any_return( "NOTIFY_CANCER_RESORT_LOBBY_SMOKE_RETREAT", "NOTIFY_CANCER_RESORT_LOBBY_SMOKE_RETREAT_B" );
        
        if ( msg == "NOTIFY_CANCER_RESORT_LOBBY_SMOKE_RETREAT_B" )
        {
            ground_pos = getclosestpointonnavmesh( cancer_resort_guards_retreat_goal_lobby_door_b.origin );
        }
        else if ( cancer_resort_guards_retreat_goal_lobby_door )
        {
            ground_pos = getclosestpointonnavmesh( cancer_resort_guards_retreat_goal_lobby_door.origin );
        }
        else
        {
            ground_pos = getclosestpointonnavmesh( cancer_resort_guards_retreat_goal_lobby.origin );
        }
        
        smokebomb_duration = 8000;
        smokegrenadeent = magicgrenademanual( smokegrenadeweapon.basename, ground_pos, ( 0, 0, -10 ), 0 );
        thread utility::delaythread( 0.05, &utility::play_sound_in_space, "smoke_grenade_expl_trans", smokegrenadeent.origin );
        var_e6b2169840aaa3e = spawnstruct();
        var_e6b2169840aaa3e.origin = smokegrenadeent.origin;
        var_e6b2169840aaa3e.endtime = gettime() + smokebomb_duration;
        wait 6.5;
    }
}

// Namespace cancer
// Params 0, eflags: 0x4
// Checksum 0xae1edb14, Offset: 0xb0fd
// Size: 0x62
function private nerf_ai()
{
    utility::ent_flag_set( "ai_nerf" );
    ai::set_ai_max_health( int( self.health * 0.5 ) + 1 );
    
    if ( isdefined( self.armorhealth ) )
    {
        self.armorhealth = int( self.armorhealth * 0.5 ) + 1;
    }
    
    self.ignoresuppression = 1;
}

// Namespace cancer
// Params 0
// Checksum 0xe9429fc4, Offset: 0xb167
// Size: 0x2e
function function_5532d53cd7c7e1e()
{
    level utility::flag_clear( "flag_cancer_resort_elevator_reveal" );
    level utility::flag_clear( "flag_cancer_penthouse_saferoom_vo_done" );
    level thread function_339bb5247b45d056( 1 );
    level thread reset_lab_door();
}

// Namespace cancer
// Params 0
// Checksum 0x8a2656b8, Offset: 0xb19d
// Size: 0x36
function function_b10ce1ca3b3c42ab()
{
    activity_info = level.var_e607236b193eb0c1.var_5992a4946aeeca5a[ "CANCER_CONFRONT_PENTHOUSE_01" ];
    
    if ( activity_info )
    {
        level ob_activity_manager::ob_activity_instance_init( activity_info );
    }
}

/#

    // Namespace cancer
    // Params 0
    // Checksum 0xa97a1eb4, Offset: 0xb1db
    // Size: 0x5, Type: dev
    function function_485dd58fbbefe627()
    {
        
    }

#/

// Namespace cancer
// Params 0
// Checksum 0xccb0a6b5, Offset: 0xb1e8
// Size: 0xa9
function function_293349321a6b7a44()
{
    cancer_resort_elevator_door_interact_struct = utility::getstruct( "cancer_resort_elevator_door_interact", "targetname" );
    interact_offset = ( -2, 0, -20 );
    interaction_size = 72;
    elevator_door_interact = interaction::register_interact( cancer_resort_elevator_door_interact_struct.origin + interact_offset, interaction_size, &elevator_door_interacted, &"sat_ob_activities/cancer_open", undefined, undefined, undefined, "HINT_BUTTON" );
    elevator_door_interact setusableenabled( 1 );
    elevator_door_interact sethintdisplayrange( 200 );
    elevator_door_interact sethintdisplayfov( 360 );
    elevator_door_interact setusefov( 45 );
    elevator_door_interact setuseholdduration( 600 );
}

// Namespace cancer
// Params 1, eflags: 0x4
// Checksum 0xd98791ed, Offset: 0xb299
// Size: 0x19
function private elevator_door_interacted( player )
{
    thread function_41ddb216f785c08f();
    self delete();
}

// Namespace cancer
// Params 0
// Checksum 0x381ac9ce, Offset: 0xb2ba
// Size: 0x173
function function_41ddb216f785c08f()
{
    door_offset = ( 0, 24, 0 );
    var_1bac8038488b46fd = 2;
    cancer_penthouse_elevator_doors_l = getent( "cancer_penthouse_elevator_doors_l", #targetname );
    cancer_penthouse_elevator_doors_r = getent( "cancer_penthouse_elevator_doors_r", #targetname );
    cancer_penthouse_elevator_doors_clip_l = getent( "cancer_penthouse_elevator_doors_clip_l", #targetname );
    cancer_penthouse_elevator_doors_clip_r = getent( "cancer_penthouse_elevator_doors_clip_r", #targetname );
    
    if ( !cancer_penthouse_elevator_doors_l )
    {
        cancer_penthouse_elevator_doors_l = getscriptablearray( "cancer_penthouse_elevator_doors_l", #targetname )[ 0 ];
    }
    
    if ( !cancer_penthouse_elevator_doors_r )
    {
        cancer_penthouse_elevator_doors_r = getscriptablearray( "cancer_penthouse_elevator_doors_r", #targetname )[ 0 ];
    }
    
    if ( cancer_penthouse_elevator_doors_l )
    {
        cancer_penthouse_elevator_doors_l moveto( cancer_penthouse_elevator_doors_l.origin + door_offset, var_1bac8038488b46fd );
    }
    
    if ( cancer_penthouse_elevator_doors_r )
    {
        cancer_penthouse_elevator_doors_r moveto( cancer_penthouse_elevator_doors_r.origin - door_offset, var_1bac8038488b46fd );
    }
    
    if ( cancer_penthouse_elevator_doors_clip_l )
    {
        cancer_penthouse_elevator_doors_clip_l connectpaths();
        cancer_penthouse_elevator_doors_clip_l moveto( cancer_penthouse_elevator_doors_clip_l.origin + door_offset, var_1bac8038488b46fd );
    }
    
    if ( cancer_penthouse_elevator_doors_clip_r )
    {
        cancer_penthouse_elevator_doors_clip_r connectpaths();
        cancer_penthouse_elevator_doors_clip_r moveto( cancer_penthouse_elevator_doors_clip_r.origin - door_offset, var_1bac8038488b46fd );
    }
    
    playsoundatpos( cancer_penthouse_elevator_doors_l.origin + ( 0, 0, 50 ), "evt_cancer_pent_elevator_door_open" );
}

/#

    // Namespace cancer
    // Params 0
    // Checksum 0xf8251a85, Offset: 0xb435
    // Size: 0x5, Type: dev
    function function_fa1fe6195d44f732()
    {
        
    }

#/

// Namespace cancer
// Params 1
// Checksum 0x74ab5398, Offset: 0xb442
// Size: 0x38
function function_ba5de45a742651a4( reset_encounter = 0 )
{
    level utility::flag_wait( "flag_cancer_skyscrapper_spawn_enemies" );
    level.cancer_encounter_manager thread request_encounter( "enc_cancer_skyscraper_pre_1_enemies", reset_encounter );
}

/#

    // Namespace cancer
    // Params 0
    // Checksum 0xbf856055, Offset: 0xb482
    // Size: 0x5, Type: dev
    function function_85fe251fa0f3574f()
    {
        
    }

#/

// Namespace cancer
// Params 1
// Checksum 0xd4c4095c, Offset: 0xb48f
// Size: 0x38
function function_32493132174c387d( reset_encounter = 0 )
{
    level utility::flag_wait( "flag_cancer_skyscrapper_spawn_enemies" );
    level.cancer_encounter_manager thread request_encounter( "enc_cancer_skyscraper_pre_2_enemies", reset_encounter );
}

/#

    // Namespace cancer
    // Params 0
    // Checksum 0x82e549e5, Offset: 0xb4cf
    // Size: 0x5, Type: dev
    function function_126ca9ff059ade6c()
    {
        
    }

#/

// Namespace cancer
// Params 1
// Checksum 0x231c2df, Offset: 0xb4dc
// Size: 0x38
function function_629a1fcdca83a336( reset_encounter = 0 )
{
    level utility::flag_wait( "flag_cancer_skyscrapper_spawn_enemies" );
    level.cancer_encounter_manager thread request_encounter( "enc_cancer_skyscraper_pre_3_enemies", reset_encounter );
}

/#

    // Namespace cancer
    // Params 0
    // Checksum 0x5ddbe272, Offset: 0xb51c
    // Size: 0x5, Type: dev
    function function_b50d6623825994ab()
    {
        
    }

#/

// Namespace cancer
// Params 1
// Checksum 0x8b3aa6fa, Offset: 0xb529
// Size: 0x3f
function function_fe8a217a216aa549( reset_encounter = 0 )
{
    level utility::flag_wait( "flag_cancer_skyscrapper_spawn_enemies" );
    level.cancer_encounter_manager thread request_encounter( "enc_cancer_skyscrapper_parking_lot_guards", reset_encounter, 1, &function_863ce808951314e2 );
}

// Namespace cancer
// Params 4
// Checksum 0xa520dc4b, Offset: 0xb570
// Size: 0x4a
function function_863ce808951314e2( requestid, userdata, agent, data )
{
    agent thread function_fc9e9e2d9f68fa94( "cancer_outro" );
    agent function_fa32376aaa88a7a2( agent.origin, 4000 );
}

/#

    // Namespace cancer
    // Params 0
    // Checksum 0xa8072eb, Offset: 0xb5c2
    // Size: 0x5, Type: dev
    function function_b7f2bd6d8027d2a()
    {
        
    }

#/

// Namespace cancer
// Params 1
// Checksum 0x4af1fc5, Offset: 0xb5cf
// Size: 0x38
function function_ef17e3aaa2a3c254( reset_encounter = 0 )
{
    level utility::flag_wait( "flag_cancer_skyscrapper_spawn_enemies" );
    level.cancer_encounter_manager thread request_encounter( "enc_cancer_skyscraper_parking_lot_roof", reset_encounter );
}

/#

    // Namespace cancer
    // Params 0
    // Checksum 0xd554568, Offset: 0xb60f
    // Size: 0x5, Type: dev
    function function_2e97a072da5f5f0a()
    {
        
    }

#/

// Namespace cancer
// Params 1
// Checksum 0x8ee5e1cc, Offset: 0xb61c
// Size: 0xc7
function function_d4fcc1eecd0a48f4( reset_encounter = 0 )
{
    level thread function_29ce94ac71862940( "notify_cancer_skyscraper_entrance_enemy_spawn", "notify_cancer_skyscraper_entrance_enemy_spawn" );
    level waittill( #"notify_cancer_skyscraper_entrance_enemy_spawn" );
    
    foreach ( cancer_mission in level.cancer_missions )
    {
        cancer_mission notify( #"notify_cancer_skyscraper_entrance_enemy_spawn" );
    }
    
    level.cancer_encounter_manager thread request_encounter( "enc_cancer_skyscraper_parking_lot_entrance", reset_encounter );
}

/#

    // Namespace cancer
    // Params 0
    // Checksum 0x6378be49, Offset: 0xb6eb
    // Size: 0x5, Type: dev
    function function_82d19e2ed2ea257e()
    {
        
    }

#/

// Namespace cancer
// Params 1
// Checksum 0x64341d1c, Offset: 0xb6f8
// Size: 0xdf
function function_b15a1a19f750abd5( reset_encounter )
{
    level thread function_29ce94ac71862940( "notify_cancer_skyscraper_lobby_enemy_spawn", "notify_cancer_skyscraper_lobby_enemy_spawn" );
    level waittill( #"notify_cancer_skyscraper_lobby_enemy_spawn" );
    requestid = ai_spawn_director::lookup_spawn_request( "enc_cancer_skyscraper_lobby" );
    data = function_9b649316adcccbaa( requestid );
    
    if ( data.status == 1 )
    {
        level.var_f3eb940b8590ddc9 = spawnstruct();
        
        if ( !isdefined( level.var_f3eb940b8590ddc9.ai_array ) )
        {
            level.var_f3eb940b8590ddc9.ai_array = [];
        }
        
        function_ef57f478f96b050c( requestid, 1 );
        
        /#
            iprintlnbold( "<dev string:xd3>" );
        #/
        
        ai_spawn_director::add_spawned_callback( requestid, &function_78f51851f036a128, level.var_f3eb940b8590ddc9 );
        activity_ai_encounters::function_6bf4ff2fbde584ee( requestid, &function_a7ef1fb1d30f3774, level.var_f3eb940b8590ddc9 );
    }
}

// Namespace cancer
// Params 4
// Checksum 0x9508303e, Offset: 0xb7df
// Size: 0xbf
function function_78f51851f036a128( requestid, userdata, agent, data )
{
    level endon( #"hash_59db8a35650dc4" );
    
    if ( !isdefined( agent ) )
    {
        return;
    }
    
    agent function_fa32376aaa88a7a2( agent.origin, 4000 );
    struct = userdata;
    struct.ai_array = arraycombineunique( struct.ai_array, [ agent ] );
    agent waittill( #"death" );
    
    if ( arraycontains( struct.ai_array, agent ) )
    {
        struct.ai_array = arrayremove( struct.ai_array, agent );
    }
}

// Namespace cancer
// Params 2
// Checksum 0x171ea042, Offset: 0xb8a6
// Size: 0x74
function function_a7ef1fb1d30f3774( requestid, struct )
{
    level endon( #"hash_59db8a35650dc4" );
    wait 5;
    start_time = gettime();
    time_passed = 0;
    
    while ( struct.ai_array.size > 1 && time_passed < 20000 )
    {
        time_passed = gettime() - start_time;
        waitframe();
    }
    
    level notify( #"hash_5b7f2da0ee9188b5" );
}

/#

    // Namespace cancer
    // Params 0
    // Checksum 0x20ac699, Offset: 0xb922
    // Size: 0x5, Type: dev
    function function_969e4aec87708477()
    {
        
    }

#/

// Namespace cancer
// Params 1
// Checksum 0xdef607b2, Offset: 0xb92f
// Size: 0xb4
function function_5f33f32b562a4dbe( reset_encounter = 0 )
{
    level utility::flag_wait( "flag_cancer_skyscrapper_spawn_enemies" );
    
    if ( !isdefined( level.var_e3babcb8f7252f5b ) )
    {
        level.var_e3babcb8f7252f5b = spawnstruct();
    }
    
    if ( !isdefined( level.var_e3babcb8f7252f5b.ai_array ) )
    {
        level.var_e3babcb8f7252f5b.ai_array = [];
    }
    
    if ( reset_encounter )
    {
        level.var_e3babcb8f7252f5b.ai_array = [];
    }
    
    level.cancer_encounter_manager thread request_encounter( "enc_cancer_skyscraper_mid_level_holdout", reset_encounter, 1, &function_9b33f72b93da1592, level.var_e3babcb8f7252f5b, &function_cac1aeb7759473ef, level.var_e3babcb8f7252f5b );
}

// Namespace cancer
// Params 4
// Checksum 0x486b13f0, Offset: 0xb9eb
// Size: 0xd6
function function_9b33f72b93da1592( requestid, userdata, agent, data )
{
    level endon( #"hash_59db8a35650dc4" );
    
    if ( !isdefined( agent ) )
    {
        return;
    }
    
    agent thread function_fc9e9e2d9f68fa94( "cancer_outro" );
    agent thread cancer_mid_level_stairway_retreater();
    agent function_fa32376aaa88a7a2( agent.origin, 4000 );
    struct = userdata;
    struct.ai_array = arraycombineunique( struct.ai_array, [ agent ] );
    agent waittill( #"death" );
    
    if ( arraycontains( struct.ai_array, agent ) )
    {
        struct.ai_array = arrayremove( struct.ai_array, agent );
    }
}

// Namespace cancer
// Params 0
// Checksum 0x60a39cf8, Offset: 0xbac9
// Size: 0xa1
function cancer_mid_level_stairway_retreater()
{
    self endon( #"death" );
    struct = utility::getstruct( "mid_level_stairway_retreater_goal", "targetname" );
    left_struct = utility::getstruct( "mid_level_left_goal", "targetname" );
    self setgoalpos( self.origin, self.radius );
    level waittill( #"hash_beea93fe5d82a483" );
    self setgoalpos( left_struct.origin, left_struct.radius );
    self.goalradius = 65;
    ai::set_forcegoal();
    self.allowstrafe = 0;
}

// Namespace cancer
// Params 2
// Checksum 0x9b36323e, Offset: 0xbb72
// Size: 0x43
function function_cac1aeb7759473ef( requestid, struct )
{
    level endon( #"hash_59db8a35650dc4" );
    
    while ( struct.ai_array.size > 0 )
    {
        waitframe();
    }
    
    level utility::flag_set( "flag_cancer_outro_terrace_encounter_cleared" );
}

/#

    // Namespace cancer
    // Params 0
    // Checksum 0xb7b0c67b, Offset: 0xbbbd
    // Size: 0x5, Type: dev
    function function_3d05a7c4e8c36a7f()
    {
        
    }

#/

// Namespace cancer
// Params 1
// Checksum 0xae5d5769, Offset: 0xbbca
// Size: 0x3f
function function_cfd6c319693e822e( reset_encounter = 0 )
{
    level utility::flag_wait( "flag_cancer_skyscrapper_spawn_enemies" );
    level.cancer_encounter_manager thread request_encounter( "enc_cancer_skyscraper_top_boardroom", reset_encounter, 1, &function_13f8571275f25987 );
}

// Namespace cancer
// Params 4
// Checksum 0xa46437c6, Offset: 0xbc11
// Size: 0x97
function function_13f8571275f25987( requestid, userdata, agent, data )
{
    level endon( #"hash_59db8a35650dc4" );
    agent thread function_fc9e9e2d9f68fa94( "cancer_outro" );
    agent utility::set_battlechatter( 0 );
    agent.battlechatter.npcid = "3";
    level.cancer_encounter_manager.sanctum_guard = agent;
    agent waittill( #"death" );
    level utility::flag_set( "flag_cancer_outro_boardroom_encounter_cleared" );
}

// Namespace cancer
// Params 0
// Checksum 0x98a1a56c, Offset: 0xbcb0
// Size: 0x121
function function_9e184a05a15fe947()
{
    structs = utility::getstructarray( "cancer_skyscraper_lock_door", "targetname" );
    
    foreach ( struct in structs )
    {
        scriptables = getentitylessscriptablearray( undefined, undefined, struct.origin, 200 );
        
        foreach ( scriptable in scriptables )
        {
            if ( scriptable scriptableisdoor() )
            {
                scriptable scriptabledoorlock();
            }
        }
    }
    
    level thread function_63cb30943535c388();
}

// Namespace cancer
// Params 0
// Checksum 0xbfe6242a, Offset: 0xbdd9
// Size: 0x15a
function function_63cb30943535c388()
{
    level waittill( #"hash_5b7f2da0ee9188b5" );
    structs = utility::getstructarray( "cancer_skyscraper_lock_door", "targetname" );
    lobbydoor_loc = utility::getstruct( "lobby_door_open" );
    
    foreach ( struct in structs )
    {
        scriptables = getentitylessscriptablearray( undefined, undefined, struct.origin, 50 );
        
        foreach ( scriptable in scriptables )
        {
            if ( scriptable scriptableisdoor() )
            {
                scriptable scriptabledoorunlock();
                scriptable scriptabledooropen( "away", lobbydoor_loc.origin );
            }
        }
    }
    
    level thread function_31552129e94101d1();
}

/#

    // Namespace cancer
    // Params 0
    // Checksum 0x274fe352, Offset: 0xbf3b
    // Size: 0x5, Type: dev
    function function_a5c2e9dda87360db()
    {
        
    }

#/

// Namespace cancer
// Params 0
// Checksum 0xf603ce65, Offset: 0xbf48
// Size: 0xac
function function_31552129e94101d1()
{
    /#
        iprintlnbold( "<dev string:xe6>" );
    #/
    
    requestid = ai_spawn_director::lookup_spawn_request( "enc_cancer_skyscraper_lobby_reinforce" );
    data = function_9b649316adcccbaa( requestid );
    
    if ( data.status == 1 )
    {
        level.var_f67ec2b3b9446f03 = spawnstruct();
        
        if ( !isdefined( level.var_f67ec2b3b9446f03.ai_array ) )
        {
            level.var_f67ec2b3b9446f03.ai_array = [];
        }
        
        function_ef57f478f96b050c( requestid, 1 );
        
        /#
            iprintlnbold( "<dev string:x103>" );
        #/
        
        ai_spawn_director::add_spawned_callback( requestid, &function_1fcd298224e83fc5, level.var_f67ec2b3b9446f03 );
    }
}

// Namespace cancer
// Params 4
// Checksum 0x9f25ad03, Offset: 0xbffc
// Size: 0x45
function function_1fcd298224e83fc5( requestid, userdata, agent, data )
{
    agent function_fa32376aaa88a7a2( agent.origin, 4000 );
    agent thread function_ec4b2f8a93582d8b();
}

// Namespace cancer
// Params 0
// Checksum 0x809ecae1, Offset: 0xc049
// Size: 0x4a
function function_ec4b2f8a93582d8b()
{
    wait 1;
    
    if ( self.script_noteworthy == "lobby_reinforcement_jugg" )
    {
        /#
            iprintlnbold( "<dev string:x128>" );
        #/
        
        self waittill( #"death" );
        
        /#
            iprintlnbold( "<dev string:x147>" );
        #/
        
        utility::flag_set( "flag_cancer_skyscraper_holdout_titan_dead" );
    }
}

// Namespace cancer
// Params 0
// Checksum 0xc055b31a, Offset: 0xc09b
// Size: 0x25
function function_8233f91da3a1a43e()
{
    level utility::flag_clear( "flag_cancer_outro_terrace_encounter_cleared" );
    level utility::flag_clear( "flag_cancer_skyscraper_holdout_complete" );
    level thread set_elevator_door_state( 0 );
}

/#

    // Namespace cancer
    // Params 0
    // Checksum 0xa983cbd8, Offset: 0xc0c8
    // Size: 0x5, Type: dev
    function function_4567eeb628434cfc()
    {
        
    }

#/

// Namespace cancer
// Params 7
// Checksum 0x771cbac2, Offset: 0xc0d5
// Size: 0x1b5
function request_encounter( encounter_name, reset_encounter = 0, var_19a90e8e5da456ea = 1, on_spawned_callback = undefined, on_spawned_data = undefined, var_531a5d7d8a693acb = undefined, var_dcdc4a8ce8700558 = undefined )
{
    requestid = ai_spawn_director::lookup_spawn_request( encounter_name );
    
    if ( !requestid )
    {
        return;
    }
    
    data = function_9b649316adcccbaa( requestid );
    
    if ( arraycontains( self.active_encounters, encounter_name ) )
    {
        if ( !reset_encounter )
        {
            return;
        }
        else
        {
            if ( arraycontains( self.resetting_encounters, encounter_name ) )
            {
                return;
            }
            
            self.resetting_encounters[ self.resetting_encounters.size ] = encounter_name;
            players_nearby = 1;
            
            while ( players_nearby )
            {
                if ( getplayerinfluenceatposition( data.origin ) < 0.1 )
                {
                    players_nearby = 0;
                }
                
                wait 1;
            }
            
            function_17ee483eb76a9759( requestid, 1 );
            waitframe();
        }
    }
    
    while ( data.status != 1 )
    {
        wait 1;
        data = function_9b649316adcccbaa( requestid );
    }
    
    function_ef57f478f96b050c( requestid, 1 );
    function_64ac8c4e752f4dca( requestid, var_19a90e8e5da456ea );
    self.active_encounters = arraycombineunique( self.active_encounters, [ encounter_name ] );
    
    /#
        iprintlnbold( encounter_name + "<dev string:x152>" );
    #/
    
    if ( on_spawned_callback )
    {
        ai_spawn_director::add_spawned_callback( requestid, on_spawned_callback, on_spawned_data );
    }
    
    if ( var_531a5d7d8a693acb )
    {
        activity_ai_encounters::function_6bf4ff2fbde584ee( requestid, var_531a5d7d8a693acb, var_dcdc4a8ce8700558 );
    }
    
    self.resetting_encounters = arrayremove( self.resetting_encounters, encounter_name );
}

/#

    // Namespace cancer
    // Params 0
    // Checksum 0xce8cb033, Offset: 0xc292
    // Size: 0x5, Type: dev
    function function_6947009142975441()
    {
        
    }

#/

// Namespace cancer
// Params 2
// Checksum 0xd1403b, Offset: 0xc29f
// Size: 0x1ba
function function_bb3bc91ea7e32d3b( emitter, struct_locations )
{
    level endon( #"game_ended" );
    dist = 2500;
    
    while ( true )
    {
        params = function_4d7d0a9677311946( struct_locations, dist );
        
        if ( params.result )
        {
            emitter.origin = params.origin;
            
            foreach ( cancer_mission in level.cancer_missions )
            {
                if ( cancer_mission.step_index == 0 && cancer_mission.var_66ba198d514b0772 )
                {
                    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
                    
                    foreach ( player in var_64bb57aa2d6e8b35.players )
                    {
                        player playsoundtoplayer( "amb_emt_cancer_horror_vox", player, emitter );
                    }
                }
            }
            
            wait randomfloatrange( 3, 6 );
            continue;
        }
        
        wait 0.5;
    }
}

// Namespace cancer
// Params 2
// Checksum 0x2c04da68, Offset: 0xc461
// Size: 0x1bd
function function_4d7d0a9677311946( struct_locations, dist )
{
    params = {};
    params.result = 0;
    params.origin = struct_locations[ 0 ].origin;
    var_399a0f97e8cb8e0b = struct_locations[ randomintrange( 0, struct_locations.size - 1 ) ];
    
    foreach ( cancer_mission in level.cancer_missions )
    {
        if ( cancer_mission.step_index == 0 )
        {
            var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
            
            foreach ( player in var_64bb57aa2d6e8b35.players )
            {
                if ( distancesquared( player.origin, var_399a0f97e8cb8e0b.origin ) < dist )
                {
                    return params;
                }
            }
        }
    }
    
    params.result = 1;
    params.origin = var_399a0f97e8cb8e0b.origin;
    return params;
}

// Namespace cancer
// Params 1
// Checksum 0xc90e03e9, Offset: 0xc627
// Size: 0xc8
function function_95c8146c48e8b44f( cancer_mission )
{
    self endon( #"disconnect" );
    is_started = utility::flag( "flag_cancer_saferoom_music_started" );
    var_be8546f2a31b0a3e = utility::flag( "flag_cancer_saferoom_bookcase_opening" ) || utility::flag( "flag_cancer_saferoom_bookcase_open" );
    is_closed = is_started && !var_be8546f2a31b0a3e;
    
    if ( !is_started )
    {
        self clearsoundsubmix( "mp_sat_ob_cancer_saferoom_occ_mx_mute" );
        self clearsoundsubmix( "mp_sat_ob_cancer_saferoom_mx_mute" );
        return;
    }
    
    if ( is_closed )
    {
        self clearsoundsubmix( "mp_sat_ob_cancer_saferoom_occ_mx_mute" );
        self setsoundsubmix( "mp_sat_ob_cancer_saferoom_mx_mute" );
        return;
    }
    
    if ( var_be8546f2a31b0a3e )
    {
        self clearsoundsubmix( "mp_sat_ob_cancer_saferoom_mx_mute", 1.5 );
        self setsoundsubmix( "mp_sat_ob_cancer_saferoom_occ_mx_mute", 1.5 );
    }
}

// Namespace cancer
// Params 1
// Checksum 0x1b34a29a, Offset: 0xc6f7
// Size: 0x15c
function function_4f2bbb39e7ff5e3c( cancer_mission )
{
    level endon( #"game_ended" );
    cancer_mission endon( #"reset" );
    var_5f69f0d7ed202678 = utility::getstruct( "saferoom_music_audio_location", "targetname" );
    
    if ( isstruct( var_5f69f0d7ed202678 ) && isvector( var_5f69f0d7ed202678.origin ) )
    {
        level.var_35d9b730f05b999d = snd::play( "evt_mx_saferoom_classical", var_5f69f0d7ed202678.origin );
        utility::flag_set( "flag_cancer_saferoom_music_started" );
        cancer_mission waittill( #"hash_cb417506fb764fb2" );
        snd::stop( level.var_35d9b730f05b999d );
        level.var_35d9b730f05b999d = undefined;
        utility::flag_clear( "flag_cancer_saferoom_music_started" );
        var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
        
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            player function_95c8146c48e8b44f( cancer_mission );
        }
    }
}

// Namespace cancer
// Params 1
// Checksum 0x47dd21da, Offset: 0xc85b
// Size: 0x181
function function_24937c38eca312d6( cancer_mission )
{
    cancer_mission endon( #"reset" );
    cancer_mission endon( #"hash_924bee8343f36b42" );
    level thread function_4b3fada1990a8b35( cancer_mission, "trig_cancer_penthouse_enter", "notify_cancer_penthouse_start_music" );
    cancer_mission waittill( #"notify_cancer_penthouse_start_music" );
    level thread function_4f2bbb39e7ff5e3c( cancer_mission );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( cancer_mission.team, cancer_mission.sessionsquadid );
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        player function_95c8146c48e8b44f( cancer_mission );
    }
    
    if ( !utility::flag( "flag_cancer_saferoom_bookcase_opening" ) )
    {
        utility::flag_wait( "flag_cancer_saferoom_bookcase_opening" );
        
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            player function_95c8146c48e8b44f( cancer_mission );
        }
    }
}

// Namespace cancer
// Params 1, eflags: 0x4
// Checksum 0xe47151ce, Offset: 0xc9e4
// Size: 0xaa
function private function_cddb50034003950e( var_cd7e11dc688992d4 )
{
    var_cd7e11dc688992d4 endon( #"reset" );
    
    if ( getdvarint( @"hash_5f6ca140af42ebad", 0 ) )
    {
        return;
    }
    
    utility::flag_wait( "flag_cancer_setup_complete" );
    
    if ( !getdvarint( @"hash_e3fc9f81504917a1", 0 ) )
    {
        if ( !isdefined( level.cancer_oob_volumes ) )
        {
            level.cancer_oob_volumes = getnoentvolumearray( "cancer_oob_volume", #targetname );
        }
    }
    
    var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
    childthread story_contract_util::function_cddb50034003950e( var_64bb57aa2d6e8b35, level.cancer_oob_volumes );
}

