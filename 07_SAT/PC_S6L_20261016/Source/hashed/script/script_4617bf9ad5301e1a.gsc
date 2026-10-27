// script_4617bf9ad5301e1a  (hash_4617bf9ad5301e1a.gscc) (size: 705 Bytes / 0x2c1)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xeb9f5a92 (3953089170)
// size ...... 705 (0x2c1)
// includes .. 1   (offset: 0x2ad)
// strings ... 1   (offset: 0x2b5)
// dev strs .. 0   (offset: 0x2c1)
// exports ... 6   (offset: 0x131)
// cseg ...... 0x6c + 0xc5 (0x131)
// imports ... 5   (offset: 0x221)
// animtree1 . 0   (offset: 0x2c1)
// animtree2 . 0   (offset: 0x2c1)
#using script_63258e3c8c400b7a;

#namespace prophuntcontrols;

// Namespace prophuntcontrols
// Params 2
// Checksum 0x4e86bd4d, Offset: 0x8a
// Size: 0x27
function unregister( player, forceclose = 0 )
{
    lui_elems::unregister_lui_elem( player, forceclose );
}

// Namespace prophuntcontrols
// Params 0
// Checksum 0xffc4555f, Offset: 0xb9
// Size: 0x16
function register()
{
    return lui_elems::register_lui_elem( "PropHuntControls", #"prophuntcontrols" );
}

// Namespace prophuntcontrols
// Params 2
// Checksum 0xc2b5d53d, Offset: 0xd8
// Size: 0x1f
function open( player, flags )
{
    lui_elems::open_lui_elem( player, flags );
}

// Namespace prophuntcontrols
// Params 1
// Checksum 0x2652a98b, Offset: 0xff
// Size: 0x15
function close( player )
{
    lui_elems::close_lui_elem( player );
}

// Namespace prophuntcontrols
// Params 1
// Checksum 0x360dba4a, Offset: 0x11c
// Size: 0x14
function is_open( player )
{
    return lui_elems::is_open_lui_elem( player );
}

