// script_4519eff181e91bd3  (hash_4519eff181e91bd3.gscc) (size: 587 Bytes / 0x24b)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf2ddf1d9 (4074631641)
// size ...... 587 (0x24b)
// includes .. 1   (offset: 0x237)
// strings ... 1   (offset: 0x23f)
// dev strs .. 0   (offset: 0x24b)
// exports ... 5   (offset: 0xff)
// cseg ...... 0x69 + 0x96 (0xff)
// imports ... 4   (offset: 0x1c7)
// animtree1 . 0   (offset: 0x24b)
// animtree2 . 0   (offset: 0x24b)
#using script_63258e3c8c400b7a;

#namespace ZMArsenalMenu;

// Namespace ZMArsenalMenu
// Params 0
// Checksum 0x5541aa2f, Offset: 0x87
// Size: 0x16
function register()
{
    return lui_elems::register_lui_elem( "ZMArsenalMenu", #"zmarsenalmenu" );
}

// Namespace ZMArsenalMenu
// Params 2
// Checksum 0x8bb33c1d, Offset: 0xa6
// Size: 0x1f
function open( player, flags )
{
    lui_elems::open_lui_elem( player, flags );
}

// Namespace ZMArsenalMenu
// Params 1
// Checksum 0x6f5440ab, Offset: 0xcd
// Size: 0x15
function close( player )
{
    lui_elems::close_lui_elem( player );
}

// Namespace ZMArsenalMenu
// Params 1
// Checksum 0x7f0b536a, Offset: 0xea
// Size: 0x14
function is_open( player )
{
    return lui_elems::is_open_lui_elem( player );
}

