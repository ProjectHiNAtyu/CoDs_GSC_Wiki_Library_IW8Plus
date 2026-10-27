// script_27b3537ee86e1b76  (hash_27b3537ee86e1b76.gscc) (size: 1041 Bytes / 0x411)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfb7b3ee6 (4219158246)
// size ...... 1041 (0x411)
// includes .. 1   (offset: 0x3fd)
// strings ... 1   (offset: 0x405)
// dev strs .. 0   (offset: 0x411)
// exports ... 10  (offset: 0x1d1)
// cseg ...... 0x69 + 0x168 (0x1d1)
// imports ... 5   (offset: 0x361)
// animtree1 . 0   (offset: 0x411)
// animtree2 . 0   (offset: 0x411)
#using script_63258e3c8c400b7a;

#namespace AethericBoost;

// Namespace AethericBoost
// Params 0
// Checksum 0xe99f9983, Offset: 0x87
// Size: 0x16
function register()
{
    return lui_elems::register_lui_elem( "AethericBoost", #"aethericboost" );
}

// Namespace AethericBoost
// Params 2
// Checksum 0x2fa6a097, Offset: 0xa6
// Size: 0x1f
function open( player, flags )
{
    lui_elems::open_lui_elem( player, flags );
}

// Namespace AethericBoost
// Params 1
// Checksum 0xcb41dc21, Offset: 0xcd
// Size: 0x15
function close( player )
{
    lui_elems::close_lui_elem( player );
}

// Namespace AethericBoost
// Params 1
// Checksum 0xdb1ecfe0, Offset: 0xea
// Size: 0x14
function is_open( player )
{
    return lui_elems::is_open_lui_elem( player );
}

// Namespace AethericBoost
// Params 2
// Checksum 0xb80c67c0, Offset: 0x107
// Size: 0x22
function set_fillbar( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 1, value );
}

// Namespace AethericBoost
// Params 2
// Checksum 0xd2c2528d, Offset: 0x131
// Size: 0x22
function set_splash_visible( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 2, value );
}

// Namespace AethericBoost
// Params 2
// Checksum 0x1a9d07e7, Offset: 0x15b
// Size: 0x22
function set_description_visible( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 3, value );
}

// Namespace AethericBoost
// Params 2
// Checksum 0xb03bf7b4, Offset: 0x185
// Size: 0x22
function set_current_level( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 4, value );
}

// Namespace AethericBoost
// Params 2
// Checksum 0x73debab6, Offset: 0x1af
// Size: 0x22
function set_upgrade_desc( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 5, value );
}

