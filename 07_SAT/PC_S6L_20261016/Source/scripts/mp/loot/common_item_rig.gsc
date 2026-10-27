// scripts\mp\loot\common_item_rig.gsc  (hash_654331b73425c043.gscc) (size: 5792 Bytes / 0x16a0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x65aec33a (1705952058)
// size ...... 5792 (0x16a0)
// includes .. 7   (offset: 0x15e0)
// strings ... 6   (offset: 0x1618)
// dev strs .. 0   (offset: 0x16a0)
// exports ... 16  (offset: 0xedc)
// cseg ...... 0xc9 + 0xe13 (0xedc)
// imports ... 37  (offset: 0x115c)
// animtree1 . 0   (offset: 0x16a0)
// animtree2 . 0   (offset: 0x16a0)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\loot\common_inventory_groups;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;

#namespace common_item_rig;

// Namespace common_item_rig
// Params 0, eflags: 0x5
// Checksum 0x7d55715f, Offset: 0xe7
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"item_rig", #"common_item_database", undefined, &function_355b839b4ac3e514 );
}

// Namespace common_item_rig
// Params 0
// Checksum 0x126d1cf3, Offset: 0x110
// Size: 0x49c
function function_355b839b4ac3e514()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    if ( !hasomnvar( "ui_perk_rig_index" ) )
    {
        return;
    }
    
    common_item::function_4b30c091d3b04a25( "perk_rig" );
    common_item::function_84174b793b5fe9a7( "perk_rig", #"use", &function_345913acfca065c9 );
    common_item::function_84174b793b5fe9a7( "perk_rig", #"canautouse", &function_345913acfca065c9 );
    common_item::function_84174b793b5fe9a7( "perk_rig", #"hash_9e49dfaa7c147654", &function_7f4b195f9f5ac06f );
    common_item::function_84174b793b5fe9a7( "perk_rig", #"getcurrent", &function_15f8358a34a0e49b );
    common_item::function_84174b793b5fe9a7( "perk_rig", #"removecurrent", &function_b0b92104f231af6b );
    common_item::function_84174b793b5fe9a7( "perk_rig", #"getspawncount", &function_8a8fdcc39cb4a0b8 );
    common_item::function_4b30c091d3b04a25( "perk_rig_module" );
    common_item::function_84174b793b5fe9a7( "perk_rig_module", #"use", &function_77cf3c94e20111e5 );
    common_item::function_84174b793b5fe9a7( "perk_rig_module", #"canautouse", &utility::always_false );
    common_item::function_84174b793b5fe9a7( "perk_rig_module", #"hash_9e49dfaa7c147654", &function_50e02e416f9dfceb );
    common_item::function_84174b793b5fe9a7( "perk_rig_module", #"getcurrent", &function_ad775440fdf9c17 );
    level.commonitem.var_ed61472acfd82ccc = [];
    level.commonitem.var_88aaaf8c60ae10a4 = [];
    level.commonitem.var_b51521e94c6ae403 = [];
    firstmodule = undefined;
    moduleslist = common_item::function_62da977131eeed4a( "PERK_RIG_MODULES" );
    
    foreach ( index, entry in moduleslist.itementries )
    {
        itembundlename = getxhashasset( entry.itemspawnentry );
        itembundle = getscriptbundlefieldvalues( itembundlename, [ #"lootitemtype", #"ref" ] );
        
        if ( isdefined( itembundle.lootitemtype ) && isdefined( itembundle.ref ) )
        {
            level.commonitem.var_88aaaf8c60ae10a4[ itembundle.ref ] = index;
            
            if ( !firstmodule )
            {
                firstmodule = itembundle;
            }
        }
    }
    
    rigslist = common_item::function_62da977131eeed4a( "PERK_RIG" );
    
    foreach ( index, entry in rigslist.itementries )
    {
        itembundlename = getxhashasset( entry.itemspawnentry );
        itembundle = getscriptbundlefieldvalues( itembundlename, [ #"lootitemtype", #"ref", #"riggroup" ] );
        
        if ( isdefined( itembundle.lootitemtype ) && isdefined( itembundle.ref ) )
        {
            level.commonitem.var_ed61472acfd82ccc[ itembundle.ref ] = index;
            
            if ( itembundle.riggroup && firstmodule )
            {
                slots = common_inventory_groups::function_c8b5512ec6e3fe49( 3, firstmodule, itembundle.riggroup );
                maxindex = 0;
                
                foreach ( typedata in slots )
                {
                    if ( typedata.index > maxindex )
                    {
                        maxindex = typedata.index;
                    }
                }
                
                level.commonitem.var_b51521e94c6ae403[ itembundle.ref ] = { #maxindex:maxindex, #totalnum:slots.size };
            }
        }
    }
    
    callback::add( #"player_connect", &init_rigs );
}

// Namespace common_item_rig
// Params 1
// Checksum 0x91e5f1c2, Offset: 0x5b4
// Size: 0x41
function init_rigs( params )
{
    self.rigslots = [];
    
    for ( i = 1; i <= 3 ; i++ )
    {
        self setclientomnvar( "ui_perk_rig_module_index_" + i, 0 );
    }
}

// Namespace common_item_rig
// Params 4
// Checksum 0x411e507c, Offset: 0x5fd
// Size: 0x47
function function_77cf3c94e20111e5( itembundle, item, autouse, var_981c264073bf1154 )
{
    result = function_535c5cf271f73840( itembundle );
    return isdefined( result ) ? 0 : 1;
}

// Namespace common_item_rig
// Params 1, eflags: 0x4
// Checksum 0x88c1addc, Offset: 0x64d
// Size: 0x126
function private function_535c5cf271f73840( itembundle )
{
    if ( self.rigslots.size >= self.riglevel )
    {
        return;
    }
    
    currentdata = function_15f8358a34a0e49b();
    rigbundle = common_item::function_90c3e0c1fd55d6b6( currentdata.name );
    var_2bb2b005f8247dc = level.commonitem.var_b51521e94c6ae403[ rigbundle.ref ];
    slotindex = common_inventory_groups::function_76928b4f093ca1ad( 3, itembundle );
    adjustedindex = slotindex - var_2bb2b005f8247dc.maxindex + var_2bb2b005f8247dc.totalnum;
    moduleindex = level.commonitem.var_88aaaf8c60ae10a4[ itembundle.ref ] + 1;
    self setclientomnvar( "ui_perk_rig_module_index_" + adjustedindex, moduleindex );
    self.rigslots[ slotindex ] = itembundle.ref;
    perk = itembundle.moduleperk;
    perk::giveperk( perk );
    return slotindex;
}

// Namespace common_item_rig
// Params 4
// Checksum 0x9e27f6d6, Offset: 0x77c
// Size: 0x28, Type: bool
function function_6c3eff3c2dbd617c( itembundle, item, autouse, allowswap )
{
    return false;
}

// Namespace common_item_rig
// Params 4
// Checksum 0x281cc0df, Offset: 0x7ad
// Size: 0x4e, Type: bool
function function_50e02e416f9dfceb( itembundle, item, autouse, allowswap )
{
    return isdefined( self.rigslots ) && !arraycontains( self.rigslots, itembundle.ref );
}

// Namespace common_item_rig
// Params 1
// Checksum 0x513204e4, Offset: 0x804
// Size: 0x8a
function function_ad775440fdf9c17( params )
{
    if ( !self.rigslots || !isdefined( params.index ) || !isdefined( self.rigslots[ params.index ] ) )
    {
        return;
    }
    
    name = common_item_database::function_a4f0a21951180013( self.rigslots[ params.index ] );
    
    if ( name )
    {
        return { #count:1, #name:name };
    }
}

// Namespace common_item_rig
// Params 4
// Checksum 0xb292398d, Offset: 0x897
// Size: 0x1f6
function function_345913acfca065c9( itembundle, item, autouse, var_981c264073bf1154 )
{
    if ( self.rigtype == itembundle.ref )
    {
        return item.count;
    }
    
    self.rigtype = itembundle.ref;
    self.riglevel = itembundle.riglevel;
    
    foreach ( ref in self.rigslots )
    {
        modulebundle = common_item::function_cf68ad18114498b2( ref );
        perk::removeperk( modulebundle.moduleperk );
    }
    
    self.rigslots = [];
    self setclientomnvar( "ui_perk_rig_index", level.commonitem.var_ed61472acfd82ccc[ itembundle.ref ] + 1 );
    counts = function_dece72af62af6c0e( item );
    totalmodules = 0;
    
    for ( i = 1; i <= 3 ; i++ )
    {
        if ( !counts[ i ] )
        {
            continue;
        }
        
        listentry = common_item::function_5cfa00ddd006df3( "PERK_RIG_MODULES", counts[ i ] - 1 );
        modulebundle = common_item::function_90c3e0c1fd55d6b6( listentry.itemspawnentry );
        moduleindex = function_535c5cf271f73840( modulebundle );
        
        if ( isdefined( moduleindex ) )
        {
            totalmodules++;
        }
    }
    
    for ( i = 1; i <= 3 ; i++ )
    {
        if ( i >= totalmodules + 1 )
        {
            self setclientomnvar( "ui_perk_rig_module_index_" + i, 0 );
        }
    }
    
    return 0;
}

// Namespace common_item_rig
// Params 4
// Checksum 0xa83fa881, Offset: 0xa96
// Size: 0x33, Type: bool
function function_7f4b195f9f5ac06f( itembundle, item, autouse, allowswap )
{
    return isdefined( itembundle.riglevel );
}

// Namespace common_item_rig
// Params 1
// Checksum 0x936949ae, Offset: 0xad2
// Size: 0x6c
function function_15f8358a34a0e49b( params )
{
    if ( !isdefined( self.riglevel ) )
    {
        self.riglevel = 0;
    }
    
    if ( isdefined( self.rigtype ) )
    {
        name = common_item_database::function_a4f0a21951180013( self.rigtype );
        
        if ( isdefined( name ) )
        {
            return { #count:function_9da8dc7fce8488ff(), #name:name };
        }
    }
}

// Namespace common_item_rig
// Params 1
// Checksum 0xb79cfd3, Offset: 0xb47
// Size: 0x10d
function function_b0b92104f231af6b( params )
{
    var_8fb8e1fb220cca48 = function_15f8358a34a0e49b( params );
    
    if ( isdefined( var_8fb8e1fb220cca48 ) )
    {
        self.riglevel = 0;
        self.rigtype = undefined;
        
        foreach ( ref in self.rigslots )
        {
            modulebundle = common_item::function_cf68ad18114498b2( ref );
            perk::removeperk( modulebundle.moduleperk );
        }
        
        self.rigslots = [];
        self setclientomnvar( "ui_perk_rig_index", 0 );
        
        for ( i = 1; i <= 3 ; i++ )
        {
            self setclientomnvar( "ui_perk_rig_module_index_" + i, 0 );
        }
    }
    
    return var_8fb8e1fb220cca48;
}

// Namespace common_item_rig
// Params 2
// Checksum 0x116c0a9a, Offset: 0xc5d
// Size: 0x13a
function function_8a8fdcc39cb4a0b8( itembundle, spawnoptions )
{
    count = 1;
    
    if ( isdefined( itembundle.includedmodules ) )
    {
        i = 0;
        
        foreach ( module in itembundle.includedmodules )
        {
            bundle = common_item::function_90c3e0c1fd55d6b6( module.rigmodule );
            
            if ( isdefined( bundle.ref ) && isdefined( level.commonitem.var_88aaaf8c60ae10a4[ bundle.ref ] ) )
            {
                index = level.commonitem.var_88aaaf8c60ae10a4[ bundle.ref ] + 1;
                count += index << 6 * i + 1;
                i++;
            }
        }
    }
    
    return count;
}

// Namespace common_item_rig
// Params 0, eflags: 0x4
// Checksum 0x1bce3321, Offset: 0xda0
// Size: 0xcf
function private function_9da8dc7fce8488ff()
{
    if ( !isdefined( self.rigslots ) )
    {
        return;
    }
    
    count = 1;
    i = 0;
    
    foreach ( moduleref in self.rigslots )
    {
        index = level.commonitem.var_88aaaf8c60ae10a4[ moduleref ] + 1;
        count += index << 6 * i + 1;
        i++;
    }
    
    return count;
}

// Namespace common_item_rig
// Params 1, eflags: 0x4
// Checksum 0x6e37e11a, Offset: 0xe78
// Size: 0x63
function private function_dece72af62af6c0e( item )
{
    results = [];
    results[ 0 ] = item.count & 1;
    
    for ( i = 0; i < 3 ; i++ )
    {
        results[ results.size ] = item.count >> 6 * i + 1 & 63;
    }
    
    return results;
}

