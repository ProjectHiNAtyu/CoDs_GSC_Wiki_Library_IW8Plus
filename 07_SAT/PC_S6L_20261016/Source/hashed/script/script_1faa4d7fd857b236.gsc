// script_1faa4d7fd857b236  (hash_1faa4d7fd857b236.gscc) (size: 2541 Bytes / 0x9ed / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x76d7854e (1993835854)
// size ...... 2541 (0x9ed)
// includes .. 8   (offset: 0x95d)
// strings ... 3   (offset: 0x99d)
// dev strs .. 2   (offset: 0x9d5)
// exports ... 10  (offset: 0x4c1)
// cseg ...... 0x91 + 0x430 (0x4c1)
// imports ... 27  (offset: 0x651)
// animtree1 . 0   (offset: 0x9ed)
// animtree2 . 0   (offset: 0x9ed)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\mp\airdrop_scriptbundle;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevent_doublexp_crate;
#using scripts\mp\br\gametypes\br_publicevents;

#namespace namespace_1a244aab9c77701a;

// Namespace namespace_1a244aab9c77701a
// Params 0, eflags: 0x5
// Checksum 0x84eefa02, Offset: 0xaf
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_1caa0f78114aa897", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_1a244aab9c77701a
// Params 0, eflags: 0x4
// Checksum 0xff238d9a, Offset: 0xd8
// Size: 0x2f
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BR_PUBLIC_EVENT_DOUBLE_XP_CRATES", &activity_type_init );
    br_publicevents::function_54d95495df246a2b( getxhashasset( "BR_PUBLIC_EVENT_DOUBLE_XP_CRATES" ), &function_323fab1b62a2d5d4 );
    br_publicevent_doublexp_crate::initdialog();
}

// Namespace namespace_1a244aab9c77701a
// Params 1, eflags: 0x4
// Checksum 0xe7d4199b, Offset: 0x10f
// Size: 0x8a
function private function_323fab1b62a2d5d4( eventinfo )
{
    activitycustomproperties = level.activities.definitions[ eventinfo.event ];
    scriptbundlevalues = activity_definition_utils::function_9129cd8075c85c09( activitycustomproperties );
    assert( isdefined( scriptbundlevalues.airdropasset ), "<dev string:x24>" );
    airdrop_scriptbundle::registerairdrop( scriptbundlevalues.airdropasset, &br_publicevent_doublexp_crate::function_abcea032e1fe2aa0 );
    eventinfo.canactivatefunc = &br_publicevent_doublexp_crate::function_7a420b2caca4891b;
}

// Namespace namespace_1a244aab9c77701a
// Params 0, eflags: 0x4
// Checksum 0x614a597, Offset: 0x1a1
// Size: 0x4d
function private activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_DOUBLE_XP_CRATES", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_DOUBLE_XP_CRATES", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_DOUBLE_XP_CRATES", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_DOUBLE_XP_CRATES", 3, &function_d4acef179eb9f9b2 );
}

// Namespace namespace_1a244aab9c77701a
// Params 0, eflags: 0x4
// Checksum 0x811eb4cd, Offset: 0x1f6
// Size: 0x56
function private activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( activity_instance );
    activity_instance function_217cbedd5d2ab393();
    br_publicevent_doublexp_crate::function_af1b0f0759f33540();
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_1a244aab9c77701a
// Params 0, eflags: 0x4
// Checksum 0xdfd31c00, Offset: 0x254
// Size: 0x174
function private function_217cbedd5d2ab393()
{
    level.var_a96adc48a346553a = { #var_1ca2aee1bb5b6f3c:[], #var_4a0271ed43846837:[], #var_8514f1e6e7596d6a:self.var_332f929de1894b2b.var_ad3b588087a3492a, #var_e3fc4a7818ad9104:self.var_332f929de1894b2b.var_e45d0b211d7dc898, #var_f358ba80826a9f86:self.var_332f929de1894b2b.var_76abc4eb7b219762, #xpmultiplier:self.var_332f929de1894b2b.xpmultiplier };
    xprewards = strtok( self.var_332f929de1894b2b.var_1ca2aee1bb5b6f3c, " " );
    
    foreach ( xpreward in xprewards )
    {
        level.var_a96adc48a346553a.var_1ca2aee1bb5b6f3c[ level.var_a96adc48a346553a.var_1ca2aee1bb5b6f3c.size ] = int( xpreward );
    }
    
    assert( level.var_a96adc48a346553a.xpmultiplier >= 1, "<dev string:x7a>" );
}

// Namespace namespace_1a244aab9c77701a
// Params 0, eflags: 0x4
// Checksum 0x20192614, Offset: 0x3d0
// Size: 0x9f
function private function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.var_4a0271ed43846837 = [];
    level thread br_public::brleaderdialog( "dbxp_inbound", 1, undefined, 0, 1, undefined );
    scriptbundlevalues = activity_definition_utils::function_9129cd8075c85c09( activity_instance );
    
    for ( i = 0; i < scriptbundlevalues.var_a494197abae2a68c ; i++ )
    {
        thread airdrop_scriptbundle::startairdrop( scriptbundlevalues.airdropasset );
        waitframe();
    }
    
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_1a244aab9c77701a
// Params 1, eflags: 0x4
// Checksum 0xaef12a83, Offset: 0x477
// Size: 0x26
function private activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_1a244aab9c77701a
// Params 0, eflags: 0x4
// Checksum 0xc579e4bf, Offset: 0x4a5
// Size: 0x1c
function private function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

