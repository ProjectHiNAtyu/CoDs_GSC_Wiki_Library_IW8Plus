// script_3457513587e5331f  (hash_3457513587e5331f.gscc) (size: 590 Bytes / 0x24e)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xda33b7a1 (3660822433)
// size ...... 590 (0x24e)
// includes .. 1   (offset: 0x23a)
// strings ... 1   (offset: 0x242)
// dev strs .. 0   (offset: 0x24e)
// exports ... 5   (offset: 0x102)
// cseg ...... 0x6c + 0x96 (0x102)
// imports ... 4   (offset: 0x1ca)
// animtree1 . 0   (offset: 0x24e)
// animtree2 . 0   (offset: 0x24e)
#using script_63258e3c8c400b7a;

#namespace cardpurchasemenu;

// Namespace cardpurchasemenu
// Params 0
// Checksum 0x5bad1b02, Offset: 0x8a
// Size: 0x16
function register()
{
    return lui_elems::register_lui_elem( "CardPurchaseMenu", #"cardpurchasemenu" );
}

// Namespace cardpurchasemenu
// Params 2
// Checksum 0xb2fdea61, Offset: 0xa9
// Size: 0x1f
function open( player, flags )
{
    lui_elems::open_lui_elem( player, flags );
}

// Namespace cardpurchasemenu
// Params 1
// Checksum 0x561a96d7, Offset: 0xd0
// Size: 0x15
function close( player )
{
    lui_elems::close_lui_elem( player );
}

// Namespace cardpurchasemenu
// Params 1
// Checksum 0x46458516, Offset: 0xed
// Size: 0x14
function is_open( player )
{
    return lui_elems::is_open_lui_elem( player );
}

