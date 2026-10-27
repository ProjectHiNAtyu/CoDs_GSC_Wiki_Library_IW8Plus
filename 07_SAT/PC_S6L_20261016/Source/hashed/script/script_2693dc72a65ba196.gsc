// script_2693dc72a65ba196  (hash_2693dc72a65ba196.gscc) (size: 874 Bytes / 0x36a)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x91dbc260 (2447098464)
// size ...... 874 (0x36a)
// includes .. 1   (offset: 0x356)
// strings ... 1   (offset: 0x35e)
// dev strs .. 0   (offset: 0x36a)
// exports ... 8   (offset: 0x182)
// cseg ...... 0x6e + 0x114 (0x182)
// imports ... 5   (offset: 0x2c2)
// animtree1 . 0   (offset: 0x36a)
// animtree2 . 0   (offset: 0x36a)
#using script_63258e3c8c400b7a;

#namespace Interactionholding;

// Namespace Interactionholding
// Params 0
// Checksum 0xa475b847, Offset: 0x8c
// Size: 0x16
function register()
{
    return lui_elems::register_lui_elem( "Interactionholding", #"interactionholding" );
}

// Namespace Interactionholding
// Params 2
// Checksum 0x4b55c61c, Offset: 0xab
// Size: 0x1f
function open( player, flags )
{
    lui_elems::open_lui_elem( player, flags );
}

// Namespace Interactionholding
// Params 1
// Checksum 0xafb2baaa, Offset: 0xd2
// Size: 0x15
function close( player )
{
    lui_elems::close_lui_elem( player );
}

// Namespace Interactionholding
// Params 1
// Checksum 0xbfeda96b, Offset: 0xef
// Size: 0x14
function is_open( player )
{
    return lui_elems::is_open_lui_elem( player );
}

// Namespace Interactionholding
// Params 2
// Checksum 0x5f63e803, Offset: 0x10c
// Size: 0x22
function set_description( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 1, value );
}

// Namespace Interactionholding
// Params 2
// Checksum 0x6c0b4673, Offset: 0x136
// Size: 0x22
function set_progressfrac( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 2, value );
}

// Namespace Interactionholding
// Params 2
// Checksum 0xd4fe3750, Offset: 0x160
// Size: 0x22
function set_caption( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 3, value );
}

