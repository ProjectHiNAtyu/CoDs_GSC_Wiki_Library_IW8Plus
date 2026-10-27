// script_546a3d5aa2af7a0a  (hash_546a3d5aa2af7a0a.gscc) (size: 587 Bytes / 0x24b)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x39878844 (965183556)
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

#namespace minimapborder;

// Namespace minimapborder
// Params 0
// Checksum 0x6446be32, Offset: 0x87
// Size: 0x16
function register()
{
    return lui_elems::register_lui_elem( "MinimapBorder", #"minimapborder" );
}

// Namespace minimapborder
// Params 2
// Checksum 0x9bc2fba, Offset: 0xa6
// Size: 0x1f
function open( player, flags )
{
    lui_elems::open_lui_elem( player, flags );
}

// Namespace minimapborder
// Params 1
// Checksum 0xed5b530c, Offset: 0xcd
// Size: 0x15
function close( player )
{
    lui_elems::close_lui_elem( player );
}

// Namespace minimapborder
// Params 1
// Checksum 0xfd0440cd, Offset: 0xea
// Size: 0x14
function is_open( player )
{
    return lui_elems::is_open_lui_elem( player );
}

