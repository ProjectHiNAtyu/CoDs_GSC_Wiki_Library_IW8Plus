// script_e47d749d0b3a590  (hash_0e47d749d0b3a590.gscc) (size: 2050 Bytes / 0x802 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4d222781 (1294083969)
// size ...... 2050 (0x802)
// includes .. 8   (offset: 0x742)
// strings ... 8   (offset: 0x782)
// dev strs .. 1   (offset: 0x7f6)
// exports ... 8   (offset: 0x3a6)
// cseg ...... 0xf6 + 0x2b0 (0x3a6)
// imports ... 21  (offset: 0x4e6)
// animtree1 . 0   (offset: 0x802)
// animtree2 . 0   (offset: 0x802)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\gametypes\br_publicevent_firesale;
#using scripts\mp\br\gametypes\br_publicevents;

#namespace namespace_ccf0371d4d0bee14;

// Namespace namespace_ccf0371d4d0bee14
// Params 0, eflags: 0x5
// Checksum 0x99d74c3e, Offset: 0x114
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_c0c31baab074985b", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_ccf0371d4d0bee14
// Params 0, eflags: 0x4
// Checksum 0x7c330708, Offset: 0x13d
// Size: 0x28
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BR_PUBLIC_EVENT_FIRESALE", &activity_type_init );
    br_publicevents::function_54d95495df246a2b( getxhashasset( "BR_PUBLIC_EVENT_FIRESALE" ), &function_323fab1b62a2d5d4 );
}

// Namespace namespace_ccf0371d4d0bee14
// Params 1
// Checksum 0xbab9dc1d, Offset: 0x16d
// Size: 0x2e
function function_323fab1b62a2d5d4( eventinfo )
{
    eventinfo.canactivatefunc = &br_publicevent_firesale::canactivatefunc;
    eventinfo.waitfunc = &br_publicevent_firesale::waitfunc;
}

// Namespace namespace_ccf0371d4d0bee14
// Params 0
// Checksum 0xf79a2c59, Offset: 0x1a3
// Size: 0x70
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_FIRESALE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_FIRESALE", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_FIRESALE", 3, &function_d4acef179eb9f9b2 );
    assert( isdefined( game[ "<dev string:x24>" ] ) );
    game[ "dialog" ][ "public_events_firesale_start" ] = "pblc_wzan_frsc";
    game[ "dialog" ][ "public_events_firesale_end" ] = "pblc_wzan_frsn";
}

// Namespace namespace_ccf0371d4d0bee14
// Params 0
// Checksum 0x1a54316c, Offset: 0x21b
// Size: 0x32
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_ccf0371d4d0bee14
// Params 0
// Checksum 0xeaa82528, Offset: 0x255
// Size: 0xc7
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    callback::callback( #"hash_dd36ab548337dd9a", { #objectivestate:"firesale" } );
    
    if ( isdefined( level.var_65f58b7fd405d30b ) )
    {
        [[ level.var_65f58b7fd405d30b ]]();
    }
    
    level notify( #"public_event_firesale_start" );
    thread br_publicevent_firesale::function_bb2df381fb948e27( 1 );
    level.br_pe_data[ %"firesale" ] = { #active:1 };
    eventduration = namespace_9085ae059032a84f::function_9129cd8075c85c09( self ).duration;
    br_activity_util::function_f255dbc3d969ce02( eventduration, 1 );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_ccf0371d4d0bee14
// Params 0
// Checksum 0xd889c0a3, Offset: 0x324
// Size: 0x82
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    callback::callback( #"hash_dd36ab548337dd9a", { #objectivestate:"active" } );
    
    if ( isdefined( level.var_3317f1328e7e9df3 ) )
    {
        [[ level.var_3317f1328e7e9df3 ]]();
    }
    
    level notify( #"public_event_firesale_end" );
    thread br_publicevent_firesale::function_bb2df381fb948e27( 0 );
    level.br_pe_data[ %"firesale" ] = undefined;
    br_activity_util::function_f24cad5d113f4f52();
}

