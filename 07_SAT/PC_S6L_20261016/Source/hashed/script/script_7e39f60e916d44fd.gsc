// script_7e39f60e916d44fd  (hash_7e39f60e916d44fd.gscc) (size: 5547 Bytes / 0x15ab / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe49448be (3834923198)
// size ...... 5547 (0x15ab)
// includes .. 11  (offset: 0x13e3)
// strings ... 19  (offset: 0x143b)
// dev strs .. 7   (offset: 0x154b)
// exports ... 15  (offset: 0xc23)
// cseg ...... 0x22c + 0x9f7 (0xc23)
// imports ... 47  (offset: 0xe7b)
// animtree1 . 0   (offset: 0x15ab)
// animtree2 . 0   (offset: 0x15ab)
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
#using scripts\mp\br\gametypes\br_circle_util;

#namespace activity_black_market_caches;

// Namespace activity_black_market_caches
// Params 0, eflags: 0x5
// Checksum 0xa3efb89a, Offset: 0x24a
// Size: 0x33
function private autoexec __init__system__()
{
    system::register( #"activity_black_market_caches", [ #"br_activity_manager", #"activity_common" ], &function_538033a540e63c70, undefined );
}

// Namespace activity_black_market_caches
// Params 0, eflags: 0x4
// Checksum 0x3eb805e8, Offset: 0x285
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BR_BLACK_MARKET_CACHES", &activity_type_init );
}

// Namespace activity_black_market_caches
// Params 0
// Checksum 0x6e561e0d, Offset: 0x2a0
// Size: 0x6d
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BR_BLACK_MARKET_CACHES", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_BLACK_MARKET_CACHES", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BR_BLACK_MARKET_CACHES", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "BR_BLACK_MARKET_CACHES", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &br_activity_util::function_d0dded8c467ac5dd, "BR_BLACK_MARKET_CACHES" );
    
    /#
        debug_init();
    #/
}

// Namespace activity_black_market_caches
// Params 0
// Checksum 0x53c15c18, Offset: 0x315
// Size: 0x41
function activity_setup()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( self );
    self.var_49571e198eba80d5 = function_61359d320c3ba96b();
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace activity_black_market_caches
// Params 0
// Checksum 0x79c2806e, Offset: 0x35e
// Size: 0x1dd
function function_477932e3884ea1fd()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.cacheslooted = 0;
    self.selectedpoi = find_best_poi( self.playerparticipants[ 0 ].origin, self.var_332f929de1894b2b );
    
    if ( !isdefined( self.selectedpoi ) )
    {
        self.var_e31e2f92f674112e = 1;
        activity_instance_common::endactivity( self, 0 );
        return;
    }
    
    self.selectedpoi = get_poi_bucket( self.selectedpoi );
    
    if ( !isdefined( self.selectedpoi ) )
    {
        self.var_e31e2f92f674112e = 1;
        activity_instance_common::endactivity( self, 0 );
        return;
    }
    
    self.var_a72ac4dda42a6b4e = level.poi[ self.selectedpoi ][ "calloutIndex" ];
    
    if ( self.varianttag == "black_market_caches" )
    {
        self.numcaches = getdvarint( @"hash_d90630f1f41f6534", self.var_332f929de1894b2b.numcaches );
    }
    else
    {
        self.numcaches = getdvarint( @"hash_d90633f1f41f6bcd", self.var_332f929de1894b2b.numcaches );
    }
    
    if ( isdefined( self.selectedpoi ) )
    {
        br_black_market::set_objective_omnvars( self.var_f118922d6f1d1e00, self.objectiveindex, self.cacheslooted, self.numcaches, self.var_a72ac4dda42a6b4e );
    }
    else
    {
        br_black_market::set_objective_omnvars( self.var_f118922d6f1d1e00, self.objectiveindex, self.cacheslooted, self.numcaches );
    }
    
    self.callbackparams = { #activity:self };
    level callback::add( #"cache_opened", &function_4866044da4d91cd8, self.callbackparams );
    
    /#
    #/
}

// Namespace activity_black_market_caches
// Params 0
// Checksum 0x8036375, Offset: 0x543
// Size: 0x94
function activity_ended()
{
    self endon( #"instance_destroyed" );
    succeeded = activity_instance_common::function_6bb0be4a3940d6e3( self );
    
    if ( succeeded )
    {
        level callback::callback( self.activitycallback, { #activity:self, #team:self.team } );
    }
    
    if ( level callback::exists( #"cache_opened", &function_4866044da4d91cd8, self.callbackparams ) )
    {
        level callback::remove( #"cache_opened", &function_4866044da4d91cd8, self.callbackparams );
    }
}

// Namespace activity_black_market_caches
// Params 0
// Checksum 0xdeadb29f, Offset: 0x5df
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity = self;
    activity endon( #"instance_destroyed" );
}

// Namespace activity_black_market_caches
// Params 0, eflags: 0x4
// Checksum 0xd938d79a, Offset: 0x603
// Size: 0xa1
function private function_61359d320c3ba96b()
{
    poibucket = [];
    poibucket[ "saw_island_town site_1" ] = [ "saw_island_town site_1", "saw_island_graveyard site_9", "saw_island_overlook site_10" ];
    poibucket[ "saw_island_winery site_2" ] = [ "saw_island_winery site_2", "saw_island_pier site_6", "saw_island_bay site_7" ];
    poibucket[ "saw_island_grotto site_3" ] = [ "saw_island_grotto site_3", "saw_island_smugglers_cove site_4", "saw_island_lighthouse site_5" ];
    poibucket[ "saw_island_keep site_8" ] = [ "saw_island_keep site_8", "saw_island_gatehouse site_0", "saw_island_terraces site_11" ];
    return poibucket;
}

// Namespace activity_black_market_caches
// Params 2
// Checksum 0x48735fb6, Offset: 0x6ad
// Size: 0x194
function function_4866044da4d91cd8( params, additional_params )
{
    player = params.player;
    poi = player.closestpoi;
    activity = additional_params.activity;
    
    if ( !activity_participation::function_e7fc1202ac164928( activity, player ) )
    {
        return;
    }
    
    /#
        printtoscreen2d( 100, 620, poi, ( 1, 0, 1 ), 2, 120 );
    #/
    
    if ( !isdefined( activity ) )
    {
        return;
    }
    
    if ( getdvarint( @"scr_br_black_market_caches_disable", 0 ) )
    {
        return;
    }
    
    if ( activity.completed )
    {
        return;
    }
    
    if ( isdefined( activity.selectedpoi ) )
    {
        if ( !arraycontains( activity.var_49571e198eba80d5[ activity.selectedpoi ], poi ) )
        {
            return;
        }
    }
    
    activity.cacheslooted++;
    activity br_black_market::function_538557e757f948f0( activity.var_f118922d6f1d1e00, activity.cacheslooted );
    br_black_market::function_89707e63629ff7e6( activity.team, activity.varianttag, string( activity.cacheslooted ) + " / " + string( activity.numcaches ) + " caches looted in " + string( activity.selectedpoi ) );
    
    if ( activity.cacheslooted >= activity.numcaches )
    {
        activity.completed = 1;
        activity_instance_common::endactivity( activity, 1 );
    }
}

// Namespace activity_black_market_caches
// Params 2
// Checksum 0x13042c93, Offset: 0x849
// Size: 0x16a
function find_best_poi( origin, paramstruct )
{
    validpois = [];
    selectedpoi = undefined;
    
    foreach ( poi in level.poi )
    {
        if ( !arraycontains( getarraykeys( poi ), "calloutIndex" ) )
        {
            continue;
        }
        
        poiorigin = level.poi_origins[ poi[ "name" ] ];
        dist = distance2d( poiorigin, origin );
        
        if ( dist > paramstruct.poimaxdist )
        {
            continue;
        }
        
        if ( !level.br_circle_disabled )
        {
            var_fe0c4908619f7ec1 = br_circle_util::function_472c93858e491e0a( poiorigin );
            var_c74854bee54101e2 = br_circle_util::function_b880c0f9998fdd69( var_fe0c4908619f7ec1 );
            traveltime = dist / 190;
            var_c74854bee54101e2 -= traveltime;
            
            if ( var_c74854bee54101e2 > paramstruct.var_540b35ff024488bc )
            {
                validpois[ validpois.size ] = poi;
            }
        }
    }
    
    selectedpoi = utility::array_random( validpois );
    
    if ( isdefined( selectedpoi ) )
    {
        selectedpoi = selectedpoi[ "name" ];
    }
    
    return selectedpoi;
}

// Namespace activity_black_market_caches
// Params 1
// Checksum 0x68d0c30, Offset: 0x9bc
// Size: 0x97
function get_poi_bucket( poiname )
{
    foreach ( bucket in getarraykeys( self.var_49571e198eba80d5 ) )
    {
        if ( arraycontains( self.var_49571e198eba80d5[ bucket ], poiname ) )
        {
            return bucket;
        }
    }
}

/#

    // Namespace activity_black_market_caches
    // Params 0
    // Checksum 0x7f125e50, Offset: 0xa5c
    // Size: 0xbb, Type: dev
    function debug_ui()
    {
        while ( true )
        {
            if ( self.cacheslooted >= self.numcaches )
            {
                printtoscreen2d( 50, 620, "<dev string:x24>" + self.selectedpoi + "<dev string:x36>" + self.cacheslooted + "<dev string:x39>" + self.numcaches, ( 0, 1, 0 ), 2, 120 );
                return;
            }
            
            printtoscreen2d( 50, 620, "<dev string:x24>" + self.selectedpoi + "<dev string:x36>" + self.cacheslooted + "<dev string:x39>" + self.numcaches, ( 1, 1, 1 ), 2, 22 );
            wait 1;
        }
    }

    // Namespace activity_black_market_caches
    // Params 0
    // Checksum 0x1fc8d45d, Offset: 0xb1f
    // Size: 0x2e, Type: dev
    function debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x3b>" );
        devgui::add_devgui_func( "<dev string:x5c>", "<dev string:x69>", &debug_loot_cache );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace activity_black_market_caches
    // Params 0
    // Checksum 0x13c7538e, Offset: 0xb55
    // Size: 0xce, Type: dev
    function debug_loot_cache()
    {
        var_657a3abce2509b48 = activity_participation::function_e8eabd79cc49540e( level.players[ 0 ], [ "<dev string:x8b>" ] );
        
        if ( var_657a3abce2509b48.size == 0 )
        {
            return;
        }
        
        cacheactivity = level.activities.instances[ getfirstarraykey( var_657a3abce2509b48 ) ];
        cacheactivity.cacheslooted++;
        cacheactivity br_black_market::function_538557e757f948f0( cacheactivity.var_f118922d6f1d1e00, cacheactivity.cacheslooted );
        
        if ( cacheactivity.cacheslooted >= cacheactivity.numcaches )
        {
            cacheactivity.cacheslooted = cacheactivity.numcaches;
            cacheactivity.completed = 1;
            activity_instance_common::endactivity( cacheactivity, 1 );
        }
    }

#/
