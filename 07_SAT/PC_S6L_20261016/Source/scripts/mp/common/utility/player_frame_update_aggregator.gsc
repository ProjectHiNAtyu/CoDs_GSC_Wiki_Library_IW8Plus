// scripts\mp\common\utility\player_frame_update_aggregator.gsc  (hash_7dfe0b190edeca84.gscc) (size: 858 Bytes / 0x35a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x712f853e (1898939710)
// size ...... 858 (0x35a)
// includes .. 1   (offset: 0x32e)
// strings ... 1   (offset: 0x336)
// dev strs .. 2   (offset: 0x342)
// exports ... 4   (offset: 0x21a)
// cseg ...... 0x69 + 0x1b1 (0x21a)
// imports ... 4   (offset: 0x2ba)
// animtree1 . 0   (offset: 0x35a)
// animtree2 . 0   (offset: 0x35a)
#using scripts\mp\flags;

#namespace player_frame_update_aggregator;

// Namespace player_frame_update_aggregator
// Params 0
// Checksum 0x86296319, Offset: 0x87
// Size: 0x14
function init()
{
    level.playerframeupdatecallbacks = [];
    level thread runupdates();
}

// Namespace player_frame_update_aggregator
// Params 0
// Checksum 0xa2f803ab, Offset: 0xa3
// Size: 0x121
function runupdates()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    
    if ( level.playerframeupdatecallbacks.size == 0 )
    {
        level.playerframeupdatecallbacks = undefined;
        return;
    }
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            foreach ( callback in level.playerframeupdatecallbacks )
            {
                player [[ callback ]]();
            }
        }
        
        waitframe();
    }
}

// Namespace player_frame_update_aggregator
// Params 1
// Checksum 0xb6702c73, Offset: 0x1cc
// Size: 0x4e
function registerplayerframeupdatecallback( callback )
{
    assert( !game[ "<dev string:x24>" ], "<dev string:x30>" );
    
    if ( !isdefined( level.playerframeupdatecallbacks ) )
    {
        level.playerframeupdatecallbacks = [];
    }
    
    level.playerframeupdatecallbacks[ level.playerframeupdatecallbacks.size ] = callback;
}

