// scripts\autotests\test_mit.gsc  (hash_540fb264c9b68e6a.gscc) (size: 9677 Bytes / 0x25cd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4165de68 (1097195112)
// size ...... 9677 (0x25cd)
// includes .. 4   (offset: 0x21d5)
// strings ... 66  (offset: 0x21f5)
// dev strs .. 1   (offset: 0x25c1)
// exports ... 17  (offset: 0x1959)
// cseg ...... 0x5d6 + 0x1383 (0x1959)
// imports ... 39  (offset: 0x1c01)
// animtree1 . 0   (offset: 0x25cd)
// animtree2 . 0   (offset: 0x25cd)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_telemetry;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_player;

#namespace test_mit;

// Namespace test_mit/testautomation
// Params 0, eflags: 0x20
// Checksum 0xda2ea14f, Offset: 0x5f4
// Size: 0x31
function event_handler[testautomation] main()
{
    test = autotests::register_tests( "scripts/autotests/test_mit.gsc", #"test", &start_test, &setup, &cleanup );
}

// Namespace test_mit
// Params 0
// Checksum 0xf803d7a4, Offset: 0x62d
// Size: 0xb, Type: bool
function setup()
{
    autotests::function_5c8c87763724c132();
    return true;
}

// Namespace test_mit
// Params 0, eflags: 0x4
// Checksum 0xb752ec03, Offset: 0x641
// Size: 0x9
function private cleanup()
{
    autotests_utility::cleanup();
}

// Namespace test_mit
// Params 0
// Checksum 0x85229965, Offset: 0x652
// Size: 0x15d
function start_test()
{
    bundle = autotests::get_test_bundle( self.test.xhash_ref );
    autotests::push_function( "Single event with default callback" );
    test_result_int = function_ea9b84c9dc7c540a( bundle ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Single event with default callback", test_result_int, undefined, undefined, "scripts/autotests/test_mit.gsc", 39 );
    autotests::pop_function( "Single event with default callback" );
    autotests::test_assert_return( test_result_int );
    wait 0.75;
    autotests::push_function( "Single event with explicit callback" );
    test_result_int = function_f35a649abea2419f( bundle ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Single event with explicit callback", test_result_int, undefined, undefined, "scripts/autotests/test_mit.gsc", 41 );
    autotests::pop_function( "Single event with explicit callback" );
    autotests::test_assert_return( test_result_int );
    wait 0.75;
    autotests::push_function( "Batch events with explicit callback" );
    test_result_int = function_dbbf90abe6e86580( bundle ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Batch events with explicit callback", test_result_int, undefined, undefined, "scripts/autotests/test_mit.gsc", 43 );
    autotests::pop_function( "Batch events with explicit callback" );
    autotests::test_assert_return( test_result_int );
    wait 0.75;
    autotests::push_function( "Batch events with default callback" );
    test_result_int = function_ee7f1d2166dd2061( bundle ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Batch events with default callback", test_result_int, undefined, undefined, "scripts/autotests/test_mit.gsc", 45 );
    autotests::pop_function( "Batch events with default callback" );
    autotests::test_assert_return( test_result_int );
}

// Namespace test_mit
// Params 0
// Checksum 0xe44dd81, Offset: 0x7b7
// Size: 0x53
function player_found()
{
    player = autotests_utility_player::get_player();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player found", isdefined( player ), "scripts/autotests/test_mit.gsc", 51 );
    
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

// Namespace test_mit
// Params 1
// Checksum 0xa9a816b, Offset: 0x813
// Size: 0x115
function function_ea9b84c9dc7c540a( bundle )
{
    player_found();
    batch = function_b45c21c8ce5767fd( bundle );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Spatial Event Valid?", isdefined( batch.events[ 0 ] ), "scripts/autotests/test_mit.gsc", 64 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    level.autotests.test_runtime.var_552e784db1ce905d = 0;
    autotests_telemetry::spatial_event_send( batch.events[ 0 ], bundle.var_77d94d1b1267e36c, &response_callback, bundle.dryrun );
    starttime = gettime();
    
    while ( !level.autotests.test_runtime.var_552e784db1ce905d )
    {
        waitframe();
        
        if ( gettime() - starttime > 15000 )
        {
            autotests::function_d84657f448aaeef6( "HTTP response did not come back in 15 sec!", 0, "scripts/autotests/test_mit.gsc", 67 );
            return;
        }
    }
    
    return 0;
}

// Namespace test_mit
// Params 1
// Checksum 0xc059cd77, Offset: 0x931
// Size: 0x9c
function function_f35a649abea2419f( bundle )
{
    player_found();
    batch = function_b45c21c8ce5767fd( bundle );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Spatial Event Valid?", isdefined( batch.events[ 0 ] ), "scripts/autotests/test_mit.gsc", 80 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests_telemetry::spatial_event_send( batch.events[ 0 ], bundle.var_77d94d1b1267e36c, undefined, bundle.dryrun );
    return 0;
}

// Namespace test_mit
// Params 1
// Checksum 0xaeb214ac, Offset: 0x9d6
// Size: 0x113
function function_dbbf90abe6e86580( bundle )
{
    player_found();
    batch = function_b45c21c8ce5767fd( bundle );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Spatial Event Valid?", isdefined( batch.events[ 0 ] ), "scripts/autotests/test_mit.gsc", 95 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    level.autotests.test_runtime.var_552e784db1ce905d = 0;
    autotests_telemetry::function_5530fe2e62fb63db( batch.events, bundle.var_77d94d1b1267e36c, &response_callback, bundle.dryrun );
    starttime = gettime();
    
    while ( !level.autotests.test_runtime.var_552e784db1ce905d )
    {
        waitframe();
        
        if ( gettime() - starttime > 15000 )
        {
            autotests::function_d84657f448aaeef6( "HTTP response did not come back in 15 sec!", 0, "scripts/autotests/test_mit.gsc", 99 );
            return;
        }
    }
    
    return 0;
}

// Namespace test_mit
// Params 1
// Checksum 0x1771998c, Offset: 0xaf2
// Size: 0x9a
function function_ee7f1d2166dd2061( bundle )
{
    player_found();
    batch = function_b45c21c8ce5767fd( bundle );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Spatial Event Valid?", isdefined( batch.events[ 0 ] ), "scripts/autotests/test_mit.gsc", 113 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests_telemetry::function_5530fe2e62fb63db( batch.events, bundle.var_77d94d1b1267e36c, undefined, bundle.dryrun );
    return 0;
}

// Namespace test_mit
// Params 1
// Checksum 0x5a103545, Offset: 0xb95
// Size: 0x87
function response_callback( data )
{
    println( "<dev string:x24>" + data );
    level.autotests.test_runtime.var_552e784db1ce905d = 1;
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "HTTP request successful", data.statuscode, 200, "scripts/autotests/test_mit.gsc", 124 );
    
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

// Namespace test_mit
// Params 1
// Checksum 0x2bab77f7, Offset: 0xc25
// Size: 0x145
function function_b45c21c8ce5767fd( bundle )
{
    if ( bundle.miteventname == "door_event" )
    {
        event = function_f71ffe7e6ee92b85( bundle );
    }
    else if ( bundle.miteventname == "traversal_event" )
    {
        event = function_1f8d31c920e1d3ad( bundle );
    }
    else if ( bundle.miteventname == "window_event" )
    {
        event = function_d9d76df514ea4ce9( bundle );
    }
    else if ( bundle.miteventname == "roaming_event" )
    {
        event = function_cd7eeeb28fd8b2f4( bundle );
    }
    else if ( bundle.miteventname == "loot_event" )
    {
        event = function_517107c54b75a52b( bundle );
    }
    else
    {
        autotests::print_both( "ERROR: Invalid event name provided in test bundle: " + bundle.miteventname );
        return;
    }
    
    batch = spawnstruct();
    batch.events = [];
    batch.events[ 0 ] = event;
    batch.events[ 1 ] = event;
    batch.events[ 2 ] = event;
    batch.events[ 3 ] = event;
    batch.events[ 4 ] = event;
    return batch;
}

// Namespace test_mit
// Params 1
// Checksum 0xba1a37e, Offset: 0xd73
// Size: 0x249
function function_1f8d31c920e1d3ad( bundle )
{
    traversal_positions = [];
    traversal_positions[ 0 ] = [];
    traversal_positions[ 0 ][ 0 ] = 795.764;
    traversal_positions[ 0 ][ 1 ] = -160.191;
    traversal_positions[ 0 ][ 2 ] = 5.80074;
    traversal_positions[ 1 ] = [];
    traversal_positions[ 1 ][ 0 ] = 783.705;
    traversal_positions[ 1 ][ 1 ] = -216.924;
    traversal_positions[ 1 ][ 2 ] = 5.00779;
    traversal_wkt = autotests_telemetry::function_f6a7c392efedf019( traversal_positions );
    var_364605b8590d862e = [];
    var_364605b8590d862e[ 0 ] = spawnstruct();
    var_364605b8590d862e[ 0 ].type = "begin_position";
    var_364605b8590d862e[ 0 ].description = "Traversal begin position";
    var_364605b8590d862e[ 1 ] = spawnstruct();
    var_364605b8590d862e[ 1 ].type = "end_position";
    var_364605b8590d862e[ 1 ].description = "Traversal end position";
    traversal_meta = [];
    traversal_meta[ 0 ] = spawnstruct();
    traversal_meta[ 0 ].key = "bot_entity";
    traversal_meta[ 0 ].value = 5;
    traversal_meta[ 1 ] = spawnstruct();
    traversal_meta[ 1 ].key = "situation";
    traversal_meta[ 1 ].value = "passed";
    traversal_meta[ 2 ] = spawnstruct();
    traversal_meta[ 2 ].key = "last_position";
    traversal_meta[ 2 ].value = "(781.588, -229.914, 6.11984)";
    traversal_meta[ 3 ] = spawnstruct();
    traversal_meta[ 3 ].key = "traversal_name";
    traversal_meta[ 3 ].value = "pf802a30ee5f98b38f_auto1";
    traversal_meta[ 4 ] = spawnstruct();
    traversal_meta[ 4 ].key = "traversal_type";
    traversal_meta[ 4 ].value = "traverse_warp_down";
    traversal_meta[ 5 ] = spawnstruct();
    traversal_meta[ 5 ].key = "comment";
    traversal_meta[ 5 ].value = "";
    event_traversal = autotests_telemetry::spatial_event_create( traversal_wkt, autotests_telemetry::build_geometry_metadata_json( var_364605b8590d862e ), bundle.miteventname, "scripts/autotests/test_mit.gsc", 0, autotests_telemetry::function_f65481dc1156878e( traversal_meta ) );
    return event_traversal;
}

// Namespace test_mit
// Params 1
// Checksum 0xd1fd2f6f, Offset: 0xfc5
// Size: 0x288
function function_f71ffe7e6ee92b85( bundle )
{
    door_positions = [];
    door_positions[ 0 ] = [];
    door_positions[ 0 ][ 0 ] = 285.472;
    door_positions[ 0 ][ 1 ] = -691.334;
    door_positions[ 0 ][ 2 ] = 72;
    door_positions[ 1 ] = [];
    door_positions[ 1 ][ 0 ] = 264;
    door_positions[ 1 ][ 1 ] = -644;
    door_positions[ 1 ][ 2 ] = 72;
    door_positions[ 2 ] = [];
    door_positions[ 2 ][ 0 ] = 290.479;
    door_positions[ 2 ][ 1 ] = -694;
    door_positions[ 2 ][ 2 ] = 72;
    door_positions[ 3 ] = [];
    door_positions[ 3 ][ 0 ] = 290.479;
    door_positions[ 3 ][ 1 ] = -594;
    door_positions[ 3 ][ 2 ] = 72;
    door_wkt = autotests_telemetry::function_464ddcba1fc9adbb( door_positions );
    var_fed2aca6cb3e66a0 = [];
    var_fed2aca6cb3e66a0[ 0 ] = spawnstruct();
    var_fed2aca6cb3e66a0[ 0 ].type = "last_position";
    var_fed2aca6cb3e66a0[ 0 ].description = "Bot position before door event";
    var_fed2aca6cb3e66a0[ 1 ] = spawnstruct();
    var_fed2aca6cb3e66a0[ 1 ].type = "door_origin";
    var_fed2aca6cb3e66a0[ 1 ].description = "Origin of the door";
    var_fed2aca6cb3e66a0[ 2 ] = spawnstruct();
    var_fed2aca6cb3e66a0[ 2 ].type = "before_door_pos";
    var_fed2aca6cb3e66a0[ 2 ].description = "Bot position before opening door";
    var_fed2aca6cb3e66a0[ 3 ] = spawnstruct();
    var_fed2aca6cb3e66a0[ 3 ].type = "after_door_pos";
    var_fed2aca6cb3e66a0[ 3 ].description = "Bot position after opening door";
    door_meta = [];
    door_meta[ 0 ] = spawnstruct();
    door_meta[ 0 ].key = "bot_entity";
    door_meta[ 0 ].value = 2;
    door_meta[ 1 ] = spawnstruct();
    door_meta[ 1 ].key = "situation";
    door_meta[ 1 ].value = "passed";
    door_meta[ 2 ] = spawnstruct();
    door_meta[ 2 ].key = "door_index";
    door_meta[ 2 ].value = 2176;
    door_meta[ 3 ] = spawnstruct();
    door_meta[ 3 ].key = "is_passed";
    door_meta[ 3 ].value = 1;
    event_door = autotests_telemetry::spatial_event_create( door_wkt, autotests_telemetry::build_geometry_metadata_json( var_fed2aca6cb3e66a0 ), bundle.miteventname, "scripts/autotests/test_mit.gsc", 0, autotests_telemetry::function_f65481dc1156878e( door_meta ) );
    return event_door;
}

// Namespace test_mit
// Params 1
// Checksum 0x512a93d3, Offset: 0x1256
// Size: 0x2f0
function function_d9d76df514ea4ce9( bundle )
{
    window_positions = [];
    window_positions[ 0 ] = [];
    window_positions[ 0 ][ 0 ] = -4492.82;
    window_positions[ 0 ][ 1 ] = 7616.83;
    window_positions[ 0 ][ 2 ] = 120;
    window_positions[ 1 ] = [];
    window_positions[ 1 ][ 0 ] = -4495.87;
    window_positions[ 1 ][ 1 ] = 7612.21;
    window_positions[ 1 ][ 2 ] = 110;
    window_positions[ 2 ] = [];
    window_positions[ 2 ][ 0 ] = -4476.29;
    window_positions[ 2 ][ 1 ] = 7641.87;
    window_positions[ 2 ][ 2 ] = 78;
    window_positions[ 3 ] = [];
    window_positions[ 3 ][ 0 ] = -4520.36;
    window_positions[ 3 ][ 1 ] = 7575.1;
    window_positions[ 3 ][ 2 ] = 130;
    window_wkt = autotests_telemetry::function_464ddcba1fc9adbb( window_positions );
    window_geo_meta = [];
    window_geo_meta[ 0 ] = spawnstruct();
    window_geo_meta[ 0 ].type = "window_pos";
    window_geo_meta[ 0 ].description = "Window position";
    window_geo_meta[ 1 ] = spawnstruct();
    window_geo_meta[ 1 ].type = "last_position";
    window_geo_meta[ 1 ].description = "Bot last position";
    window_geo_meta[ 2 ] = spawnstruct();
    window_geo_meta[ 2 ].type = "start_pos";
    window_geo_meta[ 2 ].description = "Start position";
    window_geo_meta[ 3 ] = spawnstruct();
    window_geo_meta[ 3 ].type = "target_pos";
    window_geo_meta[ 3 ].description = "Target position";
    window_meta = [];
    window_meta[ 0 ] = spawnstruct();
    window_meta[ 0 ].key = "bot_id";
    window_meta[ 0 ].value = 7;
    window_meta[ 1 ] = spawnstruct();
    window_meta[ 1 ].key = "situation";
    window_meta[ 1 ].value = "passed";
    window_meta[ 2 ] = spawnstruct();
    window_meta[ 2 ].key = "comment";
    window_meta[ 2 ].value = "";
    window_meta[ 3 ] = spawnstruct();
    window_meta[ 3 ].key = "window_height";
    window_meta[ 3 ].value = 88;
    window_meta[ 4 ] = spawnstruct();
    window_meta[ 4 ].key = "height_from_ground";
    window_meta[ 4 ].value = 42.0001;
    window_meta[ 5 ] = spawnstruct();
    window_meta[ 5 ].key = "has_traversal";
    window_meta[ 5 ].value = 0;
    event_window = autotests_telemetry::spatial_event_create( window_wkt, autotests_telemetry::build_geometry_metadata_json( window_geo_meta ), bundle.miteventname, "scripts/autotests/test_mit.gsc", 0, autotests_telemetry::function_f65481dc1156878e( window_meta ) );
    return event_window;
}

// Namespace test_mit
// Params 1
// Checksum 0xd5454351, Offset: 0x154f
// Size: 0x1bb
function function_cd7eeeb28fd8b2f4( bundle )
{
    roaming_positions = [];
    roaming_positions[ 0 ] = [];
    roaming_positions[ 0 ][ 0 ] = 538.891;
    roaming_positions[ 0 ][ 1 ] = -272.532;
    roaming_positions[ 0 ][ 2 ] = 168.195;
    roaming_wkt = autotests_telemetry::function_464ddcba1fc9adbb( roaming_positions );
    var_8913e0c2e35589f5 = [];
    var_8913e0c2e35589f5[ 0 ] = spawnstruct();
    var_8913e0c2e35589f5[ 0 ].type = "bot_position";
    var_8913e0c2e35589f5[ 0 ].description = "Bot position at event";
    roaming_meta = [];
    roaming_meta[ 0 ] = spawnstruct();
    roaming_meta[ 0 ].key = "bot_entity";
    roaming_meta[ 0 ].value = 11;
    roaming_meta[ 1 ] = spawnstruct();
    roaming_meta[ 1 ].key = "situation";
    roaming_meta[ 1 ].value = "bad_path_no_path_to_script_goal";
    roaming_meta[ 2 ] = spawnstruct();
    roaming_meta[ 2 ].key = "start_pos";
    roaming_meta[ 2 ].value = "(517.5, -272.5, 173.969)";
    roaming_meta[ 3 ] = spawnstruct();
    roaming_meta[ 3 ].key = "target_pos";
    roaming_meta[ 3 ].value = "(502.5, -447.5, 89.5)";
    roaming_meta[ 4 ] = spawnstruct();
    roaming_meta[ 4 ].key = "comment";
    roaming_meta[ 4 ].value = "";
    event_roaming = autotests_telemetry::spatial_event_create( roaming_wkt, autotests_telemetry::build_geometry_metadata_json( var_8913e0c2e35589f5 ), bundle.miteventname, "scripts/autotests/test_mit.gsc", 0, autotests_telemetry::function_f65481dc1156878e( roaming_meta ) );
    return event_roaming;
}

// Namespace test_mit
// Params 1
// Checksum 0x769c2c7d, Offset: 0x1713
// Size: 0x245
function function_517107c54b75a52b( bundle )
{
    loot_positions = [];
    loot_positions[ 0 ] = [];
    loot_positions[ 0 ][ 0 ] = -19760.9;
    loot_positions[ 0 ][ 1 ] = 25708.5;
    loot_positions[ 0 ][ 2 ] = 1276;
    loot_positions[ 1 ] = [];
    loot_positions[ 1 ][ 0 ] = -19795.4;
    loot_positions[ 1 ][ 1 ] = 25704.6;
    loot_positions[ 1 ][ 2 ] = 1245.81;
    loot_positions[ 2 ] = [];
    loot_positions[ 2 ][ 0 ] = -19760.9;
    loot_positions[ 2 ][ 1 ] = 25708.5;
    loot_positions[ 2 ][ 2 ] = 1276.26;
    loot_wkt = autotests_telemetry::function_464ddcba1fc9adbb( loot_positions );
    var_6784a1a4590c3fca = [];
    var_6784a1a4590c3fca[ 0 ] = spawnstruct();
    var_6784a1a4590c3fca[ 0 ].type = "loot_origin";
    var_6784a1a4590c3fca[ 0 ].description = "Loot origin";
    var_6784a1a4590c3fca[ 1 ] = spawnstruct();
    var_6784a1a4590c3fca[ 1 ].type = "navmesh_point";
    var_6784a1a4590c3fca[ 1 ].description = "Closest navmesh point";
    var_6784a1a4590c3fca[ 2 ] = spawnstruct();
    var_6784a1a4590c3fca[ 2 ].type = "clip_point";
    var_6784a1a4590c3fca[ 2 ].description = "Clip point";
    loot_meta = [];
    loot_meta[ 0 ] = spawnstruct();
    loot_meta[ 0 ].key = "situation";
    loot_meta[ 0 ].value = "no navmesh";
    loot_meta[ 1 ] = spawnstruct();
    loot_meta[ 1 ].key = "loot_type";
    loot_meta[ 1 ].value = "cache_metal_briefcase";
    loot_meta[ 2 ] = spawnstruct();
    loot_meta[ 2 ].key = "h_offset";
    loot_meta[ 2 ].value = 34.7184;
    loot_meta[ 3 ] = spawnstruct();
    loot_meta[ 3 ].key = "v_offset";
    loot_meta[ 3 ].value = 30.4463;
    event_loot = autotests_telemetry::spatial_event_create( loot_wkt, autotests_telemetry::build_geometry_metadata_json( var_6784a1a4590c3fca ), bundle.miteventname, "scripts/autotests/test_mit.gsc", 0, autotests_telemetry::function_f65481dc1156878e( loot_meta ) );
    return event_loot;
}

