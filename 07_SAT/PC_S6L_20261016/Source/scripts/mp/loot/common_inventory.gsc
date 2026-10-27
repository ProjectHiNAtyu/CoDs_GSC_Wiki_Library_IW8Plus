// scripts\mp\loot\common_inventory.gsc  (hash_191ec2bcea8f4f11.gscc) (size: 62836 Bytes / 0xf574 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbec36d75 (3200478581)
// size ...... 62836 (0xf574)
// includes .. 25  (offset: 0xe8a8)
// strings ... 103 (offset: 0xe970)
// dev strs .. 77  (offset: 0xf190)
// exports ... 149 (offset: 0x9b5c)
// cseg ...... 0xa1e + 0x913e (0x9b5c)
// imports ... 402 (offset: 0xb2a4)
// animtree1 . 0   (offset: 0xf574)
// animtree2 . 0   (offset: 0xf574)
#using scripts\common\bots\bots_util;
#using scripts\common\callbacks;
#using scripts\common\dev;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\br\gametypes\br_instance_inventory;
#using scripts\mp\class;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\lui_game_event_aggregator;
#using scripts\mp\common\utility\teams;
#using scripts\mp\currency;
#using scripts\mp\dmz\gametypes\dmz_dog_tag;
#using scripts\mp\dmz\modified_values;
#using scripts\mp\equipment;
#using scripts\mp\loot;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_instance_inventory;
#using scripts\mp\loot\common_inventory_groups;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\loot\common_item_weapon;

#namespace common_inventory;

// Namespace common_inventory
// Params 0, eflags: 0x5
// Checksum 0xa5675e3e, Offset: 0xa3c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"common_inventory", #"common_item", &inventory_init, undefined );
}

// Namespace common_inventory
// Params 0
// Checksum 0x33eed58d, Offset: 0xa65
// Size: 0x240
function inventory_init()
{
    if ( !inventory_isenabled() )
    {
        return;
    }
    
    if ( !isdefined( level.commonitem ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    function_15344519fedb8bb0();
    lui_game_event_aggregator::registeronluieventcallback( &function_8147f4a281cb1bcb );
    utility::registersharedfunc( #"game", #"hash_1368462c2bde97a7", &function_d1993196b2bcf62d );
    utility::registersharedfunc( #"game", #"hash_d9699ea59fa4a494", &function_476110daf7b2ce9b );
    utility::registersharedfunc( #"game", #"hash_7597e84e811f7e7", &function_1f277d13c98bf3c1 );
    utility::registersharedfunc( #"game", #"hash_e7295f0234758798", &function_f8c32573680af2ca );
    utility::registersharedfunc( #"game", #"hash_3dd32e81d0cea08", &function_e9fdb01d6fe5f4ee );
    utility::registersharedfunc( #"game", #"hash_fac0cb6e13f58e63", &inventory_getquantityatbackpackindex );
    utility::registersharedfunc( #"game", #"getlootidatbackpackindex", &inventory_getlootidatbackpackindex );
    utility::registersharedfunc( #"game", #"hash_2b0b5e917fd9500", &function_c620a110c81af8f6 );
    utility::registersharedfunc( #"game", #"hash_7124c4f4697407d1", &inventory_setbackpackitematindex );
    utility::registersharedfunc( #"game", #"hash_dd34cca7fec796cf", &function_da96a2b63b35a3f8 );
    utility::registersharedfunc( #"game", #"getplayerbackpacksize", &function_9cd65c8312048802 );
    utility::registersharedfunc( #"game", #"hash_b2a8858d935629a7", &function_d57aa72eb94634f9 );
    utility::registersharedfunc( #"player", #"getAvailableDMZBackpackIndex", &function_9cfce16f3087291a );
    utility::registersharedfunc( #"inventory", #"isbackpackinventoryenabled", &function_5c64d2b24a8c3e18 );
    utility::registersharedfunc( #"inventory", #"hash_5b6cd96a11db0f50", &function_4c281d89a14b4a16 );
    callback::add( #"player_spawned", &inventory_onplayerspawned );
    callback::add( #"prematch_done", &function_8365ce8f12ed2bfe );
    
    /#
        callback::add( #"prematch_done", &inventory_debug );
    #/
}

// Namespace common_inventory
// Params 2, eflags: 0x4
// Checksum 0x967f481, Offset: 0xcad
// Size: 0x68e
function private function_8147f4a281cb1bcb( notification, var_b55d5f06d88a35a7 )
{
    if ( level.infilcinematicactive )
    {
        return;
    }
    
    if ( isdefined( notification ) && isdefined( var_b55d5f06d88a35a7 ) && !self.isjuggernaut )
    {
        switch ( notification )
        {
            case #"hash_f9442c17e42ea782":
                itemtype = function_41ef8d4d875ae0a3( var_b55d5f06d88a35a7 );
                
                if ( ( itemtype == 3 || itemtype == 1 ) && ( isdefined( self.triggeringstreak ) || istrue( self.enabledequipdeployvfx ) ) )
                {
                    break;
                }
                
                itemindex = function_6cc5b271aaea14b1( var_b55d5f06d88a35a7 );
                quantity = 1;
                
                if ( itemtype == 5 || itemtype == 10 )
                {
                    lootid = inventory_getlootidatbackpackindex( itemindex );
                    itembundlename = common_item_database::function_db2360bc1c33f6f9( lootid );
                    
                    if ( isdefined( itembundlename ) )
                    {
                        itembundle = getscriptbundle( itembundlename );
                        
                        if ( isdefined( itembundle.spawncount ) && itembundle.spawncount > 0 && !itembundle.var_2b0a27d4be7d298b )
                        {
                            quantity = common_item::function_ea3b3088d82fd357( itembundle );
                        }
                    }
                    else
                    {
                        assertmsg( "<dev string:x85>" + itemindex + "<dev string:xc2>" + ( lootid ?? "<dev string:xd6>" ) + "<dev string:xe0>" );
                    }
                }
                
                spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
                thread uidropitem( itemtype, itemindex, quantity, spawnoptions );
                break;
            case #"hash_24d3e929a240e2d7":
                itemtype = function_41ef8d4d875ae0a3( var_b55d5f06d88a35a7 );
                
                if ( ( itemtype == 3 || itemtype == 1 ) && ( isdefined( self.triggeringstreak ) || istrue( self.enabledequipdeployvfx ) ) )
                {
                    break;
                }
                
                itemindex = function_6cc5b271aaea14b1( var_b55d5f06d88a35a7 );
                
                if ( itemtype == 10 )
                {
                    callbacks = common_item::function_9f00d6361edd38ce( common_item::function_16e8c106491eeaca( common_item::function_b202b16941992cca( inventory_getlootidatbackpackindex( itemindex ) ) ) );
                    
                    if ( isdefined( callbacks.funcs[ #"hash_f813bdc63d43bd77" ] ) && [[ callbacks.funcs[ #"hash_f813bdc63d43bd77" ] ]]( itemindex ) )
                    {
                        break;
                    }
                }
                
                spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
                thread uidropitem( itemtype, itemindex, undefined, spawnoptions );
                break;
            case #"hash_344a8be1e67f4848":
                itemtype = function_41ef8d4d875ae0a3( var_b55d5f06d88a35a7 );
                
                if ( itemtype == 3 && isdefined( self.triggeringstreak ) )
                {
                    break;
                }
                
                itemindex = function_6cc5b271aaea14b1( var_b55d5f06d88a35a7 );
                
                if ( itemtype == 1 && itemindex == 2 )
                {
                    function_4f16b9e05d19938c();
                }
                else
                {
                    inventory_equipbackpackitem( itemindex );
                }
                
                break;
            case #"hash_1e7d2b97f26d79a5":
                itemtype = function_41ef8d4d875ae0a3( var_b55d5f06d88a35a7 );
                
                if ( itemtype == 3 && isdefined( self.triggeringstreak ) )
                {
                    break;
                }
                
                itemindex = function_6cc5b271aaea14b1( var_b55d5f06d88a35a7 );
                itemdata = function_408108e079538628( itemtype, itemindex );
                itemname = itemdata.itemname;
                quantity = itemdata.quantity;
                itembundle = getscriptbundle( itemname );
                
                if ( !isdefined( itembundle ) || quantity <= 0 )
                {
                    assertmsg( "<dev string:xfd>" + itemtype + "<dev string:x13f>" );
                    break;
                }
                
                itemcount = common_item::function_598dd39282efb544( quantity );
                remainder = inventory_additemtobackpack( itembundle, itemcount );
                
                if ( remainder == 0 )
                {
                    break;
                }
                
                remaindercount = common_item::function_598dd39282efb544( remainder );
                common_item::function_360e96e0447f17f9( itembundle, remaindercount );
                break;
            case #"hash_df97645422cac8a6":
                itemtype = function_41ef8d4d875ae0a3( var_b55d5f06d88a35a7 );
                
                if ( itemtype != 1 )
                {
                    break;
                }
                
                itemindex = function_6cc5b271aaea14b1( var_b55d5f06d88a35a7 );
                item_weapon::function_f9f6a26369a4edf4( itemindex );
                break;
            case #"hash_21120d09fe99acc5":
                lootid = var_b55d5f06d88a35a7;
                item = common_item::function_7e9d780108e351ec( lootid );
                
                if ( !isdefined( item ) )
                {
                    assertmsg( "<dev string:x162>" + lootid + "<dev string:x19d>" );
                    break;
                }
                
                if ( lootid == item_weapon::function_e11b7333d211c17e() )
                {
                    lootid = item_weapon::function_b7f484c7dea7dc34( item );
                }
                
                if ( !isdefined( lootid ) )
                {
                    break;
                }
                
                function_b374bcc6d7c43b31( item, lootid );
                break;
            case #"hash_970fe96b5f1fa60b":
                itemtype = function_41ef8d4d875ae0a3( var_b55d5f06d88a35a7 );
                
                if ( itemtype == 3 && isdefined( self.triggeringstreak ) )
                {
                    break;
                }
                
                itemindex = function_6cc5b271aaea14b1( var_b55d5f06d88a35a7 );
                
                if ( isdefined( self.var_50f741a14f09a6 ) )
                {
                    common_cache::closelootablecontainer( self.var_50f741a14f09a6, self );
                }
                
                var_34a7a3f23ff246cd = function_408108e079538628( itemtype, itemindex );
                removeditemname = var_34a7a3f23ff246cd.itemname;
                removedquantity = var_34a7a3f23ff246cd.quantity;
                item = spawnstruct();
                item.count = removedquantity;
                item.var_bfb964dc17a2982c = 2;
                lootid = common_item::function_b01955b20c77371d( removeditemname );
                function_7d1d46e75dfdaece( item, lootid );
                break;
            case #"hash_795377ce62b9e0ca":
                movedata = common_inventory_groups::function_313be7104bf0b01e( var_b55d5f06d88a35a7 );
                fromgroup = movedata[ 7 ];
                
                if ( !common_inventory_groups::function_bdd40ff62071d8a0( fromgroup ) && fromgroup != 20 )
                {
                    break;
                }
                
                fromrow = movedata[ 5 ];
                fromcolumn = movedata[ 6 ];
                fromfuncs = common_inventory_groups::function_987405ff5ee23e99( fromgroup );
                
                if ( !fromfuncs.var_65a6f7922d118cdd || !fromfuncs.getfunc )
                {
                    break;
                }
                
                item = [[ fromfuncs.getfunc ]]( fromrow, fromcolumn, 1 );
                
                if ( !item )
                {
                    break;
                }
                
                bundle = common_item::function_6b8ff3d5f2688336( item );
                itemtype = common_item::function_16e8c106491eeaca( bundle );
                callbacks = common_item::function_9f00d6361edd38ce( itemtype );
                
                if ( !function_46911908632ad440( item, fromgroup ) )
                {
                    break;
                }
                
                [ inventorygroup, inventorygroupname ] = self [[ fromfuncs.var_65a6f7922d118cdd ]]();
                index = common_inventory_groups::function_7539b7a73a2ba0b2( inventorygroup, fromrow, fromcolumn );
                lootid = common_item::function_779887309ec71dfe( bundle );
                thread function_1ecae8c4c288bf7d( callbacks.funcs[ #"hash_2d3b76ff260f2d68" ], item, index, bundle, lootid, item.count, fromgroup );
                break;
            default:
                break;
        }
    }
}

// Namespace common_inventory
// Params 7, eflags: 0x4
// Checksum 0x4800e71, Offset: 0x1343
// Size: 0x120
function private function_1ecae8c4c288bf7d( var_ced8d9b66bb25aad, item, index, bundle, lootid, quantity, fromgroup )
{
    remainder = self [[ var_ced8d9b66bb25aad ]]( index, bundle, lootid, quantity, fromgroup );
    
    if ( isdefined( remainder ) && remainder != quantity )
    {
        if ( fromgroup == 20 )
        {
            container = self.var_50f741a14f09a6;
            assert( lootid == container.contents[ index ].lootid );
            common_cache::function_25bee1f5701a0786( self, index, lootid, remainder );
            common_cache::function_430a2732cbe29d15( self, lootid );
            
            if ( common_cache::iscontainerempty( container ) )
            {
                common_cache::closelootablecontainer( container, self );
                
                if ( !container.var_5a4d5180ea13e4ed && !isstruct( container ) && container getscriptableisreserved() )
                {
                    container notify( #"death" );
                    container freescriptable();
                }
            }
            
            return;
        }
        
        if ( fromgroup == 1 )
        {
            inventory_setbackpackitematindex( index, lootid, remainder, item );
        }
    }
}

// Namespace common_inventory
// Params 1, eflags: 0x4
// Checksum 0xa1cc0056, Offset: 0x146b
// Size: 0x15
function private function_41ef8d4d875ae0a3( var_b55d5f06d88a35a7 )
{
    return ( var_b55d5f06d88a35a7 & 65280 ) >> 8;
}

// Namespace common_inventory
// Params 1
// Checksum 0x6312b0ef, Offset: 0x1489
// Size: 0x11
function function_6cc5b271aaea14b1( var_b55d5f06d88a35a7 )
{
    return var_b55d5f06d88a35a7 & 255;
}

// Namespace common_inventory
// Params 4
// Checksum 0xd7c83396, Offset: 0x14a3
// Size: 0xab
function uidropitem( itemtype, itemindex, quantity, spawnoptions )
{
    var_34a7a3f23ff246cd = function_408108e079538628( itemtype, itemindex, quantity, spawnoptions, 0 );
    removeditemname = var_34a7a3f23ff246cd.itemname;
    removedquantity = var_34a7a3f23ff246cd.quantity;
    
    if ( isdefined( removeditemname ) && removedquantity > 0 )
    {
        var_75e3d865bd2811cd = getscriptbundlefieldvalues( removeditemname, [ #"type" ] );
        common_item::function_db61e190f60b2349( spawnoptions, var_75e3d865bd2811cd );
        common_item::function_61c2c0251e742ffd( removeditemname, removedquantity, spawnoptions );
    }
}

// Namespace common_inventory
// Params 5, eflags: 0x4
// Checksum 0x8f99383, Offset: 0x1556
// Size: 0x598
function private function_408108e079538628( itemtype, itemindex, quantity, var_3b8f1509495546fd, dontdrop = 1 )
{
    spawnoptions = var_3b8f1509495546fd ?? common_item::items_initspawnoptions_spawnfromentity( self );
    removeditemname = undefined;
    removedquantity = 0;
    weaponinfostruct = undefined;
    
    switch ( itemtype )
    {
        case 0:
            if ( function_88e95c4947652564() )
            {
                callbacks = common_item::function_9f00d6361edd38ce( "currency" );
                var_8fb8e1fb220cca48 = self [[ callbacks.funcs[ #"getcurrent" ] ]]();
                
                if ( isdefined( var_8fb8e1fb220cca48 ) )
                {
                    var_4151769dbb2c435a = var_8fb8e1fb220cca48.count;
                    
                    if ( isdefined( quantity ) )
                    {
                        var_4151769dbb2c435a = quantity * getmatchrulesdata( "brData", "plunderDropSomeAmount" );
                    }
                    
                    var_34a7a3f23ff246cd = self [[ callbacks.funcs[ #"removecurrent" ] ]]( { #count:var_4151769dbb2c435a } );
                    removeditemname = var_34a7a3f23ff246cd.name;
                    removedquantity = var_34a7a3f23ff246cd.count;
                }
            }
            
            break;
        case 1:
            weaponinfostruct = common_item::function_bbba261e6fdc7e52( "weapon", { #dontdrop:dontdrop, #spawnoptions:spawnoptions, #slotname:itemindex } );
            
            if ( weaponinfostruct )
            {
                removedquantity = 1;
            }
            
            break;
        case 2:
            slot = equipment_mp::function_b1928e5713e81b5e( itemindex );
            item_type = "lethal";
            
            if ( slot == "secondary" )
            {
                item_type = "tactical";
            }
            
            if ( slot == "health" )
            {
                item_type = "armor";
            }
            
            var_34a7a3f23ff246cd = common_item::function_bbba261e6fdc7e52( item_type, { #spawnoptions:spawnoptions, #count:quantity } );
            
            if ( isdefined( var_34a7a3f23ff246cd ) )
            {
                removeditemname = var_34a7a3f23ff246cd.name ?? var_34a7a3f23ff246cd.itembundlename;
                removedquantity = var_34a7a3f23ff246cd.count ?? var_34a7a3f23ff246cd.quantity;
            }
            
            break;
        case 3:
            var_34a7a3f23ff246cd = common_item::function_bbba261e6fdc7e52( "killstreak", { #count:quantity } );
            removeditemname = var_34a7a3f23ff246cd.name;
            removedquantity = var_34a7a3f23ff246cd.count;
            break;
        case 4:
            var_34a7a3f23ff246cd = common_item::function_bbba261e6fdc7e52( "super", { #count:quantity } );
            removeditemname = var_34a7a3f23ff246cd.itembundlename;
            removedquantity = var_34a7a3f23ff246cd.count;
            break;
        case 6:
            var_34a7a3f23ff246cd = common_item::function_bbba261e6fdc7e52( "gasmask", { #count:quantity } );
            
            if ( isdefined( var_34a7a3f23ff246cd ) )
            {
                removeditemname = var_34a7a3f23ff246cd.name ?? var_34a7a3f23ff246cd.itembundlename;
                removedquantity = var_34a7a3f23ff246cd.count ?? var_34a7a3f23ff246cd.quantity;
            }
            
            break;
        case 7:
            var_34a7a3f23ff246cd = common_item::function_bbba261e6fdc7e52( "revive", { #count:quantity } );
            
            if ( isdefined( var_34a7a3f23ff246cd ) )
            {
                removeditemname = var_34a7a3f23ff246cd.name ?? var_34a7a3f23ff246cd.itembundlename;
                removedquantity = var_34a7a3f23ff246cd.count ?? var_34a7a3f23ff246cd.quantity;
            }
            
            break;
        case 12:
            var_34a7a3f23ff246cd = common_item::function_bbba261e6fdc7e52( "backpack_upgrade", { #count:quantity, #index:itemindex } );
            
            if ( isdefined( var_34a7a3f23ff246cd ) )
            {
                removeditemname = var_34a7a3f23ff246cd.name ?? var_34a7a3f23ff246cd.itembundlename;
                removedquantity = var_34a7a3f23ff246cd.count ?? var_34a7a3f23ff246cd.quantity;
            }
            
            break;
        case 5:
        case 10:
            if ( !isdefined( function_211a16b41e71f692() ) )
            {
                break;
            }
            
            removedlootid = inventory_getlootidatbackpackindex( itemindex );
            currentquantity = inventory_getquantityatbackpackindex( itemindex );
            removeditemname = common_item_database::function_db2360bc1c33f6f9( removedlootid );
            
            if ( !isdefined( removeditemname ) )
            {
                break;
            }
            
            var_b22349265921e003 = getscriptbundlefieldvalue( removeditemname, #"hash_35a6ff448ffc0318" );
            newlootid = 0;
            newquantity = 0;
            removedquantity = currentquantity;
            
            if ( isdefined( quantity ) && quantity > 0 && !var_b22349265921e003 )
            {
                removedquantity = quantity < currentquantity ? quantity : currentquantity;
                newlootid = removedlootid;
                newquantity = currentquantity - removedquantity;
            }
            
            inventory_setbackpackitematindex( itemindex, newlootid, newquantity );
            break;
        case 14:
            var_34a7a3f23ff246cd = common_item::function_bbba261e6fdc7e52( "armor_upgrade", { #count:quantity } );
            
            if ( isdefined( var_34a7a3f23ff246cd ) )
            {
                removeditemname = var_34a7a3f23ff246cd.name ?? var_34a7a3f23ff246cd.itembundlename;
                removedquantity = var_34a7a3f23ff246cd.count ?? var_34a7a3f23ff246cd.quantity;
            }
            
            break;
    }
    
    result = { #weaponinfostruct:weaponinfostruct, #quantity:removedquantity, #itemname:removeditemname };
    
    if ( isdefined( spawnoptions.var_7a166247da860246 ) && removedquantity > 0 && ( weaponinfostruct || removeditemname ) )
    {
        spawnoptions.var_7a166247da860246[ spawnoptions.var_7a166247da860246.size ] = result;
    }
    
    return result;
}

// Namespace common_inventory
// Params 0
// Checksum 0xd47a3fb2, Offset: 0x1af7
// Size: 0xa3
function function_4f16b9e05d19938c()
{
    var_98072c02586d07c0 = self getcurrentweapon();
    item_weapon::function_cfd26324d14e4149();
    
    if ( !weapon::isfistweapon( var_98072c02586d07c0 ) && !issameweapon( var_98072c02586d07c0, level.weaponnone ) )
    {
        function_1923cd40e1b4efc8( var_98072c02586d07c0 );
    }
    
    self takeweapon( var_98072c02586d07c0 );
    params = spawnstruct();
    params.oldlocation = "backpack";
    params.var_9f61a39737873518 = 0;
    params.newlocation = "loadout";
    params.var_67b5c2a186b5eab5 = 0;
    callback::callback( "inventory_item_moved", params );
}

// Namespace common_inventory
// Params 1
// Checksum 0xb6517c2e, Offset: 0x1ba2
// Size: 0x4e
function inventory_equipbackpackitem( itemslotindex )
{
    lootid = inventory_getlootidatbackpackindex( itemslotindex );
    quantity = inventory_getquantityatbackpackindex( itemslotindex );
    
    if ( lootid == 0 || quantity == 0 )
    {
        return;
    }
    
    function_54c2ba7e4353996( lootid, quantity, itemslotindex, undefined );
}

// Namespace common_inventory
// Params 5
// Checksum 0xace7844e, Offset: 0x1bf8
// Size: 0x2b1, Type: bool
function function_54c2ba7e4353996( lootid, quantity, inventoryslotindex, countalt, var_3d167b7f0c3a043b )
{
    newitembundlename = common_item_database::function_db2360bc1c33f6f9( lootid );
    
    if ( function_99a3c189718cdd9e( newitembundlename ) )
    {
        return false;
    }
    
    newitembundle = getscriptbundle( newitembundlename );
    var_17804b009b15e57 = newitembundle.scriptable;
    
    if ( !isdefined( var_17804b009b15e57 ) )
    {
        return false;
    }
    
    itemtype = common_item::function_16e8c106491eeaca( newitembundle );
    newitemcallbacks = common_item::function_9f00d6361edd38ce( itemtype );
    
    if ( !isdefined( newitemcallbacks ) )
    {
        assertmsg( "<dev string:x1b6>" + itemtype + "<dev string:x1f3>" );
        return false;
    }
    
    fakeitem = { #count:quantity };
    
    if ( isdefined( newitemcallbacks.funcs[ #"hash_9e49dfaa7c147654" ] ) && !self [[ newitemcallbacks.funcs[ #"hash_9e49dfaa7c147654" ] ]]( newitembundle, fakeitem, 0, 1 ) )
    {
        common_item::function_eddf962212836a3e( newitembundle, 0 );
        return false;
    }
    
    var_f869e76c0a070d54 = undefined;
    var_7b7b16d698131759 = 0;
    
    if ( isdefined( newitemcallbacks.funcs[ #"getcurrent" ] ) )
    {
        var_f869e76c0a070d54 = self [[ newitemcallbacks.funcs[ #"getcurrent" ] ]]( { #index:inventoryslotindex } );
        var_7b7b16d698131759 = var_f869e76c0a070d54.count;
    }
    
    packedcount = common_item::function_598dd39282efb544( quantity, undefined, countalt );
    newitemremainder = common_item::function_360e96e0447f17f9( newitembundle, packedcount );
    
    if ( isarray( newitemremainder ) )
    {
        newitemremainder = newitemremainder[ 0 ];
    }
    
    if ( newitemremainder >= packedcount )
    {
        common_item::function_eddf962212836a3e( newitembundle, 0 );
        return false;
    }
    
    assert( isdefined( newitemremainder ), "<dev string:x204>" + itemtype + "<dev string:x232>" );
    
    if ( var_f869e76c0a070d54.name === newitembundlename && common_item::function_bfd517bdc8850ea6( itemtype, newitembundle ) )
    {
        var_7b7b16d698131759 = newitemremainder;
        var_f869e76c0a070d54.count = newitemremainder;
    }
    
    if ( isdefined( inventoryslotindex ) )
    {
        var_1e9a485e4239c8db = 0;
        
        if ( isdefined( var_f869e76c0a070d54 ) && var_7b7b16d698131759 > 0 )
        {
            var_1e9a485e4239c8db = common_item::function_b01955b20c77371d( var_f869e76c0a070d54.name );
        }
        
        inventory_setbackpackitematindex( inventoryslotindex, var_1e9a485e4239c8db, var_7b7b16d698131759 );
    }
    
    if ( isdefined( var_f869e76c0a070d54 ) && var_3d167b7f0c3a043b && !isdefined( inventoryslotindex ) && var_f869e76c0a070d54.count > 0 )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
        common_item::function_61c2c0251e742ffd( var_f869e76c0a070d54.name, var_f869e76c0a070d54.count, spawnoptions );
    }
    
    common_item::function_eddf962212836a3e( newitembundle, 1 );
    return true;
}

// Namespace common_inventory
// Params 9
// Checksum 0xdab82b1, Offset: 0x1eb2
// Size: 0x183
function function_1a85f583119d9740( itembundlename, itembundle, item, autouse, lootid = common_item::function_779887309ec71dfe( itembundle ), itemtype, var_6ecc64ede36ab68, var_779f4b1579342dbe, count )
{
    if ( !isdefined( lootid ) )
    {
        assertmsg( "<dev string:x254>" + getxhashsourcename( itembundlename ) + "<dev string:x283>" );
        return item.count;
    }
    
    assert( lootid == common_item::function_779887309ec71dfe( itembundle ), "<dev string:x2aa>" );
    
    if ( !isdefined( count ) )
    {
        count = common_item::function_974a788b833e282b( item, itembundle );
    }
    
    var_4375d83555c8dd6f = common_inventory_groups::inventorygroup_enabled() ? common_inventory_groups::function_c27ac785b5373b73()[ 0 ] : undefined;
    
    if ( var_4375d83555c8dd6f && !var_6ecc64ede36ab68 )
    {
        backpacksize = function_9cd65c8312048802();
        var_6ecc64ede36ab68 = common_inventory_groups::function_9cfb83fd532b7894( itembundle, var_4375d83555c8dd6f, backpacksize, lootid );
    }
    
    if ( !isdefined( var_779f4b1579342dbe ) )
    {
        var_779f4b1579342dbe = inventory_canitemfitinbackpack( itembundle, count, autouse, item, lootid, itemtype, var_6ecc64ede36ab68 );
    }
    
    if ( var_779f4b1579342dbe )
    {
        common_item::function_e70f64f8d4664b9e( self, item, count, 1, itembundle, itembundlename, autouse );
        remainder = inventory_additemtobackpack( itembundle, item.count, item, autouse, var_6ecc64ede36ab68, itemtype );
        
        if ( remainder <= 0 )
        {
            self notify( #"self_pickedupitem", getxhashasset( item.type ) );
        }
        
        return remainder;
    }
    
    return item.count;
}

// Namespace common_inventory
// Params 2
// Checksum 0x5f5ad849, Offset: 0x203e
// Size: 0x73, Type: bool
function function_f5e59a1bd3f1dc1( itembundle, item )
{
    if ( !common_inventory_groups::inventorygroup_enabled() )
    {
        return false;
    }
    
    [ securegroup, _ ] = common_inventory_groups::function_ecbef11f7cab32fa();
    
    if ( !isdefined( securegroup ) )
    {
        return false;
    }
    
    secureslot = common_inventory_groups::function_76928b4f093ca1ad( 5, itembundle, 1, item );
    return isdefined( secureslot );
}

// Namespace common_inventory
// Params 5
// Checksum 0x67ffe42b, Offset: 0x20ba
// Size: 0xf0
function function_87aa67ee2b065517( itembundlename = common_item::function_e044c3e813daec3a( itembundle ), itembundle, item, var_8ec9bd311c662237, var_8e2a9de76678811f )
{
    if ( !isdefined( itembundlename ) )
    {
        return 0;
    }
    
    if ( !function_f5e59a1bd3f1dc1( itembundle, item ) )
    {
        return 0;
    }
    
    itemdata = common_item::function_a48ae6cbf7e8c2d5( item, common_item::function_779887309ec71dfe( itembundle ) );
    result = common_inventory_groups::function_41fe07e971a7e566( item, 31, 31 );
    quantitysecured = result.quantityused ?? 0;
    
    if ( quantitysecured <= 0 )
    {
        return 0;
    }
    
    common_item::function_e70f64f8d4664b9e( self, item, quantitysecured, 1, itembundle, itembundlename );
    remainder = item.count - quantitysecured;
    common_item::function_6b392f3e5fc53c0d( item, itembundle, remainder );
    common_item::function_2e0436a8625e3515( itembundle, quantitysecured, itemdata, 1, var_8ec9bd311c662237, var_8e2a9de76678811f );
    return quantitysecured;
}

// Namespace common_inventory
// Params 4
// Checksum 0xe7e3d724, Offset: 0x21b3
// Size: 0x48
function function_e332683b9ad5368b( lootid, quantity, autouse, item )
{
    itembundle = common_item::function_b202b16941992cca( lootid );
    return inventory_canitemfitinbackpack( itembundle, quantity, autouse, item, lootid );
}

// Namespace common_inventory
// Params 7
// Checksum 0xcc8c1d20, Offset: 0x2204
// Size: 0x35c, Type: bool
function inventory_canitemfitinbackpack( itembundle, quantity, autouse, item, lootid, itemtype, var_6ecc64ede36ab68 )
{
    if ( !isdefined( function_211a16b41e71f692() ) )
    {
        return false;
    }
    
    if ( !isdefined( lootid ) )
    {
        lootid = common_item::function_779887309ec71dfe( itembundle );
    }
    
    if ( !isdefined( itemtype ) )
    {
        itemtype = common_item::function_16e8c106491eeaca( itembundle );
    }
    
    assert( lootid == common_item::function_779887309ec71dfe( itembundle ), "<dev string:x2f5>" );
    assert( !isdefined( itemtype ) || itemtype == common_item::function_16e8c106491eeaca( itembundle ), "<dev string:x34f>" );
    
    if ( isdefined( itemtype ) )
    {
        callbacks = common_item::function_9f00d6361edd38ce( itemtype );
        
        if ( isdefined( callbacks.funcs[ #"caninteract" ] ) )
        {
            caninteract = self [[ callbacks.funcs[ #"caninteract" ] ]]( { #item:item, #togroup:1, #itembundle:itembundle } );
        }
        else
        {
            weaponobj = function_f66959a3d0c23978( item, itemtype, itembundle );
            itembundlename = common_item::function_e044c3e813daec3a( itembundle );
            caninteract = self function_a35b39392c23339f( { #weaponobj:weaponobj, #togroup:1, #itembundlename:itembundlename } );
        }
        
        if ( !caninteract )
        {
            return false;
        }
    }
    
    backpacksize = function_9cd65c8312048802();
    var_4375d83555c8dd6f = common_inventory_groups::inventorygroup_enabled() ? common_inventory_groups::function_c27ac785b5373b73()[ 0 ] : undefined;
    
    if ( var_4375d83555c8dd6f )
    {
        if ( !isdefined( var_6ecc64ede36ab68 ) )
        {
            var_6ecc64ede36ab68 = common_inventory_groups::function_9cfb83fd532b7894( itembundle, var_4375d83555c8dd6f, backpacksize, lootid );
        }
    }
    
    var_67ae78eebd102b5c = 0;
    var_2e12622a27a12880 = 0;
    
    for ( i = 0; i < backpacksize ; i++ )
    {
        if ( var_4375d83555c8dd6f && !isdefined( var_6ecc64ede36ab68[ i ] ) )
        {
            continue;
        }
        
        if ( var_4375d83555c8dd6f )
        {
            buttondefinition = var_6ecc64ede36ab68[ i ];
            
            if ( buttondefinition.var_ace7479a34165c59 && callbacks.funcs[ #"getcurrent" ] )
            {
                currentlyheld = [[ callbacks.funcs[ #"getcurrent" ] ]]();
                
                if ( currentlyheld.name == itembundlename )
                {
                    continue;
                }
            }
        }
        
        currentlootid = inventory_getlootidatbackpackindex( i );
        
        if ( currentlootid == 0 )
        {
            var_2e12622a27a12880++;
            
            if ( !autouse )
            {
                return true;
            }
            
            if ( itembundle.var_b30083978786aac7 && itembundle.var_59803d1ed0f20c22 )
            {
                if ( !itembundle.var_51f149d23464d654 )
                {
                    return true;
                }
            }
        }
        
        sameitem = currentlootid == lootid;
        
        if ( sameitem && common_item::function_bfd517bdc8850ea6( itemtype, itembundle ) && ( !autouse || itembundle.var_b30083978786aac7 ) )
        {
            currentquantity = inventory_getquantityatbackpackindex( i );
            
            if ( currentquantity < common_item::function_38334193bd9b5956( itembundle ) )
            {
                return true;
            }
        }
        
        if ( sameitem )
        {
            var_67ae78eebd102b5c++;
        }
    }
    
    if ( itembundle.var_59803d1ed0f20c22 && itembundle.var_51f149d23464d654 && var_67ae78eebd102b5c < itembundle.var_51f149d23464d654 && var_2e12622a27a12880 > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace common_inventory
// Params 0
// Checksum 0x7311ea93, Offset: 0x2569
// Size: 0x49, Type: bool
function function_c4eb1493b48e7f68()
{
    backpacksize = function_9cd65c8312048802();
    
    for ( i = 0; i < backpacksize ; i++ )
    {
        currentlootid = inventory_getlootidatbackpackindex( i );
        
        if ( currentlootid == 0 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace common_inventory
// Params 1
// Checksum 0x1ab09b5d, Offset: 0x25bb
// Size: 0x17, Type: bool
function function_383caa18a4383073( targetlootid )
{
    return function_d57aa72eb94634f9( targetlootid ) != -1;
}

// Namespace common_inventory
// Params 1
// Checksum 0x86e077a, Offset: 0x25db
// Size: 0x6b
function function_d57aa72eb94634f9( targetlootid )
{
    if ( !isdefined( targetlootid ) )
    {
        assert( "<dev string:x3ab>" );
        return -1;
    }
    
    backpacksize = function_9cd65c8312048802();
    
    for ( i = 0; i < backpacksize ; i++ )
    {
        currentlootid = inventory_getlootidatbackpackindex( i );
        
        if ( currentlootid == targetlootid )
        {
            return i;
        }
    }
    
    return -1;
}

// Namespace common_inventory
// Params 1
// Checksum 0x1b3aba62, Offset: 0x264f
// Size: 0x9c
function function_1f277d13c98bf3c1( targetlootid )
{
    backpacksize = function_9cd65c8312048802();
    leastindex = -1;
    leastquantity = undefined;
    
    for ( i = 0; i < backpacksize ; i++ )
    {
        currentlootid = inventory_getlootidatbackpackindex( i );
        
        if ( currentlootid == targetlootid )
        {
            quantity = inventory_getquantityatbackpackindex( i );
            
            if ( !isdefined( leastquantity ) || quantity < leastquantity )
            {
                leastquantity = quantity;
                leastindex = i;
            }
        }
    }
    
    return [ leastindex, leastquantity ];
}

// Namespace common_inventory
// Params 1
// Checksum 0x19c24ba, Offset: 0x26f4
// Size: 0x9c
function function_f8c32573680af2ca( targetlootid )
{
    backpacksize = function_9cd65c8312048802();
    largestindex = -1;
    largestquantity = undefined;
    
    for ( i = 0; i < backpacksize ; i++ )
    {
        currentlootid = inventory_getlootidatbackpackindex( i );
        
        if ( currentlootid == targetlootid )
        {
            quantity = inventory_getquantityatbackpackindex( i );
            
            if ( !isdefined( largestquantity ) || quantity > largestquantity )
            {
                largestquantity = quantity;
                largestindex = i;
            }
        }
    }
    
    return [ largestindex, largestquantity ];
}

// Namespace common_inventory
// Params 1
// Checksum 0xda7a9790, Offset: 0x2799
// Size: 0x82
function function_4436b2f08e588b8( lootid )
{
    if ( !isdefined( lootid ) || lootid == 0 )
    {
        return [];
    }
    
    indexes = [];
    backpacksize = function_9cd65c8312048802();
    
    for ( i = 0; i < backpacksize ; i++ )
    {
        currentlootid = inventory_getlootidatbackpackindex( i );
        
        if ( lootid == currentlootid )
        {
            indexes[ i ] = inventory_getquantityatbackpackindex( i );
        }
    }
    
    indexes = tablesort( indexes );
    return indexes;
}

// Namespace common_inventory
// Params 0
// Checksum 0x64257649, Offset: 0x2824
// Size: 0x3c
function function_9cfce16f3087291a()
{
    backpacksize = function_9cd65c8312048802();
    
    for ( i = 0; i < backpacksize ; i++ )
    {
        if ( inventory_getlootidatbackpackindex( i ) == 0 )
        {
            return i;
        }
    }
}

// Namespace common_inventory
// Params 2
// Checksum 0xd4b9a8f7, Offset: 0x2869
// Size: 0x33
function function_d3959596f4031a1d( itemlootid, itemcount )
{
    itembundle = common_item::function_b202b16941992cca( itemlootid );
    inventory_additemtobackpack( itembundle, itemcount );
}

// Namespace common_inventory
// Params 6
// Checksum 0x16e53669, Offset: 0x28a4
// Size: 0x48d
function inventory_additemtobackpack( itembundle, itemcount, item, autouse, var_6ecc64ede36ab68, typeref )
{
    if ( !( isdefined( itembundle ) && isdefined( itemcount ) ) )
    {
        assertmsg( "<dev string:x3da>" );
        return 0;
    }
    
    /#
        itemnamestring = itembundle.ref ?? "<dev string:x424>";
    #/
    
    lootid = common_item::function_779887309ec71dfe( itembundle );
    
    if ( !isdefined( lootid ) )
    {
        assertmsg( "<dev string:x254>" + common_item::function_1cb2d422222358b8( itemnamestring ) + "<dev string:x283>" );
        return itemcount;
    }
    
    quantity = itembundle.var_2b0a27d4be7d298b ? itemcount : common_item::function_44eacd480abb5b94( itemcount );
    maxcount = common_item::function_38334193bd9b5956( itembundle );
    var_232857ed7c70890f = common_inventory_groups::inventorygroup_enabled() ? common_inventory_groups::function_c27ac785b5373b73() : undefined;
    var_4375d83555c8dd6f = undefined;
    var_feb46c6f827972ac = undefined;
    
    if ( isdefined( var_232857ed7c70890f ) )
    {
        var_4375d83555c8dd6f = var_232857ed7c70890f[ 0 ];
        var_feb46c6f827972ac = var_232857ed7c70890f[ 1 ];
    }
    
    backpacksize = function_9cd65c8312048802();
    
    if ( var_4375d83555c8dd6f )
    {
        if ( !isdefined( var_6ecc64ede36ab68 ) )
        {
            var_6ecc64ede36ab68 = common_inventory_groups::function_9cfb83fd532b7894( itembundle, var_4375d83555c8dd6f, backpacksize, lootid );
        }
    }
    
    if ( !isdefined( typeref ) )
    {
        typeref = common_item::function_16e8c106491eeaca( itembundle );
    }
    
    isstackable = common_item::function_bfd517bdc8850ea6( typeref, itembundle );
    invalidslots = [];
    var_67ae78eebd102b5c = 0;
    var_2e12622a27a12880 = 0;
    
    if ( isstackable )
    {
        for ( i = 0; i < backpacksize ; i++ )
        {
            if ( isdefined( var_4375d83555c8dd6f ) && !isdefined( var_6ecc64ede36ab68[ i ] ) )
            {
                invalidslots[ i ] = 1;
                continue;
            }
            
            currentlootid = inventory_getlootidatbackpackindex( i );
            
            if ( currentlootid == lootid )
            {
                var_67ae78eebd102b5c++;
                slotquantity = inventory_getquantityatbackpackindex( i );
                
                if ( slotquantity <= maxcount )
                {
                    slotsavailable = maxcount - slotquantity;
                    var_af8ac5c9d17f99b5 = min( maxcount, slotquantity + quantity );
                    inventory_setbackpackitematindex( i, lootid, var_af8ac5c9d17f99b5, item, undefined, typeref );
                    quantity = int( max( 0, quantity - slotsavailable ) );
                    
                    if ( quantity <= 0 || itembundle.deleteremainder )
                    {
                        return 0;
                    }
                }
                
                continue;
            }
            
            if ( currentlootid == 0 )
            {
                var_2e12622a27a12880++;
            }
        }
    }
    
    var_81c52049381fc8af = min( maxcount, quantity );
    
    if ( autouse && ( !itembundle.var_59803d1ed0f20c22 || !itembundle.var_51f149d23464d654 || var_67ae78eebd102b5c >= itembundle.var_51f149d23464d654 || var_2e12622a27a12880 <= 0 ) )
    {
        return quantity;
    }
    
    if ( common_inventory_groups::inventorygroup_enabled() && isdefined( var_4375d83555c8dd6f ) )
    {
        slots = common_inventory_groups::function_6e8756548142d338( "BACKPACK", var_feb46c6f827972ac );
        
        if ( isdefined( slots ) )
        {
            foreach ( typedata in slots )
            {
                if ( typedata.index >= backpacksize || invalidslots[ typedata.index ] )
                {
                    continue;
                }
                
                if ( !isstackable && !isdefined( var_6ecc64ede36ab68 ) && !common_inventory_groups::function_79e2c2087aa7de1e( itembundle, typedata, lootid ) )
                {
                    continue;
                }
                
                currentlootid = inventory_getlootidatbackpackindex( typedata.index );
                
                if ( currentlootid == 0 && currentlootid != lootid )
                {
                    if ( typeref == "weapon" )
                    {
                        weaponobj = item_weapon::function_31562a2fb3df68d5( itembundle, item );
                        function_1923cd40e1b4efc8( weaponobj );
                    }
                    
                    inventory_setbackpackitematindex( typedata.index, lootid, var_81c52049381fc8af, item, undefined, typeref );
                    quantity -= var_81c52049381fc8af;
                    
                    if ( quantity <= 0 || itembundle.deleteremainder )
                    {
                        return 0;
                    }
                    
                    var_81c52049381fc8af = min( maxcount, quantity );
                }
            }
            
            return common_item::function_598dd39282efb544( quantity );
        }
    }
    
    for ( i = 0; i < backpacksize ; i++ )
    {
        currentlootid = inventory_getlootidatbackpackindex( i );
        
        if ( currentlootid == 0 && currentlootid != lootid )
        {
            inventory_setbackpackitematindex( i, lootid, var_81c52049381fc8af, item );
            quantity -= var_81c52049381fc8af;
            
            if ( quantity <= 0 || itembundle.deleteremainder )
            {
                return 0;
            }
            
            var_81c52049381fc8af = min( maxcount, quantity );
        }
    }
    
    return common_item::function_598dd39282efb544( quantity );
}

// Namespace common_inventory
// Params 2
// Checksum 0xbf24f190, Offset: 0x2d3a
// Size: 0x5d
function function_8b6c67fda6928fd9( index, amount )
{
    oldamount = inventory_getquantityatbackpackindex( index );
    newamount = int( max( 0, oldamount + amount ) );
    lootid = inventory_getlootidatbackpackindex( index );
    inventory_setbackpackitematindex( index, lootid, newamount );
}

// Namespace common_inventory
// Params 0
// Checksum 0x536d229a, Offset: 0x2d9f
// Size: 0x132
function function_1cc2d5027325dc95()
{
    if ( isdefined( self.var_d0759f57356f151a ) )
    {
        foreach ( weapon in self.primaryweapons )
        {
            if ( weapon.basename != "none" )
            {
                inventory_utility::_takeweapon( weapon );
            }
        }
        
        foreach ( weapon in self.var_d0759f57356f151a )
        {
            if ( weapon.basename != "none" )
            {
                inventory_utility::_giveweapon( weapon );
                inventory_utility::_switchtoweaponimmediate( weapon );
            }
        }
        
        self.var_d0759f57356f151a = undefined;
    }
}

// Namespace common_inventory
// Params 1
// Checksum 0xd75cdc93, Offset: 0x2ed9
// Size: 0x106
function function_46997c9dfcd0ef43( ammotype )
{
    lootid = loot::function_d3e3bcaea591a6a2( ammotype );
    
    if ( !isdefined( lootid ) )
    {
        return 0;
    }
    
    var_c0f616c30a8ac08e = int( max( 0, level.br_ammo_max[ ammotype ] - self.br_ammo[ ammotype ] ) );
    maxcount = level.common_item.var_3444316dc55e4b0a[ ammotype ];
    
    if ( !isdefined( maxcount ) )
    {
        maxcount = level.common_item.maxcounts[ ammotype ];
    }
    
    backpacksize = function_9cd65c8312048802();
    
    for ( i = 0; i < backpacksize ; i++ )
    {
        currentlootid = inventory_getlootidatbackpackindex( i );
        
        if ( currentlootid == lootid )
        {
            currentquantity = inventory_getquantityatbackpackindex( i );
            missingammo = int( max( 0, maxcount - currentquantity ) );
            var_c0f616c30a8ac08e += missingammo;
        }
    }
    
    return var_c0f616c30a8ac08e;
}

// Namespace common_inventory
// Params 1
// Checksum 0x6722a835, Offset: 0x2fe8
// Size: 0x51
function inventory_dropammo( spawnoptions )
{
    thread uidropitem( 5, 0, undefined, spawnoptions );
    thread uidropitem( 5, 1, undefined, spawnoptions );
    thread uidropitem( 5, 2, undefined, spawnoptions );
    thread uidropitem( 5, 3, undefined, spawnoptions );
    thread uidropitem( 5, 4, undefined, spawnoptions );
}

// Namespace common_inventory
// Params 1
// Checksum 0x947cef17, Offset: 0x3041
// Size: 0x51
function function_1c78f5a91f111025( spawnoptions )
{
    function_408108e079538628( 5, 0, undefined, spawnoptions );
    function_408108e079538628( 5, 1, undefined, spawnoptions );
    function_408108e079538628( 5, 2, undefined, spawnoptions );
    function_408108e079538628( 5, 3, undefined, spawnoptions );
    function_408108e079538628( 5, 4, undefined, spawnoptions );
}

// Namespace common_inventory
// Params 1
// Checksum 0x25eec015, Offset: 0x309a
// Size: 0x94
function inventory_dropweapons( spawnoptions )
{
    thread uidropitem( 1, #"primary_2", undefined, spawnoptions );
    thread uidropitem( 1, #"primary_1", undefined, spawnoptions );
    thread uidropitem( 1, #"primary_0", undefined, spawnoptions );
    thread uidropitem( 1, #"tertiary_1", undefined, spawnoptions );
    thread uidropitem( 1, #"tertiary_0", undefined, spawnoptions );
    
    if ( isdefined( function_933894456e289760() ) )
    {
        thread uidropitem( 1, #"backpack_0", undefined, spawnoptions );
    }
}

// Namespace common_inventory
// Params 1
// Checksum 0x151084d, Offset: 0x3136
// Size: 0x94
function function_bcb3b52008443a44( spawnoptions )
{
    function_408108e079538628( 1, #"primary_2", undefined, spawnoptions );
    function_408108e079538628( 1, #"primary_1", undefined, spawnoptions );
    function_408108e079538628( 1, #"primary_0", undefined, spawnoptions );
    function_408108e079538628( 1, #"tertiary_1", undefined, spawnoptions );
    function_408108e079538628( 1, #"tertiary_0", undefined, spawnoptions );
    
    if ( isdefined( function_933894456e289760() ) )
    {
        function_408108e079538628( 1, #"backpack_0", undefined, spawnoptions );
    }
}

// Namespace common_inventory
// Params 1
// Checksum 0x5515b6f3, Offset: 0x31d2
// Size: 0x55
function function_dea44924bc39c69a( spawnoptions )
{
    if ( !self.var_b4c45c2992c2e37c.stackprimary )
    {
        thread uidropitem( 2, 0, undefined, spawnoptions );
    }
    
    if ( !self.var_b4c45c2992c2e37c.stacksecondary )
    {
        thread uidropitem( 2, 1, undefined, spawnoptions );
    }
}

// Namespace common_inventory
// Params 1
// Checksum 0x1b35569b, Offset: 0x322f
// Size: 0x27
function function_f49daeb7a25b5b21( spawnoptions )
{
    function_408108e079538628( 2, 0, undefined, spawnoptions );
    function_408108e079538628( 2, 1, undefined, spawnoptions );
}

// Namespace common_inventory
// Params 1
// Checksum 0xb78773bd, Offset: 0x325e
// Size: 0x1a
function function_457446259943ace1( spawnoptions )
{
    thread uidropitem( 2, 2, undefined, spawnoptions );
}

// Namespace common_inventory
// Params 1
// Checksum 0x5b20b2a, Offset: 0x3280
// Size: 0x1a
function inventory_removearmor( spawnoptions )
{
    function_408108e079538628( 2, 2, undefined, spawnoptions );
}

// Namespace common_inventory
// Params 1
// Checksum 0xde615770, Offset: 0x32a2
// Size: 0x19
function function_c06d8f2a85102c39( spawnoptions )
{
    thread uidropitem( 4, undefined, undefined, spawnoptions );
}

// Namespace common_inventory
// Params 1
// Checksum 0x6c542fe7, Offset: 0x32c3
// Size: 0x19
function function_38ff1a66cd956902( spawnoptions )
{
    function_408108e079538628( 4, undefined, undefined, spawnoptions );
}

// Namespace common_inventory
// Params 1
// Checksum 0x15a2650a, Offset: 0x32e4
// Size: 0x19
function function_22b6752ea0b8d004( spawnoptions )
{
    thread uidropitem( 3, undefined, undefined, spawnoptions );
}

// Namespace common_inventory
// Params 1
// Checksum 0x2de44325, Offset: 0x3305
// Size: 0x19
function function_4b4cbbe1c5a19189( spawnoptions )
{
    function_408108e079538628( 3, undefined, undefined, spawnoptions );
}

// Namespace common_inventory
// Params 1
// Checksum 0xc2e27271, Offset: 0x3326
// Size: 0x19
function function_7191bfc32dde4117( spawnoptions )
{
    thread uidropitem( 6, undefined, undefined, spawnoptions );
}

// Namespace common_inventory
// Params 1
// Checksum 0xe4491071, Offset: 0x3347
// Size: 0x19
function function_eb484185711f8cc0( spawnoptions )
{
    function_408108e079538628( 6, undefined, undefined, spawnoptions );
}

// Namespace common_inventory
// Params 1
// Checksum 0x96aca74b, Offset: 0x3368
// Size: 0x19
function function_bea629729eedb95d( spawnoptions )
{
    thread uidropitem( 7, undefined, undefined, spawnoptions );
}

// Namespace common_inventory
// Params 1
// Checksum 0xaeea8164, Offset: 0x3389
// Size: 0x19
function function_94daaff595cfaa7c( spawnoptions )
{
    function_408108e079538628( 7, undefined, undefined, spawnoptions );
}

// Namespace common_inventory
// Params 1
// Checksum 0x90d246d9, Offset: 0x33aa
// Size: 0x4b
function function_d1ada307f58da584( spawnoptions )
{
    backpacksize = function_9cd65c8312048802();
    
    for ( i = 0; i < backpacksize ; i++ )
    {
        thread uidropitem( 10, i, inventory_getquantityatbackpackindex( i ), spawnoptions );
    }
}

// Namespace common_inventory
// Params 1
// Checksum 0xf7528a8f, Offset: 0x33fd
// Size: 0x4b
function function_2d64dff409573799( spawnoptions )
{
    backpacksize = function_9cd65c8312048802();
    
    for ( i = 0; i < backpacksize ; i++ )
    {
        function_408108e079538628( 10, i, inventory_getquantityatbackpackindex( i ), spawnoptions );
    }
}

// Namespace common_inventory
// Params 1
// Checksum 0x47ac4984, Offset: 0x3450
// Size: 0x61
function function_cee9acbe8434a0ed( spawnoptions )
{
    if ( spawnoptions.isdeathevent && utility::issharedfuncdefined( #"gametype", #"hash_2329eb23ec58c745" ) )
    {
        thread utility::callsharedfunc( #"gametype", #"hash_2329eb23ec58c745", undefined, undefined, undefined, spawnoptions );
        return;
    }
    
    thread uidropitem( 0, undefined, undefined, spawnoptions );
}

// Namespace common_inventory
// Params 1
// Checksum 0xb4f20ea6, Offset: 0x34b9
// Size: 0x61
function function_a061ce77da9856d4( spawnoptions )
{
    if ( spawnoptions.isdeathevent && utility::issharedfuncdefined( #"gametype", #"hash_2329eb23ec58c745" ) )
    {
        thread utility::callsharedfunc( #"gametype", #"hash_2329eb23ec58c745", undefined, undefined, undefined, spawnoptions );
        return;
    }
    
    function_408108e079538628( 0, undefined, undefined, spawnoptions );
}

// Namespace common_inventory
// Params 1
// Checksum 0x96d6fa9, Offset: 0x3522
// Size: 0x35
function function_8f0b4f273c78dd61( spawnoptions )
{
    for ( i = 0; i < 4 ; i++ )
    {
        thread uidropitem( 12, i, undefined, spawnoptions );
    }
}

// Namespace common_inventory
// Params 1
// Checksum 0x21b00274, Offset: 0x355f
// Size: 0x35
function function_a56a3897040df5f0( spawnoptions )
{
    for ( i = 0; i < 4 ; i++ )
    {
        function_408108e079538628( 12, i, undefined, spawnoptions );
    }
}

// Namespace common_inventory
// Params 1
// Checksum 0x89c1b039, Offset: 0x359c
// Size: 0x19
function function_4a8e36ee7640731b( spawnoptions )
{
    thread uidropitem( 14, undefined, undefined, spawnoptions );
}

// Namespace common_inventory
// Params 1
// Checksum 0xfa50009, Offset: 0x35bd
// Size: 0x19
function function_ced64d1554a59346( spawnoptions )
{
    function_408108e079538628( 14, undefined, undefined, spawnoptions );
}

// Namespace common_inventory
// Params 1
// Checksum 0x64af1005, Offset: 0x35de
// Size: 0x27
function function_1e5fbfd034d154ff( spawnoptions )
{
    utility::callsharedfunc( #"perk", #"dropperks", spawnoptions );
}

// Namespace common_inventory
// Params 1
// Checksum 0xd48ec2ca, Offset: 0x360d
// Size: 0x27
function function_b5e5631a23c09344( spawnoptions )
{
    utility::callsharedfunc( #"perk", #"dropperks", spawnoptions );
}

// Namespace common_inventory
// Params 1
// Checksum 0xf6019398, Offset: 0x363c
// Size: 0xd1
function function_369198873216ea88( player )
{
    return { #var_f668a5d7e0ae235b:1, #dropperks:1, #droparmor:!utility::callsharedfunc( #"game", #"hash_f5f661388892926c", player ), #var_61abd858dd3b58b4:1, #dropbackpack:1, #dropcash:1, #dropammo:1, #droprevive:utility::callsharedfunc( #"game", #"hash_81aac595b2504f23", player ) ?? 0, #dropgasmask:1, #dropkillstreak:1, #dropsuper:1, #dropequipment:1, #dropweapons:1 };
}

// Namespace common_inventory
// Params 2
// Checksum 0xf7f91cea, Offset: 0x3716
// Size: 0x1e9
function function_4c281d89a14b4a16( var_3b8f1509495546fd, optionalfilter )
{
    spawnoptions = undefined;
    profilestart();
    filter = optionalfilter ?? function_369198873216ea88( self );
    spawnoptions = var_3b8f1509495546fd ?? common_item::items_initspawnoptions_spawnfromposition( self.origin, self.angles );
    spawnoptions.var_7a166247da860246 = [];
    spawnoptions.spawningteam = self.team;
    spawnoptions.originalowner = self;
    function_bcb3b52008443a44( filter.dropweapons ? spawnoptions : undefined );
    function_f49daeb7a25b5b21( filter.dropequipment ? spawnoptions : undefined );
    function_38ff1a66cd956902( filter.dropsuper ? spawnoptions : undefined );
    function_4b4cbbe1c5a19189( filter.dropkillstreak ? spawnoptions : undefined );
    function_eb484185711f8cc0( filter.dropgasmask ? spawnoptions : undefined );
    function_94daaff595cfaa7c( filter.droprevive ? spawnoptions : undefined );
    function_1c78f5a91f111025( filter.dropammo ? spawnoptions : undefined );
    function_a061ce77da9856d4( filter.dropcash ? spawnoptions : undefined );
    function_2d64dff409573799( filter.dropbackpack ? spawnoptions : undefined );
    function_a56a3897040df5f0( filter.var_61abd858dd3b58b4 ? spawnoptions : undefined );
    inventory_removearmor( filter.droparmor ? spawnoptions : undefined );
    function_b5e5631a23c09344( filter.dropperks ? spawnoptions : undefined );
    function_ced64d1554a59346( filter.var_f668a5d7e0ae235b ? spawnoptions : undefined );
    profilestop();
    return spawnoptions;
}

// Namespace common_inventory
// Params 2
// Checksum 0xed1a729b, Offset: 0x3908
// Size: 0x4a
function function_71114c5adfb01f7b( var_3b8f1509495546fd, optionalfilter )
{
    filter = optionalfilter ?? function_369198873216ea88( self );
    spawnoptions = function_4c281d89a14b4a16( var_3b8f1509495546fd, filter );
    level thread function_993f81a1c4d8bbc1( spawnoptions );
}

// Namespace common_inventory
// Params 1
// Checksum 0xf74e381e, Offset: 0x395a
// Size: 0x150
function function_993f81a1c4d8bbc1( spawnoptions )
{
    weaponsdropped = [];
    
    for ( i = 0; i < spawnoptions.var_7a166247da860246.size ; i++ )
    {
        waitframe();
        item = spawnoptions.var_7a166247da860246[ i ];
        spawnoptions.weaponinfostruct = item.weaponinfostruct;
        removeditemname = item.itemname;
        removedcount = item.quantity;
        
        if ( spawnoptions.weaponinfostruct )
        {
            weapon = item_weapon::function_53da2af5697709f8( undefined, item.weaponinfostruct, spawnoptions );
            weaponsdropped[ weaponsdropped.size ] = weapon;
            continue;
        }
        
        var_75e3d865bd2811cd = getscriptbundlefieldvalues( removeditemname, [ #"type" ] );
        common_item::function_db61e190f60b2349( spawnoptions, var_75e3d865bd2811cd );
        common_item::function_61c2c0251e742ffd( removeditemname, removedcount, spawnoptions );
    }
    
    if ( isdefined( level.var_b1065270f009bbf7 ) && weaponsdropped.size > 0 && spawnoptions.spawningentity && isplayer( spawnoptions.spawningentity ) )
    {
        spawnoptions.spawningentity thread [[ level.var_b1065270f009bbf7 ]]( weaponsdropped );
    }
}

// Namespace common_inventory
// Params 1
// Checksum 0x63fce77c, Offset: 0x3ab2
// Size: 0x36
function function_3644767c4087b4cc( var_3b8f1509495546fd )
{
    spawnoptions = var_3b8f1509495546fd ?? common_item::items_initspawnoptions_spawnfromentity( self );
    inventory_dropweapons( spawnoptions );
    function_dea44924bc39c69a( spawnoptions );
}

// Namespace common_inventory
// Params 0, eflags: 0x4
// Checksum 0xe9d0f180, Offset: 0x3af0
// Size: 0xbc
function private function_876415bfe4405106()
{
    var_8fb8e1fb220cca48 = common_item::function_c4c43ebb7aa636dc( "backpack" );
    
    if ( !var_8fb8e1fb220cca48.name )
    {
        gametypefield = isdefined( self.perks[ "specialty_trait_backpack_extra_slots" ] ) ? level.gametypebundle.var_18287131d420be63 : level.gametypebundle.var_621d8b8efdb66e4f;
        return getscriptbundle( gametypefield );
    }
    
    field = isdefined( self.perks[ "specialty_trait_backpack_extra_slots" ] ) ? #"hash_adb81ed1e85e47e6" : #"hash_fa92f052374a998e";
    return getscriptbundle( getscriptbundlefieldvalue( var_8fb8e1fb220cca48.name, field ) );
}

// Namespace common_inventory
// Params 0, eflags: 0x4
// Checksum 0x5214460b, Offset: 0x3bb5
// Size: 0x5d
function private function_5ea4b2b3a1afa146()
{
    var_8fb8e1fb220cca48 = common_item::function_c4c43ebb7aa636dc( "backpack" );
    
    if ( !isdefined( var_8fb8e1fb220cca48.name ) )
    {
        return getscriptbundle( level.gametypebundle.var_41e2e0bb8df3b892 );
    }
    
    return getscriptbundle( getscriptbundlefieldvalue( var_8fb8e1fb220cca48.name, #"hash_4763c14a8207459b" ) );
}

// Namespace common_inventory
// Params 0
// Checksum 0x5c17aeb0, Offset: 0x3c1b
// Size: 0x249
function function_85e1b1f32d40bd39()
{
    var_280f4c5a9aad6612 = common_item::items_initspawnoptions_spawnfromentity( self );
    [ loadoutgroup, _ ] = common_inventory_groups::function_896ed3217a875f7d();
    var_eecc1b3a21621fad = common_inventory_groups::function_19a5a29f5cd0df45( loadoutgroup );
    
    for ( i = 0; i < var_eecc1b3a21621fad ; i++ )
    {
        [ callbacks, typeref, var_8fb8e1fb220cca48 ] = common_inventory_groups::function_6dfdd28826ee7354( loadoutgroup, i );
        
        if ( !( isdefined( callbacks ) && isdefined( var_8fb8e1fb220cca48 ) ) || var_8fb8e1fb220cca48.count <= 0 )
        {
            continue;
        }
        
        if ( typeref == "weapon" )
        {
            continue;
        }
        
        lootid = common_item::function_b01955b20c77371d( var_8fb8e1fb220cca48.name );
        
        if ( lootid > 0 )
        {
            continue;
        }
        
        bundle = common_item::function_90c3e0c1fd55d6b6( var_8fb8e1fb220cca48.name );
        
        if ( !bundle.var_e24642d3b20b855a )
        {
            continue;
        }
        
        common_item::function_61c2c0251e742ffd( bundle, var_8fb8e1fb220cca48.count, var_280f4c5a9aad6612 );
        params = { #count:var_8fb8e1fb220cca48.count, #index:0 };
        self [[ callbacks.funcs[ #"removecurrent" ] ]]( params );
    }
    
    [ backpackgroup, _ ] = common_inventory_groups::function_c27ac785b5373b73();
    backpacksize = function_9cd65c8312048802();
    
    for ( i = 0; i < backpacksize ; i++ )
    {
        lootid = inventory_getlootidatbackpackindex( i );
        quantity = inventory_getquantityatbackpackindex( i );
        
        if ( lootid == 0 || quantity == 0 )
        {
            continue;
        }
        
        bundle = common_item::function_b202b16941992cca( lootid );
        additionaldata = common_inventory_groups::function_af51bdd9c1c5acd3( 1, i );
        
        if ( !bundle.var_e24642d3b20b855a )
        {
            continue;
        }
        
        var_280f4c5a9aad6612.additionaldata = additionaldata;
        common_item::function_61c2c0251e742ffd( bundle, quantity, var_280f4c5a9aad6612 );
        inventory_setbackpackitematindex( i, 0, 0 );
    }
}

// Namespace common_inventory
// Params 1
// Checksum 0x2632ea9f, Offset: 0x3e6c
// Size: 0x3f3
function function_1706ab4cdf733fb3( attacker )
{
    var_46bdfbf377e73ed = self.disconnecting && function_56b8fd2ccc68ddf9() && attacker;
    
    if ( self.disconnecting && !var_46bdfbf377e73ed )
    {
        spawnoptions = common_item::function_bc5ff2958b71a708( self.origin, ( 0, 0, 180 ) );
    }
    else
    {
        spawnoptions = common_item::function_bc5ff2958b71a708( self.origin );
    }
    
    spawnoptions.var_f35b5b18b029c493 = 0;
    spawnoptions.critical = 1;
    
    if ( self.disconnecting && !var_46bdfbf377e73ed )
    {
        var_db7be50631eefb9 = function_5ea4b2b3a1afa146();
        corpse = common_item::function_61c2c0251e742ffd( var_db7be50631eefb9, 1, spawnoptions );
    }
    else
    {
        var_db7be50631eefb9 = function_876415bfe4405106();
        corpse = common_item::function_61c2c0251e742ffd( var_db7be50631eefb9, 1, spawnoptions );
        corpse.owner = self;
        corpse utility::scriptable_setparententity( self, ( 0, 0, 20 ) );
        self.backpackscriptable = corpse;
        self.var_9386f7405ccaa198 = ( 0, 0, 20 );
    }
    
    corpse.contents = [];
    corpse.bundle = var_db7be50631eefb9;
    common_cache::function_9d6321275c249932( corpse );
    
    foreach ( ref, _ in level.var_369bb2cf01ce7896 )
    {
        corpse.var_f28d3e1d622974 = function_98120ff3aa5f552e( ref );
        break;
    }
    
    self.var_50f741a14f09a6 = corpse;
    corpse.onitemtaken = &function_62016a4df2050638;
    var_280f4c5a9aad6612 = common_item::items_initspawnoptions_spawnfromentity( self );
    self.var_6b0d64da08c0a623 = 1;
    droppeditems = common_inventory_groups::function_8ac7b21bacb56918( corpse, var_280f4c5a9aad6612 );
    self.var_6b0d64da08c0a623 = undefined;
    
    foreach ( lootid, quantity in droppeditems )
    {
        callbackparams = { #isspend:0, #currencytype:#"item", #amount:quantity, #sourceitem:lootid };
        telemetry_utils::function_af2d366f9522f76f( "loot_drop_on_death", callbackparams );
    }
    
    corpse.var_80a55ae41f929b49 = self.guid;
    corpse.originalownerteam = self.team;
    corpse.var_f9027633b61e4fb7 = self.var_f9027633b61e4fb7;
    corpse.uimemberindex = self.var_dc7f6dd7f400bd1;
    
    if ( level.gamemodebundle.var_37cc1279b4e22381 )
    {
        function_85b2caf8cc75262c( attacker );
    }
    
    foreach ( teammember in teams::getteamdata( self.team, "players" ) )
    {
        corpse disablescriptableplayeruse( teammember );
    }
    
    if ( !self.disconnecting )
    {
        level thread function_b2c0848009d706ec( self, self.attached_bag, corpse );
    }
}

// Namespace common_inventory
// Params 2, eflags: 0x4
// Checksum 0xe3fdd839, Offset: 0x4267
// Size: 0x15
function private function_62016a4df2050638( corpse, playertaking )
{
    
}

// Namespace common_inventory
// Params 1, eflags: 0x4
// Checksum 0xc492d4c, Offset: 0x4284
// Size: 0x131
function private function_85b2caf8cc75262c( attacker )
{
    var_d9af75c26d5465d8 = currency::get_currency_amount( #"xp_orb" );
    
    if ( !var_d9af75c26d5465d8 )
    {
        return;
    }
    
    if ( self.var_f2b72d1f994760d3[ attacker.team ] )
    {
        return;
    }
    
    if ( attacker.team )
    {
        self.var_f2b72d1f994760d3[ attacker.team ] = 1;
    }
    
    dropgoal = min( ( level.gamemodebundle.var_e7d5e9fd96e887a2 ?? 0.3 ) * var_d9af75c26d5465d8, level.gamemodebundle.var_c0c240924e000561 ?? 50 );
    dropcount = int( min( var_d9af75c26d5465d8, dropgoal ) );
    
    if ( dropcount <= 0 )
    {
        return;
    }
    
    currency::function_b5fe1e05c892a7f3( #"xp_orb", dropcount );
    spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
    
    while ( dropcount >= 10 )
    {
        common_item::function_61c2c0251e742ffd( %"hash_46d9d234f1548450", 10, spawnoptions );
        dropcount -= 10;
    }
    
    if ( dropcount > 0 )
    {
        common_item::function_61c2c0251e742ffd( %"hash_38fabcee577587a4", dropcount, spawnoptions );
    }
}

// Namespace common_inventory
// Params 0
// Checksum 0x55d5ca60, Offset: 0x43bd
// Size: 0x4, Type: bool
function function_88e95c4947652564()
{
    return true;
}

// Namespace common_inventory
// Params 4, eflags: 0x4
// Checksum 0xd4080284, Offset: 0x43ca
// Size: 0x39f
function private function_b2c0848009d706ec( deadplayer, model, corpse, droppedweapon )
{
    corpse endon( #"death" );
    guid = deadplayer.guid;
    result = deadplayer utility::waittill_any_return_no_endon_death( "disconnect", "spawned" );
    
    if ( !corpse )
    {
        return;
    }
    
    if ( result == "disconnect" )
    {
        if ( function_56b8fd2ccc68ddf9() )
        {
            return;
        }
        
        neworigin = utility::drop_to_ground( corpse.origin ) + ( 0, 0, 2 );
        var_4ee1e1964ab7b9d9 = deadplayer function_5ea4b2b3a1afa146();
        spawnedbackpack = spawnscriptable( var_4ee1e1964ab7b9d9.scriptable, neworigin, ( 0, 0, 180 ) );
        function_dbab7677624ea28( corpse, spawnedbackpack );
        
        foreach ( content in corpse.contents )
        {
            if ( content.quantity > 0 )
            {
                if ( dmz_dog_tag::function_7b2fcbd8d8d2e2a3( content.lootid ) && guid == content.item.additionaldata.var_80a55ae41f929b49 )
                {
                    common_cache::function_52ac35e31eb303d3( spawnedbackpack, %"hash_434c34bbaa6518e0", common_item_database::function_db2360bc1c33f6f9( content.lootid ), content.quantity, 1, undefined, content.item );
                    continue;
                }
                
                common_cache::cache_additem( spawnedbackpack, common_item_database::function_db2360bc1c33f6f9( content.lootid ), content.quantity, 1, undefined, content.item );
            }
        }
        
        if ( isdefined( corpse.opener ) )
        {
            common_cache::closelootablecontainer( corpse, corpse.opener );
        }
        
        corpse freescriptable();
        return;
    }
    
    if ( isdefined( droppedweapon ) )
    {
        deadplayer common_item::function_96119bed8ab4c5d9( droppedweapon );
    }
    
    foreach ( item in corpse.contents )
    {
        if ( !item.lootid )
        {
            continue;
        }
        
        itembundle = common_item::function_b202b16941992cca( item.lootid );
        itembundlename = common_item::function_e044c3e813daec3a( itembundle );
        pickupitem = common_item::function_77600f92048df72d( itembundle, item.quantity, item.weaponobj, undefined, undefined, item.item, item.weapondata );
        
        if ( item.item.additionaldata.groupindex == 1 )
        {
            deadplayer function_1a85f583119d9740( itembundlename, itembundle, pickupitem, undefined, item.lootid );
            continue;
        }
        
        deadplayer common_item::function_96119bed8ab4c5d9( pickupitem, 0, 1, 1 );
    }
    
    thread common_item::function_869d7676e359a627( corpse );
}

// Namespace common_inventory
// Params 1
// Checksum 0xe2313c9e, Offset: 0x4771
// Size: 0x7b
function function_c54ad5b34ff0a17a( xmodelname )
{
    if ( isdefined( xmodelname ) )
    {
        switch ( xmodelname )
        {
            case #"hash_dca6f419e607e1f7":
                return "brloot_backpack_player_small";
            case #"hash_d9938108fa8eb85f":
                return "brloot_backpack_player_medium";
            case #"hash_e3731b91d944f82f":
                return "brloot_backpack_player_large";
            case #"hash_e6d61aa8716cb5e3":
                return "brloot_backpack_player_secure";
            case #"hash_1dc65c7b5858c244":
                return "brloot_backpack_player_scav";
        }
    }
    
    return "brloot_backpack";
}

// Namespace common_inventory
// Params 2, eflags: 0x4
// Checksum 0xe59b2a80, Offset: 0x47f5
// Size: 0x9f
function private function_dbab7677624ea28( corpse, backpack )
{
    backpack.containertype = corpse.containertype;
    backpack.owner = corpse.player;
    backpack.var_80a55ae41f929b49 = corpse.var_80a55ae41f929b49;
    backpack.originalownerteam = corpse.originalownerteam;
    backpack.var_f9027633b61e4fb7 = corpse.var_f9027633b61e4fb7;
    backpack.uimemberindex = corpse.uimemberindex;
}

// Namespace common_inventory
// Params 3, eflags: 0x4
// Checksum 0xd5aed250, Offset: 0x489c
// Size: 0x114
function private function_ac4fb18ae40c4cbc( container, lootid, weapon )
{
    weaponmaphandle = undefined;
    
    if ( isdefined( lootid ) && lootid != 0 )
    {
        if ( !isdefined( weapon ) )
        {
            scriptabledefname = loot::getScriptableFromLootID( lootid );
            assert( isdefined( scriptabledefname ) );
            weaponmaphandle = function_646cc662db6a3fe0( scriptabledefname );
        }
        else if ( isweapon( weapon ) )
        {
            weaponclasstoken = weapon::getweaponclasstoken( weapon.basename );
            scriptabledefname = "brloot_weapon_generic_" + weaponclasstoken;
            weaponmaphandle = function_646cc662db6a3fe0( scriptabledefname, weapon );
        }
        else
        {
            assert( isstring( weapon ) );
            scriptabledefname = weapon;
            weaponmaphandle = function_646cc662db6a3fe0( scriptabledefname );
        }
    }
    
    if ( isdefined( weaponmaphandle ) && weaponmaphandle != 0 )
    {
        assert( isdefined( container ) );
        
        if ( !isdefined( container.var_9698b23946ca9ef7 ) )
        {
            container.var_9698b23946ca9ef7 = [];
        }
        
        container.var_9698b23946ca9ef7[ container.var_9698b23946ca9ef7.size ] = weaponmaphandle;
    }
    
    return loot_mp::function_3356ab331151b684( lootid, weaponmaphandle );
}

// Namespace common_inventory
// Params 1
// Checksum 0x10756f57, Offset: 0x49b9
// Size: 0x1c, Type: bool
function function_614b449545fb220b( index )
{
    if ( common_inventory_groups::inventorygroup_enabled() )
    {
        return false;
    }
    
    return index >= 11;
}

// Namespace common_inventory
// Params 2
// Checksum 0x27d1453e, Offset: 0x49de
// Size: 0x2e8
function function_5f7bc3510079202c( instance, index )
{
    if ( !isdefined( instance.loadoutomnvars ) )
    {
        return [ 0, 0 ];
    }
    
    switch ( index )
    {
        case 11:
            return [ common_item::items_getlootidfromref( "cash" ), instance.loadoutomnvars[ "loot_container_loadout_plunder_quantity" ] ?? 0 ];
        case 12:
            return [ instance.loadoutomnvars[ "loot_container_loadout_lethal_id" ] ?? 0, instance.loadoutomnvars[ "loot_container_loadout_lethal_quantity" ] ?? 0 ];
        case 13:
            return [ instance.loadoutomnvars[ "loot_container_loadout_tactical_id" ] ?? 0, instance.loadoutomnvars[ "loot_container_loadout_tactical_quantity" ] ?? 0 ];
        case 14:
            return [ common_item::items_getlootidfromref( level.armorref ?? "equip_armorplate" ), instance.loadoutomnvars[ "loot_container_loadout_armor_quantity" ] ?? 0 ];
        case 15:
            return [ instance.loadoutomnvars[ "loot_container_loadout_killstreak_id" ] ?? 0, 1 ];
        case 16:
            return [ instance.loadoutomnvars[ "loot_container_loadout_super_id" ] ?? 0, 1 ];
        case 17:
            gasmasktype = instance.loadoutomnvars[ "loot_container_loadout_gasmask_id" ] ?? 0;
            
            if ( gasmasktype == 3 )
            {
                lootid = common_item::items_getlootidfromref( "gas_mask_durable" );
            }
            else if ( gasmasktype == 2 )
            {
                lootid = common_item::items_getlootidfromref( "gas_mask" );
            }
            else
            {
                lootid = 0;
            }
            
            return [ lootid, instance.loadoutomnvars[ "loot_container_loadout_gasmask_quantity" ] ?? 0 ];
        case 18:
            return [ common_item::items_getlootidfromref( "brloot_self_revive" ), instance.loadoutomnvars[ "loot_container_loadout_revive" ] ?? 0 ];
        case 19:
            return [ dmz_dog_tag::function_d19864f8c32f315f( self ), instance.loadoutomnvars[ "loot_container_loadout_dogtag_quantity" ] ?? 0 ];
        case 20:
            return [ instance.loadoutomnvars[ "loot_container_loadout_backpack" ] ?? 0, 1 ];
        case 150:
            return [ loot_mp::function_fe4ecb88aeb31c79( instance.loadoutomnvars[ "loot_container_loadout_weapon_id" ] ?? 0 ).lootid, 1 ];
    }
}

// Namespace common_inventory
// Params 2
// Checksum 0xd19f836d, Offset: 0x4cce
// Size: 0x303
function function_5ea342500de9311( index, newquantity )
{
    instance = self.var_50f741a14f09a6;
    
    if ( !isdefined( instance.loadoutomnvars ) )
    {
        return;
    }
    
    switch ( index )
    {
        case 11:
            instance.loadoutomnvars[ "loot_container_loadout_plunder_quantity" ] = newquantity;
            self setclientomnvar( "loot_container_loadout_plunder_quantity", newquantity );
            break;
        case 12:
            instance.loadoutomnvars[ "loot_container_loadout_lethal_quantity" ] = newquantity;
            self setclientomnvar( "loot_container_loadout_lethal_quantity", newquantity );
            
            if ( newquantity == 0 )
            {
                instance.loadoutomnvars[ "loot_container_loadout_lethal_id" ] = newquantity;
                self setclientomnvar( "loot_container_loadout_lethal_id", newquantity );
            }
            
            break;
        case 13:
            instance.loadoutomnvars[ "loot_container_loadout_tactical_quantity" ] = newquantity;
            self setclientomnvar( "loot_container_loadout_tactical_quantity", newquantity );
            
            if ( newquantity == 0 )
            {
                instance.loadoutomnvars[ "loot_container_loadout_tactical_id" ] = newquantity;
                self setclientomnvar( "loot_container_loadout_tactical_id", newquantity );
            }
            
            break;
        case 14:
            instance.loadoutomnvars[ "loot_container_loadout_armor_quantity" ] = newquantity;
            self setclientomnvar( "loot_container_loadout_armor_quantity", newquantity );
            break;
        case 15:
            if ( newquantity == 0 )
            {
                instance.loadoutomnvars[ "loot_container_loadout_killstreak_id" ] = 0;
                self setclientomnvar( "loot_container_loadout_killstreak_id", 0 );
            }
            
            break;
        case 16:
            if ( newquantity == 0 )
            {
                instance.loadoutomnvars[ "loot_container_loadout_super_id" ] = 0;
                self setclientomnvar( "loot_container_loadout_super_id", 0 );
            }
            
            break;
        case 17:
            instance.loadoutomnvars[ "loot_container_loadout_gasmask_quantity" ] = newquantity;
            self setclientomnvar( "loot_container_loadout_gasmask_quantity", newquantity );
            
            if ( newquantity == 0 )
            {
                instance.loadoutomnvars[ "loot_container_loadout_gasmask_id" ] = 0;
                self setclientomnvar( "loot_container_loadout_gasmask_id", 0 );
            }
            
            break;
        case 18:
            instance.loadoutomnvars[ "loot_container_loadout_revive" ] = newquantity;
            self setclientomnvar( "loot_container_loadout_revive", newquantity );
            break;
        case 19:
            if ( newquantity == 0 )
            {
                instance.loadoutomnvars[ "loot_container_loadout_dogtag_quantity" ] = 0;
                instance.loadoutomnvars[ "loot_container_loadout_dogtag_tier" ] = 0;
                self setclientomnvar( "loot_container_loadout_dogtag_quantity", 0 );
                self setclientomnvar( "loot_container_loadout_dogtag_tier", 0 );
            }
            
            break;
        case 20:
            if ( newquantity == 0 )
            {
                instance.loadoutomnvars[ "loot_container_loadout_backpack" ] = 0;
                self setclientomnvar( "loot_container_loadout_backpack", 0 );
            }
            
            break;
        case 150:
            if ( newquantity == 0 )
            {
                instance.loadoutomnvars[ "loot_container_loadout_weapon_id" ] = 0;
                self setclientomnvar( "loot_container_loadout_weapon_id", 0 );
            }
            
            break;
    }
}

// Namespace common_inventory
// Params 2
// Checksum 0xab1f65fc, Offset: 0x4fd9
// Size: 0x71
function function_3a25b4ecb8b50411( corpse, index )
{
    if ( index != 150 )
    {
        return;
    }
    
    if ( !isdefined( corpse.var_9185433e2ad9ec33 ) )
    {
        return;
    }
    
    return { #type:item_weapon::function_f75620a38a24072(), #count:corpse.loadoutomnvars[ "loot_container_loadout_weapon_ammo" ] ?? 0, #weaponobj:corpse.var_9185433e2ad9ec33 };
}

// Namespace common_inventory
// Params 1
// Checksum 0x9cad6519, Offset: 0x5053
// Size: 0xd0
function function_23e6c4f7cc3350d3( struct )
{
    foreach ( backpackitem in struct.backpackitems )
    {
        lootid = common_item::function_b01955b20c77371d( backpackitem.backpackitem );
        quantity = backpackitem.quantity ? backpackitem.quantity : 1;
        
        if ( lootid )
        {
            function_d3959596f4031a1d( lootid, quantity );
        }
    }
}

// Namespace common_inventory
// Params 1
// Checksum 0xfb1716b2, Offset: 0x512b
// Size: 0xab
function inventory_onplayerspawned( params )
{
    if ( !inventory_isenabled() || params.revivespawn || common_instance_inventory::isenabled() )
    {
        return;
    }
    
    function_f8f5267dca49c43e();
    
    if ( isdefined( level.gametypebundle.clearinventoryonspawn ) && !level.gametypebundle.clearinventoryonspawn )
    {
        return;
    }
    
    if ( isdefined( function_211a16b41e71f692() ) )
    {
        function_1202b827227d4ad2();
    }
    
    if ( self.classstruct && self.classstruct.backpackitems )
    {
        function_23e6c4f7cc3350d3( self.classstruct );
    }
}

// Namespace common_inventory
// Params 4
// Checksum 0x81bb9eb7, Offset: 0x51de
// Size: 0x193
function function_7995ab7f567ba9d3( item, autouse, var_8ec9bd311c662237, var_52b39fa4cade665f )
{
    if ( !inventory_isenabled() )
    {
        return 0;
    }
    
    itembundlename = common_item::function_33a2c00e46263d99( item );
    
    if ( !isdefined( itembundlename ) )
    {
        return 0;
    }
    
    if ( function_99a3c189718cdd9e( itembundlename ) )
    {
        return 0;
    }
    
    itembundle = getscriptbundle( itembundlename );
    
    if ( !common_item::function_5cf4e552f9e871f1( itembundle ) )
    {
        return 0;
    }
    
    itemdata = common_item::function_a48ae6cbf7e8c2d5( item );
    var_6ecc64ede36ab68 = undefined;
    lootid = common_item::function_779887309ec71dfe( itembundle );
    itemtype = common_item::function_16e8c106491eeaca( itembundle );
    
    if ( common_inventory_groups::inventorygroup_enabled() )
    {
        var_4375d83555c8dd6f = common_inventory_groups::inventorygroup_enabled() ? common_inventory_groups::function_c27ac785b5373b73()[ 0 ] : undefined;
        
        if ( var_4375d83555c8dd6f )
        {
            var_6ecc64ede36ab68 = common_inventory_groups::function_9cfb83fd532b7894( itembundle, var_4375d83555c8dd6f, function_9cd65c8312048802(), lootid );
        }
    }
    
    if ( !autouse && !inventory_canitemfitinbackpack( itembundle, common_item::function_974a788b833e282b( item, itembundle ), undefined, item, lootid, itemtype, var_6ecc64ede36ab68 ) )
    {
        return function_b374bcc6d7c43b31( item, lootid, itembundlename, 1, undefined, var_52b39fa4cade665f );
    }
    
    remainder = function_1a85f583119d9740( itembundlename, itembundle, item, autouse, lootid, itemtype, var_6ecc64ede36ab68 );
    quantitystowed = item.count - remainder;
    common_item::function_6b392f3e5fc53c0d( item, itembundle, remainder );
    
    if ( quantitystowed > 0 )
    {
        common_item::function_2e0436a8625e3515( itembundle, quantitystowed, itemdata, 0, var_8ec9bd311c662237 );
        return quantitystowed;
    }
    
    if ( !var_8ec9bd311c662237 )
    {
        common_item::function_eddf962212836a3e( itembundle, 0 );
    }
    
    return 0;
}

// Namespace common_inventory
// Params 6
// Checksum 0xa17ee4b9, Offset: 0x537a
// Size: 0x355
function function_b374bcc6d7c43b31( item, lootid, itembundlename = common_item::function_33a2c00e46263d99( item ), var_f1fc3c3c80cdc76f = 0, var_8ec9bd311c662237, var_52b39fa4cade665f )
{
    if ( !isdefined( itembundlename ) )
    {
        assertmsg( "<dev string:x431>" + item.type + "<dev string:x471>" );
        return 0;
    }
    
    assert( itembundlename == common_item::function_33a2c00e46263d99( item ), "<dev string:x4a4>" );
    
    if ( function_99a3c189718cdd9e( itembundlename ) )
    {
        return 0;
    }
    
    itembundle = getscriptbundle( itembundlename );
    
    if ( !isdefined( itembundle ) )
    {
        assertmsg( "<dev string:x513>" + getxhashsourcename( itembundlename ) + "<dev string:x471>" );
        return 0;
    }
    
    self.var_6eec07112ad043b8 = gettime();
    
    if ( !common_item::function_5cf4e552f9e871f1( itembundle ) || itembundle.notbackpack )
    {
        return 0;
    }
    
    itemtype = common_item::function_16e8c106491eeaca( itembundle );
    
    if ( isdefined( itemtype ) )
    {
        callbacks = common_item::function_9f00d6361edd38ce( itemtype );
        
        if ( isdefined( callbacks.funcs[ #"hash_549c36915774594e" ] ) )
        {
            var_efdf2e7094e10b13 = self [[ callbacks.funcs[ #"hash_549c36915774594e" ] ]]( itembundle );
            
            if ( var_efdf2e7094e10b13 )
            {
                common_item::function_2b5e2ff57d5f392( item, undefined, var_8ec9bd311c662237 );
                return 0;
            }
        }
        
        if ( isdefined( callbacks.funcs[ #"caninteract" ] ) )
        {
            caninteract = self [[ callbacks.funcs[ #"caninteract" ] ]]( { #item:item, #togroup:1, #itembundle:itembundle } );
        }
        else
        {
            weaponobj = function_f66959a3d0c23978( item, itemtype, itembundle );
            caninteract = self function_a35b39392c23339f( { #weaponobj:weaponobj, #togroup:1, #itembundlename:itembundlename } );
        }
        
        if ( !caninteract )
        {
            return 0;
        }
    }
    
    if ( !var_f1fc3c3c80cdc76f && inventory_canitemfitinbackpack( itembundle, item.count, undefined, item, lootid ) )
    {
        itemdata = common_item::function_a48ae6cbf7e8c2d5( item, lootid );
        remainder = function_1a85f583119d9740( itembundlename, itembundle, item, undefined, lootid );
        stowed_count = item.count - remainder;
        common_item::function_6b392f3e5fc53c0d( item, itembundle, remainder );
        common_item::function_2e0436a8625e3515( itembundle, stowed_count, itemdata, 0, var_8ec9bd311c662237 );
        return stowed_count;
    }
    
    if ( common_inventory_groups::inventorygroup_enabled() )
    {
        if ( itemtype == "weapon" )
        {
            weaponcount = item.count;
            item.var_2bc2b0a122147bae = 1;
            common_item::function_2b5e2ff57d5f392( item, undefined, undefined, undefined, itembundle, itemtype );
            return weaponcount;
        }
        
        quantitysecured = function_87aa67ee2b065517( itembundlename, itembundle, item, var_8ec9bd311c662237 );
        
        if ( quantitysecured > 0 )
        {
            return quantitysecured;
        }
        
        validslot = common_inventory_groups::function_76928b4f093ca1ad( 1, itembundle, 1, item );
        
        if ( !isdefined( validslot ) )
        {
            return 0;
        }
    }
    
    if ( !var_52b39fa4cade665f )
    {
        if ( !isdefined( item.var_bfb964dc17a2982c ) )
        {
            item.var_bfb964dc17a2982c = 1;
        }
        
        function_7d1d46e75dfdaece( item, lootid );
    }
    
    return 0;
}

// Namespace common_inventory
// Params 2
// Checksum 0x4d879edd, Offset: 0x56d8
// Size: 0x1f0
function function_7d1d46e75dfdaece( item, lootid )
{
    var_b52cfc0aab60d70a = common_cache::function_705da5a7c1cc2b41();
    
    if ( !isdefined( var_b52cfc0aab60d70a ) )
    {
        return;
    }
    
    inventorygroup = common_inventory_groups::function_dffd0ba870098fc5( var_b52cfc0aab60d70a );
    itembundle = common_item::function_6b8ff3d5f2688336( item );
    validslot = common_inventory_groups::function_76928b4f093ca1ad( 21, itembundle, 1, item, inventorygroup, var_b52cfc0aab60d70a );
    
    if ( !isdefined( validslot ) )
    {
        return;
    }
    
    if ( !isdefined( item.var_bfb964dc17a2982c ) )
    {
        assertmsg( "<dev string:x556>" );
    }
    
    stubcache = item;
    stubcache.contents = [];
    stubcache.containertype = 14;
    stubcache.contents[ 0 ] = spawnstruct();
    stubcache.contents[ 0 ].quantity = item.count;
    stubcache.contents[ 0 ].lootid = lootid;
    stubcache.var_6e5229c10873d74a = 1;
    stubcache.inventorygroup = inventorygroup;
    stubcache.inventorygroupname = var_b52cfc0aab60d70a;
    stubcache.inventorygroup.index = common_cache::function_cd864dbca60b4577();
    
    if ( isdefined( item.var_6828becb300b1c44 ) )
    {
        stubcache.contents[ 0 ].weapondata = spawnstruct();
        stubcache.contents[ 0 ].weapondata.rarity = item.var_6828becb300b1c44.rarity;
        stubcache.contents[ 0 ].weapondata.attachments = item.var_6828becb300b1c44.attachments;
    }
    
    function_293e8ca6b8e585f6( stubcache );
}

// Namespace common_inventory
// Params 1
// Checksum 0xa4ecf8cb, Offset: 0x58d0
// Size: 0x202
function function_293e8ca6b8e585f6( stubcache )
{
    if ( !isdefined( stubcache.var_bfb964dc17a2982c ) )
    {
        assertmsg( "<dev string:x556>" );
        return;
    }
    
    if ( stubcache.var_bfb964dc17a2982c == 0 || stubcache.fromcache )
    {
        assertmsg( "<dev string:x608>" );
        return;
    }
    
    itemcount = stubcache.contents[ 0 ].quantity;
    itemlootid = stubcache.contents[ 0 ].lootid;
    itemweapondata = stubcache.contents[ 0 ].weapondata;
    stubcache.var_3ce963fa4f90ffdd = self.var_50f741a14f09a6;
    stubcache.var_fa306d1ca4b7a841 = self.var_75f60e367c30d7ac;
    self.var_50f741a14f09a6 = stubcache;
    self.var_75f60e367c30d7ac = self.origin;
    
    if ( stubcache.var_bfb964dc17a2982c == 1 && !isstruct( stubcache ) && stubcache isscriptableinstance() )
    {
        foreach ( player in level.players )
        {
            stubcache disablescriptableplayeruse( player );
        }
    }
    
    common_cache::function_7875275a0511dfeb( self, 0, itemlootid, itemcount, itemweapondata );
    
    for ( itemindex = 1; itemindex < 55 ; itemindex++ )
    {
        common_cache::function_8632ef63c71b6048( self, itemindex );
    }
    
    self setclientomnvar( "loot_container_weapon", 0 );
    self setclientomnvar( "loot_container_open", common_cache::function_62d95810cae876df( stubcache ) );
    thread function_fe1628fc20df1532( stubcache );
    stubcache thread function_eaf1b53e998abfc( self );
}

// Namespace common_inventory
// Params 1
// Checksum 0x9e7b86c6, Offset: 0x5ada
// Size: 0x1b5
function function_a1677226f1d7e408( stubcache )
{
    if ( !isdefined( stubcache.var_bfb964dc17a2982c ) )
    {
        assertmsg( "<dev string:x556>" );
        return;
    }
    
    self setclientomnvar( "loot_container_open", 0 );
    
    if ( stubcache.var_bfb964dc17a2982c == 1 && !isstruct( stubcache ) && stubcache isscriptableinstance() )
    {
        if ( common_cache::iscontainerempty( stubcache ) )
        {
            common_item::function_869d7676e359a627( stubcache );
        }
        else
        {
            foreach ( player in level.players )
            {
                stubcache enablescriptableplayeruse( player );
            }
        }
    }
    
    if ( stubcache.var_bfb964dc17a2982c == 2 && isstruct( stubcache ) && !common_cache::iscontainerempty( stubcache ) )
    {
        lootid = stubcache.contents[ 0 ].lootid;
        quantity = stubcache.contents[ 0 ].quantity;
        function_54c2ba7e4353996( lootid, quantity );
        common_cache::function_25bee1f5701a0786( self, 0, 0, 0 );
    }
    
    self.var_50f741a14f09a6 = stubcache.var_3ce963fa4f90ffdd;
    self.var_75f60e367c30d7ac = stubcache.var_fa306d1ca4b7a841;
    stubcache.var_3ce963fa4f90ffdd = undefined;
    stubcache.var_fa306d1ca4b7a841 = undefined;
    stubcache notify( #"closed" );
}

// Namespace common_inventory
// Params 1
// Checksum 0x1b6a6ae7, Offset: 0x5c97
// Size: 0x5d
function function_fe1628fc20df1532( cache )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"disconnect" );
    cache endon( #"death" );
    cache endon( #"closed" );
    cache common_cache::function_489fcdde96d16732( self );
    thread function_a1677226f1d7e408( cache );
}

// Namespace common_inventory
// Params 1
// Checksum 0xecc036e4, Offset: 0x5cfc
// Size: 0x68
function function_eaf1b53e998abfc( player )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    player endon( #"death" );
    player endon( #"disconnect" );
    utility::waittill_any( "closed", "close_container", "flashbang", "concussed", "weapon_fired" );
    player thread function_a1677226f1d7e408( self );
}

// Namespace common_inventory
// Params 6
// Checksum 0xc2614146, Offset: 0x5d6c
// Size: 0x22c
function function_22c912d7a228afd8( backpackindex, lootid, quantity, dontdrop, item, var_8ec9bd311c662237 )
{
    var_e008cd73b3ebdff7 = common_item_database::function_db2360bc1c33f6f9( lootid );
    
    if ( isdefined( var_e008cd73b3ebdff7 ) )
    {
        if ( function_99a3c189718cdd9e( var_e008cd73b3ebdff7 ) )
        {
            return 0;
        }
    }
    
    backpacklootid = inventory_getlootidatbackpackindex( backpackindex );
    backpackquantity = inventory_getquantityatbackpackindex( backpackindex );
    newitembundle = common_item::function_90c3e0c1fd55d6b6( var_e008cd73b3ebdff7 );
    maxcount = common_item::function_38334193bd9b5956( newitembundle );
    newitemtype = common_item::function_16e8c106491eeaca( newitembundle );
    var_12bbba5c33a14a9b = int( min( maxcount, quantity ) );
    amountused = var_12bbba5c33a14a9b;
    
    if ( backpacklootid == lootid && ( !newitemtype || common_item::function_bfd517bdc8850ea6( newitemtype, newitembundle ) ) )
    {
        var_12bbba5c33a14a9b = int( min( maxcount, quantity + backpackquantity ) );
        amountused = var_12bbba5c33a14a9b - backpackquantity;
        dontdrop = 1;
    }
    
    if ( backpacklootid != 0 && backpackquantity != 0 && !dontdrop && backpackquantity > 0 )
    {
        oldbundlename = common_item_database::function_db2360bc1c33f6f9( backpacklootid );
        var_d47e2bb8eabbfe7c = getscriptbundle( oldbundlename );
        spawnoptions = undefined;
        
        if ( self.var_50f741a14f09a6 && self.var_50f741a14f09a6.containertype != 14 && common_cache::function_e3795ef6fb5d5a82() )
        {
            [ baseorigin, _ ] = common_cache::function_9d11bc7908a66f11( self.var_50f741a14f09a6 );
            spawnoptions = common_item::items_initspawnoptions_spawnfromposition( baseorigin, self.var_50f741a14f09a6.angles );
            spawnoptions.ignoreents = [ self.var_50f741a14f09a6 ];
        }
        else
        {
            spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
        }
        
        common_item::function_61c2c0251e742ffd( var_d47e2bb8eabbfe7c, backpackquantity, spawnoptions );
    }
    
    inventory_setbackpackitematindex( backpackindex, lootid, var_12bbba5c33a14a9b, item );
    
    if ( !var_8ec9bd311c662237 )
    {
        common_item::function_eddf962212836a3e( newitembundle, 1 );
    }
    
    return amountused;
}

// Namespace common_inventory
// Params 0
// Checksum 0xf3c4a914, Offset: 0x5fa1
// Size: 0x1f, Type: bool
function inventory_isenabled()
{
    return common_item::items_isenabled() && level.gametypebundle.var_722cd6288caa9ff1;
}

// Namespace common_inventory
// Params 0
// Checksum 0xe272c44a, Offset: 0x5fc9
// Size: 0x7a, Type: bool
function function_5c64d2b24a8c3e18()
{
    if ( common_inventory_groups::inventorygroup_enabled() )
    {
        return isdefined( level.gametypebundle.var_d64fe236fbddfa34 );
    }
    
    if ( !isdefined( level.noinventory ) )
    {
        return false;
    }
    
    if ( utility::issharedfuncdefined( #"gametype", #"hash_24ecc9dd35043a79" ) )
    {
        if ( !utility::callsharedfunc( #"gametype", #"hash_24ecc9dd35043a79" ) )
        {
            return false;
        }
    }
    
    if ( !level.noinventory )
    {
        return true;
    }
    
    return false;
}

// Namespace common_inventory
// Params 1
// Checksum 0xeb841f4f, Offset: 0x604c
// Size: 0x5d
function function_7ec5937e3b3d86e0( itemname )
{
    var_7bd99e1c7579e4f4 = function_5c64d2b24a8c3e18();
    
    if ( var_7bd99e1c7579e4f4 && utility::issharedfuncdefined( #"gametype", #"lootallowedinbackpack" ) )
    {
        var_7bd99e1c7579e4f4 = utility::callsharedfunc( #"gametype", #"lootallowedinbackpack", itemname );
    }
    
    return var_7bd99e1c7579e4f4;
}

// Namespace common_inventory
// Params 0
// Checksum 0xe4a88336, Offset: 0x60b2
// Size: 0x15
function function_211a16b41e71f692()
{
    return level.gametypebundle.backpackkey;
}

// Namespace common_inventory
// Params 0
// Checksum 0xa4d12496, Offset: 0x60d0
// Size: 0x7
function function_33fb71f2e7ba4629()
{
    return "backpackSize";
}

// Namespace common_inventory
// Params 0
// Checksum 0xa40717cc, Offset: 0x60e0
// Size: 0x15
function function_933894456e289760()
{
    return level.gametypebundle.var_1aef570323aaeff0;
}

// Namespace common_inventory
// Params 0
// Checksum 0x8066ddc, Offset: 0x60fe
// Size: 0xcb
function function_15344519fedb8bb0()
{
    backpack_size = level.gametypebundle.backpacksize ?? 8;
    setdvarifuninitialized( @"unified_backpack_size", level.gametypebundle.var_53f82dea7d1e0215 );
    
    if ( level.gametypebundle.var_53f82dea7d1e0215 )
    {
        setdvarifuninitialized( @"inventory_backpack_size", backpack_size );
    }
    
    if ( common_inventory_groups::inventorygroup_enabled() && isdefined( level.gametypebundle.var_d64fe236fbddfa34 ) )
    {
        backpack_size = common_inventory_groups::function_19a5a29f5cd0df45( getscriptbundlefieldvalues( level.gametypebundle.var_d64fe236fbddfa34, [ #"buttonrows" ] ) );
    }
    
    setdvarifuninitialized( @"hash_a384f4621ba11550", backpack_size );
}

// Namespace common_inventory
// Params 0
// Checksum 0xaa76db57, Offset: 0x61d1
// Size: 0x6b
function function_538786216800afe9()
{
    if ( !common_inventory_groups::inventorygroup_enabled() || !level.gametypebundle.var_8e68df9684111673 || !isdefined( self.perks[ "specialty_trait_backpack_extra_slots" ] ) )
    {
        return function_ddf98332913ae51();
    }
    
    return common_inventory_groups::function_19a5a29f5cd0df45( getscriptbundlefieldvalues( level.gametypebundle.var_8e68df9684111673, [ #"buttonrows" ] ) );
}

// Namespace common_inventory
// Params 0
// Checksum 0x25f8bc07, Offset: 0x6245
// Size: 0x9b
function function_ddf98332913ae51()
{
    var_7237854e3be197ca = level.var_3c8d9ace644af482;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    default_size = 8;
    
    if ( common_inventory_groups::inventorygroup_enabled() && isdefined( level.gametypebundle.var_d64fe236fbddfa34 ) )
    {
        default_size = common_inventory_groups::function_19a5a29f5cd0df45( getscriptbundlefieldvalues( level.gametypebundle.var_d64fe236fbddfa34, [ #"buttonrows" ] ) );
    }
    
    level.var_3c8d9ace644af482 = getdvarint( @"hash_a384f4621ba11550", default_size );
    return level.var_3c8d9ace644af482;
}

// Namespace common_inventory
// Params 0
// Checksum 0xcdc5118, Offset: 0x62e9
// Size: 0x25, Type: bool
function function_7d8024a0beed38ae()
{
    if ( function_211a16b41e71f692() )
    {
        return ( level.gametypebundle.var_233705505ff57a83 ?? 10 );
    }
    
    return false;
}

// Namespace common_inventory
// Params 0
// Checksum 0x63fee7b7, Offset: 0x6317
// Size: 0x22, Type: bool
function function_5a70e09721a21568()
{
    if ( !inventory_isenabled() )
    {
        return false;
    }
    
    return istrue( level.gametypebundle.var_d93b43485e70004e );
}

// Namespace common_inventory
// Params 1
// Checksum 0xe3fe5008, Offset: 0x6342
// Size: 0x7d
function function_476110daf7b2ce9b( lootid )
{
    if ( lootid == 0 )
    {
        return 0;
    }
    
    quantityremoved = 0;
    backpacksize = function_9cd65c8312048802();
    
    for ( backpackindex = 0; backpackindex < backpacksize ; backpackindex++ )
    {
        currentlootid = inventory_getlootidatbackpackindex( backpackindex );
        
        if ( currentlootid == lootid )
        {
            quantityremoved += inventory_getquantityatbackpackindex( backpackindex );
            inventory_setbackpackitematindex( backpackindex, 0, 0 );
        }
    }
    
    return quantityremoved;
}

// Namespace common_inventory
// Params 2
// Checksum 0xadedc149, Offset: 0x63c8
// Size: 0x75, Type: bool
function function_4f226d9d5d61901e( backpackindex, quantity = 1 )
{
    if ( backpackindex == -1 )
    {
        return false;
    }
    
    backpackquantity = inventory_getquantityatbackpackindex( backpackindex );
    
    if ( quantity <= 0 )
    {
        return false;
    }
    
    backpackquantity -= quantity;
    
    if ( backpackquantity <= 0 )
    {
        inventory_setbackpackitematindex( backpackindex, 0, 0 );
    }
    else
    {
        inventory_setbackpackitematindex( backpackindex, inventory_getlootidatbackpackindex( backpackindex ), backpackquantity );
    }
    
    return true;
}

// Namespace common_inventory
// Params 1
// Checksum 0xf30ec0a4, Offset: 0x6446
// Size: 0x8f
function function_563eb2695c39cc43( scriptablename )
{
    bundle = common_item::function_80af1e9daffacc7d( scriptablename );
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    bundlename = common_item::function_e044c3e813daec3a( bundle );
    itemtype = common_item::function_16e8c106491eeaca( bundle );
    
    if ( !isdefined( itemtype ) )
    {
        return;
    }
    
    currentitem = common_item::function_c4c43ebb7aa636dc( itemtype );
    
    if ( !isdefined( currentitem ) )
    {
        return;
    }
    
    if ( isdefined( currentitem ) && currentitem.name == bundlename )
    {
        common_item::function_bbba261e6fdc7e52( itemtype );
    }
}

// Namespace common_inventory
// Params 2
// Checksum 0xc8981b35, Offset: 0x64dd
// Size: 0x7f, Type: bool
function function_d1993196b2bcf62d( lootid, quantity = 1 )
{
    backpackindex = function_d57aa72eb94634f9( lootid );
    
    if ( backpackindex == -1 )
    {
        return false;
    }
    
    backpackquantity = inventory_getquantityatbackpackindex( backpackindex );
    
    if ( quantity <= 0 )
    {
        return false;
    }
    
    backpackquantity -= quantity;
    
    if ( backpackquantity <= 0 )
    {
        inventory_setbackpackitematindex( backpackindex, 0, 0 );
    }
    else
    {
        inventory_setbackpackitematindex( backpackindex, lootid, backpackquantity );
    }
    
    return true;
}

// Namespace common_inventory
// Params 2
// Checksum 0x87f4c260, Offset: 0x6565
// Size: 0x112
function function_3cd473ff8c027855( lootid, quantity = 1 )
{
    if ( quantity <= 0 )
    {
        return 0;
    }
    
    [ backpackindex, backpackquantity ] = function_1f277d13c98bf3c1( lootid );
    
    if ( backpackindex == -1 )
    {
        return 0;
    }
    
    totalremoved = 0;
    backpacksize = function_9cd65c8312048802();
    
    for ( backpackindex = 0; backpackindex < backpacksize ; backpackindex++ )
    {
        if ( quantity <= 0 )
        {
            return totalremoved;
        }
        
        [ backpackindex, backpackquantity ] = function_1f277d13c98bf3c1( lootid );
        
        if ( backpackindex == -1 )
        {
            return totalremoved;
        }
        
        removed = 0;
        newquantity = backpackquantity - quantity;
        
        if ( newquantity <= 0 )
        {
            inventory_setbackpackitematindex( backpackindex, 0, 0 );
            removed += backpackquantity;
        }
        else
        {
            inventory_setbackpackitematindex( backpackindex, lootid, newquantity );
            removed += quantity;
        }
        
        quantity -= removed;
        totalremoved += removed;
    }
    
    return totalremoved;
}

// Namespace common_inventory
// Params 2
// Checksum 0x28877da6, Offset: 0x6680
// Size: 0x9a
function function_e9fdb01d6fe5f4ee( lootid, quantity = 1 )
{
    if ( quantity <= 0 )
    {
        return 0;
    }
    
    [ backpackindex, backpackquantity ] = function_f8c32573680af2ca( lootid );
    
    if ( backpackindex == -1 )
    {
        return 0;
    }
    
    removed = min( backpackquantity, quantity );
    backpackquantity -= quantity;
    
    if ( backpackquantity <= 0 )
    {
        inventory_setbackpackitematindex( backpackindex, 0, 0 );
    }
    else
    {
        inventory_setbackpackitematindex( backpackindex, lootid, backpackquantity );
    }
    
    return removed;
}

// Namespace common_inventory
// Params 2
// Checksum 0xa8b91dd8, Offset: 0x6723
// Size: 0xd9
function function_6525f6bbec67b15e( lootids, quantity = 1 )
{
    if ( quantity <= 0 )
    {
        return 0;
    }
    
    if ( !isarray( lootids ) )
    {
        lootids = [ lootids ];
    }
    
    removed = 0;
    backpacksize = function_9cd65c8312048802();
    
    for ( backpackindex = 0; backpackindex < backpacksize ; backpackindex++ )
    {
        currentlootid = inventory_getlootidatbackpackindex( backpackindex );
        
        if ( arraycontains( lootids, currentlootid ) )
        {
            currentquantity = inventory_getquantityatbackpackindex( backpackindex );
            newquantity = currentquantity - quantity;
            
            if ( newquantity <= 0 )
            {
                inventory_setbackpackitematindex( backpackindex, 0, 0 );
                removed += currentquantity;
                continue;
            }
            
            inventory_setbackpackitematindex( backpackindex, currentlootid, newquantity );
            removed += quantity;
        }
    }
    
    return removed;
}

// Namespace common_inventory
// Params 2
// Checksum 0xac1912a1, Offset: 0x6805
// Size: 0x5a, Type: bool
function function_da96a2b63b35a3f8( lootid, quantity = 1 )
{
    if ( !lootid )
    {
        return false;
    }
    
    backpackindex = function_d57aa72eb94634f9( lootid );
    
    if ( backpackindex == -1 )
    {
        return false;
    }
    
    backpackquantity = inventory_getquantityatbackpackindex( backpackindex );
    return backpackquantity >= quantity;
}

// Namespace common_inventory
// Params 1
// Checksum 0x477e169b, Offset: 0x6868
// Size: 0x32
function function_4ae597f1950505a0( lootid )
{
    backpackindex = function_d57aa72eb94634f9( lootid );
    
    if ( backpackindex == -1 )
    {
        return 0;
    }
    
    return inventory_getquantityatbackpackindex( backpackindex );
}

// Namespace common_inventory
// Params 1
// Checksum 0x8967cfce, Offset: 0x68a3
// Size: 0x72
function function_99741e85ee9c3d18( lootid )
{
    if ( lootid == 0 )
    {
        return 0;
    }
    
    totalquantity = 0;
    backpacksize = function_9cd65c8312048802();
    
    for ( i = 0; i < backpacksize ; i++ )
    {
        currentlootid = inventory_getlootidatbackpackindex( i );
        
        if ( lootid == currentlootid )
        {
            totalquantity += inventory_getquantityatbackpackindex( i );
        }
    }
    
    return totalquantity;
}

// Namespace common_inventory
// Params 0
// Checksum 0xc2bb29c7, Offset: 0x691e
// Size: 0x41
function function_9cd65c8312048802()
{
    if ( level.gametypebundle.var_53f82dea7d1e0215 )
    {
        return function_ddf98332913ae51();
    }
    
    return isdefined( function_211a16b41e71f692() ) ? self getplayerdata( level.var_6f9b00680ed002d8, function_33fb71f2e7ba4629() ) : 0;
}

// Namespace common_inventory
// Params 3
// Checksum 0x38e4540f, Offset: 0x6968
// Size: 0xc4
function function_4e7fa885e76e773e( size = function_ddf98332913ae51(), itembundle, var_a3dcabab79ac9ece )
{
    if ( level.gametypebundle.var_53f82dea7d1e0215 )
    {
        return;
    }
    
    self setplayerdata( level.var_6f9b00680ed002d8, function_33fb71f2e7ba4629(), size );
    backpacktype = undefined;
    
    if ( common_inventory_groups::inventorygroup_enabled() )
    {
        var_ac9ac87f293120e4 = common_inventory_groups::function_69f17db49d1fd00( itembundle );
        common_inventory_groups::function_bb4396f7ff09e93f( var_ac9ac87f293120e4 );
        backpacktype = common_inventory_groups::function_93b951c93e339754( "BACKPACK", var_ac9ac87f293120e4 ) + 1;
        common_inventory_groups::function_e704cb5db69835c4( itembundle );
    }
    else
    {
        backpacktype = function_910a92e44559f6e8( itembundle );
    }
    
    self setclientomnvar( "ui_loot_backpack_type", var_a3dcabab79ac9ece ?? backpacktype );
}

// Namespace common_inventory
// Params 0
// Checksum 0xc6163d60, Offset: 0x6a34
// Size: 0xc7
function function_f8f5267dca49c43e()
{
    if ( level.gametypebundle.var_53f82dea7d1e0215 && level.var_309e3d9dac389de6 )
    {
        if ( self getplayerdata( level.var_6f9b00680ed002d8, "hasUpdatedBackpackSize" ) == 0 || self getplayerdata( level.var_6f9b00680ed002d8, function_33fb71f2e7ba4629() ) == 0 )
        {
            self setplayerdata( level.var_6f9b00680ed002d8, function_33fb71f2e7ba4629(), function_538786216800afe9() );
            self setplayerdata( level.var_6f9b00680ed002d8, "hasUpdatedBackpackSize", 1 );
        }
    }
    
    if ( isdefined( self._blackboard ) && bots_util::function_deef484b5b3a3977() )
    {
        self._blackboard.backpacksize = self getplayerdata( level.var_6f9b00680ed002d8, function_33fb71f2e7ba4629() );
    }
}

// Namespace common_inventory
// Params 0
// Checksum 0xa4e3fadf, Offset: 0x6b03
// Size: 0x2d7
function function_53c2eff14977db64()
{
    currentinventory = [];
    
    for ( i = 0; i < function_7d8024a0beed38ae() ; i++ )
    {
        currentlootid = inventory_getlootidatbackpackindex( i );
        
        if ( currentlootid > 0 )
        {
            currentquantity = inventory_getquantityatbackpackindex( i );
            inventory_setbackpackitematindex( i, 0, 0 );
            itemtype = common_item::function_9deb822f286163b1( currentlootid );
            
            if ( itemtype == "weapon" )
            {
                continue;
            }
            
            currentinventory[ i ] = { #quantity:currentquantity, #lootid:currentlootid };
        }
    }
    
    spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
    
    if ( function_d33e11a8dda3cb20() && common_inventory_groups::inventorygroup_enabled() )
    {
        weapondata = item_weapon::function_2acdc118d951356c( { #slotname:#"backpack_0" } );
        weaponbundle = common_item::function_90c3e0c1fd55d6b6( weapondata.name );
        
        if ( isdefined( weaponbundle ) )
        {
            slotindex = common_inventory_groups::function_fe1314155ed7bd19( 2 );
            item = common_item::function_77600f92048df72d( weaponbundle, weapondata.count, weapondata.weaponobj, 1, slotindex, undefined, weapondata );
            index = common_inventory_groups::function_76928b4f093ca1ad( 1, weaponbundle, undefined, item );
            
            if ( !isdefined( index ) )
            {
                spawnoptions.weapon = weapondata.weaponobj;
                common_item::function_61c2c0251e742ffd( weaponbundle, weapondata.count, spawnoptions );
                function_56f7e890f83685bd();
            }
            else
            {
                weaponlootid = common_item::function_779887309ec71dfe( weaponbundle );
                weaponitem = common_item::function_77600f92048df72d( weaponbundle, weapondata.count, weapondata.weaponobj, 1, index );
                inventory_setbackpackitematindex( index, weaponlootid, weapondata.count, weaponitem );
            }
        }
    }
    
    backpacksize = function_9cd65c8312048802();
    
    for ( i = 0; i < function_7d8024a0beed38ae() ; i++ )
    {
        if ( !currentinventory[ i ] )
        {
            continue;
        }
        
        currentlootid = currentinventory[ i ].lootid;
        currentquantity = currentinventory[ i ].quantity;
        itembundle = common_item::function_b202b16941992cca( currentlootid );
        index = i;
        
        if ( common_inventory_groups::inventorygroup_enabled() )
        {
            index = common_inventory_groups::function_76928b4f093ca1ad( 1, itembundle );
        }
        
        if ( !isdefined( index ) || index >= backpacksize )
        {
            common_item::function_61c2c0251e742ffd( itembundle, currentquantity, spawnoptions );
            continue;
        }
        
        newquantity = min( common_item::function_38334193bd9b5956( itembundle ), currentquantity );
        
        if ( newquantity < currentquantity )
        {
            common_item::function_61c2c0251e742ffd( itembundle, int( currentquantity - newquantity ), spawnoptions );
        }
        
        inventory_setbackpackitematindex( index, currentlootid, newquantity );
    }
    
    callback::callback( #"backpack_size_changed", {} );
}

// Namespace common_inventory
// Params 1
// Checksum 0x83a6eb01, Offset: 0x6de2
// Size: 0x6a
function function_715070fe0960df6( player )
{
    var_2830e43b647fd6be = 0;
    backpacksize = player function_9cd65c8312048802();
    
    if ( isdefined( backpacksize ) )
    {
        for ( i = 0; i < backpacksize ; i++ )
        {
            slotlootid = player inventory_getlootidatbackpackindex( i );
            
            if ( slotlootid )
            {
                var_2830e43b647fd6be += 1;
            }
        }
    }
    
    return var_2830e43b647fd6be;
}

// Namespace common_inventory
// Params 1
// Checksum 0xc36bd5b5, Offset: 0x6e55
// Size: 0x6c
function function_910a92e44559f6e8( itembundle )
{
    if ( !isdefined( itembundle ) )
    {
        return 0;
    }
    
    itemref = itembundle.ref;
    
    if ( !isdefined( itemref ) )
    {
        return 0;
    }
    
    switch ( itemref )
    {
        case #"hash_75ca97f27fab119c":
            return 1;
        case #"hash_5cdbaa0bf3e5ebfe":
            return 2;
        default:
            return 0;
    }
    
    return 0;
}

// Namespace common_inventory
// Params 1
// Checksum 0xa05ece65, Offset: 0x6eca
// Size: 0x31
function function_a7a3fe2f2b6b7582( lootid )
{
    backpackname = loot::getScriptableFromLootID( lootid );
    
    if ( !isdefined( backpackname ) )
    {
        backpackname = loot::function_f54ecb89dfab8e8c( lootid );
    }
    
    return backpackname;
}

// Namespace common_inventory
// Params 1
// Checksum 0x947d6564, Offset: 0x6f04
// Size: 0x36
function inventory_getlootidatbackpackindex( index )
{
    assert( isdefined( function_211a16b41e71f692() ) );
    return self getplayerdata( level.var_6f9b00680ed002d8, function_211a16b41e71f692(), index, "lootID" );
}

// Namespace common_inventory
// Params 1
// Checksum 0x804cdc25, Offset: 0x6f43
// Size: 0x36
function inventory_getquantityatbackpackindex( index )
{
    assert( isdefined( function_211a16b41e71f692() ) );
    return self getplayerdata( level.var_6f9b00680ed002d8, function_211a16b41e71f692(), index, "quantity" );
}

// Namespace common_inventory
// Params 2
// Checksum 0x68fb8ae5, Offset: 0x6f82
// Size: 0x42
function function_c620a110c81af8f6( lootid, quantity )
{
    assert( isdefined( function_211a16b41e71f692() ) );
    index = function_d57aa72eb94634f9( lootid );
    function_bae25ae0b487a249( index, quantity );
}

// Namespace common_inventory
// Params 2
// Checksum 0xe5442782, Offset: 0x6fcc
// Size: 0x97
function function_bae25ae0b487a249( index, quantity )
{
    assert( isdefined( function_211a16b41e71f692() ) );
    assert( index != -1 );
    
    if ( index != -1 )
    {
        backpackkey = function_211a16b41e71f692();
        oldquantity = int( self getplayerdata( level.var_6f9b00680ed002d8, backpackkey, index, "quantity" ) ?? 0 );
        
        if ( oldquantity != quantity )
        {
            self setplayerdata( level.var_6f9b00680ed002d8, backpackkey, index, "quantity", int( quantity ) );
        }
    }
}

// Namespace common_inventory
// Params 6
// Checksum 0x5af518f9, Offset: 0x706b
// Size: 0x23a
function inventory_setbackpackitematindex( index, lootid = 0, quantity = 0, item, olditem, typeref )
{
    assert( isdefined( function_211a16b41e71f692() ) );
    
    if ( !isint( index ) || index < 0 || index >= 256 )
    {
        assertmsg( "<dev string:x6b3>" + ( index ?? "<dev string:xd6>" ) + "<dev string:x6db>" );
        return;
    }
    
    if ( quantity < 0 || quantity >= 2048 )
    {
        assertmsg( "<dev string:x6f6>" + quantity + "<dev string:x716>" + 2048 + "<dev string:x729>" );
        return;
    }
    
    if ( !isdefined( typeref ) )
    {
        typeref = lootid ? common_item::function_9deb822f286163b1( lootid ) : undefined;
    }
    
    assert( !isdefined( typeref ) || typeref == common_item::function_9deb822f286163b1( lootid ), "<dev string:x72b>" );
    
    if ( lootid != 0 && quantity == 0 && typeref != "weapon" )
    {
        lootid = 0;
    }
    
    backpackkey = function_211a16b41e71f692();
    oldlootid = int( self getplayerdata( level.var_6f9b00680ed002d8, backpackkey, index, "lootID" ) ?? 0 );
    oldquantity = int( self getplayerdata( level.var_6f9b00680ed002d8, backpackkey, index, "quantity" ) ?? 0 );
    
    if ( oldlootid != lootid )
    {
        self setplayerdata( level.var_6f9b00680ed002d8, backpackkey, index, "lootID", lootid );
    }
    
    if ( oldquantity != quantity )
    {
        self setplayerdata( level.var_6f9b00680ed002d8, backpackkey, index, "quantity", int( quantity ) );
    }
    
    callback::callback( #"hash_89555462d4b2ee9f", { #player:self, #olditem:olditem, #item:item, #oldlootid:oldlootid, #oldquantity:oldquantity, #quantity:quantity, #typeref:typeref, #lootid:lootid, #index:index } );
}

// Namespace common_inventory
// Params 7
// Checksum 0x15e1213c, Offset: 0x72ad
// Size: 0x64
function function_728f03d326a6e4e8( player, index, lootid, quantity, loadoutlocation, loadoutslot, lootedquantity = 0 )
{
    br_instance_inventory::function_43d0b80ae3044ee5( player, index, loadoutlocation, loadoutslot );
    player inventory_setbackpackitematindex( index, lootid, quantity );
}

// Namespace common_inventory
// Params 3
// Checksum 0x248ec2f9, Offset: 0x7319
// Size: 0x35
function function_ff587618cdad1d01( player, index, loadoutslot )
{
    br_instance_inventory::function_98d8598f81420818( player, index, loadoutslot );
    player inventory_setbackpackitematindex( index, 0, 0 );
}

// Namespace common_inventory
// Params 0
// Checksum 0x1a9f94ff, Offset: 0x7356
// Size: 0x28
function function_7bf60ff8870e96b4()
{
    if ( !isdefined( function_933894456e289760() ) )
    {
        return;
    }
    
    return function_25c18fb30f61d5dd( level.var_6f9b00680ed002d8, function_933894456e289760(), "weaponLootID" );
}

// Namespace common_inventory
// Params 3
// Checksum 0x51c1428c, Offset: 0x7387
// Size: 0x2a1
function function_25c18fb30f61d5dd( statsgroup, weaponkey, lootidkey )
{
    player = self;
    
    if ( !isdefined( statsgroup ) )
    {
        statsgroup = level.var_6f9b00680ed002d8;
    }
    
    if ( !isdefined( weaponkey ) )
    {
        weaponkey = function_933894456e289760();
    }
    
    weapon = undefined;
    variantid = undefined;
    
    if ( class::function_4d362babbfd5b4b1() )
    {
        weaponlootid = player getplayerdata( statsgroup, weaponkey, lootidkey ?? "weaponLootID" );
        weapon = class::function_4573a68b3f3d5235( weaponlootid );
        
        if ( weapon == "none" )
        {
            return;
        }
        
        variantid = class::function_8840c0bc3ed152d1( weaponlootid );
    }
    else
    {
        weapon = player getplayerdata( statsgroup, weaponkey, "weapon" );
        
        if ( weapon == "none" )
        {
            return;
        }
        
        variantid = player getplayerdata( statsgroup, weaponkey, "variantID" );
    }
    
    attachments = [];
    attachmentids = [];
    maxprimaryattachments = weapon::getmaxprimaryattachments( player class::function_facf39de1a82731a() );
    
    for ( attachmentindex = 0; attachmentindex < maxprimaryattachments ; attachmentindex++ )
    {
        if ( class::function_4d362babbfd5b4b1() )
        {
            attachments[ attachmentindex ] = class::function_5acc830f47e150f0( weapon, player getplayerdata( statsgroup, weaponkey, "attachmentSetup", attachmentindex, "attachmentLootID" ) );
            attachmentids[ attachmentindex ] = player getplayerdata( statsgroup, weaponkey, "attachmentSetup", attachmentindex, "attachmentVariantID" );
            continue;
        }
        
        attachments[ attachmentindex ] = player getplayerdata( statsgroup, weaponkey, "attachmentSetup", attachmentindex, "attachment" );
        attachmentids[ attachmentindex ] = player getplayerdata( statsgroup, weaponkey, "attachmentSetup", attachmentindex, "variantID" );
    }
    
    camo = undefined;
    reticle = undefined;
    cosmeticattachment = undefined;
    stickers = [];
    
    if ( class::function_4d362babbfd5b4b1() )
    {
        camo = class::function_e6526d29276880dd( player getplayerdata( statsgroup, weaponkey, "camoLootID" ) );
        reticle = class::function_6522d758f2f446e9( player getplayerdata( statsgroup, weaponkey, "reticleLootID" ) );
        cosmeticattachment = class::function_9e833ec629866afb( player getplayerdata( statsgroup, weaponkey, "cosmeticAttachmentLootID" ) );
        stickers = [];
        
        for ( stickerindex = 0; stickerindex < 5 ; stickerindex++ )
        {
            stickers[ stickerindex ] = class::function_3b5cd530636d604a( player getplayerdata( statsgroup, weaponkey, "stickerLootIDs", stickerindex ) );
        }
    }
    else
    {
        camo = player getplayerdata( statsgroup, weaponkey, "camo" );
        reticle = player getplayerdata( statsgroup, weaponkey, "reticle" );
        cosmeticattachment = player getplayerdata( statsgroup, weaponkey, "cosmeticAttachment" );
        stickers = [];
        
        for ( stickerindex = 0; stickerindex < 5 ; stickerindex++ )
        {
            stickers[ stickerindex ] = player getplayerdata( statsgroup, weaponkey, "sticker", stickerindex );
        }
    }
    
    return weapon::buildweapon( weapon, attachments, camo, reticle, variantid, attachmentids, cosmeticattachment, stickers );
}

// Namespace common_inventory
// Params 1
// Checksum 0x5514d8fa, Offset: 0x7631
// Size: 0x2ae
function function_1923cd40e1b4efc8( weapon )
{
    assert( isdefined( function_933894456e289760() ) );
    rootname = weapon::getweaponrootname( weapon );
    variantid = weapon.variantid;
    
    if ( !isdefined( weapon.variantid ) )
    {
        variantid = 0;
    }
    
    ref = rootname;
    
    if ( variantid )
    {
        ref = rootname + "_v" + variantid;
    }
    
    lootid = common_item::items_getlootidfromref( ref );
    
    if ( !isdefined( lootid ) )
    {
        lootid = common_item::items_getlootidfromref( rootname );
    }
    
    var_cc7abc9a5c427ef2 = class::function_4d362babbfd5b4b1();
    
    if ( var_cc7abc9a5c427ef2 )
    {
        self setplayerdata( level.var_6f9b00680ed002d8, function_933894456e289760(), "weaponLootID", lootid );
    }
    else
    {
        self setplayerdata( level.var_6f9b00680ed002d8, function_933894456e289760(), "weapon", rootname );
        self setplayerdata( level.var_6f9b00680ed002d8, function_933894456e289760(), "variantID", variantid );
        self setplayerdata( level.var_6f9b00680ed002d8, function_933894456e289760(), "lootItemID", lootid );
    }
    
    self.var_a6baf10262f73fd6 = self getweaponammoclip( weapon ) + self getweaponammostock( weapon );
    
    if ( weapon.hasalternate )
    {
        weaponalt = weapon getaltweapon();
        self.var_655fababc6344d9f = self getweaponammoclip( weaponalt );
    }
    
    attachments = getweaponattachments( weapon );
    defaulttoidmap = weapon::getbaseweaponattachdefaulttoidmap( rootname );
    playerdataindex = 0;
    maxprimaryattachments = weapon::getmaxprimaryattachments( class::function_facf39de1a82731a() );
    
    for ( attachmentindex = 0; attachmentindex < attachments.size && playerdataindex < maxprimaryattachments ; attachmentindex++ )
    {
        if ( !isdefined( defaulttoidmap[ attachments[ attachmentindex ] ] ) )
        {
            if ( var_cc7abc9a5c427ef2 )
            {
                lootid = loot::getlootidfromref( attachments[ attachmentindex ] );
                
                if ( lootid )
                {
                    self setplayerdata( level.var_6f9b00680ed002d8, function_933894456e289760(), "attachmentSetup", playerdataindex, "attachmentLootID", lootid );
                    self setplayerdata( level.var_6f9b00680ed002d8, function_933894456e289760(), "attachmentSetup", playerdataindex, "attachmentVariantID", 0 );
                }
            }
            else
            {
                self setplayerdata( level.var_6f9b00680ed002d8, function_933894456e289760(), "attachmentSetup", playerdataindex, "attachment", attachments[ attachmentindex ] );
                self setplayerdata( level.var_6f9b00680ed002d8, function_933894456e289760(), "attachmentSetup", playerdataindex, "variantID", 0 );
            }
            
            playerdataindex++;
        }
    }
    
    camoLootID = weapon::function_2b94fc4d332569a5( weapon );
    
    if ( camoLootID )
    {
        self setplayerdata( level.var_6f9b00680ed002d8, function_933894456e289760(), "camoLootID", camoLootID );
    }
}

// Namespace common_inventory
// Params 0
// Checksum 0xa8c7acd1, Offset: 0x78e7
// Size: 0x60
function function_d33e11a8dda3cb20()
{
    if ( class::function_4d362babbfd5b4b1() )
    {
        return ( isdefined( function_933894456e289760() ) && self getplayerdata( level.var_6f9b00680ed002d8, function_933894456e289760(), "weaponLootID" ) != 0 );
    }
    
    return isdefined( function_933894456e289760() ) && self getplayerdata( level.var_6f9b00680ed002d8, function_933894456e289760(), "weapon" ) != "none";
}

// Namespace common_inventory
// Params 0
// Checksum 0xc5a47c7d, Offset: 0x794f
// Size: 0x5e
function function_b2c6164fc8a62023()
{
    if ( class::function_4d362babbfd5b4b1() )
    {
        return ( isdefined( function_933894456e289760() ) ? self getplayerdata( level.var_6f9b00680ed002d8, function_933894456e289760(), "weaponLootID" ) : 0 );
    }
    
    return isdefined( function_933894456e289760() ) ? self getplayerdata( level.var_6f9b00680ed002d8, function_933894456e289760(), "lootItemID" ) : 0;
}

// Namespace common_inventory
// Params 0
// Checksum 0xd18aeafd, Offset: 0x79b5
// Size: 0x277
function function_56f7e890f83685bd()
{
    if ( !isdefined( function_933894456e289760() ) )
    {
        return;
    }
    
    self setplayerdata( level.var_6f9b00680ed002d8, function_933894456e289760(), "blueprintName", "" );
    
    if ( class::function_4d362babbfd5b4b1() )
    {
        self setplayerdata( level.var_6f9b00680ed002d8, function_933894456e289760(), "weaponLootID", 0 );
        self setplayerdata( level.var_6f9b00680ed002d8, function_933894456e289760(), "camoLootID", 0 );
        self setplayerdata( level.var_6f9b00680ed002d8, function_933894456e289760(), "reticleLootID", 0 );
        self setplayerdata( level.var_6f9b00680ed002d8, function_933894456e289760(), "cosmeticAttachmentLootID", 0 );
        
        for ( attachindex = 0; attachindex < 8 ; attachindex++ )
        {
            self setplayerdata( level.var_6f9b00680ed002d8, function_933894456e289760(), "attachmentSetup", attachindex, "attachmentLootID", 0 );
            self setplayerdata( level.var_6f9b00680ed002d8, function_933894456e289760(), "attachmentSetup", attachindex, "attachmentVariantID", 0 );
        }
        
        for ( stickerindex = 0; stickerindex < 4 ; stickerindex++ )
        {
            self setplayerdata( level.var_6f9b00680ed002d8, function_933894456e289760(), "stickerLootIDs", stickerindex, 0 );
        }
        
        return;
    }
    
    self setplayerdata( level.var_6f9b00680ed002d8, function_933894456e289760(), "weapon", "none" );
    self setplayerdata( level.var_6f9b00680ed002d8, function_933894456e289760(), "lootItemID", 0 );
    self setplayerdata( level.var_6f9b00680ed002d8, function_933894456e289760(), "camo", "camo_none" );
    self setplayerdata( level.var_6f9b00680ed002d8, function_933894456e289760(), "reticle", "none" );
    self setplayerdata( level.var_6f9b00680ed002d8, function_933894456e289760(), "cosmeticAttachment", "charm_none" );
    self setplayerdata( level.var_6f9b00680ed002d8, function_933894456e289760(), "variantID", 0 );
    
    for ( attachindex = 0; attachindex < 8 ; attachindex++ )
    {
        self setplayerdata( level.var_6f9b00680ed002d8, function_933894456e289760(), "attachmentSetup", attachindex, "attachment", "none" );
        self setplayerdata( level.var_6f9b00680ed002d8, function_933894456e289760(), "attachmentSetup", attachindex, "variantID", 0 );
    }
    
    for ( stickerindex = 0; stickerindex < 4 ; stickerindex++ )
    {
        self setplayerdata( level.var_6f9b00680ed002d8, function_933894456e289760(), "sticker", stickerindex, "sticker_none" );
    }
}

// Namespace common_inventory
// Params 0
// Checksum 0x1407de9b, Offset: 0x7c34
// Size: 0x40
function function_1202b827227d4ad2()
{
    for ( i = 0; i < function_7d8024a0beed38ae() ; i++ )
    {
        inventory_setbackpackitematindex( i, 0, 0 );
    }
    
    function_56f7e890f83685bd();
    function_4e7fa885e76e773e( function_538786216800afe9() );
}

// Namespace common_inventory
// Params 0
// Checksum 0xb1e42022, Offset: 0x7c7c
// Size: 0x65
function inventory_clearloadout()
{
    primaryweaponlootid = common_item::items_getlootidfromref( "iw9_pi_golf17" );
    function_699660bc4456e3a8( 0, 0, "iw9_pi_golf17", primaryweaponlootid );
    function_699660bc4456e3a8( 0, 1 );
    function_56f7e890f83685bd();
    function_d58718e48c88c49b( 0, 0, "none" );
    function_d58718e48c88c49b( 0, 1, "none" );
    function_22afe69eb5fbb318( 0, 0, "none" );
}

// Namespace common_inventory
// Params 4
// Checksum 0x374585d6, Offset: 0x7ce9
// Size: 0x443
function function_699660bc4456e3a8( classindex, weaponindex, clearweapon, clearweaponid )
{
    if ( class::function_4d362babbfd5b4b1() )
    {
        if ( isdefined( clearweapon ) && isdefined( clearweaponid ) )
        {
            self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "weaponLootID", 0 );
        }
        else
        {
            self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "weaponLootID", 0 );
        }
        
        self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "camoLootID", 0 );
        self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "reticleLootID", 0 );
        self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "cosmeticAttachmentLootID", 0 );
        self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "blueprintName", "" );
        
        for ( attachindex = 0; attachindex < 5 ; attachindex++ )
        {
            self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "attachmentSetup", attachindex, "attachmentLootID", "none" );
            self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "attachmentSetup", attachindex, "attachmentVariantID", 0 );
        }
        
        for ( stickerindex = 0; stickerindex < 4 ; stickerindex++ )
        {
            self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "stickerLootID", stickerindex, 0 );
        }
        
        return;
    }
    
    if ( isdefined( clearweapon ) && isdefined( clearweaponid ) )
    {
        self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "weapon", clearweapon );
        self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "lootItemID", clearweaponid );
    }
    else
    {
        self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "weapon", level.defaultfist.basename );
        self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "lootItemID", 0 );
    }
    
    self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "camo", "camo_none" );
    self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "reticle", "none" );
    self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "weaponSetups", weaponindex, "cosmeticAttachment", "charm_none" );
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

// Namespace common_inventory
// Params 3
// Checksum 0x37d9e52b, Offset: 0x8134
// Size: 0x90
function function_d58718e48c88c49b( classindex, equipindex, ref )
{
    if ( class::function_4d362babbfd5b4b1() )
    {
        lootid = common_item::items_getlootidfromref( ref );
        self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "equipmentSetups", equipindex, "equipmentLootID", lootid );
        return;
    }
    
    self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "equipmentSetups", equipindex, "equipment", ref );
}

// Namespace common_inventory
// Params 3
// Checksum 0x98b22327, Offset: 0x81cc
// Size: 0x8a
function function_22afe69eb5fbb318( classindex, superindex, ref )
{
    if ( class::function_4d362babbfd5b4b1() )
    {
        lootid = common_item::items_getlootidfromref( ref );
        self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "fieldUpgradeSetups", superindex, "fieldUpgradeLootID", lootid );
        return;
    }
    
    self setplayerdata( level.loadoutdata, "squadMembers", "loadouts", classindex, "fieldUpgrades", superindex, ref );
}

// Namespace common_inventory
// Params 2
// Checksum 0xec10d713, Offset: 0x825e
// Size: 0x79
function function_8be00ecd58e89453( index, ref )
{
    if ( class::function_4d362babbfd5b4b1() )
    {
        lootid = common_item::items_getlootidfromref( ref );
        self setplayerdata( level.loadoutdata, "squadMembers", "killstreakSetups", index, "killstreakLootID", lootid );
        return;
    }
    
    self setplayerdata( level.loadoutdata, "squadMembers", "killstreakSetups", index, "killstreak", ref );
}

// Namespace common_inventory
// Params 1
// Checksum 0x2040b9e2, Offset: 0x82df
// Size: 0x22
function function_230ed6a778f68342( slotname )
{
    if ( common_instance_inventory::isenabled() )
    {
        return common_instance_inventory::function_b258e1b57fbb92f3( slotname );
    }
    
    return;
}

// Namespace common_inventory
// Params 1
// Checksum 0xcbea6710, Offset: 0x8309
// Size: 0xeb, Type: bool
function function_6c36a0b1022cf8f6( currentweapon )
{
    if ( !isweapon( currentweapon ) || isnullweapon( currentweapon ) )
    {
        return false;
    }
    
    assert( isplayer( self ), "<dev string:x798>" );
    slotnames = [ #"primary_0", #"primary_1", #"backpack_0" ];
    
    foreach ( slotname in slotnames )
    {
        var_1e462696c364cbe = function_230ed6a778f68342( slotname );
        
        if ( isdefined( var_1e462696c364cbe ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace common_inventory
// Params 2, eflags: 0x4
// Checksum 0xec75abfc, Offset: 0x83fd
// Size: 0xe6
function private function_4012c951f7b32692( var_fffe2219f1563141, resourceref )
{
    if ( !var_fffe2219f1563141 || !resourceref )
    {
        return;
    }
    
    foreach ( resource in var_fffe2219f1563141 )
    {
        if ( !resource.printtype || !resource.value )
        {
            continue;
        }
        
        var_88a968b82b82b04b = getscriptbundlefieldvalue( resource.printtype, #"hash_72cba0cf4d3a6992" );
        
        if ( var_88a968b82b82b04b != resourceref )
        {
            continue;
        }
        
        return resource.value;
    }
}

// Namespace common_inventory
// Params 1
// Checksum 0x3939bed3, Offset: 0x84ec
// Size: 0x13d
function function_98120ff3aa5f552e( resourceref )
{
    basevalue = function_4012c951f7b32692( level.gametypebundle.var_42f604f0f3eb264c, resourceref ) ?? 100;
    storagemod = 1;
    
    if ( isdefined( self.perks[ "specialty_trait_increased_resource_storage" ] ) )
    {
        storagemod = level.perkbundles[ "specialty_trait_increased_resource_storage" ].storagemod ?? 1;
    }
    
    finalvalue = basevalue * storagemod;
    
    if ( resourceref )
    {
        callbacks = common_item::function_9f00d6361edd38ce( "backpack" );
        
        if ( isdefined( callbacks.funcs[ #"getcurrent" ] ) )
        {
            backpackdata = self [[ callbacks.funcs[ #"getcurrent" ] ]]();
            
            if ( isdefined( backpackdata.name ) )
            {
                var_4e7b2114de82af2f = getscriptbundlefieldvalue( backpackdata.name, #"hash_8d50f0614fa6ced1" );
                
                if ( isdefined( var_4e7b2114de82af2f ) )
                {
                    backpackmax = function_4012c951f7b32692( var_4e7b2114de82af2f, resourceref );
                    
                    if ( backpackmax )
                    {
                        finalvalue = backpackmax * storagemod;
                    }
                }
            }
        }
    }
    
    finalvalue = modified_values::function_14d05d73e63e1f9e( 6, finalvalue );
    return finalvalue;
}

// Namespace common_inventory
// Params 0
// Checksum 0x3a13e482, Offset: 0x8632
// Size: 0xaf
function function_12e0a32239019ac2()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_6278d6b729a8b5ba ) )
    {
        return;
    }
    
    foreach ( ref, unused in level.var_6278d6b729a8b5ba )
    {
        maxvalue = function_98120ff3aa5f552e( ref );
        self setclientomnvar( "ui_resource_max_override", int( maxvalue ) );
        return;
    }
}

// Namespace common_inventory
// Params 1
// Checksum 0x971a4929, Offset: 0x86e9
// Size: 0x21b
function function_8365ce8f12ed2bfe( params )
{
    itemsstring = getdvar( @"hash_fdd46432241b26e7", "" );
    
    if ( !isdefined( itemsstring ) || itemsstring == "" )
    {
        return;
    }
    
    items = strtok( itemsstring, "," );
    
    foreach ( player in level.players )
    {
        foreach ( itembundlename in items )
        {
            var_eb17b44f95ecb1e7 = "itemspawnentry:" + itembundlename;
            itembundle = getscriptbundle( var_eb17b44f95ecb1e7 );
            
            if ( !isdefined( itembundle ) )
            {
                continue;
            }
            
            fakeitem = spawnstruct();
            fakeitem.type = itembundle.scriptable;
            fakeitem.count = common_item::function_ea3b3088d82fd357( itembundle );
            canuse = player common_item::function_5f81801cb8c86ac2( var_eb17b44f95ecb1e7, itembundle, fakeitem );
            itemtype = common_item::function_16e8c106491eeaca( itembundle );
            var_8fb8e1fb220cca48 = player common_item::function_c4c43ebb7aa636dc( itemtype, {}, 0 );
            
            if ( canuse && ( !( isdefined( var_8fb8e1fb220cca48 ) && isdefined( var_8fb8e1fb220cca48.count ) ) || var_8fb8e1fb220cca48.count <= 0 ) )
            {
                player common_item::function_96119bed8ab4c5d9( fakeitem );
                continue;
            }
            
            player inventory_additemtobackpack( itembundle, fakeitem.count, fakeitem );
        }
    }
}

// Namespace common_inventory
// Params 3, eflags: 0x4
// Checksum 0x545e72c0, Offset: 0x890c
// Size: 0x87
function private function_f66959a3d0c23978( item, itemtype, itembundle )
{
    weaponobj = item.weaponobj;
    
    if ( itemtype == "weapon" && !weaponobj )
    {
        if ( item.var_6828becb300b1c44 && !itembundle.var_d45ad5f713c5ee95 )
        {
            weaponobj = item_weapon::function_849a34281f9996f1( item.var_6828becb300b1c44 );
        }
        else
        {
            weaponobj = item_weapon::function_477bf1207c6672a5( itembundle );
        }
    }
    
    return weaponobj;
}

// Namespace common_inventory
// Params 2, eflags: 0x4
// Checksum 0xeaca5260, Offset: 0x899c
// Size: 0xc7, Type: bool
function private function_46911908632ad440( item, fromgroup )
{
    bundle = common_item::function_6b8ff3d5f2688336( item );
    itemtype = common_item::function_16e8c106491eeaca( bundle );
    callbacks = common_item::function_9f00d6361edd38ce( itemtype );
    
    if ( !callbacks.funcs || !callbacks.funcs[ #"hash_2d3b76ff260f2d68" ] )
    {
        return false;
    }
    
    if ( bundle.var_597137438370ed5e && fromgroup == 1 )
    {
        return true;
    }
    
    if ( bundle.var_1fa55557cdb6fa99 && fromgroup == 20 )
    {
        return true;
    }
    
    if ( bundle.var_1d26df64b187bbf6 && fromgroup == 2 )
    {
        return true;
    }
    
    return false;
}

/#

    // Namespace common_inventory
    // Params 1
    // Checksum 0x3c1a93ea, Offset: 0x8a6c
    // Size: 0x2c, Type: dev
    function inventory_debug( params )
    {
        inventory_devgui();
        level thread dev::devcommandwatcher( @"debug_inventory", &inventory_debugcommand );
    }

    // Namespace common_inventory
    // Params 0
    // Checksum 0x4cba8c01, Offset: 0x8aa0
    // Size: 0x304, Type: dev
    function inventory_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x7d4>" );
        devgui::add_devgui_func( "<dev string:x7eb>", "<dev string:x7fe>", &function_ef461f3b63c429ad );
        devgui::add_devgui_func( "<dev string:x822>", "<dev string:x834>", &function_fb3087c2a0c2f3a5 );
        devgui::add_devgui_func( "<dev string:x857>", "<dev string:x866>", &inventory_clearbackpack );
        var_b9af18a63e8b59d3 = getscriptbundlenames( #"itemspawnentry" );
        
        foreach ( itembundlename in var_b9af18a63e8b59d3 )
        {
            itembundle = getscriptbundlefieldvalues( itembundlename, [ #"lootitemtype" ] );
            itemtype = common_item::function_16e8c106491eeaca( itembundle );
            
            if ( itemtype != "<dev string:x886>" )
            {
                continue;
            }
            
            devgui::function_cd4e263c1f3018ae( "<dev string:x88f>" + common_item::clean_name( itembundlename ), "<dev string:x89e>" + common_item::clean_name( itembundlename ), &function_e9ecbadd852a034 );
            devgui::function_cd4e263c1f3018ae( "<dev string:x8be>" + common_item::clean_name( itembundlename ), "<dev string:x8e6>" + common_item::clean_name( itembundlename ), &function_9c9e0d384b3fd993 );
            devgui::function_cd4e263c1f3018ae( "<dev string:x8be>" + common_item::clean_name( itembundlename ), "<dev string:x8e6>" + common_item::clean_name( itembundlename ), &function_9c9e0d384b3fd993 );
            devgui::function_cd4e263c1f3018ae( "<dev string:x8be>" + common_item::clean_name( itembundlename ), "<dev string:x8e6>" + common_item::clean_name( itembundlename ), &function_9c9e0d384b3fd993 );
        }
        
        if ( common_inventory_groups::inventorygroup_enabled() && isdefined( level.inventorygroupings ) )
        {
            foreach ( groupid, list in level.inventorygroupings )
            {
                if ( groupid != "<dev string:x91f>" && groupid != "<dev string:x928>" && groupid != "<dev string:x930>" )
                {
                    continue;
                }
                
                foreach ( bundlename, data in list )
                {
                    devgui::function_cd4e263c1f3018ae( "<dev string:x936>" + groupid + "<dev string:x94c>" + common_item::clean_name( bundlename ), "<dev string:x94e>" + common_item::clean_name( bundlename ) + "<dev string:x975>" + groupid, &function_d322df72e68c9ea1 );
                }
            }
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace common_inventory
    // Params 1
    // Checksum 0x355baa72, Offset: 0x8dac
    // Size: 0x2e9, Type: dev
    function function_9c9e0d384b3fd993( params )
    {
        hostteam = level.players[ 0 ].team;
        selectedbot = undefined;
        
        foreach ( player in level.players )
        {
            if ( isbot( player ) && player.team != hostteam && utility::issharedfuncdefined( #"player", #"isreallyalive" ) && [[ utility::getsharedfunc( #"player", #"isreallyalive" ) ]]( player ) )
            {
                selectedbot = player;
                break;
            }
        }
        
        if ( !selectedbot )
        {
            setdvar( @"hash_12d23346fbacee91", 2 );
            setdvar( @"bot_disableattack", 1 );
            setdvar( @"dev_spawnbots", 5 );
            setdvar( @"bot_notarget", 1 );
        }
        
        wait 1;
        
        foreach ( player in level.players )
        {
            if ( isbot( player ) && player.team != hostteam && utility::issharedfuncdefined( #"player", #"isreallyalive" ) && [[ utility::getsharedfunc( #"player", #"isreallyalive" ) ]]( player ) )
            {
                selectedbot = player;
                break;
            }
        }
        
        if ( !selectedbot )
        {
            return;
        }
        
        function_e9ecbadd852a034( params, [ selectedbot ] );
        wait 1;
        obtainedweapons = function_ef461f3b63c429ad( [ selectedbot ] );
        function_fb3087c2a0c2f3a5( [ selectedbot ], obtainedweapons );
        fwd = anglestoforward( level.players[ 0 ].angles ) * 72 + ( 0, 0, 48 );
        lft = anglestoleft( level.players[ 0 ].angles );
        target = level.players[ 0 ].origin + fwd + lft;
        selectedbot setorigin( target );
        wait 1.5;
        selectedbot kill();
    }

    // Namespace common_inventory
    // Params 0
    // Checksum 0xc18f459, Offset: 0x909d
    // Size: 0x9e, Type: dev
    function inventory_clearbackpack()
    {
        foreach ( player in level.players )
        {
            for ( i = 0; i < function_7d8024a0beed38ae() ; i++ )
            {
                player inventory_setbackpackitematindex( i, 0, 0 );
            }
        }
    }

    // Namespace common_inventory
    // Params 1
    // Checksum 0x7cd3a05b, Offset: 0x9143
    // Size: 0x3b6, Type: dev
    function function_ef461f3b63c429ad( players )
    {
        players = players ?? level.players;
        var_b9af18a63e8b59d3 = getscriptbundlenames( #"itemspawnentry" );
        weaponbundle = undefined;
        var_b6eee7ac18ab7504 = [ "<dev string:x886>", "<dev string:x977>", "<dev string:x97e>", "<dev string:x986>", "<dev string:x98c>", "<dev string:x998>", "<dev string:x99d>", "<dev string:x9af>" ];
        obtainedweapons = [];
        
        foreach ( player in players )
        {
            foreach ( itembundlename in var_b9af18a63e8b59d3 )
            {
                if ( player function_c4eb1493b48e7f68() && weaponbundle )
                {
                    break;
                }
                
                itembundle = getscriptbundle( itembundlename );
                
                if ( !itembundle.ref )
                {
                    continue;
                }
                
                lootid = common_item::function_779887309ec71dfe( itembundle );
                
                if ( !lootid )
                {
                    continue;
                }
                
                itemtype = common_item::function_16e8c106491eeaca( itembundle );
                
                if ( arraycontains( var_b6eee7ac18ab7504, itembundle.subtype ) || arraycontains( var_b6eee7ac18ab7504, itemtype ) )
                {
                    continue;
                }
                
                if ( itemtype == "<dev string:x9b8>" && isdefined( itembundle.ref ) )
                {
                    weaponbundle = itembundle;
                    continue;
                }
                else if ( itembundle.ref != common_item::function_80af1e9daffacc7d( itembundle.scriptable ).ref )
                {
                    continue;
                }
                else if ( player function_c4eb1493b48e7f68() )
                {
                    continue;
                }
                
                fakeitem = spawnstruct();
                fakeitem.type = itembundle.scriptable;
                fakeitem.count = common_item::function_ea3b3088d82fd357( itembundle );
                player function_1a85f583119d9740( itembundlename, itembundle, fakeitem, undefined, lootid, itemtype );
            }
            
            if ( !player function_d33e11a8dda3cb20() && isdefined( weaponbundle ) )
            {
                weaponobj = item_weapon::function_477bf1207c6672a5( weaponbundle );
                item = common_item::function_77600f92048df72d( weaponbundle, 1, weaponobj );
                validslot = player common_inventory_groups::function_76928b4f093ca1ad( 1, weaponbundle, undefined, item );
                
                if ( isdefined( validslot ) )
                {
                    player function_1923cd40e1b4efc8( weaponobj );
                    obtainedweapons[ weaponbundle.baseweapon ] = 1;
                }
            }
            
            if ( level.var_369bb2cf01ce7896 )
            {
                foreach ( resourcebundle in level.var_369bb2cf01ce7896 )
                {
                    baseitem = common_item::function_77600f92048df72d( resourcebundle, 999 );
                    player common_item::function_96119bed8ab4c5d9( baseitem, undefined, 1, 1 );
                }
            }
        }
        
        return obtainedweapons;
    }

    // Namespace common_inventory
    // Params 2
    // Checksum 0x662b5ef7, Offset: 0x9501
    // Size: 0x2ea, Type: dev
    function function_fb3087c2a0c2f3a5( players, obtainedweapons )
    {
        players = players ?? level.players;
        var_b9af18a63e8b59d3 = getscriptbundlenames( #"itemspawnentry" );
        
        foreach ( player in players )
        {
            loadouttypes[ "<dev string:x9bf>" ] = 1;
            loadouttypes[ "<dev string:x9c6>" ] = 1;
            loadouttypes[ "<dev string:x9b8>" ] = 2;
            loadouttypes[ "<dev string:x9cf>" ] = 1;
            loadouttypes[ "<dev string:x9d6>" ] = 1;
            loadouttypes[ "<dev string:x9dc>" ] = 1;
            loadouttypes[ "<dev string:x9e5>" ] = 1;
            loadouttypes[ "<dev string:x9f3>" ] = 1;
            loadouttypes[ "<dev string:x9f9>" ] = 1;
            loadouttypes[ "<dev string:xa04>" ] = 1;
            loadouttypes[ "<dev string:xa0e>" ] = 1;
            
            if ( isbrgamemode() )
            {
                loadouttypes[ "<dev string:xa16>" ] = 1;
                loadouttypes[ "<dev string:xa25>" ] = 1;
                loadouttypes[ "<dev string:x998>" ] = 1;
            }
            
            player common_item::function_bbba261e6fdc7e52( "<dev string:x9b8>", { #slotname:#"primary_0" } );
            player common_item::function_bbba261e6fdc7e52( "<dev string:x9b8>", { #slotname:#"primary_1" } );
            
            if ( !isdefined( obtainedweapons ) )
            {
                obtainedweapons = [];
            }
            
            foreach ( itembundlename in var_b9af18a63e8b59d3 )
            {
                if ( loadouttypes.size == 0 )
                {
                    break;
                }
                
                itembundle = getscriptbundle( itembundlename );
                itemtype = common_item::function_16e8c106491eeaca( itembundle );
                
                if ( !isdefined( itemtype ) || !loadouttypes[ itemtype ] )
                {
                    continue;
                }
                
                if ( itemtype == "<dev string:x9b8>" && ( !itembundle.baseweapon || itembundle.baseweapon && obtainedweapons[ itembundle.baseweapon ] ) )
                {
                    continue;
                }
                
                fakeitem = spawnstruct();
                fakeitem.type = itembundle.scriptable;
                fakeitem.count = common_item::function_f8d1af7ca2a38061( itembundle );
                amountused = player common_item::function_2b5e2ff57d5f392( fakeitem );
                
                if ( amountused )
                {
                    loadouttypes[ itemtype ] -= 1;
                    
                    if ( itemtype == "<dev string:x9b8>" )
                    {
                        obtainedweapons[ itembundle.baseweapon ] = 1;
                    }
                }
            }
        }
    }

    // Namespace common_inventory
    // Params 2
    // Checksum 0xe21235d8, Offset: 0x97f3
    // Size: 0x106, Type: dev
    function function_e9ecbadd852a034( params, players )
    {
        backpackname = params[ 0 ];
        
        if ( !isdefined( backpackname ) )
        {
            return;
        }
        
        itembundle = common_item::function_90c3e0c1fd55d6b6( "<dev string:xa36>" + backpackname );
        
        if ( !isdefined( itembundle ) )
        {
            return;
        }
        
        players = players ?? level.players;
        
        foreach ( player in players )
        {
            fakeitem = spawnstruct();
            fakeitem.type = itembundle.scriptable;
            fakeitem.count = 1;
            player common_item::function_96119bed8ab4c5d9( fakeitem, 0, 1 );
        }
    }

    // Namespace common_inventory
    // Params 2
    // Checksum 0xbde9818, Offset: 0x9901
    // Size: 0x66, Type: dev
    function inventory_debugcommand( command, args )
    {
        switch ( command )
        {
            case #"hash_8b31bd936cd12086":
                level.gametypebundle.var_d93b43485e70004e = !istrue( level.gametypebundle.var_d93b43485e70004e );
            default:
                break;
        }
    }

    // Namespace common_inventory
    // Params 1
    // Checksum 0x3a0156f3, Offset: 0x996f
    // Size: 0x1ed, Type: dev
    function function_d322df72e68c9ea1( params )
    {
        if ( !isdefined( params ) || params.size < 1 )
        {
            return;
        }
        
        bundlename = params[ 0 ];
        groupid = params[ 1 ];
        bundlename = hashcat( %"hash_614921b07d869f21", bundlename );
        index = common_inventory_groups::function_93b951c93e339754( groupid, bundlename );
        omnvarstring = undefined;
        indexmod = 0;
        
        switch ( groupid )
        {
            case #"hash_e63c9f4f7f7d38eb":
                indexmod = 1;
                omnvarstring = "<dev string:xa5c>";
                break;
            case #"hash_2c4c34ed69312923":
                indexmod = 1;
                omnvarstring = "<dev string:xa72>";
                
                foreach ( loadoutbundlename, loadoutdata in level.inventorygroupings[ "<dev string:x928>" ] )
                {
                    if ( loadoutdata.index === index )
                    {
                        self.loadoutgroup = loadoutbundlename;
                    }
                }
                
                break;
            case #"hash_dc6fcc7779f2bbea":
                omnvarstring = "<dev string:xa83>";
                break;
            default:
                break;
        }
        
        if ( !isdefined( omnvarstring ) )
        {
            return;
        }
        
        foreach ( player in level.players )
        {
            player setclientomnvar( omnvarstring, index + indexmod );
        }
    }

#/
