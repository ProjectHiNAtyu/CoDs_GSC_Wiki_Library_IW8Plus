// scripts\mp\loot\common_item_resource.gsc  (hash_0bc9158c8b87c0b1.gscc) (size: 9806 Bytes / 0x264e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbd600f9f (3177189279)
// size ...... 9806 (0x264e)
// includes .. 10  (offset: 0x24d2)
// strings ... 14  (offset: 0x2522)
// dev strs .. 5   (offset: 0x25fe)
// exports ... 25  (offset: 0x18de)
// cseg ...... 0x16e + 0x1770 (0x18de)
// imports ... 67  (offset: 0x1cc6)
// animtree1 . 0   (offset: 0x264e)
// animtree2 . 0   (offset: 0x264e)
#using scripts\common\callbacks;
#using scripts\common\dev;
#using scripts\common\system;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\mp\challenges;
#using scripts\mp\dmz\modified_values;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_inventory_groups;
#using scripts\mp\loot\common_item;

#namespace item_resource;

// Namespace item_resource
// Params 0, eflags: 0x5
// Checksum 0x636819f9, Offset: 0x18c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"item_resource", #"common_item", &init, undefined );
}

// Namespace item_resource
// Params 0
// Checksum 0x112f70c5, Offset: 0x1b5
// Size: 0x152
function init()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    common_item::function_4b30c091d3b04a25( "resource" );
    common_item::function_84174b793b5fe9a7( "resource", #"use", &function_337dd1aaf65806ec );
    common_item::function_84174b793b5fe9a7( "resource", #"canautouse", &function_e33017d8db152344 );
    common_item::function_84174b793b5fe9a7( "resource", #"hash_9e49dfaa7c147654", &function_1b81915944ff6ced );
    common_item::function_84174b793b5fe9a7( "resource", #"caninteract", &function_e13142d99ea4a1d1 );
    common_item::function_84174b793b5fe9a7( "resource", #"hash_9886eb1395647ce1", &function_8535b3a6e6adef54 );
    common_item::function_84174b793b5fe9a7( "resource", #"hash_3459376aa4403b66", &function_83aefa41912c342e );
    common_item::function_84174b793b5fe9a7( "resource", #"database_additem", &function_80a5bd4594d5c3d0 );
    common_item::function_84174b793b5fe9a7( "resource", #"getcurrent", &get_current_resource );
    common_item::function_84174b793b5fe9a7( "resource", #"removecurrent", &remove_current_resource );
    common_item::function_84174b793b5fe9a7( "resource", #"hash_2d3b76ff260f2d68", &function_7640a1ba4219ecc );
    thread function_d1d0e3f6a0b5656f();
    callback::add( #"backpack_size_changed", &backpack_size_changed );
    
    /#
        level thread dev::devcommandwatcher( @"debug_resource", &debug_resource );
    #/
}

// Namespace item_resource
// Params 0, eflags: 0x4
// Checksum 0x8d15779f, Offset: 0x30f
// Size: 0x267
function private function_d1d0e3f6a0b5656f()
{
    level endon( #"game_ended" );
    level.var_6278d6b729a8b5ba = [];
    
    if ( common_inventory_groups::inventorygroup_enabled() )
    {
        while ( !isdefined( level.inventorygroupings ) )
        {
            waitframe();
        }
        
        foreach ( bundlename, _ in level.inventorygroupings[ "RESOURCES" ] )
        {
            resourcegroup = getscriptbundle( bundlename );
            totalslots = common_inventory_groups::function_19a5a29f5cd0df45( resourcegroup );
            
            if ( !isdefined( totalslots ) )
            {
                continue;
            }
            
            for ( i = 0; i < totalslots ; i++ )
            {
                [ row, column ] = common_inventory_groups::function_12ee5af12df204b4( resourcegroup, i );
                
                if ( isdefined( row ) && isdefined( column ) )
                {
                    typedata = common_inventory_groups::function_ec48255a23c8526f( common_inventory_groups::function_62e8f7d021e6a61e( resourcegroup, row, column ) );
                    
                    if ( !isdefined( typedata ) )
                    {
                        continue;
                    }
                    
                    resourceitem = utility::array_get_first_item( typedata.alloweditems );
                    
                    if ( !isdefined( resourceitem ) )
                    {
                        continue;
                    }
                    
                    itembundle = getscriptbundlefieldvalues( resourceitem.itemspawnentry, [ #"RESOURCES" ] );
                    
                    if ( !isdefined( itembundle.resources ) )
                    {
                        continue;
                    }
                    
                    resourcedata = utility::array_get_first_item( itembundle.resources );
                    resourceref = getscriptbundlefieldvalue( resourcedata.printtype, #"hash_72cba0cf4d3a6992" );
                    
                    if ( !isdefined( resourceref ) )
                    {
                        continue;
                    }
                    
                    if ( !isdefined( level.var_6278d6b729a8b5ba[ bundlename ] ) )
                    {
                        level.var_6278d6b729a8b5ba[ bundlename ] = [];
                    }
                    
                    level.var_6278d6b729a8b5ba[ bundlename ][ resourceref ] = i;
                }
            }
        }
        
        return;
    }
    
    level.var_6278d6b729a8b5ba[ "synthetics" ] = 0;
    level.var_6278d6b729a8b5ba[ "electronics" ] = 1;
    level.var_6278d6b729a8b5ba[ "chemicals" ] = 2;
    level.var_6278d6b729a8b5ba[ "metals" ] = 3;
}

// Namespace item_resource
// Params 1, eflags: 0x4
// Checksum 0xbfd7c20c, Offset: 0x57e
// Size: 0x99
function private function_80a5bd4594d5c3d0( itembundlename )
{
    if ( !isdefined( level.var_369bb2cf01ce7896 ) )
    {
        level.var_369bb2cf01ce7896 = [];
    }
    
    resourcebundle = getscriptbundle( itembundlename );
    
    if ( resourcebundle.subtype == "crunched" )
    {
        var_312a62dc8d63897a = utility::array_get_first_item( resourcebundle.resources );
        resourceref = getscriptbundlefieldvalue( var_312a62dc8d63897a.printtype, #"hash_72cba0cf4d3a6992" );
        
        if ( isdefined( resourceref ) )
        {
            level.var_369bb2cf01ce7896[ resourceref ] = resourcebundle;
        }
    }
}

// Namespace item_resource
// Params 4, eflags: 0x4
// Checksum 0xb077a96d, Offset: 0x61f
// Size: 0x4a5
function private function_337dd1aaf65806ec( itembundle, item, autouse, var_981c264073bf1154 )
{
    if ( !isdefined( itembundle.subtype ) )
    {
        return item.count;
    }
    
    switch ( itembundle.subtype )
    {
        case #"hash_42384c01b5af5a60":
            if ( !isdefined( itembundle.resources ) )
            {
                return 0;
            }
            
            foreach ( resource in itembundle.resources )
            {
                if ( resource.printtype )
                {
                    resourcebundle = getscriptbundlefieldvalues( resource.printtype, [ #"hash_d73369e4833ca2f3" ] );
                    
                    if ( resourcebundle )
                    {
                        resourceref = getscriptbundlefieldvalue( resource.printtype, #"hash_72cba0cf4d3a6992" );
                        var_8bb099a2716b00a8 = getscriptbundlefieldvalues( resourcebundle.var_c333dd09b1896b44, [ #"ref", #"scriptable", #"rarity", #"lootitemtype" ] );
                        
                        if ( var_8bb099a2716b00a8.ref == itembundle.ref )
                        {
                            return;
                        }
                        
                        resourceamount = resource.value * item.count;
                        resourceamount = int( modified_values::function_14d05d73e63e1f9e( 5, resourceamount ) );
                        maxresource = common_inventory::function_98120ff3aa5f552e( resourceref );
                        overflow = resourceamount + self.var_f9027633b61e4fb7[ resourceref ] - maxresource;
                        
                        if ( overflow > 0 && isdefined( self.perks[ "specialty_trait_resource_management" ] ) )
                        {
                            lowestresource = maxresource;
                            
                            foreach ( key, resource in self.var_f9027633b61e4fb7 )
                            {
                                if ( resource < lowestresource )
                                {
                                    lowestresource = resource;
                                    minkey = key;
                                }
                            }
                            
                            function_d9226b137ba7c285( ceil( resourceamount * 0.2 ), minkey );
                        }
                        
                        baseitem = common_item::function_77600f92048df72d( var_8bb099a2716b00a8, resourceamount );
                        baseitem.fromground = item.fromground;
                        common_item::function_96119bed8ab4c5d9( baseitem, undefined, 1, 1 );
                        resourcetype = resourceref ?? baseitem.type ?? #"unspecified";
                        callbackparams = { #isspend:0, #currencytype:getxhash( resourcetype ), #amount:resourceamount, #sourceitem:item };
                        telemetry_utils::function_af2d366f9522f76f( #"hash_751cd4a063920b00", callbackparams );
                        function_5d1cc48c5d6f1ef2( resourceamount, resourcetype );
                    }
                }
            }
            
            return 0;
        case #"hash_1b09ca2458ea15a9":
            itembundle = common_item::function_6b8ff3d5f2688336( item );
            var_83379e9ab8ee1a6 = undefined;
            
            foreach ( resourceref, var_126bdf247ed1c2c3 in level.var_369bb2cf01ce7896 )
            {
                if ( var_126bdf247ed1c2c3.ref == itembundle.ref )
                {
                    var_83379e9ab8ee1a6 = resourceref;
                    break;
                }
            }
            
            if ( !isdefined( var_83379e9ab8ee1a6 ) )
            {
                return 0;
            }
            
            if ( isdefined( self.perks[ "specialty_trait_higher_value_resources" ] ) )
            {
                item.count = int( ceil( item.count * level.perkbundles[ "specialty_trait_higher_value_resources" ].resourcemod ) );
            }
            
            function_d9226b137ba7c285( item.count, var_83379e9ab8ee1a6 );
            return 0;
        default:
            break;
    }
    
    return item.count;
}

// Namespace item_resource
// Params 4, eflags: 0x4
// Checksum 0x70b70146, Offset: 0xacd
// Size: 0x7d, Type: bool
function private function_e33017d8db152344( itembundle, item, autouse, allowswap )
{
    if ( isdefined( itembundle.subtype ) )
    {
        switch ( itembundle.subtype )
        {
            case #"hash_1b09ca2458ea15a9":
            case #"hash_42384c01b5af5a60":
                return istrue( itembundle.autopickupenabled );
            default:
                return false;
        }
    }
    
    return false;
}

// Namespace item_resource
// Params 4, eflags: 0x4
// Checksum 0x45e209ae, Offset: 0xb53
// Size: 0x4d, Type: bool
function private function_1b81915944ff6ced( itembundle, item, autouse, allowswap )
{
    return itembundle.subtype == "crunchable" || itembundle.subtype == "crunched";
}

// Namespace item_resource
// Params 1, eflags: 0x4
// Checksum 0x1c9dd005, Offset: 0xba9
// Size: 0x1a3, Type: bool
function private function_e13142d99ea4a1d1( params )
{
    itembundle = params.itembundle;
    
    if ( isdefined( itembundle.subtype ) )
    {
        switch ( itembundle.subtype )
        {
            case #"hash_1b09ca2458ea15a9":
            case #"hash_42384c01b5af5a60":
                if ( isdefined( params.togroup ) && params.togroup == 0 )
                {
                    return true;
                }
                
                if ( isdefined( self.perks[ "specialty_trait_resource_management" ] ) )
                {
                    return true;
                }
                
                foreach ( resource in itembundle.resources )
                {
                    resourcebundle = getscriptbundlefieldvalues( resource.printtype, [ #"hash_72cba0cf4d3a6992" ] );
                    
                    if ( !resourcebundle.resourceref )
                    {
                        continue;
                    }
                    
                    currentcount = isdefined( self.var_f9027633b61e4fb7 ) ? self.var_f9027633b61e4fb7[ resourcebundle.resourceref ] : undefined;
                    
                    if ( isdefined( currentcount ) && currentcount >= common_inventory::function_98120ff3aa5f552e( resourcebundle.resourceref ) )
                    {
                        return false;
                    }
                }
                
                return true;
            default:
                return true;
        }
    }
    
    return true;
}

// Namespace item_resource
// Params 2, eflags: 0x4
// Checksum 0xfc3d030e, Offset: 0xd55
// Size: 0x22e
function private function_8535b3a6e6adef54( item, togroup )
{
    itembundle = common_item::function_6b8ff3d5f2688336( item );
    
    if ( !isdefined( itembundle ) )
    {
        return [ item, togroup ];
    }
    
    if ( isdefined( itembundle.subtype ) )
    {
        switch ( itembundle.subtype )
        {
            case #"hash_42384c01b5af5a60":
                items = [];
                
                if ( !isdefined( itembundle.resources ) )
                {
                    return [ undefined, togroup ];
                }
                
                foreach ( resource in itembundle.resources )
                {
                    if ( resource.printtype )
                    {
                        resourcebundle = getscriptbundlefieldvalues( resource.printtype, [ #"hash_d73369e4833ca2f3" ] );
                        
                        if ( resourcebundle )
                        {
                            var_8bb099a2716b00a8 = getscriptbundlefieldvalues( resourcebundle.var_c333dd09b1896b44, [ #"ref", #"scriptable", #"rarity", #"lootitemtype" ] );
                            
                            if ( var_8bb099a2716b00a8.ref == itembundle.ref )
                            {
                                return [ undefined, togroup ];
                            }
                            
                            resourceamount = resource.value * item.count;
                            items[ items.size ] = common_item::function_77600f92048df72d( var_8bb099a2716b00a8, resourceamount );
                        }
                    }
                }
                
                if ( items.size <= 0 )
                {
                    return [ item, togroup ];
                }
                
                return [ items, togroup ];
            default:
                return [ item, togroup ];
        }
    }
    
    return [ item, togroup ];
}

// Namespace item_resource
// Params 1, eflags: 0x4
// Checksum 0x2f53f08b, Offset: 0xf8c
// Size: 0xdb
function private function_83aefa41912c342e( itembundle )
{
    if ( isdefined( itembundle.subtype ) )
    {
        switch ( itembundle.subtype )
        {
            case #"hash_1b09ca2458ea15a9":
                if ( !isdefined( itembundle.resources ) || itembundle.resources.size == 0 || !itembundle.resources[ 0 ].printtype )
                {
                    break;
                }
                
                resourcebundle = getscriptbundlefieldvalues( itembundle.resources[ 0 ].printtype, [ #"hash_72cba0cf4d3a6992" ] );
                
                if ( !isdefined( resourcebundle ) )
                {
                    break;
                }
                
                return common_inventory::function_98120ff3aa5f552e( resourcebundle.resourceref );
            default:
                break;
        }
    }
}

// Namespace item_resource
// Params 2, eflags: 0x4
// Checksum 0x563278c, Offset: 0x1070
// Size: 0x6b
function private function_1ec71d288e6fb29( index, bundlename )
{
    if ( bundlename && level.var_6278d6b729a8b5ba[ bundlename ] )
    {
        var_7237854e3be197ca = function_f02c63b99c9614c9( level.var_6278d6b729a8b5ba[ bundlename ], index );
        
        if ( isdefined( var_7237854e3be197ca ) )
        {
            return var_7237854e3be197ca;
        }
        
        return;
    }
    
    var_7237854e3be197ca = function_f02c63b99c9614c9( level.var_6278d6b729a8b5ba, index );
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
}

// Namespace item_resource
// Params 1
// Checksum 0xe4788257, Offset: 0x10e4
// Size: 0x18
function function_f117580b04feee18( resourceref )
{
    return level.var_369bb2cf01ce7896[ resourceref ];
}

// Namespace item_resource
// Params 1, eflags: 0x4
// Checksum 0x46a32dc9, Offset: 0x1105
// Size: 0xcc
function private get_current_resource( params )
{
    if ( !isdefined( params.index ) )
    {
        return;
    }
    
    resourceref = function_1ec71d288e6fb29( params.index, params.bundlename );
    
    if ( !isdefined( resourceref ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_f9027633b61e4fb7 ) )
    {
        self.var_f9027633b61e4fb7 = [];
    }
    
    if ( !isdefined( self.var_f9027633b61e4fb7[ resourceref ] ) )
    {
        self.var_f9027633b61e4fb7[ resourceref ] = 0;
    }
    
    itembundle = function_f117580b04feee18( resourceref );
    name = common_item::function_e044c3e813daec3a( itembundle );
    
    if ( isdefined( name ) )
    {
        return { #count:self.var_f9027633b61e4fb7[ resourceref ], #name:name };
    }
}

// Namespace item_resource
// Params 1, eflags: 0x4
// Checksum 0x7ec79a14, Offset: 0x11d9
// Size: 0x68
function private remove_current_resource( params )
{
    if ( !isdefined( params.index ) )
    {
        return;
    }
    
    resourceref = function_1ec71d288e6fb29( params.index, params.bundlename );
    
    if ( !isdefined( resourceref ) )
    {
        return;
    }
    
    function_4a4da1a990be3889( ( params.count ?? 0 ) * -1, resourceref );
}

// Namespace item_resource
// Params 1, eflags: 0x4
// Checksum 0xd67b8908, Offset: 0x1249
// Size: 0x6d
function private function_71274de14bf963bc( resourceref )
{
    switch ( resourceref )
    {
        case #"hash_66523394350edcdd":
            return "ui_resource_metal";
        case #"hash_e73bcaf52848ff6c":
            return "ui_resource_electronics";
        case #"hash_c5e1fd26c3d58ad6":
            return "ui_resource_chem";
        case #"hash_a397c9cd49586131":
            return "ui_resource_synthetics";
        default:
            break;
    }
}

// Namespace item_resource
// Params 2
// Checksum 0x1c12e39c, Offset: 0x12bf
// Size: 0xa4
function function_5d1cc48c5d6f1ef2( amount, resourceref )
{
    resourcebundle = function_f117580b04feee18( resourceref );
    
    if ( resourcebundle.resources && resourcebundle.resources.size == 1 )
    {
        resourcetype = resourcebundle.resources[ 0 ].printtype;
        typebundle = getscriptbundle( resourcetype );
        
        if ( typebundle && typebundle.challengebit )
        {
            challenges::function_ee942a83ee5ecf19( self, amount, typebundle.challengebit );
        }
    }
}

// Namespace item_resource
// Params 2
// Checksum 0x9d7d6aee, Offset: 0x136b
// Size: 0x29
function function_d9226b137ba7c285( amount, resourceref )
{
    function_4a4da1a990be3889( amount, resourceref );
    function_5d1cc48c5d6f1ef2( amount, resourceref );
}

// Namespace item_resource
// Params 2
// Checksum 0x4839e582, Offset: 0x139c
// Size: 0xac
function function_4a4da1a990be3889( amount, resourceref )
{
    if ( !isdefined( amount ) || !isdefined( resourceref ) )
    {
        assertmsg( "<dev string:x24>" + ( amount ?? "<dev string:x6a>" ) + "<dev string:x74>" + ( resourceref ?? "<dev string:x6a>" ) + "<dev string:x8a>" );
        return;
    }
    
    if ( !isdefined( self.var_f9027633b61e4fb7 ) )
    {
        self.var_f9027633b61e4fb7 = [];
    }
    
    if ( !isdefined( self.var_f9027633b61e4fb7[ resourceref ] ) )
    {
        self.var_f9027633b61e4fb7[ resourceref ] = 0;
    }
    
    newamount = self.var_f9027633b61e4fb7[ resourceref ] + amount;
    function_d8f2b4c7d4c07204( newamount, resourceref );
}

// Namespace item_resource
// Params 2, eflags: 0x4
// Checksum 0x60591a44, Offset: 0x1450
// Size: 0xc1
function private function_d8f2b4c7d4c07204( amount, resourceref )
{
    if ( !isdefined( amount ) || !isdefined( resourceref ) )
    {
        assertmsg( "<dev string:x8d>" + ( amount ?? "<dev string:x6a>" ) + "<dev string:x74>" + ( resourceref ?? "<dev string:x6a>" ) + "<dev string:x8a>" );
        return;
    }
    
    maxval = common_inventory::function_98120ff3aa5f552e( resourceref );
    
    if ( !isdefined( self.var_f9027633b61e4fb7 ) )
    {
        self.var_f9027633b61e4fb7 = [];
    }
    
    self.var_f9027633b61e4fb7[ resourceref ] = int( max( 0, min( amount, maxval ) ) );
    omnvar = function_71274de14bf963bc( resourceref );
    self setclientomnvar( omnvar, self.var_f9027633b61e4fb7[ resourceref ] );
}

// Namespace item_resource
// Params 1, eflags: 0x4
// Checksum 0x2e75038d, Offset: 0x1519
// Size: 0x1c, Type: bool
function private function_a797bfece7d2d097( ref )
{
    return self.var_f9027633b61e4fb7[ ref ] ?? 0;
}

// Namespace item_resource
// Params 1, eflags: 0x4
// Checksum 0x361dd8cb, Offset: 0x153e
// Size: 0x104
function private backpack_size_changed( params )
{
    if ( self.var_6b0d64da08c0a623 )
    {
        return;
    }
    
    spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
    
    foreach ( ref, var_1a0d0ffa3d7a3548 in level.var_369bb2cf01ce7896 )
    {
        var_7a0d2800aca3a50a = common_inventory::function_98120ff3aa5f552e( ref );
        currentcount = function_a797bfece7d2d097( ref );
        var_9afaa0c09341a192 = currentcount - var_7a0d2800aca3a50a;
        
        if ( var_9afaa0c09341a192 > 0 )
        {
            newamount = int( min( var_7a0d2800aca3a50a, currentcount ) );
            function_d8f2b4c7d4c07204( newamount, ref );
            common_item::function_61c2c0251e742ffd( var_1a0d0ffa3d7a3548, var_9afaa0c09341a192, spawnoptions );
        }
    }
    
    common_inventory::function_12e0a32239019ac2();
}

// Namespace item_resource
// Params 5, eflags: 0x4
// Checksum 0x4bd57b6f, Offset: 0x164a
// Size: 0x4d
function private function_7640a1ba4219ecc( index, itembundle, lootid, quantity, fromgroup )
{
    if ( itembundle.var_a4398f449de22222 )
    {
        thread common_item::function_88fc33fa5edff36e( index, itembundle, lootid, quantity, fromgroup );
        return;
    }
}

// Namespace item_resource
// Params 0
// Checksum 0x4d66495f, Offset: 0x169f
// Size: 0xc3
function get_valuable_counts()
{
    valuablecount = 0;
    valuablevalue = 0;
    
    for ( i = 0; i < common_inventory::function_9cd65c8312048802() ; i++ )
    {
        lootid = common_inventory::inventory_getlootidatbackpackindex( i );
        quantity = common_inventory::inventory_getquantityatbackpackindex( i );
        
        if ( lootid <= 0 || quantity <= 0 )
        {
            continue;
        }
        
        bundle = common_item::function_b202b16941992cca( lootid, [ #"hash_10b471c64c92ba5b" ] );
        
        if ( bundle.cashvalue > 0 )
        {
            valuablecount += quantity;
            valuablevalue += bundle.cashvalue * quantity;
        }
    }
    
    return [ valuablecount, valuablevalue ];
}

/#

    // Namespace item_resource
    // Params 2, eflags: 0x4
    // Checksum 0xf6e45852, Offset: 0x176b
    // Size: 0x173, Type: dev
    function private debug_resource( command, args )
    {
        switch ( command )
        {
            case #"hash_ba72800f31a3607c":
                count = int( args[ 0 ] ?? 1 );
                type = args[ 1 ];
                
                foreach ( ref, resourcebundle in level.var_369bb2cf01ce7896 )
                {
                    if ( !isdefined( type ) || ref == type )
                    {
                        foreach ( player in level.players )
                        {
                            baseitem = common_item::function_77600f92048df72d( resourcebundle, count );
                            player common_item::function_96119bed8ab4c5d9( baseitem, undefined, 1, 1 );
                        }
                    }
                }
                
                break;
            default:
                break;
        }
    }

#/
