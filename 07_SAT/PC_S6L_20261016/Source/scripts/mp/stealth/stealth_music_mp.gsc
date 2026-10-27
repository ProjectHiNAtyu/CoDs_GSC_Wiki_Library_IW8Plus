// scripts\mp\stealth\stealth_music_mp.gsc  (hash_15c7dc779b327c9b.gscc) (size: 293 Bytes / 0x125 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x63cf1b56 (1674517334)
// size ...... 293 (0x125)
// includes .. 2   (offset: 0x115)
// strings ... 0   (offset: 0x125)
// dev strs .. 0   (offset: 0x125)
// exports ... 2   (offset: 0x8d)
// cseg ...... 0x58 + 0x35 (0x8d)
// imports ... 2   (offset: 0xdd)
// animtree1 . 0   (offset: 0x125)
// animtree2 . 0   (offset: 0x125)
#using scripts\common\callbacks;
#using scripts\mp\stealth\stealth_music;

#namespace stealth_music_mp;

// Namespace stealth_music_mp
// Params 0
// Checksum 0xee22e9fb, Offset: 0x76
// Size: 0x17
function init()
{
    callback::add( #"player_spawned", &stealth_music::function_5197bc70e9265f24 );
}

