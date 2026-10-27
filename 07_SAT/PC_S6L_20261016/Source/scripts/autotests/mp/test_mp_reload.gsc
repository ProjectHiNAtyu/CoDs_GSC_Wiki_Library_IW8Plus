// scripts\autotests\mp\test_mp_reload.gsc  (hash_64e16d407e12db79.gscc) (size: 14728 Bytes / 0x3988 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x315a7372 (828011378)
// size ...... 14728 (0x3988)
// includes .. 12  (offset: 0x33cc)
// strings ... 67  (offset: 0x342c)
// dev strs .. 0   (offset: 0x3988)
// exports ... 12  (offset: 0x25d4)
// cseg ...... 0xb7f + 0x1a55 (0x25d4)
// imports ... 71  (offset: 0x27b4)
// animtree1 . 0   (offset: 0x3988)
// animtree2 . 0   (offset: 0x3988)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_common_item;
#using scripts\autotests\autotests_utility_player;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\weapon;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_ammo;

#namespace test_mp_reload;

// Namespace test_mp_reload/testautomation
// Params 0, eflags: 0x20
// Checksum 0xccc5c05a, Offset: 0xb9d
// Size: 0x2a
function event_handler[testautomation] main()
{
    autotests::register_test( #"test_mp_reload", #"GP", &start_test, &setup, &cleanup );
}

// Namespace test_mp_reload
// Params 0, eflags: 0x4
// Checksum 0xda69d1bc, Offset: 0xbcf
// Size: 0x1eb
function private setup()
{
    autotests::function_5c8c87763724c132();
    player = autotests_utility_player::get_player();
    autotests_utility::setup();
    autotests::push_function( "Prematch completed" );
    test_result_int = player autotests_utility::test_prematch_done() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Prematch completed", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 41 );
    autotests::pop_function( "Prematch completed" );
    autotests::test_assert_return( test_result_int );
    player function_ffb0711adb6d8d0d();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player is autopiloted?", isautopilot( player ), "scripts/autotests/mp/test_mp_reload.gsc", 44 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests_utility_bot::set_bot_ignore_script_weapon( player, 0 );
    give_default_weapon( player );
    player item_ammo::function_a530c73bf2e2b013( 0, 0, 1 );
    autotests::set_dvar( @"hash_4c1997b229a0a01e", -1 );
    botdata = autotests_utility_bot::create_spawn_data( level.autotests.test_runtime.standbyposition + ( 100, 0, 0 ), player.angles );
    friendlybot = autotests_utility_bot::function_e4afe0f2cd6331a6( player.team, botdata );
    level.autotests.test_runtime.friendlybot = friendlybot;
    setup_vehicle( player.origin + ( 0, 500, 0 ), player.angles * ( 0, 1, 0 ) );
    level autotests_utility::function_4104f641c0755805( #"reload", "reload_finished" );
    level autotests_utility::function_4104f641c0755805( #"player_vehicle_enter", "vehicle_enter" );
    level autotests_utility::function_4104f641c0755805( #"player_vehicle_seat_switch", "seat_switch" );
    return 1;
}

// Namespace test_mp_reload
// Params 2, eflags: 0x4
// Checksum 0x74eb1150, Offset: 0xdc3
// Size: 0x296
function private setup_vehicle( origin, angles )
{
    foreach ( ref in vehicle::function_75acd2d48a8f3605( 1 ) )
    {
        vehicledata = vehicle::get_data( ref );
        
        if ( vehicledata.isboat || vehicledata.canfly )
        {
            continue;
        }
        
        vehicleref = ref;
        
        if ( vehicledata.occupancy.seatdata.size > 1 )
        {
            foreach ( seatref, seatdata in vehicledata.occupancy.seatdata )
            {
                if ( vehicle_occupancy::get_driver_seat() != seatref )
                {
                    var_4d441290407e0a2f = seatref;
                    break;
                }
            }
            
            if ( var_4d441290407e0a2f )
            {
                break;
            }
        }
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Found a valid vehicle ref?", vehicleref, "scripts/autotests/mp/test_mp_reload.gsc", 97 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Found a valid non-driver seat ref?", var_4d441290407e0a2f, "scripts/autotests/mp/test_mp_reload.gsc", 98 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    spawndata = { #angles:angles, #origin:origin };
    vehicle = vehicle::spawn( vehicleref, spawndata );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Vehicle spawned?", vehicle, "scripts/autotests/mp/test_mp_reload.gsc", 103 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    level.autotests.test_runtime.vehicle = vehicle;
    level.autotests.test_runtime.var_4d441290407e0a2f = var_4d441290407e0a2f;
}

// Namespace test_mp_reload
// Params 0, eflags: 0x4
// Checksum 0xa067157f, Offset: 0x1061
// Size: 0x100
function private cleanup()
{
    player = autotests_utility_player::get_player();
    autotests_utility_bot::set_bot_ignore_script_weapon( player, 1 );
    player playerexitautopilotmode();
    level autotests_utility::flag_remove_callback( #"reload", "reload_finished" );
    level autotests_utility::flag_remove_callback( #"player_vehicle_enter", "vehicle_enter" );
    level autotests_utility::flag_remove_callback( #"player_vehicle_seat_switch", "seat_switch" );
    autotests_utility_common_item::clear_all_loot();
    player takeweapon( level.autotests.test_runtime.weapon );
    level.autotests.test_runtime.weapon = undefined;
    vehicle = level.autotests.test_runtime.vehicle;
    
    if ( vehicle )
    {
        vehicle delete();
        level.autotests.test_runtime.vehicle = undefined;
    }
}

// Namespace test_mp_reload
// Params 1, eflags: 0x4
// Checksum 0x8d94e8e2, Offset: 0x1169
// Size: 0x20
function private cleanup_post_reload( player )
{
    autotests_utility_common_item::clear_all_loot();
    
    while ( player isreloading() )
    {
        waitframe();
    }
}

// Namespace test_mp_reload
// Params 0, eflags: 0x4
// Checksum 0xb4b56c2f, Offset: 0x1191
// Size: 0xab1
function private start_test()
{
    player = autotests_utility_player::get_player();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player Is Alive At Test Start?", isalive( player ), "scripts/autotests/mp/test_mp_reload.gsc", 148 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    settingsmap = [ "prioritizeReload":{ #contextualreload:1, #tapToInteract:0 }, "prioritizeInteract":{ #contextualreload:1, #tapToInteract:1 }, "tapToInteract":{ #contextualreload:0, #tapToInteract:1 }, "tapToReload":{ #contextualreload:0, #tapToInteract:0 } ];
    friendlybot = level.autotests.test_runtime.friendlybot;
    currentsettings = settingsmap[ "tapToReload" ];
    autotests::push_function( "Does reload work with tap (DEFAULT_RELOAD_TAP)?" );
    test_result_int = test_reload( player, 0, 1, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Does reload work with tap (DEFAULT_RELOAD_TAP)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 166 );
    autotests::pop_function( "Does reload work with tap (DEFAULT_RELOAD_TAP)?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Does reload work with holding (DEFAULT_RELOAD_TAP)?" );
    test_result_int = test_reload( player, 1, 1, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Does reload work with holding (DEFAULT_RELOAD_TAP)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 167 );
    autotests::pop_function( "Does reload work with holding (DEFAULT_RELOAD_TAP)?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "ItemConflict: Does reload work with tap (DEFAULT_RELOAD_TAP)?" );
    test_result_int = function_b743f4c54874359f( player, 0, 1, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "ItemConflict: Does reload work with tap (DEFAULT_RELOAD_TAP)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 168 );
    autotests::pop_function( "ItemConflict: Does reload work with tap (DEFAULT_RELOAD_TAP)?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "ItemConflict: Does reload NOT work with hold (DEFAULT_RELOAD_TAP)?" );
    test_result_int = function_b743f4c54874359f( player, 1, 0, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "ItemConflict: Does reload NOT work with hold (DEFAULT_RELOAD_TAP)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 169 );
    autotests::pop_function( "ItemConflict: Does reload NOT work with hold (DEFAULT_RELOAD_TAP)?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "VehicleInsideConflict: Does reload work with tap (DEFAULT_RELOAD_TAP)?" );
    test_result_int = function_ab375480415cba39( friendlybot, 0, 1, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "VehicleInsideConflict: Does reload work with tap (DEFAULT_RELOAD_TAP)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 170 );
    autotests::pop_function( "VehicleInsideConflict: Does reload work with tap (DEFAULT_RELOAD_TAP)?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "VehicleInsideConflict: Does reload NOT work with hold (DEFAULT_RELOAD_TAP)?" );
    test_result_int = function_ab375480415cba39( friendlybot, 1, 0, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "VehicleInsideConflict: Does reload NOT work with hold (DEFAULT_RELOAD_TAP)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 171 );
    autotests::pop_function( "VehicleInsideConflict: Does reload NOT work with hold (DEFAULT_RELOAD_TAP)?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "VehicleOutsideConflict: Does reload work with tap (DEFAULT_RELOAD_TAP)?" );
    test_result_int = function_3a7a50f76d681ef2( player, 0, 1, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "VehicleOutsideConflict: Does reload work with tap (DEFAULT_RELOAD_TAP)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 172 );
    autotests::pop_function( "VehicleOutsideConflict: Does reload work with tap (DEFAULT_RELOAD_TAP)?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "VehicleOutsideConflict: Does reload NOT work with hold (DEFAULT_RELOAD_TAP)?" );
    test_result_int = function_3a7a50f76d681ef2( player, 1, 0, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "VehicleOutsideConflict: Does reload NOT work with hold (DEFAULT_RELOAD_TAP)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 173 );
    autotests::pop_function( "VehicleOutsideConflict: Does reload NOT work with hold (DEFAULT_RELOAD_TAP)?" );
    autotests::test_assert_return( test_result_int );
    currentsettings = settingsmap[ "tapToInteract" ];
    autotests::push_function( "Does reload NOT work with tap (USE_TAP)?" );
    test_result_int = test_reload( player, 0, 0, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Does reload NOT work with tap (USE_TAP)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 176 );
    autotests::pop_function( "Does reload NOT work with tap (USE_TAP)?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Does reload work with hold (USE_TAP)?" );
    test_result_int = test_reload( player, 1, 1, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Does reload work with hold (USE_TAP)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 177 );
    autotests::pop_function( "Does reload work with hold (USE_TAP)?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "ItemConflict: Does reload NOT work with tap (USE_TAP)?" );
    test_result_int = function_b743f4c54874359f( player, 0, 0, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "ItemConflict: Does reload NOT work with tap (USE_TAP)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 178 );
    autotests::pop_function( "ItemConflict: Does reload NOT work with tap (USE_TAP)?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "ItemConflict: Does reload work with hold (USE_TAP)?" );
    test_result_int = function_b743f4c54874359f( player, 1, 1, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "ItemConflict: Does reload work with hold (USE_TAP)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 179 );
    autotests::pop_function( "ItemConflict: Does reload work with hold (USE_TAP)?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "VehicleInsideConflict: Does reload NOT work with tap (USE_TAP)?" );
    test_result_int = function_ab375480415cba39( friendlybot, 0, 0, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "VehicleInsideConflict: Does reload NOT work with tap (USE_TAP)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 180 );
    autotests::pop_function( "VehicleInsideConflict: Does reload NOT work with tap (USE_TAP)?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "VehicleInsideConflict: Does reload work with hold (USE_TAP)?" );
    test_result_int = function_ab375480415cba39( friendlybot, 1, 1, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "VehicleInsideConflict: Does reload work with hold (USE_TAP)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 181 );
    autotests::pop_function( "VehicleInsideConflict: Does reload work with hold (USE_TAP)?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "VehicleOutsideConflict: Does reload NOT work with tap (USE_TAP)?" );
    test_result_int = function_3a7a50f76d681ef2( player, 0, 0, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "VehicleOutsideConflict: Does reload NOT work with tap (USE_TAP)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 182 );
    autotests::pop_function( "VehicleOutsideConflict: Does reload NOT work with tap (USE_TAP)?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "VehicleOutsideConflict: Does reload work with hold (USE_TAP)?" );
    test_result_int = function_3a7a50f76d681ef2( player, 1, 1, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "VehicleOutsideConflict: Does reload work with hold (USE_TAP)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 183 );
    autotests::pop_function( "VehicleOutsideConflict: Does reload work with hold (USE_TAP)?" );
    autotests::test_assert_return( test_result_int );
    currentsettings = settingsmap[ "prioritizeInteract" ];
    autotests::push_function( "Does reload work with tap (CONTEXTUAL_TAP)?" );
    test_result_int = test_reload( player, 1, 1, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Does reload work with tap (CONTEXTUAL_TAP)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 186 );
    autotests::pop_function( "Does reload work with tap (CONTEXTUAL_TAP)?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Does reload work with hold (CONTEXTUAL_TAP)?" );
    test_result_int = test_reload( player, 1, 1, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Does reload work with hold (CONTEXTUAL_TAP)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 187 );
    autotests::pop_function( "Does reload work with hold (CONTEXTUAL_TAP)?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "ItemConflict: Does reload NOT work with tap (CONTEXTUAL_TAP)?" );
    test_result_int = function_b743f4c54874359f( player, 0, 0, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "ItemConflict: Does reload NOT work with tap (CONTEXTUAL_TAP)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 188 );
    autotests::pop_function( "ItemConflict: Does reload NOT work with tap (CONTEXTUAL_TAP)?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "ItemConflict: Does reload work with hold (CONTEXTUAL_TAP)?" );
    test_result_int = function_b743f4c54874359f( player, 1, 1, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "ItemConflict: Does reload work with hold (CONTEXTUAL_TAP)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 189 );
    autotests::pop_function( "ItemConflict: Does reload work with hold (CONTEXTUAL_TAP)?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "VehicleInsideConflict: Does reload work with hold (CONTEXTUAL_TAP)?" );
    test_result_int = function_ab375480415cba39( friendlybot, 1, 1, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "VehicleInsideConflict: Does reload work with hold (CONTEXTUAL_TAP)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 190 );
    autotests::pop_function( "VehicleInsideConflict: Does reload work with hold (CONTEXTUAL_TAP)?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "VehicleInsideConflict: Does reload work NOT with tap (CONTEXTUAL_TAP)?" );
    test_result_int = function_ab375480415cba39( friendlybot, 0, 0, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "VehicleInsideConflict: Does reload work NOT with tap (CONTEXTUAL_TAP)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 191 );
    autotests::pop_function( "VehicleInsideConflict: Does reload work NOT with tap (CONTEXTUAL_TAP)?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "VehicleOutsideConflict: Does reload work with hold (CONTEXTUAL_TAP)?" );
    test_result_int = function_3a7a50f76d681ef2( player, 1, 1, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "VehicleOutsideConflict: Does reload work with hold (CONTEXTUAL_TAP)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 192 );
    autotests::pop_function( "VehicleOutsideConflict: Does reload work with hold (CONTEXTUAL_TAP)?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "VehicleOutsideConflict: Does reload work NOT work with tap (CONTEXTUAL_TAP)?" );
    test_result_int = function_3a7a50f76d681ef2( player, 0, 0, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "VehicleOutsideConflict: Does reload work NOT work with tap (CONTEXTUAL_TAP)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 193 );
    autotests::pop_function( "VehicleOutsideConflict: Does reload work NOT work with tap (CONTEXTUAL_TAP)?" );
    autotests::test_assert_return( test_result_int );
    currentsettings = settingsmap[ "prioritizeReload" ];
    autotests::push_function( "Does reload work with tap (CONTEXTUAL_RELOAD)?" );
    test_result_int = test_reload( player, 1, 1, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Does reload work with tap (CONTEXTUAL_RELOAD)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 196 );
    autotests::pop_function( "Does reload work with tap (CONTEXTUAL_RELOAD)?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Does reload work with hold (CONTEXTUAL_RELOAD)?" );
    test_result_int = test_reload( player, 1, 1, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Does reload work with hold (CONTEXTUAL_RELOAD)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 197 );
    autotests::pop_function( "Does reload work with hold (CONTEXTUAL_RELOAD)?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "ItemConflict: Does reload work with tap (CONTEXTUAL_RELOAD)?" );
    test_result_int = function_b743f4c54874359f( player, 0, 1, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "ItemConflict: Does reload work with tap (CONTEXTUAL_RELOAD)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 198 );
    autotests::pop_function( "ItemConflict: Does reload work with tap (CONTEXTUAL_RELOAD)?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "ItemConflict: Does reload NOT work with hold (CONTEXTUAL_RELOAD)?" );
    test_result_int = function_b743f4c54874359f( player, 1, 0, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "ItemConflict: Does reload NOT work with hold (CONTEXTUAL_RELOAD)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 199 );
    autotests::pop_function( "ItemConflict: Does reload NOT work with hold (CONTEXTUAL_RELOAD)?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "VehicleInsideConflict: Does reload work with tap (CONTEXTUAL_RELOAD)?" );
    test_result_int = function_ab375480415cba39( friendlybot, 0, 1, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "VehicleInsideConflict: Does reload work with tap (CONTEXTUAL_RELOAD)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 200 );
    autotests::pop_function( "VehicleInsideConflict: Does reload work with tap (CONTEXTUAL_RELOAD)?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "VehicleInsideConflict: Does reload NOT work with hold (CONTEXTUAL_RELOAD)?" );
    test_result_int = function_ab375480415cba39( friendlybot, 1, 0, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "VehicleInsideConflict: Does reload NOT work with hold (CONTEXTUAL_RELOAD)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 201 );
    autotests::pop_function( "VehicleInsideConflict: Does reload NOT work with hold (CONTEXTUAL_RELOAD)?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "VehicleOutsideConflict: Does reload work with tap (CONTEXTUAL_RELOAD)?" );
    test_result_int = function_3a7a50f76d681ef2( player, 0, 1, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "VehicleOutsideConflict: Does reload work with tap (CONTEXTUAL_RELOAD)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 202 );
    autotests::pop_function( "VehicleOutsideConflict: Does reload work with tap (CONTEXTUAL_RELOAD)?" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "VehicleOutsideConflict: Does reload NOT work with hold (CONTEXTUAL_RELOAD)?" );
    test_result_int = function_3a7a50f76d681ef2( player, 1, 0, currentsettings ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "VehicleOutsideConflict: Does reload NOT work with hold (CONTEXTUAL_RELOAD)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_reload.gsc", 203 );
    autotests::pop_function( "VehicleOutsideConflict: Does reload NOT work with hold (CONTEXTUAL_RELOAD)?" );
    autotests::test_assert_return( test_result_int );
    return 0;
}

// Namespace test_mp_reload
// Params 4, eflags: 0x4
// Checksum 0xd0e1e856, Offset: 0x1c4b
// Size: 0x1a4
function private test_reload( player, shouldhold, canreload, settings )
{
    player function_349ee393ea6dba7e( "use_reload_cfg", settings.tapToInteract );
    player function_349ee393ea6dba7e( "use_reload_contextual_cfg_disable", !settings.contextualreload );
    waitframe();
    autotests_utility::flag_clear( "reload_finished" );
    weapon = player getcurrentweapon();
    ammoclip = player getweaponammoclip( weapon );
    player setweaponammoclip( weapon, ammoclip - 1 );
    var_984b1e514b61cb = shouldhold ? 1 : 0;
    player botpressbutton( "use", var_984b1e514b61cb );
    reloadstarted = player utility::waittill_any_in_array_or_timeout( [ "reload_start" ], 1 + var_984b1e514b61cb ) != "timeout";
    reloadfinished = 0;
    
    if ( reloadstarted )
    {
        reloadfinished = autotests_utility::flag_wait_or_timeout( "reload_finished", 4 ) != "timeout";
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( canreload ? "Started reload?" : "Didn't start reload?", reloadstarted == canreload, "scripts/autotests/mp/test_mp_reload.gsc", 246 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( canreload ? "Finished reload?" : "Didn't finish reload?", reloadfinished == canreload, "scripts/autotests/mp/test_mp_reload.gsc", 247 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    cleanup_post_reload( player );
}

// Namespace test_mp_reload
// Params 4, eflags: 0x4
// Checksum 0xd9282403, Offset: 0x1df7
// Size: 0x13c
function private function_b743f4c54874359f( player, shouldhold, canreload, settings )
{
    player setorigin( level.autotests.test_runtime.testposition );
    
    if ( !common_item::items_isenabled() )
    {
        return 5;
    }
    
    var_35a0d33d42f16f6d = autotests_utility_common_item::function_923f6b80a7d17409( "ar", 0 );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "AR weapon item bundle found?", var_35a0d33d42f16f6d, "scripts/autotests/mp/test_mp_reload.gsc", 272 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    spawnposition = player.origin + vectornormalize2( anglestoforward( player.angles ) ) * 50;
    spawnoptions = common_item::function_bc5ff2958b71a708( spawnposition );
    item = common_item::function_61c2c0251e742ffd( var_35a0d33d42f16f6d, undefined, spawnoptions );
    player autotests_utility_player::player_look_at( spawnposition );
    test_reload( player, shouldhold, canreload, settings );
    player setorigin( level.autotests.test_runtime.standbyposition );
}

// Namespace test_mp_reload
// Params 4, eflags: 0x4
// Checksum 0xfaa3e9b6, Offset: 0x1f3b
// Size: 0x31e
function private function_ab375480415cba39( bot, shouldhold, canreload, settings )
{
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player is a bot?", isbot( bot ), "scripts/autotests/mp/test_mp_reload.gsc", 301 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests_utility::flag_clear( "vehicle_enter" );
    autotests_utility::flag_clear( "seat_switch" );
    vehicle = level.autotests.test_runtime.vehicle;
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Vehicle still spawned?", vehicle, "scripts/autotests/mp/test_mp_reload.gsc", 307 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests_utility_player::get_player() autotests_utility_player::player_look_at( vehicle.origin );
    thread vehicle_occupancy::enter( vehicle, vehicle_occupancy::get_driver_seat(), bot );
    vehicleentered = autotests_utility::flag_wait_or_timeout( "vehicle_enter", 2 ) != "timeout";
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Bot entered vehicle?", bot vehicle::is_in_vehicle() && vehicleentered, "scripts/autotests/mp/test_mp_reload.gsc", 312 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_4d441290407e0a2f = level.autotests.test_runtime.var_4d441290407e0a2f;
    thread vehicle_occupancy::enter( vehicle, var_4d441290407e0a2f, bot );
    seatswitched = autotests_utility::flag_wait_or_timeout( "seat_switch", 1 ) != "timeout";
    var_ca9acaf4ed3590a1 = vehicle_occupancy::get_seat_occupant( vehicle, var_4d441290407e0a2f );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Bot switched seat?", var_ca9acaf4ed3590a1 == bot && seatswitched, "scripts/autotests/mp/test_mp_reload.gsc", 320 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    test_reload( bot, shouldhold, canreload, settings );
    
    if ( canreload )
    {
        var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Bot still in vehicle?", bot vehicle::is_in_vehicle(), "scripts/autotests/mp/test_mp_reload.gsc", 326 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    else
    {
        var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Bot NOT in vehicle?", !bot vehicle::is_in_vehicle(), "scripts/autotests/mp/test_mp_reload.gsc", 330 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    
    vehicle_occupancy::exit( vehicle, var_4d441290407e0a2f, bot, undefined, 1 );
    
    if ( canreload )
    {
        var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Bot exited vehicle?", !bot vehicle::is_in_vehicle(), "scripts/autotests/mp/test_mp_reload.gsc", 337 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    
    bot setorigin( level.autotests.test_runtime.standbyposition + ( 100, 0, 0 ) );
}

// Namespace test_mp_reload
// Params 4, eflags: 0x4
// Checksum 0xa50f7883, Offset: 0x2261
// Size: 0x227
function private function_3a7a50f76d681ef2( player, shouldhold, canreload, settings )
{
    var_63a718d91714219d = autotests::function_ae5837f8e14d9b71( "Player isn't a bot?", isbot( player ), "scripts/autotests/mp/test_mp_reload.gsc", 356 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests_utility::flag_clear( "vehicle_enter" );
    autotests_utility::flag_clear( "seat_switch" );
    vehicle = level.autotests.test_runtime.vehicle;
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Vehicle still spawned?", vehicle, "scripts/autotests/mp/test_mp_reload.gsc", 362 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    exit = vehicle_occupancy::function_759b1ac7685fb992( vehicle, player, vehicle_occupancy::get_driver_seat() );
    player setorigin( exit.origin );
    player autotests_utility_player::player_look_at( vehicle.origin );
    test_reload( player, shouldhold, canreload, settings );
    
    if ( canreload )
    {
        var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player NOT in vehicle?", !player vehicle::is_in_vehicle(), "scripts/autotests/mp/test_mp_reload.gsc", 372 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    else
    {
        var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player in vehicle?", player vehicle::is_in_vehicle(), "scripts/autotests/mp/test_mp_reload.gsc", 376 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        vehicle_occupancy::exit( vehicle, vehicle_occupancy::get_driver_seat(), player, undefined, 1 );
        
        if ( canreload )
        {
            var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Bot exited vehicle?", !player vehicle::is_in_vehicle(), "scripts/autotests/mp/test_mp_reload.gsc", 382 );
            
            if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
            {
                if ( autotests::function_561cb32cd7469145() )
                {
                    return;
                }
                
                autotests::test_assert_return( var_63a718d91714219d );
            }
        }
    }
    
    player setorigin( level.autotests.test_runtime.standbyposition );
}

// Namespace test_mp_reload
// Params 1, eflags: 0x4
// Checksum 0x2e492b15, Offset: 0x2490
// Size: 0x144
function private give_default_weapon( player )
{
    if ( common_item::items_isenabled() )
    {
        var_35a0d33d42f16f6d = autotests_utility_common_item::function_923f6b80a7d17409( "ar", 0 );
        var_63a718d91714219d = autotests::function_d84657f448aaeef6( "AR weapon item bundle found?", var_35a0d33d42f16f6d, "scripts/autotests/mp/test_mp_reload.gsc", 394 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( ( 0, 0, 0 ) );
        item = common_item::function_61c2c0251e742ffd( var_35a0d33d42f16f6d, undefined, spawnoptions );
        player common_item::function_2b5e2ff57d5f392( item, 0 );
        level.autotests.test_runtime.weapon = item.weaponobj;
    }
    else
    {
        [ weaponref, weaponbase ] = autotests_utility::function_fc09add23c4398c1( "ar", 0 );
        weapon = weapon::buildweapon( weaponref );
        player giveweapon( weapon );
        player inventory_utility::domonitoredweaponswitch( weapon, 1, 1, 1 );
    }
    
    player waittill( #"weapon_change" );
    wait 1;
}

