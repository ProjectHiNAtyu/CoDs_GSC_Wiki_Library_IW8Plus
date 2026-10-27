// script_171e4f4a4ea34c0  (hash_0171e4f4a4ea34c0.gscc) (size: 3082 Bytes / 0xc0a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc89cc303 (3365716739)
// size ...... 3082 (0xc0a)
// includes .. 1   (offset: 0xb26)
// strings ... 18  (offset: 0xb2e)
// dev strs .. 0   (offset: 0xc0a)
// exports ... 11  (offset: 0x7d2)
// cseg ...... 0x30e + 0x4c4 (0x7d2)
// imports ... 10  (offset: 0x98a)
// animtree1 . 0   (offset: 0xc0a)
// animtree2 . 0   (offset: 0xc0a)
#using scripts\autotests\autotests;

#namespace gscunittest_undefined_struct_array_object;

// Namespace gscunittest_undefined_struct_array_object
// Params 0
// Checksum 0x3ec87157, Offset: 0x32c
// Size: 0x3b
function main()
{
    if ( getdvarint( @"scr_unittest_undefined", 0 ) == 0 )
    {
        return;
    }
    
    function_b8a21478634d956e();
    
    if ( getdvarint( @"scr_unittest_undefined", 0 ) > 1 )
    {
        function_7b4af50274f4d644();
    }
}

// Namespace gscunittest_undefined_struct_array_object
// Params 0, eflags: 0x4
// Checksum 0xeb85422d, Offset: 0x36f
// Size: 0x17
function private function_b8a21478634d956e()
{
    function_27df804d25b97aa2();
    function_99d12a17e657d05c();
    function_c841c48c86d9e9a2();
}

// Namespace gscunittest_undefined_struct_array_object
// Params 1, eflags: 0x4
// Checksum 0x284abfc3, Offset: 0x38e
// Size: 0x1d
function private failed( test_name )
{
    autotests::function_d84657f448aaeef6( test_name, 0, "scripts/autotests/gscunittest/test_gscunittest_undefined_struct_array_object.gsc", 41 );
}

// Namespace gscunittest_undefined_struct_array_object
// Params 1, eflags: 0x4
// Checksum 0xd51b0df4, Offset: 0x3b3
// Size: 0x1e
function private passed( test_name )
{
    autotests::function_d84657f448aaeef6( test_name, 1, "scripts/autotests/gscunittest/test_gscunittest_undefined_struct_array_object.gsc", 47 );
}

// Namespace gscunittest_undefined_struct_array_object
// Params 0, eflags: 0x4
// Checksum 0xfc1fd565, Offset: 0x3d9
// Size: 0xc7
function private function_27df804d25b97aa2()
{
    no_array = undefined;
    some_var = 2020;
    test_name = "no array, some var";
    
    if ( isdefined( no_array[ some_var ] ) )
    {
        failed( test_name );
    }
    else
    {
        passed( test_name );
    }
    
    test_name = "level no array, some var";
    
    if ( isdefined( level.no_array[ some_var ] ) )
    {
        failed( test_name );
    }
    else
    {
        passed( test_name );
    }
    
    some_var = undefined;
    test_name = "no array, some var undefined";
    
    if ( isdefined( no_array[ some_var ] ) )
    {
        failed( test_name );
    }
    else
    {
        passed( test_name );
    }
    
    test_name = "level no array, some var undefined";
    
    if ( isdefined( level.no_array[ some_var ] ) )
    {
        failed( test_name );
        return;
    }
    
    passed( test_name );
}

// Namespace gscunittest_undefined_struct_array_object
// Params 0, eflags: 0x4
// Checksum 0xf685c52f, Offset: 0x4a8
// Size: 0xde
function private function_99d12a17e657d05c()
{
    no_struct = undefined;
    test_name = "no struct, some var";
    
    if ( isdefined( no_struct.some_var ) )
    {
        failed( test_name );
    }
    else
    {
        passed( test_name );
    }
    
    test_name = "level no struct, some var";
    
    if ( isdefined( level.no_struct.some_var ) )
    {
        failed( test_name );
    }
    else
    {
        passed( test_name );
    }
    
    some_var = undefined;
    test_name = "no struct, some var undefined";
    
    if ( isdefined( no_struct.some_var ) )
    {
        failed( test_name );
    }
    else
    {
        passed( test_name );
    }
    
    test_name = "level no struct, some var undefined";
    
    if ( isdefined( level.no_struct.some_var ) )
    {
        failed( test_name );
        return;
    }
    
    passed( test_name );
}

// Namespace gscunittest_undefined_struct_array_object
// Params 0, eflags: 0x4
// Checksum 0xc43601a, Offset: 0x58e
// Size: 0x1e4
function private function_c841c48c86d9e9a2()
{
    if ( !isdefined( level.players[ 0 ] ) )
    {
        failed( "cannot run undefined object test; run again when player is spawned" );
    }
    
    player = level.players[ 0 ];
    some_var = 2020;
    test_name = "player, no struct, some var";
    
    if ( isdefined( player.no_struct.some_var ) )
    {
        failed( test_name );
    }
    else
    {
        passed( test_name );
    }
    
    test_name = "player, no array, some var";
    
    if ( isdefined( player.no_array[ some_var ] ) )
    {
        failed( test_name );
    }
    else
    {
        passed( test_name );
    }
    
    some_var = undefined;
    test_name = "player, no struct, some var undefined";
    
    if ( isdefined( player.no_struct.some_var ) )
    {
        failed( test_name );
    }
    else
    {
        passed( test_name );
    }
    
    test_name = "player, no array, some var undefined";
    
    if ( isdefined( player.no_array[ some_var ] ) )
    {
        failed( test_name );
    }
    else
    {
        passed( test_name );
    }
    
    player = undefined;
    some_var = 2020;
    test_name = "no player, no struct, some var";
    
    if ( isdefined( player.no_struct.some_var ) )
    {
        failed( test_name );
    }
    else
    {
        passed( test_name );
    }
    
    test_name = "no player, no array, some var";
    
    if ( isdefined( player.no_array[ some_var ] ) )
    {
        failed( test_name );
    }
    else
    {
        passed( test_name );
    }
    
    some_var = undefined;
    test_name = "no player, no struct, some var undefined";
    
    if ( isdefined( player.no_struct.some_var ) )
    {
        failed( test_name );
    }
    else
    {
        passed( test_name );
    }
    
    test_name = "no player, no array, some var undefined";
    
    if ( isdefined( player.no_array[ some_var ] ) )
    {
        failed( test_name );
        return;
    }
    
    passed( test_name );
}

// Namespace gscunittest_undefined_struct_array_object
// Params 0, eflags: 0x4
// Checksum 0xd498b571, Offset: 0x77a
// Size: 0x20
function private function_a6bc820cc006089a()
{
    some_local_array[ 0 ] = 100;
    level.var_a456bde87d71ed35[ 0 ] = 100;
}

// Namespace gscunittest_undefined_struct_array_object
// Params 0, eflags: 0x4
// Checksum 0x366936fb, Offset: 0x7a2
// Size: 0x9
function private function_7b4af50274f4d644()
{
    function_533e7a6484071f20();
}

// Namespace gscunittest_undefined_struct_array_object
// Params 0, eflags: 0x4
// Checksum 0xcf203e28, Offset: 0x7b3
// Size: 0x1f
function private function_533e7a6484071f20()
{
    some_object = undefined;
    some_object.some_array[ 0 ] = 100;
}

