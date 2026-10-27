// scripts\mp\common\killstreaks\juggernaut_instant.gsc  (hash_11c22eb0069374a4.gscc) (size: 589 Bytes / 0x24d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3a44da7c (977590908)
// size ...... 589 (0x24d)
// includes .. 3   (offset: 0x225)
// strings ... 1   (offset: 0x23d)
// dev strs .. 0   (offset: 0x24d)
// exports ... 4   (offset: 0xdd)
// cseg ...... 0x6e + 0x6f (0xdd)
// imports ... 6   (offset: 0x17d)
// animtree1 . 0   (offset: 0x24d)
// animtree2 . 0   (offset: 0x24d)
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\mp\common\killstreaks\juggernaut;
#using scripts\mp\common\killstreaks\killstreaks;

#namespace juggernaut_instant;

// Namespace juggernaut_instant
// Params 0, eflags: 0x1
// Checksum 0x3f7bedfa, Offset: 0x8c
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( "juggernaut_instant" ), &killstreakinit );
}

// Namespace juggernaut_instant
// Params 0
// Checksum 0x1e7991a9, Offset: 0xab
// Size: 0x13
function killstreakinit()
{
    killstreaks::registerkillstreak( "juggernaut_instant", &function_ed3a4a8ef7047b8f );
}

// Namespace juggernaut_instant
// Params 1
// Checksum 0xb2da2c1, Offset: 0xc6
// Size: 0x17
function function_ed3a4a8ef7047b8f( streakinfo )
{
    juggernaut::tryusejuggernautfromstruct( streakinfo, 1 );
}

