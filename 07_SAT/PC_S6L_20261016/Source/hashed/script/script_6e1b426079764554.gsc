// script_6e1b426079764554  (hash_6e1b426079764554.gscc) (size: 1125 Bytes / 0x465 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaf7d9e9c (2944245404)
// size ...... 1125 (0x465)
// includes .. 5   (offset: 0x415)
// strings ... 3   (offset: 0x43d)
// dev strs .. 0   (offset: 0x465)
// exports ... 5   (offset: 0x1bd)
// cseg ...... 0x85 + 0x138 (0x1bd)
// imports ... 14  (offset: 0x285)
// animtree1 . 0   (offset: 0x465)
// animtree2 . 0   (offset: 0x465)
#using script_aa3bac81ad4fc8e;
#using scripts\common\system;
#using scripts\common\weapon;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\pack_a_punch;

#namespace zm_bgb_fully_packed;

// Namespace zm_bgb_fully_packed
// Params 0, eflags: 0x5
// Checksum 0x62917e3c, Offset: 0xa3
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "fully_packed", #"bgb", &__init__, undefined );
}

// Namespace zm_bgb_fully_packed
// Params 0
// Checksum 0xfb1d137f, Offset: 0xc8
// Size: 0x21
function __init__()
{
    bgb::register( "fully_packed", "activated", 1, undefined, undefined, &validation, &activation );
}

// Namespace zm_bgb_fully_packed
// Params 0
// Checksum 0x632862c5, Offset: 0xf1
// Size: 0x3c
function activation()
{
    weapon = self getcurrentweapon();
    pap_lvl = pack_a_punch::get_pap_level( weapon );
    pack_a_punch::pap_weapon( weapon, pap_lvl, undefined, undefined, undefined, undefined, undefined, 3 );
    wait 0.1;
}

// Namespace zm_bgb_fully_packed
// Params 0
// Checksum 0xdbe65af2, Offset: 0x135
// Size: 0x87, Type: bool
function validation()
{
    weapon = self getcurrentweapon();
    pap_lvl = pack_a_punch::get_pap_level( weapon );
    
    if ( !self isswitchingweapon() && !weapon::isfistweapon( weapon ) && !weapon::iskillstreakweapon( weapon ) && !killstreakdeploy::function_9670f0716ada309b( weapon.basename ) && !bgb::is_active( "hidden_power" ) && pack_a_punch::can_pap( weapon ) && pap_lvl < 3 )
    {
        return true;
    }
    
    return false;
}

