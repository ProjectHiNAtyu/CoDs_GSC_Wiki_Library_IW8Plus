// script_6d60a2f06878900a  (hash_6d60a2f06878900a.gscc) (size: 5950 Bytes / 0x173e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7bf94837 (2079934519)
// size ...... 5950 (0x173e)
// includes .. 7   (offset: 0x1636)
// strings ... 7   (offset: 0x166e)
// dev strs .. 10  (offset: 0x16c6)
// exports ... 21  (offset: 0xd46)
// cseg ...... 0x105 + 0xc41 (0xd46)
// imports ... 48  (offset: 0x108e)
// animtree1 . 0   (offset: 0x173e)
// animtree2 . 0   (offset: 0x173e)
#using script_1f139695c61f1549;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_reward_cache_settings;
#using scripts\common\rewards\managed_reward_cache;
#using scripts\common\rewards\reward_cache_settings;

#namespace activity_rewards;

// Namespace activity_rewards
// Params 4
// Checksum 0xee2a18d7, Offset: 0x123
// Size: 0xe2
function function_a1243aea0ef35dd9( activityinstance, activitymoment, var_14d3c6aa1c479f1e, rewardstructoverride )
{
    assert( isdefined( activitymoment ) );
    assert( isdefined( activityinstance ) );
    var_fc3b6deb224be83b = function_d94a5424dba80682( activityinstance, activitymoment, var_14d3c6aa1c479f1e );
    assert( isdefined( var_fc3b6deb224be83b ) );
    
    foreach ( var_548228027aad4e18 in var_fc3b6deb224be83b )
    {
        var_88529cdf3789377f = activity_reward_cache_settings::function_f9ff18532030ae0c( var_548228027aad4e18 );
        function_8f63df8c390c6a2c( activityinstance, var_88529cdf3789377f, rewardstructoverride );
    }
}

// Namespace activity_rewards
// Params 3
// Checksum 0xafe2456, Offset: 0x20d
// Size: 0xe2
function function_8f63df8c390c6a2c( activityinstance, var_88529cdf3789377f, rewardstructoverride )
{
    rewardcachesettings = activity_reward_cache_settings::function_673370ae370746f7( var_88529cdf3789377f );
    rewardcachebehaviorsettings = activity_reward_cache_settings::function_c1dc1aba345d5b69( var_88529cdf3789377f );
    playerrewardgroups = function_b793d4d1a0d17570( activityinstance, var_88529cdf3789377f );
    rewardspawnlocation = rewardstructoverride ?? function_fdbc2b10df0a1eec( activityinstance, var_88529cdf3789377f );
    openlootablecontainerfunction = &function_ef319aeac2e5cbe;
    lootfunction = &function_b164be198374d294;
    lootfunctionargs = function_52e780f2892dc8c8( activityinstance );
    onitemtakenfunction = undefined;
    onitemaddedfunction = undefined;
    var_4a8ccb832c0d4a8 = spawnstruct();
    thread function_b44e08b6ef8d57ec( activityinstance, var_4a8ccb832c0d4a8 );
    managed_reward_cache::function_62e1e9e8ae541941( rewardcachesettings, rewardcachebehaviorsettings, playerrewardgroups, rewardspawnlocation, openlootablecontainerfunction, lootfunction, lootfunctionargs, onitemtakenfunction, onitemaddedfunction, var_4a8ccb832c0d4a8 );
}

// Namespace activity_rewards
// Params 3
// Checksum 0xd85916f7, Offset: 0x2f7
// Size: 0x56
function function_19aa7c79ee51d3d5( activityinstance, rewardgrouptype, perplayerloot )
{
    relevantinfostruct = spawnstruct();
    relevantinfostruct.rewardgrouptype = rewardgrouptype;
    relevantinfostruct.perplayerloot = perplayerloot;
    return activity_common::runactivityfunction( activityinstance, 6, relevantinfostruct );
}

// Namespace activity_rewards
// Params 2
// Checksum 0x6cfbf059, Offset: 0x356
// Size: 0x45
function function_b793d4d1a0d17570( activityinstance, var_88529cdf3789377f )
{
    rewardgrouptype = activity_reward_cache_settings::getrewardgrouptype( var_88529cdf3789377f );
    perplayerloot = activity_reward_cache_settings::getperplayerloot( var_88529cdf3789377f );
    return function_19aa7c79ee51d3d5( activityinstance, rewardgrouptype, perplayerloot );
}

// Namespace activity_rewards
// Params 2
// Checksum 0xa8ca9e3a, Offset: 0x3a4
// Size: 0x115
function function_ed272537390fd69e( activityinstance, rewardspawnlocationtype )
{
    relevantinfostruct = spawnstruct();
    relevantinfostruct.rewardspawnlocationtype = rewardspawnlocationtype;
    var_34a7c20640a74f0 = [];
    var_7b24d7b335d7f93e = activity_common::function_460fd843724fc9b1( activityinstance.type, 5 );
    
    if ( var_7b24d7b335d7f93e )
    {
        var_34a7c20640a74f0 = activity_common::runactivityfunction( activityinstance, 5, relevantinfostruct );
        
        if ( !isarray( var_34a7c20640a74f0 ) )
        {
            var_34a7c20640a74f0 = [ var_34a7c20640a74f0 ];
        }
        
        if ( isdefined( var_34a7c20640a74f0[ 0 ].origin ) && isdefined( var_34a7c20640a74f0[ 0 ].angles ) )
        {
            return var_34a7c20640a74f0[ 0 ];
        }
        
        assert( isdefined( var_34a7c20640a74f0[ 0 ].origin ), "<dev string:x24>" );
        assert( isdefined( var_34a7c20640a74f0[ 0 ].angles ), "<dev string:x7c>" );
        assertmsg( "<dev string:xd4>" );
    }
    else if ( rewardspawnlocationtype == "FunctionOverride" && !var_7b24d7b335d7f93e )
    {
        assertmsg( "<dev string:x1a4>" );
    }
    
    return activityinstance function_6d27add3b696f678( relevantinfostruct );
}

// Namespace activity_rewards
// Params 2
// Checksum 0x7909c0fb, Offset: 0x4c2
// Size: 0x32
function function_fdbc2b10df0a1eec( activityinstance, var_88529cdf3789377f )
{
    rewardspawnlocationtype = activity_reward_cache_settings::function_fa83b236c4585c07( var_88529cdf3789377f );
    return function_ed272537390fd69e( activityinstance, rewardspawnlocationtype );
}

// Namespace activity_rewards
// Params 1
// Checksum 0xefc039ed, Offset: 0x4fd
// Size: 0x33
function function_ef319aeac2e5cbe( argstruct )
{
    if ( activity_common::function_e9bc8a898f05077d( 9 ) )
    {
        activity_common::function_2ba08ba0c0544a1a( 9, argstruct, 0 );
        return;
    }
    
    assertmsg( "<dev string:x25e>" );
}

// Namespace activity_rewards
// Params 1
// Checksum 0xcfbfc96f, Offset: 0x538
// Size: 0xa2
function function_6d27add3b696f678( relevantinfostruct )
{
    activityinstance = self;
    var_33eb9ef7f002a82 = ( 0, 0, 0 );
    var_38b7acc5e1c5dd00 = ( 0, 0, 0 );
    rewardstructs = function_4695b849b6007a6d( activityinstance );
    
    if ( rewardstructs.size > 0 )
    {
        rewardstruct = rewardstructs[ 0 ];
        var_33eb9ef7f002a82 = rewardstruct.origin;
        var_38b7acc5e1c5dd00 = rewardstruct.angles;
    }
    else
    {
        var_33eb9ef7f002a82 = activity_instance_common::function_776ee11e7acc64a5( activityinstance );
    }
    
    return reward_cache_placement_struct::function_5e18091e9e0bd7e0( var_33eb9ef7f002a82, var_38b7acc5e1c5dd00, undefined, undefined, undefined, undefined );
}

// Namespace activity_rewards
// Params 1
// Checksum 0x6ddfcbe2, Offset: 0x5e3
// Size: 0x131
function function_4695b849b6007a6d( activityinstance )
{
    rewardstructs = [];
    activityvariantname = activityinstance.varianttag;
    
    for ( variantscriptstructinfo = activity_common::function_d54f02a6971bb9ab( activityvariantname ); isdefined( variantscriptstructinfo ) ; variantscriptstructinfo = undefined )
    {
        variantstruct = variantscriptstructinfo.variantstruct;
        linkedstructs = variantscriptstructinfo.linkedstructs;
        
        foreach ( linkedstruct in linkedstructs )
        {
            var_ff905734abf13669 = linkedstruct.targetname === "activity_nexus_instance_reward";
            
            if ( var_ff905734abf13669 )
            {
                rewardstructs[ rewardstructs.size ] = linkedstruct;
            }
        }
        
        parentactivityvariantname = variantstruct.parent;
        
        if ( isstring( parentactivityvariantname ) )
        {
            variantscriptstructinfo = activity_common::function_d54f02a6971bb9ab( parentactivityvariantname );
            continue;
        }
    }
    
    return rewardstructs;
}

// Namespace activity_rewards
// Params 1, eflags: 0x4
// Checksum 0xa63cee11, Offset: 0x71d
// Size: 0x9a
function private function_b164be198374d294( lootfunctionargs )
{
    assert( isstruct( lootfunctionargs ) && isdefined( lootfunctionargs.activity_instance ) );
    activityinstance = lootfunctionargs.activity_instance;
    relevantinfostruct = lootfunctionargs;
    var_a0f05682f112d967 = activity_common::function_c18ae2ea1e9c715a( 7 );
    
    if ( activity_common::function_460fd843724fc9b1( activityinstance.type, 7 ) || isfunction( var_a0f05682f112d967 ) )
    {
        return activity_common::runactivityfunction( activityinstance, 7, relevantinfostruct );
    }
    
    assertmsg( "<dev string:x30c>" );
    return [];
}

// Namespace activity_rewards
// Params 1
// Checksum 0xdb2e511b, Offset: 0x7c0
// Size: 0x8c
function getrewardgroups( relevantinfostruct )
{
    assert( isdefined( relevantinfostruct ), "<dev string:x42b>" );
    activityinstance = self;
    rewardgrouptype = relevantinfostruct.rewardgrouptype;
    perplayerloot = relevantinfostruct.perplayerloot;
    assert( isdefined( rewardgrouptype ) );
    assert( isdefined( perplayerloot ) );
    rewardgroups = function_a556b204230fb1d2( activityinstance, rewardgrouptype );
    
    if ( perplayerloot )
    {
        return function_72d2d86277318d67( rewardgroups );
    }
    
    return rewardgroups;
}

// Namespace activity_rewards
// Params 1, eflags: 0x4
// Checksum 0x31feb737, Offset: 0x855
// Size: 0xf6
function private function_72d2d86277318d67( rewardgroups )
{
    perplayerrewardgroups = [];
    
    foreach ( rewardgroup in rewardgroups )
    {
        foreach ( player in rewardgroup )
        {
            perplayerrewardgroups[ perplayerrewardgroups.size ] = [ player ];
        }
    }
    
    return perplayerrewardgroups;
}

// Namespace activity_rewards
// Params 2, eflags: 0x4
// Checksum 0xe63bbad, Offset: 0x954
// Size: 0xab
function private function_a556b204230fb1d2( activityinstance, rewardgrouptype )
{
    var_86737cbe11bf496e = activityinstance.var_86737cbe11bf496e ?? [];
    playerrewardgroups = [];
    
    switch ( rewardgrouptype )
    {
        case #"hash_172e3a33f45b462e":
            assert( isdefined( var_86737cbe11bf496e ) );
            playerrewardgroups = [ var_86737cbe11bf496e ];
            break;
        case #"hash_89ee46feec0f25b9":
            assertmsg( "<dev string:x4b2>" );
            break;
        default:
            assertmsg( "<dev string:x539>" + rewardgrouptype + "<dev string:x54a>" );
            break;
    }
    
    return playerrewardgroups;
}

// Namespace activity_rewards
// Params 3
// Checksum 0xbc8b3080, Offset: 0xa08
// Size: 0x39, Type: bool
function function_37f06bd4c02411fb( activityinstance, activitymoment, var_14d3c6aa1c479f1e )
{
    var_951ee12063406129 = function_d94a5424dba80682( activityinstance, activitymoment, var_14d3c6aa1c479f1e );
    return var_951ee12063406129.size > 0;
}

// Namespace activity_rewards
// Params 3, eflags: 0x4
// Checksum 0x1b526e20, Offset: 0xa4a
// Size: 0x6a, Type: bool
function private function_d94a5424dba80682( activityinstance, activitymoment, var_14d3c6aa1c479f1e )
{
    if ( !isdefined( activityinstance.var_b99d0304e471ada ) )
    {
        function_33d8d051b9881281( activityinstance );
    }
    
    mapkey = function_71e5271e5c38ba32( activitymoment, var_14d3c6aa1c479f1e );
    var_951ee12063406129 = activityinstance.var_b99d0304e471ada[ mapkey ];
    return var_951ee12063406129 ?? [];
}

// Namespace activity_rewards
// Params 2, eflags: 0x4
// Checksum 0x14e6ab33, Offset: 0xabd
// Size: 0x24
function private function_71e5271e5c38ba32( activitymoment, var_14d3c6aa1c479f1e )
{
    return isdefined( var_14d3c6aa1c479f1e ) ? activitymoment + var_14d3c6aa1c479f1e : activitymoment;
}

// Namespace activity_rewards
// Params 1, eflags: 0x4
// Checksum 0xa6af3ac7, Offset: 0xaea
// Size: 0x127
function private function_33d8d051b9881281( activityinstance )
{
    if ( !isdefined( activityinstance.var_48c2202698ec0bc9 ) )
    {
        activityinstance.var_b99d0304e471ada = [];
    }
    
    var_29b041c6cefd658 = function_df566c54ecb01b03( activityinstance );
    
    foreach ( bundlestruct in var_29b041c6cefd658 )
    {
        cacheactivitymoment = namespace_548228027aad4e18::function_d94eefd0faaae460( bundlestruct );
        cacheactivationname = namespace_548228027aad4e18::function_cd1c6dd1f011d236( bundlestruct );
        mapkey = function_71e5271e5c38ba32( cacheactivitymoment, cacheactivationname );
        
        if ( !isdefined( activityinstance.var_b99d0304e471ada[ mapkey ] ) )
        {
            activityinstance.var_b99d0304e471ada[ mapkey ] = [];
        }
        
        numelements = activityinstance.var_b99d0304e471ada[ mapkey ].size;
        activityinstance.var_b99d0304e471ada[ mapkey ][ numelements ] = bundlestruct;
    }
}

// Namespace activity_rewards
// Params 1, eflags: 0x4
// Checksum 0xd71349fa, Offset: 0xc19
// Size: 0x91
function private function_df566c54ecb01b03( activityinstance )
{
    var_761525ac1f9b6c7 = activity_common::function_bfafd481c8062532();
    var_b2862aaf9e3c1d12 = var_761525ac1f9b6c7.var_91cc064b6ec8a6c;
    activitycategory = activityinstance.category;
    var_581d9909185f139 = var_761525ac1f9b6c7.var_3d3e562ecf5625f8;
    var_b0e805f4bf0c627c = var_581d9909185f139[ activitycategory ];
    var_5bcdb48884b2e38d = activity_definition_utils::function_65cbe62d5b3c2c15( activityinstance );
    var_cb5afed83b152a6c = arraycombine( var_b2862aaf9e3c1d12, var_b0e805f4bf0c627c, var_5bcdb48884b2e38d );
    return var_cb5afed83b152a6c;
}

// Namespace activity_rewards
// Params 1, eflags: 0x4
// Checksum 0xd1c179c3, Offset: 0xcb3
// Size: 0x37
function private function_52e780f2892dc8c8( activityinstance )
{
    lootfunctionargs = spawnstruct();
    lootfunctionargs.activity_instance = activityinstance;
    lootfunctionargs.reward_group = undefined;
    return lootfunctionargs;
}

// Namespace activity_rewards
// Params 2, eflags: 0x4
// Checksum 0x6fa5caec, Offset: 0xcf3
// Size: 0x53
function private function_b44e08b6ef8d57ec( activityinstance, var_4a8ccb832c0d4a8 )
{
    activity_instance_common::function_a1d94c2267cba15( activityinstance, "Any", "Cleanup", "REWARD CACHE SPAWN", "REWARD CACHE SPAWN START" );
    var_4a8ccb832c0d4a8 waittill( #"hash_db90bb68b59b48ea" );
    activity_instance_common::function_3e3a340f4b0f8f1e( activityinstance, "REWARD CACHE SPAWN", "REWARD CACHE SPAWN DONE" );
}

