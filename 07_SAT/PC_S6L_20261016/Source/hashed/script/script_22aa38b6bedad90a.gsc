// script_22aa38b6bedad90a  (hash_22aa38b6bedad90a.gscc) (size: 1396 Bytes / 0x574 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcae84714 (3404220180)
// size ...... 1396 (0x574)
// includes .. 5   (offset: 0x540)
// strings ... 1   (offset: 0x568)
// dev strs .. 0   (offset: 0x574)
// exports ... 7   (offset: 0x2d4)
// cseg ...... 0x64 + 0x270 (0x2d4)
// imports ... 12  (offset: 0x3ec)
// animtree1 . 0   (offset: 0x574)
// animtree2 . 0   (offset: 0x574)
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\rewards\reward_cache_settings;
#using scripts\mp\loot\common_cache;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_objective_rewards;

#namespace ob_activity_rewards;

// Namespace ob_activity_rewards
// Params 1
// Checksum 0x5f80ee7d, Offset: 0x82
// Size: 0x66
function ob_openlootablecontainer( relevantparameters )
{
    grouprewardcache = relevantparameters.cache;
    player = relevantparameters.player;
    
    if ( !isdefined( grouprewardcache ) )
    {
        return;
    }
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    grouprewardcache.minimumslots = function_c1e5e2430937d1dc( grouprewardcache );
    common_cache::openlootablecontainer( grouprewardcache, player );
}

// Namespace ob_activity_rewards
// Params 1
// Checksum 0x83b65ce9, Offset: 0xf0
// Size: 0x7a
function function_d5422be66a10dac0( relevantinfostruct )
{
    currentopener = relevantinfostruct.currentopener;
    
    if ( !isplayer( currentopener ) )
    {
        return;
    }
    
    lootid = relevantinfostruct.lootid;
    quantity = relevantinfostruct.quantity;
    containerindex = relevantinfostruct.containerindex;
    common_cache::function_25bee1f5701a0786( currentopener, containerindex, lootid, quantity );
}

// Namespace ob_activity_rewards
// Params 1
// Checksum 0x73d1581, Offset: 0x172
// Size: 0xa6
function function_91481a82c41f9021( relevantinfostruct )
{
    activityinstance = self;
    category = activity_instance_common::getactivitycategory( activityinstance );
    
    if ( category == "Contract" )
    {
        var_c8ded34eca00f0b9 = spawnstruct();
        var_c8ded34eca00f0b9.difficulty_region = activityinstance namespace_34bb2a33b8502c64::function_978e3550d9f0313f();
        var_c8ded34eca00f0b9.activity_instance = activityinstance;
        var_c8ded34eca00f0b9.reward_group = relevantinfostruct.reward_group;
        cache = spawnstruct();
        var_c8ded34eca00f0b9 namespace_34bb2a33b8502c64::function_f87ed5526b8f404e( cache );
        return cache.contents;
    }
    
    return [];
}

// Namespace ob_activity_rewards
// Params 3
// Checksum 0x3f1d8506, Offset: 0x220
// Size: 0x44
function function_f23d5e30cd73e104( origin, var_c786523ebe9c85c0, var_e9aeea7e0ebb0b56 )
{
    return reward_cache_placement_struct::function_5e18091e9e0bd7e0( origin, ( 0, 0, 0 ), var_c786523ebe9c85c0 ?? 0, var_e9aeea7e0ebb0b56 ?? 100, 22, 36 );
}

// Namespace ob_activity_rewards
// Params 1, eflags: 0x4
// Checksum 0xbcf62b51, Offset: 0x26d
// Size: 0x22
function private function_c1e5e2430937d1dc( grouprewardcache )
{
    return int( max( grouprewardcache.contents.size, 4 ) );
}

// Namespace ob_activity_rewards
// Params 1, eflags: 0x4
// Checksum 0x3eb403a3, Offset: 0x298
// Size: 0x3c
function private function_1d36ad9a59be4525( activityinstance )
{
    var_880b2b26b9114f94 = namespace_4a69edc3725e741::function_b6096bc924663393( activityinstance );
    
    if ( var_880b2b26b9114f94.size > 0 )
    {
        var_ca21418e617c2723 = var_880b2b26b9114f94[ 0 ];
        return var_ca21418e617c2723;
    }
    
    return;
}

