// scripts\mp\scriptable.gsc  (hash_525cd9b94f8850c1.gscc) (size: 550 Bytes / 0x226 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdc8ec8fd (3700345085)
// size ...... 550 (0x226)
// includes .. 3   (offset: 0x1f6)
// strings ... 1   (offset: 0x20e)
// dev strs .. 0   (offset: 0x226)
// exports ... 3   (offset: 0xd6)
// cseg ...... 0x6d + 0x69 (0xd6)
// imports ... 6   (offset: 0x14e)
// animtree1 . 0   (offset: 0x226)
// animtree2 . 0   (offset: 0x226)
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\flags;

#namespace scriptable;

// Namespace scriptable
// Params 0
// Checksum 0x739dbfde, Offset: 0x8b
// Size: 0xe
function scriptable_mpglobalcallback()
{
    scriptable_setinitcallback( &scriptable_mpcallback );
}

// Namespace scriptable
// Params 0
// Checksum 0x3cc03896, Offset: 0xa1
// Size: 0x35
function scriptable_mpcallback()
{
    flags::levelflagset( "scriptables_ready" );
    
    if ( !utility::flag_exist( "scriptables_ready" ) )
    {
        utility::flag_init( "scriptables_ready" );
    }
    
    utility::flag_set( "scriptables_ready" );
}

