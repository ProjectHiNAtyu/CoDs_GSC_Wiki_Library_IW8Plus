// scripts\mp\br\gametypes\br_pickups.gsc  (hash_46c74a41a5ef9f4b.gscc) (size: 114742 Bytes / 0x1c036 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7eec6f94 (2129424276)
// size ...... 114742 (0x1c036)
// includes .. 86  (offset: 0x1ad5e)
// strings ... 256 (offset: 0x1b00e)
// dev strs .. 26  (offset: 0x1bef2)
// exports ... 277 (offset: 0x11a32)
// cseg ...... 0x163b + 0x103f7 (0x11a32)
// imports ... 806 (offset: 0x1457a)
// animtree1 . 0   (offset: 0x1c036)
// animtree2 . 0   (offset: 0x1c036)
#using script_16ea1b94f0f381b3;
#using script_5757e9f873fc5cf3;
#using script_68bfedf2ed730bd;
#using script_68fc38d757ac68d3;
#using script_6962ddc481c4af49;
#using script_70ac8a06d80020b0;
#using script_be7da0439d09064;
#using scripts\common\ae_utility;
#using scripts\common\gasmask;
#using scripts\common\script;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\common\weapon;
#using scripts\mp\armor;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_armory_kiosk;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_default_inventory;
#using scripts\mp\br\gametypes\br_dev;
#using scripts\mp\br\gametypes\br_dmz_inventory;
#using scripts\mp\br\gametypes\br_dom_gulag;
#using scripts\mp\br\gametypes\br_elite_broken_arrow;
#using scripts\mp\br\gametypes\br_extract_quest;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\br\gametypes\br_gametype_truckwar;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_hacker_phone_quest;
#using scripts\mp\br\gametypes\br_headgear;
#using scripts\mp\br\gametypes\br_instance_inventory;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_strongholds;
#using scripts\mp\br\gametypes\br_weapons;
#using scripts\mp\calloutmarkerping_mp;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\common\equipment\disguise;
#using scripts\mp\common\equipment\hb_sensor;
#using scripts\mp\common\equipment\iodine_pills;
#using scripts\mp\common\equipment\nvg;
#using scripts\mp\common\equipment\scuba_gasmask;
#using scripts\mp\common\equipment\throwing_knife_mp;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\white_phosphorus;
#using scripts\mp\common\perks\perkfunctions;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\supers\vehicle_drop;
#using scripts\mp\common\utility\callback_group;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damagefeedback;
#using scripts\mp\dmz\gametypes\dmz_dog_tag;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\gametypes\common;
#using scripts\mp\hud_message;
#using scripts\mp\juggernaut;
#using scripts\mp\laststand;
#using scripts\mp\loot;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_super;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\operator;
#using scripts\mp\overlord;
#using scripts\mp\overseer;
#using scripts\mp\pickups_scriptable;
#using scripts\mp\quickprompt;
#using scripts\mp\supers;
#using scripts\mp\talking_gun;
#using scripts\mp\weapons;

#namespace br_pickups;

// Namespace br_pickups
// Params 0
// Checksum 0x1d288920, Offset: 0x1659
// Size: 0x25
function br_pickups_init()
{
    if ( utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
    {
        br_pickups_init_common_items();
        return;
    }
}

// Namespace br_pickups
// Params 0
// Checksum 0xa82adb88, Offset: 0x1686
// Size: 0x12c
function br_pickups_init_common_items()
{
    level.var_548004405d16dcf8 = &gasmaskon;
    level.var_7518fcc73a6d4676 = &gasmaskoff;
    level.var_a497e1f1038f9d84 = getdvarfloat( @"hash_ba9e8fbf0254be1e", 1 );
    level.var_8939aaad719c1058 = getdvarint( @"hash_3196e3743c6871b2", 3 );
    level.var_c623a0da9f4c58f4 = getdvarfloat( @"hash_27f5f1d2bc0ef94c", 0.75 );
    level.var_2b3191b005b84c0d = getdvarint( @"hash_a75f4828b96da3ab", 40 );
    scuba_gasmask::init();
    level.var_48fc5a6351d1343c = getdvarfloat( @"hash_58805f0cb8978a2a", 0.65 );
    level.var_c87a581cca19993b = getdvarint( @"hash_ff8abba18e62faa0", 22 );
    level.var_d764aadece5d06d5 = getdvarint( @"hash_27fc198432e29f5a", 25 );
    level.var_2b3191b005b84c0d = getdvarint( @"hash_a75f4828b96da3ab", 40 );
    level.var_f5a8200247e32df9 = getdvarint( @"hash_4b287dc805e35339", 5 );
    level.var_75dd11a79fd1bcd = getdvarfloat( @"hash_c5bb640990a524c2", 0.7 );
    function_292925e1e969bb34();
    thread function_f6206bebca918789();
}

// Namespace br_pickups
// Params 0
// Checksum 0x186bdee3, Offset: 0x17ba
// Size: 0x11e
function function_292925e1e969bb34()
{
    index = 0;
    
    foreach ( itemdef in level.var_39aab67cbd4693ef )
    {
        itemtype = itemdef.type;
        
        if ( !isdefined( itemtype ) )
        {
            continue;
        }
        
        var_669e874aa574e40a = itemdef.name;
        
        if ( !isdefined( var_669e874aa574e40a ) )
        {
            continue;
        }
        
        maxstacksize = itemdef.maxstacksize;
        
        if ( !isdefined( maxstacksize ) )
        {
            maxstacksize = 0;
        }
        
        if ( itemtype == #"ammo" )
        {
            if ( !isdefined( level.br_ammo_max ) )
            {
                br_weapons::br_ammo_init();
            }
            
            level.br_ammo_max[ var_669e874aa574e40a ] = maxstacksize;
        }
    }
    
    level.var_39aab67cbd4693ef = undefined;
    level.var_49830aa008637c9c = undefined;
}

// Namespace br_pickups
// Params 0
// Checksum 0xb195dae5, Offset: 0x18e0
// Size: 0x89
function function_a2cae8a7c9363e76()
{
    level.var_fc6e902332b6c551 = [];
    var_912d9a16509f33fb = getdvar( @"weapon_class_groups_for_auto_grab_table", "mp/automatism/weapon_class_groups_for_auto_grab.csv" );
    var_9e26a5b4b5f77693 = tablelookupgetnumrows( var_912d9a16509f33fb );
    
    for ( row = 0; row < var_9e26a5b4b5f77693 ; row++ )
    {
        weaponclass = tablelookupbyrow( var_912d9a16509f33fb, row, 0 );
        groupindex = int( tablelookupbyrow( var_912d9a16509f33fb, row, 1 ) );
        level.var_fc6e902332b6c551[ weaponclass ] = groupindex;
    }
}

// Namespace br_pickups
// Params 0
// Checksum 0xf2922906, Offset: 0x1971
// Size: 0x57
function function_280a908dccbfb380()
{
    if ( isdefined( level.br_standard_loadout ) )
    {
        level.var_f6580548b0ea50af[ "primary" ] = function_a0a9ffa2fff91248( level.br_standard_loadout, "Primary" );
        level.var_f6580548b0ea50af[ "secondary" ] = function_a0a9ffa2fff91248( level.br_standard_loadout, "Secondary" );
    }
}

// Namespace br_pickups
// Params 0
// Checksum 0x4c2e6d3e, Offset: 0x19d0
// Size: 0x11e
function function_5deb3a9e5c2a953f()
{
    level.var_676d872087fa8b61 = [];
    
    if ( level.usegulag )
    {
        assert( isdefined( level.gulagloadouts ) );
        var_cb53d7bc86f9e80d = [];
        var_1169135bf3093491 = getdvar( @"scr_initial_slot_after_gulag_base_weapons_table", "mp/automatism/initial_slot_after_gulag_base_weapons_table.csv" );
        
        if ( tableexists( var_1169135bf3093491 ) )
        {
            rowscount = tablelookupgetnumrows( var_1169135bf3093491 );
            
            for ( row = 0; row < rowscount ; row++ )
            {
                baseweaponname = tablelookupbyrow( var_1169135bf3093491, row, 0 );
                var_cb53d7bc86f9e80d[ row ] = baseweaponname;
            }
            
            count = level.gulagloadouts.size;
            
            for ( index = 0; index < count ; index++ )
            {
                var_97deed8247c28795 = function_a0a9ffa2fff91248( level.gulagloadouts[ index ], "Primary" );
                var_930ef225c8d6dca5 = function_a0a9ffa2fff91248( level.gulagloadouts[ index ], "Secondary" );
                function_3cf4781e1513b4a7( var_97deed8247c28795, var_cb53d7bc86f9e80d );
                function_3cf4781e1513b4a7( var_930ef225c8d6dca5, var_cb53d7bc86f9e80d );
            }
        }
    }
}

// Namespace br_pickups
// Params 2
// Checksum 0xe51a8edd, Offset: 0x1af6
// Size: 0x7f
function function_3cf4781e1513b4a7( weaponobj, var_cb53d7bc86f9e80d )
{
    baseweaponname = weapon::getweaponrootname( weaponobj );
    count = var_cb53d7bc86f9e80d.size;
    
    for ( index = 0; index < count ; index++ )
    {
        if ( var_cb53d7bc86f9e80d[ index ] == baseweaponname && !function_c0483cdb17f0e32d( weaponobj ) )
        {
            level.var_676d872087fa8b61[ level.var_676d872087fa8b61.size ] = weaponobj;
            break;
        }
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0xc2fcc2a5, Offset: 0x1b7d
// Size: 0x61
function function_c0483cdb17f0e32d( weaponobj )
{
    hasweapon = 0;
    count = level.var_676d872087fa8b61.size;
    
    for ( index = 0; !hasweapon && index < count ; index++ )
    {
        hasweapon = issameweapon( level.var_676d872087fa8b61[ index ], weaponobj );
    }
    
    return hasweapon;
}

// Namespace br_pickups
// Params 2
// Checksum 0xd33f5daf, Offset: 0x1be7
// Size: 0x127
function function_a0a9ffa2fff91248( loadout, slotstring )
{
    maxattachments = 0;
    
    if ( slotstring == "Primary" )
    {
        maxattachments = weapon::getmaxprimaryattachments( "wildcard_none" );
    }
    else if ( slotstring == "Secondary" )
    {
        maxattachments = weapon::getmaxsecondaryattachments( "wildcard_none" );
    }
    else
    {
        assertmsg( "<dev string:x24>" + slotstring + "<dev string:x32>" );
    }
    
    basestring = "loadout" + slotstring;
    weaponattachments = [];
    var_17fd4284c6d5b9f = [];
    var_498a24b85741dd03 = basestring + "Attachment";
    var_6627111ff19b06b3 = "";
    
    for ( attachmentindex = 0; attachmentindex < maxattachments ; attachmentindex++ )
    {
        if ( attachmentindex != 0 )
        {
            var_6627111ff19b06b3 = var_498a24b85741dd03 + attachmentindex + 1;
        }
        else
        {
            var_6627111ff19b06b3 = var_498a24b85741dd03;
        }
        
        if ( isdefined( loadout[ var_6627111ff19b06b3 ] ) )
        {
            weaponattachments[ attachmentindex ] = loadout[ var_6627111ff19b06b3 ];
            var_17fd4284c6d5b9f[ attachmentindex ] = 0;
        }
    }
    
    return weapon::buildweapon( loadout[ basestring ], weaponattachments, loadout[ basestring + "Camo" ], loadout[ basestring + "Reticle" ], loadout[ basestring + "VariantID" ], var_17fd4284c6d5b9f );
}

// Namespace br_pickups
// Params 1
// Checksum 0xa04d30f0, Offset: 0x1d17
// Size: 0x6e
function function_6cebf175e5947276( fromkiosk )
{
    if ( fromkiosk )
    {
        level.br_pickups.yawoffsetoverride = br_armory_kiosk::getkioskyawoffsetoverride();
        level.br_pickups.distanceoverride = br_armory_kiosk::function_a2853af26b7307ce();
        return;
    }
    
    level.br_pickups.yawoffsetoverride = undefined;
    level.br_pickups.distanceoverride = undefined;
}

// Namespace br_pickups
// Params 1
// Checksum 0x9ad8a07a, Offset: 0x1d8d
// Size: 0x53
function getfullweaponobjforscriptablepartname( scriptablename )
{
    if ( isdefined( scriptablename ) && isdefined( level.br_lootiteminfo[ scriptablename ] ) && isdefined( level.br_lootiteminfo[ scriptablename ].fullweaponobj ) )
    {
        return level.br_lootiteminfo[ scriptablename ].fullweaponobj;
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0x734edcd5, Offset: 0x1de9
// Size: 0x57
function getfullweaponobjforpickup( pickupent )
{
    if ( isdefined( pickupent ) && isdefined( pickupent.scriptablename ) )
    {
        return getfullweaponobjforscriptablepartname( pickupent.scriptablename );
    }
    
    if ( isdefined( pickupent.type ) )
    {
        return getfullweaponobjforscriptablepartname( pickupent.type );
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0x286a491b, Offset: 0x1e49
// Size: 0xd, Type: bool
function lootusedignore( instance )
{
    return false;
}

// Namespace br_pickups
// Params 8
// Checksum 0x2b85067, Offset: 0x1e5f
// Size: 0x279
function lootused( instance, part, state, player, bautouse, usestring, fromcallback, forcebackpack )
{
    if ( !isdefined( instance ) )
    {
        return;
    }
    
    pickup = spawnstruct();
    pickup.origin = instance.origin;
    pickup.count = common_item::function_44eacd480abb5b94( instance.count );
    pickup.countlefthand = common_item::function_5c3ce1ec7db94488( instance.count );
    pickup.countalt = common_item::function_3b2613fcafd07797( instance.count );
    pickup.instance = instance;
    pickup.customweaponname = instance.customweaponname;
    pickup.maxcount = level.br_pickups.maxcounts[ pickup.scriptablename ];
    pickup.stackable = level.br_pickups.stackable[ pickup.scriptablename ];
    assert( isdefined( pickup.count ) );
    
    if ( !pickup.count && !isgascan( pickup.scriptablename ) && !isgasmask( pickup.scriptablename ) && !ishelmet( pickup.scriptablename ) && !function_e587e310ab3d3b77( pickup.scriptablename ) && isdefined( level.br_pickups.counts[ pickup.scriptablename ] ) )
    {
        pickup.count = level.br_pickups.counts[ pickup.scriptablename ];
    }
    
    pickup.isweaponfromcrate = instance.isweaponfromcrate;
    pickup.isautouse = bautouse;
    pickup.pastteam = instance.pastteam;
    pickup.metadata = instance.metadata;
    return function_5b180b03ffe1dd26( pickup, state, player, bautouse, instance, fromcallback, forcebackpack );
}

// Namespace br_pickups
// Params 4
// Checksum 0xfeb2ed1b, Offset: 0x20e1
// Size: 0x2af, Type: bool
function function_f068be168c3a6776( pickup, player, bautouse, instance )
{
    var_aa9228ec214de084 = function_bb0787b9230d2a4a( pickup.scriptablename );
    var_a8f84208dff21ede = isdefined( pickup.scriptablename ) && pickup br_elite_broken_arrow::function_c67ed81341a99d07();
    var_b8c893bbb6bca5ef = var_aa9228ec214de084 || var_a8f84208dff21ede;
    pickupremains = player onusecompleted( pickup, var_b8c893bbb6bca5ef, bautouse, undefined, undefined, instance );
    
    if ( isdefined( instance ) && pickupremains )
    {
        common_item::items_setitemcount( instance, pickup.count, pickup.countlefthand, pickup.countalt );
    }
    
    if ( player br_public::isplayerinorgoingtogulag() )
    {
        if ( isdefined( player.var_e47f2b0c6f184dcb ) )
        {
            player.var_e47f2b0c6f184dcb += 1;
        }
        
        if ( pickup.scriptablename == "loot_key_gulag" )
        {
            player.var_8c2127ad940d0a2e = 1;
            player.var_245c13045821ff74 = 1;
        }
        
        arena = namespace_a974e4dd85555bc2::function_bc8c8f723d5d7be8( player );
        
        if ( isdefined( pickup.scriptablename ) && pickup.scriptablename != "loot_key_gulag" )
        {
            if ( isdefined( arena ) && isdefined( arena.lootpickedup ) && isdefined( instance ) )
            {
                arena.lootpickedup[ arena.lootpickedup.size ] = instance;
            }
        }
    }
    
    var_42d7e95a4ce22703 = getdvarint( @"hash_920a281ef3740251", 1 );
    
    if ( !isdefined( instance ) || pickupremains && !var_42d7e95a4ce22703 )
    {
        return true;
    }
    
    if ( isplunder( instance.type ) )
    {
        player function_d292cd24cf16d9b0( instance );
    }
    
    if ( !var_aa9228ec214de084 && !function_49be4ae122d13f2e( pickup.scriptablename ) && !instance.var_d56f5d70ad733694 )
    {
        if ( pickupremains && var_42d7e95a4ce22703 )
        {
            dropstruct = pickups::function_f71dd588dc4f6288();
            dropinfo = pickups::getitemdroporiginandangles( dropstruct, player.origin, player.angles, player, undefined, pickup.overridedist, undefined, undefined, pickup.origin );
            spawnpickup( pickup.scriptablename, dropinfo, pickupremains, 1 );
        }
        
        pickups::loothide( instance );
    }
    
    function_abed73c8891ee73c( player, pickup, bautouse, 1 );
    player setclientomnvar( "ui_notify_show_minimal_hud", gettime() );
    return true;
}

// Namespace br_pickups
// Params 1
// Checksum 0x3eab2bd0, Offset: 0x2399
// Size: 0x50
function function_98acc7a7dafe6955( pickup )
{
    if ( isdefined( pickup.customweaponname ) )
    {
        lootid = function_9b4625217723bb22( pickup.customweaponname );
    }
    else
    {
        lootid = loot::function_d3e3bcaea591a6a2( pickup.scriptablename );
    }
    
    return lootid;
}

// Namespace br_pickups
// Params 1
// Checksum 0xf961b54c, Offset: 0x23f2
// Size: 0x11a
function function_de6c2fa53bdb8f87( perks )
{
    bit_width = 8;
    quantity = 0;
    var_33ed632112a7f7cf = 0;
    mask = ( 1 << bit_width ) - 1;
    
    for ( i = 0; i < 4 && i < perks.size ; i++ )
    {
        if ( isdefined( perks[ i ] ) )
        {
            perk = perks[ i ];
        }
        else
        {
            key = "perk" + i + 1;
            perk = perks[ key ];
        }
        
        var_4bdfd1b66f855b16 = i >= 2;
        id = perks::getperkid( perk );
        assert( id <= mask, "<dev string:x58>" + mask );
        shiftindex = var_4bdfd1b66f855b16 ? i - 2 : i;
        shiftedid = ( id & mask ) << shiftindex * bit_width;
        
        if ( var_4bdfd1b66f855b16 )
        {
            var_33ed632112a7f7cf += shiftedid;
            continue;
        }
        
        quantity += shiftedid;
    }
    
    return [ quantity, var_33ed632112a7f7cf ];
}

// Namespace br_pickups
// Params 4
// Checksum 0x774f9d1d, Offset: 0x2515
// Size: 0x195
function function_5cf1430d50947ac0( pickup, player, bautouse, instance )
{
    lootid = function_98acc7a7dafe6955( pickup );
    player onpickuptakenintobackpack( pickup );
    player playpickupfeedback( pickup, bautouse );
    function_abed73c8891ee73c( player, pickup, bautouse, 20 );
    pickupremains = 0;
    
    if ( isdefined( lootid ) )
    {
        if ( pickups::isweaponpickupitem( pickup ) )
        {
            pickup.count = 1;
        }
        
        if ( namespace_5ab67a14d18bea3f::function_e96bd96c3a428bb8( pickup.scriptablename ) )
        {
            if ( namespace_5ab67a14d18bea3f::function_3a6825469c3df4a3() )
            {
                backpackindex = player common_inventory::function_9cfce16f3087291a();
                quantity = 1;
                var_33ed632112a7f7cf = 0;
                
                if ( isdefined( pickup.instance.perks ) )
                {
                    [ quantity, var_33ed632112a7f7cf ] = function_de6c2fa53bdb8f87( pickup.instance.perks );
                }
                
                player common_inventory::inventory_setbackpackitematindex( backpackindex, lootid, quantity );
                
                if ( isdefined( pickup.instance.perks ) )
                {
                    custperks = arraycopy( pickup.instance.perks );
                    player namespace_5ab67a14d18bea3f::function_62b6609bf67a7ad7( backpackindex, custperks );
                }
            }
        }
        else
        {
            player common_inventory::function_d3959596f4031a1d( lootid, pickup.count );
        }
        
        if ( isdefined( instance ) )
        {
            pickups::loothide( instance );
        }
        
        return 1;
    }
}

// Namespace br_pickups
// Params 4
// Checksum 0xb6cb3553, Offset: 0x26b2
// Size: 0x11e
function function_abed73c8891ee73c( player, pickup, bautouse, results )
{
    issuccess = results == 1 || results == 20 || results == 5 || results == 27;
    
    if ( issuccess )
    {
        method = challenges::function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"loot_method_bitfield", #"loot" ) );
        method = challenges::function_a23641f33e985edb( method, ae_utility::function_2d1565a236387b2( #"loot_method_bitfield", #"ground" ) );
        lootid = function_98acc7a7dafe6955( pickup );
        quantity = pickup.count;
        itemneeded = challenges::reportlootitemevent( player, lootid, undefined, method, quantity );
        
        if ( !itemneeded )
        {
            function_93a4e9fbdc83c0d( player, pickup );
        }
        
        if ( !isbrgamemode() )
        {
            function_c184270d1f716161( player, pickup.origin );
        }
        
        player notify( #"looted_item", lootid, quantity, bautouse );
    }
}

// Namespace br_pickups
// Params 2
// Checksum 0x3b6d0296, Offset: 0x27d8
// Size: 0xe1
function function_93a4e9fbdc83c0d( player, pickup )
{
    if ( !( isdefined( player ) && isdefined( pickup ) && isdefined( pickup.scriptablename ) ) )
    {
        return;
    }
    
    scriptablename = pickup.scriptablename;
    
    if ( isplunder( scriptablename ) || isvaluable( scriptablename ) )
    {
        cashvalue = 0;
        
        if ( isdefined( player.plundercount ) )
        {
            cashvalue = player.plundercount;
        }
        
        extracash = player br_dmz_inventory::function_e342ce3749830a35( undefined, 1 );
        
        if ( isdefined( extracash ) )
        {
            cashvalue += extracash;
        }
        
        if ( cashvalue > 1000 )
        {
            if ( br_instance_inventory::function_ba4e5cfedfe04b10( player ) && !overlord::function_b329f59a03497e56( player, "dead_drop_nag" ) )
            {
                overlord::playevent( "dead_drop_nag", [ player ] );
            }
        }
    }
}

// Namespace br_pickups
// Params 2
// Checksum 0x7f08fbe7, Offset: 0x28c1
// Size: 0x22
function function_c184270d1f716161( player, origin )
{
    stealtheventbroadcastsimple( "looted_item", player, origin );
}

// Namespace br_pickups
// Params 1
// Checksum 0x7ac4b9c5, Offset: 0x28eb
// Size: 0x98
function function_105a2d8e9c651e1d( pickup )
{
    if ( br_public::isammo( pickup.scriptablename ) && !getdvarint( @"hash_9d140d98331435ed", 0 ) )
    {
        return 0;
    }
    
    if ( isgametypeitem( pickup.scriptablename ) && utility::issharedfuncdefined( #"gametype", #"hash_e7c2393b1d947b73" ) )
    {
        return utility::callsharedfunc( #"gametype", #"hash_e7c2393b1d947b73", pickup.scriptablename );
    }
    
    return getdvarint( @"hash_15055cb805b43a20", 1 );
}

// Namespace br_pickups
// Params 3
// Checksum 0x51dae4f7, Offset: 0x298c
// Size: 0xb7, Type: bool
function allowautouse( player, pickup, instance )
{
    if ( level.disableautolootpickup )
    {
        return false;
    }
    
    if ( function_105a2d8e9c651e1d( pickup ) && !player function_b82b55355bb1c31f( pickup.scriptablename ) )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_752eeed3ddcbd04b", 0 ) && !player function_d9c41783a16c116f() && player function_b82b55355bb1c31f( pickup.scriptablename ) )
    {
        return false;
    }
    
    if ( br_public::isammo( pickup.scriptablename ) && player common_inventory::function_46997c9dfcd0ef43( pickup.scriptablename ) == 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace br_pickups
// Params 8
// Checksum 0xba52f4be, Offset: 0x2a4c
// Size: 0x5e2
function function_5b180b03ffe1dd26( pickup, state, player, bautouse, instance, fromcallback, forcebackpack, var_b897713b180977f8 )
{
    if ( !isdefined( pickup ) )
    {
        return 0;
    }
    
    if ( player utility::callsharedfunc( #"gametype", #"hash_673db8bb5562ee19", instance, bautouse ) || level.infilcinematicactive )
    {
        return 0;
    }
    
    if ( bautouse && !allowautouse( player, pickup, instance ) )
    {
        return 0;
    }
    
    if ( br_dom_gulag::function_bf5c033346d6e717() && player br_public::isplayerinorgoingtogulag() )
    {
        if ( isdefined( pickup.instance ) && pickup.instance.classname == "scriptable_br_plunder_box" )
        {
            if ( !isdefined( player.var_4d30b739505bbabf ) )
            {
                player.var_4d30b739505bbabf = 0;
            }
            
            player.var_4d30b739505bbabf += 1;
        }
    }
    
    if ( !isdefined( instance ) || instance getscriptableisloot() && !lootusedignore( instance ) )
    {
        results = undefined;
        
        if ( forcebackpack )
        {
            results = 20;
        }
        else
        {
            results = player cantakepickup( pickup, getdvarint( @"hash_8225b8d33c1565c6", 1 ) && !bautouse && !var_b897713b180977f8 );
        }
        
        if ( quickprompt::quickpromptisenabled() )
        {
            if ( results == 1 || results == 20 || results == 5 || results == 27 )
            {
                if ( player calloutmarkerping_mp::function_fa511c27ff3cfada( instance ) )
                {
                    player thread quickprompt::quickpromptshow( 3 );
                }
            }
        }
        
        if ( isgametypeitem( pickup.scriptablename ) && bautouse == 0 && utility::issharedfuncdefined( #"gametype", #"hash_59e42b0d1873d99b" ) )
        {
            if ( utility::callsharedfunc( #"gametype", #"hash_59e42b0d1873d99b", pickup.scriptablename ) )
            {
                results = 1;
            }
        }
        
        if ( results == 1 )
        {
            return function_f068be168c3a6776( pickup, player, bautouse, instance );
        }
        else if ( results == 20 )
        {
            return function_5cf1430d50947ac0( pickup, player, bautouse, instance );
        }
        else if ( results == 5 || results == 27 )
        {
            newweapon = br_weapons::function_e21fbe40c5ae575e( pickup )[ 0 ];
            fakepickup = spawnstruct();
            fakepickup.scriptablename = br_weapons::br_ammo_type_for_weapon( newweapon );
            fakepickup.origin = pickup.origin;
            fakepickup.count = weaponclipsize( newweapon );
            lootresult = 0;
            
            if ( results == 5 )
            {
                lootresult = function_f068be168c3a6776( fakepickup, player );
            }
            else
            {
                lootresult = function_5cf1430d50947ac0( fakepickup, player );
            }
            
            if ( isdefined( instance ) )
            {
                pickups::loothide( instance );
            }
            
            return lootresult;
        }
        else
        {
            if ( getdvarint( @"hash_c031ba1736951fae", 1 ) && results != 28 && results != 2 && results != 10 && results != 9 && results != 13 && results != 33 && results != 35 && results != 11 && results != 16 && results != 8 && results != 36 && results != 7 && results != 37 && results != 39 && player common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) && isdefined( instance ) && !bautouse )
            {
                tmpcontainer = instance;
                tmpcontainer.contents = [];
                tmpcontainer.containertype = 14;
                tmpcontainer.contents[ 0 ] = [];
                tmpcontainer.contents[ 0 ][ "quantity" ] = pickup.count;
                tmpcontainer.contents[ 0 ][ "lootID" ] = loot::function_d3e3bcaea591a6a2( pickup.scriptablename );
                
                if ( function_d1bdfe41ee9800f9( pickup.scriptablename ) )
                {
                    tmpcontainer.contents[ 0 ][ "extraInfoEnt" ] = undefined;
                    tmpcontainer.contents[ 0 ][ "extraInfoTeam" ] = undefined;
                    
                    if ( isdefined( pickup.instance.blacksite ) )
                    {
                        tmpcontainer.contents[ 0 ][ "extraInfoEnt" ] = pickup.instance.blacksite;
                    }
                    
                    if ( isdefined( pickup.instance.originalteam ) )
                    {
                        tmpcontainer.contents[ 0 ][ "extraInfoTeam" ] = pickup.instance.originalteam;
                    }
                }
                
                loot_mp::function_33781f4917f1fcde( player, tmpcontainer );
                return 0;
            }
            
            var_cbb2cd915ec8d0d7 = 1;
            var_882118f217b10a45 = level.br_pickups.br_hasautopickup[ pickup.scriptablename ];
            
            if ( isdefined( bautouse ) && isdefined( var_882118f217b10a45 ) )
            {
                if ( bautouse && var_882118f217b10a45 && state == "visible" )
                {
                    var_cbb2cd915ec8d0d7 = 0;
                }
            }
            
            if ( results == 17 )
            {
                var_cbb2cd915ec8d0d7 = 0;
            }
            
            if ( iscache( pickup.scriptablename ) )
            {
                var_cbb2cd915ec8d0d7 = 0;
            }
            
            if ( isrock( pickup.scriptablename ) )
            {
                var_cbb2cd915ec8d0d7 = 0;
            }
            
            if ( isgametypeitem( pickup.scriptablename ) )
            {
                var_cbb2cd915ec8d0d7 = 0;
            }
            
            if ( results == 41 )
            {
                thread br_hacker_phone_quest::function_65e79827fc9cbdf8( pickup, player );
                var_cbb2cd915ec8d0d7 = 0;
            }
            
            if ( var_cbb2cd915ec8d0d7 )
            {
                if ( results == 3 )
                {
                    player playlocalsound( "weap_ammo_full" );
                }
                else
                {
                    player playlocalsound( "fly_pickup_deny" );
                }
                
                player showuseresultsfeedback( results );
            }
        }
    }
    
    return 0;
}

// Namespace br_pickups
// Params 2
// Checksum 0x37d612b, Offset: 0x3037
// Size: 0x17, Type: bool
function function_6a85ec799fb98a0c( loot, var_21455c7c771abf70 )
{
    return true;
}

// Namespace br_pickups
// Params 8
// Checksum 0x16d180b9, Offset: 0x3057
// Size: 0x3f2, Type: bool
function br_forcegivecustompickupitem( player, scriptablename, var_90916fc4b2724efd, countoverride, fromkiosk, droppurchased, options, autouse )
{
    if ( droppurchased )
    {
        player dropbrcustompickupitem( scriptablename, countoverride, fromkiosk, droppurchased );
        return true;
    }
    
    fakepickup = spawnstruct();
    fakepickup.scriptablename = scriptablename;
    fakepickup.origin = player.origin;
    fakepickup.count = 0;
    fakepickup.maxcount = level.br_pickups.maxcounts[ fakepickup.scriptablename ];
    fakepickup.stackable = level.br_pickups.stackable[ fakepickup.scriptablename ];
    
    if ( fromkiosk && isdefined( player.br_kiosk ) )
    {
        fakepickup.overridedist = distance2d( player.origin, player.br_kiosk.origin ) / 2;
    }
    
    if ( !fakepickup.count && isdefined( level.br_pickups.counts[ fakepickup.scriptablename ] ) )
    {
        fakepickup.count = level.br_pickups.counts[ fakepickup.scriptablename ];
    }
    
    if ( isdefined( countoverride ) )
    {
        fakepickup.count = countoverride;
    }
    
    if ( isdefined( options ) )
    {
        if ( isdefined( options.perks ) )
        {
            fakepickup.perks = arraycopy( options.perks );
        }
    }
    
    results = player cantakepickup( fakepickup, 1 );
    
    if ( results == 1 )
    {
        lootid = loot::function_d3e3bcaea591a6a2( fakepickup.scriptablename );
        
        if ( br_public::isarmorplate( fakepickup.scriptablename ) && player common_inventory::function_7ec5937e3b3d86e0( fakepickup.scriptablename ) )
        {
            equipname = level.br_pickups.br_equipname[ fakepickup.scriptablename ];
            slot = level.equipment.table[ equipname ].defaultslot;
            var_5d963343b3355d92 = player equipment_mp::getequipmentslotammo( slot );
            
            if ( !isdefined( var_5d963343b3355d92 ) )
            {
                var_5d963343b3355d92 = 0;
            }
            
            backpackpickup = spawnstruct();
            backpackpickup.scriptablename = scriptablename;
            backpackpickup.count = fakepickup.count - level.br_pickups.var_3444316dc55e4b0a[ scriptablename ] - var_5d963343b3355d92;
            
            if ( backpackpickup.count > 0 )
            {
                player common_inventory::function_d3959596f4031a1d( lootid, backpackpickup.count );
                fakepickup.count -= backpackpickup.count;
            }
        }
        
        player onusecompleted( fakepickup, var_90916fc4b2724efd, autouse, fromkiosk );
        return true;
    }
    else if ( results == 20 )
    {
        lootid = undefined;
        
        if ( br_public::isammo( fakepickup.scriptablename ) )
        {
            lootid = loot::getlootidfromref( fakepickup.scriptablename );
        }
        else
        {
            lootid = loot::function_d3e3bcaea591a6a2( fakepickup.scriptablename );
        }
        
        if ( isdefined( lootid ) )
        {
            if ( pickups::isweaponpickupitem( fakepickup ) || function_e2035e1b9faa4f6a( fakepickup.scriptablename ) )
            {
                fakepickup.count = 1;
            }
            
            player common_inventory::function_d3959596f4031a1d( lootid, fakepickup.count );
            return true;
        }
    }
    
    return false;
}

// Namespace br_pickups
// Params 3
// Checksum 0x8c94c2b5, Offset: 0x3452
// Size: 0x113
function resetplayerinventory( keeploadout, keeparmor, playerkilled )
{
    iskingslayer = game_utility::getgametype() == "kingslayer";
    self.br_inventory_slots = [];
    
    if ( !br_gametypes::isfeaturedisabled( #"armor" ) )
    {
        if ( !keeparmor )
        {
            armor::breakarmor();
        }
        
        if ( self.insertingarmorplate )
        {
            armor::function_d1a93ae3582cc2da( "reset_player_inventory" );
        }
    }
    
    if ( !keeploadout )
    {
        breakgasmaskbr();
        
        if ( !level.allowsupers )
        {
            resetsuper( playerkilled );
        }
        
        if ( isdefined( self.streakdata ) && !iskingslayer )
        {
            killstreaks::removekillstreak( 1 );
        }
        
        equipment_mp::takeequipment( "primary" );
        equipment_mp::takeequipment( "secondary" );
        equipment_mp::takeequipment( "super" );
        weapons::setlastdroppableweaponobj( level.defaultfist );
        
        if ( namespace_5ab67a14d18bea3f::function_43c57123ed24d409() )
        {
            namespace_5ab67a14d18bea3f::function_9477f4690296f31();
        }
        
        if ( laststand::hasselfrevivetoken() )
        {
            removeselfrevivetoken();
        }
        
        item_weapon::function_e762c26370fb8ad2();
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0x236c8d3b, Offset: 0x356d
// Size: 0x44
function resetsuper( playerkilled )
{
    supers_mp::clearsuper( undefined, undefined, playerkilled );
    equipment_mp::takeequipment( "super" );
    self setclientomnvar( "ui_perk_package_state", 0 );
    thread supers_mp::function_cb3e288a8ed4df3e( 0 );
    br_instance_inventory::function_ba66e7c85bc79054( self, "super" );
}

// Namespace br_pickups
// Params 1
// Checksum 0x736929e7, Offset: 0x35b9
// Size: 0x25
function initplayer( useloadout )
{
    br_weapons::br_ammo_player_clear();
    resetplayerinventory( useloadout );
    level thread function_742c331e82fe7e67( self );
}

// Namespace br_pickups
// Params 1
// Checksum 0x57571128, Offset: 0x35e6
// Size: 0xc5
function function_742c331e82fe7e67( player )
{
    if ( !common_inventory::function_5c64d2b24a8c3e18() || !getdvarint( @"hash_48d4e35a894b5aff", 1 ) )
    {
        return;
    }
    
    player notify( #"watch_backpack_size" );
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player endon( #"watch_backpack_size" );
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        flags::gameflagwait( "prematch_done" );
    }
    
    while ( true )
    {
        if ( isdefined( player.attached_bag ) )
        {
            var_a8cd9ba7be080732 = getbagtypeforplayer( player );
            
            if ( player.var_f54de930992884bf != var_a8cd9ba7be080732 )
            {
                function_97f6f4663f7dd996( player, var_a8cd9ba7be080732 );
            }
        }
        
        wait 1;
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0x45202265, Offset: 0x36b3
// Size: 0x82
function getbagtypeforplayer( player )
{
    var_863f968cc133f52b = player common_inventory::function_715070fe0960df6();
    totalsize = player common_inventory::function_9cd65c8312048802();
    
    if ( totalsize <= 0 )
    {
        return "";
    }
    
    ratio = var_863f968cc133f52b / totalsize;
    bagtype = "";
    
    if ( ratio == 1 )
    {
        bagtype = "bgfull";
    }
    else if ( ratio >= 0.5 )
    {
        bagtype = "bghalf";
    }
    
    return bagtype;
}

// Namespace br_pickups
// Params 2
// Checksum 0x9c3425fc, Offset: 0x373e
// Size: 0x30
function function_97f6f4663f7dd996( player, bagtype )
{
    player setbagtype( getxhash( bagtype ) );
    player.var_f54de930992884bf = bagtype;
}

// Namespace br_pickups
// Params 3
// Checksum 0x839da4ed, Offset: 0x3776
// Size: 0x64
function spawndebugpickupfromdevgui( scriptablename, critical, quantity )
{
    if ( utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
    {
        params = [ scriptablename, undefined, quantity ];
        
        /#
            common_item::devgui_spawn_item( params );
        #/
        
        return;
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0x5a173bbe, Offset: 0x37e2
// Size: 0x135
function function_79e841e11b415079( skipweapons )
{
    size = level.br_pickups.br_value.size;
    rows = sqrt( size );
    spos = level.players[ 0 ].origin;
    curindex = 0;
    
    foreach ( index, value in level.br_pickups.var_2e379e316c36bf4a )
    {
        if ( skipweapons && pickups::isweaponpickup( index ) )
        {
            continue;
        }
        
        curindex += 1;
        dropinfo = pickups::getitemdropinfo( spos + ( 20 * curindex % rows, 20 * int( curindex / rows ), 0 ) );
        item = spawnpickup( index, dropinfo, 1 );
    }
}

// Namespace br_pickups
// Params 0
// Checksum 0xb7f56d95, Offset: 0x391f
// Size: 0x1cf
function function_aa23d7c84f09683f()
{
    allcaches = [];
    
    foreach ( scriptablename, type in level.br_pickups.br_itemtype )
    {
        if ( type == #"cache" && ( scriptablename == "dmz_crate_wood" || issubstr( scriptablename, "br_loot" ) ) )
        {
            allcaches[ allcaches.size ] = scriptablename;
        }
    }
    
    size = allcaches.size;
    rows = sqrt( size );
    spos = level.players[ 0 ].origin;
    curindex = 0;
    
    foreach ( scriptable in allcaches )
    {
        curindex += 1;
        dropinfo = pickups::getitemdropinfo( spos + ( 60 * curindex % rows, 60 * int( curindex / rows ), 0 ) );
        item = spawnpickup( scriptable, dropinfo, 1 );
        
        if ( isdefined( item ) && item getscriptablehaspart( "body" ) )
        {
            item setscriptablepartstate( "body", "closed_usable" );
        }
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0xe3bb7eac, Offset: 0x3af6
// Size: 0x7c
function takearmorpickup( pickupent )
{
    armorperkname = level.br_pickups.br_equipname[ pickupent.scriptablename ];
    armorbetter = armor::function_df826fddef9a9e3f( armorperkname );
    
    if ( armorbetter )
    {
        tryequiparmor( pickupent );
    }
    
    level notify( "picked_up_item_" + pickupent.scriptablename + "_" + self.team, self );
}

// Namespace br_pickups
// Params 5
// Checksum 0xd3fa6df7, Offset: 0x3b7a
// Size: 0x2e8
function function_4dbd2dcc3564d964( pickupent, bautouse, var_6432f32bb6fece8b, backpackequip, fromkiosk )
{
    lootid = loot::function_d3e3bcaea591a6a2( pickupent.scriptablename );
    var_e96bd96c3a428bb8 = namespace_5ab67a14d18bea3f::function_e96bd96c3a428bb8( pickupent.scriptablename );
    pickupremains = 0;
    hasperkpack = isdefined( self.var_24633d8241ca5c23 ) && isdefined( self.var_24633d8241ca5c23.var_3cb7bc08e98113e2 );
    equippack = bautouse || backpackequip || !hasperkpack || !isdefined( var_6432f32bb6fece8b ) && !isdefined( backpackequip ) || fromkiosk;
    var_36e39478517a892 = common_inventory::function_7ec5937e3b3d86e0( pickupent.scriptablename ) && common_inventory::function_e332683b9ad5368b( lootid, pickupent.count );
    var_3eb107e33ba8d81c = var_36e39478517a892 && !equippack;
    stowexisting = fromkiosk && var_36e39478517a892 && hasperkpack;
    dropexisting = equippack && hasperkpack && !backpackequip && !stowexisting;
    targetent = pickupent;
    var_b8db655bb2c8a098 = hasperkpack ? namespace_5ab67a14d18bea3f::function_e96bd96c3a428bb8( self.var_24633d8241ca5c23.var_3cb7bc08e98113e2 ) : 0;
    perks = namespace_5ab67a14d18bea3f::function_6e89cf28e8010430();
    
    if ( equippack || var_3eb107e33ba8d81c )
    {
        currentlootid = undefined;
        
        if ( hasperkpack )
        {
            currentlootid = loot::function_d3e3bcaea591a6a2( self.var_24633d8241ca5c23.var_3cb7bc08e98113e2 );
        }
        
        if ( stowexisting )
        {
            index = common_inventory::function_9cfce16f3087291a();
            
            if ( isdefined( index ) )
            {
                if ( namespace_5ab67a14d18bea3f::function_e96bd96c3a428bb8( self.var_24633d8241ca5c23.var_3cb7bc08e98113e2 ) )
                {
                    namespace_5ab67a14d18bea3f::function_62b6609bf67a7ad7( index, self.var_24633d8241ca5c23.perks );
                }
                
                common_inventory::inventory_setbackpackitematindex( index, currentlootid, 1 );
                namespace_5ab67a14d18bea3f::function_9477f4690296f31();
                hasperkpack = 0;
                currentlootid = undefined;
            }
            else if ( hasperkpack )
            {
                dropexisting = 1;
            }
        }
        
        namespace_5ab67a14d18bea3f::function_d9e5280cbe50ff06( targetent, dropexisting, bautouse, var_6432f32bb6fece8b, backpackequip );
        
        if ( isdefined( currentlootid ) && backpackequip && hasperkpack )
        {
            quantity = 1;
            var_33ed632112a7f7cf = 0;
            
            if ( var_b8db655bb2c8a098 && isdefined( perks ) )
            {
                [ quantity, var_33ed632112a7f7cf ] = function_de6c2fa53bdb8f87( perks );
            }
            
            common_inventory::function_728f03d326a6e4e8( self, var_6432f32bb6fece8b, currentlootid, quantity, 1, 6, var_33ed632112a7f7cf );
        }
        else if ( backpackequip && !hasperkpack )
        {
            quantity = 1;
            
            if ( var_e96bd96c3a428bb8 )
            {
                quantity = common_inventory::inventory_getquantityatbackpackindex( var_6432f32bb6fece8b );
            }
            
            common_inventory::function_4f226d9d5d61901e( var_6432f32bb6fece8b, quantity );
        }
    }
    else
    {
        pickupremains = 1;
    }
    
    return pickupremains;
}

// Namespace br_pickups
// Params 4
// Checksum 0xba044913, Offset: 0x3e6b
// Size: 0x5a2
function takeequipmentpickup( pickupent, fromkiosk, var_6432f32bb6fece8b, backpackequip )
{
    equipname = level.br_pickups.br_equipname[ pickupent.scriptablename ];
    slot = level.equipment.table[ equipname ].defaultslot;
    lootid = loot::function_d3e3bcaea591a6a2( pickupent.scriptablename );
    pickupremains = 0;
    
    if ( pickupissameasequipmentslot( equipname, slot ) )
    {
        if ( equipmentslothasroom( pickupent.scriptablename, slot ) )
        {
            currentslotammo = equipment_mp::getequipmentslotammo( slot );
            var_10dde5538f1daae6 = equipment_mp::getequipmentmaxammo( equipname );
            
            if ( currentslotammo == 0 && pickupent.count > 0 )
            {
                br_instance_inventory::function_b1116f6c1b474c9c( self, slot, lootid );
            }
            
            if ( currentslotammo + pickupent.count > var_10dde5538f1daae6 )
            {
                var_d395b032111261c8 = var_10dde5538f1daae6 - currentslotammo;
                equipment_mp::setequipmentammo( equipname, var_10dde5538f1daae6 );
                pickupent.count -= var_d395b032111261c8;
                pickupremains = pickupent.count;
            }
            else
            {
                equipment_mp::incrementequipmentslotammo( slot, pickupent.count );
            }
            
            if ( common_inventory::function_5c64d2b24a8c3e18() && equipname == "equip_throwing_knife" && !isdefined( self.perks[ "specialty_equip_throwingKnife" ] ) )
            {
                throwing_knife_mp::throwing_knife_mp_ongive( equipname );
            }
            
            if ( isdefined( var_6432f32bb6fece8b ) )
            {
                common_inventory::inventory_setbackpackitematindex( var_6432f32bb6fece8b, -1 * ( var_10dde5538f1daae6 - currentslotammo ) );
                pickupremains = 0;
            }
            
            if ( pickupremains && common_inventory::function_7ec5937e3b3d86e0( pickupent.scriptablename ) && !isdefined( var_6432f32bb6fece8b ) && function_9218c8b00d4e2c3b() )
            {
                lootid = loot::function_d3e3bcaea591a6a2( pickupent.scriptablename );
                common_inventory::inventory_setbackpackitematindex( lootid, pickupent.count );
                pickupremains = 0;
            }
        }
        else if ( common_inventory::function_7ec5937e3b3d86e0( pickupent.scriptablename ) && !backpackequip && function_9218c8b00d4e2c3b() )
        {
            lootid = loot::function_d3e3bcaea591a6a2( pickupent.scriptablename );
            common_inventory::inventory_setbackpackitematindex( lootid, pickupent );
            pickupremains = 0;
        }
    }
    else if ( !isdefined( self.equipment[ slot ] ) || equipment_mp::getequipmentslotammo( slot ) == 0 )
    {
        var_10dde5538f1daae6 = equipment_mp::getequipmentmaxammo( equipname );
        equipment_mp::giveequipment( equipname, slot );
        
        if ( pickupent.count > var_10dde5538f1daae6 )
        {
            var_d395b032111261c8 = var_10dde5538f1daae6;
            equipment_mp::setequipmentammo( equipname, var_10dde5538f1daae6 );
            pickupent.count -= var_d395b032111261c8;
            pickupremains = pickupent.count;
        }
        else
        {
            equipment_mp::setequipmentammo( equipname, pickupent.count );
        }
        
        if ( pickupremains && common_inventory::function_7ec5937e3b3d86e0( pickupent.scriptablename ) && function_9218c8b00d4e2c3b() )
        {
            lootid = loot::function_d3e3bcaea591a6a2( pickupent.scriptablename );
            common_inventory::inventory_setbackpackitematindex( lootid, pickupent );
            pickupremains = 0;
        }
        
        if ( isdefined( var_6432f32bb6fece8b ) )
        {
            var_8d0ff9054f43f969 = br_instance_inventory::function_5755958875a31ff8( slot );
            common_inventory::function_ff587618cdad1d01( self, var_6432f32bb6fece8b, var_8d0ff9054f43f969 );
        }
        else
        {
            br_instance_inventory::function_b1116f6c1b474c9c( self, slot, lootid );
        }
    }
    else if ( common_inventory::function_7ec5937e3b3d86e0( pickupent.scriptablename ) && !isdefined( var_6432f32bb6fece8b ) && function_9218c8b00d4e2c3b() )
    {
        lootid = loot::function_d3e3bcaea591a6a2( pickupent.scriptablename );
        
        if ( common_inventory::function_e332683b9ad5368b( lootid, pickupent.count ) )
        {
            var_f7e41c4e8421f7d3 = function_f02c63b99c9614c9( level.br_pickups.br_equipname, self.equipment[ slot ] );
            lootid = loot::function_d3e3bcaea591a6a2( var_f7e41c4e8421f7d3 );
            ammocount = equipment_mp::getequipmentslotammo( slot );
            fakepickup = spawnstruct();
            fakepickup.scriptablename = var_f7e41c4e8421f7d3;
            fakepickup.count = ammocount;
            
            if ( isdefined( pickupent.overridedist ) )
            {
                fakepickup.overridedist = pickupent.overridedist;
            }
            
            common_inventory::inventory_setbackpackitematindex( lootid, fakepickup );
            equipment_mp::giveequipment( equipname, slot );
            equipment_mp::setequipmentammo( equipname, pickupent.count );
            pickupremains = 0;
        }
        else
        {
            dropstruct = pickups::function_f71dd588dc4f6288();
            dropequipmentinslot( dropstruct, slot, fromkiosk, undefined, var_6432f32bb6fece8b, undefined, undefined, undefined, pickupent );
            equipment_mp::giveequipment( equipname, slot );
            equipment_mp::setequipmentammo( equipname, pickupent.count );
            pickupremains = 0;
        }
        
        br_instance_inventory::function_b1116f6c1b474c9c( self, slot, lootid );
    }
    else
    {
        if ( isdefined( var_6432f32bb6fece8b ) )
        {
            if ( pickupent.maxcount == 0 )
            {
                pickupent.maxcount = level.br_pickups.var_3444316dc55e4b0a[ pickupent.scriptablename ];
            }
            
            newamount = min( pickupent.maxcount, pickupent.count );
            common_inventory::inventory_setbackpackitematindex( var_6432f32bb6fece8b, -1 * newamount );
            br_instance_inventory::function_ba66e7c85bc79054( self, slot );
        }
        
        if ( !level.drop_item_disabled )
        {
            dropstruct = pickups::function_f71dd588dc4f6288();
            dropequipmentinslot( dropstruct, slot, fromkiosk, undefined, var_6432f32bb6fece8b, undefined, undefined, undefined, pickupent );
        }
        
        equipment_mp::giveequipment( equipname, slot );
        equipment_mp::setequipmentammo( equipname, pickupent.count );
        br_instance_inventory::function_b1116f6c1b474c9c( self, slot, lootid );
    }
    
    return pickupremains;
}

// Namespace br_pickups
// Params 10
// Checksum 0x2862dfcc, Offset: 0x4416
// Size: 0x42a
function dropequipmentinslot( dropstruct, slot, fromkiosk, ammocountoverride, var_6432f32bb6fece8b, allowautopickup, itemtype, dropfeedback, pickup, var_c5a0a9e1ab68623b )
{
    ammocount = equipment_mp::getequipmentslotammo( slot );
    
    if ( slot == "super" )
    {
        if ( supers_mp::function_31f00fe6e0334d03() && supers_mp::issuperready() )
        {
            ammocount = 1;
        }
        else if ( supers_mp::isusingsuperweapon() )
        {
            ammocount = supers_mp::function_9e6dc95ca52d8e3f();
        }
    }
    
    if ( isdefined( ammocountoverride ) )
    {
        ammocount = ammocountoverride;
    }
    
    if ( !isdefined( allowautopickup ) )
    {
        allowautopickup = 1;
    }
    
    if ( ammocount <= 0 )
    {
        return;
    }
    
    oldequip = self.equipment[ slot ];
    scriptablename = level.br_pickups.br_equipnametoscriptable[ oldequip ];
    
    if ( isdefined( scriptablename ) && isdefined( level.br_pickups.overridedroploot[ scriptablename ] ) )
    {
        oldequip = level.br_pickups.overridedroploot[ scriptablename ];
    }
    
    var_f7e41c4e8421f7d3 = function_f02c63b99c9614c9( level.br_pickups.br_equipname, oldequip );
    
    if ( isdefined( var_c5a0a9e1ab68623b ) )
    {
        var_f7e41c4e8421f7d3 = var_c5a0a9e1ab68623b;
    }
    
    scriptablename = level.br_pickups.br_equipnametoscriptable[ oldequip ];
    
    if ( level.br_pickups.var_5a2c1bedb1a1e9e[ scriptablename ] )
    {
        return;
    }
    
    if ( isdefined( var_f7e41c4e8421f7d3 ) )
    {
        function_6cebf175e5947276( fromkiosk );
        
        if ( isdefined( var_6432f32bb6fece8b ) )
        {
            lootid = loot::function_d3e3bcaea591a6a2( var_f7e41c4e8421f7d3 );
            common_inventory::function_c620a110c81af8f6( lootid, ammocount );
            return;
        }
        
        var_48757da99828d5d8 = 0;
        lootid = loot::function_d3e3bcaea591a6a2( var_f7e41c4e8421f7d3 );
        scriptablename = common_inventory::function_a7a3fe2f2b6b7582( lootid );
        
        if ( isdefined( itemtype ) )
        {
            var_48757da99828d5d8 = quickdropaddtoexisting( itemtype, scriptablename, ammocount );
        }
        
        if ( var_48757da99828d5d8 )
        {
            return;
        }
        
        overridedist = undefined;
        overrideorigin = undefined;
        
        if ( isdefined( pickup ) )
        {
            if ( isdefined( pickup.distanceoverride ) )
            {
                overridedist = pickup.distanceoverride;
            }
            
            if ( isdefined( pickup.origin ) )
            {
                overrideorigin = pickup.origin;
            }
        }
        
        baseorigin = self.origin;
        baseangles = self.angles;
        yawoffsetoverride = level.br_pickups.yawoffsetoverride;
        
        if ( fromkiosk && isdefined( self.br_kiosk ) )
        {
            baseorigin = self.br_kiosk.centerbottom ?? self.br_kiosk.origin;
            baseangles = self.br_kiosk.angles;
            yawoffsetoverride = undefined;
            
            if ( isdefined( self.br_kiosk.linkedparent ) )
            {
                baseorigin = self.br_kiosk.linkedparent.origin + rotatevector( baseorigin, self.br_kiosk.linkedparent.angles );
            }
        }
        
        dropinfo = pickups::getitemdroporiginandangles( dropstruct, baseorigin, baseangles, self, yawoffsetoverride, overridedist, undefined, undefined, overrideorigin );
        
        if ( issuperpickup( scriptablename ) )
        {
            allowautopickup = getdvarint( @"hash_8c7fd24cb9dc68f0", 0 ) || allowautopickup && isalive( self );
        }
        
        item = spawnpickup( var_f7e41c4e8421f7d3, dropinfo, ammocount, 1, undefined, allowautopickup );
        quickdropaddtocache( scriptablename, slot, item, dropinfo.origin, dropinfo.angles );
        function_7a45cbf285d2f3af( item );
        
        if ( dropfeedback )
        {
            quickdropplaysound( itemtype, dropinfo.origin, scriptablename, item );
        }
        
        var_4867f7de397e8d04 = equipment_mp::getcallback( self.equipment[ slot ], "onDropped" );
        
        if ( isdefined( var_4867f7de397e8d04 ) )
        {
            self thread [[ var_4867f7de397e8d04 ]]( self.equipment[ slot ], slot );
        }
        
        br_instance_inventory::function_ba66e7c85bc79054( self, slot );
    }
}

// Namespace br_pickups
// Params 2
// Checksum 0x5023275d, Offset: 0x4848
// Size: 0x2b, Type: bool
function pickupissameasequipmentslot( equipname, equipmentslot )
{
    if ( self.equipment[ equipmentslot ] == equipname )
    {
        return true;
    }
    
    return false;
}

// Namespace br_pickups
// Params 2
// Checksum 0x61a2c642, Offset: 0x487c
// Size: 0x56, Type: bool
function equipmentslothasroom( scriptablename, equipmentslot )
{
    equip_ref = level.br_pickups.br_equipname[ scriptablename ];
    
    if ( isdefined( equip_ref ) && equipment_mp::getequipmentslotammo( equipmentslot ) < equipment_mp::getequipmentmaxammo( equip_ref ) )
    {
        return true;
    }
    
    return false;
}

// Namespace br_pickups
// Params 2
// Checksum 0x617cc2e5, Offset: 0x48db
// Size: 0xa9, Type: bool
function function_c4311096810e3207( lootname, var_4893becb9275a57c )
{
    lootid = loot::function_d3e3bcaea591a6a2( lootname );
    currentitemcount = common_inventory::function_99741e85ee9c3d18( lootid );
    itemstackcount = 0;
    maxcount = level.br_pickups.var_3444316dc55e4b0a[ lootname ];
    
    if ( !isdefined( maxcount ) || maxcount == 0 )
    {
        maxcount = level.br_pickups.maxcounts[ lootname ];
    }
    
    if ( maxcount > 0 )
    {
        itemstackcount = floor( currentitemcount / maxcount );
    }
    
    if ( itemstackcount >= var_4893becb9275a57c )
    {
        return false;
    }
    
    return true;
}

// Namespace br_pickups
// Params 1
// Checksum 0x1ce2f000, Offset: 0x498d
// Size: 0x2b, Type: bool
function takerespawntokenpickup( pickupent )
{
    if ( namespace_9d8e359c3b1041e5::respawntokendisabledsharedfunc() )
    {
        return false;
    }
    
    if ( br_public::function_f8e966575e96628e() )
    {
        return false;
    }
    
    addrespawntoken();
    return true;
}

// Namespace br_pickups
// Params 1
// Checksum 0x980e6ce6, Offset: 0x49c1
// Size: 0xd5
function addrespawntoken( skipsplash )
{
    player = self;
    
    if ( player br_public::function_2d9074b461a9f5cb() )
    {
        if ( player br_public::function_f8e966575e96628e() )
        {
            return;
        }
        
        if ( !isdefined( player.var_ccf5a598b0d5582e ) || player.var_ccf5a598b0d5582e < 0 )
        {
            player.var_ccf5a598b0d5582e = 0;
        }
        
        player.var_ccf5a598b0d5582e += 1;
        player br_public::updatebrscoreboardstat( "numRespawnToken", player.var_ccf5a598b0d5582e );
    }
    else
    {
        assert( !player.hasrespawntoken );
    }
    
    player.hasrespawntoken = 1;
    player br_public::sethasrespawntokenextrainfo( 1 );
    
    if ( !skipsplash )
    {
        player thread hud_message::showsplash( "br_respawn_token_pickup" );
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0x92704feb, Offset: 0x4a9e
// Size: 0x80, Type: bool
function function_488496dfbfb6c990( pickupent )
{
    if ( !br_public::function_b648dc1bd1363daf() && level.usegulag )
    {
        if ( !br_public::function_70c1f4b75530023f() )
        {
            function_bddc9eed420437d8();
            return true;
        }
        
        if ( common_inventory::function_7ec5937e3b3d86e0( pickupent.scriptablename ) )
        {
            lootid = loot::function_d3e3bcaea591a6a2( pickupent.scriptablename );
            common_inventory::function_d3959596f4031a1d( lootid, pickupent.count );
            return true;
        }
    }
    
    return false;
}

// Namespace br_pickups
// Params 1
// Checksum 0x79ceb08b, Offset: 0x4b27
// Size: 0x5a
function function_bddc9eed420437d8( skipsplash )
{
    player = self;
    assert( !player.var_70c1f4b75530023f );
    player.var_70c1f4b75530023f = 1;
    player br_public::function_99e432af35c80c99( 1 );
    
    if ( !skipsplash )
    {
        player thread hud_message::showsplash( "br_gulag_token_pickup" );
    }
}

// Namespace br_pickups
// Params 3
// Checksum 0xf428941, Offset: 0x4b89
// Size: 0x76, Type: bool
function takerevivepickup( pickupent, itemslotindex, backpackequip )
{
    if ( !laststand::hasselfrevivetoken() || laststand::hasselfrevivetoken() && !br_public::function_69153dc21f82c59a( self, pickupent.scriptablename ) )
    {
        revivelootid = loot::getlootidfromref( pickupent.scriptablename );
        addselfrevivetoken( undefined, revivelootid, itemslotindex, backpackequip );
        return true;
    }
    
    return false;
}

// Namespace br_pickups
// Params 1
// Checksum 0xd7e75101, Offset: 0x4c08
// Size: 0x5a, Type: bool
function function_6dadaf2d40ccdfc1( pickupent )
{
    player = self;
    
    if ( !isdefined( player.var_1f2e1a5f16aaebf6 ) )
    {
        player.var_1f2e1a5f16aaebf6 = [];
    }
    
    player.var_1f2e1a5f16aaebf6[ player.var_1f2e1a5f16aaebf6.size ] = pickupent.scriptablename;
    return true;
}

// Namespace br_pickups
// Params 4
// Checksum 0x717236f2, Offset: 0x4c6b
// Size: 0x205
function function_19f92529593d1af9( skipsplash, revivelootid, itemslotindex, backpackequip )
{
    player = self;
    
    if ( !common_item::items_isenabled() )
    {
        scriptablename = loot::getScriptableFromLootID( revivelootid );
        
        if ( player laststand::hasselfrevivetoken() && !br_public::function_69153dc21f82c59a( player, scriptablename ) )
        {
            if ( backpackequip && isdefined( itemslotindex ) )
            {
                var_a0f2bf7c1de8df2b = br_public::function_a62f204c9c901e6f( player );
                lootid = loot::function_d3e3bcaea591a6a2( var_a0f2bf7c1de8df2b );
                common_inventory::function_728f03d326a6e4e8( player, itemslotindex, lootid, 1, 65535, 3 );
                player removeselfrevivetoken();
            }
            else
            {
                dropstruct = pickups::function_f71dd588dc4f6288();
                player dropbrselfrevivetoken( dropstruct );
            }
        }
        else if ( backpackequip && isdefined( itemslotindex ) )
        {
            player common_inventory::function_4f226d9d5d61901e( itemslotindex );
        }
    }
    
    player.selfrevivedata = spawnstruct();
    player.selfrevivedata.name = scriptablename;
    player.selfrevivedata.type = br_public::function_f448cf07ef04a61b( scriptablename );
    player.selfrevivedata.perk = br_public::function_232a41fcb87530a7( scriptablename );
    player setclientomnvar( "ui_br_self_revive_type", player.selfrevivedata.type );
    
    if ( isdefined( player.selfrevivedata.perk ) )
    {
        player perk::giveperk( player.selfrevivedata.perk );
    }
    
    player laststand::sethasselfrevivetokenextrainfo( 1 );
    
    if ( !skipsplash )
    {
        player thread hud_message::showsplash( "br_self_revive_token_pickup" );
    }
    
    issolos = level.maxteamsize == 1;
    
    if ( issolos && !isdefined( player.perks[ "specialty_pistoldeath" ] ) )
    {
        player perk::giveperk( "specialty_pistoldeath" );
    }
}

// Namespace br_pickups
// Params 4
// Checksum 0xb901c5e0, Offset: 0x4e78
// Size: 0x51
function addselfrevivetoken( skipsplash, revivelootid = 8548, itemslotindex, backpackequip )
{
    function_19f92529593d1af9( skipsplash, revivelootid, itemslotindex, backpackequip );
    level notify( "picked_up_item_brloot_self_revive_" + self.team, self );
}

// Namespace br_pickups
// Params 2
// Checksum 0xe3306075, Offset: 0x4ed1
// Size: 0xca
function removeselfrevivetoken( param1, param2 )
{
    player = self;
    
    if ( player laststand::hasselfrevivetoken() )
    {
        currentperk = br_public::function_af655f4c315d1874( player );
        
        if ( isdefined( currentperk ) && isdefined( player.perks[ currentperk ] ) )
        {
            player perk::removeperk( currentperk );
        }
        
        player laststand::sethasselfrevivetokenextrainfo( 0 );
        issolos = level.maxteamsize == 1;
        
        if ( issolos && isdefined( player.perks[ "specialty_pistoldeath" ] ) )
        {
            player perk::removeperk( "specialty_pistoldeath" );
        }
        
        br_instance_inventory::function_29eb2f072ac8b7ac( self );
        player.selfrevivedata = undefined;
    }
    
    function_95c43ecec7788235( "brloot_self_revive" );
}

// Namespace br_pickups
// Params 0
// Checksum 0x2e053fd9, Offset: 0x4fa3
// Size: 0xd7
function fillmaxarmorplate()
{
    player = self;
    fakepickup = spawnstruct();
    fakepickup.scriptablename = "brloot_armor_plate";
    fakepickup.equipname = level.br_pickups.br_equipname[ fakepickup.scriptablename ];
    fakepickup.origin = self.origin;
    fakepickup.maxcount = equipment_mp::getequipmentmaxammo( fakepickup.equipname );
    fakepickup.count = fakepickup.maxcount;
    fakepickup.stackable = level.br_pickups.stackable[ fakepickup.scriptablename ];
    player takeequipmentpickup( fakepickup );
}

// Namespace br_pickups
// Params 1
// Checksum 0x55dead6e, Offset: 0x5082
// Size: 0x99
function takeaccesscardpickup( pickupent )
{
    if ( br_public::hasaccesscard() )
    {
        dropstruct = pickups::function_f71dd588dc4f6288();
        yawoffsetoverride = undefined;
        dropinfo = pickups::getitemdroporiginandangles( dropstruct, self.origin, self.angles, self, yawoffsetoverride, pickupent.overridedist, undefined, undefined, pickupent.origin );
        spawnpickup( self.accesscard, dropinfo, 1, 1 );
    }
    
    addaccesscard( pickupent.scriptablename );
}

// Namespace br_pickups
// Params 1
// Checksum 0xf1d5ec14, Offset: 0x5123
// Size: 0x104
function addaccesscard( cardtype )
{
    player = self;
    player.accesscard = cardtype;
    
    if ( !isdefined( level.var_9dbb0f423dac126 ) )
    {
        level.var_9dbb0f423dac126 = getscriptbundle( getgametypescriptbundle().braccess_card );
    }
    
    if ( !isdefined( level.var_9dbb0f423dac126 ) )
    {
        assertmsg( "<dev string:x8c>" );
        return;
    }
    
    var_e9dc4ab61a3f47f4 = getxhash( cardtype );
    isfound = 0;
    
    for ( var_90abd0b765c18ae2 = 0; var_90abd0b765c18ae2 < level.var_9dbb0f423dac126.list.size ; var_90abd0b765c18ae2++ )
    {
        item = level.var_9dbb0f423dac126.list[ var_90abd0b765c18ae2 ];
        
        if ( item.ref == var_e9dc4ab61a3f47f4 )
        {
            isfound = 1;
            var_90abd0b765c18ae2++;
            break;
        }
    }
    
    if ( !isfound )
    {
        var_90abd0b765c18ae2 = 0;
    }
    
    player br_public::updatebrscoreboardstat( "bunkerKeycardType", var_90abd0b765c18ae2 );
}

// Namespace br_pickups
// Params 0
// Checksum 0x94442dd, Offset: 0x522f
// Size: 0x49
function removeaccesscard()
{
    player = self;
    
    if ( !getdvarint( @"hash_8c6e1c43e3d41dd3", 0 ) )
    {
        assert( br_public::hasaccesscard() );
    }
    
    player.accesscard = undefined;
    player br_public::updatebrscoreboardstat( "bunkerKeycardType", 0 );
}

// Namespace br_pickups
// Params 1
// Checksum 0x8ae50ed5, Offset: 0x5280
// Size: 0x3d
function function_10d4475b0263c742( pickupent )
{
    lootid = loot::function_d3e3bcaea591a6a2( pickupent.scriptablename );
    common_inventory::function_d3959596f4031a1d( lootid, pickupent.count );
}

// Namespace br_pickups
// Params 1
// Checksum 0xa3d235e4, Offset: 0x52c5
// Size: 0x45
function takexp( pickupent )
{
    thread points::doscoreevent( #"dmz_loot_xp" );
    thread hud_message::showsplash( "dmz_loot_xp" );
    damagefeedback::hudicontype( "xp_pickup" );
    pickupent.instance disablescriptableplayeruse( self );
}

// Namespace br_pickups
// Params 1
// Checksum 0xfa4d35c0, Offset: 0x5312
// Size: 0xc9
function function_a35730a988baa527( pickupent )
{
    var_2ed40116b5fea2ed = 0;
    
    if ( pickupent br_elite_broken_arrow::function_c67ed81341a99d07() )
    {
        var_2ed40116b5fea2ed = pickupent br_elite_broken_arrow::function_82760319f6a590e8();
    }
    
    var_2943103a7ac11f56 = 0;
    
    if ( pickupent br_elite_broken_arrow::function_31df7dd55c44bda8() )
    {
        var_2943103a7ac11f56 = pickupent br_elite_broken_arrow::function_770bbad081e3c123( self );
    }
    
    shouldpickup = var_2ed40116b5fea2ed || var_2943103a7ac11f56;
    elementname = pickupent br_elite_broken_arrow::function_ebcaa647b48649c9();
    
    if ( isdefined( elementname ) && shouldpickup )
    {
        if ( !pickupent br_elite_broken_arrow::function_206ea3b3452b2f2( self ) )
        {
            return 33;
        }
        
        pickupent.scriptablename = elementname;
    }
    
    if ( shouldpickup )
    {
        return function_3a6d2dc9abde2071( pickupent );
    }
    
    pickupent.instance.count = 1;
    return 1;
}

// Namespace br_pickups
// Params 7
// Checksum 0xa4aa0bb2, Offset: 0x53e3
// Size: 0x1db
function forcegivekillstreak( killstreakref, dropcurrent, fromkiosk, droppurchased, var_6432f32bb6fece8b, backpackequip, pickup )
{
    self notify( #"cancel_all_killstreak_deployments" );
    
    if ( droppurchased )
    {
        dropstruct = pickups::function_f71dd588dc4f6288();
        
        if ( fromkiosk && isdefined( self.br_kiosk ) && isdefined( self.br_kiosk.dropstruct ) )
        {
            slotindex = self.br_kiosk function_ef8a0f215f5f8b92();
            self.br_kiosk.dropstruct.dropidx = slotindex;
            dropstruct = self.br_kiosk.dropstruct;
        }
        
        function_364fcbacd8b7472( dropstruct, fromkiosk, droppurchased, killstreakref, pickup );
        return;
    }
    
    if ( backpackequip && isdefined( var_6432f32bb6fece8b ) )
    {
        common_inventory::function_4f226d9d5d61901e( var_6432f32bb6fece8b );
    }
    
    if ( dropcurrent )
    {
        dropstruct = pickups::function_f71dd588dc4f6288();
        
        if ( fromkiosk && isdefined( self.br_kiosk ) && isdefined( self.br_kiosk.dropstruct ) )
        {
            slotindex = self.br_kiosk function_ef8a0f215f5f8b92();
            self.br_kiosk.dropstruct.dropidx = slotindex;
            dropstruct = self.br_kiosk.dropstruct;
        }
        
        dropbrkillstreak( dropstruct, fromkiosk, var_6432f32bb6fece8b, undefined, pickup );
        
        if ( isdefined( var_6432f32bb6fece8b ) )
        {
            br_instance_inventory::function_7575906b0512f675( self );
        }
    }
    else
    {
        killstreaks::removekillstreak( 1 );
    }
    
    killstreaks::awardkillstreak( killstreakref, "other", undefined, undefined, undefined, 1 );
    lootid = loot::function_d3e3bcaea591a6a2( loot::function_3bbf7813accff0d9( killstreakref ) );
    br_instance_inventory::function_26cf1ad6f45e326d( self, lootid );
}

// Namespace br_pickups
// Params 4
// Checksum 0xd00466ce, Offset: 0x55c6
// Size: 0x6f
function takekillstreakpickup( pickupent, fromkiosk, var_6432f32bb6fece8b, backpackequip )
{
    killstreakref = level.br_pickups.br_lootreference[ pickupent.scriptablename ];
    assert( isdefined( killstreakref ) );
    forcegivekillstreak( killstreakref, 1, fromkiosk, 0, var_6432f32bb6fece8b, backpackequip, pickupent );
}

// Namespace br_pickups
// Params 0
// Checksum 0xa960b107, Offset: 0x563d
// Size: 0x59, Type: bool
function hasanykillstreak()
{
    if ( isdefined( self.streakdata ) && isdefined( self.streakdata.streaks ) && self.streakdata.streaks.size > 0 )
    {
        return isdefined( self.streakdata.streaks[ 1 ] );
    }
    
    return false;
}

// Namespace br_pickups
// Params 1
// Checksum 0xfd447b99, Offset: 0x569f
// Size: 0x39, Type: bool
function haskillstreak( killstreakref )
{
    return hasanykillstreak() && self.streakdata.streaks[ 1 ].streakname == killstreakref;
}

// Namespace br_pickups
// Params 1
// Checksum 0x8a3a1c6, Offset: 0x56e1
// Size: 0x65
function forceusekillstreak( killstreakref )
{
    if ( hasanykillstreak() )
    {
        killstreaks::removekillstreak( 1 );
    }
    
    killstreaks::awardkillstreak( killstreakref, "other" );
    streakitem = killstreaks::getkillstreakinslot( 1 );
    usesuccess = killstreaks::triggerkillstreak( streakitem, 1 );
    
    if ( !usesuccess )
    {
        killstreaks::removekillstreak( 1 );
    }
    
    return usesuccess;
}

// Namespace br_pickups
// Params 3
// Checksum 0xe5c2d14a, Offset: 0x574f
// Size: 0xc0
function _givebrsuper( equipname, supername, supercount )
{
    if ( level.allowsupers || self.var_760a3e04da86556f && !supers_mp::function_ec58b00bf38b48a8( supername ) )
    {
        perkpackage::perkpackage_giveoverridefieldupgrades( supername );
        supers_mp::function_1f9b6b3c1d1f1404( 0 );
        supercount = supers_mp::getcurrentsuperpoints() >= supers_mp::getsuperpointsneeded();
    }
    else
    {
        function_7a84cede0c8eec18( supername );
        self setclientomnvar( "ui_perk_package_state", 3 );
        self setclientomnvar( "ui_perk_package_super1", supers_mp::getsuperid( supername ) );
        thread supers_mp::function_cb3e288a8ed4df3e( 1 );
        thread supers_mp::handlesuperuistatechange( 2 );
    }
    
    if ( isdefined( equipname ) )
    {
        equipment_mp::giveequipment( equipname, "super" );
        equipment_mp::setequipmentammo( equipname, supercount );
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0x5bb3028e, Offset: 0x5817
// Size: 0x6b
function function_7a84cede0c8eec18( supername )
{
    perkpackage::perkpackage_giveimmediate( supername );
    self.var_33129007db246c94 = 1;
    thread function_b0cfd578776003e9( supername );
    
    if ( isdefined( self.super.staticdata.ongivefunc ) )
    {
        self thread [[ self.super.staticdata.ongivefunc ]]();
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0x90e27e2a, Offset: 0x588a
// Size: 0x56
function function_b0cfd578776003e9( supername )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self setclientomnvar( "ui_perk_package_state", 3 );
    self setclientomnvar( "ui_perk_package_super1", supers_mp::getsuperid( supername ) );
    thread supers_mp::function_cb3e288a8ed4df3e( 1 );
    thread supers_mp::handlesuperuistatechange( 2 );
}

// Namespace br_pickups
// Params 2
// Checksum 0x61b385a5, Offset: 0x58e8
// Size: 0x63
function function_c8443eb135b6c738( equipname, supername )
{
    self.var_33129007db246c94 = 1;
    self setclientomnvar( "ui_perk_package_state", 3 );
    self setclientomnvar( "ui_perk_package_super1", supers_mp::getsuperid( supername ) );
    thread supers_mp::function_cb3e288a8ed4df3e( 1 );
    thread supers_mp::handlesuperuistatechange( 2 );
    
    if ( isdefined( equipname ) )
    {
        equipment_mp::setequipmentammo( equipname, 1 );
    }
}

// Namespace br_pickups
// Params 0
// Checksum 0xec545c71, Offset: 0x5953
// Size: 0xb7
function function_d743bcc9a06c3bb2()
{
    superinfo = supers_mp::getcurrentsuper();
    
    if ( !isdefined( superinfo ) )
    {
        return;
    }
    
    if ( isdefined( superinfo.staticdata.useweapon ) )
    {
        return supers_mp::function_9e6dc95ca52d8e3f();
    }
    
    if ( isdefined( superinfo.staticdata.ref ) && utility::issharedfuncdefined( superinfo.staticdata.ref, #"getammo", 0 ) )
    {
        return [[ utility::getsharedfunc( superinfo.staticdata.ref, #"getammo" ) ]]();
    }
    
    return equipment_mp::getequipmentslotammo( "super" );
}

// Namespace br_pickups
// Params 0
// Checksum 0x4b3ded1b, Offset: 0x5a12
// Size: 0x55
function function_5fa27fb0c5741e02()
{
    bulletsfired = supers_mp::function_e33f44960be55a1f( 1 );
    var_140160807b4fc9f4 = supers_mp::getsuperpointsneeded();
    pointsreduced = supers_mp::function_88ef58d2fa3e72c0( self.super, 1 ) * bulletsfired * var_140160807b4fc9f4;
    supers_mp::setsuperbasepoints( var_140160807b4fc9f4 - pointsreduced, undefined, 1 );
}

// Namespace br_pickups
// Params 3
// Checksum 0xaaac08e0, Offset: 0x5a6f
// Size: 0x205
function takesuperpickup( pickupent, fromkiosk, var_6432f32bb6fece8b )
{
    equipname = level.br_pickups.br_equipname[ pickupent.scriptablename ];
    supername = level.br_pickups.br_lootreference[ pickupent.scriptablename ];
    lootid = loot::function_d3e3bcaea591a6a2( pickupent.scriptablename );
    var_9c89495de4c58fa8 = 0;
    
    if ( isdefined( self.super ) && supers_mp::function_31f00fe6e0334d03() )
    {
        var_9c89495de4c58fa8 = supers_mp::getcurrentsuperpoints() >= supers_mp::getsuperpointsneeded();
    }
    
    if ( isdefined( var_6432f32bb6fece8b ) )
    {
        common_inventory::function_d3959596f4031a1d( var_6432f32bb6fece8b, pickupent.count * -1 );
        br_instance_inventory::function_ba66e7c85bc79054( self, "super" );
    }
    
    if ( function_e44a0803d593564( undefined, pickupent.scriptablename ) && br_gametype_truckwar::function_fe8835b9f00d3c4d() )
    {
        br_gametype_truckwar::function_337995b87b58fe3c();
    }
    
    if ( isdefined( self.equipment[ "super" ] ) )
    {
        if ( equipment_mp::getequipmentslotammo( "super" ) > 0 || var_9c89495de4c58fa8 || supers_mp::isusingsuperweapon() )
        {
            dropstruct = pickups::function_f71dd588dc4f6288();
            dropequipmentinslot( dropstruct, "super", fromkiosk, undefined, var_6432f32bb6fece8b, undefined, undefined, undefined, pickupent );
        }
    }
    
    _givebrsuper( equipname, supername, pickupent.count );
    
    if ( function_3d06a36003e339e4( pickupent.scriptablename ) )
    {
        supers_mp::function_b8c330b10d1729bb( pickupent.count, "all" );
        function_5fa27fb0c5741e02();
    }
    
    br_instance_inventory::function_b1116f6c1b474c9c( self, "super", lootid );
    
    if ( ( level.allowsupers || supers_mp::function_31f00fe6e0334d03() ) && !( equipment_mp::getequipmentslotammo( "super" ) > 0 ) )
    {
        supers_mp::givesuperpoints( supers_mp::getsuperpointsneeded(), undefined, undefined, undefined, 1 );
    }
    
    self notify( #"br_pickup_super" );
}

// Namespace br_pickups
// Params 5
// Checksum 0xa6ab4fd2, Offset: 0x5c7c
// Size: 0xbc
function forcegivesuper( targetsupername, dropcurrent, fromkiosk, droppurchased, var_6432f32bb6fece8b )
{
    if ( level.var_3e0ce9b4c749525f && targetsupername == "none" )
    {
        return;
    }
    
    if ( droppurchased )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( fromkiosk );
        common_item::function_325e28c0fb65c36a( targetsupername, undefined, spawnoptions );
        return;
    }
    
    if ( !dropcurrent )
    {
        item_super::remove_current_super();
    }
    
    itembundle = common_item::function_cf68ad18114498b2( targetsupername );
    item = common_item::function_77600f92048df72d( itembundle, 1 );
    item.fromground = 1;
    common_item::function_2b5e2ff57d5f392( item, 0 );
}

// Namespace br_pickups
// Params 4
// Checksum 0xb5034ae5, Offset: 0x5d40
// Size: 0x63
function takeperkpickup( scriptablename, fromkiosk, var_6432f32bb6fece8b, backpackequip )
{
    perkref = level.br_pickups.br_lootreference[ scriptablename ];
    assert( isdefined( perkref ) );
    forcegiveperk( perkref, 1, fromkiosk, var_6432f32bb6fece8b, backpackequip );
}

// Namespace br_pickups
// Params 5
// Checksum 0xdf6001ac, Offset: 0x5dab
// Size: 0xdd
function forcegiveperk( perkref, dropcurrent, fromkiosk, var_6432f32bb6fece8b, backpackequip )
{
    if ( backpackequip && isdefined( var_6432f32bb6fece8b ) )
    {
        common_inventory::function_4f226d9d5d61901e( var_6432f32bb6fece8b );
    }
    
    if ( dropcurrent )
    {
        dropstruct = pickups::function_f71dd588dc4f6288();
        
        if ( fromkiosk && isdefined( self.br_kiosk ) && isdefined( self.br_kiosk.dropstruct ) )
        {
            slotindex = self.br_kiosk function_ef8a0f215f5f8b92();
            self.br_kiosk.dropstruct.dropidx = slotindex;
            dropstruct = self.br_kiosk.dropstruct;
        }
    }
    
    perk::giveperk( perkref );
}

// Namespace br_pickups
// Params 0
// Checksum 0xd96ea770, Offset: 0x5e90
// Size: 0x129
function function_f6206bebca918789()
{
    if ( !isdefined( level.headgeardata ) )
    {
        level waittill( #"headgear_init" );
    }
    
    var_df48a6559284e3cb = spawnstruct();
    var_df48a6559284e3cb.var_d4127ffc4a33f741 = &gasmask::hasgasmask;
    var_df48a6559284e3cb.var_e59404adc566edd0 = &gasmask::function_799e5d7cad9440ce;
    var_df48a6559284e3cb.var_abc222b77737dfda = &function_55a08fb1a7d0aac5;
    var_df48a6559284e3cb.var_f8afa4b15f2dfd1a = &gasmask::function_dc1842f4eec31f5c;
    var_df48a6559284e3cb.var_cbdf8c6be6174cc = &gasmask::function_2dbe13ebabc803b4;
    var_df48a6559284e3cb.var_d8ed88d301c75991 = &gasmask::function_43a8d89f6f1d2141;
    var_df48a6559284e3cb.var_7058909c0850f32f = &gasmask::init;
    var_df48a6559284e3cb.breakfunc = &breakgasmaskbr;
    var_df48a6559284e3cb.var_395e196a7eb5381e = &function_219547e563ff9527;
    var_df48a6559284e3cb.var_4e4dc022e7622dde = &function_1190855e1ea8f90f;
    var_df48a6559284e3cb.var_c615929c785b38db = &function_1b69cf98b638957e;
    var_df48a6559284e3cb.var_ef9b6239a74b7964 = &function_6ea3686585fe3f7e;
    var_df48a6559284e3cb.var_27498b72660f8f41 = &function_14cef7e00c80834;
    var_df48a6559284e3cb.var_ce0f1a96b9992941 = &function_cea1f9eaf07ce634;
    br_headgear::registerheadgear( "gas_mask", var_df48a6559284e3cb );
}

// Namespace br_pickups
// Params 5
// Checksum 0x26599704, Offset: 0x5fc1
// Size: 0x36e
function takeheadgear( headgeartype, pickupent, fromkiosk, itemslotindex, backpackequip )
{
    if ( !br_headgear::function_8d2d82039f815a8f( headgeartype ) )
    {
        return;
    }
    
    if ( backpackequip && isdefined( itemslotindex ) )
    {
        common_inventory::function_4f226d9d5d61901e( itemslotindex );
    }
    
    if ( !isdefined( pickupent.count ) || pickupent.count <= 0 )
    {
        return;
    }
    
    if ( br_headgear::function_915d0e7eb3f5dcdd( self ) )
    {
        currentheadgear = br_headgear::function_6435617c4427123a( self.headgeartype, self );
        var_94391e60e85e5c34 = br_headgear::function_d26be71b65916bb0( self.headgeartype, self );
        var_4d9f4261417c0d8d = loot::function_d3e3bcaea591a6a2( currentheadgear );
        var_bd5bc435c753c61c = currentheadgear;
        var_174fc3823209a8c2 = var_94391e60e85e5c34;
        var_593cb5bcbee3baa3 = var_4d9f4261417c0d8d;
        var_8c4f380c2b51cc80 = self.headgeartype == headgeartype && br_headgear::function_dc1842f4eec31f5c( headgeartype, self, pickupent ) || backpackequip;
        
        if ( !var_8c4f380c2b51cc80 )
        {
            var_bd5bc435c753c61c = pickupent.scriptablename;
            var_174fc3823209a8c2 = pickupent.count;
            var_593cb5bcbee3baa3 = loot::function_d3e3bcaea591a6a2( var_bd5bc435c753c61c );
        }
        
        function_6cebf175e5947276( fromkiosk );
        dodrop = !common_inventory::function_7ec5937e3b3d86e0( var_bd5bc435c753c61c );
        
        if ( !dodrop )
        {
            if ( !backpackequip )
            {
                index = common_inventory::function_9cfce16f3087291a();
                
                if ( isdefined( index ) )
                {
                    common_inventory::inventory_setbackpackitematindex( self, index, var_593cb5bcbee3baa3, int( var_174fc3823209a8c2 ) );
                }
                else
                {
                    dodrop = 1;
                }
            }
            else
            {
                common_inventory::inventory_setbackpackitematindex( self, itemslotindex, var_593cb5bcbee3baa3, int( var_174fc3823209a8c2 ) );
            }
        }
        
        if ( dodrop )
        {
            dropstruct = pickups::function_f71dd588dc4f6288();
            overridedist = pickupent.overridedist ?? level.br_pickups.distanceoverride;
            dropinfo = pickups::getitemdroporiginandangles( dropstruct, self.origin, self.angles, self, level.br_pickups.yawoffsetoverride, overridedist, undefined, undefined, pickupent.origin );
            headgeardrop = spawnpickup( var_bd5bc435c753c61c, dropinfo, int( var_174fc3823209a8c2 ), 1 );
            
            if ( br_public::isplayeringulag() )
            {
                headgeardrop.var_69c7f935014de621 = 1;
            }
        }
        
        if ( !var_8c4f380c2b51cc80 )
        {
            return;
        }
        
        br_headgear::function_43e3a6d7dd5bc804( self, self.headgeartype, "br_circle" );
        br_instance_inventory::function_bf3288672a33d4a2( self );
    }
    
    lootid = loot::function_d3e3bcaea591a6a2( pickupent.scriptablename );
    br_instance_inventory::function_41df234a9777485a( self, lootid );
    br_headgear::initheadgear( headgeartype, self, pickupent.count, pickupent.scriptablename );
    
    if ( br_headgear::function_f95a396894b1ddad( headgeartype ) )
    {
        br_headgear::headgearon( headgeartype, "br_circle" );
    }
    
    scoreboarddata = 0;
    
    if ( headgeartype == "gas_mask" )
    {
        scoreboarddata = pickupent.scriptablename == "brloot_equip_gasmask_durable" ? 2 : 1;
    }
    else if ( headgeartype == "helmet" )
    {
        scoreboarddata = 3;
    }
    
    assert( scoreboarddata != 0, "<dev string:xab>" );
    br_public::updatebrscoreboardstat( "headGearType", scoreboarddata );
    level notify( "picked_up_item_" + pickupent.scriptablename + "_" + self.team, self );
}

// Namespace br_pickups
// Params 0
// Checksum 0x42b995cd, Offset: 0x6337
// Size: 0x30, Type: bool
function function_55a08fb1a7d0aac5()
{
    if ( !isdefined( level.var_c7bf4af6240a235 ) )
    {
        level.var_c7bf4af6240a235 = getdvarint( @"hash_f221cc8f9519efe", 1 );
    }
    
    return istrue( level.var_c7bf4af6240a235 );
}

// Namespace br_pickups
// Params 4
// Checksum 0xc2265f8b, Offset: 0x6370
// Size: 0x39
function takegasmask( pickupent, fromkiosk, itemslotindex, backpackequip )
{
    takeheadgear( "gas_mask", pickupent, fromkiosk, itemslotindex, backpackequip );
}

// Namespace br_pickups
// Params 1
// Checksum 0x16794306, Offset: 0x63b1
// Size: 0x1a
function gasmaskon( request )
{
    br_headgear::headgearon( "gas_mask", request );
}

// Namespace br_pickups
// Params 1
// Checksum 0x9d20aa7e, Offset: 0x63d3
// Size: 0x1a
function gasmaskoff( request )
{
    br_headgear::headgearoff( "gas_mask", request );
}

// Namespace br_pickups
// Params 1
// Checksum 0xfc53303c, Offset: 0x63f5
// Size: 0x54
function function_8bb363a772f35700( player )
{
    delaygesture = 0;
    delaygesture |= player isreloading();
    delaygesture |= player isthrowinggrenade();
    delaygesture |= player isdiving();
    delaygesture |= player issprintsliding();
    delaygesture |= player player::isplayerads();
    return delaygesture;
}

// Namespace br_pickups
// Params 0
// Checksum 0x33821a16, Offset: 0x6452
// Size: 0x54, Type: bool
function canplaygasmaskgesturebr()
{
    player = self;
    preventgesture = 0;
    preventgesture |= player isinfreefall();
    preventgesture |= player isskydiving();
    preventgesture |= player isparachuting();
    preventgesture |= player isbasejumpavailable();
    preventgesture |= player ismantling();
    return !preventgesture;
}

// Namespace br_pickups
// Params 0
// Checksum 0xcd91d6f2, Offset: 0x64af
// Size: 0x8b
function function_1b69cf98b638957e()
{
    self playsoundtoplayer( "br_gas_mask_on_plr", self );
    thread delayedattach( 0.2 );
    var_6b4b79136446cdf5 = self getgestureanimlength( "iw9_vm_ges_gasmask_on" );
    overlayfadetime = var_6b4b79136446cdf5 * 0.35;
    assert( 0.2 < var_6b4b79136446cdf5 );
    
    if ( canplaygasmaskgesturebr() )
    {
        thread pickups::playerplaygestureweaponanim( "iw8_ges_plyr_gasmask_on", var_6b4b79136446cdf5 );
    }
    
    self setclientomnvar( "ui_gas_mask", 2 );
    thread function_ba4f9bbecefee262( level.var_c623a0da9f4c58f4, overlayfadetime );
    wait var_6b4b79136446cdf5;
}

// Namespace br_pickups
// Params 0
// Checksum 0x171d6901, Offset: 0x6542
// Size: 0x3d
function function_6ea3686585fe3f7e()
{
    self.gasmaskequipped = 1;
    white_phosphorus::enableloopingcoughaudiosupression();
    operator::function_89e5e91ee0fb0836();
    
    if ( self.gasmaskhealth <= 0 )
    {
        if ( !level.var_c7bf4af6240a235 )
        {
            breakgasmaskbr();
        }
    }
}

// Namespace br_pickups
// Params 0
// Checksum 0xe0a263c9, Offset: 0x6587
// Size: 0x130
function removegasmaskbr()
{
    self endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !self.gasmaskequipped && !level.var_c7bf4af6240a235 )
    {
        return;
    }
    
    self playsoundtoplayer( "br_gas_mask_off_plr", self );
    fadeouttime = self getgestureanimlength( "iw9_vm_ges_gasmask_off" );
    overlayfadetime = fadeouttime * 0.35;
    thread delayeddetach( 1.3 );
    
    if ( canplaygasmaskgesturebr() )
    {
        if ( level.var_c7bf4af6240a235 )
        {
            if ( gasmask::function_a062bf98847b605a( self ) )
            {
                thread pickups::playerplaygestureweaponanim( "iw8_ges_plyr_gasmask_off", fadeouttime );
            }
            else
            {
                thread pickups::playerplaygestureweaponanim( "iw8_ges_plyr_gasmask_break", fadeouttime );
            }
        }
        else
        {
            thread pickups::playerplaygestureweaponanim( "iw8_ges_plyr_gasmask_off", fadeouttime );
        }
    }
    
    self.gasmaskswapinprogress = 1;
    self setclientomnvar( "ui_gas_mask", 1 );
    thread function_ba4f9bbecefee262( 0, overlayfadetime );
    wait fadeouttime;
    self.gasmaskswapinprogress = 0;
    self notify( #"gas_mask_swap_complete" );
    white_phosphorus::disableloopingcoughaudiosupression();
    operator::setgendersoundcontext();
    
    if ( self.gasmaskhealth <= 0 )
    {
        if ( !level.var_c7bf4af6240a235 )
        {
            function_5375ae93bfe708df();
        }
    }
}

// Namespace br_pickups
// Params 0
// Checksum 0xaf684c10, Offset: 0x66bf
// Size: 0xab
function function_14cef7e00c80834()
{
    self playsoundtoplayer( "br_gas_mask_off_plr", self );
    fadeouttime = self getgestureanimlength( "iw9_vm_ges_gasmask_off" );
    overlayfadetime = fadeouttime * 0.35;
    thread delayeddetach( 1.3 );
    
    if ( canplaygasmaskgesturebr() )
    {
        if ( level.var_c7bf4af6240a235 )
        {
            if ( gasmask::function_a062bf98847b605a( self ) )
            {
                thread pickups::playerplaygestureweaponanim( "iw8_ges_plyr_gasmask_off", fadeouttime );
            }
            else
            {
                thread pickups::playerplaygestureweaponanim( "iw8_ges_plyr_gasmask_break", fadeouttime );
            }
        }
        else
        {
            thread pickups::playerplaygestureweaponanim( "iw8_ges_plyr_gasmask_off", fadeouttime );
        }
    }
    
    self setclientomnvar( "ui_gas_mask", 1 );
    thread function_ba4f9bbecefee262( 0, overlayfadetime );
    wait fadeouttime;
}

// Namespace br_pickups
// Params 0
// Checksum 0xeb0e4763, Offset: 0x6772
// Size: 0x32
function function_cea1f9eaf07ce634()
{
    white_phosphorus::disableloopingcoughaudiosupression();
    operator::setgendersoundcontext();
    
    if ( self.gasmaskhealth <= 0 )
    {
        if ( !level.var_c7bf4af6240a235 )
        {
            function_5375ae93bfe708df();
        }
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0x965156f4, Offset: 0x67ac
// Size: 0xcf
function breakgasmaskbr( attacker )
{
    if ( !isdefined( self.gasmaskhealth ) )
    {
        return;
    }
    
    self playsoundtoplayer( "br_gas_mask_break_plr", self );
    
    if ( !level.var_c7bf4af6240a235 )
    {
        thread delayeddetachbreak( 0.6 );
    }
    
    operator::setgendersoundcontext();
    self playsoundtoplayer( #"br_gas_mask_depleted_plr", self );
    
    if ( !level.var_c7bf4af6240a235 )
    {
        function_5375ae93bfe708df();
        fadeouttime = self getgestureanimlength( "iw9_vm_ges_gasmask_break" );
        thread pickups::playerplaygestureweaponanim( "iw8_ges_plyr_gasmask_break", fadeouttime );
        self.gasmaskswapinprogress = 1;
        self setclientomnvar( "ui_gas_mask", 3 );
        wait fadeouttime;
        self.gasmaskswapinprogress = 0;
        self notify( #"gas_mask_swap_complete" );
        br_instance_inventory::function_bf3288672a33d4a2( self );
        function_219547e563ff9527();
    }
}

// Namespace br_pickups
// Params 2
// Checksum 0xa3668e23, Offset: 0x6883
// Size: 0x3d
function function_ba4f9bbecefee262( amount, time )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    wait time;
    self setclientomnvar( "ui_gas_mask_opacity_override", amount );
}

// Namespace br_pickups
// Params 1
// Checksum 0xbf9cbc8c, Offset: 0x68c8
// Size: 0x42
function delayedattach( delaytime )
{
    self endon( #"game_end" );
    self endon( #"death_or_disconnect" );
    
    if ( delaytime > 0 )
    {
        wait delaytime;
    }
    
    self attach( "hat_child_hadir_gas_mask_wm_br", "j_head" );
}

// Namespace br_pickups
// Params 1
// Checksum 0xbf9cbc94, Offset: 0x6912
// Size: 0x58
function delayeddetach( delaytime )
{
    self endon( #"game_end" );
    self endon( #"death_or_disconnect" );
    
    if ( delaytime > 0 )
    {
        wait delaytime;
    }
    
    if ( self.gasmaskequipped )
    {
        self detach( "hat_child_hadir_gas_mask_wm_br", "j_head" );
        self.gasmaskequipped = 0;
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0x5c3b4cd0, Offset: 0x6972
// Size: 0x7a
function delayeddetachbreak( delaytime )
{
    self endon( #"game_end" );
    self endon( #"death_or_disconnect" );
    
    if ( delaytime > 0.1 )
    {
        wait delaytime - 0.1;
    }
    
    playfxontag( utility::getfx( "vfx_gas_mask_break" ), self, "tag_weapon_left" );
    wait 0.1;
    
    if ( self.gasmaskequipped )
    {
        self detach( "hat_child_hadir_gas_mask_wm_br", "j_head" );
        self.gasmaskequipped = 0;
    }
}

// Namespace br_pickups
// Params 0
// Checksum 0xa6e71e6e, Offset: 0x69f4
// Size: 0x60
function function_cde7bb308b1cf12f()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        gasmasktimeout = utility::waittill_any_timeout( level.var_48fc5a6351d1343c, "gasmask_buffer_reset" );
        
        if ( !isdefined( gasmasktimeout ) || gasmasktimeout == "timeout" )
        {
            self.var_ccaedd955fabd3b4 = 0;
            return;
        }
    }
}

// Namespace br_pickups
// Params 0
// Checksum 0x3dbd78cd, Offset: 0x6a5c
// Size: 0x43
function function_219547e563ff9527()
{
    player = self;
    
    if ( !player common_inventory::function_5c64d2b24a8c3e18() )
    {
        return;
    }
    
    restocksuccess = function_95c43ecec7788235( "gas_mask_durable" );
    
    if ( !restocksuccess )
    {
        function_95c43ecec7788235( "gas_mask" );
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0x5393660a, Offset: 0x6aa7
// Size: 0x20
function canholdammobox( scriptablename )
{
    if ( !isdefined( self.br_ammo[ scriptablename ] ) )
    {
        return 1;
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0xf85b8796, Offset: 0x6acf
// Size: 0x3b, Type: bool
function isgasmask( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"gear" && issubstr( scriptablename, "gasmask" );
}

// Namespace br_pickups
// Params 1
// Checksum 0xffc671b2, Offset: 0x6b13
// Size: 0x3b, Type: bool
function ishelmet( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"gear" && issubstr( scriptablename, "helmet" );
}

// Namespace br_pickups
// Params 1
// Checksum 0x144645c0, Offset: 0x6b57
// Size: 0x3b, Type: bool
function function_ce9a9f8d70afdf01( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"key" && issubstr( scriptablename, "loot_key_gulag" );
}

// Namespace br_pickups
// Params 1
// Checksum 0xba6ce28, Offset: 0x6b9b
// Size: 0x2c, Type: bool
function isnote( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"note";
}

// Namespace br_pickups
// Params 1
// Checksum 0x2e2221b6, Offset: 0x6bd0
// Size: 0x3b, Type: bool
function function_56d8ca44f91af7c( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"gear" && issubstr( scriptablename, "iodine_pills" );
}

// Namespace br_pickups
// Params 1
// Checksum 0x7a29ca22, Offset: 0x6c14
// Size: 0x3b, Type: bool
function function_8b2f7f58a48bed48( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"exfil" && issubstr( scriptablename, "exfil_marker" );
}

// Namespace br_pickups
// Params 1
// Checksum 0x20d84765, Offset: 0x6c58
// Size: 0x3b, Type: bool
function isspecialistbonus( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"specialist" && issubstr( scriptablename, "specialist_bonus" );
}

// Namespace br_pickups
// Params 1
// Checksum 0xb67d3861, Offset: 0x6c9c
// Size: 0x2c, Type: bool
function isplunder( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"plunder";
}

// Namespace br_pickups
// Params 1
// Checksum 0x213a9cbd, Offset: 0x6cd1
// Size: 0x12, Type: bool
function function_c1a47b070ee27c93( lootid )
{
    return lootid == 8395;
}

// Namespace br_pickups
// Params 1
// Checksum 0xba36b623, Offset: 0x6cec
// Size: 0x2c, Type: bool
function isquesttablet( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"tablet";
}

// Namespace br_pickups
// Params 1
// Checksum 0x1ef35837, Offset: 0x6d21
// Size: 0x24
function function_e83c60c3a6451be3( scriptablename )
{
    if ( isquesttablet( scriptablename ) )
    {
        return issubstr( scriptablename, "elite_arrow" );
    }
    
    return 0;
}

// Namespace br_pickups
// Params 1
// Checksum 0xc630a40, Offset: 0x6d4e
// Size: 0x2c, Type: bool
function isdogtag( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"dogtag";
}

// Namespace br_pickups
// Params 1
// Checksum 0x4ee325a2, Offset: 0x6d83
// Size: 0x3b, Type: bool
function function_e380482ca8f0de4b( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"extractable" && issubstr( scriptablename, "durable_loot" );
}

// Namespace br_pickups
// Params 1
// Checksum 0xaae9a0bd, Offset: 0x6dc7
// Size: 0x2c, Type: bool
function isweaponcase( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"weaponcase";
}

// Namespace br_pickups
// Params 1
// Checksum 0xad8655af, Offset: 0x6dfc
// Size: 0x2c, Type: bool
function isquestitem( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"questitem_misc";
}

// Namespace br_pickups
// Params 1
// Checksum 0xb25000c0, Offset: 0x6e31
// Size: 0x2c, Type: bool
function function_1578d9983da7761a( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"elite_arrow";
}

// Namespace br_pickups
// Params 1
// Checksum 0x9cd6c1, Offset: 0x6e66
// Size: 0x2c, Type: bool
function isperkpointpickup( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"perkpoint";
}

// Namespace br_pickups
// Params 1
// Checksum 0xb3c4b3a2, Offset: 0x6e9b
// Size: 0x2c, Type: bool
function istokenpickup( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"token";
}

// Namespace br_pickups
// Params 1
// Checksum 0xd49b4d17, Offset: 0x6ed0
// Size: 0x14, Type: bool
function function_c45997117794b25f( scriptablename )
{
    return scriptablename == "brloot_gulag_token";
}

// Namespace br_pickups
// Params 1
// Checksum 0xf516aacd, Offset: 0x6eed
// Size: 0x2c, Type: bool
function isrevivepickup( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"revive";
}

// Namespace br_pickups
// Params 1
// Checksum 0xe0c59ce9, Offset: 0x6f22
// Size: 0x2c, Type: bool
function iskillstreak( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"killstreak";
}

// Namespace br_pickups
// Params 1
// Checksum 0xcbb9bc, Offset: 0x6f57
// Size: 0x2c, Type: bool
function isattachment( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"attachment";
}

// Namespace br_pickups
// Params 1
// Checksum 0xdb20a364, Offset: 0x6f8c
// Size: 0x39, Type: bool
function issuperpickup( scriptablename )
{
    return !isnonequippable( scriptablename ) && level.br_pickups.br_itemtype[ scriptablename ] == #"super";
}

// Namespace br_pickups
// Params 1
// Checksum 0xb7ef099, Offset: 0x6fce
// Size: 0x60
function function_3d06a36003e339e4( scriptablename )
{
    if ( !isdefined( scriptablename ) )
    {
        return 0;
    }
    
    switch ( scriptablename )
    {
        case #"hash_1e184faee1b35a2":
        case #"hash_dc76dae6923cd72":
        case #"hash_42f538a268e06c04":
        case #"hash_cc33d71013dc6a72":
            return 1;
        default:
            return 0;
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0xf554942d, Offset: 0x7036
// Size: 0x2c, Type: bool
function function_36092a934fe35d06( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"perk";
}

// Namespace br_pickups
// Params 1
// Checksum 0x7e70e21b, Offset: 0x706b
// Size: 0x14, Type: bool
function function_e2035e1b9faa4f6a( scriptablename )
{
    return scriptablename == "brloot_plate_carrier_high_capacity";
}

// Namespace br_pickups
// Params 1
// Checksum 0x4c2f4be7, Offset: 0x7088
// Size: 0x17
function isaccesscard( scriptablename )
{
    return issubstr( scriptablename, "access_card" );
}

// Namespace br_pickups
// Params 1
// Checksum 0xf42c5f8e, Offset: 0x70a8
// Size: 0x17
function function_e587e310ab3d3b77( scriptablename )
{
    return issubstr( scriptablename, "card_biometric_scan" );
}

// Namespace br_pickups
// Params 1
// Checksum 0xfa63b201, Offset: 0x70c8
// Size: 0x17
function isxp( scriptablename )
{
    return issubstr( scriptablename, "brloot_xp" );
}

// Namespace br_pickups
// Params 1
// Checksum 0x24785951, Offset: 0x70e8
// Size: 0x17
function function_bb0787b9230d2a4a( scriptablename )
{
    return issubstr( scriptablename, "activity_starter" );
}

// Namespace br_pickups
// Params 1
// Checksum 0x589cefb6, Offset: 0x7108
// Size: 0x26, Type: bool
function iskey( scriptablename )
{
    return issubstr( scriptablename, "loot_key" ) || issubstr( scriptablename, "loot_multi_key" );
}

// Namespace br_pickups
// Params 1
// Checksum 0xccdf3df2, Offset: 0x7137
// Size: 0x17
function function_d1bdfe41ee9800f9( scriptablename )
{
    return issubstr( scriptablename, "loot_multi_key" );
}

// Namespace br_pickups
// Params 1
// Checksum 0x84c7088a, Offset: 0x7157
// Size: 0x17
function function_1f87e4642e088efd( scriptablename )
{
    return issubstr( scriptablename, "brloot_drone_part" );
}

// Namespace br_pickups
// Params 1
// Checksum 0xab96c602, Offset: 0x7177
// Size: 0x20, Type: bool
function isnonequippable( scriptablename )
{
    return scriptablename == "br_loot_cache" || isquesttablet( scriptablename );
}

// Namespace br_pickups
// Params 1
// Checksum 0xd44a3cdc, Offset: 0x71a0
// Size: 0x2c, Type: bool
function isvaluable( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"valuable";
}

// Namespace br_pickups
// Params 1
// Checksum 0xb8bc7ee7, Offset: 0x71d5
// Size: 0x2c, Type: bool
function ispersonal( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"personal";
}

// Namespace br_pickups
// Params 1
// Checksum 0xe1b02ef5, Offset: 0x720a
// Size: 0x2c, Type: bool
function function_b60b7e1e86789b5a( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"mission";
}

// Namespace br_pickups
// Params 1
// Checksum 0x4743ab97, Offset: 0x723f
// Size: 0x25, Type: bool
function function_659a09a211112eaa( scriptablename )
{
    return level.br_pickups.var_ebf8e39c046809af[ scriptablename ] == 1;
}

// Namespace br_pickups
// Params 1
// Checksum 0x49c26471, Offset: 0x726d
// Size: 0x2c, Type: bool
function iscache( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"cache";
}

// Namespace br_pickups
// Params 1
// Checksum 0x9cdda34c, Offset: 0x72a2
// Size: 0x2c, Type: bool
function function_7019629f2a3b016c( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"lethal";
}

// Namespace br_pickups
// Params 1
// Checksum 0x54ac2564, Offset: 0x72d7
// Size: 0x2c, Type: bool
function function_a1f9f8123c01bb3b( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"tactical";
}

// Namespace br_pickups
// Params 1
// Checksum 0xc4e57b73, Offset: 0x730c
// Size: 0x2c, Type: bool
function isnvg( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"nvg";
}

// Namespace br_pickups
// Params 1
// Checksum 0x799c44a3, Offset: 0x7341
// Size: 0x2c, Type: bool
function isdisguise( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"disguise";
}

// Namespace br_pickups
// Params 1
// Checksum 0x875c8c42, Offset: 0x7376
// Size: 0x2c, Type: bool
function isweaponpart( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"weaponpart";
}

// Namespace br_pickups
// Params 1
// Checksum 0xf44aa331, Offset: 0x73ab
// Size: 0x2c, Type: bool
function isgascan( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"gascan";
}

// Namespace br_pickups
// Params 1
// Checksum 0x991f6926, Offset: 0x73e0
// Size: 0x3a, Type: bool
function function_9839731fa9d707c0( lootid )
{
    if ( !isdefined( lootid ) )
    {
        return false;
    }
    
    scriptable = loot::getScriptableFromLootID( lootid );
    
    if ( !isdefined( scriptable ) )
    {
        return false;
    }
    
    return isgascan( scriptable );
}

// Namespace br_pickups
// Params 1
// Checksum 0x675ad3d9, Offset: 0x7423
// Size: 0x50
function istempv( scriptablename )
{
    if ( !isdefined( level.br_pickups.br_itemtype[ scriptablename ] ) )
    {
        return 0;
    }
    
    switch ( scriptablename )
    {
        case #"hash_37befa6a4b547903":
            return 1;
        default:
            return 0;
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0xdfa6311d, Offset: 0x747b
// Size: 0x43
function isgametypeitem( scriptablename )
{
    if ( utility::issharedfuncdefined( #"gametype", #"isgametypeitem" ) )
    {
        return utility::callsharedfunc( #"gametype", #"isgametypeitem", scriptablename );
    }
    
    return 0;
}

// Namespace br_pickups
// Params 1
// Checksum 0x1f18ae90, Offset: 0x74c7
// Size: 0x14, Type: bool
function isrock( scriptablename )
{
    return scriptablename == "brloot_rock";
}

// Namespace br_pickups
// Params 1
// Checksum 0xa29dc344, Offset: 0x74e4
// Size: 0x14, Type: bool
function function_10c0573255b72cb6( scriptablename )
{
    return scriptablename == "brloot_payment_hacker_phone";
}

// Namespace br_pickups
// Params 1
// Checksum 0x20ac3622, Offset: 0x7501
// Size: 0x14, Type: bool
function function_48864b4e9a0f3040( scriptablename )
{
    return scriptablename == "brloot_wz_payment_exe_phone";
}

// Namespace br_pickups
// Params 1
// Checksum 0x86800e86, Offset: 0x751e
// Size: 0x38, Type: bool
function function_b6ce9af1f1dbcb98( scriptablename )
{
    return isvaluable( scriptablename ) || isdogtag( scriptablename ) || ispersonal( scriptablename ) || function_b60b7e1e86789b5a( scriptablename );
}

// Namespace br_pickups
// Params 1
// Checksum 0xf6d6900e, Offset: 0x755f
// Size: 0x14, Type: bool
function function_22e6daf22d974762( scriptablename )
{
    return scriptablename == "brloot_shopkeeper_code";
}

// Namespace br_pickups
// Params 2
// Checksum 0xaa4259a9, Offset: 0x757c
// Size: 0x35, Type: bool
function function_e44a0803d593564( lootid, scriptablename = loot::getScriptableFromLootID( lootid ) )
{
    if ( !isdefined( scriptablename ) )
    {
        return false;
    }
    
    return scriptablename == "brloot_offhand_advancedvehicledrop";
}

// Namespace br_pickups
// Params 1
// Checksum 0xdc045a98, Offset: 0x75ba
// Size: 0x1d, Type: bool
function function_7aa665f61b561c66( scriptablename )
{
    if ( !isdefined( scriptablename ) )
    {
        return false;
    }
    
    return scriptablename == "brloot_offhand_deconstation";
}

// Namespace br_pickups
// Params 2
// Checksum 0xbcc27634, Offset: 0x75e0
// Size: 0xb2, Type: bool
function function_bcc6dc9b2b7365e0( lootid, scriptablename )
{
    if ( !isdefined( lootid ) && !isdefined( scriptablename ) )
    {
        return false;
    }
    
    if ( !isdefined( scriptablename ) )
    {
        scriptablename = loot::getScriptableFromLootID( lootid );
    }
    
    if ( !isdefined( scriptablename ) )
    {
        return false;
    }
    
    return dmz_dog_tag::function_7b2fcbd8d8d2e2a3( lootid ) || isgasmask( scriptablename ) || ishelmet( scriptablename ) || isgascan( scriptablename ) || function_3d06a36003e339e4( scriptablename ) || br_public::isheartbeatsensor( scriptablename ) || function_22e6daf22d974762( scriptablename ) || isdisguise( scriptablename ) || function_e587e310ab3d3b77( scriptablename ) || function_7aa665f61b561c66( scriptablename );
}

// Namespace br_pickups
// Params 1
// Checksum 0x1ba28097, Offset: 0x769b
// Size: 0x2c, Type: bool
function function_40f12dd872f2f27( scriptablename )
{
    return level.br_pickups.br_itemtype[ scriptablename ] == #"breakable_tool";
}

// Namespace br_pickups
// Params 2
// Checksum 0x5fd72fe7, Offset: 0x76d0
// Size: 0x8a, Type: bool
function function_2cc3cc4201a9040e( contractref, player )
{
    whitelist = tolower( getdvar( hashcat( @"hash_6c7b8805d40e0639", contractref ) ) );
    
    if ( !isdefined( whitelist ) || whitelist == "" )
    {
        return true;
    }
    
    var_25007f7844a6b748 = strtok( whitelist, " " );
    playername = tolower( player.name );
    
    if ( arraycontains( var_25007f7844a6b748, playername ) )
    {
        return true;
    }
    
    return false;
}

// Namespace br_pickups
// Params 4
// Checksum 0x4da0be43, Offset: 0x7763
// Size: 0xe4
function function_e2df2f8df3b3ce9a( ref, lootid, quantity, var_b8b2f39fcba6d824 )
{
    if ( !( isdefined( ref ) && isdefined( lootid ) && isdefined( quantity ) ) )
    {
        return 0;
    }
    
    fakepickup = spawnstruct();
    fakepickup.scriptablename = ref;
    fakepickup.count = quantity;
    result = function_bb73d66fb7091aaa( fakepickup, canholdammobox( ref ) );
    
    if ( result == 1 )
    {
        function_55de798ca5dc4080( lootid, undefined, var_b8b2f39fcba6d824, quantity );
        br_weapons::br_ammo_give_type( self, ref, quantity, 1 );
        return 1;
    }
    
    if ( result == 20 )
    {
        function_55de798ca5dc4080( lootid, undefined, var_b8b2f39fcba6d824, quantity );
        common_inventory::function_d3959596f4031a1d( lootid, fakepickup.count );
        return 1;
    }
    
    showuseresultsfeedback( result );
    return 0;
}

// Namespace br_pickups
// Params 2
// Checksum 0xe03fc8ca, Offset: 0x784f
// Size: 0x68
function function_dd4c2584cac2343e( pickup, isautouse )
{
    lootid = loot::function_d3e3bcaea591a6a2( pickup.scriptablename );
    result = common_inventory::function_e332683b9ad5368b( lootid, pickup.count );
    
    if ( result )
    {
        return 1;
    }
    
    if ( isautouse )
    {
        return 12;
    }
    
    return 4;
}

// Namespace br_pickups
// Params 2
// Checksum 0xebd70933, Offset: 0x78bf
// Size: 0x68
function function_3a6d2dc9abde2071( pickup, isautouse )
{
    lootid = loot::function_d3e3bcaea591a6a2( pickup.scriptablename );
    result = common_inventory::function_e332683b9ad5368b( lootid, pickup.count );
    
    if ( result )
    {
        return 20;
    }
    
    if ( isautouse )
    {
        return 12;
    }
    
    return 4;
}

// Namespace br_pickups
// Params 2
// Checksum 0xf152d7b, Offset: 0x792f
// Size: 0xdf
function function_bb73d66fb7091aaa( pickup, var_154443dbdffc0411 )
{
    var_5f792c975816fdf = 0;
    
    if ( pickup.count + self.br_ammo[ pickup.scriptablename ] <= level.br_ammo_max_stock[ pickup.scriptablename ] )
    {
        var_5f792c975816fdf = 1;
    }
    
    if ( var_154443dbdffc0411 && var_5f792c975816fdf )
    {
        return 1;
    }
    
    lootid = loot::function_d3e3bcaea591a6a2( pickup.scriptablename );
    result = common_inventory::function_e332683b9ad5368b( lootid, pickup.count );
    
    if ( result || self.br_ammo[ pickup.scriptablename ] < level.br_ammo_max_stock[ pickup.scriptablename ] )
    {
        return 20;
    }
    
    return 4;
}

// Namespace br_pickups
// Params 2
// Checksum 0x8340649c, Offset: 0x7a17
// Size: 0x1814
function cantakepickup( pickup, var_a5bc9c8c270532d1 )
{
    if ( utility::issharedfuncdefined( #"gametype", #"cantakepickup" ) )
    {
        result = utility::callsharedfunc( #"gametype", #"cantakepickup", pickup );
        
        if ( result > 0 )
        {
            return result;
        }
    }
    
    if ( self isskydiving() )
    {
        return 9;
    }
    
    if ( br_public::isammo( pickup.scriptablename ) )
    {
        if ( self.isjuggernaut && !juggernaut::jugg_canuseweaponpickups() )
        {
            return 16;
        }
        
        var_154443dbdffc0411 = canholdammobox( pickup.scriptablename );
        
        if ( !level.var_e8b92f135862392e && common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
        {
            return function_bb73d66fb7091aaa( pickup, var_154443dbdffc0411 );
        }
        else if ( var_154443dbdffc0411 )
        {
            return 1;
        }
        else
        {
            return 4;
        }
    }
    
    isautouse = istrue( pickup.isautouse );
    
    if ( pickups::isweaponpickupitem( pickup ) )
    {
        if ( self.isjuggernaut && !juggernaut::jugg_canuseweaponpickups() )
        {
            return 16;
        }
        
        if ( level.var_bf3cba06830a0e49 == 1 )
        {
            if ( self.insertingarmorplate )
            {
                return 13;
            }
        }
        
        if ( vehicle::is_in_vehicle() )
        {
            return 17;
        }
        
        newweapon = br_weapons::function_e21fbe40c5ae575e( pickup )[ 0 ];
        
        foreach ( weap in self.primaryweapons )
        {
            if ( issameweapon( weap, newweapon ) )
            {
                fakepickup = spawnstruct();
                fakepickup.scriptablename = br_weapons::br_ammo_type_for_weapon( newweapon );
                fakepickup.count = weaponclipsize( newweapon );
                
                if ( isdefined( fakepickup.scriptablename ) )
                {
                    result = function_bb73d66fb7091aaa( fakepickup, canholdammobox( pickup.scriptablename ) );
                    
                    if ( result == 1 )
                    {
                        return 5;
                    }
                    else if ( result == 20 )
                    {
                        return 27;
                    }
                    
                    return 28;
                }
                
                return 28;
            }
        }
        
        if ( common_inventory::function_d33e11a8dda3cb20() )
        {
            playerdataweapon = common_inventory::function_7bf60ff8870e96b4();
            
            if ( issameweapon( playerdataweapon, newweapon ) )
            {
                fakepickup = spawnstruct();
                fakepickup.scriptablename = br_weapons::br_ammo_type_for_weapon( newweapon );
                fakepickup.count = weaponclipsize( newweapon );
                
                if ( isdefined( fakepickup.scriptablename ) )
                {
                    result = function_bb73d66fb7091aaa( fakepickup, canholdammobox( pickup.scriptablename ) );
                    
                    if ( result == 1 )
                    {
                        return 5;
                    }
                    else if ( result == 20 )
                    {
                        return 27;
                    }
                    
                    return 28;
                }
                else
                {
                    return 28;
                }
            }
        }
        
        if ( !isdefined( pickup.lootid ) )
        {
            pickup.lootid = loot::function_d3e3bcaea591a6a2( pickup.scriptablename );
        }
        
        if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
        {
            script::demoforcesre( "shouldWeaponPickupGoToBackpack is deprecated. Add in common_inventory system logic instead." );
            result = common_inventory::function_e332683b9ad5368b( pickup.lootid, pickup.count );
            
            if ( result )
            {
                return 20;
            }
        }
        
        if ( self isautograbweaponsenabled() )
        {
            if ( isautouse && !function_7746e3e9ecf31195( pickup, newweapon ) )
            {
                return 12;
            }
        }
        
        return 1;
    }
    
    if ( br_public::isequipment( pickup.scriptablename ) )
    {
        if ( self.isjuggernaut )
        {
            return 16;
        }
        
        equipname = level.br_pickups.br_equipname[ pickup.scriptablename ];
        slot = level.equipment.table[ equipname ].defaultslot;
        pickupcount = 1;
        
        if ( isdefined( pickup.count ) )
        {
            pickupcount = pickup.count;
        }
        
        if ( isautouse && ( slot == "primary" || slot == "secondary" ) )
        {
            if ( isdefined( self.equipment[ slot ] ) && pickupissameasequipmentslot( equipname, slot ) && equipmentslothasroom( pickup.scriptablename, slot ) )
            {
                if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
                {
                    currentslotammo = equipment_mp::getequipmentslotammo( slot );
                    lootid = loot::function_d3e3bcaea591a6a2( pickup.scriptablename );
                    
                    if ( !isdefined( lootid ) )
                    {
                        lootid = 0;
                    }
                    
                    itemindex = common_inventory::function_d57aa72eb94634f9( lootid );
                    
                    if ( !isdefined( itemindex ) || currentslotammo > 0 )
                    {
                        return 1;
                    }
                }
                else
                {
                    return 1;
                }
            }
            
            if ( !common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
            {
                if ( getdvarint( @"hash_752eeed3ddcbd04b", 0 ) && ( !isdefined( self.equipment[ slot ] ) || equipment_mp::getequipmentslotammo( slot ) == 0 ) )
                {
                    return 1;
                }
                
                return 12;
            }
        }
        
        var_e2abf9aa8a371372 = !isautouse || slot == "health";
        
        if ( var_e2abf9aa8a371372 && ( !isdefined( self.equipment[ slot ] ) || equipment_mp::getequipmentslotammo( slot ) == 0 ) )
        {
            return 1;
        }
        
        if ( pickupissameasequipmentslot( equipname, slot ) )
        {
            if ( equipmentslothasroom( pickup.scriptablename, slot ) )
            {
                return 1;
            }
            else if ( !isautouse )
            {
                if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
                {
                    return function_3a6d2dc9abde2071( pickup, isautouse );
                }
                else
                {
                    return 4;
                }
            }
        }
        
        if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
        {
            if ( !var_a5bc9c8c270532d1 )
            {
                return function_3a6d2dc9abde2071( pickup, isautouse );
            }
            else
            {
                return 1;
            }
        }
        else
        {
            return 1;
        }
    }
    
    if ( isgametypeitem( pickup.scriptablename ) && utility::issharedfuncdefined( #"gametype", #"hash_ebc45fd32e3dcae7" ) )
    {
        if ( utility::callsharedfunc( #"gametype", #"hash_ebc45fd32e3dcae7", pickup.scriptablename, self ) )
        {
            return 1;
        }
    }
    
    if ( isplunder( pickup.scriptablename ) )
    {
        if ( isdefined( level.br_plunder ) && self.plundercount >= level.br_plunder.plunderlimit )
        {
            return 11;
        }
        
        return 1;
    }
    
    if ( br_public::isvoucher( pickup.scriptablename ) )
    {
        return 1;
    }
    
    if ( isgasmask( pickup.scriptablename ) )
    {
        if ( self.isjuggernaut )
        {
            return 16;
        }
        
        if ( getdvarint( @"hash_752eeed3ddcbd04b", 0 ) && isautouse && gasmask::hasgasmask( self ) )
        {
            if ( getdvarint( @"hash_e3bbc876e8c8249e", 0 ) && pickup.count > self.gasmaskhealth )
            {
                return 1;
            }
            
            return 12;
        }
        
        if ( var_a5bc9c8c270532d1 )
        {
            return 1;
        }
        
        if ( gasmask::hasgasmask( self ) && pickup.count <= self.gasmaskhealth && common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
        {
            fakepickup = spawnstruct();
            fakepickup.scriptablename = pickup.scriptablename;
            fakepickup.count = 1;
            return function_3a6d2dc9abde2071( fakepickup, isautouse );
        }
        
        return 1;
    }
    
    if ( ishelmet( pickup.scriptablename ) )
    {
        return 1;
    }
    
    if ( function_56d8ca44f91af7c( pickup.scriptablename ) )
    {
        if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
        {
            return function_3a6d2dc9abde2071( pickup, isautouse );
        }
        
        return 1;
    }
    
    if ( isquesttablet( pickup.scriptablename ) )
    {
        if ( isdefined( pickup.instance ) )
        {
            if ( !isdefined( pickup.instance.task ) )
            {
                br_contract_manager::function_a0e70de0d9b56fb0( pickup.instance, pickup.instance.type );
                
                if ( isdefined( pickup.instance.task ) && isdefined( pickup.instance.task.safestructs ) )
                {
                    if ( !pickup.instance.task.safestructs.size < 0 )
                    {
                        logstring( "Safecracker ERROR: Tried to generate safe locations on pickup and generation failed" );
                    }
                    
                    assert( pickup.instance.task.safestructs.size > 0, "<dev string:xbc>" );
                }
            }
        }
        
        assert( isdefined( pickup.instance.task ), "<dev string:xfc>" + pickup.scriptablename );
        
        if ( !function_2cc3cc4201a9040e( pickup.instance.task.type.ref, self ) )
        {
            return 33;
        }
        
        if ( function_e83c60c3a6451be3( pickup.scriptablename ) )
        {
            var_56f923b51774a5f1 = getdvarint( @"hash_441931632f11125e", 1 );
            
            if ( var_56f923b51774a5f1 )
            {
                var_8c5d6aade11f5b10 = getdvar( @"hash_55d6af015c42ab58", "11200+11201+1001" );
                featurebans = [];
                
                if ( isdefined( var_8c5d6aade11f5b10 ) && var_8c5d6aade11f5b10.size )
                {
                    featurebans = strtok( var_8c5d6aade11f5b10, "+" );
                }
                
                if ( isdefined( featurebans ) )
                {
                    foreach ( featureban in featurebans )
                    {
                        var_6132079b6bf7d49b = self function_c61e257d2f3c6251( int( featureban ) );
                        
                        if ( var_6132079b6bf7d49b )
                        {
                            return 33;
                        }
                    }
                }
            }
            
            result = pickup.instance.task br_elite_broken_arrow::function_1054f70a6fa25397( self );
            
            if ( isstring( result ) )
            {
                if ( result == "too_many_teammates" )
                {
                    return 35;
                }
            }
        }
        
        if ( pickup.scriptablename == "brloot_blueprintextract_tablet" )
        {
            return 1;
        }
        else
        {
            alreadyhavequest = br_contract_manager::function_af264a228f8c4b11( self.team ) || br_contract_manager::function_9cb0572c407b9880( br_contract_manager::function_6b738bc71eb53bd4() );
            
            if ( alreadyhavequest )
            {
                if ( self.canhackcontracts )
                {
                    return 41;
                }
                
                return 10;
            }
            else
            {
                return 1;
            }
        }
    }
    
    if ( isperkpointpickup( pickup.scriptablename ) )
    {
        if ( self.isjuggernaut )
        {
            return 16;
        }
        
        return 1;
    }
    
    if ( istokenpickup( pickup.scriptablename ) )
    {
        if ( self.isjuggernaut )
        {
            return 16;
        }
        
        if ( pickup.scriptablename == "brloot_redeploy_token" )
        {
            if ( br_public::hasrespawntoken() )
            {
                if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
                {
                    return function_3a6d2dc9abde2071( pickup );
                }
                else
                {
                    return 8;
                }
            }
            else
            {
                return 1;
            }
        }
        
        if ( function_c45997117794b25f( pickup.scriptablename ) )
        {
            if ( isdefined( level.gulag ) && ( br_public::function_70c1f4b75530023f() || br_gulag::checkgulagusecount() ) )
            {
                if ( br_public::function_70c1f4b75530023f() )
                {
                    return 36;
                }
                else
                {
                    return 1;
                }
            }
            else
            {
                return 1;
            }
        }
        
        return 1;
    }
    
    if ( isrevivepickup( pickup.scriptablename ) )
    {
        if ( self.isjuggernaut )
        {
            return 16;
        }
        
        if ( pickup.scriptablename == "brloot_self_revive" || pickup.scriptablename == "brloot_battlerage_self_revive" )
        {
            if ( laststand::hasselfrevivetoken() && br_public::function_69153dc21f82c59a( self, pickup.scriptablename ) )
            {
                if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
                {
                    return function_3a6d2dc9abde2071( pickup, isautouse );
                }
                else if ( isautouse )
                {
                    return 12;
                }
                else
                {
                    return 14;
                }
            }
            else
            {
                return 1;
            }
        }
        
        return 1;
    }
    
    if ( iskillstreak( pickup.scriptablename ) )
    {
        killstreakref = level.br_pickups.br_lootreference[ pickup.scriptablename ];
        
        if ( self.isjuggernaut )
        {
            return 16;
        }
        
        if ( level.var_e541c2ff59ae7571 && weapon::iskillstreakweapon( self getcurrentweapon() ) )
        {
            return 7;
        }
        
        if ( var_a5bc9c8c270532d1 && !getdvarint( @"hash_752eeed3ddcbd04b", 0 ) )
        {
            if ( isdefined( self.streakdata ) && isdefined( self.streakdata.streaks[ 1 ] ) && common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) && self.streakdata.streaks.size > 0 && self.streakdata.streaks[ 1 ].streakname == level.br_pickups.br_lootreference[ pickup.scriptablename ] )
            {
                return function_3a6d2dc9abde2071( pickup, isautouse );
            }
            else
            {
                return 1;
            }
        }
        
        if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
        {
            script::demoforcesre( "shouldKillstreakGoToBackpack is deprecated. Add in common_inventory system logic instead." );
        }
        
        if ( isdefined( self.streakdata ) && isdefined( self.streakdata.streaks[ 1 ] ) && self.streakdata.streaks.size > 0 && self.streakdata.streaks[ 1 ].streakname == level.br_pickups.br_lootreference[ pickup.scriptablename ] )
        {
            return 7;
        }
        else if ( getdvarint( @"hash_752eeed3ddcbd04b", 0 ) && isautouse && isdefined( self.streakdata ) && isdefined( self.streakdata.streaks ) && self.streakdata.streaks.size != 0 )
        {
            return 12;
        }
        else
        {
            return 1;
        }
    }
    
    if ( issuperpickup( pickup.scriptablename ) )
    {
        if ( self.isjuggernaut )
        {
            return 16;
        }
        else if ( function_e44a0803d593564( undefined, pickup.scriptablename ) && !br_gametype_truckwar::function_69613cfdb96f05b8() )
        {
            return 39;
        }
        
        currentsuper = supers_mp::getcurrentsuperref();
        
        if ( !supers_mp::issuperinuse() && !supers_mp::function_ec7e2ab9a462557b() && !self isthrowinggrenade() )
        {
            equipammo = equipment_mp::getequipmentslotammo( "super" );
            
            if ( getdvarint( @"hash_752eeed3ddcbd04b", 0 ) && isautouse && isdefined( equipammo ) && equipammo != 0 )
            {
                return 12;
            }
            else if ( !isdefined( equipammo ) || equipammo == 0 || !common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
            {
                if ( getdvarint( @"hash_fb6fdaa2e155eb88", 0 ) && isdefined( currentsuper ) && isdefined( level.br_pickups.br_lootreference[ pickup.scriptablename ] ) && level.br_pickups.br_lootreference[ pickup.scriptablename ] == currentsuper && equipammo > 0 )
                {
                    return 39;
                }
                else
                {
                    return 1;
                }
            }
        }
        
        if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
        {
            if ( var_a5bc9c8c270532d1 )
            {
                if ( level.br_pickups.br_lootreference[ pickup.scriptablename ] == currentsuper )
                {
                    result = function_3a6d2dc9abde2071( pickup );
                    
                    if ( result == 4 && !supers_mp::issuperinuse() && !supers_mp::function_ec7e2ab9a462557b() )
                    {
                        return 29;
                    }
                    else
                    {
                        return result;
                    }
                }
                else if ( supers_mp::issuperinuse() || supers_mp::function_ec7e2ab9a462557b() )
                {
                    result = function_3a6d2dc9abde2071( pickup );
                    
                    if ( result == 4 && !supers_mp::issuperinuse() )
                    {
                        return 29;
                    }
                    else
                    {
                        return result;
                    }
                }
                else if ( self isthrowinggrenade() )
                {
                    result = function_3a6d2dc9abde2071( pickup );
                    
                    if ( result != 20 )
                    {
                        result = 2;
                    }
                    
                    return result;
                }
                else
                {
                    return 1;
                }
            }
            else if ( supers_mp::issuperinuse() && !supers_mp::function_ec7e2ab9a462557b() )
            {
                script::demoforcesre( "shouldFieldUpgradeGoToBackpack is deprecated. Add in common_inventory system logic instead." );
                result = function_3a6d2dc9abde2071( pickup );
                
                if ( result == 4 && !supers_mp::issuperinuse() )
                {
                    return 29;
                }
                else
                {
                    return result;
                }
            }
        }
        
        return 4;
    }
    
    if ( function_36092a934fe35d06( pickup.scriptablename ) )
    {
        if ( self.isjuggernaut )
        {
            return 16;
        }
        
        if ( common_inventory::function_5c64d2b24a8c3e18() && !getdvarint( @"hash_ff7a56b91e81bd5d" ) )
        {
            return function_3a6d2dc9abde2071( pickup, isautouse );
        }
        else
        {
            return 1;
        }
    }
    
    if ( br_public::isarmor( pickup.scriptablename ) )
    {
        if ( self.isjuggernaut )
        {
            return 16;
        }
        
        if ( armor::function_df826fddef9a9e3f( level.br_pickups.br_equipname[ pickup.scriptablename ] ) )
        {
            return 1;
        }
        else
        {
            return 6;
        }
    }
    
    if ( function_e2035e1b9faa4f6a( pickup.scriptablename ) )
    {
        if ( self.isjuggernaut )
        {
            return 16;
        }
        
        if ( isdefined( self.perks[ "specialty_pc_high_capacity" ] ) )
        {
            if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
            {
                return function_3a6d2dc9abde2071( pickup );
            }
            else
            {
                return 15;
            }
        }
        
        return 1;
    }
    
    if ( function_e380482ca8f0de4b( pickup.scriptablename ) )
    {
        if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
        {
            if ( !isdefined( pickup.count ) )
            {
                pickup.count = 1;
            }
            
            return function_3a6d2dc9abde2071( pickup );
        }
        
        return 1;
    }
    
    if ( isaccesscard( pickup.scriptablename ) )
    {
        if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
        {
            return function_3a6d2dc9abde2071( pickup );
        }
        
        return 1;
    }
    
    if ( function_e587e310ab3d3b77( pickup.scriptablename ) )
    {
        if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
        {
            return function_3a6d2dc9abde2071( pickup );
        }
        
        return 1;
    }
    
    if ( isattachment( pickup.scriptablename ) )
    {
        if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
        {
            return function_3a6d2dc9abde2071( pickup );
        }
    }
    
    if ( isxp( pickup.scriptablename ) )
    {
        return 1;
    }
    
    if ( function_bb0787b9230d2a4a( pickup.scriptablename ) )
    {
        return 1;
    }
    
    if ( iskey( pickup.scriptablename ) )
    {
        if ( function_ce9a9f8d70afdf01( pickup.scriptablename ) )
        {
            if ( self.var_30d27a6f168d83e1 )
            {
                return 23;
            }
            else
            {
                return 1;
            }
        }
        
        if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
        {
            lootid = loot::function_d3e3bcaea591a6a2( pickup.scriptablename );
            script::demoforcesre( "getFirstAvailableStackableIndex is deprecated. Add in common_inventory system logic instead." );
            return function_3a6d2dc9abde2071( pickup );
        }
        
        return 1;
    }
    
    if ( isquestitem( pickup.scriptablename ) )
    {
        if ( isdefined( pickup.instance.team ) && self.team == pickup.instance.team )
        {
            return 1;
        }
        else
        {
            return 4;
        }
    }
    
    if ( function_1578d9983da7761a( pickup.scriptablename ) )
    {
        if ( pickup br_elite_broken_arrow::function_770bbad081e3c123( self ) )
        {
            return function_a35730a988baa527( pickup );
        }
    }
    
    if ( isspecialistbonus( pickup.scriptablename ) )
    {
        if ( self.isjuggernaut )
        {
            return 16;
        }
        
        if ( br_public::hasspecialistbonus() )
        {
            return 18;
        }
        
        return 1;
    }
    
    if ( pickup.scriptablename == "brloot_ammo_grenade" )
    {
        if ( self.isjuggernaut )
        {
            return 16;
        }
        
        primaryammocount = equipment_mp::getequipmentslotammo( "primary" );
        secondaryammocount = equipment_mp::getequipmentslotammo( "secondary" );
        
        if ( primaryammocount < 2 || secondaryammocount < 2 )
        {
            return 1;
        }
        else
        {
            return 3;
        }
    }
    
    if ( pickup.scriptablename == "Pillage_Cache" )
    {
        return 1;
    }
    
    if ( isvaluable( pickup.scriptablename ) || ispersonal( pickup.scriptablename ) || isnvg( pickup.scriptablename ) || isgascan( pickup.scriptablename ) || isnote( pickup.scriptablename ) || function_b60b7e1e86789b5a( pickup.scriptablename ) || function_40f12dd872f2f27( pickup.scriptablename ) || isdisguise( pickup.scriptablename ) || isweaponpart( pickup.scriptablename ) )
    {
        if ( isdefined( level.missionitemcallbacks[ pickup.scriptablename ] ) )
        {
            var_7237854e3be197ca = [[ level.missionitemcallbacks[ pickup.scriptablename ] ]]( pickup, self );
            
            if ( isdefined( var_7237854e3be197ca ) )
            {
                return var_7237854e3be197ca;
            }
        }
        
        if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
        {
            return function_3a6d2dc9abde2071( pickup );
        }
        
        return 1;
    }
    
    if ( isweaponcase( pickup.scriptablename ) )
    {
        if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
        {
            return function_3a6d2dc9abde2071( pickup );
        }
        
        return 1;
    }
    
    if ( isdogtag( pickup.scriptablename ) )
    {
        if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) )
        {
            return function_3a6d2dc9abde2071( pickup );
        }
        
        return 1;
    }
    
    if ( function_8b2f7f58a48bed48( pickup.scriptablename ) )
    {
        if ( isdefined( level.secondaryvictory ) )
        {
            if ( [[ level.secondaryvictory.var_c2782cd369af1416 ]]() )
            {
                return 1;
            }
            else
            {
                return 2;
            }
        }
    }
    
    if ( function_49be4ae122d13f2e( pickup.scriptablename ) )
    {
        return 1;
    }
    
    if ( function_cfce107ef35a347e( pickup.scriptablename ) )
    {
        return function_3a6d2dc9abde2071( pickup );
    }
    
    if ( br_public::function_d115f1547e28f0c6( pickup.scriptablename ) )
    {
        platelevel = br_public::function_f7d29d5dab587ae1( pickup.scriptablename );
        
        if ( self.platecarrierlevel < platelevel || isdefined( self.platecarriertype ) && pickup.scriptablename != self.platecarriertype )
        {
            return 1;
        }
        
        return function_3a6d2dc9abde2071( pickup );
    }
    
    if ( isperkpack( pickup.scriptablename ) )
    {
        if ( self.isjuggernaut )
        {
            return 16;
        }
        
        if ( var_a5bc9c8c270532d1 )
        {
            return 1;
        }
        
        if ( common_inventory::function_7ec5937e3b3d86e0( pickup.scriptablename ) && namespace_5ab67a14d18bea3f::function_3a6825469c3df4a3() )
        {
            result = function_3a6d2dc9abde2071( pickup );
            
            if ( result == 4 )
            {
                return 29;
            }
            else
            {
                return result;
            }
        }
        
        return 1;
    }
    
    if ( function_d39ca17df2c672e8( pickup.scriptablename ) )
    {
        return 1;
    }
    
    if ( iseventcard( pickup.scriptablename ) )
    {
        return 1;
    }
    
    if ( function_18c9ebe68283fe1c( pickup.scriptablename ) )
    {
        if ( pickup.instance.player == self )
        {
            return 1;
        }
        else
        {
            return 37;
        }
    }
    
    return 2;
}

// Namespace br_pickups
// Params 1
// Checksum 0x24529021, Offset: 0x9234
// Size: 0x33, Type: bool
function isdroppablepickup( pickupname )
{
    if ( weapon::isfistweapon( pickupname ) || weapon::isgunlessweapon( pickupname ) || weapon::ismeleeoverrideweapon( pickupname ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br_pickups
// Params 8
// Checksum 0x7c62a90c, Offset: 0x9270
// Size: 0x765
function spawnpickup( pickupname, dropinfo, count, showtrail, weaponobj, allowautopickup, countlefthand, countalt )
{
    if ( !isdefined( dropinfo ) )
    {
        println( "<dev string:x13b>" + pickupname + "<dev string:x15b>" );
        return;
    }
    
    if ( dropinfo.origin == ( 0, 0, 0 ) )
    {
        println( "<dev string:x13b>" + pickupname + "<dev string:x1a0>" );
        return;
    }
    
    assert( isdefined( dropinfo.origin ) );
    assert( isdefined( dropinfo.angles ) );
    assert( isdefined( dropinfo.payload ) );
    var_2c1e489e33df7534 = 0;
    assert( isdefined( pickupname ) );
    scriptabledefname = undefined;
    
    if ( isdefined( weaponobj ) )
    {
        fullweapon = getcompleteweaponname( weaponobj );
        
        if ( isdefined( level.br_pickups.var_14163aac44e08274[ fullweapon ] ) )
        {
            scriptabledefname = level.br_pickups.var_14163aac44e08274[ fullweapon ];
        }
    }
    
    if ( !isdefined( scriptabledefname ) )
    {
        if ( isdefined( level.var_4282cf0f3d1c8e74 ) && level.var_4282cf0f3d1c8e74 != 1 )
        {
            if ( isdefined( level.br_pickups.br_weapontoscriptable[ pickupname ] ) )
            {
                scriptabledefname = level.br_pickups.br_weapontoscriptable[ pickupname ];
            }
            else if ( arraycontains( level.br_pickups.br_weapontoscriptable, pickupname ) )
            {
                scriptabledefname = pickupname;
            }
        }
        
        if ( !isdefined( scriptabledefname ) )
        {
            if ( isdroppablepickup( pickupname ) )
            {
                scriptabledefname = pickupname;
            }
        }
    }
    
    if ( !isdefined( scriptabledefname ) )
    {
        assert( !isdroppablepickup( pickupname ), "<dev string:x1e1>" + pickupname );
        return;
    }
    
    statesuffix = "";
    
    if ( issubstr( scriptabledefname, "la_juliet" ) )
    {
        dropinfo.angles = ( dropinfo.angles[ 0 ] - 4.2, dropinfo.angles[ 1 ], dropinfo.angles[ 2 ] - 90 );
        dropinfo.origin = ( dropinfo.origin[ 0 ], dropinfo.origin[ 1 ], dropinfo.origin[ 2 ] + 8.5 );
    }
    
    translationoffset = level.br_pickups.translationoffset[ scriptabledefname ];
    rotationoffset = level.br_pickups.rotationoffset[ scriptabledefname ];
    
    if ( isdefined( translationoffset ) )
    {
        dropinfo.origin = coordtransform( translationoffset, dropinfo.origin, dropinfo.angles );
    }
    
    if ( isdefined( rotationoffset ) )
    {
        dropinfo.angles = rotationoffset + dropinfo.angles;
    }
    
    pickups::clearspaceforscriptableinstance();
    
    if ( var_2c1e489e33df7534 )
    {
        item = spawncustomweaponscriptable( scriptabledefname, dropinfo.origin, dropinfo.angles, undefined, dropinfo.payload, weaponobj );
        
        if ( isdefined( item ) )
        {
            item.customweaponname = getcompleteweaponname( weaponobj );
        }
    }
    else if ( namespace_5ab67a14d18bea3f::function_e96bd96c3a428bb8( scriptabledefname ) )
    {
        while ( dropinfo.customperkpayload.size < 5 )
        {
            dropinfo.customperkpayload[ dropinfo.customperkpayload.size ] = 0;
        }
        
        item = spawnscriptable( scriptabledefname, dropinfo.origin, dropinfo.angles, undefined, dropinfo.payload, dropinfo.customperkpayload );
    }
    else if ( isdefined( dropinfo.teamselect ) )
    {
        item = spawnscriptable( scriptabledefname, dropinfo.origin, dropinfo.angles, undefined, dropinfo.payload, dropinfo.teamselect );
    }
    else
    {
        item = spawnscriptable( scriptabledefname, dropinfo.origin, dropinfo.angles, undefined, dropinfo.payload );
    }
    
    if ( !isdefined( item ) )
    {
        return;
    }
    
    if ( isdefined( dropinfo.groundentity ) )
    {
        localorigin = rotatevectorinverted( dropinfo.origin - dropinfo.groundentity.origin, dropinfo.groundentity.angles );
        localangles = combineangles( invertangles( dropinfo.groundentity.angles ), dropinfo.angles );
        item utility::scriptable_setparententity( dropinfo.groundentity, localorigin, localangles );
    }
    
    pickups::registerscriptableinstance( item );
    
    if ( isdefined( count ) )
    {
        common_item::items_setitemcount( item, count, countlefthand, countalt );
    }
    else
    {
        common_item::items_setitemcount( item, 0 );
    }
    
    if ( !isdefined( allowautopickup ) )
    {
        allowautopickup = 1;
    }
    
    if ( !level.br_pickups.br_hasautopickup[ scriptabledefname ] )
    {
        allowautopickup = 1;
    }
    
    scriptablepartname = item.type;
    var_a7cf8ee849f5691b = 0;
    defaultscriptablepartstate = "visible";
    
    if ( !getdvarint( @"hash_61e10de0f675e9ad" ) )
    {
        if ( showtrail )
        {
            if ( allowautopickup )
            {
                item setscriptablepartstate( scriptablepartname, "dropped" + statesuffix );
                var_a7cf8ee849f5691b = 1;
            }
            else
            {
                assert( level.br_pickups.br_hasautopickup[ scriptabledefname ] );
                state = "droppedNoAuto";
                
                if ( !item getscriptableparthasstate( scriptablepartname, state + statesuffix ) && getdvarint( @"hash_8d10ede0f25e6d2e", 0 ) )
                {
                    state = "dropped";
                }
                
                item setscriptablepartstate( scriptablepartname, state + statesuffix );
                var_a7cf8ee849f5691b = 1;
            }
        }
        else if ( !allowautopickup )
        {
            assert( level.br_pickups.br_hasautopickup[ scriptabledefname ] );
            state = "noAuto";
            
            if ( !item getscriptableparthasstate( scriptablepartname, state + statesuffix ) && getdvarint( @"hash_8d10ede0f25e6d2e", 0 ) )
            {
                state = "dropped";
            }
            
            item setscriptablepartstate( scriptablepartname, state + statesuffix );
            var_a7cf8ee849f5691b = 1;
        }
    }
    
    if ( !var_a7cf8ee849f5691b )
    {
        item setscriptablepartstate( scriptablepartname, defaultscriptablepartstate + statesuffix );
    }
    
    if ( isent( self ) && isplayer( self ) )
    {
        item.var_5ff8235204183f8c = self;
        function_98411cfa56c9b407( item, scriptabledefname );
    }
    
    createcallback = level.br_pickups.createcallbacks[ scriptabledefname ];
    
    if ( isdefined( createcallback ) )
    {
        item [[ createcallback ]]();
    }
    
    /#
        if ( level.var_58e4decd8b9f14ef )
        {
            foreach ( player in level.players )
            {
                br_dev::devgivemaxammo( player );
            }
        }
    #/
    
    return item;
}

// Namespace br_pickups
// Params 2
// Checksum 0x25515ea6, Offset: 0x99de
// Size: 0x8b
function function_98411cfa56c9b407( instance, scriptablename )
{
    if ( !( isdefined( instance ) && isdefined( scriptablename ) && isdefined( self.var_eb1ab70ef3a2b4a4 ) ) || self.var_eb1ab70ef3a2b4a4.size <= 0 )
    {
        return;
    }
    
    founditemindex = function_f02c63b99c9614c9( self.var_eb1ab70ef3a2b4a4, scriptablename );
    
    if ( !isdefined( founditemindex ) )
    {
        return;
    }
    
    self.var_eb1ab70ef3a2b4a4[ founditemindex ] = undefined;
    instance.criticalitem = 1;
    instance.alwayscritical = 1;
}

// Namespace br_pickups
// Params 3
// Checksum 0xc12cd336, Offset: 0x9a71
// Size: 0xde
function registerpickupcreatedcallback( scriptabledefname, callback, var_4a3a2c0f21a4ec56 = 0 )
{
    if ( !utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
    {
        level.br_pickups.createcallbacks[ scriptabledefname ] = callback;
        
        if ( var_4a3a2c0f21a4ec56 )
        {
            items = getlootscriptablearray( scriptabledefname );
            
            foreach ( item in items )
            {
                item [[ callback ]]();
            }
        }
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0xaa722e6d, Offset: 0x9b57
// Size: 0x53
function function_87a5dccc82001425( callback )
{
    if ( !utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
    {
        level.br_pickups.var_fc7d03bac87458cf[ level.br_pickups.var_fc7d03bac87458cf.size ] = callback;
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0x819f3d48, Offset: 0x9bb2
// Size: 0x42f
function showuseresultsfeedback( results )
{
    switch ( results )
    {
        case 28:
            hud_message::showerrormessage( level.br_pickups.br_pickupdenyalreadyhaveweapon );
            return;
        case 3:
            hud_message::showerrormessage( level.br_pickups.br_pickupdenyammonoroom );
            return;
        case 4:
            hud_message::showerrormessage( level.br_pickups.br_pickupdenyequipnoroom );
            return;
        case 6:
            hud_message::showerrormessage( level.br_pickups.br_pickupdenyarmornotbetter );
            return;
        case 7:
            hud_message::showerrormessage( level.br_pickups.br_pickupdenyalreadyhaveks );
            return;
        case 8:
            hud_message::showerrormessage( level.br_pickups.var_7e6f47db0a8f2440 );
            return;
        case 36:
            hud_message::showerrormessage( level.br_pickups.var_9dab099cc358356c );
            return;
        case 14:
            hud_message::showerrormessage( level.br_pickups.br_pickupdenyalreadyhaverevive );
            return;
        case 9:
            hud_message::showerrormessage( level.br_pickups.br_pickupdenyparachuting );
            return;
        case 10:
            hud_message::showerrormessage( level.br_pickups.br_pickupdenyalreadyhavequest );
            return;
        case 13:
            hud_message::showerrormessage( level.br_pickups.br_pickupdenyweaponpickupap );
            return;
        case 15:
            hud_message::showerrormessage( level.br_pickups.br_pickupdenyalreadyhaveplatepouch );
            return;
        case 16:
            hud_message::showerrormessage( level.br_pickups.br_pickupdenyjuggernaut );
            return;
        case 18:
            hud_message::showerrormessage( level.br_pickups.br_pickupalreadyhavespecialistbonus );
            return;
        case 19:
            hud_message::showerrormessage( level.br_pickups.var_67faf57dba653dae );
            return;
        case 23:
            hud_message::showerrormessage( level.br_pickups.var_28f88201e12996f9 );
            return;
        case 2:
            break;
        case 25:
            hud_message::showerrormessage( level.br_pickups.var_53f0f176d34bcc83 );
            break;
        case 26:
            hud_message::showerrormessage( level.br_pickups.var_c17598a2773729cf );
            break;
        case 31:
            hud_message::showerrormessage( level.br_pickups.var_8ce217b7f539e05d );
            break;
        case 32:
            hud_message::showerrormessage( level.br_pickups.var_a3fbdfbc23c9581 );
            break;
        case 33:
            hud_message::showerrormessage( level.br_pickups.var_57383386ca32b63c );
            break;
        case 34:
            hud_message::showerrormessage( level.br_pickups.var_cc10cffe2fe70db9 );
            break;
        case 35:
            hud_message::showerrormessage( level.br_pickups.var_1ebf22bd335111d1 );
            break;
        case 11:
            hud_message::showerrormessage( level.br_pickups.br_pickupdenyplunderpickup );
            break;
        case 37:
            hud_message::showerrormessage( level.br_pickups.var_2c585953124fc454 );
            break;
        case 39:
            hud_message::showerrormessage( level.br_pickups.var_c6ee82e87c9e1924 );
            break;
    }
}

// Namespace br_pickups
// Params 2
// Checksum 0x2ad712e0, Offset: 0x9fe9
// Size: 0x64
function _removecashstateforplayer( player, waittime )
{
    assert( isplayer( player ) );
    assert( isfloat( waittime ) );
    player notify( #"hash_f3a16841fa5f45d6" );
    player endon( #"hash_f3a16841fa5f45d6" );
    wait waittime;
    player.br_cash_count = undefined;
    player.br_cash_time = undefined;
}

// Namespace br_pickups
// Params 2
// Checksum 0x4f5b391, Offset: 0xa055
// Size: 0x4dc
function getcashsoundaliasforplayer( player, plundername )
{
    pickup_sfx = "br_pickup_cash";
    var_3bc3f373af55ad6e = 5000;
    cash_timeout_sec = var_3bc3f373af55ad6e / 1000;
    now = gettime();
    var_95c5a10b255e0c36 = getmatchrulesdata( "brData", "plunderModelType" ) == "gold";
    
    if ( isplayer( player ) )
    {
        if ( !isdefined( player.br_cash_count ) )
        {
            player.br_cash_count = 0;
        }
        
        if ( !isdefined( player.br_cash_time ) )
        {
            player.br_cash_time = now;
        }
        
        cashdelta = now - player.br_cash_time;
        player.br_cash_time = now;
        
        if ( cashdelta < var_3bc3f373af55ad6e )
        {
            player.br_cash_count += 1;
        }
        
        player thread _removecashstateforplayer( player, cash_timeout_sec );
        assert( isdefined( player.br_cash_count ) );
        currencytype = "cash";
        
        if ( var_95c5a10b255e0c36 )
        {
            currencytype = "gold";
        }
        
        switch ( plundername )
        {
            case #"hash_192a14ffd18243fb":
            case #"hash_192a15ffd182458e":
            case #"hash_b64903f6ab579d1c":
            default:
                switch ( player.br_cash_count )
                {
                    case 0:
                    case 1:
                        pickup_sfx = "br_pickup_" + currencytype + "_01";
                        break;
                    case 2:
                        pickup_sfx = "br_pickup_" + currencytype + "_02";
                        break;
                    case 3:
                        pickup_sfx = "br_pickup_" + currencytype + "_03";
                        break;
                    case 4:
                        pickup_sfx = "br_pickup_" + currencytype + "_04";
                        break;
                    case 5:
                    default:
                        pickup_sfx = "br_pickup_" + currencytype + "_05";
                        break;
                }
                
                break;
            case #"hash_192a16ffd1824721":
            case #"hash_8f5e151d9e4dfc51":
                switch ( player.br_cash_count )
                {
                    case 0:
                    case 1:
                        pickup_sfx = "br_pickup_" + currencytype + "_med_01";
                        break;
                    case 2:
                        pickup_sfx = "br_pickup_" + currencytype + "_med_02";
                        break;
                    case 3:
                        pickup_sfx = "br_pickup_" + currencytype + "_med_03";
                        break;
                    case 4:
                        pickup_sfx = "br_pickup_" + currencytype + "_med_04";
                        break;
                    case 5:
                    default:
                        pickup_sfx = "br_pickup_" + currencytype + "_med_05";
                        break;
                }
                
                break;
            case #"hash_364c01bf1db279e8":
            case #"hash_364c04bf1db27ea1":
            case #"hash_8f5e121d9e4df798":
                switch ( player.br_cash_count )
                {
                    case 0:
                    case 1:
                        pickup_sfx = "br_pickup_" + currencytype + "_lrg_01";
                        break;
                    case 2:
                        pickup_sfx = "br_pickup_" + currencytype + "_lrg_02";
                        break;
                    case 3:
                        pickup_sfx = "br_pickup_" + currencytype + "_lrg_03";
                        break;
                    case 4:
                        pickup_sfx = "br_pickup_" + currencytype + "_lrg_04";
                        break;
                    case 5:
                    default:
                        pickup_sfx = "br_pickup_" + currencytype + "_lrg_05";
                        break;
                }
                
                break;
            case #"hash_266af6147dbd8916":
                switch ( player.br_cash_count )
                {
                    case 0:
                    case 1:
                        pickup_sfx = "br_pickup_" + currencytype + "_vlrg_01";
                        break;
                    case 2:
                        pickup_sfx = "br_pickup_" + currencytype + "_vlrg_02";
                        break;
                    case 3:
                        pickup_sfx = "br_pickup_" + currencytype + "_vlrg_03";
                        break;
                    case 4:
                        pickup_sfx = "br_pickup_" + currencytype + "_vlrg_04";
                        break;
                    case 5:
                    default:
                        pickup_sfx = "br_pickup_" + currencytype + "_vlrg_05";
                        break;
                }
                
                break;
        }
    }
    
    return pickup_sfx;
}

// Namespace br_pickups
// Params 9
// Checksum 0x2981fb1e, Offset: 0xa53a
// Size: 0xba9
function onusecompleted( pickupent, var_90916fc4b2724efd, bautouse, fromkiosk, var_6432f32bb6fece8b, instance, backpackequip, delayfeedback, weaponstowed )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    pickupremains = 0;
    
    if ( !isdefined( pickupent.count ) )
    {
        pickupent.count = 0;
    }
    
    level notify( "pickedupweapon_kill_callout_" + pickupent.scriptablename + pickupent.origin );
    utility::callsharedfunc( #"gametype", #"hash_a6cd80390ff28c62", pickupent );
    
    if ( isplunder( pickupent.scriptablename ) )
    {
        self notify( "self_pickedupitem_" + "plunder" );
    }
    else if ( pickups::isweaponpickupitem( pickupent ) )
    {
        if ( self isautograbweaponsenabled() )
        {
            self.var_6a41bd6cabbd5185 = gettime();
        }
        
        self notify( "self_pickedupitem_" + "weapon", pickupent.scriptablename );
    }
    else
    {
        self notify( "self_pickedupitem_" + pickupent.scriptablename );
    }
    
    self notify( #"br_pickup_scriptable" );
    
    if ( pickups::isweaponpickupitem( pickupent ) )
    {
        var_467bf18371688a96 = pickupent.scriptablename == "brloot_weapon_lm_dblmg_lege";
        
        if ( var_467bf18371688a96 )
        {
            manageminigunpickup();
        }
    }
    else if ( br_public::isarmorplate( pickupent.scriptablename ) )
    {
        if ( !fromkiosk && isdefined( self.perks[ "specialty_fast_armor" ] ) )
        {
            pickupremains = perkfunctions::function_a682fbbdf1856e15( pickupent, fromkiosk, var_6432f32bb6fece8b, backpackequip );
        }
        else
        {
            pickupremains = takeequipmentpickup( pickupent, fromkiosk, var_6432f32bb6fece8b, backpackequip );
        }
        
        br_ftue_popups::ftue_triggertip( "br_ftue_armor" );
        thread armor::function_df9c3f3288ff004f( pickupent.count );
    }
    else if ( br_public::function_d115f1547e28f0c6( pickupent.scriptablename ) )
    {
        if ( backpackequip && isdefined( var_6432f32bb6fece8b ) )
        {
            common_inventory::function_4f226d9d5d61901e( var_6432f32bb6fece8b );
        }
        
        if ( function_62231ee4879586fd() )
        {
            if ( backpackequip && isdefined( var_6432f32bb6fece8b ) )
            {
                var_aa856994116e4a9 = function_7cdc0a04f360f6d5();
                lootid = loot::function_d3e3bcaea591a6a2( var_aa856994116e4a9 );
                common_inventory::function_d3959596f4031a1d( lootid, 1 );
            }
            else
            {
                dropstruct = pickups::function_f71dd588dc4f6288();
                function_37557258071bf85f( dropstruct, 1 );
                br_instance_inventory::function_1ab1d8636982f8eb( self );
            }
        }
        
        platelevel = function_402de4642e0ec93c( self, pickupent.scriptablename );
        
        if ( pickupent.scriptablename == "brloot_plate_carrier_high_capacity" && !self.var_73611c5a905de865 )
        {
            fillmaxarmorplate();
            self.var_73611c5a905de865 = 1;
        }
    }
    else if ( br_public::isequipment( pickupent.scriptablename ) )
    {
        pickupremains = takeequipmentpickup( pickupent, fromkiosk, var_6432f32bb6fece8b, backpackequip );
    }
    else if ( br_public::isarmor( pickupent.scriptablename ) )
    {
        takearmorpickup( pickupent );
    }
    else if ( pickupent.scriptablename == "Pillage_Cache" && isdefined( level.givetagsfromcache ) )
    {
        self [[ level.givetagsfromcache ]]();
    }
    else if ( isplunder( pickupent.scriptablename ) )
    {
        br_plunder::takeplunderpickup( pickupent );
    }
    else if ( br_public::isvoucher( pickupent.scriptablename ) )
    {
        function_6dadaf2d40ccdfc1( pickupent );
    }
    else if ( istokenpickup( pickupent.scriptablename ) )
    {
        if ( issubstr( pickupent.scriptablename, "redeploy_token" ) )
        {
            takerespawntokenpickup( pickupent );
        }
        
        if ( issubstr( pickupent.scriptablename, "gulag_token" ) )
        {
            function_488496dfbfb6c990( pickupent );
        }
    }
    else if ( isrevivepickup( pickupent.scriptablename ) )
    {
        takerevivepickup( pickupent, var_6432f32bb6fece8b, backpackequip );
    }
    else if ( iskillstreak( pickupent.scriptablename ) )
    {
        takekillstreakpickup( pickupent, fromkiosk, var_6432f32bb6fece8b, backpackequip );
    }
    else if ( issuperpickup( pickupent.scriptablename ) )
    {
        takesuperpickup( pickupent, fromkiosk, var_6432f32bb6fece8b );
    }
    else if ( function_36092a934fe35d06( pickupent.scriptablename ) )
    {
        takeperkpickup( pickupent.scriptablename, fromkiosk, var_6432f32bb6fece8b, backpackequip );
    }
    else if ( isgasmask( pickupent.scriptablename ) )
    {
        takeheadgear( "gas_mask", pickupent, fromkiosk, var_6432f32bb6fece8b, backpackequip );
    }
    else if ( ishelmet( pickupent.scriptablename ) )
    {
        takeheadgear( "helmet", pickupent, fromkiosk, var_6432f32bb6fece8b, backpackequip );
    }
    else if ( isquesttablet( pickupent.scriptablename ) )
    {
        br_contract_manager::function_9490728b1fe4323( pickupent.instance );
    }
    else if ( pickupent.scriptablename == "brloot_ammo_grenade" )
    {
        takegenericgrenadepickup( pickupent );
    }
    else if ( function_e380482ca8f0de4b( pickupent.scriptablename ) )
    {
        function_10d4475b0263c742( pickupent );
    }
    else if ( isaccesscard( pickupent.scriptablename ) )
    {
        takeaccesscardpickup( pickupent );
    }
    else if ( pickupent.scriptablename == "loot_key_mrap" )
    {
        if ( isdefined( self.vehicle ) )
        {
            ref = self.vehicle vehicle::get_ref();
            
            if ( ref == %"hash_3585a3d351c5e6ff" && self.vehicle.owner == self )
            {
                if ( self.vehicle vehicle_occupancy::is_locked() )
                {
                    self.vehicle vehicle_occupancy::unlock();
                    common_inventory::function_bae25ae0b487a249( var_6432f32bb6fece8b, 0 );
                }
                else
                {
                    hud_message::showerrormessage( "MP/MRAP_ALREADY_UNLOCKED" );
                }
            }
            else
            {
                hud_message::showerrormessage( "MP/CANNOT_USE_MRAP_KEY" );
            }
        }
        else
        {
            hud_message::showerrormessage( "MP/CANNOT_USE_MRAP_KEY" );
        }
    }
    else if ( iskey( pickupent.scriptablename ) )
    {
        if ( function_ce9a9f8d70afdf01( pickupent.scriptablename ) )
        {
            if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "gulagKeyAcquired" ) )
            {
                namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "gulagKeyAcquired" );
            }
            
            return 0;
        }
        else
        {
            return 1;
        }
    }
    else if ( isquestitem( pickupent.scriptablename ) )
    {
    }
    else if ( function_1578d9983da7761a( pickupent.scriptablename ) )
    {
        function_a35730a988baa527( pickupent );
    }
    else if ( isxp( pickupent.scriptablename ) )
    {
        takexp( pickupent );
        return 1;
    }
    else if ( function_bb0787b9230d2a4a( pickupent.scriptablename ) )
    {
        if ( self.canhackcontracts )
        {
            thread namespace_84d989e8789e6a05::function_4aad07fa1664ce24( pickupent, self );
        }
        else
        {
            thread activity_manager::function_89e4869128e7a19a( pickupent, self );
        }
    }
    else if ( function_49be4ae122d13f2e( pickupent.scriptablename ) )
    {
        thread overseer::function_51eb09c3cc658225( instance );
    }
    else if ( function_8b2f7f58a48bed48( pickupent.scriptablename ) )
    {
        if ( isdefined( level.secondaryvictory ) )
        {
            self thread [[ level.secondaryvictory.var_66b605e8c66a9f64 ]]();
        }
    }
    else if ( function_56d8ca44f91af7c( pickupent.scriptablename ) )
    {
        thread iodine_pills::iodinepills_onuse( undefined, pickupent );
    }
    else if ( isgascan( pickupent.scriptablename ) )
    {
        var_3df97f2404d99e4c = pickupent.scriptablename == "brloot_gascan_palfa";
        error = vehicle_interact::gas_can_refuel_vehicle( var_3df97f2404d99e4c );
        
        if ( isdefined( error ) )
        {
            hud_message::showerrormessage( error );
        }
        else
        {
            common_inventory::function_bae25ae0b487a249( var_6432f32bb6fece8b, pickupent.count );
            
            if ( delayfeedback )
            {
                playpickupfeedback( pickupent, bautouse );
            }
            
            playsoundatpos( self.origin + ( 0, 0, 30 ), "eqp_gas_can_use" );
            
            if ( var_3df97f2404d99e4c )
            {
                namespace_6fe0f1cba107e99::function_e7ea7e530ea2a2e0();
            }
        }
    }
    else if ( function_cfce107ef35a347e( pickupent.scriptablename ) )
    {
        var_2f0fa6696b583d9b = br_default_inventory::function_52727e682b6bb2d3( pickupent.scriptablename );
        var_afd80741e24afa30 = common_inventory::function_9cd65c8312048802();
        lootid = loot::function_d3e3bcaea591a6a2( pickupent.scriptablename );
        var_6d9ba0f7d86e7134 = br_default_inventory::function_677447af306a9120( self );
        
        if ( var_6d9ba0f7d86e7134 != 0 )
        {
            dropstruct = pickups::function_f71dd588dc4f6288();
            scriptablename = loot::getScriptableFromLootID( var_6d9ba0f7d86e7134 );
            dropinfo = pickups::getitemdroporiginandangles( dropstruct, self.origin, self.angles, self, undefined, pickupent.overridedist, undefined, undefined, pickupent.origin );
            item = spawnpickup( scriptablename, dropinfo, 1, 1, undefined, 0 );
        }
        
        br_instance_inventory::function_3885ada2ac161b19( self );
        br_instance_inventory::function_b3ac69700bb1c081( self, lootid );
        br_default_inventory::function_7fcce769f23a1428( self, var_2f0fa6696b583d9b, undefined, lootid );
        
        if ( backpackequip && isdefined( var_6432f32bb6fece8b ) )
        {
            br_default_inventory::function_39f0833282ad6f6( var_6432f32bb6fece8b );
        }
        
        br_default_inventory::function_c0277b9c26d57ffc( self, var_2f0fa6696b583d9b, pickupent.scriptablename );
    }
    else if ( isperkpack( pickupent.scriptablename ) )
    {
        thread function_4dbd2dcc3564d964( pickupent, bautouse, var_6432f32bb6fece8b, backpackequip, fromkiosk );
    }
    else if ( isdogtag( pickupent.scriptablename ) && game_utility::getgametype() != "dmz" && isdefined( level.var_cd27949416787694 ) )
    {
    }
    else if ( iseventcard( pickupent.scriptablename ) && isdefined( level.var_1e6f8d9cd78c70e4 ) )
    {
        self [[ level.var_1e6f8d9cd78c70e4 ]]( pickupent );
    }
    else if ( function_d39ca17df2c672e8( pickupent.scriptablename ) && utility::issharedfuncdefined( #"hash_85f521d3225dcb38", #"reveal_intel" ) )
    {
        utility::callsharedfunc( #"hash_85f521d3225dcb38", #"reveal_intel", pickupent );
    }
    else if ( function_18c9ebe68283fe1c( pickupent.scriptablename ) )
    {
        utility::callsharedfunc( #"scavenger_bag", #"onscavengerbagpickup", pickupent.instance );
        pickupremains = 0;
    }
    else if ( isgametypeitem( pickupent.scriptablename ) && utility::issharedfuncdefined( #"gametype", #"hash_86902e87165af1e1" ) )
    {
        utility::callsharedfunc( #"gametype", #"hash_86902e87165af1e1", pickupent, self );
    }
    else
    {
        amount = 1;
        
        if ( isdefined( pickupent.count ) )
        {
            amount = pickupent.count;
        }
        
        trypickupitem( pickupent.scriptablename, amount );
    }
    
    amount = 1;
    
    if ( isdefined( pickupent.count ) )
    {
        amount = pickupent.count;
    }
    
    if ( isdefined( pickupent.instance ) && isdefined( pickupent.instance.uniquelootitemid ) )
    {
        processuniquelootitem( pickupent.instance.uniquelootitemid, self );
    }
    
    function_b167aca7dc0dac9( pickupent );
    br_analytics::branalytics_lootpickup( self, pickupent.scriptablename, amount );
    br_ftue_popups::ftue_triggertip( "br_ftue_inventory" );
    
    if ( !var_90916fc4b2724efd && !delayfeedback )
    {
        if ( pickupremains )
        {
            pickupent.count -= pickupremains;
        }
        
        playpickupfeedback( pickupent, bautouse );
    }
    
    return pickupremains;
}

// Namespace br_pickups
// Params 1
// Checksum 0xaf904b4a, Offset: 0xb0ec
// Size: 0x1fd
function onpickuptakenintobackpack( pickup )
{
    if ( isdefined( level.var_f9b5071f732e0bef[ pickup.scriptablename ] ) )
    {
        [[ level.var_f9b5071f732e0bef[ pickup.scriptablename ] ]]( pickup, self );
    }
    
    if ( function_d1bdfe41ee9800f9( pickup.scriptablename ) )
    {
        blacksite = undefined;
        originalteam = undefined;
        
        if ( isdefined( pickup.instance ) )
        {
            blacksite = pickup.instance.blacksite;
            originalteam = pickup.instance.originalteam;
        }
        else
        {
            blacksite = pickup.blacksite;
            originalteam = pickup.originalteam;
        }
        
        if ( isdefined( blacksite ) )
        {
            self.blacksite = blacksite;
            teamplayers = player_utility::getteamarray( self.team, 0 );
            br_strongholds::function_585e02e41b6f11c( blacksite, 0, teamplayers, originalteam, self.team );
            
            if ( level.var_4a541addea7705bf && isdefined( level.var_3d89fd8ba253e8f9 ) )
            {
                self thread [[ level.var_3d89fd8ba253e8f9 ]]( pickup );
            }
        }
    }
    
    if ( function_1f87e4642e088efd( pickup.scriptablename ) )
    {
        if ( utility::issharedfuncdefined( #"hash_8538e247e32e58b9", #"hash_c2d8f5e98051b51e" ) )
        {
            level thread [[ utility::getsharedfunc( #"hash_8538e247e32e58b9", #"hash_c2d8f5e98051b51e" ) ]]( pickup, self );
        }
    }
    
    if ( isaccesscard( pickup.scriptablename ) )
    {
        if ( utility::issharedfuncdefined( #"br_bunkers", #"hash_5cf2b13104bb361e" ) )
        {
            level thread [[ utility::getsharedfunc( #"br_bunkers", #"hash_5cf2b13104bb361e" ) ]]( self );
        }
    }
    
    function_b167aca7dc0dac9( pickup );
    utility::callsharedfunc( #"gametype", #"onpickuptakenintobackpack", pickup );
    level notify( #"backpack_item", self, pickup );
}

// Namespace br_pickups
// Params 1
// Checksum 0x712de212, Offset: 0xb2f1
// Size: 0x79
function function_b167aca7dc0dac9( pickup )
{
    if ( pickup.alwayscritical || isdefined( pickup.instance ) && pickup.instance.alwayscritical )
    {
        if ( !isdefined( self.var_eb1ab70ef3a2b4a4 ) )
        {
            self.var_eb1ab70ef3a2b4a4 = [];
        }
        
        self.var_eb1ab70ef3a2b4a4[ self.var_eb1ab70ef3a2b4a4.size ] = pickup.scriptablename;
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0xd5387a34, Offset: 0xb372
// Size: 0x19d
function updatelootsplash( pickupent )
{
    self notify( #"hash_92ee10be2566118d" );
    self endon( #"disconnect" );
    lootid = 0;
    quantity = 0;
    
    if ( pickups::isweaponpickup( pickupent.scriptablename ) )
    {
        if ( isdefined( pickupent.customweaponname ) )
        {
            lootid = function_9b4625217723bb22( pickupent.customweaponname );
        }
        else
        {
            weaponobj = getfullweaponobjforpickup( pickupent );
            lootid = weapon::getweaponlootid( weaponobj );
        }
    }
    else
    {
        lootid = level.br_pickups.var_2e379e316c36bf4a[ pickupent.scriptablename ];
        
        if ( !isdefined( lootid ) )
        {
            lootid = 0;
        }
        
        shouldshowquantity = pickupent.stackable > 0 || isplunder( pickupent.scriptablename ) || ispickupstackable( pickupent.scriptablename ) || function_10c0573255b72cb6( pickupent.scriptablename ) || function_48864b4e9a0f3040( pickupent.scriptablename );
        
        if ( shouldshowquantity && isdefined( pickupent.count ) )
        {
            quantity = pickupent.count;
        }
    }
    
    waitframe();
    
    if ( isdefined( lootid ) )
    {
        self setclientomnvar( "ui_loot_splash_item_id", lootid );
        self setclientomnvar( "ui_loot_splash_item_quantity", quantity );
    }
    else
    {
        logstring( "ui_loot_splash_item_id LootID: undefined    pickupEnt: " + pickupent.scriptablename );
    }
    
    self endon( #"hash_92ee10be2566118d" );
    wait 0.05;
    common_item::function_dba5cd48d3cd08cb();
}

// Namespace br_pickups
// Params 1
// Checksum 0xe6be7f13, Offset: 0xb517
// Size: 0x1a
function function_9b4625217723bb22( customweaponname )
{
    return loot::getlootidfromref( weapon::getweaponrootname( customweaponname ) );
}

// Namespace br_pickups
// Params 4
// Checksum 0xbe1f8ba5, Offset: 0xb53a
// Size: 0x84
function function_55de798ca5dc4080( lootid, origin, var_b8b2f39fcba6d824, quantity )
{
    pickup = spawnstruct();
    pickup.scriptablename = loot::getScriptableFromLootID( lootid );
    pickup.origin = origin;
    pickup.count = quantity;
    
    if ( isdefined( var_b8b2f39fcba6d824 ) )
    {
        pickup.var_b8b2f39fcba6d824 = var_b8b2f39fcba6d824;
    }
    
    playpickupfeedback( pickup );
}

// Namespace br_pickups
// Params 2
// Checksum 0x226a7046, Offset: 0xb5c6
// Size: 0x48f
function playpickupfeedback( pickupent, bautouse )
{
    pickup_sfx = "fly_pickup_gen";
    legendary_pickup_sfx = undefined;
    valuable_pickup_sfx = undefined;
    
    if ( isdefined( pickupent.scriptablename ) )
    {
        if ( isplunder( pickupent.scriptablename ) )
        {
            pickup_sfx = getcashsoundaliasforplayer( self, pickupent.scriptablename );
        }
        else if ( function_10c0573255b72cb6( pickupent.scriptablename ) )
        {
            pickup_sfx = namespace_84d989e8789e6a05::function_371a1a7a67c55dc7( self );
        }
        else if ( isdefined( level.br_pickups.br_pickupsfx[ pickupent.scriptablename ] ) && level.br_pickups.br_pickupsfx[ pickupent.scriptablename ] != getxhash( "" ) && !( getdvarint( @"scr_br_skiplegendarypickupsound", 0 ) != 0 && level.br_pickups.br_pickupsfx[ pickupent.scriptablename ] == getxhash( "fly_br_legendary_loot_pickup" ) ) )
        {
            if ( level.br_pickups.br_pickupsfx[ pickupent.scriptablename ] == getxhash( "fly_br_legendary_loot_pickup" ) )
            {
                legendary_pickup_sfx = level.br_pickups.br_pickupsfx[ pickupent.scriptablename ];
                
                if ( pickups::isweaponpickupitem( pickupent ) )
                {
                    pickup_sfx = "fly_pickup_wpn";
                }
                else
                {
                    pickup_sfx = "fly_pickup_gen";
                }
            }
            else if ( level.br_pickups.br_pickupsfx[ pickupent.scriptablename ] == getxhash( "uin_dmz_valuable_loot_pickup" ) )
            {
                valuable_pickup_sfx = level.br_pickups.br_pickupsfx[ pickupent.scriptablename ];
                
                if ( pickups::isweaponpickupitem( pickupent ) )
                {
                    pickup_sfx = "fly_pickup_wpn";
                }
                else
                {
                    pickup_sfx = "fly_pickup_gen";
                }
            }
            else
            {
                pickup_sfx = level.br_pickups.br_pickupsfx[ pickupent.scriptablename ];
            }
        }
        else if ( pickups::isweaponpickupitem( pickupent ) )
        {
            pickup_sfx = "fly_pickup_wpn";
        }
        else
        {
            pickup_sfx = "fly_pickup_gen";
        }
        
        if ( isdefined( level.br_pickups.br_itemrow[ pickupent.scriptablename ] ) && level.br_pickups.var_df72c1e1bfcdea3c[ pickupent.scriptablename ] )
        {
            customweapon = pickupent.customweaponname;
            var_5e6e4a7c412c75b9 = undefined;
            index = undefined;
            
            if ( isdefined( customweapon ) )
            {
                index = function_9b4625217723bb22( customweapon );
                var_5e6e4a7c412c75b9 = 0;
            }
            else
            {
                index = level.br_pickups.br_itemrow[ pickupent.scriptablename ];
                var_5e6e4a7c412c75b9 = 1;
            }
            
            self setcollectedloot( index, pickupent.count, var_5e6e4a7c412c75b9 );
            self notify( #"loot_collected" );
        }
    }
    
    origin_plr = self getvieworigin();
    origin_pickup = undefined;
    
    if ( isvector( pickupent.origin ) )
    {
        origin_pickup = pickupent.origin;
    }
    else if ( isstruct( pickupent ) )
    {
        container = pickupent.container ?? self.var_50f741a14f09a6;
        
        if ( isdefined( container ) )
        {
            origin_pickup = container.origin;
            origin_pickup = ( origin_pickup[ 0 ], origin_pickup[ 1 ], origin_plr[ 2 ] - 20 );
        }
    }
    
    if ( !isvector( origin_pickup ) )
    {
        assertmsg( "<dev string:x1ff>" );
        origin_pickup = origin_plr + anglestoforward( self getplayerangles() ) * 36 + ( 0, 0, -20 );
    }
    
    assert( isvector( origin_pickup ), "<dev string:x1ff>" );
    origin_delta = origin_pickup - origin_plr;
    origin_offset = origin_delta * 0.666;
    grab_origin = origin_plr + origin_offset;
    
    if ( isdefined( self ) && player::isreallyalive() && !function_e5e92a3d360f1a2c( self ) )
    {
        if ( isdefined( legendary_pickup_sfx ) )
        {
            self playlocalsound( legendary_pickup_sfx );
        }
        else if ( isdefined( valuable_pickup_sfx ) )
        {
            self playlocalsound( valuable_pickup_sfx );
        }
        
        if ( player::isreallyalive( self ) )
        {
            self playsoundonmovingent( pickup_sfx );
        }
    }
    
    if ( !pickupent.var_fbb504183990fc9f )
    {
        thread updatelootsplash( pickupent );
    }
    
    if ( !bautouse && !pickupent.var_b8b2f39fcba6d824 )
    {
        thread pickups::playerplaypickupanim( pickupent );
    }
}

// Namespace br_pickups
// Params 0
// Checksum 0xe528f062, Offset: 0xba5d
// Size: 0x47
function function_7cdc0a04f360f6d5()
{
    if ( !isdefined( self.platecarrierlevel ) || self.platecarrierlevel <= 1 )
    {
        return;
    }
    
    if ( isdefined( self.platecarriertype ) )
    {
        return self.platecarriertype;
    }
    
    return "brloot_plate_carrier_" + self.platecarrierlevel;
}

// Namespace br_pickups
// Params 2
// Checksum 0xa285b6c9, Offset: 0xbaad
// Size: 0x124
function function_37557258071bf85f( dropstruct, alivedrop )
{
    if ( !isdefined( self.platecarrierlevel ) )
    {
        return;
    }
    
    if ( self.platecarrierlevel <= 1 )
    {
        return;
    }
    
    dropinfo = pickups::getitemdroporiginandangles( dropstruct, self.origin, self.angles, self );
    item = undefined;
    pickupname = function_7cdc0a04f360f6d5();
    item = spawnpickup( pickupname, dropinfo, 1, 1, undefined, 0 );
    
    if ( alivedrop )
    {
        return;
    }
    
    if ( level.var_dd8633765c6a1db9 )
    {
        self setplayerdata( level.var_6f9b00680ed002d8, "dmzPlateCarrierLevel", 1 );
    }
    
    if ( isdefined( item ) )
    {
        function_7a45cbf285d2f3af( item );
        
        if ( function_e2035e1b9faa4f6a( item.type ) )
        {
            perkfunctions::function_4217611c148026a6();
            self.var_73611c5a905de865 = undefined;
        }
    }
    
    if ( level.var_dd8633765c6a1db9 )
    {
        self.platecarrierlevel = 1;
    }
    else
    {
        self.platecarrierlevel = 2;
    }
    
    self.maxarmorhealth = armor::function_3988e68b87d5acc0() * 50;
    armor::setarmorhealth( 0, 1 );
}

// Namespace br_pickups
// Params 3
// Checksum 0x5b5edbbd, Offset: 0xbbd9
// Size: 0x24b
function dropbrweapon( weapon, dropstruct, overrideorigin )
{
    weaponobj = undefined;
    ammoclipcount = 1;
    var_9cbcdc25afd7f1cd = 0;
    var_b492d890ebd15f10 = 0;
    
    if ( isdefined( weapon ) )
    {
        if ( isweapon( weapon ) )
        {
            weaponobj = weapon;
            ammoclipcount = self getweaponammoclip( weaponobj );
            var_9cbcdc25afd7f1cd = self getweaponammoclip( weaponobj, "left" );
            
            if ( weaponobj.hasalternate )
            {
                weaponaltobj = weaponobj getaltweapon();
                
                if ( br_weapons::br_ammo_type_for_weapon( weaponaltobj ) != br_weapons::br_ammo_type_for_weapon( weaponobj ) )
                {
                    var_b492d890ebd15f10 = self getweaponammoclip( weaponaltobj );
                }
            }
        }
        else if ( isstring( weapon ) )
        {
            weaponobj = getfullweaponobjfromscriptablename( weapon );
            
            if ( isdefined( weaponobj ) )
            {
                ammoclipcount = weaponobj.clipsize;
            }
            else if ( isdefined( level.br_ammo_clipsize[ weapon ] ) )
            {
                ammoclipcount = level.br_ammo_clipsize[ weapon ];
            }
        }
    }
    
    if ( !isdefined( weaponobj ) )
    {
        print( "<dev string:x227>" );
        return;
    }
    
    dropinfo = pickups::getitemdroporiginandangles( dropstruct, self.origin, self.angles, self, undefined, undefined, undefined, undefined, overrideorigin );
    newweaponref = undefined;
    
    if ( isdefined( newweaponref ) )
    {
        ammotype = br_weapons::br_ammo_type_for_weapon( weaponobj );
        newweaponref.ammotype = ammotype;
        
        if ( getdvarint( @"hash_752eeed3ddcbd04b", 0 ) == 0 && self.br_ammo[ ammotype ] > 0 )
        {
            var_566a503a3488a1e6 = getdvarint( @"hash_3c4edd0a748e4053", 1 );
            dropstruct.dropidx = 1;
            var_16244add81e2345e = undefined;
            
            if ( isdefined( overrideorigin ) )
            {
                var_16244add81e2345e = self.origin + rotatevector( overrideorigin - self.origin, ( 0, 45, 0 ) );
            }
            
            dropinfo = pickups::getitemdroporiginandangles( dropstruct, self.origin, self.angles, self, undefined, undefined, undefined, undefined, var_16244add81e2345e );
            newweaponref.var_48da44f99291b04a = spawnpickup( ammotype, dropinfo, self.br_ammo[ ammotype ], 1, undefined, var_566a503a3488a1e6 );
        }
        
        common_item::items_setitemcount( newweaponref, ammoclipcount, var_9cbcdc25afd7f1cd, var_b492d890ebd15f10 );
    }
    
    return newweaponref;
}

// Namespace br_pickups
// Params 2
// Checksum 0x4c24bcb8, Offset: 0xbe2d
// Size: 0x191
function function_fb0af7ec2ac831f8( dropstruct, arena )
{
    player = self;
    scriptable = level.br_pickups.var_5515c706eaccd3[ "loot_key_gulag" ];
    dropinfo = pickups::getitemdroporiginandangles( dropstruct, player.origin, player.angles, player, level.br_pickups.yawoffsetoverride, level.br_pickups.distanceoverride );
    item = spawnpickup( scriptable, dropinfo, 1, 1, undefined, 0 );
    
    if ( isplayer( player ) )
    {
        player function_7a45cbf285d2f3af( item );
    }
    
    arena.var_f2bd026a83c7bd98[ arena.var_f2bd026a83c7bd98.size ] = item;
    playsoundatpos( player.origin, "flag_spawned" );
    
    foreach ( p in arena.arenaplayers )
    {
        p thread hud_message::showsplash( "br_twotwo_gulag_key_dropped" );
    }
    
    wait 0.5;
    
    if ( !isdefined( item ) )
    {
        return;
    }
    
    namespace_a974e4dd85555bc2::function_30f8f49dae1ba5e8( arena, item.origin );
}

// Namespace br_pickups
// Params 3
// Checksum 0x6983910e, Offset: 0xbfc7
// Size: 0x174
function function_d5e08ebbca145e65( dropstruct, arena, killer )
{
    agent = self;
    
    if ( !isdefined( agent ) )
    {
        return;
    }
    
    scriptable = level.br_pickups.var_5515c706eaccd3[ "loot_key_spectator_gulag" ];
    dropinfo = pickups::getitemdroporiginandangles( dropstruct, agent.origin, agent.angles, agent, undefined, 25 );
    item = spawnpickup( scriptable, dropinfo, 1, 1, undefined, 0 );
    item.criticalitem = 1;
    item.var_d56f5d70ad733694 = 1;
    arena.secondchancekey = item;
    playsoundatpos( agent.origin, "flag_spawned" );
    catwalkplayers = arrayremove( arena.jailedplayers, arena.arenaplayers );
    
    foreach ( player in catwalkplayers )
    {
        player thread hud_message::showsplash( "gulagbreak_got_key" );
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0x710c1a6b, Offset: 0xc144
// Size: 0x50
function getfullweaponobjfromscriptablename( scriptableweaponname )
{
    weaponname = undefined;
    
    if ( !isdefined( level.br_lootiteminfo ) && !isdefined( level.br_lootiteminfo[ scriptableweaponname ] ) )
    {
        return;
    }
    
    return level.br_lootiteminfo[ scriptableweaponname ].fullweaponobj;
}

// Namespace br_pickups
// Params 2
// Checksum 0x2745c238, Offset: 0xc19d
// Size: 0xb0, Type: bool
function shoulddropbrprimary( weapon, player )
{
    if ( !isalive( player ) && level.blockweapondrops )
    {
        return false;
    }
    
    basename = weapon::getweaponrootname( weapon.basename );
    
    if ( !weapons::isdroppableweapon( player, weapon ) )
    {
        return false;
    }
    
    if ( basename == "ks_use_crate_mp" )
    {
        return false;
    }
    
    if ( !isweapon( weapon ) )
    {
        return false;
    }
    
    if ( weapon.inventorytype != "primary" )
    {
        return false;
    }
    
    if ( player br_extract_quest::extract_ismissionweapon( weapon ) )
    {
        return false;
    }
    
    if ( class::function_d31c1081fbeb777b() && weapon::isbackuppistol( weapon ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br_pickups
// Params 5
// Checksum 0x55a6b286, Offset: 0xc256
// Size: 0x319
function dropbrequipment( dropstruct, fromkiosk, droppurchased, equipmentref, var_d3ae4cece27f98df )
{
    var_d7aeccd7e912818 = droppurchased && isdefined( equipmentref );
    
    if ( var_d7aeccd7e912818 )
    {
        var_bdb4bdfa53aebb08 = function_f02c63b99c9614c9( level.br_pickups.br_equipname, equipmentref );
        
        if ( isdefined( var_bdb4bdfa53aebb08 ) )
        {
            function_6cebf175e5947276( fromkiosk );
            baseorigin = self.origin;
            baseangles = self.angles;
            yawoffsetoverride = level.br_pickups.yawoffsetoverride;
            distanceoverride = level.br_pickups.distanceoverride;
            
            if ( fromkiosk && isdefined( self.br_kiosk ) )
            {
                baseorigin = self.br_kiosk.origin;
                baseangles = self.br_kiosk.angles;
                distanceoverride = undefined;
                yawoffsetoverride = undefined;
            }
            
            dropamount = 1;
            
            if ( isdefined( var_d3ae4cece27f98df ) )
            {
                dropamount = var_d3ae4cece27f98df;
            }
            
            dropinfo = pickups::getitemdroporiginandangles( dropstruct, baseorigin, baseangles, self, yawoffsetoverride, distanceoverride );
            item = spawnpickup( var_bdb4bdfa53aebb08, dropinfo, dropamount, 1, undefined, isalive( self ) );
            function_7a45cbf285d2f3af( item );
        }
        
        return;
    }
    
    primaryequipment = self.equipment[ "primary" ];
    
    if ( isdefined( primaryequipment ) )
    {
        if ( primaryequipment == "equip_hb_sensor" )
        {
            ammocount = hb_sensor_equipment::function_4bae610387dbbea0();
        }
        else
        {
            ammocount = equipment_mp::getequipmentslotammo( "primary" );
        }
        
        if ( ammocount > 0 )
        {
            var_f7e41c4e8421f7d3 = function_f02c63b99c9614c9( level.br_pickups.br_equipname, self.equipment[ "primary" ] );
            
            if ( isdefined( var_f7e41c4e8421f7d3 ) )
            {
                dropinfo = pickups::getitemdroporiginandangles( dropstruct, self.origin, self.angles, self );
                allowautopickup = isalive( self ) || getdvarint( @"scr_br_allow_auto_pickup_dropped_lethal_gadgets", 0 );
                item = spawnpickup( var_f7e41c4e8421f7d3, dropinfo, ammocount, 1, undefined, allowautopickup );
                function_7a45cbf285d2f3af( item );
            }
        }
    }
    
    secondaryequipment = self.equipment[ "secondary" ];
    
    if ( isdefined( secondaryequipment ) )
    {
        if ( secondaryequipment == "equip_hb_sensor" )
        {
            ammocount = hb_sensor_equipment::function_4bae610387dbbea0();
        }
        else
        {
            ammocount = equipment_mp::getequipmentslotammo( "secondary" );
        }
        
        if ( ammocount > 0 )
        {
            var_f7e41c4e8421f7d3 = function_f02c63b99c9614c9( level.br_pickups.br_equipname, self.equipment[ "secondary" ] );
            
            if ( isdefined( var_f7e41c4e8421f7d3 ) )
            {
                dropinfo = pickups::getitemdroporiginandangles( dropstruct, self.origin, self.angles, self );
                allowautopickup = isalive( self ) || getdvarint( @"scr_br_allow_auto_pickup_dropped_tactical_gadgets", 0 );
                item = spawnpickup( var_f7e41c4e8421f7d3, dropinfo, ammocount, 1, undefined, allowautopickup );
                function_7a45cbf285d2f3af( item );
            }
        }
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0x8027b310, Offset: 0xc577
// Size: 0x239
function dropbrhealthpack( dropstruct )
{
    itemcount = 0;
    itemname = undefined;
    
    if ( !isdefined( level.br_pickups ) )
    {
        return;
    }
    
    if ( br_public::isplayeringulag() )
    {
        return;
    }
    
    if ( isdefined( self.equipment[ "health" ] ) )
    {
        itemname = level.br_pickups.br_equipnametoscriptable[ self.equipment[ "health" ] ];
        itemcount = equipment_mp::getequipmentslotammo( "health" );
    }
    else if ( level.droparmorondeath )
    {
        itemname = level.br_pickups.br_equipnametoscriptable[ level.armorref ?? "equip_armorplate" ];
        itemcount = level.armordropamount;
    }
    
    if ( level.var_1bd712f9520609c8 && level.droparmorondeath && level.armordropamount )
    {
        itemcount = level.var_1bd712f9520609c8;
    }
    
    if ( level.armordropamount && itemcount < level.armordropamount )
    {
        itemcount = level.armordropamount;
        
        if ( !isdefined( itemname ) )
        {
            itemname = level.br_pickups.br_equipnametoscriptable[ level.armorref ?? "equip_armorplate" ];
        }
    }
    
    if ( itemcount > 0 && isdefined( itemname ) )
    {
        allowautopickup = getdvarint( @"scr_br_allow_auto_pickup_dropped_armor", 1 ) || isalive( self );
        
        if ( itemcount > level.br_pickups.maxcounts[ itemname ] )
        {
            itemcount -= level.br_pickups.maxcounts[ itemname ];
            dropinfo = pickups::getitemdroporiginandangles( dropstruct, self.origin, self.angles, self );
            item = spawnpickup( itemname, dropinfo, level.br_pickups.maxcounts[ itemname ], 1, undefined, isalive( self ) );
        }
        
        dropinfo = pickups::getitemdroporiginandangles( dropstruct, self.origin, self.angles, self );
        item = spawnpickup( itemname, dropinfo, itemcount, 1, undefined, allowautopickup );
        function_7a45cbf285d2f3af( item );
    }
}

// Namespace br_pickups
// Params 3
// Checksum 0x97d57e05, Offset: 0xc7b8
// Size: 0x18a
function dropheadgear( dropstruct, dontspawnitem, delaydrop )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( self.headgeartype ) )
    {
        return;
    }
    
    headgeartype = self.headgeartype;
    
    if ( !br_headgear::function_8d2d82039f815a8f( headgeartype ) )
    {
        return;
    }
    
    if ( br_headgear::hasheadgear( headgeartype, self ) )
    {
        if ( delaydrop && br_headgear::function_f95a396894b1ddad( headgeartype ) )
        {
            br_headgear::headgearoff( headgeartype, "br_circle" );
            
            if ( headgeartype == "gas_mask" )
            {
                wait 0.6;
            }
            
            if ( !br_headgear::hasheadgear( headgeartype, self ) )
            {
                return;
            }
        }
        
        dropinfo = pickups::getitemdroporiginandangles( dropstruct, self.origin, self.angles, self );
        allowautopickup = isalive( self ) || getdvarint( @"hash_4508c701f27f5496", 0 );
        headgeardrop = undefined;
        headgearhealth = br_headgear::function_d26be71b65916bb0( headgeartype, self );
        
        if ( !dontspawnitem && headgearhealth > 0 )
        {
            headgearref = br_headgear::function_6435617c4427123a( headgeartype, self );
            headgeardrop = spawnpickup( headgearref, dropinfo, int( headgearhealth ), 1, undefined, allowautopickup );
        }
        
        br_headgear::function_ba7af88505b7d878( headgeartype, self );
        
        if ( isdefined( headgeardrop ) )
        {
            function_7a45cbf285d2f3af( headgeardrop );
        }
        
        br_instance_inventory::function_bf3288672a33d4a2( self );
        
        if ( !dontspawnitem )
        {
            br_headgear::tryrestock( headgeartype, self );
        }
    }
    
    br_public::updatebrscoreboardstat( "headGearType", 0 );
}

// Namespace br_pickups
// Params 5
// Checksum 0x9756d156, Offset: 0xc94a
// Size: 0x120
function function_364fcbacd8b7472( dropstruct, fromkiosk, droppurchased, purchasedkillstreak, pickup )
{
    var_364fcbacd8b7472 = droppurchased && isdefined( purchasedkillstreak );
    
    if ( var_364fcbacd8b7472 )
    {
        function_6cebf175e5947276( fromkiosk );
        distanceoverride = level.br_pickups.distanceoverride;
        overrideorigin = undefined;
        
        if ( isdefined( pickup ) )
        {
            if ( isdefined( pickup.overridedist ) )
            {
                distanceoverride = pickup.overridedist;
            }
            
            if ( isdefined( pickup.origin ) )
            {
                overrideorigin = pickup.origin;
            }
        }
        
        dropinfo = pickups::getitemdroporiginandangles( dropstruct, self.origin, self.angles, self, level.br_pickups.yawoffsetoverride, distanceoverride, undefined, undefined, overrideorigin );
        spawnpickup( level.br_pickups.var_5515c706eaccd3[ purchasedkillstreak ], dropinfo );
        return;
    }
    
    dropbrkillstreak( dropstruct, fromkiosk );
}

// Namespace br_pickups
// Params 5
// Checksum 0x61311fc3, Offset: 0xca72
// Size: 0x2bb
function dropbrkillstreak( dropstruct, fromkiosk, var_6432f32bb6fece8b, dropfeedback, pickup )
{
    if ( hasanykillstreak() )
    {
        function_6cebf175e5947276( fromkiosk );
        scriptable = level.br_pickups.var_5515c706eaccd3[ self.streakdata.streaks[ 1 ].streakname ];
        
        if ( isdefined( var_6432f32bb6fece8b ) )
        {
            lootid = loot::function_d3e3bcaea591a6a2( scriptable );
            br_default_inventory::function_5429728066900449( self, var_6432f32bb6fece8b, lootid, 1, 65535, 0 );
        }
        else
        {
            distanceoverride = level.br_pickups.distanceoverride;
            overrideorigin = undefined;
            
            if ( isdefined( pickup ) )
            {
                if ( isdefined( pickup.overridedist ) )
                {
                    distanceoverride = pickup.overridedist;
                }
                
                if ( isdefined( pickup.origin ) )
                {
                    overrideorigin = pickup.origin;
                }
            }
            
            baseorigin = self.origin;
            baseangles = self.angles;
            yawoffsetoverride = level.br_pickups.yawoffsetoverride;
            
            if ( fromkiosk && isdefined( self.br_kiosk ) )
            {
                distanceoverride = undefined;
                overrideorigin = undefined;
                yawoffsetoverride = undefined;
                baseorigin = self.br_kiosk.origin;
                baseangles = self.br_kiosk.angles;
                
                if ( isdefined( self.br_kiosk.centerbottom ) )
                {
                    baseorigin = self.br_kiosk.centerbottom;
                }
                
                if ( isdefined( self.br_kiosk.linkedparent ) )
                {
                    baseorigin = self.br_kiosk.linkedparent.origin + rotatevector( baseorigin, self.br_kiosk.linkedparent.angles );
                }
            }
            
            dropinfo = pickups::getitemdroporiginandangles( dropstruct, baseorigin, baseangles, self, yawoffsetoverride, distanceoverride, undefined, undefined, overrideorigin );
            allowautopickup = isalive( self ) || getdvarint( @"hash_75376790b7cf7e23", 0 );
            item = spawnpickup( scriptable, dropinfo, 1, 1, undefined, allowautopickup );
            function_7a45cbf285d2f3af( item );
            killstreaks::removekillstreak( 1 );
            
            if ( dropfeedback )
            {
                quickdropplaysound( 3, dropinfo.origin, scriptable, item );
            }
        }
        
        return;
    }
    
    if ( isdefined( var_6432f32bb6fece8b ) )
    {
        br_default_inventory::function_8dd4724906f22d8c( self, var_6432f32bb6fece8b );
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0x94c76e5c, Offset: 0xcd35
// Size: 0x69
function dropbrselfrevivetoken( dropstruct )
{
    if ( laststand::hasselfrevivetoken() )
    {
        dropinfo = pickups::getitemdroporiginandangles( dropstruct, self.origin, self.angles, self );
        item = spawnpickup( br_public::function_a62f204c9c901e6f( self ), dropinfo, 1, 1 );
        function_7a45cbf285d2f3af( item );
        removeselfrevivetoken();
    }
}

// Namespace br_pickups
// Params 4
// Checksum 0x713192b5, Offset: 0xcda6
// Size: 0x1c5
function dropbrcustompickupitem( scriptablename, countoverride, fromkiosk, droppurchased )
{
    var_c6fac63e772454bc = droppurchased && isdefined( scriptablename );
    
    if ( var_c6fac63e772454bc )
    {
        function_6cebf175e5947276( fromkiosk );
        dropstruct = pickups::function_f71dd588dc4f6288();
        
        if ( fromkiosk && isdefined( self.br_kiosk ) && isdefined( self.br_kiosk.dropstruct ) )
        {
            slotindex = self.br_kiosk function_ef8a0f215f5f8b92();
            self.br_kiosk.dropstruct.dropidx = slotindex;
            dropstruct = self.br_kiosk.dropstruct;
            
            if ( !isdefined( countoverride ) )
            {
                countoverride = 1;
            }
            
            var_48757da99828d5d8 = self.br_kiosk quickdropaddtoexisting( undefined, scriptablename, countoverride );
            
            if ( !var_48757da99828d5d8 )
            {
                dropinfo = pickups::getitemdroporiginandangles( dropstruct, self.br_kiosk.centerbottom ?? self.br_kiosk.origin, self.br_kiosk.angles, self );
                item = spawnpickup( scriptablename, dropinfo, countoverride, 1, undefined, 0 );
                self.br_kiosk quickdropaddtocache( scriptablename, undefined, item, dropinfo.origin, dropinfo.angles );
            }
            
            return;
        }
        
        dropinfo = pickups::getitemdroporiginandangles( dropstruct, self.origin, self.angles, self );
        item = spawnpickup( scriptablename, dropinfo, countoverride );
        function_7a45cbf285d2f3af( item );
    }
}

// Namespace br_pickups
// Params 0
// Checksum 0x4c782040, Offset: 0xcf73
// Size: 0x38
function function_ad89197d7104e665()
{
    if ( isdefined( self.var_24633d8241ca5c23 ) && isdefined( self.var_24633d8241ca5c23.var_3cb7bc08e98113e2 ) )
    {
        item = namespace_5ab67a14d18bea3f::dropperkpack();
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0xb5378c7, Offset: 0xcfb3
// Size: 0xc
function dropdogtag( dropstruct )
{
    
}

// Namespace br_pickups
// Params 3
// Checksum 0x48918b41, Offset: 0xcfc7
// Size: 0x91
function function_14e6129340c2ff2d( dropstruct, itemindex, lootid )
{
    backpackname = br_default_inventory::function_ea8b0d4fb96856a5( lootid );
    
    if ( isdefined( br_elite_broken_arrow::function_a246dc01c1d8e60e( backpackname, 0 ) ) )
    {
        dropinfo = pickups::getitemdroporiginandangles( dropstruct, self.origin, self.angles, self );
        br_elite_broken_arrow::function_957e2129483a9d92( dropinfo, self );
        spawnedelement = spawnpickup( backpackname, dropinfo, 1, 0, undefined, 0 );
        br_elite_broken_arrow::function_51730e86424734b2( self, spawnedelement, itemindex );
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0xb9495188, Offset: 0xd060
// Size: 0x35
function function_7a45cbf285d2f3af( item )
{
    if ( !player::isreallyalive( self ) && isdefined( item ) )
    {
        self.var_d5e836adfb09a0ef[ self.var_d5e836adfb09a0ef.size ] = item;
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0xbda9d0c8, Offset: 0xd09d
// Size: 0x23, Type: bool
function ispickupstackable( scriptablename )
{
    return istrue( level.br_pickups.stackable[ scriptablename ] );
}

// Namespace br_pickups
// Params 0
// Checksum 0x90e082bc, Offset: 0xd0c9
// Size: 0x32, Type: bool
function isitemslotopen()
{
    for ( i = 0; i < 8 ; i++ )
    {
        if ( !isdefined( self.br_inventory_slots[ i ] ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_pickups
// Params 2
// Checksum 0xa6042800, Offset: 0xd104
// Size: 0x2f, Type: bool
function isitemfull( item, pickupcount )
{
    return pickupcount + item.count > item.maxcount;
}

// Namespace br_pickups
// Params 2
// Checksum 0x14310652, Offset: 0xd13c
// Size: 0xa7, Type: bool
function canstackpickup( scriptablename, pickupcount )
{
    foreach ( item in self.br_inventory_slots )
    {
        if ( item.scriptablename == scriptablename )
        {
            if ( !isitemfull( item, pickupcount ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace br_pickups
// Params 2
// Checksum 0xc40573ff, Offset: 0xd1ec
// Size: 0x35, Type: bool
function canslotitem( scriptablename, pickupcount )
{
    if ( ispickupstackable( scriptablename ) )
    {
        if ( canstackpickup( scriptablename, pickupcount ) )
        {
            return true;
        }
    }
    
    return isitemslotopen();
}

// Namespace br_pickups
// Params 0
// Checksum 0x18e42c60, Offset: 0xd22a
// Size: 0x33
function getfirstopenslot()
{
    for ( i = 0; i < 8 ; i++ )
    {
        if ( !isdefined( self.br_inventory_slots[ i ] ) )
        {
            return i;
        }
    }
    
    return -1;
}

// Namespace br_pickups
// Params 1
// Checksum 0x5b1b0389, Offset: 0xd266
// Size: 0x155
function pickupitemintoinventory( pickup )
{
    if ( ispickupstackable( pickup.scriptablename ) )
    {
        if ( canstackpickup( pickup.scriptablename, pickup.count ) )
        {
            foreach ( item in self.br_inventory_slots )
            {
                if ( item.scriptablename == pickup.scriptablename )
                {
                    if ( !isitemfull( item, pickup.count ) )
                    {
                        item.count += pickup.count;
                        item.count = int( min( item.count, pickup.maxcount ) );
                        return;
                    }
                }
            }
        }
    }
    
    firstopenslot = getfirstopenslot();
    
    if ( firstopenslot == -1 )
    {
        return;
    }
    
    self.br_inventory_slots[ firstopenslot ] = pickup;
}

// Namespace br_pickups
// Params 1
// Checksum 0x587aa17, Offset: 0xd3c3
// Size: 0x58
function takegenericgrenadepickup( pickupent )
{
    ammocount = equipment_mp::getequipmentslotammo( "primary" );
    
    if ( ammocount < 2 )
    {
        equipment_mp::incrementequipmentslotammo( "primary" );
    }
    
    ammocount = equipment_mp::getequipmentslotammo( "secondary" );
    
    if ( ammocount < 2 )
    {
        equipment_mp::incrementequipmentslotammo( "secondary" );
    }
}

// Namespace br_pickups
// Params 2
// Checksum 0xf95b2a94, Offset: 0xd423
// Size: 0x124
function trypickupitem( scriptablename, count )
{
    if ( !( isdefined( scriptablename ) && isdefined( level.br_pickups.maxcounts[ scriptablename ] ) && isdefined( level.br_pickups.stackable[ scriptablename ] ) ) )
    {
        return;
    }
    
    pickup = spawnstruct();
    pickup.scriptablename = scriptablename;
    pickup.count = count;
    pickup.maxcount = level.br_pickups.maxcounts[ scriptablename ];
    pickup.stackable = level.br_pickups.stackable[ scriptablename ];
    pickup.itemtype = level.br_pickups.br_itemtype[ scriptablename ];
    
    if ( canslotitem( pickup.scriptablename, pickup.count ) )
    {
        pickupitemintoinventory( pickup );
        return;
    }
    
    self iprintlnbold( "No room in inventory" );
    self playlocalsound( "fly_pickup_deny" );
}

// Namespace br_pickups
// Params 2
// Checksum 0x9290b433, Offset: 0xd54f
// Size: 0xd4
function droparmor( itemtype, itemhealth )
{
    dropinfo = pickups::getitemdropinfo( self.origin + level.br_pickups.br_dropoffsets[ 0 ], self.angles );
    pickupent = spawnpickup( itemtype, dropinfo );
    pickupent.count = 1;
    pickupent.helmethealth = 0;
    pickupent.armorhealth = 0;
    pickupent.gasmaskhealth = 0;
    
    if ( issubstr( itemtype, "helmet" ) )
    {
        pickupent.helmethealth = itemhealth;
        
        if ( itemtype == "brloot_armor_helmet_3" )
        {
            perk::removeperk( "specialty_stun_resistance" );
        }
    }
    
    br_analytics::branalytics_lootdrop( self, itemtype );
}

// Namespace br_pickups
// Params 1
// Checksum 0xae4732ae, Offset: 0xd62b
// Size: 0x57
function trydroparmorfornewarmor( scriptablename )
{
    if ( br_public::ishelmet( scriptablename ) )
    {
        if ( isdefined( self.br_helmetlevel ) )
        {
            itemtype = armor::helmetitemtypeforlevel( self.br_helmetlevel );
            
            if ( isdefined( itemtype ) )
            {
                droparmor( itemtype, self.br_helmethealth );
            }
        }
    }
}

// Namespace br_pickups
// Params 2
// Checksum 0xff4f0471, Offset: 0xd68a
// Size: 0x9c
function tryequiparmor( item, slot )
{
    if ( isdefined( slot ) )
    {
        self.br_inventory_slots[ slot ] = undefined;
    }
    
    trydroparmorfornewarmor( item.scriptablename );
    
    if ( item.scriptablename == "brloot_armor_helmet_1" )
    {
        armor::takehelmet( item, 1 );
        return;
    }
    
    if ( item.scriptablename == "brloot_armor_helmet_2" )
    {
        armor::takehelmet( item, 2 );
        return;
    }
    
    if ( item.scriptablename == "brloot_armor_helmet_3" )
    {
        armor::takehelmet( item, 3 );
    }
}

// Namespace br_pickups
// Params 2
// Checksum 0x4fa80c8, Offset: 0xd72e
// Size: 0x6a
function brpickupsusecallback( entity, player )
{
    results = player cantakepickup( entity );
    player showuseresultsfeedback( results );
    
    if ( results != 1 )
    {
        return;
    }
    
    player onusecompleted( entity );
    pickups::deregisterscriptableinstance( entity );
    
    if ( entity isscriptable() )
    {
        entity freescriptable();
        return;
    }
    
    entity delete();
}

// Namespace br_pickups
// Params 0
// Checksum 0x8b721579, Offset: 0xd7a0
// Size: 0x39
function function_1190855e1ea8f90f()
{
    if ( self.gasmaskequipped )
    {
        self detach( "hat_child_hadir_gas_mask_wm_br", "j_head" );
        self.gasmaskequipped = 0;
    }
    
    self.gasmaskswapinprogress = 0;
    function_5375ae93bfe708df();
}

// Namespace br_pickups
// Params 0
// Checksum 0xb68833cc, Offset: 0xd7e1
// Size: 0x69
function function_5375ae93bfe708df()
{
    self.gasmaskmaxhealth = undefined;
    self.gasmaskhealth = undefined;
    self.headgearrequests = undefined;
    self.headgeartype = undefined;
    scuba_gasmask::removescubagasmaskfromplayer( self );
    self setclientomnvar( "ui_gas_mask", 0 );
    self setclientomnvar( "ui_head_equip_class", 0 );
    self setclientomnvar( "ui_gasmask_damage", 0 );
    self setclientomnvar( "ui_gas_mask_opacity_override", 0 );
    operator::function_89e5e91ee0fb0836();
}

/#

    // Namespace br_pickups
    // Params 0
    // Checksum 0x2b70ac78, Offset: 0xd852
    // Size: 0x89, Type: dev
    function function_6ac9fd6a59587d24()
    {
        br_forcegivecustompickupitem( self, "<dev string:x2a4>", 1, 3 );
        br_plunder::playerplunderpickup( 500 );
        br_forcegivecustompickupitem( self, "<dev string:x2b7>", 1 );
        br_forcegivecustompickupitem( self, "<dev string:x2cc>", 1 );
        br_forcegivecustompickupitem( self, "<dev string:x2ef>", 1 );
        br_forcegivecustompickupitem( self, "<dev string:x302>", 1 );
        br_forcegivecustompickupitem( self, "<dev string:x31f>", 1 );
        br_forcegivecustompickupitem( self, "<dev string:x335>", 1 );
        br_forcegivecustompickupitem( self, "<dev string:x354>", 1 );
    }

    // Namespace br_pickups
    // Params 0
    // Checksum 0x6bf3f4d5, Offset: 0xd8e3
    // Size: 0x20, Type: dev
    function quickdropfill()
    {
        br_forcegivecustompickupitem( self, "<dev string:x2a4>", 1, 3 );
        br_plunder::playerplunderpickup( 500 );
    }

#/

// Namespace br_pickups
// Params 1
// Checksum 0xc4ae31df, Offset: 0xd90b
// Size: 0x53
function getquickdropplundercount( dropall )
{
    plunderdropsomeamount = getmatchrulesdata( "brData", "plunderDropSomeAmount" );
    
    if ( dropall )
    {
        return int( min( self.plundercount, 2047 ) );
    }
    
    return int( min( self.plundercount, plunderdropsomeamount ) );
}

// Namespace br_pickups
// Params 1
// Checksum 0x56325475, Offset: 0xd967
// Size: 0x5e
function getquickdropweapon( itemindex )
{
    dropweaponobj = function_5ef22d170cdde55e( self, itemindex );
    assert( isdefined( dropweaponobj ) );
    assert( !isnullweapon( dropweaponobj ) );
    assert( !weapon::isfistweapon( dropweaponobj ) );
    weaponname = getcompleteweaponname( dropweaponobj );
    return weaponname;
}

// Namespace br_pickups
// Params 2
// Checksum 0xc84d1943, Offset: 0xd9ce
// Size: 0xd4
function function_5ef22d170cdde55e( player, itemindex )
{
    if ( itemindex == 2 )
    {
        return br_default_inventory::function_3b4976a12ea5037b( player );
    }
    
    weaponlist = player.equippedweapons;
    var_8ba40327ab269093 = itemindex == 0;
    
    foreach ( weapon in weaponlist )
    {
        if ( !weapons::isdroppableweapon( player, weapon ) )
        {
            continue;
        }
        
        if ( var_8ba40327ab269093 )
        {
            return weapon;
        }
        
        var_8ba40327ab269093 = 1;
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0x879ab5f3, Offset: 0xdaaa
// Size: 0x2b0
function quickdropremoveweapon( var_f7cb5f756a346f4a )
{
    fistsweapon = level.defaultfist;
    assert( isdefined( var_f7cb5f756a346f4a ) );
    assert( !isnullweapon( var_f7cb5f756a346f4a ) );
    assert( var_f7cb5f756a346f4a != fistsweapon );
    var_cd7bb6f332ee144e = fistsweapon;
    primaryweapons = self getweaponslistprimaries();
    
    foreach ( weapon in primaryweapons )
    {
        if ( weapon.inventorytype != "primary" )
        {
            continue;
        }
        
        if ( class::function_d31c1081fbeb777b() && weapon::isbackuppistol( weapon ) )
        {
            continue;
        }
        
        if ( weapon != fistsweapon && weapon != var_f7cb5f756a346f4a && !weapon::ismeleeoverrideweapon( weapon ) && !weapon::isunderwaterweapon( weapon ) && !weapon::isclimbweapon( weapon ) )
        {
            if ( !self isalternatemode( weapon ) )
            {
                var_cd7bb6f332ee144e = weapon;
            }
            else
            {
                foreach ( altweapon in primaryweapons )
                {
                    if ( altweapon.basename == weapon.basename && altweapon.inventorytype == "altmode" )
                    {
                        var_cd7bb6f332ee144e = altweapon;
                        break;
                    }
                }
            }
            
            break;
        }
    }
    
    if ( !weapon_utility::isriotshield( var_f7cb5f756a346f4a ) )
    {
        ammostock = self getweaponammostock( var_f7cb5f756a346f4a );
        weaponammotype = br_weapons::br_ammo_type_for_weapon( var_f7cb5f756a346f4a );
        
        if ( isdefined( weaponammotype ) )
        {
            self.br_ammo[ weaponammotype ] = min( ammostock, level.br_ammo_max_stock[ weaponammotype ] );
            self.br_ammo[ weaponammotype ] = utility::get_int_or_0( self.br_ammo[ weaponammotype ] );
        }
    }
    
    if ( weapon::isminigunweapon( var_f7cb5f756a346f4a ) )
    {
        self notify( #"dropped_minigun" );
    }
    
    if ( getdvarint( @"hash_218b826f84233424", 0 ) )
    {
        function_bea188db0e770fda( var_f7cb5f756a346f4a, 0 );
    }
    
    inventory_utility::_takeweapon( var_f7cb5f756a346f4a );
    br_public::function_c61dc6b780cede50();
    
    if ( !self hasweapon( fistsweapon ) )
    {
        self giveweapon( fistsweapon );
    }
    
    self switchtoweaponimmediate( var_cd7bb6f332ee144e );
}

// Namespace br_pickups
// Params 9
// Checksum 0xe9f826cd, Offset: 0xdd62
// Size: 0x3af
function quickdropweapon( player, itemtype, itemindex, itemcount, dropall, dontspawnitem, overridedist, overrideorigin, regulardrop )
{
    var_f7cb5f756a346f4a = function_5ef22d170cdde55e( player, itemindex );
    
    if ( !isdefined( var_f7cb5f756a346f4a ) || weapon::isunderwaterweapon( var_f7cb5f756a346f4a ) || weapon::isclimbweapon( var_f7cb5f756a346f4a ) || weapon::isstimpistolweapon( var_f7cb5f756a346f4a ) )
    {
        return;
    }
    
    itemcount = 0;
    itemcountlefthand = 0;
    itemcountalt = 0;
    weaponobj = undefined;
    
    if ( !isdefined( var_f7cb5f756a346f4a ) || isnullweapon( var_f7cb5f756a346f4a ) || weapon::isfistweapon( var_f7cb5f756a346f4a ) || self isskydiving() || class::function_d31c1081fbeb777b() && weapon::isbackuppistol( var_f7cb5f756a346f4a ) )
    {
        return 0;
    }
    else
    {
        if ( itemindex == 2 )
        {
            itemcount = player.weaponslotclip ?? player getweaponammoclip( var_f7cb5f756a346f4a );
            itemcountlefthand = player.var_ee5ceae7ad99228 ?? player getweaponammoclip( var_f7cb5f756a346f4a, "left" );
            
            if ( var_f7cb5f756a346f4a.hasalternate )
            {
                weaponaltobj = var_f7cb5f756a346f4a getaltweapon();
                
                if ( isdefined( player.var_655fababc6344d9f ) )
                {
                    itemcountalt = player.var_655fababc6344d9f;
                }
                else if ( br_weapons::br_ammo_type_for_weapon( weaponaltobj ) != br_weapons::br_ammo_type_for_weapon( var_f7cb5f756a346f4a ) )
                {
                    itemcountalt = player getweaponammoclip( weaponaltobj );
                }
            }
        }
        else
        {
            itemcount = player getweaponammoclip( var_f7cb5f756a346f4a );
            itemcountlefthand = player getweaponammoclip( var_f7cb5f756a346f4a, "left" );
            
            if ( var_f7cb5f756a346f4a.hasalternate )
            {
                weaponaltobj = var_f7cb5f756a346f4a getaltweapon();
                weaponammotype = br_weapons::br_ammo_type_for_weapon( var_f7cb5f756a346f4a ) ?? "";
                var_28ac233a7e73ca27 = br_weapons::br_ammo_type_for_weapon( weaponaltobj ) ?? "";
                
                if ( weaponammotype != var_28ac233a7e73ca27 )
                {
                    itemcountalt = player getweaponammoclip( weaponaltobj );
                }
            }
        }
        
        weaponobj = var_f7cb5f756a346f4a;
    }
    
    weaponmetadata = undefined;
    
    if ( br_instance_inventory::function_926a8f8643d34690() )
    {
        if ( itemindex == 2 )
        {
            weaponmetadata = br_instance_inventory::function_6a05cf5689058e1f( player, 2 );
        }
        else
        {
            weaponmetadata = br_instance_inventory::function_6a05cf5689058e1f( player, itemindex );
        }
    }
    
    pastteam = undefined;
    quickdropweapon = getquickdropweapon( itemindex );
    
    if ( itemindex == 2 )
    {
        br_default_inventory::function_f7c0ab39bb3170f( player );
    }
    else
    {
        quickdropremoveweapon( var_f7cb5f756a346f4a );
        br_instance_inventory::function_1e5fd659146e4d80( player, itemindex, istrue( regulardrop ) );
    }
    
    if ( dontspawnitem )
    {
        return 1;
    }
    
    item = quickdropnewitem( itemtype, quickdropweapon, itemcount, itemcountlefthand, itemcountalt, weaponobj, weaponmetadata, overridedist, overrideorigin );
    
    if ( isdefined( item ) )
    {
        item.pastteam = pastteam;
        
        if ( getdvarint( @"hash_52f4a8ccedf61788", 1 ) == 1 )
        {
            if ( weapon::function_33e74163843b348e( weaponobj ) && item.count == 0 )
            {
                if ( isdefined( player.var_6513b5b526741b4c ) )
                {
                    player.var_6513b5b526741b4c pickups::deletescriptableinstance();
                }
                
                player.var_6513b5b526741b4c = item;
            }
        }
    }
    
    assert( isdefined( player.tookweaponfrom ) );
    
    if ( isdefined( item ) )
    {
        if ( isdefined( player.tookweaponfrom[ quickdropweapon ].var_e01941ff17446ef3 ) )
        {
            item.owner = player.tookweaponfrom[ quickdropweapon ].var_e01941ff17446ef3;
            player.tookweaponfrom[ quickdropweapon ].var_e01941ff17446ef3 = undefined;
        }
        else
        {
            item.owner = player;
        }
        
        item.objweapon = weaponobj;
    }
    
    return 1;
}

// Namespace br_pickups
// Params 5
// Checksum 0xa8c06169, Offset: 0xe11a
// Size: 0x9b, Type: bool
function quickdropplunder( player, itemtype, dropall, dontspawnitem, overridecount )
{
    if ( getdvarint( @"hash_9e0e52e9b74f15eb", 0 ) )
    {
        return false;
    }
    
    itemcount = getquickdropplundercount( dropall );
    
    if ( isdefined( overridecount ) )
    {
        itemcount = overridecount;
    }
    
    if ( itemcount == 0 )
    {
        return false;
    }
    
    player br_plunder::playerplunderdrop( itemcount );
    plunderscriptable = br_plunder::getplundernamebyamount( itemcount );
    
    if ( dontspawnitem )
    {
        return true;
    }
    
    quickdropnewitem( itemtype, plunderscriptable, itemcount );
    return true;
}

// Namespace br_pickups
// Params 1
// Checksum 0x815e45e4, Offset: 0xe1be
// Size: 0x43, Type: bool
function function_34f22d7446d00286( scriptablename )
{
    if ( !isdefined( level.var_5c3d5c5d7851ba58 ) || level.var_5c3d5c5d7851ba58.size <= 0 || !isdefined( scriptablename ) )
    {
        return true;
    }
    
    return !isdefined( level.var_5c3d5c5d7851ba58[ scriptablename ] );
}

// Namespace br_pickups
// Params 5
// Checksum 0x3ac7b191, Offset: 0xe20a
// Size: 0x3d5
function function_1c6552d4cf849261( player, itemtype, itemindex, dropall, dontspawnitem )
{
    [ lootid, quantity ] = br_default_inventory::function_c022fc696a9c0db2( itemindex );
    
    if ( lootid == 0 )
    {
        return;
    }
    
    itemcount = undefined;
    itemcountlefthand = undefined;
    itemcountalt = undefined;
    ref = loot::function_f54ecb89dfab8e8c( lootid );
    isdogtag = dmz_dog_tag::function_7b2fcbd8d8d2e2a3( lootid );
    isperkpack = namespace_5ab67a14d18bea3f::function_e96bd96c3a428bb8( ref );
    
    if ( utility::issharedfuncdefined( lootid, #"canquickdrop" ) )
    {
        if ( !utility::callsharedfunc( lootid, #"canquickdrop", player ) )
        {
            return;
        }
    }
    
    if ( function_fe0521864025d97e( ref ) )
    {
        function_58fb35e7414b9c05( lootid, quantity, ref, itemindex );
    }
    
    if ( dropall || function_bcc6dc9b2b7365e0( lootid ) )
    {
        itemcount = quantity;
    }
    else if ( br_public::isammo( ref ) )
    {
        itemcount = int( min( quantity, level.br_pickups.counts[ ref ] ) );
    }
    else
    {
        itemcount = 1;
    }
    
    if ( isperkpack && !dontspawnitem )
    {
        slot = function_ef8a0f215f5f8b92();
        thread function_dc6f8ce37163a81();
        namespace_5ab67a14d18bea3f::dropperkpack( undefined, undefined, itemindex );
        dontspawnitem = 1;
    }
    else if ( function_e44a0803d593564( lootid ) )
    {
        return 0;
    }
    else if ( function_1578d9983da7761a( ref ) )
    {
        slot = function_ef8a0f215f5f8b92();
        thread function_dc6f8ce37163a81();
        dropstruct = pickups::function_f71dd588dc4f6288();
        dropstruct.dropidx = slot;
        elementid = br_elite_broken_arrow::function_a246dc01c1d8e60e( lootid, 5 );
        elemname = br_elite_broken_arrow::function_ca621b047cf24253( elementid, 0 );
        dropinfo = pickups::getitemdroporiginandangles( dropstruct, self.origin, self.angles, self, undefined );
        br_elite_broken_arrow::function_957e2129483a9d92( dropinfo, self );
        element = spawnpickup( elemname, dropinfo, itemcount, 1, undefined, 0 );
        br_elite_broken_arrow::function_51730e86424734b2( self, element, itemindex );
        dontspawnitem = 1;
    }
    else if ( function_d1bdfe41ee9800f9( ref ) )
    {
        slot = function_ef8a0f215f5f8b92();
        thread function_dc6f8ce37163a81();
        dropstruct = pickups::function_f71dd588dc4f6288();
        dropstruct.dropidx = slot;
        player br_strongholds::function_30128ad2ab80b07d( dropstruct, player.blacksite );
        dontspawnitem = 1;
    }
    else if ( function_1f87e4642e088efd( ref ) )
    {
        if ( utility::issharedfuncdefined( #"hash_8538e247e32e58b9", #"hash_f68dee5c61e4c6af" ) )
        {
            dronepart = loot::getScriptableFromLootID( lootid );
            level thread [[ utility::getsharedfunc( #"hash_8538e247e32e58b9", #"hash_f68dee5c61e4c6af" ) ]]( dronepart, player );
        }
    }
    
    ref = loot::function_f54ecb89dfab8e8c( lootid );
    scriptable = undefined;
    
    if ( br_public::isammo( ref ) )
    {
        scriptable = ref;
    }
    else
    {
        scriptable = loot::getScriptableFromLootID( lootid );
    }
    
    if ( dropall && scriptable == "brloot_gascan" )
    {
        [ error, newcount ] = vehicle_interact::gas_can_siphon_vehicle( itemcount );
        
        if ( isdefined( error ) )
        {
            hud_message::showerrormessage( error );
            return;
        }
        
        br_default_inventory::function_d625d28b11a26654( self, itemindex, newcount );
        playsoundatpos( self.origin + ( 0, 0, 30 ), "eqp_gas_can_siphon" );
        return;
    }
    
    player br_default_inventory::function_39f0833282ad6f6( itemindex, isdogtag || isperkpack ? quantity : itemcount );
    
    if ( dontspawnitem )
    {
        return;
    }
    
    if ( isdefined( scriptable ) )
    {
        quickdropnewitem( itemtype, scriptable, itemcount, itemcountlefthand, itemcountalt );
    }
}

// Namespace br_pickups
// Params 5
// Checksum 0x35ec3a3e, Offset: 0xe5e7
// Size: 0x170, Type: bool
function function_ed92a440ddcbc97b( player, itemindex, itemtype, dropall, dontspawnitem )
{
    itemcount = player equipment_mp::getequipmentslotammo( equipment_mp::function_b1928e5713e81b5e( itemindex ) );
    
    if ( !isdefined( itemcount ) || itemcount == 0 )
    {
        return false;
    }
    
    slot = equipment_mp::function_b1928e5713e81b5e( itemindex );
    ref = equipment_mp::getcurrentequipment( slot );
    
    if ( utility::issharedfuncdefined( ref, #"getammo" ) )
    {
        itemcount = player [[ utility::getsharedfunc( ref, #"getammo" ) ]]();
        dropall = 1;
    }
    
    if ( !dropall )
    {
        itemcount = 1;
    }
    
    equipment_mp::decrementequipmentslotammo( slot, itemcount );
    
    if ( !dontspawnitem )
    {
        dropslot = function_ef8a0f215f5f8b92();
        player thread function_dc6f8ce37163a81();
        dropstruct = pickups::function_f71dd588dc4f6288();
        dropstruct.dropidx = dropslot;
        player dropequipmentinslot( dropstruct, slot, 0, itemcount, undefined, 0, itemtype, 1 );
    }
    
    if ( ref == ( level.armorref ?? "equip_armorplate" ) )
    {
        player armor::function_d844468b44333411();
    }
    
    if ( ref == "equip_throwing_knife" && player equipment_mp::getequipmentslotammo( slot ) == 0 && isdefined( player.perks[ "specialty_equip_throwingKnife" ] ) )
    {
        player throwing_knife_mp::throwing_knife_mp_ontake();
    }
    
    return true;
}

// Namespace br_pickups
// Params 3
// Checksum 0x24cb8efd, Offset: 0xe760
// Size: 0x90, Type: bool
function function_7178851e773d21c5( player, dropall, dontspawnitem )
{
    itemcount = 1;
    
    if ( !player hasanykillstreak() )
    {
        return false;
    }
    
    if ( !dontspawnitem )
    {
        slot = function_ef8a0f215f5f8b92();
        player thread function_dc6f8ce37163a81();
        dropstruct = pickups::function_f71dd588dc4f6288();
        dropstruct.dropidx = slot;
        player dropbrkillstreak( dropstruct, 0, undefined, 1 );
    }
    
    killstreaks::removekillstreak( 1 );
    return true;
}

// Namespace br_pickups
// Params 2
// Checksum 0xf81da60a, Offset: 0xe7f9
// Size: 0x1e
function quickdropgasmaskitem( player, dontspawnitem )
{
    return quickdropheadgear( player, dontspawnitem );
}

// Namespace br_pickups
// Params 2
// Checksum 0xe5464b36, Offset: 0xe820
// Size: 0x5d, Type: bool
function quickdropheadgear( player, dontspawnitem )
{
    slot = function_ef8a0f215f5f8b92();
    player thread function_dc6f8ce37163a81();
    dropstruct = pickups::function_f71dd588dc4f6288();
    dropstruct.dropidx = slot;
    player thread dropheadgear( dropstruct, dontspawnitem, 1 );
    return true;
}

// Namespace br_pickups
// Params 2
// Checksum 0xdc44b08a, Offset: 0xe886
// Size: 0x6c, Type: bool
function function_2d949a5d88cadcc4( player, dontspawnitem )
{
    if ( !dontspawnitem )
    {
        slot = function_ef8a0f215f5f8b92();
        player thread function_dc6f8ce37163a81();
        dropstruct = pickups::function_f71dd588dc4f6288();
        dropstruct.dropidx = slot;
        player dropbrselfrevivetoken( dropstruct );
    }
    else
    {
        player removeselfrevivetoken();
    }
    
    return true;
}

// Namespace br_pickups
// Params 3
// Checksum 0x1ca75c4a, Offset: 0xe8fb
// Size: 0x124
function function_9632355c478445e0( player, dropall, dontspawnitem )
{
    itemcount = player function_d743bcc9a06c3bb2();
    equipref = self.equipment[ "super" ];
    
    if ( isdefined( self.equipment[ "super" ] ) && player supers_mp::function_31f00fe6e0334d03() && supers_mp::issuperready() )
    {
        itemcount = 1;
    }
    
    if ( !isdefined( itemcount ) || itemcount == 0 )
    {
        return 0;
    }
    
    if ( !dropall )
    {
        itemcount = 1;
    }
    
    if ( !dontspawnitem )
    {
        if ( isdefined( equipref ) && vehicle_drop::function_1147d252fa28e09f( equipref ) )
        {
            return 0;
        }
        
        slot = function_ef8a0f215f5f8b92();
        player thread function_dc6f8ce37163a81();
        dropstruct = pickups::function_f71dd588dc4f6288();
        dropstruct.dropidx = slot;
        player dropequipmentinslot( dropstruct, "super", 0, itemcount, undefined, 0, 4, 1 );
    }
    
    if ( supers_mp::issuperinuse() )
    {
        supers_mp::superusefinished();
    }
    
    player resetsuper();
    self.equipment[ "super" ] = undefined;
}

// Namespace br_pickups
// Params 2
// Checksum 0xd1aa2218, Offset: 0xea27
// Size: 0x41
function function_e4fef6be87257f3f( player, dontspawnitem )
{
    if ( !dontspawnitem )
    {
        slot = function_ef8a0f215f5f8b92();
        player thread function_dc6f8ce37163a81();
        function_ad89197d7104e665();
        dontspawnitem = 1;
    }
}

// Namespace br_pickups
// Params 4
// Checksum 0xc8b0624c, Offset: 0xea70
// Size: 0x145
function function_fa47dd9cf7f6fbce( itemtype, itemindex, dropall, dontspawnitem )
{
    switch ( itemtype )
    {
        case 0:
            quickdropplunder( self, itemtype, dropall, dontspawnitem );
            break;
        case 1:
            quickdropweapon( self, itemtype, itemindex, undefined, dropall, dontspawnitem, undefined, undefined, 1 );
            break;
        case 10:
            function_1c6552d4cf849261( self, itemtype, itemindex, dropall, dontspawnitem );
            break;
        case 2:
            function_ed92a440ddcbc97b( self, itemindex, itemtype, dropall, dontspawnitem );
            break;
        case 3:
            function_7178851e773d21c5( self, dropall, dontspawnitem );
            break;
        case 4:
            function_9632355c478445e0( self, 1, dontspawnitem );
            break;
        case 6:
            quickdropheadgear( self, dontspawnitem );
            break;
        case 7:
            function_2d949a5d88cadcc4( self, dontspawnitem );
            break;
        case 13:
            function_e4fef6be87257f3f( self, dontspawnitem );
            break;
        default:
            assertmsg( "<dev string:x36e>" + itemtype );
            return;
    }
}

// Namespace br_pickups
// Params 0
// Checksum 0xb76b72f1, Offset: 0xebbd
// Size: 0x4d
function quickdropcleanupcache()
{
    var_41a9723c32c56d1a = 120;
    self notify( #"hash_70c158b11da93503" );
    self endon( #"hash_70c158b11da93503" );
    self endon( #"death" );
    level endon( #"game_ended" );
    wait var_41a9723c32c56d1a;
    self.quickdropcache = undefined;
}

// Namespace br_pickups
// Params 5
// Checksum 0x2722125a, Offset: 0xec12
// Size: 0xfe
function quickdropaddtocache( scriptablename, slot, ent, droporigin, dropangles )
{
    if ( !isdefined( self.quickdropcache ) )
    {
        self.quickdropcache = [];
    }
    
    newitem = spawnstruct();
    newitem.scriptablename = scriptablename;
    newitem.slot = slot;
    newitem.ent = ent;
    newitem.droporigin = droporigin;
    newitem.dropangles = dropangles;
    newitem.playerorigin = self.origin;
    newitem.playeryaw = self.angles[ 1 ];
    
    if ( isplunder( scriptablename ) )
    {
        self.quickdropcache[ "cash" ] = newitem;
    }
    else
    {
        self.quickdropcache[ scriptablename ] = newitem;
    }
    
    thread quickdropcleanupcache();
}

// Namespace br_pickups
// Params 1
// Checksum 0x17dbcae7, Offset: 0xed18
// Size: 0xb4
function quickdropfinditemincache( scriptablename )
{
    if ( !isdefined( scriptablename ) )
    {
        return;
    }
    
    if ( !isdefined( self.quickdropcache ) )
    {
        return;
    }
    
    cacheindex = scriptablename;
    
    if ( isplunder( scriptablename ) )
    {
        cacheindex = "cash";
    }
    
    if ( !isdefined( self.quickdropcache[ cacheindex ] ) )
    {
        return;
    }
    
    if ( !isdefined( self.quickdropcache[ cacheindex ].ent ) )
    {
        self.quickdropcache[ cacheindex ] = undefined;
        return;
    }
    
    if ( distancesquared( self.quickdropcache[ cacheindex ].droporigin, self.origin ) > 20000 )
    {
        return;
    }
    
    return self.quickdropcache[ cacheindex ];
}

// Namespace br_pickups
// Params 0
// Checksum 0x2fd14743, Offset: 0xedd5
// Size: 0xa8
function function_ef8a0f215f5f8b92()
{
    if ( !isdefined( level.quickdropindexes ) )
    {
        level.quickdropindexes = [ 0, 8, 1, 7, 2, 9, 17, 10, 16, 18, 26, 19, 25 ];
    }
    
    if ( !isdefined( self.quickdropindex ) )
    {
        self.quickdropindex = 0;
    }
    else
    {
        self.quickdropindex++;
    }
    
    return level.quickdropindexes[ self.quickdropindex % level.quickdropindexes.size ];
}

// Namespace br_pickups
// Params 0
// Checksum 0xc0acecc1, Offset: 0xee86
// Size: 0x9c
function function_dc6f8ce37163a81()
{
    self endon( #"disconnect" );
    
    if ( isdefined( self ) && self.quickdropindex == 0 )
    {
        startorigin = self.origin;
        startangles = self.angles;
        
        while ( isdefined( self ) && distancesquared( startorigin, self.origin ) < 100 && anglesdelta( startangles, self.angles ) < 10 )
        {
            wait 1;
        }
        
        if ( isdefined( self ) )
        {
            self.quickdropindex = undefined;
            self notify( #"reset_slots" );
        }
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0xb1160431, Offset: 0xef2a
// Size: 0xd4
function function_458426e942bdda96( scriptablename )
{
    if ( isplunder( scriptablename ) )
    {
        return "fly_drop_cash_plunder_med";
    }
    else if ( br_public::isammo( scriptablename ) )
    {
        return "fly_drop_ammo";
    }
    else if ( scriptablename == "brloot_offhand_throwingknife" || scriptablename == "brloot_offhand_shuriken" )
    {
        return "fly_drop_knife";
    }
    else if ( scriptablename == "brloot_gascan" )
    {
        return "fly_drop_gas_can";
    }
    else if ( br_public::isequipmentlethal( scriptablename ) )
    {
        return "fly_drop_lethal";
    }
    else if ( br_public::isequipmenttactical( scriptablename ) )
    {
        return "fly_drop_tactical";
    }
    else if ( br_public::isarmorplate( scriptablename ) )
    {
        return "fly_drop_armor";
    }
    else if ( isstartstr( scriptablename, "iw" ) )
    {
        return "fly_drop_weap";
    }
    else if ( isstartstr( scriptablename, "loot_key" ) )
    {
        return "fly_drop_key";
    }
    
    return "fly_drop_generic";
}

// Namespace br_pickups
// Params 5
// Checksum 0x55164fde, Offset: 0xf007
// Size: 0x1f2
function quickdropplaysound( itemtype, droporigin, scriptablename, newent, weaponobj )
{
    aliasname = undefined;
    
    switch ( itemtype )
    {
        case 5:
            aliasname = "fly_drop_ammo";
            break;
        case 0:
            if ( scriptablename == "brloot_plunder_cash_uncommon_1" )
            {
                aliasname = "fly_drop_cash_plunder_sm";
            }
            else if ( scriptablename == "brloot_plunder_cash_uncommon_2" )
            {
                aliasname = "fly_drop_cash_plunder_sm";
            }
            else if ( scriptablename == "brloot_plunder_cash_uncommon_3" )
            {
                aliasname = "fly_drop_cash_plunder_sm";
            }
            else if ( scriptablename == "brloot_plunder_cash_rare_1" )
            {
                aliasname = "fly_drop_cash_plunder_med";
            }
            else if ( scriptablename == "brloot_plunder_cash_rare_2" )
            {
                aliasname = "fly_drop_cash_plunder_med";
            }
            else if ( scriptablename == "brloot_plunder_cash_epic_1" )
            {
                aliasname = "fly_drop_cash_plunder_lrg";
            }
            else if ( scriptablename == "brloot_plunder_cash_epic_2" )
            {
                aliasname = "fly_drop_cash_plunder_lrg";
            }
            else if ( scriptablename == "brloot_plunder_cash_legendary_1" )
            {
                aliasname = "fly_drop_cash_plunder_extra_lrg";
            }
            else
            {
                aliasname = "fly_drop_cash_plunder_med";
            }
            
            break;
        case 1:
            if ( isdefined( weaponobj ) )
            {
                thread function_cc8f316fd971be5d( newent, weaponobj );
                return;
            }
            else
            {
                aliasname = "fly_drop_weap";
            }
            
            break;
        case 2:
        case 3:
        case 4:
        case 6:
        case 7:
        case 10:
            aliasname = function_458426e942bdda96( scriptablename );
            break;
        default:
            assertmsg( "<dev string:x38d>" + itemtype );
            break;
    }
    
    if ( isdefined( aliasname ) )
    {
        if ( isdefined( newent ) && isvector( newent.origin ) )
        {
            playsoundatpos( newent.origin, aliasname );
            return;
        }
        
        self playsound( aliasname );
    }
}

// Namespace br_pickups
// Params 2
// Checksum 0x39b0b4cb, Offset: 0xf201
// Size: 0x11b
function function_cc8f316fd971be5d( newent, weaponobj )
{
    origin = self.origin;
    basename = weaponobj.basename ?? "";
    material = weaponobj.material ?? "";
    
    if ( isdefined( newent ) && isvector( newent.origin ) )
    {
        origin = newent.origin;
    }
    else
    {
        view_origin = self getvieworigin();
        origin = view_origin + anglestoforward( self getplayerangles() ) * 100;
        origin = ( origin[ 0 ], origin[ 1 ], view_origin[ 2 ] );
    }
    
    self playsound( "fly_drop_weap_toss_only" );
    wait 0.5;
    downward = origin + ( 0, 0, -120 );
    trace = trace::ray_trace( origin, downward, self, undefined, 1 );
    surfacetype = trace[ "surfacetype" ];
    waittillframeend();
    weapons::function_acdca5c5e8c63f62( surfacetype );
}

// Namespace br_pickups
// Params 6
// Checksum 0x11f6a192, Offset: 0xf324
// Size: 0x2b1, Type: bool
function quickdropaddtoexisting( itemtype, scriptablename, itemcount, itemcountlefthand, itemcountalt, weaponobj )
{
    if ( !function_34f22d7446d00286( scriptablename ) )
    {
        return false;
    }
    
    cacheitem = quickdropfinditemincache( scriptablename );
    
    if ( isdefined( cacheitem ) )
    {
        oldent = cacheitem.ent;
        oldorigin = cacheitem.droporigin;
        oldangles = cacheitem.dropangles;
        oldcount = common_item::function_44eacd480abb5b94( oldent.count );
        var_4d5b1580ce8a5bae = common_item::function_5c3ce1ec7db94488( oldent.count );
        var_3cb04d64de6da7b9 = common_item::function_3b2613fcafd07797( oldent.count );
        var_51688298211c94eb = istrue( cacheitem.ent.var_7971994d2364af58 );
        newcount = oldcount + itemcount;
        
        if ( newcount >= 2048 )
        {
            return false;
        }
        
        if ( !isdefined( itemcountlefthand ) )
        {
            itemcountlefthand = 0;
        }
        
        var_9df9349d7d54802f = var_4d5b1580ce8a5bae + itemcountlefthand;
        
        if ( !isdefined( itemcountalt ) )
        {
            itemcountalt = 0;
        }
        
        var_50967f0dd9b8b68e = var_3cb04d64de6da7b9 + itemcountalt;
        droppayload = calcscriptablepayloadgravityarc( oldorigin + ( 0, 0, 12 ), oldorigin );
        dropinfo = pickups::getitemdropinfo( oldorigin, oldangles, droppayload, oldent.linkedparent );
        cacheindex = scriptablename;
        
        if ( isplunder( scriptablename ) )
        {
            cacheindex = "cash";
            plundername = br_plunder::getplundernamebyamount( newcount );
            
            if ( plundername != scriptablename )
            {
                scriptablename = plundername;
            }
        }
        
        newent = spawnpickup( scriptablename, dropinfo, newcount, 1, weaponobj, 0, var_9df9349d7d54802f, var_50967f0dd9b8b68e );
        
        if ( isent( self ) && isplayer( self ) )
        {
            br_analytics::branalytics_lootdrop( self, scriptablename, undefined, itemcount );
        }
        
        if ( isdefined( weaponobj ) )
        {
            level.onweapondropcreated callback_group::callback_trigger( newent, self, weaponobj );
        }
        
        soundname = scriptablename;
        
        if ( isplunder( scriptablename ) )
        {
            soundname = br_plunder::getplundernamebyamount( newcount );
            
            if ( var_51688298211c94eb )
            {
                newent.var_7971994d2364af58 = 1;
            }
        }
        
        if ( isdefined( itemtype ) )
        {
            quickdropplaysound( itemtype, oldorigin, soundname, newent );
        }
        
        self.quickdropcache[ cacheindex ].ent = newent;
        thread quickdropcleanupcache();
        pickups::deregisterscriptableinstance( oldent );
        
        if ( isent( oldent ) )
        {
            oldent delete();
        }
        else
        {
            oldent freescriptable();
        }
        
        return true;
    }
    
    return false;
}

// Namespace br_pickups
// Params 9
// Checksum 0x43d385c, Offset: 0xf5de
// Size: 0x363
function quickdropnewitem( itemtype, scriptablename, itemcount, itemcountlefthand, itemcountalt, weaponobj, weaponmetadata, overridedist, overrideorigin )
{
    var_48757da99828d5d8 = quickdropaddtoexisting( itemtype, scriptablename, itemcount, itemcountlefthand, itemcountalt, weaponobj );
    
    if ( var_48757da99828d5d8 )
    {
        return;
    }
    
    slot = function_ef8a0f215f5f8b92();
    thread function_dc6f8ce37163a81();
    dropstruct = pickups::function_f71dd588dc4f6288();
    dropstruct.dropidx = slot;
    dropinfo = pickups::getitemdroporiginandangles( dropstruct, self.origin, self.angles, self, undefined, overridedist, undefined, undefined, overrideorigin );
    newent = undefined;
    ismissionweapon = br_extract_quest::extract_ismissionweapon( weaponobj );
    
    if ( !ismissionweapon )
    {
        newent = spawnpickup( scriptablename, dropinfo, itemcount, 1, weaponobj, 0, itemcountlefthand, itemcountalt );
        utility::callsharedfunc( scriptablename, #"dropped", newent, self, dropinfo.origin );
        talking_gun::function_2417dd5f3232aaf4( newent, weaponobj );
        quickdropaddtocache( scriptablename, slot, newent, dropinfo.origin, dropinfo.angles );
        br_analytics::branalytics_lootdrop( self, scriptablename, undefined, itemcount );
        
        if ( isdefined( weaponobj ) )
        {
            level.onweapondropcreated callback_group::callback_trigger( newent, self, weaponobj );
            
            if ( level.var_5d84ba48f578e7f8 && getdvarint( @"hash_752eeed3ddcbd04b", 0 ) == 0 )
            {
                ammotype = br_weapons::br_ammo_type_for_weapon( weaponobj );
                
                if ( self.br_ammo[ ammotype ] > 0 )
                {
                    var_566a503a3488a1e6 = getdvarint( @"hash_3c4edd0a748e4053", 1 );
                    dirvec = dropinfo.origin - self.origin;
                    upvec = anglestoup( dropinfo.angles );
                    var_c7fcef85c6fd9faf = vectorcross( vectornormalize( dirvec ), upvec );
                    var_c7fcef85c6fd9faf = rotatepointaroundvector( upvec, var_c7fcef85c6fd9faf, getdvarint( @"hash_51cb230bbd599b71", 20 ) );
                    var_16244add81e2345e = dropinfo.origin + var_c7fcef85c6fd9faf * getdvarint( @"hash_16e74796df75b8d0", 20 );
                    ammodropstruct = pickups::function_f71dd588dc4f6288();
                    dropinfo = pickups::getitemdroporiginandangles( ammodropstruct, self.origin, self.angles, self, undefined, undefined, undefined, undefined, var_16244add81e2345e );
                    ammopickup = spawnpickup( ammotype, dropinfo, self.br_ammo[ ammotype ], 1, undefined, var_566a503a3488a1e6 );
                }
            }
        }
        
        if ( isdefined( weaponmetadata ) )
        {
            newent.metadata = weaponmetadata;
        }
    }
    
    if ( isplunder( scriptablename ) )
    {
        newent.var_7971994d2364af58 = 1;
        newent.lastowner = self;
        scriptablename = br_plunder::getplundernamebyamount( itemcount );
    }
    
    if ( function_1f87e4642e088efd( scriptablename ) )
    {
        if ( utility::issharedfuncdefined( #"hash_8538e247e32e58b9", #"hash_f68dee5c61e4c6af" ) )
        {
            level thread [[ utility::getsharedfunc( #"hash_8538e247e32e58b9", #"hash_f68dee5c61e4c6af" ) ]]( scriptablename, self );
        }
    }
    
    quickdropplaysound( itemtype, dropinfo.origin, scriptablename, newent, weaponobj );
    return newent;
}

// Namespace br_pickups
// Params 1
// Checksum 0x89916bc0, Offset: 0xf94a
// Size: 0xf5
function function_d292cd24cf16d9b0( instance )
{
    if ( !( isdefined( self ) && isdefined( instance.lastowner ) ) || self == instance.lastowner || self.team != instance.lastowner.team )
    {
        return;
    }
    
    if ( !isdefined( self.var_d387ddcd9f0d8285 ) )
    {
        self.var_d387ddcd9f0d8285 = 0;
    }
    
    if ( !isdefined( instance.lastowner.var_d387ddcd9f0d8285 ) )
    {
        instance.lastowner.var_d387ddcd9f0d8285 = 0;
    }
    
    self.var_d387ddcd9f0d8285 += instance.count;
    instance.lastowner.var_d387ddcd9f0d8285 = max( instance.lastowner.var_d387ddcd9f0d8285 - instance.count, 0 );
}

// Namespace br_pickups
// Params 3
// Checksum 0x6efd83d1, Offset: 0xfa47
// Size: 0x4f
function quickdropitem( itemtype, itemindex, dontspawnitem )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    function_fa47dd9cf7f6fbce( itemtype, itemindex, 0, dontspawnitem );
}

// Namespace br_pickups
// Params 3
// Checksum 0xc9751395, Offset: 0xfa9e
// Size: 0x50
function quickdropall( itemtype, itemindex, dontspawnitem )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    function_fa47dd9cf7f6fbce( itemtype, itemindex, 1, dontspawnitem );
}

// Namespace br_pickups
// Params 1
// Checksum 0xeb8e86bf, Offset: 0xfaf6
// Size: 0xb7
function equipbackpackitem( itemslotindex )
{
    level endon( #"game_ended" );
    [ lootid, quantity ] = br_default_inventory::function_c022fc696a9c0db2( itemslotindex );
    itemref = loot::function_f54ecb89dfab8e8c( lootid );
    
    if ( function_fe0521864025d97e( itemref ) )
    {
        function_7fb3c614c601ddef( lootid, quantity, itemref, itemslotindex );
        return;
    }
    
    if ( !isdefined( itemref ) || isdefined( itemref ) && !br_public::isammo( itemref ) )
    {
        self.var_42547f1bd3ea0117[ itemslotindex ] = 1;
        equipitem( lootid, quantity, itemslotindex, undefined, 1 );
        self.var_42547f1bd3ea0117[ itemslotindex ] = undefined;
    }
}

// Namespace br_pickups
// Params 4
// Checksum 0xef053317, Offset: 0xfbb5
// Size: 0x6c
function function_7fb3c614c601ddef( lootid, quantity, itemref, itemslotindex )
{
    if ( itemref == "brloot_nvg" )
    {
        function_609afc6949a526cc();
        return;
    }
    
    if ( itemref == "brloot_disguise" )
    {
        if ( !disguise::function_bc13e7208281eb0c() )
        {
            disguise::disguise_used( itemref, undefined, undefined, undefined, "iw9_vm_ges_disguise_on" );
            return;
        }
        
        disguise::function_f7776d7012343e70();
    }
}

// Namespace br_pickups
// Params 0
// Checksum 0x87d3094f, Offset: 0xfc29
// Size: 0x2e
function function_609afc6949a526cc()
{
    ison = self isnightvisionon();
    
    if ( ison )
    {
        self nightvisionviewoff();
    }
    else
    {
        self nightvisionviewon();
    }
    
    thread nvg::nvg_monitor();
}

// Namespace br_pickups
// Params 4
// Checksum 0x79c7a9d9, Offset: 0xfc5f
// Size: 0x98
function function_58fb35e7414b9c05( lootid, quantity, itemref, itemslotindex )
{
    if ( itemref == "brloot_nvg" )
    {
        totalnvgs = br_default_inventory::gettotalitemcountinbag( lootid );
        
        if ( totalnvgs <= 1 )
        {
            if ( self isnightvisionon() )
            {
                self nightvisionviewoff();
            }
        }
        
        thread function_cea164908631bc34( lootid );
        return;
    }
    
    if ( itemref == "brloot_disguise" )
    {
        if ( disguise::function_bc13e7208281eb0c() )
        {
            if ( disguise::function_ef201423b6658dfa() )
            {
                thread function_cc917887aa974790( lootid );
                return;
            }
            
            disguise::function_f7776d7012343e70();
        }
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0xeba27ba7, Offset: 0xfcff
// Size: 0x6a
function function_cc917887aa974790( lootid )
{
    self notify( #"hash_1c87886c19d9bf1" );
    level endon( #"game_ended" );
    self endon( #"hash_1c87886c19d9bf1" );
    self endon( #"disconnect" );
    
    while ( disguise::function_ef201423b6658dfa() )
    {
        waitframe();
    }
    
    hasdisguise = br_default_inventory::function_511e6d4f61a60220( lootid );
    
    if ( hasdisguise )
    {
        return;
    }
    
    disguise::function_f7776d7012343e70();
}

// Namespace br_pickups
// Params 1
// Checksum 0xe11c56d2, Offset: 0xfd71
// Size: 0x6e
function function_cea164908631bc34( lootid )
{
    self notify( #"hash_e0d024a7f5074ac5" );
    level endon( #"game_ended" );
    self endon( #"hash_e0d024a7f5074ac5" );
    self endon( #"disconnect" );
    self endon( #"night_vision_off" );
    wait 1;
    hasnvg = br_default_inventory::function_511e6d4f61a60220( lootid );
    
    if ( hasnvg )
    {
        return;
    }
    
    self nightvisionviewoff();
}

// Namespace br_pickups
// Params 1
// Checksum 0x94c0f6e2, Offset: 0xfde7
// Size: 0x48
function function_fe0521864025d97e( itemref )
{
    if ( !isdefined( itemref ) )
    {
        return 0;
    }
    
    switch ( itemref )
    {
        case #"hash_5fd271e568cc2313":
        case #"hash_c6fbab1b754d4731":
            return 1;
        default:
            return 0;
    }
}

// Namespace br_pickups
// Params 11
// Checksum 0x2ba14922, Offset: 0xfe37
// Size: 0x181, Type: bool
function equipweapon( weaponobj, quantity, itemslotindex, countalt, backpackequip, weaponstowed, metadata, overridedist, overrideorigin, pastteam, var_aa5019a51b0e7f29 )
{
    proxypickup = spawnstruct();
    scriptablename = undefined;
    
    if ( isdefined( weaponobj ) )
    {
        fullweapon = getcompleteweaponname( weaponobj );
        
        if ( isdefined( level.br_pickups.var_14163aac44e08274[ fullweapon ] ) )
        {
            scriptablename = level.br_pickups.var_14163aac44e08274[ fullweapon ];
        }
    }
    
    proxypickup.scriptablename = scriptablename ?? "brloot_weapon_generic_pi";
    proxypickup.origin = overrideorigin ?? self.origin;
    proxypickup.count = quantity;
    proxypickup.weapon = weaponobj;
    proxypickup.countlefthand = var_aa5019a51b0e7f29;
    proxypickup.countalt = countalt;
    proxypickup.metadata = metadata;
    proxypickup.overridedist = overridedist;
    proxypickup.pastteam = pastteam;
    proxypickup.var_fbb504183990fc9f = istrue( backpackequip );
    onusecompleted( proxypickup, undefined, 1, 0, itemslotindex, undefined, backpackequip, 0, weaponstowed );
    return true;
}

// Namespace br_pickups
// Params 1
// Checksum 0x1cdd1f83, Offset: 0xffc1
// Size: 0xd6, Type: bool
function function_95c43ecec7788235( lootref )
{
    player = self;
    
    if ( !isbrgamemode() || !getdvarint( @"hash_1f9797aa5675c82a", 1 ) )
    {
        return false;
    }
    
    lootid = loot::getlootidfromref( lootref );
    var_b2b8e5af55214aee = player br_default_inventory::function_8ca9685ec86d37c1( [ lootid ] );
    
    if ( var_b2b8e5af55214aee.size > 0 )
    {
        player equipbackpackitem( var_b2b8e5af55214aee[ 0 ] );
        return true;
    }
    
    if ( level.br_pickups.var_7fdcf8b33e641813 && arraycontains( level.br_pickups.br_killstreakreference, lootref ) )
    {
        var_f4d10c03f5a8709c = player br_default_inventory::function_6cf02ae6b5f10a23();
        
        if ( var_f4d10c03f5a8709c.size > 0 )
        {
            player equipbackpackitem( var_f4d10c03f5a8709c[ 0 ] );
            return true;
        }
    }
    
    return false;
}

// Namespace br_pickups
// Params 8
// Checksum 0xc16b2ff3, Offset: 0x100a0
// Size: 0x301
function equipitem( lootid, quantity, itemslotindex, countalt, backpackequip, weaponstowed, overridedist, overrideorigin )
{
    scriptablename = loot::getScriptableFromLootID( lootid );
    
    if ( !isdefined( scriptablename ) )
    {
        return;
    }
    
    if ( issuperpickup( scriptablename ) )
    {
        if ( supers_mp::issuperinuse() || supers_mp::function_ec7e2ab9a462557b() )
        {
            currentsuper = supers_mp::getcurrentsuper();
            statement = isdefined( currentsuper ) && isdefined( currentsuper.staticdata ) && isdefined( currentsuper.staticdata.ref );
            ref = "";
            
            if ( statement )
            {
                ref = currentsuper.staticdata.ref;
            }
            
            if ( ref != "super_stimpistol" && ref != "super_oxygen_mask" )
            {
                if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
                {
                    self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"mp/supers_unavailable_equip" );
                }
                
                return;
            }
            else
            {
                supers_mp::switchandtakesuperuseweapon();
            }
        }
        
        if ( isdefined( self.equipment[ "super" ] ) )
        {
            var_dc57d30a234ba2f7 = function_f02c63b99c9614c9( level.br_pickups.br_equipname, self.equipment[ "super" ] );
            
            if ( var_dc57d30a234ba2f7 == scriptablename )
            {
                if ( equipment_mp::getequipmentammo( self.equipment[ "super" ] ) != 0 )
                {
                    hud_message::showerrormessage( level.br_pickups.var_5f77ceb1af5872cc );
                    return;
                }
            }
        }
    }
    
    proxypickup = spawnstruct();
    proxypickup.scriptablename = scriptablename;
    proxypickup.origin = overrideorigin ?? self.origin;
    proxypickup.count = quantity;
    proxypickup.maxcount = level.br_pickups.maxcounts[ scriptablename ];
    proxypickup.stackable = level.br_pickups.stackable[ scriptablename ];
    
    if ( isdefined( countalt ) )
    {
        proxypickup.countalt = countalt;
    }
    
    proxypickup.countlefthand = 0;
    proxypickup.var_fbb504183990fc9f = istrue( backpackequip );
    
    if ( isdefined( overridedist ) )
    {
        proxypickup.overridedist = overridedist;
    }
    
    if ( iskillstreak( scriptablename ) || issuperpickup( scriptablename ) && !function_3d06a36003e339e4( scriptablename ) )
    {
        proxypickup.count = 1;
    }
    
    var_96dad37e611cf966 = undefined;
    
    if ( isgascan( scriptablename ) )
    {
        var_96dad37e611cf966 = 1;
    }
    
    return onusecompleted( proxypickup, undefined, 1, 0, itemslotindex, undefined, backpackequip, var_96dad37e611cf966, weaponstowed );
}

// Namespace br_pickups
// Params 11
// Checksum 0x15ca606b, Offset: 0x103aa
// Size: 0x21c
function lootitem( lootid, quantity, weaponref, var_b8b2f39fcba6d824, forcebackpack, var_fbb504183990fc9f, overridedist, overrideorigin, autopickup, var_df78d4a492ecf0a6, var_b897713b180977f8 )
{
    scriptablename = weaponref;
    
    if ( !isdefined( weaponref ) )
    {
        scriptablename = loot::getScriptableFromLootID( lootid );
    }
    
    proxypickup = spawnstruct();
    proxypickup.scriptablename = scriptablename;
    proxypickup.origin = overrideorigin ?? self.origin;
    proxypickup.maxcount = level.br_pickups.maxcounts[ scriptablename ];
    proxypickup.stackable = level.br_pickups.stackable[ scriptablename ];
    
    if ( pickups::isweaponpickupitem( proxypickup ) && common_inventory::function_7ec5937e3b3d86e0( scriptablename ) )
    {
        [ ammo, ammoleft, ammoalt ] = br_gametype_dmz::getdefaultweaponammo( level.br_lootiteminfo[ scriptablename ].fullweaponobj, 1 );
        proxypickup.count = ammo;
        proxypickup.countlefthand = ammoleft;
        proxypickup.countalt = ammoalt;
        proxypickup.var_df78d4a492ecf0a6 = var_df78d4a492ecf0a6;
    }
    else
    {
        proxypickup.count = quantity;
        proxypickup.countlefthand = 0;
        proxypickup.countalt = 0;
    }
    
    if ( isdefined( var_b8b2f39fcba6d824 ) )
    {
        proxypickup.var_b8b2f39fcba6d824 = var_b8b2f39fcba6d824;
    }
    
    if ( isdefined( var_fbb504183990fc9f ) )
    {
        proxypickup.var_fbb504183990fc9f = var_fbb504183990fc9f;
    }
    
    if ( isdefined( overridedist ) )
    {
        proxypickup.overridedist = overridedist;
    }
    
    return function_5b180b03ffe1dd26( proxypickup, "visible", self, autopickup, undefined, undefined, forcebackpack, var_b897713b180977f8 );
}

// Namespace br_pickups
// Params 2
// Checksum 0x495d9c4c, Offset: 0x105cf
// Size: 0x46
function registeruniquelootcallback( var_31c6325f16cd0bf4, callback )
{
    while ( !isdefined( level.br_pickups ) )
    {
        waitframe();
    }
    
    level.br_pickups.uniquelootcallbacks[ "uniqueLootItem_" + var_31c6325f16cd0bf4 ] = callback;
}

// Namespace br_pickups
// Params 2
// Checksum 0x6dd3de48, Offset: 0x1061d
// Size: 0x43
function processuniquelootitem( uniquelootitemid, player )
{
    if ( isdefined( [[ level.br_pickups.uniquelootcallbacks[ uniquelootitemid ] ]]( player ) ) )
    {
        return;
    }
    
    assertmsg( "<dev string:x3ac>" );
}

// Namespace br_pickups
// Params 0
// Checksum 0x9e702ca4, Offset: 0x10668
// Size: 0x17
function manageminigunpickup()
{
    thread watchaddminigunrestrictions();
    thread watchremoveminigunrestrictions();
    thread watchminigunweapon();
}

// Namespace br_pickups
// Params 0
// Checksum 0xb7142e5c, Offset: 0x10687
// Size: 0x83
function applyminigunrestrictions()
{
    self.playerstreakspeedscale = juggernaut::jugg_getmovespeedscalar();
    
    if ( !common::function_8ff835bf23198a0( "playerStreakSpeedScale" ) )
    {
        common::function_ac4bf3256b2545e3( "playerStreakSpeedScale", self.playerstreakspeedscale );
        common::function_a6a0ecdb12c8e351( 2 );
    }
    
    weapons::updatemovespeedscale();
    val::group_set( "fakeJugg", 0 );
    
    if ( !level.disablemount )
    {
        val::set( "fakeJugg", "mount_top", 0 );
        val::set( "fakeJugg", "mount_side", 0 );
    }
}

// Namespace br_pickups
// Params 0
// Checksum 0xccd6092a, Offset: 0x10712
// Size: 0x42
function removeminigunrestrictions()
{
    self.playerstreakspeedscale = undefined;
    
    if ( common::function_8ff835bf23198a0( "playerStreakSpeedScale" ) )
    {
        common::function_d85a92c557ea5a52( "playerStreakSpeedScale" );
        common::function_65276d8c156b2ec9( 2 );
    }
    
    weapons::updatemovespeedscale();
    val::group_reset( "fakeJugg" );
}

// Namespace br_pickups
// Params 0
// Checksum 0x9093627e, Offset: 0x1075c
// Size: 0x4e
function watchaddminigunrestrictions()
{
    self endon( #"death_or_disconnect" );
    self endon( #"dropped_minigun" );
    self endon( #"juggernaut_start" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"hash_6fe79eaa8f91054" );
        applyminigunrestrictions();
    }
}

// Namespace br_pickups
// Params 0
// Checksum 0xebacd42, Offset: 0x107b2
// Size: 0x65
function watchremoveminigunrestrictions()
{
    self endon( #"death_or_disconnect" );
    self endon( #"juggernaut_start" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        result = utility::waittill_any_return_no_endon_death( "switched_from_minigun", "dropped_minigun" );
        
        if ( isdefined( result ) )
        {
            removeminigunrestrictions();
            
            if ( result == "dropped_minigun" )
            {
                break;
            }
        }
    }
}

// Namespace br_pickups
// Params 0
// Checksum 0xbb400e3c, Offset: 0x1081f
// Size: 0x84
function watchminigunweapon()
{
    self endon( #"death_or_disconnect" );
    self endon( #"dropped_minigun" );
    self endon( #"juggernaut_start" );
    level endon( #"game_ended" );
    var_4274e5112a999f74 = 0;
    
    while ( true )
    {
        if ( !weapon::isminigunweapon( self getcurrentweapon() ) )
        {
            if ( var_4274e5112a999f74 )
            {
                var_4274e5112a999f74 = 0;
                self notify( #"switched_from_minigun" );
            }
        }
        else if ( !var_4274e5112a999f74 )
        {
            var_4274e5112a999f74 = 1;
            self notify( #"hash_6fe79eaa8f91054" );
        }
        
        waitframe();
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0x8eaa91f8, Offset: 0x108ab
// Size: 0x57a
function function_b82b55355bb1c31f( lootname )
{
    maxcount = level.br_pickups.var_3444316dc55e4b0a[ lootname ];
    
    if ( !isdefined( maxcount ) || maxcount == 0 )
    {
        maxcount = level.br_pickups.maxcounts[ lootname ];
    }
    
    if ( !isdefined( maxcount ) )
    {
        script::demoforcesre( "[IW9-672783]: maxCount undefined with lootName: " + lootname );
    }
    
    lootid = loot::function_d3e3bcaea591a6a2( lootname );
    
    if ( maxcount > 0 && isdefined( lootid ) )
    {
        for ( i = 0; i < common_inventory::function_9cd65c8312048802() ; i++ )
        {
            currentlootid = common_inventory::inventory_getlootidatbackpackindex( i );
            
            if ( currentlootid == lootid )
            {
                slotquantity = br_default_inventory::getquantityatbackpackindex( i );
                
                if ( slotquantity < maxcount )
                {
                    return 1;
                }
            }
        }
    }
    
    if ( br_public::isammo( lootname ) )
    {
        if ( !getdvarint( @"hash_752eeed3ddcbd04b", 0 ) )
        {
            allweaps = self getweaponslistprimaries();
            
            foreach ( weap in allweaps )
            {
                ammotypecomparison = br_weapons::br_ammo_type_for_weapon( weap );
                
                if ( lootname == ammotypecomparison )
                {
                    if ( getdvarint( @"hash_b5db5ff4b3f9e052", 0 ) )
                    {
                        return 1;
                    }
                    
                    var_750c0ab8ec53f515 = self.br_ammo[ lootname ] < level.br_ammo_max_stock[ lootname ];
                    
                    if ( getdvarint( @"hash_d116b9023292a13e", 1 ) )
                    {
                        return ( !br_default_inventory::function_8200c6fadac262d4( lootname ) || var_750c0ab8ec53f515 );
                    }
                    
                    return var_750c0ab8ec53f515;
                }
            }
            
            if ( br_default_inventory::function_787d2ebb0cc2e86f( self ) )
            {
                playerdataweapon = br_default_inventory::function_3b4976a12ea5037b( self );
                ammotype = br_weapons::br_ammo_type_for_weapon( playerdataweapon );
                
                if ( ammotype == lootname )
                {
                    if ( getdvarint( @"hash_b5db5ff4b3f9e052", 0 ) )
                    {
                        return 1;
                    }
                    
                    var_750c0ab8ec53f515 = self.br_ammo[ lootname ] < level.br_ammo_max_stock[ lootname ];
                    
                    if ( getdvarint( @"hash_d116b9023292a13e", 1 ) )
                    {
                        return ( !br_default_inventory::function_8200c6fadac262d4( lootname ) || var_750c0ab8ec53f515 );
                    }
                    
                    return var_750c0ab8ec53f515;
                }
            }
            
            return 0;
        }
        else
        {
            return 1;
        }
    }
    
    if ( isplunder( lootname ) )
    {
        return 1;
    }
    
    if ( function_18c9ebe68283fe1c( lootname ) )
    {
        return 1;
    }
    
    if ( pickups::isweaponpickup( lootname ) && self isautograbweaponsenabled() )
    {
        return 1;
    }
    
    if ( br_public::isarmorplate( lootname ) )
    {
        equipname = level.br_pickups.br_equipname[ lootname ];
        slot = level.equipment.table[ equipname ].defaultslot;
        
        if ( !isdefined( self.equipment[ slot ] ) )
        {
            return 1;
        }
        
        if ( equipmentslothasroom( lootname, slot ) )
        {
            return 1;
        }
        
        if ( getdvarint( @"hash_26fdfbd6bcbe5f42", 1 ) && br_default_inventory::isbackpackinventoryenabled() )
        {
            if ( level.var_5e11761a0e34cdc5 != -1 )
            {
                if ( function_c4311096810e3207( lootname, level.var_5e11761a0e34cdc5 ) )
                {
                    return 1;
                }
            }
            else
            {
                return 1;
            }
        }
        
        if ( lootname == "br_armor_plate" && isdefined( self.perks[ "specialty_fast_armor" ] ) )
        {
            if ( self.armorhealth <= self.maxarmorhealth - self.maxhealth )
            {
                return 1;
            }
        }
        
        return 0;
    }
    
    if ( isgametypeitem( lootname ) && utility::issharedfuncdefined( #"gametype", #"hash_ebc45fd32e3dcae7" ) )
    {
        return utility::callsharedfunc( #"gametype", #"hash_ebc45fd32e3dcae7", lootname, self );
    }
    
    if ( function_7019629f2a3b016c( lootname ) && !getdvarint( @"hash_752eeed3ddcbd04b", 0 ) )
    {
        equipname = level.br_pickups.br_equipname[ lootname ];
        slot = level.equipment.table[ equipname ].defaultslot;
        return ( pickupissameasequipmentslot( equipname, slot ) && equipmentslothasroom( lootname, slot ) );
    }
    
    if ( function_a1f9f8123c01bb3b( lootname ) && !getdvarint( @"hash_752eeed3ddcbd04b", 0 ) )
    {
        equipname = level.br_pickups.br_equipname[ lootname ];
        slot = level.equipment.table[ equipname ].defaultslot;
        return ( pickupissameasequipmentslot( equipname, slot ) && equipmentslothasroom( lootname, slot ) );
    }
    
    if ( getdvarint( @"hash_752eeed3ddcbd04b", 0 ) )
    {
        var_882118f217b10a45 = 0;
        
        if ( function_7019629f2a3b016c( lootname ) )
        {
            var_882118f217b10a45 = self function_abeab80c50527884() == 1;
        }
        else if ( function_a1f9f8123c01bb3b( lootname ) )
        {
            var_882118f217b10a45 = self function_eb443e0f012a8511() == 1;
        }
        else if ( iskillstreak( lootname ) )
        {
            var_882118f217b10a45 = self function_8eb82c3bbafeb4e9() == 1;
        }
        else if ( issuperpickup( lootname ) )
        {
            var_882118f217b10a45 = self function_1f13c2eb85124adb() == 1;
        }
        else if ( isrevivepickup( lootname ) )
        {
            var_882118f217b10a45 = self function_1610db0bafb9fdef() == 1;
        }
        else if ( isgasmask( lootname ) )
        {
            var_882118f217b10a45 = self function_8ae0100702399ac3() == 1;
        }
        
        return var_882118f217b10a45;
    }
    
    return 0;
}

// Namespace br_pickups
// Params 1
// Checksum 0xbd3163b3, Offset: 0x10e2e
// Size: 0x14, Type: bool
function function_49be4ae122d13f2e( lootname )
{
    return lootname == "brloot_dead_agent_radio";
}

// Namespace br_pickups
// Params 1
// Checksum 0x1942502b, Offset: 0x10e4b
// Size: 0x3a, Type: bool
function function_cfce107ef35a347e( lootname )
{
    return isdefined( lootname ) && !issubstr( lootname, "brloot_backpack_player" ) && lootname != "brloot_backpack" && issubstr( lootname, "brloot_backpack" );
}

// Namespace br_pickups
// Params 1
// Checksum 0x544a5fc, Offset: 0x10e8e
// Size: 0x17
function isperkpack( lootname )
{
    return issubstr( lootname, "brloot_perkpack" );
}

// Namespace br_pickups
// Params 1
// Checksum 0x6be7eef9, Offset: 0x10eae
// Size: 0x17
function function_d39ca17df2c672e8( lootname )
{
    return issubstr( lootname, "jup_exgm_force_recon_" );
}

// Namespace br_pickups
// Params 1
// Checksum 0x8ebd5ee8, Offset: 0x10ece
// Size: 0x17
function iseventcard( lootname )
{
    return issubstr( lootname, "brloot_underground_keycard_" );
}

// Namespace br_pickups
// Params 1
// Checksum 0xdaf1e111, Offset: 0x10eee
// Size: 0x14, Type: bool
function function_18c9ebe68283fe1c( lootname )
{
    return lootname == "brloot_scavenger_bag";
}

// Namespace br_pickups
// Params 2
// Checksum 0x80def62e, Offset: 0x10f0b
// Size: 0x31a
function function_7746e3e9ecf31195( pickup, weaponobj )
{
    if ( player::isplayerads() || getdvarint( @"hash_9fc90311ef111afd", 0 ) && player::isincombat() )
    {
        return 0;
    }
    
    if ( self.insertingarmorplate )
    {
        return 0;
    }
    
    var_9ae0005e5a4b0f86 = getdvarint( @"hash_ef63562e5f3b14d0", 0 );
    currenttime = gettime();
    var_7746e3e9ecf31195 = !isdefined( self.var_6a41bd6cabbd5185 ) || currenttime - self.var_6a41bd6cabbd5185 > var_9ae0005e5a4b0f86;
    
    if ( var_7746e3e9ecf31195 && self function_895629dc2757d1a8() )
    {
        var_7746e3e9ecf31195 = !function_25277b7be782b566( weaponobj );
    }
    
    if ( var_7746e3e9ecf31195 )
    {
        if ( self function_cd13a7d9389fc669() )
        {
            primaryweaponscount = self.primaryweapons.size;
            var_b8b41ef31be353f6 = 2 > primaryweaponscount;
            
            for ( i = 0; !var_b8b41ef31be353f6 && i < self.primaryweapons.size ; i++ )
            {
                if ( isnullweapon( self.primaryweapons[ i ] ) || weapon::isfistweapon( self.primaryweapons[ i ] ) || !function_70f78bd49af0a1e2( i ) && function_25277b7be782b566( self.primaryweapons[ i ] ) )
                {
                    primaryweaponscount--;
                    var_b8b41ef31be353f6 = 2 > primaryweaponscount;
                }
            }
            
            var_7746e3e9ecf31195 = var_b8b41ef31be353f6;
        }
        else if ( self function_ff17c4599c4c2a1c() )
        {
            if ( !isdefined( level.var_fc6e902332b6c551 ) )
            {
                function_a2cae8a7c9363e76();
            }
            
            var_d42c9da6fc3504f3 = level.var_fc6e902332b6c551[ weaponclass( weaponobj.basename ) ];
            var_db02f34dd4f721ee = self function_572ba997c08260a2( var_d42c9da6fc3504f3 );
            var_7746e3e9ecf31195 = 0;
            
            for ( i = 0; i < self.primaryweapons.size ; i++ )
            {
                primaryweaponobj = self.primaryweapons[ i ];
                
                if ( !isnullweapon( primaryweaponobj ) )
                {
                    if ( weapon::isfistweapon( primaryweaponobj ) )
                    {
                        var_7746e3e9ecf31195 = 1;
                        continue;
                    }
                    
                    var_9e8c74421f60ff37 = level.var_fc6e902332b6c551[ weaponclass( primaryweaponobj.basename ) ];
                    
                    if ( var_d42c9da6fc3504f3 == var_9e8c74421f60ff37 )
                    {
                        var_7746e3e9ecf31195 = 0;
                        break;
                    }
                    
                    if ( function_70f78bd49af0a1e2( i ) )
                    {
                        continue;
                    }
                    
                    weaponclasspriority = self function_572ba997c08260a2( var_9e8c74421f60ff37 );
                    
                    if ( weaponclasspriority < var_db02f34dd4f721ee )
                    {
                        var_7746e3e9ecf31195 = 1;
                    }
                }
            }
        }
    }
    
    if ( self function_bfe15f18944cd3d9() )
    {
        baseweaponname = weapon::getweaponrootname( weaponobj );
        var_e26d9f1bddd19e27 = 0;
        
        for ( i = 0; !var_e26d9f1bddd19e27 && i < self.primaryweapons.size ; i++ )
        {
            var_31aae3e924108b71 = weapon::getweaponrootname( self.primaryweapons[ i ] );
            
            if ( var_31aae3e924108b71 == baseweaponname )
            {
                playerweaponrarity = getweaponpickuprarity( self.primaryweapons[ i ] );
                var_a39d1e202dca141d = level.br_pickups.br_itemrarity[ pickup.scriptablename ];
                var_e26d9f1bddd19e27 = playerweaponrarity < var_a39d1e202dca141d;
            }
        }
        
        var_7746e3e9ecf31195 = var_e26d9f1bddd19e27;
    }
    
    return var_7746e3e9ecf31195;
}

// Namespace br_pickups
// Params 1
// Checksum 0x254c99a1, Offset: 0x1122e
// Size: 0xef
function function_25277b7be782b566( weapon )
{
    var_25277b7be782b566 = 0;
    
    if ( isdefined( level.br_standard_loadout ) )
    {
        if ( !isdefined( level.var_f6580548b0ea50af ) )
        {
            function_280a908dccbfb380();
        }
        
        foreach ( var_64cecf84ada5fb08 in level.var_f6580548b0ea50af )
        {
            var_25277b7be782b566 = issameweapon( weapon, var_64cecf84ada5fb08 );
            
            if ( var_25277b7be782b566 )
            {
                break;
            }
        }
    }
    
    if ( !var_25277b7be782b566 && isdefined( self.gulag ) )
    {
        if ( !isdefined( level.var_676d872087fa8b61 ) )
        {
            function_5deb3a9e5c2a953f();
        }
        
        var_25277b7be782b566 = function_c0483cdb17f0e32d( weapon );
    }
    
    return var_25277b7be782b566;
}

// Namespace br_pickups
// Params 1
// Checksum 0x8a20117e, Offset: 0x11326
// Size: 0x7d
function getweaponpickuprarity( weaponobj )
{
    weaponrarity = 0;
    weaponfullname = getcompleteweaponname( weaponobj );
    
    if ( isdefined( level.br_pickups.br_weapontoscriptable[ weaponfullname ] ) )
    {
        scriptabledefname = level.br_pickups.br_weapontoscriptable[ weaponfullname ];
        weaponrarity = level.br_pickups.br_itemrarity[ scriptabledefname ];
    }
    
    return weaponrarity;
}

// Namespace br_pickups
// Params 0
// Checksum 0xea925244, Offset: 0x113ac
// Size: 0x35
function function_42581a897f3ac410()
{
    self.weaponslotblocked = [];
    
    for ( i = 0; i < 2 ; i++ )
    {
        self.weaponslotblocked[ i ] = 0;
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0x67123829, Offset: 0x113e9
// Size: 0x58
function function_70f78bd49af0a1e2( slotindex )
{
    slotblocked = 0;
    
    if ( getdvarint( @"hash_218b826f84233424", 0 ) )
    {
        if ( !isdefined( self.weaponslotblocked ) )
        {
            function_42581a897f3ac410();
        }
        
        slotblocked = slotindex < 2 && self.weaponslotblocked[ slotindex ];
    }
    
    return slotblocked;
}

// Namespace br_pickups
// Params 2
// Checksum 0xefabc6fe, Offset: 0x1144a
// Size: 0x83
function function_bea188db0e770fda( weaponobj, blocked )
{
    if ( !isdefined( self.weaponslotblocked ) )
    {
        function_42581a897f3ac410();
    }
    
    weaponcount = min( 2, self.primaryweapons.size );
    
    for ( i = 0; i < weaponcount ; i++ )
    {
        if ( issameweapon( self.primaryweapons[ i ], weaponobj ) )
        {
            self.weaponslotblocked[ i ] = blocked;
            break;
        }
    }
}

// Namespace br_pickups
// Params 3
// Checksum 0x1e72eaae, Offset: 0x114d5
// Size: 0x1b0
function function_402de4642e0ec93c( player, scriptablename, var_6323cfe1d6f4585a )
{
    platelevel = br_public::function_f7d29d5dab587ae1( scriptablename );
    
    if ( level.var_dd8633765c6a1db9 )
    {
        player setplayerdata( level.var_6f9b00680ed002d8, "dmzPlateCarrierLevel", platelevel );
    }
    
    if ( armor::function_52bd24d06ec049d7() )
    {
        function_839b6d3a34503680( player, scriptablename );
        var_d3ae4cece27f98df = player function_d5543139aa83ded0( scriptablename );
        
        if ( var_d3ae4cece27f98df > 0 )
        {
            dropstruct = pickups::function_f71dd588dc4f6288();
            player dropbrequipment( dropstruct, 0, 1, level.armorref ?? "equip_armorplate", var_d3ae4cece27f98df );
        }
        
        player armor::function_164c824617d7e8d7( 0 );
    }
    
    if ( isdefined( scriptablename ) )
    {
        br_instance_inventory::function_f3867fdc89c40513( player, loot::function_d3e3bcaea591a6a2( scriptablename ) );
    }
    
    player.platecarriertype = scriptablename;
    
    if ( !var_6323cfe1d6f4585a )
    {
        player.platecarrierlevel = platelevel;
        player.maxarmorhealth = player armor::function_3988e68b87d5acc0() * 50;
        player notify( #"try_armor_cancel", "plate_carrier" );
        
        if ( !getdvarint( @"hash_43b4bf9a8ba6c500", 1 ) )
        {
            armor::setarmorhealth( player.maxarmorhealth );
        }
        else
        {
            armor::setarmorhealth( player.armorhealth );
            currentplates = player armor::function_22290101992e4874();
            
            if ( getdvarint( @"hash_e1ef460ef24e76e6", 0 ) && currentplates < player armor::function_3988e68b87d5acc0() && !player.var_e8651cd47e80ffd7 )
            {
                player armor::function_164c824617d7e8d7( player armor::function_3988e68b87d5acc0() - currentplates );
            }
        }
    }
    
    return platelevel;
}

// Namespace br_pickups
// Params 2
// Checksum 0x515c91f5, Offset: 0x1168e
// Size: 0x75
function function_839b6d3a34503680( player, scriptablename )
{
    newperkname = function_bc67eadf98fb969a( scriptablename );
    currentperkname = function_bc67eadf98fb969a( player.platecarriertype );
    
    if ( isdefined( currentperkname ) && isdefined( self.perks[ currentperkname ] ) )
    {
        player perk::removeperk( currentperkname );
    }
    
    if ( isdefined( newperkname ) )
    {
        player perk::giveperk( newperkname );
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0xc71c24fa, Offset: 0x1170b
// Size: 0xb0
function function_bc67eadf98fb969a( scriptablename )
{
    if ( !isdefined( scriptablename ) )
    {
        return;
    }
    
    perkname = undefined;
    
    if ( issubstr( scriptablename, "comms" ) )
    {
        perkname = "specialty_pc_comms";
    }
    else if ( issubstr( scriptablename, "medic" ) )
    {
        perkname = "specialty_pc_medic";
    }
    else if ( issubstr( scriptablename, "stealth" ) )
    {
        perkname = "specialty_pc_stealth";
    }
    else if ( issubstr( scriptablename, "tempered" ) )
    {
        perkname = "specialty_pc_tempered";
    }
    else if ( issubstr( scriptablename, "high_capacity" ) )
    {
        perkname = "specialty_pc_high_capacity";
    }
    else if ( issubstr( scriptablename, "cqc" ) )
    {
        perkname = "specialty_pc_close_quarter";
    }
    
    return perkname;
}

// Namespace br_pickups
// Params 1
// Checksum 0x46a17428, Offset: 0x117c4
// Size: 0x2f
function function_f315be762bc7a779( player )
{
    if ( level.var_dd8633765c6a1db9 )
    {
        player setplayerdata( level.var_6f9b00680ed002d8, "dmzPlateCarrierLevel", 1 );
    }
}

// Namespace br_pickups
// Params 1
// Checksum 0x734eaa4e, Offset: 0x117fb
// Size: 0xf5
function function_d5543139aa83ded0( scriptablename )
{
    currentplates = 0;
    
    foreach ( weapon in self.equippedweapons )
    {
        basename = weapon::getweaponrootname( weapon.basename );
        
        if ( basename == "armorplate" )
        {
            currentplates = self getweaponammoclip( weapon );
        }
    }
    
    maxplates = armor::function_bc6363e19ce42a9a();
    
    if ( isdefined( scriptablename ) )
    {
        if ( scriptablename == "brloot_plate_carrier_high_capacity" )
        {
            maxplates = 8;
        }
    }
    
    var_d3ae4cece27f98df = undefined;
    
    if ( currentplates > maxplates )
    {
        var_d3ae4cece27f98df = currentplates - maxplates;
    }
    
    return var_d3ae4cece27f98df;
}

// Namespace br_pickups
// Params 0
// Checksum 0x65b20807, Offset: 0x118f9
// Size: 0xb1, Type: bool
function function_62231ee4879586fd()
{
    if ( isbrgamemode() )
    {
        if ( !isdefined( self.platecarriertype ) )
        {
            return false;
        }
        
        var_772eddd8b833d7e5 = self.platecarrierlevel == 2;
        var_2a2f8926002cd74f = self.platecarriertype == "brloot_plate_carrier_3" ? 1 : 0;
        
        if ( var_772eddd8b833d7e5 || var_2a2f8926002cd74f )
        {
            return false;
        }
        
        return true;
    }
    
    if ( getdvarint( @"hash_62882304cc93ba77", 0 ) == 1 && self.platecarrierlevel == 2 || self.platecarrierlevel == 3 && getdvarint( @"scr_br_drop_three_carrier", 1 ) == 1 )
    {
        return true;
    }
    
    return false;
}

// Namespace br_pickups
// Params 0
// Checksum 0x55ccef9a, Offset: 0x119b3
// Size: 0x10
function function_9218c8b00d4e2c3b()
{
    return getdvarint( @"hash_8d79947a6199a378", 0 );
}

// Namespace br_pickups
// Params 1
// Checksum 0xaf4b20b9, Offset: 0x119cc
// Size: 0x66
function function_3afbdc742cdc709c( perk )
{
    perk::giveperk( perk );
    lootid = loot::getlootidfromref( perk );
    assert( isdefined( lootid ), "<dev string:x3e3>" + perk + "<dev string:x3f2>" );
    
    if ( !isdefined( lootid ) )
    {
        return;
    }
    
    view_origin = self getvieworigin();
    function_55de798ca5dc4080( lootid, view_origin, 1, 0 );
}

