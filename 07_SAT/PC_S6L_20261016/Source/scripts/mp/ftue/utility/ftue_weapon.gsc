// scripts\mp\ftue\utility\ftue_weapon.gsc  (hash_0781de0ee4cd5153.gscc) (size: 1173 Bytes / 0x495 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfa32940e (4197618702)
// size ...... 1173 (0x495)
// includes .. 5   (offset: 0x455)
// strings ... 2   (offset: 0x47d)
// dev strs .. 0   (offset: 0x495)
// exports ... 5   (offset: 0x235)
// cseg ...... 0x70 + 0x1c5 (0x235)
// imports ... 12  (offset: 0x2fd)
// animtree1 . 0   (offset: 0x495)
// animtree2 . 0   (offset: 0x495)
#using scripts\common\weapon;
#using scripts\mp\br\gametypes\br_weapons;
#using scripts\mp\common\utility\inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;

#namespace ftue_weapon;

// Namespace ftue_weapon
// Params 4
// Checksum 0xe8ca3990, Offset: 0x8e
// Size: 0xd8
function function_2b043353c56db43( weaponname, attachmentsstring, position, angles )
{
    weapattachments = strtok( attachmentsstring, "+" );
    weaponobj = weapon::buildweapon( weaponname, weapattachments, undefined, undefined, -1, undefined, undefined, undefined, 0 );
    weaponinfostruct = spawnstruct();
    weaponinfostruct.ammoclipright = weaponclipsize( weaponobj );
    weaponinfostruct.ammoclipleft = weaponclipsize( weaponobj );
    weaponinfostruct.ammoclipalt = weaponclipsize( weaponobj );
    weaponinfostruct.ammostock = weaponmaxammo( weaponobj );
    spawnoptions = common_item::function_bc5ff2958b71a708( position, angles );
    weaponpickup = item_weapon::function_53da2af5697709f8( weaponobj, weaponinfostruct, spawnoptions );
    return weaponpickup;
}

// Namespace ftue_weapon
// Params 1
// Checksum 0x6f4619ef, Offset: 0x16f
// Size: 0x4a
function function_2d46aef28ae9a3de( ammoposition )
{
    objweapon = level.player getcurrentweapon();
    weaponammotype = br_weapons::br_ammo_type_for_weapon( objweapon );
    spawnedammo = spawnscriptable( weaponammotype, ammoposition );
    return spawnedammo;
}

// Namespace ftue_weapon
// Params 1
// Checksum 0x7b06bc63, Offset: 0x1c2
// Size: 0x37
function function_ee6218ff39f233ea( var_32c7fe63bd4d1ee1 )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    
    while ( !self isreloading() )
    {
        waitframe();
    }
    
    self [[ var_32c7fe63bd4d1ee1 ]]();
}

// Namespace ftue_weapon
// Params 0
// Checksum 0x4b2885f7, Offset: 0x201
// Size: 0x33, Type: bool
function function_f17ccf5633ebd537()
{
    firstweapon = inventory::getfirstprimaryweapon();
    
    if ( isdefined( firstweapon ) && firstweapon.basename != "iw9_me_fists_mp" )
    {
        return true;
    }
    
    return false;
}

