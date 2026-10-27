// scripts\mp\maps\mp_sat_coolant\mp_sat_coolant_fx.gsc  (hash_69505ed1e5652abe.gscc) (size: 451 Bytes / 0x1c3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xec5953ef (3965277167)
// size ...... 451 (0x1c3)
// includes .. 1   (offset: 0x1a3)
// strings ... 2   (offset: 0x1ab)
// dev strs .. 0   (offset: 0x1c3)
// exports ... 3   (offset: 0xd7)
// cseg ...... 0x80 + 0x57 (0xd7)
// imports ... 3   (offset: 0x14f)
// animtree1 . 0   (offset: 0x1c3)
// animtree2 . 0   (offset: 0x1c3)
#using scripts\mp\flags;

#namespace mp_sat_coolant_fx;

// Namespace mp_sat_coolant_fx
// Params 0
// Checksum 0x4213a4b6, Offset: 0x9e
// Size: 0xa
function main()
{
    level thread function_15c103706a01e62e();
}

// Namespace mp_sat_coolant_fx
// Params 0, eflags: 0x4
// Checksum 0xb9a0d70b, Offset: 0xb0
// Size: 0x27
function private function_15c103706a01e62e()
{
    level endon( #"hash_ae78a05a1f3ffddb" );
    level flags::function_2f3408423ccc9b2e( "potg_finalized" );
    activateworldevent( "we_vfx_camera_snow", 1 );
}

