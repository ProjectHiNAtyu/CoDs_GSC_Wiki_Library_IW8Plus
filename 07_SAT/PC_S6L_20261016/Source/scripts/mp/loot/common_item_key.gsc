// scripts\mp\loot\common_item_key.gsc  (hash_24a724688d1b7b0a.gscc) (size: 865 Bytes / 0x361 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x47ccff50 (1204617040)
// size ...... 865 (0x361)
// includes .. 2   (offset: 0x341)
// strings ... 1   (offset: 0x351)
// dev strs .. 0   (offset: 0x361)
// exports ... 4   (offset: 0x1dd)
// cseg ...... 0x5f + 0x17e (0x1dd)
// imports ... 7   (offset: 0x27d)
// animtree1 . 0   (offset: 0x361)
// animtree2 . 0   (offset: 0x361)
#using scripts\common\system;
#using scripts\mp\loot\common_item;

#namespace item_lootkey;

// Namespace item_lootkey
// Params 0, eflags: 0x5
// Checksum 0x48e5ff54, Offset: 0x7d
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"item_key", #"common_item", &init_item_key, undefined );
}

// Namespace item_lootkey
// Params 0
// Checksum 0x38679dbc, Offset: 0xa6
// Size: 0x33
function init_item_key()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    common_item::function_4b30c091d3b04a25( "key" );
    common_item::function_84174b793b5fe9a7( "key", #"use", &use_key_item );
}

// Namespace item_lootkey
// Params 4
// Checksum 0xa352ad4b, Offset: 0xe1
// Size: 0xfb
function use_key_item( itembundle, item, autouse, var_981c264073bf1154 )
{
    if ( !level.gametypebundle.var_b9b9c4d8fbcad0e9 )
    {
        return item.count;
    }
    
    if ( !isdefined( self.equippedkeys ) )
    {
        self.equippedkeys = [];
    }
    
    if ( !isdefined( self.equippedkeys[ item.type ] ) )
    {
        self.equippedkeys[ item.type ] = 0;
    }
    
    usedquantity = minint( item.count, itembundle.maxcount - self.equippedkeys[ item.type ] );
    self.equippedkeys[ item.type ] += usedquantity;
    return usedquantity;
}

