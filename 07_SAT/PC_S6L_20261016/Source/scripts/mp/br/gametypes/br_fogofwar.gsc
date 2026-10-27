// scripts\mp\br\gametypes\br_fogofwar.gsc  (hash_5365416a40b7e859.gscc) (size: 415 Bytes / 0x19f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x26a63724 (648427300)
// size ...... 415 (0x19f)
// includes .. 4   (offset: 0x17f)
// strings ... 0   (offset: 0x19f)
// dev strs .. 0   (offset: 0x19f)
// exports ... 2   (offset: 0xbb)
// cseg ...... 0x58 + 0x63 (0xbb)
// imports ... 4   (offset: 0x10b)
// animtree1 . 0   (offset: 0x19f)
// animtree2 . 0   (offset: 0x19f)
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\points;
#using scripts\mp\fogofwar;

#namespace br_fogofwar;

// Namespace br_fogofwar
// Params 0
// Checksum 0xc2b707e3, Offset: 0x76
// Size: 0x45
function init()
{
    utility::registersharedfunc( #"hash_a0522d1ad778a788", #"isplayeringulag", &br_public::isplayeringulag );
    utility::registersharedfunc( #"hash_a0522d1ad778a788", #"hash_cb519eda4cd9c06b", &points::givexpwithtext );
    fogofwar::init();
}

