// scripts\mp\loot\common_barter.gsc  (hash_0d4ba3044352723d.gscc) (size: 7771 Bytes / 0x1e5b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7bd54ff7 (2077577207)
// size ...... 7771 (0x1e5b)
// includes .. 10  (offset: 0x1da3)
// strings ... 4   (offset: 0x1df3)
// dev strs .. 4   (offset: 0x1e23)
// exports ... 21  (offset: 0x133b)
// cseg ...... 0x8a + 0x12b1 (0x133b)
// imports ... 60  (offset: 0x1683)
// animtree1 . 0   (offset: 0x1e5b)
// animtree2 . 0   (offset: 0x1e5b)
#using scripts\common\system;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\lui_game_event_aggregator;
#using scripts\mp\common\utility\player;
#using scripts\mp\loot\common_instance_inventory;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_inventory_groups;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_kiosk;

#namespace common_barter;

// Namespace common_barter
// Params 0, eflags: 0x5
// Checksum 0xa1d5e137, Offset: 0xa8
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"common_barter", #"common_item", &__init__, undefined );
}

// Namespace common_barter
// Params 0
// Checksum 0xae54c6c2, Offset: 0xd1
// Size: 0x9
function __init__()
{
    thread initbarter();
}

// Namespace common_barter
// Params 0
// Checksum 0xa1b0c15c, Offset: 0xe2
// Size: 0xec
function initbarter()
{
    level endon( #"game_ended" );
    
    if ( !common_kiosk::function_5274212108b240d3() )
    {
        return;
    }
    
    if ( !( isdefined( level.gametypebundle ) && level.gametypebundle.var_301f2c93e4074020 ) )
    {
        return;
    }
    
    lui_game_event_aggregator::registeronluieventcallback( &function_20015982239e13af );
    level.var_683e47a3fd72d382 = spawnstruct();
    level.var_683e47a3fd72d382.barterlist = level.gametypebundle.var_410b547a62771ea6;
    level.var_683e47a3fd72d382.barterrecipes = function_22eb041898617f68( level.var_683e47a3fd72d382.barterlist );
    level.var_683e47a3fd72d382.var_aa977fc0c0489c53 = function_d0ac3f9622df5592( level.gametypebundle.var_7793d78466fef906 );
    
    /#
        level thread function_7bb94c791bb482f8();
        level thread function_7f637685525c33c4();
    #/
}

// Namespace common_barter
// Params 2
// Checksum 0x35b8ce47, Offset: 0x1d6
// Size: 0x48
function function_20015982239e13af( channel, barterindex )
{
    if ( channel == "barter_item" )
    {
        result = function_83e0b6d9259f2be9( self, barterindex );
        
        if ( result )
        {
            level thread function_f8796468359c3a7d( self, "ui_barter_success" );
        }
    }
}

// Namespace common_barter
// Params 0
// Checksum 0xa49fc536, Offset: 0x226
// Size: 0xc, Type: bool
function isenabled()
{
    return isdefined( level.var_683e47a3fd72d382 );
}

// Namespace common_barter
// Params 2
// Checksum 0xb254906b, Offset: 0x23b
// Size: 0xa1
function function_16bf5a111be3a491( kiosk, barterlist )
{
    if ( !isenabled() )
    {
        return;
    }
    
    if ( !( isdefined( kiosk ) && isdefined( barterlist ) && isdefined( level.var_683e47a3fd72d382.var_aa977fc0c0489c53[ barterlist ] ) ) )
    {
        return;
    }
    
    overridestruct = level.var_683e47a3fd72d382.var_aa977fc0c0489c53[ barterlist ];
    kiosk.var_1ce8e8bc9752a33 = overridestruct.index + 1;
    kiosk.var_eb78956f15efdafc = function_22eb041898617f68( overridestruct.var_add873a179d1dc40 );
}

// Namespace common_barter
// Params 3
// Checksum 0x4f34dbc3, Offset: 0x2e4
// Size: 0x92
function function_1c9ff4e798cf2eee( players, kiosk, barterlist )
{
    foreach ( player in players )
    {
        function_cdd8bf408668f329( player, kiosk, barterlist );
    }
}

// Namespace common_barter
// Params 3
// Checksum 0x6267d4fd, Offset: 0x37e
// Size: 0x113
function function_cdd8bf408668f329( player, kiosk, barterlist )
{
    if ( !isenabled() )
    {
        return;
    }
    
    if ( !( isdefined( player ) && isdefined( kiosk ) && isdefined( barterlist ) && isdefined( level.var_683e47a3fd72d382.var_aa977fc0c0489c53[ barterlist ] ) ) )
    {
        return;
    }
    
    if ( !isdefined( kiosk.var_bd2a623fad3c3aab ) )
    {
        kiosk.var_bd2a623fad3c3aab = [];
    }
    
    overridestruct = level.var_683e47a3fd72d382.var_aa977fc0c0489c53[ barterlist ];
    kiosk.var_bd2a623fad3c3aab[ player.guid ] = spawnstruct();
    kiosk.var_bd2a623fad3c3aab[ player.guid ].var_5380eb0c05c682e = overridestruct.index + 1;
    kiosk.var_bd2a623fad3c3aab[ player.guid ].barterrecipes = function_22eb041898617f68( overridestruct.var_add873a179d1dc40 );
}

// Namespace common_barter
// Params 2
// Checksum 0xc878fc23, Offset: 0x499
// Size: 0x67, Type: bool
function function_95d9d0ef66d180e7( player, kiosk )
{
    if ( !isenabled() )
    {
        return false;
    }
    
    if ( !( isdefined( player ) && isdefined( kiosk ) ) )
    {
        return false;
    }
    
    return isdefined( kiosk.var_bd2a623fad3c3aab ) && isdefined( kiosk.var_bd2a623fad3c3aab[ player.guid ] ) || isdefined( kiosk.var_1ce8e8bc9752a33 );
}

// Namespace common_barter
// Params 2
// Checksum 0x8ec5ba33, Offset: 0x509
// Size: 0x6c
function function_25c795dfd37affe4( player, kiosk )
{
    if ( !function_95d9d0ef66d180e7( player, kiosk ) )
    {
        return 0;
    }
    
    if ( isdefined( kiosk.var_bd2a623fad3c3aab[ player.guid ] ) )
    {
        return kiosk.var_bd2a623fad3c3aab[ player.guid ].var_5380eb0c05c682e;
    }
    
    return kiosk.var_1ce8e8bc9752a33;
}

// Namespace common_barter
// Params 1, eflags: 0x4
// Checksum 0xd228aa52, Offset: 0x57e
// Size: 0xcc
function private function_22eb041898617f68( barterlist )
{
    var_92e152a29811b638 = getscriptbundle( barterlist );
    barterrecipes = [];
    
    foreach ( recipe in var_92e152a29811b638.recipelist )
    {
        if ( isdefined( recipe.recipe ) )
        {
            barterrecipes[ barterrecipes.size ] = getscriptbundle( hashcat( %"barterrecipes:", recipe.recipe ) );
        }
    }
    
    return barterrecipes;
}

// Namespace common_barter
// Params 1, eflags: 0x4
// Checksum 0x8b8167c4, Offset: 0x653
// Size: 0xfa
function private function_d0ac3f9622df5592( listoverride )
{
    bundleoverride = getscriptbundle( listoverride );
    outputoverrides = [];
    
    foreach ( index, list in bundleoverride.listoverrides )
    {
        if ( isdefined( list.list ) )
        {
            struct = spawnstruct();
            struct.index = index;
            struct.var_add873a179d1dc40 = hashcat( %"hash_6c8907a65a40a6a9", list.list );
            outputoverrides[ list.list ] = struct;
        }
    }
    
    return outputoverrides;
}

// Namespace common_barter
// Params 2, eflags: 0x4
// Checksum 0xb9072a11, Offset: 0x756
// Size: 0x5c
function private function_f8796468359c3a7d( player, omnvar )
{
    player notify( #"hash_23bf04d09d55d760" );
    player setclientomnvar( omnvar, 1 );
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player endon( #"hash_23bf04d09d55d760" );
    waitframe();
    player setclientomnvar( omnvar, 0 );
}

// Namespace common_barter
// Params 2, eflags: 0x4
// Checksum 0x7ac529f0, Offset: 0x7ba
// Size: 0x35
function private function_83e0b6d9259f2be9( player, index )
{
    recipes = function_9b02a3fcc6a8cd29( player );
    return processbarter( player, recipes[ index ] );
}

// Namespace common_barter
// Params 1, eflags: 0x4
// Checksum 0xa70119d0, Offset: 0x7f8
// Size: 0x25, Type: bool
function private canbarter( player )
{
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    if ( !player::isreallyalive( player ) )
    {
        return false;
    }
    
    return true;
}

// Namespace common_barter
// Params 1, eflags: 0x4
// Checksum 0x66e5eb7, Offset: 0x826
// Size: 0xc4
function private function_9b02a3fcc6a8cd29( player )
{
    if ( !( isdefined( player ) && isdefined( player.common_kiosk ) ) )
    {
        return level.var_683e47a3fd72d382.barterrecipes;
    }
    
    if ( isdefined( player.common_kiosk.var_bd2a623fad3c3aab[ player.guid ] ) )
    {
        return player.common_kiosk.var_bd2a623fad3c3aab[ player.guid ].barterrecipes;
    }
    
    var_7237854e3be197ca = player.common_kiosk.var_eb78956f15efdafc;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return level.var_683e47a3fd72d382.barterrecipes;
}

// Namespace common_barter
// Params 4, eflags: 0x4
// Checksum 0x506c4eaa, Offset: 0x8f3
// Size: 0x80
function private takeloadoutitem( player, amount, itemtype, itemindex )
{
    if ( itemtype == "weapon" )
    {
        slotname = common_inventory_groups::function_acd97ba889776567( itemindex );
        player common_item::function_bbba261e6fdc7e52( itemtype, { #dontdrop:1, #slotname:slotname } );
        return;
    }
    
    player common_item::function_bbba261e6fdc7e52( itemtype, { #count:amount } );
}

// Namespace common_barter
// Params 2, eflags: 0x4
// Checksum 0x213ad449, Offset: 0x97b
// Size: 0x502, Type: bool
function private processbarter( player, recipe )
{
    if ( !canbarter( player ) )
    {
        return false;
    }
    
    var_9711efc290030dc8 = [];
    
    if ( recipe.unlocksublocation > 0 )
    {
        if ( !player common_instance_inventory::function_902ad22eabe0eeeb( recipe.unlocksublocation ) )
        {
            return false;
        }
    }
    
    foreach ( item in recipe.materials )
    {
        recipelootid = item.lootid;
        backpackamount = player common_inventory::function_99741e85ee9c3d18( recipelootid );
        var_40d483431f62fd1f = 0;
        loadoutamount = 0;
        loadoutindex = undefined;
        loadouttype = undefined;
        
        if ( backpackamount < item.quantity )
        {
            var_40d483431f62fd1f = item.quantity - backpackamount;
            [ loadoutgroup, _ ] = player common_inventory_groups::function_896ed3217a875f7d();
            var_eecc1b3a21621fad = common_inventory_groups::function_19a5a29f5cd0df45( loadoutgroup );
            
            for ( i = 0; i < var_eecc1b3a21621fad ; i++ )
            {
                [ callbacks, typeref, var_8fb8e1fb220cca48 ] = player common_inventory_groups::function_6dfdd28826ee7354( loadoutgroup, i );
                
                if ( !isdefined( var_8fb8e1fb220cca48 ) || var_8fb8e1fb220cca48.count <= 0 )
                {
                    continue;
                }
                
                lootid = common_item::function_b01955b20c77371d( var_8fb8e1fb220cca48.name );
                
                if ( lootid == recipelootid )
                {
                    loadoutamount = var_8fb8e1fb220cca48.count;
                    loadoutindex = i;
                    loadouttype = typeref;
                    break;
                }
            }
        }
        
        if ( backpackamount + loadoutamount < item.quantity )
        {
            return false;
        }
        
        var_12a711f9969a4659 = player common_inventory::function_4436b2f08e588b8( recipelootid );
        
        if ( var_12a711f9969a4659.size == 0 && loadoutamount <= 0 )
        {
            return false;
        }
        
        backpackamount = int( min( backpackamount, item.quantity ) );
        
        if ( var_40d483431f62fd1f > 0 )
        {
            loadoutamount = int( min( loadoutamount, var_40d483431f62fd1f ) );
        }
        
        var_f3032e6a64317641 = spawnstruct();
        var_f3032e6a64317641.backpackamount = backpackamount;
        var_f3032e6a64317641.var_12a711f9969a4659 = var_12a711f9969a4659;
        var_f3032e6a64317641.loadoutamount = loadoutamount;
        var_f3032e6a64317641.loadoutindex = loadoutindex;
        var_f3032e6a64317641.loadouttype = loadouttype;
        var_9711efc290030dc8[ var_9711efc290030dc8.size ] = var_f3032e6a64317641;
    }
    
    foreach ( item in var_9711efc290030dc8 )
    {
        var_72b0814b09f1dd3 = item.backpackamount;
        
        foreach ( itemslotindex in item.var_12a711f9969a4659 )
        {
            quantity = player common_inventory::inventory_getquantityatbackpackindex( itemslotindex );
            remainingquantity = quantity - var_72b0814b09f1dd3;
            player common_inventory::inventory_setbackpackitematindex( itemslotindex, recipelootid, int( max( remainingquantity, 0 ) ) );
            var_72b0814b09f1dd3 = remainingquantity * -1;
            
            if ( var_72b0814b09f1dd3 <= 0 )
            {
                break;
            }
        }
        
        if ( var_f3032e6a64317641.loadoutamount > 0 )
        {
            takeloadoutitem( player, var_f3032e6a64317641.loadoutamount, var_f3032e6a64317641.loadouttype, var_f3032e6a64317641.loadoutindex );
        }
    }
    
    scriptablename = recipe.weaponscriptable;
    
    if ( !isdefined( scriptablename ) || scriptablename == "" )
    {
        scriptablename = loot::getScriptableFromLootID( recipe.lootid );
    }
    
    if ( !recipe.permanent )
    {
        recipeitem = spawnstruct();
        recipeitem.type = scriptablename;
        recipeitem.count = common_item::function_598dd39282efb544( recipe.quantity );
        player common_item::function_96119bed8ab4c5d9( recipeitem, 0 );
    }
    
    player challenges::function_c3ebaa8cc6842f83( undefined, scriptablename, recipe.lootid, recipe.quantity, 0 );
    return true;
}

/#

    // Namespace common_barter
    // Params 0, eflags: 0x4
    // Checksum 0x762f9c99, Offset: 0xe86
    // Size: 0x30e, Type: dev
    function private function_7bb94c791bb482f8()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            player = level.players[ 0 ];
            barterindex = getdvarint( @"hash_d0372976df17d33a", 0 );
            var_ec4cd86841489773 = getdvarint( @"hash_df5d1d642bd121d0", 0 );
            var_2895139d321f65bf = getdvarint( @"hash_f77ca612090e125b", 0 );
            var_43a650f725d0a8f6 = getdvar( @"hash_d61b2e700fcd4a9", "<dev string:x24>" );
            
            if ( barterindex )
            {
                barterrecipes = function_9b02a3fcc6a8cd29( player );
                setdvar( @"scr_barter_test", 0 );
                
                if ( !isdefined( barterrecipes[ barterindex - 1 ] ) )
                {
                    waitframe();
                    continue;
                }
                
                barterchosen = barterrecipes[ barterindex - 1 ];
                processbarter( player, barterchosen );
            }
            else if ( var_ec4cd86841489773 )
            {
                barterrecipes = function_9b02a3fcc6a8cd29( player );
                setdvar( @"hash_df5d1d642bd121d0", 0 );
                
                if ( !canbarter( player ) )
                {
                    waitframe();
                    continue;
                }
                
                barterchosen = barterrecipes[ var_ec4cd86841489773 - 1 ];
                
                foreach ( materialitem in barterchosen.materials )
                {
                    scriptablename = loot::getScriptableFromLootID( materialitem.lootid );
                    recipeitem = spawnstruct();
                    recipeitem.type = scriptablename;
                    recipeitem.count = common_item::function_598dd39282efb544( materialitem.quantity );
                    player common_item::function_96119bed8ab4c5d9( recipeitem, 0 );
                }
            }
            else if ( var_43a650f725d0a8f6 != "<dev string:x24>" )
            {
                setdvar( @"hash_d61b2e700fcd4a9", "<dev string:x24>" );
                kioskinstances = common_kiosk::function_5c2447fa1580c330();
                mindist = 999999999999;
                closestkiosk = undefined;
                
                foreach ( kiosk in kioskinstances )
                {
                    if ( !isdefined( kiosk.origin ) )
                    {
                        continue;
                    }
                    
                    currentdist = distance( kiosk.origin, player.origin );
                    
                    if ( currentdist < mindist )
                    {
                        mindist = currentdist;
                        closestkiosk = kiosk;
                    }
                }
                
                if ( isdefined( closestkiosk ) )
                {
                    if ( var_2895139d321f65bf )
                    {
                        function_cdd8bf408668f329( player, closestkiosk, var_43a650f725d0a8f6 );
                    }
                    else
                    {
                        function_16bf5a111be3a491( closestkiosk, var_43a650f725d0a8f6 );
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace common_barter
    // Params 0, eflags: 0x4
    // Checksum 0x1f25d7c6, Offset: 0x119c
    // Size: 0x19f, Type: dev
    function private function_7f637685525c33c4()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            player = level.players[ 0 ];
            var_c327eac3b144b9d5 = getdvar( @"hash_960392030358b954", "<dev string:x25>" );
            var_369e5a648cbcab62 = getdvar( @"hash_be729db8a6ea5ad9", "<dev string:x2c>" );
            var_52e9b33096b69ec1 = getdvarint( @"hash_4745328defe32d4a", 0 );
            
            if ( var_52e9b33096b69ec1 )
            {
                setdvar( @"hash_4745328defe32d4a", 0 );
                customrecipe = spawnstruct();
                customrecipe.quantity = 1;
                customrecipe.lootid = int( var_c327eac3b144b9d5 );
                materialstringlist = strtok( var_369e5a648cbcab62, "<dev string:x3c>" );
                customrecipe.materials = [];
                
                foreach ( str in materialstringlist )
                {
                    materialitem = spawnstruct();
                    materialitem.lootid = int( str );
                    materialitem.quantity = 1;
                    customrecipe.materials[ customrecipe.materials.size ] = materialitem;
                }
                
                processbarter( player, customrecipe );
            }
            
            waitframe();
        }
    }

#/
