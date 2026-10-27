// script_45583617ae826370  (hash_45583617ae826370.gscc) (size: 15437 Bytes / 0x3c4d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb87403a1 (3094610849)
// size ...... 15437 (0x3c4d)
// includes .. 23  (offset: 0x3939)
// strings ... 38  (offset: 0x39f1)
// dev strs .. 4   (offset: 0x3c19)
// exports ... 29  (offset: 0x27b5)
// cseg ...... 0x3af + 0x2406 (0x27b5)
// imports ... 105 (offset: 0x2c3d)
// animtree1 . 0   (offset: 0x3c4d)
// animtree2 . 0   (offset: 0x3c4d)
#using script_599653855a4317f1;
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\mp\ai_fortress;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_dmz_radiation;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\common\equipment\geiger_counter;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dmz\gametypes\dmz_audio;
#using scripts\mp\dmz\gametypes\dmz_task_utils;
#using scripts\mp\equipment;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\hud_message;
#using scripts\mp\locksandkeys;
#using scripts\mp\loot;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\poi;

#namespace namespace_4c5dd9edb2d6e4a8;

// Namespace namespace_4c5dd9edb2d6e4a8
// Params 1
// Checksum 0x40f45701, Offset: 0x3cd
// Size: 0x6e8
function dmztask_getspawndata( data )
{
    level.geigerprops = spawnstruct();
    level.geigerprops.circleradius = getdvarint( @"hash_9cbb7d15274d1400", 2000 );
    level.geigerprops.circlepadding = getdvarint( @"hash_22afe1c9474c402b", 250 );
    level.geigerprops.numcaches = getdvarint( @"hash_a4e9af7f9b4f5f27", 3 );
    level.geigerprops.minseparation = getdvarint( @"hash_a238c865cc6af24c", 3500 );
    level.geigerprops.maxseparation = getdvarint( @"hash_4eef3124e0eeba7e", 6000 );
    level.geigerprops.neardist = getdvarint( @"hash_7ec9710223dce350", 1750 );
    level.geigerprops.neardistsq = level.geigerprops.neardist * level.geigerprops.neardist;
    level.geigerprops.var_d4fcd6944f2d9a56 = level.geigerprops.minseparation * level.geigerprops.minseparation;
    level.geigerprops.var_3a58878074599120 = level.geigerprops.maxseparation * level.geigerprops.maxseparation;
    geiger_counter::geigercounter_init();
    level.var_9ab3d73fe300dbbe = [];
    allnodes = arrayrandomize( utility::getstructarray( "dmz_hidden_container", "script_noteworthy" ) );
    potentialnodes = [];
    
    foreach ( node in allnodes )
    {
        if ( br_dmz_radiation::function_704454416dce7454( node.origin ) )
        {
            continue;
        }
        
        potentialnodes[ potentialnodes.size ] = node;
    }
    
    nodegroups = [];
    
    foreach ( node in potentialnodes )
    {
        if ( node.picked )
        {
            continue;
        }
        
        node.allnodes = [ node ];
        
        for ( cache = 1; cache < level.geigerprops.numcaches ; cache++ )
        {
            for ( idx = 0; idx < potentialnodes.size ; idx++ )
            {
                possiblenode = potentialnodes[ idx ];
                
                if ( possiblenode.picked )
                {
                    continue;
                }
                
                inrange = 1;
                
                foreach ( chosennode in node.allnodes )
                {
                    dist = distance2dsquared( possiblenode.origin, chosennode.origin );
                    
                    if ( dist < level.geigerprops.var_d4fcd6944f2d9a56 || dist > level.geigerprops.var_3a58878074599120 )
                    {
                        inrange = 0;
                        break;
                    }
                }
                
                if ( inrange )
                {
                    node.allnodes[ node.allnodes.size ] = possiblenode;
                    break;
                }
            }
        }
        
        if ( node.allnodes.size == level.geigerprops.numcaches )
        {
            nodegroups[ nodegroups.size ] = node;
            
            foreach ( chosennode in node.allnodes )
            {
                chosennode.picked = 1;
            }
        }
    }
    
    foreach ( node in nodegroups )
    {
        nearbytoolboxes = getentitylessscriptablearray( "scriptable_cache_toolbox", #classname, node.origin, 7500 );
        
        if ( nearbytoolboxes.size )
        {
            idealdist = 1500;
            bestdiff = 999999999;
            bestcache = undefined;
            
            foreach ( cache in nearbytoolboxes )
            {
                if ( cache.choosen || !function_abc0712a4db8c287( cache ) )
                {
                    continue;
                }
                
                diff = abs( distance( node.origin, cache.origin ) - idealdist );
                
                if ( diff < bestdiff )
                {
                    bestdiff = diff;
                    bestcache = cache;
                    
                    if ( bestdiff < 300 )
                    {
                        break;
                    }
                }
            }
            
            if ( isdefined( bestcache ) )
            {
                node.var_b1221b9ada64e1f2 = bestcache;
                bestcache.choosen = 1;
                level.var_9ab3d73fe300dbbe[ level.var_9ab3d73fe300dbbe.size ] = node;
            }
        }
    }
    
    level.missionitemcallbacks[ "brloot_valuable_fuelrods" ] = &function_d4171e834baa4661;
    level.var_f9b5071f732e0bef[ "brloot_valuable_fuelrods" ] = &function_8e898fd1374fd509;
    thread function_2d9e678357d7113b();
    activity_manager::function_f61a1f535aab4194( data, &function_fce7b1f43ee45b8e, level.var_9ab3d73fe300dbbe );
}

/#

    // Namespace namespace_4c5dd9edb2d6e4a8
    // Params 0
    // Checksum 0x5d9fbda1, Offset: 0xabd
    // Size: 0x16, Type: dev
    function function_746bdfc760ec9b18()
    {
        return utility::getstructarray( "<dev string:x24>", "<dev string:x39>" );
    }

#/

// Namespace namespace_4c5dd9edb2d6e4a8
// Params 2
// Checksum 0xe2ec44d9, Offset: 0xadb
// Size: 0x108
function function_fce7b1f43ee45b8e( activity, node )
{
    task = dmz_task_utils::task_create( activity );
    task.funcs[ "onInit" ] = &function_fe60a45b41cf5729;
    task.funcs[ "onTeamAssigned" ] = &function_72a20cea4a9c2836;
    task.funcs[ "onPlayerJoined" ] = &function_e4979136e15858ab;
    task.funcs[ "onPlayerRemoved" ] = &function_d6a65e032b56ca6a;
    task.funcs[ "onTeamStart" ] = &function_4a3e40c7afda1cbe;
    task.funcs[ "onCancel" ] = &function_171c5f11e493fd09;
    task.node = node;
    task.nodes = node.allnodes;
    task.ref = "dmz_geiger_search_explore";
    task.refindex = br_contract_manager::getquesttableindex( task.ref );
    return task;
}

// Namespace namespace_4c5dd9edb2d6e4a8
// Params 0
// Checksum 0xff66316b, Offset: 0xbec
// Size: 0x338
function function_fe60a45b41cf5729()
{
    self.caches = [];
    circlelocations = [];
    
    foreach ( index, node in self.nodes )
    {
        cache = spawnscriptable( "dmz_hidden_container", node.origin, node.angles );
        cache.var_6e39895e14c70e34 = &function_599e67af30d28d9;
        self.caches[ index ] = cache;
        cache.task = self;
        circlelocations[ circlelocations.size ] = dmz_task_utils::function_c7ccd46fc59f189d( cache.origin, level.geigerprops.circleradius );
        cache.cacheindex = index;
        cache setscriptablepartstate( "body", "closed_unusable" );
        
        /#
            dmz_logging::addlogevent( "<dev string:x4b>", self.activity.name, undefined, "<dev string:x24>", undefined, undefined, self.activity.script_poi, node.origin );
        #/
        
        geiger_counter::function_69cfcbb5ee5bfc98( cache );
    }
    
    self.activity.origin = self.nodes[ 0 ].origin;
    dmz_task_utils::function_13fe84cb824c72a8( "Explore_Dmz", circlelocations, level.geigerprops.circleradius + level.geigerprops.circlepadding );
    pos = ( 0, 0, 0 );
    
    foreach ( loc in circlelocations )
    {
        pos += loc;
    }
    
    pos /= circlelocations.size;
    dmz_task_utils::function_b3476f99a8e21fa2( pos + ( 0, 0, 750 ) );
    self.cachesfound = 0;
    
    if ( self.caches.size < level.geigerprops.numcaches )
    {
        dmztask_cleanup();
        dmz_task_utils::task_ended();
        return;
    }
    
    self.var_b1221b9ada64e1f2 = self.node.var_b1221b9ada64e1f2;
    
    if ( !function_abc0712a4db8c287( self.var_b1221b9ada64e1f2 ) )
    {
        dmztask_cleanup();
        dmz_task_utils::task_ended();
        return;
    }
    
    self.geigercountercontainer = self.node.var_b1221b9ada64e1f2;
    self.geigercountercontainer.var_6e39895e14c70e34 = &function_4e780ba79965d014;
    self.geigercountercontainer.task = self;
}

// Namespace namespace_4c5dd9edb2d6e4a8
// Params 1
// Checksum 0x7862e421, Offset: 0xf2c
// Size: 0xf7
function function_e4979136e15858ab( player )
{
    if ( !isdefined( self.geigercountercontainer.playercontents[ player.guid ] ) )
    {
        itembundlename = common_item_database::function_ca9ca606e66b5911( "brloot_offhand_geigercounter" );
        common_cache::function_990ee9d9acd2d1d5( self.geigercountercontainer, player, itembundlename, 1 );
        loot_mp::function_c1bd3db63e64bad1( player, self.geigercountercontainer, self.geigercountercontainer.contents );
    }
    
    foreach ( cache in self.caches )
    {
        cache enablescriptableplayeruse( player );
    }
}

// Namespace namespace_4c5dd9edb2d6e4a8
// Params 1
// Checksum 0xedf5dc18, Offset: 0x102b
// Size: 0xb3
function function_d6a65e032b56ca6a( player )
{
    dmz_task_utils::function_1f01bb1108ba0241( player );
    dmz_task_utils::function_d8d9112f1e68fa2b( player );
    
    if ( isdefined( self.cacheicon ) )
    {
        self.cacheicon dmz_task_utils::function_3ff46488beb193c7();
    }
    
    foreach ( cache in self.caches )
    {
        cache disablescriptableplayeruse( player );
    }
}

// Namespace namespace_4c5dd9edb2d6e4a8
// Params 1
// Checksum 0xc5991c41, Offset: 0x10e6
// Size: 0x54f
function function_72a20cea4a9c2836( teamname )
{
    players = teams::getteamdata( teamname, "players" );
    
    if ( !isdefined( self.geigercountercontainer.contents ) )
    {
        items = getscriptablelootcachecontents( self.geigercountercontainer );
        self.geigercountercontainer.containertype = 3;
        common_cache::function_a09e7cf5bad99b64( self.geigercountercontainer, items );
    }
    
    foreach ( player in players )
    {
        if ( !( isdefined( self.geigercountercontainer.playercontents ) && isdefined( self.geigercountercontainer.playercontents[ player.guid ] ) ) )
        {
            itembundlename = common_item_database::function_ca9ca606e66b5911( "brloot_offhand_geigercounter" );
            common_cache::function_990ee9d9acd2d1d5( self.geigercountercontainer, player, itembundlename, 1 );
            loot_mp::function_c1bd3db63e64bad1( player, self.geigercountercontainer, self.geigercountercontainer.contents );
        }
    }
    
    var_1afe20bbff3968cd = function_ad8de335d42f1aca();
    
    if ( var_1afe20bbff3968cd )
    {
        index = br_contract_manager::getquesttableindex( "dmz_geiger_search_loot" );
        dmz_task_utils::function_c74c010e593f5ea5( self.geigercountercontainer.origin + ( 0, 0, 15 ) );
        self.cacheicon = spawnstruct();
        self.cacheicon dmz_task_utils::function_b3476f99a8e21fa2( function_cbc6807c50928826(), "recon" );
        
        foreach ( player in players )
        {
            if ( player function_4430189911111bed() )
            {
                dmz_task_utils::function_6277bd2a0d5a28b9( player );
                function_374ea404765613de( player );
                function_c3a38d777deaa201( player );
                continue;
            }
            
            dmz_task_utils::function_1f01bb1108ba0241( player );
            function_642e8155efac0367( player );
            dmz_task_utils::function_d1003180abd8ac5f( player, index );
        }
    }
    else
    {
        foreach ( player in players )
        {
            player.var_497b2e4675d21f26 = 1;
        }
        
        dmz_task_utils::function_18b83232055b1325( teamname );
    }
    
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"geiger_search_assigned", teamname, 3 );
    self.var_84deb5244c7a5c4d = dmz_task_utils::function_f15515a374b8ebf2( teamname );
    
    foreach ( cache in self.caches )
    {
        cache setscriptablepartstate( "body", "closed_usable" );
        
        foreach ( player in level.players )
        {
            cache disablescriptableplayeruse( player );
        }
        
        foreach ( player in players )
        {
            cache enablescriptableplayeruse( player );
        }
    }
    
    dmz_task_utils::task_showsplashtoteam( "dmz_geiger_assigned", teamname );
    dmz_audio::function_32ff837bc21a4833( teamname, "dmz_activity_start", 1.5, "dmz_activity_start_classic" );
    
    foreach ( player in players )
    {
        player br_contract_manager::uiobjectivesetparameter( level.geigerprops.numcaches - self.cachesfound );
    }
    
    thread function_731e9709142cd684( teamname );
    thread function_c01220e3266a3b33( teamname );
}

// Namespace namespace_4c5dd9edb2d6e4a8
// Params 1
// Checksum 0x59ea5aa, Offset: 0x163d
// Size: 0xc
function function_4a3e40c7afda1cbe( teamname )
{
    
}

// Namespace namespace_4c5dd9edb2d6e4a8
// Params 1
// Checksum 0x4c91115c, Offset: 0x1651
// Size: 0x11b
function function_171c5f11e493fd09( teamname )
{
    players = teams::getteamdata( teamname, "players" );
    
    foreach ( player in players )
    {
        foreach ( cache in self.caches )
        {
            cache disablescriptableplayeruse( player );
        }
    }
    
    dmz_audio::function_32ff837bc21a4833( teamname, undefined, undefined );
    dmztask_cleanup();
    dmz_task_utils::task_ended();
}

// Namespace namespace_4c5dd9edb2d6e4a8
// Params 0
// Checksum 0xd22a30a2, Offset: 0x1774
// Size: 0x38
function dmztask_cleanup()
{
    self.taskended = 1;
    dmz_task_utils::function_3ff46488beb193c7();
    
    if ( isdefined( self.cacheicon ) )
    {
        self.cacheicon dmz_task_utils::function_3ff46488beb193c7();
    }
    
    dmz_task_utils::function_e23cad864e9e2023();
}

// Namespace namespace_4c5dd9edb2d6e4a8
// Params 1, eflags: 0x4
// Checksum 0xba82203c, Offset: 0x17b4
// Size: 0x69
function private function_8c9c850384d7f05c( teamname )
{
    self notify( #"task_ended" );
    dmztask_cleanup();
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"geiger_search_win", teamname, 3 );
    dmz_audio::function_32ff837bc21a4833( teamname, "dmz_activity_win", 1.5, "dmz_activity_win_classic" );
    dmz_task_utils::task_ended( teamname );
}

// Namespace namespace_4c5dd9edb2d6e4a8
// Params 0
// Checksum 0x20d7a39c, Offset: 0x1825
// Size: 0x69, Type: bool
function function_4430189911111bed()
{
    curr = equipment_mp::getcurrentequipment( "secondary" );
    equipammo = equipment_mp::getequipmentslotammo( "secondary" );
    lootid = loot::getlootidfromref( "equip_geigercounter" );
    count = common_inventory::function_99741e85ee9c3d18( lootid );
    return curr == "equip_geigercounter" && equipammo || count;
}

// Namespace namespace_4c5dd9edb2d6e4a8
// Params 0
// Checksum 0xa7622dbc, Offset: 0x1897
// Size: 0xa9
function function_ad8de335d42f1aca()
{
    teammates = teams::getteamdata( self.teams[ 0 ], "players" );
    var_ca867ad7a4e184e1 = 0;
    
    foreach ( teammate in teammates )
    {
        if ( teammate function_4430189911111bed() )
        {
            continue;
        }
        
        var_ca867ad7a4e184e1++;
    }
    
    return var_ca867ad7a4e184e1;
}

// Namespace namespace_4c5dd9edb2d6e4a8
// Params 1
// Checksum 0x3872f2, Offset: 0x1949
// Size: 0x44, Type: bool
function function_abc0712a4db8c287( cache )
{
    return !ai_fortress::function_5428359c3c1916ac( cache.origin ) && !locksandkeys::function_9894956c856a7904( cache.origin ) && !cache.islockedcache;
}

// Namespace namespace_4c5dd9edb2d6e4a8
// Params 2
// Checksum 0x2d088a00, Offset: 0x1996
// Size: 0x124
function function_4e780ba79965d014( instance, player )
{
    if ( !( isdefined( instance.task ) && isdefined( instance.task.teams[ 0 ] ) ) || player.team != instance.task.teams[ 0 ] || instance.task.taskended )
    {
        player hud_message::showerrormessage( %"MP_DMZ_MISSIONS/GEIGER_SEARCH_GC_CACHE_ERR" );
        return 0;
    }
    
    if ( !isdefined( instance.contents ) )
    {
        items = getscriptablelootcachecontents( instance );
        instance.containertype = 3;
        common_cache::function_a09e7cf5bad99b64( instance, items, undefined, player );
    }
    
    if ( !isdefined( instance.playercontents[ player.guid ] ) )
    {
        itembundlename = common_item_database::function_ca9ca606e66b5911( "brloot_offhand_geigercounter" );
        common_cache::function_990ee9d9acd2d1d5( instance, player, itembundlename, 1 );
        loot_mp::function_c1bd3db63e64bad1( player, instance, instance.contents );
    }
}

// Namespace namespace_4c5dd9edb2d6e4a8
// Params 2, eflags: 0x4
// Checksum 0x349fe5ca, Offset: 0x1ac2
// Size: 0x5e
function private function_599e67af30d28d9( instance, player )
{
    if ( !isdefined( instance.contents ) )
    {
        items = getscriptablelootcachecontents( instance );
        instance.containertype = 3;
        common_cache::function_a09e7cf5bad99b64( instance, items, undefined, player );
        script::demoforcesre( "Removed br_lootcache function ensureCashValueInLootContents here." );
    }
}

// Namespace namespace_4c5dd9edb2d6e4a8
// Params 2, eflags: 0x4
// Checksum 0x1077655a, Offset: 0x1b28
// Size: 0xa5
function private function_d4171e834baa4661( instance, player )
{
    if ( isdefined( player.var_50f741a14f09a6 ) && isdefined( player.var_50f741a14f09a6.task ) )
    {
        cache = player.var_50f741a14f09a6;
        task = cache.task;
        
        if ( task.taskended )
        {
            return 34;
        }
        
        if ( common_inventory::function_5c64d2b24a8c3e18() )
        {
            return player br_pickups::function_3a6d2dc9abde2071( instance );
        }
        
        return 34;
    }
    
    if ( common_inventory::function_5c64d2b24a8c3e18() )
    {
        return player br_pickups::function_3a6d2dc9abde2071( instance );
    }
    
    return 34;
}

// Namespace namespace_4c5dd9edb2d6e4a8
// Params 2
// Checksum 0xd85a91e0, Offset: 0x1bd6
// Size: 0x2f3
function function_8e898fd1374fd509( pickup, player )
{
    if ( isdefined( player.var_50f741a14f09a6 ) && isdefined( player.var_50f741a14f09a6.task ) )
    {
        cache = player.var_50f741a14f09a6;
        task = cache.task;
        task dmz_task_utils::function_d0fab7ddae4ada22( cache.cacheindex );
        task.cachesfound++;
        cache.found = 1;
        geiger_counter::function_54886797fcd30128( cache );
        players = teams::getteamdata( task.teams[ 0 ], "players" );
        
        foreach ( player in players )
        {
            player br_contract_manager::uiobjectivesetparameter( level.geigerprops.numcaches - task.cachesfound );
        }
        
        splash = undefined;
        
        if ( level.geigerprops.numcaches == 1 )
        {
            splash = "dmz_geiger_complete";
        }
        
        if ( level.geigerprops.numcaches == 2 )
        {
            c = [ "dmz_geiger_first_found_out_of_two", "dmz_geiger_complete" ];
            splash = c[ task.cachesfound - 1 ];
        }
        
        if ( level.geigerprops.numcaches == 3 )
        {
            c = [ "dmz_geiger_first_found", "dmz_geiger_second_found", "dmz_geiger_complete" ];
            splash = c[ task.cachesfound - 1 ];
        }
        
        if ( task.cachesfound == level.geigerprops.numcaches )
        {
            task dmz_task_utils::function_c64a66646904bc1( splash, "geiger", task.activity.cashreward, player.team );
            task function_8c9c850384d7f05c( player.team );
            dmz_audio::function_32ff837bc21a4833( player.team, "dmz_activity_win", 1.5, "dmz_activity_win_classic" );
            return;
        }
        
        br_gametype_dmz::showdmzsplash( splash, teams::getteamdata( player.team, "players" ) );
        task function_f9129688d9a38b1();
        dmz_audio::function_32ff837bc21a4833( player.team, "dmz_geigersearch_pickups", 0, "dmz_geigersearch_pickups_classic" );
        dmz_audio::function_32ff837bc21a4833( player.team, "", 8 );
    }
}

// Namespace namespace_4c5dd9edb2d6e4a8
// Params 0
// Checksum 0xc6630abc, Offset: 0x1ed1
// Size: 0x1a8
function function_cbc6807c50928826()
{
    pos = ( 0, 0, 0 );
    
    foreach ( circle in self.questcircles )
    {
        if ( isdefined( circle ) && isdefined( circle.mapcircle ) )
        {
            pos += circle.mapcircle.origin;
        }
    }
    
    var_3bbaea92d59c7c8c = max( 1, level.geigerprops.numcaches - self.cachesfound );
    pos /= var_3bbaea92d59c7c8c;
    height = 0;
    
    foreach ( cache in self.caches )
    {
        if ( !cache.found )
        {
            height += cache.origin[ 2 ];
        }
    }
    
    height /= var_3bbaea92d59c7c8c;
    pos = ( pos[ 0 ], pos[ 1 ], height );
    return pos + ( 0, 0, 750 );
}

// Namespace namespace_4c5dd9edb2d6e4a8
// Params 0
// Checksum 0x2d659ce0, Offset: 0x2082
// Size: 0x3f
function function_f9129688d9a38b1()
{
    pos = function_cbc6807c50928826();
    
    if ( isdefined( self.cacheicon ) )
    {
        self.cacheicon dmz_task_utils::function_c74c010e593f5ea5( pos );
        return;
    }
    
    dmz_task_utils::function_c74c010e593f5ea5( pos );
}

// Namespace namespace_4c5dd9edb2d6e4a8
// Params 1
// Checksum 0x6b875a4f, Offset: 0x20c9
// Size: 0x37
function function_374ea404765613de( player )
{
    if ( isdefined( self.cacheicon ) )
    {
        self.cacheicon dmz_task_utils::function_dc6a173a36eef985( player );
        return;
    }
    
    dmz_task_utils::function_dc6a173a36eef985( player );
}

// Namespace namespace_4c5dd9edb2d6e4a8
// Params 1
// Checksum 0x18935d4f, Offset: 0x2108
// Size: 0x37
function function_642e8155efac0367( player )
{
    if ( isdefined( self.cacheicon ) )
    {
        self.cacheicon dmz_task_utils::function_d8d9112f1e68fa2b( player );
        return;
    }
    
    dmz_task_utils::function_d8d9112f1e68fa2b( player );
}

// Namespace namespace_4c5dd9edb2d6e4a8
// Params 1
// Checksum 0x9e9ddf95, Offset: 0x2147
// Size: 0x22
function function_3204a80da0d45662( player )
{
    if ( isdefined( self.cacheicon ) )
    {
        dmz_task_utils::function_dc6a173a36eef985( player );
    }
}

// Namespace namespace_4c5dd9edb2d6e4a8
// Params 1
// Checksum 0xc7faef40, Offset: 0x2171
// Size: 0x22
function function_c3a38d777deaa201( player )
{
    if ( isdefined( self.cacheicon ) )
    {
        dmz_task_utils::function_d8d9112f1e68fa2b( player );
    }
}

// Namespace namespace_4c5dd9edb2d6e4a8
// Params 1
// Checksum 0xbe8735a0, Offset: 0x219b
// Size: 0x105
function function_731e9709142cd684( teamname )
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    
    while ( true )
    {
        players = teams::getteamdata( teamname, "players" );
        
        foreach ( player in players )
        {
            if ( isdefined( player.geigercounterstruct ) && player.geigercounterstruct.var_43cb1c27a49e2dd3 < 0.8 )
            {
                utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"geiger_search_detected", teamname );
                return;
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_4c5dd9edb2d6e4a8
// Params 1
// Checksum 0x7add4af1, Offset: 0x22a8
// Size: 0x321
function function_c01220e3266a3b33( teamname )
{
    self endon( #"task_ended" );
    wait 5;
    var_934391bb5ffe0db7 = 0;
    incircleindex = br_contract_manager::getquesttableindex( "dmz_geiger_search" );
    outcircleindex = br_contract_manager::getquesttableindex( "dmz_geiger_search_explore" );
    var_e0246ad6f45ff506 = br_contract_manager::getquesttableindex( "dmz_geiger_search_loot" );
    
    while ( true )
    {
        if ( isdefined( self.cacheicon ) )
        {
            var_ca867ad7a4e184e1 = function_ad8de335d42f1aca();
            
            if ( var_ca867ad7a4e184e1 == 0 )
            {
                dmz_task_utils::function_c74c010e593f5ea5( self.cacheicon.iconorigin );
                self.cacheicon dmz_task_utils::function_3ff46488beb193c7();
                self.cacheicon = undefined;
            }
        }
        
        players = teams::getteamdata( teamname, "players" );
        
        foreach ( player in players )
        {
            if ( !player player::isreallyalive() )
            {
                continue;
            }
            
            if ( !player function_4430189911111bed() && isdefined( self.cacheicon ) )
            {
                dmz_task_utils::function_d1003180abd8ac5f( player, var_e0246ad6f45ff506 );
                function_642e8155efac0367( player );
                function_3204a80da0d45662( player );
                dmz_task_utils::function_1f01bb1108ba0241( player );
                continue;
            }
            else
            {
                function_c3a38d777deaa201( player );
                dmz_task_utils::function_6277bd2a0d5a28b9( player );
            }
            
            foreach ( circle in self.questcircles )
            {
                if ( !isdefined( circle ) )
                {
                    continue;
                }
                
                distsq = distance2dsquared( circle.mapcircle.origin, player.origin );
                
                if ( distsq < level.geigerprops.circleradius * level.geigerprops.circleradius )
                {
                    dmz_task_utils::function_d1003180abd8ac5f( player, incircleindex );
                    function_642e8155efac0367( player );
                }
                else
                {
                    dmz_task_utils::function_d1003180abd8ac5f( player, outcircleindex );
                    function_374ea404765613de( player );
                }
                
                if ( !var_934391bb5ffe0db7 && distsq < level.geigerprops.circleradius * level.geigerprops.circleradius )
                {
                    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"geiger_search_approach", teamname );
                    dmz_audio::function_32ff837bc21a4833( teamname, "dmz_activity_tension", 0, "dmz_activity_tension_classic" );
                    var_934391bb5ffe0db7 = 1;
                }
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_4c5dd9edb2d6e4a8
// Params 0
// Checksum 0xbd32127b, Offset: 0x25d1
// Size: 0x1ae
function function_2d9e678357d7113b()
{
    if ( getdvarint( @"hash_e3673b8854e11b40", 0 ) )
    {
        index = 0;
        nodes = utility::getstructarray( "dmz_hidden_container", "script_noteworthy" );
        lastcache = undefined;
        
        while ( true )
        {
            poi = getdvar( @"hash_d4dd9c7f6eecaf23" );
            
            if ( getdvarint( @"hash_be93c6177feb6077", 0 ) )
            {
                setdvar( @"hash_be93c6177feb6077", 0 );
                node = undefined;
                
                while ( index < nodes.size )
                {
                    node = nodes[ index ];
                    index++;
                    
                    if ( poi )
                    {
                        if ( !isdefined( node.script_poi ) )
                        {
                            node.script_poi = poi::poi_findpoioriginisin( node.origin );
                        }
                        
                        if ( node.script_poi == poi )
                        {
                            break;
                        }
                        
                        continue;
                    }
                    
                    break;
                }
                
                if ( !isdefined( node ) )
                {
                    /#
                        printtoscreen2d( 50, 50, "<dev string:x5c>" );
                    #/
                    
                    index = 0;
                    continue;
                }
                
                if ( isdefined( lastcache ) )
                {
                    lastcache freescriptable();
                }
                
                lastcache = spawnscriptable( "dmz_hidden_container", node.origin, node.angles );
                lastcache setscriptablepartstate( "body", "closed_usable" );
                origin = node.origin + ( 0, 0, 75 );
                angles = vectortoangles( node.origin - origin );
                level.players[ 0 ] setorigin( origin );
                level.players[ 0 ] setplayerangles( angles );
            }
            
            waitframe();
        }
    }
}

/#

    // Namespace namespace_4c5dd9edb2d6e4a8
    // Params 0
    // Checksum 0xe3956b9a, Offset: 0x2787
    // Size: 0x2e, Type: dev
    function function_7ffd95ec3ecfc6f8()
    {
        while ( true )
        {
            sphere( self.origin, 50, ( 1, 1, 0 ), 0, 1 );
            waitframe();
        }
    }

#/
