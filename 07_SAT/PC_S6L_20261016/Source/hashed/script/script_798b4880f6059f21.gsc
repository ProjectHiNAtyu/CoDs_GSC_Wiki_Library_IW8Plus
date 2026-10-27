// script_798b4880f6059f21  (hash_798b4880f6059f21.gscc) (size: 1132 Bytes / 0x46c)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd74c980a (3612121098)
// size ...... 1132 (0x46c)
// includes .. 1   (offset: 0x458)
// strings ... 1   (offset: 0x460)
// dev strs .. 0   (offset: 0x46c)
// exports ... 11  (offset: 0x200)
// cseg ...... 0x6e + 0x192 (0x200)
// imports ... 5   (offset: 0x3b8)
// animtree1 . 0   (offset: 0x46c)
// animtree2 . 0   (offset: 0x46c)
#using script_63258e3c8c400b7a;

#namespace ZMBoatRacingMainUI;

// Namespace ZMBoatRacingMainUI
// Params 0
// Checksum 0xa37745ff, Offset: 0x8c
// Size: 0x16
function register()
{
    return lui_elems::register_lui_elem( "ZMBoatRacingMainUI", #"zmboatracingmainui" );
}

// Namespace ZMBoatRacingMainUI
// Params 2
// Checksum 0x3bb7b71d, Offset: 0xab
// Size: 0x1f
function open( player, flags )
{
    lui_elems::open_lui_elem( player, flags );
}

// Namespace ZMBoatRacingMainUI
// Params 1
// Checksum 0xdf50cbab, Offset: 0xd2
// Size: 0x15
function close( player )
{
    lui_elems::close_lui_elem( player );
}

// Namespace ZMBoatRacingMainUI
// Params 1
// Checksum 0xcf0fd86a, Offset: 0xef
// Size: 0x14
function is_open( player )
{
    return lui_elems::is_open_lui_elem( player );
}

// Namespace ZMBoatRacingMainUI
// Params 2
// Checksum 0xd14cf247, Offset: 0x10c
// Size: 0x22
function set_remain_time( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 1, value );
}

// Namespace ZMBoatRacingMainUI
// Params 2
// Checksum 0x73a422e5, Offset: 0x136
// Size: 0x22
function set_score( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 2, value );
}

// Namespace ZMBoatRacingMainUI
// Params 2
// Checksum 0xf13ede90, Offset: 0x160
// Size: 0x22
function function_91b602a84036d09f( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 3, value );
}

// Namespace ZMBoatRacingMainUI
// Params 2
// Checksum 0xc872e3b8, Offset: 0x18a
// Size: 0x22
function set_rank( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 4, value );
}

// Namespace ZMBoatRacingMainUI
// Params 2
// Checksum 0x48811f05, Offset: 0x1b4
// Size: 0x22
function set_total_player( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 5, value );
}

// Namespace ZMBoatRacingMainUI
// Params 2
// Checksum 0x877bcf91, Offset: 0x1de
// Size: 0x22
function function_d4e665cb192670c4( player, value )
{
    lui_elems::function_dccebe4829a93560( player, 6, value );
}

