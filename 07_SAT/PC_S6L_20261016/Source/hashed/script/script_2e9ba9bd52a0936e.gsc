// script_2e9ba9bd52a0936e  (hash_2e9ba9bd52a0936e.gscc) (size: 472 Bytes / 0x1d8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd63c227d (3594265213)
// size ...... 472 (0x1d8)
// includes .. 1   (offset: 0x1c4)
// strings ... 1   (offset: 0x1cc)
// dev strs .. 0   (offset: 0x1d8)
// exports ... 5   (offset: 0xc4)
// cseg ...... 0x66 + 0x5e (0xc4)
// imports ... 2   (offset: 0x18c)
// animtree1 . 0   (offset: 0x1d8)
// animtree2 . 0   (offset: 0x1d8)
#using scripts\asm\asm;

#namespace namespace_dda7f81067cf7acb;

// Namespace namespace_dda7f81067cf7acb
// Params 0
// Checksum 0x8fc7cd47, Offset: 0x84
// Size: 0x2
function function_2487cd4ddfbb9cdc()
{
    
}

// Namespace namespace_dda7f81067cf7acb
// Params 0
// Checksum 0xbd59bd8a, Offset: 0x8e
// Size: 0x2
function init_zombie_phobos_enraged()
{
    
}

// Namespace namespace_dda7f81067cf7acb
// Params 0
// Checksum 0x4e00d657, Offset: 0x98
// Size: 0xe
function function_586293bcd3535260()
{
    asm::asm_setstate( "enraged_in" );
}

/#

    // Namespace namespace_dda7f81067cf7acb
    // Params 0, eflags: 0x4
    // Checksum 0xa74aec5e, Offset: 0xae
    // Size: 0x16, Type: dev
    function private debug_enraged()
    {
        return getdvarint( @"hash_afec1a4f0f9e6c38", 0 ) > 0;
    }

#/
