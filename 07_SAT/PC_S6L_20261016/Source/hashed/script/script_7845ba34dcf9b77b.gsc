// script_7845ba34dcf9b77b  (hash_7845ba34dcf9b77b.gscc) (size: 781 Bytes / 0x30d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb2fc17f5 (3002865653)
// size ...... 781 (0x30d)
// includes .. 2   (offset: 0x2fd)
// strings ... 0   (offset: 0x30d)
// dev strs .. 0   (offset: 0x30d)
// exports ... 3   (offset: 0x231)
// cseg ...... 0x58 + 0x1d9 (0x231)
// imports ... 3   (offset: 0x2a9)
// animtree1 . 0   (offset: 0x30d)
// animtree2 . 0   (offset: 0x30d)
#using script_d74ae0b4aa21186;
#using scripts\mp\gameobjects;

#namespace interactable_fobs;

// Namespace interactable_fobs
// Params 0
// Checksum 0x927fdd53, Offset: 0x76
// Size: 0x67
function createevent()
{
    event = mind::function_1d123cae6381160b();
    event.result = [];
    eventstream = self.mind.eventstream;
    eventstream.var_dada0225e9db408 = event;
    eventstream.events[ eventstream.events.size ] = event;
}

// Namespace interactable_fobs
// Params 0
// Checksum 0xe430b110, Offset: 0xe5
// Size: 0x14b
function getevent()
{
    event = self.mind.eventstream.var_dada0225e9db408;
    
    if ( !event.evaluated )
    {
        if ( event.result.size > 0 )
        {
            event.result = [];
        }
        
        if ( !isdefined( level.allfobs ) )
        {
            return event.result;
        }
        
        foreach ( fob in level.allfobs )
        {
            fobobject = fob.trigger.gameobject;
            
            if ( !fobobject gameobjects::caninteractwith( self.team ) )
            {
                continue;
            }
            
            event.result[ event.result.size ] = fob;
        }
        
        event.evaluated = 1;
    }
    
    return event.result;
}

