// scripts\mp\agents\nearby_player_scaling.gsc  (hash_3b2bc94f89bfce04.gscc) (size: 937 Bytes / 0x3a9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x35949803 (898930691)
// size ...... 937 (0x3a9)
// includes .. 2   (offset: 0x381)
// strings ... 1   (offset: 0x391)
// dev strs .. 1   (offset: 0x39d)
// exports ... 3   (offset: 0x225)
// cseg ...... 0x7e + 0x1a7 (0x225)
// imports ... 8   (offset: 0x29d)
// animtree1 . 0   (offset: 0x3a9)
// animtree2 . 0   (offset: 0x3a9)
#using scripts\common\throttle;
#using scripts\mp\common\utility\player;

#namespace nearby_player_scaling;

// Namespace nearby_player_scaling
// Params 0
// Checksum 0x516a534e, Offset: 0x9c
// Size: 0x29
function init_nearby_player_scaling()
{
    assert( self.aisettings.var_d1a3cff26e5fd54a, "<dev string:x24>" );
    thread track_nearby_players();
}

// Namespace nearby_player_scaling
// Params 0
// Checksum 0x9680a3f9, Offset: 0xcd
// Size: 0x158
function track_nearby_players()
{
    self endon( #"death" );
    
    if ( !isdefined( level.search_for_nearby_players_throttle ) )
    {
        level.search_for_nearby_players_throttle = throttle::throttle_initialize( "search_for_nearby_players_throttle", 1, 0.5 );
    }
    
    while ( true )
    {
        throttle::throttle_wait_in_queue( level.search_for_nearby_players_throttle, self );
        self.nearbyplayers = getplayersinradius( self.origin, self.var_a9921441cd6db952 );
        var_619ddb65b66555b = self.nearbyplayers.size - 1;
        var_72c66249ccc63a24 = -1;
        
        foreach ( nearbyplayer in self.nearbyplayers )
        {
            if ( !player::isinlaststand( nearbyplayer ) )
            {
                var_72c66249ccc63a24++;
            }
        }
        
        self._blackboard.var_606bf8ea1f70975d = abs( var_619ddb65b66555b * self.var_b102d7d6e24e96d );
        self._blackboard.var_7963b0f3595635be = abs( var_72c66249ccc63a24 * self.var_b102d7d6e24e96d );
        waitframe();
    }
}

