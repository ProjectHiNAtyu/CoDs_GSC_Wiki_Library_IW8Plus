// scripts\mp\ob\systems\ob_item_ammo.gsc  (hash_04039df15bb92a2d.gscc) (size: 1214 Bytes / 0x4be / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x68652e31 (1751461425)
// size ...... 1214 (0x4be)
// includes .. 1   (offset: 0x492)
// strings ... 2   (offset: 0x49a)
// dev strs .. 0   (offset: 0x4be)
// exports ... 4   (offset: 0x2ea)
// cseg ...... 0x6b + 0x27f (0x2ea)
// imports ... 9   (offset: 0x38a)
// animtree1 . 0   (offset: 0x4be)
// animtree2 . 0   (offset: 0x4be)
#using scripts\mp\loot\common_item;

#namespace ob_item_ammo;

// Namespace ob_item_ammo
// Params 0
// Checksum 0xb8293615, Offset: 0x89
// Size: 0x42
function init_item_ammo()
{
    common_item::function_4b30c091d3b04a25( "ammo" );
    common_item::function_84174b793b5fe9a7( "ammo", #"use", &function_8bd793b0e49846d8 );
    common_item::function_84174b793b5fe9a7( "ammo", #"canautouse", &function_380b1678c9f2110 );
}

// Namespace ob_item_ammo
// Params 4
// Checksum 0x481af866, Offset: 0xd3
// Size: 0xe1, Type: bool
function function_380b1678c9f2110( var_f35ca3abacda4f11, item, auto_pickup, var_a0f59cb55797bb59 )
{
    foreach ( primary_weapon in self.primaryweapons )
    {
        if ( primary_weapon.inventorytype == "primary" && !primary_weapon.ismelee )
        {
            current_ammo = self getweaponammostock( primary_weapon );
            
            if ( current_ammo < primary_weapon.maxammo )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace ob_item_ammo
// Params 4
// Checksum 0x6d7c961f, Offset: 0x1bd
// Size: 0x12c, Type: bool
function function_8bd793b0e49846d8( var_f35ca3abacda4f11, item, autouse, var_981c264073bf1154 )
{
    foreach ( primary_weapon in self.primaryweapons )
    {
        if ( primary_weapon.inventorytype == "primary" && !primary_weapon.ismelee )
        {
            ammoamount = item.count ?? 20;
            maxammo = primary_weapon.maxammo;
            var_8bb1b2bde27b267c = maxammo * ammoamount / 100;
            var_da5b372f327ba5dd = self getweaponammostock( primary_weapon );
            var_8bb1b2bde27b267c = var_da5b372f327ba5dd + var_8bb1b2bde27b267c;
            var_8bb1b2bde27b267c = clamp( var_8bb1b2bde27b267c, 0, maxammo );
            self setweaponammostock( primary_weapon, int( var_8bb1b2bde27b267c ) );
        }
    }
    
    return false;
}

