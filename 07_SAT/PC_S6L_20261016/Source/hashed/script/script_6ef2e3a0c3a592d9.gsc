// script_6ef2e3a0c3a592d9  (hash_6ef2e3a0c3a592d9.gscc) (size: 2031 Bytes / 0x7ef / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x14772f11 (343355153)
// size ...... 2031 (0x7ef)
// includes .. 8   (offset: 0x74f)
// strings ... 6   (offset: 0x78f)
// dev strs .. 0   (offset: 0x7ef)
// exports ... 9   (offset: 0x3c7)
// cseg ...... 0xc0 + 0x307 (0x3c7)
// imports ... 19  (offset: 0x52f)
// animtree1 . 0   (offset: 0x7ef)
// animtree2 . 0   (offset: 0x7ef)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_deployable_kiosk;
#using scripts\mp\br\gametypes\br_publicevent_flybuy;
#using scripts\mp\br\gametypes\br_publicevents;

#namespace namespace_903a8fcaa4f8f643;

// Namespace namespace_903a8fcaa4f8f643
// Params 0, eflags: 0x5
// Checksum 0x3943ad9f, Offset: 0xde
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_3f01c054725e4ae6", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_903a8fcaa4f8f643
// Params 0, eflags: 0x4
// Checksum 0x1e8d3414, Offset: 0x107
// Size: 0x28
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BR_PUBLIC_EVENT_FLY_BUY", &activity_type_init );
    br_publicevents::function_54d95495df246a2b( getxhashasset( "BR_PUBLIC_EVENT_FLY_BUY" ), &function_323fab1b62a2d5d4 );
}

// Namespace namespace_903a8fcaa4f8f643
// Params 1
// Checksum 0x979ba0fd, Offset: 0x137
// Size: 0x1d
function function_323fab1b62a2d5d4( eventinfo )
{
    eventinfo.waitfunc = &br_publicevent_flybuy::waitfunc;
}

// Namespace namespace_903a8fcaa4f8f643
// Params 0
// Checksum 0xc10dae57, Offset: 0x15c
// Size: 0x85
function activity_type_init()
{
    if ( getdvarint( @"hash_29070507df61e0dd", 0 ) )
    {
        return;
    }
    
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_FLY_BUY", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_FLY_BUY", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_FLY_BUY", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_FLY_BUY", 3, &function_d4acef179eb9f9b2 );
    game[ "dialog" ][ "flybuy_intro" ] = "flyb_wzan_pest";
    game[ "dialog" ][ "flybuy_desc" ] = "pblc_wzan_bsnv";
}

// Namespace namespace_903a8fcaa4f8f643
// Params 0
// Checksum 0xf3a7293b, Offset: 0x1e9
// Size: 0x32
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_903a8fcaa4f8f643
// Params 0
// Checksum 0x7fe70b4c, Offset: 0x223
// Size: 0x152
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level notify( #"hash_bffccab9e8e2de25" );
    
    if ( level.circleclosing )
    {
        circleindex = level.br_circle.circleindex + 1;
    }
    else
    {
        circleindex = level.br_circle.circleindex;
    }
    
    circlecenter = level.br_level.br_circlecenters[ circleindex ];
    radius = level.br_level.br_circleradii[ circleindex ];
    count = activity_definition_utils::function_9129cd8075c85c09( self ).count;
    step = 360 / count;
    yaw = 0;
    
    for ( i = 0; i < count ; i++ )
    {
        randompoint = br_circle::getrandompointinboundscircle( circlecenter, radius, 0.25, 0.75, 1, 1, 1, undefined, yaw, yaw + step );
        yaw += step;
        br_deployable_kiosk::deployablekioskspawn( undefined, randompoint, 1 );
    }
    
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_903a8fcaa4f8f643
// Params 1
// Checksum 0x967eacde, Offset: 0x37d
// Size: 0x26
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_903a8fcaa4f8f643
// Params 0
// Checksum 0xfdf662e2, Offset: 0x3ab
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

