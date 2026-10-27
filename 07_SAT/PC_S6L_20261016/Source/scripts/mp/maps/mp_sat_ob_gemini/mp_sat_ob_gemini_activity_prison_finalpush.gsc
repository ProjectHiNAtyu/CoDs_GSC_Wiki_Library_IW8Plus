// scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_activity_prison_finalpush.gsc  (hash_61ec20548f3fb2e2.gscc) (size: 23944 Bytes / 0x5d88 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x78db71d2 (2027647442)
// size ...... 23944 (0x5d88)
// includes .. 28  (offset: 0x5744)
// strings ... 72  (offset: 0x5824)
// dev strs .. 13  (offset: 0x5cec)
// exports ... 61  (offset: 0x3598)
// cseg ...... 0x97f + 0x2c19 (0x3598)
// imports ... 198 (offset: 0x3f20)
// animtree1 . 0   (offset: 0x5d88)
// animtree2 . 0   (offset: 0x5d88)
#using script_16d8789bae43669e;
#using script_3edd59d0d3fc3262;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\callbacks;
#using scripts\common\hud_util;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\visibility_mode;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_activity_prison_armory;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_activity_prison_topside;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_scenes;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_util;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_vo;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_vtol;
#using scripts\mp\ob\contracts\ob_contract_ui_widget;
#using scripts\mp\outofbounds;

#namespace namespace_876a8ceeff77ab5c;

// Namespace namespace_876a8ceeff77ab5c
// Params 0, eflags: 0x5
// Checksum 0x996b2f3f, Offset: 0x99d
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_200236ef42fe7844", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_876a8ceeff77ab5c
// Params 0, eflags: 0x4
// Checksum 0xe81ab310, Offset: 0x9c6
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_GEMINI_PRISON_FINALPUSH";
    activity_common::registeractivitytype( "OB_GEMINI_PRISON_FINALPUSH", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_PRISON_FINALPUSH", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_PRISON_FINALPUSH", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_PRISON_FINALPUSH", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_GEMINI_PRISON_FINALPUSH" );
}

// Namespace namespace_876a8ceeff77ab5c
// Params 0
// Checksum 0xa6fe4c51, Offset: 0xa3d
// Size: 0x59
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance prison_finalpush_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_876a8ceeff77ab5c
// Params 0
// Checksum 0xc044c1f2, Offset: 0xa9e
// Size: 0x168
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance prison_finalpush_main();
    story_contract_util::mark_complete( level.players, #"gemini_complete" );
    ob_contract_ui_widget::completed( level.players );
    activity_instance thread namespace_60d9b3cbf41663fe::function_851e601bc3ae7892();
    level utility::flag_wait( "flag_gemini_exfil_igc_complete" );
    
    if ( ob::nightmare() )
    {
        ob_story_mission_utils::function_f20a9fe6c594f5b3( 0 );
        
        foreach ( player in level.players )
        {
            player thread hud_util::fade_in( 0.5, "black" );
            player utility::callsharedfunc( #"hash_561b73e89e879cb7", #"hash_3fa3c8cca94e4308", "gemini" );
        }
        
        origin = ( -55664, 4426, -100 );
        angles = ( 0, 130, 0 );
        ob_story_mission_utils::function_e1f7ae6f70c4b0c1( origin, angles, undefined, "OB_GEMINI_PRISON_FINALPUSH" );
    }
    
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_876a8ceeff77ab5c
// Params 0
// Checksum 0xa6793ffd, Offset: 0xc0e
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_876a8ceeff77ab5c
// Params 1
// Checksum 0x7591a31d, Offset: 0xc32
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread prison_finalpush_player_setup( player );
    }
}

// Namespace namespace_876a8ceeff77ab5c
// Params 0
// Checksum 0x3d776108, Offset: 0xcee
// Size: 0x44
function prison_finalpush_start()
{
    activity_instance = self;
    gemini_util::function_34a3d0cff5de2d7d();
    gemini_util::function_dfcbf5f9b3b2e6a0();
    namespace_325e21231ce5a0e0::function_d777c22ec9110368();
    level.onplayerdamaged = &gemini_util::function_24410a0d29b3ba36;
    activity_instance thread namespace_31b2bab150bfb17a::function_e879f3e7b663d371();
    activity_instance thread namespace_325e21231ce5a0e0::function_5e9eddeb41a2b4d7();
}

// Namespace namespace_876a8ceeff77ab5c
// Params 0
// Checksum 0x3adbaa59, Offset: 0xd3a
// Size: 0x22a
function prison_finalpush_main()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    level.var_d53163b0ef2a4488 = 1;
    
    if ( !isdefined( level.var_122bf6634835c678 ) )
    {
        level.var_122bf6634835c678 = 0;
    }
    
    player_list = ob_story_mission_utils::get_playing_players();
    level callback::add( #"player_spawned", &function_f71d6f2babaf0b7b );
    createthreatbiasgroup( "threatbias_prison_soldier" );
    createthreatbiasgroup( "threatbias_prison_zombie" );
    setthreatbias( "threatbias_prison_zombie", "threatbias_prison_soldier", 1000 );
    
    if ( !isdefined( level.finalpush_enemy_soldiers ) )
    {
        level.finalpush_enemy_soldiers = spawnstruct();
        
        if ( !isdefined( level.finalpush_enemy_soldiers.ai_array ) )
        {
            level.finalpush_enemy_soldiers.ai_array = [];
        }
    }
    
    if ( !isdefined( level.var_12336cd7b84a33dd ) )
    {
        level.var_12336cd7b84a33dd = spawnstruct();
        
        if ( !isdefined( level.var_12336cd7b84a33dd.ai_array ) )
        {
            level.var_12336cd7b84a33dd.ai_array = [];
        }
    }
    
    activity_instance function_fdc9e03eabad95d2();
    activity_instance function_e679a3b77f51e252();
    waitframe();
    activity_instance childthread function_81f1d55ce5ad4a92();
    waitframe();
    activity_instance childthread function_787faa913a72abf7();
    activity_instance thread function_deaee867d40697e9();
    activity_instance thread function_3bccaedc16c222ba();
    activity_instance childthread function_50473185e4347f1c();
    activity_instance childthread gemini_vo::function_af9f9f93f3b61bc3();
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_finalpush_weapon", undefined, 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_finalpush_equipment", undefined, 1 );
    activity_instance thread function_6fe05474c822f5be();
    level.onplayerdamaged = undefined;
    activity_instance childthread function_f0dce3309e80c62f();
    level utility::flag_wait_all( "flag_finalpush_barrier_threshold_reached", "flag_prison_finalpush_outro_vo_end" );
    story_contract_util::mark_complete( level.players, #"gemini_complete" );
    story_contract_util::achievement_activities( level.players, "sat_wc_mission8and9", [ #"cancer_outro", #"gemini_complete" ] );
    wait 4;
    level utility::flag_set( "flag_gemini_exfil_igc_begin" );
    level thread gemini_util::delete_all_ai( 1 );
}

// Namespace namespace_876a8ceeff77ab5c
// Params 1
// Checksum 0x1034fab0, Offset: 0xf6c
// Size: 0x51
function prison_finalpush_player_setup( player )
{
    activity_instance = self;
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        player thread gemini_util::player_cold_breath_toggle( "flag_gemini_exfil_igc_begin" );
        player thread gemini_util::prison_ai_corpse_cleanup();
        player thread gemini_util::function_bbf656a0b4c64354();
    }
}

// Namespace namespace_876a8ceeff77ab5c
// Params 0, eflags: 0x4
// Checksum 0xa245a52a, Offset: 0xfc5
// Size: 0x111
function private function_fdc9e03eabad95d2()
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance thread function_4e66a7e2349534ff();
    
    if ( !isdefined( a_far_players ) )
    {
        a_far_players = [];
    }
    
    var_cfdde791f058f707 = utility::getstruct( "player_catchup_prison_finalpush", "targetname" );
    
    foreach ( player in level.players )
    {
        if ( distance2d( player.origin, var_cfdde791f058f707.origin ) > 2000 )
        {
            if ( isdefined( player ) )
            {
                a_far_players = arraycombineunique( a_far_players, [ player ] );
            }
        }
    }
    
    if ( a_far_players.size <= 0 )
    {
        return;
    }
    
    activity_instance thread namespace_1f3f9eb1e9681da5::init_player_catchup( activity_instance, "player_catchup_prison_finalpush", "flag_finalpush_player_catchup_complete", a_far_players );
}

// Namespace namespace_876a8ceeff77ab5c
// Params 0, eflags: 0x4
// Checksum 0xef973a86, Offset: 0x10de
// Size: 0xaf
function private function_4e66a7e2349534ff()
{
    level endon( #"game_ended" );
    
    if ( !isdefined( level.var_55debfdcf33e2ec0 ) )
    {
        level.var_55debfdcf33e2ec0 = getentarray( "v_oob_finalpush", #script_noteworthy );
    }
    
    foreach ( vol in level.var_55debfdcf33e2ec0 )
    {
        outofbounds::function_ea64b5c2bd16e0f5( vol );
    }
    
    waitframe();
}

// Namespace namespace_876a8ceeff77ab5c
// Params 0, eflags: 0x4
// Checksum 0xcf1cef55, Offset: 0x1195
// Size: 0x21
function private function_f0dce3309e80c62f()
{
    level utility::flag_wait_all( "flag_prison_finalpush_completed", "flag_prison_blockade_defeated" );
    level utility::flag_set( "flag_finalpush_all_enemies_cleared" );
}

/#

    // Namespace namespace_876a8ceeff77ab5c
    // Params 0
    // Checksum 0xb38e8cb3, Offset: 0x11be
    // Size: 0x5, Type: dev
    function function_bd35a25defaa37c7()
    {
        
    }

#/

// Namespace namespace_876a8ceeff77ab5c
// Params 0, eflags: 0x4
// Checksum 0xc9ac99a0, Offset: 0x11cb
// Size: 0xa0
function private function_81f1d55ce5ad4a92()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    activity_instance thread function_e6728281745fd7d0( "sat_sm04_gemini_ai_encounter_finalpush_allyzombies", 20, 0 );
    wait 1;
    activity_instance thread function_e6728281745fd7d0( "sat_sm04_gemini_ai_encounter_finalpush_allyzombies_lowerprio", 20, 1 );
    wait 1;
    activity_instance thread function_e6728281745fd7d0( "sat_sm04_gemini_ai_encounter_finalpush_allyzombies_lowerprio2", 15, 0 );
    wait 1;
    activity_instance thread function_e6728281745fd7d0( "sat_sm04_gemini_ai_encounter_finalpush_allyzombies_lowerprio3", 15, 1 );
    wait 1;
    activity_instance thread function_e6728281745fd7d0( "sat_sm04_gemini_ai_encounter_finalpush_allyzombies_lowerprio4", 15, 0 );
}

// Namespace namespace_876a8ceeff77ab5c
// Params 0
// Checksum 0xa7018aba, Offset: 0x1273
// Size: 0xca
function function_787faa913a72abf7()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    utility::flag_wait( "flag_finalpush_barrier_attractor_start" );
    var_ed2af0b701bd5b7e = activity_instance activity_ai_encounters::function_92b671064b0b1ce2( "sat_sm04_gemini_ai_encounter_finalpush_allyzombies_flooding", 0, 1, 1, 1 );
    activity_ai_encounters::function_52d1342183200a8f( var_ed2af0b701bd5b7e, &function_ffc77b91e71c5258 );
    activity_ai_encounters::function_dcf6bdb6ee9d1ca0( var_ed2af0b701bd5b7e, &function_9919d1e940edcfd );
    activity_ai_encounters::function_d33de057e760c97b( var_ed2af0b701bd5b7e, &function_9f2292f7261322bd );
    function_bbd192652d1a9e18( var_ed2af0b701bd5b7e, 4 );
    function_a748fd0f51127844( var_ed2af0b701bd5b7e, 3 );
    activity_ai_encounters::function_48582991402cac50( var_ed2af0b701bd5b7e, 1 );
    activity_instance thread function_678a60eea3fd8472( var_ed2af0b701bd5b7e );
    utility::flag_wait( "flag_finalpush_barrier_attractor_escalate" );
    function_bbd192652d1a9e18( var_ed2af0b701bd5b7e, 6 );
    function_a748fd0f51127844( var_ed2af0b701bd5b7e, 1 );
}

// Namespace namespace_876a8ceeff77ab5c
// Params 3, eflags: 0x4
// Checksum 0x16ea254e, Offset: 0x1345
// Size: 0xf4
function private function_e6728281745fd7d0( ai_encounter_targetname, var_939a6122b3f49ea1 = 15, forward_cycling = 1 )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    request_id = activity_instance activity_ai_encounters::function_92b671064b0b1ce2( ai_encounter_targetname, 0, 1, 1, 1 );
    activity_ai_encounters::function_52d1342183200a8f( request_id, &function_ffc77b91e71c5258 );
    activity_ai_encounters::function_dcf6bdb6ee9d1ca0( request_id, &function_9919d1e940edcfd );
    activity_ai_encounters::function_d33de057e760c97b( request_id, &function_9f2292f7261322bd );
    
    while ( !utility::flag( "flag_gemini_exfil_igc_begin" ) )
    {
        count_all_ai = getaicount();
        
        if ( count_all_ai <= var_939a6122b3f49ea1 )
        {
            activity_ai_encounters::function_48582991402cac50( request_id, 1 );
            break;
        }
        
        wait 5;
    }
    
    if ( !utility::flag( "flag_gemini_exfil_igc_begin" ) && forward_cycling == 1 )
    {
        activity_instance thread function_678a60eea3fd8472( request_id );
    }
}

// Namespace namespace_876a8ceeff77ab5c
// Params 4, eflags: 0x4
// Checksum 0x25d76286, Offset: 0x1441
// Size: 0x160
function private function_ffc77b91e71c5258( requestid, instance, agent, userdata )
{
    level endon( #"game_ended" );
    agent endon( #"death" );
    agent gemini_util::function_376f4cf6d212ef9b( 5 );
    agent setthreatbiasgroup( "threatbias_prison_zombie" );
    agent childthread gemini_util::function_11266ff8ae084f14( "flag_prison_blockade_half_defeated" );
    agent childthread function_813d4b3d43ae001a();
    
    if ( !isdefined( level.vol_finalpush_soldier_main ) )
    {
        level.vol_finalpush_soldier_main = getent( "vol_finalpush_soldier_main", #targetname );
    }
    
    agent function_fa32376aaa88a7a2( level.vol_finalpush_soldier_main.origin, 3000 );
    level utility::flag_wait_any( "flag_prison_finalpush_completed", "flag_prison_blockade_half_defeated" );
    
    if ( utility::flag( "flag_prison_finalpush_completed" ) )
    {
        level utility::flag_wait( "flag_prison_blockade_half_defeated" );
    }
    else
    {
        level utility::flag_wait_any( "flag_finalpush_vtol_half_dead", "flag_prison_blockade_defeated" );
    }
    
    agent notify( #"hash_755d26458a238372" );
    agent.attackeraccuracy = 0.1;
    level utility::flag_wait( "flag_prison_blockade_defeated" );
    agent clearbtgoal( 0 );
    waitframe();
    
    if ( !isdefined( level.vol_finalpush_soldier_fallback ) )
    {
        level.vol_finalpush_soldier_fallback = getent( "vol_finalpush_soldier_fallback", #targetname );
    }
    
    agent function_dd3b2de3b28ea995( 0, level.vol_finalpush_soldier_fallback );
}

// Namespace namespace_876a8ceeff77ab5c
// Params 0, eflags: 0x4
// Checksum 0x8283e617, Offset: 0x15a9
// Size: 0xa9
function private function_813d4b3d43ae001a()
{
    level endon( #"game_ended", #"flag_prison_finalpush_completed" );
    self endon( #"death", #"hash_755d26458a238372" );
    
    if ( utility::flag( "flag_prison_finalpush_completed" ) )
    {
        return;
    }
    
    while ( isalive( self ) )
    {
        if ( !utility::flag( "flag_prison_blockade_defeated" ) || level.players.size > 2 )
        {
            gemini_util::function_f53463c3213de6a1( "s_finalpush_breakable_barrier", undefined, 20, 10 );
            wait randomfloatrange( 1, 9 );
            continue;
        }
        
        gemini_util::function_f53463c3213de6a1( "s_finalpush_breakable_barrier", undefined, 25, 15 );
        wait randomfloatrange( 5, 15 );
    }
}

// Namespace namespace_876a8ceeff77ab5c
// Params 2, eflags: 0x4
// Checksum 0x8c097930, Offset: 0x165a
// Size: 0x72, Type: bool
function private function_9919d1e940edcfd( requestid, userdata )
{
    count_all_ai = getaicount();
    n_count = 15;
    
    if ( utility::flag( "flag_prison_blockade_defeated" ) || utility::flag( "flag_prison_finalpush_completed" ) )
    {
        if ( utility::flag( "flag_prison_blockade_defeated" ) )
        {
            n_count = 25;
        }
        else
        {
            n_count = 20;
        }
    }
    
    if ( count_all_ai > n_count )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_876a8ceeff77ab5c
// Params 2, eflags: 0x4
// Checksum 0x15f8a675, Offset: 0x16d5
// Size: 0x27, Type: bool
function private function_9f2292f7261322bd( requestid, userdata )
{
    if ( utility::flag( "flag_gemini_exfil_igc_begin" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_876a8ceeff77ab5c
// Params 1
// Checksum 0x1f523c3f, Offset: 0x1705
// Size: 0x15c
function function_678a60eea3fd8472( requestid )
{
    activity_instance = self;
    level endon( #"game_ended" );
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( utility::flag( "flag_gemini_exfil_igc_begin" ) )
    {
        return;
    }
    
    level endon( #"flag_gemini_exfil_igc_begin" );
    s_finalpush_breakable_barrier = utility::getstruct( "s_finalpush_breakable_barrier", "targetname" );
    forward_pos = s_finalpush_breakable_barrier.origin;
    distance_buffer = 512;
    
    while ( !utility::flag( "flag_finalpush_barrier_attractor_start" ) )
    {
        var_22b65f6dbdf06919 = utility::function_4325398d215ecda5( forward_pos, activity_instance.playerparticipants );
        function_28fe15d9e2bfab0d( requestid );
        
        if ( !isent( var_22b65f6dbdf06919 ) || !isplayer( var_22b65f6dbdf06919 ) )
        {
            wait 2;
            continue;
        }
        
        function_c505198907e0d306( requestid, var_22b65f6dbdf06919, 1 );
        activity_instance function_f1ec9a465a773086( forward_pos, var_22b65f6dbdf06919, distance_buffer, requestid );
        wait 2;
    }
    
    waitframe();
    s_finalpush_zombie_floodfill_front = utility::getstruct( "s_finalpush_zombie_floodfill_front", "targetname" );
    
    if ( isdefined( s_finalpush_zombie_floodfill_front ) )
    {
        spawn_pos = s_finalpush_zombie_floodfill_front.origin;
        radius = 512;
    }
    else
    {
        spawn_pos = forward_pos;
        radius = 768;
    }
    
    function_1ac3703e7bc56a8( requestid, spawn_pos, radius, 1 );
}

// Namespace namespace_876a8ceeff77ab5c
// Params 4, eflags: 0x4
// Checksum 0x5ddec425, Offset: 0x1869
// Size: 0x168
function private function_f1ec9a465a773086( forward_pos, var_22b65f6dbdf06919, distance_buffer, requestid )
{
    var_1f30ece26f79f525 = distance2d( forward_pos, var_22b65f6dbdf06919.origin ) + distance_buffer;
    data = function_9b649316adcccbaa( requestid );
    b_fast_despawn = 0;
    
    if ( data.ai.size > 3 )
    {
        b_fast_despawn = 1;
    }
    
    foreach ( ai in data.ai )
    {
        if ( isdefined( ai ) )
        {
            players = getplayersinradius( ai.origin, 256 );
            
            if ( players.size > 0 )
            {
                waitframe();
                continue;
            }
            
            var_778463950afa2a8e = distance2d( forward_pos, ai.origin );
            
            if ( var_778463950afa2a8e > var_1f30ece26f79f525 )
            {
                ai gemini_util::ai_zombie_despawn();
                
                if ( b_fast_despawn )
                {
                    wait randomfloatrange( 0.1, 0.9 );
                }
                else
                {
                    wait randomfloatrange( 0.5, 1.5 );
                }
            }
        }
        
        waitframe();
    }
}

/#

    // Namespace namespace_876a8ceeff77ab5c
    // Params 0
    // Checksum 0xb1cf3ff8, Offset: 0x19d9
    // Size: 0x5, Type: dev
    function function_75a45b38e9980e4c()
    {
        
    }

#/

// Namespace namespace_876a8ceeff77ab5c
// Params 0, eflags: 0x4
// Checksum 0x9925dba4, Offset: 0x19e6
// Size: 0xf0
function private function_e679a3b77f51e252()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    request_id_soldiers_blockade = activity_instance activity_ai_encounters::function_92b671064b0b1ce2( "sat_sm04_gemini_ai_encounter_finalpush_soldiers_blockade", 0, 1, 1, 2 );
    activity_ai_encounters::function_52d1342183200a8f( request_id_soldiers_blockade, &function_98f298244f432b18, level.var_12336cd7b84a33dd );
    activity_ai_encounters::function_48582991402cac50( request_id_soldiers_blockade, 1 );
    activity_ai_encounters::function_6bf4ff2fbde584ee( request_id_soldiers_blockade, &function_d2c8b523f9361448 );
    request_id_soldiers = activity_instance activity_ai_encounters::function_92b671064b0b1ce2( "sat_sm04_gemini_ai_encounter_finalpush_soldiers", 0, 1, 1, 2 );
    waitframe();
    activity_instance childthread function_ac029bb9c53e044c();
    waitframe();
    activity_ai_encounters::function_52d1342183200a8f( request_id_soldiers, &function_98f298244f432b18, level.finalpush_enemy_soldiers );
    activity_ai_encounters::function_dcf6bdb6ee9d1ca0( request_id_soldiers, &function_9297e038b51aaabd );
    activity_ai_encounters::function_d33de057e760c97b( request_id_soldiers, &function_a44b21f2c76f407d );
    activity_ai_encounters::function_48582991402cac50( request_id_soldiers, 1 );
    level thread function_d369f50da5bdaaa4( request_id_soldiers );
}

// Namespace namespace_876a8ceeff77ab5c
// Params 2, eflags: 0x4
// Checksum 0xde94b96, Offset: 0x1ade
// Size: 0x27, Type: bool
function private function_9297e038b51aaabd( requestid, userdata )
{
    if ( utility::flag( "flag_prison_finalpush_completed" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_876a8ceeff77ab5c
// Params 2, eflags: 0x4
// Checksum 0x35ec4daa, Offset: 0x1b0e
// Size: 0x31, Type: bool
function private function_a44b21f2c76f407d( requestid, userdata )
{
    if ( utility::flag( "flag_prison_finalpush_completed" ) )
    {
        ai_spawn_director::cancel_spawn_request( requestid, 0 );
        return true;
    }
    
    return false;
}

// Namespace namespace_876a8ceeff77ab5c
// Params 4, eflags: 0x4
// Checksum 0x688f5931, Offset: 0x1b48
// Size: 0x178
function private function_98f298244f432b18( requestid, instance, agent, userdata )
{
    level endon( #"game_ended" );
    agent endon( #"death" );
    
    if ( isstruct( instance ) )
    {
        agent thread gemini_util::function_7653e4bbe774fb50( instance );
    }
    
    agent setthreatbiasgroup( "threatbias_prison_soldier" );
    agent.noragdoll = 0;
    agent agent_utils::function_1874e18b42e6d814( &gemini_util::function_cb3d5af3567a0360 );
    
    if ( isdefined( agent.directorspawndata.script_noteworthy ) )
    {
        switch ( agent.directorspawndata.script_noteworthy )
        {
            case #"hash_c9ce32066612c729":
                agent.var_ee914ad666562200 = 1;
                agent.dontmeleeme = 0;
                agent thread function_903a26c4866ff08();
                agent thread gemini_util::function_7653e4bbe774fb50( level.var_12336cd7b84a33dd );
                break;
            case #"hash_5750d6ce52be2eda":
                agent.ignoreme = 1;
                agent thread function_58941304f7698c06();
                agent thread gemini_util::function_7653e4bbe774fb50( level.finalpush_enemy_soldiers );
                break;
            default:
                break;
        }
    }
    else
    {
        agent thread gemini_util::function_7653e4bbe774fb50( level.finalpush_enemy_soldiers );
    }
    
    level utility::flag_wait( "flag_prison_finalpush_completed" );
    agent gemini_util::ai_nerf();
    agent.zombie_dmg_multiplier = 3;
}

// Namespace namespace_876a8ceeff77ab5c
// Params 1, eflags: 0x4
// Checksum 0x8c697a23, Offset: 0x1cc8
// Size: 0x3c
function private function_d369f50da5bdaaa4( requestid )
{
    level endon( #"game_ended" );
    level utility::flag_wait( "flag_prison_finalpush_completed" );
    ai_spawn_director::cancel_spawn_request( requestid, 0 );
    level utility::flag_set( "flag_finalpush_soldiers_defeated" );
}

// Namespace namespace_876a8ceeff77ab5c
// Params 2, eflags: 0x4
// Checksum 0xdb8b020a, Offset: 0x1d0c
// Size: 0x21
function private function_d2c8b523f9361448( requestid, userdata )
{
    utility::flag_set( "flag_prison_blockade_spawned" );
}

// Namespace namespace_876a8ceeff77ab5c
// Params 0, eflags: 0x4
// Checksum 0xe6b34f8f, Offset: 0x1d35
// Size: 0xea
function private function_ac029bb9c53e044c()
{
    activity_instance = self;
    utility::flag_wait( "flag_prison_blockade_spawned" );
    assert( isdefined( level.var_12336cd7b84a33dd ), "<dev string:x24>" );
    var_c66b1cb0f8ad3bd3 = level.var_12336cd7b84a33dd.ai_array.size;
    var_8914a6e73b1971cd = int( var_c66b1cb0f8ad3bd3 * 0.5 ) + 1;
    
    while ( level.var_12336cd7b84a33dd.ai_array.size > 0 )
    {
        waitframe();
        level.var_12336cd7b84a33dd gemini_util::ai_array_cleanup( "soldier" );
        
        if ( !utility::flag( "flag_prison_blockade_half_defeated" ) && level.var_12336cd7b84a33dd.ai_array.size <= var_8914a6e73b1971cd )
        {
            utility::flag_set( "flag_prison_blockade_half_defeated" );
        }
    }
    
    utility::flag_set( "flag_prison_blockade_defeated" );
    
    /#
        iprintlnbold( "<dev string:x60>" );
    #/
}

// Namespace namespace_876a8ceeff77ab5c
// Params 0, eflags: 0x4
// Checksum 0x1ae8587c, Offset: 0x1e27
// Size: 0x7c
function private function_903a26c4866ff08()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    utility::flag_wait( "flag_prison_finalpush_completed" );
    gemini_util::ai_nerf();
    self.var_ee914ad666562200 = 0;
    wait randomfloatrange( 1, 9 );
    
    if ( !isdefined( level.vol_finalpush_soldier_fallback ) )
    {
        level.vol_finalpush_soldier_fallback = getent( "vol_finalpush_soldier_fallback", #targetname );
    }
    
    self setgoalvolumeauto( level.vol_finalpush_soldier_fallback );
}

// Namespace namespace_876a8ceeff77ab5c
// Params 0, eflags: 0x4
// Checksum 0x626743b6, Offset: 0x1eab
// Size: 0x5f
function private function_58941304f7698c06()
{
    self endon( #"death" );
    utility::flag_wait( "flag_barrels_exploded" );
    forward_vector = anglestoforward( self.angles );
    self kill();
    corpse = self getcorpseentity();
    
    if ( corpse )
    {
        corpse startragdollfromimpact( "torso_upper", forward_vector * 9000 );
    }
}

/#

    // Namespace namespace_876a8ceeff77ab5c
    // Params 0
    // Checksum 0x734ec76d, Offset: 0x1f12
    // Size: 0x5, Type: dev
    function function_2876cdab424714e0()
    {
        
    }

#/

// Namespace namespace_876a8ceeff77ab5c
// Params 0
// Checksum 0x168483f4, Offset: 0x1f1f
// Size: 0x108
function function_6fe05474c822f5be()
{
    activity_instance = self;
    level.s_finalpush_breakable_barrier = utility::getstruct( "s_finalpush_breakable_barrier", "targetname" );
    level.s_finalpush_breakable_barrier.sm_barrier = getent( "sm_finalpush_breakable_barrier", #targetname );
    level.s_finalpush_breakable_barrier.sbm_barrier = getent( "sbm_finalpush_breakable_barrier", #targetname );
    level.s_finalpush_breakable_barrier.var_5726d1f0f4c7a0d7 = utility::getstructarray( "s_finalpush_breakable_barrier_att_points", "targetname" );
    level.s_finalpush_breakable_barrier.var_db4919a4ebd1797f = 0;
    level utility::flag_wait_any( "flag_prison_finalpush_completed", "flag_prison_blockade_defeated" );
    
    if ( utility::flag( "flag_prison_finalpush_completed" ) )
    {
        level utility::flag_wait( "flag_prison_blockade_half_defeated" );
    }
    
    level.onplayerdamaged = undefined;
    activity_instance thread function_41a9b2fa98c26b45( level.s_finalpush_breakable_barrier );
    activity_instance thread function_3cee6c8b67681c47();
    activity_instance thread function_b493b3c6a3cabd36();
}

// Namespace namespace_876a8ceeff77ab5c
// Params 0, eflags: 0x4
// Checksum 0xbf649154, Offset: 0x202f
// Size: 0x101
function private function_b493b3c6a3cabd36()
{
    level endon( #"game_ended" );
    utility::flag_wait( "flag_prison_finalpush_outro_vo_end" );
    
    /#
        iprintlnbold( "<dev string:x88>" + 5 );
    #/
    
    n_start_time = gettime();
    var_355aa9f02125ac58 = 0;
    n_timeout = 5;
    var_db921c40879d9501 = 10;
    
    while ( true )
    {
        /#
            if ( getdvarint( @"hash_90b8a0d6d446704a", 0 ) )
            {
                iprintlnbold( "<dev string:xae>" + level.var_1aca9388b6f0b5ab.var_db4919a4ebd1797f );
            }
        #/
        
        if ( gettime() > n_start_time + utility::function_4b74c15943231980( n_timeout ) )
        {
            var_355aa9f02125ac58 = 1;
            break;
        }
        
        if ( level.var_1aca9388b6f0b5ab.var_db4919a4ebd1797f >= var_db921c40879d9501 )
        {
            break;
        }
        
        wait 0.5;
    }
    
    if ( var_355aa9f02125ac58 )
    {
        /#
            iprintlnbold( "<dev string:xd0>" );
        #/
    }
    else
    {
        /#
            iprintlnbold( "<dev string:xef>" );
        #/
    }
    
    utility::flag_set( "flag_finalpush_barrier_threshold_reached" );
}

// Namespace namespace_876a8ceeff77ab5c
// Params 2, eflags: 0x4
// Checksum 0xe5e02bec, Offset: 0x2138
// Size: 0x167
function private function_41a9b2fa98c26b45( var_dff548c3090b7c3b, var_a2d856f418c07d6a )
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    sm_barrier = var_dff548c3090b7c3b.sm_barrier;
    sbm_barrier = var_dff548c3090b7c3b.sbm_barrier;
    var_a2d856f418c07d6a = var_dff548c3090b7c3b.var_5726d1f0f4c7a0d7;
    activity_instance thread function_223605a945dab083( var_dff548c3090b7c3b );
    activity_instance thread function_4d9933e62d488427( var_dff548c3090b7c3b );
    activity_instance thread function_6b72d569313dfaa1( sm_barrier );
    
    /#
        iprintlnbold( "<dev string:x121>" );
    #/
    
    utility::flag_set( "flag_finalpush_barrier_attractor_start" );
    s_attackable = zombie_attractor_manager::add_attractor( var_dff548c3090b7c3b, 3, 3072, 1, undefined, &function_95fb8291b63b4dec, 0, "team_hundred_ninety" );
    zombie_attractor_manager::function_4c34b0f066a9d9fe( s_attackable, 90 );
    zombie_attractor_manager::set_attractor_slots( s_attackable, var_a2d856f418c07d6a );
    zombie_attractor_manager::function_e8b05e26d8b2ede( s_attackable, sm_barrier );
    
    foreach ( slot in var_a2d856f418c07d6a )
    {
        level thread function_4c0b33ed5e18655e( slot );
    }
}

// Namespace namespace_876a8ceeff77ab5c
// Params 1, eflags: 0x4
// Checksum 0x2b76d72a, Offset: 0x22a7
// Size: 0xc4
function private function_4c0b33ed5e18655e( slot )
{
    level endon( #"game_ended" );
    
    /#
        if ( getdvarint( @"hash_90b8a0d6d446704a", 0 ) )
        {
            level childthread function_377b8cb5ab38737f( slot );
        }
    #/
    
    while ( isdefined( slot ) )
    {
        if ( isdefined( slot.var_80be1da0fa595ce1 ) )
        {
            slot.var_80be1da0fa595ce1 utility::ent_flag_set( "zombie_moving_to_finalpush_attractor" );
            var_1f40d481e32db471 = distance2dsquared( slot.var_80be1da0fa595ce1.origin, slot.origin );
            
            if ( var_1f40d481e32db471 < 1024 )
            {
                slot.var_80be1da0fa595ce1 utility::ent_flag_set( "zombie_at_finalpush_attractor" );
                function_b28de3d1de3019c3( slot );
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_876a8ceeff77ab5c
// Params 1, eflags: 0x4
// Checksum 0xb82df4a1, Offset: 0x2373
// Size: 0x8b
function private function_b28de3d1de3019c3( slot )
{
    level endon( #"game_ended" );
    level.s_finalpush_breakable_barrier.var_db4919a4ebd1797f++;
    
    if ( isdefined( slot.var_80be1da0fa595ce1 ) )
    {
        agent = slot.var_80be1da0fa595ce1;
        
        while ( true )
        {
            if ( !isdefined( agent ) || agent.target_attractor_slot != slot )
            {
                break;
            }
            
            waitframe();
        }
    }
    
    level.s_finalpush_breakable_barrier.var_db4919a4ebd1797f--;
}

// Namespace namespace_876a8ceeff77ab5c
// Params 2, eflags: 0x4
// Checksum 0x62ab80d3, Offset: 0x2406
// Size: 0x274
function private function_377b8cb5ab38737f( slot, b_spectator = 0 )
{
    level endon( #"game_ended" );
    
    if ( b_spectator )
    {
        move_color = ( 0, 1, 1 );
        reach_color = ( 0.5, 0, 1 );
    }
    else
    {
        move_color = ( 0, 0, 1 );
        reach_color = ( 1, 0, 0 );
    }
    
    index = slot.script_index;
    
    while ( true )
    {
        if ( !isdefined( slot.var_80be1da0fa595ce1 ) )
        {
            wait 0.1;
            continue;
        }
        
        if ( slot.var_80be1da0fa595ce1 utility::ent_flag( "zombie_at_finalpush_attractor" ) )
        {
            /#
                slot.var_80be1da0fa595ce1 thread gemini_util::debug_draw_sphere( slot.origin, 32, 0.1, reach_color );
                slot.var_80be1da0fa595ce1 thread gemini_util::function_c00e991359ce19d9( "<dev string:x148>" + index, slot.var_80be1da0fa595ce1.origin + ( 0, 0, 72 ), reach_color, 1, 0.5, 0.1 );
                slot.var_80be1da0fa595ce1 thread gemini_util::function_c00e991359ce19d9( index, slot.origin + ( 0, 0, 96 ), reach_color, 1, 1, 0.1 );
            #/
        }
        else
        {
            /#
                slot.var_80be1da0fa595ce1 thread gemini_util::debug_draw_line( slot.var_80be1da0fa595ce1.origin, slot.origin, 0.1, move_color );
                slot.var_80be1da0fa595ce1 thread gemini_util::debug_draw_sphere( slot.origin, 32, 0.1, move_color );
                slot.var_80be1da0fa595ce1 thread gemini_util::function_c00e991359ce19d9( "<dev string:x158>" + index, slot.var_80be1da0fa595ce1.origin + ( 0, 0, 72 ), move_color, 1, 0.5, 0.1 );
                slot.var_80be1da0fa595ce1 thread gemini_util::function_c00e991359ce19d9( index, slot.origin + ( 0, 0, 96 ), move_color, 1, 1, 0.1 );
            #/
        }
        
        wait 0.1;
    }
}

// Namespace namespace_876a8ceeff77ab5c
// Params 0, eflags: 0x4
// Checksum 0x795c86b8, Offset: 0x2682
// Size: 0x112
function private function_3cee6c8b67681c47()
{
    level endon( #"game_ended" );
    utility::flag_wait_all( "flag_finalpush_vtol_half_dead", "flag_finalpush_barrier_attractor_start" );
    s_spectator = utility::getstruct( "s_finalpush_spectator", "targetname" );
    var_18abf64ea4bec417 = utility::getstructarray( "s_finalpush_spectator_slot", "targetname" );
    
    if ( !isdefined( s_spectator ) )
    {
        return;
    }
    
    attractor_spectator = zombie_attractor_manager::add_attractor( s_spectator, 0, 4500, 0, undefined, &function_f19a58a9133df926, 0, "team_hundred_ninety", 0 );
    zombie_attractor_manager::set_attractor_slots( attractor_spectator, var_18abf64ea4bec417 );
    
    /#
        if ( getdvarint( @"hash_90b8a0d6d446704a", 0 ) )
        {
            foreach ( slot in var_18abf64ea4bec417 )
            {
                level thread function_377b8cb5ab38737f( slot, 1 );
            }
        }
    #/
}

// Namespace namespace_876a8ceeff77ab5c
// Params 1
// Checksum 0x8f03c987, Offset: 0x279c
// Size: 0x42
function function_223605a945dab083( var_dff548c3090b7c3b )
{
    level endon( #"game_ended" );
    utility::flag_wait_all( "flag_finalpush_vtol_half_dead", "flag_prison_blockade_half_defeated" );
    
    /#
        iprintlnbold( "<dev string:x168>" );
    #/
    
    utility::flag_set( "flag_finalpush_barrier_attractor_escalate" );
}

// Namespace namespace_876a8ceeff77ab5c
// Params 1, eflags: 0x4
// Checksum 0x4e43cfef, Offset: 0x27e6
// Size: 0x94
function private function_4d9933e62d488427( var_dff548c3090b7c3b )
{
    level endon( #"game_ended" );
    a_zombies_near_gate = getaiarrayinradius( var_dff548c3090b7c3b.origin, 1024, level.players[ 0 ].team );
    
    if ( a_zombies_near_gate.size > 8 )
    {
        level utility::flag_set_delayed( "flag_finalpush_barrier_attractor_expand", 5 );
        return;
    }
    
    if ( a_zombies_near_gate.size > 4 )
    {
        level utility::flag_set_delayed( "flag_finalpush_barrier_attractor_expand", 2 );
        return;
    }
    
    level utility::flag_set( "flag_finalpush_barrier_attractor_expand" );
}

// Namespace namespace_876a8ceeff77ab5c
// Params 1, eflags: 0x4
// Checksum 0xc0e451b, Offset: 0x2882
// Size: 0x85
function private function_6b72d569313dfaa1( var_34983608850fadfe )
{
    level endon( #"game_ended" );
    var_34983608850fadfe setcandamage( 1 );
    var_34983608850fadfe.health = 999999;
    
    while ( true )
    {
        var_34983608850fadfe waittill( #"damage", amount, attacker );
        var_34983608850fadfe.health += amount;
        var_34983608850fadfe playsound( "evt_sat_gem_zombies_end_gate_impacts" );
        waitframe();
    }
}

// Namespace namespace_876a8ceeff77ab5c
// Params 2, eflags: 0x4
// Checksum 0xf2b20e25, Offset: 0x290f
// Size: 0xc5, Type: bool
function private function_95fb8291b63b4dec( attractor, zombie )
{
    if ( !isalive( zombie ) || !isdefined( attractor ) )
    {
        return false;
    }
    
    if ( zombie namespace_b76ff2659823e89d::is_crawling() )
    {
        return false;
    }
    
    if ( zombie utility::ent_flag( "scene_active" ) )
    {
        return false;
    }
    
    if ( isdefined( zombie.enemy ) && !utility::flag( "flag_finalpush_barrier_attractor_escalate" ) && utility::cointoss() )
    {
        return false;
    }
    
    if ( !utility::flag( "flag_finalpush_barrier_attractor_expand" ) )
    {
        s_finalpush_breakable_barrier = utility::getstruct( "s_finalpush_breakable_barrier", "targetname" );
        
        if ( distance2dsquared( zombie.origin, s_finalpush_breakable_barrier.origin ) > 1048576 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace namespace_876a8ceeff77ab5c
// Params 2, eflags: 0x4
// Checksum 0xd5babe99, Offset: 0x29dd
// Size: 0x7e, Type: bool
function private function_f19a58a9133df926( attractor, zombie )
{
    if ( !isalive( zombie ) || !isdefined( attractor ) )
    {
        return false;
    }
    
    if ( zombie namespace_b76ff2659823e89d::is_crawling() )
    {
        return false;
    }
    
    if ( zombie utility::ent_flag( "scene_active" ) )
    {
        return false;
    }
    
    if ( isdefined( zombie.enemy ) )
    {
        return false;
    }
    
    if ( zombie utility::ent_flag( "zombie_at_finalpush_attractor" ) || zombie utility::ent_flag( "zombie_moving_to_finalpush_attractor" ) )
    {
        return false;
    }
    
    return true;
}

/#

    // Namespace namespace_876a8ceeff77ab5c
    // Params 0
    // Checksum 0xab3aed90, Offset: 0x2a64
    // Size: 0x5, Type: dev
    function function_17e84949aa616916()
    {
        
    }

#/

// Namespace namespace_876a8ceeff77ab5c
// Params 0, eflags: 0x4
// Checksum 0x21541273, Offset: 0x2a71
// Size: 0xbe
function private function_50473185e4347f1c()
{
    activity_instance = self;
    
    while ( !isdefined( level.guild_vtol ) )
    {
        waitframe();
    }
    
    ob_story_mission_utils::objective_text_show( "OB_GEMINI_PRISON_FINALPUSH_VTOL" );
    level utility::flag_wait( "flag_finalpush_vtol_spinout" );
    activity_instance.obj_id = gemini_util::function_70fecc661764c00a( "s_finalpush_breakable_barrier", undefined, 128, "targetname", "sat_ob_objectivemarker_storymissionmain" );
    
    if ( !utility::flag( "flag_prison_blockade_defeated" ) )
    {
        ob_story_mission_utils::objective_text_show( "OB_GEMINI_PRISON_FINALPUSH_RIOTSHIELDS" );
    }
    
    level utility::flag_wait_all( "flag_prison_finalpush_completed", "flag_prison_blockade_defeated" );
    waitframe();
    ob_story_mission_utils::objective_text_show( "OB_GEMINI_PRISON_FINALPUSH_ESCAPE" );
    level utility::flag_wait( "flag_gemini_exfil_igc_begin" );
    ob_story_mission_utils::objective_text_clear();
    ob_story_mission_utils::objective_marker_clear( activity_instance.obj_id );
}

/#

    // Namespace namespace_876a8ceeff77ab5c
    // Params 0
    // Checksum 0x6660e198, Offset: 0x2b37
    // Size: 0x5, Type: dev
    function function_cab4d716bfbdb51e()
    {
        
    }

#/

// Namespace namespace_876a8ceeff77ab5c
// Params 0, eflags: 0x4
// Checksum 0x827e22bc, Offset: 0x2b44
// Size: 0x1cc
function private function_deaee867d40697e9()
{
    activity_instance = self;
    activity_instance.start = utility::getstruct( "s_finale_vtol", "targetname" );
    level.var_59e1d7f72751378 = 1;
    
    if ( isdefined( activity_instance.start ) )
    {
        activity_instance.heli_path_start = activity_instance.start;
        instance = spawnstruct();
        instance.activity = activity_instance;
        instance.boss = instance mp_sat_ob_gemini_vtol::spawn_vtol( activity_instance.heli_path_start.origin, activity_instance.heli_path_start.angles, &function_daffd91f1d5f8a8a );
        level.guild_vtol = instance.boss;
        instance.boss thread function_4766bae7f179444f();
        instance.boss.crash_position = utility::getstruct( "s_vtol_crash_pos", "targetname" );
        instance.boss thread function_b57700a46dbbd528();
        instance.boss thread function_143f9faa6feae964();
        level.guild_vtol vtol_intro_sequence();
        instance.boss thread mp_sat_ob_gemini_vtol::function_4dc701cb9e6fd618( activity_instance );
        instance.boss thread mp_sat_ob_gemini_vtol::vtol_turret_shoot_think();
        instance.boss thread mp_sat_ob_gemini_vtol::function_b33a1bb5cd2fb8ba( [ "flag_finalpush_vtol_half_dead", "flag_finalpush_soldiers_defeated" ] );
        instance.boss val::set( "gemini_vtol_boss", "show_healthbar", 0 );
        level utility::flag_set( "flag_finalpush_vtol_initialized" );
        return;
    }
    
    /#
        iprintlnbold( "<dev string:x191>" );
    #/
    
    utility::flag_set( "flag_prison_finalpush_completed" );
}

// Namespace namespace_876a8ceeff77ab5c
// Params 0, eflags: 0x4
// Checksum 0xd703ea94, Offset: 0x2d18
// Size: 0x171
function private vtol_intro_sequence()
{
    self endon( #"death", #"crashing" );
    self.animname = "vtol";
    animnode = utility::getstruct( "sat_cin_gem_prison_boss", "targetname" );
    var_7b4b8530ea8bd61e = [ self ];
    level utility::flag_set( "flag_finalpush_vtol_intro" );
    animnode thread scene::play( var_7b4b8530ea8bd61e, "enter" );
    self waittill( #"hash_c496f7208f161c52" );
    
    /#
        iprintlnbold( "<dev string:x1c2>" );
    #/
    
    s_target_start = utility::getstruct( "s_finalpush_vtol_entrance_missile_target", "targetname" );
    self.intro_missile_target = utility::spawn_tag_origin( s_target_start.origin );
    self.intro_missile_target show();
    self.var_521099eccef67894 = 1;
    visibility_mode::function_3afc3bc470c80e61( self, self.team );
    level notify( #"highvis_reload_outline", self.team, [ self ] );
    thread function_81c1ae4b847076ec( s_target_start, self.intro_missile_target );
    
    if ( isdefined( self.intro_missile_target ) )
    {
        thread mp_sat_ob_gemini_vtol::shoot_missiles( self.intro_missile_target, 4 );
    }
    else
    {
        /#
            iprintlnbold( "<dev string:x1d1>" );
        #/
        
        thread mp_sat_ob_gemini_vtol::shoot_missiles( level.players[ 0 ], 4 );
    }
    
    self waittill( #"vtol_enter_ended" );
    animnode thread scene::play( var_7b4b8530ea8bd61e, "loop" );
}

// Namespace namespace_876a8ceeff77ab5c
// Params 2, eflags: 0x4
// Checksum 0xabafb933, Offset: 0x2e91
// Size: 0xb8
function private function_81c1ae4b847076ec( s_target_start, intro_missile_target )
{
    level endon( #"game_ended" );
    self endon( #"death", #"flyaway", #"crashing" );
    self waittill( #"shoot_missiles_start" );
    
    if ( isdefined( s_target_start.target ) )
    {
        s_target_end = utility::getstruct( s_target_start.target, "targetname" );
        intro_missile_target moveto( s_target_end.origin, 1.5, 0.3, 0.3 );
    }
    
    self waittill( #"shoot_missiles_end" );
    wait 1;
    intro_missile_target delete();
}

// Namespace namespace_876a8ceeff77ab5c
// Params 0, eflags: 0x4
// Checksum 0x5d5e6aea, Offset: 0x2f51
// Size: 0x62
function private function_daffd91f1d5f8a8a()
{
    level endon( #"game_ended" );
    self endon( #"death", #"flyaway", #"crashing" );
    var_5990ce3727e634d1 = utility::getstruct( "s_finalpush_vtol_entrance_missile_target", "targetname" );
    self setturrettargetvec( var_5990ce3727e634d1.origin );
    self setturretscriptcontrolled( 1, 0 );
}

// Namespace namespace_876a8ceeff77ab5c
// Params 0
// Checksum 0x2c0779d0, Offset: 0x2fbb
// Size: 0x96
function function_b57700a46dbbd528()
{
    guild_vtol = self;
    guild_vtol zombie_boss_healthbar::init_zombie_boss_healthbar();
    
    foreach ( player in level.players )
    {
        player ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_guild_vtol", guild_vtol );
    }
}

// Namespace namespace_876a8ceeff77ab5c
// Params 1
// Checksum 0xbbe3ee28, Offset: 0x3059
// Size: 0x29
function function_f71d6f2babaf0b7b( params )
{
    if ( isdefined( level.guild_vtol ) )
    {
        level.guild_vtol function_a88301fee80fb07b();
    }
}

// Namespace namespace_876a8ceeff77ab5c
// Params 0
// Checksum 0x1c989b95, Offset: 0x308a
// Size: 0x8d
function function_143f9faa6feae964()
{
    self endon( #"death" );
    
    while ( self.health > 0 )
    {
        self waittill( #"damage", amount, attacker, direction_vec, damagelocation, damagetype );
        
        if ( isplayer( attacker ) || isplayer( attacker.owner ) )
        {
            thread function_3e85148568a0661( attacker );
            function_a88301fee80fb07b();
        }
        
        waitframe();
    }
}

// Namespace namespace_876a8ceeff77ab5c
// Params 1
// Checksum 0xe2f593d5, Offset: 0x311f
// Size: 0xba
function function_3e85148568a0661( attacker )
{
    self notify( #"hash_90d7b891bede6934" );
    self endon( #"hash_90d7b891bede6934" );
    self endon( #"death" );
    
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    if ( isdefined( attacker.owner ) && !isplayer( attacker.owner ) )
    {
        return;
    }
    
    self.last_attacker = attacker;
    attacker.var_b608cdcc4dbe9100 = gettime();
    attacker.vtol_protection = 0;
    attacker utility::waittill_notify_or_timeout( "death", 5 );
    
    if ( isdefined( attacker ) )
    {
        attacker.var_b608cdcc4dbe9100 = gettime();
    }
    
    self.last_attacker = undefined;
}

// Namespace namespace_876a8ceeff77ab5c
// Params 0
// Checksum 0x2de67052, Offset: 0x31e1
// Size: 0x1a5
function function_a88301fee80fb07b()
{
    if ( self.health > 0 )
    {
        health_frac = self.health / self.maxhealth;
        
        if ( !utility::flag( "flag_finalpush_vtol_half_dead" ) && health_frac <= 0.5 )
        {
            level utility::flag_set( "flag_finalpush_vtol_half_dead" );
            var_8a91c0f41f940c16 = ob_story_mission_utils::get_playing_players();
            
            if ( var_8a91c0f41f940c16.size <= 2 || level.is_squad_size_small )
            {
                var_ff8597a8a4dd5d0c = 3;
            }
            else
            {
                var_ff8597a8a4dd5d0c = 5;
            }
            
            thread mp_sat_ob_gemini_vtol::missiles_think( 2, var_ff8597a8a4dd5d0c, -64 );
        }
        
        foreach ( player in level.players )
        {
            player ob_story_mission_utils::function_e231206f1628d4c6( 1, health_frac * 100, 100 );
        }
        
        return;
    }
    
    foreach ( player in level.players )
    {
        player ob_story_mission_utils::player_boss_healthbar_hide();
    }
    
    level callback::remove( #"player_spawned", &function_f71d6f2babaf0b7b );
}

// Namespace namespace_876a8ceeff77ab5c
// Params 0, eflags: 0x4
// Checksum 0x7a8f5822, Offset: 0x338e
// Size: 0xc8
function private function_4766bae7f179444f()
{
    level endon( #"game_ended" );
    self waittill( #"death" );
    utility::flag_set( "flag_prison_finalpush_completed" );
    
    foreach ( player in level.players )
    {
        player ob_story_mission_utils::function_e231206f1628d4c6( 1, 0, 100 );
        player ob_story_mission_utils::player_boss_healthbar_hide();
    }
    
    wait 3;
    
    if ( isdefined( level.guild_vtol ) )
    {
        level.guild_vtol = undefined;
    }
}

/#

    // Namespace namespace_876a8ceeff77ab5c
    // Params 0
    // Checksum 0x1fc59a6d, Offset: 0x345e
    // Size: 0x5, Type: dev
    function function_ed49ae2f4cc0f66d()
    {
        
    }

#/

// Namespace namespace_876a8ceeff77ab5c
// Params 0, eflags: 0x4
// Checksum 0x8d589352, Offset: 0x346b
// Size: 0x12d
function private function_3bccaedc16c222ba()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    level waittill( #"vtol_boss_crashed" );
    a_barrels = gemini_util::get_scriptable_array( "finalpush_explosive_barrel", #targetname );
    
    if ( a_barrels )
    {
        foreach ( barrel in a_barrels )
        {
            delay = randomfloatrange( 0.1, 0.9 );
            wait delay;
            
            if ( barrel )
            {
                magicbullet( "sat_la_polis_mp", barrel.origin + ( 0, 0, 5 ), barrel.origin, level.players[ 0 ] );
            }
        }
    }
    
    utility::flag_set( "flag_barrels_exploded" );
}

