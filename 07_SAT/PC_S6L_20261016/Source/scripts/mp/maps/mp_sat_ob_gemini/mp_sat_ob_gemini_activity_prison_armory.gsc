// scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_activity_prison_armory.gsc  (hash_389453bced5e788e.gscc) (size: 17324 Bytes / 0x43ac / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x59409805 (1497405445)
// size ...... 17324 (0x43ac)
// includes .. 13  (offset: 0x3e70)
// strings ... 71  (offset: 0x3ed8)
// dev strs .. 10  (offset: 0x4330)
// exports ... 48  (offset: 0x2730)
// cseg ...... 0xaca + 0x1c66 (0x2730)
// imports ... 128 (offset: 0x2eb0)
// animtree1 . 0   (offset: 0x43ac)
// animtree2 . 0   (offset: 0x43ac)
#using script_2399696a9d953451;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\waypoint_objective_handler;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_util;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_vo;
#using scripts\mp\outofbounds;

#namespace namespace_31b2bab150bfb17a;

// Namespace namespace_31b2bab150bfb17a
// Params 0, eflags: 0x5
// Checksum 0x35e88d95, Offset: 0xae8
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_b64e12bd7ce07f62", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_31b2bab150bfb17a
// Params 0, eflags: 0x4
// Checksum 0x47d2a936, Offset: 0xb11
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_GEMINI_PRISON_ARMORY";
    activity_common::registeractivitytype( "OB_GEMINI_PRISON_ARMORY", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_PRISON_ARMORY", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_PRISON_ARMORY", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_PRISON_ARMORY", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_GEMINI_PRISON_ARMORY" );
}

// Namespace namespace_31b2bab150bfb17a
// Params 0
// Checksum 0x8b69fe79, Offset: 0xb88
// Size: 0x59
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance prison_armory_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_31b2bab150bfb17a
// Params 0
// Checksum 0xd80fd9bf, Offset: 0xbe9
// Size: 0x39
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance prison_armory_main();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_31b2bab150bfb17a
// Params 0
// Checksum 0x9b125db, Offset: 0xc2a
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_31b2bab150bfb17a
// Params 1
// Checksum 0x459a85a2, Offset: 0xc4e
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread prison_armory_player_setup( player );
    }
}

// Namespace namespace_31b2bab150bfb17a
// Params 0
// Checksum 0x73d7a08c, Offset: 0xd0a
// Size: 0x9b
function prison_armory_start()
{
    activity_instance = self;
    sbm_minecarts_breakable_barrier = getent( "sbm_minecarts_breakable_barrier", #targetname );
    sm_minecarts_breakable_barrier = getent( "sm_minecarts_breakable_barrier", #targetname );
    sbm_minecarts_breakable_barrier hide();
    sbm_minecarts_breakable_barrier connectpaths();
    sm_minecarts_breakable_barrier setscriptablepartstate( "main", "dead_nofx" );
    gemini_util::function_34a3d0cff5de2d7d();
    gemini_util::function_dfcbf5f9b3b2e6a0();
    activity_instance thread function_b317ecf8c6509b49();
    activity_instance thread function_4c86d412ebfdbccd();
    level thread function_c28c596cbfcd0e22();
    level utility::flag_set( "flag_prison_minecarts_completed" );
}

// Namespace namespace_31b2bab150bfb17a
// Params 0
// Checksum 0x20754351, Offset: 0xdad
// Size: 0xf1
function prison_armory_main()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    level.var_d53163b0ef2a4488 = 1;
    activity_instance thread function_e879f3e7b663d371();
    activity_instance childthread gemini_vo::function_7277bfe20071c789();
    activity_instance childthread function_cbeb04c4cf0a9881();
    activity_instance childthread function_4ea083f049eea61d();
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_armory_weapon", undefined, 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_armory_equipment", undefined, 1 );
    activity_instance thread ob_story_mission_utils::function_e6799e9a19df2365( "s_prison_armory_cache" );
    activity_instance thread function_2ce89151f0355b48();
    activity_instance thread function_5032e3d9f99a39d0();
    waitframe();
    activity_instance thread function_f93dfadbfc0c2b91();
    waitframe();
    activity_instance thread function_357fedf1dceb6d56();
    waitframe();
    activity_instance thread function_6e9ef02bb13a0a53();
    level utility::flag_wait_any( "flag_prison_armory_complete", "flag_prison_armory_ambush_soldiers_defeated", "flag_trig_prison_topside_armory_ambush_enter" );
    level utility::flag_wait( "flag_trig_prison_topside_armory_lockers_exit" );
    level utility::flag_set( "flag_prison_armory_complete" );
}

// Namespace namespace_31b2bab150bfb17a
// Params 1
// Checksum 0xef065310, Offset: 0xea6
// Size: 0x48
function prison_armory_player_setup( player )
{
    activity_instance = self;
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        player thread gemini_util::player_cold_breath_toggle( "flag_gemini_exfil_igc_begin" );
        player thread gemini_util::prison_ai_corpse_cleanup();
    }
}

// Namespace namespace_31b2bab150bfb17a
// Params 0
// Checksum 0xafd7767, Offset: 0xef6
// Size: 0xb9
function function_e879f3e7b663d371()
{
    level endon( #"game_ended" );
    
    if ( level utility::flag( "flag_prison_armory_oob_enabled" ) )
    {
        return;
    }
    
    var_402002104ec1b47d = getentarray( "v_oob_armory", #script_noteworthy );
    
    foreach ( vol in var_402002104ec1b47d )
    {
        outofbounds::function_ea64b5c2bd16e0f5( vol );
    }
    
    level utility::flag_set( "flag_prison_armory_oob_enabled" );
}

// Namespace namespace_31b2bab150bfb17a
// Params 0
// Checksum 0xec7ac629, Offset: 0xfb7
// Size: 0xae
function function_c28c596cbfcd0e22()
{
    level utility::flag_wait( "scriptables_ready" );
    scriptable_targetnames = [ "e_prison_minecarts_building1_gate_interact", "e_prison_minecarts_building2_gate_interact" ];
    
    foreach ( targetname in scriptable_targetnames )
    {
        interact = gemini_util::get_scriptable( targetname );
        interact function_7653c765b6c7b815();
    }
}

/#

    // Namespace namespace_31b2bab150bfb17a
    // Params 0
    // Checksum 0x1c469695, Offset: 0x106d
    // Size: 0x5, Type: dev
    function function_bd35a25defaa37c7()
    {
        
    }

#/

// Namespace namespace_31b2bab150bfb17a
// Params 0, eflags: 0x4
// Checksum 0x8e82f012, Offset: 0x107a
// Size: 0x83
function private function_5032e3d9f99a39d0()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    activity_instance thread function_1ef211d956dbb53a( "sat_sm05_gemini_ai_encounter_topside_allyzombies_armory_entrance_lower_prio", 20 );
    wait 1;
    activity_instance thread function_1ef211d956dbb53a( "sat_sm05_gemini_ai_encounter_topside_allyzombies_armory_entrance_lower_prio2", 20 );
    wait 1;
    activity_instance thread function_1ef211d956dbb53a( "sat_sm05_gemini_ai_encounter_topside_allyzombies_armory_entrance_lower_prio3", 15 );
    wait 1;
    activity_instance thread function_1ef211d956dbb53a( "sat_sm05_gemini_ai_encounter_topside_allyzombies_armory_entrance_lower_prio4", 15 );
}

// Namespace namespace_31b2bab150bfb17a
// Params 2, eflags: 0x4
// Checksum 0x3b9dd336, Offset: 0x1105
// Size: 0xc5
function private function_1ef211d956dbb53a( ai_encounter_targetname, var_939a6122b3f49ea1 = 15 )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    request_id = activity_instance activity_ai_encounters::function_92b671064b0b1ce2( ai_encounter_targetname, 0, 1, 1, 2 );
    activity_ai_encounters::function_52d1342183200a8f( request_id, &function_f0a9b100ec8b5f6 );
    activity_ai_encounters::function_dcf6bdb6ee9d1ca0( request_id, &function_faf6a98b1fd28693 );
    activity_ai_encounters::function_d33de057e760c97b( request_id, &function_940d36a63b61d833, "flag_trig_prison_topside_spawn_zombies" );
    
    while ( !utility::flag( "flag_trig_prison_topside_armory_lockers_alert" ) )
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

// Namespace namespace_31b2bab150bfb17a
// Params 0
// Checksum 0xb9ccb014, Offset: 0x11d2
// Size: 0xc6
function function_f93dfadbfc0c2b91()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    utility::flag_wait( "flag_trig_prison_topside_armory_lockers_alert" );
    var_bf97c041cacb44f5 = activity_instance activity_ai_encounters::function_92b671064b0b1ce2( "sat_sm05_gemini_ai_encounter_topside_allyzombies_armory_ambush", 0, 1, 1, 2 );
    activity_ai_encounters::function_52d1342183200a8f( var_bf97c041cacb44f5, &function_f0a9b100ec8b5f6 );
    activity_ai_encounters::function_dcf6bdb6ee9d1ca0( var_bf97c041cacb44f5, &function_5b8910b422e48ce0 );
    activity_ai_encounters::function_d33de057e760c97b( var_bf97c041cacb44f5, &function_343d10092212696e, "flag_trig_prison_topside_spawn_zombies" );
    
    while ( !utility::flag( "flag_trig_prison_topside_spawn_zombies" ) )
    {
        count_all_ai = getaicount();
        
        if ( count_all_ai <= 20 )
        {
            activity_ai_encounters::function_48582991402cac50( var_bf97c041cacb44f5, 1 );
            break;
        }
        
        wait 1;
    }
}

// Namespace namespace_31b2bab150bfb17a
// Params 4, eflags: 0x4
// Checksum 0x5cccb639, Offset: 0x12a0
// Size: 0x2ad
function private function_f0a9b100ec8b5f6( requestid, instance, agent, userdata )
{
    level endon( #"game_ended" );
    agent endon( #"death" );
    agent gemini_util::function_376f4cf6d212ef9b( 5 );
    agent childthread gemini_util::function_11266ff8ae084f14( "flag_trig_prison_topside_armory_encounter_approach" );
    agent childthread function_abfa65aad675e168();
    
    if ( threatbiasgroupexists( "armory_entrance_zombies" ) )
    {
        agent setthreatbiasgroup( "armory_entrance_zombies" );
    }
    
    if ( !utility::flag( "flag_prison_armory_ambush_soldiers_spawned" ) )
    {
        s_armory_entrance = utility::getstruct( "s_prison_armory_entrance_zombie_attractor", "targetname" );
        agent function_fa32376aaa88a7a2( s_armory_entrance.origin, 6400 );
        
        if ( isdefined( level.var_6f1e76adcacad587 ) )
        {
            while ( isdefined( level.var_6f1e76adcacad587 ) && level.var_6f1e76adcacad587.ai_array.size > 0 )
            {
                ai_target = function_47c86977a18df38b( level.var_6f1e76adcacad587.ai_array, agent.origin, 6400 );
                
                if ( isalive( ai_target ) && ai_target.type != "zombie" )
                {
                    agent function_f2fdf8ef124744e8( 0, ai_target );
                    ai_target utility::waittill_notify_or_timeout( "death", 10 );
                    agent clearbtgoal( 0 );
                }
                
                wait 1;
            }
        }
        
        utility::flag_wait( "flag_prison_armory_entrance_soldiers_defeated" );
        s_armory_ambush = utility::getstruct( "s_prison_armory_ambush_zombie_attractor", "targetname" );
        agent function_fa32376aaa88a7a2( s_armory_ambush.origin, 6400 );
    }
    
    utility::flag_wait( "flag_prison_armory_topfloor_soldiers_defeated" );
    
    if ( isdefined( level.var_3a4610cde3168675 ) )
    {
        while ( isdefined( level.var_3a4610cde3168675 ) && level.var_3a4610cde3168675.ai_array.size > 0 )
        {
            ai_target = function_47c86977a18df38b( level.var_3a4610cde3168675.ai_array, agent.origin, 6400 );
            
            if ( isalive( ai_target ) && ai_target.type != "zombie" )
            {
                agent function_f2fdf8ef124744e8( 0, ai_target );
                ai_target utility::waittill_notify_or_timeout( "death", 10 );
                agent clearbtgoal( 0 );
            }
            
            wait 1;
        }
    }
    
    utility::flag_wait( "flag_prison_armory_ambush_soldiers_defeated" );
    agent clearbtgoal( 0 );
    var_d223d9a0dc2876e4 = utility::getstruct( "s_prison_armory_end_zombie_attractor", "targetname" );
    agent function_fa32376aaa88a7a2( var_d223d9a0dc2876e4.origin, 4000 );
    agent thread gemini_util::ai_delete_when_out_of_sight( 768, 1536 );
}

// Namespace namespace_31b2bab150bfb17a
// Params 0, eflags: 0x4
// Checksum 0xde15af6c, Offset: 0x1555
// Size: 0x77
function private function_abfa65aad675e168()
{
    level endon( #"game_ended", #"flag_prison_armory_ambush_soldiers_defeated" );
    
    if ( utility::flag( "flag_prison_armory_ambush_soldiers_defeated" ) )
    {
        return;
    }
    
    while ( isalive( self ) )
    {
        gemini_util::function_f53463c3213de6a1( "s_prison_armory_end_zombie_attractor", "flag_prison_armory_ambush_soldiers_spawned", 20, 10 );
        
        if ( level.players.size > 2 )
        {
            wait randomfloatrange( 1, 5 );
            continue;
        }
        
        wait randomfloatrange( 1, 9 );
    }
}

// Namespace namespace_31b2bab150bfb17a
// Params 2, eflags: 0x4
// Checksum 0xa91b5235, Offset: 0x15d4
// Size: 0x41, Type: bool
function private function_faf6a98b1fd28693( requestid, userdata )
{
    count_all_ai = getaicount();
    
    if ( count_all_ai > 20 )
    {
        return false;
    }
    
    if ( utility::flag( "flag_trig_prison_topside_armory_lockers_alert" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_31b2bab150bfb17a
// Params 2, eflags: 0x4
// Checksum 0xc762e6d, Offset: 0x161e
// Size: 0x27, Type: bool
function private function_940d36a63b61d833( requestid, userdata )
{
    if ( utility::flag( "flag_trig_prison_topside_armory_lockers_alert" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_31b2bab150bfb17a
// Params 2, eflags: 0x4
// Checksum 0xc87fba09, Offset: 0x164e
// Size: 0x41, Type: bool
function private function_5b8910b422e48ce0( requestid, userdata )
{
    count_all_ai = getaicount();
    
    if ( count_all_ai > 20 )
    {
        return false;
    }
    
    if ( utility::flag( "flag_trig_prison_topside_spawn_zombies" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_31b2bab150bfb17a
// Params 2, eflags: 0x4
// Checksum 0xd43e73ca, Offset: 0x1698
// Size: 0x27, Type: bool
function private function_343d10092212696e( requestid, userdata )
{
    if ( utility::flag( "flag_trig_prison_topside_spawn_zombies" ) )
    {
        return true;
    }
    
    return false;
}

/#

    // Namespace namespace_31b2bab150bfb17a
    // Params 0
    // Checksum 0x1e0725de, Offset: 0x16c8
    // Size: 0x5, Type: dev
    function function_75a45b38e9980e4c()
    {
        
    }

#/

// Namespace namespace_31b2bab150bfb17a
// Params 0
// Checksum 0xec6cf2fb, Offset: 0x16d5
// Size: 0x11a
function function_88caaa909a57c15a()
{
    if ( !isdefined( level.var_6f1e76adcacad587 ) )
    {
        level.var_6f1e76adcacad587 = spawnstruct();
        
        if ( !isdefined( level.var_6f1e76adcacad587.ai_array ) )
        {
            level.var_6f1e76adcacad587.ai_array = [];
        }
    }
    
    if ( !isdefined( level.var_9deba1900cbce730 ) )
    {
        level.var_9deba1900cbce730 = spawnstruct();
        
        if ( !isdefined( level.var_9deba1900cbce730.ai_array ) )
        {
            level.var_9deba1900cbce730.ai_array = [];
        }
    }
    
    if ( !isdefined( level.var_7591deaf87d32672 ) )
    {
        level.var_7591deaf87d32672 = spawnstruct();
        
        if ( !isdefined( level.var_7591deaf87d32672.ai_array ) )
        {
            level.var_7591deaf87d32672.ai_array = [];
        }
    }
    
    if ( !isdefined( level.var_3a4610cde3168675 ) )
    {
        level.var_3a4610cde3168675 = spawnstruct();
        
        if ( !isdefined( level.var_3a4610cde3168675.ai_array ) )
        {
            level.var_3a4610cde3168675.ai_array = [];
        }
    }
}

// Namespace namespace_31b2bab150bfb17a
// Params 0
// Checksum 0xc8df8815, Offset: 0x17f7
// Size: 0x57
function function_4c86d412ebfdbccd()
{
    activity_instance = self;
    level endon( #"game_ended" );
    function_88caaa909a57c15a();
    activity_instance gemini_util::function_51e3aaef58423855( "sat_sm04_gemini_ai_encounter_topside_soldiers_armory_entrance", &function_96f6d9c16cdc775d, undefined, "flag_trig_prison_topside_armory_lockers_exit", 2, 0, undefined, &function_99dd2ca38a8e408f );
    waitframe();
    activity_instance childthread function_630092c7c4c0766c();
    activity_instance childthread function_9f718d8036c66ef4();
}

// Namespace namespace_31b2bab150bfb17a
// Params 0, eflags: 0x4
// Checksum 0x9c2efa82, Offset: 0x1856
// Size: 0x76
function private function_357fedf1dceb6d56()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    function_88caaa909a57c15a();
    level utility::flag_wait_any( "flag_prison_minecarts_completed", "flag_trig_prison_topside_armory_encounter_approach" );
    activity_instance gemini_util::function_51e3aaef58423855( "sat_sm04_gemini_ai_encounter_topside_soldiers_armory_topfloor", &function_a49a30b07521a31a, undefined, "flag_trig_prison_topside_armory_lockers_exit", 2, 0, undefined, &function_eaf1221a422a22fe );
    waitframe();
    activity_instance childthread function_c95f8d2c45910877();
}

// Namespace namespace_31b2bab150bfb17a
// Params 0, eflags: 0x4
// Checksum 0xe118f010, Offset: 0x18d4
// Size: 0x79
function private function_6e9ef02bb13a0a53()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    function_88caaa909a57c15a();
    utility::flag_wait_any( "flag_trig_prison_topside_armory_lockers_entrance", "flag_prison_armory_entrance_soldiers_defeated" );
    activity_instance gemini_util::function_51e3aaef58423855( "sat_sm04_gemini_ai_encounter_topside_soldiers_armory_ambush", &function_52bb0c3030467dab, undefined, "flag_trig_prison_topside_spawn_zombies", 2, 0, &function_dcf138133db65c94, &function_eab38c35737b550d );
    waitframe();
    activity_instance childthread function_76ad9539a4e2c1c2();
}

// Namespace namespace_31b2bab150bfb17a
// Params 3, eflags: 0x4
// Checksum 0x95827b7c, Offset: 0x1955
// Size: 0x56, Type: bool
function private function_dcf138133db65c94( requestid, userdata, wavenumber )
{
    if ( utility::flag( "flag_trig_prison_topside_armory_ambush_enter" ) )
    {
        return false;
    }
    
    data = function_9b649316adcccbaa( requestid );
    
    if ( data.ai.size <= 2 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_31b2bab150bfb17a
// Params 2, eflags: 0x4
// Checksum 0x81fa4c2d, Offset: 0x19b4
// Size: 0x21
function private function_99dd2ca38a8e408f( requestid, userdata )
{
    utility::flag_set( "flag_prison_armory_entrance_soldiers_spawned" );
}

// Namespace namespace_31b2bab150bfb17a
// Params 2, eflags: 0x4
// Checksum 0xfba1331e, Offset: 0x19dd
// Size: 0x21
function private function_eaf1221a422a22fe( requestid, userdata )
{
    utility::flag_set( "flag_prison_armory_topfloor_soldiers_spawned" );
}

// Namespace namespace_31b2bab150bfb17a
// Params 2, eflags: 0x4
// Checksum 0xe6d68463, Offset: 0x1a06
// Size: 0x21
function private function_eab38c35737b550d( requestid, userdata )
{
    utility::flag_set( "flag_prison_armory_ambush_soldiers_spawned" );
}

// Namespace namespace_31b2bab150bfb17a
// Params 4, eflags: 0x4
// Checksum 0x389678a4, Offset: 0x1a2f
// Size: 0x12e
function private function_96f6d9c16cdc775d( requestid, instance, agent, userdata )
{
    level endon( #"game_ended" );
    agent endon( #"death" );
    
    if ( agent.basearchetype != "zombie_base" )
    {
        agent thread gemini_util::function_7653e4bbe774fb50( level.var_6f1e76adcacad587 );
    }
    
    if ( isdefined( agent.directorspawndata.script_noteworthy ) )
    {
        switch ( agent.directorspawndata.script_noteworthy )
        {
            case #"hash_c9ce32066612c729":
                agent.var_ee914ad666562200 = 1;
                agent.dontmeleeme = 0;
                childthread function_4572e24f114ee387();
                agent agent_utils::function_1874e18b42e6d814( &gemini_util::function_cb3d5af3567a0360 );
                agent thread gemini_util::function_7653e4bbe774fb50( level.var_9deba1900cbce730 );
                break;
            case #"hash_c6e5431e8d48296d":
                if ( threatbiasgroupexists( "armory_entrance_door_soldiers" ) )
                {
                    agent setthreatbiasgroup( "armory_entrance_door_soldiers" );
                }
            default:
                agent agent_utils::function_1874e18b42e6d814( &gemini_util::function_cb3d5af3567a0360 );
                break;
        }
    }
}

// Namespace namespace_31b2bab150bfb17a
// Params 4, eflags: 0x4
// Checksum 0x2d0e7e5b, Offset: 0x1b65
// Size: 0xce
function private function_a49a30b07521a31a( requestid, instance, agent, userdata )
{
    level endon( #"game_ended" );
    agent endon( #"death" );
    
    if ( agent.basearchetype != "zombie_base" )
    {
        agent thread gemini_util::function_7653e4bbe774fb50( level.var_7591deaf87d32672 );
    }
    
    if ( isdefined( agent.directorspawndata.script_noteworthy ) )
    {
        switch ( agent.directorspawndata.script_noteworthy )
        {
            case #"hash_e74d0511a87c87dc":
                agent childthread function_4f6cba02127c4928();
            default:
                agent agent_utils::function_1874e18b42e6d814( &gemini_util::function_cb3d5af3567a0360 );
                break;
        }
    }
}

// Namespace namespace_31b2bab150bfb17a
// Params 4, eflags: 0x4
// Checksum 0x416f1d85, Offset: 0x1c3b
// Size: 0xe4
function private function_52bb0c3030467dab( requestid, instance, agent, userdata )
{
    level endon( #"game_ended" );
    agent endon( #"death" );
    
    if ( agent.basearchetype != "zombie_base" )
    {
        agent thread gemini_util::function_7653e4bbe774fb50( level.var_3a4610cde3168675 );
    }
    
    if ( isdefined( agent.directorspawndata.script_noteworthy ) )
    {
        switch ( agent.directorspawndata.script_noteworthy )
        {
            case #"hash_4ad475e6e15635bd":
                agent.dontmeleeme = 0;
                agent.goalradius = 384;
                break;
            default:
                agent agent_utils::function_1874e18b42e6d814( &gemini_util::function_cb3d5af3567a0360 );
                break;
        }
    }
}

// Namespace namespace_31b2bab150bfb17a
// Params 0, eflags: 0x4
// Checksum 0xf50d2bc0, Offset: 0x1d27
// Size: 0x3f
function private function_4572e24f114ee387()
{
    utility::flag_wait( "flag_trig_armory_entrance_blockade_free" );
    wait randomfloatrange( 1, 3 );
    
    /#
        iprintln( "<dev string:x24>" );
    #/
    
    self.var_ee914ad666562200 = 0;
    self.goalradius = 64;
}

// Namespace namespace_31b2bab150bfb17a
// Params 0, eflags: 0x4
// Checksum 0xc8758c59, Offset: 0x1d6e
// Size: 0x93
function private function_630092c7c4c0766c()
{
    activity_instance = self;
    utility::flag_wait( "flag_prison_armory_entrance_soldiers_spawned" );
    assert( isdefined( level.var_6f1e76adcacad587 ), "<dev string:x37>" );
    
    while ( level.var_6f1e76adcacad587.ai_array.size > 0 )
    {
        waitframe();
        level.var_6f1e76adcacad587 gemini_util::ai_array_cleanup( "soldier" );
    }
    
    utility::flag_set( "flag_prison_armory_entrance_soldiers_defeated" );
    
    /#
        iprintlnbold( "<dev string:x67>" );
    #/
    
    activity_instance thread gemini_util::function_b8a6e5d594fbfcc3( "s_prison_armory_ambush_zombie_attractor", undefined, "flag_prison_topside_armory_lockers_combat", 1 );
}

// Namespace namespace_31b2bab150bfb17a
// Params 0, eflags: 0x4
// Checksum 0x57d5093f, Offset: 0x1e09
// Size: 0x7d
function private function_9f718d8036c66ef4()
{
    activity_instance = self;
    utility::flag_wait( "flag_prison_armory_entrance_soldiers_spawned" );
    assert( isdefined( level.var_9deba1900cbce730 ), "<dev string:x37>" );
    
    while ( level.var_9deba1900cbce730.ai_array.size > 0 )
    {
        waitframe();
        level.var_9deba1900cbce730 gemini_util::ai_array_cleanup( "soldier" );
    }
    
    utility::flag_set( "flag_prison_armory_entrance_riotshields_defeated" );
    
    /#
        iprintlnbold( "<dev string:x95>" );
    #/
}

// Namespace namespace_31b2bab150bfb17a
// Params 0, eflags: 0x4
// Checksum 0x778cd5ac, Offset: 0x1e8e
// Size: 0x7d
function private function_c95f8d2c45910877()
{
    activity_instance = self;
    utility::flag_wait( "flag_prison_armory_topfloor_soldiers_spawned" );
    assert( isdefined( level.var_7591deaf87d32672 ), "<dev string:xc6>" );
    
    while ( level.var_7591deaf87d32672.ai_array.size > 0 )
    {
        waitframe();
        level.var_7591deaf87d32672 gemini_util::ai_array_cleanup( "soldier" );
    }
    
    utility::flag_set( "flag_prison_armory_topfloor_soldiers_defeated" );
    
    /#
        iprintlnbold( "<dev string:xfd>" );
    #/
}

// Namespace namespace_31b2bab150bfb17a
// Params 0, eflags: 0x4
// Checksum 0x20fb24f6, Offset: 0x1f13
// Size: 0x93
function private function_76ad9539a4e2c1c2()
{
    activity_instance = self;
    utility::flag_wait( "flag_prison_armory_ambush_soldiers_spawned" );
    assert( isdefined( level.var_3a4610cde3168675 ), "<dev string:x12b>" );
    
    while ( level.var_3a4610cde3168675.ai_array.size > 0 )
    {
        waitframe();
        level.var_3a4610cde3168675 gemini_util::ai_array_cleanup( "soldier" );
    }
    
    utility::flag_set( "flag_prison_armory_ambush_soldiers_defeated" );
    
    /#
        iprintlnbold( "<dev string:x15c>" );
    #/
    
    activity_instance thread gemini_util::function_b8a6e5d594fbfcc3( "s_prison_armory_end_zombie_attractor", undefined, "flag_trig_prison_topside_spawn_zombies", 1 );
}

// Namespace namespace_31b2bab150bfb17a
// Params 0, eflags: 0x4
// Checksum 0x710c97d, Offset: 0x1fae
// Size: 0x1e5
function private function_4f6cba02127c4928()
{
    self endon( #"death" );
    
    if ( !isdefined( level.var_7591deaf87d32672 ) )
    {
        level.var_7591deaf87d32672 = spawnstruct();
        
        if ( !isdefined( level.var_7591deaf87d32672.ai_array ) )
        {
            level.var_7591deaf87d32672.ai_array = [];
        }
    }
    
    thread gemini_util::function_7653e4bbe774fb50( level.var_7591deaf87d32672 );
    self.ignoreall = 1;
    self.ignoreme = 1;
    childthread function_1919cf9c0272c017();
    childthread function_72dc2b07aff2dd68();
    utility::flag_wait( "flag_trig_prison_topside_armory_lockers_entrance" );
    self.ignoreme = 0;
    utility::waittill_any( "damage", "bulletwhizby", "notify_armory_secondfloor_player_presence", "grenade danger", "proximity", "ally_damaged", "ally_killed" );
    utility::flag_set( "flag_prison_topside_armory_lockers_combat" );
    self notify( #"hash_915fa10aa5181997" );
    
    foreach ( guy in level.var_7591deaf87d32672.ai_array )
    {
        if ( isalive( guy ) )
        {
            guy thread utility::delay_notify( randomfloatrange( 0.5, 1.5 ), "notify_armory_secondfloor_player_presence", "death" );
        }
    }
    
    self.ignoreall = 0;
    
    while ( level.var_7591deaf87d32672.ai_array.size > 1 )
    {
        level.var_7591deaf87d32672 gemini_util::ai_array_cleanup( "soldier" );
        waitframe();
    }
    
    vol_armory_exit = getent( "vol_armory_exit", #targetname );
    self setgoalvolumeauto( vol_armory_exit );
}

// Namespace namespace_31b2bab150bfb17a
// Params 0, eflags: 0x4
// Checksum 0x4a7055ea, Offset: 0x219b
// Size: 0x8f
function private function_72dc2b07aff2dd68()
{
    self endon( #"death", #"hash_915fa10aa5181997" );
    level utility::flag_wait( "flag_trig_prison_topside_armory_lockers_alert" );
    n_alert_time = gettime() + utility::function_4b74c15943231980( randomfloatrange( 4, 6 ) );
    
    while ( gettime() < n_alert_time )
    {
        a_players = getplayersinradius( self.origin, 128 );
        
        if ( a_players.size > 0 )
        {
            break;
        }
        
        wait 1;
    }
    
    self notify( #"notify_armory_secondfloor_player_presence" );
}

// Namespace namespace_31b2bab150bfb17a
// Params 0, eflags: 0x4
// Checksum 0x300068ef, Offset: 0x2232
// Size: 0xd0
function private function_1919cf9c0272c017()
{
    self endon( #"death", #"hash_915fa10aa5181997" );
    var_b691beb95f0bfacc = utility::getstructarray( "s_armory_topfloor_set_dressing_shootat_target", "targetname" );
    
    if ( !isdefined( var_b691beb95f0bfacc ) || var_b691beb95f0bfacc.size <= 0 )
    {
        /#
            iprintlnbold( "<dev string:x188>" );
        #/
        
        return;
    }
    
    shootat_target = utility::array_random( var_b691beb95f0bfacc );
    var_db535fce4e9b23a3 = randomintrange( 20, 45 );
    
    for ( shots_fired = 0; true ; shots_fired = 0 )
    {
        if ( shots_fired < var_db535fce4e9b23a3 )
        {
            self shoot( 1, shootat_target.origin, 1, 1, 0 );
            shots_fired += 1;
            wait 0.125;
            continue;
        }
        
        wait 1.5;
        shootat_target = utility::array_random( var_b691beb95f0bfacc );
    }
}

// Namespace namespace_31b2bab150bfb17a
// Params 0, eflags: 0x4
// Checksum 0x2c9817ff, Offset: 0x230a
// Size: 0x1af
function private function_2ce89151f0355b48()
{
    /#
        iprintlnbold( "<dev string:x1c4>" );
    #/
    
    if ( isdefined( level.minecarts_enemy_soldiers ) )
    {
        level.minecarts_enemy_soldiers gemini_util::ai_array_cleanup( "soldier" );
        
        if ( level.minecarts_enemy_soldiers.ai_array.size > 0 )
        {
            foreach ( guy in level.minecarts_enemy_soldiers.ai_array )
            {
                if ( isalive( guy ) )
                {
                    guy gemini_util::ai_delete_when_out_of_sight( 512, 1024 );
                }
            }
        }
    }
    
    if ( isdefined( level.var_c5fdbf7b47e210ae ) )
    {
        level.var_c5fdbf7b47e210ae gemini_util::ai_array_cleanup( "zombie_base" );
        
        if ( level.var_c5fdbf7b47e210ae.ai_array.size > 0 )
        {
            foreach ( var_95e210b9b3228eab in level.var_c5fdbf7b47e210ae.ai_array )
            {
                if ( isalive( var_95e210b9b3228eab ) )
                {
                    var_95e210b9b3228eab gemini_util::ai_delete_when_out_of_sight( 512, 1024 );
                }
            }
        }
    }
}

/#

    // Namespace namespace_31b2bab150bfb17a
    // Params 0
    // Checksum 0x87a1dd65, Offset: 0x24c1
    // Size: 0x5, Type: dev
    function function_4152716244a63d96()
    {
        
    }

#/

// Namespace namespace_31b2bab150bfb17a
// Params 0
// Checksum 0x4cda4b70, Offset: 0x24ce
// Size: 0x15b
function function_b317ecf8c6509b49()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    var_43921ea2e3c00c52 = utility::getstructarray( "scene_armory_feeding_zmb", "targetname" );
    allocated_ai = var_43921ea2e3c00c52.size * 3;
    var_d34f383fd9317e14 = getaispeciesarray( "all", "zombie" );
    var_5314729e5483f43a = 0;
    
    foreach ( guy in var_d34f383fd9317e14 )
    {
        var_f912c3050ae9e947 = guy gemini_util::function_d4451e723cacc364();
        
        if ( !var_f912c3050ae9e947 )
        {
            guy gemini_util::function_6db88e9571f4e393();
            var_5314729e5483f43a += 1;
            var_d34f383fd9317e14 = arrayremove( var_d34f383fd9317e14, guy );
        }
        
        if ( var_5314729e5483f43a >= allocated_ai )
        {
            break;
        }
    }
    
    activity_instance thread gemini_util::function_b2e3b9ccdce5ec87( "scene_armory_feeding_zmb", undefined, undefined, undefined, "flag_prison_armory_complete" );
    utility::flag_set( "flag_armory_setdressing_initiated" );
    level.var_d9600188c0b05bac = utility::getent_or_struct_array( "sm_armory_battle_setdressing", "targetname" );
}

/#

    // Namespace namespace_31b2bab150bfb17a
    // Params 0
    // Checksum 0xebefd14f, Offset: 0x2631
    // Size: 0x5, Type: dev
    function function_f5427601b43a8b8b()
    {
        
    }

#/

// Namespace namespace_31b2bab150bfb17a
// Params 0, eflags: 0x4
// Checksum 0xb21e037f, Offset: 0x263e
// Size: 0x3b
function private function_4ea083f049eea61d()
{
    ob_story_mission_utils::objective_text_show( "OB_GEMINI_PRISON_ARMORY" );
    mission_ui::function_759924b87215156b( 0, 1, level.players );
    level utility::flag_wait( "flag_trig_prison_topside_armory_lockers_exit" );
    waitframe();
    ob_story_mission_utils::objective_text_show( "OB_GEMINI_PRISON_TOPSIDE" );
}

// Namespace namespace_31b2bab150bfb17a
// Params 0, eflags: 0x4
// Checksum 0x892aec1, Offset: 0x2681
// Size: 0xaf
function private function_cbeb04c4cf0a9881()
{
    activity_instance = self;
    activity_instance.var_81c59024e0ba036 = spawnstruct();
    activity_instance.var_81c59024e0ba036.objective = "sat_ob_objectivemarker_storymissionmain";
    activity_instance.var_81c59024e0ba036.waypoint = "sat_ob_objectivemarker_location";
    activity_instance thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "s_obj_prison_armory_lockers", activity_instance.var_81c59024e0ba036, "notify_prison_armory_waypoint_lockers", undefined, undefined, 1 );
    level utility::flag_wait( "flag_trig_prison_armory_lockers_approach" );
    waypoint_objective_handler::waypoint_objective_handler_cancel( "s_obj_prison_armory_lockers" );
    waitframe();
    activity_instance thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "s_obj_prison_armory_exit", "sat_ob_objectivemarker_location", "notify_prison_armory_waypoint_exit", undefined, undefined, 1 );
}

