// script_31ecd16917c98923  (hash_31ecd16917c98923.gscc) (size: 26763 Bytes / 0x688b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe06dd23d (3765293629)
// size ...... 26763 (0x688b)
// includes .. 22  (offset: 0x601b)
// strings ... 115 (offset: 0x60cb)
// dev strs .. 0   (offset: 0x688b)
// exports ... 52  (offset: 0x429f)
// cseg ...... 0xb7b + 0x3724 (0x429f)
// imports ... 164 (offset: 0x4abf)
// animtree1 . 0   (offset: 0x688b)
// animtree2 . 0   (offset: 0x688b)
#using script_34b50456e3922412;
#using script_636bd827a012af12;
#using script_66878054d141dbc0;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\aitypes\shared\zombie\zombie_emergence_spawning;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\chyron;
#using scripts\common\hud_util;
#using scripts\common\scene;
#using scripts\common\snd\snd;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_activity_tunnels_elevator;
#using scripts\mp\maps\mp_sat_ob_gemini\mp_sat_ob_gemini_util;
#using scripts\mp\mp_agent;
#using scripts\mp\ob\systems\ob_item_select;

#namespace namespace_f6592ea7cc080fa2;

/#

    // Namespace namespace_f6592ea7cc080fa2
    // Params 0
    // Checksum 0x83100fc, Offset: 0xb99
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_f6592ea7cc080fa2
// Params 0, eflags: 0x5
// Checksum 0x5a1aba, Offset: 0xba6
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_d65c6f5a18adf969", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_f6592ea7cc080fa2
// Params 0, eflags: 0x4
// Checksum 0xdb6517ee, Offset: 0xbcf
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_GEMINI_NM_1";
    activity_common::registeractivitytype( "OB_GEMINI_NM_1", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_NM_1", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_NM_1", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_GEMINI_NM_1", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_GEMINI_NM_1" );
}

// Namespace namespace_f6592ea7cc080fa2
// Params 0
// Checksum 0xf9143c12, Offset: 0xc46
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance nightmare_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_f6592ea7cc080fa2
// Params 0
// Checksum 0x8b5f4427, Offset: 0xcab
// Size: 0x5f
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    level.request_ids = [];
    
    if ( !ob::nightmare() )
    {
        activity_instance waittill( #"hash_1e9bc5e84aa89155" );
    }
    
    activity_instance thread nightmare_main();
}

// Namespace namespace_f6592ea7cc080fa2
// Params 0
// Checksum 0x95069b03, Offset: 0xd12
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_f6592ea7cc080fa2
// Params 1
// Checksum 0xd9556b75, Offset: 0xd36
// Size: 0x9f
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    
    foreach ( player in player_list )
    {
        activity_instance thread player_setup( player );
    }
}

/#

    // Namespace namespace_f6592ea7cc080fa2
    // Params 0
    // Checksum 0x4f8ba4ec, Offset: 0xddd
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_f6592ea7cc080fa2
// Params 1
// Checksum 0xef6d665b, Offset: 0xdea
// Size: 0x30
function player_setup( player )
{
    if ( isdefined( level.amalgam_boss ) )
    {
        player thread ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_nm_amalgam", level.amalgam_boss );
    }
}

// Namespace namespace_f6592ea7cc080fa2
// Params 0
// Checksum 0x79413103, Offset: 0xe22
// Size: 0x2
function nightmare_start()
{
    
}

// Namespace namespace_f6592ea7cc080fa2
// Params 0
// Checksum 0x578db74e, Offset: 0xe2c
// Size: 0x3ff
function nightmare_main()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    chyron::function_d41002779543c80e( undefined, 0.01, 0.01 );
    level.var_bd2748e149a8024b = self;
    level.nm_activity_instance = self;
    level.nm_activity_name = "OB_GEMINI_NM_1";
    thread turn_off_scriptables();
    
    if ( isdefined( level.stealth.threatsightwidget ) )
    {
        level.stealth.threatsightwidget = undefined;
    }
    
    thread ob_nm_mode::watch_solo_player();
    level.tunnels_elevator = namespace_51f35399a137ca44::elevator_moving_init( "e_tunnels_elevator_moving", "flag_delete_elevator" );
    level.tunnels_elevator thread namespace_51f35399a137ca44::function_319a23379572a316( "enter", 1 );
    level.tunnels_elevator thread namespace_51f35399a137ca44::function_319a23379572a316( "exit", 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "struct_nm_medkit_prison", "flag_nm_prison_complete", 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "struct_nm_medkit_cafe", "flag_nm_prison_complete", 1 );
    level._effect[ "enemy_vfx" ] = loadfxasset( "vfx_sat_wc_ai_cradle_spawn_burst_med_01" );
    level._effect[ "wall_vfx" ] = loadfxasset( "vfx_sat_levels_mp_odysseus_cradle_base_lrg" );
    level._effect[ "glass_vfx" ] = loadfxasset( "vfx_sat_coop_shattered_shield" );
    level._effect[ "glass2_vfx" ] = loadfxasset( "vfx_sat_core_strk_warmachine_grenade_explosion_glass" );
    level._effect[ "orange_flare" ] = loadfxasset( "vfx_sat_levels_mp_sat_avalon_smoke_flare_orange" );
    level thread ob_story_mission_utils::function_e6799e9a19df2365( "nm_wave_1_crate", %"itemspawnlist:ob_sat_items_lethals", 2 );
    thread function_d283aee3d1244e6c( "tunnels_mine_barrier" );
    struct = utility::getstruct( "struct_gemini_nm_prison", "targetname" );
    ob_item_select::function_95f9ecc2af4693f6( struct.origin, "super_shadow_break", "super_bubble_shield", #"default" );
    level thread function_d8a7357af78c2aca( "sat_spawner_zombie_vermin_ob", "cage_ai_struct_1", undefined, 1, "leg_1_done", 1 );
    walls = getentarray( "nm_maze_blockers", "targetname" );
    
    foreach ( item in walls )
    {
        if ( isdefined( item ) )
        {
            item movez( 320, 0.1 );
        }
    }
    
    ob_nm_mode::function_1f2648b3b22d9816( undefined, "nm_overlord_glich_start" );
    var_12dad7deb9f58051 = gemini_util::security_gate_init( "e_tunnels_mine_gate_03" );
    var_12dad7deb9f58051 gemini_util::security_gate_open();
    function_924fae677005ef6c();
    thread function_4f5f61acea9b03b9();
    smoke_players();
    function_4d307d6678b3ec6d();
    level notify( #"hash_88a5c9221727633d" );
    thread function_7c0ef25d97874c9f();
    function_a25acb62ddab20e2( "nm_minion_zombie", 1 );
    level utility::flag_wait( "amalgam_spawned" );
    function_2aedd95d3c7720a4( "struct_gemini_nm_prison_boss", "sat_spawner_zombie_ghoul_ob_nm", "encounter_gemini_nm_prison_boss", %"hash_21b2af1c009d4221" );
    function_a25acb62ddab20e2( "nm_minion_zombie", 0 );
    level.var_754190cf3f5b958a = 0;
    ob_nm_mode::nightmare_teleport( "OB_GEMINI_NM_2" );
    level thread ob_nm_mode::function_5dd43e7cb0682d57( "struct_gemini_nm_prison_boss", "OB_GEMINI_NM_2" );
    nm_cafeteria_blockers = getentarray( "nm_cafeteria_blockers", "targetname" );
    
    foreach ( blocker in nm_cafeteria_blockers )
    {
        if ( isdefined( blocker ) )
        {
            blocker delete();
        }
    }
    
    level utility::flag_set( "flag_nm_prison_complete" );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_f6592ea7cc080fa2
// Params 0
// Checksum 0xedf18515, Offset: 0x1233
// Size: 0x2e1
function turn_off_scriptables()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "scriptables_ready" );
    scriptable_a = getentitylessscriptablearray( "e_tunnels_mine_gate_03_interact_a", "targetname" );
    scriptable_b = getentitylessscriptablearray( "e_tunnels_mine_gate_03_interact_b", "targetname" );
    scriptable_c = getentitylessscriptablearray( "e_tunnels_prison_cellblock_armory_gate_interact", "targetname" );
    shower_valve_interact = gemini_util::get_scriptable( "tunnels_prison_shower_valve_cellblock" );
    var_227b6976122d0b6f = gemini_util::get_scriptable_array( "security_door_cellblock_trans_02" );
    b_special_doors = gemini_util::get_scriptable_array( "security_door_stairwell_office" );
    
    foreach ( item in scriptable_a )
    {
        item utility::function_7c10ea82c1e305b8( "base", "console_waiting" );
    }
    
    foreach ( item in scriptable_b )
    {
        item utility::function_7c10ea82c1e305b8( "base", "console_waiting" );
    }
    
    foreach ( item in scriptable_c )
    {
        item utility::function_7c10ea82c1e305b8( "base", "console_waiting" );
    }
    
    foreach ( item in var_227b6976122d0b6f )
    {
        item scriptabledoorfreeze();
    }
    
    foreach ( item in b_special_doors )
    {
        item scriptabledoorfreeze();
    }
    
    shower_valve_interact utility::function_7c10ea82c1e305b8( "base", "off" );
}

// Namespace namespace_f6592ea7cc080fa2
// Params 0
// Checksum 0x13160fff, Offset: 0x151c
// Size: 0x226
function function_7c0ef25d97874c9f()
{
    rafter_structs = utility::getstructarray( "cradle_rafter_structs", "targetname" );
    
    foreach ( struct in rafter_structs )
    {
        struct.tag = utility::function_1808878d1c511ce8( struct.origin, struct.angles );
        playfxontag( level._effect[ "wall_vfx" ], struct.tag, "tag_origin" );
    }
    
    nm_cafe_flare = utility::getstructarray( "nm_cafe_flare", "targetname" );
    
    foreach ( flare in nm_cafe_flare )
    {
        flare thread function_cb195eb8993c7ecc();
    }
    
    level.var_754190cf3f5b958a = 1;
    thread function_1b120d0c25894104();
    level utility::flag_wait( "nightmare_encouter_done" );
    level.var_754190cf3f5b958a = 0;
    
    foreach ( struct in rafter_structs )
    {
        if ( isdefined( struct.tag ) )
        {
            stopfxontag( level._effect[ "wall_vfx" ], struct.tag, "tag_origin" );
            struct.tag delete();
        }
    }
}

// Namespace namespace_f6592ea7cc080fa2
// Params 0
// Checksum 0xa0e7a546, Offset: 0x174a
// Size: 0xf4
function function_1b120d0c25894104()
{
    level endon( #"game_ended" );
    
    while ( level.var_754190cf3f5b958a )
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) || !isdefined( player.origin ) )
            {
                continue;
            }
            
            if ( player.origin[ 2 ] > -53.5 )
            {
                player dodamage( 5, player.origin, player );
                level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "light", 0.5, undefined, player, undefined, undefined, 1 );
            }
        }
        
        wait 0.5;
    }
}

// Namespace namespace_f6592ea7cc080fa2
// Params 0
// Checksum 0x37eb1d4e, Offset: 0x1846
// Size: 0x41a
function function_2c1954c60686e93()
{
    level utility::flag_set( "flag_killcount_event" );
    var_4c55f873ab6bb314 = [];
    
    switch ( level.players.size )
    {
        case 1:
            level.minion_kill_obj = 1;
            struct_gemini_nm_prison_ghoul_01 = utility::getstruct( "struct_gemini_nm_prison_ghoul_01", "script_noteworthy" );
            var_4c55f873ab6bb314[ 0 ] = struct_gemini_nm_prison_ghoul_01;
            scaler = 1;
            break;
        case 2:
            level.minion_kill_obj = 1;
            struct_gemini_nm_prison_ghoul_01 = utility::getstruct( "struct_gemini_nm_prison_ghoul_01", "script_noteworthy" );
            var_5da787af4417c8d2 = spawnstruct();
            var_5da787af4417c8d2.origin = ( 9914, 6208, -911 );
            var_4c55f873ab6bb314[ 0 ] = struct_gemini_nm_prison_ghoul_01;
            scaler = 1.5;
            break;
        case 3:
            level.minion_kill_obj = 1;
            struct_gemini_nm_prison_ghoul_01 = utility::getstruct( "struct_gemini_nm_prison_ghoul_01", "script_noteworthy" );
            var_5da787af4417c8d2 = spawnstruct();
            var_5da787af4417c8d2.origin = ( 9914, 6208, -911 );
            var_5da788af4417cb05 = spawnstruct();
            var_5da788af4417cb05.origin = ( 8876, 6204, -1120 );
            var_4c55f873ab6bb314[ 0 ] = struct_gemini_nm_prison_ghoul_01;
            scaler = 1.8;
            break;
        case 4:
            level.minion_kill_obj = 1;
            struct_gemini_nm_prison_ghoul_01 = utility::getstruct( "struct_gemini_nm_prison_ghoul_01", "script_noteworthy" );
            var_5da787af4417c8d2 = spawnstruct();
            var_5da787af4417c8d2.origin = ( 9914, 6208, -911 );
            var_5da788af4417cb05 = spawnstruct();
            var_5da788af4417cb05.origin = ( 8876, 6204, -1120 );
            var_5da781af4417bba0 = spawnstruct();
            var_5da781af4417bba0.origin = ( 9160, 5886, -992 );
            var_4c55f873ab6bb314[ 0 ] = struct_gemini_nm_prison_ghoul_01;
            scaler = 2.5;
            break;
        default:
            level.minion_kill_obj = 1;
            struct_gemini_nm_prison_ghoul_01 = utility::getstruct( "struct_gemini_nm_prison_ghoul_01", "script_noteworthy" );
            var_4c55f873ab6bb314[ 0 ] = struct_gemini_nm_prison_ghoul_01;
            break;
    }
    
    level.minions_killed = 0;
    wait 1.5;
    thread handle_glass_break();
    ob_nm_mode::nightmare_splash( "nm_wave_threat_start" );
    
    foreach ( s_ghoul_spawn in var_4c55f873ab6bb314 )
    {
        spawn_pos = getclosestpointonnavmesh( s_ghoul_spawn.origin );
        
        if ( !isdefined( s_ghoul_spawn.angles ) )
        {
            s_ghoul_spawn.angles = ( 0, 0, 0 );
        }
        
        playfx( level._effect[ "enemy_vfx" ], spawn_pos + ( 0, 0, 32 ) );
        ai_ghoul_spawn = mp_agent::spawnnewagentaitype( "sat_spawner_zombie_ghoul_ob_nm", spawn_pos, s_ghoul_spawn.angles, "team_two_hundred" );
        ai_ghoul_spawn thread ob_nm_mode::individual_vanish( "nm_cafe_interact_ghouls_done" );
        ai_ghoul_spawn thread set_doppleghast_health( scaler );
    }
    
    if ( level.minion_kill_obj > 100 )
    {
        level.nm_activity_instance ob_story_mission_utils::function_315d79883d962ba7( 0, 100 );
    }
    else
    {
        level.nm_activity_instance ob_story_mission_utils::function_315d79883d962ba7( 0, level.minion_kill_obj );
    }
    
    while ( level.minions_killed < level.minion_kill_obj )
    {
        waitframe();
    }
    
    level notify( #"hash_f8318a5d48451de5" );
    waitframe();
    level thread ob_nm_mode::transition_stream( ob_story_mission_utils::get_activity_starts( "OB_GEMINI_NM_CAFETERIA" )[ 0 ].origin );
    var_ad30c944bbd232d7 = 1.5;
    level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", var_ad30c944bbd232d7, undefined, level.players, undefined, undefined, 1 );
    ob_nm_mode::nightmare_splash( "nm_wave_threat_end" );
    level utility::flag_set( "nm_cafe_interact_ghouls_done" );
}

// Namespace namespace_f6592ea7cc080fa2
// Params 0
// Checksum 0xcec6acf3, Offset: 0x1c68
// Size: 0x1a1
function handle_glass_break()
{
    clips = getentarray( "nm_container_glass_clips", "script_noteworthy" );
    
    if ( isdefined( clips ) )
    {
        foreach ( item in clips )
        {
            item connectpaths();
        }
    }
    
    tube_pos = utility::getstruct( "cage_ai_struct_1", "targetname" );
    playfx( level._effect[ "glass_vfx" ], tube_pos.origin + ( 0, 0, 48 ) );
    playfx( level._effect[ "glass2_vfx" ], tube_pos.origin );
    var_e0c6e35a01fb3d9f = getentarray( "nm_tube_main", "targetname" );
    
    if ( isdefined( var_e0c6e35a01fb3d9f ) )
    {
        foreach ( ent in var_e0c6e35a01fb3d9f )
        {
            playfx( level._effect[ "enemy_vfx" ], ent.origin );
            ent delete();
        }
    }
}

// Namespace namespace_f6592ea7cc080fa2
// Params 0
// Checksum 0x5c14b864, Offset: 0x1e11
// Size: 0x21
function get_death_location()
{
    self waittill( #"death" );
    level.boss_spawn = self.origin;
}

// Namespace namespace_f6592ea7cc080fa2
// Params 1
// Checksum 0xe80401bf, Offset: 0x1e3a
// Size: 0x18
function function_3148ba72070b432b( player )
{
    utility::flag_set( "start_doppelghast_transition" );
}

// Namespace namespace_f6592ea7cc080fa2
// Params 1
// Checksum 0x872f9d59, Offset: 0x1e5a
// Size: 0x45
function set_doppleghast_health( scalar )
{
    if ( isdefined( self ) )
    {
        minibosshealth = self.health;
        new_health = minibosshealth * scalar;
        new_health = int( new_health );
        mp_agent::set_agent_health( new_health );
    }
}

// Namespace namespace_f6592ea7cc080fa2
// Params 0
// Checksum 0x64a88746, Offset: 0x1ea7
// Size: 0x82
function function_cb195eb8993c7ecc()
{
    tag_origin = utility::function_1808878d1c511ce8( self.origin );
    tag_origin.origin = self.origin;
    playfxontag( level._effect[ "orange_flare" ], tag_origin, "tag_origin" );
    level utility::flag_wait( "flag_nm_atrium_complete" );
    stopfxontag( level._effect[ "orange_flare" ], tag_origin, "tag_origin" );
    
    if ( isdefined( tag_origin ) )
    {
        tag_origin delete();
    }
}

// Namespace namespace_f6592ea7cc080fa2
// Params 4
// Checksum 0x485d47e9, Offset: 0x1f31
// Size: 0x1e5
function function_2aedd95d3c7720a4( var_e04c0425c57a325, main_boss, minion_encounter_name, objective_asset )
{
    ob_nm_mode::start_of_round_fanfare( "nm_overlord_boss_start", "nm_miniboss_start" );
    level utility::flag_clear( "nightmare_encouter_done" );
    obj = %"hash_21b2af1c009d4221";
    ob_story_mission_utils::objective_text_show( obj );
    time_modifier = ob_nm_mode::function_3fc7f1f10018b737( 360 );
    ob_story_mission_utils::objective_timer_update( time_modifier );
    level thread ob_nm_mode::wave_fail_timer( time_modifier );
    wait 1;
    
    if ( !isdefined( level.var_6f5c0bece5deb66e ) )
    {
        level.var_6f5c0bece5deb66e = [];
    }
    
    function_c6ab690d8fd83913();
    result = level.amalgam_scaler;
    
    if ( !isdefined( result ) )
    {
        result = 1;
    }
    
    level.amalgam_boss thread ob_nm_mode::set_boss_health( result );
    level.amalgam_boss thread function_bac76538aa8f37fc();
    level.amalgam_boss thread function_26cd0dae10797083();
    level.nm_activity_instance.var_9be376218db54aba = "sat_ob_objectivemarker_nm_big_boss";
    level.nm_activity_instance thread ob_nm_mode::miniboss_objective( level.amalgam_boss );
    level utility::flag_set( "nightmare_encouter_active" );
    thread ob_nm_mode::minion_encounter( minion_encounter_name, "amalgam_phase_1", 0, undefined, undefined, 0 );
    msg = level.amalgam_boss utility::waittill_any_return( "amalgam_phase_2", "death" );
    
    if ( msg == "amalgam_phase_2" )
    {
        thread ob_nm_mode::minion_encounter( minion_encounter_name, "nightmare_encouter_done", 0, undefined, undefined, 0 );
        level.amalgam_boss waittill( #"death" );
    }
    
    level notify( #"cleanup_minions" );
    level notify( #"hash_aefc5c470125baf8" );
    level utility::flag_clear( "nightmare_encouter_active" );
    level utility::flag_set( "nightmare_encouter_done" );
    self.var_9be376218db54aba = undefined;
    ob_nm_mode::end_of_round_fanfare( "nm_overlord_boss_dead" );
}

// Namespace namespace_f6592ea7cc080fa2
// Params 1
// Checksum 0x65e195fd, Offset: 0x211e
// Size: 0x51
function set_amalgam_health( scalar )
{
    if ( isdefined( self ) )
    {
        minibosshealth = self.health;
        new_health = minibosshealth * level.players.size * scalar;
        new_health = int( new_health );
        mp_agent::set_agent_health( new_health );
    }
}

// Namespace namespace_f6592ea7cc080fa2
// Params 0
// Checksum 0x182a5750, Offset: 0x2177
// Size: 0x91
function function_c6ab690d8fd83913()
{
    switch ( level.players.size )
    {
        case 1:
            scaler = 0.5;
            break;
        case 2:
            scaler = 0.8;
            break;
        case 3:
            scaler = 1;
            break;
        case 4:
            scaler = 1.5;
            break;
        default:
            scaler = 1;
            break;
    }
    
    level.amalgam_scaler = scaler;
}

// Namespace namespace_f6592ea7cc080fa2
// Params 1
// Checksum 0x9f4670d, Offset: 0x2210
// Size: 0x83
function function_8b1fd359ac5d4272( condition )
{
    if ( isdefined( self ) )
    {
        if ( condition == 1 )
        {
            self.ignoreall = 1;
            self.ignoreme = 1;
            self.var_4916f80452e056ec = 1;
            self.fixednode = 1;
            self setcandamage( 0 );
        }
        
        if ( condition == 0 )
        {
            self.ignoreall = 0;
            self.ignoreme = 0;
            self.var_4916f80452e056ec = 0;
            self.fixednode = 0;
            self setcandamage( 1 );
        }
    }
}

// Namespace namespace_f6592ea7cc080fa2
// Params 0
// Checksum 0xe499325a, Offset: 0x229b
// Size: 0xb6
function smoke_players()
{
    foreach ( player in level.players )
    {
        grenade = magicgrenademanual( "sat_smoke_grenade_ob", player.origin + ( 0, 0, 24 ), ( 0, 0, 0 ), 0.05 );
    }
    
    wait 1.25;
}

// Namespace namespace_f6592ea7cc080fa2
// Params 0
// Checksum 0xd2b8561c, Offset: 0x2359
// Size: 0x1f5
function function_4d307d6678b3ec6d()
{
    ob_gametype_story_mission::function_b69ee4ccc5e7a2ae( "OB_GEMINI_NM_CAFETERIA" );
    
    foreach ( player in level.players )
    {
        player giveandfireoffhand( "sat_ob_activity_crash_site_blast_start" );
        stun_duration = 1;
        player thread weapon_utility::cleanupconcussionstun( stun_duration );
        level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", 5, undefined, player, undefined, undefined, 1 );
        player playrumbleonentity( "damage_heavy" );
    }
    
    foreach ( player in level.players )
    {
        player thread hud_util::fade_out( 0.5, "white" );
    }
    
    waitframe();
    cafe_teleport_structs = utility::getstructarray( "cafe_teleport_structs", "targetname" );
    coop::teleport_players( level.players, cafe_teleport_structs );
    thread smoke_players();
    
    foreach ( player in level.players )
    {
        player thread hud_util::fade_in( 1.5, "white" );
    }
    
    level utility::flag_set( "flag_cafe_teleport_done" );
}

// Namespace namespace_f6592ea7cc080fa2
// Params 0
// Checksum 0x62a6bcb8, Offset: 0x2556
// Size: 0x1e2
function teleport_to_elevator()
{
    foreach ( player in level.players )
    {
        player giveandfireoffhand( "sat_ob_activity_crash_site_blast_start" );
        stun_duration = 1;
        player thread weapon_utility::cleanupconcussionstun( stun_duration );
        level thread namespace_a350a26c6d662a6a::function_9ac30cec520d32b6( "heavy", 5, undefined, player, undefined, undefined, 1 );
        player playrumbleonentity( "damage_heavy" );
    }
    
    foreach ( player in level.players )
    {
        player thread hud_util::fade_out( 0.5, "white" );
    }
    
    waitframe();
    elevator_teleport_structs = utility::getstructarray( "elevator_teleport_structs", "targetname" );
    coop::teleport_players( level.players, elevator_teleport_structs );
    
    foreach ( player in level.players )
    {
        player thread hud_util::fade_in( 1.5, "white" );
    }
    
    level utility::flag_set( "flag_cafe_teleport_done" );
}

// Namespace namespace_f6592ea7cc080fa2
// Params 0
// Checksum 0x6f7932b0, Offset: 0x2740
// Size: 0xe2
function function_924fae677005ef6c()
{
    ob_nm_mode::start_of_round_fanfare( undefined, "nm_wave_threat_start" );
    obj = %"hash_21b2ac1c009d3d08";
    ob_story_mission_utils::objective_text_show( obj );
    level utility::flag_set( "flag_maze_event" );
    level utility::flag_set( "flag_soul_event" );
    level utility::flag_clear( "flag_maze_event_done" );
    ob_story_mission_utils::objective_timer_update( 480 );
    level thread ob_nm_mode::wave_fail_timer( 480 );
    function_a25acb62ddab20e2( "nm_minion_zombie", 1 );
    function_a73e9aa3b730b0da();
    function_a25acb62ddab20e2( "nm_minion_zombie", 0 );
    level.cadence_override = undefined;
    level utility::flag_set( "flag_maze_event_done" );
    level notify( #"hash_aefc5c470125baf8" );
    ob_story_mission_utils::objective_timer_update( 0 );
    level utility::flag_clear( "flag_maze_event" );
    level.minions_killed = 0;
    level thread ob_nm_mode::function_70467d6be224da52( "nm_overlord_br_complete" );
    level notify( #"stop_circle" );
}

// Namespace namespace_f6592ea7cc080fa2
// Params 0
// Checksum 0xd3d6134f, Offset: 0x282a
// Size: 0x1b9
function function_a73e9aa3b730b0da()
{
    spawn_pos = utility::getstruct( "cage_ai_struct_1", "targetname" );
    level.endpos = spawn_pos.origin + ( 0, 0, 48 );
    level.enemy_count_array = [ 8, 12, 16, 20 ];
    level utility::flag_clear( "flag_enable_super_sprint" );
    obj_id = level.nm_activity_instance ob_story_mission_utils::function_b9cb179f9577f32a( spawn_pos.origin, 120 );
    function_9ca8302e563d9e36( "encounter_gemini_nm_prison_kill_count_1" );
    ob_nm_mode::nightmare_splash( "nm_wave_threat_end" );
    wait 4.5;
    level utility::flag_set( "leg_1_done" );
    level thread function_d8a7357af78c2aca( "sat_spawner_zombie_parasite_ob", "cage_ai_struct_1", undefined, 1, "leg_2_done", 1 );
    ob_nm_mode::nightmare_splash( "nm_wave_threat_start" );
    function_9ca8302e563d9e36( "encounter_gemini_nm_prison_kill_count_2" );
    ob_nm_mode::nightmare_splash( "nm_wave_threat_end" );
    wait 4.5;
    level utility::flag_set( "leg_2_done" );
    level thread function_d8a7357af78c2aca( "sat_spawner_zombie_ghoul_ob_nm", "cage_ai_struct_1", 1, 1, "leg_3_done", 1 );
    level.enemy_count_array = [ 8, 12, 16, 20 ];
    level utility::flag_clear( "flag_enable_super_sprint" );
    ob_nm_mode::nightmare_splash( "nm_wave_threat_start" );
    function_9ca8302e563d9e36( "encounter_gemini_nm_prison_kill_count_3" );
    level.nm_activity_instance ob_story_mission_utils::objective_marker_clear( obj_id );
    level utility::flag_clear( "flag_soul_event" );
    ob_nm_mode::nightmare_splash( "nm_wave_threat_end" );
    wait 2;
    level utility::flag_set( "leg_3_done" );
    function_2c1954c60686e93();
}

// Namespace namespace_f6592ea7cc080fa2
// Params 1
// Checksum 0x2ea86fbe, Offset: 0x29eb
// Size: 0x195
function function_9ca8302e563d9e36( encounter_name )
{
    struct = self;
    level utility::flag_set( "flag_enable_super_sprint" );
    level utility::flag_set( "ambient_encounter_stop" );
    level utility::flag_set( "flag_killcount_event" );
    level utility::flag_clear( "flag_killcount_event_done" );
    level.minion_kill_obj = level.players.size * 15;
    level.minions_killed = 0;
    level.enemy_count_array = [ 10, 15, 20, 30 ];
    level.cadence_override = 0.75;
    level.nm_activity_instance thread ob_nm_mode::minion_encounter( encounter_name, "flag_killcount_event_done" );
    
    if ( level.minion_kill_obj <= 100 )
    {
        level.nm_activity_instance ob_story_mission_utils::function_315d79883d962ba7( level.minions_killed, level.minion_kill_obj );
    }
    else
    {
        fraction = level.minions_killed / level.minion_kill_obj;
        percent = int( fraction * 100 );
        level.nm_activity_instance ob_story_mission_utils::function_315d79883d962ba7( percent, 100 );
    }
    
    while ( level.minions_killed < level.minion_kill_obj )
    {
        waitframe();
    }
    
    level utility::flag_clear( "ambient_encounter_stop" );
    level utility::flag_set( "flag_killcount_event_done" );
    level utility::flag_clear( "flag_killcount_event" );
    level notify( #"hash_f8318a5d48451de5" );
    level.cadence_override = undefined;
    level.nm_activity_instance ob_story_mission_utils::function_315d79883d962ba7( 0, 0 );
}

// Namespace namespace_f6592ea7cc080fa2
// Params 6
// Checksum 0x10bab397, Offset: 0x2b88
// Size: 0x1f4
function function_d8a7357af78c2aca( spawn_type, var_dc6a4b4b351da087, set_goal = 0, container_ai = 0, flag_name, friendly = 0 )
{
    result = level.players.size * 0.5;
    
    if ( friendly == 1 )
    {
        team = level.players[ 0 ].team;
    }
    else
    {
        team = "team_two_hundred";
    }
    
    spawn_struct = utility::getstruct( var_dc6a4b4b351da087, "targetname" );
    spawn_pos = spawn_struct.origin;
    spawn_pos_angles = spawn_struct.angles;
    playfx( level._effect[ "enemy_vfx" ], spawn_pos + ( 0, 0, 32 ) );
    var_20f9e9213a0c9854 = mp_agent::spawnnewagentaitype( spawn_type, spawn_pos, spawn_pos_angles, team );
    var_20f9e9213a0c9854 ob_nm_mode::set_boss_health( result );
    
    if ( isdefined( var_20f9e9213a0c9854 ) )
    {
        if ( set_goal == 1 )
        {
            var_20f9e9213a0c9854 thread ob_nm_mode::individual_vanish( flag_name, spawn_pos );
            waitframe();
        }
        else
        {
            var_20f9e9213a0c9854 thread ob_nm_mode::individual_vanish( flag_name );
        }
        
        if ( container_ai == 1 )
        {
            tag_origin = utility::function_1808878d1c511ce8( spawn_pos, spawn_pos_angles );
            var_20f9e9213a0c9854 linkto( tag_origin );
            var_20f9e9213a0c9854.ignoreall = 1;
            var_20f9e9213a0c9854.ignoreme = 1;
            var_20f9e9213a0c9854.var_4916f80452e056ec = 1;
            var_20f9e9213a0c9854.fixednode = 1;
            var_20f9e9213a0c9854 setcandamage( 0 );
            var_20f9e9213a0c9854.nocorpse = 1;
            
            if ( isalive( level.container_ai ) )
            {
            }
            
            level.container_ai = var_20f9e9213a0c9854;
            var_20f9e9213a0c9854 waittill( #"killed" );
            
            if ( isdefined( tag_origin ) )
            {
                tag_origin delete();
            }
        }
        
        return var_20f9e9213a0c9854;
    }
}

// Namespace namespace_f6592ea7cc080fa2
// Params 3
// Checksum 0x2b86a9f6, Offset: 0x2d84
// Size: 0x233
function function_55b6201062a883e4( scriptable_targetname, min_delay = 0.5, max_delay = 1.5 )
{
    level endon( #"game_ended" );
    level utility::flag_wait( "scriptables_ready" );
    a_barrier_ent = getscriptablearray( scriptable_targetname, #targetname );
    a_barrier_noent = getentitylessscriptablearray( scriptable_targetname, #targetname );
    a_barrier = arraycombine( a_barrier_ent, a_barrier_noent );
    
    if ( a_barrier.size == 0 )
    {
        return;
    }
    
    if ( isdefined( a_barrier[ 0 ].script_index ) )
    {
        a_barrier = utility::array_sort_by_script_index( a_barrier );
    }
    else
    {
        a_barrier = arrayrandomize( a_barrier );
    }
    
    for ( i = 0; i < a_barrier.size ; i++ )
    {
        if ( arraycontains( a_barrier[ i ] function_7c320131bd49bb18(), "main" ) )
        {
            if ( a_barrier[ i ] getscriptablepartstate( "main" ) != "dead" )
            {
                a_barrier[ i ] setscriptablepartstate( "main", "dead" );
            }
        }
        else if ( a_barrier[ i ] getscriptablepartstate( "tag_gemini_mines_breakwall_removed" ) != "dead" )
        {
            a_barrier[ i ] setscriptablepartstate( "tag_gemini_mines_breakwall_removed", "dead" );
        }
        
        earthquake( 0.2, 0.2, a_barrier[ i ].origin, 768 );
        playrumbleonposition( "grenade_rumble", a_barrier[ i ].origin );
        a_players = getplayersinradius( a_barrier[ i ].origin, 512 );
        
        if ( a_players.size > 0 )
        {
            foreach ( player in a_players )
            {
                player shellshock_utility_cpmp::_shellshock( %"frag_grenade_mp", #"explosion", 2 );
            }
        }
        
        wait randomfloatrange( min_delay, max_delay );
    }
}

// Namespace namespace_f6592ea7cc080fa2
// Params 1
// Checksum 0x1d666e17, Offset: 0x2fbf
// Size: 0xfb
function function_d283aee3d1244e6c( scriptable_noteworthy )
{
    level endon( #"game_ended" );
    level utility::flag_wait( "scriptables_ready" );
    a_barrier_ent = getscriptablearray( scriptable_noteworthy, #script_noteworthy );
    a_barrier_noent = getentitylessscriptablearray( scriptable_noteworthy, #script_noteworthy );
    a_barrier = arraycombine( a_barrier_ent, a_barrier_noent );
    
    if ( a_barrier.size == 0 )
    {
        return;
    }
    
    for ( i = 0; i < a_barrier.size ; i++ )
    {
        if ( arraycontains( a_barrier[ i ] function_7c320131bd49bb18(), "main" ) )
        {
            if ( a_barrier[ i ] getscriptablepartstate( "main" ) != "dead" )
            {
                a_barrier[ i ] setscriptablepartstate( "main", "dead" );
            }
        }
        else if ( a_barrier[ i ] getscriptablepartstate( "tag_gemini_mines_breakwall_removed" ) != "dead" )
        {
            a_barrier[ i ] setscriptablepartstate( "tag_gemini_mines_breakwall_removed", "dead" );
        }
        
        wait 1;
    }
}

// Namespace namespace_f6592ea7cc080fa2
// Params 1
// Checksum 0x3222046f, Offset: 0x30c2
// Size: 0xfb
function function_730f747deb04019d( targetname )
{
    level endon( #"game_ended" );
    level utility::flag_wait( "scriptables_ready" );
    a_barrier_ent = getscriptablearray( targetname, #script_noteworthy );
    a_barrier_noent = getentitylessscriptablearray( targetname, #script_noteworthy );
    a_barrier = arraycombine( a_barrier_ent, a_barrier_noent );
    
    if ( a_barrier.size == 0 )
    {
        return;
    }
    
    for ( i = 0; i < a_barrier.size ; i++ )
    {
        if ( arraycontains( a_barrier[ i ] function_7c320131bd49bb18(), "main" ) )
        {
            if ( a_barrier[ i ] getscriptablepartstate( "main" ) != "pristine" )
            {
                a_barrier[ i ] setscriptablepartstate( "main", "pristine" );
            }
        }
        else if ( a_barrier[ i ] getscriptablepartstate( "tag_gemini_mines_breakwall_removed" ) != "pristine" )
        {
            a_barrier[ i ] setscriptablepartstate( "tag_gemini_mines_breakwall_removed", "pristine" );
        }
        
        wait 1;
    }
}

// Namespace namespace_f6592ea7cc080fa2
// Params 0, eflags: 0x4
// Checksum 0xff8e1ee1, Offset: 0x31c5
// Size: 0x1b
function private function_203afe23edb9d304()
{
    self endon( #"death" );
    function_dd00aae2a13bf7eb();
    self kill();
}

// Namespace namespace_f6592ea7cc080fa2
// Params 0
// Checksum 0x768bf9c6, Offset: 0x31e8
// Size: 0x49
function function_dd00aae2a13bf7eb()
{
    if ( !isdefined( var_d8e646f5fdfb1e70 ) )
    {
        var_d8e646f5fdfb1e70 = 0;
    }
    
    namespace_659599414270bd0a::function_748dd662235c0bf();
    namespace_659599414270bd0a::enable_emergence_spawning( 1 );
    namespace_659599414270bd0a::function_efc0cf237cec322b( 20000 );
    namespace_659599414270bd0a::function_cc83d10b65f73ee( var_d8e646f5fdfb1e70 );
    namespace_659599414270bd0a::set_emergence_spawning_through_death_percentage( 100 );
    namespace_659599414270bd0a::force_emergence_spawning( 1 );
}

// Namespace namespace_f6592ea7cc080fa2
// Params 0
// Checksum 0x5ca5289, Offset: 0x3239
// Size: 0x50
function function_165d90b48cb6336b()
{
    waitframe();
    
    if ( isdefined( level.container_ai ) )
    {
        level.container_ai thread scene::play( level.container_ai, "idle_2", "mp_sat_ob_nm_scenes_gemini" );
        level utility::flag_wait( "flag_killcount_event_done" );
        level.container_ai scene::stop();
    }
}

// Namespace namespace_f6592ea7cc080fa2
// Params 0
// Checksum 0x3c648bea, Offset: 0x3291
// Size: 0x2d3
function function_4f5f61acea9b03b9()
{
    scene_struct = utility::getstruct( "cafe_scenes", "targetname" );
    level.ghoul_cafe = mp_agent::spawnnewagentaitype( "sat_spawner_zombie_ghoul_ob_nm", scene_struct.origin, scene_struct.angles, "team_two_hundred" );
    level.ghoul_cafe zombie_utils::function_dfae6a5bd222c586( &function_ca401c4211026608 );
    tag_origin = utility::function_1808878d1c511ce8( scene_struct.origin, scene_struct.angles );
    level.ghoul_cafe linkto( tag_origin );
    level.ghoul_cafe.ignoreall = 1;
    level.ghoul_cafe.ignoreme = 1;
    level.ghoul_cafe.var_4916f80452e056ec = 1;
    level.ghoul_cafe.fixednode = 1;
    level.ghoul_cafe.boss_immune = 1;
    
    if ( isdefined( level.ghoul_cafe ) )
    {
        level utility::flag_wait( "flag_cafe_teleport_done" );
        level.ghoul_cafe utility::ent_flag_set( "ghoul_evolve_forced" );
        level.ghoul_cafe.ignoreall = 0;
        level.ghoul_cafe.ignoreme = 0;
        level.ghoul_cafe.var_4916f80452e056ec = 0;
        level.ghoul_cafe.fixednode = 0;
        wait 0.5;
        structs = utility::getstructarray( "evo_struct", "targetname" );
        
        if ( !isdefined( structs ) || structs.size == 0 )
        {
            return;
        }
        
        for ( i = 0; i < 5 ; i++ )
        {
            spawn_pos = getclosestpointonnavmesh( structs[ i ].origin );
            playfx( level._effect[ "enemy_vfx" ], spawn_pos + ( 0, 0, 32 ) );
            var_20f9e9213a0c9854 = mp_agent::spawnnewagentaitype( "sat_spawner_zombie_base_ob", spawn_pos, ( 0, 0, 0 ), "team_two_hundred" );
        }
        
        thread find_amalgam();
        wait 20;
        
        if ( !utility::flag( "amalgam_spawned" ) )
        {
            if ( isalive( level.ghoul_cafe ) )
            {
                level.ghoul_cafe kill();
            }
            
            boss_spawn = utility::getstruct( "struct_gemini_nm_prison_boss", "targetname" );
            level.amalgam_boss = mp_agent::spawnnewagentaitype( "sat_spawner_zombie_amalgam_ob_nm", boss_spawn.origin, ( 0, 0, 0 ), "team_two_hundred" );
            level.amalgam_boss zombie_utils::function_dfae6a5bd222c586( &function_ca401c4211026608 );
        }
    }
}

// Namespace namespace_f6592ea7cc080fa2
// Params 0
// Checksum 0x5e040fb4, Offset: 0x356c
// Size: 0x169
function find_amalgam()
{
    level.ghoul_cafe waittill( #"death" );
    var_b1d3cd832fbb5b7b = 1;
    
    while ( var_b1d3cd832fbb5b7b )
    {
        enemies = getaiarray();
        
        foreach ( enemy in enemies )
        {
            if ( issubstr( enemy.classname, "amalgam" ) )
            {
                var_b1d3cd832fbb5b7b = 0;
            }
        }
        
        waitframe();
    }
    
    wait 1;
    enemies = getaiarray();
    
    foreach ( enemy in enemies )
    {
        if ( issubstr( enemy.classname, "amalgam" ) )
        {
            level.amalgam_boss = enemy;
            level utility::flag_set( "amalgam_spawned" );
            level.amalgam_boss zombie_utils::function_dfae6a5bd222c586( &function_ca401c4211026608 );
        }
    }
}

// Namespace namespace_f6592ea7cc080fa2
// Params 0
// Checksum 0x53438b2, Offset: 0x36dd
// Size: 0x7d
function function_26cd0dae10797083()
{
    self endon( #"death" );
    max_health = self.health;
    
    while ( self.health > max_health * 0.5 )
    {
        waitframe();
    }
    
    level utility::flag_set( "amalgam_phase_1" );
    thread function_5727bf64335e2d04();
    
    while ( self.health > max_health * 0.33 )
    {
        waitframe();
    }
    
    level.amalgam_boss notify( #"amalgam_phase_2" );
}

// Namespace namespace_f6592ea7cc080fa2
// Params 0
// Checksum 0x1c92cc29, Offset: 0x3762
// Size: 0x284
function function_5727bf64335e2d04()
{
    level.amalgam_boss endon( #"death" );
    
    if ( isdefined( level.amalgam_boss ) )
    {
        function_8fa9b34b8eab6add( level.amalgam_boss );
        level.amalgam_boss thread function_da0f47d09bf1fea();
        
        foreach ( player in level.players )
        {
            player ob_story_mission_utils::player_boss_healthbar_immune();
        }
        
        level.amalgam_boss.boss_immune = 1;
        level.amalgam_boss.ignoreall = 1;
        tag_origin = utility::spawn_tag_origin( level.amalgam_boss.origin, level.amalgam_boss.angles );
        level.amalgam_boss linkto( tag_origin, "tag_origin" );
        level thread ob_nm_mode::function_72282522248ae734( level.amalgam_boss.origin, level.amalgam_boss.origin + ( 0, 0, 64 ) );
        wait 0.5;
        level thread ob_nm_mode::function_72282522248ae734( level.amalgam_boss.origin, level.amalgam_boss.origin + ( 0, 0, 64 ) );
        spawn_boss_minions();
        level utility::flag_clear( "flag_spawning_amalgam_done" );
        function_438df5b82622ef34( level.amalgam_boss );
        level.amalgam_boss unlink();
        waitframe();
        tag_origin delete();
        level.amalgam_boss.boss_immune = 0;
        level.amalgam_boss.ignoreall = 0;
        
        foreach ( player in level.players )
        {
            player ob_story_mission_utils::player_boss_healthbar_show();
        }
    }
}

// Namespace namespace_f6592ea7cc080fa2
// Params 1
// Checksum 0x8d3105d9, Offset: 0x39ee
// Size: 0x5b
function function_8fa9b34b8eab6add( boss )
{
    if ( !isdefined( boss ) )
    {
        return;
    }
    
    snd::play( "uin_sat_nightmare_health_regen_start", boss.origin + ( 0, 0, 80 ) );
    function_438df5b82622ef34( boss );
    boss.var_ffe8160a9d53ca8a = snd::play( "uin_sat_nightmare_health_regen_lp", boss );
}

// Namespace namespace_f6592ea7cc080fa2
// Params 1
// Checksum 0x739f0268, Offset: 0x3a51
// Size: 0x45
function function_438df5b82622ef34( boss )
{
    if ( !isdefined( boss ) )
    {
        return;
    }
    
    if ( isdefined( boss.var_ffe8160a9d53ca8a ) )
    {
        snd::stop( boss.var_ffe8160a9d53ca8a, 0.1 );
        boss.var_ffe8160a9d53ca8a = undefined;
    }
}

// Namespace namespace_f6592ea7cc080fa2
// Params 0
// Checksum 0xcf2b1f36, Offset: 0x3a9e
// Size: 0x17
function function_da0f47d09bf1fea()
{
    self waittill( #"death" );
    function_438df5b82622ef34( self );
}

// Namespace namespace_f6592ea7cc080fa2
// Params 0
// Checksum 0x1944b6eb, Offset: 0x3abd
// Size: 0x37e
function spawn_boss_minions()
{
    level.amalgam_boss endon( #"death" );
    
    if ( !isdefined( level.var_6f5c0bece5deb66e ) )
    {
        level.var_6f5c0bece5deb66e = [];
    }
    
    switch ( level.players.size )
    {
        case 1:
            var_258b7dc6c1bbbd92 = 5;
            break;
        case 2:
            var_258b7dc6c1bbbd92 = 8;
            break;
        case 3:
            var_258b7dc6c1bbbd92 = 10;
            break;
        case 4:
            var_258b7dc6c1bbbd92 = 12;
            break;
        default:
            var_258b7dc6c1bbbd92 = 8;
            break;
    }
    
    if ( !isdefined( level.amalgam_boss ) )
    {
        return;
    }
    
    minion_offset = ( 0, 0, 40 );
    boss_offset = ( 0, 0, 64 );
    structs = utility::getstructarray( "minion_boss_spawns", "targetname" );
    
    if ( !isdefined( structs ) || structs.size == 0 )
    {
        return;
    }
    
    spawn_pos = sortbydistance( structs, level.amalgam_boss.origin );
    
    if ( !isdefined( spawn_pos ) )
    {
        spawn_pos = structs;
    }
    
    for ( i = 0; i < var_258b7dc6c1bbbd92 ; i++ )
    {
        wait 0.5;
        level thread ob_nm_mode::function_72282522248ae734( level.amalgam_boss.origin + boss_offset, spawn_pos[ i ].origin + minion_offset );
        wait 0.3;
        level thread ob_nm_mode::function_72282522248ae734( level.amalgam_boss.origin + boss_offset, spawn_pos[ i ].origin + minion_offset );
        
        if ( i == var_258b7dc6c1bbbd92 - 1 )
        {
            playfx( level._effect[ "enemy_vfx" ], spawn_pos[ i ].origin + ( 0, 0, 32 ) );
            var_20f9e9213a0c9854 = mp_agent::spawnnewagentaitype( "sat_spawner_zombie_ghoul_ob", spawn_pos[ i ].origin, spawn_pos[ i ].angles, "team_two_hundred" );
            var_20f9e9213a0c9854 thread ob_nm_mode::individual_vanish( "nightmare_encouter_done" );
            level.var_6f5c0bece5deb66e[ level.var_6f5c0bece5deb66e.size ] = var_20f9e9213a0c9854;
            continue;
        }
        
        if ( i == var_258b7dc6c1bbbd92 - 2 && var_258b7dc6c1bbbd92 > 9 )
        {
            playfx( level._effect[ "enemy_vfx" ], spawn_pos[ i ].origin + ( 0, 0, 32 ) );
            var_20f9e9213a0c9854 = mp_agent::spawnnewagentaitype( "sat_spawner_zombie_ghoul_ob", spawn_pos[ i ].origin, spawn_pos[ i ].angles, "team_two_hundred" );
            var_20f9e9213a0c9854 thread ob_nm_mode::individual_vanish( "nightmare_encouter_done" );
            level.var_6f5c0bece5deb66e[ level.var_6f5c0bece5deb66e.size ] = var_20f9e9213a0c9854;
            continue;
        }
        
        playfx( level._effect[ "enemy_vfx" ], spawn_pos[ i ].origin + ( 0, 0, 32 ) );
        var_20f9e9213a0c9854 = mp_agent::spawnnewagentaitype( "sat_spawner_zombie_vermin_ob", spawn_pos[ i ].origin, spawn_pos[ i ].angles, "team_two_hundred" );
        var_20f9e9213a0c9854 thread ob_nm_mode::individual_vanish( "nightmare_encouter_done" );
        level.var_6f5c0bece5deb66e[ level.var_6f5c0bece5deb66e.size ] = var_20f9e9213a0c9854;
    }
    
    level utility::flag_set( "flag_spawning_amalgam_done" );
}

// Namespace namespace_f6592ea7cc080fa2
// Params 0
// Checksum 0x46cb60ac, Offset: 0x3e43
// Size: 0x52
function function_bac76538aa8f37fc()
{
    self endon( #"death" );
    self.var_24954f14e27b448d = 0;
    thread ob_nm_mode::setup_boss_healthbar( self.health, self.maxhealth, "ob_boss_nm_amalgam" );
    max_health = self.health;
    thread function_f8216248bd17d70d();
}

// Namespace namespace_f6592ea7cc080fa2
// Params 1
// Checksum 0x2f0ee4a3, Offset: 0x3e9d
// Size: 0x234
function function_fb68e96e4d1951cf( enemies )
{
    boss = self;
    boss endon( #"death" );
    
    foreach ( player in level.players )
    {
        player ob_story_mission_utils::player_boss_healthbar_immune();
    }
    
    boss.boss_immune = 1;
    level.amalgam_boss.ignoreall = 1;
    tag_origin = utility::spawn_tag_origin( boss.origin, boss.angles );
    boss linkto( tag_origin, "tag_origin" );
    
    if ( !isdefined( enemies ) )
    {
        level.var_6f5c0bece5deb66e = getaiarray( "team_two_hundred" );
    }
    
    level.var_6f5c0bece5deb66e = arrayremove( level.var_6f5c0bece5deb66e, boss );
    
    for ( i = 0; i < level.var_6f5c0bece5deb66e.size ; i++ )
    {
        level.var_6f5c0bece5deb66e[ i ] thread sacrificial_heal( boss );
        boss ob_nm_mode::heal_boss( enemy_heal_amount( level.var_6f5c0bece5deb66e[ i ] ) );
        wait 0.2;
    }
    
    wait 4;
    level utility::flag_set( "flag_heal_amalgam_done" );
    boss unlink();
    waitframe();
    tag_origin delete();
    boss.boss_immune = 0;
    boss setcandamage( 1 );
    level.amalgam_boss.ignoreall = 0;
    
    foreach ( player in level.players )
    {
        player ob_story_mission_utils::player_boss_healthbar_show();
    }
}

// Namespace namespace_f6592ea7cc080fa2
// Params 1
// Checksum 0xe19de495, Offset: 0x40d9
// Size: 0x86
function sacrificial_heal( boss )
{
    boss endon( #"death" );
    self endon( #"death" );
    minion_offset = ( 0, 0, 40 );
    boss_offset = ( 0, 0, 64 );
    
    if ( isalive( self ) )
    {
        level thread ob_nm_mode::function_72282522248ae734( self.origin + minion_offset, boss.origin + boss_offset );
        waitframe();
        self kill();
    }
}

// Namespace namespace_f6592ea7cc080fa2
// Params 1
// Checksum 0xff71c90b, Offset: 0x4167
// Size: 0x3d
function enemy_heal_amount( enemy )
{
    var_7306b73201c61041 = 0.02;
    
    if ( issubstr( enemy.classname, "ghoul" ) )
    {
        var_7306b73201c61041 = 0.1;
    }
    
    return var_7306b73201c61041;
}

// Namespace namespace_f6592ea7cc080fa2
// Params 0
// Checksum 0x12a9d06d, Offset: 0x41ad
// Size: 0xcd
function function_f8216248bd17d70d()
{
    self endon( #"death" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    while ( isalive( self ) )
    {
        if ( isdefined( level.health_struct ) )
        {
            level.health_struct.health = max( self.health, 0 );
            
            foreach ( player in level.players )
            {
                player ob_story_mission_utils::function_e231206f1628d4c6( 1 );
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_f6592ea7cc080fa2
// Params 1
// Checksum 0xf42060c, Offset: 0x4282
// Size: 0x1c
function function_ca401c4211026608( params )
{
    if ( self.boss_immune )
    {
        return 0;
    }
    
    return -1;
}

