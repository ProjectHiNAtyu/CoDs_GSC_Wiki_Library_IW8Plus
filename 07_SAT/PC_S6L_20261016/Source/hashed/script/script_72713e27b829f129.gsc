// script_72713e27b829f129  (hash_72713e27b829f129.gscc) (size: 1285 Bytes / 0x505 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2896e59c (680977820)
// size ...... 1285 (0x505)
// includes .. 4   (offset: 0x4c9)
// strings ... 2   (offset: 0x4e9)
// dev strs .. 0   (offset: 0x505)
// exports ... 7   (offset: 0x295)
// cseg ...... 0x83 + 0x212 (0x295)
// imports ... 10  (offset: 0x3ad)
// animtree1 . 0   (offset: 0x505)
// animtree2 . 0   (offset: 0x505)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\damage;

#namespace specialty_melee_damage_mod;

// Namespace specialty_melee_damage_mod
// Params 0, eflags: 0x1
// Checksum 0x59b2ef54, Offset: 0xa1
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_melee_damage_mod
// Params 1
// Checksum 0x28ecdeff, Offset: 0xc1
// Size: 0x6e
function registerspecialty( params )
{
    if ( params.var_bf34439fc0ca3cec )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_melee_damage_mod", &setspecialty, &unsetspecialty );
    }
    
    damage::function_3232791951a34daf( &function_965672de7aad19cb );
    agent_utils::register_soldier_damage_callback( &function_6d838cba69719615 );
    utility::registersharedfunc( #"zombie_damage", #"hash_7b7e42eb24435073", &function_6d838cba69719615 );
}

// Namespace specialty_melee_damage_mod
// Params 0
// Checksum 0xa0d83a3a, Offset: 0x137
// Size: 0x1e
function setspecialty()
{
    self.var_2ed733cb8503d95 = self.var_9842326056fd7207.var_2ed733cb8503d95;
}

// Namespace specialty_melee_damage_mod
// Params 0
// Checksum 0x736d985c, Offset: 0x15d
// Size: 0xc
function unsetspecialty()
{
    self.var_2ed733cb8503d95 = undefined;
}

// Namespace specialty_melee_damage_mod
// Params 11
// Checksum 0xf5ef2760, Offset: 0x171
// Size: 0x91
function function_965672de7aad19cb( eattacker, einflictor, victim, idamage, objweapon, smeansofdeath, shitloc, idflags, var_cdd29ad5d1362c2, partname, unmodifieddamage )
{
    if ( smeansofdeath == "MOD_MELEE" && eattacker.var_2ed733cb8503d95 )
    {
        return ( idamage * eattacker.var_2ed733cb8503d95 );
    }
    
    return idamage;
}

// Namespace specialty_melee_damage_mod
// Params 1, eflags: 0x4
// Checksum 0xbefe7cd, Offset: 0x20b
// Size: 0x89
function private function_6d838cba69719615( params )
{
    if ( isdefined( params.objweapon ) && isplayer( params.eattacker ) && params.smeansofdeath == "MOD_MELEE" && params.eattacker.var_2ed733cb8503d95 )
    {
        return ( params.idamage * params.eattacker.var_2ed733cb8503d95 );
    }
    
    return params.idamage;
}

