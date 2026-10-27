// scripts\code\delete.gsc  (hash_2b0d7e2a0f096cd1.gscc) (size: 310 Bytes / 0x136 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa5219475 (2770441333)
// size ...... 310 (0x136)
// includes .. 0   (offset: 0x136)
// strings ... 0   (offset: 0x136)
// dev strs .. 0   (offset: 0x136)
// exports ... 2   (offset: 0x92)
// cseg ...... 0x58 + 0x3a (0x92)
// imports ... 3   (offset: 0xe2)
// animtree1 . 0   (offset: 0x136)
// animtree2 . 0   (offset: 0x136)
#namespace delete;

// Namespace delete/delete_entity
// Params 0, eflags: 0x20
// Checksum 0x618d1387, Offset: 0x76
// Size: 0x1c
function event_handler[delete_entity] main()
{
    assert( isdefined( self ) );
    wait 0;
    
    if ( isent( self ) )
    {
        self delete();
    }
}

