// scripts\vehicle\empty_heli.gsc  (hash_15a70ad2b561d11d.gscc) (size: 362 Bytes / 0x16a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf210ad52 (4061179218)
// size ...... 362 (0x16a)
// includes .. 1   (offset: 0x152)
// strings ... 1   (offset: 0x15a)
// dev strs .. 0   (offset: 0x16a)
// exports ... 2   (offset: 0xca)
// cseg ...... 0x72 + 0x58 (0xca)
// imports ... 2   (offset: 0x11a)
// animtree1 . 0   (offset: 0x16a)
// animtree2 . 0   (offset: 0x16a)
#using scripts\common\vehicle_build;

#namespace empty_heli;

// Namespace empty_heli
// Params 3
// Checksum 0x2df929d1, Offset: 0x90
// Size: 0x3a
function main( model, type, classname )
{
    vehicle_build::build_template( "empty_heli", model, type, classname );
    vehicle_build::build_is_helicopter( "empty_heli" );
}

