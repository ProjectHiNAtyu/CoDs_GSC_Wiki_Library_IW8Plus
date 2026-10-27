// scripts\mp\structspawnconfig.gsc  (hash_4440095dbe990b46.gscc) (size: 39200 Bytes / 0x9920 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfd67859e (4251420062)
// size ...... 39200 (0x9920)
// includes .. 5   (offset: 0x9180)
// strings ... 77  (offset: 0x91a8)
// dev strs .. 66  (offset: 0x95dc)
// exports ... 127 (offset: 0x63c4)
// cseg ...... 0x711 + 0x5cb3 (0x63c4)
// imports ... 199 (offset: 0x779c)
// animtree1 . 0   (offset: 0x9920)
// animtree2 . 0   (offset: 0x9920)
#using script_16ea1b94f0f381b3;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\poi;

#namespace structspawnconfig;

// Namespace structspawnconfig
// Params 0, eflags: 0x5
// Checksum 0x2de3d32, Offset: 0x72f
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"structspawnconfig", undefined, &init, undefined );
}

// Namespace structspawnconfig
// Params 0
// Checksum 0xb817945b, Offset: 0x750
// Size: 0x1f5, Type: bool
function init()
{
    if ( getdvarint( @"hash_e6afce2cf5cf7515" ) == 1 )
    {
        return false;
    }
    
    if ( !getdvarint( @"scr_ssc_enabled", 1 ) || isdefined( level.ssc ) )
    {
        return false;
    }
    
    debug_print( "System enabled" );
    
    /#
        init_debug();
        thread debug_thread();
    #/
    
    var_43f3c6567c6a825b = getdvar( @"scr_ssc_config_list_override", "" );
    
    if ( var_43f3c6567c6a825b != "" )
    {
        level.sscl = hashcat( %"hash_1253fc6aee0cf412", var_43f3c6567c6a825b );
    }
    else
    {
        if ( isdefined( level.gametypebundle.sscl ) )
        {
            level.sscl = level.gametypebundle.sscl;
        }
        
        if ( isdefined( level.gametypebundle.var_8e448012be99c2bc ) )
        {
            foreach ( mapentry in level.gametypebundle.var_8e448012be99c2bc )
            {
                if ( isdefined( mapentry.map ) )
                {
                    mapinfobundle = getmapinfobundle( mapentry.map );
                    
                    if ( mapinfobundle.mapname == level.mapname )
                    {
                        level.sscl = mapentry.sscl;
                        break;
                    }
                }
            }
        }
    }
    
    if ( !isdefined( level.sscl ) )
    {
        debug_print( "No Config List given, exiting" );
        return false;
    }
    
    init_data();
    utility::flag_set( "ssc_initialized" );
    thread init_thread( level.sscl );
    return true;
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x1ca4498f, Offset: 0x94e
// Size: 0x5c
function private init_thread( listref )
{
    debug_print_verbose( "init_thread entered" );
    
    if ( poi::poi_issystemactive() )
    {
        level waittill( #"pois_spawned" );
    }
    
    debug_print_verbose( "init_thread level waittill set" );
    wait 1;
    ssc_config( listref );
    level notify( #"ssc_config_spawned" );
    init_cleanup_temp();
}

// Namespace structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0xb48492ff, Offset: 0x9b2
// Size: 0xac
function private init_data()
{
    level.ssc = spawnstruct();
    level.ssc.spawns = [];
    
    /#
        level.ssc.colors = [];
        level.ssc.drawcount = 0;
    #/
    
    level.ssc.funcgetlocations = [];
    level.ssc.var_1203f9795300b943 = [];
    level.ssc.var_9cb7faebef4e013d = [];
    level.ssc.var_2baf370af79db528 = [];
    init_data_temp();
}

// Namespace structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0x6d85fc07, Offset: 0xa66
// Size: 0x56
function private init_data_temp()
{
    level.ssc.structs = [];
    level.ssc.indexes = [];
    level.ssc.exclude = [];
    level.ssc.weights = [];
}

// Namespace structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0x3d33a4e4, Offset: 0xac4
// Size: 0x4e
function private init_cleanup_temp()
{
    level.ssc.structs = undefined;
    level.ssc.indexes = undefined;
    level.ssc.exclude = undefined;
    level.ssc.weights = undefined;
}

// Namespace structspawnconfig
// Params 2
// Checksum 0xa264cc32, Offset: 0xb1a
// Size: 0x53
function function_7418a260adaec05( structname, var_708aa9029f1cc545 )
{
    if ( !( isdefined( level.ssc ) && isdefined( level.ssc.funcgetlocations ) ) )
    {
        return;
    }
    
    level.ssc.funcgetlocations[ structname ] = var_708aa9029f1cc545;
}

// Namespace structspawnconfig
// Params 2
// Checksum 0xdc101587, Offset: 0xb75
// Size: 0x53
function function_8c0a09968efe9138( structname, var_bd4bed2415cba185 )
{
    if ( !( isdefined( level.ssc ) && isdefined( level.ssc.var_1203f9795300b943 ) ) )
    {
        return;
    }
    
    level.ssc.var_1203f9795300b943[ structname ] = var_bd4bed2415cba185;
}

// Namespace structspawnconfig
// Params 2
// Checksum 0x2ba6580d, Offset: 0xbd0
// Size: 0x53
function function_5d240d112f92de88( structname, var_f94432a4772c3618 )
{
    if ( !( isdefined( level.ssc ) && isdefined( level.ssc.var_9cb7faebef4e013d ) ) )
    {
        return;
    }
    
    level.ssc.var_9cb7faebef4e013d[ structname ] = var_f94432a4772c3618;
}

// Namespace structspawnconfig
// Params 2
// Checksum 0xfa3362f5, Offset: 0xc2b
// Size: 0x53
function function_36050499b5f48983( structname, var_fedf21dff8e30d3d )
{
    if ( !( isdefined( level.ssc ) && isdefined( level.ssc.var_2baf370af79db528 ) ) )
    {
        return;
    }
    
    level.ssc.var_2baf370af79db528[ structname ] = var_fedf21dff8e30d3d;
}

// Namespace structspawnconfig
// Params 2
// Checksum 0xebd76352, Offset: 0xc86
// Size: 0x84
function ssc_config( listref, spawntype )
{
    configlist = ssc_config_init( listref );
    
    if ( !isdefined( configlist ) )
    {
        debug_print_verbose( "ssc_config could not init list" );
        return;
    }
    
    results = configlist ssc_config_spawn_all( spawntype );
    
    /#
        debug_print( "<dev string:x24>" + getxhashsourcename( listref ) );
        
        if ( spawntype == 2 )
        {
            level.ssc.drawcount++;
        }
    #/
    
    return results;
}

// Namespace structspawnconfig
// Params 2
// Checksum 0x3cb1d517, Offset: 0xd13
// Size: 0x85
function ssc_config_single( configref, spawntype )
{
    spawnconfig = function_5d1805cd9bcb3bf0( configref, "structspawnconfig:" );
    
    if ( !isdefined( spawnconfig ) )
    {
        debug_print_verbose( "ssc_config_single could not init config" );
        return;
    }
    
    results = spawnconfig ssc_process( spawntype );
    debug_print( "Spawning complete for config " + configref );
    
    /#
        if ( spawntype == 2 )
        {
            level.ssc.drawcount++;
        }
    #/
    
    return results;
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0xa1fa905, Offset: 0xda1
// Size: 0x60
function private ssc_config_init( listref )
{
    configbundle = function_5d1805cd9bcb3bf0( listref );
    
    if ( !isdefined( configbundle ) )
    {
        return;
    }
    
    configlist = function_c502c7566cf59e2a( configbundle );
    
    if ( !isdefined( configlist ) )
    {
        return;
    }
    
    configlist = configlist ssc_config_overrides();
    configlist ssc_config_sort();
    configlist function_da77e9bedd1bc78b();
    return configlist;
}

// Namespace structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0x47123150, Offset: 0xe0a
// Size: 0xd7
function private ssc_config_overrides()
{
    configlist = self;
    configrefs = strtok( getdvar( @"scr_ssc_config_overrides", "" ), " " );
    
    if ( configrefs.size == 0 )
    {
        return configlist;
    }
    
    foreach ( configref in configrefs )
    {
        configlist = function_b9490163dc12e026( configlist, configref, "structspawnconfig:" );
    }
    
    debug_print( "Config overrides loaded: " + getdvar( @"scr_ssc_config_overrides", "" ) );
    return configlist;
}

// Namespace structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0xd34e5d8d, Offset: 0xeea
// Size: 0x1d
function private ssc_config_sort()
{
    configlist = self;
    configlist = arraysort( configlist, undefined, &function_567fa520955bb35 );
}

// Namespace structspawnconfig
// Params 2
// Checksum 0x5d9a811b, Offset: 0xf0f
// Size: 0x41, Type: bool
function function_567fa520955bb35( left, right )
{
    var_cdd6b527517b64bb = left function_c45630c66d2f914();
    
    if ( arraycontains( var_cdd6b527517b64bb, right.script_struct ) )
    {
        return true;
    }
    
    return false;
}

// Namespace structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0xdd4adc11, Offset: 0xf59
// Size: 0x5b
function private function_c45630c66d2f914()
{
    spawnconfig = self;
    var_681b5dabe2936cf7 = function_d7412234d4fdda3c( spawnconfig.var_56d4f76eb9d8a404, spawnconfig.var_978fc82a128927c9 );
    var_681b5dabe2936cf7 = arraycombine( var_681b5dabe2936cf7, function_d7412234d4fdda3c( spawnconfig.var_a444dba3095d616e, spawnconfig.var_e79ba16812baa6af ) );
    return var_681b5dabe2936cf7;
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0xbaf15441, Offset: 0xfbd
// Size: 0xab
function private function_d7412234d4fdda3c( rule, var_cab7d7bdf4904501 )
{
    structnames = [];
    
    if ( !function_22bdbbccaf611486( rule ) )
    {
        return structnames;
    }
    
    foreach ( entry in var_cab7d7bdf4904501 )
    {
        structnames[ structnames.size ] = entry.script_struct;
    }
    
    return structnames;
}

// Namespace structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0xbc586ccd, Offset: 0x1071
// Size: 0x5e
function private function_da77e9bedd1bc78b()
{
    configlist = self;
    var_a66a54b15919bd8c = "";
    
    for ( i = 0; i < configlist.size ; i++ )
    {
        var_a66a54b15919bd8c += configlist[ i ].script_struct + " ";
    }
    
    debug_print( "Final config list: " + var_a66a54b15919bd8c );
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x382cc479, Offset: 0x10d7
// Size: 0x67
function private ssc_config_spawn_all( spawntype )
{
    configlist = self;
    results = [];
    
    for ( i = 0; i < configlist.size ; i++ )
    {
        index = configlist[ i ].script_struct;
        results[ index ] = configlist[ i ] ssc_process( spawntype );
    }
    
    return results;
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0xeecf34bf, Offset: 0x1147
// Size: 0x74
function private ssc_process( spawntype )
{
    spawnconfig = self;
    
    if ( !isdefined( spawntype ) )
    {
        spawntype = 0;
    }
    
    function_78c535ba3b646b0e( spawnconfig, spawntype );
    spawnlist = spawnconfig function_a4234c98fdcfd63();
    spawnresult = spawnlist function_99ebfb65bb511d33( spawnconfig, spawntype );
    spawnlist function_c6a1414213e4a36c( spawnconfig, spawntype );
    spawnlist function_fcacfbede1768cf6( spawnconfig, spawntype );
    
    if ( spawntype == 3 )
    {
        return spawnlist;
    }
    
    return spawnresult;
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0xa1fd46f2, Offset: 0x11c4
// Size: 0x194
function private function_78c535ba3b646b0e( spawnconfig, spawntype )
{
    init_data_temp();
    
    if ( !isdefined( level.ssc.spawns[ spawnconfig.script_struct ] ) && spawntype != 2 )
    {
        level.ssc.spawns[ spawnconfig.script_struct ] = [];
    }
    
    /#
        if ( isdefined( spawnconfig.debug_color ) )
        {
            colorvec = strtok( spawnconfig.debug_color, "<dev string:x47>" );
            level.ssc.colors[ spawnconfig.script_struct ] = ( float( colorvec[ 0 ] ), float( colorvec[ 1 ] ), float( colorvec[ 2 ] ) );
        }
    #/
    
    structlocations = function_1b9f953b761fc982( spawnconfig.script_struct );
    debug_print_verbose( "Struct " + spawnconfig.script_struct + " found " + structlocations.size + " locations to select from" );
    
    for ( i = 0; i < structlocations.size ; i++ )
    {
        struct = structlocations[ i ];
        thisindex = function_c174f268cb8ce270( struct.script_index );
        level.ssc.indexes[ thisindex ] = thisindex;
        level.ssc.structs[ thisindex ] = struct;
        function_4024f17e80d5dd41( spawnconfig, struct, thisindex );
    }
}

// Namespace structspawnconfig
// Params 3, eflags: 0x4
// Checksum 0x4f1707f7, Offset: 0x1360
// Size: 0x7d
function private function_4024f17e80d5dd41( spawnconfig, struct, thisindex )
{
    structpoi = function_ce3ae8fa55f5f2b2( struct );
    
    if ( !isdefined( level.ssc.structs[ structpoi ] ) )
    {
        level.ssc.structs[ structpoi ] = [];
    }
    
    level.ssc.structs[ structpoi ][ thisindex ] = struct;
}

// Namespace structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0x2e94ee37, Offset: 0x13e5
// Size: 0x105
function private function_a4234c98fdcfd63()
{
    spawnconfig = self;
    spawns = [];
    debug_print_verbose( "Struct " + spawnconfig.script_struct + " is beginning config processing" );
    
    if ( spawnconfig.spawn_all || spawnconfig.spawn_all_rules )
    {
        spawns = level.ssc.indexes;
        
        if ( spawnconfig.spawn_all )
        {
            debug_print_verbose( "Spawn All was selected, exiting" );
            return spawns;
        }
    }
    
    spawnconfig = spawnconfig function_81eefdbb6e2fcbae();
    spawns = spawns function_5b505c2c65b99e17( spawnconfig );
    spawns = spawns function_7edb2f365933c9a0( spawnconfig );
    spawns = spawns function_ae459edc4279238b( spawnconfig );
    spawns = spawns function_bc701dcc4246cc00( spawnconfig );
    spawns = spawns function_d6c41239c5afa351( spawnconfig );
    spawns = spawns function_ae459edc4279238b( spawnconfig );
    spawns = spawns function_7edb2f365933c9a0( spawnconfig );
    spawns = spawns function_d6c41239c5afa351( spawnconfig, 1 );
    spawns = spawns function_bc701dcc4246cc00( spawnconfig, 1 );
    spawns = spawns function_5b505c2c65b99e17( spawnconfig );
    return spawns;
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x5508b599, Offset: 0x14f3
// Size: 0xaf
function private function_99ebfb65bb511d33( spawnconfig, spawntype )
{
    spawnlist = self;
    spawnarray = [];
    
    foreach ( entry in spawnlist )
    {
        spawnarray[ spawnarray.size ] = function_6fc89a46c743d31( entry, spawnconfig, spawntype );
    }
    
    if ( spawntype == 1 )
    {
        return spawnarray;
    }
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x93dd37b1, Offset: 0x15aa
// Size: 0x120
function private function_c6a1414213e4a36c( spawnconfig, spawntype )
{
    spawnlist = self;
    
    /#
        if ( getdvarint( @"hash_74281019987bc070", 0 ) == 1 )
        {
            return;
        }
    #/
    
    var_8d06a69542c052d9 = level.ssc.var_9cb7faebef4e013d[ spawnconfig.script_struct ];
    
    if ( !isdefined( var_8d06a69542c052d9 ) )
    {
        return;
    }
    
    foreach ( structindex in level.ssc.indexes )
    {
        if ( !arraycontains( spawnlist, structindex ) )
        {
            struct = level.ssc.structs[ structindex ];
            [[ var_8d06a69542c052d9 ]]( spawnconfig.script_struct, struct );
        }
    }
}

// Namespace structspawnconfig
// Params 3, eflags: 0x4
// Checksum 0x7bf06bb0, Offset: 0x16d2
// Size: 0xa4
function private function_6fc89a46c743d31( entry, spawnconfig, spawntype )
{
    switch ( spawntype )
    {
        case 3:
            break;
        case 2:
            /#
                debug_draw_single( spawnconfig.script_struct, entry );
            #/
            
            break;
        case 1:
            return function_a0c91cefd6f58bb( entry );
        case 0:
        default:
            ssc_spawn( spawnconfig.script_struct, entry );
            break;
    }
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x6131d21, Offset: 0x177e
// Size: 0x7e
function private function_fcacfbede1768cf6( spawnconfig, spawntype )
{
    spawnlist = self;
    spawnlist function_c7d4a72e795ea09b( spawnconfig, spawntype );
    
    if ( isdefined( level.ssc.var_2baf370af79db528[ spawnconfig.script_struct ] ) )
    {
        level thread [[ level.ssc.var_2baf370af79db528[ spawnconfig.script_struct ] ]]( spawnconfig.script_struct );
    }
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0xf88f3f23, Offset: 0x1804
// Size: 0x60
function private function_c7d4a72e795ea09b( spawnconfig, spawntype )
{
    spawnlist = self;
    debug_print( "Struct " + spawnconfig.script_struct + " spawned " + spawnlist.size + " times" + ( spawntype == 2 ? " in Debug mode" : "" ) );
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0xc4dc140f, Offset: 0x186c
// Size: 0x3f
function private function_5b505c2c65b99e17( spawnconfig )
{
    spawns = self;
    spawns = spawns function_7c322009a536615c( spawnconfig );
    spawns = spawns function_a9045e37bb3d3d9a( spawnconfig );
    spawns function_72167c9fd9facc93( "Force" );
    return spawns;
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0xefcf2, Offset: 0x18b4
// Size: 0x172
function private function_7edb2f365933c9a0( spawnconfig )
{
    spawns = self;
    
    if ( isdefined( spawnconfig.var_68581d0f2ef84cce ) )
    {
        foreach ( poirule in spawnconfig.var_68581d0f2ef84cce )
        {
            if ( !isdefined( poirule.poi_group_name ) )
            {
                group_name = "";
                
                foreach ( poi in poirule.poi_group )
                {
                    group_name += poi.poi_name + "_";
                }
                
                poirule.poi_group_name = group_name;
            }
            
            spawns = spawns function_242a3dd025752e94( poirule, spawnconfig );
        }
    }
    
    spawns = spawns function_c0c9582f82ae2726( spawnconfig );
    spawns function_72167c9fd9facc93( "POI" );
    return spawns;
}

// Namespace structspawnconfig
// Params 3, eflags: 0x4
// Checksum 0x45d9e8ad, Offset: 0x1a2f
// Size: 0xf1
function private function_d1626b01184c5c21( poirule, spawnconfig, groupindex )
{
    spawns = self;
    [ spawns, var_f4c5caf254b57111 ] = spawns function_52d7520974a3a20( function_5fcf8df9928b26b5( poirule.poi_group[ groupindex ] ), 1 );
    
    if ( var_f4c5caf254b57111.size == 0 )
    {
        debug_print_verbose( "Struct " + spawnconfig.script_struct + " has 0 spawns in " + poirule.poi_group[ groupindex ] );
        return spawns;
    }
    
    var_449736929a56bdc = var_f4c5caf254b57111 function_4ed6e1d9c13f0669( poirule, groupindex );
    var_449736929a56bdc = var_449736929a56bdc function_b52e0074c7482791( poirule );
    var_449736929a56bdc = var_449736929a56bdc function_8b94c7f5ac63660f( poirule );
    spawns = function_dd40ba138bc3dba2( spawns, var_449736929a56bdc );
    function_72167c9fd9facc93( "POI Single - " + poirule.poi_group[ groupindex ] );
    return spawns;
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x22a9ef3d, Offset: 0x1b29
// Size: 0x1d5
function private function_242a3dd025752e94( poirule, spawnconfig )
{
    spawns = self;
    [ spawns, var_f4c5caf254b57111 ] = spawns function_52d7520974a3a20( function_85e5a1014025e13f( poirule.poi_group ), 1 );
    
    if ( var_f4c5caf254b57111.size == 0 )
    {
        var_f4c5caf254b57111 = function_85e5a1014025e13f( poirule.poi_group );
        
        if ( var_f4c5caf254b57111.size == 0 )
        {
            debug_print_verbose( "Struct " + spawnconfig.script_struct + " has 0 spawns in " + poirule.poi_group_name + "poi group" );
            return spawns;
        }
    }
    
    var_449736929a56bdc = var_f4c5caf254b57111 function_bff0595e8be6afd5( poirule );
    
    if ( poirule.var_7924584ff3e24345 > 0 || poirule.var_c6db75c5f0ca14e3 > 0 )
    {
        var_449736929a56bdc = var_449736929a56bdc function_b52e0074c7482791( poirule, poirule.var_7924584ff3e24345, 0 );
        var_449736929a56bdc = var_449736929a56bdc function_8b94c7f5ac63660f( poirule, poirule.var_c6db75c5f0ca14e3, 0 );
        var_c8f9db9e9e6f1b24 = poirule.poi_count_weight[ 0 ].spawn_count;
        
        if ( var_c8f9db9e9e6f1b24 > -1 && var_449736929a56bdc.size < var_c8f9db9e9e6f1b24 )
        {
            var_449736929a56bdc = var_449736929a56bdc function_bff0595e8be6afd5( poirule );
            var_449736929a56bdc = var_449736929a56bdc function_b52e0074c7482791( poirule, poirule.var_283f77888a78aa3f, 1 );
            var_449736929a56bdc = var_449736929a56bdc function_8b94c7f5ac63660f( poirule, poirule.var_d8339e4a8a472b59, 1 );
        }
    }
    else
    {
        var_449736929a56bdc = var_449736929a56bdc function_b52e0074c7482791( poirule, poirule.var_283f77888a78aa3f );
        var_449736929a56bdc = var_449736929a56bdc function_8b94c7f5ac63660f( poirule, poirule.var_d8339e4a8a472b59 );
    }
    
    spawns = function_dd40ba138bc3dba2( spawns, var_449736929a56bdc );
    function_72167c9fd9facc93( "POI Group - " + poirule.poi_group_name );
    return spawns;
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0xb78500cf, Offset: 0x1d07
// Size: 0x105
function private function_c0c9582f82ae2726( spawnconfig )
{
    spawns = self;
    
    if ( !utility::issharedfuncdefined( #"poi", #"isSystemActive" ) || ![[ utility::getsharedfunc( #"poi", #"isSystemActive" ) ]]() )
    {
        debug_print_verbose( "Global POI rules are being skipped as POI system is disabled" );
        return spawns;
    }
    
    foreach ( poiname in level.poi_names )
    {
        var_b9b61dd0feecce42 = [[ utility::getsharedfunc( #"poi", #"hash_274d8f14575dd2c1" ) ]]( poiname );
        spawns = spawns function_89a3618a366ecaa3( spawnconfig, var_b9b61dd0feecce42 );
    }
    
    return spawns;
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0xb9785729, Offset: 0x1e15
// Size: 0xe9
function private function_89a3618a366ecaa3( spawnconfig, poiname )
{
    spawns = self;
    possiblespawns = function_5fcf8df9928b26b5( poiname );
    
    if ( !isdefined( possiblespawns ) || possiblespawns.size == 0 )
    {
        return spawns;
    }
    
    [ spawns, var_449736929a56bdc ] = spawns function_52d7520974a3a20( possiblespawns, 1 );
    
    if ( isdefined( spawnconfig.var_1be7dee21190ac79 ) )
    {
        var_449736929a56bdc = var_449736929a56bdc function_2e20b3526f2ca966( possiblespawns, poiname, spawnconfig.var_1be7dee21190ac79 );
    }
    
    var_449736929a56bdc = var_449736929a56bdc function_7f3502a8f45c662b( possiblespawns, spawnconfig.var_6a826a3eb103722b ?? -1 );
    var_449736929a56bdc = var_449736929a56bdc function_bd87eae36b20fe2d( spawnconfig.var_a8d5527927c80a2d ?? -1 );
    spawns = function_dd40ba138bc3dba2( spawns, var_449736929a56bdc );
    spawns function_72167c9fd9facc93( "POI Global Single - " + poiname );
    return spawns;
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0xbe112d20, Offset: 0x1f07
// Size: 0x1f4
function private function_ae459edc4279238b( spawnconfig )
{
    spawns = self;
    spawns = spawns function_7a66294c04ef96c0( spawnconfig );
    possiblespawns = level.ssc.indexes;
    spawns = spawns function_7f3502a8f45c662b( possiblespawns, spawnconfig.var_6cd2597c1e9eb3b3 ?? -1 );
    spawns = spawns function_bd87eae36b20fe2d( spawnconfig.var_e5ec4086fe7f1be5 ?? -1 );
    
    if ( spawnconfig.var_556c46d11574c877 > 0 || spawnconfig.var_3987c177812227c1 > 0 )
    {
        spawns = spawns function_5d888bf67a41c4de( possiblespawns, spawnconfig.var_556c46d11574c877, undefined, spawnconfig.var_6cd2597c1e9eb3b3, spawnconfig.var_5dce8d5b724a09ce, 0 );
        spawns = spawns function_1e3d6b6fc4e45e4c( possiblespawns, spawnconfig.var_3987c177812227c1, undefined, spawnconfig.var_6cd2597c1e9eb3b3, spawnconfig.var_5dce8d5b724a09ce, 0 );
        
        if ( spawnconfig.var_6cd2597c1e9eb3b3 > -1 && spawns.size < spawnconfig.var_6cd2597c1e9eb3b3 )
        {
            spawns = spawns function_7f3502a8f45c662b( possiblespawns, spawnconfig.var_6cd2597c1e9eb3b3 );
            spawns = spawns function_5d888bf67a41c4de( possiblespawns, spawnconfig.var_b32905ce7447fd, undefined, spawnconfig.var_6cd2597c1e9eb3b3, spawnconfig.var_5dce8d5b724a09ce );
            spawns = spawns function_1e3d6b6fc4e45e4c( possiblespawns, spawnconfig.var_715b2669956e715b, undefined, spawnconfig.var_6cd2597c1e9eb3b3, spawnconfig.var_5dce8d5b724a09ce );
        }
    }
    else
    {
        spawns = spawns function_5d888bf67a41c4de( possiblespawns, spawnconfig.var_b32905ce7447fd, undefined, spawnconfig.var_6cd2597c1e9eb3b3, spawnconfig.var_5dce8d5b724a09ce );
        spawns = spawns function_1e3d6b6fc4e45e4c( possiblespawns, spawnconfig.var_715b2669956e715b, undefined, spawnconfig.var_6cd2597c1e9eb3b3, spawnconfig.var_5dce8d5b724a09ce );
    }
    
    spawns function_72167c9fd9facc93( "Global" );
    return spawns;
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x523dcfe0, Offset: 0x2104
// Size: 0xdd
function private function_bc701dcc4246cc00( spawnconfig, hardonly )
{
    spawns = self;
    
    if ( function_22bdbbccaf611486( spawnconfig.var_7738a99dbc94dab8, hardonly ) && isdefined( spawnconfig.circle_final ) )
    {
        spawns = spawns function_e225f51b07d86b48( spawnconfig.var_ea4254eb75484a85, spawnconfig.circle_final );
    }
    
    if ( function_22bdbbccaf611486( spawnconfig.var_34451359e0300f9a, hardonly ) && isdefined( spawnconfig.circle_final ) )
    {
        spawns = spawns function_8c4fe57545bdac0a( spawnconfig.var_5d84c85fb72a3453, spawnconfig.circle_final );
    }
    
    hardstring = hardonly ? " - Hard Only" : "";
    spawns function_72167c9fd9facc93( "BR" + hardstring );
    return spawns;
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x3b2ffa6b, Offset: 0x21ea
// Size: 0x494
function private function_d6c41239c5afa351( spawnconfig, hardonly )
{
    spawns = self;
    
    if ( function_22bdbbccaf611486( spawnconfig.var_f5b91ca545b22030, hardonly ) && isdefined( spawnconfig.var_f13026c1ca246ed ) )
    {
        foreach ( entry in spawnconfig.var_f13026c1ca246ed )
        {
            spawns = spawns function_d31accf06686f054( entry.spawn_count ?? 0, entry.spawn_tag );
        }
    }
    
    if ( function_22bdbbccaf611486( spawnconfig.var_38d10df2e6745022, hardonly ) && isdefined( spawnconfig.var_664ebfa7e5f55aeb ) )
    {
        foreach ( entry in spawnconfig.var_664ebfa7e5f55aeb )
        {
            spawns = spawns function_61c3fafad8f0cfa6( entry.spawn_count ?? 0, entry.spawn_tag );
        }
    }
    
    if ( function_22bdbbccaf611486( spawnconfig.var_218e3c03ee50f102, hardonly ) && isdefined( spawnconfig.var_1f14d61061f6ea0b ) )
    {
        foreach ( entry in spawnconfig.var_1f14d61061f6ea0b )
        {
            spawns = spawns function_f05aae74f3145251( entry.spawn_distance, entry.script_struct );
        }
    }
    
    if ( function_22bdbbccaf611486( spawnconfig.var_4cbc68736371b210, hardonly ) && isdefined( spawnconfig.var_6cbba6e66828f10d ) )
    {
        foreach ( entry in spawnconfig.var_6cbba6e66828f10d )
        {
            spawns = spawns function_c6d261f5d8416f2f( entry.spawn_distance, entry.script_struct );
        }
    }
    
    possiblespawns = level.ssc.indexes;
    
    if ( function_22bdbbccaf611486( spawnconfig.var_ddc3c603bde07a47, hardonly ) && isdefined( spawnconfig.var_fd661b3015c7fd4 ) )
    {
        foreach ( entry in spawnconfig.var_fd661b3015c7fd4 )
        {
            spawns = spawns function_5d888bf67a41c4de( possiblespawns, entry.spawn_distance, entry.script_struct );
        }
    }
    
    if ( function_22bdbbccaf611486( spawnconfig.var_e6776eeb171d41c5, hardonly ) && isdefined( spawnconfig.var_62ffb41bfc89e6c6 ) )
    {
        foreach ( entry in spawnconfig.var_62ffb41bfc89e6c6 )
        {
            spawns = spawns function_1e3d6b6fc4e45e4c( possiblespawns, entry.spawn_distance, entry.script_struct );
        }
    }
    
    hardstring = hardonly ? " - Hard Only" : "";
    spawns function_72167c9fd9facc93( "Base" + hardstring );
    return spawns;
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0xedb3ddc, Offset: 0x2687
// Size: 0x41
function private function_72167c9fd9facc93( rule )
{
    spawns = self;
    debug_print_all( "After " + rule + ", spawns has " + spawns.size + " entries" );
    function_db58f4de5b0fd46f( spawns );
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x24d066dd, Offset: 0x26d0
// Size: 0x119
function private function_7c322009a536615c( spawnconfig )
{
    spawns = self;
    
    if ( !isdefined( spawnconfig.force_spawn_list ) || spawnconfig.force_spawn_list.size == 0 )
    {
        return spawns;
    }
    
    spawnlist = [];
    
    foreach ( entry in spawnconfig.force_spawn_list )
    {
        spawnlist[ entry.spawn_number ] = entry.spawn_number;
    }
    
    notfound = function_44c7c098cd4e39d7( spawnlist, level.ssc.indexes );
    spawnlist = function_44c7c098cd4e39d7( spawnlist, notfound );
    function_4baf28f9cc882214( spawnlist, notfound );
    spawns = function_dd40ba138bc3dba2( spawns, spawnlist );
    return spawns;
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x776af4a, Offset: 0x27f2
// Size: 0x7b
function private function_4baf28f9cc882214( spawnlist, notfound )
{
    spawns = self;
    newentries = function_44c7c098cd4e39d7( spawnlist, spawns );
    debug_print_all( "Rule Force - Added " + newentries.size + " new spawns" );
    function_db58f4de5b0fd46f( newentries );
    
    if ( notfound.size != 0 )
    {
        debug_print_all( "Rule Force - Not Found contained " + newentries.size + " spawns" );
        function_db58f4de5b0fd46f( notfound );
    }
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0xbb1c6e15, Offset: 0x2875
// Size: 0xe8
function private function_a9045e37bb3d3d9a( spawnconfig )
{
    spawns = self;
    
    if ( !isdefined( spawnconfig.force_block_list ) || spawnconfig.force_block_list.size == 0 )
    {
        return spawns;
    }
    
    blocklist = [];
    
    foreach ( entry in spawnconfig.force_block_list )
    {
        blocklist[ entry.spawn_number ] = entry.spawn_number;
    }
    
    blocklist function_451361f0de0aa546();
    spawns = spawns util_remove_array( blocklist );
    return spawns;
}

// Namespace structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0x63199c6d, Offset: 0x2966
// Size: 0x53
function private function_451361f0de0aa546()
{
    blocklist = self;
    newentries = function_44c7c098cd4e39d7( blocklist, level.ssc.exclude );
    debug_print_all( "Rule Block - Blocked " + newentries.size + " new spawns" );
    function_db58f4de5b0fd46f( newentries );
}

// Namespace structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0x59436efb, Offset: 0x29c1
// Size: 0xb1
function private function_81eefdbb6e2fcbae()
{
    spawnconfig = self;
    
    if ( !isdefined( spawnconfig.var_31d9ad90e2ef10f9 ) || spawnconfig.var_31d9ad90e2ef10f9.size == 0 )
    {
        return spawnconfig;
    }
    
    foreach ( pool in spawnconfig.var_31d9ad90e2ef10f9 )
    {
        spawnconfig = spawnconfig function_27ad113c31c1c93b( pool );
    }
    
    return spawnconfig;
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0xeb3f1feb, Offset: 0x2a7b
// Size: 0x12b
function private function_27ad113c31c1c93b( pool )
{
    spawnconfig = self;
    
    if ( pool.spawn_list.size == 0 )
    {
        return spawnconfig;
    }
    
    selectedcount = pool.spawn_count;
    spawnpool = arrayrandomize( pool.spawn_list );
    selectedspawns = utility::array_slice( spawnpool, 0, selectedcount );
    unselectedspawns = utility::array_slice( spawnpool, selectedcount, spawnpool.size );
    
    if ( pool.force_spawn )
    {
        if ( !isdefined( spawnconfig.force_spawn_list ) )
        {
            spawnconfig.force_spawn_list = selectedspawns;
        }
        else
        {
            spawnconfig.force_spawn_list = arraycombineunique( spawnconfig.force_spawn_list, selectedspawns );
        }
    }
    
    if ( pool.force_block )
    {
        if ( !isdefined( spawnconfig.force_block_list ) )
        {
            spawnconfig.force_block_list = selectedspawns;
        }
        else
        {
            spawnconfig.force_block_list = arraycombineunique( spawnconfig.force_block_list, unselectedspawns );
        }
    }
    
    pool function_9c1146cb07b49a02( selectedspawns, unselectedspawns );
    return spawnconfig;
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0xbb23e06d, Offset: 0x2baf
// Size: 0x18e
function private function_9c1146cb07b49a02( spawnlist, blocklist )
{
    pool = self;
    debug_print_all( "Spawn Pool" );
    
    if ( pool.force_spawn )
    {
        debug_print_all( "Added " + spawnlist.size + " to Force Spawn List" );
        indexes = [];
        
        foreach ( entry in spawnlist )
        {
            indexes[ entry.spawn_number ] = entry.spawn_number;
        }
        
        function_db58f4de5b0fd46f( indexes );
    }
    
    if ( pool.force_block )
    {
        debug_print_all( "Added " + blocklist.size + " to Force Block List" );
        indexes = [];
        
        foreach ( entry in blocklist )
        {
            indexes[ entry.spawn_number ] = entry.spawn_number;
        }
        
        function_db58f4de5b0fd46f( indexes );
    }
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x3d629940, Offset: 0x2d45
// Size: 0x1de
function private function_c6d194b1b72767a4( weights, spawncount )
{
    if ( isdefined( spawncount ) )
    {
        foreach ( entry in weights )
        {
            if ( entry.spawn_count == spawncount )
            {
                return spawncount;
            }
        }
    }
    
    totalweight = 0;
    
    foreach ( entry in weights )
    {
        if ( isdefined( entry.spawn_weight ) )
        {
            totalweight += entry.spawn_weight;
        }
    }
    
    randomweight = 0;
    
    if ( totalweight > 0 )
    {
        randomweight = randomint( totalweight );
    }
    
    foreach ( entry in weights )
    {
        if ( isdefined( entry.spawn_weight ) )
        {
            randomweight -= entry.spawn_weight;
            
            if ( randomweight <= 0 )
            {
                return entry.spawn_count;
            }
        }
    }
    
    return weights[ weights.size - 1 ].spawn_count;
}

// Namespace structspawnconfig
// Params 3, eflags: 0x4
// Checksum 0x960e1220, Offset: 0x2f2c
// Size: 0x176
function private function_2e20b3526f2ca966( possiblespawns, poigroupname, weights )
{
    spawns = self;
    
    if ( !isdefined( weights ) || weights.size == 0 )
    {
        debug_print_verbose( "POI Group" + poigroupname + " has no weights set" );
        return spawns;
    }
    
    spawncount = level.ssc.weights[ poigroupname ];
    level.ssc.weights[ poigroupname ] = function_c6d194b1b72767a4( weights, spawncount );
    
    if ( level.ssc.weights[ poigroupname ] < 0 )
    {
        debug_print_all( "Rule Weights - The chosen count weight for POI " + poigroupname + " was below 0. Setting to 0" );
        level.ssc.weights[ poigroupname ] = 0;
    }
    
    spawndifference = level.ssc.weights[ poigroupname ] - spawns.size;
    
    if ( spawndifference < 0 )
    {
        spawns = function_87de98d607328ffb( spawns, abs( spawndifference ), 0 );
    }
    else if ( spawndifference > 0 )
    {
        newspawns = function_84f4aaba31aba342( possiblespawns, spawndifference );
        spawns = function_dd40ba138bc3dba2( spawns, newspawns );
    }
    
    debug_print_all( "Rule Weights - Weight rolled for POI " + poigroupname + " is " + level.ssc.weights[ poigroupname ] + " and spawn count was changed by " + spawndifference );
    return spawns;
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0xf64e1c60, Offset: 0x30ab
// Size: 0x9a
function private function_bff0595e8be6afd5( poirule )
{
    poispawns = self;
    
    if ( !( isdefined( poirule.poi_group ) && isdefined( poirule.poi_group_name ) && isdefined( poirule.poi_count_weight ) ) || poirule.poi_count_weight.size == 0 )
    {
        return poispawns;
    }
    
    possiblespawns = function_85e5a1014025e13f( poirule.poi_group );
    poispawns = poispawns function_2e20b3526f2ca966( possiblespawns, poirule.poi_group_name, poirule.poi_count_weight );
    return poispawns;
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x868d6ad8, Offset: 0x314e
// Size: 0x9d
function private function_4ed6e1d9c13f0669( poirule, groupindex )
{
    poispawns = self;
    
    if ( !( isdefined( poirule.poi_group[ groupindex ] ) && isdefined( poirule.poi_count_weight ) ) || poirule.poi_count_weight.size == 0 )
    {
        return poispawns;
    }
    
    possiblespawns = function_5fcf8df9928b26b5( poirule.poi_group[ groupindex ] );
    poispawns = poispawns function_2e20b3526f2ca966( possiblespawns, poirule.poi_group[ groupindex ], poirule.poi_count_weight );
    return poispawns;
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x68ebad35, Offset: 0x31f4
// Size: 0x78
function private function_7a66294c04ef96c0( spawnconfig )
{
    spawns = self;
    
    if ( !isdefined( spawnconfig.map_count_weight ) || spawnconfig.map_count_weight.size == 0 )
    {
        return spawns;
    }
    
    possiblespawns = level.ssc.indexes;
    spawns = spawns function_2e20b3526f2ca966( possiblespawns, "all", spawnconfig.map_count_weight );
    return spawns;
}

// Namespace structspawnconfig
// Params 7, eflags: 0x4
// Checksum 0xc344bc69, Offset: 0x3275
// Size: 0x21d
function private function_dcafa9aa6b3a831( possiblespawns, dist, var_3074666fd773963, otherstruct, mincount, var_69854d38a2e89e66, var_829eaefe9037d96c )
{
    spawns = self;
    
    if ( !isdefined( dist ) || dist == 0 )
    {
        return spawns;
    }
    
    possiblespawns = function_44c7c098cd4e39d7( possiblespawns, level.ssc.exclude );
    possiblespawns = function_44c7c098cd4e39d7( possiblespawns, spawns );
    ruledistsq = dist * dist;
    spawntotal = spawns.size + possiblespawns.size;
    iterations = 0;
    removedspawns = [];
    goodspawns = [];
    
    while ( goodspawns.size != spawns.size )
    {
        removecandidates = [];
        testspawns = spawns function_9965e28c2b20a355( otherstruct );
        var_a441491413250691 = function_44c7c098cd4e39d7( spawns, goodspawns );
        
        if ( testspawns.size == 0 )
        {
            break;
        }
        
        [ removecandidates, goodspawns, iterations ] = testspawns function_bc97a263752dd47( var_a441491413250691, goodspawns, ruledistsq, var_3074666fd773963, iterations );
        [ spawns, possiblespawns, removedspawns ] = spawns function_e152ad6de46734cd( removecandidates, possiblespawns, removedspawns, var_829eaefe9037d96c );
    }
    
    while ( removedspawns.size + goodspawns.size < spawntotal )
    {
        removecandidates = [];
        testspawns = spawns function_9965e28c2b20a355( otherstruct );
        
        if ( testspawns.size == 0 )
        {
            break;
        }
        
        [ removecandidates, goodspawns, iterations ] = testspawns function_bc97a263752dd47( possiblespawns, goodspawns, ruledistsq, var_3074666fd773963, iterations );
        [ var_501dc081b0f8b25, possiblespawns, removedspawns ] = possiblespawns function_e152ad6de46734cd( removecandidates, possiblespawns, removedspawns, var_829eaefe9037d96c );
    }
    
    if ( var_69854d38a2e89e66 )
    {
        [ spawns, removedspawns ] = spawns function_1f05fa8773f0f499( removedspawns, goodspawns, mincount );
    }
    
    function_5465615f2e044a4d( removedspawns, iterations, otherstruct );
    return spawns;
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0xd095ede9, Offset: 0x349b
// Size: 0x7e
function private function_9965e28c2b20a355( otherstruct )
{
    spawns = self;
    
    if ( isdefined( otherstruct ) )
    {
        assert( isdefined( level.ssc.spawns[ otherstruct ] ), "<dev string:x49>" + otherstruct + "<dev string:x52>" );
        return level.ssc.spawns[ otherstruct ];
    }
    
    return function_44c7c098cd4e39d7( spawns, level.ssc.exclude );
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0xd612cd24, Offset: 0x3522
// Size: 0x44
function private function_2e0a93450adcba65( struct, testindex )
{
    if ( isint( struct ) )
    {
        if ( struct == testindex )
        {
            return;
        }
        
        return function_a0c91cefd6f58bb( struct ).origin;
    }
    
    return struct.origin;
}

// Namespace structspawnconfig
// Params 5, eflags: 0x4
// Checksum 0x36dbc44d, Offset: 0x356f
// Size: 0x1a1
function private function_bc97a263752dd47( var_a441491413250691, goodspawns, ruledistsq, var_3074666fd773963, iterations )
{
    spawns = self;
    highestscore = 0;
    removecandidates = [];
    
    foreach ( entry in var_a441491413250691 )
    {
        [ removeindexes, iterations ] = spawns [[ var_3074666fd773963 ]]( entry, ruledistsq, iterations );
        
        if ( isdefined( removeindexes ) )
        {
            removecandidates[ entry ] = [];
            removecandidates[ entry ] = removeindexes;
            
            if ( removeindexes.size > highestscore )
            {
                highestscore = removeindexes.size;
            }
            
            continue;
        }
        
        if ( isdefined( goodspawns ) )
        {
            goodspawns[ entry ] = entry;
        }
    }
    
    foreach ( key, value in removecandidates )
    {
        if ( value.size == highestscore )
        {
            removecandidates[ key ] = key;
            continue;
        }
        
        removecandidates[ key ] = undefined;
    }
    
    return [ removecandidates, goodspawns, iterations ];
}

// Namespace structspawnconfig
// Params 3, eflags: 0x4
// Checksum 0x4a6cee06, Offset: 0x3719
// Size: 0x10c
function private function_fb31f9fd3575351a( index, minimumsq, iterations )
{
    spawns = self;
    origin = function_a0c91cefd6f58bb( index ).origin;
    removelist = undefined;
    
    foreach ( entry in spawns )
    {
        iterations++;
        testorigin = function_2e0a93450adcba65( entry, index );
        
        if ( !isdefined( testorigin ) )
        {
            continue;
        }
        
        testdistsq = distancesquared( origin, testorigin );
        
        if ( testdistsq < minimumsq )
        {
            if ( !isdefined( removelist ) )
            {
                removelist = [];
            }
            
            removelist[ entry ] = entry;
        }
    }
    
    return [ removelist, iterations ];
}

// Namespace structspawnconfig
// Params 3, eflags: 0x4
// Checksum 0x49bc92b6, Offset: 0x382e
// Size: 0x114
function private function_92464637fc387150( index, maximumsq, iterations )
{
    spawns = self;
    origin = function_a0c91cefd6f58bb( index ).origin;
    
    foreach ( entry in spawns )
    {
        iterations++;
        testorigin = function_2e0a93450adcba65( entry, index );
        
        if ( !isdefined( testorigin ) )
        {
            continue;
        }
        
        testdistsq = distancesquared( origin, testorigin );
        
        if ( testdistsq > maximumsq )
        {
            continue;
        }
        
        return [ undefined, iterations ];
    }
    
    removelist = [];
    removelist[ index ] = index;
    return [ removelist, iterations ];
}

// Namespace structspawnconfig
// Params 4, eflags: 0x4
// Checksum 0x7e4f02fc, Offset: 0x394b
// Size: 0xa5
function private function_e152ad6de46734cd( removearray, possiblespawns, removedspawns, var_829eaefe9037d96c )
{
    spawns = self;
    
    if ( removearray.size == 0 )
    {
        return [ spawns, possiblespawns, removedspawns ];
    }
    
    spawns = spawns util_remove_array( removearray, var_829eaefe9037d96c );
    possiblespawns = function_44c7c098cd4e39d7( possiblespawns, removearray );
    newspawns = function_84f4aaba31aba342( possiblespawns, removearray.size );
    spawns = function_dd40ba138bc3dba2( spawns, newspawns );
    removedspawns = function_dd40ba138bc3dba2( removedspawns, removearray );
    return [ spawns, possiblespawns, removedspawns ];
}

// Namespace structspawnconfig
// Params 3, eflags: 0x4
// Checksum 0x92423fd3, Offset: 0x39f9
// Size: 0x5b
function private function_5465615f2e044a4d( removedspawns, iterations, otherstruct )
{
    debug_print_all( "Rule Dist - There were " + removedspawns.size + " spawns removed over " + iterations + " iterations" );
    
    if ( isdefined( otherstruct ) )
    {
        debug_print_all( "Rule Dist - The other struct is " + otherstruct );
    }
    
    function_db58f4de5b0fd46f( removedspawns );
}

// Namespace structspawnconfig
// Params 3, eflags: 0x4
// Checksum 0x63a33fc6, Offset: 0x3a5c
// Size: 0x10c
function private function_1f05fa8773f0f499( removearray, goodspawns, mincount )
{
    spawns = self;
    
    if ( isdefined( mincount ) )
    {
        if ( spawns.size < mincount )
        {
            var_8cfa15c2231ee7fe = [];
            var_ba264d6a753b8e25 = goodspawns util_remove_array( spawns );
            
            for ( i = 0; i < mincount - spawns.size ; i++ )
            {
                randomspawn = undefined;
                
                if ( var_ba264d6a753b8e25.size > 0 )
                {
                    randomspawn = util_array_random( var_ba264d6a753b8e25 );
                    
                    if ( isdefined( randomspawn ) )
                    {
                        var_ba264d6a753b8e25 = var_ba264d6a753b8e25 function_669d31877820d5c6( var_ba264d6a753b8e25, randomspawn );
                    }
                }
                else
                {
                    randomspawn = util_array_random( removearray );
                    
                    if ( isdefined( randomspawn ) )
                    {
                        removearray = removearray function_669d31877820d5c6( removearray, randomspawn );
                    }
                }
                
                if ( isdefined( randomspawn ) )
                {
                    var_8cfa15c2231ee7fe[ randomspawn ] = randomspawn;
                }
            }
            
            debug_print( "Rule Dist - There are " + var_8cfa15c2231ee7fe.size + " spawns that break the distance rule being spawned. These were chosen to spawn anyways to ensure that the min spawn amount rule is followed." );
            function_db58f4de5b0fd46f( var_8cfa15c2231ee7fe );
        }
    }
    
    newspawns = function_dd40ba138bc3dba2( spawns, var_8cfa15c2231ee7fe );
    return [ newspawns, removearray ];
}

// Namespace structspawnconfig
// Params 6, eflags: 0x4
// Checksum 0x95d402bb, Offset: 0x3b71
// Size: 0x5f
function private function_5d888bf67a41c4de( possiblespawns, dist, otherstruct, mincount, var_69854d38a2e89e66, var_829eaefe9037d96c )
{
    spawns = self;
    spawns = spawns function_dcafa9aa6b3a831( possiblespawns, dist, &function_fb31f9fd3575351a, otherstruct, mincount, var_69854d38a2e89e66, var_829eaefe9037d96c );
    return spawns;
}

// Namespace structspawnconfig
// Params 6, eflags: 0x4
// Checksum 0xd41cb7f3, Offset: 0x3bd9
// Size: 0xab
function private function_a980bcd77feb406a( possiblespawns, dist, groupstring = "Group", mincount, var_69854d38a2e89e66, var_829eaefe9037d96c )
{
    spawns = self;
    [ spawns, currentspawns ] = spawns function_52d7520974a3a20( possiblespawns );
    spawns = currentspawns function_5d888bf67a41c4de( possiblespawns, dist, undefined, mincount, var_69854d38a2e89e66, var_829eaefe9037d96c );
    debug_print_all( "Rule Dist Group Min - " + groupstring + " has ended with " + spawns.size + " spawns" );
    return spawns;
}

// Namespace structspawnconfig
// Params 3, eflags: 0x4
// Checksum 0xb590128, Offset: 0x3c8d
// Size: 0xba
function private function_b52e0074c7482791( poirule, dist, var_829eaefe9037d96c )
{
    spawns = self;
    
    if ( !( isdefined( poirule.poi_group_name ) && isdefined( poirule.poi_group ) && isdefined( poirule.var_283f77888a78aa3f ) ) )
    {
        return spawns;
    }
    
    possiblespawns = function_85e5a1014025e13f( poirule.poi_group );
    spawns = spawns function_a980bcd77feb406a( possiblespawns, dist, "POI Group" + poirule.poi_group_name, poirule.poi_count_weight[ 0 ].spawn_count, poirule.var_48ff6c68fd5638c1, var_829eaefe9037d96c );
    return spawns;
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x62044786, Offset: 0x3d50
// Size: 0x5d
function private function_f05aae74f3145251( dist, tag )
{
    spawns = self;
    possiblespawns = function_6e2e28966f090935( level.ssc.indexes, tag );
    spawns = spawns function_a980bcd77feb406a( possiblespawns, dist, "Tag " + tag );
    return spawns;
}

// Namespace structspawnconfig
// Params 6, eflags: 0x4
// Checksum 0x95d402bb, Offset: 0x3db6
// Size: 0x5f
function private function_1e3d6b6fc4e45e4c( possiblespawns, dist, otherstruct, mincount, var_69854d38a2e89e66, var_829eaefe9037d96c )
{
    spawns = self;
    spawns = spawns function_dcafa9aa6b3a831( possiblespawns, dist, &function_92464637fc387150, otherstruct, mincount, var_69854d38a2e89e66, var_829eaefe9037d96c );
    return spawns;
}

// Namespace structspawnconfig
// Params 6, eflags: 0x4
// Checksum 0xa5a55ccd, Offset: 0x3e1e
// Size: 0xad
function private function_ee44aae670e3fee0( possiblespawns, dist, groupstring = "Group", mincount, var_69854d38a2e89e66, var_829eaefe9037d96c )
{
    spawns = self;
    [ spawns, currentspawns ] = spawns function_52d7520974a3a20( possiblespawns, 1 );
    spawns = currentspawns function_1e3d6b6fc4e45e4c( possiblespawns, dist, undefined, mincount, var_69854d38a2e89e66, var_829eaefe9037d96c );
    debug_print_all( "Rule Dist Group Max - " + groupstring + " has ended with " + spawns.size + " spawns" );
    return spawns;
}

// Namespace structspawnconfig
// Params 3, eflags: 0x4
// Checksum 0xd432964f, Offset: 0x3ed4
// Size: 0xcb
function private function_8b94c7f5ac63660f( poirule, dist, var_829eaefe9037d96c )
{
    spawns = self;
    
    if ( !( isdefined( poirule.poi_group_name ) && isdefined( poirule.poi_group ) && isdefined( poirule.var_d8339e4a8a472b59 ) ) || poirule.var_d8339e4a8a472b59 == 0 )
    {
        return spawns;
    }
    
    possiblespawns = function_85e5a1014025e13f( poirule.poi_group );
    spawns = spawns function_ee44aae670e3fee0( possiblespawns, dist, "POI " + poirule.poi_group_name, poirule.poi_count_weight[ 0 ].spawn_count, poirule.var_48ff6c68fd5638c1, var_829eaefe9037d96c );
    return spawns;
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0xee4644ff, Offset: 0x3fa8
// Size: 0x5d
function private function_c6d261f5d8416f2f( dist, tag )
{
    spawns = self;
    possiblespawns = function_6e2e28966f090935( level.ssc.indexes, tag );
    spawns = spawns function_ee44aae670e3fee0( possiblespawns, dist, "Tag " + tag );
    return spawns;
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0xf925f871, Offset: 0x400e
// Size: 0x98
function private function_7f3502a8f45c662b( possiblespawns, minimum )
{
    spawns = self;
    
    if ( !isdefined( minimum ) || minimum == -1 || spawns.size >= minimum )
    {
        return spawns;
    }
    
    possiblespawns = function_44c7c098cd4e39d7( possiblespawns, spawns );
    addcount = minimum - spawns.size;
    newspawns = function_84f4aaba31aba342( possiblespawns, addcount );
    spawns = function_dd40ba138bc3dba2( spawns, newspawns );
    debug_print_all( "Rule Count Min - " + newspawns.size + " spawns were added" );
    function_db58f4de5b0fd46f( newspawns );
    return spawns;
}

// Namespace structspawnconfig
// Params 3, eflags: 0x4
// Checksum 0xef071eb9, Offset: 0x40af
// Size: 0x94
function private function_8212102629a956ef( possiblespawns, minimum, groupstring )
{
    spawns = self;
    [ spawns, currentspawns ] = spawns function_52d7520974a3a20( possiblespawns, 1 );
    newspawns = currentspawns function_7f3502a8f45c662b( possiblespawns, minimum );
    spawns = function_dd40ba138bc3dba2( spawns, newspawns );
    debug_print_all( "Rule Count Group Min - " + groupstring + " has ended with " + newspawns.size + " spawns" );
    return spawns;
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x73810b2e, Offset: 0x414c
// Size: 0x5d
function private function_d31accf06686f054( minimum, tag )
{
    spawns = self;
    possiblespawns = function_6e2e28966f090935( level.ssc.indexes, tag );
    spawns = spawns function_8212102629a956ef( possiblespawns, minimum, "Tag " + tag );
    return spawns;
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x93142d1a, Offset: 0x41b2
// Size: 0x5d
function private function_e225f51b07d86b48( minimum, circlefinal )
{
    spawns = self;
    possiblespawns = function_4c109a22ab8a37c7( level.ssc.indexes, circlefinal );
    spawns = spawns function_8212102629a956ef( possiblespawns, minimum, "Circle " + circlefinal );
    return spawns;
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x7a3082ad, Offset: 0x4218
// Size: 0x68
function private function_bd87eae36b20fe2d( maximum )
{
    spawns = self;
    
    if ( !isdefined( maximum ) || maximum == -1 || spawns.size <= maximum )
    {
        return spawns;
    }
    
    removecount = spawns.size - maximum;
    spawns = function_87de98d607328ffb( spawns, removecount );
    debug_print_all( "Rule Count Max - " + removecount + " spawns were removed" );
    return spawns;
}

// Namespace structspawnconfig
// Params 3, eflags: 0x4
// Checksum 0x2ace150b, Offset: 0x4289
// Size: 0x93
function private function_5e8089263a865109( possiblespawns, maximum, groupstring )
{
    spawns = self;
    [ spawns, currentspawns ] = spawns function_52d7520974a3a20( possiblespawns, 1 );
    newspawns = currentspawns function_bd87eae36b20fe2d( maximum );
    spawns = function_dd40ba138bc3dba2( spawns, newspawns );
    debug_print_all( "Rule Count Group Max - " + groupstring + " has ended with " + newspawns.size + " spawns" );
    return spawns;
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0xffc30857, Offset: 0x4325
// Size: 0x5d
function private function_61c3fafad8f0cfa6( maximum, tag )
{
    spawns = self;
    possiblespawns = function_6e2e28966f090935( level.ssc.indexes, tag );
    spawns = spawns function_5e8089263a865109( possiblespawns, maximum, "Tag " + tag );
    return spawns;
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x746fd515, Offset: 0x438b
// Size: 0x5d
function private function_8c4fe57545bdac0a( maximum, circlefinal )
{
    spawns = self;
    possiblespawns = function_4c109a22ab8a37c7( level.ssc.indexes, circlefinal );
    spawns = spawns function_5e8089263a865109( possiblespawns, maximum, "Circle " + circlefinal );
    return spawns;
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0xb2fb7757, Offset: 0x43f1
// Size: 0xb2
function private ssc_spawn( scriptstruct, index )
{
    if ( !isdefined( level.ssc.var_1203f9795300b943[ scriptstruct ] ) )
    {
        return;
    }
    
    mapstruct = function_a0c91cefd6f58bb( index );
    newspawn = [[ level.ssc.var_1203f9795300b943[ scriptstruct ] ]]( scriptstruct, mapstruct );
    newspawn.sscindex = index;
    size = level.ssc.spawns[ scriptstruct ].size;
    level.ssc.spawns[ scriptstruct ][ size ] = newspawn;
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x599c9202, Offset: 0x44ab
// Size: 0x22
function private function_a0c91cefd6f58bb( key )
{
    return level.ssc.structs[ key ];
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0xf76866c8, Offset: 0x44d6
// Size: 0xa4
function private function_5fcf8df9928b26b5( poiname )
{
    poispawns = [];
    poistructs = function_a0c91cefd6f58bb( poiname );
    
    if ( !isdefined( poistructs ) )
    {
        return poispawns;
    }
    
    foreach ( key, value in poistructs )
    {
        poispawns[ key ] = key;
    }
    
    return poispawns;
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0xc32ceb27, Offset: 0x4583
// Size: 0xcf
function private function_85e5a1014025e13f( poi_group )
{
    var_f0a75aa58946bdca = [];
    
    foreach ( key in poi_group )
    {
        poispawns = function_5fcf8df9928b26b5( key.poi_name );
        [ var_f0a75aa58946bdca, overlapspawns ] = var_f0a75aa58946bdca function_52d7520974a3a20( poispawns, 1 );
        var_f0a75aa58946bdca = function_c6c06162c8e6ae75( var_f0a75aa58946bdca, poispawns );
    }
    
    return var_f0a75aa58946bdca;
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x13f3ea9a, Offset: 0x465b
// Size: 0xb4
function private function_6e2e28966f090935( spawns, tag )
{
    tagspawns = [];
    
    foreach ( entry in spawns )
    {
        struct = function_a0c91cefd6f58bb( entry );
        
        if ( struct.script_noteworthy == tag )
        {
            tagspawns[ entry ] = entry;
        }
    }
    
    return tagspawns;
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x1e9ec3e4, Offset: 0x4718
// Size: 0x15b
function private function_4c109a22ab8a37c7( spawns, circleindex )
{
    circlespawns = [];
    
    if ( !isdefined( circleindex ) )
    {
        return circlespawns;
    }
    
    if ( !namespace_9d8e359c3b1041e5::isfeatureenabledsharedfunc( #"circle" ) )
    {
        return circlespawns;
    }
    
    if ( !utility::issharedfuncdefined( #"game", #"hash_a3a5de30e31f08e8" ) || !utility::issharedfuncdefined( #"game", #"hash_537f438b96ab0fa9" ) )
    {
        return circlespawns;
    }
    
    foreach ( entry in spawns )
    {
        struct = function_a0c91cefd6f58bb( entry );
        dangertime = [[ utility::getsharedfunc( #"game", #"hash_537f438b96ab0fa9" ) ]]( struct.origin );
        circleend = [[ utility::getsharedfunc( #"game", #"hash_a3a5de30e31f08e8" ) ]]( circleindex );
        
        if ( dangertime > circleend )
        {
            circlespawns[ entry ] = entry;
        }
    }
    
    return circlespawns;
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0xb4fda388, Offset: 0x487c
// Size: 0x56
function private function_1b9f953b761fc982( structname )
{
    if ( !isdefined( level.ssc.funcgetlocations[ structname ] ) )
    {
        return [];
    }
    
    structlocations = [[ level.ssc.funcgetlocations[ structname ] ]]( structname );
    return utility::array_sort_by_script_index( structlocations );
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x8fc749b, Offset: 0x48db
// Size: 0xf5
function private function_ce3ae8fa55f5f2b2( struct )
{
    var_8540b854a6294ade = utility::issharedfuncdefined( #"poi", #"poi_issystemactive" ) && utility::issharedfuncdefined( #"poi", #"hash_79b3b95992c86428" );
    structpoi = struct.script_poi;
    
    if ( !isdefined( structpoi ) && var_8540b854a6294ade && [[ utility::getsharedfunc( #"poi", #"poi_issystemactive" ) ]]() )
    {
        structpoi = [[ utility::getsharedfunc( #"poi", #"hash_79b3b95992c86428" ) ]]( struct.origin );
        
        if ( !isdefined( structpoi ) )
        {
            structpoi = "none";
        }
        
        structpoi = [[ utility::getsharedfunc( #"poi", #"hash_274d8f14575dd2c1" ) ]]( structpoi );
    }
    else
    {
        structpoi = "none";
    }
    
    if ( !isdefined( structpoi ) )
    {
        structpoi = "none";
    }
    
    return structpoi;
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0xa7a39c7e, Offset: 0x49d9
// Size: 0x5b
function private function_c174f268cb8ce270( scriptindex )
{
    indexes = level.ssc.indexes;
    
    if ( isdefined( scriptindex ) )
    {
        if ( !isdefined( indexes[ scriptindex ] ) )
        {
            return scriptindex;
        }
        
        assertmsg( "<dev string:x6f>" + scriptindex + "<dev string:xad>" );
    }
    
    return function_a509d228a6eec8f3( indexes );
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0xc388f5ed, Offset: 0x4a3d
// Size: 0x2a
function private function_a509d228a6eec8f3( integers )
{
    for ( i = 1; isdefined( integers[ i ] ) ; i++ )
    {
    }
    
    return i;
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0xfe8415bc, Offset: 0x4a70
// Size: 0x5e
function private util_exclude( spawns )
{
    if ( !isarray( spawns ) )
    {
        level.ssc.exclude[ spawns ] = spawns;
        return;
    }
    
    level.ssc.exclude = function_dd40ba138bc3dba2( level.ssc.exclude, spawns );
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x3671617c, Offset: 0x4ad6
// Size: 0x3a, Type: bool
function private function_22bdbbccaf611486( rulesetting, hardonly )
{
    if ( !isdefined( rulesetting ) || rulesetting == "none" )
    {
        return false;
    }
    
    if ( hardonly )
    {
        return ( rulesetting == "hard" );
    }
    
    return true;
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x8bbdcc6e, Offset: 0x4b19
// Size: 0x50
function private util_remove( index, exclude = 1 )
{
    spawns = self;
    
    if ( !isdefined( index ) )
    {
        return spawns;
    }
    
    if ( exclude )
    {
        util_exclude( index );
    }
    
    spawns = function_669d31877820d5c6( spawns, index );
    return spawns;
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0xce8eb82f, Offset: 0x4b72
// Size: 0xa1
function private util_remove_array( array, exclude )
{
    spawns = self;
    
    if ( !isdefined( array ) )
    {
        return spawns;
    }
    
    foreach ( entry in array )
    {
        spawns = spawns util_remove( entry, exclude );
    }
    
    return spawns;
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0xe35e4582, Offset: 0x4c1c
// Size: 0xaf
function private function_8710462d9ff3e119( listref, type )
{
    liststrings = strtok( listref, " " );
    configbundles = [];
    
    foreach ( list in liststrings )
    {
        configbundles[ configbundles.size ] = function_5d1805cd9bcb3bf0( list, type );
    }
    
    return configbundles;
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x33299dee, Offset: 0x4cd4
// Size: 0x69
function private function_5d1805cd9bcb3bf0( listref, type )
{
    bundlename = listref;
    
    if ( !isxhashasset( listref ) )
    {
        bundlename = getxhashasset( ( type ?? "" ) + listref );
    }
    
    configbundle = getscriptbundle( bundlename );
    assert( isdefined( configbundle ), "<dev string:xda>" + getxhashsourcename( bundlename ) );
    return configbundle;
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0xfab76210, Offset: 0x4d46
// Size: 0xa5
function private function_ce08f3762fe97e85( configbundles )
{
    if ( !isdefined( configbundles ) )
    {
        assert( isdefined( configbundles ), "<dev string:x10c>" );
        return;
    }
    
    configlist = [];
    
    foreach ( configbundle in configbundles )
    {
        configlist = function_c502c7566cf59e2a( configbundle, configlist );
    }
    
    return configlist;
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x2bbab647, Offset: 0x4df4
// Size: 0xd5
function private function_c502c7566cf59e2a( configbundle, configlist )
{
    if ( !isdefined( configbundle ) )
    {
        assert( isdefined( configbundle ), "<dev string:x10c>" );
        return;
    }
    
    var_663ed2bc5f3f81b6 = configlist ?? [];
    
    foreach ( entry in configbundle.config_list )
    {
        if ( isdefined( entry.config ) )
        {
            var_663ed2bc5f3f81b6 = function_b9490163dc12e026( var_663ed2bc5f3f81b6, entry.config );
        }
    }
    
    return var_663ed2bc5f3f81b6;
}

// Namespace structspawnconfig
// Params 3, eflags: 0x4
// Checksum 0xbe4c120c, Offset: 0x4ed2
// Size: 0x6b
function private function_b9490163dc12e026( configlist, configref, type )
{
    config = function_5d1805cd9bcb3bf0( configref, type );
    
    if ( !isdefined( config ) )
    {
        assert( isdefined( config ), "<dev string:x12f>" );
        return configlist;
    }
    
    configlist = configlist function_1dffc2159e71222f( config.script_struct );
    configlist[ configlist.size ] = config;
    return configlist;
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x2b807788, Offset: 0x4f46
// Size: 0x9c
function private function_1dffc2159e71222f( configstruct )
{
    configlist = self;
    
    foreach ( config in configlist )
    {
        if ( config.script_struct == configstruct )
        {
            configlist = arrayremove( configlist, config );
        }
    }
    
    return configlist;
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0xd45e3e3c, Offset: 0x4feb
// Size: 0x90
function private function_84f4aaba31aba342( possiblespawns, count )
{
    possiblespawns = function_44c7c098cd4e39d7( possiblespawns, level.ssc.exclude );
    newspawns = [];
    
    for ( i = 0; i < count ; i++ )
    {
        if ( possiblespawns.size == 0 )
        {
            break;
        }
        
        randomspawn = util_array_random( possiblespawns );
        possiblespawns = function_669d31877820d5c6( possiblespawns, randomspawn );
        newspawns[ randomspawn ] = randomspawn;
    }
    
    newspawns function_6caf9e5a765e77e();
    return newspawns;
}

// Namespace structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0xcdd6be6b, Offset: 0x5084
// Size: 0x2e
function private function_6caf9e5a765e77e()
{
    newspawns = self;
    debug_print_all( "Struct Add - Adding " + newspawns.size + " new spawns" );
    function_db58f4de5b0fd46f( newspawns );
}

// Namespace structspawnconfig
// Params 3, eflags: 0x4
// Checksum 0xf6cc546b, Offset: 0x50ba
// Size: 0x7e
function private function_87de98d607328ffb( spawns, count, exclude )
{
    removedspawns = [];
    
    for ( i = 0; i < count ; i++ )
    {
        if ( spawns.size == 0 )
        {
            return spawns;
        }
        
        randomspawn = util_array_random( spawns );
        spawns = spawns util_remove( randomspawn, exclude );
        removedspawns[ removedspawns.size ] = randomspawn;
    }
    
    removedspawns function_96983d8305d6c66b();
    return spawns;
}

// Namespace structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0x62e4291d, Offset: 0x5141
// Size: 0x2e
function private function_96983d8305d6c66b()
{
    removedspawns = self;
    debug_print_all( "Struct Remove - Removing " + removedspawns.size + " spawns" );
    function_db58f4de5b0fd46f( removedspawns );
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0xe265e3a1, Offset: 0x5177
// Size: 0x9f
function private function_44c7c098cd4e39d7( array1, array2 )
{
    if ( !isdefined( array2 ) )
    {
        return array1;
    }
    
    var_b68e9c04ef6eed10 = arraycopy( array1 );
    
    foreach ( entry in array2 )
    {
        var_b68e9c04ef6eed10[ entry ] = undefined;
    }
    
    return var_b68e9c04ef6eed10;
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x16655d4c, Offset: 0x521f
// Size: 0x38
function private function_669d31877820d5c6( array, index )
{
    if ( !isdefined( index ) )
    {
        return array;
    }
    
    temparray = arraycopy( array );
    temparray[ index ] = undefined;
    return temparray;
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x11a33578, Offset: 0x5260
// Size: 0xa0
function private function_dd40ba138bc3dba2( array1, array2 )
{
    if ( !isdefined( array2 ) )
    {
        return array1;
    }
    
    var_b68e9c04ef6eed10 = arraycopy( array1 );
    
    foreach ( entry in array2 )
    {
        var_b68e9c04ef6eed10[ entry ] = entry;
    }
    
    return var_b68e9c04ef6eed10;
}

// Namespace structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x40e6a0d5, Offset: 0x5309
// Size: 0xd3
function private function_52d7520974a3a20( otherarray, remove )
{
    spawns = self;
    
    if ( !isdefined( otherarray ) )
    {
        return [ spawns, [] ];
    }
    
    overlap = [];
    
    foreach ( entry in spawns )
    {
        if ( isdefined( otherarray[ entry ] ) )
        {
            overlap[ entry ] = entry;
        }
    }
    
    if ( remove )
    {
        spawns = function_44c7c098cd4e39d7( spawns, overlap );
    }
    
    return [ spawns, overlap ];
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x7a522c37, Offset: 0x53e5
// Size: 0xb5
function private util_array_random( array )
{
    if ( !isdefined( array ) || array.size == 0 )
    {
        return;
    }
    
    randomcount = randomint( array.size );
    randomentry = undefined;
    
    foreach ( entry in array )
    {
        randomentry = entry;
        randomcount--;
        
        if ( randomcount < 0 )
        {
            break;
        }
    }
    
    return randomentry;
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x500f2746, Offset: 0x54a3
// Size: 0x32
function private debug_print( text )
{
    /#
        if ( getdvarint( @"scr_ssc_debug_print", 1 ) < 1 )
        {
            return;
        }
        
        println( "<dev string:x161>" + text );
    #/
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0xe34eea93, Offset: 0x54dd
// Size: 0x32
function private debug_print_verbose( text )
{
    /#
        if ( getdvarint( @"scr_ssc_debug_print", 1 ) < 2 )
        {
            return;
        }
        
        println( "<dev string:x168>" + text );
    #/
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x87690f7e, Offset: 0x5517
// Size: 0x32
function private debug_print_all( text )
{
    /#
        if ( getdvarint( @"scr_ssc_debug_print", 1 ) < 3 )
        {
            return;
        }
        
        println( "<dev string:x179>" + text );
    #/
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x68a78051, Offset: 0x5551
// Size: 0x8d
function private function_db58f4de5b0fd46f( array )
{
    /#
        if ( getdvarint( @"scr_ssc_debug_print", 1 ) < 3 )
        {
            return;
        }
        
        if ( !isdefined( array ) || array.size == 0 )
        {
            return;
        }
        
        condensedarray = function_10330da46b3ea4a5( array );
        arraystring = "<dev string:x186>";
        
        for ( i = 0; i < condensedarray.size ; i++ )
        {
            arraystring += condensedarray[ i ] + "<dev string:x47>";
        }
        
        println( "<dev string:x187>" + arraystring );
    #/
}

// Namespace structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x5851dc47, Offset: 0x55e6
// Size: 0x91
function private function_10330da46b3ea4a5( var_7413ce28c5939f7b )
{
    condensedarray = [];
    
    foreach ( entry in var_7413ce28c5939f7b )
    {
        condensedarray[ condensedarray.size ] = entry;
    }
    
    condensedarray = arraysort( condensedarray );
    return condensedarray;
}

// Namespace structspawnconfig
// Params 1
// Checksum 0xf375389b, Offset: 0x5680
// Size: 0x15
function function_c23b46dea4f3bf15( spawnconfig )
{
    spawnconfig ssc_process();
}

/#

    // Namespace structspawnconfig
    // Params 0, eflags: 0x4
    // Checksum 0x44812ae, Offset: 0x569d
    // Size: 0x161, Type: dev
    function private init_debug()
    {
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        devgui::function_9082edeb5db93280( "<dev string:x196>" );
        devgui::add_devgui_command( "<dev string:x1b5>", "<dev string:x1c6>" );
        devgui::add_devgui_command( "<dev string:x1e1>", "<dev string:x1ee>" );
        devgui::add_devgui_command( "<dev string:x20c>", "<dev string:x21d>" );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x239>" );
        devgui::add_devgui_command( "<dev string:x265>", "<dev string:x272>" );
        devgui::add_devgui_command( "<dev string:x29c>", "<dev string:x2ab>" );
        devgui::add_devgui_command( "<dev string:x2d8>", "<dev string:x2e4>" );
        devgui::add_devgui_command( "<dev string:x30d>", "<dev string:x31a>" );
        devgui::add_devgui_command( "<dev string:x344>", "<dev string:x355>" );
        devgui::add_devgui_command( "<dev string:x383>", "<dev string:x392>" );
        devgui::add_devgui_command( "<dev string:x3bf>", "<dev string:x3c9>" );
        devgui::add_devgui_command( "<dev string:x3f1>", "<dev string:x3fe>" );
        devgui::add_devgui_command( "<dev string:x428>", "<dev string:x43a>" );
        devgui::add_devgui_command( "<dev string:x46c>", "<dev string:x480>" );
        devgui::add_devgui_command( "<dev string:x4b1>", "<dev string:x4bf>" );
        devgui::add_devgui_command( "<dev string:x4ea>", "<dev string:x4f7>" );
        devgui::add_devgui_command( "<dev string:x522>", "<dev string:x534>" );
        devgui::add_devgui_command( "<dev string:x563>", "<dev string:x579>" );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace structspawnconfig
    // Params 0, eflags: 0x4
    // Checksum 0x89576e1f, Offset: 0x5806
    // Size: 0x98, Type: dev
    function private debug_thread()
    {
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        thread debug_watch( @"hash_e4a633370d1ef223", &debug_draw );
        thread debug_watch( @"hash_e131fa7eb854022b", &function_e02ad6183b3d9150 );
        thread debug_watch( @"hash_dabca9d7fe9cee2a", &function_4582cac877547a2f );
        thread debug_watch( @"hash_f9cebbc2fc0ec02f", &function_88f99d5ee1642683 );
        thread debug_watch( @"hash_c58cb33610933aa4", &function_55e715c34479ea5 );
        thread debug_watch( @"hash_988831f42004ed6b", &function_b3ff7b71c94df092 );
    }

    // Namespace structspawnconfig
    // Params 2, eflags: 0x4
    // Checksum 0x430a1db8, Offset: 0x58a6
    // Size: 0x81, Type: dev
    function private debug_watch( dvarstring, funcdebug )
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            debugstate = getdvar( dvarstring, "<dev string:x186>" );
            
            if ( debugstate == "<dev string:x186>" )
            {
                waitframe();
                continue;
            }
            
            setdvar( dvarstring, "<dev string:x186>" );
            debug_print( "<dev string:x5a5>" + getxhashsourcename( dvarstring ) + "<dev string:x5ae>" + debugstate );
            [[ funcdebug ]]( debugstate );
            waitframe();
        }
    }

    // Namespace structspawnconfig
    // Params 2, eflags: 0x4
    // Checksum 0x6f545e75, Offset: 0x592f
    // Size: 0xfa, Type: dev
    function private debug_draw( scriptstruct, spawns )
    {
        spawnconfig = spawnstruct();
        spawnconfig.script_struct = scriptstruct;
        function_78c535ba3b646b0e( spawnconfig, 2 );
        debug_cleanup();
        iprintlnbold( "<dev string:x5b5>" + scriptstruct + "<dev string:x5cf>" );
        
        if ( !isdefined( spawns ) )
        {
            spawns = level.ssc.indexes;
        }
        
        foreach ( entry in spawns )
        {
            debug_draw_single( scriptstruct, entry );
        }
        
        level.ssc.drawcount++;
    }

    // Namespace structspawnconfig
    // Params 0, eflags: 0x4
    // Checksum 0x8274cbad, Offset: 0x5a31
    // Size: 0x43, Type: dev
    function private function_205d8c06eb042e4e()
    {
        offset = getdvarint( @"hash_5ec6f63fa858b195", 1 );
        drawindex = level.ssc.drawcount - offset;
        return drawindex;
    }

    // Namespace structspawnconfig
    // Params 2, eflags: 0x4
    // Checksum 0x8da16703, Offset: 0x5a7c
    // Size: 0xaf, Type: dev
    function private debug_draw_single( scriptstruct, index )
    {
        origin = function_a0c91cefd6f58bb( index ).origin ?? ( 0, 0, 0 );
        angles = function_a0c91cefd6f58bb( index ).angles ?? ( 0, 0, 0 );
        color = level.ssc.colors[ scriptstruct ] ?? ( 1, 1, 1 );
        function_64af1e327012c3fb( index, origin, angles, color );
    }

    // Namespace structspawnconfig
    // Params 4, eflags: 0x4
    // Checksum 0x9bb8b597, Offset: 0x5b33
    // Size: 0xfd, Type: dev
    function private function_64af1e327012c3fb( text, origin, angles, color )
    {
        forward = anglestoforward( angles );
        timesec = getdvarint( @"hash_1e06d12003d4c5bf", 15 );
        timeframes = int( timesec / level.framedurationseconds );
        thread function_62a0da817d4c56f4( text, origin, color, timeframes );
        ray = origin + ( 0, 0, 20000 );
        forwardpos = origin + forward * 75;
        thread utility::draw_line_for_time( origin, ray, color[ 0 ], color[ 1 ], color[ 2 ], timesec, "<dev string:x5d9>" + level.ssc.drawcount );
        thread utility::draw_arrow_time( origin, forwardpos, color, timesec, "<dev string:x5d9>" + level.ssc.drawcount );
    }

    // Namespace structspawnconfig
    // Params 4, eflags: 0x4
    // Checksum 0x7d774cf8, Offset: 0x5c38
    // Size: 0x81, Type: dev
    function private function_62a0da817d4c56f4( text, origin, color, timeframes )
    {
        level endon( "<dev string:x5d9>" + level.ssc.drawcount );
        
        while ( timeframes > 0 )
        {
            print3d( origin, text, color, 1, 60, 10 );
            timeframes -= 10;
            timesec = 10 * level.framedurationseconds;
            wait timesec;
        }
    }

    // Namespace structspawnconfig
    // Params 1, eflags: 0x4
    // Checksum 0xdf86962c, Offset: 0x5cc1
    // Size: 0x27, Type: dev
    function private debug_cleanup( drawindex )
    {
        if ( !isdefined( drawindex ) )
        {
            drawindex = function_205d8c06eb042e4e();
        }
        
        level notify( "<dev string:x5d9>" + drawindex );
    }

    // Namespace structspawnconfig
    // Params 1, eflags: 0x4
    // Checksum 0xdb78a715, Offset: 0x5cf0
    // Size: 0x56, Type: dev
    function private function_e02ad6183b3d9150( listref )
    {
        if ( listref == "<dev string:x5e7>" )
        {
            listref = getdvar( @"scr_ssc_config_list", "<dev string:x186>" );
        }
        
        if ( listref == "<dev string:x186>" )
        {
            listref = level.sscl;
        }
        
        debug_cleanup();
        ssc_config( listref, 2 );
    }

    // Namespace structspawnconfig
    // Params 2, eflags: 0x4
    // Checksum 0x185e6485, Offset: 0x5d4e
    // Size: 0x40, Type: dev
    function private function_4582cac877547a2f( configref, spawntype )
    {
        if ( !isdefined( spawntype ) )
        {
            spawntype = 2;
        }
        
        debug_cleanup();
        results = ssc_config_single( configref, spawntype );
        return results;
    }

    // Namespace structspawnconfig
    // Params 1, eflags: 0x4
    // Checksum 0xd0bfd4d9, Offset: 0x5d96
    // Size: 0x19b, Type: dev
    function private function_88f99d5ee1642683( debugstate )
    {
        debug_cleanup();
        
        foreach ( structname, spawnarray in level.ssc.spawns )
        {
            color = level.ssc.colors[ structname ] ?? ( 1, 1, 1 );
            
            foreach ( scriptstruct in spawnarray )
            {
                origin = scriptstruct.origin ?? ( 0, 0, 0 );
                angles = scriptstruct.angles ?? ( 0, 0, 0 );
                function_64af1e327012c3fb( scriptstruct.sscindex, origin, angles, color );
            }
        }
        
        level.ssc.drawcount++;
    }

    // Namespace structspawnconfig
    // Params 1, eflags: 0x4
    // Checksum 0xe079a4cc, Offset: 0x5f39
    // Size: 0x49, Type: dev
    function private function_55e715c34479ea5( debugstate )
    {
        for ( i = function_205d8c06eb042e4e(); i <= level.ssc.drawcount ; i++ )
        {
            debug_cleanup( i );
        }
    }

    // Namespace structspawnconfig
    // Params 1, eflags: 0x4
    // Checksum 0xe199c270, Offset: 0x5f8a
    // Size: 0xb7, Type: dev
    function private function_b3ff7b71c94df092( configref )
    {
        spawns = [];
        numtimes = getdvarint( @"hash_a7edcbf40456f8b5", 10 );
        debug_print( "<dev string:x5e9>" + configref + "<dev string:x47>" + numtimes + "<dev string:x601>" );
        
        for ( i = 0; i < numtimes ; i++ )
        {
            debug_print( "<dev string:x609>" + i + 1 + "<dev string:x61f>" + configref );
            results = function_4582cac877547a2f( configref, 3 );
            println( results.size );
            spawns = arraycombine( spawns, results );
            waitframe();
        }
        
        function_46b2ce0812f57e77( configref, spawns, numtimes );
    }

    // Namespace structspawnconfig
    // Params 3, eflags: 0x4
    // Checksum 0xfad4c0da, Offset: 0x6049
    // Size: 0x37b, Type: dev
    function private function_46b2ce0812f57e77( configref, spawns, var_f86002d07a24aaa9 )
    {
        spawncounts = [];
        maxcount = 0;
        
        foreach ( spawn in spawns )
        {
            if ( isdefined( spawncounts[ spawn ] ) )
            {
                count = spawncounts[ spawn ] + 1;
                spawncounts[ spawn ] = count;
                
                if ( count > maxcount )
                {
                    maxcount = count;
                }
                
                continue;
            }
            
            spawncounts[ spawn ] = 1;
        }
        
        mincount = maxcount;
        
        foreach ( count in spawncounts )
        {
            if ( count < mincount )
            {
                mincount = count;
            }
        }
        
        deltacount = maxcount - mincount;
        
        foreach ( index in level.ssc.indexes )
        {
            origin = level.ssc.structs[ index ].origin ?? ( 0, 0, 0 );
            angles = level.ssc.structs[ index ].angles ?? ( 0, 0, 0 );
            
            if ( spawncounts[ index ] > 0 )
            {
                count = spawncounts[ index ];
                
                if ( deltacount )
                {
                    colorfrac = ( count - mincount ) / deltacount;
                }
                else
                {
                    colorfrac = 1;
                }
                
                if ( colorfrac < 0.25 )
                {
                    color = ( 0, colorfrac / 0.25, 1 );
                }
                else if ( colorfrac < 0.5 )
                {
                    colorfrac -= 0.25;
                    color = ( 0, 1, 1 - colorfrac / 0.25 );
                }
                else if ( colorfrac < 0.75 )
                {
                    colorfrac -= 0.5;
                    color = ( colorfrac / 0.25, 1, 0 );
                }
                else
                {
                    colorfrac -= 0.75;
                    color = ( 1, 1 - colorfrac / 0.25, 0 );
                }
                
                function_64af1e327012c3fb( index + "<dev string:x624>" + spawncounts[ index ] + "<dev string:x626>", origin, angles, color );
                continue;
            }
            
            debug_print( "<dev string:x628>" + index + "<dev string:x62f>" + var_f86002d07a24aaa9 + "<dev string:x64e>" + configref );
            function_64af1e327012c3fb( index + "<dev string:x664>", origin, angles, ( 1, 1, 1 ) );
        }
        
        level.ssc.drawcount++;
    }

#/
