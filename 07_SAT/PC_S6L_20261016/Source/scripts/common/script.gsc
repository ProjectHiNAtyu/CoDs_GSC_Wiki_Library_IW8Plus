// scripts\common\script.gsc  (hash_54d0de7496fceea5.gscc) (size: 6359 Bytes / 0x18d7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x721f3a04 (1914649092)
// size ...... 6359 (0x18d7)
// includes .. 0   (offset: 0x17f7)
// strings ... 11  (offset: 0x17f7)
// dev strs .. 7   (offset: 0x187f)
// exports ... 36  (offset: 0xe4b)
// cseg ...... 0xd8 + 0xd73 (0xe4b)
// imports ... 33  (offset: 0x13eb)
// animtree1 . 0   (offset: 0x18d7)
// animtree2 . 0   (offset: 0x18d7)
#namespace script;

// Namespace script
// Params 2
// Checksum 0xe3df296d, Offset: 0xf6
// Size: 0xa2
function waittillslowprocessallowed( allowloop, frameendonly )
{
    if ( level.lastslowprocessframe == gettime() )
    {
        if ( allowloop )
        {
            do
            {
                waitframe();
                
                if ( frameendonly )
                {
                    waittillframeend();
                }
            }
            while ( level.lastslowprocessframe == gettime() );
        }
        else
        {
            waitframe();
            
            if ( frameendonly )
            {
                waittillframeend();
            }
            
            if ( level.lastslowprocessframe == gettime() )
            {
                waitframe();
                
                if ( frameendonly )
                {
                    waittillframeend();
                }
                
                if ( level.lastslowprocessframe == gettime() )
                {
                    waitframe();
                    
                    if ( frameendonly )
                    {
                        waittillframeend();
                    }
                    
                    if ( level.lastslowprocessframe == gettime() )
                    {
                        waitframe();
                        
                        if ( frameendonly )
                        {
                            waittillframeend();
                        }
                    }
                }
            }
        }
    }
    
    level.lastslowprocessframe = gettime();
}

// Namespace script
// Params 0
// Checksum 0x83615f7, Offset: 0x1a0
// Size: 0x1c
function function_f82d6641490331a9()
{
    level.lastslowprocessframe = maxint( level.lastslowprocessframe, gettime() );
}

// Namespace script
// Params 0
// Checksum 0x44b6567e, Offset: 0x1c4
// Size: 0x14
function function_e1c5c030f026248c()
{
    return gettime() - ( level.lastslowprocessframe ?? 0 );
}

// Namespace script
// Params 0
// Checksum 0x492f979a, Offset: 0x1e1
// Size: 0x10, Type: bool
function function_7cae34dfec48a6d1()
{
    return level.lastslowprocessframe === gettime();
}

// Namespace script
// Params 1
// Checksum 0xbb9b5aab, Offset: 0x1fa
// Size: 0x46
function queuecreate( queuename )
{
    if ( !isdefined( level.queues ) )
    {
        level.queues = [];
    }
    
    assert( !isdefined( level.queues[ queuename ] ) );
    level.queues[ queuename ] = [];
}

// Namespace script
// Params 2
// Checksum 0xe048aad5, Offset: 0x248
// Size: 0x46
function queueadd( queuename, entity )
{
    assert( isdefined( level.queues[ queuename ] ) );
    level.queues[ queuename ][ level.queues[ queuename ].size ] = entity;
}

// Namespace script
// Params 1
// Checksum 0x70c1695d, Offset: 0x296
// Size: 0xd9
function queueremovefirst( queuename )
{
    assert( isdefined( level.queues[ queuename ] ) );
    first = undefined;
    newqueue = [];
    
    foreach ( element in level.queues[ queuename ] )
    {
        if ( !isdefined( element ) )
        {
            continue;
        }
        
        if ( !isdefined( first ) )
        {
            first = element;
            continue;
        }
        
        newqueue[ newqueue.size ] = element;
    }
    
    level.queues[ queuename ] = newqueue;
    return first;
}

// Namespace script
// Params 2
// Checksum 0x195aa015, Offset: 0x378
// Size: 0x38
function limitdecimalplaces( value, places )
{
    modifier = int( pow( 10, places ) );
    return floor( value * modifier ) / modifier;
}

// Namespace script
// Params 3
// Checksum 0x4573ca38, Offset: 0x3b9
// Size: 0x9b
function rounddecimalplaces( value, places, style = "nearest" )
{
    modifier = int( pow( 10, places ) );
    newvalue = value * modifier;
    
    if ( style == "up" )
    {
        roundedvalue = ceil( newvalue );
    }
    else if ( style == "down" )
    {
        roundedvalue = floor( newvalue );
    }
    else
    {
        roundedvalue = newvalue + 0.5;
    }
    
    newvalue = int( roundedvalue ) / modifier;
    return newvalue;
}

// Namespace script
// Params 1
// Checksum 0x3b43630e, Offset: 0x45d
// Size: 0x96
function stringtofloat( stringval )
{
    floatelements = strtok( stringval, "." );
    floatval = int( floatelements[ 0 ] );
    
    if ( isdefined( floatelements[ 1 ] ) )
    {
        modifier = 1;
        
        for ( i = 0; i < floatelements[ 1 ].size ; i++ )
        {
            modifier *= 0.1;
        }
        
        floatval += int( floatelements[ 1 ] ) * modifier;
    }
    
    if ( stringval[ 0 ] == "-" )
    {
        floatval *= -1;
    }
    
    return floatval;
}

// Namespace script
// Params 1
// Checksum 0xd3546914, Offset: 0x4fc
// Size: 0x26
function delayentdelete( time )
{
    self endon( #"death" );
    wait time;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace script
// Params 3, eflags: 0x40 variadic
// Checksum 0xb9106b70, Offset: 0x52a
// Size: 0x3e
function bufferednotify( notification, ... )
{
    thread bufferednotify_internal( notification, { #params:vararg, #count:varargcount } );
}

// Namespace script
// Params 0, eflags: 0x4
// Checksum 0x31894638, Offset: 0x570
// Size: 0x69
function private function_284c2ae5583007bc()
{
    var_1f68bf13bc904879 = level.gametypebundle.var_d5a83b7f03ff465e ?? #"hash_dfcb6a2fdbc977b0";
    
    switch ( var_1f68bf13bc904879 )
    {
        case #"hash_dfcb6a2fdbc977b0":
        default:
            waittillframeend();
            return;
        case #"hash_16a4c2b6f68453e0":
            do
            {
                waitframe();
                waittillframeend();
            }
            while ( function_7cae34dfec48a6d1() );
            
            return;
    }
}

// Namespace script
// Params 0, eflags: 0x4
// Checksum 0xd81f8aa5, Offset: 0x5e1
// Size: 0x69
function private function_de23bc0ca8d2eba()
{
    var_1f68bf13bc904879 = level.gametypebundle.var_d5a83b7f03ff465e ?? #"hash_dfcb6a2fdbc977b0";
    
    switch ( var_1f68bf13bc904879 )
    {
        case #"hash_dfcb6a2fdbc977b0":
        default:
            waitframe();
            return;
        case #"hash_16a4c2b6f68453e0":
            do
            {
                waitframe();
                waittillframeend();
            }
            while ( function_7cae34dfec48a6d1() );
            
            return;
    }
}

// Namespace script
// Params 2, eflags: 0x4
// Checksum 0x6700ae10, Offset: 0x652
// Size: 0x10e
function private bufferednotify_internal( notification, var_3e69b0b43bd155b7 )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    uniqueendonnotify = "bufferedNotify_" + notification;
    self notify( uniqueendonnotify );
    self endon( uniqueendonnotify );
    
    if ( !isdefined( self.bufferednotifications ) )
    {
        self.bufferednotifications = [];
    }
    
    if ( !isdefined( self.bufferednotifications[ notification ] ) )
    {
        self.bufferednotifications[ notification ] = [];
    }
    
    self.bufferednotifications[ notification ][ self.bufferednotifications[ notification ].size ] = var_3e69b0b43bd155b7;
    function_284c2ae5583007bc();
    
    while ( isdefined( self ) && self.bufferednotifications[ notification ].size > 0 )
    {
        var_3e69b0b43bd155b7 = self.bufferednotifications[ notification ][ 0 ];
        self notify( notification, flat_args( var_3e69b0b43bd155b7.params, var_3e69b0b43bd155b7.count ) );
        self.bufferednotifications[ notification ][ 0 ] = undefined;
        function_cdc669dbc8ea2101( self.bufferednotifications[ notification ] );
        function_de23bc0ca8d2eba();
    }
}

// Namespace script
// Params 2
// Checksum 0x245943c9, Offset: 0x768
// Size: 0x41
function notifyafterframeend( waittillmsg, var_e3a1804111bee4c8 )
{
    assert( isdefined( waittillmsg ), "<dev string:x24>" );
    assert( isdefined( var_e3a1804111bee4c8 ), "<dev string:x5c>" );
    self waittill( waittillmsg );
    waittillframeend();
    self notify( var_e3a1804111bee4c8 );
}

// Namespace script
// Params 3
// Checksum 0x7f51ecb4, Offset: 0x7b1
// Size: 0x36
function delaysetclientomnvar( delaytime, omnvar, value )
{
    self endon( #"disconnect" );
    wait delaytime;
    self setclientomnvar( omnvar, value );
}

// Namespace script
// Params 2
// Checksum 0x126799fb, Offset: 0x7ef
// Size: 0x49
function strip_suffix( lookupstring, stripstring )
{
    if ( lookupstring.size <= stripstring.size )
    {
        return lookupstring;
    }
    
    if ( getsubstr( lookupstring, lookupstring.size - stripstring.size, lookupstring.size ) == stripstring )
    {
        return getsubstr( lookupstring, 0, lookupstring.size - stripstring.size );
    }
    
    return lookupstring;
}

// Namespace script
// Params 2
// Checksum 0x6c048696, Offset: 0x841
// Size: 0x45
function vectortoanglessafe( forward, up )
{
    right = vectorcross( forward, up );
    up = vectorcross( right, forward );
    angles = axistoangles( forward, right, up );
    return angles;
}

// Namespace script
// Params 1
// Checksum 0xcb751d3c, Offset: 0x88f
// Size: 0x94
function heap( type )
{
    assert( type == "<dev string:x91>" || type == "<dev string:x95>", "<dev string:x99>" );
    h = spawnstruct();
    h.nvals = 0;
    h.vals = [];
    
    if ( type == "max" )
    {
        h.swap = &_heaplessthan;
    }
    else if ( type == "min" )
    {
        h.swap = &_heapgreaterthan;
    }
    
    return h;
}

// Namespace script
// Params 0
// Checksum 0x72cac05c, Offset: 0x92c
// Size: 0xb
function heapsize()
{
    return self.nvals;
}

// Namespace script
// Params 0
// Checksum 0x82e3540d, Offset: 0x940
// Size: 0xe
function heappeek()
{
    return self.vals[ 1 ];
}

// Namespace script
// Params 0
// Checksum 0x8dec70ea, Offset: 0x957
// Size: 0xb9
function heappop()
{
    if ( self.nvals == 0 )
    {
        return;
    }
    
    if ( self.nvals == 1 )
    {
        val = self.vals[ 1 ];
        self.vals[ 1 ] = undefined;
        self.nvals = 0;
        return val;
    }
    
    val = self.vals[ 1 ];
    self.vals[ 1 ] = self.vals[ self.nvals ];
    self.vals[ self.nvals ] = undefined;
    _heapify( 1 );
    self.nvals -= 1;
    return val;
}

// Namespace script
// Params 1
// Checksum 0xed515bdd, Offset: 0xa18
// Size: 0xcf
function heapinsert( val )
{
    self.vals[ self.nvals + 1 ] = val;
    i = self.nvals + 1;
    parent = _heapparent( i );
    
    while ( isdefined( parent ) )
    {
        if ( [[ self.swap ]]( parent, i ) )
        {
            temp = self.vals[ parent ];
            self.vals[ parent ] = self.vals[ i ];
            self.vals[ i ] = temp;
            i = parent;
            parent = _heapparent( i );
            continue;
        }
        
        break;
    }
    
    self.nvals += 1;
}

/#

    // Namespace script
    // Params 0
    // Checksum 0x8b68121c, Offset: 0xaef
    // Size: 0x98, Type: dev
    function printheap()
    {
        print( "<dev string:xba>" );
        vals = [];
        size = self.nvals;
        
        for ( i = 0; i < size ; i++ )
        {
            vals[ i ] = heappop();
        }
        
        for ( i = 0; i < vals.size ; i++ )
        {
            heapinsert( vals[ i ] );
        }
        
        for ( i = 0; i < vals.size ; i++ )
        {
            print( vals[ i ] + "<dev string:xbe>" );
        }
        
        print( "<dev string:xba>" );
    }

#/

// Namespace script
// Params 2
// Checksum 0xae5e35d1, Offset: 0xb8f
// Size: 0x2e, Type: bool
function _heapgreaterthan( i, j )
{
    return self.vals[ i ] > self.vals[ j ];
}

// Namespace script
// Params 2
// Checksum 0xc66ba6ef, Offset: 0xbc6
// Size: 0x2e, Type: bool
function _heaplessthan( i, j )
{
    return self.vals[ i ] < self.vals[ j ];
}

// Namespace script
// Params 1
// Checksum 0x6f967da6, Offset: 0xbfd
// Size: 0x11b
function _heapify( i )
{
    lc = _heapleftchild( i );
    rc = _heaprightchild( i );
    newidx = undefined;
    swapleft = 0;
    
    if ( isdefined( lc ) )
    {
        swapleft = self [[ self.swap ]]( i, lc );
    }
    
    swapright = 0;
    
    if ( isdefined( rc ) )
    {
        swapright = self [[ self.swap ]]( i, rc );
    }
    
    if ( !swapleft && !swapright )
    {
        return;
    }
    else if ( swapleft && !swapright )
    {
        newidx = lc;
    }
    else if ( !swapleft && swapright )
    {
        newidx = rc;
    }
    else if ( self [[ self.swap ]]( lc, rc ) )
    {
        newidx = rc;
    }
    else
    {
        newidx = lc;
    }
    
    temp = self.vals[ i ];
    self.vals[ i ] = self.vals[ newidx ];
    self.vals[ newidx ] = temp;
    _heapify( newidx );
}

// Namespace script
// Params 1
// Checksum 0x78b24443, Offset: 0xd20
// Size: 0x26
function _heapleftchild( i )
{
    if ( !isdefined( self.vals[ 2 * i ] ) )
    {
        return;
    }
    
    return 2 * i;
}

// Namespace script
// Params 1
// Checksum 0xd056df93, Offset: 0xd4f
// Size: 0x2c
function _heaprightchild( i )
{
    if ( !isdefined( self.vals[ 2 * i + 1 ] ) )
    {
        return;
    }
    
    return 2 * i + 1;
}

// Namespace script
// Params 1
// Checksum 0x5355d07, Offset: 0xd84
// Size: 0x22
function _heapparent( i )
{
    if ( i == 1 )
    {
        return;
    }
    
    return int( floor( i / 2 ) );
}

// Namespace script
// Params 2
// Checksum 0xb31a7982, Offset: 0xdaf
// Size: 0x23, Type: bool
function isnumbermultipleof( number, factor )
{
    return number > 0 && number % factor == 0;
}

// Namespace script
// Params 1
// Checksum 0x51f2cf2, Offset: 0xddb
// Size: 0x13
function demoforcesre( message )
{
    throw( message );
}

// Namespace script
// Params 1
// Checksum 0x3b98c46f, Offset: 0xdf6
// Size: 0x1d
function function_2e2007575f92910d( message )
{
    recordeventforsreparser( "sre_error_event", "SRE LOGGING", message );
}

// Namespace script
// Params 2
// Checksum 0x53e699eb, Offset: 0xe1b
// Size: 0x30
function function_789a02669a1a12e9( dvar, message )
{
    if ( getdvarint( dvar, 0 ) )
    {
        recordeventforsreparser( "sre_error_event", "SRE LOGGING DVAR GATED", message );
    }
}

