// scripts\unittest\util.gsc  (hash_78a054d0158094fb.gscc) (size: 620 Bytes / 0x26c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc79b5996 (3348846998)
// size ...... 620 (0x26c)
// includes .. 0   (offset: 0x248)
// strings ... 3   (offset: 0x248)
// dev strs .. 0   (offset: 0x26c)
// exports ... 4   (offset: 0x134)
// cseg ...... 0x78 + 0xbc (0x134)
// imports ... 4   (offset: 0x1d4)
// animtree1 . 0   (offset: 0x26c)
// animtree2 . 0   (offset: 0x26c)
#namespace util;

// Namespace util
// Params 1
// Checksum 0x2662da49, Offset: 0x96
// Size: 0x58
function test_print( msg )
{
    msg = "SCR_TEST: " + msg;
    sysprint( msg );
    
    /#
        if ( !isdefined( level.var_49a2bb622d327d98 ) )
        {
            level.var_49a2bb622d327d98 = getdvarint( @"hash_afbf853954f73b57", 0 ) != 0;
        }
        
        if ( level.var_49a2bb622d327d98 )
        {
            println( msg );
        }
    #/
}

// Namespace util
// Params 1
// Checksum 0x4e7e9f49, Offset: 0xf6
// Size: 0x1b
function test_begin( tag )
{
    test_print( tag + "_begin" );
}

// Namespace util
// Params 1
// Checksum 0xfb8e10e3, Offset: 0x119
// Size: 0x1b
function test_end( tag )
{
    test_print( tag + "_end" );
}

