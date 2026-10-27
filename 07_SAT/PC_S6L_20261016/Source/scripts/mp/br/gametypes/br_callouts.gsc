// scripts\mp\br\gametypes\br_callouts.gsc  (hash_03b2d2b13b94aad9.gscc) (size: 3433 Bytes / 0xd69 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7b15b4a3 (2065020067)
// size ...... 3433 (0xd69)
// includes .. 2   (offset: 0xd19)
// strings ... 3   (offset: 0xd29)
// dev strs .. 2   (offset: 0xd51)
// exports ... 6   (offset: 0x9c1)
// cseg ...... 0x6b + 0x956 (0x9c1)
// imports ... 20  (offset: 0xab1)
// animtree1 . 0   (offset: 0xd69)
// animtree2 . 0   (offset: 0xd69)
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace br_callouts;

// Namespace br_callouts
// Params 0
// Checksum 0xc5894f85, Offset: 0x89
// Size: 0x4f2
function init()
{
    level.calloutglobals.namelocations = [];
    
    if ( !level.calloutglobals.var_e3610645ced210b2 && !isdefined( level.calloutglobals.calloutlist ) && ( !isdefined( level.calloutglobals.callouttable ) || !tableexists( level.calloutglobals.callouttable ) ) )
    {
        return;
    }
    
    minx = level.mapcorners[ 0 ].origin[ 0 ];
    maxx = level.mapcorners[ 1 ].origin[ 0 ];
    sizex = maxx - minx;
    miny = level.mapcorners[ 0 ].origin[ 1 ];
    maxy = level.mapcorners[ 1 ].origin[ 1 ];
    sizey = maxy - miny;
    
    if ( level.calloutglobals.var_e3610645ced210b2 )
    {
        level.calloutglobals.var_6c351155c27cf4ac = [];
        sitecount = function_fd6ceee336caaf26( 1 );
        
        for ( siteidx = 0; siteidx < sitecount ; siteidx++ )
        {
            site = function_e1b7d58d23ea03ff( 1, siteidx );
            region = function_ba8494ae1c952908( 1, site.region );
            ref = region.name + " site_" + siteidx;
            assert( !isdefined( level.calloutglobals.namelocations[ ref ] ), "<dev string:x24>" + ref + "<dev string:x32>" + level.mapname );
            namedlocation = spawnstruct();
            namedlocation.origin = site.origin;
            level.calloutglobals.namelocations[ ref ] = namedlocation;
            level.calloutglobals.var_6c351155c27cf4ac[ siteidx ] = ref;
        }
    }
    else if ( isdefined( level.calloutglobals.calloutlist ) )
    {
        foreach ( callout in level.calloutglobals.calloutlist )
        {
            if ( !callout.ontacmap )
            {
                continue;
            }
            
            x = callout.xfrac;
            x = float( x );
            x = x * sizex + minx;
            y = callout.yfrac;
            y = float( y );
            y = y * sizey + miny;
            radius = callout.radius;
            radius = float( radius );
            ref = callout.calloutref;
            namedlocation = spawnstruct();
            namedlocation.origin = ( x, y, 0 );
            namedlocation.radius = radius;
            level.calloutglobals.namelocations[ ref ] = namedlocation;
        }
    }
    else
    {
        for ( row = 0; true ; row++ )
        {
            ontacmap = tablelookupbyrow( level.calloutglobals.callouttable, row, 5 );
            
            if ( !isdefined( ontacmap ) || ontacmap == "" )
            {
                break;
            }
            
            if ( ontacmap != "1" )
            {
                continue;
            }
            
            x = tablelookupbyrow( level.calloutglobals.callouttable, row, 6 );
            x = float( x );
            x = x * sizex + minx;
            y = tablelookupbyrow( level.calloutglobals.callouttable, row, 7 );
            y = float( y );
            y = y * sizey + miny;
            radius = tablelookupbyrow( level.calloutglobals.callouttable, row, 8 );
            radius = float( radius );
            ref = tablelookupbyrow( level.calloutglobals.callouttable, row, 1 );
            namedlocation = spawnstruct();
            namedlocation.origin = ( x, y, 0 );
            namedlocation.radius = radius;
            level.calloutglobals.namelocations[ ref ] = namedlocation;
        }
    }
    
    callback::callback( #"br_callouts_initialized" );
}

// Namespace br_callouts
// Params 1
// Checksum 0xbebcfbf, Offset: 0x583
// Size: 0x113
function getlocationnameforpoint( point )
{
    locname = "";
    
    if ( level.calloutglobals.var_e3610645ced210b2 )
    {
        siteidx = function_2d6761e072b4e500( 1, point );
        
        if ( isdefined( siteidx ) )
        {
            locname = level.calloutglobals.var_6c351155c27cf4ac[ siteidx ];
        }
    }
    else
    {
        foreach ( name, info in level.calloutglobals.namelocations )
        {
            if ( distance2dsquared( point, info.origin ) <= info.radius * info.radius )
            {
                locname = name;
                break;
            }
        }
    }
    
    return locname;
}

/#

    // Namespace br_callouts
    // Params 0, eflags: 0x4
    // Checksum 0xc980f88a, Offset: 0x69f
    // Size: 0xf8, Type: dev
    function private function_a7e49ff4f379c07c()
    {
        if ( level.calloutglobals.var_e3610645ced210b2 )
        {
            function_25f710938c304f4b( 0, 1 );
            return;
        }
        
        foreach ( ref, loc in level.calloutglobals.namelocations )
        {
            utility::draw_circle( loc.origin, loc.radius, ( 1, 1, 0 ), 1, 0, 1 );
            debugstar( loc.origin, ( 1, 1, 0 ), 1, ref, 1 );
        }
    }

    // Namespace br_callouts
    // Params 0, eflags: 0x4
    // Checksum 0x52199b7b, Offset: 0x79f
    // Size: 0x1c4, Type: dev
    function private function_b04b6df53b0ffc7()
    {
        showtablets = isdefined( level.questinfo ) && isdefined( level.questinfo.debuginfo ) && isdefined( level.questinfo.debuginfo.locationtablets );
        
        foreach ( ref, loc in level.calloutglobals.namelocations )
        {
            if ( showtablets && isdefined( level.questinfo.debuginfo.locationtablets[ ref ] ) )
            {
                foreach ( tablet in level.questinfo.debuginfo.locationtablets[ ref ] )
                {
                    sphere( tablet.origin, 30, ( 1, 0, 0 ) );
                    line( tablet.origin, loc.origin, ( 1, 0, 0 ) );
                }
            }
        }
    }

    // Namespace br_callouts
    // Params 0
    // Checksum 0x2ca2274c, Offset: 0x96b
    // Size: 0x56, Type: dev
    function function_ba35b32b217357da()
    {
        if ( level.var_975cf749ad8eb88c )
        {
            level.var_975cf749ad8eb88c = 0;
            level notify( #"hash_2885e1088e6de365" );
            return;
        }
        
        level endon( #"hash_2885e1088e6de365" );
        level.var_975cf749ad8eb88c = 1;
        
        while ( true )
        {
            function_a7e49ff4f379c07c();
            function_b04b6df53b0ffc7();
            waitframe();
        }
    }

#/
