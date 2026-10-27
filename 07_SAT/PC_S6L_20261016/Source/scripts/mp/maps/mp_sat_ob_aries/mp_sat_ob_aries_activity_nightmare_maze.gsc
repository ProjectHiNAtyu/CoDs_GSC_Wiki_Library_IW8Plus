// scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_activity_nightmare_maze.gsc  (hash_7a287fbaf21d4f15.gscc) (size: 26201 Bytes / 0x6659 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3c37ad3b (1010281787)
// size ...... 26201 (0x6659)
// includes .. 15  (offset: 0x5a59)
// strings ... 184 (offset: 0x5ad1)
// dev strs .. 1   (offset: 0x664d)
// exports ... 54  (offset: 0x3f41)
// cseg ...... 0x161a + 0x2927 (0x3f41)
// imports ... 139 (offset: 0x47b1)
// animtree1 . 0   (offset: 0x6659)
// animtree2 . 0   (offset: 0x6659)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_activity_nightmare_corridor;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_audio;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_scenes;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_util;
#using scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_vo;
#using scripts\mp\ob\systems\ob_container_spawn_closet;

#namespace namespace_c8335fe106fcaba1;

// Namespace namespace_c8335fe106fcaba1
// Params 0, eflags: 0x5
// Checksum 0x191bac6b, Offset: 0x1638
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_95521fe86627d178", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_c8335fe106fcaba1
// Params 0, eflags: 0x4
// Checksum 0x1191b3ed, Offset: 0x1661
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_ARIES_NIGHTMARE_MAZE";
    activity_common::registeractivitytype( "OB_ARIES_NIGHTMARE_MAZE", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_NIGHTMARE_MAZE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_NIGHTMARE_MAZE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_ARIES_NIGHTMARE_MAZE", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_ARIES_NIGHTMARE_MAZE" );
}

// Namespace namespace_c8335fe106fcaba1
// Params 0
// Checksum 0xdc6cd1c5, Offset: 0x16d8
// Size: 0x59
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance nightmare_maze_start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_c8335fe106fcaba1
// Params 0
// Checksum 0xb464dd85, Offset: 0x1739
// Size: 0x39
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance nightmare_maze_main();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_c8335fe106fcaba1
// Params 0
// Checksum 0x5ff23f00, Offset: 0x177a
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_c8335fe106fcaba1
// Params 1
// Checksum 0x6553bd28, Offset: 0x179e
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread nightmare_maze_player_setup( player );
    }
}

// Namespace namespace_c8335fe106fcaba1
// Params 0
// Checksum 0xd5f6a73b, Offset: 0x185a
// Size: 0x4d
function nightmare_maze_start()
{
    activity_instance = self;
    ob_container_spawn_closet::function_e6f9ca6684759ebe( "p2_spawn_closet", "p2_fake_floor", "ob_sat_items_enemy_zombie_aries_spawn_closet" );
    level thread aries_util::bloodpool_player_setup();
    activity_instance thread function_6b0bf2c067a8ec19();
    level thread namespace_a7ec45bcd7d54d98::function_ffb71d4b2d613b41( "flag_aries_nightmare_maze_catchup_complete", 1 );
    level thread function_98f6f620d6add9a7();
}

// Namespace namespace_c8335fe106fcaba1
// Params 0
// Checksum 0x83fe6d6f, Offset: 0x18af
// Size: 0x539
function nightmare_maze_main()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    activity_instance thread aries_util::annihilate_fx_init();
    level thread aries_util::bloodpool_player_setup();
    level thread aries_util::function_aa46fed9c0298214();
    level.blockers_triggered = 0;
    level thread function_2b49858e55179ad9();
    
    if ( level.is_squad_size_small )
    {
        level.var_5e0f2305516ac075 = 1;
    }
    else
    {
        level.var_5e0f2305516ac075 = 2;
    }
    
    activity_instance thread function_eafddaaa69540e10();
    activity_instance thread function_f3efa8322d969135();
    activity_instance thread function_cd2aad025da7476();
    activity_instance thread function_76c1da0fecd56d1( "sbm_tunnel_3_nav_cutter", "flag_aries_nightmare_maze_tomb_left_entered" );
    activity_instance thread function_76c1da0fecd56d1( "sbm_tunnel_6_nav_cutter", "flag_aries_nightmare_maze_tomb_right_entered" );
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "str_maze_weapon", "flag_aries_nightmare_maze_catchup_complete", 1 );
    activity_instance thread ob_story_mission_utils::function_e6799e9a19df2365( "str_maze_weapon_cache_a", %"hash_43f0ed9b2eb8b832", 2 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "str_maze_lethal", "flag_aries_nightmare_maze_catchup_complete", 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "str_maze_tactical", "flag_aries_nightmare_maze_catchup_complete", 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "str_crypt_right_tactical", "flag_aries_nightmare_maze_catchup_complete", 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "str_crypt_right_lethal", "flag_aries_nightmare_maze_catchup_complete", 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "str_crypt_left_tactical", "flag_aries_nightmare_maze_catchup_complete", 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "str_crypt_left_lethal", "flag_aries_nightmare_maze_catchup_complete", 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "str_crypt_right_weapon", "flag_aries_nightmare_maze_catchup_complete", 1, undefined, undefined, undefined, 3 );
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "str_crypt_left_weapon", "flag_aries_nightmare_maze_catchup_complete", 1, undefined, undefined, undefined, 3 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "str_equipment_maze_selfrez", "flag_aries_nightmare_maze_catchup_complete", 1, undefined, undefined, 1, 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "str_maze_transition_lethal", "flag_aries_nightmare_maze_catchup_complete", 1 );
    activity_instance thread function_6b0bf2c067a8ec19();
    activity_instance thread aries_util::function_d092342c9ead418d( "e_nmr_maze_weakpoint_1", "flag_aries_nightmare_maze_tomb_right_entered", "weak_point_flower_vine_01", "vines_1", "vine_door_1", "flag_weakpoint_maze_01_complete" );
    activity_instance thread function_ca6c0d0645ad74c9( "flag_weakpoint_maze_01_complete", "e_nmr_maze_weakpoint_1_door" );
    activity_instance thread aries_util::function_d092342c9ead418d( "e_nmr_maze_weakpoint_2", "flag_aries_nightmare_maze_tomb_left_entered", "weak_point_flower_vine_02", "vines_2", "vine_door_2", "flag_weakpoint_maze_02_complete" );
    activity_instance thread function_ca6c0d0645ad74c9( "flag_weakpoint_maze_02_complete", "e_nmr_maze_weakpoint_2_door" );
    activity_instance thread function_b3426ac06801eba7();
    level thread aries_audio::function_8c0738b67a9c7cf4();
    activity_instance thread function_41000370a6110d46();
    level thread aries_vo::function_3ecb014591099be8();
    activity_instance thread function_123a86d525bb2888( "vol_maze_tunnel_left_a", "trig_maze_tunnel_left_a", "flag_aries_nightmare_maze_tomb_left_entered", "flag_nm_maze_tunnel_1_triggered" );
    activity_instance thread function_123a86d525bb2888( "vol_maze_tunnel_left_b", "trig_maze_tunnel_left_b", "flag_aries_nightmare_maze_tomb_left_entered", "flag_nm_maze_tunnel_2_triggered" );
    activity_instance thread function_123a86d525bb2888( "vol_maze_tunnel_mid_a", "trig_maze_tunnel_mid_a", "flag_aries_nightmare_maze_tomb_left_entered", "flag_nm_maze_tunnel_3_triggered" );
    activity_instance thread function_123a86d525bb2888( "vol_maze_tunnel_mid_b", "trig_maze_tunnel_mid_b", "flag_aries_nightmare_maze_tomb_right_entered", "flag_nm_maze_tunnel_4_triggered" );
    activity_instance thread function_123a86d525bb2888( "vol_maze_tunnel_right_a", "trig_maze_tunnel_right_a", "flag_aries_nightmare_maze_tomb_right_entered", "flag_nm_maze_tunnel_5_triggered" );
    activity_instance thread function_123a86d525bb2888( "vol_maze_tunnel_right_b", "trig_maze_tunnel_right_b", "flag_aries_nightmare_maze_tomb_right_entered", "flag_nm_maze_tunnel_6_triggered" );
    activity_instance thread function_583adc115a9c3bd4();
    activity_instance thread function_5d256f5bebee7d4b();
    activity_instance thread tomb_progress_tracker();
    activity_instance thread function_8c54ccc8d6bd27a7();
    activity_instance thread aries_util::waterfall_handler( "vfx_maze_transition_waterfall", "trig_bp_vfx_damage_tower_lvl0_a2", "flag_weakpoint_maze_all_complete", "flag_aries_nightmare_crashsite_catchup_complete" );
    activity_instance thread aries_util::function_2aa782e2f16bd276( "scn_maze_crypt_zmb_caught" );
    activity_instance thread aries_util::function_2aa782e2f16bd276( "scn_maze_crypt_zmb_crushed" );
    var_10d4b2d079c425e5 = "vol_tower_barge_scene";
    var_fc9b6c8958151c5c = ai_spawn_director::lookup_spawn_request( var_10d4b2d079c425e5 );
    function_ef57f478f96b050c( var_fc9b6c8958151c5c, 1 );
    ai_spawn_director::add_callback( "OnSpawned", var_fc9b6c8958151c5c, &function_620d3ee2c6a39a5a );
    level thread function_6c00552e8f3750ea();
    level.var_8a09e86f6cea0eed = getent( "sbm_player_coll_transition", #targetname );
    level.var_8a09e86f6cea0eed connectpaths();
    level.var_8a09e86f6cea0eed notsolid();
    var_501bab5f902ac716 = getnoentvolumearray( "trig_maze_final_stretch", #targetname );
    var_501bab5f902ac716[ 0 ] waittill( #"trigger", player );
    activity_instance thread ob_story_mission_utils::function_e6799e9a19df2365( "str_tower_weapon_cache_a", %"hash_43f0ec9b2eb8b67f", 2 );
    activity_instance thread ob_story_mission_utils::function_e6799e9a19df2365( "str_tower_weapon_cache_b", %"hash_43f0ee9b2eb8b9e5", 2 );
    var_8a433f3735c6cb2c = getentarray( "sm_barge_spawnpoint", #targetname );
    var_301166e291628db3 = getent( "sm_barge_spawnpoint_roof", #targetname );
    
    foreach ( ent in var_8a433f3735c6cb2c )
    {
        ent hide();
    }
    
    var_301166e291628db3 hide();
    var_a7e856ed95484187 = getnoentvolumearray( "trig_maze_final_trasition", #targetname );
    var_a7e856ed95484187[ 0 ] waittill( #"trigger", player );
    utility::flag_set( "flag_aries_nightmare_maze_complete" );
}

// Namespace namespace_c8335fe106fcaba1
// Params 0
// Checksum 0x63fdb80, Offset: 0x1df0
// Size: 0xe3
function function_6b0bf2c067a8ec19()
{
    activity_instance = self;
    s_ability_case = utility::getstruct( "s_ability_case_maze", "targetname" );
    
    if ( isdefined( s_ability_case ) )
    {
        if ( !isdefined( s_ability_case.angles ) )
        {
            s_ability_case.angles = ( 0, 0, 0 );
        }
        
        var_29c7d047c0b75485 = { #delay:2, #endon_string:undefined, #var_a9496e34ebda5db:&"sat_ob/hint_crash_cart_gamepad", #var_b53628100ef29954:&"sat_ob/hint_crash_cart_kbm", #hint_ref_name:"hint_crash_cart", #equipment_ref:"super_survival_life_drain" };
        activity_instance thread ob_story_mission_utils::function_516cfe2bb1eed11f( s_ability_case.origin, "super_survival_life_drain", undefined, "default", s_ability_case.angles, undefined, var_29c7d047c0b75485 );
    }
}

// Namespace namespace_c8335fe106fcaba1
// Params 1
// Checksum 0x6ad2c34c, Offset: 0x1edb
// Size: 0x31
function function_de1e14b42d86e3b1( player )
{
    self makeunusable();
    utility::flag_set( "flg_nmr_woods_memory_1_starting" );
    namespace_d11629872d017c15::function_1479818cb43ea632();
    utility::flag_set( "flg_nmr_woods_memory_1_complete" );
}

// Namespace namespace_c8335fe106fcaba1
// Params 1
// Checksum 0x5fdc333, Offset: 0x1f14
// Size: 0x43
function nightmare_maze_player_setup( player )
{
    activity_instance = self;
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        player ob_story_mission_utils::function_2383fc8bfc3074d2();
        player ob_story_mission_utils::function_288fdad79fa2a11();
    }
}

// Namespace namespace_c8335fe106fcaba1
// Params 0
// Checksum 0x17544d79, Offset: 0x1f5f
// Size: 0x1f
function tomb_progress_tracker()
{
    utility::flag_wait_any( "flag_weakpoint_maze_01_complete", "flag_weakpoint_maze_02_complete" );
    utility::flag_set( "flag_weakpoint_maze_all_complete" );
}

/#

    // Namespace namespace_c8335fe106fcaba1
    // Params 0
    // Checksum 0x27f9c3c2, Offset: 0x1f86
    // Size: 0x5, Type: dev
    function function_f342b3fcd37f6bfc()
    {
        
    }

#/

// Namespace namespace_c8335fe106fcaba1
// Params 1
// Checksum 0x3e8cd089, Offset: 0x1f93
// Size: 0xa2
function function_bbef8e1239ac81a( var_8d34a7629cdeac14 )
{
    a_ents = [];
    
    foreach ( str_ent_name in var_8d34a7629cdeac14 )
    {
        container_ent = getent( str_ent_name, #targetname );
        a_ents[ a_ents.size ] = container_ent;
    }
    
    return a_ents;
}

// Namespace namespace_c8335fe106fcaba1
// Params 1
// Checksum 0x9d3c756b, Offset: 0x203e
// Size: 0x82
function function_daed65b8fa01f78a( a_sequence_ents )
{
    foreach ( ent in a_sequence_ents )
    {
        if ( isdefined( ent ) )
        {
            ent delete();
        }
    }
}

// Namespace namespace_c8335fe106fcaba1
// Params 0
// Checksum 0xa24da761, Offset: 0x20c8
// Size: 0x203
function function_b3426ac06801eba7()
{
    container_left_1 = getent( "sm_maze_reveal_p4", #targetname );
    container_left_2 = getent( "sm_maze_reveal_p5", #targetname );
    container_left_3 = getent( "sm_maze_reveal_p1", #targetname );
    container_down_left_1 = getent( "sm_maze_reveal_p6", #targetname );
    container_down_left_2 = getent( "sm_maze_reveal_p2", #targetname );
    container_down_left_3 = getent( "sm_maze_reveal_p3", #targetname );
    container_down_right_1 = getent( "sm_maze_reveal_p9", #targetname );
    container_down_right_2 = getent( "sm_maze_reveal_p10", #targetname );
    container_down_right_3 = getent( "sm_maze_reveal_p7", #targetname );
    container_right_1 = getent( "sm_maze_reveal_p8", #targetname );
    container_right_2 = getent( "sm_maze_reveal_p12", #targetname );
    var_adc082f2adf43dcb = [ container_left_1, container_left_2, container_left_3, container_down_left_1, container_down_left_2, container_down_left_3, container_down_right_1, container_down_right_2, container_down_right_3, container_right_1, container_right_2 ];
    animnode = utility::getstruct( "sat_cin_ari_nightmare_maze", "targetname" );
    animnode thread aries_util::function_46ea5163d8f3c881( "nmr_corridor_containers_rumble_01" );
    animnode scene::play( var_adc082f2adf43dcb, "transition" );
    var_8a09e86f6cea0eed = getent( "sbm_maze_reveal_collision", #targetname );
    var_8a09e86f6cea0eed delete();
    utility::flag_set( "flag_aries_nightmare_maze_corridor_complete" );
    utility::flag_wait( "flag_aries_nightmare_tower_complete" );
    function_daed65b8fa01f78a( var_adc082f2adf43dcb );
    var_adc082f2adf43dcb = undefined;
}

// Namespace namespace_c8335fe106fcaba1
// Params 0
// Checksum 0x48dda968, Offset: 0x22d3
// Size: 0x81
function function_db085d7682362d92()
{
    var_8d34a7629cdeac14 = [ "sbm_maze_wall_transition_c_l3", "sbm_maze_wall_transition_c_r1", "sbm_maze_wall_transition_c_l1", "sbm_maze_wall_transition_c_r2", "sbm_maze_wall_transition_c_r3", "sbm_maze_wall_transition_c_l2" ];
    a_containers_wall = function_bbef8e1239ac81a( var_8d34a7629cdeac14 );
    waitframe();
    aries_util::function_2ad4d6454b67c8a8( a_containers_wall, 0.5 );
    utility::flag_wait( "flag_aries_nightmare_tower_complete" );
    function_daed65b8fa01f78a( a_containers_wall );
    var_8d34a7629cdeac14 = undefined;
    a_containers_wall = undefined;
}

/#

    // Namespace namespace_c8335fe106fcaba1
    // Params 0
    // Checksum 0xd3051d74, Offset: 0x235c
    // Size: 0x5, Type: dev
    function function_39cd51e70ff41760()
    {
        
    }

#/

// Namespace namespace_c8335fe106fcaba1
// Params 2
// Checksum 0xdefd191c, Offset: 0x2369
// Size: 0x50
function function_33c5d646b9cd4113( target_count, var_cdb665c03b873a33 )
{
    current_ai_count = getaicount();
    
    while ( current_ai_count >= target_count )
    {
        current_ai_count = getaicount();
        wait 0.5;
        wait 0.5;
    }
    
    if ( isdefined( var_cdb665c03b873a33 ) )
    {
        utility::flag_set( var_cdb665c03b873a33 );
    }
}

// Namespace namespace_c8335fe106fcaba1
// Params 0
// Checksum 0x50fda4ed, Offset: 0x23c1
// Size: 0x48
function function_84b40b0c39f50af5()
{
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
    
    var_f873ec447c4ef099 = getent( "spawn_closet_maze_b_1", #targetname );
    waitframe();
    utility::flag_wait( "flag_aries_nightmare_tower_complete" );
    function_daed65b8fa01f78a( [ var_f873ec447c4ef099 ] );
}

// Namespace namespace_c8335fe106fcaba1
// Params 4
// Checksum 0xb92ed476, Offset: 0x2411
// Size: 0x90
function function_123a86d525bb2888( encounter, trig_encounter_start, flag_disable, flag_blocker_disable )
{
    level endon( flag_disable );
    level endon( flag_blocker_disable );
    level endon( #"flag_aries_nightmare_maze_catchup_complete" );
    a_trigger_enc = getnoentvolumearray( trig_encounter_start, #targetname );
    a_trigger_enc[ 0 ] waittill( #"trigger" );
    waitframe();
    var_b7cf517faab82e9c = activity_ai_encounters::function_92b671064b0b1ce2( encounter, 1, 1, 1, 1 );
    activity_ai_encounters::function_52d1342183200a8f( var_b7cf517faab82e9c, &function_a6a0c565b37c6275 );
}

// Namespace namespace_c8335fe106fcaba1
// Params 2
// Checksum 0x6f4a192d, Offset: 0x24a9
// Size: 0x60
function function_76c1da0fecd56d1( sbm_nav_cutter, var_51ddb6db28b5f0e7 )
{
    level endon( #"flag_aries_nightmare_tower_catchup_complete" );
    var_dd243999c083f148 = getent( sbm_nav_cutter, #targetname );
    
    if ( isdefined( var_dd243999c083f148 ) )
    {
        var_dd243999c083f148 disconnectpaths();
        utility::flag_wait( var_51ddb6db28b5f0e7 );
        var_dd243999c083f148 connectpaths();
        var_dd243999c083f148 delete();
    }
}

// Namespace namespace_c8335fe106fcaba1
// Params 0
// Checksum 0x8c3d7fb6, Offset: 0x2511
// Size: 0x3bf
function function_583adc115a9c3bd4()
{
    level endon( #"flag_aries_nightmare_maze_catchup_complete" );
    activity_instance = self;
    a_trigger_enc = getnoentvolumearray( "trig_enc_maze_tomb_right", #targetname );
    a_trigger_enc[ 0 ] waittill( #"trigger" );
    level utility::flag_set( "flag_aries_nightmare_maze_tomb_right_entered" );
    level thread function_791e838f77242652( "e_nmr_maze_weakpoint_1", "flag_weakpoint_maze_01_complete", undefined, a_trigger_enc[ 0 ] );
    var_f873ec447c4ef099 = getent( "spawn_closet_crypt_right_1", #targetname );
    var_f873e9447c4eea00 = getent( "spawn_closet_crypt_right_2", #targetname );
    var_f873ea447c4eec33 = getent( "spawn_closet_crypt_right_3", #targetname );
    var_f873ef447c4ef732 = getent( "spawn_closet_crypt_right_4", #targetname );
    pace_rand = randomfloatrange( 1, 3 );
    
    if ( level.playercount > 2 || !level.is_squad_size_small )
    {
        if ( utility::cointoss() )
        {
            var_f873ec447c4ef099 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_right_1", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 4, 20, undefined, undefined, 0 );
            wait pace_rand;
            var_f873ea447c4eec33 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_right_3", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 4, 20, undefined, undefined, 0 );
            thread function_33c5d646b9cd4113( 8, "flag_aries_nightmare_tomb_right_combat_a_count_hit" );
            utility::flag_wait_or_timeout( "flag_aries_nightmare_tomb_right_combat_a_count_hit", 8 );
            
            if ( utility::cointoss() )
            {
                var_f873e9447c4eea00 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_right_2", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 4, 20, undefined, undefined, 0 );
            }
            else
            {
                var_f873ef447c4ef732 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_right_4", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 4, 20, undefined, undefined, 0 );
            }
        }
        else
        {
            var_f873e9447c4eea00 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_right_2", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 4, 20, undefined, undefined, 0 );
            wait pace_rand;
            var_f873ef447c4ef732 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_right_4", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 4, 20, undefined, undefined, 0 );
            thread function_33c5d646b9cd4113( 8, "flag_aries_nightmare_tomb_right_combat_a_count_hit" );
            utility::flag_wait_or_timeout( "flag_aries_nightmare_tomb_right_combat_a_count_hit", 8 );
            
            if ( utility::cointoss() )
            {
                var_f873ec447c4ef099 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_right_1", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 4, 20, undefined, undefined, 0 );
            }
            else
            {
                var_f873ea447c4eec33 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_right_3", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 4, 20, undefined, undefined, 0 );
            }
        }
        
        return;
    }
    
    if ( utility::cointoss() )
    {
        var_f873ec447c4ef099 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_right_1", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 2, 20, undefined, undefined, 0 );
        wait pace_rand;
        var_f873ea447c4eec33 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_right_3", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 2, 20, undefined, undefined, 0 );
        thread function_33c5d646b9cd4113( 6, "flag_aries_nightmare_tomb_right_combat_a_count_hit" );
        utility::flag_wait_or_timeout( "flag_aries_nightmare_tomb_right_combat_a_count_hit", 8 );
        
        if ( utility::cointoss() )
        {
            var_f873e9447c4eea00 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_right_2", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 2, 20, undefined, undefined, 0 );
        }
        else
        {
            var_f873ef447c4ef732 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_right_4", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 2, 20, undefined, undefined, 0 );
        }
        
        return;
    }
    
    var_f873e9447c4eea00 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_right_2", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 2, 20, undefined, undefined, 0 );
    wait pace_rand;
    var_f873ef447c4ef732 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_right_4", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 2, 20, undefined, undefined, 0 );
    thread function_33c5d646b9cd4113( 6, "flag_aries_nightmare_tomb_right_combat_a_count_hit" );
    utility::flag_wait_or_timeout( "flag_aries_nightmare_tomb_right_combat_a_count_hit", 8 );
    
    if ( utility::cointoss() )
    {
        var_f873ec447c4ef099 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_right_1", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 2, 20, undefined, undefined, 0 );
        return;
    }
    
    var_f873ea447c4eec33 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_right_3", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 2, 20, undefined, undefined, 0 );
}

// Namespace namespace_c8335fe106fcaba1
// Params 0
// Checksum 0xef170fcc, Offset: 0x28d8
// Size: 0x3be
function function_5d256f5bebee7d4b()
{
    level endon( #"flag_aries_nightmare_maze_catchup_complete" );
    activity_instance = self;
    a_trigger_enc = getnoentvolumearray( "trig_enc_maze_tomb_left", #targetname );
    a_trigger_enc[ 0 ] waittill( #"trigger" );
    level utility::flag_set( "flag_aries_nightmare_maze_tomb_left_entered" );
    level thread function_791e838f77242652( "e_nmr_maze_weakpoint_2", "flag_weakpoint_maze_02_complete", undefined, a_trigger_enc[ 0 ] );
    var_f873ec447c4ef099 = getent( "spawn_closet_crypt_left_1", #targetname );
    var_f873e9447c4eea00 = getent( "spawn_closet_crypt_left_2", #targetname );
    var_f873ea447c4eec33 = getent( "spawn_closet_crypt_left_3", #targetname );
    var_f873ef447c4ef732 = getent( "spawn_closet_crypt_left_4", #targetname );
    pace_rand = randomfloatrange( 1, 3 );
    
    if ( level.playercount > 2 || !level.is_squad_size_small )
    {
        if ( utility::cointoss() )
        {
            var_f873ec447c4ef099 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_left_1", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 4, 20, undefined, undefined, 0 );
            wait pace_rand;
            var_f873ea447c4eec33 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_left_3", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 4, 20, undefined, undefined, 0 );
            thread function_33c5d646b9cd4113( 8, "flag_aries_nightmare_tomb_left_combat_a_count_hit" );
            utility::flag_wait_or_timeout( "flag_aries_nightmare_tomb_left_combat_a_count_hit", 8 );
            
            if ( utility::cointoss() )
            {
                var_f873e9447c4eea00 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_left_2", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 4, 20, undefined, undefined, 0 );
            }
            else
            {
                var_f873ef447c4ef732 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_left_4", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 4, 20, undefined, undefined, 0 );
            }
        }
        else
        {
            var_f873e9447c4eea00 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_left_2", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 4, 20, undefined, undefined, 0 );
            wait pace_rand;
            var_f873ef447c4ef732 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_left_4", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 4, 20, undefined, undefined, 0 );
            thread function_33c5d646b9cd4113( 8, "flag_aries_nightmare_tomb_left_combat_a_count_hit" );
            utility::flag_wait_or_timeout( "flag_aries_nightmare_tomb_left_combat_a_count_hit", 8 );
            
            if ( utility::cointoss() )
            {
                var_f873ec447c4ef099 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_left_1", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 4, 20, undefined, undefined, 0 );
            }
            else
            {
                var_f873ea447c4eec33 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_left_3", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 4, 20, undefined, undefined, 0 );
            }
        }
        
        return;
    }
    
    if ( utility::cointoss() )
    {
        var_f873ec447c4ef099 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_left_1", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 2, 20, undefined, undefined, 0 );
        wait pace_rand;
        var_f873ea447c4eec33 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_left_3", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 2, 20, undefined, undefined, 0 );
        thread function_33c5d646b9cd4113( 6, "flag_aries_nightmare_tomb_left_combat_a_count_hit" );
        utility::flag_wait_or_timeout( "flag_aries_nightmare_tomb_left_combat_a_count_hit", 8 );
        
        if ( utility::cointoss() )
        {
            var_f873e9447c4eea00 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_left_2", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 2, 20, undefined, undefined, 0 );
        }
        else
        {
            var_f873ef447c4ef732 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_left_4", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 2, 20, undefined, undefined, 0 );
        }
        
        return;
    }
    
    var_f873e9447c4eea00 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_left_2", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 2, 20, undefined, undefined, 0 );
    wait pace_rand;
    var_f873ef447c4ef732 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_left_4", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 2, 20, undefined, undefined, 0 );
    thread function_33c5d646b9cd4113( 6, "flag_aries_nightmare_tomb_left_combat_a_count_hit" );
    utility::flag_wait_or_timeout( "flag_aries_nightmare_tomb_left_combat_a_count_hit", 8 );
    
    if ( &utility::cointoss )
    {
        var_f873ec447c4ef099 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_left_1", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 2, 20, undefined, undefined, 0 );
        return;
    }
    
    var_f873ea447c4eec33 thread ob_container_spawn_closet::function_eec83e80439c009b( "flag_shutdown_spawn_closet_crypt_left_3", "ai_encounter:aries_p2_spawn_closet_encounter", "vermin", 2, 20, undefined, undefined, 0 );
}

/#

    // Namespace namespace_c8335fe106fcaba1
    // Params 0
    // Checksum 0x97ffda49, Offset: 0x2c9e
    // Size: 0x5, Type: dev
    function function_44d206b1599267d1()
    {
        
    }

#/

// Namespace namespace_c8335fe106fcaba1
// Params 4
// Checksum 0x2590526d, Offset: 0x2cab
// Size: 0x33
function function_e60f8a1f79f357ff( requestid, activity_instance, agent, data )
{
    utility::flag_set( "flag_aries_nightmare_maze_tomb_left_spawned" );
}

// Namespace namespace_c8335fe106fcaba1
// Params 4
// Checksum 0x2245de8, Offset: 0x2ce6
// Size: 0x33
function function_b761f25e678614da( requestid, activity_instance, agent, data )
{
    utility::flag_set( "flag_aries_nightmare_maze_tomb_right_spawned" );
}

// Namespace namespace_c8335fe106fcaba1
// Params 4
// Checksum 0x2e4c268e, Offset: 0x2d21
// Size: 0x87
function function_a6a0c565b37c6275( requestid, activity_instance, agent, data )
{
    data.spawnspeed = 2;
    player = utility::get_closest_filtered( agent.origin, level.players );
    agent.favoriteenemy = player;
    agent function_fa32376aaa88a7a2( agent.origin, 5000 );
    agent aries_util::function_fe0a54195e81bbc6();
}

// Namespace namespace_c8335fe106fcaba1
// Params 4
// Checksum 0xee4a56bc, Offset: 0x2db0
// Size: 0x232
function function_620d3ee2c6a39a5a( requestid, activity_instance, agent, data )
{
    agent endon( #"death" );
    agent endon( #"entitydeleted" );
    data.spawnspeed = 2;
    agent.ignoreall = 1;
    agent.var_a13bed1ac47e1b2c = 1;
    var_c0cf0ccdd2aade71 = spawn( "script_model", agent.origin );
    var_c0cf0ccdd2aade71.angles = agent.angles;
    waitframe();
    agent linkto( var_c0cf0ccdd2aade71 );
    var_c0cf0ccdd2aade71 rotateyaw( randomfloatrange( 1, 270 ), 0.1 );
    f_move_time = randomfloatrange( 0.5, 2 );
    var_66dc73cea33c51eb = randomintrange( 10, 45 );
    agent thread function_1d9c5c4ed6a75586();
    
    while ( !utility::flag( "flag_aries_nightmare_maze_tower_transition_25" ) && !utility::flag( "flag_aries_nightmare_maze_tower_transition_shot" ) )
    {
        var_c0cf0ccdd2aade71 movez( var_66dc73cea33c51eb, f_move_time );
        utility::flag_wait_any_timeout( f_move_time, "flag_aries_nightmare_maze_tower_transition_25", "flag_aries_nightmare_maze_tower_transition_shot" );
        var_c0cf0ccdd2aade71 movez( var_66dc73cea33c51eb * -1, f_move_time );
        utility::flag_wait_any_timeout( f_move_time, "flag_aries_nightmare_maze_tower_transition_25", "flag_aries_nightmare_maze_tower_transition_shot" );
    }
    
    wait randomfloatrange( 0.1, 1 );
    f_move_time = 4;
    i_move_dist = randomintrange( 1100, 1350 );
    var_930d3dec77581db3 = utility::getstructarray( "s_tower_scene_fly_exit_ref", "targetname" );
    s_tower_scene_fly_exit_ref = var_930d3dec77581db3[ randomintrange( 0, var_930d3dec77581db3.size - 1 ) ];
    var_c0cf0ccdd2aade71 movez( i_move_dist, f_move_time, 2 );
    var_c0cf0ccdd2aade71 rotateto( s_tower_scene_fly_exit_ref.angles, f_move_time );
    wait f_move_time;
    f_move_time = 3;
    var_c0cf0ccdd2aade71 moveto( s_tower_scene_fly_exit_ref.origin, f_move_time, 1 );
    wait f_move_time;
    var_c0cf0ccdd2aade71 delete();
    agent.diequietly = 1;
    agent.nocorpse = 1;
    agent.death_source = "despawn";
    agent kill();
}

// Namespace namespace_c8335fe106fcaba1
// Params 0
// Checksum 0xd750d60e, Offset: 0x2fea
// Size: 0x43
function function_1d9c5c4ed6a75586()
{
    self endon( #"flag_aries_nightmare_maze_tower_transition" );
    self endon( #"flag_aries_nightmare_tower_entered" );
    level endon( #"flag_aries_nightmare_maze_tower_transition_shot" );
    utility::waittill_any( "damage", "bulletwhizby" );
    utility::flag_set( "flag_aries_nightmare_maze_tower_transition_shot" );
}

// Namespace namespace_c8335fe106fcaba1
// Params 0
// Checksum 0xa3f87a65, Offset: 0x3035
// Size: 0x45
function function_6c00552e8f3750ea()
{
    var_501bab5f902ac716 = getnoentvolumearray( "trig_containertower_entered", #targetname );
    var_501bab5f902ac716[ 0 ] waittill( #"trigger", player );
    utility::flag_set( "flag_aries_nightmare_maze_tower_transition_25" );
}

/#

    // Namespace namespace_c8335fe106fcaba1
    // Params 0
    // Checksum 0xb202f067, Offset: 0x3082
    // Size: 0x5, Type: dev
    function function_7e36ea0ebb77a99()
    {
        
    }

#/

// Namespace namespace_c8335fe106fcaba1
// Params 0
// Checksum 0xaba21f4, Offset: 0x308f
// Size: 0x41
function function_6fb36db034a0b36d()
{
    var_9ad05a8c35eae29f = utility::getstruct( "scn_maze_intro_vermin_walk_ground_across", "targetname" );
    var_9ad05a8c35eae29f thread scene::set_anim_rate( 2 );
    var_9ad05a8c35eae29f thread scene::play();
    wait 1.5;
    var_9ad05a8c35eae29f thread scene::cleanup();
}

// Namespace namespace_c8335fe106fcaba1
// Params 4
// Checksum 0x721871fa, Offset: 0x30d8
// Size: 0xc0
function function_73894006983041e7( scene_zombies, amount, playspeed, var_3e7cf343e0805099 )
{
    a_animnode = utility::getstructarray( scene_zombies, "targetname" );
    
    if ( isdefined( amount ) )
    {
        n_max = minint( amount, a_animnode.size );
        a_animnode = arrayrandomize( a_animnode );
    }
    else
    {
        n_max = a_animnode.size;
    }
    
    i = 0;
    
    while ( i <= n_max )
    {
        a_animnode[ i ] thread scene::set_anim_rate( playspeed );
        
        if ( isdefined( var_3e7cf343e0805099 ) )
        {
            a_animnode[ i ] thread scene::play( var_3e7cf343e0805099 );
        }
        else
        {
            a_animnode[ i ] thread scene::play();
        }
        
        if ( i == n_max )
        {
            break;
        }
        else
        {
            i++;
        }
        
        wait 0.1;
    }
}

/#

    // Namespace namespace_c8335fe106fcaba1
    // Params 0
    // Checksum 0x2e0cf840, Offset: 0x31a0
    // Size: 0x5, Type: dev
    function function_84ce0422c9a1d8d1()
    {
        
    }

#/

// Namespace namespace_c8335fe106fcaba1
// Params 2
// Checksum 0x4dcbf86e, Offset: 0x31ad
// Size: 0xb6
function function_ca6c0d0645ad74c9( var_46f1327fcd04fb1e, var_aa51443487c71c68 )
{
    utility::flag_wait( var_46f1327fcd04fb1e );
    var_28933483b80630f9 = getentarray( var_aa51443487c71c68, #targetname );
    wait 5;
    
    foreach ( ent in var_28933483b80630f9 )
    {
        ent delete();
    }
    
    utility::flag_set( "flag_weakpoint_maze_complete" );
}

/#

    // Namespace namespace_c8335fe106fcaba1
    // Params 0
    // Checksum 0xe227cee7, Offset: 0x326b
    // Size: 0x5, Type: dev
    function function_f138ef08a5d43165()
    {
        
    }

#/

// Namespace namespace_c8335fe106fcaba1
// Params 0
// Checksum 0xcb1e53be, Offset: 0x3278
// Size: 0x48
function function_41000370a6110d46()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended", #"instance_destroyed" );
    waitframe();
    activity_instance thread ob_story_mission_utils::objective_text_show( "ob_aries_find_woods_nightmare" );
    level utility::flag_wait( "flag_nm_narr_tower_objective" );
    ob_story_mission_utils::objective_text_clear();
}

// Namespace namespace_c8335fe106fcaba1
// Params 4
// Checksum 0x7c4c70a, Offset: 0x32c8
// Size: 0x98
function function_791e838f77242652( var_be8ba0881d6c60d7, var_ae6bca7c69ee7c00, flag_endon = "flg_nmr_woods_memory_2_starting", crypt_trigger )
{
    scriptable_weak_point = getscriptablearray( var_be8ba0881d6c60d7, #targetname )[ 0 ];
    level utility::flag_wait_or_timeout( var_ae6bca7c69ee7c00, 30 );
    
    if ( utility::flag( var_ae6bca7c69ee7c00 ) )
    {
        return;
    }
    
    level thread aries_vo::function_46272aed8c75dda7();
    thread function_9ccf7cb45a649301( scriptable_weak_point, var_ae6bca7c69ee7c00, flag_endon, crypt_trigger );
    level utility::flag_wait_any( var_ae6bca7c69ee7c00, flag_endon );
    level utility::flag_set( "flag_maze_room_weakpoint_obj_destroyed" );
}

// Namespace namespace_c8335fe106fcaba1
// Params 4
// Checksum 0x2286d3d6, Offset: 0x3368
// Size: 0xb8
function function_9ccf7cb45a649301( scriptable_weak_point, var_ae6bca7c69ee7c00, flag_endon, crypt_trigger )
{
    forward = anglestoup( scriptable_weak_point.angles );
    var_c337a642d6ac802 = forward * 55 + scriptable_weak_point.origin;
    var_8ec10611cdf1a599 = [];
    
    while ( !utility::flag( var_ae6bca7c69ee7c00 ) )
    {
        crypt_trigger waittill( #"trigger", triggerer );
        
        if ( isplayer( triggerer ) && !arraycontains( var_8ec10611cdf1a599, triggerer ) )
        {
            var_8ec10611cdf1a599[ var_8ec10611cdf1a599.size ] = triggerer;
            triggerer childthread function_c752fe18e57b79e7( var_c337a642d6ac802, var_ae6bca7c69ee7c00, flag_endon );
        }
    }
}

// Namespace namespace_c8335fe106fcaba1
// Params 3
// Checksum 0x7f314f75, Offset: 0x3428
// Size: 0x4d
function function_c752fe18e57b79e7( way_point_origin, var_ca908a6a83b8fb50, flag_endon )
{
    obj_id = ob_story_mission_utils::function_b9cb179f9577f32a( way_point_origin, 40, [ self ] );
    utility::flag_wait_any( var_ca908a6a83b8fb50, flag_endon );
    ob_story_mission_utils::objective_marker_clear( obj_id );
}

// Namespace namespace_c8335fe106fcaba1
// Params 0
// Checksum 0xc8fcc153, Offset: 0x347d
// Size: 0xb6
function function_8c54ccc8d6bd27a7()
{
    level endon( #"flg_nmr_woods_memory_2_complete" );
    
    if ( !isdefined( level.var_821f8d6f0a129792 ) )
    {
        level.var_821f8d6f0a129792 = [];
    }
    
    var_879893c3755f65c5 = getnoentvolumearray( "t_nmr_containertower_memory_objective", #targetname );
    
    if ( var_879893c3755f65c5.size <= 0 )
    {
        return;
    }
    
    while ( !utility::flag( "flg_nmr_woods_memory_2_complete" ) )
    {
        var_879893c3755f65c5[ 0 ] waittill( #"trigger", triggerer );
        
        if ( isplayer( triggerer ) && !arraycontains( level.var_821f8d6f0a129792, triggerer ) )
        {
            level.var_821f8d6f0a129792[ level.var_821f8d6f0a129792.size ] = triggerer;
        }
        
        level notify( #"hash_b4b148e1238aeaaa" );
    }
}

/#

    // Namespace namespace_c8335fe106fcaba1
    // Params 0
    // Checksum 0xe12e3718, Offset: 0x353b
    // Size: 0x5, Type: dev
    function function_dc4a9d6fbfc34a67()
    {
        
    }

#/

// Namespace namespace_c8335fe106fcaba1
// Params 0
// Checksum 0xef271d5a, Offset: 0x3548
// Size: 0xba
function function_f3efa8322d969135()
{
    thread function_a25a8607baf52031( "trig_maze_tunnel_left_a", "sm_maze_tunnel_1_entrance_blocker_left", "sm_maze_tunnel_1_entrance_blocker_right", "sbm_maze_tunnel_1_clip", "sm_maze_tunnel_1_blockers", "flag_nm_maze_tunnel_1_triggered" );
    thread function_d39ec2bff9a0626( "trig_maze_tunnel_left_b", "sm_maze_tunnel_2_blocker", "sbm_maze_tunnel_2_clip", "flag_nm_maze_tunnel_2_triggered" );
    thread function_d39ec2bff9a0626( "trig_maze_tunnel_mid_a", "sm_maze_tunnel_3_blocker", "sbm_maze_tunnel_3_clip", "flag_nm_maze_tunnel_3_triggered" );
    utility::flag_wait( "flag_nm_maze_tunnel_blockers_shutdown" );
    
    if ( !utility::flag( "flag_nm_maze_tunnel_1_triggered" ) )
    {
        thread function_9771e04b160a9797( "sbm_maze_tunnel_1_clip" );
    }
    
    if ( !utility::flag( "flag_nm_maze_tunnel_2_triggered" ) )
    {
        thread function_9771e04b160a9797( "sbm_maze_tunnel_2_clip" );
    }
    
    if ( !utility::flag( "flag_nm_maze_tunnel_3_triggered" ) )
    {
        thread function_9771e04b160a9797( "sbm_maze_tunnel_3_clip" );
    }
}

// Namespace namespace_c8335fe106fcaba1
// Params 0
// Checksum 0xec036a86, Offset: 0x360a
// Size: 0xc4
function function_cd2aad025da7476()
{
    thread function_a25a8607baf52031( "trig_maze_tunnel_mid_b_entered", "sm_maze_tunnel_4_entrance_blocker_left", "sm_maze_tunnel_4_entrance_blocker_right", "sbm_maze_tunnel_4_clip", "sm_maze_tunnel_4_blocker", "flag_nm_maze_tunnel_4_triggered" );
    thread function_a25a8607baf52031( "trig_maze_tunnel_right_a", "sm_maze_tunnel_5_entrance_blocker_left", "sm_maze_tunnel_5_entrance_blocker_right", "sbm_maze_tunnel_5_clip", "sm_maze_tunnel_5_blocker", "flag_nm_maze_tunnel_5_triggered" );
    thread function_d39ec2bff9a0626( "trig_maze_tunnel_right_b", "sm_maze_tunnel_6_blocker", "sbm_maze_tunnel_6_clip", "flag_nm_maze_tunnel_6_triggered" );
    utility::flag_wait( "flag_nm_maze_tunnel_blockers_shutdown" );
    
    if ( !utility::flag( "flag_nm_maze_tunnel_4_triggered" ) )
    {
        thread function_9771e04b160a9797( "sbm_maze_tunnel_4_clip" );
    }
    
    if ( !utility::flag( "flag_nm_maze_tunnel_5_triggered" ) )
    {
        thread function_9771e04b160a9797( "sbm_maze_tunnel_5_clip" );
    }
    
    if ( !utility::flag( "flag_nm_maze_tunnel_6_triggered" ) )
    {
        thread function_9771e04b160a9797( "sbm_maze_tunnel_6_clip" );
    }
}

// Namespace namespace_c8335fe106fcaba1
// Params 7
// Checksum 0xc20bb2f3, Offset: 0x36d6
// Size: 0x235
function function_a25a8607baf52031( trigger, left_door_target, right_door_target, tunnel_clip, container_blockers, flag_toset, rumble_radius )
{
    level endon( #"flag_aries_nightmare_tower_catchup_complete" );
    level endon( #"flag_nm_maze_tunnel_blockers_shutdown" );
    a_trigger = getnoentvolumearray( trigger, #targetname );
    a_trigger[ 0 ] waittill( #"trigger" );
    utility::flag_set( flag_toset );
    
    if ( level.blockers_triggered < level.var_5e0f2305516ac075 )
    {
        level.blockers_triggered++;
        level thread aries_vo::function_effe77bd5c8d9a71();
        var_67aef62fea0fcca4 = getent( left_door_target, #targetname );
        var_7d7412f89b2f7ffd = getent( right_door_target, #targetname );
        var_67aef62fea0fcca4 rotateto( var_67aef62fea0fcca4.angles - ( 0, 90, 0 ), 0.5, 0.25, 0 );
        var_7d7412f89b2f7ffd rotateto( var_7d7412f89b2f7ffd.angles + ( 0, 90, 0 ), 0.5, 0.25, 0 );
        var_67aef62fea0fcca4 playsound( "evt_aries_nm_maze_block_door" );
        thread function_15bb27f344089ab0( var_67aef62fea0fcca4.origin, "viewmodel_small", 512, "damage_med" );
        var_b25b5d8f96f27c71 = getentarray( container_blockers, #targetname );
        
        foreach ( ent_blocker in var_b25b5d8f96f27c71 )
        {
            var_5990ce3727e634d1 = utility::getstruct( ent_blocker.target, "targetname" );
            ent_blocker moveto( var_5990ce3727e634d1.origin, 0.5, 0.1, 0.1 );
        }
        
        return;
    }
    
    function_9771e04b160a9797( tunnel_clip );
}

// Namespace namespace_c8335fe106fcaba1
// Params 4
// Checksum 0x234f551d, Offset: 0x3913
// Size: 0x199
function function_d39ec2bff9a0626( trigger, container_blockers, tunnel_clip, flag_toset )
{
    level endon( #"flag_aries_nightmare_tower_catchup_complete" );
    level endon( #"flag_nm_maze_tunnel_blockers_shutdown" );
    a_trigger = getnoentvolumearray( trigger, #targetname );
    a_trigger[ 0 ] waittill( #"trigger" );
    utility::flag_set( flag_toset );
    
    if ( level.blockers_triggered < level.var_5e0f2305516ac075 )
    {
        level.blockers_triggered++;
        level thread aries_vo::function_effe77bd5c8d9a71();
        var_b25b5d8f96f27c71 = getentarray( container_blockers, #targetname );
        
        foreach ( ent_blocker in var_b25b5d8f96f27c71 )
        {
            var_5990ce3727e634d1 = utility::getstruct( ent_blocker.target, "targetname" );
            ent_blocker moveto( var_5990ce3727e634d1.origin, 0.5, 0.1, 0.1 );
            ent_blocker playsound( "evt_aries_nm_maze_block_container" );
            thread function_15bb27f344089ab0( var_5990ce3727e634d1.origin, "viewmodel_small", 512, "damage_med", 0.5, 1 );
        }
        
        return;
    }
    
    function_9771e04b160a9797( tunnel_clip );
}

// Namespace namespace_c8335fe106fcaba1
// Params 1
// Checksum 0x2995fe77, Offset: 0x3ab4
// Size: 0x35
function function_9771e04b160a9797( tunnel_clip )
{
    e_entrance_clip = getent( tunnel_clip, #targetname );
    e_entrance_clip connectpaths();
    e_entrance_clip delete();
}

// Namespace namespace_c8335fe106fcaba1
// Params 0
// Checksum 0x74d6599a, Offset: 0x3af1
// Size: 0x3b
function function_eafddaaa69540e10()
{
    while ( !utility::flag( "flag_nm_maze_tunnel_blockers_shutdown" ) )
    {
        if ( level.blockers_triggered < level.var_5e0f2305516ac075 )
        {
        }
        else
        {
            waitframe();
            utility::flag_set( "flag_nm_maze_tunnel_blockers_shutdown" );
        }
        
        waitframe();
    }
}

// Namespace namespace_c8335fe106fcaba1
// Params 8
// Checksum 0xb0484601, Offset: 0x3b34
// Size: 0x1b2
function function_15bb27f344089ab0( pos, rumble = "artillery_rumble_light", rumble_radius = 512, end_rumble, end_rumble_delay = 0.5, screen_shake = 0, scale = 0.2, duration = 0.6 )
{
    nearbyplayers = utility::playersincylinder( pos, rumble_radius );
    
    foreach ( player in nearbyplayers )
    {
        player playrumbleonpositionforclient( rumble, player.origin );
        
        if ( screen_shake )
        {
            player earthquakeforplayer( scale, duration, player.origin, rumble_radius );
        }
    }
    
    if ( isdefined( end_rumble ) )
    {
        wait end_rumble_delay;
        
        foreach ( player in nearbyplayers )
        {
            player playrumbleonpositionforclient( end_rumble, player.origin );
        }
    }
}

// Namespace namespace_c8335fe106fcaba1
// Params 0
// Checksum 0xbfaaf47b, Offset: 0x3cee
// Size: 0x19
function function_2b49858e55179ad9()
{
    if ( level.blockers_triggered == 2 )
    {
        level thread aries_vo::function_3e89eb44c5ef466e();
    }
}

/#

    // Namespace namespace_c8335fe106fcaba1
    // Params 0
    // Checksum 0xfa4dcf94, Offset: 0x3d0f
    // Size: 0x5, Type: dev
    function function_cba78abec66efcc4()
    {
        
    }

#/

// Namespace namespace_c8335fe106fcaba1
// Params 0
// Checksum 0x9cfa690b, Offset: 0x3d1c
// Size: 0x225
function function_98f6f620d6add9a7()
{
    activity_instance = self;
    activity_instance thread ob_story_mission_utils::item_spawn_weapon( "str_corridor_weapon", "flag_aries_nightmare_tower_catchup_complete", 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "str_corridor_lethal", "flag_aries_nightmare_tower_catchup_complete", 1 );
    activity_instance thread ob_story_mission_utils::item_spawn_equipment( "str_corridor_tactical", "flag_aries_nightmare_tower_catchup_complete", 1 );
    var_faf2cd50cd20cbcc = getent( "sbm_nmr_corridor_intro_nograpple", #targetname );
    var_faf2cd50cd20cbcc delete();
    e_blocker_right_a = getent( "sbm_nmr_corridor_intro_clip_right_a", #targetname );
    e_blocker_right_a delete();
    e_blocker_left_a = getent( "sbm_nmr_corridor_intro_clip_left_a", #targetname );
    e_blocker_left_a delete();
    e_blocker_left_b = getent( "sbm_nmr_corridor_intro_clip_left_b", #targetname );
    e_blocker_left_b delete();
    e_blocker_right_b = getent( "sbm_nmr_corridor_intro_clip_right_b", #targetname );
    e_blocker_right_b delete();
    var_8d34a7629cdeac14 = [ "sm_container_constrict_a1_0", "sm_container_constrict_a1_1", "sm_container_constrict_a1_2", "sm_container_constrict_a1_3", "sm_container_constrict_a1_4", "sm_container_constrict_a1_5", "sm_container_constrict_a1_6" ];
    var_2fddb2ef9c6a0e93 = function_bbef8e1239ac81a( var_8d34a7629cdeac14 );
    thread aries_util::function_2ad4d6454b67c8a8( var_2fddb2ef9c6a0e93 );
    var_f873ea447c4eec33 = getent( "spawn_closet_maze_a_3", #targetname );
    var_f873ef447c4ef732 = getent( "spawn_closet_maze_a_4", #targetname );
    var_75f350bd8910114d = utility::getstruct( "static_encounter_maze_a_3", "targetname" );
    var_ed8fa314efb9de3a = utility::getstruct( "static_encounter_maze_a_4", "targetname" );
    var_f873ea447c4eec33 thread ob_container_spawn_closet::function_e2f5560f63a19f46( var_75f350bd8910114d, 0.5, 0.5, 0.15, 0.15 );
    var_f873ef447c4ef732 thread ob_container_spawn_closet::function_e2f5560f63a19f46( var_ed8fa314efb9de3a, 0.5, 0.5, 0.15, 0.15 );
    utility::flag_wait( "flag_aries_nightmare_tower_catchup_complete" );
    function_daed65b8fa01f78a( var_2fddb2ef9c6a0e93 );
    var_8d34a7629cdeac14 = undefined;
    var_2fddb2ef9c6a0e93 = undefined;
}

