// scripts\autotests\mp\test_mp_blueprint_video.gsc  (hash_1072fee20e7953a1.gscc) (size: 2816 Bytes / 0xb00 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x30747183 (812937603)
// size ...... 2816 (0xb00)
// includes .. 4   (offset: 0xa58)
// strings ... 9   (offset: 0xa78)
// dev strs .. 1   (offset: 0xaf4)
// exports ... 9   (offset: 0x5c0)
// cseg ...... 0x10b + 0x4b5 (0x5c0)
// imports ... 28  (offset: 0x728)
// animtree1 . 0   (offset: 0xb00)
// animtree2 . 0   (offset: 0xb00)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_player;
#using scripts\common\utility;

#namespace test_mp_blueprint_video;

// Namespace test_mp_blueprint_video/testautomation
// Params 0, eflags: 0x20
// Checksum 0x4bed424f, Offset: 0x129
// Size: 0x21
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_blueprint_video.gsc", #"GP", &start_test, &setup );
}

// Namespace test_mp_blueprint_video
// Params 0
// Checksum 0x8e304c46, Offset: 0x152
// Size: 0x2b, Type: bool
function setup()
{
    autotests::function_5c8c87763724c132();
    level.autotests.test_runtime.disable_hud_prints = 1;
    return true;
}

// Namespace test_mp_blueprint_video
// Params 0
// Checksum 0x2da1f4b, Offset: 0x186
// Size: 0x1ad
function start_test()
{
    params = level.autotests.test_runtime.parameters;
    skin = "t10_usa_pl_bailey_gamer_skin";
    testactions = "kill";
    setdvar( @"cg_draw2d", 0 );
    
    if ( params.size == 1 )
    {
        weaponblueprint = params[ 0 ];
    }
    else if ( params.size == 2 )
    {
        weaponblueprint = params[ 0 ];
        testactions = tolower( params[ 1 ] );
    }
    else if ( params.size == 3 )
    {
        weaponblueprint = params[ 0 ];
        testactions = tolower( params[ 1 ] );
        skin = params[ 2 ];
    }
    
    if ( testactions == "kill" )
    {
        doinspect = 0;
        dokill = 1;
    }
    else if ( testactions == "inspect" )
    {
        doinspect = 1;
        dokill = 0;
    }
    else if ( testactions == "kill_inspect" || testactions == "inspect_kill" )
    {
        doinspect = 1;
        dokill = 1;
    }
    
    level.blockweapondrops = 1;
    player = autotests_utility_player::get_player();
    
    /#
        adddebugcommand( "<dev string:x24>" );
    #/
    
    setdvar( @"scr_giveweaponblueprintname", weaponblueprint, "" );
    setdvar( @"scr_operator_skin_target", 0 );
    setdvar( @"scr_operator_skin", skin, "" );
    setdvar( @"g_freeclientcorpses", 1 );
    wait 2;
    
    if ( doinspect )
    {
        function_b33f19c550e19acb( player );
    }
    
    if ( dokill )
    {
        function_83135b6a057f37a7( player, skin );
    }
    
    wait 5;
    setdvar( @"cg_draw2d", 1 );
}

// Namespace test_mp_blueprint_video
// Params 1, eflags: 0x4
// Checksum 0x5b1a909a, Offset: 0x33b
// Size: 0x2c
function private function_b33f19c550e19acb( player )
{
    player forceweaponinspect();
    wait 1;
    
    while ( player function_985124b0e1e74f2e() )
    {
        waitframe();
    }
    
    wait 2;
}

// Namespace test_mp_blueprint_video
// Params 2, eflags: 0x4
// Checksum 0x47f57cd9, Offset: 0x36f
// Size: 0xa4
function private function_83135b6a057f37a7( player, skin )
{
    var_d9084239cc1ec7f0 = function_1e006006f5d43f7e( player );
    wait 2;
    setdvar( @"scr_operator_skin_target", 1 );
    setdvar( @"scr_operator_skin", skin, "" );
    autotests_utility_bot::function_aa611d4a3829652a( var_d9084239cc1ec7f0, player, 300 );
    wait 2;
    weapons = player function_f251961fba0e40e9();
    
    if ( weapons.size == 0 )
    {
        return 1;
    }
    
    player function_61dfb2826ade14ad( var_d9084239cc1ec7f0 );
    wait 2;
    setdvar( @"g_freeclientcorpses", 1 );
}

// Namespace test_mp_blueprint_video
// Params 1, eflags: 0x4
// Checksum 0x2618f874, Offset: 0x41b
// Size: 0x70
function private function_1e006006f5d43f7e( player )
{
    autotests_utility_bot::kick_all_bots();
    spawndata = spawnstruct();
    spawndata.spawnpos = ( -352, -64, 16 );
    spawndata.angles = ( 0, 0, 0 );
    bot = autotests_utility_bot::function_978126f411fc8a11( player, spawndata );
    wait 2;
    return bot;
}

// Namespace test_mp_blueprint_video
// Params 0, eflags: 0x4
// Checksum 0x3041e030, Offset: 0x494
// Size: 0xde
function private function_f251961fba0e40e9()
{
    weapons = [];
    
    foreach ( weapon in self.primaryweapons )
    {
        if ( weapon.damagemodcategory != #"melee" )
        {
            weapons[ weapons.size ] = weapon;
        }
    }
    
    var_63a718d91714219d = autotests::function_d84657f448aaeef6( "There are weapons to shoot.", weapons.size != 0, "scripts/autotests/mp/test_mp_blueprint_video.gsc", 198 );
    
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

// Namespace test_mp_blueprint_video
// Params 2, eflags: 0x4
// Checksum 0xb3092c6a, Offset: 0x57b
// Size: 0x45
function private function_61dfb2826ade14ad( bot, duration = 5 )
{
    self startforcedfire();
    bot utility::waittill_any_in_array_or_timeout( [ "death" ], duration );
    wait 0.5;
    self stopforcedfire();
}

