// scripts\common\activity_nexus\activity_scriptables.gsc  (hash_4a2005cdcbf64b88.gscc) (size: 3907 Bytes / 0xf43 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x87d3fb85 (2278816645)
// size ...... 3907 (0xf43)
// includes .. 3   (offset: 0xe97)
// strings ... 5   (offset: 0xeaf)
// dev strs .. 5   (offset: 0xefb)
// exports ... 12  (offset: 0x98f)
// cseg ...... 0xbd + 0x8d2 (0x98f)
// imports ... 27  (offset: 0xb6f)
// animtree1 . 0   (offset: 0xf43)
// animtree2 . 0   (offset: 0xf43)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;

#namespace activity_scriptables;

// Namespace activity_scriptables
// Params 4
// Checksum 0x9d4a54b, Offset: 0xdb
// Size: 0x69
function function_e54570745bff582e( activityinstance, scriptablename, origin = activity_instance_common::function_776ee11e7acc64a5( activityinstance ), destructionmoment = "InstanceEnd" )
{
    scriptable = spawnscriptable( scriptablename, origin );
    
    if ( isdefined( scriptable ) )
    {
        function_114d59757e8d7bd9( activityinstance, scriptable, destructionmoment );
        return scriptable;
    }
}

// Namespace activity_scriptables
// Params 3
// Checksum 0x1b4c77d6, Offset: 0x14d
// Size: 0x45
function function_114d59757e8d7bd9( activityinstance, scriptable, destructionmoment = "None" )
{
    if ( isdefined( scriptable ) )
    {
        function_b7a788ba5a3202b1( activityinstance, scriptable, destructionmoment );
        function_25bcf6b5031ad254( activityinstance, scriptable );
    }
}

// Namespace activity_scriptables
// Params 3
// Checksum 0x915c072f, Offset: 0x19a
// Size: 0x92
function function_f71912f49638e206( activityinstance, scriptables, destructionmoment )
{
    foreach ( scriptable in scriptables )
    {
        function_114d59757e8d7bd9( activityinstance, scriptable, destructionmoment );
    }
}

// Namespace activity_scriptables
// Params 3
// Checksum 0x6c557204, Offset: 0x234
// Size: 0x58
function function_12e3c036c773688f( activityinstance, interactscriptables, var_e9b114d9c38b5cb9 )
{
    if ( !isarray( interactscriptables ) )
    {
        interactscriptables = [ interactscriptables ];
    }
    
    activity_common::function_cb0bd0d51905badf( interactscriptables, activityinstance );
    
    if ( var_e9b114d9c38b5cb9 )
    {
        function_f71912f49638e206( activityinstance, interactscriptables, "ActivityEnd" );
    }
    
    activity_participation::function_6c92bb685deb5c9b( activityinstance );
}

// Namespace activity_scriptables
// Params 5
// Checksum 0xb5754265, Offset: 0x294
// Size: 0x131
function function_529e41b4ec8c6ed1( activityinstance, activitymoment, scriptable, partname, statename )
{
    var_fc5ddfcbfbf81ca9 = function_b7a788ba5a3202b1( activityinstance, scriptable );
    
    if ( !scriptable getscriptablehaspart( partname ) )
    {
        assertmsg( "<dev string:x24>" + partname + "<dev string:x3a>" + scriptable.index );
        return;
    }
    
    if ( !isdefined( var_fc5ddfcbfbf81ca9.partnames[ partname ] ) )
    {
        var_fc5ddfcbfbf81ca9.partnames[ partname ] = [];
    }
    
    if ( isdefined( statename ) )
    {
        if ( !scriptable getscriptableparthasstate( partname, statename ) )
        {
            assertmsg( "<dev string:x7b>" + statename + "<dev string:x92>" + partname + "<dev string:xcd>" + scriptable.index );
            return;
        }
        
        var_fc5ddfcbfbf81ca9.partnames[ partname ][ activitymoment ] = statename;
        return;
    }
    
    if ( !scriptable getscriptableparthasstate( partname, activitymoment ) )
    {
        assertmsg( "<dev string:x7b>" + activitymoment + "<dev string:x92>" + partname + "<dev string:xcd>" + scriptable.index );
        return;
    }
    
    var_fc5ddfcbfbf81ca9.partnames[ partname ][ activitymoment ] = activitymoment;
}

// Namespace activity_scriptables
// Params 2
// Checksum 0x5e260a50, Offset: 0x3cd
// Size: 0x1ec
function function_a7d7e6902efa9fe5( activityinstance, activitymoment )
{
    var_acf4ce05826be231 = 0;
    
    if ( !isarray( activityinstance.var_d916a0349fb35326 ) )
    {
        return;
    }
    
    foreach ( scriptableid, var_fc5ddfcbfbf81ca9 in activityinstance.var_d916a0349fb35326 )
    {
        if ( !isdefined( var_fc5ddfcbfbf81ca9.scriptable ) )
        {
            activityinstance.var_d916a0349fb35326[ scriptableid ] = undefined;
            var_acf4ce05826be231 = 1;
            continue;
        }
        
        if ( var_fc5ddfcbfbf81ca9.destructionmoment == activitymoment )
        {
            if ( isdefined( var_fc5ddfcbfbf81ca9.scriptable.origin ) )
            {
                level notify( "lootcache_opened_kill_callout" + var_fc5ddfcbfbf81ca9.scriptable.origin );
            }
            
            var_fc5ddfcbfbf81ca9.scriptable freescriptable();
            activityinstance.var_d916a0349fb35326[ scriptableid ] = undefined;
            var_acf4ce05826be231 = 1;
            continue;
        }
        
        foreach ( partname, partinfo in var_fc5ddfcbfbf81ca9.partnames )
        {
            if ( isdefined( partinfo[ activitymoment ] ) )
            {
                var_fc5ddfcbfbf81ca9.scriptable setscriptablepartstate( partname, activitymoment );
            }
        }
    }
    
    if ( var_acf4ce05826be231 )
    {
        activityinstance.var_d916a0349fb35326 = function_f943bef551ff028c( activityinstance.var_d916a0349fb35326 );
        activity_common::function_5293d009a2fe9978( activityinstance );
    }
}

// Namespace activity_scriptables
// Params 1
// Checksum 0x84fb4e58, Offset: 0x5c1
// Size: 0x55
function function_d3f8b8b79398979c( activityinstance )
{
    varianttag = activityinstance.varianttag;
    var_765a52a6c55d1911 = getentitylessscriptablearray( varianttag, #script_noteworthy );
    var_765a52a6c55d1911 = arraycombine( var_765a52a6c55d1911, getscriptablearray( varianttag, #script_noteworthy ) );
    return var_765a52a6c55d1911;
}

// Namespace activity_scriptables
// Params 1
// Checksum 0xbae43272, Offset: 0x61f
// Size: 0x115
function activityscriptablecleanup( activityinstance )
{
    if ( !isarray( activityinstance.var_d916a0349fb35326 ) )
    {
        return;
    }
    
    foreach ( var_fc5ddfcbfbf81ca9 in activityinstance.var_d916a0349fb35326 )
    {
        if ( isdefined( var_fc5ddfcbfbf81ca9.scriptable ) )
        {
            var_acd5b4a64c0a3762 = var_fc5ddfcbfbf81ca9.destructionmoment == "None";
            var_6a2cbb37b4528e5a = !var_acd5b4a64c0a3762;
            
            if ( var_6a2cbb37b4528e5a )
            {
                if ( isdefined( var_fc5ddfcbfbf81ca9.scriptable.origin ) )
                {
                    level notify( "lootcache_opened_kill_callout" + var_fc5ddfcbfbf81ca9.scriptable.origin );
                }
                
                var_fc5ddfcbfbf81ca9.scriptable freescriptable();
            }
        }
    }
}

// Namespace activity_scriptables
// Params 2, eflags: 0x4
// Checksum 0x3aa81a27, Offset: 0x73c
// Size: 0x5c
function private function_f30870e01c9dd498( scriptable, destructionmoment = "None" )
{
    var_fc5ddfcbfbf81ca9 = spawnstruct();
    var_fc5ddfcbfbf81ca9.scriptable = scriptable;
    var_fc5ddfcbfbf81ca9.partnames = [];
    var_fc5ddfcbfbf81ca9.destructionmoment = destructionmoment;
    return var_fc5ddfcbfbf81ca9;
}

// Namespace activity_scriptables
// Params 3, eflags: 0x4
// Checksum 0x65299891, Offset: 0x7a1
// Size: 0xa9
function private function_b7a788ba5a3202b1( activityinstance, scriptable, destructionmoment = "None" )
{
    if ( !isdefined( activityinstance.var_d916a0349fb35326 ) )
    {
        activityinstance.var_d916a0349fb35326 = [];
    }
    
    if ( isdefined( activityinstance.var_d916a0349fb35326[ scriptable.index ] ) )
    {
        return activityinstance.var_d916a0349fb35326[ scriptable.index ];
    }
    
    var_fc5ddfcbfbf81ca9 = function_f30870e01c9dd498( scriptable, destructionmoment );
    activityinstance.var_d916a0349fb35326[ scriptable.index ] = var_fc5ddfcbfbf81ca9;
    return var_fc5ddfcbfbf81ca9;
}

// Namespace activity_scriptables
// Params 2, eflags: 0x4
// Checksum 0x5146b4a7, Offset: 0x853
// Size: 0x13c
function private function_25bcf6b5031ad254( activityinstance, scriptable )
{
    scriptablepartnames = scriptable function_7c320131bd49bb18();
    
    foreach ( partname in scriptablepartnames )
    {
        if ( isstartstr( toupper( partname ), "NEXUSMANAGEDSCRIPTABLEPART" ) )
        {
            var_38c5026e3d88a5d = level.activities.activitymoments;
            
            foreach ( activitymoment in var_38c5026e3d88a5d )
            {
                if ( scriptable getscriptableparthasstate( partname, activitymoment ) )
                {
                    function_529e41b4ec8c6ed1( activityinstance, activitymoment, scriptable, partname );
                }
            }
        }
    }
}

