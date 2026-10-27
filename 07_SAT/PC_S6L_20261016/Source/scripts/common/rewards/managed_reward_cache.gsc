// scripts\common\rewards\managed_reward_cache.gsc  (hash_68283b3e4663b14f.gscc) (size: 6396 Bytes / 0x18fc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdfcd7b21 (3754785569)
// size ...... 6396 (0x18fc)
// includes .. 4   (offset: 0x18dc)
// strings ... 0   (offset: 0x18fc)
// dev strs .. 0   (offset: 0x18fc)
// exports ... 31  (offset: 0xd3c)
// cseg ...... 0x58 + 0xce4 (0xd3c)
// imports ... 59  (offset: 0x1214)
// animtree1 . 0   (offset: 0x18fc)
// animtree2 . 0   (offset: 0x18fc)
#using scripts\common\callbacks;
#using scripts\common\rewards\reward_cache;
#using scripts\common\rewards\reward_cache_settings;
#using scripts\common\scriptable;

#namespace managed_reward_cache;

// Namespace managed_reward_cache
// Params 10
// Checksum 0xdcfc6c74, Offset: 0x76
// Size: 0x72
function function_62e1e9e8ae541941( rewardcachesettings, rewardcachebehaviorsettings, playergroups, placementstruct, func_openlootablecontainer, var_c74a1c6030ca10fb, lootfunctionargs, func_oncacheitemtaken, func_onitemadded, var_baee98df379448aa )
{
    thread function_b0b4f3eb2302158a( rewardcachesettings, rewardcachebehaviorsettings, playergroups, placementstruct, func_openlootablecontainer, var_c74a1c6030ca10fb, lootfunctionargs, func_oncacheitemtaken, func_onitemadded, var_baee98df379448aa );
}

// Namespace managed_reward_cache
// Params 1
// Checksum 0xfadbaf4e, Offset: 0xf0
// Size: 0x21
function function_c14ca9c329a7c858( managedrewardcache )
{
    if ( function_4860fbccb419e9f4( managedrewardcache ) )
    {
        return;
    }
    
    thread function_ce78812f57b8f1fb( managedrewardcache );
}

// Namespace managed_reward_cache
// Params 3
// Checksum 0x9cd1f2ba, Offset: 0x119
// Size: 0x3d
function function_53efe036928052e8( managedrewardcache, player, lootcontents )
{
    rewardcache = function_bb07ec7c683a525d( managedrewardcache );
    reward_cache::function_ded16316ebf40799( rewardcache, player, lootcontents );
}

// Namespace managed_reward_cache
// Params 2
// Checksum 0x5ebf1f79, Offset: 0x15e
// Size: 0x32
function function_5faff0392b13a93f( managedrewardcache, player )
{
    rewardcache = function_bb07ec7c683a525d( managedrewardcache );
    return reward_cache::function_1b634f56af4b2c30( rewardcache, player );
}

// Namespace managed_reward_cache
// Params 4
// Checksum 0x10de37a, Offset: 0x199
// Size: 0x48
function function_e8b27e2b4f71c42a( managedrewardcache, player, reservedslotindex, item )
{
    rewardcache = function_bb07ec7c683a525d( managedrewardcache );
    reward_cache::function_8cb9542d8aedb5f7( rewardcache, player, reservedslotindex, item );
}

// Namespace managed_reward_cache
// Params 1
// Checksum 0xbc474f60, Offset: 0x1e9
// Size: 0x2e
function function_6c4b2bdaa921d609( managedrewardcache )
{
    if ( isdefined( managedrewardcache ) && managedrewardcache.var_60d815cc9ea0ee96 )
    {
        managedrewardcache.allowdespawn = 0;
    }
}

// Namespace managed_reward_cache
// Params 1
// Checksum 0x6e84eefd, Offset: 0x21f
// Size: 0x4e
function function_91dcd938272d2758( managedrewardcache )
{
    if ( !isdefined( managedrewardcache ) || !managedrewardcache.var_60d815cc9ea0ee96 )
    {
        return;
    }
    
    if ( managedrewardcache.allowdespawn )
    {
        return;
    }
    
    managedrewardcache.allowdespawn = 1;
    managedrewardcache notify( #"allow_despawn" );
}

// Namespace managed_reward_cache
// Params 1
// Checksum 0x1cd0e97d, Offset: 0x275
// Size: 0x36, Type: bool
function function_4860fbccb419e9f4( managedrewardcache )
{
    assert( isdefined( managedrewardcache ) );
    assert( managedrewardcache.var_60d815cc9ea0ee96 );
    return !managedrewardcache.allowdespawn;
}

// Namespace managed_reward_cache
// Params 1, eflags: 0x4
// Checksum 0xad1b1ea4, Offset: 0x2b4
// Size: 0x25
function private function_d3750a49184ae923( managedrewardcache )
{
    if ( function_4860fbccb419e9f4( managedrewardcache ) )
    {
        managedrewardcache waittill( #"allow_despawn" );
    }
}

// Namespace managed_reward_cache
// Params 2, eflags: 0x4
// Checksum 0x9cf0399c, Offset: 0x2e1
// Size: 0x4e
function private function_338f7faf32cb3ea( managedrewardcache, durationseconds )
{
    rewardcache = managedrewardcache.rewardcache;
    rewardcache endon( #"despawn" );
    function_6c4b2bdaa921d609( managedrewardcache );
    wait durationseconds;
    function_91dcd938272d2758( managedrewardcache );
}

// Namespace managed_reward_cache
// Params 10, eflags: 0x4
// Checksum 0x3e93c37f, Offset: 0x337
// Size: 0x110
function private function_b0b4f3eb2302158a( rewardcachesettings, rewardcachebehaviorsettings, playergroups, placementstruct, func_openlootablecontainer, var_c74a1c6030ca10fb, lootfunctionargs, func_oncacheitemtaken, func_onitemadded, var_baee98df379448aa )
{
    if ( !function_26a4d001b3356088() )
    {
        function_402188db6a1d0870();
    }
    
    if ( !isstruct( rewardcachesettings ) || !rewardcachesettings.var_ed9af280ad7bd97c )
    {
        function_b700b19071b0f9c4( var_baee98df379448aa );
        return;
    }
    
    if ( !isdefined( rewardcachebehaviorsettings ) || !isstruct( rewardcachesettings ) || !rewardcachebehaviorsettings.var_3a206bc82beee5c6 )
    {
        function_b700b19071b0f9c4( var_baee98df379448aa );
        return;
    }
    
    function_6153d826a1dc1c2b( rewardcachesettings, rewardcachebehaviorsettings );
    spawndelayseconds = namespace_15dfbdeb8b2ff6b9::getspawndelayseconds( rewardcachebehaviorsettings );
    
    if ( spawndelayseconds > 0 )
    {
        wait spawndelayseconds;
    }
    
    var_2d262fd6dcf3a710 = rewardcachesettings;
    thread function_80188b36823c9f9( var_2d262fd6dcf3a710, var_baee98df379448aa, rewardcachebehaviorsettings );
    reward_cache::spawnrewardcache( rewardcachesettings, playergroups, placementstruct, func_openlootablecontainer, var_c74a1c6030ca10fb, lootfunctionargs, func_oncacheitemtaken, func_onitemadded, var_2d262fd6dcf3a710 );
}

// Namespace managed_reward_cache
// Params 3, eflags: 0x4
// Checksum 0xcfe8abfe, Offset: 0x44f
// Size: 0x83
function private function_80188b36823c9f9( var_2d262fd6dcf3a710, var_baee98df379448aa, rewardcachebehaviorsettings )
{
    var_2d262fd6dcf3a710 waittill( #"hash_4f4a891a302e4c2c", rewardcache );
    
    if ( !isdefined( rewardcache ) )
    {
        function_b700b19071b0f9c4( var_baee98df379448aa );
        return;
    }
    
    managedrewardcache = function_be98659c5d0fae2f( rewardcache, rewardcachebehaviorsettings );
    function_2cbcdc4a24e62ef5( managedrewardcache );
    function_5e35e4ae1369b322( managedrewardcache );
    
    if ( isdefined( var_baee98df379448aa ) )
    {
        var_baee98df379448aa notify( #"hash_db90bb68b59b48ea", managedrewardcache );
    }
}

// Namespace managed_reward_cache
// Params 2, eflags: 0x4
// Checksum 0x72a3f665, Offset: 0x4da
// Size: 0x99
function private function_be98659c5d0fae2f( rewardcache, rewardcachebehaviorsettings )
{
    if ( !isdefined( level.var_35571fb95053f1c2 ) )
    {
        level.var_35571fb95053f1c2 = 0;
    }
    else
    {
        level.var_35571fb95053f1c2++;
    }
    
    managedrewardcache = spawnstruct();
    managedrewardcache.rewardcache = rewardcache;
    managedrewardcache.behaviorsettings = rewardcachebehaviorsettings;
    managedrewardcache.allowdespawn = 1;
    managedrewardcache.id = level.var_35571fb95053f1c2;
    managedrewardcache.var_60d815cc9ea0ee96 = 1;
    return managedrewardcache;
}

// Namespace managed_reward_cache
// Params 0, eflags: 0x4
// Checksum 0x35c0ed61, Offset: 0x57c
// Size: 0xc, Type: bool
function private function_26a4d001b3356088()
{
    return isdefined( level.var_ee3f4f00e3ffc473 );
}

// Namespace managed_reward_cache
// Params 0, eflags: 0x4
// Checksum 0x86f13e91, Offset: 0x591
// Size: 0x42
function private function_402188db6a1d0870()
{
    level.var_ee3f4f00e3ffc473 = [];
    callback::add( #"player_connect", &function_c00388453e7dc3aa );
    callback::add( #"player_disconnect", &function_f9e41a4119386314 );
    scriptable::scriptable_addusedcallback( &reward_cache::function_b7a770407e22d02 );
}

// Namespace managed_reward_cache
// Params 1, eflags: 0x4
// Checksum 0xdfcc66c2, Offset: 0x5db
// Size: 0x23
function private function_5e35e4ae1369b322( managedrewardcache )
{
    level.var_ee3f4f00e3ffc473[ level.var_ee3f4f00e3ffc473.size ] = managedrewardcache;
}

// Namespace managed_reward_cache
// Params 1, eflags: 0x4
// Checksum 0x2471d0cd, Offset: 0x606
// Size: 0x24
function private function_5b8bc7acb8b3c4c3( managedrewardcache )
{
    level.var_ee3f4f00e3ffc473 = arrayremove( level.var_ee3f4f00e3ffc473, managedrewardcache );
}

// Namespace managed_reward_cache
// Params 2, eflags: 0x4
// Checksum 0x47913f10, Offset: 0x632
// Size: 0x2a
function private function_6153d826a1dc1c2b( rewardcachesettings, rewardcachebehaviorsettings )
{
    if ( namespace_15dfbdeb8b2ff6b9::function_1ea817783d320429( rewardcachebehaviorsettings ) )
    {
        reward_cache_settings::function_d1085ce094e377e( rewardcachesettings, 0 );
    }
}

// Namespace managed_reward_cache
// Params 1, eflags: 0x4
// Checksum 0xaf5690ed, Offset: 0x664
// Size: 0xd8
function private function_2cbcdc4a24e62ef5( managedrewardcache )
{
    rewardcache = managedrewardcache.rewardcache;
    despawnwhenempty = namespace_15dfbdeb8b2ff6b9::function_1ea817783d320429( managedrewardcache.behaviorsettings );
    
    if ( despawnwhenempty )
    {
        foreach ( grouprewardcache in rewardcache.grouprewardcaches )
        {
            thread function_9f36b8b0778bd3fe( managedrewardcache, grouprewardcache );
        }
    }
    
    thread function_93cdbf2e045e13d3( managedrewardcache );
    thread function_7d6dfc0f42ab5503( managedrewardcache );
    thread function_90fedd8f3a1d538a( managedrewardcache );
}

// Namespace managed_reward_cache
// Params 2, eflags: 0x4
// Checksum 0x180efe3a, Offset: 0x744
// Size: 0x75
function private function_9f36b8b0778bd3fe( managedrewardcache, grouprewardcache )
{
    rewardcache = grouprewardcache.rewardcacheowner;
    rewardcache endon( #"despawn" );
    
    while ( true )
    {
        grouprewardcache waittill( #"closed" );
        function_d3750a49184ae923( managedrewardcache );
        
        if ( reward_cache::grouprewardcache_isempty( grouprewardcache ) )
        {
            reward_cache::function_5ce279fad829a1be( grouprewardcache );
        }
        
        function_58a0c9b4ebe9b5e2( managedrewardcache );
    }
}

// Namespace managed_reward_cache
// Params 1, eflags: 0x4
// Checksum 0xae64ab4b, Offset: 0x7c1
// Size: 0x60
function private function_93cdbf2e045e13d3( managedrewardcache )
{
    despawntimerseconds = namespace_15dfbdeb8b2ff6b9::function_3b032208530a328e( managedrewardcache.behaviorsettings );
    rewardcache = managedrewardcache.rewardcache;
    rewardcache endon( #"despawn" );
    wait despawntimerseconds;
    function_d3750a49184ae923( managedrewardcache );
    function_c14ca9c329a7c858( managedrewardcache );
}

// Namespace managed_reward_cache
// Params 1, eflags: 0x4
// Checksum 0x68cdcb85, Offset: 0x829
// Size: 0xa0
function private function_7d6dfc0f42ab5503( managedrewardcache )
{
    rewardcache = managedrewardcache.rewardcache;
    rewardcache endon( #"despawn" );
    despawndistance = namespace_15dfbdeb8b2ff6b9::getdespawndistance( managedrewardcache.behaviorsettings );
    despawndistancesquared = despawndistance * despawndistance;
    
    while ( true )
    {
        function_d3750a49184ae923( managedrewardcache );
        playerowners = reward_cache::getplayerowners( rewardcache );
        
        if ( function_7e102644df9fb124( playerowners, reward_cache::function_f4cf6bc9ebcdf5ea( rewardcache ), despawndistancesquared ) )
        {
            function_c14ca9c329a7c858( managedrewardcache );
        }
        
        wait 3;
    }
}

// Namespace managed_reward_cache
// Params 1, eflags: 0x4
// Checksum 0xae18977a, Offset: 0x8d1
// Size: 0x133
function private function_90fedd8f3a1d538a( managedrewardcache )
{
    rewardcache = managedrewardcache.rewardcache;
    rewardcache endon( #"despawn" );
    visibilitydistance = namespace_15dfbdeb8b2ff6b9::function_5874e3ceb9d44ec4( managedrewardcache.behaviorsettings );
    visibilitydistancesquared = visibilitydistance * visibilitydistance;
    
    while ( true )
    {
        var_cb79e4cd3d2f91e9 = 0;
        
        foreach ( player in reward_cache::function_78b44dd54ba16bd8( rewardcache ) )
        {
            if ( !isplayer( player ) )
            {
                if ( !var_cb79e4cd3d2f91e9 )
                {
                    reward_cache::function_6c5a222c320939f0( rewardcache );
                    var_cb79e4cd3d2f91e9 = 1;
                }
                
                continue;
            }
            
            if ( distance2dsquared( player.origin, reward_cache::function_f4cf6bc9ebcdf5ea( rewardcache ) ) > visibilitydistancesquared )
            {
                reward_cache::function_ea1c739324051b81( rewardcache, player );
                continue;
            }
            
            reward_cache::function_cf0329c600b38bc5( rewardcache, player );
        }
        
        wait 0.5;
    }
}

// Namespace managed_reward_cache
// Params 1, eflags: 0x4
// Checksum 0x7d8d02e8, Offset: 0xa0c
// Size: 0x83
function private function_ce78812f57b8f1fb( managedrewardcache )
{
    rewardcache = managedrewardcache.rewardcache;
    rewardcache notify( #"despawn" );
    managedrewardcache notify( #"managed_reward_cache_despawned" );
    rewardcache endon( #"despawn" );
    despawntriggerdelayseconds = namespace_15dfbdeb8b2ff6b9::function_5934560c8b643240( managedrewardcache.behaviorsettings );
    reward_cache::function_68e0647bec178162( rewardcache );
    wait despawntriggerdelayseconds;
    reward_cache::cleanuprewardcache( rewardcache );
    function_5b8bc7acb8b3c4c3( managedrewardcache );
}

// Namespace managed_reward_cache
// Params 1, eflags: 0x4
// Checksum 0x254fecf, Offset: 0xa97
// Size: 0x49
function private function_bb07ec7c683a525d( rewardcachevariant )
{
    if ( !isstruct( rewardcachevariant ) )
    {
        return;
    }
    
    if ( rewardcachevariant.isrewardcache )
    {
        return rewardcachevariant;
    }
    
    if ( rewardcachevariant.var_60d815cc9ea0ee96 )
    {
        return rewardcachevariant.rewardcache;
    }
    
    return;
}

// Namespace managed_reward_cache
// Params 1, eflags: 0x4
// Checksum 0x7202dd02, Offset: 0xae8
// Size: 0x29
function private function_58a0c9b4ebe9b5e2( managedrewardcache )
{
    if ( reward_cache::isempty( managedrewardcache.rewardcache ) )
    {
        function_c14ca9c329a7c858( managedrewardcache );
    }
}

// Namespace managed_reward_cache
// Params 1, eflags: 0x4
// Checksum 0x3f1dcd5a, Offset: 0xb19
// Size: 0x9f
function private function_c00388453e7dc3aa( params )
{
    connectedplayer = self;
    
    foreach ( managedrewardcache in level.var_ee3f4f00e3ffc473 ?? [] )
    {
        reward_cache::function_83a7eac64f333f2( managedrewardcache.rewardcache, connectedplayer );
    }
}

// Namespace managed_reward_cache
// Params 1, eflags: 0x4
// Checksum 0x454aea59, Offset: 0xbc0
// Size: 0x9f
function private function_f9e41a4119386314( params )
{
    disconnectedplayer = self;
    
    foreach ( managedrewardcache in level.var_ee3f4f00e3ffc473 ?? [] )
    {
        reward_cache::function_e4abcad98e325366( managedrewardcache.rewardcache, disconnectedplayer );
    }
}

// Namespace managed_reward_cache
// Params 1, eflags: 0x4
// Checksum 0x7dbcd33c, Offset: 0xc67
// Size: 0x20
function private function_b700b19071b0f9c4( var_d183fae00e665a75 )
{
    if ( isdefined( var_d183fae00e665a75 ) )
    {
        var_d183fae00e665a75 notify( #"hash_db90bb68b59b48ea", undefined );
    }
}

// Namespace managed_reward_cache
// Params 3, eflags: 0x4
// Checksum 0x79e62332, Offset: 0xc8f
// Size: 0xac, Type: bool
function private function_7e102644df9fb124( players, origin, var_37dca7b18a971aaa )
{
    foreach ( player in players )
    {
        if ( isplayer( player ) && distance2dsquared( player.origin, origin ) <= var_37dca7b18a971aaa )
        {
            return false;
        }
    }
    
    return true;
}

