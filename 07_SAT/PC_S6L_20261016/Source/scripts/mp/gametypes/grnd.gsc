// scripts\mp\gametypes\grnd.gsc  (hash_0c5cc3d0d9e62a6d.gscc) (size: 39545 Bytes / 0x9a79 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc774db67 (3346324327)
// size ...... 39545 (0x9a79)
// includes .. 42  (offset: 0x9031)
// strings ... 122 (offset: 0x9181)
// dev strs .. 12  (offset: 0x99d1)
// exports ... 64  (offset: 0x62f5)
// cseg ...... 0x889 + 0x5a6c (0x62f5)
// imports ... 277 (offset: 0x6cf5)
// animtree1 . 0   (offset: 0x9a79)
// animtree2 . 0   (offset: 0x9a79)
#using script_382bf8d77c4fd348;
#using script_39ecc21922ab862e;
#using scripts\common\callback_sequence;
#using scripts\common\callbacks;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\telemetry_utils;
#using scripts\common\trace;
#using scripts\common\trigger_group;
#using scripts\common\utility;
#using scripts\common\vehicle_tracking;
#using scripts\mp\callouts;
#using scripts\mp\common\gameobjects\gameobjects_common;
#using scripts\mp\common\gameobjects\gameobjects_shared;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\killstreaks\airdrop_multiple;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\sound;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\koth;
#using scripts\mp\gametypes\obj_zonecapture;
#using scripts\mp\globallogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\objectiveiconstates;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\rank;
#using scripts\mp\spawnfactor;
#using scripts\mp\spawnlogic;

#namespace grnd;

// Namespace grnd
// Params 0
// Checksum 0x92296310, Offset: 0x8a7
// Size: 0x2a7
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    
    if ( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        gameobjects_common::function_22117b1fd559026f( "dropzone", { #manual_drop:1, #var_7f4958ce4e4277c3:#"hash_bb332da19f9944df", #capture_segment_count:1, #var_333d3689d793bcc7:0, #use_time_seconds:0, #var_c68e9f43ed9cc918:#"hash_a1360b18943e920", #var_d7c90dc73c1dcba8:( 0, 0, 0 ), #objective_icon_offset:( 0, 0, 0 ), #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) }, &function_51483b09a1807cd7 );
    }
    else
    {
        allowed[ 0 ] = game_utility::getgametype();
        allowed[ 1 ] = "dz_flare";
        gameobjects::main( allowed );
    }
    
    level.teambased = 1;
    level.onstartgametype = &onstartgametype;
    level.onplayerconnect = &onplayerconnect;
    level.getspawnpoint = &getspawnpoint;
    level.onrespawndelay = &koth::getrespawndelay;
    level.var_40cd999d911308e0 = &game_utility_mp::function_24298f56712800ff;
    level.var_e16ef107a3dd572b = &game_utility_mp::function_84968d430abf1672;
    level.nosuspensemusic = 1;
    callback::add( #"player_spawned", &onspawnplayer );
    callback::add( #"hash_244314ef9125e636", &koth::function_8314535b81f548e );
    utility::registersharedfunc( #"koth_shared", #"hash_cda4308a680a661b", &function_aa8f15d9f14b98cc );
    utility::registersharedfunc( #"koth_shared", #"hash_fe4eaea2df7a50a0", &function_537d9824316d5d99 );
    utility::registersharedfunc( #"koth_shared", #"hash_78baf065cea30b57", &function_369d35ac6034c160 );
    utility::registersharedfunc( #"koth_shared", #"on_player_score_interval", &on_player_score_interval );
    utility::registersharedfunc( #"koth_shared", #"hash_4356b4516dc478f2", &function_2770fdef48db2491 );
    koth_shared::initialize();
    setomnvar( "ui_hq_status", -1 );
    setomnvar( "ui_hq_num_alive", 0 );
    setomnvar( "ui_hq_ownerteam", -1 );
}

// Namespace grnd
// Params 0
// Checksum 0x6ddf2acd, Offset: 0xb56
// Size: 0x11d
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    level.droptime = getmatchrulesdata( "grndData", "dropTime" ) ?? 15;
    level.zoneduration = getmatchrulesdata( "kothData", "zoneLifetime" ) ?? 60;
    level.zonecapturetime = getmatchrulesdata( "kothData", "zoneCaptureTime" ) ?? 0;
    level.firstzoneactivationdelay = getmatchrulesdata( "kothData", "firstZoneActivationDelay" ) ?? 30;
    level.zoneactivationdelay = getmatchrulesdata( "kothData", "zoneActivationDelay" ) ?? 30;
    level.nextzonerevealtime = getmatchrulesdata( "kothData", "nextZoneRevealTime" ) ?? 12;
    level.zonerandomlocationorder = getmatchrulesdata( "kothData", "randomLocationOrder" ) ?? 0;
    level.zoneadditivescoring = getmatchrulesdata( "kothData", "additiveScoring" ) ?? 0;
    level.pausemodetimer = getmatchrulesdata( "kothData", "pauseTime" ) ?? 1;
    level.enablevariantdrops = getmatchrulesdata( "grndData", "enableVariantDZ" ) ?? 0;
}

// Namespace grnd
// Params 0
// Checksum 0x9252f230, Offset: 0xc7b
// Size: 0x333
function onstartgametype()
{
    setclientnamemode( "auto_change" );
    
    if ( !isdefined( game[ "switchedsides" ] ) )
    {
        game[ "switchedsides" ] = 0;
    }
    
    foreach ( entry in level.teamnamelist )
    {
        game_utility_mp::setobjectivetext( entry, &"objectives/grnd" );
        
        if ( level.splitscreen )
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/grnd" );
        }
        else
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/grnd_score" );
        }
        
        game_utility_mp::setobjectivehinttext( entry, &"objectives/dom_hint" );
    }
    
    flags::levelflaginit( "first_zone_spawned", 0 );
    
    if ( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        callback::function_dc654a4d4126a928( #"hash_92c01688276809dc", #"hash_6947ec89a1af6d69", &function_6c2b1c0335034a16 );
        callback::function_dc654a4d4126a928( #"hash_89cf712b23a4d7b5", #"hash_6947ec89a1af6d69", &function_a1fba607824e9171 );
        callback::function_dc654a4d4126a928( #"hash_3c955b1e6fcd76eb", #"hash_6947ec89a1af6d69", &function_94a6de4e2d6c3b57 );
        callback::function_dc654a4d4126a928( #"hash_45277be78cb54c51", #"hash_6947ec89a1af6d69", &function_80569e83bd3abfbf );
        callback::function_dc654a4d4126a928( #"hash_358d33b2497e2ce3", #"hash_6947ec89a1af6d69", &function_6a19a64439b0eea9 );
        callback::function_dc654a4d4126a928( #"hash_5d939c5f097361e9", #"hash_6947ec89a1af6d69", &function_d8ee55e6aab29845 );
        callback::function_dc654a4d4126a928( #"hash_47fedf1df6eafa30", #"hash_6947ec89a1af6d69", &on_use_update_cb );
        callback::function_dc654a4d4126a928( #"hash_a1e02ee2cc2ad28e", #"hash_6947ec89a1af6d69", &function_d30aecaa8ade1f5 );
        callback::function_dc654a4d4126a928( #"hash_3aba7df6443df11d", #"hash_6947ec89a1af6d69", &function_aaa1ceb9e48346dc );
        callback::function_dc654a4d4126a928( #"hash_2e3e0663aecb6f19", #"hash_6947ec89a1af6d69", &function_ceadb54c29c1a81a );
        callback::function_dc654a4d4126a928( #"hash_29eede2365f9349a", #"hash_6947ec89a1af6d69", &function_5a35159676e6e80d );
        callback::function_dc654a4d4126a928( #"hash_a836ce9ab43d9e2", #"hash_6947ec89a1af6d69", &on_zone_captured_cb );
        callback::function_dc654a4d4126a928( #"hash_300ad54dcc9beab1", #"hash_6947ec89a1af6d69", &function_d3f276c6e626d80 );
        callback::function_dc654a4d4126a928( #"hash_629949853fbabab8", #"hash_6947ec89a1af6d69", &function_7deb426f5232fa5f );
        
        if ( istrue( level.game_objects.var_5f329cd264226f08 ) )
        {
            utility::flag_wait( "cs_gameobjects_constructed" );
        }
        else
        {
            utility::flag_wait( "gameobject_system_post_init" );
            function_bf70e8e73e6ea0dc();
            function_144be83cf9436fa0();
            waitframe();
        }
    }
    else
    {
        level thread setupzones();
    }
    
    setmapsizespawnconsts();
    initspawns();
    level thread dzmainloop();
    
    /#
    #/
    
    if ( level.droptime > 0 )
    {
        level thread randomdrops();
    }
}

// Namespace grnd
// Params 0
// Checksum 0x23162582, Offset: 0xfb6
// Size: 0x41
function updategametypedvars()
{
    common::updatecommongametypedvars();
    
    if ( game_utility_mp::matchmakinggame() && !game_utility_mp::isanymlgmatch() && getdvarint( @"hash_56937a1bd450393d", 15 ) != 0 )
    {
        level.zoneactivationdelay = adjustzoneactivationdelayforlargemaps();
    }
}

// Namespace grnd
// Params 0
// Checksum 0x7dc7c546, Offset: 0xfff
// Size: 0x87
function adjustzoneactivationdelayforlargemaps()
{
    mapname = game_utility::getmapname();
    
    switch ( mapname )
    {
        case #"hash_62c07791a2eda185":
        case #"hash_f09747c9feb47eb1":
        case #"hash_fcab5810ee4c6dc2":
            return getdvarint( @"hash_56937a1bd450393d", 15 );
        case #"hash_a8b272dba33a4aed":
            return ( getdvarint( @"hash_56937a1bd450393d", 15 ) + 15 );
        default:
            return level.zoneactivationdelay;
    }
}

// Namespace grnd
// Params 0
// Checksum 0xb06d0ee5, Offset: 0x108e
// Size: 0x36
function setmapsizespawnconsts()
{
    level.spawn_deadzone_dist = 1000;
    level.close_spawn_min_dist_sq = 10000;
    level.max_spawn_dist_sq = 25000000;
    level.enemy_spawn_influence_dist_sq = 12250000;
}

// Namespace grnd
// Params 0
// Checksum 0xf465df78, Offset: 0x10cc
// Size: 0x738
function initspawns()
{
    spawnlogic::function_6dbabb72223a4bca();
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        spawnlogic::function_3cdbb94b81729d5f( spawnkey );
    }
    else
    {
        spawnlogic::setactivespawnlogic( #"default" );
        spawnlogic::addstartspawnpoints( "mp_tdm_spawn_allies_start" );
        spawnlogic::addstartspawnpoints( "mp_tdm_spawn_axis_start" );
        spawnlogic::addspawnpointslegacy( game[ "attackers" ], "mp_tdm_spawn_allies_start" );
        spawnlogic::addspawnpointslegacy( game[ "defenders" ], "mp_tdm_spawn_axis_start" );
        attackers = spawnlogic::getspawnpointarray( "mp_tdm_spawn_allies_start" );
        defenders = spawnlogic::getspawnpointarray( "mp_tdm_spawn_axis_start" );
        spawnlogic::registerspawnset( #"start_attackers", attackers );
        spawnlogic::registerspawnset( #"start_defenders", defenders );
        spawnlogic::addspawnpointslegacy( "allies", "mp_tdm_spawn" );
        spawnlogic::addspawnpointslegacy( "axis", "mp_tdm_spawn" );
        spawnlogic::addspawnpointslegacy( "allies", "mp_tdm_spawn_secondary", 1, 1 );
        spawnlogic::addspawnpointslegacy( "axis", "mp_tdm_spawn_secondary", 1, 1 );
        spawnlogic::registerspawnset( #"primary", "mp_tdm_spawn" );
        spawnlogic::registerspawnset( #"fallback", "mp_tdm_spawn_secondary" );
        enablespawnpointsbyclassname( "mp_tdm_spawn" );
        level.spawnpoints = spawnlogic::getspawnpointarray( "mp_tdm_spawn" );
    }
    
    if ( !level.spawnpoints.size )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    spawnlogic::finalizemap();
    
    foreach ( zone in level.objectives )
    {
        zone.furthestspawndistsq = 0;
        zone.spawnpoints = [];
        zone.fallbackspawnpoints = [];
    }
    
    foreach ( spawnpoint in level.spawnpoints )
    {
        function_dc4c4c2b9f6a9ad( spawnpoint );
        originstring = spawnlogic::getoriginidentifierstring( spawnpoint );
        
        if ( isdefined( level.grndextraprimaryspawnpoints ) && isdefined( level.grndextraprimaryspawnpoints[ originstring ] ) )
        {
            foreach ( zoneindex in level.grndextraprimaryspawnpoints[ originstring ] )
            {
                zone = level.objectives[ zoneindex ];
                zone.spawnpoints[ zone.spawnpoints.size ] = spawnpoint;
            }
        }
        
        var_5d7f46b8f1e25d9f = 0;
        isstartspawn = spawnpoint.classname == "mp_tdm_spawn_allies_start" || spawnpoint.classname == "mp_tdm_spawn_axis_start";
        var_3b72c14b568d1c04 = spawnpoint.classname == "mp_tdm_spawn" || spawnpoint.classname == "mp_spawn_point";
        var_8816bfb015c19a5e = spawnpoint.classname == "mp_tdm_spawn_secondary";
        
        if ( isstartspawn )
        {
            continue;
        }
        
        if ( var_3b72c14b568d1c04 || var_8816bfb015c19a5e )
        {
            if ( isdefined( spawnpoint.script_noteworthy ) && spawnpoint.script_noteworthy != "" )
            {
                var_5d7f46b8f1e25d9f = 1;
                zoneindicies = strtok( spawnpoint.script_noteworthy, " " );
                
                foreach ( zoneindex in zoneindicies )
                {
                    zone = level.objectives[ zoneindex ];
                    
                    if ( var_3b72c14b568d1c04 )
                    {
                        zone.spawnpoints[ zone.spawnpoints.size ] = spawnpoint;
                        continue;
                    }
                    
                    assert( var_8816bfb015c19a5e, "<dev string:x4c>" );
                    zone.fallbackspawnpoints[ zone.fallbackspawnpoints.size ] = spawnpoint;
                }
            }
        }
        
        function_dc4c4c2b9f6a9ad( spawnpoint );
        
        if ( !var_5d7f46b8f1e25d9f )
        {
            foreach ( zone in level.objectives )
            {
                objective_key = gameobjects_common::get_objective_key( zone );
                
                if ( spawnpoint.scriptdata.var_a881d5343a45f1a6[ objective_key ] < level.close_spawn_min_dist_sq || spawnpoint.scriptdata.var_a881d5343a45f1a6[ objective_key ] > level.max_spawn_dist_sq )
                {
                    spawnpoint.removespawn = 1;
                }
                
                if ( var_3b72c14b568d1c04 )
                {
                    if ( !isdefined( spawnpoint.removespawn ) )
                    {
                        zone.spawnpoints[ zone.spawnpoints.size ] = spawnpoint;
                    }
                }
                else
                {
                    assert( var_8816bfb015c19a5e );
                    zone.fallbackspawnpoints[ zone.fallbackspawnpoints.size ] = spawnpoint;
                }
                
                spawnpoint.removespawn = undefined;
            }
        }
    }
    
    foreach ( objid, zone in level.objectives )
    {
        assert( zone.spawnpoints.size > 0, "<dev string:x93>" + objid + "<dev string:xa9>" );
        zone.spawnset = hashcat( #"dropzone_", string( objid ) );
        spawnlogic::registerspawnset( zone.spawnset, zone.spawnpoints );
        zone.fallbackspawnset = hashcat( #"dropzone_fallback_", string( objid ) );
        spawnlogic::registerspawnset( zone.fallbackspawnset, zone.fallbackspawnpoints );
    }
}

// Namespace grnd
// Params 2
// Checksum 0x47b08831, Offset: 0x180c
// Size: 0xe3, Type: bool
function comparezoneindexes( zone_a, zone_b )
{
    script_index_a = int( zone_a.objectivekey );
    script_index_b = int( zone_b.objectivekey );
    
    if ( !isdefined( script_index_a ) && !isdefined( script_index_b ) )
    {
        println( "<dev string:xca>" + zone_a.origin + "<dev string:xf7>" + zone_b.origin );
        return false;
    }
    
    if ( !isdefined( script_index_a ) && isdefined( script_index_b ) )
    {
        println( "<dev string:xca>" + zone_a.origin );
        return true;
    }
    
    if ( isdefined( script_index_a ) && !isdefined( script_index_b ) )
    {
        println( "<dev string:xca>" + zone_b.origin );
        return false;
    }
    
    if ( script_index_a > script_index_b )
    {
        return true;
    }
    
    return false;
}

// Namespace grnd
// Params 1
// Checksum 0x8ba69e1b, Offset: 0x18f8
// Size: 0x135
function getzonearray( targetname )
{
    zones = getentarray( targetname, #targetname );
    
    foreach ( z in zones )
    {
        z.objectivekey = z.script_label;
    }
    
    if ( !isdefined( zones ) || zones.size == 0 )
    {
        return;
    }
    
    swapped = 1;
    
    for ( n = zones.size; swapped ; n-- )
    {
        swapped = 0;
        
        for ( i = 0; i < n - 1 ; i++ )
        {
            if ( comparezoneindexes( zones[ i ], zones[ i + 1 ] ) )
            {
                temp = zones[ i ];
                zones[ i ] = zones[ i + 1 ];
                zones[ i + 1 ] = temp;
                swapped = 1;
            }
        }
    }
    
    return zones;
}

// Namespace grnd
// Params 0
// Checksum 0x8573d5db, Offset: 0x1a36
// Size: 0xae2
function setupzones()
{
    trigs = getzonearray( "grnd" );
    
    if ( level.mapname == "mp_piccadilly" )
    {
        foreach ( trig in trigs )
        {
            if ( distance( trig.origin, ( -1547, -1512, 165 ) ) < 10 )
            {
                trig.origin -= ( 0, 0, 10 );
            }
        }
    }
    else if ( level.mapname == "mp_aniyah" )
    {
        foreach ( trig in trigs )
        {
            if ( distance( trig.origin, ( -1117, 2295, 398 ) ) < 10 )
            {
                trig.origin -= ( 0, 0, 10 );
                continue;
            }
            
            if ( distance( trig.origin, ( -4501, -2, 322 ) ) < 10 )
            {
                trig.script_label = "9";
                continue;
            }
            
            if ( distance( trig.origin, ( -4474, 1159, 388 ) ) < 10 )
            {
                trig.origin -= ( 0, 0, 20 );
            }
        }
    }
    
    assert( isdefined( trigs.size > 3 ) );
    maperrors = [];
    flares = utility::getstructarray( "dz_flare", "targetname" );
    
    if ( level.mapname == "mp_shipment" )
    {
        removetrigs = [];
        
        foreach ( trig in trigs )
        {
            if ( trig.script_label == "1" && distance( trig.origin, ( -333, 1999, 119 ) ) < 5 )
            {
                removetrigs[ removetrigs.size ] = trig;
                continue;
            }
            
            if ( trig.script_label == "2" && distance( trig.origin, ( 189, 1564, 75 ) ) < 5 )
            {
                removetrigs[ removetrigs.size ] = trig;
                continue;
            }
            
            if ( trig.script_label == "3" && distance( trig.origin, ( -751, 2416, 81 ) ) < 5 )
            {
                removetrigs[ removetrigs.size ] = trig;
                continue;
            }
            
            if ( trig.script_label == "4" && distance( trig.origin, ( 165, 2420, 79 ) ) < 5 )
            {
                removetrigs[ removetrigs.size ] = trig;
                continue;
            }
            
            if ( trig.script_label == "5" && distance( trig.origin, ( -823, 1536, 68 ) ) < 5 )
            {
                removetrigs[ removetrigs.size ] = trig;
            }
        }
        
        trigs = arrayremove( trigs, removetrigs );
        removeflares = [];
        
        foreach ( flare in flares )
        {
            if ( distance( flare.origin, ( 192.944, 1583.51, 16.344 ) ) < 5 )
            {
                removeflares[ removeflares.size ] = flare;
                continue;
            }
            
            if ( distance( flare.origin, ( -743.056, 2447.51, 17.844 ) ) < 5 )
            {
                removeflares[ removeflares.size ] = flare;
                continue;
            }
            
            if ( distance( flare.origin, ( 152.944, 2415.51, 16.344 ) ) < 5 )
            {
                removeflares[ removeflares.size ] = flare;
                continue;
            }
            
            if ( distance( flare.origin, ( -334.5, 1990.5, 17.25 ) ) < 5 )
            {
                removeflares[ removeflares.size ] = flare;
                continue;
            }
            
            if ( distance( flare.origin, ( -751.056, 1479.51, 16.844 ) ) < 5 )
            {
                removeflares[ removeflares.size ] = flare;
            }
        }
        
        flares = arrayremove( flares, removeflares );
    }
    else if ( level.mapname == "mp_catedral" )
    {
        replacementtrigs = [];
        
        foreach ( trig in trigs )
        {
            groundpos = utility::drop_to_ground( trig.origin, 100 );
            radius = 128;
            crateradius = undefined;
            
            switch ( trig.script_label )
            {
                case #"hash_31100fbc01bd387c":
                    radius = 210;
                    break;
                case #"hash_311012bc01bd3d35":
                    radius = 295;
                    break;
                case #"hash_311011bc01bd3ba2":
                    radius = 225;
                    break;
                case #"hash_31100cbc01bd33c3":
                    radius = 200;
                    crateradius = 100;
                    break;
                case #"hash_31100bbc01bd3230":
                    radius = 345;
                    break;
            }
            
            newtrig = spawn( "trigger_radius", groundpos, 0, radius, 128 );
            newtrig.script_label = trig.script_label;
            newtrig.script_gameobjectname = trig.script_gameobjectname;
            newtrig.targetname = trig.targetname;
            newtrig.crateradius = crateradius ?? radius;
            replacementtrigs[ replacementtrigs.size ] = newtrig;
        }
        
        trigs = replacementtrigs;
    }
    else if ( level.mapname == "mp_crossing" )
    {
        replacementtrigs = [];
        
        foreach ( trig in trigs )
        {
            groundpos = utility::drop_to_ground( trig.origin, 100 );
            radius = 128;
            crateradius = undefined;
            
            switch ( trig.script_label )
            {
                case #"hash_31100fbc01bd387c":
                    radius = 215;
                    break;
                case #"hash_311012bc01bd3d35":
                    radius = 190;
                    break;
                case #"hash_311011bc01bd3ba2":
                    radius = 350;
                    break;
                case #"hash_31100cbc01bd33c3":
                    radius = 350;
                    break;
                case #"hash_31100bbc01bd3230":
                    radius = 350;
                    break;
            }
            
            newtrig = spawn( "trigger_radius", groundpos, 0, radius, 128 );
            newtrig.script_label = trig.script_label;
            newtrig.script_gameobjectname = trig.script_gameobjectname;
            newtrig.targetname = trig.targetname;
            newtrig.crateradius = crateradius ?? radius;
            replacementtrigs[ replacementtrigs.size ] = newtrig;
        }
        
        trigs = replacementtrigs;
    }
    
    foreach ( flare in flares )
    {
        groundpos = utility::drop_to_ground( flare.origin, 100 ) + ( 0, 0, 1.25 );
        scriptable = spawn( "script_model", groundpos );
        scriptable.angles = flare.angles;
        scriptable setmodel( "dz_flare_scriptable" );
        flare.scriptable = scriptable;
    }
    
    visuals = [];
    level.objectives = [];
    
    for ( i = 0; i < flares.size ; i++ )
    {
        errored = 0;
        flare = flares[ i ];
        trig = undefined;
        
        for ( j = 0; j < trigs.size ; j++ )
        {
            if ( flare.scriptable istouching( trigs[ j ] ) )
            {
                if ( isdefined( trig ) )
                {
                    maperrors[ maperrors.size ] = "flare at " + flare.origin + " is touching more than one \"flaretrigger\" trigger";
                    errored = 1;
                    break;
                }
                
                trig = trigs[ j ];
                break;
            }
        }
        
        if ( !isdefined( trig ) )
        {
            if ( !errored )
            {
                maperrors[ maperrors.size ] = "flare at " + flare.origin + " is not inside any \"flaretrigger\" trigger";
                continue;
            }
        }
        
        assert( !errored );
        visuals = [];
        visuals[ 0 ] = flare.scriptable;
        zone = obj_zonecapture::setupobjective( trig, visuals );
        zone.origin = trig.origin;
        zone.offset3d = ( 0, 0, 120 );
        level.objectives[ zone.objectivekey ] = zone;
    }
    
    if ( maperrors.size > 0 )
    {
        /#
            println( "<dev string:xf9>" );
            
            for ( i = 0; i < maperrors.size ; i++ )
            {
                println( maperrors[ i ] );
            }
            
            println( "<dev string:x120>" );
        #/
        
        assertmsg( "<dev string:x147>" );
        return;
    }
    
    return 1;
}

// Namespace grnd
// Params 0
// Checksum 0xe9068426, Offset: 0x2521
// Size: 0x463
function dzmainloop()
{
    if ( koth_shared::is_enabled() )
    {
        return;
    }
    
    level endon( #"game_ended" );
    seticonnames();
    initwaypointicons();
    setomnvar( "ui_objective_timer_stopped", 1 );
    setomnvar( "ui_hardpoint_timer", 0 );
    level.zone = getfirstzone();
    firstzone = 1;
    level.kothhillrotation = 0;
    flags::levelflagset( "first_zone_spawned" );
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level utility::waittill_any( "prematch_done", "start_mode_setup" );
    }
    
    level.zone obj_zonecapture::activatezone();
    level.favorclosespawnent = level.zone;
    level.zone.active = 1;
    level.zone gameobjects::setvisibleteam( "any" );
    level.zone gameobjects::setobjectivestatusicons( level.icontarget );
    telemetry_data = spawnstruct();
    telemetry_data.player = level.zone;
    telemetry_data.eventname = "hill_moved";
    telemetry_data.position = level.zone.trigger.origin;
    telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
    flags::gameflagwait( "prematch_done" );
    setomnvar( "ui_objective_timer_stopped", 0 );
    var_3cfcfd857dedb22b = 0;
    
    if ( level.firstzoneactivationdelay )
    {
        var_3cfcfd857dedb22b = 1;
        level.zoneendtime = int( gettime() + level.firstzoneactivationdelay * 1000 );
        setomnvar( "ui_hardpoint_timer", level.zoneendtime );
        setomnvar( "ui_hq_status", 6 );
        level.zoneislocked = 1;
        level thread hud_message::updatematchstatushintforallplayers( undefined, #"dz_control", #"dz_control" );
        level.zone thread gameobjects::function_d7321ef757ecefd7( level.firstzoneactivationdelay );
        wait level.firstzoneactivationdelay;
        level.zoneislocked = 0;
        level thread hud_message::updatematchstatushintforallplayers( undefined, #"dz_capture", #"dz_capture" );
    }
    
    sound::playsoundonplayers( "mp_dropzone_obj_new" );
    
    while ( true )
    {
        level.zone.visuals[ 0 ] setscriptablepartstate( "smoke", "idle", 0 );
        level.objectivesetorder = 1;
        waittillframeend();
        level.zone gameobjects::enableobject();
        level.zone.capturecount = 0;
        
        if ( level.codcasterenabled )
        {
            level.zone thread obj_zonecapture::trackgametypevips();
        }
        
        spawnlogic::clearlastteamspawns();
        hqactivatenextzone( var_3cfcfd857dedb22b, firstzone );
        firstzone = 0;
        var_3cfcfd857dedb22b = 0;
        setomnvar( "ui_hq_status", 8 );
        spawnlogic::clearlastteamspawns();
        hpcaptureloop();
        ownerteam = level.zone gameobjects::getownerteam();
        
        if ( level.pausemodetimer )
        {
            level gamelogic_mp::resumetimer();
        }
        
        level.lastcaptureteam = undefined;
        level.zone.active = 0;
        
        if ( level.usehpzonebrushes )
        {
            foreach ( player in level.players )
            {
                level.zone obj_zonecapture::hideplayerspecificbrushes( player );
            }
        }
        
        level.zone gameobjects::disableobject();
        level.zone gameobjects::allowuse( "none" );
        level.zone gameobjects::setownerteam( "neutral" );
        obj_zonecapture::updateservericons( "zone_shift", 0 );
        level notify( #"zone_reset" );
        setomnvar( "ui_hq_status", -1 );
        spawn_next_zone();
        
        if ( game_utility::getgametype() == "grnd" && level.kothhillrotation == 4 )
        {
        }
        
        setomnvar( "ui_hq_status", -1 );
        wait 1;
    }
}

// Namespace grnd
// Params 0
// Checksum 0xc9398408, Offset: 0x298c
// Size: 0x5b
function getfirstzone()
{
    if ( level.mapname == "mp_hardhat" )
    {
        zone = level.objectives[ "5" ];
        level.prevzoneindex = 5;
    }
    else
    {
        zone = level.objectives[ "1" ];
        level.prevzoneindex = 1;
    }
    
    return zone;
}

// Namespace grnd
// Params 0
// Checksum 0xe591f19b, Offset: 0x29f0
// Size: 0x4ed
function getnextzone()
{
    if ( level.zonerandomlocationorder )
    {
        var_8493e175a66447ea = [];
        
        foreach ( entry in level.teamnamelist )
        {
            var_8493e175a66447ea[ entry ] = ( 0, 0, 0 );
        }
        
        livingplayers = game_utility_mp::getpotentiallivingplayers();
        
        foreach ( player in livingplayers )
        {
            if ( player.team == "spectator" )
            {
                continue;
            }
            
            var_8493e175a66447ea[ player.team ] += player.origin;
        }
        
        avgpos = [];
        
        foreach ( entry in level.teamnamelist )
        {
            players = teams::getteamdata( entry, "players" );
            teamsize = max( players.size, 1 );
            avgpos[ entry ] = var_8493e175a66447ea[ entry ] / teamsize;
        }
        
        if ( !isdefined( level.prevzonelist ) || isdefined( level.prevzonelist ) && level.prevzonelist.size == level.objectives.size - 1 )
        {
            level.prevzonelist = [];
        }
        
        level.prevzonelist[ level.prevzonelist.size ] = level.prevzoneindex;
        playerweight = 0.7;
        zoneweight = 0.3;
        bestzoneindex = undefined;
        bestcost = undefined;
        
        foreach ( objective in level.objectives )
        {
            skip = 0;
            
            foreach ( zoneindex in level.prevzonelist )
            {
                if ( objective.objectivekey == string( zoneindex ) )
                {
                    skip = 1;
                    break;
                }
            }
            
            if ( skip )
            {
                continue;
            }
            
            zone = objective;
            playercost = 0;
            
            foreach ( entry in level.teamnamelist )
            {
                playercost += distance2dsquared( zone.curorigin, avgpos[ entry ] );
            }
            
            zonecost = distance2dsquared( zone.curorigin, level.zone.curorigin );
            totalcost = playercost * playerweight + zonecost * zoneweight;
            
            if ( !isdefined( bestcost ) || totalcost > bestcost )
            {
                bestcost = totalcost;
                bestzoneindex = objective.objectivekey;
            }
        }
        
        zone = level.objectives[ bestzoneindex ];
        level.prevzoneindex = bestzoneindex;
    }
    else
    {
        level.prevzoneindex++;
        
        if ( level.prevzoneindex > level.objectives.size )
        {
            level.prevzoneindex = 1;
        }
        
        zone = level.objectives[ string( level.prevzoneindex ) ];
    }
    
    return zone;
}

// Namespace grnd
// Params 0
// Checksum 0x6f6424ed, Offset: 0x2ee6
// Size: 0x157
function spawn_next_zone()
{
    writecurrentrotationteamscore();
    level.zone.visuals[ 0 ] setscriptablepartstate( "smoke", "off", 0 );
    level.zone obj_zonecapture::deactivatezone();
    level.zone = getnextzone();
    level.kothhillrotation++;
    level.zone obj_zonecapture::activatezone();
    level.favorclosespawnent = level.zone;
    level.zone.active = 1;
    level.zone.lastactivatetime = gettime();
    
    if ( level.zoneactivationdelay > 0 )
    {
        level.zone gameobjects::setobjectivestatusicons( level.icontarget );
    }
    else
    {
        level.zone gameobjects::setobjectivestatusicons( level.iconneutral );
    }
    
    telemetry_data = spawnstruct();
    telemetry_data.player = level.zone;
    telemetry_data.eventname = "hill_moved";
    telemetry_data.position = level.zone.trigger.origin;
    telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
}

// Namespace grnd
// Params 2
// Checksum 0x9f59cb16, Offset: 0x3045
// Size: 0x2bc
function hqactivatenextzone( var_3cfcfd857dedb22b, firstzone )
{
    if ( firstzone )
    {
        foreach ( entry in level.teamnamelist )
        {
            dialog::statusdialog( #"hash_be7886b111257d86", entry );
        }
    }
    else
    {
        foreach ( entry in level.teamnamelist )
        {
            dialog::statusdialog( #"grnd_new_zone", entry );
        }
    }
    
    sound::playsoundonplayers( "mp_dropzone_obj_new" );
    level.zone thread obj_zonecapture::hardpoint_setneutral();
    level.zone gameobjects::allowuse( "none" );
    
    if ( var_3cfcfd857dedb22b )
    {
    }
    else if ( level.zoneactivationdelay )
    {
        level.zone gameobjects::setobjectivestatusicons( level.icontarget );
        obj_zonecapture::updateservericons( "zone_activation_delay", 0 );
        level.zoneendtime = int( gettime() + 1000 * level.zoneactivationdelay );
        setomnvar( "ui_hardpoint_timer", level.zoneendtime );
        setomnvar( "ui_hq_status", 6 );
        level.zoneislocked = 1;
        level thread hud_message::updatematchstatushintforallplayers( undefined, #"dz_control", #"dz_control" );
        level.zone thread gameobjects::function_d7321ef757ecefd7( level.zoneactivationdelay );
        wait level.zoneactivationdelay;
        level.zoneislocked = 0;
        level thread hud_message::updatematchstatushintforallplayers( undefined, #"dz_capture", #"dz_capture" );
    }
    
    level.zone gameobjects::setobjectivestatusicons( level.iconneutral );
    obj_zonecapture::updateservericons( "neutral", 0 );
    
    if ( level.zoneduration )
    {
        obj_zonecapture::updateservericons( "neutral", 0 );
        thread movezoneaftertime( level.zoneduration );
        level.zoneendtime = int( gettime() + 1000 * level.zoneduration );
        setomnvar( "ui_hardpoint_timer", level.zoneendtime );
        return;
    }
    
    level.zonedestroyedbytimer = 0;
}

// Namespace grnd
// Params 0
// Checksum 0x2d658831, Offset: 0x3309
// Size: 0x198
function hpcaptureloop()
{
    level endon( #"game_ended" );
    level endon( #"zone_moved" );
    level.hpstarttime = gettime();
    
    while ( true )
    {
        level.zone gameobjects::allowuse( "enemy" );
        level.zone gameobjects::setvisibleteam( "any" );
        level.zone gameobjects::setusetext( &"mp/securing_position" );
        level.zone thread obj_zonecapture::hardpoint_setneutral();
        level.zone gameobjects::cancontestclaim( 1 );
        
        if ( isdefined( level.matchrules_droptime ) && level.matchrules_droptime )
        {
            level thread randomdrops();
        }
        
        msg = level utility::waittill_any_return( "zone_captured", "zone_destroyed" );
        
        if ( msg == "zone_destroyed" )
        {
            continue;
        }
        
        ownerteam = level.zone gameobjects::getownerteam();
        sound::playsoundonplayers( "mp_dropzone_captured_positive", ownerteam );
        sound::playsoundonplayers( "mp_dropzone_captured_negative", team_utility::getotherteam( ownerteam ) );
        level callback::callback( #"music_event", { #event_type:#"hq_new" } );
        thread updaterespawntimer();
        level waittill( #"zone_destroyed", destroy_team );
        level.spawndelay = undefined;
        
        if ( isdefined( destroy_team ) )
        {
            level.zone gameobjects::setownerteam( destroy_team );
            continue;
        }
        
        level.zone gameobjects::setownerteam( "none" );
    }
}

// Namespace grnd
// Params 0, eflags: 0xc
// Checksum 0x744063c1, Offset: 0x34a9
// Size: 0x342
function private awardcapturepoints()
{
    self notify( #"hash_55896c641e470dad" );
    self endon( #"hash_55896c641e470dad" );
    level endon( #"game_ended" );
    level endon( #"zone_reset" );
    level endon( #"zone_moved" );
    
    if ( koth_shared::is_enabled() )
    {
        return;
    }
    
    seconds = 1;
    
    while ( !level.gameended )
    {
        for ( waittime = 0; waittime < seconds ; waittime = 0 )
        {
            waitframe();
            hostmigration::waittillhostmigrationdone();
            waittime += level.framedurationseconds;
            
            if ( level.zone.stalemate )
            {
            }
        }
        
        var_7f4958ce4e4277c3 = namespace_277c922f0d0dc523::function_9b71aa2788e21706( level.zone );
        
        if ( var_7f4958ce4e4277c3 == #"hash_bb332da19f9944df" )
        {
            continue;
        }
        
        if ( !level.zone.stalemate && !level.gameended )
        {
            owning_team_name = namespace_277c922f0d0dc523::get_owning_team_name( level.zone );
            players_using = gameobjects_common::function_de2f4638a165d21c( level.zone, var_7f4958ce4e4277c3 );
            score = level.zoneadditivescoring ? players_using.size : 1;
            gamescore::giveteamscoreforobjective( owning_team_name, score, 0 );
            
            foreach ( player in players_using )
            {
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
                {
                    if ( isdefined( player.leaderboarddata[ "objTime" ] ) )
                    {
                        player.leaderboarddata[ "objTime" ] = player.leaderboarddata[ "objTime" ] + 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "objTime" ] ) )
                    {
                        [[ level.leaderboardfunc[ "objTime" ] ]]( player, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x15d>" );
                    
                    if ( isdefined( player.pers[ "objTime" ] ) )
                    {
                        player.pers[ "objTime" ] = player.pers[ "objTime" ] + 1;
                    }
                }
                
                if ( isdefined( player.timebyrotation[ level.kothhillrotation ] ) )
                {
                    player.timebyrotation[ level.kothhillrotation ]++;
                }
                else
                {
                    player.timebyrotation[ level.kothhillrotation ] = 1;
                }
                
                player persistence::statsetchild( "round", "objTime", player.pers[ "objTime" ] );
                player stats::setextrascore0( player.pers[ "objTime" ] );
                player gamescore::giveplayerscore( #"koth_in_obj", 10 );
            }
        }
    }
}

// Namespace grnd
// Params 1
// Checksum 0x77e08cb7, Offset: 0x37f3
// Size: 0x87
function movezoneaftertime( time )
{
    level notify( #"hash_3cfe4c8aad7733c7" );
    level endon( #"hash_3cfe4c8aad7733c7" );
    level endon( #"game_ended" );
    level endon( #"zone_reset" );
    level endon( #"hash_a5281c9480b32767" );
    level.zonemovetime = time;
    level.zonedestroyedbytimer = 0;
    obj_zonecapture::zonetimerwait();
    level.zonedestroyedbytimer = 1;
    level notify( #"zone_moved" );
    level notify( #"zone_destroyed" );
}

// Namespace grnd
// Params 5, eflags: 0x4
// Checksum 0x19f24a3b, Offset: 0x3882
// Size: 0x2d8
function private give_capture_credit( var_2b03add3a518dea6, capturetime, capture_team, lastcaptureteam, credit_player )
{
    level endon( #"game_ended" );
    
    if ( koth_shared::is_enabled() )
    {
        return;
    }
    
    level.lastcaptime = gettime();
    first_player = credit_player;
    
    if ( isdefined( first_player.owner ) )
    {
        first_player = first_player.owner;
    }
    
    if ( isplayer( first_player ) )
    {
        if ( !isscoreboosting( first_player ) )
        {
            telemetry_data = spawnstruct();
            telemetry_data.player = first_player;
            telemetry_data.eventname = "capture";
            telemetry_data.position = first_player.origin;
            telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
            first_player thread points::doscoreevent( #"dz_capture" );
            
            if ( isdefined( level.zone.lastactivatetime ) && gettime() - level.zone.lastactivatetime <= 2100 )
            {
                first_player thread points::doscoreevent( #"mode_hp_quick_cap" );
            }
        }
    }
    
    foreach ( player in var_2b03add3a518dea6 )
    {
        player updatecapsperminute( lastcaptureteam );
        
        if ( !isscoreboosting( player ) )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
            {
                if ( isdefined( player.leaderboarddata[ "captures" ] ) )
                {
                    player.leaderboarddata[ "captures" ] = player.leaderboarddata[ "captures" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "captures" ] ) )
                {
                    [[ level.leaderboardfunc[ "captures" ] ]]( player, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x15d>" );
                
                if ( isdefined( player.pers[ "captures" ] ) )
                {
                    player.pers[ "captures" ] = player.pers[ "captures" ] + 1;
                }
            }
            
            player persistence::statsetchild( "round", "captures", player.pers[ "captures" ] );
        }
        else
        {
            /#
                player iprintlnbold( "<dev string:x183>" );
            #/
        }
        
        wait 0.05;
    }
}

// Namespace grnd
// Params 0
// Checksum 0x40a7a72f, Offset: 0x3b62
// Size: 0x3bc
function randomdrops()
{
    level endon( #"game_ended" );
    flags::function_b0491bb92d5acbb6( "first_zone_spawned" );
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    level.grnd_previouscratetypes = [];
    
    while ( true )
    {
        hasowningteam = namespace_277c922f0d0dc523::function_79ed8dd2c414e8ed( level.zone );
        var_766d9694d6cd52f7 = 1;
        
        if ( hasowningteam && killstreak::currentactivevehiclecount() < killstreak::maxvehiclesallowed() && level.fauxvehiclecount + var_766d9694d6cd52f7 < killstreak::maxvehiclesallowed() && airdrop::getnumdroppedcrates() < 8 )
        {
            cratetype = common::getdropzonecratetype();
            nodes = [];
            
            if ( gameobjects_common::has_trigger_group( level.zone ) )
            {
                trigger_group = gameobjects_common::get_trigger_group( level.zone );
                
                foreach ( trigger in trigger_group::get_triggers( trigger_group ) )
                {
                    if ( isent( trigger ) )
                    {
                        nodes = arraycombine( nodes, getnodesintrigger( trigger ) );
                        continue;
                    }
                    
                    nodes = arraycombine( nodes, getnodesinradius( trigger.origin, trigger.radius ?? 100, 0 ) );
                }
            }
            else
            {
                trigger = gameobjects_shared::get_trigger( level.zone );
                nodes = getnodesintrigger( trigger );
            }
            
            if ( shoulddonodedrop( cratetype ) && isdefined( nodes ) && nodes.size > 0 )
            {
                nodesnum = randomintrange( 0, nodes.size );
                position = nodes[ nodesnum ];
                droporigin = getclosestpointonnavmesh( position.origin );
                tracestart = position.origin;
                traceend = droporigin;
                contentoverride = trace::create_contents( 0, 1, 1, 1, 0, 1, 0 );
                ignoreents = [];
                trace = trace::ray_trace( tracestart, traceend, ignoreents, contentoverride );
                position = trace[ "position" ];
            }
            else
            {
                position = getdropposition() + ( randomintrange( -50, 50 ), randomintrange( -50, 50 ), 0 );
            }
            
            owningteam = gameobjects_shared::function_623b07f4735aecb2( level.zone );
            vehicleisreserved = vehicle_tracking::reserve_vehicle();
            scenenode = undefined;
            streakinfo = spawnstruct();
            streakinfo.bundle = killstreak_utility::function_f943c0602acdc2af( "airdrop" );
            
            if ( cratetype == "mega" )
            {
                scenenode = airdrop_multiple::airdrop_multiple_dropcrates( undefined, owningteam, position, randomfloat( 360 ), position, vehicleisreserved, streakinfo );
            }
            else
            {
                scenenode = airdrop::dropkillstreakcratefromscriptedheli( undefined, owningteam, cratetype, position, randomfloat( 360 ), position, vehicleisreserved, streakinfo );
            }
            
            foreach ( crate in scenenode.crates )
            {
                crate.skipminimapicon = 1;
            }
            
            waittime = level.droptime;
            wait level.droptime;
            continue;
        }
        
        wait 0.5;
    }
}

// Namespace grnd
// Params 1
// Checksum 0x9e58c888, Offset: 0x3f26
// Size: 0x183, Type: bool
function shoulddonodedrop( cratetype )
{
    if ( cratetype == "mega" )
    {
        return false;
    }
    
    zone_trigger = gameobjects_shared::get_trigger( level.zone );
    
    if ( level.mapname == "mp_vacant" )
    {
        if ( zone_trigger.script_label == "4" )
        {
            return false;
        }
    }
    else if ( issubstr( level.mapname, "mp_aniyah" ) )
    {
        if ( zone_trigger.script_label == "1" )
        {
            return false;
        }
    }
    else if ( level.mapname == "mp_raid" )
    {
        if ( zone_trigger.script_label == "6" )
        {
            return false;
        }
    }
    else if ( level.mapname == "mp_petrograd" )
    {
        if ( zone_trigger.script_label == "1" )
        {
            return false;
        }
    }
    else if ( issubstr( level.mapname, "mp_hackney" ) )
    {
        if ( zone_trigger.script_label == "4" )
        {
            return false;
        }
    }
    else if ( issubstr( level.mapname, "mp_shipment" ) )
    {
        if ( zone_trigger.script_label == "1" )
        {
            return false;
        }
    }
    else if ( issubstr( level.mapname, "mp_emporium" ) )
    {
        return false;
    }
    else if ( level.mapname == "mp_backlot2" )
    {
        if ( zone_trigger.script_label == "5" )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace grnd
// Params 0
// Checksum 0x432b9fb4, Offset: 0x40b2
// Size: 0x173
function getdropposition()
{
    zone_trigger = gameobjects_shared::get_trigger( level.zone );
    
    if ( level.mapname == "mp_vacant" && isdefined( zone_trigger.script_label ) && zone_trigger.script_label == "4" )
    {
        return ( 1760, 701, 122 );
    }
    else if ( level.mapname == "mp_emporium" && isdefined( zone_trigger.script_label ) )
    {
        switch ( zone_trigger.script_label )
        {
            case #"hash_31100fbc01bd387c":
                return ( -732, -136, 608 );
            case #"hash_311012bc01bd3d35":
                return ( 672, -1336, 608 );
            case #"hash_311011bc01bd3ba2":
                return ( 44, 968, 608 );
            case #"hash_31100cbc01bd33c3":
                return ( -680, -1552, 608 );
            case #"hash_31100bbc01bd3230":
                return ( 832, 4, 608 );
        }
    }
    else if ( level.mapname == "mp_backlot2" && isdefined( zone_trigger.script_label ) && zone_trigger.script_label == "5" )
    {
        return ( -346, -2368, 66 );
    }
    
    return gameobjects_shared::get_origin( level.zone );
}

// Namespace grnd
// Params 0
// Checksum 0xbb3bfa0a, Offset: 0x422e
// Size: 0x104
function getbestplayer()
{
    bestplayer = undefined;
    besttime = 0;
    ownerteam = gameobjects_shared::function_623b07f4735aecb2( level.zone );
    
    if ( ownerteam == "neutral" || ownerteam == "none" )
    {
        return bestplayer;
    }
    
    players_using = gameobjects_shared::function_de2f4638a165d21c( level.zone, ownerteam );
    
    foreach ( object in players_using )
    {
        if ( besttime == 0 || besttime > object.starttime )
        {
            besttime = object.starttime;
            bestplayer = object.player;
        }
    }
    
    return bestplayer;
}

// Namespace grnd
// Params 0
// Checksum 0x9db0dda2, Offset: 0x433b
// Size: 0x2d4
function getspawnpoint()
{
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        var_ebfc366885697c15 = getobjzonedeadzonedist();
        current_zone = level.zone ?? getfirstzone();
        var_1db36f52276b333e = gameobjects_shared::get_objective_key( current_zone );
        spawnparams = spawnfactor::function_daea503b73d07eed( var_1db36f52276b333e, current_zone.furthestspawndistsq, var_ebfc366885697c15 * var_ebfc366885697c15, 12250000 );
        spawnpoint = spawnlogic::function_3f9d5fcfb93d4190( self, spawnparams, current_zone.spawngroup, #"fallback", #"default", 2 );
        
        if ( !spawnlogic::shoulduseteamstartspawn() && !spawnlogic::useablespawngroup( current_zone.spawngroup ) && level.spawnglobals.gametypeplayerspawn.var_b1b86dda63b48ce2 )
        {
            trigger_origin = undefined;
            
            if ( gameobjects_common::has_trigger_group( current_zone ) )
            {
                trigger_group = gameobjects_common::get_trigger_group( current_zone );
                trigger_origin = trigger_group.origin;
            }
            else
            {
                trigger = gameobjects_common::get_trigger( current_zone );
                trigger_origin = trigger.origin;
            }
            
            path = self findpath( spawnpoint.origin, trigger_origin, 1 );
            
            if ( isdefined( path ) && path.size > 2 )
            {
                fwd = vectornormalize( path[ 1 ] - path[ 0 ] );
                spawnpoint.angles = vectortoangles( fwd );
            }
        }
    }
    else
    {
        spawnteam = self.pers[ "team" ];
        current_zone = level.zone ?? getfirstzone();
        var_ebfc366885697c15 = getobjzonedeadzonedist();
        var_5604c97df7f05c1b = spawnfactor::function_daea503b73d07eed( gameobjects_common::get_objective_key( current_zone ), current_zone.furthestspawndistsq, var_ebfc366885697c15 * var_ebfc366885697c15, level.enemy_spawn_influence_dist_sq );
        
        if ( spawnlogic::shoulduseteamstartspawn() )
        {
            if ( spawnteam == game[ "attackers" ] )
            {
                spawnlogic::activatespawnset( #"start_attackers", 1 );
                spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, undefined, #"start_attackers", undefined, var_5604c97df7f05c1b );
            }
            else
            {
                spawnlogic::activatespawnset( #"start_defenders", 1 );
                spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, undefined, #"start_defenders", undefined, var_5604c97df7f05c1b );
            }
        }
        else
        {
            if ( !isdefined( level.switchedtohardpointspawnlogic ) )
            {
                level.switchedtohardpointspawnlogic = 1;
                spawnlogic::setactivespawnlogic( #"objective" );
            }
            
            function_fcde7b12329ffe17( current_zone );
            spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, current_zone.spawnset, current_zone.fallbackspawnset, 2, var_5604c97df7f05c1b );
        }
    }
    
    return spawnpoint;
}

// Namespace grnd
// Params 0
// Checksum 0xb9f9b2a6, Offset: 0x4618
// Size: 0xb
function getobjzonedeadzonedist()
{
    return level.spawn_deadzone_dist;
}

// Namespace grnd
// Params 1
// Checksum 0x442f48b3, Offset: 0x462c
// Size: 0x178
function function_fcde7b12329ffe17( zone )
{
    zone_trigger = gameobjects_shared::get_trigger( zone );
    
    if ( isdefined( zone.spawnpoints ) )
    {
        temp_spawnpoints = [];
        
        foreach ( spawnpoint in zone.spawnpoints )
        {
            if ( !ispointinvolume( spawnpoint.origin, zone_trigger ) )
            {
                temp_spawnpoints[ temp_spawnpoints.size ] = spawnpoint;
            }
        }
        
        zone.spawnpoints = temp_spawnpoints;
    }
    
    if ( isdefined( zone.fallbackspawnpoints ) )
    {
        temp_spawnpoints = [];
        
        foreach ( spawnpoint in zone.fallbackspawnpoints )
        {
            if ( !ispointinvolume( spawnpoint.origin, zone_trigger ) )
            {
                temp_spawnpoints[ temp_spawnpoints.size ] = spawnpoint;
            }
        }
        
        zone.fallbackspawnpoints = temp_spawnpoints;
    }
}

// Namespace grnd
// Params 1
// Checksum 0x696f128d, Offset: 0x47ac
// Size: 0xa5
function onplayerconnect( player )
{
    player.numcaps = 0;
    player.capsperminute = 0;
    player.timebyrotation = [];
    player stats::setextrascore0( player.pers[ "objTime" ] ?? 0, "objTime" );
    player stats::setextrascore1( player.pers[ "defends" ] ?? 0, "defends" );
    
    if ( isdefined( level.zone ) )
    {
        player setclientomnvar( "ui_hp_callout_id", level.zone.area_id );
    }
}

// Namespace grnd
// Params 1
// Checksum 0x56be53a1, Offset: 0x4859
// Size: 0x22
function onplayerspawned( player )
{
    while ( true )
    {
        player waittill( #"spawned" );
    }
}

// Namespace grnd
// Params 1
// Checksum 0x35e9b439, Offset: 0x4883
// Size: 0x2a
function onspawnplayer( revivespawn )
{
    lower_message::setlowermessageomnvar( "clear_lower_msg" );
    thread updatematchstatushintonspawn();
    level.personalnukecostoverride = 30;
}

// Namespace grnd
// Params 0
// Checksum 0x64db4004, Offset: 0x48b5
// Size: 0xab
function updaterespawntimer()
{
    level endon( #"game_ended" );
    level endon( #"zone_moved" );
    level endon( #"zone_destroyed" );
    starttime = gettime();
    
    if ( level.zoneduration > 0 )
    {
        endtime = starttime + level.zoneduration * 1000;
    }
    else
    {
        endtime = starttime + game_utility_mp::gettimelimit() * 1000 - game_utility::gettimepassed();
    }
    
    currenttime = starttime;
    
    while ( currenttime < endtime )
    {
        currenttime = gettime();
        level.spawndelay = ( endtime - currenttime ) / 1000 + 0.1;
        waitframe();
    }
}

// Namespace grnd
// Params 0
// Checksum 0x170600f7, Offset: 0x4968
// Size: 0x72
function seticonnames()
{
    level.icontarget = "dz_target";
    level.iconneutral = "dz_neutral";
    level.iconcapture = "dz_enemy";
    level.icondefend = "dz_friendly";
    level.iconcontested = "dz_contested";
    level.icontaking = "dz_taking";
    level.iconlosing = "dz_losing";
    level.icondefending = "dz_defending";
}

// Namespace grnd
// Params 0
// Checksum 0x1e50077f, Offset: 0x49e2
// Size: 0xeb
function initwaypointicons()
{
    gamelogic_mp::setwaypointiconinfo( "dz_enemy", 0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dz", 0 );
    gamelogic_mp::setwaypointiconinfo( "dz_friendly", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dz", 0 );
    gamelogic_mp::setwaypointiconinfo( "dz_defending", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dz", 0 );
    gamelogic_mp::setwaypointiconinfo( "dz_neutral", 0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dz", 0 );
    gamelogic_mp::setwaypointiconinfo( "dz_contested", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dz", 0 );
    gamelogic_mp::setwaypointiconinfo( "dz_losing", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dz", 0 );
    gamelogic_mp::setwaypointiconinfo( "dz_target", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0 );
    gamelogic_mp::setwaypointiconinfo( "dz_taking", 0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dz", 1 );
}

// Namespace grnd
// Params 1
// Checksum 0x3db3969e, Offset: 0x4ad5
// Size: 0xcf
function updatecapsperminute( lastownerteam )
{
    if ( !isdefined( self.capsperminute ) )
    {
        self.numcaps = 0;
        self.capsperminute = 0;
    }
    
    if ( !isdefined( lastownerteam ) || lastownerteam == "neutral" )
    {
        return;
    }
    
    self.numcaps++;
    minutespassed = game_utility::gettimepassed() / 60000;
    
    if ( isplayer( self ) && isdefined( self.timeplayed[ "total" ] ) )
    {
        minutespassed = self.timeplayed[ "total" ] / 60;
    }
    
    self.capsperminute = self.numcaps / minutespassed;
    
    if ( self.capsperminute > self.numcaps )
    {
        self.capsperminute = self.numcaps;
    }
}

// Namespace grnd
// Params 1
// Checksum 0xc54de73a, Offset: 0x4bac
// Size: 0x1a, Type: bool
function isscoreboosting( player )
{
    return player.capsperminute > 3;
}

// Namespace grnd
// Params 0
// Checksum 0xb538b326, Offset: 0x4bcf
// Size: 0x49
function writecurrentrotationteamscore()
{
    if ( level.kothhillrotation < 24 )
    {
        setmatchdata( "alliesRoundScore", level.kothhillrotation, getteamscore( "allies" ) );
        setmatchdata( "axisRoundScore", level.kothhillrotation, getteamscore( "axis" ) );
    }
}

// Namespace grnd
// Params 0
// Checksum 0x97fa6fa8, Offset: 0x4c20
// Size: 0x3d
function updatematchstatushintonspawn()
{
    level endon( #"game_ended" );
    
    if ( level.zoneislocked )
    {
        hud_message::function_ef4318a0090caa0f( #"hash_e5b05f9d6c0aac1f" );
        return;
    }
    
    hud_message::function_ef4318a0090caa0f( #"grnd_zone_capture" );
}

// Namespace grnd
// Params 2, eflags: 0x4
// Checksum 0xa76b9309, Offset: 0x4c65
// Size: 0x141
function private update_objective_icon_state( game_object, is_locked )
{
    if ( is_locked )
    {
        namespace_1cdb218d68ef13f6::set_objective_icon_state( game_object.objective_id, #"hash_8ba6cb81d28ab21c" );
        return;
    }
    
    var_536395db3d80fedb = namespace_277c922f0d0dc523::get_claim_team_hash( game_object );
    var_7f4958ce4e4277c3 = namespace_277c922f0d0dc523::function_9b71aa2788e21706( game_object );
    var_d07b2b95cdf20f0c = namespace_277c922f0d0dc523::function_a33241bbed7a745d( game_object );
    
    if ( namespace_277c922f0d0dc523::function_c849c18a5dce9088( game_object ) )
    {
        namespace_1cdb218d68ef13f6::set_objective_icon_state( game_object.objective_id, #"grnd_zone_contested" );
        return;
    }
    
    if ( var_7f4958ce4e4277c3 == #"hash_bb332da19f9944df" || var_536395db3d80fedb == #"hash_bb332da19f9944df" )
    {
        namespace_1cdb218d68ef13f6::set_objective_icon_state( game_object.objective_id, #"hash_a29260268aebcaec" );
        return;
    }
    
    if ( var_7f4958ce4e4277c3 != var_536395db3d80fedb )
    {
        namespace_1cdb218d68ef13f6::set_objective_icon_state( game_object.objective_id, #"hash_a69c3bfda0b6296c" );
        return;
    }
    
    if ( var_d07b2b95cdf20f0c == #"hash_bb332da19f9944df" )
    {
        namespace_1cdb218d68ef13f6::set_objective_icon_state( game_object.objective_id, #"hash_37b63f9d18e752ba" );
        return;
    }
    
    namespace_1cdb218d68ef13f6::set_objective_icon_state( game_object.objective_id, #"hash_b769d671120f1b55" );
}

// Namespace grnd
// Params 2, eflags: 0xc
// Checksum 0x6ec5668e, Offset: 0x4dae
// Size: 0xab
function private function_5ca98c75d64756c5( objective_id, time_ms )
{
    self notify( #"hash_2bc5f1fbfc321913" );
    self endon( #"hash_2bc5f1fbfc321913" );
    level endon( #"game_ended" );
    current_time_ms = 0;
    var_5cfdc51756a8db0 = 1 / time_ms;
    objidpoolmanager::objective_show_progress( objective_id, 1 );
    
    while ( current_time_ms < time_ms )
    {
        current_time_ms += level.frameduration;
        progress_fraction = current_time_ms * var_5cfdc51756a8db0;
        objidpoolmanager::objective_set_progress( objective_id, 1 - min( progress_fraction, 1 ) );
        waitframe();
    }
    
    objidpoolmanager::objective_show_progress( objective_id, 0 );
}

// Namespace grnd
// Params 1, eflags: 0x4
// Checksum 0x9b701027, Offset: 0x4e61
// Size: 0x10b
function private function_dc4c4c2b9f6a9ad( spawnpoint )
{
    spawnpoint.scriptdata.var_a881d5343a45f1a6 = [];
    
    foreach ( objective in level.objectives )
    {
        var_8b70d8aedcddc58c = gameobjects_shared::get_origin( objective );
        objective_distance_squared = distancesquared( spawnpoint.origin, var_8b70d8aedcddc58c );
        objective_key = gameobjects_shared::get_objective_key( objective );
        spawnpoint.scriptdata.var_a881d5343a45f1a6[ objective_key ] = objective_distance_squared;
        
        if ( objective_distance_squared > objective.furthestspawndistsq )
        {
            objective.furthestspawndistsq = objective_distance_squared;
        }
    }
}

// Namespace grnd
// Params 1, eflags: 0x4
// Checksum 0xbcbec025, Offset: 0x4f74
// Size: 0x144
function private function_144be83cf9436fa0( instance_id )
{
    foreach ( game_object in game_utility_mp::get_gametype_objectives( instance_id ) )
    {
        if ( gameobjects_common::has_trigger_group( game_object ) )
        {
            trigger_group = gameobjects_common::get_trigger_group( game_object );
            game_object.area_id = callouts::function_9a41f54921665d99( trigger_group.origin );
            continue;
        }
        
        trigger = gameobjects_common::get_trigger( game_object );
        
        if ( isdefined( trigger.script_noteworthy ) )
        {
            game_object.area_id = level.calloutglobals.areaidmap[ trigger.script_noteworthy ];
            continue;
        }
        
        if ( isent( trigger ) )
        {
            game_object.area_id = callouts::function_69298682a76ef6c5( trigger );
            continue;
        }
        
        game_object.area_id = callouts::function_9a41f54921665d99( trigger.origin );
    }
}

// Namespace grnd
// Params 1, eflags: 0x4
// Checksum 0xc4b89fc2, Offset: 0x50c0
// Size: 0x1ff
function private function_2770fdef48db2491( params )
{
    player = params.player;
    is_assist = params.is_assist;
    var_76e9eb89ea7138e3 = params.var_76e9eb89ea7138e3;
    
    if ( var_76e9eb89ea7138e3 )
    {
        /#
            player iprintlnbold( "<dev string:x183>" );
        #/
        
        return;
    }
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
    {
        if ( isdefined( player.leaderboarddata[ "captures" ] ) )
        {
            player.leaderboarddata[ "captures" ] = player.leaderboarddata[ "captures" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "captures" ] ) )
        {
            [[ level.leaderboardfunc[ "captures" ] ]]( player, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x15d>" );
        
        if ( isdefined( player.pers[ "captures" ] ) )
        {
            player.pers[ "captures" ] = player.pers[ "captures" ] + 1;
        }
    }
    
    player persistence::statsetchild( "round", "captures", player.pers[ "captures" ] );
    
    if ( !is_assist )
    {
        player stats::setextrascore2( player.pers[ "extrascore2" ] + 1 );
        telemetry_data = {};
        telemetry_data.player = player;
        telemetry_data.eventname = "capture";
        telemetry_data.position = player.origin;
        telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
        player thread points::doscoreevent( #"dz_capture" );
        return;
    }
    
    player thread points::doscoreevent( #"capture_assist" );
}

// Namespace grnd
// Params 1, eflags: 0x4
// Checksum 0xdcac9583, Offset: 0x52c7
// Size: 0x88
function private function_369d35ac6034c160( params )
{
    game_object = params.game_object;
    owning_team_name = params.owning_team_name;
    var_7f4958ce4e4277c3 = params.var_7f4958ce4e4277c3;
    
    if ( level.zoneadditivescoring )
    {
        players_using = gameobjects_common::function_de2f4638a165d21c( game_object, var_7f4958ce4e4277c3 );
        gamescore::giveteamscoreforobjective( owning_team_name, players_using.size, 0 );
        return;
    }
    
    gamescore::giveteamscoreforobjective( owning_team_name, 1, 0 );
}

// Namespace grnd
// Params 1, eflags: 0x4
// Checksum 0xc6358626, Offset: 0x5357
// Size: 0x221
function private on_player_score_interval( params )
{
    player = params.player;
    var_db2b1dde1497a248 = params.var_db2b1dde1497a248;
    is_first_interval = var_db2b1dde1497a248 == 1;
    var_5737c1c33e675415 = var_db2b1dde1497a248 % ( level.scoreeventglobals.var_f244d41a6bc4a67d ?? 4 ) == 0;
    should_notify_lua = is_first_interval || var_5737c1c33e675415;
    
    if ( var_5737c1c33e675415 )
    {
        player points::doscoreevent( #"grnd_in_obj" );
    }
    else if ( !level.scoreeventglobals.var_c21da95c189c7f73 )
    {
        points = rank::getscoreinfovalue( #"grnd_in_obj" );
        player gamescore::giveplayerscore( #"grnd_in_obj", points );
    }
    
    if ( should_notify_lua )
    {
        player setclientomnvar( "ui_score_chunking_notify", 1 );
        player thread utility::function_c2dfd06e2639cc7e( &setclientomnvar, "ui_score_chunking_notify", 0 );
    }
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
    {
        if ( isdefined( player.leaderboarddata[ "objTime" ] ) )
        {
            player.leaderboarddata[ "objTime" ] = player.leaderboarddata[ "objTime" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "objTime" ] ) )
        {
            [[ level.leaderboardfunc[ "objTime" ] ]]( player, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x15d>" );
        
        if ( isdefined( player.pers[ "objTime" ] ) )
        {
            player.pers[ "objTime" ] = player.pers[ "objTime" ] + 1;
        }
    }
    
    player persistence::statsetchild( "round", "objTime", player.pers[ "objTime" ] );
    player stats::setextrascore0( player.pers[ "objTime" ] );
}

// Namespace grnd
// Params 1, eflags: 0x4
// Checksum 0xed38c949, Offset: 0x5580
// Size: 0x1d5
function private function_aa8f15d9f14b98cc( params )
{
    game_object = params.game_object;
    lock_time_ms = params.lock_time_ms;
    instance_id = params.instance_id;
    zone_origin = gameobjects_common::get_origin( game_object );
    objective_icon_position = zone_origin + gameobjects_common::get_objective_icon_offset( game_object );
    game_object.objective_id = objidpoolmanager::requestobjectiveid();
    objidpoolmanager::objective_set_play_intro( game_object.objective_id, 1 );
    objidpoolmanager::objective_set_play_outro( game_object.objective_id, 0 );
    objidpoolmanager::objective_playermask_showtoall( game_object.objective_id );
    objidpoolmanager::update_objective_position( game_object.objective_id, objective_icon_position );
    objidpoolmanager::update_objective_state( game_object.objective_id, "current" );
    is_locked = lock_time_ms > 0;
    update_objective_icon_state( game_object, is_locked );
    hud_message::updatematchstatushintforallplayers( undefined, #"hash_e5b05f9d6c0aac1f", #"hash_e5b05f9d6c0aac1f" );
    gameplay_sound_fx::function_28103d3430792dce( zone_origin, #"hash_78def57587c51738" );
    
    if ( is_locked )
    {
        if ( !koth_shared::is_first_zone( game_object ) )
        {
            dialog::statusdialog( #"hash_4cb2dac9f6d48133", game_utility_mp::get_attacker_team( instance_id ) );
            dialog::statusdialog( #"hash_4cb2dac9f6d48133", game_utility_mp::get_defender_team( instance_id ) );
            callback::callback( #"music_event", { #event_type:#"hq_new" } );
        }
        
        game_object thread function_5ca98c75d64756c5( game_object.objective_id, lock_time_ms );
        setomnvar( "ui_hardpoint_timer", int( gettime() + lock_time_ms ) );
        setomnvar( "ui_hq_status", 6 );
    }
    
    flags::levelflagset( "first_zone_spawned" );
}

// Namespace grnd
// Params 1, eflags: 0x4
// Checksum 0x8eca36e0, Offset: 0x575d
// Size: 0x47
function private function_537d9824316d5d99( params )
{
    game_object = params.game_object;
    objidpoolmanager::objective_playermask_hidefromall( game_object.objective_id );
    objidpoolmanager::returnobjectiveid( game_object.objective_id );
}

// Namespace grnd
// Params 0, eflags: 0x4
// Checksum 0x600bca3c, Offset: 0x57ac
// Size: 0x1c3
function private function_bf70e8e73e6ea0dc()
{
    game_utility_mp::clean_up_entities( [ game_utility::getgametype(), "dz_flare" ] );
    triggers = getentarray( "grnd", #targetname );
    assert( triggers.size > 3, "<dev string:x1c8>" );
    
    foreach ( trigger in triggers )
    {
        var_24290c36e2cab388 = { #manual_drop:1, #var_7f4958ce4e4277c3:#"hash_bb332da19f9944df", #capture_segment_count:1, #var_333d3689d793bcc7:0, #use_time_seconds:0, #var_c68e9f43ed9cc918:#"hash_a1360b18943e920", #var_d7c90dc73c1dcba8:( 0, 0, 0 ), #objective_icon_offset:( 0, 0, 0 ), #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) };
        var_24290c36e2cab388.origin = trigger.origin;
        var_24290c36e2cab388.angles = trigger.angles;
        var_24290c36e2cab388.use_time_seconds = level.zonecapturetime;
        gameobjects_common::initialize_game_object( trigger.targetname, var_24290c36e2cab388, trigger, &function_51483b09a1807cd7 );
    }
}

// Namespace grnd
// Params 1, eflags: 0x4
// Checksum 0x893001d5, Offset: 0x5977
// Size: 0x83
function private function_51483b09a1807cd7( game_object )
{
    game_object_origin = gameobjects_common::get_origin( game_object );
    flare_origin = utility::drop_to_ground( game_object_origin, 32 );
    game_object.visuals = spawn( "script_model", flare_origin );
    game_object.visuals setmodel( "dz_flare_scriptable" );
    game_object.visuals setscriptablepartstate( "visibility", "show" );
    game_utility_mp::add_gametype_objective( game_object );
}

// Namespace grnd
// Params 1, eflags: 0x4
// Checksum 0xde08df49, Offset: 0x5a02
// Size: 0x1bb
function private function_6c2b1c0335034a16( params )
{
    game_object = params.game_object;
    instance_id = params.instance_id;
    
    if ( level.pausemodetimer )
    {
        gamelogic_mp::resumetimer();
    }
    
    function_fd022c4bb6ed6f48( game_object );
    function_fbc1c7f8eef77b55( game_object );
    update_objective_icon_state( game_object );
    game_object.visuals setscriptablepartstate( "smoke", "idle" );
    dialogue_hash = koth_shared::is_first_zone( game_object ) ? #"hash_be7886b111257d86" : #"grnd_new_zone";
    dialog::statusdialog( dialogue_hash, game_utility_mp::get_attacker_team( instance_id ) );
    dialog::statusdialog( dialogue_hash, game_utility_mp::get_defender_team( instance_id ) );
    zone_origin = gameobjects_common::get_origin( game_object );
    hud_message::updatematchstatushintforallplayers( undefined, #"grnd_zone_capture", #"grnd_zone_capture" );
    gameplay_sound_fx::function_28103d3430792dce( zone_origin, #"grnd_zone_activated" );
    
    foreach ( player in level.players )
    {
        player setclientomnvar( "ui_hp_callout_id", game_object.area_id );
    }
    
    setomnvar( "ui_hardpoint_timer", int( gettime() + 1000 * level.zoneduration ) );
    setomnvar( "ui_hq_status", 7 );
}

// Namespace grnd
// Params 1, eflags: 0x4
// Checksum 0xee2b2b11, Offset: 0x5bc5
// Size: 0x50
function private function_a1fba607824e9171( params )
{
    game_object = params.game_object;
    
    if ( level.pausemodetimer )
    {
        gamelogic_mp::pausetimer();
    }
    
    game_object.visuals setscriptablepartstate( "smoke", "off" );
}

// Namespace grnd
// Params 1, eflags: 0x4
// Checksum 0xc7a7785d, Offset: 0x5c1d
// Size: 0x6a
function private function_94a6de4e2d6c3b57( params )
{
    game_object = params.game_object;
    player = params.player;
    
    if ( level.pausemodetimer )
    {
        gamelogic_mp::pausetimer();
    }
    
    objidpoolmanager::objective_pin_player( game_object.objective_id, player );
    objidpoolmanager::function_b3b969f2930890eb( 2, player );
}

// Namespace grnd
// Params 1, eflags: 0x4
// Checksum 0x2bb6b25a, Offset: 0x5c8f
// Size: 0x56
function private function_80569e83bd3abfbf( params )
{
    game_object = params.game_object;
    player = params.player;
    objidpoolmanager::objective_unpin_player( game_object.objective_id, player );
    objidpoolmanager::function_b3b969f2930890eb( 0, player );
}

// Namespace grnd
// Params 1, eflags: 0x4
// Checksum 0x953e4e9c, Offset: 0x5ced
// Size: 0x4b
function private function_6a19a64439b0eea9( params )
{
    game_object = params.game_object;
    use_time_seconds = gameobjects_common::get_use_time_seconds( game_object );
    objidpoolmanager::objective_show_progress( game_object.objective_id, use_time_seconds > 0 );
}

// Namespace grnd
// Params 1, eflags: 0x4
// Checksum 0xd554131f, Offset: 0x5d40
// Size: 0x49
function private function_d8ee55e6aab29845( params )
{
    game_object = params.game_object;
    var_7ed0697b0eea44f8 = gameobjects_common::function_7ed0697b0eea44f8( game_object );
    objidpoolmanager::objective_show_progress( game_object.objective_id, var_7ed0697b0eea44f8 );
}

// Namespace grnd
// Params 1, eflags: 0x4
// Checksum 0x6090add3, Offset: 0x5d91
// Size: 0x53
function private on_use_update_cb( params )
{
    game_object = params.game_object;
    progress = params.progress;
    
    if ( progress > 0 )
    {
        objidpoolmanager::objective_set_progress( game_object.objective_id, progress );
    }
}

// Namespace grnd
// Params 1, eflags: 0x4
// Checksum 0x4226744a, Offset: 0x5dec
// Size: 0x49
function private function_d30aecaa8ade1f5( params )
{
    game_object = params.game_object;
    objidpoolmanager::objective_set_progress( game_object.objective_id, 0 );
    objidpoolmanager::objective_show_progress( game_object.objective_id, 0 );
}

// Namespace grnd
// Params 1, eflags: 0x4
// Checksum 0xde9869a1, Offset: 0x5e3d
// Size: 0x82
function private function_aaa1ceb9e48346dc( params )
{
    game_object = params.game_object;
    team_name = params.team_name;
    
    if ( game_utility_mp::is_attacker_team( team_name ) || game_utility_mp::is_defender_team( team_name ) )
    {
        objidpoolmanager::function_84651f3f2873ee19( game_object.objective_id, team_name );
    }
    else
    {
        objidpoolmanager::function_84651f3f2873ee19( game_object.objective_id, undefined );
    }
    
    update_objective_icon_state( game_object );
}

// Namespace grnd
// Params 1, eflags: 0x4
// Checksum 0xc9032a92, Offset: 0x5ec7
// Size: 0xa8
function private function_ceadb54c29c1a81a( params )
{
    game_object = params.game_object;
    team_name = params.team_name;
    
    if ( game_utility_mp::is_attacker_team( team_name ) || game_utility_mp::is_defender_team( team_name ) )
    {
        if ( level.pausemodetimer )
        {
            gamelogic_mp::pausetimer();
        }
        
        objidpoolmanager::update_objective_ownerteam( game_object.objective_id, team_name );
    }
    else
    {
        if ( level.pausemodetimer )
        {
            gamelogic_mp::resumetimer();
        }
        
        objidpoolmanager::update_objective_ownerteam( game_object.objective_id, undefined );
    }
    
    update_objective_icon_state( game_object );
}

// Namespace grnd
// Params 1, eflags: 0x4
// Checksum 0xb7925bf5, Offset: 0x5f77
// Size: 0x82
function private function_5a35159676e6e80d( params )
{
    game_object = params.game_object;
    team_name = params.team_name;
    
    if ( game_utility_mp::is_attacker_team( team_name ) || game_utility_mp::is_defender_team( team_name ) )
    {
        objidpoolmanager::objective_set_progress_team( game_object.objective_id, team_name );
    }
    else
    {
        objidpoolmanager::objective_set_progress_team( game_object.objective_id, undefined );
    }
    
    update_objective_icon_state( game_object );
}

// Namespace grnd
// Params 1, eflags: 0x4
// Checksum 0xd90d6085, Offset: 0x6001
// Size: 0x127
function private on_zone_captured_cb( params )
{
    game_object = params.game_object;
    team_name = params.team_name;
    other_team_name = team_utility::getotherteam( team_name );
    dialog::statusdialog( #"hash_3c247c56eb6ee6a2", team_name );
    dialog::statusdialog( #"hash_f011606c9335942f", other_team_name );
    zone_trigger = gameobjects_common::get_trigger( game_object );
    
    if ( gameobjects_common::has_trigger_group( game_object ) || !isent( zone_trigger ) )
    {
        gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_75530473b5176676", teams::getteamdata( team_name, "players" ) );
        gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_20d3ea007d182136", teams::getteamdata( other_team_name, "players" ) );
    }
    else
    {
        zone_trigger gameplay_sound_fx::function_6dac8db778849e61( #"hash_75530473b5176676", team_name, undefined, zone_trigger );
        zone_trigger gameplay_sound_fx::function_6dac8db778849e61( #"hash_20d3ea007d182136", other_team_name, undefined, zone_trigger );
    }
    
    objidpoolmanager::objective_set_progress( game_object.objective_id, 0 );
    objidpoolmanager::objective_show_progress( game_object.objective_id, 0 );
}

// Namespace grnd
// Params 1, eflags: 0x4
// Checksum 0x359dfceb, Offset: 0x6130
// Size: 0x37
function private function_d3f276c6e626d80( params )
{
    game_object = params.game_object;
    objidpoolmanager::update_objective_sethot( game_object.objective_id, 1 );
}

// Namespace grnd
// Params 1, eflags: 0x4
// Checksum 0x96d244d5, Offset: 0x616f
// Size: 0x36
function private function_7deb426f5232fa5f( params )
{
    game_object = params.game_object;
    objidpoolmanager::update_objective_sethot( game_object.objective_id, 0 );
}

// Namespace grnd
// Params 2, eflags: 0x4
// Checksum 0xd40efb5d, Offset: 0x61ad
// Size: 0x9f
function private function_fbc1c7f8eef77b55( game_object, team_name )
{
    game_object.spawninfluencers = [];
    zone_origin = gameobjects_common::get_origin( game_object );
    spawn_key = spawnlogic::function_d5c160a4110b573e();
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawn_key ) )
    {
        game_object.spawninfluencers[ #"gametype_hardpoint_zone" ] = spawnlogic::addspawninfluencer( #"gametype_hardpoint_zone", zone_origin );
        game_object.spawninfluencers[ #"hash_7cebf9e340111eb7" ] = spawnlogic::addspawninfluencer( #"hash_7cebf9e340111eb7", zone_origin );
    }
}

// Namespace grnd
// Params 1, eflags: 0x4
// Checksum 0xf1345c9a, Offset: 0x6254
// Size: 0xa1
function private function_fd022c4bb6ed6f48( game_object )
{
    if ( isdefined( game_object.spawninfluencers ) )
    {
        foreach ( influencer in game_object.spawninfluencers )
        {
            spawnlogic::removespawninfluencer( influencer );
        }
        
        game_object.spawninfluencers = undefined;
    }
}

