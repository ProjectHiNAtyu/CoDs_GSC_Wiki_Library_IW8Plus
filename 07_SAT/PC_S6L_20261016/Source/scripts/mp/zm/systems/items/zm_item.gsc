// scripts\mp\zm\systems\items\zm_item.gsc  (hash_7218920abb622e97.gscc) (size: 1384 Bytes / 0x568 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4fc970af (1338601647)
// size ...... 1384 (0x568)
// includes .. 8   (offset: 0x4c4)
// strings ... 6   (offset: 0x504)
// dev strs .. 2   (offset: 0x550)
// exports ... 3   (offset: 0x324)
// cseg ...... 0xf3 + 0x231 (0x324)
// imports ... 10  (offset: 0x39c)
// animtree1 . 0   (offset: 0x568)
// animtree2 . 0   (offset: 0x568)
#using scripts\common\callbacks;
#using scripts\common\omnvar_utility;
#using scripts\common\utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\zm\systems\items\zm_item_ammo;
#using scripts\mp\zm\systems\items\zm_item_armor;
#using scripts\mp\zm\systems\items\zm_item_currency;
#using scripts\mp\zm\systems\items\zm_item_perk;

#namespace zm_item;

// Namespace zm_item
// Params 0
// Checksum 0xf70a1eba, Offset: 0x111
// Size: 0x56
function init_items()
{
    level.init_item_ammo_override = &zm_item_ammo::init_item_ammo;
    level.var_820a394c85bc5b35 = &zm_item_currency::init_item_currency;
    level.var_22064d9de4434e37 = &zm_item_armor::init_item_armor;
    level.init_item_perk_override = &zm_item_perk::init_item_perk;
    callback::add( "lootcache_looted", &function_17ec67ddca962aaf );
    level.var_5c489f2dd81149e9 = 1;
}

// Namespace zm_item
// Params 1
// Checksum 0x42027363, Offset: 0x16f
// Size: 0x1b5
function function_17ec67ddca962aaf( params )
{
    omnvarsused = 0;
    i = 0;
    
    while ( i < params.items.size )
    {
        item = params.items[ i ];
        typename = loot::function_52cf8374c44a4ff5( item.lootid );
        
        if ( typename == "weapon" && isdefined( item.weapondata ) )
        {
            if ( omnvarsused >= 4 )
            {
                assertmsg( "<dev string:x24>" + 4 + "<dev string:x2a>" );
                break;
            }
            
            params.player omnvar_utility::setcachedclientomnvar( "ui_zm_loot_container_index_" + omnvarsused, i );
            params.player omnvar_utility::setcachedclientomnvar( "ui_zm_loot_container_rarity_" + omnvarsused, item.weapondata.rarity ?? 0 );
            params.player omnvar_utility::setcachedclientomnvar( "ui_zm_loot_container_pap_" + omnvarsused, item.weapondata.paplv ?? 0 );
            params.player omnvar_utility::setcachedclientomnvar( "ui_zm_loot_container_ammomod_" + omnvarsused, utility::callsharedfunc( #"ammo_mod", #"hash_ddbe3f904027bd04", item.weapondata.ammomod ) ?? 0 );
            omnvarsused += 1;
        }
        
        i += 1;
    }
    
    i = omnvarsused;
    
    while ( i < 4 )
    {
        params.player omnvar_utility::setcachedclientomnvar( "ui_zm_loot_container_index_" + i, -1 );
        i += 1;
    }
}

