// script_249fe651636adfba  (hash_249fe651636adfba.gscc) (size: 1298 Bytes / 0x512)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4d47d2 (5064658)
// size ...... 1298 (0x512)
// includes .. 1   (offset: 0x4fe)
// strings ... 1   (offset: 0x506)
// dev strs .. 0   (offset: 0x512)
// exports ... 13  (offset: 0x24e)
// cseg ...... 0x68 + 0x1e6 (0x24e)
// imports ... 5   (offset: 0x456)
// animtree1 . 0   (offset: 0x512)
// animtree2 . 0   (offset: 0x512)
#using script_63258e3c8c400b7a;

#namespace GriefStreaks;

// Namespace GriefStreaks
// Params 0
// Checksum 0xfef8590c, Offset: 0x86
// Size: 0x16
function register()
{
    return lui_elems::register_lui_elem( "GriefStreaks", #"griefstreaks" );
}

// Namespace GriefStreaks
// Params 2
// Checksum 0x816ebf51, Offset: 0xa5
// Size: 0x1f
function open( player, flags )
{
    lui_elems::open_lui_elem( player, flags );
}

// Namespace GriefStreaks
// Params 1
// Checksum 0x6589c3e7, Offset: 0xcc
// Size: 0x15
function close( player )
{
    lui_elems::close_lui_elem( player );
}

// Namespace GriefStreaks
// Params 1
// Checksum 0x75d6d026, Offset: 0xe9
// Size: 0x14
function is_open( player )
{
    return lui_elems::is_open_lui_elem( player );
}

// Namespace GriefStreaks
// Params 2
// Checksum 0x153590fb, Offset: 0x106
// Size: 0x22
function function_ad12487c6f7b580a( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 1, value );
}

// Namespace GriefStreaks
// Params 2
// Checksum 0x2c3f8732, Offset: 0x130
// Size: 0x22
function function_bc71440f21a5f493( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 2, value );
}

// Namespace GriefStreaks
// Params 2
// Checksum 0xc5c3e7bb, Offset: 0x15a
// Size: 0x22
function set_spawntime( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 3, value );
}

// Namespace GriefStreaks
// Params 2
// Checksum 0xa184ec77, Offset: 0x184
// Size: 0x22
function function_965a77d825ad7a13( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 4, value );
}

// Namespace GriefStreaks
// Params 2
// Checksum 0x20873fd, Offset: 0x1ae
// Size: 0x22
function function_747d1e669e667dcc( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 5, value );
}

// Namespace GriefStreaks
// Params 2
// Checksum 0xe9ba0785, Offset: 0x1d8
// Size: 0x22
function function_71979067d3d58d25( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 6, value );
}

// Namespace GriefStreaks
// Params 2
// Checksum 0x349fbfda, Offset: 0x202
// Size: 0x22
function function_49a619abfb4ae4b9( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 7, value );
}

// Namespace GriefStreaks
// Params 2
// Checksum 0xeb6f2da3, Offset: 0x22c
// Size: 0x22
function function_9a3d88c821ee723( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 8, value );
}

