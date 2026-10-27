// script_844f2da395ef1a3  (hash_0844f2da395ef1a3.gscc) (size: 7908 Bytes / 0x1ee4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf31d2b3 (254923443)
// size ...... 7908 (0x1ee4)
// includes .. 13  (offset: 0x1cf0)
// strings ... 32  (offset: 0x1d58)
// dev strs .. 0   (offset: 0x1ee4)
// exports ... 16  (offset: 0x13c8)
// cseg ...... 0x36b + 0x105d (0x13c8)
// imports ... 57  (offset: 0x1648)
// animtree1 . 0   (offset: 0x1ee4)
// animtree2 . 0   (offset: 0x1ee4)
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\mp\ai_fortress;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_instance_inventory;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dmz\gametypes\dmz_audio;
#using scripts\mp\dmz\gametypes\dmz_task_utils;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\hud_message;
#using scripts\mp\locksandkeys;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item_database;

#namespace namespace_1958d9cb901e3991;

// Namespace namespace_1958d9cb901e3991
// Params 1
// Checksum 0x39f18456, Offset: 0x389
// Size: 0x581
function dmztask_getspawndata( data )
{
    level.scavprops = spawnstruct();
    level.scavprops.circleradius = getdvarint( @"scr_dmz_scav_circle_radius", 800 );
    level.scavprops.numcaches = getdvarint( @"scr_dmz_scav_num_caches", 3 );
    level.scavprops.mindist = getdvarint( @"scr_dmz_scav_min_dist", 1000 );
    level.scavprops.mindistsq = level.scavprops.mindist * level.scavprops.mindist;
    level.scavprops.maxdist = getdvarint( @"scr_dmz_scav_max_dist", 6000 );
    level.scavprops.maxdistsq = level.scavprops.maxdist * level.scavprops.maxdist;
    level.var_6d200bfa4a4bdd60 = [];
    allnodes = getentitylessscriptablearray( "scriptable_dmz_crate_wood", #classname );
    potentialnodes = [];
    
    foreach ( node in allnodes )
    {
        if ( !function_ea4e1febb324038a( node ) )
        {
            potentialnodes[ potentialnodes.size ] = node;
        }
    }
    
    potentialnodes = arrayrandomize( potentialnodes );
    
    foreach ( node in potentialnodes )
    {
        if ( node.taken )
        {
            continue;
        }
        
        node.taken = 1;
        node.nodes = [];
        
        for ( i = 0; i < level.scavprops.numcaches - 1 ; i++ )
        {
            foreach ( othernode in potentialnodes )
            {
                if ( othernode.taken )
                {
                    continue;
                }
                
                var_9e1c9a5f3d552868 = arraycombine( node.nodes, [ node ] );
                withindistance = 1;
                
                foreach ( selectednode in var_9e1c9a5f3d552868 )
                {
                    distsq = distance2dsquared( selectednode.origin, othernode.origin );
                    
                    if ( distsq < level.scavprops.mindistsq || distsq > level.scavprops.maxdistsq )
                    {
                        withindistance = 0;
                        break;
                    }
                }
                
                if ( withindistance )
                {
                    node.nodes[ node.nodes.size ] = othernode;
                    othernode.taken = 1;
                    break;
                }
            }
        }
        
        if ( node.nodes.size == level.scavprops.numcaches - 1 )
        {
            level.var_6d200bfa4a4bdd60[ level.var_6d200bfa4a4bdd60.size ] = node;
            node.var_2a54a0d09c47a115 = 1;
            
            foreach ( othernode in node.nodes )
            {
                othernode.var_2a54a0d09c47a115 = 1;
            }
            
            continue;
        }
        
        node.taken = 0;
        
        foreach ( othernode in node.nodes )
        {
            othernode.taken = 0;
        }
    }
    
    activity_manager::function_f61a1f535aab4194( data, &function_f39de77e5bcbb5c8, level.var_6d200bfa4a4bdd60 );
}

// Namespace namespace_1958d9cb901e3991
// Params 1
// Checksum 0x15ffa73f, Offset: 0x912
// Size: 0x41, Type: bool
function function_ea4e1febb324038a( node )
{
    return ai_fortress::function_5428359c3c1916ac( node.origin ) || locksandkeys::function_9894956c856a7904( node.origin ) || node.islockedcache;
}

// Namespace namespace_1958d9cb901e3991
// Params 2
// Checksum 0x6293c19c, Offset: 0x95c
// Size: 0xf1
function function_f39de77e5bcbb5c8( activity, node )
{
    task = dmz_task_utils::task_create( activity );
    task.funcs[ "onInit" ] = &function_785be084fef03967;
    task.funcs[ "onTeamAssigned" ] = &function_90e2dd0e0c78ff50;
    task.funcs[ "onPlayerJoined" ] = &function_2ad6fbb1d7455535;
    task.funcs[ "onPlayerRemoved" ] = &function_28b1c92017b7c30;
    task.funcs[ "onTeamStart" ] = &function_7b64cfad87d2fd4;
    task.funcs[ "onCancel" ] = &function_3824a5c5d2221fb7;
    task.node = node;
    task.ref = "dmz_scav";
    task.refindex = br_contract_manager::getquesttableindex( task.ref );
    return task;
}

// Namespace namespace_1958d9cb901e3991
// Params 0
// Checksum 0xe8e83b7b, Offset: 0xa56
// Size: 0x228
function function_785be084fef03967()
{
    self.nodes = arraycombine( self.node.nodes, [ self.node ] );
    
    foreach ( node in self.nodes )
    {
        node.task = self;
        node.var_6e39895e14c70e34 = &function_599e67af30d28d9;
    }
    
    foreach ( node in self.nodes )
    {
        if ( function_ea4e1febb324038a( node ) )
        {
            dmztask_cleanup();
            dmz_task_utils::task_ended();
            return;
        }
    }
    
    self.itemorder = arrayrandomize( [ "brloot_plate_carrier_2", "brloot_backpack_medium", "brloot_self_revive" ] );
    self.var_d9d807cb2cf6cb53 = arrayrandomize( [ "brloot_plate_carrier_2_medic", "brloot_plate_carrier_2_comms", "brloot_plate_carrier_2_stealth", "brloot_plate_carrier_3", "brloot_equip_gasmask_scuba", "brloot_equip_gasmask_durable", "brloot_backpack_large", "brloot_battlerage_self_revive", "brloot_super_self_revive_box", "brloot_super_armorbox" ] );
    self.activity.origin = self.node.origin;
    dmz_task_utils::function_b3476f99a8e21fa2( self.node.origin + ( 0, 0, 50 ) );
    self.cachesfound = 0;
}

// Namespace namespace_1958d9cb901e3991
// Params 1
// Checksum 0xfb1a8454, Offset: 0xc86
// Size: 0x1e
function function_2ad6fbb1d7455535( player )
{
    dmz_task_utils::function_6277bd2a0d5a28b9( player );
    dmz_task_utils::function_dc6a173a36eef985( player );
}

// Namespace namespace_1958d9cb901e3991
// Params 1
// Checksum 0xc7fa9cf0, Offset: 0xcac
// Size: 0x1e
function function_28b1c92017b7c30( player )
{
    dmz_task_utils::function_1f01bb1108ba0241( player );
    dmz_task_utils::function_d8d9112f1e68fa2b( player );
}

// Namespace namespace_1958d9cb901e3991
// Params 1
// Checksum 0xdb3f2c09, Offset: 0xcd2
// Size: 0x9c
function function_90e2dd0e0c78ff50( teamname )
{
    players = teams::getteamdata( teamname, "players" );
    dmz_task_utils::function_18b83232055b1325( teamname );
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"supply_assigned", teamname, 3 );
    self.var_84deb5244c7a5c4d = dmz_task_utils::function_f15515a374b8ebf2( teamname );
    dmz_task_utils::task_showsplashtoteam( "dmz_supply_assigned", teamname );
    dmz_audio::function_32ff837bc21a4833( teamname, "dmz_activity_start", 1.5, "dmz_activity_start_classic" );
    function_7ad9a140df3e9496();
    function_8e6248bcffe43b04();
}

// Namespace namespace_1958d9cb901e3991
// Params 1
// Checksum 0x12de2a71, Offset: 0xd76
// Size: 0xc
function function_7b64cfad87d2fd4( teamname )
{
    
}

// Namespace namespace_1958d9cb901e3991
// Params 1
// Checksum 0xe7eff9ec, Offset: 0xd8a
// Size: 0x3e
function function_3824a5c5d2221fb7( teamname )
{
    players = teams::getteamdata( teamname, "players" );
    dmz_audio::function_32ff837bc21a4833( teamname, undefined, undefined );
    dmztask_cleanup();
    dmz_task_utils::task_ended();
}

// Namespace namespace_1958d9cb901e3991
// Params 0
// Checksum 0x410743d5, Offset: 0xdd0
// Size: 0x14
function dmztask_cleanup()
{
    self.taskended = 1;
    dmz_task_utils::function_3ff46488beb193c7();
}

// Namespace namespace_1958d9cb901e3991
// Params 1, eflags: 0x4
// Checksum 0xb6ee07ad, Offset: 0xdec
// Size: 0x69
function private function_eb83851aa840e45e( teamname )
{
    self notify( #"task_ended" );
    dmztask_cleanup();
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"supply_win", teamname, 3 );
    dmz_audio::function_32ff837bc21a4833( teamname, "dmz_activity_win", 1.5, "dmz_activity_win_classic" );
    dmz_task_utils::task_ended( teamname );
}

// Namespace namespace_1958d9cb901e3991
// Params 2, eflags: 0x4
// Checksum 0x2e76ceca, Offset: 0xe5d
// Size: 0x31d
function private function_599e67af30d28d9( instance, player )
{
    if ( !( isdefined( player ) && isdefined( player.team ) ) )
    {
        return;
    }
    
    if ( !( isdefined( instance.task ) && isdefined( instance.task.teams[ 0 ] ) ) || player.team != instance.task.teams[ 0 ] || instance.task.taskended )
    {
        player hud_message::showerrormessage( %"MP_DMZ_MISSIONS/GEIGER_SEARCH_GC_CACHE_ERR" );
        return 0;
    }
    
    if ( !isdefined( instance.taskopened ) )
    {
        task = instance.task;
        items = getscriptablelootcachecontents( instance );
        instance.containertype = 3;
        common_cache::function_a09e7cf5bad99b64( instance, items, undefined, player );
        script::demoforcesre( "Removed br_lootcache function ensureCashValueInLootContents here." );
        var_72d58899a8793609 = task.itemorder[ task.cachesfound ];
        itembundlename = common_item_database::function_ca9ca606e66b5911( var_72d58899a8793609 );
        common_cache::cache_additem( instance, itembundlename, 1, undefined, player );
        upgradecount = br_instance_inventory::function_f27d28bab3135f68( player.team, 24 );
        
        if ( upgradecount )
        {
            chances = [ 0.5, 0.75, 0.95 ];
            chance = chances[ upgradecount - 1 ];
            
            if ( randomfloat( 1 ) < chance )
            {
                var_af53dfa9cba99889 = task.var_d9d807cb2cf6cb53[ task.cachesfound ];
                itembundlename = common_item_database::function_ca9ca606e66b5911( var_af53dfa9cba99889 );
                common_cache::cache_additem( instance, itembundlename, 1, undefined, player );
            }
        }
        
        instance.opened = 1;
        instance.taskopened = 1;
        task.cachesfound++;
        task function_8e6248bcffe43b04();
        
        if ( task.cachesfound >= level.scavprops.numcaches )
        {
            task function_eb83851aa840e45e( player.team );
            task dmz_task_utils::task_showsplashtoteam( "dmz_supply_secured", player.team );
            return;
        }
        
        if ( level.scavprops.numcaches == 2 )
        {
            splash = "dmz_supply_1_2";
        }
        else
        {
            splash = [ "dmz_supply_2_3", "dmz_supply_1_3" ][ task.cachesfound - 1 ];
        }
        
        task dmz_task_utils::task_showsplashtoteam( splash, player.team );
        task function_7ad9a140df3e9496();
        task dmz_task_utils::function_844c661c74b52ce3( "dmz_scav" );
        utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"supply_secured", player.team, 3 );
    }
}

// Namespace namespace_1958d9cb901e3991
// Params 0
// Checksum 0x9a91782e, Offset: 0x1182
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

// Namespace namespace_1958d9cb901e3991
// Params 0
// Checksum 0x808e656d, Offset: 0x136c
// Size: 0x26
function function_8e6248bcffe43b04()
{
    br_contract_manager::function_9fe564137142e8ee( level.scavprops.numcaches - self.cachesfound );
}

/#

    // Namespace namespace_1958d9cb901e3991
    // Params 0
    // Checksum 0x19b5e919, Offset: 0x139a
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
