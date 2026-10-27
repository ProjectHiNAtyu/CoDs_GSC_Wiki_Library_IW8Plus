// scripts\mp\common\killstreaks\airdrop_multiple_mp.gsc  (hash_0fe9d79f45d5b5ce.gscc) (size: 582 Bytes / 0x246 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb3e69ec8 (3018235592)
// size ...... 582 (0x246)
// includes .. 4   (offset: 0x21a)
// strings ... 1   (offset: 0x23a)
// dev strs .. 0   (offset: 0x246)
// exports ... 3   (offset: 0x116)
// cseg ...... 0x6c + 0xaa (0x116)
// imports ... 5   (offset: 0x18e)
// animtree1 . 0   (offset: 0x246)
// animtree2 . 0   (offset: 0x246)
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\damage;

#namespace airdrop_multiple_mp;

// Namespace airdrop_multiple_mp
// Params 0
// Checksum 0xcccead77, Offset: 0x8a
// Size: 0x31
function airdrop_multiple_init()
{
    killstreaks::registerkillstreak( "airdrop_multiple", &airdrop::tryuseairdropmarkerfromstruct );
    utility::registersharedfunc( #"airdrop_multiple", #"monitordamage", &airdrop_multiple_monitordamage );
}

// Namespace airdrop_multiple_mp
// Params 7
// Checksum 0x9f4601c5, Offset: 0xc3
// Size: 0x53
function airdrop_multiple_monitordamage( maxhealth, damagefeedback, ondeathfunc, modifydamagefunc, biskillstreak, rumble, resetdamagetaken )
{
    damage::monitordamage( maxhealth, damagefeedback, ondeathfunc, modifydamagefunc, biskillstreak, rumble, resetdamagetaken );
}

