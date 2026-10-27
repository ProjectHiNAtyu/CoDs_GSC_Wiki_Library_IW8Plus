// script_709f5f888cd7904d  (hash_709f5f888cd7904d.gscc) (size: 2022 Bytes / 0x7e6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6f4fa907 (1867491591)
// size ...... 2022 (0x7e6)
// includes .. 3   (offset: 0x6e6)
// strings ... 10  (offset: 0x6fe)
// dev strs .. 7   (offset: 0x782)
// exports ... 6   (offset: 0x3ce)
// cseg ...... 0xe8 + 0x2e6 (0x3ce)
// imports ... 19  (offset: 0x4be)
// animtree1 . 0   (offset: 0x7e6)
// animtree2 . 0   (offset: 0x7e6)
#using script_44280f644740bac;
#using scripts\common\utility;
#using scripts\mp\flags;

#namespace namespace_9802b2422c258ec9;

// Namespace namespace_9802b2422c258ec9
// Params 0
// Checksum 0xb751445a, Offset: 0x106
// Size: 0x6c
function main()
{
    level thread function_1c462a1a6b061861();
    
    /#
        namespace_ec33f26de741e14e::function_5a52677cbdd3e5e5( "<dev string:x24>" );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x2d>", "<dev string:x24>", &function_ed09412acbffc1a, "<dev string:x41>", "<dev string:x6d>", undefined );
        namespace_ec33f26de741e14e::registercommand( "<dev string:x73>", "<dev string:x24>", &function_ebec8ae49540db47, "<dev string:x8e>", "<dev string:x6d>", undefined );
        namespace_ec33f26de741e14e::function_67acbc0c7e614803( "<dev string:xaf>", "<dev string:x24>" );
    #/
}

// Namespace namespace_9802b2422c258ec9
// Params 0, eflags: 0x4
// Checksum 0x9c0e265a, Offset: 0x17a
// Size: 0x125
function private function_1c462a1a6b061861()
{
    level endon( #"game_ended", #"hash_8bbb24e28a960e41" );
    utility::flag_wait( "scriptables_ready" );
    var_16180d6ee2b7006f = getscriptablearray( "solar_panel", "script_noteworthy" );
    
    if ( var_16180d6ee2b7006f.size == 0 )
    {
        return;
    }
    
    var_2ab4ca8df91e8e39 = [];
    
    foreach ( var_420b16d686a0580e in var_16180d6ee2b7006f )
    {
        var_420b16d686a0580e setscriptablepartstate( "base", "idle" );
        var_2ab4ca8df91e8e39[ int( var_420b16d686a0580e.targetname ) ] = var_420b16d686a0580e;
    }
    
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    
    for ( i = 0; i < var_2ab4ca8df91e8e39.size ; i++ )
    {
        var_2ab4ca8df91e8e39[ i ] setscriptablepartstate( "base", "activate" );
        wait 1.1;
    }
    
    level thread function_57c49258c8998ebd( var_2ab4ca8df91e8e39 );
}

// Namespace namespace_9802b2422c258ec9
// Params 1, eflags: 0x4
// Checksum 0x43e7b8b8, Offset: 0x2a7
// Size: 0xc7
function private function_57c49258c8998ebd( var_2ab4ca8df91e8e39 )
{
    level endon( #"game_ended", #"hash_8bbb24e28a960e41" );
    var_cedef5f923c05e2a = randomintrange( 20, 25 );
    level utility::waittill_any_timeout( var_cedef5f923c05e2a, "skip_to_adjust" );
    var_d87c8849a04a4d4b = randomintrange( 2, var_2ab4ca8df91e8e39.size );
    var_4fb504457be45931 = arrayrandomize( var_2ab4ca8df91e8e39 );
    
    for ( i = 0; i <= var_d87c8849a04a4d4b ; i++ )
    {
        var_4fb504457be45931[ i ] setscriptablepartstate( "base", "transition" );
        waitframe();
        var_4fb504457be45931[ i ] setscriptablepartstate( "base", "adjust" );
        var_450317893c29969b = randomfloatrange( 0.7, 5 );
        wait var_450317893c29969b;
    }
    
    thread function_57c49258c8998ebd( var_2ab4ca8df91e8e39 );
}

/#

    // Namespace namespace_9802b2422c258ec9
    // Params 2, eflags: 0x4
    // Checksum 0x33340f00, Offset: 0x376
    // Size: 0x2c, Type: dev
    function private function_ed09412acbffc1a( host, args )
    {
        level notify( #"hash_8bbb24e28a960e41" );
        level thread function_1c462a1a6b061861();
    }

    // Namespace namespace_9802b2422c258ec9
    // Params 2, eflags: 0x4
    // Checksum 0x34ef2bc4, Offset: 0x3aa
    // Size: 0x24, Type: dev
    function private function_ebec8ae49540db47( host, args )
    {
        level notify( #"skip_to_adjust" );
    }

#/
