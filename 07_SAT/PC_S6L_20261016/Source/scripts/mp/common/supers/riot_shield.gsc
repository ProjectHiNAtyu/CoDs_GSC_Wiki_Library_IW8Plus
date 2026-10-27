// scripts\mp\common\supers\riot_shield.gsc  (hash_4ffbc856a1ad9183.gscc) (size: 676 Bytes / 0x2a4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xea24a566 (3928270182)
// size ...... 676 (0x2a4)
// includes .. 2   (offset: 0x274)
// strings ... 2   (offset: 0x284)
// dev strs .. 0   (offset: 0x2a4)
// exports ... 3   (offset: 0x100)
// cseg ...... 0x8d + 0x73 (0x100)
// imports ... 9   (offset: 0x178)
// animtree1 . 0   (offset: 0x2a4)
// animtree2 . 0   (offset: 0x2a4)
#using scripts\mp\common\supers\super_riotshield;
#using scripts\mp\supers;

#namespace riot_shield;

// Namespace riot_shield
// Params 0, eflags: 0x1
// Checksum 0x6a0c5d00, Offset: 0xab
// Size: 0x17
function autoexec main()
{
    supers_mp::function_adf2820d5daa2e81( getxhash( "super_riot_shield" ), &riot_shield_init );
}

// Namespace riot_shield
// Params 0
// Checksum 0x87232048, Offset: 0xca
// Size: 0x36
function riot_shield_init()
{
    supers_mp::function_48aaa60b2ce7b8a1( "super_riot_shield", undefined, &super_riotshield::function_4013f0059e7227c4, &super_riotshield::riotshield_beginuse, undefined, &super_riotshield::function_1f861534eaef5adc, &super_riotshield::riotshield_ongive, undefined );
    super_riotshield::riotshield_init( "super_riot_shield", "projectile_rex_me_riotshield" );
}

