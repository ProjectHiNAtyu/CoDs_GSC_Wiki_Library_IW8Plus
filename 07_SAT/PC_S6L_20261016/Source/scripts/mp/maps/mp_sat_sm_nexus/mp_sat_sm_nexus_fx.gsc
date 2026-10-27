// scripts\mp\maps\mp_sat_sm_nexus\mp_sat_sm_nexus_fx.gsc  (hash_1acbde7abea69d06.gscc) (size: 354 Bytes / 0x162 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x181ae27b (404415099)
// size ...... 354 (0x162)
// includes .. 0   (offset: 0x14a)
// strings ... 2   (offset: 0x14a)
// dev strs .. 0   (offset: 0x162)
// exports ... 2   (offset: 0xde)
// cseg ...... 0xa5 + 0x39 (0xde)
// imports ... 1   (offset: 0x12e)
// animtree1 . 0   (offset: 0x162)
// animtree2 . 0   (offset: 0x162)
#namespace mp_sat_sm_nexus_fx;

// Namespace mp_sat_sm_nexus_fx
// Params 0
// Checksum 0xeed78932, Offset: 0xc3
// Size: 0x1b
function main()
{
    level._effect[ "robot_vacuum_death" ] = loadfxasset( "vfx_sat_prop_script_sat_electronics_robot_vacuum_01" );
}

