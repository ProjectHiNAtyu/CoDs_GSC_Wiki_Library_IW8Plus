// scripts\common\snd\snd_utility.gsc  (hash_1b56c93663a131b8.gscc) (size: 27932 Bytes / 0x6d1c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x97e7f3e (159285054)
// size ...... 27932 (0x6d1c)
// includes .. 2   (offset: 0x6970)
// strings ... 44  (offset: 0x6980)
// dev strs .. 25  (offset: 0x6be0)
// exports ... 118 (offset: 0x4408)
// cseg ...... 0x37e + 0x408a (0x4408)
// imports ... 133 (offset: 0x5678)
// animtree1 . 0   (offset: 0x6d1c)
// animtree2 . 0   (offset: 0x6d1c)
#using scripts\common\snd\snd_draw;
#using scripts\common\utility;

#namespace snd;

// Namespace snd
// Params 2
// Checksum 0xb99a33b3, Offset: 0x39c
// Size: 0x19
function temp_fmod( x, y )
{
    return x % y;
}

// Namespace snd
// Params 0
// Checksum 0x43b3f789, Offset: 0x3be
// Size: 0x83
function getplayervieworigin()
{
    player = self;
    assert( isplayersafe( self ) );
    vieworigin = undefined;
    
    if ( isfunction( level.snd.callbacks[ "player_view" ] ) )
    {
        vieworigin = player [[ level.snd.callbacks[ "player_view" ] ]]();
    }
    else
    {
        vieworigin = player geteye();
    }
    
    assert( isvector( vieworigin ) );
    return vieworigin;
}

// Namespace snd
// Params 0
// Checksum 0x8fa4e18a, Offset: 0x44a
// Size: 0x83
function getplayerviewangles()
{
    player = self;
    assert( isplayersafe( self ) );
    viewangles = undefined;
    
    if ( isfunction( level.snd.callbacks[ "player_angles" ] ) )
    {
        viewangles = player [[ level.snd.callbacks[ "player_angles" ] ]]();
    }
    else
    {
        viewangles = player getplayerangles();
    }
    
    assert( isvector( viewangles ) );
    return viewangles;
}

// Namespace snd
// Params 0
// Checksum 0x9566c275, Offset: 0x4d6
// Size: 0x9f
function getplayerfov()
{
    player = self;
    assert( isplayersafe( self ) );
    fov = undefined;
    
    if ( isfunction( level.snd.callbacks[ "player_fov" ] ) )
    {
        fov = player [[ level.snd.callbacks[ "player_fov" ] ]]();
    }
    else
    {
        fov = getdvarfloat( @"cg_fov", 65 );
    }
    
    assert( isfloat( fov ) );
    assert( fov <= 180 );
    return fov;
}

// Namespace snd
// Params 1
// Checksum 0x63516feb, Offset: 0x57e
// Size: 0xfc
function vectoraverage( v )
{
    if ( isvector( v ) )
    {
        avg = 0;
        avg += v[ 0 ];
        avg += v[ 1 ];
        avg += v[ 2 ];
        avg /= 3;
        return avg;
    }
    
    assert( isarray( v ), "<dev string:x24>" );
    avg = ( 0, 0, 0 );
    
    if ( v.size == 0 )
    {
        return avg;
    }
    else if ( v.size == 1 )
    {
        return v[ 0 ];
    }
    
    foreach ( vec in v )
    {
        avg += vec;
    }
    
    avg /= v.size;
    return avg;
}

/#

    // Namespace snd
    // Params 2, eflags: 0x4
    // Checksum 0xae4a0ed5, Offset: 0x683
    // Size: 0x20, Type: dev
    function private function_d5bffa458d645c71( hud, duration )
    {
        waitframe();
        hud destroy();
    }

    // Namespace snd
    // Params 7
    // Checksum 0xa95a8249, Offset: 0x6ab
    // Size: 0x62, Type: dev
    function function_5a2bde9239ec6207( posx, posy, text, color, alpha, scale, duration )
    {
        origin = ( posx, posy, 0 );
        printtoscreen2d( posx, posy, text, color, scale );
    }

#/

// Namespace snd
// Params 1
// Checksum 0xe470b0b6, Offset: 0x715
// Size: 0x1c, Type: bool
function function_28e502d3c60c20e3( func )
{
    return isbuiltinfunction( func ) || isbuiltinmethod( func );
}

// Namespace snd
// Params 1
// Checksum 0x797a8c4f, Offset: 0x73a
// Size: 0x12
function isscriptfunction( func )
{
    return isfunction( func );
}

// Namespace snd
// Params 1
// Checksum 0x4ea6f377, Offset: 0x755
// Size: 0x1c, Type: bool
function function_91beeef81da2dd73( func )
{
    return isbuiltinfunction( func ) || isfunction( func );
}

// Namespace snd
// Params 2
// Checksum 0xda40392d, Offset: 0x77a
// Size: 0x15
function function_675f36fbb6a0a5d0( soundalias, column )
{
    
}

// Namespace snd
// Params 2
// Checksum 0xd0eef663, Offset: 0x798
// Size: 0x1e
function function_446279deaf2f09f6( soundalias, column )
{
    return function_675f36fbb6a0a5d0( soundalias, column );
}

// Namespace snd
// Params 1
// Checksum 0x42d9ba65, Offset: 0x7bf
// Size: 0x45
function function_bfe0872937d87e72( angles )
{
    assert( isvector( angles ), "<dev string:x5b>" );
    wrapped = ( angleclamp180( angles[ 0 ] ), angleclamp180( angles[ 1 ] ), angleclamp180( angles[ 2 ] ) );
    return wrapped;
}

// Namespace snd
// Params 1
// Checksum 0x6dd547b6, Offset: 0x80d
// Size: 0x8d
function randomhelper( value )
{
    if ( isarray( value ) )
    {
        if ( value.size >= 2 )
        {
            min = value[ 0 ];
            max = value[ 1 ];
            
            if ( min > max )
            {
                temp = max;
                max = min;
                min = temp;
            }
            
            assert( max >= min );
            randomrange = randomfloatrange( min, max );
            return randomrange;
        }
        else if ( value.size == 1 )
        {
            value = value[ 0 ];
        }
    }
    
    return float( value );
}

// Namespace snd
// Params 3
// Checksum 0xb6090d79, Offset: 0x8a3
// Size: 0x6d
function randomrangehelper( value_min, value_max, value_default )
{
    if ( isdefined( value_min ) && isdefined( value_max ) )
    {
        if ( value_min == value_max )
        {
            return value_min;
        }
        else
        {
            value = randomfloatrange( value_min, value_max );
            return value;
        }
        
        return;
    }
    
    if ( ( isdefined( value_min ) && isdefined( value_max ) ) == 0 )
    {
        return value_min;
    }
    
    if ( isdefined( value_default ) )
    {
        return value_default;
    }
}

// Namespace snd
// Params 2
// Checksum 0x656299a3, Offset: 0x919
// Size: 0xb5
function rangehelper( range, defaultminvalue )
{
    randomrange = undefined;
    
    if ( isarray( range ) )
    {
        if ( range.size == 0 )
        {
            return;
        }
        else if ( range.size == 1 )
        {
            return float( range[ 0 ] );
        }
        else
        {
            rangemin = range[ 0 ];
            rangemax = range[ 1 ];
            randomrange = randomrangehelper( rangemin, rangemax );
            return float( randomrange );
        }
    }
    else if ( isarray( range ) == 0 && isdefined( defaultminvalue ) )
    {
        randomrange = randomrangehelper( defaultminvalue, range );
    }
    else
    {
        randomrange = range;
    }
    
    assert( isdefined( randomrange ), "<dev string:x82>" );
    return float( randomrange );
}

// Namespace snd
// Params 1
// Checksum 0xaa10495f, Offset: 0x9d7
// Size: 0x27
function function_96110023c8018546( arr )
{
    if ( arr.size == 0 )
    {
        return;
    }
    else if ( arr.size == 1 )
    {
        return arr[ 0 ];
    }
    
    return arr;
}

// Namespace snd
// Params 1
// Checksum 0xe0c8d6ce, Offset: 0xa07
// Size: 0x4d
function makearray( v )
{
    if ( !isdefined( v ) )
    {
        return [];
    }
    else if ( is_object_invalid( v ) == 0 && isarray( v ) )
    {
    }
    else
    {
        return [ v ];
    }
    
    assert( isarray( v ) );
    return v;
}

// Namespace snd
// Params 2
// Checksum 0x124f9e5b, Offset: 0xa5d
// Size: 0x97
function function_2cd84c46a7fc2468( var_ba8727372b299018, v )
{
    isarr = isarray( var_ba8727372b299018 );
    isdef = isdefined( v );
    
    if ( condition_alert( !isdef, "snd VarrayAdd undefined entity" ) )
    {
        return var_ba8727372b299018;
    }
    
    if ( !isarr )
    {
        if ( isdefined( var_ba8727372b299018 ) )
        {
            var_ba8727372b299018 = [ var_ba8727372b299018, v ];
        }
        else
        {
            var_ba8727372b299018 = [ v ];
        }
    }
    else if ( isarr )
    {
        isinarr = arraycontains( var_ba8727372b299018, v );
        
        if ( !isinarr )
        {
            var_ba8727372b299018[ var_ba8727372b299018.size ] = v;
        }
    }
    
    return var_ba8727372b299018;
}

// Namespace snd
// Params 2
// Checksum 0xa0b3ae0c, Offset: 0xafd
// Size: 0x6e
function varrayremove( var_ba8727372b299018, v )
{
    isarr = isarray( var_ba8727372b299018 );
    
    if ( condition_alert( !isdefined( v ), "snd VarrayRemove undefined entity" ) )
    {
        return var_ba8727372b299018;
    }
    
    if ( !isarr )
    {
        var_ba8727372b299018 = undefined;
    }
    else if ( isarr )
    {
        isinarr = arraycontains( var_ba8727372b299018, v );
        
        if ( isinarr )
        {
            var_ba8727372b299018 = arrayremove( var_ba8727372b299018, v );
        }
    }
    
    return var_ba8727372b299018;
}

/#

    // Namespace snd
    // Params 2
    // Checksum 0x47b0f1a6, Offset: 0xb74
    // Size: 0x7b, Type: dev
    function function_bb82f32186a9b8a( inputstring, var_88c3ae1a48b01083 )
    {
        prefix = "<dev string:xa2>";
        outputstring = "<dev string:xa2>";
        
        if ( isstring( inputstring ) && inputstring.size > 0 && inputstring.size < var_88c3ae1a48b01083 )
        {
            var_88c3ae1a48b01083 -= inputstring.size;
            
            while ( var_88c3ae1a48b01083 >= 0 )
            {
                prefix += "<dev string:xa3>";
                var_88c3ae1a48b01083--;
            }
        }
        
        outputstring = prefix + inputstring;
        return outputstring;
    }

#/

// Namespace snd
// Params 1
// Checksum 0xd4ae5a97, Offset: 0xbf7
// Size: 0xb7, Type: bool
function hasnumber( s )
{
    if ( isnumber( s ) )
    {
        return true;
    }
    else if ( isstring( s ) && s[ 0 ] == "0" || s[ 0 ] == "1" || s[ 0 ] == "2" || s[ 0 ] == "3" || s[ 0 ] == "4" || s[ 0 ] == "5" || s[ 0 ] == "6" || s[ 0 ] == "7" || s[ 0 ] == "8" || s[ 0 ] == "9" || s[ 0 ] == "." )
    {
        return true;
    }
    
    return false;
}

// Namespace snd
// Params 2
// Checksum 0xf4790afd, Offset: 0xcb7
// Size: 0x1ac
function printdecimalcount( inputvalue, decimalcount )
{
    if ( isstring( inputvalue ) )
    {
        return inputvalue;
    }
    
    if ( !isnumber( inputvalue ) )
    {
        assertmsg( "<dev string:xa5>" );
        return;
    }
    
    if ( !isdefined( decimalcount ) )
    {
        decimalcount = 0;
    }
    
    decimalcount = int( min( decimalcount, 6 ) );
    intvalue = int( inputvalue + 0.0001 );
    fractional = round( inputvalue - intvalue, 0.0001 );
    
    switch ( decimalcount )
    {
        case 0:
            return string( intvalue );
        case 1:
            fractional = int( fractional * 10 );
            break;
        case 2:
            fractional = int( fractional * 100 );
            break;
        case 3:
            fractional = int( fractional * 1000 );
            break;
        case 4:
            fractional = int( fractional * 10000 );
            break;
        case 5:
            fractional = int( fractional * 10000 );
            break;
        case 6:
        default:
            fractional = int( fractional * 100000 );
            break;
    }
    
    fractional_text = fractional + "";
    var_ea49d7a5478e8e5b = decimalcount - fractional_text.size;
    
    if ( var_ea49d7a5478e8e5b >= 1 )
    {
        for ( i = var_ea49d7a5478e8e5b; i > 0 ; i-- )
        {
            fractional_text += "0";
        }
    }
    
    outputvalue = intvalue + "." + fractional_text;
    return outputvalue;
}

// Namespace snd
// Params 1
// Checksum 0x557b890e, Offset: 0xe6c
// Size: 0x95
function function_f9bad4d38a7b5d86( arr )
{
    foreach ( i, item in arr )
    {
        if ( isstring( item ) && isnumber( item ) )
        {
            arr[ i ] = int( item );
        }
    }
    
    return arr;
}

// Namespace snd
// Params 1
// Checksum 0x6389bc41, Offset: 0xf0a
// Size: 0x95
function function_b74aafb27c48050d( arr )
{
    foreach ( i, item in arr )
    {
        if ( isstring( item ) && isnumber( item ) )
        {
            arr[ i ] = float( item );
        }
    }
    
    return arr;
}

// Namespace snd
// Params 1
// Checksum 0x62b2ac8b, Offset: 0xfa8
// Size: 0x79
function positionhelper( thing )
{
    position = undefined;
    
    if ( isent( thing ) )
    {
        position = thing.origin;
    }
    else if ( isstruct( thing ) )
    {
        position = thing.origin;
    }
    else if ( isvector( thing ) )
    {
        position = thing;
    }
    else
    {
        assert( 0 );
    }
    
    assert( isvector( position ), "<dev string:xd0>" );
    return position;
}

// Namespace snd
// Params 1
// Checksum 0x6c1cf3d2, Offset: 0x102a
// Size: 0xe8
function function_7343e2107064fa8( thing )
{
    origins = [];
    
    if ( isvector( thing ) )
    {
        origins[ origins.size ] = thing;
    }
    else if ( isarray( thing ) )
    {
        foreach ( obj in thing )
        {
            if ( isvector( obj ) )
            {
                origins[ origins.size ] = obj;
                continue;
            }
            
            if ( ( isent( obj ) || isstruct( obj ) ) && isvector( obj.origin ) )
            {
                origins[ origins.size ] = obj.origin;
            }
        }
    }
    
    return origins;
}

// Namespace snd
// Params 1
// Checksum 0x3bc1f511, Offset: 0x111b
// Size: 0x40, Type: bool
function isstringinteger( str )
{
    intvalue = int( str );
    
    if ( intvalue )
    {
        return true;
    }
    else if ( intvalue == 0 && str == "0" )
    {
        return true;
    }
    
    return false;
}

// Namespace snd
// Params 1
// Checksum 0x987d875f, Offset: 0x1164
// Size: 0x6e, Type: bool
function is_object_invalid( obj )
{
    isa = isarray( obj );
    isd = isdefined( obj );
    ise = isent( obj );
    iss = isstruct( obj );
    
    if ( isa == 0 && iss == 0 && ise == 0 && isd == 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace snd
// Params 1
// Checksum 0x79d6350, Offset: 0x11db
// Size: 0x99
function gettargetnames( target )
{
    ents = getentarray( target, #targetname );
    structs = utility::getstructarray( target, "targetname" );
    nodes = [];
    vehiclenodes = getvehiclenodearray( target, #targetname );
    
    if ( utility::issp() )
    {
        nodes = builtin [[ level.getnodearrayfunction ]]( target, #targetname );
    }
    
    targets = arraycombine( ents, structs, nodes, vehiclenodes );
    return targets;
}

// Namespace snd
// Params 3
// Checksum 0x72ac3011, Offset: 0x127d
// Size: 0x90
function smoothvalue( currentvalue, var_1a62ba5ce44095b6, smoothalpha )
{
    if ( smoothalpha == 0 )
    {
        return currentvalue;
    }
    else if ( smoothalpha == 1 )
    {
        /#
            text = "<dev string:xf2>";
            println( text );
            iprintlnbold( text );
        #/
        
        return var_1a62ba5ce44095b6;
    }
    
    smoothalpha = clamp( smoothalpha, 0, 1 );
    inversealpha = 1 - smoothalpha;
    var_1a62ba5ce44095b6 = currentvalue * inversealpha + var_1a62ba5ce44095b6 * smoothalpha;
    return var_1a62ba5ce44095b6;
}

// Namespace snd
// Params 3
// Checksum 0x3fc3de24, Offset: 0x1316
// Size: 0x31, Type: bool
function function_226e5a7f7170c409( value, minvalue, maxvalue )
{
    if ( value >= minvalue && value <= maxvalue )
    {
        return true;
    }
    
    return false;
}

// Namespace snd
// Params 3
// Checksum 0xfc934c40, Offset: 0x1350
// Size: 0x3c
function function_ee983dd7f1138431( value, midvalue, var_bdf6d25234fb8465 )
{
    isinrange = function_226e5a7f7170c409( value, midvalue - var_bdf6d25234fb8465, midvalue + var_bdf6d25234fb8465 );
    return isinrange;
}

// Namespace snd
// Params 0
// Checksum 0x8d0ddde5, Offset: 0x1395
// Size: 0x28
function waittilldeleted()
{
    assert( isdefined( self ) );
    
    while ( is_object_invalid( self ) == 0 )
    {
        self waittill( #"death_or_disconnect" );
    }
}

// Namespace snd
// Params 2
// Checksum 0x4b3a02fc, Offset: 0x13c5
// Size: 0x2c5
function waittilldistance( target, range )
{
    self endon( #"death" );
    src = self;
    rmin = undefined;
    rmax = undefined;
    
    if ( isarray( range ) )
    {
        assert( range.size == 2 );
        rmin = float( range[ 0 ] );
        rmax = float( range[ 1 ] );
        assert( rmax >= rmin );
    }
    else if ( isnumber( range ) )
    {
        rmin = float( range );
    }
    
    assert( isfloat( rmin ) );
    armin = abs( rmin );
    armin_sq = squared( armin );
    rmin_sq = squared( rmin );
    rmax_sq = undefined;
    
    if ( isfloat( rmax ) )
    {
        rmax_sq = squared( rmax );
        
        if ( rmax < 0 )
        {
            rmax_sq *= -1;
        }
    }
    
    if ( rmin < 0 )
    {
        rmin_sq *= -1;
    }
    
    while ( isdefined( src ) && isdefined( target ) )
    {
        spt = positionhelper( src );
        tpt = positionhelper( target );
        current_distance_sq = distancesquared( spt, tpt );
        
        if ( isfloat( rmax_sq ) )
        {
            if ( current_distance_sq <= rmax_sq && current_distance_sq >= rmin_sq )
            {
                return;
            }
        }
        else
        {
            if ( rmin_sq > 0 && current_distance_sq >= rmin_sq )
            {
                return;
            }
            
            if ( rmin_sq <= 0 && current_distance_sq <= armin_sq )
            {
                return;
            }
        }
        
        /#
            if ( function_542b9fda0c23d8f4() > 0 )
            {
                randred = randomfloatrange( 0.72974, 1 );
                randgreen = randomfloatrange( 0.5, 1 );
                randblue = randomfloatrange( 0.5, 1 );
                randomcolor = ( randred, randgreen, randblue );
                randomcolor = vectornormalize( randomcolor );
                scale = -0.75;
                current_distance = sqrt( current_distance_sq );
                disttext = printdecimalcount( current_distance, 0 ) + "<dev string:x12c>" + armin;
                
                if ( isfloat( rmax ) )
                {
                    disttext += "<dev string:x12c>" + rmax;
                    
                    if ( rmax > 0 )
                    {
                        linesphere( tpt, rmax, randomcolor, 1, 1 );
                    }
                }
                
                if ( armin > 0 )
                {
                    linesphere( tpt, armin, randomcolor, 1, 1 );
                }
                
                print3dplus( disttext, tpt + ( 0, 0, 4 ), scale, "<dev string:x130>", randomcolor, 1, ( 0, 0, 0 ), 0.72974, ( 1, 1, 1 ), 0.72974 );
            }
        #/
        
        waitframe();
    }
}

/#

    // Namespace snd
    // Params 0
    // Checksum 0x919eb60, Offset: 0x1692
    // Size: 0x8f, Type: dev
    function _waittill_squad_trigger_debug_draw()
    {
        self endon( #"hash_67e6fc7b9e2a4533" );
        
        while ( true )
        {
            if ( function_542b9fda0c23d8f4() > 0 )
            {
                randred = randomfloatrange( 0.72974, 1 );
                randgreen = randomfloatrange( 0.5, 1 );
                randblue = randomfloatrange( 0.5, 1 );
                randomcolor = ( randred, randgreen, randblue );
                randomcolor = vectornormalize( randomcolor );
                drawtrigger( self, randomcolor, 0 );
            }
            
            waitframe();
        }
    }

#/

// Namespace snd
// Params 1
// Checksum 0x4c4eab98, Offset: 0x1729
// Size: 0x12a
function waittill_squad_trigger( squad )
{
    if ( condition_alert( !isent( self ), "snd::waittill_squad_trigger" + ": self is not an entity" ) )
    {
        return;
    }
    
    if ( condition_alert( !issquad( squad ), "snd::waittill_squad_trigger" + ": invalid squad argument" ) )
    {
        return;
    }
    
    /#
        thread _waittill_squad_trigger_debug_draw();
    #/
    
    while ( true )
    {
        self waittill( #"trigger", who );
        
        if ( isplayer( who ) && arraycontains( squad.players, who ) )
        {
            self notify( #"hash_67e6fc7b9e2a4533" );
            return who;
        }
        
        if ( who && who.classname == "script_vehicle" && isarray( who.occupants ) && who.occupants.size > 0 )
        {
            var_4c3fcfd5a35949f5 = arrayintersection( who.occupants, squad.players );
            
            if ( var_4c3fcfd5a35949f5.size > 0 )
            {
                self notify( #"hash_67e6fc7b9e2a4533" );
                
                if ( var_4c3fcfd5a35949f5.size == 1 )
                {
                    return var_4c3fcfd5a35949f5[ 0 ];
                }
                
                return var_4c3fcfd5a35949f5;
            }
        }
    }
}

// Namespace snd
// Params 1
// Checksum 0x1efdc5d, Offset: 0x185b
// Size: 0x6c
function function_2b5337e83120e1e9( holdduration )
{
    if ( isnumber( holdduration ) )
    {
        return holdduration;
    }
    
    switch ( holdduration )
    {
        case #"hash_d41336d028b3b99c":
            return 0;
        case #"hash_245ddd42796f500":
        default:
            return 250;
        case #"hash_f920647079c5619d":
            return 1000;
        case #"hash_d3eb18db47fa3d20":
            return 5000;
    }
    
    return 0;
}

// Namespace snd
// Params 2
// Checksum 0x9f47500c, Offset: 0x18d0
// Size: 0x73
function function_542d72477c81b195( player, holdduration )
{
    var_20f968af2671c2df = 250;
    
    if ( isstring( holdduration ) )
    {
        var_20f968af2671c2df = function_2b5337e83120e1e9( holdduration );
    }
    else if ( isnumber( holdduration ) )
    {
        var_20f968af2671c2df = holdduration;
    }
    
    button_time = 0;
    
    while ( button_time < var_20f968af2671c2df )
    {
        button_time += 50;
        waitframe();
        waittillframeend();
        
        if ( !player usebuttonpressed() )
        {
            break;
        }
    }
    
    return button_time;
}

// Namespace snd
// Params 3
// Checksum 0x3d897f06, Offset: 0x194c
// Size: 0x109
function function_e644f84c31f6f24a( trigger_progress, holdduration, usemilliseconds )
{
    if ( !isdefined( trigger_progress ) )
    {
        return;
    }
    
    if ( !isdefined( usemilliseconds ) )
    {
        usemilliseconds = 0;
    }
    
    if ( !trigger_progress.var_efb152093af3b346 )
    {
        trigger_progress waittill( #"trigger_progress", player );
        trigger_progress.var_efb152093af3b346 = 1;
        trigger_progress.var_62846ab81c68a440 = player;
        return [ player, 0 ];
    }
    
    player = trigger_progress.var_62846ab81c68a440;
    trigger_progress.var_efb152093af3b346 = undefined;
    trigger_progress.var_62846ab81c68a440 = undefined;
    total_time = function_2b5337e83120e1e9( holdduration );
    button_time = function_542d72477c81b195( player, holdduration );
    progress = undefined;
    
    if ( usemilliseconds )
    {
        progress = [ player, button_time ];
    }
    else
    {
        scale = button_time / total_time;
        progress = [ player, scale ];
    }
    
    return progress;
}

// Namespace snd
// Params 1
// Checksum 0x5abf921f, Offset: 0x1a5e
// Size: 0x23, Type: bool
function isplayersafe( player )
{
    if ( isent( player ) && isplayer( player ) )
    {
        return true;
    }
    
    return false;
}

// Namespace snd
// Params 1
// Checksum 0x9357dece, Offset: 0x1a8a
// Size: 0x15
function _getplayers( team )
{
    return level.players;
}

// Namespace snd
// Params 1
// Checksum 0xa872d7c5, Offset: 0x1aa8
// Size: 0xf5
function getplayerssafe( team )
{
    if ( isdefined( level.snd ) && level.snd.is_client_script )
    {
        players = _getplayers( team );
        
        foreach ( player in players )
        {
            if ( !isplayersafe( player ) )
            {
                players = arrayremove( players, player );
            }
        }
        
        return players;
    }
    
    if ( isdefined( level.snd ) && level.snd.is_server_script )
    {
        players = _getplayers( team );
        return players;
    }
    
    return [];
}

// Namespace snd
// Params 1
// Checksum 0x6ad77d2, Offset: 0x1ba6
// Size: 0x99
function function_83946fefe6b3475e( localclientnum )
{
    players = getplayerssafe();
    
    foreach ( player in players )
    {
        if ( player.localclientnum == localclientnum )
        {
            return player;
        }
    }
}

// Namespace snd
// Params 0
// Checksum 0xaa602877, Offset: 0x1c48
// Size: 0x32
function waitforplayers()
{
    while ( true )
    {
        players = getplayerssafe();
        
        if ( isarray( players ) && players.size > 0 )
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace snd
// Params 1
// Checksum 0xe1ba12b4, Offset: 0x1c82
// Size: 0x29
function function_8988c7b20cb7a452( team )
{
    waitforplayers();
    players = getplayerssafe( team );
    return players;
}

// Namespace snd
// Params 1
// Checksum 0x7fa79886, Offset: 0x1cb4
// Size: 0x35
function function_cdcb369d4e1d1e9f( activity )
{
    if ( isstruct( activity ) && isarray( activity.playerparticipants ) )
    {
        return activity.playerparticipants;
    }
    
    return [];
}

// Namespace snd
// Params 1
// Checksum 0xd76850d0, Offset: 0x1cf2
// Size: 0x56
function function_7a86238ee2359651( activity )
{
    while ( true )
    {
        players = function_cdcb369d4e1d1e9f( activity );
        
        if ( isarray( players ) && players.size > 0 )
        {
            return players;
        }
        
        activity waittill( #"player_joined", player );
    }
    
    return [];
}

// Namespace snd
// Params 1
// Checksum 0x32472237, Offset: 0x1d51
// Size: 0x2c, Type: bool
function issquad( squad )
{
    if ( isstruct( squad ) && isarray( squad.players ) )
    {
        return true;
    }
    
    return false;
}

// Namespace snd
// Params 1
// Checksum 0x62e36ddb, Offset: 0x1d86
// Size: 0x48
function function_c0c0d18177bbad02( player )
{
    if ( isarray( level.squaddata ) && isplayer( player ) )
    {
        return level.squaddata[ player.team ][ player.sessionsquadid ];
    }
}

// Namespace snd
// Params 0
// Checksum 0x5e36bc8b, Offset: 0x1dd7
// Size: 0x42
function function_5a6197a8525d2d60()
{
    if ( level.snd.is_client_script )
    {
        return int( 60 );
    }
    
    if ( level.snd.is_server_script )
    {
        return int( 20 );
    }
    
    return float( 20 );
}

// Namespace snd
// Params 0
// Checksum 0xd2c6934e, Offset: 0x1e22
// Size: 0x4b
function function_76f9a4325afecc73()
{
    if ( level.snd.is_client_script )
    {
        return float( 0.0166667 );
    }
    
    if ( level.snd.is_server_script )
    {
        return float( 0.05 );
    }
    
    return float( 0.05 );
}

// Namespace snd
// Params 0
// Checksum 0xce8f02ec, Offset: 0x1e76
// Size: 0x63
function function_7fde87582259c071()
{
    if ( isstruct( level.snd ) && isstring( level.snd.start_point ) )
    {
        return level.snd.start_point;
    }
    else if ( isstring( level.start_point ) )
    {
        return level.start_point;
    }
    
    return "";
}

// Namespace snd
// Params 2
// Checksum 0xf65cc826, Offset: 0x1ee2
// Size: 0x6b
function function_1dbeeb436fcf81c0( framecount, var_670e49543574803d )
{
    frametime = 0.0333333 * framecount;
    
    if ( isdefined( var_670e49543574803d ) == 0 )
    {
        var_670e49543574803d = 0;
    }
    
    waittime = frametime + var_670e49543574803d;
    
    if ( waittime <= 0 )
    {
        println( "<dev string:x132>" + waittime + "<dev string:x149>" );
        return;
    }
    
    wait waittime;
}

// Namespace snd
// Params 5
// Checksum 0xcffa36fc, Offset: 0x1f55
// Size: 0x6b
function scalerp( in_value, in_min, in_max, out_min, out_max )
{
    if ( in_min == in_max )
    {
        in_max += 0.001;
    }
    
    if ( out_min == out_max )
    {
        out_max += 0.001;
    }
    
    out_lerp = mapfloat( in_min, in_max, out_min, out_max, in_value );
    return out_lerp;
}

// Namespace snd
// Params 2
// Checksum 0xecfe5d24, Offset: 0x1fc9
// Size: 0x47
function vectorscale( vector, scale )
{
    assert( isvector( vector ) );
    assert( isnumber( scale ) );
    scaledvector = vector * ( scale, scale, scale );
    return scaledvector;
}

// Namespace snd
// Params 3
// Checksum 0x5e34912a, Offset: 0x2019
// Size: 0x7e
function vectorclamp( v, min, max )
{
    if ( isnumber( min ) )
    {
        min = ( min, min, min );
    }
    
    if ( isnumber( max ) )
    {
        max = ( max, max, max );
    }
    
    clampedvector = v;
    clampedvector = ( clamp( clampedvector[ 0 ], min[ 0 ], max[ 0 ] ), clamp( clampedvector[ 1 ], min[ 1 ], max[ 1 ] ), clamp( clampedvector[ 2 ], min[ 2 ], max[ 2 ] ) );
    return clampedvector;
}

// Namespace snd
// Params 2
// Checksum 0x33804682, Offset: 0x20a0
// Size: 0x3c
function vectorscalenormalize( vector, scale )
{
    scaledvector = vectorscale( vector, scale );
    normalizedvector = vectornormalize( scaledvector );
    return normalizedvector;
}

// Namespace snd
// Params 2
// Checksum 0xa9e252b2, Offset: 0x20e5
// Size: 0x58
function function_69dc1ffd54edd65c( vector, scale )
{
    scaledvector = vectorscale( vector, scale );
    saturatedvector = vectorclamp( scaledvector, ( 0, 0, 0 ), ( 1, 1, 1 ) );
    return saturatedvector;
}

// Namespace snd
// Params 1
// Checksum 0xdce6e31f, Offset: 0x2146
// Size: 0x2b
function utofeet( inches )
{
    assert( isnumber( inches ), "<dev string:x150>" );
    return float( inches ) * 0.0833333;
}

// Namespace snd
// Params 1
// Checksum 0xa1a34306, Offset: 0x217a
// Size: 0x2b
function utometers( inches )
{
    assert( isnumber( inches ), "<dev string:x16d>" );
    return float( inches ) * 0.0254;
}

// Namespace snd
// Params 1
// Checksum 0x8a2a0509, Offset: 0x21ae
// Size: 0x2b
function function_7d9695b207284985( meters )
{
    assert( isnumber( meters ), "<dev string:x18c>" );
    return float( meters ) * 39.3701;
}

// Namespace snd
// Params 1
// Checksum 0x80cc6cb3, Offset: 0x21e2
// Size: 0x2b
function function_90dc96a7a36f6a19( meters )
{
    assert( isnumber( meters ), "<dev string:x1b0>" );
    return float( meters ) * 3.28084;
}

// Namespace snd
// Params 1
// Checksum 0x7e95d1a2, Offset: 0x2216
// Size: 0x29
function function_d689fb81d42852b9( miles )
{
    assert( isnumber( miles ), "<dev string:x1d2>" );
    return float( miles ) * 63360;
}

// Namespace snd
// Params 3
// Checksum 0xd96169f, Offset: 0x2248
// Size: 0x4c, Type: bool
function function_ae9898408a0c789a( point, sphere_origin, radius )
{
    radius_sq = squared( radius );
    dist_sq = distancesquared( point, sphere_origin );
    
    if ( dist_sq <= radius_sq )
    {
        return true;
    }
    
    return false;
}

// Namespace snd
// Params 4
// Checksum 0xda68d4f4, Offset: 0x229d
// Size: 0xd2
function orbitalposition( centerorigin, dist, var_4d9b73147ea83832, elevation )
{
    if ( isdefined( dist ) == 0 || dist <= 0 )
    {
        return centerorigin;
    }
    
    if ( !isdefined( var_4d9b73147ea83832 ) )
    {
        var_4d9b73147ea83832 = 0;
    }
    
    if ( !isdefined( elevation ) )
    {
        elevation = 0;
    }
    
    var_4d9b73147ea83832 += 180;
    elevation += 270;
    posx = centerorigin[ 0 ];
    posy = centerorigin[ 1 ];
    posz = centerorigin[ 2 ];
    posx += dist * sin( elevation ) * cos( var_4d9b73147ea83832 );
    posy += dist * sin( elevation ) * sin( var_4d9b73147ea83832 );
    posz += dist * cos( elevation );
    position = ( posx, posy, posz );
    return position;
}

// Namespace snd
// Params 1
// Checksum 0xc8796980, Offset: 0x2378
// Size: 0x68
function gettagsafe( tagstr )
{
    ent = self;
    tagname = "";
    tagorigin = undefined;
    
    if ( isdefined( tagstr ) )
    {
        tagname = tagstr;
        tagorigin = ent gettagorigin( tagname, 1 );
    }
    
    if ( isdefined( tagorigin ) )
    {
        tagname = tolower( tagname );
    }
    
    assert( isdefined( tagname ), "<dev string:x1f5>" );
    return tagname;
}

// Namespace snd
// Params 3
// Checksum 0x6f17ecf, Offset: 0x23e9
// Size: 0xa6
function function_d4d71c181de2e0( origin, angles, extents )
{
    mins = origin - extents;
    maxs = origin + extents;
    delta = maxs - mins;
    randomdelta = ( randomfloat( delta[ 0 ] ), randomfloat( delta[ 1 ] ), randomfloat( delta[ 2 ] ) );
    
    if ( angles != ( 0, 0, 0 ) )
    {
        mins = origin - rotatevector( origin - mins, angles );
        randomdelta = rotatevector( randomdelta, angles );
    }
    
    randompoint = mins + randomdelta;
    return randompoint;
}

// Namespace snd
// Params 0
// Checksum 0xb3d8cce4, Offset: 0x2498
// Size: 0x45
function function_5e5cdedbd432d043()
{
    vidwidth = getdvarint( @"vid_width", 1920 );
    vidheight = getdvarint( @"vid_height", 1080 );
    return [ vidwidth, vidheight ];
}

// Namespace snd
// Params 0
// Checksum 0xbd3090bd, Offset: 0x24e6
// Size: 0x45
function function_542b9fda0c23d8f4()
{
    /#
        if ( isdefined( level.snd.debug.debuglevel ) )
        {
            return level.snd.debug.debuglevel;
        }
    #/
    
    return 0;
}

// Namespace snd
// Params 0
// Checksum 0xac20563a, Offset: 0x2534
// Size: 0x14, Type: bool
function function_5584988e43b61242()
{
    /#
        if ( function_542b9fda0c23d8f4() > 0 )
        {
            return true;
        }
    #/
    
    return false;
}

// Namespace snd
// Params 0
// Checksum 0x9ebf87b0, Offset: 0x2551
// Size: 0x15, Type: bool
function function_97c5f949bfb92869()
{
    /#
        if ( function_542b9fda0c23d8f4() > 2 )
        {
            return true;
        }
    #/
    
    return false;
}

// Namespace snd
// Params 2
// Checksum 0x898bbebe, Offset: 0x256f
// Size: 0x31
function condition_alert( condition, alerttext )
{
    /#
        if ( condition )
        {
            if ( function_5584988e43b61242() )
            {
                function_7a77574e2157fbce( alerttext );
            }
        }
    #/
    
    return condition;
}

// Namespace snd
// Params 1
// Checksum 0x1836497a, Offset: 0x25a9
// Size: 0x55
function function_195a8d89f5d5c362( volume )
{
    volume = float( volume );
    
    if ( volume <= 0 )
    {
        return -120;
    }
    
    var_769399a4b31695af = log( volume ) / log( 10 );
    var_e582090582357d3d = 20 * var_769399a4b31695af;
    return var_e582090582357d3d;
}

// Namespace snd
// Params 1
// Checksum 0xd3503620, Offset: 0x2607
// Size: 0x2f
function function_4aa8d29567677b4e( var_e582090582357d3d )
{
    volume = pow( 10, float( var_e582090582357d3d ) / 20 );
    return volume;
}

// Namespace snd
// Params 1
// Checksum 0x578d76f6, Offset: 0x263f
// Size: 0x2f
function function_89f0c5e1028788d6( semitone )
{
    pitchscale = pow( 2, float( semitone ) / 12 );
    return pitchscale;
}

// Namespace snd
// Params 1
// Checksum 0xba78a91a, Offset: 0x2677
// Size: 0x3c
function function_4c6e201b08bb9ae4( pitch )
{
    pitchlog2 = log( pitch ) / log( 2 );
    semitone = 12 * pitchlog2;
    return semitone;
}

// Namespace snd
// Params 4
// Checksum 0xd3c25800, Offset: 0x26bc
// Size: 0x82
function rvplayanimation( animname, animtree, notifyname, rate )
{
    if ( isdefined( level.var_da882a5fead94f84 ) == 0 )
    {
        condition_alert( isdefined( level.var_da882a5fead94f84 ) == 0, "rvPlayAnimation was not initialized!" );
        return;
    }
    
    if ( isdefined( notifyname ) == 0 )
    {
        notifyname = "animnotetrack";
    }
    
    if ( isdefined( rate ) == 0 )
    {
        rate = 1;
    }
    
    self thread [[ level.var_da882a5fead94f84 ]]( animname, animtree, notifyname, rate );
}

// Namespace snd
// Params 2
// Checksum 0x3b80ec7, Offset: 0x2746
// Size: 0xf6, Type: bool
function did_once( name, will_set )
{
    assert( isstruct( level.snd ), "<dev string:x211>" );
    assert( isstring( name ), "<dev string:x22a>" );
    
    if ( !isdefined( will_set ) )
    {
        will_set = 1;
    }
    
    if ( !isarray( level.snd.onesies ) )
    {
        assert( !isarray( level.snd.onesies ), "<dev string:x253>" );
        level.snd.onesies = [];
    }
    
    if ( isarray( level.snd.onesies ) && level.snd.onesies[ name ] )
    {
        return true;
    }
    
    if ( will_set )
    {
        level.snd.onesies[ name ] = 1;
    }
    
    return false;
}

// Namespace snd
// Params 0
// Checksum 0x89ebaa9d, Offset: 0x2845
// Size: 0xe
function dvar_shutdown()
{
    level notify( #"snd_dvar_stop" );
}

// Namespace snd
// Params 0, eflags: 0x4
// Checksum 0xee6b17bd, Offset: 0x285b
// Size: 0x234
function private _dvar_main()
{
    level notify( #"snd_dvar_stop" );
    level endon( #"snd_dvar_stop" );
    level endon( #"game_ended" );
    assert( isstruct( level.snd ), "<dev string:x211>" );
    assert( isdefined( level.snd.dvars ) );
    
    while ( true )
    {
        foreach ( dvar in level.snd.dvars )
        {
            callback = dvar.callback;
            key = dvar.key;
            value = string( dvar.value );
            curvalue = string( getdvar( key ) );
            
            if ( isdefined( callback ) && isdefined( key ) && isdefined( curvalue ) && value != curvalue )
            {
                returnvalue = [[ callback ]]( key, curvalue );
                
                if ( isdefined( returnvalue ) )
                {
                    setdvar( key, returnvalue );
                    dvar.value = returnvalue;
                    continue;
                }
                
                dvar.value = curvalue;
            }
        }
        
        waitframe();
        
        if ( isdefined( level.hostmigrationtimer ) )
        {
            level waittill( #"host_migration_end" );
            
            foreach ( dvar in level.snd.dvars )
            {
                function_200bc09dacdeca37( dvar.key, dvar.value );
            }
        }
    }
}

// Namespace snd
// Params 0, eflags: 0x4
// Checksum 0x247a3c1, Offset: 0x2a97
// Size: 0x55
function private _dvar_init()
{
    assert( isstruct( level.snd ), "<dev string:x211>" );
    
    if ( isarray( level.snd.dvars ) == 0 )
    {
        level.snd.dvars = [];
        level thread _dvar_main();
    }
}

// Namespace snd
// Params 3, eflags: 0x4
// Checksum 0xf0b3d7b5, Offset: 0x2af4
// Size: 0xb2
function private _dvar_alloc( dvar, value, callback_func )
{
    dvar_free( dvar );
    level.snd.dvars[ dvar ] = spawnstruct();
    level.snd.dvars[ dvar ].callback = callback_func;
    level.snd.dvars[ dvar ].key = dvar;
    level.snd.dvars[ dvar ].value = value;
    function_200bc09dacdeca37( dvar, value );
}

// Namespace snd
// Params 2, eflags: 0x4
// Checksum 0x2edfbf5b, Offset: 0x2bae
// Size: 0x27
function private function_200bc09dacdeca37( dvar, value )
{
    if ( !isdvardefined( dvar ) )
    {
        setdvarifuninitialized( dvar, value );
    }
}

// Namespace snd
// Params 1
// Checksum 0xf005512b, Offset: 0x2bdd
// Size: 0x3c
function dvar_free( dvar )
{
    if ( isdefined( level.snd.dvars[ dvar ] ) )
    {
        level.snd.dvars[ dvar ] = undefined;
    }
}

// Namespace snd
// Params 3
// Checksum 0x6356f68c, Offset: 0x2c21
// Size: 0x81
function dvar( dvar, value, callback_func )
{
    var_b3ced44a8c67e77f = isxhashdvar( dvar );
    var_a1a2d83b43cbb999 = "snd::dvar: dvar parameter must be XHashDvar (#d)";
    
    if ( condition_alert( !var_b3ced44a8c67e77f, var_a1a2d83b43cbb999 ) )
    {
        /#
            if ( function_97c5f949bfb92869() )
            {
                InvalidOpCode( 0x2 );
                // Unknown operator ( 0x2, t11, Black Ops 7 )
            }
        #/
        
        assert( var_b3ced44a8c67e77f, var_a1a2d83b43cbb999 + "<dev string:x299>" + dvar );
        return;
    }
    
    _dvar_init();
    _dvar_alloc( dvar, value, callback_func );
}

// Namespace snd
// Params 3, eflags: 0x44 variadic
// Checksum 0x41b94270, Offset: 0x2caa
// Size: 0x4b
function private function_31ed3f4800afd37b( callbackfunc, ... )
{
    assert( isdefined( self ) );
    assert( isdefined( callbackfunc ) );
    assert( isfunction( callbackfunc ) );
    self [[ callbackfunc ]]( flat_args( vararg, varargcount ) );
}

// Namespace snd
// Params 3, eflags: 0x44 variadic
// Checksum 0x33f9faae, Offset: 0x2cfd
// Size: 0x4b
function private function_b6c5f4a7d423892b( callbackfunc, ... )
{
    assert( isdefined( self ) );
    assert( isdefined( callbackfunc ) );
    assert( isbuiltinmethod( callbackfunc ) );
    self builtin [[ callbackfunc ]]( flat_args( vararg, varargcount ) );
}

// Namespace snd
// Params 3, eflags: 0x40 variadic
// Checksum 0x8c46a795, Offset: 0x2d50
// Size: 0x62
function callbackfunconentity( callbackfunc, ... )
{
    assert( isdefined( self ) );
    assert( isdefined( callbackfunc ) );
    
    if ( isfunction( callbackfunc ) )
    {
        function_31ed3f4800afd37b( callbackfunc, flat_args( vararg, varargcount ) );
        return;
    }
    
    if ( isbuiltinmethod( callbackfunc ) )
    {
        function_b6c5f4a7d423892b( callbackfunc, flat_args( vararg, varargcount ) );
    }
}

// Namespace snd
// Params 3, eflags: 0x40 variadic
// Checksum 0xba2fb5fe, Offset: 0x2dba
// Size: 0x2b
function function_88469cc1709ab6f1( callbackfunc, ... )
{
    thread callbackfunconentity( callbackfunc, flat_args( vararg, varargcount ) );
}

// Namespace snd
// Params 3, eflags: 0x4
// Checksum 0x44355f8f, Offset: 0x2ded
// Size: 0xd6
function private function_a141c12a252f1ceb( soundalias, column, var_4a93a7a98a371be9 )
{
    if ( soundexists( soundalias ) == 0 )
    {
        return;
    }
    
    aliasvalue = function_446279deaf2f09f6( soundalias, column );
    
    if ( isdefined( aliasvalue ) == 0 || string( aliasvalue ) == "" )
    {
        return;
    }
    
    minormaxvalue = float( aliasvalue );
    
    for ( secondaryalias = function_446279deaf2f09f6( soundalias, "secondaryaliasname" ); secondaryalias ; secondaryalias = function_446279deaf2f09f6( secondaryalias, "secondaryaliasname" ) )
    {
        aliasvalue = function_446279deaf2f09f6( soundalias, column );
        aliasvalue = float( aliasvalue );
        
        if ( var_4a93a7a98a371be9 == "min" )
        {
            minormaxvalue = min( minormaxvalue, aliasvalue );
            continue;
        }
        
        if ( var_4a93a7a98a371be9 == "max" )
        {
            minormaxvalue = max( minormaxvalue, aliasvalue );
        }
    }
    
    return minormaxvalue;
}

// Namespace snd
// Params 2
// Checksum 0x694685fb, Offset: 0x2ecc
// Size: 0x31
function function_4f80a4872306be7c( soundalias, column )
{
    minvalue = function_a141c12a252f1ceb( soundalias, column, "min" );
    return minvalue;
}

// Namespace snd
// Params 2
// Checksum 0x694685fb, Offset: 0x2f06
// Size: 0x31
function function_4f5d928722e04f2e( soundalias, column )
{
    maxvalue = function_a141c12a252f1ceb( soundalias, column, "max" );
    return maxvalue;
}

// Namespace snd
// Params 1
// Checksum 0x3e0122d0, Offset: 0x2f40
// Size: 0x147
function function_cdef4e5c55324316( name )
{
    assert( isstring( name ), "<dev string:x29c>" );
    var_93ef073c71897c2 = [ "intro", "loop", "main", "exit" ];
    musicsndaliases = [];
    
    foreach ( sndaliaspostfix in var_93ef073c71897c2 )
    {
        sndalias = "mus_" + name + "_" + sndaliaspostfix;
        didexist = soundexists( sndalias );
        
        if ( didexist )
        {
            musicsndaliases[ musicsndaliases.size ] = sndalias;
            continue;
        }
        
        statenum = 0;
        
        while ( true )
        {
            sndaliasnum = sndalias + "_" + statenum;
            didexist = soundexists( sndaliasnum );
            
            if ( didexist )
            {
                musicsndaliases[ musicsndaliases.size ] = sndaliasnum;
                statenum += 1;
                continue;
            }
            
            break;
        }
    }
    
    return musicsndaliases;
}

// Namespace snd
// Params 1
// Checksum 0xd97c66ed, Offset: 0x3090
// Size: 0x2c, Type: bool
function musicexists( name )
{
    musicsndaliases = function_cdef4e5c55324316( name );
    
    if ( musicsndaliases.size > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace snd
// Params 1
// Checksum 0x9b32e400, Offset: 0x30c5
// Size: 0xa4
function musicislooping( name )
{
    islooping = undefined;
    musicsndaliases = function_cdef4e5c55324316( name );
    
    foreach ( sndalias in musicsndaliases )
    {
        islooping = soundislooping( sndalias );
        
        if ( islooping )
        {
            return 1;
        }
    }
    
    return islooping;
}

// Namespace snd
// Params 1
// Checksum 0xefc0c48, Offset: 0x3172
// Size: 0x142
function musiclength( name )
{
    maxsndaliaslength = 0;
    musicnames = makearray( name );
    
    foreach ( musicname in musicnames )
    {
        musicsndaliases = function_cdef4e5c55324316( musicname );
        
        foreach ( sndalias in musicsndaliases )
        {
            islooping = soundislooping( sndalias );
            
            if ( islooping )
            {
                return -1;
            }
            
            sndaliaslength = lookupsoundlength( sndalias, 1 );
            
            if ( sndaliaslength > maxsndaliaslength )
            {
                maxsndaliaslength = sndaliaslength;
            }
        }
    }
    
    return maxsndaliaslength;
}

// Namespace snd
// Params 1
// Checksum 0x36c87d4f, Offset: 0x32bd
// Size: 0x67
function function_a39e88ad6fe60d5e( decimal )
{
    hexarray = "0123456789ABCDEF";
    quotient = int( decimal );
    hexadecimal = "";
    
    while ( quotient != 0 )
    {
        remainder = quotient % 16;
        hexadecimal = hexarray[ remainder ] + hexadecimal;
        quotient >>= 4;
    }
    
    return hexadecimal;
}

// Namespace snd
// Params 1
// Checksum 0x1082f62, Offset: 0x332d
// Size: 0x1b2
function function_d82f268d740c23cc( hex )
{
    hex = string( hex );
    intvalue = int( 0 );
    
    for ( i = 0; i < hex.size ; i++ )
    {
        nib = hex[ i ];
        nibvalue = 0;
        
        switch ( nib )
        {
            case #"hash_31100bbc01bd3230":
            case #"hash_31100cbc01bd33c3":
            case #"hash_31100dbc01bd3556":
            case #"hash_31100ebc01bd36e9":
            case #"hash_31100fbc01bd387c":
            case #"hash_311010bc01bd3a0f":
            case #"hash_311011bc01bd3ba2":
            case #"hash_311012bc01bd3d35":
            case #"hash_311017bc01bd4514":
            case #"hash_311018bc01bd46a7":
                nibvalue = int( nib );
                break;
            case #"hash_31103fbc01bd840c":
            case #"hash_31105fbc01bdb66c":
                nibvalue = 10;
                break;
            case #"hash_311042bc01bd88c5":
            case #"hash_311062bc01bdbb25":
                nibvalue = 11;
                break;
            case #"hash_311041bc01bd8732":
            case #"hash_311061bc01bdb992":
                nibvalue = 12;
                break;
            case #"hash_31103cbc01bd7f53":
            case #"hash_31105cbc01bdb1b3":
                nibvalue = 13;
                break;
            case #"hash_31103bbc01bd7dc0":
            case #"hash_31105bbc01bdb020":
                nibvalue = 14;
                break;
            case #"hash_31103ebc01bd8279":
            case #"hash_31105ebc01bdb4d9":
                nibvalue = 15;
                break;
        }
        
        intvalue = int( intvalue << 4 | int( nibvalue ) );
    }
    
    return intvalue;
}

// Namespace snd
// Params 2
// Checksum 0xa1f609a7, Offset: 0x34e8
// Size: 0x1a6
function get_scenedef_ents( scenedef, willexcludeplayers = 1 )
{
    instances = [];
    var_849e5d9b8eb64c0c = utility::getstructarray( scenedef, "scriptbundlename" );
    instances = arraycombine( var_849e5d9b8eb64c0c, instances );
    instances_active = [];
    instances = arraycombine( instances_active, instances );
    instances_inactive = [];
    instances = arraycombine( instances_inactive, instances );
    scenedef_ents = [];
    
    if ( isarray( instances ) && instances.size > 0 )
    {
        foreach ( i in instances )
        {
            if ( isarray( i.scene_ents ) )
            {
                scenedef_ents = arraycombine( i.scene_ents, scenedef_ents );
                scenedef_ents = function_5713d46873b29625( scenedef_ents );
                
                if ( willexcludeplayers )
                {
                    foreach ( e in scenedef_ents )
                    {
                        if ( isplayersafe( e ) )
                        {
                            scenedef_ents = arrayremove( scenedef_ents, e );
                        }
                    }
                }
            }
        }
    }
    
    return scenedef_ents;
}

// Namespace snd
// Params 3
// Checksum 0xd25d2f70, Offset: 0x3697
// Size: 0x35
function scr_getentitiesinradius( org, radius, _ignored )
{
    ents = getentarrayinradius( undefined, undefined, org, radius );
    return ents;
}

// Namespace snd
// Params 5
// Checksum 0xb33e4547, Offset: 0x36d5
// Size: 0x147
function function_51d82def583d96a( arr, origin, forward, fov = 65, maxdistance )
{
    cosfov = cos( fov );
    
    if ( !isdefined( maxdistance ) )
    {
        maxdistance = 262144;
    }
    
    maxdistance_sq = squared( maxdistance );
    visible = [];
    
    foreach ( v in arr )
    {
        dist_sq = distancesquared( v.origin, origin );
        
        if ( dist_sq <= maxdistance_sq )
        {
            delta = v.origin - origin;
            normalized = vectornormalize( delta );
            dot = vectordot( forward, normalized );
            
            if ( dot >= cosfov )
            {
                visible[ visible.size ] = v;
            }
        }
    }
    
    return visible;
}

// Namespace snd
// Params 4
// Checksum 0x992b542b, Offset: 0x3825
// Size: 0x132
function function_f1c888429fdb949f( origin, forward, arr, maxdistance = 262144 )
{
    maxdistance_sq = squared( maxdistance );
    closest = undefined;
    closestdot = 0;
    
    foreach ( v in arr )
    {
        dist_sq = distancesquared( v.origin, origin );
        
        if ( dist_sq <= maxdistance_sq )
        {
            delta = v.origin - origin;
            normalized = vectornormalize( delta );
            dot = vectordot( forward, normalized );
            
            if ( dot > closestdot )
            {
                closest = v;
                closestdot = dot;
            }
        }
    }
    
    return closest;
}

// Namespace snd
// Params 4
// Checksum 0x87005949, Offset: 0x3960
// Size: 0x17e
function function_6d90d69a99a38950( alertlevel, origin, radius, team )
{
    var_36aa0a42bdf110df = isvector( origin ) && isnumber( radius );
    hasteam = isstring( team );
    ents = undefined;
    
    if ( hasteam && var_36aa0a42bdf110df )
    {
        ents = getaiarrayinradius( origin, radius, team );
    }
    else if ( hasteam && !var_36aa0a42bdf110df )
    {
        ents = getaiarray( team );
    }
    else if ( !hasteam && var_36aa0a42bdf110df )
    {
        ents = getaiarrayinradius( origin, radius );
    }
    else
    {
        ents = getaiarray();
    }
    
    assert( isarray( ents ), "<dev string:x2bf>" );
    
    if ( ents.size > 0 && isstring( alertlevel ) && alertlevel != "" )
    {
        ai_array = [];
        
        foreach ( ent in ents )
        {
            if ( isstring( ent.alertlevel ) && ent.alertlevel == alertlevel )
            {
                ai_array[ ai_array.size ] = ent;
            }
        }
        
        return ai_array;
    }
    
    return ents;
}

// Namespace snd
// Params 2
// Checksum 0xf9d65bc5, Offset: 0x3ae7
// Size: 0x2f
function function_2466c32d49675ad1( alertlevel, team )
{
    ents = function_6d90d69a99a38950( alertlevel, undefined, undefined, team );
    return ents;
}

// Namespace snd
// Params 3
// Checksum 0x5fd880e9, Offset: 0x3b1f
// Size: 0xf3
function function_fb3aa5e5cfafdf81( alertlevel, targets, team )
{
    if ( !isarray( targets ) )
    {
        targets = [ targets ];
    }
    
    ents = function_2466c32d49675ad1( alertlevel, team );
    
    if ( ents.size > 0 )
    {
        ai_array = [];
        
        foreach ( ent in ents )
        {
            if ( isent( ent.enemy ) && arraycontains( targets, ent.enemy ) )
            {
                ai_array[ ai_array.size ] = ent;
            }
        }
        
        return ai_array;
    }
    
    return ents;
}

// Namespace snd
// Params 2
// Checksum 0xe2688a35, Offset: 0x3c1b
// Size: 0x186
function function_b61550454862daa8( targets = [ level.player ], team = "bad_guys" )
{
    if ( team == "bad_guys" )
    {
        team = "axis";
    }
    
    vehicles = vehicle_getarray();
    
    if ( isarray( vehicles ) && vehicles.size > 0 )
    {
        vehs = [];
        
        foreach ( veh in vehicles )
        {
            if ( isstring( veh.team ) && veh.team == team || isstring( veh.script_team ) && veh.script_team == team )
            {
                if ( isent( veh.enemy ) && arraycontains( targets, veh.enemy ) )
                {
                    vehs[ vehs.size ] = veh;
                    continue;
                }
                
                turret_target = veh getturrettargetent();
                
                if ( isent( turret_target ) && arraycontains( targets, turret_target ) )
                {
                    vehs[ vehs.size ] = veh;
                }
            }
        }
        
        return vehs;
    }
    
    return vehicles;
}

// Namespace snd
// Params 1
// Checksum 0xbc3c3491, Offset: 0x3daa
// Size: 0x9c, Type: bool
function function_8e33f9165866a9d2( players )
{
    if ( isarray( players ) )
    {
        foreach ( player in players )
        {
            if ( isplayer( player ) && player.sentientattackercount > 0 )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace snd
// Params 1
// Checksum 0xec81dd84, Offset: 0x3e4f
// Size: 0x2a, Type: bool
function function_426f0eac71ed60a2( squad )
{
    if ( issquad( squad ) )
    {
        return function_8e33f9165866a9d2( squad.players );
    }
    
    return false;
}

// Namespace snd
// Params 1
// Checksum 0x6a76673a, Offset: 0x3e82
// Size: 0xb5
function function_be8701d28e71efbd( players )
{
    attacker_count = 0;
    
    if ( isarray( players ) )
    {
        foreach ( player in players )
        {
            if ( isplayer( player ) && player.sentientattackercount > 0 )
            {
                attacker_count += player.sentientattackercount;
            }
        }
    }
    
    return attacker_count;
}

// Namespace snd
// Params 1
// Checksum 0x45641f9b, Offset: 0x3f40
// Size: 0x2a
function function_8e80e4fd00155a1d( squad )
{
    if ( issquad( squad ) )
    {
        return function_be8701d28e71efbd( squad.players );
    }
    
    return 0;
}

// Namespace snd
// Params 1
// Checksum 0x2259473e, Offset: 0x3f73
// Size: 0x28
function function_c401f0837df862eb( squad )
{
    while ( issquad( squad ) && !function_426f0eac71ed60a2( squad ) )
    {
        waitframe();
    }
}

// Namespace snd
// Params 1
// Checksum 0x68981c8a, Offset: 0x3fa3
// Size: 0x1b
function function_befbf25eb5dd5667( squad )
{
    while ( function_426f0eac71ed60a2( squad ) )
    {
        waitframe();
    }
}

// Namespace snd
// Params 1
// Checksum 0x7c85b152, Offset: 0x3fc6
// Size: 0x159
function function_25592a59fb9de67c( value )
{
    color = ( 0.309804, 0.152941, 0.623529 );
    
    if ( value < 0.32 )
    {
        frac = scalerp( value, 0, 0.32, 0, 1 );
        color = vectorlerp( ( 0.309804, 0.152941, 0.623529 ), ( 0.937255, 0.309804, 0.309804 ), frac );
    }
    else if ( value < 0.64 )
    {
        frac = scalerp( value, 0.32, 0.64, 0, 1 );
        color = vectorlerp( ( 0.937255, 0.309804, 0.309804 ), ( 0.937255, 0.623529, 0.309804 ), frac );
    }
    else if ( value < 0.96 )
    {
        frac = scalerp( value, 0.64, 0.96, 0, 1 );
        color = vectorlerp( ( 0.937255, 0.623529, 0.309804 ), ( 0.937255, 0.937255, 0.309804 ), frac );
    }
    else
    {
        frac = scalerp( value, 0.96, 1, 0, 1 );
        color = vectorlerp( ( 0.937255, 0.937255, 0.309804 ), ( 0.937255, 0.937255, 0.937255 ), frac );
    }
    
    return color;
}

// Namespace snd
// Params 1
// Checksum 0xc15f0ed7, Offset: 0x4128
// Size: 0xb4
function function_38325378bdc09e81( state )
{
    switch ( state )
    {
        default:
            break;
        case #"hash_1c39674e5b0de0f3":
            return ( 0.937255, 0.937255, 0.937255 );
        case #"hash_186d745a92c317d9":
            return ( 0.937255, 0.937255, 0.309804 );
        case #"hash_3015d6b4c9f55525":
            return ( 0.937255, 0.623529, 0.309804 );
        case #"hash_9e02cd4a0f3ca981":
            return ( 0.937255, 0.309804, 0.309804 );
        case #"hash_7b6614415d1b2e48":
            return ( 0.309804, 0.623529, 0.937255 );
    }
    
    return ( 1, 1, 1 );
}

// Namespace snd
// Params 1
// Checksum 0x2532e8fd, Offset: 0x41e5
// Size: 0xdf
function function_c90113f46cd1abe8( ai )
{
    if ( issentient( ai ) )
    {
        if ( ai.stealth_enabled && isnumber( ai.stealth_bsmstate ) )
        {
            switch ( ai.stealth_bsmstate )
            {
                case 0:
                    return "idle";
                case 1:
                    return "investigate";
                case 2:
                    return "hunt";
                case 3:
                    return "combat";
                case 4:
                default:
                    return "???";
            }
        }
        else
        {
            return ( ai.alertlevel == "noncombat" ? "idle" : ai.alertlevel );
        }
    }
    
    return "???";
}

// Namespace snd
// Params 1
// Checksum 0x2c8fd790, Offset: 0x42cd
// Size: 0x13a
function function_c8c5f9c0ee8f80c0( state = "" )
{
    color = undefined;
    assert( isstring( state ), "<dev string:x2f6>" );
    
    switch ( state )
    {
        case #"hash_d2a4c56b6b9ff274":
        default:
            color = ( randomfloatrange( 0.5, 1 ), randomfloatrange( 0.5, 1 ), randomfloatrange( 0.5, 1 ) );
            break;
        case #"hash_1c39674e5b0de0f3":
        case #"hash_4d6a329017fe1bd0":
        case #"hash_9128327eb51e0b7b":
        case #"hash_c6076a90d1a76064":
            color = ( 0.72974, 0.72974, 0.72974 );
            break;
        case #"hash_186d745a92c317d9":
        case #"hash_21c69ec47c409a66":
        case #"hash_37bb23543c319104":
        case #"hash_e21b072df2b47f94":
            color = ( 0.937255, 0.937255, 0.309804 );
            break;
        case #"hash_2d1406e602f0875d":
        case #"hash_9e02cd4a0f3ca981":
            color = ( 0.937255, 0.309804, 0.309804 );
            break;
    }
    
    return color;
}

