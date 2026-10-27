// script_41e73c1fdc7f422a  (hash_41e73c1fdc7f422a.gscc) (size: 1485 Bytes / 0x5cd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x304ec1e6 (810467814)
// size ...... 1485 (0x5cd)
// includes .. 3   (offset: 0x53d)
// strings ... 2   (offset: 0x555)
// dev strs .. 8   (offset: 0x56d)
// exports ... 9   (offset: 0x22d)
// cseg ...... 0x74 + 0x1b9 (0x22d)
// imports ... 15  (offset: 0x395)
// animtree1 . 0   (offset: 0x5cd)
// animtree2 . 0   (offset: 0x5cd)
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\devgui;

#namespace namespace_896b586af011dc97;

/#

    // Namespace namespace_896b586af011dc97
    // Params 0
    // Checksum 0xb426f13b, Offset: 0x92
    // Size: 0xc, Type: dev
    function function_854c976a13f0454a()
    {
        function_5c66b6cd4c72ac03();
    }

#/

// Namespace namespace_896b586af011dc97
// Params 0
// Checksum 0x82f90083, Offset: 0xa6
// Size: 0x23
function function_70cf8f67298d0e72()
{
    asm::function_7256f5ba459c840b( "roar_in" );
    self function_786bb6aa1b76c7ee( "roar_end_time", 2000 );
    thread manage_roar();
}

// Namespace namespace_896b586af011dc97
// Params 0, eflags: 0x4
// Checksum 0x142d8577, Offset: 0xd1
// Size: 0x1a
function private manage_roar()
{
    self endon( #"death" );
    self endon( #"roar_end" );
}

/#

    // Namespace namespace_896b586af011dc97
    // Params 0, eflags: 0x4
    // Checksum 0x3936a938, Offset: 0xf3
    // Size: 0x44, Type: dev
    function private function_5c66b6cd4c72ac03()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3c>", "<dev string:x47>", &function_6167bd4dd082d22 );
        devgui::add_devgui_func( "<dev string:x59>", "<dev string:x64>", &toggle_debug_roar );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_896b586af011dc97
    // Params 1, eflags: 0x4
    // Checksum 0x72d15e2, Offset: 0x13f
    // Size: 0x4b, Type: dev
    function private function_6167bd4dd082d22( params )
    {
        phobos = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x76>" );
        
        if ( isdefined( phobos ) )
        {
            phobos function_70cf8f67298d0e72();
        }
    }

    // Namespace namespace_896b586af011dc97
    // Params 0, eflags: 0x4
    // Checksum 0x18c2d941, Offset: 0x192
    // Size: 0x1a, Type: dev
    function private toggle_debug_roar()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x84>", @"phobos_roar_debug" );
    }

    // Namespace namespace_896b586af011dc97
    // Params 0, eflags: 0x4
    // Checksum 0x73403269, Offset: 0x1b4
    // Size: 0x16, Type: dev
    function private debug_roar()
    {
        return getdvarint( @"phobos_roar_debug", 0 ) > 0;
    }

    // Namespace namespace_896b586af011dc97
    // Params 2, eflags: 0x4
    // Checksum 0xe38e007, Offset: 0x1d2
    // Size: 0x5b, Type: dev
    function private roar_print( text, pos )
    {
        if ( debug_roar() )
        {
            if ( !isdefined( pos ) )
            {
                pos = self.origin + ( 0, 0, 70 );
            }
            
            print3d( pos, "<dev string:x96>" + text, ( 1, 0, 0 ) );
        }
    }

#/
