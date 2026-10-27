// script_50914162bf70e498  (hash_50914162bf70e498.gscc) (size: 2154 Bytes / 0x86a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x26f05eb1 (653287089)
// size ...... 2154 (0x86a)
// includes .. 11  (offset: 0x7ee)
// strings ... 1   (offset: 0x846)
// dev strs .. 2   (offset: 0x852)
// exports ... 4   (offset: 0x42e)
// cseg ...... 0x63 + 0x3cb (0x42e)
// imports ... 28  (offset: 0x4ce)
// animtree1 . 0   (offset: 0x86a)
// animtree2 . 0   (offset: 0x86a)
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\br\gametypes\br_default_inventory;
#using scripts\mp\br\gametypes\br_instance_inventory;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\class;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\vehicles\vehicle_occupancy_mp;

#namespace vehicle_occupancy_br;

// Namespace vehicle_occupancy_br
// Params 1
// Checksum 0x7e3ca5be, Offset: 0x81
// Size: 0x48
function vehicle_occupancy_br_init( params )
{
    utility::registersharedfunc( #"vehicle_occupancy", #"takeriotshield", &function_3582bd0ee0ca9a );
    utility::registersharedfunc( #"vehicle_occupancy", #"giveriotshield", &function_1080dd3d44909748 );
}

// Namespace vehicle_occupancy_br
// Params 3
// Checksum 0xd1f1e58f, Offset: 0xd1
// Size: 0x29e
function function_3582bd0ee0ca9a( player, vehicle, newseatid )
{
    riotshieldweapon = undefined;
    riotshieldiscurrentprimary = undefined;
    var_cd7bb6f332ee144e = undefined;
    primaryweapons = player getweaponslistprimaries();
    
    foreach ( weapon in primaryweapons )
    {
        if ( isnullweapon( weapon ) )
        {
            continue;
        }
        
        if ( weapon_utility::isriotshield( weapon ) )
        {
            assert( !isdefined( riotshieldweapon ), "<dev string:x24>" );
            riotshieldweapon = weapon;
            
            if ( issameweapon( riotshieldweapon, player getcurrentprimaryweapon() ) )
            {
                riotshieldiscurrentprimary = 1;
            }
            
            continue;
        }
        
        if ( !isdefined( var_cd7bb6f332ee144e ) && !weapon::ismeleeoverrideweapon( weapon ) && !weapon::isunderwaterweapon( weapon ) && !weapon::isclimbweapon( weapon ) )
        {
            noaltweapon = weapon getnoaltweapon();
            
            if ( noaltweapon.inventorytype != "primary" )
            {
                continue;
            }
            
            var_cd7bb6f332ee144e = weapon;
        }
    }
    
    if ( !isdefined( riotshieldweapon ) && br_default_inventory::isbackpackinventoryenabled() && br_default_inventory::function_787d2ebb0cc2e86f( player ) )
    {
        playerdataweapon = br_default_inventory::function_3b4976a12ea5037b( player );
        
        if ( isdefined( playerdataweapon ) && weapon_utility::isriotshield( playerdataweapon ) )
        {
            riotshieldweapon = playerdataweapon;
        }
    }
    
    weaponindex = 0;
    
    if ( isdefined( riotshieldweapon ) )
    {
        if ( br_default_inventory::isbackpackinventoryenabled() )
        {
            for ( i = 0; i < 3 ; i++ )
            {
                weapontocheck = br_pickups::function_5ef22d170cdde55e( player, i );
                
                if ( weapontocheck == riotshieldweapon )
                {
                    weaponindex = i;
                    
                    if ( br_instance_inventory::function_926a8f8643d34690() )
                    {
                        weaponmetadata = br_instance_inventory::function_6a05cf5689058e1f( player, i );
                        player.riotshieldmetadata = weaponmetadata;
                    }
                    
                    break;
                }
            }
        }
        
        if ( weaponindex == 2 )
        {
            br_default_inventory::function_f7c0ab39bb3170f( player );
        }
        else
        {
            player br_pickups::quickdropremoveweapon( riotshieldweapon );
        }
        
        player.riotshieldtaken = riotshieldweapon;
        player.riotshieldiscurrentprimary = riotshieldiscurrentprimary;
        
        if ( riotshieldiscurrentprimary )
        {
            vehicle_occupancy_mp::vehicle_occupancy_mp_updateriotshield( player, vehicle, newseatid );
        }
        
        assert( isdefined( var_cd7bb6f332ee144e ), "<dev string:x76>" );
        player class::riotshieldonweaponchange( var_cd7bb6f332ee144e );
        player notify( #"modified_riot_shield" );
        player endon( #"modified_riot_shield" );
        player childthread inventory_utility::forcevalidweapon( var_cd7bb6f332ee144e );
    }
}

// Namespace vehicle_occupancy_br
// Params 3
// Checksum 0x3cf9acf4, Offset: 0x377
// Size: 0xb7
function function_1080dd3d44909748( player, fromdeath, fromlaststand )
{
    if ( isdefined( player.riotshieldtaken ) )
    {
        if ( !fromdeath )
        {
            player item_weapon::function_96add18b226ff731( player.riotshieldtaken, 1 );
            player class::trackriotshield_tryreset();
            
            if ( player.riotshieldiscurrentprimary )
            {
                player notify( #"modified_riot_shield" );
                player endon( #"modified_riot_shield" );
                
                if ( !fromlaststand )
                {
                    player childthread inventory_utility::_switchtoweaponimmediate( player.riotshieldtaken );
                }
            }
        }
        
        player.riotshieldtaken = undefined;
        player.riotshieldiscurrentprimary = undefined;
        player notify( #"modified_riot_shield" );
    }
}

