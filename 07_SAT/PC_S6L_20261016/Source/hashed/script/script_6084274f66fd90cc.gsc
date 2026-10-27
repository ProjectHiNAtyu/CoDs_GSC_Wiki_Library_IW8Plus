// script_6084274f66fd90cc  (hash_6084274f66fd90cc.gscc) (size: 6743 Bytes / 0x1a57 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf2a4b543 (4070880579)
// size ...... 6743 (0x1a57)
// includes .. 16  (offset: 0x177b)
// strings ... 39  (offset: 0x17fb)
// dev strs .. 1   (offset: 0x1a4b)
// exports ... 13  (offset: 0xeb7)
// cseg ...... 0x3d7 + 0xae0 (0xeb7)
// imports ... 58  (offset: 0x10bf)
// animtree1 . 0   (offset: 0x1a57)
// animtree2 . 0   (offset: 0x1a57)
#using script_3edd59d0d3fc3262;
#using script_4807fa09430c799f;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\hud_util;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_util;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_vo;
#using scripts\mp\snd\snd_ob;

#namespace namespace_fbf65315066b0001;

/#

    // Namespace namespace_fbf65315066b0001
    // Params 0
    // Checksum 0xc2520f5f, Offset: 0x3f5
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_fbf65315066b0001
// Params 0, eflags: 0x5
// Checksum 0xb84f2cc6, Offset: 0x402
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_e813f67d0bf124ae", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_fbf65315066b0001
// Params 0, eflags: 0x4
// Checksum 0x5928c33e, Offset: 0x42b
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_VIRGO_CARRIER_3";
    activity_common::registeractivitytype( "OB_VIRGO_CARRIER_3", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_CARRIER_3", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_CARRIER_3", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_CARRIER_3", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_fbf65315066b0001
// Params 0
// Checksum 0x1919f6ab, Offset: 0x48c
// Size: 0x89
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance function_9dae1376f9d78367();
    }
    
    var_e04c0425c57a325 = utility::getstruct( "scene_harper_boss", "targetname" );
    var_e04c0425c57a325 zombie_boss_healthbar::function_f50a10314e72caa1();
    var_e04c0425c57a325 zombie_boss_healthbar::init_zombie_boss_healthbar();
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_fbf65315066b0001
// Params 0
// Checksum 0x87380aab, Offset: 0x51d
// Size: 0x32
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance function_c8b4a5956fe9bd0();
}

// Namespace namespace_fbf65315066b0001
// Params 0
// Checksum 0xe349f417, Offset: 0x557
// Size: 0x2b
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    
    /#
        level notify( #"hash_44942599bc2c6056" );
    #/
}

/#

    // Namespace namespace_fbf65315066b0001
    // Params 0
    // Checksum 0x85e8ab4f, Offset: 0x58a
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_fbf65315066b0001
// Params 0
// Checksum 0x5df157a1, Offset: 0x597
// Size: 0x103
function function_9dae1376f9d78367()
{
    var_e04c0425c57a325 = utility::getstruct( "scene_harper_boss", "targetname" );
    var_e04c0425c57a325 zombie_boss_healthbar::function_f50a10314e72caa1();
    var_e04c0425c57a325 zombie_boss_healthbar::init_zombie_boss_healthbar();
    level thread ob_virgo_util::carrier_exploders();
    level thread virgo_vo::function_62378c0819bf51db();
    level thread OB_VIRGO_CARRIER_INTRO::boss_damage_listener();
    scene_struct = utility::getstruct( "scene_harper_boss", "targetname" );
    scene_struct scene::set_notify_note( level, "slam_right", "Types_Prop", 1 );
    scene_struct scene::set_notify_note( level, "slam_left", "Types_Prop", 1 );
    level.boss_activity = self;
    level.bubble = getent( "harper_attack_orb", "targetname" );
    level.bubble_2 = getent( "harper_attack_orb_2", "targetname" );
    level.old_spot = level.bubble.origin;
    thread ob_story_mission_utils::item_spawn_weapon( "s_weapon_carrier", undefined, 1 );
    thread ob_story_mission_utils::item_spawn_equipment( "s_equip_carrier", undefined, 1, undefined, undefined, undefined );
}

// Namespace namespace_fbf65315066b0001
// Params 0
// Checksum 0x5fad41ba, Offset: 0x6a2
// Size: 0x1be
function function_c8b4a5956fe9bd0()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    level thread boss_fight_3();
    struct = utility::getstruct( "struct_br_circle_start", "targetname" );
    level thread ob_virgo_util::function_8a4b5830e567ba87( struct );
    level utility::flag_set( "flag_start_harper_gas_ring" );
    ob_virgo_util::setup_ui_widget( "OB_VIRGO_CARRIER_3" );
    level utility::flag_wait( "flag_virgo_carrier_3_done" );
    story_contract_util::mark_complete( level.players, #"virgo_complete" );
    story_contract_util::achievement_activities( level.players, "sat_wc_mission6and7", [ #"aqua_complete", #"virgo_complete" ] );
    
    if ( ob::nightmare() )
    {
        ob_story_mission_utils::function_f20a9fe6c594f5b3( 0 );
        
        foreach ( player in level.players )
        {
            player thread hud_util::fade_in( 0.5, "white" );
            player utility::callsharedfunc( #"hash_561b73e89e879cb7", #"hash_3fa3c8cca94e4308", "virgo" );
        }
        
        level utility::flag_set( "nm_virgo_loot_flag" );
        origin = ( 41780, 29512, -132 );
        angles = ( 0, 130, 0 );
        ob_story_mission_utils::function_e1f7ae6f70c4b0c1( origin, angles, undefined, "OB_VIRGO_CARRIER_2" );
    }
    
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_fbf65315066b0001
// Params 0
// Checksum 0x32107e0f, Offset: 0x868
// Size: 0x48e
function boss_fight_3()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    var_78a1a9cabfc4d42e = 150000;
    
    /#
        if ( getdvarint( @"scr_harper_health", 0 ) )
        {
            var_78a1a9cabfc4d42e = getdvarint( @"scr_harper_health" );
        }
    #/
    
    switch ( level.players.size )
    {
        case 1:
            boss_health = var_78a1a9cabfc4d42e;
            break;
        case 2:
            boss_health = var_78a1a9cabfc4d42e * 2;
            break;
        case 3:
            boss_health = var_78a1a9cabfc4d42e * 3;
            break;
        case 4:
            boss_health = var_78a1a9cabfc4d42e * 4;
            break;
        default:
            boss_health = var_78a1a9cabfc4d42e;
            break;
    }
    
    level.stun_damage = boss_health / 30;
    
    if ( !isdefined( level.health_struct ) )
    {
        level.health_struct = {};
        level.health_struct.health = boss_health / 3;
        level.health_struct.maxhealth = boss_health;
    }
    
    var_54469e2e396bab8e = [ "double_slam", "attack_yell", "palm_slam_left", "attack_cradle", "palm_slam_right", "attack_yell", "attack_cradle" ];
    scene_struct = utility::getstruct( "scene_harper_boss", "targetname" );
    scene_struct scene::set_notify_note( level, "slam_right", "Types_Prop", 1 );
    scene_struct scene::set_notify_note( level, "slam_left", "Types_Prop", 1 );
    level.health_threshold = 1;
    level.var_bf2e669910db962c = "flag_virgo_harper_boss_3";
    level thread OB_VIRGO_CARRIER_INTRO::function_430bfb34f5c4fc82( level.health_threshold, "flag_virgo_harper_boss_3" );
    level utility::flag_set( "flag_start_boss_fight_3" );
    scene_struct thread OB_VIRGO_CARRIER_INTRO::setup_harper();
    scene_struct scene::play( undefined, "enter_normal" );
    scene_struct thread OB_VIRGO_CARRIER_INTRO::function_57dded51455ae5ae( "flag_virgo_harper_boss_3", var_54469e2e396bab8e );
    level thread prestream_outro();
    level utility::flag_wait( "flag_virgo_harper_boss_3" );
    scene_struct thread scene::play( undefined, "attack_yell_react" );
    wait 2.5;
    level notify( #"hash_44ab75d4712e2d31" );
    scene_struct scene::stop();
    level.bubble hide();
    level thread ob_virgo_util::revive_squad();
    level thread ob_story_mission_utils::function_2686bb512b355040( "OB_VIRGO_CARRIER_3" );
    outro_struct = utility::getstruct( "struct_boss_outro", "targetname" );
    level notify( #"hash_2e3ff762df82a737" );
    level thread snd_ob::function_70013396bb42f6cc( level.players, "scene_sat_cin_virgo_carrier_boss_outro" );
    
    if ( !ob::nightmare() )
    {
        outro_struct scene::play();
    }
    else
    {
        level utility::flag_set( "nm_harper_boss_defeated" );
        outro_struct scene::play( undefined, undefined, "scene_sat_wc_s2_cin_virgo_carrier_boss_outro" );
    }
    
    foreach ( player in level.players )
    {
        player coop::set_player_frozen_vars( 1, "teleport_no_cinematic" );
    }
    
    wait 2.5;
    level thread function_4775b6051a7e23e();
    
    foreach ( player in level.players )
    {
        player coop::set_player_frozen_vars( 0, "teleport_no_cinematic" );
    }
    
    foreach ( player in level.players )
    {
        player utility::player_prestream_clear( "virgo_carrier_3" );
    }
    
    level utility::flag_set( "flag_virgo_carrier_3_done" );
    level notify( #"exit_death_completed" );
    level thread snd_ob::function_52bc8194809997e8( level.players, "scene_sat_cin_virgo_carrier_boss_outro" );
}

// Namespace namespace_fbf65315066b0001
// Params 0
// Checksum 0x95386b6b, Offset: 0xcfe
// Size: 0x86
function function_4775b6051a7e23e()
{
    foreach ( player in level.players )
    {
        player hud_util::fade_out( 0, "white" );
    }
    
    function_aa3cd643ac2c86cc();
}

// Namespace namespace_fbf65315066b0001
// Params 0
// Checksum 0xaa824a97, Offset: 0xd8c
// Size: 0x12b
function prestream_outro()
{
    while ( level.health_struct.health > 25000 )
    {
        waitframe();
    }
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
    
    assets = [];
    distances = [];
    assets[ assets.size ] = "xcomp_c_sat_usa_npc_harper_boss_cradle";
    distances[ distances.size ] = 2000;
    assets[ assets.size ] = "xcomp_c_sat_usa_pl_red_proto";
    distances[ distances.size ] = 128;
    assets[ assets.size ] = "xcomp_c_sat_nzl_pl_rose_proto_cin";
    distances[ distances.size ] = 128;
    assets[ assets.size ] = "xcomp_c_sat_usa_pl_black_sp";
    distances[ distances.size ] = 128;
    assets[ assets.size ] = "xcomp_c_sat_usa_pl_maroon_proto";
    distances[ distances.size ] = 128;
    
    foreach ( player in level.players )
    {
        player thread utility::player_prestream_assets( "virgo_carrier_3", "model", assets, distances, -1 );
    }
}

