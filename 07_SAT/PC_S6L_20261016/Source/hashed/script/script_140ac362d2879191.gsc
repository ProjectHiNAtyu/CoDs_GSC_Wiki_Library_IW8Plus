// script_140ac362d2879191  (hash_140ac362d2879191.gscc) (size: 7185 Bytes / 0x1c11 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdcbffc12 (3703569426)
// size ...... 7185 (0x1c11)
// includes .. 9   (offset: 0x1a69)
// strings ... 27  (offset: 0x1ab1)
// dev strs .. 0   (offset: 0x1c11)
// exports ... 15  (offset: 0x11b5)
// cseg ...... 0x26d + 0xf48 (0x11b5)
// imports ... 55  (offset: 0x140d)
// animtree1 . 0   (offset: 0x1c11)
// animtree2 . 0   (offset: 0x1c11)
#using scripts\common\script;
#using scripts\common\scriptable;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_supply_drops_common;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dmz\gametypes\dmz_audio;
#using scripts\mp\dmz\gametypes\dmz_task_utils;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\loot\common_cache;

#namespace namespace_7101146850c37273;

// Namespace namespace_7101146850c37273
// Params 1
// Checksum 0x5afffdc1, Offset: 0x28b
// Size: 0x482
function dmztask_getspawndata( data )
{
    level.supplyprops = spawnstruct();
    level.supplyprops.circleradius = getdvarint( @"scr_dmz_supply_circle_radius", 800 );
    level.supplyprops.numcaches = getdvarint( @"scr_dmz_supply_num_caches", 3 );
    level.supplyprops.mindist = getdvarint( @"scr_dmz_supply_min_dist", 1000 );
    level.supplyprops.mindistsq = level.supplyprops.mindist * level.supplyprops.mindist;
    level.supplyprops.maxdist = getdvarint( @"scr_dmz_supply_max_dist", 6000 );
    level.supplyprops.maxdistsq = level.supplyprops.maxdist * level.supplyprops.maxdist;
    level.var_a7ffb4f832eeaf76 = [];
    potentialnodes = [];
    
    for ( i = 0; i < 60 ; i++ )
    {
        pos = ( randomfloatrange( -40000, 40000 ), randomfloatrange( -40000, 40000 ), 0 );
        z = getclosestpointonnavmesh( getgroundposition( pos, 15, 10000, 10000 ) );
        struct = spawnstruct();
        struct.origin = z;
        struct.angles = ( 0, 0, 0 );
        potentialnodes[ potentialnodes.size ] = struct;
    }
    
    foreach ( node in potentialnodes )
    {
        if ( node.taken )
        {
            continue;
        }
        
        node.taken = 1;
        node.nodes = [];
        
        for ( i = 0; i < level.supplyprops.numcaches - 1 ; i++ )
        {
            foreach ( othernode in potentialnodes )
            {
                if ( othernode.taken )
                {
                    continue;
                }
                
                distsq = distance2dsquared( node.origin, othernode.origin );
                
                if ( distsq > level.supplyprops.mindistsq && distsq < level.supplyprops.maxdistsq )
                {
                    node.nodes[ node.nodes.size ] = othernode;
                    othernode.taken = 1;
                    break;
                }
            }
        }
        
        if ( node.nodes.size == level.supplyprops.numcaches - 1 )
        {
            level.var_a7ffb4f832eeaf76[ level.var_a7ffb4f832eeaf76.size ] = node;
            continue;
        }
        
        node.taken = 0;
        
        foreach ( othernode in node.nodes )
        {
            othernode.taken = 0;
        }
    }
    
    scriptable::scriptable_addusedcallbackbypart( "dmz_flare_site_use", &function_24e4e7b3efee9fda );
    level.supplydroptypes[ "dmz_supply_drop" ].onopenfunc = &function_599e67af30d28d9;
    activity_manager::function_f61a1f535aab4194( data, &function_1fc837d6bc695936, level.var_a7ffb4f832eeaf76 );
}

// Namespace namespace_7101146850c37273
// Params 2
// Checksum 0x721b2f6a, Offset: 0x715
// Size: 0xf1
function function_1fc837d6bc695936( activity, node )
{
    task = dmz_task_utils::task_create( activity );
    task.funcs[ "onInit" ] = &function_920398dec18e49e1;
    task.funcs[ "onTeamAssigned" ] = &function_1e8d88e3916d96ae;
    task.funcs[ "onPlayerJoined" ] = &function_8f492b6dd2ca9053;
    task.funcs[ "onPlayerRemoved" ] = &function_160ecede48b8f362;
    task.funcs[ "onTeamStart" ] = &function_8d3f4602182527a6;
    task.funcs[ "onCancel" ] = &function_c43ec1d08c5e1db1;
    task.node = node;
    task.ref = "dmz_supply_explore";
    task.refindex = br_contract_manager::getquesttableindex( task.ref );
    return task;
}

// Namespace namespace_7101146850c37273
// Params 0
// Checksum 0xf6e2a417, Offset: 0x80f
// Size: 0x1d3
function function_920398dec18e49e1()
{
    self.nodes = arraycombine( self.node.nodes, [ self.node ] );
    
    foreach ( node in self.nodes )
    {
        node.site = spawnscriptable( "dmz_flare_site", node.origin, node.angles );
        node.site.task = self;
        node.site.node = node;
        
        foreach ( player in level.players )
        {
            node.site disablescriptableplayeruse( player );
        }
    }
    
    self.activity.origin = self.node.origin;
    dmz_task_utils::function_b3476f99a8e21fa2( self.node.origin + ( 0, 0, 50 ) );
    self.cachesfound = 0;
}

// Namespace namespace_7101146850c37273
// Params 1
// Checksum 0xe515e968, Offset: 0x9ea
// Size: 0xc
function function_8f492b6dd2ca9053( player )
{
    
}

// Namespace namespace_7101146850c37273
// Params 1
// Checksum 0xd192118e, Offset: 0x9fe
// Size: 0x1e
function function_160ecede48b8f362( player )
{
    dmz_task_utils::function_1f01bb1108ba0241( player );
    dmz_task_utils::function_d8d9112f1e68fa2b( player );
}

// Namespace namespace_7101146850c37273
// Params 1
// Checksum 0xe9742490, Offset: 0xa24
// Size: 0x162
function function_1e8d88e3916d96ae( teamname )
{
    players = teams::getteamdata( teamname, "players" );
    dmz_task_utils::function_18b83232055b1325( teamname );
    self.var_84deb5244c7a5c4d = players.size * self.activity.cashreward;
    dmz_task_utils::task_showsplashtoteam( "dmz_supply_assigned", teamname );
    dmz_audio::function_32ff837bc21a4833( teamname, "dmz_activity_start", 1.5, "dmz_activity_start_classic" );
    
    foreach ( node in self.nodes )
    {
        foreach ( player in players )
        {
            node.site enablescriptableplayeruse( player );
        }
    }
    
    function_7ad9a140df3e9496();
}

// Namespace namespace_7101146850c37273
// Params 1
// Checksum 0xc6351401, Offset: 0xb8e
// Size: 0xc
function function_8d3f4602182527a6( teamname )
{
    
}

// Namespace namespace_7101146850c37273
// Params 1
// Checksum 0x1ccd5e95, Offset: 0xba2
// Size: 0x3e
function function_c43ec1d08c5e1db1( teamname )
{
    players = teams::getteamdata( teamname, "players" );
    dmz_audio::function_32ff837bc21a4833( teamname, undefined, undefined );
    dmztask_cleanup();
    dmz_task_utils::task_ended();
}

// Namespace namespace_7101146850c37273
// Params 0
// Checksum 0x81da0837, Offset: 0xbe8
// Size: 0x14
function dmztask_cleanup()
{
    self.taskended = 1;
    dmz_task_utils::function_3ff46488beb193c7();
}

// Namespace namespace_7101146850c37273
// Params 1, eflags: 0x4
// Checksum 0x95d92130, Offset: 0xc04
// Size: 0x40
function private function_638bede66de9a524( teamname )
{
    self notify( #"task_ended" );
    dmztask_cleanup();
    dmz_audio::function_32ff837bc21a4833( teamname, "dmz_activity_win", 1.5, "dmz_activity_win_classic" );
    dmz_task_utils::task_ended( teamname );
}

// Namespace namespace_7101146850c37273
// Params 6
// Checksum 0x9c7625ae, Offset: 0xc4c
// Size: 0x189
function function_24e4e7b3efee9fda( instance, part, state, player, bautouse, usestring )
{
    instance setscriptablepartstate( "dmz_flare_site_use", "unusable" );
    instance setscriptablepartstate( "dmz_flare_site", "dissipate" );
    br_contract_manager::utilflare_shootflare( instance.origin, "dom" );
    instance.task dmz_task_utils::function_844c661c74b52ce3( "dmz_supply_loot" );
    
    if ( isdefined( player.team ) )
    {
        instance.task dmz_task_utils::task_showsplashtoteam( "dmz_supply_fired", player.team );
    }
    
    crate = br_supply_drops_common::function_85cc64e2a6e80987( instance.origin, level.supplydroptypes[ "dmz_supply_drop" ] );
    
    if ( isdefined( crate ) )
    {
        crate.task = instance.task;
        crate.site = instance;
        crate unlink();
        crate physicslaunchserver( crate.origin, ( 0, 0, 0 ) );
        bodyid = crate physics_getbodyid( 0 );
        physics_setbodycenterofmassnormal( bodyid, ( 0, 0, 0 ) );
        crate.physicsactivated = 1;
        crate.usetime = 10;
        crate setscriptablepartstate( "dmz_supply_drop", "usable" );
    }
}

// Namespace namespace_7101146850c37273
// Params 2, eflags: 0x4
// Checksum 0x1d7947f9, Offset: 0xddd
// Size: 0x1b8
function private function_599e67af30d28d9( instance, player )
{
    if ( !( isdefined( player ) && isdefined( player.team ) ) )
    {
        return;
    }
    
    if ( !isdefined( instance.contents ) )
    {
        task = instance.entity.task;
        items = getscriptablelootcachecontents( instance );
        instance.containertype = 3;
        common_cache::function_a09e7cf5bad99b64( instance, items, undefined, player );
        script::demoforcesre( "Removed br_lootcache function ensureCashValueInLootContents here." );
        instance.entity.site.node.opened = 1;
        
        if ( player.team != task.teams[ 0 ] )
        {
            return;
        }
        
        task.cachesfound++;
        
        if ( task.cachesfound >= level.supplyprops.numcaches )
        {
            task function_638bede66de9a524( player.team );
            task dmz_task_utils::task_showsplashtoteam( "dmz_supply_secured", player.team );
            return;
        }
        
        if ( level.supplyprops.numcaches == 2 )
        {
            splash = "dmz_supply_1_2";
        }
        else
        {
            splash = [ "dmz_supply_1_3", "dmz_supply_2_3" ][ task.cachesfound - 1 ];
        }
        
        task dmz_task_utils::task_showsplashtoteam( splash, player.team );
        task function_7ad9a140df3e9496();
        task dmz_task_utils::function_844c661c74b52ce3( "dmz_supply_explore" );
    }
}

// Namespace namespace_7101146850c37273
// Params 0
// Checksum 0x5a4c33cc, Offset: 0xf9d
// Size: 0x1e2
function function_7ad9a140df3e9496()
{
    if ( !isdefined( self.teams[ 0 ] ) )
    {
        return;
    }
    
    players = teams::getteamdata( self.teams[ 0 ], "players" );
    avgpos = ( 0, 0, 0 );
    numplayers = 0;
    
    foreach ( player in players )
    {
        if ( isdefined( player ) && isdefined( player.origin ) )
        {
            avgpos += player.origin;
            numplayers++;
        }
    }
    
    avgpos /= max( numplayers, 1 );
    var_d8dee6424c2af23d = 99999999999;
    closestnode = self.node;
    
    foreach ( node in self.nodes )
    {
        if ( node.opened )
        {
            continue;
        }
        
        distsq = distancesquared( node.origin, avgpos );
        
        if ( distsq < var_d8dee6424c2af23d )
        {
            closestnode = node;
            var_d8dee6424c2af23d = distsq;
        }
    }
    
    dmz_task_utils::function_c74c010e593f5ea5( closestnode.origin + ( 0, 0, 50 ) );
}

/#

    // Namespace namespace_7101146850c37273
    // Params 0
    // Checksum 0xd099e7b1, Offset: 0x1187
    // Size: 0x2e, Type: dev
    function function_9a7498d4c80c1000()
    {
        while ( true )
        {
            sphere( self.origin, 50, ( 1, 1, 0 ), 0, 1 );
            waitframe();
        }
    }

#/
