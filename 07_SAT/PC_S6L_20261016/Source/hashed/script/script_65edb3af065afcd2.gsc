// script_65edb3af065afcd2  (hash_65edb3af065afcd2.gscc) (size: 3730 Bytes / 0xe92)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8c618fa5 (2355204005)
// size ...... 3730 (0xe92)
// includes .. 1   (offset: 0xcf6)
// strings ... 29  (offset: 0xcfe)
// dev strs .. 0   (offset: 0xe92)
// exports ... 13  (offset: 0x8ce)
// cseg ...... 0x3f2 + 0x4dc (0x8ce)
// imports ... 16  (offset: 0xad6)
// animtree1 . 0   (offset: 0xe92)
// animtree2 . 0   (offset: 0xe92)
#using script_3f182ddb21e37fd3;

#namespace namespace_e30ef3357d6636b;

// Namespace namespace_e30ef3357d6636b/testautomation
// Params 0, eflags: 0x20
// Checksum 0x523baea6, Offset: 0x410
// Size: 0xf4
function event_handler[testautomation] main()
{
    namespace_3637061638c5e37a::function_6b8b68fa6ee6a023( "testargsloop", &function_b3b21e40a0c4a341, "test" );
    namespace_3637061638c5e37a::function_6b8b68fa6ee6a023( "testemptyreturn", &function_5763dcad5cae58ef, "test" );
    namespace_3637061638c5e37a::function_6b8b68fa6ee6a023( "testreturnemptystring", &function_eb15e67042f945c1, "test" );
    namespace_3637061638c5e37a::function_6b8b68fa6ee6a023( "testnoparams", &function_6f77323361c8cd1b, "test" );
    namespace_3637061638c5e37a::function_6b8b68fa6ee6a023( "testreturntype", &test_return_type, "test" );
    namespace_3637061638c5e37a::function_6b8b68fa6ee6a023( "testwait", &test_wait, "test" );
    namespace_3637061638c5e37a::function_6b8b68fa6ee6a023( "testreturnerror", &function_7a5d2ecb8080ce74, "test" );
    namespace_3637061638c5e37a::function_6b8b68fa6ee6a023( "testreturnresultanderror", &test_return_result_and_error, "test" );
    namespace_3637061638c5e37a::function_6b8b68fa6ee6a023( "testreturnarray", &test_return_array, "test" );
    namespace_3637061638c5e37a::function_6b8b68fa6ee6a023( "testhelloworldhashedstring", &function_ee0379b2327257b2, "test" );
    namespace_3637061638c5e37a::function_6b8b68fa6ee6a023( "testunattendedhasheddvar", &function_9d542ed965bb1f01, "test" );
}

// Namespace namespace_e30ef3357d6636b
// Params 1, eflags: 0x4
// Checksum 0x6fd074d4, Offset: 0x50c
// Size: 0xe
function private function_b3b21e40a0c4a341( params )
{
    return params;
}

// Namespace namespace_e30ef3357d6636b
// Params 1, eflags: 0x4
// Checksum 0x8f2211f6, Offset: 0x523
// Size: 0xc
function private function_5763dcad5cae58ef( params )
{
    
}

// Namespace namespace_e30ef3357d6636b
// Params 1, eflags: 0x4
// Checksum 0x2b924222, Offset: 0x538
// Size: 0x11
function private function_eb15e67042f945c1( params )
{
    return "";
}

// Namespace namespace_e30ef3357d6636b
// Params 0, eflags: 0x4
// Checksum 0x96777741, Offset: 0x552
// Size: 0x7
function private function_6f77323361c8cd1b()
{
    return "no_args_function_return_value";
}

// Namespace namespace_e30ef3357d6636b
// Params 0, eflags: 0x4
// Checksum 0x32ff10ae, Offset: 0x562
// Size: 0xf
function private function_7a5d2ecb8080ce74()
{
    return namespace_3637061638c5e37a::function_8ecfff37b1877ba2( 17, "error message" );
}

// Namespace namespace_e30ef3357d6636b
// Params 0, eflags: 0x4
// Checksum 0x732aefdd, Offset: 0x57a
// Size: 0x90
function private test_return_result_and_error()
{
    res = namespace_3637061638c5e37a::function_8ecfff37b1877ba2( 23, "The error message from test_return_result_and_error" );
    res.intfield = 1;
    res.stringfield = "stringval";
    res.var_42b6ea2766862e06 = "";
    res.floatfield = 1.5;
    res.arrayfield = [ 1, "str", 1.5 ];
    res.var_f1ba8005fd224ae8 = [];
    return res;
}

// Namespace namespace_e30ef3357d6636b
// Params 0, eflags: 0x4
// Checksum 0xa67e917d, Offset: 0x613
// Size: 0x87
function private test_return_array()
{
    res = spawnstruct();
    res.intfield = 1;
    res.stringfield = "stringval";
    res.var_42b6ea2766862e06 = "";
    res.floatfield = 1.5;
    res.arrayfield = [ 1, "str", 1.5 ];
    res.var_f1ba8005fd224ae8 = [];
    return res;
}

// Namespace namespace_e30ef3357d6636b
// Params 1, eflags: 0x4
// Checksum 0x6a4e31ba, Offset: 0x6a3
// Size: 0x26
function private test_return_type( params )
{
    if ( params.return_value )
    {
        return params.return_value;
    }
}

// Namespace namespace_e30ef3357d6636b
// Params 1, eflags: 0x4
// Checksum 0x338d265e, Offset: 0x6d2
// Size: 0x3f
function private test_wait( params )
{
    if ( params.delay )
    {
        wait params.delay;
        return params.delay;
    }
    
    return namespace_3637061638c5e37a::function_8ecfff37b1877ba2( 40, "Test wait called without delay parameter" );
}

// Namespace namespace_e30ef3357d6636b
// Params 1, eflags: 0x4
// Checksum 0xea43b46d, Offset: 0x71a
// Size: 0xd5
function private function_ee0379b2327257b2( params )
{
    if ( isxhash( params.clear ) )
    {
        return namespace_3637061638c5e37a::function_8ecfff37b1877ba2( 42, "Parameter 'clear' is not supposed to be an XHash" );
    }
    
    if ( params.clear != "hello_world" )
    {
        return namespace_3637061638c5e37a::function_8ecfff37b1877ba2( 42, "Parameter 'clear' is supposed to be equal to 'hello_world'" );
    }
    
    if ( !isxhash( params.hashed ) )
    {
        return namespace_3637061638c5e37a::function_8ecfff37b1877ba2( 42, "Parameter 'hashed' is supposed to be an XHash" );
    }
    
    if ( params.hashed != #"hello_world" )
    {
        return namespace_3637061638c5e37a::function_8ecfff37b1877ba2( 42, "Parameter 'hashed' is supposed to be equal to #x'hello_world'" );
    }
    
    res = spawnstruct();
    res.clear = params.clear;
    res.hashed = params.hashed;
    return res;
}

// Namespace namespace_e30ef3357d6636b
// Params 1, eflags: 0x4
// Checksum 0x1839be03, Offset: 0x7f8
// Size: 0xd5
function private function_9d542ed965bb1f01( params )
{
    if ( isxhashdvar( params.clear_dvar ) )
    {
        return namespace_3637061638c5e37a::function_8ecfff37b1877ba2( 42, "Parameter 'clear_dvar' is not supposed to be an XHashDvar" );
    }
    
    if ( params.clear_dvar != "unattended" )
    {
        return namespace_3637061638c5e37a::function_8ecfff37b1877ba2( 42, "Parameter 'clear_dvar' is supposed to be equal to 'unattended'" );
    }
    
    if ( !isxhashdvar( params.hashed_dvar ) )
    {
        return namespace_3637061638c5e37a::function_8ecfff37b1877ba2( 42, "Parameter 'hashed_dvar' is supposed to be an XHashDvar" );
    }
    
    if ( params.hashed_dvar != @"unattended" )
    {
        return namespace_3637061638c5e37a::function_8ecfff37b1877ba2( 42, "Parameter 'hashed_dvar' is supposed to be equal to #d'unattended'" );
    }
    
    res = spawnstruct();
    res.clear_dvar = params.clear_dvar;
    res.hashed_dvar = params.hashed_dvar;
    return res;
}

