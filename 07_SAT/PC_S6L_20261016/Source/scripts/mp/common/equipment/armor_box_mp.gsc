// scripts\mp\common\equipment\armor_box_mp.gsc  (hash_3031e3046fae7a98.gscc) (size: 867 Bytes / 0x363 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x46863971 (1183201649)
// size ...... 867 (0x363)
// includes .. 4   (offset: 0x30b)
// strings ... 4   (offset: 0x32b)
// dev strs .. 0   (offset: 0x363)
// exports ... 4   (offset: 0x18b)
// cseg ...... 0x90 + 0xfb (0x18b)
// imports ... 8   (offset: 0x22b)
// animtree1 . 0   (offset: 0x363)
// animtree2 . 0   (offset: 0x363)
#using scripts\common\utility;
#using scripts\mp\common\equipment\support_box;
#using scripts\mp\damagefeedback;
#using scripts\mp\equipment;

#namespace armor_box_mp;

// Namespace armor_box_mp
// Params 0, eflags: 0x1
// Checksum 0x7a392ad9, Offset: 0xae
// Size: 0x1c
function autoexec main()
{
    utility::registersharedfunc( "armor_drop", #"init", &init );
}

// Namespace armor_box_mp
// Params 0
// Checksum 0xb8c9f2d8, Offset: 0xd2
// Size: 0x10
function init()
{
    level.onarmorboxusedbyplayer = &onarmorboxusedbyplayer;
}

// Namespace armor_box_mp
// Params 1
// Checksum 0x52dc3ef9, Offset: 0xea
// Size: 0xa0, Type: bool
function onarmorboxusedbyplayer( player )
{
    armoramount = getdvarint( @"hash_796878180a8e250", 4 );
    
    if ( isdefined( player.equipment ) && !isdefined( player.equipment[ "health" ] ) )
    {
        player.equipment[ "health" ] = level.armorref ?? "equip_armorplate";
    }
    
    player equipment_mp::incrementequipmentslotammo( "health", armoramount );
    player damagefeedback::hudicontype( "br_armor" );
    support_box::supportbox_playusesound( player );
    thread support_box::supportbox_onplayeruseanim();
    return true;
}

