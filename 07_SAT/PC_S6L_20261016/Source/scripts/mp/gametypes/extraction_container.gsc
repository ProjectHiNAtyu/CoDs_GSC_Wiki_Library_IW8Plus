// scripts\mp\gametypes\extraction_container.gsc  (hash_048614492ef09b23.gscc) (size: 7885 Bytes / 0x1ecd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7ec755a1 (2126992801)
// size ...... 7885 (0x1ecd)
// includes .. 11  (offset: 0x1d7d)
// strings ... 7   (offset: 0x1dd5)
// dev strs .. 4   (offset: 0x1e9d)
// exports ... 14  (offset: 0x1571)
// cseg ...... 0xfd + 0x1474 (0x1571)
// imports ... 51  (offset: 0x17a1)
// animtree1 . 0   (offset: 0x1ecd)
// animtree2 . 0   (offset: 0x1ecd)
#using script_16ea1b94f0f381b3;
#using scripts\common\weapon;
#using scripts\mp\br\gametypes\br_default_inventory;
#using scripts\mp\br\gametypes\br_instance_inventory;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\hud_message;
#using scripts\mp\loot;
#using scripts\mp\loot\common_inventory;

#namespace extraction_container;

// Namespace extraction_container
// Params 6
// Checksum 0x54a9a9f7, Offset: 0x11b
// Size: 0x8c
function function_e1dbb4b44225d9a2( instance, part, state, player, bautouse, usestring )
{
    function_7f60632e32cf8b7c( player, instance );
    instance.playeropen[ player.guid ] = player;
    
    if ( isdefined( instance.usedcallback ) )
    {
        [[ instance.usedcallback ]]( instance, part, state, player, bautouse, usestring );
    }
    
    loot_mp::openlootablecontainer( player, instance );
}

// Namespace extraction_container
// Params 7
// Checksum 0x6f18b603, Offset: 0x1af
// Size: 0xbc
function function_2a28497226027a50( players, container, lootid, quantity, weaponobj, noextract, force )
{
    foreach ( player in players )
    {
        function_339e015d0d45f1a5( player, container, lootid, quantity, weaponobj, noextract, force );
    }
}

// Namespace extraction_container
// Params 2
// Checksum 0x18b33b8c, Offset: 0x273
// Size: 0x118
function function_7f60632e32cf8b7c( player, container )
{
    if ( !loot_mp::function_13a69e0034bdf2f9( player, container ) )
    {
        containertype = function_4a93ddb93467f187( container.type );
        loot_mp::initplayercontents( player, container, containertype );
        container.playercontents[ player.guid ].contents[ 0 ] = [];
        container.playercontents[ player.guid ].contents[ 0 ][ "quantity" ] = 0;
        container.playercontents[ player.guid ].contents[ 0 ][ "lootID" ] = 0;
        
        if ( !container.noweaponslot )
        {
            container.playercontents[ player.guid ].weaponslotcontents = 0;
            container.playercontents[ player.guid ].weaponslotobj = undefined;
        }
    }
}

// Namespace extraction_container
// Params 8
// Checksum 0x401104fb, Offset: 0x393
// Size: 0x52d
function function_339e015d0d45f1a5( player, container, lootid, quantity, weaponobj, noextract, force, var_7429e3346a2e1042 )
{
    function_7f60632e32cf8b7c( player, container );
    [ items, lastvalidindex ] = loot_mp::function_bd786d01398cca27( container.playercontents[ player.guid ].contents, player, container );
    container.playercontents[ player.guid ].contents = items;
    containersize = function_f40f1b8493967f01( container );
    
    for ( i = lastvalidindex + 1; i < containersize ; i++ )
    {
        container.playercontents[ player.guid ].contents[ i ] = undefined;
    }
    
    if ( lootid == 0 || quantity == 0 )
    {
        return;
    }
    
    if ( isdefined( weaponobj ) && !container.noweaponslot )
    {
        if ( function_7d765df3b451de6a( player, container ) )
        {
            loot_mp::function_3d4987dd14eeffe0( player, container.playercontents[ player.guid ], weaponobj, lootid, quantity, undefined, noextract );
            return;
        }
        
        loot_mp::function_43b2ea123b58c1c4( container.playercontents[ player.guid ], lootid, weaponobj, undefined, noextract, quantity, undefined );
        return;
    }
    
    containerindex = container.playercontents[ player.guid ].contents.size;
    canstack = undefined;
    
    foreach ( index, item in container.playercontents[ player.guid ].contents )
    {
        if ( !( isdefined( item ) && isdefined( item[ "quantity" ] ) && isdefined( item[ "lootID" ] ) ) )
        {
            continue;
        }
        
        if ( item[ "lootID" ] == 8395 && lootid == item[ "lootID" ] )
        {
            containerindex = index;
            quantity += item[ "quantity" ];
            canstack = 1;
            break;
        }
        
        scriptablename = loot::getScriptableFromLootID( lootid );
        maxcount = level.br_pickups.var_3444316dc55e4b0a[ scriptablename ];
        
        if ( !isdefined( maxcount ) || maxcount == 0 )
        {
            maxcount = level.br_pickups.maxcounts[ scriptablename ];
        }
        
        if ( !isdefined( maxcount ) || maxcount == 0 )
        {
            continue;
        }
        
        if ( item[ "lootID" ] == lootid && quantity + item[ "quantity" ] <= maxcount )
        {
            containerindex = index;
            quantity += item[ "quantity" ];
            canstack = 1;
            break;
        }
    }
    
    if ( containerindex >= containersize && !isdefined( weaponobj ) && !canstack )
    {
        if ( force )
        {
            containerindex = 0;
            containerlootid = container.playercontents[ player.guid ].contents[ containerindex ][ "lootID" ];
            containerquantity = container.playercontents[ player.guid ].contents[ containerindex ][ "quantity" ];
            scriptablename = loot::getScriptableFromLootID( containerlootid );
            spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( container.origin, container.angles );
            namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( scriptablename, containerquantity, spawnoptions );
        }
        else
        {
            player hud_message::showerrormessage( %"mp/balloon_extract_deny_no_room" );
            return;
        }
    }
    
    if ( isdefined( container.var_444df56487288e2a ) )
    {
        [ lootid, var_5e5e85156948df48 ] = [[ container.var_444df56487288e2a ]]( container, player, lootid, quantity, undefined, undefined, containerindex );
        
        if ( var_5e5e85156948df48 )
        {
            noextract = var_5e5e85156948df48;
        }
    }
    
    container.playercontents[ player.guid ].contents[ containerindex ][ "quantity" ] = quantity;
    container.playercontents[ player.guid ].contents[ containerindex ][ "lootID" ] = lootid;
    
    if ( noextract )
    {
        container.playercontents[ player.guid ].contents[ containerindex ][ "noExtract" ] = 1;
        return;
    }
    
    container.playercontents[ player.guid ].contents[ containerindex ][ "noExtract" ] = undefined;
}

// Namespace extraction_container
// Params 4
// Checksum 0x38bda39b, Offset: 0x8c8
// Size: 0x614
function function_e1575793b130643f( itemtype, itemindex, noextract, dropall )
{
    [ items, lastvalidindex ] = loot_mp::function_bd786d01398cca27( self.var_50f741a14f09a6.playercontents[ self.guid ].contents, self, self.var_50f741a14f09a6 );
    self.var_50f741a14f09a6.playercontents[ self.guid ].contents = items;
    containersize = function_f40f1b8493967f01( self.var_50f741a14f09a6 );
    
    for ( i = lastvalidindex + 1; i < containersize ; i++ )
    {
        self.var_50f741a14f09a6.playercontents[ self.guid ].contents[ i ] = undefined;
    }
    
    container = self.var_50f741a14f09a6.playercontents[ self.guid ];
    weaponslotid = loot_mp::function_6d3e17fbc5d75dde( "loot_container_weapon" );
    
    if ( weaponslotid && itemtype == 1 )
    {
        hud_message::showerrormessage( %"mp/balloon_extract_deny_no_room" );
        return;
    }
    
    [ lootid, quantity, weaponobj ] = function_f58dedc518edc462( itemtype, itemindex, dropall );
    
    if ( !isdefined( lootid ) || br_instance_inventory::isdeaddropitem( lootid ) )
    {
        return;
    }
    
    if ( lootid == 0 || quantity == 0 && !isdefined( weaponobj ) )
    {
        return;
    }
    
    if ( itemtype == 1 && isdefined( weaponobj ) )
    {
        if ( weapon::isstimpistolweapon( weaponobj ) )
        {
            return;
        }
        
        metadata = undefined;
        
        if ( br_instance_inventory::function_926a8f8643d34690() )
        {
            metadata = br_instance_inventory::function_6a05cf5689058e1f( self, itemindex );
        }
        
        altcount = undefined;
        
        if ( weaponobj.hasalternate )
        {
            altweapon = weaponobj getaltweapon();
            
            if ( isdefined( altweapon ) )
            {
                altcount = self getweaponammoclip( altweapon );
            }
        }
        
        lefthandcount = undefined;
        
        if ( weapon::isakimbo( weaponobj ) )
        {
            lefthandcount = self getweaponammoclip( weaponobj, "left" );
        }
        
        loot_mp::function_3d4987dd14eeffe0( self, self.var_50f741a14f09a6.playercontents[ self.guid ], weaponobj, lootid, itemtype, itemindex, quantity, metadata, noextract, altcount, lefthandcount );
        return;
    }
    
    containerindex = container.contents.size;
    canstack = undefined;
    droppedquantity = quantity;
    
    foreach ( index, item in container.contents )
    {
        if ( !( isdefined( item ) && isdefined( item[ "quantity" ] ) && isdefined( item[ "lootID" ] ) ) )
        {
            continue;
        }
        
        totalquantity = quantity + item[ "quantity" ];
        
        if ( item[ "lootID" ] == 8395 && lootid == item[ "lootID" ] && totalquantity < 4095 )
        {
            containerindex = index;
            quantity = totalquantity;
            canstack = 1;
            break;
        }
        
        scriptablename = loot::getScriptableFromLootID( lootid );
        maxcount = level.br_pickups.var_3444316dc55e4b0a[ scriptablename ];
        
        if ( !isdefined( maxcount ) || maxcount == 0 )
        {
            maxcount = level.br_pickups.maxcounts[ scriptablename ];
        }
        
        if ( !isdefined( maxcount ) || maxcount == 0 )
        {
            continue;
        }
        
        if ( item[ "lootID" ] == lootid && totalquantity <= maxcount && totalquantity < 4095 )
        {
            containerindex = index;
            quantity = totalquantity;
            canstack = 1;
            break;
        }
    }
    
    if ( containerindex >= containersize && itemtype != 1 && !canstack )
    {
        hud_message::showerrormessage( %"mp/balloon_extract_deny_no_room" );
        return;
    }
    
    if ( isdefined( self.var_50f741a14f09a6.var_444df56487288e2a ) )
    {
        [ lootid, var_5e5e85156948df48 ] = [[ self.var_50f741a14f09a6.var_444df56487288e2a ]]( self.var_50f741a14f09a6, self, lootid, quantity, itemtype, itemindex, containerindex );
        
        if ( var_5e5e85156948df48 )
        {
            noextract = var_5e5e85156948df48;
        }
    }
    
    if ( br_pickups::function_c1a47b070ee27c93( lootid ) )
    {
        thread br_pickups::quickdropplunder( self, itemtype, undefined, 1, droppedquantity );
    }
    else if ( dropall && !br_pickups::function_9839731fa9d707c0( lootid ) )
    {
        thread br_pickups::quickdropall( itemtype, itemindex, 1 );
    }
    else
    {
        thread br_pickups::quickdropitem( itemtype, itemindex, 1 );
    }
    
    self.var_50f741a14f09a6.playercontents[ self.guid ].contents[ containerindex ][ "quantity" ] = quantity;
    self.var_50f741a14f09a6.playercontents[ self.guid ].contents[ containerindex ][ "lootID" ] = lootid;
    
    if ( noextract )
    {
        self.var_50f741a14f09a6.playercontents[ self.guid ].contents[ containerindex ][ "noExtract" ] = 1;
    }
    else
    {
        self.var_50f741a14f09a6.playercontents[ self.guid ].contents[ containerindex ][ "noExtract" ] = undefined;
    }
    
    function_21eafe9722001305( self, self.var_50f741a14f09a6 );
    scriptablename = loot::getScriptableFromLootID( lootid );
    
    if ( br_pickups::function_fe0521864025d97e( scriptablename ) )
    {
        br_pickups::function_58fb35e7414b9c05( undefined, undefined, scriptablename, itemindex );
    }
}

// Namespace extraction_container
// Params 2
// Checksum 0x733a571d, Offset: 0xee4
// Size: 0x13f
function function_21eafe9722001305( opener, container )
{
    [ items, lastvalidindex ] = loot_mp::function_bd786d01398cca27( container.playercontents[ opener.guid ].contents, opener, container );
    container.playercontents[ opener.guid ].contents = items;
    containersize = function_f40f1b8493967f01( container );
    
    /#
        if ( items.size > containersize )
        {
            println( "<dev string:x24>" + items.size + "<dev string:x58>" + containersize + "<dev string:x71>" );
        }
    #/
    
    for ( itemindex = 0; itemindex < containersize ; itemindex++ )
    {
        loot_mp::function_8632ef63c71b6048( opener, itemindex );
    }
    
    for ( itemindex = 0; itemindex < containersize ; itemindex++ )
    {
        if ( itemindex <= lastvalidindex )
        {
            loot_mp::function_7875275a0511dfeb( opener, container.playercontents[ opener.guid ], itemindex, items[ itemindex ][ "lootID" ], items[ itemindex ][ "quantity" ], items[ itemindex ][ "ref" ] );
        }
    }
}

// Namespace extraction_container
// Params 1
// Checksum 0xb8982a87, Offset: 0x102b
// Size: 0x67
function function_4a93ddb93467f187( scriptablename )
{
    containertype = 1;
    
    switch ( scriptablename )
    {
        case #"hash_8387e0bfe22abc5d":
        case #"hash_f1db14019ca6a516":
            containertype = 15;
            break;
        case #"hash_884fc5db10bac9b3":
            containertype = 13;
            break;
        default:
            break;
    }
    
    return containertype;
}

// Namespace extraction_container
// Params 1
// Checksum 0x5892e3cd, Offset: 0x109b
// Size: 0x99
function function_f40f1b8493967f01( container )
{
    containertype = container.containertype;
    hasweaponslot = !container.noweaponslot ? 1 : 0;
    
    switch ( containertype )
    {
        case 15:
            return ( getdvarint( @"scr_dmz_dead_drop_slots", 4 ) - hasweaponslot );
        case 13:
            return ( getdvarint( @"scr_balloon_extract_slots", 4 ) - hasweaponslot );
        default:
            return 55;
    }
}

// Namespace extraction_container
// Params 3
// Checksum 0x985ca3ec, Offset: 0x113c
// Size: 0x169
function function_f58dedc518edc462( itemtype, itemindex, dropall )
{
    switch ( itemtype )
    {
        case 10:
            lootid = common_inventory::inventory_getlootidatbackpackindex( itemindex );
            
            if ( !isdefined( lootid ) )
            {
                return [ 0, 0 ];
            }
            
            scriptablename = loot::getScriptableFromLootID( lootid );
            quantity = 1;
            
            if ( dropall || br_pickups::function_bcc6dc9b2b7365e0( lootid ) )
            {
                quantity = common_inventory::inventory_getquantityatbackpackindex( itemindex );
            }
            else if ( isdefined( scriptablename ) && br_public::isammo( scriptablename ) )
            {
                quantity = int( min( common_inventory::inventory_getquantityatbackpackindex( itemindex ), level.br_pickups.counts[ scriptablename ] ) );
            }
            else
            {
                quantity = 1;
            }
            
            return [ lootid, quantity ];
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 6:
        case 7:
            return br_default_inventory::function_7efe1c7f7b48fea7( itemtype, itemindex, 1, 1, !istrue( dropall ) );
        default:
            assertmsg( "<dev string:x73>" + itemtype );
            return;
    }
}

// Namespace extraction_container
// Params 1
// Checksum 0x49087f7f, Offset: 0x12ad
// Size: 0x9c
function function_e388824327a192fb( player )
{
    if ( !loot_mp::iscontaineropen( player ) )
    {
        return 0;
    }
    
    if ( !isdefined( player.var_50f741a14f09a6 ) )
    {
        return 0;
    }
    
    if ( !isdefined( player.var_50f741a14f09a6.containertype ) )
    {
        return 0;
    }
    
    containertype = player.var_50f741a14f09a6.containertype;
    
    switch ( containertype )
    {
        case 13:
        case 15:
            return 1;
        default:
            return 0;
    }
}

// Namespace extraction_container
// Params 2
// Checksum 0xf563aa0a, Offset: 0x1351
// Size: 0x69, Type: bool
function function_7d765df3b451de6a( player, container )
{
    if ( !function_e388824327a192fb( player ) )
    {
        return false;
    }
    
    if ( player.var_50f741a14f09a6.containertype != container.containertype )
    {
        return false;
    }
    
    if ( !isdefined( container.playeropen[ player.guid ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace extraction_container
// Params 1
// Checksum 0x11c263c, Offset: 0x13c3
// Size: 0xb7
function function_b241e22ad86550a1( player )
{
    if ( !loot_mp::iscontaineropen( player ) )
    {
        return 0;
    }
    
    if ( !isdefined( player.var_50f741a14f09a6 ) )
    {
        return 0;
    }
    
    if ( !isdefined( player.var_50f741a14f09a6.containertype ) )
    {
        return 0;
    }
    
    containertype = player.var_50f741a14f09a6.containertype;
    
    switch ( containertype )
    {
        case 15:
            return getdvarint( @"hash_6ee9465e13d271e5", 0 );
        case 13:
            return getdvarint( @"scr_balloon_extract_use_weapon_slot", 0 );
        default:
            return 0;
    }
}

// Namespace extraction_container
// Params 1
// Checksum 0x90cb0fd3, Offset: 0x1482
// Size: 0xee
function function_1cf7382eb22db968( contents )
{
    contentsarray = [];
    
    foreach ( key, item in contents )
    {
        contentsarray[ key ] = spawnstruct();
        contentsarray[ key ].lootid = item[ "lootID" ];
        contentsarray[ key ].quantity = item[ "quantity" ];
        contentsarray[ key ].index = item[ "index" ];
        
        if ( isdefined( item[ "noExtract" ] ) )
        {
            contentsarray[ key ].noextract = item[ "noExtract" ];
        }
    }
    
    return contentsarray;
}

