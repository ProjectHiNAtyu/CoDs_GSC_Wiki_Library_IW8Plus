// scripts\mp\br\gametypes\br_dmz_inventory.gsc  (hash_1b7ef6624a424766.gscc) (size: 9672 Bytes / 0x25c8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb2d42c4 (187515588)
// size ...... 9672 (0x25c8)
// includes .. 16  (offset: 0x2284)
// strings ... 35  (offset: 0x2304)
// dev strs .. 6   (offset: 0x2580)
// exports ... 19  (offset: 0x1788)
// cseg ...... 0x33a + 0x144e (0x1788)
// imports ... 63  (offset: 0x1a80)
// animtree1 . 0   (offset: 0x25c8)
// animtree2 . 0   (offset: 0x25c8)
#using script_78fc8c746d423a6d;
#using scripts\common\ae_utility;
#using scripts\common\gasmask;
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_default_inventory;
#using scripts\mp\br\gametypes\br_instance_inventory;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\challenges;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\loot;
#using scripts\mp\equipment;
#using scripts\mp\weapons;

#namespace br_dmz_inventory;

// Namespace br_dmz_inventory
// Params 0
// Checksum 0x241c02c8, Offset: 0x358
// Size: 0x2ad
function snapshotinventory_initial()
{
    if ( isai( self ) )
    {
        return;
    }
    
    if ( !br_default_inventory::function_b7b8a2d7ac9eb88b() )
    {
        return;
    }
    
    println( self.name + "<dev string:x24>" );
    
    if ( br_instance_inventory::function_926a8f8643d34690() )
    {
        br_instance_inventory::function_2c3478576a392389( self );
        var_f15881dead287f84 = br_instance_inventory::function_2b6831d1c23b80fd( self );
        
        if ( var_f15881dead287f84 > 0 )
        {
            br_default_inventory::function_86f211f994ea95a3( "brloot_armor_plate", var_f15881dead287f84 );
        }
    }
    
    println( self.name + "<dev string:x40>" );
    
    if ( !function_8acb6b99e9082011() )
    {
        clearloadout();
    }
    
    br_default_inventory::function_ba03dc5a721b978b( self );
    
    if ( !isdefined( level.var_e28e7caa9d0d5eb8 ) )
    {
        filename = "mp/dmz_starting_inventory_ae_whitelist.csv";
        level.var_e28e7caa9d0d5eb8 = [];
        numrows = tablelookupgetnumrows( filename );
        
        for ( row = 0; row < numrows ; row++ )
        {
            level.var_e28e7caa9d0d5eb8[ level.var_e28e7caa9d0d5eb8.size ] = int( tablelookupbyrow( filename, row, 1 ) );
        }
    }
    
    method = challenges::function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"loot_method_bitfield", #"starting_loadout" ) );
    
    foreach ( item in snapshotinventory() )
    {
        comparelootid = item.lootid;
        
        if ( isdefined( item.objweapon ) )
        {
            baseweaponlootid = weapons::function_636e43f4bcdc20b5( item.lootid );
            
            if ( isdefined( baseweaponlootid ) )
            {
                comparelootid = baseweaponlootid;
            }
        }
        
        if ( arraycontains( level.var_e28e7caa9d0d5eb8, comparelootid ) )
        {
            challenges::reportlootitemevent( self, comparelootid, undefined, method, item.quantity );
        }
    }
    
    foreach ( item in br_default_inventory::snapshotbackpack() )
    {
        if ( arraycontains( level.var_e28e7caa9d0d5eb8, item.lootid ) )
        {
            challenges::reportlootitemevent( self, item.lootid, undefined, method, item.quantity );
        }
    }
}

// Namespace br_dmz_inventory
// Params 1
// Checksum 0x39fbd529, Offset: 0x60d
// Size: 0x215
function snapshotinventory_extract( exfilinfo )
{
    if ( isai( self ) )
    {
        return;
    }
    
    if ( !br_default_inventory::function_b7b8a2d7ac9eb88b() )
    {
        return;
    }
    
    println( self.name + "<dev string:x64>" );
    self setplayerdata( level.var_6f9b00680ed002d8, "lootedCash", self.plundercount );
    var_f60a94cc05c2ed0f = br_default_inventory::snapshotbackpack();
    
    foreach ( item in var_f60a94cc05c2ed0f )
    {
        function_3c9057a7d6fa327e( item.lootid );
    }
    
    inventory = snapshotinventory();
    
    foreach ( item in inventory )
    {
        function_3c9057a7d6fa327e( item.lootid );
    }
    
    inventory = snapshotinventory();
    backpackinventory = br_default_inventory::snapshotbackpack();
    clipammo = snapshotclipammo();
    dmz_weapon_case::function_487c6d8d32e756da( self );
    br_instance_inventory::function_7c3d5606261c1cc0( self );
    var_9ebee770c4d8cd27 = self getplayerdata( level.var_6f9b00680ed002d8, "dmzBankedCash" );
    self setplayerdata( level.var_6f9b00680ed002d8, "dmzBankedCash", var_9ebee770c4d8cd27 + self.plundercount );
    utility::callsharedfunc( #"persistent_missions", #"hash_d5d5e1d98bc1edc4", self, inventory, var_f60a94cc05c2ed0f, clipammo, self.plundercount, exfilinfo );
    println( self.name + "<dev string:x8a>" );
}

// Namespace br_dmz_inventory
// Params 0
// Checksum 0xda37c91, Offset: 0x82a
// Size: 0x1b
function getweaponcooldown()
{
    cooldown = br_instance_inventory::function_8f6940f94f97b5aa();
    return getsystemtime() + cooldown;
}

// Namespace br_dmz_inventory
// Params 2
// Checksum 0xf9c24c8d, Offset: 0x84e
// Size: 0x290
function function_e342ce3749830a35( overrideinventory, alreadyremoved )
{
    totalcash = 0;
    
    if ( isdefined( overrideinventory ) )
    {
        backpackinventory = overrideinventory;
    }
    else
    {
        backpackinventory = br_default_inventory::snapshotbackpack();
    }
    
    self.var_76476d66e979cc4a = [];
    
    foreach ( item in backpackinventory )
    {
        ref = loot::function_f54ecb89dfab8e8c( item.lootid );
        scriptableref = level.br_pickups.var_5515c706eaccd3[ ref ];
        itemtype = undefined;
        
        if ( isdefined( scriptableref ) )
        {
            itemtype = level.br_pickups.br_itemtype[ scriptableref ];
        }
        
        if ( itemtype == #"plunder" )
        {
            totalcash += item.quantity;
            continue;
        }
        
        if ( isdefined( scriptableref ) && isdefined( itemtype ) )
        {
            cashvalue = level.br_pickups.br_value[ scriptableref ];
            
            if ( itemtype == #"dogtag" )
            {
                self.var_76476d66e979cc4a[ self.var_76476d66e979cc4a.size ] = item.quantity;
                value = level.br_pickups.br_value[ scriptableref ];
                totalcash += value;
                
                if ( !alreadyremoved )
                {
                    br_default_inventory::function_39f0833282ad6f6( item.index, item.quantity );
                }
                
                continue;
            }
            
            if ( !br_pickups::function_659a09a211112eaa( scriptableref ) )
            {
                if ( isdefined( cashvalue ) && isdefined( itemtype ) )
                {
                    if ( itemtype == #"valuable" || itemtype == #"personal" || itemtype == #"note" )
                    {
                        totalcash += cashvalue * item.quantity;
                    }
                }
                
                var_33a79b2c287b7771 = br_default_inventory::function_bb231745c730734d( scriptableref );
                
                if ( itemtype == #"valuable" && !var_33a79b2c287b7771 && !alreadyremoved )
                {
                    br_default_inventory::function_f0398a1e115d3553( item.lootid, item.quantity );
                }
            }
        }
    }
    
    totalcash += dmz_weapon_case::function_90286fea6c965c26( self );
    return totalcash;
}

// Namespace br_dmz_inventory
// Params 0
// Checksum 0xf1dc5072, Offset: 0xae7
// Size: 0x2e
function function_8acb6b99e9082011()
{
    if ( !isdefined( level.var_68164e28828be923 ) )
    {
        level.var_68164e28828be923 = getdvarint( @"hash_b3d354dab8da45d4", 0 );
    }
    
    return level.var_68164e28828be923;
}

// Namespace br_dmz_inventory
// Params 0
// Checksum 0x8b037572, Offset: 0xb1e
// Size: 0x2f
function function_2fd3b7be7693536b()
{
    if ( !isdefined( level.var_5dedefef7e34c2ed ) )
    {
        level.var_5dedefef7e34c2ed = getdvarint( @"hash_e28234d5ed130fb4", 1 );
    }
    
    return level.var_5dedefef7e34c2ed;
}

// Namespace br_dmz_inventory
// Params 0
// Checksum 0x86cc8468, Offset: 0xb56
// Size: 0xd1
function snapshotclipammo()
{
    items = [];
    
    if ( !isdefined( self.br_ammo ) )
    {
        return items;
    }
    
    foreach ( ammotype, count in self.br_ammo )
    {
        if ( count == 0 )
        {
            continue;
        }
        
        item = spawnstruct();
        item.lootid = loot::getlootidfromref( ammotype );
        item.quantity = count;
        items[ items.size ] = item;
    }
    
    return items;
}

// Namespace br_dmz_inventory
// Params 0
// Checksum 0xb7f74e90, Offset: 0xc30
// Size: 0x37c
function snapshotinventory()
{
    items = [];
    script::demoforcesre( "Removed a br_weapons function as br_weapons is deprecated. Add in common_item system logic instead to handle pastTeam and weapon metadata if this is used still" );
    inventoryweapons = br_default_inventory::getinventoryweapons( self );
    
    foreach ( weapon in inventoryweapons )
    {
        lootid = weapon::getweaponlootid( weapon );
        
        if ( lootid > 0 )
        {
            item = spawnstruct();
            item.lootid = lootid;
            item.quantity = 1;
            item.objweapon = weapon;
            items[ items.size ] = item;
        }
    }
    
    ref = equipment_mp::getcurrentequipment( "primary" );
    
    if ( isdefined( ref ) )
    {
        equipmentammo = equipment_mp::getequipmentslotammo( "primary" );
        lootid = loot::getlootidfromref( ref );
        
        if ( isdefined( lootid ) && equipmentammo > 0 )
        {
            item = spawnstruct();
            item.lootid = lootid;
            item.quantity = equipmentammo;
            items[ items.size ] = item;
        }
    }
    
    ref = equipment_mp::getcurrentequipment( "secondary" );
    
    if ( isdefined( ref ) )
    {
        equipmentammo = equipment_mp::getequipmentslotammo( "secondary" );
        lootid = loot::getlootidfromref( ref );
        
        if ( isdefined( lootid ) && equipmentammo > 0 )
        {
            item = spawnstruct();
            item.lootid = lootid;
            item.quantity = equipmentammo;
            items[ items.size ] = item;
        }
    }
    
    ref = equipment_mp::getcurrentequipment( "super" );
    ref = loot::function_c0c6b52344a55671( ref );
    equipmentammo = br::getsuperweapondisabledammobr();
    lootid = loot::getlootidfromref( ref );
    
    if ( isdefined( lootid ) && equipmentammo > 0 )
    {
        item = spawnstruct();
        item.lootid = lootid;
        item.quantity = equipmentammo;
        items[ items.size ] = item;
    }
    
    ref = killstreaks::getkillstreakinslot( 1 );
    
    if ( isdefined( ref ) )
    {
        lootid = loot::getlootidfromref( ref.streakname );
        
        if ( isdefined( lootid ) )
        {
            item = spawnstruct();
            item.lootid = lootid;
            item.quantity = 1;
            items[ items.size ] = item;
        }
    }
    
    if ( br_public::hasplatepouch() )
    {
        lootid = loot::getlootidfromref( "armor_satchel" );
        
        if ( isdefined( lootid ) )
        {
            item = spawnstruct();
            item.lootid = lootid;
            item.quantity = 1;
            items[ items.size ] = item;
        }
    }
    
    if ( gasmask::hasgasmask( self ) )
    {
        lootid = loot::getlootidfromref( "gas_mask" );
        
        if ( isdefined( lootid ) )
        {
            item = spawnstruct();
            item.lootid = lootid;
            item.quantity = 1;
            items[ items.size ] = item;
        }
    }
    
    itemname = self.equipment[ "health" ];
    itemcount = equipment_mp::getequipmentslotammo( "health" );
    
    if ( isdefined( itemname ) && isdefined( itemcount ) && itemcount > 0 )
    {
        item = spawnstruct();
        item.lootid = loot::getlootidfromref( level.armorref ?? "equip_armorplate" );
        item.quantity = itemcount;
        items[ items.size ] = item;
    }
    
    return items;
}

// Namespace br_dmz_inventory
// Params 3
// Checksum 0x284071b1, Offset: 0xfb5
// Size: 0x47
function function_fff200ec7c3a153d( classindex, weaponindex, ref )
{
    self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "weapon", ref );
}

// Namespace br_dmz_inventory
// Params 3
// Checksum 0x67c10d25, Offset: 0x1004
// Size: 0x47
function function_769ee45d8a280732( classindex, weaponindex, lootid )
{
    self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "lootItemID", lootid );
}

// Namespace br_dmz_inventory
// Params 2
// Checksum 0xd6383b4d, Offset: 0x1053
// Size: 0x1d9
function function_be4806daccb4a477( classindex, weaponindex )
{
    function_fff200ec7c3a153d( classindex, weaponindex, level.defaultfist.var_1616e6fbba9a722d );
    function_769ee45d8a280732( classindex, weaponindex, 0 );
    self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "camo", "none" );
    self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "reticle", "none" );
    self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "cosmeticAttachment", "none" );
    self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "variantID", 0 );
    self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "blueprintName", "" );
    
    for ( attachindex = 0; attachindex < 5 ; attachindex++ )
    {
        self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "attachmentSetup", attachindex, "attachment", "none" );
        self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "attachmentSetup", attachindex, "variantID", 0 );
    }
    
    for ( stickerindex = 0; stickerindex < 4 ; stickerindex++ )
    {
        self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "sticker", stickerindex, "sticker_none" );
    }
}

// Namespace br_dmz_inventory
// Params 3
// Checksum 0x4c18a117, Offset: 0x1234
// Size: 0x47
function function_f941e08a3b32d28b( classindex, equipindex, ref )
{
    self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "equipmentSetups", equipindex, "equipment", ref );
}

// Namespace br_dmz_inventory
// Params 2
// Checksum 0xd365eabb, Offset: 0x1283
// Size: 0x37
function function_9ebc81242a633383( index, ref )
{
    self setplayerdata( level.loadoutdata, "squadMembers", "killstreakSetups", index, "killstreak", ref );
}

// Namespace br_dmz_inventory
// Params 3
// Checksum 0x43e050a8, Offset: 0x12c2
// Size: 0x40
function function_5ed7daacb0c67271( classindex, superindex, ref )
{
    return self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "fieldUpgrades", superindex, ref );
}

// Namespace br_dmz_inventory
// Params 0
// Checksum 0x3b18a8a8, Offset: 0x130b
// Size: 0x4d
function clearloadout()
{
    function_be4806daccb4a477( 0, 0 );
    function_be4806daccb4a477( 0, 1 );
    function_f941e08a3b32d28b( 0, 0, "none" );
    function_f941e08a3b32d28b( 0, 1, "none" );
    function_5ed7daacb0c67271( 0, 0, "none" );
    function_9ebc81242a633383( 0, "none" );
}

// Namespace br_dmz_inventory
// Params 0
// Checksum 0x2e978726, Offset: 0x1360
// Size: 0x1a9
function function_549c622be488bd0c()
{
    weaponindex = 0;
    inventoryweapons = br_default_inventory::getinventoryweapons( self );
    
    foreach ( weapon in inventoryweapons )
    {
        if ( weaponindex > 1 )
        {
            continue;
        }
        
        rootname = weapon::getweaponrootname( weapon );
        lootid = weapon::getweaponlootid( weapon );
        function_fff200ec7c3a153d( 0, weaponindex, rootname );
        
        if ( !isdefined( lootid ) )
        {
            lootid = 0;
        }
        
        function_769ee45d8a280732( 0, weaponindex, lootid );
        weaponindex++;
    }
    
    ref = equipment_mp::getcurrentequipment( "primary" );
    equipmentammo = equipment_mp::getequipmentslotammo( "primary" );
    
    if ( isdefined( ref ) && equipmentammo > 0 )
    {
        function_f941e08a3b32d28b( 0, 0, ref );
    }
    
    ref = equipment_mp::getcurrentequipment( "secondary" );
    equipmentammo = equipment_mp::getequipmentslotammo( "secondary" );
    
    if ( isdefined( ref ) && equipmentammo > 0 )
    {
        function_f941e08a3b32d28b( 0, 1, ref );
    }
    
    ref = equipment_mp::getcurrentequipment( "super" );
    ref = loot::function_c0c6b52344a55671( ref );
    equipmentammo = br::getsuperweapondisabledammobr();
    
    if ( isdefined( ref ) && equipmentammo > 0 )
    {
        function_5ed7daacb0c67271( 0, 0, ref );
    }
    
    ref = killstreaks::getkillstreakinslot( 1 );
    
    if ( isdefined( ref ) )
    {
        function_9ebc81242a633383( 0, ref.streakname );
    }
}

// Namespace br_dmz_inventory
// Params 1
// Checksum 0x1e886aa4, Offset: 0x1511
// Size: 0x13e
function function_8cd50c5d893b2696( lootid )
{
    println( self.name + "<dev string:xae>" + "<dev string:xcc>" + lootid );
    
    if ( !isdefined( lootid ) )
    {
        return;
    }
    
    type = loot::function_52cf8374c44a4ff5( lootid );
    
    if ( !isdefined( type ) )
    {
        return;
    }
    
    ref = loot::function_f54ecb89dfab8e8c( lootid );
    
    switch ( type )
    {
        case #"hash_1cac65e1b8bf24a7":
        case #"hash_27124c6c97ccffa1":
        case #"hash_325cb2e66f67d5b9":
        case #"hash_339227cb650975db":
        case #"hash_511d3c24fcedcdb1":
        case #"hash_850999d7864fa3b4":
        case #"hash_93c71e7b6c0b81d7":
        case #"hash_ab671284a3fc4e3d":
        case #"hash_b60679835e82a584":
        case #"hash_e534fd8ec73eafb4":
            return;
        case #"hash_7d516d84d0a82f2":
            if ( isdefined( level.var_621f7bbf74943efa ) && isdefined( level.var_621f7bbf74943efa[ "onMatchStart" ] ) && isdefined( level.var_621f7bbf74943efa[ "onMatchStart" ][ ref ] ) )
            {
                [[ level.var_621f7bbf74943efa[ "onMatchStart" ][ ref ] ]]( self );
            }
            
            return;
    }
}

// Namespace br_dmz_inventory
// Params 1
// Checksum 0x279e7055, Offset: 0x1658
// Size: 0x12f
function function_3c9057a7d6fa327e( lootid )
{
    if ( !isdefined( lootid ) )
    {
        return;
    }
    
    type = loot::function_52cf8374c44a4ff5( lootid );
    ref = loot::function_f54ecb89dfab8e8c( lootid );
    
    switch ( type )
    {
        case #"hash_1cac65e1b8bf24a7":
        case #"hash_27124c6c97ccffa1":
        case #"hash_325cb2e66f67d5b9":
        case #"hash_339227cb650975db":
        case #"hash_511d3c24fcedcdb1":
        case #"hash_850999d7864fa3b4":
        case #"hash_93c71e7b6c0b81d7":
        case #"hash_ab671284a3fc4e3d":
        case #"hash_b60679835e82a584":
        case #"hash_e534fd8ec73eafb4":
            break;
        case #"hash_7d516d84d0a82f2":
            if ( isdefined( level.var_621f7bbf74943efa ) && isdefined( level.var_621f7bbf74943efa[ "onExtract" ] ) && isdefined( level.var_621f7bbf74943efa[ "onExtract" ][ ref ] ) )
            {
                [[ level.var_621f7bbf74943efa[ "onExtract" ][ ref ] ]]( self );
            }
            
            break;
    }
    
    if ( br_pickups::function_659a09a211112eaa( ref ) )
    {
        br_instance_inventory::function_cf3a7f7cf63fd736( self, lootid );
    }
}

