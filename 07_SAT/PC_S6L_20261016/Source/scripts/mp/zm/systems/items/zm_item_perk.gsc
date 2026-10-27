// scripts\mp\zm\systems\items\zm_item_perk.gsc  (hash_0501d719ea707242.gscc) (size: 1053 Bytes / 0x41d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x883eba1d (2285812253)
// size ...... 1053 (0x41d)
// includes .. 3   (offset: 0x3dd)
// strings ... 2   (offset: 0x3f5)
// dev strs .. 0   (offset: 0x41d)
// exports ... 5   (offset: 0x209)
// cseg ...... 0x72 + 0x197 (0x209)
// imports ... 9   (offset: 0x2d1)
// animtree1 . 0   (offset: 0x41d)
// animtree2 . 0   (offset: 0x41d)
#using scripts\common\values;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\loot\common_item;

#namespace zm_item_perk;

// Namespace zm_item_perk
// Params 0
// Checksum 0x82a7223, Offset: 0x90
// Size: 0x76
function init_item_perk()
{
    common_item::function_4b30c091d3b04a25( "perk" );
    common_item::function_84174b793b5fe9a7( "perk", #"use", &pickup_perk );
    common_item::function_84174b793b5fe9a7( "perk", #"canautouse", &function_d37d521f98011b3e );
    common_item::function_84174b793b5fe9a7( "perk", #"hash_9e49dfaa7c147654", &function_d37d521f98011b3e );
    common_item::function_84174b793b5fe9a7( "perk", #"hash_2d3b76ff260f2d68", &function_541e93a9762816e8 );
}

// Namespace zm_item_perk
// Params 4
// Checksum 0x512e2d76, Offset: 0x10e
// Size: 0x4f, Type: bool
function function_d37d521f98011b3e( itembundle, item, auto_pickup, var_a0f59cb55797bb59 )
{
    if ( zombie_perks::has_perk( itembundle.ref ) || !val::get( "allow_zm_perks" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_item_perk
// Params 4
// Checksum 0xf805a48f, Offset: 0x166
// Size: 0x3d, Type: bool
function pickup_perk( itembundle, item, autouse, var_981c264073bf1154 )
{
    zombie_perks::grab_and_use_perk( itembundle.ref, 0, 1 );
    return false;
}

// Namespace zm_item_perk
// Params 5
// Checksum 0x961ff555, Offset: 0x1ac
// Size: 0x5c
function function_541e93a9762816e8( index, itembundle, lootid, quantity, fromgroup )
{
    success = zombie_perks::grab_and_use_perk( itembundle.ref );
    return success ? quantity - 1 : quantity;
}

