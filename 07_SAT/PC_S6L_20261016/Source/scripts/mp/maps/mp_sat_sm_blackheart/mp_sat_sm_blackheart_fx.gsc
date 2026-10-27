// scripts\mp\maps\mp_sat_sm_blackheart\mp_sat_sm_blackheart_fx.gsc  (hash_236a1485fb895aee.gscc) (size: 354 Bytes / 0x162 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x96745693 (2524206739)
// size ...... 354 (0x162)
// includes .. 0   (offset: 0x14a)
// strings ... 2   (offset: 0x14a)
// dev strs .. 0   (offset: 0x162)
// exports ... 2   (offset: 0xde)
// cseg ...... 0x93 + 0x4b (0xde)
// imports ... 1   (offset: 0x12e)
// animtree1 . 0   (offset: 0x162)
// animtree2 . 0   (offset: 0x162)
#namespace mp_sat_sm_blackheart_fx;

// Namespace mp_sat_sm_blackheart_fx
// Params 0
// Checksum 0x50f59e91, Offset: 0xb1
// Size: 0x2d
function main()
{
    level._effect[ "water_vfx" ] = loadfxasset( "vfx_sat_levels_mp_blackheart_water_drip_01" );
    level.var_261de636e755e4f4 = #"detonate_over_water";
}

