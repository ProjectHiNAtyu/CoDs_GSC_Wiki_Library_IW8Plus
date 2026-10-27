// scripts\mp\vehicles\vehicle_compass_mp.gsc  (hash_631f011549331c7b.gscc) (size: 369 Bytes / 0x171 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9a1b5587 (2585482631)
// size ...... 369 (0x171)
// includes .. 3   (offset: 0x159)
// strings ... 0   (offset: 0x171)
// dev strs .. 0   (offset: 0x171)
// exports ... 2   (offset: 0x99)
// cseg ...... 0x58 + 0x41 (0x99)
// imports ... 4   (offset: 0xe9)
// animtree1 . 0   (offset: 0x171)
// animtree2 . 0   (offset: 0x171)
#using scripts\common\callbacks;
#using scripts\common\vehicle_compass;
#using scripts\mp\common\utility\join_team_aggregator;

#namespace vehicle_compass_mp;

// Namespace vehicle_compass_mp
// Params 0
// Checksum 0xf7ba3889, Offset: 0x76
// Size: 0x23
function vehicle_compass_mp_init()
{
    callback::add( #"player_spawned", &vehicle_compass::player_spawned_callback );
    join_team_aggregator::registeronplayerjointeamnospectatorcallback( &vehicle_compass::player_joined_team_callback );
}

