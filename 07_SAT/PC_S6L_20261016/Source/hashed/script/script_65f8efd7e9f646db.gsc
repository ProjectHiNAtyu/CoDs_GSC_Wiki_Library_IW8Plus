// script_65f8efd7e9f646db  (hash_65f8efd7e9f646db.gscc) (size: 784 Bytes / 0x310)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5f445cd3 (1598315731)
// size ...... 784 (0x310)
// includes .. 1   (offset: 0x2fc)
// strings ... 1   (offset: 0x304)
// dev strs .. 0   (offset: 0x310)
// exports ... 7   (offset: 0x154)
// cseg ...... 0x6a + 0xea (0x154)
// imports ... 5   (offset: 0x26c)
// animtree1 . 0   (offset: 0x310)
// animtree2 . 0   (offset: 0x310)
#using script_63258e3c8c400b7a;

#namespace Descriptionhud;

// Namespace Descriptionhud
// Params 0
// Checksum 0x6ea98e6e, Offset: 0x88
// Size: 0x16
function register()
{
    return lui_elems::register_lui_elem( "Descriptionhud", #"descriptionhud" );
}

// Namespace Descriptionhud
// Params 2
// Checksum 0x7d01ca60, Offset: 0xa7
// Size: 0x1f
function open( player, flags )
{
    lui_elems::open_lui_elem( player, flags );
}

// Namespace Descriptionhud
// Params 1
// Checksum 0x99e6b6d6, Offset: 0xce
// Size: 0x15
function close( player )
{
    lui_elems::close_lui_elem( player );
}

// Namespace Descriptionhud
// Params 1
// Checksum 0x89b9a517, Offset: 0xeb
// Size: 0x14
function is_open( player )
{
    return lui_elems::is_open_lui_elem( player );
}

// Namespace Descriptionhud
// Params 2
// Checksum 0x6937e47f, Offset: 0x108
// Size: 0x22
function set_description( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 1, value );
}

// Namespace Descriptionhud
// Params 2
// Checksum 0x40a8368a, Offset: 0x132
// Size: 0x22
function set_endtime( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 2, value );
}

