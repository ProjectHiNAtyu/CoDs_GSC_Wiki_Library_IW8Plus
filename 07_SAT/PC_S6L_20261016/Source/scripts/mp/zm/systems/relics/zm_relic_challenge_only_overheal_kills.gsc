// scripts\mp\zm\systems\relics\zm_relic_challenge_only_overheal_kills.gsc  (hash_3f0cfca64b7e87f1.gscc) (size: 1711 Bytes / 0x6af / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfeb8dfe6 (4273528806)
// size ...... 1711 (0x6af)
// includes .. 6   (offset: 0x657)
// strings ... 1   (offset: 0x687)
// dev strs .. 2   (offset: 0x697)
// exports ... 8   (offset: 0x2bf)
// cseg ...... 0x70 + 0x24f (0x2bf)
// imports ... 21  (offset: 0x3ff)
// animtree1 . 0   (offset: 0x6af)
// animtree2 . 0   (offset: 0x6af)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\health_overcharge;
#using scripts\mp\zm\systems\relics\zm_relic_challenges;
#using scripts\mp\zm\zm_utility;

#namespace zm_relic_challenge_only_overheal_kills;

// Namespace zm_relic_challenge_only_overheal_kills
// Params 0, eflags: 0x5
// Checksum 0x5781365e, Offset: 0x8e
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_65ace228dac8a054", undefined, &function_427caa1bab65a914, undefined );
}

// Namespace zm_relic_challenge_only_overheal_kills
// Params 0
// Checksum 0xf3b6b17c, Offset: 0xaf
// Size: 0xa
function function_427caa1bab65a914()
{
    level thread function_1a57b315f4a22a7f();
}

// Namespace zm_relic_challenge_only_overheal_kills
// Params 0
// Checksum 0x528689c6, Offset: 0xc1
// Size: 0x1c
function function_1a57b315f4a22a7f()
{
    zm_relic_challenges::register_relic_challenge_functions( #"hash_efd75b235dceeae2", &function_b5a56420ba4cdf1f, &function_c4ea744dbd795ada );
}

// Namespace zm_relic_challenge_only_overheal_kills
// Params 0
// Checksum 0xf9502505, Offset: 0xe5
// Size: 0x64
function function_b5a56420ba4cdf1f()
{
    level utility::registersharedfunc( #"zombie", #"hash_9390d4bfb2b44ab2", &function_eb037271d5fb2c78 );
    level callback::add( "on_zombie_ai_spawned", &on_zombie_ai_spawned );
    level.var_cdca5e730e05bc39 = 1;
    level.active_relic_challenge.overheal_kills = 1;
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_relic_challenge_only_overheal_kills
// Params 0
// Checksum 0x33c90213, Offset: 0x151
// Size: 0xea
function function_c4ea744dbd795ada()
{
    level utility::clearsharedfunc( #"zombie", #"hash_9390d4bfb2b44ab2" );
    level callback::remove( "on_zombie_ai_spawned", &on_zombie_ai_spawned );
    level.var_cdca5e730e05bc39 = 0;
    level.active_relic_challenge.overheal_kills = undefined;
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
        iprintlnbold( "<dev string:x60>" );
    #/
}

// Namespace zm_relic_challenge_only_overheal_kills
// Params 1, eflags: 0x4
// Checksum 0x46ee18c1, Offset: 0x243
// Size: 0x60
function private function_eb037271d5fb2c78( dmg_struct )
{
    idamage = dmg_struct.idamage;
    
    if ( isdefined( dmg_struct.eattacker ) && dmg_struct.eattacker health_overcharge::function_1c546d630583f860() )
    {
        zm_relic_challenges::function_908a1b8613e50514();
    }
    else
    {
        idamage *= 0;
        zm_relic_challenges::set_zombie_damage_invuln();
    }
    
    return idamage;
}

// Namespace zm_relic_challenge_only_overheal_kills
// Params 1, eflags: 0x4
// Checksum 0xdb680d63, Offset: 0x2ac
// Size: 0x13
function private on_zombie_ai_spawned( params )
{
    zm_relic_challenges::set_zombie_damage_invuln();
}

