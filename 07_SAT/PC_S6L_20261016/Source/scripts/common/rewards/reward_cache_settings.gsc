// scripts\common\rewards\reward_cache_settings.gsc  (hash_4db4e7f305ce5a21.gscc) (size: 4764 Bytes / 0x129c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x95ee67d1 (2515429329)
// size ...... 4764 (0x129c)
// includes .. 2   (offset: 0x1264)
// strings ... 0   (offset: 0x1274)
// dev strs .. 3   (offset: 0x1274)
// exports ... 34  (offset: 0x970)
// cseg ...... 0x58 + 0x918 (0x970)
// imports ... 33  (offset: 0xec0)
// animtree1 . 0   (offset: 0x129c)
// animtree2 . 0   (offset: 0x129c)
#using script_159e727e83aed322;
#using scripts\common\rewards\reward_cache;

#namespace reward_cache_settings;

// Namespace reward_cache_settings
// Params 1
// Checksum 0x2cd699cb, Offset: 0x76
// Size: 0x51
function function_30b01f7700d12b96( bundlename )
{
    bundlestruct = getscriptbundle( hashcat( %"rewardcache:", bundlename ) );
    
    if ( !isdefined( bundlestruct ) )
    {
        assertmsg( "<dev string:x24>" + bundlename + "<dev string:x45>" );
        return;
    }
    
    return function_5bf529a4289db099( bundlestruct );
}

// Namespace reward_cache_settings
// Params 1
// Checksum 0xf6505b3, Offset: 0xd0
// Size: 0xa5
function function_5bf529a4289db099( bundlestruct )
{
    var_799e7804a717e759 = bundle_rewardcache::function_e260208d36d45f87( bundlestruct );
    interactionpointscriptablename = bundle_rewardcache::function_23fc4be9b3177424( bundlestruct );
    lootcachescriptablename = bundle_rewardcache::function_37b8aee93c29abec( bundlestruct );
    var_94132b2c5008d349 = reward_cache::function_74471f8245ac348c( var_799e7804a717e759, 0 );
    var_8b555827f1fb0bf0 = reward_cache::function_74471f8245ac348c( interactionpointscriptablename, 1 );
    var_41001281e434e29a = reward_cache::function_74471f8245ac348c( lootcachescriptablename, 2 );
    struct = function_86b3b63e156acaf7( bundle_rewardcache::function_9b30144f35838d02( bundlestruct ), bundle_rewardcache::function_d5b246809c38148a( bundlestruct ), var_94132b2c5008d349, var_8b555827f1fb0bf0, var_41001281e434e29a );
    return struct;
}

// Namespace reward_cache_settings
// Params 5
// Checksum 0xf1b27922, Offset: 0x17e
// Size: 0xa1
function function_86b3b63e156acaf7( objectivemarkerbundlename, objectivemarkerzoffset, var_94132b2c5008d349, var_8b555827f1fb0bf0, var_41001281e434e29a )
{
    struct = spawnstruct();
    struct.var_ed9af280ad7bd97c = 1;
    struct.objectivemarkerbundlename = objectivemarkerbundlename;
    struct.objectivemarkerzoffset = objectivemarkerzoffset;
    struct.var_94132b2c5008d349 = var_94132b2c5008d349;
    struct.var_8b555827f1fb0bf0 = var_8b555827f1fb0bf0;
    struct.var_41001281e434e29a = var_41001281e434e29a;
    struct.var_e8df3d15a9262e76 = undefined;
    return struct;
}

// Namespace reward_cache_settings
// Params 1
// Checksum 0xcf6ce97a, Offset: 0x228
// Size: 0x1e
function getobjectivemarkerbundlename( rewardcachesettings )
{
    if ( isdefined( rewardcachesettings ) )
    {
        return rewardcachesettings.objectivemarkerbundlename;
    }
}

// Namespace reward_cache_settings
// Params 1
// Checksum 0x2a4737d1, Offset: 0x24f
// Size: 0x1e
function function_951d16c76d05ac34( rewardcachesettings )
{
    if ( isdefined( rewardcachesettings ) )
    {
        return rewardcachesettings.objectivemarkerzoffset;
    }
}

// Namespace reward_cache_settings
// Params 1
// Checksum 0x269a9542, Offset: 0x276
// Size: 0x1e
function function_d5a2c090a6cf9fdd( rewardcachesettings )
{
    if ( isdefined( rewardcachesettings ) )
    {
        return rewardcachesettings.var_94132b2c5008d349;
    }
}

// Namespace reward_cache_settings
// Params 1
// Checksum 0x47f97fe5, Offset: 0x29d
// Size: 0x1e
function function_6c5d8e4be0979384( rewardcachesettings )
{
    if ( isdefined( rewardcachesettings ) )
    {
        return rewardcachesettings.var_8b555827f1fb0bf0;
    }
}

// Namespace reward_cache_settings
// Params 1
// Checksum 0xc2525c08, Offset: 0x2c4
// Size: 0x1e
function function_94deaff283e30496( rewardcachesettings )
{
    if ( isdefined( rewardcachesettings ) )
    {
        return rewardcachesettings.var_41001281e434e29a;
    }
}

// Namespace reward_cache_settings
// Params 1
// Checksum 0x39aaaf6, Offset: 0x2eb
// Size: 0x1e
function function_bf5102d23412c9fa( rewardcachesettings )
{
    if ( isdefined( rewardcachesettings ) )
    {
        return rewardcachesettings.var_e8df3d15a9262e76;
    }
}

// Namespace reward_cache_settings
// Params 2
// Checksum 0x98a1d89c, Offset: 0x312
// Size: 0x29
function function_d1085ce094e377e( rewardcachesettings, boolvaluetoset )
{
    if ( isdefined( rewardcachesettings ) )
    {
        rewardcachesettings.var_e8df3d15a9262e76 = boolvaluetoset;
    }
}

#namespace namespace_15dfbdeb8b2ff6b9;

// Namespace namespace_15dfbdeb8b2ff6b9
// Params 1
// Checksum 0x8a0a78c3, Offset: 0x343
// Size: 0x51
function function_73b34e1d8c583b0d( bundlename )
{
    bundlestruct = getscriptbundle( hashcat( %"hash_2ad645e0d0c60ba7", bundlename ) );
    
    if ( !isdefined( bundlestruct ) )
    {
        assertmsg( "<dev string:x5a>" + bundlename + "<dev string:x45>" );
        return;
    }
    
    return function_7d96f9640c446bd3( bundlestruct );
}

// Namespace namespace_15dfbdeb8b2ff6b9
// Params 2
// Checksum 0x6fccbada, Offset: 0x39d
// Size: 0x5b
function function_7d96f9640c446bd3( bundlestruct_rewardcachebehavior, var_e2ea97666fd35a94 )
{
    struct = function_604c70eb43095f69( bundle_rewardcachebehavior::function_a5de17fb37fe8a9e( bundlestruct_rewardcachebehavior ), bundle_rewardcachebehavior::function_f831b0d8640be65b( bundlestruct_rewardcachebehavior ), bundle_rewardcachebehavior::function_f276f67dab4c31a3( bundlestruct_rewardcachebehavior ), bundle_rewardcachebehavior::function_eaca57655e891af6( bundlestruct_rewardcachebehavior ), bundle_rewardcachebehavior::function_a37a850d9f190f59( bundlestruct_rewardcachebehavior ), bundle_rewardcachebehavior::function_f06d205ee72b25bc( bundlestruct_rewardcachebehavior ), var_e2ea97666fd35a94 );
    return struct;
}

// Namespace namespace_15dfbdeb8b2ff6b9
// Params 7
// Checksum 0xe287486, Offset: 0x401
// Size: 0xcd
function function_604c70eb43095f69( despawndistance, despawntimerseconds, despawntriggerdelayseconds, despawnwhenempty, objectivemarkervisibilitydistance, spawndelayseconds, var_e2ea97666fd35a94 = 1 )
{
    struct = spawnstruct();
    struct.var_3a206bc82beee5c6 = 1;
    struct.despawndistance = despawndistance;
    struct.despawntimerseconds = despawntimerseconds;
    struct.despawntriggerdelayseconds = despawntriggerdelayseconds;
    struct.despawnwhenempty = despawnwhenempty;
    struct.objectivemarkervisibilitydistance = objectivemarkervisibilitydistance;
    struct.spawndelayseconds = spawndelayseconds;
    
    if ( var_e2ea97666fd35a94 )
    {
        function_66dbba235a7147ab( struct );
    }
    
    return struct;
}

// Namespace namespace_15dfbdeb8b2ff6b9
// Params 1
// Checksum 0x59f06250, Offset: 0x4d7
// Size: 0x1e
function getdespawndistance( rewardcachebehaviorsettings )
{
    if ( isdefined( rewardcachebehaviorsettings ) )
    {
        return rewardcachebehaviorsettings.despawndistance;
    }
}

// Namespace namespace_15dfbdeb8b2ff6b9
// Params 1
// Checksum 0xd97648cc, Offset: 0x4fe
// Size: 0x1e
function function_3b032208530a328e( rewardcachebehaviorsettings )
{
    if ( isdefined( rewardcachebehaviorsettings ) )
    {
        return rewardcachebehaviorsettings.despawntimerseconds;
    }
}

// Namespace namespace_15dfbdeb8b2ff6b9
// Params 1
// Checksum 0xe7fdd0c8, Offset: 0x525
// Size: 0x1e
function function_5934560c8b643240( rewardcachebehaviorsettings )
{
    if ( isdefined( rewardcachebehaviorsettings ) )
    {
        return rewardcachebehaviorsettings.despawntriggerdelayseconds;
    }
}

// Namespace namespace_15dfbdeb8b2ff6b9
// Params 1
// Checksum 0x45f17186, Offset: 0x54c
// Size: 0x1e
function function_1ea817783d320429( rewardcachebehaviorsettings )
{
    if ( isdefined( rewardcachebehaviorsettings ) )
    {
        return rewardcachebehaviorsettings.despawnwhenempty;
    }
}

// Namespace namespace_15dfbdeb8b2ff6b9
// Params 1
// Checksum 0x107e6e39, Offset: 0x573
// Size: 0x1e
function function_5874e3ceb9d44ec4( rewardcachebehaviorsettings )
{
    if ( isdefined( rewardcachebehaviorsettings ) )
    {
        return rewardcachebehaviorsettings.objectivemarkervisibilitydistance;
    }
}

// Namespace namespace_15dfbdeb8b2ff6b9
// Params 1
// Checksum 0x74e1ccf2, Offset: 0x59a
// Size: 0x1e
function getspawndelayseconds( rewardcachebehaviorsettings )
{
    if ( isdefined( rewardcachebehaviorsettings ) )
    {
        return rewardcachebehaviorsettings.spawndelayseconds;
    }
}

// Namespace namespace_15dfbdeb8b2ff6b9
// Params 1, eflags: 0x4
// Checksum 0x2f0d3211, Offset: 0x5c1
// Size: 0x42
function private function_66dbba235a7147ab( rewardcachebehaviorsettings )
{
    function_5fe14c0b36daa65e( rewardcachebehaviorsettings );
    function_a49156cde5c1e01b( rewardcachebehaviorsettings );
    function_97dc74024c9ccd63( rewardcachebehaviorsettings );
    function_d1042df75203f5b6( rewardcachebehaviorsettings );
    function_73dc2eb031fe3219( rewardcachebehaviorsettings );
    function_3901a07ff65fd77c( rewardcachebehaviorsettings );
}

// Namespace namespace_15dfbdeb8b2ff6b9
// Params 1, eflags: 0x4
// Checksum 0x7e8c2024, Offset: 0x60b
// Size: 0x43
function private function_73dc2eb031fe3219( rewardcachebehaviorsettings )
{
    objectivemarkervisibilitydistance = function_5874e3ceb9d44ec4( rewardcachebehaviorsettings );
    validationcondition = objectivemarkervisibilitydistance > 0;
    
    if ( !validationcondition )
    {
        rewardcachebehaviorsettings.objectivemarkervisibilitydistance = 7500;
    }
}

// Namespace namespace_15dfbdeb8b2ff6b9
// Params 1, eflags: 0x4
// Checksum 0x7ba60780, Offset: 0x656
// Size: 0x45
function private function_97dc74024c9ccd63( rewardcachebehaviorsettings )
{
    despawntriggerdelayseconds = rewardcachebehaviorsettings.despawntriggerdelayseconds;
    validationcondition = despawntriggerdelayseconds >= 0;
    
    if ( !validationcondition )
    {
        rewardcachebehaviorsettings.despawntriggerdelayseconds = 5;
    }
}

// Namespace namespace_15dfbdeb8b2ff6b9
// Params 1, eflags: 0x4
// Checksum 0x147fc662, Offset: 0x6a3
// Size: 0x43
function private function_d1042df75203f5b6( rewardcachebehaviorsettings )
{
    despawnwhenempty = rewardcachebehaviorsettings.despawnwhenempty;
    validationcondition = isdefined( despawnwhenempty );
    
    if ( !validationcondition )
    {
        rewardcachebehaviorsettings.despawnwhenempty = 0;
    }
}

// Namespace namespace_15dfbdeb8b2ff6b9
// Params 1, eflags: 0x4
// Checksum 0x57a3e55b, Offset: 0x6ee
// Size: 0x44
function private function_a49156cde5c1e01b( rewardcachebehaviorsettings )
{
    despawntimerseconds = rewardcachebehaviorsettings.despawntimerseconds;
    validationcondition = isdefined( despawntimerseconds );
    
    if ( !validationcondition )
    {
        rewardcachebehaviorsettings.despawntimerseconds = 180;
    }
}

// Namespace namespace_15dfbdeb8b2ff6b9
// Params 1, eflags: 0x4
// Checksum 0xa30fb4a9, Offset: 0x73a
// Size: 0x46
function private function_5fe14c0b36daa65e( rewardcachebehaviorsettings )
{
    despawndistance = rewardcachebehaviorsettings.despawndistance;
    validationcondition = despawndistance > 0;
    
    if ( !validationcondition )
    {
        rewardcachebehaviorsettings.despawndistance = 12500;
    }
}

// Namespace namespace_15dfbdeb8b2ff6b9
// Params 1, eflags: 0x4
// Checksum 0x8f5dcdb8, Offset: 0x788
// Size: 0x44
function private function_3901a07ff65fd77c( rewardcachebehaviorsettings )
{
    spawndelayseconds = rewardcachebehaviorsettings.spawndelayseconds;
    validationcondition = spawndelayseconds >= 0;
    
    if ( !validationcondition )
    {
        rewardcachebehaviorsettings.spawndelayseconds = 0;
    }
}

#namespace reward_cache_placement_struct;

// Namespace reward_cache_placement_struct
// Params 6
// Checksum 0xcec07cbd, Offset: 0x7d4
// Size: 0xb1
function function_5e18091e9e0bd7e0( origin, angles, var_c786523ebe9c85c0, var_e9aeea7e0ebb0b56, var_f83c775d5ca290e7, var_b4cc49efb805e0ad )
{
    struct = spawnstruct();
    struct.origin = origin;
    struct.angles = angles;
    struct.var_c786523ebe9c85c0 = var_c786523ebe9c85c0 ?? 0;
    struct.var_e9aeea7e0ebb0b56 = var_e9aeea7e0ebb0b56 ?? 100;
    struct.var_f83c775d5ca290e7 = var_f83c775d5ca290e7 ?? 1;
    struct.var_b4cc49efb805e0ad = var_b4cc49efb805e0ad ?? 0;
    return struct;
}

// Namespace reward_cache_placement_struct
// Params 1
// Checksum 0xd2c48a0e, Offset: 0x88e
// Size: 0x1e
function getplacementorigin( rewardcacheplacementstruct )
{
    if ( isdefined( rewardcacheplacementstruct ) )
    {
        return rewardcacheplacementstruct.origin;
    }
}

// Namespace reward_cache_placement_struct
// Params 1
// Checksum 0xd2c48a0e, Offset: 0x8b5
// Size: 0x1e
function function_a8eeb78f35811f89( rewardcacheplacementstruct )
{
    if ( isdefined( rewardcacheplacementstruct ) )
    {
        return rewardcacheplacementstruct.angles;
    }
}

// Namespace reward_cache_placement_struct
// Params 1
// Checksum 0xf67e97f7, Offset: 0x8dc
// Size: 0x1e
function function_b1657d4dc2601384( rewardcacheplacementstruct )
{
    if ( isdefined( rewardcacheplacementstruct ) )
    {
        return rewardcacheplacementstruct.var_c786523ebe9c85c0;
    }
}

// Namespace reward_cache_placement_struct
// Params 1
// Checksum 0x53f1a9e9, Offset: 0x903
// Size: 0x1e
function function_ddb9d24a4c20769e( rewardcacheplacementstruct )
{
    if ( isdefined( rewardcacheplacementstruct ) )
    {
        return rewardcacheplacementstruct.var_e9aeea7e0ebb0b56;
    }
}

// Namespace reward_cache_placement_struct
// Params 1
// Checksum 0xa4d826f7, Offset: 0x92a
// Size: 0x1e
function function_12c151c4aad6a1af( rewardcacheplacementstruct )
{
    if ( isdefined( rewardcacheplacementstruct ) )
    {
        return rewardcacheplacementstruct.var_f83c775d5ca290e7;
    }
}

// Namespace reward_cache_placement_struct
// Params 1
// Checksum 0xf6a2e256, Offset: 0x951
// Size: 0x1e
function function_da4e4df9e44f22a5( rewardcacheplacementstruct )
{
    if ( isdefined( rewardcacheplacementstruct ) )
    {
        return rewardcacheplacementstruct.var_b4cc49efb805e0ad;
    }
}

