// script_60ecf0e6d7ee7771  (hash_60ecf0e6d7ee7771.gscc) (size: 710 Bytes / 0x2c6)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x23c9626a (600400490)
// size ...... 710 (0x2c6)
// includes .. 1   (offset: 0x2b2)
// strings ... 1   (offset: 0x2ba)
// dev strs .. 0   (offset: 0x2c6)
// exports ... 6   (offset: 0x136)
// cseg ...... 0x76 + 0xc0 (0x136)
// imports ... 5   (offset: 0x226)
// animtree1 . 0   (offset: 0x2c6)
// animtree2 . 0   (offset: 0x2c6)
#using script_63258e3c8c400b7a;

#namespace ZMBoatRacingStartCountDown;

// Namespace ZMBoatRacingStartCountDown
// Params 0
// Checksum 0x48a4fe41, Offset: 0x94
// Size: 0x16
function register()
{
    return lui_elems::register_lui_elem( "ZMBoatRacingStartCountDown", #"zmboatracingstartcountdown" );
}

// Namespace ZMBoatRacingStartCountDown
// Params 2
// Checksum 0x5135e16d, Offset: 0xb3
// Size: 0x1f
function open( player, flags )
{
    lui_elems::open_lui_elem( player, flags );
}

// Namespace ZMBoatRacingStartCountDown
// Params 1
// Checksum 0xb5d29ddb, Offset: 0xda
// Size: 0x15
function close( player )
{
    lui_elems::close_lui_elem( player );
}

// Namespace ZMBoatRacingStartCountDown
// Params 1
// Checksum 0xa58d8e1a, Offset: 0xf7
// Size: 0x14
function is_open( player )
{
    return lui_elems::is_open_lui_elem( player );
}

// Namespace ZMBoatRacingStartCountDown
// Params 2
// Checksum 0xbbcea437, Offset: 0x114
// Size: 0x22
function set_remain_time( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 1, value );
}

