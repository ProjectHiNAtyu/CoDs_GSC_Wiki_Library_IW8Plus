// scripts\mp\maps\mp_sat_the_forge\mp_sat_the_forge_fx.gsc  (hash_695d5eb1f4db7534.gscc) (size: 894 Bytes / 0x37e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb112a708 (2970789640)
// size ...... 894 (0x37e)
// includes .. 0   (offset: 0x2fe)
// strings ... 8   (offset: 0x2fe)
// dev strs .. 0   (offset: 0x37e)
// exports ... 2   (offset: 0x276)
// cseg ...... 0x17c + 0xfa (0x276)
// imports ... 1   (offset: 0x2c6)
// animtree1 . 0   (offset: 0x37e)
// animtree2 . 0   (offset: 0x37e)
#namespace mp_sat_the_forge_fx;

// Namespace mp_sat_the_forge_fx
// Params 0
// Checksum 0x406d025a, Offset: 0x19a
// Size: 0xdc
function main()
{
    level._effect[ "vfx_sat_level_mp_the_forge_boat_wake_01" ] = loadfxasset( "vfx_sat_level_mp_the_forge_boat_wake_01" );
    level._effect[ "vfx_the_forge_boat_wake_01" ] = loadfxasset( "vfx_sat_level_mp_the_forge_boat_wake_01" );
    level._effect[ "vfx_sat_level_mp_the_forge_boat_wake_02" ] = loadfxasset( "vfx_sat_level_mp_the_forge_boat_wake_02" );
    level._effect[ "vfx_the_forge_boat_wake_02" ] = loadfxasset( "vfx_sat_level_mp_the_forge_boat_wake_02" );
    level._effect[ "vfx_sat_level_mp_the_forge_boat_wake_03" ] = loadfxasset( "vfx_sat_level_mp_the_forge_boat_wake_03" );
    level._effect[ "vfx_the_forge_boat_wake_03" ] = loadfxasset( "vfx_sat_level_mp_the_forge_boat_wake_03" );
    level._effect[ "vfx_sat_level_mp_the_forge_boat_wake_04" ] = loadfxasset( "vfx_sat_level_mp_the_forge_boat_wake_04" );
    level._effect[ "vfx_the_forge_boat_wake_04" ] = loadfxasset( "vfx_sat_level_mp_the_forge_boat_wake_04" );
    level.var_261de636e755e4f4 = #"detonate_over_water";
}

