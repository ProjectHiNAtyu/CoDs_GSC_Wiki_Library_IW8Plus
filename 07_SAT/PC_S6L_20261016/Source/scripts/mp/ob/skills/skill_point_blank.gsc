// scripts\mp\ob\skills\skill_point_blank.gsc  (hash_594065beb89a840a.gscc) (size: 1910 Bytes / 0x776 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6994fe83 (1771372163)
// size ...... 1910 (0x776)
// includes .. 7   (offset: 0x722)
// strings ... 1   (offset: 0x75a)
// dev strs .. 1   (offset: 0x76a)
// exports ... 7   (offset: 0x3aa)
// cseg ...... 0x66 + 0x344 (0x3aa)
// imports ... 20  (offset: 0x4c2)
// animtree1 . 0   (offset: 0x776)
// animtree2 . 0   (offset: 0x776)
#using script_2fe74ee229c972c3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\events;

#namespace skill_point_blank;

// Namespace skill_point_blank
// Params 0, eflags: 0x1
// Checksum 0x44096858, Offset: 0x84
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"point_blank", &init );
}

// Namespace skill_point_blank
// Params 0
// Checksum 0x75f08ec7, Offset: 0xa3
// Size: 0x3e
function init()
{
    utility::registersharedfunc( #"point_blank", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"point_blank", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_point_blank
// Params 1, eflags: 0x4
// Checksum 0xe775447c, Offset: 0xe9
// Size: 0x93, Type: bool
function private on_give_skill( skill_bundle )
{
    assert( skill_bundle.var_316e22d5e6fbb966, "<dev string:x24>" );
    self.var_929fb50d57b0f4bb = { #bundle:skill_bundle };
    agent_utils::function_bc89b9076dd93902( &function_17fdfda41f9aa95a );
    zombie_utils::function_dfae6a5bd222c586( &function_17fdfda41f9aa95a );
    
    if ( skill_bundle.var_57f6dbfd78bda511 )
    {
        assert( !callback::exists( #"hash_2346898712859996", &function_6108cf3368c55e03 ) );
        callback::add( #"hash_2346898712859996", &function_6108cf3368c55e03 );
    }
    
    return true;
}

// Namespace skill_point_blank
// Params 1, eflags: 0x4
// Checksum 0x9401d1e, Offset: 0x185
// Size: 0x6d
function private function_c51f1692ecb73bfe( skill_bundle )
{
    if ( skill_bundle.var_57f6dbfd78bda511 )
    {
        assert( callback::exists( #"hash_2346898712859996", &function_6108cf3368c55e03 ) );
        callback::remove( #"hash_2346898712859996", &function_6108cf3368c55e03 );
    }
    
    agent_utils::function_def5273cfe3c9109( &function_17fdfda41f9aa95a );
    zombie_utils::function_10c0c35c21e3ed9d( &function_17fdfda41f9aa95a );
    self.var_929fb50d57b0f4bb = undefined;
}

// Namespace skill_point_blank
// Params 1, eflags: 0x4
// Checksum 0x9228375f, Offset: 0x1fa
// Size: 0xbe
function private function_17fdfda41f9aa95a( params )
{
    attacker = params.eattacker;
    assert( isplayer( attacker ) );
    damage_multiplier = attacker.var_929fb50d57b0f4bb.bundle.var_316e22d5e6fbb966;
    shot_type = events::getshotdistancetype( attacker, params.objweapon, params.smeansofdeath, attacker.origin, self.origin );
    current_damage = params.idamage;
    
    if ( shot_type == "pointblank" )
    {
        current_damage *= damage_multiplier;
    }
    
    return current_damage;
}

// Namespace skill_point_blank
// Params 1, eflags: 0x4
// Checksum 0x1e5e8397, Offset: 0x2c1
// Size: 0xe9
function private function_6108cf3368c55e03( params )
{
    attacker = params.eattacker;
    assert( isplayer( attacker ) );
    victim = params.victim;
    
    if ( player_utility::isfriendly( victim.team, attacker ) )
    {
        return;
    }
    
    damage_multiplier = attacker.var_929fb50d57b0f4bb.bundle.var_57f6dbfd78bda511;
    shot_type = events::getshotdistancetype( attacker, params.objweapon, params.smeansofdeath, attacker.origin, victim.origin );
    
    if ( shot_type == "pointblank" )
    {
        params.idamage *= damage_multiplier;
    }
}

