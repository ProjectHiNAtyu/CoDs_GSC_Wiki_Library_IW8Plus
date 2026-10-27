// scripts\mp\gametypes\barter_system.gsc  (hash_342e51952b63e594.gscc) (size: 7455 Bytes / 0x1d1f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x45eb08b4 (1173031092)
// size ...... 7455 (0x1d1f)
// includes .. 13  (offset: 0x1c4f)
// strings ... 6   (offset: 0x1cb7)
// dev strs .. 2   (offset: 0x1cff)
// exports ... 17  (offset: 0x12bf)
// cseg ...... 0xd0 + 0x11ef (0x12bf)
// imports ... 60  (offset: 0x1567)
// animtree1 . 0   (offset: 0x1d1f)
// animtree2 . 0   (offset: 0x1d1f)
#using script_16ea1b94f0f381b3;
#using scripts\mp\br\gametypes\br_default_inventory;
#using scripts\mp\br\gametypes\br_instance_inventory;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\challenges;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\player;
#using scripts\mp\dmz\gametypes\dmz_dog_tag;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\locksandkeys;

#namespace barter_system;

// Namespace barter_system
// Params 0
// Checksum 0xa4b7d43b, Offset: 0xee
// Size: 0x9e
function init()
{
    level endon( #"game_ended" );
    level.barterenabled = getdvarint( @"hash_ae537ea74ad94bf6", 0 );
    
    if ( !level.barterenabled )
    {
        return;
    }
    
    level.barterlist = getdvar( @"hash_d02bf26d7b888c7b", "barter_recipe_list_iw9" );
    level.var_aa977fc0c0489c53 = function_df2a1467bfd585cb( getdvar( @"hash_25dbdc95ff3e3da5", "barter_list_overrides_iw9" ) );
    flags::gameflagwait( "prematch_done" );
    level.barterrecipes = function_4d7ec2695024775( level.barterlist );
    
    /#
        level thread function_8716e00af94c2e33();
    #/
}

// Namespace barter_system
// Params 2
// Checksum 0xc609c691, Offset: 0x194
// Size: 0x35
function function_f3f18d69f62ea154( player, index )
{
    recipes = function_d30b8279bbe76922( player );
    return function_f88f4ed07d1e4ec8( player, recipes[ index ] );
}

// Namespace barter_system
// Params 1
// Checksum 0xae6e1e0c, Offset: 0x1d2
// Size: 0x4d
function function_fc83ad8339a189a4( player )
{
    player notify( #"clear_barter" );
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player endon( #"clear_barter" );
    waitframe();
    player setclientomnvar( "ui_barter_success", 0 );
}

// Namespace barter_system
// Params 2
// Checksum 0xad2781e2, Offset: 0x227
// Size: 0x62
function function_db5ceab7d99a46ac( kiosk, barterlist )
{
    if ( !( isdefined( kiosk ) && isdefined( barterlist ) && isdefined( level.var_aa977fc0c0489c53[ barterlist ] ) ) )
    {
        return;
    }
    
    kiosk.var_1ce8e8bc9752a33 = level.var_aa977fc0c0489c53[ barterlist ] + 1;
    kiosk.var_eb78956f15efdafc = function_4d7ec2695024775( barterlist );
}

// Namespace barter_system
// Params 3
// Checksum 0x70f98929, Offset: 0x291
// Size: 0x92
function function_ff330c29ba25dd3( players, kiosk, barterlist )
{
    foreach ( player in players )
    {
        function_410af70c2b04d592( player, kiosk, barterlist );
    }
}

// Namespace barter_system
// Params 3
// Checksum 0x62740d8, Offset: 0x32b
// Size: 0xd4
function function_410af70c2b04d592( player, kiosk, barterlist )
{
    if ( !( isdefined( player ) && isdefined( kiosk ) && isdefined( barterlist ) && isdefined( level.var_aa977fc0c0489c53[ barterlist ] ) ) )
    {
        return;
    }
    
    if ( !isdefined( kiosk.var_bd2a623fad3c3aab ) )
    {
        kiosk.var_bd2a623fad3c3aab = [];
    }
    
    kiosk.var_bd2a623fad3c3aab[ player.guid ] = spawnstruct();
    kiosk.var_bd2a623fad3c3aab[ player.guid ].var_5380eb0c05c682e = level.var_aa977fc0c0489c53[ barterlist ] + 1;
    kiosk.var_bd2a623fad3c3aab[ player.guid ].barterrecipes = function_4d7ec2695024775( barterlist );
}

// Namespace barter_system
// Params 2
// Checksum 0xe2e428de, Offset: 0x407
// Size: 0x6a, Type: bool
function function_25bcc6f5616288b4( player, kiosk )
{
    if ( !level.barterenabled )
    {
        return false;
    }
    
    if ( !( isdefined( player ) && isdefined( kiosk ) ) )
    {
        return false;
    }
    
    return isdefined( kiosk.var_bd2a623fad3c3aab ) && isdefined( kiosk.var_bd2a623fad3c3aab[ player.guid ] ) || isdefined( kiosk.var_1ce8e8bc9752a33 );
}

// Namespace barter_system
// Params 2
// Checksum 0xec3b09ba, Offset: 0x47a
// Size: 0x6c
function function_8ebfd8cb7a429c23( player, kiosk )
{
    if ( !function_25bcc6f5616288b4( player, kiosk ) )
    {
        return 0;
    }
    
    if ( isdefined( kiosk.var_bd2a623fad3c3aab[ player.guid ] ) )
    {
        return kiosk.var_bd2a623fad3c3aab[ player.guid ].var_5380eb0c05c682e;
    }
    
    return kiosk.var_1ce8e8bc9752a33;
}

// Namespace barter_system
// Params 1, eflags: 0x4
// Checksum 0x70255b34, Offset: 0x4ef
// Size: 0xd2
function private function_4d7ec2695024775( barterlist )
{
    var_92e152a29811b638 = getscriptbundle( hashcat( %"hash_6c8907a65a40a6a9", barterlist ) );
    barterrecipes = [];
    
    foreach ( recipe in var_92e152a29811b638.recipelist )
    {
        if ( isdefined( recipe.recipe ) )
        {
            barterrecipes[ barterrecipes.size ] = getscriptbundle( "barterrecipes:" + recipe.recipe );
        }
    }
    
    return barterrecipes;
}

// Namespace barter_system
// Params 1, eflags: 0x4
// Checksum 0xbbe243b8, Offset: 0x5ca
// Size: 0xc7
function private function_df2a1467bfd585cb( listoverride )
{
    bundleoverride = getscriptbundle( hashcat( %"hash_283f419bc25a568b", listoverride ) );
    outputoverrides = [];
    
    foreach ( index, list in bundleoverride.listoverrides )
    {
        if ( isdefined( list.list ) )
        {
            outputoverrides[ list.list ] = index;
        }
    }
    
    return outputoverrides;
}

// Namespace barter_system
// Params 1, eflags: 0x4
// Checksum 0x3494d9f2, Offset: 0x69a
// Size: 0xb0
function private function_d30b8279bbe76922( player )
{
    if ( !( isdefined( player ) && isdefined( player.br_kiosk ) ) )
    {
        return level.barterrecipes;
    }
    
    if ( isdefined( player.br_kiosk.var_bd2a623fad3c3aab[ player.guid ] ) )
    {
        return player.br_kiosk.var_bd2a623fad3c3aab[ player.guid ].barterrecipes;
    }
    
    var_7237854e3be197ca = player.br_kiosk.var_eb78956f15efdafc;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return level.barterrecipes;
}

// Namespace barter_system
// Params 1, eflags: 0x4
// Checksum 0x6403d6fb, Offset: 0x753
// Size: 0x25, Type: bool
function private function_7e272103090039b3( player )
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

// Namespace barter_system
// Params 2, eflags: 0x4
// Checksum 0x534e85e1, Offset: 0x781
// Size: 0x187
function private function_93cbd9900c485194( player, matchlootid )
{
    loadoutitems = player br_default_inventory::function_af60747a2da55b77( 1, 1, 1 );
    
    if ( isdefined( loadoutitems ) )
    {
        foreach ( indextype, itemtype in loadoutitems )
        {
            if ( !itemtype.size )
            {
                continue;
            }
            
            foreach ( slotindex, slot in itemtype )
            {
                if ( !isdefined( slot ) )
                {
                    continue;
                }
                
                lootid = slot[ 0 ];
                quantity = slot[ 1 ];
                
                if ( !lootid || !quantity )
                {
                    continue;
                }
                
                if ( lootid != matchlootid )
                {
                    continue;
                }
                
                if ( br_pickups::function_bcc6dc9b2b7365e0( matchlootid ) && quantity > 0 )
                {
                    quantity = 1;
                }
                
                return [ quantity, indextype, slotindex ];
            }
        }
    }
    
    return [ 0, 0, 0 ];
}

// Namespace barter_system
// Params 4, eflags: 0x4
// Checksum 0x4e95959e, Offset: 0x911
// Size: 0x138
function private function_2b229b12e5c2523f( player, amount, itemtype, itemindex )
{
    switch ( itemtype )
    {
        case 0:
            plundercount = player.plundercount - amount;
            player br_plunder::playersetplundercount( plundercount );
            break;
        case 1:
            break;
        case 2:
            slot = equipment_mp::function_b1928e5713e81b5e( itemindex );
            player equipment_mp::decrementequipmentslotammo( slot, amount );
            break;
        case 3:
            player killstreaks::removekillstreak( 1 );
            break;
        case 4:
            player br_pickups::resetsuper();
            player.equipment[ "super" ] = undefined;
            break;
        case 6:
            player br_pickups::function_1190855e1ea8f90f();
            br_instance_inventory::function_bf3288672a33d4a2( player );
            break;
        case 7:
            player br_pickups::removeselfrevivetoken();
            break;
        default:
            assertmsg( "<dev string:x24>" + itemtype );
            return;
    }
}

// Namespace barter_system
// Params 2, eflags: 0x4
// Checksum 0x5b19d1e9, Offset: 0xa51
// Size: 0x56e, Type: bool
function private function_f88f4ed07d1e4ec8( player, recipe )
{
    if ( !function_7e272103090039b3( player ) )
    {
        return false;
    }
    
    var_9711efc290030dc8 = [];
    
    if ( recipe.unlocksublocation > 0 )
    {
        if ( !br_instance_inventory::function_902ad22eabe0eeeb( player, recipe.unlocksublocation ) )
        {
            return false;
        }
    }
    
    foreach ( item in recipe.materials )
    {
        scriptablename = loot::getScriptableFromLootID( item.lootid );
        recipelootid = item.lootid;
        
        if ( br_pickups::iskey( scriptablename ) )
        {
            rootkeyname = locksandkeys::function_741733f682405a26( scriptablename );
            [ scriptablename, _ ] = locksandkeys::function_d39456776fcadb79( rootkeyname, player, 1 );
            recipelootid = loot::function_d3e3bcaea591a6a2( scriptablename );
        }
        
        backpackamount = player br_default_inventory::function_1c4df4a60ee9b86a( recipelootid );
        [ loadoutamount, loadouttype, loadoutindex ] = function_93cbd9900c485194( player, recipelootid );
        var_a0737a490d461968 = undefined;
        
        if ( dmz_dog_tag::hasdogtag( player ) && br_pickups::isdogtag( scriptablename ) )
        {
            currentdogtag = dmz_dog_tag::function_a084b2fcf3307a37( player );
            
            if ( currentdogtag == scriptablename )
            {
                loadoutamount++;
                var_a0737a490d461968 = 1;
            }
        }
        
        if ( backpackamount + loadoutamount < item.quantity )
        {
            return false;
        }
        
        var_12a711f9969a4659 = player br_default_inventory::function_2dea722d6c0344( recipelootid );
        
        if ( var_12a711f9969a4659.size == 0 && loadoutamount < item.quantity )
        {
            return false;
        }
        
        if ( backpackamount >= item.quantity )
        {
            loadoutamount = undefined;
            loadoutindex = undefined;
            loadouttype = undefined;
            var_a0737a490d461968 = undefined;
        }
        else
        {
            loadoutamount = item.quantity - backpackamount;
        }
        
        backpackamount = int( min( backpackamount, item.quantity ) );
        
        if ( isdefined( loadoutamount ) )
        {
            loadoutamount = int( min( loadoutamount, item.quantity ) );
        }
        
        var_9711efc290030dc8[ var_9711efc290030dc8.size ] = [ backpackamount, var_12a711f9969a4659, loadoutamount, loadoutindex, loadouttype, var_a0737a490d461968 ];
    }
    
    foreach ( item in var_9711efc290030dc8 )
    {
        var_72b0814b09f1dd3 = item[ 0 ];
        
        foreach ( index in item[ 1 ] )
        {
            [ lootid, quantity ] = player br_default_inventory::function_c022fc696a9c0db2( index );
            
            if ( br_pickups::function_bcc6dc9b2b7365e0( lootid ) )
            {
                var_72b0814b09f1dd3 = quantity;
            }
            
            player br_default_inventory::function_39f0833282ad6f6( index, var_72b0814b09f1dd3 );
            var_72b0814b09f1dd3 -= quantity;
            
            if ( var_72b0814b09f1dd3 <= 0 )
            {
                break;
            }
        }
        
        if ( item[ 5 ] )
        {
            dmz_dog_tag::function_ff4a0e3c9d3674dc( player, 0 );
            continue;
        }
        
        if ( !( isdefined( item[ 2 ] ) && isdefined( item[ 3 ] ) && isdefined( item[ 4 ] ) ) )
        {
            continue;
        }
        
        function_2b229b12e5c2523f( player, item[ 2 ], item[ 4 ], item[ 3 ] );
    }
    
    scriptablename = recipe.weaponscriptable;
    
    if ( !isdefined( scriptablename ) )
    {
        scriptablename = loot::getScriptableFromLootID( recipe.lootid );
    }
    
    result = undefined;
    
    if ( !recipe.permanent )
    {
        result = player br_pickups::lootitem( recipe.lootid, recipe.quantity, recipe.weaponscriptable );
    }
    
    if ( !result && !recipe.permanent )
    {
        baseorigin = player.origin;
        baseangles = player.angles;
        
        if ( isdefined( player.br_kiosk ) )
        {
            baseorigin = player.br_kiosk.centerbottom ?? player.br_kiosk.origin;
            baseangles = player.br_kiosk.angles;
        }
        
        spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( baseorigin, baseangles );
        namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( scriptablename, recipe.quantity, spawnoptions );
    }
    
    player challenges::function_c3ebaa8cc6842f83( undefined, scriptablename, recipe.lootid, recipe.quantity, 0 );
    return true;
}

/#

    // Namespace barter_system
    // Params 0, eflags: 0x4
    // Checksum 0xf20895e2, Offset: 0xfc8
    // Size: 0x2f7, Type: dev
    function private function_8716e00af94c2e33()
    {
        level endon( #"game_ended" );
        player = level.players[ 0 ];
        
        while ( true )
        {
            barterindex = getdvarint( @"hash_d0372976df17d33a", 0 );
            var_ec4cd86841489773 = getdvarint( @"hash_df5d1d642bd121d0", 0 );
            var_2895139d321f65bf = getdvarint( @"hash_f77ca612090e125b", 0 );
            var_43a650f725d0a8f6 = getdvar( @"hash_d61b2e700fcd4a9", "<dev string:x47>" );
            
            if ( barterindex )
            {
                setdvar( @"scr_barter_test", 0 );
                
                if ( !isdefined( level.barterrecipes[ barterindex - 1 ] ) )
                {
                    waitframe();
                    continue;
                }
                
                barterchosen = level.barterrecipes[ barterindex - 1 ];
                function_f88f4ed07d1e4ec8( player, barterchosen );
            }
            else if ( var_ec4cd86841489773 )
            {
                setdvar( @"hash_df5d1d642bd121d0", 0 );
                
                if ( !function_7e272103090039b3( player ) )
                {
                    waitframe();
                    continue;
                }
                
                barterchosen = level.barterrecipes[ var_ec4cd86841489773 - 1 ];
                
                foreach ( item in barterchosen.materials )
                {
                    player br_pickups::lootitem( item.lootid, item.quantity, undefined, 1 );
                }
            }
            else if ( var_43a650f725d0a8f6 != "<dev string:x47>" )
            {
                setdvar( @"hash_d61b2e700fcd4a9", "<dev string:x47>" );
                
                if ( !( isdefined( level.common_armory_kiosk ) && isdefined( level.common_armory_kiosk.instances ) ) )
                {
                    waitframe();
                    continue;
                }
                
                mindist = 999999999999;
                closestkiosk = undefined;
                
                foreach ( kiosk in level.common_armory_kiosk.instances )
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
                        function_410af70c2b04d592( player, closestkiosk, var_43a650f725d0a8f6 );
                    }
                    else
                    {
                        function_db5ceab7d99a46ac( closestkiosk, var_43a650f725d0a8f6 );
                    }
                }
            }
            
            waitframe();
        }
    }

#/
