// scripts\autotests\test_scripted_widgets.gsc  (hash_079ad8ff77475726.gscc) (size: 3551 Bytes / 0xddf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x873ac23e (2268774974)
// size ...... 3551 (0xddf)
// includes .. 3   (offset: 0xbf7)
// strings ... 23  (offset: 0xc0f)
// dev strs .. 0   (offset: 0xddf)
// exports ... 7   (offset: 0x837)
// cseg ...... 0x382 + 0x4b5 (0x837)
// imports ... 19  (offset: 0x94f)
// animtree1 . 0   (offset: 0xddf)
// animtree2 . 0   (offset: 0xddf)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility_player;
#using scripts\common\scripted_widgets;

#namespace test_scripted_widgets;

// Namespace test_scripted_widgets/testautomation
// Params 0, eflags: 0x20
// Checksum 0x1a2c0d3b, Offset: 0x3a0
// Size: 0x26
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/test_scripted_widgets.gsc", #"test", &start_test, &setup, &cleanup );
}

// Namespace test_scripted_widgets
// Params 0
// Checksum 0x5bdf247c, Offset: 0x3ce
// Size: 0x8, Type: bool
function setup()
{
    return autotests::function_5c8c87763724c132();
}

// Namespace test_scripted_widgets
// Params 0
// Checksum 0xeb89c8c0, Offset: 0x3df
// Size: 0x48
function cleanup()
{
    player = autotests_utility_player::get_player();
    
    if ( isdefined( player ) && player scripted_widgets::is_active( "autotest_scripted_widget" ) )
    {
        player scripted_widgets::destroy( "autotest_scripted_widget" );
    }
    
    if ( isdefined( player ) )
    {
        cleanup_capacity_widgets( player );
    }
}

// Namespace test_scripted_widgets
// Params 0
// Checksum 0xf83710e, Offset: 0x42f
// Size: 0x234, Type: bool
function start_test()
{
    player = autotests_utility_player::get_player();
    autotests::function_36ed835262a19e53( "Player found", player, "scripts/autotests/test_scripted_widgets.gsc", 43 );
    
    if ( !isdefined( player ) )
    {
        return true;
    }
    
    if ( player scripted_widgets::is_active( "autotest_scripted_widget" ) )
    {
        player scripted_widgets::destroy( "autotest_scripted_widget" );
    }
    
    autotests::function_d84657f448aaeef6( "Widget type available before create", player scripted_widgets::available( "scripted_widget_golden_template" ), "scripts/autotests/test_scripted_widgets.gsc", 55 );
    autotests::function_ae5837f8e14d9b71( "Widget inactive before create", player scripted_widgets::is_active( "autotest_scripted_widget" ), "scripts/autotests/test_scripted_widgets.gsc", 56 );
    autotests::function_d84657f448aaeef6( "Create scripted widget", player scripted_widgets::create( "autotest_scripted_widget", "scripted_widget_golden_template" ), "scripts/autotests/test_scripted_widgets.gsc", 57 );
    autotests::function_d84657f448aaeef6( "Widget active after create", player scripted_widgets::is_active( "autotest_scripted_widget" ), "scripts/autotests/test_scripted_widgets.gsc", 58 );
    first_index = player scripted_widgets::get_active_index( "autotest_scripted_widget" );
    autotests::function_36ed835262a19e53( "Widget index assigned", first_index, "scripts/autotests/test_scripted_widgets.gsc", 61 );
    autotests::function_ae5837f8e14d9b71( "Duplicate widget_ref create fails", player scripted_widgets::create( "autotest_scripted_widget", "scripted_widget_golden_template" ), "scripts/autotests/test_scripted_widgets.gsc", 62 );
    autotests::function_e50d1006e5d65c04( "Widget index unchanged after duplicate create", player scripted_widgets::get_active_index( "autotest_scripted_widget" ), first_index, "scripts/autotests/test_scripted_widgets.gsc", 63 );
    player scripted_widgets::destroy( "autotest_scripted_widget" );
    autotests::function_ae5837f8e14d9b71( "Widget inactive after destroy", player scripted_widgets::is_active( "autotest_scripted_widget" ), "scripts/autotests/test_scripted_widgets.gsc", 66 );
    autotests::function_dbbd10e009ede41e( "Widget index cleared after destroy", player scripted_widgets::get_active_index( "autotest_scripted_widget" ), "scripts/autotests/test_scripted_widgets.gsc", 67 );
    autotests::function_d84657f448aaeef6( "Widget type available after destroy", player scripted_widgets::available( "scripted_widget_golden_template" ), "scripts/autotests/test_scripted_widgets.gsc", 68 );
    autotests::function_d84657f448aaeef6( "Create scripted widget after release", player scripted_widgets::create( "autotest_scripted_widget", "scripted_widget_golden_template" ), "scripts/autotests/test_scripted_widgets.gsc", 70 );
    autotests::function_36ed835262a19e53( "Widget index assigned after recreate", player scripted_widgets::get_active_index( "autotest_scripted_widget" ), "scripts/autotests/test_scripted_widgets.gsc", 71 );
    player scripted_widgets::destroy( "autotest_scripted_widget" );
    autotests::function_ae5837f8e14d9b71( "Widget inactive after final destroy", player scripted_widgets::is_active( "autotest_scripted_widget" ), "scripts/autotests/test_scripted_widgets.gsc", 74 );
    function_95a9aea4d8a3c275( player );
    return false;
}

// Namespace test_scripted_widgets
// Params 1
// Checksum 0xd62dbf69, Offset: 0x66c
// Size: 0x149
function function_95a9aea4d8a3c275( player )
{
    created_refs = [];
    created_count = 0;
    
    for ( i = 0; i < 128 ; i++ )
    {
        ref = "autotest_scripted_widget_capacity_" + i;
        
        if ( !player scripted_widgets::create( ref, "scripted_widget_golden_template" ) )
        {
            break;
        }
        
        created_refs[ created_refs.size ] = ref;
        created_count++;
    }
    
    autotests::function_e5040106e5cc1c59( "Created at least one capacity widget", created_count, 0, "scripts/autotests/test_scripted_widgets.gsc", 99 );
    autotests::function_e50d1006e5d65c04( "Capacity loop filled to configured bound", created_count, 128, "scripts/autotests/test_scripted_widgets.gsc", 100 );
    overflow_ref = "autotest_scripted_widget_capacity_" + "overflow";
    overflow_created = player scripted_widgets::create( overflow_ref, "scripted_widget_golden_template" );
    autotests::function_ae5837f8e14d9b71( "Create fails when capacity exceeded", overflow_created, "scripts/autotests/test_scripted_widgets.gsc", 103 );
    
    if ( overflow_created )
    {
        created_refs[ created_refs.size ] = overflow_ref;
    }
    
    for ( i = 0; i < created_refs.size ; i++ )
    {
        if ( player scripted_widgets::is_active( created_refs[ i ] ) )
        {
            player scripted_widgets::destroy( created_refs[ i ] );
        }
    }
    
    autotests::function_d84657f448aaeef6( "Can create again after capacity cleanup", player scripted_widgets::create( "autotest_scripted_widget", "scripted_widget_golden_template" ), "scripts/autotests/test_scripted_widgets.gsc", 118 );
    player scripted_widgets::destroy( "autotest_scripted_widget" );
}

// Namespace test_scripted_widgets
// Params 1
// Checksum 0xc7581f28, Offset: 0x7bd
// Size: 0x7a
function cleanup_capacity_widgets( player )
{
    for ( i = 0; i < 128 ; i++ )
    {
        ref = "autotest_scripted_widget_capacity_" + i;
        
        if ( player scripted_widgets::is_active( ref ) )
        {
            player scripted_widgets::destroy( ref );
        }
    }
    
    overflow_ref = "autotest_scripted_widget_capacity_" + "overflow";
    
    if ( player scripted_widgets::is_active( overflow_ref ) )
    {
        player scripted_widgets::destroy( overflow_ref );
    }
}

