// scripts\autotests\mp\test_mp_cod_weapons_sweep_perf.gsc  (hash_5a75f7ab0586feaf.gscc) (size: 5477 Bytes / 0x1565 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb8e90d42 (3102281026)
// size ...... 5477 (0x1565)
// includes .. 6   (offset: 0x1405)
// strings ... 22  (offset: 0x1435)
// dev strs .. 0   (offset: 0x1565)
// exports ... 13  (offset: 0xaad)
// cseg ...... 0x21e + 0x88f (0xaad)
// imports ... 61  (offset: 0xcb5)
// animtree1 . 0   (offset: 0x1565)
// animtree2 . 0   (offset: 0x1565)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_player;
#using scripts\autotests\mp\autotests_utility_weapons;
#using scripts\common\weapon;
#using scripts\mp\common\utility\game_utility;

#namespace test_mp_cod_weapons_sweep_perf;

// Namespace test_mp_cod_weapons_sweep_perf/testautomation
// Params 0, eflags: 0x20
// Checksum 0x7fb96143, Offset: 0x23c
// Size: 0x30
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_cod_weapons_sweep_perf.gsc", #"gp_vehicles", &start_test, &setup, &cleanup, &parameterize, &asset_types );
}

// Namespace test_mp_cod_weapons_sweep_perf
// Params 0, eflags: 0x4
// Checksum 0xecb36a3a, Offset: 0x274
// Size: 0xc
function private asset_types()
{
    return [ "weaponblueprint" ];
}

// Namespace test_mp_cod_weapons_sweep_perf
// Params 1, eflags: 0x4
// Checksum 0xca2466d9, Offset: 0x289
// Size: 0x17e
function private parameterize( datasets )
{
    blueprintnames = [];
    
    if ( !isdefined( level.weaponmapdata ) )
    {
        return blueprintnames;
    }
    
    var_15dd55f313034f43 = autotests_utility_weapons::function_b1e78006d75ee4f3( &autotests_utility_weapons::function_5b69f10049eb1449 );
    
    foreach ( weapon in var_15dd55f313034f43 )
    {
        rootname = weapon::getweaponrootname( weapon );
        blueprints = getweaponblueprintnames( weapon );
        
        if ( blueprints.size == 0 )
        {
            blueprintnames[ blueprintnames.size ] = rootname + "$" + 0;
            continue;
        }
        
        foreach ( varianthash, variantid in blueprints )
        {
            if ( autotests_utility_weapons::get_assetlist().size > 0 )
            {
                if ( !autotests_utility_weapons::function_e86f9992269514eb( varianthash, autotests_utility_weapons::get_assetlist() ) )
                {
                    continue;
                }
            }
            
            blueprintnames[ blueprintnames.size ] = rootname + "$" + variantid;
        }
    }
    
    return blueprintnames;
}

// Namespace test_mp_cod_weapons_sweep_perf
// Params 0, eflags: 0x4
// Checksum 0xc048eb69, Offset: 0x410
// Size: 0x4e
function private cleanup()
{
    if ( level.autotests.test_runtime.fpstool )
    {
        function_3abe1f9532a7887b( "capture_perf_force_finish" );
        wait 1;
    }
    
    setdvar( @"hash_1a0424526eddd43", 0 );
    setdvar( @"hash_ebd98e5eecc1322b", 1 );
}

// Namespace test_mp_cod_weapons_sweep_perf
// Params 0, eflags: 0x4
// Checksum 0x7f99c861, Offset: 0x466
// Size: 0x20f, Type: bool
function private setup()
{
    autotests::function_5c8c87763724c132();
    autotests::set_dvar( @"hash_5fdf364fef6ac4d0", 1 );
    var_c584e1e56d759ed9 = getdvarint( @"br_minplayers", 0 );
    
    if ( var_c584e1e56d759ed9 < 3 )
    {
        setdvar( @"br_minplayers", 3 );
    }
    
    player = autotests_utility_player::get_player();
    player function_ffb0711adb6d8d0d();
    
    if ( game_utility::getmapname() == "mp_t10_mtx_capture" )
    {
        player setorigin( ( -21, -648, 42 ) );
        player setplayerangles( ( 0, 90, 0 ) );
        wait 2;
    }
    
    var_55507fd74ecdb6a4 = getdvar( @"hash_24647fd862aeee10" );
    
    if ( var_55507fd74ecdb6a4.size > 0 )
    {
        level.autotests.test_runtime.fpstool = 1;
    }
    
    if ( level.autotests.test_runtime.fpstool )
    {
        function_3abe1f9532a7887b( "r_gpuTimers 2" );
        function_3abe1f9532a7887b( "r_gpShowStats 1" );
    }
    
    autotests::set_dvar( @"r_mbenable", "off" );
    autotests::set_dvar( @"cg_draw2d", 0 );
    autotests::set_dvar( @"cg_drawfps", 0 );
    autotests::set_dvar( @"hash_db628cbef70002ae", 0 );
    autotests::set_dvar( @"hash_1c7ec136165116b7", 0 );
    autotests::set_dvar( @"hash_c11db9baa9e5bc9b", 1 );
    level.timelimit = 0;
    botdata = autotests_utility_bot::get_spawn_data( player, 400 );
    player setplayerangles( vectortoangles( botdata.origin - player.origin + ( 0, 0, -15 ) ) );
    level.autotests.test_runtime.playerangles = player getplayerangles();
    player.maxhealth = 30000;
    player.health = 30000;
    return true;
}

// Namespace test_mp_cod_weapons_sweep_perf
// Params 0
// Checksum 0x100a9ec0, Offset: 0x67e
// Size: 0x14c
function start_test()
{
    autotests::function_e5041006e5cc3d56( "Has at least 1 parameter?", self.parameters.size, 1, "scripts/autotests/mp/test_mp_cod_weapons_sweep_perf.gsc", 136 );
    player = autotests_utility_player::get_player();
    
    if ( self.parameters.size == 1 )
    {
        var_23986f5ff3f49f24 = self.parameters[ 0 ];
        weaponname = autotests_utility_weapons::get_weapon_asset_name( var_23986f5ff3f49f24 );
        variant = autotests_utility_weapons::function_3d7814ac5020182( var_23986f5ff3f49f24 );
        var_63a718d91714219d = autotests::function_36ed835262a19e53( "Found variant from single input parameter?", variant, "scripts/autotests/mp/test_mp_cod_weapons_sweep_perf.gsc", 145 );
        
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
        weaponname = self.parameters[ 0 ];
        variantid = int( self.parameters[ 1 ] );
        variant = autotests_utility_weapons::function_621215cb1817ee55( weaponname, variantid );
        var_63a718d91714219d = autotests::function_36ed835262a19e53( "Found variant from weaponname + variantID?", variant, "scripts/autotests/mp/test_mp_cod_weapons_sweep_perf.gsc", 152 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
    
    function_ec71ecc8a4ff1e9f( player, level.autotests.test_runtime.playerangles, weaponname, variant );
}

// Namespace test_mp_cod_weapons_sweep_perf
// Params 4, eflags: 0x4
// Checksum 0xd86c8f70, Offset: 0x7d2
// Size: 0x104
function private function_ec71ecc8a4ff1e9f( player, angles, weaponname, variant )
{
    hashstring = string( variant.varianthash );
    hashstring = getsubstr( hashstring, 3, hashstring.size - 1 );
    variantname = weaponname + "_hash_" + hashstring + "_id_" + string( variant.variantid );
    autotests::set_current_asset_name( variantname );
    autotests::function_d84657f448aaeef6( "New weapon variant " + variantname, 1, "scripts/autotests/mp/test_mp_cod_weapons_sweep_perf.gsc", 169 );
    waitframe();
    player setplayerangles( angles );
    autotests::function_5b8cb4c1e1344b52( autotests::get_current_asset_name(), "sweep" );
    player testweapon( autotests_utility_weapons::create_weapon( weapon::getweaponrootname( weaponname ), variant.variantid, istrue( level.nightmap ) ), 0 );
    autotests::function_d2beb5130405ff37( autotests::get_current_asset_name(), "sweep" );
    autotests::set_current_asset_name( "" );
}

// Namespace test_mp_cod_weapons_sweep_perf
// Params 2, eflags: 0x4
// Checksum 0x45be489, Offset: 0x8de
// Size: 0x131
function private testweapon( weapon, checkammo )
{
    self takeweapon( self getcurrentweapon() );
    wait 1;
    self giveweapon( weapon );
    self switchtoweaponimmediate( weapon );
    wait 1;
    fpstool = level.autotests.test_runtime.fpstool;
    
    if ( fpstool )
    {
        function_3abe1f9532a7887b( "capture_perf_current_camera " + autotests::get_current_asset_name() );
    }
    
    wait 1;
    autotests::function_5b8cb4c1e1344b52( autotests::get_current_asset_name(), "inspect" );
    function_b33f19c550e19acb();
    autotests::function_d2beb5130405ff37( autotests::get_current_asset_name(), "inspect" );
    wait 1;
    autotests::function_5b8cb4c1e1344b52( autotests::get_current_asset_name(), "ads" );
    botads( 2 );
    autotests::function_d2beb5130405ff37( autotests::get_current_asset_name(), "ads" );
    autotests::function_5b8cb4c1e1344b52( autotests::get_current_asset_name(), "shootPrimaryWeapon" );
    shootPrimaryWeapon( 2 );
    autotests::function_d2beb5130405ff37( autotests::get_current_asset_name(), "shootPrimaryWeapon" );
    wait 1;
    autotests::function_5b8cb4c1e1344b52( autotests::get_current_asset_name(), "reloadPrimaryWeapon" );
    reloadPrimaryWeapon();
    autotests::function_d2beb5130405ff37( autotests::get_current_asset_name(), "reloadPrimaryWeapon" );
    wait 1;
}

// Namespace test_mp_cod_weapons_sweep_perf
// Params 0, eflags: 0x4
// Checksum 0xa7a6258b, Offset: 0xa17
// Size: 0x17
function private function_b33f19c550e19acb()
{
    self forceweaponinspect();
    wait 1;
    
    while ( self function_985124b0e1e74f2e() )
    {
        waitframe();
    }
}

// Namespace test_mp_cod_weapons_sweep_perf
// Params 1, eflags: 0x4
// Checksum 0x52edb8d8, Offset: 0xa36
// Size: 0x25
function private botads( duration = 2 )
{
    self botpressbutton( "ADS", duration );
    wait duration;
}

// Namespace test_mp_cod_weapons_sweep_perf
// Params 1, eflags: 0x4
// Checksum 0xe8ee662e, Offset: 0xa63
// Size: 0x27
function private shootPrimaryWeapon( duration = 2 )
{
    self startforcedfire();
    wait duration;
    self stopforcedfire();
    wait 1;
}

// Namespace test_mp_cod_weapons_sweep_perf
// Params 0, eflags: 0x4
// Checksum 0xa69d7bd4, Offset: 0xa92
// Size: 0x1b
function private reloadPrimaryWeapon()
{
    self forcereloading();
    wait 0.5;
    
    while ( self isreloading() )
    {
        waitframe();
    }
    
    waitframe();
}

