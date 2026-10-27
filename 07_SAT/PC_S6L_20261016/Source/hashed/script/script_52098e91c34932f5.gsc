// script_52098e91c34932f5  (hash_52098e91c34932f5.gscc) (size: 1381 Bytes / 0x565)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x30918365 (814842725)
// size ...... 1381 (0x565)
// includes .. 1   (offset: 0x551)
// strings ... 1   (offset: 0x559)
// dev strs .. 0   (offset: 0x565)
// exports ... 14  (offset: 0x275)
// cseg ...... 0x65 + 0x210 (0x275)
// imports ... 5   (offset: 0x4a5)
// animtree1 . 0   (offset: 0x565)
// animtree2 . 0   (offset: 0x565)
#using script_63258e3c8c400b7a;

#namespace SquadVote;

// Namespace SquadVote
// Params 0
// Checksum 0xd8d69b28, Offset: 0x83
// Size: 0x16
function register()
{
    return lui_elems::register_lui_elem( "SquadVote", #"squadvote" );
}

// Namespace SquadVote
// Params 2
// Checksum 0xbd556475, Offset: 0xa2
// Size: 0x1f
function open( player, flags )
{
    lui_elems::open_lui_elem( player, flags );
}

// Namespace SquadVote
// Params 1
// Checksum 0x59b218c3, Offset: 0xc9
// Size: 0x15
function close( player )
{
    lui_elems::close_lui_elem( player );
}

// Namespace SquadVote
// Params 1
// Checksum 0x49ed0b02, Offset: 0xe6
// Size: 0x14
function is_open( player )
{
    return lui_elems::is_open_lui_elem( player );
}

// Namespace SquadVote
// Params 2
// Checksum 0x65eea0af, Offset: 0x103
// Size: 0x22
function set_players_needed( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 1, value );
}

// Namespace SquadVote
// Params 2
// Checksum 0x4e636ae7, Offset: 0x12d
// Size: 0x22
function set_initiator( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 2, value );
}

// Namespace SquadVote
// Params 2
// Checksum 0xdd81733f, Offset: 0x157
// Size: 0x22
function function_87fd87c10d3b04e( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 3, value );
}

// Namespace SquadVote
// Params 2
// Checksum 0xd8e3fde5, Offset: 0x181
// Size: 0x22
function set_is_player_initiator( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 4, value );
}

// Namespace SquadVote
// Params 2
// Checksum 0x3c8ddf1f, Offset: 0x1ab
// Size: 0x22
function set_player_vote( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 5, value );
}

// Namespace SquadVote
// Params 2
// Checksum 0xa9634a6d, Offset: 0x1d5
// Size: 0x22
function set_description( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 6, value );
}

// Namespace SquadVote
// Params 2
// Checksum 0xdb0ab903, Offset: 0x1ff
// Size: 0x22
function set_vote_result( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 7, value );
}

// Namespace SquadVote
// Params 2
// Checksum 0xa97d407c, Offset: 0x229
// Size: 0x22
function function_24bc47a077976162( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 8, value );
}

// Namespace SquadVote
// Params 2
// Checksum 0x9919a7e1, Offset: 0x253
// Size: 0x22
function set_header( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 9, value );
}

