// script_4bf223434bdc0646  (hash_4bf223434bdc0646.gscc) (size: 4640 Bytes / 0x1220 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbf864916 (3213248790)
// size ...... 4640 (0x1220)
// includes .. 3   (offset: 0x11a8)
// strings ... 8   (offset: 0x11c0)
// dev strs .. 0   (offset: 0x1220)
// exports ... 11  (offset: 0xcec)
// cseg ...... 0xeb + 0xc01 (0xcec)
// imports ... 23  (offset: 0xea4)
// animtree1 . 0   (offset: 0x1220)
// animtree2 . 0   (offset: 0x1220)
#using scripts\common\ai;
#using scripts\common\ai\subclass_to_aitype_map;
#using scripts\common\utility;

#namespace namespace_c7157c2cd884c5d5;

// Namespace namespace_c7157c2cd884c5d5
// Params 0
// Checksum 0x49b9171, Offset: 0x109
// Size: 0xcd
function build_ai_spawn_list()
{
    level utility::flag_wait( "subclass_to_aitype_map_initialized" );
    var_b0dd18e3624806d7 = getscriptbundlenames( "zmaispawnlist" );
    
    if ( !isdefined( level.zm_ai_spawn_lists ) )
    {
        level.zm_ai_spawn_lists = [];
    }
    
    if ( !isdefined( level.var_2292921b310dff03 ) )
    {
        level.var_2292921b310dff03 = [];
    }
    
    foreach ( bundlename in var_b0dd18e3624806d7 )
    {
        register_ai_spawn_list( bundlename );
    }
    
    level utility::flag_set( "build_ai_spawn_list_completed" );
}

// Namespace namespace_c7157c2cd884c5d5
// Params 1
// Checksum 0xd6334395, Offset: 0x1de
// Size: 0x16c
function register_ai_spawn_list( aispawnlist )
{
    level.zm_ai_spawn_lists[ aispawnlist ] = [];
    var_2a6c55cfcbe644b7 = getscriptbundle( aispawnlist );
    
    if ( isdefined( var_2a6c55cfcbe644b7 ) )
    {
        foreach ( v in var_2a6c55cfcbe644b7.aispawnlist )
        {
            var_99cf9b3fde8243ce = spawnstruct();
            var_c72bc39c5e17db97 = v.ailist;
            ailist = getscriptbundle( "zmaispawnlist:" + var_c72bc39c5e17db97 );
            
            if ( isdefined( ailist ) )
            {
                var_203cfbd98d07634b = hashcat( %"zmaispawnlist:", var_c72bc39c5e17db97 );
                register_ai_spawn_list( var_203cfbd98d07634b );
            }
            
            new_index = level.zm_ai_spawn_lists[ aispawnlist ].size;
            level.zm_ai_spawn_lists[ aispawnlist ][ new_index ] = var_99cf9b3fde8243ce;
            level.zm_ai_spawn_lists[ aispawnlist ][ new_index ].weight = v.spawnweight ?? 0;
            level.zm_ai_spawn_lists[ aispawnlist ][ new_index ].var_c72bc39c5e17db97 = var_c72bc39c5e17db97;
        }
    }
}

// Namespace namespace_c7157c2cd884c5d5
// Params 1
// Checksum 0x8a41508e, Offset: 0x352
// Size: 0x18e
function function_8506004ffbf27011( aispawnlist )
{
    var_d3adea197e95f620 = function_e0abfec4a095a04b( aispawnlist );
    
    if ( isdefined( var_d3adea197e95f620 ) )
    {
        foreach ( var_f456081bfb0d1e37 in var_d3adea197e95f620 )
        {
            subclass = ai::function_29ab862ec4f51541( var_f456081bfb0d1e37 ) ?? var_f456081bfb0d1e37;
            aitype = subclass_to_aitype_map::function_7f9ebc41207674e9( subclass );
            
            if ( isdefined( aitype ) )
            {
                aitype_scriptbundle = getaitypescriptbundle( aitype );
                
                if ( isdefined( aitype_scriptbundle.zombieaisetting ) )
                {
                    category = getscriptbundlefieldvalue( getxhashasset( "zombieaisettings:" + aitype_scriptbundle.zombieaisetting ), #"aicategory" );
                    
                    if ( isdefined( category ) )
                    {
                        if ( level.gametypebundle.disableelites && category == "elite" )
                        {
                            return;
                        }
                        
                        if ( !isdefined( level.var_c6d6e983c300b6f0[ category ] ) )
                        {
                            level.var_c6d6e983c300b6f0[ category ] = [];
                        }
                        
                        level.var_c6d6e983c300b6f0[ category ] = arraycombineunique( level.var_c6d6e983c300b6f0[ category ], [ subclass ] );
                    }
                }
            }
            
            level.var_2292921b310dff03 = arraycombineunique( level.var_2292921b310dff03, [ subclass ] );
        }
    }
}

// Namespace namespace_c7157c2cd884c5d5
// Params 1
// Checksum 0x4d6c8888, Offset: 0x4e8
// Size: 0x1e8
function function_d34f63bc9c24e432( aispawnlist )
{
    ailist = aispawnlist;
    
    if ( !isdefined( level.zm_ai_spawn_lists[ aispawnlist ] ) )
    {
        var_c72bc39c5e17db97 = aispawnlist;
        ailist = hashcat( %"zmaispawnlist:", aispawnlist );
    }
    
    if ( isdefined( level.zm_ai_spawn_lists[ ailist ] ) )
    {
        total_weight = 0;
        
        foreach ( var_99cf9b3fde8243ce in level.zm_ai_spawn_lists[ ailist ] )
        {
            total_weight += var_99cf9b3fde8243ce.weight;
        }
        
        total_weight = int( total_weight );
        
        if ( total_weight < 1 )
        {
            total_weight = 1;
        }
        
        weight_rolled = randomint( total_weight );
        var_1cbbff3b938a1a88 = 0;
        
        foreach ( var_99cf9b3fde8243ce in level.zm_ai_spawn_lists[ ailist ] )
        {
            var_1cbbff3b938a1a88 += var_99cf9b3fde8243ce.weight;
            
            if ( weight_rolled <= var_1cbbff3b938a1a88 )
            {
                var_c72bc39c5e17db97 = var_99cf9b3fde8243ce.var_c72bc39c5e17db97;
                ailist = hashcat( %"zmaispawnlist:", var_c72bc39c5e17db97 );
                
                if ( isdefined( level.zm_ai_spawn_lists[ ailist ] ) )
                {
                    var_c72bc39c5e17db97 = function_d34f63bc9c24e432( var_c72bc39c5e17db97 );
                }
                
                var_c72bc39c5e17db97 = function_3fbdda7b775ce416( var_c72bc39c5e17db97 );
                return var_c72bc39c5e17db97;
            }
        }
        
        return;
    }
    
    aispawnlist = function_3fbdda7b775ce416( aispawnlist );
    return aispawnlist;
}

// Namespace namespace_c7157c2cd884c5d5
// Params 2
// Checksum 0xea8f50b1, Offset: 0x6d8
// Size: 0x8b
function function_3925bfe0a9aed36d( aispawnlist, index )
{
    ailist = aispawnlist;
    
    if ( !isdefined( level.zm_ai_spawn_lists[ aispawnlist ] ) )
    {
        ailist = hashcat( %"zmaispawnlist:", aispawnlist );
    }
    
    if ( isdefined( level.zm_ai_spawn_lists[ ailist ] ) )
    {
        if ( level.zm_ai_spawn_lists[ ailist ][ index ].weight > 0 )
        {
            return level.zm_ai_spawn_lists[ ailist ][ index ].var_c72bc39c5e17db97;
        }
    }
}

// Namespace namespace_c7157c2cd884c5d5
// Params 2
// Checksum 0x7c1e8fcd, Offset: 0x76c
// Size: 0x12b
function function_cfe336af64fbc449( aispawnlist, aisubclass )
{
    ailist = aispawnlist;
    
    if ( !isdefined( level.zm_ai_spawn_lists[ aispawnlist ] ) )
    {
        var_c72bc39c5e17db97 = aispawnlist;
        ailist = hashcat( %"zmaispawnlist:", aispawnlist );
    }
    
    if ( isdefined( level.zm_ai_spawn_lists[ ailist ] ) )
    {
        foreach ( var_99cf9b3fde8243ce in level.zm_ai_spawn_lists[ ailist ] )
        {
            var_c72bc39c5e17db97 = var_99cf9b3fde8243ce.var_c72bc39c5e17db97;
            ailist = hashcat( %"zmaispawnlist:", var_c72bc39c5e17db97 );
            
            if ( isdefined( level.zm_ai_spawn_lists[ ailist ] ) )
            {
                return function_cfe336af64fbc449( var_c72bc39c5e17db97, aisubclass );
            }
            
            var_c72bc39c5e17db97 = function_3fbdda7b775ce416( var_c72bc39c5e17db97 );
            return ( var_c72bc39c5e17db97 == aisubclass );
        }
        
        return;
    }
    
    aispawnlist = function_3fbdda7b775ce416( var_c72bc39c5e17db97 );
    return aispawnlist == aisubclass;
}

// Namespace namespace_c7157c2cd884c5d5
// Params 1
// Checksum 0x817fa73, Offset: 0x89f
// Size: 0x11a, Type: bool
function function_f566149de5039773( aispawnlist )
{
    if ( !isdefined( level.zm_ai_spawn_lists[ aispawnlist ] ) )
    {
        var_c72bc39c5e17db97 = aispawnlist;
        ailist = hashcat( %"zmaispawnlist:", aispawnlist );
    }
    
    if ( isdefined( level.zm_ai_spawn_lists[ ailist ] ) )
    {
        if ( level.zm_ai_spawn_lists[ ailist ].size <= 0 )
        {
            return false;
        }
        
        foreach ( var_99cf9b3fde8243ce in level.zm_ai_spawn_lists[ ailist ] )
        {
            var_c72bc39c5e17db97 = var_99cf9b3fde8243ce.var_c72bc39c5e17db97;
            ailist = hashcat( %"zmaispawnlist:", var_c72bc39c5e17db97 );
            
            if ( isdefined( level.zm_ai_spawn_lists[ ailist ] ) )
            {
                if ( !function_f566149de5039773( ailist ) )
                {
                    return false;
                }
            }
            
            return true;
        }
    }
    
    return true;
}

// Namespace namespace_c7157c2cd884c5d5
// Params 1
// Checksum 0xfaa8b238, Offset: 0x9c2
// Size: 0x1c2
function function_e0abfec4a095a04b( aispawnlist )
{
    var_73a56df61d877b3b = [];
    ailist = aispawnlist;
    
    if ( !isdefined( level.zm_ai_spawn_lists[ aispawnlist ] ) )
    {
        var_c72bc39c5e17db97 = aispawnlist;
        ailist = hashcat( %"zmaispawnlist:", aispawnlist );
    }
    
    if ( isdefined( level.zm_ai_spawn_lists[ ailist ] ) )
    {
        foreach ( var_99cf9b3fde8243ce in level.zm_ai_spawn_lists[ ailist ] )
        {
            var_c72bc39c5e17db97 = var_99cf9b3fde8243ce.var_c72bc39c5e17db97;
            ailist = hashcat( %"zmaispawnlist:", var_c72bc39c5e17db97 );
            
            if ( isdefined( level.zm_ai_spawn_lists[ ailist ] ) )
            {
                foreach ( ai_subclass in function_e0abfec4a095a04b( var_c72bc39c5e17db97 ) )
                {
                    ai_subclass = function_3fbdda7b775ce416( ai_subclass );
                    var_73a56df61d877b3b = arraycombineunique( var_73a56df61d877b3b, [ ai_subclass ] );
                }
                
                continue;
            }
            
            var_c72bc39c5e17db97 = function_3fbdda7b775ce416( var_c72bc39c5e17db97 );
            var_73a56df61d877b3b = arraycombineunique( var_73a56df61d877b3b, [ var_c72bc39c5e17db97 ] );
        }
    }
    else
    {
        aispawnlist = function_3fbdda7b775ce416( aispawnlist );
        var_73a56df61d877b3b = arraycombineunique( var_73a56df61d877b3b, [ aispawnlist ] );
    }
    
    return var_73a56df61d877b3b;
}

// Namespace namespace_c7157c2cd884c5d5
// Params 1
// Checksum 0x4cb5d09, Offset: 0xb8d
// Size: 0x47
function function_e05919b47b9a0cda( aicategory )
{
    if ( isdefined( aicategory ) )
    {
        if ( isdefined( level.var_c6d6e983c300b6f0[ aicategory ] ) )
        {
            return level.var_c6d6e983c300b6f0[ aicategory ];
        }
    }
    
    if ( isdefined( level.var_2292921b310dff03 ) )
    {
        return level.var_2292921b310dff03;
    }
    
    return [];
}

// Namespace namespace_c7157c2cd884c5d5
// Params 1, eflags: 0x4
// Checksum 0x7e274042, Offset: 0xbdd
// Size: 0x10e
function private function_3fbdda7b775ce416( subclass )
{
    if ( isdefined( level.var_c35151c62aaf033d ) )
    {
        return ( level.var_c35151c62aaf033d[ subclass ] ?? subclass );
    }
    
    replace_string = getdvar( @"hash_5b9f8512308d472a" );
    
    if ( replace_string.size > 0 )
    {
        level.var_c35151c62aaf033d = [];
        var_858b41882e4314cb = strtok( replace_string, "|" );
        
        foreach ( replace_string in var_858b41882e4314cb )
        {
            map_entry = strtok( replace_string, "->" );
            
            if ( map_entry.size == 2 )
            {
                level.var_c35151c62aaf033d[ map_entry[ 0 ] ] = map_entry[ 1 ];
            }
        }
        
        return ( level.var_c35151c62aaf033d[ subclass ] ?? subclass );
    }
    
    return subclass;
}

