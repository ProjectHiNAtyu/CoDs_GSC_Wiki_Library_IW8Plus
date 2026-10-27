// script_5495cf3ce62afcf3  (hash_5495cf3ce62afcf3.gscc) (size: 4257 Bytes / 0x10a1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5e4e9d5e (1582210398)
// size ...... 4257 (0x10a1)
// includes .. 11  (offset: 0xec1)
// strings ... 24  (offset: 0xf19)
// dev strs .. 0   (offset: 0x10a1)
// exports ... 13  (offset: 0x855)
// cseg ...... 0x248 + 0x60d (0x855)
// imports ... 38  (offset: 0xa5d)
// animtree1 . 0   (offset: 0x10a1)
// animtree2 . 0   (offset: 0x10a1)
#using script_4807fa09430c799f;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_util;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_vo;

#namespace namespace_fbf65215066afdce;

/#

    // Namespace namespace_fbf65215066afdce
    // Params 0
    // Checksum 0xc253f290, Offset: 0x266
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_fbf65215066afdce
// Params 0, eflags: 0x5
// Checksum 0xcf49e350, Offset: 0x273
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_e813f77d0bf12661", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_fbf65215066afdce
// Params 0, eflags: 0x4
// Checksum 0x59293ef1, Offset: 0x29c
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_VIRGO_CARRIER_2";
    activity_common::registeractivitytype( "OB_VIRGO_CARRIER_2", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_CARRIER_2", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_CARRIER_2", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_CARRIER_2", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_fbf65215066afdce
// Params 0
// Checksum 0xc2f271ac, Offset: 0x2fd
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance function_5a1c22bb672d5e58();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_fbf65215066afdce
// Params 0
// Checksum 0x3b621457, Offset: 0x362
// Size: 0x32
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance function_25d97dcf21fa7bb1();
}

// Namespace namespace_fbf65215066afdce
// Params 0
// Checksum 0xe34809d8, Offset: 0x39c
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

    // Namespace namespace_fbf65215066afdce
    // Params 0
    // Checksum 0x85e95680, Offset: 0x3cf
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_fbf65215066afdce
// Params 0
// Checksum 0xfb87a1da, Offset: 0x3dc
// Size: 0x103
function function_5a1c22bb672d5e58()
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

// Namespace namespace_fbf65215066afdce
// Params 0
// Checksum 0x4bc44d49, Offset: 0x4e7
// Size: 0x5e
function function_25d97dcf21fa7bb1()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    level thread ob_virgo_util::supply_drop_1( "carrier_airdrop_3", "flag_virgo_harper_boss_2" );
    level thread function_39e32eb32fcbab52();
    thread function_5f7bb44b1315a488();
    ob_virgo_util::setup_ui_widget( "OB_VIRGO_CARRIER_2" );
    level utility::flag_wait( "flag_virgo_carrier_2_done" );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_fbf65215066afdce
// Params 0
// Checksum 0x9bd5d620, Offset: 0x54d
// Size: 0x251
function function_39e32eb32fcbab52()
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
        level.health_struct.health = boss_health * 0.666667;
        level.health_struct.maxhealth = boss_health;
    }
    
    level thread function_899c150fbef10948();
    var_286c296047c12465 = [ "double_slam", "attack_cradle", "attack_yell", "double_slam", "attack_cradle", "attack_yell", "attack_cradle" ];
    scene_struct = utility::getstruct( "scene_harper_boss", "targetname" );
    level.health_threshold = level.health_struct.maxhealth / 3;
    level.var_bf2e669910db962c = "flag_virgo_harper_boss_2";
    level thread OB_VIRGO_CARRIER_INTRO::function_430bfb34f5c4fc82( level.health_threshold, "flag_virgo_harper_boss_2", 10 );
    level utility::flag_set( "flag_start_boss_fight_2" );
    scene_struct thread OB_VIRGO_CARRIER_INTRO::setup_harper();
    scene_struct scene::play( undefined, "enter_normal" );
    scene_struct thread OB_VIRGO_CARRIER_INTRO::function_57dded51455ae5ae( "flag_virgo_harper_boss_2", var_286c296047c12465 );
    level utility::flag_wait( "flag_virgo_harper_boss_2" );
    level utility::flag_set( "flag_spawn_encounter_2" );
    scene_struct scene::play( undefined, "exit_agitated" );
    level utility::flag_wait( "flag_stop_encounter_2" );
    level utility::flag_set( "flag_virgo_carrier_2_done" );
}

// Namespace namespace_fbf65215066afdce
// Params 0
// Checksum 0x1a4fab1c, Offset: 0x7a6
// Size: 0x64
function function_5f7bb44b1315a488()
{
    level utility::flag_wait( "flag_spawn_encounter_2" );
    wait 6;
    level thread ob_virgo_util::function_fdd5b4c27ba17b79();
    thread OB_VIRGO_CARRIER_INTRO::function_39bacd7f36de7864( undefined, "zone_2_encounter", "flag_stop_encounter_2" );
    struct = utility::getstruct( "carrier_airdrop_3", "targetname" );
    level utility::flag_wait_or_timeout( "flag_carrier_combat_2_done", 60 );
    level utility::flag_set( "flag_stop_encounter_2" );
}

// Namespace namespace_fbf65215066afdce
// Params 0
// Checksum 0x2a8181d, Offset: 0x812
// Size: 0x43
function function_899c150fbef10948()
{
    while ( level.health_struct.health / level.health_struct.maxhealth > 0.5 )
    {
        waitframe();
    }
    
    level utility::flag_set( "flag_harper_at_50_percent" );
}

