// scripts\mp\loot\common_item_ammo.gsc  (hash_68c3bade6f0d4d53.gscc) (size: 15145 Bytes / 0x3b29 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5eeb9a5b (1592498779)
// size ...... 15145 (0x3b29)
// includes .. 10  (offset: 0x3921)
// strings ... 22  (offset: 0x3971)
// dev strs .. 4   (offset: 0x3af9)
// exports ... 41  (offset: 0x2585)
// cseg ...... 0x280 + 0x2305 (0x2585)
// imports ... 105 (offset: 0x2bed)
// animtree1 . 0   (offset: 0x3b29)
// animtree2 . 0   (offset: 0x3b29)
#using scripts\common\callbacks;
#using scripts\common\dev;
#using scripts\common\string;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\dmz\modified_values;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_inventory_groups;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;

#namespace item_ammo;

// Namespace item_ammo
// Params 0, eflags: 0x5
// Checksum 0xd4d9f7c8, Offset: 0x29e
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"item_ammo", #"common_item", &init_item_ammo, &post_init_item_ammo );
}

// Namespace item_ammo
// Params 0
// Checksum 0xc8895e96, Offset: 0x2cb
// Size: 0x16f
function init_item_ammo()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    level.var_9a6a4b42eba220f6 = [];
    
    if ( isdefined( level.init_item_ammo_override ) )
    {
        [[ level.init_item_ammo_override ]]();
    }
    else
    {
        common_item::function_4b30c091d3b04a25( "ammo" );
        common_item::function_84174b793b5fe9a7( "ammo", #"use", &function_fd3c87baab9eedaf );
        common_item::function_84174b793b5fe9a7( "ammo", #"hash_9e49dfaa7c147654", &function_b50569e72cb85739 );
        common_item::function_84174b793b5fe9a7( "ammo", #"canautouse", &function_42d729879edb5ba0 );
        common_item::function_84174b793b5fe9a7( "ammo", #"hash_e2da6c78fc49f200", &function_8e04ccac15648db9 );
        common_item::function_84174b793b5fe9a7( "ammo", #"hash_3459376aa4403b66", &function_bc44ebafb97454a0 );
        common_item::function_84174b793b5fe9a7( "ammo", #"database_additem", &function_87d214afcb21b724 );
        callback::add( #"player_connect", &function_98ca9e69b4af4858 );
        callback::add( #"reload", &function_bfcdd6e7049ff664 );
        callback::add( #"hash_89555462d4b2ee9f", &function_244ce90aef950bf2 );
    }
    
    utility::registersharedfunc( #"ammo", #"hash_30840cd0519b8713", &function_46e5ccf39665fcf4 );
    utility::registersharedfunc( #"ammo", #"hash_f3333d9b5f4eebfb", &function_332f9bae9ef3343c );
    
    /#
        level thread dev::devcommandwatcher( @"hash_467e788c512b1c44", &items_ammo_debug );
    #/
}

// Namespace item_ammo
// Params 0
// Checksum 0x56acd123, Offset: 0x442
// Size: 0x15
function post_init_item_ammo()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    level thread function_66868d100f71d6d9();
}

// Namespace item_ammo
// Params 5
// Checksum 0x3f55aa05, Offset: 0x45f
// Size: 0x20b
function function_fd3c87baab9eedaf( itembundle, item, autouse, var_981c264073bf1154, frominventory )
{
    if ( itembundle.subtype == "generic" )
    {
        if ( self.hasfullammo )
        {
            return item.count;
        }
        
        ammomod = undefined;
        
        if ( !frominventory )
        {
            if ( item.aidropped && isdefined( self.perks[ "specialty_trait_ai_ammo" ] ) && isdefined( level.perkbundles[ "specialty_trait_ai_ammo" ] ) )
            {
                perkbundle = level.perkbundles[ "specialty_trait_ai_ammo" ];
                ammomod = perkbundle.aiammomod ?? 2;
            }
            
            ammomod = modified_values::function_14d05d73e63e1f9e( 0, ammomod );
        }
        
        amountused = function_5b3e00ec8cebdbea( itembundle, ammomod, undefined, undefined, item.count );
        remainingammo = item.count - ( amountused ?? 0 );
        
        if ( remainingammo <= 0 )
        {
            item.var_fbb504183990fc9f = 1;
        }
        
        return remainingammo;
    }
    
    if ( function_fdb7ca5c724bcb5c() )
    {
        return item.count;
    }
    
    ammoleft = item.count;
    ammoleft = function_eddb74b551d3fe1f( self.currentprimaryweapon, itembundle, ammoleft );
    
    if ( ammoleft == 0 )
    {
        return 0;
    }
    
    primary_weapons = self getweaponslist( "primary" );
    
    foreach ( primary_weapon in primary_weapons )
    {
        ammoleft = function_eddb74b551d3fe1f( primary_weapon, itembundle, ammoleft );
        
        if ( ammoleft == 0 )
        {
            return 0;
        }
    }
    
    return ammoleft;
}

// Namespace item_ammo
// Params 4
// Checksum 0x942425bf, Offset: 0x673
// Size: 0x33
function function_b50569e72cb85739( itembundle, item, autouse, allowswap )
{
    return function_42d729879edb5ba0( itembundle, item, autouse, allowswap );
}

// Namespace item_ammo
// Params 4
// Checksum 0xa0becf83, Offset: 0x6af
// Size: 0x1ac, Type: bool
function function_42d729879edb5ba0( itembundle, item, autouse, allowswap )
{
    if ( function_fdb7ca5c724bcb5c() )
    {
        return false;
    }
    
    primary_weapons = self getweaponslist( "primary" );
    
    foreach ( primary_weapon in primary_weapons )
    {
        relevant_weapons = [ primary_weapon ];
        
        if ( function_46ec0ebc88b3a6fc( primary_weapon ) )
        {
            relevant_weapons[ relevant_weapons.size ] = primary_weapon getaltweapon();
        }
        
        foreach ( weapon in relevant_weapons )
        {
            current_ammo_type = function_b162feeed34a4640( weapon );
            
            if ( current_ammo_type == itembundle.ref || isdefined( current_ammo_type ) && itembundle.subtype == "generic" )
            {
                currentammo = function_44b52f17768fb1c6( self, weapon );
                maxstock = function_9aecfd8b12f7ed0e( weapon, current_ammo_type );
                
                if ( currentammo < maxstock )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace item_ammo
// Params 1
// Checksum 0xd653e548, Offset: 0x864
// Size: 0x150
function function_b162feeed34a4640( primary_weapon )
{
    if ( primary_weapon.ismelee )
    {
        return;
    }
    
    var_5d32055da4025670 = function_5d32055da4025670( primary_weapon );
    weapon_class = string::function_63338a5831bf61d9( var_5d32055da4025670 ) ? primary_weapon.classname : var_5d32055da4025670;
    
    switch ( weapon_class )
    {
        case #"hash_719417cb1de832b6":
        case #"hash_900cb96c552c5e8e":
        case #"hash_cc131451bc90bd5c":
            return "brloot_ammo_919";
        case #"hash_690c0d6a821b42e":
        case #"hash_23209741b93850b5":
            return "brloot_ammo_12g";
        case #"hash_2f2d546c2247838f":
        case #"hash_8cdaf2e4ecfe5b51":
        case #"hash_d4f05e450448c3ec":
            return "brloot_ammo_762";
        case #"hash_6191aaef9f922f96":
        case #"hash_f4b0076c03d93738":
            return "brloot_ammo_50cal";
        case #"hash_61e969dacaaf9881":
        case #"hash_c5a1525ba35389fa":
        case #"hash_e224d0b635d0dadd":
            return "brloot_ammo_rocket";
        case #"hash_ceb3b5150f04b677":
            return;
    }
    
    /#
        if ( !getdvarint( @"hash_cb700a07e4870c57", 0 ) )
        {
            println( "<dev string:x24>" + weapon_class + "<dev string:x4c>" );
        }
    #/
    
    return "brloot_ammo_762";
}

// Namespace item_ammo
// Params 0
// Checksum 0x66abb2f9, Offset: 0x9bd
// Size: 0x4e
function function_66fcda3aac586229()
{
    if ( !isdefined( level.ammotypes ) )
    {
        level.ammotypes = [ "brloot_ammo_919", "brloot_ammo_12g", "brloot_ammo_762", "brloot_ammo_50cal", "brloot_ammo_rocket" ];
    }
    
    return level.ammotypes;
}

// Namespace item_ammo
// Params 0
// Checksum 0xbd8e2c9a, Offset: 0xa14
// Size: 0xe
function function_dbd260599742cbb3()
{
    return utility::array_random( function_66fcda3aac586229() );
}

// Namespace item_ammo
// Params 1
// Checksum 0x3b4e552a, Offset: 0xa2b
// Size: 0x102
function function_34507cb26eeaa577( weapongroup )
{
    if ( !isdefined( level.var_fb849aec368cdc2e ) )
    {
        level.var_fb849aec368cdc2e = [];
        level.var_fb849aec368cdc2e[ "weapon_machine_pistol" ] = "brloot_ammo_919";
        level.var_fb849aec368cdc2e[ "weapon_pistol" ] = "brloot_ammo_919";
        level.var_fb849aec368cdc2e[ "weapon_smg" ] = "brloot_ammo_919";
        level.var_fb849aec368cdc2e[ "weapon_shotgun" ] = "brloot_ammo_12g";
        level.var_fb849aec368cdc2e[ "weapon_assault" ] = "brloot_ammo_762";
        level.var_fb849aec368cdc2e[ "weapon_battle" ] = "brloot_ammo_762";
        level.var_fb849aec368cdc2e[ "weapon_lmg" ] = "brloot_ammo_762";
        level.var_fb849aec368cdc2e[ "weapon_dmr" ] = "brloot_ammo_50cal";
        level.var_fb849aec368cdc2e[ "weapon_sniper" ] = "brloot_ammo_50cal";
        level.var_fb849aec368cdc2e[ "weapon_projectile" ] = "brloot_ammo_rocket";
    }
    
    return level.var_fb849aec368cdc2e[ weapongroup ];
}

// Namespace item_ammo
// Params 3
// Checksum 0xe58be644, Offset: 0xb36
// Size: 0x117
function function_eddb74b551d3fe1f( primary_weapon, itembundle, ammoleft )
{
    relevant_weapons = [ primary_weapon ];
    
    if ( function_46ec0ebc88b3a6fc( primary_weapon ) )
    {
        relevant_weapons[ relevant_weapons.size ] = primary_weapon getaltweapon();
    }
    
    foreach ( weapon in relevant_weapons )
    {
        current_ammo_type = function_b162feeed34a4640( weapon );
        remainder = ammoleft;
        
        if ( current_ammo_type == itembundle.ref )
        {
            currentammo = function_44b52f17768fb1c6( self, weapon );
            maxammo = function_9aecfd8b12f7ed0e( weapon, current_ammo_type );
            
            if ( currentammo < maxammo )
            {
                remainder = function_d668d164f515b571( self, weapon, ammoleft );
            }
        }
    }
    
    return remainder;
}

// Namespace item_ammo
// Params 6
// Checksum 0x82cacf1d, Offset: 0xc56
// Size: 0x446
function function_5b3e00ec8cebdbea( var_72a52e8e2e38f966, amountmod = 1, givemax, var_f245f9487000b77a = 1, itemcount, var_d6c62c6097bb8e5b = 0 )
{
    primary_weapons = self getweaponslist( "primary" );
    var_4c48fad50fa1fc28 = [];
    var_3b4cc536291599bb = 0;
    
    foreach ( primary_weapon in primary_weapons )
    {
        if ( primary_weapon.ismelee )
        {
            continue;
        }
        
        relevant_weapons = [ primary_weapon ];
        
        if ( function_46ec0ebc88b3a6fc( primary_weapon ) )
        {
            relevant_weapons[ relevant_weapons.size ] = primary_weapon getaltweapon();
        }
        
        if ( var_d6c62c6097bb8e5b )
        {
            item_weapon::function_165956c3013b4abf( primary_weapon );
        }
        
        foreach ( weapon in relevant_weapons )
        {
            ammotype = function_b162feeed34a4640( weapon );
            maxammo = function_9aecfd8b12f7ed0e( weapon, ammotype );
            currentstock = function_44b52f17768fb1c6( self, weapon );
            var_6a61f0d63731fb7c = maxammo - currentstock;
            var_43985a7b592b1702 = 0;
            var_67a5f90c22427c2e = 0;
            
            if ( givemax )
            {
                var_43985a7b592b1702 = maxammo;
            }
            else if ( var_72a52e8e2e38f966.var_d79d09312355832e && var_72a52e8e2e38f966.var_d79d09312355832e.size )
            {
                foreach ( ammodata in var_72a52e8e2e38f966.var_d79d09312355832e )
                {
                    if ( ammotype == ammodata.ammotype )
                    {
                        var_67a5f90c22427c2e = ammodata.ammocount ?? 1;
                        
                        if ( var_72a52e8e2e38f966.var_2b0a27d4be7d298b && isdefined( itemcount ) )
                        {
                            var_43985a7b592b1702 = var_67a5f90c22427c2e * itemcount / var_72a52e8e2e38f966.maxcount;
                        }
                        
                        break;
                    }
                }
            }
            else if ( isdefined( ammotype ) && isdefined( level.var_d157a47d96f8c663 ) && isdefined( level.var_d157a47d96f8c663[ ammotype ] ) )
            {
                var_43985a7b592b1702 = level.var_d157a47d96f8c663[ ammotype ];
            }
            
            missingammo = ( 1 - currentstock / maxammo ) * 100 * ( var_72a52e8e2e38f966.var_e236651e9acd1c9e ?? 1 );
            
            if ( utility::percent_chance( missingammo ) )
            {
                var_43985a7b592b1702 *= var_72a52e8e2e38f966.var_ad80b6ef390a5fda ?? 2;
            }
            
            if ( var_43985a7b592b1702 <= 0 )
            {
                continue;
            }
            
            var_43985a7b592b1702 = int( min( var_6a61f0d63731fb7c, var_43985a7b592b1702 * amountmod ) );
            
            if ( var_43985a7b592b1702 > 0 )
            {
                function_d668d164f515b571( self, weapon, var_43985a7b592b1702 );
                
                if ( var_67a5f90c22427c2e > 0 && isdefined( itemcount ) )
                {
                    var_ef20ec3b4d95e31d = int( ceil( var_72a52e8e2e38f966.maxcount * var_43985a7b592b1702 / ( var_67a5f90c22427c2e ?? 1 ) ) );
                    
                    if ( var_ef20ec3b4d95e31d > var_3b4cc536291599bb )
                    {
                        var_3b4cc536291599bb = var_ef20ec3b4d95e31d;
                    }
                }
                
                fakepickup = spawnstruct();
                fakepickup.count = var_43985a7b592b1702;
                fakepickup.ref = function_b162feeed34a4640( weapon );
                var_4c48fad50fa1fc28[ var_4c48fad50fa1fc28.size ] = fakepickup;
            }
        }
    }
    
    if ( var_f245f9487000b77a && utility::issharedfuncdefined( #"game", #"showStockLootFeed" ) && var_4c48fad50fa1fc28.size > 0 )
    {
        level thread [[ utility::getsharedfunc( #"game", #"showStockLootFeed" ) ]]( self, var_4c48fad50fa1fc28 );
    }
    
    return var_3b4cc536291599bb;
}

// Namespace item_ammo
// Params 4
// Checksum 0x5d9b28ad, Offset: 0x10a5
// Size: 0xc2
function function_609174a0a64a03a( weapon, var_cdbc3c3d5f273793, ammoamount, numclips )
{
    ammotype = function_b162feeed34a4640( weapon );
    
    if ( !isdefined( ammotype ) )
    {
        return;
    }
    
    if ( var_cdbc3c3d5f273793 )
    {
        maxammo = function_9aecfd8b12f7ed0e( weapon, ammotype );
        return { #count:common_item::function_598dd39282efb544( maxammo ), #type:ammotype };
    }
    
    if ( !isdefined( ammoamount ) )
    {
        if ( !isdefined( numclips ) )
        {
            println( "<dev string:x82>" );
            return;
        }
        
        ammoamount = numclips * level.var_d157a47d96f8c663[ ammotype ];
    }
    
    return { #count:common_item::function_598dd39282efb544( ammoamount ), #type:ammotype };
}

// Namespace item_ammo
// Params 6
// Checksum 0xb5bf9bc, Offset: 0x1170
// Size: 0xb7
function function_46e5ccf39665fcf4( weapon, autouse, dropextra, var_cdbc3c3d5f273793, ammoamount, numclips )
{
    ammoitem = function_609174a0a64a03a( weapon, var_cdbc3c3d5f273793, ammoamount, numclips );
    
    if ( !isdefined( ammoitem ) )
    {
        return;
    }
    
    ammogiven = common_item::function_96119bed8ab4c5d9( ammoitem, autouse );
    remainder = ammoitem.count - ammogiven;
    
    if ( dropextra && remainder > 0 )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
        common_item::function_325e28c0fb65c36a( ammoitem.type, remainder, spawnoptions );
    }
}

// Namespace item_ammo
// Params 6
// Checksum 0xec5cc1a4, Offset: 0x122f
// Size: 0x215
function function_332f9bae9ef3343c( weapons, autouse, dropextra, var_cdbc3c3d5f273793, ammoamount, numclips )
{
    var_caefc8741c525dd0 = [];
    var_4c48fad50fa1fc28 = [];
    
    foreach ( weapon in weapons )
    {
        if ( !isdefined( weapon ) || isnullweapon( weapon ) )
        {
            continue;
        }
        
        ammoitem = function_609174a0a64a03a( weapon, var_cdbc3c3d5f273793, ammoamount, numclips );
        
        if ( isdefined( ammoitem.type ) && !isdefined( var_caefc8741c525dd0[ ammoitem.type ] ) )
        {
            var_caefc8741c525dd0[ ammoitem.type ] = ammoitem;
        }
    }
    
    foreach ( ammoitem in var_caefc8741c525dd0 )
    {
        if ( !isdefined( ammoitem ) )
        {
            continue;
        }
        
        ammogiven = common_item::function_96119bed8ab4c5d9( ammoitem, autouse );
        remainder = ammoitem.count - ammogiven;
        
        if ( ammogiven > 0 )
        {
            fakepickup = { #count:ammogiven, #ref:ammoitem.type };
            var_4c48fad50fa1fc28[ var_4c48fad50fa1fc28.size ] = fakepickup;
        }
        
        if ( dropextra && remainder > 0 )
        {
            spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
            common_item::function_325e28c0fb65c36a( ammoitem.type, remainder, spawnoptions );
        }
    }
    
    return var_4c48fad50fa1fc28;
}

// Namespace item_ammo
// Params 5
// Checksum 0x3a1c707b, Offset: 0x144d
// Size: 0x4f
function function_a530c73bf2e2b013( autouse, dropextra, var_cdbc3c3d5f273793, ammoamount, numclips )
{
    weapons = self getweaponslistprimaries();
    return function_332f9bae9ef3343c( weapons, autouse, dropextra, var_cdbc3c3d5f273793, ammoamount, numclips );
}

// Namespace item_ammo
// Params 2, eflags: 0x4
// Checksum 0x2ec5b4e1, Offset: 0x14a5
// Size: 0x29c
function private function_c7f4ec614f7088c9( player, weaponobj )
{
    if ( !common_inventory::inventory_isenabled() )
    {
        return;
    }
    
    ammotype = function_b162feeed34a4640( weaponobj );
    
    if ( !isdefined( ammotype ) )
    {
        return;
    }
    
    lootid = common_item::function_cb980b90c836804e( ammotype );
    sortedammo = player common_inventory::function_4436b2f08e588b8( lootid );
    
    foreach ( index in sortedammo )
    {
        weaponammo = function_44b52f17768fb1c6( player, weaponobj );
        maxammo = player function_9aecfd8b12f7ed0e( weaponobj, ammotype );
        backpackammo = common_inventory::inventory_getquantityatbackpackindex( index );
        
        if ( weaponammo < maxammo )
        {
            var_fdb0a8cace6cac30 = backpackammo - weaponammo;
            
            if ( var_fdb0a8cace6cac30 > 0 )
            {
                remainder = function_d668d164f515b571( player, weaponobj, var_fdb0a8cace6cac30 );
                backpackammo -= var_fdb0a8cace6cac30 - remainder;
                player common_inventory::inventory_setbackpackitematindex( index, lootid, backpackammo );
                
                if ( backpackammo > 0 )
                {
                    break;
                }
            }
        }
    }
    
    if ( level.var_e9d733627b29a6 )
    {
        genericlootid = common_item::items_getlootidfromref( level.var_e9d733627b29a6 );
        genericammo = player common_inventory::function_4436b2f08e588b8( genericlootid );
        
        if ( genericammo && genericammo.size )
        {
            var_f97b4a8100e20ee5 = common_item::function_b202b16941992cca( genericlootid, [ #"subtype", #"hash_557e5fe243407be9", #"hash_4ca245f1591b2f32", #"hash_35a6ff448ffc0318", #"maxcount" ] );
            
            foreach ( index in genericammo )
            {
                quantity = common_inventory::inventory_getquantityatbackpackindex( index );
                amountremaining = player function_fd3c87baab9eedaf( var_f97b4a8100e20ee5, { #count:quantity }, undefined, undefined, 1 );
                
                if ( !amountremaining )
                {
                    player common_inventory::inventory_setbackpackitematindex( index, 0, 0 );
                    continue;
                }
                
                player common_inventory::function_bae25ae0b487a249( index, amountremaining );
            }
        }
    }
}

// Namespace item_ammo
// Params 1
// Checksum 0x93fee67, Offset: 0x1749
// Size: 0x13
function function_98ca9e69b4af4858( params )
{
    thread function_7cfb4aa359e3cf8b();
}

// Namespace item_ammo
// Params 0
// Checksum 0x9c3d022e, Offset: 0x1764
// Size: 0x44
function function_66868d100f71d6d9()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"connected", player );
        player thread function_7cfb4aa359e3cf8b();
    }
}

// Namespace item_ammo
// Params 0
// Checksum 0x97c0dbb, Offset: 0x17b0
// Size: 0xbc
function function_7cfb4aa359e3cf8b()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( isdefined( self.ammostock ) )
    {
        return;
    }
    
    self.ammostock = [];
    utility::flag_wait( "items_database_init" );
    
    foreach ( ammoref, maxstock in level.var_9a6a4b42eba220f6 )
    {
        self.ammostock[ ammoref ] = maxstock;
    }
}

// Namespace item_ammo
// Params 1
// Checksum 0xd87f2cd8, Offset: 0x1874
// Size: 0xde
function function_bfcdd6e7049ff664( params )
{
    profilestart();
    player = params.player;
    weaponobj = player getcurrentweapon();
    
    if ( level.gametypebundle.var_b861684883c8d831 )
    {
        if ( function_fdb7ca5c724bcb5c() )
        {
            ammotype = function_b162feeed34a4640( weaponobj );
            maxammo = player function_9aecfd8b12f7ed0e( weaponobj, ammotype );
            currentstock = function_44b52f17768fb1c6( player, weaponobj );
            var_6a61f0d63731fb7c = maxammo - currentstock;
            function_d668d164f515b571( player, weaponobj, var_6a61f0d63731fb7c );
        }
        else
        {
            player setweaponammostock( weaponobj, weaponmaxammo( weaponobj ) );
        }
    }
    else
    {
        if ( function_54c12856313814d5() )
        {
            function_d06447d50fdcdeda( player, weaponobj, player getweaponammostock( weaponobj ) );
        }
        
        function_c7f4ec614f7088c9( player, weaponobj );
    }
    
    profilestop();
}

// Namespace item_ammo
// Params 1
// Checksum 0x37dc20e2, Offset: 0x195a
// Size: 0xf0
function function_87d214afcb21b724( itembundlename )
{
    itembundle = getscriptbundlefieldvalues( itembundlename, [ #"maxcount", #"ref", #"spawncount", #"subtype" ] );
    
    if ( !( isdefined( itembundle.maxcount ) && isdefined( itembundle.ref ) ) )
    {
        return;
    }
    
    level.var_9a6a4b42eba220f6[ itembundle.ref ] = itembundle.maxcount;
    level.var_d157a47d96f8c663[ itembundle.ref ] = itembundle.spawncount ?? 1;
    
    if ( itembundle.subtype == "generic" && !level.var_e9d733627b29a6 )
    {
        level.var_e9d733627b29a6 = itembundle.ref;
    }
}

// Namespace item_ammo
// Params 0
// Checksum 0xf0dc168a, Offset: 0x1a52
// Size: 0x43
function function_db162c4f4d0277d5()
{
    if ( !isdefined( level.var_e1d53476d18ea997 ) )
    {
        level.var_e1d53476d18ea997 = utility::function_edc4cc03e9e60b3e( @"hash_a0e9691c0b482b75", 0, level.gametypebundle.var_e1d53476d18ea997 );
    }
    
    return level.var_e1d53476d18ea997;
}

// Namespace item_ammo
// Params 0
// Checksum 0x6ecbbe93, Offset: 0x1a9e
// Size: 0x13, Type: bool
function function_54c12856313814d5()
{
    return function_db162c4f4d0277d5() && !function_fdb7ca5c724bcb5c();
}

// Namespace item_ammo
// Params 1
// Checksum 0xdf0d8241, Offset: 0x1aba
// Size: 0x5e
function function_bc44ebafb97454a0( itembundle )
{
    if ( itembundle.subtype == "generic" )
    {
        return itembundle.maxcount;
    }
    
    ammoref = itembundle.ref;
    
    if ( function_fdb7ca5c724bcb5c() )
    {
        return function_2041497ddcff6b3e( self, ammoref );
    }
    
    return function_3bb829269a94bef8( ammoref );
}

// Namespace item_ammo
// Params 2
// Checksum 0xcbab982a, Offset: 0x1b21
// Size: 0xbe
function function_9aecfd8b12f7ed0e( weapon, ammoref = function_b162feeed34a4640( weapon ) )
{
    assert( !isdefined( ammoref ) || ammoref == function_b162feeed34a4640( weapon ), "<dev string:xdd>" );
    var_482e9999b75ed3d8 = istrue( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_z_mod", #"z_mod_pack_mule" ) );
    maxammo = utility::get_max_stock_ammo( weapon, var_482e9999b75ed3d8 );
    
    if ( function_54c12856313814d5() )
    {
        if ( !isdefined( ammoref ) )
        {
            return maxammo;
        }
        
        return function_3bb829269a94bef8( ammoref );
    }
    else if ( function_fdb7ca5c724bcb5c() )
    {
        return function_2041497ddcff6b3e( self, ammoref );
    }
    
    return maxammo;
}

// Namespace item_ammo
// Params 1, eflags: 0x4
// Checksum 0xb8b806fa, Offset: 0x1be8
// Size: 0x5c
function private function_3bb829269a94bef8( ammoref )
{
    if ( !isdefined( ammoref ) )
    {
        return 0;
    }
    
    additionalstock = 0;
    
    if ( isdefined( self.var_2666d61566849451 ) && self.var_2666d61566849451[ ammoref ] )
    {
        additionalstock = self.var_2666d61566849451[ ammoref ];
    }
    
    return level.var_9a6a4b42eba220f6[ ammoref ] + additionalstock;
}

// Namespace item_ammo
// Params 2
// Checksum 0xeae1c8ca, Offset: 0x1c4d
// Size: 0x52
function function_44b52f17768fb1c6( player, weapon )
{
    if ( function_54c12856313814d5() )
    {
        ammoref = function_b162feeed34a4640( weapon );
        
        if ( !isdefined( ammoref ) )
        {
            return player getweaponammostock( weapon );
        }
        
        return function_7a3786a6d12362bd( player, ammoref );
    }
    
    return player getweaponammostock( weapon );
}

// Namespace item_ammo
// Params 2, eflags: 0x4
// Checksum 0x4cf4e4c7, Offset: 0x1ca8
// Size: 0x2c
function private function_7a3786a6d12362bd( player, ammoref )
{
    if ( !isdefined( ammoref ) )
    {
        return 0;
    }
    
    return player.ammostock[ ammoref ];
}

// Namespace item_ammo
// Params 2
// Checksum 0xbac5c896, Offset: 0x1cdd
// Size: 0x3d
function function_f01abfab49a719a0( player, weapon )
{
    if ( !function_fdb7ca5c724bcb5c() )
    {
        return;
    }
    
    ammotype = function_b162feeed34a4640( weapon );
    return function_925e40db4bc1e2fe( player, ammotype );
}

// Namespace item_ammo
// Params 2
// Checksum 0xf1dd7d19, Offset: 0x1d23
// Size: 0x46
function function_925e40db4bc1e2fe( player, ammotype )
{
    if ( !function_fdb7ca5c724bcb5c() )
    {
        return;
    }
    
    lootid = common_item::function_cb980b90c836804e( ammotype );
    
    if ( !isdefined( lootid ) )
    {
        return 0;
    }
    
    return player common_inventory::function_99741e85ee9c3d18( lootid );
}

// Namespace item_ammo
// Params 2, eflags: 0x4
// Checksum 0x222a030d, Offset: 0x1d72
// Size: 0x85
function private function_2041497ddcff6b3e( player, ammotype )
{
    if ( !function_fdb7ca5c724bcb5c() )
    {
        return 0;
    }
    
    maxammostock = function_3bb829269a94bef8( ammotype );
    var_1062579f788dbad6 = level.backpackupgrades[ ammotype ];
    
    if ( isdefined( var_1062579f788dbad6 ) )
    {
        hasupgrade = isdefined( player.backpackupgrades.var_9f469e8d2bc259d[ ammotype ] );
        maxammostock -= hasupgrade ? 0 : var_1062579f788dbad6;
    }
    
    return maxammostock;
}

// Namespace item_ammo
// Params 3
// Checksum 0x73c7cd53, Offset: 0x1e00
// Size: 0x40
function function_d668d164f515b571( player, weapon, incrementamount )
{
    currentstock = function_44b52f17768fb1c6( player, weapon );
    return function_d06447d50fdcdeda( player, weapon, incrementamount + currentstock );
}

// Namespace item_ammo
// Params 4
// Checksum 0xd045f3f0, Offset: 0x1e49
// Size: 0xd8
function function_d06447d50fdcdeda( player, weapon, count, maxstock )
{
    ammoref = function_b162feeed34a4640( weapon );
    
    if ( !isdefined( ammoref ) )
    {
        return count;
    }
    
    if ( function_54c12856313814d5() && !isdefined( player.ammostock[ ammoref ] ) )
    {
        player.ammostock[ ammoref ] = 0;
    }
    
    if ( !isdefined( maxstock ) )
    {
        maxstock = player function_9aecfd8b12f7ed0e( weapon, ammoref );
    }
    
    newstock = int( clamp( count, 0, maxstock ) );
    
    if ( function_54c12856313814d5() )
    {
        player.ammostock[ ammoref ] = newstock;
        function_55df76e594585afc( player, ammoref );
    }
    else
    {
        player setweaponammostock( weapon, newstock );
    }
    
    newstock = function_44b52f17768fb1c6( player, weapon );
    return count - newstock;
}

// Namespace item_ammo
// Params 1
// Checksum 0xa8898b5, Offset: 0x1f2a
// Size: 0x36, Type: bool
function function_b956ec34b65538e( ammotype )
{
    if ( !isdefined( ammotype ) || !isdefined( level.var_d157a47d96f8c663 ) )
    {
        return true;
    }
    
    return level.var_d157a47d96f8c663[ ammotype ] ?? 1;
}

// Namespace item_ammo
// Params 2, eflags: 0x4
// Checksum 0xc3449846, Offset: 0x1f69
// Size: 0x1ce
function private function_55df76e594585afc( player, var_bfcca06888355751 )
{
    hasfullammo = 1;
    
    foreach ( primary_weapon in self.primaryweapons )
    {
        if ( isnullweapon( primary_weapon ) )
        {
            continue;
        }
        
        relevant_weapons = [ primary_weapon ];
        
        if ( function_46ec0ebc88b3a6fc( primary_weapon ) )
        {
            relevant_weapons[ relevant_weapons.size ] = primary_weapon getaltweapon();
        }
        
        foreach ( weapon in relevant_weapons )
        {
            if ( function_b162feeed34a4640( weapon ) == var_bfcca06888355751 )
            {
                player setweaponammostock( weapon, function_7a3786a6d12362bd( player, var_bfcca06888355751 ), function_54c12856313814d5() );
            }
            
            current_ammo_type = function_b162feeed34a4640( weapon );
            
            if ( isdefined( current_ammo_type ) && hasfullammo )
            {
                currentammo = function_44b52f17768fb1c6( self, weapon );
                maxstock = function_9aecfd8b12f7ed0e( weapon, current_ammo_type );
                
                if ( currentammo < maxstock )
                {
                    hasfullammo = 0;
                }
            }
        }
    }
    
    player.hasfullammo = hasfullammo;
    
    if ( hasomnvar( "ui_has_full_ammo" ) )
    {
        player setclientomnvar( "ui_has_full_ammo", player.hasfullammo );
    }
}

// Namespace item_ammo
// Params 5
// Checksum 0xb3148dd0, Offset: 0x213f
// Size: 0x47
function function_8e04ccac15648db9( player, itembundle, item, inventorygroup, var_981c264073bf1154 )
{
    if ( function_fdb7ca5c724bcb5c() )
    {
        return 0;
    }
    
    return player function_fd3c87baab9eedaf( itembundle, item, var_981c264073bf1154 );
}

// Namespace item_ammo
// Params 0
// Checksum 0xdb48a6b6, Offset: 0x218f
// Size: 0x68, Type: bool
function function_fdb7ca5c724bcb5c()
{
    if ( !isdefined( level.var_c7b349cac7852206 ) )
    {
        var_c7b349cac7852206 = isdefined( level.gametypebundle ) && level.gametypebundle.var_cc79f3bb670c8eed;
        level.var_c7b349cac7852206 = getdvarint( @"hash_c2a60d051847ba6a", var_c7b349cac7852206 );
    }
    
    return common_inventory_groups::inventorygroup_enabled() && level.var_c7b349cac7852206;
}

// Namespace item_ammo
// Params 1, eflags: 0x4
// Checksum 0xe78e0288, Offset: 0x2200
// Size: 0x209
function private function_244ce90aef950bf2( params )
{
    [ backpackgroup, _ ] = common_inventory_groups::function_c27ac785b5373b73();
    [ row, column ] = common_inventory_groups::function_12ee5af12df204b4( backpackgroup, params.index );
    buttondefinition = common_inventory_groups::function_62e8f7d021e6a61e( backpackgroup, row, column );
    typedata = common_inventory_groups::function_ec48255a23c8526f( buttondefinition );
    
    if ( typedata.alloweditems.size == 0 || !isdefined( typedata.alloweditems[ 0 ] ) )
    {
        return;
    }
    
    alloweditem = typedata.alloweditems[ 0 ].itemspawnentry;
    
    if ( !isdefined( alloweditem ) )
    {
        return;
    }
    
    ammoref = getscriptbundlefieldvalue( alloweditem, #"ref" );
    primary_weapons = self getweaponslist( "primary" );
    
    foreach ( primary_weapon in primary_weapons )
    {
        current_ammo_type = function_b162feeed34a4640( primary_weapon );
        
        if ( current_ammo_type == ammoref )
        {
            self setweaponammostock( primary_weapon, int( params.quantity ) );
            continue;
        }
        
        if ( primary_weapon.hasalternate && !item_weapon::function_dc8d4a742844a795( primary_weapon ) )
        {
            altweaponobj = primary_weapon getaltweapon();
            var_c9210074b73ac497 = function_b162feeed34a4640( altweaponobj );
            
            if ( var_c9210074b73ac497 == ammoref )
            {
                self setweaponammostock( altweaponobj, int( params.quantity ) );
            }
        }
    }
}

// Namespace item_ammo
// Params 2, eflags: 0x4
// Checksum 0xfc2e24af, Offset: 0x2411
// Size: 0x174
function private items_ammo_debug( command, args )
{
    switch ( command )
    {
        case #"hash_8ff3986c5518a2e3":
            foreach ( player in level.players )
            {
                primary_weapons = player getweaponslist( "primary" );
                
                foreach ( primary_weapon in primary_weapons )
                {
                    ammoref = function_b162feeed34a4640( primary_weapon );
                    amount = function_3bb829269a94bef8( ammoref );
                    
                    if ( isdefined( args[ 0 ] ) )
                    {
                        amount = int( min( int( args[ 0 ] ), amount ) );
                    }
                    
                    player function_d06447d50fdcdeda( player, primary_weapon, amount );
                }
            }
            
            break;
        default:
            break;
    }
}

