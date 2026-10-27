// scripts\mp\gestures_mp.gsc  (hash_6a8018994ebc5564.gscc) (size: 327 Bytes / 0x147 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x470eb47c (1192146044)
// size ...... 327 (0x147)
// includes .. 3   (offset: 0x12f)
// strings ... 0   (offset: 0x147)
// dev strs .. 0   (offset: 0x147)
// exports ... 2   (offset: 0x8b)
// cseg ...... 0x58 + 0x33 (0x8b)
// imports ... 3   (offset: 0xdb)
// animtree1 . 0   (offset: 0x147)
// animtree2 . 0   (offset: 0x147)
#using scripts\common\notetrack;
#using scripts\mp\common\utility\lui_game_event_aggregator;
#using scripts\mp\gestures;

#namespace gestures_mp;

// Namespace gestures_mp
// Params 0
// Checksum 0xb1fbe118, Offset: 0x76
// Size: 0x15
function init_mp()
{
    lui_game_event_aggregator::registeronluieventcallback( &gestures::watchradialgestureactivation );
    notetrack::function_b25e047f92f346cb();
}

