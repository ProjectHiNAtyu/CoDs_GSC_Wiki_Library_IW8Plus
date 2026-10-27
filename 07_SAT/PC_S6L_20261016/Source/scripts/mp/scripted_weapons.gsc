// scripts\mp\scripted_weapons.gsc  (hash_4c329fef77c1d45a.gscc) (size: 674 Bytes / 0x2a2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x27e3c742 (669239106)
// size ...... 674 (0x2a2)
// includes .. 0   (offset: 0x296)
// strings ... 0   (offset: 0x296)
// dev strs .. 1   (offset: 0x296)
// exports ... 3   (offset: 0x1ae)
// cseg ...... 0x58 + 0x156 (0x1ae)
// imports ... 4   (offset: 0x226)
// animtree1 . 0   (offset: 0x2a2)
// animtree2 . 0   (offset: 0x2a2)
#namespace scripted_weapons;

// Namespace scripted_weapons
// Params 0
// Checksum 0x28210d32, Offset: 0x76
// Size: 0xf6
function init()
{
    bundlename = level.gamemodebundle.scriptedweapon_list;
    
    if ( !isdefined( bundlename ) )
    {
        return;
    }
    
    bundle = getscriptbundle( bundlename );
    weaponlist = bundle.scriptedweapon_list;
    
    foreach ( weaponstruct in weaponlist )
    {
        if ( isdefined( weaponstruct.weaponref ) )
        {
            weaponstruct.objweapon = makeweapon( weaponstruct.weaponref );
        }
    }
    
    level.var_363840efc0e8a5a0 = weaponlist;
    level notify( #"scripted_weapons_init" );
}

// Namespace scripted_weapons
// Params 1
// Checksum 0xe77e16e4, Offset: 0x174
// Size: 0x39
function get_scripted_weapon_object( basenamehash )
{
    assert( isdefined( level.var_363840efc0e8a5a0 ), "<dev string:x24>" );
    return level.var_363840efc0e8a5a0[ basenamehash ].objweapon;
}

