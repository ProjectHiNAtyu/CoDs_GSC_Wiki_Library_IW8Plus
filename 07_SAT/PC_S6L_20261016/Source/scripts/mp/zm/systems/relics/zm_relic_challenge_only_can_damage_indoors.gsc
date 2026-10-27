// scripts\mp\zm\systems\relics\zm_relic_challenge_only_can_damage_indoors.gsc  (hash_2bc4707573d80866.gscc) (size: 1756 Bytes / 0x6dc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd7422bd0 (3611438032)
// size ...... 1756 (0x6dc)
// includes .. 5   (offset: 0x68c)
// strings ... 1   (offset: 0x6b4)
// dev strs .. 2   (offset: 0x6c4)
// exports ... 8   (offset: 0x2d4)
// cseg ...... 0x70 + 0x264 (0x2d4)
// imports ... 22  (offset: 0x414)
// animtree1 . 0   (offset: 0x6dc)
// animtree2 . 0   (offset: 0x6dc)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\relics\zm_relic_challenges;
#using scripts\mp\zm\zm_utility;

#namespace zm_relic_challenge_only_can_damage_indoors;

// Namespace zm_relic_challenge_only_can_damage_indoors
// Params 0, eflags: 0x5
// Checksum 0xdaa8de50, Offset: 0x8e
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_99dd92034227fc52", undefined, &function_ec110c2d01c53612, undefined );
}

// Namespace zm_relic_challenge_only_can_damage_indoors
// Params 0
// Checksum 0x60bc03aa, Offset: 0xaf
// Size: 0xa
function function_ec110c2d01c53612()
{
    level thread function_1af5f7f9de2b70a3();
}

// Namespace zm_relic_challenge_only_can_damage_indoors
// Params 0
// Checksum 0x71892842, Offset: 0xc1
// Size: 0x1c
function function_1af5f7f9de2b70a3()
{
    zm_relic_challenges::register_relic_challenge_functions( #"hash_8d76bac719900756", &function_d2b085a69cfb106b, &function_e4748e1a155b35e6 );
}

// Namespace zm_relic_challenge_only_can_damage_indoors
// Params 0
// Checksum 0x6f71d17e, Offset: 0xe5
// Size: 0x68
function function_d2b085a69cfb106b()
{
    level utility::registersharedfunc( #"zombie", #"hash_9390d4bfb2b44ab2", &function_eb037271d5fb2c78 );
    level utility::callsharedfunc( #"zm_blizzard", #"freeze_world" );
    level callback::add( "on_zombie_ai_spawned", &on_zombie_ai_spawned );
    level.var_cdca5e730e05bc39 = 1;
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace zm_relic_challenge_only_can_damage_indoors
// Params 0
// Checksum 0x89137cbc, Offset: 0x155
// Size: 0xf1
function function_e4748e1a155b35e6()
{
    level utility::clearsharedfunc( #"zombie", #"hash_9390d4bfb2b44ab2" );
    level utility::callsharedfunc( #"zm_blizzard", #"unfreeze_world" );
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
        iprintlnbold( "<dev string:x57>" );
    #/
}

// Namespace zm_relic_challenge_only_can_damage_indoors
// Params 1, eflags: 0x4
// Checksum 0xa5965852, Offset: 0x24e
// Size: 0x6a
function private function_eb037271d5fb2c78( dmg_struct )
{
    idamage = dmg_struct.idamage;
    player = dmg_struct.eattacker;
    
    if ( player && !ispointindoors( player.origin ) )
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

// Namespace zm_relic_challenge_only_can_damage_indoors
// Params 1, eflags: 0x4
// Checksum 0xa20f0268, Offset: 0x2c1
// Size: 0x13
function private on_zombie_ai_spawned( params )
{
    zm_relic_challenges::set_zombie_damage_invuln();
}

