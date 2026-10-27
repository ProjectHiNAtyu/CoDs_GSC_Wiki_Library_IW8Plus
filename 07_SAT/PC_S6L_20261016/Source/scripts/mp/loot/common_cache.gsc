// scripts\mp\loot\common_cache.gsc  (hash_5690feaa6b54a81f.gscc) (size: 62897 Bytes / 0xf5b1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8f295c01 (2401852417)
// size ...... 62897 (0xf5b1)
// includes .. 24  (offset: 0xe8dd)
// strings ... 75  (offset: 0xe99d)
// dev strs .. 128 (offset: 0xeead)
// exports ... 121 (offset: 0xa73d)
// cseg ...... 0x7d2 + 0x9f6b (0xa73d)
// imports ... 358 (offset: 0xba25)
// animtree1 . 0   (offset: 0xf5b1)
// animtree2 . 0   (offset: 0xf5b1)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\player;
#using scripts\mp\dmz\modified_values;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_inventory_groups;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_ammo;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\poi;

#namespace common_cache;

// Namespace common_cache
// Params 0, eflags: 0x5
// Checksum 0xc207e1f9, Offset: 0x7f0
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"common_cache", #"common_item", &init_cache, undefined );
}

// Namespace common_cache
// Params 0
// Checksum 0xd1986b95, Offset: 0x819
// Size: 0x3dc
function init_cache()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    var_e7859541f2f9ab42 = getdvarint( @"hash_340f31675ef2e702", level.gametypebundle.containerclosedist ?? 50 );
    var_580802f7a3cc2a0c = getdvarint( @"hash_adc3757de4a4f0b9", level.gametypebundle.var_89ff576311617bd ?? 10 );
    level.var_e7859541f2f9ab42 = var_e7859541f2f9ab42 * var_e7859541f2f9ab42;
    level.var_580802f7a3cc2a0c = var_580802f7a3cc2a0c * var_580802f7a3cc2a0c;
    level.var_6e24b391ac36b238 = getdvarint( @"hash_22ef27debe529bf8", 20 );
    level.var_6de02274b052182 = getdvarint( @"hash_819b6e8500e6044c", 4 );
    level.var_a7f8c522f4072f70 = getdvarint( @"hash_419fd2f09b23942a", !level.gametypebundle.var_971b58aea694f61a );
    level.var_dcb5008a07500f9 = getdvarint( @"hash_aea0716d0a0f790a", level.gametypebundle.var_e5bb2331d749e893 ?? 6 );
    level.var_9afcf1fa7009bc81 = getdvarint( @"hash_a9ec985d4616d593", 0 );
    level.var_f206f99829d42149 = level.gametypebundle.var_4fd93007abaadb37 ?? 0.5;
    level.var_49a28b27a1d6f4da = level.gametypebundle.var_59c7fc9bd1ea04f0 ?? 0.5;
    level.var_178d825f61c867d5 = level.gametypebundle.var_25ce34765e48d90b;
    
    if ( !isdefined( level.var_2005ea41919076c3 ) )
    {
        level.var_2005ea41919076c3 = [];
    }
    
    common_item::function_4b30c091d3b04a25( "cache" );
    common_item::function_84174b793b5fe9a7( "cache", #"use", &usecache );
    common_item::function_84174b793b5fe9a7( "cache", #"canautouse", &function_242273dd5bcb3090 );
    common_item::function_84174b793b5fe9a7( "cache", #"hash_9e49dfaa7c147654", &function_242273dd5bcb3090 );
    
    /#
        common_item::function_84174b793b5fe9a7( "<dev string:x24>", #"hash_3483a973fd1fe5b8", &function_ea1b7551b74eab4b );
    #/
    
    common_item::function_9c9e4c71569f3ae8( &function_e1edd53f20e103f );
    scriptable::scriptable_addusedcallback( &function_60ce579fa7d3b6da );
    scriptable::scriptable_addautousecallback( &function_60ce579fa7d3b6da );
    thread function_71044e7f34def746();
    utility::registersharedfunc( #"container", #"iscontainerempty", &iscontainerempty );
    utility::registersharedfunc( #"container", #"additem", &cache_additem );
    utility::registersharedfunc( #"container", #"getindexforlootidincontainer", &function_36e88ba6bc879452 );
    utility::registersharedfunc( #"container", #"getloadoutdoublebackpacklootid", undefined );
    utility::registersharedfunc( #"container", #"getlootidatcontainerindex", &function_8a794a103f67b684 );
    utility::registersharedfunc( #"container", #"openLootableContainer", &openlootablecontainer );
    utility::registersharedfunc( #"container", #"closelootablecontainer", &closelootablecontainer );
    utility::registersharedfunc( #"container", #"hash_b58b15d934036c28", &common_inventory_groups::function_dffd0ba870098fc5 );
    utility::registersharedfunc( #"container", #"hash_9f0af2a52b5ef107", &common_inventory_groups::function_93b951c93e339754 );
    utility::registersharedfunc( #"container", #"fillContentsFromList", &fillcontentsfromlist );
    utility::registersharedfunc( #"container", #"modifyplayerloottime", &modifyplayerloottime );
    
    if ( level.gamemodebundle.var_64dbdf394f723bd && function_4042d2fbe6237835( #"hash_849a265581d9f2a4" ) )
    {
        level.gamemodebundle.var_64dbdf394f723bd = 0;
    }
    
    /#
        thread setup_devgui();
        thread function_bf34e2ac498ad761();
        thread function_904414bc697b88f7();
    #/
}

/#

    // Namespace common_cache
    // Params 0, eflags: 0x4
    // Checksum 0x37afd4ba, Offset: 0xbfd
    // Size: 0x10a, Type: dev
    function private function_904414bc697b88f7()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_13bcef30805d7628", 0 ) == 1 )
            {
                params = [ "<dev string:x2a>" ];
                cache = debug_spawn_cache( params );
                
                foreach ( player in level.players )
                {
                    function_6e9defb713a31012( cache, player, [ %"hash_1da081d5da479d0d", %"hash_af04daac993128a", %"hash_4b5937f60cfa00b9" ] );
                }
                
                setdvar( @"hash_13bcef30805d7628", 0 );
            }
            
            wait 1;
        }
    }

#/

// Namespace common_cache
// Params 0, eflags: 0x4
// Checksum 0xbb6f58d8, Offset: 0xd0f
// Size: 0x3f
function private function_71044e7f34def746()
{
    level endon( #"game_ended" );
    
    while ( !utility::issharedfuncdefined( #"game", #"registeronluieventcallback" ) )
    {
        wait 1;
    }
    
    namespace_9d8e359c3b1041e5::registeronluieventcallbacksharedfunc( &function_f87c1c077b1be730 );
}

// Namespace common_cache
// Params 4, eflags: 0x4
// Checksum 0x60f18e7b, Offset: 0xd56
// Size: 0x32
function private usecache( itembundle, item, autouse, var_981c264073bf1154 )
{
    return item.count;
}

// Namespace common_cache
// Params 4, eflags: 0x4
// Checksum 0x62650196, Offset: 0xd91
// Size: 0x28, Type: bool
function private function_242273dd5bcb3090( itembundle, item, autouse, allowswap )
{
    return false;
}

// Namespace common_cache
// Params 1
// Checksum 0xec35e1b3, Offset: 0xdc2
// Size: 0x17
function function_2a790ff752bdb267( canbeusedfunction )
{
    level.var_618bf854186512c6 = canbeusedfunction;
}

// Namespace common_cache
// Params 1
// Checksum 0x222abad4, Offset: 0xde1
// Size: 0x17
function function_e35d5e97bd22367( overridefunction )
{
    self.var_ae5aacb4681e18e9 = overridefunction;
}

// Namespace common_cache
// Params 2
// Checksum 0x4f4272c3, Offset: 0xe00
// Size: 0x39
function function_8b2e367c183e89f6( subtype, callback )
{
    if ( !isdefined( level.var_2a312cd2f2e99e41 ) )
    {
        level.var_2a312cd2f2e99e41 = [];
    }
    
    level.var_2a312cd2f2e99e41[ subtype ] = callback;
}

// Namespace common_cache
// Params 1, eflags: 0x4
// Checksum 0x40df4a30, Offset: 0xe41
// Size: 0x18
function private function_15528cc7a19e6a89( subtype )
{
    return level.var_2a312cd2f2e99e41[ subtype ];
}

// Namespace common_cache
// Params 6
// Checksum 0xaf796b0d, Offset: 0xe62
// Size: 0x4e9
function function_60ce579fa7d3b6da( instance, part, state, player, bautouse, usestring )
{
    if ( !common_item::function_f107d23d5275a951( instance.type, "cache" ) )
    {
        return;
    }
    
    if ( player val::get( "disallow_cache_use" ) )
    {
        return 0;
    }
    
    if ( level.var_618bf854186512c6 && !player [[ level.var_618bf854186512c6 ]]( instance ) )
    {
        return;
    }
    
    if ( !level.var_9afcf1fa7009bc81 && player && player playerads() >= 0.5 )
    {
        return;
    }
    
    var_ae5aacb4681e18e9 = instance.var_ae5aacb4681e18e9 ?? instance.entity.var_ae5aacb4681e18e9;
    
    if ( isdefined( var_ae5aacb4681e18e9 ) )
    {
        [[ var_ae5aacb4681e18e9 ]]( instance, part, state, player, bautouse, usestring );
        return;
    }
    
    function_9d6321275c249932( instance );
    assert( part == "<dev string:x3e>" );
    
    if ( ( state == #"closed_usable" || state == #"closed_usable_no_collision" ) && !isdefined( instance.entity ) )
    {
        if ( instance getscriptableparthasstate( part, "partially_opening_unusable" ) )
        {
            instance setscriptablepartstate( part, "partially_opening_unusable" );
        }
        else if ( instance getscriptableparthasstate( part, "closed_to_fully_open_unusable" ) )
        {
            instance setscriptablepartstate( part, "closed_to_fully_open_unusable" );
        }
        else if ( instance getscriptableparthasstate( part, "fully_opening_unusable" ) )
        {
            instance setscriptablepartstate( part, "fully_opening_unusable" );
        }
        
        if ( isdefined( instance.var_6e39895e14c70e34 ) )
        {
            result = [[ instance.var_6e39895e14c70e34 ]]( instance, player );
            
            if ( isdefined( result ) )
            {
                if ( !result )
                {
                    return;
                }
            }
        }
        
        subtype = undefined;
        itembundlename = common_item::function_33a2c00e46263d99( instance );
        
        if ( isdefined( itembundlename ) )
        {
            subtype = getscriptbundlefieldvalue( itembundlename, "subtype" );
        }
        
        switch ( subtype )
        {
            case #"hash_dbd093aa8ad53b94":
                instance function_c893ef9b1e3d60e5( player );
                break;
            default:
                break;
        }
        
        var_7332216551d2f1c8 = function_15528cc7a19e6a89( subtype );
        
        if ( isdefined( var_7332216551d2f1c8 ) )
        {
            [[ var_7332216551d2f1c8 ]]( instance, player );
        }
        
        if ( !isdefined( instance.contents ) )
        {
            if ( isfunction( instance.var_e2bbc1702d7a3c00 ) )
            {
                itemnames = self [[ instance.var_e2bbc1702d7a3c00 ]]( instance );
            }
            else
            {
                itemnames = getscriptablelootcachecontents( instance );
            }
            
            if ( !isarray( itemnames ) && !instance.inventorygroup.var_e0bb9885a6ae0be0 )
            {
                assertmsg( "<dev string:x43>" + ( instance.classname ?? "<dev string:x93>" ) );
                return;
            }
            
            function_61ef9e0b74e10aaf( instance, itemnames );
            
            if ( !isdefined( instance.contents ) )
            {
                instance.contents = [];
            }
            
            if ( isdefined( itemnames ) )
            {
                function_a09e7cf5bad99b64( instance, itemnames, 1 );
                player callback::callback( #"lootCacheAddAdditionalLoot", { #cache:instance } );
                
                if ( isdefined( player.perks[ "specialty_trait_container_rare_loot" ] ) && isdefined( level.perkbundles[ "specialty_trait_container_rare_loot" ] ) && isdefined( level.perkbundles[ "specialty_trait_container_rare_loot" ].var_a2270f6a638ff53 ) )
                {
                    var_41090a8eb8560c6b = common_item::items_selectfromlist( level.perkbundles[ "specialty_trait_container_rare_loot" ].var_a2270f6a638ff53, 1 );
                    
                    if ( isdefined( var_41090a8eb8560c6b ) && var_41090a8eb8560c6b.size > 0 )
                    {
                        function_a09e7cf5bad99b64( instance, var_41090a8eb8560c6b, 1 );
                        
                        if ( instance.contents.size > 0 )
                        {
                            for ( i = instance.contents.size - 1; i >= 0 ; i-- )
                            {
                                if ( instance.contents[ i ].lootid > 0 && instance.contents[ i ].quantity > 0 )
                                {
                                    instance.contents[ i ].perkadded = 1;
                                    break;
                                }
                            }
                        }
                    }
                }
            }
        }
        
        if ( !isdefined( instance.containertype ) )
        {
            instance.containertype = 3;
        }
        
        extraloot = player smartloot( instance );
        
        if ( extraloot )
        {
            function_a09e7cf5bad99b64( instance, extraloot, 1 );
        }
    }
    else if ( isdefined( instance.contents ) && state == "partially_open_usable" )
    {
        if ( instance getscriptableparthasstate( part, "partially_reopen_in_use_unusable" ) )
        {
            instance setscriptablepartstate( part, "partially_reopen_in_use_unusable" );
        }
        else if ( instance getscriptableparthasstate( part, "partially_open_in_use_unusable" ) )
        {
            instance setscriptablepartstate( part, "partially_open_in_use_unusable" );
        }
    }
    
    opencache( instance, player, undefined );
}

// Namespace common_cache
// Params 4
// Checksum 0xb8e0cbae, Offset: 0x1353
// Size: 0x108
function opencache( instance, player, var_4a4b419f66681601, var_48c529c808a3d700 )
{
    instance callback::callback( #"cache_opened", { #player:player, #cache:instance } );
    challenges::function_f1b24bfd749d06e7( player, instance );
    player function_acae7643c0cdeeb4( instance.type, instance.origin, instance.contents, instance.index, instance.angles );
    
    if ( !var_48c529c808a3d700 )
    {
        utility::callsharedfunc( #"game", #"hash_897c59c034e10acb", instance, player );
    }
    
    if ( level.var_9afcf1fa7009bc81 )
    {
        function_72bff7a0da34bc70( instance, player, var_4a4b419f66681601 );
        level.var_2005ea41919076c3[ level.var_2005ea41919076c3.size ] = instance;
        return;
    }
    
    assert( !isdefined( var_4a4b419f66681601 ), "<dev string:x9d>" );
    openlootablecontainer( instance, player );
}

// Namespace common_cache
// Params 0
// Checksum 0xd649f320, Offset: 0x1463
// Size: 0x2a
function function_e5af5eddd7ec103e()
{
    if ( arraycontains( level.var_2005ea41919076c3, self ) )
    {
        level.var_2005ea41919076c3 = arrayremove( level.var_2005ea41919076c3, self );
    }
}

// Namespace common_cache
// Params 1
// Checksum 0x46c83ff0, Offset: 0x1495
// Size: 0x99
function function_c893ef9b1e3d60e5( player )
{
    var_b0349102295e411a = player namespace_9d8e359c3b1041e5::savefavoriteloadoutsharedfunc();
    
    if ( !isdefined( var_b0349102295e411a ) )
    {
        return;
    }
    
    var_d24d6807f69ebf3a = weapon::isfistweapon( var_b0349102295e411a.loadoutprimaryobject );
    
    if ( var_d24d6807f69ebf3a )
    {
        logstring( "common_cache::addPlayerFavoriteLoadoutWeapons - favorite loadout is fists only, using default1 for player " + player.name );
        var_b0349102295e411a = player namespace_9d8e359c3b1041e5::preloadandqueueclasssharedfunc( "default1" );
        
        if ( !isdefined( var_b0349102295e411a ) )
        {
            return;
        }
    }
    
    function_f033259e8605ab87( var_b0349102295e411a.loadoutprimaryobject );
    function_f033259e8605ab87( var_b0349102295e411a.loadoutsecondaryobject );
}

// Namespace common_cache
// Params 1
// Checksum 0xe68c1e46, Offset: 0x1536
// Size: 0x9d
function function_f033259e8605ab87( weapon )
{
    if ( !isdefined( weapon ) )
    {
        return;
    }
    
    loadoutscriptable = item_weapon::function_56a1baf9422bf1d4();
    loadoutbundlename = common_item_database::function_ca9ca606e66b5911( loadoutscriptable );
    
    if ( !loadoutbundlename )
    {
        return;
    }
    
    weapondata = { #var_2cb6d045c209a9ff:weapon };
    cache_additem( self, loadoutbundlename, undefined, 1, undefined, undefined, weapondata );
    ammotype = item_ammo::function_b162feeed34a4640( weapon );
    
    if ( isdefined( ammotype ) )
    {
        var_641d0819f6d09277 = common_item_database::function_ca9ca606e66b5911( ammotype );
        cache_additem( self, var_641d0819f6d09277, undefined, 1 );
    }
}

// Namespace common_cache
// Params 4, eflags: 0x4
// Checksum 0xfdc1e17, Offset: 0x15db
// Size: 0x97
function private function_a72a7a0cc1655f8d( rarity, var_d36ba6c2d46262e2, player, dropposition )
{
    itemspawnsfx = level.commonitem.raritydefs[ rarity ].var_7f1e967f6c8d1fc9;
    
    if ( !isdefined( itemspawnsfx ) )
    {
        return;
    }
    
    if ( var_d36ba6c2d46262e2.rarities[ rarity ] )
    {
        return;
    }
    
    if ( isdefined( dropposition ) )
    {
        playsoundatpos( dropposition, itemspawnsfx );
    }
    else
    {
        player playsound( itemspawnsfx );
    }
    
    var_d36ba6c2d46262e2.rarities[ rarity ] = 1;
}

// Namespace common_cache
// Params 3
// Checksum 0xf2b18248, Offset: 0x167a
// Size: 0x8f
function function_72bff7a0da34bc70( cache, player, var_4a4b419f66681601 )
{
    if ( !isdefined( cache.contents ) )
    {
        return;
    }
    
    if ( !isstruct( cache ) )
    {
        if ( cache getscriptableparthasstate( "body", "closed_to_fully_open_unusable" ) )
        {
            cache setscriptablepartstate( "body", "closed_to_fully_open_unusable" );
        }
        else if ( cache getscriptableparthasstate( "body", "fully_opening_unusable" ) )
        {
            cache setscriptablepartstate( "body", "fully_opening_unusable" );
        }
    }
    
    function_fbb69fe19da245da( cache, player, var_4a4b419f66681601 );
}

// Namespace common_cache
// Params 1
// Checksum 0x82938d50, Offset: 0x1711
// Size: 0x12c
function function_9d11bc7908a66f11( cache )
{
    cachebundlename = common_item::function_33a2c00e46263d99( cache );
    
    if ( cachebundlename )
    {
        cachebundle = getscriptbundlefieldvalues( cachebundlename, [ #"hash_43e03a8f1dc0aea0", #"hash_c46d8ad026333921", #"hash_b7349ddddbd8362c", #"hash_5ac356eeca95d0d3" ] );
    }
    
    forwardangles = cache.angles + ( 0, cachebundle.var_49e83a85150c5409 ?? 90, 0 );
    forwardangles = anglestoforward( forwardangles );
    zoffset = cachebundle.var_bd27e5e181b88db8 ?? 30;
    startorigin = cache.origin + ( 0, 0, zoffset ) + forwardangles * ( cachebundle.var_7138fd1169c4fcc5 ?? 0 );
    spawndistance = cachebundle.var_6ce57c9a7802879c ?? 60;
    spawndistance = cache.var_a3b7393208a540bc ?? spawndistance;
    endorigin = startorigin + forwardangles * spawndistance;
    return [ startorigin, endorigin ];
}

// Namespace common_cache
// Params 3
// Checksum 0xf9a96596, Offset: 0x1846
// Size: 0x5fb
function function_fbb69fe19da245da( cache, player, var_4a4b419f66681601 )
{
    if ( !isdefined( cache.contents ) )
    {
        return;
    }
    
    cachebundle = common_item::function_6b8ff3d5f2688336( cache );
    [ startorigin, endorigin ] = function_9d11bc7908a66f11( cache );
    
    if ( cachebundle.var_938569dacf789d91 )
    {
        spawnoptions = common_item::function_f5dfaa3bbdf99a33( endorigin, startorigin, cache.angles );
    }
    else
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( startorigin, cache.angles );
    }
    
    if ( isdefined( cache.var_885e7724f049d850 ) && !cache.var_885e7724f049d850 )
    {
        spawnoptions.var_885e7724f049d850 = 0;
    }
    
    spawnoptions.var_9161cf0784b6951d = 0;
    spawnoptions.var_7a5f61b06b9371b5 = 1;
    spawnoptions.var_44d5025c8cfbd48e = cache.contents.size;
    spawnoptions.var_aec43e9d95b191f9 = cachebundle.var_a89b8a66afd4fa5f;
    spawnoptions.var_12d76a8b35ac875d = cachebundle.var_73d4aa76c1fe3075;
    spawnoptions.var_2321e933cbdf46d8 = cachebundle.var_2ed71c0d850e9677;
    spawnoptions.var_34444f0dda11f0d5 = cachebundle.var_fee96745665bffa0;
    spawnoptions.var_8934e0ace9b7d996 = cachebundle.var_a11c5549411804d4;
    spawnoptions.var_8958d2ace9e03584 = cachebundle.var_a13f4349413e24f6;
    spawnoptions.var_d72f168a0f299753 = cachebundle.var_299225da1c61fa4b;
    spawnoptions.var_d7522c8a0f500f6d = cachebundle.var_296f3bda1c3be2f5;
    spawnoptions.var_8f2dd74e9b3d807d = cachebundle.var_8f2dd74e9b3d807d;
    spawnoptions.var_fc803688fa7c976c = 0;
    spawnoptions.var_10a99b46418cef2 = [];
    spawnoptions.ignoreents = [ cache ];
    spawnoptions.var_4a4b419f66681601 = var_4a4b419f66681601;
    spawnoptions.var_c580c0e8b49f1fcc = isdefined( var_4a4b419f66681601 );
    spawnoptions.spawningplayer = player;
    spawnoptions.var_37f4d1f586744af6 = 1;
    spawnoptions.analyticssource = cache.type;
    var_6d30a159ebb591aa = spawnstruct();
    contentsspawned = [];
    
    foreach ( item in cache.contents )
    {
        if ( cachebundle.var_ab3a1db2845e515f )
        {
            bundle = common_item::function_b202b16941992cca( item.lootid );
            
            if ( !namespace_9d8e359c3b1041e5::function_a7918caa4f9819eb( bundle.scriptable ) )
            {
                continue;
            }
            
            itemrarity = bundle.rarity ?? 0;
            function_a72a7a0cc1655f8d( itemrarity, var_6d30a159ebb591aa, player, spawnoptions.baseorigin );
            currencyitem = common_item::function_77600f92048df72d( bundle, item.quantity );
            player common_item::function_96119bed8ab4c5d9( currencyitem, 1 );
            continue;
        }
        
        if ( isdefined( item.weapondata.var_2cb6d045c209a9ff ) )
        {
            weaponobj = item.weapondata.var_2cb6d045c209a9ff;
            itemrarity = weaponobj.var_e4de3f79b4ac164f ?? item.weapondata.rarity;
            function_a72a7a0cc1655f8d( itemrarity, var_6d30a159ebb591aa, player, spawnoptions.baseorigin );
            spawned_weapon = item_weapon::function_53da2af5697709f8( weaponobj, item.weapondata, spawnoptions );
            
            if ( !isdefined( contentsspawned ) )
            {
                contentsspawned = [];
            }
            
            contentsspawned[ contentsspawned.size ] = spawned_weapon;
            continue;
        }
        
        if ( item.weapondata.var_d45ad5f713c5ee95 && isdefined( item.weapondata.scriptable ) )
        {
            item.weapondata.var_d3429102a6d659e5 = 1;
            weaponobj = function_1fb839e25a7e4f84( item.weapondata.scriptable );
            itemrarity = item.weapondata.rarity ?? 0;
            function_a72a7a0cc1655f8d( itemrarity, var_6d30a159ebb591aa, player, spawnoptions.baseorigin );
            spawned_weapon = item_weapon::function_53da2af5697709f8( weaponobj, item.weapondata, spawnoptions );
            
            if ( !isdefined( contentsspawned ) )
            {
                contentsspawned = [];
            }
            
            contentsspawned[ contentsspawned.size ] = spawned_weapon;
            continue;
        }
        
        if ( isdefined( item.weapondata ) )
        {
            bundle = common_item::function_90c3e0c1fd55d6b6( item.weapondata.itembundlename );
        }
        else
        {
            bundle = common_item::function_b202b16941992cca( item.lootid );
        }
        
        if ( !namespace_9d8e359c3b1041e5::function_a7918caa4f9819eb( bundle.scriptable ) )
        {
            continue;
        }
        
        itemrarity = bundle.rarity ?? 0;
        function_a72a7a0cc1655f8d( itemrarity, var_6d30a159ebb591aa, player, spawnoptions.baseorigin );
        spawned_item = common_item::function_61c2c0251e742ffd( bundle, item.quantity, spawnoptions );
        
        if ( !isdefined( contentsspawned ) )
        {
            contentsspawned = [];
        }
        
        contentsspawned[ contentsspawned.size ] = spawned_item;
        
        if ( self.var_9441016ace29d51d )
        {
            self [[ self.var_9441016ace29d51d ]]( spawned_item, bundle, spawnoptions );
        }
    }
    
    params = { #contentsspawned:contentsspawned, #spawnoptions:spawnoptions, #player:player, #cacheinstance:cache };
    player callback::callback( "lootcache_looted", params );
}

// Namespace common_cache
// Params 2
// Checksum 0x7ba5c485, Offset: 0x1e49
// Size: 0x6e0
function openlootablecontainer( container, opener )
{
    if ( !isdefined( container ) )
    {
        assertmsg( "<dev string:xd7>" );
        return;
    }
    
    containerbundle = undefined;
    var_b093e03044c4343e = common_item::function_33a2c00e46263d99( container );
    
    if ( var_b093e03044c4343e )
    {
        containerbundle = getscriptbundlefieldvalues( var_b093e03044c4343e, [ #"hash_5066679ac0ae76e0", #"hash_fbe7911f85f2d552", #"hash_c3b6f08cc4cd161f" ] );
    }
    
    if ( !isdefined( container.contents ) )
    {
        container.contents = [];
    }
    
    if ( container.containertype == 13 )
    {
        container.contents = opener.ballooncontents.contents;
    }
    
    if ( isdefined( container.playercontents[ opener.guid ] ) )
    {
        container.contents = container.playercontents[ opener.guid ];
    }
    
    function_69cdca74fead9201( opener, container );
    
    if ( level.gamemodebundle.var_64dbdf394f723bd && common_item::function_9af4a186249f7df1( opener ) && isdefined( opener.currentweapon.basename ) && opener.currentweapon.basename != "none" )
    {
        opener forceplaygestureviewmodel( "vm_ges_loot_container" );
    }
    
    items = container.contents;
    opener.var_50f741a14f09a6 = container;
    opener.var_75f60e367c30d7ac = opener.origin;
    
    if ( container.type == "activity_reward_cache_lootcache" )
    {
        foreach ( item in items )
        {
            item.fromriftreward = 1;
        }
    }
    
    params = { #player:opener, #items:items, #cacheinstance:container };
    opener callback::callback( "lootcache_looted", params );
    container.openedbefore = 1;
    
    if ( container.containertype == 13 )
    {
        opener.ballooncontents.contents = items;
    }
    
    if ( isdefined( container.linkedparent ) )
    {
        opener.var_75f60e367c30d7ac = rotatevectorinverted( opener.origin - container.linkedparent.origin, container.linkedparent.angles );
    }
    
    /#
        if ( items.size > 55 )
        {
            println( "<dev string:xfd>" + items.size + "<dev string:x131>" + 55 + "<dev string:x14a>" );
        }
    #/
    
    for ( itemindex = 0; itemindex < 55 ; itemindex++ )
    {
        if ( function_b55ef839fd45350( opener, container, itemindex ) )
        {
            function_7875275a0511dfeb( opener, itemindex, items[ itemindex ].lootid, items[ itemindex ].quantity, items[ itemindex ].weapondata );
            continue;
        }
        
        function_8632ef63c71b6048( opener, itemindex );
    }
    
    if ( isdefined( container.weaponslotcontents ) )
    {
        opener setclientomnvar( "loot_container_weapon", container.weaponslotcontents );
    }
    else
    {
        opener setclientomnvar( "loot_container_weapon", 0 );
    }
    
    if ( hasomnvar( "loot_container_min_slots" ) )
    {
        opener setclientomnvar( "loot_container_min_slots", container.minimumslots ?? level.var_6de02274b052182 );
    }
    
    if ( hasomnvar( "loot_container_owner_is_enemy" ) )
    {
        var_f58019e3c04b511 = isdefined( container.originalownerteam ) ? container.originalownerteam != opener.team : 0;
        opener setclientomnvar( "loot_container_owner_is_enemy", var_f58019e3c04b511 );
    }
    
    if ( container.var_f9027633b61e4fb7 && container.var_f9027633b61e4fb7.size )
    {
        foreach ( ref, resourceamount in container.var_f9027633b61e4fb7 )
        {
            if ( hasomnvar( "loot_container_owner_resource_" + ref ) )
            {
                opener setclientomnvar( "loot_container_owner_resource_" + ref, resourceamount );
            }
        }
        
        if ( hasomnvar( "loot_container_owner_max_count" ) )
        {
            opener setclientomnvar( "loot_container_owner_max_count", int( container.var_f28d3e1d622974 ?? 50 ) );
        }
    }
    
    if ( isdefined( container.uimemberindex ) && hasomnvar( "loot_container_owner_is_enemy" ) && container.uimemberindex >= 0 )
    {
        opener setclientomnvar( "loot_container_owner_squad_index", container.uimemberindex );
    }
    
    if ( !isstruct( container ) && hasomnvar( "loot_container_scriptable_index" ) && container scriptableislootcache() )
    {
        opener setclientomnvar( "loot_container_scriptable_index", container getscriptableindex() );
    }
    
    if ( !isdefined( container.containertype ) )
    {
        container.containertype = 1;
    }
    
    function_9d6321275c249932( container );
    
    if ( !isdefined( container.var_5a4d5180ea13e4ed ) )
    {
        container.var_5a4d5180ea13e4ed = containerbundle.var_350ea35146e8fb77 || containerbundle.var_5a4d5180ea13e4ed;
    }
    
    container thread function_8f2230e30fb63ee( opener );
    opener setclientomnvar( "loot_container_open", function_62d95810cae876df( container ) );
    
    if ( level.var_ed6ba5511b904dbd && !container.previouslyopened && container.containertype != 13 )
    {
        container.previouslyopened = 1;
    }
    
    if ( !function_4614af47ed74937b() && function_3d497f36c1ac217d() && !( isdefined( containerbundle ) && containerbundle.allowautoloot == 0 ) )
    {
        container thread function_b6f5e23e94a8f6d2( opener );
    }
    
    if ( container.inventorygroup.var_5fa09dedb96bba59 )
    {
        container thread function_5fa09dedb96bba59( opener );
    }
    
    container thread function_3cd03ddb9c97fb47( opener );
    container thread function_f4864e365efb6c46( opener );
    container.alreadyopened = 1;
    opener calloutmarkerping::function_d34345aa1f30ebba();
    opener callback::callback( "lootcache_opened_finished", params );
}

// Namespace common_cache
// Params 2
// Checksum 0x8d2bad17, Offset: 0x2531
// Size: 0x1d2
function function_69cdca74fead9201( opener, container )
{
    for ( itemindex = 0; itemindex < container.contents.size ; itemindex++ )
    {
        if ( !function_b55ef839fd45350( opener, container, itemindex ) )
        {
            continue;
        }
        
        item = container.contents[ itemindex ];
        itembundlename = common_item_database::function_db2360bc1c33f6f9( item.lootid );
        
        if ( !isdefined( itembundlename ) )
        {
            assertmsg( "<dev string:x14c>" + item.lootid + "<dev string:x17f>" );
            continue;
        }
        
        itembundle = getscriptbundle( itembundlename );
        
        if ( common_item::function_16e8c106491eeaca( itembundle ) == "weapon" && isdefined( itembundle.baseweapon ) )
        {
            clipammo = 0;
            stockammo = 0;
            rarity = undefined;
            
            if ( isdefined( item.var_6828becb300b1c44 ) || isdefined( item.weapondata ) )
            {
                weaponobj = item_weapon::function_31562a2fb3df68d5( itembundle, item );
                rarity = isdefined( item.weapondata ) ? item.weapondata.rarity : item.var_6828becb300b1c44.rarity;
                
                if ( isdefined( weaponobj ) )
                {
                    clipammo = weaponclipsize( weaponobj );
                    stockammo = weaponmaxammo( weaponobj );
                }
            }
            
            if ( clipammo <= 0 && isdefined( itembundle.baseweapon ) )
            {
                clipammo = weaponclipsize( itembundle.baseweapon );
                stockammo = weaponmaxammo( itembundle.baseweapon );
            }
            
            item.quantity = common_item::function_598dd39282efb544( clipammo + stockammo, undefined, undefined, rarity );
        }
    }
}

// Namespace common_cache
// Params 2
// Checksum 0x6cbc14b, Offset: 0x270b
// Size: 0x231
function closelootablecontainer( container, opener )
{
    if ( !( isdefined( container ) && isdefined( opener ) ) )
    {
        assertmsg( "<dev string:x1db>" );
        return;
    }
    
    /#
        if ( container === level.commonitemdebug.fakecache )
        {
            opener setclientomnvar( "<dev string:x20c>", 0 );
            opener.var_50f741a14f09a6 = undefined;
            container.revealedslots = undefined;
            container notify( #"closed" );
            return;
        }
    #/
    
    if ( level.gamemodebundle.var_64dbdf394f723bd && opener isgestureplaying( "vm_ges_loot_container" ) )
    {
        opener stopgestureviewmodel( "vm_ges_loot_container", 0.1 );
    }
    
    opener setclientomnvar( "loot_container_open", 0 );
    function_9c14b82a97b31e5a( opener );
    isempty = opener iscontainerempty( container );
    
    if ( !container.var_6e5229c10873d74a && !container.dontclose )
    {
        partname = container function_84ad2f70189ee7c3();
        
        if ( isempty )
        {
            if ( container getscriptableparthasstate( partname, "fully_opening_unusable" ) )
            {
                container setscriptablepartstate( partname, "fully_opening_unusable" );
            }
        }
        else if ( container getscriptableparthasstate( partname, "partially_open_usable" ) )
        {
            state = container getscriptablepartstate( partname );
            
            if ( state == "partially_open_in_use_unusable" || state == "partially_reopen_in_use_unusable" )
            {
                container setscriptablepartstate( partname, "partially_open_usable" );
            }
            else if ( state == "partially_opening_unusable" )
            {
                container thread function_7f82038990e4f22();
            }
            else if ( state != "partially_open_usable" && state != "closing" )
            {
                assertmsg( "<dev string:x220>" );
            }
        }
    }
    
    if ( opener.var_86fde2dcf3ca9f90 )
    {
        opener.var_86fde2dcf3ca9f90 = undefined;
    }
    
    opener.var_50f741a14f09a6 = undefined;
    params = { #isempty:isempty, #opener:opener };
    container callback::callback( #"on_cache_closed", params );
    
    if ( container.var_55c4b88997344176 )
    {
        function_7afda593c8230cf4( container, opener );
    }
    
    container notify( #"closed" );
}

// Namespace common_cache
// Params 1
// Checksum 0x7c49ae6f, Offset: 0x2944
// Size: 0x160
function function_489fcdde96d16732( opener )
{
    var_51bbba5cf1a735be = anglestoforward( opener getplayerangles() );
    framesstill = 0;
    var_dd45f6f0ad4c4ff3 = 0;
    
    while ( opener player::isreallyalive() && !opener.isdisconnecting && isdefined( opener.origin ) && !function_f12c2f020bcb9e80( self, opener, var_dd45f6f0ad4c4ff3 ) && !function_28cb4ef6c96f0ad( opener, var_51bbba5cf1a735be ) && opener playerads() < 0.5 )
    {
        if ( level.var_a7f8c522f4072f70 )
        {
            if ( lengthsquared( opener getvelocity() ) == 0 )
            {
                var_dd45f6f0ad4c4ff3 = framesstill >= level.var_dcb5008a07500f9;
                
                if ( isdefined( self.linkedparent ) )
                {
                    opener.var_75f60e367c30d7ac = rotatevectorinverted( opener.origin - self.linkedparent.origin, self.linkedparent.angles );
                }
                else
                {
                    opener.var_75f60e367c30d7ac = opener.origin;
                }
                
                framesstill++;
                framesstill = int( min( framesstill, level.var_dcb5008a07500f9 ) );
            }
            else if ( framesstill < level.var_dcb5008a07500f9 )
            {
                framesstill--;
                framesstill = int( max( framesstill, 0 ) );
            }
        }
        
        waitframe();
    }
}

// Namespace common_cache
// Params 1
// Checksum 0xcb04ec7b, Offset: 0x2aac
// Size: 0x50
function function_3cd03ddb9c97fb47( opener )
{
    self endon( #"death" );
    self endon( #"closed" );
    level endon( #"game_ended" );
    opener endon( #"disconnect" );
    function_489fcdde96d16732( opener );
    closelootablecontainer( self, opener );
}

// Namespace common_cache
// Params 1
// Checksum 0x2593b12b, Offset: 0x2b04
// Size: 0x57
function function_f4864e365efb6c46( opener )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self endon( #"closed" );
    opener utility::waittill_any( "close_container", "flashbang", "concussed", "weapon_fired" );
    closelootablecontainer( self, opener );
}

// Namespace common_cache
// Params 1, eflags: 0x4
// Checksum 0x2804d60f, Offset: 0x2b63
// Size: 0x3b0
function private function_5fa09dedb96bba59( opener )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self endon( #"closed" );
    opener endon( #"disconnect" );
    wait level.var_49a28b27a1d6f4da ?? 0.5;
    containerfuncs = common_inventory_groups::function_987405ff5ee23e99( 20 );
    [ containerinventorygroup, var_201686b8f2df16dd ] = self [[ containerfuncs.var_65a6f7922d118cdd ]]();
    
    if ( !var_201686b8f2df16dd )
    {
        return;
    }
    
    slots = common_inventory_groups::function_6e8756548142d338( common_inventory_groups::function_b353a43484c9827f( 20 ), var_201686b8f2df16dd ) ?? [];
    
    foreach ( typedata in slots )
    {
        [ torow, tocolumn ] = common_inventory_groups::function_12ee5af12df204b4( containerinventorygroup, typedata.index );
        currentitem = self [[ containerfuncs.getfunc ]]( torow, tocolumn );
        
        if ( !typedata.alloweditems || currentitem )
        {
            continue;
        }
        
        foreach ( alloweditem in typedata.alloweditems )
        {
            var_ca4b44da04a67a9a = opener common_inventory_groups::function_cbcd1dafab5f95e7( opener, alloweditem.lootid );
            
            if ( !var_ca4b44da04a67a9a || var_ca4b44da04a67a9a.size == 0 )
            {
                continue;
            }
            
            success = 0;
            
            foreach ( groupindex, var_2a602d2315d8a1d0 in var_ca4b44da04a67a9a )
            {
                foreach ( slotindex, item in var_2a602d2315d8a1d0 )
                {
                    funcs = common_inventory_groups::function_987405ff5ee23e99( groupindex );
                    [ playergroup, _ ] = self [[ funcs.var_65a6f7922d118cdd ]]();
                    [ fromrow, fromcolumn ] = common_inventory_groups::function_12ee5af12df204b4( playergroup, slotindex );
                    opener common_inventory_groups::function_d1ad55b9507ab500( fromrow, fromcolumn, groupindex, torow, tocolumn, 20, undefined, undefined, item );
                    success = 1;
                    break;
                }
            }
            
            if ( success )
            {
                wait level.var_f206f99829d42149 ?? 0.5;
            }
        }
    }
}

// Namespace common_cache
// Params 1
// Checksum 0x20fc59f3, Offset: 0x2f1b
// Size: 0x33c
function function_b6f5e23e94a8f6d2( opener )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self endon( #"closed" );
    opener endon( #"disconnect" );
    wait level.var_49a28b27a1d6f4da;
    
    if ( !isdefined( self.contents ) )
    {
        assertmsg( "<dev string:x296>" );
        return;
    }
    
    contents = self.contents;
    
    for ( i = 0; i < contents.size ; i++ )
    {
        if ( !isdefined( contents[ i ] ) )
        {
            continue;
        }
        
        lootid = contents[ i ].lootid;
        quantity = contents[ i ].quantity;
        itembundlename = common_item_database::function_db2360bc1c33f6f9( lootid );
        
        if ( !isdefined( itembundlename ) )
        {
            if ( quantity > 0 )
            {
                assertmsg( "<dev string:x2eb>" + lootid + "<dev string:x329>" );
            }
            
            continue;
        }
        
        itembundle = getscriptbundle( itembundlename );
        
        if ( !itembundle.autopickupenabled )
        {
            continue;
        }
        
        fakeitem = spawnstruct();
        fakeitem.type = itembundle.scriptable;
        fakeitem.count = quantity;
        fakeitem.fromcache = 1;
        
        if ( !opener )
        {
            return;
        }
        
        autolooted = opener common_item::function_96119bed8ab4c5d9( fakeitem, 1 );
        
        if ( autolooted )
        {
            function_25bee1f5701a0786( opener, i, 0, 0 );
            function_430a2732cbe29d15( opener, lootid );
            
            if ( isdefined( self.var_488526e1eed488ac ) )
            {
                foreach ( pingdata in self.var_488526e1eed488ac )
                {
                    if ( pingdata.lootid == lootid )
                    {
                        deleteping = 1;
                        
                        for ( index = 0; index < contents.size ; index++ )
                        {
                            if ( index != i && isdefined( contents[ index ].lootid ) && contents[ index ].lootid == lootid )
                            {
                                deleteping = 0;
                                break;
                            }
                        }
                        
                        if ( deleteping )
                        {
                            pingdata.pingowner calloutmarkerping::function_7c0ee9d4b604e6d6( pingdata.pingindex );
                        }
                        
                        waitframe();
                    }
                }
            }
            
            wait level.var_f206f99829d42149;
        }
    }
    
    if ( opener iscontainerempty( self ) && self.containertype != 15 && self.containertype != 18 && self.containertype != 19 && self.containertype != 20 && self.containertype != 21 )
    {
        container = self;
        closelootablecontainer( self, opener );
        
        if ( !container.var_5a4d5180ea13e4ed )
        {
            common_item::function_869d7676e359a627( container );
        }
    }
}

// Namespace common_cache
// Params 0
// Checksum 0xfeb5fb38, Offset: 0x325f
// Size: 0x4d
function function_7f82038990e4f22()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    partname = self function_84ad2f70189ee7c3();
    waitframe();
    
    while ( self getscriptablepartstate( partname ) == "partially_opening_unusable" )
    {
        waitframe();
    }
    
    self setscriptablepartstate( partname, "partially_open_usable" );
}

// Namespace common_cache
// Params 5
// Checksum 0xfaf02287, Offset: 0x32b4
// Size: 0x205
function function_7875275a0511dfeb( player, index, lootid, quantity, weapondata )
{
    assert( isdefined( lootid ) && isdefined( quantity ) );
    
    if ( !isdefined( lootid ) || lootid == 0 || !isdefined( quantity ) || quantity == 0 )
    {
        function_8632ef63c71b6048( player, index );
        return;
    }
    
    typename = loot::function_52cf8374c44a4ff5( lootid );
    
    if ( !isdefined( typename ) )
    {
        assertmsg( "<dev string:x363>" + lootid + "<dev string:x396>" );
        return;
    }
    
    typedata = level.lootmaster[ typename ];
    
    if ( !isdefined( typedata ) )
    {
        assertmsg( "<dev string:x399>" + typename + "<dev string:x396>" );
        return;
    }
    
    typeindex = typedata.typevalue;
    
    if ( typename == "weapon" && isdefined( weapondata ) )
    {
        itembundle = common_item::function_b202b16941992cca( lootid, [ #"baseweapon" ] );
        
        if ( isdefined( itembundle.baseweapon ) )
        {
            weaponobj = undefined;
            
            if ( isdefined( weapondata.variantid ) && weapondata.variantid != 0 )
            {
                blueprintcamo = function_7fbe09b4061ba663( lootid );
                weaponobj = weapon::giveweaponblueprint( itembundle.baseweapon, weapondata.variantid, blueprintcamo );
            }
            else
            {
                weaponobj = weapon::buildweapon( itembundle.baseweapon, weapondata.attachments );
            }
            
            weaponmaphandle = function_3fca4ed4a61b1996( player, weaponobj );
            lootid = function_41f8623757b80c63( lootid, weaponmaphandle );
        }
        
        typeindex = weapondata.rarity ?? 0;
    }
    
    player setclientomnvar( "loot_container_item_" + index, lootid );
    player setclientomnvar( "loot_container_quantity_" + index, quantity );
    player setclientomnvar( "loot_container_type_" + index, typeindex );
}

// Namespace common_cache
// Params 2
// Checksum 0x80de95e5, Offset: 0x34c1
// Size: 0x45
function function_8632ef63c71b6048( player, index )
{
    player setclientomnvar( "loot_container_item_" + index, 0 );
    player setclientomnvar( "loot_container_quantity_" + index, 0 );
    player setclientomnvar( "loot_container_type_" + index, 0 );
}

// Namespace common_cache
// Params 2
// Checksum 0xaee98052, Offset: 0x350e
// Size: 0x52, Type: bool
function function_28cb4ef6c96f0ad( opener, var_51bbba5cf1a735be )
{
    if ( !( isdefined( opener ) && isdefined( opener getplayerangles() ) ) )
    {
        return true;
    }
    
    var_3681bba61d4dd215 = anglestoforward( opener getplayerangles() );
    return math::anglebetweenvectors( var_51bbba5cf1a735be, var_3681bba61d4dd215 ) > level.var_6e24b391ac36b238;
}

// Namespace common_cache
// Params 1
// Checksum 0x4f1dc7ad, Offset: 0x3569
// Size: 0x273, Type: bool
function iscontainerempty( container )
{
    if ( container.var_350ea35146e8fb77 )
    {
        return false;
    }
    
    if ( container.var_960fe22fec7f3153 && !container.alreadyopened )
    {
        return false;
    }
    
    if ( isdefined( container.contents ) )
    {
        foreach ( content in container.contents )
        {
            if ( !( isdefined( content.lootid ) && isdefined( content.quantity ) ) )
            {
                continue;
            }
            
            if ( content.lootid > 0 && common_item::function_b4807b3f2255f9fa( content.lootid, content.quantity ) > 0 )
            {
                return false;
            }
        }
    }
    
    if ( isdefined( container.weaponslotcontents ) )
    {
        containerweapon = self getclientomnvar( "loot_container_weapon" );
        
        if ( containerweapon )
        {
            return false;
        }
    }
    
    if ( isdefined( container.playercontents ) )
    {
        foreach ( contents in container.playercontents )
        {
            foreach ( content in contents )
            {
                if ( !( isdefined( content.lootid ) && isdefined( content.quantity ) ) )
                {
                    continue;
                }
                
                if ( content.lootid > 0 && common_item::function_b4807b3f2255f9fa( content.lootid, content.quantity ) > 0 )
                {
                    return false;
                }
            }
        }
    }
    
    return true;
}

// Namespace common_cache
// Params 3
// Checksum 0xcc8aebe8, Offset: 0x37e5
// Size: 0xf7, Type: bool
function function_f12c2f020bcb9e80( container, opener, var_dd45f6f0ad4c4ff3 )
{
    if ( !isdefined( opener.var_75f60e367c30d7ac ) )
    {
        return true;
    }
    
    movedistancesquared = level.var_e7859541f2f9ab42;
    
    if ( level.var_a7f8c522f4072f70 && var_dd45f6f0ad4c4ff3 )
    {
        movedistancesquared = level.var_580802f7a3cc2a0c;
    }
    
    if ( isdefined( container.linkedparent ) )
    {
        newoffset = rotatevectorinverted( opener.origin - container.linkedparent.origin, container.linkedparent.angles );
        
        if ( distancesquared( opener.var_75f60e367c30d7ac, newoffset ) > movedistancesquared )
        {
            return true;
        }
    }
    else if ( distancesquared( opener.var_75f60e367c30d7ac, opener.origin ) > movedistancesquared )
    {
        return true;
    }
    
    return false;
}

// Namespace common_cache
// Params 3
// Checksum 0x7a2b89f2, Offset: 0x38e5
// Size: 0x99, Type: bool
function function_b55ef839fd45350( opener, container, itemindex )
{
    if ( !isdefined( container.contents[ itemindex ] ) )
    {
        return false;
    }
    
    item = container.contents[ itemindex ];
    lootid = item.lootid;
    quantity = common_item::function_b4807b3f2255f9fa( lootid, item.quantity );
    
    if ( quantity > 0 && isdefined( lootid ) && lootid > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace common_cache
// Params 2
// Checksum 0x76b150d9, Offset: 0x3987
// Size: 0x33f
function function_f87c1c077b1be730( notification, slotindex )
{
    result = 0;
    
    if ( isdefined( notification ) )
    {
        cache = self.var_50f741a14f09a6;
        
        if ( !isdefined( cache ) )
        {
            return;
        }
        
        if ( !function_e3795ef6fb5d5a82() )
        {
            return;
        }
        
        switch ( notification )
        {
            case #"hash_31a47c100531f34f":
                result = function_a06f5ca9e028aaf3( self, slotindex, "lootcache_obtaintype_stow", 1, cache );
                break;
            case #"hash_b7e2e7e659da3043":
                result = function_a06f5ca9e028aaf3( self, slotindex, "lootcache_obtaintype_stow", undefined, cache );
                break;
            case #"hash_453445f0e586a78e":
                if ( !cache.var_6e5229c10873d74a )
                {
                    loadoutindex = slotindex >> 8;
                    slotindex &= 255;
                    
                    if ( loadoutindex > 0 )
                    {
                        common_item::function_bbba261e6fdc7e52( "weapon", { #index:loadoutindex - 1 } );
                    }
                    
                    result = function_a06f5ca9e028aaf3( self, slotindex, "lootcache_obtaintype_equip", undefined, cache );
                }
                else
                {
                    if ( cache.var_bfb964dc17a2982c == 1 && !iscontainerempty( cache ) )
                    {
                        lootid = cache.contents[ 0 ].lootid;
                        quantity = cache.contents[ 0 ].quantity;
                        common_inventory::function_54c2ba7e4353996( lootid, quantity, undefined, undefined, 1 );
                        function_25bee1f5701a0786( self, 0, 0, 0 );
                    }
                    
                    common_inventory::function_a1677226f1d7e408( cache );
                }
                
                break;
            case #"hash_fb84b605789df05e":
                closelootablecontainer( cache, self );
                return;
            case #"hash_10217053947e341b":
                cacheindex = slotindex >> 8;
                backpackindex = slotindex & 255;
                lootid = cache.contents[ cacheindex ].lootid;
                quantity = cache.contents[ cacheindex ].quantity;
                common_inventory::function_22c912d7a228afd8( backpackindex, lootid, quantity );
                itembundlename = common_item_database::function_db2360bc1c33f6f9( lootid );
                
                if ( isdefined( itembundlename ) )
                {
                    itembundle = getscriptbundlefieldvalues( "itemspawnentry:" + itembundlename, [ #"pickupsfx", #"raritydef", #"type", #"ref", #"subtype" ] );
                    params = spawnstruct();
                    params.item = cache;
                    params.itembundlename = itembundlename;
                    params.itembundle = itembundle;
                    params.tobackpack = 1;
                    params.fromcache = cache;
                    callback::callback( #"player_item_pickup", params );
                }
                
                function_25bee1f5701a0786( self, cacheindex, 0, 0 );
                function_430a2732cbe29d15( self, lootid );
                
                if ( cache.var_6e5229c10873d74a )
                {
                    common_inventory::function_a1677226f1d7e408( cache );
                }
                else if ( iscontainerempty( cache ) )
                {
                    closelootablecontainer( cache, self );
                }
                
                break;
            default:
                return;
        }
    }
    
    function_df8b3ab8ce2209e7( result );
}

// Namespace common_cache
// Params 3
// Checksum 0x74432343, Offset: 0x3cce
// Size: 0x174
function function_df8b3ab8ce2209e7( result, autouse, lootid )
{
    if ( self.var_50f741a14f09a6 )
    {
        self.var_50f741a14f09a6.var_125d7756323ed24a = lootid;
    }
    
    if ( isdefined( self.var_50f741a14f09a6.onitemtaken ) )
    {
        [[ self.var_50f741a14f09a6.onitemtaken ]]( self.var_50f741a14f09a6, self );
    }
    
    if ( result && isdefined( self.var_50f741a14f09a6 ) && iscontainerempty( self.var_50f741a14f09a6 ) && self.var_50f741a14f09a6.containertype != 15 && self.var_50f741a14f09a6.containertype != 18 && self.var_50f741a14f09a6.containertype != 19 )
    {
        container = self.var_50f741a14f09a6;
        
        if ( autouse && level.var_178d825f61c867d5 )
        {
            function_976180a4c4d76a77( self.var_50f741a14f09a6, level.var_178d825f61c867d5 );
        }
        else
        {
            closelootablecontainer( self.var_50f741a14f09a6, self );
        }
        
        /#
            if ( container === level.commonitemdebug.fakecache )
            {
                return;
            }
        #/
        
        if ( !container.var_5a4d5180ea13e4ed )
        {
            common_item::function_869d7676e359a627( container );
        }
    }
}

// Namespace common_cache
// Params 2, eflags: 0xc
// Checksum 0x21259e47, Offset: 0x3e4a
// Size: 0x8e
function private function_976180a4c4d76a77( cache, delay )
{
    self notify( #"hash_918c4908d6ad3427" );
    self endon( #"hash_918c4908d6ad3427" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( cache ) )
    {
        if ( !isdefined( self.var_50f741a14f09a6 ) )
        {
            return;
        }
        
        cache = self.var_50f741a14f09a6;
    }
    
    cache endon( #"death" );
    cache endon( #"closed" );
    self endon( #"death_or_disconnect" );
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    closelootablecontainer( cache, self );
}

// Namespace common_cache
// Params 0
// Checksum 0x927a8cd1, Offset: 0x3ee0
// Size: 0xe, Type: bool
function function_e3795ef6fb5d5a82()
{
    return self getclientomnvar( "loot_container_open" ) > 0;
}

// Namespace common_cache
// Params 6
// Checksum 0x9cf0acc, Offset: 0x3ef7
// Size: 0x362, Type: bool
function function_a06f5ca9e028aaf3( player, index, obtaintype, obtainquantity, cache, autouse )
{
    if ( !( isdefined( cache ) && isdefined( cache.contents[ index ] ) ) )
    {
        assertmsg( "<dev string:x3d4>" + index + "<dev string:x396>" );
        return false;
    }
    
    if ( common_inventory::function_614b449545fb220b( index ) )
    {
        [ lootid, cachequantity ] = player common_inventory::function_5f7bc3510079202c( player.var_50f741a14f09a6, index );
        player.var_936b50c3120a3d3d = common_inventory::function_3a25b4ecb8b50411( player.var_50f741a14f09a6, index ) ?? player.var_936b50c3120a3d3d;
    }
    else
    {
        lootid = function_8a794a103f67b684( cache, index );
        cachequantity = function_8fcbeea1c8dee7fe( cache, index );
    }
    
    if ( !isdefined( lootid ) || lootid == 0 || !isdefined( cachequantity ) || cachequantity == 0 )
    {
        assertmsg( "<dev string:x408>" + index + "<dev string:x396>" );
        return false;
    }
    
    fromriftreward = cache.contents[ index ].fromriftreward ?? 0;
    weapondata = cache.contents[ index ].weapondata;
    
    if ( !isdefined( obtainquantity ) )
    {
        obtainquantity = cachequantity;
    }
    
    if ( obtainquantity > cachequantity )
    {
        obtainquantity = cachequantity;
        assertmsg( "<dev string:x45c>" );
    }
    
    itembundlename = undefined;
    itembundle = undefined;
    
    if ( isdefined( weapondata.baseweapon ) )
    {
        itembundlename = item_weapon::function_3da93a43aae4473d( weapondata.baseweapon, 0, weapondata.variantid );
        itembundle = getscriptbundle( itembundlename );
        assert( isdefined( itembundle ), "<dev string:x4aa>" + getxhashsourcename( itembundlename ) + "<dev string:x4e8>" );
    }
    else
    {
        itembundlename = common_item_database::function_db2360bc1c33f6f9( lootid );
        itembundle = common_item::function_b202b16941992cca( lootid );
    }
    
    if ( !isdefined( itembundle ) )
    {
        return false;
    }
    
    if ( function_99a3c189718cdd9e( itembundlename ) )
    {
        return false;
    }
    
    item = player.var_936b50c3120a3d3d;
    player.var_936b50c3120a3d3d = undefined;
    
    if ( !isdefined( item ) )
    {
        currentitem = function_e3c66d2777a7f9e8( cache, index );
        item = common_item::function_77600f92048df72d( itembundle, common_item::function_598dd39282efb544( obtainquantity ), undefined, 20, index, currentitem, weapondata );
        item.fromgroup = 20;
        item.fromriftreward = fromriftreward;
        item.fromcache = 1;
    }
    
    quantityused = 0;
    
    if ( !isdefined( obtaintype ) )
    {
        obtaintype = "";
    }
    
    switch ( obtaintype )
    {
        case #"hash_e6ef587f08f8234e":
            quantityused = player common_item::function_2b5e2ff57d5f392( item, autouse );
            break;
        case #"hash_93aad3e0afb4b617":
            quantityused = player common_inventory::function_7995ab7f567ba9d3( item, autouse );
            break;
        default:
            quantityused = player common_item::function_96119bed8ab4c5d9( item, autouse, 1 );
            break;
    }
    
    newquantity = obtainquantity - ( quantityused ?? 0 );
    function_25bee1f5701a0786( player, index, lootid, newquantity, weapondata );
    
    if ( newquantity < obtainquantity )
    {
        function_430a2732cbe29d15( player, lootid );
        player function_df8b3ab8ce2209e7( 1, autouse );
    }
    
    return newquantity == 0;
}

// Namespace common_cache
// Params 1
// Checksum 0x3495c793, Offset: 0x4262
// Size: 0x135
function function_9d6321275c249932( cache )
{
    if ( cache.inited )
    {
        return;
    }
    
    cachebundlename = common_item::function_33a2c00e46263d99( cache );
    
    if ( isdefined( cachebundlename ) )
    {
        cachebundle = getscriptbundlefieldvalues( cachebundlename, [ #"cacheinventorygroup", #"hash_bb2cbb2f083681d1", #"hash_e226fef9f27f5a53", #"hash_5066679ac0ae76e0", #"hash_7fe293a98716658e" ] );
        
        if ( isdefined( cachebundle.cacheinventorygroup ) && !isdefined( cache.inventorygroup ) )
        {
            function_8e78605bd608beb8( cache, cachebundle.cacheinventorygroup );
        }
        
        cache.var_55c4b88997344176 = cachebundle.var_55c4b88997344176 ?? undefined;
        cache.var_426cb1aea0467e8a = cachebundle.var_426cb1aea0467e8a ?? undefined;
        cache.var_350ea35146e8fb77 = cachebundle.var_350ea35146e8fb77 ?? undefined;
        cache.var_960fe22fec7f3153 = cachebundle.var_960fe22fec7f3153 ?? undefined;
    }
    
    cache.inited = 1;
}

// Namespace common_cache
// Params 2
// Checksum 0xd745ff86, Offset: 0x439f
// Size: 0x5a
function function_8e78605bd608beb8( cache, var_343cb5a98d11a0a2 )
{
    cache.inventorygroup = common_inventory_groups::function_dffd0ba870098fc5( var_343cb5a98d11a0a2 );
    cache.inventorygroupname = var_343cb5a98d11a0a2;
    cache.inventorygroup.index = common_inventory_groups::function_93b951c93e339754( "CONTAINER", var_343cb5a98d11a0a2 );
}

// Namespace common_cache
// Params 8
// Checksum 0x9006f49c, Offset: 0x4401
// Size: 0x54a
function cache_additem( cache, itembundlename, quantity, skipomnvars = 1, player, item, itemweapondata, alreadypacked )
{
    assert( ( isstruct( cache ) || isent( cache ) || cache scriptableislootcache() ) && isxhashasset( itembundlename ) && ( skipomnvars || isplayer( player ) ) );
    
    if ( !( isdefined( cache ) && isdefined( itembundlename ) ) )
    {
        return 0;
    }
    
    if ( !isdefined( cache.contents ) )
    {
        cache.contents = [];
    }
    
    if ( level.var_9afcf1fa7009bc81 )
    {
        itembundle = getscriptbundle( itembundlename );
        
        if ( !isdefined( quantity ) )
        {
            quantity = common_item::function_ea3b3088d82fd357( itembundle, { #weapon:itemweapondata.var_2cb6d045c209a9ff } );
        }
        
        function_9eba6662d46ad2c6( cache, quantity, itembundlename, itemweapondata );
        return quantity;
    }
    
    function_9d6321275c249932( cache );
    
    if ( !cache.contentinited )
    {
        totalslots = common_inventory_groups::function_19a5a29f5cd0df45( cache.inventorygroup );
        
        if ( isdefined( totalslots ) )
        {
            for ( i = 0; i < totalslots ; i++ )
            {
                if ( !isdefined( cache.contents[ i ] ) )
                {
                    cache.contents[ i ] = { #quantity:0, #lootid:0 };
                }
            }
            
            cache.contentinited = 1;
        }
    }
    
    itembundle = getscriptbundle( itembundlename );
    result = callback::response( 1, #"hash_8e2728470d1fa87a", { #itembundle:itembundle } );
    
    if ( result )
    {
        return 0;
    }
    
    lootid = common_item::function_779887309ec71dfe( itembundle );
    itemtype = common_item::function_16e8c106491eeaca( itembundle );
    
    if ( !isdefined( quantity ) )
    {
        quantity = common_item::function_ea3b3088d82fd357( itembundle );
    }
    
    if ( !isdefined( lootid ) )
    {
        assertmsg( "<dev string:x4ea>" + getxhashsourcename( itembundlename ) + "<dev string:x517>" );
        return 0;
    }
    
    var_825c1d611a95c0fd = quantity;
    
    for ( i = 0; i < common_inventory_groups::function_19a5a29f5cd0df45( cache.inventorygroup ) ; i++ )
    {
        index = cache common_inventory_groups::function_76928b4f093ca1ad( 20, itembundle, undefined, item );
        
        if ( !isdefined( index ) )
        {
            break;
        }
        
        currentlootid = function_8a794a103f67b684( cache, index );
        currentquantity = function_8fcbeea1c8dee7fe( cache, index );
        
        if ( currentquantity > 0 && lootid != currentlootid )
        {
            continue;
        }
        
        var_3b9fc76191bf8884 = common_inventory_groups::function_3687d548a906da96( 20, index );
        newquantity = int( min( var_3b9fc76191bf8884, var_825c1d611a95c0fd + currentquantity ) );
        weapondata = itemweapondata;
        
        if ( itemtype == "weapon" )
        {
            newquantity = quantity;
            
            if ( !itembundle.var_d45ad5f713c5ee95 )
            {
                if ( !alreadypacked )
                {
                    newquantity = common_item::function_598dd39282efb544( quantity, undefined, undefined, itembundle.rarity );
                }
                
                if ( !isdefined( weapondata ) )
                {
                    if ( isdefined( item.weaponobj ) )
                    {
                        weapondata = item_weapon::function_fdc74b9be99fda2f( item.weaponobj );
                    }
                    else
                    {
                        weapondata = {};
                        weapondata.variantid = item_weapon::function_4591efaaa1c03edd( itembundle );
                        weapondata.count = newquantity;
                        weapondata.baseweapon = itembundle.baseweapon;
                        weapondata.attachmentslots = itembundle.var_ef872c5384bdd7ce;
                        weapondata.itembundlename = itembundlename;
                        
                        if ( !isdefined( item ) )
                        {
                            item = spawnstruct();
                        }
                        
                        if ( !isdefined( item.additionaldata ) )
                        {
                            item.additionaldata = {};
                        }
                        
                        item.additionaldata.attachmentslots = weapondata.attachmentslots;
                        
                        if ( weapondata.variantid == 0 )
                        {
                            attachments = item_weapon::function_860f9afb151019a6( itembundlename );
                            
                            if ( isdefined( attachments ) && attachments.size > 0 )
                            {
                                weapondata.attachments = attachments;
                            }
                        }
                        else
                        {
                            weapondata.camo = function_7fbe09b4061ba663( lootid );
                        }
                        
                        weapondata.rarity = function_f69e65e97212f577( weapondata, itembundle );
                    }
                }
            }
        }
        
        cache.contents[ index ] = { #item:item, #weapondata:weapondata, #quantity:newquantity, #lootid:lootid };
        callback::callback( #"hash_43fa020e1f5bd32e", { #quantity:newquantity, #lootid:lootid, #player:player, #index:index, #cache:cache } );
        
        if ( !skipomnvars && player && player function_e3795ef6fb5d5a82() && cache == player.var_50f741a14f09a6 )
        {
            function_7875275a0511dfeb( player, index, lootid, newquantity, weapondata );
        }
        
        var_825c1d611a95c0fd -= common_item::function_b4807b3f2255f9fa( lootid, newquantity ) - currentquantity;
        
        if ( itemtype == "weapon" || var_825c1d611a95c0fd <= 0 )
        {
            break;
        }
    }
    
    return quantity - var_825c1d611a95c0fd;
}

// Namespace common_cache
// Params 4
// Checksum 0x5cc28d1c, Offset: 0x4954
// Size: 0xf5
function function_a09e7cf5bad99b64( cache, var_b9af18a63e8b59d3, skipomnvars, player )
{
    assert( ( isstruct( cache ) || isent( cache ) || cache scriptableislootcache() ) && isarray( var_b9af18a63e8b59d3 ) && ( skipomnvars || isplayer( player ) ) );
    
    if ( !isdefined( cache.contents ) )
    {
        cache.contents = [];
    }
    
    foreach ( itembundlename in var_b9af18a63e8b59d3 )
    {
        cache_additem( cache, itembundlename, undefined, skipomnvars, player );
    }
}

// Namespace common_cache
// Params 5
// Checksum 0x4301c7ab, Offset: 0x4a51
// Size: 0x122
function function_a136b84fc5c0dfab( cache, itemspawnlistbundlename, count, skipomnvars, player )
{
    assert( ( isstruct( cache ) || isent( cache ) || cache scriptableislootcache() ) && isxhashasset( itemspawnlistbundlename ) && ( skipomnvars || isplayer( player ) ) );
    
    if ( !isdefined( cache.contents ) )
    {
        cache.contents = [];
    }
    
    var_b9af18a63e8b59d3 = function_c11af7a197679429( itemspawnlistbundlename, count );
    function_9d6321275c249932( cache );
    function_61ef9e0b74e10aaf( cache, var_b9af18a63e8b59d3 );
    
    foreach ( itembundlename in var_b9af18a63e8b59d3 )
    {
        cache_additem( cache, itembundlename, undefined, skipomnvars, player );
    }
}

// Namespace common_cache
// Params 7
// Checksum 0xf419ac57, Offset: 0x4b7b
// Size: 0x552
function function_990ee9d9acd2d1d5( cache, player, itembundlename, quantity, skipomnvars = 1, item, itemweapondata )
{
    assert( isplayer( player ) && isxhashasset( itembundlename ) );
    
    if ( !isdefined( cache.contents ) )
    {
        cache.contents = [];
    }
    
    if ( !isdefined( cache.playercontents ) )
    {
        cache.playercontents = [];
    }
    
    if ( !isdefined( cache.playercontents[ player.guid ] ) )
    {
        cache.playercontents[ player.guid ] = [];
    }
    
    if ( !isdefined( cache.var_a599cc60a4ed8416 ) )
    {
        cache.var_a599cc60a4ed8416 = [];
    }
    
    function_9d6321275c249932( cache );
    
    if ( !cache.var_a599cc60a4ed8416[ player.guid ] )
    {
        totalslots = common_inventory_groups::function_19a5a29f5cd0df45( cache.inventorygroup );
        
        if ( isdefined( totalslots ) )
        {
            for ( i = 0; i < totalslots ; i++ )
            {
                if ( !isdefined( cache.playercontents[ player.guid ][ i ] ) )
                {
                    cache.playercontents[ player.guid ][ i ] = { #quantity:0, #lootid:0 };
                }
            }
            
            cache.var_a599cc60a4ed8416[ player.guid ] = 1;
        }
    }
    
    itembundle = getscriptbundle( itembundlename );
    lootid = common_item::function_779887309ec71dfe( itembundle );
    itemtype = common_item::function_16e8c106491eeaca( itembundle );
    packedquantity = quantity ?? common_item::function_ea3b3088d82fd357( itembundle );
    quantity = common_item::function_44eacd480abb5b94( packedquantity );
    
    if ( !isdefined( lootid ) )
    {
        assertmsg( "<dev string:x4ea>" + getxhashsourcename( itembundlename ) + "<dev string:x517>" );
        return 0;
    }
    
    var_825c1d611a95c0fd = quantity;
    
    for ( i = 0; i < common_inventory_groups::function_19a5a29f5cd0df45( cache.inventorygroup ) ; i++ )
    {
        var_eab44256d7c4454 = player.var_50f741a14f09a6;
        player.var_50f741a14f09a6 = cache;
        cache.var_4a3c02ed9b7fd7a7 = player.guid;
        index = player common_inventory_groups::function_76928b4f093ca1ad( 20, itembundle, undefined, item );
        cache.var_4a3c02ed9b7fd7a7 = undefined;
        player.var_50f741a14f09a6 = var_eab44256d7c4454;
        
        if ( !isdefined( index ) )
        {
            break;
        }
        
        currentlootid = function_ba4d200a60da538( cache, player, index );
        currentquantity = function_e401c34a0cb32886( cache, player, index );
        
        if ( currentquantity > 0 && lootid != currentlootid )
        {
            continue;
        }
        
        var_3b9fc76191bf8884 = common_inventory_groups::function_3687d548a906da96( 20, index );
        newquantity = int( min( var_3b9fc76191bf8884, var_825c1d611a95c0fd + currentquantity ) );
        var_cae05f1ee3b95815 = newquantity;
        weapondata = itemweapondata;
        
        if ( itemtype == "weapon" )
        {
            newquantity = quantity;
            var_cae05f1ee3b95815 = packedquantity;
            
            if ( !itembundle.var_d45ad5f713c5ee95 )
            {
                var_cae05f1ee3b95815 = common_item::function_598dd39282efb544( quantity, undefined, undefined, itembundle.rarity );
                
                if ( !isdefined( weapondata ) )
                {
                    if ( isdefined( item.weaponobj ) )
                    {
                        weapondata = item_weapon::function_fdc74b9be99fda2f( item.weaponobj );
                    }
                    else
                    {
                        weapondata = {};
                        weapondata.rarity = itembundle.rarity;
                        weapondata.variantid = item_weapon::function_4591efaaa1c03edd( itembundle );
                        weapondata.count = packedquantity;
                        weapondata.baseweapon = itembundle.baseweapon;
                        weapondata.itembundlename = itembundlename;
                        
                        if ( weapondata.variantid == 0 )
                        {
                            attachments = item_weapon::function_860f9afb151019a6( itembundlename );
                            
                            if ( isdefined( attachments ) && attachments.size > 0 )
                            {
                                weapondata.attachments = attachments;
                            }
                        }
                        else
                        {
                            weapondata.camo = function_7fbe09b4061ba663( lootid );
                        }
                        
                        weapondata.rarity = function_f69e65e97212f577( weapondata, itembundle );
                    }
                }
            }
        }
        
        cache.playercontents[ player.guid ][ index ] = { #item:item, #weapondata:weapondata, #quantity:var_cae05f1ee3b95815, #lootid:lootid };
        callback::callback( #"hash_43fa020e1f5bd32e", { #quantity:var_cae05f1ee3b95815, #lootid:lootid, #player:player, #index:index, #cache:cache } );
        
        if ( !skipomnvars && player && player function_e3795ef6fb5d5a82() && cache == player.var_50f741a14f09a6 )
        {
            function_7875275a0511dfeb( player, index, lootid, var_cae05f1ee3b95815, weapondata );
        }
        
        var_825c1d611a95c0fd -= newquantity - currentquantity;
        
        if ( var_825c1d611a95c0fd <= 0 )
        {
            break;
        }
    }
    
    return quantity - var_825c1d611a95c0fd;
}

// Namespace common_cache
// Params 4
// Checksum 0x8f29f877, Offset: 0x50d6
// Size: 0x118
function function_6e9defb713a31012( cache, player, var_b9af18a63e8b59d3, skipomnvars )
{
    assert( ( isstruct( cache ) || cache scriptableislootcache() ) && isplayer( player ) && isarray( var_b9af18a63e8b59d3 ) );
    
    if ( !isdefined( cache.playercontents ) )
    {
        cache.playercontents = [];
    }
    
    if ( !isdefined( cache.playercontents[ player.guid ] ) )
    {
        cache.playercontents[ player.guid ] = [];
    }
    
    foreach ( itembundlename in var_b9af18a63e8b59d3 )
    {
        function_990ee9d9acd2d1d5( cache, player, itembundlename, undefined, skipomnvars );
    }
}

// Namespace common_cache
// Params 5
// Checksum 0xce01e7d8, Offset: 0x51f6
// Size: 0x145
function function_3f73c0f38d34737f( cache, player, itemspawnlistbundlename, count, skipomnvars )
{
    assert( ( isstruct( cache ) || cache scriptableislootcache() ) && isplayer( player ) && isxhashasset( itemspawnlistbundlename ) );
    
    if ( !isdefined( cache.playercontents ) )
    {
        cache.playercontents = [];
    }
    
    if ( !isdefined( cache.playercontents[ player.guid ] ) )
    {
        cache.playercontents[ player.guid ] = [];
    }
    
    var_b9af18a63e8b59d3 = function_c11af7a197679429( itemspawnlistbundlename, count );
    function_9d6321275c249932( cache );
    function_61ef9e0b74e10aaf( cache, var_b9af18a63e8b59d3 );
    
    foreach ( itembundlename in var_b9af18a63e8b59d3 )
    {
        function_990ee9d9acd2d1d5( cache, player, itembundlename, undefined, skipomnvars );
    }
}

// Namespace common_cache
// Params 4
// Checksum 0x8f7d744, Offset: 0x5343
// Size: 0x511
function function_e69b07abaa3e643b( cache, itemspawnlistbundlename, count, players )
{
    partname = cache function_84ad2f70189ee7c3();
    firstplayer = players[ 0 ];
    var_f7aecda6b44cf0d4 = firstplayer.guid;
    otherplayers = utility::array_slice( players, 1 );
    everyoneelse = arraycopy( level.players );
    
    foreach ( player in players )
    {
        everyoneelse = arrayremove( everyoneelse, player );
    }
    
    while ( true )
    {
        state = cache getscriptablepartstate( partname );
        
        if ( state != "partially_open_in_use_unusable" && state != "partially_reopen_in_use_unusable" && state != "partially_opening_unusable" && state != "fully_opening_unusable" && state != "closing" && state != "partially_closing_unusable" && state != "closed_to_fully_open_unusable" )
        {
            break;
        }
        
        waitframe();
    }
    
    switch ( state )
    {
        case #"hash_6508078488d5273a":
        case #"hash_80a322219de080cb":
            if ( !cache.contents )
            {
                itemnames = getscriptablelootcachecontents( cache );
                
                if ( itemnames )
                {
                    function_61ef9e0b74e10aaf( cache, itemnames );
                    function_a09e7cf5bad99b64( cache, itemnames, 1 );
                }
            }
            
            foreach ( itembundlename in function_c11af7a197679429( itemspawnlistbundlename, count ) )
            {
                function_990ee9d9acd2d1d5( cache, firstplayer, itembundlename, undefined, undefined, { #var_6f072442f0dfe379:1 } );
            }
            
            break;
        case #"hash_c8b4e464ad01036b":
            foreach ( itembundlename in function_c11af7a197679429( itemspawnlistbundlename, count ) )
            {
                function_990ee9d9acd2d1d5( cache, firstplayer, itembundlename, undefined, undefined, { #var_6f072442f0dfe379:1 } );
            }
            
            break;
        case #"hash_33d00c02a93d1b5e":
            cache setscriptablepartstate( partname, "partially_open_usable" );
            
            foreach ( itembundlename in function_c11af7a197679429( itemspawnlistbundlename, count ) )
            {
                function_990ee9d9acd2d1d5( cache, firstplayer, itembundlename, undefined, undefined, { #var_6f072442f0dfe379:1 } );
            }
            
            cache function_7653c765b6c7b815();
            
            foreach ( player in players )
            {
                cache enablescriptableplayeruse( player );
            }
            
            break;
        default:
            assertmsg( "<dev string:x53c>" + state );
            break;
    }
    
    foreach ( player in otherplayers )
    {
        cache.playercontents[ player.guid ] = cache.playercontents[ var_f7aecda6b44cf0d4 ];
    }
    
    foreach ( player in everyoneelse )
    {
        cache.playercontents[ player.guid ] = cache.contents;
    }
    
    cache utility::ent_flag_set( "added_filtered_items" );
}

// Namespace common_cache
// Params 2
// Checksum 0xfc71872, Offset: 0x585c
// Size: 0x1c7
function function_5fe16141c561e14a( cache, players )
{
    partname = cache function_84ad2f70189ee7c3();
    everyoneelse = arraycopy( level.players );
    
    foreach ( player in players )
    {
        everyoneelse = arrayremove( everyoneelse, player );
    }
    
    while ( true )
    {
        state = cache getscriptablepartstate( partname );
        
        if ( state != "partially_open_in_use_unusable" && state != "partially_reopen_in_use_unusable" && state != "partially_opening_unusable" && state != "fully_opening_unusable" && state != "closing" && state != "partially_closing_unusable" && state != "closed_to_fully_open_unusable" )
        {
            break;
        }
        
        waitframe();
    }
    
    if ( everyoneelse.size )
    {
        cache.contents = cache.playercontents[ everyoneelse[ 0 ].guid ];
    }
    
    foreach ( guid, content in cache.playercontents )
    {
        cache.playercontents[ guid ] = undefined;
    }
}

// Namespace common_cache
// Params 2
// Checksum 0xaf1ab804, Offset: 0x5a2b
// Size: 0x17d
function function_340c14c90101568a( container, buttondef )
{
    if ( !( isdefined( container ) && isdefined( buttondef ) ) )
    {
        return [ 0, 0 ];
    }
    
    currentquantity = 0;
    var_453c34d9c126dafd = 0;
    
    foreach ( rownum, row in container.inventorygroup.buttonrows )
    {
        foreach ( colnum, col in row.buttoncolumns )
        {
            if ( col.buttondef === buttondef )
            {
                var_453c34d9c126dafd++;
                index = common_inventory_groups::function_7539b7a73a2ba0b2( container.inventorygroup, rownum, colnum );
                currentquantity += function_8fcbeea1c8dee7fe( container, index );
            }
        }
    }
    
    return [ currentquantity, var_453c34d9c126dafd ];
}

// Namespace common_cache
// Params 7
// Checksum 0x476da095, Offset: 0x5bb1
// Size: 0x30f
function function_52ac35e31eb303d3( container, buttondef, itembundlename, quantity, skipomnvars, player, item )
{
    if ( !( isdefined( container ) && isdefined( buttondef ) && isdefined( itembundlename ) ) )
    {
        return 0;
    }
    
    itembundle = getscriptbundle( itembundlename );
    
    if ( !isdefined( quantity ) )
    {
        quantity = common_item::function_ea3b3088d82fd357( itembundle );
    }
    
    if ( level.var_9afcf1fa7009bc81 )
    {
        function_9eba6662d46ad2c6( container, quantity, itembundlename );
        return quantity;
    }
    
    if ( !isdefined( container.contents ) )
    {
        container.contents = [];
    }
    
    function_9d6321275c249932( container );
    
    if ( !isdefined( container.inventorygroup.buttonrows ) )
    {
        return 0;
    }
    
    initialquantity = quantity;
    maxcount = common_item::function_38334193bd9b5956( itembundle );
    typeref = common_item::function_16e8c106491eeaca( itembundle );
    lootid = common_item::function_779887309ec71dfe( itembundle );
    
    foreach ( rownum, row in container.inventorygroup.buttonrows )
    {
        foreach ( colnum, col in row.buttoncolumns )
        {
            if ( col.buttondef === buttondef )
            {
                index = common_inventory_groups::function_7539b7a73a2ba0b2( container.inventorygroup, rownum, colnum );
                currentquantity = function_8fcbeea1c8dee7fe( container, index );
                newquantity = int( min( maxcount, quantity + currentquantity ) );
                quantity -= newquantity - currentquantity;
                
                if ( typeref == "weapon" )
                {
                    newquantity = initialquantity;
                }
                
                if ( isdefined( player ) && !skipomnvars )
                {
                    function_25bee1f5701a0786( player, index, lootid, newquantity, undefined, item );
                }
                else
                {
                    container.contents[ index ] = { #item:item, #quantity:newquantity, #lootid:lootid };
                    callback::callback( #"hash_43fa020e1f5bd32e", { #quantity:newquantity, #lootid:lootid, #player:player, #index:index, #cache:container } );
                }
                
                break;
            }
        }
    }
    
    return initialquantity - quantity;
}

// Namespace common_cache
// Params 1
// Checksum 0x90db5a77, Offset: 0x5ec9
// Size: 0x2d
function cache_restock( cache )
{
    level.var_2005ea41919076c3 = arrayremove( level.var_2005ea41919076c3, cache );
    function_df56bf0f13c9f0b3( cache );
}

// Namespace common_cache
// Params 1, eflags: 0x4
// Checksum 0x217cc208, Offset: 0x5efe
// Size: 0x91
function private function_df56bf0f13c9f0b3( cache )
{
    cache.contents = undefined;
    var_f67995529827f79 = function_73fc13f2febd3a2( cache.type );
    
    if ( isdefined( var_f67995529827f79.spawnlist ) && isdefined( var_f67995529827f79.spawncount ) )
    {
        function_a136b84fc5c0dfab( cache, var_f67995529827f79.spawnlist, var_f67995529827f79.spawncount, 1 );
    }
    
    cache setscriptablepartstate( "body", "closing" );
    cache notify( #"closed" );
}

// Namespace common_cache
// Params 1
// Checksum 0xdb2453f5, Offset: 0x5f97
// Size: 0x42
function function_cad109a4d37ddbb( cache )
{
    level.var_2005ea41919076c3 = arrayremove( level.var_2005ea41919076c3, cache );
    cache setscriptablepartstate( "body", "closing" );
    cache notify( #"closed" );
}

// Namespace common_cache
// Params 1
// Checksum 0x5ad09e2c, Offset: 0x5fe1
// Size: 0x1a
function function_81144e13eed673e( cache )
{
    cache.var_20371c57bb2d341d = 1;
}

// Namespace common_cache
// Params 1
// Checksum 0xf2e89cbb, Offset: 0x6003
// Size: 0xe1
function restockall( ispublicevent )
{
    if ( !isdefined( level.var_8c7e4dff187f47a4 ) )
    {
        level.var_8c7e4dff187f47a4 = throttle::throttle_initialize_gate( "common_item_restock_all_throttle", getdvarint( @"hash_746754755f28096a", 25 ) );
    }
    
    var_8ffb4f157c264fe5 = level.var_2005ea41919076c3;
    level.var_2005ea41919076c3 = [];
    
    foreach ( instance in var_8ffb4f157c264fe5 )
    {
        throttle::throttle_wait_gate( level.var_8c7e4dff187f47a4 );
        
        if ( isdefined( instance ) )
        {
            thread function_c34016d8417cc4eb( instance, ispublicevent );
        }
    }
}

// Namespace common_cache
// Params 2, eflags: 0x4
// Checksum 0x5ae68438, Offset: 0x60ec
// Size: 0x99
function private function_c34016d8417cc4eb( instance, ispublicevent )
{
    if ( instance.var_20371c57bb2d341d || instance.type == "br_scavenger_quest_cache" || instance.type == "br_loot_cache_aether" || !instance getscriptableparthasstate( "body", "closing" ) || ispublicevent && !instance.var_426cb1aea0467e8a )
    {
        level.var_2005ea41919076c3[ level.var_2005ea41919076c3.size ] = instance;
        return;
    }
    
    function_df56bf0f13c9f0b3( instance );
}

// Namespace common_cache
// Params 3
// Checksum 0xcdd497, Offset: 0x618d
// Size: 0xef
function function_36e88ba6bc879452( container, lootid, player )
{
    if ( !( isdefined( container ) && isdefined( container.contents ) && isdefined( lootid ) ) || !isint( lootid ) )
    {
        /#
            if ( !( isdefined( container ) && isdefined( container.contents ) ) )
            {
                assertmsg( "<dev string:x557>" );
            }
            else if ( !isint( lootid ) )
            {
                assertmsg( "<dev string:x5a8>" );
            }
        #/
        
        return [ undefined, undefined ];
    }
    
    containerindex = 0;
    
    while ( containerindex < container.contents.size )
    {
        if ( lootid == container.contents[ containerindex ].lootid )
        {
            return [ containerindex, 0 ];
        }
        
        containerindex += 1;
    }
    
    return [ undefined, undefined ];
}

// Namespace common_cache
// Params 1, eflags: 0x4
// Checksum 0x35c5b8d6, Offset: 0x6285
// Size: 0x3e
function private function_d10e11db62420b63( container )
{
    if ( isdefined( container.var_4a3c02ed9b7fd7a7 ) )
    {
        return container.playercontents[ container.var_4a3c02ed9b7fd7a7 ];
    }
    
    return container.contents;
}

// Namespace common_cache
// Params 2
// Checksum 0x29cda190, Offset: 0x62cc
// Size: 0x52, Type: bool
function function_8a794a103f67b684( container, index )
{
    contents = function_d10e11db62420b63( container );
    
    if ( !( isdefined( container ) && isdefined( index ) && isdefined( contents[ index ] ) ) )
    {
        return false;
    }
    
    return contents[ index ].lootid ?? 0;
}

// Namespace common_cache
// Params 2
// Checksum 0xdc8f4e4b, Offset: 0x6327
// Size: 0x74
function function_8fcbeea1c8dee7fe( container, index )
{
    contents = function_d10e11db62420b63( container );
    
    if ( !( isdefined( container ) && isdefined( index ) && isdefined( contents[ index ] ) && isdefined( contents[ index ].quantity ) ) )
    {
        return 0;
    }
    
    return common_item::function_b4807b3f2255f9fa( contents[ index ].lootid, contents[ index ].quantity );
}

// Namespace common_cache
// Params 2
// Checksum 0x71d6c03b, Offset: 0x63a4
// Size: 0x4d
function function_e3c66d2777a7f9e8( container, index )
{
    contents = function_d10e11db62420b63( container );
    
    if ( !( isdefined( container ) && isdefined( index ) && isdefined( contents[ index ] ) ) )
    {
        return;
    }
    
    return contents[ index ].item;
}

// Namespace common_cache
// Params 2
// Checksum 0x33d1828e, Offset: 0x63fa
// Size: 0x5e
function function_79205ff2572aa19b( container, index )
{
    contents = function_d10e11db62420b63( container );
    
    if ( !( isdefined( container ) && isdefined( index ) && isdefined( contents[ index ] ) ) )
    {
        return;
    }
    
    return contents[ index ].weapondata ?? contents[ index ].var_6828becb300b1c44;
}

// Namespace common_cache
// Params 3
// Checksum 0xd95a68ec, Offset: 0x6461
// Size: 0x78, Type: bool
function function_ba4d200a60da538( container, player, index )
{
    if ( isdefined( container ) && isdefined( player ) && isdefined( index ) && isdefined( container.playercontents[ player.guid ][ index ] ) )
    {
        return ( container.playercontents[ player.guid ][ index ].lootid ?? 0 );
    }
    
    return false;
}

// Namespace common_cache
// Params 3
// Checksum 0xfcddb6bc, Offset: 0x64e2
// Size: 0x78, Type: bool
function function_e401c34a0cb32886( container, player, index )
{
    if ( isdefined( container ) && isdefined( player ) && isdefined( index ) && isdefined( container.playercontents[ player.guid ][ index ] ) )
    {
        return ( container.playercontents[ player.guid ][ index ].quantity ?? 0 );
    }
    
    return false;
}

// Namespace common_cache
// Params 3
// Checksum 0xb93340d1, Offset: 0x6563
// Size: 0x73
function function_d02799be7103ba5c( container, player, index )
{
    if ( isdefined( container ) && isdefined( player ) && isdefined( index ) && isdefined( container.playercontents[ player.guid ][ index ] ) )
    {
        return container.playercontents[ player.guid ][ index ].item;
    }
}

// Namespace common_cache
// Params 3
// Checksum 0x3913b9e4, Offset: 0x65df
// Size: 0x9a
function function_8cdc917b25e97bed( container, player, index )
{
    if ( isdefined( container ) && isdefined( player ) && isdefined( index ) && isdefined( container.playercontents[ player.guid ][ index ] ) )
    {
        return ( container.playercontents[ player.guid ][ index ].weapondata ?? container.playercontents[ player.guid ][ index ].var_6828becb300b1c44 );
    }
}

// Namespace common_cache
// Params 1
// Checksum 0x4de6449b, Offset: 0x6682
// Size: 0x43
function function_73fc13f2febd3a2( cachename )
{
    assert( isdefined( level.commonitem.var_f4a0cd0e44af4832 ) );
    return function_525b81b5b46043f7( cachename, level.commonitem.var_f4a0cd0e44af4832 );
}

// Namespace common_cache
// Params 2
// Checksum 0xceea96cd, Offset: 0x66ce
// Size: 0x199
function function_525b81b5b46043f7( cachename, var_4c34217b8aa62d30 )
{
    if ( isdefined( cachename ) && isdefined( var_4c34217b8aa62d30 ) )
    {
        var_16d763e03ef0bbc = getscriptbundlefieldvalues( "itemspawnzonedef:" + var_4c34217b8aa62d30, [ #"hash_32a95aa45b53f917" ] );
        
        if ( !isdefined( var_16d763e03ef0bbc.var_a72bc938c97bce90 ) )
        {
            return;
        }
        
        var_f67995529827f79 = spawnstruct();
        
        foreach ( cacheentry in var_16d763e03ef0bbc.var_a72bc938c97bce90 )
        {
            if ( cacheentry.scriptkey == getxhash( cachename ) )
            {
                var_f67995529827f79.spawnlist = hashcat( %"itemspawnlist:", cacheentry.itemspawnlist );
                var_f67995529827f79.spawnlistname = cacheentry.itemspawnlist;
                var_f67995529827f79.spawncount = cacheentry.itemspawnquantity;
                assert( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ), "<dev string:x5fa>" + cachename + "<dev string:x608>" + var_4c34217b8aa62d30 + "<dev string:x632>" );
                return var_f67995529827f79;
            }
        }
    }
    
    assertmsg( "<dev string:x667>" + cachename + "<dev string:x684>" + var_4c34217b8aa62d30 + "<dev string:x691>" );
}

// Namespace common_cache
// Params 6
// Checksum 0xdaf16aa9, Offset: 0x6870
// Size: 0x190
function function_25bee1f5701a0786( player, index, newlootid, newquantity, newweapondata, item )
{
    if ( isdefined( player.var_50f741a14f09a6 ) )
    {
        if ( common_inventory::function_614b449545fb220b( index ) )
        {
            player common_inventory::function_5ea342500de9311( index, newquantity );
            return;
        }
        else
        {
            if ( !isdefined( player.var_50f741a14f09a6.contents[ index ] ) )
            {
                player.var_50f741a14f09a6.contents[ index ] = {};
            }
            
            player.var_50f741a14f09a6.contents[ index ].quantity = newquantity;
            
            if ( newquantity <= 0 )
            {
                newlootid = 0;
            }
            
            player.var_50f741a14f09a6.contents[ index ].lootid = newlootid;
        }
        
        player.var_50f741a14f09a6.contents[ index ].weapondata = newweapondata;
        player.var_50f741a14f09a6.contents[ index ].item = item;
        callback::callback( #"hash_43fa020e1f5bd32e", { #quantity:newquantity, #lootid:newlootid, #player:player, #index:index, #cache:player.var_50f741a14f09a6 } );
    }
    
    function_7875275a0511dfeb( player, index, newlootid, newquantity, newweapondata );
}

// Namespace common_cache
// Params 2
// Checksum 0x1ac4ac06, Offset: 0x6a08
// Size: 0x43
function function_430a2732cbe29d15( player, lootid )
{
    if ( isdefined( player ) && isdefined( player.var_50f741a14f09a6 ) )
    {
        player.var_50f741a14f09a6 notify( #"hash_364b1f605f1a6061", lootid, player );
    }
}

// Namespace common_cache
// Params 3
// Checksum 0xa03ec9e5, Offset: 0x6a53
// Size: 0xc4
function function_685c32bf3c155f6d( instance, quantity, lootid )
{
    if ( !isdefined( instance.contents ) )
    {
        instance.contents = [];
    }
    
    if ( !isdefined( lootid ) || lootid == 0 || !isdefined( quantity ) || quantity == 0 )
    {
        instance.contents[ instance.contents.size ] = { #quantity:0, #lootid:0 };
        return;
    }
    
    itembundlename = common_item_database::function_db2360bc1c33f6f9( lootid );
    
    if ( !isdefined( itembundlename ) )
    {
        assertmsg( "<dev string:x6bd>" + lootid + "<dev string:x701>" );
        return;
    }
    
    function_9eba6662d46ad2c6( instance, quantity, itembundlename );
}

// Namespace common_cache
// Params 4
// Checksum 0x7639ec3, Offset: 0x6b1f
// Size: 0x337
function function_9eba6662d46ad2c6( instance, quantity, itembundlename, weapondata )
{
    if ( !isdefined( itembundlename ) )
    {
        assertmsg( "<dev string:x70f>" );
        return;
    }
    
    if ( !isdefined( instance.contents ) )
    {
        instance.contents = [];
    }
    
    if ( !isdefined( quantity ) || quantity == 0 )
    {
        instance.contents[ instance.contents.size ] = { #quantity:0, #lootid:0 };
        return;
    }
    
    var_456fb47f62296078 = getscriptbundlefieldvalues( itembundlename, [ #"spawncount", #"rarity", #"lootitemtype", #"ref", #"scriptable", #"hash_b03f160ecbda0659", #"baseweapon", #"hash_49d54bf7fdc612d4" ] );
    
    if ( !isdefined( var_456fb47f62296078 ) )
    {
        assertmsg( "<dev string:x750>" + getxhashsourcename( itembundlename ) );
        return;
    }
    
    item = spawnstruct();
    item.lootid = common_item::function_779887309ec71dfe( var_456fb47f62296078 );
    
    if ( !isdefined( item.lootid ) )
    {
        assertmsg( "<dev string:x4ea>" + getxhashsourcename( itembundlename ) + "<dev string:x77e>" );
        return;
    }
    
    item.quantity = quantity;
    
    if ( isdefined( var_456fb47f62296078.spawncount ) || isdefined( var_456fb47f62296078.var_d3af3f4e323ff7b0 ) )
    {
        item.quantity = common_item::function_ea3b3088d82fd357( var_456fb47f62296078, { #weapon:weapondata.var_2cb6d045c209a9ff } );
    }
    
    if ( common_item::function_16e8c106491eeaca( var_456fb47f62296078 ) == "weapon" )
    {
        itemweapondata = weapondata ?? spawnstruct();
        itemweapondata.itembundlename = itembundlename;
        
        if ( var_456fb47f62296078.var_d45ad5f713c5ee95 )
        {
            itemweapondata.scriptable = var_456fb47f62296078.scriptable;
            itemweapondata.var_d45ad5f713c5ee95 = var_456fb47f62296078.var_d45ad5f713c5ee95;
        }
        
        itemweapondata.rarity = var_456fb47f62296078.rarity ?? 0;
        itemweapondata.variantid = item_weapon::function_4591efaaa1c03edd( var_456fb47f62296078 );
        itemweapondata.count = item.quantity;
        
        if ( itemweapondata.variantid == 0 )
        {
            attachments = item_weapon::function_860f9afb151019a6( itembundlename );
            
            if ( isdefined( attachments ) && attachments.size > 0 )
            {
                itemweapondata.attachments = attachments;
            }
            
            itemweapondata.rarity = function_f69e65e97212f577( itemweapondata, var_456fb47f62296078 );
        }
        
        if ( isdefined( weapondata ) || isdefined( itemweapondata.rarity ) || isdefined( itemweapondata.attachments ) || itemweapondata.variantid != 0 )
        {
            item.weapondata = itemweapondata;
        }
    }
    
    instance.contents[ instance.contents.size ] = item;
}

// Namespace common_cache
// Params 4
// Checksum 0xf513de76, Offset: 0x6e5e
// Size: 0x61
function fillcontentsfromlist( instance, listbundlename, count, players )
{
    if ( players && players.size > 0 )
    {
        function_e69b07abaa3e643b( instance, listbundlename, count, players );
        return;
    }
    
    function_a136b84fc5c0dfab( instance, hashcat( %"itemspawnlist:", listbundlename ), count, 1 );
}

// Namespace common_cache
// Params 5
// Checksum 0xfdf958c5, Offset: 0x6ec7
// Size: 0xd9
function spawncache( var_2ca20d11c764c548, origin, angles, forcedstate, payload )
{
    var_a16be873299f761b = getscriptbundlefieldvalues( var_2ca20d11c764c548, [ #"scriptable", #"hash_52178cb2f78336c1" ] );
    
    if ( !isdefined( var_a16be873299f761b ) )
    {
        assertmsg( "<dev string:x7a3>" + getxhashsourcename( var_2ca20d11c764c548 ) + "<dev string:x396>" );
        return;
    }
    
    initialstate = var_a16be873299f761b.var_94baf3c752b9ff60 ?? #"closed_usable";
    
    if ( isdefined( forcedstate ) )
    {
        initialstate = forcedstate;
    }
    
    cache = spawnscriptable( var_a16be873299f761b.scriptable, origin, angles, undefined, payload );
    cache setscriptablepartstate( "body", initialstate );
    return cache;
}

// Namespace common_cache
// Params 7
// Checksum 0x24b7e128, Offset: 0x6fa9
// Size: 0x1e6
function function_9bc018c1b8aad720( scriptkey, origin, angles, forcedstate, var_4c34217b8aa62d30, payload, players )
{
    var_16d763e03ef0bbc = undefined;
    
    if ( isdefined( var_4c34217b8aa62d30 ) )
    {
        var_16d763e03ef0bbc = getscriptbundlefieldvalues( "itemspawnzonedef:" + var_4c34217b8aa62d30, [ #"hash_32a95aa45b53f917" ] );
    }
    else
    {
        var_16d763e03ef0bbc = common_item::function_f852430ffb889f14( origin, [ #"hash_32a95aa45b53f917" ] );
    }
    
    if ( !isdefined( var_16d763e03ef0bbc ) )
    {
        /#
            if ( isdefined( var_4c34217b8aa62d30 ) )
            {
                assertmsg( "<dev string:x800>" + getxhashsourcename( scriptkey ) + "<dev string:x83e>" + origin + "<dev string:x84c>" + var_4c34217b8aa62d30 + "<dev string:x396>" );
                return;
            }
            
            assertmsg( "<dev string:x800>" + getxhashsourcename( scriptkey ) + "<dev string:x83e>" + origin + "<dev string:x87d>" );
        #/
        
        return;
    }
    
    foreach ( cacheentry in var_16d763e03ef0bbc.var_a72bc938c97bce90 )
    {
        if ( cacheentry.scriptkey == scriptkey )
        {
            if ( !isdefined( cacheentry.cacheitemspawnentry ) )
            {
                assertmsg( "<dev string:x800>" + getxhashsourcename( scriptkey ) + "<dev string:x8aa>" );
                return;
            }
            
            cache = spawncache( "itemspawnentry:" + cacheentry.cacheitemspawnentry, origin, angles, forcedstate, payload );
            fillcontentsfromlist( cache, cacheentry.itemspawnlist, cacheentry.itemspawnquantity, players );
            return cache;
        }
    }
}

// Namespace common_cache
// Params 6
// Checksum 0x20377795, Offset: 0x7198
// Size: 0x1ec
function function_cc09d3a70f175d1d( itembundlename, origin, angles, forcedstate, var_4c34217b8aa62d30, payload )
{
    var_16d763e03ef0bbc = undefined;
    
    if ( isdefined( var_4c34217b8aa62d30 ) )
    {
        var_16d763e03ef0bbc = getscriptbundlefieldvalues( "itemspawnzonedef:" + var_4c34217b8aa62d30, [ #"hash_2b3533d35fcc1708" ] );
    }
    else
    {
        var_16d763e03ef0bbc = common_item::function_f852430ffb889f14( origin, [ #"hash_2b3533d35fcc1708" ] );
    }
    
    if ( !isdefined( var_16d763e03ef0bbc ) )
    {
        /#
            if ( isdefined( var_4c34217b8aa62d30 ) )
            {
                assertmsg( "<dev string:x8d6>" + itembundlename + "<dev string:x83e>" + origin + "<dev string:x84c>" + var_4c34217b8aa62d30 + "<dev string:x396>" );
                return;
            }
            
            assertmsg( "<dev string:x8d6>" + itembundlename + "<dev string:x83e>" + origin + "<dev string:x87d>" );
        #/
        
        return;
    }
    
    foreach ( cacheentry in var_16d763e03ef0bbc.var_2f3b9a0f877e32b1 )
    {
        if ( cacheentry.cacheitemspawnentry == itembundlename )
        {
            itembundle = getscriptbundle( hashcat( %"itemspawnentry:", cacheentry.cacheitemspawnentry ) );
            
            if ( !isdefined( itembundle ) )
            {
                assertmsg( "<dev string:x8d6>" + itembundlename + "<dev string:x918>" );
                return;
            }
            
            cache = spawncache( "itemspawnentry:" + cacheentry.cacheitemspawnentry, origin, angles, forcedstate, payload );
            fillcontentsfromlist( cache, cacheentry.cacheitemspawnlist, cacheentry.var_fc47c362d6d23c22 );
            return cache;
        }
    }
}

// Namespace common_cache
// Params 6
// Checksum 0xa1ae6b9f, Offset: 0x738d
// Size: 0x90
function function_74364c32a1e82886( var_343cb5a98d11a0a2, origin, radius, hintstring, hintstringarg, var_6d213fd91d3cd184 )
{
    interact = interaction::register_interact( origin, radius, &function_4cf6a3c4374a7ae3, hintstring, hintstringarg, var_6d213fd91d3cd184 );
    interact.cache = { #dontclose:1, #origin:origin };
    function_8e78605bd608beb8( interact.cache, var_343cb5a98d11a0a2 );
    return interact;
}

// Namespace common_cache
// Params 1
// Checksum 0x349aedfd, Offset: 0x7426
// Size: 0x37
function function_4cf6a3c4374a7ae3( player )
{
    if ( isplayer( player ) && !player.interactions_disabled )
    {
        openlootablecontainer( self.cache, player );
    }
}

// Namespace common_cache
// Params 2
// Checksum 0x88613165, Offset: 0x7465
// Size: 0x95
function function_98861c0455f4e01f( items, cache )
{
    foreach ( item in items )
    {
        if ( !isdefined( item ) )
        {
            continue;
        }
        
        function_9eba6662d46ad2c6( cache, 1, item );
    }
}

// Namespace common_cache
// Params 2, eflags: 0x4
// Checksum 0x5bd9a28b, Offset: 0x7502
// Size: 0x94
function private function_3fca4ed4a61b1996( player, weaponobj )
{
    if ( isweapon( weaponobj ) )
    {
        weaponmaphandle = function_646cc662db6a3fe0( item_weapon::function_f75620a38a24072() ?? %"obloot_custom_weapon", weaponobj );
        
        if ( isdefined( weaponmaphandle ) && weaponmaphandle != 0 )
        {
            if ( isdefined( player.var_673ba85cad1c850 ) )
            {
                player.var_673ba85cad1c850[ player.var_673ba85cad1c850.size ] = weaponmaphandle;
            }
            else
            {
                player.var_673ba85cad1c850 = [ weaponmaphandle ];
            }
            
            return weaponmaphandle;
        }
    }
    
    return 0;
}

// Namespace common_cache
// Params 1, eflags: 0x4
// Checksum 0x890d1ae2, Offset: 0x759f
// Size: 0xa3
function private function_9c14b82a97b31e5a( player )
{
    if ( !isdefined( player.var_673ba85cad1c850 ) )
    {
        return;
    }
    
    foreach ( weaponmaphandle in player.var_673ba85cad1c850 )
    {
        function_a76fdf4e079af7be( weaponmaphandle );
    }
    
    player.var_673ba85cad1c850 = [];
}

// Namespace common_cache
// Params 2, eflags: 0x4
// Checksum 0xefae45a2, Offset: 0x764a
// Size: 0x93
function private function_41f8623757b80c63( lootid, extrapayload )
{
    bitsused = 31;
    
    if ( bitsused > 31 )
    {
        assertmsg( "<dev string:x940>" );
        return 0;
    }
    
    if ( !isdefined( lootid ) )
    {
        lootid = 0;
    }
    
    assert( lootid >= 0 && lootid < 1048576 );
    
    if ( !isdefined( extrapayload ) )
    {
        extrapayload = 0;
    }
    
    assert( extrapayload >= 0 && extrapayload < 2048 );
    var_b8f3420a16148f7c = extrapayload;
    var_b8f3420a16148f7c <<= 20;
    var_b8f3420a16148f7c |= lootid;
    return var_b8f3420a16148f7c;
}

// Namespace common_cache
// Params 1, eflags: 0x4
// Checksum 0xa6b22d24, Offset: 0x76e6
// Size: 0x96
function private function_584f0ee77732c912( var_b8f3420a16148f7c )
{
    bitsused = 31;
    
    if ( bitsused > 31 )
    {
        assertmsg( "<dev string:x940>" );
        return;
    }
    
    var_7f6e840760efcf1 = spawnstruct();
    lootidmask = 1048575;
    var_7f6e840760efcf1.lootid = lootidmask & var_b8f3420a16148f7c;
    var_b8f3420a16148f7c >>= 20;
    var_9815cf02010e0eae = 2047;
    var_7f6e840760efcf1.extrapayload = var_9815cf02010e0eae & var_b8f3420a16148f7c;
    var_b8f3420a16148f7c >>= 11;
    assert( var_b8f3420a16148f7c == 0 );
    return var_7f6e840760efcf1;
}

// Namespace common_cache
// Params 0
// Checksum 0xb46b94bd, Offset: 0x7785
// Size: 0x61
function function_4614af47ed74937b()
{
    if ( !isdefined( level.var_1dec6cece65fd66 ) )
    {
        if ( getdvarint( @"hash_f3e94854302608a0", 0 ) )
        {
            level.var_1dec6cece65fd66 = 0;
        }
        else
        {
            level.var_1dec6cece65fd66 = isdefined( level.gametypebundle ) && level.gametypebundle.var_b4710c47017571c0;
        }
    }
    
    return level.var_1dec6cece65fd66;
}

// Namespace common_cache
// Params 0
// Checksum 0xe89a5c5a, Offset: 0x77ef
// Size: 0x42
function function_3d497f36c1ac217d()
{
    if ( !isdefined( level.var_bf850d645b84c69c ) )
    {
        level.var_bf850d645b84c69c = !getdvarint( @"hash_48bded9af4a20010", istrue( level.gametypebundle.var_996d5dd5d7c7352b ) );
    }
    
    return level.var_bf850d645b84c69c;
}

// Namespace common_cache
// Params 0
// Checksum 0x2a27d6cb, Offset: 0x783a
// Size: 0x24
function function_705da5a7c1cc2b41()
{
    if ( !isdefined( level.gametypebundle ) )
    {
        return;
    }
    
    return level.gametypebundle.decisionlayergroup;
}

// Namespace common_cache
// Params 0
// Checksum 0xedcf6f7e, Offset: 0x7867
// Size: 0x12
function function_cd864dbca60b4577()
{
    return level.inventorygroupings[ "CONTAINER" ].size;
}

// Namespace common_cache
// Params 1
// Checksum 0x3b7de8c8, Offset: 0x7882
// Size: 0x3f
function function_62d95810cae876df( cache )
{
    if ( isdefined( cache.inventorygroup ) )
    {
        return ( cache.inventorygroup.index + 1 );
    }
    
    return cache.containertype;
}

// Namespace common_cache
// Params 1
// Checksum 0xe629d0ef, Offset: 0x78ca
// Size: 0x97
function function_e1edd53f20e103f( params )
{
    if ( !( isdefined( params.item ) && isdefined( params.itembundle ) ) )
    {
        return;
    }
    
    itemtype = common_item::function_16e8c106491eeaca( params.itembundle );
    
    if ( itemtype != "cache" )
    {
        return;
    }
    
    state = params.itembundle.var_94baf3c752b9ff60 ?? #"closed_usable";
    params.item setscriptablepartstate( "body", state );
}

// Namespace common_cache
// Params 2
// Checksum 0xfa2dbdbc, Offset: 0x7969
// Size: 0x211
function function_7afda593c8230cf4( cache, player )
{
    if ( !isdefined( cache.contents ) )
    {
        return;
    }
    
    var_3dd4c29610109a3f = [];
    
    for ( itemindex = 0; itemindex < 55 ; itemindex++ )
    {
        if ( !isdefined( cache.contents[ itemindex ] ) )
        {
            continue;
        }
        
        if ( cache.contents[ itemindex ].lootid == 0 || cache.contents[ itemindex ].quantity == 0 )
        {
            continue;
        }
        
        if ( cache.contents[ itemindex ].item.critical || cache.contents[ itemindex ].item.additionaldata.critical )
        {
            continue;
        }
        
        if ( cache.contents[ itemindex ].item.var_6f072442f0dfe379 )
        {
            continue;
        }
        
        var_3dd4c29610109a3f[ itemindex ] = structcopy( cache.contents[ itemindex ] );
    }
    
    params = { #player:player, #items:var_3dd4c29610109a3f, #cache:cache };
    level callback::callback( #"hash_c7de421fb16ff532", params );
    
    foreach ( itemindex, _ in var_3dd4c29610109a3f )
    {
        cache.contents[ itemindex ] = undefined;
        
        if ( isdefined( player ) && player function_e3795ef6fb5d5a82() && player.var_50f741a14f09a6 === cache )
        {
            function_8632ef63c71b6048( player, itemindex );
        }
    }
}

// Namespace common_cache
// Params 1
// Checksum 0xaa23fca, Offset: 0x7b82
// Size: 0x30, Type: bool
function function_6f6c9f1260e96e23( cache )
{
    return cache.var_55c4b88997344176 && cache.inventorygroup.var_e0bb9885a6ae0be0;
}

// Namespace common_cache
// Params 1, eflags: 0x4
// Checksum 0x2655ec99, Offset: 0x7bbb
// Size: 0x53
function private function_41e661720a93d68b( container )
{
    if ( !( isdefined( container ) && isdefined( container.revealedslots ) ) )
    {
        return;
    }
    
    for ( i = 0; i < 55 ; i++ )
    {
        if ( !container.revealedslots[ i ] )
        {
            return i;
        }
    }
}

// Namespace common_cache
// Params 1, eflags: 0x4
// Checksum 0x1b86e197, Offset: 0x7c17
// Size: 0x5a2
function private function_8f2230e30fb63ee( player )
{
    if ( !function_4614af47ed74937b() || !( isdefined( self ) && isdefined( player ) ) )
    {
        /#
            level notify( #"container_revealed" );
        #/
        
        return;
    }
    
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"closed" );
    player endon( #"disconnect" );
    player setclientomnvar( "loot_container_revealed_state", 0 );
    
    if ( !isdefined( self.revealedslots ) )
    {
        self.revealedslots = [];
    }
    
    for ( i = 0; i < 55 ; i++ )
    {
        lootid = function_8a794a103f67b684( self, i );
        quantity = function_8fcbeea1c8dee7fe( self, i );
        revealedstate = 0;
        
        if ( self.revealedslots[ i ] || lootid == 0 || quantity == 0 )
        {
            self.revealedslots[ i ] = 1;
            revealedstate = 2;
        }
        
        player setclientomnvar( "loot_container_revealed_" + i, revealedstate );
    }
    
    revealtime = isdefined( level.gametypebundle ) ? level.gametypebundle.var_89a76b9451023eba : 0;
    revealtime = getdvarfloat( @"hash_2ee7830659882bf8", revealtime ) / 1000;
    firstpass = 1;
    initialdelay = isdefined( level.gametypebundle ) ? level.gametypebundle.var_afe1c250c94734e4 : 0;
    initialdelay = getdvarfloat( @"hash_78ee249aa0a3ac4c", initialdelay ) / 1000;
    
    if ( initialdelay > 0 )
    {
        wait initialdelay;
    }
    
    player setclientomnvar( "loot_container_revealed_state", 1 );
    
    for ( var_2cc4d4a143268f7a = 0; true ; var_2cc4d4a143268f7a++ )
    {
        slotindex = function_41e661720a93d68b( self );
        
        if ( !isdefined( slotindex ) )
        {
            break;
        }
        
        lootid = function_8a794a103f67b684( self, slotindex );
        quantity = isdefined( self.contents ) && isdefined( self.contents[ slotindex ] ) ? self.contents[ slotindex ].quantity : undefined;
        perkadded = isdefined( self.contents ) && isdefined( self.contents[ slotindex ] ) ? self.contents[ slotindex ].perkadded : undefined;
        weapondata = isdefined( self.contents ) && isdefined( self.contents[ slotindex ] ) ? self.contents[ slotindex ].weapondata : undefined;
        itembundle = common_item::function_b202b16941992cca( lootid, [ #"rarity", #"subtype", #"lootitemtype" ] );
        waittime = function_b0227ea507886ba7( itembundle, quantity, weapondata ) ?? revealtime;
        player setclientomnvar( "loot_container_revealed_" + slotindex, perkadded ? 3 : 1 );
        wait waittime * ( 1 - player function_4622b176d5424bed() );
        player setclientomnvar( "loot_container_revealed_" + slotindex, 2 );
        self.revealedslots[ slotindex ] = 1;
        raritybundle = common_item::function_b7eae989f62fad46( itembundle );
        
        if ( raritybundle.revealsfx )
        {
            player playlocalsound( raritybundle.revealsfx );
        }
        
        if ( firstpass )
        {
            revealoffset = isdefined( level.gametypebundle ) ? level.gametypebundle.var_6b2a8643a7e40d30 : 0;
            
            if ( !isdefined( revealoffset ) )
            {
                revealoffset = 0;
            }
            
            revealoffset = getdvarfloat( @"hash_d5c00e3857e8d33e", revealoffset ) / 1000;
            revealtime += revealoffset;
            firstpass = 0;
        }
    }
    
    player setclientomnvar( "loot_container_revealed_state", 2 );
    allowautoloot = 1;
    var_b093e03044c4343e = common_item::function_33a2c00e46263d99( self );
    
    if ( var_b093e03044c4343e )
    {
        allowautoloot = getscriptbundlefieldvalue( var_b093e03044c4343e, #"hash_c3b6f08cc4cd161f" ) ?? 1;
    }
    
    if ( function_3d497f36c1ac217d() && allowautoloot )
    {
        autopickuptime = level.gametypebundle.var_ce0b12afaf7cfc97 ?? 0;
        autopickuptime = getdvarfloat( @"hash_f028e971145dd60", autopickuptime ) / 1000;
        delaypickuptime = level.gametypebundle.var_2fc476780f1b50fb ?? 0;
        delaypickuptime = getdvarfloat( @"hash_eb9971b69380906c", delaypickuptime ) / 1000;
        
        if ( var_2cc4d4a143268f7a <= 1 )
        {
            delaypickuptime = max( delaypickuptime, autopickuptime );
        }
        
        if ( delaypickuptime )
        {
            wait delaypickuptime;
        }
        
        for ( i = 0; i < 55 ; i++ )
        {
            lootid = function_8a794a103f67b684( self, i );
            startingquantity = function_8fcbeea1c8dee7fe( self, i );
            
            if ( lootid == 0 || startingquantity == 0 )
            {
                continue;
            }
            
            itembundle = common_item::function_b202b16941992cca( lootid, [ #"autopickupenabled" ] );
            
            if ( !itembundle.autopickupenabled )
            {
                continue;
            }
            
            function_a06f5ca9e028aaf3( player, i, undefined, undefined, self, 1 );
            resultlootid = function_8a794a103f67b684( self, i );
            resultquantity = function_8fcbeea1c8dee7fe( self, i );
            
            if ( resultlootid == 0 || startingquantity != resultquantity && autopickuptime )
            {
                wait autopickuptime;
            }
        }
    }
    
    /#
        level notify( #"container_revealed" );
    #/
}

// Namespace common_cache
// Params 2
// Checksum 0x11ad2806, Offset: 0x81c1
// Size: 0x43
function modifyplayerloottime( modref, value )
{
    if ( !isdefined( self.var_17ee944cadaca3f4 ) )
    {
        self.var_17ee944cadaca3f4 = [];
    }
    
    if ( value == 0 )
    {
        value = undefined;
    }
    
    self.var_17ee944cadaca3f4[ modref ] = value;
}

// Namespace common_cache
// Params 0
// Checksum 0xce7f16c7, Offset: 0x820c
// Size: 0x96
function function_4622b176d5424bed()
{
    lootmod = 0;
    
    if ( !isdefined( self.var_17ee944cadaca3f4 ) )
    {
        return lootmod;
    }
    
    foreach ( mod in self.var_17ee944cadaca3f4 )
    {
        lootmod += mod;
    }
    
    return lootmod;
}

// Namespace common_cache
// Params 3
// Checksum 0x2255a956, Offset: 0x82ab
// Size: 0xa7
function function_b0227ea507886ba7( itembundle, quantity, weapondata )
{
    if ( !itembundle )
    {
        return;
    }
    
    raritybundle = undefined;
    
    if ( weapondata.rarity )
    {
        raritybundle = level.commonitem.raritydefs[ weapondata.rarity ];
    }
    
    if ( !raritybundle )
    {
        raritybundle = common_item::function_b7eae989f62fad46( itembundle, quantity );
    }
    
    if ( !isdefined( raritybundle.lootrevealtime ) || itembundle.subtype == "crunchable" )
    {
        return;
    }
    
    return raritybundle.lootrevealtime / 1000;
}

// Namespace common_cache
// Params 1
// Checksum 0xd817283, Offset: 0x835b
// Size: 0x15, Type: bool
function cache_isopen( cache )
{
    return !cache_isclosed( cache );
}

// Namespace common_cache
// Params 1
// Checksum 0x6f09bffe, Offset: 0x8379
// Size: 0x67, Type: bool
function cache_isclosed( cache )
{
    assert( cache getscriptablehaspart( "<dev string:x3e>" ), "<dev string:x996>" );
    state = cache getscriptablepartstate( "body" );
    return state == #"closed_usable" || state == #"closed_usable_no_collision" || state == #"lege_closed_usable";
}

// Namespace common_cache
// Params 4
// Checksum 0xfc9cd374, Offset: 0x83e9
// Size: 0x196
function function_54a2baa02d8610a( location, radius, var_ef6031eca004812, var_9e4c2a780c4c1858 )
{
    scriptables = getentitylessscriptablearray( undefined, undefined, location, radius, "body" );
    
    if ( isarray( var_ef6031eca004812 ) )
    {
        temp = [];
        
        foreach ( cache in scriptables )
        {
            if ( arraycontains( var_ef6031eca004812, cache.type ) )
            {
                temp[ temp.size ] = cache;
            }
        }
        
        scriptables = temp;
    }
    
    excludecount = 0;
    
    if ( var_9e4c2a780c4c1858 )
    {
        wontrestock = [];
        
        foreach ( cache in scriptables )
        {
            if ( cache.var_20371c57bb2d341d )
            {
                wontrestock[ wontrestock.size ] = cache;
            }
        }
        
        wontrestock = utility::function_5fdf0884f9b2d470( wontrestock, &cache_isopen );
        excludecount = wontrestock.size;
    }
    else
    {
        scriptables = utility::function_5fdf0884f9b2d470( scriptables, &cache_isclosed );
    }
    
    return scriptables.size - excludecount;
}

// Namespace common_cache
// Params 2
// Checksum 0x99887889, Offset: 0x8588
// Size: 0x169
function function_61ef9e0b74e10aaf( cache, itemnames )
{
    if ( !itemnames || !itemnames.size || !cache.inventorygroup.variants || !cache.inventorygroup.variants.size )
    {
        return;
    }
    
    weapcount = 0;
    
    foreach ( itemname in itemnames )
    {
        itembundle = common_item::function_90c3e0c1fd55d6b6( itemname );
        typeref = common_item::function_16e8c106491eeaca( itembundle );
        
        if ( typeref == "weapon" )
        {
            weapcount++;
        }
    }
    
    if ( !weapcount )
    {
        return;
    }
    
    variant = cache.inventorygroup.variants[ weapcount - 1 ] ?? cache.inventorygroup.variants[ 0 ];
    
    if ( !variant.weapongroup )
    {
        return;
    }
    
    function_8e78605bd608beb8( cache, variant.weapongroup );
}

// Namespace common_cache
// Params 2, eflags: 0x4
// Checksum 0x5cc8af6, Offset: 0x86f9
// Size: 0x7f
function private function_f69e65e97212f577( weapondata, itembundle )
{
    if ( weapondata.attachments )
    {
        rarityindex = function_fece2e54f76c2761( weapondata.attachments.size );
        raritydef = level.commonitem.raritydefs[ rarityindex ];
        
        if ( raritydef.var_c48c3fa596232d32 )
        {
            return rarityindex;
        }
    }
    
    return itembundle.rarity ?? 0;
}

// Namespace common_cache
// Params 1
// Checksum 0xeb2b4546, Offset: 0x8781
// Size: 0x1e2
function smartloot( container )
{
    if ( !level.gametypebundle.var_2d66933aab6e1cfe )
    {
        return;
    }
    
    if ( !isdefined( self.smartloot ) )
    {
        self.smartloot = [];
    }
    
    var_13595fa0d2d1f716 = [];
    
    foreach ( entry in level.gametypebundle.var_f0425dab33462824 )
    {
        if ( container.type == entry.lootscriptable )
        {
            var_13595fa0d2d1f716[ var_13595fa0d2d1f716.size ] = entry.ref;
        }
    }
    
    if ( isdefined( level.smartloot.reqfunc[ "healthContainer" ] ) && self [[ level.smartloot.reqfunc[ "healthContainer" ] ]]() && arraycontains( var_13595fa0d2d1f716, "HEALTH_ITEMS" ) )
    {
        index = "healthContainer";
        
        if ( !isdefined( self.smartloot[ index ] ) )
        {
            self.smartloot[ index ] = 0;
        }
        
        self.smartloot[ index ] += modified_values::function_14d05d73e63e1f9e( 7, level.gametypebundle.var_4154f5c4a4512cec );
        
        if ( utility::percent_chance( self.smartloot[ index ] ) )
        {
            self.smartloot[ index ] = 0;
            itemlist = common_item::function_3c24841536dc783e( "HEALTH_ITEMS" );
            
            if ( isdefined( itemlist ) )
            {
                return function_c11af7a197679429( itemlist, 1 );
            }
            
            return;
        }
    }
}

// Namespace common_cache
// Params 5
// Checksum 0xc2a1b934, Offset: 0x896c
// Size: 0x377
function function_acae7643c0cdeeb4( containertype, containerposition, items, containerindex, containerangles )
{
    player = self;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    var_393274955cf19848 = "";
    
    foreach ( item in items )
    {
        if ( !isstruct( item ) )
        {
            continue;
        }
        
        var_393274955cf19848 += "||count:" + ( item.quantity ?? -1 );
        var_393274955cf19848 += "|type:" + ( utility::callsharedfunc( #"item", #"hash_7c5f2583a47f342f", item.lootid ) ?? "none" );
        var_393274955cf19848 += "|itemid:" + ( string( item.lootid ) ?? "none" );
    }
    
    eventparams = [ "container_type", containertype ?? "none", "container_index", containerindex ?? -1, "closest_poi", poi::function_c14b808f44505866( containerposition ) ?? "none", "cache_position_x", containerposition[ 0 ] ?? 0, "cache_position_y", containerposition[ 1 ] ?? 0, "cache_position_z", containerposition[ 2 ] ?? 0, "player_origin_x", player.origin[ 0 ], "player_origin_y", player.origin[ 1 ], "player_origin_z", player.origin[ 2 ], "player_angles_yaw", player.angles[ 1 ], "cache_angles_yaw", containerangles[ 1 ] ?? 0, "player_health", player.health ?? -1, "player_armor", player.armorhealth ?? -1, "player_stance", player getstance() ?? "none", "is_player_bot", isbot( player ) || player isplayerheadless() ?? "none", "server_time", gettime(), "circle_index", isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) ? level.br_circle.circleindex : -1, "playlist_id", getplaylistid(), "playlist_name", getplaylistname(), "container_items", var_393274955cf19848 ?? "" ];
    player dlog_recordplayerevent( "dlog_event_common_cache_opened", eventparams );
}

/#

    // Namespace common_cache
    // Params 0, eflags: 0x4
    // Checksum 0x995a563d, Offset: 0x8ceb
    // Size: 0x742, Type: dev
    function private setup_devgui()
    {
        if ( getdvarint( @"debug_common_item", 1 ) == 0 )
        {
            return;
        }
        
        devgui::function_9082edeb5db93280( "<dev string:x9c7>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x9e8>", "<dev string:x9ea>", &function_29b47b29307576fe );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa00>", "<dev string:xa02>", &function_29b47b29307576fe );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa18>", "<dev string:xa1a>", &function_29b47b29307576fe );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa30>", "<dev string:xa32>", &function_29b47b29307576fe );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa48>", "<dev string:xa4a>", &function_29b47b29307576fe );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa60>", "<dev string:xa62>", &function_29b47b29307576fe );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa78>", "<dev string:xa7a>", &function_29b47b29307576fe );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa90>", "<dev string:xa92>", &function_29b47b29307576fe );
        devgui::function_cd4e263c1f3018ae( "<dev string:xaa8>", "<dev string:xaaa>", &function_29b47b29307576fe );
        devgui::function_cd4e263c1f3018ae( "<dev string:xac0>", "<dev string:xac3>", &function_29b47b29307576fe );
        devgui::function_cd4e263c1f3018ae( "<dev string:xada>", "<dev string:xadd>", &function_29b47b29307576fe );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:xaf4>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:xb1a>", "<dev string:xb1c>", &function_24c38ce1e851c7a7 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x9e8>", "<dev string:xb32>", &function_24c38ce1e851c7a7 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa00>", "<dev string:xb48>", &function_24c38ce1e851c7a7 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa18>", "<dev string:xb5e>", &function_24c38ce1e851c7a7 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa30>", "<dev string:xb74>", &function_24c38ce1e851c7a7 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa48>", "<dev string:xb8a>", &function_24c38ce1e851c7a7 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa60>", "<dev string:xba0>", &function_24c38ce1e851c7a7 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa78>", "<dev string:xbb6>", &function_24c38ce1e851c7a7 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa90>", "<dev string:xbcc>", &function_24c38ce1e851c7a7 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xaa8>", "<dev string:xbe2>", &function_24c38ce1e851c7a7 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xac0>", "<dev string:xbf8>", &function_24c38ce1e851c7a7 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xada>", "<dev string:xc0f>", &function_24c38ce1e851c7a7 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:xc26>" );
        devgui::add_devgui_func( "<dev string:xc3a>", "<dev string:xc4d>", &function_5649f2339c0e2387 );
        devgui::add_devgui_func( "<dev string:xc60>", "<dev string:xc71>", &function_dcffd6035b41536b );
        devgui::add_devgui_func( "<dev string:xc82>", "<dev string:xc9e>", &function_912931445e3f071a );
        devgui::add_devgui_func( "<dev string:xcbb>", "<dev string:xcda>", &function_36f7fe8ac7a24117 );
        devgui::function_77df7fe7dd273e10();
        var_ad860309c52ece07 = level.gametypebundle.var_3842463aacfdc5ca;
        
        foreach ( var_4d6e1c3239583df2 in level.gametypebundle.var_f1c87cb6c2385550 )
        {
            if ( isdefined( var_4d6e1c3239583df2.map ) )
            {
                mapinfobundle = getmapinfobundle( var_4d6e1c3239583df2.map );
                
                if ( mapinfobundle.mapname == level.mapname )
                {
                    var_ad860309c52ece07 = var_4d6e1c3239583df2.zones;
                    break;
                }
            }
        }
        
        if ( isdefined( var_ad860309c52ece07 ) )
        {
            zonelist = getscriptbundle( var_ad860309c52ece07 );
            
            if ( isdefined( zonelist ) )
            {
                foreach ( var_2bc5b074bc2c1f55 in zonelist.zonedefs )
                {
                    if ( !( isdefined( var_2bc5b074bc2c1f55.zonename ) && isdefined( var_2bc5b074bc2c1f55.zonedef ) ) )
                    {
                        continue;
                    }
                    
                    var_6f1fab09e4a30dcb = getscriptbundlefieldvalues( "<dev string:xcf9>" + var_2bc5b074bc2c1f55.zonedef, [ #"hash_2b3533d35fcc1708", #"hash_bff3a5161bb0e294", #"hash_32a95aa45b53f917" ] );
                    
                    if ( isdefined( var_6f1fab09e4a30dcb.var_2f3b9a0f877e32b1 ) )
                    {
                        foreach ( var_ad136796f2e59c96 in var_6f1fab09e4a30dcb.var_2f3b9a0f877e32b1 )
                        {
                            if ( isdefined( var_ad136796f2e59c96.var_fc47c362d6d23c22 ) && isdefined( var_ad136796f2e59c96.cacheitemspawnlist ) && isdefined( var_ad136796f2e59c96.cacheitemspawnentry ) )
                            {
                                function_ea1b7551b74eab4b( var_ad136796f2e59c96.cacheitemspawnentry, var_ad136796f2e59c96.cacheitemspawnentry, var_2bc5b074bc2c1f55.zonename, "<dev string:xd0b>", var_ad136796f2e59c96.cacheitemspawnlist, var_ad136796f2e59c96.var_fc47c362d6d23c22 );
                            }
                        }
                    }
                    
                    if ( isdefined( var_6f1fab09e4a30dcb.var_6438189894f8f515 ) )
                    {
                        foreach ( var_ad136796f2e59c96 in var_6f1fab09e4a30dcb.var_6438189894f8f515 )
                        {
                            if ( isdefined( var_ad136796f2e59c96.var_fc47c362d6d23c22 ) && isdefined( var_ad136796f2e59c96.cacheitemspawnlist ) && isdefined( var_ad136796f2e59c96.cacheitemspawnentry ) )
                            {
                                function_ea1b7551b74eab4b( var_ad136796f2e59c96.cacheitemspawnentry, var_ad136796f2e59c96.cacheitemspawnentry, var_2bc5b074bc2c1f55.zonename, "<dev string:xd13>", var_ad136796f2e59c96.cacheitemspawnlist, var_ad136796f2e59c96.var_fc47c362d6d23c22 );
                            }
                        }
                    }
                    
                    if ( isdefined( var_6f1fab09e4a30dcb.var_a72bc938c97bce90 ) )
                    {
                        foreach ( var_ad136796f2e59c96 in var_6f1fab09e4a30dcb.var_a72bc938c97bce90 )
                        {
                            if ( isdefined( var_ad136796f2e59c96.itemspawnquantity ) && isdefined( var_ad136796f2e59c96.itemspawnlist ) && isdefined( var_ad136796f2e59c96.cacheitemspawnentry ) )
                            {
                                function_ea1b7551b74eab4b( var_ad136796f2e59c96.cacheitemspawnentry, getxhashsourcename( var_ad136796f2e59c96.scriptkey ), var_2bc5b074bc2c1f55.zonename, "<dev string:xd19>", var_ad136796f2e59c96.itemspawnlist, var_ad136796f2e59c96.itemspawnquantity );
                            }
                        }
                    }
                }
            }
        }
    }

    // Namespace common_cache
    // Params 1
    // Checksum 0x8cdf74e3, Offset: 0x9435
    // Size: 0x1f, Type: dev
    function function_29b47b29307576fe( params )
    {
        level.var_6de02274b052182 = int( params[ 0 ] );
    }

    // Namespace common_cache
    // Params 0
    // Checksum 0xec5a14ac, Offset: 0x945c
    // Size: 0x4b, Type: dev
    function function_5649f2339c0e2387()
    {
        if ( !isdefined( level.var_1dec6cece65fd66 ) )
        {
            level.var_1dec6cece65fd66 = function_4614af47ed74937b();
        }
        
        level.var_1dec6cece65fd66 = !level.var_1dec6cece65fd66;
        setdvar( @"hash_f3e94854302608a0", !level.var_1dec6cece65fd66 );
    }

    // Namespace common_cache
    // Params 0
    // Checksum 0xfe6f1400, Offset: 0x94af
    // Size: 0x18, Type: dev
    function function_dcffd6035b41536b()
    {
        level.var_bf850d645b84c69c = !level.var_bf850d645b84c69c;
    }

    // Namespace common_cache
    // Params 0
    // Checksum 0xd52f522c, Offset: 0x94cf
    // Size: 0x3b, Type: dev
    function function_912931445e3f071a()
    {
        if ( getdvarint( @"hash_82b5f4eccb13d4d2", 0 ) == 1 )
        {
            setdvar( @"hash_82b5f4eccb13d4d2", 0 );
            return;
        }
        
        setdvar( @"hash_82b5f4eccb13d4d2", 1 );
    }

    // Namespace common_cache
    // Params 0
    // Checksum 0x452b7e1f, Offset: 0x9512
    // Size: 0x3b, Type: dev
    function function_36f7fe8ac7a24117()
    {
        if ( getdvarint( @"hash_82b5f4eccb13d4d2", 0 ) == 2 )
        {
            setdvar( @"hash_82b5f4eccb13d4d2", 0 );
            return;
        }
        
        setdvar( @"hash_82b5f4eccb13d4d2", 2 );
    }

    // Namespace common_cache
    // Params 6
    // Checksum 0xc81ec771, Offset: 0x9555
    // Size: 0x298, Type: dev
    function function_ea1b7551b74eab4b( itembundlename, cachename, zonename, spawntype, listbundlename, rollquantity )
    {
        if ( getdvarint( @"debug_common_item", 1 ) == 0 )
        {
            return;
        }
        
        cleanname = common_item::clean_name( itembundlename );
        
        if ( !isdefined( cachename ) )
        {
            cachename = cleanname;
        }
        
        if ( !isdefined( zonename ) )
        {
            zonename = "<dev string:xd20>";
        }
        
        if ( !isdefined( spawntype ) )
        {
            spawntype = "<dev string:xd25>";
        }
        
        if ( !isdefined( level.commonitemdebug ) )
        {
            level.commonitemdebug = {};
        }
        
        if ( !isdefined( level.commonitemdebug.cachedevgui ) )
        {
            level.commonitemdebug.cachedevgui = [];
        }
        
        if ( !isdefined( level.commonitemdebug.cachedevgui[ zonename ] ) )
        {
            level.commonitemdebug.cachedevgui[ zonename ] = { #types:[], #generated:0 };
            devgui::function_cd4e263c1f3018ae( "<dev string:xd27>" + zonename, "<dev string:xd42>" + zonename, &function_d28f3dd145557f80, 0, 0 );
        }
        
        if ( !isdefined( level.commonitemdebug.cachedevgui[ zonename ].types[ spawntype ] ) )
        {
            level.commonitemdebug.cachedevgui[ zonename ].types[ spawntype ] = { #caches:[], #generated:0 };
        }
        
        if ( !isdefined( level.commonitemdebug.cachedevgui[ zonename ].types[ spawntype ].caches[ cachename ] ) )
        {
            level.commonitemdebug.cachedevgui[ zonename ].types[ spawntype ].caches[ cachename ] = { #quantity:rollquantity, #list:listbundlename, #bundlename:cleanname, #generated:0 };
        }
        
        if ( level.commonitemdebug.cachedevgui[ zonename ].generated )
        {
            if ( level.commonitemdebug.cachedevgui[ zonename ].types[ spawntype ].generated )
            {
                function_d28f3dd145557f80( [ zonename, spawntype, cachename ] );
                return;
            }
            
            function_d28f3dd145557f80( [ zonename, spawntype ] );
        }
    }

    // Namespace common_cache
    // Params 1
    // Checksum 0xfcfd334a, Offset: 0x97f5
    // Size: 0x644, Type: dev
    function function_d28f3dd145557f80( params )
    {
        zonename = params[ 0 ];
        spawntype = params[ 1 ];
        cachename = params[ 2 ];
        
        if ( isdefined( cachename ) )
        {
            if ( level.commonitemdebug.cachedevgui[ zonename ].types[ spawntype ].caches[ cachename ].generated )
            {
                return;
            }
            
            level.commonitemdebug.cachedevgui[ zonename ].types[ spawntype ].caches[ cachename ].generated = 1;
            devguimenu = "<dev string:xd27>" + zonename + "<dev string:xd65>" + ( spawntype != "<dev string:xd25>" ? spawntype + "<dev string:xd65>" : "<dev string:xd67>" ) + cachename + "<dev string:xd68>";
            devgui::add_debug_command( "<dev string:xd6b>" + devguimenu + "<dev string:xd7b>" );
            cachebundlename = getxhashsourcename( level.commonitemdebug.cachedevgui[ zonename ].types[ spawntype ].caches[ cachename ].bundlename );
            devgui::function_cd4e263c1f3018ae( devguimenu + "<dev string:xd7e>", "<dev string:xd8b>" + cachebundlename, &debug_spawn_cache, 0, 0 );
            devgui::function_cd4e263c1f3018ae( devguimenu + "<dev string:xd98>", "<dev string:xdb1>" + cachebundlename, &function_8c81d3dbbc5965ca, 0, 1 );
            
            if ( isdefined( level.commonitemdebug.cachedevgui[ zonename ].types[ spawntype ].caches[ cachename ].list ) )
            {
                listbundlename = level.commonitemdebug.cachedevgui[ zonename ].types[ spawntype ].caches[ cachename ].list;
                spawnquantity = level.commonitemdebug.cachedevgui[ zonename ].types[ spawntype ].caches[ cachename ].quantity ?? 1;
                devgui::function_cd4e263c1f3018ae( devguimenu + "<dev string:xdd0>", "<dev string:xd8b>" + cachebundlename + "<dev string:xdde>" + listbundlename + "<dev string:xdde>" + spawnquantity, &debug_spawn_cache, 0, 2 );
                devgui::function_cd4e263c1f3018ae( devguimenu + "<dev string:xde0>", "<dev string:xdeb>" + cachebundlename + "<dev string:xdde>" + listbundlename + "<dev string:xdde>" + spawnquantity, &function_57a122759a2ac452, 0, 3 );
                devgui::function_cd4e263c1f3018ae( devguimenu + "<dev string:xdfc>", "<dev string:xe13>" + cachebundlename + "<dev string:xdde>" + listbundlename + "<dev string:xdde>" + spawnquantity, &function_935bae8f5fe6d292, 0, 3 );
            }
            
            devgui::add_debug_command( "<dev string:xe29>" + devguimenu + "<dev string:xd7b>" );
            return;
        }
        
        if ( isdefined( spawntype ) )
        {
            if ( level.commonitemdebug.cachedevgui[ zonename ].types[ spawntype ].generated )
            {
                return;
            }
            
            level.commonitemdebug.cachedevgui[ zonename ].types[ spawntype ].generated = 1;
            devguimenu = "<dev string:xd27>" + zonename + "<dev string:xd65>" + spawntype + "<dev string:xd68>";
            devgui::add_debug_command( "<dev string:xd6b>" + devguimenu + "<dev string:xd7b>" );
            
            foreach ( cachename, cacheinfo in level.commonitemdebug.cachedevgui[ zonename ].types[ spawntype ].caches )
            {
                devgui::function_cd4e263c1f3018ae( devguimenu + "<dev string:xd65>" + cachename, "<dev string:xd42>" + zonename + "<dev string:xdde>" + spawntype + "<dev string:xdde>" + cachename, &function_d28f3dd145557f80, 0, 0 );
            }
            
            devgui::add_debug_command( "<dev string:xe29>" + devguimenu + "<dev string:xd7b>" );
            return;
        }
        
        if ( level.commonitemdebug.cachedevgui[ zonename ].generated )
        {
            return;
        }
        
        level.commonitemdebug.cachedevgui[ zonename ].generated = 1;
        devguimenu = "<dev string:xd27>" + zonename + "<dev string:xd68>";
        devgui::add_debug_command( "<dev string:xd6b>" + devguimenu + "<dev string:xd7b>" );
        
        foreach ( spawntype, spawntypeinfo in level.commonitemdebug.cachedevgui[ zonename ].types )
        {
            if ( spawntype == "<dev string:xd25>" )
            {
                foreach ( cachename, cacheinfo in level.commonitemdebug.cachedevgui[ zonename ].types[ spawntype ].caches )
                {
                    devgui::function_cd4e263c1f3018ae( devguimenu + "<dev string:xd65>" + cachename, "<dev string:xd42>" + zonename + "<dev string:xe37>" + cachename, &function_d28f3dd145557f80, 0, 0 );
                }
                
                continue;
            }
            
            devgui::function_cd4e263c1f3018ae( devguimenu + "<dev string:xd65>" + spawntype, "<dev string:xd42>" + zonename + "<dev string:xdde>" + spawntype, &function_d28f3dd145557f80, 0, 0 );
        }
        
        devgui::add_debug_command( "<dev string:xe29>" + devguimenu + "<dev string:xd7b>" );
    }

    // Namespace common_cache
    // Params 1
    // Checksum 0x5cd660a6, Offset: 0x9e41
    // Size: 0x9b, Type: dev
    function debug_spawn_cache( params )
    {
        var_2ca20d11c764c548 = hashcat( %"itemspawnentry:", params[ 0 ] );
        itemlistbundlename = params[ 1 ];
        quantity = params[ 2 ];
        cache = spawncache( var_2ca20d11c764c548, common_item::function_4fec258c8e1ea99c(), ( 0, 0, 0 ) );
        
        if ( isdefined( itemlistbundlename ) && isdefined( quantity ) )
        {
            fillcontentsfromlist( cache, itemlistbundlename, int( quantity ) );
        }
        else
        {
            cache.contents = [];
        }
        
        return cache;
    }

    // Namespace common_cache
    // Params 1
    // Checksum 0x7526463a, Offset: 0x9ee4
    // Size: 0xa6, Type: dev
    function function_8c81d3dbbc5965ca( params )
    {
        var_2ca20d11c764c548 = hashcat( %"itemspawnentry:", params[ 0 ] );
        cache = spawncache( var_2ca20d11c764c548, common_item::function_4fec258c8e1ea99c(), ( 0, 0, 0 ) );
        itemlists = getscriptbundlenames( #"itemspawnlist" );
        
        if ( itemlists.size > 0 )
        {
            function_a136b84fc5c0dfab( cache, itemlists[ randomint( itemlists.size ) ], randomintrange( 1, 5 ), 1 );
        }
        
        if ( !isdefined( cache.contents ) )
        {
            cache.contents = [];
        }
    }

    // Namespace common_cache
    // Params 1
    // Checksum 0x9157f7cb, Offset: 0x9f92
    // Size: 0x48, Type: dev
    function function_935bae8f5fe6d292( params )
    {
        level.var_ac05102cb0491c76 = !level.var_ac05102cb0491c76;
        
        if ( !level.var_ac05102cb0491c76 )
        {
            level notify( #"hash_1ebe075d5aabbfea" );
            return;
        }
        
        level thread function_a8f2b4bc57d4760e( params );
    }

    // Namespace common_cache
    // Params 1, eflags: 0xc
    // Checksum 0xe23ddc37, Offset: 0x9fe2
    // Size: 0x6f, Type: dev
    function private function_a8f2b4bc57d4760e( params )
    {
        self notify( #"hash_aefb7f17ebd86c5b" );
        self endon( #"hash_aefb7f17ebd86c5b" );
        level endon( #"game_ended" );
        level endon( #"hash_1ebe075d5aabbfea" );
        
        while ( true )
        {
            function_57a122759a2ac452( params );
            
            if ( function_4614af47ed74937b() )
            {
                level waittill( #"container_revealed" );
                continue;
            }
            
            wait 2;
        }
    }

    // Namespace common_cache
    // Params 1
    // Checksum 0x81fe755a, Offset: 0xa059
    // Size: 0x2b4, Type: dev
    function function_57a122759a2ac452( params )
    {
        var_2ca20d11c764c548 = hashcat( %"itemspawnentry:", params[ 0 ] );
        itemlistbundlename = params[ 1 ];
        quantity = int( params[ 2 ] );
        
        if ( !isdefined( level.commonitemdebug ) )
        {
            level.commonitemdebug = {};
        }
        
        type = getscriptbundlefieldvalue( var_2ca20d11c764c548, #"scriptable" ) ?? "<dev string:xd67>";
        
        if ( !isdefined( level.commonitemdebug.fakecache ) )
        {
            level.commonitemdebug.fakecache = { #var_5a4d5180ea13e4ed:1, #angles:( 0, 0, 0 ), #type:type };
        }
        
        level.commonitemdebug.fakecache.contents = undefined;
        level.commonitemdebug.fakecache.inventorygroup = undefined;
        level.commonitemdebug.fakecache.alreadyopened = undefined;
        level.commonitemdebug.fakecache.inited = undefined;
        quantity = level.var_f35b5a30bb6dcfb3 ?? quantity;
        fillcontentsfromlist( level.commonitemdebug.fakecache, itemlistbundlename, quantity );
        
        if ( iscontainerempty( level.commonitemdebug.fakecache ) )
        {
            return;
        }
        
        foreach ( player in level.players )
        {
            if ( isdefined( player function_e3795ef6fb5d5a82() ) )
            {
                closelootablecontainer( level.commonitemdebug.fakecache, player );
            }
            
            level.commonitemdebug.fakecache.origin = player geteye() + 32 * vectornormalize( anglestoforward( player getplayerangles() ) );
            
            if ( level.var_9afcf1fa7009bc81 )
            {
                function_72bff7a0da34bc70( level.commonitemdebug.fakecache, player );
                continue;
            }
            
            utility::delaythread( 0.1, &openlootablecontainer, level.commonitemdebug.fakecache, player );
        }
    }

    // Namespace common_cache
    // Params 1
    // Checksum 0xa815321b, Offset: 0xa315
    // Size: 0x56, Type: dev
    function function_24c38ce1e851c7a7( params )
    {
        level.var_f35b5a30bb6dcfb3 = int( params[ 0 ] );
        
        if ( !isdefined( level.var_6de02274b052182 ) || level.var_6de02274b052182 < level.var_f35b5a30bb6dcfb3 )
        {
            level.var_6de02274b052182 = level.var_f35b5a30bb6dcfb3;
        }
    }

    // Namespace common_cache
    // Params 1
    // Checksum 0x7a21d3dd, Offset: 0xa373
    // Size: 0xd8, Type: dev
    function function_3445980113c04609( origin )
    {
        contents = trace::create_playerclip_contents();
        trace = trace::sphere_trace_get_all_results( origin, origin, 2, undefined, contents, undefined, 1 );
        
        foreach ( hit in trace )
        {
            if ( hit[ "<dev string:xe3b>" ] != "<dev string:xe43>" )
            {
                continue;
            }
            
            scriptable = hit[ "<dev string:xe56>" ];
            
            if ( !scriptable scriptableislootcache() )
            {
                continue;
            }
            
            return scriptable;
        }
        
        return;
    }

    // Namespace common_cache
    // Params 0
    // Checksum 0x4eac8408, Offset: 0xa453
    // Size: 0x2ea, Type: dev
    function function_bf34e2ac498ad761()
    {
        var_c23789593c603174 = 10000;
        var_63eddf9662c08f6c = 150;
        var_7b7d47018fdf2b11 = 200;
        drawframeduration = 20;
        var_1ffb711ce830e797 = throttle::throttle_initialize_gate( "<dev string:xe61>", var_63eddf9662c08f6c );
        var_27424e0649778958 = throttle::function_ac02df3f2e81cbab( "<dev string:xe7c>", var_7b7d47018fdf2b11, undefined, drawframeduration * level.framedurationseconds );
        
        while ( true )
        {
            waitframe();
            var_709cb95834db6518 = getdvarint( @"hash_82b5f4eccb13d4d2", 0 );
            showdebug = var_709cb95834db6518 >= 1;
            var_5db0432ae18a1b51 = var_709cb95834db6518 >= 2;
            
            if ( !showdebug || !isdefined( level.players[ 0 ].origin ) )
            {
                continue;
            }
            
            caches = [];
            lootcount = getlootspawnpointcount();
            
            for ( i = 0; i < lootcount ; i++ )
            {
                loot = getlootspawnpoint( i );
                
                if ( loot.type != 1 )
                {
                    continue;
                }
                
                playerdist = distance2dsquared( level.players[ 0 ].origin, loot.origin );
                
                if ( playerdist > var_c23789593c603174 * var_c23789593c603174 )
                {
                    continue;
                }
                
                throttle::throttle_wait_gate( var_1ffb711ce830e797 );
                lootnode = spawnstruct();
                lootnode.origin = loot.origin;
                lootnode.color = ( 1, 0, 0 );
                
                if ( var_5db0432ae18a1b51 )
                {
                    throttle::throttle_wait_gate( var_1ffb711ce830e797 );
                    throttle::throttle_wait_gate( var_1ffb711ce830e797 );
                    lootnode.scriptable = function_3445980113c04609( lootnode.origin );
                    
                    if ( lootnode.scriptable )
                    {
                        lootnode.var_3e6d2c7a3afc0b5e = !cache_isclosed( lootnode.scriptable );
                        lootnode.color = lootnode.var_3e6d2c7a3afc0b5e ? ( 1, 1, 0 ) : ( 0, 1, 0 );
                        caches[ caches.size ] = lootnode;
                    }
                    
                    continue;
                }
                
                caches[ caches.size ] = lootnode;
            }
            
            throttle::function_706ed379a3746335( var_27424e0649778958 );
            
            foreach ( lootnode in caches )
            {
                throttle::function_1302aa73badc74f0( var_27424e0649778958 );
                sphere( lootnode.origin, 25, lootnode.color, 0, drawframeduration );
            }
        }
    }

#/
