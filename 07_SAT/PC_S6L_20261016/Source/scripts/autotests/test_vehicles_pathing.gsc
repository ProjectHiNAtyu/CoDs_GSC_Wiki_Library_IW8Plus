// scripts\autotests\test_vehicles_pathing.gsc  (hash_2a06e81642871bb1.gscc) (size: 4586 Bytes / 0x11ea / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8669d04a (2255081546)
// size ...... 4586 (0x11ea)
// includes .. 5   (offset: 0x1086)
// strings ... 22  (offset: 0x10ae)
// dev strs .. 0   (offset: 0x11ea)
// exports ... 10  (offset: 0xa02)
// cseg ...... 0x1e9 + 0x819 (0xa02)
// imports ... 43  (offset: 0xb92)
// animtree1 . 0   (offset: 0x11ea)
// animtree2 . 0   (offset: 0x11ea)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility_player;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\common\vehicle;

#namespace test_vehicles_pathing;

// Namespace test_vehicles_pathing/testautomation
// Params 0, eflags: 0x20
// Checksum 0x281fa8f7, Offset: 0x207
// Size: 0x26
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/test_vehicles_pathing.gsc", #"gp_vehicles", &start_test, &setup, &cleanup_test );
}

// Namespace test_vehicles_pathing
// Params 0
// Checksum 0x6655263b, Offset: 0x235
// Size: 0x17, Type: bool
function setup()
{
    autotests::function_5c8c87763724c132();
    utility::flag_wait( "vehicle_init_done" );
    return true;
}

// Namespace test_vehicles_pathing
// Params 0
// Checksum 0xaa572cf3, Offset: 0x255
// Size: 0xd3, Type: bool
function start_test()
{
    bundle = autotests::get_test_bundle( self.test.xhash_ref );
    player = autotests_utility_player::get_player();
    level.autotests.test_runtime.player = player;
    level.autotests.test_runtime.bundle = bundle;
    
    if ( bundle.var_a4b59e60379a557 )
    {
        autotests::push_function( "P2P Pathing" );
        test_result_int = function_a06249d2bb46c4ed() ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "P2P Pathing", test_result_int, undefined, undefined, "scripts/autotests/test_vehicles_pathing.gsc", 49 );
        autotests::pop_function( "P2P Pathing" );
        autotests::test_assert_return( test_result_int );
    }
    
    return false;
}

// Namespace test_vehicles_pathing
// Params 0
// Checksum 0x13bed191, Offset: 0x331
// Size: 0x7a
function cleanup_test()
{
    level notify( #"test_vehicles_pathing_finished" );
    veh = level.autotests.test_runtime.veh;
    
    if ( isdefined( veh ) )
    {
        veh delete();
    }
    
    player = level.autotests.test_runtime.player;
    
    if ( isdefined( player ) )
    {
        player autotests_utility_player::reset_player_angles();
    }
}

// Namespace test_vehicles_pathing
// Params 0
// Checksum 0xd2863c2b, Offset: 0x3b3
// Size: 0x216
function function_a06249d2bb46c4ed()
{
    player = level.autotests.test_runtime.player;
    bundle = level.autotests.test_runtime.bundle;
    points = player generate_points();
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "[" + ( bundle.var_4fa6773281b28978 ?? 10 ) + "] points were generated?", points, "scripts/autotests/test_vehicles_pathing.gsc", 78 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    veh = function_4298ed01dc62c70d( points );
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Was able to spawn vehicle? [" + bundle.var_1cdd682debbaa95e + "]", veh, "scripts/autotests/test_vehicles_pathing.gsc", 81 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    level.autotests.test_runtime.veh = veh;
    veh thread navigate_points( points );
    player thread watch_vehicle( veh );
    navigate_timeout = bundle.testdurationseconds ?? 30;
    result = level utility::waittill_any_timeout( navigate_timeout, "test_vehicles_pathing_finished" );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Navigated points within " + navigate_timeout + "s?", result != "timeout", "scripts/autotests/test_vehicles_pathing.gsc", 89 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e5041006e5cc3d56( "Made it to destination?", bundle.var_ed386cd288baf38c ?? 100, distance( veh.origin, points[ points.size - 1 ] ), "scripts/autotests/test_vehicles_pathing.gsc", 91 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    return 0;
}

// Namespace test_vehicles_pathing
// Params 0, eflags: 0x4
// Checksum 0x5eb8f8b6, Offset: 0x5d2
// Size: 0x158
function private generate_points()
{
    bundle = level.autotests.test_runtime.bundle;
    radius = bundle.var_53c46b49a1ed6c13 ?? 1000;
    num_points = bundle.var_4fa6773281b28978 ?? 10;
    height_offset = bundle.var_486118fd8e2d82a5 ?? 50;
    
    /#
        origin_override = getdvarvector( @"hash_8862ce25b633d8a9", self.origin );
        
        if ( origin_override != self.origin )
        {
            self setorigin( origin_override );
        }
    #/
    
    slice = math::round_float( 360 / num_points, 0, 0 );
    points = [];
    t = 0;
    
    while ( t < 360 )
    {
        x = radius * cos( t ) + self.origin[ 0 ];
        y = radius * sin( t ) + self.origin[ 1 ];
        points[ points.size ] = ( x, y, self.origin[ 2 ] + height_offset );
        t += slice;
    }
    
    if ( points.size < num_points )
    {
        return;
    }
    
    return points;
}

// Namespace test_vehicles_pathing
// Params 1, eflags: 0x4
// Checksum 0x19f36a1e, Offset: 0x733
// Size: 0x13c
function private function_4298ed01dc62c70d( points )
{
    bundle = level.autotests.test_runtime.bundle;
    veh_ref = bundle.var_1cdd682debbaa95e ?? "veh_rex_lnd_6x6";
    veh_origin = points[ 0 ];
    veh_angles = vectortoangles( vectornormalize( points[ 1 ] - veh_origin ) );
    veh = vehicle::spawn( veh_ref, { #angles:veh_angles, #origin:veh_origin } );
    
    if ( !isdefined( veh ) )
    {
        return;
    }
    
    veh addcomponent( "p2p" );
    veh function_eb88c4e66edbc855( "p2p", "checkStuck", 0 );
    veh function_eb88c4e66edbc855( "p2p", "brakeAtGoal", 0 );
    veh function_eb88c4e66edbc855( "p2p", "stopAtGoal", veh vehicle::ishelicopter() );
    veh function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( bundle.p2p_speed ?? 45 ) );
    veh function_eb88c4e66edbc855( "p2p", "goalThreshold", bundle.var_ed386cd288baf38c ?? 100 );
    return veh;
}

// Namespace test_vehicles_pathing
// Params 1, eflags: 0x4
// Checksum 0xc7878e47, Offset: 0x878
// Size: 0xed
function private navigate_points( points )
{
    level endon( #"game_ended" );
    level endon( #"test_vehicles_pathing_finished" );
    
    foreach ( index, point in points )
    {
        /#
            sphere( point, 25, ( 0, 1, 0 ), 0, 300 );
        #/
        
        self function_eb88c4e66edbc855( "p2p", "goalPoint", point );
        self waittill( #"near_goal" );
        autotests::report_info( "Made it to point[" + index + "]: " + point );
    }
    
    level notify( #"test_vehicles_pathing_finished" );
}

// Namespace test_vehicles_pathing
// Params 1, eflags: 0x4
// Checksum 0xfba78fd7, Offset: 0x96d
// Size: 0x95
function private watch_vehicle( veh )
{
    level endon( #"game_ended" );
    level endon( #"test_vehicles_pathing_finished" );
    bundle = level.autotests.test_runtime.bundle;
    
    if ( bundle.var_eacccfe4a9ee95c4 )
    {
        self setorigin( veh.origin * ( 1, 1, 0 ) + ( 300, 0, self.origin[ 2 ] ) );
    }
    
    childthread autotests_utility_player::function_9275480f08b78840( veh );
}

