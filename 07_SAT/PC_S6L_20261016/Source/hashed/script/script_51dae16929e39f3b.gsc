// script_51dae16929e39f3b  (hash_51dae16929e39f3b.gscc) (size: 1086 Bytes / 0x43e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6b2a9671 (1797953137)
// size ...... 1086 (0x43e)
// includes .. 5   (offset: 0x3ee)
// strings ... 3   (offset: 0x416)
// dev strs .. 0   (offset: 0x43e)
// exports ... 5   (offset: 0x19a)
// cseg ...... 0x85 + 0x115 (0x19a)
// imports ... 14  (offset: 0x262)
// animtree1 . 0   (offset: 0x43e)
// animtree2 . 0   (offset: 0x43e)
#using script_aa3bac81ad4fc8e;
#using scripts\common\system;
#using scripts\common\weapon;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\loot\common_item_weapon;

#namespace zm_bgb_hidden_power;

// Namespace zm_bgb_hidden_power
// Params 0, eflags: 0x5
// Checksum 0xe7142333, Offset: 0xa3
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "hidden_power", #"bgb", &__init__, undefined );
}

// Namespace zm_bgb_hidden_power
// Params 0
// Checksum 0xbe0efa20, Offset: 0xc8
// Size: 0x21
function __init__()
{
    bgb::register( "hidden_power", "activated", 1, undefined, undefined, &validation, &activation );
}

// Namespace zm_bgb_hidden_power
// Params 0
// Checksum 0xfa420dec, Offset: 0xf1
// Size: 0x7c, Type: bool
function validation()
{
    weapon = self getcurrentweapon();
    
    if ( !self isswitchingweapon() && !weapon::isfistweapon( weapon ) && !weapon::iswonderweapon( weapon ) && !weapon::iskillstreakweapon( weapon ) && !killstreakdeploy::function_9670f0716ada309b( weapon.basename ) && !bgb::is_active( "fully_packed" ) && item_weapon::function_fb81bd2fe070faa6( weapon ) < 4 )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_bgb_hidden_power
// Params 0
// Checksum 0x5fce0b5d, Offset: 0x176
// Size: 0x24
function activation()
{
    weapon = self getcurrentweapon();
    item_weapon::function_40e1cbd0e1f47d1a( weapon, 4 );
    wait 0.1;
}

