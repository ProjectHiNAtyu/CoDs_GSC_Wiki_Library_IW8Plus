// scripts\mp\loot\common_kiosk_data.gsc  (hash_5bc1d5d7770ff171.gscc) (size: 7105 Bytes / 0x1bc1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe2355ca (237196746)
// size ...... 7105 (0x1bc1)
// includes .. 2   (offset: 0x1a21)
// strings ... 15  (offset: 0x1a31)
// dev strs .. 12  (offset: 0x1b1d)
// exports ... 30  (offset: 0x11e1)
// cseg ...... 0x13e + 0x10a3 (0x11e1)
// imports ... 27  (offset: 0x1691)
// animtree1 . 0   (offset: 0x1bc1)
// animtree2 . 0   (offset: 0x1bc1)
#using scripts\common\utility;
#using scripts\mp\currency;

#namespace common_kiosk_data;

// Namespace common_kiosk_data
// Params 1
// Checksum 0x9442f6c0, Offset: 0x15c
// Size: 0xab
function function_9d041619b6fccf18( buystationref )
{
    if ( isdefined( buystationref ) )
    {
        buystationref = tolower( buystationref );
        
        foreach ( currentindex, currentbuystation in self.var_ecf0a5a3c0076f5a.buyStationList )
        {
            if ( currentbuystation.buystation == buystationref )
            {
                return currentindex;
            }
        }
    }
}

// Namespace common_kiosk_data
// Params 1
// Checksum 0xbe39ffd7, Offset: 0x210
// Size: 0x2c
function function_bc4c6e4a3e7d611a( buystationindex )
{
    return self.var_ecf0a5a3c0076f5a.buyStationList[ buystationindex ].buystation;
}

// Namespace common_kiosk_data
// Params 1
// Checksum 0xac7881a6, Offset: 0x245
// Size: 0x4c
function function_57fdad70d0f27d87( itemref )
{
    itemref = tolower( itemref );
    itemconfig = parseitem( itemref );
    assert( isdefined( itemconfig ), "<dev string:x24>" + itemref + "<dev string:x3c>" );
    return itemconfig.cost;
}

// Namespace common_kiosk_data
// Params 0
// Checksum 0x88667d68, Offset: 0x29a
// Size: 0xec
function initialize()
{
    self.buystationsinuse = [];
    self.additionalbuystations = [];
    self.buystationitems = [];
    self.currentbuystation = undefined;
    self.var_1214e3cb12e122a = [];
    var_dc5b379faf4ea2a1 = getmatchrulesdata( "commonOption", "buyStationList" );
    assert( var_dc5b379faf4ea2a1, "<dev string:x49>" );
    self.var_ecf0a5a3c0076f5a = getscriptbundle( "buystationlist:" + var_dc5b379faf4ea2a1 );
    assert( self.var_ecf0a5a3c0076f5a, "<dev string:x6e>" + var_dc5b379faf4ea2a1 + "<dev string:x94>" );
    var_7e7d0317c62f22e2 = getmatchrulesdata( "commonOption", "buyStationItemList" );
    assert( var_7e7d0317c62f22e2, "<dev string:xa0>" );
    self.var_3439d17c39f493c9 = getscriptbundle( "buystationitemlist:" + var_7e7d0317c62f22e2 );
    assert( self.var_3439d17c39f493c9, "<dev string:xc9>" + var_7e7d0317c62f22e2 + "<dev string:x94>" );
}

// Namespace common_kiosk_data
// Params 1
// Checksum 0x9f0d7e6d, Offset: 0x38e
// Size: 0x4b
function function_70af9883d65d43fb( buystationref )
{
    assert( isdefined( buystationref ) && buystationref != "<dev string:xf7>" );
    buystationref = tolower( buystationref );
    
    if ( !function_7b35de08edb8257e( buystationref ) )
    {
        function_7b41071a148cdb79( buystationref );
    }
    
    self.currentbuystation = buystationref;
}

// Namespace common_kiosk_data
// Params 1
// Checksum 0x18d2784c, Offset: 0x3e1
// Size: 0x55
function function_7b41071a148cdb79( buystationref )
{
    buystationref = tolower( buystationref );
    
    if ( !isdefined( self.buystationsinuse[ buystationref ] ) && !isdefined( self.additionalbuystations[ buystationref ] ) )
    {
        self.buystationsinuse[ buystationref ] = function_9da9718af8a09bb5( buystationref );
        function_79103bed8c26a944( buystationref );
    }
}

// Namespace common_kiosk_data
// Params 0
// Checksum 0x971597c9, Offset: 0x43e
// Size: 0xb
function function_c3950de54d46edf()
{
    return self.buystationsinuse;
}

// Namespace common_kiosk_data
// Params 1
// Checksum 0xfee15b88, Offset: 0x452
// Size: 0x56
function function_bf67e32fb61fec07( buystationindex )
{
    buystationref = function_bc4c6e4a3e7d611a( buystationindex );
    
    if ( isdefined( buystationref ) && !isdefined( self.additionalbuystations[ buystationref ] ) )
    {
        self.additionalbuystations[ buystationref ] = function_9da9718af8a09bb5( buystationref );
        function_79103bed8c26a944( buystationref );
    }
}

// Namespace common_kiosk_data
// Params 0
// Checksum 0x49eff311, Offset: 0x4b0
// Size: 0x118
function function_f848553e07fc98a7()
{
    mincost = undefined;
    
    foreach ( buystationinuse in self.buystationsinuse )
    {
        foreach ( item in buystationinuse[ "items" ] )
        {
            if ( item[ "cost" ] <= 0 )
            {
                continue;
            }
            
            if ( !isdefined( mincost ) || item[ "cost" ] < mincost )
            {
                mincost = item[ "cost" ];
            }
        }
    }
    
    return mincost;
}

// Namespace common_kiosk_data
// Params 1
// Checksum 0x6542d929, Offset: 0x5d1
// Size: 0x9a, Type: bool
function function_c6883cb97d900a3b( var_317f3ab12fa62d40 )
{
    foreach ( buystation in self.buystationsinuse )
    {
        var_a5c448d707ffda75 = buystation[ "items" ][ var_317f3ab12fa62d40 ];
        
        if ( isdefined( var_a5c448d707ffda75 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace common_kiosk_data
// Params 1
// Checksum 0x345417ce, Offset: 0x674
// Size: 0x1f
function function_a1c1cc5cf66f2de9( itemref )
{
    if ( isdefined( itemref ) )
    {
        return self.buystationitems[ itemref ];
    }
}

// Namespace common_kiosk_data
// Params 2
// Checksum 0x622ed1f4, Offset: 0x69c
// Size: 0x79
function function_a841bf1534cb9fa2( currentbuystation, itemref )
{
    assert( isdefined( currentbuystation ) );
    buystationdata = function_d6dc1c4751a512a3( self.buystationsinuse, currentbuystation );
    
    if ( !isdefined( buystationdata ) )
    {
        buystationdata = function_d6dc1c4751a512a3( self.additionalbuystations, currentbuystation );
    }
    
    itemdata = function_cd2fa022201b4702( itemref, buystationdata );
    return isdefined( itemdata ) ? itemdata[ "cost" ] : undefined;
}

// Namespace common_kiosk_data
// Params 0
// Checksum 0xdb7b34d2, Offset: 0x71e
// Size: 0x28
function function_148539293b639735()
{
    buystationdata = self.buystationsinuse[ self.currentbuystation ];
    return buystationdata[ "index" ];
}

// Namespace common_kiosk_data
// Params 1
// Checksum 0x839d2950, Offset: 0x74f
// Size: 0x59
function function_561b8e8b8ed4c18b( entryref )
{
    itemref = self.var_1214e3cb12e122a[ entryref ];
    itemdata = isdefined( itemref ) ? self.buystationitems[ itemref ] : undefined;
    return isdefined( itemdata ) ? itemdata.index : undefined;
}

// Namespace common_kiosk_data
// Params 1
// Checksum 0x47f1ad57, Offset: 0x7b1
// Size: 0xa2
function function_74433c19fcc10b90( itemindex )
{
    itemdata = undefined;
    
    foreach ( itemdata in self.buystationitems )
    {
        if ( itemdata.index == itemindex )
        {
            return function_a1c1cc5cf66f2de9( itemdata.ref );
        }
    }
}

// Namespace common_kiosk_data
// Params 0
// Checksum 0xfe574f88, Offset: 0x85c
// Size: 0xc
function function_51fc0412ca4334bf()
{
    return self.buystationsinuse.size;
}

// Namespace common_kiosk_data
// Params 1
// Checksum 0xfe2acf36, Offset: 0x871
// Size: 0x99
function function_5bc68da613540d2e( position )
{
    index = 0;
    
    foreach ( buystation in self.buystationsinuse )
    {
        if ( index == position )
        {
            return buystation[ "index" ];
        }
        
        index++;
    }
}

// Namespace common_kiosk_data
// Params 1
// Checksum 0xe3bca7ef, Offset: 0x912
// Size: 0x34, Type: bool
function function_6a04888539a8ebbd( buystationindex )
{
    return isdefined( function_d6dc1c4751a512a3( self.buystationsinuse, buystationindex ) ) || isdefined( function_d6dc1c4751a512a3( self.additionalbuystations, buystationindex ) );
}

// Namespace common_kiosk_data
// Params 1
// Checksum 0x8ef8b99e, Offset: 0x94f
// Size: 0x44
function function_e7774bf19f7a50f5( buystationindex )
{
    buystationdata = function_d6dc1c4751a512a3( self.buystationsinuse, buystationindex );
    
    if ( !buystationdata )
    {
        buystationdata = function_d6dc1c4751a512a3( self.additionalbuystations, buystationindex );
    }
    
    return buystationdata;
}

// Namespace common_kiosk_data
// Params 1
// Checksum 0xb6167c0d, Offset: 0x99c
// Size: 0x3a
function function_98010bc27337cc99( var_317f3ab12fa62d40 )
{
    itemref = self.var_1214e3cb12e122a[ var_317f3ab12fa62d40 ];
    return isdefined( itemref ) ? self.buystationitems[ itemref ] : undefined;
}

// Namespace common_kiosk_data
// Params 1, eflags: 0x4
// Checksum 0xc62696a, Offset: 0x9df
// Size: 0x53
function private function_9da9718af8a09bb5( buystationref )
{
    buystationdata = [];
    buystationindex = function_9d041619b6fccf18( buystationref );
    buystationdata[ "index" ] = buystationindex;
    buystationdata[ "ref" ] = buystationref;
    buystationdata[ "items" ] = [];
    buystationdata[ "itemFilter" ] = 0;
    return buystationdata;
}

// Namespace common_kiosk_data
// Params 1, eflags: 0x4
// Checksum 0x6db943fd, Offset: 0xa3b
// Size: 0x28a
function private function_79103bed8c26a944( buystationref )
{
    var_f45715438c3fbe15 = "buystationdef:" + buystationref;
    buystationbundle = getscriptbundle( var_f45715438c3fbe15 );
    assert( buystationbundle, "<dev string:xf8>" + buystationref + "<dev string:x3c>" );
    
    foreach ( itembundle in buystationbundle.buyStationItemList )
    {
        if ( itembundle.var_b3f5bfdadbffc88c )
        {
            randomizedselection = [];
            
            foreach ( randomitem in itembundle.var_e19aad06f80fb202 )
            {
                randomizedselection[ randomizedselection.size ] = randomitem.buystationitem;
            }
            
            randomizedselection = arrayrandomize( randomizedselection );
            randomizedselection = utility::array_slice( randomizedselection, 0, itembundle.var_40a6dacbbc77ffbe );
            
            foreach ( var_391f75ad82faa676 in itembundle.var_e19aad06f80fb202 )
            {
                isRandomlySelected = arraycontains( randomizedselection, var_391f75ad82faa676.buystationitem );
                var_dd493b1f79ddf4da = function_8a72efda25e65e76( var_391f75ad82faa676, 1, isRandomlySelected );
                var_c90de5b517c311f0 = parseitem( var_391f75ad82faa676.buystationitem );
                function_9f287f55fffbe06( buystationref, var_391f75ad82faa676.buystationitem, var_dd493b1f79ddf4da, var_c90de5b517c311f0 );
            }
            
            continue;
        }
        
        var_a5c448d707ffda75 = function_8a72efda25e65e76( itembundle );
        itemconfig = parseitem( itembundle.buystationitem );
        function_9f287f55fffbe06( buystationref, itembundle.buystationitem, var_a5c448d707ffda75, itemconfig );
    }
}

// Namespace common_kiosk_data
// Params 3, eflags: 0x4
// Checksum 0x4d43c971, Offset: 0xccd
// Size: 0x90
function private function_8a72efda25e65e76( var_512baf0a78538115, var_778df059d2202ee2, isRandomlySelected )
{
    var_a5c448d707ffda75 = [];
    var_a5c448d707ffda75[ "defaultStock" ] = var_512baf0a78538115.stock;
    var_a5c448d707ffda75[ "hidden" ] = var_512baf0a78538115.onlyfiresale;
    var_a5c448d707ffda75[ "cost" ] = currency::function_ec2513654311fb07( var_512baf0a78538115.buystationitem ) ?? var_512baf0a78538115.costoverride;
    
    if ( var_778df059d2202ee2 && isdefined( isRandomlySelected ) )
    {
        var_a5c448d707ffda75[ "isRandomlySelected" ] = isRandomlySelected;
    }
    
    return var_a5c448d707ffda75;
}

// Namespace common_kiosk_data
// Params 1, eflags: 0x4
// Checksum 0x55b166c9, Offset: 0xd66
// Size: 0x1d2
function private parseitem( var_2322a6ca41ecc92 )
{
    itemindex = undefined;
    
    foreach ( index, currentitem in self.var_3439d17c39f493c9.buyStationItemList )
    {
        if ( tolower( currentitem.buystationitem ) == var_2322a6ca41ecc92 )
        {
            itemindex = index;
            break;
        }
    }
    
    if ( !isdefined( itemindex ) )
    {
        println( "<dev string:x116>" + var_2322a6ca41ecc92 + "<dev string:x11d>" );
    }
    
    assert( isdefined( itemindex ), "<dev string:x116>" + var_2322a6ca41ecc92 + "<dev string:x11d>" );
    itembundlename = "buystationitem:" + var_2322a6ca41ecc92;
    itembundle = getscriptbundle( itembundlename );
    assert( itembundle, "<dev string:x147>" + itembundlename + "<dev string:x3c>" );
    var_f67d8aee161ecf = spawnstruct();
    var_f67d8aee161ecf.entryref = var_2322a6ca41ecc92;
    var_f67d8aee161ecf.type = itembundle.type;
    var_f67d8aee161ecf.ref = itembundle.itemref;
    var_f67d8aee161ecf.scalingcost = itembundle.scalingcost;
    var_f67d8aee161ecf.index = itemindex;
    var_f67d8aee161ecf.cost = currency::function_ec2513654311fb07( var_2322a6ca41ecc92 ) ?? itembundle.defaultcost;
    var_f67d8aee161ecf.firesalediscount = currency::function_fafed3d425170577( var_2322a6ca41ecc92 ) ?? itembundle.firesalediscount;
    return var_f67d8aee161ecf;
}

// Namespace common_kiosk_data
// Params 1, eflags: 0x4
// Checksum 0xba55b559, Offset: 0xf41
// Size: 0x19, Type: bool
function private function_7b35de08edb8257e( buystationref )
{
    return isdefined( self.buystationsinuse[ buystationref ] );
}

// Namespace common_kiosk_data
// Params 4, eflags: 0x4
// Checksum 0xe566070b, Offset: 0xf63
// Size: 0xb0
function private function_9f287f55fffbe06( buystationref, itemref, var_a5c448d707ffda75, itemconfig )
{
    if ( isdefined( self.buystationsinuse[ buystationref ] ) )
    {
        self.buystationsinuse[ buystationref ][ "items" ][ itemref ] = var_a5c448d707ffda75;
    }
    else if ( isdefined( self.additionalbuystations[ buystationref ] ) )
    {
        self.additionalbuystations[ buystationref ][ "items" ][ itemref ] = var_a5c448d707ffda75;
    }
    
    self.buystationitems[ itemconfig.ref ] = itemconfig;
    self.var_1214e3cb12e122a[ itemref ] = itemconfig.ref;
    function_f5adee05f7e58f75( itemref, itemconfig );
}

// Namespace common_kiosk_data
// Params 2, eflags: 0x4
// Checksum 0x6cf04cf8, Offset: 0x101b
// Size: 0x8d
function private function_cd2fa022201b4702( itemref, buystation )
{
    foreach ( var_764e2820648e2b5d, currentitem in buystation[ "items" ] )
    {
        if ( var_764e2820648e2b5d == itemref )
        {
            return currentitem;
        }
    }
}

// Namespace common_kiosk_data
// Params 1, eflags: 0x4
// Checksum 0xf9d00a5f, Offset: 0x10b1
// Size: 0x98
function private function_881a31e4367f49e5( entryref )
{
    foreach ( currentbuystation in self.buystationsinuse )
    {
        currentitem = currentbuystation[ "items" ][ entryref ];
        
        if ( currentitem )
        {
            return currentitem;
        }
    }
}

// Namespace common_kiosk_data
// Params 2, eflags: 0x4
// Checksum 0x1705ec2b, Offset: 0x1152
// Size: 0x8e
function private function_d6dc1c4751a512a3( buystations, buystationindex )
{
    foreach ( buystation in buystations )
    {
        if ( buystation[ "index" ] == buystationindex )
        {
            return buystation;
        }
    }
}

