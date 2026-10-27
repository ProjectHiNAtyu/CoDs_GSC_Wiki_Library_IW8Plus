// scripts\common\activity_nexus\activity_reward_cache_settings.gsc  (hash_02838bf44b7dbfea.gscc) (size: 1659 Bytes / 0x67b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfd1f16d9 (4246673113)
// size ...... 1659 (0x67b)
// includes .. 2   (offset: 0x66b)
// strings ... 0   (offset: 0x67b)
// dev strs .. 0   (offset: 0x67b)
// exports ... 12  (offset: 0x31f)
// cseg ...... 0x58 + 0x2c7 (0x31f)
// imports ... 13  (offset: 0x4ff)
// animtree1 . 0   (offset: 0x67b)
// animtree2 . 0   (offset: 0x67b)
#using script_1f139695c61f1549;
#using scripts\common\rewards\reward_cache_settings;

#namespace activity_reward_cache_settings;

// Namespace activity_reward_cache_settings
// Params 1
// Checksum 0xb75ebace, Offset: 0x76
// Size: 0x58
function function_f9ff18532030ae0c( var_548228027aad4e18 )
{
    struct = function_b8a68c7670d035c( namespace_548228027aad4e18::function_9cb4a154d3957d83( var_548228027aad4e18 ), namespace_548228027aad4e18::function_15f3f29887361cad( var_548228027aad4e18 ), namespace_548228027aad4e18::function_21cd9567e49d3263( var_548228027aad4e18 ), namespace_548228027aad4e18::function_834a856f1f56abad( var_548228027aad4e18 ), namespace_548228027aad4e18::function_9355d86d3e5d7b2( var_548228027aad4e18 ), namespace_548228027aad4e18::function_cd1c6dd1f011d236( var_548228027aad4e18 ), namespace_548228027aad4e18::function_d94eefd0faaae460( var_548228027aad4e18 ) );
    return struct;
}

// Namespace activity_reward_cache_settings
// Params 7
// Checksum 0x151b037c, Offset: 0xd7
// Size: 0xc4
function function_b8a68c7670d035c( rewardcacheassetname, var_4b2c3f9949122eea, perplayerloot, rewardgrouptype, rewardspawnlocationtype, spawnactivationname, spawnactivitymoment )
{
    struct = spawnstruct();
    struct.var_7094b689487b3a5b = 1;
    struct.rewardcacheassetname = rewardcacheassetname;
    struct.var_4b2c3f9949122eea = var_4b2c3f9949122eea;
    struct.perplayerloot = perplayerloot;
    struct.rewardgrouptype = rewardgrouptype;
    struct.rewardspawnlocationtype = rewardspawnlocationtype;
    struct.spawnactivationname = spawnactivationname;
    struct.spawnactivitymoment = spawnactivitymoment;
    return struct;
}

// Namespace activity_reward_cache_settings
// Params 1
// Checksum 0xbab8f4c0, Offset: 0x1a4
// Size: 0x1e
function function_945a03612b4457d0( var_88529cdf3789377f )
{
    if ( isdefined( var_88529cdf3789377f ) )
    {
        return var_88529cdf3789377f.rewardcacheassetname;
    }
}

// Namespace activity_reward_cache_settings
// Params 1
// Checksum 0x4e7b9c1f, Offset: 0x1cb
// Size: 0x1e
function function_7fcd1ec586dcd6da( var_88529cdf3789377f )
{
    if ( isdefined( var_88529cdf3789377f ) )
    {
        return var_88529cdf3789377f.var_4b2c3f9949122eea;
    }
}

// Namespace activity_reward_cache_settings
// Params 1
// Checksum 0x8970a3f3, Offset: 0x1f2
// Size: 0x1e
function getperplayerloot( var_88529cdf3789377f )
{
    if ( isdefined( var_88529cdf3789377f ) )
    {
        return var_88529cdf3789377f.perplayerloot;
    }
}

// Namespace activity_reward_cache_settings
// Params 1
// Checksum 0xe05ba27a, Offset: 0x219
// Size: 0x1e
function getrewardgrouptype( var_88529cdf3789377f )
{
    if ( isdefined( var_88529cdf3789377f ) )
    {
        return var_88529cdf3789377f.rewardgrouptype;
    }
}

// Namespace activity_reward_cache_settings
// Params 1
// Checksum 0x31fb6de0, Offset: 0x240
// Size: 0x1e
function function_fa83b236c4585c07( var_88529cdf3789377f )
{
    if ( isdefined( var_88529cdf3789377f ) )
    {
        return var_88529cdf3789377f.rewardspawnlocationtype;
    }
}

// Namespace activity_reward_cache_settings
// Params 1
// Checksum 0x1b2f2af, Offset: 0x267
// Size: 0x1e
function function_9c94783f98618d1a( var_88529cdf3789377f )
{
    if ( isdefined( var_88529cdf3789377f ) )
    {
        return var_88529cdf3789377f.spawnactivationname;
    }
}

// Namespace activity_reward_cache_settings
// Params 1
// Checksum 0xa62c58a7, Offset: 0x28e
// Size: 0x1e
function function_f35099b22ace34c( var_88529cdf3789377f )
{
    if ( isdefined( var_88529cdf3789377f ) )
    {
        return var_88529cdf3789377f.spawnactivitymoment;
    }
}

// Namespace activity_reward_cache_settings
// Params 1
// Checksum 0xfe1f3a14, Offset: 0x2b5
// Size: 0x30
function function_673370ae370746f7( var_88529cdf3789377f )
{
    rewardcachebundlename = function_945a03612b4457d0( var_88529cdf3789377f );
    
    if ( !isdefined( rewardcachebundlename ) )
    {
        return;
    }
    
    return reward_cache_settings::function_30b01f7700d12b96( rewardcachebundlename );
}

// Namespace activity_reward_cache_settings
// Params 1
// Checksum 0x1e614f8b, Offset: 0x2ee
// Size: 0x30
function function_c1dc1aba345d5b69( var_88529cdf3789377f )
{
    var_a06b95284bc4fd0c = function_7fcd1ec586dcd6da( var_88529cdf3789377f );
    
    if ( !isdefined( var_a06b95284bc4fd0c ) )
    {
        return;
    }
    
    return namespace_15dfbdeb8b2ff6b9::function_73b34e1d8c583b0d( var_a06b95284bc4fd0c );
}

