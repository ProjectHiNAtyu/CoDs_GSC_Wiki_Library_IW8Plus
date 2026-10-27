// script_5f08d059d4b31062  (hash_5f08d059d4b31062.gscc) (size: 1758 Bytes / 0x6de / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8431009f (2217803935)
// size ...... 1758 (0x6de)
// includes .. 6   (offset: 0x686)
// strings ... 1   (offset: 0x6b6)
// dev strs .. 2   (offset: 0x6c6)
// exports ... 8   (offset: 0x2ea)
// cseg ...... 0x70 + 0x27a (0x2ea)
// imports ... 21  (offset: 0x42a)
// animtree1 . 0   (offset: 0x6de)
// animtree2 . 0   (offset: 0x6de)
#using scripts\common\ai\aitypes\shared\zombie\zombie_damage;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\relics\zm_relic_challenges;
#using scripts\mp\zm\zm_utility;

#namespace namespace_e227b6a192ff95c8;

// Namespace namespace_e227b6a192ff95c8
// Params 0, eflags: 0x5
// Checksum 0xf1011b64, Offset: 0x8e
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_819c987f501a0a47", undefined, &function_8e771d195d67bb07, undefined );
}

// Namespace namespace_e227b6a192ff95c8
// Params 0
// Checksum 0xdafaf5b1, Offset: 0xaf
// Size: 0xa
function function_8e771d195d67bb07()
{
    level thread function_c3a8b4e3354b013c();
}

// Namespace namespace_e227b6a192ff95c8
// Params 0
// Checksum 0x70fb8eff, Offset: 0xc1
// Size: 0x1c
function function_c3a8b4e3354b013c()
{
    zm_relic_challenges::register_relic_challenge_functions( #"hash_90b6522172a32e62", &function_832b879630f6c9b2, &function_9e8e254f41d24f1 );
}

// Namespace namespace_e227b6a192ff95c8
// Params 0
// Checksum 0xcf9367c5, Offset: 0xe5
// Size: 0x4e
function function_832b879630f6c9b2()
{
    level utility::registersharedfunc( #"zombie", #"hash_9390d4bfb2b44ab2", &function_eb037271d5fb2c78 );
    level callback::add( "on_zombie_ai_spawned", &on_zombie_ai_spawned );
    level.var_cdca5e730e05bc39 = 1;
    wait 1;
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace namespace_e227b6a192ff95c8
// Params 0
// Checksum 0xd6686d30, Offset: 0x13b
// Size: 0xd7
function function_9e8e254f41d24f1()
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
        iprintlnbold( "<dev string:x5f>" );
    #/
}

// Namespace namespace_e227b6a192ff95c8
// Params 1, eflags: 0x4
// Checksum 0x6c6f433a, Offset: 0x21a
// Size: 0xb4
function private function_eb037271d5fb2c78( dmg_struct )
{
    idamage = dmg_struct.idamage;
    player = dmg_struct.eattacker;
    element = zombie_damage::get_element( dmg_struct.objweapon, player, dmg_struct.smeansofdeath );
    
    if ( self.elementalweakness.size > 0 && !isdefined( self.elementalweakness[ element ] ) )
    {
        idamage *= 0;
        zm_relic_challenges::set_zombie_damage_invuln();
    }
    else if ( !self.elementalweakness.size > 0 )
    {
        zm_relic_challenges::function_908a1b8613e50514();
    }
    else
    {
        zm_relic_challenges::function_908a1b8613e50514();
    }
    
    return idamage;
}

// Namespace namespace_e227b6a192ff95c8
// Params 1, eflags: 0x4
// Checksum 0x432a5e88, Offset: 0x2d7
// Size: 0x13
function private on_zombie_ai_spawned( params )
{
    zm_relic_challenges::set_zombie_damage_invuln();
}

