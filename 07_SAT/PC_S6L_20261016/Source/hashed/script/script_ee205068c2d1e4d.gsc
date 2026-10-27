// script_ee205068c2d1e4d  (hash_0ee205068c2d1e4d.gscc) (size: 704 Bytes / 0x2c0)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1bfbc077 (469483639)
// size ...... 704 (0x2c0)
// includes .. 1   (offset: 0x2ac)
// strings ... 1   (offset: 0x2b4)
// dev strs .. 0   (offset: 0x2c0)
// exports ... 6   (offset: 0x130)
// cseg ...... 0x70 + 0xc0 (0x130)
// imports ... 5   (offset: 0x220)
// animtree1 . 0   (offset: 0x2c0)
// animtree2 . 0   (offset: 0x2c0)
#using script_63258e3c8c400b7a;

#namespace Objectivecompletehud;

// Namespace Objectivecompletehud
// Params 0
// Checksum 0xb8732f02, Offset: 0x8e
// Size: 0x16
function register()
{
    return lui_elems::register_lui_elem( "Objectivecompletehud", #"objectivecompletehud" );
}

// Namespace Objectivecompletehud
// Params 2
// Checksum 0x2072ecaa, Offset: 0xad
// Size: 0x1f
function open( player, flags )
{
    lui_elems::open_lui_elem( player, flags );
}

// Namespace Objectivecompletehud
// Params 1
// Checksum 0xc495901c, Offset: 0xd4
// Size: 0x15
function close( player )
{
    lui_elems::close_lui_elem( player );
}

// Namespace Objectivecompletehud
// Params 1
// Checksum 0xd4ca83dd, Offset: 0xf1
// Size: 0x14
function is_open( player )
{
    return lui_elems::is_open_lui_elem( player );
}

// Namespace Objectivecompletehud
// Params 2
// Checksum 0x7759944c, Offset: 0x10e
// Size: 0x22
function function_1faee175fc3e0f1e( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 1, value );
}

