// script_23c6ff72ee8ce2d5  (hash_23c6ff72ee8ce2d5.gscc) (size: 1426 Bytes / 0x592 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd9287759 (3643307865)
// size ...... 1426 (0x592)
// includes .. 5   (offset: 0x536)
// strings ... 4   (offset: 0x55e)
// dev strs .. 0   (offset: 0x592)
// exports ... 4   (offset: 0x326)
// cseg ...... 0xba + 0x26c (0x326)
// imports ... 13  (offset: 0x3c6)
// animtree1 . 0   (offset: 0x592)
// animtree2 . 0   (offset: 0x592)
#using script_31ee2a173f3499b7;
#using scripts\common\system;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_weapon;

#namespace ztron_item_weapon;

// Namespace ztron_item_weapon
// Params 0, eflags: 0x5
// Checksum 0x33bc218f, Offset: 0xd8
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_item_weapon", #"ztron_item", undefined, &init );
}

// Namespace ztron_item_weapon
// Params 0
// Checksum 0xf65cd572, Offset: 0x101
// Size: 0x15d
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"weapon", #"use", &useweapon );
    
    foreach ( var_ea94fc492cd8775f, _ in level.ztron.itemdef.itemdata )
    {
        bundle = getscriptbundlefieldvalues( var_ea94fc492cd8775f, [ #"genericstring", #"genericinteger" ] );
        type = bundle.genericstring;
        
        if ( type == #"weapon" )
        {
            var_c218def7b6eb54ad = level.ztron.itemdef.itemdata[ var_ea94fc492cd8775f ].weaponbundle;
            ztron_weapon::function_ca69007ed23675ee( var_c218def7b6eb54ad, var_ea94fc492cd8775f, bundle.genericinteger );
        }
    }
    
    level thread ztron_weapon::function_f331fb6858460752();
    level thread ztron_weapon::function_843cf77e99e3281();
    ztron_sound::function_4ac735395b173fe( "weapon_pickup_generic_OS", "evt_ztron_pickup_weapon_generic" );
}

// Namespace ztron_item_weapon
// Params 1, eflags: 0x4
// Checksum 0x3d7987c5, Offset: 0x266
// Size: 0xc0
function private useweapon( params )
{
    var_c218def7b6eb54ad = level.ztron.itemdef.itemdata[ params.scriptable.var_8593f17418a81b6e ].weaponbundle;
    
    if ( var_c218def7b6eb54ad == %"hash_7b269d83e9f2bfac" )
    {
        params.player ztron_ui::function_787d89891b886acf( "JETGUN_HINT" );
    }
    else
    {
        params.player ztron_ui::function_787d89891b886acf( "WEAPON_DROP_HINT" );
    }
    
    params.player ztron_weapon::giveweaponpack( var_c218def7b6eb54ad, 1 );
    ztron_sound::ztron_playsound( "weapon_pickup_generic_OS", self.origin );
}

