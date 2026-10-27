// script_38b1fdddff7cdad3  (hash_38b1fdddff7cdad3.gscc) (size: 3905 Bytes / 0xf41 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb06cf637 (2959930935)
// size ...... 3905 (0xf41)
// includes .. 11  (offset: 0xdad)
// strings ... 19  (offset: 0xe05)
// dev strs .. 0   (offset: 0xf41)
// exports ... 15  (offset: 0x719)
// cseg ...... 0x211 + 0x508 (0x719)
// imports ... 37  (offset: 0x971)
// animtree1 . 0   (offset: 0xf41)
// animtree2 . 0   (offset: 0xf41)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_util;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_vo;
#using scripts\mp\snd\snd_ob;

#namespace namespace_fcc50569ce051cc1;

/#

    // Namespace namespace_fcc50569ce051cc1
    // Params 0
    // Checksum 0xa3c139f, Offset: 0x22f
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_fcc50569ce051cc1
// Params 0, eflags: 0x5
// Checksum 0xc79a34a0, Offset: 0x23c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_671b60a1736a711a", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_fcc50569ce051cc1
// Params 0, eflags: 0x4
// Checksum 0xdee569af, Offset: 0x265
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LIBRA_IGC_ANSWERS";
    activity_common::registeractivitytype( "OB_LIBRA_IGC_ANSWERS", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_IGC_ANSWERS", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_IGC_ANSWERS", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_IGC_ANSWERS", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_fcc50569ce051cc1
// Params 0
// Checksum 0x7f23f155, Offset: 0x2c6
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

// Namespace namespace_fcc50569ce051cc1
// Params 0
// Checksum 0x50288101, Offset: 0x32b
// Size: 0x48
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    activity_instance igc_answers_main();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_fcc50569ce051cc1
// Params 0
// Checksum 0x970b8860, Offset: 0x37b
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_fcc50569ce051cc1
// Params 0
// Checksum 0xb1557d20, Offset: 0x39f
// Size: 0xe
function setup_ui_widget()
{
    ob_story_mission_utils::objective_text_show( "ob_libra_infil_analysis_investigate" );
}

/#

    // Namespace namespace_fcc50569ce051cc1
    // Params 0
    // Checksum 0x4d86b78f, Offset: 0x3b5
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_fcc50569ce051cc1
// Params 0
// Checksum 0xb134284c, Offset: 0x3c2
// Size: 0x20
function start()
{
    activity_instance = self;
    activity_instance setup_ui_widget();
    level thread igc_answers_pre_stream();
}

// Namespace namespace_fcc50569ce051cc1
// Params 0
// Checksum 0xeca40281, Offset: 0x3ea
// Size: 0x74
function igc_answers_main()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    level utility::flag_set( "flag_igc_answers_start" );
    deactivateworldevent( "VFX_Libra_Stor-Pak_Vista_Ambient" );
    
    if ( ob::nightmare() )
    {
        level thread ob_story_mission_utils::function_ecbb860d6714e9f3( 0, 0 );
    }
    
    level thread function_5ba8cc40907cdcf8();
    level utility::flag_wait( "flag_igc_answers_done" );
    waitframe();
    
    if ( ob::nightmare() )
    {
        level thread ob_story_mission_utils::function_ecbb860d6714e9f3( 1, 1, 0.25 );
    }
}

// Namespace namespace_fcc50569ce051cc1
// Params 1
// Checksum 0x27be4e4, Offset: 0x466
// Size: 0x118
function igc_answers_pre_stream( wait_flag_array )
{
    if ( isdefined( wait_flag_array ) )
    {
        level utility::flag_wait_all_array( wait_flag_array );
    }
    
    screen = getent( "answers_igc", "targetname" );
    
    if ( !isdefined( screen ) )
    {
        return;
    }
    
    tag_align_answers = utility::getstruct( "tag_align_answers" );
    tag_align_answers.script_scenescriptbundle = "scene_sat_cin_libra_answers";
    var_3a052fe5dd4b350e = [ screen.origin, screen.origin ];
    var_b9376415d6b959c5 = [ "facility_status::" + "sat_libra_electronics_monitor_screen_02_big", "manufacturing_status::" + "sat_libra_electronics_monitor_screen_02_big" ];
    tag_align_answers scene::function_110f292f4976d4fd( "shot_01", "model", var_b9376415d6b959c5, var_3a052fe5dd4b350e );
    var_3a052fe5dd4b350e = [ screen.origin ];
    var_b9376415d6b959c5 = [ "facility_status::" + "sat_libra_electronics_monitor_screen_02_big" ];
    tag_align_answers scene::function_110f292f4976d4fd( "shot_04", "model", var_b9376415d6b959c5, var_3a052fe5dd4b350e );
    tag_align_answers thread scene::pre_stream( undefined, undefined, -1, "scene_sat_cin_libra_answers" );
}

// Namespace namespace_fcc50569ce051cc1
// Params 1
// Checksum 0xb521346c, Offset: 0x586
// Size: 0xde
function function_5ba8cc40907cdcf8( player )
{
    ob_story_mission_utils::function_f20a9fe6c594f5b3( 1 );
    ob_story_mission_utils::function_2686bb512b355040( "OB_LIBRA_IGC_ANSWERS" );
    tag_align_answers = utility::getstruct( "tag_align_answers" );
    level thread mp_sat_ob_libra_util::function_96910d9608e728ce( "packing_exit_door", #script_noteworthy, 1 );
    level thread mp_sat_ob_libra_vo::function_18a76214127aea90();
    level thread function_be4f7a04a715833f();
    snd_ob::function_70013396bb42f6cc( level.players, "scene_sat_cin_libra_answers" );
    tag_align_answers scene::play( undefined, undefined, "scene_sat_cin_libra_answers" );
    snd_ob::function_52bc8194809997e8( level.players, "scene_sat_cin_libra_answers" );
    self notify( #"interacted" );
    ob_story_mission_utils::function_2686bb512b355040( "OB_LIBRA_IGC_ANSWERS" );
    level thread mp_sat_ob_libra_util::function_96910d9608e728ce( "packing_exit_door", #script_noteworthy, 0 );
    ob_story_mission_utils::function_f20a9fe6c594f5b3( 0 );
    level utility::flag_set( "flag_igc_answers_done" );
}

// Namespace namespace_fcc50569ce051cc1
// Params 0
// Checksum 0x72ee2b57, Offset: 0x66c
// Size: 0x84
function function_be4f7a04a715833f()
{
    screen = getent( "answers_igc", "targetname" );
    
    if ( !isdefined( screen ) )
    {
        return;
    }
    
    level waittill( #"screen_02" );
    mp_sat_ob_libra_util::function_bd1845bf5896dd1b( screen, "facility_status", "sat_libra_electronics_monitor_screen_02_big" );
    level waittill( #"screen_03" );
    mp_sat_ob_libra_util::function_bd1845bf5896dd1b( screen, "manufacturing_status", "sat_libra_electronics_monitor_screen_02_big" );
    level waittill( #"screen_01" );
    mp_sat_ob_libra_util::function_bd1845bf5896dd1b( screen, "processing_status", "sat_libra_electronics_monitor_screen_02_big" );
}

// Namespace namespace_fcc50569ce051cc1
// Params 0, eflags: 0x4
// Checksum 0x4c8c5318, Offset: 0x6f8
// Size: 0x21
function private facility_intro_objectives()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    setup_ui_widget();
}

