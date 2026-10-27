// script_25f7d83c36862807  (hash_25f7d83c36862807.gscc) (size: 2707 Bytes / 0xa93 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb9376582 (3107415426)
// size ...... 2707 (0xa93)
// includes .. 4   (offset: 0xa43)
// strings ... 1   (offset: 0xa63)
// dev strs .. 3   (offset: 0xa6f)
// exports ... 13  (offset: 0x5b7)
// cseg ...... 0x65 + 0x552 (0x5b7)
// imports ... 20  (offset: 0x7bf)
// animtree1 . 0   (offset: 0xa93)
// animtree2 . 0   (offset: 0xa93)
#using scripts\common\callbacks;
#using scripts\mp\equipment;
#using scripts\mp\player\grapple;
#using scripts\mp\supers;

#namespace namespace_e6b8ff332c074970;

// Namespace namespace_e6b8ff332c074970
// Params 10
// Checksum 0xc133363, Offset: 0x83
// Size: 0xb9
function register( ref, setfunc, unsetfunc, beginusefunc, endusefunc, var_49661824f9845c52, ongivefunc, var_a7ba5cee6855a3ad, reclaimfunc, var_9d4e2d5725711898 )
{
    staticdata = level.superglobals.staticsuperdata[ ref ];
    
    if ( !isdefined( staticdata ) )
    {
        return;
    }
    
    bundle = staticdata.bundle;
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    supers_mp::function_48aaa60b2ce7b8a1( ref, setfunc, unsetfunc, beginusefunc, endusefunc, var_49661824f9845c52, ongivefunc, var_a7ba5cee6855a3ad, reclaimfunc, var_9d4e2d5725711898 );
}

// Namespace namespace_e6b8ff332c074970
// Params 1
// Checksum 0x1c2fc1ca, Offset: 0x144
// Size: 0x14
function setsuper( superref )
{
    namespace_999f317f0f814479::function_a0d6ef86f55e7cfd( self );
}

// Namespace namespace_e6b8ff332c074970
// Params 1
// Checksum 0x2434810d, Offset: 0x160
// Size: 0x1d
function unsetsuper( superref )
{
    namespace_999f317f0f814479::function_a94e14b573700765( self );
    function_a4d52f8852dbfa6b( superref );
}

// Namespace namespace_e6b8ff332c074970
// Params 5
// Checksum 0xa14e426d, Offset: 0x185
// Size: 0x87
function function_8b5c1e5efaeccd48( superref, callbackparams, var_a457446b45edbad9, var_c89b325a95abf06a, var_9b8284562d031fb7 )
{
    if ( callbackparams.superref == superref )
    {
        namespace_999f317f0f814479::function_17da84fdf0008ba6( self, var_a457446b45edbad9, var_c89b325a95abf06a, var_9b8284562d031fb7 );
        
        if ( !self isgrapplefiring() )
        {
            ammospent = callbackparams.var_ad5ed056cc5bb841 - callbackparams.currentammo;
            equipment_mp::incrementequipmentslotammo( "secondary", ammospent );
        }
    }
}

// Namespace namespace_e6b8ff332c074970
// Params 6
// Checksum 0x8b453f75, Offset: 0x214
// Size: 0x118, Type: bool
function beginuse( superref, var_a457446b45edbad9, var_c89b325a95abf06a, var_9b8284562d031fb7, cancelfunc, var_d58499cb1b02d04e )
{
    assert( superref );
    assert( isfunction( var_a457446b45edbad9 ) );
    assert( isfunction( var_c89b325a95abf06a ) );
    assert( isfunction( var_9b8284562d031fb7 ) );
    assert( isfunction( cancelfunc ) );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( superref );
    assert( isdefined( bundle ), "<dev string:x24>" );
    
    if ( bundle.var_8b9eade13fbfb044 )
    {
        function_34390a7662271ec6( superref, #"super_cancel", cancelfunc );
    }
    
    superhasammousage = supers_mp::superhasammousage( supers_mp::getcurrentsuper( #"tactical" ), #"tactical" );
    
    if ( superhasammousage )
    {
        if ( var_d58499cb1b02d04e )
        {
            function_34390a7662271ec6( superref, #"hash_ffc49165b0271655", var_d58499cb1b02d04e );
        }
    }
    else
    {
        namespace_999f317f0f814479::function_17da84fdf0008ba6( self, var_a457446b45edbad9, var_c89b325a95abf06a, var_9b8284562d031fb7 );
    }
    
    return true;
}

// Namespace namespace_e6b8ff332c074970
// Params 1
// Checksum 0x78d3b57b, Offset: 0x335
// Size: 0x3f
function canceluse( superref )
{
    namespace_999f317f0f814479::forcecleanup( self );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( superref );
    
    if ( bundle.var_8b9eade13fbfb044 )
    {
        function_a4d52f8852dbfa6b( superref );
    }
}

// Namespace namespace_e6b8ff332c074970
// Params 1
// Checksum 0xcbc91230, Offset: 0x37c
// Size: 0x51, Type: bool
function function_44fb742853607576( superref )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( superref );
    assert( isdefined( bundle ), "<dev string:x8d>" + superref + "<dev string:xae>" );
    
    if ( bundle.var_8b9eade13fbfb044 )
    {
        function_a4d52f8852dbfa6b( superref );
    }
    
    return false;
}

// Namespace namespace_e6b8ff332c074970
// Params 1
// Checksum 0x6b704a9f, Offset: 0x3d6
// Size: 0x4c
function onmiss( superref )
{
    superhasammousage = supers_mp::superhasammousage( supers_mp::getcurrentsuper( #"tactical" ), #"tactical" );
    
    if ( !superhasammousage )
    {
        supers_mp::refundsuper( #"tactical" );
    }
}

// Namespace namespace_e6b8ff332c074970
// Params 1
// Checksum 0x392c5b7c, Offset: 0x42a
// Size: 0xc
function function_44acf016f264110c( superref )
{
    
}

// Namespace namespace_e6b8ff332c074970
// Params 1
// Checksum 0x1e342cfd, Offset: 0x43e
// Size: 0xc
function function_f5003f9cde4967d5( superref )
{
    
}

// Namespace namespace_e6b8ff332c074970
// Params 3, eflags: 0x4
// Checksum 0x91f91b76, Offset: 0x452
// Size: 0x8b
function private function_34390a7662271ec6( superref, callbackname, callbackfunc )
{
    assert( isfunction( callbackfunc ) );
    assert( !callback::exists( callbackname, callbackfunc ) );
    callback::add( callbackname, callbackfunc );
    
    if ( !isdefined( self.var_14bd22e2a61ad399 ) )
    {
        self.var_14bd22e2a61ad399 = [];
    }
    
    if ( !isdefined( self.var_14bd22e2a61ad399[ superref ] ) )
    {
        self.var_14bd22e2a61ad399[ superref ] = [];
    }
    
    self.var_14bd22e2a61ad399[ superref ][ callbackname ] = callbackfunc;
}

// Namespace namespace_e6b8ff332c074970
// Params 1, eflags: 0x4
// Checksum 0xf0575bb2, Offset: 0x4e5
// Size: 0xd2
function private function_a4d52f8852dbfa6b( superref )
{
    if ( !self.var_14bd22e2a61ad399 )
    {
        return;
    }
    
    foreach ( callbackname, callbackfunc in self.var_14bd22e2a61ad399[ superref ] )
    {
        if ( callbackfunc )
        {
            assert( callback::exists( callbackname, callbackfunc ) );
            callback::remove( callbackname, callbackfunc );
        }
    }
    
    self.var_14bd22e2a61ad399[ superref ] = undefined;
    
    if ( self.var_14bd22e2a61ad399.size == 0 )
    {
        self.var_14bd22e2a61ad399 = undefined;
    }
}

