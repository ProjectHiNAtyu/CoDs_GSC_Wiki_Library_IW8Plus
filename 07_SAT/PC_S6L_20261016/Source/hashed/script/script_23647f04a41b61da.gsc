// script_23647f04a41b61da  (hash_23647f04a41b61da.gscc) (size: 2072 Bytes / 0x818 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xab28f9d (179474333)
// size ...... 2072 (0x818)
// includes .. 8   (offset: 0x760)
// strings ... 8   (offset: 0x7a0)
// dev strs .. 0   (offset: 0x818)
// exports ... 11  (offset: 0x36c)
// cseg ...... 0x11f + 0x24d (0x36c)
// imports ... 20  (offset: 0x524)
// animtree1 . 0   (offset: 0x818)
// animtree2 . 0   (offset: 0x818)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_util;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_vo;

#namespace namespace_1a60f1ff58b060cf;

/#

    // Namespace namespace_1a60f1ff58b060cf
    // Params 0
    // Checksum 0x9c896f91, Offset: 0x13d
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_1a60f1ff58b060cf
// Params 0, eflags: 0x5
// Checksum 0xdabe4ebe, Offset: 0x14a
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_3b7f67c5550003ac", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_1a60f1ff58b060cf
// Params 0, eflags: 0x4
// Checksum 0x6d2c3ec6, Offset: 0x173
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_VIRGO_VOID_ROOM_1";
    activity_common::registeractivitytype( "OB_VIRGO_VOID_ROOM_1", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_VOID_ROOM_1", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_VOID_ROOM_1", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_VOID_ROOM_1", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_1a60f1ff58b060cf
// Params 0
// Checksum 0x491b6d54, Offset: 0x1d4
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance function_d9e8e80e629a7a91();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_1a60f1ff58b060cf
// Params 0
// Checksum 0x259cea0b, Offset: 0x239
// Size: 0x32
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance function_31a5423fe3be5452();
}

// Namespace namespace_1a60f1ff58b060cf
// Params 0
// Checksum 0x1bef46e, Offset: 0x273
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

/#

    // Namespace namespace_1a60f1ff58b060cf
    // Params 0
    // Checksum 0xdb33cb81, Offset: 0x297
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_1a60f1ff58b060cf
// Params 0
// Checksum 0x49420ba7, Offset: 0x2a4
// Size: 0x1c
function function_d9e8e80e629a7a91()
{
    level thread utility::exploder( "fx_freeway_crashsite" );
    level thread utility::exploder( "fx_freeway_crashsite_bc" );
}

// Namespace namespace_1a60f1ff58b060cf
// Params 0
// Checksum 0x8bf645f2, Offset: 0x2c8
// Size: 0x5f
function function_31a5423fe3be5452()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    wait 3;
    struct = utility::getstruct( "struct_scene_void_1", "targetname" );
    
    if ( isdefined( struct ) )
    {
        struct scene::play();
    }
    
    activity_instance_common::endactivity( self, 1 );
    level thread ob_virgo_util::virgo_teleport_players( "OB_VIRGO_JAPAN_INTRO" );
}

// Namespace namespace_1a60f1ff58b060cf
// Params 0
// Checksum 0x7bf7a9, Offset: 0x32f
// Size: 0x3d
function function_297f339f3572d514()
{
    thread ob_virgo_util::function_70674852bcdd6cd3( "struct_virgo_void_room_1_end", "flag_virgo_void_room_1_done", &"sat_ob_story_missions/virgo_interact_upload" );
    level virgo_vo::function_8d45fc2fb5f863eb();
    ob_virgo_util::setup_ui_widget( "OB_VIRGO_VOID_ROOM_1" );
    level utility::flag_wait( "flag_virgo_void_room_1_done" );
}

