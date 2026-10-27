// script_295f777f1fcfd5fe  (hash_295f777f1fcfd5fe.gscc) (size: 3158 Bytes / 0xc56 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x902fc887 (2419050631)
// size ...... 3158 (0xc56)
// includes .. 9   (offset: 0xb8e)
// strings ... 5   (offset: 0xbd6)
// dev strs .. 4   (offset: 0xc26)
// exports ... 11  (offset: 0x5ca)
// cseg ...... 0xbf + 0x50b (0x5ca)
// imports ... 36  (offset: 0x782)
// animtree1 . 0   (offset: 0xc56)
// animtree2 . 0   (offset: 0xc56)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\br_black_market;

#namespace activity_black_market_mark_targets;

// Namespace activity_black_market_mark_targets
// Params 0, eflags: 0x5
// Checksum 0x4c70b4e5, Offset: 0xdd
// Size: 0x33
function private autoexec __init__system__()
{
    system::register( #"activity_black_market_mark_targets", [ #"br_activity_manager", #"activity_common" ], &function_538033a540e63c70, undefined );
}

// Namespace activity_black_market_mark_targets
// Params 0, eflags: 0x4
// Checksum 0x5e1e367c, Offset: 0x118
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BR_BLACK_MARKET_MARK_TARGETS", &activity_type_init );
}

// Namespace activity_black_market_mark_targets
// Params 0
// Checksum 0xef02d99, Offset: 0x133
// Size: 0x6d
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BR_BLACK_MARKET_MARK_TARGETS", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_BLACK_MARKET_MARK_TARGETS", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BR_BLACK_MARKET_MARK_TARGETS", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "BR_BLACK_MARKET_MARK_TARGETS", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &br_activity_util::function_d0dded8c467ac5dd, "BR_BLACK_MARKET_MARK_TARGETS" );
    
    /#
        debug_init();
    #/
}

// Namespace activity_black_market_mark_targets
// Params 0
// Checksum 0x3b40a3fc, Offset: 0x1a8
// Size: 0x32
function activity_setup()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( self );
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace activity_black_market_mark_targets
// Params 0
// Checksum 0x96453733, Offset: 0x1e2
// Size: 0xea
function function_477932e3884ea1fd()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.targetsmarked = [];
    
    if ( self.varianttag == "black_market_mark_targets" )
    {
        self.var_3c1de40d110aed08 = getdvarint( @"hash_a7a5eb3ed55504f1", self.var_332f929de1894b2b.var_3c1de40d110aed08 );
    }
    else
    {
        self.var_3c1de40d110aed08 = getdvarint( @"hash_a7a5e83ed554fe58", self.var_332f929de1894b2b.var_3c1de40d110aed08 );
    }
    
    br_black_market::set_objective_omnvars( self.var_f118922d6f1d1e00, self.objectiveindex, self.targetsmarked.size, self.var_3c1de40d110aed08 );
    self.callbackparams = { #activity:self };
    level callback::add( #"hash_2fe6e340a46bbf0f", &on_target_marked, self.callbackparams );
}

// Namespace activity_black_market_mark_targets
// Params 0
// Checksum 0xf45d6b06, Offset: 0x2d4
// Size: 0x94
function activity_ended()
{
    self endon( #"instance_destroyed" );
    succeeded = activity_instance_common::function_6bb0be4a3940d6e3( self );
    
    if ( succeeded )
    {
        level callback::callback( self.activitycallback, { #activity:self, #team:self.team } );
    }
    
    if ( level callback::exists( #"recon_drone_watch_enemy", &on_target_marked, self.callbackparams ) )
    {
        level callback::remove( #"recon_drone_watch_enemy", &on_target_marked, self.callbackparams );
    }
}

// Namespace activity_black_market_mark_targets
// Params 0
// Checksum 0x22f3baec, Offset: 0x370
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity = self;
    activity endon( #"instance_destroyed" );
}

// Namespace activity_black_market_mark_targets
// Params 2
// Checksum 0xe4d2b180, Offset: 0x394
// Size: 0x130
function on_target_marked( params, additional_params )
{
    activity = additional_params.activity;
    
    if ( !activity_participation::function_e7fc1202ac164928( activity, self ) )
    {
        return;
    }
    
    if ( !isdefined( activity ) )
    {
        return;
    }
    
    if ( activity.completed )
    {
        return;
    }
    
    if ( arraycontains( activity.targetsmarked, params.target ) )
    {
        return;
    }
    
    activity.targetsmarked[ activity.targetsmarked.size ] = params.target;
    activity br_black_market::function_538557e757f948f0( activity.var_f118922d6f1d1e00, activity.targetsmarked.size );
    br_black_market::function_89707e63629ff7e6( activity.team, activity.varianttag, string( activity.targetsmarked.size ) + " / " + string( activity.var_3c1de40d110aed08 ) + " targets marked." );
    
    if ( activity.targetsmarked.size >= activity.var_3c1de40d110aed08 )
    {
        activity.completed = 1;
        activity_instance_common::endactivity( activity, 1 );
    }
}

/#

    // Namespace activity_black_market_mark_targets
    // Params 0
    // Checksum 0xcd1425dc, Offset: 0x4cc
    // Size: 0x2e, Type: dev
    function debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x4b>", "<dev string:x59>", &debug_mark_target );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace activity_black_market_mark_targets
    // Params 0
    // Checksum 0xc22187b, Offset: 0x502
    // Size: 0xc8, Type: dev
    function debug_mark_target()
    {
        var_657a3abce2509b48 = activity_participation::function_e8eabd79cc49540e( level.players[ 0 ], [ "<dev string:x78>" ] );
        
        if ( var_657a3abce2509b48.size == 0 )
        {
            return;
        }
        
        marktargetactivity = level.activities.instances[ getfirstarraykey( var_657a3abce2509b48 ) ];
        marktargetactivity.targetsmarked[ marktargetactivity.targetsmarked.size ] = 1;
        marktargetactivity br_black_market::function_538557e757f948f0( marktargetactivity.var_f118922d6f1d1e00, marktargetactivity.targetsmarked.size );
        
        if ( marktargetactivity.targetsmarked.size >= marktargetactivity.var_3c1de40d110aed08 )
        {
            marktargetactivity.completed = 1;
            activity_instance_common::endactivity( marktargetactivity, 1 );
        }
    }

#/
