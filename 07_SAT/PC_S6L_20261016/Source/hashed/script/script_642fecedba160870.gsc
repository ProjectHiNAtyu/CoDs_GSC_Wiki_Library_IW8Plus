// script_642fecedba160870  (hash_642fecedba160870.gscc) (size: 2383 Bytes / 0x94f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xef1488da (4011100378)
// size ...... 2383 (0x94f)
// includes .. 6   (offset: 0x8a3)
// strings ... 9   (offset: 0x8d3)
// dev strs .. 0   (offset: 0x94f)
// exports ... 8   (offset: 0x50f)
// cseg ...... 0xd5 + 0x43a (0x50f)
// imports ... 21  (offset: 0x64f)
// animtree1 . 0   (offset: 0x94f)
// animtree2 . 0   (offset: 0x94f)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\mp\br\gametypes\br_publicevent_roguesignal;
#using scripts\mp\br\gametypes\br_publicevents;

#namespace namespace_45eb0cde96702a00;

// Namespace namespace_45eb0cde96702a00
// Params 0, eflags: 0x5
// Checksum 0xe8e6db9a, Offset: 0xf3
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_69f2bec2850d42db", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_45eb0cde96702a00
// Params 0, eflags: 0x4
// Checksum 0x387b4a2c, Offset: 0x11c
// Size: 0x28
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BR_PUBLIC_EVENT_ROGUE_SIGNAL", &activity_type_init );
    br_publicevents::function_54d95495df246a2b( getxhashasset( "BR_PUBLIC_EVENT_ROGUE_SIGNAL" ), &function_323fab1b62a2d5d4 );
}

// Namespace namespace_45eb0cde96702a00
// Params 1
// Checksum 0x61c21809, Offset: 0x14c
// Size: 0xc
function function_323fab1b62a2d5d4( eventinfo )
{
    
}

// Namespace namespace_45eb0cde96702a00
// Params 0
// Checksum 0xe6b2d858, Offset: 0x160
// Size: 0x53
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_ROGUE_SIGNAL", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_ROGUE_SIGNAL", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_ROGUE_SIGNAL", 2, &activity_ended );
    
    if ( !isdefined( level.roguesignalinfo ) )
    {
        level.roguesignalinfo = spawnstruct();
    }
}

// Namespace namespace_45eb0cde96702a00
// Params 0
// Checksum 0xf5b3f122, Offset: 0x1bb
// Size: 0x2d0
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    self.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( self );
    level.roguesignalinfo.currenteventtype = 0;
    level.roguesignalinfo.scoreboard = [];
    level.roguesignalinfo.eventlength = int( self.var_332f929de1894b2b.eventlength * getmatchrulesdata( "brData", "circleTimeScale" ) );
    level.roguesignalinfo.eventtypes = [];
    var_aad56564bce12044 = [ "Powerup":5, "Looting":4, "Damage":3, "Kills":2, "Plunder":1, "Inactive":0 ];
    
    foreach ( eventstruct in self.var_332f929de1894b2b.eventtypes )
    {
        level.roguesignalinfo.eventtypes[ level.roguesignalinfo.eventtypes.size ] = var_aad56564bce12044[ eventstruct.type ];
    }
    
    level.roguesignalinfo.reward_cache = self.var_332f929de1894b2b.rewardcache;
    level.roguesignalinfo.var_6422b98a4e22e1d2 = self.var_332f929de1894b2b.var_191430bfdd2a627a;
    level.roguesignalinfo.var_90478ae18206c270 = self.var_332f929de1894b2b.var_c37753be8dfd9eb6;
    level.roguesignalinfo.var_20b0b11854b50073 = self.var_332f929de1894b2b.var_e2c2b5a5df1e9beb;
    level.roguesignalinfo.use_quest_circle = self.var_332f929de1894b2b.usequestcircle;
    level.roguesignalinfo.start_buffer = self.var_332f929de1894b2b.startbuffer;
    level.roguesignalinfo.var_d704d3a7b1e60666 = self.var_332f929de1894b2b.var_2dfa1f7ff4106e78;
    
    if ( !isdefined( level.var_d4e1d6e51b37f60b ) )
    {
        level.var_d4e1d6e51b37f60b = [];
    }
    
    br_publicevent_roguesignal::event_post_init();
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace namespace_45eb0cde96702a00
// Params 0
// Checksum 0x55c2f2c9, Offset: 0x493
// Size: 0x3b
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    br_publicevent_roguesignal::event_activate();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_45eb0cde96702a00
// Params 1
// Checksum 0x8c510144, Offset: 0x4d6
// Size: 0x39
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    br_publicevent_roguesignal::function_31c4c5162449ac0a();
}

