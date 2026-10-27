// scripts\mp\loot\common_item_database.gsc  (hash_50bca8faff139478.gscc) (size: 4886 Bytes / 0x1316 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb7d2e530 (3084051760)
// size ...... 4886 (0x1316)
// includes .. 6   (offset: 0x11fe)
// strings ... 3   (offset: 0x122e)
// dev strs .. 15  (offset: 0x1252)
// exports ... 10  (offset: 0xbca)
// cseg ...... 0x7e + 0xb4c (0xbca)
// imports ... 38  (offset: 0xd5a)
// animtree1 . 0   (offset: 0x1316)
// animtree2 . 0   (offset: 0x1316)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;

#namespace common_item_database;

// Namespace common_item_database
// Params 0, eflags: 0x5
// Checksum 0x65310032, Offset: 0x9c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"common_item_database", #"common_item", undefined, &items_database_init );
}

// Namespace common_item_database
// Params 0, eflags: 0x4
// Checksum 0xadd0f61c, Offset: 0xc5
// Size: 0x634
function private items_database_init()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    utility::registersharedfunc( #"game", #"hash_35447656b103dd34", &function_db2360bc1c33f6f9 );
    utility::registersharedfunc( #"game", #"hash_2d6603ce4710caa8", &function_ca9ca606e66b5911 );
    utility::registersharedfunc( #"game", #"getItemBundleNameFromRef", &function_a4f0a21951180013 );
    utility::registersharedfunc( #"game", #"hash_d401e7f98d9f9b30", &function_eb5323bad2b41c84 );
    level.commonitem.var_47078f33898179f4 = [];
    level.commonitem.var_1a1b8354fa1e275c = [];
    level.commonitem.var_4d60369c227dcd1e = [];
    level.commonitem.var_10dd9382f338e3e0 = [];
    var_b9af18a63e8b59d3 = getscriptbundlenames( #"itemspawnentry" );
    
    foreach ( itembundlename in var_b9af18a63e8b59d3 )
    {
        itembundle = getscriptbundlefieldvalues( itembundlename, [ #"lootitemtype", #"hash_b9a3752dc7a3d626", #"scriptable", #"perplayerscriptable", #"ref", #"pingvo", #"hash_3b8e9a2077424ab8" ] );
        itemtype = common_item::function_16e8c106491eeaca( itembundle );
        
        /#
            if ( isdefined( itembundle ) )
            {
                var_bb4f2f9c57088ad4 = common_item::function_c6f3ef3dcb4c55c0( itemtype, #"hash_3483a973fd1fe5b8" );
                
                if ( isdefined( var_bb4f2f9c57088ad4 ) )
                {
                    [[ var_bb4f2f9c57088ad4 ]]( itembundlename );
                }
                else
                {
                    common_item::function_d211b8a8f539dff2( itembundlename );
                }
            }
        #/
        
        var_47c9eb2097781ff8 = common_item::function_c6f3ef3dcb4c55c0( itemtype, #"database_additem" );
        
        if ( var_47c9eb2097781ff8 )
        {
            [[ var_47c9eb2097781ff8 ]]( itembundlename );
        }
        
        callback::callback( #"hash_91012fd98c668c5f", { #itembundlename:itembundlename } );
        
        if ( itembundle.var_74421e5967d993a3 )
        {
            continue;
        }
        
        var_50a70553dc1ffbce = [ itembundle.scriptable, itembundle.perplayerscriptable ];
        
        foreach ( var_d9de565385a73372 in var_50a70553dc1ffbce )
        {
            if ( var_d9de565385a73372 )
            {
                /#
                    if ( isdefined( level.commonitem.var_1a1b8354fa1e275c[ var_d9de565385a73372 ] ) )
                    {
                        if ( getdvarint( @"hash_11a180966b9141dd" ) > 1 )
                        {
                            print( "<dev string:x24>" + getxhashsourcename( level.commonitem.var_1a1b8354fa1e275c[ var_d9de565385a73372 ] ) + "<dev string:x5f>" + getxhashsourcename( itembundlename ) + "<dev string:x67>" + getxhashsourcename( var_d9de565385a73372 ) + "<dev string:x73>" );
                        }
                    }
                #/
                
                if ( !isdefined( level.commonitem.var_1a1b8354fa1e275c[ var_d9de565385a73372 ] ) )
                {
                    level.commonitem.var_1a1b8354fa1e275c[ var_d9de565385a73372 ] = itembundlename;
                }
            }
        }
        
        if ( itembundle.ref )
        {
            if ( !level.commonitem.var_4d60369c227dcd1e[ itembundle.ref ] )
            {
                var_ea9275e365a250ae = [ " " ];
                
                foreach ( character in var_ea9275e365a250ae )
                {
                    if ( issubstr( itembundle.ref, character ) )
                    {
                        assertmsg( "<dev string:xd1>" + getxhashsourcename( itembundlename ) + "<dev string:xe4>" + character + "<dev string:x114>" );
                    }
                }
                
                level.commonitem.var_4d60369c227dcd1e[ itembundle.ref ] = itembundlename;
                lootidtype = common_item::function_c973dc1cb0ad3375( itembundle );
                
                if ( !isdefined( lootidtype ) )
                {
                    assertmsg( "<dev string:x117>" + getxhashsourcename( itembundlename ) + "<dev string:x129>" );
                    continue;
                }
                
                lootid = common_item::items_getlootidfromref( itembundle.ref );
                
                if ( isdefined( lootid ) )
                {
                    level.commonitem.var_47078f33898179f4[ lootid ] = itembundlename;
                }
                
                if ( !isdefined( level.commonitem.var_10dd9382f338e3e0[ itemtype ] ) )
                {
                    level.commonitem.var_10dd9382f338e3e0[ itemtype ] = [];
                }
                
                level.commonitem.var_10dd9382f338e3e0[ itemtype ][ level.commonitem.var_10dd9382f338e3e0[ itemtype ].size ] = itembundlename;
            }
            else
            {
                /#
                    if ( getdvarint( @"hash_11a180966b9141dd" ) > 1 )
                    {
                        print( "<dev string:x24>" + getxhashsourcename( level.commonitem.var_4d60369c227dcd1e[ itembundle.ref ] ) + "<dev string:x5f>" + getxhashsourcename( itembundlename ) + "<dev string:x67>" + itembundle.ref + "<dev string:x148>" );
                    }
                #/
            }
            
            continue;
        }
        
        if ( common_inventory::inventory_isenabled() && common_item::function_5cf4e552f9e871f1( itembundle ) )
        {
            assertmsg( "<dev string:x117>" + getxhashsourcename( itembundlename ) + "<dev string:x18b>" );
        }
    }
    
    function_bb8519086922ab67();
    function_c011bfa5eb68f626();
    utility::flag_set( "items_database_init" );
}

// Namespace common_item_database
// Params 0
// Checksum 0xea2d0cf2, Offset: 0x701
// Size: 0x1a5
function function_c011bfa5eb68f626()
{
    var_d38ff638b3800677 = level.gametypebundle.var_3842463aacfdc5ca;
    var_f4b7731809d459f2 = level.gametypebundle.var_f1c87cb6c2385550;
    
    foreach ( entry in var_f4b7731809d459f2 )
    {
        if ( isdefined( entry.map ) )
        {
            mapinfobundle = getmapinfobundle( entry.map );
            
            if ( mapinfobundle.mapname == level.mapname )
            {
                var_d38ff638b3800677 = entry.zones;
                break;
            }
        }
    }
    
    if ( !isdefined( var_d38ff638b3800677 ) )
    {
        return;
    }
    
    level.commonitem.raritydefs = function_75ab90a1d95beb88();
    level.commonitem.var_1df326001ae22d9f = [];
    
    for ( i = 0; i < level.commonitem.raritydefs.size ; i++ )
    {
        raritydef = level.commonitem.raritydefs[ i ];
        
        if ( raritydef.rarityref )
        {
            level.commonitem.var_1df326001ae22d9f[ raritydef.rarityref ] = i;
        }
    }
}

// Namespace common_item_database
// Params 0
// Checksum 0x8e7d4620, Offset: 0x8ae
// Size: 0x216
function function_bb8519086922ab67()
{
    var_d38ff638b3800677 = level.gametypebundle.var_3842463aacfdc5ca;
    var_f4b7731809d459f2 = level.gametypebundle.var_f1c87cb6c2385550;
    
    foreach ( entry in var_f4b7731809d459f2 )
    {
        if ( isdefined( entry.map ) )
        {
            mapinfobundle = getmapinfobundle( entry.map );
            
            if ( mapinfobundle.mapname == level.mapname )
            {
                var_d38ff638b3800677 = entry.zones;
                break;
            }
        }
    }
    
    if ( !isdefined( var_d38ff638b3800677 ) )
    {
        /#
            logstring( "<dev string:x1f9>" );
        #/
        
        return;
    }
    
    var_c1be14654061530c = getscriptbundlefieldvalues( var_d38ff638b3800677, [ #"hash_11eb633eb96632df" ] );
    
    if ( !isdefined( var_c1be14654061530c.zonedefs ) )
    {
        /#
            logstring( "<dev string:x238>" + getxhashsourcename( var_d38ff638b3800677 ) );
        #/
        
        return;
    }
    
    foreach ( entry in var_c1be14654061530c.zonedefs )
    {
        if ( entry.zonename == "global" )
        {
            level.commonitem.var_f4a0cd0e44af4832 = entry.zonedef;
            
            /#
                logstring( "<dev string:x261>" + entry.zonedef );
            #/
            
            return;
        }
    }
    
    /#
        logstring( "<dev string:x284>" + getxhashsourcename( var_d38ff638b3800677 ) );
    #/
}

// Namespace common_item_database
// Params 1
// Checksum 0x69d67cd5, Offset: 0xacc
// Size: 0x39, Type: bool
function function_9eeb5b816d2c20c0( scriptablename )
{
    if ( !common_item::items_isenabled() )
    {
        return false;
    }
    
    if ( !isdefined( scriptablename ) )
    {
        return false;
    }
    
    if ( isstring( scriptablename ) )
    {
        scriptablename = getxhashasset( scriptablename );
    }
    
    return isdefined( function_c1ead8fef1e8da23( scriptablename ) );
}

// Namespace common_item_database
// Params 1
// Checksum 0x7d4a7f03, Offset: 0xb0e
// Size: 0x53
function function_db2360bc1c33f6f9( lootid )
{
    lootidtype = loot::function_52cf8374c44a4ff5( lootid );
    
    if ( isdefined( lootidtype ) )
    {
        funcoverride = common_item::function_c6f3ef3dcb4c55c0( lootidtype, #"bundlenamefromlootid" );
        
        if ( isdefined( funcoverride ) )
        {
            return [[ funcoverride ]]( lootid );
        }
    }
    
    return function_697f4e30c025bf6c( lootid );
}

// Namespace common_item_database
// Params 1
// Checksum 0xa38c56fd, Offset: 0xb6a
// Size: 0x2a
function function_ca9ca606e66b5911( scriptablename )
{
    if ( isstring( scriptablename ) )
    {
        scriptablename = getxhashasset( scriptablename );
    }
    
    if ( isdefined( scriptablename ) )
    {
        return function_c1ead8fef1e8da23( scriptablename );
    }
}

// Namespace common_item_database
// Params 1
// Checksum 0x91a77e5b, Offset: 0xb9c
// Size: 0x12
function function_a4f0a21951180013( ref )
{
    return function_ad2a5237ae8ed35e( ref );
}

// Namespace common_item_database
// Params 1
// Checksum 0x3f32869b, Offset: 0xbb7
// Size: 0x12
function function_eb5323bad2b41c84( itemtype )
{
    return function_b79f7feabd9df55d( itemtype );
}

