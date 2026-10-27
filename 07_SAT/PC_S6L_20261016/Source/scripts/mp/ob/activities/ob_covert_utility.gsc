// scripts\mp\ob\activities\ob_covert_utility.gsc  (hash_2f6c6e8ca64c368c.gscc) (size: 719 Bytes / 0x2cf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x74ca167c (1959401084)
// size ...... 719 (0x2cf)
// includes .. 2   (offset: 0x29b)
// strings ... 2   (offset: 0x2ab)
// dev strs .. 0   (offset: 0x2cf)
// exports ... 3   (offset: 0x15f)
// cseg ...... 0x92 + 0xcd (0x15f)
// imports ... 7   (offset: 0x1d7)
// animtree1 . 0   (offset: 0x2cf)
// animtree2 . 0   (offset: 0x2cf)
#using scripts\common\utility;
#using scripts\mp\loot\common_item;

#namespace ob_covert_utility;

// Namespace ob_covert_utility
// Params 0
// Checksum 0xcdc77b9a, Offset: 0xb0
// Size: 0x2e
function function_ca660988c89ba0b1()
{
    if ( !level._effect[ "vfx_sat_ob_gameplay_chest_spawn" ] )
    {
        level._effect[ "vfx_sat_ob_gameplay_chest_spawn" ] = loadfxasset( "vfx_sat_ob_gameplay_chest_spawn" );
    }
}

// Namespace ob_covert_utility
// Params 3
// Checksum 0x4e526615, Offset: 0xe6
// Size: 0x79
function covert_spawn_reward( itemspawnlist, origin, angles )
{
    spawn_options = common_item::function_bc5ff2958b71a708( origin, angles );
    item_name = function_c11af7a197679429( itemspawnlist, 1 );
    item = common_item::function_61c2c0251e742ffd( item_name[ 0 ], undefined, spawn_options );
    playfx( utility::getfx( "vfx_sat_ob_gameplay_chest_spawn" ), origin );
    playsoundatpos( origin, "evt_mimic_prop_hide" );
}

