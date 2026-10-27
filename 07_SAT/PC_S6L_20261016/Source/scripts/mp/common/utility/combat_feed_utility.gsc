// scripts\mp\common\utility\combat_feed_utility.gsc  (hash_50d22460def5c889.gscc) (size: 660 Bytes / 0x294 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9136f265 (2436297317)
// size ...... 660 (0x294)
// includes .. 1   (offset: 0x28c)
// strings ... 0   (offset: 0x294)
// dev strs .. 0   (offset: 0x294)
// exports ... 5   (offset: 0x15c)
// cseg ...... 0x58 + 0x104 (0x15c)
// imports ... 3   (offset: 0x224)
// animtree1 . 0   (offset: 0x294)
// animtree2 . 0   (offset: 0x294)
#using scripts\common\omnvar_utility;

#namespace combat_feed_utility;

// Namespace combat_feed_utility
// Params 0
// Checksum 0x540271a2, Offset: 0x76
// Size: 0x2b, Type: bool
function function_47a6f06f6300fa18()
{
    if ( getdvarint( @"hash_9c2e4776e95c6490", 0 ) == 0 )
    {
        return false;
    }
    
    if ( function_9340dd398350d3d0( #"hash_7c1d2feb2d7e5c50" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace combat_feed_utility
// Params 0
// Checksum 0x2649e77d, Offset: 0xaa
// Size: 0x4
function function_3f12a36a6f8ea8d6()
{
    return 3;
}

// Namespace combat_feed_utility
// Params 2
// Checksum 0xdc12726c, Offset: 0xb7
// Size: 0x68
function function_c2c521865350303b( omnvar, params )
{
    omnvar_utility::function_85d5f88af471ac4b( omnvar, 0, 8, params.killcount ?? 0 );
    omnvar_utility::function_85d5f88af471ac4b( omnvar, 8, 8, params.totalevents ?? 0 );
    omnvar_utility::function_85d5f88af471ac4b( omnvar, 16, 16, params.totalpoints ?? 0 );
}

// Namespace combat_feed_utility
// Params 1
// Checksum 0x5fe19fc7, Offset: 0x127
// Size: 0x35
function function_6a97578cae661d84( omnvar )
{
    omnvar_utility::function_85d5f88af471ac4b( omnvar, 0, 8, 0 );
    omnvar_utility::function_85d5f88af471ac4b( omnvar, 8, 8, 0 );
    omnvar_utility::function_85d5f88af471ac4b( omnvar, 16, 16, 0 );
}

