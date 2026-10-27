// scripts\mp\zm\systems\items\zm_item_currency.gsc  (hash_0c6a99c521eb6b99.gscc) (size: 1395 Bytes / 0x573 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2f5e456d (794707309)
// size ...... 1395 (0x573)
// includes .. 5   (offset: 0x50b)
// strings ... 4   (offset: 0x533)
// dev strs .. 0   (offset: 0x573)
// exports ... 6   (offset: 0x2b3)
// cseg ...... 0x8a + 0x229 (0x2b3)
// imports ... 12  (offset: 0x3a3)
// animtree1 . 0   (offset: 0x573)
// animtree2 . 0   (offset: 0x573)
#using script_72d1ece3cbd0884a;
#using scripts\common\utility;
#using scripts\mp\currency;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\points;

#namespace zm_item_currency;

// Namespace zm_item_currency
// Params 0
// Checksum 0x2abdeb5b, Offset: 0xa8
// Size: 0xac
function init_item_currency()
{
    common_item::function_4b30c091d3b04a25( "currency" );
    common_item::function_84174b793b5fe9a7( "currency", #"use", &pickup_currency );
    common_item::function_84174b793b5fe9a7( "currency", #"canautouse", &function_ccd5a182b4945bd1 );
    common_item::function_84174b793b5fe9a7( "currency", #"hash_2d3b76ff260f2d68", &function_aecd3a675b0bc771 );
    common_item::function_84174b793b5fe9a7( "currency", #"database_additem", &function_563598851e75afab );
    
    if ( getdvarint( @"hash_1a0aac3eab65ce39", 1 ) )
    {
        namespace_4bd17a2ee56036fa::function_5cfef02beb796343( "essence" );
        namespace_4bd17a2ee56036fa::function_5cfef02beb796343( "salvage" );
        namespace_4bd17a2ee56036fa::function_5cfef02beb796343( "rare_salvage" );
    }
}

// Namespace zm_item_currency
// Params 4
// Checksum 0x1cdfa387, Offset: 0x15c
// Size: 0x29, Type: bool
function function_ccd5a182b4945bd1( itembundle, item, auto_pickup, var_a0f59cb55797bb59 )
{
    return true;
}

// Namespace zm_item_currency
// Params 4
// Checksum 0xa5a82a76, Offset: 0x18e
// Size: 0x9a, Type: bool
function pickup_currency( itembundle, item, autouse, var_981c264073bf1154 )
{
    currency_type = itembundle.subtype;
    currency_amount = item.count;
    
    if ( currency_type == #"essence" )
    {
        currency_amount = points::zm_modify_points( currency_amount, undefined, self );
        item.count = int( currency_amount );
    }
    
    if ( !itembundle.var_b809e106e0052656 )
    {
        currency::add_currency_amount( currency_type, currency_amount );
    }
    
    return false;
}

// Namespace zm_item_currency
// Params 5
// Checksum 0x97bc7d3d, Offset: 0x231
// Size: 0x52, Type: bool
function function_aecd3a675b0bc771( index, itembundle, lootid, quantity, fromgroup )
{
    currency_type = itembundle.subtype;
    currency::add_currency_amount( currency_type, quantity );
    return false;
}

// Namespace zm_item_currency
// Params 1, eflags: 0x4
// Checksum 0x907579cd, Offset: 0x28c
// Size: 0x27
function private function_563598851e75afab( itembundlename )
{
    utility::callsharedfunc( #"vehicle_pickup", #"databaseadditem", itembundlename );
}

