// scripts\mp\br\gametypes\br_elite_geiger_quest.gsc  (hash_1fc86654ca3f775e.gscc) (size: 13738 Bytes / 0x35aa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9e3a3069 (2654613609)
// size ...... 13738 (0x35aa)
// includes .. 19  (offset: 0x3382)
// strings ... 26  (offset: 0x341a)
// dev strs .. 0   (offset: 0x35aa)
// exports ... 25  (offset: 0x2366)
// cseg ...... 0x2b8 + 0x20ae (0x2366)
// imports ... 99  (offset: 0x274e)
// animtree1 . 0   (offset: 0x35aa)
// animtree2 . 0   (offset: 0x35aa)
#using scripts\common\script;
#using scripts\mp\ai_fortress;
#using scripts\mp\br\gametypes\br_bunker_utility;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_default_inventory;
#using scripts\mp\br\gametypes\br_elite_broken_arrow;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_scavenger_quest;
#using scripts\mp\common\equipment\geiger_counter;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dmz\gametypes\dmz_task_utils;
#using scripts\mp\equipment;
#using scripts\mp\hud_message;
#using scripts\mp\locksandkeys;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item_database;

#namespace br_elite_geiger_quest;

// Namespace br_elite_geiger_quest
// Params 1
// Checksum 0x2575c8be, Offset: 0x2d6
// Size: 0x2ec
function getcontractdata( data )
{
    level.geigerprops = spawnstruct();
    level.geigerprops.circleradius = getdvarint( @"hash_1d40039c44b8ad97", 3000 );
    level.geigerprops.circlepadding = getdvarint( @"hash_cac42315ea0f8822", 250 );
    level.geigerprops.numcaches = getdvarint( @"hash_4178b1ff014a2222", 1 );
    level.geigerprops.multicounter = getdvarint( @"hash_834e3a87f7224a66", 1 );
    level.geigerprops.minseparation = getdvarint( @"hash_8afa4a88bfe03241", 4000 );
    level.geigerprops.maxseparation = getdvarint( @"hash_223f9b902afa5a5b", 8000 );
    level.geigerprops.minneardist = getdvarint( @"hash_9d75874f6eaef13b", 10000 );
    level.geigerprops.maxneardist = getdvarint( @"hash_e7bb53f3d22046ad", 20000 );
    level.geigerprops.var_b9a787119cb431f8 = level.geigerprops.minneardist * level.geigerprops.minneardist;
    level.geigerprops.var_fdc1e59ff2e6ebae = level.geigerprops.maxneardist * level.geigerprops.maxneardist;
    level.geigerprops.var_d4fcd6944f2d9a56 = level.geigerprops.minseparation * level.geigerprops.minseparation;
    level.geigerprops.var_3a58878074599120 = level.geigerprops.maxseparation * level.geigerprops.maxseparation;
    level.geigerprops.splashenabled = getdvarint( @"hash_f1152b3ca355c77", 0 );
    geiger_counter::geigercounter_init();
    data.funcs[ "onInit" ] = &function_ecfae03e31f08798;
    data.funcs[ "onTeamAssigned" ] = &function_573d93456093361b;
    data.funcs[ "onPlayerAssimilated" ] = &function_92eec9b54d7f566a;
    data.funcs[ "onPlayerTearDown" ] = &function_f413a229008c5c9;
    data.funcs[ "onCancel" ] = &function_a5ce22a4f1aee80;
    data.funcs[ "onEliteTearDown" ] = &function_2672172cd38fcf55;
    data.funcs[ "onPlayerRespawn" ] = &br_elite_broken_arrow::arrow_onplayerrespawn;
}

// Namespace br_elite_geiger_quest
// Params 0
// Checksum 0x1ee87791, Offset: 0x5ca
// Size: 0x34d, Type: bool
function function_ecfae03e31f08798()
{
    missionnode = function_409025745c63e4e();
    
    if ( !isdefined( missionnode ) )
    {
        return false;
    }
    
    self.node = missionnode;
    self.nodes = self.node.allnodes;
    self.caches = [];
    circlelocations = [];
    
    foreach ( index, node in self.nodes )
    {
        cache = spawnscriptable( "br_loot_cache_yellow_quiet", node.origin, node.angles );
        cache.var_6e39895e14c70e34 = &function_d8488454705e0b3e;
        cache.task = self;
        cache.cacheindex = index;
        cache setscriptablepartstate( "body", "closed_usable" );
        circlelocations[ circlelocations.size ] = dmz_task_utils::function_c7ccd46fc59f189d( cache.origin, level.geigerprops.circleradius );
        geiger_counter::function_69cfcbb5ee5bfc98( cache );
        self.caches[ index ] = cache;
        disablelootspawnpoint( node.index );
    }
    
    dmz_task_utils::function_13fe84cb824c72a8( "Elite_Geiger", circlelocations, level.geigerprops.circleradius + level.geigerprops.circlepadding );
    pos = ( 0, 0, 0 );
    
    foreach ( loc in circlelocations )
    {
        pos += loc;
    }
    
    pos /= circlelocations.size;
    dmz_task_utils::function_b3476f99a8e21fa2( pos + ( 0, 0, 750 ), "elite_geiger" );
    objective_setdescription( self.icon, &"br_elite_broken_arrow/locate_elem" );
    objective_setbackground( self.icon, 1 );
    objective_settint( self.icon, 246, 192, 72 );
    self.cachesfound = 0;
    
    if ( self.caches.size < level.geigerprops.numcaches )
    {
        function_f44f9c3d57e3721f();
        return false;
    }
    
    self.var_b1221b9ada64e1f2 = self.node.var_b1221b9ada64e1f2;
    
    if ( !function_1abff1fb1ec5e340( self.var_b1221b9ada64e1f2 ) )
    {
        function_f44f9c3d57e3721f();
        return false;
    }
    
    self.geigercountercontainer = self.node.var_b1221b9ada64e1f2;
    self.geigercountercontainer.var_6e39895e14c70e34 = &function_6a256437a1441487;
    self.geigercountercontainer.task = self;
    return true;
}

// Namespace br_elite_geiger_quest
// Params 0
// Checksum 0xc8e1a1a0, Offset: 0x920
// Size: 0x5f7
function function_409025745c63e4e()
{
    potentialnodes = [];
    var_9ab3d73fe300dbbe = [];
    lootpoint = br_contract_manager::function_2159ab6c273022cc( self.tablet.origin, level.geigerprops.var_b9a787119cb431f8, level.geigerprops.var_fdc1e59ff2e6ebae, 1, 1 );
    potentialnodes[ 0 ] = lootpoint;
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
    
    bags1 = getentitylessscriptablearray( "scriptable_cache_duffel_bag_01", #classname );
    bags2 = getentitylessscriptablearray( "scriptable_cache_duffel_bag_02", #classname );
    var_ac7871f323633c10 = arraycombine( bags1, bags2 );
    backupbags = [];
    var_24fcd85044a4ecb4 = getdvarint( @"hash_638b5231a4cec66", 1 );
    circlecenter = br_circle::getnextsafecircleorigin();
    circleradius = br_circle::getnextsafecircleradius();
    
    foreach ( node in nodegroups )
    {
        if ( var_ac7871f323633c10.size )
        {
            bestcache = undefined;
            
            foreach ( cache in var_ac7871f323633c10 )
            {
                if ( cache.chosen )
                {
                    continue;
                }
                
                if ( var_24fcd85044a4ecb4 && cache getscriptablepartstate( "body" ) != #"closed_usable" )
                {
                    continue;
                }
                
                if ( ai_fortress::function_f96df72675d7e8c6( cache.origin ) )
                {
                    continue;
                }
                
                if ( br_scavenger_quest::function_9e34ff6f77321bef( cache.origin ) )
                {
                    continue;
                }
                
                if ( br_bunker_utility::function_5f3fda39a064e862( cache.origin ) )
                {
                    continue;
                }
                
                if ( locksandkeys::function_9894956c856a7904( cache.origin ) )
                {
                    continue;
                }
                
                if ( isdefined( circlecenter ) && isdefined( circleradius ) )
                {
                    if ( distance2dsquared( circlecenter, cache.origin ) > circleradius * circleradius )
                    {
                        continue;
                    }
                }
                
                backupbags[ backupbags.size ] = cache;
                dist = distance2dsquared( node.origin, cache.origin );
                
                if ( dist > level.geigerprops.var_d4fcd6944f2d9a56 && dist < level.geigerprops.var_3a58878074599120 )
                {
                    bestcache = cache;
                    break;
                }
            }
            
            if ( !isdefined( bestcache ) )
            {
                if ( backupbags.size > 0 )
                {
                    bestcache = backupbags[ randomint( backupbags.size ) ];
                }
                
                if ( !isdefined( bestcache ) )
                {
                    bestcache = var_ac7871f323633c10[ randomint( var_ac7871f323633c10.size ) ];
                }
                
                if ( var_24fcd85044a4ecb4 && bestcache getscriptablepartstate( "body" ) != #"closed_usable" )
                {
                    bestcache setscriptablepartstate( "body", #"closed_usable" );
                }
            }
            
            node.var_b1221b9ada64e1f2 = bestcache;
            bestcache.chosen = 1;
            var_9ab3d73fe300dbbe[ var_9ab3d73fe300dbbe.size ] = node;
            break;
        }
    }
    
    return var_9ab3d73fe300dbbe[ 0 ];
}

// Namespace br_elite_geiger_quest
// Params 1
// Checksum 0x9805ac48, Offset: 0xf20
// Size: 0x84
function function_92eec9b54d7f566a( player )
{
    foreach ( cache in self.caches )
    {
        cache enablescriptableplayeruse( player );
    }
}

// Namespace br_elite_geiger_quest
// Params 3
// Checksum 0xcbac582d, Offset: 0xfac
// Size: 0xc5
function function_f413a229008c5c9( player, oldteam, newteam )
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

// Namespace br_elite_geiger_quest
// Params 0
// Checksum 0xa36893c6, Offset: 0x1079
// Size: 0x513
function function_573d93456093361b()
{
    self.category = "elite_geiger";
    players = teams::getteamdata( self.team, "players" );
    var_1afe20bbff3968cd = function_38de15728dc69e1b();
    
    if ( !isdefined( self.geigercountercontainer.contents ) )
    {
        items = getscriptablelootcachecontents( self.geigercountercontainer );
        self.geigercountercontainer.containertype = 3;
        common_cache::function_a09e7cf5bad99b64( self.geigercountercontainer, items );
        lootcount = level.geigerprops.multicounter ? var_1afe20bbff3968cd : 1;
        itembundlename = common_item_database::function_ca9ca606e66b5911( "brloot_offhand_geigercounter" );
        common_cache::cache_additem( self.geigercountercontainer, itembundlename, lootcount );
    }
    
    if ( var_1afe20bbff3968cd )
    {
        index = br_contract_manager::getquesttableindex( "elite_geiger_loot" );
        dmz_task_utils::function_c74c010e593f5ea5( self.geigercountercontainer.origin + ( 0, 0, 15 ) );
        self.cacheicon = spawnstruct();
        self.cacheicon dmz_task_utils::function_b3476f99a8e21fa2( function_f2cc4022acaa525d(), "elite_geiger" );
        objective_setdescription( self.cacheicon.icon, &"br_elite_broken_arrow/locate_elem" );
        objective_setbackground( self.cacheicon.icon, 1 );
        objective_settint( self.cacheicon.icon, 246, 192, 72 );
        
        foreach ( player in players )
        {
            if ( player function_92fb1ee7f0045810() )
            {
                dmz_task_utils::function_6277bd2a0d5a28b9( player );
                function_6543badef07f3567( player );
                function_b7eef62bff4bac7a( player );
                continue;
            }
            
            dmz_task_utils::function_1f01bb1108ba0241( player );
            function_7865d39f0f9f1af6( player );
            dmz_task_utils::function_d1003180abd8ac5f( player, index );
        }
    }
    else
    {
        foreach ( player in players )
        {
            player.var_497b2e4675d21f26 = 1;
        }
        
        dmz_task_utils::function_18b83232055b1325( self.team );
    }
    
    self.var_84deb5244c7a5c4d = 500;
    
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
    
    if ( level.geigerprops.splashenabled )
    {
        dmz_task_utils::task_showsplashtoteam( "br_elite_geiger_start", self.team );
    }
    
    level thread br_public::brleaderdialogteam( "arrow_start_geiger", self.teams[ 0 ], undefined, 2 );
    
    foreach ( player in players )
    {
        player br_contract_manager::uiobjectivesetparameter( level.geigerprops.numcaches - self.cachesfound );
    }
    
    thread function_d6f99387efd63b14( self.team );
}

// Namespace br_elite_geiger_quest
// Params 1
// Checksum 0xa7474add, Offset: 0x1594
// Size: 0x109
function function_a5ce22a4f1aee80( teamname )
{
    players = teams::getteamdata( teamname, "players" );
    
    foreach ( player in players )
    {
        foreach ( cache in self.caches )
        {
            cache disablescriptableplayeruse( player );
        }
    }
    
    function_f44f9c3d57e3721f();
}

// Namespace br_elite_geiger_quest
// Params 0
// Checksum 0x3b7fff0f, Offset: 0x16a5
// Size: 0x3f
function task_cleanup()
{
    self.taskended = 1;
    dmz_task_utils::function_3ff46488beb193c7();
    
    if ( isdefined( self.cacheicon ) )
    {
        self.cacheicon dmz_task_utils::function_3ff46488beb193c7();
    }
    
    dmz_task_utils::function_e23cad864e9e2023();
    function_c8efb2ecce20da8e();
}

// Namespace br_elite_geiger_quest
// Params 1, eflags: 0x4
// Checksum 0x4f134bee, Offset: 0x16ec
// Size: 0x40
function private function_f44f9c3d57e3721f( success )
{
    if ( self.ended )
    {
        return;
    }
    
    self.ended = 1;
    self notify( #"task_ended" );
    task_cleanup();
    br_contract_manager::endcontract( success );
}

// Namespace br_elite_geiger_quest
// Params 0
// Checksum 0xf58a99d3, Offset: 0x1734
// Size: 0x69, Type: bool
function function_92fb1ee7f0045810()
{
    curr = equipment_mp::getcurrentequipment( "secondary" );
    equipammo = equipment_mp::getequipmentslotammo( "secondary" );
    lootid = loot::getlootidfromref( "equip_geigercounter" );
    count = br_default_inventory::gettotalitemcountinbag( lootid );
    return curr == "equip_geigercounter" && equipammo || count;
}

// Namespace br_elite_geiger_quest
// Params 0
// Checksum 0x902d5c11, Offset: 0x17a6
// Size: 0xa7
function function_38de15728dc69e1b()
{
    teammates = teams::getteamdata( self.team, "players" );
    var_ca867ad7a4e184e1 = 0;
    
    foreach ( teammate in teammates )
    {
        if ( teammate function_92fb1ee7f0045810() )
        {
            continue;
        }
        
        var_ca867ad7a4e184e1++;
    }
    
    return var_ca867ad7a4e184e1;
}

// Namespace br_elite_geiger_quest
// Params 1
// Checksum 0xb45616ba, Offset: 0x1856
// Size: 0x2e, Type: bool
function function_1abff1fb1ec5e340( cache )
{
    return !ai_fortress::function_5428359c3c1916ac( cache.origin ) && !cache.islockedcache;
}

// Namespace br_elite_geiger_quest
// Params 2
// Checksum 0x66546f3a, Offset: 0x188d
// Size: 0xed
function function_6a256437a1441487( instance, player )
{
    if ( !( isdefined( instance.task ) && isdefined( instance.task.team ) ) || player.team != instance.task.team || instance.task.taskended )
    {
        player hud_message::showerrormessage( "MP_DMZ_MISSIONS/GEIGER_SEARCH_GC_CACHE_ERR" );
        return 0;
    }
    
    if ( !isdefined( instance.contents ) )
    {
        items = getscriptablelootcachecontents( instance );
        instance.containertype = 3;
        common_cache::function_a09e7cf5bad99b64( instance, items, undefined, player );
        itembundlename = common_item_database::function_ca9ca606e66b5911( "brloot_offhand_geigercounter" );
        common_cache::cache_additem( instance, itembundlename, 1, undefined, player );
    }
}

// Namespace br_elite_geiger_quest
// Params 2, eflags: 0x4
// Checksum 0x309d7bfe, Offset: 0x1982
// Size: 0xba
function private function_d8488454705e0b3e( instance, player )
{
    if ( !isdefined( instance.contents ) )
    {
        items = getscriptablelootcachecontents( instance );
        instance.containertype = 3;
        common_cache::function_a09e7cf5bad99b64( instance, items, undefined, player );
        script::demoforcesre( "Removed br_lootcache function ensureCashValueInLootContents here." );
    }
    
    team = instance.task.team;
    element = br_elite_broken_arrow::function_f6ff0d8613c64445( team );
    br_elite_broken_arrow::function_e747a7a8161f31a9( team, instance.origin, instance.angles, element );
    function_495ce4c5f0eb7982( instance, player );
}

// Namespace br_elite_geiger_quest
// Params 2
// Checksum 0xeb4aa1b6, Offset: 0x1a44
// Size: 0x151
function function_495ce4c5f0eb7982( instance, player )
{
    if ( isdefined( player ) && isdefined( instance ) )
    {
        cache = instance;
        task = cache.task;
        task dmz_task_utils::function_d0fab7ddae4ada22( cache.cacheindex );
        task.cachesfound++;
        cache.found = 1;
        geiger_counter::function_54886797fcd30128( cache );
        players = teams::getteamdata( task.team, "players" );
        
        foreach ( player in players )
        {
            player br_contract_manager::uiobjectivesetparameter( level.geigerprops.numcaches - task.cachesfound );
        }
        
        if ( level.geigerprops.splashenabled )
        {
            task br_contract_manager::function_5c7e547ccc13711b( "br_elite_geiger_end" );
        }
        
        task function_f44f9c3d57e3721f( 1 );
    }
}

// Namespace br_elite_geiger_quest
// Params 0
// Checksum 0xd1375802, Offset: 0x1b9d
// Size: 0x1a8
function function_f2cc4022acaa525d()
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

// Namespace br_elite_geiger_quest
// Params 0
// Checksum 0xa9fc884b, Offset: 0x1d4e
// Size: 0x3f
function function_ccf86fe26e1c37fe()
{
    pos = function_f2cc4022acaa525d();
    
    if ( isdefined( self.cacheicon ) )
    {
        self.cacheicon dmz_task_utils::function_c74c010e593f5ea5( pos );
        return;
    }
    
    dmz_task_utils::function_c74c010e593f5ea5( pos );
}

// Namespace br_elite_geiger_quest
// Params 1
// Checksum 0x70232999, Offset: 0x1d95
// Size: 0x37
function function_6543badef07f3567( player )
{
    if ( isdefined( self.cacheicon ) )
    {
        self.cacheicon dmz_task_utils::function_dc6a173a36eef985( player );
        return;
    }
    
    dmz_task_utils::function_dc6a173a36eef985( player );
}

// Namespace br_elite_geiger_quest
// Params 1
// Checksum 0x3372e99, Offset: 0x1dd4
// Size: 0x37
function function_7865d39f0f9f1af6( player )
{
    if ( isdefined( self.cacheicon ) )
    {
        self.cacheicon dmz_task_utils::function_d8d9112f1e68fa2b( player );
        return;
    }
    
    dmz_task_utils::function_d8d9112f1e68fa2b( player );
}

// Namespace br_elite_geiger_quest
// Params 1
// Checksum 0xac52eff0, Offset: 0x1e13
// Size: 0x22
function function_7697d9e42a9c0801( player )
{
    if ( isdefined( self.cacheicon ) )
    {
        dmz_task_utils::function_dc6a173a36eef985( player );
    }
}

// Namespace br_elite_geiger_quest
// Params 1
// Checksum 0xf535df25, Offset: 0x1e3d
// Size: 0x22
function function_b7eef62bff4bac7a( player )
{
    if ( isdefined( self.cacheicon ) )
    {
        dmz_task_utils::function_d8d9112f1e68fa2b( player );
    }
}

// Namespace br_elite_geiger_quest
// Params 1
// Checksum 0x6ced39a8, Offset: 0x1e67
// Size: 0x29f
function function_d6f99387efd63b14( teamname )
{
    self endon( #"task_ended" );
    wait 5;
    incircleindex = br_contract_manager::getquesttableindex( "elite_geiger_search" );
    outcircleindex = br_contract_manager::getquesttableindex( "elite_geiger_explore" );
    var_e0246ad6f45ff506 = br_contract_manager::getquesttableindex( "elite_geiger_loot" );
    
    while ( true )
    {
        if ( isdefined( self.cacheicon ) )
        {
            var_ca867ad7a4e184e1 = function_38de15728dc69e1b();
            
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
            
            if ( !player function_92fb1ee7f0045810() && isdefined( self.cacheicon ) )
            {
                dmz_task_utils::function_d1003180abd8ac5f( player, var_e0246ad6f45ff506 );
                function_7865d39f0f9f1af6( player );
                function_7697d9e42a9c0801( player );
                dmz_task_utils::function_1f01bb1108ba0241( player );
                continue;
            }
            else
            {
                function_b7eef62bff4bac7a( player );
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
                    function_7865d39f0f9f1af6( player );
                    continue;
                }
                
                dmz_task_utils::function_d1003180abd8ac5f( player, outcircleindex );
                function_6543badef07f3567( player );
            }
        }
        
        wait 1;
    }
}

// Namespace br_elite_geiger_quest
// Params 0, eflags: 0x4
// Checksum 0x13de1f7, Offset: 0x210e
// Size: 0xf7
function private function_c8efb2ecce20da8e()
{
    players = teams::getteamdata( self.teams[ 0 ], "players" );
    
    foreach ( player in players )
    {
        if ( isdefined( player.equipment[ "secondary" ] ) && player.equipment[ "secondary" ] == "equip_geigercounter" )
        {
            player equipment_mp::takeequipment( "secondary" );
        }
        
        lootid = loot::getlootidfromref( "equip_geigercounter" );
        
        while ( player br_default_inventory::function_511e6d4f61a60220( lootid ) )
        {
            player br_default_inventory::function_f0398a1e115d3553( lootid );
        }
    }
}

// Namespace br_elite_geiger_quest
// Params 1
// Checksum 0xf8795f0d, Offset: 0x220d
// Size: 0x159
function function_2672172cd38fcf55( team )
{
    task = self;
    teammates = teams::getteamdata( team, "players" );
    
    foreach ( player in teammates )
    {
        foreach ( cache in task.caches )
        {
            cache disablescriptableplayeruse( player );
        }
    }
    
    task.taskended = 1;
    task dmz_task_utils::function_3ff46488beb193c7();
    
    if ( isdefined( task.cacheicon ) )
    {
        task.cacheicon dmz_task_utils::function_3ff46488beb193c7();
    }
    
    task dmz_task_utils::function_e23cad864e9e2023();
    task function_c8efb2ecce20da8e();
}

