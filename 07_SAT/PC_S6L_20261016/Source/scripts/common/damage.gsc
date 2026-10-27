// scripts\common\damage.gsc  (hash_1fca6e8d01a6b143.gscc) (size: 546 Bytes / 0x222 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x42eadf8f (1122688911)
// size ...... 546 (0x222)
// includes .. 0   (offset: 0x222)
// strings ... 0   (offset: 0x222)
// dev strs .. 0   (offset: 0x222)
// exports ... 3   (offset: 0x18e)
// cseg ...... 0x58 + 0x136 (0x18e)
// imports ... 1   (offset: 0x206)
// animtree1 . 0   (offset: 0x222)
// animtree2 . 0   (offset: 0x222)
#namespace damage;

// Namespace damage
// Params 12
// Checksum 0x857f7cf8, Offset: 0x76
// Size: 0x85
function callback_playerdamagescore( einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, lightarmordamage, heavyarmordamage )
{
    return scoredamage( einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, lightarmordamage, heavyarmordamage );
}

// Namespace damage
// Params 12
// Checksum 0xa4f626f4, Offset: 0x104
// Size: 0x89
function scoredamage( einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, lightarmordamage, heavyarmordamage )
{
    if ( idamage >= 50 )
    {
        return 2;
    }
    else if ( idamage >= 16 )
    {
        return 1;
    }
    
    return 0;
}

