// script_23d29b4b9cdef522  (hash_23d29b4b9cdef522.gscc) (size: 597 Bytes / 0x255)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf4d489ce (4107569614)
// size ...... 597 (0x255)
// includes .. 1   (offset: 0x241)
// strings ... 1   (offset: 0x249)
// dev strs .. 0   (offset: 0x255)
// exports ... 5   (offset: 0x109)
// cseg ...... 0x73 + 0x96 (0x109)
// imports ... 4   (offset: 0x1d1)
// animtree1 . 0   (offset: 0x255)
// animtree2 . 0   (offset: 0x255)
#using script_63258e3c8c400b7a;

#namespace augmentselectionluielem;

// Namespace augmentselectionluielem
// Params 0
// Checksum 0x176dfb9, Offset: 0x91
// Size: 0x16
function register()
{
    return lui_elems::register_lui_elem( "augmentSelectionLuielem", #"augmentselectionluielem" );
}

// Namespace augmentselectionluielem
// Params 2
// Checksum 0xd4ac25db, Offset: 0xb0
// Size: 0x1f
function open( player, flags )
{
    lui_elems::open_lui_elem( player, flags );
}

// Namespace augmentselectionluielem
// Params 1
// Checksum 0x304b596d, Offset: 0xd7
// Size: 0x15
function close( player )
{
    lui_elems::close_lui_elem( player );
}

// Namespace augmentselectionluielem
// Params 1
// Checksum 0x20144aac, Offset: 0xf4
// Size: 0x14
function is_open( player )
{
    return lui_elems::is_open_lui_elem( player );
}

