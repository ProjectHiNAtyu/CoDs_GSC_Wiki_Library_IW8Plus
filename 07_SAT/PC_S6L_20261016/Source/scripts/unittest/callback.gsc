// scripts\unittest\callback.gsc  (hash_1322f7f2fd8dc770.gscc) (size: 239 Bytes / 0xef / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb945af0e (3108351758)
// size ...... 239 (0xef)
// includes .. 0   (offset: 0xef)
// strings ... 0   (offset: 0xef)
// dev strs .. 0   (offset: 0xef)
// exports ... 2   (offset: 0x9f)
// cseg ...... 0x58 + 0x47 (0x9f)
// imports ... 0   (offset: 0xef)
// animtree1 . 0   (offset: 0xef)
// animtree2 . 0   (offset: 0xef)
#namespace callback;

// Namespace callback
// Params 2
// Checksum 0x77f3f507, Offset: 0x76
// Size: 0x29
function exec_callback( func, data )
{
    if ( isdefined( data ) )
    {
        [[ func ]]( data );
        return;
    }
    
    [[ func ]]();
}

