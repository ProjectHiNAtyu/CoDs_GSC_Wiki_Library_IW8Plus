// script_69155f453844a88c  (hash_69155f453844a88c.gscc) (size: 954 Bytes / 0x3ba / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xecdc99c4 (3973880260)
// size ...... 954 (0x3ba)
// includes .. 4   (offset: 0x372)
// strings ... 3   (offset: 0x392)
// dev strs .. 0   (offset: 0x3ba)
// exports ... 6   (offset: 0x186)
// cseg ...... 0x82 + 0x104 (0x186)
// imports ... 9   (offset: 0x276)
// animtree1 . 0   (offset: 0x3ba)
// animtree2 . 0   (offset: 0x3ba)
#using script_aa3bac81ad4fc8e;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\musicbank_utility;

#namespace zm_bgb_slaylist;

// Namespace zm_bgb_slaylist
// Params 0, eflags: 0x5
// Checksum 0xe03c5038, Offset: 0xa0
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "slaylist", #"bgb", &__init__, undefined );
}

// Namespace zm_bgb_slaylist
// Params 0
// Checksum 0x8f2c3127, Offset: 0xc5
// Size: 0x21
function __init__()
{
    bgb::register( "slaylist", "activated", 1, undefined, undefined, &validation, &activation );
}

// Namespace zm_bgb_slaylist
// Params 0
// Checksum 0x910d2ec9, Offset: 0xee
// Size: 0x39
function activation()
{
    playlist = function_710ebc0d0721c7ea();
    random_track = utility::array_random( playlist );
    level musicbank_utility::function_5aca66c390aa347d( level.players, random_track );
}

// Namespace zm_bgb_slaylist
// Params 0
// Checksum 0x7ecf8a20, Offset: 0x12f
// Size: 0x4, Type: bool
function validation()
{
    return true;
}

// Namespace zm_bgb_slaylist
// Params 0
// Checksum 0xe115ed6, Offset: 0x13c
// Size: 0x49
function function_710ebc0d0721c7ea()
{
    track_num = 23;
    array = [];
    
    for ( i = 0; i < track_num ; i++ )
    {
        array[ i ] = getxhash( "bgb_slaylist_" + i + 1 );
    }
    
    return array;
}

