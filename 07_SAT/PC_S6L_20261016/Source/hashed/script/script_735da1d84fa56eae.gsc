// script_735da1d84fa56eae  (hash_735da1d84fa56eae.gscc) (size: 602 Bytes / 0x25a)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x13eefe4 (20901860)
// size ...... 602 (0x25a)
// includes .. 1   (offset: 0x246)
// strings ... 1   (offset: 0x24e)
// dev strs .. 0   (offset: 0x25a)
// exports ... 5   (offset: 0x10e)
// cseg ...... 0x78 + 0x96 (0x10e)
// imports ... 4   (offset: 0x1d6)
// animtree1 . 0   (offset: 0x25a)
// animtree2 . 0   (offset: 0x25a)
#using script_63258e3c8c400b7a;

#namespace ZMQuestContinuePlayingScreen;

// Namespace ZMQuestContinuePlayingScreen
// Params 0
// Checksum 0x2d158b34, Offset: 0x96
// Size: 0x16
function register()
{
    return lui_elems::register_lui_elem( "ZMQuestContinuePlayingScreen", #"zmquestcontinueplayingscreen" );
}

// Namespace ZMQuestContinuePlayingScreen
// Params 2
// Checksum 0x3696a325, Offset: 0xb5
// Size: 0x1f
function open( player, flags )
{
    lui_elems::open_lui_elem( player, flags );
}

// Namespace ZMQuestContinuePlayingScreen
// Params 1
// Checksum 0xd271df93, Offset: 0xdc
// Size: 0x15
function close( player )
{
    lui_elems::close_lui_elem( player );
}

// Namespace ZMQuestContinuePlayingScreen
// Params 1
// Checksum 0xc22ecc52, Offset: 0xf9
// Size: 0x14
function is_open( player )
{
    return lui_elems::is_open_lui_elem( player );
}

