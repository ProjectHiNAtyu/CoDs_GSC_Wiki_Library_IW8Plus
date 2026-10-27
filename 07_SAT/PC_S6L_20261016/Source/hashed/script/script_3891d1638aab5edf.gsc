// script_3891d1638aab5edf  (hash_3891d1638aab5edf.gscc) (size: 2217 Bytes / 0x8a9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9627f527 (2519201063)
// size ...... 2217 (0x8a9)
// includes .. 11  (offset: 0x7e9)
// strings ... 6   (offset: 0x841)
// dev strs .. 1   (offset: 0x89d)
// exports ... 8   (offset: 0x38d)
// cseg ...... 0xf9 + 0x294 (0x38d)
// imports ... 28  (offset: 0x4cd)
// animtree1 . 0   (offset: 0x8a9)
// animtree2 . 0   (offset: 0x8a9)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevent_choppers;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\hud_util;

#namespace namespace_373bdb2f36881547;

// Namespace namespace_373bdb2f36881547
// Params 0, eflags: 0x5
// Checksum 0xecc08f21, Offset: 0x117
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_6fddda8d721621cc", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_373bdb2f36881547
// Params 0, eflags: 0x4
// Checksum 0xcb467d80, Offset: 0x140
// Size: 0x28
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BR_PUBLIC_EVENT_CHOPPERS", &activity_type_init );
    br_publicevents::function_54d95495df246a2b( getxhashasset( "BR_PUBLIC_EVENT_CHOPPERS" ), &function_323fab1b62a2d5d4 );
}

// Namespace namespace_373bdb2f36881547
// Params 1
// Checksum 0xc13a274e, Offset: 0x170
// Size: 0xc
function function_323fab1b62a2d5d4( eventinfo )
{
    
}

// Namespace namespace_373bdb2f36881547
// Params 0
// Checksum 0x803060d4, Offset: 0x184
// Size: 0xa7
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_CHOPPERS", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_CHOPPERS", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_CHOPPERS", 3, &function_d4acef179eb9f9b2 );
    assert( isdefined( game[ "<dev string:x24>" ] ) );
    game[ "dialog" ][ "public_events_choppers_start" ] = "chpp_wzan_bmev";
    utility::registersharedfunc( #"br_lootchopper", #"lootchopper_oncrateuse", &br_publicevent_choppers::oncrateuse );
    utility::registersharedfunc( #"loot_chopper", #"explode", &br_publicevent_choppers::function_6500dbf8533d53e5 );
    br_circle::registercirclecallbacks( 8, &br_publicevent_choppers::dangercircletick );
}

// Namespace namespace_373bdb2f36881547
// Params 0
// Checksum 0xdbbe5006, Offset: 0x233
// Size: 0x50
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( self );
    level.var_b4c8dcabb0437344 = 1;
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_373bdb2f36881547
// Params 0
// Checksum 0x615e051d, Offset: 0x28b
// Size: 0xd7
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    hud_util::showsplashtoall( "br_plunder_pe_attack_choppers_active", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp" );
    br_public::brleaderdialog( "public_events_choppers_start" );
    activity_instance thread br_publicevent_choppers::spawnchoppers( activity_instance.var_332f929de1894b2b.choppercount );
    level.br_pe_chopper_damage_time = gettime() + int( activity_instance.var_332f929de1894b2b.var_3ab42820881e7e38 * 1000 );
    activity_instance thread br_activity_util::function_f255dbc3d969ce02( activity_instance.var_332f929de1894b2b.helilifetime, 12 );
    br_publicevent_choppers::waituntilallchoppersaredead( 10, activity_instance.eventendtime );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_373bdb2f36881547
// Params 0
// Checksum 0x2296151b, Offset: 0x36a
// Size: 0x23
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    br_activity_util::function_f24cad5d113f4f52();
}

