// scripts\mp\maps\mp_sat_homestead_halloween\mp_sat_homestead_halloween_fx.gsc  (hash_6b0d566f5863ccae.gscc) (size: 640 Bytes / 0x280 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8e171140 (2383876416)
// size ...... 640 (0x280)
// includes .. 0   (offset: 0x230)
// strings ... 6   (offset: 0x230)
// dev strs .. 0   (offset: 0x280)
// exports ... 2   (offset: 0x1b8)
// cseg ...... 0x134 + 0x84 (0x1b8)
// imports ... 1   (offset: 0x208)
// animtree1 . 0   (offset: 0x280)
// animtree2 . 0   (offset: 0x280)
#namespace mp_sat_homestead_halloween_fx;

// Namespace mp_sat_homestead_halloween_fx
// Params 0
// Checksum 0xaf582bb1, Offset: 0x152
// Size: 0x66
function main()
{
    level._effect[ "ruby_js_image" ] = loadfxasset( "vfx_sat_levels_zm_ruby_jump_scare_camera" );
    level._effect[ "jump_scare" ] = loadfxasset( "vfx_t10_levels_zm_opal_jump_scare_camera" );
    level._effect[ "vfx_sat_levels_mp_homestead_halloween_loot_cyst_trail" ] = loadfxasset( "vfx_sat_levels_mp_homestead_halloween_loot_cyst_trail" );
    level._effect[ "vfx_t10_gameplay_zm_loot_trail_legendary" ] = loadfxasset( "vfx_t10_gameplay_zm_loot_trail_legendary" );
}

