// scripts\mp\dmz\modified_values.gsc  (hash_5fcd2d34484df23e.gscc) (size: 2258 Bytes / 0x8d2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x57ce45b (92071003)
// size ...... 2258 (0x8d2)
// includes .. 0   (offset: 0x8d2)
// strings ... 0   (offset: 0x8d2)
// dev strs .. 0   (offset: 0x8d2)
// exports ... 15  (offset: 0x596)
// cseg ...... 0x58 + 0x53e (0x596)
// imports ... 7   (offset: 0x7ee)
// animtree1 . 0   (offset: 0x8d2)
// animtree2 . 0   (offset: 0x8d2)
#namespace modified_values;

// Namespace modified_values
// Params 1, eflags: 0x4
// Checksum 0x50f09e64, Offset: 0x76
// Size: 0x43
function private validatevalue( name )
{
    vals = self.modified_values ?? [];
    
    if ( !vals[ name ] )
    {
        vals[ name ] = function_101a9189c343a6da();
    }
    
    self.modified_values = vals;
}

// Namespace modified_values
// Params 0, eflags: 0x4
// Checksum 0x55b255b6, Offset: 0xc1
// Size: 0x2e
function private function_101a9189c343a6da()
{
    struct = spawnstruct();
    struct.funcs = [];
    struct.totalvals = [];
    return struct;
}

// Namespace modified_values
// Params 4, eflags: 0x4
// Checksum 0xf49372bb, Offset: 0xf8
// Size: 0xd8
function private function_a9cceea8bb82b393( name, modref, modvalue, type )
{
    validatevalue( name );
    struct = spawnstruct();
    struct.ref = modref;
    struct.val = modvalue;
    
    if ( !isdefined( self.modified_values[ name ].funcs[ type ] ) )
    {
        self.modified_values[ name ].funcs[ type ] = [];
    }
    
    self.modified_values[ name ].funcs[ type ][ modref ] = struct;
    self.modified_values[ name ] function_7ee718e37746376a( type );
    self.modified_values[ name ].base = undefined;
}

// Namespace modified_values
// Params 3, eflags: 0x4
// Checksum 0xb0bbde1b, Offset: 0x1d8
// Size: 0x82
function private function_601f070b6fa7d5e6( name, modref, type )
{
    if ( !isdefined( self.modified_values[ name ].funcs[ type ][ modref ] ) )
    {
        return;
    }
    
    self.modified_values[ name ].funcs[ type ][ modref ] = undefined;
    self.modified_values[ name ] function_7ee718e37746376a( type );
    self.modified_values[ name ].base = undefined;
}

// Namespace modified_values
// Params 1, eflags: 0x4
// Checksum 0x655075ce, Offset: 0x262
// Size: 0xb2
function private function_7ee718e37746376a( type )
{
    self.totalvals[ type ] = 0;
    
    foreach ( struct in self.funcs[ type ] )
    {
        self.totalvals[ type ] += struct.val;
    }
}

// Namespace modified_values
// Params 2
// Checksum 0xe893c18b, Offset: 0x31c
// Size: 0x10b
function function_14d05d73e63e1f9e( name, value )
{
    if ( !isdefined( value ) || !isdefined( self.modified_values[ name ] ) )
    {
        return value;
    }
    
    if ( self.modified_values[ name ].base == value )
    {
        return self.modified_values[ name ].var_f5ff424098b1d5f9;
    }
    
    self.modified_values[ name ].base = value;
    struct = self.modified_values[ name ];
    value *= struct.totalvals[ 2 ] ?? 1;
    value /= struct.totalvals[ 3 ] ?? 1;
    value += struct.totalvals[ 0 ] ?? 0;
    value -= struct.totalvals[ 1 ] ?? 0;
    self.modified_values[ name ].var_f5ff424098b1d5f9 = value;
    return value;
}

// Namespace modified_values
// Params 3
// Checksum 0xc7a967f1, Offset: 0x430
// Size: 0x2a
function add( name, modref, modvalue )
{
    function_a9cceea8bb82b393( name, modref, modvalue, 0 );
}

// Namespace modified_values
// Params 3
// Checksum 0x1beb0e9e, Offset: 0x462
// Size: 0x2b
function function_5c707a1342e5975a( name, modref, modvalue )
{
    function_a9cceea8bb82b393( name, modref, modvalue, 1 );
}

// Namespace modified_values
// Params 3
// Checksum 0x2b05355f, Offset: 0x495
// Size: 0x2b
function function_200ffcde884aee82( name, modref, modvalue )
{
    function_a9cceea8bb82b393( name, modref, modvalue, 2 );
}

// Namespace modified_values
// Params 3
// Checksum 0xb92dd95d, Offset: 0x4c8
// Size: 0x2b
function function_175fdacc04e4775b( name, modref, modvalue )
{
    function_a9cceea8bb82b393( name, modref, modvalue, 3 );
}

// Namespace modified_values
// Params 2
// Checksum 0xc0916add, Offset: 0x4fb
// Size: 0x20
function removeadd( name, modref )
{
    function_601f070b6fa7d5e6( name, modref, 0 );
}

// Namespace modified_values
// Params 2
// Checksum 0xdf61abe7, Offset: 0x523
// Size: 0x21
function function_e9fb603d1486f2ea( name, modref )
{
    function_601f070b6fa7d5e6( name, modref, 1 );
}

// Namespace modified_values
// Params 2
// Checksum 0xef8f9026, Offset: 0x54c
// Size: 0x21
function function_72b1c8140e33bf66( name, modref )
{
    function_601f070b6fa7d5e6( name, modref, 2 );
}

// Namespace modified_values
// Params 2
// Checksum 0x80dce55e, Offset: 0x575
// Size: 0x21
function function_309cb941477d946b( name, modref )
{
    function_601f070b6fa7d5e6( name, modref, 3 );
}

