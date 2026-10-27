// scripts\mp\loot\common_item_recipe.gsc  (hash_61c5ad29aef03393.gscc) (size: 818 Bytes / 0x332 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x26fd6d9a (654142874)
// size ...... 818 (0x332)
// includes .. 2   (offset: 0x30a)
// strings ... 1   (offset: 0x31a)
// dev strs .. 0   (offset: 0x332)
// exports ... 5   (offset: 0x172)
// cseg ...... 0x62 + 0x110 (0x172)
// imports ... 7   (offset: 0x23a)
// animtree1 . 0   (offset: 0x332)
// animtree2 . 0   (offset: 0x332)
#using scripts\common\system;
#using scripts\mp\loot\common_item;

#namespace common_item_recipe;

// Namespace common_item_recipe
// Params 0, eflags: 0x5
// Checksum 0x5405241b, Offset: 0x80
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"item_recipe", #"common_item", &init_item_recipe, undefined );
}

// Namespace common_item_recipe
// Params 0
// Checksum 0x454406f6, Offset: 0xa9
// Size: 0x67
function init_item_recipe()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    common_item::function_4b30c091d3b04a25( "recipe" );
    common_item::function_84174b793b5fe9a7( "recipe", #"use", &use_recipe );
    common_item::function_84174b793b5fe9a7( "recipe", #"canautouse", &function_edf300bc9ca85484 );
    common_item::function_84174b793b5fe9a7( "recipe", #"hash_9e49dfaa7c147654", &function_edf300bc9ca85484 );
}

// Namespace common_item_recipe
// Params 4
// Checksum 0x187528a0, Offset: 0x118
// Size: 0x28, Type: bool
function function_edf300bc9ca85484( itembundle, item, auto_use, var_51e0c31d31f04b31 )
{
    return false;
}

// Namespace common_item_recipe
// Params 4
// Checksum 0x552bb10b, Offset: 0x149
// Size: 0x28, Type: bool
function use_recipe( itembundle, item, autouse, var_981c264073bf1154 )
{
    return false;
}

