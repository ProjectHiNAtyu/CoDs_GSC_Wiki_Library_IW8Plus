// script_73de011fe26f0314  (hash_73de011fe26f0314.gscc) (size: 1267 Bytes / 0x4f3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc8aef9d6 (3366910422)
// size ...... 1267 (0x4f3)
// includes .. 4   (offset: 0x4d3)
// strings ... 0   (offset: 0x4f3)
// dev strs .. 0   (offset: 0x4f3)
// exports ... 8   (offset: 0x257)
// cseg ...... 0x58 + 0x1ff (0x257)
// imports ... 11  (offset: 0x397)
// animtree1 . 0   (offset: 0x4f3)
// animtree2 . 0   (offset: 0x4f3)
#using script_2fe74ee229c972c3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\supers;

#namespace skill_active_camo_upgrade;

// Namespace skill_active_camo_upgrade
// Params 0, eflags: 0x1
// Checksum 0x48e8336a, Offset: 0x76
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"active_camo_upgrade", &init );
}

// Namespace skill_active_camo_upgrade
// Params 0
// Checksum 0x938f6cb1, Offset: 0x95
// Size: 0x72
function init()
{
    utility::registersharedfunc( #"active_camo_upgrade", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"active_camo_upgrade", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    utility::registersharedfunc( #"super_active_camo", #"hash_57df9ea72261e1db", &function_2833dc25872d5a7a );
    level callback::add( #"on_ai_killed", &agent_killed );
}

// Namespace skill_active_camo_upgrade
// Params 1, eflags: 0x4
// Checksum 0xc1aaeb8b, Offset: 0x10f
// Size: 0x23, Type: bool
function private on_give_skill( skill_bundle )
{
    self.var_9cc47cb28e52bc38 = { #bundle:skill_bundle };
    return true;
}

// Namespace skill_active_camo_upgrade
// Params 1, eflags: 0x4
// Checksum 0x625a2315, Offset: 0x13b
// Size: 0x16
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self.var_9cc47cb28e52bc38 = undefined;
}

// Namespace skill_active_camo_upgrade
// Params 1, eflags: 0x4
// Checksum 0x938f3797, Offset: 0x159
// Size: 0x81
function private agent_killed( params )
{
    attacker = params.eattacker;
    
    if ( !attacker )
    {
        return;
    }
    
    if ( !attacker function_7aa1d58079de29b6() )
    {
        return;
    }
    
    smeansofdeath = params.smeansofdeath;
    
    if ( !utility::ismeleedamage( smeansofdeath ) )
    {
        return;
    }
    
    attacker supers_mp::function_9f116b8da4a01a94( attacker.var_9cc47cb28e52bc38.bundle.var_fa639eaddd49e1c );
}

// Namespace skill_active_camo_upgrade
// Params 0, eflags: 0x4
// Checksum 0x80d3f405, Offset: 0x1e2
// Size: 0x21, Type: bool
function private function_7aa1d58079de29b6()
{
    return self.var_9cc47cb28e52bc38.bundle.var_fa639eaddd49e1c > 0;
}

// Namespace skill_active_camo_upgrade
// Params 0, eflags: 0x4
// Checksum 0x52fe8589, Offset: 0x20c
// Size: 0x4a
function private function_2833dc25872d5a7a()
{
    bundle = self.var_9cc47cb28e52bc38.bundle;
    return { #duration:bundle.var_21b8a3682b6c5c42, #multiplier:bundle.var_b4c33710cfa82791 };
}

