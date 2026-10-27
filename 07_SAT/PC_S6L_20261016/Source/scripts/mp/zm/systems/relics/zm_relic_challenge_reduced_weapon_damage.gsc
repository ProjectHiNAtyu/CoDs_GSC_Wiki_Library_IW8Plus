// scripts\mp\zm\systems\relics\zm_relic_challenge_reduced_weapon_damage.gsc  (hash_201a5a70dae7aa81.gscc) (size: 1062 Bytes / 0x426 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x915f558 (152434008)
// size ...... 1062 (0x426)
// includes .. 4   (offset: 0x3ee)
// strings ... 0   (offset: 0x40e)
// dev strs .. 2   (offset: 0x40e)
// exports ... 7   (offset: 0x182)
// cseg ...... 0x58 + 0x12a (0x182)
// imports ... 12  (offset: 0x29a)
// animtree1 . 0   (offset: 0x426)
// animtree2 . 0   (offset: 0x426)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\zm\systems\relics\zm_relic_challenges;

#namespace zm_relic_challenge_reduced_weapon_damage;

// Namespace zm_relic_challenge_reduced_weapon_damage
// Params 0, eflags: 0x5
// Checksum 0x34a93484, Offset: 0x76
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_relic_challenge_reduced_weapon_damage", undefined, &init_relic_challenge_reduced_weapon_damage, undefined );
}

// Namespace zm_relic_challenge_reduced_weapon_damage
// Params 0
// Checksum 0x67e90eb9, Offset: 0x97
// Size: 0xa
function init_relic_challenge_reduced_weapon_damage()
{
    level thread function_abaedc05033fa50b();
}

// Namespace zm_relic_challenge_reduced_weapon_damage
// Params 0
// Checksum 0x48e0b121, Offset: 0xa9
// Size: 0x1c
function function_abaedc05033fa50b()
{
    zm_relic_challenges::register_relic_challenge_functions( #"reduced_weapon_damage", &function_254a5313eddb69e7, &function_ede919290c9fbf22 );
}

// Namespace zm_relic_challenge_reduced_weapon_damage
// Params 0
// Checksum 0xce3b7771, Offset: 0xcd
// Size: 0x31
function function_254a5313eddb69e7()
{
    level utility::registersharedfunc( #"zombie", #"hash_9390d4bfb2b44ab2", &function_ed5070f64e2e51b6 );
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_relic_challenge_reduced_weapon_damage
// Params 0
// Checksum 0x31ff7b5a, Offset: 0x106
// Size: 0x2c
function function_ede919290c9fbf22()
{
    level utility::clearsharedfunc( #"zombie", #"hash_9390d4bfb2b44ab2" );
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x59>" );
    #/
}

// Namespace zm_relic_challenge_reduced_weapon_damage
// Params 1, eflags: 0x4
// Checksum 0xbc62b0ec, Offset: 0x13a
// Size: 0x47
function private function_ed5070f64e2e51b6( dmg_struct )
{
    idamage = dmg_struct.idamage;
    
    if ( weapon::isprimaryweapon( dmg_struct.sweapon ) )
    {
        idamage = int( idamage * 0.5 );
    }
    
    return idamage;
}

