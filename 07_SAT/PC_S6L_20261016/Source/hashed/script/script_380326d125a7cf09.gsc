// script_380326d125a7cf09  (hash_380326d125a7cf09.gscc) (size: 2322 Bytes / 0x912 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb3099695 (3003750037)
// size ...... 2322 (0x912)
// includes .. 6   (offset: 0x8e2)
// strings ... 0   (offset: 0x912)
// dev strs .. 0   (offset: 0x912)
// exports ... 9   (offset: 0x4a2)
// cseg ...... 0x58 + 0x44a (0x4a2)
// imports ... 25  (offset: 0x60a)
// animtree1 . 0   (offset: 0x912)
// animtree2 . 0   (offset: 0x912)
#using script_2fe74ee229c972c3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\common\utility\damage_utility;

#namespace skill_blindside;

// Namespace skill_blindside
// Params 0, eflags: 0x1
// Checksum 0x46e089a3, Offset: 0x76
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"blindside", &init );
}

// Namespace skill_blindside
// Params 0
// Checksum 0x7836bb84, Offset: 0x95
// Size: 0x3e
function init()
{
    utility::registersharedfunc( #"blindside", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"blindside", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_blindside
// Params 1, eflags: 0x4
// Checksum 0x18462200, Offset: 0xdb
// Size: 0x50, Type: bool
function private on_give_skill( skill_bundle )
{
    self.var_3e62534cfb89b109 = { #bundle:skill_bundle };
    zombie_utils::function_dfae6a5bd222c586( &function_17fdfda41f9aa95a );
    agent_utils::function_bc89b9076dd93902( &function_17fdfda41f9aa95a );
    callback::add( #"hash_2346898712859996", &on_player_damaged_callback );
    return true;
}

// Namespace skill_blindside
// Params 1, eflags: 0x4
// Checksum 0x30a91dfe, Offset: 0x134
// Size: 0xa7
function private on_player_damaged_callback( params )
{
    valid_shot = damage_utility::validshotcheck( params.smeansofdeath, params.eattacker );
    is_critical = damage_utility::isheadshot( params.shitloc, params.smeansofdeath, params.eattacker, valid_shot );
    params.idamage = params.victim function_53cb5df58d60a6( params.eattacker, params.idamage, is_critical, params.vdamagedir );
}

// Namespace skill_blindside
// Params 1, eflags: 0x4
// Checksum 0x1fede177, Offset: 0x1e3
// Size: 0x3e
function private function_17fdfda41f9aa95a( params )
{
    return function_53cb5df58d60a6( params.eattacker, params.idamage, params.biscritical, params.vdir );
}

// Namespace skill_blindside
// Params 4, eflags: 0x4
// Checksum 0x6fa99bb7, Offset: 0x22a
// Size: 0x155
function private function_53cb5df58d60a6( attacker, damage, is_critical, damage_dir )
{
    if ( !damage_dir )
    {
        return damage;
    }
    
    assert( isplayer( attacker ) );
    bundle = attacker.var_3e62534cfb89b109.bundle;
    original_contexts = callback::response( 6, #"hash_70c49d15a6f8da89" );
    
    if ( original_contexts.size )
    {
        foreach ( context in original_contexts )
        {
            var_cb9750b87adf8ac7 = damage_utility::function_96098e54715671d3( context.originaldir, context.originalangles, bundle.var_9d7545a9786d1210 );
            
            if ( var_cb9750b87adf8ac7 )
            {
                break;
            }
        }
    }
    else
    {
        var_cb9750b87adf8ac7 = damage_utility::function_96098e54715671d3( damage_dir, self.angles, bundle.var_9d7545a9786d1210 );
    }
    
    if ( var_cb9750b87adf8ac7 )
    {
        return function_1151d81e79215477( attacker, damage, bundle, is_critical );
    }
    
    return damage;
}

// Namespace skill_blindside
// Params 4, eflags: 0x4
// Checksum 0x2f05e377, Offset: 0x388
// Size: 0xb7
function private function_1151d81e79215477( attacker, damage, bundle, is_critical )
{
    critical_and_full = self.health == self.maxhealth && is_critical;
    
    if ( isplayer( self ) )
    {
        multiplier = critical_and_full ? bundle.var_35761cc9761ee24b ?? 1 : bundle.var_b4ffa6ab3fa76439 ?? 1;
    }
    else
    {
        multiplier = critical_and_full ? bundle.var_c3926072cd28d724 ?? 1 : bundle.var_98f11a27bf15461e ?? 1;
    }
    
    return damage * multiplier;
}

// Namespace skill_blindside
// Params 1, eflags: 0x4
// Checksum 0x1011f176, Offset: 0x448
// Size: 0x5a
function private function_c51f1692ecb73bfe( skill_bundle )
{
    zombie_utils::function_10c0c35c21e3ed9d( &function_17fdfda41f9aa95a );
    agent_utils::function_def5273cfe3c9109( &function_17fdfda41f9aa95a );
    
    if ( callback::exists( #"hash_2346898712859996", &on_player_damaged_callback ) )
    {
        callback::remove( #"hash_2346898712859996", &on_player_damaged_callback );
    }
    
    self.var_3e62534cfb89b109 = undefined;
}

