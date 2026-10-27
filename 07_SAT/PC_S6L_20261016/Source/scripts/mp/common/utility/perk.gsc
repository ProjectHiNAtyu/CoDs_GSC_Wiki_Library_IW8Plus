// scripts\mp\common\utility\perk.gsc  (hash_0762e73cd6088bff.gscc) (size: 3227 Bytes / 0xc9b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x694bdae5 (1766578917)
// size ...... 3227 (0xc9b)
// includes .. 2   (offset: 0xb83)
// strings ... 2   (offset: 0xb93)
// dev strs .. 18  (offset: 0xbab)
// exports ... 13  (offset: 0x76b)
// cseg ...... 0x67 + 0x704 (0x76b)
// imports ... 16  (offset: 0x973)
// animtree1 . 0   (offset: 0xc9b)
// animtree2 . 0   (offset: 0xc9b)
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\perks\perks;

#namespace perk;

// Namespace perk
// Params 0
// Checksum 0x5234b178, Offset: 0x85
// Size: 0xb
function perksenabled()
{
    return level.allowperks;
}

// Namespace perk
// Params 3
// Checksum 0xf058e7aa, Offset: 0x99
// Size: 0x128
function giveperk( perkname, parentperk, var_4b2b3dc56d37a58 )
{
    assert( isdefined( perkname ), "<dev string:x24>" );
    assert( perkname != "<dev string:x50>", "<dev string:x5f>" );
    assert( perkname != "<dev string:x9f>", "<dev string:xa4>" );
    var_1181414736c29286 = parentperk ?? perkname;
    
    if ( isdefined( level.perkbundles[ var_1181414736c29286 ] ) )
    {
        self.var_9842326056fd7207 = level.perkbundles[ var_1181414736c29286 ];
        self.var_9842326056fd7207.ref = var_1181414736c29286;
    }
    
    variationbundle = var_4b2b3dc56d37a58 ? function_568f797e7642c672( "perk", var_4b2b3dc56d37a58 ) : undefined;
    
    if ( isdefined( variationbundle ) )
    {
        self.var_9842326056fd7207 = variationbundle;
        self.var_9842326056fd7207.ref = var_1181414736c29286;
    }
    else if ( isdefined( var_4b2b3dc56d37a58 ) )
    {
        assertmsg( "<dev string:xda>" + var_4b2b3dc56d37a58 + "<dev string:xf1>" );
    }
    
    perks::_setperk( perkname, var_4b2b3dc56d37a58 );
    perks::_setextraperks( perkname, var_4b2b3dc56d37a58 );
    self.var_9842326056fd7207 = undefined;
}

// Namespace perk
// Params 0
// Checksum 0x4a076f3a, Offset: 0x1c9
// Size: 0x9
function resetperkpackage()
{
    perkpackage::perkpackage_reset();
}

// Namespace perk
// Params 2
// Checksum 0x3261ca87, Offset: 0x1da
// Size: 0x77
function removeperk( perkname, var_4b2b3dc56d37a58 )
{
    if ( level.gameended )
    {
        return;
    }
    
    assert( isdefined( perkname ), "<dev string:x106>" );
    assert( perkname != "<dev string:x50>", "<dev string:x134>" );
    assert( perkname != "<dev string:x9f>", "<dev string:x164>" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    perks::_unsetperk( perkname, var_4b2b3dc56d37a58 );
    perks::_unsetextraperks( perkname, var_4b2b3dc56d37a58 );
}

// Namespace perk
// Params 1
// Checksum 0x1b5224cd, Offset: 0x259
// Size: 0x1d3
function blockperkfunction( perkname )
{
    assert( isdefined( perkname ), "<dev string:x18a>" );
    assert( perkname != "<dev string:x50>", "<dev string:x1b9>" );
    assert( perkname != "<dev string:x9f>", "<dev string:x1ea>" );
    
    if ( !function_2f0f457290bf8326( perkname ) )
    {
        self.perksblocked[ perkname ] = 1;
    }
    else
    {
        self.perksblocked[ perkname ]++;
    }
    
    if ( self.perksblocked[ perkname ] == 1 && isdefined( self.perks[ perkname ] ) )
    {
        perks::_unsetperkinternal( perkname );
        
        foreach ( perk, array in level.extraperkmap )
        {
            if ( perkname == perk )
            {
                foreach ( extraperk in array )
                {
                    if ( !function_2f0f457290bf8326( extraperk ) )
                    {
                        self.perksblocked[ extraperk ] = 1;
                    }
                    else
                    {
                        self.perksblocked[ extraperk ]++;
                    }
                    
                    if ( self.perksblocked[ extraperk ] == 1 )
                    {
                        perks::_unsetperkinternal( extraperk );
                    }
                }
                
                break;
            }
        }
    }
    
    /#
        level notify( #"hash_b21f590d1568ec6d" );
    #/
}

// Namespace perk
// Params 1
// Checksum 0xa6ac5ceb, Offset: 0x434
// Size: 0x216
function unblockperkfunction( perkname )
{
    assert( isdefined( perkname ), "<dev string:x211>" );
    assert( perkname != "<dev string:x50>", "<dev string:x248>" );
    assert( perkname != "<dev string:x9f>", "<dev string:x281>" );
    assert( function_2f0f457290bf8326( perkname ) && self.perksblocked[ perkname ] > 0 || isdefined( level.perks_suppressasserts ), "<dev string:x2b0>" );
    self.perksblocked[ perkname ]--;
    
    if ( self.perksblocked[ perkname ] == 0 )
    {
        self.perksblocked[ perkname ] = undefined;
        
        if ( isdefined( self.perks[ perkname ] ) )
        {
            perks::_setperkinternal( perkname );
            
            foreach ( perk, array in level.extraperkmap )
            {
                if ( perkname == perk )
                {
                    foreach ( extraperk in array )
                    {
                        assert( function_2f0f457290bf8326( extraperk ) && self.perksblocked[ extraperk ] > 0 || isdefined( level.perks_suppressasserts ), "<dev string:x2e8>" );
                        self.perksblocked[ extraperk ]--;
                        
                        if ( self.perksblocked[ extraperk ] == 0 )
                        {
                            perks::_setperkinternal( extraperk );
                            self.perksblocked[ extraperk ] = undefined;
                        }
                    }
                    
                    break;
                }
            }
        }
    }
    
    /#
        level notify( #"hash_b21f590d1568ec6d" );
    #/
}

// Namespace perk
// Params 1
// Checksum 0x9e99236d, Offset: 0x652
// Size: 0x2b
function getbaseperkname( perkname )
{
    if ( isendstr( perkname, "_ks" ) )
    {
        perkname = getsubstr( perkname, 0, perkname.size - 3 );
    }
    
    return perkname;
}

// Namespace perk
// Params 0
// Checksum 0x9db8f11b, Offset: 0x686
// Size: 0x7
function lightweightscalar()
{
    return 1.06;
}

// Namespace perk
// Params 1
// Checksum 0x30fc5d1c, Offset: 0x696
// Size: 0x19, Type: bool
function function_2f0f457290bf8326( perkname )
{
    return isdefined( self.perksblocked[ perkname ] );
}

// Namespace perk
// Params 0
// Checksum 0x7d1bd285, Offset: 0x6b8
// Size: 0x3c
function function_93baad77ae8e5757()
{
    if ( isdefined( level.gamemodebundle ) )
    {
        return istrue( level.gamemodebundle.perkpackageenabled );
    }
    
    if ( isdefined( level.enableperkpackages ) )
    {
        return level.enableperkpackages;
    }
    
    return 0;
}

// Namespace perk
// Params 0
// Checksum 0x225875c4, Offset: 0x6fd
// Size: 0x32
function function_2d1b2c825510b212()
{
    if ( isdefined( level.gamemodebundle ) )
    {
        return istrue( level.gamemodebundle.var_ed83f0f1668a6ed2 );
    }
    
    return getdvarint( @"hash_7a1dc05c581af6f8", 0 );
}

// Namespace perk
// Params 0
// Checksum 0x2135d42b, Offset: 0x738
// Size: 0x32
function function_2461b046fc74d8de()
{
    if ( level.disableBonusPerks )
    {
        return;
    }
    
    if ( isdefined( level.gamemodebundle ) )
    {
        return istrue( level.gamemodebundle.var_98c12e8c808d91ce );
    }
    
    return 0;
}

