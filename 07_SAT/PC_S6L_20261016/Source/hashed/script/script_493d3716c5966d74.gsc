// script_493d3716c5966d74  (hash_493d3716c5966d74.gscc) (size: 3693 Bytes / 0xe6d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7e84c481 (2122630273)
// size ...... 3693 (0xe6d)
// includes .. 11  (offset: 0xd1d)
// strings ... 18  (offset: 0xd75)
// dev strs .. 0   (offset: 0xe6d)
// exports ... 16  (offset: 0x689)
// cseg ...... 0x200 + 0x489 (0x689)
// imports ... 37  (offset: 0x909)
// animtree1 . 0   (offset: 0xe6d)
// animtree2 . 0   (offset: 0xe6d)
#using script_3edd59d0d3fc3262;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\chyron;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_util;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_vo;
#using scripts\mp\ob\systems\ob_item_select;

#namespace namespace_a5a87f7f1400855e;

/#

    // Namespace namespace_a5a87f7f1400855e
    // Params 0
    // Checksum 0xd0398a00, Offset: 0x21e
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_a5a87f7f1400855e
// Params 0, eflags: 0x5
// Checksum 0x141b51bc, Offset: 0x22b
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_b665ccf6630d4b75", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_a5a87f7f1400855e
// Params 0, eflags: 0x4
// Checksum 0xee10daa1, Offset: 0x254
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LIBRA_INFIL";
    activity_common::registeractivitytype( "OB_LIBRA_INFIL", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_INFIL", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_INFIL", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_INFIL", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_a5a87f7f1400855e
// Params 0
// Checksum 0xbcc5ae26, Offset: 0x2b5
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance start();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_a5a87f7f1400855e
// Params 0
// Checksum 0x61bb606e, Offset: 0x31a
// Size: 0x61
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    activity_instance infil_main();
    story_contract_util::mark_complete( level.players, #"libra_launch" );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_a5a87f7f1400855e
// Params 0
// Checksum 0x4d0e11ff, Offset: 0x383
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_a5a87f7f1400855e
// Params 0
// Checksum 0x4371b822, Offset: 0x3a7
// Size: 0xe
function setup_ui_widget()
{
    ob_story_mission_utils::objective_text_show( "OB_LIBRA_INFIL" );
}

/#

    // Namespace namespace_a5a87f7f1400855e
    // Params 0
    // Checksum 0x97832e10, Offset: 0x3bd
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_a5a87f7f1400855e
// Params 0
// Checksum 0xfdb324df, Offset: 0x3ca
// Size: 0x18
function start()
{
    activity_instance = self;
    activity_instance setup_ui_widget();
}

// Namespace namespace_a5a87f7f1400855e
// Params 0
// Checksum 0xa0f30f43, Offset: 0x3ea
// Size: 0xa1
function infil_main()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    level utility::flag_wait( "story_mission_party_check_complete" );
    thread function_4581cafa455d71af();
    level thread infil_chyron();
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "infil_waypoint_org", undefined, "infil_waypoint_org_waypoint_done", undefined, undefined, 1 );
    level thread mp_sat_ob_libra_util::function_776ea74dd9e92d46( "flag_infil_done", "infil_waypoint_org" );
    level thread infil_exit_door();
    level thread mp_sat_ob_libra_vo::libra_infil();
    utility::delaythread( 10, &mp_sat_ob_libra_util::show_hint_toast, "hint_bubble_shield", &"sat_ob/hint_bubble_shield_kbm", &"sat_ob/hint_bubble_shield_gamepad" );
    level waittill( #"flag_infil_done" );
}

// Namespace namespace_a5a87f7f1400855e
// Params 0
// Checksum 0x825039d4, Offset: 0x493
// Size: 0x136
function function_4581cafa455d71af()
{
    thread ob_story_mission_utils::item_spawn_weapon( "s_weapon_libra_intro", "flag_igc_answers_done", 1 );
    thread ob_story_mission_utils::item_spawn_equipment( "s_equip_libra_intro", "flag_igc_answers_done", 1 );
    thread ob_story_mission_utils::function_e6799e9a19df2365( "supply_cache_libra_intro" );
    ability_cases = utility::getstructarray( "analysis_ability_struct", "targetname" );
    i = 0;
    
    foreach ( case_struct in ability_cases )
    {
        switch ( i )
        {
            case 0:
                thread ob_item_select::function_95f9ecc2af4693f6( case_struct.origin, "super_war_machine", "super_annihilator", #"default" );
                break;
            case 1:
            case 2:
            case 3:
            case 4:
                break;
        }
        
        i++;
    }
}

// Namespace namespace_a5a87f7f1400855e
// Params 0
// Checksum 0xcda9e966, Offset: 0x5d1
// Size: 0x10
function infil_chyron()
{
    wait 2;
    level thread chyron::function_d41002779543c80e();
}

// Namespace namespace_a5a87f7f1400855e
// Params 1
// Checksum 0xdd6a3f12, Offset: 0x5e9
// Size: 0x2b
function handle_objectives( activity_name )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    setup_ui_widget();
}

// Namespace namespace_a5a87f7f1400855e
// Params 0
// Checksum 0x60c9ccd, Offset: 0x61c
// Size: 0x45
function infil_exit_door()
{
    trigger = getent( "infil_exit_door", "script_noteworthy" );
    
    if ( isdefined( trigger ) )
    {
        trigger waittill( #"opening" );
        level utility::flag_set( "flag_infil_door_opened" );
        level thread nozzles();
    }
}

// Namespace namespace_a5a87f7f1400855e
// Params 0
// Checksum 0x1ee6bf7d, Offset: 0x669
// Size: 0x20
function nozzles()
{
    utility::exploder( "analysis_nozzles" );
    wait 5;
    utility::stop_exploder( "analysis_nozzles" );
}

