// scripts\autotests\mp\test_mp_cod_weapons_sweep.gsc  (hash_04260ef27313c5f9.gscc) (size: 12758 Bytes / 0x31d6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x177ef381 (394195841)
// size ...... 12758 (0x31d6)
// includes .. 9   (offset: 0x2e6a)
// strings ... 53  (offset: 0x2eb2)
// dev strs .. 0   (offset: 0x31d6)
// exports ... 34  (offset: 0x18f2)
// cseg ...... 0x48a + 0x1468 (0x18f2)
// imports ... 118 (offset: 0x1e42)
// animtree1 . 0   (offset: 0x31d6)
// animtree2 . 0   (offset: 0x31d6)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_player;
#using scripts\autotests\mp\autotests_utility_assets;
#using scripts\autotests\mp\autotests_utility_video;
#using scripts\autotests\mp\autotests_utility_weapons;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\utility\game_utility;

#namespace test_mp_cod_weapons_sweep;

// Namespace test_mp_cod_weapons_sweep/testautomation
// Params 0, eflags: 0x20
// Checksum 0x83790ecd, Offset: 0x4a8
// Size: 0x2d
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_cod_weapons_sweep.gsc", #"GP", &start_test, &setup, &cleanup, &parameterize, undefined, 0 );
}

// Namespace test_mp_cod_weapons_sweep
// Params 1, eflags: 0x4
// Checksum 0x3b385bf4, Offset: 0x4dd
// Size: 0x1b
function private parameterize( test_setup )
{
    return autotests_utility_weapons::function_dc598beaf588c3d0( test_setup, &autotests_utility_weapons::function_5b69f10049eb1449, 1 );
}

// Namespace test_mp_cod_weapons_sweep
// Params 0, eflags: 0x4
// Checksum 0x74d6c266, Offset: 0x501
// Size: 0x1cc, Type: bool
function private setup()
{
    if ( self.datasets.size > 0 )
    {
        dataset = self.datasets[ 0 ];
        random_operators = dataset == "grab_operators";
        level.autotests.test_runtime.random_operators = random_operators;
        random_attachments = dataset == "grab_attachments";
        level.autotests.test_runtime.random_attachments = random_attachments;
    }
    
    autotests::function_5c8c87763724c132();
    autotests_utility_video::function_5826175e5df28fd8();
    autotests::set_dvar( @"hash_aa5c2e28a06af46", 0 );
    player = autotests_utility_player::get_player();
    testbundle = autotests::get_test_bundle( self.test.xhash_ref );
    autotests_utility_player::function_30be7535f53dd7a1( testbundle, player );
    autotests::set_dvar( @"r_mbenable", "off" );
    autotests::set_dvar( @"hash_db628cbef70002ae", 0 );
    autotests::set_dvar( @"hash_1c7ec136165116b7", 0 );
    autotests::set_dvar( @"cg_draw2d", 0 );
    autotests::set_dvar( @"hash_d69e5ce714e4ecd8", 1 );
    autotests::set_dvar( @"hash_1471cf85cde4d3e2", 1 );
    autotests::set_dvar( @"hash_d8f0a05f42bcd86b", 1 );
    level.autotests.test_runtime.playerangles = player getplayerangles();
    level.autotests.test_runtime.playerorigin = player getorigin();
    player function_ffb0711adb6d8d0d();
    player autotests_utility_video::function_fa5160f0e09f8bf9( testbundle );
    autotests_utility_bot::set_bot_godmode( player, 1 );
    return true;
}

// Namespace test_mp_cod_weapons_sweep
// Params 0, eflags: 0x4
// Checksum 0x89ecb188, Offset: 0x6d6
// Size: 0x67
function private cleanup()
{
    autotests::set_dvar( @"hash_d69e5ce714e4ecd8", 0 );
    autotests::set_dvar( @"hash_1471cf85cde4d3e2", -1 );
    autotests::set_dvar( @"hash_d8f0a05f42bcd86b", 0 );
    autotests_utility_video::function_2bddeed61c9c1561();
    autotests_utility_bot::kick_all_bots();
    player = autotests_utility_player::get_player();
    autotests_utility_bot::set_bot_godmode( player, 0 );
    player playerexitautopilotmode();
}

// Namespace test_mp_cod_weapons_sweep
// Params 0
// Checksum 0x8462cf35, Offset: 0x745
// Size: 0x1e6
function start_test()
{
    setdvar( @"hash_aa5c2e28a06af46", 1 );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Has 1 parameter?", self.parameters.size, 1, "scripts/autotests/mp/test_mp_cod_weapons_sweep.gsc", 89 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    player = autotests_utility_player::get_player();
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Player is autopiloted?", isautopilot( player ), "scripts/autotests/mp/test_mp_cod_weapons_sweep.gsc", 92 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_23986f5ff3f49f24 = self.parameters[ 0 ];
    weaponinfo = autotests_utility_weapons::get_weapon_info( var_23986f5ff3f49f24 );
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Weapon info is defined?", weaponinfo, "scripts/autotests/mp/test_mp_cod_weapons_sweep.gsc", 96 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    setdvar( @"hash_aa5c2e28a06af46", 0 );
    
    if ( level.autotests.test_runtime.random_operators )
    {
        randomskin = getxhashasset( utility::array_random( autotests_utility_assets::function_afcf75b6412f73b9() ) );
        autotests_utility_video::function_bdc5139799504032( player, randomskin );
    }
    
    attachments = undefined;
    
    if ( level.autotests.test_runtime.random_attachments )
    {
        attachments = autotests_utility_assets::getrandomattachments( weaponinfo.assetname, 2 );
    }
    
    player setplayerangles( level.autotests.test_runtime.playerangles );
    player setorigin( level.autotests.test_runtime.playerorigin );
    weaponsweep( player, weaponinfo, attachments );
}

// Namespace test_mp_cod_weapons_sweep
// Params 3, eflags: 0x4
// Checksum 0xc2a6285, Offset: 0x933
// Size: 0x8a
function private weaponsweep( player, weaponinfo, attachments )
{
    baseweapon = createweapon( weaponinfo.assetname, attachments, weaponinfo.variantid );
    assetname = autotests_utility_weapons::get_assetname( weaponinfo );
    
    if ( attachments.size > 0 )
    {
        assetname = getcompleteweaponname( baseweapon );
    }
    
    autotests::set_current_asset_name( assetname );
    waitframe();
    player function_f5d7bda0fafef1c9( baseweapon );
    autotests::set_current_asset_name( "" );
}

// Namespace test_mp_cod_weapons_sweep
// Params 3, eflags: 0x4
// Checksum 0x85c49f3d, Offset: 0x9c5
// Size: 0x4c
function private createweapon( weaponname, attachments, variantid )
{
    rootname = weapon::getweaponrootname( weaponname );
    return weapon::buildweapon( rootname, attachments, undefined, undefined, variantid, undefined, undefined, undefined, istrue( level.nightmap ) );
}

// Namespace test_mp_cod_weapons_sweep
// Params 1, eflags: 0x4
// Checksum 0x2dfddd9c, Offset: 0xa1a
// Size: 0xf
function private test_wait( duration )
{
    wait duration;
}

// Namespace test_mp_cod_weapons_sweep
// Params 1, eflags: 0x4
// Checksum 0x743e54fd, Offset: 0xa31
// Size: 0x399
function private function_f5d7bda0fafef1c9( weapon )
{
    previousweapon = self getcurrentweapon();
    var_41965f6cdd4230ba = self function_a4f068798d87b7ea( 0 );
    var_906ce4e7b26a1606 = self function_a4f068798d87b7ea( 1 );
    
    if ( previousweapon != var_906ce4e7b26a1606 )
    {
        self takeweapon( previousweapon );
    }
    
    self botsetflag( "ignore_script_weapon", 0 );
    self giveweapon( weapon );
    self switchtoweaponimmediate( weapon );
    test_wait( 5 );
    currentweapon = self getcurrentweapon();
    
    if ( self function_fc08227330530fcb( currentweapon ) )
    {
        autotests::function_5b8cb4c1e1344b52( autotests::get_current_asset_name(), "WeaponInspection" );
        function_bfdf0f060cc65514();
        autotests::function_d2beb5130405ff37( autotests::get_current_asset_name(), "WeaponInspection" );
    }
    
    if ( currentweapon.ismelee )
    {
        autotests::function_5b8cb4c1e1344b52( autotests::get_current_asset_name(), "Melee" );
        function_241a42464a3864de();
        autotests::function_d2beb5130405ff37( autotests::get_current_asset_name(), "Melee" );
        return;
    }
    
    if ( self function_5e6e55e17153d2d8( currentweapon ) )
    {
        function_ca55025078a31055( currentweapon );
    }
    
    autotests::function_5b8cb4c1e1344b52( autotests::get_current_asset_name(), "ADS" );
    testads( 3 );
    autotests::function_d2beb5130405ff37( autotests::get_current_asset_name(), "ADS" );
    reloaddisabled = function_16c7713d4a27e803( currentweapon );
    
    if ( !reloaddisabled )
    {
        autotests::function_5b8cb4c1e1344b52( autotests::get_current_asset_name(), "EmptyReload" );
        EmptyReload( currentweapon );
        autotests::function_d2beb5130405ff37( autotests::get_current_asset_name(), "EmptyReload" );
    }
    
    if ( currentweapon.maxammo > 0 )
    {
        autotests::function_5b8cb4c1e1344b52( autotests::get_current_asset_name(), "WeaponFiring" );
        function_2cb35ea905382b9d( 2 );
        autotests::function_d2beb5130405ff37( autotests::get_current_asset_name(), "WeaponFiring" );
    }
    
    extendedtest = 0;
    
    if ( extendedtest )
    {
        if ( !reloaddisabled )
        {
            var_76a3b56d99c1ddee = weaponclipsize( currentweapon ) == 1;
            
            if ( !function_be41a80a6ba0b0a6( currentweapon ) && !var_76a3b56d99c1ddee )
            {
                autotests::function_5b8cb4c1e1344b52( autotests::get_current_asset_name(), "PartialReload" );
                PartialReload( currentweapon );
                autotests::function_d2beb5130405ff37( autotests::get_current_asset_name(), "PartialReload" );
                autotests::function_5b8cb4c1e1344b52( autotests::get_current_asset_name(), "CancelReload" );
                testcancelreload( currentweapon, var_906ce4e7b26a1606 );
                autotests::function_d2beb5130405ff37( autotests::get_current_asset_name(), "CancelReload" );
                autotests::function_5b8cb4c1e1344b52( autotests::get_current_asset_name(), "YYReload" );
                function_d4871c8a7f1970f1( currentweapon, var_906ce4e7b26a1606 );
                autotests::function_d2beb5130405ff37( autotests::get_current_asset_name(), "YYReload" );
            }
            
            autotests::function_5b8cb4c1e1344b52( autotests::get_current_asset_name(), "SprintReload" );
            testsprintreload( currentweapon );
            autotests::function_d2beb5130405ff37( autotests::get_current_asset_name(), "SprintReload" );
            autotests::function_5b8cb4c1e1344b52( autotests::get_current_asset_name(), "ProneReload" );
            function_78fabe42c96827e9( currentweapon );
            autotests::function_d2beb5130405ff37( autotests::get_current_asset_name(), "ProneReload" );
            autotests::function_5b8cb4c1e1344b52( autotests::get_current_asset_name(), "SlidingReload" );
            function_9056e7a977b5f2d1( currentweapon );
            autotests::function_d2beb5130405ff37( autotests::get_current_asset_name(), "SlidingReload" );
            autotests::function_5b8cb4c1e1344b52( autotests::get_current_asset_name(), "ADSReload" );
            function_f779ada1616df0b5( currentweapon );
            autotests::function_d2beb5130405ff37( autotests::get_current_asset_name(), "ADSReload" );
            
            if ( game_utility::getmapname() == "mp_saw_mechanics" )
            {
                function_dba5967cb383906b( currentweapon );
            }
        }
        
        if ( currentweapon.hasalternate )
        {
            autotests::function_5b8cb4c1e1344b52( autotests::get_current_asset_name(), "FireModeSelect" );
            function_ac84687d967be89();
            autotests::function_d2beb5130405ff37( autotests::get_current_asset_name(), "FireModeSelect" );
        }
    }
    
    akimboattachment = function_543a9774f0f10d1e( currentweapon );
    
    if ( akimboattachment )
    {
        function_d5835ee14365b1ef( currentweapon, akimboattachment );
    }
}

// Namespace test_mp_cod_weapons_sweep
// Params 2, eflags: 0x4
// Checksum 0x35b26cb0, Offset: 0xdd2
// Size: 0xcb
function private function_d5835ee14365b1ef( currentweapon, akimboattachment )
{
    autotests::function_d84657f448aaeef6( "_DualWield", 1, "scripts/autotests/mp/test_mp_cod_weapons_sweep.gsc", 235 );
    var_e74daecbaa319747 = weapon::buildweapon( weapon::getweaponrootname( currentweapon ), [ akimboattachment ], undefined, undefined, undefined, undefined, undefined, undefined, istrue( level.nightmap ) );
    
    if ( var_e74daecbaa319747 )
    {
        self takeweapon( currentweapon );
        self giveweapon( var_e74daecbaa319747 );
        self switchtoweaponimmediate( var_e74daecbaa319747 );
        wait 1;
        
        if ( self function_fc08227330530fcb( currentweapon ) )
        {
            autotests::function_5b8cb4c1e1344b52( autotests::get_current_asset_name(), "DualWieldInspect" );
            function_bfdf0f060cc65514();
            autotests::function_d2beb5130405ff37( autotests::get_current_asset_name(), "DualWieldInspect" );
        }
        
        self takeweapon( var_e74daecbaa319747 );
        self giveweapon( currentweapon );
        self switchtoweaponimmediate( currentweapon );
        wait 1;
    }
}

// Namespace test_mp_cod_weapons_sweep
// Params 1, eflags: 0x4
// Checksum 0x9a55e886, Offset: 0xea5
// Size: 0x181
function private function_dba5967cb383906b( currentweapon )
{
    autotests_utility_video::test_setorigin( ( -694, 890, -454 ) );
    self setplayerangles( ( 0, 90, 0 ) );
    wait 1;
    autotests::function_5b8cb4c1e1344b52( autotests::get_current_asset_name(), "MountedReload" );
    self botpressbutton( "ADS", 8 );
    self botpressbutton( "mount", 0.1 );
    wait 1;
    mounttype = self playermounttype();
    var_63a718d91714219d = autotests::function_e4dbfc06e59fa0cb( "Mounted before reload?", mounttype, "mount_none", "scripts/autotests/mp/test_mp_cod_weapons_sweep.gsc", 269 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    PartialReload( currentweapon );
    var_63a718d91714219d = autotests::function_e4dbfc06e59fa0cb( "Mounted after reload?", mounttype, "mount_none", "scripts/autotests/mp/test_mp_cod_weapons_sweep.gsc", 273 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    self botclearbutton( "ADS" );
    wait 2;
    autotests::function_d2beb5130405ff37( autotests::get_current_asset_name(), "MountedReload" );
    function_8b3810771b6e2e47( 0.5 );
    wait 1.5;
    self setplayerangles( level.autotests.test_runtime.playerangles );
    autotests_utility_video::test_setorigin( level.autotests.test_runtime.playerorigin );
    wait 1;
    removeallfxmarks();
}

// Namespace test_mp_cod_weapons_sweep
// Params 1, eflags: 0x4
// Checksum 0x9bfa529b, Offset: 0x102e
// Size: 0x71
function private function_ca55025078a31055( currentweapon )
{
    self setweaponammostock( currentweapon, 0 );
    self setweaponammoclip( currentweapon, 0 );
    autotests::function_5b8cb4c1e1344b52( autotests::get_current_asset_name(), "EmptyInspect" );
    wait 0.5;
    function_bfdf0f060cc65514();
    wait 0.5;
    autotests::function_d2beb5130405ff37( autotests::get_current_asset_name(), "EmptyInspect" );
    self setweaponammoclip( currentweapon, weaponclipsize( currentweapon ) );
    self setweaponammostock( currentweapon, weaponmaxammo( currentweapon ) );
}

// Namespace test_mp_cod_weapons_sweep
// Params 1, eflags: 0x4
// Checksum 0xa5e19143, Offset: 0x10a7
// Size: 0x8d
function private function_543a9774f0f10d1e( weapon )
{
    attachment_bundles = function_e4a939f46849b299( weapon, "akimbo" );
    
    foreach ( attachment_bundle in attachment_bundles )
    {
        return attachment_bundle;
    }
}

// Namespace test_mp_cod_weapons_sweep
// Params 1, eflags: 0x4
// Checksum 0xa733d9aa, Offset: 0x113c
// Size: 0x1f
function private testads( duration )
{
    self botpressbutton( "ADS", duration );
    wait duration;
    wait 2;
}

// Namespace test_mp_cod_weapons_sweep
// Params 0, eflags: 0x4
// Checksum 0xc1079420, Offset: 0x1163
// Size: 0x90
function private function_bfdf0f060cc65514()
{
    self forceweaponinspect();
    starttime = gettime();
    
    if ( !self function_985124b0e1e74f2e() )
    {
        starttime = gettime();
        
        while ( !self function_985124b0e1e74f2e() )
        {
            waitframe();
            
            if ( gettime() - starttime > 1000 )
            {
                autotests::function_d84657f448aaeef6( "Weapon inspection did not start in 1 second.", 0, "scripts/autotests/mp/test_mp_cod_weapons_sweep.gsc", 328 );
                return;
            }
        }
    }
    
    starttime = gettime();
    
    while ( !!self function_985124b0e1e74f2e() )
    {
        waitframe();
        
        if ( gettime() - starttime > 25000 )
        {
            autotests::function_d84657f448aaeef6( "Weapon inspection did not finish in 25 seconds.", 0, "scripts/autotests/mp/test_mp_cod_weapons_sweep.gsc", 331 );
            return;
        }
    }
}

// Namespace test_mp_cod_weapons_sweep
// Params 0, eflags: 0x4
// Checksum 0x9bc44e75, Offset: 0x11fb
// Size: 0x18
function private function_241a42464a3864de()
{
    autotests_utility_bot::function_aaa2288bee31d766( "melee", 1, 0.5 );
    wait 2;
}

// Namespace test_mp_cod_weapons_sweep
// Params 1, eflags: 0x4
// Checksum 0xef4fa384, Offset: 0x121b
// Size: 0x10e
function private function_2cb35ea905382b9d( duration )
{
    weapon = self getcurrentweapon();
    clipsize = weaponclipsize( weapon );
    ammoclip = self getweaponammoclip( weapon );
    
    if ( ammoclip < clipsize )
    {
        self setweaponammoclip( weapon, clipsize );
        starttime = gettime();
        
        while ( !( self getweaponammoclip( weapon ) == clipsize ) )
        {
            waitframe();
            
            if ( gettime() - starttime > 1000 )
            {
                autotests::function_d84657f448aaeef6( "Weapon did not get ammo for firing in 1 second.", 0, "scripts/autotests/mp/test_mp_cod_weapons_sweep.gsc", 349 );
                return;
            }
        }
        
        wait 2;
    }
    
    self setweaponammostock( weapon, 0 );
    self startforcedfire();
    wait duration;
    self stopforcedfire();
    wait 0.5;
    ammoclip = self getweaponammoclip( weapon );
    var_63a718d91714219d = autotests::function_e4e4ff06e5a9c612( "Shooting used clip ammo?", ammoclip, clipsize, "scripts/autotests/mp/test_mp_cod_weapons_sweep.gsc", 361 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    removeallfxmarks();
    self setweaponammostock( weapon, weaponmaxammo( weapon ) );
}

// Namespace test_mp_cod_weapons_sweep
// Params 2, eflags: 0x4
// Checksum 0xd52ef10c, Offset: 0x1331
// Size: 0xe3
function private testcancelreload( currentweapon, previousweapon )
{
    self function_349ee393ea6dba7e( "sprint_reload_cancel", 1 );
    halfclipsize = int( weaponclipsize( currentweapon ) / 2 );
    self setweaponammoclip( currentweapon, halfclipsize );
    time = 3;
    function_a53e6baa289edf87( time );
    wait 0.2;
    self forcereloading();
    waitforreloadstart();
    wait 0.1;
    self botpressbutton( "sprint" );
    wait time - 1;
    var_63a718d91714219d = autotests::function_e4e4ff06e5a9c612( "Interrupted reload - less than full ammo?", self getweaponammoclip( currentweapon ), weaponclipsize( currentweapon ), "scripts/autotests/mp/test_mp_cod_weapons_sweep.gsc", 382 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    wait 0.5;
    self function_349ee393ea6dba7e( "sprint_reload_cancel", 0 );
    removeallfxmarks();
}

// Namespace test_mp_cod_weapons_sweep
// Params 2, eflags: 0x4
// Checksum 0xaab7a4f6, Offset: 0x141c
// Size: 0x93
function private function_d4871c8a7f1970f1( currentweapon, previousweapon )
{
    self setweaponammoclip( currentweapon, 1 );
    self forcereloading();
    waitforreloadstart();
    wait 0.1;
    self switchtoweapon( previousweapon );
    wait 0.1;
    self switchtoweapon( currentweapon );
    var_63a718d91714219d = autotests::function_e4e4ff06e5a9c612( "YY interrupted reload - no reload?", self getweaponammoclip( currentweapon ), weaponclipsize( currentweapon ), "scripts/autotests/mp/test_mp_cod_weapons_sweep.gsc", 398 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace test_mp_cod_weapons_sweep
// Params 1, eflags: 0x4
// Checksum 0x2b27f0fd, Offset: 0x14b7
// Size: 0x1e
function private function_a53e6baa289edf87( time )
{
    self botsetscriptmove( self getplayerangles()[ 1 ], time, 1 );
}

// Namespace test_mp_cod_weapons_sweep
// Params 1, eflags: 0x4
// Checksum 0xd9dea038, Offset: 0x14dd
// Size: 0x21
function private function_8b3810771b6e2e47( time )
{
    self botsetscriptmove( self getplayerangles()[ 1 ] * -1, time, 1 );
}

// Namespace test_mp_cod_weapons_sweep
// Params 1, eflags: 0x4
// Checksum 0x7692e297, Offset: 0x1506
// Size: 0xc4
function private testsprintreload( currentweapon )
{
    angles = self getplayerangles();
    origin = self getorigin();
    time = 3;
    function_a53e6baa289edf87( time );
    self botpressbutton( "sprint", time );
    wait 0.5;
    PartialReload( currentweapon );
    var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Sprint Reload?", self getweaponammoclip( currentweapon ), weaponclipsize( currentweapon ), "scripts/autotests/mp/test_mp_cod_weapons_sweep.gsc", 422 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    test_wait( 1 );
    self setplayerangles( angles );
    self setorigin( origin );
    removeallfxmarks();
}

// Namespace test_mp_cod_weapons_sweep
// Params 1, eflags: 0x4
// Checksum 0xf68255b3, Offset: 0x15d2
// Size: 0x72
function private function_8eb3fb76c74fbcad( stance )
{
    self botsetstance( stance );
    starttime = gettime();
    
    for ( currentstance = self getstance(); currentstance != stance ; currentstance = self getstance() )
    {
        waitframe();
        
        if ( gettime() - starttime > 5000 )
        {
            autotests::function_d84657f448aaeef6( "Failed to set stance to " + stance + " in 5 seconds.", 0, "scripts/autotests/mp/test_mp_cod_weapons_sweep.gsc", 441 );
            return;
        }
    }
}

// Namespace test_mp_cod_weapons_sweep
// Params 1, eflags: 0x4
// Checksum 0xddf1944c, Offset: 0x164c
// Size: 0x41
function private function_78fabe42c96827e9( currentweapon )
{
    var_df5f168a691597b7 = self getstance();
    function_8eb3fb76c74fbcad( "prone" );
    wait 1;
    PartialReload( currentweapon );
    function_8eb3fb76c74fbcad( var_df5f168a691597b7 );
    wait 1;
}

// Namespace test_mp_cod_weapons_sweep
// Params 1, eflags: 0x4
// Checksum 0x2211ba3d, Offset: 0x1695
// Size: 0x6a
function private function_9056e7a977b5f2d1( currentweapon )
{
    time = 10;
    function_a53e6baa289edf87( time );
    self botpressbutton( "sprint" );
    wait 1;
    self botpressbutton( "slide", 5 );
    wait 0.2;
    PartialReload( currentweapon );
    wait 1;
    self botclearbutton( "slide" );
    self botsetscriptmove( 0, 0, 1 );
    removeallfxmarks();
}

// Namespace test_mp_cod_weapons_sweep
// Params 0, eflags: 0x4
// Checksum 0x4cb6f38e, Offset: 0x1707
// Size: 0x21
function private function_ac84687d967be89()
{
    wait 1;
    self botpressbutton( "alt_weapon_toggle" );
    wait 2;
    self botpressbutton( "alt_weapon_toggle" );
    wait 2;
}

// Namespace test_mp_cod_weapons_sweep
// Params 1, eflags: 0x4
// Checksum 0x8d3bc71d, Offset: 0x1730
// Size: 0x2b
function private function_f779ada1616df0b5( currentweapon )
{
    self botpressbutton( "ADS", 2 );
    wait 0.5;
    PartialReload( currentweapon );
    wait 2;
}

// Namespace test_mp_cod_weapons_sweep
// Params 0, eflags: 0x4
// Checksum 0xc2fe1c47, Offset: 0x1763
// Size: 0x52
function private waitforreloadstart()
{
    starttime = gettime();
    
    if ( !self isreloading() )
    {
        starttime = gettime();
        
        while ( !self isreloading() )
        {
            waitframe();
            
            if ( gettime() - starttime > 1000 )
            {
                autotests::function_d84657f448aaeef6( "Reload did not start in 1 second.", 0, "scripts/autotests/mp/test_mp_cod_weapons_sweep.gsc", 495 );
                return;
            }
        }
    }
}

// Namespace test_mp_cod_weapons_sweep
// Params 0, eflags: 0x4
// Checksum 0x912c04a8, Offset: 0x17bd
// Size: 0x44
function private waitforreloadfinish()
{
    starttime = gettime();
    
    while ( !!self isreloading() )
    {
        waitframe();
        
        if ( gettime() - starttime > 22000 )
        {
            autotests::function_d84657f448aaeef6( "Reload did not finish in 22 seconds.", 0, "scripts/autotests/mp/test_mp_cod_weapons_sweep.gsc", 501 );
            return;
        }
    }
}

// Namespace test_mp_cod_weapons_sweep
// Params 0, eflags: 0x4
// Checksum 0x783d30ea, Offset: 0x1809
// Size: 0x10
function private waitforreload()
{
    waitforreloadstart();
    waitforreloadfinish();
}

// Namespace test_mp_cod_weapons_sweep
// Params 1, eflags: 0x4
// Checksum 0xb8b28fd5, Offset: 0x1821
// Size: 0x3e
function private EmptyReload( currentweapon )
{
    self givemaxammo( currentweapon );
    self setweaponammoclip( currentweapon, 0 );
    
    if ( function_cc2b66d6ab909910( currentweapon ) || self function_9727a187e8b273c4( currentweapon ) )
    {
        self forcereloading();
    }
    
    waitforreload();
}

// Namespace test_mp_cod_weapons_sweep
// Params 1, eflags: 0x4
// Checksum 0x50449a15, Offset: 0x1867
// Size: 0x43
function private PartialReload( currentweapon )
{
    self givemaxammo( currentweapon );
    halfclipsize = int( weaponclipsize( currentweapon ) / 2 );
    self setweaponammoclip( currentweapon, halfclipsize );
    self forcereloading();
    waitforreload();
}

// Namespace test_mp_cod_weapons_sweep
// Params 0, eflags: 0x4
// Checksum 0xf8bb8e4d, Offset: 0x18b2
// Size: 0x3f
function private function_2da7d4694fda2fdd()
{
    projectname = tolower( getprojectname() );
    
    if ( projectname == "wz2" )
    {
        projectname = "t10";
    }
    else if ( projectname == "saw" )
    {
        projectname = "sat";
    }
    
    return projectname;
}

