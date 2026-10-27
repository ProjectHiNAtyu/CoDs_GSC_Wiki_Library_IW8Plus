// scripts\mp\compass_ping.gsc  (hash_50a639638e0e98f7.gscc) (size: 477 Bytes / 0x1dd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf696bdf1 (4137074161)
// size ...... 477 (0x1dd)
// includes .. 1   (offset: 0x1d5)
// strings ... 0   (offset: 0x1dd)
// dev strs .. 0   (offset: 0x1dd)
// exports ... 2   (offset: 0x12d)
// cseg ...... 0x58 + 0xd5 (0x12d)
// imports ... 3   (offset: 0x17d)
// animtree1 . 0   (offset: 0x1dd)
// animtree2 . 0   (offset: 0x1dd)
#using scripts\common\utility;

#namespace compass_ping;

// Namespace compass_ping
// Params 3
// Checksum 0x891908f9, Offset: 0x76
// Size: 0xb7
function ping( visibility_radius = 1200, visibility_height = 500, duration_ms = 1000 )
{
    player = self;
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    teams_nearby = utility::function_d6c8833c6628c415( player.origin, visibility_radius, visibility_height, 0, player );
    
    if ( teams_nearby.size <= 0 )
    {
        return;
    }
    
    player function_7b4f73a93178f87d( 6, teams_nearby, player, 1 );
    waitframe();
    player function_71c7c5be98d11198( teams_nearby, duration_ms, 1 );
    player function_7b4f73a93178f87d( 6, teams_nearby, player, 0 );
}

