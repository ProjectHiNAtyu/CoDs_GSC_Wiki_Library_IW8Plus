// script_42e64e08775e2164  (hash_42e64e08775e2164.gscc) (size: 795 Bytes / 0x31b)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7df0187 (132055431)
// size ...... 795 (0x31b)
// includes .. 1   (offset: 0x307)
// strings ... 1   (offset: 0x30f)
// dev strs .. 0   (offset: 0x31b)
// exports ... 7   (offset: 0x15f)
// cseg ...... 0x75 + 0xea (0x15f)
// imports ... 5   (offset: 0x277)
// animtree1 . 0   (offset: 0x31b)
// animtree2 . 0   (offset: 0x31b)
#using script_63258e3c8c400b7a;

#namespace ZMBoatRacingMainCountDown;

// Namespace ZMBoatRacingMainCountDown
// Params 0
// Checksum 0x9d38296e, Offset: 0x93
// Size: 0x16
function register()
{
    return lui_elems::register_lui_elem( "ZMBoatRacingMainCountDown", #"zmboatracingmaincountdown" );
}

// Namespace ZMBoatRacingMainCountDown
// Params 2
// Checksum 0x183dfd70, Offset: 0xb2
// Size: 0x1f
function open( player, flags )
{
    lui_elems::open_lui_elem( player, flags );
}

// Namespace ZMBoatRacingMainCountDown
// Params 1
// Checksum 0xfcda81c6, Offset: 0xd9
// Size: 0x15
function close( player )
{
    lui_elems::close_lui_elem( player );
}

// Namespace ZMBoatRacingMainCountDown
// Params 1
// Checksum 0xec859207, Offset: 0xf6
// Size: 0x14
function is_open( player )
{
    return lui_elems::is_open_lui_elem( player );
}

// Namespace ZMBoatRacingMainCountDown
// Params 2
// Checksum 0xf2c6b82a, Offset: 0x113
// Size: 0x22
function set_remain_time( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 1, value );
}

// Namespace ZMBoatRacingMainCountDown
// Params 2
// Checksum 0xdc349c93, Offset: 0x13d
// Size: 0x22
function set_countdown_description( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 2, value );
}

