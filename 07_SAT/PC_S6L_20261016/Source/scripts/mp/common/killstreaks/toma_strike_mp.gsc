// scripts\mp\common\killstreaks\toma_strike_mp.gsc  (hash_156ce82f4d965fc0.gscc) (size: 922 Bytes / 0x39a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xba17c7e7 (3122120679)
// size ...... 922 (0x39a)
// includes .. 5   (offset: 0x35a)
// strings ... 1   (offset: 0x382)
// dev strs .. 0   (offset: 0x39a)
// exports ... 4   (offset: 0x1d2)
// cseg ...... 0x67 + 0x16b (0x1d2)
// imports ... 8   (offset: 0x272)
// animtree1 . 0   (offset: 0x39a)
// animtree2 . 0   (offset: 0x39a)
#using scripts\common\utility;
#using scripts\mp\common\equipment\molotov;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\toma_strike;
#using scripts\mp\damage;

#namespace toma_strike_mp;

// Namespace toma_strike_mp
// Params 0
// Checksum 0x7a00f894, Offset: 0x85
// Size: 0xde
function init()
{
    killstreaks::registerkillstreak( "toma_strike", &toma_strike::tryusetomastrikefromstruct );
    utility::registersharedfunc( #"toma_strike", #"monitordamage", &toma_strike_monitordamage );
    utility::registersharedfunc( #"toma_strike", #"molotov_branch_draw_hits", &toma_strike_molotov_branch_draw_hits );
    bundle = level.streakglobals.streakbundles[ "toma_strike" ];
    
    if ( isdefined( bundle ) && isdefined( bundle.toma_weapon_name ) )
    {
        killstreaks::registerkillstreakdamagedealingweapon( "toma_strike", bundle.toma_weapon_name, #"medium" );
    }
    
    if ( isdefined( bundle ) && isdefined( bundle.deployweaponname ) )
    {
        killstreaks::registerkillstreakdamagedealingweapon( "toma_strike", bundle.deployweaponname, #"donotregister" );
    }
}

// Namespace toma_strike_mp
// Params 7
// Checksum 0x9763537a, Offset: 0x16b
// Size: 0x53
function toma_strike_monitordamage( maxhealth, damagefeedback, ondeathfunc, modifydamagefunc, biskillstreak, rumble, resetdamagetaken )
{
    damage::monitordamage( maxhealth, damagefeedback, ondeathfunc, modifydamagefunc, biskillstreak, rumble, resetdamagetaken );
}

// Namespace toma_strike_mp
// Params 0
// Checksum 0x497c89a1, Offset: 0x1c6
// Size: 0xc
function toma_strike_molotov_branch_draw_hits()
{
    /#
        thread molotov::molotov_branch_draw_hits();
    #/
}

