// scripts\mp\br\gametypes\br_weapons.gsc  (hash_2db0f4bfa718d997.gscc) (size: 6036 Bytes / 0x1794 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfca006fd (4238345981)
// size ...... 6036 (0x1794)
// includes .. 13  (offset: 0x158c)
// strings ... 28  (offset: 0x15f4)
// dev strs .. 0   (offset: 0x1794)
// exports ... 10  (offset: 0xf68)
// cseg ...... 0x2da + 0xc8e (0xf68)
// imports ... 39  (offset: 0x10f8)
// animtree1 . 0   (offset: 0x1794)
// animtree2 . 0   (offset: 0x1794)
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\common\utility\callback_group;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\flags;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_ammo;
#using scripts\mp\loot\common_item_weapon;

#namespace br_weapons;

// Namespace br_weapons
// Params 5
// Checksum 0xa9d18205, Offset: 0x2f8
// Size: 0x72
function weaponspawn( weaponobj, droppingplayer, dropinfo, firstspawn, showtrail )
{
    completeweaponname = getcompleteweaponname( weaponobj );
    weaponpickup = br_pickups::spawnpickup( completeweaponname, dropinfo, 0, showtrail, weaponobj, undefined, undefined, undefined );
    level.onweapondropcreated callback_group::callback_trigger( weaponpickup, droppingplayer, weaponobj );
    return weaponpickup;
}

// Namespace br_weapons
// Params 1
// Checksum 0xf0d7de2c, Offset: 0x373
// Size: 0x109
function function_e21fbe40c5ae575e( pickupent )
{
    if ( !isdefined( pickupent.weapon ) )
    {
        attachments = [];
        newweapon = undefined;
        
        if ( isdefined( pickupent.customweaponname ) )
        {
            completeweaponname = pickupent.customweaponname;
            newweapon = makeweaponfromstring( completeweaponname );
        }
        else if ( !isdefined( pickupent.completeweapon ) )
        {
            newweapon = br_pickups::getfullweaponobjforpickup( pickupent );
            completeweaponname = getcompleteweaponname( newweapon );
        }
        else
        {
            newweapon = weapon::buildweapon( pickupent.loadoutprimaryfullname, attachments, "camo_none", "none", -1 );
            completeweaponname = pickupent.loadoutprimaryfullname;
        }
        
        newweaponbasename = weapon::getweaponrootname( completeweaponname );
        weaponname = completeweaponname;
    }
    else
    {
        newweapon = pickupent.weapon;
        weaponname = getcompleteweaponname( newweapon );
        newweaponbasename = weapon::getweaponrootname( weaponname );
    }
    
    return [ newweapon, newweaponbasename, weaponname ];
}

// Namespace br_weapons
// Params 9
// Checksum 0xfe3c8731, Offset: 0x485
// Size: 0x11d
function br_forcegivecustomweapon( player, weaponobj, weaponfullname, weaponbasename, var_3680410241359e3a, var_c284d9620d27fd06, overrideorigin, metadata, pastteam )
{
    if ( common_item::items_isenabled() )
    {
        var_ceb6c50f374074a0 = item_weapon::function_f75620a38a24072();
        var_d6a4b79e04be953 = utility::callsharedfunc( #"game", #"hash_2d6603ce4710caa8", var_ceb6c50f374074a0 );
        
        if ( isdefined( var_d6a4b79e04be953 ) )
        {
            ammocount = common_item::function_598dd39282efb544( weaponclipsize( weaponobj ) );
            weapondata = { #itembundlename:var_d6a4b79e04be953, #var_3df5b0fceaf91931:1 };
            item = { #var_6828becb300b1c44:weapondata, #count:ammocount, #type:var_ceb6c50f374074a0, #weaponobj:weaponobj };
            player common_item::function_2b5e2ff57d5f392( item, 1, 1 );
            return 1;
        }
        
        return 0;
    }
}

// Namespace br_weapons
// Params 0
// Checksum 0xe6e66284, Offset: 0x5aa
// Size: 0x2
function br_ammo_init()
{
    
}

// Namespace br_weapons
// Params 0
// Checksum 0xffcfbdc6, Offset: 0x79d
// Size: 0x64
function br_ammo_player_init()
{
    
}

// Namespace br_weapons
// Params 0
// Checksum 0x11aa1932, Offset: 0x9c0
// Size: 0x137
function br_ammo_player_clear()
{
    if ( common_item::items_isenabled() )
    {
        if ( isdefined( self.ammostock ) )
        {
            foreach ( ammotype, ammocount in self.ammostock )
            {
                lootid = common_item::items_getlootidfromref( ammotype );
                common_inventory::function_476110daf7b2ce9b( lootid );
            }
        }
        
        return;
    }
    
    if ( br_gametypes::isfeaturedisabled( #"weapons" ) )
    {
        return;
    }
    
    foreach ( ammotype in level.br_ammo_types )
    {
        self.br_ammo[ ammotype ] = 0;
    }
    
    self notify( #"ammo_update" );
}

// Namespace br_weapons
// Params 0
// Checksum 0x58f01f4d, Offset: 0xaff
// Size: 0x146
function br_ammo_player_max_out()
{
    player = self;
    var_6ee44b03bc83d86e = [];
    allweaps = player getweaponslistprimaries();
    
    foreach ( weap in allweaps )
    {
        ammotype = br_ammo_type_for_weapon( weap );
        
        if ( isdefined( ammotype ) )
        {
            var_6ee44b03bc83d86e[ ammotype ] = "dummy_value";
            ammoclipsize = weaponclipsize( weap );
            player setweaponammoclip( weap, ammoclipsize );
        }
    }
    
    foreach ( ammotype, unused in var_6ee44b03bc83d86e )
    {
        player.br_ammo[ ammotype ] = level.br_ammo_max_stock[ ammotype ];
    }
}

// Namespace br_weapons
// Params 5
// Checksum 0x273d6a3d, Offset: 0xc4d
// Size: 0x230
function br_ammo_give_type( player, ammotype, amount, dropleftovers, var_d9f9541680bd9bee = 1 )
{
    if ( level.br_ammo_max.size == 0 )
    {
        return 0;
    }
    
    if ( !isdefined( dropleftovers ) )
    {
        dropleftovers = 0;
    }
    
    if ( !isdefined( ammotype ) )
    {
        script::demoforcesre( "br_ammo_give_type - ammoType undefined" );
        return;
    }
    
    if ( !isdefined( player.br_ammo ) )
    {
        message = "br_ammo_give_type - player.br_ammo undefined";
        message += "; ammoType: " + ammotype;
        message += "; isPrematchDone: " + flags::gameflag( "prematch_done" );
        message += "; isCodcaster: " + player iscodcaster();
        message += "; isSpectating: " + player isspectatinganyone();
        message += "; playerName: " + player.name;
        script::demoforcesre( message );
        return;
    }
    
    if ( !isdefined( player.br_ammo[ ammotype ] ) )
    {
        script::demoforcesre( "br_ammo_give_type - player.br_ammo[ ammoType ] undefined for " + ammotype );
        return;
    }
    
    if ( !isdefined( level.br_ammo_max[ ammotype ] ) )
    {
        script::demoforcesre( "br_ammo_give_type - level.br_ammo_max is missing ammoType: " + ammotype );
    }
    
    leftoveramount = 0;
    player.br_ammo[ ammotype ] += amount;
    
    if ( player.br_ammo[ ammotype ] > level.br_ammo_max[ ammotype ] )
    {
        leftoveramount = player.br_ammo[ ammotype ] - level.br_ammo_max[ ammotype ];
        
        if ( common_inventory::function_7ec5937e3b3d86e0( ammotype ) )
        {
            var_39c18626374a43e5 = leftoveramount;
            
            if ( !var_d9f9541680bd9bee )
            {
                missingammo = player common_inventory::function_46997c9dfcd0ef43( ammotype );
                var_39c18626374a43e5 = int( min( leftoveramount, missingammo ) );
            }
            
            lootid = loot::function_d3e3bcaea591a6a2( ammotype );
            player common_inventory::function_d3959596f4031a1d( lootid, var_39c18626374a43e5 );
            leftoveramount -= var_39c18626374a43e5;
        }
        else if ( !dropleftovers && leftoveramount < level.br_ammo_clipsize[ ammotype ] )
        {
            leftoveramount = 0;
        }
        
        player.br_ammo[ ammotype ] = level.br_ammo_max[ ammotype ];
    }
    
    return leftoveramount;
}

// Namespace br_weapons
// Params 1
// Checksum 0x11dd227c, Offset: 0xe86
// Size: 0xe1
function br_ammo_type_for_weapon( weapon )
{
    if ( utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
    {
        return item_ammo::function_b162feeed34a4640( weapon );
    }
    
    weapclass = undefined;
    
    if ( weapon::function_33e74163843b348e( weapon ) )
    {
        return;
    }
    else if ( weapon.isalternate && function_46ec0ebc88b3a6fc( weapon ) )
    {
        underbarrel = weapon.underbarrel;
        
        if ( isdefined( underbarrel ) && function_b7037bc0cf5c7a82( weapon ) )
        {
            return "brloot_ammo_12g";
        }
        else if ( weapon.classname == "throwingknife" )
        {
            return;
        }
        else
        {
            weapclass = "weapon_projectile";
        }
    }
    else if ( weapon::issuperuseweapon( weapon ) )
    {
        return;
    }
    else
    {
        weapclass = weapon::getbaseweapongroup( weapon );
        
        if ( !isdefined( weapclass ) )
        {
            return;
        }
    }
    
    return level.var_2798bdeb35f6389d[ weapclass ];
}

