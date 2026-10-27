// scripts\mp\zm\systems\relics\zm_relic_challenge_only_melee_damage_kills.gsc  (hash_4a2cf99ccd00aaad.gscc) (size: 1835 Bytes / 0x72b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7f8a019f (2139750815)
// size ...... 1835 (0x72b)
// includes .. 5   (offset: 0x6ab)
// strings ... 5   (offset: 0x6d3)
// dev strs .. 2   (offset: 0x713)
// exports ... 8   (offset: 0x32f)
// cseg ...... 0xbc + 0x273 (0x32f)
// imports ... 20  (offset: 0x46f)
// animtree1 . 0   (offset: 0x72b)
// animtree2 . 0   (offset: 0x72b)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\relics\zm_relic_challenges;
#using scripts\mp\zm\zm_utility;

#namespace zm_relic_challenge_only_melee_damage_kills;

// Namespace zm_relic_challenge_only_melee_damage_kills
// Params 0, eflags: 0x5
// Checksum 0xd0250f70, Offset: 0xda
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_25da1a169a138fae", undefined, &function_ecfebb08e8c7baee, undefined );
}

// Namespace zm_relic_challenge_only_melee_damage_kills
// Params 0
// Checksum 0xd72a033f, Offset: 0xfb
// Size: 0xa
function function_ecfebb08e8c7baee()
{
    level thread function_8453d273a8a8ac31();
}

// Namespace zm_relic_challenge_only_melee_damage_kills
// Params 0
// Checksum 0xcf3c9f49, Offset: 0x10d
// Size: 0x1c
function function_8453d273a8a8ac31()
{
    zm_relic_challenges::register_relic_challenge_functions( #"only_melee_damage", &function_5c4f58e512f389ad, &function_cac18c906d09ea0 );
}

// Namespace zm_relic_challenge_only_melee_damage_kills
// Params 0
// Checksum 0xc9630cf0, Offset: 0x131
// Size: 0x4e
function function_5c4f58e512f389ad()
{
    level utility::registersharedfunc( #"zombie", #"hash_9390d4bfb2b44ab2", &function_eb037271d5fb2c78 );
    level callback::add( "on_zombie_ai_spawned", &on_zombie_ai_spawned );
    level.var_cdca5e730e05bc39 = 1;
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_relic_challenge_only_melee_damage_kills
// Params 0
// Checksum 0xa6304902, Offset: 0x187
// Size: 0xd7
function function_cac18c906d09ea0()
{
    level utility::clearsharedfunc( #"zombie", #"hash_9390d4bfb2b44ab2" );
    level callback::remove( "on_zombie_ai_spawned", &on_zombie_ai_spawned );
    level.var_cdca5e730e05bc39 = 0;
    var_d3bf5c32e7a64eb1 = getaiarray( zm_utility::get_zombie_team() );
    
    foreach ( zombie in var_d3bf5c32e7a64eb1 )
    {
        if ( isalive( zombie ) )
        {
            zombie zm_relic_challenges::function_908a1b8613e50514();
        }
    }
    
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x5b>" );
    #/
}

// Namespace zm_relic_challenge_only_melee_damage_kills
// Params 1, eflags: 0x4
// Checksum 0x12e4fb20, Offset: 0x266
// Size: 0xad
function private function_eb037271d5fb2c78( dmg_struct )
{
    idamage = dmg_struct.idamage;
    
    if ( dmg_struct.smeansofdeath != "MOD_MELEE" && ( dmg_struct.sweapon.basename != "sat_ww_locust_fireball" || dmg_struct.sweapon.basename != "sat_ww_locust_zm" || dmg_struct.sweapon.basename != "sat_ww_locust" ) )
    {
        idamage *= 0;
        zm_relic_challenges::set_zombie_damage_invuln();
    }
    else
    {
        zm_relic_challenges::function_908a1b8613e50514();
    }
    
    return idamage;
}

// Namespace zm_relic_challenge_only_melee_damage_kills
// Params 1, eflags: 0x4
// Checksum 0xebac78d3, Offset: 0x31c
// Size: 0x13
function private on_zombie_ai_spawned( params )
{
    zm_relic_challenges::set_zombie_damage_invuln();
}

