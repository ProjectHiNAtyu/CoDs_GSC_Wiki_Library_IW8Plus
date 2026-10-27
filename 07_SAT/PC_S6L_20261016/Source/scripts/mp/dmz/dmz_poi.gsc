// scripts\mp\dmz\dmz_poi.gsc  (hash_294bdda953661ca4.gscc) (size: 35107 Bytes / 0x8923 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xeaf6e754 (3942049620)
// size ...... 35107 (0x8923)
// includes .. 7   (offset: 0x8487)
// strings ... 51  (offset: 0x84bf)
// dev strs .. 8   (offset: 0x88bb)
// exports ... 91  (offset: 0x619b)
// cseg ...... 0x37d + 0x5e1e (0x619b)
// imports ... 150 (offset: 0x6fd3)
// animtree1 . 0   (offset: 0x8923)
// animtree2 . 0   (offset: 0x8923)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\ai_reinforcements;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\dmz\star_system;
#using scripts\mp\flags;

#namespace dmz_poi;

// Namespace dmz_poi
// Params 0
// Checksum 0xdba16128, Offset: 0x39b
// Size: 0x353
function dmzpoi_init()
{
    utility::flag_init( "poi_initialized" );
    
    if ( getdvarint( @"scr_poi_system", 1 ) == 0 )
    {
        return;
    }
    
    function_d79c21b4d7f89a67();
    level.var_6053799fc5292ab = getdvarint( @"hash_ad89f1c2b195eda2", 90 ) * 1000;
    level.var_ca00a98f96729962 = getdvarint( @"hash_c0a94085bd5d4c61", 1 );
    level.areas = [];
    level.var_8851f2c94661cea1 = [];
    
    if ( !isdefined( level.area_names ) )
    {
        level.area_names = [];
    }
    
    function_b178e0c2aea77a36();
    function_4468f537ca70d2e();
    level.poi = [];
    level.var_e38f0af66eb58ff2 = [];
    
    if ( !isdefined( level.poi_names ) )
    {
        level.poi_names = [];
    }
    
    function_c31afa5a12002206();
    function_4395dac9d667841e();
    
    if ( level.var_f3eb0389ef8ac178 && isdefined( level.var_c66dede5fc9610c2 ) )
    {
        [[ level.var_c66dede5fc9610c2 ]]();
    }
    
    level.var_fe4133865228ae6c = getdvarint( @"hash_d92efe924cc2086d", 0 );
    areadefaultstate = 1;
    
    if ( level.var_fe4133865228ae6c )
    {
        areadefaultstate = 0;
    }
    
    foreach ( areaname in level.area_names )
    {
        dvarhash = hashcat( @"area_", areaname );
        
        if ( getdvarint( dvarhash, areadefaultstate ) == 0 )
        {
            level.var_8851f2c94661cea1[ level.var_8851f2c94661cea1.size ] = areaname;
        }
        
        function_162fe7d206185f80( areaname );
    }
    
    level.var_fc19dff9a7363347 = getdvarint( @"scr_poi_disable_all", 0 );
    poidefaultstate = 1;
    
    if ( level.var_fc19dff9a7363347 )
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
        
        function_b5987c44ff6c1e5f( poiname );
    }
    
    function_d3f5b02f17724858();
    function_d668ad6f3644a239();
    function_2c3eaca78b1b0944();
    function_49cf5b8ac86581fb();
    function_45a5b68630efe1a4();
    function_cb44b99431207e55();
    level thread function_5e31518dd9b5ee5f();
    level thread function_fa0bbbd89a928c48();
    disconnect_event_aggregator::registerondisconnecteventcallback( &function_69e2a1577a147a94 );
    
    while ( !isdefined( level.var_b40e8430c5d07a40 ) )
    {
        waitframe();
    }
    
    function_9990ef4b565fc06a();
    function_f97fac7cf82a782b();
    
    /#
        level thread function_271cfe9e46f18297();
    #/
    
    utility::registersharedfunc( #"hash_7160a636b947b0d", #"hash_f14c637523d65993", &dmzpoi_findpoioriginisin );
    utility::flag_set( "poi_initialized" );
}

// Namespace dmz_poi
// Params 2
// Checksum 0x5278540d, Offset: 0x6f6
// Size: 0x1b4
function function_473b30c6018b7b8f( areaname, var_358e1cedbc5d335f )
{
    utility::flag_wait( "poi_initialized" );
    
    if ( !dmzpoi_issystemactive() )
    {
        return;
    }
    
    function_162fe7d206185f80( areaname );
    level.area_names[ level.area_names.size ] = areaname;
    struct = { #var_f69986e46c50ba53:0, #agentdeaths:0 };
    function_17bbb7bf0dab18d0( areaname + "_orphan", "everybody" );
    level.aibudgets.areas[ areaname ] = [];
    level.aibudgets.areas[ areaname ][ "orphan" ] = struct;
    function_56d1f269587ffc64( areaname );
    level.areas[ areaname ] = [];
    var_428f19f04224c431 = { #origin:( 0, 0, 0 ), #skits:[], #spawnpackage_optional:[], #spawnpackage_required:[], #livingagents:[], #tuning:{ #var_2fdda594ff89a52d:var_358e1cedbc5d335f, #var_ee14ca6e8181bd86:0 }, #var_d4b3247c36826678:1, #subareaname:"orphan", #areaname:areaname };
    level.subareas[ level.subareas.size ] = var_428f19f04224c431;
    level.areas[ areaname ][ "subAreas" ] = [];
    level.areas[ areaname ][ "subAreas" ][ "orphan" ] = var_428f19f04224c431;
    level.areas[ areaname ][ "name" ] = areaname;
    return var_428f19f04224c431;
}

// Namespace dmz_poi
// Params 0
// Checksum 0x5f4b34cb, Offset: 0x8b3
// Size: 0x116
function function_d668ad6f3644a239()
{
    foreach ( poiname, poi in level.poi )
    {
        foreach ( areaname, area in level.areas )
        {
            if ( ispointinvolume( level.poi_origins[ poiname ], level.area_volumes[ areaname ] ) )
            {
                level.areas[ areaname ][ "pois" ][ poiname ] = poi;
            }
        }
    }
}

// Namespace dmz_poi
// Params 0
// Checksum 0x6b6ebeb9, Offset: 0x9d1
// Size: 0x9c
function function_2c3eaca78b1b0944()
{
    foreach ( subarea in level.subareas )
    {
        level.areas[ subarea.areaname ][ "subAreas" ][ subarea.subareaname ] = subarea;
    }
}

// Namespace dmz_poi
// Params 0
// Checksum 0x511370c6, Offset: 0xa75
// Size: 0x10e
function function_49cf5b8ac86581fb()
{
    foreach ( subarea in level.subareas )
    {
        poiname = dmzpoi_findpoioriginisin( subarea.volume.origin, 1 );
        
        if ( !isdefined( poiname ) )
        {
            continue;
        }
        
        subarea.poiname = poiname;
        
        if ( isdefined( level.poi[ poiname ] ) && !isdefined( level.poi[ poiname ][ "subAreas" ] ) )
        {
            level.poi[ poiname ][ "subAreas" ] = [];
        }
        
        level.poi[ poiname ][ "subAreas" ][ subarea.subareaname ] = subarea;
    }
}

// Namespace dmz_poi
// Params 0
// Checksum 0x8203b524, Offset: 0xb8b
// Size: 0xf2
function function_d79c21b4d7f89a67()
{
    utility::registersharedfunc( #"poi", #"poi_ispoiactive", &dmzpoi_ispoiactive );
    utility::registersharedfunc( #"poi", #"poi_issystemactive", &dmzpoi_issystemactive );
    utility::registersharedfunc( #"poi", #"hash_79b3b95992c86428", &dmzpoi_findpoioriginisin );
    utility::registersharedfunc( #"poi", #"area_findoriginisin", &area_findoriginisin );
    utility::registersharedfunc( #"poi", #"hash_fc858bd1017130aa", &dmzpoi_getorigin );
    utility::registersharedfunc( #"poi", #"subarea_getorigin", &function_d5e69d02d71ce881 );
    utility::registersharedfunc( #"poi", #"area_getorigin", &function_8c9b089e4dd62123 );
    utility::registersharedfunc( #"poi", #"hash_aef520fb6136be05", &function_4bc0b1ddf992be97 );
}

// Namespace dmz_poi
// Params 0
// Checksum 0xb0f8b07c, Offset: 0xc85
// Size: 0x1e2
function function_ca261f43aae5a517()
{
    utility::registersharedfunc( #"poi", #"hash_8dbb0d45f903ae1c", &subarea_findfromorigin );
    utility::registersharedfunc( #"poi", #"hash_e8d82f43da156688", &subarea_getsubareanationality );
    utility::registersharedfunc( #"poi", #"subarea_addfeaturearray", &subarea_addfeaturearray );
    utility::registersharedfunc( #"poi", #"subarea_registerfeatureelement", &subarea_registerfeatureelement );
    utility::registersharedfunc( #"poi", #"subarea_getfeaturearray", &subarea_getfeaturearray );
    utility::registersharedfunc( #"poi", #"hash_37331756c0dab8d8", &subarea_spawnagentpackages );
    utility::registersharedfunc( #"poi", #"hash_f6d41e05b52f7915", &subarea_checkforreinforcementshutdown );
    utility::registersharedfunc( #"poi", #"subarea_checkforreinforcementshutdownclear", &subarea_checkforreinforcementshutdownclear );
    utility::registersharedfunc( #"poi", #"subarea_findandassignfordormancyid", &subarea_findandassignfordormancyid );
    utility::registersharedfunc( #"poi", #"hash_ff67e64a1cc4f956", &subarea_findandassignforagent );
    utility::registersharedfunc( #"poi", #"subarea_removeagentfrom", &subarea_removeagentfrom );
    utility::registersharedfunc( #"poi", #"hash_7a0fcb8e94df1242", &subarea_orderagentarraysubareafirst );
    utility::registersharedfunc( #"poi", #"hash_e883651dbecf55b4", &tieroverride_checkorigin );
    utility::registersharedfunc( #"poi", #"hash_7f732c09fb6c538d", &subarea_getsubareadifficultyfromorigin );
    utility::registersharedfunc( #"poi", #"area_isareaactive", &area_isareaactive );
    utility::registersharedfunc( #"poi", #"hash_cd2758a499bb6be4", &function_de3865d18d2dc8e8 );
}

// Namespace dmz_poi
// Params 0, eflags: 0x4
// Checksum 0xbf8610d7, Offset: 0xe6f
// Size: 0x1c9
function private function_c31afa5a12002206()
{
    level.poi_volumes = [];
    poivolumes = [];
    
    foreach ( volume in getnoentvolumearray( "noent_volume_info", #classname ) )
    {
        if ( volume.variantname == "noent_poi_volume" )
        {
            poivolumes[ poivolumes.size ] = volume;
        }
    }
    
    if ( poivolumes.size > 0 )
    {
        foreach ( volume in poivolumes )
        {
            poiname = tolower( volume.targetname );
            
            if ( !isdefined( level.poi_names ) )
            {
                level.poi_names = [];
            }
            
            volume.script_poi = poiname;
            
            if ( !arraycontains( level.poi_names, poiname ) )
            {
                level.poi_names[ level.poi_names.size ] = poiname;
                level.poi_volumes[ poiname ] = volume;
                
                /#
                    if ( getdvarint( @"hash_62cf1f12e3c0b4dd", 0 ) == 1 )
                    {
                        print3d( volume.origin, poiname, ( 1, 0, 0 ), 1, 12, 10000, 1 );
                    }
                #/
            }
        }
    }
}

// Namespace dmz_poi
// Params 0, eflags: 0x4
// Checksum 0xdcc1cb0f, Offset: 0x1040
// Size: 0x187
function private function_b178e0c2aea77a36()
{
    level.area_volumes = [];
    areavolumes = [];
    
    foreach ( volume in getnoentvolumearray( "noent_volume_info", #classname ) )
    {
        if ( volume.variantname == "noent_area_volume" )
        {
            areavolumes[ areavolumes.size ] = volume;
        }
    }
    
    if ( areavolumes.size > 0 )
    {
        foreach ( volume in areavolumes )
        {
            areaname = tolower( volume.targetname );
            
            if ( !isdefined( level.area_names ) )
            {
                level.area_names = [];
            }
            
            volume.areaname = areaname;
            
            if ( !arraycontains( level.area_names, areaname ) )
            {
                level.area_names[ level.area_names.size ] = areaname;
                level.area_volumes[ areaname ] = volume;
            }
        }
    }
}

// Namespace dmz_poi
// Params 0, eflags: 0x4
// Checksum 0xa536302, Offset: 0x11cf
// Size: 0xa3
function private function_4395dac9d667841e()
{
    level.poi_origins = [];
    
    if ( level.poi_volumes.size > 0 )
    {
        foreach ( poiname, volume in level.poi_volumes )
        {
            level.poi_origins[ poiname ] = volume.origin;
        }
    }
}

// Namespace dmz_poi
// Params 0, eflags: 0x4
// Checksum 0x3a05edf3, Offset: 0x127a
// Size: 0xa3
function private function_4468f537ca70d2e()
{
    level.area_origins = [];
    
    if ( level.area_volumes.size > 0 )
    {
        foreach ( areaname, volume in level.area_volumes )
        {
            level.area_origins[ areaname ] = volume.origin;
        }
    }
}

// Namespace dmz_poi
// Params 0
// Checksum 0xa328053c, Offset: 0x1325
// Size: 0xf8
function function_5960aa6eac9e8602()
{
    if ( !isdefined( level.aibudgetvolumes ) )
    {
        return;
    }
    
    foreach ( volume in level.aibudgetvolumes )
    {
        areaname = volume.script_noteworthy;
        subareaname = volume.targetname;
        
        if ( isdefined( areaname ) && isdefined( subareaname ) )
        {
            struct = spawnstruct();
            struct.trigger = volume;
            struct.subareaname = subareaname;
            level.area[ areaname ][ "subAreas" ][ subareaname ] = struct;
        }
    }
}

// Namespace dmz_poi
// Params 1
// Checksum 0x907ee1ea, Offset: 0x1425
// Size: 0x42
function function_6e21f853056cafe2( name )
{
    potentialindex = tablelookup( "mp/map_callouts/" + level.mapname + "_callouts.csv", 1, name, 0 );
    
    if ( potentialindex )
    {
        return int( potentialindex );
    }
}

// Namespace dmz_poi
// Params 1
// Checksum 0x4fe950db, Offset: 0x1470
// Size: 0xff
function function_8886edbe675b8c7a( name )
{
    tablename = "mp/compass_regions/" + "compassregions_" + level.mapname + "_poi" + ".csv";
    var_c97f4fb1a7665df5 = tablelookup( tablename, 0, "regions", 1 );
    mapprefix = level.var_88fe1dcea16ce1c8 ?? "MP_REX_TUMEN";
    var_831227438065fb8d = tablelookuprownum( tablename, 0, mapprefix + "/CALLOUT_" + name );
    
    if ( !isdefined( var_831227438065fb8d ) || var_831227438065fb8d < 0 )
    {
        if ( level.var_728051eb2399405 )
        {
            assertmsg( "<dev string:x24>" + name );
        }
        
        return 0;
    }
    
    calloutIndex = int( var_831227438065fb8d ) - int( var_c97f4fb1a7665df5 ) - 2;
    
    if ( calloutIndex < 0 )
    {
        if ( level.var_728051eb2399405 )
        {
            assertmsg( "<dev string:x39>" + var_831227438065fb8d + "<dev string:x62>" + var_c97f4fb1a7665df5 );
        }
        
        return 0;
    }
    
    return calloutIndex;
}

// Namespace dmz_poi
// Params 1
// Checksum 0xfa86a8b, Offset: 0x1578
// Size: 0x17
function function_bc9415740e0eeb69( poiindexes )
{
    level.poiindexes = poiindexes;
}

// Namespace dmz_poi
// Params 1
// Checksum 0xf67c7f8d, Offset: 0x1597
// Size: 0x3d
function function_de3865d18d2dc8e8( poiname )
{
    var_a72ac4dda42a6b4e = 0;
    
    if ( isdefined( poiname ) )
    {
        potentialindex = function_8886edbe675b8c7a( poiname );
        
        if ( isdefined( potentialindex ) )
        {
            var_a72ac4dda42a6b4e = potentialindex;
        }
    }
    
    return var_a72ac4dda42a6b4e;
}

// Namespace dmz_poi
// Params 0, eflags: 0x4
// Checksum 0x3e098a3f, Offset: 0x15dd
// Size: 0x18a
function private function_cb44b99431207e55()
{
    if ( !isdefined( level.poi_volumes ) )
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

// Namespace dmz_poi
// Params 1
// Checksum 0xb819bd6d, Offset: 0x176f
// Size: 0xb6
function function_b5987c44ff6c1e5f( poiname )
{
    if ( isdefined( level.poi[ poiname ] ) )
    {
        return level.poi[ poiname ];
    }
    
    if ( !dmzpoi_ispoiactive( poiname ) )
    {
        return;
    }
    
    level.poi[ poiname ] = [];
    level.poi[ poiname ][ "name" ] = poiname;
    level.poi[ poiname ][ "calloutIndex" ] = function_8886edbe675b8c7a( poiname );
    level.poi[ poiname ][ "priority" ] = function_4ad4ea474657727f( poiname );
    level.poi[ poiname ][ "country" ] = function_198de25d2c6e3899( poiname );
    return level.poi[ poiname ];
}

// Namespace dmz_poi
// Params 1
// Checksum 0x4920eb38, Offset: 0x182e
// Size: 0xc3
function function_162fe7d206185f80( areaname )
{
    if ( isdefined( level.areas[ areaname ] ) )
    {
        return level.areas[ areaname ];
    }
    
    if ( !area_isareaactive( areaname ) )
    {
        return;
    }
    
    level.areas[ areaname ] = [];
    level.areas[ areaname ][ "name" ] = areaname;
    level.areas[ areaname ][ "pois" ] = [];
    level.areas[ areaname ][ "subAreas" ] = [];
    level.areas[ areaname ][ "country" ] = function_198de25d2c6e3899( areaname );
    level.areas[ areaname ][ "calloutIndex" ] = function_8886edbe675b8c7a( areaname );
    return level.areas[ areaname ];
}

// Namespace dmz_poi
// Params 1
// Checksum 0x647cc09f, Offset: 0x18fa
// Size: 0x2c
function dmzpoi_getorigin( poiname )
{
    if ( isdefined( poiname ) && isdefined( level.poi_origins ) )
    {
        return level.poi_origins[ poiname ];
    }
}

// Namespace dmz_poi
// Params 1
// Checksum 0x8a0a7ebf, Offset: 0x192f
// Size: 0x47
function function_d5e69d02d71ce881( subarea )
{
    origin = undefined;
    
    if ( isdefined( subarea ) )
    {
        if ( isdefined( subarea.volume ) )
        {
            origin = subarea.volume.origin;
        }
    }
    
    return origin;
}

// Namespace dmz_poi
// Params 1
// Checksum 0x96ff237e, Offset: 0x197f
// Size: 0x39
function function_8c9b089e4dd62123( areaname )
{
    origin = undefined;
    
    if ( isdefined( areaname ) )
    {
        origin = level.area_volumes[ areaname ].origin;
    }
    
    return origin;
}

// Namespace dmz_poi
// Params 1
// Checksum 0x465798b8, Offset: 0x19c1
// Size: 0x48, Type: bool
function function_555354f7d26705ef( origin )
{
    poi = dmzpoi_findpoioriginisin( origin, 1 );
    return isdefined( poi ) && ( !isdefined( level.var_e38f0af66eb58ff2 ) || !arraycontains( level.var_e38f0af66eb58ff2, poi ) );
}

// Namespace dmz_poi
// Params 3
// Checksum 0x8fd37bd6, Offset: 0x1a12
// Size: 0x5c, Type: bool
function function_a4891870d8e24df2( origin, poiname = dmzpoi_findpoioriginisin( origin, 1 ), areaname = area_findoriginisin( origin, 1 ) )
{
    return area_isareaactive( areaname ) && ( !isdefined( poiname ) || dmzpoi_ispoiactive( poiname ) );
}

// Namespace dmz_poi
// Params 2
// Checksum 0xc378460e, Offset: 0x1a77
// Size: 0x37
function dmzpoi_findpoioriginisin( origin, var_c6af19746fa74b39 )
{
    if ( !dmzpoi_issystemactive() )
    {
        return;
    }
    
    poiname = function_e45d6764cba0c05e( origin, var_c6af19746fa74b39 );
    return poiname;
}

// Namespace dmz_poi
// Params 3
// Checksum 0xaf04bceb, Offset: 0x1ab7
// Size: 0x109
function area_findoriginisin( origin, var_203430924a533062, var_e44426dd870f3753 = 0 )
{
    if ( !dmzpoi_issystemactive() )
    {
        return;
    }
    
    if ( !isdefined( origin ) )
    {
        return;
    }
    
    if ( !isdefined( var_203430924a533062 ) )
    {
        var_203430924a533062 = 0;
    }
    
    areanames = var_203430924a533062 ? level.area_names : arrayremove( level.area_names, level.var_8851f2c94661cea1 );
    
    foreach ( areaname in areanames )
    {
        if ( isdefined( level.area_volumes[ areaname ] ) )
        {
            if ( function_74a57110bedd6644( origin, areaname ) )
            {
                return areaname;
            }
        }
    }
    
    if ( var_e44426dd870f3753 )
    {
        return function_53a3527a29352408( origin, var_203430924a533062 );
    }
}

// Namespace dmz_poi
// Params 2
// Checksum 0x4065a8ce, Offset: 0x1bc8
// Size: 0xc4
function function_dc4bba8faccdb520( areaname = area_findoriginisin( origin ), origin )
{
    foreach ( subarea in level.areas[ areaname ][ "subAreas" ] )
    {
        if ( isdefined( subarea.volume ) && ispointinvolume( origin, subarea.volume ) )
        {
            return subarea;
        }
    }
}

// Namespace dmz_poi
// Params 2, eflags: 0x4
// Checksum 0xf55004b2, Offset: 0x1c95
// Size: 0xef
function private function_e45d6764cba0c05e( origin, var_c6af19746fa74b39 )
{
    if ( !dmzpoi_issystemactive() )
    {
        return;
    }
    
    if ( !isdefined( var_c6af19746fa74b39 ) )
    {
        var_c6af19746fa74b39 = 0;
    }
    
    pois = var_c6af19746fa74b39 ? level.poi_names : getarraykeys( level.poi );
    
    foreach ( poiname in pois )
    {
        if ( isdefined( level.poi_volumes[ poiname ] ) )
        {
            if ( function_f95f10dafa92f26b( origin, poiname ) )
            {
                if ( level.poi[ poiname ][ "priority" ] == 0 )
                {
                    return poiname;
                }
            }
        }
    }
}

// Namespace dmz_poi
// Params 2, eflags: 0x4
// Checksum 0x58d29876, Offset: 0x1d8d
// Size: 0xf9
function private function_cf00cef14eac9fcd( origin, var_c6af19746fa74b39 )
{
    [ var_acecc217377ee7c6, var_88e79ea6c7c3fa25 ] = function_b1034fac5c679c19( origin, var_c6af19746fa74b39 );
    var_763dc6bd0b1cbbad = undefined;
    
    foreach ( poiname in var_88e79ea6c7c3fa25 )
    {
        if ( !isdefined( var_763dc6bd0b1cbbad ) || level.poi[ poiname ][ "priority" ] > level.poi[ var_763dc6bd0b1cbbad ][ "priority" ] )
        {
            var_763dc6bd0b1cbbad = poiname;
        }
    }
    
    return [ var_acecc217377ee7c6, var_763dc6bd0b1cbbad ];
}

// Namespace dmz_poi
// Params 2, eflags: 0x4
// Checksum 0x4bee3d87, Offset: 0x1e8f
// Size: 0xe9
function private function_7c74ea4d6f708720( origin, var_c6af19746fa74b39 )
{
    if ( !dmzpoi_issystemactive() )
    {
        return;
    }
    
    if ( !isdefined( var_c6af19746fa74b39 ) )
    {
        var_c6af19746fa74b39 = 0;
    }
    
    pois = var_c6af19746fa74b39 ? level.poi_names : getarraykeys( level.poi );
    var_88e79ea6c7c3fa25 = [];
    
    foreach ( poiname in pois )
    {
        if ( isdefined( level.poi_volumes[ poiname ] ) )
        {
            if ( function_f95f10dafa92f26b( origin, poiname ) )
            {
                var_88e79ea6c7c3fa25[ var_88e79ea6c7c3fa25.size ] = poiname;
            }
        }
    }
    
    return var_88e79ea6c7c3fa25;
}

// Namespace dmz_poi
// Params 2, eflags: 0x4
// Checksum 0xf60d4c9c, Offset: 0x1f81
// Size: 0x11a
function private function_b1034fac5c679c19( origin, var_c6af19746fa74b39 )
{
    if ( !dmzpoi_issystemactive() )
    {
        return;
    }
    
    if ( !isdefined( var_c6af19746fa74b39 ) )
    {
        var_c6af19746fa74b39 = 0;
    }
    
    pois = var_c6af19746fa74b39 ? level.poi_names : getarraykeys( level.poi );
    var_88e79ea6c7c3fa25 = [];
    var_acecc217377ee7c6 = undefined;
    
    foreach ( poiname in pois )
    {
        if ( isdefined( level.poi_volumes[ poiname ] ) )
        {
            if ( function_f95f10dafa92f26b( origin, poiname ) )
            {
                var_88e79ea6c7c3fa25[ var_88e79ea6c7c3fa25.size ] = poiname;
                
                if ( level.poi[ poiname ][ "priority" ] == 0 )
                {
                    var_acecc217377ee7c6 = poiname;
                }
            }
        }
    }
    
    return [ var_acecc217377ee7c6, var_88e79ea6c7c3fa25 ];
}

// Namespace dmz_poi
// Params 2, eflags: 0x4
// Checksum 0x20879350, Offset: 0x20a4
// Size: 0xd8
function private function_9c2e8f4e5bf5bac1( origin, var_203430924a533062 )
{
    if ( !dmzpoi_issystemactive() )
    {
        return;
    }
    
    if ( !isdefined( var_203430924a533062 ) )
    {
        var_203430924a533062 = 0;
    }
    
    areas = var_203430924a533062 ? level.area_names : getarraykeys( level.areas );
    
    foreach ( areaname in areas )
    {
        if ( isdefined( level.area_volumes[ areaname ] ) )
        {
            if ( function_74a57110bedd6644( origin, areaname ) )
            {
                return areaname;
            }
        }
    }
}

// Namespace dmz_poi
// Params 2, eflags: 0x4
// Checksum 0x46a3c733, Offset: 0x2184
// Size: 0x50
function private function_f95f10dafa92f26b( origin, poiname )
{
    if ( dmzpoi_issystemactive() )
    {
        var_f48b1422540291b7 = isdefined( level.poi_volumes[ poiname ] ) && ispointinvolume( origin, level.poi_volumes[ poiname ] );
        return var_f48b1422540291b7;
    }
}

// Namespace dmz_poi
// Params 2
// Checksum 0x2f58387f, Offset: 0x21dd
// Size: 0x50
function function_74a57110bedd6644( origin, areaname )
{
    if ( dmzpoi_issystemactive() )
    {
        var_65037aeeca83b258 = isdefined( level.area_volumes[ areaname ] ) && ispointinvolume( origin, level.area_volumes[ areaname ] );
        return var_65037aeeca83b258;
    }
}

// Namespace dmz_poi
// Params 2
// Checksum 0xd80588af, Offset: 0x2236
// Size: 0x13a
function function_4bc0b1ddf992be97( origin, var_c6af19746fa74b39 )
{
    if ( !isdefined( origin ) )
    {
        return;
    }
    
    if ( dmzpoi_issystemactive() )
    {
        var_712f3cd86a829de8 = undefined;
        var_b890a144673634d3 = undefined;
        
        if ( !isdefined( var_c6af19746fa74b39 ) )
        {
            var_c6af19746fa74b39 = 0;
        }
        
        pois = var_c6af19746fa74b39 ? level.poi_names : getarraykeys( level.poi );
        
        foreach ( poiname in pois )
        {
            if ( !isdefined( level.poi_origins[ poiname ] ) )
            {
                continue;
            }
            
            var_314cd8b2e7efc4c6 = function_4ad4ea474657727f( poiname );
            
            if ( var_314cd8b2e7efc4c6 != 0 )
            {
                continue;
            }
            
            dist = distance2dsquared( level.poi_origins[ poiname ], origin );
            
            if ( !isdefined( var_b890a144673634d3 ) || dist < var_b890a144673634d3 )
            {
                var_712f3cd86a829de8 = poiname;
                var_b890a144673634d3 = dist;
            }
        }
        
        return var_712f3cd86a829de8;
    }
}

// Namespace dmz_poi
// Params 4
// Checksum 0x4a57d4aa, Offset: 0x2378
// Size: 0x179
function function_630cf758cc471d31( origin, var_c6af19746fa74b39, includesuburbs, var_5041555eb50316c3 )
{
    if ( !isdefined( origin ) )
    {
        return;
    }
    
    if ( dmzpoi_issystemactive() )
    {
        var_712f3cd86a829de8 = undefined;
        var_b890a144673634d3 = undefined;
        
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
            
            if ( !isdefined( level.poi_origins[ poiname ] ) )
            {
                continue;
            }
            
            if ( var_5041555eb50316c3 && !isdefined( level.poi[ poiname ][ "calloutIndex" ] ) )
            {
                continue;
            }
            
            dist = distance2dsquared( level.poi_origins[ poiname ], origin );
            
            if ( !isdefined( var_b890a144673634d3 ) || dist < var_b890a144673634d3 )
            {
                var_712f3cd86a829de8 = poiname;
                var_b890a144673634d3 = dist;
            }
        }
        
        return var_712f3cd86a829de8;
    }
}

// Namespace dmz_poi
// Params 2
// Checksum 0xd93afb0f, Offset: 0x24f9
// Size: 0x11e
function function_53a3527a29352408( origin, var_203430924a533062 )
{
    if ( !isdefined( origin ) )
    {
        return;
    }
    
    if ( dmzpoi_issystemactive() )
    {
        var_109dac3d8865a4c7 = undefined;
        var_42a207c6e42def8c = undefined;
        
        if ( !isdefined( var_203430924a533062 ) )
        {
            var_203430924a533062 = 0;
        }
        
        areas = var_203430924a533062 ? level.area_names : getarraykeys( level.areas );
        
        foreach ( areaname in areas )
        {
            if ( !isdefined( level.area_origins[ areaname ] ) )
            {
                continue;
            }
            
            dist = distancesquared( level.area_origins[ areaname ], origin );
            
            if ( !isdefined( var_42a207c6e42def8c ) || dist < var_42a207c6e42def8c )
            {
                var_109dac3d8865a4c7 = areaname;
                var_42a207c6e42def8c = dist;
            }
        }
        
        return var_109dac3d8865a4c7;
    }
}

// Namespace dmz_poi
// Params 3
// Checksum 0x62735c30, Offset: 0x261f
// Size: 0x20f
function function_83cceb65526c85bb( origin, var_203430924a533062 = 0, var_18e34abea5e5c61e )
{
    if ( !isdefined( origin ) )
    {
        return;
    }
    
    if ( !dmzpoi_issystemactive() )
    {
        return;
    }
    
    subareas = undefined;
    
    if ( var_203430924a533062 )
    {
        subareas = [];
        
        foreach ( subarea in level.subareas )
        {
            if ( var_18e34abea5e5c61e ? [[ var_18e34abea5e5c61e ]]( subarea ) : 1 )
            {
                subareas[ subareas.size ] = subarea;
            }
        }
    }
    else
    {
        subareas = [];
        
        foreach ( areaname, area in level.areas )
        {
            if ( !isdefined( level.area_origins[ areaname ] ) )
            {
                continue;
            }
            
            if ( area[ "subAreas" ] && area[ "subAreas" ].size > 0 )
            {
                foreach ( subarea in area[ "subAreas" ] )
                {
                    if ( var_18e34abea5e5c61e ? [[ var_18e34abea5e5c61e ]]( subarea ) : 1 )
                    {
                        subareas[ subareas.size ] = subarea;
                    }
                }
            }
        }
    }
    
    if ( subareas.size > 0 )
    {
        var_8f6e7deef02b8afc = sortbydistance( subareas, origin );
        return var_8f6e7deef02b8afc[ 0 ];
    }
}

// Namespace dmz_poi
// Params 5
// Checksum 0x21d65514, Offset: 0x2836
// Size: 0x14c
function function_4967c99211aed9fb( poiname, subareaname, validfunc, var_a4b32cb95d9dab56, maxagents )
{
    activeagents = [];
    
    foreach ( subarea in level.subareas )
    {
        foreach ( agent in subarea.livingagents )
        {
            if ( activeagents.size >= maxagents )
            {
                return activeagents;
            }
            
            if ( isagent( agent ) )
            {
                if ( isdefined( validfunc ) && ![[ validfunc ]]( agent ) )
                {
                    continue;
                }
                
                activeagents[ activeagents.size ] = agent;
            }
        }
    }
    
    return activeagents;
}

// Namespace dmz_poi
// Params 4
// Checksum 0x9d685d80, Offset: 0x298b
// Size: 0x16e
function function_83473e6b26c0ffaa( poiname, excludelist = [], validfunc, var_a4b32cb95d9dab56 )
{
    activeagents = [];
    
    foreach ( subarea in level.poi[ poiname ][ "subAreas" ] )
    {
        if ( arraycontains( excludelist, subarea.subareaname ) )
        {
            continue;
        }
        
        foreach ( agent in subarea.livingagents )
        {
            if ( isagent( agent ) )
            {
                if ( isdefined( validfunc ) && ![[ validfunc ]]( agent ) )
                {
                    continue;
                }
                
                activeagents[ activeagents.size ] = agent;
                continue;
            }
            
            if ( isdefined( var_a4b32cb95d9dab56 ) )
            {
                [[ var_a4b32cb95d9dab56 ]]( agent );
            }
        }
    }
    
    return activeagents;
}

// Namespace dmz_poi
// Params 3
// Checksum 0xfa319621, Offset: 0x2b02
// Size: 0x77
function function_c8bf5f520c1f3949( agent, poiname, origin )
{
    if ( !isdefined( poiname ) )
    {
        poiname = undefined;
        var_16ba410437a14cd3 = agent.origin;
        
        if ( isdefined( origin ) )
        {
            var_16ba410437a14cd3 = origin;
        }
        
        poiname = dmzpoi_findpoioriginisin( var_16ba410437a14cd3 );
    }
    
    agent.poiname = poiname;
    
    if ( isdefined( poiname ) )
    {
        agent.poiname = poiname;
    }
    
    return poiname;
}

// Namespace dmz_poi
// Params 2
// Checksum 0x6b978dbc, Offset: 0x2b82
// Size: 0xbc
function function_eefd028ceb893202( array, poiname )
{
    temparray = [];
    
    foreach ( item in array )
    {
        poi_definition = item.script_poi ?? item.poi;
        
        if ( poi_definition == poiname )
        {
            temparray[ temparray.size ] = item;
        }
    }
    
    return temparray;
}

// Namespace dmz_poi
// Params 0
// Checksum 0x82521f94, Offset: 0x2c47
// Size: 0x19, Type: bool
function dmzpoi_issystemactive()
{
    return isdefined( level.poi ) && isdefined( level.areas );
}

// Namespace dmz_poi
// Params 0
// Checksum 0x15bcf799, Offset: 0x2c69
// Size: 0xd
function function_420da976a63bd0f1()
{
    return utility::flag( "poi_initialized" );
}

// Namespace dmz_poi
// Params 1
// Checksum 0x5f5ec305, Offset: 0x2c7f
// Size: 0x17
function function_1810c272ad5ea1e9( array )
{
    level.poi_names = array;
}

// Namespace dmz_poi
// Params 1
// Checksum 0xb45e4a7d, Offset: 0x2c9e
// Size: 0x40, Type: bool
function dmzpoi_ispoiactive( poiname )
{
    return isdefined( poiname ) && dmzpoi_issystemactive() && arraycontains( level.poi_names, poiname ) && !arraycontains( level.var_e38f0af66eb58ff2, poiname );
}

// Namespace dmz_poi
// Params 1
// Checksum 0xd5d3135a, Offset: 0x2ce7
// Size: 0x40, Type: bool
function area_isareaactive( areaname )
{
    return isdefined( areaname ) && dmzpoi_issystemactive() && arraycontains( level.area_names, areaname ) && !arraycontains( level.var_8851f2c94661cea1, areaname );
}

// Namespace dmz_poi
// Params 0
// Checksum 0xe5a3ba3c, Offset: 0x2d30
// Size: 0x21, Type: bool
function function_f4db430d7eba140()
{
    return dmzpoi_issystemactive() && level.var_e38f0af66eb58ff2.size < level.poi_names.size;
}

// Namespace dmz_poi
// Params 1
// Checksum 0x37595c06, Offset: 0x2d5a
// Size: 0x17
function function_f3a8a94794b3ef93( poiname )
{
    return issubstr( poiname, "suburb" );
}

// Namespace dmz_poi
// Params 0, eflags: 0x4
// Checksum 0xbaf9be7e, Offset: 0x2d7a
// Size: 0x622
function private function_fa0bbbd89a928c48()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    
    while ( !isdefined( level.players ) || level.poi.size == 0 )
    {
        waitframe();
    }
    
    wait 1;
    
    foreach ( poiname, poi in level.poi )
    {
        if ( !isdefined( level.poi[ poiname ][ "players" ] ) )
        {
            level.poi[ poiname ][ "players" ] = [];
        }
    }
    
    foreach ( player in level.players )
    {
        poiname = dmzpoi_findpoioriginisin( player.origin );
        
        if ( isdefined( poiname ) )
        {
            function_4f261ea09b5a0d1c( player, poiname );
            
            if ( getdvarint( @"hash_57b012f2c429bcb9", 1 ) != 0 )
            {
                difficulty = function_1dd6dbf27451788( poiname );
                player setclientomnvar( "ui_dmz_poi_difficulty_rating", difficulty );
            }
        }
    }
    
    waitframe();
    
    while ( true )
    {
        if ( !level.players || level.players.size == 0 )
        {
            wait 0.1;
        }
        
        foreach ( player in level.players )
        {
            wait 0.1;
            
            if ( !player || level.players.size == 0 )
            {
                continue;
            }
            
            [ poiname, var_6d451102c6aefbf6 ] = function_cf00cef14eac9fcd( player.origin );
            
            if ( !isdefined( var_6d451102c6aefbf6 ) )
            {
                if ( isdefined( player.var_6d451102c6aefbf6 ) )
                {
                    if ( isdefined( player.var_764fa622c95214e4 ) )
                    {
                        player.recentpois[ player.var_764fa622c95214e4 ].exittime = gettime();
                        level.poi[ player.var_764fa622c95214e4 ][ "players" ] = arrayremove( level.poi[ player.var_764fa622c95214e4 ][ "players" ], player );
                    }
                    
                    player.var_6d451102c6aefbf6 = undefined;
                    player.var_764fa622c95214e4 = undefined;
                    player setclientomnvar( "ui_dmz_poi_difficulty_rating", 0 );
                    function_4f261ea09b5a0d1c( player, undefined, player.var_b455d67c77a883b0 );
                }
                
                continue;
            }
            else if ( player.var_6d451102c6aefbf6 != var_6d451102c6aefbf6 )
            {
                player.var_6d451102c6aefbf6 = var_6d451102c6aefbf6;
                function_4f261ea09b5a0d1c( player, var_6d451102c6aefbf6 );
                callback::callback( #"on_player_enters_location", { #type:"poi", #locationname:var_6d451102c6aefbf6, #player:player } );
            }
            
            var_c5c08bf14a13636c = player.var_764fa622c95214e4;
            
            if ( !isdefined( poiname ) )
            {
                if ( isdefined( player.var_764fa622c95214e4 ) )
                {
                    level.poi[ var_c5c08bf14a13636c ][ "players" ] = arrayremove( level.poi[ var_c5c08bf14a13636c ][ "players" ], player );
                    player.var_764fa622c95214e4 = undefined;
                    
                    if ( isdefined( var_c5c08bf14a13636c ) )
                    {
                        player.recentpois[ var_c5c08bf14a13636c ].exittime = gettime();
                    }
                }
                
                continue;
            }
            
            if ( var_c5c08bf14a13636c == poiname )
            {
                continue;
            }
            
            if ( getdvarint( @"hash_57b012f2c429bcb9", 1 ) != 0 )
            {
                difficulty = function_1dd6dbf27451788( poiname );
                player setclientomnvar( "ui_dmz_poi_difficulty_rating", difficulty );
            }
            
            level.poi[ poiname ][ "players" ][ level.poi[ poiname ][ "players" ].size ] = player;
            player.var_764fa622c95214e4 = poiname;
            
            if ( !isdefined( player.recentpois ) )
            {
                player.recentpois = [];
            }
            
            if ( !isdefined( player.recentpois[ poiname ] ) )
            {
                entry = spawnstruct();
                entry.exittime = -99999999;
                player.recentpois[ poiname ] = entry;
                callback::callback( #"player_enter_poi", { #poi:poiname, #player:player } );
            }
            
            if ( isdefined( var_c5c08bf14a13636c ) && var_c5c08bf14a13636c != player.var_764fa622c95214e4 )
            {
                var_22e672392ff938cb = 1;
            }
            
            if ( !isdefined( var_c5c08bf14a13636c ) && isdefined( player.var_764fa622c95214e4 ) )
            {
                var_22e672392ff938cb = 1;
            }
            
            if ( var_22e672392ff938cb )
            {
                timesinceexit = gettime() - player.recentpois[ poiname ].exittime;
                
                if ( timesinceexit > level.var_6053799fc5292ab )
                {
                    if ( level.poi[ player.var_6d451102c6aefbf6 ][ "country" ] == level.areas[ player.var_b455d67c77a883b0 ][ "country" ] )
                    {
                        player thread utility::callsharedfunc( #"splash", #"hash_1cdff8916d495428", "dmz_poi_enter", [ player ], poiname );
                        continue;
                    }
                    
                    player thread utility::callsharedfunc( #"splash", #"hash_1cdff8916d495428", "dmz_entering_country", [ player ], poiname );
                }
            }
        }
    }
}

// Namespace dmz_poi
// Params 0, eflags: 0x4
// Checksum 0x444195e6, Offset: 0x33a4
// Size: 0x3e0
function private function_5e31518dd9b5ee5f()
{
    level utility::waittill_any( "matchStartTimer_done", "br_ready_to_jump" );
    
    while ( !isdefined( level.players ) || level.areas.size == 0 )
    {
        waitframe();
    }
    
    wait 1;
    
    foreach ( areaname, area in level.areas )
    {
        level.areas[ areaname ][ "players" ] = [];
    }
    
    foreach ( player in level.players )
    {
        areaname = area_findoriginisin( player.origin );
        callback::callback( #"on_player_enters_location", { #type:"area", #locationname:areaname, #player:player } );
        
        if ( isdefined( areaname ) )
        {
            player.var_b455d67c77a883b0 = areaname;
        }
    }
    
    waitframe();
    level.var_ab48e6097528fea2 = 0;
    
    while ( true )
    {
        for ( playersprocessed = 0; playersprocessed < level.var_ca00a98f96729962 && level.players.size > 0 ; playersprocessed++ )
        {
            level.var_ab48e6097528fea2 %= level.players.size;
            player = level.players[ level.var_ab48e6097528fea2 ];
            level.var_ab48e6097528fea2++;
            var_7d4926e95c5b2241 = area_findoriginisin( player.origin );
            
            if ( var_7d4926e95c5b2241 )
            {
                if ( player.var_b455d67c77a883b0 && player.var_b455d67c77a883b0 != var_7d4926e95c5b2241 )
                {
                    level.areas[ player.var_b455d67c77a883b0 ][ "players" ] = arrayremove( level.areas[ player.var_b455d67c77a883b0 ][ "players" ], player );
                }
                
                level.areas[ var_7d4926e95c5b2241 ][ "players" ] = arraycombineunique( level.areas[ var_7d4926e95c5b2241 ][ "players" ], [ player ] );
                
                if ( !level.poi[ player.var_6d451102c6aefbf6 ][ "country" ] || level.poi[ player.var_6d451102c6aefbf6 ][ "country" ] != level.areas[ var_7d4926e95c5b2241 ][ "country" ] )
                {
                    if ( player.var_b455d67c77a883b0 && level.areas[ var_7d4926e95c5b2241 ][ "country" ] && level.areas[ player.var_b455d67c77a883b0 ][ "country" ] != level.areas[ var_7d4926e95c5b2241 ][ "country" ] )
                    {
                        player thread utility::callsharedfunc( #"splash", #"hash_1cdff8916d495428", "dmz_entering_country", [ player ], var_7d4926e95c5b2241 );
                    }
                }
                
                player.var_b455d67c77a883b0 = var_7d4926e95c5b2241;
                continue;
            }
            
            if ( player.var_b455d67c77a883b0 )
            {
                level.areas[ player.var_b455d67c77a883b0 ][ "players" ] = arrayremove( level.areas[ player.var_b455d67c77a883b0 ][ "players" ], player );
            }
        }
        
        waitframe();
    }
}

// Namespace dmz_poi
// Params 3
// Checksum 0xce792ca7, Offset: 0x378c
// Size: 0x85
function function_4f261ea09b5a0d1c( player, poiname, areaname )
{
    potentialindex = undefined;
    
    if ( isdefined( poiname ) )
    {
        potentialindex = level.poi[ poiname ][ "calloutIndex" ];
    }
    
    if ( isdefined( areaname ) && !isdefined( player.var_6d451102c6aefbf6 ) )
    {
        potentialindex = level.areas[ areaname ][ "calloutIndex" ];
    }
    
    if ( potentialindex >= 0 )
    {
        player setclientomnvar( "ui_callout_area_id", potentialindex );
    }
}

// Namespace dmz_poi
// Params 1
// Checksum 0xee5e20e8, Offset: 0x3819
// Size: 0xba
function function_8dcd6b7912fb1c44( poiname )
{
    poi = level.poi[ poiname ];
    difficulty = function_1dd6dbf27451788( poiname );
    
    foreach ( player in poi[ "players" ] )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player setclientomnvar( "ui_dmz_poi_difficulty_rating", difficulty );
    }
}

// Namespace dmz_poi
// Params 1
// Checksum 0x541d46f6, Offset: 0x38db
// Size: 0x65
function function_1dd6dbf27451788( poiname )
{
    starlevel = namespace_e4f074fad347a61a::function_8fb952c22d4cd3da( poiname );
    relativedifficulty = 0;
    
    if ( isdefined( level.poi[ poiname ][ "relativeDifficulty" ] ) )
    {
        relativedifficulty = level.poi[ poiname ][ "relativeDifficulty" ];
    }
    
    return int( clamp( relativedifficulty + starlevel, 1, 4 ) );
}

// Namespace dmz_poi
// Params 1, eflags: 0x4
// Checksum 0x77935764, Offset: 0x3949
// Size: 0x58
function private function_69e2a1577a147a94( player )
{
    if ( isdefined( player.var_764fa622c95214e4 ) )
    {
        level.poi[ player.var_764fa622c95214e4 ][ "players" ] = arrayremove( level.poi[ player.var_764fa622c95214e4 ][ "players" ], player );
    }
}

// Namespace dmz_poi
// Params 1, eflags: 0x4
// Checksum 0x74891126, Offset: 0x39a9
// Size: 0xec
function private function_694d5a2db56d7630( poiname = self.var_764fa622c95214e4 )
{
    if ( level.var_df50cf8761945a01 )
    {
        return;
    }
    
    difficulty = function_1dd6dbf27451788( poiname );
    
    switch ( difficulty )
    {
        case 1:
            utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"ai_density_low", [ self ] );
            break;
        case 2:
            utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"ai_density_med", [ self ] );
            break;
        case 3:
            utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"ai_density_high", [ self ] );
            break;
    }
}

// Namespace dmz_poi
// Params 0
// Checksum 0x8a9573db, Offset: 0x3a9d
// Size: 0xe5
function function_9990ef4b565fc06a()
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

// Namespace dmz_poi
// Params 0
// Checksum 0x5deb6916, Offset: 0x3b8a
// Size: 0x185
function function_f97fac7cf82a782b()
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

// Namespace dmz_poi
// Params 0
// Checksum 0x817305d3, Offset: 0x3d17
// Size: 0x145
function function_d3f5b02f17724858()
{
    level.var_389159cbf5c14ce2 = [];
    level.subareas = [];
    subareavolumes = [];
    
    foreach ( volume in getnoentvolumearray( "noent_volume_info", #classname ) )
    {
        if ( volume.variantname == "noent_subarea_volume" )
        {
            subareavolumes[ subareavolumes.size ] = volume;
        }
    }
    
    if ( subareavolumes.size > 0 )
    {
        foreach ( volume in subareavolumes )
        {
            subarea = function_91d12f21ccd11629( volume );
            level.subareas[ level.subareas.size ] = subarea;
        }
    }
}

// Namespace dmz_poi
// Params 1
// Checksum 0x5c5662a, Offset: 0x3e64
// Size: 0xde
function function_91d12f21ccd11629( volume )
{
    areaname = tolower( volume.script_noteworthy );
    subareaname = tolower( volume.targetname );
    volume.areaname = areaname;
    volume.subareaname = subareaname;
    subarea = spawnstruct();
    subarea.areaname = areaname;
    subarea.subareaname = subareaname;
    subarea.volume = volume;
    subarea.livingagents = [];
    subarea.spawnpackage_required = [];
    subarea.spawnpackage_optional = [];
    subarea.origin = volume.origin;
    subarea = function_c22afa704a66436b( subarea );
    return subarea;
}

// Namespace dmz_poi
// Params 1, eflags: 0x4
// Checksum 0x466d94cf, Offset: 0x3f4b
// Size: 0xc2
function private function_c22afa704a66436b( subarea )
{
    if ( !isdefined( subarea ) )
    {
        return;
    }
    
    if ( !isdefined( subarea.features ) )
    {
        subarea.features = [];
    }
    
    foreach ( featurename in level.var_389159cbf5c14ce2 )
    {
        if ( !isdefined( subarea.features[ featurename ] ) )
        {
            subarea.features[ featurename ] = [];
        }
    }
    
    return subarea;
}

// Namespace dmz_poi
// Params 1
// Checksum 0x28123cfa, Offset: 0x4016
// Size: 0xbb
function subarea_addfeaturearray( featurename )
{
    if ( !arraycontains( level.var_389159cbf5c14ce2, featurename ) )
    {
        level.var_389159cbf5c14ce2[ level.var_389159cbf5c14ce2.size ] = featurename;
    }
    
    foreach ( index, subarea in level.subareas )
    {
        level.subareas[ index ] = function_c22afa704a66436b( subarea );
    }
}

// Namespace dmz_poi
// Params 3
// Checksum 0x161f6239, Offset: 0x40d9
// Size: 0x67
function subarea_getfeaturearray( areaname, subareaname, featurename )
{
    if ( !( isdefined( areaname ) && isdefined( subareaname ) && isdefined( featurename ) ) )
    {
        return;
    }
    
    if ( !arraycontains( level.var_389159cbf5c14ce2, featurename ) )
    {
        return;
    }
    
    return level.areas[ areaname ][ "subAreas" ][ subareaname ].features[ featurename ];
}

// Namespace dmz_poi
// Params 5
// Checksum 0x12aee4f7, Offset: 0x4149
// Size: 0xc3
function subarea_registerfeatureelement( areaname, subareaname, featurename, arrayelement, customkey )
{
    if ( !isdefined( areaname ) )
    {
        return;
    }
    
    if ( !isdefined( subareaname ) )
    {
        return;
    }
    
    if ( isdefined( customkey ) )
    {
        level.areas[ areaname ][ "subAreas" ][ subareaname ].features[ featurename ][ customkey ] = arrayelement;
        return;
    }
    
    index = level.areas[ areaname ][ "subAreas" ][ subareaname ].features[ featurename ].size;
    level.areas[ areaname ][ "subAreas" ][ subareaname ].features[ featurename ][ index ] = arrayelement;
}

// Namespace dmz_poi
// Params 0
// Checksum 0x9b095171, Offset: 0x4214
// Size: 0x168
function function_45a5b68630efe1a4()
{
    level.subareatuning = [];
    
    while ( !isdefined( level.var_b40e8430c5d07a40 ) )
    {
        waitframe();
    }
    
    if ( !dmzpoi_issystemactive() )
    {
        return;
    }
    
    foreach ( area in level.areas )
    {
        foreach ( subarea in area[ "subAreas" ] )
        {
            if ( !isdefined( subarea.tuning ) )
            {
                subarea.tuning = { #var_2fdda594ff89a52d:0, #var_ee14ca6e8181bd86:0 };
            }
        }
    }
    
    function_dd5efdf9941d95c5();
    function_de87fd1842673438();
    function_df64f34d9873fda8();
    
    if ( level.var_f8b1e9d1d264f480 )
    {
        level thread function_c8ae8b6d9663472b();
    }
    
    level.var_156349d932aabc45 = 1;
}

// Namespace dmz_poi
// Params 0
// Checksum 0x602462aa, Offset: 0x4384
// Size: 0x3b0
function function_dd5efdf9941d95c5()
{
    table = level.var_b40e8430c5d07a40;
    numrows = tablelookupgetnumrows( table );
    
    for ( i = 0; i < numrows ; i++ )
    {
        areaname = tablelookupbyrow( table, i, 0 );
        
        if ( arraycontains( level.var_8851f2c94661cea1, areaname ) )
        {
            continue;
        }
        
        subareaname = tolower( tablelookupbyrow( table, i, 1 ) );
        
        if ( issubstr( subareaname, "tieroverride" ) || subareaname == "minVehicleSpawns" )
        {
            continue;
        }
        
        if ( !isdefined( level.areas[ areaname ][ "subAreas" ][ subareaname ] ) )
        {
            continue;
        }
        
        if ( !isdefined( level.areas[ areaname ][ "subAreas" ][ subareaname ].tuning ) )
        {
            level.areas[ areaname ][ "subAreas" ][ subareaname ].tuning = spawnstruct();
        }
        
        tuning = level.areas[ areaname ][ "subAreas" ][ subareaname ].tuning;
        var_22c3e564e5b0795d = tablelookupbyrow( table, i, 2 );
        
        /#
            override = getdvar( hashcat( @"hash_75e522c69b4383e4", subareaname ) );
            var_22c3e564e5b0795d = override == "<dev string:x71>" ? var_22c3e564e5b0795d : override;
        #/
        
        if ( var_22c3e564e5b0795d )
        {
            tuning.var_22c3e564e5b0795d = float( var_22c3e564e5b0795d );
        }
        
        idealnum = int( tablelookupbyrow( table, i, 3 ) );
        maxnum = int( tablelookupbyrow( table, i, 4 ) );
        idealnum = getdvarint( hashcat( @"hash_1a72d09f5e25a285", areaname, "_", subareaname ), idealnum );
        maxnum = getdvarint( hashcat( @"hash_9c04e5f4bb63d6c0", areaname, "_", subareaname ), maxnum );
        tuning.var_ee14ca6e8181bd86 = idealnum;
        tuning.var_2fdda594ff89a52d = maxnum;
        
        if ( !isdefined( tuning.var_ee14ca6e8181bd86 ) )
        {
            tuning.var_ee14ca6e8181bd86 = 1;
        }
        
        if ( !isdefined( tuning.var_2fdda594ff89a52d ) )
        {
            tuning.var_2fdda594ff89a52d = idealnum;
        }
        
        nationalityoverride = tablelookupbyrow( table, i, 8 );
        
        if ( nationalityoverride )
        {
            tuning.nationalityoverride = nationalityoverride;
        }
        
        var_93f25c84ef6c3e2b = tablelookupbyrow( table, i, 9 );
        
        if ( var_93f25c84ef6c3e2b )
        {
            tuning.var_93f25c84ef6c3e2b = var_93f25c84ef6c3e2b;
        }
        
        var_7489deca0416ca2f = tablelookupbyrow( table, i, 13 );
        
        if ( var_7489deca0416ca2f )
        {
            tuning.var_7489deca0416ca2f = int( var_7489deca0416ca2f );
        }
        
        var_e4a102c8066aaec9 = tablelookupbyrow( table, i, 14 );
        
        if ( var_e4a102c8066aaec9 )
        {
            tuning.var_e4a102c8066aaec9 = int( var_e4a102c8066aaec9 );
        }
        
        var_d5b0123080b69eb4 = tablelookupbyrow( table, i, 15 );
        
        if ( var_d5b0123080b69eb4 )
        {
            tuning.var_d5b0123080b69eb4 = int( var_d5b0123080b69eb4 );
        }
        
        var_d5d3003080dcbed6 = tablelookupbyrow( table, i, 16 );
        
        if ( var_d5d3003080dcbed6 )
        {
            tuning.var_d5d3003080dcbed6 = int( var_d5d3003080dcbed6 );
        }
        
        var_9f21e8ffde4930f = tablelookupbyrow( table, i, 17 );
        
        if ( var_9f21e8ffde4930f )
        {
            tuning.var_9f21e8ffde4930f = int( var_9f21e8ffde4930f );
        }
        
        var_f1abf29235565ad0 = tablelookupbyrow( table, i, 18 );
        
        if ( var_f1abf29235565ad0 )
        {
            tuning.var_f1abf29235565ad0 = int( var_f1abf29235565ad0 );
        }
        
        damagetypeoverride = tablelookupbyrow( table, i, 19 );
        
        if ( damagetypeoverride )
        {
            tuning.damagetypeoverride = damagetypeoverride;
        }
    }
}

// Namespace dmz_poi
// Params 0
// Checksum 0xb5f68df3, Offset: 0x473c
// Size: 0x17c
function function_de87fd1842673438()
{
    table = level.var_b40e8430c5d07a40;
    numrows = tablelookupgetnumrows( table );
    
    for ( i = 0; i < numrows ; i++ )
    {
        areaname = tablelookupbyrow( table, i, 0 );
        
        if ( areaname == "minVehicleSpawns" )
        {
            continue;
        }
        
        if ( issubstr( areaname, "tieroverride" ) )
        {
            if ( !isdefined( level.var_f2385d0e5feed948 ) )
            {
                level.var_f2385d0e5feed948 = [];
            }
            
            level.var_f2385d0e5feed948[ areaname ] = int( tablelookupbyrow( table, i, 5 ) );
            continue;
        }
        
        subareaname = tolower( tablelookupbyrow( table, i, 1 ) );
        difficultynum = int( tablelookupbyrow( table, i, 5 ) );
        difficultynum = getdvarint( hashcat( @"hash_f625ffaa374c134b", areaname, "_", subareaname ), difficultynum );
        
        if ( !isdefined( level.areas[ areaname ][ "subAreas" ][ subareaname ].tuning ) )
        {
            if ( !isdefined( level.areas[ areaname ][ "subAreas" ][ subareaname ] ) )
            {
                continue;
            }
            
            level.areas[ areaname ][ "subAreas" ][ subareaname ].tuning = spawnstruct();
        }
        
        level.areas[ areaname ][ "subAreas" ][ subareaname ].tuning.difficultyrating = difficultynum;
    }
}

// Namespace dmz_poi
// Params 0
// Checksum 0x206351b8, Offset: 0x48c0
// Size: 0xff
function function_df64f34d9873fda8()
{
    table = level.var_b40e8430c5d07a40;
    numrows = tablelookupgetnumrows( table );
    
    for ( i = 0; i < numrows ; i++ )
    {
        areaname = tolower( tablelookupbyrow( table, i, 0 ) );
        subareaname = tolower( tablelookupbyrow( table, i, 1 ) );
        
        if ( !areaname || !subareaname )
        {
            continue;
        }
        
        if ( !level.areas[ areaname ] )
        {
            continue;
        }
        
        var_537082301b44b948 = int( tablelookupbyrow( table, i, 20 ) );
        level.areas[ areaname ][ "subAreas" ][ subareaname ].var_537082301b44b948 = var_537082301b44b948;
        var_98764618cb31924a = int( tablelookupbyrow( table, i, 21 ) );
        level.areas[ areaname ][ "subAreas" ][ subareaname ].var_98764618cb31924a = var_98764618cb31924a;
    }
}

// Namespace dmz_poi
// Params 1
// Checksum 0x98c0bf1e, Offset: 0x49c7
// Size: 0x38
function function_2be526898bb23df4( subarea )
{
    var_7237854e3be197ca = subarea.tuning.difficultyrating;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return 1;
}

// Namespace dmz_poi
// Params 1
// Checksum 0x152b9108, Offset: 0x4a08
// Size: 0x2f
function subarea_getsubareadifficultyfromorigin( origin )
{
    poiname = dmzpoi_findpoioriginisin( origin );
    return function_2be526898bb23df4( subarea_findfromorigin( origin, poiname ) );
}

// Namespace dmz_poi
// Params 2
// Checksum 0x1986942b, Offset: 0x4a40
// Size: 0x6c
function subarea_getsubareanationality( origin, subarea )
{
    if ( !isdefined( subarea ) )
    {
        if ( !isdefined( origin ) )
        {
            return ai_mp_controller::function_d8829485c05e8c1();
        }
        else
        {
            subarea = subarea_findfromorigin( origin );
        }
    }
    
    if ( isdefined( subarea.tuning.nationalityoverride ) )
    {
        return subarea.tuning.nationalityoverride;
    }
    
    return ai_mp_controller::function_d8829485c05e8c1();
}

// Namespace dmz_poi
// Params 0
// Checksum 0xd7bf3936, Offset: 0x4ab5
// Size: 0xff
function function_c8ae8b6d9663472b()
{
    tieroverridevolumes = getnoentvolumearray( "tierOverrideVolume", #targetname );
    
    foreach ( volume in tieroverridevolumes )
    {
        areaname = area_findoriginisin( volume.origin, 0 );
        
        if ( !isdefined( areaname ) )
        {
            continue;
        }
        
        if ( !isdefined( level.areas[ areaname ][ "tierOverrideVolumes" ] ) )
        {
            level.areas[ areaname ][ "tierOverrideVolumes" ] = [];
        }
        
        level.areas[ areaname ][ "tierOverrideVolumes" ][ level.areas[ areaname ][ "tierOverrideVolumes" ].size ] = volume;
    }
}

// Namespace dmz_poi
// Params 2
// Checksum 0x8bf8d373, Offset: 0x4bbc
// Size: 0xd9
function tieroverride_checkorigin( origin, areaname )
{
    if ( !area_isareaactive( areaname ) )
    {
        return;
    }
    
    if ( !isdefined( origin ) )
    {
        return;
    }
    
    if ( isdefined( level.areas[ areaname ][ "tierOverrideVolumes" ] ) )
    {
        foreach ( volume in level.areas[ areaname ][ "tierOverrideVolumes" ] )
        {
            if ( ispointinvolume( origin, volume ) )
            {
                return level.var_f2385d0e5feed948[ volume.script_label ];
            }
        }
    }
}

// Namespace dmz_poi
// Params 4
// Checksum 0x75eddbaa, Offset: 0x4c9d
// Size: 0xb7
function subarea_findfromorigin( origin, areaname, var_203430924a533062 = 1, var_e44426dd870f3753 = 0 )
{
    if ( dmzpoi_issystemactive() )
    {
        if ( !isdefined( areaname ) )
        {
            areaname = area_findoriginisin( origin, var_203430924a533062 );
        }
        
        if ( !isdefined( areaname ) )
        {
            return;
        }
        
        if ( !var_203430924a533062 && arraycontains( level.var_8851f2c94661cea1, areaname ) )
        {
            return;
        }
        
        if ( isdefined( level.areas[ areaname ][ "subAreas" ] ) )
        {
            subarea = function_dc4bba8faccdb520( areaname, origin );
            
            if ( isdefined( subarea ) )
            {
                return subarea;
            }
        }
        
        if ( var_e44426dd870f3753 )
        {
            return function_f1f0cd70a0f224f7( origin, areaname, var_203430924a533062 );
        }
    }
}

// Namespace dmz_poi
// Params 4
// Checksum 0x81032d57, Offset: 0x4d5c
// Size: 0xa2
function function_f1f0cd70a0f224f7( origin, areaname, var_203430924a533062 = 1, var_3806025b1724b52a = 1 )
{
    if ( !isdefined( origin ) )
    {
        return;
    }
    
    if ( dmzpoi_issystemactive() )
    {
        if ( !var_3806025b1724b52a )
        {
            if ( !isdefined( areaname ) )
            {
                areaname = area_findoriginisin( origin, var_203430924a533062, 1 );
            }
            
            var_8f6e7deef02b8afc = sortbydistance( level.areas[ areaname ][ "subAreas" ], origin );
            return var_8f6e7deef02b8afc[ 0 ];
        }
        
        var_8f6e7deef02b8afc = sortbydistance( level.subareas, origin );
        return var_8f6e7deef02b8afc[ 0 ];
    }
}

// Namespace dmz_poi
// Params 3
// Checksum 0x824cd0ec, Offset: 0x4e06
// Size: 0x81
function subarea_findandassignforagent( agent, subarea, destination )
{
    origin = agent.origin;
    
    if ( isdefined( destination ) )
    {
        origin = destination;
    }
    
    if ( !isdefined( subarea ) )
    {
        subarea = subarea_findfromorigin( origin, undefined, undefined, 1 );
    }
    
    if ( isdefined( subarea ) )
    {
        subarea.livingagents[ subarea.livingagents.size ] = agent;
        agent.subarea = subarea;
    }
}

// Namespace dmz_poi
// Params 4
// Checksum 0x71f688c0, Offset: 0x4e8f
// Size: 0x8b
function subarea_findandassignfordormancyid( origin, subarea, destination, dormancyid )
{
    if ( !isdefined( level.var_87bd0b3632631717[ dormancyid ] ) )
    {
        return;
    }
    
    if ( isdefined( destination ) )
    {
        origin = destination;
    }
    
    if ( !isdefined( subarea ) )
    {
        subarea = subarea_findfromorigin( origin );
    }
    
    level.var_87bd0b3632631717[ dormancyid ].subarea = subarea;
    
    if ( isdefined( subarea ) )
    {
        subarea.livingagents[ subarea.livingagents.size ] = dormancyid;
    }
}

// Namespace dmz_poi
// Params 2
// Checksum 0x234881af, Offset: 0x4f22
// Size: 0x78
function subarea_removeagentfrom( agent, subarea )
{
    if ( !isdefined( subarea ) )
    {
        subarea = agent.subarea;
        
        if ( !isdefined( subarea ) )
        {
            subarea = utility::callsharedfunc( #"poi", #"hash_8dbb0d45f903ae1c", agent.origin );
        }
    }
    
    if ( !isdefined( subarea ) )
    {
        return;
    }
    
    subarea.livingagents = arrayremove( subarea.livingagents, agent );
}

// Namespace dmz_poi
// Params 1
// Checksum 0xe3b34fc4, Offset: 0x4fa2
// Size: 0x149
function subarea_checkforreinforcementshutdown( subarea )
{
    if ( dmzpoi_issystemactive() )
    {
        if ( !isdefined( subarea ) )
        {
            return;
        }
        
        if ( subarea.isshutdown )
        {
            return;
        }
        
        areaname = subarea.areaname;
        subareaname = subarea.subareaname;
        var_d57f6caea938a49 = level.aibudgets.areas[ areaname ][ subareaname ];
        var_93f25c84ef6c3e2b = subarea.tuning.var_93f25c84ef6c3e2b;
        
        if ( isdefined( var_93f25c84ef6c3e2b ) )
        {
            return;
        }
        
        if ( !isdefined( var_d57f6caea938a49.shutdowndeathcount ) )
        {
            var_d57f6caea938a49.shutdowndeathcount = var_d57f6caea938a49.shutdowninterval;
        }
        
        if ( var_d57f6caea938a49.agentdeaths >= var_d57f6caea938a49.shutdowndeathcount )
        {
            subarea.var_8c14effb189f3c38 = 1;
            
            if ( subarea.poiname )
            {
                function_192ee0377f119b53( subarea.poiname );
            }
            else
            {
                subarea.isshutdown = 1;
                var_d57f6caea938a49.shutdowntime = gettime();
            }
            
            utility::callsharedfunc( #"poi", #"subarea_checkforreinforcementshutdownclear", subarea );
        }
    }
}

// Namespace dmz_poi
// Params 1
// Checksum 0x4d1f8f60, Offset: 0x50f3
// Size: 0xef
function function_192ee0377f119b53( poiname )
{
    foreach ( subarea in level.poi[ poiname ][ "subAreas" ] )
    {
        subarea.isshutdown = 1;
        areaname = subarea.areaname;
        subareaname = subarea.subareaname;
        var_d57f6caea938a49 = level.aibudgets.areas[ areaname ][ subareaname ];
        var_d57f6caea938a49.shutdowntime = gettime();
    }
}

// Namespace dmz_poi
// Params 1
// Checksum 0x6cfdf771, Offset: 0x51ea
// Size: 0x10d
function subarea_checkforreinforcementshutdownclear( subarea )
{
    if ( dmzpoi_issystemactive() )
    {
        if ( !isdefined( subarea ) )
        {
            return;
        }
        
        areaname = subarea.areaname;
        subareaname = subarea.subareaname;
        var_d57f6caea938a49 = level.aibudgets.areas[ areaname ][ subareaname ];
        
        if ( !isdefined( var_d57f6caea938a49.shutdowntime ) )
        {
            return;
        }
        
        while ( var_d57f6caea938a49.shutdowntime + level.var_f15ee21b463afe2b > gettime() )
        {
            wait 1;
        }
        
        if ( subarea.poiname )
        {
            function_e646cc149329dec6( subarea.poiname );
            return;
        }
        
        subarea.isshutdown = 0;
        subarea.var_ee24fa1e4b6ae66 = 1;
        subarea.var_8c14effb189f3c38 = 0;
        var_d57f6caea938a49.shutdowndeathcount = var_d57f6caea938a49.agentdeaths + var_d57f6caea938a49.shutdowninterval;
    }
}

// Namespace dmz_poi
// Params 1
// Checksum 0x44dfa111, Offset: 0x52ff
// Size: 0x15b
function function_e646cc149329dec6( poiname )
{
    foreach ( subarea in level.poi[ poiname ][ "subAreas" ] )
    {
        subarea.isshutdown = 0;
        subarea.var_ee24fa1e4b6ae66 = 1;
        subarea.var_8c14effb189f3c38 = 0;
        ai_reinforcements::function_45d15116d2acf1f8( subarea );
        areaname = subarea.areaname;
        subareaname = subarea.subareaname;
        var_d57f6caea938a49 = level.aibudgets.areas[ areaname ][ subareaname ];
        
        if ( !isdefined( var_d57f6caea938a49.shutdowndeathcount ) )
        {
            var_d57f6caea938a49.shutdowndeathcount = var_d57f6caea938a49.agentdeaths + var_d57f6caea938a49.shutdowninterval;
            continue;
        }
        
        var_d57f6caea938a49.shutdowndeathcount = var_d57f6caea938a49.agentdeaths + var_d57f6caea938a49.shutdowninterval;
    }
}

// Namespace dmz_poi
// Params 2
// Checksum 0xffb60b27, Offset: 0x5462
// Size: 0x106
function subarea_orderagentarraysubareafirst( subarea, array )
{
    var_e9e0d5c43d34731a = [];
    var_be26a9ae219540a2 = [];
    
    foreach ( agent in array )
    {
        agentsubarea = undefined;
        
        if ( !isagent( agent ) )
        {
            agentsubarea = level.var_87bd0b3632631717[ agent ].subarea;
        }
        else
        {
            agentsubarea = agent.subarea;
        }
        
        if ( !isdefined( agentsubarea ) )
        {
            continue;
        }
        
        if ( agentsubarea == subarea )
        {
            var_e9e0d5c43d34731a[ var_e9e0d5c43d34731a.size ] = agent;
            continue;
        }
        
        var_be26a9ae219540a2[ var_be26a9ae219540a2.size ] = agent;
    }
    
    newarray = arraycombine( var_e9e0d5c43d34731a, var_be26a9ae219540a2 );
    return newarray;
}

// Namespace dmz_poi
// Params 1
// Checksum 0x967d3deb, Offset: 0x5571
// Size: 0x27b
function subarea_spawnagentpackages( subarea )
{
    subarea.spawnpackage_required = arrayrandomize( subarea.spawnpackage_required );
    
    foreach ( spawnpackage in subarea.spawnpackage_required )
    {
        ai_mp_controller::spawnpackage_spawn( spawnpackage, "medium" );
    }
    
    function_f15a5d2863270e18( subarea );
    function_16bd890047f115e0( subarea );
    subarea.spawnpackage_optional = arrayrandomize( subarea.spawnpackage_optional );
    
    foreach ( spawnpackage in subarea.spawnpackage_optional )
    {
        if ( subarea.livingagents.size >= subarea.tuning.var_ee14ca6e8181bd86 )
        {
            break;
        }
        
        if ( spawnpackage.script_agent_noteworthy == "agent_spawnpackageselector" )
        {
            spawnpackageselector = spawnpackage;
            var_f34013e54cf822d0 = [];
            
            foreach ( spawnpackage in spawnpackageselector.spawnpackages )
            {
                if ( spawnpackage.script_required )
                {
                    ai_mp_controller::spawnpackage_spawn( spawnpackage );
                    
                    if ( subarea.livingagents.size >= subarea.tuning.var_ee14ca6e8181bd86 )
                    {
                        break;
                    }
                    
                    continue;
                }
                
                var_f34013e54cf822d0[ var_f34013e54cf822d0.size ] = spawnpackage;
            }
            
            spawnpackage = utility::array_random( var_f34013e54cf822d0 );
            ai_mp_controller::spawnpackage_spawn( spawnpackage );
            continue;
        }
        
        if ( isdefined( spawnpackage ) && !spawnpackage.spawned )
        {
            ai_mp_controller::spawnpackage_spawn( spawnpackage );
            continue;
        }
        
        break;
    }
}

// Namespace dmz_poi
// Params 1
// Checksum 0xa49c7887, Offset: 0x57f4
// Size: 0x247
function function_f15a5d2863270e18( subarea )
{
    if ( !isdefined( subarea.var_4dd2465177822d5c ) )
    {
        return;
    }
    
    if ( level.var_15fb757c9b81d8c4 )
    {
        managedgroupname = "guards|" + ai_mp_controller::function_23093472391d772f( subarea );
        allowlw = ai_mp_controller::function_194ab657916a88db( subarea );
    }
    
    numspawned = 0;
    index = 0;
    subarea.var_4dd2465177822d5c = arrayrandomize( subarea.var_4dd2465177822d5c );
    
    if ( isdefined( subarea.tuning.var_7489deca0416ca2f ) )
    {
        while ( subarea.livingagents.size < subarea.tuning.var_ee14ca6e8181bd86 && numspawned < subarea.tuning.var_7489deca0416ca2f )
        {
            spawnloc = subarea.var_4dd2465177822d5c[ index ];
            
            if ( !isdefined( spawnloc ) )
            {
                return;
            }
            
            spawnloc.aitype = "sniper";
            
            if ( level.var_15fb757c9b81d8c4 )
            {
                groupid = ai_mp_controller::function_29dc8dd695322183( subarea, managedgroupname, spawnloc.origin, allowlw );
            }
            
            agent = ai_mp_controller::spawnguard( spawnloc, undefined, "medium", "spawnPackage", undefined, subarea, groupid );
            
            if ( isdefined( agent ) )
            {
                numspawned++;
                index++;
                continue;
            }
            
            waitframe();
        }
    }
    
    numspawned = 0;
    
    if ( isdefined( subarea.tuning.var_e4a102c8066aaec9 ) )
    {
        while ( subarea.livingagents.size < subarea.tuning.var_ee14ca6e8181bd86 && numspawned < subarea.tuning.var_e4a102c8066aaec9 )
        {
            spawnloc = subarea.var_4dd2465177822d5c[ index ];
            
            if ( !isdefined( spawnloc ) )
            {
                return;
            }
            
            spawnloc.aitype = "rpg";
            
            if ( level.var_15fb757c9b81d8c4 )
            {
                groupid = ai_mp_controller::function_29dc8dd695322183( subarea, managedgroupname, spawnloc.origin, allowlw );
            }
            
            agent = ai_mp_controller::spawnguard( spawnloc, undefined, "medium", "spawnPackage", undefined, subarea, groupid );
            
            if ( isdefined( agent ) )
            {
                numspawned++;
                index++;
                continue;
            }
            
            waitframe();
        }
    }
}

// Namespace dmz_poi
// Params 1
// Checksum 0x83025c0e, Offset: 0x5a43
// Size: 0x1ce
function function_16bd890047f115e0( subarea )
{
    if ( !isdefined( subarea.var_173533fa4f4e7c30 ) )
    {
        return;
    }
    
    if ( !( isdefined( subarea.tuning.var_d5b0123080b69eb4 ) && isdefined( subarea.tuning.var_d5d3003080dcbed6 ) ) )
    {
        return;
    }
    
    if ( level.var_15fb757c9b81d8c4 )
    {
        managedgroupname = "patrols|" + ai_mp_controller::function_23093472391d772f( subarea );
        allowlw = ai_mp_controller::function_194ab657916a88db( subarea );
    }
    
    var_9f44158845746285 = 0;
    index = 0;
    subarea.var_173533fa4f4e7c30 = arrayrandomize( subarea.var_173533fa4f4e7c30 );
    var_f5bae713987b1d02 = randomintrange( subarea.tuning.var_d5b0123080b69eb4, subarea.tuning.var_d5d3003080dcbed6 + 1 );
    
    while ( subarea.livingagents.size < subarea.tuning.var_ee14ca6e8181bd86 && var_9f44158845746285 < var_f5bae713987b1d02 )
    {
        spawnloc = subarea.var_173533fa4f4e7c30[ index ];
        
        if ( !isdefined( spawnloc ) )
        {
            return;
        }
        
        patrolstruct = ai_mp_controller::function_ad7994ce0f8a6d54( spawnloc );
        
        if ( !patrolstruct )
        {
            index++;
            continue;
        }
        
        patrolstruct.claimed = 1;
        
        if ( level.var_15fb757c9b81d8c4 )
        {
            var_599d450bd1f7dd3b = ai_mp_controller::function_29dc8dd695322183( patrolstruct, managedgroupname, spawnloc.origin, allowlw, 1 );
        }
        
        agents = ai_mp_controller::spawnpatrol( patrolstruct, undefined, undefined, undefined, "medium", "spawnPackage", undefined, undefined, var_599d450bd1f7dd3b );
        
        if ( isdefined( agents ) )
        {
            var_9f44158845746285++;
            index++;
        }
    }
}

// Namespace dmz_poi
// Params 2, eflags: 0x4
// Checksum 0x6aa94e24, Offset: 0x5c19
// Size: 0x68
function private function_7b69e6ffc5588dbb( poiname, calloutstruct )
{
    if ( !isdefined( level.var_ce8a2269dc6b433d ) )
    {
        level.var_ce8a2269dc6b433d = [];
    }
    
    if ( !poiname || !level.mapinfobundle.calloutlist || level.var_ce8a2269dc6b433d[ poiname ] )
    {
        return;
    }
    
    level.var_ce8a2269dc6b433d[ poiname ] = calloutstruct;
}

// Namespace dmz_poi
// Params 1
// Checksum 0x4f348aa3, Offset: 0x5c89
// Size: 0x134
function function_4ad4ea474657727f( poiname )
{
    if ( !isdefined( level.mapinfobundle ) )
    {
        level.mapinfobundle = getmapscriptbundle();
    }
    
    if ( !level.mapinfobundle.calloutlist )
    {
        return 0;
    }
    
    if ( level.var_ce8a2269dc6b433d && level.var_ce8a2269dc6b433d[ poiname ] )
    {
        return level.var_ce8a2269dc6b433d[ poiname ].priority;
    }
    
    foreach ( calloutstruct in level.mapinfobundle.calloutlist )
    {
        if ( issubstr( calloutstruct.variant_object.calloutref, poiname ) )
        {
            function_7b69e6ffc5588dbb( poiname, calloutstruct.variant_object );
            return calloutstruct.variant_object.priority;
        }
    }
    
    return 0;
}

// Namespace dmz_poi
// Params 1
// Checksum 0x49080038, Offset: 0x5dc6
// Size: 0x17f
function function_198de25d2c6e3899( name )
{
    if ( !isdefined( level.mapinfobundle ) )
    {
        level.mapinfobundle = getmapscriptbundle();
    }
    
    if ( !level.mapinfobundle.calloutlist )
    {
        return;
    }
    
    if ( level.var_ce8a2269dc6b433d && level.var_ce8a2269dc6b433d[ name ] )
    {
        if ( !level.var_ce8a2269dc6b433d[ name ].countrydata )
        {
            return;
        }
        
        return getscriptbundlefieldvalue( level.var_ce8a2269dc6b433d[ name ].countrydata, #"hash_9b3925608db41a78" );
    }
    
    foreach ( calloutstruct in level.mapinfobundle.calloutlist )
    {
        if ( issubstr( calloutstruct.variant_object.calloutref, name ) )
        {
            if ( calloutstruct.variant_object.countrydata )
            {
                function_7b69e6ffc5588dbb( name, calloutstruct.variant_object );
                return getscriptbundlefieldvalue( calloutstruct.variant_object.countrydata, #"hash_9b3925608db41a78" );
            }
        }
    }
}

/#

    // Namespace dmz_poi
    // Params 0
    // Checksum 0x8294409b, Offset: 0x5f4e
    // Size: 0x24d, Type: dev
    function function_271cfe9e46f18297()
    {
        while ( !utility::flag_exist( "<dev string:x72>" ) )
        {
            waitframe();
        }
        
        utility::flag_wait( "<dev string:x72>" );
        setdvar( @"hash_9df831bbc353dad7", 0 );
        
        while ( true )
        {
            wait 0.5;
            
            if ( !level.players || level.players.size == 0 )
            {
                continue;
            }
            
            dvarvalue = getdvarint( @"hash_9df831bbc353dad7", 0 );
            
            if ( dvarvalue == 0 )
            {
                if ( level.players[ 0 ].var_d56844ef3555715d )
                {
                    level.players[ 0 ].var_d56844ef3555715d setdevtext( "<dev string:x71>" );
                }
                
                continue;
            }
            
            origin = level.players[ 0 ].origin;
            data = function_dc4bba8faccdb520( undefined, origin );
            
            if ( !data )
            {
                continue;
            }
            
            poiname = data.poiname;
            areaname = data.areaname;
            subareaname = data.subareaname;
            
            if ( !level.players[ 0 ].var_d56844ef3555715d )
            {
                poi_text = newhudelem();
                poi_text.x = 25;
                poi_text.y = 25;
                poi_text.color = ( 1, 0, 0.9 );
                poi_text.alpha = 1;
                poi_text.hidden = 0;
                poi_text.var_3d413c404ce8bc30 = 0;
                poi_text.critical_damage = 0;
                poi_text.fontscale = 0.75;
                level.players[ 0 ].var_d56844ef3555715d = poi_text;
            }
            
            msg = "<dev string:x82>" + poiname + "<dev string:x8c>" + areaname + "<dev string:x9a>" + subareaname;
            level.players[ 0 ].var_d56844ef3555715d setdevtext( msg );
            level.players[ 0 ].var_d56844ef3555715d clearalltextafterhudelem();
        }
    }

#/
