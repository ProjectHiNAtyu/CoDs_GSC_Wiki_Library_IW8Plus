// script_30a19d5ee7e2506d  (hash_30a19d5ee7e2506d.gscc) (size: 5509 Bytes / 0x1585 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4c9e2a00 (1285433856)
// size ...... 5509 (0x1585)
// includes .. 13  (offset: 0x1431)
// strings ... 17  (offset: 0x1499)
// dev strs .. 0   (offset: 0x1585)
// exports ... 14  (offset: 0xbf1)
// cseg ...... 0x180 + 0xa71 (0xbf1)
// imports ... 53  (offset: 0xe21)
// animtree1 . 0   (offset: 0x1585)
// animtree2 . 0   (offset: 0x1585)
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\common\equipment\molotov;
#using scripts\mp\equipment;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;

#namespace namespace_80cbeb966e2dcff0;

// Namespace namespace_80cbeb966e2dcff0
// Params 0, eflags: 0x5
// Checksum 0xd8f8666f, Offset: 0x19e
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_a2daff53f9e00da5", #"common_item_database", undefined, &init_item_gascan );
}

// Namespace namespace_80cbeb966e2dcff0
// Params 0
// Checksum 0xd9996898, Offset: 0x1c7
// Size: 0x12e
function init_item_gascan()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    gascanlootid = common_item::items_getlootidfromref( "brloot_gascan" );
    var_310b754ac600935e = common_item::items_getlootidfromref( "brloot_valuable_blow_torch" );
    
    if ( !isdefined( gascanlootid ) )
    {
        return;
    }
    
    bundlename = common_item_database::function_a4f0a21951180013( "brloot_gascan" );
    
    if ( !isdefined( bundlename ) )
    {
        return;
    }
    
    bundle = common_item::function_90c3e0c1fd55d6b6( bundlename );
    
    if ( !isdefined( bundle.scriptable ) )
    {
        return;
    }
    
    level.gascanlootid = gascanlootid;
    level.var_310b754ac600935e = var_310b754ac600935e;
    level.gascanscriptable = bundle.scriptable;
    common_item::function_4b30c091d3b04a25( "gascan" );
    common_item::function_84174b793b5fe9a7( "gascan", #"use", &function_ba68a2ec21d4514a );
    common_item::function_84174b793b5fe9a7( "gascan", #"getcurrent", &get_current_gas_can );
    common_item::function_84174b793b5fe9a7( "gascan", #"hash_2d3b76ff260f2d68", &function_f4021140c34663c4 );
    level thread function_8ed7c1e358574ae7();
    callback::add( #"hash_89555462d4b2ee9f", &function_12d69b30c882c98e );
    scriptable::scriptable_adddamagedcallback( &damaged );
}

// Namespace namespace_80cbeb966e2dcff0
// Params 4, eflags: 0x4
// Checksum 0x2c9a6ec5, Offset: 0x2fd
// Size: 0x32
function private function_ba68a2ec21d4514a( itembundle, item, autouse, var_981c264073bf1154 )
{
    return item.count;
}

// Namespace namespace_80cbeb966e2dcff0
// Params 1, eflags: 0x4
// Checksum 0xda5fedcd, Offset: 0x338
// Size: 0x146
function private function_12d69b30c882c98e( params )
{
    if ( params.lootid == 0 )
    {
        if ( isdefined( self.gascan_indexes ) )
        {
            self.gascan_indexes[ params.index ] = undefined;
            
            if ( isarray( self.gascan_indexes ) && self.gascan_indexes.size == 0 )
            {
                self.gascan_indexes = undefined;
            }
        }
        
        if ( isdefined( self.var_7d311b5f0bd70241 ) )
        {
            self.var_7d311b5f0bd70241[ params.index ] = undefined;
            
            if ( isarray( self.var_7d311b5f0bd70241 ) && self.var_7d311b5f0bd70241.size == 0 )
            {
                self.var_7d311b5f0bd70241 = undefined;
            }
        }
        
        return;
    }
    
    if ( params.lootid === level.gascanlootid )
    {
        if ( !isdefined( self.gascan_indexes ) )
        {
            self.gascan_indexes = [];
        }
        
        self.gascan_indexes[ params.index ] = 1;
        return;
    }
    
    if ( params.lootid === level.var_310b754ac600935e )
    {
        if ( !isdefined( self.var_7d311b5f0bd70241 ) )
        {
            self.var_7d311b5f0bd70241 = [];
        }
        
        self.var_7d311b5f0bd70241[ params.index ] = 1;
    }
}

// Namespace namespace_80cbeb966e2dcff0
// Params 0, eflags: 0x4
// Checksum 0xd061cd01, Offset: 0x486
// Size: 0xe2
function private function_8ed7c1e358574ae7()
{
    while ( !isdefined( level.struct_class_names ) )
    {
        waitframe();
    }
    
    utility::flag_wait( "scriptables_ready" );
    
    foreach ( gascan in utility::getstructarray( "gas_can_refuel", "targetname" ) )
    {
        spawned = spawnscriptable( "gas_can_refuel", gascan.origin, gascan.angles );
        spawned setscriptablepartstate( "gas_can_refuel", "hidden_usable" );
    }
    
    scriptable::scriptable_addusedcallbackbypart( "gas_can_refuel", &function_aee72d68ffa8e462 );
}

// Namespace namespace_80cbeb966e2dcff0
// Params 5
// Checksum 0x80648d0f, Offset: 0x570
// Size: 0x72
function function_f4021140c34663c4( index, bundle, lootid, quantity, groupid )
{
    item = common_item::function_77600f92048df72d( bundle, quantity );
    error = vehicle_interact::gas_can_refuel_vehicle( item, 0 );
    
    if ( isdefined( error ) )
    {
        hud_message::showerrormessage( error );
    }
    
    return item.count;
}

// Namespace namespace_80cbeb966e2dcff0
// Params 1
// Checksum 0xb83c4fdb, Offset: 0x5eb
// Size: 0x6d
function get_current_gas_can( params )
{
    if ( isdefined( params.index ) )
    {
        name = common_item_database::function_db2360bc1c33f6f9( common_inventory::inventory_getlootidatbackpackindex( params.index ) );
        
        if ( isdefined( name ) )
        {
            return { #count:common_inventory::inventory_getquantityatbackpackindex( params.index ), #name:name };
        }
        
        return {};
    }
}

// Namespace namespace_80cbeb966e2dcff0
// Params 5
// Checksum 0x952972aa, Offset: 0x660
// Size: 0xb1, Type: bool
function gas_can_siphon( index, bundle, lootid, quantity, groupid )
{
    if ( lootid != level.gascanlootid )
    {
        return false;
    }
    
    [ error, newcount ] = vehicle_interact::gas_can_siphon_vehicle( quantity );
    
    if ( isdefined( error ) )
    {
        hud_message::showerrormessage( error );
    }
    else
    {
        common_inventory::inventory_setbackpackitematindex( index, lootid, newcount );
        playsoundatpos( self.origin + ( 0, 0, 30 ), "eqp_gas_can_siphon" );
    }
    
    return true;
}

// Namespace namespace_80cbeb966e2dcff0
// Params 6, eflags: 0x4
// Checksum 0x4ef15910, Offset: 0x71a
// Size: 0x154
function private function_aee72d68ffa8e462( instance, part, state, player, bautouse, usestring )
{
    [ backpackindex, backpackquantity ] = player common_inventory::function_1f277d13c98bf3c1( level.gascanlootid );
    
    if ( !player common_inventory::function_3cd473ff8c027855( level.gascanlootid, 1000 ) )
    {
        player hud_message::showerrormessage( %"hash_39144378171690c1" );
        instance disablescriptableplayeruse( player );
        wait 1;
        
        if ( isdefined( instance ) && isdefined( player ) )
        {
            instance enablescriptableplayeruse( player );
        }
        
        return;
    }
    
    instance setscriptablepartstate( part, "refueling" );
    new_can = spawnscriptable( level.gascanscriptable, instance.origin, instance.angles );
    new_can.count = backpackquantity;
    
    while ( isdefined( new_can ) )
    {
        if ( new_can.count < 150 )
        {
            new_can.count += 1;
            wait 0.05;
            continue;
        }
        
        wait 1;
    }
    
    wait 1;
    instance setscriptablepartstate( part, "hidden_usable" );
}

// Namespace namespace_80cbeb966e2dcff0
// Params 11, eflags: 0x4
// Checksum 0x84a7c956, Offset: 0x876
// Size: 0x88
function private damaged( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type == level.gascanscriptable )
    {
        explode( instance, eattacker );
    }
}

// Namespace namespace_80cbeb966e2dcff0
// Params 2, eflags: 0x4
// Checksum 0xfbc9960e, Offset: 0x906
// Size: 0x186
function private explode( instance, eattacker )
{
    instance notify( #"explode" );
    waittillframeend();
    
    if ( !isdefined( level.var_1b7719e8fe46996d ) )
    {
        level.var_1b7719e8fe46996d = spawn( "script_origin", ( 0, 0, 0 ) );
    }
    
    damagesource = eattacker ?? level.var_1b7719e8fe46996d;
    radiusdamage( instance.origin, 250, 100, 50, damagesource, "MOD_EXPLOSIVE", "gas_can_mp" );
    fire = undefined;
    
    if ( instance.count > 15 )
    {
        if ( isplayer( eattacker ) )
        {
            molotovweapon = equipment_mp::getweaponfromequipmentref( "equip_molotov" );
            grenade = magicgrenademanual( molotovweapon.basename ?? "molotov_mp", instance.origin + ( 0, 0, 10 ), ( 0, 0, -1 ), 5 );
            grenade.owner = eattacker;
            eattacker molotov::molotov_used( grenade, ( 0, 0, -1 ) );
        }
        else
        {
            fire = spawnscriptable( "equip_propane_tank_pool_br", instance.origin, instance.angles );
            fire setscriptablepartstate( "effects", "coreCenter" );
        }
    }
    
    wait 5;
    
    if ( isdefined( fire ) )
    {
        fire freescriptable();
    }
    
    if ( isdefined( instance ) )
    {
        common_item::function_869d7676e359a627( instance );
    }
}

// Namespace namespace_80cbeb966e2dcff0
// Params 5
// Checksum 0x8f55c1ba, Offset: 0xa94
// Size: 0xac
function function_7cc4c87531b98831( index, itembundle, lootid, quantity, fromgroup )
{
    vehicle = vehicle::get_vehicle();
    
    if ( !isdefined( vehicle ) || !vehicle_occupancy::function_3080323254ba6900( self ) )
    {
        hud_message::showerrormessage( %"hash_42f1583b4dd85476" );
        return;
    }
    
    if ( isdefined( vehicle.playerlock ) )
    {
        hud_message::showerrormessage( %"hash_f5d99ebbed72416" );
        return;
    }
    
    utility::callsharedfunc( #"vehicle", #"player_lock", vehicle );
    common_inventory::inventory_setbackpackitematindex( index, 0, 0 );
}

// Namespace namespace_80cbeb966e2dcff0
// Params 5
// Checksum 0x8e9f86c, Offset: 0xb48
// Size: 0xa9
function function_9323d9f60a457f5d( index, itembundle, lootid, quantity, fromgroup )
{
    vehicle = vehicle::get_vehicle();
    
    if ( !isdefined( vehicle ) || !vehicle_occupancy::function_3080323254ba6900( self ) )
    {
        hud_message::showerrormessage( %"hash_5b86f606c329e8f2" );
        return;
    }
    
    if ( !vehicle vehicle_occupancy::is_locked() )
    {
        hud_message::showerrormessage( %"hash_7bffb989ba32bf43" );
        return;
    }
    
    vehicle utility::callsharedfunc( #"vehicle", #"player_unlock" );
    common_inventory::inventory_setbackpackitematindex( index, 0, 0 );
}

