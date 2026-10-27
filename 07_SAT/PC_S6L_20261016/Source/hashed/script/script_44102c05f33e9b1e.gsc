// script_44102c05f33e9b1e  (hash_44102c05f33e9b1e.gscc) (size: 11200 Bytes / 0x2bc0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xada1062f (2913011247)
// size ...... 11200 (0x2bc0)
// includes .. 17  (offset: 0x2b1c)
// strings ... 1   (offset: 0x2ba4)
// dev strs .. 0   (offset: 0x2bc0)
// exports ... 75  (offset: 0x14c8)
// cseg ...... 0x73 + 0x1455 (0x14c8)
// imports ... 84  (offset: 0x2080)
// animtree1 . 0   (offset: 0x2bc0)
// animtree2 . 0   (offset: 0x2bc0)
#using script_239a365a92ee4476;
#using script_45e6947be98e16e3;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\loot;
#using scripts\mp\ftue\utility\ftue_buy_station;
#using scripts\mp\ftue\utility\ftue_cash;
#using scripts\mp\ftue\utility\ftue_inventory;
#using scripts\mp\ftue\utility\ftue_loadout;
#using scripts\mp\ftue\utility\ftue_loot_cache;
#using scripts\mp\ftue\utility\ftue_movement;
#using scripts\mp\ftue\utility\ftue_objectives;
#using scripts\mp\ftue\utility\ftue_player;
#using scripts\mp\ftue\utility\ftue_tip;
#using scripts\mp\ftue\utility\ftue_utility;

#namespace namespace_44e68768d1d1a5d6;

// Namespace namespace_44e68768d1d1a5d6
// Params 1
// Checksum 0xdfa16223, Offset: 0x91
// Size: 0x2d
function function_9113b00af78e55ee( tipref )
{
    ftue_tip::function_c9cca7ed21647155( tipref );
    wait 20;
    ftue_tip::function_e1b6c8c6f8f3dc45( 1 );
    self notify( #"currentContextualTipCompleted" );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0x9e92144a, Offset: 0xc6
// Size: 0x12
function function_41a8ddbbb7993cdf()
{
    function_9113b00af78e55ee( #"prematch" );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 1
// Checksum 0xea3ff503, Offset: 0xe0
// Size: 0x12
function function_fa2a31ff3c992888( params )
{
    return ftue_movement::function_b637614feabc055f();
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0x5d6ddcba, Offset: 0xfb
// Size: 0x27
function function_4decc5d41f685a84()
{
    ftue_player::function_a0f4359c3f80d594();
    ftue_tip::function_84dafc5c5a3f97ff( #"open_parachute", 1 );
    self notify( #"currentContextualTipCompleted" );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0x1dc7997a, Offset: 0x12a
// Size: 0x2b
function function_4decc6d41f685cb7()
{
    ftue_tip::function_84dafc5c5a3f97ff( #"jump_plane", 1 );
    ftue_tip::function_c9cca7ed21647155( #"open_parachute" );
    function_4decc5d41f685a84();
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0xed64b7d1, Offset: 0x15d
// Size: 0x1e
function function_4decc7d41f685eea()
{
    ftue_tip::function_c9cca7ed21647155( #"jump_plane" );
    ftue_player::function_ce94da81b25685d7( &function_4decc6d41f685cb7 );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 1
// Checksum 0x1b0f5caf, Offset: 0x183
// Size: 0x12, Type: bool
function function_239f1a2e516d9e97( params )
{
    return ftue_player::function_53c3ebdfa4a34ea4();
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0xa67da22b, Offset: 0x19e
// Size: 0x1c
function function_18712bf1a71f7ff3()
{
    ftue_objectives::function_ecadaaabe4a83e9b( self.var_11133cb0607b498f.objectiveid );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0x63d2c46c, Offset: 0x1c2
// Size: 0xf9
function function_764a6f92fb3f1e50()
{
    ftue_tip::function_c9cca7ed21647155( #"supply_cache" );
    supplycache = self.var_11133cb0607b498f.closestlootcrate;
    assert( isdefined( supplycache ) );
    self.var_11133cb0607b498f.objectiveid = ftue_objectives::function_518a2916085fd4f8( supplycache.origin + ( 0, 0, 18 ), &"ftue_br/open", "icon_ping_ftue_waypoint", 15, self );
    childthread ftue_utility::function_2623dccd6b2677cc( self, 60, &function_18712bf1a71f7ff3 );
    self waittill( #"hash_9b7aa9f938e78248" );
    ftue_utility::function_b342342ac1cbac2e( self );
    function_18712bf1a71f7ff3();
    ftue_tip::function_e1b6c8c6f8f3dc45( 1 );
    ftue_tip::function_c9cca7ed21647155( #"pickup_loot" );
    childthread ftue_utility::function_2623dccd6b2677cc( self, 20 );
    self waittill( #"self_pickedupitem" );
    ftue_tip::function_84dafc5c5a3f97ff( #"pickup_loot", 1 );
    self notify( #"currentContextualTipCompleted" );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 1
// Checksum 0x17db8c1e, Offset: 0x2c3
// Size: 0x31
function function_2f7e8aea3e552c46( data )
{
    if ( isdefined( data.player ) )
    {
        data.player notify( #"hash_9b7aa9f938e78248" );
    }
}

// Namespace namespace_44e68768d1d1a5d6
// Params 1
// Checksum 0x6d8311e0, Offset: 0x2fc
// Size: 0x52, Type: bool
function function_b40e6af1bca2e1c1( params )
{
    if ( self.var_748dffc202f20964 && ftue_player::ftue_player_onground() )
    {
        lootcache = ftue_loot_cache::function_e46704b4fc80a964( 1500 );
        self.var_11133cb0607b498f.closestlootcrate = lootcache;
        return isdefined( lootcache );
    }
    
    return false;
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0x1da1eff8, Offset: 0x357
// Size: 0x28
function function_15e8c2db227acfab()
{
    ftue_tip::function_c9cca7ed21647155( #"open_inventory" );
    childthread ftue_utility::function_2623dccd6b2677cc( self, 30 );
    ftue_inventory::function_3fe39e89019f53d1( &function_de77cd3dee49657c );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0x22586495, Offset: 0x387
// Size: 0x4b
function function_5a5268fd00fbd788()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"backpack_item", player, item );
        player namespace_44e8cefed76aa88e::function_5d5fef02540a4a39( #"inventory" );
    }
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0x65c1ed90, Offset: 0x3da
// Size: 0x17
function function_de77cd3dee49657c()
{
    ftue_tip::function_e1b6c8c6f8f3dc45( 1 );
    self notify( #"currentContextualTipCompleted" );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0x80ec55f3, Offset: 0x3f9
// Size: 0x28
function function_1c6c6e87122d0c9()
{
    ftue_tip::function_c9cca7ed21647155( #"open_map" );
    childthread ftue_utility::function_2623dccd6b2677cc( self, 30 );
    childthread ftue_player::function_ae0296f83b974598( &function_1c6c3e87122ca30 );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0xeeeddb46, Offset: 0x429
// Size: 0x16
function function_1c6c3e87122ca30()
{
    ftue_utility::function_b342342ac1cbac2e( self );
    childthread ftue_player::function_257c9575891b6d7d( &function_1c6c4e87122cc63 );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0xca0781db, Offset: 0x447
// Size: 0x21
function function_1c6c4e87122cc63()
{
    wait 0.5;
    ftue_tip::function_e1b6c8c6f8f3dc45( 1 );
    function_9113b00af78e55ee( #"ping_map" );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 1
// Checksum 0xa8c9b8ab, Offset: 0x470
// Size: 0x22, Type: bool
function function_bad2eaf0cf5510a0( params )
{
    return level.br_circle.circleindex >= 1;
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0x37bad8ae, Offset: 0x49b
// Size: 0x33
function buystationcleanup()
{
    if ( isdefined( self.var_11133cb0607b498f.objectiveid ) )
    {
        ftue_objectives::function_ecadaaabe4a83e9b( self.var_11133cb0607b498f.objectiveid );
    }
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0xb682cc6d, Offset: 0x4d6
// Size: 0x8f
function function_a2fadcb4852edcfd()
{
    self.var_11133cb0607b498f.objectiveid = ftue_objectives::function_518a2916085fd4f8( self.var_11133cb0607b498f.currentbuystation.origin, &"ftue_br/open", "icon_ping_ftue_waypoint", 40, self );
    childthread ftue_buy_station::function_24ecaedc04ead4df( &function_a2fad9b4852ed664 );
    wait 3;
    
    if ( !self.var_11133cb0607b498f.buystationopened )
    {
        ftue_tip::function_c9cca7ed21647155( #"buy_station" );
        childthread ftue_utility::function_2623dccd6b2677cc( self, 60, &buystationcleanup );
    }
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0xbdec31e8, Offset: 0x56d
// Size: 0x33
function function_a2fad9b4852ed664()
{
    ftue_utility::function_b342342ac1cbac2e( self );
    self.var_11133cb0607b498f.buystationopened = 1;
    buystationcleanup();
    childthread ftue_buy_station::function_41412941194cd7c9( &function_578cc4c7feba9c29 );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0x7630adf7, Offset: 0x5a8
// Size: 0x21
function function_578cc4c7feba9c29()
{
    wait 0.5;
    ftue_tip::function_e1b6c8c6f8f3dc45( 1 );
    function_9113b00af78e55ee( #"purchase_item" );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 1
// Checksum 0xc95b4657, Offset: 0x5d1
// Size: 0x3b, Type: bool
function function_505083ed8776ba06( params )
{
    if ( !self.var_748dffc202f20964 )
    {
        return false;
    }
    
    if ( !ftue_cash::function_70958f50260d2af8( 2000 ) )
    {
        return false;
    }
    
    if ( !namespace_727c07157c884ff5::function_ab3300532cd9a40f( 1500 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0xf113cf04, Offset: 0x615
// Size: 0x46
function function_6007f889a2f1ca7c()
{
    ftue_tip::function_c9cca7ed21647155( #"armor" );
    childthread ftue_utility::function_2623dccd6b2677cc( self, 20 );
    self waittill( #"armor_plate_inserted" );
    ftue_utility::function_b342342ac1cbac2e( self );
    ftue_tip::function_e1b6c8c6f8f3dc45( 1 );
    self notify( #"currentContextualTipCompleted" );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 1
// Checksum 0x7c4c5761, Offset: 0x663
// Size: 0x14
function function_7469a2b459512969( params )
{
    return namespace_727c07157c884ff5::function_76f44af8b032d0b0( params );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0xebf72886, Offset: 0x680
// Size: 0x1c
function loadoutdropcleanup()
{
    ftue_objectives::function_ecadaaabe4a83e9b( self.var_11133cb0607b498f.objectiveid );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0x927957f3, Offset: 0x6a4
// Size: 0xeb
function function_ecb4cfeeea0f2e66()
{
    ftue_tip::function_c9cca7ed21647155( #"loadout_drop" );
    loadoutdrop = self.var_11133cb0607b498f.currentloadoutdrop;
    assert( isdefined( loadoutdrop ) );
    self.var_11133cb0607b498f.objectiveid = ftue_objectives::function_518a2916085fd4f8( loadoutdrop.origin + ( 0, 0, 67 ), &"ftue_br/open", "icon_ping_ftue_waypoint", 10, self );
    self.var_11133cb0607b498f.var_9ea5acf43d8dd30 = #"loadout_drop";
    childthread ftue_loadout::function_c1609cabe21411c7( &function_9ec007675d31b979 );
    wait 4;
    
    if ( isdefined( self.var_11133cb0607b498f.var_9ea5acf43d8dd30 ) )
    {
        ftue_tip::function_e1b6c8c6f8f3dc45( 1 );
        ftue_tip::function_c9cca7ed21647155( #"loadout_equip" );
        childthread ftue_utility::function_2623dccd6b2677cc( self, 60, &loadoutdropcleanup );
    }
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0xd07b72f6, Offset: 0x797
// Size: 0x9
function function_9ec007675d31b979()
{
    function_ecb4ceeeea0f2c33();
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0xe2274ad1, Offset: 0x7a8
// Size: 0x29
function function_ecb4ceeeea0f2c33()
{
    childthread ftue_loadout::function_1d0412b603b07201( &function_2db75c7789f35cf3 );
    self.var_11133cb0607b498f.var_9ea5acf43d8dd30 = undefined;
    ftue_utility::function_b342342ac1cbac2e( self );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 1
// Checksum 0xe984dc51, Offset: 0x7d9
// Size: 0x32
function function_2db75c7789f35cf3( classid )
{
    loadoutdropcleanup();
    wait 0.5;
    ftue_tip::function_e1b6c8c6f8f3dc45( 1 );
    function_9113b00af78e55ee( #"loadout_info" );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 1
// Checksum 0x12aae89c, Offset: 0x813
// Size: 0x2c, Type: bool
function function_4b7b04c28bcd5e0f( params )
{
    if ( !self.var_748dffc202f20964 )
    {
        return false;
    }
    
    if ( !namespace_727c07157c884ff5::function_40e1fe3b16a91e72( 1500 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0x24b47d82, Offset: 0x848
// Size: 0x1c
function contractcleanup()
{
    ftue_objectives::function_ecadaaabe4a83e9b( self.var_11133cb0607b498f.objectiveid );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0xfad176e2, Offset: 0x86c
// Size: 0x16f
function function_de7f57a58497cb73()
{
    ftue_tip::function_c9cca7ed21647155( #"contract" );
    tablet = self.var_11133cb0607b498f.var_97de1c9c7b4a8d85;
    self.var_11133cb0607b498f.objectiveid = ftue_objectives::function_518a2916085fd4f8( tablet.origin, &"ftue_br/pickup", "icon_ping_ftue_waypoint", 30, self );
    childthread ftue_utility::function_2623dccd6b2677cc( self, 60, &contractcleanup );
    tablet waittill( #"onTabletHidden" );
    ftue_utility::function_b342342ac1cbac2e( self );
    success = 0;
    
    if ( tablet.task.var_fe0156f1cf4e5f41 == self )
    {
        success = 1;
    }
    else
    {
        checkteam = self.team;
        
        foreach ( team in tablet.task.teams )
        {
            if ( team == checkteam )
            {
                success = 1;
                break;
            }
        }
    }
    
    contractcleanup();
    ftue_tip::function_e1b6c8c6f8f3dc45( success );
    self notify( #"currentContextualTipCompleted" );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 1
// Checksum 0xa29af517, Offset: 0x9e3
// Size: 0x57, Type: bool
function function_b390b4db4291a3e4( params )
{
    if ( !ftue_movement::function_b637614feabc055f() || !isdefined( level.contractmanager ) )
    {
        return false;
    }
    
    tablet = br_contract_manager::function_12bf8ec6b4419503( 1000000 );
    self.var_11133cb0607b498f.var_97de1c9c7b4a8d85 = tablet;
    return isdefined( tablet );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0x590f4531, Offset: 0xa43
// Size: 0x12
function function_55d2c5926889dd5a()
{
    function_9113b00af78e55ee( #"gas_close" );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 1
// Checksum 0x78ebc467, Offset: 0xa5d
// Size: 0x5a, Type: bool
function function_ed5db8d44e66b0e1( params )
{
    if ( level.br_circle.circleindex < 0 )
    {
        return false;
    }
    
    if ( !ftue_movement::function_b637614feabc055f() )
    {
        return false;
    }
    
    var_36503055e0de9238 = ftue_player::function_d535c191247aa7b8();
    
    if ( !isdefined( var_36503055e0de9238 ) )
    {
        return false;
    }
    
    if ( var_36503055e0de9238 >= 2000 )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0x785f8108, Offset: 0xac0
// Size: 0x12
function function_2cae950dde3c313b()
{
    function_9113b00af78e55ee( #"gas_avoid" );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 1
// Checksum 0xfecde428, Offset: 0xada
// Size: 0x3a, Type: bool
function function_1cea7fac78a24de4( params )
{
    if ( level.br_circle.circleindex < 0 )
    {
        return false;
    }
    
    if ( !ftue_movement::function_b637614feabc055f() )
    {
        return false;
    }
    
    return ftue_player::function_3d0a8e295d333a2e() == 0;
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0xce22fdcc, Offset: 0xb1d
// Size: 0x12
function function_46355408a8f5b396()
{
    function_9113b00af78e55ee( #"gas_mask" );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0x46bc631d, Offset: 0xb37
// Size: 0x8d
function function_da96c8389f9e70b4()
{
    self endon( #"currentContextualTipCompleted" );
    self endon( #"currentContextualTipAborted" );
    ftue_tip::function_c9cca7ed21647155( #"buy_back" );
    self.var_11133cb0607b498f.objectiveid = ftue_objectives::function_518a2916085fd4f8( self.var_11133cb0607b498f.currentbuystation.origin, &"ftue_br/open", "icon_ping_ftue_waypoint", 40, self );
    childthread ftue_utility::function_2623dccd6b2677cc( self, 60, &function_b280a9abfc9d2aab );
    childthread ftue_buy_station::function_baf3585c71fae0de( &function_da96cb389f9e774d );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0x37adca31, Offset: 0xbcc
// Size: 0x1e
function function_da96cb389f9e774d()
{
    function_b280a9abfc9d2aab();
    ftue_tip::function_e1b6c8c6f8f3dc45( 1 );
    self notify( #"currentContextualTipCompleted" );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0x71b514ef, Offset: 0xbf2
// Size: 0x1c
function function_b280a9abfc9d2aab()
{
    ftue_objectives::function_ecadaaabe4a83e9b( self.var_11133cb0607b498f.objectiveid );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 1
// Checksum 0x55f348d2, Offset: 0xc16
// Size: 0x64, Type: bool
function function_d11df06dfc63beb1( params )
{
    if ( !self.var_748dffc202f20964 )
    {
        return false;
    }
    
    deadally = namespace_727c07157c884ff5::function_217acc5fadb2a0aa();
    
    if ( !isdefined( deadally ) )
    {
        return false;
    }
    
    if ( ftue_player::function_de7cca2ef9bc611c( self, deadally ) )
    {
        return false;
    }
    
    if ( !ftue_cash::function_70958f50260d2af8( 3000 ) )
    {
        return false;
    }
    
    if ( !namespace_727c07157c884ff5::function_ab3300532cd9a40f( 1500 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0x561a095a, Offset: 0xc83
// Size: 0x12
function function_34d363d56476b073()
{
    function_9113b00af78e55ee( #"gulag_info" );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 1
// Checksum 0xe7fd28b5, Offset: 0xc9d
// Size: 0xe, Type: bool
function function_d6f4feada417e0fe( params )
{
    return true;
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0xb792742d, Offset: 0xcb4
// Size: 0x12
function function_6a3a2553dd4806d6()
{
    function_9113b00af78e55ee( #"cash_info" );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 1
// Checksum 0x3b8f2af5, Offset: 0xcce
// Size: 0x88
function function_b0dfe7e288492637( alive )
{
    ftue_utility::function_b342342ac1cbac2e( self );
    currenttime = gettime();
    delta = currenttime - self.var_11133cb0607b498f.var_ea7a9a5f149178ed;
    
    if ( delta < 2000 )
    {
        wait ( 2000 - delta ) / 1000;
    }
    
    if ( alive )
    {
        ftue_tip::function_953a5a3682bc5957();
        self notify( #"currentContextualTipAborted" );
        return;
    }
    
    ftue_tip::function_e1b6c8c6f8f3dc45( 1 );
    self notify( #"currentContextualTipCompleted" );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0xbe4d6898, Offset: 0xd5e
// Size: 0xd2
function function_b0dfe8e28849286a()
{
    ftue_tip::function_c9cca7ed21647155( #"enemy_downed" );
    downedenemy = undefined;
    
    foreach ( enemy in self.nearbyenemies )
    {
        if ( enemy.inlaststand )
        {
            downedenemy = enemy;
            break;
        }
    }
    
    self.var_11133cb0607b498f.var_ea7a9a5f149178ed = gettime();
    childthread ftue_utility::function_2623dccd6b2677cc( self, 30 );
    childthread ftue_player::function_364f4b1bdc00e78b( downedenemy, &function_b0dfe7e288492637 );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 1
// Checksum 0xb33fa220, Offset: 0xe38
// Size: 0x12
function function_b6ed34fdf8814f4b( params )
{
    return namespace_727c07157c884ff5::function_c04cf3b0a1df4691();
}

// Namespace namespace_44e68768d1d1a5d6
// Params 1
// Checksum 0x6b7f3577, Offset: 0xe53
// Size: 0x44
function function_426acdc7a58d5c37( alive )
{
    ftue_utility::function_b342342ac1cbac2e( self );
    
    if ( alive )
    {
        ftue_tip::function_e1b6c8c6f8f3dc45( 1 );
        self notify( #"currentContextualTipCompleted" );
        return;
    }
    
    ftue_tip::function_953a5a3682bc5957();
    self notify( #"currentContextualTipAborted" );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0x7272c7fe, Offset: 0xe9f
// Size: 0xba
function function_426acec7a58d5e6a()
{
    ftue_tip::function_c9cca7ed21647155( #"revive_ally" );
    reviveally = undefined;
    
    foreach ( ally in self.nearbyallies )
    {
        if ( ally.inlaststand )
        {
            reviveally = ally;
            break;
        }
    }
    
    childthread ftue_utility::function_2623dccd6b2677cc( self, 30 );
    ftue_player::function_364f4b1bdc00e78b( reviveally, &function_426acdc7a58d5c37 );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 1
// Checksum 0x25153989, Offset: 0xf61
// Size: 0x12
function function_a94d2d2d51fa7c9( params )
{
    return namespace_727c07157c884ff5::function_616b36694e0a4d5();
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0x58ccee37, Offset: 0xf7c
// Size: 0x63
function function_cc6dcd39e3bfeeb9()
{
    didslide = 0;
    diddive = 0;
    
    while ( true )
    {
        wait 0.5;
        
        if ( self issprintsliding() )
        {
            didslide = 1;
        }
        
        if ( self isdiving() )
        {
            diddive = 1;
        }
        
        if ( didslide && diddive )
        {
            break;
        }
    }
    
    ftue_tip::function_e1b6c8c6f8f3dc45( 1 );
    self notify( #"currentContextualTipCompleted" );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0x39267803, Offset: 0xfe7
// Size: 0x19
function function_9fccfef2c76a3d50()
{
    childthread function_9113b00af78e55ee( #"movement" );
    childthread function_cc6dcd39e3bfeeb9();
}

// Namespace namespace_44e68768d1d1a5d6
// Params 1
// Checksum 0xf13c4b18, Offset: 0x1008
// Size: 0x34, Type: bool
function function_72895e0151a7e65f( params )
{
    if ( !self.var_748dffc202f20964 )
    {
        return false;
    }
    
    if ( !self issprinting() )
    {
        return false;
    }
    
    if ( !ftue_movement::function_b637614feabc055f() )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0xd0f026bd, Offset: 0x1045
// Size: 0x31
function function_dfacd7df14e94d20()
{
    while ( true )
    {
        wait 1;
        
        if ( !self isswimming() )
        {
            break;
        }
    }
    
    ftue_tip::function_e1b6c8c6f8f3dc45( 1 );
    self notify( #"currentContextualTipCompleted" );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0xf4569fb4, Offset: 0x107e
// Size: 0x19
function function_8ad2aa2207e163a8()
{
    childthread function_9113b00af78e55ee( #"swimming" );
    childthread function_dfacd7df14e94d20();
}

// Namespace namespace_44e68768d1d1a5d6
// Params 1
// Checksum 0x109f68dd, Offset: 0x109f
// Size: 0x25, Type: bool
function function_512b2c1304a42d13( params )
{
    if ( !namespace_727c07157c884ff5::function_6471b7a984eb7e87() )
    {
        return false;
    }
    
    if ( !self isswimming() )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0x1b64a709, Offset: 0x10cd
// Size: 0x12
function function_e93aeaf085511858()
{
    function_9113b00af78e55ee( #"perk_pack" );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0xbf758668, Offset: 0x10e7
// Size: 0x12
function function_7225860b161daa0a()
{
    function_9113b00af78e55ee( #"armor_vest" );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0x3e78b898, Offset: 0x1101
// Size: 0x2d
function function_2c75a06270b84176()
{
    ftue_tip::function_c9cca7ed21647155( #"false_flag" );
    wait 5;
    ftue_tip::function_e1b6c8c6f8f3dc45( 1 );
    self notify( #"currentContextualTipCompleted" );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0xe740a3d6, Offset: 0x1136
// Size: 0x12
function function_3f7367749c067bb1()
{
    function_9113b00af78e55ee( #"hvlz" );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 1
// Checksum 0x10b5d02e, Offset: 0x1150
// Size: 0x35, Type: bool
function function_e2aa62faf61d0172( params )
{
    hotzones = function_e2a061fcb85d84b5();
    isonground = ftue_movement::function_b637614feabc055f();
    return isonground && hotzones.size;
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0x51eaeaff, Offset: 0x118e
// Size: 0x85
function function_ab9c7c897605a051()
{
    starttime = gettime();
    ftue_tip::function_c9cca7ed21647155( #"sprint" );
    childthread ftue_utility::function_2623dccd6b2677cc( self, 20 );
    
    while ( true )
    {
        if ( self issprinting() )
        {
            break;
        }
        
        waitframe();
    }
    
    currenttime = gettime();
    delta = currenttime - starttime;
    
    if ( delta < 2000 )
    {
        wait ( 2000 - delta ) / 1000;
    }
    
    ftue_tip::function_e1b6c8c6f8f3dc45( 1 );
    self notify( #"currentContextualTipCompleted" );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 1
// Checksum 0x2bb0929d, Offset: 0x121b
// Size: 0x3f, Type: bool
function function_e74bbb2e536cec42( params )
{
    if ( !self.var_748dffc202f20964 )
    {
        return false;
    }
    
    vel = self getvelocity();
    
    if ( length2dsquared( vel ) == 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0xeaf34795, Offset: 0x1263
// Size: 0x12
function function_ac85f6b6f4b1c457()
{
    function_9113b00af78e55ee( #"controls" );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 1
// Checksum 0x46692446, Offset: 0x127d
// Size: 0x16, Type: bool
function function_ef247399120b8628( params )
{
    return istrue( self.var_748dffc202f20964 );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0xd0fbd73c, Offset: 0x129c
// Size: 0x12
function function_6351cb9a97bc5363()
{
    function_9113b00af78e55ee( #"train_controls" );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 1
// Checksum 0xec8e465e, Offset: 0x12b6
// Size: 0xc8, Type: bool
function function_655dbd39bdca1172( params )
{
    if ( utility::callsharedfunc( #"br_movingtrain_control", #"hash_7db603b46356b014" ) )
    {
        foreach ( train in level.wztrain_info.trains )
        {
            if ( distancesquared( self.origin, train[ 0 ].origin ) <= 1000000 )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0xa9286ea4, Offset: 0x1387
// Size: 0x12
function function_4e24335ca30b4bf1()
{
    function_9113b00af78e55ee( #"driving_gas" );
}

// Namespace namespace_44e68768d1d1a5d6
// Params 1
// Checksum 0x8119b00f, Offset: 0x13a1
// Size: 0xd, Type: bool
function condnever( params )
{
    return false;
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0x996aed28, Offset: 0x13b7
// Size: 0x15
function function_96e54646554bf124()
{
    self notify( #"hash_af585851b7d481d0" );
    namespace_44e8cefed76aa88e::function_3a9798f980a93566();
}

// Namespace namespace_44e68768d1d1a5d6
// Params 0
// Checksum 0xb4986451, Offset: 0x13d4
// Size: 0xc8
function function_8ec5da1736d6205d()
{
    self endon( #"disconnect" );
    self endon( #"hash_44f28431f45beba6" );
    
    while ( true )
    {
        self waittill( #"looted_item", lootid, quantity, bautouse );
        
        if ( isdefined( lootid ) )
        {
            scriptablename = loot::getScriptableFromLootID( lootid );
            
            if ( !isdefined( scriptablename ) )
            {
                continue;
            }
            
            if ( br_pickups::isgasmask( scriptablename ) )
            {
                namespace_44e8cefed76aa88e::function_5d5fef02540a4a39( #"gasmask" );
                continue;
            }
            
            if ( br_pickups::isperkpack( scriptablename ) )
            {
                namespace_44e8cefed76aa88e::function_5d5fef02540a4a39( #"perkpack" );
                continue;
            }
            
            if ( br_public::function_d115f1547e28f0c6( scriptablename ) )
            {
                namespace_44e8cefed76aa88e::function_5d5fef02540a4a39( #"armorvest" );
            }
        }
    }
}

// Namespace namespace_44e68768d1d1a5d6
// Params 2
// Checksum 0xc5fd5f95, Offset: 0x14a4
// Size: 0x24
function playertriggercallback( player_action, params )
{
    if ( !isdefined( self.var_11133cb0607b498f ) )
    {
        return;
    }
}

