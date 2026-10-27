// scripts\mp\loot\common_item.gsc  (hash_2b867a98ca762b0a.gscc) (size: 84381 Bytes / 0x1499d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7a632427 (2053317671)
// size ...... 84381 (0x1499d)
// includes .. 28  (offset: 0x139c5)
// strings ... 95  (offset: 0x13aa5)
// dev strs .. 164 (offset: 0x14055)
// exports ... 206 (offset: 0xdb35)
// cseg ...... 0x7fd + 0xd338 (0xdb35)
// imports ... 473 (offset: 0xfb65)
// animtree1 . 0   (offset: 0x1499d)
// animtree2 . 0   (offset: 0x1499d)
#using script_16ea1b94f0f381b3;
#using scripts\common\bots\bots_util;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\dev;
#using scripts\common\devgui;
#using scripts\common\script;
#using scripts\common\scriptable;
#using scripts\common\scriptable_group;
#using scripts\common\scriptable_group_spatial;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\dmz\gametypes\dmz_dog_tag;
#using scripts\mp\equipment;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_inventory_groups;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\loot\common_item_quest;
#using scripts\mp\loot\common_item_weapon;

#namespace common_item;

// Namespace common_item
// Params 0, eflags: 0x5
// Checksum 0x874ed3c2, Offset: 0x81b
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"common_item", undefined, &items_init, undefined );
}

// Namespace common_item
// Params 0
// Checksum 0x501d800a, Offset: 0x83c
// Size: 0x757
function items_init()
{
    var_7237854e3be197ca = level.commonitem;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    utility::registersharedfunc( #"game", #"isCommonItemEnabled", &items_isenabled );
    
    if ( !items_isenabled() )
    {
        return;
    }
    
    level.commonitem = spawnstruct();
    level.commonitem.itemcallbacks = [];
    level.commonitem.var_60b382bc384e5620 = [];
    level.commonitem.var_914563511f4d6f78 = getdvarint( @"common_item_runtime_scriptable_limit", 500 );
    level.commonitem.var_d9665d85ee830b4c = getdvarint( @"hash_42873b98da3e3855", 0 );
    level.commonitem.var_b19011d4f497fae7 = getdvarint( @"hash_5c7949959c1b5c9a", 1 ) == 1;
    level.commonitem.var_50bc13577ee45475 = getdvarint( @"hash_330e06df155c6425", 0 );
    
    if ( level.commonitem.var_d9665d85ee830b4c == 0 )
    {
        scriptable_group::function_54e1543b9d498b1f( "common_items", level.commonitem.var_914563511f4d6f78, 10 );
    }
    else
    {
        level.commonitem.var_8be065896d711ba0 = getdvarint( @"hash_657a2552e92fe4b5", 0 );
        scriptable_group_spatial::function_3d8f0445c920e8f7( level.commonitem.var_914563511f4d6f78, 10 );
        
        if ( level.commonitem.var_d9665d85ee830b4c == 3 || level.commonitem.var_d9665d85ee830b4c == 4 )
        {
            scriptable_group_spatial::function_5c34c712fcfd241e( "common_items" );
        }
        else
        {
            scriptable_group_spatial::function_5c34c712fcfd241e( "common_items_nonweapons" );
            scriptable_group_spatial::function_5c34c712fcfd241e( "common_items_weapons" );
        }
    }
    
    level utility::flag_init( "common_items_init" );
    loot::init();
    thread common_item_quest::init_item_quest();
    scriptable::scriptable_addusedcallback( &items_scriptable_used );
    scriptable::scriptable_addautousecallback( &items_scriptable_used );
    scriptable::function_956535bbfd32b7d6( &function_366a8b5ccb4106f1 );
    scriptable::scriptable_addnotifycallback( "dropped_state_end", &function_c3f293f2b1d70037 );
    callback::add( #"on_ping", &function_8425760df24db4d9 );
    utility::registersharedfunc( #"item", #"hash_5a146360fa1d97ab", &function_77600f92048df72d );
    utility::registersharedfunc( #"game", #"getScriptableFromLootID", &items_getscriptablefromlootid );
    utility::registersharedfunc( #"game", #"hash_ca4103c28ac67fef", &function_105527001e21028d );
    utility::registersharedfunc( #"item", #"hash_21d84c663ac62eac", &function_cf68ad18114498b2 );
    utility::registersharedfunc( #"game", #"hash_6a1940cb87219089", &function_2b5e2ff57d5f392 );
    utility::registersharedfunc( #"game", #"obtainitem", &function_96119bed8ab4c5d9 );
    utility::registersharedfunc( #"game", #"showStockLootFeed", &function_c63738c9201561aa );
    utility::registersharedfunc( #"game", #"getlootidfromref", &items_getlootidfromref );
    utility::registersharedfunc( #"game", #"hash_da85e1cf6234f5f2", &function_bc5ff2958b71a708 );
    utility::registersharedfunc( #"game", #"initSpawnOptions_SpawnFromPosition", &items_initspawnoptions_spawnfromposition );
    utility::registersharedfunc( #"game", #"initSpawnOptions_SpawnFromEntity", &items_initspawnoptions_spawnfromentity );
    utility::registersharedfunc( #"game", #"spawnPickupFromList", &function_38cde6a6acb68ea6 );
    utility::registersharedfunc( #"game", #"hash_a7fdfd9b3e54da61", &function_577fe3f000fcb275 );
    utility::registersharedfunc( #"game", #"spawnItemFromScriptable", &items_spawnitemfromscriptable );
    utility::registersharedfunc( #"game", #"hash_dca65b23d72fe65f", &function_16e8c106491eeaca );
    utility::registersharedfunc( #"item", #"hash_7c5f2583a47f342f", &function_9deb822f286163b1 );
    utility::registersharedfunc( #"game", #"hash_4aa5275ed9e408f4", &function_80af1e9daffacc7d );
    utility::registersharedfunc( #"game", #"hash_46d169cc2f231f1b", &function_869d7676e359a627 );
    utility::registersharedfunc( #"item", #"hash_8c623dab98d6f709", &function_725abd79805e767e );
    utility::registersharedfunc( #"item", #"hash_d7e5d2a8b89b1a12", &function_c4c43ebb7aa636dc );
    utility::registersharedfunc( #"item", #"hash_5dd38e63b8ac14a4", &function_bbba261e6fdc7e52 );
    utility::registersharedfunc( #"item", #"hash_b291851ae2542542", &cleanup_all_items );
    level utility::flag_set( "common_items_init" );
    level.var_97db93a6b414090d = getdvarint( @"hash_d575cd4469710052", 0 );
    level.var_b596da802bc4f04e = getdvarfloat( @"hash_3d0c37a1b0da97b3", 0.8 );
    level.var_b0ace4a89629a502 = getdvarint( @"hash_d7fa24253bfb64d8", 0 );
    level.var_fc8c25326b291055 = getdvarint( @"hash_ddb9b0d1b5686e20", 0 ) ? "common_item_debug_positioning_drawing_reset" : undefined;
    level.var_635178f7bf48e21e = !getdvarint( @"hash_ddb9b0d1b5686e20", 0 ) ? getdvarint( @"hash_bda8934e112f68cd", 2000 ) : undefined;
    level.var_608f2b17211c7ff4 = getdvarfloat( @"hash_57c854edfce976dd", 2 );
    level.var_79d3cd44bf5dc96e = getdvarfloat( @"hash_e2cadd2e657c0c27", 0.7 );
    level.var_79d23cbd8d065edc = getdvarint( @"hash_3ca29b429f678228", 1 );
    level.var_b0878a4f306c03a8 = getdvarfloat( @"hash_b91d6bc7e0694ac", 2000 );
    level.var_6ddf3426036ea4fe = getdvarint( @"hash_ff8abba18e62faa0", 22 );
    level.var_f285d458084b8d58 = getdvarint( @"hash_27fc198432e29f5a", 25 );
    level.var_9fa769fe9c8b2a15 = getdvarint( @"hash_e192756880a5f445", 15 );
    level.var_cb1501e12a8d7d58 = getdvarint( @"hash_4b287dc805e35339", 5 );
    level.var_eca35f80c78570e0 = getdvarint( @"hash_81dd144e3d37d482", 0 );
    level.commonitem.var_4ad65b54acfaefa1 = getdvarint( @"hash_c867bb7a1159d0a0", 0 );
    level.commonitem.var_43ccd87d8acb8134 = getdvarint( @"sv_serverobject_partitioning_enabled", 1 );
    level.var_2f0a93f86990f4d4 = &function_82b75f5bfa85d5b;
    level.commonitem.var_cd902972aae40099 = common_inventory::inventory_isenabled() && getdvarint( @"hash_37de17e0ca082cb1", istrue( level.gametypebundle.var_c208158df7ba1979 ) );
    level.commonitem.item_cleanup_throttle = throttle::throttle_initialize_gate( "cleanup_all_items", 100, level.framedurationseconds );
    
    /#
        level thread setup_item_devgui();
        level thread dev::devcommandwatcher( @"debug_item", &debugitem );
        level.var_4e991a74374e63c6 = getdvarint( @"hash_6791349ae7cc13ce", 0 );
    #/
}

// Namespace common_item
// Params 0
// Checksum 0x245fe9d3, Offset: 0xf9b
// Size: 0x81
function items_isenabled()
{
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return 0;
        }
    #/
    
    if ( getdvarint( @"common_item_disable", 0 ) )
    {
        return 0;
    }
    
    if ( !isdefined( level.gametypebundle ) )
    {
        assertmsg( "<dev string:x24>" );
        return 0;
    }
    
    if ( !isdefined( level.var_6d09c00f42c02b67 ) )
    {
        level.var_6d09c00f42c02b67 = utility::function_edc4cc03e9e60b3e( @"scr_common_item_enabled", 0, level.gametypebundle.var_c4017808ddc790a2 );
    }
    
    return level.var_6d09c00f42c02b67;
}

// Namespace common_item
// Params 1
// Checksum 0x4876516e, Offset: 0x1025
// Size: 0x5a
function function_4b30c091d3b04a25( itemtype )
{
    if ( !items_isenabled() )
    {
        return;
    }
    
    if ( isdefined( level.commonitem.itemcallbacks[ itemtype ] ) )
    {
        assertmsg( "<dev string:x76>" + itemtype );
        return;
    }
    
    level.commonitem.itemcallbacks[ itemtype ] = {};
}

// Namespace common_item
// Params 1
// Checksum 0xcd530397, Offset: 0x1087
// Size: 0x23, Type: bool
function function_498ad287e390e8bc( itemtype )
{
    return isdefined( level.commonitem.itemcallbacks[ itemtype ] );
}

// Namespace common_item
// Params 1
// Checksum 0x52539cdd, Offset: 0x10b3
// Size: 0x57
function function_ed1cb2c7c4fe57cc( itemtype )
{
    switch ( itemtype )
    {
        case #"hash_2acb6b11468fd311":
        case #"hash_5ed0b523d5733ef9":
        case #"hash_dc0a55772fe305c5":
        case #"hash_fb54a7157b952658":
            return 0;
        default:
            return 1;
    }
}

// Namespace common_item
// Params 3
// Checksum 0xc4d1e3a2, Offset: 0x1112
// Size: 0xe3
function function_84174b793b5fe9a7( itemtype, var_e8f16b9dd5957931, overridefunc )
{
    if ( !isdefined( level.commonitem.itemcallbacks ) )
    {
        level.commonitem.itemcallbacks = [];
    }
    
    if ( !isdefined( level.commonitem.itemcallbacks[ itemtype ] ) )
    {
        level.commonitem.itemcallbacks[ itemtype ] = {};
    }
    
    if ( !isdefined( level.commonitem.itemcallbacks[ itemtype ].funcs ) )
    {
        level.commonitem.itemcallbacks[ itemtype ].funcs = [];
    }
    
    level.commonitem.itemcallbacks[ itemtype ].funcs[ var_e8f16b9dd5957931 ] = overridefunc;
}

// Namespace common_item
// Params 2
// Checksum 0x8b0ff777, Offset: 0x11fd
// Size: 0x37
function function_c6f3ef3dcb4c55c0( itemtype, var_e8f16b9dd5957931 )
{
    return level.commonitem.itemcallbacks[ itemtype ].funcs[ var_e8f16b9dd5957931 ];
}

// Namespace common_item
// Params 2
// Checksum 0x28d62e28, Offset: 0x123d
// Size: 0x4d
function function_9f00d6361edd38ce( itemtype, ignoregroups = 1 )
{
    if ( common_inventory_groups::inventorygroup_enabled() && !ignoregroups )
    {
        return common_inventory_groups::function_5adc07cba5c77aba( itemtype );
    }
    
    return level.commonitem.itemcallbacks[ itemtype ];
}

// Namespace common_item
// Params 3
// Checksum 0xa1195384, Offset: 0x1293
// Size: 0x7c
function function_c4c43ebb7aa636dc( itemtype, params = spawnstruct(), ignoregroups = 1 )
{
    callbacks = function_9f00d6361edd38ce( itemtype, ignoregroups );
    
    if ( isdefined( callbacks.funcs[ #"getcurrent" ] ) )
    {
        return self [[ callbacks.funcs[ #"getcurrent" ] ]]( params );
    }
    
    return {};
}

// Namespace common_item
// Params 3
// Checksum 0xcadb1546, Offset: 0x1318
// Size: 0xdd
function function_bbba261e6fdc7e52( itemtype, params = spawnstruct(), ignoregroups = 1 )
{
    callbacks = function_9f00d6361edd38ce( itemtype, ignoregroups );
    
    if ( isdefined( callbacks.funcs[ #"removecurrent" ] ) )
    {
        if ( callback::exists_any( #"hash_6be17d27fe58c7b1" ) )
        {
            var_33e1f9622e337b17 = function_c4c43ebb7aa636dc( itemtype );
            
            if ( var_33e1f9622e337b17.name )
            {
                callback::callback( #"hash_6be17d27fe58c7b1", { #itembundlename:var_33e1f9622e337b17.name, #player:self } );
            }
        }
        
        return self [[ callbacks.funcs[ #"removecurrent" ] ]]( params );
    }
    
    return {};
}

// Namespace common_item
// Params 3, eflags: 0x4
// Checksum 0xfc2c7239, Offset: 0x13fe
// Size: 0x120
function private function_f14d3021ced85435( filterkind, filtervalue, func )
{
    assert( isdefined( level.commonitem ), "<dev string:xb4>" );
    assert( isdefined( filterkind ) );
    assert( isdefined( filtervalue ) );
    
    if ( !isdefined( filterkind ) || !isdefined( filtervalue ) )
    {
        return;
    }
    
    callbackswrapper = function_fab2da776305e989( filterkind, filtervalue, 1 );
    
    /#
        foreach ( callback in callbackswrapper.callbacks )
        {
            if ( callback == func )
            {
                assertmsg( "<dev string:x113>" + callbackswrapper.debugname );
            }
        }
    #/
    
    callbackswrapper.callbacks[ callbackswrapper.callbacks.size ] = func;
}

// Namespace common_item
// Params 4, eflags: 0x44 variadic
// Checksum 0x7b5d02d, Offset: 0x1526
// Size: 0xc2
function private function_5a3b3bc996e8d5a5( filterkind, filtervalue, ... )
{
    callbackswrapper = function_fab2da776305e989( filterkind, filtervalue, 0 );
    callbacks = callbackswrapper.callbacks;
    
    foreach ( callback in callbacks )
    {
        thread [[ callback ]]( flat_args( vararg, varargcount ) );
    }
}

// Namespace common_item
// Params 3, eflags: 0x4
// Checksum 0x99259f21, Offset: 0x15f0
// Size: 0x110
function private function_fab2da776305e989( filterkind, filtervalue, var_22784b40e382a8df )
{
    if ( !isdefined( filterkind ) || !isdefined( filtervalue ) )
    {
        return;
    }
    
    if ( !isdefined( level.commonitem.itemspawncallbacks ) )
    {
        level.commonitem.itemspawncallbacks = [];
    }
    
    if ( !isdefined( level.commonitem.itemspawncallbacks[ filterkind ] ) )
    {
        level.commonitem.itemspawncallbacks[ filterkind ] = [];
    }
    
    var_7237854e3be197ca = level.commonitem.itemspawncallbacks[ filterkind ][ filtervalue ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( var_22784b40e382a8df )
    {
        callbackswrapper = { #callbacks:[] };
        
        /#
            callbackswrapper.debugname = getxhashsourcename( filterkind ) + "<dev string:x141>" + getxhashsourcename( filtervalue );
        #/
        
        level.commonitem.itemspawncallbacks[ filterkind ][ filtervalue ] = callbackswrapper;
        return callbackswrapper;
    }
}

// Namespace common_item
// Params 2
// Checksum 0x2878fff6, Offset: 0x1709
// Size: 0x36
function function_c7bbbfcefe78f798( ref, func )
{
    assert( isstring( ref ) );
    function_f14d3021ced85435( #"hash_6fa1b7a8cddbe208", ref, func );
}

// Namespace common_item
// Params 2
// Checksum 0xbe1a6b37, Offset: 0x1747
// Size: 0x36
function function_5734400f32ca9803( subtype, func )
{
    assert( isstring( subtype ) );
    function_f14d3021ced85435( #"hash_f7e6c86eafa2eab3", subtype, func );
}

// Namespace common_item
// Params 2
// Checksum 0xb9b72d22, Offset: 0x1785
// Size: 0x36
function function_e08da1075e1758ef( type, func )
{
    assert( isstring( type ) );
    function_f14d3021ced85435( #"hash_8a0270c421b2093f", type, func );
}

// Namespace common_item
// Params 2
// Checksum 0x764b54c, Offset: 0x17c3
// Size: 0x2d
function function_13398f0f1186a3f8( scriptable, func )
{
    function_f14d3021ced85435( #"hash_d2b6e74af5f0f2a8", getxhashasset( scriptable ), func );
}

// Namespace common_item
// Params 1
// Checksum 0x93544ff5, Offset: 0x17f8
// Size: 0x27
function function_9c9e4c71569f3ae8( func )
{
    function_f14d3021ced85435( #"hash_9d2a33362cc3f972", #"hash_af63a74c8601927d", func );
}

// Namespace common_item
// Params 2
// Checksum 0x9b57aa7e, Offset: 0x1827
// Size: 0xea
function function_134b9624f3886a06( filtervalue, func )
{
    foreach ( filterkind, var_b31770ef3c9a95c8 in level.commonitem.itemspawncallbacks )
    {
        callbackswrapper = var_b31770ef3c9a95c8[ filtervalue ];
        
        if ( isdefined( callbackswrapper ) )
        {
            callbackswrapper.callbacks = arrayremove( callbackswrapper.callbacks, func );
            
            if ( callbackswrapper.callbacks.size == 0 )
            {
                level.commonitem.itemspawncallbacks[ filterkind ][ filtervalue ] = undefined;
            }
            
            return;
        }
    }
}

// Namespace common_item
// Params 1
// Checksum 0x89e0a4f8, Offset: 0x1919
// Size: 0x1e
function function_52b5ab4ab2188fe5( func )
{
    function_134b9624f3886a06( #"hash_af63a74c8601927d", func );
}

// Namespace common_item
// Params 5
// Checksum 0x54aaffca, Offset: 0x193f
// Size: 0x32c
function function_96119bed8ab4c5d9( item, autouse = 0, var_94970c7bddc5ce4c, var_8ec9bd311c662237, var_8e2a9de76678811f )
{
    itembundlename = function_33a2c00e46263d99( item );
    
    if ( !isdefined( itembundlename ) )
    {
        return 0;
    }
    
    if ( items_isitemdisabled( itembundlename ) )
    {
        return 0;
    }
    
    itembundle = getscriptbundle( itembundlename );
    lootid = function_779887309ec71dfe( itembundle );
    itemtype = function_16e8c106491eeaca( itembundle );
    callbacks = function_9f00d6361edd38ce( itemtype );
    
    if ( !isdefined( callbacks ) )
    {
        assertmsg( "<dev string:x143>" + itemtype + "<dev string:x17c>" );
        return 0;
    }
    
    if ( !function_d4c3b44cc8cb33d1( self, item, itembundle, itemtype, autouse ) )
    {
        return 0;
    }
    
    canuse = function_5f81801cb8c86ac2( itembundlename, itembundle, item, autouse, itemtype );
    
    if ( common_inventory::inventory_isenabled() )
    {
        if ( canuse )
        {
            quantityequipped = function_2b5e2ff57d5f392( item, autouse, 1, itembundlename, itembundle, itemtype, var_8e2a9de76678811f );
            
            if ( quantityequipped )
            {
                if ( !var_8ec9bd311c662237 )
                {
                    function_eddf962212836a3e( itembundle, 1 );
                }
                
                return quantityequipped;
            }
        }
        else if ( autouse && !itembundle.var_b30083978786aac7 )
        {
            return 0;
        }
        
        if ( !function_5cf4e552f9e871f1( itembundle ) )
        {
            if ( !autouse && !var_8ec9bd311c662237 )
            {
                function_eddf962212836a3e( itembundle, 0 );
            }
            
            return 0;
        }
        
        var_4375d83555c8dd6f = common_inventory_groups::inventorygroup_enabled() ? common_inventory_groups::function_c27ac785b5373b73()[ 0 ] : undefined;
        var_6ecc64ede36ab68 = undefined;
        
        if ( var_4375d83555c8dd6f && !var_6ecc64ede36ab68 )
        {
            backpacksize = common_inventory::function_9cd65c8312048802();
            var_6ecc64ede36ab68 = common_inventory_groups::function_9cfb83fd532b7894( itembundle, var_4375d83555c8dd6f, backpacksize, lootid );
        }
        
        count = function_974a788b833e282b( item, itembundle );
        var_779f4b1579342dbe = common_inventory::inventory_canitemfitinbackpack( itembundle, count, undefined, item, lootid, itemtype, var_6ecc64ede36ab68 );
        
        if ( !autouse && !var_779f4b1579342dbe )
        {
            quantitysecured = common_inventory::function_87aa67ee2b065517( itembundlename, itembundle, item, var_8ec9bd311c662237, var_8e2a9de76678811f );
            
            if ( quantitysecured > 0 )
            {
                return quantitysecured;
            }
            
            if ( !var_94970c7bddc5ce4c )
            {
                common_inventory::function_b374bcc6d7c43b31( item, lootid, itembundlename, 1 );
            }
            else if ( !var_8ec9bd311c662237 )
            {
                function_eddf962212836a3e( itembundle, 0 );
            }
            
            return 0;
        }
        
        itemdata = function_a48ae6cbf7e8c2d5( item, lootid );
        remainder = common_inventory::function_1a85f583119d9740( itembundlename, itembundle, item, autouse, lootid, itemtype, var_6ecc64ede36ab68, var_779f4b1579342dbe, count );
        quantitystowed = item.count - remainder;
        function_6b392f3e5fc53c0d( item, itembundle, remainder );
        
        if ( quantitystowed > 0 )
        {
            if ( !item.var_fbb504183990fc9f && ( !itembundle.var_330a7ff3d586684e || itembundle.var_330a7ff3d586684e && quantitystowed == itemdata.count ) )
            {
                function_2e0436a8625e3515( itembundle, quantitystowed, itemdata, 1, var_8ec9bd311c662237, var_8e2a9de76678811f, autouse );
            }
            
            return quantitystowed;
        }
        
        if ( !autouse && !var_8ec9bd311c662237 )
        {
            function_eddf962212836a3e( itembundle, 0 );
        }
    }
    else if ( canuse )
    {
        quantityequipped = function_2b5e2ff57d5f392( item, autouse, undefined, itembundlename );
        
        if ( quantityequipped )
        {
            return quantityequipped;
        }
    }
    
    return 0;
}

// Namespace common_item
// Params 7
// Checksum 0x1d58bea6, Offset: 0x1c74
// Size: 0x7a4
function function_2b5e2ff57d5f392( item, autouse = 0, var_8ec9bd311c662237, newitembundlename = function_33a2c00e46263d99( item ), newitembundle, itemtype, var_8e2a9de76678811f )
{
    if ( !isdefined( newitembundlename ) )
    {
        return 0;
    }
    
    assert( newitembundlename == function_33a2c00e46263d99( item ), "<dev string:x17e>" + newitembundlename + "<dev string:x1aa>" + function_33a2c00e46263d99( item ) + "<dev string:x1d0>" );
    
    if ( items_isitemdisabled( newitembundlename ) )
    {
        return 0;
    }
    
    if ( !isdefined( newitembundle ) )
    {
        newitembundle = getscriptbundle( newitembundlename );
    }
    
    if ( !isdefined( itemtype ) )
    {
        itemtype = function_16e8c106491eeaca( newitembundle );
    }
    
    assert( itemtype == function_16e8c106491eeaca( newitembundle ), "<dev string:x1ec>" );
    callbacks = function_9f00d6361edd38ce( itemtype, 0 );
    
    if ( !isdefined( callbacks ) )
    {
        assertmsg( "<dev string:x143>" + itemtype + "<dev string:x17c>" );
        return 0;
    }
    
    useprevented = 0;
    
    if ( common_inventory_groups::inventorygroup_enabled() && item.fromgroup != 1 )
    {
        [ loadoutgroup, _ ] = common_inventory_groups::function_896ed3217a875f7d();
        slotindex = common_inventory_groups::function_76928b4f093ca1ad( 2, newitembundle, 1, item );
        [ row, column ] = common_inventory_groups::function_12ee5af12df204b4( loadoutgroup, slotindex );
        buttondefinition = common_inventory_groups::function_62e8f7d021e6a61e( loadoutgroup, row, column );
        
        if ( buttondefinition.var_ace7479a34165c59 )
        {
            newlootid = function_779887309ec71dfe( newitembundle );
            useprevented = common_inventory::function_383caa18a4383073( newlootid );
        }
    }
    
    if ( autouse )
    {
        canautouse = 1;
        
        if ( isdefined( callbacks.funcs[ #"canautouse" ] ) )
        {
            canautouse = self [[ callbacks.funcs[ #"canautouse" ] ]]( newitembundle, item, autouse, 0 );
        }
        
        canautouse = canautouse && !useprevented;
        
        if ( canautouse )
        {
            if ( isdefined( callbacks.funcs[ #"caninteract" ] ) )
            {
                canautouse = self [[ callbacks.funcs[ #"caninteract" ] ]]( { #item:item, #itembundle:newitembundle } ) ?? 0;
            }
            else
            {
                canautouse = self function_a35b39392c23339f( { #weaponobj:item.weaponobj, #itembundlename:newitembundlename } );
            }
        }
        
        if ( canautouse )
        {
            itemdata = function_a48ae6cbf7e8c2d5( item );
            quantityused = items_useitemscriptable( item, newitembundlename, newitembundle, autouse );
            var_540c7f7899866ae5 = function_44eacd480abb5b94( quantityused );
            
            if ( var_540c7f7899866ae5 > 0 )
            {
                if ( !item.var_fbb504183990fc9f && ( !newitembundle.var_330a7ff3d586684e || newitembundle.var_330a7ff3d586684e && var_540c7f7899866ae5 == itemdata.count ) )
                {
                    function_2e0436a8625e3515( newitembundle, var_540c7f7899866ae5, itemdata, 1, var_8ec9bd311c662237, var_8e2a9de76678811f, autouse );
                }
                
                return quantityused;
            }
        }
    }
    else
    {
        canuse = 1;
        
        if ( isdefined( callbacks.funcs[ #"hash_9e49dfaa7c147654" ] ) )
        {
            canuse = self [[ callbacks.funcs[ #"hash_9e49dfaa7c147654" ] ]]( newitembundle, item, autouse, 0 ) ?? 1;
        }
        
        canuse = canuse && !useprevented;
        
        if ( canuse )
        {
            if ( isdefined( callbacks.funcs[ #"caninteract" ] ) )
            {
                canuse = self [[ callbacks.funcs[ #"caninteract" ] ]]( { #itembundlename:newitembundlename, #item:item, #itembundle:newitembundle } ) ?? 1;
            }
            else
            {
                canuse = self function_a35b39392c23339f( { #weaponobj:item.weaponobj, #itembundlename:newitembundlename } );
            }
        }
        
        if ( canuse )
        {
            var_10c287547af80258 = undefined;
            var_ab17ccc9ce12ba75 = 0;
            
            if ( isdefined( callbacks.funcs[ #"getcurrent" ] ) )
            {
                var_8fb8e1fb220cca48 = self [[ callbacks.funcs[ #"getcurrent" ] ]]();
                
                if ( isdefined( var_8fb8e1fb220cca48 ) )
                {
                    var_10c287547af80258 = getscriptbundle( var_8fb8e1fb220cca48.name );
                    var_ab17ccc9ce12ba75 = var_8fb8e1fb220cca48.count;
                }
            }
            
            if ( isdefined( var_10c287547af80258 ) && var_ab17ccc9ce12ba75 )
            {
                groupindex = undefined;
                slotindex = undefined;
                
                if ( common_inventory_groups::inventorygroup_enabled() )
                {
                    groupindex = 2;
                    slotindex = common_inventory_groups::function_76928b4f093ca1ad( groupindex, var_10c287547af80258, 1, item );
                }
                
                if ( function_2cc71c2e2239ce64( var_10c287547af80258, newitembundle, var_ab17ccc9ce12ba75, itemtype ) )
                {
                    currentitem = function_77600f92048df72d( var_8fb8e1fb220cca48.name, var_ab17ccc9ce12ba75, undefined, groupindex, slotindex );
                    spawnoptions = items_initspawnoptions_spawnfromentity( self );
                    spawnoptions.additionaldata = currentitem.additionaldata;
                    function_df311537e0426654( itemtype, var_10c287547af80258, spawnoptions, newitembundle.ref );
                }
                else
                {
                    if ( var_8fb8e1fb220cca48.name != newitembundlename && common_inventory_groups::inventorygroup_enabled() && isdefined( callbacks.funcs[ #"removecurrent" ] ) )
                    {
                        var_7afdbb999f9f1b6b = var_8fb8e1fb220cca48;
                        var_8fb8e1fb220cca48 = self [[ callbacks.funcs[ #"removecurrent" ] ]]( { #beingreplaced:1, #count:var_ab17ccc9ce12ba75 } );
                        
                        if ( !isdefined( var_8fb8e1fb220cca48 ) )
                        {
                            var_10c287547af80258 = undefined;
                            var_ab17ccc9ce12ba75 = 0;
                        }
                        else
                        {
                            var_ab17ccc9ce12ba75 = var_8fb8e1fb220cca48.count;
                            
                            if ( var_7afdbb999f9f1b6b.name != var_8fb8e1fb220cca48.name )
                            {
                                var_10c287547af80258 = function_6b8ff3d5f2688336( var_8fb8e1fb220cca48.name );
                            }
                        }
                    }
                    
                    if ( isdefined( var_10c287547af80258 ) && var_ab17ccc9ce12ba75 && function_c4df947cec8e3d23( var_8fb8e1fb220cca48, newitembundle, newitembundlename, item ) )
                    {
                        currentitem = function_77600f92048df72d( var_8fb8e1fb220cca48.name, var_ab17ccc9ce12ba75, undefined, groupindex, slotindex );
                        remainder = common_inventory::function_1a85f583119d9740( var_8fb8e1fb220cca48.name, var_10c287547af80258, currentitem );
                        
                        if ( remainder > 0 )
                        {
                            var_923139babd466a23 = function_77600f92048df72d( var_8fb8e1fb220cca48.name, remainder, undefined, groupindex, slotindex );
                            quantitysecured = common_inventory::function_87aa67ee2b065517( var_8fb8e1fb220cca48.name, var_10c287547af80258, var_923139babd466a23, 1, 1 );
                            remainder -= quantitysecured;
                            
                            if ( remainder > 0 )
                            {
                                spawnoptions = items_initspawnoptions_spawnfromentity( self );
                                function_61c2c0251e742ffd( var_8fb8e1fb220cca48.name, var_ab17ccc9ce12ba75, spawnoptions );
                                self [[ callbacks.funcs[ #"removecurrent" ] ]]( { #beingreplaced:1, #count:var_ab17ccc9ce12ba75 } );
                            }
                        }
                    }
                }
            }
            
            itemdata = function_a48ae6cbf7e8c2d5( item );
            quantityused = items_useitemscriptable( item, newitembundlename, newitembundle, autouse );
            var_540c7f7899866ae5 = function_44eacd480abb5b94( quantityused );
            
            if ( var_540c7f7899866ae5 > 0 || itemtype == "weapon" || itemtype == "currency" )
            {
                if ( !item.var_fbb504183990fc9f && ( !newitembundle.var_330a7ff3d586684e || newitembundle.var_330a7ff3d586684e && var_540c7f7899866ae5 == itemdata.count ) )
                {
                    function_2e0436a8625e3515( newitembundle, var_540c7f7899866ae5, itemdata, 1, var_8ec9bd311c662237, var_8e2a9de76678811f, autouse );
                }
                
                return quantityused;
            }
        }
        
        if ( !var_8ec9bd311c662237 )
        {
            function_eddf962212836a3e( newitembundle, 0 );
        }
    }
    
    return 0;
}

// Namespace common_item
// Params 6
// Checksum 0xf60d708d, Offset: 0x2421
// Size: 0xf6
function function_41751a7f86839f01( item, autouse = 0, var_94970c7bddc5ce4c, var_8ec9bd311c662237, var_8e2a9de76678811f, spawnoptions )
{
    itembundle = function_6b8ff3d5f2688336( item );
    originalcount = item.count;
    equipamount = function_96119bed8ab4c5d9( item, autouse, var_94970c7bddc5ce4c, var_8ec9bd311c662237, var_8e2a9de76678811f );
    
    if ( equipamount >= originalcount )
    {
        return equipamount;
    }
    
    var_5deeb11d000d2696 = originalcount - equipamount;
    var_b3062827c2eddcbd = function_77600f92048df72d( itembundle, var_5deeb11d000d2696 );
    inventoryamount = function_96119bed8ab4c5d9( var_b3062827c2eddcbd, autouse, var_94970c7bddc5ce4c, var_8ec9bd311c662237, var_8e2a9de76678811f );
    
    if ( inventoryamount >= var_5deeb11d000d2696 )
    {
        return ( equipamount + inventoryamount );
    }
    
    if ( !isdefined( spawnoptions ) )
    {
        spawnoptions = items_initspawnoptions_spawnfromentity( self );
    }
    
    function_325e28c0fb65c36a( itembundle.ref, var_5deeb11d000d2696 - inventoryamount, spawnoptions );
    return originalcount;
}

// Namespace common_item
// Params 4, eflags: 0x4
// Checksum 0xe0b5ce5d, Offset: 0x2520
// Size: 0x96, Type: bool
function private function_2cc71c2e2239ce64( var_10c287547af80258, newitembundle, var_ab17ccc9ce12ba75, itemtype )
{
    if ( !isstruct( var_10c287547af80258 ) || !isdefined( var_10c287547af80258.ref ) )
    {
        return false;
    }
    
    if ( var_10c287547af80258.ref == newitembundle.ref && function_bfd517bdc8850ea6( itemtype, var_10c287547af80258 ) )
    {
        return false;
    }
    
    if ( var_ab17ccc9ce12ba75 <= 0 )
    {
        return false;
    }
    
    if ( function_3195adf8b9d5b2c6( var_10c287547af80258 ) == "Pooled" )
    {
        return false;
    }
    
    if ( common_inventory::function_5a70e09721a21568() )
    {
        return false;
    }
    
    return true;
}

// Namespace common_item
// Params 4, eflags: 0x4
// Checksum 0xf2d1b760, Offset: 0x25bf
// Size: 0x91, Type: bool
function private function_c4df947cec8e3d23( var_8fb8e1fb220cca48, newitembundle, newitembundlename, item )
{
    if ( !common_inventory::function_5a70e09721a21568() )
    {
        return false;
    }
    
    if ( var_8fb8e1fb220cca48.name === newitembundlename && !newitembundle.var_1aee3705c814b51f )
    {
        return false;
    }
    
    if ( common_inventory_groups::inventorygroup_enabled() && !item.fromground )
    {
        return false;
    }
    
    if ( !function_5cf4e552f9e871f1( newitembundle ) )
    {
        return false;
    }
    
    if ( newitembundle.var_a407b59600c40e6 )
    {
        return false;
    }
    
    return true;
}

// Namespace common_item
// Params 2
// Checksum 0xbcd5e9eb, Offset: 0x2659
// Size: 0x49
function function_bfd517bdc8850ea6( itemtype, itembundle )
{
    var_969df8d85485c024 = function_c6f3ef3dcb4c55c0( itemtype, #"hash_f6ad22d767ebd714" );
    
    if ( var_969df8d85485c024 )
    {
        return [[ var_969df8d85485c024 ]]( itembundle );
    }
    
    return !itembundle.disablestacking;
}

// Namespace common_item
// Params 2
// Checksum 0xcac83d69, Offset: 0x26ab
// Size: 0x7d
function function_d4e57b6b48d088b1( itemtype, params )
{
    func = function_c6f3ef3dcb4c55c0( itemtype, #"hash_bbbee9a6b48de857" );
    
    if ( func )
    {
        callbacks = function_9f00d6361edd38ce( itemtype );
        currentitem = self [[ callbacks.funcs[ #"getcurrent" ] ]]();
        return [[ func ]]( params, currentitem );
    }
    
    return params.count;
}

// Namespace common_item
// Params 5
// Checksum 0x9ca94859, Offset: 0x2731
// Size: 0x422
function function_df311537e0426654( itemtype, itembundle, spawnoptions, var_eb659d64b0476d5c, count )
{
    callbacks = function_9f00d6361edd38ce( itemtype );
    
    if ( !isdefined( callbacks.funcs[ #"getcurrent" ] ) )
    {
        return;
    }
    
    if ( !isdefined( itembundle ) )
    {
        currentitem = self [[ callbacks.funcs[ #"getcurrent" ] ]]();
        
        if ( isdefined( currentitem ) )
        {
            itembundle = function_90c3e0c1fd55d6b6( currentitem.name );
        }
    }
    
    if ( !isdefined( itembundle ) )
    {
        return;
    }
    
    var_3a8b7ec4deea4ec2 = [];
    var_39359cced2413b15 = count ?? currentitem.count;
    dropquantity = function_d4e57b6b48d088b1( itemtype, { #isdrop:1, #var_eb659d64b0476d5c:var_eb659d64b0476d5c, #beingreplaced:isdefined( var_eb659d64b0476d5c ), #count:var_39359cced2413b15 } );
    var_5b1acdc055c31105 = dropquantity > 1 && itembundle.nonstackable;
    isweapon = itemtype == "weapon";
    
    if ( var_5b1acdc055c31105 )
    {
        spawnoptions.var_44d5025c8cfbd48e = dropquantity;
        
        for ( index = 0; index < dropquantity ; index++ )
        {
            spawnnum = 1;
            
            if ( index > 0 )
            {
                currentitem = self [[ callbacks.funcs[ #"getcurrent" ] ]]();
            }
            
            if ( itembundle.var_2b0a27d4be7d298b )
            {
                spawnnum = currentitem.durability ?? spawnnum;
            }
            else if ( itembundle.useCountAsKillstreakAmmo )
            {
                spawnnum = currentitem.count ?? spawnnum;
            }
            
            removeditem = self [[ callbacks.funcs[ #"removecurrent" ] ]]( { #isdrop:1, #var_eb659d64b0476d5c:var_eb659d64b0476d5c, #beingreplaced:isdefined( var_eb659d64b0476d5c ), #count:spawnnum } );
            
            if ( !removeditem )
            {
                break;
            }
            
            if ( itembundle.var_2b0a27d4be7d298b )
            {
                spawnnum = removeditem.durability;
            }
            else
            {
                spawnnum = !isweapon ? removeditem.count : 1;
            }
            
            if ( spawnnum > 0 )
            {
                itemsdropped = isweapon ? removeditem : function_61c2c0251e742ffd( itembundle, spawnnum, spawnoptions );
                
                if ( itemsdropped )
                {
                    if ( isarray( itemsdropped ) )
                    {
                        var_3a8b7ec4deea4ec2 = arraycombine( var_3a8b7ec4deea4ec2, itemsdropped );
                        continue;
                    }
                    
                    var_3a8b7ec4deea4ec2[ var_3a8b7ec4deea4ec2.size ] = itemsdropped;
                }
            }
        }
    }
    else
    {
        removeditem = self [[ callbacks.funcs[ #"removecurrent" ] ]]( { #isdrop:1, #var_eb659d64b0476d5c:var_eb659d64b0476d5c, #beingreplaced:isdefined( var_eb659d64b0476d5c ), #count:var_39359cced2413b15 } );
        
        if ( removeditem )
        {
            if ( itembundle.var_2b0a27d4be7d298b )
            {
                spawnnum = removeditem.durability;
            }
            else
            {
                spawnnum = !isweapon ? removeditem.count : 1;
            }
            
            if ( spawnnum > 0 )
            {
                itemsdropped = isweapon ? removeditem : function_61c2c0251e742ffd( itembundle, spawnnum, spawnoptions );
                
                if ( isarray( itemsdropped ) )
                {
                    if ( isdefined( removeditem.var_245b79f81d8bea18 ) )
                    {
                        foreach ( item in itemsdropped )
                        {
                            item.var_245b79f81d8bea18 = removeditem.var_245b79f81d8bea18;
                        }
                    }
                    
                    var_3a8b7ec4deea4ec2 = arraycombine( var_3a8b7ec4deea4ec2, itemsdropped );
                }
                else
                {
                    if ( isdefined( removeditem.var_245b79f81d8bea18 ) )
                    {
                        itemsdropped.var_245b79f81d8bea18 = removeditem.var_245b79f81d8bea18;
                    }
                    
                    var_3a8b7ec4deea4ec2[ var_3a8b7ec4deea4ec2.size ] = itemsdropped;
                }
            }
        }
    }
    
    return var_3a8b7ec4deea4ec2;
}

// Namespace common_item
// Params 2
// Checksum 0x54b73a1f, Offset: 0x2b5c
// Size: 0x3d
function function_360e96e0447f17f9( itembundle, packedcount )
{
    return function_3f39e7be347cf7e1( itembundle, { #count:packedcount, #type:itembundle.scriptable } );
}

// Namespace common_item
// Params 4
// Checksum 0x4b4f5fd3, Offset: 0x2ba2
// Size: 0x10c
function function_3f39e7be347cf7e1( itembundle, item, var_981c264073bf1154, autouse )
{
    itemtype = function_16e8c106491eeaca( itembundle );
    callbacks = function_9f00d6361edd38ce( itemtype );
    assert( isdefined( callbacks ), "<dev string:x143>" + itemtype + "<dev string:x17c>" );
    assert( isdefined( callbacks.funcs[ #"use" ] ), "<dev string:x242>" + itemtype + "<dev string:x17c>" );
    callback::callback( #"player_used_item", { #itemtype:itemtype, #itembundle:itembundle, #item:item } );
    var_981c264073bf1154 = item.var_f7d425332dfd14bc ?? var_981c264073bf1154 ?? items_initspawnoptions_spawnfromentity( self );
    var_981c264073bf1154.var_7a3bb21eb7f88248 = 1;
    return self [[ callbacks.funcs[ #"use" ] ]]( itembundle, item, autouse, var_981c264073bf1154 );
}

// Namespace common_item
// Params 7
// Checksum 0x609714c0, Offset: 0x2cb7
// Size: 0x298
function function_77600f92048df72d( itembundle, count = 1, weaponobj, groupindex, slotindex, currentitem, weapondata )
{
    if ( isxhashasset( itembundle ) )
    {
        itembundle = getscriptbundlefieldvalues( itembundle, [ #"scriptable" ] );
    }
    
    item = { #count:count, #weaponobj:weaponobj, #type:itembundle.scriptable };
    
    if ( weaponobj && !weapondata )
    {
        weapondata = item_weapon::function_fdc74b9be99fda2f( weaponobj );
    }
    
    if ( !weapondata && itembundle.ref && itembundle.baseweapon && function_16e8c106491eeaca( itembundle ) == "weapon" )
    {
        weapondata = item_weapon::function_e3101668a21a4237( itembundle );
    }
    
    if ( weapondata )
    {
        item.var_6828becb300b1c44 = { #weaponobj:weapondata.weaponobj, #camo:weapondata.camo, #variantid:weapondata.variantid, #ammomod:weapondata.ammomod, #paplv:weapondata.paplv, #rarity:weapondata.rarity ?? itembundle.rarity, #attachmentslots:weapondata.attachmentslots ?? itembundle.var_ef872c5384bdd7ce, #attachments:weapondata.attachments, #baseweapon:weapondata.baseweapon, #itembundlename:weapondata.itembundlename ?? function_e044c3e813daec3a( itembundle ) };
        item.var_951c89546ec50477 = weapondata.paplv;
        item.ammomod_name = weapondata.ammomod;
    }
    
    if ( function_16e8c106491eeaca( itembundle ) == "perk" )
    {
        item.ref = itembundle.ref;
    }
    
    if ( !currentitem.additionaldata && common_inventory_groups::inventorygroup_enabled() )
    {
        item.additionaldata = common_inventory_groups::function_af51bdd9c1c5acd3( groupindex, slotindex );
    }
    else
    {
        item.additionaldata = currentitem.additionaldata;
    }
    
    return item;
}

// Namespace common_item
// Params 2
// Checksum 0x6742a8ff, Offset: 0x2f58
// Size: 0x1d4
function function_a48ae6cbf7e8c2d5( item, lootid )
{
    itemdata = spawnstruct();
    itemdata.var_6828becb300b1c44 = item.var_6828becb300b1c44;
    itemdata.fromcache = item.fromcache;
    itemdata.fromriftreward = item.fromriftreward;
    itemdata.fromgroup = item.fromgroup;
    itemdata.lootid = lootid ?? function_6d301ac91c3cd13d( item );
    itemdata.origin = item.origin;
    itemdata.type = item.type;
    itemdata.critical = item.critical;
    itemdata.staged = item.staged;
    itemdata.var_22cae40c41e63f97 = item.var_22cae40c41e63f97;
    itemdata.additionaldata = item.additionaldata;
    itemdata.count = item.count;
    itemdata.objidnum = item.objidnum;
    itemdata.owner = item.owner;
    itemdata.var_245b79f81d8bea18 = item.var_245b79f81d8bea18;
    itemdata.analyticssource = item.analyticssource;
    assert( itemdata.lootid === function_6d301ac91c3cd13d( item ), "<dev string:x27c>" + ( itemdata.lootid ?? "<dev string:x29d>" ) + "<dev string:x2a7>" );
    return itemdata;
}

// Namespace common_item
// Params 1
// Checksum 0xa6984af3, Offset: 0x3135
// Size: 0x237
function function_7e9d780108e351ec( targetlootid )
{
    var_65d6f580838d6439 = getlootscriptablearrayinradius( undefined, undefined, self.origin, 100 );
    
    if ( var_65d6f580838d6439.size < 1 )
    {
        return;
    }
    
    var_9c413067219bc8b1 = targetlootid == item_weapon::function_e11b7333d211c17e();
    items = [];
    
    foreach ( scriptable in var_65d6f580838d6439 )
    {
        itembundlename = function_33a2c00e46263d99( scriptable );
        
        if ( !isdefined( itembundlename ) )
        {
            continue;
        }
        
        itembundle = getscriptbundlefieldvalues( itembundlename, [ #"ref", #"scriptable" ] );
        
        if ( !isdefined( itembundle.ref ) )
        {
            continue;
        }
        
        lootid = function_779887309ec71dfe( itembundle );
        typeref = function_9deb822f286163b1( lootid );
        
        if ( isdefined( lootid ) && ( targetlootid == lootid || typeref == "weapon" && var_9c413067219bc8b1 ) )
        {
            items[ items.size ] = scriptable;
        }
    }
    
    if ( items.size == 1 )
    {
        return items[ 0 ];
    }
    
    chosenscriptable = undefined;
    largestdot = 0;
    playerforward = anglestoforward( self getplayerangles() );
    
    foreach ( scriptable in items )
    {
        directionvec = vectornormalize( scriptable.origin - self.origin );
        dot = vectordot( playerforward, directionvec );
        
        if ( dot > largestdot )
        {
            largestdot = dot;
            chosenscriptable = scriptable;
        }
    }
    
    return chosenscriptable;
}

// Namespace common_item
// Params 1
// Checksum 0xf9ea668, Offset: 0x3375
// Size: 0xb2, Type: bool
function function_8a80eb5cf2c4100d( item )
{
    if ( !isdefined( item.origin ) )
    {
        return false;
    }
    
    var_f7e22249aace636e = ( self geteye()[ 2 ] + item.origin[ 2 ] ) / 2;
    var_551ef831afa55db4 = ( item.origin[ 0 ], item.origin[ 1 ], var_f7e22249aace636e );
    directiontoitem = vectornormalize( var_551ef831afa55db4 - self geteye() );
    playerangles = self getplayerangles();
    playerforward = anglestoforward( playerangles );
    return vectordot( directiontoitem, playerforward ) > level.var_b596da802bc4f04e;
}

// Namespace common_item
// Params 1
// Checksum 0x88f42d76, Offset: 0x3430
// Size: 0x17
function function_8d9d36a5c7542cab( value )
{
    self.var_62f907f38a53e046 = value;
}

// Namespace common_item
// Params 0, eflags: 0x4
// Checksum 0xa03bdb53, Offset: 0x344f
// Size: 0xc, Type: bool
function private function_ef9f3fbdd98fcdf8()
{
    return !self.var_62f907f38a53e046;
}

// Namespace common_item
// Params 0
// Checksum 0xcb1beea9, Offset: 0x3464
// Size: 0x33
function function_dba5cd48d3cd08cb()
{
    self setclientomnvar( "ui_loot_splash_item_quantity", 0 );
    self setclientomnvar( "ui_loot_splash_item_id", 0 );
    self setclientomnvar( "ui_loot_splash_item_item_bundle", 0 );
    self.var_99b332896ef6acc1 = gettime();
}

// Namespace common_item
// Params 3
// Checksum 0x23c02b35, Offset: 0x349f
// Size: 0x2a2
function function_29cda7adf128f6fb( itembundle, itemcount, itemdata )
{
    self notify( #"hash_92ee10be2566118d" );
    self endon( #"disconnect" );
    
    if ( !function_ef9f3fbdd98fcdf8() )
    {
        return;
    }
    
    if ( common_inventory_groups::inventorygroup_enabled() && isdefined( itemdata.fromgroup ) )
    {
        switch ( itemdata.fromgroup )
        {
            case 1:
            case 2:
            case 4:
            case 5:
            case 7:
                return;
        }
    }
    
    if ( self.var_99b332896ef6acc1 )
    {
        while ( self.var_99b332896ef6acc1 + level.frameduration * 3 > gettime() )
        {
            waitframe();
        }
    }
    else
    {
        waitframe();
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    quantity = 0;
    itemtype = function_16e8c106491eeaca( itembundle );
    shouldshowquantity = ( itembundle.maxcount > 0 || itemtype == "currency" ) && !itembundle.var_6a53527f8469a346 && !itembundle.var_2b0a27d4be7d298b && !itembundle.useCountAsKillstreakAmmo;
    
    if ( shouldshowquantity && isdefined( itemcount ) )
    {
        quantity = itemcount;
    }
    
    lootid = itemdata.lootid ?? function_779887309ec71dfe( itembundle );
    
    if ( isdefined( lootid ) )
    {
        var_9ffea708a12df7c3 = undefined;
        
        if ( itemtype == "weapon" )
        {
            itembundlename = common_item_database::function_ca9ca606e66b5911( itembundle.scriptable );
            
            if ( isdefined( itembundlename ) )
            {
                var_9ffea708a12df7c3 = function_43b5ed5a14a56573( #"scriptbundle_itemspawnentry", itembundlename );
            }
        }
        
        if ( !function_269312c5169813e5( "ui_loot_splash_item_quantity", quantity ) )
        {
            itembundlename = common_item_database::function_ca9ca606e66b5911( itembundle.scriptable );
            assertmsg( "<dev string:x2e4>" + "<dev string:x36f>" + quantity + "<dev string:x37e>" + getxhashsourcename( itembundlename ) + "<dev string:x390>" );
            quantity = 0;
        }
        
        self setclientomnvar( "ui_loot_splash_item_quantity", quantity );
        self setclientomnvar( "ui_loot_splash_item_id", lootid );
        self setclientomnvar( "ui_loot_splash_item_item_bundle", var_9ffea708a12df7c3 ?? 0 );
        self.var_99b332896ef6acc1 = gettime();
    }
    else
    {
        /#
            itembundlename = common_item_database::function_ca9ca606e66b5911( itembundle.scriptable );
            
            if ( isdefined( itembundlename ) )
            {
                assertmsg( "<dev string:x43c>" + getxhashsourcename( itembundlename ) );
            }
        #/
    }
    
    self endon( #"hash_92ee10be2566118d" );
    waitframe();
    function_dba5cd48d3cd08cb();
}

// Namespace common_item
// Params 2
// Checksum 0x7a2a7df3, Offset: 0x3749
// Size: 0x15e
function function_c63738c9201561aa( player, var_4c48fad50fa1fc28 )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    count = 0;
    
    foreach ( item in var_4c48fad50fa1fc28 )
    {
        count++;
        
        if ( !isdefined( item.count ) || item.count <= 0 )
        {
            continue;
        }
        
        if ( !isdefined( item.ref ) || item.ref == "" )
        {
            continue;
        }
        
        lootid = items_getlootidfromref( item.ref );
        itembundle = function_b202b16941992cca( lootid );
        
        if ( !isdefined( itembundle.ref ) )
        {
            continue;
        }
        
        player function_29cda7adf128f6fb( itembundle, item.count );
        wait count % 3 == 0 ? 1.5 : 0.1;
    }
}

// Namespace common_item
// Params 2
// Checksum 0x7a1e1ac8, Offset: 0x38af
// Size: 0x86
function function_f852430ffb889f14( origin, var_e099cccf5dd2152a )
{
    if ( utility::issharedfuncdefined( #"game", #"hash_9067d157d8b692fd" ) )
    {
        bundle = utility::callsharedfunc( #"game", #"hash_9067d157d8b692fd", origin );
        
        if ( isdefined( var_e099cccf5dd2152a ) )
        {
            var_16d763e03ef0bbc = getscriptbundlefieldvalues( bundle, var_e099cccf5dd2152a );
            return var_16d763e03ef0bbc;
        }
        
        var_6f1fab09e4a30dcb = getscriptbundle( bundle );
        return var_6f1fab09e4a30dcb;
    }
}

// Namespace common_item
// Params 2
// Checksum 0xc7af52e0, Offset: 0x393d
// Size: 0x81, Type: bool
function function_ea3b3088d82fd357( itembundle, var_3b8f1509495546fd )
{
    if ( itembundle.spawncount > 0 )
    {
        count = itembundle.spawncount;
    }
    else
    {
        itemtype = function_16e8c106491eeaca( itembundle );
        var_c5d456c5d3291e6b = function_c6f3ef3dcb4c55c0( itemtype, #"getspawncount" );
        
        if ( isdefined( var_c5d456c5d3291e6b ) )
        {
            count = [[ var_c5d456c5d3291e6b ]]( itembundle, var_3b8f1509495546fd );
        }
    }
    
    return count ?? 1;
}

// Namespace common_item
// Params 2
// Checksum 0x81c85428, Offset: 0x39c7
// Size: 0x6b, Type: bool
function function_8c20f7b0f2737794( itembundle, player )
{
    var_a7424ebc74e7ce62 = istrue( itembundle.autopickupenabled );
    itemtype = function_16e8c106491eeaca( itembundle );
    var_e0b11e9f92c09c98 = function_c6f3ef3dcb4c55c0( itemtype, #"hash_a58b880686dd682c" );
    
    if ( isdefined( var_e0b11e9f92c09c98 ) )
    {
        var_a7424ebc74e7ce62 = [[ var_e0b11e9f92c09c98 ]]( itembundle, player );
    }
    
    return istrue( var_a7424ebc74e7ce62 );
}

// Namespace common_item
// Params 2
// Checksum 0x96ce48ad, Offset: 0x3a3b
// Size: 0x32
function function_3a06b3786d98047e( itemtype, itemindex )
{
    if ( isdefined( level.var_2783dd05c7f71d73 ) )
    {
        return self [[ level.var_2783dd05c7f71d73 ]]( itemtype, itemindex );
    }
}

// Namespace common_item
// Params 3
// Checksum 0xb7fd8538, Offset: 0x3a75
// Size: 0x67
function function_db61e190f60b2349( dropstruct, itembundle, itemindex )
{
    if ( !isdefined( dropstruct ) )
    {
        assertmsg( "<dev string:x476>" );
        return;
    }
    
    if ( !isdefined( itembundle ) )
    {
        assertmsg( "<dev string:x4c0>" );
        return;
    }
    
    dropstruct.var_814f92cbd4ba7a8d = function_3a06b3786d98047e( itembundle.type, itemindex );
}

// Namespace common_item
// Params 4
// Checksum 0x77330b0c, Offset: 0x3ae4
// Size: 0x10e
function function_6b392f3e5fc53c0d( item, itembundle, remainder, nopop )
{
    if ( !isdefined( item ) || item.count == remainder && item.count > 0 )
    {
        return remainder;
    }
    
    var_97033347293dacce = !isstruct( item ) && item isscriptableinstance();
    
    if ( remainder > 0 )
    {
        item.count = remainder;
        itemcount = remainder;
        
        if ( var_97033347293dacce && !nopop && !level.gametypebundle.var_300975d7cc63afd0 )
        {
            newitem = function_9d4ae27b4634d928( item, itembundle, 1 );
            
            if ( newitem && isplayer( self ) )
            {
                items_additemautopickupcooldownforplayer( self, newitem, 5 );
            }
        }
    }
    else
    {
        item.count = 0;
        itemcount = 0;
        
        if ( var_97033347293dacce )
        {
            function_869d7676e359a627( item );
        }
    }
    
    return itemcount;
}

// Namespace common_item
// Params 3
// Checksum 0xc83b7b3b, Offset: 0x3bfb
// Size: 0x2a0
function function_9d4ae27b4634d928( item, itembundle, height )
{
    if ( item.var_7a65426f252841e7 || itembundle.disablepopup )
    {
        return;
    }
    
    iscritical = item.critical;
    var_22cae40c41e63f97 = item.var_22cae40c41e63f97;
    var_7da3d62d2db56e16 = item.var_fd47e835523b473f;
    itemcount = item.count;
    var_f3441fa93d95027a = item.var_f3441fa93d95027a;
    origin = isdefined( var_f3441fa93d95027a ) ? var_f3441fa93d95027a.finalorigin : level.var_608f2b17211c7ff4 ? item.origin : getgroundposition( item.origin, 1 );
    angles = isdefined( var_f3441fa93d95027a ) ? var_f3441fa93d95027a.finalangles : item.angles;
    groundentity = isdefined( var_f3441fa93d95027a ) ? var_f3441fa93d95027a.groundentity : undefined;
    
    if ( level.var_608f2b17211c7ff4 > 2 && itembundle.var_259a7b10279f7c55 )
    {
        angles = ( itembundle.var_259a7b10279f7c55.x ?? angles[ 0 ] ?? 0, itembundle.var_259a7b10279f7c55.y ?? angles[ 1 ] ?? 0, itembundle.var_259a7b10279f7c55.z ?? angles[ 2 ] ?? 0 );
    }
    
    function_869d7676e359a627( item );
    baseorigin = level.var_608f2b17211c7ff4 ? origin : getgroundposition( origin, 1 );
    payload = calcscriptablepayloadgravityarc( baseorigin + ( 0, 0, height ), baseorigin );
    positioningresults = function_b4bee4333994e45a( baseorigin, angles, payload, groundentity );
    spawnoptions = { #var_fd47e835523b473f:var_7da3d62d2db56e16, #critical:iscritical };
    newitem = function_2352d25db9e97696( itembundle, itemcount, positioningresults, spawnoptions );
    newitem.critical = iscritical;
    newitem.var_22cae40c41e63f97 = var_22cae40c41e63f97;
    newitem.var_f3441fa93d95027a = var_f3441fa93d95027a;
    
    if ( isplayer( self ) )
    {
        newitem.originalowner = self;
        newitem.spawningteam = self.team;
    }
    
    return newitem;
}

// Namespace common_item
// Params 5
// Checksum 0x1ac1b4b2, Offset: 0x3ea4
// Size: 0x1f9
function function_5f81801cb8c86ac2( itembundlename, itembundle, item, autouse = 0, itemtype = function_16e8c106491eeaca( itembundle ) )
{
    assert( itemtype == function_16e8c106491eeaca( itembundle ), "<dev string:x50a>" );
    callbacks = function_9f00d6361edd38ce( itemtype );
    canuse = 1;
    
    if ( autouse )
    {
        if ( isdefined( callbacks.funcs[ #"canautouse" ] ) )
        {
            canuse = self [[ callbacks.funcs[ #"canautouse" ] ]]( itembundle, item, autouse, 0 );
            
            if ( !canuse )
            {
                return 0;
            }
        }
        
        if ( isdefined( callbacks.funcs[ #"caninteract" ] ) )
        {
            canuse = self [[ callbacks.funcs[ #"caninteract" ] ]]( { #item:item, #itembundle:itembundle } ) ?? 0;
        }
        else
        {
            canuse = self function_a35b39392c23339f( { #weaponobj:item.weaponobj, #itembundlename:itembundlename } );
        }
    }
    else
    {
        if ( isdefined( callbacks.funcs[ #"hash_9e49dfaa7c147654" ] ) )
        {
            canuse = self [[ callbacks.funcs[ #"hash_9e49dfaa7c147654" ] ]]( itembundle, item, autouse, 0 );
            
            if ( !canuse )
            {
                return 0;
            }
        }
        
        if ( isdefined( callbacks.funcs[ #"caninteract" ] ) )
        {
            canuse = self [[ callbacks.funcs[ #"caninteract" ] ]]( { #item:item, #itembundle:itembundle } ) ?? 0;
        }
        else
        {
            canuse = self function_a35b39392c23339f( { #weaponobj:item.weaponobj, #itembundlename:itembundlename } );
        }
    }
    
    return canuse;
}

// Namespace common_item
// Params 2
// Checksum 0xada2afce, Offset: 0x40a6
// Size: 0x9a
function function_974a788b833e282b( item, itembundle )
{
    if ( !isdefined( item ) )
    {
        return 0;
    }
    
    if ( !isdefined( itembundle ) )
    {
        itembundle = function_6b8ff3d5f2688336( item );
    }
    
    assert( !isdefined( itembundle ) || itembundle.ref == function_6b8ff3d5f2688336( item ).ref, "<dev string:x582>" );
    
    if ( itembundle.var_2b0a27d4be7d298b || itembundle.useCountAsKillstreakAmmo )
    {
        return item.count;
    }
    
    return function_44eacd480abb5b94( item.count );
}

// Namespace common_item
// Params 2
// Checksum 0x19f5db69, Offset: 0x4149
// Size: 0x80
function function_b4807b3f2255f9fa( lootid, quantity )
{
    if ( !lootid || !quantity )
    {
        return 0;
    }
    
    if ( !isdefined( itembundle ) )
    {
        itembundle = function_b202b16941992cca( lootid, [ #"hash_35a6ff448ffc0318", #"useCountAsKillstreakAmmo" ] );
    }
    
    if ( itembundle.var_2b0a27d4be7d298b || itembundle.useCountAsKillstreakAmmo )
    {
        return quantity;
    }
    
    return function_44eacd480abb5b94( quantity );
}

// Namespace common_item
// Params 1
// Checksum 0x1eb5e0c0, Offset: 0x41d2
// Size: 0x21
function function_44eacd480abb5b94( packedcount )
{
    if ( !isdefined( packedcount ) )
    {
        return 0;
    }
    
    return int( packedcount ) >> 0 & 2047;
}

// Namespace common_item
// Params 1
// Checksum 0xa3180f5d, Offset: 0x41fc
// Size: 0x22
function function_5c3ce1ec7db94488( packedcount )
{
    if ( !isdefined( packedcount ) )
    {
        return 0;
    }
    
    return int( packedcount ) >> 11 & 2047;
}

// Namespace common_item
// Params 1
// Checksum 0x3f73fec3, Offset: 0x4227
// Size: 0x21
function function_3b2613fcafd07797( packedcount )
{
    if ( !isdefined( packedcount ) )
    {
        return 0;
    }
    
    return int( packedcount ) >> 22 & 127;
}

// Namespace common_item
// Params 1
// Checksum 0xa4055b07, Offset: 0x4251
// Size: 0x21
function function_970735d3001edb67( packedcount )
{
    if ( !isdefined( packedcount ) )
    {
        return 0;
    }
    
    return int( packedcount ) >> 29 & 7;
}

// Namespace common_item
// Params 4
// Checksum 0x1609ce0d, Offset: 0x427b
// Size: 0x14b
function function_598dd39282efb544( itemcount, itemcountlefthand, itemcountalt, itemcountrarity )
{
    count = 0;
    
    if ( isdefined( itemcount ) )
    {
        itemcount = int( itemcount );
        
        if ( itemcount < 2048 )
        {
            count |= ( itemcount & 2047 ) << 0;
        }
        else
        {
            assertmsg( "<dev string:x5ec>" + itemcount + "<dev string:x622>" + 2048 + "<dev string:x17c>" );
        }
    }
    
    if ( isdefined( itemcountlefthand ) )
    {
        itemcountlefthand = int( itemcountlefthand );
        
        if ( itemcountlefthand < 2048 )
        {
            count |= ( itemcountlefthand & 2047 ) << 11;
        }
        else
        {
            assertmsg( "<dev string:x64f>" + itemcountlefthand + "<dev string:x622>" + 2048 + "<dev string:x17c>" );
        }
    }
    
    if ( isdefined( itemcountalt ) )
    {
        itemcountalt = int( itemcountalt );
        
        if ( itemcountalt < 128 )
        {
            count |= ( itemcountalt & 127 ) << 22;
        }
        else
        {
            assertmsg( "<dev string:x68d>" + itemcountalt + "<dev string:x622>" + 128 + "<dev string:x17c>" );
        }
    }
    
    if ( isdefined( itemcountrarity ) )
    {
        itemcountrarity = int( itemcountrarity );
        
        if ( itemcountrarity < 8 )
        {
            count |= ( itemcountrarity & 7 ) << 29;
        }
        else
        {
            assertmsg( "<dev string:x6c6>" + itemcountrarity + "<dev string:x622>" + 8 + "<dev string:x17c>" );
        }
    }
    
    return count;
}

// Namespace common_item
// Params 5
// Checksum 0x84e48a3d, Offset: 0x43cf
// Size: 0xcf
function items_setitemcount( item, itemcount, itemcountlefthand, itemcountalt, itemcountrarity )
{
    count = 0;
    assert( isdefined( item ) );
    assert( itemcount < 2048 );
    count += ( itemcount & 2047 ) << 0;
    
    if ( isdefined( itemcountlefthand ) )
    {
        assert( itemcountlefthand < 2048 );
        count += ( itemcountlefthand & 2047 ) << 11;
    }
    
    if ( isdefined( itemcountalt ) )
    {
        assert( itemcountalt < 128 );
        count += ( itemcountalt & 127 ) << 22;
    }
    
    if ( isdefined( itemcountrarity ) )
    {
        assert( itemcountrarity < 8 );
        count += ( itemcountrarity & 7 ) << 29;
    }
    
    item.count = count;
}

// Namespace common_item
// Params 5
// Checksum 0x8db3914a, Offset: 0x44a6
// Size: 0x134
function function_38cde6a6acb68ea6( listbundlename, count, spawnoptions, overridecount, var_4b8fce1b774973c0 )
{
    var_8b5270de14dff72e = items_selectfromlist( listbundlename, count, undefined, var_4b8fce1b774973c0 );
    
    if ( !var_8b5270de14dff72e )
    {
        assertmsg( "<dev string:x702>" + getxhashsourcename( listbundlename ) + "<dev string:x17c>" );
        return [];
    }
    
    var_7b7356588f3234fa = [];
    
    for ( i = 0; i < var_8b5270de14dff72e.size ; i++ )
    {
        itemspawnentryname = var_8b5270de14dff72e[ i ];
        
        if ( !itemspawnentryname )
        {
            continue;
        }
        
        itembundle = getscriptbundle( itemspawnentryname );
        
        if ( !itembundle )
        {
            assertmsg( "<dev string:x73f>" + getxhashsourcename( itemspawnentryname ) + "<dev string:x772>" + getxhashsourcename( listbundlename ) + "<dev string:x17c>" );
            continue;
        }
        
        if ( !namespace_9d8e359c3b1041e5::function_a7918caa4f9819eb( itembundle.scriptable ) )
        {
            continue;
        }
        
        spawneditems = function_61c2c0251e742ffd( itembundle, overridecount, spawnoptions );
        
        if ( spawneditems )
        {
            if ( isarray( spawneditems ) )
            {
                var_7b7356588f3234fa = arraycombine( var_7b7356588f3234fa, spawneditems );
                continue;
            }
            
            var_7b7356588f3234fa[ var_7b7356588f3234fa.size ] = spawneditems;
        }
    }
    
    return var_7b7356588f3234fa;
}

// Namespace common_item
// Params 7
// Checksum 0x40d8c722, Offset: 0x45e3
// Size: 0x6a
function function_577fe3f000fcb275( var_8a8dba0d511b9ce5, count, listbundlename, spawnoptions, overridecount, var_4b8fce1b774973c0, asblocker )
{
    if ( !asblocker )
    {
        level thread function_5af1f003a0bc6f55( var_8a8dba0d511b9ce5, count, listbundlename, spawnoptions, overridecount, var_4b8fce1b774973c0 );
        return;
    }
    
    return function_5af1f003a0bc6f55( var_8a8dba0d511b9ce5, count, listbundlename, spawnoptions, overridecount, var_4b8fce1b774973c0 );
}

// Namespace common_item
// Params 4
// Checksum 0x482c71c6, Offset: 0x4655
// Size: 0x58
function items_selectfromlist( listbundlename, count, seed, var_4b8fce1b774973c0 )
{
    if ( !listbundlename )
    {
        assertmsg( "<dev string:x785>" );
        return;
    }
    
    if ( isstring( listbundlename ) )
    {
        listbundlename = "itemspawnlist:" + listbundlename;
    }
    
    return function_c11af7a197679429( listbundlename, count, seed, var_4b8fce1b774973c0 );
}

// Namespace common_item
// Params 6, eflags: 0x4
// Checksum 0x1570b86b, Offset: 0x46b6
// Size: 0x159
function private function_5af1f003a0bc6f55( var_8a8dba0d511b9ce5, count, listbundlename, spawnoptions, overridecount, var_4b8fce1b774973c0 )
{
    level endon( #"game_ended" );
    var_8b5270de14dff72e = items_selectfromlist( listbundlename, count, undefined, var_4b8fce1b774973c0 );
    
    if ( !var_8b5270de14dff72e )
    {
        assertmsg( "<dev string:x702>" + getxhashsourcename( listbundlename ) + "<dev string:x17c>" );
        return;
    }
    
    var_7b7356588f3234fa = [];
    
    for ( i = 0; i < var_8b5270de14dff72e.size ; i++ )
    {
        itemspawnentryname = var_8b5270de14dff72e[ i ];
        
        if ( !itemspawnentryname )
        {
            continue;
        }
        
        itembundle = getscriptbundle( itemspawnentryname );
        
        if ( !itembundle )
        {
            assertmsg( "<dev string:x73f>" + getxhashsourcename( itemspawnentryname ) + "<dev string:x772>" + getxhashsourcename( listbundlename ) + "<dev string:x17c>" );
            continue;
        }
        
        if ( !namespace_9d8e359c3b1041e5::function_a7918caa4f9819eb( itembundle.scriptable ) )
        {
            continue;
        }
        
        spawneditems = function_61c2c0251e742ffd( itembundle, overridecount, spawnoptions );
        
        if ( spawneditems )
        {
            if ( isarray( spawneditems ) )
            {
                var_7b7356588f3234fa = arraycombine( var_7b7356588f3234fa, spawneditems );
            }
            else
            {
                var_7b7356588f3234fa[ var_7b7356588f3234fa.size ] = spawneditems;
            }
        }
        
        wait var_8a8dba0d511b9ce5;
    }
    
    level notify( #"hash_19c9a695e7ebc5cc", var_7b7356588f3234fa );
    return var_7b7356588f3234fa;
}

// Namespace common_item
// Params 6
// Checksum 0x5bca5dda, Offset: 0x4818
// Size: 0xa8
function function_47324f290423b2d1( itembundle, itemorigin, itemlanding, overridecount, nocleanup, var_3b8f1509495546fd )
{
    if ( !isstruct( itembundle ) && !isxhashasset( itembundle ) )
    {
        assertmsg( "<dev string:x7c8>" );
        return;
    }
    
    spawnoptions = var_3b8f1509495546fd ?? function_f5dfaa3bbdf99a33( itemlanding, itemorigin );
    spawnoptions.critical = nocleanup;
    spawnoptions.var_fd47e835523b473f = nocleanup;
    item = function_61c2c0251e742ffd( itembundle, overridecount, spawnoptions );
    return item;
}

// Namespace common_item
// Params 6
// Checksum 0x297d4016, Offset: 0x48c9
// Size: 0x104
function function_a87dc047f584d2c7( itembundle, itemorigin, itemangles = ( 0, 0, 0 ), overridecount, critical, payload )
{
    if ( !isstruct( itembundle ) && !isxhashasset( itembundle ) )
    {
        assertmsg( "<dev string:x7c8>" );
        return;
    }
    
    if ( isxhashasset( itembundle ) )
    {
        itembundle = getscriptbundle( itembundle );
    }
    
    count = overridecount ?? function_ea3b3088d82fd357( itembundle );
    positioningdata = function_b4bee4333994e45a( itemorigin, itemangles, payload );
    spawnoptions = function_bc5ff2958b71a708( itemorigin, itemangles );
    spawnoptions.critical = critical;
    spawnoptions.payload = payload;
    spawneditems = function_2352d25db9e97696( itembundle, count, positioningdata, spawnoptions );
    return isarray( spawneditems ) ? spawneditems[ 0 ] : spawneditems;
}

// Namespace common_item
// Params 6
// Checksum 0xbdb58d66, Offset: 0x49d6
// Size: 0x12f
function items_spawnnewitemfromscriptable( scriptablename, itemorigin, itemangles, overridecount, critical, payload )
{
    if ( !isdefined( scriptablename ) || !common_item_database::function_9eeb5b816d2c20c0( scriptablename ) )
    {
        /#
            if ( !isdefined( scriptablename ) )
            {
                assertmsg( "<dev string:x812>" );
                return;
            }
            
            if ( isstring( scriptablename ) )
            {
                assertmsg( "<dev string:x868>" + scriptablename + "<dev string:x8b3>" );
                return;
            }
            
            if ( isxhashasset( scriptablename ) )
            {
                assertmsg( "<dev string:x868>" + getxhashsourcename( scriptablename ) + "<dev string:x8b3>" );
                return;
            }
            
            assertmsg( "<dev string:x8b6>" );
        #/
        
        return;
    }
    
    itembundlename = common_item_database::function_ca9ca606e66b5911( scriptablename );
    
    if ( !isdefined( itembundlename ) )
    {
        assertmsg( "<dev string:x938>" + scriptablename + "<dev string:x978>" );
        return;
    }
    
    itembundle = getscriptbundle( itembundlename );
    
    if ( !isdefined( itembundle ) )
    {
        assertmsg( "<dev string:x99f>" + getxhashsourcename( itembundlename ) + "<dev string:x978>" );
        return;
    }
    
    return function_a87dc047f584d2c7( itembundle, itemorigin, itemangles, overridecount, critical, payload );
}

// Namespace common_item
// Params 3
// Checksum 0x6f68471d, Offset: 0x4b0e
// Size: 0x166
function items_additemautopickupcooldownforplayer( player, item, time )
{
    item notify( #"hash_c644bd109f432f0" );
    item endon( #"hash_c644bd109f432f0" );
    item endon( #"death" );
    level endon( #"game_ended" );
    
    if ( !isent( player ) || !isplayer( player ) )
    {
        return;
    }
    
    name = common_item_database::function_ca9ca606e66b5911( item.type );
    
    if ( isdefined( name ) )
    {
        itemtype = function_3cba34a99d02cd9( name );
        
        if ( isdefined( itemtype ) )
        {
            var_e9db8baa87fbef43 = function_c6f3ef3dcb4c55c0( itemtype, #"hash_6705e43822cdd8da" );
            
            if ( isdefined( var_e9db8baa87fbef43 ) )
            {
                [ cooldownenabled, newtime ] = [[ var_e9db8baa87fbef43 ]]( item, player, time );
                
                if ( !cooldownenabled )
                {
                    return;
                }
                
                time = newtime;
            }
        }
    }
    
    if ( !isdefined( item.var_856a1dbbb3cb703a ) )
    {
        item.var_856a1dbbb3cb703a = [];
    }
    
    playernum = player.clientid;
    endtime = gettime() + time * 1000;
    
    if ( item.var_856a1dbbb3cb703a[ playernum ] > endtime )
    {
        return;
    }
    
    item.var_856a1dbbb3cb703a[ playernum ] = endtime;
}

// Namespace common_item
// Params 1
// Checksum 0x96eb1730, Offset: 0x4c7c
// Size: 0xd9
function function_55a1e92020db856a( item )
{
    if ( !isdefined( item.spawningteam ) )
    {
        return;
    }
    
    foreach ( key in getarraykeys( item.var_856a1dbbb3cb703a ) )
    {
        playerteam = level.players[ key ].team;
        
        if ( isdefined( playerteam ) && playerteam != item.spawningteam )
        {
            item.var_856a1dbbb3cb703a[ key ] = undefined;
        }
    }
}

// Namespace common_item
// Params 1, eflags: 0x4
// Checksum 0x40ec220, Offset: 0x4d5d
// Size: 0x7c
function private items_cleanupdropcache( ent )
{
    var_41a9723c32c56d1a = 120;
    ent notify( #"items_cleanupdropcache" );
    ent endon( #"items_cleanupdropcache" );
    ent endon( #"death" );
    level endon( #"game_ended" );
    wait var_41a9723c32c56d1a;
    ent.dropcache = undefined;
    ent.var_e2025b3857123cc8 = undefined;
    ent.var_cb1849bfbe476505 = undefined;
    ent.var_eb8827f5c495b85e = undefined;
}

// Namespace common_item
// Params 5, eflags: 0x4
// Checksum 0xc2f8cf7e, Offset: 0x4de1
// Size: 0x138
function private function_7bd14a3bd0d32183( ent, item, bundlename, itemtype, positioningresults )
{
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    if ( !isdefined( ent.dropcache ) )
    {
        ent.dropcache = [];
    }
    
    if ( !isdefined( ent.var_e2025b3857123cc8 ) )
    {
        ent.var_e2025b3857123cc8 = [];
    }
    
    if ( isdefined( positioningresults ) )
    {
        item.var_f3441fa93d95027a = positioningresults;
    }
    
    ent.dropcache[ bundlename ] = item;
    ent.var_e2025b3857123cc8[ itemtype ] = item;
    
    if ( positioningresults.finalorigin )
    {
        if ( !isdefined( ent.var_eb8827f5c495b85e ) )
        {
            ent.var_eb8827f5c495b85e = 0;
        }
        
        if ( !isdefined( ent.var_cb1849bfbe476505 ) )
        {
            ent.var_cb1849bfbe476505 = [];
        }
        
        ent.var_cb1849bfbe476505[ ent.var_eb8827f5c495b85e ] = positioningresults.finalorigin;
        ent.var_eb8827f5c495b85e++;
        ent.var_eb8827f5c495b85e %= 3;
    }
    
    thread items_cleanupdropcache( ent );
}

// Namespace common_item
// Params 4, eflags: 0x4
// Checksum 0x587a45d6, Offset: 0x4f21
// Size: 0x1f9
function private function_c43e193e8e860dbb( ent, itembundle, itemtype, count )
{
    if ( !( isdefined( ent ) && isdefined( itembundle ) && isdefined( count ) ) )
    {
        return;
    }
    
    itembundlename = function_e044c3e813daec3a( itembundle );
    
    if ( !( isdefined( itembundlename ) && isdefined( ent.dropcache ) ) )
    {
        return;
    }
    
    if ( !function_7e69acc1ffc5adc0( itembundlename ) )
    {
        return;
    }
    
    if ( function_651cfd00ce6c6838( itembundlename ) )
    {
        cacheditem = ent.var_e2025b3857123cc8[ itemtype ];
    }
    else
    {
        cacheditem = ent.dropcache[ itembundlename ];
    }
    
    if ( !cacheditem )
    {
        return;
    }
    
    if ( distancesquared( cacheditem.origin, ent.origin ) > 20000 )
    {
        return;
    }
    
    newitemcount = function_44eacd480abb5b94( count );
    var_1e505ba4a5a920c6 = function_5c3ce1ec7db94488( count );
    var_3bff3aaa8a5ad0a1 = function_3b2613fcafd07797( count );
    currentcount = function_974a788b833e282b( cacheditem );
    var_ce572b9cbdfe3192 = function_5c3ce1ec7db94488( cacheditem.count );
    var_9fbd0e1c0c5f1e21 = function_3b2613fcafd07797( cacheditem.count );
    count = currentcount + newitemcount;
    countlefthand = var_ce572b9cbdfe3192 + var_1e505ba4a5a920c6;
    countalt = var_9fbd0e1c0c5f1e21 + var_3bff3aaa8a5ad0a1;
    
    if ( count >= 2048 || countlefthand >= 2048 || countalt >= 2048 )
    {
        return;
    }
    
    newcount = function_598dd39282efb544( count, countlefthand, countalt );
    var_d1cad7349c1a16c = function_c6f3ef3dcb4c55c0( itemtype, #"hash_5fe1ba8c30bcba11" );
    
    if ( var_d1cad7349c1a16c )
    {
        itembundle = function_90c3e0c1fd55d6b6( [[ var_d1cad7349c1a16c ]]( itembundle.subtype, newcount ) );
    }
    
    cacheditem.count = newcount;
    return function_9d4ae27b4634d928( cacheditem, itembundle, 12 );
}

// Namespace common_item
// Params 3, eflags: 0x4
// Checksum 0x2757397a, Offset: 0x5123
// Size: 0x312
function private function_38f74ee40c2999b9( itembundle, count, spawnoptions )
{
    if ( !isdefined( itembundle ) )
    {
        assertmsg( "<dev string:x9e2>" );
        return;
    }
    
    if ( !function_81b3ee2ff16cc3f0( spawnoptions ) )
    {
        assertmsg( "<dev string:xa14>" + function_7a9533425bd9a67f( itembundle ) + "<dev string:xa6e>" );
        return;
    }
    
    if ( !isdefined( count ) )
    {
        count = function_ea3b3088d82fd357( itembundle, spawnoptions ) ?? 1;
    }
    
    itembundlename = function_aa1699f78ccb3f3d( itembundle );
    spawneditems = undefined;
    spawningentity = spawnoptions.spawningentity;
    spawnoptions.var_d515ff001fe9ed9c = undefined;
    
    if ( isdefined( itembundlename ) )
    {
        spawnoptions.spawnitemsize = getscriptbundlefieldvalue( itembundlename, #"size" );
    }
    else
    {
        var_ffef3f1941ee7bc4 = function_ba684cbdb7194241( itembundle );
        assertmsg( "<dev string:xa76>" + var_ffef3f1941ee7bc4 + "<dev string:xad5>" + ( spawnoptions.weapon.basename ?? "<dev string:xae9>" ) + "<dev string:xaf3>" );
    }
    
    typestring = function_16e8c106491eeaca( itembundle );
    
    if ( spawnoptions.var_fd76732c1cbd4b05 || !spawnoptions.var_90cdc5dbcd319e5d && !function_14876f2cf8d634b8( itembundle, spawnoptions ) )
    {
        spawneditems = function_c43e193e8e860dbb( spawningentity, itembundle, typestring, count );
    }
    
    if ( !isdefined( spawneditems ) )
    {
        if ( isent( spawningentity ) && isplayer( spawningentity ) && spawnoptions.var_cce4312374b1b531 )
        {
            spawnoptions.spawnpositionindex = function_d121c2c924c18e19( spawningentity );
        }
        
        spawnoptions.var_a8cf639dcda6a7e5 = itembundle.var_18608bd8660b3a19;
        spawnoptions.var_a8b08eb03152fd48 = itembundle.var_259a7b10279f7c55;
        positioningresults = function_d94b7cedcd3ae9d0( spawnoptions );
        spawneditems = function_2352d25db9e97696( itembundle, count, positioningresults, spawnoptions );
    }
    
    if ( isdefined( spawneditems ) && !isarray( spawneditems ) && !function_14876f2cf8d634b8( itembundle, spawnoptions ) )
    {
        function_7bd14a3bd0d32183( spawningentity, spawneditems, itembundlename, typestring, positioningresults );
        
        if ( isent( spawningentity ) && isplayer( spawningentity ) )
        {
            if ( !spawnoptions.isdeathevent && !spawnoptions.var_8a5a7905ab5aaf83 )
            {
                items_additemautopickupcooldownforplayer( spawningentity, spawneditems, 300 );
            }
            
            params = { #weaponobj:spawnoptions.weapon, #itembundlename:itembundlename, #item:spawneditems };
            spawningentity callback::callback( #"player_item_drop", params );
            
            if ( isdefined( itembundle.ref ) )
            {
                lootid = function_779887309ec71dfe( itembundle );
                spawningentity items_analytics( lootid, undefined, undefined, undefined, undefined, typestring, undefined, undefined, spawneditems.type, spawneditems.origin, count, undefined, undefined, spawneditems.originalowner, undefined, spawneditems.analyticssource );
            }
        }
    }
    
    return spawneditems;
}

// Namespace common_item
// Params 3
// Checksum 0xb5af4a4a, Offset: 0x543e
// Size: 0x256
function function_61c2c0251e742ffd( itembundle, count, spawnoptions )
{
    if ( !isdefined( itembundle ) )
    {
        assertmsg( "<dev string:xb40>" );
        return;
    }
    
    itembundlename = itembundle;
    
    if ( !isxhashasset( itembundlename ) )
    {
        itembundlename = function_aa1699f78ccb3f3d( itembundlename );
    }
    
    if ( items_isitemdisabled( itembundlename, itembundle ) )
    {
        assertmsg( "<dev string:xb70>" + function_7a9533425bd9a67f( itembundle ) + "<dev string:xb9d>" );
        return;
    }
    
    if ( !level.var_97db93a6b414090d )
    {
        var_6400ce73760d266a = function_b617404fdc090121( itembundlename );
        
        if ( var_6400ce73760d266a.var_1d1583780b2c6606 )
        {
            if ( isdefined( var_6400ce73760d266a.var_1e3e1bca444e9636 ) )
            {
                itembundle = getscriptbundle( var_6400ce73760d266a.var_1e3e1bca444e9636 );
            }
            else
            {
                return;
            }
        }
        
        if ( function_a7a6e939a31e46b4( itembundlename ) )
        {
            var_f3652c0598f1c7d7 = function_7a9d74e5e45d2d10( itembundlename );
            
            if ( var_f3652c0598f1c7d7 == %"none" )
            {
                return;
            }
            
            itembundle = var_f3652c0598f1c7d7;
            itembundlename = var_f3652c0598f1c7d7;
        }
    }
    
    params = { #spawnoptions:spawnoptions, #count:count, #itembundle:itembundle };
    callback::callback( #"item_spawn_begin", params );
    itembundle = params.itembundle;
    count = params.count;
    spawnoptions = params.spawnoptions;
    
    if ( isxhashasset( itembundle ) )
    {
        itembundle = getscriptbundle( itembundle );
    }
    
    result = callback::response( 1, #"item_spawn_allowed", { #itembundle:itembundle } );
    
    if ( result )
    {
        return;
    }
    
    if ( !function_81b3ee2ff16cc3f0( spawnoptions ) )
    {
        assertmsg( "<dev string:xa14>" + function_7a9533425bd9a67f( itembundle ) + "<dev string:xa6e>" );
        return;
    }
    
    spawneditems = undefined;
    
    if ( !spawnoptions.var_d515ff001fe9ed9c )
    {
        itemtype = function_16e8c106491eeaca( itembundle );
        callbacks = function_9f00d6361edd38ce( itemtype );
        
        if ( isdefined( callbacks.funcs[ #"hash_d2edc28305c6e147" ] ) )
        {
            spawneditems = self [[ callbacks.funcs[ #"hash_d2edc28305c6e147" ] ]]( itembundle, count, spawnoptions );
        }
    }
    
    if ( !isdefined( spawneditems ) )
    {
        spawneditems = function_38f74ee40c2999b9( itembundle, count, spawnoptions );
    }
    
    return spawneditems;
}

// Namespace common_item
// Params 3
// Checksum 0x84ba6ecd, Offset: 0x569d
// Size: 0x97
function function_57b88e025e5fb03e( bundlename, count, spawnoptions )
{
    if ( !isdefined( bundlename ) )
    {
        assertmsg( "<dev string:xbc8>" + getxhashsourcename( bundlename ) );
        return;
    }
    
    if ( !function_81b3ee2ff16cc3f0( spawnoptions ) )
    {
        assertmsg( "<dev string:xbf6>" + getxhashsourcename( bundlename ) + "<dev string:xc5d>" );
        return;
    }
    
    itembundle = function_90c3e0c1fd55d6b6( bundlename );
    
    if ( !isdefined( itembundle ) )
    {
        assertmsg( "<dev string:xc64>" + bundlename );
        return;
    }
    
    return function_61c2c0251e742ffd( itembundle, count, spawnoptions );
}

// Namespace common_item
// Params 3
// Checksum 0xf64bf377, Offset: 0x573d
// Size: 0x8c
function function_325e28c0fb65c36a( ref, count, spawnoptions )
{
    if ( !isdefined( ref ) )
    {
        assertmsg( "<dev string:xcb2>" );
        return;
    }
    
    if ( !function_81b3ee2ff16cc3f0( spawnoptions ) )
    {
        assertmsg( "<dev string:xbf6>" + ref + "<dev string:xc5d>" );
        return;
    }
    
    itembundle = function_cf68ad18114498b2( ref );
    
    if ( !isdefined( itembundle ) )
    {
        assertmsg( "<dev string:xc64>" + ref );
        return;
    }
    
    return function_61c2c0251e742ffd( itembundle, count, spawnoptions );
}

// Namespace common_item
// Params 3
// Checksum 0xafa17fad, Offset: 0x57d2
// Size: 0x145
function items_spawnitemfromscriptable( scriptablename, count, spawnoptions )
{
    if ( !isdefined( scriptablename ) || !common_item_database::function_9eeb5b816d2c20c0( scriptablename ) )
    {
        /#
            if ( !isdefined( scriptablename ) )
            {
                assertmsg( "<dev string:x812>" );
                return;
            }
            
            if ( isstring( scriptablename ) )
            {
                assertmsg( "<dev string:x868>" + scriptablename + "<dev string:x8b3>" );
                return;
            }
            
            if ( isxhashasset( scriptablename ) )
            {
                assertmsg( "<dev string:x868>" + getxhashsourcename( scriptablename ) + "<dev string:x8b3>" );
                return;
            }
            
            assertmsg( "<dev string:x8b6>" );
        #/
        
        return;
    }
    
    if ( !function_81b3ee2ff16cc3f0( spawnoptions ) )
    {
        assertmsg( "<dev string:xbf6>" + ( isxhashasset( scriptablename ) ? getxhashsourcename( scriptablename ) : scriptablename ) + "<dev string:xce3>" );
        return;
    }
    
    itembundlename = common_item_database::function_ca9ca606e66b5911( scriptablename );
    
    if ( !isdefined( itembundlename ) )
    {
        assertmsg( "<dev string:x938>" + scriptablename + "<dev string:x978>" );
        return;
    }
    
    itembundle = getscriptbundle( itembundlename );
    
    if ( !isdefined( itembundle ) )
    {
        assertmsg( "<dev string:x99f>" + getxhashsourcename( itembundlename ) + "<dev string:x978>" );
        return;
    }
    
    return function_61c2c0251e742ffd( itembundle, count, spawnoptions );
}

// Namespace common_item
// Params 4
// Checksum 0x9b3bcd8a, Offset: 0x5920
// Size: 0x5a0
function function_2352d25db9e97696( itembundle, count, positioningresults, spawnoptions )
{
    var_5f3469f2a088fed5 = function_cd91a1f24bde432d( itembundle, spawnoptions );
    var_e257e56509f994bc = function_7bcc0dcd4d7ee24f();
    
    if ( var_5f3469f2a088fed5 > var_e257e56509f994bc )
    {
        assertmsg( "<dev string:xcf1>" + itembundle.ref + "<dev string:xd25>" + "<dev string:xd57>" + var_e257e56509f994bc + "<dev string:xd7c>" + var_5f3469f2a088fed5 );
        return;
    }
    
    itembundlename = function_aa1699f78ccb3f3d( itembundle );
    
    if ( items_isitemdisabled( itembundlename, itembundle ) )
    {
        assertmsg( "<dev string:xda7>" + function_7a9533425bd9a67f( itembundle ) + "<dev string:xb9d>" );
        return;
    }
    
    droporigin = positioningresults.finalorigin;
    dropangles = positioningresults.finalangles;
    payload = positioningresults.payload;
    itemtype = function_16e8c106491eeaca( itembundle );
    callbacks = function_9f00d6361edd38ce( itemtype );
    spawneditems = [];
    
    if ( isdefined( callbacks.funcs[ #"hash_2cc40f197e06aed7" ] ) )
    {
        if ( !isdefined( itembundle.scriptable ) )
        {
            assertmsg( "<dev string:xcf1>" + itembundle.ref + "<dev string:xdd5>" );
            return;
        }
        
        assert( isscriptabledefined( itembundle.scriptable ), "<dev string:xcf1>" + itembundle.ref + "<dev string:xe02>" + getxhashsourcename( itembundle.scriptable ) + "<dev string:xe26>" );
        spawneditems[ spawneditems.size ] = [[ callbacks.funcs[ #"hash_2cc40f197e06aed7" ] ]]( itembundle.scriptable, count, positioningresults, spawnoptions );
    }
    else
    {
        if ( !isdefined( droporigin ) )
        {
            assertmsg( "<dev string:xe40>" + function_7a9533425bd9a67f( itembundle ) + "<dev string:xe7f>" );
            return;
        }
        
        if ( isdefined( spawnoptions.var_7ab33df13f7d7e5e ) )
        {
            var_268159224d6b20c3 = [ #"hash_3fa904770c46e1ee", spawnoptions.var_7ab33df13f7d7e5e ];
        }
        
        if ( function_14876f2cf8d634b8( itembundle, spawnoptions ) && ( !isdefined( spawnoptions.payload ) || spawnoptions.payload[ 0 ] != #"teamselect" ) )
        {
            if ( isdefined( spawnoptions.var_4a4b419f66681601 ) && spawnoptions.var_4a4b419f66681601.size > 0 )
            {
                players = spawnoptions.var_4a4b419f66681601;
            }
            else
            {
                players = level.players;
            }
            
            foreach ( owningplayer in players )
            {
                if ( !isdefined( owningplayer ) )
                {
                    continue;
                }
                
                if ( level.commonitem.var_50bc13577ee45475 )
                {
                    n_offset = owningplayer getentitynumber() * 0.25;
                    droporigin = ( droporigin[ 0 ] + n_offset, droporigin[ 1 ], droporigin[ 2 ] );
                }
                
                var_7c170ceae0649b57 = [ #"teamselect", owningplayer getentitynumber() ];
                newitem = spawnscriptable( itembundle.perplayerscriptable, droporigin, dropangles, undefined, var_7c170ceae0649b57, payload, spawnoptions.payload, var_268159224d6b20c3 );
                
                if ( !isdefined( newitem ) )
                {
                    continue;
                }
                
                newitem function_7653c765b6c7b815();
                newitem enablescriptableplayeruse( owningplayer );
                newitem.var_7a65426f252841e7 = 1;
                newitem.owningplayer = owningplayer;
                spawneditems[ spawneditems.size ] = newitem;
            }
        }
        else
        {
            if ( !isdefined( itembundle.scriptable ) )
            {
                assertmsg( "<dev string:xcf1>" + itembundle.ref + "<dev string:xdd5>" );
                return;
            }
            
            assert( isscriptabledefined( itembundle.scriptable ), "<dev string:xcf1>" + itembundle.ref + "<dev string:xe02>" + getxhashsourcename( itembundle.scriptable ) + "<dev string:xe26>" );
            spawneditems[ spawneditems.size ] = spawnscriptable( itembundle.scriptable, droporigin, dropangles, undefined, payload, spawnoptions.payload, var_268159224d6b20c3 );
        }
    }
    
    foreach ( item in spawneditems )
    {
        function_2e30c2536aeaae5( item, itembundle, count, spawnoptions, positioningresults );
        
        if ( !spawnoptions.var_ec88f3792aec956a )
        {
            onmovingplatform = isdefined( positioningresults.groundentity );
            function_7d863a723c43aa51( item, spawnoptions.weapon, positioningresults.finalorigin, positioningresults.finalangles, count, onmovingplatform, level.commonitem.var_914563511f4d6f78, itembundlename );
        }
    }
    
    function_ac422ddbc7b48183( itembundle, positioningresults.finalorigin );
    
    if ( spawneditems.size > 1 )
    {
        return spawneditems;
    }
    
    if ( spawneditems.size == 1 )
    {
        return spawneditems[ 0 ];
    }
}

// Namespace common_item
// Params 5
// Checksum 0xfff7486c, Offset: 0x5ec9
// Size: 0xfc
function function_bb26c604ef9bac9f( itembundlename, itemtype, spawnoptions, count, weaponobj )
{
    if ( !itembundlename )
    {
        assertmsg( "<dev string:xbc8>" + getxhashsourcename( itembundlename ) );
        return;
    }
    
    if ( !function_81b3ee2ff16cc3f0( spawnoptions ) )
    {
        assertmsg( "<dev string:xbf6>" + getxhashsourcename( itembundlename ) + "<dev string:xc5d>" );
        return;
    }
    
    itembundle = function_90c3e0c1fd55d6b6( itembundlename );
    
    if ( !itembundle )
    {
        assertmsg( "<dev string:xc64>" + itembundlename );
        return;
    }
    
    if ( itemtype == #"weapon" )
    {
        spawnoptions.weapon = weaponobj;
        spawnoptions.overridecount = count;
        spawnoptions.var_d515ff001fe9ed9c = 1;
        spawnoptions.var_90cdc5dbcd319e5d = 1;
    }
    
    spawnoptions.var_ec88f3792aec956a = 1;
    return function_61c2c0251e742ffd( itembundle, count, spawnoptions );
}

// Namespace common_item
// Params 2
// Checksum 0x4060244c, Offset: 0x5fce
// Size: 0x1f
function function_48276d359493f0d4( item, b_despawn )
{
    function_869d7676e359a627( item, b_despawn );
}

// Namespace common_item
// Params 2, eflags: 0x4
// Checksum 0x67eb34fc, Offset: 0x5ff5
// Size: 0x5d
function private function_cd91a1f24bde432d( itembundle, spawnoptions )
{
    var_5f3469f2a088fed5 = 1;
    
    if ( function_14876f2cf8d634b8( itembundle, spawnoptions ) )
    {
        if ( isdefined( spawnoptions.var_4a4b419f66681601 ) )
        {
            var_5f3469f2a088fed5 = spawnoptions.var_4a4b419f66681601.size;
        }
        else
        {
            var_5f3469f2a088fed5 = level.players.size;
        }
    }
    
    return var_5f3469f2a088fed5;
}

// Namespace common_item
// Params 2, eflags: 0x4
// Checksum 0xb0a2940f, Offset: 0x605b
// Size: 0x6e
function private items_isitemdisabled( itembundlename, itembundle )
{
    if ( !isdefined( itembundlename ) )
    {
        if ( getdvarint( @"hash_2d01773eb030f9f", 0 ) )
        {
            var_ffef3f1941ee7bc4 = function_ba684cbdb7194241( itembundle );
            script::function_789a02669a1a12e9( @"hash_2d01773eb030f9f", "CommonItemERROR: A valid itemBundleName was not retrieved when spawning the item bundle containing [" + var_ffef3f1941ee7bc4 + " ]." + " This may be caused by a missing or incompletely set up consumable asset." );
        }
        
        return 1;
    }
    
    return function_99a3c189718cdd9e( itembundlename );
}

// Namespace common_item
// Params 2, eflags: 0x4
// Checksum 0x3c48186c, Offset: 0x60d2
// Size: 0x40, Type: bool
function private function_14876f2cf8d634b8( itembundle, spawnoptions )
{
    return spawnoptions.var_c580c0e8b49f1fcc && ( isdefined( spawnoptions.perplayerscriptable ) || isdefined( itembundle.perplayerscriptable ) );
}

// Namespace common_item
// Params 5, eflags: 0x4
// Checksum 0x5e48c0a9, Offset: 0x611b
// Size: 0x549
function private function_2e30c2536aeaae5( item, dropbundle, count, spawnoptions, positioningresults )
{
    if ( !isdefined( spawnoptions.var_f35b5b18b029c493 ) || spawnoptions.var_f35b5b18b029c493 )
    {
        var_885e7724f049d850 = !spawnoptions.var_8d4f327170228364;
        
        if ( isdefined( spawnoptions.var_885e7724f049d850 ) )
        {
            var_885e7724f049d850 = istrue( spawnoptions.var_885e7724f049d850 );
        }
        
        item function_725abd79805e767e( var_885e7724f049d850, positioningresults.finalangles, positioningresults, spawnoptions.var_50e31f8c119ef961 );
    }
    
    if ( spawnoptions.var_9161cf0784b6951d && spawnoptions.var_8d4f327170228364 )
    {
        if ( item getscriptableparthasstate( item.type, #"visible_original_position" ) )
        {
            item setscriptablepartstate( item.type, #"visible_original_position" );
        }
    }
    else if ( !spawnoptions.var_8d4f327170228364 )
    {
        /#
            if ( level.var_4e991a74374e63c6 )
            {
                debug::sphere( item.origin, 8, ( 0, 0, 0 ), level.var_635178f7bf48e21e, level.var_fc8c25326b291055 );
            }
        #/
        
        function_e2d70d809cb4e673( item, dropbundle, spawnoptions );
        
        /#
            if ( level.var_4e991a74374e63c6 )
            {
                debug::sphere( item.origin, 8, ( 1, 1, 1 ), level.var_635178f7bf48e21e, level.var_fc8c25326b291055 );
            }
        #/
    }
    
    item.var_fd47e835523b473f = spawnoptions.var_fd47e835523b473f;
    
    if ( !spawnoptions.var_fd47e835523b473f && !function_cc3e3f110bb67a46() )
    {
        var_80b1f8c4c54e54d7 = dropbundle.lifetime ?? 90;
        
        if ( isdefined( spawnoptions.overridelifetime ) )
        {
            var_80b1f8c4c54e54d7 = spawnoptions.overridelifetime;
            spawnoptions.overridelifetime = undefined;
        }
        
        item thread items_scriptable_waitandcleanup( var_80b1f8c4c54e54d7 );
    }
    
    if ( isdefined( count ) )
    {
        item.count = int( count );
    }
    
    item.var_22cae40c41e63f97 = dropbundle.var_22cae40c41e63f97;
    itemtype = function_16e8c106491eeaca( dropbundle );
    
    if ( !spawnoptions.critical && !spawnoptions.additionaldata.critical && !dropbundle.critical )
    {
        switch ( level.commonitem.var_d9665d85ee830b4c )
        {
            case 0:
                scriptable_group::function_c40c50e09efedb23( "common_items", item );
                break;
            case 1:
            case 2:
                if ( itemtype == "weapon" )
                {
                    scriptable_group_spatial::function_b7b6ffa8483b3c0b( "common_items_weapons", item );
                }
                else
                {
                    scriptable_group_spatial::function_b7b6ffa8483b3c0b( "common_items_nonweapons", item );
                }
                
                break;
            case 3:
            case 4:
                scriptable_group_spatial::function_b7b6ffa8483b3c0b( "common_items", item );
                break;
            default:
                break;
        }
    }
    else
    {
        item.critical = 1;
    }
    
    if ( spawnoptions.cleanupdisabled )
    {
        item.cleanupdisabled = 1;
    }
    
    item.spawningteam = spawnoptions.spawningteam;
    item.originalowner = spawnoptions.originalowner;
    item.staged = spawnoptions.staged;
    itemspawnparams = { #spawnoptions:spawnoptions, #angles:positioningresults.finalangles, #origin:positioningresults.finalorigin, #itembundle:dropbundle, #item:item };
    function_5a3b3bc996e8d5a5( #"hash_6fa1b7a8cddbe208", dropbundle.ref, itemspawnparams );
    function_5a3b3bc996e8d5a5( #"hash_f7e6c86eafa2eab3", dropbundle.subtype, itemspawnparams );
    function_5a3b3bc996e8d5a5( #"hash_d2b6e74af5f0f2a8", dropbundle.scriptable, itemspawnparams );
    function_5a3b3bc996e8d5a5( #"hash_8a0270c421b2093f", itemtype, itemspawnparams );
    function_5a3b3bc996e8d5a5( #"hash_9d2a33362cc3f972", #"hash_af63a74c8601927d", itemspawnparams );
    item.additionaldata = spawnoptions.additionaldata;
    item.analyticssource = spawnoptions.analyticssource;
    
    if ( spawnoptions.spawningentity.team )
    {
        item.team = spawnoptions.spawningentity.team;
    }
    
    if ( spawnoptions.spawningentity )
    {
        item.owner = spawnoptions.spawningentity;
    }
    
    var_c1dbf54946b63d26 = function_c6f3ef3dcb4c55c0( itemtype, #"hash_e8583c899ddff7b" );
    
    if ( isdefined( var_c1dbf54946b63d26 ) )
    {
        [[ var_c1dbf54946b63d26 ]]( self, item, dropbundle, spawnoptions );
    }
}

// Namespace common_item
// Params 2, eflags: 0x4
// Checksum 0x6df68f7a, Offset: 0x666c
// Size: 0x60
function private function_ac422ddbc7b48183( itembundle, dropposition )
{
    if ( !isdefined( itembundle.dropsfx ) )
    {
        return;
    }
    
    if ( isdefined( dropposition ) )
    {
        playsoundatpos( dropposition + ( 0, 0, 12 ), itembundle.dropsfx );
        return;
    }
    
    self playsound( itembundle.dropsfx );
}

// Namespace common_item
// Params 4, eflags: 0x4
// Checksum 0xaddc0e18, Offset: 0x66d4
// Size: 0x58
function private function_c3f293f2b1d70037( instance, note, param, var_64ffacba090c91be )
{
    if ( isdefined( instance ) )
    {
        instance function_7653c765b6c7b815();
        
        if ( isplayer( instance.owningplayer ) )
        {
            instance enablescriptableplayeruse( instance.owningplayer );
        }
    }
}

// Namespace common_item
// Params 1
// Checksum 0x5a916a0d, Offset: 0x6734
// Size: 0x34, Type: bool
function items_isitem( scriptablename )
{
    if ( isstring( scriptablename ) )
    {
        scriptablename = getxhashasset( scriptablename );
    }
    
    return isdefined( level.commonitem.var_1a1b8354fa1e275c[ scriptablename ] );
}

// Namespace common_item
// Params 1
// Checksum 0xcb708122, Offset: 0x6771
// Size: 0x48, Type: bool
function function_5cf4e552f9e871f1( itembundle )
{
    if ( function_3195adf8b9d5b2c6( itembundle ) != "none" )
    {
        return true;
    }
    
    if ( isdefined( itembundle.inventoryslot ) && itembundle.inventoryslot != "none" )
    {
        return true;
    }
    
    return false;
}

// Namespace common_item
// Params 1
// Checksum 0xcde0d592, Offset: 0x67c2
// Size: 0xc2
function function_33a2c00e46263d99( item )
{
    var_7237854e3be197ca = item.bundlename;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    name = common_item_database::function_ca9ca606e66b5911( item.type );
    
    if ( isdefined( name ) )
    {
        itemtype = function_3cba34a99d02cd9( name );
        
        if ( isdefined( itemtype ) )
        {
            var_13167f75caf12e04 = function_c6f3ef3dcb4c55c0( itemtype, #"bundlenamefromitem" );
            
            if ( isdefined( var_13167f75caf12e04 ) )
            {
                return [[ var_13167f75caf12e04 ]]( item, name );
            }
        }
    }
    else if ( isdefined( item.var_6828becb300b1c44.itembundlename ) )
    {
        name = item.var_6828becb300b1c44.itembundlename;
    }
    
    return name;
}

// Namespace common_item
// Params 1
// Checksum 0x7ef9cbad, Offset: 0x688d
// Size: 0x2d
function function_6b8ff3d5f2688336( scriptable )
{
    itembundlename = function_33a2c00e46263d99( scriptable );
    
    if ( isdefined( itembundlename ) )
    {
        return getscriptbundle( itembundlename );
    }
}

// Namespace common_item
// Params 1
// Checksum 0xb5bcd86b, Offset: 0x68c3
// Size: 0x2d
function function_80af1e9daffacc7d( scriptablename )
{
    itembundlename = common_item_database::function_ca9ca606e66b5911( scriptablename );
    
    if ( isdefined( itembundlename ) )
    {
        return getscriptbundle( itembundlename );
    }
}

// Namespace common_item
// Params 1
// Checksum 0xbdb87fe3, Offset: 0x68f9
// Size: 0x3f
function function_e044c3e813daec3a( itembundle )
{
    if ( !isdefined( itembundle.ref ) )
    {
        return common_item_database::function_ca9ca606e66b5911( itembundle.scriptable );
    }
    
    return common_item_database::function_a4f0a21951180013( itembundle.ref );
}

// Namespace common_item
// Params 1
// Checksum 0x12e1caa4, Offset: 0x6941
// Size: 0x7f
function function_aa1699f78ccb3f3d( itembundle )
{
    typeref = function_16e8c106491eeaca( itembundle );
    callbacks = function_9f00d6361edd38ce( typeref );
    
    if ( isdefined( callbacks.funcs[ #"hash_88b286fbc68ce7b" ] ) )
    {
        itembundlename = [[ callbacks.funcs[ #"hash_88b286fbc68ce7b" ] ]]( itembundle );
    }
    
    if ( !isdefined( itembundlename ) )
    {
        itembundlename = function_e044c3e813daec3a( itembundle );
    }
    
    return itembundlename;
}

// Namespace common_item
// Params 1
// Checksum 0x245e7dc5, Offset: 0x69c9
// Size: 0x28
function function_7a9533425bd9a67f( itembundle )
{
    /#
        return getxhashsourcename( function_e044c3e813daec3a( itembundle ) );
    #/
    
    return getxhashhexname( function_e044c3e813daec3a( itembundle ) );
}

// Namespace common_item
// Params 1
// Checksum 0x836d8fbf, Offset: 0x69fa
// Size: 0x28
function function_d43f27b1302f1c44( lootid )
{
    /#
        return getxhashsourcename( common_item_database::function_db2360bc1c33f6f9( lootid ) );
    #/
    
    return getxhashhexname( common_item_database::function_db2360bc1c33f6f9( lootid ) );
}

// Namespace common_item
// Params 1
// Checksum 0xfe77639f, Offset: 0x6a2b
// Size: 0x28
function function_5fde8a32af74e598( scriptablename )
{
    /#
        return getxhashsourcename( common_item_database::function_ca9ca606e66b5911( scriptablename ) );
    #/
    
    return getxhashhexname( common_item_database::function_ca9ca606e66b5911( scriptablename ) );
}

// Namespace common_item
// Params 1
// Checksum 0x3d5dd9f8, Offset: 0x6a5c
// Size: 0x28
function function_1cb2d422222358b8( ref )
{
    /#
        return getxhashsourcename( common_item_database::function_a4f0a21951180013( ref ) );
    #/
    
    return getxhashhexname( common_item_database::function_a4f0a21951180013( ref ) );
}

// Namespace common_item
// Params 1
// Checksum 0x19e9a7f6, Offset: 0x6a8d
// Size: 0x1a3
function function_ba684cbdb7194241( itembundle )
{
    if ( !isdefined( itembundle ) )
    {
        return "(itemBundle is not defined)";
    }
    
    if ( isdefined( itembundle.ref ) )
    {
        logref = getxhashhexname( getxhashasset( itembundle.ref ) );
        
        /#
            logref = getxhashsourcename( itembundle.ref );
        #/
    }
    
    if ( isdefined( itembundle.scriptable ) )
    {
        logscriptable = getxhashhexname( itembundle.scriptable );
        
        /#
            logscriptable = getxhashsourcename( itembundle.scriptable );
        #/
    }
    
    if ( isdefined( itembundle.lootitemtype ) )
    {
        var_b43cb1e6501dd395 = getxhashhexname( itembundle.lootitemtype );
        
        /#
            var_b43cb1e6501dd395 = getxhashsourcename( itembundle.lootitemtype );
        #/
    }
    
    if ( isdefined( itembundle.subtype ) )
    {
        logsubtype = getxhashhexname( getxhashasset( itembundle.subtype ) );
        
        /#
            logsubtype = getxhashsourcename( itembundle.subtype );
        #/
    }
    
    if ( isdefined( itembundle.titlestring ) )
    {
        var_53a34f9a7097a31b = getxhashhexname( itembundle.titlestring );
        
        /#
            var_53a34f9a7097a31b = getxhashsourcename( itembundle.titlestring );
        #/
    }
    
    return " ref: " + ( logref ?? "UNDEFINED" ) + ", scriptable: " + ( logscriptable ?? "UNDEFINED" ) + ", lootItemType: " + ( var_b43cb1e6501dd395 ?? "UNDEFINED" ) + ", subtype: " + ( logsubtype ?? "UNDEFINED" ) + ", titlestring: " + ( var_53a34f9a7097a31b ?? "UNDEFINED" );
}

// Namespace common_item
// Params 1
// Checksum 0xaeee043, Offset: 0x6c39
// Size: 0x41
function items_getscriptablefromlootid( lootid )
{
    itemdef = function_922f9c424b5c2410( lootid );
    
    if ( !isdefined( itemdef ) )
    {
        assertmsg( "<dev string:xea6>" + lootid );
        return;
    }
    
    return itemdef.scriptablestring;
}

// Namespace common_item
// Params 1
// Checksum 0x5ff3d455, Offset: 0x6c83
// Size: 0x39
function function_105527001e21028d( lootid )
{
    if ( !isdefined( lootid ) || lootid == 0 )
    {
        return;
    }
    
    lootinfo = getlootiteminfofromid( lootid );
    return lootinfo.itemref;
}

// Namespace common_item
// Params 2
// Checksum 0xd7398ff6, Offset: 0x6cc5
// Size: 0x122
function function_b202b16941992cca( lootid, var_780e89e1a687c6 )
{
    if ( lootid == 0 )
    {
        return;
    }
    
    if ( !isint( lootid ) )
    {
        assertmsg( "<dev string:xee1>" + ( lootid ?? "<dev string:x29d>" ) + "<dev string:xf11>" );
        return;
    }
    
    itembundlename = common_item_database::function_db2360bc1c33f6f9( lootid );
    
    if ( !isdefined( itembundlename ) )
    {
        /#
            lootinfo = getlootiteminfofromid( lootid );
            
            if ( isdefined( lootinfo.itemref ) )
            {
                assertmsg( "<dev string:xf3c>" + lootid + "<dev string:xf86>" + "<dev string:xf9b>" + lootinfo.itemref + "<dev string:x17c>" + "<dev string:xfcf>" + "<dev string:x103f>" );
                return;
            }
            
            assertmsg( "<dev string:x1080>" + lootid + "<dev string:x8b3>" );
        #/
        
        return;
    }
    
    if ( var_780e89e1a687c6 && var_780e89e1a687c6.size )
    {
        itembundle = getscriptbundlefieldvalues( itembundlename, var_780e89e1a687c6 );
    }
    else
    {
        itembundle = getscriptbundle( itembundlename );
    }
    
    if ( !itembundle )
    {
        assertmsg( "<dev string:x10d0>" + getxhashsourcename( itembundlename ) + "<dev string:x17c>" );
        return;
    }
    
    return itembundle;
}

// Namespace common_item
// Params 2
// Checksum 0x58ef2df8, Offset: 0x6df0
// Size: 0x4b, Type: bool
function function_f107d23d5275a951( scriptablename, itemtype )
{
    if ( !isdefined( scriptablename ) || !isdefined( itemtype ) || !common_item_database::function_9eeb5b816d2c20c0( scriptablename ) )
    {
        return false;
    }
    
    var_5ea0dae7fd8d9dd5 = function_9621774ab5ce6f82( scriptablename );
    return var_5ea0dae7fd8d9dd5 == itemtype;
}

// Namespace common_item
// Params 1
// Checksum 0x30cd60dc, Offset: 0x6e44
// Size: 0x86
function function_f8d1af7ca2a38061( itembundle )
{
    typeref = function_16e8c106491eeaca( itembundle );
    callbacks = function_9f00d6361edd38ce( typeref );
    
    if ( isdefined( callbacks.funcs[ #"hash_3459376aa4403b66" ] ) )
    {
        var_7237854e3be197ca = [[ callbacks.funcs[ #"hash_3459376aa4403b66" ] ]]( itembundle );
        
        if ( isdefined( var_7237854e3be197ca ) )
        {
            return var_7237854e3be197ca;
        }
    }
    
    return itembundle.maxcount ?? 0;
}

// Namespace common_item
// Params 2
// Checksum 0xf996a28e, Offset: 0x6ed3
// Size: 0x48, Type: bool
function function_b4f0ead21220e631( typeref, itemref )
{
    return self.backpackupgrades.var_9f469e8d2bc259d[ itemref ] ?? self.backpackupgrades.var_9f469e8d2bc259d[ typeref ] ?? 0;
}

// Namespace common_item
// Params 1
// Checksum 0xccc862c2, Offset: 0x6f24
// Size: 0xd7
function function_38334193bd9b5956( itembundle )
{
    typeref = function_16e8c106491eeaca( itembundle );
    callbacks = function_9f00d6361edd38ce( typeref );
    
    if ( isdefined( callbacks.funcs[ #"hash_3459376aa4403b66" ] ) )
    {
        var_7237854e3be197ca = [[ callbacks.funcs[ #"hash_3459376aa4403b66" ] ]]( itembundle );
        
        if ( isdefined( var_7237854e3be197ca ) )
        {
            return var_7237854e3be197ca;
        }
    }
    
    if ( itembundle.var_2b0a27d4be7d298b )
    {
        return 4294967295;
    }
    
    additionalmaxcount = function_b4f0ead21220e631( typeref, itembundle.ref );
    
    if ( itembundle.var_4c378a31417eaf3d )
    {
        return ( itembundle.var_2d4a8aa1a1c36b31 + additionalmaxcount );
    }
    
    return itembundle.maxcount + additionalmaxcount;
}

// Namespace common_item
// Params 2
// Checksum 0x5704a502, Offset: 0x7003
// Size: 0x105
function function_5f3f8e423378acd6( itembundle, typeref = function_16e8c106491eeaca( itembundle ) )
{
    callbacks = function_9f00d6361edd38ce( typeref );
    additionalmaxcount = function_b4f0ead21220e631( typeref, itembundle.ref );
    
    if ( isdefined( callbacks.funcs[ #"hash_3459376aa4403b66" ] ) )
    {
        maxcount = [[ callbacks.funcs[ #"hash_3459376aa4403b66" ] ]]( itembundle );
        
        if ( isdefined( maxcount ) )
        {
            return ( maxcount + additionalmaxcount );
        }
    }
    
    if ( itembundle.var_4c378a31417eaf3d )
    {
        if ( isdefined( self.perks[ "specialty_extraoffhandammo" ] ) && ( typeref == "lethal" || typeref == "tactical" ) )
        {
            return ( itembundle.var_f96b9b6aff0b335f + additionalmaxcount );
        }
        
        return ( itembundle.var_b7386e49348ae6a3 + additionalmaxcount );
    }
    
    return itembundle.maxcount + additionalmaxcount;
}

// Namespace common_item
// Params 1
// Checksum 0x52f51a7e, Offset: 0x7110
// Size: 0x5c
function function_cb980b90c836804e( scriptablename )
{
    if ( !isdefined( scriptablename ) )
    {
        return;
    }
    
    itemdef = function_526c97ebc6cff445( scriptablename );
    
    if ( !isdefined( itemdef ) || !isdefined( itemdef.lootid ) )
    {
        assertmsg( "<dev string:x110e>" + scriptablename );
        return;
    }
    
    return itemdef.lootid;
}

// Namespace common_item
// Params 1
// Checksum 0xda1b0f03, Offset: 0x7175
// Size: 0x2e
function function_cf68ad18114498b2( ref )
{
    itembundlename = common_item_database::function_a4f0a21951180013( ref );
    
    if ( !isdefined( itembundlename ) )
    {
        return;
    }
    
    return getscriptbundle( itembundlename );
}

// Namespace common_item
// Params 1
// Checksum 0x62cf413b, Offset: 0x71ac
// Size: 0x12
function function_90c3e0c1fd55d6b6( name )
{
    return getscriptbundle( name );
}

// Namespace common_item
// Params 1
// Checksum 0xaaed263f, Offset: 0x71c7
// Size: 0x2b
function function_70d4affb770e8103( ref )
{
    itembundle = function_cf68ad18114498b2( ref );
    return itembundle.scriptable;
}

// Namespace common_item
// Params 1
// Checksum 0xe2f3b23, Offset: 0x71fb
// Size: 0x1b
function function_b141c38a6a6342d6( name )
{
    return getscriptbundlefieldvalue( name, #"scriptable" );
}

// Namespace common_item
// Params 1
// Checksum 0xb1dc78a8, Offset: 0x721f
// Size: 0x1c, Type: bool
function function_7e69acc1ffc5adc0( bundlename )
{
    return !getscriptbundlefieldvalue( bundlename, #"nonstackable" );
}

// Namespace common_item
// Params 1
// Checksum 0xfe243619, Offset: 0x7244
// Size: 0x1b
function function_651cfd00ce6c6838( bundlename )
{
    return getscriptbundlefieldvalue( bundlename, #"itemtypestackable" );
}

// Namespace common_item
// Params 1
// Checksum 0x31eb0fc, Offset: 0x7268
// Size: 0x1a, Type: bool
function function_3a717102e34c1748( item )
{
    return function_7e69acc1ffc5adc0( common_item_database::function_ca9ca606e66b5911( item ) );
}

// Namespace common_item
// Params 1
// Checksum 0x764130b5, Offset: 0x728b
// Size: 0x2b
function function_526c97ebc6cff445( scriptablename )
{
    if ( !isdefined( scriptablename ) )
    {
        return;
    }
    
    if ( isstring( scriptablename ) )
    {
        scriptablename = getxhashasset( scriptablename );
    }
    
    return function_e541406a40e5a1df( scriptablename );
}

// Namespace common_item
// Params 1
// Checksum 0x923efb3a, Offset: 0x72bf
// Size: 0x42
function function_9deb822f286163b1( lootid )
{
    if ( !lootid )
    {
        return "generic";
    }
    
    bundle = function_b202b16941992cca( lootid, [ #"lootitemtype" ] );
    return function_16e8c106491eeaca( bundle );
}

// Namespace common_item
// Params 1
// Checksum 0x18b518f2, Offset: 0x730a
// Size: 0x3e
function function_16e8c106491eeaca( itembundle )
{
    if ( !isdefined( itembundle.lootitemtype ) )
    {
        return "generic";
    }
    
    return getscriptbundlefieldvalue( itembundle.lootitemtype, "typeRef" ) ?? "generic";
}

// Namespace common_item
// Params 1
// Checksum 0x98d98f21, Offset: 0x7351
// Size: 0x26
function function_3cba34a99d02cd9( itembundlename )
{
    return function_16e8c106491eeaca( getscriptbundlefieldvalues( itembundlename, [ #"lootitemtype" ] ) );
}

// Namespace common_item
// Params 1
// Checksum 0x2b55b406, Offset: 0x7380
// Size: 0x33, Type: bool
function function_9621774ab5ce6f82( scriptablename )
{
    itemdef = function_526c97ebc6cff445( scriptablename );
    return itemdef.type ?? "generic";
}

// Namespace common_item
// Params 1
// Checksum 0x896e8b2f, Offset: 0x73bc
// Size: 0x31
function function_c973dc1cb0ad3375( itembundle )
{
    if ( !isdefined( itembundle.lootitemtype ) )
    {
        return;
    }
    
    return getscriptbundlefieldvalue( itembundle.lootitemtype, "lootIDtype" );
}

// Namespace common_item
// Params 1
// Checksum 0xecf13f08, Offset: 0x73f6
// Size: 0x1f, Type: bool
function function_3195adf8b9d5b2c6( itembundle )
{
    return itembundle.inventorytype ?? "none";
}

// Namespace common_item
// Params 2
// Checksum 0x65fb8445, Offset: 0x741e
// Size: 0x109
function function_5cfa00ddd006df3( listref, index )
{
    if ( !isdefined( level.gametypebundle.itemspawnlistrefs ) || level.gametypebundle.itemspawnlistrefs.size == 0 )
    {
        return;
    }
    
    foreach ( entry in level.gametypebundle.itemspawnlistrefs )
    {
        if ( entry.ref == listref )
        {
            itemlist = getscriptbundlefieldvalues( entry.list, [ #"hash_634158c584fe2866" ] );
            return itemlist.itementries[ index ];
        }
    }
}

// Namespace common_item
// Params 1
// Checksum 0x8b20534d, Offset: 0x7530
// Size: 0xda
function function_62da977131eeed4a( listref )
{
    if ( !isdefined( level.gametypebundle.itemspawnlistrefs ) || level.gametypebundle.itemspawnlistrefs.size == 0 )
    {
        return;
    }
    
    foreach ( entry in level.gametypebundle.itemspawnlistrefs )
    {
        if ( entry.ref == listref )
        {
            return getscriptbundle( entry.list );
        }
    }
}

// Namespace common_item
// Params 1
// Checksum 0x90787442, Offset: 0x7613
// Size: 0xd6
function function_3c24841536dc783e( listref )
{
    if ( !isdefined( level.gametypebundle.itemspawnlistrefs ) || level.gametypebundle.itemspawnlistrefs.size == 0 )
    {
        return;
    }
    
    foreach ( entry in level.gametypebundle.itemspawnlistrefs )
    {
        if ( entry.ref == listref )
        {
            return entry.list;
        }
    }
}

// Namespace common_item
// Params 2
// Checksum 0x8d913781, Offset: 0x76f2
// Size: 0x1c3
function function_4af7d245e50939e7( listref, itembundle )
{
    if ( !isdefined( level.gametypebundle.itemspawnlistrefs ) || level.gametypebundle.itemspawnlistrefs.size == 0 )
    {
        return;
    }
    
    foreach ( entry in level.gametypebundle.itemspawnlistrefs )
    {
        if ( entry.ref == listref )
        {
            itemlist = getscriptbundlefieldvalues( entry.list, [ #"hash_634158c584fe2866" ] );
            
            foreach ( index, entry in itemlist.itementries )
            {
                itembundlename = getxhashasset( entry.itemspawnentry );
                var_1d6041e14aeb1bd9 = getscriptbundlefieldvalues( itembundlename, [ #"lootitemtype", #"ref" ] );
                
                if ( var_1d6041e14aeb1bd9.ref === itembundle.ref )
                {
                    return index;
                }
            }
        }
    }
}

// Namespace common_item
// Params 1
// Checksum 0xb6aef60, Offset: 0x78bd
// Size: 0x22
function function_b297a2bfcaccc713( var_a88c7cb6266e7633 )
{
    return level.commonitem.var_1df326001ae22d9f[ var_a88c7cb6266e7633 ];
}

// Namespace common_item
// Params 2
// Checksum 0xccd9f70e, Offset: 0x78e8
// Size: 0x8d
function function_b7eae989f62fad46( itembundle, quantity )
{
    if ( !isdefined( level.commonitem.raritydefs ) )
    {
        return;
    }
    
    itemrarity = itembundle.rarity ?? 0;
    typeref = function_16e8c106491eeaca( itembundle );
    
    if ( typeref == "weapon" && isdefined( quantity ) )
    {
        itemrarity = function_970735d3001edb67( quantity );
    }
    
    return level.commonitem.raritydefs[ itemrarity ];
}

// Namespace common_item
// Params 1
// Checksum 0x2e96a81d, Offset: 0x797e
// Size: 0x1b
function function_8fb8bfe0d9780c2e( bundlename )
{
    return getscriptbundlefieldvalue( bundlename, #"subtype" );
}

// Namespace common_item
// Params 7
// Checksum 0x2c2860a3, Offset: 0x79a2
// Size: 0x216
function function_e70f64f8d4664b9e( player, item, count, tobackpack, itembundle, itembundlename, autouse )
{
    if ( item.fromground || isdefined( item.fromgroup ) && !common_inventory_groups::function_bdd40ff62071d8a0( item.fromgroup ) )
    {
        params = spawnstruct();
        params.item = item;
        params.player = player;
        params.fromground = item.fromground;
        params.cache = item.cache;
        params.fromgroup = item.fromgroup;
        params.quantity = count;
        
        if ( !isdefined( itembundlename ) )
        {
            itembundlename = function_33a2c00e46263d99( item );
        }
        
        if ( !isdefined( itembundle ) )
        {
            itembundle = getscriptbundle( itembundlename );
        }
        
        params.itembundlename = itembundlename;
        params.itembundle = itembundle;
        params.tobackpack = tobackpack;
        params.autouse = autouse;
        player callback::callback( #"player_item_pickup", params );
        
        if ( !isdefined( itembundle ) && level.commonitem.var_b19011d4f497fae7 )
        {
            itemtype = isxhash( item.type ) ? getxhashhexname( item.type ) : isxhashasset( item.type ) ? "xhash asset item type" : item.type ?? "none";
            script::function_2e2007575f92910d( "undefined itemBundle. itemType: " + itemtype + ". count: " + ( count ?? -1 ) + ". Player: " + ( player getplayerunoid() ?? "" ) + ". toBackpack: " + ( tobackpack ?? -1 ) );
        }
    }
}

// Namespace common_item
// Params 2
// Checksum 0x8f7c7a76, Offset: 0x7bc0
// Size: 0x40, Type: bool
function function_269312c5169813e5( omnvarname, value )
{
    omnvarrange = getomnvarrange( omnvarname );
    
    if ( omnvarrange )
    {
        return ( value >= omnvarrange[ 0 ] && value <= omnvarrange[ 1 ] );
    }
    
    return true;
}

// Namespace common_item
// Params 2
// Checksum 0xf082b7b3, Offset: 0x7c09
// Size: 0xdd
function function_82b75f5bfa85d5b( item, player )
{
    autouseflags = 0;
    newitembundlename = function_33a2c00e46263d99( item );
    
    if ( !isdefined( newitembundlename ) )
    {
        return autouseflags;
    }
    
    newitembundle = getscriptbundle( newitembundlename );
    itemtype = function_16e8c106491eeaca( newitembundle );
    callbacks = function_9f00d6361edd38ce( itemtype, 0 );
    
    if ( !isdefined( callbacks ) || !isdefined( callbacks.funcs ) || !isdefined( callbacks.funcs[ #"canautouse" ] ) )
    {
        return autouseflags;
    }
    
    var_c6a3e4c65520b714 = player [[ callbacks.funcs[ #"canautouse" ] ]]( newitembundle, item, 1, 1 );
    
    if ( var_c6a3e4c65520b714 )
    {
        autouseflags = 1;
    }
    
    return autouseflags;
}

// Namespace common_item
// Params 2
// Checksum 0xeeac0ee, Offset: 0x7cef
// Size: 0x2d
function function_f77c7eedea4fc99f( var_5d98b35d3208c27f, var_28f3b0478555038f )
{
    level.commonitem.var_60b382bc384e5620[ var_5d98b35d3208c27f ] = var_28f3b0478555038f;
}

// Namespace common_item
// Params 1
// Checksum 0xaae320db, Offset: 0x7d24
// Size: 0x22
function function_6de05583881c7e60( var_5d98b35d3208c27f )
{
    level.commonitem.var_60b382bc384e5620[ var_5d98b35d3208c27f ] = undefined;
}

// Namespace common_item
// Params 1, eflags: 0x4
// Checksum 0x7d38fc93, Offset: 0x7d4e
// Size: 0x23, Type: bool
function private function_a7a6e939a31e46b4( var_5d98b35d3208c27f )
{
    return isdefined( level.commonitem.var_60b382bc384e5620[ var_5d98b35d3208c27f ] );
}

// Namespace common_item
// Params 1, eflags: 0x4
// Checksum 0x52773b9e, Offset: 0x7d7a
// Size: 0x39
function private function_7a9d74e5e45d2d10( var_5d98b35d3208c27f )
{
    var_7237854e3be197ca = level.commonitem.var_60b382bc384e5620[ var_5d98b35d3208c27f ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return var_5d98b35d3208c27f;
}

// Namespace common_item
// Params 5
// Checksum 0x3f7deff8, Offset: 0x7dbc
// Size: 0x82
function function_d4c3b44cc8cb33d1( player, item, itembundle, itemtype, autouse = 0 )
{
    return level callback::response( 2, #"hash_4239cc94bed9cb5c", { #autouse:autouse, #itemtype:itemtype, #itembundle:itembundle, #item:item, #player:player } );
}

// Namespace common_item
// Params 5
// Checksum 0xdd47ea58, Offset: 0x7e47
// Size: 0x3d2
function function_38df6d1d823e03b3( item, part, state, player, autouse )
{
    itembundlename = undefined;
    itembundle = undefined;
    itemtype = undefined;
    
    if ( !isdefined( item.type ) || !common_item_database::function_9eeb5b816d2c20c0( item.type ) || item.disable )
    {
        return [ 0, itembundlename, itembundle, itemtype ];
    }
    
    itembundlename = function_33a2c00e46263d99( item );
    
    if ( !isdefined( itembundlename ) )
    {
        assertmsg( "<dev string:x115b>" + getxhashsourcename( item.type ) + "<dev string:x117e>" );
        return [ 0, itembundlename, itembundle, itemtype ];
    }
    
    itembundle = getscriptbundle( itembundlename );
    
    if ( !isdefined( itembundle ) )
    {
        assertmsg( "<dev string:x11b1>" + getxhashsourcename( itembundlename ) + "<dev string:x11d9>" + getxhashsourcename( item.type ) + "<dev string:x17c>" );
        return [ 0, itembundlename, itembundle, itemtype ];
    }
    
    itemtype = function_16e8c106491eeaca( itembundle );
    
    if ( !function_498ad287e390e8bc( itemtype ) || !function_ed1cb2c7c4fe57cc( itemtype ) )
    {
        /#
            if ( function_ed1cb2c7c4fe57cc( itemtype ) )
            {
                assertmsg( "<dev string:x1205>" + getxhashsourcename( itembundlename ) + "<dev string:x121d>" + itemtype + "<dev string:x17c>" );
            }
        #/
        
        return [ 0, itembundlename, itembundle, itemtype ];
    }
    
    if ( autouse )
    {
        if ( item.var_35de80c7b58c9a95 || !function_8c20f7b0f2737794( itembundle, player ) )
        {
            return [ 0, itembundlename, itembundle, itemtype ];
        }
        
        time = gettime();
        
        if ( player.var_c587348832866568 > time )
        {
            return [ 0, itembundlename, itembundle, itemtype ];
        }
        
        playernum = player.clientid;
        
        if ( isdefined( item.var_856a1dbbb3cb703a ) && item.var_856a1dbbb3cb703a[ playernum ] > time )
        {
            return [ 0, itembundlename, itembundle, itemtype ];
        }
    }
    
    if ( player::isinlaststand( player ) && !itembundle.canpickupinlaststand )
    {
        return [ 0, itembundlename, itembundle, itemtype ];
    }
    
    if ( !function_d4c3b44cc8cb33d1( player, item, itembundle, itemtype, autouse ) )
    {
        return [ 0, itembundlename, itembundle, itemtype ];
    }
    
    callbacks = function_9f00d6361edd38ce( itemtype );
    
    if ( isdefined( callbacks.funcs[ #"caninteract" ] ) )
    {
        caninteract = player [[ callbacks.funcs[ #"caninteract" ] ]]( { #itembundlename:itembundlename, #item:item, #itembundle:itembundle } );
    }
    else
    {
        caninteract = player function_a35b39392c23339f( { #weaponobj:item.weaponobj, #itembundlename:itembundlename } );
    }
    
    if ( !caninteract || !player val::get( "item_pickup" ) )
    {
        if ( !autouse || !player val::get( "item_pickup" ) )
        {
            return [ 0, itembundlename, itembundle, itemtype ];
        }
    }
    
    return [ 1, itembundlename, itembundle, itemtype ];
}

// Namespace common_item
// Params 4
// Checksum 0x21168c78, Offset: 0x8222
// Size: 0x9b, Type: bool
function function_366a8b5ccb4106f1( item, part, state, player )
{
    if ( !item getscriptableisloot() )
    {
        return true;
    }
    
    [ canbeused, itembundlename, itembundle, itemtype ] = function_38df6d1d823e03b3( item, part, state, player, 0 );
    return canbeused || isdefined( itemtype ) && !function_498ad287e390e8bc( itemtype );
}

// Namespace common_item
// Params 6
// Checksum 0x66647cfb, Offset: 0x82c6
// Size: 0x277
function items_scriptable_used( item, part, state, player, autouse, usestring )
{
    [ canbeused, itembundlename, itembundle, itemtype ] = function_38df6d1d823e03b3( item, part, state, player, autouse );
    
    if ( !canbeused )
    {
        if ( !autouse )
        {
            player function_eddf962212836a3e( itembundle, 0 );
        }
        
        return 0;
    }
    
    item.fromground = 1;
    var_395fa3a95ec9b995 = undefined;
    
    if ( level.gametypebundle.var_56e485b1fa6b8ea4 )
    {
        amountused = player function_96119bed8ab4c5d9( item, autouse, level.gametypebundle.var_5f1b2834ae905122 );
        var_395fa3a95ec9b995 = amountused > 0;
    }
    else
    {
        if ( player function_e00e74d334622919() )
        {
            var_3cd869bfbe085078 = player [[ player.pickupoverride ]]( item );
        }
        else
        {
            var_3cd869bfbe085078 = player function_2b5e2ff57d5f392( item, autouse, 1 );
        }
        
        var_6e2e2e14f5e04d91 = 0;
        
        if ( !var_3cd869bfbe085078 && ( !autouse || itembundle.var_b30083978786aac7 ) && itemtype != "weapon" )
        {
            var_6e2e2e14f5e04d91 = player common_inventory::function_7995ab7f567ba9d3( item, autouse, 1, level.gametypebundle.var_5f1b2834ae905122 );
        }
        
        var_395fa3a95ec9b995 = var_3cd869bfbe085078 || var_6e2e2e14f5e04d91;
        
        switch ( itemtype ?? "" )
        {
            case #"hash_2acb6b11468fd311":
            case #"hash_5ed0b523d5733ef9":
            case #"hash_dc0a55772fe305c5":
            case #"hash_fb54a7157b952658":
                break;
            default:
                if ( var_395fa3a95ec9b995 )
                {
                    player function_eddf962212836a3e( itembundle, 1 );
                }
                else if ( !autouse && ( !isdefined( player.var_50f741a14f09a6 ) || !player.var_50f741a14f09a6.var_6e5229c10873d74a ) )
                {
                    player function_eddf962212836a3e( itembundle, 0 );
                }
                
                break;
        }
    }
    
    if ( var_395fa3a95ec9b995 )
    {
        player.var_c587348832866568 = int( gettime() + utility::function_4b74c15943231980( 0.05 ) );
    }
    
    if ( !autouse && var_395fa3a95ec9b995 )
    {
        thread function_e8dfe5e68a7a03b4( player, itembundle );
    }
    
    return var_395fa3a95ec9b995;
}

// Namespace common_item
// Params 4, eflags: 0x4
// Checksum 0x1a41040f, Offset: 0x8546
// Size: 0x3ac
function private items_useitemscriptable( item, itembundlename, itembundle, autouse )
{
    usedquantity = undefined;
    var_6bbe1e5bccb9d7dd = function_3f39e7be347cf7e1( itembundle, item, undefined, autouse );
    itemtype = function_16e8c106491eeaca( itembundle );
    callbacks = function_9f00d6361edd38ce( itemtype );
    assert( isdefined( var_6bbe1e5bccb9d7dd ), "<dev string:x124d>" + getxhashsourcename( itembundlename ) + "<dev string:x17c>" );
    remainderquantity = var_6bbe1e5bccb9d7dd;
    
    if ( isarray( remainderquantity ) && isint( remainderquantity[ 0 ] ) )
    {
        if ( remainderquantity.size > 1 && isint( remainderquantity[ 1 ] ) )
        {
            usedquantity = remainderquantity[ 1 ];
        }
        
        remainderquantity = remainderquantity[ 0 ];
    }
    
    if ( !isdefined( remainderquantity ) )
    {
        remainderquantity = 0;
        
        /#
            var_82d30fc34f032b9e = isdefined( itembundlename ) ? getxhashsourcename( itembundlename ) : undefined;
            sreitemtype = getxhashsourcename( item.type );
        #/
        
        var_b59d0aaec172cab5 = "";
        
        if ( itemtype == "weapon" )
        {
            var_b59d0aaec172cab5 = "\nThe weapon item details are:" + "\nbasename [" + ( isdefined( item.weaponobj ) ? item.weaponobj.basename : "weaponobj UNDEFINED" ) + "] " + "\ncustomweaponname [" + ( item.customweaponname ?? "weaponobj UNDEFINED" ) + "] " + "\nnum attachments [" + ( isdefined( item.weaponobj ) ? item.weaponobj.var_f6f9f66e9b50d71c.size : "weaponobj UNDEFINED" ) + "] " + "\nPAP level [" + ( item.var_951c89546ec50477 ?? "UNDEFINED" ) + "] " + "\nRarity index [" + ( isdefined( item.var_6828becb300b1c44 ) && isdefined( item.var_6828becb300b1c44.rarity ) ? item.var_6828becb300b1c44.rarity : "UNDEFINED" ) + "] ";
        }
        
        if ( isdefined( var_82d30fc34f032b9e ) || isdefined( sreitemtype ) || isstring( item.type ) || var_b59d0aaec172cab5 != "" )
        {
            script::demoforcesre( "[Items_UseItemScriptable] undefined remainderQuantity for item [" + ( var_82d30fc34f032b9e ?? "UNDEFINED" ) + "] when using item scriptable " + ( sreitemtype ?? ( isstring( item.type ) ? item.type : "UNDEFINED" ) ) + var_b59d0aaec172cab5 );
        }
    }
    
    if ( !isdefined( usedquantity ) && isdefined( item.count ) )
    {
        usedquantity = item.count - remainderquantity;
    }
    
    var_d1fb70b91b28fd8d = function_44eacd480abb5b94( usedquantity );
    
    if ( var_d1fb70b91b28fd8d > 0 || isdefined( callbacks.funcs[ #"hash_57438abc2841dfec" ] ) && self [[ callbacks.funcs[ #"hash_57438abc2841dfec" ] ]]( item, var_6bbe1e5bccb9d7dd ) )
    {
        function_e70f64f8d4664b9e( self, item, var_d1fb70b91b28fd8d, 0, itembundle, itembundlename, autouse );
        
        if ( itembundle.deleteremainder )
        {
            remainderquantity = 0;
        }
    }
    
    if ( !remainderquantity && isdefined( item.type ) )
    {
        self notify( #"self_pickedupitem", getxhashasset( item.type ) );
        item.pickedup = 1;
        item.pickedupplayer = self;
    }
    
    var_966520f2acbff500 = var_d1fb70b91b28fd8d <= 0;
    function_6b392f3e5fc53c0d( item, itembundle, remainderquantity, var_966520f2acbff500 );
    return usedquantity;
}

/#

    // Namespace common_item
    // Params 1, eflags: 0x4
    // Checksum 0x6b2f434e, Offset: 0x88fb
    // Size: 0xad, Type: dev
    function private function_34b10e179e59aabd( lifetime )
    {
        if ( !getdvarint( @"hash_691b5207342d5801", 0 ) )
        {
            return;
        }
        
        self endon( #"death" );
        remain = lifetime;
        
        while ( remain > 0 )
        {
            color = ( 1, 1, 1 );
            alpha = 1;
            scale = 0.4;
            duration = 1;
            debug::print3d( self, string( remain ), color, duration, "<dev string:x1283>", "<dev string:x1283>", alpha, scale, 20 );
            wait duration;
            remain -= duration;
        }
    }

#/

// Namespace common_item
// Params 1
// Checksum 0x581cfabc, Offset: 0x89b0
// Size: 0x74
function items_scriptable_waitandcleanup( waitseconds )
{
    self notify( #"hash_3ae3c300e1469d62" );
    self endon( #"hash_3ae3c300e1469d62" );
    self endon( #"death" );
    
    /#
        overridelifetime = getdvarint( @"hash_4fa90c2ce3766d92", 0 );
        
        if ( overridelifetime < 0 )
        {
            return;
        }
        
        if ( overridelifetime )
        {
            waitseconds = overridelifetime;
        }
        
        thread function_34b10e179e59aabd( waitseconds );
    #/
    
    wait waitseconds;
    thread function_869d7676e359a627( self, 1 );
}

// Namespace common_item
// Params 2
// Checksum 0x5afb999d, Offset: 0x8a2c
// Size: 0x1ed
function function_869d7676e359a627( item, b_despawn )
{
    if ( !isdefined( item ) )
    {
        return;
    }
    
    if ( item.fromcache )
    {
        item.count = 0;
        return;
    }
    
    if ( item.cleanupdisabled )
    {
        return;
    }
    
    function_76f4f6a7c9d8694e( item );
    
    if ( isdefined( item.group_instance_id ) )
    {
        switch ( level.commonitem.var_d9665d85ee830b4c )
        {
            case 0:
            case 3:
            case 4:
                scriptable_group::function_3359d6f82b103a4e( "common_items", item );
                break;
            case 1:
            case 2:
                itemtype = function_9621774ab5ce6f82( item.type );
                
                if ( itemtype == "weapon" )
                {
                    scriptable_group::function_3359d6f82b103a4e( "common_items_weapons", item );
                }
                else
                {
                    scriptable_group::function_3359d6f82b103a4e( "common_items_nonweapons", item );
                }
                
                break;
            default:
                break;
        }
    }
    
    if ( isstruct( item ) )
    {
        item notify( #"death" );
        return;
    }
    
    if ( isent( item ) )
    {
        item delete();
        return;
    }
    
    item calloutmarkerping::function_608710c894185549();
    item notify( #"death" );
    params = spawnstruct();
    params.item = item;
    params.b_despawn = b_despawn;
    level callback::callback( "on_item_cleanup", params );
    
    if ( item getscriptableisreserved() && !item.entity )
    {
        item freescriptable();
        return;
    }
    
    if ( item getscriptableparthasstate( item.type, "hidden" ) )
    {
        item setscriptablepartstate( item.type, "hidden" );
    }
}

// Namespace common_item
// Params 3
// Checksum 0x47dfc3fb, Offset: 0x8c21
// Size: 0x14d
function function_e2d70d809cb4e673( item, itembundle, spawnoptions )
{
    if ( !( isdefined( item ) && isdefined( itembundle ) && isdefined( spawnoptions ) ) )
    {
        return;
    }
    
    droppedstate = #"dropped";
    
    if ( isdefined( level.commonitem.raritydefs ) && !spawnoptions.var_7a3bb21eb7f88248 )
    {
        rarity = spawnoptions.rarity ?? itembundle.rarity ?? 0;
        raritydef = level.commonitem.raritydefs[ rarity ];
        
        if ( isdefined( raritydef.var_dfcca2c5d029effe ) )
        {
            droppedstate = raritydef.var_dfcca2c5d029effe;
        }
    }
    
    if ( isdefined( spawnoptions.var_cf4938fb18f3fb7d ) )
    {
        droppedstate = spawnoptions.var_cf4938fb18f3fb7d;
    }
    
    if ( !item getscriptableparthasstate( item.type, droppedstate ) )
    {
        println( "<dev string:x1289>" + getxhashsourcename( item.type ) + "<dev string:x12bb>" + getxhashsourcename( droppedstate ) );
        droppedstate = #"dropped";
    }
    
    item setscriptablepartstate( item.type, droppedstate );
}

// Namespace common_item
// Params 2
// Checksum 0x66c617c5, Offset: 0x8d76
// Size: 0x4a
function function_45c338c4003d5f13( scriptable, itemsdropped )
{
    scriptable.itemsdropped = itemsdropped;
    
    if ( bots_util::function_deef484b5b3a3977() && ( scriptable isscriptable() || scriptable isscriptableinstance() ) )
    {
        function_4184f06d14069672( scriptable, isdefined( itemsdropped ) );
    }
}

// Namespace common_item
// Params 2
// Checksum 0xd09fb772, Offset: 0x8dc8
// Size: 0x36
function function_85051688452b7927( scriptable, inuse )
{
    scriptable.inuse = inuse;
    
    if ( bots_util::function_deef484b5b3a3977() )
    {
        function_db5395dadc9479f3( scriptable, istrue( inuse ) );
    }
}

// Namespace common_item
// Params 0
// Checksum 0x185236c3, Offset: 0x8e06
// Size: 0xaa
function cleanup_all_items()
{
    items = scriptable_group::function_dbae202082772159( "common_items" );
    
    foreach ( item in items )
    {
        if ( isdefined( item ) )
        {
            throttle::throttle_wait_gate( level.commonitem.item_cleanup_throttle );
            level thread function_869d7676e359a627( item );
        }
    }
}

// Namespace common_item
// Params 4
// Checksum 0xd8451be6, Offset: 0x8eb8
// Size: 0x2a6
function function_725abd79805e767e( var_885e7724f049d850, dropangles, positioningresults, var_9afac63c9177fa45 )
{
    if ( !isdefined( self ) || self.var_60f0069bbde03d4a )
    {
        return;
    }
    
    if ( !isdefined( self.origin ) )
    {
        assertmsg( "<dev string:x12db>" + ( self.type ?? "<dev string:xae9>" ) + "<dev string:x1342>" );
        return;
    }
    
    groundent = positioningresults.groundentity;
    worldorigin = self.origin;
    
    if ( !groundent )
    {
        contents = trace::create_contents( 0, 1, 0, 0, 0, 1, 1, 0, 0 );
        ignorelist = [];
        caststart = self.origin + ( 0, 0, 50 );
        castend = caststart + ( 0, 0, -200 );
        traceresult = trace::ray_trace( caststart, castend, ignorelist, contents );
        groundent = traceresult[ "entity" ];
        worldorigin = traceresult[ "position" ];
    }
    
    if ( groundent )
    {
        if ( groundent vehicle::is_vehicle() && vehicle::has_data( groundent vehicle::get_ref() ) )
        {
            forcestick = utility::callsharedfunc( #"vehicle", #"hash_66a6ed24403ac03c", groundent vehicle::get_ref() );
            
            if ( !forcestick && level.var_eca35f80c78570e0 && !utility::is_moving_platform_ent( groundent ) )
            {
                return;
            }
            
            if ( var_9afac63c9177fa45 && !function_19e5b92df49a461d( groundent ) )
            {
                println( "<dev string:x1359>" );
                return;
            }
            
            data = vehicle::get_data( groundent vehicle::get_ref() );
            
            if ( data.interact.var_2ddf21ea17462be4 || data.interact.var_decd8eab2bb412 )
            {
                println( "<dev string:x1359>" );
                return;
            }
        }
        
        if ( groundent ismovingplatform() )
        {
            localorigin = rotatevectorinverted( worldorigin - groundent.origin, groundent.angles );
            localangles = combineangles( invertangles( groundent.angles ), var_885e7724f049d850 ? dropangles : ( 0, self.angles[ 1 ], 0 ) );
            
            if ( isdefined( self.linkedparent ) )
            {
                self.linkedparent linkto( groundent, "", localorigin, localangles );
                return;
            }
            
            utility::scriptable_setparententity( groundent, localorigin, localangles );
        }
    }
}

// Namespace common_item
// Params 2
// Checksum 0x3f7d2d6, Offset: 0x9166
// Size: 0xc8
function function_e8dfe5e68a7a03b4( player, itembundle )
{
    player notify( #"hash_cffd9fae9275cf5f" );
    player endon( #"hash_cffd9fae9275cf5f" );
    player endon( #"death" );
    player endon( #"disconnect" );
    
    if ( !isdefined( player ) || function_b8dd45a987a4325e( itembundle ) || !function_9af4a186249f7df1( player ) )
    {
        return;
    }
    
    function_ca1fd5f697b3b46( player, level.gametypebundle.pickupgestureweapon, level.gametypebundle.var_10688c489d4665d8 );
    function_526207a10c8237ab( player, level.gametypebundle.pickupgestureweapon, level.gametypebundle.var_10688c489d4665d8 );
}

// Namespace common_item
// Params 1
// Checksum 0xcabb2841, Offset: 0x9236
// Size: 0x49
function function_b8dd45a987a4325e( itembundle )
{
    if ( !( isdefined( level.gametypebundle.pickupgestureweapon ) && isdefined( level.gametypebundle.var_10688c489d4665d8 ) ) )
    {
        return 1;
    }
    
    return itembundle.var_c71ca41268e0a28b;
}

// Namespace common_item
// Params 1
// Checksum 0x36637be6, Offset: 0x9288
// Size: 0xa0, Type: bool
function function_9af4a186249f7df1( player )
{
    heldoffhand = player weapon::getgrenadeinpullback();
    
    if ( isdefined( heldoffhand ) && !isnullweapon( heldoffhand ) )
    {
        return false;
    }
    
    if ( player isswitchingweapon() || player isreloading() || player ismantling() || player isthrowinggrenade() || player israisingweapon() || player ismeleeing() || player isthrowingbackgrenade() || player player::isplayerads() || player.insertingarmorplate )
    {
        return false;
    }
    
    return !isnullweapon( player getcurrentweapon() );
}

// Namespace common_item
// Params 3
// Checksum 0xd7bf5052, Offset: 0x9331
// Size: 0x58
function function_ca1fd5f697b3b46( player, weaponref, animref )
{
    weapobj = makeweapon( weaponref );
    
    if ( player hasweapon( weapobj ) )
    {
        if ( player isgestureplaying( animref ) )
        {
            player stopgestureviewmodel( animref, 0, 1 );
        }
        
        player takeweapon( weapobj );
        waitframe();
    }
}

// Namespace common_item
// Params 3
// Checksum 0xee3a602e, Offset: 0x9391
// Size: 0x6f
function function_526207a10c8237ab( player, weaponref, animref )
{
    player endon( #"death_or_disconnect" );
    weapobj = makeweapon( weaponref );
    result = player weapon_utility::giveandfireoffhandreliable( weapobj );
    
    if ( result )
    {
        wait player getgestureanimlength( animref );
    }
    
    if ( player hasweapon( weapobj ) )
    {
        player takeweapon( weapobj );
    }
}

// Namespace common_item
// Params 7
// Checksum 0xaa08206a, Offset: 0x9408
// Size: 0x215
function function_2e0436a8625e3515( itembundle, itemcount, itemdata, stow = 0, var_8ec9bd311c662237, var_8e2a9de76678811f, autouse )
{
    lootid = itemdata.lootid ?? function_779887309ec71dfe( itembundle );
    droppedid = 0;
    stowedid = 0;
    equippedid = 0;
    boughtid = 0;
    soldid = 0;
    typestring = function_16e8c106491eeaca( itembundle );
    fromcache = istrue( itemdata.fromcache );
    fromriftreward = istrue( itemdata.fromriftreward );
    critical = istrue( itemdata.critical );
    
    if ( stow )
    {
        stowedid = lootid;
    }
    else
    {
        equippedid = lootid;
    }
    
    items_analytics( droppedid, stowedid, equippedid, boughtid, soldid, typestring, fromcache, fromriftreward, itemdata.type, itemdata.origin, itemcount, undefined, critical, itemdata.owner, itemdata.staged, itemdata.analyticssource );
    
    if ( !var_8ec9bd311c662237 )
    {
        function_eddf962212836a3e( itembundle, 1 );
    }
    
    if ( !itembundle.var_fbb504183990fc9f && !var_8e2a9de76678811f && !( itembundle.var_b872d29a8cf979c7 && autouse ) && !itemdata.var_fbb504183990fc9f )
    {
        thread function_29cda7adf128f6fb( itembundle, itemcount, itemdata );
    }
    
    if ( isdefined( itembundle.scoreevent ) )
    {
        namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( itembundle.scoreevent );
    }
    
    if ( itembundle.subtype == "quest" )
    {
        var_424a26fb1dedfefc = function_c6f3ef3dcb4c55c0( itembundle.subtype, #"hash_f2486ea3c2669567" );
        
        if ( isdefined( var_424a26fb1dedfefc ) )
        {
            self [[ var_424a26fb1dedfefc ]]( itembundle, lootid );
        }
    }
}

// Namespace common_item
// Params 1, eflags: 0x4
// Checksum 0xa9967ac2, Offset: 0x9625
// Size: 0xcf
function private function_8425760df24db4d9( params )
{
    if ( !( isdefined( params.player ) && isdefined( params.pingindex ) && isdefined( params.obj.type ) ) )
    {
        return;
    }
    
    if ( params.obj isscriptableinstance() && common_item_database::function_9eeb5b816d2c20c0( params.obj.type ) )
    {
        if ( params.obj.var_7a65426f252841e7 )
        {
            params.player calloutmarkerping_hide( params.pingindex );
            params.player calloutmarkerping_show( params.pingindex, params.player );
        }
    }
}

// Namespace common_item
// Params 16
// Checksum 0x9be5ece7, Offset: 0x96fc
// Size: 0x3b1
function items_analytics( droppedid, stowedid, equippedid, boughtid, soldid, typestring, fromcache, fromriftreward, itemname, itemorigin, itemcount, itemcost, critical, owner, staged, source )
{
    if ( !isdefined( itemorigin ) )
    {
        return;
    }
    
    player = self;
    
    if ( droppedid > 0 && !isdefined( owner ) )
    {
        owner = player;
    }
    
    var_5ac0ed4708b2b186 = isplayer( owner ) ? owner getplayerunoid() : "-1";
    
    if ( function_97de808fe549b3b7() )
    {
        player function_ad05aed95a44741e( -7994121687702711924, [ 22:source ?? "", 21:staged ?? 0, 20:var_5ac0ed4708b2b186, 19:critical ?? 0, 18:itemcost ?? -1, 17:itemcount ?? -1, 16:isdefined( level.br_circle.circleindex ) ? level.br_circle.circleindex : -1, 15:isxhashasset( itemname ) ? itemname : getxhashasset( tolower( itemname ) ?? "" ), 14:itemorigin[ 2 ], 13:itemorigin[ 1 ], 12:itemorigin[ 0 ], fromriftreward ?? 0, 10:fromcache ?? 0, 9:isxhashasset( typestring ) ? typestring : getxhashasset( tolower( typestring ) ?? "" ), 8:soldid ?? 0, 7:boughtid ?? 0, 6:equippedid ?? 0, 5:stowedid ?? 0, 4:droppedid ?? 0 ] );
        return;
    }
    
    player dlog_recordplayerevent( "dlog_event_player_common_item", [ "dropped", droppedid ?? 0, "stowed", stowedid ?? 0, "equipped", equippedid ?? 0, "bought", boughtid ?? 0, "sold", soldid ?? 0, "type", isxhashasset( typestring ) ? typestring : getxhashasset( tolower( typestring ) ?? "" ), "from_cache", fromcache ?? 0, "from_rift_reward", fromriftreward ?? 0, "item_x", itemorigin[ 0 ], "item_y", itemorigin[ 1 ], "item_z", itemorigin[ 2 ], "item_name", isxhashasset( itemname ) ? itemname : getxhashasset( tolower( itemname ) ?? "" ), "circle_index", level.br_circle.circleindex ?? -1, "count", itemcount ?? -1, "cost", itemcost ?? -1, "critical", critical ?? 0, "owner", var_5ac0ed4708b2b186, "staged", staged ?? 0, "source", source ?? "" ] );
}

// Namespace common_item
// Params 2
// Checksum 0x394e72ae, Offset: 0x9ab5
// Size: 0x19c
function function_eddf962212836a3e( itembundle, issuccessful )
{
    if ( !isdefined( itembundle ) )
    {
        return;
    }
    
    if ( !player::isreallyalive( self ) )
    {
        return;
    }
    
    if ( self.var_e6ac0a1f19668b8e )
    {
        return;
    }
    
    if ( issuccessful )
    {
        raritybundle = function_b7eae989f62fad46( itembundle );
        
        if ( raritybundle.pickupsfx )
        {
            self playlocalsound( raritybundle.pickupsfx );
        }
        
        if ( itembundle.pickupsfx )
        {
            if ( utility::callsharedfunc( #"favorite_builds", #"hash_47ead78e8a40d1c0", itembundle.baseweapon, itembundle.rarity ) )
            {
                self playlocalsound( "br_legendary_2_loot_pickup_warzone_build" );
            }
            else if ( itembundle.pickupsfx == getxhash( "fly_br_legendary_loot_pickup" ) || itembundle.pickupsfx == getxhash( "uin_dmz_valuable_loot_pickup" ) )
            {
                self playlocalsound( itembundle.pickupsfx );
            }
            else
            {
                soundtoplay = itembundle.pickupsfx;
            }
        }
        
        self playsoundonmovingent( soundtoplay ?? "fly_pickup_gen" );
        return;
    }
    
    if ( isplayer( self ) )
    {
        self playsoundtoplayer( itembundle.denialsfx ?? "fly_pickup_deny", self );
    }
    
    if ( isdefined( itembundle.var_9a1139fe42bbb0b4 ) && utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
    {
        self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( itembundle.var_9a1139fe42bbb0b4 );
    }
}

// Namespace common_item
// Params 2
// Checksum 0x2921298d, Offset: 0x9c59
// Size: 0x85
function function_bc5ff2958b71a708( spawnorigin, spawnangles )
{
    spawnoptions = { #var_18608bd8660b3a19:0, #dropradiusscale:1, #var_8d4f327170228364:1, #var_23d3495c57d61bdf:1, #var_90cdc5dbcd319e5d:1, #var_9161cf0784b6951d:1, #baseangles:spawnangles, #baseorigin:spawnorigin, #spawnpositionindex:0 };
    return spawnoptions;
}

// Namespace common_item
// Params 2
// Checksum 0x80714033, Offset: 0x9ce7
// Size: 0x4f
function items_initspawnoptions_spawnfromposition( fromorigin, fromangles )
{
    spawnoptions = { #dropradiusscale:1, #baseangles:fromangles, #baseorigin:fromorigin, #spawnpositionindex:0 };
    return spawnoptions;
}

// Namespace common_item
// Params 1
// Checksum 0x2620ae6b, Offset: 0x9d3f
// Size: 0x8f
function items_initspawnoptions_spawnfromentity( spawningentity )
{
    assert( isdefined( spawningentity ), "<dev string:x1378>" );
    spawnoptions = { #var_cce4312374b1b531:level.gametypebundle.var_cce4312374b1b531, #spawningentity:spawningentity, #dropradiusscale:1, #baseangles:spawningentity.angles, #baseorigin:spawningentity.origin, #spawnpositionindex:0 };
    return spawnoptions;
}

// Namespace common_item
// Params 1
// Checksum 0x8a3ed7c7, Offset: 0x9dd7
// Size: 0x8f
function function_c5093ef57497e721( spawningscriptable )
{
    assert( isdefined( spawningscriptable ), "<dev string:x138e>" );
    spawnoptions = { #var_cce4312374b1b531:level.gametypebundle.var_cce4312374b1b531, #spawningentity:spawningscriptable, #dropradiusscale:1, #baseangles:spawningscriptable.angles, #baseorigin:spawningscriptable.origin, #spawnpositionindex:0 };
    return spawnoptions;
}

// Namespace common_item
// Params 3
// Checksum 0xb13fb21a, Offset: 0x9e6f
// Size: 0x6e
function function_f5dfaa3bbdf99a33( toorigin, fromorigin, toangles )
{
    spawnoptions = { #dropradiusscale:1, #var_789c456dda9c8572:fromorigin, #var_9161cf0784b6951d:1, #baseangles:toangles, #baseorigin:toorigin, #spawnpositionindex:0 };
    return spawnoptions;
}

// Namespace common_item
// Params 3
// Checksum 0x2a7e7046, Offset: 0x9ee6
// Size: 0x58
function function_b94327aa4c1b718b( toorigin, spawningentity, toangles )
{
    spawnoptions = { #spawningentity:spawningentity, #baseangles:toangles, #baseorigin:toorigin, #spawnpositionindex:0 };
    return spawnoptions;
}

// Namespace common_item
// Params 1
// Checksum 0x4dd993be, Offset: 0x9f47
// Size: 0xcc8
function function_d94b7cedcd3ae9d0( spawnoptions )
{
    if ( !function_81b3ee2ff16cc3f0( spawnoptions ) )
    {
        assertmsg( "<dev string:x13a8>" );
        return;
    }
    
    workingdata = { #groundentity:undefined, #payload:0, #noground:0 };
    workingdata.baseorigin = spawnoptions.baseorigin;
    workingdata.baseangles = spawnoptions.baseangles ?? ( 0, 0, 0 );
    
    if ( !isdefined( workingdata.baseorigin ) && isdefined( spawnoptions.spawningentity ) && isdefined( spawnoptions.spawningentity.origin ) )
    {
        workingdata.baseorigin = spawnoptions.spawningentity.origin;
        workingdata.baseangles = spawnoptions.spawningentity.angles ?? ( 0, 0, 0 );
    }
    
    if ( !isdefined( workingdata.baseorigin ) )
    {
        println( "<dev string:x140e>" );
        return;
    }
    
    var_9161cf0784b6951d = istrue( spawnoptions.var_9161cf0784b6951d );
    var_8d4f327170228364 = istrue( spawnoptions.var_8d4f327170228364 );
    var_b8402e625c429a31 = istrue( spawnoptions.var_b8402e625c429a31 );
    var_23d3495c57d61bdf = istrue( spawnoptions.var_23d3495c57d61bdf );
    
    /#
        trace_draw_debug = level.var_b0ace4a89629a502;
        level notify( #"common_item_debug_positioning_drawing_reset" );
    #/
    
    groundfloat = spawnoptions.var_18608bd8660b3a19 ?? spawnoptions.var_a8cf639dcda6a7e5 ?? level.var_608f2b17211c7ff4;
    
    if ( !var_9161cf0784b6951d )
    {
        ring_quantity = spawnoptions.var_aec43e9d95b191f9 > 0 ? spawnoptions.var_aec43e9d95b191f9 : 3;
        var_df5bf71af4716f35 = spawnoptions.var_12d76a8b35ac875d > 0 ? spawnoptions.var_12d76a8b35ac875d : 7;
        slot_yaw = 360 / var_df5bf71af4716f35;
        var_f1b093a413fc702f = spawnoptions.var_8934e0ace9b7d996 ?? -5;
        var_f18d81a413d600e1 = spawnoptions.var_8958d2ace9e03584 ?? 5;
        var_16fe993707176f4e = spawnoptions.var_d72f168a0f299753 ?? -10;
        var_16da8b3706eed5cc = spawnoptions.var_d7522c8a0f500f6d ?? 10;
        var_1c9915ddfa8490a1 = spawnoptions.spawnpositionindex;
        
        if ( !spawnoptions.var_8f2dd74e9b3d807d && isdefined( spawnoptions.var_44d5025c8cfbd48e ) && spawnoptions.var_44d5025c8cfbd48e > 0 )
        {
            var_c52e93f2f7d7f128 = var_df5bf71af4716f35 * ring_quantity;
            
            if ( var_c52e93f2f7d7f128 < spawnoptions.var_44d5025c8cfbd48e )
            {
                ring_quantity += int( ( spawnoptions.var_44d5025c8cfbd48e - var_c52e93f2f7d7f128 ) / var_df5bf71af4716f35 ) + 1;
                var_c52e93f2f7d7f128 = var_df5bf71af4716f35 * ring_quantity;
            }
            
            var_1d15d9738adc1c3d = int( var_c52e93f2f7d7f128 / spawnoptions.var_44d5025c8cfbd48e );
            var_29916b5e2957f7ce = spawnoptions.spawnpositionindex * var_1d15d9738adc1c3d;
            var_4c65cfed63f1491e = 0;
            
            if ( var_1d15d9738adc1c3d > 1 )
            {
                var_4c65cfed63f1491e = randomintrange( 0, var_1d15d9738adc1c3d - 1 );
            }
            
            var_1c9915ddfa8490a1 = var_29916b5e2957f7ce + var_4c65cfed63f1491e;
        }
        
        var_6b4eba0d0802f652 = spawnoptions.var_2321e933cbdf46d8 ?? 52;
        var_625ed844eeb42047 = spawnoptions.var_34444f0dda11f0d5 ?? 35;
        workingdata.ring = int( var_1c9915ddfa8490a1 / var_df5bf71af4716f35 );
        workingdata.ringslot = var_1c9915ddfa8490a1 - workingdata.ring * var_df5bf71af4716f35;
        workingdata.yaw = workingdata.baseangles[ 1 ] + workingdata.ringslot * slot_yaw + workingdata.ring * 30 + randomfloatrange( var_f1b093a413fc702f, var_f18d81a413d600e1 );
        workingdata.dist = var_6b4eba0d0802f652 + workingdata.ring * var_625ed844eeb42047 + randomfloatrange( var_16fe993707176f4e, var_16da8b3706eed5cc );
        workingdata.dist *= spawnoptions.dropradiusscale ?? 1;
        
        if ( isdefined( spawnoptions.var_8e48a889d5a11dee ) )
        {
            var_d4ee8c5c2799a383 = 0;
            
            if ( spawnoptions.var_cb3b9e54c815a592 )
            {
                var_d4ee8c5c2799a383 = workingdata.ringslot * randomfloatrange( var_f1b093a413fc702f, var_f18d81a413d600e1 );
            }
            
            workingdata.yaw = workingdata.baseangles[ 1 ] + spawnoptions.var_8e48a889d5a11dee + var_d4ee8c5c2799a383;
        }
        
        workingdata.finalangles = ( 0, workingdata.yaw, 0 );
        workingdata.dir = anglestoforward( workingdata.finalangles );
        workingdata.finalorigin = spawnoptions.var_5c41ec8e64770998 ?? workingdata.baseorigin + workingdata.dir * workingdata.dist;
        
        if ( !var_23d3495c57d61bdf )
        {
            /#
                if ( trace_draw_debug )
                {
                    println( "<dev string:x147f>" + spawnoptions.spawnpositionindex + "<dev string:x148e>" + workingdata.baseorigin + "<dev string:x1496>" + workingdata.finalorigin + "<dev string:x149b>" + workingdata.dist );
                }
            #/
            
            ignoreents = [];
            
            if ( isent( spawnoptions.spawningentity ) )
            {
                ignoreents[ ignoreents.size ] = spawnoptions.spawningentity;
            }
            
            ignorescriptables = [];
            
            if ( spawnoptions.spawningentity && !isent( spawnoptions.spawningentity ) && spawnoptions.spawningentity isscriptableinstance() )
            {
                ignorescriptables[ ignorescriptables.size ] = spawnoptions.spawningentity;
            }
            
            tracecontents = spawnoptions.tracecontents ?? trace::create_contents( 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 1 );
            traceresults = function_b2e4806b57b40ea5( spawnoptions, workingdata, ignoreents, ignorescriptables, tracecontents, trace_draw_debug );
            var_62e67e2955fa3c80 = level.var_79d3cd44bf5dc96e;
            var_bdf5d609e9953448 = traceresults[ "fraction" ] < var_62e67e2955fa3c80;
            var_dab71209dc2ac45a = level.var_cb1501e12a8d7d58;
            
            if ( isdefined( traceresults ) && var_dab71209dc2ac45a > 0 && !isdefined( spawnoptions.var_8e48a889d5a11dee ) && !isdefined( spawnoptions.optionaloverridedist ) && !isdefined( spawnoptions.var_5c41ec8e64770998 ) )
            {
                var_e62521652d10ef58 = 0;
                
                if ( !isdefined( spawnoptions.optionaloverridedist ) && !isdefined( spawnoptions.var_5c41ec8e64770998 ) && !var_b8402e625c429a31 )
                {
                    var_e62521652d10ef58 = function_b78546b059633d8d( workingdata, spawnoptions, traceresults );
                }
                
                if ( var_e62521652d10ef58 > 0 || var_bdf5d609e9953448 )
                {
                    function_638fcb7ed9faa26e( spawnoptions, workingdata, ignoreents, ignorescriptables, tracecontents, var_dab71209dc2ac45a, var_62e67e2955fa3c80, trace_draw_debug, var_bdf5d609e9953448, var_e62521652d10ef58 );
                }
            }
            
            function_cad8e52aa133d752( spawnoptions, workingdata, ignoreents, ignorescriptables, tracecontents, trace_draw_debug );
            function_d67ddf38d79957e1( spawnoptions, workingdata, ignoreents, ignorescriptables, tracecontents, groundfloat, trace_draw_debug );
        }
        else
        {
            workingdata.finalorigin += ( 0, 0, groundfloat );
        }
        
        /#
            if ( level.var_4e991a74374e63c6 )
            {
                debug::sphere( workingdata.baseorigin, 8, ( 0, 1, 1 ), level.var_635178f7bf48e21e, level.var_fc8c25326b291055 );
                
                for ( ringindex = 0; ringindex < ring_quantity ; ringindex++ )
                {
                    for ( slotindex = 0; slotindex < var_df5bf71af4716f35 ; slotindex++ )
                    {
                        debugyaw = workingdata.baseangles[ 1 ] + slotindex * slot_yaw + ringindex * 30;
                        debugdirection = anglestoforward( ( 0, debugyaw, 0 ) );
                        debugdistance = ( var_6b4eba0d0802f652 + ringindex * var_625ed844eeb42047 ) * ( spawnoptions.dropradiusscale ?? 1 );
                        slotposition = workingdata.baseorigin + debugdirection * debugdistance;
                        debug::sphere( slotposition, 6, ( 0.5, 0, 1 ), level.var_635178f7bf48e21e, level.var_fc8c25326b291055 );
                    }
                }
            }
        #/
    }
    else
    {
        workingdata.finalorigin = workingdata.baseorigin;
        workingdata.finalangles = workingdata.baseangles;
    }
    
    if ( !var_8d4f327170228364 && !workingdata.noground )
    {
        startorigin = workingdata.baseorigin;
        var_624678d2587320f5 = 0;
        
        if ( isdefined( spawnoptions.var_789c456dda9c8572 ) )
        {
            startorigin = spawnoptions.var_789c456dda9c8572;
            var_624678d2587320f5 = 1;
        }
        else if ( isdefined( spawnoptions.spawningentity ) && isdefined( spawnoptions.spawningentity.origin ) )
        {
            startorigin = spawnoptions.spawningentity.origin;
            var_624678d2587320f5 = 1;
        }
        
        if ( !spawnoptions.var_eca4e7e2498e4c7b && !isdefined( spawnoptions.var_789c456dda9c8572 ) )
        {
            var_5ed1783f697f746b = spawnoptions.var_fda2f324ea7e833b ?? 40;
            
            if ( !isdefined( spawnoptions.var_fda2f324ea7e833b ) && isent( spawnoptions.spawningentity ) && isplayer( spawnoptions.spawningentity ) && player::isreallyalive( spawnoptions.spawningentity ) )
            {
                currentstance = spawnoptions.spawningentity getstance();
                
                if ( currentstance == "crouch" )
                {
                    var_5ed1783f697f746b = 20;
                }
                else if ( currentstance == "prone" )
                {
                    var_5ed1783f697f746b = 10;
                }
            }
            
            startorigin += ( 0, 0, var_5ed1783f697f746b );
        }
        
        /#
            if ( level.var_4e991a74374e63c6 )
            {
                debug::sphere( startorigin, 6, ( 0, 1, 0 ), level.var_635178f7bf48e21e, level.var_fc8c25326b291055 );
            }
        #/
        
        if ( var_624678d2587320f5 )
        {
            updatedyaw = vectortoyaw( workingdata.finalorigin - startorigin );
            workingdata.finalangles = ( 0, updatedyaw, 0 );
        }
        
        if ( spawnoptions.var_e85b32ed8f09c2db )
        {
            if ( startorigin[ 2 ] < workingdata.finalorigin[ 2 ] )
            {
                offsetz = workingdata.finalorigin[ 2 ] - startorigin[ 2 ];
                startorigin += ( 0, 0, offsetz );
            }
        }
        
        workingdata.payload = calcscriptablepayloadgravityarc( startorigin, workingdata.finalorigin );
    }
    
    /#
        if ( trace_draw_debug )
        {
            println( "<dev string:x147f>" + spawnoptions.spawnpositionindex + "<dev string:x14a5>" + workingdata.finalorigin + "<dev string:x14b5>" + workingdata.finalangles );
        }
    #/
    
    spawnoptions.spawnpositionindex++;
    
    if ( isdefined( spawnoptions.var_10a99b46418cef2 ) )
    {
        spawnoptions.var_10a99b46418cef2[ spawnoptions.var_10a99b46418cef2.size ] = workingdata.finalorigin;
    }
    
    /#
        if ( level.var_4e991a74374e63c6 )
        {
            debug::sphere( workingdata.finalorigin, 6, ( 1, 0, 0 ), level.var_635178f7bf48e21e, level.var_fc8c25326b291055 );
        }
    #/
    
    if ( groundfloat > 2 && isdefined( spawnoptions.var_a8b08eb03152fd48 ) )
    {
        angleoffset = ( spawnoptions.var_a8b08eb03152fd48.x ?? 0, spawnoptions.var_a8b08eb03152fd48.y ?? 0, spawnoptions.var_a8b08eb03152fd48.z ?? 0 );
        workingdata.finalangles += angleoffset;
    }
    
    return function_b4bee4333994e45a( workingdata.finalorigin, workingdata.finalangles, workingdata.payload, workingdata.groundentity );
}

// Namespace common_item
// Params 1
// Checksum 0x74e0418a, Offset: 0xac18
// Size: 0x77, Type: bool
function function_81b3ee2ff16cc3f0( spawnoptions )
{
    if ( !isstruct( spawnoptions ) )
    {
        return false;
    }
    
    var_7c8d4a4cf9df7966 = isdefined( spawnoptions.spawnpositionindex );
    var_78922a28d6c8706f = isdefined( spawnoptions.baseorigin ) || isdefined( spawnoptions.spawningent ) && isdefined( spawnoptions.spawningent.origin );
    return var_7c8d4a4cf9df7966 && var_78922a28d6c8706f;
}

// Namespace common_item
// Params 2, eflags: 0x4
// Checksum 0x66286d9e, Offset: 0xac98
// Size: 0x16c
function private function_655dca79b82ddaf0( origin, radius )
{
    var_deb180b177fe5b43 = [];
    
    if ( isdefined( level.cratedata.crates ) )
    {
        var_6dcee38c2f9efde5 = function_6a293b884c444a20( level.cratedata.crates, origin, radius );
        var_deb180b177fe5b43 = arraycombine( var_deb180b177fe5b43, var_6dcee38c2f9efde5 );
    }
    
    if ( isdefined( level.uavtowers ) )
    {
        var_6dcee38c2f9efde5 = function_6a293b884c444a20( level.uavtowers, origin, radius );
        var_deb180b177fe5b43 = arraycombine( var_deb180b177fe5b43, var_6dcee38c2f9efde5 );
    }
    
    if ( isdefined( level.ammorestocklocs ) )
    {
        var_6dcee38c2f9efde5 = function_6a293b884c444a20( level.ammorestocklocs, origin, radius );
        var_deb180b177fe5b43 = arraycombine( var_deb180b177fe5b43, var_6dcee38c2f9efde5 );
    }
    
    if ( isdefined( level.common_armory_kiosk.instances ) )
    {
        var_6dcee38c2f9efde5 = function_6a293b884c444a20( level.common_armory_kiosk.instances, origin, radius );
        var_deb180b177fe5b43 = arraycombine( var_deb180b177fe5b43, var_6dcee38c2f9efde5 );
    }
    
    if ( isdefined( level.br_armory_trader.scriptables ) )
    {
        var_6dcee38c2f9efde5 = function_6a293b884c444a20( level.br_armory_trader.scriptables, origin, radius );
        var_deb180b177fe5b43 = arraycombine( var_deb180b177fe5b43, var_6dcee38c2f9efde5 );
    }
    
    if ( isdefined( level.s_intel_quest.var_6634648543763933 ) )
    {
        var_6dcee38c2f9efde5 = function_6a293b884c444a20( level.s_intel_quest.var_6634648543763933, origin, radius );
        var_deb180b177fe5b43 = arraycombine( var_deb180b177fe5b43, var_6dcee38c2f9efde5 );
    }
    
    return var_deb180b177fe5b43;
}

// Namespace common_item
// Params 3, eflags: 0x4
// Checksum 0xbc4763b6, Offset: 0xae0d
// Size: 0x22b
function private function_b78546b059633d8d( workingdata, spawnoptions, traceresults )
{
    var_b11dd31fe1385910 = level.var_f285d458084b8d58 * level.var_f285d458084b8d58;
    
    if ( isdefined( spawnoptions.var_10a99b46418cef2 ) )
    {
        foreach ( scriptableorigin in spawnoptions.var_10a99b46418cef2 )
        {
            if ( distance2dsquared( traceresults[ "position" ], scriptableorigin ) < var_b11dd31fe1385910 )
            {
                return 1;
            }
        }
    }
    
    foreach ( pos in spawnoptions.spawningentity.var_cb1849bfbe476505 )
    {
        if ( distance2dsquared( traceresults[ "position" ], pos ) < var_b11dd31fe1385910 )
        {
            return 1;
        }
    }
    
    var_ab77385fc096c11a = workingdata.dist + level.var_f285d458084b8d58 + 8;
    scriptablenearby = getlootscriptablearrayinradius( undefined, undefined, traceresults[ "position" ], var_ab77385fc096c11a );
    var_7acda65ab0c25c0c = function_655dca79b82ddaf0( traceresults[ "position" ], var_ab77385fc096c11a );
    scriptablenearby = arraycombine( scriptablenearby, var_7acda65ab0c25c0c );
    value = 0;
    
    if ( isdefined( scriptablenearby ) && scriptablenearby.size > 0 )
    {
        value = function_fa77d84c0f1fee5f( scriptablenearby, spawnoptions, workingdata, traceresults );
    }
    
    entitiesnearby = getentitiesinradiusfrompartitiongrid( traceresults[ "position" ], var_ab77385fc096c11a, createentitytypemask( [ "etype_scriptmover" ] ) );
    
    if ( isdefined( entitiesnearby ) && entitiesnearby.size > 0 )
    {
        value = function_fa77d84c0f1fee5f( entitiesnearby, spawnoptions, workingdata, traceresults );
    }
    
    return value;
}

// Namespace common_item
// Params 4, eflags: 0x4
// Checksum 0x4950ee5a, Offset: 0xb041
// Size: 0x29a
function private function_fa77d84c0f1fee5f( var_79fa2716e007810f, spawnoptions, workingdata, traceresults )
{
    if ( !isdefined( var_79fa2716e007810f ) || var_79fa2716e007810f.size == 0 )
    {
        return 0;
    }
    
    var_8e768f40cb96ff87 = [ "ks_airdrop_marker_t10_mp" ];
    var_eb7ad776c23ae51d = [ "br_plunder_box", "br_loot_cache", "br_reusable_loot_cache", "br_loot_cache_lege", "br_loot_cache_personal_supply", "ammo_restock", "military_ammo_restock_noent", "airdrop_loadout", "scriptable_uav_tower" ];
    
    foreach ( element in var_79fa2716e007810f )
    {
        if ( !isdefined( element.origin ) || isdefined( spawnoptions.ignoreents ) && arraycontains( spawnoptions.ignoreents, element ) || isdefined( element.type ) && arraycontains( var_8e768f40cb96ff87, element.type ) )
        {
            continue;
        }
        
        if ( isdefined( element.cratetype ) || isdefined( element.type ) && arraycontains( var_eb7ad776c23ae51d, element.type ) )
        {
            /#
                if ( level.var_b0ace4a89629a502 )
                {
                    println( "<dev string:x147f>" + spawnoptions.spawnpositionindex + "<dev string:x14b7>" );
                    debug::sphere( workingdata.finalorigin, level.var_f285d458084b8d58 + 8, ( 1, 0, 0 ), level.var_635178f7bf48e21e, level.var_fc8c25326b291055 );
                }
            #/
            
            return 2;
        }
        
        if ( distance2d( traceresults[ "position" ], element.origin ) < level.var_f285d458084b8d58 )
        {
            /#
                if ( level.var_b0ace4a89629a502 )
                {
                    println( "<dev string:x147f>" + spawnoptions.spawnpositionindex + "<dev string:x14e6>" );
                    debug::sphere( workingdata.finalorigin, level.var_f285d458084b8d58, ( 1, 0, 0 ), level.var_635178f7bf48e21e, level.var_fc8c25326b291055 );
                }
            #/
            
            return 1;
        }
    }
    
    return 0;
}

// Namespace common_item
// Params 6, eflags: 0x4
// Checksum 0xaf45e601, Offset: 0xb2e4
// Size: 0x1dc
function private function_b2e4806b57b40ea5( spawnoptions, workingdata, ignoreents, ignorescriptables, tracecontents, trace_draw_debug )
{
    var_2ad016f2492a629d = spawnoptions.var_fc803688fa7c976c ?? level.var_9fa769fe9c8b2a15;
    tracestart = workingdata.baseorigin + ( 0, 0, var_2ad016f2492a629d );
    wallgrace = workingdata.dir * 18;
    traceend = workingdata.finalorigin + wallgrace + ( 0, 0, var_2ad016f2492a629d );
    
    if ( !spawnoptions.var_67c68639f233f902 )
    {
        traceresults = trace::ray_trace( tracestart, traceend, ignoreents, tracecontents, undefined, undefined, 1, ignorescriptables );
    }
    else
    {
        traceresults = trace::ray_trace_detail( tracestart, traceend, ignoreents, tracecontents );
    }
    
    /#
        if ( trace_draw_debug )
        {
            function_6a8f88ee03bb2123( spawnoptions.spawnpositionindex, "<dev string:x150f>", tracestart, traceend, traceresults );
        }
    #/
    
    if ( traceresults[ "fraction" ] < 1 )
    {
        workingdata.finalorigin = traceresults[ "position" ];
    }
    else
    {
        workingdata.finalorigin = traceend;
    }
    
    workingdata.finalorigin -= wallgrace;
    heightchecks = level.var_79d23cbd8d065edc;
    
    for ( check = 0; check < heightchecks ; check++ )
    {
        tracestart += ( 0, 0, 10 * check );
        hightraceresults = trace::ray_trace( tracestart, traceend, ignoreents, tracecontents );
        
        if ( hightraceresults[ "fraction" ] < traceresults[ "fraction" ] )
        {
            traceresults[ "fraction" ] = -1;
        }
    }
    
    return traceresults;
}

// Namespace common_item
// Params 10, eflags: 0x4
// Checksum 0xb46a95f9, Offset: 0xb4c9
// Size: 0x4fe
function private function_638fcb7ed9faa26e( spawnoptions, workingdata, ignoreents, ignorescriptables, tracecontents, retries, var_62e67e2955fa3c80, trace_draw_debug, var_bdf5d609e9953448, var_e62521652d10ef58 )
{
    var_df5bf71af4716f35 = spawnoptions.var_12d76a8b35ac875d ?? 7;
    slot_yaw = function_89fa4a425cf1013f( spawnoptions, var_e62521652d10ef58, var_bdf5d609e9953448, var_df5bf71af4716f35 );
    var_f1b093a413fc702f = spawnoptions.var_8934e0ace9b7d996 ?? -5;
    var_f18d81a413d600e1 = spawnoptions.var_8958d2ace9e03584 ?? 5;
    var_6b4eba0d0802f652 = spawnoptions.var_2321e933cbdf46d8 ?? 52;
    var_625ed844eeb42047 = spawnoptions.var_34444f0dda11f0d5 ?? 35;
    var_16fe993707176f4e = spawnoptions.var_d72f168a0f299753 ?? -10;
    var_16da8b3706eed5cc = spawnoptions.var_d7522c8a0f500f6d ?? 10;
    
    for ( attempts = 0; attempts < retries ; attempts++ )
    {
        spawnoptions.spawnpositionindex++;
        workingdata.ring = int( spawnoptions.spawnpositionindex / var_df5bf71af4716f35 );
        workingdata.ringslot = spawnoptions.spawnpositionindex - workingdata.ring * var_df5bf71af4716f35;
        workingdata.yaw = workingdata.baseangles[ 1 ] + workingdata.ringslot * slot_yaw + workingdata.ring * 30 + randomfloatrange( var_f1b093a413fc702f, var_f18d81a413d600e1 );
        workingdata.dist = var_6b4eba0d0802f652 + workingdata.ring * var_625ed844eeb42047 + randomfloatrange( var_16fe993707176f4e, var_16da8b3706eed5cc );
        workingdata.dist *= spawnoptions.dropradiusscale ?? 1;
        workingdata.finalangles = ( 0, workingdata.yaw, 0 );
        workingdata.dir = anglestoforward( workingdata.finalangles );
        workingdata.finalorigin = workingdata.baseorigin + workingdata.dir * workingdata.dist;
        traceresults = function_b2e4806b57b40ea5( spawnoptions, workingdata, ignoreents, ignorescriptables, tracecontents, trace_draw_debug );
        var_e62521652d10ef58 = function_b78546b059633d8d( workingdata, spawnoptions, traceresults );
        
        if ( traceresults[ "fraction" ] >= var_62e67e2955fa3c80 && var_e62521652d10ef58 == 0 )
        {
            /#
                if ( trace_draw_debug )
                {
                    debug::sphere( workingdata.finalorigin, level.var_f285d458084b8d58, ( 0, 1, 0 ), level.var_635178f7bf48e21e, level.var_fc8c25326b291055 );
                    thread function_75a879c121de2d99( attempts );
                }
            #/
            
            return;
        }
        
        /#
            if ( trace_draw_debug )
            {
                debug::sphere( workingdata.finalorigin, 4, ( 1, 0, 0 ), level.var_635178f7bf48e21e, level.var_fc8c25326b291055 );
            }
        #/
    }
    
    spawnoptions.spawnpositionindex++;
    workingdata.ring = int( spawnoptions.spawnpositionindex / var_df5bf71af4716f35 );
    workingdata.ringslot = spawnoptions.spawnpositionindex - workingdata.ring * var_df5bf71af4716f35;
    workingdata.yaw = workingdata.baseangles[ 1 ] + workingdata.ringslot * slot_yaw + workingdata.ring * 30 + randomfloatrange( var_f1b093a413fc702f, var_f18d81a413d600e1 );
    workingdata.dist = var_6b4eba0d0802f652 + workingdata.ring * var_625ed844eeb42047 + randomfloatrange( var_16fe993707176f4e, var_16da8b3706eed5cc );
    workingdata.dist *= spawnoptions.dropradiusscale ?? 1;
    workingdata.finalangles = ( 0, workingdata.yaw, 0 );
    workingdata.dir = anglestoforward( workingdata.finalangles );
    workingdata.finalorigin = workingdata.baseorigin + workingdata.dir * workingdata.dist;
    traceresults = function_b2e4806b57b40ea5( spawnoptions, workingdata, ignoreents, ignorescriptables, tracecontents, trace_draw_debug );
    
    /#
        if ( trace_draw_debug )
        {
            debug::sphere( workingdata.finalorigin, 4, ( 157, 0, 255 ), level.var_635178f7bf48e21e, level.var_fc8c25326b291055 );
            thread function_75a879c121de2d99( attempts );
        }
    #/
}

// Namespace common_item
// Params 4, eflags: 0x4
// Checksum 0x27f9c112, Offset: 0xb9cf
// Size: 0xba
function private function_89fa4a425cf1013f( spawnoptions, var_e62521652d10ef58, var_bdf5d609e9953448, var_df5bf71af4716f35 )
{
    slot_yaw = 360 / var_df5bf71af4716f35;
    
    if ( !var_bdf5d609e9953448 && var_e62521652d10ef58 )
    {
        if ( var_e62521652d10ef58 == 1 )
        {
            slot_yaw = level.var_6ddf3426036ea4fe;
        }
        else if ( var_e62521652d10ef58 == 2 )
        {
            slot_yaw = 80;
        }
        
        if ( isdefined( spawnoptions.spawnitemsize ) )
        {
            switch ( spawnoptions.spawnitemsize )
            {
                case #"hash_4bf33d595d8f4894":
                    slot_yaw = 60;
                    break;
                default:
                    slot_yaw = level.var_6ddf3426036ea4fe;
                    break;
            }
        }
    }
    
    return slot_yaw;
}

// Namespace common_item
// Params 6, eflags: 0x4
// Checksum 0x637bb4ae, Offset: 0xba92
// Size: 0x113
function private function_cad8e52aa133d752( spawnoptions, workingdata, ignoreents, ignorescriptables, tracecontents, trace_draw_debug )
{
    tracestart = workingdata.finalorigin;
    traceend = workingdata.finalorigin + ( 0, 0, 60 );
    traceresults = trace::ray_trace( tracestart, traceend, ignoreents, tracecontents, undefined, undefined, 1, ignorescriptables );
    
    /#
        if ( trace_draw_debug )
        {
            function_6a8f88ee03bb2123( spawnoptions.spawnpositionindex, "<dev string:x1512>", tracestart + ( 0, 1, 0 ), traceend + ( 0, 1, 0 ), traceresults );
        }
    #/
    
    if ( traceresults[ "fraction" ] < 1 )
    {
        workingdata.finalorigin = traceresults[ "position" ] + ( 0, 0, -6 );
    }
    else
    {
        workingdata.finalorigin = traceend;
    }
    
    return traceresults;
}

// Namespace common_item
// Params 7, eflags: 0x4
// Checksum 0x767e949b, Offset: 0xbbae
// Size: 0x3ee
function private function_d67ddf38d79957e1( spawnoptions, workingdata, ignoreents, ignorescriptables, tracecontents, groundfloat, trace_draw_debug )
{
    if ( level.var_eca35f80c78570e0 && isent( self ) )
    {
        platform = utility::function_7c45b71b8e0d3cff();
        
        if ( isdefined( platform.groundent ) && platform.groundent vehicle::is_vehicle() && !utility::is_moving_platform_ent( platform.groundent ) )
        {
            ignoreents[ ignoreents.size ] = platform.groundent;
        }
    }
    
    tracestart = workingdata.finalorigin;
    traceheight = spawnoptions.var_712a4caf7acec5ca ?? level.var_b0878a4f306c03a8;
    var_fbaf852c9cb6dff8 = -1 * traceheight;
    traceend = workingdata.finalorigin + ( 0, 0, var_fbaf852c9cb6dff8 );
    triescount = 0;
    
    if ( !isdefined( ignorescriptables ) )
    {
        ignorescriptables = [];
    }
    
    while ( triescount < 8 )
    {
        traceresults = trace::ray_trace( tracestart, traceend, ignoreents, tracecontents, undefined, undefined, 1, ignorescriptables );
        
        if ( traceresults[ "scriptable" ] && traceresults[ "scriptable" ] function_9c6277f3d28901d5( #"hash_4ea86d7f6719f6f1" ) )
        {
            ignorescriptables = arraycombineunique( ignorescriptables, [ traceresults[ "scriptable" ] ] );
            triescount++;
            continue;
        }
        
        break;
    }
    
    /#
        if ( trace_draw_debug )
        {
            function_6a8f88ee03bb2123( spawnoptions.spawnpositionindex, "<dev string:x1515>", tracestart, traceend, traceresults );
        }
    #/
    
    if ( traceresults[ "fraction" ] < 1 )
    {
        workingdata.finalorigin = traceresults[ "position" ] + ( 0, 0, groundfloat );
        workingdata.groundentity = traceresults[ "entity" ];
        isvalidvehicle = workingdata.groundentity && workingdata.groundentity vehicle::is_vehicle();
        
        if ( isvalidvehicle && ( workingdata.groundentity.isdestroyed || workingdata.groundentity.burningdown || workingdata.groundentity vehicle::function_b4b334e3af2d4d0() || !function_19e5b92df49a461d( workingdata.groundentity ) && spawnoptions.var_50e31f8c119ef961 ) )
        {
            if ( isent( workingdata.groundentity ) )
            {
                ignoreents[ ignoreents.size ] = workingdata.groundentity;
            }
            
            traceresults = trace::ray_trace( workingdata.finalorigin, traceend, ignoreents, tracecontents );
            
            /#
                if ( trace_draw_debug )
                {
                    function_6a8f88ee03bb2123( spawnoptions.spawnpositionindex, "<dev string:x1518>", workingdata.finalorigin, traceend, traceresults );
                }
            #/
            
            if ( traceresults[ "fraction" ] < 1 )
            {
                workingdata.finalorigin = traceresults[ "position" ] + ( 0, 0, groundfloat );
                workingdata.groundentity = traceresults[ "entity" ];
            }
            else
            {
                /#
                    if ( trace_draw_debug )
                    {
                        println( "<dev string:x147f>" + spawnoptions.spawnpositionindex + "<dev string:x151c>" );
                    }
                #/
                
                workingdata.finalorigin = ( 0, 0, 0 );
                workingdata.noground = 1;
            }
        }
    }
    else
    {
        /#
            if ( trace_draw_debug )
            {
                println( "<dev string:x147f>" + spawnoptions.spawnpositionindex + "<dev string:x151c>" );
            }
        #/
        
        workingdata.finalorigin = spawnoptions.var_b4368cb7bde8ae79 ?? ( 0, 0, 0 );
        workingdata.noground = 1;
    }
    
    return traceresults;
}

// Namespace common_item
// Params 4
// Checksum 0xa98717cd, Offset: 0xbfa5
// Size: 0x90
function function_b4bee4333994e45a( finalorigin, finalangles, payload, groundentity )
{
    assert( isdefined( finalorigin ) );
    positioningresults = spawnstruct();
    positioningresults.finalorigin = finalorigin;
    positioningresults.finalangles = finalangles ?? ( 0, 0, 0 );
    positioningresults.payload = payload ?? 0;
    positioningresults.groundentity = groundentity;
    return positioningresults;
}

// Namespace common_item
// Params 1, eflags: 0x4
// Checksum 0xfcbcc1a1, Offset: 0xc03e
// Size: 0xc4
function private function_d121c2c924c18e19( droppingent )
{
    if ( !isdefined( level.var_2ed4ce0707247c36 ) )
    {
        level.var_2ed4ce0707247c36 = [ 0, 6, 1, 5, 2, 7, 13, 8, 12, 14, 20, 15, 19 ];
    }
    
    if ( !isdefined( droppingent.dropindex ) )
    {
        droppingent.dropindex = 0;
        thread function_b08264dcc35431bf( droppingent );
    }
    else
    {
        droppingent.dropindex++;
    }
    
    return level.var_2ed4ce0707247c36[ droppingent.dropindex % level.var_2ed4ce0707247c36.size ];
}

// Namespace common_item
// Params 1, eflags: 0x4
// Checksum 0x4a5c5157, Offset: 0xc10b
// Size: 0xdb
function private function_b08264dcc35431bf( droppingent )
{
    droppingent endon( #"disconnect" );
    
    if ( isent( droppingent ) && !isplayer( droppingent ) )
    {
        droppingent endon( #"death" );
    }
    
    if ( !isdefined( droppingent.dropindex ) )
    {
        return;
    }
    
    startorigin = droppingent.origin;
    startangles = droppingent.angles;
    
    while ( isdefined( droppingent ) && distancesquared( startorigin, droppingent.origin ) < 100 && ( !( isdefined( startangles ) && isdefined( droppingent.angles ) ) || anglesdelta( startangles, droppingent.angles ) < 10 ) )
    {
        wait 1;
    }
    
    if ( isdefined( droppingent ) )
    {
        droppingent.dropindex = undefined;
    }
}

// Namespace common_item
// Params 0, eflags: 0x4
// Checksum 0x24591582, Offset: 0xc1ee
// Size: 0x43
function private function_cc3e3f110bb67a46()
{
    if ( !isdefined( level.var_262ff6e551405147 ) )
    {
        level.var_262ff6e551405147 = utility::function_edc4cc03e9e60b3e( @"hash_96d8824bfb870e1f", 0, level.gametypebundle.var_262ff6e551405147 );
    }
    
    return level.var_262ff6e551405147;
}

// Namespace common_item
// Params 1
// Checksum 0x21987c50, Offset: 0xc23a
// Size: 0x99
function items_getlootidfromref( ref )
{
    if ( !isdefined( level.var_c2ec1ee1716fa425 ) )
    {
        level.var_c2ec1ee1716fa425 = [];
    }
    
    var_7237854e3be197ca = level.var_c2ec1ee1716fa425[ ref ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( !isdefined( ref ) )
    {
        return;
    }
    
    lootinfo = getLootItemInfoFromRef( ref );
    
    if ( !isdefined( lootinfo.itemid ) )
    {
        return;
    }
    
    lootid = lootinfo.itemid;
    
    if ( lootid == 0 )
    {
        return;
    }
    
    level.var_c2ec1ee1716fa425[ ref ] = lootid;
    return lootid;
}

// Namespace common_item
// Params 1
// Checksum 0x3bcdb203, Offset: 0xc2dc
// Size: 0x6d
function function_779887309ec71dfe( itembundle )
{
    if ( !isdefined( itembundle ) )
    {
        return;
    }
    
    if ( !isdefined( itembundle.ref ) )
    {
        /#
            itembundlename = common_item_database::function_ca9ca606e66b5911( itembundle.scriptable );
            println( "<dev string:x1528>" + getxhashsourcename( itembundlename ) + "<dev string:x1568>" );
        #/
        
        return;
    }
    
    return items_getlootidfromref( itembundle.ref );
}

// Namespace common_item
// Params 1
// Checksum 0x37882579, Offset: 0xc352
// Size: 0x51
function function_b01955b20c77371d( itembundlename )
{
    ref = getscriptbundlefieldvalue( itembundlename, #"ref" );
    
    if ( !isdefined( ref ) )
    {
        println( "<dev string:x1587>" + getxhashsourcename( itembundlename ) + "<dev string:x1568>" );
        return;
    }
    
    return items_getlootidfromref( ref );
}

// Namespace common_item
// Params 1
// Checksum 0x76efc91d, Offset: 0xc3ac
// Size: 0x7f
function function_6d301ac91c3cd13d( item )
{
    itembundlename = common_item_database::function_ca9ca606e66b5911( item.type );
    
    if ( isdefined( itembundlename ) )
    {
        itemtype = function_3cba34a99d02cd9( itembundlename );
        var_b1f24b36e4b32a0c = function_c6f3ef3dcb4c55c0( itemtype, #"lootidfromitem" );
        
        if ( isdefined( var_b1f24b36e4b32a0c ) )
        {
            lootid = [[ var_b1f24b36e4b32a0c ]]( item );
        }
        
        return ( lootid ?? function_b01955b20c77371d( itembundlename ) );
    }
}

// Namespace common_item
// Params 1
// Checksum 0x202ea4b7, Offset: 0xc434
// Size: 0x17
function function_f3fdebbb09f39fb1( overridefunc )
{
    self.pickupoverride = overridefunc;
}

// Namespace common_item
// Params 0
// Checksum 0xcdc56a6c, Offset: 0xc453
// Size: 0xc, Type: bool
function function_e00e74d334622919()
{
    return isdefined( self.pickupoverride );
}

// Namespace common_item
// Params 0
// Checksum 0x89e0006e, Offset: 0xc468
// Size: 0xc
function function_b03dfc0306cdc37()
{
    self.pickupoverride = undefined;
}

// Namespace common_item
// Params 5
// Checksum 0xc1fe1009, Offset: 0xc47c
// Size: 0xd9
function function_88fc33fa5edff36e( index, itembundle, lootid, quantity, fromgroup )
{
    self notify( #"hash_3426004a0254f8a0" );
    self endon( #"hash_3426004a0254f8a0" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !isdefined( itembundle.throwingweapon ) )
    {
        return;
    }
    
    gestureweapon = makeweapon( itembundle.throwingweapon );
    result = weapon_utility::giveandfireoffhandreliable( gestureweapon );
    
    if ( !result )
    {
        return;
    }
    
    if ( common_inventory::inventory_isenabled() )
    {
        currentquantity = common_inventory::inventory_getquantityatbackpackindex( index );
        lootid = common_inventory::inventory_getlootidatbackpackindex( index );
        common_inventory::inventory_setbackpackitematindex( index, lootid, currentquantity - 1 );
    }
}

// Namespace common_item
// Params 1
// Checksum 0xb4554354, Offset: 0xc55d
// Size: 0x9c
function function_5ce7004ad09f0dce( statename )
{
    self notify( #"hash_72e4fda260eace7d" );
    self endon( #"hash_72e4fda260eace7d" );
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( !isdefined( statename ) || !self getscriptablehaspart( #"glow_hints" ) || !self getscriptableparthasstate( #"glow_hints", statename ) )
    {
        return;
    }
    
    while ( self getscriptablepartstate( self.type ) != #"visible" )
    {
        waitframe();
    }
    
    self setscriptablepartstate( #"glow_hints", statename );
}

// Namespace common_item
// Params 1, eflags: 0x4
// Checksum 0x2909ae6f, Offset: 0xc601
// Size: 0x48
function private function_19e5b92df49a461d( vehicle )
{
    if ( !vehicle )
    {
        return 0;
    }
    
    if ( !vehicle.vehiclename )
    {
        return 0;
    }
    
    return utility::callsharedfunc( #"game", #"hash_b6b5399db45fe301", vehicle.vehiclename );
}

/#

    // Namespace common_item
    // Params 1
    // Checksum 0x32f9f9f2, Offset: 0xc652
    // Size: 0x4e, Type: dev
    function clean_name( itembundlename )
    {
        source_name = getxhashsourcename( itembundlename );
        tokens = strtok( source_name, "<dev string:x141>" );
        
        if ( isdefined( tokens ) && tokens.size > 1 )
        {
            return tokens[ 1 ];
        }
        
        return source_name;
    }

    // Namespace common_item
    // Params 1
    // Checksum 0xda68f10a, Offset: 0xc6a8
    // Size: 0x29, Type: dev
    function function_82b5c516ed0330ce( str )
    {
        if ( !str )
        {
            return;
        }
        
        return utility::string_replace( str, "<dev string:x15c8>", "<dev string:x15ca>" );
    }

    // Namespace common_item
    // Params 1
    // Checksum 0x158c301f, Offset: 0xc6d9
    // Size: 0x33, Type: dev
    function get_ui_name( bundle )
    {
        if ( bundle.titlestring )
        {
            return function_82b5c516ed0330ce( debugtranslatestring( bundle.titlestring ) );
        }
    }

    // Namespace common_item
    // Params 0
    // Checksum 0xfea6bc7f, Offset: 0xc714
    // Size: 0xe0, Type: dev
    function setup_item_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x15cc>" );
        devgui::add_devgui_func( "<dev string:x15df>", "<dev string:x15f1>", &draw_items, 1 );
        devgui::add_devgui_func( "<dev string:x1609>", "<dev string:x1629>", &function_e22627b9ccb1d8d1 );
        devgui::add_devgui_func( "<dev string:x1649>", "<dev string:x165f>", &function_6e01e43dd291c8a );
        devgui::add_devgui_func( "<dev string:x167b>", "<dev string:x16a1>", &function_f898cd71cd3bac93 );
        devgui::add_devgui_func( "<dev string:x16cc>", "<dev string:x16f0>", &function_8f286097f5beabf7 );
        devgui::add_devgui_func( "<dev string:x1715>", "<dev string:x1727>", &cleanup_all_items );
        devgui::add_devgui_func( "<dev string:x1746>", "<dev string:x1756>", &spawn_all_items );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1773>", "<dev string:x178d>", &function_59bc2a16783c8dc9 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x17af>", "<dev string:x17ca>", &function_59bc2a16783c8dc9 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace common_item
    // Params 1
    // Checksum 0xc26cfd41, Offset: 0xc7fc
    // Size: 0x178, Type: dev
    function function_d211b8a8f539dff2( item_bundle_name )
    {
        if ( getdvarint( @"debug_common_item", 1 ) == 0 )
        {
            return;
        }
        
        item_bundle = getscriptbundlefieldvalues( item_bundle_name, [ #"lootitemtype", #"subtype", #"scriptable", #"hash_4b82c186d47bf884" ] );
        item_type_folder = "<dev string:x17ed>";
        
        if ( isdefined( item_bundle.lootitemtype ) )
        {
            typeref = getscriptbundlefieldvalue( item_bundle.lootitemtype, #"typeref" );
            
            if ( typeref != "<dev string:x17ed>" )
            {
                item_type_folder = typeref + "<dev string:x15c8>";
            }
        }
        
        var_712ad2cffd40b565 = "<dev string:x17ed>";
        
        if ( isdefined( item_bundle.subtype ) && item_bundle.subtype != "<dev string:x17ed>" )
        {
            var_712ad2cffd40b565 = item_bundle.subtype + "<dev string:x15c8>";
        }
        
        if ( !isdefined( item_bundle.scriptable ) )
        {
            return;
        }
        
        clean_name = clean_name( item_bundle_name );
        var_210acc0548b4017a = get_ui_name( item_bundle );
        devgui::function_cd4e263c1f3018ae( "<dev string:x17ee>" + item_type_folder + var_712ad2cffd40b565 + ( var_210acc0548b4017a ? clean_name + "<dev string:x1808>" + var_210acc0548b4017a + "<dev string:x180c>" : clean_name ), "<dev string:x180f>" + clean_name, &devgui_spawn_item, 0, 0 );
    }

    // Namespace common_item
    // Params 0, eflags: 0x4
    // Checksum 0x9b475f4c, Offset: 0xc97c
    // Size: 0xed, Type: dev
    function private draw_items()
    {
        while ( true )
        {
            items = scriptable_group::function_dbae202082772159( "<dev string:x181b>" );
            
            if ( isdefined( items ) )
            {
                foreach ( item in items )
                {
                    sphere( item.origin, 10, ( 1, 0, 0 ), 1 );
                    line( item.origin, item.origin + ( 0, 0, 50 ), ( 1, 0, 0 ), 1, 1 );
                }
            }
            
            waitframe();
        }
    }

    // Namespace common_item
    // Params 0, eflags: 0x4
    // Checksum 0xe3361001, Offset: 0xca71
    // Size: 0x22, Type: dev
    function private function_6e01e43dd291c8a()
    {
        level.var_a8f146b752a0b76a = !isdefined( level.var_a8f146b752a0b76a ) ? 1 : undefined;
    }

    // Namespace common_item
    // Params 0, eflags: 0x4
    // Checksum 0xecac8138, Offset: 0xca9b
    // Size: 0x30, Type: dev
    function private function_8f286097f5beabf7()
    {
        level.var_a336e76759a3ba47 = !level.var_a336e76759a3ba47;
        iprintlnbold( "<dev string:x1828>" + int( level.var_a336e76759a3ba47 ) );
    }

    // Namespace common_item
    // Params 0, eflags: 0x4
    // Checksum 0xe0213275, Offset: 0xcad3
    // Size: 0x36, Type: dev
    function private function_e22627b9ccb1d8d1()
    {
        level.var_4e991a74374e63c6 = !level.var_4e991a74374e63c6;
        iprintlnbold( level.var_4e991a74374e63c6 ? "<dev string:x184b>" : "<dev string:x1869>" );
    }

    // Namespace common_item
    // Params 5
    // Checksum 0xbb325804, Offset: 0xcb11
    // Size: 0x159, Type: dev
    function function_6a8f88ee03bb2123( index, name, start, end, traceresults )
    {
        if ( traceresults[ "<dev string:x1888>" ] < 1 )
        {
            debug::line( start, traceresults[ "<dev string:x1891>" ], ( 1, 0, 0 ), level.var_635178f7bf48e21e, level.var_fc8c25326b291055 );
            
            if ( isdefined( traceresults[ "<dev string:x189a>" ] ) )
            {
                selectedentity = traceresults[ "<dev string:x189a>" ];
                println( "<dev string:x147f>" + index + "<dev string:x18a1>" + name + "<dev string:x18a4>" + traceresults[ "<dev string:x1888>" ] + "<dev string:x18aa>" + traceresults[ "<dev string:x1891>" ] + "<dev string:x18af>" + ( selectedentity.name ?? "<dev string:x29d>" ) );
            }
            else
            {
                println( "<dev string:x147f>" + index + "<dev string:x18a1>" + name + "<dev string:x18a4>" + traceresults[ "<dev string:x1888>" ] + "<dev string:x18aa>" + traceresults[ "<dev string:x1891>" ] );
            }
            
            return;
        }
        
        println( "<dev string:x147f>" + index + "<dev string:x18a1>" + name + "<dev string:x18b5>" );
        debug::line( start, end, ( 1, 1, 1 ), level.var_635178f7bf48e21e, level.var_fc8c25326b291055 );
    }

    // Namespace common_item
    // Params 6, eflags: 0x4
    // Checksum 0x5e4d754e, Offset: 0xcc72
    // Size: 0x7d, Type: dev
    function private function_acfb42dd003105e3( origin, radius, color, depthtest, duration, slot )
    {
        if ( level.var_4e991a74374e63c6 )
        {
            sphere( origin, radius, color, depthtest, duration );
            
            if ( isdefined( slot ) )
            {
                print3d( origin + ( 0, 0, 20 ), "<dev string:x18be>" + slot, color, undefined, undefined, duration );
            }
        }
    }

    // Namespace common_item
    // Params 6, eflags: 0x4
    // Checksum 0x595058f1, Offset: 0xccf7
    // Size: 0x55, Type: dev
    function private function_b9ad45d0cd6cd08c( start, end, color, alpha, depthtest, duration )
    {
        if ( level.var_4e991a74374e63c6 )
        {
            line( start, end, color, alpha, depthtest, duration );
        }
    }

    // Namespace common_item
    // Params 1
    // Checksum 0xef27554, Offset: 0xcd54
    // Size: 0x477, Type: dev
    function devgui_spawn_item( params )
    {
        item_name = params[ 0 ];
        payload = params[ 1 ];
        itemcount = params[ 2 ];
        player = isbrgamemode() ? function_760d292229949f0() : undefined;
        
        if ( item_name )
        {
            if ( isdefined( payload ) )
            {
                payload = [ #"teamselect", int( payload ) ];
            }
            
            foreach ( str_ref_key, str_item_bundle in level.commonitem.var_4d60369c227dcd1e )
            {
                if ( item_name == clean_name( str_item_bundle ) || item_name == str_ref_key )
                {
                    itembundle = getscriptbundle( str_item_bundle );
                    drop_pos = function_4fec258c8e1ea99c();
                    spawnoptions = player ? items_initspawnoptions_spawnfromentity( player ) : function_bc5ff2958b71a708( drop_pos );
                    spawnoptions.payload = payload;
                    spawnoptions.critical = level.var_a8f146b752a0b76a;
                    spawnoptions.var_8a5a7905ab5aaf83 = 1;
                    
                    if ( level.var_a336e76759a3ba47 )
                    {
                        spawnoptions.var_8d4f327170228364 = 0;
                    }
                    
                    item = function_61c2c0251e742ffd( itembundle, itemcount, spawnoptions );
                    
                    if ( item_name == "<dev string:x18c5>" )
                    {
                        item setscriptablepartstate( item.type, "<dev string:x18de>" );
                    }
                    
                    if ( itembundle.lootitemtype == %"hash_64dc964ad1555df8" )
                    {
                        if ( !isdefined( level.var_988b2cd99f2c1233 ) )
                        {
                            level.var_988b2cd99f2c1233 = 0;
                        }
                        
                        level.var_988b2cd99f2c1233 += 1;
                        
                        if ( !isdefined( player ) )
                        {
                            player = level.players[ 0 ];
                        }
                        
                        if ( !isdefined( item.additionaldata ) )
                        {
                            item.additionaldata = {};
                        }
                        
                        item.additionaldata.var_80a55ae41f929b49 = level.var_988b2cd99f2c1233;
                        dmz_dog_tag::function_34d0a7ddfa21db1c( { #origin:player.origin, #bountyScore:randomint( 10 ), #guid:level.var_988b2cd99f2c1233 }, player, "<dev string:x18e5>" );
                    }
                    
                    return;
                }
            }
            
            foreach ( var_953e3174865a7521, str_item_bundle in level.commonitem.var_1a1b8354fa1e275c )
            {
                if ( item_name == clean_name( str_item_bundle ) || item_name == var_953e3174865a7521 )
                {
                    itembundle = getscriptbundle( str_item_bundle );
                    drop_pos = function_4fec258c8e1ea99c();
                    spawnoptions = player ? items_initspawnoptions_spawnfromentity( player ) : function_bc5ff2958b71a708( drop_pos );
                    spawnoptions.payload = payload;
                    spawnoptions.critical = level.var_a8f146b752a0b76a;
                    
                    if ( level.var_a336e76759a3ba47 )
                    {
                        spawnoptions.var_8d4f327170228364 = 0;
                    }
                    
                    item = function_61c2c0251e742ffd( itembundle, itemcount, spawnoptions );
                    
                    if ( item_name == "<dev string:x18c5>" )
                    {
                        item setscriptablepartstate( item.type, "<dev string:x18de>" );
                    }
                    
                    return;
                }
            }
            
            itembundle = getscriptbundle( hashcat( %"itemspawnentry:", item_name ) );
            
            if ( isdefined( itembundle ) )
            {
                drop_pos = function_4fec258c8e1ea99c();
                spawnoptions = player ? items_initspawnoptions_spawnfromentity( player ) : function_bc5ff2958b71a708( drop_pos );
                spawnoptions.payload = payload;
                spawnoptions.critical = level.var_a8f146b752a0b76a;
                
                if ( level.var_a336e76759a3ba47 )
                {
                    spawnoptions.var_8d4f327170228364 = 0;
                }
                
                item = function_61c2c0251e742ffd( itembundle, itemcount, spawnoptions );
                
                if ( item_name == "<dev string:x18c5>" )
                {
                    item setscriptablepartstate( item.type, "<dev string:x18de>" );
                }
                
                return;
            }
            
            assertmsg( "<dev string:x18f0>" + item_name + "<dev string:x1929>" );
        }
    }

    // Namespace common_item
    // Params 0
    // Checksum 0xf8fce3e2, Offset: 0xd1d3
    // Size: 0xa3, Type: dev
    function function_760d292229949f0()
    {
        if ( level.players.size > 0 )
        {
            foreach ( player in level.players )
            {
                if ( isdefined( player ) && !isbot( player ) && !player isplayerheadless() )
                {
                    return player;
                }
            }
        }
    }

    // Namespace common_item
    // Params 0
    // Checksum 0xa8067524, Offset: 0xd27e
    // Size: 0x85, Type: dev
    function function_4fec258c8e1ea99c()
    {
        if ( level.players.size > 0 )
        {
            player = level.players[ 0 ];
            forward = anglestoforward( player getplayerangles() );
            drop_pos = player.origin + forward * 100;
            drop_pos = utility::drop_to_ground( drop_pos, 100 ) + ( 0, 0, 8 );
            return drop_pos;
        }
        
        return ( 0, 0, 0 );
    }

    // Namespace common_item
    // Params 1
    // Checksum 0x1e90fc65, Offset: 0xd30b
    // Size: 0x196, Type: dev
    function function_59bc2a16783c8dc9( params )
    {
        enabled = params[ 0 ] == "<dev string:x197e>";
        
        if ( level.players.size > 0 )
        {
            player = level.players[ 0 ];
            player_forward = anglestoforward( player getplayerangles() );
            result = trace::ray_trace( player geteye(), player geteye() + player_forward * 10000 );
            
            if ( isdefined( result[ "<dev string:x1891>" ] ) && result[ "<dev string:x1888>" ] < 1 )
            {
                cylinder( result[ "<dev string:x1891>" ], result[ "<dev string:x1891>" ] + ( 0, 0, 1 ), 32, ( 0, 1, 0 ), 0, 10 );
                scriptables = getscriptablearrayinradius( undefined, undefined, result[ "<dev string:x1891>" ], 32 );
                scriptables = arraycombine( scriptables, getlootscriptablearrayinradius( undefined, undefined, result[ "<dev string:x1891>" ], 32 ) );
                
                if ( scriptables.size == 0 )
                {
                    return;
                }
                
                foreach ( scriptable in scriptables )
                {
                    if ( scriptable getscriptableisloot() && scriptable getscriptableisusableonanypart() )
                    {
                        if ( enabled )
                        {
                            scriptable enablescriptableplayeruse( player );
                            continue;
                        }
                        
                        scriptable disablescriptableplayeruse( player );
                    }
                }
            }
        }
    }

    // Namespace common_item
    // Params 2
    // Checksum 0xd832bcf9, Offset: 0xd4a9
    // Size: 0x2a3, Type: dev
    function debugitem( command, args )
    {
        count = int( args[ 1 ] ?? 1 );
        
        switch ( command )
        {
            case #"hash_ee68f44ae144c886":
                devgui_spawn_item( args );
                break;
            case #"hash_c48caaedbff169ab":
                spawn_all_items( args );
                break;
            case #"hash_f9442c17e42ea782":
                spawnoptions = items_initspawnoptions_spawnfromentity( level.players[ 0 ] );
                function_325e28c0fb65c36a( args[ 0 ], count, spawnoptions );
                break;
            case #"hash_f29c95577d1afaaa":
                spawnoptions = items_initspawnoptions_spawnfromentity( level.players[ 0 ] );
                items_spawnitemfromscriptable( args[ 0 ], count, spawnoptions );
                break;
            case #"hash_df829e381b6ffb95":
                spawnoptions = items_initspawnoptions_spawnfromposition( level.players[ 0 ].origin );
                function_38cde6a6acb68ea6( args[ 0 ], count, spawnoptions );
                break;
            case #"hash_795377ce62b9e0ca":
                if ( !isdefined( level.equipment.table ) )
                {
                    break;
                }
                
                itemname = args[ 0 ];
                bundle = function_90c3e0c1fd55d6b6( "<dev string:x19cb>" + itemname );
                
                foreach ( player in level.players )
                {
                    player thread function_d29367b5476e2a65( bundle );
                }
                
                break;
            case #"hash_3f6eb64783282c6e":
                itemname = args[ 0 ];
                bundle = function_90c3e0c1fd55d6b6( "<dev string:x19cb>" + itemname );
                item = function_77600f92048df72d( bundle, count );
                
                foreach ( player in level.players )
                {
                    player function_96119bed8ab4c5d9( item, undefined, 1, 1 );
                }
                
                break;
            case #"hash_334c896e25dc8345":
                level thread function_ee032be27f0182d4();
                break;
            default:
                break;
        }
    }

    // Namespace common_item
    // Params 0, eflags: 0x4
    // Checksum 0x9893a86e, Offset: 0xd754
    // Size: 0x40, Type: dev
    function private function_ee032be27f0182d4()
    {
        level endon( #"game_ended" );
        lastupdatetime = gettime();
        waitframe();
        var_1adbe5dea1baa940 = gettime() - lastupdatetime;
        iprintlnbold( "<dev string:x19ec>" + var_1adbe5dea1baa940 );
    }

    // Namespace common_item
    // Params 1
    // Checksum 0xcbe40e7b, Offset: 0xd79c
    // Size: 0xe1, Type: dev
    function function_d29367b5476e2a65( bundle )
    {
        level endon( #"game_end" );
        self endon( #"disconnect" );
        
        if ( !player::isreallyalive( self ) || self.inlaststand )
        {
            return;
        }
        
        equip = level.equipment.table[ bundle.ref ];
        
        if ( !isdefined( equip ) )
        {
            return;
        }
        
        weap = equip.objweapon;
        
        if ( !isdefined( weap ) )
        {
            return;
        }
        
        result = weapon_utility::giveandfireoffhandreliable( weap );
        
        if ( result )
        {
            onfiredcallback = equipment_mp::getcallback( bundle.ref, "<dev string:x19f9>" );
            
            if ( isdefined( onfiredcallback ) )
            {
                self thread [[ onfiredcallback ]]( bundle.ref, undefined, weap );
            }
        }
    }

    // Namespace common_item
    // Params 1
    // Checksum 0x67ed7e85, Offset: 0xd885
    // Size: 0xd7, Type: dev
    function function_75a879c121de2d99( overlapamount )
    {
        level endon( #"game_end" );
        self endon( #"disconnect" );
        
        if ( !isdefined( self.var_71e0bfe5850d032d ) )
        {
            self.var_71e0bfe5850d032d = 0;
        }
        
        self.var_71e0bfe5850d032d += overlapamount;
        
        if ( isplayer( self ) )
        {
            iprintlnbold( "<dev string:x1a01>" + self getentitynumber() + "<dev string:x17c>" );
        }
        
        iprintlnbold( "<dev string:x1a04>" + self.var_71e0bfe5850d032d );
        wait 1;
        self.var_71e0bfe5850d032d = max( ( self.var_71e0bfe5850d032d ?? 0 ) - overlapamount, 0 );
        
        if ( isplayer( self ) )
        {
            iprintlnbold( "<dev string:x1a01>" + self getentitynumber() + "<dev string:x17c>" );
        }
        
        iprintlnbold( "<dev string:x1a04>" + self.var_71e0bfe5850d032d );
    }

    // Namespace common_item
    // Params 1
    // Checksum 0xfda5a12d, Offset: 0xd964
    // Size: 0x193, Type: dev
    function spawn_all_items( args )
    {
        baseorigin = level.players[ 0 ].origin;
        baseangles = level.players[ 0 ].angles;
        forward = anglestoforward( baseangles );
        right = anglestoright( baseangles );
        maxcolumns = 20;
        columncount = maxcolumns * 2;
        stepdist = 30;
        typefilter = args ?? [];
        
        foreach ( str_item_bundle in level.commonitem.var_1a1b8354fa1e275c )
        {
            itembundle = getscriptbundle( str_item_bundle );
            itemtype = function_16e8c106491eeaca( itembundle );
            
            if ( itemtype != "<dev string:x1a1c>" && ( arraycontains( typefilter, itemtype ) || typefilter.size == 0 ) )
            {
                origin = baseorigin + forward * stepdist * floor( columncount / maxcolumns ) + right * stepdist * columncount % maxcolumns;
                columncount++;
                function_a87dc047f584d2c7( itembundle, origin, undefined, undefined, 1 );
            }
        }
    }

    // Namespace common_item
    // Params 0, eflags: 0x4
    // Checksum 0x5206b8d5, Offset: 0xdaff
    // Size: 0x36, Type: dev
    function private function_f898cd71cd3bac93()
    {
        level.var_3327cc6ea7faa2ba = !level.var_3327cc6ea7faa2ba;
        iprintlnbold( level.var_3327cc6ea7faa2ba ? "<dev string:x1a22>" : "<dev string:x1a41>" );
    }

#/
