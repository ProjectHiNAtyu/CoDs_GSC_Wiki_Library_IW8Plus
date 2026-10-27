// script_6c80f65b83c08ca1  (hash_6c80f65b83c08ca1.gscc) (size: 2110 Bytes / 0x83e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7eee429d (2129543837)
// size ...... 2110 (0x83e)
// includes .. 3   (offset: 0x7d2)
// strings ... 6   (offset: 0x7ea)
// dev strs .. 1   (offset: 0x832)
// exports ... 7   (offset: 0x4f6)
// cseg ...... 0xa3 + 0x453 (0x4f6)
// imports ... 16  (offset: 0x60e)
// animtree1 . 0   (offset: 0x83e)
// animtree2 . 0   (offset: 0x83e)
#using script_2498b7c75f1dee2d;
#using script_70fa7df687b2e3bf;
#using scripts\common\callbacks;

#namespace namespace_2164e9330c48a5e7;

// Namespace namespace_2164e9330c48a5e7
// Params 0, eflags: 0x1
// Checksum 0xbaa4675, Offset: 0xc1
// Size: 0x10
function autoexec init()
{
    level.var_2c037101e01c3dfb = &spawnerinit;
}

// Namespace namespace_2164e9330c48a5e7
// Params 0
// Checksum 0xf8a92f90, Offset: 0xd9
// Size: 0x38
function spawnerinit()
{
    callback::add( #"game_ended", &ongameended );
    namespace_3047dff6a502386b::function_96e8ad309c3d5340( &function_94675a95f6622579 );
    namespace_3047dff6a502386b::function_6c0fdc0c23f23397();
    namespace_775af9b7afedb6d1::init_scaling_health();
    thread function_9464570ccdf080fd();
}

// Namespace namespace_2164e9330c48a5e7
// Params 1
// Checksum 0x47874fe1, Offset: 0x119
// Size: 0x14
function ongameended( winner )
{
    level thread function_b58379410a8707a7();
}

// Namespace namespace_2164e9330c48a5e7
// Params 0
// Checksum 0x78a7b428, Offset: 0x135
// Size: 0xb4
function function_b58379410a8707a7()
{
    zombietypes = level.gametypebundle.var_fe48865e3fe54690;
    
    if ( !zombietypes )
    {
        return;
    }
    
    types = [];
    
    foreach ( zombie in zombietypes )
    {
        types[ types.size ] = zombie.zombietype;
    }
    
    namespace_3047dff6a502386b::function_95f8261172e0fceb( types );
}

// Namespace namespace_2164e9330c48a5e7
// Params 0
// Checksum 0x8c6ec71c, Offset: 0x1f1
// Size: 0x213
function function_9464570ccdf080fd()
{
    level endon( #"game_ended" );
    
    while ( level.var_c0691512e6403dce.size == 0 )
    {
        waitframe();
    }
    
    zombietypes = level.gametypebundle.var_fe48865e3fe54690;
    assert( zombietypes, "<dev string:x24>" );
    
    for ( i = 0; i < zombietypes.size ; i++ )
    {
        zombietypes[ i ].zombietype = getscriptbundle( zombietypes[ i ].zombietype ).name;
    }
    
    respawndelay = level.gametypebundle.var_39853aa5f80c2cb3 ?? 10;
    maxagents = getmatchrulesdata( "commonOption", "maxAgents" );
    maxzombies = level.gametypebundle.var_4d979a301974e907 ?? 10;
    
    if ( maxzombies > maxagents )
    {
        maxzombies = maxagents;
    }
    
    spawnsettings = { #var_583144a97cdaecf6:1, #awarenessradius:5000, #movespeedpriority:1, #movespeedid:"horde_spawn", #movespeed:level.gametypebundle.var_c9b3c8586414b258 ?? "sprint", #stealthenabled:0 };
    
    foreach ( zombie in zombietypes )
    {
        if ( zombie.density > 0 )
        {
            targetcount = int( zombie.density * maxzombies );
            level thread namespace_3047dff6a502386b::function_6d5b2d2dd94015f6( zombie.zombietype, targetcount, "axis", spawnsettings, respawndelay );
        }
    }
}

// Namespace namespace_2164e9330c48a5e7
// Params 1
// Checksum 0xae61d1f2, Offset: 0x40c
// Size: 0xea
function function_94675a95f6622579( params )
{
    attacker = params.eattacker;
    victim = self;
    damage = params.idamage;
    meansofdeath = params.smeansofdeath;
    
    if ( !attacker || !victim )
    {
        return;
    }
    
    if ( victim.owner && victim.owner.team == attacker.team )
    {
        params.idamage = 0;
        return;
    }
    
    if ( meansofdeath == "MOD_MELEE" )
    {
        if ( attacker.var_4a17c312a3e4a9f9 || attacker.var_4c85e0abc60e914a )
        {
            damage = victim.maxhealth;
        }
    }
    
    params.idamage = damage;
}

