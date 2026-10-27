// script_7e08b9bf9ee84ae1  (hash_7e08b9bf9ee84ae1.gscc) (size: 593 Bytes / 0x251)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd14f77cf (3511646159)
// size ...... 593 (0x251)
// includes .. 1   (offset: 0x23d)
// strings ... 1   (offset: 0x245)
// dev strs .. 0   (offset: 0x251)
// exports ... 5   (offset: 0x105)
// cseg ...... 0x6f + 0x96 (0x105)
// imports ... 4   (offset: 0x1cd)
// animtree1 . 0   (offset: 0x251)
// animtree2 . 0   (offset: 0x251)
#using script_63258e3c8c400b7a;

#namespace ZMWeaponUpgradeMenu;

// Namespace ZMWeaponUpgradeMenu
// Params 0
// Checksum 0x6f896d36, Offset: 0x8d
// Size: 0x16
function register()
{
    return lui_elems::register_lui_elem( "ZMWeaponUpgradeMenu", #"zmweaponupgrademenu" );
}

// Namespace ZMWeaponUpgradeMenu
// Params 2
// Checksum 0xfd8f3843, Offset: 0xac
// Size: 0x1f
function open( player, flags )
{
    lui_elems::open_lui_elem( player, flags );
}

// Namespace ZMWeaponUpgradeMenu
// Params 1
// Checksum 0x196844f5, Offset: 0xd3
// Size: 0x15
function close( player )
{
    lui_elems::close_lui_elem( player );
}

// Namespace ZMWeaponUpgradeMenu
// Params 1
// Checksum 0x9375734, Offset: 0xf0
// Size: 0x14
function is_open( player )
{
    return lui_elems::is_open_lui_elem( player );
}

