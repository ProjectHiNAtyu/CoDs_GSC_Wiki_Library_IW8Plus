// scripts\mp\telemetry_coop.gsc  (hash_0cd391879f999cb7.gscc) (size: 1686 Bytes / 0x696 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4ffcf830 (1341978672)
// size ...... 1686 (0x696)
// includes .. 1   (offset: 0x5ae)
// strings ... 17  (offset: 0x5b6)
// dev strs .. 0   (offset: 0x696)
// exports ... 5   (offset: 0x402)
// cseg ...... 0x17f + 0x283 (0x402)
// imports ... 8   (offset: 0x4ca)
// animtree1 . 0   (offset: 0x696)
// animtree2 . 0   (offset: 0x696)
#using scripts\common\telemetry_utils;

#namespace telemetry_coop;

// Namespace telemetry_coop
// Params 0
// Checksum 0x3d481977, Offset: 0x19d
// Size: 0x13
function init()
{
    telemetry_utils::function_5995f9c2ef729dbd( "callback_coop_player_oob_teleport", &function_3cca523630def532 );
}

// Namespace telemetry_coop
// Params 0
// Checksum 0xd9e41934, Offset: 0x1b8
// Size: 0x72
function function_48065623105118c3()
{
    assert( isplayer( self ) );
    telemetry_data = { #player_z:self.origin[ 2 ], #player_y:self.origin[ 1 ], #player_x:self.origin[ 0 ], #player:self };
    telemetry_utils::function_af2d366f9522f76f( "callback_coop_player_oob_teleport", telemetry_data );
}

// Namespace telemetry_coop
// Params 1
// Checksum 0x9a00f78c, Offset: 0x232
// Size: 0x138
function player_death_event( type )
{
    if ( isplayer( self ) )
    {
        var_6cc17c32c1d9442b = self.lastattacker.subclass ?? "unknown";
        regiondifficulty = "difficulty_easy";
        
        if ( isfunction( level.var_bb131187d6741752 ) )
        {
            regiondifficulty = [[ level.var_bb131187d6741752 ]]( self.origin );
        }
        
        self dlog_recordplayerevent( "dlog_event_ob_player_death", [ "was_knocked", type == "was_knocked", "was_killed", type == "was_killed", "was_revived", type == "was_revived", "was_wiped", type == "was_wiped", "location_x", self.origin[ 0 ], "location_y", self.origin[ 1 ], "location_z", self.origin[ 2 ], "difficulty", regiondifficulty, "attacker", var_6cc17c32c1d9442b ] );
    }
}

// Namespace telemetry_coop
// Params 1
// Checksum 0xdb5fb327, Offset: 0x372
// Size: 0x90
function function_3cca523630def532( data )
{
    player_x = data.player_x;
    player_y = data.player_y;
    player_z = data.player_z;
    data.player dlog_recordplayerevent( "dlog_event_sat_ob_sm_oob_teleport", [ "player_x", player_x, "player_y", player_y, "player_z", player_z ] );
}

