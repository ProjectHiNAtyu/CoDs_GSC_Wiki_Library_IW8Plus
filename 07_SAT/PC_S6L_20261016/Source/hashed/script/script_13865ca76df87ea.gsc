// script_13865ca76df87ea  (hash_013865ca76df87ea.gscc) (size: 5617 Bytes / 0x15f1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x533bf53e (1396438334)
// size ...... 5617 (0x15f1)
// includes .. 3   (offset: 0x14b1)
// strings ... 5   (offset: 0x14c9)
// dev strs .. 11  (offset: 0x1539)
// exports ... 15  (offset: 0xef5)
// cseg ...... 0xaf + 0xe46 (0xef5)
// imports ... 25  (offset: 0x114d)
// animtree1 . 0   (offset: 0x15f1)
// animtree2 . 0   (offset: 0x15f1)
#using script_4880fce3c83f33ef;
#using scripts\common\utility;
#using scripts\common\weapon;

#namespace namespace_de7b719e85d98dcc;

// Namespace namespace_de7b719e85d98dcc
// Params 2
// Checksum 0xc1c9190f, Offset: 0xcd
// Size: 0x12a
function genericblueprint_getweaponname( blueprintname, weaponkey )
{
    var_5e58db3f1d89b126 = function_568f797e7642c672( "genericblueprint", blueprintname );
    
    if ( !isdefined( var_5e58db3f1d89b126 ) )
    {
        /#
            errortext = "<dev string:x24>" + getxhashsourcename( blueprintname ) + "<dev string:x4a>";
            iprintln( errortext );
        #/
        
        return;
    }
    
    foreach ( entry in var_5e58db3f1d89b126.weaponlist )
    {
        if ( entry.key == weaponkey )
        {
            if ( entry.weapon == "" )
            {
                return;
            }
            
            return entry.weapon;
        }
    }
    
    /#
        errortext = "<dev string:x4c>" + getxhashsourcename( weaponkey ) + "<dev string:x6c>" + getxhashsourcename( blueprintname ) + "<dev string:x4a>";
        iprintln( errortext );
    #/
}

// Namespace namespace_de7b719e85d98dcc
// Params 2
// Checksum 0x272b77b4, Offset: 0x200
// Size: 0x12a
function function_6ebf762b1c13c233( blueprintname, weaponkey )
{
    var_5e58db3f1d89b126 = function_568f797e7642c672( "genericblueprint", blueprintname );
    
    if ( !isdefined( var_5e58db3f1d89b126 ) )
    {
        /#
            errortext = "<dev string:x24>" + getxhashsourcename( blueprintname ) + "<dev string:x4a>";
            iprintln( errortext );
        #/
        
        return;
    }
    
    foreach ( entry in var_5e58db3f1d89b126.weaponlist )
    {
        if ( entry.key == weaponkey )
        {
            if ( entry.weaponblueprint == "" )
            {
                return;
            }
            
            return entry.weaponblueprint;
        }
    }
    
    /#
        errortext = "<dev string:x4c>" + getxhashsourcename( weaponkey ) + "<dev string:x6c>" + getxhashsourcename( blueprintname ) + "<dev string:x4a>";
        iprintln( errortext );
    #/
}

// Namespace namespace_de7b719e85d98dcc
// Params 3
// Checksum 0x89d154da, Offset: 0x333
// Size: 0x145
function function_9756c22d39f3dee5( var_9ef7d13c3e8cc57d, vehiclekey, vehicleasset )
{
    var_5e58db3f1d89b126 = function_568f797e7642c672( "genericblueprint", var_9ef7d13c3e8cc57d );
    
    if ( !isdefined( var_5e58db3f1d89b126 ) )
    {
        /#
            errortext = "<dev string:x24>" + getxhashsourcename( var_9ef7d13c3e8cc57d ) + "<dev string:x4a>";
            iprintln( errortext );
        #/
        
        return;
    }
    
    foreach ( entry in var_5e58db3f1d89b126.vehiclelist )
    {
        if ( entry.key == vehiclekey && entry.vehicle == vehicleasset )
        {
            if ( entry.vehicleblueprint == "" )
            {
                return;
            }
            
            return entry.vehicleblueprint;
        }
    }
    
    /#
        errortext = "<dev string:x89>" + getxhashsourcename( vehiclekey ) + "<dev string:x6c>" + getxhashsourcename( var_9ef7d13c3e8cc57d ) + "<dev string:x4a>";
        iprintln( errortext );
    #/
}

// Namespace namespace_de7b719e85d98dcc
// Params 2, eflags: 0x4
// Checksum 0xca3442c4, Offset: 0x481
// Size: 0xbf
function private genericblueprint_getassetlist( bundle, assettype )
{
    switch ( assettype )
    {
        case #"xmodel":
            return bundle.xmodellist;
        case #"vfx":
            return bundle.vfxlist;
        case #"string":
            return bundle.stringlist;
        case #"suit":
            return bundle.suitlist;
        case #"execution":
            return bundle.executionlist;
        default:
            /#
                errortext = "<dev string:xaa>";
                iprintln( errortext );
            #/
            
            return;
    }
}

// Namespace namespace_de7b719e85d98dcc
// Params 3
// Checksum 0x6c973dfc, Offset: 0x548
// Size: 0x151
function function_4854a08f7de8f427( blueprintname, assettype, key )
{
    if ( !blueprintname )
    {
        return;
    }
    
    var_5e58db3f1d89b126 = function_568f797e7642c672( "genericblueprint", blueprintname );
    
    if ( !isdefined( var_5e58db3f1d89b126 ) )
    {
        /#
            errortext = "<dev string:x24>" + getxhashsourcename( blueprintname ) + "<dev string:x4a>";
            iprintln( errortext );
        #/
        
        return;
    }
    
    assetlist = genericblueprint_getassetlist( var_5e58db3f1d89b126, assettype );
    
    foreach ( entry in assetlist )
    {
        if ( entry.key == key )
        {
            if ( entry.value == "" )
            {
                return;
            }
            
            return entry.value;
        }
    }
    
    /#
        errortext = "<dev string:xcb>" + getxhashsourcename( assettype ) + "<dev string:xeb>" + getxhashsourcename( key ) + "<dev string:xfc>" + getxhashsourcename( blueprintname ) + "<dev string:x4a>";
        iprintln( errortext );
    #/
}

// Namespace namespace_de7b719e85d98dcc
// Params 5, eflags: 0x4
// Checksum 0x6bfd43fb, Offset: 0x6a2
// Size: 0x253
function private function_b3905478f8de412f( weaponname, weaponblueprintname, attachmentname, attachmentblueprintname, var_c64b678191de3aeb )
{
    var_2f27bd3a7f87ce27 = undefined;
    
    if ( isdefined( weaponblueprintname ) )
    {
        weaponblueprintnames = getweaponblueprintnames( weaponname );
        
        foreach ( name, index in weaponblueprintnames )
        {
            if ( name == weaponblueprintname )
            {
                var_2f27bd3a7f87ce27 = index;
                break;
            }
        }
    }
    
    if ( var_c64b678191de3aeb )
    {
        return weapon::buildweapon( weaponname, undefined, undefined, undefined, var_2f27bd3a7f87ce27 );
    }
    
    attachmentarray = [];
    var_72605096676c9381 = [];
    
    if ( isdefined( attachmentname ) )
    {
        attachmentarray = [ attachmentname ];
        var_72605096676c9381 = [ 0 ];
    }
    
    if ( isdefined( attachmentname ) && isdefined( attachmentblueprintname ) && isdefined( weaponblueprintname ) )
    {
        weaponblueprintattachmentnames = function_6a820129c91338cb( weaponname, weaponblueprintname );
        
        foreach ( name, index in weaponblueprintattachmentnames )
        {
            if ( name == attachmentname )
            {
                var_72605096676c9381 = [ index ];
                break;
            }
        }
    }
    
    defaultattachments = getweapondefaultattachments( weaponname );
    
    foreach ( attachment in defaultattachments )
    {
        for ( i = 0; i < attachmentarray.size ; i++ )
        {
            if ( attachment == attachmentarray[ i ] )
            {
                break;
            }
        }
        
        if ( i == attachmentarray.size )
        {
            attachmentarray[ attachmentarray.size ] = attachment;
            var_72605096676c9381[ var_72605096676c9381.size ] = 0;
        }
    }
    
    return makeweapon( weaponname, attachmentarray, undefined, undefined, var_2f27bd3a7f87ce27, var_72605096676c9381 );
}

// Namespace namespace_de7b719e85d98dcc
// Params 2
// Checksum 0x9f302008, Offset: 0x8fe
// Size: 0xa1
function function_9800c005d17e1d42( bundle, blueprintindex )
{
    genericblueprintname = undefined;
    
    if ( bundle.genericblueprintlist.blueprints.size > 0 && blueprintindex > 0 )
    {
        genericblueprintname = bundle.genericblueprintlist.blueprints[ blueprintindex - 1 ].genericblueprint;
    }
    else if ( isdefined( bundle.genericblueprintlist.blueprint_default ) )
    {
        genericblueprintname = bundle.genericblueprintlist.blueprint_default;
    }
    
    return genericblueprintname;
}

// Namespace namespace_de7b719e85d98dcc
// Params 2
// Checksum 0xa9e89847, Offset: 0x9a8
// Size: 0x1df
function genericblueprint_makeweapon( blueprintname, weaponkey )
{
    if ( isdefined( blueprintname ) && isdefined( weaponkey ) )
    {
        var_5e58db3f1d89b126 = function_568f797e7642c672( "genericblueprint", blueprintname );
        weaponentry = undefined;
        
        foreach ( weaponlistentry in var_5e58db3f1d89b126.weaponlist )
        {
            if ( weaponlistentry.key == weaponkey )
            {
                weaponentry = weaponlistentry;
                break;
            }
        }
        
        if ( !isdefined( weaponentry ) )
        {
            /#
                utility::error( "<dev string:x116>" + getxhashsourcename( blueprintname ) );
            #/
            
            return;
        }
        
        weaponname = weaponentry.weapon != "" ? weaponentry.weapon : undefined;
        weaponblueprintname = weaponentry.weaponblueprint != "" ? weaponentry.weaponblueprint : undefined;
        attachmentname = weaponentry.attachment != "" ? weaponentry.attachment : undefined;
        attachmentblueprintname = weaponentry.attachmentblueprint != "" ? weaponentry.attachmentblueprint : undefined;
        return function_b3905478f8de412f( weaponname, weaponblueprintname, attachmentname, attachmentblueprintname, weaponentry.var_c64b678191de3aeb );
    }
    
    if ( !isdefined( blueprintname ) )
    {
        utility::error( "blueprintName not specified" );
    }
    
    if ( !isdefined( weaponkey ) )
    {
        utility::error( "weaponKey not specified" );
    }
    
    return;
}

// Namespace namespace_de7b719e85d98dcc
// Params 3
// Checksum 0x559b044f, Offset: 0xb8f
// Size: 0x82
function function_59f0aef415632a71( grenade, weaponkey, bundle = grenade.bundle )
{
    if ( isdefined( grenade.weapon_object.variantid ) && isdefined( bundle ) )
    {
        blueprintname = function_9800c005d17e1d42( bundle, grenade.weapon_object.variantid );
        return genericblueprint_makeweapon( blueprintname, weaponkey );
    }
}

// Namespace namespace_de7b719e85d98dcc
// Params 1
// Checksum 0xa82084f3, Offset: 0xc19
// Size: 0xc7
function function_e10d8bdee3cb8f64( genericblueprintname )
{
    if ( !isdefined( genericblueprintname ) )
    {
        return;
    }
    
    genericblueprint = function_568f797e7642c672( "genericblueprint", genericblueprintname );
    
    foreach ( vfx in genericblueprint_getassetlist( genericblueprint, #"vfx" ) )
    {
        utility::add_fx( genericblueprintname + ":" + vfx.key, vfx.value );
    }
}

// Namespace namespace_de7b719e85d98dcc
// Params 1
// Checksum 0x4c85fe1a, Offset: 0xce8
// Size: 0xdb
function function_2cc937b1eb09aabb( bundle )
{
    defaultblueprintname = bundle.genericblueprintlist.blueprint_default;
    function_e10d8bdee3cb8f64( defaultblueprintname );
    
    if ( isdefined( bundle.genericblueprintlist.blueprints ) )
    {
        foreach ( blueprint in bundle.genericblueprintlist.blueprints )
        {
            function_e10d8bdee3cb8f64( blueprint.genericblueprint );
        }
    }
}

// Namespace namespace_de7b719e85d98dcc
// Params 4
// Checksum 0xdebe5f2c, Offset: 0xdcb
// Size: 0x58
function genericblueprint_playfx( bundle, blueprintindex, vfxkey, position )
{
    genericblueprintname = function_9800c005d17e1d42( bundle, blueprintindex );
    playfx( utility::getfx( getxhashhexname( genericblueprintname ) + ":" + vfxkey ), position );
}

// Namespace namespace_de7b719e85d98dcc
// Params 2
// Checksum 0x13d170b0, Offset: 0xe2b
// Size: 0x3c
function function_5bf49f3d5bab75bc( bundle, blueprintindex )
{
    genericblueprintname = function_9800c005d17e1d42( bundle, blueprintindex );
    blueprintdefindex = getgenericblueprintdefindex( genericblueprintname );
    return blueprintdefindex;
}

// Namespace namespace_de7b719e85d98dcc
// Params 3
// Checksum 0x6bb2de88, Offset: 0xe70
// Size: 0x85
function function_ee125f945df9bdbc( var_9ef7d13c3e8cc57d, vehiclekey, vehicleasset )
{
    vehicle = self;
    assert( isdefined( var_9ef7d13c3e8cc57d ) && isdefined( vehiclekey ) && isdefined( vehicleasset ) );
    vehicleblueprintasset = function_9756c22d39f3dee5( var_9ef7d13c3e8cc57d, vehiclekey, vehicleasset );
    
    if ( !isdefined( vehicleblueprintasset ) )
    {
        /#
            utility::error( "<dev string:x148>" + getxhashsourcename( var_9ef7d13c3e8cc57d ) );
        #/
        
        return;
    }
    
    vehicle function_c8661270973a8e60( vehicleblueprintasset );
    vehicle namespace_258c393149f2e837::function_6f973aa5086dcf35();
}

