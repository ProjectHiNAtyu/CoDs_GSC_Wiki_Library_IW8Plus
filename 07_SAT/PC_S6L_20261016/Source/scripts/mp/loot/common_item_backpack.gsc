// scripts\mp\loot\common_item_backpack.gsc  (hash_17fba692339e28db.gscc) (size: 7534 Bytes / 0x1d6e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1b233e5f (455294559)
// size ...... 7534 (0x1d6e)
// includes .. 9   (offset: 0x1c02)
// strings ... 11  (offset: 0x1c4a)
// dev strs .. 6   (offset: 0x1d1a)
// exports ... 19  (offset: 0x11fe)
// cseg ...... 0x170 + 0x108e (0x11fe)
// imports ... 57  (offset: 0x14f6)
// animtree1 . 0   (offset: 0x1d6e)
// animtree2 . 0   (offset: 0x1d6e)
#using scripts\common\bots\bots_util;
#using scripts\common\system;
#using scripts\mp\armor;
#using scripts\mp\common\utility\backpack;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_inventory_groups;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_armor;
#using scripts\mp\loot\common_item_database;

#namespace item_backpack;

// Namespace item_backpack
// Params 0, eflags: 0x5
// Checksum 0xcca3f483, Offset: 0x18e
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"item_backpack", #"common_item", &init_item_backpack, undefined );
}

// Namespace item_backpack
// Params 0
// Checksum 0x4397769b, Offset: 0x1b7
// Size: 0x1ae
function init_item_backpack()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    level.var_3fa48f8ded6ca144 = [];
    level.var_3fa48f8ded6ca144[ "wz_consumable_satchel_armor" ] = 0;
    level.var_3fa48f8ded6ca144[ "wz_consumable_satchel_ammo" ] = 1;
    level.var_3fa48f8ded6ca144[ "wz_consumable_satchel_equipment" ] = 2;
    level.var_3fa48f8ded6ca144[ "wz_consumable_satchel_killstreak" ] = 3;
    common_item::function_4b30c091d3b04a25( "backpack" );
    common_item::function_84174b793b5fe9a7( "backpack", #"use", &use_item_backpack );
    common_item::function_84174b793b5fe9a7( "backpack", #"canautouse", &function_120cfe3dbed5f028 );
    common_item::function_84174b793b5fe9a7( "backpack", #"hash_9e49dfaa7c147654", &function_64134770726cfa85 );
    common_item::function_84174b793b5fe9a7( "backpack", #"getcurrent", &get_current_item_backpack );
    common_item::function_84174b793b5fe9a7( "backpack", #"removecurrent", &function_c5e52fc7ce3c9f51 );
    common_item::function_84174b793b5fe9a7( "backpack", #"database_additem", &function_2c7a837d70afd3dc );
    common_item::function_4b30c091d3b04a25( "backpack_upgrade" );
    common_item::function_84174b793b5fe9a7( "backpack_upgrade", #"use", &use_item_backpack_upgrade );
    common_item::function_84174b793b5fe9a7( "backpack_upgrade", #"hash_9e49dfaa7c147654", &function_6cf396a9205c798e );
    common_item::function_84174b793b5fe9a7( "backpack_upgrade", #"removecurrent", &function_44ff74baae657d12 );
    common_item::function_84174b793b5fe9a7( "backpack_upgrade", #"hash_f813bdc63d43bd77", &drop_all_items_backpack_upgrade );
    common_item::function_84174b793b5fe9a7( "backpack_upgrade", #"database_additem", &function_fbd96eca1059d379 );
    level.var_31d0e19b5cba5c30 = getdvarint( @"hash_b9ad64318ad3dd83", 0 ) == 1;
}

// Namespace item_backpack
// Params 4
// Checksum 0xcebdd7b3, Offset: 0x36d
// Size: 0xaf
function use_item_backpack( item_bundle, item, autouse, var_981c264073bf1154 )
{
    assert( isdefined( item_bundle ) && common_item::function_16e8c106491eeaca( item_bundle ) == "<dev string:x24>" );
    common_inventory::function_4e7fa885e76e773e( get_backpack_size( item_bundle ), item_bundle );
    self.backpack_scriptable_name = item.type;
    self.backpack_bundle_ref = item_bundle.ref;
    common_inventory::function_53c2eff14977db64();
    self setclientomnvar( "backpack_lootid", common_item::function_779887309ec71dfe( item_bundle ) );
    function_dafbda061f5fa101();
    return item.count - 1;
}

// Namespace item_backpack
// Params 4
// Checksum 0xde7f8fb8, Offset: 0x425
// Size: 0x47b
function use_item_backpack_upgrade( item_bundle, item, autouse, var_981c264073bf1154 )
{
    assert( isdefined( item_bundle ) && common_item::function_16e8c106491eeaca( item_bundle ) == "<dev string:x2d>" );
    
    if ( !isdefined( self.backpackupgrades ) )
    {
        self.backpackupgrades = spawnstruct();
        self.backpackupgrades.var_9f469e8d2bc259d = [];
        self.backpackupgrades.equippedupgrades = [];
    }
    
    var_59bcc579e74b2634 = bots_util::function_deef484b5b3a3977() && ( isbot( self ) || isautopilot( self ) );
    self.backpackupgrades.equippedupgrades[ item_bundle.ref ] = [];
    
    if ( var_59bcc579e74b2634 )
    {
        self function_ae183ea66a08a430( item_bundle.ref, 1 );
    }
    
    var_9973044aa09b9f8a = 0;
    
    foreach ( var_8ce77704bfbe461c in item_bundle.var_9f512e71af74e61d )
    {
        itemtype = getscriptbundlefieldvalue( var_8ce77704bfbe461c.loottype, #"typeref" );
        
        if ( itemtype == "ammo" )
        {
            foreach ( ammoref, spawncount in level.var_d157a47d96f8c663 )
            {
                if ( !isdefined( self.backpackupgrades.var_9f469e8d2bc259d[ ammoref ] ) )
                {
                    self.backpackupgrades.var_9f469e8d2bc259d[ ammoref ] = 0;
                }
                
                var_bd9803328d40456c = spawncount * var_8ce77704bfbe461c.value;
                self.backpackupgrades.var_9f469e8d2bc259d[ ammoref ] += var_bd9803328d40456c;
                self.backpackupgrades.equippedupgrades[ item_bundle.ref ][ ammoref ] = var_bd9803328d40456c;
                
                if ( var_59bcc579e74b2634 )
                {
                    self function_31ea9e1ebe399933( ammoref, self.backpackupgrades.var_9f469e8d2bc259d[ ammoref ] );
                }
            }
        }
        else
        {
            if ( !isdefined( self.backpackupgrades.var_9f469e8d2bc259d[ itemtype ] ) )
            {
                self.backpackupgrades.var_9f469e8d2bc259d[ itemtype ] = 0;
            }
            
            self.backpackupgrades.var_9f469e8d2bc259d[ itemtype ] += var_8ce77704bfbe461c.value;
            self.backpackupgrades.equippedupgrades[ item_bundle.ref ][ itemtype ] = var_8ce77704bfbe461c.value;
            
            if ( var_59bcc579e74b2634 )
            {
                self function_31ea9e1ebe399933( itemtype, self.backpackupgrades.var_9f469e8d2bc259d[ itemtype ] );
            }
        }
        
        if ( var_8ce77704bfbe461c.var_65859501bbd1e73f && !level.var_31d0e19b5cba5c30 )
        {
            var_9973044aa09b9f8a = armor::function_22290101992e4874();
        }
        
        if ( isdefined( var_8ce77704bfbe461c.initialgrant ) )
        {
            callbackfunc = common_item::function_c6f3ef3dcb4c55c0( itemtype, #"hash_ec0d0fe4f16ad4e" );
            
            if ( isdefined( callbackfunc ) )
            {
                self [[ callbackfunc ]]( var_8ce77704bfbe461c.initialgrant );
                continue;
            }
            
            assertmsg( "<dev string:x3e>" + itemtype + "<dev string:x69>" );
        }
    }
    
    if ( item_bundle.ref == "wz_consumable_satchel_ammo" )
    {
        self setclientomnvar( "ui_loot_backpack_type", 2 );
    }
    
    packedids = get_packed_backpack_upgrade_ids();
    self setclientomnvar( "backpack_upgrade_ids", packedids );
    item_armor::update_max_armor_plate();
    
    if ( var_9973044aa09b9f8a > 0 )
    {
        common_item::function_47324f290423b2d1( level.armorbundlename, self.origin, item.origin, var_9973044aa09b9f8a );
    }
    
    return item.count - 1;
}

// Namespace item_backpack
// Params 4
// Checksum 0x36bde976, Offset: 0x8a9
// Size: 0x48, Type: bool
function function_120cfe3dbed5f028( item_bundle, item, auto_use, allow_swap )
{
    assert( isdefined( item_bundle ) && common_item::function_16e8c106491eeaca( item_bundle ) == "<dev string:x24>" );
    return false;
}

// Namespace item_backpack
// Params 4
// Checksum 0x6f3eb9ee, Offset: 0x8fa
// Size: 0x5c, Type: bool
function function_64134770726cfa85( item_bundle, item, auto_use, allow_swap )
{
    assert( isdefined( item_bundle ) && common_item::function_16e8c106491eeaca( item_bundle ) == "<dev string:x24>" );
    return self.backpack_scriptable_name != item.type;
}

// Namespace item_backpack
// Params 1, eflags: 0x4
// Checksum 0xfc7cb75, Offset: 0x95f
// Size: 0x23, Type: bool
function private has_backpack_upgrade( bundleref )
{
    return isdefined( self.backpackupgrades.equippedupgrades[ bundleref ] );
}

// Namespace item_backpack
// Params 4
// Checksum 0x16597ef6, Offset: 0x98b
// Size: 0x59, Type: bool
function function_6cf396a9205c798e( item_bundle, item, auto_use, allow_swap )
{
    assert( isdefined( item_bundle ) && common_item::function_16e8c106491eeaca( item_bundle ) == "<dev string:x2d>" );
    return !has_backpack_upgrade( item_bundle.ref );
}

// Namespace item_backpack
// Params 1
// Checksum 0x7be69bc7, Offset: 0x9ed
// Size: 0x52
function get_current_item_backpack( params )
{
    if ( isdefined( self.backpack_scriptable_name ) )
    {
        name = common_item_database::function_ca9ca606e66b5911( self.backpack_scriptable_name );
        
        if ( isdefined( name ) )
        {
            return { #count:1, #name:name };
        }
    }
}

// Namespace item_backpack
// Params 0
// Checksum 0x9e480f51, Offset: 0xa48
// Size: 0x5f
function function_dafbda061f5fa101()
{
    currentbackpack = get_current_item_backpack().name ?? level.var_59c79945f4388ec9;
    
    if ( !currentbackpack )
    {
        backpack::detachbag();
        return;
    }
    
    backpackmodel = level.var_71c3e6e95eb02352[ currentbackpack ];
    
    if ( !isdefined( backpackmodel ) )
    {
        return;
    }
    
    backpack::attachbag( backpackmodel );
}

// Namespace item_backpack
// Params 1
// Checksum 0x31a3eff8, Offset: 0xaaf
// Size: 0xe7
function get_current_item_backpack_upgrade( params )
{
    foundref = undefined;
    
    foreach ( upgraderef, index in level.var_3fa48f8ded6ca144 )
    {
        if ( params.index == index )
        {
            foundref = upgraderef;
            break;
        }
    }
    
    if ( !has_backpack_upgrade( foundref ) )
    {
        return;
    }
    
    name = common_item_database::function_a4f0a21951180013( foundref );
    
    if ( isdefined( name ) )
    {
        return { #quantity:1, #itembundlename:name, #ref:foundref };
    }
}

// Namespace item_backpack
// Params 1
// Checksum 0xd91aa38, Offset: 0xb9f
// Size: 0x74
function function_c5e52fc7ce3c9f51( params )
{
    var_8fb8e1fb220cca48 = get_current_item_backpack( params );
    
    if ( params.beingreplaced )
    {
        return var_8fb8e1fb220cca48;
    }
    
    if ( isdefined( var_8fb8e1fb220cca48 ) )
    {
        common_inventory::function_4e7fa885e76e773e( common_inventory::function_538786216800afe9() );
        self.backpack_scriptable_name = undefined;
        self.backpack_bundle_ref = undefined;
        common_inventory::function_53c2eff14977db64();
        self setclientomnvar( "backpack_lootid", 0 );
    }
    
    function_dafbda061f5fa101();
    return var_8fb8e1fb220cca48;
}

// Namespace item_backpack
// Params 1
// Checksum 0xb3350dec, Offset: 0xc1c
// Size: 0x1c3
function function_44ff74baae657d12( params )
{
    var_8fb8e1fb220cca48 = get_current_item_backpack_upgrade( params );
    
    if ( params.beingreplaced )
    {
        return var_8fb8e1fb220cca48;
    }
    
    if ( isdefined( var_8fb8e1fb220cca48 ) )
    {
        var_59bcc579e74b2634 = bots_util::function_deef484b5b3a3977() && ( isbot( self ) || isautopilot( self ) );
        
        foreach ( itemtype, value in self.backpackupgrades.equippedupgrades[ var_8fb8e1fb220cca48.ref ] )
        {
            capacity = self.backpackupgrades.var_9f469e8d2bc259d[ itemtype ];
            newcapacity = int( max( capacity - value, 0 ) );
            self.backpackupgrades.var_9f469e8d2bc259d[ itemtype ] = newcapacity == 0 ? undefined : newcapacity;
            
            if ( var_59bcc579e74b2634 )
            {
                self function_31ea9e1ebe399933( itemtype, newcapacity );
            }
        }
        
        self.backpackupgrades.equippedupgrades[ var_8fb8e1fb220cca48.ref ] = undefined;
        
        if ( var_59bcc579e74b2634 )
        {
            self function_ae183ea66a08a430( var_8fb8e1fb220cca48.ref, 0 );
        }
        
        if ( var_8fb8e1fb220cca48.ref == "wz_consumable_satchel_ammo" )
        {
            self setclientomnvar( "ui_loot_backpack_type", 1 );
        }
        
        packedids = get_packed_backpack_upgrade_ids();
        self setclientomnvar( "backpack_upgrade_ids", packedids );
    }
    
    item_armor::update_max_armor_plate();
    return var_8fb8e1fb220cca48;
}

// Namespace item_backpack
// Params 1
// Checksum 0x55af71a9, Offset: 0xde8
// Size: 0x65
function drop_all_items_backpack_upgrade( backpackindex )
{
    self.backpackupgrades = undefined;
    var_59bcc579e74b2634 = bots_util::function_deef484b5b3a3977() && ( isbot( self ) || isautopilot( self ) );
    
    if ( var_59bcc579e74b2634 )
    {
        self function_82583df0e48e5537();
    }
    
    item_armor::update_max_armor_plate();
    self setclientomnvar( "ui_loot_backpack_type", 1 );
    self setclientomnvar( "backpack_upgrade_ids", 0 );
}

// Namespace item_backpack
// Params 1
// Checksum 0x943b1ba9, Offset: 0xe55
// Size: 0xa7
function get_backpack_size( item_bundle )
{
    if ( isdefined( self.perks[ "specialty_trait_backpack_extra_slots" ] ) && isdefined( item_bundle.var_8e68df9684111673 ) )
    {
        groupbundle = common_inventory_groups::function_dffd0ba870098fc5( item_bundle.var_8e68df9684111673 );
        return ( common_inventory_groups::function_19a5a29f5cd0df45( groupbundle ) ?? item_bundle.backpacksize );
    }
    
    if ( isdefined( item_bundle.backpackgroup ) )
    {
        groupbundle = common_inventory_groups::function_dffd0ba870098fc5( item_bundle.backpackgroup );
        return ( common_inventory_groups::function_19a5a29f5cd0df45( groupbundle ) ?? item_bundle.backpacksize );
    }
    
    return item_bundle.backpacksize;
}

// Namespace item_backpack
// Params 0
// Checksum 0x2ef7c02, Offset: 0xf05
// Size: 0xaf
function get_packed_backpack_upgrade_ids()
{
    var_36a0f1c9a3bec34a = 0;
    
    foreach ( upgraderef, upgrade in self.backpackupgrades.equippedupgrades )
    {
        bit = level.var_3fa48f8ded6ca144[ upgraderef ];
        
        if ( isdefined( bit ) )
        {
            var_36a0f1c9a3bec34a |= 1 << bit;
        }
    }
    
    return var_36a0f1c9a3bec34a;
}

// Namespace item_backpack
// Params 1
// Checksum 0x732f8f9a, Offset: 0xfbd
// Size: 0x78
function function_2c7a837d70afd3dc( itembundlename )
{
    bundle = getscriptbundlefieldvalues( itembundlename, [ #"hash_146dd41e6d0c890c", #"isbasebackpack" ] );
    
    if ( bundle.var_ab2df660ca22b8c5 )
    {
        level.var_71c3e6e95eb02352[ itembundlename ] = bundle.var_ab2df660ca22b8c5;
    }
    
    if ( bundle.isbasebackpack )
    {
        level.var_59c79945f4388ec9 = itembundlename;
    }
}

// Namespace item_backpack
// Params 1
// Checksum 0xa7704ddb, Offset: 0x103d
// Size: 0x1c1
function function_fbd96eca1059d379( itembundlename )
{
    var_9f512e71af74e61d = getscriptbundlefieldvalue( itembundlename, #"hash_3c9cb639d5cffeea" );
    
    if ( !isdefined( var_9f512e71af74e61d ) )
    {
        /#
            bundlenamestring = getxhashsourcename( itembundlename );
            
            if ( !isdefined( bundlenamestring ) )
            {
                itembundle = common_item::function_90c3e0c1fd55d6b6( itembundlename );
                bundlenamestring = itembundle.ref;
            }
            
            assertmsg( "<dev string:x8f>" + bundlenamestring + "<dev string:xba>" );
        #/
        
        return;
    }
    
    foreach ( var_8ce77704bfbe461c in var_9f512e71af74e61d )
    {
        itemtype = getscriptbundlefieldvalue( var_8ce77704bfbe461c.loottype, #"typeref" );
        
        if ( itemtype == "ammo" )
        {
            foreach ( ammoref, spawncount in level.var_d157a47d96f8c663 )
            {
                var_bd9803328d40456c = spawncount * var_8ce77704bfbe461c.value;
                level.backpackupgrades[ ammoref ] = var_bd9803328d40456c;
            }
            
            continue;
        }
        
        level.backpackupgrades[ itemtype ] = var_8ce77704bfbe461c.value;
    }
}

