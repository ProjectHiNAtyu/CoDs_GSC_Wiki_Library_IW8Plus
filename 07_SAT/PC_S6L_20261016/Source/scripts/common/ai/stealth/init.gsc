// scripts\common\ai\stealth\init.gsc  (hash_3dd7bc356dbe2135.gscc) (size: 718 Bytes / 0x2ce / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc5ec433e (3320595262)
// size ...... 718 (0x2ce)
// includes .. 4   (offset: 0x2ae)
// strings ... 0   (offset: 0x2ce)
// dev strs .. 0   (offset: 0x2ce)
// exports ... 3   (offset: 0x18a)
// cseg ...... 0x58 + 0x132 (0x18a)
// imports ... 6   (offset: 0x202)
// animtree1 . 0   (offset: 0x2ce)
// animtree2 . 0   (offset: 0x2ce)
#using scripts\common\ai\stealth\manager;
#using scripts\common\ai\stealth\player;
#using scripts\common\ai\stealth\threat_sight;
#using scripts\common\ai\stealth\utility;

#namespace init;

// Namespace init
// Params 0
// Checksum 0x7197b334, Offset: 0x76
// Size: 0x9
function main()
{
    stealth_manager::main();
}

// Namespace init
// Params 3
// Checksum 0x98d9d58d, Offset: 0x87
// Size: 0x103
function set_stealth_mode( enabled, musichidden, musicspotted )
{
    if ( enabled )
    {
        if ( isdefined( musichidden ) && isdefined( musicspotted ) )
        {
            level thread utility::stealth_music( musichidden, musicspotted );
        }
        
        level thread threat_sight::threat_sight_set_enabled( 1 );
        
        foreach ( player in level.players )
        {
            player thread player::main();
        }
    }
    else
    {
        level thread utility::stealth_music_stop();
        level thread threat_sight::threat_sight_set_enabled( 0 );
    }
    
    if ( isdefined( level.stealth.fnsetstealthmode ) )
    {
        level thread [[ level.stealth.fnsetstealthmode ]]( enabled, musichidden, musicspotted );
    }
}

