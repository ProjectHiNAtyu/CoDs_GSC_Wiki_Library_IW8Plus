// scripts\autotests\mp\test_mp_movement.gsc  (hash_7dbe05bbdf6e2c85.gscc) (size: 37771 Bytes / 0x938b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x144442b3 (340017843)
// size ...... 37771 (0x938b)
// includes .. 11  (offset: 0x86cb)
// strings ... 163 (offset: 0x8723)
// dev strs .. 3   (offset: 0x9367)
// exports ... 73  (offset: 0x5c53)
// cseg ...... 0x107a + 0x4bd9 (0x5c53)
// imports ... 191 (offset: 0x67bb)
// animtree1 . 0   (offset: 0x938b)
// animtree2 . 0   (offset: 0x938b)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_player;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\equipment;

#namespace test_mp_movement;

// Namespace test_mp_movement/testautomation
// Params 0, eflags: 0x20
// Checksum 0xaba81dc1, Offset: 0x1098
// Size: 0x26
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_movement.gsc", #"GP", &function_fe57848fa83c781b, &setup, &cleanup );
}

// Namespace test_mp_movement
// Params 0
// Checksum 0xc2309924, Offset: 0x10c6
// Size: 0x1d
function function_fe57848fa83c781b()
{
    player = autotests_utility_player::get_player();
    function_aa691720f4e03bda( player );
}

// Namespace test_mp_movement
// Params 0
// Checksum 0x42e3783c, Offset: 0x10eb
// Size: 0x41
function function_6ff77ed8475fd98d()
{
    comparemovement = getdvarint( @"hash_f0534a600ec3839d", 0 );
    player = autotests_utility_player::get_player();
    function_2d8292c4f519d510( player );
    
    if ( comparemovement )
    {
        function_3e2828c9ac3a8e85();
    }
}

// Namespace test_mp_movement
// Params 0, eflags: 0x4
// Checksum 0x24765db1, Offset: 0x1134
// Size: 0x27a
function private setup()
{
    autotests::function_5c8c87763724c132();
    autotests_utility::setup();
    level autotests_utility::function_4104f641c0755805( #"reload", "reload_finished" );
    player = autotests_utility_player::get_player();
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Player found?", player, "scripts/autotests/mp/test_mp_movement.gsc", 122 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests::push_function( "Prematch completed" );
    test_result_int = player autotests_utility::test_prematch_done() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Prematch completed", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 123 );
    autotests::pop_function( "Prematch completed" );
    autotests::test_assert_return( test_result_int );
    autotests::set_dvar( @"hash_829c5a80bc42ed8a", 6 );
    autotests::set_dvar( @"hash_9e49766c62b3af0d", 360 );
    
    if ( getdvarint( @"hash_66151aafc2c16025", 0 ) )
    {
        autotests::set_dvar( @"hash_194e653c1be4c155", 1 );
    }
    
    player function_ffb0711adb6d8d0d();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player is autopiloted?", isautopilot( player ), "scripts/autotests/mp/test_mp_movement.gsc", 139 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    autotests_utility_bot::set_bot_ignore_script_weapon( player, 0 );
    autotests_utility_bot::set_bot_godmode( player, 1 );
    level.autotests.test_runtime.var_9ba9ad319d13f9f4 = player function_aaad5ae04c1e5224( "enable_deploy_parachute" );
    player botsetflag( "enable_deploy_parachute", 0 );
    var_e0aa576ad69f0b09 = function_1477122da9a71c3f( player );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player has pistol?", player hasweapon( var_e0aa576ad69f0b09 ), "scripts/autotests/mp/test_mp_movement.gsc", 148 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    weapon = function_5c902fd43ab54868( player );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player has autotest fists?", player hasweapon( weapon ), "scripts/autotests/mp/test_mp_movement.gsc", 151 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    groundposition = getgroundposition( player.origin, 100 );
    level.autotests.test_runtime.var_30ad434f9f0f4216 = groundposition[ 2 ];
    wait 1;
    thread recharge_tac_sprint( player );
    return 1;
}

// Namespace test_mp_movement
// Params 0, eflags: 0x4
// Checksum 0xc7c69eec, Offset: 0x13b7
// Size: 0x15d
function private cleanup()
{
    autotests_utility::cleanup();
    level autotests_utility::flag_remove_callback( #"reload", "reload_finished" );
    player = autotests_utility_player::get_player();
    
    if ( isautopilot( player ) )
    {
        player botsetflag( "enable_deploy_parachute", level.autotests.test_runtime.var_9ba9ad319d13f9f4 );
        player botclearscriptgoal();
        player botsetscriptmove( 0, 0 );
        autotests_utility_bot::set_bot_godmode( player, 0 );
        autotests_utility_bot::set_bot_ignore_script_weapon( player, 1 );
        player playerexitautopilotmode();
    }
    
    weapon = get_autotest_weapon();
    player takeweapon( weapon );
    
    if ( level.autotests.test_runtime.var_ca6497750afefcf2 )
    {
        weapon = level.autotests.test_runtime.var_486ea189e929b49b;
        player takeweapon( weapon );
    }
    
    player allowsupersprint( !level.disablesupersprint );
    player perk::removeperk( "specialty_gungho" );
    player perk::removeperk( "specialty_outlander" );
    player perk::removeperk( "specialty_resolute" );
    player perk::removeperk( "specialty_athletics" );
    player perk::removeperk( "specialty_grenadier" );
    level notify( #"hash_f79c20ca926405c1" );
    level notify( #"hash_e3f58be7b533a87b" );
}

// Namespace test_mp_movement
// Params 1, eflags: 0x4
// Checksum 0xec26d089, Offset: 0x151c
// Size: 0xa2
function private cleanup_post_movement( player )
{
    level notify( #"stop_movement" );
    player botsetscriptmove( 0, 0 );
    player botclearbutton( "sprint" );
    
    if ( player isinfreefall() )
    {
        player skydive_setdeploymentstatus( 1 );
        player skydive_setbasejumpingstatus( 1 );
        
        while ( !player isparachuting() )
        {
            player autotests_utility_bot::function_aaa2288bee31d766( "jump", undefined, 0.1, undefined, 1 );
        }
    }
    
    player setorigin( function_cec3cd2b8ed2a234() );
    
    while ( length( player getvelocity() ) > 0 )
    {
        waitframe();
    }
    
    player botsetstance( "stand" );
    wait 1;
}

// Namespace test_mp_movement
// Params 1, eflags: 0x4
// Checksum 0xeda11275, Offset: 0x15c6
// Size: 0x31
function private function_4f65264cd8166eaa( position )
{
    return ( position[ 0 ], position[ 1 ], level.autotests.test_runtime.var_30ad434f9f0f4216 );
}

// Namespace test_mp_movement
// Params 0, eflags: 0x4
// Checksum 0xee200949, Offset: 0x1600
// Size: 0x3e
function private function_cec3cd2b8ed2a234()
{
    position = autotests::get_struct_location( "test_location_movement_start" );
    return ( position[ 0 ], position[ 1 ], level.autotests.test_runtime.var_30ad434f9f0f4216 );
}

// Namespace test_mp_movement
// Params 0, eflags: 0x4
// Checksum 0x7455ceb2, Offset: 0x1647
// Size: 0x42
function private get_parachute_position()
{
    position = autotests::get_struct_location( "test_location_movement_start" );
    return ( position[ 0 ], position[ 1 ], level.autotests.test_runtime.var_30ad434f9f0f4216 + 6000 );
}

// Namespace test_mp_movement
// Params 0, eflags: 0x4
// Checksum 0xe7121944, Offset: 0x1692
// Size: 0x42
function private function_45a146424b61cfff()
{
    position = autotests::get_struct_location( "test_location_movement_start" );
    return ( position[ 0 ], position[ 1 ], level.autotests.test_runtime.var_30ad434f9f0f4216 + 1000 );
}

// Namespace test_mp_movement
// Params 0, eflags: 0x4
// Checksum 0x1d186358, Offset: 0x16dd
// Size: 0x42
function private get_free_fall_position()
{
    position = autotests::get_struct_location( "test_location_movement_start" );
    return ( position[ 0 ], position[ 1 ], level.autotests.test_runtime.var_30ad434f9f0f4216 + 15000 );
}

// Namespace test_mp_movement
// Params 0, eflags: 0x4
// Checksum 0x59225d7c, Offset: 0x1728
// Size: 0x3c
function private get_autotest_weapon()
{
    bundle = level.autotests.test_runtime.bundle;
    return weapon_utility::makedefaultweapon( bundle.movementweapon );
}

// Namespace test_mp_movement
// Params 1, eflags: 0x4
// Checksum 0xb5af4714, Offset: 0x176d
// Size: 0x21f
function private function_1477122da9a71c3f( player )
{
    foreach ( weapon in player.primaryweapons )
    {
        if ( weapon.classname == "pistol" && !weapon::isbackuppistol( weapon ) )
        {
            level.autotests.test_runtime.var_486ea189e929b49b = weapon;
            return weapon;
        }
    }
    
    foreach ( baseweapon, weaponstruct in level.commonitem.var_685573a854ce8718 )
    {
        if ( issubstr( baseweapon, "_pi_" ) )
        {
            bundlename = weaponstruct.bundles[ 0 ][ 0 ];
            weaponref = getscriptbundlefieldvalue( bundlename, #"ref" );
            break;
        }
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Found pistol?", weaponref, "scripts/autotests/mp/test_mp_movement.gsc", 286 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    weapon = weapon::buildweapon( weaponref );
    player giveweapon( weapon );
    player inventory_utility::domonitoredweaponswitch( weapon, 1, 1, 1 );
    level.autotests.test_runtime.var_486ea189e929b49b = weapon;
    level.autotests.test_runtime.var_ca6497750afefcf2 = 1;
    return weapon;
}

// Namespace test_mp_movement
// Params 1, eflags: 0x4
// Checksum 0xb4defed1, Offset: 0x1995
// Size: 0x38
function private function_5c902fd43ab54868( player )
{
    weapon = get_autotest_weapon();
    player giveweapon( weapon );
    player inventory_utility::domonitoredweaponswitch( weapon, 1, 1, 1 );
    return weapon;
}

// Namespace test_mp_movement
// Params 1, eflags: 0x4
// Checksum 0xad932f8c, Offset: 0x19d6
// Size: 0x30
function private function_afc91a82506c85dd( player )
{
    weapon = get_autotest_weapon();
    player inventory_utility::domonitoredweaponswitch( weapon, 1, 1, 1 );
    return weapon;
}

// Namespace test_mp_movement
// Params 1, eflags: 0x4
// Checksum 0x65ce6289, Offset: 0x1a0f
// Size: 0x47
function private function_e87d01151d788c41( player )
{
    weapon = level.autotests.test_runtime.var_486ea189e929b49b;
    player inventory_utility::domonitoredweaponswitch( weapon, 1, 1, 1 );
    return weapon;
}

// Namespace test_mp_movement
// Params 1, eflags: 0x4
// Checksum 0x47e5f061, Offset: 0x1a5f
// Size: 0xdd0
function private function_aa691720f4e03bda( player )
{
    var_396757728673c88a = 2;
    lookangles = ( 0, 0, 0 );
    suitbundle = function_6c01510e681b2a28( player.operatorcustomization.suit );
    autotests::push_function( "Crouching player forward?" );
    test_result_int = crouch_move_player( player, &is_crouched, ( 0, 0, 0 ), ( 0, 0, 0 ), 0, var_396757728673c88a ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Crouching player forward?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 340 );
    autotests::pop_function( "Crouching player forward?" );
    autotests::test_assert_return( test_result_int );
    cleanup_post_movement( player );
    autotests::push_function( "Crawling player forward?" );
    test_result_int = prone_move_player( player, &is_prone, ( 0, 0, 0 ), ( 0, 0, 0 ), 0, var_396757728673c88a ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Crawling player forward?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 344 );
    autotests::pop_function( "Crawling player forward?" );
    autotests::test_assert_return( test_result_int );
    cleanup_post_movement( player );
    
    if ( !function_9ab9761f98e7b330( player, suitbundle ) )
    {
        autotests::push_function( "Tac sprint doesn't engage when disabled?" );
        test_result_int = function_332b775e55d6e503( player, &is_tac_sprinting, ( 0, 0, 0 ), ( 0, 0, 0 ), 0, 5, 0, undefined, 0 ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Tac sprint doesn't engage when disabled?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 350 );
        autotests::pop_function( "Tac sprint doesn't engage when disabled?" );
        autotests::test_assert_return( test_result_int );
        
        if ( !suitbundle.var_7bdfe43bd1a2d90c && !isdefined( player.perks[ "specialty_athletics" ] ) )
        {
            var_381f0e945303efd1 = 1;
            player perk::giveperk( "specialty_athletics" );
        }
        
        player allowsupersprint( 1 );
        var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Tac sprint enabled after forcing?", function_9ab9761f98e7b330( player, suitbundle ), "scripts/autotests/mp/test_mp_movement.gsc", 362 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    
    autotests::push_function( "Tac sprint ran out?" );
    test_result_int = function_fa7cd85990484284( player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Tac sprint ran out?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 366 );
    autotests::pop_function( "Tac sprint ran out?" );
    autotests::test_assert_return( test_result_int );
    cleanup_post_movement( player );
    autotests::push_function( "Tac sprint was unlimited with melee?" );
    test_result_int = function_c4f3f5d407b87716( player, 0 ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Tac sprint was unlimited with melee?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 369 );
    autotests::pop_function( "Tac sprint was unlimited with melee?" );
    autotests::test_assert_return( test_result_int );
    cleanup_post_movement( player );
    
    if ( !var_381f0e945303efd1 )
    {
        autotests::push_function( "Tac sprint was unlimited with sprinter perk?" );
        test_result_int = function_c4f3f5d407b87716( player, 1 ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Tac sprint was unlimited with sprinter perk?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 375 );
        autotests::pop_function( "Tac sprint was unlimited with sprinter perk?" );
        autotests::test_assert_return( test_result_int );
        cleanup_post_movement( player );
    }
    
    autotests::push_function( "Can sprint while reloading?" );
    test_result_int = function_53129c64b675501a( player, &sprint_move_player, &is_sprinting, 0, 5, 0, 1 ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Can sprint while reloading?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 380 );
    autotests::pop_function( "Can sprint while reloading?" );
    autotests::test_assert_return( test_result_int );
    cleanup_post_movement( player );
    
    if ( !isdefined( player.perks[ "specialty_supersprintreload" ] ) )
    {
        autotests::push_function( "Tac sprint interrupted by reload?" );
        test_result_int = function_53129c64b675501a( player, &function_332b775e55d6e503, &is_tac_sprinting, 0, 5, 0, 0 ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Tac sprint interrupted by reload?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 385 );
        autotests::pop_function( "Tac sprint interrupted by reload?" );
        autotests::test_assert_return( test_result_int );
        cleanup_post_movement( player );
    }
    
    if ( perks::function_ae69f867e887ac4a( "specialty_gungho" ) )
    {
        autotests::push_function( "Can tac-sprint while reloading with gungho?" );
        test_result_int = function_53129c64b675501a( player, &function_332b775e55d6e503, &is_tac_sprinting, 1, 5, 0, 1 ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Can tac-sprint while reloading with gungho?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 391 );
        autotests::pop_function( "Can tac-sprint while reloading with gungho?" );
        autotests::test_assert_return( test_result_int );
        cleanup_post_movement( player );
    }
    else if ( var_381f0e945303efd1 && isdefined( player.perks[ "specialty_supersprintreload" ] ) )
    {
        autotests::push_function( "Can tac-sprint while reloading with sprinter?" );
        test_result_int = function_53129c64b675501a( player, &function_332b775e55d6e503, &is_tac_sprinting, 1, 5, 0, 1 ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Can tac-sprint while reloading with sprinter?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 396 );
        autotests::pop_function( "Can tac-sprint while reloading with sprinter?" );
        autotests::test_assert_return( test_result_int );
        cleanup_post_movement( player );
    }
    
    if ( perks::function_ae69f867e887ac4a( "specialty_resolute" ) && level.perkbundles[ "specialty_resolute" ].var_4ee89a57b15ba9d != 0 )
    {
        autotests::push_function( "Move faster with resolute perk after being shot?" );
        test_result_int = function_3974e8f0122a54d0( player, var_396757728673c88a ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Move faster with resolute perk after being shot?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 403 );
        autotests::pop_function( "Move faster with resolute perk after being shot?" );
        autotests::test_assert_return( test_result_int );
        cleanup_post_movement( player );
    }
    
    if ( perks::function_ae69f867e887ac4a( "specialty_outlander" ) )
    {
        gasorigin = level.dev_activities[ "gas_pocket" ].prefabstruct.origin;
        
        if ( gasorigin )
        {
            autotests::push_function( "Move faster with irradiated perk in gas?" );
            test_result_int = function_decbedbff8fb083a( player, var_396757728673c88a ) ?? 0;
            test_result_int = autotests::function_e496a326e5d58a25( "Move faster with irradiated perk in gas?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 413 );
            autotests::pop_function( "Move faster with irradiated perk in gas?" );
            autotests::test_assert_return( test_result_int );
            cleanup_post_movement( player );
        }
    }
    
    bundle = level.autotests.test_runtime.bundle;
    
    if ( bundle.var_e42c15e1068efbff && perks::function_ae69f867e887ac4a( "specialty_grenadier" ) )
    {
        autotests::push_function( "Move slower when hit with enemy grenade?" );
        test_result_int = function_91b18b7a0966818d( player, var_396757728673c88a ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Move slower when hit with enemy grenade?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 422 );
        autotests::pop_function( "Move slower when hit with enemy grenade?" );
        autotests::test_assert_return( test_result_int );
        cleanup_post_movement( player );
    }
    
    if ( perks::function_ae69f867e887ac4a( "specialty_gungho" ) )
    {
        autotests::push_function( "Move faster when cooking grenade with gungho?" );
        test_result_int = function_f874d85e847747a9( player, var_396757728673c88a ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Move faster when cooking grenade with gungho?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 429 );
        autotests::pop_function( "Move faster when cooking grenade with gungho?" );
        autotests::test_assert_return( test_result_int );
        cleanup_post_movement( player );
    }
    
    autotests::push_function( "Can parachute?" );
    test_result_int = parachute_player( player, &is_parachuting, ( 0, 0, 0 ), ( 0, 0, 0 ), var_396757728673c88a ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Can parachute?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 434 );
    autotests::pop_function( "Can parachute?" );
    autotests::test_assert_return( test_result_int );
    cleanup_post_movement( player );
    autotests::push_function( "Can freefall?" );
    test_result_int = move_player( player, &is_free_falling, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, var_396757728673c88a, 0, get_free_fall_position() ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Can freefall?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 437 );
    autotests::pop_function( "Can freefall?" );
    autotests::test_assert_return( test_result_int );
    cleanup_post_movement( player );
    autotests::push_function( "Can cut chute and freefall?" );
    test_result_int = function_bff47da03bfda668( player, &is_free_falling, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, var_396757728673c88a, 0, get_free_fall_position() ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Can cut chute and freefall?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 440 );
    autotests::pop_function( "Can cut chute and freefall?" );
    autotests::test_assert_return( test_result_int );
    cleanup_post_movement( player );
    autotests::push_function( "Does parachute auto deploy?" );
    test_result_int = function_1bafea5f97824c14( player, 1, 0, undefined, 1 ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Does parachute auto deploy?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 445 );
    autotests::pop_function( "Does parachute auto deploy?" );
    autotests::test_assert_return( test_result_int );
    cleanup_post_movement( player );
    autotests::push_function( "Does parachute not autodeploy (autoDeploy = false, autoDeploySafe = false?" );
    test_result_int = function_1bafea5f97824c14( player, 0, 0, undefined, 0 ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Does parachute not autodeploy (autoDeploy = false, autoDeploySafe = false?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 449 );
    autotests::pop_function( "Does parachute not autodeploy (autoDeploy = false, autoDeploySafe = false?" );
    autotests::test_assert_return( test_result_int );
    cleanup_post_movement( player );
    autotests::push_function( "Does parachute not autodeploy at low height (autoDeploy = true, autoDeploySafe = false)?" );
    test_result_int = function_1bafea5f97824c14( player, 1, 0, function_45a146424b61cfff(), 0 ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Does parachute not autodeploy at low height (autoDeploy = true, autoDeploySafe = false)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 454 );
    autotests::pop_function( "Does parachute not autodeploy at low height (autoDeploy = true, autoDeploySafe = false)?" );
    autotests::test_assert_return( test_result_int );
    cleanup_post_movement( player );
    autotests::push_function( "Does parachute autodeploy at low height (autoDeploy = true, autoDeploySafe = true)?" );
    test_result_int = function_1bafea5f97824c14( player, 1, 1, function_45a146424b61cfff(), 1 ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Does parachute autodeploy at low height (autoDeploy = true, autoDeploySafe = true)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 459 );
    autotests::pop_function( "Does parachute autodeploy at low height (autoDeploy = true, autoDeploySafe = true)?" );
    autotests::test_assert_return( test_result_int );
    cleanup_post_movement( player );
    var_434354c168257ace = autotests::get_struct_location( "test_location_movement_mantle_small" );
    endlocation = autotests::get_struct_location( "test_location_movement_mantle_end" );
    autotests::push_function( "Does mantle work over small wall?" );
    test_result_int = test_mantle( player, &function_1926dc1f7ff6bdc, var_434354c168257ace, endlocation, 2, 1 ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Does mantle work over small wall?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 465 );
    autotests::pop_function( "Does mantle work over small wall?" );
    autotests::test_assert_return( test_result_int );
    cleanup_post_movement( player );
    var_7958ad284878d63f = autotests::get_struct_location( "test_location_movement_mantle_big" );
    autotests::push_function( "Does hang and mantle work over big wall?" );
    test_result_int = test_mantle( player, &function_1eb6c76ab64eb542, var_7958ad284878d63f, endlocation, 2, 1 ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Does hang and mantle work over big wall?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 470 );
    autotests::pop_function( "Does hang and mantle work over big wall?" );
    autotests::test_assert_return( test_result_int );
    cleanup_post_movement( player );
    var_8e6e8759f022d769 = autotests::get_struct_location( "test_location_movement_mantle_too_big" );
    autotests::push_function( "Does mantle not work over too big wall?" );
    test_result_int = test_mantle( player, &function_2dd85eaaf1e712de, var_8e6e8759f022d769, endlocation, 2, 0 ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Does mantle not work over too big wall?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 474 );
    autotests::pop_function( "Does mantle not work over too big wall?" );
    autotests::test_assert_return( test_result_int );
    cleanup_post_movement( player );
    
    if ( suitbundle.var_30550fdcb27cb179 && getdvarint( @"hash_66151aafc2c16025", 0 ) )
    {
        function_e87d01151d788c41( player );
        autotests::push_function( "Does corner slicing left work?" );
        test_result_int = test_corner_slicing( player, ( 0, 90, 0 ) ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Does corner slicing left work?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 484 );
        autotests::pop_function( "Does corner slicing left work?" );
        autotests::test_assert_return( test_result_int );
        cleanup_post_movement( player );
        autotests::push_function( "Does corner slicing right work?" );
        test_result_int = test_corner_slicing( player, ( 0, 270, 0 ) ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Does corner slicing right work?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 487 );
        autotests::pop_function( "Does corner slicing right work?" );
        autotests::test_assert_return( test_result_int );
        cleanup_post_movement( player );
        function_afc91a82506c85dd( player );
    }
    else
    {
        autotests::report_info( "Corner slice tests skipped" );
    }
    
    autotests::push_function( "Does sprint resume after sliding (enabled)?" );
    test_result_int = function_4989ecfa52884bde( player, ( 0, 0, 0 ), ( 0, 0, 0 ), 1 ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Does sprint resume after sliding (enabled)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 497 );
    autotests::pop_function( "Does sprint resume after sliding (enabled)?" );
    autotests::test_assert_return( test_result_int );
    cleanup_post_movement( player );
    autotests::push_function( "Does sprint not resume after sliding (disabled)?" );
    test_result_int = function_4989ecfa52884bde( player, ( 0, 0, 0 ), ( 0, 0, 0 ), 0 ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Does sprint not resume after sliding (disabled)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 500 );
    autotests::pop_function( "Does sprint not resume after sliding (disabled)?" );
    autotests::test_assert_return( test_result_int );
    cleanup_post_movement( player );
    autotests::push_function( "Can sprint bash through door (enabled)?" );
    test_result_int = test_door_bash( player, 1 ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Can sprint bash through door (enabled)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 503 );
    autotests::pop_function( "Can sprint bash through door (enabled)?" );
    autotests::test_assert_return( test_result_int );
    cleanup_post_movement( player );
    autotests::push_function( "Can NOT sprint bash through door (disabled)?" );
    test_result_int = test_door_bash( player, 0 ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Can NOT sprint bash through door (disabled)?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 506 );
    autotests::pop_function( "Can NOT sprint bash through door (disabled)?" );
    autotests::test_assert_return( test_result_int );
    cleanup_post_movement( player );
    function_feca255249390518( player, lookangles, var_396757728673c88a, suitbundle );
}

// Namespace test_mp_movement
// Params 4, eflags: 0x4
// Checksum 0xf5aa148b, Offset: 0x2837
// Size: 0x4c1
function private function_feca255249390518( player, lookangles, var_396757728673c88a, suitbundle )
{
    var_9f74b9a2a64df974 = [];
    
    if ( suitbundle.omnisprint_enable )
    {
        var_9f74b9a2a64df974[ "forward_left" ] = ( 0, 0, 0 ) + ( 0, 45, 0 );
        var_9f74b9a2a64df974[ "forward" ] = ( 0, 0, 0 );
        var_9f74b9a2a64df974[ "left" ] = ( 0, 90, 0 );
        var_9f74b9a2a64df974[ "left_backward" ] = ( 0, 90, 0 ) + ( 0, 45, 0 );
        var_9f74b9a2a64df974[ "backward" ] = ( 0, 180, 0 );
        var_9f74b9a2a64df974[ "backward_right" ] = ( 0, 180, 0 ) + ( 0, 45, 0 );
        var_9f74b9a2a64df974[ "right" ] = ( 0, 270, 0 );
        var_9f74b9a2a64df974[ "right_forward" ] = ( 0, 270, 0 ) + ( 0, 45, 0 );
    }
    else
    {
        var_9f74b9a2a64df974[ "forward" ] = ( 0, 0, 0 );
        var_9f74b9a2a64df974[ "left" ] = ( 0, 90, 0 );
        var_9f74b9a2a64df974[ "right" ] = ( 0, 270, 0 );
        var_9f74b9a2a64df974[ "backward" ] = ( 0, 180, 0 );
    }
    
    foreach ( name, movementangles in var_9f74b9a2a64df974 )
    {
        autotests::push_function( "Sprinting player " + name + "?" );
        test_result_int = sprint_move_player( player, &is_sprinting, movementangles, lookangles, undefined, var_396757728673c88a ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Sprinting player " + name + "?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 540 );
        autotests::pop_function( "Sprinting player " + name + "?" );
        autotests::test_assert_return( test_result_int );
        cleanup_post_movement( player );
        var_59a5756abc30e310 = anglestoforward( movementangles );
        lookvector = anglestoforward( lookangles );
        dot = vectordot( lookvector, var_59a5756abc30e310 );
        var_a15fbf07ce307e22 = dot < 0;
        var_5dc3346e36dad2c7 = dot == 0;
        
        if ( var_a15fbf07ce307e22 || var_5dc3346e36dad2c7 )
        {
            autotests::push_function( "Player cannot tac-sprint " + name + "?" );
            test_result_int = function_332b775e55d6e503( player, &is_tac_sprinting, movementangles, lookangles, undefined, var_396757728673c88a, undefined, undefined, 0 ) ?? 0;
            test_result_int = autotests::function_e496a326e5d58a25( "Player cannot tac-sprint " + name + "?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 551 );
            autotests::pop_function( "Player cannot tac-sprint " + name + "?" );
            autotests::test_assert_return( test_result_int );
        }
        else
        {
            var_defc3e34b56a50ec = abs( 0.707106 - dot ) < 1e-05;
            
            if ( !var_defc3e34b56a50ec || 0 )
            {
                autotests::push_function( "Tac-sprinting player " + name + "?" );
                test_result_int = function_332b775e55d6e503( player, &is_tac_sprinting, movementangles, lookangles, undefined, var_396757728673c88a ) ?? 0;
                test_result_int = autotests::function_e496a326e5d58a25( "Tac-sprinting player " + name + "?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 561 );
                autotests::pop_function( "Tac-sprinting player " + name + "?" );
                autotests::test_assert_return( test_result_int );
            }
        }
        
        cleanup_post_movement( player );
        autotests::push_function( "Diving player " + name + "?" );
        test_result_int = dive_move_player( player, &is_diving, movementangles, lookangles, 1, var_396757728673c88a ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Diving player " + name + "?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 567 );
        autotests::pop_function( "Diving player " + name + "?" );
        autotests::test_assert_return( test_result_int );
        cleanup_post_movement( player );
        autotests::push_function( "Sliding player " + name + "?" );
        test_result_int = slide_move_player( player, &function_f6c68b423a455057, movementangles, lookangles, 1, var_396757728673c88a ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Sliding player " + name + "?", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 570 );
        autotests::pop_function( "Sliding player " + name + "?" );
        autotests::test_assert_return( test_result_int );
        cleanup_post_movement( player );
    }
}

// Namespace test_mp_movement
// Params 2, eflags: 0x4
// Checksum 0x30fb6dff, Offset: 0x2d00
// Size: 0x7ff
function private function_2d8292c4f519d510( player, record )
{
    level endon( #"end_test" );
    level endon( #"test_finished" );
    autotests::push_function( "Moving player forward" );
    test_result_int = function_bd94145df6307f88( player, &move_player, &is_walking, ( 0, 0, 0 ), ( 0, 0, 0 ), "walk_forward" ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Moving player forward", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 582 );
    autotests::pop_function( "Moving player forward" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Moving player backward" );
    test_result_int = function_bd94145df6307f88( player, &move_player, &is_walking, ( 0, 0, 0 ), ( 0, 180, 0 ), "walk_backward" ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Moving player backward", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 583 );
    autotests::pop_function( "Moving player backward" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Sprinting player forward" );
    test_result_int = function_bd94145df6307f88( player, &sprint_move_player, &is_sprinting, ( 0, 0, 0 ), ( 0, 0, 0 ), "sprint_forward" ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Sprinting player forward", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 584 );
    autotests::pop_function( "Sprinting player forward" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Sprinting player backward" );
    test_result_int = function_bd94145df6307f88( player, &sprint_move_player, &is_sprinting, ( 0, 0, 0 ), ( 0, 180, 0 ), "sprint_backward" ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Sprinting player backward", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 585 );
    autotests::pop_function( "Sprinting player backward" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Crouching player forward" );
    test_result_int = function_bd94145df6307f88( player, &crouch_move_player, &is_crouched, ( 0, 0, 0 ), ( 0, 0, 0 ), "crouch_forward" ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Crouching player forward", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 586 );
    autotests::pop_function( "Crouching player forward" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Crouching player backward" );
    test_result_int = function_bd94145df6307f88( player, &crouch_move_player, &is_crouched, ( 0, 0, 0 ), ( 0, 180, 0 ), "crouch_backward" ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Crouching player backward", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 587 );
    autotests::pop_function( "Crouching player backward" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Prone crawling player forward" );
    test_result_int = function_bd94145df6307f88( player, &prone_move_player, &is_prone, ( 0, 0, 0 ), ( 0, 0, 0 ), "prone_forward" ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Prone crawling player forward", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 588 );
    autotests::pop_function( "Prone crawling player forward" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Prone crawling player backward" );
    test_result_int = function_bd94145df6307f88( player, &prone_move_player, &is_prone, ( 0, 0, 0 ), ( 0, 180, 0 ), "prone_backward" ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Prone crawling player backward", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 589 );
    autotests::pop_function( "Prone crawling player backward" );
    autotests::test_assert_return( test_result_int );
    suitbundle = function_6c01510e681b2a28( player.operatorcustomization.suit );
    
    if ( !function_9ab9761f98e7b330( player, suitbundle ) )
    {
        player allowsupersprint( 1 );
        player perk::giveperk( "specialty_athletics" );
        autotests::push_function( "Tac-sprinting player forward" );
        test_result_int = function_bd94145df6307f88( player, &function_332b775e55d6e503, &is_tac_sprinting, ( 0, 0, 0 ), ( 0, 0, 0 ), "tac_sprint_forward" ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Tac-sprinting player forward", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 598 );
        autotests::pop_function( "Tac-sprinting player forward" );
        autotests::test_assert_return( test_result_int );
    }
    
    autotests::push_function( "Sliding player forward" );
    test_result_int = function_bd94145df6307f88( player, &slide_move_player, &function_f6c68b423a455057, ( 0, 0, 0 ), ( 0, 0, 0 ), "slide_forward", undefined, 1 ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Sliding player forward", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 602 );
    autotests::pop_function( "Sliding player forward" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Sliding player backward" );
    test_result_int = function_bd94145df6307f88( player, &slide_move_player, &function_f6c68b423a455057, ( 0, 0, 0 ), ( 0, 180, 0 ), "slide_backward", undefined, 1 ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Sliding player backward", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 603 );
    autotests::pop_function( "Sliding player backward" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Diving player forward" );
    test_result_int = function_bd94145df6307f88( player, &dive_move_player, &is_diving, ( 0, 0, 0 ), ( 0, 0, 0 ), "dive_forward", undefined, 1 ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Diving player forward", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 606 );
    autotests::pop_function( "Diving player forward" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Diving player backward" );
    test_result_int = function_bd94145df6307f88( player, &dive_move_player, &is_diving, ( 0, 0, 0 ), ( 0, 180, 0 ), "dive_backward", undefined, 1 ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Diving player backward", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 607 );
    autotests::pop_function( "Diving player backward" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Parachuting player in place" );
    test_result_int = function_bd94145df6307f88( player, &parachute_player, &is_parachuting, ( 0, 0, 0 ), ( 0, 0, 0 ), "parachute_in_place" ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Parachuting player in place", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 610 );
    autotests::pop_function( "Parachuting player in place" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Parachuting player forward" );
    test_result_int = function_bd94145df6307f88( player, &parachute_move_player, &is_parachuting, ( 0, 0, 0 ), ( 0, 0, 0 ), "parachute_forward" ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Parachuting player forward", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 611 );
    autotests::pop_function( "Parachuting player forward" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Free fall player in place" );
    test_result_int = function_bd94145df6307f88( player, &move_player, &is_free_falling, undefined, ( 0, 0, 0 ), "free_fall_in_place" ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Free fall player in place", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 613 );
    autotests::pop_function( "Free fall player in place" );
    autotests::test_assert_return( test_result_int );
    autotests::push_function( "Free fall player down" );
    test_result_int = function_bd94145df6307f88( player, &move_player, &is_free_falling, ( 0, 0, 0 ), ( 85, 0, 0 ), "free_fall_down" ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Free fall player down", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_movement.gsc", 614 );
    autotests::pop_function( "Free fall player down" );
    autotests::test_assert_return( test_result_int );
}

// Namespace test_mp_movement
// Params 2, eflags: 0x4
// Checksum 0xde515ddc, Offset: 0x3507
// Size: 0x17b
function private function_adf32b069b15ad3b( player, var_2f1b143da5a6098f )
{
    level endon( #"end_test" );
    level endon( #"test_finished" );
    autotests_utility::flag_clear( "stop_recording" );
    level waittill( #"start_recording" );
    autotests::report_info( "Recording started" );
    highestspeed = 0;
    averagespeed = 0;
    framecount = 1;
    starttime = gettime();
    
    while ( true )
    {
        if ( autotests_utility::flag( "stop_recording" ) )
        {
            endtime = gettime();
            seconds = ( endtime - starttime ) / 1000;
            break;
        }
        
        speed = length( player getvelocity() );
        averagespeed = ( averagespeed * ( framecount - 1 ) + speed ) / framecount;
        framecount++;
        
        /#
            if ( getdvarint( @"hash_9ba60d8276f21e93", 0 ) )
            {
                println( "<dev string:x24>" + speed + "<dev string:x47>" + averagespeed );
            }
        #/
        
        if ( speed > highestspeed )
        {
            highestspeed = speed;
        }
        
        waitframe();
    }
    
    averagespeed = round( averagespeed );
    highestspeed = round( highestspeed );
    autotests::report_info( var_2f1b143da5a6098f + " - " + "Average speed: " + averagespeed + ", Highest speed:" + highestspeed );
    autotests::report_info( "Seconds: " + seconds );
    record_metric( "average_speed_" + var_2f1b143da5a6098f, averagespeed );
    record_metric( "highest_speed_" + var_2f1b143da5a6098f, highestspeed );
}

// Namespace test_mp_movement
// Params 2, eflags: 0x4
// Checksum 0xfa3a001c, Offset: 0x368a
// Size: 0x64
function private record_metric( var_f4a3f7407ab8c575, var_555b956c6153f5f7 )
{
    var_4c820e41a4a018e4 = level.autotests.test_runtime.var_4c820e41a4a018e4 ?? [];
    level.autotests.test_runtime.var_4c820e41a4a018e4[ var_f4a3f7407ab8c575 ] = var_555b956c6153f5f7;
}

// Namespace test_mp_movement
// Params 1, eflags: 0x4
// Checksum 0xd17ec5c1, Offset: 0x36f6
// Size: 0x41
function private get_metric( var_f4a3f7407ab8c575 )
{
    var_4c820e41a4a018e4 = level.autotests.test_runtime.var_4c820e41a4a018e4;
    
    if ( !var_4c820e41a4a018e4 )
    {
        return [];
    }
    
    return var_4c820e41a4a018e4[ var_f4a3f7407ab8c575 ];
}

// Namespace test_mp_movement
// Params 9, eflags: 0x4
// Checksum 0xd11877c9, Offset: 0x3740
// Size: 0x90
function private function_bd94145df6307f88( player, movementfunction, var_1eb21c6c806c259c, movementangles, lookangles, var_2f1b143da5a6098f, var_396757728673c88a, endoncondition, locationoverride )
{
    level endon( #"end_test" );
    level endon( #"test_finished" );
    childthread [[ movementfunction ]]( player, var_1eb21c6c806c259c, movementangles, lookangles, undefined, var_396757728673c88a, endoncondition, locationoverride, 1 );
    function_adf32b069b15ad3b( player, var_2f1b143da5a6098f );
    cleanup_post_movement( player );
}

// Namespace test_mp_movement
// Params 9, eflags: 0xc
// Checksum 0x9888f0b8, Offset: 0x37d8
// Size: 0x1ba
function private move_player( player, var_1eb21c6c806c259c, movementangles, lookangles, var_df6f1081b2420570 = 1, var_396757728673c88a = 5, endoncondition, startlocation, var_7cf9bdbc4bd15f1d = 1 )
{
    self notify( #"hash_bacd75ce949f90bf" );
    self endon( #"hash_bacd75ce949f90bf" );
    level endon( #"end_test" );
    level endon( #"test_finished" );
    level endon( #"stop_movement" );
    
    if ( !isdefined( startlocation ) )
    {
        startlocation = function_cec3cd2b8ed2a234();
    }
    
    player setorigin( startlocation );
    autotests_utility::flag_clear( "movement_ended" );
    player setplayerangles( lookangles );
    waitframe();
    player botclearscriptgoal();
    
    if ( movementangles )
    {
        player botsetscriptmove( movementangles[ 1 ], var_396757728673c88a );
    }
    
    while ( length( player getvelocity() ) == 0 )
    {
        waitframe();
    }
    
    level notify( #"movement_started" );
    
    if ( var_df6f1081b2420570 )
    {
        level notify( #"start_recording" );
    }
    
    if ( var_1eb21c6c806c259c )
    {
        thread function_b30ac8a8b4ef1af2( player, var_1eb21c6c806c259c, movementangles, endoncondition, var_7cf9bdbc4bd15f1d );
    }
    
    wait var_396757728673c88a;
    
    if ( var_1eb21c6c806c259c )
    {
        var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Movement condition met?", level.autotests.test_runtime.var_1c5b370aff94a3ca, "scripts/autotests/mp/test_mp_movement.gsc", 765 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    
    player botclearscriptgoal();
    autotests_utility::flag_set( "stop_recording" );
    autotests_utility::flag_set( "movement_ended" );
}

// Namespace test_mp_movement
// Params 9, eflags: 0x4
// Checksum 0x381aa259, Offset: 0x399a
// Size: 0x75
function private sprint_move_player( player, var_1eb21c6c806c259c, movementangles, lookangles, var_df6f1081b2420570, var_396757728673c88a, endoncondition, startlocation, var_7cf9bdbc4bd15f1d )
{
    player botpressbutton( "sprint", var_396757728673c88a );
    move_player( player, var_1eb21c6c806c259c, movementangles, lookangles, var_df6f1081b2420570, var_396757728673c88a, endoncondition, startlocation, var_7cf9bdbc4bd15f1d );
}

// Namespace test_mp_movement
// Params 9, eflags: 0x4
// Checksum 0x5322fd72, Offset: 0x3a17
// Size: 0x7c
function private function_332b775e55d6e503( player, var_1eb21c6c806c259c, movementangles, lookangles, var_df6f1081b2420570, var_396757728673c88a, endoncondition, startlocation, var_7cf9bdbc4bd15f1d )
{
    thread function_d838cae49e31651c( player );
    move_player( player, var_1eb21c6c806c259c, movementangles, lookangles, var_df6f1081b2420570, var_396757728673c88a, endoncondition, startlocation, var_7cf9bdbc4bd15f1d );
    level notify( #"hash_dd44d963ef795eae" );
}

// Namespace test_mp_movement
// Params 9, eflags: 0x4
// Checksum 0x4eed78ac, Offset: 0x3a9b
// Size: 0xa5
function private crouch_move_player( player, var_1eb21c6c806c259c, movementangles, lookangles, var_df6f1081b2420570, var_396757728673c88a, endoncondition, startlocation, var_7cf9bdbc4bd15f1d )
{
    player botsetstance( "crouch" );
    timeouttime = gettime() + 1000;
    
    while ( gettime() < timeouttime && player getstance() != "crouch" )
    {
        waitframe();
    }
    
    move_player( player, var_1eb21c6c806c259c, movementangles, lookangles, var_df6f1081b2420570, var_396757728673c88a, endoncondition, startlocation, var_7cf9bdbc4bd15f1d );
}

// Namespace test_mp_movement
// Params 9, eflags: 0x4
// Checksum 0x5be4d12, Offset: 0x3b48
// Size: 0xa5
function private prone_move_player( player, var_1eb21c6c806c259c, movementangles, lookangles, var_df6f1081b2420570, var_396757728673c88a, endoncondition, startlocation, var_7cf9bdbc4bd15f1d )
{
    player botsetstance( "prone" );
    timeouttime = gettime() + 1000;
    
    while ( gettime() < timeouttime && player getstance() != "prone" )
    {
        waitframe();
    }
    
    move_player( player, var_1eb21c6c806c259c, movementangles, lookangles, var_df6f1081b2420570, var_396757728673c88a, endoncondition, startlocation, var_7cf9bdbc4bd15f1d );
}

// Namespace test_mp_movement
// Params 9, eflags: 0x4
// Checksum 0xa9bc71bd, Offset: 0x3bf5
// Size: 0x8d
function private slide_move_player( player, var_1eb21c6c806c259c, movementangles, lookangles, var_df6f1081b2420570, var_396757728673c88a, endoncondition, startlocation, var_7cf9bdbc4bd15f1d )
{
    thread function_caf9cbc6fcfda7c1( player, "slide", "on_slide_end", &is_sliding_native, endoncondition );
    move_player( player, var_1eb21c6c806c259c, movementangles, lookangles, var_df6f1081b2420570, var_396757728673c88a, endoncondition, startlocation, var_7cf9bdbc4bd15f1d );
    level notify( #"on_slide_end" );
}

// Namespace test_mp_movement
// Params 1, eflags: 0x4
// Checksum 0xe8f40af4, Offset: 0x3c8a
// Size: 0x12
function private is_sliding_native( player )
{
    return player issprintsliding();
}

// Namespace test_mp_movement
// Params 9, eflags: 0x4
// Checksum 0x1224bad4, Offset: 0x3ca5
// Size: 0x8d
function private dive_move_player( player, var_1eb21c6c806c259c, movementangles, lookangles, var_df6f1081b2420570, var_396757728673c88a, endoncondition, startlocation, var_7cf9bdbc4bd15f1d )
{
    thread function_caf9cbc6fcfda7c1( player, "dtp", "on_dive_end", &is_diving_native, endoncondition );
    move_player( player, var_1eb21c6c806c259c, movementangles, lookangles, var_df6f1081b2420570, var_396757728673c88a, endoncondition, startlocation, var_7cf9bdbc4bd15f1d );
    level notify( #"on_dive_end" );
}

// Namespace test_mp_movement
// Params 1, eflags: 0x4
// Checksum 0x9678198a, Offset: 0x3d3a
// Size: 0x12
function private is_diving_native( player )
{
    return player isdiving();
}

// Namespace test_mp_movement
// Params 9, eflags: 0x4
// Checksum 0xb6f5e43d, Offset: 0x3d55
// Size: 0x124
function private parachute_player( player, var_1eb21c6c806c259c, movementangles, lookangles, var_df6f1081b2420570, var_396757728673c88a, endoncondition, startlocation, var_7cf9bdbc4bd15f1d )
{
    level endon( #"stop_movement" );
    
    if ( !isdefined( startlocation ) )
    {
        startlocation = get_parachute_position();
    }
    
    player setorigin( startlocation );
    player setplayerangles( lookangles );
    
    while ( !player isparachuting() )
    {
        player autotests_utility_bot::function_aaa2288bee31d766( "jump", undefined, 0.1, undefined, 1 );
    }
    
    level notify( #"start_recording" );
    thread function_b30ac8a8b4ef1af2( player, var_1eb21c6c806c259c, endoncondition, movementangles );
    wait var_396757728673c88a;
    autotests_utility::flag_set( "stop_recording" );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Movement condition met?", level.autotests.test_runtime.var_1c5b370aff94a3ca, "scripts/autotests/mp/test_mp_movement.gsc", 858 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace test_mp_movement
// Params 9, eflags: 0x4
// Checksum 0xf984c56, Offset: 0x3e81
// Size: 0xcc
function private parachute_move_player( player, var_1eb21c6c806c259c, movementangles, lookangles, var_df6f1081b2420570, var_396757728673c88a, endoncondition, startlocation = get_parachute_position(), var_7cf9bdbc4bd15f1d )
{
    player setorigin( startlocation );
    
    if ( !player isparachuting() )
    {
        player autotests_utility_bot::function_aaa2288bee31d766( "jump", undefined, 0.1, undefined, 1 );
    }
    
    while ( !player isparachuting() )
    {
        player autotests_utility_bot::function_aaa2288bee31d766( "jump", undefined, 0.1, undefined, 1 );
    }
    
    move_player( player, var_1eb21c6c806c259c, movementangles, lookangles, var_df6f1081b2420570, var_396757728673c88a, endoncondition, player.origin, var_7cf9bdbc4bd15f1d );
}

// Namespace test_mp_movement
// Params 9, eflags: 0x4
// Checksum 0x5a21eb11, Offset: 0x3f55
// Size: 0x14c
function private function_bff47da03bfda668( player, var_1eb21c6c806c259c, movementangles, lookangles, var_df6f1081b2420570, var_396757728673c88a, endoncondition, startlocation = get_parachute_position(), var_7cf9bdbc4bd15f1d )
{
    player setorigin( startlocation );
    player setplayerangles( lookangles );
    
    while ( !player isparachuting() )
    {
        player autotests_utility_bot::function_aaa2288bee31d766( "jump", undefined, 0.1, undefined, 1 );
    }
    
    wait 1;
    
    while ( player isparachuting() )
    {
        player autotests_utility_bot::function_aaa2288bee31d766( "cut_chute", undefined, 0.1, undefined, 1 );
    }
    
    level notify( #"start_recording" );
    
    if ( var_1eb21c6c806c259c )
    {
        thread function_b30ac8a8b4ef1af2( player, var_1eb21c6c806c259c, endoncondition, movementangles, var_7cf9bdbc4bd15f1d );
    }
    
    wait var_396757728673c88a;
    autotests_utility::flag_set( "stop_recording" );
    
    if ( var_1eb21c6c806c259c )
    {
        var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Movement condition met?", level.autotests.test_runtime.var_1c5b370aff94a3ca, "scripts/autotests/mp/test_mp_movement.gsc", 911 );
        
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

// Namespace test_mp_movement
// Params 5, eflags: 0xc
// Checksum 0xf4b44fc8, Offset: 0x40a9
// Size: 0x165
function private function_caf9cbc6fcfda7c1( player, var_e67114ae18d82fe1, endonstring, var_d4613e20ab6718ff, var_5b86f22c1ffdd268 )
{
    self notify( #"hash_4f0f62e400ba7214" );
    self endon( #"hash_4f0f62e400ba7214" );
    level endon( endonstring );
    level waittill( #"movement_started" );
    player botpressbutton( "sprint", 1 );
    previousvelocity = undefined;
    var_c24027396ffa525a = 0;
    
    while ( true )
    {
        velocity = length( player getvelocity() );
        
        if ( velocity > 0 && previousvelocity == velocity )
        {
            var_c24027396ffa525a++;
            
            if ( var_c24027396ffa525a >= 3 )
            {
                println( "<dev string:x58>" + var_e67114ae18d82fe1 );
                break;
            }
        }
        else
        {
            var_c24027396ffa525a = 0;
        }
        
        previousvelocity = velocity;
        waitframe();
    }
    
    player botpressbutton( var_e67114ae18d82fe1, 0.1 );
    startedaction = 0;
    
    while ( true )
    {
        if ( !startedaction && [[ var_d4613e20ab6718ff ]]( player ) )
        {
            level notify( #"special_action_started" );
            level notify( #"start_recording" );
            startedaction = 1;
            continue;
        }
        
        if ( startedaction && ![[ var_d4613e20ab6718ff ]]( player ) )
        {
            level notify( #"special_action_done" );
            autotests_utility::flag_set( "stop_recording" );
            break;
        }
        
        waitframe();
    }
    
    if ( var_5b86f22c1ffdd268 )
    {
        level notify( #"stop_movement" );
    }
}

// Namespace test_mp_movement
// Params 5, eflags: 0xc
// Checksum 0x30abe408, Offset: 0x4216
// Size: 0x102
function private function_b30ac8a8b4ef1af2( player, function, movementangles, endoncondition, var_7cf9bdbc4bd15f1d = 1 )
{
    self notify( #"hash_f4b01ce21ee90df6" );
    self endon( #"hash_f4b01ce21ee90df6" );
    level endon( #"movement_ended" );
    level endon( #"end_test" );
    level endon( #"test_finished" );
    level.autotests.test_runtime.var_1c5b370aff94a3ca = !var_7cf9bdbc4bd15f1d;
    
    while ( true )
    {
        result = [[ function ]]( player, movementangles );
        
        if ( result )
        {
            level.autotests.test_runtime.var_1c5b370aff94a3ca = var_7cf9bdbc4bd15f1d;
            
            if ( endoncondition )
            {
                level notify( #"stop_movement" );
                autotests_utility::flag_set( "stop_recording" );
                autotests_utility::flag_set( "movement_ended" );
            }
            
            break;
        }
        
        waitframe();
    }
}

// Namespace test_mp_movement
// Params 1, eflags: 0x4
// Checksum 0xfcd06914, Offset: 0x4320
// Size: 0xa3
function private function_d838cae49e31651c( player )
{
    level endon( #"hash_dd44d963ef795eae" );
    level waittill( #"movement_started" );
    player botpressbutton( "sprint", 1 );
    var_63a718d91714219d = autotests::test_wait_any( "Sprint began?", player, [ "sprint_begin" ], 1, "scripts/autotests/mp/test_mp_movement.gsc", 1020 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    player botclearbutton( "sprint" );
    waitframe();
    player botpressbutton( "sprint", 1 );
}

// Namespace test_mp_movement
// Params 2, eflags: 0x4
// Checksum 0x98eb0561, Offset: 0x43cb
// Size: 0x6d, Type: bool
function private function_b8d39983f98c8194( player, movementangles )
{
    velocity = vectornormalize( player getvelocity() );
    
    if ( velocity == ( 0, 0, 0 ) )
    {
        return false;
    }
    
    var_59a5756abc30e310 = vectornormalize( anglestoforward( movementangles ) );
    dot = vectordot( velocity, var_59a5756abc30e310 );
    return dot > 0.98;
}

// Namespace test_mp_movement
// Params 2, eflags: 0x4
// Checksum 0xd5a61c80, Offset: 0x4441
// Size: 0x4f, Type: bool
function private is_walking( player, movementangles )
{
    return player getstance() == "stand" && !player issupersprinting() && !player issprinting() && !player issprintsliding() && function_b8d39983f98c8194( player, movementangles );
}

// Namespace test_mp_movement
// Params 2, eflags: 0x4
// Checksum 0x68d6337c, Offset: 0x4499
// Size: 0x28, Type: bool
function private is_tac_sprinting( player, movementangles )
{
    return player issupersprinting() && function_b8d39983f98c8194( player, movementangles );
}

// Namespace test_mp_movement
// Params 2, eflags: 0x4
// Checksum 0x9395d616, Offset: 0x44ca
// Size: 0x33, Type: bool
function private is_sprinting( player, movementangles )
{
    return player issprinting() && !player issupersprinting() && function_b8d39983f98c8194( player, movementangles );
}

// Namespace test_mp_movement
// Params 2, eflags: 0x4
// Checksum 0x7dc8ee95, Offset: 0x4506
// Size: 0x28, Type: bool
function private function_f6c68b423a455057( player, movementangles )
{
    return player issprintsliding() && function_b8d39983f98c8194( player, movementangles );
}

// Namespace test_mp_movement
// Params 2, eflags: 0x4
// Checksum 0x5a9eb6dc, Offset: 0x4537
// Size: 0x2e, Type: bool
function private is_crouched( player, movementangles )
{
    return player getstance() == "crouch" && function_b8d39983f98c8194( player, movementangles );
}

// Namespace test_mp_movement
// Params 2, eflags: 0x4
// Checksum 0xb69e4365, Offset: 0x456e
// Size: 0x2e, Type: bool
function private is_prone( player, movementangles )
{
    return player getstance() == "prone" && function_b8d39983f98c8194( player, movementangles );
}

// Namespace test_mp_movement
// Params 2, eflags: 0x4
// Checksum 0x1f7628f, Offset: 0x45a5
// Size: 0x28, Type: bool
function private is_diving( player, movementangles )
{
    return player isdiving() && function_b8d39983f98c8194( player, movementangles );
}

// Namespace test_mp_movement
// Params 2, eflags: 0x4
// Checksum 0x7eab033a, Offset: 0x45d6
// Size: 0x1b
function private is_parachuting( player, movementangles )
{
    return player isparachuting();
}

// Namespace test_mp_movement
// Params 2, eflags: 0x4
// Checksum 0x41991d95, Offset: 0x45fa
// Size: 0x1b
function private is_free_falling( player, movementangles )
{
    return player isinfreefall();
}

// Namespace test_mp_movement
// Params 2, eflags: 0x4
// Checksum 0x8d15cfb9, Offset: 0x461e
// Size: 0x1b
function private is_grounded( player, movementangles )
{
    return player isonground();
}

// Namespace test_mp_movement
// Params 2, eflags: 0x4
// Checksum 0xe6510b22, Offset: 0x4642
// Size: 0x1b
function private is_mantling( player, movementangles )
{
    return player ismantling();
}

// Namespace test_mp_movement
// Params 2, eflags: 0x4
// Checksum 0x997d6f43, Offset: 0x4666
// Size: 0x25, Type: bool
function private function_1eb6c76ab64eb542( player, movementangles )
{
    return player ismantling() && player ishanging();
}

// Namespace test_mp_movement
// Params 2, eflags: 0x4
// Checksum 0x73684605, Offset: 0x4694
// Size: 0x26, Type: bool
function private function_1926dc1f7ff6bdc( player, movementangles )
{
    return player ismantling() && !player ishanging();
}

// Namespace test_mp_movement
// Params 2, eflags: 0x4
// Checksum 0x5ec37bb9, Offset: 0x46c3
// Size: 0x25, Type: bool
function private function_2dd85eaaf1e712de( player, movementangles )
{
    return player ismantling() || player ishanging();
}

// Namespace test_mp_movement
// Params 2, eflags: 0x4
// Checksum 0x33a87e64, Offset: 0x46f1
// Size: 0x25, Type: bool
function private is_corner_slicing( player, movementangles )
{
    return abs( player function_6549f6483c9b151f() ) > 0;
}

// Namespace test_mp_movement
// Params 1, eflags: 0xc
// Checksum 0x3c1be643, Offset: 0x471f
// Size: 0x45
function private recharge_tac_sprint( player )
{
    self notify( #"hash_4698ca96a0aade67" );
    self endon( #"hash_4698ca96a0aade67" );
    level endon( #"hash_f79c20ca926405c1" );
    
    while ( true )
    {
        player refreshsprinttime();
        wait 0.1;
    }
}

// Namespace test_mp_movement
// Params 1, eflags: 0x4
// Checksum 0x1c2f3cf0, Offset: 0x476c
// Size: 0xc
function private function_3e2828c9ac3a8e85( player )
{
    
}

// Namespace test_mp_movement
// Params 2, eflags: 0x4
// Checksum 0xf306cce9, Offset: 0x4780
// Size: 0x116
function private function_c4f3f5d407b87716( player, var_336fdb9a6b543694 )
{
    level notify( #"hash_f79c20ca926405c1" );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player has infinite tac sprint with melee perk?", isdefined( player.perks[ "specialty_melee_infinite_tac_sprint" ] ), "scripts/autotests/mp/test_mp_movement.gsc", 1146 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    if ( var_336fdb9a6b543694 )
    {
        function_e87d01151d788c41( player );
        player perk::giveperk( "specialty_athletics" );
    }
    
    var_396757728673c88a = player function_1c6d288085be8e40() / 1000 + 1;
    function_332b775e55d6e503( player, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, var_396757728673c88a );
    var_72d311de6e75f491 = player getsprintmeterfraction() == 0;
    
    if ( var_336fdb9a6b543694 )
    {
        player perk::removeperk( "specialty_athletics" );
        function_afc91a82506c85dd( player );
    }
    
    thread recharge_tac_sprint( player );
    return var_72d311de6e75f491 ? 1 : 0;
}

// Namespace test_mp_movement
// Params 1, eflags: 0x4
// Checksum 0xef8db568, Offset: 0x489f
// Size: 0x9a
function private function_fa7cd85990484284( player )
{
    level notify( #"hash_f79c20ca926405c1" );
    function_e87d01151d788c41( player );
    var_396757728673c88a = player function_1c6d288085be8e40() / 1000 + 1;
    function_332b775e55d6e503( player, &is_tac_sprinting, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, var_396757728673c88a );
    var_72d311de6e75f491 = player getsprintmeterfraction() == 0;
    thread recharge_tac_sprint( player );
    function_afc91a82506c85dd( player );
    return var_72d311de6e75f491 ? 0 : 1;
}

// Namespace test_mp_movement
// Params 7, eflags: 0x4
// Checksum 0x5974b96a, Offset: 0x4942
// Size: 0x238
function private function_53129c64b675501a( player, movementfunction, var_1eb21c6c806c259c, var_c673f187ce20dbe1, var_396757728673c88a, endoncondition, var_7cf9bdbc4bd15f1d )
{
    if ( var_c673f187ce20dbe1 )
    {
        player perk::giveperk( "specialty_gungho" );
    }
    
    autotests_utility::flag_clear( "reload_finished" );
    weapon = function_e87d01151d788c41( player );
    thread [[ movementfunction ]]( player, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, var_396757728673c88a, endoncondition, undefined, var_7cf9bdbc4bd15f1d );
    level waittill( #"movement_started" );
    function_b30ac8a8b4ef1af2( player, var_1eb21c6c806c259c, ( 0, 0, 0 ), endoncondition, 1 );
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player started movement?", level.autotests.test_runtime.var_1c5b370aff94a3ca, "scripts/autotests/mp/test_mp_movement.gsc", 1213 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    ammoclip = player getweaponammoclip( weapon );
    player setweaponammoclip( weapon, ammoclip - 1 );
    player forcereloading();
    var_63a718d91714219d = autotests::test_wait_any( "Reload started?", player, [ "reload_start" ], 1, "scripts/autotests/mp/test_mp_movement.gsc", 1218 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    while ( true )
    {
        if ( autotests_utility::flag( "movement_ended" ) || autotests_utility::flag( "reload_finished" ) )
        {
            break;
        }
        
        if ( ![[ var_1eb21c6c806c259c ]]( player, ( 0, 0, 0 ) ) )
        {
            stoppedmovement = 1;
            break;
        }
        
        waitframe();
    }
    
    player perk::removeperk( "specialty_gungho" );
    reloadfinished = autotests_utility::flag( "reload_finished" );
    autotests_utility::flag_wait_or_timeout( "reload_finished", 3 );
    
    if ( var_7cf9bdbc4bd15f1d )
    {
        return ( !stoppedmovement && reloadfinished ? 0 : 1 );
    }
    
    return stoppedmovement && !reloadfinished ? 0 : 1;
}

// Namespace test_mp_movement
// Params 2, eflags: 0x4
// Checksum 0xc31005b5, Offset: 0x4b82
// Size: 0x164
function private function_f874d85e847747a9( player, var_396757728673c88a )
{
    bundle = level.autotests.test_runtime.bundle;
    player equipment_mp::giveequipment( bundle.fragref, "primary" );
    cook_lethal( player, var_396757728673c88a );
    function_bd94145df6307f88( player, &move_player, &is_walking, ( 0, 0, 0 ), ( 0, 0, 0 ), "without_gungho", var_396757728673c88a );
    player perk::giveperk( "specialty_gungho" );
    cook_lethal( player, var_396757728673c88a );
    function_bd94145df6307f88( player, &move_player, &is_walking, ( 0, 0, 0 ), ( 0, 0, 0 ), "with_gungho", var_396757728673c88a );
    player perk::removeperk( "specialty_gungho" );
    var_69462aea15f2a349 = get_metric( "highest_speed_" + "without_gungho" );
    var_3ce09847ff927f37 = get_metric( "highest_speed_" + "with_gungho" );
    var_63a718d91714219d = autotests::function_e5040106e5cc1c59( "Max speed higher with gungho?", var_3ce09847ff927f37, var_69462aea15f2a349, "scripts/autotests/mp/test_mp_movement.gsc", 1269 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace test_mp_movement
// Params 2, eflags: 0xc
// Checksum 0x371f13d6, Offset: 0x4cee
// Size: 0x3b
function private cook_lethal( player, var_396757728673c88a )
{
    self notify( #"hash_6fe6f223dc8b6011" );
    self endon( #"hash_6fe6f223dc8b6011" );
    player botpressbutton( "lethal", var_396757728673c88a );
}

// Namespace test_mp_movement
// Params 3, eflags: 0x4
// Checksum 0x9c51b747, Offset: 0x4d31
// Size: 0x1db
function private function_3974e8f0122a54d0( player, var_396757728673c88a, endoncondition )
{
    autotests_utility_bot::set_bot_godmode( player, 0 );
    
    if ( !isdefined( startlocation ) )
    {
        startlocation = function_cec3cd2b8ed2a234();
    }
    
    botdata = autotests_utility_bot::create_spawn_data( startlocation + ( 1000, 1000, 0 ), ( 0, 90, 0 ) );
    enemybot = autotests_utility_bot::function_978126f411fc8a11( player, botdata );
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Enemy bot spawned?", enemybot, "scripts/autotests/mp/test_mp_movement.gsc", 1287 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    player perk::giveperk( "specialty_resolute" );
    function_bd94145df6307f88( player, &move_player, &is_walking, ( 0, 0, 0 ), ( 0, 0, 0 ), "without_resolute", var_396757728673c88a, endoncondition, undefined );
    player dodamage( 1, enemybot.origin, enemybot, enemybot );
    function_bd94145df6307f88( player, &move_player, &is_walking, ( 0, 0, 0 ), ( 0, 0, 0 ), "with_resolute", var_396757728673c88a, endoncondition, undefined );
    autotests_utility_bot::kick_all_bots();
    player perk::removeperk( "specialty_resolute" );
    autotests_utility_bot::set_bot_godmode( player, 1 );
    var_bceb66c3df9691c8 = get_metric( "highest_speed_" + "without_resolute" );
    var_e4c2b0911b5fa882 = get_metric( "highest_speed_" + "with_resolute" );
    var_63a718d91714219d = autotests::function_e5040106e5cc1c59( "Max speed higher with resolute?", var_e4c2b0911b5fa882, var_bceb66c3df9691c8, "scripts/autotests/mp/test_mp_movement.gsc", 1301 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace test_mp_movement
// Params 3, eflags: 0x4
// Checksum 0x4f43467c, Offset: 0x4f14
// Size: 0x16b
function private function_decbedbff8fb083a( player, var_396757728673c88a, endoncondition )
{
    autotests::set_dvar( @"hash_5c784f7a2a4d3851", 0 );
    gasorigin = level.dev_activities[ "gas_pocket" ].prefabstruct.origin;
    function_bd94145df6307f88( player, &move_player, &is_walking, ( 0, 0, 0 ), ( 0, 0, 0 ), "without_irradiated", var_396757728673c88a, endoncondition, gasorigin );
    player perk::giveperk( "specialty_outlander" );
    function_bd94145df6307f88( player, &move_player, &is_walking, ( 0, 0, 0 ), ( 0, 0, 0 ), "with_irradiated", var_396757728673c88a, endoncondition, gasorigin );
    player perk::removeperk( "specialty_outlander" );
    autotests::reset_dvar( @"hash_5c784f7a2a4d3851" );
    var_2c57e30b2b09cf92 = get_metric( "highest_speed_" + "without_irradiated" );
    var_33a7611d8bf6e750 = get_metric( "highest_speed_" + "with_irradiated" );
    var_63a718d91714219d = autotests::function_e5040106e5cc1c59( "Max speed higher with irradiated?", var_33a7611d8bf6e750, var_2c57e30b2b09cf92, "scripts/autotests/mp/test_mp_movement.gsc", 1324 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace test_mp_movement
// Params 3, eflags: 0x4
// Checksum 0x7863493e, Offset: 0x5087
// Size: 0x4a9
function private function_91b18b7a0966818d( player, var_396757728673c88a, endoncondition )
{
    autotests_utility_bot::set_bot_godmode( player, 0 );
    
    if ( !isdefined( startlocation ) )
    {
        startlocation = function_cec3cd2b8ed2a234();
    }
    
    botdata = autotests_utility_bot::create_spawn_data( startlocation + ( 1000, 1000, 0 ), ( 0, 90, 0 ) );
    enemybot = autotests_utility_bot::function_978126f411fc8a11( player, botdata );
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Enemy bot spawned?", enemybot, "scripts/autotests/mp/test_mp_movement.gsc", 1337 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    wait 1;
    bundle = level.autotests.test_runtime.bundle;
    equipmentinfo = weapon::getequipmenttableinfo( bundle.fragref );
    fusetime = getgrenadefusetime( equipmentinfo.objweapon ) / 1000;
    player.health = player.maxhealth;
    player setorigin( startlocation );
    enemybot setorigin( startlocation - ( 0, 800, 0 ) );
    targetangles = vectortoangles( player.origin - enemybot.origin - ( 0, 0, 100 ) );
    enemybot setplayerangles( targetangles );
    player setplayerangles( targetangles * -1 );
    enemybot equipment_mp::giveequipment( bundle.fragref, "primary" );
    enemybot equipment_mp::setequipmentammo( bundle.fragref, 2 );
    wait 0.5;
    enemybot botpressbutton( "lethal", 0.1 );
    var_63a718d91714219d = autotests::test_wait_any( "Grenade thrown?", enemybot, [ "grenade_fire" ], 1, "scripts/autotests/mp/test_mp_movement.gsc", 1357 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    totalhealth = player.health + player.armorhealth;
    wait fusetime;
    var_63a718d91714219d = autotests::function_e4e4ff06e5a9c612( "Grenade damaged player?", player.health + player.armorhealth, totalhealth, "scripts/autotests/mp/test_mp_movement.gsc", 1361 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    function_bd94145df6307f88( player, &move_player, &is_walking, ( 0, 0, 0 ), ( 0, 0, 0 ), "without_grenadier", var_396757728673c88a, endoncondition );
    player.health = player.maxhealth;
    player setorigin( startlocation );
    enemybot setorigin( startlocation - ( 0, 800, 0 ) );
    enemybot setplayerangles( targetangles );
    player setplayerangles( targetangles * -1 );
    enemybot perk::giveperk( "specialty_grenadier" );
    enemybot botpressbutton( "lethal", 0.1 );
    var_63a718d91714219d = autotests::test_wait_any( "Grenade thrown?", enemybot, [ "grenade_fire" ], 1, "scripts/autotests/mp/test_mp_movement.gsc", 1373 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    totalhealth = player.health + player.armorhealth;
    wait fusetime;
    var_63a718d91714219d = autotests::function_e4e4ff06e5a9c612( "Grenade damaged player?", player.health + player.armorhealth, totalhealth, "scripts/autotests/mp/test_mp_movement.gsc", 1377 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    function_bd94145df6307f88( player, &move_player, &is_walking, ( 0, 0, 0 ), ( 0, 0, 0 ), "with_grenadier", var_396757728673c88a, endoncondition );
    autotests_utility_bot::kick_all_bots();
    player perk::removeperk( "specialty_grenadier" );
    autotests_utility_bot::set_bot_godmode( player, 1 );
    var_2543b0d2069841c0 = get_metric( "highest_speed_" + "without_grenadier" );
    var_dc7857c5ed83968a = get_metric( "highest_speed_" + "with_grenadier" );
    var_63a718d91714219d = autotests::function_e4e4ff06e5a9c612( "Max speed lower with grenadier?", var_dc7857c5ed83968a, var_2543b0d2069841c0, "scripts/autotests/mp/test_mp_movement.gsc", 1386 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace test_mp_movement
// Params 6, eflags: 0x4
// Checksum 0xab5bb46b, Offset: 0x5538
// Size: 0x91
function private test_mantle( player, var_1eb21c6c806c259c, startlocation, endlocation, var_396757728673c88a, var_7cf9bdbc4bd15f1d )
{
    direction = endlocation - startlocation;
    yaw = vectortoyaw( direction );
    angles = ( yaw, 0, 0 );
    player thread autotests_utility_bot::function_aaa2288bee31d766( "jump", 0, undefined, 1 );
    move_player( player, var_1eb21c6c806c259c, angles, angles, undefined, var_396757728673c88a, undefined, startlocation, var_7cf9bdbc4bd15f1d );
}

// Namespace test_mp_movement
// Params 5, eflags: 0x4
// Checksum 0xb6b12985, Offset: 0x55d1
// Size: 0xe1
function private function_1bafea5f97824c14( player, autodeploy, var_1e49a42318a94e17, startlocation, var_7cf9bdbc4bd15f1d )
{
    player function_349ee393ea6dba7e( "parachute_auto_deploy_safe_jump", var_1e49a42318a94e17 );
    player function_349ee393ea6dba7e( "parachute_auto_deploy_disable", !autodeploy );
    
    if ( !isdefined( startlocation ) )
    {
        startlocation = get_parachute_position();
    }
    
    thread move_player( player, &is_parachuting, ( 0, 0, 0 ), ( 85, 0, 0 ), undefined, 20, 1, startlocation, var_7cf9bdbc4bd15f1d );
    level waittill( #"movement_started" );
    
    while ( true )
    {
        if ( autotests_utility::flag( "movement_ended" ) || player isonground() )
        {
            break;
        }
        
        waitframe();
    }
    
    return level.autotests.test_runtime.var_1c5b370aff94a3ca ? 0 : 1;
}

// Namespace test_mp_movement
// Params 4, eflags: 0x4
// Checksum 0x48915eae, Offset: 0x56bb
// Size: 0x9c
function private function_98ea8ae1d0597ac2( player, autodeploy, var_1e49a42318a94e17, var_7cf9bdbc4bd15f1d )
{
    player function_349ee393ea6dba7e( "parachute_auto_deploy_safe_jump", var_1e49a42318a94e17 );
    player function_349ee393ea6dba7e( "parachute_auto_deploy_disable", !autodeploy );
    location = get_parachute_position();
    function_bff47da03bfda668( player, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, 0.1, 0, location, 1 );
    return function_1bafea5f97824c14( player, autodeploy, var_1e49a42318a94e17, player.origin, var_7cf9bdbc4bd15f1d );
}

// Namespace test_mp_movement
// Params 2, eflags: 0x4
// Checksum 0x2ccd9959, Offset: 0x5760
// Size: 0xba
function private test_corner_slicing( player, movementangles )
{
    player playerexitautopilotmode();
    location = autotests::get_struct_location( "test_location_movement_mantle_too_big" );
    player setorigin( location );
    player setplayerangles( ( 0, 0, 0 ) );
    waitframe();
    movementdir = anglestoforward( movementangles );
    timer = gettime() + 5000;
    player setvelocity( movementdir * 500 );
    
    while ( gettime() < timer )
    {
        if ( is_corner_slicing( player, movementangles ) )
        {
            successful = 1;
            break;
        }
        
        waitframe();
    }
    
    player function_ffb0711adb6d8d0d();
    return successful ? 0 : 1;
}

// Namespace test_mp_movement
// Params 4, eflags: 0x4
// Checksum 0xaf55e894, Offset: 0x5823
// Size: 0x137
function private function_4989ecfa52884bde( player, movementangles, lookangles, var_7cf9bdbc4bd15f1d )
{
    player function_349ee393ea6dba7e( "sprint_restore", var_7cf9bdbc4bd15f1d );
    player function_349ee393ea6dba7e( "slide_to_sprint", var_7cf9bdbc4bd15f1d );
    thread slide_move_player( player, undefined, movementangles, lookangles, 0, 5, 0, undefined, var_7cf9bdbc4bd15f1d );
    var_63a718d91714219d = autotests::test_wait_any( "Slide started", level, [ "special_action_started" ], 2, "scripts/autotests/mp/test_mp_movement.gsc", 1484 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    player botclearbutton( "sprint" );
    var_63a718d91714219d = autotests::test_wait_any( "Slide ended", level, [ "special_action_done" ], 2, "scripts/autotests/mp/test_mp_movement.gsc", 1487 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    startedsprinting = 0;
    
    while ( true )
    {
        if ( autotests_utility::flag( "movement_ended" ) )
        {
            break;
        }
        
        if ( player issprinting() )
        {
            startedsprinting = 1;
            break;
        }
        
        waitframe();
    }
    
    return startedsprinting == var_7cf9bdbc4bd15f1d ? 0 : 1;
}

// Namespace test_mp_movement
// Params 2, eflags: 0x4
// Checksum 0x8fc8a5a1, Offset: 0x5963
// Size: 0x204
function private test_door_bash( player, var_7cf9bdbc4bd15f1d )
{
    player function_349ee393ea6dba7e( "auto_door_bash", var_7cf9bdbc4bd15f1d );
    playerspawn = level.dev_activities[ "door" ].prefabstruct.origin;
    player setorigin( playerspawn );
    door = getentitylessscriptablearray( undefined, undefined, playerspawn, 100, "door" )[ 0 ];
    state = door getscriptablepartstate( "door" );
    
    if ( state != "closed" )
    {
        door function_e3fcde595da2ca5f( player );
    }
    
    starttime = gettime();
    
    while ( !( door.angles == ( 0, 0, 0 ) ) )
    {
        waitframe();
        
        if ( gettime() - starttime > 2000 )
        {
            var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Door is shut?", 0, "scripts/autotests/mp/test_mp_movement.gsc", 1524 );
            
            if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
            {
                if ( autotests::function_561cb32cd7469145() )
                {
                    return;
                }
                
                autotests::test_assert_return( var_63a718d91714219d );
            }
            
            return;
        }
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Door is shut?", 1, "scripts/autotests/mp/test_mp_movement.gsc", 1524 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    doorforward = anglestoforward( door.angles );
    useposition = door function_4951de6fef532028( "door" ) + doorforward * -20;
    movementdir = useposition - playerspawn;
    angles = ( 0, vectortoyaw( movementdir ), 0 );
    thread sprint_move_player( player, &is_sprinting, angles, angles, 0, 2, 0, playerspawn, 1 );
    thread monitor_is_stuck( player );
    isstuck = level utility::waittill_any_in_array_or_timeout( [ "is_stuck" ], 2 ) != "timeout";
    level notify( #"hash_e3f58be7b533a87b" );
    return isstuck != var_7cf9bdbc4bd15f1d ? 0 : 1;
}

// Namespace test_mp_movement
// Params 1, eflags: 0x4
// Checksum 0x3a828497, Offset: 0x5b70
// Size: 0x96
function private monitor_is_stuck( player )
{
    level endon( #"hash_e3f58be7b533a87b" );
    level endon( #"end_test" );
    level endon( #"test_finished" );
    level waittill( #"movement_started" );
    stuckframes = 0;
    
    while ( true )
    {
        velocity = player getvelocity();
        
        if ( velocity == ( 0, 0, 0 ) )
        {
            stuckframes++;
            
            if ( stuckframes >= 30 )
            {
                level notify( #"is_stuck" );
                break;
            }
        }
        else
        {
            stuckframes = 0;
        }
        
        waitframe();
    }
}

// Namespace test_mp_movement
// Params 2, eflags: 0x4
// Checksum 0xdb91edfb, Offset: 0x5c0e
// Size: 0x44, Type: bool
function private function_9ab9761f98e7b330( player, suitbundle )
{
    return !level.disablesupersprint && ( suitbundle.var_7bdfe43bd1a2d90c || isdefined( player.perks[ "specialty_supersprint" ] ) );
}

