// scripts\mp\damage_effects_cp_mp.gsc  (hash_10935834bdfafc78.gscc) (size: 696 Bytes / 0x2b8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3c904224 (1016087076)
// size ...... 696 (0x2b8)
// includes .. 5   (offset: 0x290)
// strings ... 0   (offset: 0x2b8)
// dev strs .. 0   (offset: 0x2b8)
// exports ... 3   (offset: 0x110)
// cseg ...... 0x58 + 0xb8 (0x110)
// imports ... 9   (offset: 0x188)
// animtree1 . 0   (offset: 0x2b8)
// animtree2 . 0   (offset: 0x2b8)
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\mp\armor;
#using scripts\mp\operator;
#using scripts\mp\playerhealth;

#namespace damage_effects_cp_mp;

// Namespace damage_effects_cp_mp
// Params 0
// Checksum 0x705b8c78, Offset: 0x76
// Size: 0x89
function init()
{
    damage_effects::init( &damage_effects::function_772d325bd6c693c, &damage_effects::function_bf2875d2fd55a5a );
    utility::registersharedfunc( #"damage_effects", #"isfemale", &operator::isfemale );
    utility::registersharedfunc( #"damage_effects", #"hasarmor", &armor::hasarmor );
    utility::registersharedfunc( #"damage_effects", #"hash_5be2154f8714fc82", &playerhealth::function_77704251ecdece64 );
    utility::registersharedfunc( #"damage_effects", #"hash_f93ac0b4812ca397", &visionsetnakedforplayer );
}

// Namespace damage_effects_cp_mp
// Params 0
// Checksum 0x7d709787, Offset: 0x107
// Size: 0x9
function initdamageeffects()
{
    damage_effects::initdamageeffects();
}

