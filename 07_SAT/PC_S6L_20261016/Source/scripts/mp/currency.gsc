// scripts\mp\currency.gsc  (hash_3a9d7a7cfee99885.gscc) (size: 10429 Bytes / 0x28bd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6180dbc1 (1635834817)
// size ...... 10429 (0x28bd)
// includes .. 3   (offset: 0x26ed)
// strings ... 12  (offset: 0x2705)
// dev strs .. 20  (offset: 0x27c1)
// exports ... 38  (offset: 0x1ac5)
// cseg ...... 0x11b + 0x19aa (0x1ac5)
// imports ... 46  (offset: 0x20b5)
// animtree1 . 0   (offset: 0x28bd)
// animtree2 . 0   (offset: 0x28bd)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;

#namespace currency;

// Namespace currency
// Params 0
// Checksum 0x8d59143d, Offset: 0x139
// Size: 0x11
function init_currency()
{
    function_1ab28d77783bb703();
    level thread init_currency_post_main();
}

// Namespace currency
// Params 0
// Checksum 0xed3c3aa4, Offset: 0x152
// Size: 0x3
function init_currency_post_main()
{
    waitframe();
}

// Namespace currency
// Params 0
// Checksum 0x925c48ac, Offset: 0x15d
// Size: 0x318
function function_1ab28d77783bb703()
{
    if ( ( isdefined( level.gametypebundle.pricelist ) || isdefined( level.gametypebundle.pricelistoverride ) || isdefined( level.gamemodebundle.pricelist ) ) && !isdefined( level.var_6a9a156c553a5fc2 ) )
    {
        if ( isdefined( level.gametypebundle.pricelistoverride ) )
        {
            level.var_6a9a156c553a5fc2 = getscriptbundle( "pricelist:" + level.gametypebundle.pricelistoverride );
        }
        else
        {
            level.var_6a9a156c553a5fc2 = getscriptbundle( "pricelist:" + level.gamemodebundle.pricelist );
        }
        
        level.var_6a9a156c553a5fc2.var_fea86f3cca51bbd1 = [];
        level.var_6a9a156c553a5fc2.var_a2ace489693274aa = [];
        assert( isdefined( level.var_6a9a156c553a5fc2.startcurrencies ), "<dev string:x24>" + level.gamemodebundle.pricelist + "<dev string:x43>" );
        
        foreach ( s_start_currency in level.var_6a9a156c553a5fc2.startcurrencies )
        {
            if ( !isdefined( level.var_6a9a156c553a5fc2.var_fea86f3cca51bbd1[ s_start_currency.var_6ad697fcf31696bd ] ) )
            {
                level.var_6a9a156c553a5fc2.var_fea86f3cca51bbd1[ s_start_currency.var_6ad697fcf31696bd ] = getscriptbundle( "currency:" + s_start_currency.var_6ad697fcf31696bd );
            }
        }
        
        foreach ( var_99d96192f08a7852 in level.var_6a9a156c553a5fc2.var_6d57fe60a29cffc6 )
        {
            if ( isdefined( var_99d96192f08a7852.var_1f8b0a4fc895be4a ) && isdefined( var_99d96192f08a7852.var_a1973d13374bd69e ) )
            {
                level.var_6a9a156c553a5fc2.var_a2ace489693274aa[ var_99d96192f08a7852.var_1f8b0a4fc895be4a ] = spawnstruct();
                level.var_6a9a156c553a5fc2.var_a2ace489693274aa[ var_99d96192f08a7852.var_1f8b0a4fc895be4a ].value = var_99d96192f08a7852.var_a1973d13374bd69e;
                level.var_6a9a156c553a5fc2.var_a2ace489693274aa[ var_99d96192f08a7852.var_1f8b0a4fc895be4a ].currency = var_99d96192f08a7852.var_b60e4cb0347ea4a;
            }
        }
    }
}

// Namespace currency
// Params 0
// Checksum 0x48af2f48, Offset: 0x47d
// Size: 0xb
function function_87fbe1244fd5eddd()
{
    return level.var_6a9a156c553a5fc2;
}

// Namespace currency
// Params 1
// Checksum 0xf4bd017b, Offset: 0x491
// Size: 0x22
function get_currency_bundle( str_currency_asset_name )
{
    return level.var_6a9a156c553a5fc2.var_fea86f3cca51bbd1[ str_currency_asset_name ];
}

// Namespace currency
// Params 1
// Checksum 0xf611d576, Offset: 0x4bc
// Size: 0xf9
function get_start_currency_amount( str_currency )
{
    if ( isdefined( level.var_6a9a156c553a5fc2 ) && isdefined( level.var_6a9a156c553a5fc2.startcurrencies ) )
    {
        foreach ( s_start_currency in level.var_6a9a156c553a5fc2.startcurrencies )
        {
            if ( isdefined( s_start_currency.var_6ad697fcf31696bd ) && level.var_6a9a156c553a5fc2.var_fea86f3cca51bbd1[ s_start_currency.var_6ad697fcf31696bd ].currencyname == str_currency )
            {
                return ( s_start_currency.var_2ebb7efc52363759 ?? 0 );
            }
        }
    }
}

// Namespace currency
// Params 1
// Checksum 0xf7bbf476, Offset: 0x5bd
// Size: 0x22
function function_9f81e184afb4d72b( str_item_ref )
{
    return level.var_6a9a156c553a5fc2.var_a2ace489693274aa[ str_item_ref ];
}

// Namespace currency
// Params 1
// Checksum 0xc65ca34d, Offset: 0x5e8
// Size: 0x33
function get_perk_machine_cost( str_perk )
{
    s_perk_machine_info = function_5601f3f2a935b26c( str_perk );
    
    if ( !isdefined( s_perk_machine_info ) )
    {
        return;
    }
    
    return s_perk_machine_info.perkmachinecost;
}

// Namespace currency
// Params 1
// Checksum 0x2b042227, Offset: 0x624
// Size: 0xad
function get_perk_machine_currency( str_perk )
{
    s_perk_machine_info = function_5601f3f2a935b26c( str_perk );
    
    if ( !isdefined( s_perk_machine_info ) )
    {
        return #"essence";
    }
    else if ( isdefined( s_perk_machine_info.perkmachinecurrency ) )
    {
        var_f2a6b751461c5334 = get_currency_bundle( s_perk_machine_info.perkmachinecurrency );
        return var_f2a6b751461c5334.currencyname;
    }
    
    println( "<dev string:x87>" + level.gamemodebundle.pricelist + "<dev string:xc7>" + str_perk + "<dev string:xcd>" + #"essence" );
    return #"essence";
}

// Namespace currency
// Params 1, eflags: 0x4
// Checksum 0x7f811f72, Offset: 0x6da
// Size: 0xe1
function private function_5601f3f2a935b26c( str_perk )
{
    var_7a97e315e1f0ab3e = function_87fbe1244fd5eddd();
    
    if ( isdefined( var_7a97e315e1f0ab3e ) && isdefined( var_7a97e315e1f0ab3e.var_5a1bb8415a6b535 ) )
    {
        foreach ( var_7dd82a78763cb7ed in var_7a97e315e1f0ab3e.var_5a1bb8415a6b535 )
        {
            if ( var_7dd82a78763cb7ed.perkmachinename == str_perk )
            {
                return var_7dd82a78763cb7ed;
            }
        }
        
        println( "<dev string:xde>" + level.gamemodebundle.pricelist + "<dev string:xc7>" + str_perk );
    }
}

// Namespace currency
// Params 0
// Checksum 0x9f6256ba, Offset: 0x7c3
// Size: 0xa2
function get_magicbox_cost()
{
    if ( !isdefined( level.gamemodebundle.pricelist ) && !isdefined( level.gametypebundle.pricelistoverride ) )
    {
        return;
    }
    
    var_7a97e315e1f0ab3e = function_87fbe1244fd5eddd();
    
    if ( isdefined( var_7a97e315e1f0ab3e ) && !isdefined( var_7a97e315e1f0ab3e.mysteryboxcost ) )
    {
        var_7a97e315e1f0ab3e.mysteryboxcost = 0;
    }
    
    assert( isdefined( var_7a97e315e1f0ab3e.mysteryboxcost ), "<dev string:x11b>" + level.gamemodebundle.pricelist );
    return var_7a97e315e1f0ab3e.mysteryboxcost;
}

// Namespace currency
// Params 0
// Checksum 0x8cb83a4c, Offset: 0x86e
// Size: 0x65
function get_magicbox_cost_firesale()
{
    if ( !isdefined( level.gamemodebundle.pricelist ) )
    {
        return;
    }
    
    var_7a97e315e1f0ab3e = function_87fbe1244fd5eddd();
    assert( isdefined( var_7a97e315e1f0ab3e.var_86861ebcacd35236 ), "<dev string:x13a>" + level.gamemodebundle.pricelist );
    return var_7a97e315e1f0ab3e.var_86861ebcacd35236;
}

// Namespace currency
// Params 0
// Checksum 0xa4138957, Offset: 0x8dc
// Size: 0x65
function function_f65547095e98ea22()
{
    if ( !isdefined( level.gamemodebundle.pricelist ) )
    {
        return;
    }
    
    var_7a97e315e1f0ab3e = function_87fbe1244fd5eddd();
    assert( isdefined( var_7a97e315e1f0ab3e.var_2165943790ea2cdf ), "<dev string:x13a>" + level.gamemodebundle.pricelist );
    return var_7a97e315e1f0ab3e.var_2165943790ea2cdf;
}

// Namespace currency
// Params 0
// Checksum 0x383672b5, Offset: 0x94a
// Size: 0xa8
function get_magicbox_currency()
{
    if ( !isdefined( level.gamemodebundle.pricelist ) && !isdefined( level.gametypebundle.pricelistoverride ) )
    {
        return;
    }
    
    var_7a97e315e1f0ab3e = function_87fbe1244fd5eddd();
    var_f2a6b751461c5334 = get_currency_bundle( var_7a97e315e1f0ab3e.mysteryboxcurrency );
    assert( isdefined( var_7a97e315e1f0ab3e.mysteryboxcurrency ) && isdefined( var_f2a6b751461c5334.currencyname ), "<dev string:x163>" + level.gamemodebundle.pricelist );
    return var_f2a6b751461c5334.currencyname;
}

// Namespace currency
// Params 0
// Checksum 0x458d132, Offset: 0x9fb
// Size: 0x8b
function get_gunbench_cost()
{
    if ( !isdefined( level.gamemodebundle.pricelist ) )
    {
        return;
    }
    
    var_7a97e315e1f0ab3e = function_87fbe1244fd5eddd();
    
    if ( isdefined( var_7a97e315e1f0ab3e ) && !isdefined( var_7a97e315e1f0ab3e.var_89e3779bf06228e ) )
    {
        var_7a97e315e1f0ab3e.var_89e3779bf06228e = 3000;
    }
    
    assert( isdefined( var_7a97e315e1f0ab3e.var_89e3779bf06228e ), "<dev string:x185>" + level.gamemodebundle.pricelist );
    return var_7a97e315e1f0ab3e.var_89e3779bf06228e;
}

// Namespace currency
// Params 0
// Checksum 0x44088fc9, Offset: 0xa8f
// Size: 0x8f
function get_gunbench_currency()
{
    if ( !isdefined( level.gamemodebundle.pricelist ) )
    {
        return;
    }
    
    var_7a97e315e1f0ab3e = function_87fbe1244fd5eddd();
    var_f2a6b751461c5334 = get_currency_bundle( var_7a97e315e1f0ab3e.gunbenchcurrency );
    assert( isdefined( var_7a97e315e1f0ab3e.gunbenchcurrency ) && isdefined( var_f2a6b751461c5334.currencyname ), "<dev string:x1ab>" + level.gamemodebundle.pricelist );
    return var_f2a6b751461c5334.currencyname;
}

// Namespace currency
// Params 1, eflags: 0x4
// Checksum 0xcacaa847, Offset: 0xb27
// Size: 0xf4
function private function_abdf264f64680a06( var_df3ae7416ed41f4c )
{
    if ( !isdefined( var_df3ae7416ed41f4c ) )
    {
        return;
    }
    
    var_df3ae7416ed41f4c = tolower( var_df3ae7416ed41f4c );
    
    if ( !isdefined( level.gamemodebundle.pricelist ) )
    {
        return;
    }
    
    var_7a97e315e1f0ab3e = function_87fbe1244fd5eddd();
    
    if ( isdefined( var_7a97e315e1f0ab3e ) && isdefined( var_7a97e315e1f0ab3e.var_aa7c2ec2dfbcf89c ) )
    {
        foreach ( var_b8e2a21e1cc48a4b in var_7a97e315e1f0ab3e.var_aa7c2ec2dfbcf89c )
        {
            if ( isdefined( var_b8e2a21e1cc48a4b.var_1c15a1c0f3344616 ) && tolower( var_b8e2a21e1cc48a4b.var_1c15a1c0f3344616 ) == var_df3ae7416ed41f4c )
            {
                return var_b8e2a21e1cc48a4b;
            }
        }
    }
}

// Namespace currency
// Params 1
// Checksum 0xfcc6a40a, Offset: 0xc23
// Size: 0x33
function function_ec2513654311fb07( var_df3ae7416ed41f4c )
{
    var_b8e2a21e1cc48a4b = function_abdf264f64680a06( var_df3ae7416ed41f4c );
    
    if ( !isdefined( var_b8e2a21e1cc48a4b ) )
    {
        return;
    }
    
    return var_b8e2a21e1cc48a4b.var_df3da4c7c0bb508;
}

// Namespace currency
// Params 1
// Checksum 0xd7beb002, Offset: 0xc5f
// Size: 0x33
function function_fafed3d425170577( var_df3ae7416ed41f4c )
{
    var_b8e2a21e1cc48a4b = function_abdf264f64680a06( var_df3ae7416ed41f4c );
    
    if ( !isdefined( var_b8e2a21e1cc48a4b ) )
    {
        return;
    }
    
    return var_b8e2a21e1cc48a4b.var_dfe4d823a70dc93;
}

// Namespace currency
// Params 1
// Checksum 0x958f9847, Offset: 0xc9b
// Size: 0x93
function function_2570aaa28fdae0ad( var_df3ae7416ed41f4c )
{
    var_b8e2a21e1cc48a4b = function_abdf264f64680a06( var_df3ae7416ed41f4c );
    
    if ( !isdefined( var_b8e2a21e1cc48a4b ) )
    {
        return;
    }
    
    var_f2a6b751461c5334 = get_currency_bundle( var_b8e2a21e1cc48a4b.var_3de64a8d5d2f4ca6 );
    assert( isdefined( var_b8e2a21e1cc48a4b.var_3de64a8d5d2f4ca6 ) && isdefined( var_f2a6b751461c5334.currencyname ), "<dev string:x1ca>" + level.gamemodebundle.pricelist + "<dev string:xc7>" + var_df3ae7416ed41f4c );
    return var_f2a6b751461c5334.currencyname;
}

// Namespace currency
// Params 7
// Checksum 0x392d027b, Offset: 0xd37
// Size: 0x190
function register_currency_type( currencytype, getfunc, setfunc, addfunc, subfunc, buysound, denysound )
{
    if ( isstring( currencytype ) )
    {
        currencytype = getxhash( currencytype );
    }
    
    if ( isdefined( level.currency[ currencytype ] ) )
    {
        assert( "<dev string:x1f1>" + currencytype + "<dev string:x1fc>" );
        return;
    }
    else if ( !isdefined( level.currency ) )
    {
        level.currency = [];
    }
    
    currencystruct = spawnstruct();
    level.currency[ currencytype ] = currencystruct;
    level.currency[ currencytype ].currencytype = currencytype;
    level.currency[ currencytype ].getfunc = getfunc;
    level.currency[ currencytype ].setfunc = setfunc;
    level.currency[ currencytype ].addfunc = addfunc;
    level.currency[ currencytype ].subfunc = subfunc;
    level.currency[ currencytype ].buysound = buysound;
    level.currency[ currencytype ].denysound = denysound;
    
    /#
        level thread setup_currency_devgui( currencytype );
    #/
    
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"give_currency", &function_e1c87ce591c8703f );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"remove_currency", &debug_remove_currency );
}

// Namespace currency
// Params 2
// Checksum 0x5d4ac248, Offset: 0xecf
// Size: 0x62
function init_player_currency( currencytype, startingamount = 0 )
{
    if ( !isplayer( self ) )
    {
        assert( "<dev string:x210>" );
        return;
    }
    
    set_currency_amount( currencytype, startingamount );
    
    if ( getdvarint( @"hash_bc19129b877ec86b", 0 ) )
    {
        thread function_2e7735ffe5fae79a( self.currency.size, currencytype );
    }
}

// Namespace currency
// Params 4
// Checksum 0xb71d6871, Offset: 0xf39
// Size: 0x124
function add_currency_amount( currencytype, amount, reason, item )
{
    if ( isstring( currencytype ) )
    {
        currencytype = getxhash( currencytype );
    }
    
    if ( !isdefined( amount ) )
    {
        assert( isdefined( amount ) );
        return;
    }
    
    originalamount = amount;
    
    if ( isdefined( level.currency[ currencytype ].addfunc ) )
    {
        self [[ level.currency[ currencytype ].addfunc ]]( amount );
    }
    else
    {
        function_9f4bd7c92079e530( amount, currencytype );
    }
    
    sparams = spawnstruct();
    sparams.originalamount = originalamount;
    sparams.currencytype = currencytype;
    sparams.amount = amount;
    sparams.reason = reason;
    
    if ( isdefined( item ) )
    {
        sparams.spawningteam = item.spawningteam;
        sparams.originalowner = item.originalowner;
    }
    
    callback::callback( "currency_add", sparams );
}

// Namespace currency
// Params 2
// Checksum 0xacc4e92, Offset: 0x1065
// Size: 0x84
function function_9f4bd7c92079e530( amount, currencytype )
{
    if ( isstring( currencytype ) )
    {
        currencytype = getxhash( currencytype );
    }
    
    currencyamount = get_currency_amount( currencytype );
    newamount = currencyamount + amount;
    
    if ( amount > 0 && newamount < currencyamount )
    {
        newamount = 2147483647;
    }
    
    if ( newamount < 0 )
    {
        newamount = 0;
    }
    
    if ( newamount > 999999 )
    {
        newamount = 999999;
    }
    
    set_currency_amount( currencytype, newamount );
}

// Namespace currency
// Params 4
// Checksum 0xa0c01780, Offset: 0x10f1
// Size: 0xfe
function function_b5fe1e05c892a7f3( currencytype, amount, reason, info )
{
    if ( isstring( currencytype ) )
    {
        currencytype = getxhash( currencytype );
    }
    
    if ( !isdefined( amount ) )
    {
        assert( isdefined( amount ) );
        return;
    }
    
    originalamount = amount;
    
    if ( isdefined( level.currency[ currencytype ].subfunc ) )
    {
        self [[ level.currency[ currencytype ].subfunc ]]( amount );
    }
    else
    {
        function_febbc9c4dd840bf9( amount, currencytype );
    }
    
    sparams = spawnstruct();
    sparams.originalamount = originalamount;
    sparams.currencytype = currencytype;
    sparams.amount = amount;
    sparams.reason = reason;
    sparams.info = info;
    callback::callback( "currency_sub", sparams );
}

// Namespace currency
// Params 2
// Checksum 0xbff2ef4, Offset: 0x11f7
// Size: 0x84
function function_febbc9c4dd840bf9( amount, currencytype )
{
    if ( isstring( currencytype ) )
    {
        currencytype = getxhash( currencytype );
    }
    
    currencyamount = get_currency_amount( currencytype );
    newamount = currencyamount - amount;
    
    if ( amount < 0 && newamount < currencyamount )
    {
        newamount = 2147483647;
    }
    
    if ( newamount < 0 )
    {
        newamount = 0;
    }
    
    if ( newamount > 999999 )
    {
        newamount = 999999;
    }
    
    set_currency_amount( currencytype, newamount );
}

// Namespace currency
// Params 3
// Checksum 0xf8f90e1a, Offset: 0x1283
// Size: 0x106
function set_currency_amount( currencytype, amount, reason )
{
    if ( isstring( currencytype ) )
    {
        currencytype = getxhash( currencytype );
    }
    
    if ( !isdefined( amount ) )
    {
        assert( isdefined( amount ) );
        return;
    }
    
    if ( amount > 999999 )
    {
        amount = 999999;
    }
    
    originalamount = amount;
    
    if ( isdefined( currencytype ) && isdefined( self.currency[ currencytype ] ) )
    {
        originalamount = self.currency[ currencytype ];
    }
    
    var_edea9c74ef8011c9 = level.currency[ currencytype ].setfunc;
    
    if ( isdefined( var_edea9c74ef8011c9 ) )
    {
        self [[ var_edea9c74ef8011c9 ]]( amount );
    }
    else
    {
        function_794c6e82017f38c3( amount, currencytype );
    }
    
    sparams = { #reason:reason, #amount:amount, #currencytype:currencytype, #originalamount:originalamount };
    callback::callback( "currency_set", sparams );
}

// Namespace currency
// Params 2
// Checksum 0x10c18fa9, Offset: 0x1391
// Size: 0x46
function function_794c6e82017f38c3( amount, currencytype )
{
    if ( isstring( currencytype ) )
    {
        currencytype = getxhash( currencytype );
    }
    
    if ( amount > 999999 )
    {
        amount = 999999;
    }
    
    self.currency[ currencytype ] = amount;
}

// Namespace currency
// Params 1
// Checksum 0xbe9bdbe5, Offset: 0x13df
// Size: 0x5c
function get_currency_amount( currencytype )
{
    if ( isstring( currencytype ) )
    {
        currencytype = getxhash( currencytype );
    }
    
    if ( isdefined( level.currency[ currencytype ].getfunc ) )
    {
        return [[ level.currency[ currencytype ].getfunc ]]();
    }
    
    return function_d47628fc4e0a8097( currencytype );
}

// Namespace currency
// Params 1
// Checksum 0xeaebb94a, Offset: 0x1443
// Size: 0x2d, Type: bool
function function_d47628fc4e0a8097( currencytype )
{
    if ( isstring( currencytype ) )
    {
        currencytype = getxhash( currencytype );
    }
    
    return self.currency[ currencytype ] ?? 0;
}

// Namespace currency
// Params 2
// Checksum 0xd06a2a4b, Offset: 0x1479
// Size: 0x52
function can_afford( currencytype, cost )
{
    if ( isstring( currencytype ) )
    {
        currencytype = getxhash( currencytype );
    }
    
    var_6e4a90cf55f64cdc = 0;
    amountonhand = get_currency_amount( currencytype );
    
    if ( cost <= amountonhand )
    {
        var_6e4a90cf55f64cdc = 1;
    }
    
    return var_6e4a90cf55f64cdc;
}

// Namespace currency
// Params 7
// Checksum 0xea7bc10d, Offset: 0x14d4
// Size: 0x154
function attempt_purchase( currencytype, cost, var_a69a10c341243ee4, var_b0e45e3c0826f9ad, reason, info, b_rumble )
{
    if ( isstring( currencytype ) )
    {
        currencytype = getxhash( currencytype );
    }
    
    if ( can_afford( currencytype, cost ) )
    {
        function_b5fe1e05c892a7f3( currencytype, cost, reason, info );
        
        if ( b_rumble && isplayer( self ) )
        {
            self playrumbleonentity( "use_interact" );
        }
        
        if ( isdefined( level.currency[ currencytype ].buysound ) && !var_a69a10c341243ee4 )
        {
            self playsoundtoplayer( level.currency[ currencytype ].buysound, self );
        }
        
        if ( !isdefined( self.pers[ "currency_spent" ] ) )
        {
            self.pers[ "currency_spent" ] = cost;
        }
        else
        {
            self.pers[ "currency_spent" ] = self.pers[ "currency_spent" ] + cost;
        }
        
        return 1;
    }
    
    if ( isdefined( level.currency[ currencytype ].denysound ) && !var_b0e45e3c0826f9ad )
    {
        self playsoundtoplayer( level.currency[ currencytype ].denysound, self );
    }
    
    return 0;
}

// Namespace currency
// Params 2
// Checksum 0x3086013b, Offset: 0x1630
// Size: 0x2d
function function_b7278fa075eb5dc4( currencytype, namestring )
{
    level.currency[ currencytype ].displayname = namestring;
}

// Namespace currency
// Params 2
// Checksum 0xcfc1c590, Offset: 0x1665
// Size: 0x266
function function_2e7735ffe5fae79a( var_64b9918b6228184b, currencytype )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    var_569a4a842916dd45 = newclienthudelem( self );
    var_569a4a842916dd45.x = -20;
    var_569a4a842916dd45.y = 380 - 15 * var_64b9918b6228184b;
    var_569a4a842916dd45.alignx = "center";
    var_569a4a842916dd45.aligny = "top";
    var_569a4a842916dd45.vertalign = "fullscreen";
    var_569a4a842916dd45.horizalign = "fullscreen";
    var_569a4a842916dd45.font = "smallfixed";
    var_569a4a842916dd45.fontscale = 0.75;
    var_6f9a7c853d557236 = newclienthudelem( self );
    var_6f9a7c853d557236.x = 60;
    var_6f9a7c853d557236.y = 380 - 15 * var_64b9918b6228184b;
    var_6f9a7c853d557236.alignx = "center";
    var_6f9a7c853d557236.aligny = "top";
    var_6f9a7c853d557236.vertalign = "fullscreen";
    var_6f9a7c853d557236.horizalign = "fullscreen";
    var_6f9a7c853d557236.font = "smallfixed";
    var_6f9a7c853d557236.fontscale = 0.75;
    
    while ( true )
    {
        if ( currencytype == #"essence" )
        {
            var_569a4a842916dd45 settext( &"shared_hintstrings/currency_hudelem_essence" );
            var_6f9a7c853d557236 setvalue( self.currency[ #"essence" ] );
        }
        else if ( currencytype == #"salvage" )
        {
            var_569a4a842916dd45 settext( &"shared_hintstrings/currency_hudelem_salvage" );
            var_6f9a7c853d557236 setvalue( self.currency[ #"salvage" ] );
        }
        else if ( currencytype == #"rare_salvage" )
        {
            var_569a4a842916dd45 settext( &"shared_hintstrings/currency_hudelem_rare_salvage" );
            var_6f9a7c853d557236 setvalue( self.currency[ #"rare_salvage" ] );
        }
        else if ( isdefined( level.currency[ currencytype ].displayname ) )
        {
            var_569a4a842916dd45 settext( level.currency[ currencytype ].displayname );
            var_6f9a7c853d557236 setvalue( self.currency[ currencytype ] );
        }
        
        waitframe();
    }
}

// Namespace currency
// Params 1
// Checksum 0x105ca43f, Offset: 0x18d3
// Size: 0xba
function function_e1c87ce591c8703f( params )
{
    currency_type = getxhash( params[ 0 ] );
    
    foreach ( player in level.players )
    {
        if ( isdefined( level.currency[ currency_type ] ) )
        {
            player add_currency_amount( currency_type, 10000 );
            continue;
        }
        
        iprintln( currency_type + " is not a valid currency in this mode" );
    }
}

// Namespace currency
// Params 1
// Checksum 0x800682ba, Offset: 0x1995
// Size: 0xba
function debug_remove_currency( params )
{
    currency_type = getxhash( params[ 0 ] );
    
    foreach ( player in level.players )
    {
        if ( isdefined( level.currency[ currency_type ] ) )
        {
            player function_b5fe1e05c892a7f3( currency_type, 10000 );
            continue;
        }
        
        iprintln( currency_type + " is not a valid currency in this mode" );
    }
}

/#

    // Namespace currency
    // Params 1
    // Checksum 0xb65a7e91, Offset: 0x1a57
    // Size: 0x6e, Type: dev
    function setup_currency_devgui( currency_type )
    {
        currencyname = getxhashsourcename( currency_type );
        devgui::function_9082edeb5db93280( "<dev string:x222>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x232>" + currencyname, "<dev string:x23c>" + currencyname, &function_e1c87ce591c8703f, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x24f>" + currencyname, "<dev string:x25b>" + currencyname, &debug_remove_currency, 0 );
        devgui::function_77df7fe7dd273e10();
    }

#/
