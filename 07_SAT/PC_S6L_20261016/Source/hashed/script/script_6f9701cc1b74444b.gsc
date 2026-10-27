// script_6f9701cc1b74444b  (hash_6f9701cc1b74444b.gscc) (size: 1985 Bytes / 0x7c1)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4f77a708 (1333241608)
// size ...... 1985 (0x7c1)
// includes .. 1   (offset: 0x7ad)
// strings ... 1   (offset: 0x7b5)
// dev strs .. 0   (offset: 0x7c1)
// exports ... 21  (offset: 0x39d)
// cseg ...... 0x67 + 0x336 (0x39d)
// imports ... 5   (offset: 0x6e5)
// animtree1 . 0   (offset: 0x7c1)
// animtree2 . 0   (offset: 0x7c1)
#using script_63258e3c8c400b7a;

#namespace ZMSquadVote;

// Namespace ZMSquadVote
// Params 0
// Checksum 0x5360d0fa, Offset: 0x85
// Size: 0x16
function register()
{
    return lui_elems::register_lui_elem( "ZMSquadVote", #"zmsquadvote" );
}

// Namespace ZMSquadVote
// Params 2
// Checksum 0xe84853d2, Offset: 0xa4
// Size: 0x1f
function open( player, flags )
{
    lui_elems::open_lui_elem( player, flags );
}

// Namespace ZMSquadVote
// Params 1
// Checksum 0xcaf2f64, Offset: 0xcb
// Size: 0x15
function close( player )
{
    lui_elems::close_lui_elem( player );
}

// Namespace ZMSquadVote
// Params 1
// Checksum 0x1cf03ca5, Offset: 0xe8
// Size: 0x14
function is_open( player )
{
    return lui_elems::is_open_lui_elem( player );
}

// Namespace ZMSquadVote
// Params 2
// Checksum 0xd1ddd22b, Offset: 0x105
// Size: 0x22
function set_players_count( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 1, value );
}

// Namespace ZMSquadVote
// Params 2
// Checksum 0x1b7e5d40, Offset: 0x12f
// Size: 0x22
function set_initiator( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 2, value );
}

// Namespace ZMSquadVote
// Params 2
// Checksum 0x889c4498, Offset: 0x159
// Size: 0x22
function function_87fd87c10d3b04e( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 3, value );
}

// Namespace ZMSquadVote
// Params 2
// Checksum 0x8dfeca42, Offset: 0x183
// Size: 0x22
function set_is_player_initiator( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 4, value );
}

// Namespace ZMSquadVote
// Params 2
// Checksum 0x6990e8b8, Offset: 0x1ad
// Size: 0x22
function set_player_vote( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 5, value );
}

// Namespace ZMSquadVote
// Params 2
// Checksum 0xfc7e7dca, Offset: 0x1d7
// Size: 0x22
function set_description( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 6, value );
}

// Namespace ZMSquadVote
// Params 2
// Checksum 0x8e178ea4, Offset: 0x201
// Size: 0x22
function set_vote_result( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 7, value );
}

// Namespace ZMSquadVote
// Params 2
// Checksum 0xcc049047, Offset: 0x22b
// Size: 0x22
function set_header( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 8, value );
}

// Namespace ZMSquadVote
// Params 2
// Checksum 0xa06994c0, Offset: 0x255
// Size: 0x22
function function_9860ff088a9c5e61( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 9, value );
}

// Namespace ZMSquadVote
// Params 2
// Checksum 0x3960c579, Offset: 0x27f
// Size: 0x22
function function_9860fc088a9c57c8( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 10, value );
}

// Namespace ZMSquadVote
// Params 2
// Checksum 0xdd3714ae, Offset: 0x2a9
// Size: 0x22
function function_7407975770042e8c( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 11, value );
}

// Namespace ZMSquadVote
// Params 2
// Checksum 0x443e4513, Offset: 0x2d3
// Size: 0x22
function function_74079a5770043525( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 12, value );
}

// Namespace ZMSquadVote
// Params 2
// Checksum 0x6746f973, Offset: 0x2fd
// Size: 0x22
function function_557768b681cc68b( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 13, value );
}

// Namespace ZMSquadVote
// Params 2
// Checksum 0xfe4fa8ca, Offset: 0x327
// Size: 0x22
function function_557778b681cc8be( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 14, value );
}

// Namespace ZMSquadVote
// Params 2
// Checksum 0x5032f5c7, Offset: 0x351
// Size: 0x22
function function_e5d1cb4112ef9661( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 15, value );
}

// Namespace ZMSquadVote
// Params 2
// Checksum 0x1f009b36, Offset: 0x37b
// Size: 0x22
function function_a671d9bffaf75eda( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 16, value );
}

