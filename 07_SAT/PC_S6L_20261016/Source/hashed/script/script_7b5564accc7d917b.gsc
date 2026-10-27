// script_7b5564accc7d917b  (hash_7b5564accc7d917b.gscc) (size: 1964 Bytes / 0x7ac / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x72d23eaf (1926381231)
// size ...... 1964 (0x7ac)
// includes .. 8   (offset: 0x718)
// strings ... 5   (offset: 0x758)
// dev strs .. 0   (offset: 0x7ac)
// exports ... 11  (offset: 0x340)
// cseg ...... 0xcc + 0x274 (0x340)
// imports ... 19  (offset: 0x4f8)
// animtree1 . 0   (offset: 0x7ac)
// animtree2 . 0   (offset: 0x7ac)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_libra\mp_sat_ob_libra_util;

#namespace namespace_35311ba0edc1a297;

/#

    // Namespace namespace_35311ba0edc1a297
    // Params 0
    // Checksum 0x29f8adc9, Offset: 0xea
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_35311ba0edc1a297
// Params 0, eflags: 0x5
// Checksum 0x31a2cf96, Offset: 0xf7
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_8a4268281bf974d2", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_35311ba0edc1a297
// Params 0, eflags: 0x4
// Checksum 0xb318a6c9, Offset: 0x120
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LIBRA_IGC_BOSS_OUTRO";
    activity_common::registeractivitytype( "OB_LIBRA_IGC_BOSS_OUTRO", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_IGC_BOSS_OUTRO", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_IGC_BOSS_OUTRO", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_IGC_BOSS_OUTRO", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_35311ba0edc1a297
// Params 0
// Checksum 0x5bec0c14, Offset: 0x181
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance setup();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_35311ba0edc1a297
// Params 0
// Checksum 0xeee52e18, Offset: 0x1e6
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

// Namespace namespace_35311ba0edc1a297
// Params 0
// Checksum 0xb4cf3636, Offset: 0x235
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_35311ba0edc1a297
// Params 0
// Checksum 0xbaf5420e, Offset: 0x259
// Size: 0xe
function setup_ui_widget()
{
    ob_story_mission_utils::objective_text_show( "OB_LIBRA_IGC_BOSS_OUTRO" );
}

/#

    // Namespace namespace_35311ba0edc1a297
    // Params 0
    // Checksum 0x6e4209d9, Offset: 0x26f
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_35311ba0edc1a297
// Params 0
// Checksum 0x1a9a86ed, Offset: 0x27c
// Size: 0x18
function setup()
{
    activity_instance = self;
    activity_instance setup_ui_widget();
}

// Namespace namespace_35311ba0edc1a297
// Params 0
// Checksum 0xcf5dd6df, Offset: 0x29c
// Size: 0xa4
function main()
{
    level thread mp_sat_ob_libra_util::function_cf3e18e44adf3387( 0 );
    options = spawnstruct();
    options.structs = ob_story_mission_utils::get_activity_starts( "OB_LIBRA_IGC_BOSS_OUTRO" );
    options.timeout = 167;
    options.countdown = -1;
    options.fadestartshader = "black";
    options.fadestartnone = 1;
    options.fadestarthold = 0.1;
    utility::flag_set( "flag_igc_boss_outro_start" );
    coop::play_cinematic( "sat_libra_boss_outro", options );
    utility::flag_set( "flag_igc_boss_outro_end" );
}

