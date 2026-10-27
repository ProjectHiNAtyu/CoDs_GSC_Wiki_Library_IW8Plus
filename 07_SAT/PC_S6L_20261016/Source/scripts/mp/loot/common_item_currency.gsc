// scripts\mp\loot\common_item_currency.gsc  (hash_6395e6ab2f9d20a6.gscc) (size: 7127 Bytes / 0x1bd7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x39af780a (967800842)
// size ...... 7127 (0x1bd7)
// includes .. 10  (offset: 0x19e3)
// strings ... 27  (offset: 0x1a33)
// dev strs .. 2   (offset: 0x1bbf)
// exports ... 18  (offset: 0x10bb)
// cseg ...... 0x24e + 0xe6d (0x10bb)
// imports ... 55  (offset: 0x138b)
// animtree1 . 0   (offset: 0x1bd7)
// animtree2 . 0   (offset: 0x1bd7)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\currency;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;

#namespace item_currency;

// Namespace item_currency
// Params 0, eflags: 0x5
// Checksum 0x7121f1c3, Offset: 0x26c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"item_currency", #"common_item", &init_item_currency, undefined );
}

// Namespace item_currency
// Params 0
// Checksum 0x8761b00, Offset: 0x295
// Size: 0x11f
function init_item_currency()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    if ( isdefined( level.var_820a394c85bc5b35 ) )
    {
        [[ level.var_820a394c85bc5b35 ]]();
        return;
    }
    
    common_item::function_4b30c091d3b04a25( "currency" );
    common_item::function_84174b793b5fe9a7( "currency", #"use", &use_currency );
    common_item::function_84174b793b5fe9a7( "currency", #"canautouse", &function_625d8e667af2580d );
    common_item::function_84174b793b5fe9a7( "currency", #"hash_9e49dfaa7c147654", &function_625d8e667af2580d );
    common_item::function_84174b793b5fe9a7( "currency", #"getcurrent", &get_currency );
    common_item::function_84174b793b5fe9a7( "currency", #"hash_5fe1ba8c30bcba11", &function_a3eadb2d3c329589 );
    common_item::function_84174b793b5fe9a7( "currency", #"removecurrent", &remove_currency );
    common_item::function_84174b793b5fe9a7( "currency", #"hash_6705e43822cdd8da", &function_d342c83e4a7dec5a );
    common_item::function_84174b793b5fe9a7( "currency", #"hash_de6911904edf96d3", &prevent_enemies_pickup_currency );
    common_item::function_84174b793b5fe9a7( "currency", #"database_additem", &function_364d9b679503df9a );
}

// Namespace item_currency
// Params 4
// Checksum 0x2e556fd, Offset: 0x3bc
// Size: 0x90, Type: bool
function function_625d8e667af2580d( itembundle, item, auto_use, var_51e0c31d31f04b31 )
{
    if ( item.var_b0ea9303a9969a5f && isdefined( item.spawningteam ) && item.spawningteam != self.team )
    {
        if ( !auto_use )
        {
            hud_message::showerrormessage( %"hash_6de84b6fe9f66713" );
        }
        
        common_item::items_additemautopickupcooldownforplayer( self, item, 900 );
        function_adcc88e46db64745( item, itembundle, auto_use );
        return false;
    }
    
    return true;
}

// Namespace item_currency
// Params 4
// Checksum 0x313eb47b, Offset: 0x455
// Size: 0x204, Type: bool
function use_currency( itembundle, item, autouse, var_981c264073bf1154 )
{
    currencytype = itembundle.subtype;
    currencyamount = item.count;
    
    if ( itembundle.var_353b1bfe41bfbe52 )
    {
        var_3504e25778fd4e66 = max( 0, ( level.maxteamsize ?? 3 ) - teams::getteamdata( self.team, "players" ).size );
        currencyamount = int( ( var_3504e25778fd4e66 * itembundle.var_353b1bfe41bfbe52 + 1 ) * currencyamount );
        item.count = currencyamount;
    }
    
    if ( currencyamount == 0 )
    {
        currencyamount = common_item::function_ea3b3088d82fd357( itembundle );
    }
    
    if ( !isdefined( currencytype ) || currencytype == "" )
    {
        assertmsg( "<dev string:x24>" + getxhashsourcename( common_item::function_33a2c00e46263d99( item ) ) + "<dev string:x5a>" );
        return false;
    }
    
    if ( currencytype == #"essence" && isdefined( self.zombie_point_scalar ) )
    {
        currencyamount *= self.zombie_point_scalar;
    }
    
    if ( currencytype == #"plunder" && isdefined( itembundle.spawncount ) )
    {
        currencyamount = common_item::function_ea3b3088d82fd357( itembundle );
    }
    
    if ( !itembundle.var_b809e106e0052656 )
    {
        currency::add_currency_amount( currencytype, currencyamount, undefined, item );
    }
    
    sparams = spawnstruct();
    sparams.currencytype = currencytype;
    sparams.amount = currencyamount;
    sparams.item = item;
    callback::callback( "currency_pickup", sparams );
    callbackparams = { #isspend:0, #currencytype:#"cash", #amount:currencyamount, #sourceitem:item };
    telemetry_utils::function_af2d366f9522f76f( "currency_pickup", callbackparams );
    return false;
}

// Namespace item_currency
// Params 0
// Checksum 0x47649231, Offset: 0x662
// Size: 0x1d, Type: bool
function function_c6ebf96d6f3b2f34()
{
    return level.gametypebundle.var_7cacc42d73f96cef ?? "cash";
}

// Namespace item_currency
// Params 1
// Checksum 0xee25c8bf, Offset: 0x688
// Size: 0x6d
function get_currency( params )
{
    name = common_item_database::function_a4f0a21951180013( function_c6ebf96d6f3b2f34() );
    
    if ( isdefined( name ) )
    {
        currencytype = level.gametypebundle.currencytype ?? "plunder";
        return { #count:currency::get_currency_amount( currencytype ), #name:name };
    }
}

// Namespace item_currency
// Params 1
// Checksum 0xe49be417, Offset: 0x6fe
// Size: 0x5d
function function_b3dc7865b2c24da2( currencyamount )
{
    if ( !isdefined( self ) || !isplayer( self ) )
    {
        return;
    }
    
    itembundlename = common_item_database::function_a4f0a21951180013( function_c6ebf96d6f3b2f34() );
    itembundle = common_item::function_90c3e0c1fd55d6b6( itembundlename );
    itemcount = currencyamount;
    thread common_item::function_29cda7adf128f6fb( itembundle, itemcount );
}

// Namespace item_currency
// Params 2
// Checksum 0x44cca62, Offset: 0x763
// Size: 0xa7
function function_a3eadb2d3c329589( currencytype, count )
{
    dropcounts = level.commonitem.currency[ currencytype ].dropcounts;
    var_721131905ca22f83 = common_item_database::function_a4f0a21951180013( function_c6ebf96d6f3b2f34() );
    
    if ( isdefined( dropcounts ) )
    {
        for ( var_9c3e5b9d415574a6 = 0; var_9c3e5b9d415574a6 < dropcounts.size ; var_9c3e5b9d415574a6++ )
        {
            dropcount = dropcounts[ var_9c3e5b9d415574a6 ];
            
            if ( dropcount.count > count )
            {
                break;
            }
            
            var_721131905ca22f83 = dropcount.bundlename;
        }
    }
    
    return var_721131905ca22f83;
}

// Namespace item_currency
// Params 3
// Checksum 0x7ba8beb1, Offset: 0x813
// Size: 0x88
function prevent_enemies_pickup_currency( item, spawnoptions, itembundle )
{
    if ( !spawnoptions.isdeathevent && itembundle.var_23f53b1594508664 && level.var_f23b4a10de35697 )
    {
        owner = isdefined( spawnoptions.spawningentity.team ) ? spawnoptions.spawningentity : self;
        item thread function_25e84da112870215( owner, itembundle );
    }
}

// Namespace item_currency
// Params 2
// Checksum 0x758dc3d0, Offset: 0x8a3
// Size: 0xa5
function function_25e84da112870215( owner, itembundle )
{
    if ( !isplayer( owner ) )
    {
        return;
    }
    
    self.var_b0ea9303a9969a5f = 1;
    
    if ( !isdefined( self.spawningteam ) )
    {
        self.spawningteam = owner.team;
    }
    
    self.droptime = gettime();
    self.originalowner = owner;
    wait_prevent_enemies_pickup_currency( owner, itembundle.var_bf66fc3e34d0d3ed, itembundle.var_924a63d2c9ef61ef );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.var_b0ea9303a9969a5f = undefined;
    self.droptime = undefined;
    common_item::function_55a1e92020db856a( self );
}

// Namespace item_currency
// Params 3
// Checksum 0x76899f56, Offset: 0x950
// Size: 0x51
function wait_prevent_enemies_pickup_currency( owner, var_bf66fc3e34d0d3ed, var_924a63d2c9ef61ef )
{
    thread function_a49c169d0f82a3a8( owner, var_924a63d2c9ef61ef );
    time = var_bf66fc3e34d0d3ed;
    utility::function_22939e0bc589604e( time, owner, "death_or_disconnect", level, "game_ended", self, "wait_prevent_enemies_pickup_currency_distance" );
}

// Namespace item_currency
// Params 2
// Checksum 0xa73c6e36, Offset: 0x9a9
// Size: 0x92
function function_a49c169d0f82a3a8( owner, var_924a63d2c9ef61ef )
{
    owner endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self endon( #"death" );
    var_6e4b792f386395ca = 0;
    distance_threshold_sq = var_924a63d2c9ef61ef * var_924a63d2c9ef61ef;
    
    while ( !var_6e4b792f386395ca )
    {
        if ( distancesquared( owner.origin, self.origin ) > distance_threshold_sq )
        {
            self notify( #"wait_prevent_enemies_pickup_currency_distance" );
            var_6e4b792f386395ca = 1;
        }
        
        wait 0.5;
    }
}

// Namespace item_currency
// Params 3
// Checksum 0x4da3f45c, Offset: 0xa43
// Size: 0x2b
function function_d342c83e4a7dec5a( item, player, time )
{
    return [ 1, time ];
}

// Namespace item_currency
// Params 3
// Checksum 0x2d69f9ae, Offset: 0xa77
// Size: 0x24e
function function_adcc88e46db64745( item, itembundle, isautouse )
{
    var_6c3e075455aa4048 = self;
    
    if ( !isplayer( var_6c3e075455aa4048 ) )
    {
        return;
    }
    
    var_6c3e075455aa4048 dlog_recordplayerevent( "dlog_event_br_anticheat_enemies_sharing_currency", [ "cash_owner", isdefined( item.originalowner ) ? item.originalowner getplayerunoid() : "-1", "cash_owner_team", item.spawningteam ?? "", "attempting_pickup_player_team", var_6c3e075455aa4048.team ?? "", "cash_amount", itembundle.spawncount ?? -1, "location_x", var_6c3e075455aa4048.origin[ 0 ] ?? "-1", "location_y", var_6c3e075455aa4048.origin[ 1 ] ?? "-1", "location_z", var_6c3e075455aa4048.origin[ 2 ] ?? "-1", "current_cash_pickup_player", var_6c3e075455aa4048 currency::get_currency_amount( "cash" ) ?? 0, "distance_to_cash_owner", isdefined( item.originalowner ) ? int( distance( var_6c3e075455aa4048.origin, item.originalowner.origin ) ) : -1, "duration", int( ( gettime() - item.droptime ) / 1000 ) ?? 0, "circle_index", level.br_circle.circleindex ?? -1, "map_name", game_utility::getmapname() ?? "", "playlist_id", getplaylistid() ?? 0, "duration_threshold", 60, "distance_threshold", 3000, "is_auto_use", isautouse ] );
}

// Namespace item_currency
// Params 1
// Checksum 0x537b73d8, Offset: 0xccd
// Size: 0xfd
function remove_currency( params )
{
    if ( !params.beingreplaced )
    {
        var_8fb8e1fb220cca48 = get_currency( params );
        
        if ( isdefined( var_8fb8e1fb220cca48 ) && var_8fb8e1fb220cca48.count > 0 )
        {
            currencytype = level.gametypebundle.currencytype ?? "plunder";
            var_9eefcc4457251a8c = params.count ?? getdvarint( @"hash_b272936aad99a46f", 50 );
            var_9eefcc4457251a8c = min( var_9eefcc4457251a8c, var_8fb8e1fb220cca48.count );
            currency::function_b5fe1e05c892a7f3( currencytype, int( var_9eefcc4457251a8c ) );
            removedcount = var_8fb8e1fb220cca48.count - currency::get_currency_amount( currencytype );
            bundlename = function_a3eadb2d3c329589( currencytype, removedcount );
            return { #count:removedcount, #name:bundlename };
        }
    }
}

// Namespace item_currency
// Params 1, eflags: 0x4
// Checksum 0xf2d48df4, Offset: 0xdd3
// Size: 0x1dd
function private function_364d9b679503df9a( var_7dd731bd2a7209c6 )
{
    if ( !isdefined( level.commonitem ) )
    {
        level.commonitem = {};
    }
    
    if ( !isdefined( level.commonitem.currency ) )
    {
        level.commonitem.currency = [];
    }
    
    bundle = getscriptbundlefieldvalues( var_7dd731bd2a7209c6, [ #"subtype", #"spawncount", #"hash_263570065b87e345" ] );
    currencytype = bundle.subtype;
    
    if ( !isdefined( level.commonitem.currency[ currencytype ] ) )
    {
        level.commonitem.currency[ currencytype ] = {};
    }
    
    if ( !isdefined( level.commonitem.currency[ currencytype ].dropcounts ) )
    {
        level.commonitem.currency[ currencytype ].dropcounts = [];
    }
    
    if ( bundle.var_87bb7ce8bf645c4a )
    {
        dropcount = { #bundlename:var_7dd731bd2a7209c6, #count:bundle.spawncount };
        level.commonitem.currency[ currencytype ].dropcounts[ level.commonitem.currency[ currencytype ].dropcounts.size ] = dropcount;
        level.commonitem.currency[ currencytype ].dropcounts = function_7243d45b5d82f431( level.commonitem.currency[ currencytype ].dropcounts, #count, 0 );
    }
}

// Namespace item_currency
// Params 0
// Checksum 0x18b741f5, Offset: 0xfb8
// Size: 0x102
function function_65bc8ce6fb2f6f42()
{
    if ( !level.gamemodebundle.var_d0c4a40d06c8a025 )
    {
        return;
    }
    
    var_d9af75c26d5465d8 = currency::get_currency_amount( #"xp_orb" );
    
    if ( !var_d9af75c26d5465d8 )
    {
        return;
    }
    
    threshold = 0;
    finalrank = undefined;
    
    foreach ( index, rank in level.gamemodebundle.var_d0c4a40d06c8a025 )
    {
        threshold += rank.var_50137072cbdcbc36;
        
        if ( var_d9af75c26d5465d8 < threshold )
        {
            break;
        }
        
        if ( var_d9af75c26d5465d8 >= threshold )
        {
            rank.index = index + 1;
            finalrank = rank;
        }
    }
    
    return finalrank;
}

