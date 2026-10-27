// scripts\mp\zm\systems\relics\zm_relic_challenge_only_sniper_kills.gsc  (hash_0cb94a9c7d3f687a.gscc) (size: 2151 Bytes / 0x867 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc8534b94 (3360902036)
// size ...... 2151 (0x867)
// includes .. 7   (offset: 0x7e3)
// strings ... 4   (offset: 0x81b)
// dev strs .. 2   (offset: 0x84f)
// exports ... 8   (offset: 0x403)
// cseg ...... 0xc9 + 0x33a (0x403)
// imports ... 23  (offset: 0x543)
// animtree1 . 0   (offset: 0x867)
// animtree2 . 0   (offset: 0x867)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\doorbuy;
#using scripts\mp\zm\systems\relics\zm_relic_challenges;
#using scripts\mp\zm\zm_utility;

#namespace zm_relic_challenge_only_sniper_kills;

// Namespace zm_relic_challenge_only_sniper_kills
// Params 0, eflags: 0x5
// Checksum 0x8cee163e, Offset: 0xe7
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_320ab2e589c25bcf", undefined, &function_f24933d02844680f, undefined );
}

// Namespace zm_relic_challenge_only_sniper_kills
// Params 0
// Checksum 0x44bb64c1, Offset: 0x108
// Size: 0xa
function function_f24933d02844680f()
{
    level thread function_b8c07f006f27f354();
}

// Namespace zm_relic_challenge_only_sniper_kills
// Params 0
// Checksum 0x54739859, Offset: 0x11a
// Size: 0x1c
function function_b8c07f006f27f354()
{
    zm_relic_challenges::register_relic_challenge_functions( #"only_sniper_kills", &function_bf50a54b1d3e643e, &function_aa336443ba2194dd );
}

// Namespace zm_relic_challenge_only_sniper_kills
// Params 0
// Checksum 0xe53f1fc1, Offset: 0x13e
// Size: 0x160
function function_bf50a54b1d3e643e()
{
    a_doors = getentarray( "zm_sat_hornet_doorbuy_instance_4", #target );
    
    foreach ( door in a_doors )
    {
        door thread doorbuy::doorbuy_used( undefined, undefined, 1 );
    }
    
    a_doors = getentarray( "zm_sat_hornet_doorbuy_instance_2", #target );
    
    foreach ( door in a_doors )
    {
        door thread doorbuy::doorbuy_used( undefined, undefined, 1 );
    }
    
    level utility::registersharedfunc( #"zombie", #"hash_9390d4bfb2b44ab2", &function_eb037271d5fb2c78 );
    level callback::add( "on_zombie_ai_spawned", &on_zombie_ai_spawned );
    level.var_cdca5e730e05bc39 = 1;
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_relic_challenge_only_sniper_kills
// Params 0
// Checksum 0x8eb701dd, Offset: 0x2a6
// Size: 0xd7
function function_aa336443ba2194dd()
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

// Namespace zm_relic_challenge_only_sniper_kills
// Params 1, eflags: 0x4
// Checksum 0x2804b6b5, Offset: 0x385
// Size: 0x62
function private function_eb037271d5fb2c78( dmg_struct )
{
    idamage = dmg_struct.idamage;
    weapongroup = weapon::getweapongroup( dmg_struct.objweapon );
    
    if ( weapongroup != "weapon_sniper" )
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

// Namespace zm_relic_challenge_only_sniper_kills
// Params 1, eflags: 0x4
// Checksum 0x590302d0, Offset: 0x3f0
// Size: 0x13
function private on_zombie_ai_spawned( params )
{
    zm_relic_challenges::set_zombie_damage_invuln();
}

