// scripts\common\rewards\reward_cache.gsc  (hash_7a5f832593a7dde9.gscc) (size: 23205 Bytes / 0x5aa5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xada6b829 (2913384489)
// size ...... 23205 (0x5aa5)
// includes .. 4   (offset: 0x59bd)
// strings ... 13  (offset: 0x59dd)
// dev strs .. 2   (offset: 0x5a8d)
// exports ... 103 (offset: 0x3865)
// cseg ...... 0x165 + 0x3700 (0x3865)
// imports ... 137 (offset: 0x487d)
// animtree1 . 0   (offset: 0x5aa5)
// animtree2 . 0   (offset: 0x5aa5)
#using script_7c98336d01c2aba2;
#using scripts\common\logging\playtest_logger;
#using scripts\common\rewards\reward_cache_settings;
#using scripts\common\utility;

#namespace reward_cache;

// Namespace reward_cache
// Params 9
// Checksum 0x4959af13, Offset: 0x183
// Size: 0xf1
function spawnrewardcache( rewardcachesettings, playergroups, placementstruct, func_openlootablecontainer, var_c74a1c6030ca10fb, lootfunctionargs, func_oncacheitemtaken, func_onitemadded, var_baee98df379448aa )
{
    if ( getdvarint( @"hash_f5047643143a3941", 0 ) == 1 )
    {
        thread function_e16bb8976ec7fe45( rewardcachesettings, playergroups, placementstruct, func_openlootablecontainer, var_c74a1c6030ca10fb, lootfunctionargs, func_oncacheitemtaken, func_onitemadded, var_baee98df379448aa );
        return;
    }
    
    var_ef09a9be7f01976c = function_a3e4363d792640b2( rewardcachesettings, playergroups, placementstruct, func_openlootablecontainer, var_c74a1c6030ca10fb, lootfunctionargs, func_oncacheitemtaken, func_onitemadded, var_baee98df379448aa );
    
    if ( !var_ef09a9be7f01976c.success )
    {
        function_1c06ff6d60be6001( var_baee98df379448aa, 1 );
        return;
    }
    
    lootfunctionargs = var_ef09a9be7f01976c.lootfunctionargs;
    func_oncacheitemtaken = var_ef09a9be7f01976c.func_oncacheitemtaken;
    func_onitemadded = var_ef09a9be7f01976c.func_onitemadded;
    thread function_76b3d44f0bbcffd2( rewardcachesettings, playergroups, placementstruct, func_openlootablecontainer, var_c74a1c6030ca10fb, lootfunctionargs, func_oncacheitemtaken, func_onitemadded, var_baee98df379448aa );
}

// Namespace reward_cache
// Params 1
// Checksum 0x9577a78f, Offset: 0x27c
// Size: 0x15
function cleanuprewardcache( rewardcache )
{
    function_7ef3bbc623a6e650( rewardcache );
}

// Namespace reward_cache
// Params 3
// Checksum 0x65bfa964, Offset: 0x299
// Size: 0x69
function function_ded16316ebf40799( rewardcache, player, lootcontents )
{
    if ( !isrewardcache( rewardcache ) )
    {
        return;
    }
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( !function_81f8943696835ec1( lootcontents ) )
    {
        return;
    }
    
    grouprewardcache = function_f05326172cca58de( rewardcache, player );
    
    if ( isdefined( grouprewardcache ) )
    {
        function_397a0c8637e0a76e( grouprewardcache, lootcontents );
        return;
    }
}

// Namespace reward_cache
// Params 2
// Checksum 0xa27e39b9, Offset: 0x30b
// Size: 0x58
function function_1b634f56af4b2c30( rewardcache, player )
{
    if ( !isrewardcache( rewardcache ) )
    {
        return -1;
    }
    
    if ( !isplayer( player ) )
    {
        return -1;
    }
    
    grouprewardcache = function_f05326172cca58de( rewardcache, player );
    
    if ( !isdefined( grouprewardcache ) )
    {
        return -1;
    }
    
    return function_8609f043ae55ffc2( grouprewardcache );
}

// Namespace reward_cache
// Params 4
// Checksum 0xda227483, Offset: 0x36c
// Size: 0xcd
function function_8cb9542d8aedb5f7( rewardcache, player, reservedslotindex, item )
{
    if ( !isrewardcache( rewardcache ) )
    {
        return;
    }
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( !isint( reservedslotindex ) )
    {
        return;
    }
    
    if ( !function_81f8943696835ec1( [ item ] ) )
    {
        return;
    }
    
    grouprewardcache = function_f05326172cca58de( rewardcache, player );
    
    if ( !isdefined( grouprewardcache ) )
    {
        return;
    }
    
    if ( reservedslotindex >= grouprewardcache.contents.size )
    {
        return;
    }
    
    reserveditem = grouprewardcache.contents[ reservedslotindex ];
    
    if ( !reserveditem.var_e0f603cef9c13396 )
    {
        return;
    }
    
    item.var_e0f603cef9c13396 = 1;
    function_c200ccd981bab5b8( grouprewardcache, item, reservedslotindex );
}

// Namespace reward_cache
// Params 1
// Checksum 0x42a368a5, Offset: 0x441
// Size: 0x21, Type: bool
function isrewardcache( rewardcache )
{
    return isstruct( rewardcache ) && rewardcache.isrewardcache;
}

// Namespace reward_cache
// Params 1
// Checksum 0xabb35e70, Offset: 0x46b
// Size: 0xd2
function function_5ce279fad829a1be( grouprewardcache )
{
    rewardcache = grouprewardcache.rewardcacheowner;
    nonplayerfound = 0;
    
    foreach ( player in grouprewardcache.playerowners )
    {
        if ( isplayer( player ) )
        {
            function_9941143ad738972c( rewardcache, player, 2 );
            function_647bdbd451e6dd83( rewardcache, player );
            continue;
        }
        
        nonplayerfound = 1;
    }
    
    if ( nonplayerfound )
    {
        function_6c5a222c320939f0( rewardcache );
    }
}

// Namespace reward_cache
// Params 1
// Checksum 0xb53b8fb7, Offset: 0x545
// Size: 0x87
function function_68e0647bec178162( rewardcache )
{
    foreach ( grouprewardcache in rewardcache.grouprewardcaches )
    {
        function_5ce279fad829a1be( grouprewardcache );
    }
}

// Namespace reward_cache
// Params 6
// Checksum 0xec9dc0ef, Offset: 0x5d4
// Size: 0x81
function function_b7a770407e22d02( instance, part, state, player, bautouse, usestring )
{
    if ( !instance.var_b676e2b705962337 )
    {
        return;
    }
    
    interactionpoint = instance;
    rewardcache = interactionpoint.rewardcacheowner;
    assert( isdefined( rewardcache ) );
    _rewardcache_openlootablecontainer( rewardcache, player );
}

// Namespace reward_cache
// Params 2
// Checksum 0xc9e56dee, Offset: 0x65d
// Size: 0x1f
function function_83a7eac64f333f2( rewardcache, connectedplayer )
{
    function_9de5c30001201a72( rewardcache, connectedplayer );
}

// Namespace reward_cache
// Params 2
// Checksum 0xb73dc169, Offset: 0x684
// Size: 0x19e
function function_e4abcad98e325366( rewardcache, disconnectedplayer )
{
    if ( !arraycontains( rewardcache.playerowners, disconnectedplayer ) )
    {
        return;
    }
    
    function_65c370b8bece4ff1( rewardcache, disconnectedplayer );
    function_7060dadfd7f8d412( rewardcache, disconnectedplayer );
    
    foreach ( grouprewardcache in rewardcache.grouprewardcaches )
    {
        if ( arraycontains( grouprewardcache.playerowners, disconnectedplayer ) )
        {
            grouprewardcache.playerowners = arrayremove( grouprewardcache.playerowners, disconnectedplayer );
        }
    }
    
    var_ac8b30ccc7c1ab98 = [];
    var_b586bc31ad506f91 = undefined;
    
    foreach ( var_708d5b426571b631 in rewardcache.var_f895f5051913d326 )
    {
        if ( var_708d5b426571b631.playerowner == disconnectedplayer )
        {
            var_b586bc31ad506f91 = var_708d5b426571b631;
            continue;
        }
        
        var_ac8b30ccc7c1ab98[ var_ac8b30ccc7c1ab98.size ] = var_708d5b426571b631;
    }
    
    rewardcache.var_f895f5051913d326 = var_ac8b30ccc7c1ab98;
    function_b8a9778f565e4e68( var_b586bc31ad506f91 );
}

// Namespace reward_cache
// Params 1
// Checksum 0x94565185, Offset: 0x82a
// Size: 0xce
function function_6c5a222c320939f0( rewardcache )
{
    function_db2babe45c6fd2c4( rewardcache );
    var_ac8b30ccc7c1ab98 = [];
    var_b586bc31ad506f91 = undefined;
    
    foreach ( var_708d5b426571b631 in rewardcache.var_f895f5051913d326 )
    {
        if ( !isdefined( var_708d5b426571b631.playerowner ) )
        {
            function_b8a9778f565e4e68( var_b586bc31ad506f91 );
            continue;
        }
        
        var_ac8b30ccc7c1ab98[ var_ac8b30ccc7c1ab98.size ] = var_708d5b426571b631;
    }
    
    rewardcache.var_f895f5051913d326 = var_ac8b30ccc7c1ab98;
}

// Namespace reward_cache
// Params 2
// Checksum 0x68e22e6c, Offset: 0x900
// Size: 0x9e
function function_f05326172cca58de( rewardcache, player )
{
    foreach ( grouprewardcache in rewardcache.grouprewardcaches )
    {
        if ( arraycontains( grouprewardcache.playerowners, player ) )
        {
            return grouprewardcache;
        }
    }
}

// Namespace reward_cache
// Params 1
// Checksum 0xd92744b0, Offset: 0x9a7
// Size: 0x8e, Type: bool
function isempty( rewardcache )
{
    foreach ( grouprewardcache in rewardcache.grouprewardcaches )
    {
        if ( !grouprewardcache_isempty( grouprewardcache ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace reward_cache
// Params 1
// Checksum 0x87de2bbc, Offset: 0xa3e
// Size: 0xad, Type: bool
function grouprewardcache_isempty( grouprewardcache )
{
    contents = grouprewardcache.contents ?? [];
    items_remaining = 0;
    
    foreach ( item in contents )
    {
        items_remaining += item.quantity;
    }
    
    return items_remaining == 0;
}

// Namespace reward_cache
// Params 1
// Checksum 0x3c0fc73a, Offset: 0xaf4
// Size: 0x21
function function_f4cf6bc9ebcdf5ea( rewardcache )
{
    return rewardcache.interactionpoint.origin;
}

// Namespace reward_cache
// Params 1
// Checksum 0x3c0fc73a, Offset: 0xb1e
// Size: 0x21
function function_e9f4bcef0aa0d128( rewardcache )
{
    return rewardcache.interactionpoint.angles;
}

// Namespace reward_cache
// Params 1
// Checksum 0xa2cafcbf, Offset: 0xb48
// Size: 0x21
function function_31a07b8539492f52( rewardcache )
{
    return arrayremove( level.players, getplayerowners( rewardcache ) );
}

// Namespace reward_cache
// Params 1
// Checksum 0x28686935, Offset: 0xb72
// Size: 0x17
function getplayerowners( rewardcache )
{
    return rewardcache.playerowners;
}

// Namespace reward_cache
// Params 1
// Checksum 0xe1d0f141, Offset: 0xb92
// Size: 0x20
function function_78b44dd54ba16bd8( rewardcache )
{
    return arrayremove( getplayerowners( rewardcache ), function_e1b5e151f741bf53( rewardcache ) );
}

// Namespace reward_cache
// Params 1
// Checksum 0x302fa7e8, Offset: 0xbbb
// Size: 0x17
function function_e1b5e151f741bf53( rewardcache )
{
    return rewardcache.var_96e082602e433228;
}

// Namespace reward_cache
// Params 9, eflags: 0x4
// Checksum 0x6657bde9, Offset: 0xbdb
// Size: 0x2d4
function private function_e16bb8976ec7fe45( rewardcachesettings, playergroups, placementstruct, func_openlootablecontainer, var_c74a1c6030ca10fb, lootfunctionargs, func_oncacheitemtaken, func_onitemadded, var_baee98df379448aa )
{
    var_f2f0a72e73b5a9a9 = 0;
    
    if ( !isarray( playergroups ) )
    {
        function_1c06ff6d60be6001( var_baee98df379448aa, !var_f2f0a72e73b5a9a9 );
        return;
    }
    
    if ( !function_c61e88a8c87af131( placementstruct ) )
    {
        function_1c06ff6d60be6001( var_baee98df379448aa, !var_f2f0a72e73b5a9a9 );
        return;
    }
    
    if ( !isfunction( func_openlootablecontainer ) )
    {
        function_1c06ff6d60be6001( var_baee98df379448aa, !var_f2f0a72e73b5a9a9 );
        return;
    }
    
    if ( !isfunction( var_c74a1c6030ca10fb ) )
    {
        function_1c06ff6d60be6001( var_baee98df379448aa, !var_f2f0a72e73b5a9a9 );
        return;
    }
    
    if ( !isdefined( lootfunctionargs ) )
    {
        lootfunctionargs = spawnstruct();
    }
    else if ( !isstruct( lootfunctionargs ) )
    {
        function_1c06ff6d60be6001( var_baee98df379448aa, !var_f2f0a72e73b5a9a9 );
        return;
    }
    
    if ( isdefined( func_oncacheitemtaken ) && !isfunction( func_oncacheitemtaken ) )
    {
        func_oncacheitemtaken = undefined;
    }
    
    if ( isdefined( func_onitemadded ) && !isfunction( func_onitemadded ) )
    {
        func_onitemadded = undefined;
    }
    
    playergrouplootstructs = [];
    spawnorigin = reward_cache_placement_struct::getplacementorigin( placementstruct );
    spawnangles = reward_cache_placement_struct::function_a8eeb78f35811f89( placementstruct );
    
    foreach ( playergroup in playergroups )
    {
        if ( !isarray( playergroup ) )
        {
            continue;
        }
        
        if ( playergroup.size == 0 )
        {
            continue;
        }
        
        lootfunctionargs.reward_group = playergroup;
        lootcontents = [[ var_c74a1c6030ca10fb ]]( lootfunctionargs );
        playergrouplootstructs[ playergrouplootstructs.size ] = { #lootcontents:lootcontents, #playergroup:playergroup };
    }
    
    if ( playergrouplootstructs.size == 0 )
    {
        function_1c06ff6d60be6001( var_baee98df379448aa, !var_f2f0a72e73b5a9a9 );
        return;
    }
    
    var_c786523ebe9c85c0 = reward_cache_placement_struct::function_b1657d4dc2601384( placementstruct );
    
    if ( var_c786523ebe9c85c0 )
    {
        function_28b7ccd0aed5fedb( playergroups, placementstruct, placementstruct );
        placementstruct waittill( #"hash_5c2ff3ac36ee1341", spawnorigin );
        playergrouplootstructs = function_61b54541c9f74de0( playergrouplootstructs );
        var_f2f0a72e73b5a9a9 = 1;
    }
    
    if ( playergrouplootstructs.size == 0 )
    {
        function_1c06ff6d60be6001( var_baee98df379448aa, !var_f2f0a72e73b5a9a9 );
        return;
    }
    
    rewardcache = _createstruct_rewardcache( rewardcachesettings, spawnorigin, spawnangles, func_openlootablecontainer, func_oncacheitemtaken, func_onitemadded );
    
    if ( !isdefined( rewardcache ) )
    {
        function_1c06ff6d60be6001( var_baee98df379448aa, !var_f2f0a72e73b5a9a9 );
        return;
    }
    
    success = function_c1c5346d80923fa9( rewardcache, playergrouplootstructs );
    
    if ( !success )
    {
        cleanuprewardcache( rewardcache );
        return;
    }
    
    function_6f58042e3920bc5( rewardcache );
    
    if ( isdefined( var_baee98df379448aa ) )
    {
        if ( !var_f2f0a72e73b5a9a9 )
        {
            waitframe();
        }
        
        var_baee98df379448aa notify( #"hash_4f4a891a302e4c2c", rewardcache );
    }
}

// Namespace reward_cache
// Params 9, eflags: 0x4
// Checksum 0xa0a50ba3, Offset: 0xeb7
// Size: 0x1aa
function private function_76b3d44f0bbcffd2( rewardcachesettings, playergroups, placementstruct, func_openlootablecontainer, var_c74a1c6030ca10fb, lootfunctionargs, func_oncacheitemtaken, func_onitemadded, var_baee98df379448aa )
{
    var_f2f0a72e73b5a9a9 = 0;
    spawnangles = reward_cache_placement_struct::function_a8eeb78f35811f89( placementstruct );
    spawnoriginworkresult = function_40be0779dff5862e();
    var_f5763015457232f5 = function_40be0779dff5862e();
    thread function_986748fbce1ab36d( spawnoriginworkresult, playergroups, placementstruct );
    thread function_408ce3d853ebf4c( var_f5763015457232f5, playergroups, var_c74a1c6030ca10fb, lootfunctionargs );
    workresults = [ spawnoriginworkresult, var_f5763015457232f5 ];
    
    for ( frameswaited = 0; !function_d85d331a04ee9287( workresults ) ; frameswaited++ )
    {
        waitframe();
        var_f2f0a72e73b5a9a9 = 1;
    }
    
    if ( function_9b77e11ca1849ba4( workresults ) )
    {
        function_1c06ff6d60be6001( var_baee98df379448aa, !var_f2f0a72e73b5a9a9 );
        return;
    }
    
    playergrouplootstructs = var_f5763015457232f5.resultobject;
    spawnorigin = spawnoriginworkresult.resultobject;
    playergrouplootstructs = function_61b54541c9f74de0( playergrouplootstructs );
    
    if ( playergrouplootstructs.size == 0 )
    {
        function_1c06ff6d60be6001( var_baee98df379448aa, !var_f2f0a72e73b5a9a9 );
        return;
    }
    
    rewardcache = _createstruct_rewardcache( rewardcachesettings, spawnorigin, spawnangles, func_openlootablecontainer, func_oncacheitemtaken, func_onitemadded );
    
    if ( !isdefined( rewardcache ) )
    {
        function_1c06ff6d60be6001( var_baee98df379448aa, !var_f2f0a72e73b5a9a9 );
        return;
    }
    
    success = function_c1c5346d80923fa9( rewardcache, playergrouplootstructs );
    
    if ( !success )
    {
        cleanuprewardcache( rewardcache );
        return;
    }
    
    function_6f58042e3920bc5( rewardcache );
    function_34f7a384cd5b96c1( var_baee98df379448aa, rewardcache, !var_f2f0a72e73b5a9a9 );
}

// Namespace reward_cache
// Params 3, eflags: 0x4
// Checksum 0x5d512534, Offset: 0x1069
// Size: 0x39
function private function_34f7a384cd5b96c1( var_d183fae00e665a75, rewardcache, var_3c5d79cd2fc372d2 )
{
    if ( isdefined( var_d183fae00e665a75 ) )
    {
        if ( var_3c5d79cd2fc372d2 )
        {
            waitframe();
        }
        
        var_d183fae00e665a75 notify( #"hash_4f4a891a302e4c2c", rewardcache );
    }
}

// Namespace reward_cache
// Params 2, eflags: 0x4
// Checksum 0x70a18004, Offset: 0x10aa
// Size: 0x2f
function private function_1c06ff6d60be6001( var_d183fae00e665a75, var_3c5d79cd2fc372d2 )
{
    if ( isdefined( var_d183fae00e665a75 ) )
    {
        if ( var_3c5d79cd2fc372d2 )
        {
            waitframe();
        }
        
        var_d183fae00e665a75 notify( #"hash_4f4a891a302e4c2c", undefined );
    }
}

// Namespace reward_cache
// Params 3, eflags: 0x4
// Checksum 0x2d1b60bc, Offset: 0x10e1
// Size: 0x11a
function private function_3f8402f5481272c0( rewardcache, players, contents )
{
    if ( !function_89911c82a0b9e825( players ) )
    {
        return 0;
    }
    
    if ( !function_81f8943696835ec1( contents ) )
    {
        return 0;
    }
    
    grouprewardcache = function_9db9ada24a5e8459( rewardcache, players, contents );
    
    if ( isdefined( grouprewardcache ) )
    {
        rewardcache.grouprewardcaches[ rewardcache.grouprewardcaches.size ] = grouprewardcache;
    }
    else
    {
        return 0;
    }
    
    var_22c3000324f14682 = 1;
    
    foreach ( player in grouprewardcache.playerowners )
    {
        function_d070b816336a05ba( rewardcache, player );
        success = function_915a224fa7290eef( rewardcache, player );
        
        if ( !success )
        {
            var_22c3000324f14682 = 0;
        }
    }
    
    return var_22c3000324f14682;
}

// Namespace reward_cache
// Params 2, eflags: 0x4
// Checksum 0x7203d0fd, Offset: 0x1204
// Size: 0xc6, Type: bool
function private function_c1c5346d80923fa9( rewardcache, playergrouplootstructs )
{
    foreach ( playergrouplootstruct in playergrouplootstructs )
    {
        playergroup = playergrouplootstruct.playergroup;
        lootcontents = playergrouplootstruct.lootcontents;
        success = function_3f8402f5481272c0( rewardcache, playergroup, lootcontents );
        
        if ( !success )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace reward_cache
// Params 3, eflags: 0x4
// Checksum 0x4c39e5c0, Offset: 0x12d3
// Size: 0xac
function private function_28b7ccd0aed5fedb( playergroups, placementstruct, var_1d77102df86df295 )
{
    spawnposition = reward_cache_placement_struct::getplacementorigin( placementstruct );
    searchradius = reward_cache_placement_struct::function_ddb9d24a4c20769e( placementstruct );
    var_8bb2240b9f87816d = reward_cache_placement_struct::function_12c151c4aad6a1af( placementstruct );
    var_4a8b75209d5e2414 = reward_cache_placement_struct::function_da4e4df9e44f22a5( placementstruct );
    var_35df3c4f5148fed9 = function_ac611bdd895cd2d5( playergroups );
    var_31ebf063d0ac2c41 = namespace_f4242316def354f7::function_de717c4405ea13b5( var_8bb2240b9f87816d, var_4a8b75209d5e2414, var_35df3c4f5148fed9 );
    var_739ad2ebadfd6c26 = namespace_f4242316def354f7::function_819b627a62584c41();
    namespace_f4242316def354f7::findnearbyspawnpointguaranteed( spawnposition, searchradius, var_31ebf063d0ac2c41, var_739ad2ebadfd6c26, var_1d77102df86df295 );
}

// Namespace reward_cache
// Params 1, eflags: 0x4
// Checksum 0x20cefac0, Offset: 0x1387
// Size: 0x34
function private function_ac611bdd895cd2d5( playergroups )
{
    var_9a60d5677ecbe5be = utility::array_random( playergroups );
    var_35df3c4f5148fed9 = utility::array_random( var_9a60d5677ecbe5be );
    return var_35df3c4f5148fed9;
}

// Namespace reward_cache
// Params 5, eflags: 0x4
// Checksum 0x24d6920, Offset: 0x13c4
// Size: 0xcb
function private _rewardcache_scriptable_setparententity( rewardcache, parent, offset, angles, var_deb347af990b69f8 )
{
    if ( var_deb347af990b69f8 ?? 1 )
    {
        thread function_b6d7a8649fe77c0( rewardcache );
    }
    
    allscriptables = function_244c18b1dfad6f0e( rewardcache );
    
    foreach ( scriptable in allscriptables )
    {
        scriptable utility::scriptable_setparententity( parent, offset, angles );
    }
}

// Namespace reward_cache
// Params 1, eflags: 0x4
// Checksum 0x1609a5c4, Offset: 0x1497
// Size: 0x118
function private function_244c18b1dfad6f0e( rewardcache )
{
    scriptables = [ rewardcache.interactionpoint ];
    
    foreach ( grouprewardcache in rewardcache.grouprewardcaches )
    {
        scriptables[ scriptables.size ] = grouprewardcache;
    }
    
    foreach ( var_708d5b426571b631 in rewardcache.var_f895f5051913d326 )
    {
        scriptables[ scriptables.size ] = var_708d5b426571b631;
    }
    
    return scriptables;
}

// Namespace reward_cache
// Params 2, eflags: 0x4
// Checksum 0x5d8fd1ff, Offset: 0x15b8
// Size: 0x37
function private function_d070b816336a05ba( rewardcache, player )
{
    rewardcache.playerowners = arraycombineunique( rewardcache.playerowners, [ player ] );
}

// Namespace reward_cache
// Params 2, eflags: 0x4
// Checksum 0x84d7bee1, Offset: 0x15f7
// Size: 0x32
function private function_65c370b8bece4ff1( rewardcache, player )
{
    rewardcache.playerowners = arrayremove( rewardcache.playerowners, player );
}

// Namespace reward_cache
// Params 1, eflags: 0x4
// Checksum 0x67180d77, Offset: 0x1631
// Size: 0x42
function private function_db2babe45c6fd2c4( rewardcache )
{
    rewardcache.playerowners = function_5713d46873b29625( rewardcache.playerowners );
    rewardcache.var_96e082602e433228 = function_5713d46873b29625( rewardcache.var_96e082602e433228 );
}

// Namespace reward_cache
// Params 2, eflags: 0x4
// Checksum 0x88bcffd3, Offset: 0x167b
// Size: 0x30
function private function_647bdbd451e6dd83( rewardcache, player )
{
    rewardcache.var_96e082602e433228[ rewardcache.var_96e082602e433228.size ] = player;
}

// Namespace reward_cache
// Params 2, eflags: 0x4
// Checksum 0xbcb8dc83, Offset: 0x16b3
// Size: 0x32
function private function_7060dadfd7f8d412( rewardcache, player )
{
    rewardcache.var_96e082602e433228 = arrayremove( rewardcache.var_96e082602e433228, player );
}

// Namespace reward_cache
// Params 6, eflags: 0x4
// Checksum 0xdb24cb75, Offset: 0x16ed
// Size: 0x101
function private _createstruct_rewardcache( rewardcachesettings, origin, angles, func_openlootablecontainer, func_oncacheitemtaken, func_onitemadded )
{
    rewardcache = spawnstruct();
    rewardcache.isrewardcache = 1;
    rewardcache.settings = rewardcachesettings;
    rewardcache.func_openlootablecontainer = func_openlootablecontainer;
    rewardcache.func_oncacheitemtaken = func_oncacheitemtaken;
    rewardcache.func_onitemadded = func_onitemadded;
    rewardcache.objectivemarkerid = function_ee43f848d045a583( rewardcachesettings, origin );
    rewardcache.interactionpoint = _createstruct_interactionpoint( rewardcache, origin, angles );
    
    if ( !isdefined( rewardcache.interactionpoint ) )
    {
        return;
    }
    
    rewardcache.grouprewardcaches = [];
    rewardcache.var_f895f5051913d326 = [];
    rewardcache.playerowners = [];
    rewardcache.var_96e082602e433228 = [];
    return rewardcache;
}

// Namespace reward_cache
// Params 1, eflags: 0x4
// Checksum 0xb7597457, Offset: 0x17f7
// Size: 0x135
function private function_7ef3bbc623a6e650( rewardcache )
{
    rewardcache notify( #"cleanup" );
    rewardcache endon( #"cleanup" );
    
    foreach ( grouprewardcache in rewardcache.grouprewardcaches )
    {
        function_906326083b990a47( grouprewardcache );
    }
    
    foreach ( var_708d5b426571b631 in rewardcache.var_f895f5051913d326 )
    {
        function_b8a9778f565e4e68( var_708d5b426571b631 );
    }
    
    function_22879cba8a5e02eb( rewardcache.interactionpoint );
    function_de8083401ed1800b( rewardcache );
}

// Namespace reward_cache
// Params 3, eflags: 0x4
// Checksum 0xade9f588, Offset: 0x1934
// Size: 0x12c
function private function_9db9ada24a5e8459( rewardcacheowner, players, cachecontents )
{
    var_41001281e434e29a = reward_cache_settings::function_94deaff283e30496( rewardcacheowner.settings );
    origin = function_f4cf6bc9ebcdf5ea( rewardcacheowner );
    angles = function_e9f4bcef0aa0d128( rewardcacheowner );
    var_41001281e434e29a = function_50d418fd175abbba( var_41001281e434e29a, origin, angles );
    
    /#
        if ( !function_cafbc08a677837f2( var_41001281e434e29a, 2, 1 ) )
        {
            function_995cab36678ae05b( var_41001281e434e29a );
            return;
        }
    #/
    
    grouprewardcache = var_41001281e434e29a;
    grouprewardcache.var_7ad1223e3184a1dc = 1;
    grouprewardcache.rewardcacheowner = rewardcacheowner;
    grouprewardcache.contents = [];
    grouprewardcache.func_oncacheitemtaken = rewardcacheowner.func_oncacheitemtaken;
    grouprewardcache.onitemtaken = &function_e2edc5ce1c5c3267;
    grouprewardcache.func_onitemadded = rewardcacheowner.func_onitemadded;
    grouprewardcache.playerowners = players;
    grouprewardcache.currentopener = undefined;
    function_397a0c8637e0a76e( grouprewardcache, cachecontents, 1 );
    thread function_5c06c8037a72c1de( grouprewardcache );
    return grouprewardcache;
}

// Namespace reward_cache
// Params 1, eflags: 0x4
// Checksum 0xef214883, Offset: 0x1a69
// Size: 0x22
function private function_906326083b990a47( grouprewardcache )
{
    grouprewardcache notify( #"cleanup" );
    function_995cab36678ae05b( grouprewardcache );
}

// Namespace reward_cache
// Params 2, eflags: 0x4
// Checksum 0xa8af4054, Offset: 0x1a93
// Size: 0x74
function private _rewardcache_openlootablecontainer( rewardcache, player )
{
    grouprewardcache = function_f05326172cca58de( rewardcache, player );
    
    if ( isdefined( grouprewardcache ) )
    {
        function_1d4f923f47a526a( grouprewardcache, player );
        argsstruct = spawnstruct();
        argsstruct.cache = grouprewardcache;
        argsstruct.player = player;
        [[ rewardcache.func_openlootablecontainer ]]( argsstruct );
    }
}

// Namespace reward_cache
// Params 3, eflags: 0x4
// Checksum 0xa5ce7ec4, Offset: 0x1b0f
// Size: 0xbb
function private function_397a0c8637e0a76e( grouprewardcache, newcontents, var_e72e1a13468e6f14 = 0 )
{
    if ( isarray( newcontents ) )
    {
        foreach ( item in newcontents )
        {
            containerindex = grouprewardcache.contents.size;
            function_c200ccd981bab5b8( grouprewardcache, item, containerindex, var_e72e1a13468e6f14 );
        }
    }
}

// Namespace reward_cache
// Params 1, eflags: 0x4
// Checksum 0x92f117e0, Offset: 0x1bd2
// Size: 0x77
function private function_8609f043ae55ffc2( grouprewardcache )
{
    newcontents = [];
    reserveditem = spawnstruct();
    reserveditem.var_e0f603cef9c13396 = 1;
    reserveditem.lootid = 0;
    reserveditem.quantity = 0;
    reserveditemslotindex = grouprewardcache.contents.size;
    grouprewardcache.contents[ reserveditemslotindex ] = reserveditem;
    return reserveditemslotindex;
}

// Namespace reward_cache
// Params 4, eflags: 0x4
// Checksum 0x2bcb4ff4, Offset: 0x1c52
// Size: 0x9c
function private function_c200ccd981bab5b8( grouprewardcache, item, index, var_e72e1a13468e6f14 = 0 )
{
    grouprewardcache.contents[ index ] = item;
    
    if ( !var_e72e1a13468e6f14 && isdefined( grouprewardcache.func_onitemadded ) )
    {
        argsstruct = function_dedecae0476eac2b( grouprewardcache, item.lootid, item.quantity, index, grouprewardcache.currentopener );
        [[ grouprewardcache.func_onitemadded ]]( argsstruct );
    }
}

// Namespace reward_cache
// Params 5, eflags: 0x4
// Checksum 0xdf7eb69d, Offset: 0x1cf6
// Size: 0x68
function private function_dedecae0476eac2b( grouprewardcache, lootid, quantity, containerindex, currentopener )
{
    return { #currentopener:currentopener, #containerindex:containerindex, #quantity:quantity, #lootid:lootid, #grouprewardcache:grouprewardcache };
}

// Namespace reward_cache
// Params 1, eflags: 0x4
// Checksum 0xbef8c77f, Offset: 0x1d67
// Size: 0xee
function private function_e935e33d8657d825( grouprewardcache )
{
    newcontents = [];
    
    foreach ( item in grouprewardcache.contents )
    {
        var_6c43c2aec76d1df7 = isdefined( item ) && item.lootid != 0;
        var_cc9d65c6840d3745 = isdefined( item.quantity ) && item.quantity != 0;
        
        if ( var_6c43c2aec76d1df7 && var_cc9d65c6840d3745 )
        {
            newcontents[ newcontents.size ] = item;
        }
    }
    
    grouprewardcache.contents = newcontents;
}

// Namespace reward_cache
// Params 1, eflags: 0x4
// Checksum 0x38eead97, Offset: 0x1e5d
// Size: 0x38
function private function_5c06c8037a72c1de( grouprewardcache )
{
    grouprewardcache endon( #"cleanup" );
    
    while ( true )
    {
        grouprewardcache waittill( #"closed" );
        function_9ce71b9d7a85cd9b( grouprewardcache );
    }
}

// Namespace reward_cache
// Params 2, eflags: 0x4
// Checksum 0x2fd43c94, Offset: 0x1e9d
// Size: 0x5f
function private function_1d4f923f47a526a( grouprewardcache, player )
{
    function_92ba4f8b74bed0ac( grouprewardcache );
    rewardcache = grouprewardcache.rewardcacheowner;
    var_e619eedc7570e359 = function_e870a159469c697b( rewardcache, player );
    function_8adce182bf2231( var_e619eedc7570e359 );
    grouprewardcache.currentopener = player;
}

// Namespace reward_cache
// Params 1, eflags: 0x4
// Checksum 0x6e4ec7e1, Offset: 0x1f04
// Size: 0x29
function private function_9ce71b9d7a85cd9b( grouprewardcache )
{
    function_b1a7acc0632f58e2( grouprewardcache );
    function_2d18d57792e46f73( grouprewardcache );
    grouprewardcache.currentopener = undefined;
}

// Namespace reward_cache
// Params 2, eflags: 0x4
// Checksum 0x8d28ce57, Offset: 0x1f35
// Size: 0xd0
function private function_e2edc5ce1c5c3267( grouprewardcache, player )
{
    rewardcache = grouprewardcache.rewardcacheowner;
    
    foreach ( player in grouprewardcache.playerowners )
    {
        var_e619eedc7570e359 = function_e870a159469c697b( rewardcache, player );
        function_f531fe379b8a462e( var_e619eedc7570e359 );
    }
    
    if ( isdefined( grouprewardcache.func_oncacheitemtaken ) )
    {
        [[ grouprewardcache.func_oncacheitemtaken ]]( grouprewardcache, player );
    }
}

// Namespace reward_cache
// Params 1, eflags: 0x4
// Checksum 0xeddf762d, Offset: 0x200d
// Size: 0x5f
function private function_2d18d57792e46f73( grouprewardcache )
{
    if ( function_50a907e8b8353ea8( grouprewardcache ) )
    {
        currentopener = grouprewardcache.currentopener;
        rewardcache = grouprewardcache.rewardcacheowner;
        var_e619eedc7570e359 = function_e870a159469c697b( rewardcache, currentopener );
        function_d295956b97f09708( var_e619eedc7570e359 );
    }
}

// Namespace reward_cache
// Params 1, eflags: 0x4
// Checksum 0xce29bed0, Offset: 0x2074
// Size: 0x74, Type: bool
function private function_50a907e8b8353ea8( grouprewardcache )
{
    currentopener = grouprewardcache.currentopener;
    
    if ( !isplayer( currentopener ) )
    {
        return false;
    }
    
    rewardcache = grouprewardcache.rewardcacheowner;
    var_bef8d8ea8743d34b = reward_cache_settings::function_bf5102d23412c9fa( rewardcache.settings );
    
    if ( !var_bef8d8ea8743d34b )
    {
        if ( grouprewardcache_isempty( grouprewardcache ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace reward_cache
// Params 1, eflags: 0x4
// Checksum 0xc8f770f4, Offset: 0x20f1
// Size: 0xab
function private function_92ba4f8b74bed0ac( grouprewardcache )
{
    rewardcache = grouprewardcache.rewardcacheowner;
    
    foreach ( player in grouprewardcache.playerowners )
    {
        if ( function_3db97dfd7f0c8060( rewardcache, player ) == 0 )
        {
            function_c61374a9b5b4130c( rewardcache, player );
        }
    }
}

// Namespace reward_cache
// Params 1, eflags: 0x4
// Checksum 0xc6db3d12, Offset: 0x21a4
// Size: 0xab
function private function_b1a7acc0632f58e2( grouprewardcache )
{
    rewardcache = grouprewardcache.rewardcacheowner;
    
    foreach ( player in grouprewardcache.playerowners )
    {
        if ( function_3db97dfd7f0c8060( rewardcache, player ) == 0 )
        {
            function_9993b51672c5beab( rewardcache, player );
        }
    }
}

// Namespace reward_cache
// Params 3, eflags: 0x4
// Checksum 0x9e954237, Offset: 0x2257
// Size: 0x96
function private _createstruct_interactionpoint( rewardcacheowner, origin, angles )
{
    var_8b555827f1fb0bf0 = reward_cache_settings::function_6c5d8e4be0979384( rewardcacheowner.settings );
    scriptable_interactionpoint = function_50d418fd175abbba( var_8b555827f1fb0bf0, origin, angles );
    
    /#
        if ( !function_cafbc08a677837f2( scriptable_interactionpoint, 1, 1 ) )
        {
            function_995cab36678ae05b( scriptable_interactionpoint );
            return;
        }
    #/
    
    interactionpoint = scriptable_interactionpoint;
    interactionpoint.var_b676e2b705962337 = 1;
    interactionpoint.rewardcacheowner = rewardcacheowner;
    return interactionpoint;
}

// Namespace reward_cache
// Params 1, eflags: 0x4
// Checksum 0x99f81bf1, Offset: 0x22f6
// Size: 0x15
function private function_22879cba8a5e02eb( interactionpoint )
{
    function_995cab36678ae05b( interactionpoint );
}

// Namespace reward_cache
// Params 2, eflags: 0x4
// Checksum 0x3f81748b, Offset: 0x2313
// Size: 0xb2
function private function_b1dc7d497965e446( rewardcacheowner, playerowner )
{
    var_94132b2c5008d349 = reward_cache_settings::function_d5a2c090a6cf9fdd( rewardcacheowner.settings );
    origin = function_f4cf6bc9ebcdf5ea( rewardcacheowner );
    angles = function_e9f4bcef0aa0d128( rewardcacheowner );
    var_e619eedc7570e359 = function_50d418fd175abbba( var_94132b2c5008d349, origin, angles, playerowner );
    
    /#
        if ( !function_cafbc08a677837f2( var_e619eedc7570e359, 0, 1 ) )
        {
            function_995cab36678ae05b( var_e619eedc7570e359 );
            return;
        }
    #/
    
    var_708d5b426571b631 = var_e619eedc7570e359;
    var_708d5b426571b631.rewardcacheowner = rewardcacheowner;
    var_708d5b426571b631.playerowner = playerowner;
    return var_708d5b426571b631;
}

// Namespace reward_cache
// Params 1, eflags: 0x4
// Checksum 0x2263aa6d, Offset: 0x23ce
// Size: 0x15
function private function_b8a9778f565e4e68( var_708d5b426571b631 )
{
    function_995cab36678ae05b( var_708d5b426571b631 );
}

// Namespace reward_cache
// Params 2, eflags: 0x4
// Checksum 0x69bcd49d, Offset: 0x23eb
// Size: 0x50, Type: bool
function private function_915a224fa7290eef( rewardcache, player )
{
    var_708d5b426571b631 = function_b1dc7d497965e446( rewardcache, player );
    
    if ( !isdefined( var_708d5b426571b631 ) )
    {
        return false;
    }
    
    rewardcache.var_f895f5051913d326[ rewardcache.var_f895f5051913d326.size ] = var_708d5b426571b631;
    return true;
}

// Namespace reward_cache
// Params 3, eflags: 0x4
// Checksum 0x4319b904, Offset: 0x2444
// Size: 0x5f
function private function_2bc70d7e12a4e881( rewardcache, player, rewardcachestate )
{
    var_e619eedc7570e359 = function_e870a159469c697b( rewardcache, player );
    var_94132b2c5008d349 = reward_cache_settings::function_d5a2c090a6cf9fdd( rewardcache.settings );
    
    if ( isdefined( var_e619eedc7570e359 ) )
    {
        function_a1789ed6ac758d44( var_e619eedc7570e359, var_94132b2c5008d349, rewardcachestate );
    }
}

// Namespace reward_cache
// Params 2, eflags: 0x4
// Checksum 0x69323592, Offset: 0x24ab
// Size: 0x9b
function private function_e870a159469c697b( rewardcache, player )
{
    foreach ( var_708d5b426571b631 in rewardcache.var_f895f5051913d326 )
    {
        if ( var_708d5b426571b631.playerowner == player )
        {
            return var_708d5b426571b631;
        }
    }
}

// Namespace reward_cache
// Params 2
// Checksum 0x677fc3f4, Offset: 0x254e
// Size: 0x31
function function_cf0329c600b38bc5( rewardcache, player )
{
    utility::callsharedfunc( #"reward_cache", #"showrewardcachemarkertoplayer", rewardcache, player );
}

// Namespace reward_cache
// Params 2
// Checksum 0x6764f319, Offset: 0x2587
// Size: 0x31
function function_ea1c739324051b81( rewardcache, player )
{
    utility::callsharedfunc( #"reward_cache", #"hiderewardcachemarkerfromplayer", rewardcache, player );
}

// Namespace reward_cache
// Params 1, eflags: 0x4
// Checksum 0xee3cd03b, Offset: 0x25c0
// Size: 0x3d
function private function_b6d7a8649fe77c0( rewardcache )
{
    rewardcache endon( #"cleanup" );
    
    while ( true )
    {
        waitframe();
        utility::callsharedfunc( #"reward_cache", #"updaterewardcachemarkerposition", rewardcache );
    }
}

// Namespace reward_cache
// Params 2, eflags: 0x4
// Checksum 0xebedc626, Offset: 0x2605
// Size: 0x30
function private function_ee43f848d045a583( rewardcachesettings, origin )
{
    return utility::callsharedfunc( #"reward_cache", #"createrewardcacheobjectivemarker", rewardcachesettings, origin );
}

// Namespace reward_cache
// Params 1, eflags: 0x4
// Checksum 0xf09802fb, Offset: 0x263e
// Size: 0x26
function private function_de8083401ed1800b( rewardcache )
{
    return utility::callsharedfunc( #"reward_cache", #"destroyrewardcacheobjectivemarker", rewardcache );
}

// Namespace reward_cache
// Params 1, eflags: 0x4
// Checksum 0x56dc0ba, Offset: 0x266d
// Size: 0x18c
function private function_6f58042e3920bc5( rewardcache )
{
    inactiveplayers = function_31a07b8539492f52( rewardcache );
    
    foreach ( player in inactiveplayers )
    {
        function_9941143ad738972c( rewardcache, player, 1 );
    }
    
    activeplayers = function_78b44dd54ba16bd8( rewardcache );
    
    foreach ( player in activeplayers )
    {
        function_9941143ad738972c( rewardcache, player, 0 );
    }
    
    var_1cb0d38c79cf1d9d = function_e1b5e151f741bf53( rewardcache );
    
    foreach ( player in var_1cb0d38c79cf1d9d )
    {
        function_9941143ad738972c( rewardcache, player, 2 );
    }
}

// Namespace reward_cache
// Params 2
// Checksum 0xfbb67864, Offset: 0x2801
// Size: 0x35
function function_9de5c30001201a72( rewardcache, player )
{
    state = function_3db97dfd7f0c8060( rewardcache, player );
    function_9941143ad738972c( rewardcache, player, state );
}

// Namespace reward_cache
// Params 2, eflags: 0x4
// Checksum 0xe50bef08, Offset: 0x283e
// Size: 0x45
function private function_3db97dfd7f0c8060( rewardcache, player )
{
    if ( arraycontains( function_e1b5e151f741bf53( rewardcache ), player ) )
    {
        return 2;
    }
    
    if ( arraycontains( getplayerowners( rewardcache ), player ) )
    {
        return 0;
    }
    
    return 1;
}

// Namespace reward_cache
// Params 2, eflags: 0x4
// Checksum 0x5f2af44b, Offset: 0x288b
// Size: 0x27
function private function_9993b51672c5beab( rewardcache, player )
{
    rewardcache.interactionpoint enablescriptableplayeruse( player );
}

// Namespace reward_cache
// Params 2, eflags: 0x4
// Checksum 0xbee0a013, Offset: 0x28ba
// Size: 0x27
function private function_c61374a9b5b4130c( rewardcache, player )
{
    rewardcache.interactionpoint disablescriptableplayeruse( player );
}

// Namespace reward_cache
// Params 3, eflags: 0x4
// Checksum 0x4b3b9131, Offset: 0x28e9
// Size: 0x5b
function private function_9941143ad738972c( rewardcache, player, rewardcachestate )
{
    if ( rewardcachestate == 0 )
    {
        function_9993b51672c5beab( rewardcache, player );
        function_cf0329c600b38bc5( rewardcache, player );
    }
    else
    {
        function_c61374a9b5b4130c( rewardcache, player );
        function_ea1c739324051b81( rewardcache, player );
    }
    
    function_2bc70d7e12a4e881( rewardcache, player, rewardcachestate );
}

// Namespace reward_cache
// Params 2
// Checksum 0xcb02fb07, Offset: 0x294c
// Size: 0x3d
function function_74471f8245ac348c( scriptableassetname, rewardcachescriptabletype )
{
    if ( !isdefined( scriptableassetname ) )
    {
        return;
    }
    
    scriptableinfo = function_dc6f53f8d098ce71( scriptableassetname );
    function_500ec279b11b5d4f( scriptableinfo, rewardcachescriptabletype );
    return scriptableinfo;
}

// Namespace reward_cache
// Params 5
// Checksum 0xc00fda0f, Offset: 0x2992
// Size: 0x88
function function_dc6f53f8d098ce71( scriptable_assetname, scriptablepartname, var_898c4627b30f2532, var_93afa6dd46410b2e, var_e7ddc1c3c4d8d8f4 )
{
    scriptableinfo = spawnstruct();
    scriptableinfo.assetname = scriptable_assetname;
    scriptableinfo.scriptablepartname = scriptablepartname;
    scriptableinfo.var_898c4627b30f2532 = var_898c4627b30f2532;
    scriptableinfo.var_93afa6dd46410b2e = var_93afa6dd46410b2e;
    scriptableinfo.var_e7ddc1c3c4d8d8f4 = var_e7ddc1c3c4d8d8f4;
    return scriptableinfo;
}

// Namespace reward_cache
// Params 2, eflags: 0x4
// Checksum 0x389784a7, Offset: 0x2a23
// Size: 0x74
function private function_500ec279b11b5d4f( scriptableinfo, rewardcachescriptabletype )
{
    switch ( rewardcachescriptabletype )
    {
        case 0:
            function_5828f0a6c7bb9dfc( scriptableinfo );
            break;
        case 1:
            function_a143ef429e1f312f( scriptableinfo );
            break;
        case 2:
            function_6b5aa1fd380373d7( scriptableinfo );
            break;
        default:
            return;
    }
}

// Namespace reward_cache
// Params 1, eflags: 0x4
// Checksum 0xfc7593a5, Offset: 0x2a9f
// Size: 0x44
function private function_a143ef429e1f312f( scriptableinfo )
{
    scriptableinfo.scriptablepartname = "body";
    scriptableinfo.var_898c4627b30f2532 = "rewardcache_interactionpoint";
    scriptableinfo.var_93afa6dd46410b2e = undefined;
    scriptableinfo.var_e7ddc1c3c4d8d8f4 = undefined;
}

// Namespace reward_cache
// Params 1, eflags: 0x4
// Checksum 0x2e70764a, Offset: 0x2aeb
// Size: 0x44
function private function_6b5aa1fd380373d7( scriptableinfo )
{
    scriptableinfo.scriptablepartname = "body";
    scriptableinfo.var_898c4627b30f2532 = "rewardcache_lootcache";
    scriptableinfo.var_93afa6dd46410b2e = undefined;
    scriptableinfo.var_e7ddc1c3c4d8d8f4 = undefined;
}

// Namespace reward_cache
// Params 1, eflags: 0x4
// Checksum 0xc6082d3, Offset: 0x2b37
// Size: 0x50
function private function_5828f0a6c7bb9dfc( scriptableinfo )
{
    scriptableinfo.scriptablepartname = "body";
    scriptableinfo.var_898c4627b30f2532 = "rewardcache_active";
    scriptableinfo.var_93afa6dd46410b2e = "rewardcache_inactive";
    scriptableinfo.var_e7ddc1c3c4d8d8f4 = "rewardcache_despawn";
}

// Namespace reward_cache
// Params 4, eflags: 0x4
// Checksum 0xf8a4be14, Offset: 0x2b8f
// Size: 0xa0
function private function_50d418fd175abbba( scriptableinfo, origin, angles, playerowner )
{
    assetname = scriptableinfo.assetname;
    scriptable = undefined;
    
    if ( isdefined( playerowner ) )
    {
        payload = [ #"teamselect", playerowner getentitynumber() ];
        scriptable = spawnscriptable( assetname, origin, angles, undefined, payload );
    }
    else
    {
        scriptable = spawnscriptable( assetname, origin, angles );
    }
    
    if ( !isdefined( scriptable ) )
    {
        return;
    }
    
    function_a1789ed6ac758d44( scriptable, scriptableinfo, 0 );
    return scriptable;
}

// Namespace reward_cache
// Params 1, eflags: 0x4
// Checksum 0xa9f28af8, Offset: 0x2c38
// Size: 0x2e
function private function_995cab36678ae05b( rewardcachescriptable )
{
    if ( !isdefined( rewardcachescriptable ) )
    {
        return;
    }
    
    if ( isent( rewardcachescriptable ) )
    {
        rewardcachescriptable delete();
        return;
    }
    
    rewardcachescriptable freescriptable();
}

// Namespace reward_cache
// Params 3, eflags: 0x4
// Checksum 0x68d4d391, Offset: 0x2c6e
// Size: 0xcc
function private function_a1789ed6ac758d44( scriptable, scriptableinfo, rewardcachestate )
{
    scriptablepartname = scriptableinfo.scriptablepartname;
    scriptablestatename = undefined;
    
    switch ( rewardcachestate )
    {
        case 0:
            scriptablestatename = scriptableinfo.var_898c4627b30f2532;
            break;
        case 1:
            scriptablestatename = scriptableinfo.var_f0a586f1c7e9a40b;
            break;
        case 2:
            scriptablestatename = scriptableinfo.var_e7ddc1c3c4d8d8f4;
            break;
        default:
            assertmsg( "<dev string:x24>" + rewardcachestate + "<dev string:x38>" );
            return;
    }
    
    function_6b7652dd09aa6214( scriptable, scriptablepartname, scriptablestatename );
}

// Namespace reward_cache
// Params 3, eflags: 0x4
// Checksum 0x63128101, Offset: 0x2d42
// Size: 0x35
function private function_6b7652dd09aa6214( scriptable, scriptablepartname, scriptablestatename )
{
    if ( scriptable getscriptableparthasstate( scriptablepartname, scriptablestatename ) )
    {
        scriptable setscriptablepartstate( scriptablepartname, scriptablestatename );
    }
}

// Namespace reward_cache
// Params 4, eflags: 0x4
// Checksum 0xac447efa, Offset: 0x2d7f
// Size: 0x8e
function private function_575980396450b379( scriptable, scriptablepartname, var_f9ee6f3ecbddbbf1, var_48411965732b0836 )
{
    scriptable notify( scriptablepartname );
    scriptable endon( scriptablepartname );
    var_d3e9852de0aca1fb = scriptable getscriptableparthasstate( scriptablepartname, var_f9ee6f3ecbddbbf1 );
    var_3422b788befdce4 = scriptable getscriptableparthasstate( scriptablepartname, var_48411965732b0836 );
    
    if ( var_d3e9852de0aca1fb && var_3422b788befdce4 )
    {
        function_6b7652dd09aa6214( scriptable, scriptablepartname, var_f9ee6f3ecbddbbf1 );
        waitframe();
        
        if ( isdefined( scriptable ) )
        {
            function_6b7652dd09aa6214( scriptable, scriptablepartname, var_48411965732b0836 );
        }
        
        return;
    }
    
    if ( var_d3e9852de0aca1fb && !var_3422b788befdce4 )
    {
    }
}

// Namespace reward_cache
// Params 1, eflags: 0x4
// Checksum 0x84700d1, Offset: 0x2e15
// Size: 0x24
function private function_f531fe379b8a462e( scriptable )
{
    thread function_575980396450b379( scriptable, "onitemtaken", "rewardcache_onitemtaken", "rewardcache_inactive" );
}

// Namespace reward_cache
// Params 1, eflags: 0x4
// Checksum 0x176c559, Offset: 0x2e41
// Size: 0x24
function private function_d295956b97f09708( scriptable )
{
    thread function_575980396450b379( scriptable, "onclosed", "rewardcache_onclosed", "rewardcache_inactive" );
}

// Namespace reward_cache
// Params 1, eflags: 0x4
// Checksum 0xa8e7afe6, Offset: 0x2e6d
// Size: 0x24
function private function_8adce182bf2231( scriptable )
{
    thread function_575980396450b379( scriptable, "onopened", "rewardcache_onopened", "rewardcache_inactive" );
}

// Namespace reward_cache
// Params 0
// Checksum 0x1d12dba9, Offset: 0x2e99
// Size: 0x6a
function function_a1922535df5be8d8()
{
    if ( !isdefined( level.var_e7b32e4c47188e7 ) )
    {
        level.var_e7b32e4c47188e7 = playtest_logger::function_81cc4ca859a01d68( @"hash_9a8fd13708d50583", @"hash_9d0c095771c6026d", @"hash_813ebb2dc2b30d1c", @"hash_693c22d6aae40d2e", @"hash_176196b9a9745584", @"hash_56641085422a272c", @"hash_bd0e9311e61ffefa", "REWARD_CACHE_LOG " );
    }
    
    return level.var_e7b32e4c47188e7;
}

// Namespace reward_cache
// Params 9, eflags: 0x4
// Checksum 0xfd394954, Offset: 0x2f0c
// Size: 0x16e
function private function_a3e4363d792640b2( rewardcachesettings, playergroups, placementstruct, func_openlootablecontainer, var_c74a1c6030ca10fb, lootfunctionargs, func_oncacheitemtaken, func_onitemadded, var_baee98df379448aa )
{
    result = { #func_onitemadded:func_onitemadded, #func_oncacheitemtaken:func_oncacheitemtaken, #lootfunctionargs:lootfunctionargs, #success:1 };
    
    if ( !isarray( playergroups ) )
    {
        result.success = 0;
    }
    else if ( playergroups.size == 0 )
    {
        result.success = 0;
    }
    
    if ( !function_c61e88a8c87af131( placementstruct ) )
    {
        result.success = 0;
    }
    
    if ( !isfunction( func_openlootablecontainer ) )
    {
        result.success = 0;
    }
    
    if ( !isfunction( var_c74a1c6030ca10fb ) )
    {
        result.success = 0;
    }
    
    if ( !isdefined( lootfunctionargs ) )
    {
        result.lootfunctionargs = spawnstruct();
    }
    else if ( !isstruct( lootfunctionargs ) )
    {
        result.success = 0;
    }
    
    if ( isdefined( func_oncacheitemtaken ) && !isfunction( func_oncacheitemtaken ) )
    {
        result.func_oncacheitemtaken = undefined;
    }
    
    if ( isdefined( func_onitemadded ) && !isfunction( func_onitemadded ) )
    {
        result.func_onitemadded = undefined;
    }
    
    return result;
}

// Namespace reward_cache
// Params 1
// Checksum 0xbde08367, Offset: 0x3083
// Size: 0xaf, Type: bool
function function_81f8943696835ec1( var_2340e0190214ba7d )
{
    if ( !isarray( var_2340e0190214ba7d ) )
    {
        return false;
    }
    
    foreach ( lootitem in var_2340e0190214ba7d )
    {
        if ( !isstruct( lootitem ) || !( isdefined( lootitem.lootid ) && isdefined( lootitem.quantity ) ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace reward_cache
// Params 1
// Checksum 0x4a93dc17, Offset: 0x313b
// Size: 0x31, Type: bool
function function_c61e88a8c87af131( var_351b63bf1bd817e3 )
{
    return isstruct( var_351b63bf1bd817e3 ) && isdefined( var_351b63bf1bd817e3.origin ) && isdefined( var_351b63bf1bd817e3.angles );
}

// Namespace reward_cache
// Params 1
// Checksum 0x1afe3799, Offset: 0x3175
// Size: 0x8f, Type: bool
function function_89911c82a0b9e825( rewardgroup )
{
    if ( !isarray( rewardgroup ) )
    {
        return false;
    }
    
    foreach ( player in rewardgroup )
    {
        if ( !isplayer( player ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace reward_cache
// Params 1, eflags: 0x4
// Checksum 0x5a118a36, Offset: 0x320d
// Size: 0xba
function private function_61b54541c9f74de0( playergrouplootstructs )
{
    var_9dfac2a2c8884bc4 = [];
    
    foreach ( grouplootstruct in playergrouplootstructs )
    {
        validplayers = function_fe63057a0c3f3191( grouplootstruct.playergroup );
        
        if ( validplayers.size > 0 )
        {
            grouplootstruct.playergroup = validplayers;
            var_9dfac2a2c8884bc4[ var_9dfac2a2c8884bc4.size ] = grouplootstruct;
        }
    }
    
    return var_9dfac2a2c8884bc4;
}

// Namespace reward_cache
// Params 1, eflags: 0x4
// Checksum 0xed10db0d, Offset: 0x32d0
// Size: 0x92
function private function_fe63057a0c3f3191( array )
{
    validplayers = [];
    
    foreach ( player in array )
    {
        if ( isplayer( player ) )
        {
            validplayers[ validplayers.size ] = player;
        }
    }
    
    return validplayers;
}

// Namespace reward_cache
// Params 3, eflags: 0x4
// Checksum 0xc060257c, Offset: 0x336b
// Size: 0x68, Type: bool
function private function_cafbc08a677837f2( scriptableinstance, rewardcachescriptabletype, logerrors = 0 )
{
    if ( !isdefined( scriptableinstance ) )
    {
        return false;
    }
    
    scriptableinfo = spawnstruct();
    function_500ec279b11b5d4f( scriptableinstance, rewardcachescriptabletype );
    missingstates = function_9ea4023cf3b02f86( scriptableinstance, scriptableinfo );
    
    if ( missingstates.size != 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace reward_cache
// Params 2, eflags: 0x4
// Checksum 0x23613252, Offset: 0x33dc
// Size: 0x6c
function private function_9ea4023cf3b02f86( scriptableinstance, scriptableinfo )
{
    requiredstates = [ scriptableinfo.var_898c4627b30f2532, scriptableinfo.var_93afa6dd46410b2e, scriptableinfo.var_e7ddc1c3c4d8d8f4 ];
    requiredstates = function_5713d46873b29625( requiredstates );
    return function_447e94aacea60288( scriptableinstance, scriptableinfo.scriptablepartname, requiredstates );
}

// Namespace reward_cache
// Params 3, eflags: 0x4
// Checksum 0x44c676e3, Offset: 0x3451
// Size: 0xa7
function private function_447e94aacea60288( scriptableinstance, partnametocheck, var_a4bd9999ef2b5398 )
{
    missingstates = [];
    
    foreach ( statename in var_a4bd9999ef2b5398 )
    {
        if ( !scriptableinstance getscriptableparthasstate( partnametocheck, statename ) )
        {
            missingstates[ missingstates.size ] = statename;
        }
    }
    
    return missingstates;
}

// Namespace reward_cache
// Params 0, eflags: 0x4
// Checksum 0x95107eae, Offset: 0x3501
// Size: 0x17
function private function_40be0779dff5862e()
{
    return { #resultstatus:0, #resultobject:undefined };
}

// Namespace reward_cache
// Params 1, eflags: 0x4
// Checksum 0xe93f16f0, Offset: 0x3521
// Size: 0x89, Type: bool
function private function_d85d331a04ee9287( workresults )
{
    foreach ( workresult in workresults )
    {
        if ( workresult.resultstatus == 0 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace reward_cache
// Params 1, eflags: 0x4
// Checksum 0xdc048b51, Offset: 0x35b3
// Size: 0x8a, Type: bool
function private function_9b77e11ca1849ba4( workresults )
{
    foreach ( workresult in workresults )
    {
        if ( workresult.resultstatus == 2 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace reward_cache
// Params 0, eflags: 0x4
// Checksum 0xbea958bf, Offset: 0x3646
// Size: 0x17
function private function_3ee888a09a3b40a5()
{
    return max( 1, getdvarint( @"hash_4e2904a76ce33e39", 8 ) );
}

// Namespace reward_cache
// Params 3, eflags: 0x4
// Checksum 0xed49cf28, Offset: 0x3666
// Size: 0x91
function private function_986748fbce1ab36d( spawnoriginworkresult, playergroups, placementstruct )
{
    var_c786523ebe9c85c0 = reward_cache_placement_struct::function_b1657d4dc2601384( placementstruct );
    
    if ( var_c786523ebe9c85c0 )
    {
        var_1d77102df86df295 = spawnstruct();
        function_28b7ccd0aed5fedb( playergroups, placementstruct, var_1d77102df86df295 );
        var_1d77102df86df295 waittill( #"hash_5c2ff3ac36ee1341", spawnorigin );
    }
    else
    {
        spawnorigin = reward_cache_placement_struct::getplacementorigin( placementstruct );
    }
    
    spawnoriginworkresult.resultobject = spawnorigin;
    spawnoriginworkresult.resultstatus = 1;
}

// Namespace reward_cache
// Params 4, eflags: 0x4
// Checksum 0x6fa2d77d, Offset: 0x36ff
// Size: 0x166
function private function_408ce3d853ebf4c( var_f5763015457232f5, playergroups, var_c74a1c6030ca10fb, lootfunctionargs )
{
    playergrouplootstructs = [];
    var_4ecf9903619daba2 = function_3ee888a09a3b40a5();
    var_17b8ab11f4fab80f = ceil( playergroups.size / var_4ecf9903619daba2 );
    var_2355a4d2d198e5e2 = 0;
    var_d63b65d30d1f1ee0 = 0;
    
    foreach ( playergroup in playergroups )
    {
        if ( var_2355a4d2d198e5e2 == var_17b8ab11f4fab80f )
        {
            waitframe();
            var_2355a4d2d198e5e2 = 0;
        }
        
        if ( !isarray( playergroup ) )
        {
            continue;
        }
        
        validplayersingroup = function_fe63057a0c3f3191( playergroup );
        
        if ( validplayersingroup.size == 0 )
        {
            continue;
        }
        
        lootfunctionargs.reward_group = validplayersingroup;
        lootcontents = [[ var_c74a1c6030ca10fb ]]( lootfunctionargs );
        playergrouplootstructs[ playergrouplootstructs.size ] = { #lootcontents:lootcontents, #playergroup:validplayersingroup };
        var_2355a4d2d198e5e2++;
        var_d63b65d30d1f1ee0++;
    }
    
    var_f5763015457232f5.resultobject = playergrouplootstructs;
    var_f5763015457232f5.resultstatus = 1;
}

