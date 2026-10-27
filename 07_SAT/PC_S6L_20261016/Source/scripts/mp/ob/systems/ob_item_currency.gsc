// scripts\mp\ob\systems\ob_item_currency.gsc  (hash_578b5c7a3fa0d038.gscc) (size: 3738 Bytes / 0xe9a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe522297 (240263831)
// size ...... 3738 (0xe9a)
// includes .. 6   (offset: 0xd92)
// strings ... 7   (offset: 0xdc2)
// dev strs .. 6   (offset: 0xe42)
// exports ... 8   (offset: 0x812)
// cseg ...... 0xca + 0x748 (0x812)
// imports ... 35  (offset: 0x952)
// animtree1 . 0   (offset: 0xe9a)
// animtree2 . 0   (offset: 0xe9a)
#using script_72d1ece3cbd0884a;
#using scripts\common\callbacks;
#using scripts\mp\common\utility\points;
#using scripts\mp\currency;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;

#namespace ob_item_currency;

// Namespace ob_item_currency
// Params 0
// Checksum 0x51b7e905, Offset: 0xe8
// Size: 0x138
function init_item_currency()
{
    common_item::function_4b30c091d3b04a25( "currency" );
    common_item::function_84174b793b5fe9a7( "currency", #"use", &use_currency );
    common_item::function_84174b793b5fe9a7( "currency", #"canautouse", &function_625d8e667af2580d );
    common_item::function_84174b793b5fe9a7( "currency", #"hash_9e49dfaa7c147654", &function_625d8e667af2580d );
    common_item::function_84174b793b5fe9a7( "currency", #"getcurrent", &get_currency );
    common_item::function_84174b793b5fe9a7( "currency", #"removecurrent", &remove_currency );
    common_item::function_84174b793b5fe9a7( "currency", #"hash_f813bdc63d43bd77", &function_633a7ad37fd8f947 );
    common_item::function_84174b793b5fe9a7( "currency", #"hash_d2edc28305c6e147", &spawn_currency );
    level.var_b5b62a762432e209 = min( 4095, getdvarint( @"hash_d6c1c3a63fffaa05", 4000 ) );
    level.var_9eb9905443ff36ab = getdvarint( @"hash_92f1f3fc3fa4338f", 499 );
    
    if ( getdvarint( @"hash_ee227f9b528f4b62", 0 ) )
    {
        namespace_4bd17a2ee56036fa::function_5cfef02beb796343( "essence" );
    }
    
    if ( getdvarint( @"hash_1dfc2b7d76b2b42e", 1 ) )
    {
        namespace_4bd17a2ee56036fa::function_5cfef02beb796343( "power_shard" );
    }
}

// Namespace ob_item_currency
// Params 4
// Checksum 0x80de5769, Offset: 0x228
// Size: 0x29, Type: bool
function function_625d8e667af2580d( itembundle, item, auto_use, var_51e0c31d31f04b31 )
{
    return true;
}

// Namespace ob_item_currency
// Params 4
// Checksum 0xb1981a9b, Offset: 0x25a
// Size: 0x16e
function use_currency( itembundle, item, autouse, var_981c264073bf1154 )
{
    currencytype = itembundle.subtype;
    currencyamount = item.count;
    
    if ( !isdefined( currencytype ) || currencytype == "" || currencytype != #"essence" && currencytype != #"salvage" && currencytype != #"rare_salvage" && currencytype != #"power_shard" )
    {
        itembundlename = common_item::function_33a2c00e46263d99( item );
        assertmsg( "<dev string:x24>" + getxhashsourcename( itembundlename ) + "<dev string:x5a>" );
        return [ currencyamount, 0 ];
    }
    
    if ( isdefined( self.zombie_point_scalar ) && !item.b_ignore_double_points )
    {
        currencyamount *= self.zombie_point_scalar;
    }
    
    reason = #"itemuse";
    
    if ( isdefined( self.var_50f741a14f09a6 ) )
    {
        reason = #"cache";
    }
    
    if ( currencytype == "power_shard" )
    {
        points::doscoreevent( #"power_pickup", undefined, currencyamount, 0 );
    }
    
    currency::add_currency_amount( currencytype, currencyamount, reason );
    return [ 0, currencyamount ];
}

// Namespace ob_item_currency
// Params 1
// Checksum 0xfb852674, Offset: 0x3d1
// Size: 0x52
function get_currency( itemslotindex )
{
    name = common_item_database::function_a4f0a21951180013( "jup_currency_essence" );
    
    if ( isdefined( name ) )
    {
        return { #count:currency::get_currency_amount( #"essence" ) ?? 0, #name:name };
    }
}

// Namespace ob_item_currency
// Params 1
// Checksum 0xead587f2, Offset: 0x42c
// Size: 0xeb
function remove_currency( params )
{
    if ( params.beingreplaced )
    {
        return;
    }
    
    var_8fb8e1fb220cca48 = get_currency( params );
    
    if ( isdefined( var_8fb8e1fb220cca48 ) && var_8fb8e1fb220cca48.count > 0 )
    {
        var_9eefcc4457251a8c = params.count ?? 50;
        var_9eefcc4457251a8c = min( var_9eefcc4457251a8c, var_8fb8e1fb220cca48.count );
        var_9eefcc4457251a8c = min( var_9eefcc4457251a8c, level.var_b5b62a762432e209 );
        var_9eefcc4457251a8c = min( var_9eefcc4457251a8c, 2048 );
        currency::function_b5fe1e05c892a7f3( #"essence", int( var_9eefcc4457251a8c ) );
        removedcount = var_8fb8e1fb220cca48.count - currency::get_currency_amount( #"essence" );
        return { #count:removedcount, #name:var_8fb8e1fb220cca48.name };
    }
}

// Namespace ob_item_currency
// Params 4
// Checksum 0x46cdb8eb, Offset: 0x520
// Size: 0x177
function function_633a7ad37fd8f947( itembundle, count, droporigin, dropangles )
{
    count = int( min( count, level.var_b5b62a762432e209 ) );
    var_442d743e49050040 = count > level.var_9eb9905443ff36ab ? "essence_container_large" : "essence_container";
    itembundlename = common_item_database::function_a4f0a21951180013( var_442d743e49050040 );
    
    if ( !isdefined( itembundlename ) )
    {
        assertmsg( "<dev string:xbe>" + var_442d743e49050040 + "<dev string:x105>" );
        return;
    }
    
    itembundle = getscriptbundle( itembundlename );
    
    if ( !isdefined( itembundle ) )
    {
        assertmsg( "<dev string:x108>" + getxhashsourcename( itembundlename ) + "<dev string:x146>" );
        return;
    }
    
    payload = [ #"teamselect", self getentitynumber() ];
    spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
    spawnoptions.payload = payload;
    item = common_item::function_61c2c0251e742ffd( itembundle, count, spawnoptions );
    item.b_ignore_double_points = 1;
    common_item::items_additemautopickupcooldownforplayer( self, item, 300 );
    params = spawnstruct();
    params.item = item;
    params.itembundlename = itembundlename;
    params.payload = payload;
    callback::callback( #"player_item_drop", params );
}

// Namespace ob_item_currency
// Params 3
// Checksum 0xc6baa4ad, Offset: 0x69f
// Size: 0x172
function spawn_currency( itembundle, count = common_item::function_ea3b3088d82fd357( itembundle ), spawnoptions )
{
    var_442d743e49050040 = itembundle.ref;
    
    if ( var_442d743e49050040 == "jup_currency_essence" )
    {
        var_442d743e49050040 = count > level.var_9eb9905443ff36ab ? "essence_container_large" : "essence_container";
    }
    
    itembundlename = common_item_database::function_a4f0a21951180013( var_442d743e49050040 );
    
    if ( !isdefined( itembundlename ) )
    {
        assertmsg( "<dev string:xbe>" + var_442d743e49050040 + "<dev string:x105>" );
        return;
    }
    
    itembundle = getscriptbundle( itembundlename );
    
    if ( !isdefined( itembundle ) )
    {
        assertmsg( "<dev string:x108>" + getxhashsourcename( itembundlename ) + "<dev string:x146>" );
        return;
    }
    
    positioningresults = common_item::function_d94b7cedcd3ae9d0( spawnoptions );
    item = common_item::function_2352d25db9e97696( itembundle, count, positioningresults, spawnoptions );
    item.b_ignore_double_points = 1;
    spawningentity = spawnoptions.spawningentity;
    
    if ( isent( spawningentity ) && isplayer( spawningentity ) )
    {
        common_item::items_additemautopickupcooldownforplayer( self, item, 300 );
        params = spawnstruct();
        params.item = item;
        params.itembundlename = itembundlename;
        spawningentity callback::callback( #"player_item_drop", params );
    }
    
    return item;
}

