// scripts\autotests\test_weapons.gsc  (hash_6d17aeeef99e8cb5.gscc) (size: 3423 Bytes / 0xd5f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x21cc57df (567039967)
// size ...... 3423 (0xd5f)
// includes .. 2   (offset: 0xca7)
// strings ... 10  (offset: 0xcb7)
// dev strs .. 0   (offset: 0xd5f)
// exports ... 10  (offset: 0x70b)
// cseg ...... 0x158 + 0x5b3 (0x70b)
// imports ... 33  (offset: 0x89b)
// animtree1 . 0   (offset: 0xd5f)
// animtree2 . 0   (offset: 0xd5f)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility_player;

#namespace test_weapons;

// Namespace test_weapons/testautomation
// Params 0, eflags: 0x20
// Checksum 0x7de20e09, Offset: 0x176
// Size: 0x21
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/test_weapons.gsc", #"GP", &start_test, &setup );
}

// Namespace test_weapons
// Params 0
// Checksum 0xc07f3113, Offset: 0x19f
// Size: 0xb, Type: bool
function setup()
{
    autotests::function_5c8c87763724c132();
    return true;
}

// Namespace test_weapons
// Params 0
// Checksum 0x7e781563, Offset: 0x1b3
// Size: 0x11c
function start_test()
{
    bundle = autotests::get_test_bundle( self.test.xhash_ref );
    player = autotests_utility_player::get_player();
    weapons = player function_f251961fba0e40e9();
    
    if ( weapons.size == 0 )
    {
        return 1;
    }
    
    iters = bundle.var_5b7d6173c464c345 ?? 3;
    
    if ( iters > 0 )
    {
        autotests::push_function( "Can shoot primary weapon?" );
        test_result_int = player function_1d0a72d10667e43a( iters, weapons ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Can shoot primary weapon?", test_result_int, undefined, undefined, "scripts/autotests/test_weapons.gsc", 36 );
        autotests::pop_function( "Can shoot primary weapon?" );
        autotests::test_assert_return( test_result_int );
    }
    
    if ( bundle.var_670e51decb9522ef )
    {
        autotests::push_function( "Check ammo consumption" );
        test_result_int = player function_670e51decb9522ef( weapons ) ?? 0;
        test_result_int = autotests::function_e496a326e5d58a25( "Check ammo consumption", test_result_int, undefined, undefined, "scripts/autotests/test_weapons.gsc", 41 );
        autotests::pop_function( "Check ammo consumption" );
        autotests::test_assert_return( test_result_int );
    }
}

// Namespace test_weapons
// Params 0, eflags: 0x4
// Checksum 0x21c90c5c, Offset: 0x2d7
// Size: 0xf3
function private function_f251961fba0e40e9()
{
    weapons = [];
    
    foreach ( weapon in self.primaryweapons )
    {
        if ( weapon.damagemodcategory != #"melee" && weapon.classname != "fist" )
        {
            weapons[ weapons.size ] = weapon;
        }
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "There are weapons to shoot.", weapons.size != 0, "scripts/autotests/test_weapons.gsc", 58 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    return weapons;
}

// Namespace test_weapons
// Params 2, eflags: 0x4
// Checksum 0xa1998d0c, Offset: 0x3d3
// Size: 0x120
function private function_1d0a72d10667e43a( iters, weapons )
{
    setdvar( @"player_sustainammo", 1 );
    
    foreach ( weapon in weapons )
    {
        autotests::set_current_asset_name( weapon.basename );
        function_b2686df40a08f5bc( weapon );
        
        for ( i = 0; i < iters ; i++ )
        {
            shootPrimaryWeapon();
        }
        
        var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Could shoot weapon?", 1, "scripts/autotests/test_weapons.gsc", 75 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    
    autotests::set_current_asset_name( "" );
    setdvar( @"player_sustainammo", 0 );
}

// Namespace test_weapons
// Params 1, eflags: 0x4
// Checksum 0xa552896b, Offset: 0x4fb
// Size: 0x18a
function private function_670e51decb9522ef( weapons )
{
    foreach ( weapon in weapons )
    {
        autotests::set_current_asset_name( weapon.basename );
        originalammo = self getweaponammoclip( weapon );
        var_9fb70ab0f549a7b3 = self getweaponammostock( weapon );
        function_b2686df40a08f5bc( weapon );
        shootPrimaryWeapon( 1 );
        var_63a718d91714219d = autotests::function_e4e4ff06e5a9c612( "Shooting used clip ammo?", self getweaponammoclip( weapon ), originalammo, "scripts/autotests/test_weapons.gsc", 93 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        reloadPrimaryWeapon();
        var_63a718d91714219d = autotests::function_e5041006e5cc3d56( "Reloading increased clip ammo?", self getweaponammoclip( weapon ), originalammo, "scripts/autotests/test_weapons.gsc", 97 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
        
        var_63a718d91714219d = autotests::function_e4e4ff06e5a9c612( "Reloading decreased stock ammo?", self getweaponammostock( weapon ), var_9fb70ab0f549a7b3, "scripts/autotests/test_weapons.gsc", 98 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    
    autotests::set_current_asset_name( "" );
}

// Namespace test_weapons
// Params 1, eflags: 0x4
// Checksum 0x93859b2, Offset: 0x68d
// Size: 0x27
function private shootPrimaryWeapon( duration = 2 )
{
    self startforcedfire();
    wait duration;
    self stopforcedfire();
    wait 1;
}

// Namespace test_weapons
// Params 1, eflags: 0x4
// Checksum 0x4b271729, Offset: 0x6bc
// Size: 0x2d
function private function_b2686df40a08f5bc( weapon )
{
    if ( isdefined( weapon ) && self.currentweapon != weapon )
    {
        self switchtoweapon( weapon );
        wait 1;
    }
}

// Namespace test_weapons
// Params 0, eflags: 0x4
// Checksum 0x474b4435, Offset: 0x6f1
// Size: 0x1a
function private reloadPrimaryWeapon()
{
    self forcereloading();
    wait 0.5;
    
    while ( self isreloading() )
    {
        waitframe();
    }
}

