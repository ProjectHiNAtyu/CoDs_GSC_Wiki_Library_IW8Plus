// scripts\autotests\mp\autotests_utility_content.gsc  (hash_1084adee4715e4bc.gscc) (size: 1649 Bytes / 0x671 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2321835c (589398876)
// size ...... 1649 (0x671)
// includes .. 6   (offset: 0x5e1)
// strings ... 8   (offset: 0x611)
// dev strs .. 0   (offset: 0x671)
// exports ... 5   (offset: 0x2f9)
// cseg ...... 0xcd + 0x22c (0x2f9)
// imports ... 19  (offset: 0x3c1)
// animtree1 . 0   (offset: 0x671)
// animtree2 . 0   (offset: 0x671)
#using scripts\autotests\autotests;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\equipment;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;

#namespace autotests_utility_content;

// Namespace autotests_utility_content
// Params 0
// Checksum 0x892f79bf, Offset: 0xeb
// Size: 0x2f
function registercallbacks()
{
    if ( !callback::exists( #"player_item_pickup", &notify_item_obtained ) )
    {
        callback::add( #"player_item_pickup", &notify_item_obtained );
    }
}

// Namespace autotests_utility_content
// Params 0
// Checksum 0xe38301dd, Offset: 0x122
// Size: 0x17
function removecallbacks()
{
    callback::remove( #"player_item_pickup", &notify_item_obtained );
}

// Namespace autotests_utility_content
// Params 2
// Checksum 0x1bc0db7, Offset: 0x141
// Size: 0x197
function equipcontent( player, contentref )
{
    itemtype = undefined;
    
    if ( common_item::items_isenabled() )
    {
        itembundle = common_item::function_cf68ad18114498b2( contentref );
        
        if ( !isdefined( itembundle ) )
        {
            autotests::report_info( "Item bundle not found for ref: " + contentref );
            return { #itemtype:undefined, #result:0 };
        }
        
        itemtype = common_item::function_16e8c106491eeaca( itembundle );
        bundlename = common_item_database::function_a4f0a21951180013( contentref );
        autotests::set_current_asset_name( contentref );
        item = common_item::function_77600f92048df72d( itembundle, itembundle.spawncount );
        player common_item::function_2b5e2ff57d5f392( item, 0, 0, bundlename, itembundle, itemtype );
        player utility::waittill_any_timeout( 1, "item_obtained" );
    }
    else
    {
        if ( isstartstr( contentref, "super_" ) )
        {
            itemtype = "super";
            player utility::callsharedfunc( #"supers", #"givesuper", contentref, 0, 1 );
        }
        else if ( isstartstr( contentref, "equip_" ) )
        {
            itemtype = equipment_mp::isequipmenttactical( contentref ) ? "tactical" : "lethal";
            player utility::callsharedfunc( #"equipment", #"hash_54e1244070e4625c", contentref, equipment_mp::getdefaultslot( contentref ) );
        }
        else
        {
            itemtype = "killstreak";
            player utility::callsharedfunc( #"killstreak", #"awardkillstreak", contentref );
        }
        
        wait 0.5;
    }
    
    return { #itemtype:itemtype, #result:1 };
}

// Namespace autotests_utility_content
// Params 1, eflags: 0x4
// Checksum 0x6a1d7354, Offset: 0x2e1
// Size: 0x18
function private notify_item_obtained( params )
{
    self notify( #"item_obtained" );
}

