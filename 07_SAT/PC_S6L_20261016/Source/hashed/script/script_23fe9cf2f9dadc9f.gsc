// script_23fe9cf2f9dadc9f  (hash_23fe9cf2f9dadc9f.gscc) (size: 1693 Bytes / 0x69d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x45f89c06 (1173920774)
// size ...... 1693 (0x69d)
// includes .. 7   (offset: 0x635)
// strings ... 3   (offset: 0x66d)
// dev strs .. 0   (offset: 0x69d)
// exports ... 8   (offset: 0x2dd)
// cseg ...... 0xa8 + 0x235 (0x2dd)
// imports ... 19  (offset: 0x41d)
// animtree1 . 0   (offset: 0x69d)
// animtree2 . 0   (offset: 0x69d)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\mp\br\gametypes\br_jugg_common;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;

#namespace namespace_7fb762c489ce406f;

// Namespace namespace_7fb762c489ce406f
// Params 0, eflags: 0x5
// Checksum 0x67c2c8e, Offset: 0xc6
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_ffcd5eef595e85f8", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_7fb762c489ce406f
// Params 0, eflags: 0x4
// Checksum 0xab27a1b, Offset: 0xef
// Size: 0x28
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BR_PUBLIC_EVENT_JUGGERNAUT", &activity_type_init );
    br_publicevents::function_54d95495df246a2b( getxhashasset( "BR_PUBLIC_EVENT_JUGGERNAUT" ), &function_323fab1b62a2d5d4 );
}

// Namespace namespace_7fb762c489ce406f
// Params 1, eflags: 0x4
// Checksum 0xa6709476, Offset: 0x11f
// Size: 0x1d
function private function_323fab1b62a2d5d4( eventinfo )
{
    eventinfo.canactivatefunc = &canactivatefunc;
}

// Namespace namespace_7fb762c489ce406f
// Params 0, eflags: 0x4
// Checksum 0xce7da48, Offset: 0x144
// Size: 0x9, Type: bool
function private canactivatefunc()
{
    return !br_public::function_73ed6e27eb5e7544();
}

// Namespace namespace_7fb762c489ce406f
// Params 0, eflags: 0x4
// Checksum 0x20358584, Offset: 0x156
// Size: 0x27
function private activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_JUGGERNAUT", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_JUGGERNAUT", 1, &function_477932e3884ea1fd );
}

// Namespace namespace_7fb762c489ce406f
// Params 0, eflags: 0x4
// Checksum 0xc973cdf6, Offset: 0x185
// Size: 0x46
function private activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( activity_instance );
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_7fb762c489ce406f
// Params 0, eflags: 0x4
// Checksum 0x145f811c, Offset: 0x1d3
// Size: 0x10a
function private function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    numdrops = br_jugg_common::getnumdrops( activity_instance.var_332f929de1894b2b.var_59d343ef26fa87a8 );
    level.juggdroplocations = arrayrandomize( level.juggdroplocations );
    droplocations = br_jugg_common::showdroplocations( numdrops, 0, activity_instance.var_332f929de1894b2b.showbeacon, activity_instance.var_332f929de1894b2b.showquestcircle );
    br_public::brleaderdialog( "public_events_juggernaut_start" );
    var_660d237b8b959745 = 0;
    var_2eb0f4a1ee34f2a3 = activity_instance.var_332f929de1894b2b.var_2eb0f4a1ee34f2a3;
    var_e5997dd5a718245 = activity_instance.var_332f929de1894b2b.var_e5997dd5a718245;
    level br_jugg_common::startdeliveries( droplocations, "public_event", undefined, var_660d237b8b959745, var_2eb0f4a1ee34f2a3, var_e5997dd5a718245 );
}

