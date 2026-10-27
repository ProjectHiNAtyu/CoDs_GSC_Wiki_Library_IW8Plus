// scripts\common\ae_utility.gsc  (hash_247745a526421ba7.gscc) (size: 5517 Bytes / 0x158d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x42912f96 (1116811158)
// size ...... 5517 (0x158d)
// includes .. 0   (offset: 0x143d)
// strings ... 1   (offset: 0x143d)
// dev strs .. 24  (offset: 0x1449)
// exports ... 13  (offset: 0xed9)
// cseg ...... 0x62 + 0xe77 (0xed9)
// imports ... 20  (offset: 0x10e1)
// animtree1 . 0   (offset: 0x158d)
// animtree2 . 0   (offset: 0x158d)
#namespace ae_utility;

// Namespace ae_utility
// Params 0, eflags: 0x4
// Checksum 0xe88b46bc, Offset: 0x80
// Size: 0x755
function private function_1ed5797f0c5d2d2f()
{
    if ( isdefined( level.var_3065ba48bd1dbc8b ) )
    {
        return;
    }
    
    if ( game[ #"levelcache" ].var_3065ba48bd1dbc8b )
    {
        level.var_3065ba48bd1dbc8b = game[ #"levelcache" ].var_3065ba48bd1dbc8b;
        level.var_50a5e0fcbd8dd0cd = game[ #"levelcache" ].var_50a5e0fcbd8dd0cd;
        level.var_7fc60b1844c1bd02 = game[ #"levelcache" ].var_7fc60b1844c1bd02;
        level.var_3fa050bba2b354f3 = game[ #"levelcache" ].var_3fa050bba2b354f3;
        level.var_6711a0b7fbe2f709 = game[ #"levelcache" ].var_6711a0b7fbe2f709;
        level.var_f6fe8b5140cfc6c8 = game[ #"levelcache" ].var_f6fe8b5140cfc6c8;
        level.var_4e24a9bb3702a598 = game[ #"levelcache" ].var_4e24a9bb3702a598;
        level.var_d2392dd52d6cfe8a = game[ #"levelcache" ].var_d2392dd52d6cfe8a;
        return;
    }
    
    level.var_3065ba48bd1dbc8b = [];
    level.var_50a5e0fcbd8dd0cd = [];
    level.var_7fc60b1844c1bd02 = [];
    level.var_3fa050bba2b354f3 = [];
    level.var_6711a0b7fbe2f709 = [];
    level.var_f6fe8b5140cfc6c8 = [];
    level.var_4e24a9bb3702a598 = [];
    level.var_d2392dd52d6cfe8a = [];
    
    /#
        if ( getdvarint( @"hash_e6afce2cf5cf7515", 0 ) == 1 )
        {
            return;
        }
        
        if ( getdvarint( @"hash_742caa13b3c2e685" ) == 1 )
        {
            return;
        }
    #/
    
    projectscriptbundle = getprojectscriptbundle();
    var_f81b14df18e3047c = getscriptbundle( hashcat( %"hash_1fa266a862bf9762", projectscriptbundle.aeeventlist ) );
    var_cf8292de50088e35 = getscriptbundle( hashcat( %"hash_65c0e77ca29a053d", projectscriptbundle.var_260ed6883cd7e5d5 ) );
    
    /#
        assetmissing = 0;
        
        if ( !isdefined( var_f81b14df18e3047c ) )
        {
            println( "<dev string:x24>" + projectscriptbundle.aeeventlist );
            assetmissing = 1;
        }
        
        if ( !isdefined( var_cf8292de50088e35 ) )
        {
            println( "<dev string:x4e>" + projectscriptbundle.var_260ed6883cd7e5d5 );
            assetmissing = 1;
        }
        
        if ( assetmissing )
        {
            return;
        }
    #/
    
    eventlist = var_f81b14df18e3047c.eventlist;
    enumlist = var_cf8292de50088e35.enumlist;
    
    for ( i = 0; i < eventlist.size ; i++ )
    {
        if ( !isdefined( eventlist[ i ].event ) )
        {
            println( "<dev string:x77>" + i + "<dev string:xa4>" );
            continue;
        }
        
        var_afe7faece24c4e0c = getscriptbundle( hashcat( %"hash_6dd4e4d4a6505f3a", eventlist[ i ].event ) );
        
        /#
            if ( !isdefined( var_afe7faece24c4e0c ) )
            {
                println( "<dev string:xa6>" + projectscriptbundle.aeeventlist + "<dev string:xda>" + eventlist[ i ].event );
                continue;
            }
        #/
        
        if ( var_afe7faece24c4e0c.source == "server" )
        {
            level.var_3065ba48bd1dbc8b[ var_afe7faece24c4e0c.sharedname ] = string( var_afe7faece24c4e0c.id );
            level.var_50a5e0fcbd8dd0cd[ var_afe7faece24c4e0c.sharedname ] = [];
            eventkeys = var_afe7faece24c4e0c.keys;
            
            for ( j = 0; j < eventkeys.size ; j++ )
            {
                if ( eventkeys[ j ] && isdefined( eventkeys[ j ].key ) )
                {
                    var_6958348e4a9434b5 = getscriptbundle( hashcat( %"hash_683f777d2122709b", eventkeys[ j ].key ) );
                    
                    if ( !isdefined( var_6958348e4a9434b5 ) )
                    {
                        continue;
                    }
                    
                    var_5d9034986afa6b29 = var_6958348e4a9434b5.sharedname;
                    level.var_50a5e0fcbd8dd0cd[ var_afe7faece24c4e0c.sharedname ][ level.var_50a5e0fcbd8dd0cd[ var_afe7faece24c4e0c.sharedname ].size ] = var_5d9034986afa6b29;
                    
                    if ( var_6958348e4a9434b5.var_26f5fdf765e0a506 && !isdefined( level.var_3fa050bba2b354f3[ var_5d9034986afa6b29 ] ) )
                    {
                        level.var_3fa050bba2b354f3[ var_5d9034986afa6b29 ] = var_6958348e4a9434b5.id;
                    }
                    
                    if ( !isdefined( level.var_7fc60b1844c1bd02[ var_5d9034986afa6b29 ] ) )
                    {
                        level.var_7fc60b1844c1bd02[ var_5d9034986afa6b29 ] = var_6958348e4a9434b5.id;
                    }
                    
                    if ( isdefined( var_6958348e4a9434b5.bitfield ) && var_6958348e4a9434b5.bitfield.size > 0 )
                    {
                        level.var_6711a0b7fbe2f709[ var_5d9034986afa6b29 ] = [];
                        
                        for ( k = 0; k < var_6958348e4a9434b5.bitfield.size ; k++ )
                        {
                            bitname = var_6958348e4a9434b5.bitfield[ k ].sharedname;
                            level.var_6711a0b7fbe2f709[ var_5d9034986afa6b29 ][ bitname ] = var_6958348e4a9434b5.bitfield[ k ].bitindex;
                        }
                    }
                }
            }
        }
    }
    
    for ( i = 0; i < enumlist.size ; i++ )
    {
        if ( !isdefined( enumlist[ i ].enum ) )
        {
            println( "<dev string:xdd>" + i + "<dev string:xa4>" );
            continue;
        }
        
        var_e539c5be360a79d7 = getscriptbundle( hashcat( %"hash_56154d39395feb69", enumlist[ i ].enum ) );
        
        /#
            if ( !isdefined( var_e539c5be360a79d7 ) )
            {
                println( "<dev string:x108>" + projectscriptbundle.var_260ed6883cd7e5d5 + "<dev string:xda>" + enumlist[ i ].enum );
                continue;
            }
        #/
        
        level.var_f6fe8b5140cfc6c8[ var_e539c5be360a79d7.sharedname ] = [];
        elements = var_e539c5be360a79d7.elements;
        
        for ( j = 0; j < elements.size ; j++ )
        {
            element = elements[ j ];
            var_eab13db16a8462bc = element.sharedname;
            level.var_f6fe8b5140cfc6c8[ var_e539c5be360a79d7.sharedname ][ var_eab13db16a8462bc ] = element.id;
        }
    }
    
    if ( !isdefined( game[ #"levelcache" ] ) )
    {
        game[ #"levelcache" ] = {};
    }
    
    game[ #"levelcache" ].var_3065ba48bd1dbc8b = level.var_3065ba48bd1dbc8b;
    game[ #"levelcache" ].var_50a5e0fcbd8dd0cd = level.var_50a5e0fcbd8dd0cd;
    game[ #"levelcache" ].var_7fc60b1844c1bd02 = level.var_7fc60b1844c1bd02;
    game[ #"levelcache" ].var_3fa050bba2b354f3 = level.var_3fa050bba2b354f3;
    game[ #"levelcache" ].var_6711a0b7fbe2f709 = level.var_6711a0b7fbe2f709;
    game[ #"levelcache" ].var_f6fe8b5140cfc6c8 = level.var_f6fe8b5140cfc6c8;
    game[ #"levelcache" ].var_4e24a9bb3702a598 = level.var_4e24a9bb3702a598;
    game[ #"levelcache" ].var_d2392dd52d6cfe8a = level.var_d2392dd52d6cfe8a;
}

// Namespace ae_utility
// Params 1, eflags: 0x4
// Checksum 0xd55aa209, Offset: 0x7dd
// Size: 0x64
function private function_553cd04c1d393940( keyname )
{
    assert( isxhash( keyname ) );
    
    if ( !isdefined( level.var_3065ba48bd1dbc8b ) )
    {
        function_1ed5797f0c5d2d2f();
    }
    
    var_7237854e3be197ca = level.var_7fc60b1844c1bd02[ keyname ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    println( "<dev string:x13b>" + getxhashsourcename( keyname ) );
}

// Namespace ae_utility
// Params 1, eflags: 0x4
// Checksum 0x8838c1de, Offset: 0x84a
// Size: 0x4f
function private function_ab91ea3a06e49191( eventname )
{
    assert( isxhash( eventname ) );
    var_7237854e3be197ca = level.var_50a5e0fcbd8dd0cd[ eventname ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    println( "<dev string:x15e>" + getxhashsourcename( eventname ) );
}

// Namespace ae_utility
// Params 2
// Checksum 0x8cf8743d, Offset: 0x8a2
// Size: 0xae
function function_4b9f0ca95497e0c8( eventname, keyname )
{
    assert( isxhash( eventname ) );
    assert( isxhash( keyname ) );
    var_7237854e3be197ca = level.var_d2392dd52d6cfe8a[ eventname ][ keyname ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( !isdefined( level.var_d2392dd52d6cfe8a[ eventname ] ) )
    {
        level.var_d2392dd52d6cfe8a[ eventname ] = [];
    }
    
    var_410eef9d06f03c3f = function_ab91ea3a06e49191( eventname );
    level.var_d2392dd52d6cfe8a[ eventname ][ keyname ] = isdefined( var_410eef9d06f03c3f ) && arraycontains( var_410eef9d06f03c3f, keyname );
    return level.var_d2392dd52d6cfe8a[ eventname ][ keyname ];
}

// Namespace ae_utility
// Params 1
// Checksum 0xf9d7142b, Offset: 0x959
// Size: 0x7b
function function_8645a430dc4bffb9( eventname )
{
    var_7237854e3be197ca = level.var_3065ba48bd1dbc8b[ eventname ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( !isdefined( level.var_3065ba48bd1dbc8b ) )
    {
        function_1ed5797f0c5d2d2f();
    }
    
    var_7237854e3be197ca = level.var_3065ba48bd1dbc8b[ eventname ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    assert( isxhash( eventname ) );
    println( "<dev string:x15e>" + getxhashsourcename( eventname ) );
}

// Namespace ae_utility
// Params 2
// Checksum 0x175d705, Offset: 0x9dd
// Size: 0x11e
function function_70b8bc68f3d8031e( eventname, keyname )
{
    var_7237854e3be197ca = level.var_4e24a9bb3702a598[ eventname ][ keyname ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( !isdefined( level.var_3065ba48bd1dbc8b ) )
    {
        function_1ed5797f0c5d2d2f();
    }
    
    var_7237854e3be197ca = level.var_4e24a9bb3702a598[ eventname ][ keyname ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    assert( isxhash( eventname ) );
    assert( isxhash( keyname ) );
    keyid = 65535;
    
    if ( function_4b9f0ca95497e0c8( eventname, keyname ) )
    {
        if ( !isdefined( level.var_4e24a9bb3702a598[ eventname ] ) )
        {
            level.var_4e24a9bb3702a598[ eventname ] = [];
        }
        
        keyid = function_553cd04c1d393940( keyname ) ?? keyid;
        level.var_4e24a9bb3702a598[ eventname ][ keyname ] = keyid;
    }
    else
    {
        assertmsg( "<dev string:x183>" + getxhashsourcename( keyname ) + "<dev string:x195>" + getxhashsourcename( eventname ) );
        println( "<dev string:x183>" + getxhashsourcename( keyname ) + "<dev string:x195>" + getxhashsourcename( eventname ) );
    }
    
    return keyid;
}

// Namespace ae_utility
// Params 1
// Checksum 0xfb2a755b, Offset: 0xb04
// Size: 0xaa
function function_85018ebf5b896513( keyname )
{
    var_7237854e3be197ca = level.var_3fa050bba2b354f3[ keyname ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( !isdefined( level.var_3065ba48bd1dbc8b ) )
    {
        function_1ed5797f0c5d2d2f();
    }
    
    var_7237854e3be197ca = level.var_3fa050bba2b354f3[ keyname ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    assert( isxhash( keyname ) );
    keyid = 65535;
    assertmsg( "<dev string:x183>" + getxhashsourcename( keyname ) + "<dev string:x1ad>" );
    println( "<dev string:x183>" + getxhashsourcename( keyname ) + "<dev string:x1ad>" );
    return keyid;
}

// Namespace ae_utility
// Params 2
// Checksum 0x10819545, Offset: 0xbb7
// Size: 0xe1
function function_2d1565a236387b2( keyname, bitname )
{
    var_7237854e3be197ca = level.var_6711a0b7fbe2f709[ keyname ][ bitname ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( !isdefined( level.var_3065ba48bd1dbc8b ) )
    {
        function_1ed5797f0c5d2d2f();
    }
    
    var_7237854e3be197ca = level.var_6711a0b7fbe2f709[ keyname ][ bitname ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    assert( isxhash( keyname ) );
    assert( isxhash( bitname ) );
    
    /#
        if ( !isdefined( level.var_6711a0b7fbe2f709[ keyname ] ) )
        {
            println( "<dev string:x183>" + getxhashsourcename( keyname ) + "<dev string:x1cd>" );
            return;
        }
        
        if ( !isdefined( level.var_6711a0b7fbe2f709[ keyname ][ bitname ] ) )
        {
            println( "<dev string:x1e0>" + getxhashsourcename( bitname ) + "<dev string:x1f2>" + getxhashsourcename( keyname ) );
        }
    #/
}

// Namespace ae_utility
// Params 2
// Checksum 0xc3df371a, Offset: 0xca1
// Size: 0x4e, Type: bool
function function_545a7a23289934e6( keyname, bitname )
{
    if ( isdefined( level.var_6711a0b7fbe2f709[ keyname ][ bitname ] ) )
    {
        return true;
    }
    
    if ( !isdefined( level.var_3065ba48bd1dbc8b ) )
    {
        function_1ed5797f0c5d2d2f();
    }
    
    return isdefined( level.var_6711a0b7fbe2f709[ keyname ][ bitname ] );
}

// Namespace ae_utility
// Params 4
// Checksum 0xbe1bdad3, Offset: 0xcf8
// Size: 0x98
function function_a05c01f371158a1b( eventparams, eventname, keyname, value )
{
    assert( isxhash( eventname ) );
    assert( isxhash( keyname ) );
    keyid = function_70b8bc68f3d8031e( eventname, keyname );
    
    if ( isdefined( keyid ) )
    {
        eventparams[ keyid ] = int( value );
    }
    else
    {
        println( "<dev string:x208>" + getxhashsourcename( keyname ) + "<dev string:x221>" + value + "<dev string:x224>" + getxhashsourcename( eventname ) );
    }
    
    return eventparams;
}

// Namespace ae_utility
// Params 2
// Checksum 0xd76c0691, Offset: 0xd99
// Size: 0xc2
function function_14b0b5e8696534b6( enumname, elementname )
{
    assert( isxhash( enumname ) );
    assert( isxhash( elementname ) );
    
    if ( !isdefined( level.var_3065ba48bd1dbc8b ) )
    {
        function_1ed5797f0c5d2d2f();
    }
    
    var_7237854e3be197ca = level.var_f6fe8b5140cfc6c8[ enumname ][ elementname ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    /#
        if ( !isdefined( level.var_f6fe8b5140cfc6c8[ enumname ] ) )
        {
            println( "<dev string:x233>" + getxhashsourcename( enumname ) );
            return;
        }
        
        if ( !isdefined( level.var_f6fe8b5140cfc6c8[ enumname ][ elementname ] ) )
        {
            println( "<dev string:x24e>" + getxhashsourcename( elementname ) + "<dev string:x261>" + getxhashsourcename( enumname ) );
        }
    #/
}

// Namespace ae_utility
// Params 1
// Checksum 0xb810a4b3, Offset: 0xe64
// Size: 0x74
function function_357622cc2d8da787( stringref )
{
    if ( isxhash( stringref ) )
    {
        var_55bf42a502a2faad = function_14b0b5e8696534b6( #"stringref", stringref );
    }
    else
    {
        var_55bf42a502a2faad = function_14b0b5e8696534b6( #"stringref", hashcat( #"hash_d13ae7e55732168f", stringref ) );
    }
    
    /#
        if ( !isdefined( var_55bf42a502a2faad ) )
        {
            println( "<dev string:x27f>" + stringref + "<dev string:x29f>" );
        }
    #/
    
    return var_55bf42a502a2faad;
}

