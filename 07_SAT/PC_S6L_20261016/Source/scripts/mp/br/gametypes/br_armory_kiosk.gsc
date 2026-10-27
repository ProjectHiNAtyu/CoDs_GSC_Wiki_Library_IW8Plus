// scripts\mp\br\gametypes\br_armory_kiosk.gsc  (hash_34a396b44ede2542.gscc) (size: 67433 Bytes / 0x10769 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xafb9c83c (2948188220)
// size ...... 67433 (0x10769)
// includes .. 77  (offset: 0xf801)
// strings ... 174 (offset: 0xfa69)
// dev strs .. 29  (offset: 0x10609)
// exports ... 142 (offset: 0xac91)
// cseg ...... 0x1387 + 0x990a (0xac91)
// imports ... 414 (offset: 0xc2c1)
// animtree1 . 0   (offset: 0x10769)
// animtree2 . 0   (offset: 0x10769)
#using script_16ea1b94f0f381b3;
#using script_599653855a4317f1;
#using script_68bfedf2ed730bd;
#using scripts\common\ae_utility;
#using scripts\common\bots\bots_util;
#using scripts\common\damage_effects;
#using scripts\common\gasmask;
#using scripts\common\omnvar_utility;
#using scripts\common\script;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_airdrop;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_spawn;
#using scripts\mp\armor;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_default_inventory;
#using scripts\mp\br\gametypes\br_exclusion_zone;
#using scripts\mp\br\gametypes\br_extract_quest;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\br\gametypes\br_gametype_truckwar;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_instance_inventory;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\br\gametypes\br_quest_util;
#using scripts\mp\br\gametypes\br_spawnrespawn;
#using scripts\mp\br\gametypes\br_spectate;
#using scripts\mp\br\gametypes\br_strongholds;
#using scripts\mp\br\gametypes\br_weapon_upgrade;
#using scripts\mp\br\gametypes\br_weapons;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\common\killstreaks\emp;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\mapselect;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\streamhint;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\train_utility;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\currency;
#using scripts\mp\damagefeedback;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\gametypes\barter_system;
#using scripts\mp\hud_message;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\loot\common_kiosk;
#using scripts\mp\menus;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\parachute;
#using scripts\mp\poi;
#using scripts\mp\structspawnconfig;
#using scripts\mp\supers;
#using scripts\mp\teams;

#namespace br_armory_kiosk;

// Namespace br_armory_kiosk
// Params 0, eflags: 0x1
// Checksum 0x1fd74d7b, Offset: 0x13a5
// Size: 0x3e
function autoexec main()
{
    utility::registersharedfunc( #"hash_d2bd141a0077e2dc", #"init", &init );
    utility::registersharedfunc( #"hash_d2bd141a0077e2dc", #"hash_a15f6baadf2003f7", &armorykioskused );
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0x905feda6, Offset: 0x13eb
// Size: 0x29e
function init()
{
    if ( isdefined( level.br_armory_kiosk_enabled ) )
    {
        return;
    }
    
    if ( common_kiosk::function_5274212108b240d3() )
    {
        return;
    }
    
    level.br_armory_kiosk = spawnstruct();
    level.br_armory_kiosk.scriptables = [];
    level.br_armory_kiosk_enabled = getdvarint( @"scr_br_armory_kiosk", 1 ) != 0;
    level.buystationdvar = getdvar( @"br_buy_station", "purchases" );
    level.var_e24e08c324e9207 = getdvarint( @"hash_32c09327627c883c", 0 );
    level.var_165e6c1983396b21 = getdvarint( @"hash_e024cf932ef753dc", 0 );
    level.var_4c5c7ff20886e361 = getdvarint( @"scr_br_kiosk_perk_package_enabled", 0 );
    level.br_armory_kiosk.var_e253c9f921155d75 = getdvarint( @"hash_95d75e4aac93c20d", 0 );
    level.br_armory_kiosk.var_7249d71eaa3b2001 = getdvarint( @"hash_650073c7a7222ae2", 138 );
    level.currentbuystation = common_kiosk::function_9d041619b6fccf18( level.buystationref );
    
    if ( br_gametypes::isfeaturedisabled( #"kiosk" ) )
    {
        level.br_armory_kiosk_enabled = 0;
        
        if ( bots_util::function_deef484b5b3a3977() )
        {
            level.var_6a8e88d5a8429194.var_d52cfd7261c25075 = 0;
        }
        
        return;
    }
    
    if ( bots_util::function_deef484b5b3a3977() )
    {
        level.var_6a8e88d5a8429194.var_d52cfd7261c25075 = level.br_armory_kiosk_enabled;
    }
    
    if ( level.br_armory_kiosk_enabled )
    {
        function_83ef16e2ed3df2d();
        scriptable::scriptable_addusedcallback( &armorykioskused );
        scriptable::scriptable_addautousecallback( &armorykioskused );
        thread init_ssc();
        level.var_85fce9bda77a32d0 = getdvarint( @"br_kiosk_itemdrop_spawn_override", 1 );
        level.var_6f7fce2d77242e55 = getdvarfloat( @"hash_624b1f6964c696d", 180 );
        level.randomanglemax = getdvarfloat( @"hash_69c62cae4d7929c9", 10 );
        level.itemdropdistance = getdvarfloat( @"hash_9c3612143e0ad401", 1 );
        level.var_a10d8c5e946fd9c1 = getdvarint( @"hash_1b89015decb21663", 1 ) == 1;
        _initsalesdiscount();
        _parsepurchaseitemtables();
        function_d899ffec8781bcd0();
        function_658aed92b9e1a408();
        level thread _watchforcircleclosure();
        
        /#
            level thread function_93c45949deab67bb();
        #/
        
        level.var_65f58b7fd405d30b = &function_65f58b7fd405d30b;
        level.var_3317f1328e7e9df3 = &function_3317f1328e7e9df3;
        br_circle::registercirclecallbacks( 4, &dangercircletick, &dangermulticircletick, &function_41cde127b379593, &disableallarmorykiosks );
        utility::flag_set( "br_kiosk_initialized" );
    }
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0x10971660, Offset: 0x1691
// Size: 0x4d
function init_ssc()
{
    level endon( #"game_ended" );
    utility::flag_wait( "ssc_initialized" );
    structspawnconfig::function_7418a260adaec05( "buy_station", &function_139d58d75da4222 );
    structspawnconfig::function_8c0a09968efe9138( "buy_station", &function_5ef1ab9c14067db2 );
    structspawnconfig::function_36050499b5f48983( "buy_station", &function_65bac696ddb8beb5 );
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0x7c2bf75d, Offset: 0x16e6
// Size: 0x179
function _initsalesdiscount()
{
    var_172087af8ec2b28f = getdvarint( @"br_kiosk_sales_discount", 0 );
    level.br_armory_kiosk.sales_discount = int( clamp( var_172087af8ec2b28f, 0, 100 ) );
    var_d8a5a5da4d701645 = getdvar( @"br_kiosk_sales_discount_items", "" );
    level.br_armory_kiosk.sales_discount_items = strtok( var_d8a5a5da4d701645, "," );
    var_8c37e26addda8a2b = 20;
    var_b5b18fca0c65fe7e = level.br_armory_kiosk.sales_discount % var_8c37e26addda8a2b;
    
    if ( var_b5b18fca0c65fe7e > 0 )
    {
        var_3ab2061dcf438d04 = int( floor( level.br_armory_kiosk.sales_discount / var_8c37e26addda8a2b ) * var_8c37e26addda8a2b );
        var_e6e4355cb8b3a32e = var_b5b18fca0c65fe7e / var_8c37e26addda8a2b >= 0.5;
        
        if ( var_e6e4355cb8b3a32e )
        {
            var_3ab2061dcf438d04 += var_8c37e26addda8a2b;
        }
        
        level.br_armory_kiosk.sales_discount = int( var_3ab2061dcf438d04 );
    }
    
    if ( var_172087af8ec2b28f != level.br_armory_kiosk.sales_discount )
    {
        setdvar( @"br_kiosk_sales_discount", level.br_armory_kiosk.sales_discount );
        assertmsg( "<dev string:x24>" + var_172087af8ec2b28f + "<dev string:x44>" + level.br_armory_kiosk.sales_discount + "<dev string:x6f>" );
    }
}

// Namespace br_armory_kiosk
// Params 2
// Checksum 0xf1fefa2b, Offset: 0x1867
// Size: 0x5d
function _applysalesdiscount( originalprice, discount )
{
    if ( !isdefined( discount ) || discount == 0 )
    {
        return originalprice;
    }
    else if ( discount == 100 )
    {
        return 0;
    }
    
    fraction = ( 100 - discount ) * 0.01;
    return int( floor( originalprice * fraction + 0.5 ) );
}

// Namespace br_armory_kiosk
// Params 2
// Checksum 0x87e965dd, Offset: 0x18cd
// Size: 0x1dd, Type: bool
function function_b2b8b8e2eedcc21d( kiosk, var_317f3ab12fa62d40 )
{
    var_28af1a6126e00278 = function_ee19003dc90a6734( kiosk );
    
    if ( level.var_e298f874f79103ed && !isdefined( kiosk ) )
    {
        var_f77bef28b1b355df = getomnvar( "ui_br_quick_buystation" );
        
        if ( var_f77bef28b1b355df >= 0 )
        {
            var_28af1a6126e00278 = var_f77bef28b1b355df;
        }
    }
    
    if ( !isdefined( var_28af1a6126e00278 ) )
    {
        var_28af1a6126e00278 = level.currentbuystation;
    }
    
    var_a422f070ea31a5a0 = function_d032047b4d39b355( kiosk );
    
    if ( !isdefined( var_28af1a6126e00278 ) )
    {
        var_a422f070ea31a5a0 = level.currentbuystation;
    }
    
    allbuys = arraycombine( level.buystationsinuse, level.additionalbuystations );
    
    foreach ( buystationdata in allbuys )
    {
        if ( buystationdata[ "index" ] == var_28af1a6126e00278 )
        {
            var_a5c448d707ffda75 = buystationdata[ "items" ];
            
            if ( isdefined( var_a5c448d707ffda75[ var_317f3ab12fa62d40 ] ) )
            {
                return true;
            }
            
            break;
        }
    }
    
    foreach ( weapondata in level.var_b60df4c8e09fbe23 )
    {
        if ( weapondata[ "index" ] == var_a422f070ea31a5a0 )
        {
            weaponitemdata = weapondata[ "items" ];
            
            if ( isdefined( weaponitemdata[ var_317f3ab12fa62d40 ] ) )
            {
                return true;
            }
            
            break;
        }
    }
    
    return false;
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0xdb4d8e6c, Offset: 0x1ab3
// Size: 0x16d, Type: bool
function function_d2fc541046c37ab4( kiosk )
{
    if ( getdvarint( @"hash_8bd31284e87b0865", 1 ) == 0 )
    {
        return false;
    }
    
    if ( !( isdefined( kiosk ) && isdefined( kiosk.index ) ) )
    {
        return false;
    }
    
    /#
        if ( getdvarint( @"hash_5f15a3e117466c52", 0 ) == 1 )
        {
            kiosk.overrideindex = undefined;
            kiosk.var_15a1ac5dcc500532 = undefined;
        }
    #/
    
    var_3d4f914b2d061fef = getsystemtime();
    
    if ( !isdefined( kiosk.overrideindex ) && isdefined( level.buystationsinuse ) && level.buystationsinuse.size > 0 )
    {
        var_28af1a6126e00278 = ( kiosk.index + var_3d4f914b2d061fef ) % level.buystationsinuse.size;
        var_936de46d0ea2c1fc = level.buystationsinuse[ var_28af1a6126e00278 ];
        kiosk.overrideindex = var_936de46d0ea2c1fc[ "index" ];
    }
    
    if ( !isdefined( kiosk.var_15a1ac5dcc500532 ) && isdefined( level.var_b60df4c8e09fbe23 ) && level.var_b60df4c8e09fbe23.size > 0 )
    {
        var_d643c0be2e002913 = ( kiosk.index + var_3d4f914b2d061fef ) % level.var_b60df4c8e09fbe23.size;
        var_ee855171605e51cd = level.var_b60df4c8e09fbe23[ var_d643c0be2e002913 ];
        kiosk.var_15a1ac5dcc500532 = var_ee855171605e51cd[ "index" ];
    }
    
    return true;
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0x6b9fd39b, Offset: 0x1c29
// Size: 0xed
function function_ee19003dc90a6734( kiosk )
{
    if ( !function_d2fc541046c37ab4( kiosk ) )
    {
        return;
    }
    
    found = 0;
    buystations = arraycombine( level.buystationsinuse, level.additionalbuystations );
    
    foreach ( buystationdata in buystations )
    {
        if ( buystationdata[ "index" ] == kiosk.overrideindex )
        {
            found = 1;
            break;
        }
    }
    
    if ( !found )
    {
        function_b1b75e4a51094d62( kiosk.overrideindex );
    }
    
    return kiosk.overrideindex;
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0x86cb5635, Offset: 0x1d1f
// Size: 0x24
function function_d032047b4d39b355( kiosk )
{
    if ( !function_d2fc541046c37ab4( kiosk ) )
    {
        return;
    }
    
    return kiosk.var_15a1ac5dcc500532;
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0xccb50003, Offset: 0x1d4c
// Size: 0x3bb, Type: bool
function function_4563779f87eaade6( kiosk )
{
    if ( getdvarint( @"hash_b0634929cd39973b", 1 ) == 0 )
    {
        return false;
    }
    
    if ( !( isdefined( kiosk ) && isdefined( kiosk.index ) ) )
    {
        return false;
    }
    
    if ( !isdefined( level.buystationsinuse ) )
    {
        return false;
    }
    
    var_ff9868b785ff9ce3 = function_ee19003dc90a6734( kiosk );
    
    if ( !isdefined( var_ff9868b785ff9ce3 ) )
    {
        return false;
    }
    
    if ( !isdefined( level.buystationstock ) )
    {
        level.buystationstock = [];
    }
    
    if ( isdefined( level.buystationstock[ kiosk.index ] ) && level.buystationstock[ kiosk.index ].defindex == var_ff9868b785ff9ce3 )
    {
        return true;
    }
    
    buystations = arraycombine( level.buystationsinuse, level.additionalbuystations );
    
    foreach ( buystationdata in buystations )
    {
        if ( buystationdata[ "index" ] == var_ff9868b785ff9ce3 )
        {
            buystationstock = spawnstruct();
            buystationstock.defindex = var_ff9868b785ff9ce3;
            buystationstock.stock = [];
            
            foreach ( var_5016f46d98f3477c, var_e485a4d261fe5c1a in buystationdata[ "items" ] )
            {
                buystationstock.stock[ var_5016f46d98f3477c ] = var_e485a4d261fe5c1a[ "defaultStock" ];
                
                if ( isdefined( level.gulag ) && level.gulag.shutdown && var_5016f46d98f3477c == "brloot_gulag_token" )
                {
                    buystationstock.stock[ var_5016f46d98f3477c ] = 0;
                }
            }
            
            level.buystationstock[ kiosk.index ] = buystationstock;
            return true;
        }
    }
    
    foreach ( buystationdata in level.additionalbuystations )
    {
        if ( buystationdata[ "index" ] == var_ff9868b785ff9ce3 )
        {
            buystationstock = spawnstruct();
            buystationstock.defindex = var_ff9868b785ff9ce3;
            buystationstock.stock = [];
            
            foreach ( var_5016f46d98f3477c, var_e485a4d261fe5c1a in buystationdata[ "items" ] )
            {
                buystationstock.stock[ var_5016f46d98f3477c ] = var_e485a4d261fe5c1a[ "defaultStock" ];
                
                if ( isdefined( level.gulag ) && level.gulag.shutdown && var_5016f46d98f3477c == "brloot_gulag_token" )
                {
                    buystationstock.stock[ var_5016f46d98f3477c ] = 0;
                }
            }
            
            level.buystationstock[ kiosk.index ] = buystationstock;
            return true;
        }
    }
    
    return false;
}

// Namespace br_armory_kiosk
// Params 2
// Checksum 0xd7f07133, Offset: 0x2110
// Size: 0x27e
function function_a014fb6ec469e815( kiosk, var_317f3ab12fa62d40 )
{
    player = self;
    assert( isplayer( player ) );
    
    if ( !function_4563779f87eaade6( kiosk ) )
    {
        return;
    }
    
    if ( pickups::isweaponpickup( var_317f3ab12fa62d40 ) )
    {
        return;
    }
    
    var_a5c448d707ffda75 = undefined;
    var_6366af1ea39abf2d = level.buystationstock[ kiosk.index ].defindex;
    buystations = arraycombine( level.buystationsinuse, level.additionalbuystations );
    
    foreach ( buystationdata in buystations )
    {
        if ( buystationdata[ "index" ] == var_6366af1ea39abf2d )
        {
            var_a5c448d707ffda75 = buystationdata[ "items" ];
            break;
        }
    }
    
    if ( isdefined( level.additionalbuystations ) )
    {
        foreach ( buystationdata in level.additionalbuystations )
        {
            if ( buystationdata[ "index" ] == var_6366af1ea39abf2d )
            {
                var_a5c448d707ffda75 = buystationdata[ "items" ];
                break;
            }
        }
    }
    
    assert( isdefined( var_a5c448d707ffda75 ) );
    isfiresale = iskioskfiresaleactiveforplayer( kiosk, player );
    itemstock = level.buystationstock[ kiosk.index ].stock[ var_317f3ab12fa62d40 ];
    
    if ( isdefined( itemstock ) )
    {
        if ( kiosk.var_435658721cd2f3f5 )
        {
            newstock = br_gametype_truckwar::function_f1b88a2d31bc96b0( var_317f3ab12fa62d40, itemstock );
            itemstock = newstock ?? itemstock;
        }
        
        ishidden = !isfiresale && var_a5c448d707ffda75[ var_317f3ab12fa62d40 ][ "hidden" ];
        
        if ( ishidden )
        {
            return 0;
        }
        else
        {
            return itemstock;
        }
        
        return;
    }
    
    unlimiteditem = var_a5c448d707ffda75[ var_317f3ab12fa62d40 ];
    
    if ( isdefined( unlimiteditem ) )
    {
        assert( !isdefined( var_a5c448d707ffda75[ var_317f3ab12fa62d40 ][ "<dev string:x72>" ] ) );
        return 1;
    }
    
    return 0;
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0xbdc7012c, Offset: 0x2396
// Size: 0x2b0
function function_b37e534a00251768( kiosk )
{
    player = self;
    assert( isplayer( player ) );
    
    if ( !function_4563779f87eaade6( kiosk ) )
    {
        return;
    }
    
    var_a5c448d707ffda75 = undefined;
    var_6366af1ea39abf2d = level.buystationstock[ kiosk.index ].defindex;
    buystations = arraycombine( level.buystationsinuse, level.additionalbuystations );
    
    foreach ( buystationdata in buystations )
    {
        if ( buystationdata[ "index" ] == var_6366af1ea39abf2d )
        {
            var_a5c448d707ffda75 = buystationdata[ "items" ];
            break;
        }
    }
    
    if ( isdefined( level.additionalbuystations ) )
    {
        foreach ( buystationdata in level.additionalbuystations )
        {
            if ( buystationdata[ "index" ] == var_6366af1ea39abf2d )
            {
                var_a5c448d707ffda75 = buystationdata[ "items" ];
                break;
            }
        }
    }
    
    assert( isdefined( var_a5c448d707ffda75 ) );
    isfiresale = iskioskfiresaleactiveforplayer( kiosk, player );
    itemstocks = [];
    var_eb3c060658ee0b1f = 0;
    
    foreach ( itemkey, itemstock in level.buystationstock[ kiosk.index ].stock )
    {
        if ( isdefined( itemstock ) )
        {
            if ( kiosk.var_435658721cd2f3f5 )
            {
                newstock = br_gametype_truckwar::function_f1b88a2d31bc96b0( itemkey, itemstock );
                itemstock = newstock ?? itemstock;
            }
            
            ishidden = !isfiresale && var_a5c448d707ffda75[ itemkey ][ "hidden" ];
            
            if ( ishidden )
            {
                itemstocks[ var_eb3c060658ee0b1f ] = 0;
            }
            else
            {
                itemstocks[ var_eb3c060658ee0b1f ] = itemstock;
            }
        }
        
        var_eb3c060658ee0b1f++;
    }
    
    return itemstocks;
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0x8954ee22, Offset: 0x264f
// Size: 0x53
function function_555d4c70d4b7eba9( kiosk )
{
    player = self;
    assert( isplayer( player ) );
    
    if ( !function_4563779f87eaade6( kiosk ) )
    {
        return;
    }
    
    return level.buystationstock[ kiosk.index ].stock;
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0xf2ec1af9, Offset: 0x26ab
// Size: 0x40
function getbuystations()
{
    if ( isdefined( level.common_armory_kiosk.instances ) )
    {
        return level.common_armory_kiosk.instances;
    }
    
    return level.br_armory_kiosk.scriptables;
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0x171c0b75, Offset: 0x26f4
// Size: 0xe3
function function_1c9b60b9dfaef240( kiosk )
{
    if ( !function_4563779f87eaade6( kiosk ) )
    {
        return;
    }
    
    itemspacked = 0;
    var_7f58eb0d2ef8b238 = 0;
    var_c7db5572b24fae99 = function_b37e534a00251768( kiosk );
    
    foreach ( var_fa48d0db5f59b870 in var_c7db5572b24fae99 )
    {
        if ( isdefined( var_fa48d0db5f59b870 ) )
        {
            assert( 0 <= var_fa48d0db5f59b870 && var_fa48d0db5f59b870 <= 3 );
            assert( itemspacked < 16 );
            var_7f58eb0d2ef8b238 |= var_fa48d0db5f59b870 << 2 * itemspacked;
            itemspacked++;
        }
    }
    
    return var_7f58eb0d2ef8b238;
}

// Namespace br_armory_kiosk
// Params 2
// Checksum 0xa292d883, Offset: 0x27e0
// Size: 0x89
function function_b402b2318d41f582( kiosk, var_317f3ab12fa62d40 )
{
    if ( !function_4563779f87eaade6( kiosk ) )
    {
        return;
    }
    
    itemstock = level.buystationstock[ kiosk.index ].stock[ var_317f3ab12fa62d40 ];
    
    if ( isdefined( itemstock ) )
    {
        level.buystationstock[ kiosk.index ].stock[ var_317f3ab12fa62d40 ] = itemstock > 0 ? itemstock - 1 : 0;
    }
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0x3d9b4bb1, Offset: 0x2871
// Size: 0x4a
function function_5b2ae8c4a1092d1e( lootid )
{
    if ( !isdefined( lootid ) )
    {
        return 0;
    }
    
    scriptableref = loot::getScriptableFromLootID( lootid );
    
    if ( !isdefined( scriptableref ) )
    {
        return 0;
    }
    
    return issubstr( getdvar( @"hash_275014452ae83a52", "" ), scriptableref );
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0x875cede8, Offset: 0x28c4
// Size: 0xc1
function function_28d1b4eaf74a3d67( var_317f3ab12fa62d40 )
{
    assert( isdefined( level.br_armory_kiosk.items ) );
    
    foreach ( itemdata in level.br_armory_kiosk.items )
    {
        if ( var_317f3ab12fa62d40 == itemdata.entryref )
        {
            return itemdata.filtered;
        }
    }
    
    return 1;
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0xdad21dea, Offset: 0x298e
// Size: 0x186
function function_d33203706510e23c( kiosk )
{
    var_28af1a6126e00278 = function_ee19003dc90a6734( kiosk );
    
    if ( level.var_e298f874f79103ed && !isdefined( kiosk ) )
    {
        var_f77bef28b1b355df = getomnvar( "ui_br_quick_buystation" );
        
        if ( var_f77bef28b1b355df >= 0 )
        {
            var_28af1a6126e00278 = var_f77bef28b1b355df;
        }
    }
    
    if ( !isdefined( var_28af1a6126e00278 ) )
    {
        var_28af1a6126e00278 = level.currentbuystation;
    }
    
    buystations = arraycombine( level.buystationsinuse, level.additionalbuystations );
    
    foreach ( buystationdata in buystations )
    {
        if ( buystationdata[ "index" ] == var_28af1a6126e00278 )
        {
            return buystationdata[ "itemFilter" ];
        }
    }
    
    if ( isdefined( level.additionalbuystations ) )
    {
        foreach ( buystationdata in level.additionalbuystations )
        {
            if ( buystationdata[ "index" ] == var_28af1a6126e00278 )
            {
                return buystationdata[ "itemFilter" ];
            }
        }
    }
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0x3f58d42, Offset: 0x2b1c
// Size: 0x28d
function function_ee6c8f3da29a67b9( buystationref )
{
    buystationdata = [];
    buystationindex = common_kiosk::function_9d041619b6fccf18( buystationref );
    buystationdata[ "index" ] = buystationindex;
    buystationdata[ "ref" ] = buystationref;
    buystationdata[ "items" ] = [];
    buystationdata[ "itemFilter" ] = 0;
    buystationrow = tablelookuprownum( "mp/buyStation/buyStationDefs.csv", 0, buystationindex );
    stationitem = tablelookupbyrow( "mp/buyStation/buyStationDefs.csv", buystationrow, 3 );
    itemindex = 0;
    var_e5f76cb5fd916b71 = 4 * itemindex;
    
    while ( stationitem != "" )
    {
        itemfiltered = function_28d1b4eaf74a3d67( stationitem );
        
        if ( !itemfiltered )
        {
            assert( !isdefined( buystationdata[ "<dev string:x7f>" ][ stationitem ] ), "<dev string:x85>" + buystationref + "<dev string:xab>" + stationitem );
            itemcost = tablelookupbyrow( "mp/buyStation/buyStationDefs.csv", buystationrow, 4 + var_e5f76cb5fd916b71 );
            var_351ba14a1fb53384 = tablelookupbyrow( "mp/buyStation/buyStationDefs.csv", buystationrow, 5 + var_e5f76cb5fd916b71 );
            itemhidden = tablelookupbyrow( "mp/buyStation/buyStationDefs.csv", buystationrow, 6 + var_e5f76cb5fd916b71 );
            buystationdata[ "items" ][ stationitem ] = [];
            
            if ( itemcost != "" )
            {
                buystationdata[ "items" ][ stationitem ][ "cost" ] = int( itemcost );
            }
            else
            {
                buystationdata[ "items" ][ stationitem ][ "cost" ] = -1;
            }
            
            if ( var_351ba14a1fb53384 != "" )
            {
                var_351ba14a1fb53384 = int( var_351ba14a1fb53384 );
                
                if ( 0 <= var_351ba14a1fb53384 && var_351ba14a1fb53384 <= 3 )
                {
                    buystationdata[ "items" ][ stationitem ][ "defaultStock" ] = var_351ba14a1fb53384;
                }
                else
                {
                    buystationdata[ "items" ][ stationitem ][ "defaultStock" ] = randomintrange( 0, 3 );
                }
            }
            else
            {
                buystationdata[ "items" ][ stationitem ][ "defaultStock" ] = undefined;
            }
            
            if ( itemhidden != "" )
            {
                buystationdata[ "items" ][ stationitem ][ "hidden" ] = int( itemhidden );
            }
            else
            {
                buystationdata[ "items" ][ stationitem ][ "hidden" ] = 0;
            }
        }
        
        if ( itemindex < 15 )
        {
            if ( itemfiltered )
            {
                var_a7bd90aba0820b7a = 1 << itemindex;
                buystationdata[ "itemFilter" ] = buystationdata[ "itemFilter" ] | var_a7bd90aba0820b7a;
            }
        }
        else
        {
            println( "<dev string:xb1>" + itemindex + 1 + "<dev string:xdb>" + 15 + "<dev string:xe2>" + stationitem + "<dev string:xe9>" + buystationref );
        }
        
        itemindex++;
        var_e5f76cb5fd916b71 = 4 * itemindex;
        stationitem = tablelookupbyrow( "mp/buyStation/buyStationDefs.csv", buystationrow, 3 + var_e5f76cb5fd916b71 );
    }
    
    return buystationdata;
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0xd04ef52f, Offset: 0x2db2
// Size: 0x14
function function_cccef74b06260ac2( itemref )
{
    return common_kiosk::function_57fdad70d0f27d87( itemref );
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0x6ebbc4ea, Offset: 0x2dcf
// Size: 0x10
function function_d6a575a95d5f637b()
{
    return getdvarint( @"br_kiosk_quick_purchase_enabled", 0 );
}

// Namespace br_armory_kiosk
// Params 1, eflags: 0x4
// Checksum 0xaf757e53, Offset: 0x2de8
// Size: 0x2f
function private function_53fa93500642754a( var_ffb8c91b80356818 )
{
    num = common_kiosk::function_9d041619b6fccf18( var_ffb8c91b80356818 );
    
    if ( !isdefined( num ) )
    {
        num = int( var_ffb8c91b80356818 );
    }
    
    return num;
}

// Namespace br_armory_kiosk
// Params 2, eflags: 0x4
// Checksum 0x4c481e82, Offset: 0x2e20
// Size: 0x146
function private function_2b8e7e5eb3b99521( var_3d71e60acb29c1fd, backupref )
{
    buystationarray = [];
    
    if ( var_3d71e60acb29c1fd )
    {
        buystationrefs = [];
        var_f463d5d4198f63d0 = utility::array_map( strtok( var_3d71e60acb29c1fd, "," ), &function_53fa93500642754a );
        
        if ( var_f463d5d4198f63d0.size == 2 && ( int( var_f463d5d4198f63d0[ 0 ] ) || int( var_f463d5d4198f63d0[ 1 ] ) ) )
        {
            var_58d6a2d84c211045 = int( var_f463d5d4198f63d0[ 0 ] );
            var_e7d690c81a54f526 = int( var_f463d5d4198f63d0[ 1 ] );
            
            for ( var_734c12796d307a70 = var_58d6a2d84c211045; var_734c12796d307a70 <= var_e7d690c81a54f526 ; var_734c12796d307a70++ )
            {
                buystationrow = tablelookuprownum( "mp/buyStation/buyStationDefs.csv", 0, var_734c12796d307a70 );
                
                if ( buystationrow != -1 )
                {
                    buystationref = tablelookupbyrow( "mp/buyStation/buyStationDefs.csv", buystationrow, 1 );
                    
                    if ( buystationref != "" )
                    {
                        buystationrefs[ buystationrefs.size ] = buystationref;
                    }
                }
            }
        }
        else
        {
            buystationrefs = var_f463d5d4198f63d0;
        }
        
        buystationrefs = arrayrandomize( buystationrefs );
        
        for ( buystationindex = 0; buystationindex < buystationrefs.size ; buystationindex++ )
        {
            buystationarray[ buystationarray.size ] = function_ee6c8f3da29a67b9( buystationrefs[ buystationindex ] );
        }
    }
    else if ( isdefined( backupref ) )
    {
        buystationarray[ buystationarray.size ] = function_ee6c8f3da29a67b9( backupref );
    }
    
    return buystationarray;
}

// Namespace br_armory_kiosk
// Params 1, eflags: 0x4
// Checksum 0xeb756c1, Offset: 0x2f6f
// Size: 0x103, Type: bool
function private function_b1b75e4a51094d62( index )
{
    if ( !isdefined( level.additionalbuystations ) )
    {
        level.additionalbuystations = [];
    }
    
    foreach ( buystationdata in level.additionalbuystations )
    {
        if ( buystationdata[ "index" ] == index )
        {
            return true;
        }
    }
    
    buystationrow = tablelookuprownum( "mp/buyStation/buyStationDefs.csv", 0, index );
    
    if ( buystationrow != -1 )
    {
        buystationref = tablelookupbyrow( "mp/buyStation/buyStationDefs.csv", buystationrow, 1 );
        
        if ( buystationref != "" )
        {
            level.additionalbuystations[ level.additionalbuystations.size ] = function_ee6c8f3da29a67b9( buystationref );
            return true;
        }
    }
    
    return false;
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0x43606b4, Offset: 0x307b
// Size: 0x1a
function function_d899ffec8781bcd0()
{
    level.br_armory_kiosk.weapons = spawnstruct();
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0x34698c93, Offset: 0x309d
// Size: 0x247
function _parsepurchaseitemtables()
{
    level.br_armory_kiosk.items = [];
    var_c7c837eabcfb9195 = getdvarint( @"hash_ee52115cbca6f7cc", 1 );
    numrows = tablelookupgetnumrows( "mp/buyStation/buyStationItems.csv" );
    
    for ( row = 0; row < numrows ; row++ )
    {
        itemindex = int( tablelookupbyrow( "mp/buyStation/buyStationItems.csv", row, 0 ) );
        assert( !isdefined( level.br_armory_kiosk.items[ itemindex ] ) );
        var_f67d8aee161ecf = spawnstruct();
        var_f67d8aee161ecf.entryref = tablelookupbyrow( "mp/buyStation/buyStationItems.csv", row, 1 );
        var_f67d8aee161ecf.type = tablelookupbyrow( "mp/buyStation/buyStationItems.csv", row, 2 );
        var_f67d8aee161ecf.ref = tablelookupbyrow( "mp/buyStation/buyStationItems.csv", row, 3 );
        var_f67d8aee161ecf.cost = int( tablelookupbyrow( "mp/buyStation/buyStationItems.csv", row, 4 ) );
        var_f67d8aee161ecf.unlocksublocation = tablelookupbyrow( "mp/buyStation/buyStationItems.csv", row, 13 );
        
        if ( var_f67d8aee161ecf.unlocksublocation != "" )
        {
            var_f67d8aee161ecf.unlocksublocation = int( var_f67d8aee161ecf.unlocksublocation );
        }
        else
        {
            var_f67d8aee161ecf.unlocksublocation = undefined;
        }
        
        var_5f748c9b0bb6e11e = getdvarint( @"hash_950c868de7e98dbf", 0 );
        
        if ( var_5f748c9b0bb6e11e != 0 )
        {
            var_f67d8aee161ecf.firesalediscount = var_5f748c9b0bb6e11e;
        }
        else
        {
            var_f67d8aee161ecf.firesalediscount = int( tablelookupbyrow( "mp/buyStation/buyStationItems.csv", row, 10 ) );
        }
        
        var_f67d8aee161ecf.lootid = int( tablelookupbyrow( "mp/buyStation/buyStationItems.csv", row, 11 ) );
        
        if ( utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) && var_f67d8aee161ecf.lootid < 1 )
        {
            var_c7c837eabcfb9195 = 0;
        }
        
        if ( var_c7c837eabcfb9195 )
        {
            var_f67d8aee161ecf.filtered = function_5b2ae8c4a1092d1e( var_f67d8aee161ecf.lootid );
        }
        else
        {
            var_f67d8aee161ecf.filtered = 0;
        }
        
        level.br_armory_kiosk.items[ itemindex ] = var_f67d8aee161ecf;
    }
}

// Namespace br_armory_kiosk
// Params 2
// Checksum 0x90423129, Offset: 0x32ec
// Size: 0xae
function function_bcf4f6771edcb548( entryref, cost )
{
    foreach ( var_f67d8aee161ecf in level.br_armory_kiosk.items )
    {
        if ( var_f67d8aee161ecf.entryref == entryref )
        {
            var_f67d8aee161ecf.cost = cost;
        }
    }
}

// Namespace br_armory_kiosk
// Params 2
// Checksum 0xc92b8985, Offset: 0x33a2
// Size: 0xcf
function function_759b296c1e3322a5( var_317f3ab12fa62d40, stock )
{
    if ( !isdefined( level.buystationstock ) )
    {
        return;
    }
    
    foreach ( index, kiosk in level.buystationstock )
    {
        assert( isdefined( level.buystationstock[ index ].stock[ var_317f3ab12fa62d40 ] ) );
        level.buystationstock[ index ].stock[ var_317f3ab12fa62d40 ] = stock;
    }
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0xd344d0ff, Offset: 0x3479
// Size: 0x93
function function_658aed92b9e1a408()
{
    if ( !isdefined( level.buystationsinuse ) )
    {
        var_2dafc86aeb2199fd = getmatchrulesdata( "commonOption", "buyStationPool" );
        buystationpool = utility::function_49a778e73bbb0f58( @"scr_buy_station_pool", "", var_2dafc86aeb2199fd );
        level.buystationsinuse = function_2b8e7e5eb3b99521( buystationpool, level.buystationref );
        common_kiosk::function_e86f80f00a71942();
    }
    
    if ( !isdefined( level.var_b60df4c8e09fbe23 ) )
    {
        level.var_b60df4c8e09fbe23 = function_2b8e7e5eb3b99521( getdvar( @"hash_f4138ad8e0de3ac6" ) );
    }
}

// Namespace br_armory_kiosk
// Params 2, eflags: 0x4
// Checksum 0xbaaaa968, Offset: 0x3514
// Size: 0xe0
function private function_ec847a0d85421346( itemref, buystationarray )
{
    foreach ( buystationdata in buystationarray )
    {
        if ( buystationdata[ "index" ] == level.currentbuystation || buystationdata[ "index" ] == level.var_b5b5eaf26cba1e93 )
        {
            if ( isdefined( buystationdata[ "items" ][ itemref ] ) && buystationdata[ "items" ][ itemref ][ "cost" ] > 0 )
            {
                return buystationdata[ "items" ][ itemref ][ "cost" ];
            }
            
            return;
        }
    }
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0x29061453, Offset: 0x35fc
// Size: 0x14
function function_342762b8dcca0afd( itemref )
{
    return function_52f28106b1df1c8( itemref );
}

// Namespace br_armory_kiosk
// Params 1, eflags: 0x4
// Checksum 0xf8174e36, Offset: 0x3619
// Size: 0x6b
function private function_52f28106b1df1c8( itemref )
{
    buystations = arraycombine( level.buystationsinuse, level.additionalbuystations );
    cost = function_ec847a0d85421346( itemref, buystations );
    
    if ( !isdefined( cost ) && isdefined( level.var_b60df4c8e09fbe23 ) )
    {
        cost = function_ec847a0d85421346( itemref, level.var_b60df4c8e09fbe23 );
    }
    
    return cost;
}

// Namespace br_armory_kiosk
// Params 2
// Checksum 0x2754c82e, Offset: 0x368d
// Size: 0x8c
function function_56342e768e9bc70c( weaponref, attachmentrefs )
{
    assert( isdefined( level.br_armory_kiosk.weapons ) );
    
    if ( isdefined( level.br_armory_kiosk.weapons.weaponprices ) )
    {
        weaponcost = level.br_armory_kiosk.weapons.weaponprices[ weaponref ];
    }
    
    if ( !isdefined( weaponcost ) )
    {
        weaponcost = 0;
    }
    
    return int( weaponcost );
}

// Namespace br_armory_kiosk
// Params 2
// Checksum 0x10b9e4be, Offset: 0x3722
// Size: 0x31a
function _getactualcost( player, itemdata )
{
    isfiresale = iskioskfiresaleactiveforplayer( player.br_kiosk, player );
    println( "<dev string:x10f>" + isfiresale );
    finalcost = itemdata.cost;
    
    if ( player.var_403f571c4b488e5f > 0 )
    {
        return 0;
    }
    
    var_193f0696ae04f08 = function_52f28106b1df1c8( itemdata.entryref );
    
    if ( isdefined( var_193f0696ae04f08 ) )
    {
        finalcost = var_193f0696ae04f08;
    }
    
    var_636e8da23b225857 = level.var_e298f874f79103ed && !isdefined( player.br_kiosk );
    
    if ( var_636e8da23b225857 )
    {
        buystationidx = getomnvar( "ui_br_quick_buystation" );
        buystationrow = tablelookuprownum( "mp/buyStation/buyStationDefs.csv", 0, buystationidx );
        
        if ( buystationrow != -1 )
        {
            buystationref = tablelookupbyrow( "mp/buyStation/buyStationDefs.csv", buystationrow, 1 );
            
            if ( buystationref != "" )
            {
                buystationdata = function_ee6c8f3da29a67b9( buystationref );
                finalcost = buystationdata[ "items" ][ itemdata.entryref ][ "cost" ];
            }
        }
    }
    
    var_fca64d021f97047c = getdvar( hashcat( @"scr_", itemdata.ref, "_cost_override" ), "" );
    
    if ( var_fca64d021f97047c != "" )
    {
        var_38bf6aab791decfd = strtok( var_fca64d021f97047c, "," );
        var_cbcd7339cd8a89e7 = teams::getteamcount( player.team ) - 1;
        
        if ( var_38bf6aab791decfd.size > 0 )
        {
            var_51765ce4c248f9f8 = var_38bf6aab791decfd.size <= var_cbcd7339cd8a89e7 ? var_38bf6aab791decfd.size - 1 : var_cbcd7339cd8a89e7;
            finalcost = int( var_38bf6aab791decfd[ var_51765ce4c248f9f8 ] );
        }
        else
        {
            script::demoforcesre( "Invalid \"scr_" + itemdata.ref + "_cost_override\" dvar value. Value: \"" + var_fca64d021f97047c + "\"." );
        }
    }
    
    if ( level.br_armory_kiosk.sales_discount > 0 )
    {
        var_f6430896979234a2 = level.br_armory_kiosk.sales_discount_items.size == 0 || arraycontains( level.br_armory_kiosk.sales_discount_items, itemdata.ref );
        
        if ( var_f6430896979234a2 )
        {
            finalcost = _applysalesdiscount( finalcost, level.br_armory_kiosk.sales_discount );
        }
    }
    
    upgradediscount = br_instance_inventory::function_fde5b7f7bf99327e( player, itemdata );
    
    if ( upgradediscount > 0 )
    {
        finalcost = _applysalesdiscount( finalcost, upgradediscount * 100 );
    }
    
    if ( isdefined( player.br_kiosk ) && player.br_kiosk.var_dea12ed962e61597 && arraycontains( player.br_kiosk.players, player ) )
    {
        return _applysalesdiscount( finalcost, 100 );
    }
    else if ( isfiresale )
    {
        return _applysalesdiscount( finalcost, itemdata.firesalediscount );
    }
    
    return finalcost;
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0x6ffd6321, Offset: 0x3a45
// Size: 0x9b
function function_ebc5b9cb20d7ef2( kiosk )
{
    if ( game_utility::function_a43ada404e8c591f() && isint( kiosk ) )
    {
        kiosk = self;
    }
    
    player = self;
    var_73df111cf32046f7 = getdvarint( @"hash_c37f7e3bb9eca843", 0 );
    maxdistsquared = var_73df111cf32046f7 * var_73df111cf32046f7;
    
    while ( true )
    {
        if ( !isdefined( kiosk ) || distancesquared( player.origin, kiosk.origin ) > maxdistsquared )
        {
            player notify( #"exit_quick_purchase_zone" );
            break;
        }
        
        wait 0.1;
    }
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0xe5038c84, Offset: 0x3ae8
// Size: 0x105
function _watchforcircleclosure()
{
    level endon( #"game_ended" );
    setdvarifuninitialized( @"hash_acddd0026cc9adad", 0 );
    
    while ( true )
    {
        level waittill( #"br_circle_set" );
        var_a7c7437462a16865 = getdvarint( @"hash_acddd0026cc9adad", 0 );
        
        if ( var_a7c7437462a16865 == 0 )
        {
            continue;
        }
        
        if ( level.br_circle.circleindex + 1 >= var_a7c7437462a16865 )
        {
            disableallarmorykiosks();
            
            foreach ( player in level.players )
            {
                if ( !isalive( player ) )
                {
                    continue;
                }
                
                player thread hud_message::showsplash( "br_kiosks_disabled" );
            }
            
            break;
        }
    }
}

/#

    // Namespace br_armory_kiosk
    // Params 0
    // Checksum 0xb330941, Offset: 0x3bf5
    // Size: 0xd7, Type: dev
    function function_93c45949deab67bb()
    {
        while ( true )
        {
            if ( getdvarint( @"br_armory_kiosk_debug_draw", 0 ) > 0 )
            {
                foreach ( armorykiosk in level.br_armory_kiosk.scriptables )
                {
                    line( armorykiosk.origin, armorykiosk.origin + ( 0, 0, 5000 ), ( 0.7, 0.2, 0.1 ), 1, 1, 1 );
                }
            }
            
            waitframe();
        }
    }

#/

// Namespace br_armory_kiosk
// Params 1
// Checksum 0x16b2f10a, Offset: 0x3cd4
// Size: 0xc3
function showdiscountsplash( delayseconds )
{
    player = self;
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( player.hasseendiscountsplash )
    {
        return;
    }
    
    if ( !isdefined( level.br_armory_kiosk.sales_discount ) )
    {
        return;
    }
    
    if ( level.br_armory_kiosk.sales_discount == 0 )
    {
        return;
    }
    
    player.hasseendiscountsplash = 1;
    
    if ( delayseconds > 0 )
    {
        wait delayseconds;
    }
    
    if ( level.br_armory_kiosk.sales_discount_items.size == 0 )
    {
        player thread hud_message::showsplash( "br_sales_event_all" );
        return;
    }
    
    player thread hud_message::showsplash( "br_sales_event_selective" );
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0x95d8e4f9, Offset: 0x3d9f
// Size: 0x10
function function_f98af03d5f4c6c89()
{
    return getdvarint( @"br_kiosk_visual_marker_enabled", 0 );
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0x443c9b90, Offset: 0x3db8
// Size: 0x166
function function_503368d463a0f974()
{
    if ( !function_f98af03d5f4c6c89() )
    {
        return;
    }
    
    foreach ( armorykiosk in level.br_armory_kiosk.scriptables )
    {
        armorykiosk.var_34f1eda9d4d54ff9 = objidpoolmanager::requestobjectiveid( 1 );
        objective_setshowdistance( armorykiosk.var_34f1eda9d4d54ff9, 0 );
        objective_state( armorykiosk.var_34f1eda9d4d54ff9, "invisible" );
        objective_icon( armorykiosk.var_34f1eda9d4d54ff9, "ui_mobile_buystation_visual_marker" );
        objective_setbackground( armorykiosk.var_34f1eda9d4d54ff9, 1 );
        objective_position( armorykiosk.var_34f1eda9d4d54ff9, armorykiosk.origin + ( 0, 0, 40 ) );
        function_5a1f9b4d7de0b23b( armorykiosk.var_34f1eda9d4d54ff9, 1 );
        var_1e1ecace3b3c2a63 = getdvarfloat( @"hash_b57f7c58a492252b", 0 );
        var_ee7bc8b53cebd37e = getdvarfloat( @"hash_d56247cfc459711f", 0 );
        function_ac9886e0e2860e18( armorykiosk.var_34f1eda9d4d54ff9, var_1e1ecace3b3c2a63, var_ee7bc8b53cebd37e );
    }
}

// Namespace br_armory_kiosk
// Params 3
// Checksum 0xe7722880, Offset: 0x3f26
// Size: 0x1e1
function dangercircletick( dangercircleorigin, dangercircleradius, thresholdradius )
{
    if ( br_gametypes::isfeaturedisabled( #"kiosk" ) || getdvarint( @"scr_br_kiosk_ignore_circle", 0 ) == 1 || level.br_armory_kiosk.all_disabled )
    {
        return;
    }
    
    var_1bdc861911b3625e = dangercircleradius + getdvarfloat( @"scr_br_circle_object_long_distance_cleanup_threshold", 1574 );
    var_b37e42f15ca6902b = var_1bdc861911b3625e * var_1bdc861911b3625e;
    var_83a49b02be42b069 = 0;
    
    foreach ( armorykiosk in level.br_armory_kiosk.scriptables )
    {
        var_8b217f269a1d0c8d = !isdefined( armorykiosk.deconeffectcount ) && exclusion_zones::function_1efc19de6199fff6( armorykiosk.origin, 0, 0 ) == -1 && distance2dsquared( armorykiosk.origin, dangercircleorigin ) + level.var_ea96217a33eb6457 > var_b37e42f15ca6902b;
        
        if ( armorykiosk.visible )
        {
            if ( var_8b217f269a1d0c8d )
            {
                disablearmorykiosk( armorykiosk );
            }
            else
            {
                var_83a49b02be42b069++;
            }
            
            continue;
        }
        
        if ( !var_8b217f269a1d0c8d && !armorykiosk.isemped )
        {
            function_41cde127b379593( armorykiosk );
            var_83a49b02be42b069++;
        }
    }
    
    if ( level.var_c3258700fcc17d2 && var_83a49b02be42b069 != level.var_5b5c55bd90f27fde )
    {
        level.var_5b5c55bd90f27fde = var_83a49b02be42b069;
        setomnvar( "ui_br_available_kiosk_num", level.var_5b5c55bd90f27fde );
    }
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0x48e01e29, Offset: 0x410f
// Size: 0x1ab
function dangermulticircletick()
{
    if ( br_gametypes::isfeaturedisabled( #"kiosk" ) || getdvarint( @"scr_br_kiosk_ignore_circle", 0 ) == 1 || level.br_armory_kiosk.all_disabled )
    {
        return;
    }
    
    hiddenkiosks = [];
    var_83a49b02be42b069 = 0;
    
    foreach ( armorykiosk in level.br_armory_kiosk.scriptables )
    {
        var_8b217f269a1d0c8d = !isdefined( armorykiosk.deconeffectcount ) && exclusion_zones::function_1efc19de6199fff6( armorykiosk.origin, 0, 0 ) == -1 && !br_circle_util::ispointinmulticircledanger( armorykiosk.origin, level.var_ea96217a33eb6457 );
        
        if ( armorykiosk.visible )
        {
            if ( var_8b217f269a1d0c8d )
            {
                hiddenkiosks[ hiddenkiosks.size ] = armorykiosk;
                disablearmorykiosk( armorykiosk );
            }
            else
            {
                var_83a49b02be42b069++;
            }
            
            continue;
        }
        
        if ( !var_8b217f269a1d0c8d && !armorykiosk.isemped )
        {
            function_41cde127b379593( armorykiosk );
            var_83a49b02be42b069++;
        }
    }
    
    if ( level.var_c3258700fcc17d2 && var_83a49b02be42b069 != level.var_5b5c55bd90f27fde )
    {
        level.var_5b5c55bd90f27fde = var_83a49b02be42b069;
        setomnvar( "ui_br_available_kiosk_num", level.var_5b5c55bd90f27fde );
    }
    
    return hiddenkiosks;
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0x7356c2b4, Offset: 0x42c3
// Size: 0xe6
function disableallarmorykiosks()
{
    if ( br_gametypes::isfeaturedisabled( #"kiosk" ) )
    {
        return;
    }
    
    level.br_armory_kiosk.all_disabled = 1;
    
    foreach ( armorykiosk in level.br_armory_kiosk.scriptables )
    {
        if ( isdefined( armorykiosk.visible ) )
        {
            disablearmorykiosk( armorykiosk );
        }
    }
    
    if ( level.var_c3258700fcc17d2 )
    {
        level.var_5b5c55bd90f27fde = 0;
        setomnvar( "ui_br_available_kiosk_num", level.var_5b5c55bd90f27fde );
    }
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0x7f4c2c0, Offset: 0x43b1
// Size: 0x61
function function_41cde127b379593( armorykiosk )
{
    if ( !isdefined( armorykiosk ) )
    {
        return;
    }
    
    if ( armorykiosk.var_96c948fbd84c94a6 )
    {
        return;
    }
    
    armorykiosk setscriptablepartstate( "br_plunder_box", "visible" );
    showobjective( armorykiosk );
    armorykiosk.visible = 1;
    armorykiosk.disabled = undefined;
    armorykiosk.disablederrormsg = undefined;
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0x3f4fd581, Offset: 0x441a
// Size: 0x129
function disablearmorykiosk( armorykiosk )
{
    if ( !isdefined( armorykiosk ) )
    {
        return;
    }
    
    if ( level.var_a10d8c5e946fd9c1 )
    {
        armorykiosk.disablederrormsg = 1;
        armorykiosk setscriptablepartstate( "br_plunder_box", "closing" );
    }
    else
    {
        armorykiosk setscriptablepartstate( "br_plunder_box", "closing" );
    }
    
    hideobjective( armorykiosk );
    armorykiosk.visible = undefined;
    armorykiosk.disabled = 1;
    
    if ( armorykiosk br_contract_manager::checkforactiveobjicon() )
    {
        armorykiosk br_contract_manager::deletequestobjicon();
    }
    
    foreach ( p in level.players )
    {
        if ( p.br_kiosk == armorykiosk )
        {
            p _closepurchasemenuwithresponse( 2 );
        }
    }
    
    level notify( "buystation_kill_callout_" + armorykiosk.origin );
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0xc05ae5b9, Offset: 0x454b
// Size: 0x30
function setspawninstances( instances )
{
    assert( isarray( instances ) );
    level.br_armory_kiosk.scriptables = instances;
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0xa5ae9d7c, Offset: 0x4583
// Size: 0x30
function getallspawninstances()
{
    if ( !level.br_armory_kiosk_enabled )
    {
        return;
    }
    
    var_ff6a734cb6d77a3d = getentitylessscriptablearray( "scriptable_br_plunder_box", #classname );
    return var_ff6a734cb6d77a3d;
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0xe3860058, Offset: 0x45bc
// Size: 0x2e
function function_2e91eb67ee41a922()
{
    if ( !isdefined( level.var_2e91eb67ee41a922 ) )
    {
        level.var_2e91eb67ee41a922 = getdvarint( @"hash_ca9c84470ead8181", 0 );
    }
    
    return level.var_2e91eb67ee41a922;
}

// Namespace br_armory_kiosk
// Params 0, eflags: 0x4
// Checksum 0x639d4aa8, Offset: 0x45f3
// Size: 0x2e
function private function_2690413940bf44f5()
{
    if ( !isdefined( level.var_2690413940bf44f5 ) )
    {
        level.var_2690413940bf44f5 = getdvarint( @"scr_enable_workbench", 0 );
    }
    
    return level.var_2690413940bf44f5;
}

// Namespace br_armory_kiosk
// Params 2
// Checksum 0x9b76e133, Offset: 0x462a
// Size: 0x29
function function_9c81111e1ef4084b( buystationindex, buystationarray )
{
    if ( buystationarray.size == 0 )
    {
        return;
    }
    
    buystationindex %= buystationarray.size;
    return buystationarray[ buystationindex ];
}

// Namespace br_armory_kiosk
// Params 3, eflags: 0x4
// Checksum 0x5e76ea49, Offset: 0x465c
// Size: 0x259
function private function_dca13df93018a598( stationstruct, buystationindex, var_b2b810e594c624a6 )
{
    if ( !isdefined( stationstruct.angles ) )
    {
        stationstruct.angles = ( 0, 0, 0 );
    }
    
    if ( !isdefined( stationstruct.scriptableid ) )
    {
        stationstruct.scriptableid = "br_plunder_box";
    }
    
    if ( isdefined( stationstruct.hightier ) )
    {
        stationstruct.scriptableid = "br_plunder_box_high_tier";
    }
    
    buystation = spawnscriptable( stationstruct.scriptableid, stationstruct.origin, stationstruct.angles );
    var_62bb33164a27144 = "visible";
    
    if ( getdvarint( @"hash_bac643b1a9d211a7", 0 ) )
    {
        var_62bb33164a27144 = "hidden";
    }
    
    buystation setscriptablepartstate( "br_plunder_box", var_62bb33164a27144 );
    showobjective( buystation, var_62bb33164a27144 );
    buystation.centerbottom = buystation.origin + rotatevector( ( 12, 0, 0 ), buystation.angles );
    
    /#
        dmz_logging::addlogevent( "<dev string:x11c>", "<dev string:x128>", undefined, "<dev string:x137>", undefined, undefined, stationstruct.script_poi, stationstruct.origin );
    #/
    
    if ( isdefined( buystationindex ) )
    {
        buystation.overrideindex = buystationindex;
    }
    
    if ( isdefined( buystationindex ) )
    {
        buystation.var_15a1ac5dcc500532 = var_b2b810e594c624a6;
    }
    
    if ( level.br_armory_kiosk.var_e253c9f921155d75 )
    {
        emp::function_ddd803a218a9926c( buystation, &kioskemp, &function_41cde127b379593 );
    }
    
    if ( isdefined( stationstruct.target ) )
    {
        foreach ( struct in utility::getstructarray( stationstruct.target, "targetname" ) )
        {
            if ( struct.script_noteworthy == "kiosk_spawn_jltv_mg" )
            {
                buystation.vehiclespawn = struct;
            }
        }
    }
    
    return buystation;
}

// Namespace br_armory_kiosk
// Params 1, eflags: 0x4
// Checksum 0x553948a9, Offset: 0x48be
// Size: 0x14e
function private function_9bd56003858f6090( buystationstruct )
{
    if ( !isdefined( buystationstruct.target ) )
    {
        return;
    }
    
    buystationtargets = utility::getstructarray( buystationstruct.target, "targetname" );
    
    foreach ( struct in buystationtargets )
    {
        if ( struct.script_noteworthy == "workbench" )
        {
            if ( !isdefined( struct.angles ) )
            {
                struct.angles = ( 0, 0, 0 );
            }
            
            workbench = spawnscriptable( "br_workbench", struct.origin, struct.angles );
            workbench setscriptablepartstate( "br_workbench", "visible" );
            
            /#
                dmz_logging::addlogevent( "<dev string:x15f>", "<dev string:x169>", undefined, "<dev string:x176>", undefined, undefined, struct.script_poi, struct.origin );
            #/
            
            return;
        }
    }
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0x2e83ff92, Offset: 0x4a14
// Size: 0x62c
function function_83e1fe45e4913b6f()
{
    if ( !level.var_e24e08c324e9207 )
    {
        return;
    }
    
    flags::gameflagwait( "prematch_done" );
    numbuystations = getdvarint( @"hash_1891a7c9188f098a", 1 );
    var_373430810fdf28c7 = getdvarint( @"hash_1eaaeec5fba02706", 3 );
    var_86be87f644530e95 = getdvarint( @"hash_4cc790851bc37d7c", 3 );
    var_25294902a414772b = randomintrange( var_373430810fdf28c7, var_86be87f644530e95 + 1 );
    var_5af62aa17a40fe9e = getdvarint( @"hash_eecbc418c6540507", 0 );
    var_c8e02c7991bfe783 = getdvarint( @"hash_5d7d5915e01d1303", 0 );
    var_59c9b2715733917f = squared( getdvarint( @"hash_61f3403e27e2815f", 3000 ) );
    level.buystationlocations = utility::getstructarray( "buy_station", "targetname" );
    
    if ( level.buystationlocations.size == 0 )
    {
        return;
    }
    
    var_73f849ca8685e557 = getdvarint( @"hash_4409a87281d77ed1", 0 );
    var_2e91eb67ee41a922 = function_2e91eb67ee41a922();
    
    if ( var_5af62aa17a40fe9e > 0 )
    {
        stationsspawned = 0;
        numlocations = level.buystationlocations.size;
        selectedbuystations = [];
        level.buystationlocations = arrayrandomize( level.buystationlocations );
        
        for ( stationindex = 0; stationindex < numlocations ; stationindex++ )
        {
            if ( br_circle::ispointwithininitialdangercircle( level.buystationlocations[ stationindex ].origin ) )
            {
                inrange = 0;
                
                foreach ( station in selectedbuystations )
                {
                    if ( distance2dsquared( station.origin, level.buystationlocations[ stationindex ].origin ) < var_59c9b2715733917f )
                    {
                        inrange = 1;
                        break;
                    }
                }
                
                if ( inrange )
                {
                    continue;
                }
                
                selectedbuystations[ selectedbuystations.size ] = spawnbuystation( level.buystationlocations[ stationindex ], stationsspawned );
                stationsspawned++;
                
                if ( stationsspawned == var_5af62aa17a40fe9e )
                {
                    break;
                }
            }
        }
    }
    else if ( !var_73f849ca8685e557 && !var_2e91eb67ee41a922 )
    {
        var_c0e84972187efef1 = [];
        buystationpois = [];
        numlocations = level.buystationlocations.size;
        
        for ( stationindex = 0; stationindex < numlocations ; stationindex++ )
        {
            buystation = level.buystationlocations[ stationindex ];
            
            if ( !isdefined( buystation.script_poi ) )
            {
                continue;
            }
            
            if ( !isdefined( var_c0e84972187efef1[ buystation.script_poi ] ) )
            {
                var_c0e84972187efef1[ buystation.script_poi ] = [];
                buystationpois[ buystationpois.size ] = buystation.script_poi;
            }
            
            var_c0e84972187efef1[ buystation.script_poi ][ var_c0e84972187efef1[ buystation.script_poi ].size ] = buystation;
        }
        
        buystationpois = arrayrandomize( buystationpois );
        stationsspawned = 0;
        stationpois = 0;
        
        foreach ( buystationpoi in buystationpois )
        {
            if ( stationpois == var_25294902a414772b )
            {
                break;
            }
            
            if ( !poi::poi_ispoiactive( buystationpoi ) )
            {
                continue;
            }
            
            if ( game_utility::getgametype() == "dmz" && game_utility::function_87c1e942653b7c63() )
            {
                stationsspawned = function_632676c5b6b918a7( stationsspawned, var_c0e84972187efef1[ buystationpoi ], buystationpoi );
                continue;
            }
            
            var_a336adab24e8d87a = var_c0e84972187efef1[ buystationpoi ];
            var_bd50f3caf3207809 = numbuystations;
            
            if ( var_bd50f3caf3207809 > var_a336adab24e8d87a.size )
            {
                var_bd50f3caf3207809 = var_a336adab24e8d87a.size;
            }
            
            var_a336adab24e8d87a = utility::array_slice( arrayrandomize( var_a336adab24e8d87a ), 0, var_bd50f3caf3207809 );
            
            for ( stationindex = 0; stationindex < var_a336adab24e8d87a.size ; stationindex++ )
            {
                spawnbuystation( var_a336adab24e8d87a[ stationindex ], stationsspawned );
                stationsspawned++;
            }
        }
    }
    else
    {
        buystationlocations = level.buystationlocations;
        
        if ( !var_2e91eb67ee41a922 )
        {
            buystationlocations = utility::array_slice( arrayrandomize( level.buystationlocations ), 0, numbuystations );
        }
        
        numlocations = buystationlocations.size;
        stationsspawned = 0;
        
        for ( stationindex = 0; stationindex < numlocations ; stationindex++ )
        {
            spawnbuystation( buystationlocations[ stationindex ], stationsspawned );
            stationsspawned++;
        }
    }
    
    if ( var_c8e02c7991bfe783 > 0 )
    {
        circlecount = level.br_level.br_circlecenters.size;
        circlecount = int( max( circlecount - 1, 0 ) );
        dangercenterorigin = ( level.br_level.br_circlecenters[ circlecount ][ 0 ], level.br_level.br_circlecenters[ circlecount ][ 1 ], 0 );
        level.buystationlocations = sortbydistance( level.buystationlocations, dangercenterorigin );
        stationsinrange = 0;
        
        for ( stationindex = 0; stationindex < level.buystationlocations.size ; stationindex++ )
        {
            inrange = 0;
            
            foreach ( buystation in level.br_armory_kiosk.scriptables )
            {
                if ( distance2dsquared( level.buystationlocations[ stationindex ].origin, buystation.origin ) < var_59c9b2715733917f )
                {
                    inrange = 1;
                    break;
                }
            }
            
            if ( inrange )
            {
                stationsinrange++;
                
                if ( stationsinrange == var_c8e02c7991bfe783 )
                {
                    break;
                }
                else
                {
                    continue;
                }
            }
            
            spawnbuystation( level.buystationlocations[ stationindex ], stationsspawned );
            stationsspawned++;
            stationsinrange++;
            
            if ( stationsinrange == var_c8e02c7991bfe783 )
            {
                break;
            }
        }
    }
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0x278b8d5, Offset: 0x5048
// Size: 0x94
function function_65bac696ddb8beb5( structname )
{
    level endon( #"game_ended" );
    
    if ( !level.br_debugsolotest )
    {
        level waittill( #"prematch_done" );
        waitframe();
    }
    
    if ( !isdefined( level.buystationlocs ) || level.buystationlocs.size == 0 )
    {
        return;
    }
    
    for ( i = 0; i < level.buystationlocs.size ; i++ )
    {
        function_1d91196be82c23bd( level.buystationlocs[ i ] );
    }
    
    utility::flag_set( "buy_stations_spawned" );
}

// Namespace br_armory_kiosk
// Params 2
// Checksum 0x3387c38f, Offset: 0x50e4
// Size: 0x18c
function spawnbuystation( stationstruct, stationsspawned )
{
    if ( isdefined( level.buystationlocations ) )
    {
        level.buystationlocations = arrayremove( level.buystationlocations, stationstruct );
    }
    
    if ( isdefined( stationstruct.var_553cc8efe969a2a8 ) )
    {
        var_2a4068ac496f5a82 = tablelookuprownum( "mp/buyStation/buyStationDefs.csv", 1, stationstruct.var_553cc8efe969a2a8 );
        buystationindex = int( tablelookupbyrow( "mp/buyStation/buyStationDefs.csv", var_2a4068ac496f5a82, 0 ) );
    }
    else
    {
        buystationindex = undefined;
        
        if ( level.buystationsinuse.size > 0 )
        {
            buystationindex = function_9c81111e1ef4084b( stationsspawned, level.buystationsinuse )[ "index" ];
        }
    }
    
    if ( isdefined( stationstruct.var_4707e873c004bdc3 ) )
    {
        var_2a4068ac496f5a82 = tablelookuprownum( "mp/buyStation/buyStationDefs.csv", 1, stationstruct.var_4707e873c004bdc3 );
        var_b2b810e594c624a6 = int( tablelookupbyrow( "mp/buyStation/buyStationDefs.csv", var_2a4068ac496f5a82, 0 ) );
    }
    else
    {
        var_b2b810e594c624a6 = undefined;
        
        if ( level.var_b60df4c8e09fbe23.size > 0 )
        {
            var_b2b810e594c624a6 = function_9c81111e1ef4084b( stationsspawned, level.var_b60df4c8e09fbe23 )[ "index" ];
        }
    }
    
    if ( br_weapon_upgrade::function_f931980fcbcda20b() )
    {
        function_9bd56003858f6090( stationstruct );
    }
    
    buystation = function_dca13df93018a598( stationstruct, buystationindex, var_b2b810e594c624a6 );
    buystation.var_553cc8efe969a2a8 = stationstruct.var_553cc8efe969a2a8;
    level.br_armory_kiosk.scriptables[ level.br_armory_kiosk.scriptables.size ] = buystation;
    return buystation;
}

// Namespace br_armory_kiosk
// Params 2
// Checksum 0xd7d05942, Offset: 0x5279
// Size: 0x44
function function_5ef1ab9c14067db2( structname, stationstruct )
{
    if ( !isdefined( level.buystationlocs ) )
    {
        level.buystationlocs = [];
    }
    
    level.buystationlocs[ level.buystationlocs.size ] = stationstruct;
    return stationstruct;
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0x36c69bd3, Offset: 0x52c6
// Size: 0x53
function function_1d91196be82c23bd( stationstruct )
{
    assert( isdefined( level.br_armory_kiosk ) );
    stationsspawned = level.br_armory_kiosk.scriptables.size;
    scriptedkiosk = spawnbuystation( stationstruct, stationsspawned );
    return scriptedkiosk;
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0x6163eca1, Offset: 0x5322
// Size: 0x67
function spawnbuystations( stationstructs )
{
    for ( stationsspawned = 0; stationsspawned < stationstructs.size ; stationsspawned++ )
    {
        scriptedkiosk = spawnbuystation( stationstructs[ stationsspawned ], stationsspawned );
        level.br_armory_kiosk.scriptables[ level.br_armory_kiosk.scriptables.size ] = scriptedkiosk;
    }
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0xf74bebc5, Offset: 0x5391
// Size: 0x73
function function_139d58d75da4222( structname )
{
    if ( !level.br_armory_kiosk_enabled )
    {
        return [];
    }
    
    var_ff6a734cb6d77a3d = getentitylessscriptablearray( "scriptable_br_plunder_box", #classname );
    allspawnlocations = var_ff6a734cb6d77a3d;
    
    if ( level.var_e24e08c324e9207 )
    {
        var_f69105072a51d19d = utility::getstructarray( structname, "targetname" );
        allspawnlocations = arraycombineunique( allspawnlocations, var_f69105072a51d19d );
    }
    
    return allspawnlocations;
}

// Namespace br_armory_kiosk
// Params 2
// Checksum 0xe37e0d77, Offset: 0x540d
// Size: 0x10d, Type: bool
function canusekiosk( instance, player )
{
    if ( level.gameended )
    {
        return false;
    }
    
    if ( ( !player player::isreallyalive() || player.inlaststand ) && !game_utility::function_a43ada404e8c591f() )
    {
        return false;
    }
    
    if ( player utility::isusingremote() )
    {
        return false;
    }
    
    if ( player vehicle::is_in_vehicle() )
    {
        return false;
    }
    
    if ( player utility::callsharedfunc( #"gametype", #"playerskipkioskuse", instance ) )
    {
        return false;
    }
    
    if ( player.iscarrying )
    {
        player hud_message::showerrormessage( %"MP/CANNOT_USE_GENERIC" );
        return false;
    }
    
    if ( player.isjuggernaut )
    {
        player hud_message::showerrormessage( level.br_pickups.br_pickupdenyjuggernaut );
        return false;
    }
    
    if ( instance.locked )
    {
        if ( !isdefined( instance.var_436e7366a08a6109 ) )
        {
            instance.var_436e7366a08a6109 = 0;
        }
        
        instance.var_436e7366a08a6109++;
        return false;
    }
    
    return true;
}

// Namespace br_armory_kiosk
// Params 6
// Checksum 0xfced72ca, Offset: 0x5523
// Size: 0x28e
function armorykioskused( instance, part, state, player, bautouse, usestring )
{
    if ( !br_public::iskiosk( instance.type ) && !br_public::function_dea12ed962e61597( instance.type ) )
    {
        return;
    }
    
    if ( instance.var_dea12ed962e61597 && !arraycontains( instance.players, player ) )
    {
        return;
    }
    
    if ( bautouse && !function_d6a575a95d5f637b() )
    {
        return;
    }
    
    if ( !isdefined( player ) )
    {
        player = self;
    }
    
    if ( bautouse && !isdefined( player.armorykioskpurchaseallowed ) )
    {
        player.armorykioskpurchaseallowed = 0;
    }
    
    if ( getdvarint( @"hash_ece0c71aa9d5c939", 0 ) )
    {
        player function_14ecac7f56e66c1b();
    }
    
    if ( !canusekiosk( instance, player ) )
    {
        if ( bautouse )
        {
            player.armorykioskpurchaseallowed = 0;
        }
        
        return;
    }
    
    if ( !isdefined( instance.playersused ) )
    {
        instance.playersused = [];
    }
    
    if ( !arraycontains( instance.playersused, player ) )
    {
        instance.playersused[ instance.playersused.size ] = player;
    }
    
    if ( instance.disablederrormsg && instance.isemped )
    {
        if ( soundexists( "br_plunder_atm_cancel" ) )
        {
            player playlocalsound( "br_plunder_atm_cancel" );
        }
        
        player hud_message::showerrormessage( "MP_BR_INGAME/EMPED_DEPLOYABLE_KIOSK" );
        return;
    }
    
    if ( instance.disablederrormsg )
    {
        if ( soundexists( "br_plunder_atm_cancel" ) )
        {
            player playlocalsound( "br_plunder_atm_cancel" );
        }
        
        player hud_message::showerrormessage( "MP_BR_INGAME/UNUSABLE_KIOSK" );
        return;
    }
    
    if ( !isdefined( instance.playersusing ) )
    {
        instance.playersusing = [];
    }
    
    instance.playersusing[ instance.playersusing.size ] = player;
    
    if ( utility::issharedfuncdefined( #"biometricscan", #"reportkeycardcount" ) )
    {
        [[ utility::getsharedfunc( #"biometricscan", #"reportkeycardcount" ) ]]( player );
    }
    
    if ( bautouse )
    {
        if ( !player.armorykioskpurchaseallowed )
        {
            function_2d1d175f54b0caf3( instance, player );
        }
        
        return;
    }
    
    if ( player.insertingarmorplate )
    {
        player notify( #"try_armor_cancel", "armory_kiosk_used" );
    }
    
    if ( isdefined( instance ) )
    {
        function_c3e759f5599da6c0( instance, part, state );
    }
    
    player thread _runpurchasemenu( instance );
}

// Namespace br_armory_kiosk
// Params 3
// Checksum 0x5552e010, Offset: 0x57b9
// Size: 0xf5
function function_c3e759f5599da6c0( kiosk, part, currentstate )
{
    if ( !isdefined( part ) )
    {
        if ( br_public::iskiosk( kiosk.type ) )
        {
            part = "br_plunder_box";
        }
        else if ( kiosk.var_dea12ed962e61597 )
        {
            part = "br_plunder_box_stronghold";
        }
        else
        {
            return;
        }
    }
    
    if ( !isdefined( currentstate ) )
    {
        currentstate = kiosk getscriptablepartstate( part );
    }
    
    switch ( currentstate )
    {
        case #"hash_2a59780b5f94bfdd":
        case #"hash_30df217077b73b50":
        case #"hash_b799d1d25a80c481":
        case #"hash_b8e6f37f38dbc6b1":
        case #"hash_fb4008fe550f76ab":
            break;
        default:
            return;
    }
    
    newstate = "opening";
    
    if ( currentstate == "firesale_visible" )
    {
        newstate = "firesale_opening";
    }
    
    kiosk setscriptablepartstate( part, newstate );
    kiosk thread kioskfixupproneplayers();
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0x9066fbfd, Offset: 0x58b6
// Size: 0x29e
function function_14ecac7f56e66c1b()
{
    player = self;
    
    foreach ( p in level.teamdata[ player.team ][ "players" ] )
    {
        if ( !isdefined( p ) )
        {
            continue;
        }
        
        if ( level.usegulag )
        {
            gulagjail = p.game_extrainfo & 32768;
            gulagarena = p.game_extrainfo & 65536;
            var_493e7ac6e15011bf = istrue( p.wasingulag );
            var_38ce4173b47cbaca = isdefined( p.gulag );
            var_65933762fead00fd = istrue( p.gulag );
            var_d437d2a4877722ed = isdefined( p.gulagarena );
            var_eba1cf00d7ed6898 = istrue( p.gulagarena );
            var_8ec24788dd7a8eec = istrue( p.gulagloser );
            arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( p );
            playerarena = isdefined( arena );
        }
        else
        {
            gulagjail = 0;
            gulagarena = 0;
            var_493e7ac6e15011bf = 0;
            var_38ce4173b47cbaca = 0;
            var_65933762fead00fd = 0;
            var_d437d2a4877722ed = 0;
            var_eba1cf00d7ed6898 = 0;
            var_8ec24788dd7a8eec = 0;
            arena = 0;
            playerarena = 0;
        }
        
        eliminated = istrue( p.br_iseliminated );
        isplayeralive = isalive( p );
        playersessionstate = p.sessionstate;
        playerspectating = isdefined( p getspectatingplayer() );
        isplayerspectating = playerspectating;
        sessionuimemberindex = p.sessionuimemberindex;
        logstring( "[ WHY_NO_BUYBACK TEST] : " + p.name + ", " + eliminated + ", " + gulagjail + ", " + gulagarena + ", " + var_493e7ac6e15011bf + ", " + var_38ce4173b47cbaca + ", " + var_65933762fead00fd + ", " + var_d437d2a4877722ed + ", " + var_eba1cf00d7ed6898 + ", " + var_8ec24788dd7a8eec + ", " + playerarena + ", " + isplayeralive + ", " + playersessionstate + ", " + isplayerspectating + ", " + sessionuimemberindex );
    }
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0x66d0a3a2, Offset: 0x5b5c
// Size: 0x12c
function kioskfixupproneplayers()
{
    if ( !getdvarint( @"hash_636451c6314df097", 1 ) )
    {
        return;
    }
    
    radius = getdvarfloat( @"hash_3990f3347374d18e", 300 );
    closeplayers = function_6a293b884c444a20( level.players, self.origin, radius );
    
    foreach ( player in closeplayers )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( player getstance() != "prone" )
        {
            continue;
        }
        
        halfsize = player getboundshalfsize();
        radius = halfsize[ 0 ];
        height = 2 * halfsize[ 2 ];
        
        if ( capsuletracepassed( player.origin, radius, height, undefined, 0, 0 ) )
        {
            continue;
        }
        
        player setstance( "crouch", 1 );
    }
}

// Namespace br_armory_kiosk
// Params 2
// Checksum 0xfee27f56, Offset: 0x5c90
// Size: 0xc6
function kiosksetupfiresaleforplayer( kiosk, player )
{
    if ( !isdefined( kiosk.firesaleforplayers ) )
    {
        kiosk.firesaleforplayers = [ player ];
    }
    else if ( !arraycontains( kiosk.firesaleforplayers, player ) )
    {
        kiosk.firesaleforplayers[ kiosk.firesaleforplayers.size ] = player;
    }
    
    if ( !kiosk br_contract_manager::checkforactiveobjicon() )
    {
        kiosk br_contract_manager::createquestobjicon( "ui_mp_br_mapmenu_icon_poi_plunder_box_firesale", "active", kiosk.origin );
    }
    
    kiosk br_contract_manager::showquestobjicontoplayer( player );
    
    if ( kiosk.onmovingtrain && !kiosk.iconmoving )
    {
        kiosk thread function_9be5a88e2e243822();
    }
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0x758c54d3, Offset: 0x5d5e
// Size: 0x41
function function_9be5a88e2e243822()
{
    if ( !self.iconmoving )
    {
        self.iconmoving = 1;
    }
    
    while ( br_contract_manager::checkforactiveobjicon() )
    {
        br_quest_util::movequestobjicon( self.origin );
        waitframe();
    }
    
    self.iconmoving = 0;
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0x6fa4e455, Offset: 0x5da7
// Size: 0x18, Type: bool
function function_dae8e9cc3954591b()
{
    if ( br_publicevents::ispubliceventoftypeactive( %"firesale" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace br_armory_kiosk
// Params 2
// Checksum 0xf12733dc, Offset: 0x5dc8
// Size: 0x96
function iskioskfiresaleactiveforplayer( kiosk, player )
{
    if ( !isdefined( kiosk ) )
    {
        if ( level.var_e298f874f79103ed && function_dae8e9cc3954591b() )
        {
            return 1;
        }
        
        return 0;
    }
    
    if ( game_utility::function_a43ada404e8c591f() && ( !isdefined( kiosk ) || isint( kiosk ) ) )
    {
        kiosk = player;
    }
    
    if ( function_dae8e9cc3954591b() )
    {
        return 1;
    }
    
    if ( player.var_11b83515f350fd10 )
    {
        return 1;
    }
    
    if ( !isdefined( kiosk.firesaleforplayers ) )
    {
        return 0;
    }
    
    return arraycontains( kiosk.firesaleforplayers, player );
}

// Namespace br_armory_kiosk
// Params 2
// Checksum 0xda74040f, Offset: 0x5e67
// Size: 0x69
function kioskfiresaledoneforplayer( kiosk, player )
{
    if ( !( isdefined( kiosk ) && isdefined( kiosk.firesaleforplayers ) ) )
    {
        return;
    }
    
    kiosk br_contract_manager::hidequestobjiconfromplayer( player );
    kiosk.firesaleforplayers = arrayremove( kiosk.firesaleforplayers, player );
    
    if ( !function_dae8e9cc3954591b() )
    {
        setomnvar( "ui_br_kiosk_hide_discount", 1 );
    }
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0x1e0eb50, Offset: 0x5ed8
// Size: 0x19
function function_a2853af26b7307ce()
{
    if ( level.var_85fce9bda77a32d0 )
    {
        return level.itemdropdistance;
    }
    
    return 0;
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0x983458e8, Offset: 0x5efa
// Size: 0x66
function getkioskyawoffsetoverride()
{
    if ( level.var_85fce9bda77a32d0 )
    {
        finaloffset = level.var_6f7fce2d77242e55;
        
        if ( level.randomanglemax > 0 )
        {
            finaloffset += randomfloatrange( level.randomanglemax * -1, level.randomanglemax );
        }
        
        return finaloffset;
    }
    
    return 180 + randomfloatrange( -10, 10 );
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0xe7187e94, Offset: 0x5f69
// Size: 0xa6
function function_2d7fcaf877066493( kiosk )
{
    if ( !isdefined( kiosk.dropstruct ) )
    {
        kiosk.dropstruct = pickups::function_f71dd588dc4f6288();
        kiosk.var_8fa30ac5dd1c05fb = gettime();
        return;
    }
    
    if ( kiosk.var_8fa30ac5dd1c05fb + getdvarint( @"hash_30955f4b3a383805", 90 ) * 1000 < gettime() )
    {
        kiosk.dropstruct = pickups::function_f71dd588dc4f6288();
        kiosk.var_8fa30ac5dd1c05fb = gettime();
        kiosk.quickdropindex = undefined;
        return;
    }
    
    kiosk.var_8fa30ac5dd1c05fb = gettime();
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0xb677847f, Offset: 0x6017
// Size: 0x30f
function _runpurchasemenu( kiosk )
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player endon( #"death" );
    player.br_kiosk = kiosk;
    function_2d7fcaf877066493( kiosk );
    
    if ( br_public::isbrpracticemode() )
    {
        player notify( #"kiosk_used" );
    }
    
    if ( isdefined( level.var_87a21a3e41dc2e5d ) )
    {
        [[ level.var_87a21a3e41dc2e5d ]]( kiosk, player );
    }
    
    /#
        if ( getdvarint( @"scr_br_firesale", 0 ) > 0 )
        {
            kiosksetupfiresaleforplayer( kiosk, player );
            setdvar( @"scr_br_firesale", 0 );
        }
    #/
    
    isfiresale = iskioskfiresaleactiveforplayer( kiosk, player );
    var_936de46d0ea2c1fc = function_ee19003dc90a6734( kiosk );
    
    if ( isdefined( var_936de46d0ea2c1fc ) )
    {
        level.currentbuystation = var_936de46d0ea2c1fc;
        player setclientomnvar( "ui_buystation_override", var_936de46d0ea2c1fc );
    }
    else if ( isdefined( level.var_b72044e6a28b0fee ) && !player.var_c305bd7c24a54d39 )
    {
        level.currentbuystation = level.var_b72044e6a28b0fee;
        player setclientomnvar( "ui_buystation_override", level.var_b72044e6a28b0fee );
    }
    
    if ( level.barterenabled )
    {
        barteroverride = barter_system::function_8ebfd8cb7a429c23( player, kiosk );
        player setclientomnvar( "ui_barter_list_index", barteroverride );
    }
    
    var_ee855171605e51cd = function_d032047b4d39b355( kiosk );
    
    if ( isdefined( var_ee855171605e51cd ) )
    {
        level.var_b5b5eaf26cba1e93 = var_ee855171605e51cd;
        player setclientomnvar( "ui_weapon_buystation_override", var_ee855171605e51cd );
    }
    
    var_2919a9eff82d3b38 = function_1c9b60b9dfaef240( kiosk );
    
    if ( isdefined( var_2919a9eff82d3b38 ) )
    {
        player setclientomnvar( "ui_buystation_limited_item_amount", var_2919a9eff82d3b38 );
    }
    
    var_5b6ee1fb6c17e007 = function_d33203706510e23c( kiosk );
    
    if ( isdefined( var_5b6ee1fb6c17e007 ) )
    {
        player setclientomnvar( "ui_buystation_item_filter", var_5b6ee1fb6c17e007 );
    }
    
    setomnvar( "ui_br_kiosk_hide_discount", 0 );
    player setclientomnvar( "ui_buystation_purchase_response", 0 );
    
    if ( player.br_kiosk.var_dea12ed962e61597 )
    {
        player setclientomnvar( "ui_open_menu_from_script", 2 );
    }
    else
    {
        openvalue = 0;
        
        if ( player.br_kiosk.isdeployablekiosk )
        {
            openvalue += 16;
        }
        else
        {
            openvalue += 2;
        }
        
        if ( isfiresale )
        {
            openvalue += 4;
        }
        
        if ( kiosk.var_435658721cd2f3f5 )
        {
            openvalue += 32;
        }
        
        player setclientomnvar( "ui_buystation_open", openvalue );
    }
    
    player.armorykioskpurchaseallowed = 1;
    kiosktype = function_a160f0512ffc87b9( kiosk );
    br_analytics::branalytics_kiosk_menu_event( player, "menu_open", undefined, kiosktype );
    player thread watchtoautoclosemenu( kiosk );
    
    if ( getdvarint( @"hash_b4ff8c1463b8bc79", 1 ) )
    {
        player setsoundsubmix( "iw8_br_plunder_kiosk_menu" );
    }
    
    player calloutmarkerping::function_d34345aa1f30ebba();
    player utility::callsharedfunc( #"gametype", #"hash_fc19aa41d3bf466a", kiosk );
}

// Namespace br_armory_kiosk
// Params 2
// Checksum 0xd1091b72, Offset: 0x632e
// Size: 0x73
function function_2d1d175f54b0caf3( kiosk, player )
{
    player.br_kiosk = kiosk;
    
    /#
        if ( getdvarint( @"scr_br_firesale", 0 ) > 0 )
        {
            kiosksetupfiresaleforplayer( kiosk, player );
            setdvar( @"scr_br_firesale", 0 );
        }
    #/
    
    player.armorykioskpurchaseallowed = 1;
    player thread function_fe79a9fdbf05ad55( kiosk );
    player calloutmarkerping::function_d34345aa1f30ebba();
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0x305c3322, Offset: 0x63a9
// Size: 0x44
function function_f8b7eed121abd17c()
{
    player = self;
    player.br_kiosk = undefined;
    player.var_c305bd7c24a54d39 = undefined;
    player.var_d5168c882218a620 = undefined;
    player.armorykioskpurchaseallowed = undefined;
    player calloutmarkerping::function_d34345aa1f30ebba();
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0x3a493563, Offset: 0x63f5
// Size: 0x7f
function function_fe79a9fdbf05ad55( kiosk )
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player endon( #"death" );
    player childthread function_ebc5b9cb20d7ef2( kiosk );
    utility::waittill_any_ents( player, "death", player, "last_stand_enter", player, "meatshield_victim_start", player, "exit_quick_purchase_zone", level, "game_ended" );
    
    if ( isdefined( player ) )
    {
        function_f8b7eed121abd17c();
    }
}

// Namespace br_armory_kiosk
// Params 1, eflags: 0x4
// Checksum 0xbb7da60, Offset: 0x647c
// Size: 0x27
function private function_9342408f4c74341c( var_8ff852348df82557 )
{
    player = self;
    player setclientomnvar( "ui_buystation_purchase_response", var_8ff852348df82557 );
}

// Namespace br_armory_kiosk
// Params 1, eflags: 0x4
// Checksum 0x18b32f29, Offset: 0x64ab
// Size: 0x74
function private function_910cd58b1d8df9a0( var_8ff852348df82557 )
{
    player = self;
    
    if ( var_8ff852348df82557 == 1 && getdvarint( @"hash_ed6e4ffa933af621", 1 ) )
    {
        if ( !isdefined( player.br_kiosk ) || !player.br_kiosk.var_dea12ed962e61597 )
        {
            player function_9342408f4c74341c( 1 );
            return;
        }
    }
    
    player _closepurchasemenuwithresponse( var_8ff852348df82557 );
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0x7b9c7113, Offset: 0x6527
// Size: 0x27b
function _closepurchasemenuwithresponse( var_8ff852348df82557 )
{
    player = self;
    player setclientomnvar( "ui_buystation_purchase_response", var_8ff852348df82557 );
    player setclientomnvar( "ui_buystation_open", 1 );
    player setclientomnvar( "ui_buystation_override", -1 );
    player setclientomnvar( "ui_weapon_buystation_override", -1 );
    player clearsoundsubmix( "iw8_br_plunder_kiosk_menu" );
    vehicle_interact::function_f8ec5cbb44385eaa( player.var_d5168c882218a620, player );
    
    if ( isdefined( player.br_kiosk ) )
    {
        if ( isdefined( player.br_kiosk ) && isdefined( player.br_kiosk.playersusing ) && arraycontains( player.br_kiosk.playersusing, player ) )
        {
            player.br_kiosk.playersusing = arrayremove( player.br_kiosk.playersusing, player );
        }
        
        if ( player.br_kiosk.var_dea12ed962e61597 )
        {
            if ( var_8ff852348df82557 == 1 && arraycontains( player.br_kiosk.players, player ) )
            {
                player.br_kiosk.players = arrayremove( player.br_kiosk.players, player );
                player.br_kiosk.var_43355c6fab4683be[ player.br_kiosk.var_43355c6fab4683be.size ] = player;
                player.br_kiosk br_strongholds::function_f4e1ae6ec70d2b0d( player );
                
                if ( player.br_kiosk.players.size <= 0 && !level.var_4a5de2a2eae8e2b0 )
                {
                    player.br_kiosk setscriptablepartstate( "br_plunder_box_stronghold", "visible_blank" );
                }
            }
            
            player setclientomnvar( "ui_open_menu_from_script", 0 );
        }
    }
    
    kiosktype = function_a160f0512ffc87b9( player.br_kiosk );
    player.br_kiosk = undefined;
    player.var_c305bd7c24a54d39 = undefined;
    player.var_d5168c882218a620 = undefined;
    player.armorykioskpurchaseallowed = undefined;
    player.var_b42a76bce637a933 = undefined;
    br_analytics::branalytics_kiosk_menu_event( player, "menu_close", "reason: " + var_8ff852348df82557, kiosktype );
    player notify( #"hash_af164706b76a3248" );
    player calloutmarkerping::function_d34345aa1f30ebba();
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0x86b15b7, Offset: 0x67aa
// Size: 0x23
function _purchasemenuclosedbyclient( player )
{
    player function_910cd58b1d8df9a0( 0 );
    player notify( #"hash_af164706b76a3248" );
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0x1da7552e, Offset: 0x67d5
// Size: 0xf3
function watchtoautoclosemenu( kiosk )
{
    player = self;
    player endon( #"disconnect" );
    player notify( #"hash_af164706b76a3248" );
    player endon( #"hash_af164706b76a3248" );
    player childthread _proximitywatcher( kiosk );
    utility::waittill_any_ents( player, "death", player, "last_stand_enter", player, "meatshield_victim_start", player, "pushed_too_far", level, "game_ended", player, "player_isHaywire" );
    
    if ( isdefined( player.pers[ "telemetry" ] ) )
    {
        if ( player.pers[ "telemetry" ].var_e1567de387d39e8c )
        {
            player.pers[ "telemetry" ].var_765f9934ae1cca3e = 1;
            player.pers[ "telemetry" ].var_e1567de387d39e8c = 0;
        }
    }
    
    player function_910cd58b1d8df9a0( 2 );
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0xf787da14, Offset: 0x68d0
// Size: 0xae
function _proximitywatcher( kiosk )
{
    if ( game_utility::function_a43ada404e8c591f() && isint( kiosk ) )
    {
        kiosk = self;
    }
    
    player = self;
    var_b3e005a39a3a3821 = 64;
    var_73df111cf32046f7 = getdvarfloat( @"hash_ecd52993b5dab130", 128 ) + var_b3e005a39a3a3821;
    maxdistsquared = var_73df111cf32046f7 * var_73df111cf32046f7;
    
    while ( true )
    {
        wait 0.1;
        var_91786b0e20cc176b = distancesquared( player.origin, kiosk.origin );
        
        if ( var_91786b0e20cc176b > maxdistsquared )
        {
            player notify( #"pushed_too_far" );
            break;
        }
    }
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0xb93f932, Offset: 0x6986
// Size: 0x51
function _getequipmentammotomax( equipmentref )
{
    player = self;
    
    if ( !isdefined( equipmentref ) )
    {
        return 0;
    }
    
    ammo = player equipment_mp::getequipmentammo( equipmentref );
    ammomax = player equipment_mp::getequipmentmaxammo( equipmentref );
    return max( 0, ammomax - ammo );
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0x2163e3bb, Offset: 0x69e0
// Size: 0x5a
function _maxoutequipmentammo( equipmentref )
{
    player = self;
    
    if ( !isdefined( equipmentref ) )
    {
        return 0;
    }
    
    ammo = player equipment_mp::getequipmentammo( equipmentref );
    ammomax = player equipment_mp::getequipmentmaxammo( equipmentref );
    
    if ( ammo < ammomax )
    {
        player equipment_mp::setequipmentammo( equipmentref, ammomax );
    }
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0xbf96ddc2, Offset: 0x6a42
// Size: 0x2
function function_cc169fb4f3b9afdc()
{
    
}

// Namespace br_armory_kiosk
// Params 2
// Checksum 0x7b2a07b3, Offset: 0x6a4c
// Size: 0x270
function _findgivearmoramountanddropleftovers( fromkiosk, var_94a2938c1379707 )
{
    player = self;
    armorcount = player equipment_mp::getequipmentslotammo( "health" );
    
    if ( !isdefined( armorcount ) )
    {
        armorcount = 0;
    }
    
    maxarmorcount = player equipment_mp::getequipmentmaxammo( level.armorref ?? "equip_armorplate" );
    
    if ( getdvarint( @"scr_br_alt_mode_gg", 0 ) )
    {
        bundlecount = 2;
    }
    else
    {
        bundlecount = 5;
    }
    
    giveamount = int( max( min( bundlecount, maxarmorcount - armorcount ), 0 ) );
    dropamount = bundlecount - giveamount;
    
    if ( common_inventory::function_7ec5937e3b3d86e0( "brloot_armor_plate" ) )
    {
        lootid = loot::function_d3e3bcaea591a6a2( "brloot_armor_plate" );
        fakepickup = spawnstruct();
        fakepickup.scriptablename = "brloot_armor_plate";
        fakepickup.count = dropamount;
        leftover = player br_default_inventory::additemtobackpack( lootid, fakepickup, 1 );
        
        if ( leftover > 0 && !var_94a2938c1379707 )
        {
            baseorigin = player.origin;
            baseangles = player.angles;
            
            if ( fromkiosk && isdefined( player.br_kiosk ) )
            {
                baseorigin = player.br_kiosk.centerbottom ?? player.br_kiosk.origin;
                baseangles = player.br_kiosk.angles;
            }
            
            spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( baseorigin, baseangles );
            namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( "brloot_armor_plate", dropamount, spawnoptions );
        }
    }
    else if ( dropamount > 0 && !var_94a2938c1379707 )
    {
        baseorigin = player.origin;
        baseangles = player.angles;
        
        if ( fromkiosk && isdefined( player.br_kiosk ) )
        {
            baseorigin = player.br_kiosk.centerbottom ?? player.br_kiosk.origin;
            baseangles = player.br_kiosk.angles;
        }
        
        spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( baseorigin, baseangles );
        namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( "brloot_armor_plate", dropamount, spawnoptions );
    }
    
    return giveamount;
}

// Namespace br_armory_kiosk
// Params 5
// Checksum 0x56c75a09, Offset: 0x6cc5
// Size: 0xd8e
function _validateitempurchase( kiosk, itemdata, var_34fb6ff55f0a6c4b, var_3a7c536abcf46aa7, var_6165334f32674d8 )
{
    player = self;
    var_a2c9b9cfdf3d3a32 = var_6165334f32674d8 ? 2 : 0;
    var_b88354ac88608570 = var_a2c9b9cfdf3d3a32 == 2 ? 0 : 1;
    
    if ( itemdata.filtered )
    {
        player function_910cd58b1d8df9a0( 24 );
        return 0;
    }
    
    var_a7312c79d1e49aa4 = function_b2b8b8e2eedcc21d( kiosk, itemdata.entryref );
    
    if ( !var_a7312c79d1e49aa4 )
    {
        player function_910cd58b1d8df9a0( 24 );
        return 0;
    }
    
    itemstock = function_a014fb6ec469e815( kiosk, itemdata.entryref );
    
    if ( itemstock <= 0 )
    {
        player function_910cd58b1d8df9a0( 24 );
        return 0;
    }
    
    var_6355b03aa74e720b = player currency::get_currency_amount( "cash" );
    var_ffc4c62576ecef5a = _getactualcost( player, itemdata );
    
    if ( !isdefined( var_6355b03aa74e720b ) )
    {
        player currency::set_currency_amount( "cash", 0 );
        var_6355b03aa74e720b = player currency::get_currency_amount( "cash" );
    }
    
    if ( var_6355b03aa74e720b < var_ffc4c62576ecef5a )
    {
        player function_910cd58b1d8df9a0( 3 );
        return 0;
    }
    
    if ( isdefined( itemdata.unlocksublocation ) )
    {
        var_75a742bec8c70ee2 = br_instance_inventory::function_902ad22eabe0eeeb( player, itemdata.unlocksublocation );
        
        /#
            var_d7911b09d714d8b2 = getdvarint( @"hash_7c258033cf2231ad", -1 );
            
            if ( var_d7911b09d714d8b2 >= 0 )
            {
                var_75a742bec8c70ee2 = itemdata.unlocksublocation == var_d7911b09d714d8b2;
            }
        #/
        
        if ( !var_75a742bec8c70ee2 )
        {
            return 0;
        }
    }
    
    if ( utility::issharedfuncdefined( #"gametype", #"hash_17812df302dd419a" ) )
    {
        result = player utility::callsharedfunc( #"gametype", #"hash_17812df302dd419a", kiosk, itemdata );
        
        if ( isdefined( result ) )
        {
            if ( !result )
            {
                return 0;
            }
            else
            {
                return 1;
            }
        }
    }
    
    if ( itemdata.type == "killstreak" )
    {
        if ( !var_34fb6ff55f0a6c4b )
        {
            if ( player br_pickups::haskillstreak( itemdata.ref ) )
            {
                if ( var_b88354ac88608570 )
                {
                    player function_910cd58b1d8df9a0( 4 );
                }
                
                return var_a2c9b9cfdf3d3a32;
            }
        }
    }
    else if ( itemdata.type == "fieldupgrade" || itemdata.type == "super" )
    {
        if ( player supers_mp::issuperinuse() )
        {
            if ( var_b88354ac88608570 )
            {
                player function_910cd58b1d8df9a0( 6 );
            }
            
            return var_a2c9b9cfdf3d3a32;
        }
        
        if ( !var_34fb6ff55f0a6c4b )
        {
            currentsuperref = player supers_mp::getcurrentsuperref();
            
            if ( itemdata.ref == currentsuperref )
            {
                if ( var_b88354ac88608570 )
                {
                    player function_910cd58b1d8df9a0( 5 );
                }
                
                return var_a2c9b9cfdf3d3a32;
            }
        }
    }
    else if ( itemdata.type == "perk" )
    {
        if ( isdefined( player.perks[ itemdata.ref ] ) )
        {
            if ( var_b88354ac88608570 )
            {
                player function_910cd58b1d8df9a0( 5 );
            }
            
            return var_a2c9b9cfdf3d3a32;
        }
    }
    else if ( itemdata.type == "equipment" )
    {
        if ( var_3a7c536abcf46aa7 )
        {
            return 2;
        }
        
        var_b96c8ec5bac6592f = spawnstruct();
        var_b96c8ec5bac6592f.scriptablename = itemdata.entryref;
        var_b96c8ec5bac6592f.count = 1;
        canpickupresult = br_pickups::cantakepickup( var_b96c8ec5bac6592f, 1 );
        
        switch ( canpickupresult )
        {
            case 1:
            case 20:
                break;
            default:
                if ( var_b88354ac88608570 )
                {
                    player function_910cd58b1d8df9a0( 7 );
                }
                
                return var_a2c9b9cfdf3d3a32;
        }
    }
    else if ( itemdata.type == "weapon" )
    {
        if ( player.carryinghostage )
        {
            if ( isdefined( level.br_pickups ) && isdefined( level.br_pickups.var_9d247aba85e39454 ) )
            {
                player hud_message::showerrormessage( level.br_pickups.var_9d247aba85e39454 );
            }
            
            return 0;
        }
        
        newweapon = br_pickups::getfullweaponobjforscriptablepartname( itemdata.ref );
        
        if ( isdefined( newweapon ) )
        {
            foreach ( weap in player.primaryweapons )
            {
                if ( issameweapon( weap, newweapon ) )
                {
                    if ( var_b88354ac88608570 )
                    {
                        player function_910cd58b1d8df9a0( 7 );
                    }
                    
                    return 0;
                }
            }
            
            if ( br_default_inventory::function_787d2ebb0cc2e86f( player ) )
            {
                playerdataweapon = br_default_inventory::function_3b4976a12ea5037b( player );
                
                if ( issameweapon( playerdataweapon, newweapon ) )
                {
                    if ( var_b88354ac88608570 )
                    {
                        player function_910cd58b1d8df9a0( 7 );
                    }
                    
                    return 0;
                }
            }
        }
        
        return 1;
    }
    else if ( itemdata.type == "special" || itemdata.type == "persistent" )
    {
        switch ( itemdata.ref )
        {
            case #"hash_2dcde97962801ba9":
            case #"hash_a825dc92f843028d":
            case #"hash_25789111b74943b4":
                if ( game_utility::function_a43ada404e8c591f() )
                {
                    var_b96c8ec5bac6592f = spawnstruct();
                    var_b96c8ec5bac6592f.scriptablename = "brloot_armor_plate";
                    
                    if ( itemdata.ref == "armor_bundle" )
                    {
                        var_b96c8ec5bac6592f.count = 5;
                    }
                    else
                    {
                        var_b96c8ec5bac6592f.count = 1;
                    }
                    
                    canpickupresult = br_pickups::cantakepickup( var_b96c8ec5bac6592f );
                    
                    if ( canpickupresult != 1 )
                    {
                        if ( var_b88354ac88608570 )
                        {
                            player function_910cd58b1d8df9a0( 7 );
                        }
                        
                        return var_a2c9b9cfdf3d3a32;
                    }
                }
                
                break;
            case #"hash_a7a7446a3194cb49":
                var_ec69fadc35ec1649 = armor::function_c600b2d5e82ce2d5();
                
                if ( !var_ec69fadc35ec1649 )
                {
                    if ( var_b88354ac88608570 )
                    {
                        player function_910cd58b1d8df9a0( 7 );
                    }
                    
                    return var_a2c9b9cfdf3d3a32;
                }
                
                break;
            case #"hash_1b71e2c3430cd301":
            case #"hash_2d1a1b811aed6b26":
            case #"hash_4808e1f340e11163":
            case #"hash_dcf82d1f65a6b16e":
            case #"hash_d01e387e6d238502":
                if ( var_3a7c536abcf46aa7 )
                {
                    return 2;
                }
                
                var_b96c8ec5bac6592f = spawnstruct();
                var_b96c8ec5bac6592f.scriptablename = gasmask::getscriptablename( itemdata.ref );
                assert( isdefined( var_b96c8ec5bac6592f.scriptablename ) );
                var_b96c8ec5bac6592f.count = gasmask::getmaxhealth( var_b96c8ec5bac6592f.scriptablename );
                canpickupresult = br_pickups::cantakepickup( var_b96c8ec5bac6592f, 1 );
                
                switch ( canpickupresult )
                {
                    case 1:
                    case 20:
                        break;
                    default:
                        if ( var_b88354ac88608570 )
                        {
                            player function_910cd58b1d8df9a0( 7 );
                        }
                        
                        return var_a2c9b9cfdf3d3a32;
                }
                
                break;
            case #"hash_e67a71b27007444":
                if ( var_3a7c536abcf46aa7 )
                {
                    return 2;
                }
                
                var_f5d73f4cb63c65db = 0;
                
                if ( player _getequipmentammotomax( player.equipment[ "primary" ] ) > 0 )
                {
                    var_f5d73f4cb63c65db = 1;
                }
                else if ( player _getequipmentammotomax( player.equipment[ "secondary" ] ) > 0 )
                {
                    var_f5d73f4cb63c65db = 1;
                }
                else if ( !player item_weapon::function_9569f8c5584b505c() )
                {
                    var_f5d73f4cb63c65db = 1;
                }
                
                if ( !var_f5d73f4cb63c65db )
                {
                    if ( var_b88354ac88608570 )
                    {
                        player function_910cd58b1d8df9a0( 7 );
                    }
                    
                    return var_a2c9b9cfdf3d3a32;
                }
                
                break;
            case #"hash_3839e36b1d747574":
            case #"hash_6613e243265c4795":
                if ( namespace_9d8e359c3b1041e5::respawntokendisabledsharedfunc() )
                {
                    if ( var_b88354ac88608570 )
                    {
                        player function_910cd58b1d8df9a0( 9 );
                    }
                    
                    return 0;
                }
                
                if ( var_3a7c536abcf46aa7 )
                {
                    return 2;
                }
                
                if ( player.hasrespawntoken )
                {
                    if ( var_b88354ac88608570 )
                    {
                        player function_910cd58b1d8df9a0( 10 );
                    }
                    
                    return 0;
                }
                
                break;
            case #"hash_f7eba4352eb7f7ba":
                if ( br_public::function_b648dc1bd1363daf() )
                {
                    if ( var_b88354ac88608570 )
                    {
                        player function_910cd58b1d8df9a0( 9 );
                    }
                    
                    return 0;
                }
                
                if ( var_3a7c536abcf46aa7 )
                {
                    return 2;
                }
                
                if ( player br_public::function_70c1f4b75530023f() )
                {
                    if ( var_b88354ac88608570 )
                    {
                        player function_910cd58b1d8df9a0( 10 );
                    }
                    
                    return 0;
                }
                
                break;
            case #"hash_1c3e21ffbc842487":
            case #"hash_4f292feb06ad9942":
                if ( var_3a7c536abcf46aa7 )
                {
                    return 2;
                }
                
                if ( player laststand::hasselfrevivetoken() )
                {
                    if ( var_b88354ac88608570 )
                    {
                        player function_910cd58b1d8df9a0( 10 );
                    }
                    
                    return var_a2c9b9cfdf3d3a32;
                }
                
                break;
            case #"hash_3a0285dc5b457e3a":
                if ( var_3a7c536abcf46aa7 )
                {
                    return 2;
                }
                
                var_b96c8ec5bac6592f = spawnstruct();
                var_b96c8ec5bac6592f.scriptablename = "brloot_offhand_advancedsupplydrop";
                var_b96c8ec5bac6592f.count = 1;
                canpickupresult = br_pickups::cantakepickup( var_b96c8ec5bac6592f, 1 );
                
                if ( canpickupresult != 1 )
                {
                    if ( var_b88354ac88608570 )
                    {
                        player function_910cd58b1d8df9a0( 7 );
                    }
                    
                    return var_a2c9b9cfdf3d3a32;
                }
                
                break;
            case #"hash_b41ab83f39326993":
                if ( isdefined( level.br_circle ) )
                {
                    if ( var_b88354ac88608570 )
                    {
                        player function_910cd58b1d8df9a0( 17 );
                    }
                    
                    return var_a2c9b9cfdf3d3a32;
                }
                
                break;
            case #"hash_532a5678aa4979f3":
                if ( isdefined( level.br_circle ) || level.brgametype.circlerunning )
                {
                    if ( var_b88354ac88608570 )
                    {
                        player function_910cd58b1d8df9a0( 9 );
                    }
                    
                    return var_a2c9b9cfdf3d3a32;
                }
                
                break;
            case #"hash_83584572ba67a745":
                if ( !player function_d1ff77addfcea8d2() )
                {
                    if ( var_b88354ac88608570 )
                    {
                        player function_910cd58b1d8df9a0( 21 );
                    }
                    
                    return var_a2c9b9cfdf3d3a32;
                }
                
                break;
            case #"hash_546ee28ea1d0dc10":
                if ( !player function_f6d3df6bd8daadaf( "armor" ) )
                {
                    if ( var_b88354ac88608570 )
                    {
                        player function_910cd58b1d8df9a0( 20 );
                    }
                    
                    return var_a2c9b9cfdf3d3a32;
                }
                
                break;
            case #"hash_99e995f94c6d662b":
                if ( !player function_51cf7c5155f03c09() )
                {
                    if ( var_b88354ac88608570 )
                    {
                        player function_910cd58b1d8df9a0( 19 );
                    }
                    
                    return var_a2c9b9cfdf3d3a32;
                }
                
                break;
            case #"hash_63edc28701e80b73":
                if ( !player function_f6d3df6bd8daadaf( "trophy" ) )
                {
                    if ( var_b88354ac88608570 )
                    {
                        player function_910cd58b1d8df9a0( 20 );
                    }
                    
                    return var_a2c9b9cfdf3d3a32;
                }
                
                break;
            case #"hash_8db3828479a5780b":
                if ( !player function_f6d3df6bd8daadaf( "uav" ) )
                {
                    if ( var_b88354ac88608570 )
                    {
                        player function_910cd58b1d8df9a0( 20 );
                    }
                    
                    return var_a2c9b9cfdf3d3a32;
                }
                
                break;
            case #"hash_7cf102dbc7cbbbc5":
                if ( !player function_f6d3df6bd8daadaf( "barrel" ) )
                {
                    if ( var_b88354ac88608570 )
                    {
                        player function_910cd58b1d8df9a0( 20 );
                    }
                    
                    return var_a2c9b9cfdf3d3a32;
                }
                
                break;
            case #"hash_63d4978a15e681a8":
                if ( !player br_gametype_truckwar::function_69613cfdb96f05b8() )
                {
                    if ( var_b88354ac88608570 )
                    {
                        player function_910cd58b1d8df9a0( 23 );
                    }
                    
                    return 0;
                }
                
                break;
            case #"hash_a500f53d3e52d6e":
            case #"hash_5cdbaa0bf3e5ebfe":
            case #"hash_75ca97f27fab119c":
            case #"hash_8709a7ef11ecdbea":
            case #"hash_ac45395faab66eb2":
            case #"hash_ac453a5faab67045":
                if ( var_3a7c536abcf46aa7 )
                {
                    return 1;
                }
                
                var_b96c8ec5bac6592f = spawnstruct();
                var_b96c8ec5bac6592f.scriptablename = itemdata.entryref;
                var_b96c8ec5bac6592f.count = 1;
                canpickupresult = br_pickups::cantakepickup( var_b96c8ec5bac6592f );
                
                switch ( canpickupresult )
                {
                    case 1:
                    case 20:
                        break;
                    default:
                        if ( var_b88354ac88608570 )
                        {
                            player function_910cd58b1d8df9a0( 7 );
                        }
                        
                        return var_a2c9b9cfdf3d3a32;
                }
            case #"hash_2e68ca53eaf9ae70":
            case #"hash_2e68cd53eaf9b329":
            case #"hash_2fc44f64748f8c8e":
            case #"hash_6235851dae0eeca8":
            case #"hash_6c0c806bbf705a0c":
            case #"hash_a2240c78d2ced063":
            case #"hash_baa7a6f9de5c563d":
            case #"hash_bb639a6ed9e9b88a":
            case #"hash_bbf617dca645120c":
            case #"hash_bbf61adca64516c5":
            case #"hash_a179bb412a3a080d":
            case #"hash_dda8890cb35ca0bf":
            case #"hash_e4154ddbab061c63":
            case #"hash_f6bd03bdc3846abe":
            case #"hash_a179b8412a3a0354":
            case #"hash_fd8da3bdddb8e1c2":
                objective = undefined;
                
                if ( isdefined( level.var_dfb2277145204ce4 ) )
                {
                    objective = player [[ level.var_dfb2277145204ce4 ]]();
                }
                
                if ( isdefined( objective ) && isdefined( level.var_4aabf66864c03ef4 ) && [[ level.var_4aabf66864c03ef4 ]]( objective.objectivekey, player.team, itemdata.ref ) )
                {
                    if ( var_b88354ac88608570 )
                    {
                        player function_910cd58b1d8df9a0( 17 );
                    }
                    
                    return var_a2c9b9cfdf3d3a32;
                }
                
                break;
            case #"hash_bd3c5bede4f8165f":
            case #"hash_c31089e2e50b5079":
                break;
            case #"hash_9789620b82d8908c":
            case #"hash_f0fd4758cf2900f0":
            case #"hash_f4fe496941705c28":
                break;
        }
    }
    else if ( itemdata.type == "secondary_victory" )
    {
        if ( isdefined( level.secondaryvictory ) && isdefined( level.secondaryvictory.var_8d3bef423cae23c0 ) )
        {
            response = [[ level.secondaryvictory.var_8d3bef423cae23c0 ]]();
            
            if ( response == 1 || response == 2 )
            {
                return 1;
            }
            else
            {
                player function_910cd58b1d8df9a0( response );
                return 0;
            }
        }
        else
        {
            return 0;
        }
    }
    
    return 1;
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0xe352073c, Offset: 0x7a5c
// Size: 0x5d
function _killstreakneedslocationselection( killstreakref )
{
    switch ( killstreakref )
    {
        case #"hash_8c766d6477287bb6":
        case #"hash_b4ac3581c343a029":
            return 1;
        case #"hash_634b246c3da5c56f":
            return 0;
        default:
            assertmsg( "<dev string:x19b>" + killstreakref );
            return 0;
    }
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0x1f26ed3b, Offset: 0x7ac1
// Size: 0x30
function _locationselectioninterrupt()
{
    player = self;
    utility::waittill_any_ents( player, "death", level, "game_ended" );
    player notify( #"cancel_location" );
}

// Namespace br_armory_kiosk
// Params 4
// Checksum 0xb7bc695e, Offset: 0x7af9
// Size: 0x1f9
function _handlekillstreakpurchase( itemdata, dropcurrent, droppurchased, var_6432f32bb6fece8b )
{
    player = self;
    player endon( #"disconnect" );
    activateimmediately = getdvarint( @"hash_e516a6aa0d85b36d", 0 );
    
    if ( !activateimmediately )
    {
        player br_pickups::forcegivekillstreak( itemdata.ref, dropcurrent, 1, droppurchased, var_6432f32bb6fece8b );
        function_75dbb34857ca590b( player, itemdata, "killstreak", "br_killstreak_purchased" );
        return;
    }
    
    if ( _killstreakneedslocationselection( itemdata.ref ) )
    {
        var_e90a12eef0296bb0 = player.br_kiosk;
        player function_910cd58b1d8df9a0( 16 );
        player player::_freezecontrols( 1, undefined, "kiosk" );
        player beginlocationselection( 0, 0, "circle_marker", 0, 4 );
        player childthread _locationselectioninterrupt();
        returninfo = player mapselect::waittill_confirm_or_cancel( "confirm_location", "cancel_location" );
        player endlocationselection();
        player player::_freezecontrols( 0, 1, "kiosk" );
        
        if ( isdefined( returninfo ) && returninfo.string == "confirm_location" )
        {
            locationtrace = br::traceselectedmaplocation( returninfo.location );
            player.kstargetlocation = locationtrace[ "position" ];
            usesuccess = player br_pickups::forceusekillstreak( itemdata.ref );
            
            if ( usesuccess )
            {
                function_75dbb34857ca590b( player, itemdata, "killstreak", "br_killstreak_purchased_and_activated" );
            }
        }
        else
        {
            player thread _runpurchasemenu( var_e90a12eef0296bb0 );
        }
        
        return;
    }
    
    player br_pickups::forcegivekillstreak( itemdata.ref, dropcurrent, 1, var_6432f32bb6fece8b );
    usesuccess = player br_pickups::forceusekillstreak( itemdata.ref );
    
    if ( usesuccess )
    {
        function_75dbb34857ca590b( player, itemdata, "killstreak", "br_killstreak_purchased_and_activated" );
    }
}

// Namespace br_armory_kiosk
// Params 4
// Checksum 0xa91d5ca8, Offset: 0x7cfa
// Size: 0x160
function function_9879ed7ad9cc5cce( itemdata, var_c759afb192fb9773, var_32ea837928cb84cf, var_6432f32bb6fece8b )
{
    scriptablename = itemdata.ref;
    proxypickup = spawnstruct();
    proxypickup.scriptablename = scriptablename;
    proxypickup.origin = self.origin;
    proxypickup.count = 1;
    proxypickup.maxcount = level.br_pickups.maxcounts[ scriptablename ];
    proxypickup.stackable = level.br_pickups.stackable[ scriptablename ];
    [ ammo, ammoleft, ammoalt ] = br_gametype_dmz::getdefaultweaponammo( level.br_lootiteminfo[ scriptablename ].fullweaponobj );
    proxypickup.count = ammo * 3;
    proxypickup.countlefthand = ammoleft;
    proxypickup.countalt = ammoalt;
    function_4884b5be535991e5( scriptablename );
    script::demoforcesre( "Removed a br_weapons function as br_weapons is deprecated. Add in common_item system logic instead to handle if this is needed still" );
    function_75dbb34857ca590b( self, itemdata, "weapon" );
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0xddc8a7d3, Offset: 0x7e62
// Size: 0x2e, Type: bool
function function_520e9890f84b9b3()
{
    isinventorydisabled = !br_instance_inventory::function_926a8f8643d34690();
    var_6c1a84ee7d5503b5 = !br_default_inventory::function_b7b8a2d7ac9eb88b();
    return isinventorydisabled && var_6c1a84ee7d5503b5;
}

// Namespace br_armory_kiosk
// Params 2
// Checksum 0x758117b9, Offset: 0x7e99
// Size: 0xc5
function function_fe65760fc0735e62( var_6432f32bb6fece8b, var_8aa41fd8bf475ba3 )
{
    dropstruct = pickups::function_f71dd588dc4f6288();
    fromkiosk = 1;
    
    if ( fromkiosk && isdefined( self.br_kiosk ) && isdefined( self.br_kiosk.dropstruct ) )
    {
        slotindex = self.br_kiosk br_pickups::function_ef8a0f215f5f8b92();
        self.br_kiosk.dropstruct.dropidx = slotindex;
        dropstruct = self.br_kiosk.dropstruct;
    }
    
    br_pickups::dropequipmentinslot( dropstruct, "super", fromkiosk, 1, var_6432f32bb6fece8b, undefined, undefined, undefined, undefined, var_8aa41fd8bf475ba3 );
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0x408235e9, Offset: 0x7f66
// Size: 0x58
function function_2b54c24b2aeb9c5b( var_8aa41fd8bf475ba3 )
{
    fakepickup = spawnstruct();
    fakepickup.scriptablename = var_8aa41fd8bf475ba3;
    fakepickup.count = 1;
    lootid = loot::function_d3e3bcaea591a6a2( var_8aa41fd8bf475ba3 );
    br_default_inventory::additemtobackpack( lootid, fakepickup, undefined, undefined, 1 );
}

// Namespace br_armory_kiosk
// Params 4
// Checksum 0x1a3fddd9, Offset: 0x7fc6
// Size: 0x165
function _handlefieldupgradepurchase( itemdata, var_c759afb192fb9773, var_32ea837928cb84cf, var_6432f32bb6fece8b )
{
    if ( supers_mp::issuperinuse() )
    {
        var_8aa41fd8bf475ba3 = undefined;
        
        foreach ( scriptablename, supername in level.br_pickups.br_lootreference )
        {
            if ( supername == itemdata.ref )
            {
                var_8aa41fd8bf475ba3 = scriptablename;
                break;
            }
        }
        
        if ( isdefined( var_8aa41fd8bf475ba3 ) )
        {
            if ( function_520e9890f84b9b3() )
            {
                function_fe65760fc0735e62( var_6432f32bb6fece8b, var_8aa41fd8bf475ba3 );
            }
            else
            {
                function_2b54c24b2aeb9c5b( var_8aa41fd8bf475ba3 );
            }
            
            function_75dbb34857ca590b( self, itemdata, "fieldUpgrade", "br_field_upgrade_purchased" );
        }
        
        return;
    }
    
    br_pickups::forcegivesuper( itemdata.ref, var_c759afb192fb9773, 1, var_32ea837928cb84cf, var_6432f32bb6fece8b );
    function_75dbb34857ca590b( self, itemdata, "fieldUpgrade", "br_field_upgrade_purchased" );
    
    if ( ( level.allowsupers || supers_mp::function_31f00fe6e0334d03() ) && !var_32ea837928cb84cf )
    {
        supers_mp::givesuperpoints( supers_mp::getsuperpointsneeded(), undefined, undefined, undefined, 1 );
    }
}

// Namespace br_armory_kiosk
// Params 4
// Checksum 0x96a9b22c, Offset: 0x8133
// Size: 0x1a2
function function_e2a4e66bd1b17029( itemdata, var_c759afb192fb9773, var_32ea837928cb84cf, var_6432f32bb6fece8b )
{
    dummydata = spawnstruct();
    purchasesuccess = 0;
    br_gametype_truckwar::function_337995b87b58fe3c();
    
    if ( br_gametype_truckwar::function_fe8835b9f00d3c4d() )
    {
        assert( isdefined( level.br_pickups.br_lootreference[ "<dev string:x1c1>" ] ), "<dev string:x1e4>" );
        dummydata.ref = level.br_pickups.br_lootreference[ "brloot_offhand_advancedvehicledrop" ];
        
        if ( supers_mp::issuperinuse() )
        {
            fakepickup = spawnstruct();
            fakepickup.scriptablename = "brloot_offhand_advancedvehicledrop";
            fakepickup.count = 1;
            lootid = loot::function_d3e3bcaea591a6a2( "brloot_offhand_advancedvehicledrop" );
            br_default_inventory::additemtobackpack( lootid, fakepickup, undefined, undefined, 1 );
        }
        else
        {
            br_pickups::forcegivesuper( dummydata.ref, var_c759afb192fb9773, 1, var_32ea837928cb84cf, var_6432f32bb6fece8b );
            
            if ( ( level.allowsupers || supers_mp::function_31f00fe6e0334d03() ) && !var_32ea837928cb84cf )
            {
                supers_mp::givesuperpoints( supers_mp::getsuperpointsneeded(), undefined, undefined, undefined, 1 );
            }
        }
        
        purchasesuccess = 1;
    }
    else
    {
        dummydata.ref = "veh9_mil_lnd_mrap";
        purchasesuccess = _handlevehiclepurchase( dummydata, var_c759afb192fb9773, 1 );
        
        if ( purchasesuccess )
        {
            thread br_gametype_dmz::showdmzsplash( "truckwar_vehicle_deploying", level.teamdata[ self.team ][ "players" ] );
        }
        else
        {
            thread hud_message::showerrormessage( "MP/VEHICLE_PURCHASE_FAILED" );
        }
    }
    
    return purchasesuccess;
}

// Namespace br_armory_kiosk
// Params 3
// Checksum 0x98443536, Offset: 0x82de
// Size: 0x233, Type: bool
function _handlevehiclepurchase( itemdata, var_c759afb192fb9773, var_fc8dc379a22f172e )
{
    assert( isdefined( self.br_kiosk ), "<dev string:x27c>" );
    
    if ( !vehicle_spawn::can_spawn_vehicle( itemdata.ref, undefined, undefined, "KIOSK" ) )
    {
        return false;
    }
    
    if ( vehicle::is_in_vehicle( 1 ) )
    {
        return false;
    }
    
    isontrain = train_utility::player_standing_on_train();
    spawndata = spawnstruct();
    
    if ( isdefined( self.br_kiosk.vehiclespawn ) )
    {
        spawndata.origin = self.br_kiosk.vehiclespawn.origin;
        spawndata.angles = self.br_kiosk.vehiclespawn.angles;
    }
    
    if ( !isdefined( spawndata.origin ) )
    {
        if ( isontrain )
        {
            spawndata.origin = self.br_kiosk.origin + anglestoforward( self.br_kiosk.angles ) * -150 + ( 0, 0, 60 );
        }
        else
        {
            spawndata.origin = self.br_kiosk.origin + anglestoforward( self.br_kiosk.angles ) * 100 + ( 0, 0, 60 );
        }
    }
    
    if ( !isdefined( spawndata.angles ) )
    {
        spawndata.angles = ( 0, self.br_kiosk.angles[ 1 ] + 90, 0 );
    }
    
    if ( var_fc8dc379a22f172e )
    {
        spawndata.var_c95d646de6b9216c = 1;
        spawndata.disablepopsmoke = 1;
        spawndata.var_5deb24d6fac0806b = 1;
        spawndata.var_be20d52d9ea88e67 = 1;
    }
    
    if ( !vehicle_spawn::function_c49e68f891a06e6f( spawndata.origin, itemdata.ref ) )
    {
        return false;
    }
    
    thread function_29e5da897c7fb1fa( itemdata, spawndata, var_fc8dc379a22f172e );
    return true;
}

// Namespace br_armory_kiosk
// Params 3
// Checksum 0x10ca85c8, Offset: 0x851a
// Size: 0x143
function function_29e5da897c7fb1fa( itemdata, spawndata, var_fc8dc379a22f172e )
{
    level endon( #"game_ended" );
    spawndata.spawntype = "KIOSK";
    
    if ( vehicle_airdrop::can_airdrop( itemdata.ref ) )
    {
        vehicle = vehicle_airdrop::vehicle_airdrop( itemdata.ref, spawndata );
    }
    else
    {
        vehicle = vehicle::spawn( itemdata.ref, spawndata );
    }
    
    if ( var_fc8dc379a22f172e )
    {
        br_gametype_truckwar::function_172dbee6aed28df8( vehicle, self.team, 1 );
        thread br_gametype_truckwar::function_ab3047138def638c( vehicle );
        thread br_gametype_truckwar::function_fb403d7f38efc744( vehicle );
        vehicle setscriptablepartstate( "tag_buystation", "buystation_usable" );
        br_gametype_truckwar::function_5ab4f3006e8c8ff0( self.team );
        thread br_gametype_dmz::showdmzsplash( "truckwar_vehicle_spawn_enabled", level.teamdata[ self.team ][ "alivePlayers" ] );
    }
    
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    vehicle vehicle_spawn::prevent_respawn();
    
    if ( isdefined( self ) )
    {
        newpingindex = calloutmarkerping::function_81aa43aad6e47820( vehicle getentitynumber() );
        vehicle thread calloutmarkerping::function_3c501da3379eca0a( self, newpingindex, [ "death" ], [ "vehicle_owner_update" ] );
    }
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0x30df31a5, Offset: 0x8665
// Size: 0x4a, Type: bool
function function_d1ff77addfcea8d2()
{
    player = self;
    vehicle = player.var_d5168c882218a620;
    
    if ( isdefined( vehicle ) )
    {
        if ( vehicle.health == vehicle.maxhealth )
        {
            return false;
        }
        
        return true;
    }
    
    return false;
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0x6e5e4e2, Offset: 0x86b8
// Size: 0x6c, Type: bool
function function_51cf7c5155f03c09()
{
    player = self;
    vehicle = player.var_d5168c882218a620;
    
    if ( isdefined( vehicle ) )
    {
        if ( isdefined( vehicle.trophyammo ) && isdefined( vehicle.var_ab799260fca86660 ) && vehicle.trophyammo == vehicle.var_ab799260fca86660 )
        {
            return false;
        }
        else
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0x4a5174b0, Offset: 0x872d
// Size: 0x49, Type: bool
function function_f6d3df6bd8daadaf( upgradetype )
{
    player = self;
    vehicle = player.var_d5168c882218a620;
    
    if ( isdefined( vehicle ) )
    {
        if ( vehicle_interact::upgrade_activated( vehicle, upgradetype ) )
        {
            return false;
        }
        else
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_armory_kiosk
// Params 2
// Checksum 0xa6106db, Offset: 0x877f
// Size: 0x1b4, Type: bool
function _handlevehiclerepair( itemdata, var_c759afb192fb9773 )
{
    player = self;
    vehicle = player.var_d5168c882218a620;
    
    if ( isdefined( vehicle ) )
    {
        if ( vehicle.health == vehicle.maxhealth )
        {
            return false;
        }
        
        var_5cc8bd1686cafb31 = getdvarfloat( @"hash_3c1b0adf9da014a0", 0.25 );
        var_7ce4277b31b82c7e = int( vehicle.maxhealth * var_5cc8bd1686cafb31 );
        vehicle vehicle_damage::add_health( var_7ce4277b31b82c7e );
        playsoundatpos( vehicle.origin + ( 0, 0, 20 ), "veh_truckwars_repair" );
        br_gametype_truckwar::function_b685b7bab062d6bd( vehicle );
        
        if ( vehicle.armoractive )
        {
            br_gametype_truckwar::function_e80e774a7affa200( vehicle );
        }
        
        players = teams::getteamdata( self.team, "players" );
        
        foreach ( player in players )
        {
            if ( getdvarint( @"hash_38d15e2d7ddbf066", 1 ) == 1 )
            {
                player damagefeedback::hudicontype( "truckheal" );
            }
            
            player omnvar_utility::setcachedclientomnvar( "ui_br_team_cash_pockets", vehicle.health );
            player omnvar_utility::setcachedclientomnvar( "ui_br_team_cash_banked", vehicle.maxhealth );
        }
        
        return true;
    }
    
    return false;
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0xe6074f66, Offset: 0x893c
// Size: 0x43, Type: bool
function function_d41a3420504e87e5( upgradetype )
{
    player = self;
    vehicle = player.var_d5168c882218a620;
    
    if ( isdefined( vehicle ) )
    {
        vehicle_interact::give_upgrade( vehicle, upgradetype, player );
        return true;
    }
    
    return false;
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0xddf09245, Offset: 0x8988
// Size: 0x54, Type: bool
function function_3d46d0a4b47ce05d( upgradetype )
{
    player = self;
    vehicle = player.var_d5168c882218a620;
    
    if ( isdefined( vehicle ) )
    {
        if ( vehicle_interact::upgrade_activated( vehicle, upgradetype ) )
        {
            return false;
        }
        else
        {
            vehicle_interact::give_upgrade( vehicle, upgradetype, player );
            return true;
        }
    }
    
    return false;
}

// Namespace br_armory_kiosk
// Params 4
// Checksum 0x89c21fa8, Offset: 0x89e5
// Size: 0x55
function function_23440189779263bb( itemdata, var_c759afb192fb9773, var_32ea837928cb84cf, var_6432f32bb6fece8b )
{
    killstreaks::awardkillstreak( itemdata.ref, "other" );
    thread hud_message::showsplash( "br_killstreak_purchased" );
    armorykioskused( 0, undefined, undefined, self );
}

// Namespace br_armory_kiosk
// Params 4
// Checksum 0xefeb6dc6, Offset: 0x8a43
// Size: 0x93
function function_93d2ce2fa6d16631( itemdata, var_c759afb192fb9773, var_32ea837928cb84cf, var_6432f32bb6fece8b )
{
    perkpackage::perkpackage_giveoverridefieldupgrades( itemdata.ref );
    supers_mp::givesuper( itemdata.ref, 1 );
    thread hud_message::showsplash( "br_field_upgrade_purchased" );
    
    if ( ( level.allowsupers || supers_mp::function_31f00fe6e0334d03() ) && !var_32ea837928cb84cf )
    {
        supers_mp::givesuperpoints( supers_mp::getsuperpointsneeded(), undefined, undefined, undefined, 1 );
    }
    
    armorykioskused( 0, undefined, undefined, self );
}

// Namespace br_armory_kiosk
// Params 4
// Checksum 0xde2cbc9f, Offset: 0x8ade
// Size: 0x93
function function_c04a2c586ae015f1( itemdata, var_c759afb192fb9773, var_32ea837928cb84cf, var_6432f32bb6fece8b )
{
    perkpackage::perkpackage_giveoverridefieldupgrades( itemdata.ref );
    supers_mp::givesuper( itemdata.ref, 1 );
    thread hud_message::showsplash( "br_field_upgrade_purchased" );
    
    if ( ( level.allowsupers || supers_mp::function_31f00fe6e0334d03() ) && !var_32ea837928cb84cf )
    {
        supers_mp::givesuperpoints( supers_mp::getsuperpointsneeded(), undefined, undefined, undefined, 1 );
    }
    
    armorykioskused( 0, undefined, undefined, self );
}

// Namespace br_armory_kiosk
// Params 4
// Checksum 0xd4826e8b, Offset: 0x8b79
// Size: 0x6a
function function_a1250ea42f1bf60a( itemdata, dropcurrent, droppurchased, var_6432f32bb6fece8b )
{
    self endon( #"disconnect" );
    perk::giveperk( itemdata.ref );
    function_75dbb34857ca590b( self, itemdata, "perk", itemdata.ref );
    armorykioskused( 0, undefined, undefined, self );
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0x423b4b4a, Offset: 0x8bec
// Size: 0xfe
function function_669a883780182d9b( itemdata )
{
    self endon( #"disconnect" );
    function_75dbb34857ca590b( self, itemdata, "operator_skin" );
    self.operatorcustomization.skinref = tablelookup( "stringtable/operatorskins.csv", 1, itemdata.ref, 0 );
    self.operatorcustomization.head = tablelookup( "stringtable/operatorskins.csv", 1, itemdata.ref, 5 );
    self.operatorcustomization.body = tablelookup( "stringtable/operatorskins.csv", 1, itemdata.ref, 4 );
    
    /#
        logstring( "<dev string:x2ab>" + itemdata.ref + "<dev string:x2cc>" + self.operatorcustomization.head + "<dev string:x2cc>" + self.operatorcustomization.body );
    #/
    
    teams::setmodelfromcustomization();
}

// Namespace br_armory_kiosk
// Params 5
// Checksum 0x5710cb69, Offset: 0x8cf2
// Size: 0x7e
function function_e61881437be9e820( func, itemdata, var_c759afb192fb9773, var_32ea837928cb84cf, var_6432f32bb6fece8b )
{
    level endon( #"game_ended" );
    function_75dbb34857ca590b( self, itemdata, itemdata.type );
    
    if ( !isalive( self ) )
    {
        armorykioskused( 0, undefined, undefined, self );
    }
    
    while ( !isalive( self ) )
    {
        waitframe();
    }
    
    self thread [[ func ]]( itemdata, var_c759afb192fb9773, var_32ea837928cb84cf, var_6432f32bb6fece8b );
}

// Namespace br_armory_kiosk
// Params 3
// Checksum 0x978f0511, Offset: 0x8d78
// Size: 0x17f
function _purchaseloadout( player, loadoutindex, var_c759afb192fb9773 )
{
    defaultloadout = menus::isloadoutindexdefault( loadoutindex );
    loadoutitemdata = undefined;
    
    if ( defaultloadout )
    {
        loadoutitemdata = function_f5050d99c674662( "loadout_default" );
    }
    else
    {
        loadoutitemdata = function_f5050d99c674662( "loadout_custom" );
    }
    
    assert( isdefined( loadoutitemdata ) );
    var_27c2d3f4f5059fab = getdvarint( @"scr_br_loadout_cost_override", 0 );
    
    if ( var_27c2d3f4f5059fab != 0 )
    {
        loadoutitemdata.cost = var_27c2d3f4f5059fab;
    }
    
    var_df4e60b1510caced = _getactualcost( player, loadoutitemdata );
    
    if ( player currency::get_currency_amount( "cash" ) < var_df4e60b1510caced )
    {
        player function_910cd58b1d8df9a0( 3 );
        return;
    }
    
    newclasschoice = menus::getclasschoice( loadoutindex );
    br_analytics::branalytics_inventory_snapshot( self, "purchasing_new_loadout" );
    dropbehind = getdvarint( @"hash_6d746a5b4acee20d", 1 );
    player.pers[ "class" ] = newclasschoice;
    player.class = newclasschoice;
    newclassdata = player class::preloadandqueueclass( newclasschoice );
    br::br_giveselectedclass( player, var_c759afb192fb9773, dropbehind );
    function_75dbb34857ca590b( player, loadoutitemdata, "loadout", "br_loadout_purchased" );
    
    if ( defaultloadout )
    {
        br_analytics::branalytics_kiosk_purchaseitem( self, var_df4e60b1510caced, "defaultLoadout", "loadout_" + loadoutindex );
        return;
    }
    
    br_analytics::branalytics_kiosk_purchaseloadout( self, var_df4e60b1510caced, newclassdata );
}

// Namespace br_armory_kiosk
// Params 2
// Checksum 0xa24c596, Offset: 0x8eff
// Size: 0x7c
function function_4a8e3513ec9fd461( weaponref, attachmentrefs )
{
    itemdata = spawnstruct();
    itemdata.ref = "loadout_primary";
    itemdata.entryref = "loadoutPrimary";
    itemdata.type = "loadout";
    itemdata.cost = function_56342e768e9bc70c( weaponref, attachmentrefs );
    itemdata.firesalediscount = 0;
    return itemdata;
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0x976a92bf, Offset: 0x8f84
// Size: 0x9a
function function_f5050d99c674662( itemref )
{
    foreach ( item in level.br_armory_kiosk.items )
    {
        if ( item.ref == itemref )
        {
            return item;
        }
    }
}

// Namespace br_armory_kiosk
// Params 2
// Checksum 0xe1bee923, Offset: 0x9026
// Size: 0xeb, Type: bool
function function_ea56078d44169b8( player, channel )
{
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    if ( player.armorykioskpurchaseallowed )
    {
        return true;
    }
    else if ( level.var_e298f874f79103ed )
    {
        if ( !player isonground() && !isdefined( player.vehicle ) )
        {
            if ( channel == "br_item_purchase" )
            {
                player function_910cd58b1d8df9a0( 18 );
                return false;
            }
        }
        
        switch ( channel )
        {
            case #"hash_21c87951dc0972dd":
            case #"hash_29076d117d462839":
            case #"hash_482a3d386d85afb8":
            case #"hash_488003205a6f0be9":
            case #"hash_4ef5bb48d3b44264":
            case #"hash_71b29cad01400640":
            case #"hash_b552fe0a04aa5018":
            case #"hash_de1d173000607e3e":
            case #"hash_e9f77d2411926057":
                return true;
        }
    }
    
    return false;
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0xa1de39db, Offset: 0x911a
// Size: 0x1d
function hideobjective( kiosk )
{
    kiosk setscriptablepartstate( "objective", "none" );
}

// Namespace br_armory_kiosk
// Params 2
// Checksum 0x723c43c8, Offset: 0x913f
// Size: 0x85
function showobjective( kiosk, kioskstate )
{
    objectivestate = "active";
    
    if ( isdefined( kioskstate ) )
    {
        switch ( kioskstate )
        {
            case #"hash_b799d1d25a80c481":
                break;
            case #"hash_61f1a95d6bf95699":
                objectivestate = "none";
                break;
            default:
                assertmsg( "<dev string:x2ce>" + kioskstate );
                break;
        }
    }
    
    kiosk setscriptablepartstate( "objective", objectivestate );
}

// Namespace br_armory_kiosk
// Params 2
// Checksum 0xec49158, Offset: 0x91cc
// Size: 0x25f
function function_745b5ca209150658( player, targetweapon )
{
    dropstruct = pickups::function_f71dd588dc4f6288();
    dropstruct.weaponpickups = [];
    dropstruct.equipprimarypickup = undefined;
    dropstruct.dropidx = int( 4 );
    
    if ( getdvarint( @"hash_ac8187887a7808aa", 0 ) )
    {
        dropstruct.dropidx += 9;
    }
    
    foreach ( weapon in player.equippedweapons )
    {
        if ( isweapon( weapon ) && weapon.inventorytype == "primary" && issameweapon( weapon, targetweapon ) )
        {
            if ( br_pickups::shoulddropbrprimary( weapon, player ) )
            {
                ismissionweapon = player br_extract_quest::extract_ismissionweapon( weapon );
                
                if ( !ismissionweapon )
                {
                    if ( getdvarint( @"hash_625378754c018440", 1 ) && isdefined( player.br_kiosk ) )
                    {
                        dropinfo = player function_ec8d40a9fedb2f83( player.br_kiosk, dropstruct );
                    }
                    else
                    {
                        dropinfo = pickups::getitemdroporiginandangles( dropstruct, player.origin, player.angles, player );
                    }
                    
                    pickupent = br_weapons::weaponspawn( weapon, player, dropinfo, 0, 1 );
                    
                    if ( isdefined( pickupent ) )
                    {
                        mainammo = player getweaponammoclip( weapon );
                        leftammo = player getweaponammoclip( weapon, "left" );
                        altammo = 0;
                        
                        if ( weapon.hasalternate )
                        {
                            weaponalt = weapon getaltweapon();
                            
                            if ( br_weapons::br_ammo_type_for_weapon( weaponalt ) != br_weapons::br_ammo_type_for_weapon( weapon ) )
                            {
                                altammo = player getweaponammoclip( weaponalt );
                            }
                        }
                        
                        common_item::items_setitemcount( pickupent, mainammo, leftammo, altammo );
                        dropstruct.weaponpickups[ dropstruct.weaponpickups.size ] = pickupent;
                    }
                }
            }
            
            player inventory_utility::_takeweapon( weapon );
        }
    }
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0x40a6924b, Offset: 0x9433
// Size: 0x226
function _makekioskpurchase( itemdata )
{
    player = self;
    isfiresale = iskioskfiresaleactiveforplayer( player.br_kiosk, player );
    cost = itemdata.cost;
    
    if ( !itemdata.var_8d51203e121463ce )
    {
        cost = _getactualcost( player, itemdata );
    }
    
    assert( player currency::get_currency_amount( "<dev string:x2e5>" ) >= cost );
    
    if ( isfiresale && itemdata.firesalediscount > 0 )
    {
        kioskfiresaledoneforplayer( player.br_kiosk, player );
    }
    
    if ( !( br_gametypes::isfeaturedisabled( #"kioskxp" ) || br_public::isanytutorialorbotpracticematch() ) )
    {
        player thread points::doscoreevent( #"br_kioskBuy", undefined, br::calculatepurchasexp( cost, itemdata.type ) );
    }
    
    if ( cost > 0 )
    {
        player br_plunder::playerplunderkioskpurchase( cost );
    }
    
    if ( !isdefined( level.br_plunder ) )
    {
        level.br_plunder = spawnstruct();
    }
    
    if ( !isdefined( level.br_plunder.kiosk_spent_total ) )
    {
        level.br_plunder.kiosk_spent_total = 0;
    }
    
    level.br_plunder.kiosk_spent_total += cost;
    
    if ( !isdefined( level.br_plunder.kiosk_num_purchases ) )
    {
        level.br_plunder.kiosk_num_purchases = 0;
    }
    
    level.br_plunder.kiosk_num_purchases++;
    response = 1;
    
    if ( itemdata.type == "secondary_victory" )
    {
        response = 2;
    }
    
    if ( itemdata.type != "biometric_scan_keycard" )
    {
        if ( utility::issharedfuncdefined( #"biometricscan", #"updatefreeitemcount" ) )
        {
            [[ utility::getsharedfunc( #"biometricscan", #"updatefreeitemcount" ) ]]( player, -1 );
        }
    }
    
    player function_910cd58b1d8df9a0( response );
    return cost;
}

// Namespace br_armory_kiosk
// Params 5
// Checksum 0x72e01de5, Offset: 0x9662
// Size: 0x1d4
function function_75dbb34857ca590b( player, itemdata, itemtyperef, splashref, quantity )
{
    cashspent = player _makekioskpurchase( itemdata );
    
    if ( !isdefined( quantity ) )
    {
        quantity = 1;
    }
    
    lootid = itemdata.lootid;
    
    if ( !isdefined( lootid ) || lootid == 0 )
    {
        lootid = loot::getlootidfromref( itemdata.ref );
        
        if ( !isdefined( lootid ) || lootid == 0 )
        {
            lootid = loot::function_d3e3bcaea591a6a2( itemdata.ref );
            
            if ( !isdefined( lootid ) )
            {
                lootid = 0;
            }
        }
    }
    
    if ( lootid > 0 )
    {
        method = challenges::function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"loot_method_bitfield", #"loot" ) );
        challenges::reportlootitemevent( player, lootid, undefined, method, quantity );
    }
    
    level notify( "buy_station_cash_spent_" + player.team, player, cashspent );
    var_209fdcce39fd01cf = 0;
    
    if ( !isdefined( player.accessedbuystations ) )
    {
        player.accessedbuystations = [];
    }
    
    if ( !arraycontains( player.accessedbuystations, player.br_kiosk ) )
    {
        player.accessedbuystations[ player.accessedbuystations.size ] = player.br_kiosk;
        var_209fdcce39fd01cf = 1;
    }
    
    if ( isdefined( itemtyperef ) )
    {
        player challenges::onkioskpurchaseitem( itemtyperef, itemdata.ref, lootid, quantity, cashspent, var_209fdcce39fd01cf );
        player function_6f955cd2a89e8d2f( cashspent );
    }
    
    if ( isdefined( itemtyperef ) )
    {
        kiosktype = function_a160f0512ffc87b9( player.br_kiosk );
        br_analytics::branalytics_kiosk_purchaseitem( player, cashspent, itemtyperef, itemdata.ref, kiosktype );
    }
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0xbd73856f, Offset: 0x983e
// Size: 0x83
function function_6f955cd2a89e8d2f( plunderspent )
{
    if ( !isdefined( self.var_d387ddcd9f0d8285 ) || self.var_d387ddcd9f0d8285 == 0 )
    {
        return;
    }
    
    var_25b808a8804c8c71 = self.var_d387ddcd9f0d8285 >= plunderspent ? plunderspent : self.var_d387ddcd9f0d8285;
    self.var_d387ddcd9f0d8285 = max( self.var_d387ddcd9f0d8285 - var_25b808a8804c8c71, 0 );
    
    if ( var_25b808a8804c8c71 > 0 )
    {
        challenges::function_37e945722d6497f3( self, "spend_friends_cash", var_25b808a8804c8c71 );
    }
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0xd1654baf, Offset: 0x98c9
// Size: 0x55
function playerlocationselectinterrupt()
{
    player = self;
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    player endon( #"confirm_location" );
    utility::waittill_any_ents( player, "death", level, "game_ended" );
    player notify( #"cancel_location" );
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0x4d51f3d0, Offset: 0x9926
// Size: 0x11c
function playerhandlecirclepickitem()
{
    self setclientomnvar( "ui_buystation_purchase_response", 1 );
    self setclientomnvar( "ui_buystation_open", 1 );
    self setclientomnvar( "ui_show_tac_map", 1 );
    player::_freezecontrols( 1, undefined, "playerHandleCirclePickItem" );
    self beginlocationselection( 0, 0, "circle_marker", 0, 4 );
    thread playerlocationselectinterrupt();
    returninfo = mapselect::waittill_confirm_or_cancel( "confirm_location", "cancel_location" );
    success = 0;
    self endlocationselection();
    
    if ( isdefined( returninfo ) && returninfo.string == "confirm_location" )
    {
        if ( br_circle::isvalidpointinbounds( returninfo.location, 1 ) )
        {
            locationtrace = br::traceselectedmaplocation( returninfo.location );
            groundorg = locationtrace[ "position" ];
            
            if ( br_circle::isvalidpointinbounds( groundorg, 1 ) )
            {
                thread restartcircleelimination( groundorg );
                success = 1;
            }
            else
            {
                function_910cd58b1d8df9a0( 18 );
            }
        }
    }
    
    player::_freezecontrols( 0, 1, "playerHandleCirclePickItem" );
    self setclientomnvar( "ui_show_tac_map", 0 );
    return success;
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0x7c66afb7, Offset: 0x9a4b
// Size: 0x2d9
function restartcircleelimination( origin )
{
    level endon( #"game_ended" );
    level notify( #"hash_b8108880414dd929" );
    var_ca5818992577e105 = 60;
    var_73da46ba736b4422 = 4;
    var_9aa1d9e6ef1bce90 = -1;
    var_394bdd21c27408d5 = 15;
    startcircledelay = getdvarint( @"hash_5ef97113d77c0835", var_ca5818992577e105 );
    startcircleindex = getdvarint( @"hash_341f671cd388b556", var_73da46ba736b4422 );
    startcircleclosetime = getdvarint( @"hash_b925987adb7fbd3e", var_9aa1d9e6ef1bce90 );
    var_7d82ab3b086dcaed = getdvarint( @"hash_3c88a1d746d97236", var_394bdd21c27408d5 );
    
    /#
        if ( level.script == "<dev string:x2ea>" )
        {
            if ( startcircledelay == var_ca5818992577e105 )
            {
                startcircledelay = 25;
            }
            
            if ( startcircleindex == var_73da46ba736b4422 )
            {
                startcircleindex = 2;
            }
        }
    #/
    
    thread utility::callsharedfunc( #"gametype", #"hash_b8108880414dd929", origin, startcircledelay );
    
    foreach ( player in level.players )
    {
        player hud_message::showsplash( "br_late_circle_soon" );
    }
    
    if ( br_gametypes::isfeaturedisabled( #"circle" ) )
    {
        br_circle::initcirclepoststarttocircleindex( origin, startcircledelay, startcircleindex, startcircleclosetime );
        level.brgametype.disabledfeatures[ "circle" ] = undefined;
    }
    
    if ( br_gametypes::isfeatureenabled( #"allowlatejoiners" ) )
    {
        level.allowlatecomers = 0;
        setnojiptime( 1, 1 );
        setnojipscore( 1, 1 );
    }
    
    var_da44c8911a7e45 = max( 0, startcircledelay - var_7d82ab3b086dcaed );
    wait var_da44c8911a7e45;
    
    foreach ( player in level.players )
    {
        player hud_message::showsplash( "br_late_circle_now" );
    }
    
    var_bcd9298e9e67db91 = startcircledelay - var_da44c8911a7e45;
    wait var_bcd9298e9e67db91;
    
    if ( br_gametypes::isfeaturedisabled( #"teamspectate" ) )
    {
        level thread br_spectate::spectate_init();
        level.brgametype.disabledfeatures[ "teamSpectate" ] = undefined;
    }
    
    if ( br_gametypes::isfeaturedisabled( #"onelife" ) )
    {
        level.disablespawning = 1;
        level.numlives = 1;
    }
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0x6f2f5e0e, Offset: 0x9d2c
// Size: 0x128
function playerhandleredeploy()
{
    self setclientomnvar( "ui_buystation_purchase_response", 1 );
    self setclientomnvar( "ui_buystation_open", 1 );
    self setclientomnvar( "ui_show_tac_map", 1 );
    player::_freezecontrols( 1, undefined, "playerHandleRedeploy" );
    self beginlocationselection( 0, 0, "circle_marker", 0, 4 );
    thread playerlocationselectinterrupt();
    returninfo = mapselect::waittill_confirm_or_cancel( "confirm_location", "cancel_location" );
    success = 0;
    self endlocationselection();
    
    if ( isdefined( returninfo ) && returninfo.string == "confirm_location" )
    {
        if ( br_circle::isvalidpointinbounds( returninfo.location, 1 ) )
        {
            locationtrace = br::traceselectedmaplocation( returninfo.location );
            groundorg = locationtrace[ "position" ];
            
            if ( br_circle::isvalidpointinbounds( groundorg, 1 ) )
            {
                self notify( #"hash_af164706b76a3248" );
                playerredeploy( groundorg );
                success = 1;
            }
            else
            {
                function_910cd58b1d8df9a0( 18 );
            }
        }
    }
    
    player::_freezecontrols( 0, 1, "playerHandleRedeploy" );
    self setclientomnvar( "ui_show_tac_map", 0 );
    return success;
}

// Namespace br_armory_kiosk
// Params 3
// Checksum 0x19110daa, Offset: 0x9e5d
// Size: 0x2d2
function playerredeploy( groundorigin, overrideheight, overrideyaw )
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    var_d235e895ea193b43 = 12000;
    height = overrideheight;
    
    if ( !isdefined( height ) )
    {
        height = var_d235e895ea193b43;
    }
    
    yaw = overrideyaw;
    
    if ( !isdefined( yaw ) )
    {
        yaw = 0;
    }
    
    spawnpoint = spawnstruct();
    spawnpoint.origin = groundorigin + ( 0, 0, height );
    spawnpoint.angles = ( 0, yaw, 0 );
    spawnpoint.height = height;
    streamorigin = player br_spawnrespawn::playerprestreamrespawnorigin( spawnpoint );
    player.forcespawnorigin = streamorigin;
    pre_spawn_delay = 1;
    player br_spawnrespawn::function_1d2f70d591e967bc();
    wait pre_spawn_delay;
    spawnorigin = spawnpoint.origin;
    spawnangles = spawnpoint.angles;
    startorigin = spawnorigin;
    
    if ( isdefined( streamorigin ) )
    {
        startorigin = streamorigin;
    }
    
    player br_spawnrespawn::function_e61300d028a4bd67();
    player br_spawnrespawn::function_4a36121aa04feff4( startorigin, spawnangles );
    linker = spawn( "script_model", startorigin );
    linker setmodel( "tag_origin" );
    linker.angles = spawnangles;
    linker hide();
    linker showtoplayer( player );
    player playerlinktoabsolute( linker, "tag_origin" );
    player player_utility::function_dbe5a52a6654a982();
    player player_utility::function_9d378d725bb4831e( "br_armory_kiosk::playerRedeploy()" );
    player thread br_spawnrespawn::playercleanupentondisconnect( linker );
    waitframe();
    player streamhint::playerwaittillstreamhintcomplete();
    player br_public::playerclearstreamhintorigin();
    
    if ( isdefined( streamorigin ) )
    {
        linker.origin = spawnorigin;
    }
    
    linker playsoundtoplayer( "br_ac130_flyby", player );
    wait 1.5;
    
    if ( !player islinked() )
    {
        player br_spawnrespawn::function_4a36121aa04feff4( spawnorigin, spawnangles );
        
        /#
            script::demoforcesre( "<dev string:x2fa>" + player.name + "<dev string:x302>" );
        #/
    }
    
    player unlink();
    player damage_effects::function_e8cba6f10a4635e9();
    player clearclienttriggeraudiozone( 1 );
    player player_utility::function_b54a1e23734ef07();
    player player_utility::function_4688d689820ff1ed( "br_armory_kiosk::playerRedeploy()" );
    falltime = 0;
    
    if ( isdefined( level.parachutedeploydelay ) )
    {
        falltime = level.parachutedeploydelay;
    }
    
    player.isredeploykeepweapons = 1;
    player thread parachute::startfreefall( falltime, 0, undefined, undefined, 1 );
    player setclientomnvar( "ui_br_transition_type", 0 );
    player setclientomnvar( "ui_show_spectateHud", -1 );
    player br_spawnrespawn::resetplayermovespeedscale();
    wait 0.5;
    player br_spawnrespawn::function_24b79e9319c6f02f();
    waitframe();
    linker delete();
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0xfb0720a7, Offset: 0xa137
// Size: 0xc1
function function_9ab3fce7d09f8e65()
{
    if ( level.br_circle_disabled )
    {
        return level.br_armory_kiosk.scriptables.size;
    }
    
    var_14e4058e0c690419 = 0;
    
    foreach ( kiosk in level.br_armory_kiosk.scriptables )
    {
        if ( br_circle::ispointincurrentsafecircle( kiosk.origin ) )
        {
            var_14e4058e0c690419++;
        }
    }
    
    return var_14e4058e0c690419;
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0xea9e1f67, Offset: 0xa201
// Size: 0xd6
function function_65f58b7fd405d30b()
{
    if ( level.br_armory_kiosk_enabled )
    {
        foreach ( station in getbuystations() )
        {
            currentstate = station getscriptablepartstate( "br_plunder_box" );
            
            if ( currentstate != "disabled" && currentstate != "hidden" )
            {
                if ( !isstartstr( currentstate, "firesale_" ) )
                {
                    newstate = "firesale_" + currentstate;
                    station setscriptablepartstate( "br_plunder_box", newstate );
                }
            }
        }
    }
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0x63491eb3, Offset: 0xa2df
// Size: 0xf4
function function_3317f1328e7e9df3()
{
    if ( level.br_armory_kiosk_enabled )
    {
        foreach ( station in level.br_armory_kiosk.scriptables )
        {
            currentstate = station getscriptablepartstate( "br_plunder_box" );
            
            if ( isstartstr( currentstate, "firesale_" ) )
            {
                splitstr = strtok( currentstate, "_" );
                
                if ( !isdefined( splitstr ) || splitstr.size < 2 )
                {
                    continue;
                }
                
                newstate = splitstr[ splitstr.size - 1 ];
                station setscriptablepartstate( "br_plunder_box", newstate );
            }
        }
    }
}

// Namespace br_armory_kiosk
// Params 0
// Checksum 0x32e645c4, Offset: 0xa3db
// Size: 0xaf
function function_83ef16e2ed3df2d()
{
    foreach ( kiosk in getentitylessscriptablearray( "scriptable_br_plunder_box", #classname ) )
    {
        kiosk.centerbottom = kiosk.origin + rotatevector( ( 12, 0, 0 ), kiosk.angles );
    }
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0xd758f70b, Offset: 0xa492
// Size: 0x63
function function_ff89b391024d8d23( index )
{
    switch ( index )
    {
        case 0:
            return "buy_station_insured_slot_1";
        case 1:
            return "buy_station_insured_slot_2";
        case 2:
            return "buy_station_insured_slot_3";
        default:
            return "buy_station_insured_slot_1";
    }
    
    return "buy_station_insured_slot_1";
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0x76561d85, Offset: 0xa4fe
// Size: 0x1a
function kiosk_lock( kiosk )
{
    kiosk.locked = 1;
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0x859f147c, Offset: 0xa520
// Size: 0x19
function kiosk_unlock( kiosk )
{
    kiosk.locked = 0;
}

// Namespace br_armory_kiosk
// Params 3
// Checksum 0xe5214150, Offset: 0xa541
// Size: 0x148
function function_632676c5b6b918a7( stationsspawned, buystationlocs, poiname )
{
    remainingstations = [];
    
    foreach ( stationloc in buystationlocs )
    {
        if ( isdefined( stationloc.blackmarket ) && int( stationloc.blackmarket ) )
        {
            spawnbuystation( stationloc, stationsspawned );
            stationsspawned++;
            continue;
        }
        
        remainingstations[ remainingstations.size ] = stationloc;
    }
    
    if ( remainingstations.size == 0 )
    {
        return stationsspawned;
    }
    
    numtospawn = randomintrange( level.poi[ poiname ][ "minExtraBuyStations" ], level.poi[ poiname ][ "maxExtraBuyStations" ] + 1 );
    remainingstations = arrayrandomize( remainingstations );
    
    for ( i = 0; i < numtospawn ; i++ )
    {
        if ( !isdefined( remainingstations[ i ] ) )
        {
            continue;
        }
        
        spawnbuystation( remainingstations[ i ], stationsspawned );
        stationsspawned++;
    }
    
    return stationsspawned;
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0x8feec77, Offset: 0xa692
// Size: 0x1d
function kioskemp( data )
{
    disablearmorykiosk( self );
    thread function_61b87feb2e19416f( data );
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0x899b83b2, Offset: 0xa6b7
// Size: 0x245
function function_61b87feb2e19416f( data )
{
    self notify( #"hash_fa29306fcca2aa4b" );
    self endon( #"hash_fa29306fcca2aa4b" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self.isemped = 1;
    
    if ( !self.isdeployablekiosk || getdvarint( @"hash_4f94cb0475db70e9", 0 ) )
    {
        if ( !isdefined( self.temptrigger ) )
        {
            self.temptrigger = spawn( "trigger_radius", self.origin, 0, level.br_armory_kiosk.var_7249d71eaa3b2001 ?? 138, 62 );
            trigger::makeenterexittrigger( self.temptrigger, &function_25ba9b48b9d80812, &function_d41a31b10d7a7586 );
            self.temptrigger.endtime = int( gettime() + utility::function_4b74c15943231980( data.time ) );
            
            if ( isdefined( self.traincar ) )
            {
                self.temptrigger enablelinkto();
                self.temptrigger linkto( self.traincar );
            }
        }
        else if ( isdefined( self.temptrigger.triggerenterents ) )
        {
            self.temptrigger.endtime = int( gettime() + utility::function_4b74c15943231980( data.time ) );
            
            foreach ( player in self.temptrigger.triggerenterents )
            {
                player lower_message::setlowermessageomnvar( "buystation_offline", self.temptrigger.endtime );
            }
        }
    }
    
    wait data.time;
    self [[ self.reactivatefunc ]]( self );
    self.isemped = 0;
    
    if ( self.temptrigger )
    {
        self.temptrigger delete();
    }
}

// Namespace br_armory_kiosk
// Params 2
// Checksum 0x15f441a0, Offset: 0xa904
// Size: 0x91
function function_25ba9b48b9d80812( player, trigger )
{
    self endon( #"hash_fa29306fcca2aa4b" );
    lower_message::setlowermessageomnvar( "buystation_offline", trigger.endtime );
    
    for ( timeleft = utility::function_6f5d2e1f1ff70482( trigger.endtime - gettime() ); isdefined( trigger ) && timeleft > 0 ; timeleft = utility::function_6f5d2e1f1ff70482( trigger.endtime - gettime() ) )
    {
        wait timeleft;
    }
    
    waitframe();
    thread function_d41a31b10d7a7586( player, trigger );
}

// Namespace br_armory_kiosk
// Params 2
// Checksum 0xc0fff08, Offset: 0xa99d
// Size: 0x2d
function function_d41a31b10d7a7586( player, trigger )
{
    lower_message::setlowermessageomnvar( "clear_lower_msg" );
    self notify( #"hash_fa29306fcca2aa4b" );
}

// Namespace br_armory_kiosk
// Params 2
// Checksum 0xab5ce898, Offset: 0xa9d2
// Size: 0x9b
function function_ec8d40a9fedb2f83( kiosk, dropstruct = pickups::function_f71dd588dc4f6288() )
{
    target_direction = self.origin - kiosk.origin;
    yaw = vectortoyaw( target_direction );
    baseangles = ( 0, yaw, 0 );
    slot = br_pickups::function_ef8a0f215f5f8b92();
    thread br_pickups::function_dc6f8ce37163a81();
    dropstruct.dropidx = slot;
    return pickups::getitemdroporiginandangles( dropstruct, self.origin, baseangles, self );
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0xf3e6e9bc, Offset: 0xaa76
// Size: 0x1b3
function function_61424f0e6704e363( buystationindex )
{
    buystationrow = tablelookuprownum( "mp/buyStation/buyStationDefs.csv", 0, buystationindex );
    
    if ( buystationrow == -1 )
    {
        return;
    }
    
    buystationref = tablelookupbyrow( "mp/buyStation/buyStationDefs.csv", buystationrow, 1 );
    
    if ( buystationref == "" )
    {
        return;
    }
    
    setomnvar( "ui_br_quick_buystation", buystationindex );
    
    foreach ( player in level.players )
    {
        if ( isbot( player ) )
        {
            continue;
        }
        
        if ( player br_public::isplayeringulag() )
        {
            continue;
        }
        
        if ( !flags::gameflag( "br_ready_to_jump" ) )
        {
            continue;
        }
        
        player thread hud_message::showsplash( "br_quick_buystation_changed" );
    }
    
    if ( !isdefined( level.buystationsinuse ) )
    {
        level.buystationsinuse = [];
    }
    
    foreach ( buystationdata in level.buystationsinuse )
    {
        if ( buystationdata[ "index" ] == buystationindex )
        {
            return;
        }
    }
    
    level.buystationsinuse[ level.buystationsinuse.size ] = function_ee6c8f3da29a67b9( buystationref );
}

// Namespace br_armory_kiosk
// Params 1
// Checksum 0x2deb018e, Offset: 0xac31
// Size: 0x5f
function function_a160f0512ffc87b9( kiosk )
{
    kiosktype = "standard_kiosk";
    
    if ( isdefined( kiosk ) && kiosk.type == "drone_deployable_kiosk" )
    {
        kiosktype = "deployable_kiosk";
    }
    else if ( level.var_e298f874f79103ed && !isdefined( kiosk ) )
    {
        kiosktype = "cloud_kiosk";
    }
    
    return kiosktype;
}

