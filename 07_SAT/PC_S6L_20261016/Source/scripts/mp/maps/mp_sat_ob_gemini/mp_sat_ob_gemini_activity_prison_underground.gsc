// scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_activity_prison_underground.gsc  (hash_124206cccb12e297.gscc) (size: 14778 Bytes / 0x39ba / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf3f88822 (4093151266)
// size ...... 14778 (0x39ba)
// includes .. 19  (offset: 0x3576)
// strings ... 59  (offset: 0x360e)
// dev strs .. 4   (offset: 0x398a)
// exports ... 39  (offset: 0x1ef2)
// cseg ...... 0x891 + 0x1661 (0x1ef2)
// imports ... 140 (offset: 0x250a)
// animtree1 . 0   (offset: 0x39ba)
// animtree2 . 0   (offset: 0x39ba)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\laststand;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_activity_prison_minecarts;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_scenes;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_util;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_vo;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\supers;

#namespace namespace_93364dffc281db19;

// Namespace namespace_93364dffc281db19
// Params 0, eflags: 0x5
// Checksum 0xd586e96f, Offset: 0x8af
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_3d8b7fed16c022f1", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_93364dffc281db19
// Params 0, eflags: 0x4
// Checksum 0xd5ecc355, Offset: 0x8d8
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_GEMINI_PRISON_UNDERGROUND";
    activity_common::registeractivitytype( "OB_GEMINI_PRISON_UNDERGROUND", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_PRISON_UNDERGROUND", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_PRISON_UNDERGROUND", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_PRISON_UNDERGROUND", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_GEMINI_PRISON_UNDERGROUND" );
}

// Namespace namespace_93364dffc281db19
// Params 0
// Checksum 0x6e57112, Offset: 0x94f
// Size: 0x59
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance prison_underground_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_93364dffc281db19
// Params 0
// Checksum 0xfd33fbd2, Offset: 0x9b0
// Size: 0x39
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance prison_underground_main();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_93364dffc281db19
// Params 0
// Checksum 0x9b8f4fb8, Offset: 0x9f1
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_93364dffc281db19
// Params 1
// Checksum 0x9adade88, Offset: 0xa15
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread prison_underground_player_setup( player );
    }
}

// Namespace namespace_93364dffc281db19
// Params 0
// Checksum 0xfed271d4, Offset: 0xad1
// Size: 0x1d
function prison_underground_start()
{
    activity_instance = self;
    gemini_util::function_34a3d0cff5de2d7d();
    gemini_util::function_dfcbf5f9b3b2e6a0();
}

// Namespace namespace_93364dffc281db19
// Params 0
// Checksum 0x9dd9ee48, Offset: 0xaf6
// Size: 0xed
function prison_underground_main()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    level utility::flag_set( "flag_prison_underground_weapon_up" );
    level.var_d53163b0ef2a4488 = 1;
    activity_instance childthread gemini_vo::function_bd2f50e757cc2fdc();
    activity_instance function_388a6b1bc5c5567f();
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_underground_weapon", "flag_trig_prison_minecarts_player_reached_end", 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_prison_underground_equipment", undefined, 1 );
    activity_instance thread namespace_60d9b3cbf41663fe::function_faa67b2e7f82331a();
    activity_instance thread gemini_util::function_139e7e4c5feaaa9d();
    activity_instance thread ob_story_mission_utils::function_e6799e9a19df2365( "s_prison_underground_cache" );
    level thread gemini_util::function_178de2439c77b626();
    activity_instance thread function_d37912b810e7f7d4();
    level thread function_ecd3bffc0ceeaed9();
    activity_instance thread function_68874b089adab674();
    waitframe();
    activity_instance thread function_cc8a4fe130f2f402();
    waitframe();
    activity_instance thread function_a74cbb8f91b1db0();
    activity_instance thread function_1e26fb6a1c64dff8();
    level utility::flag_wait( "flag_underground_completed" );
}

// Namespace namespace_93364dffc281db19
// Params 0
// Checksum 0xb6c2aaf1, Offset: 0xbeb
// Size: 0xdb
function function_1e26fb6a1c64dff8()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    utility::flag_wait_any( "flag_prison_underground_soldiers_defeated", "flag_underground_completed" );
    activity_instance namespace_2466a4c786927f0a::function_e2faa5709401981e();
    
    foreach ( player in level.players )
    {
        activity_instance namespace_2466a4c786927f0a::prison_minecarts_player_setup( player );
    }
    
    level.minecarts_manager = namespace_2466a4c786927f0a::function_162e972ee20d92ba();
    activity_instance namespace_2466a4c786927f0a::function_f6837de7b194f4a4();
}

// Namespace namespace_93364dffc281db19
// Params 0
// Checksum 0xf248d58d, Offset: 0xcce
// Size: 0x64
function function_388a6b1bc5c5567f()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( threatbiasgroupexists( "threatbias_underground_prison_soldier" ) && threatbiasgroupexists( "threatbias_underground_prison_zombie" ) )
    {
        return;
    }
    
    createthreatbiasgroup( "threatbias_underground_prison_soldier" );
    createthreatbiasgroup( "threatbias_underground_prison_zombie" );
    setthreatbias( "threatbias_underground_prison_zombie", "threatbias_underground_prison_soldier", 48 );
}

/#

    // Namespace namespace_93364dffc281db19
    // Params 0
    // Checksum 0x92a3e71d, Offset: 0xd3a
    // Size: 0x5, Type: dev
    function function_c2f85bee7d0d5203()
    {
        
    }

#/

// Namespace namespace_93364dffc281db19
// Params 1
// Checksum 0xdd7e2790, Offset: 0xd47
// Size: 0x5b
function prison_underground_player_setup( player )
{
    activity_instance = self;
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        player thread gemini_util::function_5e0ec074b46e6e09();
    }
    
    player thread function_1301da0e8a97b694();
    player thread gemini_util::player_cold_breath_toggle( "flag_prison_blockade_defeated" );
    activity_instance thread function_4d16f4c9a98c1540( player );
}

// Namespace namespace_93364dffc281db19
// Params 0, eflags: 0x4
// Checksum 0xc7e38969, Offset: 0xdaa
// Size: 0x5e
function private function_1301da0e8a97b694()
{
    player = self;
    player val::reset_all( "gemini_cabin_barrage" );
    player supers_mp::setsuperexpended( 0, #"default" );
    
    if ( isdefined( player.barrage_self_revive_count ) )
    {
        player laststand::function_39844c1e879cc048( player.barrage_self_revive_count );
        player.barrage_self_revive_count = undefined;
    }
}

// Namespace namespace_93364dffc281db19
// Params 0
// Checksum 0x2427ac53, Offset: 0xe10
// Size: 0x18a
function function_28051c6685f523d4()
{
    level endon( #"game_ended" );
    vol = getent( "v_underground_zombies_barrier", #targetname );
    var_678dae76d95010b0 = utility::getstruct( "s_underground_gate_allplayers", "targetname" );
    n_radius = var_678dae76d95010b0.radius;
    a_players_facing = [];
    n_timeout_min = 5;
    n_timeout_max = 15;
    var_f9073b9a68fe2fe = n_timeout_min;
    n_time_start = gettime();
    
    while ( true )
    {
        if ( !vol gemini_util::function_73bd7925ab7e8a36() )
        {
            wait 1;
            var_f9073b9a68fe2fe = n_timeout_min;
            n_time_start = gettime();
            continue;
        }
        
        if ( gettime() > n_time_start + utility::function_4b74c15943231980( n_timeout_max ) )
        {
            /#
                iprintlnbold( "<dev string:x24>" );
            #/
            
            utility::flag_set( "flag_underground_completed" );
            return;
        }
        
        n_time_decrease = 0;
        var_dce79ddf9e318abd = ob_story_mission_utils::get_playing_players();
        a_players_facing = function_ee2f8b3130d34026( var_678dae76d95010b0.origin, n_radius );
        
        if ( a_players_facing.size == var_dce79ddf9e318abd.size )
        {
            n_time_decrease = 3;
        }
        else if ( a_players_facing.size > 1 )
        {
            n_time_decrease = 2;
        }
        else if ( a_players_facing.size > 0 )
        {
            n_time_decrease = 1;
        }
        
        wait 1;
        
        if ( n_time_decrease > 0 )
        {
            var_f9073b9a68fe2fe -= n_time_decrease;
        }
        else
        {
            var_f9073b9a68fe2fe = n_timeout_min;
        }
        
        if ( var_f9073b9a68fe2fe <= 0 )
        {
            /#
                iprintlnbold( "<dev string:x63>" );
            #/
            
            utility::flag_set( "flag_underground_completed" );
            return;
        }
    }
}

// Namespace namespace_93364dffc281db19
// Params 3, eflags: 0x4
// Checksum 0x25473b5e, Offset: 0xfa2
// Size: 0x95
function private function_ee2f8b3130d34026( v_origin, n_distance = 2048, var_6b553f8d178bee38 = 60 )
{
    a_players_facing = [];
    var_dce79ddf9e318abd = ob_story_mission_utils::get_playing_players();
    
    for ( i = 0; i < var_dce79ddf9e318abd.size ; i++ )
    {
        player = var_dce79ddf9e318abd[ i ];
        
        if ( player function_24875e209fe0726( v_origin, n_distance, var_6b553f8d178bee38 ) )
        {
            a_players_facing = arraycombineunique( a_players_facing, [ player ] );
        }
    }
    
    return a_players_facing;
}

// Namespace namespace_93364dffc281db19
// Params 3, eflags: 0x4
// Checksum 0xaf40cafe, Offset: 0x1040
// Size: 0x75, Type: bool
function private function_24875e209fe0726( v_origin, n_distance = 2000, var_6b553f8d178bee38 = 60 )
{
    if ( n_distance && distancesquared( self.origin, v_origin ) > squared( n_distance ) )
    {
        return false;
    }
    
    if ( utility::within_fov( self geteye(), self.angles, v_origin, cos( var_6b553f8d178bee38 ) ) )
    {
        return true;
    }
    
    return false;
}

/#

    // Namespace namespace_93364dffc281db19
    // Params 0
    // Checksum 0xa7b04804, Offset: 0x10be
    // Size: 0x5, Type: dev
    function function_4d06fd5e4fa2ba68()
    {
        
    }

#/

// Namespace namespace_93364dffc281db19
// Params 0, eflags: 0x4
// Checksum 0x64ccb9f9, Offset: 0x10cb
// Size: 0xed
function private function_68874b089adab674()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    a_nd_allyzombie_minecarts_exposed = getnodearray( "nd_allyzombie_minecarts_exposed", #targetname );
    
    if ( !isdefined( level.var_c5fdbf7b47e210ae ) )
    {
        level.var_c5fdbf7b47e210ae = spawnstruct();
        
        if ( !isdefined( level.var_c5fdbf7b47e210ae.ai_array ) )
        {
            level.var_c5fdbf7b47e210ae.ai_array = [];
        }
    }
    
    activity_instance thread function_c4ef71ce40b1dba3( "sat_sm04_gemini_ai_encounter_underground_allyzombies_lower_prio", a_nd_allyzombie_minecarts_exposed, 20 );
    wait 1;
    activity_instance thread function_c4ef71ce40b1dba3( "sat_sm04_gemini_ai_encounter_underground_allyzombies_initial", a_nd_allyzombie_minecarts_exposed, 20 );
    wait 1;
    activity_instance thread function_c4ef71ce40b1dba3( "sat_sm04_gemini_ai_encounter_underground_allyzombies_lower_prio2", a_nd_allyzombie_minecarts_exposed, 15 );
    wait 1;
    activity_instance thread function_c4ef71ce40b1dba3( "sat_sm04_gemini_ai_encounter_underground_allyzombies_lower_prio3", a_nd_allyzombie_minecarts_exposed, 15 );
}

// Namespace namespace_93364dffc281db19
// Params 3, eflags: 0x4
// Checksum 0x1032f0d6, Offset: 0x11c0
// Size: 0xcb
function private function_c4ef71ce40b1dba3( ai_encounter_targetname, a_nd_allyzombie_minecarts_exposed, var_939a6122b3f49ea1 = 15 )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    request_id = activity_instance activity_ai_encounters::function_92b671064b0b1ce2( ai_encounter_targetname, 0, 1, 1, 2 );
    activity_ai_encounters::function_52d1342183200a8f( request_id, &function_9a2d708d8aaa92e5, a_nd_allyzombie_minecarts_exposed );
    activity_ai_encounters::function_dcf6bdb6ee9d1ca0( request_id, &function_3123fdcf24fc2916 );
    activity_ai_encounters::function_d33de057e760c97b( request_id, &function_1b4b50b33be3d324 );
    
    while ( !utility::flag( "flag_underground_completed" ) )
    {
        count_all_ai = getaicount();
        
        if ( count_all_ai <= var_939a6122b3f49ea1 )
        {
            activity_ai_encounters::function_48582991402cac50( request_id, 1 );
            break;
        }
        
        wait 1;
    }
}

// Namespace namespace_93364dffc281db19
// Params 0, eflags: 0x4
// Checksum 0xc169f841, Offset: 0x1293
// Size: 0x83
function private function_a74cbb8f91b1db0()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    level utility::flag_wait( "flag_trig_prison_underground_cells_approach" );
    var_a04bb2ee5a102c01 = activity_instance activity_ai_encounters::function_92b671064b0b1ce2( "sat_sm04_ai_encounter_underground_running_zombies_01", 0, 1, 1, 2 );
    activity_ai_encounters::function_52d1342183200a8f( var_a04bb2ee5a102c01, &function_9a2d708d8aaa92e5 );
    activity_ai_encounters::function_d33de057e760c97b( var_a04bb2ee5a102c01, &function_1b4b50b33be3d324 );
    activity_ai_encounters::function_48582991402cac50( var_a04bb2ee5a102c01, 1 );
}

// Namespace namespace_93364dffc281db19
// Params 0, eflags: 0x4
// Checksum 0x8c0943, Offset: 0x131e
// Size: 0xb5
function private function_d37912b810e7f7d4()
{
    activity_instance = self;
    activity_instance thread gemini_util::function_b2e3b9ccdce5ec87( "scene_prison_underground_ascent_feeding_zmb", undefined, undefined, undefined, "flag_trig_prison_minecarts_player_reached_midpoint" );
    var_704f37bf85217934 = utility::getstructarray( "scene_prison_underground_ascent_feeding_zmb", "targetname" );
    
    foreach ( index, s_scene in var_704f37bf85217934 )
    {
        s_scene thread function_baad9ce773d11e4c( index, "flag_trig_prison_minecarts_player_reached_midpoint" );
    }
}

// Namespace namespace_93364dffc281db19
// Params 2, eflags: 0x4
// Checksum 0xfda4bb1, Offset: 0x13db
// Size: 0x6b
function private function_baad9ce773d11e4c( index, flag_endon )
{
    level endon( #"game_ended" );
    var_12aadf5d8bbfdafd = createnavobstaclebybounds( self.origin, ( 32, 32, 32 ), ( 0, 0, 0 ) );
    utility::waittill_any_ents( self, "scene_zombie_action", level, flag_endon );
    destroynavobstacle( var_12aadf5d8bbfdafd );
}

// Namespace namespace_93364dffc281db19
// Params 4, eflags: 0x4
// Checksum 0x34e3a8bf, Offset: 0x144e
// Size: 0x27c
function private function_9a2d708d8aaa92e5( requestid, instance, agent, data )
{
    level endon( #"game_ended" );
    agent endon( #"death" );
    agent thread gemini_util::function_7653e4bbe774fb50( level.var_c5fdbf7b47e210ae );
    agent gemini_util::function_376f4cf6d212ef9b( 5, 6000 );
    
    if ( threatbiasgroupexists( "threatbias_underground_prison_zombie" ) )
    {
        agent setthreatbiasgroup( "threatbias_underground_prison_zombie" );
    }
    
    agent childthread gemini_util::function_11266ff8ae084f14( "flag_trig_prison_underground_cells_approach" );
    utility::flag_wait( "flag_prison_underground_soldiers_defeated" );
    var_a8e62752ce428692 = getent( "v_underground_zombies_barrier", #targetname );
    var_bb4c566ae5fb39a5 = getent( "v_minecarts_soldiers_center", #targetname );
    
    if ( utility::flag( "flag_underground_barrier_01_opened" ) )
    {
        agent function_dd3b2de3b28ea995( 0, var_bb4c566ae5fb39a5 );
    }
    else
    {
        agent function_dd3b2de3b28ea995( 0, var_a8e62752ce428692 );
        utility::flag_wait( "flag_underground_barrier_01_opened" );
        agent clearbtgoal( 0 );
        waitframe();
        agent function_fa32376aaa88a7a2( var_bb4c566ae5fb39a5.origin, 4000 );
        agent function_dd3b2de3b28ea995( 0, var_bb4c566ae5fb39a5 );
    }
    
    wait randomfloatrange( 0.5, 1.5 );
    agent gemini_util::function_daf8afa8f377f24( 3, "run" );
    agent thread namespace_2466a4c786927f0a::function_7ee00cab3090dfaa( 1536, 1 );
    agent thread function_4c5663a45060cb3b();
    
    while ( !utility::flag( "flag_prison_minecarts_barrier_destroyed" ) && !utility::flag( "flag_prison_minecarts_soldiers_defeated" ) )
    {
        var_a97d79fac8e7a1c7 = utility::get_noteworthy_array( "prison_minecarts_soldier" );
        var_a97d79fac8e7a1c7 = utility::array_removedead_or_dying( var_a97d79fac8e7a1c7, 1 );
        
        if ( var_a97d79fac8e7a1c7.size > 0 )
        {
            ai_target = function_47c86977a18df38b( var_a97d79fac8e7a1c7, agent.origin, 6400 );
            
            if ( isalive( ai_target ) && !ai_target.ignoreme && ai_target.type != "zombie" )
            {
                agent clearbtgoal( 0 );
                waitframe();
                agent function_f2fdf8ef124744e8( 0, ai_target );
                ai_target utility::waittill_notify_or_timeout( "death", 10 );
                agent clearbtgoal( 0 );
            }
        }
        
        wait 1;
    }
    
    utility::flag_wait( "flag_prison_minecarts_barrier_destroyed" );
    agent clearbtgoal( 0 );
    s_armory_entrance = utility::getstruct( "s_prison_armory_entrance_zombie_attractor", "targetname" );
    agent function_fa32376aaa88a7a2( s_armory_entrance.origin, 4000 );
    agent gemini_util::ai_delete_when_out_of_sight( 512, 1024 );
}

// Namespace namespace_93364dffc281db19
// Params 0, eflags: 0x4
// Checksum 0xf7cb61b0, Offset: 0x16d2
// Size: 0x8c
function private function_4c5663a45060cb3b()
{
    level endon( #"game_ended", #"flag_prison_minecarts_soldiers_defeated" );
    
    if ( utility::flag( "flag_prison_minecarts_soldiers_defeated" ) )
    {
        return;
    }
    
    while ( isalive( self ) )
    {
        if ( level.players.size > 2 )
        {
            gemini_util::function_f53463c3213de6a1( "s_minecarts_breakable_barrier", "flag_prison_minecarts_completed", 20, 10 );
            wait randomfloatrange( 1, 9 );
            continue;
        }
        
        gemini_util::function_f53463c3213de6a1( "s_minecarts_breakable_barrier", "flag_prison_minecarts_completed", 25, 15 );
        wait randomfloatrange( 5, 15 );
    }
}

// Namespace namespace_93364dffc281db19
// Params 2, eflags: 0x4
// Checksum 0xebe639a1, Offset: 0x1766
// Size: 0x41, Type: bool
function private function_3123fdcf24fc2916( requestid, userdata )
{
    count_all_ai = getaicount();
    
    if ( count_all_ai > 20 )
    {
        return false;
    }
    
    if ( utility::flag( "flag_underground_completed" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_93364dffc281db19
// Params 2, eflags: 0x4
// Checksum 0xd4beab06, Offset: 0x17b0
// Size: 0x27, Type: bool
function private function_1b4b50b33be3d324( requestid, userdata )
{
    if ( utility::flag( "flag_underground_completed" ) )
    {
        return true;
    }
    
    return false;
}

/#

    // Namespace namespace_93364dffc281db19
    // Params 0
    // Checksum 0xb9f84fe, Offset: 0x17e0
    // Size: 0x5, Type: dev
    function function_c64aa62f7150c263()
    {
        
    }

#/

// Namespace namespace_93364dffc281db19
// Params 0, eflags: 0x4
// Checksum 0x4b92ab88, Offset: 0x17ed
// Size: 0xa8
function private function_cc8a4fe130f2f402()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    
    if ( !isdefined( level.underground_enemy_soldiers ) )
    {
        level.underground_enemy_soldiers = spawnstruct();
        
        if ( !isdefined( level.underground_enemy_soldiers.ai_array ) )
        {
            level.underground_enemy_soldiers.ai_array = [];
        }
    }
    
    activity_instance gemini_util::function_51e3aaef58423855( "sat_sm04_gemini_ai_encounter_underground_soldiers", &function_831e5f80b1b841f5, activity_instance, "flag_underground_completed", 2, 0, &function_a83cf708cf5b762, &function_14a5a19ebea017b7 );
    waitframe();
    activity_instance childthread function_f9a6d549340d947();
}

// Namespace namespace_93364dffc281db19
// Params 4, eflags: 0x4
// Checksum 0x93f5492f, Offset: 0x189d
// Size: 0x111
function private function_831e5f80b1b841f5( requestid, activity_instance, agent, userdata )
{
    level endon( #"game_ended" );
    agent endon( #"death" );
    agent thread gemini_util::function_7653e4bbe774fb50( level.underground_enemy_soldiers );
    
    if ( threatbiasgroupexists( "threatbias_underground_prison_soldier" ) )
    {
        agent setthreatbiasgroup( "threatbias_underground_prison_soldier" );
    }
    
    agent.grenadeammo = 0;
    agent.script_noteworthy = "prison_underground_soldier";
    var_95b86e61b2c6a7 = utility::array_random( level.players );
    
    if ( isdefined( var_95b86e61b2c6a7 ) )
    {
        agent getenemyinfo( var_95b86e61b2c6a7 );
    }
    
    agent demeanoroverride( "combat" );
    waitframe();
    agent agent_utils::function_1874e18b42e6d814( &gemini_util::function_cb3d5af3567a0360 );
    level utility::flag_wait_any( "flag_underground_tunnel", "flag_underground_completed" );
    agent gemini_util::function_daf8afa8f377f24();
    agent.zombie_dmg_multiplier = 3;
    wait 1;
    agent gemini_util::ai_delete_when_out_of_sight( 512, 1024 );
}

// Namespace namespace_93364dffc281db19
// Params 3, eflags: 0x4
// Checksum 0x1159c025, Offset: 0x19b6
// Size: 0x4c, Type: bool
function private function_a83cf708cf5b762( requestid, userdata, wavenumber )
{
    if ( level utility::flag( "flag_trig_prison_underground_cells_midpoint" ) )
    {
        ai_spawn_director::cancel_spawn_request( requestid, 0 );
        return false;
    }
    
    if ( level utility::flag( "flag_prison_underground_soldiers_reinforce" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_93364dffc281db19
// Params 2, eflags: 0x4
// Checksum 0xd458f6a7, Offset: 0x1a0b
// Size: 0x21
function private function_14a5a19ebea017b7( requestid, userdata )
{
    utility::flag_set( "flag_prison_underground_soldiers_spawned" );
}

// Namespace namespace_93364dffc281db19
// Params 0, eflags: 0x4
// Checksum 0x8d257594, Offset: 0x1a34
// Size: 0xc1
function private function_f9a6d549340d947()
{
    activity_instance = self;
    utility::flag_wait( "flag_prison_underground_soldiers_spawned" );
    assert( isdefined( level.underground_enemy_soldiers ), "<dev string:xb2>" );
    
    while ( true )
    {
        waitframe();
        level.underground_enemy_soldiers gemini_util::ai_array_cleanup( "soldier" );
        
        if ( !utility::flag( "flag_prison_underground_soldiers_reinforce" ) && level.underground_enemy_soldiers.ai_array.size < 3 )
        {
            utility::flag_set( "flag_prison_underground_soldiers_reinforce" );
            wait 1;
        }
        
        if ( level.underground_enemy_soldiers.ai_array.size <= 0 )
        {
            break;
        }
    }
    
    utility::flag_set( "flag_prison_underground_soldiers_defeated" );
    
    /#
        iprintlnbold( "<dev string:xe7>" );
    #/
}

/#

    // Namespace namespace_93364dffc281db19
    // Params 0
    // Checksum 0xb0cb0be4, Offset: 0x1afd
    // Size: 0x5, Type: dev
    function function_671e5ee77b95466b()
    {
        
    }

#/

// Namespace namespace_93364dffc281db19
// Params 2, eflags: 0x4
// Checksum 0x698ef0c6, Offset: 0x1b0a
// Size: 0x4a, Type: bool
function private function_1de5bf7a075b0ae9( attractor, zombie )
{
    if ( !isalive( zombie ) || !isdefined( attractor ) )
    {
        return false;
    }
    
    if ( zombie utility::ent_flag( "scene_active" ) )
    {
        return false;
    }
    
    if ( zombie namespace_b76ff2659823e89d::is_crawling() )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_93364dffc281db19
// Params 0
// Checksum 0x2c69323d, Offset: 0x1b5d
// Size: 0x159
function function_ecd3bffc0ceeaed9()
{
    level endon( #"game_ended" );
    var_ddbf287e41d23aa3 = 3;
    level thread namespace_60d9b3cbf41663fe::function_48d06e75c2be0143( var_ddbf287e41d23aa3 );
    s_underground_breakable_barrier_01 = utility::getstruct( "s_underground_breakable_barrier_01", "targetname" );
    var_3f29c07af2f6e5e1 = utility::getstructarray( "s_underground_breakable_barrier_01_att_point", "targetname" );
    utility::flag_wait( "flag_prison_underground_soldiers_defeated" );
    s_attackable = zombie_attractor_manager::add_attractor( s_underground_breakable_barrier_01, 1, 3800, 0, undefined, &function_1de5bf7a075b0ae9, 0, "team_hundred_ninety" );
    zombie_attractor_manager::set_attractor_slots( s_attackable, var_3f29c07af2f6e5e1 );
    utility::flag_wait( "flag_underground_tunnel_exit" );
    function_28051c6685f523d4();
    utility::flag_wait( "flag_underground_completed" );
    var_fc5409dd673d9bca = getentarray( "e_underground_cart_door_static", "targetname" );
    
    foreach ( door in var_fc5409dd673d9bca )
    {
        door hide();
    }
    
    wait 4;
    level thread function_447d7e7527344ddc();
    utility::flag_set( "flag_underground_barrier_01_opened" );
    zombie_attractor_manager::remove_attractor( s_underground_breakable_barrier_01 );
}

// Namespace namespace_93364dffc281db19
// Params 0
// Checksum 0x3484b217, Offset: 0x1cbe
// Size: 0x7f
function function_447d7e7527344ddc()
{
    sm_barrier = getent( "sm_underground_breakable_barrier_01", #targetname );
    sbm_barrier = getent( "sbm_underground_breakable_barrier_01", #targetname );
    sbm_barrier_damaged = getent( "sbm_underground_breakable_barrier_01_damaged", #targetname );
    
    if ( isdefined( sm_barrier ) )
    {
        sm_barrier delete();
    }
    
    if ( isdefined( sbm_barrier ) )
    {
        sbm_barrier delete();
    }
    
    if ( isdefined( sbm_barrier_damaged ) )
    {
        sbm_barrier_damaged delete();
    }
}

/#

    // Namespace namespace_93364dffc281db19
    // Params 0
    // Checksum 0xae333b74, Offset: 0x1d45
    // Size: 0x5, Type: dev
    function function_115095d40c3a0ddc()
    {
        
    }

#/

// Namespace namespace_93364dffc281db19
// Params 1, eflags: 0x4
// Checksum 0xf6e609d6, Offset: 0x1d52
// Size: 0x1a0
function private function_4d16f4c9a98c1540( player )
{
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    foreach ( obj_id in activity_instance.a_obj_id )
    {
        objective_removeclientfrommask( obj_id, player );
    }
    
    if ( !isdefined( player.player_objective ) )
    {
        player.player_objective = spawnstruct();
    }
    
    ob_story_mission_utils::objective_text_show( "OB_GEMINI_PRISON_UNDERGROUND" );
    player.player_objective.obj_id = gemini_util::function_70fecc661764c00a( "s_obj_prison_underground_01", player, undefined, undefined, undefined, "active" );
    player utility::ent_flag_wait( "flag_ent_underground_tunnel_exited" );
    var_39c49a5c0ec0e80d = utility::getstruct( "s_obj_prison_underground_02", "targetname" );
    objidpoolmanager::update_objective_position( player.player_objective.obj_id, var_39c49a5c0ec0e80d.origin + ( 0, 0, 48 ) );
    level utility::flag_wait_all( "flag_underground_barrier_01_opened", "flag_trig_prison_minecarts_player_entered" );
    ob_story_mission_utils::objective_marker_clear( player.player_objective.obj_id );
}

