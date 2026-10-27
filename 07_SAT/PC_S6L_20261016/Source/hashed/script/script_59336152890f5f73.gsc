// script_59336152890f5f73  (hash_59336152890f5f73.gscc) (size: 593 Bytes / 0x251)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfa2e5676 (4197340790)
// size ...... 593 (0x251)
// includes .. 1   (offset: 0x23d)
// strings ... 1   (offset: 0x245)
// dev strs .. 0   (offset: 0x251)
// exports ... 5   (offset: 0x105)
// cseg ...... 0x6f + 0x96 (0x105)
// imports ... 4   (offset: 0x1cd)
// animtree1 . 0   (offset: 0x251)
// animtree2 . 0   (offset: 0x251)
#using script_63258e3c8c400b7a;

#namespace ZMCraftingTableMenu;

// Namespace ZMCraftingTableMenu
// Params 0
// Checksum 0xc98e66f5, Offset: 0x8d
// Size: 0x16
function register()
{
    return lui_elems::register_lui_elem( "ZMCraftingTableMenu", #"zmcraftingtablemenu" );
}

// Namespace ZMCraftingTableMenu
// Params 2
// Checksum 0x3786e0b9, Offset: 0xac
// Size: 0x1f
function open( player, flags )
{
    lui_elems::open_lui_elem( player, flags );
}

// Namespace ZMCraftingTableMenu
// Params 1
// Checksum 0xd3619c0f, Offset: 0xd3
// Size: 0x15
function close( player )
{
    lui_elems::close_lui_elem( player );
}

// Namespace ZMCraftingTableMenu
// Params 1
// Checksum 0xc33e8fce, Offset: 0xf0
// Size: 0x14
function is_open( player )
{
    return lui_elems::is_open_lui_elem( player );
}

