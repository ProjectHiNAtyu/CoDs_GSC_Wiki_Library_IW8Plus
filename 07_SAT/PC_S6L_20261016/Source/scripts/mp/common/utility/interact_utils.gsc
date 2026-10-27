// scripts\mp\common\utility\interact_utils.gsc  (hash_2be847b34eb86a93.gscc) (size: 529 Bytes / 0x211 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7be3b3e1 (2078520289)
// size ...... 529 (0x211)
// includes .. 1   (offset: 0x1d9)
// strings ... 4   (offset: 0x1e1)
// dev strs .. 0   (offset: 0x211)
// exports ... 3   (offset: 0x11d)
// cseg ...... 0x9a + 0x83 (0x11d)
// imports ... 2   (offset: 0x195)
// animtree1 . 0   (offset: 0x211)
// animtree2 . 0   (offset: 0x211)
#using scripts\common\values;

#namespace interact_utils;

// Namespace interact_utils
// Params 1
// Checksum 0xcf74f316, Offset: 0xb8
// Size: 0x48
function function_6b4911d1597d7dc6( ref )
{
    val::set( ref, "killstreaks", 0 );
    val::set( ref, "remote_killstreaks", 0 );
    val::set( ref, "supers", 0 );
    val::set( ref, "offhand_weapons", 0 );
}

// Namespace interact_utils
// Params 1
// Checksum 0x7edd0d79, Offset: 0x108
// Size: 0x15
function function_2589dc899a6731de( ref )
{
    val::reset_all( ref );
}

