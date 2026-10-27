// scripts\mp\loot\common_item_weapon.gsc  (hash_724b8f06df0c96b1.gscc) (size: 63818 Bytes / 0xf94a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x198cc11c (428654876)
// size ...... 63818 (0xf94a)
// includes .. 21  (offset: 0xee2e)
// strings ... 36  (offset: 0xeed6)
// dev strs .. 143 (offset: 0xf15e)
// exports ... 126 (offset: 0xa87a)
// cseg ...... 0x3bc + 0xa4be (0xa87a)
// imports ... 375 (offset: 0xbc2a)
// animtree1 . 0   (offset: 0xf94a)
// animtree2 . 0   (offset: 0xf94a)
#using script_113c055774e81279;
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\gameplay_telemetry_utils;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\gameplay_telemetry;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_ammo;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\loot\common_item_equipment;
#using scripts\mp\talking_gun;
#using scripts\mp\weapons;

#namespace item_weapon;

// Namespace item_weapon
// Params 0, eflags: 0x5
// Checksum 0xc7c21f37, Offset: 0x3da
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"item_weapon", #"common_item", &function_14d706fbf76ca1e, undefined );
}

// Namespace item_weapon
// Params 0
// Checksum 0x9905f80, Offset: 0x403
// Size: 0x426
function function_14d706fbf76ca1e()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    common_item::function_4b30c091d3b04a25( "weapon" );
    common_item::function_84174b793b5fe9a7( "weapon", #"use", &function_5be1bc100827adc7 );
    common_item::function_84174b793b5fe9a7( "weapon", #"canautouse", &function_be0129e29d04da0c );
    common_item::function_84174b793b5fe9a7( "weapon", #"hash_9e49dfaa7c147654", &function_bf9b7882fe8d3685 );
    common_item::function_84174b793b5fe9a7( "weapon", #"hash_57438abc2841dfec", &function_80f25240faed80a3 );
    common_item::function_84174b793b5fe9a7( "weapon", #"getcurrent", &function_2acdc118d951356c );
    common_item::function_84174b793b5fe9a7( "weapon", #"removecurrent", &items_weapon_removeweapon );
    common_item::function_84174b793b5fe9a7( "weapon", #"hash_d2edc28305c6e147", &function_e3ec6d88b3e56f2 );
    common_item::function_84174b793b5fe9a7( "weapon", #"hash_2cc40f197e06aed7", &function_7a22976069e48b5a );
    common_item::function_84174b793b5fe9a7( "weapon", #"hash_3459376aa4403b66", &function_269326131494fb85 );
    common_item::function_84174b793b5fe9a7( "weapon", #"getspawncount", &function_2b21991746c94c8c );
    common_item::function_84174b793b5fe9a7( "weapon", #"bundlenamefromlootid", &function_e067ae02c7bdbfc );
    common_item::function_84174b793b5fe9a7( "weapon", #"bundlenamefromitem", &function_72479413545729c8 );
    common_item::function_84174b793b5fe9a7( "weapon", #"hash_88b286fbc68ce7b", &function_d92d8a038ed7bfc0 );
    common_item::function_84174b793b5fe9a7( "weapon", #"database_additem", &function_550584229c9101ba );
    common_item::function_84174b793b5fe9a7( "weapon", #"lootidfromitem", &function_b7f484c7dea7dc34 );
    common_item::function_84174b793b5fe9a7( "weapon", #"hash_a58b880686dd682c", &function_74b6eb77bdc0169f );
    common_item::function_84174b793b5fe9a7( "weapon", #"hash_6705e43822cdd8da", &function_315007e9cb2ccde1 );
    common_item::function_84174b793b5fe9a7( "weapon", #"hash_2d3b76ff260f2d68", &function_482c254183dec1b5 );
    
    /#
        common_item::function_84174b793b5fe9a7( "<dev string:x24>", #"hash_3483a973fd1fe5b8", &function_2ab35ff6cbd1616a );
    #/
    
    level callback::add( #"player_connect", &function_85014b1092a7dc26 );
    level callback::add( #"player_spawned", &function_195f347d334719fe );
    level callback::add( #"player_weapon_take", &function_f9f12ddfa1766b72 );
    level callback::add( #"player_weapon_give", &function_f9f12ddfa1766b72 );
    
    if ( level.tertiaryweaponslotenabled )
    {
        level callback::add( #"player_weapon_change", &function_f87eb447ad123f8d );
    }
    else
    {
        level callback::add( #"player_weapon_change", &function_88ae282ed5c64191 );
    }
    
    level callback::add( "zm_packed_weapon", &function_70cb23432a855fea );
    level callback::add( "ammo_mod_equipped", &function_5747a3eae596a249 );
    utility::registersharedfunc( #"zombie", #"GetPlayerWeaponRarity", &function_fb81bd2fe070faa6 );
    utility::registersharedfunc( #"zombie", #"hash_e546039029657cd5", &function_40e1cbd0e1f47d1a );
    utility::registersharedfunc( #"zombie", #"hash_d7c108d9a9770758", &function_cf9036e07d207279 );
    utility::registersharedfunc( #"item_weapon", #"hash_1bb837b2ee0e5db9", &function_493bc69c1224a3fc );
    utility::registersharedfunc( #"item_weapon", #"hash_71052f7b6ff17121", &function_44fc01cf2d73796 );
    utility::registersharedfunc( #"item_weapon", #"hash_e45715864d7f979d", &function_842bd73027ce0146 );
    level.commonitem.var_685573a854ce8718 = [];
    level.commonitem.var_6a851b11370a0472 = [];
    level.commonitem.var_61f592e7119ec044 = strtok( getdvar( @"hash_56243d40ec08cee4", "" ), "," );
    level.commonitem.var_7e6c91688d3d059 = getdvarint( @"hash_ac1ee90233495500", 0 );
    function_57a0f488d5351461();
    function_59ca16ebed0e9c3b();
    
    /#
        thread function_337c509c85374ffb();
        utility::registersharedfunc( #"dev", #"spawnweapon", &function_96add18b226ff731 );
    #/
}

// Namespace item_weapon
// Params 1, eflags: 0x4
// Checksum 0x46dcba1f, Offset: 0x831
// Size: 0x1d
function private function_85014b1092a7dc26( params )
{
    self.var_1a87a9e7cf39ff69 = [];
    function_f44a4de9017bc034();
}

// Namespace item_weapon
// Params 1, eflags: 0x4
// Checksum 0x9b3f5b0d, Offset: 0x856
// Size: 0x42c
function private function_195f347d334719fe( params )
{
    if ( namespace_9d8e359c3b1041e5::isteamreviveenabledsharedfunc() && isdefined( self.revivecount ) )
    {
        reviveweapons = self.primaryinventory;
        var_f5361d862fc1bd72 = [];
        
        foreach ( weapon in reviveweapons )
        {
            if ( !isundefinedweapon( weapon ) )
            {
                ammostruct = spawnstruct();
                ammostruct.clipammo = self getweaponammoclip( weapon );
                ammostruct.stockammo = self getweaponammostock( weapon );
                
                if ( weapon.hasalternate )
                {
                    altweapon = weapon getaltweapon();
                    ammostruct.altclipammo = self getweaponammoclip( altweapon );
                    ammostruct.altstockammo = self getweaponammostock( altweapon );
                }
                
                var_f5361d862fc1bd72[ var_f5361d862fc1bd72.size ] = ammostruct;
                inventory_utility::_takeweapon( weapon );
            }
        }
        
        maxindex = 0;
        var_f20ced7adb9b8c55 = undefined;
        var_fa3b5fc3149ea047 = [];
        var_11e786a49459687d = [];
        
        foreach ( reviveweaponindex, var_fb58273c1ccc8e7 in reviveweapons )
        {
            foreach ( var_22a183f93a4db258, var_4289c0e26d6e4197 in self.var_1a87a9e7cf39ff69 )
            {
                if ( !var_fb58273c1ccc8e7.basename || !var_4289c0e26d6e4197.baseweapon )
                {
                    continue;
                }
                
                if ( var_fb58273c1ccc8e7.basename != var_4289c0e26d6e4197.baseweapon )
                {
                    continue;
                }
                
                var_fa3b5fc3149ea047[ var_22a183f93a4db258 ] = var_fb58273c1ccc8e7;
                var_11e786a49459687d[ var_22a183f93a4db258 ] = var_f5361d862fc1bd72[ reviveweaponindex ];
                
                if ( var_22a183f93a4db258 > maxindex )
                {
                    maxindex = var_22a183f93a4db258;
                }
                
                if ( reviveweaponindex == 0 )
                {
                    var_f20ced7adb9b8c55 = var_fb58273c1ccc8e7;
                }
                
                break;
            }
        }
        
        i = 0;
        
        while ( i <= maxindex )
        {
            weapon = var_fa3b5fc3149ea047[ i ];
            ammostruct = var_11e786a49459687d[ i ];
            
            if ( !weapon )
            {
            }
            else if ( isundefinedweapon( weapon ) )
            {
                inventory_utility::_giveweapon( level.defaultfist );
            }
            else if ( weapon::function_6b74ecd475e99b4( weapon ) )
            {
                inventory_utility::_giveweapon( weapon, undefined, undefined, 1 );
                weapon::function_b4c9549dee5d0fc5( weapon );
            }
            else
            {
                inventory_utility::_giveweapon( weapon, undefined, undefined, 1 );
                self setweaponammoclip( weapon, ammostruct.clipammo );
                self setweaponammostock( weapon, ammostruct.stockammo );
                
                if ( weapon.hasalternate )
                {
                    altweapon = weapon getaltweapon();
                    self setweaponammoclip( altweapon, ammostruct.altclipammo );
                    self setweaponammostock( altweapon, ammostruct.altstockammo );
                }
            }
            
            i += 1;
        }
        
        if ( var_f20ced7adb9b8c55 )
        {
            inventory_utility::_switchtoweapon( var_f20ced7adb9b8c55 );
            self setspawnweapon( var_f20ced7adb9b8c55 );
        }
    }
    
    foreach ( weapon in self.primaryinventory )
    {
        if ( function_42dc19da11258ab1( weapon ) )
        {
            primaryweaponindex = function_1464d1c9177c4934( weapon );
            
            if ( isdefined( primaryweaponindex ) )
            {
                function_92b8514cdacab7f9( weapon );
            }
        }
    }
}

// Namespace item_weapon
// Params 0
// Checksum 0x5f6e3f75, Offset: 0xc8a
// Size: 0xb5
function function_59ca16ebed0e9c3b()
{
    level.weaponslots = [];
    level.var_8ba765de20db7c0c = [];
    function_a0f3fe3239e3114b( #"primary", #"primary_0", 0 );
    function_a0f3fe3239e3114b( #"primary", #"primary_1", 1 );
    function_a0f3fe3239e3114b( #"primary", #"primary_2", 2 );
    function_a0f3fe3239e3114b( #"tertiary", #"tertiary_0", 0 );
    function_a0f3fe3239e3114b( #"tertiary", #"tertiary_1", 1 );
    function_a0f3fe3239e3114b( #"backpack", #"backpack_0", 0 );
}

// Namespace item_weapon
// Params 3, eflags: 0x4
// Checksum 0xb60fe47a, Offset: 0xd47
// Size: 0x6f
function private function_a0f3fe3239e3114b( slottype, slotname, id )
{
    if ( !isdefined( level.weaponslots[ slottype ] ) )
    {
        level.weaponslots[ slottype ] = [];
    }
    
    level.weaponslots[ slottype ][ id ] = slotname;
    level.var_8ba765de20db7c0c[ slotname ] = { #id:id, #type:slottype };
}

// Namespace item_weapon
// Params 1
// Checksum 0xd13c784b, Offset: 0xdbe
// Size: 0x18
function function_408321b974fbc79c( slotname )
{
    return level.var_8ba765de20db7c0c[ slotname ];
}

// Namespace item_weapon
// Params 1
// Checksum 0x5e327f16, Offset: 0xddf
// Size: 0x1d
function function_72e6bdd2cc8a6199( id )
{
    return function_5fdee52eb3891063( #"primary", id );
}

// Namespace item_weapon
// Params 1
// Checksum 0x80e862dc, Offset: 0xe05
// Size: 0x1d
function function_ecbb37fb8ca2b8cd( id )
{
    return function_5fdee52eb3891063( #"tertiary", id );
}

// Namespace item_weapon
// Params 2, eflags: 0x4
// Checksum 0x876fd7d, Offset: 0xe2b
// Size: 0x23
function private function_5fdee52eb3891063( slottype, id )
{
    return level.weaponslots[ slottype ][ id ];
}

// Namespace item_weapon
// Params 1, eflags: 0x4
// Checksum 0x896e8429, Offset: 0xe57
// Size: 0x54
function private function_f87eb447ad123f8d( params )
{
    if ( !weapon::iscurrenttertiaryweapon( self, params.weapon ) && function_46d840bd6268e2ce( params.weapon ) )
    {
        self.var_d1f2a060c3780533 = params.weapon;
    }
    
    function_88ae282ed5c64191( params );
}

// Namespace item_weapon
// Params 1, eflags: 0x4
// Checksum 0xb93c9d35, Offset: 0xeb3
// Size: 0x30
function private function_88ae282ed5c64191( params )
{
    function_92cfde6053d880e6( params.weapon );
    function_cf9036e07d207279( params.weapon );
}

// Namespace item_weapon
// Params 1, eflags: 0x4
// Checksum 0x457eba, Offset: 0xeeb
// Size: 0xba
function private function_92cfde6053d880e6( weapon )
{
    weapslot = gameplay_telemetry_utils::function_87e071d9cdce86a7( weapon.basename );
    var_a6e04294890d4a52 = weapslot ? "ui_" + weapslot + "_weapon_rarity_zm" : "undefined";
    
    if ( hasomnvar( var_a6e04294890d4a52 ) )
    {
        if ( !isdefined( weapon ) || isnullweapon( weapon ) || weapon::isfistweapon( weapon ) || weapon.basename == "iw8_gunless" )
        {
            self setclientomnvar( var_a6e04294890d4a52, 0 );
            return;
        }
        
        n_rarity = function_fb81bd2fe070faa6( weapon );
        self setclientomnvar( var_a6e04294890d4a52, n_rarity ? n_rarity : 0 );
    }
}

// Namespace item_weapon
// Params 1
// Checksum 0xac184146, Offset: 0xfad
// Size: 0x1e3
function function_cf9036e07d207279( weapon )
{
    if ( utility::issharedfuncdefined( #"weapon_rarity", #"hash_8363bfffa8f6d3e9" ) )
    {
        utility::callsharedfunc( #"weapon_rarity", #"hash_8363bfffa8f6d3e9" );
        return;
    }
    
    if ( hasomnvar( "ui_primary_weapon_rarity" ) )
    {
        primaryweaponobj = function_e7484276ad85f220( #"primary_0" );
        primaryweaponrarity = isdefined( primaryweaponobj ) ? function_fb81bd2fe070faa6( primaryweaponobj ) : 0;
        self setclientomnvar( "ui_primary_weapon_rarity", primaryweaponrarity );
    }
    
    if ( hasomnvar( "ui_secondary_weapon_rarity" ) )
    {
        secondaryweaponobj = function_e7484276ad85f220( #"primary_1" );
        secondaryweaponrarity = isdefined( secondaryweaponobj ) ? function_fb81bd2fe070faa6( secondaryweaponobj ) : 0;
        self setclientomnvar( "ui_secondary_weapon_rarity", secondaryweaponrarity );
    }
    
    if ( hasomnvar( "ui_tertiary_weapon_rarity" ) )
    {
        var_cc1262e66dbb1c79 = function_e7484276ad85f220( #"primary_2" );
        var_60bebd28ac3698b7 = isdefined( var_cc1262e66dbb1c79 ) ? function_fb81bd2fe070faa6( var_cc1262e66dbb1c79 ) : 0;
        self setclientomnvar( "ui_tertiary_weapon_rarity", var_60bebd28ac3698b7 );
    }
    
    if ( hasomnvar( "ui_current_weapon_tier" ) )
    {
        if ( !isdefined( weapon ) )
        {
            weapon = self getcurrentweapon();
        }
        
        if ( isnullweapon( weapon ) || weapon::isfistweapon( weapon ) || weapon.basename == "iw8_gunless" )
        {
            self setclientomnvar( "ui_current_weapon_tier", 0 );
            return;
        }
        
        n_rarity = function_fb81bd2fe070faa6( weapon ) ?? 0;
        self setclientomnvar( "ui_current_weapon_tier", n_rarity );
    }
    
    if ( hasomnvar( "ui_current_weapon_supports_tier_upgrade" ) )
    {
        var_88998cd5f42a3d5c = !( weapon::isfistweapon( weapon ) || weapon::iskillstreakweapon( weapon ) || weapon::iswonderweapon( weapon ) );
        self setclientomnvar( "ui_current_weapon_supports_tier_upgrade", var_88998cd5f42a3d5c );
    }
}

// Namespace item_weapon
// Params 1
// Checksum 0x15f899c6, Offset: 0x1198
// Size: 0xbb
function function_e067ae02c7bdbfc( lootid )
{
    blueprintindex = function_4d465a88a4c974d3( lootid );
    
    if ( isdefined( blueprintindex ) && blueprintindex != 0 )
    {
        baseweapon = function_357526af7a89075f( lootid );
        
        if ( isdefined( baseweapon ) )
        {
            if ( isdefined( level.commonitem.var_685573a854ce8718[ baseweapon ].bundles[ blueprintindex ] ) )
            {
                return level.commonitem.var_685573a854ce8718[ baseweapon ].bundles[ blueprintindex ][ 0 ];
            }
            
            if ( weaponinventorytype( baseweapon ) == "offhand" )
            {
                return item_equipment::function_b0aeb46b6ba652ce( lootid );
            }
        }
    }
    
    return level.commonitem.var_47078f33898179f4[ lootid ];
}

// Namespace item_weapon
// Params 1
// Checksum 0x9940a5dd, Offset: 0x125c
// Size: 0x5d
function function_b7f484c7dea7dc34( item )
{
    if ( item.type == function_f75620a38a24072() || item.type == function_56a1baf9422bf1d4() )
    {
        ref = weapon::getweaponrootname( item.weaponobj );
        return common_item::items_getlootidfromref( ref );
    }
}

// Namespace item_weapon
// Params 2
// Checksum 0x1834a6c0, Offset: 0x12c2
// Size: 0xae
function function_72479413545729c8( item, originalname )
{
    if ( isdefined( item.var_6828becb300b1c44 ) )
    {
        var_7237854e3be197ca = item.var_6828becb300b1c44.itembundlename;
        
        if ( isdefined( var_7237854e3be197ca ) )
        {
            return var_7237854e3be197ca;
        }
        
        if ( item.type == function_f75620a38a24072() )
        {
            return originalname;
        }
        
        return function_3da93a43aae4473d( item.var_6828becb300b1c44.baseweapon, item.var_6828becb300b1c44.rarity, item.var_6828becb300b1c44.variantid );
    }
    
    return originalname;
}

// Namespace item_weapon
// Params 2
// Checksum 0x330ee45a, Offset: 0x1379
// Size: 0x5c
function function_d92d8a038ed7bfc0( itembundle, originalname )
{
    if ( !isdefined( itembundle.baseweapon ) )
    {
        return originalname;
    }
    
    if ( itembundle.scriptable == function_f75620a38a24072() )
    {
        return originalname;
    }
    
    return function_3da93a43aae4473d( itembundle.baseweapon, itembundle.rarity );
}

// Namespace item_weapon
// Params 2
// Checksum 0x6757cd31, Offset: 0x13de
// Size: 0x1d, Type: bool
function function_74b6eb77bdc0169f( item, player )
{
    return function_28143f0282865199( player );
}

// Namespace item_weapon
// Params 3
// Checksum 0xb7b233d0, Offset: 0x1404
// Size: 0x41
function function_315007e9cb2ccde1( item, player, time )
{
    if ( function_28143f0282865199( player ) )
    {
        return function_f8629dd2f572af28( item, player, time );
    }
    
    return [ 1, time ];
}

// Namespace item_weapon
// Params 1
// Checksum 0xfb2b2760, Offset: 0x144e
// Size: 0x949
function function_550584229c9101ba( itembundlename )
{
    itembundle = getscriptbundlefieldvalues( itembundlename, [ #"baseweapon", #"weaponblueprint", #"ref", #"rarity", #"hash_b9a3752dc7a3d626", #"scriptable", #"weaponspawntranslation", #"weaponspawnrotation", #"hash_49d54bf7fdc612d4" ] );
    
    if ( !isdefined( itembundle.baseweapon ) )
    {
        return;
    }
    
    if ( itembundle.var_d45ad5f713c5ee95 && itembundle.scriptable )
    {
        if ( function_3f148667e2289988( itembundle.scriptable ) )
        {
            return;
        }
        
        var_4331e28e270c9a2a = function_1fb839e25a7e4f84( itembundle.scriptable, 0 );
        
        if ( var_4331e28e270c9a2a )
        {
            if ( !isdefined( level.commonitem.var_6a851b11370a0472[ var_4331e28e270c9a2a.basenamehash ] ) )
            {
                level.commonitem.var_6a851b11370a0472[ var_4331e28e270c9a2a.basenamehash ] = [];
            }
            
            if ( !isdefined( level.commonitem.var_e0eee057e60c129f ) )
            {
                level.commonitem.var_e0eee057e60c129f = [];
            }
            
            level.commonitem.var_6a851b11370a0472[ var_4331e28e270c9a2a.basenamehash ][ level.commonitem.var_6a851b11370a0472[ var_4331e28e270c9a2a.basenamehash ].size ] = { #itembundlename:itembundlename, #weaponobj:var_4331e28e270c9a2a };
            level.commonitem.var_e0eee057e60c129f = arraycombineunique( level.commonitem.var_e0eee057e60c129f, [ getweaponrootstring( var_4331e28e270c9a2a ) ] );
        }
    }
    
    if ( !isdefined( level.commonitem.var_685573a854ce8718[ itembundle.baseweapon ] ) )
    {
        level.commonitem.var_685573a854ce8718[ itembundle.baseweapon ] = { #bundles:[] };
        
        if ( getdvarint( @"hash_7fcd3e2f29d48d34", 0 ) )
        {
            rootname = weapon::getweaponrootname( itembundle.baseweapon );
            weaponassetname = weapon::getweaponassetname( rootname );
            
            if ( rootname && weaponassetname )
            {
                assert( weapon::weaponassetnamemap( rootname ) == itembundle.baseweapon, "<dev string:x2b>" + rootname );
            }
        }
    }
    
    blueprintindex = function_4591efaaa1c03edd( itembundle );
    rarity = itembundle.rarity ?? 0;
    
    if ( !isdefined( level.commonitem.var_685573a854ce8718[ itembundle.baseweapon ].bundles[ blueprintindex ] ) )
    {
        level.commonitem.var_685573a854ce8718[ itembundle.baseweapon ].bundles[ blueprintindex ] = [];
    }
    
    if ( !isdefined( level.commonitem.var_685573a854ce8718[ itembundle.baseweapon ].bundles[ blueprintindex ][ rarity ] ) )
    {
        level.commonitem.var_685573a854ce8718[ itembundle.baseweapon ].bundles[ blueprintindex ][ rarity ] = itembundlename;
        var_ca3ec50c34b723c8 = level.commonitem.var_685573a854ce8718[ itembundle.baseweapon ].var_d409d08ebfd660dd;
        level.commonitem.var_685573a854ce8718[ itembundle.baseweapon ].var_d409d08ebfd660dd = isdefined( var_ca3ec50c34b723c8 ) ? minint( var_ca3ec50c34b723c8, blueprintindex ) : blueprintindex;
        
        if ( !isdefined( level.commonitem.var_685573a854ce8718[ itembundle.baseweapon ].var_9cc71d1c7d6cdc27 ) )
        {
            level.commonitem.var_685573a854ce8718[ itembundle.baseweapon ].var_9cc71d1c7d6cdc27 = [];
        }
        
        var_e1c8eb3891b1414e = level.commonitem.var_685573a854ce8718[ itembundle.baseweapon ].var_9cc71d1c7d6cdc27[ blueprintindex ];
        level.commonitem.var_685573a854ce8718[ itembundle.baseweapon ].var_9cc71d1c7d6cdc27[ blueprintindex ] = isdefined( var_e1c8eb3891b1414e ) ? minint( var_e1c8eb3891b1414e, rarity ) : rarity;
    }
    else
    {
        /#
            if ( getdvarint( @"hash_11a180966b9141dd" ) > 1 )
            {
                print( "<dev string:x96>" + getxhashsourcename( level.commonitem.var_685573a854ce8718[ itembundle.baseweapon ].bundles[ blueprintindex ][ rarity ] ) + "<dev string:xd1>" + getxhashsourcename( itembundlename ) + "<dev string:xd9>" + getxhashsourcename( itembundle.baseweapon ) + "<dev string:xe5>" + rarity + "<dev string:xf9>" );
            }
        #/
    }
    
    if ( itembundle.var_d45ad5f713c5ee95 )
    {
        if ( !isdefined( level.commonitem.var_685573a854ce8718[ itembundle.baseweapon ].scriptables[ rarity ] ) )
        {
            level.commonitem.var_685573a854ce8718[ itembundle.baseweapon ].scriptables[ rarity ] = itembundle.scriptable;
        }
    }
    
    if ( !itembundle.var_74421e5967d993a3 )
    {
        if ( !isdefined( level.commonitem.var_685573a854ce8718[ itembundle.baseweapon ].scriptable ) )
        {
            level.commonitem.var_685573a854ce8718[ itembundle.baseweapon ].scriptable = itembundle.scriptable;
            
            /#
                level.commonitem.var_685573a854ce8718[ itembundle.baseweapon ].scriptablebundle = itembundlename;
            #/
        }
        else
        {
            /#
                if ( getdvarint( @"hash_11a180966b9141dd" ) > 1 )
                {
                    print( "<dev string:x96>" + getxhashsourcename( level.commonitem.var_685573a854ce8718[ itembundle.baseweapon ].scriptablebundle ) + "<dev string:xd1>" + getxhashsourcename( itembundlename ) + "<dev string:xd9>" + getxhashsourcename( itembundle.baseweapon ) + "<dev string:xe5>" + rarity + "<dev string:xf9>" );
                }
            #/
        }
        
        if ( isdefined( itembundle.weaponspawntranslation ) || isdefined( itembundle.weaponspawnrotation ) )
        {
            if ( !isdefined( level.commonitem.var_685573a854ce8718[ itembundle.baseweapon ].transform ) )
            {
                level.commonitem.var_685573a854ce8718[ itembundle.baseweapon ].transform = spawnstruct();
                
                if ( isdefined( itembundle.weaponspawntranslation ) )
                {
                    level.commonitem.var_685573a854ce8718[ itembundle.baseweapon ].transform.translation = ( itembundle.weaponspawntranslation.x ?? 0, itembundle.weaponspawntranslation.y ?? 0, itembundle.weaponspawntranslation.z ?? 0 );
                }
                
                if ( isdefined( itembundle.weaponspawnrotation ) )
                {
                    level.commonitem.var_685573a854ce8718[ itembundle.baseweapon ].transform.rotation = ( itembundle.weaponspawnrotation.x ?? 0, itembundle.weaponspawnrotation.y ?? 0, itembundle.weaponspawnrotation.z ?? 0 );
                }
                
                /#
                    level.commonitem.var_685573a854ce8718[ itembundle.baseweapon ].transform.bundle = itembundlename;
                #/
                
                return;
            }
            
            /#
                if ( getdvarint( @"hash_11a180966b9141dd" ) > 1 )
                {
                    print( "<dev string:x96>" + getxhashsourcename( level.commonitem.var_685573a854ce8718[ itembundle.baseweapon ].transform.bundle ) + "<dev string:xd1>" + getxhashsourcename( itembundlename ) + "<dev string:x150>" + getxhashsourcename( itembundle.baseweapon ) + "<dev string:x168>" );
                }
            #/
        }
    }
}

// Namespace item_weapon
// Params 4
// Checksum 0x80bc45ab, Offset: 0x1d9f
// Size: 0xe6, Type: bool
function function_65c509028906744f( itembundle, item, autouse, allowswap )
{
    if ( !val::get( "weapon_pickup" ) )
    {
        return false;
    }
    
    if ( self.insertingarmorplate )
    {
        return false;
    }
    
    if ( isdefined( item.exclusiveowner ) && item.exclusiveowner != self )
    {
        return false;
    }
    
    currentweapon = self getcurrentweapon();
    
    if ( weapon::iskillstreakweapon( currentweapon ) )
    {
        return false;
    }
    
    if ( common_inventory::inventory_isenabled() )
    {
        var_3c751c14d55bff2d = common_inventory::function_7bf60ff8870e96b4();
        
        if ( isdefined( var_3c751c14d55bff2d ) )
        {
            var_492a5fcc898a9fc2 = item.weaponobj ?? function_31562a2fb3df68d5( itembundle, item );
            
            if ( issameweapon( var_492a5fcc898a9fc2, var_3c751c14d55bff2d ) && item.fromgroup != 1 )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace item_weapon
// Params 4
// Checksum 0xfd70eb05, Offset: 0x1e8e
// Size: 0x89
function function_be0129e29d04da0c( itembundle, item, autouse, allowswap )
{
    canuse = function_65c509028906744f( itembundle, item, autouse, allowswap );
    
    if ( canuse && autouse && function_28143f0282865199( self ) )
    {
        var_492a5fcc898a9fc2 = item.weaponobj ?? function_31562a2fb3df68d5( itembundle, item );
        
        if ( !function_f8765284c26da663( itembundle, item, var_492a5fcc898a9fc2 ) )
        {
            canuse = 0;
        }
    }
    
    return canuse;
}

// Namespace item_weapon
// Params 4
// Checksum 0x4d6b17ca, Offset: 0x1f20
// Size: 0x33, Type: bool
function function_bf9b7882fe8d3685( itembundle, item, autouse, allowswap )
{
    return function_65c509028906744f( itembundle, item, autouse, allowswap );
}

// Namespace item_weapon
// Params 2
// Checksum 0xa9e44795, Offset: 0x1f5c
// Size: 0x32, Type: bool
function function_80f25240faed80a3( item, var_6bbe1e5bccb9d7dd )
{
    return isarray( var_6bbe1e5bccb9d7dd ) && var_6bbe1e5bccb9d7dd.size > 1 && !isnullweapon( var_6bbe1e5bccb9d7dd[ 1 ] );
}

// Namespace item_weapon
// Params 1
// Checksum 0x2cfcea5d, Offset: 0x1f97
// Size: 0x19
function function_6524d72a8880fc22( weaponidx )
{
    return common_item::function_3a06b3786d98047e( "weapon", weaponidx );
}

// Namespace item_weapon
// Params 6
// Checksum 0x990b836d, Offset: 0x1fb9
// Size: 0x9c8
function function_5be1bc100827adc7( itembundle, item, autouse, var_981c264073bf1154, var_2bc2b0a122147bae, var_64a5633315d24c40 )
{
    newweaponobj = undefined;
    weaponmaphandle = undefined;
    
    if ( isdefined( item.index ) )
    {
        weaponmaphandle = function_4884b5be535991e5( item.index );
    }
    
    if ( isdefined( item.weaponobj ) )
    {
        newweaponobj = item.weaponobj;
    }
    else if ( weaponmaphandle > 0 )
    {
        newweaponobj = getweaponfromhandle( weaponmaphandle );
    }
    else if ( isdefined( item.var_6828becb300b1c44 ) && isdefined( item.var_6828becb300b1c44.weaponobj ) )
    {
        newweaponobj = item.var_6828becb300b1c44.weaponobj;
    }
    else if ( isdefined( item.var_6828becb300b1c44 ) )
    {
        newweaponobj = function_31562a2fb3df68d5( itembundle, item );
    }
    else
    {
        newweaponobj = function_477bf1207c6672a5( itembundle );
    }
    
    if ( !isdefined( newweaponobj ) )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"favorite_builds", #"hash_b2236b923c23b575" ) )
    {
        [ item, newweaponobj ] = utility::callsharedfunc( #"favorite_builds", #"hash_b2236b923c23b575", item, newweaponobj );
    }
    
    newweaponstockammo = 0;
    
    if ( isdefined( item.weaponstockammo ) )
    {
        newweaponstockammo = item.weaponstockammo;
    }
    else
    {
        clipammo = common_item::function_44eacd480abb5b94( item.count );
        maxclipammo = weaponclipsize( newweaponobj );
        
        if ( clipammo > maxclipammo )
        {
            newweaponstockammo = clipammo - maxclipammo;
        }
    }
    
    callback::callback( #"hash_9aafcac01b1facc6", { #player:self, #objweapon:newweaponobj, #instance:item } );
    var_5a4868a324a8feaa = weapon::function_6b74ecd475e99b4( newweaponobj );
    var_a3bd7fa2e39410a3 = undefined;
    maxheldweapons = function_21fb8b54da9c5825();
    
    if ( !isdefined( var_2bc2b0a122147bae ) )
    {
        var_2bc2b0a122147bae = item.var_2bc2b0a122147bae;
    }
    
    if ( !isdefined( var_64a5633315d24c40 ) )
    {
        var_64a5633315d24c40 = item.var_64a5633315d24c40;
    }
    
    var_dd1ae4d14209c311 = function_c37bb4c61a4bbc01( newweaponobj );
    
    if ( var_5a4868a324a8feaa && isdefined( self.var_cc1262e66dbb1c79 ) && self hasweapon( self.var_cc1262e66dbb1c79 ) || !var_5a4868a324a8feaa && function_db94c1441f6cd802() > maxheldweapons - 1 || var_dd1ae4d14209c311 )
    {
        oldweaponidx = undefined;
        oldweaponobj = undefined;
        
        if ( var_2bc2b0a122147bae )
        {
            [ oldweaponidx, oldweaponobj ] = function_5057d6afdfd6c768() ?? function_6e9acdbb392dabc5( newweaponobj, undefined, autouse );
        }
        else
        {
            [ oldweaponidx, oldweaponobj ] = function_6e9acdbb392dabc5( newweaponobj, undefined, autouse );
        }
        
        if ( isdefined( oldweaponobj ) && self hasweapon( oldweaponobj ) )
        {
            if ( level.gametypebundle.var_a3ced8a724f9503a && function_5ac30ad8bde2e072( newweaponobj, oldweaponobj ) )
            {
                clipammo = common_item::function_44eacd480abb5b94( item.count );
                item_ammo::function_46e5ccf39665fcf4( newweaponobj, 0, 1, 0, clipammo );
                return 0;
            }
            
            if ( !weapon::isfistweapon( oldweaponobj ) && ( !function_9a923c52240cc9d3() || function_9a923c52240cc9d3() && !weapon::function_6b74ecd475e99b4( oldweaponobj ) ) && !utility::callsharedfunc( #"game", #"hash_bfde49be4ac35343", oldweaponobj, self ) )
            {
                oldweaponstockammo = self getweaponammostock( oldweaponobj );
                oldweaponammotype = getweaponammopoolname( oldweaponobj );
                newweaponammotype = getweaponammopoolname( newweaponobj );
                
                if ( oldweaponammotype == newweaponammotype && oldweaponstockammo > 0 )
                {
                    [ oldweaponstockammo, newweaponstockammo ] = function_944a2ca8570a3156( oldweaponstockammo, newweaponobj, newweaponstockammo );
                }
                
                function_c2ad12bd3e5d5da5( { #var_5156a93210ad2807:1, #var_aa2bfa85b57d6e16:oldweaponstockammo, #spawnoptions:var_981c264073bf1154, #weapon:oldweaponobj } );
            }
            else
            {
                items_weapon_removeweapon( { #var_5156a93210ad2807:1, #weapon:oldweaponobj } );
            }
            
            if ( weapon::function_6b74ecd475e99b4( oldweaponobj ) )
            {
                if ( self.var_cc1262e66dbb1c79 != oldweaponobj && function_9a923c52240cc9d3() )
                {
                    var_a3bd7fa2e39410a3 = oldweaponobj;
                }
            }
            
            if ( function_28143f0282865199( self ) )
            {
                self.var_6a41bd6cabbd5185 = gettime();
            }
        }
        else
        {
            var_203f0bfd905e1387 = "";
            
            for ( i = 0; i < self.primaryinventory.size ; i++ )
            {
                if ( isdefined( self.primaryinventory[ i ].basename ) )
                {
                    var_203f0bfd905e1387 += ( i != 0 ? ", " : "" ) + self.primaryinventory[ i ].basename;
                }
            }
            
            currentweapon = self getcurrentweapon();
            assertmsg( "<dev string:x1b1>" + "<dev string:x1e0>" + ( isdefined( newweaponobj ) && isdefined( newweaponobj.basename ) ? newweaponobj.basename : "<dev string:x218>" ) + "<dev string:x222>" + "<dev string:x257>" + ( isdefined( oldweaponobj ) && isdefined( oldweaponobj.basename ) ? oldweaponobj.basename : "<dev string:x218>" ) + "<dev string:x281>" + "<dev string:x284>" + ( isdefined( currentweapon ) && isdefined( currentweapon.basename ) ? currentweapon.basename : "<dev string:x218>" ) + "<dev string:x281>" + "<dev string:x2a7>" + var_203f0bfd905e1387 + "<dev string:x281>" );
            return;
        }
    }
    
    newweaponobj = weapon_utility::function_82abd5dde633d1a3( newweaponobj, item.pickup_source );
    
    if ( isdefined( item.var_d23df9e5c1ce8b02 ) )
    {
        self.var_60c2ab39157e81d2[ newweaponobj.var_1616e6fbba9a722d ] = item.var_d23df9e5c1ce8b02;
    }
    
    if ( item.var_951c89546ec50477 > 0 )
    {
        var_482e9999b75ed3d8 = istrue( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_z_mod", #"z_mod_pack_mule" ) );
        newweaponobj = utility::callsharedfunc( #"pack_a_punch", #"hash_902a07dfe723b1db", newweaponobj, item.var_951c89546ec50477 );
        utility::callsharedfunc( #"pack_a_punch", #"hash_4fb89d74adceafac", newweaponobj, item.var_951c89546ec50477 );
        
        if ( item.var_768b3618cd111c7e )
        {
            item.count = function_40acef7fe7fe290( newweaponobj );
            newweaponstockammo = utility::get_max_stock_ammo( newweaponobj, var_482e9999b75ed3d8 );
            item.var_768b3618cd111c7e = undefined;
            callback::callback( #"hash_24c992da2403a55e", { #source:item.upgrade_source, #objweapon:newweaponobj } );
        }
    }
    
    if ( level.ammo_mods_in_use )
    {
        if ( isdefined( item.ammomod_name ) )
        {
            utility::callsharedfunc( #"ammo_mod", #"hash_24f1a2cf1ed6660d", newweaponobj, item.ammomod_name );
        }
        
        if ( item.var_6828becb300b1c44.var_feda5a8ee8850775 )
        {
            if ( utility::callsharedfunc( #"ammo_mod", #"hash_4f3b91e6539bb512", newweaponobj ) )
            {
                if ( !utility::callsharedfunc( #"zombie", #"has_ammo_mod", newweaponobj ) )
                {
                    new_ammo_mod = utility::callsharedfunc( #"ammo_mod", #"get_random_ammo_mod" );
                    utility::callsharedfunc( #"ammo_mod", #"hash_24f1a2cf1ed6660d", newweaponobj, new_ammo_mod );
                }
            }
        }
        else if ( isdefined( item.var_6828becb300b1c44.var_3b3ea909a13145af ) )
        {
            var_3b3ea909a13145af = item.var_6828becb300b1c44.var_3b3ea909a13145af;
            
            if ( utility::callsharedfunc( #"ammo_mod", #"hash_4f3b91e6539bb512", newweaponobj ) )
            {
                if ( !utility::callsharedfunc( #"zombie", #"has_ammo_mod", newweaponobj ) )
                {
                    utility::callsharedfunc( #"ammo_mod", #"hash_24f1a2cf1ed6660d", newweaponobj, var_3b3ea909a13145af );
                }
            }
        }
    }
    
    function_3118b195b8da2a95( newweaponobj, item.count, newweaponstockammo, autouse, var_2bc2b0a122147bae, var_64a5633315d24c40, item );
    function_f9f12ddfa1766b72();
    challenges::onpickupweapon( newweaponobj, item.spawningteam );
    primaryweaponindex = function_1464d1c9177c4934( newweaponobj );
    
    if ( isdefined( primaryweaponindex ) )
    {
        if ( isdefined( item.var_6828becb300b1c44 ) )
        {
            self.var_1a87a9e7cf39ff69[ primaryweaponindex ] = item.var_6828becb300b1c44;
        }
        else
        {
            function_55c302d95295530f( newweaponobj, itembundle.rarity, primaryweaponindex, item.fromground );
        }
    }
    
    if ( function_28143f0282865199( self ) && getdvarint( @"hash_218b826f84233424", 0 ) )
    {
        function_bad773b9b72597f4( newweaponobj, !autouse );
    }
    
    if ( isdefined( var_a3bd7fa2e39410a3 ) )
    {
        inventory_utility::_giveweapon( var_a3bd7fa2e39410a3, undefined, undefined, 1 );
        weapon::function_b4c9549dee5d0fc5( var_a3bd7fa2e39410a3 );
    }
    
    sparams = spawnstruct();
    sparams.oldweaponobj = oldweaponobj;
    sparams.newweaponobj = newweaponobj;
    sparams.var_ab592b9195e8598f = primaryweaponindex;
    sparams.item = item;
    callback::callback( #"item_weapon_picked_up", sparams );
    gameplay_telemetry::function_3e91d2222fa2419f();
    return [ 0, newweaponobj ];
}

// Namespace item_weapon
// Params 1
// Checksum 0x5ac8c5b, Offset: 0x298a
// Size: 0x12f
function function_2acdc118d951356c( params )
{
    if ( !params )
    {
        return;
    }
    
    if ( !params.weapon && !params.slotname )
    {
        return;
    }
    
    if ( params.weapon )
    {
        weaponindex = function_1464d1c9177c4934( params.weapon );
        
        if ( !isdefined( weaponindex ) )
        {
            return;
        }
    }
    
    weapon = params.weapon ?? function_e7484276ad85f220( params.slotname );
    
    if ( isdefined( weapon ) && !isnullweapon( weapon ) && !weapon::isfistweapon( weapon ) && ( !function_9a923c52240cc9d3() || function_9a923c52240cc9d3() && !weapon::function_6b74ecd475e99b4( weapon ) ) )
    {
        name = function_3c60845f4139b91d( weapon );
        
        if ( isdefined( name ) )
        {
            rarity = function_fb81bd2fe070faa6( weapon );
            count = function_b7cc195bab9a5c92( weapon, rarity );
            return { #weaponobj:weapon, #count:count, #name:name };
        }
    }
}

// Namespace item_weapon
// Params 0
// Checksum 0x94809217, Offset: 0x2ac2
// Size: 0x8d
function function_5057d6afdfd6c768()
{
    currentweapon = self function_ca1904a5dd87fd53() ?? self getcurrentweapon();
    
    for ( weaponindex = 0; weaponindex < self.primaryinventory.size ; weaponindex++ )
    {
        weapon = self.primaryinventory[ weaponindex ];
        correctslot = function_46d840bd6268e2ce( weapon );
        
        if ( !correctslot || isnullweapon( weapon ) )
        {
            continue;
        }
        
        if ( currentweapon != weapon )
        {
            return [ weaponindex, weapon ];
        }
    }
    
    return [];
}

// Namespace item_weapon
// Params 1
// Checksum 0x26ff1b54, Offset: 0x2b58
// Size: 0x3a
function function_9beed18e7ff92b95( params )
{
    var_a2f37376e95a6261 = self getcurrentweapon();
    
    if ( !var_a2f37376e95a6261 )
    {
        return;
    }
    
    params.weapon = var_a2f37376e95a6261;
    return items_weapon_removeweapon( params );
}

// Namespace item_weapon
// Params 1
// Checksum 0xadccc03e, Offset: 0x2b9b
// Size: 0x43b
function items_weapon_removeweapon( params )
{
    if ( !params.weapon && !params.slotname )
    {
        return function_9beed18e7ff92b95( params );
    }
    
    weapon = params.weapon ?? function_e7484276ad85f220( params.slotname );
    
    if ( !weapon )
    {
        return;
    }
    
    if ( !params.dontdrop )
    {
        return function_c2ad12bd3e5d5da5( params );
    }
    
    if ( weapon::isunderwaterweaponobject( weapon ) || weapon::isclimbweaponobject( weapon ) || weapon::function_4c948bc86e32680a( weapon.basenamehash ) || weapon::function_e93a21a657377115( weapon ) || weapon.basename == "none" || weapon.inventorytype != "primary" )
    {
        return;
    }
    
    weaponindex = function_1464d1c9177c4934( weapon );
    
    if ( !isdefined( weaponindex ) )
    {
        throw( "Items_Weapon_RemoveWeapon - Tried to remove a weapon (" + weapon.basename + ") the player didn't have" );
        return;
    }
    
    var_6b74ecd475e99b4 = weapon::function_6b74ecd475e99b4( weapon );
    item = undefined;
    
    if ( !weapon::isfistweaponobject( weapon ) && !utility::callsharedfunc( #"game", #"hash_bfde49be4ac35343", weapon, self ) && ( !function_9a923c52240cc9d3() || !var_6b74ecd475e99b4 ) )
    {
        ammomod = utility::callsharedfunc( #"ammo_mod", #"hash_cf1012c4d313de70", weapon );
        item = function_8daff85dacc00ff4( self, weapon, ammomod );
        function_738e75077335e101( self, weapon );
    }
    
    if ( params.slotname )
    {
        slotinfo = function_408321b974fbc79c( params.slotname );
        
        if ( slotinfo.type == #"backpack" )
        {
            common_inventory::function_56f7e890f83685bd();
            return item;
        }
    }
    
    var_cc1262e66dbb1c79 = var_6b74ecd475e99b4 ? weapon : undefined;
    function_c209a7870d8ab55( weaponindex );
    
    if ( inventory_utility::getcurrentmonitoredweaponswitchweapon() == weapon )
    {
        inventory_utility::abortmonitoredweaponswitch( weapon );
    }
    else
    {
        inventory_utility::_takeweapon( weapon );
    }
    
    if ( var_6b74ecd475e99b4 && self.var_cc1262e66dbb1c79 == weapon )
    {
        self.tertiaryWeapon = undefined;
        self.var_cc1262e66dbb1c79 = undefined;
    }
    
    if ( function_db94c1441f6cd802() < 2 && !self.gettingloadout && !params.var_5156a93210ad2807 && !self.var_8d728cf8ba72f5a6 )
    {
        var_5d8cc93233d1451a = level.defaultfist;
        
        if ( function_9a923c52240cc9d3() )
        {
            if ( isdefined( self.var_cc1262e66dbb1c79 ) && isdefined( self.tertiaryWeapon ) )
            {
                var_5d8cc93233d1451a = self.var_cc1262e66dbb1c79;
                inventory_utility::_takeweapon( self.var_cc1262e66dbb1c79 );
                self.tertiaryWeapon = undefined;
                self.pers[ "tertiaryWeapon" ] = undefined;
                self.var_cc1262e66dbb1c79 = undefined;
            }
            else if ( isdefined( var_cc1262e66dbb1c79 ) )
            {
                var_5d8cc93233d1451a = var_cc1262e66dbb1c79;
            }
        }
        
        inventory_utility::_giveweapon( var_5d8cc93233d1451a );
        weaponindex = function_1464d1c9177c4934( var_5d8cc93233d1451a );
        
        if ( !isdefined( weaponindex ) )
        {
            if ( getbuildversion() != "SHIP" )
            {
                string = "Player Weapons: ";
                
                foreach ( index, weapon in self.primaryinventory )
                {
                    string += index + ":" + weapon.basename + ", ";
                }
                
                logstring( string );
            }
            
            throw( "Items_Weapon_RemoveWeapon - Tried to init player weapon data on a weapon (" + var_5d8cc93233d1451a.basename + ") that failed to be given to the player's primary inventory" );
        }
        else
        {
            function_55c302d95295530f( var_5d8cc93233d1451a, 0, weaponindex );
        }
        
        weapontoswitch = function_e7484276ad85f220( #"primary_0" );
        
        if ( !isdefined( weapontoswitch ) )
        {
            weapontoswitch = var_5d8cc93233d1451a;
        }
        
        inventory_utility::_switchtoweaponimmediate( weapontoswitch );
    }
    else
    {
        function_f9f12ddfa1766b72();
    }
    
    return item;
}

// Namespace item_weapon
// Params 1
// Checksum 0x35dda44d, Offset: 0x2fdf
// Size: 0x5a
function function_e762c26370fb8ad2( dontdrop )
{
    for ( index = self.primaryinventory.size - 1; index >= 0 ; index-- )
    {
        items_weapon_removeweapon( { #dontdrop:dontdrop, #weapon:self.primaryinventory[ index ] } );
    }
}

// Namespace item_weapon
// Params 3
// Checksum 0x46f9d8c1, Offset: 0x3041
// Size: 0x35
function function_e3ec6d88b3e56f2( itembundle, count, spawnoptions )
{
    spawnoptions.overridecount = count;
    return function_b960bc85ea91de14( itembundle, spawnoptions );
}

// Namespace item_weapon
// Params 4
// Checksum 0x4c257d76, Offset: 0x307f
// Size: 0x22e
function function_7a22976069e48b5a( scriptable, count, positioningdata, spawnoptions )
{
    baseweaponname = spawnoptions.weapon.basename;
    
    if ( !isdefined( baseweaponname ) )
    {
        return;
    }
    
    item = undefined;
    weapon = spawnoptions.weapon;
    droporigin = positioningdata.finalorigin;
    dropangles = positioningdata.finalangles;
    var_caba9f87afaea0cf = positioningdata.payload;
    var_4168e97f82c5285d = spawnoptions.payload;
    metadatapayload = spawnoptions.metadatapayload;
    
    if ( isdefined( spawnoptions.var_7ab33df13f7d7e5e ) )
    {
        var_268159224d6b20c3 = [ #"hash_3fa904770c46e1ee", spawnoptions.var_7ab33df13f7d7e5e ];
    }
    
    spawntransform = function_d4168a97cc3044b0( baseweaponname );
    
    if ( !spawnoptions.var_9161cf0784b6951d && isdefined( spawntransform ) )
    {
        if ( isdefined( spawntransform.translation ) )
        {
            droporigin += spawntransform.translation;
        }
        
        if ( isdefined( spawntransform.rotation ) )
        {
            dropangles += spawntransform.rotation;
        }
    }
    
    if ( spawnoptions.var_84aea320ab50b920 )
    {
        if ( isdefined( metadatapayload ) && function_9538daf6421e1353( scriptable, #"commonitemmetadata" ) )
        {
            item = spawncustomweaponscriptable( scriptable, droporigin, dropangles, undefined, weapon, var_caba9f87afaea0cf, var_4168e97f82c5285d, metadatapayload, var_268159224d6b20c3 );
        }
        else
        {
            item = spawncustomweaponscriptable( scriptable, droporigin, dropangles, undefined, weapon, var_caba9f87afaea0cf, var_4168e97f82c5285d, var_268159224d6b20c3 );
        }
        
        if ( isdefined( item ) )
        {
            item.customweaponname = getcompleteweaponname( weapon );
        }
        else
        {
            assertmsg( "<dev string:x2dd>" + getxhashsourcename( scriptable ) + "<dev string:x302>" );
            return;
        }
    }
    else
    {
        item = spawnscriptable( scriptable, droporigin, dropangles, undefined, var_caba9f87afaea0cf, var_4168e97f82c5285d, var_268159224d6b20c3 );
        
        if ( !isdefined( item ) )
        {
            assertmsg( "<dev string:x2dd>" + getxhashsourcename( scriptable ) + "<dev string:x33a>" );
            return;
        }
    }
    
    return item;
}

// Namespace item_weapon
// Params 2, eflags: 0x4
// Checksum 0xed93b51c, Offset: 0x32b6
// Size: 0x54
function private function_2b21991746c94c8c( itembundle, var_3b8f1509495546fd )
{
    if ( itembundle.var_d3af3f4e323ff7b0 )
    {
        weaponobj = var_3b8f1509495546fd.weapon ?? function_477bf1207c6672a5( itembundle );
        
        if ( isdefined( weaponobj ) )
        {
            return function_40acef7fe7fe290( weaponobj );
        }
    }
}

// Namespace item_weapon
// Params 1, eflags: 0x4
// Checksum 0x7b9679, Offset: 0x3313
// Size: 0x84
function private function_70cb23432a855fea( params )
{
    if ( !( isdefined( params.player ) && isdefined( params.var_39044599845b54cf ) && isdefined( params.var_951c89546ec50477 ) ) || !params.player function_195223d56c29625d( params.var_39044599845b54cf ) )
    {
        return;
    }
    
    params.player function_b2eab55086e607dc( params.var_39044599845b54cf, params.var_951c89546ec50477 );
}

// Namespace item_weapon
// Params 1, eflags: 0x4
// Checksum 0xb9569706, Offset: 0x339f
// Size: 0x84
function private function_5747a3eae596a249( params )
{
    if ( !( isdefined( params.player ) && isdefined( params.weapon ) && isdefined( params.ammo_mod_name ) ) || !params.player function_195223d56c29625d( params.weapon ) )
    {
        return;
    }
    
    params.player function_9f2491330451c82d( params.weapon, params.ammo_mod_name );
}

// Namespace item_weapon
// Params 3
// Checksum 0x63536b77, Offset: 0x342b
// Size: 0x8b
function function_35910aac16378fec( weaponobj, ammoinclip, var_d5c556bc8f734ddf )
{
    altammo = 0;
    
    if ( weaponobj.hasalternate && !function_dc8d4a742844a795( weaponobj ) )
    {
        altammo = isdefined( self.var_655fababc6344d9f ) ? self.var_655fababc6344d9f : weaponclipsize( weaponobj getaltweapon() );
    }
    
    packedammocount = common_item::function_598dd39282efb544( ammoinclip, undefined, altammo );
    function_3118b195b8da2a95( weaponobj, packedammocount, var_d5c556bc8f734ddf );
}

// Namespace item_weapon
// Params 0
// Checksum 0xd248a834, Offset: 0x34be
// Size: 0xa9
function function_cfd26324d14e4149()
{
    weaponobj = common_inventory::function_7bf60ff8870e96b4();
    
    if ( !isdefined( weaponobj ) )
    {
        return;
    }
    
    count = self.var_a6baf10262f73fd6 ?? weaponclipsize( weaponobj );
    altammo = 0;
    
    if ( weaponobj.hasalternate && !function_dc8d4a742844a795( weaponobj ) )
    {
        altammo = isdefined( self.var_655fababc6344d9f ) ? self.var_655fababc6344d9f : weaponclipsize( weaponobj getaltweapon() );
    }
    
    ammocount = common_item::function_598dd39282efb544( count, undefined, altammo );
    common_inventory::function_56f7e890f83685bd();
    function_3118b195b8da2a95( weaponobj, ammocount );
}

// Namespace item_weapon
// Params 7, eflags: 0x4
// Checksum 0x1f22e53f, Offset: 0x356f
// Size: 0x30a
function private function_3118b195b8da2a95( weaponobj, ammocount, stockammo, autouse, var_2bc2b0a122147bae, var_64a5633315d24c40, item )
{
    var_37ae78e0de4a6e53 = utility::callsharedfunc( #"common_item_weapon", #"hash_79fad35fafa507cc", weaponobj );
    
    if ( var_37ae78e0de4a6e53 )
    {
        weaponobj = var_37ae78e0de4a6e53;
    }
    
    weaponname = getcompleteweaponname( weaponobj );
    inventory_utility::_giveweapon( weaponname, undefined, undefined, item.skipfirstraise );
    self notify( #"pickedupweapon", weaponname );
    
    if ( utility::issharedfuncdefined( #"gametype", #"equipweapon" ) )
    {
        thread utility::callsharedfunc( #"gametype", #"equipweapon", weaponobj, 0 );
    }
    
    var_8bb1b2bde27b267c = common_item::function_44eacd480abb5b94( ammocount );
    var_917689d7bd419668 = common_item::function_5c3ce1ec7db94488( ammocount );
    clipsize = weaponclipsize( weaponobj );
    poolammo = 0;
    
    if ( var_8bb1b2bde27b267c > clipsize )
    {
        poolammo += var_8bb1b2bde27b267c - clipsize;
        var_8bb1b2bde27b267c = clipsize;
    }
    
    if ( var_917689d7bd419668 > clipsize )
    {
        poolammo += var_917689d7bd419668 - clipsize;
        var_917689d7bd419668 = clipsize;
    }
    
    self setweaponammoclip( weaponname, var_8bb1b2bde27b267c );
    self setweaponammoclip( weaponname, var_917689d7bd419668, "left" );
    
    if ( !weapon::function_251a6cf32459b82d( weaponobj ) )
    {
        newstockammo = poolammo;
        
        if ( item_ammo::function_54c12856313814d5() )
        {
            newstockammo = item_ammo::function_44b52f17768fb1c6( self, weaponobj );
        }
        else if ( item_ammo::function_fdb7ca5c724bcb5c() )
        {
            newstockammo = item_ammo::function_f01abfab49a719a0( self, weaponobj );
        }
        else if ( isdefined( stockammo ) )
        {
            newstockammo = stockammo;
        }
        
        var_be116b49a96aa33c = item_ammo::function_9aecfd8b12f7ed0e( weaponobj );
        newstockammo = minint( newstockammo, var_be116b49a96aa33c );
        item_ammo::function_d06447d50fdcdeda( self, weaponobj, newstockammo, var_be116b49a96aa33c );
    }
    
    if ( weaponobj.hasalternate && !function_dc8d4a742844a795( weaponobj ) )
    {
        altweaponobj = weaponobj getaltweapon();
        var_55d2d4184073f1f = common_item::function_3b2613fcafd07797( ammocount );
        altclipsize = weaponclipsize( altweaponobj );
        
        if ( !isdefined( var_55d2d4184073f1f ) || var_55d2d4184073f1f > altclipsize )
        {
            var_55d2d4184073f1f = altclipsize;
        }
        
        self setweaponammoclip( altweaponobj, var_55d2d4184073f1f );
        
        if ( item_ammo::function_fdb7ca5c724bcb5c() )
        {
            newstockammo = item_ammo::function_f01abfab49a719a0( self, altweaponobj );
            var_be116b49a96aa33c = item_ammo::function_9aecfd8b12f7ed0e( altweaponobj );
            item_ammo::function_d06447d50fdcdeda( self, altweaponobj, newstockammo, var_be116b49a96aa33c );
        }
    }
    
    if ( weapon::function_6b74ecd475e99b4( weaponobj ) )
    {
        weapon::function_b4c9549dee5d0fc5( weaponobj );
    }
    else if ( weaponobj.inventorytype == "primary" || weaponobj.inventorytype == "model_only" )
    {
        self assignweaponprimaryslot( weaponname );
    }
    
    var_135d65ad4506a949 = function_28143f0282865199( self ) && self function_d47d1bfd3ed511d3();
    var_cd73356e0cf288f3 = !isai( self ) && ( !autouse || var_135d65ad4506a949 || isnullweapon( self getcurrentweapon() ) );
    
    if ( var_cd73356e0cf288f3 && !var_2bc2b0a122147bae && !var_64a5633315d24c40 )
    {
        inventory_utility::_switchtoweaponimmediate( weaponname );
    }
}

// Namespace item_weapon
// Params 1
// Checksum 0xa1434127, Offset: 0x3881
// Size: 0x326
function function_c2ad12bd3e5d5da5( params )
{
    params.dontdrop = 1;
    weaponinfostruct = items_weapon_removeweapon( params );
    
    if ( !isdefined( weaponinfostruct ) )
    {
        return;
    }
    
    weaponinfostruct.ammostock = params.var_aa2bfa85b57d6e16 ?? weaponinfostruct.ammostock;
    weaponobj = weaponinfostruct.weaponobj;
    var_981c264073bf1154 = params.spawnoptions;
    
    if ( !isdefined( weaponinfostruct.var_6828becb300b1c44 ) )
    {
        assert( isdefined( weaponinfostruct.var_6828becb300b1c44 ) );
        return;
    }
    
    if ( function_28143f0282865199( self ) && getdvarint( @"hash_218b826f84233424", 0 ) )
    {
        function_bad773b9b72597f4( weaponobj, 0 );
    }
    
    spawnoptions = var_981c264073bf1154;
    
    if ( !isdefined( spawnoptions ) )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
    }
    
    spawnoptions.pastteam = self.team;
    spawnoptions.spawningteam = self.team;
    spawnoptions.originalowner = self;
    var_37ae78e0de4a6e53 = utility::callsharedfunc( #"common_item_weapon", #"hash_a09b97b1335d2c79", weaponobj );
    
    if ( var_37ae78e0de4a6e53 )
    {
        weaponobj = var_37ae78e0de4a6e53;
    }
    
    item = function_53da2af5697709f8( weaponobj, weaponinfostruct, spawnoptions );
    
    if ( !isdefined( item ) )
    {
        return;
    }
    
    talking_gun::function_2417dd5f3232aaf4( undefined, weaponobj, spawnoptions.baseorigin );
    var_33e74163843b348e = weapon::function_251a6cf32459b82d( weaponobj );
    
    if ( getdvarint( @"hash_52f4a8ccedf61788", 1 ) == 1 )
    {
        if ( var_33e74163843b348e && item.count == 0 )
        {
            if ( isdefined( self.var_6513b5b526741b4c ) )
            {
                common_item::function_869d7676e359a627( self.var_6513b5b526741b4c );
            }
            
            self.var_6513b5b526741b4c = item;
        }
    }
    
    if ( var_33e74163843b348e )
    {
        self notify( #"hash_e35c59b0ff4cf4bb" );
    }
    
    if ( isdefined( weaponinfostruct.var_6828becb300b1c44.itembundlename ) )
    {
        itembundle = getscriptbundlefieldvalues( weaponinfostruct.var_6828becb300b1c44.itembundlename, [ #"ref", #"scriptable", #"lootitemtype" ] );
        lootid = isdefined( itembundle.ref ) ? common_item::function_779887309ec71dfe( itembundle ) : 0;
        typestring = common_item::function_16e8c106491eeaca( itembundle );
        itemname = itembundle.scriptable ?? item.type;
        itemorigin = self.origin;
        common_item::items_analytics( lootid, undefined, undefined, undefined, undefined, typestring, undefined, undefined, itemname, itemorigin, 1 );
    }
    
    item.var_6828becb300b1c44 = weaponinfostruct.var_6828becb300b1c44;
    callback::callback( #"item_weapon_drop", { #player:self, #objweapon:weaponobj, #instance:item } );
    return item;
}

// Namespace item_weapon
// Params 2
// Checksum 0x3b704593, Offset: 0x3bb0
// Size: 0x459
function function_b960bc85ea91de14( itembundle, spawnoptions )
{
    if ( !itembundle )
    {
        assertmsg( "<dev string:x366>" );
        return;
    }
    
    if ( !common_item::function_81b3ee2ff16cc3f0( spawnoptions ) )
    {
        assertmsg( "<dev string:x3dc>" + common_item::function_7a9533425bd9a67f( itembundle ) + "<dev string:x436>" );
        return;
    }
    
    baseweapon = itembundle.baseweapon;
    
    if ( !isdefined( baseweapon ) )
    {
        return;
    }
    
    weaponobj = spawnoptions.weapon ?? function_477bf1207c6672a5( itembundle, spawnoptions );
    itembundlename = function_a23ea7289efe03ed( weaponobj, itembundle.rarity, weaponobj.variantid );
    var_6828becb300b1c44 = spawnoptions.var_6828becb300b1c44;
    
    if ( !var_6828becb300b1c44 )
    {
        var_6828becb300b1c44 = { #var_feda5a8ee8850775:itembundle.var_feda5a8ee8850775, #camoref:itembundle.camoref, #pastteam:self.team, #variantid:weaponobj.variantid, #baseweapon:baseweapon, #ammomod:spawnoptions.overrideammomod, #paplevel:spawnoptions.overridepaplvl ?? itembundle.var_7828255fbd9cce33, #rarity:itembundle.rarity, #attachments:weaponobj.attachments, #attachmentslots:itembundle.var_ef872c5384bdd7ce, #itembundlename:itembundlename };
        
        if ( isdefined( itembundle.var_3b3ea909a13145af ) )
        {
            var_6828becb300b1c44.var_3b3ea909a13145af = getscriptbundle( itembundle.var_3b3ea909a13145af ).ammomodname;
        }
    }
    
    weaponinfostruct = spawnoptions.weaponinfostruct;
    
    if ( !weaponinfostruct )
    {
        weaponinfostruct = spawnstruct();
        weaponinfostruct.ammoclipright = isdefined( spawnoptions.overridecount ) ? common_item::function_44eacd480abb5b94( spawnoptions.overridecount ) : weaponclipsize( weaponobj );
        weaponinfostruct.ammoclipleft = isdefined( spawnoptions.overridecount ) ? common_item::function_5c3ce1ec7db94488( spawnoptions.overridecount ) : weaponclipsize( weaponobj );
        
        if ( !function_dc8d4a742844a795( weaponobj ) )
        {
            weaponinfostruct.ammoclipalt = isdefined( spawnoptions.overridecount ) ? common_item::function_3b2613fcafd07797( spawnoptions.overridecount ) : weaponclipsize( weaponobj getaltweapon() );
        }
        else
        {
            weaponinfostruct.ammoclipalt = 0;
        }
        
        var_482e9999b75ed3d8 = istrue( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_z_mod", #"z_mod_pack_mule" ) );
        weaponmaxammo = utility::get_max_stock_ammo( weaponobj, var_482e9999b75ed3d8 );
        weaponinfostruct.ammostock = weaponmaxammo;
        weaponinfostruct.ammomod = var_6828becb300b1c44.ammomod;
        weaponinfostruct.paplv = var_6828becb300b1c44.paplevel;
        weaponinfostruct.rarity = var_6828becb300b1c44.rarity;
        weaponinfostruct.camoref = var_6828becb300b1c44.camoref;
        weaponinfostruct.var_feda5a8ee8850775 = var_6828becb300b1c44.var_feda5a8ee8850775;
        weaponinfostruct.var_3b3ea909a13145af = var_6828becb300b1c44.var_3b3ea909a13145af;
        weaponinfostruct.pastteam = var_6828becb300b1c44.pastteam;
        weaponinfostruct.attachmentslots = var_6828becb300b1c44.attachmentslots;
        weaponinfostruct.itembundlename = itembundlename;
    }
    
    item = function_53da2af5697709f8( weaponobj, weaponinfostruct, spawnoptions );
    
    if ( !isdefined( item ) )
    {
        return;
    }
    
    item.var_6828becb300b1c44 = var_6828becb300b1c44;
    item.exclusiveowner = spawnoptions.exclusiveowner;
    
    if ( !isdefined( item.additionaldata ) )
    {
        item.additionaldata = {};
    }
    
    item.additionaldata.attachmentslots = weaponinfostruct.attachmentslots;
    return item;
}

// Namespace item_weapon
// Params 3
// Checksum 0x59a352c1, Offset: 0x4012
// Size: 0x592
function function_53da2af5697709f8( weaponobj, weaponinfostruct, spawnoptions )
{
    weaponobj = weaponobj ?? weaponinfostruct.weaponobj;
    
    if ( !common_item::function_81b3ee2ff16cc3f0( spawnoptions ) )
    {
        assertmsg( "<dev string:x445>" );
        return;
    }
    
    baseweaponname = weaponobj.basename;
    
    if ( !isdefined( baseweaponname ) )
    {
        return;
    }
    
    rarity = 0;
    metadatapayload = undefined;
    
    if ( isdefined( weaponinfostruct.rarity ) || isdefined( weaponinfostruct.paplv ) || isdefined( weaponinfostruct.ammomod ) )
    {
        rarity = weaponinfostruct.rarity ?? 0;
        paplevel = weaponinfostruct.paplv ?? 0;
        ammomodid = utility::callsharedfunc( #"ammo_mod", #"hash_ddbe3f904027bd04", weaponinfostruct.ammomod ) ?? 0;
        metadatapayload = [ #"commonitemmetadata", rarity, paplevel, ammomodid, 0 ];
    }
    
    scriptable = spawnoptions.var_17415ad785d0eab6 ?? undefined;
    itembundlename = undefined;
    var_84aea320ab50b920 = 0;
    var_5ffc19d4667b5be1 = isdefined( weaponinfostruct.var_2cb6d045c209a9ff ) || spawnoptions.internal.var_508e6a09bb574ffe;
    
    if ( var_5ffc19d4667b5be1 && isdefined( level.gametypebundle.var_a3ca491bc6c8634c ) )
    {
        itembundlename = level.gametypebundle.var_a3ca491bc6c8634c;
        scriptable = function_56a1baf9422bf1d4();
        var_84aea320ab50b920 = 1;
    }
    else
    {
        itembundlename = weaponinfostruct.itembundlename ?? function_a23ea7289efe03ed( weaponobj, weaponinfostruct.rarity, weaponobj.variantid );
        
        if ( itembundlename )
        {
            itembundle = getscriptbundlefieldvalues( itembundlename, [ #"hash_49d54bf7fdc612d4", #"scriptable", #"lifetime" ] );
            
            if ( itembundle.var_d45ad5f713c5ee95 )
            {
                scriptable = itembundle.scriptable;
            }
        }
        
        if ( !scriptable )
        {
            scriptable = function_f75620a38a24072();
            var_84aea320ab50b920 = 1;
        }
        else if ( weaponinfostruct.var_6bfe3bce8147e327 && function_3f148667e2289988( scriptable ) )
        {
            if ( !isbrgamemode() )
            {
                scriptablename = getxhashhexname( scriptable );
                
                /#
                    scriptablename = getxhashsourcename( scriptable );
                #/
                
                throw( "Trying to spawn a non-loadout custom weapon " + scriptablename + " that came from a player! Some system must be giving a player a weapon without common items knowing." );
            }
            
            scriptable = function_f75620a38a24072();
            var_84aea320ab50b920 = 1;
        }
        
        spawnoptions.overridelifetime = itembundle.lifetime;
    }
    
    spawnoptions.var_84aea320ab50b920 = var_84aea320ab50b920;
    spawnoptions.weapon = weaponobj;
    spawnoptions.metadatapayload = metadatapayload;
    spawnoptions.var_90cdc5dbcd319e5d = 1;
    spawnoptions.var_d515ff001fe9ed9c = 1;
    spawnoptions.rarity = weaponinfostruct.rarity;
    item = common_item::items_spawnitemfromscriptable( scriptable, weaponinfostruct.weaponammocount, spawnoptions );
    
    if ( !isdefined( item ) )
    {
        assertmsg( "<dev string:x4a8>" );
        return;
    }
    
    spawnoptions.rarity = undefined;
    spawnoptions.weapon = undefined;
    item.count = weaponinfostruct.count ?? common_item::function_598dd39282efb544( weaponinfostruct.ammoclipright, weaponinfostruct.ammoclipleft, weaponinfostruct.ammoclipalt, weaponinfostruct.rarity );
    item.weaponstockammo = weaponinfostruct.ammostock;
    item.ammomod_name = weaponinfostruct.ammomod;
    item.var_951c89546ec50477 = weaponinfostruct.paplv;
    item.var_d23df9e5c1ce8b02 = weaponinfostruct.var_d23df9e5c1ce8b02;
    item.weaponobj = weaponobj;
    item.name = itembundlename;
    item.var_6828becb300b1c44 = { #var_d3429102a6d659e5:weaponinfostruct.var_d3429102a6d659e5, #camoref:weaponinfostruct.camoref, #var_3b3ea909a13145af:weaponinfostruct.var_3b3ea909a13145af, #var_feda5a8ee8850775:weaponinfostruct.var_feda5a8ee8850775, #pastteam:weaponinfostruct.pastteam, #var_3df5b0fceaf91931:var_84aea320ab50b920, #variantid:weaponobj.variantid, #baseweapon:baseweaponname, #ammomod:weaponinfostruct.ammomod, #paplv:weaponinfostruct.paplv, #rarity:weaponinfostruct.rarity, #attachmentslots:weaponinfostruct.attachmentslots, #attachments:weaponobj.attachments, #itembundlename:itembundlename };
    
    if ( spawnoptions.spawningentity )
    {
        spawnoptions.spawningentity callback::callback( #"item_spawn_weapon_obj", { #weapon:weaponobj, #instance:item } );
    }
    
    return item;
}

// Namespace item_weapon
// Params 1
// Checksum 0x160ac3fb, Offset: 0x45ad
// Size: 0xe6
function function_849a34281f9996f1( weapondata )
{
    if ( !isdefined( weapondata.baseweapon ) )
    {
        return nullweapon();
    }
    
    stickers = [ weapondata.stickerslot0 ?? "sticker_none", weapondata.stickerslot1 ?? "sticker_none", weapondata.stickerslot2 ?? "sticker_none", weapondata.stickerslot3 ?? "sticker_none", weapondata.var_73762c7cb8b2063 ?? "sticker_none" ];
    return weapon::buildweapon( weapondata.baseweapon, weapondata.attachments ?? [], weapondata.camo, weapondata.reticle, weapondata.variantid, undefined, undefined, stickers );
}

// Namespace item_weapon
// Params 2
// Checksum 0xcf54c316, Offset: 0x469c
// Size: 0x1e1
function function_31562a2fb3df68d5( itembundle, item )
{
    baseweaponname = itembundle.baseweapon;
    attachmentsarray = [];
    variantid = undefined;
    camo = undefined;
    reticle = undefined;
    
    if ( isdefined( item.var_6828becb300b1c44 ) )
    {
        if ( isdefined( item.var_6828becb300b1c44.baseweapon ) )
        {
            baseweaponname = item.var_6828becb300b1c44.baseweapon;
        }
        
        if ( isdefined( item.var_6828becb300b1c44.attachments ) )
        {
            attachmentsarray = item.var_6828becb300b1c44.attachments;
        }
        
        if ( isdefined( item.var_6828becb300b1c44.variantid ) )
        {
            variantid = item.var_6828becb300b1c44.variantid;
        }
        
        camo = item.var_6828becb300b1c44.camo;
        reticle = item.var_6828becb300b1c44.reticle;
    }
    
    stickers = [];
    
    if ( isdefined( item.stickerslot0 ) )
    {
        stickers[ stickers.size ] = item.stickerslot0;
    }
    
    if ( isdefined( item.stickerslot1 ) )
    {
        stickers[ stickers.size ] = item.stickerslot1;
    }
    
    if ( isdefined( item.stickerslot2 ) )
    {
        stickers[ stickers.size ] = item.stickerslot2;
    }
    
    if ( isdefined( item.stickerslot3 ) )
    {
        stickers[ stickers.size ] = item.stickerslot3;
    }
    
    if ( isdefined( item.var_73762c7cb8b2063 ) )
    {
        stickers[ stickers.size ] = item.var_73762c7cb8b2063;
    }
    
    return weapon::buildweapon( baseweaponname, attachmentsarray, camo, reticle, variantid, undefined, undefined, stickers );
}

// Namespace item_weapon
// Params 2
// Checksum 0xf72c6ffe, Offset: 0x4886
// Size: 0x198
function function_477bf1207c6672a5( itembundle, spawnoptions )
{
    if ( !isdefined( itembundle ) )
    {
        assertmsg( "<dev string:x509>" );
        return;
    }
    
    if ( !isdefined( itembundle.baseweapon ) )
    {
        assertmsg( "<dev string:x57a>" );
        return;
    }
    
    if ( itembundle.var_d45ad5f713c5ee95 && isdefined( itembundle.scriptable ) )
    {
        return function_1fb839e25a7e4f84( itembundle.scriptable );
    }
    
    baseweaponname = itembundle.baseweapon;
    camo = "camo_none";
    
    if ( isdefined( itembundle.weaponblueprint ) )
    {
        var_ad27c576a9fd9d52 = function_4591efaaa1c03edd( itembundle );
        assert( var_ad27c576a9fd9d52 != 0, "<dev string:x5fe>" + common_item::function_1cb2d422222358b8( itembundle.ref ) + "<dev string:x64f>" + itembundle.ref + "<dev string:x281>" );
        lootid = function_c5f6a5d130d7cd6c( itembundle );
        blueprintcamo = function_7fbe09b4061ba663( lootid );
        return weapon::giveweaponblueprint( baseweaponname, var_ad27c576a9fd9d52, blueprintcamo );
    }
    else if ( isdefined( itembundle.camoref ) )
    {
        camo = itembundle.camoref ?? "camo_none";
    }
    
    attachmentsarray = [];
    
    if ( getdvarint( @"hash_fe8c3a210d6855dd" ) == 0 )
    {
        attachmentsarray = function_f35592669ca50145( itembundle );
    }
    
    return weapon::buildweapon( baseweaponname, attachmentsarray, spawnoptions.var_26e2b63849fb2e8f ?? camo, undefined, spawnoptions.weapon_variant_id );
}

// Namespace item_weapon
// Params 1
// Checksum 0xe1b4f745, Offset: 0x4a27
// Size: 0x87
function function_860f9afb151019a6( itembundlename )
{
    if ( !isdefined( itembundlename ) )
    {
        return [];
    }
    
    var_456fb47f62296078 = getscriptbundlefieldvalues( itembundlename, [ #"baseweapon", #"maxattachments", #"attachmentslots", #"excludedefaultattachments", #"conversionkits", #"hash_5ebc4810f426934e" ] );
    
    if ( !isdefined( var_456fb47f62296078 ) )
    {
        return [];
    }
    
    return function_f35592669ca50145( var_456fb47f62296078 );
}

// Namespace item_weapon
// Params 1
// Checksum 0x3efa546e, Offset: 0x4ab7
// Size: 0x1176
function function_f35592669ca50145( itembundle )
{
    weapon = itembundle.baseweapon;
    maxattachments = itembundle.maxattachments ?? 0;
    
    if ( maxattachments == 0 )
    {
        return [];
    }
    
    selectedattachments = [];
    var_6312ac46ffdc4ef = [];
    var_ea6c326a135436fc = [];
    blockedattachments = [];
    var_d248e8ea49bf420c = [];
    var_fb9b519141aac52f = [];
    
    if ( isdefined( itembundle.conversionkits ) )
    {
        chance_offset = 0;
        random = randomfloat( 100 );
        
        foreach ( conversionkitentry in itembundle.conversionkits )
        {
            if ( !isdefined( conversionkitentry.attachment ) )
            {
                continue;
            }
            
            if ( !isdefined( conversionkitentry.chance ) )
            {
                blockedattachments[ blockedattachments.size ] = conversionkitentry.attachment;
                continue;
            }
            
            if ( random < chance_offset + conversionkitentry.chance && !arraycontains( level.commonitem.var_61f592e7119ec044, conversionkitentry.attachment ) )
            {
                selectedattachments[ selectedattachments.size ] = conversionkitentry.attachment;
                
                if ( selectedattachments.size >= maxattachments )
                {
                    return selectedattachments;
                }
                
                var_d248e8ea49bf420c[ var_d248e8ea49bf420c.size ] = getattachmentslot( weapon, conversionkitentry.attachment );
                
                foreach ( blockedattachment in getattachmentsblocked( weapon, conversionkitentry.attachment ) )
                {
                    blockedattachments[ blockedattachments.size ] = blockedattachment;
                }
                
                foreach ( blockedslot in getattachmentslotsblocked( weapon, conversionkitentry.attachment ) )
                {
                    var_d248e8ea49bf420c[ var_d248e8ea49bf420c.size ] = blockedslot;
                }
                
                foreach ( var_eee67c9b72ea381b in getattachmentbasetypesblocked( weapon, conversionkitentry.attachment ) )
                {
                    var_fb9b519141aac52f[ var_fb9b519141aac52f.size ] = var_eee67c9b72ea381b;
                }
                
                var_6312ac46ffdc4ef[ var_6312ac46ffdc4ef.size ] = getattachmentslot( weapon, conversionkitentry.attachment );
                basetype = getattachmentbasetype( weapon, conversionkitentry.attachment );
                
                if ( basetype != "" )
                {
                    var_ea6c326a135436fc[ var_ea6c326a135436fc.size ] = basetype;
                }
                
                break;
            }
            else
            {
                blockedattachments[ blockedattachments.size ] = conversionkitentry.attachment;
            }
            
            chance_offset += conversionkitentry.chance;
        }
    }
    
    if ( !isdefined( itembundle.attachmentslots ) )
    {
        return selectedattachments;
    }
    
    var_f8703d74700fa446 = [];
    
    if ( !isdefined( itembundle.excludedefaultattachments ) || itembundle.excludedefaultattachments == 1 )
    {
        defaultattachments = getweapondefaultattachments( weapon );
        
        foreach ( attachment in defaultattachments )
        {
            var_f8703d74700fa446[ getattachmentslot( weapon, attachment ) ] = attachment;
        }
    }
    
    var_4d7168dd10f0c9cd = [];
    var_d6132cde7f97ef6e = [];
    
    foreach ( var_2394ca84333f10ae in itembundle.attachmentslots )
    {
        if ( arraycontains( var_6312ac46ffdc4ef, var_2394ca84333f10ae.slot ) )
        {
            continue;
        }
        
        if ( arraycontains( var_d248e8ea49bf420c, var_2394ca84333f10ae.slot ) )
        {
            continue;
        }
        
        var_8b387da8e144fa98 = [];
        
        if ( var_2394ca84333f10ae.includeall )
        {
            var_8b387da8e144fa98 = function_2e5ecdd8ac47f308( weapon, var_2394ca84333f10ae.slot, level.commonitem.var_7e6c91688d3d059 );
        }
        else if ( isdefined( var_2394ca84333f10ae.includelist ) )
        {
            foreach ( attachmententry in var_2394ca84333f10ae.includelist )
            {
                if ( isdefined( attachmententry.attachment ) && attachmententry.attachment != "" )
                {
                    var_8b387da8e144fa98[ var_8b387da8e144fa98.size ] = attachmententry.attachment;
                }
            }
        }
        else
        {
            continue;
        }
        
        var_79181a7bc8a65e82 = [];
        
        foreach ( includedattachment in var_8b387da8e144fa98 )
        {
            if ( includedattachment == var_f8703d74700fa446[ var_2394ca84333f10ae.slot ] )
            {
                continue;
            }
            
            var_4da1f9a763c4110d = getattachmentslot( weapon, includedattachment );
            
            if ( var_4da1f9a763c4110d != var_2394ca84333f10ae.slot )
            {
                if ( var_4da1f9a763c4110d == "" )
                {
                    assertmsg( "<dev string:x661>" + includedattachment + "<dev string:x67a>" + weapon + "<dev string:x281>" );
                }
                else
                {
                    assertmsg( "<dev string:x661>" + includedattachment + "<dev string:x69c>" + var_2394ca84333f10ae.slot + "<dev string:x6b2>" + var_4da1f9a763c4110d + "<dev string:x6f0>" + weapon + "<dev string:x281>" );
                }
                
                continue;
            }
            
            var_b2947849af2cbdf4 = function_333a08591af6b59( weapon, includedattachment );
            
            if ( itembundle.var_828b7b9fdece7aea != 0 && isdefined( var_b2947849af2cbdf4 ) )
            {
                var_2b845cfe6bd96cba = getscriptbundlefieldvalues( var_b2947849af2cbdf4, [ #"hideinui" ] );
                
                if ( var_2b845cfe6bd96cba.hideinui )
                {
                    continue;
                }
            }
            
            if ( isdefined( var_b2947849af2cbdf4 ) && ( itembundle.var_c3b4f3a81f61c8ad ?? 1 ) )
            {
                var_2b845cfe6bd96cba = getscriptbundlefieldvalues( var_b2947849af2cbdf4, [ #"dmzrarity" ] );
                
                if ( var_2b845cfe6bd96cba.dmzrarity == "BROKEN" )
                {
                    continue;
                }
            }
            
            if ( arraycontains( level.commonitem.var_61f592e7119ec044, includedattachment ) )
            {
                continue;
            }
            
            if ( isdefined( var_2394ca84333f10ae.excludelist ) )
            {
                excluded = 0;
                
                foreach ( var_ef13c892944bca73 in var_2394ca84333f10ae.excludelist )
                {
                    if ( var_ef13c892944bca73.attachment == includedattachment )
                    {
                        excluded = 1;
                        break;
                    }
                }
                
                if ( excluded )
                {
                    continue;
                }
            }
            
            if ( arraycontains( blockedattachments, includedattachment ) )
            {
                continue;
            }
            
            basetype = getattachmentbasetype( weapon, includedattachment );
            
            if ( basetype != "" && arraycontains( var_fb9b519141aac52f, basetype ) )
            {
                continue;
            }
            
            if ( selectedattachments.size > 0 )
            {
                var_6c769843ca8cef7c = 0;
                var_49de92a3a095b26d = getattachmentsblocked( weapon, attachment );
                
                foreach ( blockedattachment in var_49de92a3a095b26d )
                {
                    if ( arraycontains( selectedattachments, blockedattachment ) )
                    {
                        var_6c769843ca8cef7c = 1;
                        break;
                    }
                }
                
                var_97ff73624bdc9dc9 = getattachmentslotsblocked( weapon, attachment );
                
                foreach ( blockedslot in var_97ff73624bdc9dc9 )
                {
                    if ( arraycontains( var_6312ac46ffdc4ef, blockedslot ) )
                    {
                        var_6c769843ca8cef7c = 1;
                        break;
                    }
                }
                
                var_caa25f1c9c1f41e6 = getattachmentbasetypesblocked( weapon, attachment );
                
                foreach ( var_eee67c9b72ea381b in var_caa25f1c9c1f41e6 )
                {
                    if ( arraycontains( var_ea6c326a135436fc, var_eee67c9b72ea381b ) )
                    {
                        var_6c769843ca8cef7c = 1;
                        break;
                    }
                }
                
                if ( var_6c769843ca8cef7c )
                {
                    continue;
                }
            }
            
            var_38ede57d1fc04b0a = 0;
            requiredattachments = getrequiredattachments( weapon, includedattachment );
            
            foreach ( requiredattachment in requiredattachments )
            {
                if ( !arraycontains( selectedattachments, requiredattachment ) )
                {
                    var_38ede57d1fc04b0a = 1;
                    break;
                }
            }
            
            if ( var_38ede57d1fc04b0a )
            {
                continue;
            }
            
            var_79181a7bc8a65e82[ var_79181a7bc8a65e82.size ] = includedattachment;
        }
        
        if ( var_79181a7bc8a65e82.size > 0 )
        {
            if ( var_2394ca84333f10ae.forced )
            {
                attachment = var_79181a7bc8a65e82[ randomint( var_79181a7bc8a65e82.size ) ];
                selectedattachments[ selectedattachments.size ] = attachment;
                
                if ( selectedattachments.size >= maxattachments )
                {
                    return selectedattachments;
                }
                
                foreach ( blockedattachment in getattachmentsblocked( weapon, attachment ) )
                {
                    blockedattachments[ blockedattachments.size ] = blockedattachment;
                }
                
                foreach ( blockedslot in getattachmentslotsblocked( weapon, attachment ) )
                {
                    var_d248e8ea49bf420c[ var_d248e8ea49bf420c.size ] = blockedslot;
                }
                
                foreach ( var_eee67c9b72ea381b in getattachmentbasetypesblocked( weapon, attachment ) )
                {
                    var_fb9b519141aac52f[ var_fb9b519141aac52f.size ] = var_eee67c9b72ea381b;
                }
                
                var_6312ac46ffdc4ef[ var_6312ac46ffdc4ef.size ] = getattachmentslot( weapon, attachment );
                basetype = getattachmentbasetype( weapon, attachment );
                
                if ( basetype != "" )
                {
                    var_ea6c326a135436fc[ var_ea6c326a135436fc.size ] = basetype;
                }
                
                continue;
            }
            
            var_4d7168dd10f0c9cd[ var_4d7168dd10f0c9cd.size ] = var_2394ca84333f10ae.slot;
            var_d6132cde7f97ef6e[ var_2394ca84333f10ae.slot ] = var_79181a7bc8a65e82;
        }
    }
    
    var_4d7168dd10f0c9cd = arrayrandomize( var_4d7168dd10f0c9cd );
    
    foreach ( slot in var_4d7168dd10f0c9cd )
    {
        if ( arraycontains( var_d248e8ea49bf420c, slot ) )
        {
            continue;
        }
        
        var_d6132cde7f97ef6e[ slot ] = arrayrandomize( var_d6132cde7f97ef6e[ slot ] );
        
        foreach ( attachment in var_d6132cde7f97ef6e[ slot ] )
        {
            basetype = getattachmentbasetype( weapon, attachment );
            
            if ( basetype != "" && arraycontains( var_fb9b519141aac52f, basetype ) || arraycontains( blockedattachments, attachment ) )
            {
                continue;
            }
            
            if ( selectedattachments.size > 0 )
            {
                var_6c769843ca8cef7c = 0;
                var_6a4bed0d4eac0512 = getattachmentsblocked( weapon, attachment );
                
                foreach ( blockedattachment in var_6a4bed0d4eac0512 )
                {
                    if ( arraycontains( selectedattachments, blockedattachment ) )
                    {
                        var_6c769843ca8cef7c = 1;
                        break;
                    }
                }
                
                var_c80f5125113fbf76 = getattachmentslotsblocked( weapon, attachment );
                
                foreach ( blockedslot in var_c80f5125113fbf76 )
                {
                    if ( arraycontains( var_6312ac46ffdc4ef, blockedslot ) )
                    {
                        var_6c769843ca8cef7c = 1;
                        break;
                    }
                }
                
                var_b9e496e1c9377589 = getattachmentbasetypesblocked( weapon, attachment );
                
                foreach ( var_eee67c9b72ea381b in var_b9e496e1c9377589 )
                {
                    if ( arraycontains( var_ea6c326a135436fc, var_eee67c9b72ea381b ) )
                    {
                        var_6c769843ca8cef7c = 1;
                        break;
                    }
                }
                
                if ( var_6c769843ca8cef7c )
                {
                    continue;
                }
            }
            
            var_38ede57d1fc04b0a = 0;
            requiredattachments = getrequiredattachments( weapon, attachment );
            
            foreach ( requiredattachment in requiredattachments )
            {
                if ( !arraycontains( selectedattachments, requiredattachment ) )
                {
                    var_38ede57d1fc04b0a = 1;
                    break;
                }
            }
            
            if ( var_38ede57d1fc04b0a )
            {
                continue;
            }
            
            selectedattachments[ selectedattachments.size ] = attachment;
            
            if ( selectedattachments.size >= maxattachments )
            {
                return selectedattachments;
            }
            
            if ( isdefined( var_6a4bed0d4eac0512 ) )
            {
                foreach ( blockedattachment in var_6a4bed0d4eac0512 )
                {
                    blockedattachments[ blockedattachments.size ] = blockedattachment;
                }
            }
            
            if ( isdefined( var_c80f5125113fbf76 ) )
            {
                foreach ( blockedslot in var_c80f5125113fbf76 )
                {
                    var_d248e8ea49bf420c[ var_d248e8ea49bf420c.size ] = blockedslot;
                }
            }
            
            if ( isdefined( var_b9e496e1c9377589 ) )
            {
                foreach ( var_eee67c9b72ea381b in var_b9e496e1c9377589 )
                {
                    var_fb9b519141aac52f[ var_fb9b519141aac52f.size ] = var_eee67c9b72ea381b;
                }
            }
            
            var_6312ac46ffdc4ef[ var_6312ac46ffdc4ef.size ] = slot;
            
            if ( basetype != "" )
            {
                var_ea6c326a135436fc[ var_ea6c326a135436fc.size ] = basetype;
            }
            
            break;
        }
    }
    
    return selectedattachments;
}

// Namespace item_weapon
// Params 1
// Checksum 0x6444892, Offset: 0x5c36
// Size: 0xbb
function function_e3101668a21a4237( itembundle )
{
    weapondata = { #pastteam:self.team, #itembundlename:function_3da93a43aae4473d( itembundle.baseweapon, itembundle.rarity, weapondata.variantid ), #variantid:function_4591efaaa1c03edd( itembundle ), #attachmentslots:itembundle.var_ef872c5384bdd7ce, #attachments:function_f35592669ca50145( itembundle ), #rarity:itembundle.rarity, #baseweapon:itembundle.baseweapon };
    return weapondata;
}

// Namespace item_weapon
// Params 1
// Checksum 0x1ae556fb, Offset: 0x5cfa
// Size: 0xbc
function function_fdc74b9be99fda2f( weaponobject )
{
    weapondata = { #pastteam:self.team, #itembundlename:function_a23ea7289efe03ed( weaponobject, weapondata.rarity ?? 0, weaponobject.variantid ), #camo:weaponobject.camo, #variantid:weaponobject.variantid, #attachments:weaponobject.attachments, #rarity:weaponobject.var_e4de3f79b4ac164f, #baseweapon:weaponobject.basename };
    return weapondata;
}

// Namespace item_weapon
// Params 4
// Checksum 0x30be715a, Offset: 0x5dbf
// Size: 0xc5
function function_55c302d95295530f( weaponobject, rarity, primaryweaponindex, fromground = 0 )
{
    weapondata = { #fromground:fromground, #pastteam:self.team, #itembundlename:function_a23ea7289efe03ed( weaponobject ), #variantid:weaponobject.variantid, #attachments:weaponobject.attachments, #rarity:rarity ?? 0, #baseweapon:weaponobject.basename };
    self.var_1a87a9e7cf39ff69[ primaryweaponindex ] = weapondata;
    return weapondata;
}

// Namespace item_weapon
// Params 3
// Checksum 0x26b421c5, Offset: 0x5e8d
// Size: 0x172
function function_a23ea7289efe03ed( weaponobj, rarity, variantid )
{
    foreach ( var_f2aa0d9dacbb5b83 in level.commonitem.var_6a851b11370a0472[ weaponobj.basenamehash ] )
    {
        if ( var_f2aa0d9dacbb5b83.weaponobj == weaponobj )
        {
            return var_f2aa0d9dacbb5b83.itembundlename;
        }
    }
    
    itembundlename = function_3da93a43aae4473d( weaponobj.basename, rarity, variantid );
    
    /#
        if ( !isdefined( itembundlename ) )
        {
            logstring( "<dev string:x707>" + "<dev string:x754>" + ( isdefined( weaponobj.basename ) ? getxhashsourcename( weaponobj.basename ) : "<dev string:x218>" ) + "<dev string:x767>" + ( isdefined( weaponobj.basename ) ? getxhashsourcename( getcompleteweaponname( weaponobj ) ) : "<dev string:x218>" ) + "<dev string:x77e>" + ( rarity ?? "<dev string:x218>" ) + "<dev string:x789>" + ( variantid ?? "<dev string:x218>" ) + "<dev string:x797>" );
        }
    #/
    
    return itembundlename;
}

// Namespace item_weapon
// Params 1
// Checksum 0xb5ff4c64, Offset: 0x6008
// Size: 0x153
function function_f9f12ddfa1766b72( params )
{
    if ( function_42cb187ac9540196() )
    {
        return;
    }
    
    if ( isdefined( self.primaryinventory ) && isdefined( self.var_1a87a9e7cf39ff69 ) )
    {
        var_c8bc670d0872044e = [];
        
        foreach ( weaponindex, weaponobject in self.primaryinventory )
        {
            foreach ( inventoryindex, weapondata in self.var_1a87a9e7cf39ff69 )
            {
                if ( weapondata.baseweapon == weaponobject.basename )
                {
                    var_c8bc670d0872044e[ weaponindex ] = weapondata;
                    self.var_1a87a9e7cf39ff69[ inventoryindex ] = undefined;
                    break;
                }
            }
        }
        
        self.var_1a87a9e7cf39ff69 = var_c8bc670d0872044e;
    }
}

// Namespace item_weapon
// Params 1, eflags: 0x4
// Checksum 0xd22f563f, Offset: 0x6163
// Size: 0xaf, Type: bool
function private function_195223d56c29625d( weaponobject )
{
    if ( !isdefined( weaponobject ) )
    {
        assertmsg( "<dev string:x79b>" );
        return false;
    }
    
    if ( !isplayer( self ) )
    {
        assertmsg( "<dev string:x806>" );
        return false;
    }
    
    var_96e87e6bed7aa700 = function_1464d1c9177c4934( weaponobject );
    
    if ( !isdefined( var_96e87e6bed7aa700 ) || var_96e87e6bed7aa700 < 0 || var_96e87e6bed7aa700 >= self.primaryinventory.size )
    {
        println( "<dev string:x86c>" + ( weaponobject.basename ?? "<dev string:x8cc>" ) + "<dev string:x8d8>" + ( var_96e87e6bed7aa700 ?? "<dev string:x90d>" ) );
        return false;
    }
    
    return isdefined( self.var_1a87a9e7cf39ff69[ var_96e87e6bed7aa700 ] );
}

// Namespace item_weapon
// Params 3
// Checksum 0x947af8ec, Offset: 0x621b
// Size: 0x74
function function_92b8514cdacab7f9( weaponobject, rarity, primaryweaponindex )
{
    [ primaryweaponindex, weapondata ] = function_22dc75ac603355ae( weaponobject, primaryweaponindex );
    
    if ( isdefined( primaryweaponindex ) && !isdefined( weapondata ) )
    {
        rarity = weaponobject.var_e4de3f79b4ac164f ?? 0;
        weapondata = function_55c302d95295530f( weaponobject, rarity, primaryweaponindex );
    }
    
    return weapondata;
}

// Namespace item_weapon
// Params 2, eflags: 0x4
// Checksum 0x8eb486e0, Offset: 0x6298
// Size: 0xfe
function private function_22dc75ac603355ae( weaponobject, primaryweaponindex )
{
    if ( !isdefined( weaponobject ) )
    {
        assertmsg( "<dev string:x917>" );
        return;
    }
    
    if ( !isplayer( self ) )
    {
        assertmsg( "<dev string:x97e>" );
        return;
    }
    
    if ( !isdefined( primaryweaponindex ) )
    {
        primaryweaponindex = function_1464d1c9177c4934( weaponobject );
    }
    
    if ( !isdefined( primaryweaponindex ) || primaryweaponindex < 0 || primaryweaponindex >= self.primaryinventory.size )
    {
        println( "<dev string:x86c>" + ( weaponobject.basename ?? "<dev string:x8cc>" ) + "<dev string:x9e0>" + ( primaryweaponindex ?? "<dev string:x90d>" ) );
        return;
    }
    
    if ( !isdefined( self.var_1a87a9e7cf39ff69[ primaryweaponindex ] ) || self.var_1a87a9e7cf39ff69[ primaryweaponindex ].baseweapon != weaponobject.basename )
    {
        return [ primaryweaponindex, undefined ];
    }
    
    return [ primaryweaponindex, self.var_1a87a9e7cf39ff69[ primaryweaponindex ] ];
}

// Namespace item_weapon
// Params 1
// Checksum 0x1f65faca, Offset: 0x639f
// Size: 0x51
function function_c209a7870d8ab55( primaryweaponindex )
{
    if ( !isdefined( primaryweaponindex ) || primaryweaponindex < 0 || primaryweaponindex >= self.primaryinventory.size )
    {
        assertmsg( "<dev string:xa0d>" + ( primaryweaponindex ?? "<dev string:x90d>" ) );
        return;
    }
    
    self.var_1a87a9e7cf39ff69[ primaryweaponindex ] = undefined;
}

// Namespace item_weapon
// Params 2
// Checksum 0x3890fcb1, Offset: 0x63f8
// Size: 0x19c
function function_9e7275fa51ace996( weaponobject, cachesource )
{
    if ( !function_195223d56c29625d( weaponobject ) )
    {
        return;
    }
    
    foreach ( var_276235448bd774f4 in self.var_863bc696d31749ec )
    {
        if ( var_276235448bd774f4.baseweapon == weaponobject.basename )
        {
            assertmsg( "<dev string:xa71>" + weaponobject.basename + "<dev string:xae6>" + ( var_276235448bd774f4.cachesource ?? "<dev string:x90d>" ) + "<dev string:xb04>" + ( cachesource ?? "<dev string:x90d>" ) + "<dev string:xb17>" );
            return;
        }
    }
    
    var_52e346f8d3159ce8 = function_22dc75ac603355ae( weaponobject );
    weapondata = var_52e346f8d3159ce8[ 1 ];
    
    if ( !isdefined( weapondata ) )
    {
        assertmsg( "<dev string:xb2c>" + ( weaponobject.basename ?? "<dev string:x90d>" ) + "<dev string:xb9d>" );
        return;
    }
    
    if ( !isdefined( self.var_863bc696d31749ec ) )
    {
        self.var_863bc696d31749ec = [];
    }
    
    self.var_863bc696d31749ec[ self.var_863bc696d31749ec.size ] = { #cachesource:cachesource, #weapondata:weapondata, #baseweapon:weapondata.baseweapon };
}

// Namespace item_weapon
// Params 1
// Checksum 0xf1137572, Offset: 0x659c
// Size: 0x16c
function function_d6a514964e1e7f2c( weaponobject )
{
    foreach ( var_276235448bd774f4 in self.var_863bc696d31749ec )
    {
        if ( var_276235448bd774f4.baseweapon == weaponobject.basename )
        {
            var_3e3409e2f44f21db = var_276235448bd774f4;
            break;
        }
    }
    
    if ( !isdefined( var_3e3409e2f44f21db.weapondata ) )
    {
        println( "<dev string:xbba>" + ( weaponobject.basename ?? "<dev string:x90d>" ) );
        return;
    }
    
    primaryweaponindex = function_1464d1c9177c4934( weaponobject );
    
    if ( !isdefined( primaryweaponindex ) || primaryweaponindex < 0 || primaryweaponindex >= self.primaryinventory.size )
    {
        println( "<dev string:x86c>" + ( weaponobject.basename ?? "<dev string:x8cc>" ) + "<dev string:x9e0>" + ( primaryweaponindex ?? "<dev string:x90d>" ) );
        return;
    }
    
    self.var_1a87a9e7cf39ff69[ primaryweaponindex ] = var_3e3409e2f44f21db.weapondata;
    self.var_863bc696d31749ec = arrayremove( self.var_863bc696d31749ec, var_3e3409e2f44f21db );
}

// Namespace item_weapon
// Params 1
// Checksum 0x29165fcc, Offset: 0x6710
// Size: 0xce
function function_e570f94856126417( weaponobject )
{
    foreach ( var_276235448bd774f4 in self.var_863bc696d31749ec )
    {
        if ( var_276235448bd774f4.baseweapon == weaponobject.basename )
        {
            var_3e3409e2f44f21db = var_276235448bd774f4;
            break;
        }
    }
    
    if ( !isdefined( var_3e3409e2f44f21db.weapondata ) )
    {
        return;
    }
    
    self.var_863bc696d31749ec = arrayremove( self.var_863bc696d31749ec, var_3e3409e2f44f21db );
}

// Namespace item_weapon
// Params 3
// Checksum 0x1cbe1cbd, Offset: 0x67e6
// Size: 0x356
function function_8daff85dacc00ff4( player, weaponobj, ammomod )
{
    rarity = player function_fb81bd2fe070faa6( weaponobj );
    var_6828becb300b1c44 = player function_92b8514cdacab7f9( weaponobj, rarity );
    weaponinfostruct = { #pastteam:player.team, #reticle:weaponobj.reticle, #var_6828becb300b1c44:var_6828becb300b1c44, #camo:weaponobj.camo, #rarity:rarity, #paplv:player utility::callsharedfunc( #"pack_a_punch", #"get_pap_level", weaponobj ), #ammomod:ammomod, #ammostock:player getweaponammostock( weaponobj ), #ammoclipalt:function_dc8d4a742844a795( weaponobj ) ? 0 : player getweaponammoclip( weaponobj getaltweapon() ), #ammoclipleft:player getweaponammoclip( weaponobj, "left" ), #ammoclipright:player getweaponammoclip( weaponobj ), #weaponobj:weaponobj, #name:player function_3c60845f4139b91d( weaponobj ) };
    
    if ( isdefined( player.var_60c2ab39157e81d2 ) )
    {
        weaponinfostruct.var_d23df9e5c1ce8b02 = player.var_60c2ab39157e81d2[ weaponobj.var_1616e6fbba9a722d ];
    }
    
    if ( isdefined( weaponobj.stickerslot0 ) && weaponobj.stickerslot0 != "sticker_none" )
    {
        weaponinfostruct.stickerslot0 = weaponobj.stickerslot0;
    }
    
    if ( isdefined( weaponobj.stickerslot1 ) && weaponobj.stickerslot1 != "sticker_none" )
    {
        weaponinfostruct.stickerslot1 = weaponobj.stickerslot1;
    }
    
    if ( isdefined( weaponobj.stickerslot2 ) && weaponobj.stickerslot2 != "sticker_none" )
    {
        weaponinfostruct.stickerslot2 = weaponobj.stickerslot2;
    }
    
    if ( isdefined( weaponobj.stickerslot3 ) && weaponobj.stickerslot3 != "sticker_none" )
    {
        weaponinfostruct.stickerslot3 = weaponobj.stickerslot3;
    }
    
    if ( isdefined( weaponobj.var_73762c7cb8b2063 ) && weaponobj.var_73762c7cb8b2063 != "sticker_none" )
    {
        weaponinfostruct.var_73762c7cb8b2063 = weaponobj.var_73762c7cb8b2063;
    }
    
    if ( !player.classstruct.var_74bf72275e8840fc && ( issameweapon( player.classstruct.loadoutprimaryobject, weaponobj ) || issameweapon( player.classstruct.loadoutsecondaryobject, weaponobj ) || issameweapon( player.classstruct.var_9dcef9a8722c3abb, weaponobj ) ) )
    {
        weaponinfostruct.var_2cb6d045c209a9ff = weaponobj;
    }
    else if ( var_6828becb300b1c44.var_3df5b0fceaf91931 )
    {
        weaponinfostruct.var_2cb6d045c209a9ff = weaponobj;
    }
    
    weaponinfostruct.var_6bfe3bce8147e327 = 1;
    return weaponinfostruct;
}

// Namespace item_weapon
// Params 1
// Checksum 0x552710c0, Offset: 0x6b45
// Size: 0x6e
function function_3c60845f4139b91d( weaponobject )
{
    primaryweaponindex = function_1464d1c9177c4934( weaponobject );
    
    if ( isdefined( primaryweaponindex ) )
    {
        var_7237854e3be197ca = self.var_1a87a9e7cf39ff69[ primaryweaponindex ].itembundlename;
        
        if ( isdefined( var_7237854e3be197ca ) )
        {
            return var_7237854e3be197ca;
        }
    }
    
    var_7237854e3be197ca = function_a23ea7289efe03ed( weaponobject );
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return common_item_database::function_ca9ca606e66b5911( function_f75620a38a24072() );
}

// Namespace item_weapon
// Params 3
// Checksum 0x6184e018, Offset: 0x6bbc
// Size: 0xbf
function function_40e1cbd0e1f47d1a( weapon, rarity, b_hud_update = 1 )
{
    weapondata = function_92b8514cdacab7f9( weapon, rarity );
    
    if ( isdefined( weapondata ) )
    {
        weapondata.rarity = rarity;
        weapondata.itembundlename = function_a23ea7289efe03ed( weapon, rarity, weapondata.variantid );
        
        if ( b_hud_update )
        {
            function_cf9036e07d207279( weapon );
        }
        
        paramsstruct = spawnstruct();
        paramsstruct.weapon = weapon;
        paramsstruct.rarity = rarity;
        callback::callback( "on_weapon_rarity_set_complete", paramsstruct );
        function_92cfde6053d880e6( weapon );
    }
}

// Namespace item_weapon
// Params 1
// Checksum 0xcee9f24, Offset: 0x6c83
// Size: 0x22, Type: bool
function function_fb81bd2fe070faa6( weapon )
{
    return function_92b8514cdacab7f9( weapon ).rarity ?? 0;
}

// Namespace item_weapon
// Params 1
// Checksum 0x2b6c9421, Offset: 0x6cae
// Size: 0x45
function function_558121b89ab6a092( weapon )
{
    weapondata = function_92b8514cdacab7f9( weapon );
    
    if ( weapondata.fromground || weapondata.var_d3429102a6d659e5 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace item_weapon
// Params 3
// Checksum 0xdc515267, Offset: 0x6cfb
// Size: 0x47
function function_b2eab55086e607dc( weapon, paplevel, rarity )
{
    weapondata = function_92b8514cdacab7f9( weapon, rarity );
    
    if ( isdefined( weapondata ) )
    {
        weapondata.paplevel = paplevel;
    }
}

// Namespace item_weapon
// Params 1
// Checksum 0xdd7f75f0, Offset: 0x6d4a
// Size: 0x32
function function_3cbd6ffdb5d48a78( weapon )
{
    weapondata = function_92b8514cdacab7f9( weapon );
    
    if ( isdefined( weapondata ) )
    {
        return weapondata.paplevel;
    }
}

// Namespace item_weapon
// Params 3
// Checksum 0x54b75020, Offset: 0x6d84
// Size: 0x47
function function_9f2491330451c82d( weapon, ammomod, rarity )
{
    weapondata = function_92b8514cdacab7f9( weapon, rarity );
    
    if ( isdefined( weapondata ) )
    {
        weapondata.ammomod = ammomod;
    }
}

// Namespace item_weapon
// Params 1
// Checksum 0xa1e18929, Offset: 0x6dd3
// Size: 0x32
function function_ef9c1a22435b14b9( weapon )
{
    weapondata = function_92b8514cdacab7f9( weapon );
    
    if ( isdefined( weapondata ) )
    {
        return weapondata.ammomod;
    }
}

// Namespace item_weapon
// Params 1
// Checksum 0xd5029b90, Offset: 0x6e0d
// Size: 0x34
function function_b520cb81440b0fea( weapon )
{
    weapondata = function_92b8514cdacab7f9( weapon, undefined, undefined );
    
    if ( isdefined( weapondata ) )
    {
        return weapondata.var_3df5b0fceaf91931;
    }
}

// Namespace item_weapon
// Params 3
// Checksum 0xbda2d274, Offset: 0x6e49
// Size: 0x49
function function_59db11f47705f704( weapon, pastteam, weaponindex )
{
    weapondata = function_92b8514cdacab7f9( weapon, undefined, weaponindex );
    
    if ( isdefined( weapondata ) )
    {
        weapondata.pastteam = pastteam;
    }
}

// Namespace item_weapon
// Params 2
// Checksum 0xbc8cf5be, Offset: 0x6e9a
// Size: 0x3e
function function_af299135a62729b8( weapon, weaponindex )
{
    weapondata = function_92b8514cdacab7f9( weapon, undefined, weaponindex );
    
    if ( isdefined( weapondata ) )
    {
        return weapondata.pastteam;
    }
}

// Namespace item_weapon
// Params 1, eflags: 0x4
// Checksum 0xf59ef7b9, Offset: 0x6ee0
// Size: 0x1f
function private function_a39b968d47067868( weapindex )
{
    if ( isdefined( weapindex ) )
    {
        return self.primaryinventory[ weapindex ];
    }
}

// Namespace item_weapon
// Params 1
// Checksum 0xeebfe657, Offset: 0x6f08
// Size: 0xab
function function_e7484276ad85f220( slotname )
{
    slotinfo = function_408321b974fbc79c( slotname );
    weaponobj = undefined;
    
    if ( slotinfo.type == #"tertiary" )
    {
        weaponobj = function_c95f9804da24bcbb( slotinfo.id );
    }
    else if ( slotinfo.type == #"backpack" )
    {
        if ( isdefined( common_inventory::function_933894456e289760() ) )
        {
            weaponobj = common_inventory::function_7bf60ff8870e96b4();
        }
        else
        {
            assertmsg( "<dev string:xc34>" );
        }
    }
    else
    {
        weaponobj = function_67ade82cb19c34d3( slotinfo.id );
    }
    
    return weaponobj;
}

// Namespace item_weapon
// Params 1, eflags: 0x4
// Checksum 0x1359a526, Offset: 0x6fbc
// Size: 0x2c
function private function_67ade82cb19c34d3( slotid )
{
    weaponindex = function_ec82b834c8af412( slotid );
    return self.primaryinventory[ weaponindex ];
}

// Namespace item_weapon
// Params 1, eflags: 0x4
// Checksum 0xfb563fb0, Offset: 0x6ff1
// Size: 0x82
function private function_ec82b834c8af412( slotid )
{
    var_d29e958430b74254 = 0;
    
    for ( weaponindex = 0; weaponindex < self.primaryinventory.size ; weaponindex++ )
    {
        weapon = self.primaryinventory[ weaponindex ];
        correctslot = function_46d840bd6268e2ce( weapon );
        
        if ( !correctslot || isnullweapon( weapon ) )
        {
            continue;
        }
        
        if ( var_d29e958430b74254 == slotid )
        {
            return weaponindex;
        }
        
        var_d29e958430b74254++;
    }
}

// Namespace item_weapon
// Params 0
// Checksum 0xf776fbce, Offset: 0x707c
// Size: 0x1b
function function_80e13ca8b843fd9e()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    return function_e7484276ad85f220( #"primary_0" );
}

// Namespace item_weapon
// Params 0
// Checksum 0x64549c6b, Offset: 0x70a0
// Size: 0x1b
function function_7e6b6d717dfe28d8()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    return function_e7484276ad85f220( #"primary_1" );
}

// Namespace item_weapon
// Params 1, eflags: 0x4
// Checksum 0xf58ede3e, Offset: 0x70c4
// Size: 0x2c
function private function_c95f9804da24bcbb( slotid )
{
    weaponindex = function_57e23b6e8d5bb2ea( slotid );
    return self.primaryinventory[ weaponindex ];
}

// Namespace item_weapon
// Params 1, eflags: 0x4
// Checksum 0x57fa8227, Offset: 0x70f9
// Size: 0x82
function private function_57e23b6e8d5bb2ea( slotid )
{
    var_d29e958430b74254 = 0;
    
    for ( weaponindex = 0; weaponindex < self.primaryinventory.size ; weaponindex++ )
    {
        weapon = self.primaryinventory[ weaponindex ];
        correctslot = weapon::function_6b74ecd475e99b4( weapon );
        
        if ( !correctslot || isnullweapon( weapon ) )
        {
            continue;
        }
        
        if ( var_d29e958430b74254 == slotid )
        {
            return weaponindex;
        }
        
        var_d29e958430b74254++;
    }
}

// Namespace item_weapon
// Params 1
// Checksum 0x77eb6478, Offset: 0x7184
// Size: 0xd8
function function_1464d1c9177c4934( weaponobject )
{
    if ( !isdefined( weaponobject ) )
    {
        return;
    }
    
    if ( !isweapon( weaponobject ) )
    {
        assertmsg( "<dev string:xc9e>" + ( isstring( weaponobject ) ? "<dev string:xce7>" + weaponobject : "<dev string:xcfb>" ) );
        return;
    }
    
    if ( !isdefined( self.primaryinventory ) )
    {
        assertmsg( "<dev string:xcfc>" );
        return;
    }
    
    primaryweaponslist = self.primaryinventory;
    var_20d278cbff22e4e1 = weaponobject getnoaltweapon();
    
    for ( i = 0; i < primaryweaponslist.size ; i++ )
    {
        weapon = primaryweaponslist[ i ];
        
        if ( issameweapon( weaponobject, weapon ) || isdefined( var_20d278cbff22e4e1 ) && !isnullweapon( var_20d278cbff22e4e1 ) && issameweapon( var_20d278cbff22e4e1, weapon ) )
        {
            return i;
        }
    }
}

// Namespace item_weapon
// Params 2
// Checksum 0xbce90b34, Offset: 0x7265
// Size: 0x8b
function function_6a2e65a74360c22d( newweapon, var_c66a6d657e0c9cb0 )
{
    if ( !common_inventory::inventory_isenabled() )
    {
        return [ undefined, undefined ];
    }
    
    if ( !common_inventory::function_d33e11a8dda3cb20() )
    {
        return [ 2, undefined ];
    }
    
    weapon = common_inventory::function_7bf60ff8870e96b4();
    
    if ( function_5ac30ad8bde2e072( newweapon, weapon ) && function_42dc19da11258ab1( weapon ) && var_c66a6d657e0c9cb0 )
    {
        return [ undefined, undefined ];
    }
    
    return [ 2, weapon ];
}

// Namespace item_weapon
// Params 1
// Checksum 0x45b51972, Offset: 0x72f9
// Size: 0x58, Type: bool
function function_c37bb4c61a4bbc01( newweapon )
{
    var_c5e5ae3401f77b2c = self.primaryinventory;
    
    for ( i = 0; i < var_c5e5ae3401f77b2c.size ; i++ )
    {
        weapon = var_c5e5ae3401f77b2c[ i ];
        
        if ( function_a9352cb53e91dc48( weapon, newweapon ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace item_weapon
// Params 3
// Checksum 0xc82359b5, Offset: 0x735a
// Size: 0x340
function function_6e9acdbb392dabc5( newweapon, var_c66a6d657e0c9cb0, autouse )
{
    var_c5e5ae3401f77b2c = self.primaryinventory;
    
    if ( autouse && function_28143f0282865199( self ) )
    {
        [ var_4740bdd547804d48, var_fac8d95c35f39bd2 ] = function_44ec91a3fb826ea0( newweapon );
        
        if ( isdefined( var_4740bdd547804d48 ) && isdefined( var_fac8d95c35f39bd2 ) )
        {
            return [ var_4740bdd547804d48, var_fac8d95c35f39bd2 ];
        }
    }
    
    if ( var_c66a6d657e0c9cb0 )
    {
        for ( i = 0; i < var_c5e5ae3401f77b2c.size ; i++ )
        {
            weapon = var_c5e5ae3401f77b2c[ i ];
            
            if ( function_a9352cb53e91dc48( weapon, newweapon ) )
            {
                return [ undefined, undefined ];
            }
        }
        
        for ( i = 0; i < var_c5e5ae3401f77b2c.size ; i++ )
        {
            weapon = var_c5e5ae3401f77b2c[ i ];
            
            if ( weapon::isfistweapon( weapon ) )
            {
                return [ i, weapon ];
            }
            
            if ( function_9a923c52240cc9d3() && weapon::function_6b74ecd475e99b4( weapon ) )
            {
                return [ i, weapon ];
            }
        }
        
        return [ undefined, undefined ];
    }
    
    if ( weapon::function_6b74ecd475e99b4( newweapon ) )
    {
        if ( isdefined( self.var_cc1262e66dbb1c79 ) )
        {
            var_8d02924bbe080f40 = function_1464d1c9177c4934( self.var_cc1262e66dbb1c79 );
            
            if ( var_8d02924bbe080f40 < var_c5e5ae3401f77b2c.size )
            {
                return [ var_8d02924bbe080f40, var_c5e5ae3401f77b2c[ var_8d02924bbe080f40 ] ];
            }
        }
        
        return [ undefined, undefined ];
    }
    
    for ( i = 0; i < var_c5e5ae3401f77b2c.size ; i++ )
    {
        weapon = var_c5e5ae3401f77b2c[ i ];
        
        if ( function_a9352cb53e91dc48( weapon, newweapon ) )
        {
            return [ i, weapon ];
        }
    }
    
    for ( i = 0; i < var_c5e5ae3401f77b2c.size ; i++ )
    {
        weapon = var_c5e5ae3401f77b2c[ i ];
        
        if ( weapon::isfistweapon( weapon ) )
        {
            return [ i, weapon ];
        }
        
        if ( function_9a923c52240cc9d3() && weapon::function_6b74ecd475e99b4( weapon ) && !isdefined( self.var_cc1262e66dbb1c79 ) )
        {
            return [ i, weapon ];
        }
    }
    
    currentweapon = self function_ca1904a5dd87fd53() ?? self getcurrentweapon();
    
    if ( currentweapon.isalternate )
    {
        currentweapon = currentweapon getnoaltweapon();
    }
    
    if ( weapon::iscurrenttertiaryweapon( self, currentweapon ) )
    {
        if ( isdefined( self.var_d1f2a060c3780533 ) )
        {
            var_3724be537c316baf = function_1464d1c9177c4934( self.var_d1f2a060c3780533 );
            
            if ( var_3724be537c316baf < var_c5e5ae3401f77b2c.size )
            {
                return [ var_3724be537c316baf, var_c5e5ae3401f77b2c[ var_3724be537c316baf ] ];
            }
        }
        
        return [ 0, var_c5e5ae3401f77b2c[ 0 ] ];
    }
    else
    {
        if ( function_46d840bd6268e2ce( currentweapon ) )
        {
            currentweaponindex = function_1464d1c9177c4934( currentweapon );
            
            if ( currentweaponindex < var_c5e5ae3401f77b2c.size )
            {
                return [ currentweaponindex, var_c5e5ae3401f77b2c[ currentweaponindex ] ];
            }
        }
        
        index = -1;
        
        for ( i = 0; i < var_c5e5ae3401f77b2c.size ; i++ )
        {
            weapon = var_c5e5ae3401f77b2c[ i ];
            
            if ( function_46d840bd6268e2ce( weapon ) )
            {
                if ( !self ishighpriorityweapon( weapon ) )
                {
                    return [ i, weapon ];
                }
                
                index = i;
            }
        }
        
        if ( index >= 0 )
        {
            return [ index, var_c5e5ae3401f77b2c[ index ] ];
        }
    }
    
    return [ undefined, undefined ];
}

// Namespace item_weapon
// Params 1
// Checksum 0xb3c3b8d6, Offset: 0x76a3
// Size: 0xce
function function_ab5ff5980e9d9950( var_96e87e6bed7aa700 )
{
    if ( !isdefined( var_96e87e6bed7aa700 ) )
    {
        return;
    }
    
    if ( !isdefined( self.primaryinventory[ var_96e87e6bed7aa700 ] ) || !isdefined( self.primaryweapons ) )
    {
        assertmsg( "<dev string:xcfc>" );
        return;
    }
    
    var_b391387f1ceba45d = self.primaryinventory[ var_96e87e6bed7aa700 ];
    var_1dd79f56427fcb91 = var_b391387f1ceba45d getnoaltweapon();
    primaryweaponslist = self.primaryweapons;
    
    for ( i = 0; i < primaryweaponslist.size ; i++ )
    {
        weapon = primaryweaponslist[ i ];
        
        if ( issameweapon( var_b391387f1ceba45d, weapon ) || isdefined( var_1dd79f56427fcb91 ) && !isnullweapon( var_1dd79f56427fcb91 ) && issameweapon( var_1dd79f56427fcb91, weapon ) )
        {
            return i;
        }
    }
}

// Namespace item_weapon
// Params 1
// Checksum 0x680be42d, Offset: 0x777a
// Size: 0x65, Type: bool
function function_46d840bd6268e2ce( weap )
{
    var_6b74ecd475e99b4 = weapon::function_6b74ecd475e99b4( weap );
    var_19612f31fee6152e = weapon::isfistweaponobject( weap ) || !var_6b74ecd475e99b4 && weapons::isdroppableweapon( self, weap ) || function_9a923c52240cc9d3() && var_6b74ecd475e99b4;
    return var_19612f31fee6152e && !weapon::isbackuppistol( weap );
}

// Namespace item_weapon
// Params 1
// Checksum 0x5c3ed9b8, Offset: 0x77e8
// Size: 0x20, Type: bool
function function_42dc19da11258ab1( weap )
{
    return function_46d840bd6268e2ce( weap ) || weapon::function_6b74ecd475e99b4( weap );
}

// Namespace item_weapon
// Params 1
// Checksum 0x2a95681a, Offset: 0x7811
// Size: 0x11b
function function_f9f6a26369a4edf4( weapindex )
{
    slotname = function_72e6bdd2cc8a6199( weapindex );
    var_98072c02586d07c0 = function_e7484276ad85f220( slotname );
    
    if ( !isdefined( var_98072c02586d07c0 ) )
    {
        return;
    }
    
    if ( function_9a923c52240cc9d3() && weapon::function_6b74ecd475e99b4( var_98072c02586d07c0 ) )
    {
        return;
    }
    
    if ( weapon::isfistweapon( var_98072c02586d07c0 ) )
    {
        return;
    }
    
    if ( common_inventory::function_d33e11a8dda3cb20() )
    {
        function_cfd26324d14e4149();
    }
    else
    {
        fistsweapon = level.defaultfist;
        
        if ( !self hasweapon( level.defaultfist ) )
        {
            self giveweapon( fistsweapon );
            function_55c302d95295530f( level.defaultfist, 0, function_1464d1c9177c4934( level.defaultfist ) );
        }
        
        switchindex = weapindex == 1 ? 0 : 1;
        var_51a96ade7d701039 = function_72e6bdd2cc8a6199( switchindex );
        weapontoswitch = function_e7484276ad85f220( var_51a96ade7d701039 );
        
        if ( !isdefined( weapontoswitch ) )
        {
            weapontoswitch = fistsweapon;
        }
        
        inventory_utility::_switchtoweaponimmediate( weapontoswitch );
    }
    
    common_inventory::function_1923cd40e1b4efc8( var_98072c02586d07c0 );
    self takeweapon( var_98072c02586d07c0 );
}

// Namespace item_weapon
// Params 1
// Checksum 0xeefebe28, Offset: 0x7934
// Size: 0xbd
function function_db94c1441f6cd802( excludefists )
{
    numprimaries = self.primaryweapons.size;
    
    foreach ( weap in self.primaryweapons )
    {
        if ( isnullweapon( weap ) || !function_46d840bd6268e2ce( weap ) || excludefists && weapon::isfistweapon( weap ) )
        {
            numprimaries--;
        }
    }
    
    return numprimaries;
}

// Namespace item_weapon
// Params 3, eflags: 0x4
// Checksum 0x2fea8802, Offset: 0x79fa
// Size: 0x9c
function private function_944a2ca8570a3156( oldweaponstockammo, newweaponobj, newweaponstockammo )
{
    var_482e9999b75ed3d8 = istrue( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_z_mod", #"z_mod_pack_mule" ) );
    var_af4c671c5aa815de = utility::get_max_stock_ammo( newweaponobj, var_482e9999b75ed3d8 );
    var_999f465e28288b03 = var_af4c671c5aa815de - newweaponstockammo;
    
    if ( oldweaponstockammo > var_999f465e28288b03 )
    {
        oldweaponstockammo -= var_999f465e28288b03;
        newweaponstockammo = var_af4c671c5aa815de;
    }
    else
    {
        newweaponstockammo += oldweaponstockammo;
        oldweaponstockammo = 0;
    }
    
    return [ oldweaponstockammo, newweaponstockammo ];
}

// Namespace item_weapon
// Params 1
// Checksum 0x59539682, Offset: 0x7a9f
// Size: 0x22
function function_dc8d4a742844a795( weaponobj )
{
    if ( weaponobj.hasalternate )
    {
        return weaponobj function_195d62e346d13f13();
    }
    
    return 0;
}

// Namespace item_weapon
// Params 1
// Checksum 0x9776ee88, Offset: 0x7aca
// Size: 0x48
function function_d4168a97cc3044b0( baseweapon )
{
    if ( !isdefined( baseweapon ) )
    {
        return;
    }
    
    var_685573a854ce8718 = level.commonitem.var_685573a854ce8718[ baseweapon ];
    
    if ( isdefined( var_685573a854ce8718 ) )
    {
        return var_685573a854ce8718.transform;
    }
}

// Namespace item_weapon
// Params 3
// Checksum 0x7dbd3ec3, Offset: 0x7b1b
// Size: 0xe2
function function_3da93a43aae4473d( baseweapon, rarity, blueprintindex )
{
    if ( !isdefined( baseweapon ) )
    {
        assertmsg( "<dev string:xd5b>" );
        return;
    }
    
    var_685573a854ce8718 = level.commonitem.var_685573a854ce8718[ baseweapon ];
    
    if ( isdefined( var_685573a854ce8718.bundles ) )
    {
        if ( !( isdefined( blueprintindex ) && isdefined( var_685573a854ce8718.bundles[ blueprintindex ] ) ) )
        {
            blueprintindex = var_685573a854ce8718.var_d409d08ebfd660dd ?? 0;
        }
        
        if ( !isdefined( var_685573a854ce8718.bundles[ blueprintindex ] ) )
        {
            return;
        }
        
        if ( !( isdefined( rarity ) && isdefined( var_685573a854ce8718.bundles[ blueprintindex ][ rarity ] ) ) )
        {
            rarity = var_685573a854ce8718.var_9cc71d1c7d6cdc27[ blueprintindex ] ?? 0;
        }
        
        return var_685573a854ce8718.bundles[ blueprintindex ][ rarity ];
    }
}

// Namespace item_weapon
// Params 1, eflags: 0x4
// Checksum 0x1ff47886, Offset: 0x7c05
// Size: 0x7c, Type: bool
function private function_c5f6a5d130d7cd6c( itembundle )
{
    baseweaponlootid = common_item::function_779887309ec71dfe( itembundle );
    
    if ( !baseweaponlootid )
    {
        return false;
    }
    
    if ( !itembundle.baseweapon || !itembundle.weaponblueprint )
    {
        return false;
    }
    
    blueprintbundle = function_18358df7912f6208( itembundle.baseweapon, itembundle.weaponblueprint );
    return blueprintbundle.lootid ?? 0;
}

// Namespace item_weapon
// Params 1
// Checksum 0xc6c1f9d6, Offset: 0x7c8a
// Size: 0x9d, Type: bool
function function_4591efaaa1c03edd( itembundle )
{
    baseweaponlootid = common_item::function_779887309ec71dfe( itembundle );
    
    if ( !baseweaponlootid )
    {
        return false;
    }
    
    if ( !itembundle.baseweapon || !itembundle.weaponblueprint )
    {
        return false;
    }
    
    blueprintbundle = function_18358df7912f6208( itembundle.baseweapon, itembundle.weaponblueprint );
    
    if ( !blueprintbundle.lootid )
    {
        return false;
    }
    
    blueprintindex = function_4d465a88a4c974d3( blueprintbundle.lootid );
    return blueprintindex ?? 0;
}

// Namespace item_weapon
// Params 0
// Checksum 0xcbfba24f, Offset: 0x7d30
// Size: 0x64
function function_f75620a38a24072()
{
    scriptable = %"loot_weapon_generic";
    
    if ( isdefined( level.gametypebundle.var_9d7bd1394c38803a ) )
    {
        gametypescriptable = getscriptbundlefieldvalue( level.gametypebundle.var_9d7bd1394c38803a, #"scriptable" );
        
        if ( isdefined( gametypescriptable ) )
        {
            scriptable = gametypescriptable;
        }
    }
    
    return scriptable;
}

// Namespace item_weapon
// Params 0
// Checksum 0xec44d4a2, Offset: 0x7d9d
// Size: 0x61
function function_56a1baf9422bf1d4()
{
    scriptable = function_f75620a38a24072();
    
    if ( isdefined( level.gametypebundle.var_a3ca491bc6c8634c ) )
    {
        gametypescriptable = getscriptbundlefieldvalue( level.gametypebundle.var_a3ca491bc6c8634c, #"scriptable" );
        
        if ( isdefined( gametypescriptable ) )
        {
            scriptable = gametypescriptable;
        }
    }
    
    return scriptable;
}

// Namespace item_weapon
// Params 0
// Checksum 0xb5f032b, Offset: 0x7e07
// Size: 0x36
function function_e11b7333d211c17e()
{
    return isdefined( level.gametypebundle.var_9d7bd1394c38803a ) ? common_item::function_b01955b20c77371d( level.gametypebundle.var_9d7bd1394c38803a ) : 0;
}

// Namespace item_weapon
// Params 0
// Checksum 0x6e5d1039, Offset: 0x7e46
// Size: 0x16, Type: bool
function function_42cb187ac9540196()
{
    return istrue( level.gametypebundle.var_a0c5bb9ee61fd2b5 );
}

// Namespace item_weapon
// Params 2
// Checksum 0x202793dc, Offset: 0x7e65
// Size: 0x72
function function_5ac30ad8bde2e072( newweapon, oldweapon )
{
    if ( function_42cb187ac9540196() )
    {
        if ( issameweapon( newweapon, oldweapon ) )
        {
            return 1;
        }
    }
    else if ( newweapon.basename == oldweapon.basename )
    {
        return 1;
    }
    
    return callback::response( 0, #"hash_47152191e641a442", { #oldweapon:oldweapon, #newweapon:newweapon } );
}

// Namespace item_weapon
// Params 2
// Checksum 0x29853395, Offset: 0x7ee0
// Size: 0x6f
function function_a9352cb53e91dc48( var_421a8e537d82e2ee, newweapon )
{
    if ( function_5ac30ad8bde2e072( newweapon, var_421a8e537d82e2ee ) )
    {
        if ( function_46d840bd6268e2ce( var_421a8e537d82e2ee ) )
        {
            return 1;
        }
        
        if ( !function_9a923c52240cc9d3() && weapon::function_6b74ecd475e99b4( var_421a8e537d82e2ee ) )
        {
            return 1;
        }
    }
    
    return callback::response( 0, #"hash_6d84bb11b9d0a738", { #newweapon:newweapon, #oldweapon:var_421a8e537d82e2ee } );
}

// Namespace item_weapon
// Params 0
// Checksum 0xc702d7cf, Offset: 0x7f58
// Size: 0xab, Type: bool
function function_de6f68adce59a780()
{
    foreach ( weapon in self.primaryweapons )
    {
        if ( !weapon )
        {
            continue;
        }
        
        if ( !function_46d840bd6268e2ce( weapon ) )
        {
            continue;
        }
        
        rootname = weapon::getweaponrootname( weapon );
        
        if ( rootname != "none" )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace item_weapon
// Params 1
// Checksum 0x3bf4f710, Offset: 0x800c
// Size: 0x11
function function_269326131494fb85( itembundle )
{
    return 4294967295;
}

// Namespace item_weapon
// Params 1
// Checksum 0xc0598db, Offset: 0x8026
// Size: 0x13c
function function_165956c3013b4abf( weaponobj )
{
    if ( item_ammo::function_fdb7ca5c724bcb5c() )
    {
        ammotype = item_ammo::function_b162feeed34a4640( weaponobj );
        
        if ( !isdefined( ammotype ) )
        {
            return;
        }
        
        lootid = common_item::function_cb980b90c836804e( ammotype );
        sortedammo = common_inventory::function_4436b2f08e588b8( lootid );
        
        foreach ( index in sortedammo )
        {
            backpackammo = common_inventory::inventory_getquantityatbackpackindex( index );
            clipsize = weaponclipsize( weaponobj );
            ammoinclip = self getweaponammoclip( weaponobj );
            self setweaponammoclip( weaponobj, minint( clipsize, backpackammo + ammoinclip ) );
            var_90be0d90e85c2164 = clipsize - ammoinclip;
            var_9bac93b2ceda38ea = backpackammo - var_90be0d90e85c2164;
            common_inventory::inventory_setbackpackitematindex( index, lootid, maxint( 0, var_9bac93b2ceda38ea ) );
            
            if ( var_9bac93b2ceda38ea >= 0 )
            {
                break;
            }
        }
        
        return 1;
    }
    
    return 0;
}

// Namespace item_weapon
// Params 2
// Checksum 0x51057298, Offset: 0x816b
// Size: 0xd1, Type: bool
function function_ec55b6cd928fb1a6( player, weaponobj )
{
    var_ceb6c50f374074a0 = function_f75620a38a24072();
    var_d6a4b79e04be953 = utility::callsharedfunc( #"game", #"hash_2d6603ce4710caa8", var_ceb6c50f374074a0 );
    ammocount = common_item::function_598dd39282efb544( weaponclipsize( weaponobj ) );
    weapondata = { #itembundlename:var_d6a4b79e04be953, #var_3df5b0fceaf91931:1 };
    item = { #var_6828becb300b1c44:weapondata, #count:ammocount, #type:var_ceb6c50f374074a0, #weaponobj:weaponobj };
    var_6bbe1e5bccb9d7dd = function_5be1bc100827adc7( var_d6a4b79e04be953, item, 1 );
    return isdefined( var_6bbe1e5bccb9d7dd );
}

// Namespace item_weapon
// Params 5
// Checksum 0xc9a732ee, Offset: 0x8245
// Size: 0xc3
function function_482c254183dec1b5( index, bundle, lootid, quantity, groupid )
{
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    weaponobj = function_477bf1207c6672a5( bundle );
    ammotype = item_ammo::function_b162feeed34a4640( weaponobj );
    
    if ( !isdefined( ammotype ) )
    {
        return;
    }
    
    dropquantity = item_ammo::function_b956ec34b65538e( ammotype );
    remainder = item_ammo::function_d668d164f515b571( self, weaponobj, dropquantity * -1 );
    dropquantity = int( dropquantity - abs( remainder ) );
    
    if ( dropquantity == 0 )
    {
        return;
    }
    
    spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
    common_item::function_325e28c0fb65c36a( ammotype, dropquantity, spawnoptions );
}

// Namespace item_weapon
// Params 4
// Checksum 0xf9148f39, Offset: 0x8310
// Size: 0xc6
function function_96add18b226ff731( weaponobj, var_3df5b0fceaf91931, weapondata, skipfirstraise )
{
    if ( var_3df5b0fceaf91931 )
    {
        var_ceb6c50f374074a0 = function_f75620a38a24072();
    }
    
    ammocount = undefined;
    
    if ( isdefined( weaponobj ) )
    {
        ammocount = function_40acef7fe7fe290( weaponobj );
    }
    
    if ( !isdefined( weapondata ) )
    {
        weapondata = function_fdc74b9be99fda2f( weaponobj );
        weapondata.var_3df5b0fceaf91931 = var_3df5b0fceaf91931;
    }
    
    item = { #skipfirstraise:skipfirstraise, #var_6828becb300b1c44:weapondata, #count:ammocount, #type:var_ceb6c50f374074a0, #weaponobj:weaponobj };
    common_item::function_2b5e2ff57d5f392( item, 0, 1 );
}

// Namespace item_weapon
// Params 0
// Checksum 0xe66836ff, Offset: 0x83de
// Size: 0xd5, Type: bool
function function_9569f8c5584b505c()
{
    var_d2808b5da0b3a896 = [];
    
    foreach ( weapon in self.primaryweapons )
    {
        ammotype = item_ammo::function_b162feeed34a4640( weapon );
        
        if ( var_d2808b5da0b3a896[ ammotype ] )
        {
            continue;
        }
        
        playerstock = item_ammo::function_f01abfab49a719a0( self, weapon ) ?? self.ammostock[ ammotype ];
        
        if ( playerstock < item_ammo::function_9aecfd8b12f7ed0e( weapon, ammotype ) )
        {
            return false;
        }
        
        var_d2808b5da0b3a896[ ammotype ] = 1;
    }
    
    return true;
}

// Namespace item_weapon
// Params 0, eflags: 0x4
// Checksum 0xbd3396a6, Offset: 0x84bc
// Size: 0x16, Type: bool
function private function_9a923c52240cc9d3()
{
    return istrue( level.commonitem.var_cd902972aae40099 );
}

// Namespace item_weapon
// Params 2
// Checksum 0xcad5d284, Offset: 0x84db
// Size: 0x90
function function_40acef7fe7fe290( weaponobj, rarity )
{
    if ( !isdefined( weaponobj ) )
    {
        return;
    }
    
    var_a1c96baaf227b40b = weaponobj getnoaltweapon();
    ammoclipright = weaponclipsize( var_a1c96baaf227b40b );
    ammoclipleft = var_a1c96baaf227b40b.isdualwield ? weaponclipsize( var_a1c96baaf227b40b ) : undefined;
    ammoclipalt = 0;
    
    if ( !function_dc8d4a742844a795( var_a1c96baaf227b40b ) )
    {
        ammoclipalt = weaponclipsize( var_a1c96baaf227b40b getaltweapon() );
    }
    
    return common_item::function_598dd39282efb544( ammoclipright, ammoclipleft, ammoclipalt, rarity );
}

// Namespace item_weapon
// Params 2, eflags: 0x4
// Checksum 0xbb709e26, Offset: 0x8574
// Size: 0x98
function private function_b7cc195bab9a5c92( weaponobj, rarity )
{
    if ( !isdefined( weaponobj ) )
    {
        return;
    }
    
    var_a1c96baaf227b40b = weaponobj getnoaltweapon();
    ammoclipright = self getweaponammoclip( var_a1c96baaf227b40b );
    ammoclipleft = var_a1c96baaf227b40b.isdualwield ? self getweaponammoclip( var_a1c96baaf227b40b, "left" ) : undefined;
    ammoclipalt = 0;
    
    if ( !function_dc8d4a742844a795( var_a1c96baaf227b40b ) )
    {
        ammoclipalt = self getweaponammoclip( var_a1c96baaf227b40b getaltweapon() );
    }
    
    return common_item::function_598dd39282efb544( ammoclipright, ammoclipleft, ammoclipalt, rarity );
}

// Namespace item_weapon
// Params 2, eflags: 0x4
// Checksum 0x6d6e66a4, Offset: 0x8615
// Size: 0x59
function private function_738e75077335e101( player, weaponobj )
{
    player utility::callsharedfunc( #"pack_a_punch", #"hash_4fb89d74adceafac", weaponobj, undefined );
    
    if ( isdefined( player.var_60c2ab39157e81d2 ) )
    {
        player.var_60c2ab39157e81d2[ weaponobj.var_1616e6fbba9a722d ] = undefined;
    }
}

// Namespace item_weapon
// Params 0
// Checksum 0x3eb0e47c, Offset: 0x8676
// Size: 0x4a
function function_21fb8b54da9c5825()
{
    maxheldweapons = self.var_ea52c11dcd2aecad ?? 2;
    var_9f695aa5fcd211c4 = utility::callsharedfunc( #"item_weapon", #"hash_7347b2185d2c7180" );
    
    if ( isdefined( var_9f695aa5fcd211c4 ) )
    {
        maxheldweapons = var_9f695aa5fcd211c4;
    }
    
    return maxheldweapons;
}

// Namespace item_weapon
// Params 0, eflags: 0x4
// Checksum 0xdf320fc7, Offset: 0x86c9
// Size: 0xd4
function private function_493bc69c1224a3fc()
{
    weaponlist = self getweaponslistprimaries();
    var_dd13034a715e508 = 0;
    
    if ( weaponlist.size > 0 )
    {
        foreach ( weapon in weaponlist )
        {
            if ( !weapon::function_6b74ecd475e99b4( weapon ) || weapon::isfistsonly( weapon ) )
            {
                items_weapon_removeweapon( { #var_5156a93210ad2807:1, #dontdrop:1, #weapon:weapon } );
                var_dd13034a715e508 = 1;
            }
        }
    }
    
    return var_dd13034a715e508;
}

// Namespace item_weapon
// Params 1, eflags: 0x4
// Checksum 0xa6d7b73f, Offset: 0x87a6
// Size: 0x227
function private function_44fc01cf2d73796( cachesource )
{
    if ( self.var_1d7366a768685940 )
    {
        return 0;
    }
    
    weaponlist = self getweaponslistprimaries();
    
    if ( weaponlist.size > 0 )
    {
        self.var_1d7366a768685940 = spawnstruct();
        self.var_1d7366a768685940.lastweaponobj = self getcurrentweapon();
        self.var_1d7366a768685940.weaponstructs = [];
        var_fba2d76808ef6526 = 0;
        
        foreach ( weapon in weaponlist )
        {
            if ( !weapon::function_6b74ecd475e99b4( weapon ) || weapon::isfistsonly( weapon ) )
            {
                if ( !weapon.isalternate && function_46d840bd6268e2ce( weapon ) )
                {
                    weaponstruct = spawnstruct();
                    weaponstruct.weaponobj = weapon;
                    weaponstruct.clipammo = self getweaponammoclip( weapon );
                    weaponstruct.stockammo = self getweaponammostock( weapon );
                    
                    if ( weapon::isakimbo( weapon ) )
                    {
                        weaponstruct.clipammo_left = self getweaponammoclip( weapon, "left" );
                    }
                    
                    weaponstruct.paplevel = utility::callsharedfunc( #"pack_a_punch", #"get_pap_level", weapon );
                    weaponstruct.rarity = utility::callsharedfunc( #"zombie", #"GetPlayerWeaponRarity", weapon );
                    weaponstruct.ammomod = utility::callsharedfunc( #"zombie", #"get_ammo_mod_name", weapon );
                    self.var_1d7366a768685940.weaponstructs[ self.var_1d7366a768685940.weaponstructs.size ] = weaponstruct;
                }
                
                function_9e7275fa51ace996( weapon, cachesource );
                var_fba2d76808ef6526 = 1;
            }
        }
        
        return var_fba2d76808ef6526;
    }
    
    return 0;
}

// Namespace item_weapon
// Params 0, eflags: 0x4
// Checksum 0xc7e6f95, Offset: 0x89d6
// Size: 0x233
function private function_842bd73027ce0146()
{
    var_a59270232f284c16 = 0;
    
    if ( isdefined( self ) && isdefined( self.var_1d7366a768685940 ) )
    {
        if ( isdefined( self.var_1d7366a768685940.weaponstructs ) )
        {
            foreach ( weaponstruct in self.var_1d7366a768685940.weaponstructs )
            {
                function_35910aac16378fec( weaponstruct.weaponobj, weaponstruct.clipammo, weaponstruct.stockammo );
                function_d6a514964e1e7f2c( weaponstruct.weaponobj );
                
                if ( weaponstruct.paplevel > 0 )
                {
                    utility::callsharedfunc( #"pack_a_punch", #"hash_4fb89d74adceafac", weaponstruct.weaponobj, weaponstruct.paplevel, 1 );
                }
                
                utility::callsharedfunc( #"zombie", #"hash_e546039029657cd5", weaponstruct.weaponobj, weaponstruct.rarity );
                
                if ( weaponstruct.ammomod )
                {
                    utility::callsharedfunc( #"zombie", #"hash_24f1a2cf1ed6660d", weaponstruct.weaponobj, weaponstruct.ammomod );
                }
                
                if ( weapon::isakimbo( weaponstruct.weaponobj ) && weaponstruct.clipammo_left >= 0 )
                {
                    self setweaponammoclip( weaponstruct.weaponobj, weaponstruct.clipammo_left, "left" );
                }
                
                if ( self.var_1d7366a768685940.lastweaponobj == weaponstruct.weaponobj )
                {
                    self switchtoweaponimmediate( weaponstruct.weaponobj );
                }
                
                weapon::fixupplayerweapons( self, weaponstruct.weaponobj );
                var_a59270232f284c16 = 1;
            }
        }
        
        self.var_1d7366a768685940 = undefined;
    }
    
    return var_a59270232f284c16;
}

/#

    // Namespace item_weapon
    // Params 0, eflags: 0x4
    // Checksum 0xbf7b0d62, Offset: 0x8c12
    // Size: 0x245, Type: dev
    function private function_337c509c85374ffb()
    {
        if ( getdvarint( @"debug_common_item", isbrgamemode() ) == 0 )
        {
            return;
        }
        
        setdvarifuninitialized( @"hash_e981f2369f02b682", 350 );
        setdvarifuninitialized( @"hash_21adc9eb44b3d7ed", 20 );
        setdvarifuninitialized( @"hash_aac79e2ab4af9ee7", 1 );
        setdvarifuninitialized( @"hash_8b93e6e651c920bb", 1 );
        
        if ( !isdefined( level.commonitemdebug ) )
        {
            level.commonitemdebug = spawnstruct();
        }
        
        level.commonitemdebug.weapondevgui = [];
        level.commonitemdebug.var_4e3ab00349a607ed = [];
        level.commonitemdebug.var_ecab07da0d246465 = [];
        devgui::function_9082edeb5db93280( "<dev string:xdc4>" );
        devgui::function_eaac4ba4b3caf621( "<dev string:xdd9>", @"hash_d1415bb7a04b48f9" );
        devgui::function_eaac4ba4b3caf621( "<dev string:xded>", @"hash_b5df8cb15e263558" );
        devgui::function_cd4e263c1f3018ae( "<dev string:xdff>", "<dev string:xe0c>", &function_f58cc06fb03d52ad );
        devgui::function_cd4e263c1f3018ae( "<dev string:xe33>", "<dev string:xe42>", &function_f58cc06fb03d52ad );
        devgui::function_cd4e263c1f3018ae( "<dev string:xe6b>", "<dev string:xe80>", &function_f58cc06fb03d52ad );
        devgui::function_cd4e263c1f3018ae( "<dev string:xea8>", "<dev string:xec6>", &function_42038dd691c35b93, 0 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xeda>", "<dev string:xefa>", &function_42038dd691c35b93, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xf0e>", "<dev string:xf29>", &function_42038dd691c35b93, 2 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xf3d>", "<dev string:xf5a>", &function_42038dd691c35b93, 3 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xf6e>", "<dev string:xf90>", &function_42038dd691c35b93, 4 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xfa4>", "<dev string:xfbf>", &function_42038dd691c35b93, 5 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xfd3>", "<dev string:xff2>", &function_42038dd691c35b93, 6 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1006>", "<dev string:x101c>", &function_cce24ea500ec9f53, 0 );
        devgui::function_eaac4ba4b3caf621( "<dev string:x1042>", @"hash_8b93e6e651c920bb", 1 );
        devgui::add_devgui_dvar( "<dev string:x105d>", "<dev string:x1072>", 2 );
        devgui::add_devgui_dvar( "<dev string:x10b0>", "<dev string:x10c5>", 3 );
        devgui::add_devgui_dvar( "<dev string:x1103>", "<dev string:x1115>", 4 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace item_weapon
    // Params 1, eflags: 0x4
    // Checksum 0xb8af19b0, Offset: 0x8e5f
    // Size: 0x2c9, Type: dev
    function private function_2ab35ff6cbd1616a( item_bundle_name )
    {
        item_bundle = getscriptbundlefieldvalues( item_bundle_name, [ #"ref", #"subtype", #"rarity", #"scriptable" ] );
        
        if ( !isdefined( item_bundle.ref ) || getdvarint( @"debug_common_item", isbrgamemode() ) == 0 )
        {
            return;
        }
        
        if ( !item_bundle.scriptable || function_3f148667e2289988( item_bundle.scriptable ) )
        {
            return;
        }
        
        subtype = isdefined( item_bundle.subtype ) && item_bundle.subtype != "<dev string:xcfb>" ? item_bundle.subtype : "<dev string:x1151>";
        rarity = isdefined( item_bundle.rarity ) ? string( item_bundle.rarity ) : "<dev string:x1153>";
        
        if ( !isdefined( level.commonitemdebug.weapondevgui[ subtype ] ) )
        {
            level.commonitemdebug.weapondevgui[ subtype ] = { #refs:[], #generated:0 };
            devgui::function_cd4e263c1f3018ae( "<dev string:x1155>" + subtype, "<dev string:x1172>" + subtype, &function_d28f3dd145557f80, 0, 0 );
        }
        
        if ( !isdefined( level.commonitemdebug.weapondevgui[ subtype ].refs[ item_bundle.ref ] ) )
        {
            level.commonitemdebug.weapondevgui[ subtype ].refs[ item_bundle.ref ] = { #rarities:[], #generated:0 };
        }
        
        level.commonitemdebug.weapondevgui[ subtype ].refs[ item_bundle.ref ].rarities[ rarity ] = common_item::clean_name( item_bundle_name );
        
        if ( level.commonitemdebug.weapondevgui[ subtype ].generated )
        {
            if ( level.commonitemdebug.weapondevgui[ subtype ].refs[ item_bundle.ref ].generated )
            {
                function_d28f3dd145557f80( [ subtype, item_bundle.ref, rarity ] );
                return;
            }
            
            function_d28f3dd145557f80( [ subtype, item_bundle.ref ] );
        }
    }

    // Namespace item_weapon
    // Params 1, eflags: 0x4
    // Checksum 0xcf8ecec3, Offset: 0x9130
    // Size: 0x111, Type: dev
    function private function_f58cc06fb03d52ad( params )
    {
        foreach ( player in level.players )
        {
            weapon = player getcurrentweapon();
            index = player function_1464d1c9177c4934( weapon );
            
            if ( isdefined( index ) )
            {
                if ( params[ 0 ] == "<dev string:x1196>" )
                {
                    player items_weapon_removeweapon( { #weapon:weapon } );
                    continue;
                }
                
                if ( params[ 0 ] == "<dev string:x119b>" )
                {
                    player items_weapon_removeweapon( { #dontdrop:1, #weapon:weapon } );
                    continue;
                }
                
                if ( params[ 0 ] == "<dev string:x11a2>" )
                {
                    player inventory_utility::_takeweapon( weapon );
                }
            }
        }
    }

    // Namespace item_weapon
    // Params 1, eflags: 0x4
    // Checksum 0x6db7b508, Offset: 0x9249
    // Size: 0x95, Type: dev
    function private function_42038dd691c35b93( params )
    {
        foreach ( player in level.players )
        {
            player function_40e1cbd0e1f47d1a( player getcurrentweapon(), int( params[ 0 ] ) );
        }
    }

    // Namespace item_weapon
    // Params 1, eflags: 0x4
    // Checksum 0x42ff012a, Offset: 0x92e6
    // Size: 0x5e0, Type: dev
    function private function_d28f3dd145557f80( params )
    {
        subtype = params[ 0 ] ?? "<dev string:x1151>";
        item_ref = params[ 1 ];
        rarity = params[ 2 ];
        
        if ( isdefined( rarity ) )
        {
            rarity_menu = "<dev string:x11a8>" + rarity + "<dev string:x11ab>";
            
            switch ( rarity )
            {
                case #"hash_311010bc01bd3a0f":
                    rarity_menu = "<dev string:x11ad>";
                    break;
                case #"hash_31100fbc01bd387c":
                    rarity_menu = "<dev string:x11c3>";
                    break;
                case #"hash_311012bc01bd3d35":
                    rarity_menu = "<dev string:x11db>";
                    break;
                case #"hash_311011bc01bd3ba2":
                    rarity_menu = "<dev string:x11ee>";
                    break;
                case #"hash_31100cbc01bd33c3":
                    rarity_menu = "<dev string:x1203>";
                    break;
                case #"hash_31100bbc01bd3230":
                    rarity_menu = "<dev string:x121d>";
                    break;
                case #"hash_31100ebc01bd36e9":
                    rarity_menu = "<dev string:xcfb>";
                    break;
            }
            
            devgui_menu = "<dev string:x1155>" + subtype + "<dev string:x1232>" + item_ref + rarity_menu + "<dev string:x1234>";
            devgui::add_debug_command( "<dev string:x1237>" + devgui_menu + "<dev string:x1247>" );
            item_bundle_name = level.commonitemdebug.weapondevgui[ subtype ].refs[ item_ref ].rarities[ rarity ];
            devgui::function_cd4e263c1f3018ae( devgui_menu + "<dev string:x124a>", "<dev string:x1251>" + item_bundle_name, &common_item::devgui_spawn_item, 0, 0 );
            devgui::function_cd4e263c1f3018ae( devgui_menu + "<dev string:x125d>", "<dev string:x1264>" + item_bundle_name, &function_969fd778dc60eac7, 0, 1 );
            devgui::function_cd4e263c1f3018ae( devgui_menu + "<dev string:x1277>", "<dev string:x1280>" + item_bundle_name, &function_323ecdd0ecbf287b, 0, 2 );
            devgui::function_cd4e263c1f3018ae( devgui_menu + "<dev string:x1295>", "<dev string:x12a7>" + item_bundle_name, &function_cce24ea500ec9f53, 0, 3 );
            devgui::function_cd4e263c1f3018ae( devgui_menu + "<dev string:x12ce>", "<dev string:x12e0>" + item_bundle_name, &function_cce24ea500ec9f53, 0, 4 );
            devgui::function_cd4e263c1f3018ae( devgui_menu + "<dev string:x1307>", "<dev string:x1319>" + item_bundle_name, &function_cce24ea500ec9f53, 0, 5 );
            devgui::function_cd4e263c1f3018ae( devgui_menu + "<dev string:x1340>", "<dev string:x1353>" + item_bundle_name, &function_cce24ea500ec9f53, 0, 6 );
            devgui::add_debug_command( "<dev string:x137b>" + devgui_menu + "<dev string:x1247>" );
            level.commonitemdebug.weapondevgui[ subtype ].refs[ item_ref ].rarities[ rarity ] = undefined;
            return;
        }
        
        if ( isdefined( item_ref ) )
        {
            if ( level.commonitemdebug.weapondevgui[ subtype ].refs[ item_ref ].generated )
            {
                return;
            }
            
            level.commonitemdebug.weapondevgui[ subtype ].refs[ item_ref ].generated = 1;
            devgui_menu = "<dev string:x1155>" + subtype + "<dev string:x1232>" + item_ref + "<dev string:x1234>";
            devgui::add_debug_command( "<dev string:x1237>" + devgui_menu + "<dev string:x1247>" );
            
            foreach ( rarity, rarity_info in level.commonitemdebug.weapondevgui[ subtype ].refs[ item_ref ].rarities )
            {
                rarity_menu = "<dev string:x11a8>" + rarity + "<dev string:x11ab>";
                
                switch ( rarity )
                {
                    case #"hash_311010bc01bd3a0f":
                        rarity_menu = "<dev string:x11ad>";
                        break;
                    case #"hash_31100fbc01bd387c":
                        rarity_menu = "<dev string:x11c3>";
                        break;
                    case #"hash_311012bc01bd3d35":
                        rarity_menu = "<dev string:x11db>";
                        break;
                    case #"hash_311011bc01bd3ba2":
                        rarity_menu = "<dev string:x11ee>";
                        break;
                    case #"hash_31100cbc01bd33c3":
                        rarity_menu = "<dev string:x1389>";
                        break;
                    case #"hash_31100bbc01bd3230":
                        rarity_menu = "<dev string:x121d>";
                        break;
                    case #"hash_31100ebc01bd36e9":
                        function_d28f3dd145557f80( [ subtype, item_ref, rarity ] );
                        return;
                }
                
                devgui::function_cd4e263c1f3018ae( devgui_menu + rarity_menu, "<dev string:x1172>" + subtype + "<dev string:x13a2>" + item_ref + "<dev string:x13a2>" + rarity, &function_d28f3dd145557f80, 0, 0 );
            }
            
            devgui::add_debug_command( "<dev string:x137b>" + devgui_menu + "<dev string:x1247>" );
            return;
        }
        
        if ( level.commonitemdebug.weapondevgui[ subtype ].generated )
        {
            return;
        }
        
        level.commonitemdebug.weapondevgui[ subtype ].generated = 1;
        devgui_menu = "<dev string:x1155>" + subtype + "<dev string:x1234>";
        devgui::add_debug_command( "<dev string:x1237>" + devgui_menu + "<dev string:x1247>" );
        
        foreach ( item_ref, ref_info in level.commonitemdebug.weapondevgui[ subtype ].refs )
        {
            devgui::function_cd4e263c1f3018ae( devgui_menu + "<dev string:x1232>" + item_ref, "<dev string:x1172>" + subtype + "<dev string:x13a2>" + item_ref, &function_d28f3dd145557f80, 0, 0 );
        }
        
        devgui::add_debug_command( "<dev string:x137b>" + devgui_menu + "<dev string:x1247>" );
    }

    // Namespace item_weapon
    // Params 1, eflags: 0x4
    // Checksum 0x1f904bf9, Offset: 0x98ce
    // Size: 0xda, Type: dev
    function private function_969fd778dc60eac7( params )
    {
        itembundle = getscriptbundle( hashcat( %"itemspawnentry:", params[ 0 ] ) );
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( ( 0, 0, 0 ) );
        item = common_item::function_61c2c0251e742ffd( itembundle, undefined, spawnoptions );
        
        foreach ( player in level.players )
        {
            player common_item::function_2b5e2ff57d5f392( item, 0 );
        }
    }

    // Namespace item_weapon
    // Params 1, eflags: 0x4
    // Checksum 0x2e9b504, Offset: 0x99b0
    // Size: 0x146, Type: dev
    function private function_323ecdd0ecbf287b( params )
    {
        itembundle = getscriptbundle( hashcat( %"itemspawnentry:", params[ 0 ] ) );
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( ( 0, 0, 0 ) );
        item = common_item::function_61c2c0251e742ffd( itembundle, undefined, spawnoptions );
        
        foreach ( player in level.players )
        {
            currentweaponobj = player getcurrentweapon();
            currentweaponindex = player function_1464d1c9177c4934( currentweaponobj );
            
            if ( isdefined( currentweaponindex ) )
            {
                player function_c209a7870d8ab55( currentweaponindex );
            }
            
            player inventory_utility::_takeweapon( currentweaponobj );
            
            if ( weapon::function_6b74ecd475e99b4( currentweaponobj ) && self.var_cc1262e66dbb1c79 === currentweaponobj )
            {
                self.tertiaryWeapon = undefined;
                self.var_cc1262e66dbb1c79 = undefined;
            }
            
            player common_item::function_2b5e2ff57d5f392( item, 0 );
        }
    }

    // Namespace item_weapon
    // Params 1, eflags: 0x4
    // Checksum 0x15afd66d, Offset: 0x9afe
    // Size: 0x6c4, Type: dev
    function private function_cce24ea500ec9f53( params )
    {
        command = params[ 0 ];
        item_bundle_name = params[ 1 ];
        
        if ( command == "<dev string:x13a4>" )
        {
            if ( isdefined( item_bundle_name ) )
            {
                if ( isdefined( level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ] ) )
                {
                    level.commonitemdebug.var_ecab07da0d246465[ level.commonitemdebug.var_ecab07da0d246465.size ] = level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].index;
                    level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ] = undefined;
                }
            }
            else
            {
                level.commonitemdebug.var_4e3ab00349a607ed = [];
                level.commonitemdebug.var_f3f848c31f7802b4 = [];
            }
            
            return;
        }
        
        if ( command == "<dev string:x13aa>" )
        {
            if ( isdefined( level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ] ) )
            {
                level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].paused = 1;
            }
            
            return;
        }
        
        if ( command == "<dev string:x13b0>" )
        {
            free_index = level.commonitemdebug.var_4e3ab00349a607ed.size;
            lowest_index = 9999;
            
            foreach ( index in level.commonitemdebug.var_ecab07da0d246465 )
            {
                if ( index < lowest_index )
                {
                    lowest_index = index;
                    free_index = index;
                }
            }
            
            level.commonitemdebug.var_ecab07da0d246465 = arrayremove( level.commonitemdebug.var_ecab07da0d246465, free_index );
            
            if ( !isdefined( level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ] ) )
            {
                level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ] = spawnstruct();
            }
            
            if ( !isdefined( level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].iterations ) )
            {
                level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].iterations = 0;
            }
            
            if ( !isdefined( level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].index ) )
            {
                level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].index = free_index;
            }
            
            if ( !isdefined( level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].bundle ) )
            {
                level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].bundle = getscriptbundle( hashcat( %"itemspawnentry:", item_bundle_name ) );
            }
            
            if ( !isdefined( level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].attachments ) )
            {
                level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].attachments = [];
            }
            
            if ( !isdefined( level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].slots ) )
            {
                level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].slots = [];
            }
            
            level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].paused = 0;
            
            if ( level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].iterations == 0 )
            {
                thread function_4f8028c9e85a8c5c( item_bundle_name );
            }
            
            return;
        }
        
        if ( command == "<dev string:x13b6>" )
        {
            if ( isdefined( level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ] ) )
            {
                total_count = level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].iterations;
                count_str = string( total_count ) + ( total_count > 9 ? total_count > 99 ? total_count > 999 ? "<dev string:x13bd>" : "<dev string:x13bf>" : "<dev string:x13c2>" : "<dev string:x13c6>" );
                print( count_str + item_bundle_name );
                
                foreach ( slot, attachments in level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].attachments )
                {
                    slot_count = level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].slots[ slot ];
                    count_str = string( slot_count ) + ( slot_count > 9 ? slot_count > 99 ? slot_count > 999 ? "<dev string:x13bf>" : "<dev string:x13c2>" : "<dev string:x13c6>" : "<dev string:x13cb>" );
                    percent_str = "<dev string:x13d1>" + 100 * float( slot_count ) / float( total_count ) + "<dev string:x13d4>";
                    print( count_str + slot + percent_str );
                    
                    foreach ( attachment, att_count in level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].attachments[ slot ] )
                    {
                        count_str = string( att_count ) + ( att_count > 9 ? att_count > 99 ? att_count > 999 ? "<dev string:x13c2>" : "<dev string:x13c6>" : "<dev string:x13cb>" : "<dev string:x13d7>" );
                        percent_str = "<dev string:x13d1>" + 100 * float( att_count ) / float( slot_count ) + "<dev string:x13d4>";
                        print( count_str + attachment + percent_str );
                    }
                }
            }
        }
    }

    // Namespace item_weapon
    // Params 1, eflags: 0x4
    // Checksum 0xfde119f3, Offset: 0xa1ca
    // Size: 0x6b0, Type: dev
    function private function_4f8028c9e85a8c5c( item_bundle_name )
    {
        while ( true )
        {
            if ( !isdefined( level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ] ) )
            {
                return;
            }
            
            if ( !level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].paused )
            {
                level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].iterations += 1;
                rolledattachments = function_f35592669ca50145( level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].bundle );
                
                foreach ( attachment in rolledattachments )
                {
                    slot = getattachmentslot( level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].bundle.baseweapon, attachment );
                    
                    if ( !isdefined( level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].attachments[ slot ] ) )
                    {
                        level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].attachments[ slot ] = [];
                    }
                    
                    if ( isdefined( level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].slots[ slot ] ) )
                    {
                        level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].slots[ slot ] += 1;
                    }
                    else
                    {
                        level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].slots[ slot ] = 1;
                    }
                    
                    if ( isdefined( level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].attachments[ slot ][ attachment ] ) )
                    {
                        level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].attachments[ slot ][ attachment ] += 1;
                        continue;
                    }
                    
                    level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].attachments[ slot ][ attachment ] = 1;
                }
            }
            
            if ( getdvarint( @"hash_8b93e6e651c920bb", 1 ) )
            {
                scale = getdvarfloat( @"hash_aac79e2ab4af9ee7", 1 );
                space = int( 8 * scale );
                line_height = int( 12 * scale );
                x = getdvarint( @"hash_e981f2369f02b682", 350 );
                x += 350 * scale * level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].index;
                y = getdvarint( @"hash_21adc9eb44b3d7ed", 20 );
                frames = int( 1000 * getdvarfloat( @"hash_33348a07cb3e791b", 0.1 ) / getframeduration() ) + 1;
                total_count = level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].iterations;
                printtoscreen2d( x, y, string( total_count ), ( 1, 1, 1 ), scale, frames );
                printtoscreen2d( x + 4 * space, y, "<dev string:x13bd>", ( 1, 1, 1 ), scale, frames );
                printtoscreen2d( x + 5 * space, y, item_bundle_name, ( 1, 1, 1 ), scale, frames );
                y += line_height;
                
                foreach ( slot, attachments in level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].attachments )
                {
                    slot_count = level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].slots[ slot ];
                    percent = "<dev string:x13d1>" + 100 * float( slot_count ) / float( total_count ) + "<dev string:x13d4>";
                    printtoscreen2d( x, y, string( slot_count ), ( 1, 1, 1 ), scale, frames );
                    printtoscreen2d( x + 5 * space, y, "<dev string:x13bd>", ( 1, 1, 1 ), scale, frames );
                    printtoscreen2d( x + 6 * space, y, slot + percent, ( 1, 1, 1 ), scale, frames );
                    y += line_height;
                    
                    foreach ( attachment, att_count in level.commonitemdebug.var_4e3ab00349a607ed[ item_bundle_name ].attachments[ slot ] )
                    {
                        percent = "<dev string:x13d1>" + 100 * float( att_count ) / float( slot_count ) + "<dev string:x13d4>";
                        printtoscreen2d( x, y, string( att_count ), ( 1, 1, 1 ), scale, frames );
                        printtoscreen2d( x + 6 * space, y, "<dev string:x13bd>", ( 1, 1, 1 ), scale, frames );
                        printtoscreen2d( x + 7 * space, y, attachment + percent, ( 1, 1, 1 ), scale, frames );
                        y += line_height;
                    }
                }
            }
            
            wait getdvarfloat( @"hash_33348a07cb3e791b", 0.1 );
        }
    }

#/
