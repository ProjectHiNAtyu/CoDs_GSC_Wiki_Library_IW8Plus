// scripts\mp\common\killstreaks\helper_drone_mp.gsc  (hash_7a6466d8e30fbe67.gscc) (size: 710 Bytes / 0x2c6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf096c82e (4036413486)
// size ...... 710 (0x2c6)
// includes .. 5   (offset: 0x292)
// strings ... 1   (offset: 0x2ba)
// dev strs .. 0   (offset: 0x2c6)
// exports ... 4   (offset: 0x112)
// cseg ...... 0x71 + 0xa1 (0x112)
// imports ... 8   (offset: 0x1b2)
// animtree1 . 0   (offset: 0x2c6)
// animtree2 . 0   (offset: 0x2c6)
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\assault_drone_mp;
#using scripts\mp\common\killstreaks\helper_drone;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\join_team_aggregator;

#namespace helper_drone_mp;

// Namespace helper_drone_mp
// Params 0
// Checksum 0x7f346cf5, Offset: 0x8f
// Size: 0x44
function helper_drone_init()
{
    assault_drone_mp::assaultdrone_init();
    killstreaks::registerkillstreak( "radar_drone_overwatch", &helper_drone::tryusehelperdronefromstruct );
    join_team_aggregator::registeronplayerjointeamcallback( &helperdrone_updateheadicononjointeam );
    utility::registersharedfunc( #"helper_drone", #"attachxrays", &helperdrone_attachxrays );
}

// Namespace helper_drone_mp
// Params 1
// Checksum 0xdf2d69e2, Offset: 0xdb
// Size: 0xc
function helperdrone_updateheadicononjointeam( player )
{
    
}

// Namespace helper_drone_mp
// Params 1
// Checksum 0xe45d2da9, Offset: 0xef
// Size: 0x22
function helperdrone_attachxrays( helperdrone )
{
    helperdrone setentityhudoutlinedata( 3, helperdrone.team );
    return helperdrone;
}

