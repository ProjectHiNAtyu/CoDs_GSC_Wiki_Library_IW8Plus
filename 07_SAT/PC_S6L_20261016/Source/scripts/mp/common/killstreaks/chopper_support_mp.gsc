// scripts\mp\common\killstreaks\chopper_support_mp.gsc  (hash_2d163c4d299f5bd3.gscc) (size: 681 Bytes / 0x2a9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4f257d37 (1327856951)
// size ...... 681 (0x2a9)
// includes .. 4   (offset: 0x26d)
// strings ... 2   (offset: 0x28d)
// dev strs .. 0   (offset: 0x2a9)
// exports ... 3   (offset: 0x14d)
// cseg ...... 0x7d + 0xd0 (0x14d)
// imports ... 6   (offset: 0x1c5)
// animtree1 . 0   (offset: 0x2a9)
// animtree2 . 0   (offset: 0x2a9)
#using scripts\common\utility;
#using scripts\common\vehicle_damage;
#using scripts\mp\common\killstreaks\chopper_support;
#using scripts\mp\common\killstreaks\killstreaks;

#namespace chopper_support_mp;

// Namespace chopper_support_mp
// Params 0
// Checksum 0x1278c0fb, Offset: 0x9b
// Size: 0x8b
function init()
{
    bundle = level.streakglobals.streakbundles[ "airdrop_escort" ];
    
    if ( isdefined( bundle ) && isdefined( bundle.var_442269833ef7493a ) )
    {
        killstreaks::registerkillstreakdamagedealingweapon( "airdrop_escort", bundle.var_442269833ef7493a, #"large" );
    }
    
    killstreaks::registerkillstreak( "chopper_support", &chopper_support::tryusechoppersupportfromstruct );
    utility::registersharedfunc( #"chopper_support", #"set_vehicle_hit_damage_data", &chopper_support_set_vehicle_hit_damage_data );
}

// Namespace chopper_support_mp
// Params 2
// Checksum 0x68fffde, Offset: 0x12e
// Size: 0x1f
function chopper_support_set_vehicle_hit_damage_data( ref, hitstokill )
{
    vehicle_damage::set_vehicle_hit_damage_data( ref, hitstokill );
}

