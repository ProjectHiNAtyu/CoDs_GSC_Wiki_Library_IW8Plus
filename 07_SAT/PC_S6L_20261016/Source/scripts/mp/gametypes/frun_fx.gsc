// scripts\mp\gametypes\frun_fx.gsc  (hash_507327aef5d0d866.gscc) (size: 1017 Bytes / 0x3f9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc4c1cdeb (3301035499)
// size ...... 1017 (0x3f9)
// includes .. 1   (offset: 0x3d9)
// strings ... 2   (offset: 0x3e1)
// dev strs .. 0   (offset: 0x3f9)
// exports ... 5   (offset: 0x1f5)
// cseg ...... 0x7d + 0x178 (0x1f5)
// imports ... 10  (offset: 0x2bd)
// animtree1 . 0   (offset: 0x3f9)
// animtree2 . 0   (offset: 0x3f9)
#using scripts\mp\common\utility\trigger;

#namespace frun_fx;

// Namespace frun_fx
// Params 0
// Checksum 0x86d12b5e, Offset: 0x9b
// Size: 0x9
function init()
{
    function_b804292deb870d69();
}

// Namespace frun_fx
// Params 0, eflags: 0x4
// Checksum 0x9f763a96, Offset: 0xac
// Size: 0x99
function private function_b804292deb870d69()
{
    worldeventtriggers = getentarray( "world_event_trigger", "targetname" );
    
    foreach ( trigger in worldeventtriggers )
    {
        trigger::makeenterexittrigger( trigger, &function_7211300e217808d1, undefined, undefined, undefined, &function_fe1fb3d2b2e0e810 );
    }
}

// Namespace frun_fx
// Params 2, eflags: 0x4
// Checksum 0xadea8c6f, Offset: 0x14d
// Size: 0x54, Type: bool
function private function_fe1fb3d2b2e0e810( triggeringent, enttrigger )
{
    if ( !isplayer( triggeringent ) || !isalive( triggeringent ) )
    {
        return true;
    }
    
    playerid = triggeringent getentitynumber();
    
    if ( enttrigger.triggeredplayers[ playerid ] )
    {
        return true;
    }
    
    return false;
}

// Namespace frun_fx
// Params 2, eflags: 0x4
// Checksum 0xde55077, Offset: 0x1aa
// Size: 0x4b
function private function_7211300e217808d1( triggeringent, enttrigger )
{
    playerid = triggeringent getentitynumber();
    enttrigger.triggeredplayers[ playerid ] = 1;
    activateworldevent( enttrigger.script_noteworthy, undefined, triggeringent );
}

