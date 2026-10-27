// script_1d881eb179f15363  (hash_1d881eb179f15363.gscc) (size: 4564 Bytes / 0x11d4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3a0d1751 (973936465)
// size ...... 4564 (0x11d4)
// includes .. 10  (offset: 0x10a0)
// strings ... 9   (offset: 0x10f0)
// dev strs .. 7   (offset: 0x1174)
// exports ... 14  (offset: 0x978)
// cseg ...... 0xfb + 0x87d (0x978)
// imports ... 44  (offset: 0xba8)
// animtree1 . 0   (offset: 0x11d4)
// animtree2 . 0   (offset: 0x11d4)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\br_black_market;

#namespace activity_black_market_contracts;

// Namespace activity_black_market_contracts
// Params 0, eflags: 0x5
// Checksum 0xee600b0a, Offset: 0x119
// Size: 0x33
function private autoexec __init__system__()
{
    system::register( #"activity_black_market_contracts", [ #"br_activity_manager", #"activity_common" ], &function_538033a540e63c70, undefined );
}

// Namespace activity_black_market_contracts
// Params 0, eflags: 0x4
// Checksum 0xcff6233b, Offset: 0x154
// Size: 0x25
function private function_538033a540e63c70()
{
    if ( !getdvarint( @"scr_br_black_market_contracts_disable", 0 ) )
    {
        activity_common::registeractivitytype( "BR_BLACK_MARKET_CONTRACTS", &activity_type_init );
    }
}

// Namespace activity_black_market_contracts
// Params 0
// Checksum 0x2721e78f, Offset: 0x181
// Size: 0x6d
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BR_BLACK_MARKET_CONTRACTS", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_BLACK_MARKET_CONTRACTS", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BR_BLACK_MARKET_CONTRACTS", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "BR_BLACK_MARKET_CONTRACTS", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &br_activity_util::function_d0dded8c467ac5dd, "BR_BLACK_MARKET_CONTRACTS" );
    
    /#
        debug_init();
    #/
}

// Namespace activity_black_market_contracts
// Params 0
// Checksum 0x71631e81, Offset: 0x1f6
// Size: 0x41
function activity_setup()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( self );
    self.var_402b146c4404c7f0 = function_8f7d865c9c300d81();
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace activity_black_market_contracts
// Params 0
// Checksum 0x32444f94, Offset: 0x23f
// Size: 0x14e
function function_477932e3884ea1fd()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.contractscompleted = 0;
    
    if ( self.varianttag == "black_market_contracts" )
    {
        self.numcontracts = getdvarint( @"hash_b550436bfd53a38a", self.var_332f929de1894b2b.numcontracts );
    }
    else
    {
        self.numcontracts = getdvarint( @"hash_b550426bfd53a157", self.var_332f929de1894b2b.numcontracts );
    }
    
    if ( self.var_332f929de1894b2b.anycontract )
    {
        br_black_market::set_objective_omnvars( self.var_f118922d6f1d1e00, self.objectiveindex, self.contractscompleted, self.numcontracts );
    }
    else
    {
        descindex = self.var_402b146c4404c7f0[ self.var_ab952647bf460c19 ];
        br_black_market::set_objective_omnvars( self.var_f118922d6f1d1e00, self.objectiveindex, self.contractscompleted, self.numcontracts, descindex );
    }
    
    self.callbackparams = { #activity:self };
    level callback::add( #"on_contract_completed", &on_contract_completed, self.callbackparams );
}

// Namespace activity_black_market_contracts
// Params 0
// Checksum 0x4f1fb737, Offset: 0x395
// Size: 0x94
function activity_ended()
{
    self endon( #"instance_destroyed" );
    succeeded = activity_instance_common::function_6bb0be4a3940d6e3( self );
    
    if ( succeeded )
    {
        level callback::callback( self.activitycallback, { #activity:self, #team:self.team } );
    }
    
    if ( level callback::exists( #"on_contract_completed", &on_contract_completed, self.callbackparams ) )
    {
        level callback::remove( #"on_contract_completed", &on_contract_completed, self.callbackparams );
    }
}

// Namespace activity_black_market_contracts
// Params 0
// Checksum 0x99b166dd, Offset: 0x431
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity = self;
    activity endon( #"instance_destroyed" );
}

// Namespace activity_black_market_contracts
// Params 0, eflags: 0x4
// Checksum 0x17267656, Offset: 0x455
// Size: 0x2f
function private function_8f7d865c9c300d81()
{
    objlist = [];
    objlist[ "recon" ] = 1;
    objlist[ "scavenger" ] = 2;
    objlist[ "assassination" ] = 3;
    return objlist;
}

// Namespace activity_black_market_contracts
// Params 0, eflags: 0x4
// Checksum 0xaf40866, Offset: 0x48d
// Size: 0x1e1
function private select_contract()
{
    if ( self.var_332f929de1894b2b.anycontract )
    {
        var_9562e645b698873 = 0;
        
        foreach ( tablet in level.activitymanager.visibletablets )
        {
            if ( tablet.associatedactivityinstance.varianttag != "black_market_recon" )
            {
                var_9562e645b698873++;
            }
        }
        
        if ( var_9562e645b698873 < self.var_332f929de1894b2b.numcontracts + 2 )
        {
            return;
        }
        
        return level.activitymanager.visibletablets[ 0 ].associatedactivityinstance.varianttag;
    }
    
    var_21ad79613fd6d505 = [];
    
    foreach ( tablet in level.activitymanager.visibletablets )
    {
        var_21ad79613fd6d505 = arraycombineunique( var_21ad79613fd6d505, [ tablet.associatedactivityinstance.varianttag ] );
    }
    
    var_21ad79613fd6d505 = arrayremove( var_21ad79613fd6d505, "black_market_recon" );
    validcontracts = arrayintersection( getarraykeys( self.var_402b146c4404c7f0 ), var_21ad79613fd6d505 );
    
    if ( validcontracts.size == 0 )
    {
        return;
    }
    
    return utility::array_random( validcontracts );
}

// Namespace activity_black_market_contracts
// Params 2
// Checksum 0x2ab6a92, Offset: 0x676
// Size: 0x133
function on_contract_completed( params, additional_params )
{
    activity = additional_params.activity;
    
    if ( !activity_participation::function_e7fc1202ac164928( activity, self.var_ca369031b554da2f ) )
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
    
    if ( isdefined( activity.var_ab952647bf460c19 ) )
    {
        if ( params.contract.varianttag != activity.var_ab952647bf460c19 )
        {
            return;
        }
    }
    
    activity.contractscompleted++;
    activity br_black_market::function_538557e757f948f0( activity.var_f118922d6f1d1e00, activity.contractscompleted );
    br_black_market::function_89707e63629ff7e6( activity.team, activity.varianttag, string( activity.contractscompleted ) + " / " + string( activity.numcontracts ) + " contracts completed." );
    
    if ( activity.contractscompleted >= activity.numcontracts )
    {
        activity.completed = 1;
        activity_instance_common::endactivity( activity, 1 );
    }
}

/#

    // Namespace activity_black_market_contracts
    // Params 0
    // Checksum 0x4706813e, Offset: 0x7b1
    // Size: 0xbb, Type: dev
    function debug_ui()
    {
        while ( true )
        {
            if ( self.contractscompleted >= self.numcontracts )
            {
                printtoscreen2d( 50, 700, "<dev string:x24>" + self.var_ab952647bf460c19 + "<dev string:x2e>" + self.contractscompleted + "<dev string:x3a>" + self.numcontracts, ( 0, 1, 0 ), 2, 120 );
                return;
            }
            
            printtoscreen2d( 50, 700, "<dev string:x24>" + self.var_ab952647bf460c19 + "<dev string:x2e>" + self.contractscompleted + "<dev string:x3a>" + self.numcontracts, ( 1, 1, 1 ), 2, 22 );
            wait 1;
        }
    }

    // Namespace activity_black_market_contracts
    // Params 0
    // Checksum 0x305cf0fb, Offset: 0x874
    // Size: 0x2e, Type: dev
    function debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x3c>" );
        devgui::add_devgui_func( "<dev string:x60>", "<dev string:x74>", &debug_contracts );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace activity_black_market_contracts
    // Params 0
    // Checksum 0x372094d7, Offset: 0x8aa
    // Size: 0xce, Type: dev
    function debug_contracts()
    {
        var_657a3abce2509b48 = activity_participation::function_e8eabd79cc49540e( level.players[ 0 ], [ "<dev string:x91>" ] );
        
        if ( var_657a3abce2509b48.size == 0 )
        {
            return;
        }
        
        contractactivity = level.activities.instances[ getfirstarraykey( var_657a3abce2509b48 ) ];
        contractactivity.contractscompleted++;
        contractactivity br_black_market::function_538557e757f948f0( contractactivity.var_f118922d6f1d1e00, contractactivity.contractscompleted );
        
        if ( contractactivity.contractscompleted >= contractactivity.numcontracts )
        {
            contractactivity.contractscompleted = contractactivity.numcontracts;
            contractactivity.completed = 1;
            activity_instance_common::endactivity( contractactivity, 1 );
        }
    }

#/
