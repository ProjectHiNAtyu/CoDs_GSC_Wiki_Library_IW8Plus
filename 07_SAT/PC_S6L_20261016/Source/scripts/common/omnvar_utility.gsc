// scripts\common\omnvar_utility.gsc  (hash_7c6926e32dc49782.gscc) (size: 2443 Bytes / 0x98b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa72c3c7f (2804694143)
// size ...... 2443 (0x98b)
// includes .. 1   (offset: 0x95f)
// strings ... 0   (offset: 0x967)
// dev strs .. 3   (offset: 0x967)
// exports ... 15  (offset: 0x5a3)
// cseg ...... 0x58 + 0x54b (0x5a3)
// imports ... 12  (offset: 0x7fb)
// animtree1 . 0   (offset: 0x98b)
// animtree2 . 0   (offset: 0x98b)
#using scripts\common\callbacks;

#namespace omnvar_utility;

// Namespace omnvar_utility
// Params 0, eflags: 0x1
// Checksum 0xca6bbc8e, Offset: 0x76
// Size: 0x17
function autoexec init()
{
    callback::add( #"player_spawned", &onplayerspawned );
}

// Namespace omnvar_utility
// Params 2
// Checksum 0xb0914b4b, Offset: 0x95
// Size: 0x6f
function setcachedgameomnvar( omnvar, value )
{
    if ( !( isdefined( omnvar ) && isdefined( value ) ) )
    {
        return;
    }
    
    if ( !isdefined( level.cachedomnars ) )
    {
        level.cachedomnars = [];
    }
    
    shouldset = level.cachedomnars[ omnvar ] != value;
    
    if ( shouldset )
    {
        level.cachedomnars[ omnvar ] = value;
        setomnvar( omnvar, value );
    }
}

// Namespace omnvar_utility
// Params 2
// Checksum 0x751774ca, Offset: 0x10c
// Size: 0x75
function setcachedclientomnvar( omnvar, value )
{
    if ( !( isdefined( self ) && isdefined( omnvar ) && isdefined( value ) ) )
    {
        return;
    }
    
    if ( !isdefined( self.cachedomnars ) )
    {
        self.cachedomnars = [];
    }
    
    shouldset = self.cachedomnars[ omnvar ] != value;
    
    if ( shouldset )
    {
        self.cachedomnars[ omnvar ] = value;
        self setclientomnvar( omnvar, value );
    }
}

// Namespace omnvar_utility
// Params 4
// Checksum 0x41606709, Offset: 0x189
// Size: 0x9c
function repackomnvar( bitoffset, bitwidth, prevpackedvalue, newvalue )
{
    mask = function_9b84713d01dc0a13( bitwidth );
    assert( newvalue <= mask, "<dev string:x24>" + newvalue + "<dev string:x3e>" + bitwidth + "<dev string:x57>" );
    shiftedvalue = ( newvalue & mask ) << bitoffset;
    invertedmask = ~( mask << bitoffset );
    cleanedbase = prevpackedvalue & invertedmask;
    repackedvalue = cleanedbase + shiftedvalue;
    return repackedvalue;
}

// Namespace omnvar_utility
// Params 3
// Checksum 0x92ce6d8f, Offset: 0x22e
// Size: 0x45
function unpackvalue( bitoffset, bitwidth, packedvalue )
{
    mask = function_9b84713d01dc0a13( bitwidth );
    shiftedvalue = packedvalue >> bitoffset & mask;
    return shiftedvalue;
}

// Namespace omnvar_utility
// Params 1, eflags: 0x4
// Checksum 0xb0876886, Offset: 0x27c
// Size: 0x14
function private function_9b84713d01dc0a13( bitwidth )
{
    return ( 1 << bitwidth ) - 1;
}

// Namespace omnvar_utility
// Params 4
// Checksum 0x43afadca, Offset: 0x299
// Size: 0x33
function function_85d5f88af471ac4b( omnvarname, bitoffset, bitwidth, value )
{
    self function_47457b9ec007482e( omnvarname, bitoffset, bitwidth, value );
}

// Namespace omnvar_utility
// Params 3
// Checksum 0x394356e2, Offset: 0x2d4
// Size: 0x27
function function_feb50abd0ba8a2e7( omnvarname, bitoffset, bitwidth )
{
    return self function_11cbb31553d5872a( omnvarname, bitoffset, bitwidth );
}

// Namespace omnvar_utility
// Params 4
// Checksum 0xe5a3aca8, Offset: 0x304
// Size: 0x32
function function_8b206c75cb7ad548( omnvarname, bitoffset, bitwidth, value )
{
    function_a9a8165656e26139( omnvarname, bitoffset, bitwidth, value );
}

// Namespace omnvar_utility
// Params 3
// Checksum 0x877081e0, Offset: 0x33e
// Size: 0x26
function function_764bc2ee92370f4c( omnvarname, bitoffset, bitwidth )
{
    return function_c8dbeacc32ede645( omnvarname, bitoffset, bitwidth );
}

// Namespace omnvar_utility
// Params 2
// Checksum 0x637da6aa, Offset: 0x36d
// Size: 0x64
function function_848be99d5f69a20e( omnvarname, callback )
{
    if ( !isdefined( level.omnvarcallbacks ) )
    {
        level.omnvarcallbacks = [];
    }
    
    if ( !isdefined( level.omnvarcallbacks[ omnvarname ] ) )
    {
        level.omnvarcallbacks[ omnvarname ] = [];
    }
    
    level.omnvarcallbacks[ omnvarname ][ level.omnvarcallbacks[ omnvarname ].size ] = callback;
}

// Namespace omnvar_utility
// Params 2
// Checksum 0x51fa6627, Offset: 0x3d9
// Size: 0x99
function function_58bd31d56367a73d( omnvarname, omnvarvalue )
{
    self setclientomnvar( omnvarname, omnvarvalue );
    
    foreach ( callback in level.omnvarcallbacks[ omnvarname ] )
    {
        self [[ callback ]]( omnvarvalue );
    }
}

// Namespace omnvar_utility
// Params 2
// Checksum 0xd56f5489, Offset: 0x47a
// Size: 0x6d
function function_8734497daff87527( omnvarname, omnvarvalue )
{
    profilestart();
    
    if ( isalive( self ) )
    {
        self setclientomnvar( omnvarname, omnvarvalue );
    }
    else
    {
        if ( !isdefined( self.var_acf8795cbe1c333c ) )
        {
            self.var_acf8795cbe1c333c = [];
        }
        
        self.var_acf8795cbe1c333c[ self.var_acf8795cbe1c333c.size ] = { #omnvarvalue:omnvarvalue, #omnvarname:omnvarname };
    }
    
    profilestop();
}

// Namespace omnvar_utility
// Params 1, eflags: 0x4
// Checksum 0x90f12250, Offset: 0x4ef
// Size: 0xb4
function private onplayerspawned( params )
{
    profilestart();
    
    if ( !self.var_acf8795cbe1c333c.size )
    {
        profilestop();
        return;
    }
    
    foreach ( info in self.var_acf8795cbe1c333c )
    {
        self setclientomnvar( info.omnvarname, info.omnvarvalue );
    }
    
    self.var_acf8795cbe1c333c = undefined;
    profilestop();
}

