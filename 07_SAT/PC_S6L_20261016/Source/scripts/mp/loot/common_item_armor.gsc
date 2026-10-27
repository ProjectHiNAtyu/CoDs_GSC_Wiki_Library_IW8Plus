// scripts\mp\loot\common_item_armor.gsc  (hash_3b47f32d2aedd4e2.gscc) (size: 7509 Bytes / 0x1d55 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5fd605bc (1607861692)
// size ...... 7509 (0x1d55)
// includes .. 7   (offset: 0x1c89)
// strings ... 7   (offset: 0x1cc1)
// dev strs .. 0   (offset: 0x1d55)
// exports ... 23  (offset: 0x1089)
// cseg ...... 0xf5 + 0xf94 (0x1089)
// imports ... 71  (offset: 0x1421)
// animtree1 . 0   (offset: 0x1d55)
// animtree2 . 0   (offset: 0x1d55)
#using scripts\common\bots\bots_util;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\armor;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;

#namespace item_armor;

// Namespace item_armor
// Params 0, eflags: 0x5
// Checksum 0xd1e743e5, Offset: 0x113
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"item_armor", #"common_item", &init_item_armor, undefined );
}

// Namespace item_armor
// Params 0
// Checksum 0x84df56a6, Offset: 0x13c
// Size: 0x1eb
function init_item_armor()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    if ( isdefined( level.var_22064d9de4434e37 ) )
    {
        [[ level.var_22064d9de4434e37 ]]();
    }
    else
    {
        common_item::function_4b30c091d3b04a25( "armor" );
        common_item::function_84174b793b5fe9a7( "armor", #"use", &use_armor_plate );
        common_item::function_84174b793b5fe9a7( "armor", #"canautouse", &function_8620d9d8ce3aaf36 );
        common_item::function_84174b793b5fe9a7( "armor", #"hash_9e49dfaa7c147654", &can_use_armor_plate );
        common_item::function_84174b793b5fe9a7( "armor", #"getcurrent", &get_current_armor_plate );
        common_item::function_84174b793b5fe9a7( "armor", #"removecurrent", &remove_current_armor_plate );
        common_item::function_84174b793b5fe9a7( "armor", #"hash_2d3b76ff260f2d68", &function_332bec1984512059 );
        common_item::function_4b30c091d3b04a25( "plate_carrier" );
        common_item::function_84174b793b5fe9a7( "plate_carrier", #"use", &use_plate_carrier );
        common_item::function_84174b793b5fe9a7( "plate_carrier", #"canautouse", &function_b678258172d3c849 );
        common_item::function_84174b793b5fe9a7( "plate_carrier", #"hash_9e49dfaa7c147654", &can_use_plate_carrier );
        common_item::function_84174b793b5fe9a7( "plate_carrier", #"getcurrent", &get_current_plate_carrier );
        common_item::function_84174b793b5fe9a7( "plate_carrier", #"removecurrent", &remove_current_plate_carrier );
    }
    
    level.var_f65356c6fd0d4607 = 1;
    utility::registersharedfunc( #"game", #"hash_fb0cbf750a27a0bc", &function_e448b5ab56311cb4 );
    common_item::function_84174b793b5fe9a7( "plate_carrier", #"database_additem", &function_9c7a8dd8de585051 );
    common_item::function_84174b793b5fe9a7( "armor", #"database_additem", &function_b9848f236c842ec1 );
    common_item::function_84174b793b5fe9a7( "armor", #"hash_ec0d0fe4f16ad4e", &function_7cc1f52a6322ab84 );
    callback::add( #"player_connect", &on_player_connect );
}

// Namespace item_armor
// Params 1
// Checksum 0x54e6512a, Offset: 0x32f
// Size: 0x1d
function on_player_connect( params )
{
    callback::add( "instance_inventory_item_equipped", &on_instance_inventory_item_equipped );
}

// Namespace item_armor
// Params 1
// Checksum 0xd1e3a520, Offset: 0x354
// Size: 0x45
function on_instance_inventory_item_equipped( params )
{
    if ( params.type && common_item::function_9621774ab5ce6f82( params.type ) == "plate_carrier" )
    {
        armor::setarmorhealth( self.maxarmorhealth );
    }
}

// Namespace item_armor
// Params 1
// Checksum 0xaa00706c, Offset: 0x3a1
// Size: 0x6b
function function_7cc1f52a6322ab84( initialgrant )
{
    self setclientomnvar( "ui_br_has_plate_pouch", 1 );
    
    if ( utility::issharedfuncdefined( #"br", #"hash_ccc082092db526b8" ) )
    {
        self [[ utility::getsharedfunc( #"br", #"hash_ccc082092db526b8" ) ]]( "hasArmorSatchel", 1 );
    }
    
    use_armor_plate( undefined, { #count:initialgrant } );
}

// Namespace item_armor
// Params 4
// Checksum 0x6dee4907, Offset: 0x414
// Size: 0xc7
function use_armor_plate( itembundle, item, autouse, var_981c264073bf1154 )
{
    platecount = armor::function_22290101992e4874();
    platemax = armor::function_db9ebf086f67fe92();
    var_665d743b06806225 = platemax - platecount;
    var_365794f149abb0de = min( var_665d743b06806225, item.count );
    plateleft = item.count - var_365794f149abb0de;
    armor::function_164c824617d7e8d7( var_365794f149abb0de );
    armor::function_df9c3f3288ff004f( var_365794f149abb0de );
    
    if ( self function_ced0cb60f8a65db4() )
    {
        if ( self.armorqueued > 0 )
        {
            armor::function_b072d0355af6e535( self.armorqueued + 1 );
        }
    }
    
    return plateleft;
}

// Namespace item_armor
// Params 4
// Checksum 0x8b627417, Offset: 0x4e4
// Size: 0x33
function function_8620d9d8ce3aaf36( itembundle, item, autouse, allowswap )
{
    return can_use_armor_plate( itembundle, item, autouse, allowswap );
}

// Namespace item_armor
// Params 4
// Checksum 0x1e84d69a, Offset: 0x520
// Size: 0x4d, Type: bool
function can_use_armor_plate( itembundle, item, autouse, allowswap )
{
    platecount = armor::function_22290101992e4874();
    platemax = armor::function_db9ebf086f67fe92();
    return platecount < platemax;
}

// Namespace item_armor
// Params 1
// Checksum 0xd7876d98, Offset: 0x576
// Size: 0x55
function get_current_armor_plate( params )
{
    name = level.armorbundlename ?? common_item_database::function_ca9ca606e66b5911( %"brloot_armor_plate" );
    
    if ( isdefined( name ) )
    {
        return { #count:armor::function_22290101992e4874(), #name:name };
    }
}

// Namespace item_armor
// Params 1
// Checksum 0xedaeac92, Offset: 0x5d4
// Size: 0x109
function remove_current_armor_plate( params )
{
    var_8fb8e1fb220cca48 = get_current_armor_plate( params );
    
    if ( isdefined( var_8fb8e1fb220cca48 ) )
    {
        removedcount = var_8fb8e1fb220cca48.count;
        
        if ( params.count > 0 && params.count < var_8fb8e1fb220cca48.count )
        {
            removedcount = params.count;
        }
        
        if ( params.spawnoptions.isdeathevent && level.droparmorondeath )
        {
            var_6c179f1943aca93d = 0;
            
            if ( level.var_1bd712f9520609c8 > 0 )
            {
                var_6c179f1943aca93d = level.var_1bd712f9520609c8;
            }
            else
            {
                var_6c179f1943aca93d = level.armordropamount;
            }
            
            removedcount = maxint( var_6c179f1943aca93d, removedcount );
        }
        
        if ( removedcount > 0 )
        {
            armor::function_164c824617d7e8d7( -1 * removedcount, 1 );
            return { #count:removedcount, #name:var_8fb8e1fb220cca48.name };
        }
    }
}

// Namespace item_armor
// Params 4
// Checksum 0xa610449a, Offset: 0x6e5
// Size: 0x2ee
function use_plate_carrier( itembundle, item, autouse, var_981c264073bf1154 )
{
    if ( !isdefined( item ) )
    {
        return 0;
    }
    
    if ( !isdefined( itembundle.platecarrierlevel ) )
    {
        return item.count;
    }
    
    carrierlevel = itembundle.platecarrierlevel;
    self.platecarriertype = itembundle.ref;
    self.platecarrierlevel = carrierlevel;
    self.maxarmorhealth = armor::function_3988e68b87d5acc0() * level.var_1bfbe247e8d32b1b;
    var_8b090b9c6b6c8ae = armor::function_cb22658f54166b6b();
    var_1d3960bff54ad3a9 = 0;
    
    if ( self.var_a877e400842dab9b )
    {
        foreach ( perk in self.var_a877e400842dab9b )
        {
            if ( isdefined( self.perks[ perk ] ) )
            {
                if ( perk == "specialty_plate_carrier_gel" )
                {
                    var_1d3960bff54ad3a9 = 1;
                }
                
                utility::callsharedfunc( #"perk", #"removeperk", perk );
            }
        }
    }
    
    if ( !var_1d3960bff54ad3a9 )
    {
        function_a42cc776fafc9239( carrierlevel );
    }
    
    self.var_a877e400842dab9b = [];
    
    if ( itembundle.var_a877e400842dab9b.size > 0 )
    {
        foreach ( perkstruct in itembundle.var_a877e400842dab9b )
        {
            if ( perkstruct.perk )
            {
                utility::callsharedfunc( #"perk", #"giveperk", perkstruct.perk );
                self.var_a877e400842dab9b[ self.var_a877e400842dab9b.size ] = perkstruct.perk;
            }
        }
    }
    
    newarmorhealth = self.armorhealth;
    
    if ( level.gametypebundle.var_d53201e169d3f0eb )
    {
        var_e324ab2945389a71 = armor::function_cb22658f54166b6b();
        armorhealthmod = var_e324ab2945389a71 / var_8b090b9c6b6c8ae;
        newarmorhealth = int( min( self.maxarmorhealth, newarmorhealth * armorhealthmod ) );
    }
    
    armor::setarmorhealth( int( newarmorhealth ), undefined, 1 );
    carrierleft = item.count - 1;
    callback::callback( #"used_plate_carrier" );
    return carrierleft;
}

// Namespace item_armor
// Params 4
// Checksum 0xae31f900, Offset: 0x9dc
// Size: 0x44
function function_b678258172d3c849( itembundle, item, autouse, allowswap )
{
    if ( !itembundle.autopickupenabled )
    {
        return 0;
    }
    
    return can_use_plate_carrier( itembundle, item, autouse, allowswap );
}

// Namespace item_armor
// Params 4
// Checksum 0x23adb6dc, Offset: 0xa29
// Size: 0x83, Type: bool
function can_use_plate_carrier( itembundle, item, autouse, allowswap )
{
    if ( !isdefined( itembundle.platecarrierlevel ) )
    {
        return false;
    }
    
    return self.platecarrierlevel < itembundle.platecarrierlevel || self.platecarriertype && itembundle.ref && itembundle.ref != self.platecarriertype;
}

// Namespace item_armor
// Params 1
// Checksum 0x9846c25b, Offset: 0xab5
// Size: 0x42
function function_94b1ce9c97119a3a( params )
{
    var_73625056e93f2156 = get_current_plate_carrier( params );
    
    if ( !isdefined( var_73625056e93f2156.name ) )
    {
        return;
    }
    
    return common_item::function_b01955b20c77371d( var_73625056e93f2156.name );
}

// Namespace item_armor
// Params 1
// Checksum 0xd42c6974, Offset: 0xb00
// Size: 0x6e
function get_current_plate_carrier( params )
{
    if ( self.platecarrierlevel > ( level.platecarrierstartlevel ?? 1 ) && isdefined( self.platecarriertype ) )
    {
        name = common_item_database::function_a4f0a21951180013( self.platecarriertype );
        
        if ( isdefined( name ) )
        {
            return { #count:1, #name:name };
        }
    }
}

// Namespace item_armor
// Params 1
// Checksum 0x7153cd4e, Offset: 0xb77
// Size: 0x1ee
function remove_current_plate_carrier( params )
{
    if ( params.beingreplaced )
    {
        return get_current_plate_carrier( params );
    }
    
    var_8fb8e1fb220cca48 = get_current_plate_carrier( params );
    var_1d3960bff54ad3a9 = 0;
    
    if ( isdefined( var_8fb8e1fb220cca48 ) )
    {
        var_8b090b9c6b6c8ae = armor::function_cb22658f54166b6b();
        
        if ( self.var_a877e400842dab9b )
        {
            foreach ( perk in self.var_a877e400842dab9b )
            {
                if ( isdefined( self.perks[ perk ] ) )
                {
                    if ( perk == "specialty_plate_carrier_gel" )
                    {
                        var_1d3960bff54ad3a9 = 1;
                    }
                    
                    utility::callsharedfunc( #"perk", #"removeperk", perk );
                }
            }
        }
        
        newlevel = level.platecarrierstartlevel ?? 1;
        
        if ( !var_1d3960bff54ad3a9 )
        {
            function_a42cc776fafc9239( newlevel );
        }
        
        self.platecarrierlevel = newlevel;
        self.platecarriertype = undefined;
        self.maxarmorhealth = armor::function_3988e68b87d5acc0() * level.var_1bfbe247e8d32b1b;
        newarmorhealth = self.armorhealth;
        
        if ( level.gametypebundle.var_d53201e169d3f0eb )
        {
            var_e324ab2945389a71 = armor::function_cb22658f54166b6b();
            armorhealthmod = var_e324ab2945389a71 / var_8b090b9c6b6c8ae;
            newarmorhealth = int( min( self.maxarmorhealth, newarmorhealth * armorhealthmod ) );
        }
        
        armor::setarmorhealth( newarmorhealth, undefined, 1 );
        callback::callback( #"plate_carrier_removed" );
        return var_8fb8e1fb220cca48;
    }
    
    callback::callback( #"plate_carrier_removed" );
}

// Namespace item_armor
// Params 0
// Checksum 0xe125dc98, Offset: 0xd6e
// Size: 0x9d
function function_e448b5ab56311cb4()
{
    platecount = armor::function_22290101992e4874();
    platemax = armor::function_db9ebf086f67fe92();
    
    if ( platecount >= platemax )
    {
        return;
    }
    
    armorplatelootid = common_item::items_getlootidfromref( level.armorref ?? "equip_armorplate" );
    var_1be44e49abbaef27 = 0;
    
    if ( utility::issharedfuncdefined( #"game", #"hash_1368462c2bde97a7" ) )
    {
        var_1be44e49abbaef27 = utility::callsharedfunc( #"game", #"hash_1368462c2bde97a7", armorplatelootid );
    }
    
    if ( var_1be44e49abbaef27 )
    {
        armor::function_164c824617d7e8d7( 1 );
    }
}

// Namespace item_armor
// Params 1
// Checksum 0x8770cffb, Offset: 0xe13
// Size: 0x4a
function function_b9848f236c842ec1( itembundlename )
{
    level.armorbundlename = itembundlename;
    level.armorref = getscriptbundlefieldvalue( itembundlename, #"ref" );
    utility::callsharedfunc( #"vehicle_pickup", #"databaseadditem", itembundlename );
}

// Namespace item_armor
// Params 1
// Checksum 0xc9068117, Offset: 0xe65
// Size: 0x83
function function_9c7a8dd8de585051( itembundlename )
{
    if ( !isdefined( level.var_24f2fe5e7b8ea9af ) )
    {
        level.var_24f2fe5e7b8ea9af = [];
    }
    
    itembundle = getscriptbundlefieldvalues( itembundlename, [ #"platecarriertype", #"ref" ] );
    
    if ( isdefined( itembundle.ref ) )
    {
        level.var_24f2fe5e7b8ea9af[ itembundle.ref ] = itembundle.platecarriertype ?? 0;
    }
}

// Namespace item_armor
// Params 1
// Checksum 0xebbd97f2, Offset: 0xef0
// Size: 0x112
function function_a42cc776fafc9239( var_eba311a10487d31e )
{
    if ( !level.gametypebundle.var_d160eda1f3532e31 )
    {
        return;
    }
    
    plateamount = armor::function_cb22658f54166b6b();
    var_167cfbb69ae1d367 = self.armorhealth - var_eba311a10487d31e * level.var_1bfbe247e8d32b1b;
    
    if ( self.platecarrierlevel > var_eba311a10487d31e && plateamount <= var_167cfbb69ae1d367 )
    {
        armorbundlename = level.armorbundlename ?? common_item_database::function_ca9ca606e66b5911( %"brloot_armor_plate" );
        
        if ( isdefined( armorbundlename ) )
        {
            var_cfd942ce8ce270e3 = int( floor( var_167cfbb69ae1d367 / plateamount ) );
            armorbundle = common_item::function_90c3e0c1fd55d6b6( armorbundlename );
            
            if ( isdefined( armorbundle ) )
            {
                var_a0106b681ac9a0b2 = common_item::items_initspawnoptions_spawnfromentity( self );
                armoritem = common_item::function_77600f92048df72d( armorbundle, var_cfd942ce8ce270e3 );
                amountused = common_item::function_96119bed8ab4c5d9( armoritem, 1, 1 );
                
                if ( amountused == 0 )
                {
                    common_item::function_61c2c0251e742ffd( armorbundle, var_cfd942ce8ce270e3, var_a0106b681ac9a0b2 );
                }
            }
        }
    }
}

// Namespace item_armor
// Params 0
// Checksum 0xcd5a0e7c, Offset: 0x100a
// Size: 0x33
function update_max_armor_plate()
{
    if ( isdefined( self._blackboard ) && bots_util::function_deef484b5b3a3977() )
    {
        self._blackboard.var_3c9b8cee9fb2782a = armor::function_db9ebf086f67fe92();
    }
}

// Namespace item_armor
// Params 5
// Checksum 0x4dd27a29, Offset: 0x1045
// Size: 0x43
function function_332bec1984512059( index, bundle, lootid, quantity, fromgroup )
{
    armor::tryusearmor( 1 );
    return max( 0, quantity - 1 );
}

