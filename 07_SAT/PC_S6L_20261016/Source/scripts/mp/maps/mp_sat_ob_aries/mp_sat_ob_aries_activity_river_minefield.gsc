// scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_activity_river_minefield.gsc  (hash_152c7bb94eda4412.gscc) (size: 14899 Bytes / 0x3a33 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xba38efdf (3124293599)
// size ...... 14899 (0x3a33)
// includes .. 11  (offset: 0x3627)
// strings ... 63  (offset: 0x367f)
// dev strs .. 0   (offset: 0x3a33)
// exports ... 48  (offset: 0x2207)
// cseg ...... 0x7e0 + 0x1a27 (0x2207)
// imports ... 103 (offset: 0x2987)
// animtree1 . 0   (offset: 0x3a33)
// animtree2 . 0   (offset: 0x3a33)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_util;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_vo;
#using scripts\mp\ob\systems\ob_flying_drone;

#namespace mp_sat_ob_aries_activity_river_minefield;

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 0, eflags: 0x5
// Checksum 0x74743b58, Offset: 0x7fe
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_863e16c3a77023c7", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 0, eflags: 0x4
// Checksum 0xc9791c0, Offset: 0x827
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_ARIES_RIVER_MINEFIELD";
    activity_common::registeractivitytype( "OB_ARIES_RIVER_MINEFIELD", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_RIVER_MINEFIELD", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_RIVER_MINEFIELD", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_RIVER_MINEFIELD", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_ARIES_RIVER_MINEFIELD" );
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 0
// Checksum 0x283f5127, Offset: 0x89e
// Size: 0x59
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance function_ac83f03e28dfccb1();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 0
// Checksum 0x1bf5c734, Offset: 0x8ff
// Size: 0x39
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance function_5c91f961cd1b04f2();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 0
// Checksum 0x42f41d2d, Offset: 0x940
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 1
// Checksum 0xb430043c, Offset: 0x964
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread function_ff06efab1a5fed08( player );
    }
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 0
// Checksum 0x549bdba7, Offset: 0xa20
// Size: 0x1e
function function_ac83f03e28dfccb1()
{
    activity_instance = self;
    aries_util::function_ff8302797d7d1756();
    level thread function_ddd8463f210a6fac();
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 0
// Checksum 0xbec627ee, Offset: 0xa46
// Size: 0x1f4
function function_5c91f961cd1b04f2()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed", #"flag_river_barge_activity_begin" );
    ob_story_mission_utils::function_6314f03dfe2adbc5();
    
    while ( activity_instance.playerparticipants.size < 1 )
    {
        waitframe();
    }
    
    level.var_5fe1c01595a2e32b = [ "ent_flag_jungle_clear_wp_1", "ent_flag_end_objective_secure_area_1_jungle" ];
    activity_instance thread function_1261b5bbd0832379();
    activity_instance thread function_5d8410d915eb89ba();
    level thread function_e0d983f52416db7f();
    level thread function_b61ec11cbe58ff65();
    level thread aries_vo::function_619b2bdb7e7d965c();
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_river_trail_weapon", "flag_river_barge_activity_begin", 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_river_trail_equipment", "flag_river_barge_activity_begin", 1 );
    activity_instance thread ob_story_mission_utils::function_e6799e9a19df2365( "s_river_minefield_cache", %"hash_43f0ed9b2eb8b832", 2 );
    activity_instance function_bc3cd2b11b413a08();
    activity_instance thread function_8ffed4384d293fef();
    
    foreach ( player in level.players )
    {
        player thread function_be9a82cccd6c0a54();
        player thread function_5553377e81b7092c();
    }
    
    activity_instance thread function_ba42a6dfa342af8d( 4 );
    level.var_aa4933c6c52b61c6 = [];
    activity_instance thread function_b942a4c048724a10( "s_trail_ambush_drone_01", "s_trail_ambush_drone_largesquad_01" );
    activity_instance thread function_89ef9da601bb363e( 2 );
    activity_instance thread function_2ee4a8a8a1e1dfc();
    activity_instance thread trail_spawn_reinforcements();
    activity_instance utility::flag_wait( "flg_jungle_minefield_complete" );
    level utility::flag_set( "flag_river_barge_activity_begin" );
    
    if ( isdefined( level.var_f6961b333ee62c5a ) )
    {
        level.var_f6961b333ee62c5a = undefined;
    }
    
    if ( isdefined( level.var_cd9c067574448018 ) )
    {
        level.var_cd9c067574448018 = undefined;
    }
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 0
// Checksum 0x72e8350e, Offset: 0xc42
// Size: 0x49
function function_b61ec11cbe58ff65()
{
    animnode = utility::getstruct( "sat_cin_ari_nightmare_vines_01", "targetname" );
    waitframe();
    animnode scene::play( undefined, "nightmare_village_idle" );
    utility::flag_wait( "flg_jungle_minefield_complete" );
    animnode scene::play( undefined, "nightmare_village" );
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 0
// Checksum 0x380a08a4, Offset: 0xc93
// Size: 0x59
function function_1261b5bbd0832379()
{
    activity_instance = self;
    activity_instance thread ob_story_mission_utils::function_273dfd9583646854( "river_trail_vtol_2", undefined, 1, "flag_end_objective_secure_area_1_jungle", 100, 300, 0, undefined, undefined, 1, 1 );
    wait 1.5;
    activity_instance thread ob_story_mission_utils::function_273dfd9583646854( "river_trail_vtol_1", undefined, 1, "flag_end_objective_secure_area_1_jungle", 100, 300, 0, undefined, undefined, 1, 1 );
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 0
// Checksum 0x7038355e, Offset: 0xcf4
// Size: 0xc0
function function_cb46cda779a85ee1()
{
    activity_instance = self;
    activity_instance endon( #"flag_river_barge_activity_begin" );
    var_546ebd1a121e8a80 = aries_util::function_619b5a0410cf1a0a( "e_river_trail_vtol", "hide" );
    level utility::flag_wait( "flag_river_minefield_progress_01" );
    
    foreach ( ent in var_546ebd1a121e8a80 )
    {
        if ( isdefined( ent ) )
        {
            ent show();
            ent thread river_trail_vtol_follow_path();
        }
    }
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 0
// Checksum 0xd4e8be0d, Offset: 0xdbc
// Size: 0x87
function river_trail_vtol_follow_path()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    s_point_1 = utility::getstruct( self.target, "targetname" );
    s_point_2 = utility::getstruct( s_point_1.target, "targetname" );
    
    if ( isdefined( s_point_1 ) )
    {
        self moveto( s_point_1.origin, 4 );
    }
    
    wait 3;
    
    if ( isdefined( s_point_2 ) )
    {
        self moveto( s_point_2.origin, 4 );
    }
    
    wait 4;
    self delete();
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 1
// Checksum 0x64a3e4d8, Offset: 0xe4b
// Size: 0x4d
function function_ff06efab1a5fed08( player )
{
    activity_instance = self;
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        player ob_story_mission_utils::function_2383fc8bfc3074d2();
        player ob_story_mission_utils::function_288fdad79fa2a11();
    }
    
    activity_instance thread function_33556d3682473141( player );
}

/#

    // Namespace mp_sat_ob_aries_activity_river_minefield
    // Params 0
    // Checksum 0x408ead98, Offset: 0xea0
    // Size: 0x5, Type: dev
    function function_780e02a04ec694e6()
    {
        
    }

#/

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 0
// Checksum 0xc026a172, Offset: 0xead
// Size: 0x60
function function_bc3cd2b11b413a08()
{
    activity_instance = self;
    level.var_f6961b333ee62c5a = [];
    level.var_cd9c067574448018 = 5;
    level.var_433ec1dc5abccd5b = 2;
    activity_instance thread minefield_spawn_soldiers();
    level waittill( #"hash_d23350cac8d61287" );
    activity_instance thread function_6448832d9d91e714( level.var_cd9c067574448018, level.var_433ec1dc5abccd5b );
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 0
// Checksum 0x4f7d1876, Offset: 0xf15
// Size: 0x71
function minefield_spawn_soldiers()
{
    activity_instance = self;
    var_31453435f28ada70 = "enc_river_minefield";
    var_65ce58bbb0ae2c0d = activity_instance activity_ai_encounters::function_92b671064b0b1ce2( var_31453435f28ada70, 1, 1, 1, 1 );
    function_ef57f478f96b050c( var_65ce58bbb0ae2c0d, 1 );
    function_64ac8c4e752f4dca( var_65ce58bbb0ae2c0d, 0 );
    activity_instance activity_ai_encounters::function_52d1342183200a8f( var_65ce58bbb0ae2c0d, &function_5ddf2ec0f55806b7, activity_instance );
    level utility::flag_wait( "flag_player_on_barge_touching" );
    function_64ac8c4e752f4dca( var_65ce58bbb0ae2c0d, 1 );
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 4, eflags: 0x4
// Checksum 0xdb6d52a7, Offset: 0xf8e
// Size: 0xb3
function private function_5ddf2ec0f55806b7( requestid, activity_instance, agent, data )
{
    level endon( #"story_mission_startpoint_called" );
    agent endon( #"death" );
    data = function_9b649316adcccbaa( requestid );
    
    if ( !isdefined( level.var_f6961b333ee62c5a ) )
    {
        level.var_f6961b333ee62c5a = [];
    }
    
    level.var_f6961b333ee62c5a = arraycombineunique( level.var_f6961b333ee62c5a, [ agent ] );
    waitframe();
    agent thread function_33fb183cc948c7e9( 1 );
    agent thread function_5a27e38489578e2f();
    
    if ( level.var_f6961b333ee62c5a.size > level.var_cd9c067574448018 )
    {
        level notify( #"hash_d23350cac8d61287" );
    }
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 1
// Checksum 0xe1803483, Offset: 0x1049
// Size: 0x93
function function_ba42a6dfa342af8d( f_wait_time = 0 )
{
    level utility::flag_wait( "flag_river_trail_ambush" );
    wait f_wait_time;
    activity_instance = self;
    var_31453435f28ada70 = "enc_river_minefield_bots";
    var_65ce58bbb0ae2c0d = activity_instance activity_ai_encounters::function_92b671064b0b1ce2( var_31453435f28ada70, 1, 1, 1, 1 );
    function_ef57f478f96b050c( var_65ce58bbb0ae2c0d, 1 );
    function_64ac8c4e752f4dca( var_65ce58bbb0ae2c0d, 0 );
    activity_instance activity_ai_encounters::function_52d1342183200a8f( var_65ce58bbb0ae2c0d, &function_40744911f039bd2a, activity_instance );
    level utility::flag_wait( "flag_player_on_barge_touching" );
    function_64ac8c4e752f4dca( var_65ce58bbb0ae2c0d, 1 );
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 3
// Checksum 0x8b54a1c, Offset: 0x10e4
// Size: 0x1f6
function function_b942a4c048724a10( str_spawn_struct, var_eb6571af1cc6da93, f_wait_time = 0 )
{
    level endon( #"game_ended" );
    activity_instance = self;
    level utility::flag_wait( "flag_river_trail_ambush" );
    wait f_wait_time;
    var_373c257214a92f83 = utility::getstructarray( str_spawn_struct, "targetname" );
    
    if ( isdefined( var_eb6571af1cc6da93 ) )
    {
        if ( !level.is_squad_size_small )
        {
            var_3a9baec23e0c3ab2 = utility::getstructarray( var_eb6571af1cc6da93, "targetname" );
            var_373c257214a92f83 = arraycombineunique( var_373c257214a92f83, var_3a9baec23e0c3ab2 );
        }
    }
    
    foreach ( struct in var_373c257214a92f83 )
    {
        str_drone_type = "turret";
        
        if ( isdefined( struct.script_noteworthy ) )
        {
            str_drone_type = struct.script_noteworthy;
        }
        
        spawnoptions = {};
        spawnoptions.spawnpos = struct.origin;
        spawnoptions.finish_pos = undefined;
        spawnoptions.activationdelay = 0;
        spawnoptions.var_bd2b4756836f0b9a = 0;
        spawnoptions.var_75fab83acb648e4e = 1024;
        var_5990ce3727e634d1 = utility::getstruct( struct.target, "targetname" );
        activity_instance thread function_900f97f566dcda73( str_drone_type, struct.origin, level.players[ 0 ], spawnoptions, var_5990ce3727e634d1 );
        var_39ae44a13ef5cd04 = randomfloat( 0.4 );
        wait var_39ae44a13ef5cd04;
    }
    
    if ( !utility::flag( "flag_river_trail_drones_spawned" ) )
    {
        level utility::flag_set( "flag_river_trail_drones_spawned" );
    }
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 5
// Checksum 0x4252950a, Offset: 0x12e2
// Size: 0xa5
function function_900f97f566dcda73( str_type, v_origin, var_5ddea964f429e3cf, options, var_73b8002ea49e30f )
{
    spawn_path_array = [ v_origin ];
    drone = ob_flying_drone::spawn_helper_drone( str_type, var_5ddea964f429e3cf, spawn_path_array, undefined, options );
    drone.pos = undefined;
    
    if ( !isdefined( level.var_aa4933c6c52b61c6 ) )
    {
        level.var_aa4933c6c52b61c6 = [];
    }
    
    level.var_aa4933c6c52b61c6[ level.var_aa4933c6c52b61c6.size ] = drone;
    drone thread function_fab7bfa141832420( var_73b8002ea49e30f );
    drone thread function_5f924ac04ac4cd78();
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 2
// Checksum 0x96b84f9f, Offset: 0x138f
// Size: 0x5f
function function_fab7bfa141832420( var_5990ce3727e634d1, var_39ae44a13ef5cd04 = 0.1 )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( self ) || !isdefined( var_5990ce3727e634d1 ) )
    {
        return;
    }
    
    self endon( #"death" );
    wait var_39ae44a13ef5cd04;
    self.centerpos = var_5990ce3727e634d1.origin;
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 1
// Checksum 0x6564655, Offset: 0x13f6
// Size: 0xd1
function function_89ef9da601bb363e( var_30c3fbe0bc147a42 )
{
    level endon( #"flag_river_trail_drones_defeated" );
    level endon( #"flag_river_trail_reinforce" );
    level endon( #"flag_river_minefield_progress_03" );
    level utility::flag_wait_all( "flag_river_minefield_progress_02_leftside", "flag_river_trail_drones_spawned" );
    var_4ae50740578e6e2a = utility::getstructarray( "s_trail_drones_leftflank_attack", "targetname" );
    
    for ( var_46166621547d16a4 = 0; var_46166621547d16a4 < var_30c3fbe0bc147a42 && var_46166621547d16a4 < var_4ae50740578e6e2a.size && var_46166621547d16a4 < level.var_aa4933c6c52b61c6.size ; var_46166621547d16a4++ )
    {
        level.var_aa4933c6c52b61c6[ var_46166621547d16a4 ] thread function_fab7bfa141832420( var_4ae50740578e6e2a[ var_46166621547d16a4 ] );
    }
    
    if ( level.players.size > 2 || !level.is_squad_size_small )
    {
        function_b942a4c048724a10( "s_trail_leftflank_drone" );
    }
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 0
// Checksum 0x660d3795, Offset: 0x14cf
// Size: 0x6b
function function_fa71ad8c0fcebea0()
{
    level endon( #"flag_river_trail_drones_defeated" );
    var_8d9616db05d2d13e = utility::getstructarray( "s_trail_drones_exitcorridor", "targetname" );
    
    for ( i = 0; i < var_8d9616db05d2d13e.size && i < level.var_aa4933c6c52b61c6.size ; i++ )
    {
        level.var_aa4933c6c52b61c6[ i ] thread function_fab7bfa141832420( var_8d9616db05d2d13e[ i ] );
    }
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 0
// Checksum 0x5d12e6c, Offset: 0x1542
// Size: 0x3b
function function_5f924ac04ac4cd78()
{
    self endon( #"death" );
    level utility::flag_wait_any( "flag_trg_weakpoint_location_1", "flag_trg_weakpoint_location_2", "flag_trg_weakpoint_location_3" );
    level.var_aa4933c6c52b61c6 = undefined;
    self notify( #"death" );
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 0
// Checksum 0x1d24f904, Offset: 0x1585
// Size: 0x7f
function function_2ee4a8a8a1e1dfc()
{
    level endon( #"flag_river_barge_activity_begin" );
    level utility::flag_wait( "flag_river_trail_drones_spawned" );
    
    while ( !isdefined( level.var_aa4933c6c52b61c6 ) || level.var_aa4933c6c52b61c6.size <= 0 )
    {
        wait 0.1;
    }
    
    while ( level.var_aa4933c6c52b61c6.size > 0 )
    {
        level.var_aa4933c6c52b61c6 = utility::function_8391781ea0784541( level.var_aa4933c6c52b61c6 );
        wait 0.1;
    }
    
    level utility::flag_set( "flag_river_trail_drones_defeated" );
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 4
// Checksum 0xcad8ef41, Offset: 0x160c
// Size: 0x6e
function function_40744911f039bd2a( requestid, activity_instance, agent, data )
{
    level endon( #"story_mission_startpoint_called" );
    data = function_9b649316adcccbaa( requestid );
    
    if ( !isdefined( level.var_f6961b333ee62c5a ) )
    {
        level.var_f6961b333ee62c5a = [];
    }
    
    level.var_f6961b333ee62c5a = arraycombineunique( level.var_f6961b333ee62c5a, [ agent ] );
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 2
// Checksum 0x92c72c1f, Offset: 0x1682
// Size: 0xab
function function_6448832d9d91e714( var_803dee4bb7ec3192, var_59c6b46cf4005e3c )
{
    activity_instance = self;
    activity_instance endon( #"flag_river_barge_activity_begin" );
    
    while ( level.var_f6961b333ee62c5a.size > var_803dee4bb7ec3192 )
    {
        wait 0.5;
        level.var_f6961b333ee62c5a = utility::array_removedead_or_dying( level.var_f6961b333ee62c5a );
    }
    
    level utility::flag_set( "flag_river_trail_reinforce" );
    
    while ( level.var_f6961b333ee62c5a.size > var_59c6b46cf4005e3c )
    {
        wait 0.5;
        level.var_f6961b333ee62c5a = utility::array_removedead_or_dying( level.var_f6961b333ee62c5a );
    }
    
    level utility::flag_set( "flag_river_trail_reinforce_final" );
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 1
// Checksum 0xe87121ec, Offset: 0x1735
// Size: 0x136
function function_33fb183cc948c7e9( f_wait_time = 0 )
{
    self endon( #"death" );
    
    if ( isdefined( self.var_8f9ee136590854c1 ) )
    {
        return;
    }
    
    self.var_8f9ee136590854c1 = 1;
    
    if ( self.agent_type == "actor_sat_ob_enemy_guild_bot" || self.agent_type == "actor_sat_ob_enemy_guild_bot_cradle" )
    {
        function_d11fe7c0d48cce67();
        return;
    }
    
    target_node = self.goalnode;
    thread function_ed7f83110215f48d();
    thread function_6c8f4b3f89301664();
    thread function_9c89f93627ef2003( 128 );
    function_15e00ddc3febfbae( 1, target_node );
    level utility::flag_wait( "flag_river_trail_ambush" );
    wait f_wait_time;
    function_15e00ddc3febfbae( 0 );
    
    if ( isdefined( self.var_580e1d14b75cbfbc ) && self.var_580e1d14b75cbfbc == 1 )
    {
        return;
    }
    
    if ( isdefined( target_node ) )
    {
        str_goal_targetname = target_node.script_noteworthy;
        [ target_volume ] = getnoentvolumearray( str_goal_targetname, #targetname );
    }
    
    if ( isdefined( target_volume ) )
    {
        self setgoalpos( self.origin, 16 );
        self setgoalvolumeauto( target_volume );
    }
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 2
// Checksum 0x8f6e33a7, Offset: 0x1873
// Size: 0x1bc
function function_15e00ddc3febfbae( var_3a8998ec795e15ff, var_efc35054132eea9 )
{
    self endon( #"death" );
    
    if ( !var_3a8998ec795e15ff )
    {
        if ( isdefined( self.og_goalradius ) )
        {
            self.goalradius = self.og_goalradius;
        }
        else
        {
            self.goalradius = 512;
        }
    }
    else
    {
        self.og_goalradius = self.goalradius;
        self.goalradius = 16;
    }
    
    if ( self.agent_type == "actor_sat_ob_enemy_specialist_rusher" )
    {
        self.meleeonly = var_3a8998ec795e15ff;
        self.var_d3a2a716bfeea071 = var_3a8998ec795e15ff ? 0 : 1;
    }
    
    self.ignoreall = var_3a8998ec795e15ff;
    
    if ( !var_3a8998ec795e15ff )
    {
        nearestplayer = function_628bac9faa9d1e86( level.players, self.origin )[ 0 ];
        self getenemyinfo( nearestplayer );
        wait 1;
    }
    
    self.dontevershoot = var_3a8998ec795e15ff;
    self.dontshootwhilemoving = var_3a8998ec795e15ff;
    self.var_fccfc00935827567 = var_3a8998ec795e15ff;
    self.var_911e12c7cc4a33c1 = var_3a8998ec795e15ff;
    self.var_7fd07f3dcf6ee004 = var_3a8998ec795e15ff;
    self.fixednode = var_3a8998ec795e15ff;
    
    if ( var_3a8998ec795e15ff )
    {
        self allowedstances( "crouch", "prone" );
    }
    else
    {
        self allowedstances( "crouch", "prone", "stand" );
    }
    
    if ( isdefined( var_efc35054132eea9 ) )
    {
        var_efc35054132eea9 setnodeallowlookpeek( !var_3a8998ec795e15ff );
    }
    else if ( var_3a8998ec795e15ff )
    {
        self setgoalpos( self.origin, 16 );
    }
    else
    {
        [ vol_default ] = getnoentvolumearray( "vol_river_minefield_all", #targetname );
        self setgoalvolumeauto( vol_default );
    }
    
    function_44e505cb5b1a418e( !var_3a8998ec795e15ff );
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 0
// Checksum 0x2eadb3fa, Offset: 0x1a37
// Size: 0x3a
function function_d11fe7c0d48cce67()
{
    self endon( #"death" );
    thread function_ed7f83110215f48d();
    thread function_6c8f4b3f89301664();
    function_c304a012a4b36c70( 1 );
    level utility::flag_wait( "flag_river_trail_ambush" );
    function_c304a012a4b36c70( 0 );
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 1
// Checksum 0xbefa2024, Offset: 0x1a79
// Size: 0x38
function function_c304a012a4b36c70( var_3a8998ec795e15ff )
{
    self.dontevershoot = var_3a8998ec795e15ff;
    self.var_f180e42891d1bb1c = var_3a8998ec795e15ff;
    
    if ( var_3a8998ec795e15ff )
    {
        self setgoalpos( self.origin, 16 );
    }
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 1
// Checksum 0x306426b0, Offset: 0x1ab9
// Size: 0x5d
function function_44e505cb5b1a418e( var_f1fbc291f2430b1e )
{
    if ( var_f1fbc291f2430b1e )
    {
        if ( isdefined( self.var_7787bc76eaa52c3 ) )
        {
            self.grenadeammo = self.var_7787bc76eaa52c3;
        }
        else
        {
            self.grenadeammo = 6;
        }
        
        return;
    }
    
    self.var_7787bc76eaa52c3 = self.grenadeammo;
    self.grenadeammo = 0;
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 0
// Checksum 0xe010a3d, Offset: 0x1b1e
// Size: 0x49
function function_8ffed4384d293fef()
{
    if ( utility::flag( "flag_river_trail_ambush" ) )
    {
        return;
    }
    
    level endon( #"flag_river_trail_ambush" );
    level utility::flag_wait( "flag_river_trail_begin_ambush_monitoring" );
    level utility::flag_wait_any( "flag_river_minefield_progress_02", "flag_river_minefield_progress_02_leftside" );
    level utility::flag_set( "flag_river_trail_ambush" );
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 0
// Checksum 0x4e930a4a, Offset: 0x1b6f
// Size: 0x35
function function_be9a82cccd6c0a54()
{
    level endon( #"flag_river_trail_ambush" );
    level utility::flag_wait( "flag_river_trail_begin_ambush_monitoring" );
    self waittill( #"weapon_fired" );
    level utility::flag_set( "flag_river_trail_ambush" );
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 0
// Checksum 0xc2e30acc, Offset: 0x1bac
// Size: 0x6e
function function_5553377e81b7092c()
{
    level endon( #"flag_river_trail_ambush" );
    level utility::flag_wait( "flag_river_trail_begin_ambush_monitoring" );
    
    while ( true )
    {
        self waittill( #"grenade_fire", var_25c93cd85acadaae, var_2e08e94c9cb1747c );
        
        if ( isdefined( var_2e08e94c9cb1747c ) && var_2e08e94c9cb1747c.basename != "sat_grappling_hook_ob" )
        {
            level utility::flag_set( "flag_river_trail_ambush" );
        }
    }
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 0
// Checksum 0x12a06202, Offset: 0x1c22
// Size: 0x58
function function_ed7f83110215f48d()
{
    self endon( #"death" );
    
    if ( utility::flag( "flag_river_trail_ambush" ) )
    {
        return;
    }
    
    level endon( #"flag_river_trail_ambush" );
    self waittill( #"damage", attacker );
    
    if ( isplayer( attacker ) )
    {
        level utility::flag_set( "flag_river_trail_ambush" );
    }
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 0
// Checksum 0x1c0cc116, Offset: 0x1c82
// Size: 0x4c
function function_6c8f4b3f89301664()
{
    if ( utility::flag( "flag_river_trail_ambush" ) )
    {
        return;
    }
    
    level endon( #"flag_river_trail_ambush" );
    self waittill( #"death", attacker );
    
    if ( isplayer( attacker ) )
    {
        level utility::flag_set( "flag_river_trail_ambush" );
    }
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 1
// Checksum 0x99e0c359, Offset: 0x1cd6
// Size: 0xf3
function function_9c89f93627ef2003( f_detect_dist )
{
    if ( utility::flag( "flag_river_trail_ambush" ) )
    {
        return;
    }
    
    level endon( #"flag_river_trail_ambush" );
    self endon( #"death" );
    var_9c9f604f49279920 = 0;
    
    while ( !var_9c9f604f49279920 )
    {
        foreach ( player in level.players )
        {
            var_2a80491bd0b645ad = distance( self.origin, player.origin );
            
            if ( var_2a80491bd0b645ad < f_detect_dist )
            {
                level utility::flag_set( "flag_river_trail_ambush" );
            }
        }
        
        wait 0.25;
    }
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 0
// Checksum 0x84cfbf7c, Offset: 0x1dd1
// Size: 0xb8
function trail_spawn_reinforcements()
{
    activity_instance = self;
    level utility::flag_wait_any( "flag_river_trail_reinforce", "flag_river_minefield_progress_03" );
    var_31453435f28ada70 = "enc_river_minefield_reinforcements";
    var_65ce58bbb0ae2c0d = activity_instance activity_ai_encounters::function_92b671064b0b1ce2( var_31453435f28ada70, 1, 1, 1, 1 );
    function_ef57f478f96b050c( var_65ce58bbb0ae2c0d, 1 );
    activity_instance activity_ai_encounters::function_52d1342183200a8f( var_65ce58bbb0ae2c0d, &function_b1048b3c9fc015ef, "flag_river_trail_reinforce_finished_spawn" );
    level utility::flag_wait_any( "flag_river_minefield_progress_04", "flag_river_trail_reinforce_final" );
    var_31453435f28ada70 = "enc_river_minefield_reinforcements_final";
    var_65ce58bbb0ae2c0d = activity_instance activity_ai_encounters::function_92b671064b0b1ce2( var_31453435f28ada70, 1, 1, 1, 1 );
    function_ef57f478f96b050c( var_65ce58bbb0ae2c0d, 1 );
    activity_instance activity_ai_encounters::function_52d1342183200a8f( var_65ce58bbb0ae2c0d, &function_b1048b3c9fc015ef, "flag_river_trail_reinforce_final_finished_spawn" );
    thread function_fa71ad8c0fcebea0();
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 4
// Checksum 0xf8966ff7, Offset: 0x1e91
// Size: 0xd8
function function_b1048b3c9fc015ef( requestid, var_3fe146a19ef8dc2b, agent, data )
{
    level endon( #"story_mission_startpoint_called" );
    agent endon( #"death" );
    data = function_9b649316adcccbaa( requestid );
    
    if ( !isdefined( level.var_f6961b333ee62c5a ) )
    {
        level.var_f6961b333ee62c5a = [];
    }
    
    level.var_f6961b333ee62c5a = arraycombineunique( level.var_f6961b333ee62c5a, [ agent ] );
    level utility::flag_set( var_3fe146a19ef8dc2b );
    level utility::flag_wait( "flag_river_trail_reinforce_final" );
    str_target_vol = "vol_river_minefield_corridor";
    var_252d981212493b30 = getnoentvolumearray( str_target_vol, #targetname );
    agent setgoalpos( agent.origin );
    agent setgoalvolumeauto( var_252d981212493b30[ 0 ] );
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 0
// Checksum 0xd2f7fbd6, Offset: 0x1f71
// Size: 0xda
function function_e0d983f52416db7f()
{
    while ( utility::flag( "flag_river_barge_activity_begin" ) == 0 )
    {
        level.var_f6961b333ee62c5a = utility::array_removedead_or_dying( level.var_f6961b333ee62c5a );
        
        if ( level.var_f6961b333ee62c5a.size <= 0 && utility::flag( "flag_river_trail_reinforce_final_finished_spawn" ) )
        {
            level thread aries_vo::function_1bb29a8bea831567();
            
            foreach ( player in level.players )
            {
                player utility::ent_flag_set( "flag_river_trail_enemies_dead" );
            }
            
            break;
        }
        
        wait 0.1;
    }
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 0
// Checksum 0x89e9f437, Offset: 0x2053
// Size: 0x78
function function_5a27e38489578e2f()
{
    if ( isdefined( self.var_3a582d9d7882d2cb ) )
    {
        return;
    }
    
    self endon( #"death" );
    self.var_3a582d9d7882d2cb = 1;
    level utility::flag_wait( "flag_river_trail_reinforce" );
    [ var_82df36f723457186 ] = getnoentvolumearray( "vol_river_minefield_fallback", #targetname );
    self setgoalpos( self.origin, 16 );
    self setgoalvolumeauto( var_82df36f723457186 );
}

/#

    // Namespace mp_sat_ob_aries_activity_river_minefield
    // Params 0
    // Checksum 0xf15d504f, Offset: 0x20d3
    // Size: 0x5, Type: dev
    function function_7cd81705b5b3efb7()
    {
        
    }

#/

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 0
// Checksum 0x2a14ba1b, Offset: 0x20e0
// Size: 0x33
function function_5d8410d915eb89ba()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance thread ob_story_mission_utils::objective_text_show( "ob_aries_fight_through_jungle" );
}

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 1
// Checksum 0x9fa10a0a, Offset: 0x211b
// Size: 0x82
function function_33556d3682473141( player )
{
    activity_instance = self;
    player endon( #"ent_flg_jungle_minefield_complete", #"death_or_disconnect" );
    player utility::ent_flag_wait_any( "ent_flag_river_minefield_progress_03", "flag_river_trail_enemies_dead" );
    obj_s = utility::getstruct( "wp_cross_minefield_objective_struct", "targetname" );
    activity_instance thread aries_util::function_e6895f5efd1feb56( player, obj_s.origin, undefined, "sat_ob_objectivemarker_storymissionmain", player, "ent_flg_jungle_minefield_complete", undefined, 2500 );
}

/#

    // Namespace mp_sat_ob_aries_activity_river_minefield
    // Params 0
    // Checksum 0xb7db3498, Offset: 0x21a5
    // Size: 0x5, Type: dev
    function function_3bd535dcf53b4838()
    {
        
    }

#/

// Namespace mp_sat_ob_aries_activity_river_minefield
// Params 0
// Checksum 0x7b8ab095, Offset: 0x21b2
// Size: 0x55
function function_ddd8463f210a6fac()
{
    int_guild_bots_enabled = getdvarint( @"hash_72c4f4e1118330e6", 0 );
    
    if ( int_guild_bots_enabled == 1 )
    {
        function_a25acb62ddab20e2( "guild_bots_enabled", 1 );
        function_a25acb62ddab20e2( "guild_bots_disabled", 0 );
        return;
    }
    
    function_a25acb62ddab20e2( "guild_bots_enabled", 0 );
    function_a25acb62ddab20e2( "guild_bots_disabled", 1 );
}

