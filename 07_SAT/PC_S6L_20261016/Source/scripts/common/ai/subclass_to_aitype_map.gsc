// scripts\common\ai\subclass_to_aitype_map.gsc  (hash_5c9b111047cd229f.gscc) (size: 6531 Bytes / 0x1983 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x73213346 (1931555654)
// size ...... 6531 (0x1983)
// includes .. 3   (offset: 0x1813)
// strings ... 11  (offset: 0x182b)
// dev strs .. 15  (offset: 0x18c7)
// exports ... 15  (offset: 0xf93)
// cseg ...... 0xfc + 0xe97 (0xf93)
// imports ... 51  (offset: 0x11eb)
// animtree1 . 0   (offset: 0x1983)
// animtree2 . 0   (offset: 0x1983)
#using script_16ea1b94f0f381b3;
#using scripts\common\devgui;
#using scripts\common\utility;

#namespace subclass_to_aitype_map;

// Namespace subclass_to_aitype_map
// Params 0, eflags: 0x1
// Checksum 0x81e29020, Offset: 0x11a
// Size: 0xa
function autoexec init()
{
    level thread setup_global_subclass_to_aitype_map();
}

// Namespace subclass_to_aitype_map
// Params 0, eflags: 0x4
// Checksum 0xe185bda9, Offset: 0x12c
// Size: 0x1c0
function private setup_global_subclass_to_aitype_map()
{
    level endon( #"game_ended" );
    waitframe();
    level.stam_default_mapping = "ChooseSmallest";
    level.stam_default_specific_aitype = undefined;
    level.stam_default_substring = undefined;
    level.var_c9e0fca55204d8c4 = [];
    level.subclass_to_aitype_map = [];
    level.var_962742d9501c1412 = [];
    subclass_names = getscriptbundlenames( "ai_subclass" );
    
    foreach ( str_bundle in subclass_names )
    {
        name = getscriptbundlefieldvalue( str_bundle, "name" );
        level.var_962742d9501c1412[ level.var_962742d9501c1412.size ] = name;
    }
    
    add_map();
    gametypebundle = getgametypescriptbundle();
    
    if ( isdefined( gametypebundle ) && isdefined( gametypebundle.subclass_to_aitype_map ) )
    {
        add_map( gametypebundle.subclass_to_aitype_map );
    }
    
    mapinfo = getactivemapinfobundle();
    
    if ( isdefined( mapinfo ) && isdefined( mapinfo.subclass_to_aitype_map ) && mapinfo.subclass_to_aitype_map.size > 0 )
    {
        add_map( mapinfo.subclass_to_aitype_map );
    }
    
    if ( isdefined( gametypebundle ) && isdefined( gametypebundle.var_d72ac83fac014227 ) )
    {
        add_map( gametypebundle.var_d72ac83fac014227 );
    }
    
    utility::flag_set( "subclass_to_aitype_map_initialized" );
    level thread function_e3f62c04fcbf8c79();
    
    /#
        level thread init_debug_stam();
    #/
}

// Namespace subclass_to_aitype_map
// Params 1
// Checksum 0x55a44cb5, Offset: 0x2f4
// Size: 0x2d
function function_7f9ebc41207674e9( subclass )
{
    assert( utility::flag( "<dev string:x24>" ), "<dev string:x47>" );
    return function_b3988325430ce242( subclass );
}

// Namespace subclass_to_aitype_map
// Params 1
// Checksum 0xed5eb1bc, Offset: 0x32a
// Size: 0x15d
function add_map( map_asset )
{
    processed_map = process_map_asset( map_asset, level.stam_default_mapping, level.stam_default_specific_aitype, level.stam_default_substring, level.subclass_to_aitype_map );
    level.stam_default_mapping = processed_map.default_mapping ?? level.stam_default_mapping;
    level.stam_default_specific_aitype = processed_map.default_specific_aitype ?? level.stam_default_specific_aitype;
    level.stam_default_substring = processed_map.default_substring ?? level.stam_default_substring;
    level.subclass_to_aitype_map = processed_map.subclass_map;
    
    foreach ( subclass_name in level.var_962742d9501c1412 )
    {
        aitype = function_9fc4e9f61d6b21d8( subclass_name );
        
        if ( isdefined( aitype ) )
        {
            setsubclasstoaitype( subclass_name, aitype );
        }
    }
    
    level.var_c9e0fca55204d8c4[ level.var_c9e0fca55204d8c4.size ] = map_asset;
}

// Namespace subclass_to_aitype_map
// Params 1
// Checksum 0x456514, Offset: 0x48f
// Size: 0xbe
function remove_map( map_asset )
{
    assert( arraycontains( level.var_c9e0fca55204d8c4, map_asset ) );
    level.var_c9e0fca55204d8c4 = arrayremove( level.var_c9e0fca55204d8c4, map_asset );
    level.subclass_to_aitype_map = [];
    
    foreach ( current_map_asset in level.var_c9e0fca55204d8c4 )
    {
        add_map( current_map_asset );
    }
}

// Namespace subclass_to_aitype_map
// Params 2
// Checksum 0xfbe508c9, Offset: 0x555
// Size: 0x11d
function function_427ae77ce1056e01( subclass, map_assets )
{
    assert( utility::flag( "<dev string:x24>" ), "<dev string:x47>" );
    
    if ( !isarray( map_assets ) )
    {
        map_assets = [ map_assets ];
    }
    
    assert( map_assets.size > 0 );
    processed_map = process_map_asset( map_assets[ 0 ] );
    
    for ( map_index = 1; map_index < map_assets.size ; map_index++ )
    {
        processed_map = process_map_asset( map_assets[ map_index ], processed_map.default_mapping, processed_map.default_specific_aitype, processed_map.default_substring, processed_map.subclass_to_aitype_map );
    }
    
    if ( isdefined( processed_map.subclass_map[ subclass ] ) )
    {
        return processed_map.subclass_map[ subclass ];
    }
    
    if ( isdefined( processed_map.default_mapping ) )
    {
        calculated_aitype = calculate_aitype( subclass, processed_map.default_mapping, processed_map.default_specific_aitype, processed_map.default_substring );
        return calculated_aitype;
    }
}

// Namespace subclass_to_aitype_map
// Params 5, eflags: 0x4
// Checksum 0xb3bfd9e5, Offset: 0x67b
// Size: 0x275
function private process_map_asset( map_asset, prev_default_mapping, prev_default_specific_aitype, prev_default_substring, prev_subclass_map )
{
    return_map = { #subclass_map:arraycopy( prev_subclass_map ?? [] ), #default_substring:prev_default_substring, #default_specific_aitype:prev_default_specific_aitype, #default_mapping:prev_default_mapping };
    
    if ( !isdefined( map_asset ) )
    {
        return return_map;
    }
    
    if ( isstring( map_asset ) )
    {
        if ( !issubstr( map_asset, "subclass_to_aitype_map:" ) )
        {
            map_asset = "subclass_to_aitype_map:" + map_asset;
        }
        
        map_asset = getxhashasset( map_asset );
    }
    
    scriptbundle = load_map_asset( map_asset );
    
    if ( isdefined( scriptbundle ) )
    {
        if ( isdefined( scriptbundle.default_mapping ) && scriptbundle.default_mapping != "DontChange" )
        {
            return_map.default_mapping = scriptbundle.default_mapping;
            
            if ( return_map.default_mapping == "Specific" )
            {
                assert( isstring( scriptbundle.defaultspecificaitype ) );
                return_map.default_specific_aitype = scriptbundle.defaultspecificaitype;
            }
            else if ( return_map.default_mapping == "ContainsString" )
            {
                assert( isstring( scriptbundle.defaultsubstring ) );
                return_map.default_substring = scriptbundle.defaultsubstring;
            }
        }
        
        if ( isdefined( scriptbundle.entry_list ) )
        {
            foreach ( entry in scriptbundle.entry_list )
            {
                subclass_name = getscriptbundlefieldvalue( entry.subclass, "name" );
                
                if ( !isdefined( subclass_name ) )
                {
                    continue;
                }
                
                calculated_aitype = calculate_aitype( subclass_name, entry.mapping, entry.specificaitype, entry.substring );
                
                if ( !isdefined( calculated_aitype ) )
                {
                    continue;
                }
                
                return_map.subclass_map[ subclass_name ] = calculated_aitype;
            }
        }
    }
    
    return return_map;
}

// Namespace subclass_to_aitype_map
// Params 4, eflags: 0x4
// Checksum 0xf4fd72d4, Offset: 0x8f9
// Size: 0x199
function private calculate_aitype( subclass_name, mapping, specific_aitype, substring )
{
    assert( isdefined( mapping ) );
    
    if ( !isdefined( mapping ) )
    {
        return;
    }
    
    if ( mapping == "Specific" )
    {
        assert( isstring( specific_aitype ) );
        return specific_aitype;
    }
    
    aitypes = namespace_9d8e359c3b1041e5::get_aitype_by_subclass_sharedfunc( subclass_name );
    
    if ( !isarray( aitypes ) || aitypes.size <= 0 )
    {
        return;
    }
    
    if ( mapping == "ContainsString" )
    {
        assert( isstring( substring ) );
        
        foreach ( aitype in aitypes )
        {
            if ( issubstr( aitype, substring ) )
            {
                return aitype;
            }
        }
    }
    
    smallest_aitype = undefined;
    
    foreach ( aitype in aitypes )
    {
        strlen = aitype.size;
        
        if ( !isdefined( smallest_aitype ) || smallest_aitype.size > strlen )
        {
            smallest_aitype = aitype;
        }
    }
    
    return smallest_aitype;
}

// Namespace subclass_to_aitype_map
// Params 1, eflags: 0x4
// Checksum 0xb621906f, Offset: 0xa9c
// Size: 0x9a
function private load_map_asset( map_asset )
{
    assert( isxhash( map_asset ) || isxhashasset( map_asset ) );
    
    if ( !isdefined( level.var_e6acc6202bec467e ) )
    {
        level.var_e6acc6202bec467e = [];
    }
    
    scriptbundle = undefined;
    
    if ( !isdefined( level.var_e6acc6202bec467e[ map_asset ] ) )
    {
        scriptbundle = getscriptbundle( map_asset );
        
        if ( !isdefined( scriptbundle ) )
        {
            assertmsg( "<dev string:x72>" + getxhashsourcename( map_asset ) );
            return;
        }
        
        level.var_e6acc6202bec467e[ map_asset ] = scriptbundle;
    }
    
    scriptbundle = level.var_e6acc6202bec467e[ map_asset ];
    return scriptbundle;
}

// Namespace subclass_to_aitype_map
// Params 0, eflags: 0x4
// Checksum 0xf8303a45, Offset: 0xb3f
// Size: 0x110
function private function_e3f62c04fcbf8c79()
{
    level endon( #"game_ended" );
    setdvarifuninitialized( @"hash_33aa1a0677d2f25f", "" );
    
    while ( true )
    {
        stam_dvar = getdvar( @"hash_33aa1a0677d2f25f" );
        
        if ( stam_dvar == "" )
        {
            wait 1;
            continue;
        }
        
        setdvar( @"hash_33aa1a0677d2f25f", "" );
        map_assets = strtok( stam_dvar, "|" );
        
        foreach ( map_asset in map_assets )
        {
            if ( map_asset[ 0 ] == "-" )
            {
                map_asset = getsubstr( map_asset, 1, map_asset.size );
                remove_map( map_asset );
                continue;
            }
            
            add_map( map_asset );
        }
    }
}

// Namespace subclass_to_aitype_map
// Params 1, eflags: 0x4
// Checksum 0x16de5ce1, Offset: 0xc57
// Size: 0x5a
function private function_9fc4e9f61d6b21d8( subclass )
{
    if ( isdefined( level.subclass_to_aitype_map[ subclass ] ) )
    {
        return level.subclass_to_aitype_map[ subclass ];
    }
    
    calculated_aitype = calculate_aitype( subclass, level.stam_default_mapping, level.stam_default_specific_aitype, level.stam_default_substring );
    return calculated_aitype;
}

/#

    // Namespace subclass_to_aitype_map
    // Params 0, eflags: 0x4
    // Checksum 0x21f648db, Offset: 0xcba
    // Size: 0x4b, Type: dev
    function private init_debug_stam()
    {
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        devgui::function_9082edeb5db93280( "<dev string:x88>" );
        devgui::add_devgui_func( "<dev string:xa8>", "<dev string:xba>", &toggle_draw_debug_stam );
        devgui::function_77df7fe7dd273e10();
        level thread draw_debug_stam();
    }

    // Namespace subclass_to_aitype_map
    // Params 0, eflags: 0x4
    // Checksum 0x67702fd4, Offset: 0xd0d
    // Size: 0x1a, Type: dev
    function private toggle_draw_debug_stam()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xe3>", @"stam_debug" );
    }

    // Namespace subclass_to_aitype_map
    // Params 0, eflags: 0x4
    // Checksum 0xec165dad, Offset: 0xd2f
    // Size: 0x264, Type: dev
    function private draw_debug_stam()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"stam_debug", 0 ) == 0 )
            {
                waitframe();
                continue;
            }
            
            col = ( 0, 1, 0 );
            yy = 400;
            printtoscreen2d( 10, yy, "<dev string:xee>", col );
            yy += 20;
            printtoscreen2d( 10, yy, "<dev string:x105>" + level.stam_default_mapping, col );
            yy += 20;
            
            if ( level.stam_default_mapping == "<dev string:x117>" )
            {
                printtoscreen2d( 10, yy, "<dev string:x126>" + level.stam_default_substring, col );
            }
            else if ( level.stam_default_mapping == "<dev string:x13c>" )
            {
                printtoscreen2d( 10, yy, "<dev string:x145>" + level.var_bb740e14e3b6aefc, col );
            }
            
            yy += 30;
            entry_i = 0;
            
            foreach ( subclass in level.var_962742d9501c1412 )
            {
                aitype = function_b3988325430ce242( subclass );
                col = arraycontains( level.subclass_to_aitype_map, aitype ) ? ( 0.9, 0.6, 0 ) : ( 0.8, 0.5, 0 );
                printtoscreen2d( 200, yy + entry_i * 20, subclass + "<dev string:x157>" + aitype, col );
                entry_i++;
            }
            
            printtoscreen2d( 10, yy, "<dev string:x15c>", col );
            yy += 20;
            entry_i = 0;
            
            foreach ( map_name in level.var_c9e0fca55204d8c4 )
            {
                printtoscreen2d( 10, yy + entry_i * 20, map_name, col );
                entry_i++;
            }
            
            waitframe();
        }
    }

#/
