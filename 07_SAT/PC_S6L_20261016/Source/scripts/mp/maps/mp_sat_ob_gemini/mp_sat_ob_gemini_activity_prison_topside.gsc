// scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_activity_prison_topside.gsc  (hash_648d6db075416416.gscc) (size: 20759 Bytes / 0x5117 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa72f028d (2804875917)
// size ...... 20759 (0x5117)
// includes .. 20  (offset: 0x4b47)
// strings ... 75  (offset: 0x4be7)
// dev strs .. 13  (offset: 0x5073)
// exports ... 51  (offset: 0x2f87)
// cseg ...... 0xb13 + 0x2474 (0x2f87)
// imports ... 163 (offset: 0x377f)
// animtree1 . 0   (offset: 0x5117)
// animtree2 . 0   (offset: 0x5117)
#using script_2304453c69e996e2;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_interact;
#using scripts\common\waypoint_objective_handler;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_activity_prison_armory;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_util;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_vo;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_vtol;
#using scripts\mp\ob\activities\ob_activity_heli_takedown;
#using scripts\mp\outofbounds;

#namespace namespace_325e21231ce5a0e0;

// Namespace namespace_325e21231ce5a0e0
// Params 0, eflags: 0x5
// Checksum 0xd7bf48d0, Offset: 0xb31
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_94035570a5e3d88", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_325e21231ce5a0e0
// Params 0, eflags: 0x4
// Checksum 0xb88b8ac, Offset: 0xb5a
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_GEMINI_PRISON_TOPSIDE";
    activity_common::registeractivitytype( "OB_GEMINI_PRISON_TOPSIDE", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_PRISON_TOPSIDE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_PRISON_TOPSIDE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_PRISON_TOPSIDE", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_GEMINI_PRISON_TOPSIDE" );
}

// Namespace namespace_325e21231ce5a0e0
// Params 0
// Checksum 0xfc38149d, Offset: 0xbd1
// Size: 0x59
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance prison_topside_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_325e21231ce5a0e0
// Params 0
// Checksum 0x97800798, Offset: 0xc32
// Size: 0x39
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance prison_topside_main();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_325e21231ce5a0e0
// Params 0
// Checksum 0x45eb3441, Offset: 0xc73
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_325e21231ce5a0e0
// Params 1
// Checksum 0xc7689209, Offset: 0xc97
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread prison_topside_player_setup( player );
    }
}

// Namespace namespace_325e21231ce5a0e0
// Params 0
// Checksum 0xd4c69fb1, Offset: 0xd53
// Size: 0xc5
function prison_topside_start()
{
    activity_instance = self;
    sbm_minecarts_breakable_barrier = getent( "sbm_minecarts_breakable_barrier", #targetname );
    sm_minecarts_breakable_barrier = getent( "sm_minecarts_breakable_barrier", #targetname );
    sbm_minecarts_breakable_barrier hide();
    sbm_minecarts_breakable_barrier connectpaths();
    sm_minecarts_breakable_barrier setscriptablepartstate( "main", "dead_nofx" );
    utility::flag_set( "flag_trig_prison_topside_spawn_zombies" );
    utility::flag_set( "flag_prison_armory_complete" );
    gemini_util::function_34a3d0cff5de2d7d();
    gemini_util::function_dfcbf5f9b3b2e6a0();
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_armory_weapon", undefined, 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_armory_equipment", undefined, 1 );
    activity_instance thread ob_story_mission_utils::function_e6799e9a19df2365( "s_prison_armory_cache" );
    activity_instance thread namespace_31b2bab150bfb17a::function_e879f3e7b663d371();
}

// Namespace namespace_325e21231ce5a0e0
// Params 0
// Checksum 0x2d53a5ed, Offset: 0xe20
// Size: 0xcd
function prison_topside_main()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    level.var_d53163b0ef2a4488 = 1;
    activity_instance childthread function_5e9eddeb41a2b4d7();
    activity_instance childthread function_d777c22ec9110368();
    activity_instance childthread function_3c6ef4db7eb04ab7();
    activity_instance childthread function_9c5924de5ad05bf();
    activity_instance childthread gemini_vo::function_3659422881b9539b();
    level.onplayerdamaged = &gemini_util::function_24410a0d29b3ba36;
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_topside_armory_weapon", undefined, 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_prison_topside_equipment", undefined, 1 );
    activity_instance thread function_f87366f66596a16a();
    waitframe();
    activity_instance thread function_fe77f971d20e0cda();
    waitframe();
    activity_instance thread function_6a1f7d6d9bbb0a73();
    waitframe();
    activity_instance thread function_721c48645685c147();
    level utility::flag_wait( "flag_prison_topside_completed" );
}

// Namespace namespace_325e21231ce5a0e0
// Params 1
// Checksum 0x472be23b, Offset: 0xef5
// Size: 0x51
function prison_topside_player_setup( player )
{
    activity_instance = self;
    player thread gemini_util::function_bbf656a0b4c64354();
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        player thread gemini_util::player_cold_breath_toggle( "flag_gemini_exfil_igc_begin" );
        player thread gemini_util::prison_ai_corpse_cleanup();
    }
}

// Namespace namespace_325e21231ce5a0e0
// Params 0, eflags: 0x4
// Checksum 0xd7139bd1, Offset: 0xf4e
// Size: 0x13f
function private function_a997d4a88b73ae09()
{
    level endon( #"game_ended", #"flag_trig_prison_topside_advance" );
    activity_instance = self;
    a_s_killzone = utility::getstructarray( "s_prison_topside_enter_magic_grenade", "targetname" );
    wait 1;
    
    while ( !utility::flag( "flag_trig_prison_topside_advance" ) )
    {
        if ( a_s_killzone.size == 0 )
        {
            break;
        }
        
        n_wait = 1;
        temparray = function_aa72fc373c82d642( a_s_killzone );
        
        if ( temparray.size > 1 )
        {
            tempowner = level.topside_enemy_soldiers.ai_array[ 0 ];
            
            if ( isdefined( tempowner ) )
            {
                zombie = temparray[ 0 ];
                s_killzone = temparray[ 1 ];
                tempowner launchgrenade( "sat_frag_grenade_mp", zombie.origin + ( 0, 0, 10 ), ( 0, 0, 0 ), 0.05 );
                
                if ( utility::flag( "flag_prison_armory_complete" ) )
                {
                    a_s_killzone = arrayremove( a_s_killzone, s_killzone );
                    n_wait = randomfloatrange( 5, 15 );
                }
                else
                {
                    n_wait = randomfloatrange( 2, 8 );
                }
            }
        }
        
        wait n_wait;
    }
}

// Namespace namespace_325e21231ce5a0e0
// Params 0, eflags: 0x4
// Checksum 0x24385e28, Offset: 0x1095
// Size: 0x115
function private function_f531838f1e93111f()
{
    level endon( #"game_ended", #"flag_prison_topside_completed" );
    activity_instance = self;
    a_s_killzone = utility::getstructarray( "s_prison_topside_exit_magic_grenade", "targetname" );
    wait 1;
    
    while ( !utility::flag( "flag_prison_topside_completed" ) )
    {
        if ( a_s_killzone.size == 0 )
        {
            break;
        }
        
        n_wait = 1;
        temparray = function_aa72fc373c82d642( a_s_killzone );
        
        if ( temparray.size > 1 )
        {
            tempowner = level.var_a089036921d6d51a.ai_array[ 0 ];
            
            if ( isdefined( tempowner ) )
            {
                zombie = temparray[ 0 ];
                s_killzone = temparray[ 1 ];
                tempowner launchgrenade( "sat_frag_grenade_mp", zombie.origin + ( 0, 0, 10 ), ( 0, 0, 0 ), 0.05 );
                n_wait = randomfloatrange( 2, 8 );
            }
        }
        
        wait n_wait;
    }
}

// Namespace namespace_325e21231ce5a0e0
// Params 1, eflags: 0x4
// Checksum 0x8ead8b8, Offset: 0x11b2
// Size: 0xa9
function private function_aa72fc373c82d642( a_s_killzone )
{
    a_s_killzone = arrayrandomize( a_s_killzone );
    a_players = ob_story_mission_utils::get_playing_players();
    a_blank = [];
    
    for ( i = 0; i < a_s_killzone.size ; i++ )
    {
        var_d0bf10f61a87b364 = getaiarrayinradius( a_s_killzone[ i ].origin, 256, a_players[ 0 ].team );
        
        if ( var_d0bf10f61a87b364.size > 1 )
        {
            var_d0bf10f61a87b364 = function_628bac9faa9d1e86( var_d0bf10f61a87b364, a_s_killzone[ i ].origin );
            return [ var_d0bf10f61a87b364[ 0 ], a_s_killzone[ i ] ];
        }
        
        waitframe();
    }
    
    return a_blank;
}

// Namespace namespace_325e21231ce5a0e0
// Params 0
// Checksum 0xb57b79ae, Offset: 0x1264
// Size: 0xb9
function function_5e9eddeb41a2b4d7()
{
    level endon( #"game_ended" );
    
    if ( level utility::flag( "flag_prison_topside_oob_enabled" ) )
    {
        return;
    }
    
    var_c2265297e3ffaee3 = getentarray( "v_oob_topside", #script_noteworthy );
    
    foreach ( vol in var_c2265297e3ffaee3 )
    {
        outofbounds::function_ea64b5c2bd16e0f5( vol );
    }
    
    level utility::flag_set( "flag_prison_topside_oob_enabled" );
}

// Namespace namespace_325e21231ce5a0e0
// Params 0
// Checksum 0x49ed57c1, Offset: 0x1325
// Size: 0xb7
function function_d777c22ec9110368()
{
    if ( !isdefined( level.var_d9600188c0b05bac ) )
    {
        level.var_d9600188c0b05bac = utility::getent_or_struct_array( "sm_armory_battle_setdressing", "targetname" );
    }
    
    if ( level.var_d9600188c0b05bac.size > 0 )
    {
        foreach ( item in level.var_d9600188c0b05bac )
        {
            item delete();
        }
    }
    
    level.var_d9600188c0b05bac = undefined;
}

/#

    // Namespace namespace_325e21231ce5a0e0
    // Params 0
    // Checksum 0x501c870f, Offset: 0x13e4
    // Size: 0x5, Type: dev
    function function_bd35a25defaa37c7()
    {
        
    }

#/

// Namespace namespace_325e21231ce5a0e0
// Params 0, eflags: 0x4
// Checksum 0xd9256ebf, Offset: 0x13f1
// Size: 0xaf
function private function_fe77f971d20e0cda()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    activity_instance thread function_562cb2caf28424d8( "sat_sm04_gemini_ai_encounter_topside_allyzombies_lowerprio", 25 );
    wait 1;
    activity_instance thread function_562cb2caf28424d8( "sat_sm04_gemini_ai_encounter_topside_allyzombies_left", 25 );
    wait 1;
    activity_instance thread function_562cb2caf28424d8( "sat_sm04_gemini_ai_encounter_topside_allyzombies_right", 25 );
    wait 1;
    activity_instance thread function_562cb2caf28424d8( "sat_sm04_gemini_ai_encounter_topside_allyzombies_lowerprio2", 25 );
    wait 1;
    activity_instance thread function_562cb2caf28424d8( "sat_sm04_gemini_ai_encounter_topside_allyzombies_lowerprio3", 20 );
    wait 1;
    activity_instance thread function_562cb2caf28424d8( "sat_sm04_gemini_ai_encounter_topside_allyzombies_lowerprio4", 20 );
}

// Namespace namespace_325e21231ce5a0e0
// Params 2, eflags: 0x4
// Checksum 0xca4a4e57, Offset: 0x14a8
// Size: 0xc0
function private function_562cb2caf28424d8( ai_encounter_targetname, var_939a6122b3f49ea1 = 20 )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    request_id = activity_instance activity_ai_encounters::function_92b671064b0b1ce2( ai_encounter_targetname, 0, 1, 1, 2 );
    activity_ai_encounters::function_52d1342183200a8f( request_id, &function_25b62ee6cc97bbb0 );
    activity_ai_encounters::function_dcf6bdb6ee9d1ca0( request_id, &function_f9638e72e954a215 );
    activity_ai_encounters::function_d33de057e760c97b( request_id, &function_cd1c30ee2467f095 );
    
    while ( !utility::flag( "flag_prison_topside_completed" ) )
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

// Namespace namespace_325e21231ce5a0e0
// Params 4, eflags: 0x4
// Checksum 0x482ab4f0, Offset: 0x1570
// Size: 0x1e6
function private function_25b62ee6cc97bbb0( requestid, instance, agent, userdata )
{
    level endon( #"game_ended" );
    agent endon( #"death" );
    agent gemini_util::function_376f4cf6d212ef9b( 5 );
    agent childthread gemini_util::function_11266ff8ae084f14( "flag_trig_prison_topside_advance" );
    agent childthread function_eaf062a41330a592();
    
    if ( !isdefined( level.vol_topside_soldier_fallback ) )
    {
        level.vol_topside_soldier_fallback = getent( "vol_topside_soldier_fallback", #targetname );
    }
    
    if ( !isdefined( level.vol_finalpush_soldier_main ) )
    {
        level.vol_finalpush_soldier_main = getent( "vol_finalpush_soldier_main", #targetname );
    }
    
    agent.var_18df753f0509540c = 0;
    
    while ( !utility::flag( "flag_topside_soldiers_defeated" ) )
    {
        if ( agent.directorspawndata.script_noteworthy == "zombie_topside_left" && level.var_e5810ebf65166f.ai_array.size > 0 )
        {
            agent function_8ea5fa7096858b27( "left" );
        }
        else if ( agent.directorspawndata.script_noteworthy == "zombie_topside_right" && level.var_bb6a3e8c28c97160.ai_array.size > 0 )
        {
            agent function_8ea5fa7096858b27( "right" );
        }
        else
        {
            agent function_8ea5fa7096858b27( "default" );
        }
        
        wait 1;
    }
    
    agent gemini_util::ai_nerf( undefined, "run" );
    utility::flag_wait( "flag_topside_soldiers_defeated" );
    agent clearbtgoal( 0 );
    waitframe();
    agent function_fa32376aaa88a7a2( level.vol_finalpush_soldier_main.origin, 6000 );
    agent function_dd3b2de3b28ea995( 0, level.vol_finalpush_soldier_main );
    utility::flag_wait( "flag_prison_topside_completed" );
    agent thread gemini_util::ai_delete_when_out_of_sight( 768, 1536 );
}

// Namespace namespace_325e21231ce5a0e0
// Params 0, eflags: 0x4
// Checksum 0x1339abf5, Offset: 0x175e
// Size: 0x8c
function private function_eaf062a41330a592()
{
    level endon( #"game_ended", #"flag_topside_soldiers_defeated" );
    
    if ( utility::flag( "flag_topside_soldiers_defeated" ) )
    {
        return;
    }
    
    while ( isalive( self ) )
    {
        if ( level.players.size > 2 )
        {
            gemini_util::function_f53463c3213de6a1( "s_finalpush_breakable_barrier", "flag_prison_topside_completed", 20, 10 );
            wait randomfloatrange( 1, 9 );
            continue;
        }
        
        gemini_util::function_f53463c3213de6a1( "s_finalpush_breakable_barrier", "flag_prison_topside_completed", 25, 15 );
        wait randomfloatrange( 5, 15 );
    }
}

// Namespace namespace_325e21231ce5a0e0
// Params 1, eflags: 0x4
// Checksum 0x3767ac66, Offset: 0x17f2
// Size: 0x1ff
function private function_8ea5fa7096858b27( str_lane )
{
    self endon( #"death" );
    level.topside_enemy_soldiers gemini_util::ai_array_cleanup( "soldier" );
    var_3fd89bd4d3f2e0a4 = level.topside_enemy_soldiers.ai_array;
    
    switch ( str_lane )
    {
        case #"hash_c9b3133a17a3b2d0":
            level.var_e5810ebf65166f gemini_util::ai_array_cleanup( "soldier" );
            var_3fd89bd4d3f2e0a4 = level.var_e5810ebf65166f.ai_array;
            break;
        case #"hash_96815ce4f2a3dbc5":
            level.var_bb6a3e8c28c97160 gemini_util::ai_array_cleanup( "soldier" );
            var_3fd89bd4d3f2e0a4 = level.var_bb6a3e8c28c97160.ai_array;
            break;
        default:
            break;
    }
    
    attackable_soldier = undefined;
    
    if ( var_3fd89bd4d3f2e0a4.size > 0 )
    {
        closest_soldier = function_47c86977a18df38b( var_3fd89bd4d3f2e0a4, self.origin, 6400 );
        
        if ( isalive( closest_soldier ) && closest_soldier.basearchetype == "soldier" && !closest_soldier.b_unreachable )
        {
            attackable_soldier = closest_soldier;
        }
    }
    
    if ( isdefined( attackable_soldier ) )
    {
        self.var_18df753f0509540c = 0;
        self clearbtgoal( 0 );
        waitframe();
        self function_f2fdf8ef124744e8( 0, attackable_soldier );
        attackable_soldier utility::waittill_notify_or_timeout( "death", 10 );
        self clearbtgoal( 0 );
        return;
    }
    
    if ( !self.var_18df753f0509540c )
    {
        self clearbtgoal( 0 );
        waitframe();
        
        if ( utility::flag( "flag_topside_soldiers_reinforcements_spawned" ) )
        {
            self function_fa32376aaa88a7a2( level.vol_finalpush_soldier_main.origin, 6000 );
            self function_dd3b2de3b28ea995( 0, level.vol_finalpush_soldier_main );
        }
        else
        {
            self function_fa32376aaa88a7a2( level.vol_topside_soldier_fallback.origin, 6000 );
            self function_dd3b2de3b28ea995( 0, level.vol_topside_soldier_fallback );
        }
        
        self.var_18df753f0509540c = 1;
    }
}

// Namespace namespace_325e21231ce5a0e0
// Params 2, eflags: 0x4
// Checksum 0xb197b5d0, Offset: 0x19f9
// Size: 0x4d, Type: bool
function private function_f9638e72e954a215( requestid, userdata )
{
    count_all_ai = getaicount();
    
    if ( !utility::flag( "flag_trig_prison_topside_advance" ) )
    {
        if ( count_all_ai > 20 )
        {
            return false;
        }
    }
    else if ( count_all_ai > 25 )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_325e21231ce5a0e0
// Params 2, eflags: 0x4
// Checksum 0x3fffefe9, Offset: 0x1a4f
// Size: 0x27, Type: bool
function private function_cd1c30ee2467f095( requestid, userdata )
{
    if ( utility::flag( "flag_prison_topside_completed" ) )
    {
        return true;
    }
    
    return false;
}

/#

    // Namespace namespace_325e21231ce5a0e0
    // Params 0
    // Checksum 0x525d3444, Offset: 0x1a7f
    // Size: 0x5, Type: dev
    function function_75a45b38e9980e4c()
    {
        
    }

#/

// Namespace namespace_325e21231ce5a0e0
// Params 0
// Checksum 0x5570af1f, Offset: 0x1a8c
// Size: 0x11a
function function_b6045eb9534192d2()
{
    if ( !isdefined( level.topside_enemy_soldiers ) )
    {
        level.topside_enemy_soldiers = spawnstruct();
        
        if ( !isdefined( level.topside_enemy_soldiers.ai_array ) )
        {
            level.topside_enemy_soldiers.ai_array = [];
        }
    }
    
    if ( !isdefined( level.var_e5810ebf65166f ) )
    {
        level.var_e5810ebf65166f = spawnstruct();
        
        if ( !isdefined( level.var_e5810ebf65166f.ai_array ) )
        {
            level.var_e5810ebf65166f.ai_array = [];
        }
    }
    
    if ( !isdefined( level.var_bb6a3e8c28c97160 ) )
    {
        level.var_bb6a3e8c28c97160 = spawnstruct();
        
        if ( !isdefined( level.var_bb6a3e8c28c97160.ai_array ) )
        {
            level.var_bb6a3e8c28c97160.ai_array = [];
        }
    }
    
    if ( !isdefined( level.var_a089036921d6d51a ) )
    {
        level.var_a089036921d6d51a = spawnstruct();
        
        if ( !isdefined( level.var_a089036921d6d51a.ai_array ) )
        {
            level.var_a089036921d6d51a.ai_array = [];
        }
    }
}

// Namespace namespace_325e21231ce5a0e0
// Params 0
// Checksum 0x96dc23a2, Offset: 0x1bae
// Size: 0xbc
function function_f87366f66596a16a()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    function_b6045eb9534192d2();
    waitframe();
    activity_instance thread function_a997d4a88b73ae09();
    activity_instance gemini_util::function_51e3aaef58423855( "sat_sm04_gemini_ai_encounter_topside_soldiers_sniper", &function_44fd60df8323e320, undefined, "flag_prison_topside_completed", 2, 0, undefined, &function_6410262e160e569c );
    waitframe();
    activity_instance gemini_util::function_51e3aaef58423855( "sat_sm04_gemini_ai_encounter_topside_soldiers_right", &function_44fd60df8323e320, undefined, "flag_prison_topside_completed", 2, 0, &function_74b07db499b710d7, &function_6273915f31b6515 );
    waitframe();
    activity_instance gemini_util::function_51e3aaef58423855( "sat_sm04_gemini_ai_encounter_topside_soldiers_left", &function_44fd60df8323e320, undefined, "flag_prison_topside_completed", 2, 0, &function_74b07db499b710d7, &function_fb5c851b5eee604a );
    waitframe();
    activity_instance thread function_3e694b3d197fa30b();
}

// Namespace namespace_325e21231ce5a0e0
// Params 2, eflags: 0x4
// Checksum 0xeec6554e, Offset: 0x1c72
// Size: 0x21
function private function_6410262e160e569c( requestid, userdata )
{
    utility::flag_set( "flag_prison_topside_sniper_soldiers_spawned" );
}

// Namespace namespace_325e21231ce5a0e0
// Params 2, eflags: 0x4
// Checksum 0x73a3bcd5, Offset: 0x1c9b
// Size: 0x21
function private function_fb5c851b5eee604a( requestid, userdata )
{
    utility::flag_set( "flag_prison_topside_left_soldiers_spawned" );
}

// Namespace namespace_325e21231ce5a0e0
// Params 2, eflags: 0x4
// Checksum 0x20b9cf05, Offset: 0x1cc4
// Size: 0x21
function private function_6273915f31b6515( requestid, userdata )
{
    utility::flag_set( "flag_prison_topside_right_soldiers_spawned" );
}

// Namespace namespace_325e21231ce5a0e0
// Params 3, eflags: 0x4
// Checksum 0x6768b51e, Offset: 0x1ced
// Size: 0x60, Type: bool
function private function_74b07db499b710d7( requestid, userdata, wavenumber )
{
    if ( utility::flag( "flag_trig_prison_topside_assault" ) )
    {
        ai_spawn_director::cancel_spawn_request( requestid, 0 );
        return false;
    }
    
    data = function_9b649316adcccbaa( requestid );
    
    if ( data.ai.size <= 2 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_325e21231ce5a0e0
// Params 0, eflags: 0x4
// Checksum 0x86889bd8, Offset: 0x1d56
// Size: 0xe8
function private function_6a1f7d6d9bbb0a73()
{
    activity_instance = self;
    level endon( #"game_ended" );
    function_b6045eb9534192d2();
    waitframe();
    msg = utility::flag_wait_any_return( "flag_trig_prison_topside_convergence_left", "flag_trig_prison_topside_convergence_right", "flag_prison_topside_completed" );
    utility::flag_set( "flag_topside_soldiers_reinforcements" );
    
    if ( utility::flag( "flag_trig_prison_topside_convergence_left" ) )
    {
        function_415dce586b759c1b( "sat_sm04_gemini_ai_encounter_topside_soldiers_vehicleright" );
        wait 1.5;
        function_415dce586b759c1b( "sat_sm04_gemini_ai_encounter_topside_soldiers_vehicleleft" );
    }
    else
    {
        function_415dce586b759c1b( "sat_sm04_gemini_ai_encounter_topside_soldiers_vehicleleft_alt" );
        wait 1.5;
        
        if ( !utility::flag( "flag_prison_topside_completed" ) )
        {
            function_415dce586b759c1b( "sat_sm04_gemini_ai_encounter_topside_soldiers_vehicleright_alt" );
        }
    }
    
    utility::flag_set( "flag_topside_soldiers_reinforcements_spawned" );
    activity_instance thread function_7d63433fe9d05ee3();
    utility::flag_wait_any( "flag_topside_soldiers_defeated", "flag_prison_topside_completed" );
    
    if ( !utility::flag( "flag_prison_topside_completed" ) )
    {
        activity_instance thread function_f531838f1e93111f();
    }
}

// Namespace namespace_325e21231ce5a0e0
// Params 1, eflags: 0x4
// Checksum 0xed3c412a, Offset: 0x1e46
// Size: 0x5b
function private function_415dce586b759c1b( encounter_targetname )
{
    level endon( #"game_ended" );
    request_id = ai_spawn_director::lookup_spawn_request( encounter_targetname );
    ai_spawn_director::add_vehicle_spawned_callback( request_id, &topside_on_vehicle_spawned );
    ai_spawn_director::add_spawned_callback( request_id, &function_44fd60df8323e320 );
    function_ef57f478f96b050c( request_id, 1 );
    level thread function_f63705e0e58b0c8( request_id );
}

// Namespace namespace_325e21231ce5a0e0
// Params 1, eflags: 0x4
// Checksum 0x45498583, Offset: 0x1ea9
// Size: 0x2f
function private function_f63705e0e58b0c8( request_id )
{
    level endon( #"game_ended" );
    utility::flag_wait( "flag_gemini_exfil_igc_begin" );
    ai_spawn_director::cancel_spawn_request( request_id, 0, 0 );
}

// Namespace namespace_325e21231ce5a0e0
// Params 4, eflags: 0x4
// Checksum 0xdaef0fba, Offset: 0x1ee0
// Size: 0x38
function private topside_on_vehicle_spawned( requestid, userdata, vehicle, data )
{
    vehicle_interact::allow_use( vehicle, 0 );
    vehicle vehicle_turnengineon();
}

// Namespace namespace_325e21231ce5a0e0
// Params 4, eflags: 0x4
// Checksum 0xd19f4314, Offset: 0x1f20
// Size: 0x2ed
function private function_44fd60df8323e320( requestid, instance, agent, userdata )
{
    level endon( #"game_ended" );
    agent endon( #"death" );
    
    if ( agent.basearchetype == "zombie_base" )
    {
        /#
            iprintlnbold( "<dev string:x24>" );
        #/
    }
    
    agent agent_utils::function_1874e18b42e6d814( &gemini_util::function_cb3d5af3567a0360 );
    agent.binvehicle = 0;
    
    if ( isdefined( agent.directorspawndata.script_noteworthy ) )
    {
        switch ( agent.directorspawndata.script_noteworthy )
        {
            case #"hash_abcf18db72a33953":
                agent.binvehicle = 1;
            case #"hash_5798a4eae2f06f4e":
                agent thread gemini_util::function_7653e4bbe774fb50( level.topside_enemy_soldiers );
                agent thread gemini_util::function_7653e4bbe774fb50( level.var_e5810ebf65166f );
                break;
            case #"hash_d5c1a11c7c62bdc":
                agent.binvehicle = 1;
            case #"hash_7c58ac3b1c5ca9a3":
                agent thread gemini_util::function_7653e4bbe774fb50( level.topside_enemy_soldiers );
                agent thread gemini_util::function_7653e4bbe774fb50( level.var_bb6a3e8c28c97160 );
                break;
            case #"hash_953decc7f31226d1":
                agent.b_unreachable = 1;
                agent ai::set_ignoreme( 1 );
            default:
                agent thread gemini_util::function_7653e4bbe774fb50( level.topside_enemy_soldiers );
                break;
        }
    }
    
    if ( agent.classname == "actor_sat_ob_enemy_specialist_sniper" )
    {
        agent thread function_735283302c4b438e();
    }
    
    utility::flag_wait( "flag_topside_soldiers_reinforcements_spawned" );
    
    if ( !isdefined( level.vol_topside_soldier_fallback ) )
    {
        level.vol_topside_soldier_fallback = getent( "vol_topside_soldier_fallback", #targetname );
    }
    
    if ( !agent.binvehicle )
    {
        pos = agent getclosestreachablepointonnavmesh( level.vol_topside_soldier_fallback.origin, 0 );
        
        if ( isdefined( pos ) )
        {
            agent setgoalvolumeauto( level.vol_topside_soldier_fallback );
        }
        else
        {
            agent gemini_util::ai_nerf();
        }
    }
    else
    {
        agent.bisincombat = 1;
        agent.vehiclerunexit = 1;
    }
    
    level utility::flag_wait_any( "flag_prison_topside_completed", "flag_topside_soldiers_almost_defeated" );
    agent gemini_util::ai_nerf();
    waitframe();
    
    if ( !isdefined( level.vol_finalpush_soldier_main ) )
    {
        level.vol_finalpush_soldier_main = getent( "vol_finalpush_soldier_main", #targetname );
    }
    
    pos = agent getclosestreachablepointonnavmesh( level.vol_finalpush_soldier_main.origin, 0 );
    
    if ( isdefined( pos ) )
    {
        agent setgoalvolumeauto( level.vol_finalpush_soldier_main );
    }
    
    level utility::flag_wait( "flag_prison_topside_completed" );
    agent thread gemini_util::ai_delete_when_out_of_sight( 768, 1536 );
}

// Namespace namespace_325e21231ce5a0e0
// Params 0, eflags: 0x4
// Checksum 0x6ea8f154, Offset: 0x2215
// Size: 0xa6
function private function_735283302c4b438e()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.var_5af6c7d6e3c9b5aa = 128;
    self.var_63f1ffef1eafa4e4 = 1;
    self function_2ef9eb3349906d00( 6400 );
    self.maxsightdistsqrd = 64000000;
    self.maxvisibledist = 8192;
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker );
        
        if ( isplayer( attacker ) || isplayer( attacker.owner ) )
        {
            self.favoriteenemy = attacker;
        }
        
        waitframe();
    }
}

// Namespace namespace_325e21231ce5a0e0
// Params 0, eflags: 0x4
// Checksum 0xaffe8283, Offset: 0x22c3
// Size: 0x99
function private function_3e694b3d197fa30b()
{
    level endon( #"game_ended", #"flag_topside_soldiers_reinforcements" );
    activity_instance = self;
    assert( isdefined( level.topside_enemy_soldiers ), "<dev string:x3f>" );
    utility::flag_wait_all( "flag_prison_topside_sniper_soldiers_spawned", "flag_prison_topside_left_soldiers_spawned", "flag_prison_topside_right_soldiers_spawned" );
    
    while ( level.topside_enemy_soldiers.ai_array.size > 0 )
    {
        waitframe();
        level.topside_enemy_soldiers gemini_util::ai_array_cleanup( "soldier" );
    }
    
    activity_instance thread gemini_util::function_b8a6e5d594fbfcc3( "s_prison_topside_blockade_zombie_attractor", undefined, "flag_topside_soldiers_reinforcements_spawned", 1 );
}

// Namespace namespace_325e21231ce5a0e0
// Params 0, eflags: 0x4
// Checksum 0x8ceb58b6, Offset: 0x2364
// Size: 0xc9
function private function_7d63433fe9d05ee3()
{
    level endon( #"game_ended" );
    activity_instance = self;
    assert( isdefined( level.topside_enemy_soldiers ), "<dev string:x3f>" );
    
    while ( level.topside_enemy_soldiers.ai_array.size > 0 )
    {
        waitframe();
        level.topside_enemy_soldiers gemini_util::ai_array_cleanup( "soldier" );
        
        if ( !utility::flag( "flag_topside_soldiers_almost_defeated" ) && level.topside_enemy_soldiers.ai_array.size <= 2 )
        {
            utility::flag_set( "flag_topside_soldiers_almost_defeated" );
        }
    }
    
    utility::flag_set( "flag_topside_soldiers_defeated" );
    
    /#
        iprintlnbold( "<dev string:x70>" );
    #/
    
    activity_instance thread gemini_util::function_b8a6e5d594fbfcc3( "s_prison_topside_end_zombie_attractor", undefined, "flag_prison_topside_completed", 1 );
}

// Namespace namespace_325e21231ce5a0e0
// Params 0, eflags: 0x4
// Checksum 0x97e51732, Offset: 0x2435
// Size: 0x98
function private function_721c48645685c147()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"game_ended" );
    function_b6045eb9534192d2();
    waitframe();
    utility::flag_wait( "flag_topside_soldiers_defeated" );
    request_id = activity_instance activity_ai_encounters::function_92b671064b0b1ce2( "sat_sm04_gemini_ai_encounter_topside_soldiers_exit", 0, 1, 1, 2 );
    activity_ai_encounters::function_52d1342183200a8f( request_id, &function_212d94ce01513065 );
    activity_ai_encounters::function_dcf6bdb6ee9d1ca0( request_id, &function_d9ea29e3f40f9996 );
    activity_ai_encounters::function_d33de057e760c97b( request_id, &function_6a75f91884a764a4 );
    activity_ai_encounters::function_48582991402cac50( request_id, 1 );
}

// Namespace namespace_325e21231ce5a0e0
// Params 2, eflags: 0x4
// Checksum 0xfe188633, Offset: 0x24d5
// Size: 0x27, Type: bool
function private function_d9ea29e3f40f9996( requestid, userdata )
{
    if ( utility::flag( "flag_prison_topside_completed" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_325e21231ce5a0e0
// Params 2, eflags: 0x4
// Checksum 0xe29cb7d3, Offset: 0x2505
// Size: 0x31, Type: bool
function private function_6a75f91884a764a4( requestid, userdata )
{
    if ( utility::flag( "flag_prison_topside_completed" ) )
    {
        ai_spawn_director::cancel_spawn_request( requestid, 0 );
        return true;
    }
    
    return false;
}

// Namespace namespace_325e21231ce5a0e0
// Params 4, eflags: 0x4
// Checksum 0xeb9aeccf, Offset: 0x253f
// Size: 0xb7
function private function_212d94ce01513065( requestid, instance, agent, userdata )
{
    level endon( #"game_ended" );
    agent endon( #"death" );
    
    if ( agent.basearchetype == "zombie_base" )
    {
        /#
            iprintlnbold( "<dev string:x24>" );
        #/
    }
    
    agent agent_utils::function_1874e18b42e6d814( &gemini_util::function_cb3d5af3567a0360 );
    agent thread gemini_util::function_7653e4bbe774fb50( level.var_a089036921d6d51a );
    level utility::flag_wait( "flag_prison_topside_completed" );
    agent gemini_util::ai_nerf();
    level utility::flag_wait( "flag_prison_finalpush_completed" );
    agent thread gemini_util::ai_delete_when_out_of_sight( 768, 1536 );
}

/#

    // Namespace namespace_325e21231ce5a0e0
    // Params 0
    // Checksum 0xdaf4e234, Offset: 0x25fe
    // Size: 0x5, Type: dev
    function function_6b9fa3bffcbaa353()
    {
        
    }

#/

// Namespace namespace_325e21231ce5a0e0
// Params 0
// Checksum 0xb36d67ff, Offset: 0x260b
// Size: 0x1c6
function function_eea391bcf10c81d4()
{
    activity_instance = self;
    ob_activity_heli_takedown::function_fb53b392296c145c();
    ob_story_mission_utils::set_vtol_speed( 75, 75, 12, 20 );
    activity_instance.heli_path_start = utility::getstruct( "prison_topside_vtol", "targetname" );
    
    if ( isdefined( activity_instance.heli_path_start ) )
    {
        activity_instance.var_2a47db6ce749f4a9 = activity_instance mp_sat_ob_gemini_vtol::spawn_vtol( activity_instance.heli_path_start.origin, activity_instance.heli_path_start.angles, &prison_topside_vtol_turret_think );
        
        /#
            iprintlnbold( "<dev string:x96>" );
        #/
        
        activity_instance.var_2a47db6ce749f4a9 setmaxpitchroll( 15, 15 );
        activity_instance.var_2a47db6ce749f4a9 setneargoalnotifydist( 128 );
        activity_instance.var_2a47db6ce749f4a9 setturningability( 0.02 );
        activity_instance.var_2a47db6ce749f4a9.b_escaping = 0;
        activity_instance.var_2a47db6ce749f4a9.hover_min_height = 0;
        activity_instance.var_2a47db6ce749f4a9.heightoffset = ( 0, 0, 0 );
        activity_instance.var_2a47db6ce749f4a9.damagestate = 0;
        activity_instance.var_2a47db6ce749f4a9.var_24954f14e27b448d = 0;
        activity_instance.var_2a47db6ce749f4a9.var_25ced6dafb5b15f0 = 1.5;
        activity_instance.var_2a47db6ce749f4a9.pathgoaldistance = 128;
        level utility::flag_wait( "flag_trig_prison_topside_spawn_zombies" );
        activity_instance.var_2a47db6ce749f4a9 thread function_c0518952ddceeb6b();
        activity_instance prison_topside_vtol_flyby( activity_instance.heli_path_start, 80, 20, 20 );
    }
}

// Namespace namespace_325e21231ce5a0e0
// Params 4
// Checksum 0xd9c6c820, Offset: 0x27d9
// Size: 0x1de
function prison_topside_vtol_flyby( path_start, var_305eb0d761a45d91, path_accel, path_decel )
{
    self endon( #"activity_ended" );
    self.var_2a47db6ce749f4a9 endon( #"death" );
    var_2356daabba8966ee = utility::getstruct( path_start.target, "targetname" );
    
    if ( isdefined( var_2356daabba8966ee ) )
    {
        /#
            iprintlnbold( "<dev string:xa4>" );
        #/
        
        self.var_2a47db6ce749f4a9 notify( #"takeoff" );
        self.var_2a47db6ce749f4a9 setyawspeed( var_305eb0d761a45d91, path_accel, path_decel, 0.1 );
        self.var_2a47db6ce749f4a9.var_66985f8f48b0cef7 = 0;
        self.var_2a47db6ce749f4a9 namespace_28acf6540b1bc740::function_7fb408948b1225e0( var_2356daabba8966ee, 0, undefined, 1, self.var_2a47db6ce749f4a9.angles[ 1 ], 0, var_305eb0d761a45d91, path_accel );
        self.var_2a47db6ce749f4a9 setscriptablepartstate( "engine", "on_all", 0 );
        self.var_2a47db6ce749f4a9 setscriptablepartstate( "thrusters", "horizontal", 0 );
        self.var_2a47db6ce749f4a9.speed = var_305eb0d761a45d91;
        self.var_2a47db6ce749f4a9 vehicle_setspeed( var_305eb0d761a45d91, path_accel, path_decel );
        self.var_2a47db6ce749f4a9 thread namespace_28acf6540b1bc740::action_follow_path( var_2356daabba8966ee, undefined, var_305eb0d761a45d91 );
        self.var_2a47db6ce749f4a9 utility::waittill_any( "leaving", "follow_path_complete" );
        self.var_2a47db6ce749f4a9 setscriptablepartstate( "engine", "booster", 0 );
        self.var_2a47db6ce749f4a9 thread vehicle::godon();
    }
    
    waitframe();
    self notify( #"heli_escaped" );
    self.var_2a47db6ce749f4a9.b_escaping = 1;
    self.var_2a47db6ce749f4a9 ob_activity_heli_takedown::function_ec2bfddde8f4bf8d();
    
    /#
        iprintlnbold( "<dev string:xb1>" );
    #/
}

// Namespace namespace_325e21231ce5a0e0
// Params 0
// Checksum 0x67e37661, Offset: 0x29bf
// Size: 0x21d
function prison_topside_vtol_turret_think()
{
    self endon( #"death", #"flyaway", #"crashing" );
    self notify( #"hash_a35e08874766d610" );
    self endon( #"hash_a35e08874766d610" );
    
    if ( !isdefined( range ) )
    {
        range = 5000;
    }
    
    if ( !isdefined( firetime ) )
    {
        firetime = 5;
    }
    
    if ( !isdefined( spread ) )
    {
        spread = 1;
    }
    
    s_target_start = utility::getstruct( "prison_topside_vtol_target", "targetname" );
    
    if ( !isdefined( s_target_start ) )
    {
        return;
    }
    
    s_target_end = utility::getstruct( s_target_start.target, "targetname" );
    self.var_a648afea39238b85 = utility::spawn_script_origin( s_target_start.origin );
    self.var_a648afea39238b85.health = 9999;
    self.var_a648afea39238b85 makeentitysentient( "team_hundred_ninety" );
    self.var_a648afea39238b85.ignoreme = 1;
    self setturrettargetent( self.var_a648afea39238b85, ( 0, 0, 0 ) );
    self setturrettargetvec( self.var_a648afea39238b85.origin );
    self setturretscriptcontrolled( 1, 0 );
    self setturretaispread( spread );
    level utility::flag_wait( "flag_trig_prison_topside_spawn_zombies" );
    wait firetime * 0.2;
    
    while ( true )
    {
        if ( mp_sat_ob_gemini_vtol::is_within_target_range( self.var_a648afea39238b85.origin, range ) && mp_sat_ob_gemini_vtol::function_43ac45f2bf4fe748( self.var_a648afea39238b85.origin ) )
        {
            /#
                iprintlnbold( "<dev string:xbf>" );
            #/
            
            self.var_a648afea39238b85 moveto( s_target_end.origin, firetime, 1, 1 );
            childthread function_20077065d855ade( self.var_a648afea39238b85, firetime * 0.15 );
            mp_sat_ob_gemini_vtol::function_12afeddc73d1dda4( self.var_a648afea39238b85, firetime );
            break;
        }
        
        waitframe();
    }
    
    wait 1;
    self.var_a648afea39238b85 delete();
}

// Namespace namespace_325e21231ce5a0e0
// Params 2
// Checksum 0xdd9b1c8f, Offset: 0x2be4
// Size: 0x62
function function_20077065d855ade( var_a648afea39238b85, delay )
{
    self endon( #"death" );
    wait delay;
    
    while ( isdefined( var_a648afea39238b85 ) )
    {
        if ( mp_sat_ob_gemini_vtol::function_ae5efa8add232784( var_a648afea39238b85.origin, 0.6 ) )
        {
            /#
                iprintlnbold( "<dev string:xd1>" );
            #/
            
            mp_sat_ob_gemini_vtol::shoot_missiles( var_a648afea39238b85, 2 );
            break;
        }
        
        waitframe();
    }
}

// Namespace namespace_325e21231ce5a0e0
// Params 0, eflags: 0x4
// Checksum 0xfc7b29d6, Offset: 0x2c4e
// Size: 0x21d
function private function_c0518952ddceeb6b()
{
    self endon( #"death", #"heli_escaped" );
    level.var_122bf6634835c678 = 0;
    vtol_maxhealth = self.health;
    
    if ( !isdefined( var_17b2d57cb7e0e4ba ) )
    {
        var_17b2d57cb7e0e4ba = 0;
    }
    
    while ( true )
    {
        self waittill( #"damage", amount, var_de4e7421cbff35f7, var_de4e7421cbff35f7, var_de4e7421cbff35f7, var_de4e7421cbff35f7, var_de4e7421cbff35f7, var_de4e7421cbff35f7, var_de4e7421cbff35f7, var_de4e7421cbff35f7, objweapon );
        
        if ( isdefined( objweapon ) )
        {
            if ( isdefined( objweapon.classname ) )
            {
                switch ( objweapon.classname )
                {
                    case #"hash_8cdaf2e4ecfe5b51":
                    case #"hash_fa18d2f6bd57925a":
                        var_17b2d57cb7e0e4ba = 10;
                        break;
                    case #"hash_900cb96c552c5e8e":
                    case #"hash_fa50b9f6bd82f79d":
                        var_17b2d57cb7e0e4ba = 8;
                        break;
                    case #"hash_690c0d6a821b42e":
                        var_17b2d57cb7e0e4ba = 6;
                        break;
                    case #"hash_fa24dff6bd60a12d":
                        var_17b2d57cb7e0e4ba = 16;
                        break;
                    case #"hash_f4b0076c03d93738":
                    case #"hash_fa0ed9f6bd4f4e9a":
                        var_17b2d57cb7e0e4ba = 12;
                        break;
                    case #"hash_e224d0b635d0dadd":
                        var_17b2d57cb7e0e4ba = 120;
                        break;
                    case #"hash_6191aaef9f922f96":
                        var_17b2d57cb7e0e4ba = 70;
                        break;
                    case #"hash_719417cb1de832b6":
                        var_17b2d57cb7e0e4ba = 6;
                        break;
                    case #"hash_61e969dacaaf9881":
                    case #"hash_ba39cac9c099d4f1":
                    case #"hash_fa27bdf6bd62aa3e":
                        var_17b2d57cb7e0e4ba = 500;
                        break;
                    default:
                        /#
                            iprintln( "<dev string:xe9>" + objweapon.classname + "<dev string:xff>" );
                        #/
                        
                        var_17b2d57cb7e0e4ba = 10;
                        break;
                }
            }
            else
            {
                /#
                    iprintlnbold( "<dev string:x108>" + objweapon + "<dev string:x115>" );
                #/
                
                var_17b2d57cb7e0e4ba = 200;
            }
        }
        
        level.var_122bf6634835c678 += var_17b2d57cb7e0e4ba;
        
        /#
            iprintlnbold( "<dev string:x120>" + level.var_122bf6634835c678 );
        #/
        
        self.health = vtol_maxhealth;
    }
}

/#

    // Namespace namespace_325e21231ce5a0e0
    // Params 0
    // Checksum 0xed8b4b9e, Offset: 0x2e73
    // Size: 0x5, Type: dev
    function function_3600fd1b7721698e()
    {
        
    }

#/

// Namespace namespace_325e21231ce5a0e0
// Params 0, eflags: 0x4
// Checksum 0xa2616ad5, Offset: 0x2e80
// Size: 0x22
function private function_3c6ef4db7eb04ab7()
{
    ob_story_mission_utils::objective_text_show( "OB_GEMINI_PRISON_TOPSIDE" );
    level utility::flag_wait( "flag_prison_topside_completed" );
    ob_story_mission_utils::objective_text_clear();
}

// Namespace namespace_325e21231ce5a0e0
// Params 0, eflags: 0x4
// Checksum 0xbcc4a3ff, Offset: 0x2eaa
// Size: 0xdd
function private function_9c5924de5ad05bf()
{
    activity_instance = self;
    
    if ( !activity_instance.additionalspawndata.is_startpoint_start )
    {
        waypoint_objective_handler::waypoint_objective_handler_cancel( "s_obj_prison_armory_exit" );
    }
    
    var_f5594f9951890a3d = utility::getstruct( "s_obj_topside_gate_tower", "targetname" );
    
    foreach ( player in level.players )
    {
        activity_instance thread gemini_util::function_8ff6409d7606f259( player, var_f5594f9951890a3d.origin, undefined, undefined, level, "flag_prison_topside_completed", undefined, 3000 );
    }
}

