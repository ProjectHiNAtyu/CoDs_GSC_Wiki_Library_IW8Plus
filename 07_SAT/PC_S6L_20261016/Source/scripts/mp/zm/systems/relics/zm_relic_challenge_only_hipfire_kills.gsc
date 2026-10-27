// scripts\mp\zm\systems\relics\zm_relic_challenge_only_hipfire_kills.gsc  (hash_290e93511074a828.gscc) (size: 2258 Bytes / 0x8d2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb978f681 (3111712385)
// size ...... 2258 (0x8d2)
// includes .. 7   (offset: 0x85a)
// strings ... 3   (offset: 0x892)
// dev strs .. 2   (offset: 0x8ba)
// exports ... 9   (offset: 0x3ee)
// cseg ...... 0x93 + 0x35b (0x3ee)
// imports ... 27  (offset: 0x556)
// animtree1 . 0   (offset: 0x8d2)
// animtree2 . 0   (offset: 0x8d2)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\zm\systems\relics\zm_relic_challenges;
#using scripts\mp\zm\zm_utility;

#namespace zm_relic_challenge_only_hipfire_kills;

// Namespace zm_relic_challenge_only_hipfire_kills
// Params 0, eflags: 0x5
// Checksum 0x3cae3dbf, Offset: 0xb1
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_relic_challenge_only_hipfire_kills", undefined, &init_relic_challenge_only_hipfire_kills, undefined );
}

// Namespace zm_relic_challenge_only_hipfire_kills
// Params 0
// Checksum 0xfd7ea365, Offset: 0xd2
// Size: 0xa
function init_relic_challenge_only_hipfire_kills()
{
    level thread function_a97055454873ae0();
}

// Namespace zm_relic_challenge_only_hipfire_kills
// Params 0
// Checksum 0x78d07965, Offset: 0xe4
// Size: 0x1c
function function_a97055454873ae0()
{
    zm_relic_challenges::register_relic_challenge_functions( #"only_hipfire_kills", &function_e54570035d0c347a, &function_709c865db17e7dd9 );
}

// Namespace zm_relic_challenge_only_hipfire_kills
// Params 0
// Checksum 0xfcacd7eb, Offset: 0x108
// Size: 0x4e
function function_e54570035d0c347a()
{
    level utility::registersharedfunc( #"zombie", #"hash_9390d4bfb2b44ab2", &function_eb037271d5fb2c78 );
    level callback::add( "on_zombie_ai_spawned", &on_zombie_ai_spawned );
    level.var_cdca5e730e05bc39 = 1;
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_relic_challenge_only_hipfire_kills
// Params 0
// Checksum 0xe4556708, Offset: 0x15e
// Size: 0xd7
function function_709c865db17e7dd9()
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
        iprintlnbold( "<dev string:x56>" );
    #/
}

// Namespace zm_relic_challenge_only_hipfire_kills
// Params 1, eflags: 0x4
// Checksum 0x40019cd3, Offset: 0x23d
// Size: 0x110
function private function_eb037271d5fb2c78( dmg_struct )
{
    idamage = dmg_struct.idamage;
    player = dmg_struct.eattacker;
    weapon = dmg_struct.sweapon;
    
    if ( !isplayer( player ) || player adsbuttonpressed() && !weapon::isakimbo( dmg_struct.sweapon ) || weapon::isweaponequipment( dmg_struct.sweapon ) || is_banned_killstreak( dmg_struct.sweapon ) || !weapon::isprimaryweapon( dmg_struct.sweapon ) && !weapon::iskillstreakweapon( dmg_struct.sweapon ) && dmg_struct.smeansofdeath != "MOD_MELEE" && dmg_struct.smeansofdeath != "MOD_MELEE_TAKEDOWN" )
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

// Namespace zm_relic_challenge_only_hipfire_kills
// Params 1, eflags: 0x4
// Checksum 0x1ddde3e5, Offset: 0x356
// Size: 0x7c, Type: bool
function private is_banned_killstreak( sweapon )
{
    if ( !weapon::iskillstreakweapon( sweapon ) )
    {
        return false;
    }
    
    switch ( sweapon.basenamehash )
    {
        case %"t10_la_mangler_cannon_mp":
        case %"sat_ks_warmachine":
        case %"sat_ks_handcannon":
        case %"sat_ks_deathmachine":
        case %"sat_ks_compound_mp":
        case %"sat_ks_mega_deathmachine_zm":
            return false;
    }
    
    return true;
}

// Namespace zm_relic_challenge_only_hipfire_kills
// Params 1, eflags: 0x4
// Checksum 0x1bd7594, Offset: 0x3db
// Size: 0x13
function private on_zombie_ai_spawned( params )
{
    zm_relic_challenges::set_zombie_damage_invuln();
}

