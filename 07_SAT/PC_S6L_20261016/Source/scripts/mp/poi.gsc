// scripts\mp\poi.gsc  (hash_5def7af2a9f04234.gscc) (size: 23264 Bytes / 0x5ae0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xac8038d4 (2894084308)
// size ...... 23264 (0x5ae0)
// includes .. 13  (offset: 0x5660)
// strings ... 64  (offset: 0x56c8)
// dev strs .. 0   (offset: 0x5ae0)
// exports ... 53  (offset: 0x3e00)
// cseg ...... 0x4b2 + 0x394e (0x3e00)
// imports ... 127 (offset: 0x4648)
// animtree1 . 0   (offset: 0x5ae0)
// animtree2 . 0   (offset: 0x5ae0)
#using scripts\common\callbacks;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\currency;
#using scripts\mp\flags;
#using scripts\mp\loot\common_item;

#namespace poi;

// Namespace poi
// Params 0
// Checksum 0x6f8478c2, Offset: 0x4d0
// Size: 0x34e
function poi_init()
{
    utility::flag_init( "poi_initialized" );
    utility::flag_init( "poi_default_funcs_initialized" );
    
    if ( getdvarint( @"scr_poi_system", 1 ) == 0 )
    {
        return;
    }
    
    function_c65dcebfc7a3a41c();
    level.var_9b27f7dce1bc303 = getdvarint( @"scr_poi_disable_all", 0 );
    level.var_6053799fc5292ab = getdvarint( @"hash_ad89f1c2b195eda2", 120 ) * 1000;
    level.poi = [];
    level.var_e38f0af66eb58ff2 = [];
    level.var_7825bf2cbbdee369 = [];
    callback::add( #"hash_6a3e445c5100cb67", &poidifficulty );
    
    if ( !isdefined( level.poi_names ) )
    {
        level.poi_names = [];
    }
    
    var_c85ee404ead4a183 = getdvarint( @"bg_compassregions_enabled", 1 );
    
    if ( var_c85ee404ead4a183 )
    {
        var_7155b217356dab2d = game_utility_mp::function_3e2a0e4a5bf03624();
        var_46671f231be8e83f = "mp/compass_regions/" + "compassregions_" + game_utility::getmapname() + "_poi_regions" + ".csv";
        compassregionsconfig = "mp/compass_regions/" + "compassregions_" + game_utility::getmapname() + "_" + var_7155b217356dab2d + "_poi_regions" + ".csv";
        function_d451ed5980378d2( compassregionsconfig, var_46671f231be8e83f, 1 );
    }
    
    function_26ee64a9eb19b76f();
    function_b3197749d64546d7();
    utility::script_func( "pois_found" );
    
    if ( level.var_f3eb0389ef8ac178 && isdefined( level.var_c66dede5fc9610c2 ) )
    {
        [[ level.var_c66dede5fc9610c2 ]]();
    }
    
    level.var_a78d7a5e7a1c74fb = var_c85ee404ead4a183 && function_989729b41cc7d6f7( 1 );
    
    if ( level.var_a78d7a5e7a1c74fb )
    {
        function_9924a6b0220e1cc8();
    }
    else
    {
        function_26ee64a9eb19b76f();
        function_b3197749d64546d7();
    }
    
    if ( !isdefined( level.poi_names ) )
    {
        return;
    }
    
    poidefaultstate = 1;
    
    if ( level.var_9b27f7dce1bc303 )
    {
        poidefaultstate = 0;
    }
    
    foreach ( poiname in level.poi_names )
    {
        dvarhash = hashcat( @"poi_", poiname );
        
        if ( getdvarint( dvarhash, poidefaultstate ) == 0 )
        {
            level.var_e38f0af66eb58ff2[ level.var_e38f0af66eb58ff2.size ] = poiname;
        }
        
        function_83e092dcbbd2ba3e( poiname );
    }
    
    if ( level.var_a78d7a5e7a1c74fb )
    {
        function_9e2a607447d3824();
        
        if ( game_utility::getgametype() == "dmz" )
        {
            function_91a057235d0bfc44();
        }
    }
    else
    {
        function_80edfebbcb20e166();
        
        if ( game_utility::getgametype() == "dmz" )
        {
            function_587647b8bc047430();
        }
    }
    
    level thread function_117c79cc2c4614bd();
    disconnect_event_aggregator::registerondisconnecteventcallback( &function_69e2a1577a147a94 );
    
    while ( !isdefined( level.var_b40e8430c5d07a40 ) )
    {
        waitframe();
    }
    
    function_e70b36c865e888f1();
    function_7bb68398828e82c2();
    utility::script_func( "pois_init" );
    utility::flag_set( "poi_initialized" );
    utility::registersharedfunc( #"poi", #"get_poi_name_from_origin", &poi_findpoioriginisin );
}

// Namespace poi
// Params 0
// Checksum 0x89b31788, Offset: 0x826
// Size: 0xb0
function function_c65dcebfc7a3a41c()
{
    utility::flag_init( "poi_default_funcs_initialized" );
    utility::registersharedfunc( #"poi", #"hash_79b3b95992c86428", &poi_findpoioriginisin_default );
    utility::registersharedfunc( #"poi", #"poi_issystemactive", &poi_issystemactive_default );
    utility::registersharedfunc( #"poi", #"hash_fc858bd1017130aa", &poi_getorigin );
    utility::registersharedfunc( #"poi", #"subarea_getorigin", &function_60ae3ea154c0090 );
    utility::registersharedfunc( #"poi", #"hash_cd2758a499bb6be4", &function_98b6b43120545617 );
    utility::flag_set( "poi_default_funcs_initialized" );
}

// Namespace poi
// Params 4
// Checksum 0x7bcaf4ff, Offset: 0x8de
// Size: 0x50
function poi_findpoioriginisin( origin, var_c6af19746fa74b39, includesuburbs, var_5041555eb50316c3 )
{
    poiname = utility::callsharedfunc( #"poi", #"hash_79b3b95992c86428", origin, var_c6af19746fa74b39 );
    return poiname;
}

// Namespace poi
// Params 4
// Checksum 0xc13b14cf, Offset: 0x937
// Size: 0x97
function poi_findpoioriginisin_default( origin, var_c6af19746fa74b39, includesuburbs, var_5041555eb50316c3 )
{
    poiname = undefined;
    
    if ( !poi_issystemactive() )
    {
        return poiname;
    }
    
    if ( level.var_a78d7a5e7a1c74fb )
    {
        siteidx = function_2d6761e072b4e500( 1, origin );
        
        if ( isdefined( siteidx ) )
        {
            poiname = level.poi_sites[ siteidx ];
        }
    }
    else
    {
        poiname = function_ad3a7f1bb576fbc7( origin, var_c6af19746fa74b39, var_5041555eb50316c3 );
    }
    
    if ( !isdefined( poiname ) )
    {
        poiname = function_c14b808f44505866( origin, var_c6af19746fa74b39, includesuburbs, var_5041555eb50316c3 );
    }
    
    return poiname;
}

// Namespace poi
// Params 0
// Checksum 0x6762e532, Offset: 0x9d7
// Size: 0x30
function poi_issystemactive()
{
    isactive = utility::callsharedfunc( #"poi", #"poi_issystemactive" );
    
    if ( !isdefined( isactive ) )
    {
        isactive = 0;
    }
    
    return isactive;
}

// Namespace poi
// Params 0
// Checksum 0x80b8ca57, Offset: 0xa10
// Size: 0xc, Type: bool
function poi_issystemactive_default()
{
    return isdefined( level.poi );
}

// Namespace poi
// Params 0, eflags: 0x4
// Checksum 0xae7ddedb, Offset: 0xa25
// Size: 0x31a
function private function_26ee64a9eb19b76f()
{
    level.poi_volumes = [];
    poivolumes = [];
    
    foreach ( volume in getentarray( "trigger_multiple", #code_classname ) )
    {
        if ( isdefined( volume.targetname ) && issubstr( volume.targetname, "poi_trigger_" ) )
        {
            poivolumes[ poivolumes.size ] = volume;
        }
    }
    
    foreach ( volume in getnoentvolumearray( "noent_volume_trigger", #classname ) )
    {
        if ( isdefined( volume.targetname ) && issubstr( volume.targetname, "poi_trigger_" ) )
        {
            poivolumes[ poivolumes.size ] = volume;
        }
    }
    
    foreach ( volume in getnoentvolumearray( "noent_volume_info", #classname ) )
    {
        if ( isdefined( volume.targetname ) && issubstr( volume.targetname, "poi_trigger_" ) )
        {
            poivolumes[ poivolumes.size ] = volume;
        }
    }
    
    if ( poivolumes.size > 0 )
    {
        foreach ( volume in poivolumes )
        {
            poiname = tolower( getsubstr( volume.targetname, 12 ) );
            
            if ( !isdefined( level.poi_names ) )
            {
                level.poi_names = [];
            }
            
            volume.script_poi = poiname;
            
            if ( !arraycontains( level.poi_names, poiname ) )
            {
                level.poi_names[ level.poi_names.size ] = poiname;
                level.poi_volumes[ poiname ] = volume;
                continue;
            }
            
            if ( !isdefined( level.var_e970d88bf9da9d2b ) )
            {
                level.var_e970d88bf9da9d2b = [];
            }
            
            level.var_e970d88bf9da9d2b[ poiname ] = level.poi_volumes[ poiname ];
            level.poi_volumes[ poiname ] = volume;
        }
    }
}

// Namespace poi
// Params 0, eflags: 0x4
// Checksum 0xd97acb6b, Offset: 0xd47
// Size: 0x208
function private function_b3197749d64546d7()
{
    level.poi_origins = [];
    level.poi_structs = [];
    
    if ( level.poi_volumes.size > 0 )
    {
        foreach ( poiname, volume in level.poi_volumes )
        {
            level.poi_origins[ poiname ] = volume.origin;
            poistruct = { #origin:volume.origin, #name:poiname };
            level.poi_structs[ level.poi_structs.size ] = poistruct;
        }
        
        return;
    }
    
    poiorigins = [];
    poiorigins[ "saba_hydro" ] = ( -8968, 8225, 772 );
    poiorigins[ "saba_oilfield" ] = ( -23684, 21737, 436 );
    poiorigins[ "saba_fort" ] = ( 18357, -54628, 2270 );
    poiorigins[ "saba_exhume" ] = ( -49193, 14284, 1674 );
    
    foreach ( poiname in level.poi_names )
    {
        if ( isdefined( poiorigins[ poiname ] ) )
        {
            level.poi_origins[ poiname ] = poiorigins[ poiname ];
            poistruct = { #origin:volume.origin, #name:poiname };
            level.poi_structs[ level.poi_structs.size ] = poistruct;
        }
    }
}

// Namespace poi
// Params 0, eflags: 0x4
// Checksum 0x893592ea, Offset: 0xf57
// Size: 0xba
function private function_b3444e9765baf954()
{
    foreach ( poiname, poi in level.poi )
    {
        var_428f19f04224c431 = spawnstruct();
        var_428f19f04224c431.poiname = poiname;
        var_428f19f04224c431.subareaname = "orphan";
        function_af949b3e1b544ec8( poiname, "subAreas", var_428f19f04224c431, var_428f19f04224c431.subareaname );
    }
}

// Namespace poi
// Params 0, eflags: 0x4
// Checksum 0xf1fb8cb9, Offset: 0x1019
// Size: 0x121
function private function_2bce7784795de961()
{
    foreach ( poi in level.poi )
    {
        if ( !isdefined( poi[ "subAreas" ] ) )
        {
            continue;
        }
        
        foreach ( subarea in poi[ "subAreas" ] )
        {
            subarea.livingagents = [];
            subarea.agentdeaths = 0;
            subarea.spawnpackage_required = [];
            subarea.spawnpackage_optional = [];
        }
    }
}

// Namespace poi
// Params 0, eflags: 0x4
// Checksum 0x8b4c2c98, Offset: 0x1142
// Size: 0x298
function private function_80edfebbcb20e166()
{
    ents = arraycombine( getentarray( "trigger_multiple", #classname ), getnoentvolumearray( "noent_volume_trigger", #classname ), getnoentvolumearray( "noent_volume_info", #classname ) );
    function_3fe3760adc2508e5( "subAreas" );
    
    foreach ( ent in ents )
    {
        if ( isdefined( ent.script_noteworthy ) && issubstr( ent.script_noteworthy, "subarea_" ) )
        {
            struct = spawnstruct();
            struct.trigger = ent;
            var_c5fb949765502c8d = "saba_";
            
            if ( isdefined( level.subareaprefix ) )
            {
                var_c5fb949765502c8d = level.subareaprefix;
            }
            
            tokens = strtok( ent.script_noteworthy, "_" );
            poiname = var_c5fb949765502c8d + tolower( function_5d044133536d0766( "_", utility::array_slice( tokens, 1, tokens.size - 1 ) ) );
            startindexoffset = tokens[ 0 ].size + tokens[ 1 ].size + 2;
            
            if ( issubstr( ent.script_noteworthy, "suburb_" ) || issubstr( ent.script_noteworthy, "suburbs_" ) )
            {
                startindexoffset = tokens[ 0 ].size + tokens[ 1 ].size + tokens[ 2 ].size + 3;
            }
            
            struct.subareaname = tolower( getsubstr( ent.script_noteworthy, startindexoffset ) );
            struct.script_poi = poiname;
            
            foreach ( poinamekey, poi in level.poi )
            {
                if ( issubstr( poinamekey, poiname ) )
                {
                    function_af949b3e1b544ec8( poinamekey, "subAreas", struct, struct.subareaname );
                }
            }
        }
    }
    
    function_b3444e9765baf954();
    function_2bce7784795de961();
}

// Namespace poi
// Params 1
// Checksum 0xba58727f, Offset: 0x13e2
// Size: 0x79
function function_db0e4b7793a08ae5( poiname )
{
    poiindex = undefined;
    
    if ( level.var_a78d7a5e7a1c74fb )
    {
        poiindex = level.poi_regions[ poiname ];
    }
    else
    {
        poiindex = tablelookup( "mp/map_callouts/" + level.mapname + "_callouts.csv", 1, poiname, 0 );
        
        if ( poiindex )
        {
            poiindex = int( poiindex );
        }
        else
        {
            poiindex = function_f02c63b99c9614c9( level.poi_names, poiname );
        }
    }
    
    return poiindex;
}

// Namespace poi
// Params 1
// Checksum 0x8af81fdf, Offset: 0x1464
// Size: 0x17
function function_3ffc80a8dff97782( poiindexes )
{
    level.poiindexes = poiindexes;
}

// Namespace poi
// Params 1
// Checksum 0xe3cf6247, Offset: 0x1483
// Size: 0x3d
function function_98b6b43120545617( poiname )
{
    var_a72ac4dda42a6b4e = 0;
    
    if ( isdefined( poiname ) )
    {
        potentialindex = function_db0e4b7793a08ae5( poiname );
        
        if ( isdefined( potentialindex ) )
        {
            var_a72ac4dda42a6b4e = potentialindex;
        }
    }
    
    return var_a72ac4dda42a6b4e;
}

// Namespace poi
// Params 0, eflags: 0x4
// Checksum 0x8ef27cb1, Offset: 0x14c9
// Size: 0x197
function private function_587647b8bc047430()
{
    if ( !isdefined( level.poi_volumes ) )
    {
        return;
    }
    
    if ( level.var_f7735c8a5a7ab2fe )
    {
        return;
    }
    
    foreach ( pname in level.poi_names )
    {
        if ( !isdefined( level.poi[ pname ] ) )
        {
            continue;
        }
        
        level.poi[ pname ][ "otherPoiByDist" ] = [];
        curorigin = level.poi_origins[ pname ];
        var_60144497d4e98854 = sortbydistance( level.poi_volumes, curorigin );
        
        foreach ( volume in var_60144497d4e98854 )
        {
            if ( isdefined( level.poi[ volume.script_poi ] ) )
            {
                level.poi[ pname ][ "otherPoiByDist" ][ level.poi[ pname ][ "otherPoiByDist" ].size ] = volume.script_poi;
            }
        }
    }
}

// Namespace poi
// Params 1
// Checksum 0xc7beb65f, Offset: 0x1668
// Size: 0x90
function function_83e092dcbbd2ba3e( poiname )
{
    if ( !poi_issystemactive() )
    {
        return;
    }
    
    if ( isdefined( level.poi[ poiname ] ) )
    {
        return level.poi[ poiname ];
    }
    
    if ( !poi_ispoiactive( poiname ) )
    {
        return;
    }
    
    level.poi[ poiname ] = function_ec969fad15e7daa4();
    level.poi[ poiname ][ "name" ] = poiname;
    level.poi[ poiname ][ "calloutIndex" ] = function_db0e4b7793a08ae5( poiname );
    return level.poi[ poiname ];
}

// Namespace poi
// Params 1, eflags: 0x4
// Checksum 0x474b2fab, Offset: 0x1701
// Size: 0x93
function private function_ec969fad15e7daa4( poi = [] )
{
    foreach ( featurename in level.var_7825bf2cbbdee369 )
    {
        if ( !isdefined( poi[ featurename ] ) )
        {
            poi[ featurename ] = [];
        }
    }
    
    return poi;
}

// Namespace poi
// Params 1
// Checksum 0x73bcfb0b, Offset: 0x179d
// Size: 0xc6
function function_3fe3760adc2508e5( featurename )
{
    if ( !poi_issystemactive() )
    {
        return;
    }
    
    if ( !arraycontains( level.var_7825bf2cbbdee369, featurename ) )
    {
        level.var_7825bf2cbbdee369[ level.var_7825bf2cbbdee369.size ] = featurename;
    }
    
    foreach ( index, poi in level.poi )
    {
        level.poi[ index ] = function_ec969fad15e7daa4( poi );
    }
}

// Namespace poi
// Params 2
// Checksum 0xc00d841a, Offset: 0x186b
// Size: 0x50
function function_f05a87fd5e748420( poiname, featurename )
{
    if ( !poi_issystemactive() )
    {
        return;
    }
    
    if ( !( isdefined( poiname ) && isdefined( featurename ) ) )
    {
        return;
    }
    
    if ( !arraycontains( level.var_7825bf2cbbdee369, featurename ) )
    {
        return;
    }
    
    return level.poi[ poiname ][ featurename ];
}

// Namespace poi
// Params 4
// Checksum 0x32c3ff59, Offset: 0x18c4
// Size: 0x95
function function_af949b3e1b544ec8( poiname, featurename, arrayelement, customkey )
{
    if ( !poi_issystemactive() )
    {
        return;
    }
    
    if ( !isdefined( poiname ) )
    {
        return;
    }
    
    if ( !poi_ispoiactive( poiname ) )
    {
        return;
    }
    
    if ( !isdefined( level.poi[ poiname ] ) )
    {
        return;
    }
    
    if ( isdefined( customkey ) )
    {
        level.poi[ poiname ][ featurename ][ customkey ] = arrayelement;
        return;
    }
    
    level.poi[ poiname ][ featurename ][ level.poi[ poiname ][ featurename ].size ] = arrayelement;
}

// Namespace poi
// Params 1
// Checksum 0xea141e88, Offset: 0x1961
// Size: 0x2c
function poi_getorigin( poiname )
{
    if ( isdefined( poiname ) && isdefined( level.poi_origins ) )
    {
        return level.poi_origins[ poiname ];
    }
}

// Namespace poi
// Params 1
// Checksum 0x30466df4, Offset: 0x1996
// Size: 0x72
function function_60ae3ea154c0090( subarea )
{
    origin = undefined;
    
    if ( isdefined( subarea ) )
    {
        if ( level.var_a78d7a5e7a1c74fb )
        {
            if ( isdefined( subarea.origin ) )
            {
                origin = subarea.origin;
            }
        }
        else if ( isdefined( subarea.trigger ) )
        {
            origin = subarea.trigger.origin;
        }
    }
    
    return origin;
}

// Namespace poi
// Params 3
// Checksum 0x1a84a7df, Offset: 0x1a11
// Size: 0x55, Type: bool
function function_4da557e2eb873ee6( origin, poi = poi_findpoioriginisin( origin, 1 ), _ )
{
    return isdefined( poi ) && ( !isdefined( level.var_e38f0af66eb58ff2 ) || !arraycontains( level.var_e38f0af66eb58ff2, poi ) );
}

// Namespace poi
// Params 2
// Checksum 0xb3634ac, Offset: 0x1a6f
// Size: 0x159
function function_6bd7e6ecb5d9e062( poiname, origin )
{
    if ( level.var_a78d7a5e7a1c74fb )
    {
        var_6239d87d487d59d9 = function_2d6761e072b4e500( 2, origin );
        
        foreach ( subarea in level.poi[ poiname ][ "subAreas" ] )
        {
            if ( var_6239d87d487d59d9 == subarea.site )
            {
                return subarea;
            }
        }
        
        return;
    }
    
    foreach ( subarea in level.poi[ poiname ][ "subAreas" ] )
    {
        if ( isdefined( subarea.trigger ) && ispointinvolume( origin, subarea.trigger ) )
        {
            return subarea;
        }
    }
}

// Namespace poi
// Params 1
// Checksum 0x714a78f0, Offset: 0x1bd1
// Size: 0x68
function function_356e66e91a150a02( poiname )
{
    if ( level.var_a78d7a5e7a1c74fb )
    {
        assert( isdefined( level.poi_regions ) );
        var_ebd85467250d2111 = level.poi_regions[ poiname ];
        
        if ( isdefined( var_ebd85467250d2111 ) )
        {
            poiregion = function_ba8494ae1c952908( 1, var_ebd85467250d2111 );
            return poiregion.name;
        }
    }
    
    return poiname;
}

// Namespace poi
// Params 4, eflags: 0x4
// Checksum 0x2087e6e5, Offset: 0x1c42
// Size: 0x133
function private function_ad3a7f1bb576fbc7( origin, var_c6af19746fa74b39, includesuburbs, var_5041555eb50316c3 )
{
    if ( !poi_issystemactive() )
    {
        return;
    }
    
    if ( !isdefined( var_c6af19746fa74b39 ) )
    {
        var_c6af19746fa74b39 = 0;
    }
    
    if ( !isdefined( includesuburbs ) )
    {
        includesuburbs = 1;
    }
    
    if ( !isdefined( var_5041555eb50316c3 ) )
    {
        var_5041555eb50316c3 = 0;
    }
    
    pois = var_c6af19746fa74b39 ? level.poi_names : getarraykeys( level.poi );
    
    foreach ( poiname in pois )
    {
        if ( !includesuburbs && issubstr( poiname, "suburb" ) )
        {
            continue;
        }
        
        if ( var_5041555eb50316c3 && !isdefined( level.poi[ poiname ][ "calloutIndex" ] ) )
        {
            continue;
        }
        
        if ( isdefined( level.poi_volumes[ poiname ] ) )
        {
            if ( function_16eafa02b83b5736( origin, poiname ) )
            {
                return poiname;
            }
        }
    }
}

// Namespace poi
// Params 2
// Checksum 0xc71d30da, Offset: 0x1d7d
// Size: 0x83
function function_16eafa02b83b5736( origin, poiname )
{
    if ( poi_issystemactive() )
    {
        var_f48b1422540291b7 = isdefined( level.poi_volumes[ poiname ] ) && ispointinvolume( origin, level.poi_volumes[ poiname ] );
        var_9bfee0ad6469af3a = isdefined( level.var_e970d88bf9da9d2b[ poiname ] ) && ispointinvolume( origin, level.var_e970d88bf9da9d2b[ poiname ] );
        return ( var_f48b1422540291b7 || var_9bfee0ad6469af3a );
    }
}

// Namespace poi
// Params 4
// Checksum 0xd981ad14, Offset: 0x1e09
// Size: 0x14c
function function_c14b808f44505866( origin, var_c6af19746fa74b39 = 0, includesuburbs = 1, var_5041555eb50316c3 = 0 )
{
    if ( !isdefined( origin ) || !level.poi_structs )
    {
        return;
    }
    
    if ( poi_issystemactive() )
    {
        pois = function_628bac9faa9d1e86( level.poi_structs, origin );
        
        foreach ( poi in pois )
        {
            poiname = poi.name;
            
            if ( !includesuburbs && issubstr( poiname, "suburb" ) )
            {
                continue;
            }
            
            if ( !var_c6af19746fa74b39 && !isdefined( level.poi[ poiname ] ) )
            {
                continue;
            }
            
            if ( var_5041555eb50316c3 && !isdefined( level.poi[ poiname ][ "calloutIndex" ] ) )
            {
                continue;
            }
            
            return poiname;
        }
    }
}

// Namespace poi
// Params 3
// Checksum 0x9dfceee5, Offset: 0x1f5d
// Size: 0x77
function poi_findandassignforagent( agent, poiname, origin )
{
    if ( !isdefined( poiname ) )
    {
        poiname = undefined;
        var_16ba410437a14cd3 = agent.origin;
        
        if ( isdefined( origin ) )
        {
            var_16ba410437a14cd3 = origin;
        }
        
        poiname = poi_findpoioriginisin( var_16ba410437a14cd3 );
    }
    
    agent.script_poi = poiname;
    
    if ( isdefined( poiname ) )
    {
        agent.poiname = poiname;
    }
    
    return poiname;
}

// Namespace poi
// Params 2
// Checksum 0xc78094f8, Offset: 0x1fdd
// Size: 0xa3
function function_1753e32730117e8d( array, poiname )
{
    temparray = [];
    
    foreach ( item in array )
    {
        if ( item.script_poi == poiname )
        {
            temparray[ temparray.size ] = item;
        }
    }
    
    return temparray;
}

// Namespace poi
// Params 1
// Checksum 0x81c40487, Offset: 0x2089
// Size: 0x17
function function_613d77978dc08bd0( array )
{
    level.poi_names = array;
}

// Namespace poi
// Params 1
// Checksum 0xdd8ce210, Offset: 0x20a8
// Size: 0x40, Type: bool
function poi_ispoiactive( poiname )
{
    return isdefined( poiname ) && poi_issystemactive() && arraycontains( level.poi_names, poiname ) && !arraycontains( level.var_e38f0af66eb58ff2, poiname );
}

// Namespace poi
// Params 0
// Checksum 0x8496908c, Offset: 0x20f1
// Size: 0x21, Type: bool
function function_fbe74cc793e2b81b()
{
    return poi_issystemactive() && level.var_e38f0af66eb58ff2.size < level.poi_names.size;
}

// Namespace poi
// Params 1, eflags: 0xc
// Checksum 0xc69ed79b, Offset: 0x211b
// Size: 0xe8
function private function_4fc7a9b8d3774a4a( poiname )
{
    self notify( #"hash_db1e5709a96ba660" );
    self endon( #"hash_db1e5709a96ba660" );
    level endon( #"match_end" );
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( level.poi[ poiname ][ "calloutIndex" ] ) )
    {
        return;
    }
    
    while ( !( self isonground() || self isswimming() || self ishanging() || self isonladder() || self isvehicleactive() ) )
    {
        waitframe();
    }
    
    if ( !isdefined( self.poivisited ) )
    {
        self.poivisited = [];
    }
    
    calloutIndex = level.poi[ poiname ][ "calloutIndex" ];
    
    if ( !isdefined( self.poivisited[ calloutIndex ] ) )
    {
        challenges::function_37e945722d6497f3( self, "visite_poi", 1 );
        self.poivisited[ calloutIndex ] = 1;
    }
}

// Namespace poi
// Params 0, eflags: 0x4
// Checksum 0x95bb42a4, Offset: 0x220b
// Size: 0x296
function private function_117c79cc2c4614bd()
{
    level utility::waittill_any( "matchStartTimer_done", "br_ready_to_jump" );
    
    while ( !isdefined( level.players ) || level.poi.size == 0 )
    {
        waitframe();
    }
    
    isdmz = istrue( level.var_9de2d66a20de512f );
    var_f0f65436d43f73bc = getdvarint( @"hash_a9f6d0e41ea4bc32", 0 );
    var_acbef3fbe4e5b495 = getdvarint( @"hash_57b012f2c429bcb9", 1 );
    var_a9b4969c0275bc0c = getdvarint( @"hash_88e87d9d935136d0", 5000 );
    frameduration = level.frameduration;
    
    if ( isdmz && var_acbef3fbe4e5b495 )
    {
        foreach ( player in level.players )
        {
            poiname = function_ad3a7f1bb576fbc7( player.origin );
            
            if ( isdefined( poiname ) )
            {
                difficulty = function_cfc4eae425b5dce1( poiname );
                player setclientomnvar( "ui_dmz_poi_difficulty_rating", difficulty );
            }
        }
    }
    
    foreach ( poiname, poi in level.poi )
    {
        level.poi[ poiname ][ "players" ] = [];
    }
    
    while ( true )
    {
        players = level.players;
        var_d075e30679df368f = 1;
        playersupdated = 0;
        timepassed = 0;
        
        for ( playeridx = 0; playeridx < players.size ; playeridx++ )
        {
            player = players[ playeridx ];
            
            if ( !isdefined( player ) || player.brneverlanded )
            {
                continue;
            }
            
            player function_1cf53a8871561687( isdmz, var_f0f65436d43f73bc, var_acbef3fbe4e5b495 );
            playersupdated++;
            
            if ( playersupdated >= var_d075e30679df368f )
            {
                playersupdated = 0;
                timepassed += frameduration;
                waitframe();
            }
        }
        
        waittime = ( var_a9b4969c0275bc0c - timepassed ) * 0.001;
        
        if ( waittime > 0 )
        {
            wait waittime;
        }
    }
}

// Namespace poi
// Params 3, eflags: 0x4
// Checksum 0xf2f22cad, Offset: 0x24a9
// Size: 0x223
function private function_1cf53a8871561687( isdmz, var_f0f65436d43f73bc, var_acbef3fbe4e5b495 )
{
    player = self;
    player.sublocation = undefined;
    
    if ( isdmz && isdefined( level.var_2e695a893d04be22 ) )
    {
        foreach ( name, trigger in level.var_2e695a893d04be22 )
        {
            if ( ispointinvolume( player.origin, trigger ) )
            {
                player.sublocation = name;
                break;
            }
        }
    }
    
    previouspoi = player.closestpoi;
    previsvalid = isdefined( previouspoi );
    player.lastvalidpoi = previouspoi ?? player.lastvalidpoi;
    poiname = poi_findpoioriginisin( player.origin );
    player.closestpoi = poiname;
    
    if ( isdefined( poiname ) )
    {
        var_3806dc1b04245fc6 = !previsvalid || previouspoi != poiname;
        
        if ( var_3806dc1b04245fc6 )
        {
            player function_fc38ec4895e5fe69();
            
            if ( previsvalid )
            {
                level.poi[ previouspoi ][ "players" ] = arrayremove( level.poi[ previouspoi ][ "players" ], player );
            }
            
            level.poi[ poiname ][ "players" ][ level.poi[ poiname ][ "players" ].size ] = player;
        }
        
        var_f16a47bfb6ab9bbf = var_f0f65436d43f73bc ? function_356e66e91a150a02( poiname ) : poiname;
        player thread function_745822b34a9f6969( poiname, var_f16a47bfb6ab9bbf, var_3806dc1b04245fc6, isdmz, var_acbef3fbe4e5b495 );
        return;
    }
    
    if ( previsvalid )
    {
        level.poi[ previouspoi ][ "players" ] = arrayremove( level.poi[ previouspoi ][ "players" ], player );
    }
}

// Namespace poi
// Params 0, eflags: 0x4
// Checksum 0x13d460b6, Offset: 0x26d4
// Size: 0x340
function private function_fc38ec4895e5fe69()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    hotzones = function_e2a061fcb85d84b5();
    
    if ( !hotzones.size )
    {
        return;
    }
    
    player = self;
    
    if ( !isplayer( player ) || isbot( player ) || istestclient( player ) || player isplayerheadless() )
    {
        return;
    }
    
    previouspoi = player.lastvalidpoi ?? "";
    var_7f05151ad8f04b18 = level.poi[ previouspoi ][ "isHot" ] ?? 0;
    currentpoi = player.closestpoi ?? "";
    var_7d78768acb028484 = level.poi[ currentpoi ][ "isHot" ] ?? 0;
    
    if ( !var_7f05151ad8f04b18 && !var_7d78768acb028484 )
    {
        return;
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "previous_poi_name";
    eventparams[ eventparams.size ] = previouspoi;
    eventparams[ eventparams.size ] = "previous_poi_is_hot";
    eventparams[ eventparams.size ] = var_7f05151ad8f04b18;
    eventparams[ eventparams.size ] = "current_poi_name";
    eventparams[ eventparams.size ] = currentpoi;
    eventparams[ eventparams.size ] = "current_poi_is_hot";
    eventparams[ eventparams.size ] = var_7d78768acb028484;
    eventparams[ eventparams.size ] = "is_player_entering_hotzone";
    
    if ( var_7f05151ad8f04b18 )
    {
        if ( var_7d78768acb028484 )
        {
            var_d84afe19273d812 = 2;
        }
        else
        {
            var_d84afe19273d812 = 0;
        }
    }
    else if ( var_7d78768acb028484 )
    {
        var_d84afe19273d812 = 1;
    }
    else
    {
        var_d84afe19273d812 = -1;
    }
    
    eventparams[ eventparams.size ] = var_d84afe19273d812;
    eventparams[ eventparams.size ] = "player_current_money";
    currentmoney = player currency::get_currency_amount( "cash" );
    eventparams[ eventparams.size ] = currentmoney ?? 0;
    eventparams[ eventparams.size ] = "player_buyback_count";
    eventparams[ eventparams.size ] = player.endmatchstats[ "kioskRevives" ] ?? 0;
    eventparams[ eventparams.size ] = "player_cash_spent";
    eventparams[ eventparams.size ] = player.endmatchstats[ "cashSpent" ] ?? 0;
    eventparams[ eventparams.size ] = "player_team_name";
    eventparams[ eventparams.size ] = player.team ?? "";
    eventparams[ eventparams.size ] = "teammates_currently_in_hot_zone";
    var_31c28efbb9ea9791 = 0;
    teammates = teams::function_d032b36d01bbbab3( player.team, player.sessionsquadid, 1 );
    
    foreach ( teammate in teammates )
    {
        if ( !isdefined( teammate ) )
        {
            continue;
        }
        
        currentpoi = teammate.closestpoi ?? "";
        var_7d78768acb028484 = level.poi[ currentpoi ][ "isHot" ] ?? 0;
        
        if ( var_7d78768acb028484 )
        {
            var_31c28efbb9ea9791++;
        }
    }
    
    eventparams[ eventparams.size ] = var_31c28efbb9ea9791;
    eventparams[ eventparams.size ] = "circle_index";
    circleindex = level.br_circle.circleindex ?? -1;
    eventparams[ eventparams.size ] = circleindex;
    player dlog_recordplayerevent( "dlog_event_br_hot_zones_entry_exit", eventparams );
}

// Namespace poi
// Params 5, eflags: 0x4
// Checksum 0x97b21d09, Offset: 0x2a1c
// Size: 0x3dd
function private function_745822b34a9f6969( poiname, var_f16a47bfb6ab9bbf, var_3806dc1b04245fc6, isdmz, var_acbef3fbe4e5b495 )
{
    player = self;
    
    if ( var_3806dc1b04245fc6 )
    {
        player thread function_4fc7a9b8d3774a4a( poiname );
        vehicle = player player_utility::getvehicle();
        
        if ( isdefined( vehicle ) && isdefined( player.team ) )
        {
            if ( !isdefined( level.var_c8221f7cb3644236 ) )
            {
                level.var_c8221f7cb3644236 = [];
            }
            
            if ( !isdefined( level.var_c8221f7cb3644236[ var_f16a47bfb6ab9bbf ] ) )
            {
                level.var_c8221f7cb3644236[ var_f16a47bfb6ab9bbf ] = [];
            }
            
            if ( !isdefined( level.var_c8221f7cb3644236[ var_f16a47bfb6ab9bbf ][ player.team ] ) )
            {
                level.var_c8221f7cb3644236[ var_f16a47bfb6ab9bbf ][ player.team ] = 1;
            }
        }
        
        if ( isdmz && !issubstr( poiname, "suburb" ) )
        {
            callback::callback( #"player_enter_poi", { #poi:poiname, #player:player } );
            players = teams::getteamdata( player.team, "players" );
            
            foreach ( ent in players )
            {
                ent points::doscoreevent( #"dmz_poi_visited" );
            }
        }
        else if ( !isdmz )
        {
            callback::callback( #"player_enter_poi", { #poi:poiname, #player:player } );
        }
        
        var_a72ac4dda42a6b4e = level.poi[ poiname ][ "calloutIndex" ] ?? -1;
        player setclientomnvar( "ui_callout_area_id", var_a72ac4dda42a6b4e );
        
        if ( utility::issharedfuncdefined( #"br_kura", #"hash_5c11c4d39474f0a8" ) )
        {
            player thread [[ utility::getsharedfunc( #"br_kura", #"hash_5c11c4d39474f0a8" ) ]]();
        }
    }
    
    if ( isdmz )
    {
        if ( !isdefined( player.recentpois ) )
        {
            player.recentpois = [];
        }
        
        if ( !isdefined( player.recentpois[ var_f16a47bfb6ab9bbf ] ) )
        {
            player.recentpois[ var_f16a47bfb6ab9bbf ] = { #exittime:-99999999 };
        }
        
        if ( isdefined( player.lastvalidpoi ) && player.lastvalidpoi != player.closestpoi )
        {
            timesinceexit = gettime() - player.recentpois[ var_f16a47bfb6ab9bbf ].exittime;
            
            if ( timesinceexit > level.var_6053799fc5292ab )
            {
                splash = "br_poi_entry_" + var_f16a47bfb6ab9bbf;
                
                if ( utility::issharedfuncdefined( #"hud", #"hash_5e35e7287b7efce8" ) )
                {
                    [[ utility::getsharedfunc( #"hud", #"hash_5e35e7287b7efce8" ) ]]( splash, [ player ] );
                }
            }
        }
        
        if ( var_3806dc1b04245fc6 )
        {
            if ( var_acbef3fbe4e5b495 )
            {
                difficulty = function_cfc4eae425b5dce1( poiname );
                player setclientomnvar( "ui_dmz_poi_difficulty_rating", difficulty );
                player function_de4d0505f77db56f( poiname );
            }
            
            callback::callback( #"player_enter_poi", { #poi:var_f16a47bfb6ab9bbf, #player:player } );
            waitframe();
        }
        
        if ( isdefined( player.recentpois[ var_f16a47bfb6ab9bbf ] ) && isalive( player ) )
        {
            player.recentpois[ var_f16a47bfb6ab9bbf ].exittime = gettime();
        }
    }
}

// Namespace poi
// Params 1, eflags: 0x4
// Checksum 0xd61a2137, Offset: 0x2e01
// Size: 0x5b
function private poidifficulty( params )
{
    poiname = params.poi;
    relativedifficulty = 1;
    
    if ( isdefined( level.poi[ poiname ][ "relativeDifficulty" ] ) )
    {
        relativedifficulty = level.poi[ poiname ][ "relativeDifficulty" ];
    }
    
    return relativedifficulty;
}

// Namespace poi
// Params 1, eflags: 0x4
// Checksum 0xd31212ce, Offset: 0x2e65
// Size: 0x29
function private function_cfc4eae425b5dce1( poiname )
{
    return callback::response( 4, #"hash_6a3e445c5100cb67", { #poi:poiname } );
}

// Namespace poi
// Params 1, eflags: 0x4
// Checksum 0x17389f, Offset: 0x2e97
// Size: 0x58
function private function_69e2a1577a147a94( player )
{
    if ( isdefined( player.closestpoi ) )
    {
        level.poi[ player.closestpoi ][ "players" ] = arrayremove( level.poi[ player.closestpoi ][ "players" ], player );
    }
}

// Namespace poi
// Params 1, eflags: 0x4
// Checksum 0x4c8260f0, Offset: 0x2ef7
// Size: 0xf8
function private function_de4d0505f77db56f( poiname = self.closestpoi )
{
    if ( level.var_df50cf8761945a01 )
    {
        return;
    }
    
    difficulty = function_cfc4eae425b5dce1( poiname );
    
    switch ( difficulty )
    {
        case 1:
            utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"ai_density_low", [ self ] );
            break;
        case 2:
            utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"ai_density_med", [ self ] );
            break;
        case 3:
        case 4:
            utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"ai_density_high", [ self ] );
            break;
    }
}

// Namespace poi
// Params 0, eflags: 0x4
// Checksum 0x352e273, Offset: 0x2ff7
// Size: 0x1f5
function private function_9924a6b0220e1cc8()
{
    level.poi_sites = [];
    sitecount = function_fd6ceee336caaf26( 1 );
    
    for ( siteidx = 0; siteidx < sitecount ; siteidx++ )
    {
        site = function_e1b7d58d23ea03ff( 1, siteidx );
        region = function_ba8494ae1c952908( 1, site.region );
        poiname = region.name + " site_" + siteidx;
        var_3f20bad11e32835b = removesubstr( tolower( region.name ), " " );
        
        if ( !isdefined( level.poi_names ) )
        {
            level.poi_names = [];
        }
        
        if ( !isdefined( level.poi_regions_names ) )
        {
            level.poi_regions_names = [];
        }
        
        assert( !arraycontains( level.poi_names, poiname ) );
        level.poi_names[ level.poi_names.size ] = poiname;
        level.poi_origins[ poiname ] = site.origin;
        poistruct = { #origin:site.origin, #name:poiname };
        level.poi_structs[ level.poi_structs.size ] = poistruct;
        affix = isdefined( level.mapname ) ? level.mapname + "_" : "";
        level.var_74e93adf71e0b98f[ poiname ] = affix + var_3f20bad11e32835b;
        level.poi_sites[ siteidx ] = poiname;
        level.poi_regions[ poiname ] = site.region;
        
        if ( !isdefined( level.poi_regions_names[ site.region ] ) )
        {
            level.poi_regions_names[ site.region ] = region.name;
        }
    }
}

// Namespace poi
// Params 0, eflags: 0x4
// Checksum 0x65c36ba6, Offset: 0x31f4
// Size: 0x192
function private function_91a057235d0bfc44()
{
    if ( !isdefined( level.poi_sites ) )
    {
        return;
    }
    
    if ( level.var_f7735c8a5a7ab2fe )
    {
        return;
    }
    
    foreach ( poiname in level.poi_names )
    {
        if ( !isdefined( level.poi[ poiname ] ) )
        {
            continue;
        }
        
        level.poi[ poiname ][ "otherPoiByDist" ] = [];
        curorigin = level.poi_origins[ poiname ];
        var_586abcafcd3c0ad3 = function_7f5167677855fb01( 1, curorigin );
        
        foreach ( site in var_586abcafcd3c0ad3 )
        {
            if ( isdefined( level.poi[ level.poi_sites[ site ] ] ) )
            {
                level.poi[ poiname ][ "otherPoiByDist" ][ level.poi[ poiname ][ "otherPoiByDist" ].size ] = level.poi_sites[ site ];
            }
        }
    }
}

// Namespace poi
// Params 0, eflags: 0x4
// Checksum 0x61a1152d, Offset: 0x338e
// Size: 0x18b
function private function_9e2a607447d3824()
{
    function_3fe3760adc2508e5( "subAreas" );
    gametype = game_utility::getgametype() + "_";
    compassregionsconfig = "mp/compass_regions/" + "compassregions_" + level.mapname + "_" + gametype + "_poi_sub_regions" + ".csv";
    function_d451ed5980378d2( compassregionsconfig, 2 );
    
    if ( function_989729b41cc7d6f7( 2 ) )
    {
        sitecount = function_fd6ceee336caaf26( 2 );
        
        for ( siteidx = 0; siteidx < sitecount ; siteidx++ )
        {
            subareasite = function_e1b7d58d23ea03ff( 2, siteidx );
            var_8ddd0e566a25b7f4 = function_2d6761e072b4e500( 1, subareasite.origin );
            
            if ( isdefined( var_8ddd0e566a25b7f4 ) )
            {
                subarearegion = function_ba8494ae1c952908( 2, subareasite.region );
                subarea = spawnstruct();
                subarea.site = siteidx;
                subarea.origin = subareasite.origin;
                subarea.subareaname = subarearegion.name + " site_" + siteidx;
                subarea.poiname = subarearegion.name;
                poiname = level.poi_sites[ var_8ddd0e566a25b7f4 ];
                function_af949b3e1b544ec8( poiname, "subAreas", subarea, subarea.subareaname );
            }
        }
    }
    
    function_b3444e9765baf954();
    function_2bce7784795de961();
}

// Namespace poi
// Params 0
// Checksum 0x9aee9d7d, Offset: 0x3521
// Size: 0xe5
function function_e70b36c865e888f1()
{
    while ( !isdefined( level.var_b40e8430c5d07a40 ) )
    {
        waitframe();
    }
    
    table = level.var_b40e8430c5d07a40;
    numrows = tablelookupgetnumrows( table );
    var_2c3a1922dc55e038 = undefined;
    
    for ( i = 0; i < numrows ; i++ )
    {
        poiname = tablelookupbyrow( table, i, 0 );
        
        if ( !arraycontains( level.poi_names, poiname ) )
        {
            continue;
        }
        
        if ( isdefined( level.poi[ poiname ][ "relativeDifficulty" ] ) && poiname == var_2c3a1922dc55e038 )
        {
            continue;
        }
        
        relativedifficulty = int( tablelookupbyrow( table, i, 10 ) );
        
        if ( relativedifficulty > 0 && relativedifficulty <= 3 )
        {
            level.poi[ poiname ][ "relativeDifficulty" ] = relativedifficulty;
            var_2c3a1922dc55e038 = poiname;
        }
    }
}

// Namespace poi
// Params 0
// Checksum 0xbb2ab87e, Offset: 0x360e
// Size: 0x185
function function_7bb68398828e82c2()
{
    while ( !isdefined( level.var_b40e8430c5d07a40 ) )
    {
        waitframe();
    }
    
    table = level.var_b40e8430c5d07a40;
    numrows = tablelookupgetnumrows( table );
    var_2c3a1922dc55e038 = undefined;
    
    for ( i = 0; i < numrows ; i++ )
    {
        poiname = tablelookupbyrow( table, i, 0 );
        
        if ( !arraycontains( level.poi_names, poiname ) )
        {
            continue;
        }
        
        if ( isdefined( level.poi[ poiname ][ "minExtraBuyStations" ] ) && poiname == var_2c3a1922dc55e038 )
        {
            continue;
        }
        
        tempnum = tablelookupbyrow( table, i, 11 );
        
        if ( tempnum == "" )
        {
            continue;
        }
        
        minextrabuystations = int( tempnum );
        level.poi[ poiname ][ "minExtraBuyStations" ] = minextrabuystations;
        var_2c3a1922dc55e038 = poiname;
    }
    
    var_2c3a1922dc55e038 = undefined;
    
    for ( i = 0; i < numrows ; i++ )
    {
        poiname = tablelookupbyrow( table, i, 0 );
        
        if ( !arraycontains( level.poi_names, poiname ) )
        {
            continue;
        }
        
        if ( isdefined( level.poi[ poiname ][ "maxExtraBuyStations" ] ) && poiname == var_2c3a1922dc55e038 )
        {
            continue;
        }
        
        tempnum = tablelookupbyrow( table, i, 12 );
        
        if ( tempnum == "" )
        {
            continue;
        }
        
        maxextrabuystations = int( tempnum );
        level.poi[ poiname ][ "maxExtraBuyStations" ] = maxextrabuystations;
        var_2c3a1922dc55e038 = poiname;
    }
}

// Namespace poi
// Params 0
// Checksum 0x2fd06774, Offset: 0x379b
// Size: 0x12f
function function_df1af501ed4eb423()
{
    if ( !isdefined( level.misc_regions ) )
    {
        level.misc_regions = [];
    }
    
    compassregionsconfig = "mp/compass_regions/" + "compassregions_" + level.mapname + "_misc_regions" + ".csv";
    function_d451ed5980378d2( compassregionsconfig, 4 );
    
    if ( function_989729b41cc7d6f7( 4 ) )
    {
        sitecount = function_fd6ceee336caaf26( 4 );
        
        for ( siteidx = 0; siteidx < sitecount ; siteidx++ )
        {
            var_68bb171102f635e4 = function_e1b7d58d23ea03ff( 4, siteidx );
            var_cf2d73e31a2fe9ac = function_2d6761e072b4e500( 4, var_68bb171102f635e4.origin );
            
            if ( isdefined( var_cf2d73e31a2fe9ac ) )
            {
                var_ea4b3d43dbc45d87 = function_ba8494ae1c952908( 4, var_68bb171102f635e4.region );
                miscarea = spawnstruct();
                miscarea.site = siteidx;
                miscarea.origin = var_68bb171102f635e4.origin;
                miscarea.name = var_ea4b3d43dbc45d87.name;
                level.misc_regions[ var_ea4b3d43dbc45d87.name ] = miscarea;
            }
        }
    }
}

// Namespace poi
// Params 1
// Checksum 0xc1e1c9d5, Offset: 0x38d2
// Size: 0xaf
function function_853a1dd91debb879( origin )
{
    if ( isdefined( level.misc_regions ) )
    {
        var_e3332c113422c0a8 = function_2d6761e072b4e500( 4, origin );
        
        foreach ( region in level.misc_regions )
        {
            if ( var_e3332c113422c0a8 == region.site )
            {
                return region;
            }
        }
    }
}

// Namespace poi
// Params 2
// Checksum 0x12ae804c, Offset: 0x398a
// Size: 0x224
function function_1a666d7097121932( var_b3c59931c38000ba, origin )
{
    if ( !isdefined( level.var_a9e15a4d8006eff8 ) )
    {
        level.var_a9e15a4d8006eff8 = utility::callsharedfunc( #"br_infils", #"hash_f3c68636c0e494a1" );
    }
    
    if ( !isdefined( level.var_a9e15a4d8006eff8 ) )
    {
        assert( isdefined( level.var_a9e15a4d8006eff8 ) );
        return;
    }
    
    if ( !isdefined( level.name_fx ) )
    {
        level.name_fx = [];
    }
    
    modelname = level.var_a9e15a4d8006eff8.var_19733a4972a03471;
    scriptablestate = var_b3c59931c38000ba;
    origin += level.var_a9e15a4d8006eff8.offset;
    angles = level.br_ac130.angles;
    angles += level.var_a9e15a4d8006eff8.anglesoffset;
    var_feed607033221c00 = spawn( "script_model", origin );
    var_feed607033221c00.angles = angles;
    waitframe();
    poiname = poi_findpoioriginisin( origin );
    ishotzone = poiname && level.poi[ poiname ][ "isHot" ];
    var_d2fc355b457c3db3 = utility::callsharedfunc( #"br_destruction_scenarios", #"hash_823c0f506a4fe9b9", var_b3c59931c38000ba );
    
    if ( ishotzone && level.var_a9e15a4d8006eff8.hotzonemodelname )
    {
        modelname = level.var_a9e15a4d8006eff8.hotzonemodelname;
    }
    else if ( var_d2fc355b457c3db3 && level.var_a9e15a4d8006eff8.var_de90d5a70718f121 )
    {
        modelname = level.var_a9e15a4d8006eff8.var_de90d5a70718f121;
    }
    
    var_feed607033221c00 setmodel( modelname );
    var_feed607033221c00 setscriptablepartstate( "name_fx", scriptablestate );
    var_feed607033221c00 forcenetfieldhighlod( 1 );
    level.name_fx[ level.name_fx.size ] = var_feed607033221c00;
    level thread utility::callsharedfunc( #"gametype", #"hash_3c53b4205d1bbcb9", var_feed607033221c00 );
}

// Namespace poi
// Params 0, eflags: 0x4
// Checksum 0x70cf8f1a, Offset: 0x3bb6
// Size: 0x159
function private poi_brHideNameFXFromPlayers()
{
    level endon( #"game_ended" );
    level endon( #"hash_1c918d0a4ce43118" );
    flags::gameflagwait( "br_ready_to_jump" );
    var_177c4be8b18d540f = throttle::throttle_initialize( "poi_brHideNameFXFromPlayers", 10, 0.25 );
    
    while ( level.name_fx.size > 0 && level.players.size > 0 )
    {
        foreach ( player in level.players )
        {
            throttle::throttle_wait_in_queue( var_177c4be8b18d540f, player );
            
            if ( player.var_40d4d44aa6104f06 )
            {
                continue;
            }
            
            if ( isalive( player ) && ( isdefined( player.vehicle ) || !player.brneverlanded ) )
            {
                for ( j = 0; j < level.name_fx.size ; j++ )
                {
                    level.name_fx[ j ] hidefromplayer( player );
                }
                
                player.var_40d4d44aa6104f06 = 1;
            }
        }
    }
}

// Namespace poi
// Params 0
// Checksum 0x2a1fef57, Offset: 0x3d17
// Size: 0xe9
function function_60168f9e93bde289()
{
    if ( level.name_fx.size == 0 )
    {
        return;
    }
    
    var_a9e15a4d8006eff8 = utility::callsharedfunc( #"br_infils", #"hash_f3c68636c0e494a1" );
    
    if ( !isdefined( var_a9e15a4d8006eff8 ) )
    {
        return;
    }
    
    level thread poi_brHideNameFXFromPlayers();
    
    while ( isdefined( level.br_ac130 ) )
    {
        wait 0.1;
    }
    
    wait var_a9e15a4d8006eff8.lifetime;
    level notify( #"hash_1c918d0a4ce43118" );
    
    foreach ( element in level.name_fx )
    {
        element delete();
    }
}

