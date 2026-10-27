// scripts\mp\br_window_alarm.gsc  (hash_1584d072dd426127.gscc) (size: 1911 Bytes / 0x777 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf875906f (4168454255)
// size ...... 1911 (0x777)
// includes .. 3   (offset: 0x6b3)
// strings ... 12  (offset: 0x6cb)
// dev strs .. 2   (offset: 0x75f)
// exports ... 4   (offset: 0x49f)
// cseg ...... 0x115 + 0x38a (0x49f)
// imports ... 13  (offset: 0x53f)
// animtree1 . 0   (offset: 0x777)
// animtree2 . 0   (offset: 0x777)
#using scripts\common\ai\stealth\event;
#using scripts\common\utility;
#using scripts\mp\flags;

#namespace br_window_alarm;

// Namespace br_window_alarm
// Params 0
// Checksum 0xdbe19cc2, Offset: 0x133
// Size: 0x1d
function init()
{
    if ( !getdvarint( @"scr_br_window_alarm_enabled", 1 ) )
    {
        return;
    }
    
    thread function_c8311d7edf14de1e();
}

// Namespace br_window_alarm
// Params 0
// Checksum 0x70010452, Offset: 0x158
// Size: 0x15c
function function_c8311d7edf14de1e()
{
    level endon( #"game_ended" );
    level.alarmwindows = utility::getstructarray( "alarmmanager", "script_noteworthy" );
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    wait 1;
    
    foreach ( alarm in level.alarmwindows )
    {
        alarm.active = 0;
        alarm.glass = getglass( alarm.target );
        stickers = getentitylessscriptablearray( alarm.target, #targetname );
        
        if ( stickers.size > 0 )
        {
            assert( stickers.size == 1, "<dev string:x24>" + alarm.origin + "<dev string:x37>" );
            alarm.sticker = stickers[ 0 ];
            
            if ( isdefined( alarm.sticker ) )
            {
                alarm.sticker setscriptablepartstate( "base", "visible" );
            }
        }
    }
    
    thread windowwatcher();
}

// Namespace br_window_alarm
// Params 0
// Checksum 0xa6c12a1d, Offset: 0x2bc
// Size: 0x1e3
function windowwatcher()
{
    level endon( #"game_ended" );
    
    if ( !isdefined( level.var_1b7719e8fe46996d ) )
    {
        level.var_1b7719e8fe46996d = spawn( "script_origin", ( 0, 0, 0 ) );
    }
    
    while ( true )
    {
        level waittill( #"glass_destroyed", glassid );
        
        foreach ( alarm in level.alarmwindows )
        {
            if ( alarm.glass == glassid )
            {
                if ( isdefined( alarm.sticker ) )
                {
                    alarm.sticker setscriptablepartstate( "base", "destroyed" );
                    level.var_1b7719e8fe46996d.orgin = alarm.sticker.origin;
                    event::event_broadcast_generic( "cover_blown", alarm.sticker.origin, 2500, level.var_1b7719e8fe46996d );
                    level.var_1b7719e8fe46996d.orgin = ( 0, 0, 0 );
                }
                
                if ( !alarm.active )
                {
                    dlog_recordevent( "dlog_event_br_window_alarm", [ "window_x", alarm.origin[ 0 ], "window_y", alarm.origin[ 1 ], "window_z", alarm.origin[ 2 ] ] );
                }
            }
        }
    }
}

