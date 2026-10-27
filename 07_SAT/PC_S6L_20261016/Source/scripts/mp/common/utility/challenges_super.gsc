// scripts\mp\common\utility\challenges_super.gsc  (hash_04d4114209b393d5.gscc) (size: 1818 Bytes / 0x71a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5d792c94 (1568222356)
// size ...... 1818 (0x71a)
// includes .. 3   (offset: 0x6c6)
// strings ... 1   (offset: 0x6de)
// dev strs .. 4   (offset: 0x6ea)
// exports ... 7   (offset: 0x436)
// cseg ...... 0x60 + 0x3d6 (0x436)
// imports ... 12  (offset: 0x54e)
// animtree1 . 0   (offset: 0x71a)
// animtree2 . 0   (offset: 0x71a)
#using scripts\common\ae_utility;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\loot;

#namespace challenges;

// Namespace challenges
// Params 2
// Checksum 0x1071c99d, Offset: 0x7e
// Size: 0x9f
function tracksuper( superowner, superref )
{
    assert( isdefined( superowner ), "<dev string:x24>" );
    var_713a8541453e2167 = undefined;
    
    if ( function_7fd275785a2ffef7( superowner, superref ) )
    {
        var_713a8541453e2167 = self.trackedsupers[ superowner getentitynumber() ];
    }
    else
    {
        var_713a8541453e2167 = {};
        var_713a8541453e2167.superrefs = [];
        var_713a8541453e2167.owner = superowner;
    }
    
    var_713a8541453e2167.superrefs[ var_713a8541453e2167.superrefs.size ] = superref;
    self.trackedsupers[ superowner getentitynumber() ] = var_713a8541453e2167;
}

// Namespace challenges
// Params 2
// Checksum 0xe24970a, Offset: 0x125
// Size: 0xc1
function function_ead174660f144273( superowner, superref )
{
    assert( isdefined( superowner ), "<dev string:x5b>" );
    
    if ( !isdefined( self.trackedsupers ) )
    {
        return;
    }
    
    var_713a8541453e2167 = self.trackedsupers[ superowner getentitynumber() ];
    
    if ( !isdefined( var_713a8541453e2167 ) )
    {
        return;
    }
    
    var_dc57a7bae073c636 = function_f02c63b99c9614c9( var_713a8541453e2167.superrefs, superref );
    
    if ( isdefined( var_dc57a7bae073c636 ) )
    {
        var_713a8541453e2167.superrefs[ var_dc57a7bae073c636 ] = undefined;
        
        if ( isint( var_dc57a7bae073c636 ) )
        {
            function_cdc669dbc8ea2101( var_713a8541453e2167.superrefs );
        }
    }
    
    if ( var_713a8541453e2167.superrefs.size <= 0 )
    {
        self.trackedsupers[ superowner getentitynumber() ] = undefined;
    }
}

// Namespace challenges
// Params 2, eflags: 0x4
// Checksum 0xd231f75a, Offset: 0x1ee
// Size: 0x6b
function private function_7fd275785a2ffef7( superowner, superref )
{
    assert( isdefined( superowner ), "<dev string:x8f>" );
    
    if ( !isdefined( self.trackedsupers ) )
    {
        return 0;
    }
    
    var_713a8541453e2167 = self.trackedsupers[ superowner getentitynumber() ];
    
    if ( !isdefined( var_713a8541453e2167 ) )
    {
        return 0;
    }
    
    return arraycontains( var_713a8541453e2167.superrefs, superref );
}

// Namespace challenges
// Params 0
// Checksum 0xa6a0de85, Offset: 0x262
// Size: 0x6e
function function_325e4020b7ae07dc()
{
    if ( isdefined( self ) && isdefined( self.super.staticdata.ref ) && self.super.isactive )
    {
        return loot::getlootidfromref( self.super.staticdata.ref );
    }
    
    return loot::getlootidfromref( "none" );
}

// Namespace challenges
// Params 2
// Checksum 0x3441a96a, Offset: 0x2d9
// Size: 0x114
function function_dda82f6314e2674d( superowner, superbitfield )
{
    assert( isdefined( superowner ), "<dev string:xd2>" );
    
    if ( !isdefined( self.trackedsupers ) )
    {
        return superbitfield;
    }
    
    var_5e419791e9b1c3db = self.trackedsupers[ superowner getentitynumber() ];
    
    if ( !isdefined( var_5e419791e9b1c3db ) )
    {
        return superbitfield;
    }
    
    processedrefs = [];
    
    foreach ( superref in var_5e419791e9b1c3db.superrefs )
    {
        if ( arraycontains( processedrefs, superref ) )
        {
            continue;
        }
        
        var_73e8352552addfb6 = function_a51f112509bff672( superref );
        
        if ( var_73e8352552addfb6 <= 0 )
        {
            continue;
        }
        
        superbitfield = function_a23641f33e985edb( superbitfield, var_73e8352552addfb6 );
        processedrefs[ processedrefs.size ] = superref;
    }
    
    return superbitfield;
}

// Namespace challenges
// Params 1, eflags: 0x4
// Checksum 0x35a8e695, Offset: 0x3f6
// Size: 0x3f, Type: bool
function private function_a51f112509bff672( superref )
{
    return ae_utility::function_2d1565a236387b2( #"supers_bitfield", level.superglobals.staticsuperdata[ superref ].var_4298b03a50e4e614 ) ?? 0;
}

