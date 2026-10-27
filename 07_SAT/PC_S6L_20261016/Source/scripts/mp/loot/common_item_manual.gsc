// scripts\mp\loot\common_item_manual.gsc  (hash_043b0f97705dc383.gscc) (size: 818 Bytes / 0x332 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdfc7439 (234648633)
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

#namespace common_item_manual;

// Namespace common_item_manual
// Params 0, eflags: 0x5
// Checksum 0x6be92c03, Offset: 0x80
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"item_manual", #"common_item", &init_item_manual, undefined );
}

// Namespace common_item_manual
// Params 0
// Checksum 0x89f00655, Offset: 0xa9
// Size: 0x67
function init_item_manual()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    common_item::function_4b30c091d3b04a25( "manual" );
    common_item::function_84174b793b5fe9a7( "manual", #"use", &use_manual );
    common_item::function_84174b793b5fe9a7( "manual", #"canautouse", &function_d5474de460fb3038 );
    common_item::function_84174b793b5fe9a7( "manual", #"hash_9e49dfaa7c147654", &function_d5474de460fb3038 );
}

// Namespace common_item_manual
// Params 4
// Checksum 0xd4c12803, Offset: 0x118
// Size: 0x28, Type: bool
function function_d5474de460fb3038( itembundle, item, auto_use, var_51e0c31d31f04b31 )
{
    return false;
}

// Namespace common_item_manual
// Params 4
// Checksum 0x999fb1a8, Offset: 0x149
// Size: 0x28, Type: bool
function use_manual( itembundle, item, autouse, var_981c264073bf1154 )
{
    return false;
}

