// scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_activity_river_barge.gsc  (hash_7b8751f1e117ab12.gscc) (size: 18981 Bytes / 0x4a25 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x252e6cf6 (623799542)
// size ...... 18981 (0x4a25)
// includes .. 16  (offset: 0x43ad)
// strings ... 105 (offset: 0x442d)
// dev strs .. 0   (offset: 0x4a25)
// exports ... 45  (offset: 0x2cad)
// cseg ...... 0xb2e + 0x217f (0x2cad)
// imports ... 129 (offset: 0x33b5)
// animtree1 . 0   (offset: 0x4a25)
// animtree2 . 0   (offset: 0x4a25)
#using script_16555c1140262e45;
#using script_16d8789bae43669e;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\save;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\interaction;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_audio;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_util;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_vo;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_weakpoint;

#namespace mp_sat_ob_aries_activity_river_barge;

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 0, eflags: 0x5
// Checksum 0x8845d7f7, Offset: 0xb4c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_3c56b077070a0927", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 0, eflags: 0x4
// Checksum 0x4b57b100, Offset: 0xb75
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_ARIES_RIVER_BARGE";
    activity_common::registeractivitytype( "OB_ARIES_RIVER_BARGE", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_RIVER_BARGE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_RIVER_BARGE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_RIVER_BARGE", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_ARIES_RIVER_BARGE" );
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 0
// Checksum 0x53f6886e, Offset: 0xbec
// Size: 0x59
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance function_d7c11cb1178f2905();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 0
// Checksum 0xc7e0ad0a, Offset: 0xc4d
// Size: 0x39
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance function_26601a82ef41c5e();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 0
// Checksum 0x5343ded, Offset: 0xc8e
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 1
// Checksum 0x8fe83372, Offset: 0xcb2
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread function_bb2ea56c623df824( player );
    }
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 0
// Checksum 0x608f76dc, Offset: 0xd6e
// Size: 0x33
function function_d7c11cb1178f2905()
{
    activity_instance = self;
    level utility::flag_set_array( [ "flag_river_barge_activity_begin", "flg_jungle_village_start_obj" ] );
    activity_instance thread function_50ca4c126e1c5eec();
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 0
// Checksum 0x3c201861, Offset: 0xda9
// Size: 0x2c5
function function_26601a82ef41c5e()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    ob_story_mission_utils::function_6314f03dfe2adbc5( 0 );
    level.var_5fe1c01595a2e32b = [ "ent_flag_jungle_clear_wp_1", "ent_flag_end_objective_secure_area_1_jungle", "ent_flg_jungle_minefield_complete" ];
    activity_instance thread namespace_1f3f9eb1e9681da5::function_9dbeaf9ca833864( activity_instance, "player_catchup_river_barge", "player_catchup_river_barge_complete", 3 );
    activity_instance thread function_4d46c3009c76f0c1();
    setdvar( @"hash_4bc188e324733a72", 1 );
    
    if ( !isdefined( save::mission_get_data().var_e38d71218638a518 ) )
    {
        save::mission_get_data().var_e38d71218638a518 = [];
    }
    else if ( save::mission_get_data().var_e38d71218638a518.size > 0 )
    {
        utility::flag_set_array( [ "flag_cargo_inspect_intro" ] );
    }
    
    activity_instance function_4a56e51534d1d86a();
    activity_instance thread function_dad0286078036091();
    level thread aries_util::mortars_fx_init();
    activity_instance thread function_6af4d46b877d952e();
    level thread aries_vo::function_7a2e7db9891062df();
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "s_river_barge_weapon", "flag_aries_nightmare_intro_complete", 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "s_river_barge_equipment", "flag_aries_nightmare_intro_complete", 1 );
    activity_instance thread ob_story_mission_utils::function_e6799e9a19df2365( "s_river_barge_cache", %"hash_43f0ed9b2eb8b832", 2 );
    level.var_7dc76fe81b04e969 = [];
    activity_instance thread function_5acdb04dfc45a066( "shed", 0, "flag_river_barge_spawn_bots", "e_jungle_root_1" );
    activity_instance thread function_5acdb04dfc45a066( "island", 1, "flag_river_barge_spawn_bots", "e_jungle_root_1", "flg_jungle_root_1_dest" );
    activity_instance thread function_5acdb04dfc45a066( "church", 1, "flag_river_barge_spawn_church", "e_jungle_root_3", "flg_jungle_root_3_dest" );
    activity_instance thread function_5acdb04dfc45a066( "huts", 1, "flag_river_barge_spawn_huts", "e_jungle_root_2", "flg_jungle_root_2_dest" );
    
    if ( !utility::flag( "flag_barge_vines_cleared" ) )
    {
        level waittill( #"hash_e3bce47d150649c7" );
        level thread function_757fdcccf5e5971c( "flag_river_village_enemies_defeated" );
    }
    
    level utility::flag_wait_any( "flag_aries_river_barge_trigger_vtol_scene", "flag_barge_vines_cleared" );
    activity_instance thread function_d1d06238631d0a36();
    wait 15;
    level.var_7dc76fe81b04e969 = undefined;
    activity_instance thread function_a73d5d64609e750d( "enc_fishingvillage_barge", "flag_river_base_barge_opened", 1 );
    activity_instance thread function_a73d5d64609e750d( "enc_fishingvillage_barge_periphery", "flag_river_base_barge_opened", 0 );
    level utility::flag_set( "flag_river_village_finalwave_spawned" );
    struct = utility::getstruct( "s_jungle_barge_container_interact_ref", "targetname" );
    vol = getnoentvolumearray( "vol_river_barge_enemies_right", "targetname" );
    level waittill( #"hash_e3bce47d150649c7" );
    activity_instance thread function_757fdcccf5e5971c( "flag_river_village_finalwave_defeated" );
    level utility::flag_wait( "flag_river_base_barge_opened" );
    level utility::flag_set( "aries_river_base_complete" );
    
    if ( isdefined( level.var_7dc76fe81b04e969 ) )
    {
        level.var_7dc76fe81b04e969 = undefined;
    }
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 1
// Checksum 0x45f3ec47, Offset: 0x1076
// Size: 0x43
function function_bb2ea56c623df824( player )
{
    activity_instance = self;
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        player ob_story_mission_utils::function_2383fc8bfc3074d2();
        player ob_story_mission_utils::function_288fdad79fa2a11();
    }
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 0
// Checksum 0xd6248ca6, Offset: 0x10c1
// Size: 0x13
function function_50ca4c126e1c5eec()
{
    aries_util::function_619b5a0410cf1a0a( "e_river_trail_vtol", "delete" );
}

/#

    // Namespace mp_sat_ob_aries_activity_river_barge
    // Params 0
    // Checksum 0x742d09f2, Offset: 0x10dc
    // Size: 0x5, Type: dev
    function function_ceba7f16682e01fd()
    {
        
    }

#/

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 5
// Checksum 0x10b3a933, Offset: 0x10e9
// Size: 0xed
function function_5acdb04dfc45a066( str_location, var_bcba299ae8b244f = 0, str_trigger_flag, var_be8ba0881d6c60d7, var_c084b30efde2e6a5 )
{
    activity_instance = self;
    
    if ( isarray( save::mission_get_data().var_e38d71218638a518 ) && arraycontains( save::mission_get_data().var_e38d71218638a518, var_be8ba0881d6c60d7 ) )
    {
        return;
    }
    
    if ( isdefined( str_trigger_flag ) )
    {
        level utility::flag_wait( str_trigger_flag );
    }
    
    str_enc = "enc_fishingvillage_" + str_location;
    activity_instance thread function_bc3b45c03f4d961a( str_enc, str_location );
    
    if ( var_bcba299ae8b244f && isdefined( var_c084b30efde2e6a5 ) )
    {
        var_846e6d99745a127c = "enc_barge_" + str_location + "_reinforce";
        var_f6c65a642af1ec59 = "vol_river_fishingvillage_enemies_" + str_location + "_fallback";
        activity_instance thread function_212432fec44e1f54( var_846e6d99745a127c, var_c084b30efde2e6a5, var_f6c65a642af1ec59 );
    }
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 2
// Checksum 0x638e863e, Offset: 0x11de
// Size: 0x82
function function_bc3b45c03f4d961a( var_99f71f87ff320085, str_location )
{
    activity_instance = self;
    var_b55fe580dfaa919d = activity_instance activity_ai_encounters::function_92b671064b0b1ce2( var_99f71f87ff320085, 1, 1, 1, 1 );
    ai_spawn_director::add_spawned_callback( var_b55fe580dfaa919d, &function_64883e1d4c7f600f, str_location );
    function_ef57f478f96b050c( var_b55fe580dfaa919d, 1 );
    function_64ac8c4e752f4dca( var_b55fe580dfaa919d, 0 );
    function_8f7c88b112137fdc( var_b55fe580dfaa919d, "flag_river_village_finalwave_spawned" );
    level utility::flag_wait( "flag_river_village_finalwave_defeated" );
    function_64ac8c4e752f4dca( var_b55fe580dfaa919d, 1 );
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 4
// Checksum 0x90c5677, Offset: 0x1268
// Size: 0xd2
function function_64883e1d4c7f600f( requestid, userdata, agent, data )
{
    level endon( #"story_mission_startpoint_called" );
    data = function_9b649316adcccbaa( requestid );
    
    if ( !isdefined( level.var_7dc76fe81b04e969 ) )
    {
        level.var_7dc76fe81b04e969 = [];
    }
    
    level.var_7dc76fe81b04e969 = arraycombineunique( level.var_7dc76fe81b04e969, [ agent ] );
    
    if ( level.var_7dc76fe81b04e969.size > 0 )
    {
        level notify( #"hash_e3bce47d150649c7" );
    }
    
    if ( userdata == "shed" )
    {
        return;
    }
    
    str_trig_targetname = "t_river_fishingvillage_" + userdata + "_fallback";
    str_vol_targetname = "vol_river_fishingvillage_enemies_" + userdata + "_fallback";
    agent thread function_8aa2a9de7882e924( str_trig_targetname, str_vol_targetname );
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 2
// Checksum 0x2fa709eb, Offset: 0x1342
// Size: 0xd4
function function_8aa2a9de7882e924( var_a338198753bd83fc, var_b795533ca0c81487 )
{
    self endon( #"death" );
    
    if ( isdefined( var_a338198753bd83fc ) && var_a338198753bd83fc != "no_trigger" )
    {
        [ trig_fallback ] = getnoentvolumearray( var_a338198753bd83fc, #targetname );
        trig_fallback waittill( #"trigger" );
    }
    
    a_vol_fallback = getnoentvolumearray( var_b795533ca0c81487, #targetname );
    var_82df36f723457186 = a_vol_fallback[ 0 ];
    
    if ( a_vol_fallback.size > 1 )
    {
        i_random_range = a_vol_fallback.size;
        var_6e05590a2e15edf9 = randomint( i_random_range );
        var_82df36f723457186 = a_vol_fallback[ var_6e05590a2e15edf9 ];
    }
    
    self setgoalpos( self.origin, 16 );
    self setgoalvolumeauto( var_82df36f723457186 );
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 4
// Checksum 0x313aa7c8, Offset: 0x141e
// Size: 0x33
function function_2bc9a9a1d3a942f6( requestid, userdata, agent, data )
{
    level notify( #"hash_e3bce47d150649c7" );
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 1
// Checksum 0x8daacc99, Offset: 0x1459
// Size: 0x60
function function_757fdcccf5e5971c( str_flag )
{
    activity_instance = self;
    activity_instance endon( #"aries_river_base_complete" );
    
    while ( level.var_7dc76fe81b04e969.size > 0 )
    {
        wait 0.5;
        level.var_7dc76fe81b04e969 = utility::array_removedead_or_dying( level.var_7dc76fe81b04e969 );
    }
    
    level utility::flag_set( str_flag );
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 3
// Checksum 0x2f8a2ef8, Offset: 0x14c1
// Size: 0xc4
function function_212432fec44e1f54( var_99f71f87ff320085, str_endon_flag, var_f6c65a642af1ec59 )
{
    level endon( str_endon_flag );
    
    while ( !isdefined( level.var_e769d589cbe6b0a7 ) || level.var_e769d589cbe6b0a7 < 2 )
    {
        wait 0.5;
    }
    
    activity_instance = self;
    var_b55fe580dfaa919d = activity_instance activity_ai_encounters::function_92b671064b0b1ce2( var_99f71f87ff320085, 1, 1, 1, 1 );
    ai_spawn_director::add_spawned_callback( var_b55fe580dfaa919d, &function_8f8130415c33b20a, str_endon_flag );
    var_32c65b4b8c1e988c = [ "no_trigger", var_f6c65a642af1ec59 ];
    ai_spawn_director::add_spawned_callback( var_b55fe580dfaa919d, &function_a436e48a2b33c6de, var_32c65b4b8c1e988c );
    function_ef57f478f96b050c( var_b55fe580dfaa919d, 1 );
    activity_instance thread function_8f7c88b112137fdc( var_b55fe580dfaa919d, "flag_river_village_finalwave_spawned" );
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 2
// Checksum 0xb4047530, Offset: 0x158d
// Size: 0xee
function function_8f7c88b112137fdc( requestid, str_flag )
{
    level utility::flag_wait( str_flag );
    data = function_9b649316adcccbaa( requestid );
    var_8844b11b777ba902 = 40;
    
    foreach ( enemy in data.ai )
    {
        if ( var_8844b11b777ba902 > 0 )
        {
            vfx_cradle_burst = loadfxasset( "vfx_sat_wc_ai_cradle_soldier_death_01" );
            playfx( vfx_cradle_burst, enemy.origin );
            var_8844b11b777ba902--;
        }
    }
    
    wait 0.1;
    ai_spawn_director::cancel_spawn_request( requestid, 0, 1 );
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 4
// Checksum 0x56742b60, Offset: 0x1683
// Size: 0x6e
function function_8f8130415c33b20a( requestid, userdata, agent, data )
{
    level endon( #"story_mission_startpoint_called" );
    data = function_9b649316adcccbaa( requestid );
    
    if ( !isdefined( level.var_7dc76fe81b04e969 ) )
    {
        level.var_7dc76fe81b04e969 = [];
    }
    
    level.var_7dc76fe81b04e969 = arraycombineunique( level.var_7dc76fe81b04e969, [ agent ] );
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 4
// Checksum 0x4874966c, Offset: 0x16f9
// Size: 0x37
function function_a436e48a2b33c6de( requestid, userdata, agent, data )
{
    agent thread function_8aa2a9de7882e924( userdata[ 0 ], userdata[ 1 ] );
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 3
// Checksum 0x918d0fd, Offset: 0x1738
// Size: 0xab
function function_a73d5d64609e750d( var_99f71f87ff320085, str_endon_flag, var_1183374a3443d528 = 0 )
{
    level endon( str_endon_flag );
    activity_instance = self;
    var_b55fe580dfaa919d = activity_instance activity_ai_encounters::function_92b671064b0b1ce2( var_99f71f87ff320085, 1, 1, 1, 1 );
    function_64ac8c4e752f4dca( var_b55fe580dfaa919d, 0 );
    
    if ( var_1183374a3443d528 )
    {
        ai_spawn_director::add_spawned_callback( var_b55fe580dfaa919d, &function_6e3c24abe4c5ae45, str_endon_flag );
        ai_spawn_director::function_5a08798970350207( var_b55fe580dfaa919d, &function_2bc9a9a1d3a942f6 );
        function_ef57f478f96b050c( var_b55fe580dfaa919d, 1 );
    }
    
    function_8f7c88b112137fdc( var_b55fe580dfaa919d, "flag_river_village_finalwave_defeated" );
    level utility::flag_wait( "flag_river_village_finalwave_defeated" );
    function_64ac8c4e752f4dca( var_b55fe580dfaa919d, 1 );
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 4
// Checksum 0xa071adcc, Offset: 0x17eb
// Size: 0xef
function function_6e3c24abe4c5ae45( requestid, userdata, agent, data )
{
    level endon( #"story_mission_startpoint_called" );
    
    if ( !isdefined( level.var_7dc76fe81b04e969 ) )
    {
        level.var_7dc76fe81b04e969 = [];
    }
    
    level.var_7dc76fe81b04e969 = arraycombineunique( level.var_7dc76fe81b04e969, [ agent ] );
    
    if ( agent.classname == "actor_sat_dawg_sm" )
    {
        agent thread aries_util::function_5c470cf8fafe39f5( "flag_player_on_barge_touching", 10 );
        agent dawg_turret::dawg_turret_set_owner( agent );
        thread function_431ccae35f2cce6( agent );
        [ var_9340db67a0e6a733 ] = getnoentvolumearray( "vol_river_barge_enemies_barge", #targetname );
        agent setgoalpos( agent.origin );
        agent setgoalvolumeauto( var_9340db67a0e6a733 );
    }
    
    level utility::flag_set( "flag_barge_final_dawg_spawned" );
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 1
// Checksum 0x9d98075, Offset: 0x18e2
// Size: 0x36
function function_431ccae35f2cce6( dawg )
{
    while ( !isdefined( dawg ) )
    {
        waitframe();
    }
    
    while ( isalive( dawg ) )
    {
        wait 0.1;
    }
    
    level utility::flag_set( "flag_river_barge_dawg_killed" );
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 0
// Checksum 0xe6166a16, Offset: 0x1920
// Size: 0x36
function function_d1d06238631d0a36()
{
    activity_instance = self;
    activity_instance thread ob_story_mission_utils::function_273dfd9583646854( "river_barge_vtol_1", undefined, 0, "flag_aries_river_barge_trigger_vtol_scene", 100, 300, 0, undefined, undefined, 1, 1, 384, undefined, 1 );
}

/#

    // Namespace mp_sat_ob_aries_activity_river_barge
    // Params 0
    // Checksum 0xb69d708f, Offset: 0x195e
    // Size: 0x5, Type: dev
    function function_7cd81705b5b3efb7()
    {
        
    }

#/

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 0
// Checksum 0xfb2b2f7d, Offset: 0x196b
// Size: 0x3d
function function_6af4d46b877d952e()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    var_8aa4e2649f733ea = 1024;
    waitframe();
    activity_instance thread function_5c4e606f88f872f5( var_8aa4e2649f733ea );
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 1
// Checksum 0xfaeae890, Offset: 0x19b0
// Size: 0xe8
function function_5c4e606f88f872f5( var_8aa4e2649f733ea )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    waitframe();
    activity_instance thread ob_story_mission_utils::objective_text_show( "ob_aries_investigate_the_barge_b_obj" );
    level utility::flag_wait_or_timeout( "flag_cargo_inspect_intro", 60 );
    ob_story_mission_utils::objective_text_clear();
    
    foreach ( player in activity_instance.playerparticipants )
    {
        player notify( #"flag_cargo_inspect_intro" );
        player notify( #"hide_objective_waypoint" );
    }
    
    activity_instance thread function_a20ad379d10ef2ad( var_8aa4e2649f733ea );
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 1
// Checksum 0x8f6ded0a, Offset: 0x1aa0
// Size: 0x1bd
function function_a20ad379d10ef2ad( var_8aa4e2649f733ea )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    level endon( #"hash_1d7c60a791f839cf" );
    activity_instance thread ob_story_mission_utils::objective_text_show( "ob_aries_destroy_flowers_defeat_enemies" );
    level utility::flag_set( "flag_village_weakpoint_objective" );
    var_350081e54157f2d8 = [];
    
    for ( i = 1; i <= 3 ; i++ )
    {
        var_ab5fb5147adb273d = "wp_s_weakpoint_village_" + i;
        flag_destroy = "flg_jungle_root_" + i + "_dest";
        
        if ( !utility::flag( flag_destroy ) )
        {
            waypoint_data = [ var_ab5fb5147adb273d, flag_destroy, 0 ];
            var_350081e54157f2d8[ var_350081e54157f2d8.size ] = waypoint_data;
        }
    }
    
    level.var_25731c1d2290b64d = [];
    activity_instance thread aries_util::function_ef6698d52dee64dd( var_350081e54157f2d8, var_8aa4e2649f733ea );
    level utility::flag_wait( "flag_barge_vines_cleared" );
    ob_story_mission_utils::objective_text_clear();
    activity_instance thread ob_story_mission_utils::objective_text_show( "ob_aries_secure_the_barge_b_obj" );
    s_obj_wp = utility::getstruct( "struct_secure_barge_waypoint", "targetname" );
    obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( s_obj_wp.origin - ( 7, 0, 40 ) );
    level utility::flag_wait( "flag_river_village_finalwave_defeated" );
    ob_story_mission_utils::objective_text_clear();
    ob_story_mission_utils::objective_marker_clear( obj_id );
    activity_instance thread ob_story_mission_utils::objective_text_show( "ob_aries_open_the_cargo_container_b_obj" );
    var_c9d2653474c654e9 = utility::getstruct( "s_waypoint_container_interact_objective", "targetname" );
    obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( var_c9d2653474c654e9.origin );
    
    if ( isdefined( level.var_25731c1d2290b64d ) )
    {
        level.var_25731c1d2290b64d = undefined;
    }
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 5
// Checksum 0xbcffa3e1, Offset: 0x1c65
// Size: 0x197
function weakpoint_destroyed_rumble( flag_weakpoint_destroyed, scale = 0.3, duration = 3.5, rumble = "artillery_rumble_light", radius = 1024 )
{
    activity_instance = self;
    
    if ( isdefined( flag_weakpoint_destroyed ) )
    {
        switch ( flag_weakpoint_destroyed )
        {
            case #"hash_74646bd75020892":
                str_waypoint_targetname = "wp_s_weakpoint_village_1";
                break;
            case #"hash_f484e1e1f6f1a32d":
                str_waypoint_targetname = "wp_s_weakpoint_village_2";
                break;
            default:
                str_waypoint_targetname = "wp_s_weakpoint_village_3";
                break;
        }
        
        var_f5594f9951890a3d = utility::getstruct( str_waypoint_targetname, "targetname" );
        nearbyplayers = utility::playersincylinder( var_f5594f9951890a3d.origin, radius );
    }
    else
    {
        nearbyplayers = level.players;
    }
    
    foreach ( player in nearbyplayers )
    {
        player earthquakeforplayer( scale, duration, player.origin, radius );
        player playrumbleonpositionforclient( rumble, player.origin );
    }
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 0
// Checksum 0x606a3019, Offset: 0x1e04
// Size: 0xdf
function function_4a56e51534d1d86a()
{
    activity_instance = self;
    
    if ( !utility::flag( "flag_cargo_inspect_intro" ) && !utility::flag( "FLAG_BARGE_VO_FOLLOW_VINES" ) )
    {
        obj_s = utility::getstruct( "wp_jungle_container_objective", "targetname" );
        
        foreach ( player in activity_instance.playerparticipants )
        {
            activity_instance thread aries_util::function_e6895f5efd1feb56( player, obj_s.origin, undefined, "sat_ob_objectivemarker_storymissionmain", player, "flag_cargo_inspect_intro", 60, 1600 );
        }
    }
}

/#

    // Namespace mp_sat_ob_aries_activity_river_barge
    // Params 0
    // Checksum 0x933bd846, Offset: 0x1eeb
    // Size: 0x5, Type: dev
    function function_aff7258558e2e2df()
    {
        
    }

#/

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 0
// Checksum 0x347fbb07, Offset: 0x1ef8
// Size: 0x21f
function function_dad0286078036091()
{
    activity_instance = self;
    level._effect[ "vine_death" ] = loadfxasset( "vfx_sat_mp_ob_aries_ivy_death_lrg_01" );
    level._effect[ "barge_vine_door" ] = loadfxasset( "vfx_sat_mp_ob_aries_scr_vines_wall_destruction_01" );
    level._effect[ "barge_vine_claw" ] = loadfxasset( "vfx_sat_mp_ob_aries_scr_root_hands_death_01" );
    level.var_e769d589cbe6b0a7 = 0;
    level thread function_7f52bfe17939d9aa();
    level thread function_c8bdaddafb83a0a9();
    
    for ( i = 1; i <= 3 ; i++ )
    {
        activity_instance thread function_e69329df63c2cf22( i, "e_jungle_root_" + i, "flower_killed_" + i, "flg_jungle_root_" + i + "_dest", "weakpoint_vine_" + i, "b_weakpoint_clip_" + i );
    }
    
    while ( level.var_e769d589cbe6b0a7 < 3 )
    {
        wait 0.1;
    }
    
    aries_util::function_619b5a0410cf1a0a( "e_jungle_barge_door_open", "hide" );
    level utility::flag_set( "flag_barge_vines_cleared" );
    aries_util::function_619b5a0410cf1a0a( "e_jungle_barge_root_blocker", "delete" );
    activity_instance utility::delaythread( 3, &weakpoint_destroyed_rumble, undefined, 0.25, 3, "artillery_rumble", 512 );
    level utility::flag_wait( "flag_river_village_finalwave_defeated" );
    var_cc9dbb3fbaaec44e = utility::getstruct( "s_jungle_barge_container_interact_ref" );
    var_8713485142ad4620 = spawn( "script_origin", var_cc9dbb3fbaaec44e.origin + ( 0, 0, 0 ) );
    interact = interaction::register_interact( var_8713485142ad4620, 64, &aries_util::function_1fba812dff471090, &"sat_ob_story_missions_aries/interact_docks_container", undefined, undefined, undefined, "HINT_BUTTON" );
    interact setuseholdduration( "duration_medium" );
    interact waittill( #"trigger", player );
    interact delete();
    level.teleport_initiator = player;
    level utility::flag_set( "flag_river_base_barge_opened" );
    
    if ( isdefined( var_8713485142ad4620 ) )
    {
        var_8713485142ad4620 delete();
    }
    
    if ( isdefined( level.a_weakpoints ) )
    {
        level.a_weakpoints = undefined;
    }
    
    level utility::flag_wait( "aries_river_base_complete" );
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 6
// Checksum 0x76d114cf, Offset: 0x211f
// Size: 0x283
function function_e69329df63c2cf22( index, var_be8ba0881d6c60d7, var_c98411469e07c9a0, var_517c7311488c9fed, var_3c609fa4ac42d88a, var_1e6949f1b96db47 )
{
    activity_instance = self;
    utility::flag_wait( "scriptables_ready" );
    
    if ( isarray( save::mission_get_data().var_e38d71218638a518 ) && arraycontains( save::mission_get_data().var_e38d71218638a518, var_be8ba0881d6c60d7 ) )
    {
        activity_instance function_2dec89168f4c5e6d( index, var_be8ba0881d6c60d7, var_c98411469e07c9a0, var_517c7311488c9fed, var_3c609fa4ac42d88a, var_1e6949f1b96db47 );
    }
    else
    {
        vine = getscriptablearray( var_3c609fa4ac42d88a, #script_noteworthy )[ 0 ];
        e_jungle_root = weak_point::cluster_setup( var_be8ba0881d6c60d7, "closed" );
        level thread function_604df862a935dd27( index );
        wait 1;
        e_jungle_root weak_point::cluster_set_state( "opening" );
        e_jungle_root waittill( #"weak_point_destroyed" );
        save::mission_get_data().var_e38d71218638a518[ save::mission_get_data().var_e38d71218638a518.size ] = var_be8ba0881d6c60d7;
        level utility::flag_set( var_c98411469e07c9a0 );
        
        if ( isdefined( var_1e6949f1b96db47 ) )
        {
            var_a40fdc6a10f0b69 = getent( var_1e6949f1b96db47, #targetname );
            
            if ( isdefined( var_a40fdc6a10f0b69 ) )
            {
                var_a40fdc6a10f0b69 delete();
            }
        }
        
        activity_instance thread function_f5f586d5e8ab4fff( var_be8ba0881d6c60d7 );
        activity_instance utility::delaythread( 0.5, &weakpoint_destroyed_rumble, var_517c7311488c9fed );
        activity_instance thread weakpoint_clear_objective( var_517c7311488c9fed );
        level thread aries_audio::function_6e2c9dd3c2a93378( var_be8ba0881d6c60d7 );
        
        if ( var_be8ba0881d6c60d7 == "e_jungle_root_1" )
        {
            utility::exploder( "expl_vfx_vine_slide_01" );
        }
        else if ( var_be8ba0881d6c60d7 == "e_jungle_root_2" )
        {
            utility::exploder( "expl_vfx_vine_slide_02" );
        }
        else if ( var_be8ba0881d6c60d7 == "e_jungle_root_3" )
        {
            utility::exploder( "expl_vfx_vine_slide_03" );
        }
        
        level utility::flag_set( var_517c7311488c9fed );
        vine setscriptablepartstate( "base", "dead" );
        i = 100;
        
        while ( i > 0 )
        {
            joint_name = vine function_cb497b712374573a( i );
            
            if ( isdefined( joint_name ) )
            {
                playfxontag( level._effect[ "vine_death" ], vine, joint_name );
                wait 0.08;
            }
            
            i -= 2;
        }
        
        i = 1;
        
        while ( i < 50 )
        {
            joint_name = vine function_cb497b712374573a( i );
            
            if ( isdefined( joint_name ) )
            {
                playfxontag( level._effect[ "vine_death" ], vine, joint_name );
                wait 0.08;
            }
            
            i += 2;
        }
    }
    
    level.var_e769d589cbe6b0a7++;
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 6, eflags: 0x4
// Checksum 0x93e8777f, Offset: 0x23aa
// Size: 0x83
function private function_2dec89168f4c5e6d( index, var_be8ba0881d6c60d7, var_c98411469e07c9a0, var_517c7311488c9fed, var_3c609fa4ac42d88a, var_1e6949f1b96db47 )
{
    activity_instance = self;
    vine = getscriptablearray( var_3c609fa4ac42d88a, #script_noteworthy )[ 0 ];
    activity_instance thread function_682f84163e6b3bb7( var_be8ba0881d6c60d7, var_c98411469e07c9a0, var_1e6949f1b96db47 );
    activity_instance thread weakpoint_clear_objective( var_517c7311488c9fed );
    activity_instance thread function_2c0c2f0f672423bf( index, vine );
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 3, eflags: 0x4
// Checksum 0x957d972e, Offset: 0x2435
// Size: 0x6d
function private function_682f84163e6b3bb7( var_be8ba0881d6c60d7, var_c98411469e07c9a0, var_1e6949f1b96db47 )
{
    e_jungle_root = weak_point::cluster_setup( var_be8ba0881d6c60d7, "dead" );
    level utility::flag_set( var_c98411469e07c9a0 );
    
    if ( isdefined( var_1e6949f1b96db47 ) )
    {
        var_a40fdc6a10f0b69 = getent( var_1e6949f1b96db47, #targetname );
        
        if ( isdefined( var_a40fdc6a10f0b69 ) )
        {
            var_a40fdc6a10f0b69 delete();
        }
    }
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 2, eflags: 0x4
// Checksum 0x2b9c127c, Offset: 0x24aa
// Size: 0x155
function private function_2c0c2f0f672423bf( index, vine )
{
    vine setscriptablepartstate( "base", "dead" );
    vine hide();
    var_4447097a75e6472c = getent( "e_jungle_root_collision_" + index, #targetname );
    vine_claws = getscriptablearray( "vine_claw_" + index, #script_noteworthy );
    a_e_chain = [];
    a_e_chain[ a_e_chain.size ] = var_4447097a75e6472c;
    
    while ( true )
    {
        if ( isdefined( var_4447097a75e6472c.target ) )
        {
            var_4447097a75e6472c = getent( var_4447097a75e6472c.target, "targetname" );
            a_e_chain[ a_e_chain.size ] = var_4447097a75e6472c;
        }
        else
        {
            break;
        }
        
        waitframe();
    }
    
    for ( i = 0; i < a_e_chain.size ; i++ )
    {
        a_e_chain[ i ] delete();
        waitframe();
    }
    
    foreach ( var_514041e713ec83b5 in vine_claws )
    {
        var_514041e713ec83b5 setscriptablepartstate( "base", "dead" );
    }
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 1
// Checksum 0x7d829013, Offset: 0x2607
// Size: 0x190
function weakpoint_clear_objective( flag_weakpoint_destroyed )
{
    activity_instance = self;
    utility::flag_set( flag_weakpoint_destroyed );
    
    if ( isdefined( flag_weakpoint_destroyed ) )
    {
        str_waypoint_targetname = "wp_s_weakpoint_village_3";
        
        switch ( flag_weakpoint_destroyed )
        {
            case #"hash_74646bd75020892":
                str_waypoint_targetname = "wp_s_weakpoint_village_1";
                break;
            case #"hash_f484e1e1f6f1a32d":
                str_waypoint_targetname = "wp_s_weakpoint_village_2";
                break;
        }
        
        var_f5594f9951890a3d = utility::getstruct( str_waypoint_targetname, "targetname" );
        
        foreach ( obj_id in level.var_25731c1d2290b64d )
        {
            if ( obj_id[ 1 ] == var_f5594f9951890a3d.origin )
            {
                if ( getdvarint( @"hash_4bc188e324733a72", 0 ) )
                {
                    if ( arraycontains( activity_instance.a_obj_circle, obj_id[ 0 ] ) )
                    {
                        activity_instance ob_story_mission_utils::function_352aa3aab98a0618( obj_id[ 0 ] );
                    }
                }
                else if ( arraycontains( activity_instance.a_obj_id, obj_id[ 0 ] ) )
                {
                    activity_instance ob_story_mission_utils::objective_marker_clear( obj_id[ 0 ] );
                }
                
                break;
            }
        }
        
        if ( !utility::flag( "flag_aries_river_barge_first_flower_destroyed" ) )
        {
            utility::flag_set( "flag_aries_river_barge_first_flower_destroyed" );
            activity_instance ob_story_mission_utils::objective_text_clear();
            activity_instance thread ob_story_mission_utils::objective_text_show( "ob_aries_final_weakpoint_arena" );
        }
    }
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 0
// Checksum 0xe34a7cc8, Offset: 0x279f
// Size: 0x26
function function_c8bdaddafb83a0a9()
{
    level utility::flag_wait_all( "flower_killed_1", "flower_killed_2", "flower_killed_3" );
    level utility::flag_set( "flag_aries_river_barge_trigger_vtol_scene" );
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 0
// Checksum 0xd04c65ab, Offset: 0x27cd
// Size: 0xb1
function function_7f52bfe17939d9aa()
{
    utility::flag_wait( "scriptables_ready" );
    vines = getscriptablearray( "barge_vine", #script_noteworthy );
    level utility::flag_wait( "flag_barge_vines_cleared" );
    
    foreach ( vine in vines )
    {
        vine setscriptablepartstate( "base", "dead" );
    }
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 1
// Checksum 0x2a0e0fef, Offset: 0x2886
// Size: 0xd7
function function_604df862a935dd27( index )
{
    var_4447097a75e6472c = getent( "e_jungle_root_collision_" + index, #targetname );
    a_e_chain = [];
    a_e_chain[ a_e_chain.size ] = var_4447097a75e6472c;
    
    while ( true )
    {
        if ( isdefined( var_4447097a75e6472c.target ) )
        {
            var_4447097a75e6472c = getent( var_4447097a75e6472c.target, "targetname" );
            a_e_chain[ a_e_chain.size ] = var_4447097a75e6472c;
        }
        else
        {
            break;
        }
        
        wait 0.1;
    }
    
    switch ( index )
    {
        case 1:
            level.var_b6decb4f5e255b2 = a_e_chain;
            break;
        case 2:
            level.var_b6debb4f5e2537f = a_e_chain;
            break;
        case 3:
            level.var_b6deab4f5e2514c = a_e_chain;
            break;
    }
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 1
// Checksum 0xb34fa881, Offset: 0x2965
// Size: 0x98
function function_f5f586d5e8ab4fff( var_be8ba0881d6c60d7 )
{
    if ( isdefined( var_be8ba0881d6c60d7 ) )
    {
        switch ( var_be8ba0881d6c60d7 )
        {
            case #"hash_4b092a5f936cb351":
                a_vines = level.var_b6decb4f5e255b2;
                level thread function_9405efe3e2004def( 1, a_vines );
                break;
            case #"hash_4b09275f936cae98":
                a_vines = level.var_b6debb4f5e2537f;
                level thread function_9405efe3e2004def( 2, a_vines );
                break;
            case #"hash_4b09285f936cb02b":
                a_vines = level.var_b6deab4f5e2514c;
                level thread function_9405efe3e2004def( 3, a_vines );
                break;
        }
    }
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 2
// Checksum 0xb9958f80, Offset: 0x2a05
// Size: 0x180
function function_9405efe3e2004def( index, a_vines )
{
    if ( !isdefined( a_vines ) || !isdefined( a_vines.size ) )
    {
        return;
    }
    
    vine_claws = getscriptablearray( "vine_claw_" + index, #script_noteworthy );
    var_1048a910ba9500aa = a_vines.size;
    animation_frames = 360;
    var_e8785572b25d910a = animation_frames / var_1048a910ba9500aa * 0.5;
    var_b52e37e0825037ca = var_e8785572b25d910a;
    deleted_claw = 0;
    var_8d7375288266af39 = 0;
    
    for ( x = 0; x < animation_frames ; x++ )
    {
        var_3fbc9f2f662c6e81 = ( 1 - cos( x * 0.25 ) ) * animation_frames;
        
        if ( var_3fbc9f2f662c6e81 > var_b52e37e0825037ca )
        {
            if ( isdefined( a_vines[ var_8d7375288266af39 ] ) )
            {
                a_vines[ var_8d7375288266af39 ] delete();
                var_8d7375288266af39++;
                var_b52e37e0825037ca = var_e8785572b25d910a * ( var_8d7375288266af39 + 1 );
            }
        }
        
        wait 0.0166;
        
        if ( x > 234 && !deleted_claw )
        {
            foreach ( var_514041e713ec83b5 in vine_claws )
            {
                var_514041e713ec83b5 setscriptablepartstate( "base", "dead" );
            }
            
            deleted_claw = 1;
        }
    }
}

// Namespace mp_sat_ob_aries_activity_river_barge
// Params 0, eflags: 0x4
// Checksum 0x850eee65, Offset: 0x2b8d
// Size: 0x120
function private function_4d46c3009c76f0c1()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    utility::flag_wait( "player_catchup_river_barge_complete" );
    
    foreach ( player in activity_instance.playerparticipants )
    {
        foreach ( ent_flag in level.var_5fe1c01595a2e32b )
        {
            player utility::ent_flag_set( ent_flag );
        }
    }
    
    aries_util::function_449d53209415d945();
}

