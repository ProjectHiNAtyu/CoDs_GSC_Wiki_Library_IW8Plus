// script_566a61b853aadf08  (hash_566a61b853aadf08.gscc) (size: 1821 Bytes / 0x71d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x55ba1c19 (1438260249)
// size ...... 1821 (0x71d)
// includes .. 7   (offset: 0x6a9)
// strings ... 3   (offset: 0x6e1)
// dev strs .. 0   (offset: 0x71d)
// exports ... 11  (offset: 0x2f1)
// cseg ...... 0xb5 + 0x23c (0x2f1)
// imports ... 18  (offset: 0x4a9)
// animtree1 . 0   (offset: 0x71d)
// animtree2 . 0   (offset: 0x71d)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob_gametype_story_mission;

#namespace namespace_9d9702cdfa2bc07c;

/#

    // Namespace namespace_9d9702cdfa2bc07c
    // Params 0
    // Checksum 0x3e12cf22, Offset: 0xd3
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_9d9702cdfa2bc07c
// Params 0, eflags: 0x5
// Checksum 0xdd936ecb, Offset: 0xe0
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_f746c4e917de3d31", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_9d9702cdfa2bc07c
// Params 0, eflags: 0x4
// Checksum 0x8d592d0d, Offset: 0x109
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LIBRA_APPROACH";
    activity_common::registeractivitytype( "OB_LIBRA_APPROACH", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_APPROACH", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_APPROACH", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LIBRA_APPROACH", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_9d9702cdfa2bc07c
// Params 0
// Checksum 0xbbfae4aa, Offset: 0x16a
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

// Namespace namespace_9d9702cdfa2bc07c
// Params 0
// Checksum 0xef3c6a6, Offset: 0x1cf
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

// Namespace namespace_9d9702cdfa2bc07c
// Params 0
// Checksum 0xa32554dd, Offset: 0x21e
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_9d9702cdfa2bc07c
// Params 0
// Checksum 0x7348439f, Offset: 0x242
// Size: 0xe
function setup_ui_widget()
{
    ob_story_mission_utils::objective_text_show( "OB_LIBRA_APPROACH" );
}

/#

    // Namespace namespace_9d9702cdfa2bc07c
    // Params 0
    // Checksum 0x79a86b32, Offset: 0x258
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_9d9702cdfa2bc07c
// Params 0
// Checksum 0xfa8c6e53, Offset: 0x265
// Size: 0x18
function setup()
{
    activity_instance = self;
    activity_instance setup_ui_widget();
}

// Namespace namespace_9d9702cdfa2bc07c
// Params 0
// Checksum 0x8d1a1fde, Offset: 0x285
// Size: 0x6c
function main()
{
    options = spawnstruct();
    options.structs = ob_story_mission_utils::get_activity_starts( "OB_LIBRA_APPROACH" );
    options.timeout = 104;
    options.countdown = 0;
    options.fadestartnone = 1;
    coop::play_cinematic( "sat_libra_offshore_approach", options );
    utility::flag_set( "flat_sat_libra_offshore_approach_done" );
}

