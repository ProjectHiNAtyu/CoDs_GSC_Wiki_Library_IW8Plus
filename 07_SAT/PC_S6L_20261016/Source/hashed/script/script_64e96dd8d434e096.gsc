// script_64e96dd8d434e096  (hash_64e96dd8d434e096.gscc) (size: 2968 Bytes / 0xb98 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x691b7293 (1763406483)
// size ...... 2968 (0xb98)
// includes .. 9   (offset: 0xaf0)
// strings ... 6   (offset: 0xb38)
// dev strs .. 0   (offset: 0xb98)
// exports ... 13  (offset: 0x5c4)
// cseg ...... 0xe5 + 0x4df (0x5c4)
// imports ... 28  (offset: 0x7cc)
// animtree1 . 0   (offset: 0xb98)
// animtree2 . 0   (offset: 0xb98)
#using script_3edd59d0d3fc3262;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\maps\mp_sat_ob_leo\mp_sat_ob_leo_util;
#using scripts\mp\operator;

#namespace namespace_11b0800b3830b4c0;

/#

    // Namespace namespace_11b0800b3830b4c0
    // Params 0
    // Checksum 0xfc09bb9e, Offset: 0x103
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace namespace_11b0800b3830b4c0
// Params 0, eflags: 0x5
// Checksum 0x147e254e, Offset: 0x110
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_f85c5b063f9d114d", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_11b0800b3830b4c0
// Params 0, eflags: 0x4
// Checksum 0x2f5dac8c, Offset: 0x139
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_LEO_FACILITY_INTRO_IGC";
    activity_common::registeractivitytype( "OB_LEO_FACILITY_INTRO_IGC", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_LEO_FACILITY_INTRO_IGC", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_LEO_FACILITY_INTRO_IGC", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_LEO_FACILITY_INTRO_IGC", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_LEO_FACILITY_INTRO_IGC" );
}

// Namespace namespace_11b0800b3830b4c0
// Params 0
// Checksum 0x3cf1ca7e, Offset: 0x1b0
// Size: 0x5d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance function_61663271f4581fab();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_11b0800b3830b4c0
// Params 0
// Checksum 0x5e4e2b38, Offset: 0x215
// Size: 0x3d
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    activity_instance thread function_984019600b425c();
}

// Namespace namespace_11b0800b3830b4c0
// Params 0
// Checksum 0x613e2061, Offset: 0x25a
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_11b0800b3830b4c0
// Params 1
// Checksum 0xcfca1cc5, Offset: 0x27e
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread player_setup( player );
    }
}

/#

    // Namespace namespace_11b0800b3830b4c0
    // Params 0
    // Checksum 0xbbb31f8e, Offset: 0x33a
    // Size: 0x5, Type: dev
    function function_7b253d2a921e4cbd()
    {
        
    }

#/

// Namespace namespace_11b0800b3830b4c0
// Params 1
// Checksum 0x9a20551f, Offset: 0x347
// Size: 0x20
function player_setup( player )
{
    activity_instance = self;
    prestream_operator_skins();
}

// Namespace namespace_11b0800b3830b4c0
// Params 0, eflags: 0x4
// Checksum 0xfb6aba0c, Offset: 0x36f
// Size: 0x12e
function private prestream_operator_skins()
{
    var_a2684dedbb3accf6 = [];
    
    foreach ( player in level.players )
    {
        var_c94fe7a52bb293af = player function_66df206dec9fe1ae();
        models = operator::function_fb2ad6ca3c6b708d( var_c94fe7a52bb293af );
        var_a2684dedbb3accf6 = arraycombine( var_a2684dedbb3accf6, models );
    }
    
    if ( var_a2684dedbb3accf6.size > 0 )
    {
        foreach ( player in level.players )
        {
            player thread utility::player_prestream_assets( "leo_facility_intro", "model", var_a2684dedbb3accf6, undefined, -1 );
        }
    }
}

// Namespace namespace_11b0800b3830b4c0
// Params 0
// Checksum 0x79ac0357, Offset: 0x4a5
// Size: 0x10
function function_61663271f4581fab()
{
    thread mp_sat_ob_leo_util::function_96b32ff9e4b0fc4c();
    thread mp_sat_ob_leo_util::function_d2eaefb295692571();
}

// Namespace namespace_11b0800b3830b4c0
// Params 0
// Checksum 0x71859fc8, Offset: 0x4bd
// Size: 0x107
function function_984019600b425c()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    if ( !getdvarint( @"hash_8654b7e8fa452fff", 0 ) )
    {
        coop::play_cinematic( "sat_cin_leo_guild_facility_intro", { #timeout:97, #countdown:0, #fadestartnone:1 } );
    }
    
    foreach ( player in level.players )
    {
        player utility::player_prestream_clear( "leo_facility_intro" );
    }
    
    level utility::flag_set( "facility_intro_igc_complete" );
    story_contract_util::mark_complete( level.players, #"leo_launch" );
    activity_instance_common::endactivity( self, 1 );
}

