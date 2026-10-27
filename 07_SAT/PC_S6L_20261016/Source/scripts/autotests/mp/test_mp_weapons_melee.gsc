// scripts\autotests\mp\test_mp_weapons_melee.gsc  (hash_4ea328e0ab28fe78.gscc) (size: 4002 Bytes / 0xfa2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd8a0a00b (3634405387)
// size ...... 4002 (0xfa2)
// includes .. 5   (offset: 0xe66)
// strings ... 17  (offset: 0xe8e)
// dev strs .. 0   (offset: 0xfa2)
// exports ... 9   (offset: 0x87a)
// cseg ...... 0x1c8 + 0x6b2 (0x87a)
// imports ... 36  (offset: 0x9e2)
// animtree1 . 0   (offset: 0xfa2)
// animtree2 . 0   (offset: 0xfa2)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_player;
#using scripts\common\utility;
#using scripts\common\weapon;

#namespace test_mp_weapons_melee;

// Namespace test_mp_weapons_melee/testautomation
// Params 0, eflags: 0x20
// Checksum 0x7be31f7, Offset: 0x1e6
// Size: 0x26
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_weapons_melee.gsc", #"GP", &start_test, &setup, &cleanup );
}

// Namespace test_mp_weapons_melee
// Params 0, eflags: 0x4
// Checksum 0x2582b284, Offset: 0x214
// Size: 0xb, Type: bool
function private setup()
{
    autotests::function_5c8c87763724c132();
    return true;
}

// Namespace test_mp_weapons_melee
// Params 0, eflags: 0x4
// Checksum 0x5ba66c14, Offset: 0x228
// Size: 0x1be
function private start_test()
{
    player = autotests_utility_player::get_player();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player has spawned.", isdefined( player ), "scripts/autotests/mp/test_mp_weapons_melee.gsc", 27 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    botdata = autotests_utility_bot::get_spawn_data( player, 30 );
    bot = autotests_utility_bot::function_e4afe0f2cd6331a6( undefined, botdata );
    wait 1;
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Could spawn bot1?", isdefined( bot ), "scripts/autotests/mp/test_mp_weapons_melee.gsc", 32 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    level.var_a5ecc4fd7d64db7b = 1;
    player.maxhealth = 6000;
    player.health = 6000;
    autotests::push_function( "getMeleeWeapons" );
    test_result_int = getMeleeWeapons() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "getMeleeWeapons", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_weapons_melee.gsc", 40 );
    autotests::pop_function( "getMeleeWeapons" );
    autotests::test_assert_return( test_result_int );
    wait 1;
    autotests::push_function( "bot_gun_butt_player" );
    test_result_int = bot_gun_butt_player( bot, player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "bot_gun_butt_player", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_weapons_melee.gsc", 42 );
    autotests::pop_function( "bot_gun_butt_player" );
    autotests::test_assert_return( test_result_int );
    wait 2;
    autotests::push_function( "bot_equip_and_use_melee_weapons" );
    test_result_int = bot_equip_and_use_melee_weapons( bot, player ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "bot_equip_and_use_melee_weapons", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_weapons_melee.gsc", 44 );
    autotests::pop_function( "bot_equip_and_use_melee_weapons" );
    autotests::test_assert_return( test_result_int );
}

// Namespace test_mp_weapons_melee
// Params 0, eflags: 0x4
// Checksum 0x7c9a406f, Offset: 0x3ee
// Size: 0x9
function private cleanup()
{
    autotests_utility_bot::kick_all_bots();
}

// Namespace test_mp_weapons_melee
// Params 2, eflags: 0x4
// Checksum 0xd11a66db, Offset: 0x3ff
// Size: 0x1f
function private bot_gun_butt_player( bot, player )
{
    bot_melee_player( bot, player );
}

// Namespace test_mp_weapons_melee
// Params 2, eflags: 0x4
// Checksum 0x63357a89, Offset: 0x426
// Size: 0x23f
function private bot_equip_and_use_melee_weapons( bot, player )
{
    weaponlist = level.autotests.test_runtime.weaponlist;
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Are there melee weapons to test? " + weaponlist.size, weaponlist.size > 0, "scripts/autotests/mp/test_mp_weapons_melee.gsc", 60 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    foreach ( weapon in weaponlist )
    {
        newweapon = weapon::getweaponrootname( weapon );
        newweaponobj = weapon::buildweapon( newweapon );
        
        if ( newweaponobj == level.weaponnone )
        {
            continue;
        }
        
        currweapon = bot getcurrentweapon();
        bot utility::callsharedfunc( #"utilities", #"dropitem", currweapon );
        waitframe();
        bot giveweapon( newweaponobj );
        bot switchtoweaponimmediate( newweaponobj );
        autotests::set_current_asset_name( newweaponobj.basename );
        var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Can equip weapon?", 1, "scripts/autotests/mp/test_mp_weapons_melee.gsc", 79 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        wait 3;
        activeweapon = [];
        activeweapon[ activeweapon.size ] = bot getcurrentweapon();
        autotests::push_function( "bot_melee_player" );
        test_result_int = bot_melee_player( bot, player ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "bot_melee_player", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_weapons_melee.gsc", 86 );
        autotests::pop_function( "bot_melee_player" );
        autotests::test_assert_return( test_result_int );
        droppedweapons = getweaponarrayinradius( bot.origin, 150 );
        utility::array_delete( droppedweapons );
        waitframe();
        autotests::set_current_asset_name( "" );
    }
}

// Namespace test_mp_weapons_melee
// Params 2, eflags: 0x4
// Checksum 0x2d85fa07, Offset: 0x66d
// Size: 0xe4
function private bot_melee_player( bot, player )
{
    var_24c1af1c78490d23 = player getplayerangles();
    targetangles = vectortoangles( player.origin - bot.origin + ( 0, 0, 5 ) );
    bot setplayerangles( targetangles );
    previoushealth = player.health;
    bot autotests_utility_bot::function_aaa2288bee31d766( "melee", 1, 0.5 );
    endhealth = player.health;
    damagedone = previoushealth - endhealth;
    autotests::function_e4e4ff06e5a9c612( "Melee Damage Done? " + damagedone, endhealth, previoushealth, "scripts/autotests/mp/test_mp_weapons_melee.gsc", 108 );
    player.health = previoushealth;
    wait 0.5;
    player setplayerangles( var_24c1af1c78490d23 );
}

// Namespace test_mp_weapons_melee
// Params 0, eflags: 0x4
// Checksum 0x8714a7a2, Offset: 0x759
// Size: 0x121
function private getMeleeWeapons()
{
    weaponlist = [];
    
    foreach ( key, _ in level.weaponmapdata )
    {
        if ( issubstr( key, "_zombie_" ) || issubstr( key, "climbfists" ) || issubstr( key, "bloodstone" ) )
        {
            continue;
        }
        
        if ( issubstr( key, "_me_" ) )
        {
            weaponlist[ weaponlist.size ] = key;
        }
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "There are melee weapons to use.", weaponlist.size > 0, "scripts/autotests/mp/test_mp_weapons_melee.gsc", 134 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    level.autotests.test_runtime.weaponlist = weaponlist;
}

