// scripts\vehicle\empty_nocollision.gsc  (hash_304fb8a7a53594f4.gscc) (size: 527 Bytes / 0x20f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb64effb0 (3058630576)
// size ...... 527 (0x20f)
// includes .. 1   (offset: 0x207)
// strings ... 0   (offset: 0x20f)
// dev strs .. 0   (offset: 0x20f)
// exports ... 3   (offset: 0xe7)
// cseg ...... 0x64 + 0x83 (0xe7)
// imports ... 6   (offset: 0x15f)
// animtree1 . 0   (offset: 0x20f)
// animtree2 . 0   (offset: 0x20f)
#using scripts\common\vehicle_build;

#namespace empty_nocollision;

// Namespace empty_nocollision
// Params 3
// Checksum 0x4c415998, Offset: 0x82
// Size: 0x4a
function main( model, type, classname )
{
    vehicle_build::build_template( type, model, undefined, classname );
    vehicle_build::build_localinit( &init_local );
    vehicle_build::build_life( 90000 );
    vehicle_build::build_is_airplane();
}

// Namespace empty_nocollision
// Params 0
// Checksum 0x68ea516b, Offset: 0xd4
// Size: 0x13
function init_local()
{
    self.disable_wash = 1;
    self hideallparts();
}

