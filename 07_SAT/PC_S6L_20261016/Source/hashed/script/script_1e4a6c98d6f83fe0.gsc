// script_1e4a6c98d6f83fe0  (hash_1e4a6c98d6f83fe0.gscc) (size: 1133 Bytes / 0x46d)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x88cdc4b1 (2295186609)
// size ...... 1133 (0x46d)
// includes .. 1   (offset: 0x459)
// strings ... 1   (offset: 0x461)
// dev strs .. 0   (offset: 0x46d)
// exports ... 11  (offset: 0x201)
// cseg ...... 0x6f + 0x192 (0x201)
// imports ... 5   (offset: 0x3b9)
// animtree1 . 0   (offset: 0x46d)
// animtree2 . 0   (offset: 0x46d)
#using script_63258e3c8c400b7a;

#namespace DyingWishLastChance;

// Namespace DyingWishLastChance
// Params 0
// Checksum 0x27bfb310, Offset: 0x8d
// Size: 0x16
function register()
{
    return lui_elems::register_lui_elem( "DyingWishLastChance", #"dyingwishlastchance" );
}

// Namespace DyingWishLastChance
// Params 2
// Checksum 0xd9b380a1, Offset: 0xac
// Size: 0x1f
function open( player, flags )
{
    lui_elems::open_lui_elem( player, flags );
}

// Namespace DyingWishLastChance
// Params 1
// Checksum 0x3d54fc17, Offset: 0xd3
// Size: 0x15
function close( player )
{
    lui_elems::close_lui_elem( player );
}

// Namespace DyingWishLastChance
// Params 1
// Checksum 0x2d0befd6, Offset: 0xf0
// Size: 0x14
function is_open( player )
{
    return lui_elems::is_open_lui_elem( player );
}

// Namespace DyingWishLastChance
// Params 2
// Checksum 0x80bfc938, Offset: 0x10d
// Size: 0x22
function function_86b9774ae7a14968( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 1, value );
}

// Namespace DyingWishLastChance
// Params 2
// Checksum 0x91830528, Offset: 0x137
// Size: 0x22
function function_2c729362688b0b38( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 2, value );
}

// Namespace DyingWishLastChance
// Params 2
// Checksum 0xdd263182, Offset: 0x161
// Size: 0x22
function function_4d07e9a9329fb1bf( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 3, value );
}

// Namespace DyingWishLastChance
// Params 2
// Checksum 0xcc1afd96, Offset: 0x18b
// Size: 0x22
function function_ed4c3f6e49331aef( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 4, value );
}

// Namespace DyingWishLastChance
// Params 2
// Checksum 0xd5494889, Offset: 0x1b5
// Size: 0x22
function function_cb231cb6c45dedc8( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 5, value );
}

// Namespace DyingWishLastChance
// Params 2
// Checksum 0x20ad099b, Offset: 0x1df
// Size: 0x22
function function_30b62bb66ae155a( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 6, value );
}

