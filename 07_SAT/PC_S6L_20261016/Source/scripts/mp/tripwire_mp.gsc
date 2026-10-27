// scripts\mp\tripwire_mp.gsc  (hash_62475ac39cfcd0c2.gscc) (size: 398 Bytes / 0x18e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa70595ea (2802161130)
// size ...... 398 (0x18e)
// includes .. 2   (offset: 0x17e)
// strings ... 0   (offset: 0x18e)
// dev strs .. 0   (offset: 0x18e)
// exports ... 3   (offset: 0xce)
// cseg ...... 0x58 + 0x76 (0xce)
// imports ... 2   (offset: 0x146)
// animtree1 . 0   (offset: 0x18e)
// animtree2 . 0   (offset: 0x18e)
#using scripts\mp\common\utility\points;
#using scripts\mp\poi;

#namespace tripwire_mp;

// Namespace tripwire_mp
// Params 1
// Checksum 0x7cc0a2f5, Offset: 0x76
// Size: 0x29
function ontripwirecreate( tripwire )
{
    tripwire.script_poi = poi::poi_findpoioriginisin( tripwire.origin );
}

// Namespace tripwire_mp
// Params 2
// Checksum 0xe7caa942, Offset: 0xa7
// Size: 0x27
function ontripwiredefused( player, tripwire )
{
    player thread points::doscoreevent( #"dmz_trap_defused" );
}

