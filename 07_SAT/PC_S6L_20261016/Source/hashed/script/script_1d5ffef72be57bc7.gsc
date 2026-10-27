// script_1d5ffef72be57bc7  (hash_1d5ffef72be57bc7.gscc) (size: 2062 Bytes / 0x80e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7263dea3 (1919147683)
// size ...... 2062 (0x80e)
// includes .. 7   (offset: 0x766)
// strings ... 7   (offset: 0x79e)
// dev strs .. 0   (offset: 0x80e)
// exports ... 10  (offset: 0x38e)
// cseg ...... 0xfd + 0x291 (0x38e)
// imports ... 20  (offset: 0x51e)
// animtree1 . 0   (offset: 0x80e)
// animtree2 . 0   (offset: 0x80e)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_virgo\mp_sat_ob_virgo_util;

#namespace namespace_1a60f2ff58b06302;

/#

    // Namespace namespace_1a60f2ff58b06302
    // Params 0
    // Checksum 0x9c896c5c, Offset: 0x11b
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_1a60f2ff58b06302
// Params 0, eflags: 0x5
// Checksum 0x43b717a0, Offset: 0x128
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_3b7f6ac5550008c5", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_1a60f2ff58b06302
// Params 0, eflags: 0x4
// Checksum 0x6d2c3d0b, Offset: 0x151
// Size: 0x59
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_VIRGO_VOID_ROOM_2";
    activity_common::registeractivitytype( "OB_VIRGO_VOID_ROOM_2", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_VOID_ROOM_2", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_VOID_ROOM_2", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_VIRGO_VOID_ROOM_2", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_1a60f2ff58b06302
// Params 0
// Checksum 0xe1fa25be, Offset: 0x1b2
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance function_fd8fabf0c26dd760();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_1a60f2ff58b06302
// Params 0
// Checksum 0x3a01cad2, Offset: 0x217
// Size: 0x32
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance function_b82b669b10d6af9();
}

// Namespace namespace_1a60f2ff58b06302
// Params 0
// Checksum 0x1bef7a3, Offset: 0x251
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

/#

    // Namespace namespace_1a60f2ff58b06302
    // Params 0
    // Checksum 0xdb33c84c, Offset: 0x275
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_1a60f2ff58b06302
// Params 0
// Checksum 0x263b675e, Offset: 0x282
// Size: 0xa
function function_fd8fabf0c26dd760()
{
    level thread ob_virgo_util::carrier_exploders();
}

// Namespace namespace_1a60f2ff58b06302
// Params 0
// Checksum 0x5660d6b1, Offset: 0x294
// Size: 0xfa
function function_b82b669b10d6af9()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    var_bc6c5faff1e3941b = 0;
    jet = getent( "script_carrier_jet", "targetname" );
    
    if ( isdefined( jet ) )
    {
        jet hide();
    }
    
    /#
        if ( getdvarint( @"hash_ad1035a2bb2f79c6", 0 ) )
        {
            var_bc6c5faff1e3941b = 1;
        }
    #/
    
    struct = utility::getstruct( "struct_scene_virgo_betrayal", "targetname" );
    wait 3;
    
    if ( !var_bc6c5faff1e3941b )
    {
        struct scene::play();
    }
    
    var_63b52a0bc1c0f3bf = utility::getstruct( "struct_scene_boss_intro", "targetname" );
    var_63b52a0bc1c0f3bf scene::play();
    
    if ( isdefined( jet ) )
    {
        jet show();
    }
    
    outro_struct = utility::getstruct( "struct_boss_outro", "targetname" );
    outro_struct scene::play();
    activity_instance_common::endactivity( self, 1 );
    level thread ob_virgo_util::virgo_teleport_players( "OB_VIRGO_CARRIER_INTRO" );
}

