// scripts\mp\zm\systems\items\zm_item_equipment.gsc  (hash_12ea2791a3c9f694.gscc) (size: 1743 Bytes / 0x6cf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x13b5887d (330664061)
// size ...... 1743 (0x6cf)
// includes .. 2   (offset: 0x67f)
// strings ... 4   (offset: 0x68f)
// dev strs .. 0   (offset: 0x6cf)
// exports ... 6   (offset: 0x3b3)
// cseg ...... 0x86 + 0x32d (0x3b3)
// imports ... 15  (offset: 0x4a3)
// animtree1 . 0   (offset: 0x6cf)
// animtree2 . 0   (offset: 0x6cf)
#using scripts\mp\equipment;
#using scripts\mp\loot\common_item;

#namespace zm_item_equipment;

// Namespace zm_item_equipment
// Params 0
// Checksum 0x43dadd24, Offset: 0xa4
// Size: 0x82
function init_item_equipment()
{
    common_item::function_4b30c091d3b04a25( "lethal" );
    common_item::function_84174b793b5fe9a7( "lethal", #"use", &pickup_equipment );
    common_item::function_84174b793b5fe9a7( "lethal", #"canautouse", &can_pickup_equipment );
    common_item::function_4b30c091d3b04a25( "tactical" );
    common_item::function_84174b793b5fe9a7( "tactical", #"use", &pickup_equipment );
    common_item::function_84174b793b5fe9a7( "tactical", #"canautouse", &can_pickup_equipment );
}

// Namespace zm_item_equipment
// Params 4
// Checksum 0xdbad4e4b, Offset: 0x12e
// Size: 0xc6, Type: bool
function can_pickup_equipment( itembundle, item, autouse, allowswap )
{
    equipmentslot = get_equipment_slot( common_item::function_16e8c106491eeaca( itembundle ) );
    currentequipment = equipment_mp::getcurrentequipment( equipmentslot );
    
    if ( isdefined( currentequipment ) )
    {
        if ( autouse || !allowswap )
        {
            ammo = equipment_mp::getequipmentammo( currentequipment );
            
            if ( currentequipment != itembundle.ref && ammo > 0 )
            {
                return false;
            }
        }
        
        if ( currentequipment == itembundle.ref )
        {
            ammo = equipment_mp::getequipmentammo( currentequipment );
            maxammo = equipment_mp::getequipmentmaxammo( currentequipment );
            return ( ammo < maxammo );
        }
    }
    
    return true;
}

// Namespace zm_item_equipment
// Params 4
// Checksum 0x5e5e46c, Offset: 0x1fd
// Size: 0x10c, Type: bool
function pickup_equipment( itembundle, item, autouse, var_981c264073bf1154 )
{
    equipmentslot = get_equipment_slot( common_item::function_16e8c106491eeaca( itembundle ) );
    currentequipment = equipment_mp::getcurrentequipment( equipmentslot );
    equipmentref = itembundle.ref;
    count = common_item::function_44eacd480abb5b94( item.count );
    
    if ( isdefined( currentequipment ) )
    {
        ammo = equipment_mp::getequipmentammo( currentequipment );
        maxammo = equipment_mp::getequipmentmaxammo( currentequipment );
        
        if ( currentequipment == itembundle.ref )
        {
            if ( ammo < maxammo )
            {
                count = ammo + count;
            }
            else
            {
                return true;
            }
        }
        else if ( ammo > 0 )
        {
            spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
            common_item::function_325e28c0fb65c36a( currentequipment, ammo, spawnoptions );
        }
    }
    
    equipment_mp::giveequipment( equipmentref, equipmentslot );
    equipment_mp::setequipmentammo( equipmentref, count );
    return false;
}

// Namespace zm_item_equipment
// Params 1
// Checksum 0x47d61a5b, Offset: 0x312
// Size: 0x5d
function function_fb733bc79550c91a( slot )
{
    lootid = 0;
    quantity = 0;
    currentequipment = equipment_mp::getcurrentequipment( slot );
    
    if ( isdefined( currentequipment ) )
    {
        lootid = common_item::items_getlootidfromref( currentequipment );
        quantity = equipment_mp::getequipmentammo( currentequipment );
    }
    
    return [ lootid, quantity ];
}

// Namespace zm_item_equipment
// Params 1
// Checksum 0x636300bb, Offset: 0x378
// Size: 0x3a
function get_equipment_slot( item_type )
{
    switch ( item_type )
    {
        case #"hash_339227cb650975db":
            return "primary";
        case #"hash_850999d7864fa3b4":
            return "secondary";
    }
}

