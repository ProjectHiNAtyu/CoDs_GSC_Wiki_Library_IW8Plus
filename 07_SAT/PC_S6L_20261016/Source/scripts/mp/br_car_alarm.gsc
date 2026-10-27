// scripts\mp\br_car_alarm.gsc  (hash_3c24a56641a03789.gscc) (size: 744 Bytes / 0x2e8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcb594bea (3411626986)
// size ...... 744 (0x2e8)
// includes .. 1   (offset: 0x2b0)
// strings ... 4   (offset: 0x2b8)
// dev strs .. 0   (offset: 0x2e8)
// exports ... 3   (offset: 0x190)
// cseg ...... 0x94 + 0xfc (0x190)
// imports ... 6   (offset: 0x208)
// animtree1 . 0   (offset: 0x2e8)
// animtree2 . 0   (offset: 0x2e8)
#using scripts\common\utility;

#namespace br_car_alarm;

// Namespace br_car_alarm
// Params 0
// Checksum 0xd8a4f82d, Offset: 0xb2
// Size: 0x1c
function init()
{
    if ( !getdvarint( @"hash_8bfdc77e20414f2a", 0 ) )
    {
        return;
    }
    
    thread initalarms();
}

// Namespace br_car_alarm
// Params 0
// Checksum 0xf833a86b, Offset: 0xd6
// Size: 0xba
function initalarms()
{
    utility::flag_wait( "scriptables_ready" );
    caralarms = getentitylessscriptablearray( "scriptablecaralarm", #script_noteworthy );
    
    if ( caralarms.size <= 0 )
    {
        return;
    }
    
    level waittill( #"prematch_fade_done" );
    
    foreach ( alarm in caralarms )
    {
        alarm setscriptablepartstate( "base", "alive" );
    }
}

