// scripts\mp\loot\common_item_perk.gsc  (hash_76a5d8a6343e8c41.gscc) (size: 2772 Bytes / 0xad4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2a03f6bc (704902844)
// size ...... 2772 (0xad4)
// includes .. 4   (offset: 0xa78)
// strings ... 3   (offset: 0xa98)
// dev strs .. 0   (offset: 0xad4)
// exports ... 12  (offset: 0x670)
// cseg ...... 0x72 + 0x5fe (0x670)
// imports ... 18  (offset: 0x850)
// animtree1 . 0   (offset: 0xad4)
// animtree2 . 0   (offset: 0xad4)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;

#namespace item_perk;

// Namespace item_perk
// Params 0, eflags: 0x5
// Checksum 0xfa567423, Offset: 0x90
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"item_perk", #"common_item", &init_item_perk, undefined );
}

// Namespace item_perk
// Params 0
// Checksum 0x1e711d41, Offset: 0xb9
// Size: 0xb7
function init_item_perk()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    if ( isdefined( level.init_item_perk_override ) )
    {
        [[ level.init_item_perk_override ]]();
        return;
    }
    
    common_item::function_4b30c091d3b04a25( "perk" );
    common_item::function_84174b793b5fe9a7( "perk", #"use", &use_perk );
    common_item::function_84174b793b5fe9a7( "perk", #"canautouse", &utility::always_false );
    common_item::function_84174b793b5fe9a7( "perk", #"hash_9e49dfaa7c147654", &can_use_perk );
    common_item::function_84174b793b5fe9a7( "perk", #"hash_2d3b76ff260f2d68", &function_541e93a9762816e8 );
    common_item::function_84174b793b5fe9a7( "perk", #"database_additem", &function_f448700e00dfef8d );
}

// Namespace item_perk
// Params 4
// Checksum 0xc469527c, Offset: 0x178
// Size: 0xdb
function use_perk( itembundle, item, autouse, var_981c264073bf1154 )
{
    usedperk = 0;
    
    if ( !item.fromcache )
    {
        usedperk = utility::callsharedfunc( #"loot_perks", #"hash_ab5f9559e80fdb52", itembundle.ref );
    }
    else if ( !utility::callsharedfunc( #"loot_perks", #"hash_2041bc8577e77110", itembundle.ref ) )
    {
        utility::callsharedfunc( #"loot_perks", #"hash_d60bebeaed508539", itembundle.ref, 1 );
        usedperk = 1;
    }
    
    if ( usedperk )
    {
        return ( item.count - 1 );
    }
    
    return item.count;
}

// Namespace item_perk
// Params 4
// Checksum 0x38e312e1, Offset: 0x25c
// Size: 0x4b, Type: bool
function can_use_perk( itembundle, item, autouse, allowswap )
{
    return !utility::callsharedfunc( #"loot_perks", #"hash_2041bc8577e77110", itembundle.ref );
}

// Namespace item_perk
// Params 5
// Checksum 0x32613013, Offset: 0x2b0
// Size: 0x83
function function_541e93a9762816e8( index, itembundle, lootid, quantity, fromgroup )
{
    if ( !utility::callsharedfunc( #"loot_perks", #"hash_2041bc8577e77110", itembundle.ref ) )
    {
        utility::callsharedfunc( #"loot_perks", #"hash_ab5f9559e80fdb52", itembundle.ref );
        return ( quantity - 1 );
    }
    
    return quantity;
}

// Namespace item_perk
// Params 1
// Checksum 0x60a0892f, Offset: 0x33c
// Size: 0x17e
function function_f448700e00dfef8d( bundlename )
{
    if ( !utility::issharedfuncdefined( #"hash_cbd3c460cd3d9ee8", #"isenabled" ) || !utility::callsharedfunc( #"hash_cbd3c460cd3d9ee8", #"isenabled" ) || !isdefined( level.gametypebundle.var_755920657e3e5d3e ) )
    {
        return;
    }
    
    itembundle = getscriptbundlefieldvalues( bundlename, [ #"subtype", #"traitlevel", #"traittype", #"ref", #"traitcategory" ] );
    
    if ( itembundle.subtype != "trait" || itembundle.traittype != "Minor" )
    {
        return;
    }
    
    categorynum = utility::callsharedfunc( #"hash_cbd3c460cd3d9ee8", #"hash_5e9abc50bf29c45c", itembundle.traitcategory );
    
    if ( !isdefined( categorynum ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_2e9af223e05576b3 ) )
    {
        level.var_2e9af223e05576b3 = [];
    }
    
    if ( !isdefined( level.var_2e9af223e05576b3[ categorynum ] ) )
    {
        level.var_2e9af223e05576b3[ categorynum ] = [];
    }
    
    if ( !isdefined( level.var_2e9af223e05576b3[ categorynum ] ) )
    {
        level.var_2e9af223e05576b3[ categorynum ] = [];
    }
    
    level.var_2e9af223e05576b3[ categorynum ][ level.var_2e9af223e05576b3[ categorynum ].size ] = itembundle;
}

// Namespace item_perk
// Params 4
// Checksum 0xe04c2176, Offset: 0x4c2
// Size: 0x98, Type: bool
function use_perk_dmz( itembundle, item, autouse, var_981c264073bf1154 )
{
    utility::callsharedfunc( #"perk", #"giveperk", itembundle.ref );
    
    if ( itembundle.subtype == "trait" && utility::issharedfuncdefined( #"hash_cbd3c460cd3d9ee8", #"addtrait" ) )
    {
        utility::callsharedfunc( #"hash_cbd3c460cd3d9ee8", #"addtrait", itembundle, item );
    }
    
    return false;
}

// Namespace item_perk
// Params 4
// Checksum 0xa5a15db4, Offset: 0x563
// Size: 0x33
function function_450841566b1fc4aa( itembundle, item, autouse, allowswap )
{
    return can_use_perk_dmz( itembundle, item, autouse, allowswap );
}

// Namespace item_perk
// Params 4
// Checksum 0x26948f55, Offset: 0x59f
// Size: 0x50, Type: bool
function can_use_perk_dmz( itembundle, item, autouse, allowswap )
{
    if ( !isdefined( itembundle.ref ) )
    {
        return false;
    }
    
    return !isdefined( self.perks[ itembundle.ref ] );
}

// Namespace item_perk
// Params 2
// Checksum 0x282712d, Offset: 0x5f8
// Size: 0x37
function function_a75d14f9c4d648aa( item, name )
{
    if ( !isdefined( item.ref ) )
    {
        return;
    }
    
    return common_item_database::function_a4f0a21951180013( item.ref );
}

// Namespace item_perk
// Params 2
// Checksum 0x7a19acc0, Offset: 0x638
// Size: 0x37
function function_6acc72ac0ef67ec1( item, name )
{
    if ( !isdefined( item.ref ) )
    {
        return;
    }
    
    return common_item::items_getlootidfromref( item.ref );
}

