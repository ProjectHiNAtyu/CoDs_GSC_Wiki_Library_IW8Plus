// script_26f456dbdf9aa216  (hash_26f456dbdf9aa216.gscc) (size: 548 Bytes / 0x224 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xba505cff (3125828863)
// size ...... 548 (0x224)
// includes .. 1   (offset: 0x1f0)
// strings ... 1   (offset: 0x1f8)
// dev strs .. 2   (offset: 0x20c)
// exports ... 2   (offset: 0x140)
// cseg ...... 0x63 + 0xdd (0x140)
// imports ... 3   (offset: 0x190)
// animtree1 . 0   (offset: 0x224)
// animtree2 . 0   (offset: 0x224)
#using scripts\asm\gesture;

#namespace namespace_f9e15975f25db152;

// Namespace namespace_f9e15975f25db152
// Params 2
// Checksum 0x907c01ef, Offset: 0x81
// Size: 0xbf
function function_f5f982ce9e32c830( statename, params )
{
    id = self getinteractionid();
    
    if ( params.size == 1 )
    {
        thread gesture::ai_request_gesture( params[ 0 ], undefined, undefined, "gesture" );
        return;
    }
    
    if ( params.size == 2 )
    {
        thread gesture::ai_request_gesture( params[ 0 ], params[ 1 ], undefined, "gesture" );
        return;
    }
    
    if ( params.size == 3 )
    {
        thread gesture::ai_request_gesture( params[ 0 ], params[ 1 ], params[ 2 ], "gesture" );
        return;
    }
    
    if ( params.size == 4 )
    {
        thread gesture::ai_request_gesture( params[ 0 ], params[ 1 ], params[ 2 ], params[ 3 ] );
        return;
    }
    
    assertmsg( "<dev string:x24>" + params.size + "<dev string:x64>" );
}

