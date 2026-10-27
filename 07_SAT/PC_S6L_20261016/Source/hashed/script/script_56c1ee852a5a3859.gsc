// script_56c1ee852a5a3859  (hash_56c1ee852a5a3859.gscc) (size: 555 Bytes / 0x22b)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x35e025c8 (903882184)
// size ...... 555 (0x22b)
// includes .. 0   (offset: 0x21f)
// strings ... 0   (offset: 0x21f)
// dev strs .. 1   (offset: 0x21f)
// exports ... 5   (offset: 0x103)
// cseg ...... 0x58 + 0xab (0x103)
// imports ... 3   (offset: 0x1cb)
// animtree1 . 0   (offset: 0x22b)
// animtree2 . 0   (offset: 0x22b)
#namespace namespace_41b3c10212179324;

// Namespace namespace_41b3c10212179324
// Params 0
// Checksum 0xc72c4a4f, Offset: 0x76
// Size: 0x2
function function_115f39adad17c83b()
{
    
}

// Namespace namespace_41b3c10212179324
// Params 0
// Checksum 0xe09f2a3c, Offset: 0x80
// Size: 0x2
function init_zombie_phobos_spithose()
{
    
}

/#

    // Namespace namespace_41b3c10212179324
    // Params 0, eflags: 0x4
    // Checksum 0x4eed869, Offset: 0x8a
    // Size: 0x16, Type: dev
    function private debug_spit()
    {
        return getdvarint( @"phobos_spit_debug", 0 ) > 0;
    }

    // Namespace namespace_41b3c10212179324
    // Params 2, eflags: 0x4
    // Checksum 0x4ecccbb0, Offset: 0xa8
    // Size: 0x5b, Type: dev
    function private spit_print( text, pos )
    {
        if ( debug_spit() )
        {
            if ( !isdefined( pos ) )
            {
                pos = self.origin + ( 0, 0, 70 );
            }
            
            print3d( pos, "<dev string:x24>" + text, ( 1, 0, 0 ) );
        }
    }

#/
