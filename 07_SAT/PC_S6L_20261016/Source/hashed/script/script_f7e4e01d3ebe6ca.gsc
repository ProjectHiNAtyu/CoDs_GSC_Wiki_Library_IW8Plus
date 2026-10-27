// script_f7e4e01d3ebe6ca  (hash_0f7e4e01d3ebe6ca.gscc) (size: 346 Bytes / 0x15a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x41f63bcb (1106656203)
// size ...... 346 (0x15a)
// includes .. 1   (offset: 0x146)
// strings ... 0   (offset: 0x14e)
// dev strs .. 1   (offset: 0x14e)
// exports ... 2   (offset: 0xa2)
// cseg ...... 0x58 + 0x4a (0xa2)
// imports ... 3   (offset: 0xf2)
// animtree1 . 0   (offset: 0x15a)
// animtree2 . 0   (offset: 0x15a)
#using scripts\sp\lights;

#namespace namespace_cc2cbcd57ab8205e;

/#

    // Namespace namespace_cc2cbcd57ab8205e
    // Params 0
    // Checksum 0x570c5cb8, Offset: 0x76
    // Size: 0x2c, Type: dev
    function function_416d8df6134ec90a()
    {
        if ( isofflinetoolrun( 3 ) )
        {
            lights::init();
            println( "<dev string:x24>" );
            level waittill( #"eternity" );
        }
    }

#/
