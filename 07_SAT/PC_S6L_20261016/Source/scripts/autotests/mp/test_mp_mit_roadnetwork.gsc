// scripts\autotests\mp\test_mp_mit_roadnetwork.gsc  (hash_0adb1ff0ef5b7b57.gscc) (size: 3525 Bytes / 0xdc5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x391756c8 (957830856)
// size ...... 3525 (0xdc5)
// includes .. 6   (offset: 0xc61)
// strings ... 21  (offset: 0xc91)
// dev strs .. 1   (offset: 0xdb9)
// exports ... 6   (offset: 0x8b5)
// cseg ...... 0x227 + 0x68e (0x8b5)
// imports ... 24  (offset: 0x9a5)
// animtree1 . 0   (offset: 0xdc5)
// animtree2 . 0   (offset: 0xdc5)
#using script_3d2770dc09c1243;
#using scripts\autotests\autotests;
#using scripts\common\utility;
#using scripts\common\vehicle_roads;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\utility\game_utility;

#namespace test_mp_mit_roadnetwork;

// Namespace test_mp_mit_roadnetwork/testautomation
// Params 0, eflags: 0x20
// Checksum 0x86ae8196, Offset: 0x245
// Size: 0x26
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_mit_roadnetwork.gsc", #"gp_vehicles", &start_test, &setup, &cleanup_test );
}

// Namespace test_mp_mit_roadnetwork
// Params 0, eflags: 0x4
// Checksum 0xc539d9db, Offset: 0x273
// Size: 0xc
function private cleanup_test()
{
    level.var_5613c4ec1d021fbf = 0;
}

// Namespace test_mp_mit_roadnetwork
// Params 0, eflags: 0x4
// Checksum 0x4e2ff734, Offset: 0x287
// Size: 0x24, Type: bool
function private setup()
{
    autotests::function_5c8c87763724c132();
    utility::flag_wait( "vehicle_init_done" );
    level.var_5613c4ec1d021fbf = 0;
    wait 30;
    return true;
}

// Namespace test_mp_mit_roadnetwork
// Params 0, eflags: 0x4
// Checksum 0xe7ff47af, Offset: 0x2b4
// Size: 0x46c
function private start_test()
{
    var_99c2e1e399b978d5 = 0;
    var_95127e6f3c0e2708 = 0;
    contents = physics_createcontents( [ "physicscontents_item", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_playerclip" ] );
    ignore = vehicle_tracking::function_5820a38c9873992e();
    caststhisframe = 0;
    var_27994b09a1d37d56 = [];
    
    foreach ( road in level.roads )
    {
        var_27994b09a1d37d56 = arraycombineunique( var_27994b09a1d37d56, road.connections, [ road.key ] );
    }
    
    visited = [];
    
    foreach ( targetname in var_27994b09a1d37d56 )
    {
        vehiclenode = vehicle_roads::function_d5de32e196353afe( targetname );
        
        if ( visited[ vehiclenode.index ] )
        {
            continue;
        }
        
        visited[ vehiclenode.index ] = 1;
        vehiclenode.groundpos = utility::drop_to_ground( vehiclenode.origin, 200 ) + ( 0, 0, 125 );
        
        if ( distance( vehiclenode.origin, vehiclenode.groundpos ) > 5000 )
        {
            vehiclenode.groundpos = getclosestpointonnavmesh( vehiclenode.origin, level.vehiclenavmeshlayer ) + ( 0, 0, 125 );
        }
        
        while ( vehiclenode.target )
        {
            var_99c2e1e399b978d5 += 1;
            startorigin = vehiclenode.groundpos;
            vehiclenode = vehicle_roads::function_d5de32e196353afe( vehiclenode.target );
            
            if ( visited[ vehiclenode.index ] )
            {
                break;
            }
            
            visited[ vehiclenode.index ] = 1;
            vehiclenode.groundpos = utility::drop_to_ground( vehiclenode.origin, 200 ) + ( 0, 0, 125 );
            
            if ( distance( vehiclenode.origin, vehiclenode.groundpos ) > 5000 )
            {
                vehiclenode.groundpos = getclosestpointonnavmesh( vehiclenode.origin, level.vehiclenavmeshlayer ) + ( 0, 0, 125 );
            }
            
            cast = physics_spherecast( startorigin, vehiclenode.groundpos, 50, contents, ignore, "physicsquery_closest", "physicsquery_any", 1 );
            
            if ( cast.size > 0 && isdefined( cast[ 0 ][ 0 ][ "position" ] ) )
            {
                roadsegment = [ { #targetname:"road_start_" + vehiclenode.index, #origin:startorigin }, { #targetname:"road_end_" + vehiclenode.index, #origin:vehiclenode.groundpos } ];
                blockageposition = cast[ 0 ][ 0 ][ "position" ];
                comment = "blockage_at=" + blockageposition + " distance=" + distance( startorigin, blockageposition );
                report( "road_blockage", undefined, startorigin, roadsegment, comment );
                
                /#
                    line( startorigin, vehiclenode.groundpos, ( 1, 0, 0 ), 1, 0, 100000 );
                    sphere( cast[ 0 ][ 0 ][ "<dev string:x24>" ], 20, ( 1, 0, 0 ), 0, 100000 );
                #/
                
                var_95127e6f3c0e2708 += 1;
            }
            
            caststhisframe += 1;
            
            if ( caststhisframe >= 50 )
            {
                waitframe();
                caststhisframe = 0;
            }
        }
    }
}

// Namespace test_mp_mit_roadnetwork
// Params 5, eflags: 0x4
// Checksum 0x86cb6791, Offset: 0x728
// Size: 0x18d
function private report( situation, bot, position, roadtarget, commentoverride )
{
    if ( !level.var_5613c4ec1d021fbf )
    {
        test_session_id = getdvar( @"dlog_apollo_test_session_id", "0" );
        mapname = game_utility::getmapname();
        logstring( "[MIT] Task; " + test_session_id + "; " + mapname );
        header = "#time; #situation; #bot; #lastPosition; #roadSegmentStart; #roadSegmentEnd; #comment";
        mit::outputlog( "RoadNetwork", header );
        level.var_5613c4ec1d021fbf = 1;
    }
    
    botentitynumber = "";
    
    if ( isdefined( bot ) )
    {
        botentitynumber = bot getentitynumber();
    }
    
    lastposition = "";
    
    if ( isdefined( position ) )
    {
        lastposition = position;
    }
    
    var_cafab89380860fdb = "";
    var_3111b21a2aff343e = "";
    
    if ( isdefined( roadtarget ) )
    {
        var_cafab89380860fdb = roadtarget[ 0 ].origin;
        var_3111b21a2aff343e = roadtarget[ 1 ].origin;
    }
    
    comment = "";
    
    if ( isdefined( commentoverride ) )
    {
        comment = commentoverride;
    }
    
    reportstring = gettime() + "; " + situation + "; " + botentitynumber + "; " + lastposition + "; " + var_cafab89380860fdb + "; " + var_3111b21a2aff343e + "; " + comment;
    mit::outputlog( "Roadnetwork", reportstring );
}

