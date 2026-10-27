// script_4d6ddd547bcd9399  (hash_4d6ddd547bcd9399.gscc) (size: 6629 Bytes / 0x19e5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x17ed0be2 (401411042)
// size ...... 6629 (0x19e5)
// includes .. 15  (offset: 0x172d)
// strings ... 41  (offset: 0x17a5)
// dev strs .. 0   (offset: 0x19e5)
// exports ... 15  (offset: 0xdc5)
// cseg ...... 0x448 + 0x97d (0xdc5)
// imports ... 60  (offset: 0x101d)
// animtree1 . 0   (offset: 0x19e5)
// animtree2 . 0   (offset: 0x19e5)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\scriptable_door_utility;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_lighting;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_util;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_vo;
#using scripts\mp\ob\systems\ob_item_select;
#using scripts\mp\snd\snd_ob;

#namespace namespace_eee6457f670d8545;

/#

    // Namespace namespace_eee6457f670d8545
    // Params 0
    // Checksum 0xa3348a1b, Offset: 0x466
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_eee6457f670d8545
// Params 0, eflags: 0x5
// Checksum 0xfde9d40f, Offset: 0x473
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_660c0da0b6a8e018", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_eee6457f670d8545
// Params 0, eflags: 0x4
// Checksum 0x3e78842d, Offset: 0x49c
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LIBRA_IGC_PROCESSING";
    activity_common::registeractivitytype( "OB_LIBRA_IGC_PROCESSING", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_IGC_PROCESSING", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_IGC_PROCESSING", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_IGC_PROCESSING", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_eee6457f670d8545
// Params 0
// Checksum 0x809280f8, Offset: 0x4fd
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

// Namespace namespace_eee6457f670d8545
// Params 0
// Checksum 0x8fffa14b, Offset: 0x562
// Size: 0x47
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    activity_instance main();
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_eee6457f670d8545
// Params 0
// Checksum 0x3e0311e4, Offset: 0x5b1
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_eee6457f670d8545
// Params 0
// Checksum 0xdc43c86b, Offset: 0x5d5
// Size: 0xe
function setup_ui_widget()
{
    ob_story_mission_utils::objective_text_show( "OB_LIBRA_IGC_PROCESSING" );
}

/#

    // Namespace namespace_eee6457f670d8545
    // Params 0
    // Checksum 0xe48e2e0b, Offset: 0x5eb
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_eee6457f670d8545
// Params 0
// Checksum 0x251c6586, Offset: 0x5f8
// Size: 0x98
function start()
{
    activity_instance = self;
    activity_instance setup_ui_widget();
    thread mp_sat_ob_libra_lighting::function_2bd21e5bfd850bd0();
    level thread function_95136d109ab3ceb8();
    level thread mp_sat_ob_libra_util::function_9886d86be8c62744();
    level.var_7c60caafb0bb3790 = utility::getstruct( "tag_align_processing_center" );
    level.var_7c60caafb0bb3790 scene::add_spawn_function( &mp_sat_ob_libra_util::fire_custom, "fiftyfifty" );
    level.var_7c60caafb0bb3790 scene::add_spawn_function( &mp_sat_ob_libra_util::fire_custom, "enemy01" );
    level.var_7c60caafb0bb3790 scene::pre_stream( undefined, undefined, -1, "scene_sat_cin_libra_processing_center" );
    level thread function_fea33e63d0f156d1();
}

// Namespace namespace_eee6457f670d8545
// Params 0
// Checksum 0xafea32b2, Offset: 0x698
// Size: 0xc5
function function_fea33e63d0f156d1()
{
    assets = [];
    distances = [];
    assets[ assets.size ] = "xcomp_c_sat_usa_pl_red_proto";
    distances[ distances.size ] = 50;
    
    foreach ( player in level.players )
    {
        player thread utility::player_prestream_assets( "libra_igc_processing", "model", assets, distances, -1 );
    }
    
    level thread mp_sat_ob_libra_util::function_51599a610d3dc9af( "libra_igc_processing", "flag_igc_processing_done" );
}

// Namespace namespace_eee6457f670d8545
// Params 0
// Checksum 0xb8ec4419, Offset: 0x765
// Size: 0x4c7
function main()
{
    activity_instance = self;
    activity_instance setup_ui_widget();
    trigger = getent( "processing_main_door", #script_noteworthy );
    
    if ( isdefined( trigger ) )
    {
        trigger thread scriptable_door_utility::simple_lock_door();
    }
    
    thread mp_sat_ob_libra_util::function_7c6f64dfa8ae940c();
    thread mp_sat_ob_libra_util::function_3404036aa1432445( "proc_pump_room_door" );
    thread mp_sat_ob_libra_util::function_2bc2cecd260a5613( [ "hoist_interact_scene_a", "hoist_interact_scene_b" ] );
    mp_sat_ob_libra_util::function_c58a10af89e58f3f( "enter_processing", "processing_door_interacted", &"sat_ob_story_missions/interact_unlock" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "igc_processing_waypoint_org", undefined, "igc_processing_waypoint_org_waypoint_done", undefined, undefined, 1, undefined, undefined, undefined, undefined, undefined, undefined, ( 0, 0, 16 ) );
    level thread mp_sat_ob_libra_util::function_776ea74dd9e92d46( "processing_door_interacted", "igc_processing_waypoint_org" );
    utility::flag_wait( "processing_door_interacted" );
    
    if ( ob::nightmare() )
    {
        level thread ob_story_mission_utils::function_ecbb860d6714e9f3( 0, 0 );
    }
    
    options = spawnstruct();
    options.triggertargetname = "igc_processing_regroup_trigger";
    options.flag_countdown = "start_processing";
    igc_processing_regroup_org = utility::getstruct( "igc_processing_regroup_org" );
    level thread snd_ob::function_70013396bb42f6cc( level.players, "sat_libra_igc_processing_center" );
    
    if ( isdefined( igc_processing_regroup_org ) )
    {
        options.var_ba7c3b8fa9d3823 = igc_processing_regroup_org;
    }
    
    coop::function_164d95b45992525( options );
    function_d21cd9ec01b2df47( 200, "WorldAndHud", ( 0, 0, 0 ) );
    wait 0.25;
    
    foreach ( player in level.players )
    {
        player notify( #"exit" );
    }
    
    if ( isdefined( level.var_9aa249948cb5092d ) )
    {
        foreach ( interact in level.var_9aa249948cb5092d )
        {
            interact makeunusable();
        }
        
        level.var_9aa249948cb5092d = undefined;
    }
    
    level thread mp_sat_ob_libra_util::function_32b80bf22f39a811( "processing_fan", "roll", 2, "flag_boss_intro_regroup_countdown_finished", %"electronics_fan_box_lg_01_blade" );
    deactivateworldevent( "VFX_Libra_Labs_Calm_Ambient" );
    hatch_door_a = getent( "hatch_door_a", #targetname );
    
    if ( isdefined( hatch_door_a ) )
    {
        hatch_door_a hide();
    }
    
    hatch_door_b = getent( "hatch_door_b", #targetname );
    
    if ( isdefined( hatch_door_b ) )
    {
        hatch_door_b hide();
    }
    
    cradle_sphere_pipe = getent( "cradle_sphere_pipe", #targetname );
    
    if ( isdefined( cradle_sphere_pipe ) )
    {
        cradle_sphere_pipe hide();
    }
    
    cradle_sphere = getent( "cradle_sphere", #targetname );
    
    if ( isdefined( cradle_sphere ) )
    {
        cradle_sphere hide();
    }
    
    level thread mp_sat_ob_libra_util::function_96910d9608e728ce( "processing_main_door", #script_noteworthy, 1 );
    ob_story_mission_utils::function_f20a9fe6c594f5b3( 1 );
    ob_story_mission_utils::function_2686bb512b355040( "OB_LIBRA_PROCESSING_DOORS" );
    level thread mp_sat_ob_libra_vo::function_f89e87cea1bfa588();
    level thread lock_entrance_door();
    
    if ( isdefined( level.var_7c60caafb0bb3790 ) )
    {
        utility::flag_set( "flag_igc_processing_start" );
        level.var_7c60caafb0bb3790 scene::play( undefined, undefined, "scene_sat_cin_libra_processing_center" );
    }
    
    hatch_door_a = getent( "hatch_door_a", #targetname );
    
    if ( isdefined( hatch_door_a ) )
    {
        hatch_door_a show();
    }
    
    hatch_door_b = getent( "hatch_door_b", #targetname );
    
    if ( isdefined( hatch_door_b ) )
    {
        hatch_door_b show();
    }
    
    cradle_sphere_pipe = getent( "cradle_sphere_pipe", #targetname );
    
    if ( isdefined( cradle_sphere_pipe ) )
    {
        cradle_sphere_pipe show();
    }
    
    cradle_sphere = getent( "cradle_sphere", #targetname );
    
    if ( isdefined( cradle_sphere ) )
    {
        cradle_sphere show();
    }
    
    level thread mp_sat_ob_libra_util::function_96910d9608e728ce( "processing_main_door", #script_noteworthy, 0 );
    thread mp_sat_ob_libra_util::function_3404036aa1432445( "processing_alt_door", 1, 0, 1 );
    function_2fd33a3b1faebfe0();
    ob_story_mission_utils::function_2686bb512b355040( "OB_LIBRA_PROCESSING_DOORS" );
    utility::flag_set( "flag_igc_processing_done" );
    ob_story_mission_utils::function_f20a9fe6c594f5b3( 0 );
    level thread snd_ob::function_52bc8194809997e8( level.players, "sat_libra_igc_processing_center" );
    waitframe();
    
    if ( ob::nightmare() )
    {
        level thread ob_story_mission_utils::function_ecbb860d6714e9f3( 1, 1, 0.25 );
    }
}

// Namespace namespace_eee6457f670d8545
// Params 0
// Checksum 0x51b4f17, Offset: 0xc34
// Size: 0x3c
function lock_entrance_door()
{
    level waittill( #"hash_ba2baa092707a611" );
    trigger = getent( "processing_main_door", #script_noteworthy );
    
    if ( isdefined( trigger ) )
    {
        trigger scriptable_door_utility::simple_lock_door();
    }
}

// Namespace namespace_eee6457f670d8545
// Params 0
// Checksum 0x528bee9f, Offset: 0xc78
// Size: 0x116
function function_2fd33a3b1faebfe0()
{
    thread ob_story_mission_utils::item_spawn_weapon( "s_weapon_processing", "flag_igc_boss_intro_done" );
    ability_cases = utility::getstructarray( "ability_struct_processing", "targetname" );
    i = 0;
    
    foreach ( case_struct in ability_cases )
    {
        switch ( i )
        {
            case 0:
                thread ob_item_select::function_95f9ecc2af4693f6( case_struct.origin, "super_bubble_shield", "super_war_machine", #"default" );
                break;
            case 1:
                thread ob_item_select::function_95f9ecc2af4693f6( case_struct.origin, "super_overcharge", "super_black_hat", #"tactical" );
                break;
        }
        
        i++;
    }
}

// Namespace namespace_eee6457f670d8545
// Params 0
// Checksum 0x20cd5378, Offset: 0xd96
// Size: 0x2f
function function_95136d109ab3ceb8()
{
    processing_alt_door = getent( "processing_alt_door", #script_noteworthy );
    
    if ( isdefined( processing_alt_door ) )
    {
        processing_alt_door thread scriptable_door_utility::simple_lock_door();
    }
}

