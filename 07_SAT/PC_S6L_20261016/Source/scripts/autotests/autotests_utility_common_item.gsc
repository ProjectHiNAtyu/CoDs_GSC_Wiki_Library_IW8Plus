// scripts\autotests\autotests_utility_common_item.gsc  (hash_117af1647d87ca8e.gscc) (size: 4064 Bytes / 0xfe0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x900abd59 (2416622937)
// size ...... 4064 (0xfe0)
// includes .. 3   (offset: 0xf58)
// strings ... 8   (offset: 0xf70)
// dev strs .. 1   (offset: 0xfd4)
// exports ... 14  (offset: 0xa80)
// cseg ...... 0x91 + 0x9ef (0xa80)
// imports ... 21  (offset: 0xcb0)
// animtree1 . 0   (offset: 0xfe0)
// animtree2 . 0   (offset: 0xfe0)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\common\utility;

#namespace autotests_utility_common_item;

// Namespace autotests_utility_common_item
// Params 2
// Checksum 0xae476579, Offset: 0xaf
// Size: 0xac
function give_money( player, amount )
{
    bundlenames = utility::callsharedfunc( #"game", #"hash_d401e7f98d9f9b30", "currency" );
    
    if ( !bundlenames )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    cashscriptbundle = getscriptbundle( bundlenames[ 0 ] );
    item = utility::callsharedfunc( #"item", #"hash_5a146360fa1d97ab", cashscriptbundle, amount );
    player utility::callsharedfunc( #"game", #"hash_6a1940cb87219089", item, 0, undefined, bundlenames[ 0 ], cashscriptbundle );
}

// Namespace autotests_utility_common_item
// Params 2
// Checksum 0x75f0dfab, Offset: 0x163
// Size: 0xa2
function get_item( itembundle, params )
{
    itemtype = utility::callsharedfunc( #"game", #"hash_dca65b23d72fe65f", itembundle );
    currentitem = utility::callsharedfunc( #"item", #"hash_d7e5d2a8b89b1a12", itemtype, params );
    
    if ( currentitem )
    {
        if ( !isdefined( currentitem.count ) )
        {
            currentitem.count = function_1403fd2e6dbaa0fb( itemtype, itembundle.ref );
        }
        
        currentitem.type = itemtype;
    }
    
    return currentitem;
}

// Namespace autotests_utility_common_item
// Params 2
// Checksum 0x92a37685, Offset: 0x20e
// Size: 0x32
function get_item_count( itembundle, params )
{
    item = get_item( itembundle, params );
    return function_322b5c81a9941a9( item );
}

// Namespace autotests_utility_common_item
// Params 1
// Checksum 0x16a1937f, Offset: 0x249
// Size: 0x29, Type: bool
function function_322b5c81a9941a9( item )
{
    return item.durability ?? item.count ?? 0;
}

// Namespace autotests_utility_common_item
// Params 2
// Checksum 0xc339ba24, Offset: 0x27b
// Size: 0x45
function function_fbd90a5b84876756( var_f0cfde08205d95ae, count )
{
    itembundle = utility::callsharedfunc( #"item", #"hash_21d84c663ac62eac", var_f0cfde08205d95ae );
    function_f510913b7f5822a9( itembundle, count );
}

// Namespace autotests_utility_common_item
// Params 2
// Checksum 0x49805729, Offset: 0x2c8
// Size: 0x31
function function_f7143f1888dba389( itembundlename, count )
{
    itembundle = getscriptbundle( itembundlename );
    function_f510913b7f5822a9( itembundle, count );
}

// Namespace autotests_utility_common_item
// Params 2
// Checksum 0x747c41fa, Offset: 0x301
// Size: 0x57
function function_f510913b7f5822a9( itembundle, count )
{
    item = utility::callsharedfunc( #"item", #"hash_5a146360fa1d97ab", itembundle, count );
    utility::callsharedfunc( #"game", #"obtainitem", item );
}

// Namespace autotests_utility_common_item
// Params 0
// Checksum 0x4f5dcdea, Offset: 0x360
// Size: 0x1b
function clear_all_loot()
{
    utility::callsharedfunc( #"item", #"hash_b291851ae2542542" );
}

// Namespace autotests_utility_common_item
// Params 0
// Checksum 0x799210ca, Offset: 0x383
// Size: 0x61
function clear_inventory()
{
    spawnoptions = utility::callsharedfunc( #"game", #"initSpawnOptions_SpawnFromPosition", self.origin, self.angles );
    spawnoptions.isdeathevent = 1;
    utility::callsharedfunc( #"inventory", #"hash_5b6cd96a11db0f50", spawnoptions );
}

// Namespace autotests_utility_common_item
// Params 2
// Checksum 0x5e34bc33, Offset: 0x3ec
// Size: 0xac
function function_92d66ed1629b0979( location, radius )
{
    lootarray = getlootscriptablearrayinradius( undefined, undefined, location, radius );
    
    foreach ( loot in lootarray )
    {
        utility::callsharedfunc( #"game", #"hash_46d169cc2f231f1b", loot );
    }
}

// Namespace autotests_utility_common_item
// Params 3
// Checksum 0x581ba246, Offset: 0x4a0
// Size: 0x431
function function_5ac354a32140c47d( var_ee029599f431ebc, var_6f1a4a54084497c1, var_1ec26bf0bc8ee188 )
{
    var_72560e287bceeb86 = 1;
    var_9762422296b3a89c = getdvar( @"hash_b4a29fd19945acf9", "" );
    
    if ( var_9762422296b3a89c && var_9762422296b3a89c != "" )
    {
        var_da1a8e52789b93ae = undefined;
        lootoverrides = strtok( var_9762422296b3a89c, "," );
        
        foreach ( lootoverride in lootoverrides )
        {
            if ( !var_da1a8e52789b93ae )
            {
                var_da1a8e52789b93ae = [];
                var_72560e287bceeb86 = 0;
            }
            
            bundlename = utility::callsharedfunc( #"game", #"getItemBundleNameFromRef", lootoverride );
            var_da1a8e52789b93ae[ var_da1a8e52789b93ae.size ] = bundlename;
        }
    }
    
    var_4dacd80f693331dd = [];
    
    foreach ( var_72af030d02d0baa0 in var_ee029599f431ebc )
    {
        var_bae6352f785d7b2c = getscriptbundle( var_72af030d02d0baa0.loottype );
        var_4dacd80f693331dd[ var_4dacd80f693331dd.size ] = var_bae6352f785d7b2c.typeref;
    }
    
    bundlenames = [];
    itemrefs = [];
    
    foreach ( bundlename in var_da1a8e52789b93ae ?? level.commonitem.var_1a1b8354fa1e275c )
    {
        itembundle = getscriptbundle( bundlename );
        
        if ( var_72560e287bceeb86 )
        {
            var_2f890415f5ea8120 = 0;
            
            foreach ( var_16097595a08c4882 in var_6f1a4a54084497c1 )
            {
                if ( var_16097595a08c4882.itemref == itembundle.ref )
                {
                    var_2f890415f5ea8120 = 1;
                    break;
                }
            }
            
            if ( var_2f890415f5ea8120 )
            {
                continue;
            }
        }
        
        itemtype = utility::callsharedfunc( #"game", #"hash_dca65b23d72fe65f", itembundle );
        
        if ( var_72560e287bceeb86 )
        {
            var_d004f1ff483d6641 = 0;
            
            foreach ( var_270f4c8d117b5e90 in var_1ec26bf0bc8ee188 )
            {
                if ( var_270f4c8d117b5e90.subtype == itembundle.subtype )
                {
                    var_d004f1ff483d6641 = 1;
                    break;
                }
            }
            
            if ( var_d004f1ff483d6641 )
            {
                continue;
            }
            
            if ( !arraycontains( var_4dacd80f693331dd, itemtype ) )
            {
                continue;
            }
        }
        
        if ( function_3f148667e2289988( itembundle.scriptable ) )
        {
            continue;
        }
        
        itemref = itembundle.ref;
        bundlenamestring = autotests::as_string( bundlename );
        bundlenamestring = strtok( bundlenamestring, ":" )[ 1 ];
        bundlenames[ bundlenames.size ] = bundlenamestring;
        itemrefs[ itemrefs.size ] = itemref;
    }
    
    return { #itemrefs:itemrefs, #bundlenames:bundlenames };
}

// Namespace autotests_utility_common_item
// Params 2, eflags: 0x4
// Checksum 0x9e0baf00, Offset: 0x8da
// Size: 0x62
function private function_1403fd2e6dbaa0fb( itemtype, itemref )
{
    if ( itemtype == "perk" )
    {
        return ( isdefined( self.perks[ itemref ] ) ? 1 : 0 );
    }
    else if ( itemtype == "ammo" )
    {
        return utility::callsharedfunc( #"game", #"hash_51e235f4d43bef2d", self, itemref );
    }
    
    return 0;
}

// Namespace autotests_utility_common_item
// Params 3
// Checksum 0x63835618, Offset: 0x945
// Size: 0x13b
function function_923f6b80a7d17409( type, index, var_e58c3fa6d542fad8 )
{
    var_c80738c7478ba43a = utility::callsharedfunc( #"game", #"hash_d401e7f98d9f9b30", "weapon" );
    count = 0;
    projectstring = autotests_utility::function_2da7d4694fda2fdd() + "_";
    
    foreach ( var_c218def7b6eb54ad in var_c80738c7478ba43a )
    {
        bundle = getscriptbundlefieldvalues( var_c218def7b6eb54ad, [ #"ref", #"subtype" ] );
        
        if ( !var_e58c3fa6d542fad8 && !issubstr( bundle.ref, projectstring ) )
        {
            continue;
        }
        
        if ( bundle.subtype == type )
        {
            if ( count == index )
            {
                return getscriptbundle( var_c218def7b6eb54ad );
            }
            
            count++;
        }
    }
}

