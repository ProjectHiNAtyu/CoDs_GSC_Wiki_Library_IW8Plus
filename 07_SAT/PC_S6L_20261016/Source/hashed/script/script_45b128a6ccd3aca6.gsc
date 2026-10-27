// script_45b128a6ccd3aca6  (hash_45b128a6ccd3aca6.gscc) (size: 3340 Bytes / 0xd0c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x489df0ab (1218310315)
// size ...... 3340 (0xd0c)
// includes .. 11  (offset: 0xc18)
// strings ... 5   (offset: 0xc70)
// dev strs .. 6   (offset: 0xcc4)
// exports ... 13  (offset: 0x5bc)
// cseg ...... 0xa7 + 0x515 (0x5bc)
// imports ... 39  (offset: 0x7c4)
// animtree1 . 0   (offset: 0xd0c)
// animtree2 . 0   (offset: 0xd0c)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\br_black_market;
#using scripts\mp\common\utility\teams;
#using scripts\mp\interaction;

#namespace namespace_d2448e8df22b73d5;

// Namespace namespace_d2448e8df22b73d5
// Params 0, eflags: 0x5
// Checksum 0xd80d7bd0, Offset: 0xc5
// Size: 0x33
function private autoexec __init__system__()
{
    system::register( #"hash_70290072bd609b4c", [ #"br_activity_manager", #"activity_common" ], &function_538033a540e63c70, undefined );
}

// Namespace namespace_d2448e8df22b73d5
// Params 0, eflags: 0x4
// Checksum 0xcbf6dd8e, Offset: 0x100
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BR_BLACK_MARKET_COLLECT", &activity_type_init );
}

// Namespace namespace_d2448e8df22b73d5
// Params 0
// Checksum 0x9b18c66b, Offset: 0x11b
// Size: 0x6d
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BR_BLACK_MARKET_COLLECT", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_BLACK_MARKET_COLLECT", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BR_BLACK_MARKET_COLLECT", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "BR_BLACK_MARKET_COLLECT", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &br_activity_util::function_d0dded8c467ac5dd, "BR_BLACK_MARKET_COLLECT" );
    
    /#
        debug_init();
    #/
}

// Namespace namespace_d2448e8df22b73d5
// Params 0
// Checksum 0xb296fe64, Offset: 0x190
// Size: 0x32
function activity_setup()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( self );
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace namespace_d2448e8df22b73d5
// Params 0
// Checksum 0x25cb4661, Offset: 0x1ca
// Size: 0x16a
function function_477932e3884ea1fd()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    br_black_market::set_objective_omnvars( self.var_f118922d6f1d1e00, self.objectiveindex, 0, 1 );
    player = teams::getteamdata( self.team, "players" )[ 0 ];
    collectorigin = ( self.var_332f929de1894b2b.var_67e9977636a04d7a, self.var_332f929de1894b2b.interactposy, self.var_332f929de1894b2b.var_67e9957636a04914 );
    collectangles = ( self.var_332f929de1894b2b.var_88164be0522ed2d, self.var_332f929de1894b2b.var_88163be0522eafa, self.var_332f929de1894b2b.var_88162be0522e8c7 );
    payload = [ #"teamselect", player getentitynumber() ];
    self.collectinteract = spawnscriptable( self.var_332f929de1894b2b.collectscriptable, collectorigin, collectangles, undefined, payload );
    self.collectinteract setscriptablepartstate( self.var_332f929de1894b2b.collectscriptable, "enabled" );
    interaction::register_scriptable_interact( self.collectinteract, &function_5c0e5eb85d1f4798, undefined, undefined, &collect_hint_callback );
}

// Namespace namespace_d2448e8df22b73d5
// Params 0
// Checksum 0x262b6406, Offset: 0x33c
// Size: 0x62
function activity_ended()
{
    self endon( #"instance_destroyed" );
    succeeded = activity_instance_common::function_6bb0be4a3940d6e3( self );
    
    if ( succeeded )
    {
        level callback::callback( self.activitycallback, { #activity:self, #team:self.team } );
    }
    
    self.collectinteract freescriptable();
}

// Namespace namespace_d2448e8df22b73d5
// Params 0
// Checksum 0xab25e774, Offset: 0x3a6
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity = self;
    activity endon( #"instance_destroyed" );
}

// Namespace namespace_d2448e8df22b73d5
// Params 1
// Checksum 0x256233eb, Offset: 0x3ca
// Size: 0x95
function function_5c0e5eb85d1f4798( player )
{
    var_657a3abce2509b48 = activity_participation::function_e8eabd79cc49540e( player, [ "BR_BLACK_MARKET_COLLECT" ] );
    
    if ( var_657a3abce2509b48.size == 0 )
    {
        return;
    }
    
    collectactivity = level.activities.instances[ getfirstarraykey( var_657a3abce2509b48 ) ];
    
    if ( collectactivity.completed )
    {
        return;
    }
    
    collectactivity br_black_market::function_538557e757f948f0( collectactivity.var_f118922d6f1d1e00, 1 );
    collectactivity.completed = 1;
    activity_instance_common::endactivity( collectactivity, 1 );
}

// Namespace namespace_d2448e8df22b73d5
// Params 2
// Checksum 0x9d8d09d8, Offset: 0x467
// Size: 0x36
function collect_hint_callback( interact, player )
{
    return { #string:&"hash_5d3b834a67ed87d6", #type:"HINT_BUTTON" };
}

/#

    // Namespace namespace_d2448e8df22b73d5
    // Params 0
    // Checksum 0x920061b9, Offset: 0x4a6
    // Size: 0x44, Type: dev
    function debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x46>", "<dev string:x53>", &debug_collect );
        devgui::add_devgui_func( "<dev string:x6e>", "<dev string:x82>", &function_2925c2df90f15aeb );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_d2448e8df22b73d5
    // Params 0
    // Checksum 0xf8c361ca, Offset: 0x4f2
    // Size: 0x88, Type: dev
    function debug_collect()
    {
        var_657a3abce2509b48 = activity_participation::function_e8eabd79cc49540e( level.players[ 0 ], [ "<dev string:xa9>" ] );
        
        if ( var_657a3abce2509b48.size == 0 )
        {
            return;
        }
        
        collectactivity = level.activities.instances[ getfirstarraykey( var_657a3abce2509b48 ) ];
        collectactivity br_black_market::function_538557e757f948f0( collectactivity.var_f118922d6f1d1e00, 1 );
        collectactivity.completed = 1;
        activity_instance_common::endactivity( collectactivity, 1 );
    }

    // Namespace namespace_d2448e8df22b73d5
    // Params 0
    // Checksum 0x1425027c, Offset: 0x582
    // Size: 0x3a, Type: dev
    function function_2925c2df90f15aeb()
    {
        sphere( level.var_ab06be8f65123f71.collectinteract.origin, 25, ( 0, 0, 1 ), 0, 600 );
    }

#/
