// scripts\mp\br\br_activity_scheduler.gsc  (hash_79fbd4500c9b77a3.gscc) (size: 34814 Bytes / 0x87fe / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9207bb90 (2449980304)
// size ...... 34814 (0x87fe)
// includes .. 13  (offset: 0x7f0a)
// strings ... 106 (offset: 0x7f72)
// dev strs .. 61  (offset: 0x84fa)
// exports ... 75  (offset: 0x5f56)
// cseg ...... 0xcd2 + 0x5284 (0x5f56)
// imports ... 155 (offset: 0x6b0e)
// animtree1 . 0   (offset: 0x87fe)
// animtree2 . 0   (offset: 0x87fe)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\conditional_container;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\flags;

#namespace br_activity_scheduler;

// Namespace br_activity_scheduler
// Params 0, eflags: 0x5
// Checksum 0x8bf8b6d, Offset: 0xcf0
// Size: 0x37
function private autoexec __init__system__()
{
    system::register( #"br_activity_scheduler", [ #"br_activity_manager", #"activity_common" ], &init, &postmain );
}

// Namespace br_activity_scheduler
// Params 0, eflags: 0x4
// Checksum 0xfcb148a9, Offset: 0xd2f
// Size: 0x1a
function private init()
{
    /#
        thread function_d0e4c14bc9d19e4a();
        thread function_cfc60147263c112c();
    #/
    
    function_36af8268d0b9190b();
}

// Namespace br_activity_scheduler
// Params 0, eflags: 0x4
// Checksum 0xd86e9639, Offset: 0xd51
// Size: 0xe
function private postmain()
{
    utility::flag_set( "scheduler_post_main" );
}

// Namespace br_activity_scheduler
// Params 0, eflags: 0xc
// Checksum 0xe6eff6e1, Offset: 0xd67
// Size: 0x152
function private function_36af8268d0b9190b()
{
    self notify( #"hash_a2219b01f2f5c04f" );
    self endon( #"hash_a2219b01f2f5c04f" );
    
    /#
        function_a82a0333642e5c7a();
        devgui::remove_devgui_menu( "<dev string:x24>" );
    #/
    
    var_68f543069583585c = function_586a0dc14d19b930();
    
    if ( !var_68f543069583585c )
    {
        debuglog( "Activity Scheduler Skipping init because no schedule was found." );
        return;
    }
    
    var_c3b4e63bcb84242d = level.activityscheduler.var_d372793050f9c238;
    level.activityscheduler = { #spawnpoints:[], #var_4b95f74665795a46:[], #var_8b20f0333f735647:[], #var_d372793050f9c238:var_c3b4e63bcb84242d ?? [], #var_243f162dc6e624e1:[], #levelnotifyactions:[], #timeractions:[], #matchstartactions:[], #circleactions:[ "CircleBeginClose":[], "CircleClosed":[], "CircleSet":[] ], #var_da8376c609ab3c58:[], #resources:[] };
    function_a3953142620f315b( var_68f543069583585c );
    function_bbb7178ac51f67f5( var_68f543069583585c );
    function_f669ddc346cab4f8( var_68f543069583585c );
    function_7b6f96c471756d7e( var_68f543069583585c );
    
    /#
        schedulerdevgui();
    #/
    
    debuglog( "Activity Scheduler Initialized from asset: " + var_68f543069583585c.name );
    level thread function_faee9e8392928da3();
}

// Namespace br_activity_scheduler
// Params 0, eflags: 0x4
// Checksum 0xce80c4ee, Offset: 0xec1
// Size: 0x53
function private function_fe23b992883c5473()
{
    var_b4a492fe405bbe9 = getdvar( @"hash_d60e64936fb14ff8" );
    
    if ( var_b4a492fe405bbe9 )
    {
        bundlename = hashcat( %"hash_184dbffc708406a0", var_b4a492fe405bbe9 );
    }
    else
    {
        bundlename = level.gametypebundle.var_41729606a9fcbc3a;
    }
    
    return bundlename;
}

// Namespace br_activity_scheduler
// Params 0, eflags: 0x4
// Checksum 0x7937e9f, Offset: 0xf1d
// Size: 0x43
function private function_586a0dc14d19b930()
{
    bundlename = function_fe23b992883c5473();
    
    if ( !isdefined( bundlename ) )
    {
        return;
    }
    
    var_68f543069583585c = getscriptbundle( bundlename );
    
    if ( !var_68f543069583585c )
    {
        debuglog( "Failed to retrieve scriptbundle for schedule: " + bundlename );
    }
    
    return var_68f543069583585c;
}

/#

    // Namespace br_activity_scheduler
    // Params 0, eflags: 0xc
    // Checksum 0x560ed024, Offset: 0xf69
    // Size: 0x122, Type: dev
    function private function_a82a0333642e5c7a()
    {
        self notify( #"hash_71e35700a4b796d1" );
        self endon( #"hash_71e35700a4b796d1" );
        
        if ( getdvarint( @"hash_684e4cd9ea43ba8d", 0 ) )
        {
            return;
        }
        
        foreach ( schedule in level.activityscheduler.var_da8376c609ab3c58 )
        {
            foreach ( activityinstance in schedule.var_34683e7f9fceb34f )
            {
                activity_instance_common::function_9aeeabe50fc9cc3e( activityinstance );
            }
        }
    }

    // Namespace br_activity_scheduler
    // Params 0, eflags: 0xc
    // Checksum 0xd7b300c3, Offset: 0x1093
    // Size: 0x9e, Type: dev
    function private function_d0e4c14bc9d19e4a()
    {
        self notify( #"hash_e6a9867090641fa9" );
        self endon( #"hash_e6a9867090641fa9" );
        
        while ( true )
        {
            level waittill( #"hash_7e967560bc92fa01", var_facf97ba9e42d82d );
            
            if ( var_facf97ba9e42d82d.asset_type != "<dev string:x3a>" )
            {
                continue;
            }
            
            if ( var_facf97ba9e42d82d.asset_name != function_fe23b992883c5473() )
            {
                continue;
            }
            
            debuglog( "<dev string:x4d>" + var_facf97ba9e42d82d.asset_name + "<dev string:x67>" );
            level notify( #"hash_61e935b878210dac" );
            function_36af8268d0b9190b();
        }
    }

    // Namespace br_activity_scheduler
    // Params 0, eflags: 0xc
    // Checksum 0x56845f30, Offset: 0x1139
    // Size: 0x8e, Type: dev
    function private function_cfc60147263c112c()
    {
        self notify( #"hash_8f0623900538014e" );
        self endon( #"hash_8f0623900538014e" );
        lastvalue = getdvar( @"hash_d60e64936fb14ff8" );
        
        while ( true )
        {
            wait 1;
            currentvalue = getdvar( @"hash_d60e64936fb14ff8" );
            
            if ( currentvalue == lastvalue )
            {
                continue;
            }
            
            lastvalue = currentvalue;
            debuglog( "<dev string:x83>" + currentvalue + "<dev string:xa7>" );
            level notify( #"hash_61e935b878210dac" );
            function_36af8268d0b9190b();
        }
    }

#/

// Namespace br_activity_scheduler
// Params 1, eflags: 0x4
// Checksum 0xf6904bc4, Offset: 0x11cf
// Size: 0x16f
function private function_a3953142620f315b( var_68f543069583585c )
{
    foreach ( pool in var_68f543069583585c.resourcepools )
    {
        if ( level.activityscheduler.resources[ pool.name ] )
        {
            assertmsg( "<dev string:xc4>" + pool.name + "<dev string:xf6>" + level.gametypebundle.var_41729606a9fcbc3a );
            continue;
        }
        
        level.activityscheduler.resources[ pool.name ] = spawnstruct();
        level.activityscheduler.resources[ pool.name ].capacity = pool.capacity;
        level.activityscheduler.resources[ pool.name ].var_5f373363df1057ed = [];
    }
    
    callback::add( #"br_activity_end", &function_391b5630c715e7a6 );
}

// Namespace br_activity_scheduler
// Params 1, eflags: 0x4
// Checksum 0x66d8a9b2, Offset: 0x1346
// Size: 0xcb
function private function_1ceec207314829f( name )
{
    if ( !level.activityscheduler.resources[ name ] )
    {
        return;
    }
    
    totalusage = 0;
    
    foreach ( reservation in level.activityscheduler.resources[ name ].var_5f373363df1057ed )
    {
        totalusage += reservation.count;
    }
    
    return totalusage;
}

// Namespace br_activity_scheduler
// Params 2, eflags: 0x4
// Checksum 0xc69f7aa0, Offset: 0x141a
// Size: 0x5e, Type: bool
function private function_186472a355d5dd7a( name, count )
{
    pool = level.activityscheduler.resources[ name ];
    
    if ( !isdefined( pool ) )
    {
        return false;
    }
    
    if ( count + function_1ceec207314829f( name ) > pool.capacity )
    {
        return false;
    }
    
    return true;
}

// Namespace br_activity_scheduler
// Params 2, eflags: 0x4
// Checksum 0xc05fb6ae, Offset: 0x1481
// Size: 0xfe, Type: bool
function private function_5e13d492785dd2d7( resourcecost, activityinstance )
{
    foreach ( cost in resourcecost )
    {
        level.activityscheduler.resources[ cost.pool ].var_5f373363df1057ed[ level.activityscheduler.resources[ cost.pool ].var_5f373363df1057ed.size ] = { #count:cost.count, #activityinstanceid:activityinstance.id };
    }
    
    return true;
}

// Namespace br_activity_scheduler
// Params 1, eflags: 0x4
// Checksum 0x8150b821, Offset: 0x1588
// Size: 0x1ed
function private function_391b5630c715e7a6( params )
{
    activityinstance = params.activityinstance;
    
    if ( activityinstance.successfullycompleted && activityinstance.var_86737cbe11bf496e && activityinstance.var_86737cbe11bf496e.size > 0 && !activityinstance.var_9699265805219bc9 )
    {
        if ( utility::issharedfuncdefined( #"gametype", #"hash_4d30403ee025b771" ) )
        {
            utility::callsharedfunc( #"gametype", #"hash_4d30403ee025b771", params );
        }
    }
    
    foreach ( name, pool in level.activityscheduler.resources )
    {
        foreach ( reservation in pool.var_5f373363df1057ed )
        {
            if ( reservation.activityinstanceid == activityinstance.id )
            {
                debuglog( "Returned " + reservation.count + " " + name + " resources from activity ID " + activityinstance.id );
                pool.var_5f373363df1057ed = arrayremove( pool.var_5f373363df1057ed, reservation );
                break;
            }
        }
    }
}

// Namespace br_activity_scheduler
// Params 1, eflags: 0x4
// Checksum 0x4ebf4fc, Offset: 0x177d
// Size: 0xe3
function private function_f857607443561e10( var_90ea7cee64ab71ca )
{
    var_b99336ee1ed60634 = [];
    
    foreach ( conditionstruct in var_90ea7cee64ab71ca.excludeconditions )
    {
        condition = conditionstruct.variant_object;
        
        if ( condition.exclusiontype == "RESOURCE_POOL" )
        {
            var_b99336ee1ed60634[ var_b99336ee1ed60634.size ] = { #count:condition.var_67ce98147af682fd, #pool:condition.name };
        }
    }
    
    return var_b99336ee1ed60634;
}

// Namespace br_activity_scheduler
// Params 1, eflags: 0x4
// Checksum 0x4170ec8b, Offset: 0x1869
// Size: 0xca
function private function_f669ddc346cab4f8( var_68f543069583585c )
{
    foreach ( entry in var_68f543069583585c.var_4b95f74665795a46 )
    {
        level.activityscheduler.var_4b95f74665795a46[ entry.variant ] = 1;
        debuglog( "Blacklisted variant " + entry.variant + " from schedule " + var_68f543069583585c.name );
    }
}

// Namespace br_activity_scheduler
// Params 1, eflags: 0x4
// Checksum 0xc1a8d167, Offset: 0x193b
// Size: 0x103
function private function_7b6f96c471756d7e( var_68f543069583585c )
{
    level.activityscheduler.var_c58cd6761344263f = var_68f543069583585c.var_c58cd6761344263f;
    level.activityscheduler.var_cdcb86918ef004a4 = var_68f543069583585c.var_cdcb86918ef004a4;
    level.activityscheduler.var_4c6746e6c928a5d5 = var_68f543069583585c.var_4c6746e6c928a5d5;
    level.activityscheduler.var_af31955b6c9dfb64 = var_68f543069583585c.var_af31955b6c9dfb64;
    level.activityscheduler.var_6ecb985cf0efb404 = var_68f543069583585c.var_6ecb985cf0efb404;
    level.activityscheduler.var_c8113077425d5dc3 = throttle::throttle_initialize_gate( "schedule", var_68f543069583585c.var_c58cd6761344263f );
    level.activityscheduler.var_d696f34356a799b3 = throttle::throttle_initialize_gate( "spawn_point_filtering", level.activityscheduler.var_6ecb985cf0efb404 );
}

// Namespace br_activity_scheduler
// Params 1, eflags: 0x4
// Checksum 0x5b4b7c7f, Offset: 0x1a46
// Size: 0x176
function private function_bbb7178ac51f67f5( var_68f543069583585c )
{
    foreach ( schedule in var_68f543069583585c.var_a927e81b58c1064f )
    {
        killswitchdvar = hashcat( @"hash_3391fc87273dad01", schedule.label );
        
        if ( schedule.disable && !isdvardefined( killswitchdvar ) )
        {
            debuglog( "Killswitched schedule " + schedule.label + " from GDT" );
            continue;
        }
        
        if ( getdvarint( killswitchdvar, 0 ) == 1 )
        {
            debuglog( "Killswitched schedule " + schedule.label + " from DVar" );
            continue;
        }
        
        level.activityscheduler.var_da8376c609ab3c58[ schedule.label ] = { #var_34683e7f9fceb34f:[], #partialactions:[ "LeavesCircleGas":[], "EntersCircleGas":[], "LeavesGas":[], "EntersGas":[] ], #schedule:schedule };
        function_361df7f343fbd1( schedule );
        inittriggers( schedule );
    }
}

// Namespace br_activity_scheduler
// Params 1, eflags: 0x4
// Checksum 0x4dab6377, Offset: 0x1bc4
// Size: 0x172
function private function_361df7f343fbd1( schedule )
{
    foreach ( entry in schedule.var_a9dfc10a29865ad2 )
    {
        options = function_9546e862ccc51c79( entry );
        
        switch ( options.var_6cb90bd34d18aa5b )
        {
            case #"hash_f0d5082e93ba704":
                thread function_82472449c29d764c( options.name, options.type, entry.activitydefinition, options.registervariants );
                activity_definition_utils::function_74af1ab4059e3c06( entry.activitydefinition, entry.activitydefinition );
                break;
            case #"hash_549704383f4d33fe":
            case #"hash_baed159411ca4d8f":
            case #"hash_c716670ef2f90539":
                activity_definition_utils::function_74af1ab4059e3c06( entry.activitydefinition, entry.activitydefinition );
                break;
            default:
                activity_definition_utils::function_74af1ab4059e3c06( entry.activitydefinition, entry.activitydefinition );
                break;
        }
    }
}

// Namespace br_activity_scheduler
// Params 1, eflags: 0x4
// Checksum 0xddbb10ac, Offset: 0x1d3e
// Size: 0x90e
function private inittriggers( schedule )
{
    foreach ( triggerstruct in schedule.triggers )
    {
        trigger = triggerstruct.variant_object;
        destinations = [];
        
        switch ( trigger.triggertype )
        {
            case #"hash_24cd68a821648661":
                destinations[ destinations.size ] = level.activityscheduler.matchstartactions;
                break;
            case #"hash_34866217e7bb861":
                destinationindex = trigger.circle - 1 + "";
                
                if ( !isdefined( level.activityscheduler.circleactions[ trigger.circleevent ][ destinationindex ] ) )
                {
                    level.activityscheduler.circleactions[ trigger.circleevent ][ destinationindex ] = [];
                }
                
                destinations[ destinations.size ] = level.activityscheduler.circleactions[ trigger.circleevent ][ destinationindex ];
                break;
            case #"hash_dd2ed33873eebae1":
                for ( i = trigger.mincircle; i <= trigger.maxcircle ; i++ )
                {
                    destinationindex = i - 1 + "";
                    
                    if ( !isdefined( level.activityscheduler.circleactions[ trigger.circleevent ][ destinationindex ] ) )
                    {
                        level.activityscheduler.circleactions[ trigger.circleevent ][ destinationindex ] = [];
                    }
                    
                    destinations[ destinations.size ] = level.activityscheduler.circleactions[ trigger.circleevent ][ destinationindex ];
                }
                
                break;
            case #"hash_2faced055f1bf462":
                if ( !isdefined( level.activityscheduler.timeractions[ trigger.var_fe2be708da1f1c38 ] ) )
                {
                    level.activityscheduler.timeractions[ trigger.var_fe2be708da1f1c38 ] = [];
                }
                
                if ( !isdefined( level.activityscheduler.timeractions[ trigger.var_fe2be708da1f1c38 ][ "" + trigger.delay ] ) )
                {
                    level.activityscheduler.timeractions[ trigger.var_fe2be708da1f1c38 ][ "" + trigger.delay ] = [];
                }
                
                destinations[ destinations.size ] = level.activityscheduler.timeractions[ trigger.var_fe2be708da1f1c38 ][ "" + trigger.delay ];
                break;
            case #"hash_40ab4431cee8f9db":
                if ( !isdefined( level.activityscheduler.notifyevents[ trigger.notifyname ] ) )
                {
                    level.activityscheduler.notifyevents[ trigger.notifyname ] = [];
                }
                
                destinations[ destinations.size ] = level.activityscheduler.notifyevents[ trigger.notifyname ];
                break;
            case #"hash_e633152f9c5ec1fa":
                if ( !isdefined( level.activityscheduler.var_da8376c609ab3c58[ schedule.label ].partialactions[ trigger.gasbehavior ] ) )
                {
                    level.activityscheduler.var_da8376c609ab3c58[ schedule.label ].partialactions[ trigger.gasbehavior ] = [];
                }
                
                destinations[ destinations.size ] = level.activityscheduler.var_da8376c609ab3c58[ schedule.label ].partialactions[ trigger.gasbehavior ];
                break;
            default:
                assertmsg( "<dev string:x105>" + trigger.triggertype + "<dev string:x116>" + schedule.label );
                break;
        }
        
        foreach ( actionstruct in trigger.actions )
        {
            actiondefinition = actionstruct.variant_object;
            action = { #params:{ #delay:actiondefinition.delay } };
            
            /#
                action.var_5868d186373af428 = schedule.label;
            #/
            
            switch ( actiondefinition.actiontype )
            {
                case #"hash_7eb134a2634323ec":
                    action.function = &spawnactivity;
                    action.params.schedule = schedule;
                    action.params.spawnchance = actiondefinition.spawnchance;
                    action.params.spawncount = actiondefinition.spawncount;
                    action.params.minstagger = actiondefinition.minstagger;
                    action.params.maxstagger = actiondefinition.maxstagger;
                    
                    /#
                        action.debugname = "<dev string:x13e>";
                    #/
                    
                    break;
                case #"hash_eaea04e20d0e727e":
                    action.function = &function_b7e99426cd1629f3;
                    action.params.schedule = schedule;
                    action.params.notifyname = actiondefinition.notifyname;
                    
                    /#
                        action.debugname = "<dev string:x14f>" + actiondefinition.notifyname + "<dev string:x163>";
                    #/
                    
                    break;
                case #"hash_26e1d2babccf7ae1":
                    action.function = &function_8438aa7c5011b57f;
                    action.params.notifyname = actiondefinition.notifyname;
                    action.params.activitytype = actiondefinition.activitytype;
                    
                    /#
                        action.debugname = "<dev string:x165>" + actiondefinition.activitytype + "<dev string:x172>" + actiondefinition.notifyname + "<dev string:x163>";
                    #/
                    
                    break;
                case #"hash_3628a5626a3d30c8":
                    action.function = &function_75738fc8ac6c52a3;
                    action.params.schedule = schedule;
                    action.params.mincount = actiondefinition.mincount;
                    
                    /#
                        action.debugname = "<dev string:x175>";
                    #/
                    
                    break;
                case #"hash_3f1a21e8641a2ce8":
                    action.function = &function_2eb18c4f5c9fc19;
                    action.params.notifyname = actiondefinition.notifyname;
                    break;
                case #"hash_a87c3c4a8929610e":
                    action.function = &function_dcfb24ab41438f09;
                    break;
                default:
                    assertmsg( "<dev string:x184>" + actiondefinition.actiontype + "<dev string:x116>" + schedule.label );
                    break;
            }
            
            if ( !action )
            {
                assertmsg( "<dev string:x199>" );
                return;
            }
            
            foreach ( destination in destinations )
            {
                destination[ destination.size ] = action;
                debuglog( "Scheduled " + trigger.triggertype + "|" + actiondefinition.actiontype + " for " + schedule.label );
            }
        }
    }
}

// Namespace br_activity_scheduler
// Params 4, eflags: 0x4
// Checksum 0xc6ebfdf, Offset: 0x2654
// Size: 0x6a
function private function_82472449c29d764c( name, type, activitydefinition, registervariants )
{
    if ( level.activityscheduler.var_d372793050f9c238[ type ][ name ] )
    {
        return;
    }
    
    game_utility::function_c4ff84a7288ed707();
    utility::flag_wait( "scheduler_post_main" );
    function_ab14cbc15a4c34ac( name, type, activitydefinition, registervariants );
    game_utility::function_48cf7b776b9642d3();
}

// Namespace br_activity_scheduler
// Params 4, eflags: 0x4
// Checksum 0x984b44c0, Offset: 0x26c6
// Size: 0x252
function private function_ab14cbc15a4c34ac( name, type, activitydefinition, registervariants )
{
    if ( !isdefined( level.activityscheduler.var_d372793050f9c238[ type ] ) )
    {
        level.activityscheduler.var_d372793050f9c238[ type ] = [];
    }
    
    level.activityscheduler.var_d372793050f9c238[ type ][ name ] = [];
    additionalstructs = utility::getstructarray( name, type );
    
    if ( registervariants )
    {
        foreach ( struct in additionalstructs )
        {
            if ( !isdefined( struct.entity_id ) )
            {
                assertmsg( "<dev string:x1ae>" );
                return;
            }
            
            variantname = activitydefinition + "_" + struct.entity_id;
            activity_definition_utils::function_74af1ab4059e3c06( activitydefinition, variantname );
            var_ca3f65fdba0a9ed2 = level.activities;
            variantscriptstructinfo = { #linkedstructs:[ struct ], #variantstruct:struct };
            var_ca3f65fdba0a9ed2.var_dd80223f1900e086[ variantname ] = variantscriptstructinfo;
            activitytype = function_ccc4c48350d921bd( activitydefinition );
            
            if ( !isdefined( var_ca3f65fdba0a9ed2.var_ba2ff13ee5b3ab5[ activitytype ] ) )
            {
                var_ca3f65fdba0a9ed2.var_ba2ff13ee5b3ab5[ activitytype ] = [];
            }
            
            var_ca3f65fdba0a9ed2.var_ba2ff13ee5b3ab5[ activitytype ][ var_ca3f65fdba0a9ed2.var_ba2ff13ee5b3ab5[ activitytype ].size ] = variantscriptstructinfo;
            debuglog( "Registered activity variant: " + variantname );
        }
    }
    
    level.activityscheduler.var_d372793050f9c238[ type ][ name ] = arraycombine( level.activityscheduler.var_d372793050f9c238[ type ][ name ], additionalstructs );
    debuglog( "Cached " + level.activityscheduler.var_d372793050f9c238[ type ][ name ].size + " Map Structs: " + name + "|" + type );
}

// Namespace br_activity_scheduler
// Params 2
// Checksum 0x873e266d, Offset: 0x2920
// Size: 0x2d
function function_db53d4a97454fe14( name, type )
{
    return level.activityscheduler.var_d372793050f9c238[ type ][ name ];
}

// Namespace br_activity_scheduler
// Params 1, eflags: 0x4
// Checksum 0x16ff9426, Offset: 0x2956
// Size: 0x231, Type: bool
function private function_d40b3aa8f34f046b( var_90ea7cee64ab71ca )
{
    foreach ( var_9e8f6807c04755fc in var_90ea7cee64ab71ca.excludeconditions )
    {
        excludecondition = var_9e8f6807c04755fc.variant_object;
        
        switch ( excludecondition.exclusiontype )
        {
            case #"hash_94e4b25ee79d3554":
                if ( !function_186472a355d5dd7a( excludecondition.name, excludecondition.var_67ce98147af682fd ) )
                {
                    debuglog( "Exclude condition met: " + excludecondition.exclusiontype );
                    function_e305524af521b5f8();
                    return true;
                }
                
                break;
            case #"hash_be49cc5f726052ec":
                var_d767078c752dc812 = function_5f16efcabe07e545( var_90ea7cee64ab71ca.activitydefinition );
                
                if ( var_d767078c752dc812 >= excludecondition.count )
                {
                    debuglog( "Exclude condition met: " + excludecondition.exclusiontype );
                    return true;
                }
                
                break;
            case #"hash_bb79fc5ad8a2b6d7":
                var_d767078c752dc812 = function_5f16efcabe07e545( var_90ea7cee64ab71ca.activitydefinition );
                
                if ( var_d767078c752dc812 >= excludecondition.counts[ level.br_circle.circleindex ].count )
                {
                    debuglog( "Exclude condition met: " + excludecondition.exclusiontype );
                    return true;
                }
                
                break;
            case #"hash_bc50f4ee263c9ae8":
                type = function_ccc4c48350d921bd( var_90ea7cee64ab71ca.activitydefinition );
                
                if ( level.activityscheduler.var_243f162dc6e624e1[ type ] > excludecondition.count )
                {
                    return true;
                }
                
                break;
            default:
                assertmsg( "<dev string:x262>" + excludecondition.exclusiontype );
                break;
        }
    }
    
    return false;
}

// Namespace br_activity_scheduler
// Params 1, eflags: 0x4
// Checksum 0x6f9c478d, Offset: 0x2b90
// Size: 0xb6
function private function_5f16efcabe07e545( definitionname )
{
    type = function_ccc4c48350d921bd( definitionname );
    var_d767078c752dc812 = 0;
    
    foreach ( activity in level.activities.instances )
    {
        if ( activity_instance_common::getactivitytype( activity ) == type )
        {
            var_d767078c752dc812++;
        }
    }
    
    return var_d767078c752dc812;
}

// Namespace br_activity_scheduler
// Params 1, eflags: 0x4
// Checksum 0xf45b31a6, Offset: 0x2c4f
// Size: 0xca
function private function_b5b149bf81dc33a1( activitydefinition )
{
    if ( !isdefined( level.activityscheduler.var_8b20f0333f735647[ activitydefinition ].category ) )
    {
        if ( !isdefined( level.activityscheduler.var_8b20f0333f735647[ activitydefinition ] ) )
        {
            level.activityscheduler.var_8b20f0333f735647[ activitydefinition ] = {};
        }
        
        activityscriptbundle = getscriptbundle( hashcat( %"activitydefinition:", activitydefinition ) );
        level.activityscheduler.var_8b20f0333f735647[ activitydefinition ].category = activity_definition_utils::function_897014a17bf1cbdc( activityscriptbundle );
    }
    
    return level.activityscheduler.var_8b20f0333f735647[ activitydefinition ].category;
}

// Namespace br_activity_scheduler
// Params 1, eflags: 0x4
// Checksum 0x23789e3d, Offset: 0x2d22
// Size: 0xdf
function private function_ccc4c48350d921bd( activitydefinition )
{
    if ( !isdefined( level.activityscheduler.var_8b20f0333f735647[ activitydefinition ].type ) )
    {
        if ( !isdefined( level.activityscheduler.var_8b20f0333f735647[ activitydefinition ] ) )
        {
            level.activityscheduler.var_8b20f0333f735647[ activitydefinition ] = {};
        }
        
        activityscriptbundle = getscriptbundle( hashcat( %"activitydefinition:", activitydefinition ) );
        activityproperties = activity_definition_utils::function_9129cd8075c85c09( activityscriptbundle );
        level.activityscheduler.var_8b20f0333f735647[ activitydefinition ].type = activityproperties.activitytype;
    }
    
    return level.activityscheduler.var_8b20f0333f735647[ activitydefinition ].type;
}

// Namespace br_activity_scheduler
// Params 1, eflags: 0x4
// Checksum 0x59f45cac, Offset: 0x2e0a
// Size: 0x23
function private function_9546e862ccc51c79( var_90ea7cee64ab71ca )
{
    return var_90ea7cee64ab71ca.var_7e78cbe393b664f7[ 0 ].variant_object;
}

// Namespace br_activity_scheduler
// Params 2, eflags: 0x4
// Checksum 0x6d616d9e, Offset: 0x2e36
// Size: 0x5ab
function private function_df5dfb8dc4edbfd8( var_90ea7cee64ab71ca, label )
{
    spawnoptions = function_9546e862ccc51c79( var_90ea7cee64ab71ca );
    spawnpoints = [];
    
    if ( isdefined( level.activityscheduler.spawnpoints[ label ] ) )
    {
        return level.activityscheduler.spawnpoints[ label ];
    }
    
    switch ( spawnoptions.var_6cb90bd34d18aa5b )
    {
        case #"hash_f0d5082e93ba704":
        case #"hash_a35e4aac149ed3ba":
            activitytype = function_ccc4c48350d921bd( var_90ea7cee64ab71ca.activitydefinition );
            
            if ( getdvarint( @"hash_77028468edaceec6", 0 ) == 1 )
            {
                allvariants = activity_definition_utils::function_326a5e04c9b438f5( activitytype );
                
                foreach ( variant, struct in allvariants )
                {
                    if ( "activitydefinition:" + var_90ea7cee64ab71ca.activitydefinition != struct.associatedscriptbundlename && "activitydefinition:" + spawnoptions.activitydefinitionoverride != struct.associatedscriptbundlename )
                    {
                        continue;
                    }
                    
                    if ( level.activityscheduler.var_4b95f74665795a46[ variant ] )
                    {
                        continue;
                    }
                    
                    info = activity_common::function_d54f02a6971bb9ab( variant );
                    
                    if ( !info )
                    {
                        if ( struct.var_49b766acb5226cde )
                        {
                            spawndata = { #origin:[[ struct.var_49b766acb5226cde ]]()[ variant ].scriptstructorigin, #variant:variant };
                            spawnpoints[ spawnpoints.size ] = spawndata;
                        }
                        else
                        {
                            continue;
                        }
                        
                        continue;
                    }
                    
                    spawndata = { #origin:info.variantstruct.origin, #variant:variant };
                    spawnpoints[ spawnpoints.size ] = spawndata;
                }
                
                break;
            }
            
            utility::flag_wait( "activity_map_data_cached" );
            var_10e048cd277c023f = activity_common::function_98ded9c70478e2bf( activitytype ) ?? [];
            
            foreach ( info in var_10e048cd277c023f )
            {
                var_34bb6763f902e86c = info.variantstruct.activity_bundle;
                
                if ( var_90ea7cee64ab71ca.activitydefinition != var_34bb6763f902e86c && spawnoptions.activitydefinitionoverride != var_34bb6763f902e86c )
                {
                    continue;
                }
                
                variant = info.variantstruct.name;
                
                if ( level.activityscheduler.var_4b95f74665795a46[ variant ] )
                {
                    continue;
                }
                
                spawndata = { #origin:info.variantstruct.origin, #variant:variant };
                spawnpoints[ spawnpoints.size ] = spawndata;
            }
            
            break;
        case #"hash_549704383f4d33fe":
            for ( i = 0; i < spawnoptions.samplecount ; i++ )
            {
                spawndata = { #origin:br_circle::getrandompointinsafecircle(), #variant:var_90ea7cee64ab71ca.activitydefinition };
                spawnpoints[ spawnpoints.size ] = spawndata;
            }
            
            break;
        case #"hash_baed159411ca4d8f":
            spawndata = { #origin:( 0, 0, 0 ), #variant:var_90ea7cee64ab71ca.activitydefinition };
            spawnpoints[ spawnpoints.size ] = spawndata;
            break;
        case #"hash_c716670ef2f90539":
            foreach ( var_1d994f9239dffb24 in spawnoptions.mapspawnpoints )
            {
                if ( level.mapname == var_1d994f9239dffb24.mapname )
                {
                    foreach ( point in var_1d994f9239dffb24.spawnpoints )
                    {
                        spawndata = { #origin:( point.x, point.y, point.z ), #variant:var_90ea7cee64ab71ca.activitydefinition };
                        spawnpoints[ spawnpoints.size ] = spawndata;
                    }
                    
                    break;
                }
            }
            
            break;
        default:
            assertmsg( "<dev string:x282>" );
            break;
    }
    
    level.activityscheduler.spawnpoints[ label ] = spawnpoints;
    return level.activityscheduler.spawnpoints[ label ];
}

// Namespace br_activity_scheduler
// Params 2, eflags: 0x4
// Checksum 0x23b0d806, Offset: 0x33e9
// Size: 0x51e
function private function_a8e5d27512ee04d8( points, var_90ea7cee64ab71ca )
{
    var_b87198c2dd7ccf8b = [];
    
    foreach ( spawndata in points )
    {
        point = spawndata.origin;
        pointvalid = 1;
        
        foreach ( var_f00874caec9493e0 in var_90ea7cee64ab71ca.spawnpointconstraints )
        {
            throttle::throttle_wait_gate( level.activityscheduler.var_d696f34356a799b3 );
            constraint = var_f00874caec9493e0.variant_object;
            
            switch ( constraint.var_61923655c4aeef2 )
            {
                case #"hash_75aec332f90089a8":
                    var_6cfbf3440852b83f = function_d8b2088f0e9d8c03( point, constraint.var_14b8c08b89dfa263, var_90ea7cee64ab71ca.activitydefinition );
                    
                    if ( !var_6cfbf3440852b83f )
                    {
                        break;
                    }
                    
                    origin = activity_instance_common::function_776ee11e7acc64a5( var_6cfbf3440852b83f );
                    function_8d2a17daae98575f( "Comparing " + point + "(" + spawndata.variant + ") to " + origin + " (" + var_6cfbf3440852b83f.varianttag + ") Distance Squared: " + distance2dsquared( point, origin ) );
                    withinradius = distance2dsquared( point, origin ) < constraint.radius * constraint.radius;
                    
                    if ( withinradius )
                    {
                        pointvalid = 0;
                        function_8d2a17daae98575f( "Rejecting Spawn point because it's within " + constraint.radius + " of an activity of the same " + constraint.var_14b8c08b89dfa263 );
                    }
                    
                    break;
                case #"hash_77654e48abe45e6":
                    var_6cfbf3440852b83f = function_ca062399c8c075ba( point, "Type", constraint.activitytype );
                    
                    if ( !var_6cfbf3440852b83f )
                    {
                        break;
                    }
                    
                    origin = activity_instance_common::function_776ee11e7acc64a5( var_6cfbf3440852b83f );
                    withinradius = distance2dsquared( point, origin ) < constraint.radius * constraint.radius;
                    
                    if ( withinradius != constraint.behavior == "Within" )
                    {
                        pointvalid = 0;
                        function_8d2a17daae98575f( "Rejecting Spawn point because it's not " + constraint.behavior + " " + constraint.radius + " of an activity of type " + constraint.activitytype );
                    }
                    
                    break;
                case #"hash_e982696c842e4362":
                    var_171501653d192328 = br_circle::function_6bf5d4e680297398( point ) || br_circle_util::function_4c6afbf2b757376a( point, 1 );
                    
                    if ( var_171501653d192328 != constraint.gasbehavior == "Within" )
                    {
                        pointvalid = 0;
                        function_8d2a17daae98575f( "Rejecting Spawn point because it's " + constraint.behavior + " gas" );
                    }
                    
                    break;
                case #"hash_bbf9b1bee5b517a9":
                    var_58c6f769655e8f23 = constraint.var_6b5aa87b06572bdf ? level.br_circle.circleindex + 1 : constraint.var_58c6f769655e8f23;
                    
                    if ( var_58c6f769655e8f23 >= level.br_level.br_circlecenters.size )
                    {
                        pointvalid = 0;
                        function_8d2a17daae98575f( "Rejecting Spawn point because there isn't a circle " + constraint.var_58c6f769655e8f23 );
                        break;
                    }
                    
                    circleorigin = level.br_level.br_circlecenters[ var_58c6f769655e8f23 ];
                    circleradius = level.br_level.br_circleradii[ var_58c6f769655e8f23 ] * constraint.circleradiusscalar;
                    pointincircle = utility::ispointinsidecircle( point, circleorigin, circleradius );
                    
                    if ( pointincircle != constraint.behavior == "Within" )
                    {
                        pointvalid = 0;
                        function_8d2a17daae98575f( "Rejecting Spawn point because it's not " + constraint.behavior + " circle " + var_58c6f769655e8f23 + " with scalar " + constraint.circleradiusscalar + " (radius: " + circleradius + ")" );
                    }
                    
                    break;
                default:
                    assertmsg( "<dev string:x2a6>" + constraint.var_61923655c4aeef2 );
                    break;
            }
            
            if ( !pointvalid )
            {
                break;
            }
        }
        
        if ( pointvalid )
        {
            var_b87198c2dd7ccf8b[ var_b87198c2dd7ccf8b.size ] = spawndata;
        }
    }
    
    debuglog( "Filtered out " + points.size - var_b87198c2dd7ccf8b.size + " spawnpoints. Found " + var_b87198c2dd7ccf8b.size + " valid spawnpoints for " + function_ccc4c48350d921bd( var_90ea7cee64ab71ca.activitydefinition ) );
    return var_b87198c2dd7ccf8b;
}

// Namespace br_activity_scheduler
// Params 2, eflags: 0x4
// Checksum 0x8c9f5c11, Offset: 0x3910
// Size: 0xb7
function private function_f682f2fa453fbedb( activity_instance, params )
{
    switch ( params.var_14b8c08b89dfa263 )
    {
        case #"hash_f3f770333d8988b1":
            comparestring = activity_instance_common::getactivitycategory( activity_instance );
            matchstring = function_b5b149bf81dc33a1( params.matchactivitydefinition );
            return issubstr( comparestring, matchstring );
        case #"hash_8c41dd300ada028d":
            comparestring = activity_instance_common::getactivitytype( activity_instance );
            matchstring = function_ccc4c48350d921bd( params.matchactivitydefinition );
            return issubstr( comparestring, matchstring );
        default:
            assertmsg( "<dev string:x2c7>" );
            return 0;
    }
}

// Namespace br_activity_scheduler
// Params 2, eflags: 0x4
// Checksum 0x5d4ffbe3, Offset: 0x39cf
// Size: 0x9d
function private function_7850ddfd95a76162( activity_instance, params )
{
    switch ( params.var_14b8c08b89dfa263 )
    {
        case #"hash_f3f770333d8988b1":
            comparestring = activity_instance_common::getactivitycategory( activity_instance );
            return issubstr( comparestring, params.matchstring );
        case #"hash_8c41dd300ada028d":
            comparestring = activity_instance_common::getactivitytype( activity_instance );
            return issubstr( comparestring, params.matchstring );
        default:
            assertmsg( "<dev string:x2c7>" );
            return 0;
    }
}

// Namespace br_activity_scheduler
// Params 2
// Checksum 0x6d77f472, Offset: 0x3a74
// Size: 0x1f, Type: bool
function function_6d116875d23c858d( activity_instance, params )
{
    return !function_f72295ae20829456( activity_instance, params );
}

// Namespace br_activity_scheduler
// Params 2, eflags: 0x4
// Checksum 0x83299e2c, Offset: 0x3a9c
// Size: 0x23, Type: bool
function private function_f72295ae20829456( activity_instance, params )
{
    return activity_instance.type == params;
}

// Namespace br_activity_scheduler
// Params 2
// Checksum 0x46547758, Offset: 0x3ac8
// Size: 0x90, Type: bool
function function_3427727590420365( activity_instance, params )
{
    foreach ( state in params )
    {
        if ( activity_instance_common::getactivitystate( activity_instance ) == state )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_activity_scheduler
// Params 2, eflags: 0x4
// Checksum 0xd3fcab3b, Offset: 0x3b61
// Size: 0x6a
function private function_84caae2951bb6bbd( origin, type )
{
    conditions = spawnstruct();
    conditions conditional_container::function_3c3be461141746c0();
    conditional_container::addcondition( conditions, &function_f72295ae20829456, type );
    conditional_container::addcondition( conditions, &function_3427727590420365, [ "Active", "Idle" ] );
    return activity_common::function_3eba33db536a1da6( origin, undefined, conditions );
}

// Namespace br_activity_scheduler
// Params 3, eflags: 0x4
// Checksum 0x9adbd882, Offset: 0x3bd4
// Size: 0x67
function private function_d8b2088f0e9d8c03( origin, var_14b8c08b89dfa263, matchactivitydefinition )
{
    conditions = spawnstruct();
    conditions conditional_container::function_3c3be461141746c0();
    conditional_container::addcondition( conditions, &function_f682f2fa453fbedb, { #matchactivitydefinition:matchactivitydefinition, #var_14b8c08b89dfa263:var_14b8c08b89dfa263 } );
    return activity_common::function_3eba33db536a1da6( origin, undefined, conditions );
}

// Namespace br_activity_scheduler
// Params 3, eflags: 0x4
// Checksum 0xd8d81a44, Offset: 0x3c44
// Size: 0x67
function private function_ca062399c8c075ba( origin, var_14b8c08b89dfa263, matchstring )
{
    conditions = spawnstruct();
    conditions conditional_container::function_3c3be461141746c0();
    conditional_container::addcondition( conditions, &function_7850ddfd95a76162, { #matchstring:matchstring, #var_14b8c08b89dfa263:var_14b8c08b89dfa263 } );
    return activity_common::function_3eba33db536a1da6( origin, undefined, conditions );
}

// Namespace br_activity_scheduler
// Params 2, eflags: 0x4
// Checksum 0x955773dd, Offset: 0x3cb4
// Size: 0x51c
function private selectspawnpoint( points, selectiontype )
{
    switch ( selectiontype )
    {
        case #"hash_d950ebd1da4d0aa2":
            return utility::array_random( points );
        case #"hash_675d2f3f8dd1d4ea":
            bestpoint = undefined;
            
            foreach ( point in points )
            {
                pointscore = getplayerinfluenceatposition( point.origin, 1 );
                
                if ( !isdefined( bestpoint ) || pointscore > getplayerinfluenceatposition( bestpoint.origin, 1 ) )
                {
                    bestpoint = point;
                }
            }
            
            return bestpoint;
        case #"hash_c18bad81243ce9f3":
            bestpoint = undefined;
            var_dd2c1f52fb6bb31e = undefined;
            circleorigin = level.br_level.br_circlecenters[ level.br_circle.circleindex + 2 ];
            circleradius = level.br_level.br_circleradii[ level.br_circle.circleindex + 2 ];
            largeradius = 13500;
            var_94617d585d8395d0 = 20250000;
            var_f5c0b6c651c57846 = throttle::throttle_initialize_gate( "cradle_gas_spawn_selection" );
            
            foreach ( point in points )
            {
                throttle::throttle_wait_gate( var_f5c0b6c651c57846 );
                function_8d2a17daae98575f( "CradleGas Evaluating point " + point.origin );
                
                if ( !isdefined( bestpoint ) )
                {
                    bestpoint = point;
                    var_dd2c1f52fb6bb31e = getplayersinradius( point.origin, largeradius ).size;
                    var_57d1078bf9939e45 = utility::ispointinsidecircle( bestpoint.origin, circleorigin, circleradius );
                    function_8d2a17daae98575f( "CradleGas Initial Best Point set to " + point.origin );
                    continue;
                }
                
                pointincircle = utility::ispointinsidecircle( point.origin, circleorigin, circleradius );
                
                if ( !var_57d1078bf9939e45 && pointincircle )
                {
                    bestpoint = point;
                    var_dd2c1f52fb6bb31e = getplayersinradius( point.origin, largeradius ).size;
                    var_57d1078bf9939e45 = pointincircle;
                    function_8d2a17daae98575f( "CradleGas New Best Point set to " + point.origin + " (inside circle)" );
                    continue;
                }
                
                if ( var_57d1078bf9939e45 && !pointincircle )
                {
                    function_8d2a17daae98575f( "CradleGas Skipping point " + point.origin + " because best point is already inside circle." );
                    continue;
                }
                
                players = getplayersinradius( point.origin, largeradius );
                var_60bad15914781484 = 0;
                
                foreach ( player in players )
                {
                    if ( distancesquared( player.origin, point.origin ) < var_94617d585d8395d0 )
                    {
                        var_60bad15914781484 = 1;
                        break;
                    }
                }
                
                if ( var_60bad15914781484 )
                {
                    function_8d2a17daae98575f( "CradleGas Skipping point " + point.origin + " because it overlaps players." );
                    continue;
                }
                
                playercount = players.size;
                
                if ( playercount > var_dd2c1f52fb6bb31e )
                {
                    bestpoint = point;
                    var_dd2c1f52fb6bb31e = playercount;
                    var_57d1078bf9939e45 = pointincircle;
                    function_8d2a17daae98575f( "CradleGas New Best Point set to " + point.origin + " with player count " + playercount );
                }
            }
            
            debuglog( "CradleGas Selected Spawn Point at " + bestpoint.origin + " with player count of " + var_dd2c1f52fb6bb31e );
            throttle::throttle_destroy( var_f5c0b6c651c57846 );
            return bestpoint;
        case #"hash_16e4c63ecf5fd28e":
            bestpoint = undefined;
            
            foreach ( point in points )
            {
                pointscore = getplayerinfluenceatposition( point.origin, 1 );
                
                if ( !isdefined( bestpoint ) || pointscore < getplayerinfluenceatposition( bestpoint.origin, 1 ) )
                {
                    bestpoint = point;
                }
            }
            
            return bestpoint;
        default:
            assertmsg( "<dev string:x2dc>" );
            break;
    }
}

// Namespace br_activity_scheduler
// Params 1, eflags: 0x4
// Checksum 0x3dbe3429, Offset: 0x41d8
// Size: 0x3a
function private spawnactivity( params )
{
    if ( randomfloat( 1 ) > params.spawnchance )
    {
        debuglog( "Spawning no activities because of spawn chance." );
        return;
    }
    
    thread function_886e7ee567ae912d( params );
}

// Namespace br_activity_scheduler
// Params 1, eflags: 0x4
// Checksum 0xc1db5ac0, Offset: 0x421a
// Size: 0x598
function private function_886e7ee567ae912d( params )
{
    /#
        level endon( #"hash_61e935b878210dac" );
    #/
    
    throttle = throttle::throttle_initialize_gate( "activity_spawn_per_frame", level.activityscheduler.var_af31955b6c9dfb64 );
    
    for ( i = 0; i < params.spawncount ; i++ )
    {
        throttle::throttle_wait_gate( throttle );
        totalweight = 0;
        weights = [];
        validactivities = [];
        var_b99336ee1ed60634 = [];
        var_c0c13a2ba9ba2b75 = [];
        chosenspawnpoints = [];
        
        foreach ( entry in params.schedule.var_a9dfc10a29865ad2 )
        {
            if ( function_d40b3aa8f34f046b( entry ) )
            {
                debuglog( "Excluding activity " + entry.activitydefinition + " because of Exclusion Conditions." );
                continue;
            }
            
            spawnpoints = function_df5dfb8dc4edbfd8( entry, params.schedule.label );
            
            if ( spawnpoints.size == 0 )
            {
                debuglog( "Excluding activity " + entry.activitydefinition + " because no valid spawn points exist." );
                continue;
            }
            
            var_f1b193699556675f = function_a8e5d27512ee04d8( spawnpoints, entry );
            
            if ( var_f1b193699556675f.size == 0 )
            {
                debuglog( "Excluding activity " + entry.activitydefinition + " because all valid spawn points were filtered out." );
                continue;
            }
            
            spawnpoint = selectspawnpoint( var_f1b193699556675f, entry.spawnselection );
            totalweight += entry.weight;
            weights[ weights.size ] = entry.weight;
            validactivities[ validactivities.size ] = entry.activitydefinition;
            var_b99336ee1ed60634[ var_b99336ee1ed60634.size ] = function_f857607443561e10( entry );
            var_c0c13a2ba9ba2b75[ var_c0c13a2ba9ba2b75.size ] = function_9546e862ccc51c79( entry ).var_6cb90bd34d18aa5b;
            chosenspawnpoints[ chosenspawnpoints.size ] = spawnpoint;
            
            foreach ( point in spawnpoints )
            {
                if ( point.origin == spawnpoint.origin )
                {
                    point.used = 1;
                    break;
                }
            }
        }
        
        if ( totalweight == 0 )
        {
            debuglog( "No activities were valid - skipping spawn action." );
            return;
        }
        
        roll = randomintrange( 0, totalweight );
        var_e171a4aa39610933 = undefined;
        
        for ( j = 0; j < weights.size ; j++ )
        {
            roll -= weights[ j ];
            
            if ( roll < 0 )
            {
                var_e171a4aa39610933 = j;
                debuglog( "Chose activity: " + validactivities[ var_e171a4aa39610933 ] );
                break;
            }
        }
        
        if ( !isdefined( var_e171a4aa39610933 ) )
        {
            assertmsg( "<dev string:x2fa>" );
        }
        
        varianttag = validactivities[ var_e171a4aa39610933 ];
        type = function_ccc4c48350d921bd( varianttag );
        
        if ( !isdefined( level.activityscheduler.var_243f162dc6e624e1[ type ] ) )
        {
            level.activityscheduler.var_243f162dc6e624e1[ type ] = 0;
        }
        
        level.activityscheduler.var_243f162dc6e624e1[ type ]++;
        
        if ( var_c0c13a2ba9ba2b75[ var_e171a4aa39610933 ] == "MapPlacedVariants" || var_c0c13a2ba9ba2b75[ var_e171a4aa39610933 ] == "ReferenceStructs" )
        {
            varianttag = chosenspawnpoints[ var_e171a4aa39610933 ].variant;
        }
        
        activityinstance = activity_instance_common::function_9b387cb1af0d5b4b( varianttag, chosenspawnpoints[ var_e171a4aa39610933 ].origin, { #angles:chosenspawnpoints[ var_e171a4aa39610933 ].angles, #scheduleractivitydefinition:validactivities[ var_e171a4aa39610933 ] } );
        level.activityscheduler.var_da8376c609ab3c58[ params.schedule.label ].var_34683e7f9fceb34f[ level.activityscheduler.var_da8376c609ab3c58[ params.schedule.label ].var_34683e7f9fceb34f.size ] = activityinstance;
        function_5e13d492785dd2d7( var_b99336ee1ed60634[ var_e171a4aa39610933 ], activityinstance );
        function_3967769b9010c430( activityinstance, level.activityscheduler.var_da8376c609ab3c58[ params.schedule.label ].partialactions );
        debuglog( "Spawned Activity " + i + 1 + " of " + params.spawncount + " " + varianttag + " at " + chosenspawnpoints[ var_e171a4aa39610933 ].origin );
        staggerduration = randomfloatrange( params.minstagger ?? 0, params.maxstagger ?? 0 );
        debuglog( "Waiting for random stagger: " + staggerduration + " seconds" );
        wait staggerduration;
    }
    
    throttle::throttle_destroy( throttle );
}

// Namespace br_activity_scheduler
// Params 2, eflags: 0x4
// Checksum 0x708f6165, Offset: 0x47ba
// Size: 0x89
function private function_3967769b9010c430( activityinstance, partialactions )
{
    if ( partialactions[ "EntersGas" ] )
    {
        thread gasdelay( activityinstance, partialactions[ "EntersGas" ], 1, 1 );
    }
    
    if ( partialactions[ "LeavesGas" ] )
    {
        thread gasdelay( activityinstance, partialactions[ "LeavesGas" ], 0, 1 );
    }
    
    if ( partialactions[ "EntersCircleGas" ] )
    {
        thread gasdelay( activityinstance, partialactions[ "EntersCircleGas" ], 1, 0 );
    }
    
    if ( partialactions[ "LeavesCircleGas" ] )
    {
        thread gasdelay( activityinstance, partialactions[ "LeavesCircleGas" ], 0, 0 );
    }
}

// Namespace br_activity_scheduler
// Params 4, eflags: 0x4
// Checksum 0x2f2ce60e, Offset: 0x484b
// Size: 0xac
function private gasdelay( activityinstance, partialactions, var_1e9a3e7dcf47b0bb, var_3ff7c16e0b69edb9 )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    
    while ( true )
    {
        point = activity_instance_common::function_776ee11e7acc64a5( activityinstance );
        var_171501653d192328 = br_circle::function_6bf5d4e680297398( point );
        
        if ( var_3ff7c16e0b69edb9 )
        {
            var_171501653d192328 = var_171501653d192328 || br_circle_util::function_4c6afbf2b757376a( point, 1 );
        }
        
        if ( var_1e9a3e7dcf47b0bb == var_171501653d192328 )
        {
            executeall( partialactions, activityinstance );
            return;
        }
        
        wait level.activityscheduler.var_cdcb86918ef004a4;
    }
}

// Namespace br_activity_scheduler
// Params 1, eflags: 0x4
// Checksum 0x1eeb0937, Offset: 0x48ff
// Size: 0xd7
function private function_b7e99426cd1629f3( params )
{
    activitylist = params.schedule.var_34683e7f9fceb34f;
    debuglog( "Scheduler notifying all activities from schedule " + params.schedule.label + " with " + params.notifyname );
    
    foreach ( activity in activitylist )
    {
        activity notify( params.notifyname );
    }
}

// Namespace br_activity_scheduler
// Params 1, eflags: 0x4
// Checksum 0xc3fd6af2, Offset: 0x49de
// Size: 0xe5
function private function_8438aa7c5011b57f( params )
{
    activitylist = level.activities.instances;
    debuglog( "Scheduler notifying all activities of type " + params.activitytype + " with " + params.notifyname );
    
    foreach ( activity in activitylist )
    {
        if ( issubstr( activity_instance_common::getactivitytype( activity ), params.activitytype ) )
        {
            activity notify( params.notifyname );
        }
    }
}

// Namespace br_activity_scheduler
// Params 2, eflags: 0x4
// Checksum 0xd8824142, Offset: 0x4acb
// Size: 0x37
function private function_2eb18c4f5c9fc19( params, activityinstance )
{
    if ( !activityinstance )
    {
        assertmsg( "<dev string:x31d>" );
    }
    
    activityinstance notify( params.notifyname );
}

// Namespace br_activity_scheduler
// Params 1, eflags: 0x4
// Checksum 0x26a6150a, Offset: 0x4b0a
// Size: 0x9d
function private function_75738fc8ac6c52a3( params )
{
    debuglog( "Scheduler cleaning up activities from schedule " + params.schedule.label );
    var_953429a7a0c24b12 = level.activityscheduler.var_da8376c609ab3c58[ params.schedule.label ].var_34683e7f9fceb34f;
    
    for ( i = 0; i < var_953429a7a0c24b12.size - params.mincount ; i++ )
    {
        activity_instance_common::function_9aeeabe50fc9cc3e( var_953429a7a0c24b12[ i ] );
    }
}

// Namespace br_activity_scheduler
// Params 2, eflags: 0x4
// Checksum 0x96b34379, Offset: 0x4baf
// Size: 0x5b
function private function_dcfb24ab41438f09( params, activityinstance )
{
    if ( !activityinstance )
    {
        assertmsg( "<dev string:x35e>" );
    }
    
    debuglog( "Scheduler cleaning up activity " + activityinstance.varianttag + ":" + activityinstance.id );
    activity_instance_common::function_9aeeabe50fc9cc3e( activityinstance );
}

// Namespace br_activity_scheduler
// Params 0, eflags: 0xc
// Checksum 0x6a2a562b, Offset: 0x4c12
// Size: 0xb0
function private function_faee9e8392928da3()
{
    self notify( #"hash_999d32247500996c" );
    self endon( #"hash_999d32247500996c" );
    level endon( #"game_ended" );
    level childthread function_1491cb550ce543();
    level childthread function_a5b4dc2499bba0c0( "br_circle_set", level.activityscheduler.circleactions[ "CircleSet" ] );
    level childthread function_a5b4dc2499bba0c0( "br_circle_started", level.activityscheduler.circleactions[ "CircleBeginClose" ] );
    level childthread function_a5b4dc2499bba0c0( "br_circle_closed", level.activityscheduler.circleactions[ "CircleClosed" ] );
    level childthread watchtimeractions();
    level childthread function_f9e8ab5d63547d07();
}

// Namespace br_activity_scheduler
// Params 0, eflags: 0x4
// Checksum 0xbfdc646e, Offset: 0x4cca
// Size: 0x49
function private function_1491cb550ce543()
{
    /#
        if ( getdvarint( @"hash_330aada25d5aa8ab", 0 ) )
        {
            return;
        }
    #/
    
    flags::function_2f3408423ccc9b2e( "prematch_cleanup_done" );
    debuglog( "Scheduler firing events for match start!" );
    executeall( level.activityscheduler.matchstartactions );
}

// Namespace br_activity_scheduler
// Params 2, eflags: 0x4
// Checksum 0x3f0d10ae, Offset: 0x4d1b
// Size: 0x6e
function private function_a5b4dc2499bba0c0( notifyname, eventtrack )
{
    while ( true )
    {
        level waittill( notifyname );
        debuglog( "Scheduler firing for circle index " + level.br_circle.circleindex + " " + notifyname );
        executeall( eventtrack[ "" + level.br_circle.circleindex ] );
    }
}

// Namespace br_activity_scheduler
// Params 2, eflags: 0x4
// Checksum 0x96ca737a, Offset: 0x4d91
// Size: 0xbe
function private function_b1d1d9bb11960e25( timewaited, timeractions )
{
    besttime = undefined;
    
    foreach ( timer, actions in timeractions )
    {
        floattime = float( timer );
        
        if ( floattime < timewaited + 0.001 )
        {
            continue;
        }
        
        if ( !isdefined( besttime ) || floattime < besttime )
        {
            besttime = floattime;
        }
    }
    
    return besttime;
}

// Namespace br_activity_scheduler
// Params 1, eflags: 0x4
// Checksum 0x25988c9e, Offset: 0x4e58
// Size: 0x13a
function private watchtimertype( var_733790371248277f )
{
    switch ( var_733790371248277f )
    {
        case #"hash_cf939cfe79a5c027":
            level waittill( #"prematch_fade_done" );
            break;
        case #"hash_d2aba1b4c847a6b8":
            flags::function_2f3408423ccc9b2e( "br_ready_to_jump" );
            break;
        default:
            assertmsg( "<dev string:x39c>" );
            break;
    }
    
    debuglog( "Began executing timer events for: " + var_733790371248277f );
    timewaited = 0;
    
    for ( i = 0; i < level.activityscheduler.timeractions[ var_733790371248277f ].size ; i++ )
    {
        nexttime = function_b1d1d9bb11960e25( timewaited, level.activityscheduler.timeractions[ var_733790371248277f ] );
        
        if ( !isdefined( nexttime ) )
        {
            assertmsg( "<dev string:x3b6>" );
        }
        
        wait nexttime - timewaited;
        timewaited = float( nexttime );
        debuglog( "Executing events for " + var_733790371248277f + " + " + timewaited );
        executeall( level.activityscheduler.timeractions[ var_733790371248277f ][ nexttime + "" ] );
    }
}

// Namespace br_activity_scheduler
// Params 0, eflags: 0x4
// Checksum 0x3f8fbe62, Offset: 0x4f9a
// Size: 0x1a
function private watchtimeractions()
{
    childthread watchtimertype( "prematch_fade_done" );
    childthread watchtimertype( "br_ready_to_jump" );
}

// Namespace br_activity_scheduler
// Params 0, eflags: 0x4
// Checksum 0xe372750b, Offset: 0x4fbc
// Size: 0x86
function private function_f9e8ab5d63547d07()
{
    foreach ( notifyname, action in level.activityscheduler.levelnotifyactions )
    {
        childthread notifywatcher( notifyname, action );
    }
}

// Namespace br_activity_scheduler
// Params 2, eflags: 0x4
// Checksum 0xa8223d19, Offset: 0x504a
// Size: 0x33
function private notifywatcher( notifyname, actions )
{
    self waittill( notifyname );
    debuglog( "Scheduler firing events for " + notifyname );
    executeall( actions );
}

// Namespace br_activity_scheduler
// Params 2, eflags: 0x4
// Checksum 0xe5b9deeb, Offset: 0x5085
// Size: 0x115
function private executeall( actions, extradata )
{
    /#
        level endon( #"hash_61e935b878210dac" );
    #/
    
    foreach ( action in actions )
    {
        throttle::throttle_wait_gate( level.activityscheduler.var_c8113077425d5dc3 );
        
        if ( extradata )
        {
            utility::delaythread( action.params.delay, action.function, action.params, extradata );
            continue;
        }
        
        utility::delaythread( action.params.delay, action.function, action.params );
    }
}

// Namespace br_activity_scheduler
// Params 1, eflags: 0x4
// Checksum 0xab2391ad, Offset: 0x51a2
// Size: 0x19
function private debuglog( string )
{
    logstring( "[BR Activity Scheduler] " + string );
}

// Namespace br_activity_scheduler
// Params 1, eflags: 0x4
// Checksum 0x92f5e82a, Offset: 0x51c3
// Size: 0x2d
function private function_8d2a17daae98575f( string )
{
    if ( getdvarint( @"hash_17dbc23923fb8c44", 0 ) == 1 )
    {
        logstring( "[BR Activity Scheduler] " + string );
    }
}

// Namespace br_activity_scheduler
// Params 0, eflags: 0x4
// Checksum 0xb4dc0d44, Offset: 0x51f8
// Size: 0x15b
function private function_e305524af521b5f8()
{
    foreach ( name, pool in level.activityscheduler.resources )
    {
        logstring( "[BR Activity Scheduler] Pool Name: " + name + " Capacity: " + pool.capacity );
        var_c07834dfd5f680cd = 0;
        
        foreach ( reservation in pool.var_5f373363df1057ed )
        {
            logstring( "[BR Activity Scheduler] Activity ID: " + reservation.activityinstanceid + " Count: " + reservation.count );
            var_c07834dfd5f680cd += reservation.count;
        }
        
        logstring( "[BR Activity Scheduler] Total Usage: " + var_c07834dfd5f680cd );
    }
}

/#

    // Namespace br_activity_scheduler
    // Params 1, eflags: 0x4
    // Checksum 0x709733f8, Offset: 0x535b
    // Size: 0x72, Type: dev
    function private function_da8e475342a8d1e( params )
    {
        action = level.activityscheduler.circleactions[ params[ 0 ] ][ params[ 1 ] ][ int( params[ 2 ] ) ];
        utility::delaythread( action.params.delay, action.function, action.params );
    }

    // Namespace br_activity_scheduler
    // Params 1, eflags: 0x4
    // Checksum 0xbf95607e, Offset: 0x53d5
    // Size: 0x158, Type: dev
    function private function_55097a295e68c1a8( circleevent )
    {
        foreach ( circleindex, var_b9d05dca1ff31780 in level.activityscheduler.circleactions[ circleevent ] )
        {
            foreach ( actionindex, action in var_b9d05dca1ff31780 )
            {
                var_699de4c95afbf0cc = int( circleindex ) + 1;
                devgui::function_cd4e263c1f3018ae( "<dev string:x3d9>" + action.var_5868d186373af428 + "<dev string:x3e4>" + var_699de4c95afbf0cc + "<dev string:x3ed>" + action.debugname, "<dev string:x3f3>" + circleevent + "<dev string:x40b>" + circleindex + "<dev string:x40b>" + actionindex, &function_da8e475342a8d1e );
            }
        }
    }

    // Namespace br_activity_scheduler
    // Params 1, eflags: 0x4
    // Checksum 0x60b3d3fa, Offset: 0x5535
    // Size: 0x68, Type: dev
    function private function_5aa98c4a1271a479( params )
    {
        action = level.activityscheduler.matchstartactions[ int( params[ 0 ] ) ];
        utility::delaythread( action.params.delay, action.function, action.params );
    }

    // Namespace br_activity_scheduler
    // Params 0, eflags: 0x4
    // Checksum 0x65db4a90, Offset: 0x55a5
    // Size: 0xb6, Type: dev
    function private function_e709e227bca6d42d()
    {
        foreach ( actionindex, action in level.activityscheduler.matchstartactions )
        {
            devgui::function_cd4e263c1f3018ae( "<dev string:x3d9>" + action.var_5868d186373af428 + "<dev string:x40d>" + action.debugname, "<dev string:x41b>" + actionindex, &function_5aa98c4a1271a479 );
        }
    }

    // Namespace br_activity_scheduler
    // Params 0, eflags: 0x4
    // Checksum 0x190e422a, Offset: 0x5663
    // Size: 0x10f, Type: dev
    function private function_d9d1ff53f73a38cf()
    {
        foreach ( schedule in level.activityscheduler.var_da8376c609ab3c58 )
        {
            devgui::function_cd4e263c1f3018ae( "<dev string:x3d9>" + schedule.schedule.label + "<dev string:x437>", "<dev string:x449>" + schedule.schedule.label, &function_f376b5d1e109ff30 );
            devgui::function_cd4e263c1f3018ae( "<dev string:x3d9>" + schedule.schedule.label + "<dev string:x458>", "<dev string:x479>" + schedule.schedule.label, &function_4355dd700bac01a0 );
        }
    }

    // Namespace br_activity_scheduler
    // Params 1, eflags: 0x4
    // Checksum 0xefe9ca04, Offset: 0x577a
    // Size: 0x5e, Type: dev
    function private function_4355dd700bac01a0( params )
    {
        if ( !level.activityscheduler.var_50b0dd2f17f344fc[ params[ 0 ] ] )
        {
            level.activityscheduler.var_50b0dd2f17f344fc[ params[ 0 ] ] = 1;
            return;
        }
        
        level.activityscheduler.var_50b0dd2f17f344fc[ params[ 0 ] ] = undefined;
    }

    // Namespace br_activity_scheduler
    // Params 1, eflags: 0x4
    // Checksum 0x7ccdf953, Offset: 0x57e0
    // Size: 0x1c1, Type: dev
    function private function_f376b5d1e109ff30( params )
    {
        level notify( #"hash_bff2af8120fe74dd" );
        
        if ( !isdefined( level.activityscheduler.spawnpoints[ params[ 0 ] ] ) )
        {
            println( "<dev string:x496>" + params[ 0 ] + "<dev string:x4bf>" );
            function_df5dfb8dc4edbfd8( level.activityscheduler.var_da8376c609ab3c58[ params[ 0 ] ].schedule.var_a9dfc10a29865ad2[ 0 ], level.activityscheduler.var_da8376c609ab3c58[ params[ 0 ] ].schedule.label );
        }
        
        foreach ( spawn in level.activityscheduler.spawnpoints[ params[ 0 ] ] )
        {
            if ( spawn.used )
            {
                function_64af1e327012c3fb( spawn.variant, spawn.origin, spawn.angles, "<dev string:x548>", level.activityscheduler.var_50b0dd2f17f344fc[ params[ 0 ] ] );
                continue;
            }
            
            function_64af1e327012c3fb( spawn.variant, spawn.origin, spawn.angles, "<dev string:x54e>", level.activityscheduler.var_50b0dd2f17f344fc[ params[ 0 ] ] );
        }
    }

    // Namespace br_activity_scheduler
    // Params 5, eflags: 0x4
    // Checksum 0x3e32261d, Offset: 0x59a9
    // Size: 0x173, Type: dev
    function private function_64af1e327012c3fb( text, origin, angles, coloroverride, circlesblocked )
    {
        switch ( coloroverride )
        {
            case #"hash_883ff07272b4f9c":
                color = ( 0, 1, 0 );
                questcircle = "<dev string:x552>";
                break;
            case #"hash_97430f6c58e61cbc":
            default:
                color = ( 1, 0, 0 );
                questcircle = "<dev string:x562>";
                break;
        }
        
        forward = anglestoforward( angles ?? ( 0, 0, 0 ) );
        timesec = getdvarint( @"hash_67d5df901321f3d5", 600 );
        timeframes = int( timesec / level.framedurationseconds );
        thread function_62a0da817d4c56f4( text, origin, color, timeframes );
        ray = origin + ( 0, 0, 20000 );
        forwardpos = origin + forward * 75;
        thread utility::draw_line_for_time( origin, ray, color[ 0 ], color[ 1 ], color[ 2 ], timesec, "<dev string:x574>" );
        thread function_97281f569ff975da( origin, forwardpos, color, timesec );
        
        if ( !circlesblocked )
        {
            thread function_b42f365dd49ec568( questcircle, origin[ 0 ], origin[ 1 ], 400, self, timesec );
        }
    }

    // Namespace br_activity_scheduler
    // Params 4, eflags: 0x4
    // Checksum 0xd95f5f3c, Offset: 0x5b24
    // Size: 0x66, Type: dev
    function private function_97281f569ff975da( origin, forwardpos, color, time )
    {
        level endon( #"hash_bff2af8120fe74dd" );
        endtime = gettime() + time * 1000;
        
        while ( gettime() < endtime )
        {
            utility::draw_arrow( origin, forwardpos, color );
            waitframe();
        }
    }

    // Namespace br_activity_scheduler
    // Params 4, eflags: 0x4
    // Checksum 0x9f960480, Offset: 0x5b92
    // Size: 0x73, Type: dev
    function private function_62a0da817d4c56f4( text, origin, color, timeframes )
    {
        level endon( #"hash_bff2af8120fe74dd" );
        
        while ( timeframes > 0 )
        {
            print3d( origin, text, color, 1, 10, 10, 1 );
            timeframes -= 10;
            timesec = 10 * level.framedurationseconds;
            wait timesec;
        }
    }

    // Namespace br_activity_scheduler
    // Params 6, eflags: 0x4
    // Checksum 0x4e8d3950, Offset: 0x5c0d
    // Size: 0x76, Type: dev
    function private function_b42f365dd49ec568( id, x, y, radius, owner, time )
    {
        wait 1;
        mapcircle = spawnquestcircle( id, x, y, radius, self );
        mapcircle show();
        level utility::waittill_any_timeout( time, "<dev string:x574>" );
        mapcircle delete();
    }

    // Namespace br_activity_scheduler
    // Params 1, eflags: 0x4
    // Checksum 0xc51c4317, Offset: 0x5c8b
    // Size: 0xd0, Type: dev
    function private function_c686343cfb8bbcab( params )
    {
        var_b9d05dca1ff31780 = level.activityscheduler.timeractions[ params[ 0 ] ][ params[ 1 ] ];
        
        foreach ( action in var_b9d05dca1ff31780 )
        {
            utility::delaythread( action.params.delay, action.function, action.params );
        }
    }

    // Namespace br_activity_scheduler
    // Params 1, eflags: 0x4
    // Checksum 0x1cd60ce7, Offset: 0x5d63
    // Size: 0x149, Type: dev
    function private function_54be2e0c8a101a7d( timertype )
    {
        foreach ( actionindex, var_b9d05dca1ff31780 in level.activityscheduler.timeractions[ timertype ] )
        {
            foreach ( action in var_b9d05dca1ff31780 )
            {
                devgui::function_cd4e263c1f3018ae( "<dev string:x3d9>" + action.var_5868d186373af428 + "<dev string:x586>" + timertype + "<dev string:x58e>" + int( actionindex ) + "<dev string:x592>" + action.debugname, "<dev string:x595>" + timertype + "<dev string:x40b>" + actionindex, &function_c686343cfb8bbcab );
            }
        }
    }

    // Namespace br_activity_scheduler
    // Params 0, eflags: 0x4
    // Checksum 0x715a6679, Offset: 0x5eb4
    // Size: 0xa2, Type: dev
    function private schedulerdevgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x5ac>" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x5c3>", @"hash_684e4cd9ea43ba8d" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x5e7>", @"hash_330aada25d5aa8ab" );
        devgui::add_devgui_func( "<dev string:x60c>", "<dev string:x620>", &function_e305524af521b5f8 );
        function_e709e227bca6d42d();
        function_d9d1ff53f73a38cf();
        function_55097a295e68c1a8( "<dev string:x639>" );
        function_55097a295e68c1a8( "<dev string:x646>" );
        function_55097a295e68c1a8( "<dev string:x650>" );
        function_54be2e0c8a101a7d( "<dev string:x661>" );
        function_54be2e0c8a101a7d( "<dev string:x674>" );
        devgui::function_77df7fe7dd273e10();
    }

#/
