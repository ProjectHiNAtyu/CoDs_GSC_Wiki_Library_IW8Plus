// scripts\mp\common\utility\pickups_utility.gsc  (hash_3c73e783818a9a01.gscc) (size: 7947 Bytes / 0x1f0b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4ff1ae85 (1341238917)
// size ...... 7947 (0x1f0b)
// includes .. 4   (offset: 0x1d2b)
// strings ... 7   (offset: 0x1d4b)
// dev strs .. 20  (offset: 0x1ddb)
// exports ... 16  (offset: 0x14e3)
// cseg ...... 0xdc + 0x1407 (0x14e3)
// imports ... 49  (offset: 0x1763)
// animtree1 . 0   (offset: 0x1f0b)
// animtree2 . 0   (offset: 0x1f0b)
#using scripts\common\trace;
#using scripts\common\vehicle;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon_utility;

#namespace pickups;

// Namespace pickups
// Params 1
// Checksum 0x58e2887b, Offset: 0xfa
// Size: 0x2c, Type: bool
function isweaponpickup( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"weapon";
}

// Namespace pickups
// Params 1
// Checksum 0xb2c146ec, Offset: 0x12f
// Size: 0x4c, Type: bool
function isweaponpickupitem( item )
{
    if ( !isdefined( item ) )
    {
        return false;
    }
    
    if ( isdefined( item.scriptablename ) )
    {
        return isweaponpickup( item.scriptablename );
    }
    else if ( isdefined( item.weapon ) )
    {
        return true;
    }
    
    return false;
}

// Namespace pickups
// Params 3
// Checksum 0x6c8c68bb, Offset: 0x184
// Size: 0x5b
function playerplaygestureweaponanim( weaponref, animtime, variantid )
{
    self endon( #"death_or_disconnect" );
    weapobj = weapon_utility::function_d2c8356dc369d9ce( weaponref );
    self giveandfireoffhand( weapobj );
    wait animtime;
    
    if ( self hasweapon( weapobj ) )
    {
        self takeweapon( weapobj );
    }
}

// Namespace pickups
// Params 0
// Checksum 0x51de7fd6, Offset: 0x1e7
// Size: 0x75, Type: bool
function canplaynotcriticalgesture()
{
    if ( self.insertingarmorplate )
    {
        return false;
    }
    
    if ( self isswitchingweapon() )
    {
        return false;
    }
    
    if ( self isreloading() )
    {
        return false;
    }
    
    if ( self ismantling() )
    {
        return false;
    }
    
    if ( self isthrowinggrenade() )
    {
        return false;
    }
    
    if ( self israisingweapon() )
    {
        return false;
    }
    
    if ( self ismeleeing() )
    {
        return false;
    }
    
    if ( player::isplayerads() )
    {
        return false;
    }
    
    curweap = self getcurrentweapon();
    
    if ( isnullweapon( curweap ) )
    {
        return false;
    }
    
    return true;
}

// Namespace pickups
// Params 0
// Checksum 0x83bca1a6, Offset: 0x265
// Size: 0x45
function function_13d44cc7f77cd45b()
{
    weapobj = makeweapon( "iw8_ges_plyr_loot_pickup" );
    
    if ( self hasweapon( weapobj ) )
    {
        if ( self isgestureplaying( "iw8_ges_pickup_br" ) )
        {
            self stopgestureviewmodel( "iw8_ges_pickup_br", 0, 1 );
        }
        
        self takeweapon( weapobj );
        waitframe();
    }
}

// Namespace pickups
// Params 1
// Checksum 0x73076dd0, Offset: 0x2b2
// Size: 0x6b
function playerplaypickupanim( pickupent )
{
    self notify( #"hash_cffd9fae9275cf5f" );
    self endon( #"hash_cffd9fae9275cf5f" );
    self endon( #"death" );
    self endon( #"disconnect" );
    
    if ( isweaponpickupitem( pickupent ) || !canplaynotcriticalgesture() )
    {
        return;
    }
    
    function_13d44cc7f77cd45b();
    playerplaygestureweaponanim( "iw8_ges_plyr_loot_pickup", 1.17 );
}

// Namespace pickups
// Params 3
// Checksum 0x94090874, Offset: 0x325
// Size: 0x74
function function_f71dd588dc4f6288( var_ebf3eef9acd53aef, var_6914d368b87df9ca, var_6937dd68b8a45780 )
{
    dropstruct = spawnstruct();
    dropstruct.dropcount = 0;
    dropstruct.dropidx = 0;
    dropstruct.var_ebf3eef9acd53aef = var_ebf3eef9acd53aef;
    dropstruct.var_6914d368b87df9ca = var_6914d368b87df9ca;
    dropstruct.var_6937dd68b8a45780 = var_6937dd68b8a45780;
    return dropstruct;
}

// Namespace pickups
// Params 11
// Checksum 0xfd00523f, Offset: 0x3a2
// Size: 0x585
function getitemdroporiginandangles( dropstruct, baseorigin, baseangles, ignoreent, var_8e48a889d5a11dee, optionaloverridedist, var_18608bd8660b3a19, var_11f401c17a8141c5, overrideorigin, var_6287e62c98e4976a, var_8b237685b50b68c )
{
    assert( !isdefined( ignoreent ) || isent( ignoreent ) );
    ring_item_count = 9;
    
    if ( dropstruct.var_ebf3eef9acd53aef > 0 )
    {
        ring_item_count = dropstruct.var_ebf3eef9acd53aef;
    }
    
    slot_yaw = 360 / ring_item_count;
    trace_draw_debug = getdvarint( @"hash_d7613094ea4ba91f", 0 );
    var_f1b093a413fc702f = dropstruct.var_6914d368b87df9ca ?? -5;
    var_f18d81a413d600e1 = dropstruct.var_6937dd68b8a45780 ?? 5;
    var_5ed1783f697f746b = 40;
    
    if ( isent( ignoreent ) && isplayer( ignoreent ) && player::isreallyalive( ignoreent ) )
    {
        currentstance = ignoreent getstance();
        
        if ( currentstance == "crouch" )
        {
            var_5ed1783f697f746b = 20;
        }
        else if ( currentstance == "prone" )
        {
            var_5ed1783f697f746b = 10;
        }
    }
    
    dropdata = spawnstruct();
    dropdata.noground = 0;
    dropdata.payload = 0;
    dropdata.groundentity = undefined;
    
    if ( !isdefined( baseangles ) )
    {
        baseangles = ( 0, 0, 0 );
    }
    
    groundfloat = 2;
    
    if ( isdefined( var_18608bd8660b3a19 ) )
    {
        groundfloat = var_18608bd8660b3a19;
    }
    
    dropdata.ring = int( dropstruct.dropidx / ring_item_count );
    dropdata.slot = dropstruct.dropidx - dropdata.ring * ring_item_count;
    randomyawrange = 0;
    
    if ( var_f1b093a413fc702f != var_f18d81a413d600e1 )
    {
        randomyawrange = randomfloatrange( var_f1b093a413fc702f, var_f18d81a413d600e1 );
    }
    
    dropdata.yaw = baseangles[ 1 ] + dropdata.slot * slot_yaw + dropdata.ring * 30 + randomyawrange;
    dropdata.dist = 52 + dropdata.ring * 35 + randomfloatrange( -10, 10 );
    
    if ( isdefined( var_8e48a889d5a11dee ) )
    {
        dropdata.yaw = baseangles[ 1 ] + var_8e48a889d5a11dee;
    }
    
    if ( isdefined( optionaloverridedist ) )
    {
        dropdata.dist = optionaloverridedist;
    }
    
    dropdata.outangles = ( 0, dropdata.yaw, 0 );
    dropdata.dir = anglestoforward( dropdata.outangles );
    dropdata.outorigin = baseorigin + dropdata.dir * dropdata.dist;
    
    if ( isdefined( overrideorigin ) )
    {
        dropdata.outorigin = overrideorigin;
    }
    
    if ( true )
    {
        /#
            if ( trace_draw_debug )
            {
                println( "<dev string:x24>" + dropstruct.dropidx + "<dev string:x33>" + baseorigin + "<dev string:x3b>" + dropdata.outorigin + "<dev string:x40>" + dropdata.dist );
            }
        #/
        
        tracecontents = trace::create_contents( 0, 1, 1, 1, 1, 1, level.var_cfaf0ab5adc4655c, 0, 1, 0, 1 );
        traceresults = function_1d32a00c1751ff96( dropstruct, dropdata, baseorigin, ignoreent, tracecontents, trace_draw_debug );
        var_bdf5d609e9953448 = traceresults[ "fraction" ] < level.var_75dd11a79fd1bcd;
        
        if ( isdefined( traceresults ) && level.var_f5a8200247e32df9 > 0 && !isdefined( var_8e48a889d5a11dee ) && !isdefined( optionaloverridedist ) && !isdefined( overrideorigin ) )
        {
            var_5a2c7a5eca227e39 = 0;
            
            if ( !isdefined( optionaloverridedist ) && !isdefined( overrideorigin ) && !var_8b237685b50b68c )
            {
                var_5a2c7a5eca227e39 = function_d966d651a5610377( baseorigin, dropdata, traceresults );
            }
            
            if ( var_5a2c7a5eca227e39 || var_bdf5d609e9953448 )
            {
                function_7960823709d95fd7( dropstruct, dropdata, baseorigin, baseangles, ignoreent, tracecontents, level.var_f5a8200247e32df9, level.var_75dd11a79fd1bcd, trace_draw_debug, var_bdf5d609e9953448, var_5a2c7a5eca227e39 );
            }
        }
        
        function_32f5d6fe1a27e125( dropstruct, dropdata, ignoreent, tracecontents, trace_draw_debug );
        function_d3c39851219934f2( dropstruct, dropdata, ignoreent, tracecontents, groundfloat, var_6287e62c98e4976a, trace_draw_debug );
    }
    else
    {
        dropdata.outorigin += ( 0, 0, groundfloat );
    }
    
    if ( 1 && !dropdata.noground )
    {
        startorigin = baseorigin;
        
        if ( !var_11f401c17a8141c5 )
        {
            startorigin += ( 0, 0, var_5ed1783f697f746b );
        }
        
        dropdata.payload = calcscriptablepayloadgravityarc( startorigin, dropdata.outorigin );
    }
    
    /#
        if ( trace_draw_debug )
        {
            println( "<dev string:x24>" + dropstruct.dropidx + "<dev string:x4a>" + dropdata.outorigin + "<dev string:x5a>" + dropdata.outangles );
        }
    #/
    
    dropstruct.dropcount++;
    dropstruct.dropidx++;
    return getitemdropinfo( dropdata.outorigin, dropdata.outangles, dropdata.payload, dropdata.groundentity );
}

// Namespace pickups
// Params 4
// Checksum 0xfe89a0c8, Offset: 0x930
// Size: 0xb4
function getitemdropinfo( origin, angles, payload, groundentity )
{
    assert( isdefined( origin ) );
    dropinfo = spawnstruct();
    dropinfo.origin = origin;
    
    if ( isdefined( angles ) )
    {
        dropinfo.angles = angles;
    }
    else
    {
        dropinfo.angles = ( 0, 0, 0 );
    }
    
    if ( isdefined( payload ) )
    {
        dropinfo.payload = payload;
    }
    else
    {
        dropinfo.payload = 0;
    }
    
    dropinfo.groundentity = groundentity;
    return dropinfo;
}

// Namespace pickups
// Params 6
// Checksum 0x4f0df387, Offset: 0x9ed
// Size: 0x19f
function function_1d32a00c1751ff96( dropstruct, dropdata, baseorigin, ignoreent, tracecontents, trace_draw_debug )
{
    tracestart = baseorigin + ( 0, 0, 21 );
    wallgrace = dropdata.dir * 18;
    traceend = dropdata.outorigin + wallgrace + ( 0, 0, 21 + level.var_2b3191b005b84c0d );
    traceresults = trace::ray_trace( tracestart, traceend, ignoreent, tracecontents );
    
    /#
        if ( trace_draw_debug )
        {
            function_6a8f88ee03bb2123( dropstruct.dropidx, "<dev string:x5c>", tracestart, traceend, traceresults );
        }
    #/
    
    if ( traceresults[ "fraction" ] < 1 )
    {
        dropdata.outorigin = traceresults[ "position" ];
    }
    else
    {
        dropdata.outorigin = traceend;
    }
    
    dropdata.outorigin -= wallgrace;
    heightchecks = getdvarint( @"hash_3ca29b429f678228", 1 );
    
    for ( check = 0; check < heightchecks ; check++ )
    {
        tracestart += ( 0, 0, 10 * check );
        hightraceresults = trace::ray_trace( tracestart, traceend, ignoreent, tracecontents );
        
        if ( hightraceresults[ "fraction" ] < traceresults[ "fraction" ] )
        {
            traceresults[ "fraction" ] = -1;
        }
    }
    
    return traceresults;
}

// Namespace pickups
// Params 11
// Checksum 0x25df2af2, Offset: 0xb95
// Size: 0x31d
function function_7960823709d95fd7( dropstruct, dropdata, baseorigin, baseangles, ignoreent, tracecontents, retries, var_62e67e2955fa3c80, trace_draw_debug, var_bdf5d609e9953448, var_5a2c7a5eca227e39 )
{
    ring_item_count = 9;
    slot_yaw = 360 / ring_item_count;
    
    if ( !var_bdf5d609e9953448 && var_5a2c7a5eca227e39 )
    {
        slot_yaw = level.var_c87a581cca19993b;
    }
    
    initialring = dropdata.ring;
    initialslot = dropdata.slot;
    initialyaw = dropdata.yaw;
    initialdist = dropdata.dist;
    initialdir = dropdata.dir;
    var_a37b444c9e9add9e = dropdata.outangles;
    var_35c3b7a4b73d245c = dropdata.outorigin;
    
    for ( attempts = 0; attempts < retries ; attempts++ )
    {
        dropstruct.dropidx++;
        dropdata.ring = int( dropstruct.dropidx / ring_item_count );
        dropdata.slot = dropstruct.dropidx - dropdata.ring * ring_item_count;
        dropdata.yaw = baseangles[ 1 ] + dropdata.slot * slot_yaw + dropdata.ring * 30 + randomfloatrange( -5, 5 );
        dropdata.dist = 52 + dropdata.ring * 35 + randomfloatrange( -10, 10 );
        dropdata.outangles = ( 0, dropdata.yaw, 0 );
        dropdata.dir = anglestoforward( dropdata.outangles );
        dropdata.outorigin = baseorigin + dropdata.dir * dropdata.dist;
        traceresults = function_1d32a00c1751ff96( dropstruct, dropdata, baseorigin, ignoreent, tracecontents, trace_draw_debug );
        var_5a2c7a5eca227e39 = function_d966d651a5610377( baseorigin, dropdata, traceresults );
        
        if ( traceresults[ "fraction" ] >= var_62e67e2955fa3c80 && !var_5a2c7a5eca227e39 )
        {
            return;
        }
    }
    
    dropdata.ring = initialring;
    dropdata.slot = initialslot;
    dropdata.yaw = initialyaw;
    distancescalar = var_5a2c7a5eca227e39 ? 3 : 1;
    dropdata.dist = initialdist / distancescalar;
    dropdata.dir = initialdir;
    dropdata.outangles = var_a37b444c9e9add9e;
    dropdata.outorigin = var_35c3b7a4b73d245c;
}

// Namespace pickups
// Params 5
// Checksum 0x2d9dc6d8, Offset: 0xeba
// Size: 0x104
function function_32f5d6fe1a27e125( dropstruct, dropdata, ignoreent, tracecontents, trace_draw_debug )
{
    tracestart = dropdata.outorigin;
    traceend = dropdata.outorigin + ( 0, 0, 60 );
    traceresults = trace::ray_trace( tracestart, traceend, ignoreent, tracecontents );
    
    /#
        if ( trace_draw_debug )
        {
            function_6a8f88ee03bb2123( dropstruct.dropidx, "<dev string:x5f>", tracestart + ( 0, 1, 0 ), traceend + ( 0, 1, 0 ), traceresults );
        }
    #/
    
    if ( traceresults[ "fraction" ] < 1 )
    {
        dropdata.outorigin = traceresults[ "position" ] + ( 0, 0, -6 );
    }
    else
    {
        dropdata.outorigin = traceend;
    }
    
    return traceresults;
}

// Namespace pickups
// Params 7
// Checksum 0x30c83da5, Offset: 0xfc7
// Size: 0x2cc
function function_d3c39851219934f2( dropstruct, dropdata, ignoreent, tracecontents, groundfloat, var_6287e62c98e4976a, trace_draw_debug )
{
    tracestart = dropdata.outorigin;
    traceheight = var_6287e62c98e4976a ?? getdvarfloat( @"hash_b91d6bc7e0694ac", 2000 );
    var_fbaf852c9cb6dff8 = -1 * traceheight;
    traceend = dropdata.outorigin + ( 0, 0, var_fbaf852c9cb6dff8 );
    traceresults = trace::ray_trace( tracestart, traceend, ignoreent, tracecontents );
    
    /#
        if ( trace_draw_debug )
        {
            function_6a8f88ee03bb2123( dropstruct.dropidx, "<dev string:x62>", tracestart, traceend, traceresults );
        }
    #/
    
    if ( traceresults[ "fraction" ] < 1 )
    {
        dropdata.outorigin = traceresults[ "position" ] + ( 0, 0, groundfloat );
        dropdata.groundentity = traceresults[ "entity" ];
        
        if ( isdefined( dropdata.groundentity ) && ( dropdata.groundentity.isdestroyed || dropdata.groundentity.burningdown || dropdata.groundentity vehicle::function_b4b334e3af2d4d0() ) )
        {
            ignorelist = [ dropdata.groundentity ];
            
            if ( isdefined( ignoreent ) )
            {
                ignorelist[ ignorelist.size ] = ignoreent;
            }
            
            traceresults = trace::ray_trace( dropdata.outorigin, traceend, ignorelist, tracecontents );
            
            /#
                if ( trace_draw_debug )
                {
                    function_6a8f88ee03bb2123( dropstruct.dropidx, "<dev string:x65>", dropdata.outorigin, traceend, traceresults );
                }
            #/
            
            if ( traceresults[ "fraction" ] < 1 )
            {
                dropdata.outorigin = traceresults[ "position" ] + ( 0, 0, groundfloat );
                dropdata.groundentity = traceresults[ "entity" ];
            }
            else
            {
                /#
                    if ( trace_draw_debug )
                    {
                        println( "<dev string:x24>" + dropstruct.dropidx + "<dev string:x69>" );
                    }
                #/
                
                dropdata.outorigin = ( 0, 0, 0 );
                dropdata.noground = 1;
            }
        }
    }
    else
    {
        /#
            if ( trace_draw_debug )
            {
                println( "<dev string:x24>" + dropstruct.dropidx + "<dev string:x69>" );
            }
        #/
        
        dropdata.outorigin = ( 0, 0, 0 );
        dropdata.noground = 1;
    }
    
    return traceresults;
}

// Namespace pickups
// Params 3
// Checksum 0x842a4a57, Offset: 0x129c
// Size: 0xf0, Type: bool
function function_d966d651a5610377( baseorigin, dropdata, traceresults )
{
    scriptablenearby = getlootscriptablearrayinradius( undefined, undefined, baseorigin, dropdata.dist + level.var_d764aadece5d06d5 );
    
    if ( scriptablenearby.size > 0 )
    {
        foreach ( scriptable in scriptablenearby )
        {
            if ( !isdefined( scriptable.origin ) )
            {
                continue;
            }
            
            if ( distance2d( traceresults[ "position" ], scriptable.origin ) < level.var_d764aadece5d06d5 )
            {
                return true;
            }
        }
    }
    
    return false;
}

/#

    // Namespace pickups
    // Params 5
    // Checksum 0x8e6b72eb, Offset: 0x1395
    // Size: 0x14e, Type: dev
    function function_6a8f88ee03bb2123( index, name, start, end, traceresults )
    {
        var_c5b7ca5f7b286ea0 = 2000;
        
        if ( traceresults[ "<dev string:x75>" ] < 1 )
        {
            line( start, traceresults[ "<dev string:x7e>" ], ( 1, 0, 0 ), 1, 0, var_c5b7ca5f7b286ea0 );
            
            if ( isdefined( traceresults[ "<dev string:x87>" ] ) )
            {
                selectedentity = traceresults[ "<dev string:x87>" ];
                println( "<dev string:x24>" + index + "<dev string:x8e>" + name + "<dev string:x91>" + traceresults[ "<dev string:x75>" ] + "<dev string:x97>" + traceresults[ "<dev string:x7e>" ] + "<dev string:x9c>" + ( selectedentity.name ?? "<dev string:xa2>" ) );
            }
            else
            {
                println( "<dev string:x24>" + index + "<dev string:x8e>" + name + "<dev string:x91>" + traceresults[ "<dev string:x75>" ] + "<dev string:x97>" + traceresults[ "<dev string:x7e>" ] );
            }
            
            return;
        }
        
        println( "<dev string:x24>" + index + "<dev string:x8e>" + name + "<dev string:xac>" );
        line( start, end, ( 1, 1, 1 ), 1, 0, var_c5b7ca5f7b286ea0 );
    }

#/
