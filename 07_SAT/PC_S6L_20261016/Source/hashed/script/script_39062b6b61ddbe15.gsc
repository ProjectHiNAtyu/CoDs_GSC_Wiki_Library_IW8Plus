// script_39062b6b61ddbe15  (hash_39062b6b61ddbe15.gscc) (size: 1764 Bytes / 0x6e4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7e96a360 (2123801440)
// size ...... 1764 (0x6e4)
// includes .. 5   (offset: 0x6a0)
// strings ... 0   (offset: 0x6c8)
// dev strs .. 2   (offset: 0x6c8)
// exports ... 8   (offset: 0x358)
// cseg ...... 0x58 + 0x300 (0x358)
// imports ... 17  (offset: 0x498)
// animtree1 . 0   (offset: 0x6e4)
// animtree2 . 0   (offset: 0x6e4)
#using script_2fe74ee229c972c3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;

#namespace skill_berzerker;

// Namespace skill_berzerker
// Params 0, eflags: 0x1
// Checksum 0x97e38d8, Offset: 0x76
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"berzerker", &init );
}

// Namespace skill_berzerker
// Params 0
// Checksum 0xe3478d0, Offset: 0x95
// Size: 0x3e
function init()
{
    utility::registersharedfunc( #"berzerker", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"berzerker", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_berzerker
// Params 1, eflags: 0x4
// Checksum 0xd4f605c7, Offset: 0xdb
// Size: 0x68, Type: bool
function private on_give_skill( skill_bundle )
{
    self.var_d397a3049141f0a5 = { #bundle:skill_bundle };
    zombie_utils::function_dfae6a5bd222c586( &function_17fdfda41f9aa95a );
    agent_utils::function_bc89b9076dd93902( &function_17fdfda41f9aa95a );
    
    if ( !callback::exists( #"hash_2346898712859996", &on_player_damaged_callback ) )
    {
        callback::add( #"hash_2346898712859996", &on_player_damaged_callback );
    }
    
    return true;
}

// Namespace skill_berzerker
// Params 1, eflags: 0x4
// Checksum 0xdfaf76d, Offset: 0x14c
// Size: 0x5a
function private function_c51f1692ecb73bfe( skill_bundle )
{
    zombie_utils::function_10c0c35c21e3ed9d( &function_17fdfda41f9aa95a );
    agent_utils::function_def5273cfe3c9109( &function_17fdfda41f9aa95a );
    
    if ( callback::exists( #"hash_2346898712859996", &on_player_damaged_callback ) )
    {
        callback::remove( #"hash_2346898712859996", &on_player_damaged_callback );
    }
    
    self.var_d397a3049141f0a5 = undefined;
}

// Namespace skill_berzerker
// Params 1, eflags: 0x4
// Checksum 0xc08f4b92, Offset: 0x1ae
// Size: 0x94
function private on_player_damaged_callback( params )
{
    var_da55798eb12048a0 = params.eattacker.var_d397a3049141f0a5;
    assert( var_da55798eb12048a0, "<dev string:x24>" );
    bundle = var_da55798eb12048a0.bundle;
    params.idamage = function_13ad81fc9fb7eeff( params.eattacker, params.idamage, bundle.var_7bc28909b7c8fac5 ?? 1, bundle.var_1da626aa47b8d6dd );
}

// Namespace skill_berzerker
// Params 1, eflags: 0x4
// Checksum 0xe2215ac6, Offset: 0x24a
// Size: 0x88
function private function_17fdfda41f9aa95a( params )
{
    var_da55798eb12048a0 = params.eattacker.var_d397a3049141f0a5;
    assert( var_da55798eb12048a0, "<dev string:x24>" );
    bundle = var_da55798eb12048a0.bundle;
    return function_13ad81fc9fb7eeff( params.eattacker, params.idamage, bundle.var_937aabe5779c425e ?? 1, bundle.var_1da626aa47b8d6dd );
}

// Namespace skill_berzerker
// Params 4, eflags: 0x4
// Checksum 0x9ec15bd6, Offset: 0x2db
// Size: 0x7c
function private function_13ad81fc9fb7eeff( player, damage, damage_multiplier, health_percent_activation )
{
    assert( isplayer( player ), "<dev string:x4d>" );
    
    if ( player.inlaststand )
    {
        return damage;
    }
    
    var_bfd9a1b518cc6aa6 = player.health / player.maxhealth;
    
    if ( health_percent_activation < var_bfd9a1b518cc6aa6 )
    {
        return damage;
    }
    
    return damage * damage_multiplier;
}

