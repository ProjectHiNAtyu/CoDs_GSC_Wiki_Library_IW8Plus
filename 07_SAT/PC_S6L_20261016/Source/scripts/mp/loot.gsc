// scripts\mp\loot.gsc  (hash_5cefbbf3a6a9a8b0.gscc) (size: 48206 Bytes / 0xbc4e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9a0adc97 (2584403095)
// size ...... 48206 (0xbc4e)
// includes .. 36  (offset: 0xb426)
// strings ... 95  (offset: 0xb546)
// dev strs .. 11  (offset: 0xbbb6)
// exports ... 96  (offset: 0x8132)
// cseg ...... 0xb98 + 0x759a (0x8132)
// imports ... 271 (offset: 0x9032)
// animtree1 . 0   (offset: 0xbc4e)
// animtree2 . 0   (offset: 0xbc4e)
#using script_16ea1b94f0f381b3;
#using script_70ac8a06d80020b0;
#using scripts\common\ae_utility;
#using scripts\common\math;
#using scripts\common\script;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\br\gametypes\br_elite_broken_arrow;
#using scripts\mp\br\gametypes\br_instance_inventory;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_strongholds;
#using scripts\mp\br\gametypes\br_weapons;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\calloutmarkerping_mp;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\dmz\gametypes\dmz_dog_tag;
#using scripts\mp\equipment;
#using scripts\mp\hud_message;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\pickups_scriptable;
#using scripts\mp\quickprompt;

#namespace loot_mp;

// Namespace loot_mp
// Params 0
// Checksum 0xdb787928, Offset: 0xbb6
// Size: 0x64
function init()
{
    level.lootweaponcache = [];
    level.lootweaponrefs = [];
    var_70a9d655f2d1a23c = getdvarint( @"hash_d8d8d08bfd9ec4df", 30 );
    var_665992a5af7cc45e = getdvarint( @"hash_17fe9acebdd2352", 5 );
    level.var_4e86bf04cdc5d172 = var_70a9d655f2d1a23c * var_70a9d655f2d1a23c;
    level.var_665992a5af7cc45e = var_665992a5af7cc45e * var_665992a5af7cc45e;
}

// Namespace loot_mp
// Params 2
// Checksum 0x8edc1d57, Offset: 0xc22
// Size: 0x61
function getweaponassetfromrootweapon( rootweaponname, variantid )
{
    varianttable = "mp/loot/weapon/" + rootweaponname + ".csv";
    weaponasset = tablelookup( varianttable, 0, variantid, 3 );
    assert( weaponasset, "<dev string:x24>" + rootweaponname + "<dev string:x52>" + variantid );
    return weaponasset;
}

// Namespace loot_mp
// Params 2
// Checksum 0x744abd66, Offset: 0xc8c
// Size: 0x61
function lookupvariantref( rootweaponname, variantid )
{
    varianttable = "mp/loot/weapon/" + rootweaponname + ".csv";
    variantref = tablelookup( varianttable, 0, variantid, 1 );
    assert( variantref, "<dev string:x64>" + rootweaponname + "<dev string:x52>" + variantid );
    return variantref;
}

// Namespace loot_mp
// Params 1
// Checksum 0x213f67cf, Offset: 0xcf6
// Size: 0x28, Type: bool
function isweaponitem( lootitemid )
{
    itemtype = loot::function_52cf8374c44a4ff5( lootitemid );
    return itemtype == "weapon";
}

// Namespace loot_mp
// Params 1
// Checksum 0xaf351cf7, Offset: 0xd27
// Size: 0x28, Type: bool
function iskillstreakitem( lootitemid )
{
    itemtype = loot::function_52cf8374c44a4ff5( lootitemid );
    return itemtype == "weapon";
}

// Namespace loot_mp
// Params 2
// Checksum 0x72c27494, Offset: 0xd58
// Size: 0x53
function getweaponqualitybyid( weapon, variantid )
{
    if ( !isdefined( variantid ) || variantid < 0 )
    {
        return 0;
    }
    
    var_ab0b84ab4a39a20 = getweaponloottable( weapon );
    quality = int( tablelookup( var_ab0b84ab4a39a20, 0, variantid, 4 ) );
    return quality;
}

// Namespace loot_mp
// Params 4
// Checksum 0xb72c056f, Offset: 0xdb4
// Size: 0xdf, Type: bool
function isvalidslot( opener, container, itemindex, overridecontents )
{
    contents = overridecontents ?? container.contents;
    
    if ( !isdefined( contents[ itemindex ] ) )
    {
        return false;
    }
    
    item = contents[ itemindex ];
    quantity = item[ "quantity" ];
    lootid = item[ "lootID" ];
    team = item[ "team" ];
    visibilitycondition = item[ "visibilityCondition" ];
    
    if ( quantity > 0 && lootid > 0 && ( !isdefined( team ) || team == opener.team ) && ( !isdefined( visibilitycondition ) || [[ visibilitycondition ]]( opener, container ) ) )
    {
        return true;
    }
    
    return false;
}

// Namespace loot_mp
// Params 3
// Checksum 0xdd16dadd, Offset: 0xe9c
// Size: 0xd0, Type: bool
function isvalidloadoutslot( opener, container, itemindex )
{
    if ( !isdefined( container.loadoutcontents[ itemindex ] ) )
    {
        return false;
    }
    
    item = container.loadoutcontents[ itemindex ];
    quantity = item[ "quantity" ];
    lootid = item[ "lootID" ];
    team = item[ "team" ];
    visibilitycondition = item[ "visibilityCondition" ];
    
    if ( quantity > 0 && lootid > 0 && ( !isdefined( team ) || team == opener.team ) && ( !isdefined( visibilitycondition ) || [[ visibilitycondition ]]( opener, container ) ) )
    {
        return true;
    }
    
    return false;
}

// Namespace loot_mp
// Params 1
// Checksum 0x15967036, Offset: 0xf75
// Size: 0x67
function function_94d2c71ab19b61e6( container )
{
    if ( !isdefined( container.containertype ) )
    {
        return 1;
    }
    
    switch ( container.containertype )
    {
        case 13:
        case 14:
        case 15:
            return 0;
        default:
            return 1;
    }
}

// Namespace loot_mp
// Params 3
// Checksum 0x76440a80, Offset: 0xfe4
// Size: 0x181
function function_1122c02678431bd4( opener, container, var_bf6425333f1080a8 )
{
    loadoutcontents = container.loadoutcontents;
    
    if ( !isdefined( var_bf6425333f1080a8 ) )
    {
        var_bf6425333f1080a8 = [];
    }
    
    if ( !isdefined( container.var_aa16d22e51056da1 ) )
    {
        container.var_aa16d22e51056da1 = [];
    }
    
    if ( isdefined( loadoutcontents ) )
    {
        foreach ( itemindex, item in loadoutcontents )
        {
            lootid = 0;
            quantity = 0;
            
            if ( isdefined( item[ "lootID" ] ) )
            {
                lootid = item[ "lootID" ];
                quantity = item[ "quantity" ];
            }
            
            if ( lootid == 0 || quantity == 0 )
            {
                continue;
            }
            
            newquantity = getautopickupquantity( opener, lootid, quantity );
            
            if ( newquantity != quantity )
            {
                currentsize = var_bf6425333f1080a8.size;
                var_bf6425333f1080a8[ currentsize ] = spawnstruct();
                var_bf6425333f1080a8[ currentsize ].index = itemindex + 11;
                var_bf6425333f1080a8[ currentsize ].takeamount = quantity;
                var_bf6425333f1080a8[ currentsize ].lootid = lootid;
                container.var_aa16d22e51056da1[ currentsize ] = itemindex;
            }
        }
    }
    
    return var_bf6425333f1080a8;
}

// Namespace loot_mp
// Params 3
// Checksum 0x27851c99, Offset: 0x116e
// Size: 0x3d8
function getautopickupquantity( opener, lootid, quantity )
{
    lootname = loot::getScriptableFromLootID( lootid );
    
    if ( !isdefined( lootname ) )
    {
        return quantity;
    }
    
    maxcount = level.br_pickups.var_3444316dc55e4b0a[ lootname ];
    
    if ( !isdefined( maxcount ) || maxcount == 0 )
    {
        maxcount = level.br_pickups.maxcounts[ lootname ];
    }
    
    result = utility::callsharedfunc( #"gametype", #"getautopickupquantity", lootid, lootname, quantity, maxcount );
    
    if ( isdefined( result ) )
    {
        return result;
    }
    
    if ( maxcount > 0 && isdefined( lootid ) )
    {
        for ( i = 0; i < opener common_inventory::function_9cd65c8312048802() ; i++ )
        {
            currentlootid = opener common_inventory::inventory_getlootidatbackpackindex( i );
            
            if ( currentlootid == lootid )
            {
                slotquantity = opener common_inventory::inventory_getquantityatbackpackindex( i );
                
                if ( slotquantity < maxcount )
                {
                    return int( max( 0, slotquantity + quantity - maxcount ) );
                }
            }
        }
    }
    
    if ( br_public::isammo( lootname ) )
    {
        allweaps = opener getweaponslistprimaries();
        
        foreach ( weap in allweaps )
        {
            ammotypecomparison = br_weapons::br_ammo_type_for_weapon( weap );
            
            if ( lootname == ammotypecomparison && opener.br_ammo[ lootname ] < level.var_9a6a4b42eba220f6[ lootname ] )
            {
                return int( max( 0, opener.br_ammo[ lootname ] + quantity - level.var_9a6a4b42eba220f6[ lootname ] ) );
            }
        }
    }
    
    if ( br_public::isarmorplate( lootname ) )
    {
        equipname = level.br_pickups.br_equipname[ lootname ];
        slot = level.equipment.table[ equipname ].defaultslot;
        
        if ( !isdefined( opener.equipment[ slot ] ) || opener br_pickups::equipmentslothasroom( lootname, slot ) )
        {
            currentslotammo = opener equipment_mp::getequipmentslotammo( slot );
            
            if ( !isdefined( currentslotammo ) )
            {
                currentslotammo = 0;
            }
            
            var_10dde5538f1daae6 = opener equipment_mp::getequipmentmaxammo( equipname );
            return int( max( 0, currentslotammo + quantity - var_10dde5538f1daae6 ) );
        }
    }
    
    if ( br_pickups::function_7019629f2a3b016c( lootname ) || br_pickups::function_a1f9f8123c01bb3b( lootname ) )
    {
        equipname = level.br_pickups.br_equipname[ lootname ];
        slot = level.equipment.table[ equipname ].defaultslot;
        
        if ( opener br_pickups::pickupissameasequipmentslot( equipname, slot ) && opener br_pickups::equipmentslothasroom( lootname, slot ) )
        {
            currentslotammo = opener equipment_mp::getequipmentslotammo( slot );
            
            if ( !isdefined( currentslotammo ) )
            {
                currentslotammo = 0;
            }
            
            var_10dde5538f1daae6 = opener equipment_mp::getequipmentmaxammo( equipname );
            return int( max( 0, currentslotammo + quantity - var_10dde5538f1daae6 ) );
        }
    }
    
    if ( br_pickups::isplunder( lootname ) )
    {
        if ( opener.plundercount >= level.br_plunder.plunderlimit )
        {
            return quantity;
        }
        
        currentplunder = opener.plundercount ?? 0;
        maxplunder = level.br_plunder.plunderlimit ?? currentplunder + quantity;
        return int( max( 0, currentplunder + quantity - maxplunder ) );
    }
    
    return quantity;
}

// Namespace loot_mp
// Params 4
// Checksum 0x78fd356f, Offset: 0x154f
// Size: 0x582
function function_d92e1e6730619203( opener, container, items, parentcontainer )
{
    opener endon( #"death_or_disconnect" );
    opener endon( #"enter_live_ragdoll" );
    container endon( #"closed" );
    level endon( #"game_ended" );
    waittime = 0.55;
    var_e6c435eaeba3475b = getdvarfloat( @"hash_d9e519d9c89af2f3", 0 );
    
    if ( var_e6c435eaeba3475b > 0 )
    {
        waittime = var_e6c435eaeba3475b + 0.2;
    }
    
    var_bfbfd6f1af0ec2e7 = getdvarfloat( @"hash_12b0e0c79ccf572d", 0 );
    
    if ( var_bfbfd6f1af0ec2e7 > 0 )
    {
        waittime = 0.35 + var_bfbfd6f1af0ec2e7;
        
        if ( var_e6c435eaeba3475b > 0 )
        {
            waittime = var_e6c435eaeba3475b + var_bfbfd6f1af0ec2e7;
        }
    }
    
    var_33046434811e12f1 = getdvarint( @"hash_ab7929439577c576", 1 );
    wait waittime;
    
    foreach ( item in items )
    {
        if ( !player::isreallyalive( opener ) || !iscontaineropen( opener ) || iscontainerempty( container, opener ) )
        {
            if ( isdefined( container.reservedindex ) )
            {
                container.reservedindex = [];
            }
            
            if ( isdefined( container.var_aa16d22e51056da1 ) )
            {
                container.var_aa16d22e51056da1 = [];
            }
            
            return;
        }
        
        if ( !( isdefined( item ) && isdefined( item.lootid ) && isdefined( item.takeamount ) && isdefined( item.index ) ) )
        {
            continue;
        }
        
        if ( !function_56d525c33dd2bd84( item.index ) && !isvalidslot( opener, container, item.index ) )
        {
            continue;
        }
        
        if ( function_56d525c33dd2bd84( item.index ) && !isvalidloadoutslot( opener, container, item.index - 11 ) )
        {
            continue;
        }
        
        itemtaken = 0;
        
        if ( isdefined( container.contents ) )
        {
            foreach ( content in container.contents )
            {
                if ( function_56d525c33dd2bd84( item.index ) )
                {
                    break;
                }
                
                currentlootid = content[ "lootID" ];
                
                if ( currentlootid == item.lootid )
                {
                    quantity = content[ "quantity" ];
                    newquantity = getautopickupquantity( opener, item.lootid, quantity );
                    
                    if ( quantity != newquantity )
                    {
                        itemtaken = 1;
                        function_2eb63da268420582( opener, item.index, container );
                        var_d395b032111261c8 = quantity - newquantity;
                        assert( var_d395b032111261c8 >= 0, "<dev string:x91>" + currentlootid );
                        
                        if ( var_d395b032111261c8 < 0 )
                        {
                            continue;
                        }
                        
                        function_3d2df00a6e925f1b( opener, item.index, var_d395b032111261c8, parentcontainer, 1 );
                        
                        if ( isdefined( container ) && iscontainerempty( container, opener ) && iscontaineropen( opener ) )
                        {
                            common_cache::closelootablecontainer( container, opener );
                        }
                        
                        if ( !var_33046434811e12f1 )
                        {
                            wait getdvarfloat( @"hash_f920b46a5250c2a9", 0.33 );
                        }
                    }
                }
            }
        }
        
        if ( function_56d525c33dd2bd84( item.index ) && isdefined( container.loadoutcontents ) )
        {
            for ( i = 0; i < container.loadoutcontents.size ; i++ )
            {
                if ( !isdefined( container.loadoutcontents[ i ] ) )
                {
                    continue;
                }
                
                currentlootid = container.loadoutcontents[ i ][ "lootID" ];
                
                if ( currentlootid == item.lootid )
                {
                    quantity = container.loadoutcontents[ i ][ "quantity" ];
                    newquantity = getautopickupquantity( opener, item.lootid, quantity );
                    
                    if ( quantity != newquantity )
                    {
                        itemtaken = 1;
                        function_2eb63da268420582( opener, item.index, container );
                        var_d395b032111261c8 = quantity - newquantity;
                        function_3d2df00a6e925f1b( opener, item.index, var_d395b032111261c8, parentcontainer, 1 );
                        
                        if ( isdefined( container ) && iscontainerempty( container, opener ) && iscontaineropen( opener ) )
                        {
                            common_cache::closelootablecontainer( container, opener );
                        }
                        
                        if ( !var_33046434811e12f1 )
                        {
                            wait getdvarfloat( @"hash_f920b46a5250c2a9", 0.33 );
                        }
                    }
                }
            }
        }
        
        if ( itemtaken && var_33046434811e12f1 )
        {
            wait getdvarfloat( @"hash_f920b46a5250c2a9", 0.33 );
        }
    }
    
    if ( isdefined( container.reservedindex ) )
    {
        container.reservedindex = [];
    }
    
    if ( isdefined( container.var_aa16d22e51056da1 ) )
    {
        container.var_aa16d22e51056da1 = [];
    }
}

// Namespace loot_mp
// Params 1
// Checksum 0x2cad09ad, Offset: 0x1ad9
// Size: 0x18
function getlootweaponref( lootitemid )
{
    return level.lootweaponrefs[ lootitemid ];
}

// Namespace loot_mp
// Params 1
// Checksum 0x974e45cc, Offset: 0x1afa
// Size: 0x87
function function_1b8abd5d31371481( scriptablename )
{
    if ( !isdefined( scriptablename ) )
    {
        return 8;
    }
    
    if ( br_pickups::isrevivepickup( scriptablename ) )
    {
        return 0;
    }
    
    if ( br_pickups::iskillstreak( scriptablename ) )
    {
        return 1;
    }
    
    if ( br_public::isarmorplate( scriptablename ) )
    {
        return 2;
    }
    
    if ( br_public::function_d115f1547e28f0c6( scriptablename ) )
    {
        return 3;
    }
    
    if ( br_pickups::function_cfce107ef35a347e( scriptablename ) )
    {
        return 4;
    }
    
    if ( br_pickups::issuperpickup( scriptablename ) )
    {
        return 5;
    }
    
    if ( br_public::isequipment( scriptablename ) )
    {
        return 6;
    }
    
    if ( br_public::isammo( scriptablename ) )
    {
        return 7;
    }
    
    return 8;
}

// Namespace loot_mp
// Params 2
// Checksum 0xd63fb16f, Offset: 0x1b8a
// Size: 0x97, Type: bool
function function_91d37445f9ae37eb( itema, itemb )
{
    if ( !( isdefined( itema ) && isdefined( itemb ) ) )
    {
        return true;
    }
    
    if ( !itema[ "lootID" ] || !itemb[ "lootID" ] || !itema[ "quantity" ] || !itemb[ "quantity" ] )
    {
        return true;
    }
    
    prioritya = function_1b8abd5d31371481( loot::getScriptableFromLootID( itema[ "lootID" ] ) );
    priorityb = function_1b8abd5d31371481( loot::getScriptableFromLootID( itemb[ "lootID" ] ) );
    return prioritya < priorityb;
}

// Namespace loot_mp
// Params 2
// Checksum 0x2a7224fe, Offset: 0x1c2a
// Size: 0x6dd
function openlootablecontainer( opener, container )
{
    parentcontainer = container;
    
    if ( function_13a69e0034bdf2f9( opener, container ) )
    {
        parentcontainer = container;
        container = function_89b43bf99e20a168( opener, container );
        container.origin = parentcontainer.origin;
        container.angles = parentcontainer.angles;
    }
    
    if ( function_5cdaa261d954d20( container ) && getdvarint( @"hash_ab065f0da94d8ff", 1 ) )
    {
        [ items, lastvalidindex ] = function_bd786d01398cca27( container.contents, opener, container );
        container.contents = items;
        container.contents = arraysort( container.contents, undefined, &function_91d37445f9ae37eb );
    }
    
    weaponcount = 0;
    
    for ( itemindex = 0; itemindex < 55 ; itemindex++ )
    {
        if ( isvalidslot( opener, container, itemindex ) )
        {
            if ( isweaponitem( container.contents[ itemindex ][ "lootID" ] ) )
            {
                tmp = container.contents[ weaponcount ];
                container.contents[ weaponcount ] = container.contents[ itemindex ];
                container.contents[ itemindex ] = tmp;
                weaponcount++;
            }
        }
    }
    
    items = container.contents;
    opener.var_50f741a14f09a6 = parentcontainer;
    opener.var_75f60e367c30d7ac = opener.origin;
    parentcontainer.opener = opener;
    
    if ( isplayer( opener ) )
    {
        opener function_5eadd7aca3a1194d( items, parentcontainer.containertype );
    }
    
    if ( isdefined( container.linkedparent ) )
    {
        opener.var_75f60e367c30d7ac = rotatevectorinverted( opener.origin - parentcontainer.linkedparent.origin, parentcontainer.linkedparent.angles );
    }
    
    /#
        if ( items.size > 55 )
        {
            println( "<dev string:xcf>" + items.size + "<dev string:x103>" + 55 + "<dev string:x11c>" );
        }
    #/
    
    var_bf6425333f1080a8 = [];
    var_35d455e7476f277e = 0;
    container.reservedindex = [];
    
    for ( itemindex = 0; itemindex < 55 ; itemindex++ )
    {
        if ( isvalidslot( opener, container, itemindex ) )
        {
            newquantity = items[ itemindex ][ "quantity" ];
            
            if ( getdvarint( @"hash_c272dfd858eba88f", 1 ) && function_94d2c71ab19b61e6( parentcontainer ) )
            {
                newquantity = getautopickupquantity( opener, items[ itemindex ][ "lootID" ], items[ itemindex ][ "quantity" ] );
            }
            
            function_7875275a0511dfeb( opener, container, itemindex, items[ itemindex ][ "lootID" ], items[ itemindex ][ "quantity" ], items[ itemindex ][ "ref" ] );
            
            if ( newquantity != items[ itemindex ][ "quantity" ] )
            {
                currentsize = var_bf6425333f1080a8.size;
                var_bf6425333f1080a8[ currentsize ] = spawnstruct();
                var_bf6425333f1080a8[ currentsize ].index = itemindex;
                var_bf6425333f1080a8[ currentsize ].takeamount = items[ itemindex ][ "quantity" ];
                var_bf6425333f1080a8[ currentsize ].lootid = items[ itemindex ][ "lootID" ];
                
                if ( !opener function_236aa4cd547af143() )
                {
                    container.reservedindex[ currentsize ] = itemindex;
                }
            }
            
            continue;
        }
        
        function_8632ef63c71b6048( opener, itemindex );
    }
    
    if ( isdefined( container.weaponslotcontents ) )
    {
        function_5b66206be41a47a7( opener, container, "loot_container_weapon", container.weaponslotcontents, container.weaponslotobj );
    }
    else
    {
        opener setclientomnvar( "loot_container_weapon", 0 );
    }
    
    if ( !isdefined( parentcontainer.containertype ) )
    {
        parentcontainer.containertype = 1;
    }
    
    containertype = parentcontainer.containertype;
    
    if ( containertype == 6 )
    {
        if ( isdefined( parentcontainer.owner ) && isdefined( parentcontainer.owner.sessionuimemberindex ) && parentcontainer.owner.team == opener.team )
        {
            containertype = 7 + parentcontainer.owner.sessionuimemberindex;
        }
        
        if ( isdefined( parentcontainer.deadplayerindex ) )
        {
            opener setclientomnvar( "loot_container_dead_player_index", parentcontainer.deadplayerindex );
        }
    }
    
    if ( function_5cdaa261d954d20( parentcontainer ) )
    {
        if ( isdefined( parentcontainer.deadplayerindex ) )
        {
            opener setclientomnvar( "loot_container_dead_player_index", parentcontainer.deadplayerindex );
        }
        
        if ( isdefined( parentcontainer.backpacksize ) )
        {
            opener setclientomnvar( "loot_container_dead_player_backpack_size", parentcontainer.backpacksize );
        }
        
        if ( utility::issharedfuncdefined( #"hash_4dec7d3fa4499fe0", #"hash_5c2170e957638d6" ) )
        {
            opener [[ utility::getsharedfunc( #"hash_4dec7d3fa4499fe0", #"hash_5c2170e957638d6" ) ]]( parentcontainer );
        }
        
        var_bf6425333f1080a8 = function_1122c02678431bd4( opener, container, var_bf6425333f1080a8 );
        function_c823755017c8b17( opener, container );
    }
    
    if ( var_bf6425333f1080a8.size > 0 && !opener function_236aa4cd547af143() )
    {
        thread function_d92e1e6730619203( opener, container, var_bf6425333f1080a8, parentcontainer );
    }
    
    opener setclientomnvar( "loot_container_open", containertype );
    
    if ( level.var_ed6ba5511b904dbd && !parentcontainer.previouslyopened && parentcontainer.containertype != 13 && parentcontainer.containertype != 15 && parentcontainer.containertype != 17 && parentcontainer.containertype != 18 && parentcontainer.containertype != 19 && !function_5cdaa261d954d20( parentcontainer ) )
    {
        parentcontainer.previouslyopened = 1;
        
        if ( !isdefined( opener.containerslooted ) )
        {
            opener.containerslooted = 0;
        }
        
        opener.containerslooted++;
        thread function_92c75b3dfc836cf( opener, parentcontainer, var_35d455e7476f277e );
    }
    
    dropstruct = pickups::function_f71dd588dc4f6288();
    parentcontainer.dropstruct = dropstruct;
    function_efefd20bca9f9846( container, opener );
    
    if ( opener function_236aa4cd547af143() )
    {
        container thread function_41cdd21ec7a2372a( container, opener, var_bf6425333f1080a8, parentcontainer );
    }
    
    parentcontainer thread function_3cd03ddb9c97fb47( parentcontainer, opener );
    parentcontainer thread function_f4864e365efb6c46( parentcontainer, opener );
    
    if ( function_13a69e0034bdf2f9( opener, container ) )
    {
        container.playercontents[ opener.guid ].contents = items;
    }
    
    opener calloutmarkerping::function_d34345aa1f30ebba();
}

// Namespace loot_mp
// Params 2
// Checksum 0x69cdecd2, Offset: 0x230f
// Size: 0x26e
function function_5eadd7aca3a1194d( items, container_type )
{
    if ( !isdefined( items ) )
    {
        return;
    }
    
    if ( !isdefined( items.size ) || items.size <= 0 )
    {
        return;
    }
    
    current_team = "unset";
    
    if ( isdefined( self.sessionteam ) )
    {
        current_team = self.sessionteam;
    }
    
    if ( isdefined( self.team ) )
    {
        current_team = self.team;
    }
    
    lpconlevel = "0";
    
    if ( isdefined( level.lpconmanager ) && isdefined( level.lpconmanager.currentalertlevel ) )
    {
        lpconlevel = string( level.lpconmanager.currentalertlevel );
    }
    
    itemids = [];
    itemcounts = [];
    
    foreach ( item in items )
    {
        itemcounts[ itemids.size ] = string( item[ "quantity" ] );
        itemids[ itemids.size ] = string( item[ "lootID" ] );
    }
    
    data = spawnstruct();
    data.player = self;
    data.current_team = current_team;
    data.x = self.origin[ 0 ];
    data.y = self.origin[ 1 ];
    data.z = self.origin[ 2 ];
    data.xrot = self.angles[ 0 ];
    data.yrot = self.angles[ 1 ];
    data.zrot = self.angles[ 2 ];
    data.lpconlevel = lpconlevel;
    data.matchtimeelapsed = int( game_utility_mp::getsecondspassed() );
    data.itemids = itemids;
    data.itemcounts = itemcounts;
    data.container_type = container_type;
    telemetry_utils::function_af2d366f9522f76f( "callback_dmz_on_container", data );
}

// Namespace loot_mp
// Params 4
// Checksum 0x7cc7c9d4, Offset: 0x2585
// Size: 0x47d
function function_41cdd21ec7a2372a( container, opener, var_bf6425333f1080a8, parentcontainer )
{
    opener endon( #"death_or_disconnect" );
    opener endon( #"enter_live_ragdoll" );
    container endon( #"closed" );
    level endon( #"game_ended" );
    startdelay = 0.5;
    pickupdelay = 0.2;
    currentindex = 0;
    wait startdelay;
    
    while ( opener activatekeypressed() && iscontaineropen( opener ) && currentindex < 55 && player::isreallyalive( opener ) && !iscontainerempty( container, opener ) )
    {
        if ( isvalidslot( opener, container, currentindex ) )
        {
            lootid = container.contents[ currentindex ][ "lootID" ];
            scriptablename = opener loot::getScriptableFromLootID( lootid );
            scriptableref = loot::function_f54ecb89dfab8e8c( lootid );
            equipitem = 0;
            stowweapon = 0;
            var_74545340acec6e99 = 0;
            
            if ( br_pickups::function_7019629f2a3b016c( scriptablename ) || br_pickups::function_a1f9f8123c01bb3b( scriptablename ) )
            {
                equipname = level.br_pickups.br_equipname[ scriptablename ];
                slot = level.equipment.table[ equipname ].defaultslot;
                
                if ( opener br_pickups::pickupissameasequipmentslot( equipname, slot ) )
                {
                    if ( opener br_pickups::equipmentslothasroom( scriptablename, slot ) )
                    {
                        equipitem = 1;
                    }
                }
                else if ( !isdefined( opener equipment_mp::getcurrentequipment( slot ) ) || opener equipment_mp::getequipmentslotammo( slot ) == 0 )
                {
                    equipitem = 1;
                }
            }
            else if ( pickups::isweaponpickup( scriptablename ) )
            {
                var_74545340acec6e99 = 1;
                
                foreach ( weaponobj in opener.primaryinventory )
                {
                    if ( weapon::isfistweapon( weaponobj ) )
                    {
                        equipitem = 1;
                        break;
                    }
                }
                
                if ( !equipitem && !opener common_inventory::function_d33e11a8dda3cb20() && opener common_inventory::function_9cd65c8312048802() >= 7 )
                {
                    stowweapon = 1;
                }
            }
            else if ( br_public::function_d115f1547e28f0c6( scriptablename ) )
            {
                carrierlevel = br_public::function_f7d29d5dab587ae1( scriptablename );
                
                if ( carrierlevel > opener.platecarrierlevel )
                {
                    equipitem = 1;
                }
            }
            else if ( br_public::isarmorplate( scriptablename ) )
            {
                equipitem = 1;
            }
            else if ( br_pickups::iskillstreak( scriptablename ) )
            {
                if ( !opener br_pickups::hasanykillstreak() )
                {
                    equipitem = 1;
                }
            }
            else if ( br_pickups::isgasmask( scriptablename ) )
            {
                if ( !isdefined( opener.gasmaskhealth ) )
                {
                    equipitem = 1;
                }
            }
            else if ( br_pickups::function_cfce107ef35a347e( scriptablename ) )
            {
                if ( !opener common_inventory::function_e332683b9ad5368b( lootid, 1 ) )
                {
                    equipitem = 1;
                }
            }
            else if ( br_pickups::isrevivepickup( scriptablename ) )
            {
                if ( !opener laststand::hasselfrevivetoken() )
                {
                    equipitem = 1;
                }
            }
            else if ( br_pickups::issuperpickup( scriptablename ) )
            {
                script::demoforcesre( "shouldFieldUpgradeGoToBackpack is deprecated. Add in common_inventory system logic instead." );
            }
            
            if ( scriptableref == "cash" )
            {
                function_2eb63da268420582( opener, currentindex, container );
                function_3d2df00a6e925f1b( opener, currentindex, container.contents[ currentindex ][ "quantity" ], container, 1 );
                wait pickupdelay;
            }
            else if ( equipitem )
            {
                opener function_4b734bd88c67417b( opener, currentindex, 0, container );
                wait pickupdelay;
            }
            else if ( stowweapon )
            {
                opener function_46e9fad35d05d811( 0, 100, container );
                wait pickupdelay;
            }
            else if ( !var_74545340acec6e99 && ( br_public::isammo( scriptablename ) || opener common_inventory::function_e332683b9ad5368b( lootid, container.contents[ currentindex ][ "quantity" ] ) ) )
            {
                opener function_a7da62c448fddcd8( opener, currentindex, container );
                wait pickupdelay;
            }
        }
        
        currentindex++;
    }
    
    if ( var_bf6425333f1080a8.size > 0 && currentindex < 55 && iscontaineropen( opener ) )
    {
        thread function_d92e1e6730619203( opener, container, var_bf6425333f1080a8, parentcontainer );
        return;
    }
    
    if ( isdefined( container ) && iscontainerempty( container, opener ) && iscontaineropen( opener ) )
    {
        common_cache::closelootablecontainer( container, opener );
    }
}

// Namespace loot_mp
// Params 2
// Checksum 0x71128e0d, Offset: 0x2a0a
// Size: 0x8e
function function_efefd20bca9f9846( container, opener )
{
    assert( isdefined( opener ) && isdefined( container ) );
    
    if ( isdefined( level.gamemodebundle ) )
    {
        if ( level.gamemodebundle.var_cb8b4e9602c493be )
        {
            playsoundatpos( opener.origin + ( 0, 0, 24 ), level.gamemodebundle.var_cb8b4e9602c493be );
        }
    }
    
    function_2fb22956d9d4cda3( opener, container.origin );
}

// Namespace loot_mp
// Params 2
// Checksum 0x34d3c20f, Offset: 0x2aa0
// Size: 0x22
function function_2fb22956d9d4cda3( player, origin )
{
    stealtheventbroadcastsimple( "examine_loot", player, origin );
}

// Namespace loot_mp
// Params 3
// Checksum 0x57cd9278, Offset: 0x2aca
// Size: 0x159
function function_bd786d01398cca27( items, opener, container )
{
    assert( isdefined( items ) );
    validitems = [];
    firstindex = 0;
    lastindex = items.size - 1;
    
    foreach ( item in items )
    {
        quantity = item[ "quantity" ];
        lootid = item[ "lootID" ];
        team = item[ "team" ];
        visibilitycondition = item[ "visibilityCondition" ];
        
        if ( quantity > 0 && lootid > 0 && ( !isdefined( team ) || team == opener.team ) && ( !isdefined( visibilitycondition ) || [[ visibilitycondition ]]( opener, container ) ) )
        {
            validitems[ firstindex ] = item;
            firstindex++;
            continue;
        }
        
        validitems[ lastindex ] = item;
        lastindex--;
    }
    
    return [ validitems, lastindex ];
}

// Namespace loot_mp
// Params 2
// Checksum 0x27d3c336, Offset: 0x2c2c
// Size: 0x45
function function_8632ef63c71b6048( player, index )
{
    player setclientomnvar( "loot_container_item_" + index, 0 );
    player setclientomnvar( "loot_container_quantity_" + index, 0 );
    player setclientomnvar( "loot_container_type_" + index, 0 );
}

// Namespace loot_mp
// Params 2
// Checksum 0x743029b5, Offset: 0x2c79
// Size: 0x62
function function_f4864e365efb6c46( container, opener )
{
    container endon( #"death" );
    level endon( #"game_ended" );
    container endon( #"closed" );
    opener utility::waittill_any( "close_container", "flashbang", "concussed", "weapon_fired" );
    common_cache::closelootablecontainer( container, opener );
}

// Namespace loot_mp
// Params 2
// Checksum 0x3a38565e, Offset: 0x2ce3
// Size: 0x4b, Type: bool
function function_d3b84fca43f1b29e( startingforward, opener )
{
    if ( !( isdefined( opener ) && isdefined( opener getplayerangles() ) ) )
    {
        return true;
    }
    
    newforward = anglestoforward( opener getplayerangles() );
    return math::anglebetweenvectors( startingforward, newforward ) > 20;
}

// Namespace loot_mp
// Params 3
// Checksum 0xb4a00196, Offset: 0x2d37
// Size: 0xec, Type: bool
function function_b2e1df6724895299( container, opener, framesstill )
{
    closedistance = level.var_4e86bf04cdc5d172;
    
    if ( framesstill > 2 && getdvarint( @"hash_419fd2f09b23942a", 1 ) )
    {
        closedistance = level.var_665992a5af7cc45e;
    }
    
    if ( isdefined( container.linkedparent ) )
    {
        newoffset = rotatevectorinverted( opener.origin - container.linkedparent.origin, container.linkedparent.angles );
        
        if ( distancesquared( opener.var_75f60e367c30d7ac, newoffset ) > closedistance )
        {
            return false;
        }
    }
    else if ( distancesquared( opener.var_75f60e367c30d7ac, opener.origin ) > closedistance )
    {
        return false;
    }
    
    return true;
}

// Namespace loot_mp
// Params 4
// Checksum 0x542ee17f, Offset: 0x2e2c
// Size: 0xa5, Type: bool
function function_6ac8084ec6f0a53b( container, opener, startingforward, framesstill )
{
    if ( opener.isdisconnecting )
    {
        return false;
    }
    
    if ( !player::isreallyalive( opener ) )
    {
        return false;
    }
    
    if ( function_aa0397fa378bc8e4( container ) && container.loadoutcontainer )
    {
        return true;
    }
    
    if ( !isdefined( opener.origin ) )
    {
        return false;
    }
    
    if ( !function_b2e1df6724895299( container, opener, framesstill ) )
    {
        return false;
    }
    
    if ( function_d3b84fca43f1b29e( startingforward, opener ) )
    {
        return false;
    }
    
    if ( opener playerads() > 0.5 )
    {
        return false;
    }
    
    return true;
}

// Namespace loot_mp
// Params 2
// Checksum 0xe4e4fc00, Offset: 0x2eda
// Size: 0x141
function function_3cd03ddb9c97fb47( container, opener )
{
    container endon( #"death" );
    level endon( #"game_ended" );
    container endon( #"closed" );
    startingforward = anglestoforward( opener getplayerangles() );
    framesstill = 0;
    
    while ( function_6ac8084ec6f0a53b( container, opener, startingforward, framesstill ) )
    {
        if ( getdvarint( @"hash_419fd2f09b23942a", 1 ) )
        {
            if ( lengthsquared( opener getvelocity() ) == 0 )
            {
                if ( framesstill == 0 )
                {
                    if ( isdefined( container.linkedparent ) )
                    {
                        opener.var_75f60e367c30d7ac = rotatevectorinverted( opener.origin - container.linkedparent.origin, container.linkedparent.angles );
                    }
                    else
                    {
                        opener.var_75f60e367c30d7ac = opener.origin;
                    }
                }
                
                framesstill++;
                framesstill = int( min( framesstill, getdvarint( @"hash_aea0716d0a0f790a", 6 ) ) );
            }
            else
            {
                framesstill--;
                framesstill = int( max( framesstill, 0 ) );
            }
        }
        
        waitframe();
    }
    
    common_cache::closelootablecontainer( container, opener );
}

// Namespace loot_mp
// Params 0
// Checksum 0x59b8ad87, Offset: 0x3023
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

// Namespace loot_mp
// Params 1
// Checksum 0xba88f4e5, Offset: 0x3078
// Size: 0x19, Type: bool
function iscontaineropen( player )
{
    return player getclientomnvar( "loot_container_open" ) > 0;
}

// Namespace loot_mp
// Params 1
// Checksum 0xc7e8e5b9, Offset: 0x309a
// Size: 0x135, Type: bool
function function_287f2ac76698bc1( player )
{
    if ( !iscontaineropen( player ) )
    {
        return false;
    }
    
    if ( !isdefined( player.var_50f741a14f09a6 ) )
    {
        return false;
    }
    
    if ( !isdefined( player.var_50f741a14f09a6.containertype ) )
    {
        return false;
    }
    
    if ( player.var_50f741a14f09a6.containertype != 14 )
    {
        return false;
    }
    
    if ( !isdefined( player.var_50f741a14f09a6.contents ) )
    {
        return false;
    }
    
    foreach ( item in player.var_50f741a14f09a6.contents )
    {
        if ( isdefined( item[ "lootID" ] ) )
        {
            scriptablename = loot::getScriptableFromLootID( item[ "lootID" ] );
            
            if ( isdefined( scriptablename ) && br_pickups::function_1578d9983da7761a( scriptablename ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace loot_mp
// Params 2
// Checksum 0x50186037, Offset: 0x31d8
// Size: 0xb7
function function_8b70220a96530c7e( opener, container )
{
    container = function_aea840f4352608fb( opener, container );
    
    if ( !isdefined( container.var_9698b23946ca9ef7 ) )
    {
        return;
    }
    
    foreach ( weaponmaphandle in container.var_9698b23946ca9ef7 )
    {
        function_a76fdf4e079af7be( weaponmaphandle );
    }
    
    container.var_9698b23946ca9ef7 = [];
}

// Namespace loot_mp
// Params 1
// Checksum 0xa4fea18f, Offset: 0x3297
// Size: 0x96
function function_fe4ecb88aeb31c79( var_b8f3420a16148f7c )
{
    bitsused = 31;
    
    if ( bitsused > 31 )
    {
        assertmsg( "<dev string:x11e>" );
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

// Namespace loot_mp
// Params 2
// Checksum 0x23607364, Offset: 0x3336
// Size: 0x99
function function_3356ab331151b684( lootid = 0, extrapayload )
{
    assert( lootid >= 0 && lootid < 1048576 );
    
    if ( !isdefined( extrapayload ) )
    {
        extrapayload = 0;
    }
    
    assert( extrapayload >= 0 && extrapayload < 2048 );
    var_b8f3420a16148f7c = 0;
    bitsused = 31;
    
    if ( bitsused > 31 )
    {
        assertmsg( "<dev string:x17d>" );
        return var_b8f3420a16148f7c;
    }
    
    var_b8f3420a16148f7c |= extrapayload;
    var_b8f3420a16148f7c <<= 20;
    var_b8f3420a16148f7c |= lootid;
    return var_b8f3420a16148f7c;
}

// Namespace loot_mp
// Params 1
// Checksum 0xf0956caa, Offset: 0x33d8
// Size: 0x6a
function function_6d3e17fbc5d75dde( var_aaf2a1dd717393f3 )
{
    player = self;
    assert( isplayer( player ) );
    var_3024de225f017350 = player getclientomnvar( var_aaf2a1dd717393f3 );
    
    if ( !isdefined( var_3024de225f017350 ) )
    {
        return 0;
    }
    
    var_e2099ecb60635bd4 = function_fe4ecb88aeb31c79( var_3024de225f017350 );
    var_a6f3d833224532d6 = var_e2099ecb60635bd4.lootid;
    return var_a6f3d833224532d6;
}

// Namespace loot_mp
// Params 5
// Checksum 0xb6591de3, Offset: 0x344b
// Size: 0x139
function function_5b66206be41a47a7( player, container, var_d88aa41456c01b18, lootid, weapon )
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
    
    var_779101e04758775 = function_3356ab331151b684( lootid, weaponmaphandle );
    player setclientomnvar( var_d88aa41456c01b18, var_779101e04758775 );
}

// Namespace loot_mp
// Params 6
// Checksum 0x30d0db9e, Offset: 0x358c
// Size: 0x13a
function function_7875275a0511dfeb( player, container, index, lootid, quantity, scriptabledefname )
{
    if ( function_b883bff8be9f52eb( container, index ) )
    {
        function_c0f0c842a515c9d5( player, index - 11, lootid, quantity );
        return;
    }
    
    typename = loot::function_52cf8374c44a4ff5( lootid );
    typedata = undefined;
    
    if ( isdefined( typename ) )
    {
        typedata = level.lootmaster[ typename ];
    }
    
    if ( lootid == 0 )
    {
        function_8632ef63c71b6048( player, index );
        return;
    }
    
    if ( isdefined( typedata ) )
    {
        if ( typedata.typename == "weapon" )
        {
            function_5b66206be41a47a7( player, container, "loot_container_item_" + index, lootid, scriptabledefname );
        }
        else
        {
            player setclientomnvar( "loot_container_item_" + index, lootid );
        }
        
        player setclientomnvar( "loot_container_quantity_" + index, quantity );
        player setclientomnvar( "loot_container_type_" + index, typedata.typevalue );
        
        if ( quantity > 4095 )
        {
            logstring( "IW9-690092: Item quantity too large for loot ID: " + lootid );
        }
        
        return;
    }
    
    println( "<dev string:x1d0>" + lootid + "<dev string:x11c>" );
}

// Namespace loot_mp
// Params 1
// Checksum 0x19111b38, Offset: 0x36ce
// Size: 0x1a, Type: bool
function function_56d525c33dd2bd84( index )
{
    return index >= 11 && index <= 20;
}

// Namespace loot_mp
// Params 2
// Checksum 0x432252a3, Offset: 0x36f1
// Size: 0x29, Type: bool
function function_b883bff8be9f52eb( container, index )
{
    return function_56d525c33dd2bd84( index ) && function_5cdaa261d954d20( container );
}

// Namespace loot_mp
// Params 3
// Checksum 0xfc149ca, Offset: 0x3723
// Size: 0x85
function getloadoutdoublebackpacklootid( container, index, var_173cfcf7993f6228 )
{
    if ( isdefined( container ) && isdefined( container.var_aa16d22e51056da1 ) && arraycontains( container.var_aa16d22e51056da1, index ) && !var_173cfcf7993f6228 )
    {
        return 0;
    }
    
    if ( isdefined( container ) && isdefined( container.loadoutcontents[ index ][ "lootID" ] ) )
    {
        return container.loadoutcontents[ index ][ "lootID" ];
    }
    
    return 0;
}

// Namespace loot_mp
// Params 3
// Checksum 0x420bd238, Offset: 0x37b1
// Size: 0x85
function function_a52c163bca75efe8( container, index, var_173cfcf7993f6228 )
{
    if ( isdefined( container ) && isdefined( container.var_aa16d22e51056da1 ) && arraycontains( container.var_aa16d22e51056da1, index ) && !var_173cfcf7993f6228 )
    {
        return 0;
    }
    
    if ( isdefined( container ) && isdefined( container.loadoutcontents[ index ][ "quantity" ] ) )
    {
        return container.loadoutcontents[ index ][ "quantity" ];
    }
    
    return 0;
}

// Namespace loot_mp
// Params 1
// Checksum 0xb01dfa27, Offset: 0x383f
// Size: 0x33
function function_9d65d96238d48ae( player )
{
    player setclientomnvar( "loot_container_loadout_weapon_id", 0 );
    player setclientomnvar( "loot_container_loadout_weapon_attachments", 0 );
    player setclientomnvar( "loot_container_loadout_weapon_ammo", 0 );
}

// Namespace loot_mp
// Params 3
// Checksum 0x3a0d5dbe, Offset: 0x387a
// Size: 0xa0
function function_2b22e24f49268a76( player, lootid, quantity )
{
    gasmasktype = 0;
    gasmaskhealth = 0;
    
    if ( !( lootid == 0 || quantity == 0 ) )
    {
        gasmaskhealth = quantity;
        scriptablename = loot::getScriptableFromLootID( lootid );
        
        if ( scriptablename == "brloot_equip_gasmask_durable" )
        {
            gasmasktype = 3;
        }
        else if ( scriptablename == "brloot_equip_gasmask_scuba" )
        {
            gasmasktype = 4;
        }
        else
        {
            gasmasktype = 2;
        }
    }
    
    player setclientomnvar( "loot_container_loadout_gasmask_id", gasmasktype );
    player setclientomnvar( "loot_container_loadout_gasmask_quantity", gasmaskhealth );
}

// Namespace loot_mp
// Params 4
// Checksum 0x90c8b716, Offset: 0x3922
// Size: 0x208
function function_c0f0c842a515c9d5( player, index, lootid, quantity )
{
    if ( lootid == 0 || quantity == 0 )
    {
        lootid = 0;
        quantity = 0;
    }
    
    switch ( index )
    {
        case 0:
            player setclientomnvar( "loot_container_loadout_plunder_quantity", quantity );
            break;
        case 1:
            player setclientomnvar( "loot_container_loadout_lethal_id", lootid );
            player setclientomnvar( "loot_container_loadout_lethal_quantity", quantity );
            break;
        case 2:
            player setclientomnvar( "loot_container_loadout_tactical_id", lootid );
            
            if ( br_pickups::function_bcc6dc9b2b7365e0( lootid ) )
            {
                quantity = 1;
            }
            
            player setclientomnvar( "loot_container_loadout_tactical_quantity", quantity );
            break;
        case 3:
            player setclientomnvar( "loot_container_loadout_armor_quantity", quantity );
            break;
        case 6:
            function_2b22e24f49268a76( player, lootid, quantity );
            break;
        case 7:
            player setclientomnvar( "loot_container_loadout_revive", quantity );
            break;
        case 5:
            player setclientomnvar( "loot_container_loadout_super_id", lootid );
            break;
        case 4:
            player setclientomnvar( "loot_container_loadout_killstreak_id", lootid );
            break;
        case 8:
            if ( lootid == 0 || quantity == 0 )
            {
                player setclientomnvar( "loot_container_loadout_dogtag_tier", 0 );
                break;
            }
            
            if ( lootid == 26140 )
            {
                player setclientomnvar( "loot_container_loadout_dogtag_tier", 5 );
                player setclientomnvar( "loot_container_loadout_dogtag_quantity", 1 );
                break;
            }
            
            tier = dmz_dog_tag::function_b11e1152414b6b63( lootid );
            player setclientomnvar( "loot_container_loadout_dogtag_tier", tier + 1 );
            player setclientomnvar( "loot_container_loadout_dogtag_quantity", quantity );
            break;
        case 9:
            player setclientomnvar( "loot_container_loadout_backpack", lootid );
        default:
            break;
    }
}

// Namespace loot_mp
// Params 2
// Checksum 0x9aead625, Offset: 0x3b32
// Size: 0x1e9
function function_c823755017c8b17( player, container )
{
    loadoutcontents = container.loadoutcontents;
    
    if ( isdefined( loadoutcontents ) )
    {
        foreach ( index, item in loadoutcontents )
        {
            lootid = 0;
            quantity = 0;
            
            if ( isdefined( item[ "lootID" ] ) )
            {
                lootid = item[ "lootID" ];
                quantity = item[ "quantity" ];
            }
            
            function_c0f0c842a515c9d5( player, index, lootid, quantity );
        }
    }
    
    if ( isdefined( container.var_64df982caf48609c ) && isdefined( container.var_9185433e2ad9ec33 ) )
    {
        weaponslotid = container.var_64df982caf48609c;
        weaponobj = container.var_9185433e2ad9ec33;
        attachments = getweaponattachments( weaponobj );
        attachmentcount = 0;
        
        foreach ( attachment in attachments )
        {
            if ( !weapon::attachmentisselectable( weaponobj, attachment ) )
            {
                continue;
            }
            
            attachmentcount++;
        }
        
        function_5b66206be41a47a7( player, container, "loot_container_loadout_weapon_id", weaponslotid, weaponobj );
        player setclientomnvar( "loot_container_loadout_weapon_attachments", attachmentcount );
        player setclientomnvar( "loot_container_loadout_weapon_ammo", player getweaponammoclip( weaponobj ) );
    }
}

// Namespace loot_mp
// Params 4
// Checksum 0x96bc5bcd, Offset: 0x3d23
// Size: 0x95
function getlootidatcontainerindex( player, index, container, var_173cfcf7993f6228 )
{
    if ( isdefined( container ) && isdefined( container.reservedindex ) && arraycontains( container.reservedindex, index ) && !var_173cfcf7993f6228 )
    {
        return 0;
    }
    
    slotlootid = undefined;
    
    if ( index == 100 )
    {
        slotlootid = player function_6d3e17fbc5d75dde( "loot_container_weapon" );
    }
    else
    {
        slotlootid = player function_6d3e17fbc5d75dde( "loot_container_item_" + index );
    }
    
    return slotlootid;
}

// Namespace loot_mp
// Params 4
// Checksum 0x1bb001ff, Offset: 0x3dc1
// Size: 0x73
function function_adc34dc6458d547b( player, index, container, var_173cfcf7993f6228 )
{
    if ( isdefined( container ) && isdefined( container.reservedindex ) && arraycontains( container.reservedindex, index ) && !var_173cfcf7993f6228 )
    {
        return 0;
    }
    
    if ( index == 100 )
    {
        return 1;
    }
    
    return player getclientomnvar( "loot_container_quantity_" + index );
}

// Namespace loot_mp
// Params 2
// Checksum 0xe2e99021, Offset: 0x3e3d
// Size: 0x1de, Type: bool
function iscontainerempty( container, opener )
{
    if ( function_77446e259fbebd12( container ) )
    {
        return false;
    }
    
    container = function_aea840f4352608fb( opener, container );
    
    if ( !isdefined( container.contents ) )
    {
        return true;
    }
    
    contents = container.contents;
    
    foreach ( content in contents )
    {
        if ( !( isdefined( content[ "lootID" ] ) && isdefined( content[ "quantity" ] ) ) )
        {
            continue;
        }
        
        if ( content[ "lootID" ] > 0 && content[ "quantity" ] > 0 )
        {
            return false;
        }
    }
    
    if ( isdefined( container.customweaponname ) )
    {
        return false;
    }
    
    if ( container.weaponslotcontents )
    {
        return false;
    }
    
    if ( function_5cdaa261d954d20( container ) )
    {
        if ( isdefined( container.loadoutcontents ) )
        {
            foreach ( content in container.loadoutcontents )
            {
                if ( !( isdefined( content[ "lootID" ] ) && isdefined( content[ "quantity" ] ) ) )
                {
                    continue;
                }
                
                if ( content[ "lootID" ] > 0 && content[ "quantity" ] > 0 )
                {
                    return false;
                }
            }
        }
        
        if ( isdefined( container.var_9185433e2ad9ec33 ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace loot_mp
// Params 4
// Checksum 0x7475fc0d, Offset: 0x4024
// Size: 0x3b3
function function_b6cb458b9bea3095( player, lootid, quantity, container )
{
    if ( quantity < 0 )
    {
        return;
    }
    
    method = challenges::function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"loot_method_bitfield", #"loot" ) );
    scriptablename = container.type;
    containertype = container.containertype;
    
    if ( containertype == 2 || containertype == 6 || containertype >= 7 && containertype <= 12 )
    {
        method = challenges::function_a23641f33e985edb( method, ae_utility::function_2d1565a236387b2( #"loot_method_bitfield", #"backpack" ) );
    }
    else
    {
        method = challenges::function_a23641f33e985edb( method, ae_utility::function_2d1565a236387b2( #"loot_method_bitfield", #"cache" ) );
    }
    
    lootsource = 0;
    issupplydrop = 0;
    
    if ( isdefined( scriptablename ) )
    {
        switch ( scriptablename )
        {
            case #"hash_3b6111354af78459":
                lootsource = challenges::function_a23641f33e985edb( lootsource, ae_utility::function_2d1565a236387b2( #"loot_source", #"radioactive_cache" ) );
                break;
            case #"hash_469a90a45e97eda9":
            case #"hash_50e52e4dc37fb7a8":
                lootsource = challenges::function_a23641f33e985edb( lootsource, ae_utility::function_2d1565a236387b2( #"loot_source", #"medicine_cabinet" ) );
                break;
            case #"hash_44904bb5898785d9":
                lootsource = challenges::function_a23641f33e985edb( lootsource, ae_utility::function_2d1565a236387b2( #"loot_source", #"pc_cache" ) );
                break;
            case #"hash_61f36140da68c992":
                lootsource = challenges::function_a23641f33e985edb( lootsource, ae_utility::function_2d1565a236387b2( #"loot_source", #"supply_drop" ) );
                lootsource = challenges::function_a23641f33e985edb( lootsource, ae_utility::function_2d1565a236387b2( #"loot_source", #"supply_drop_event" ) );
                issupplydrop = 1;
                break;
            case #"hash_993262832973e0d":
                lootsource = challenges::function_a23641f33e985edb( lootsource, ae_utility::function_2d1565a236387b2( #"loot_source", #"supply_drop" ) );
                lootsource = challenges::function_a23641f33e985edb( lootsource, ae_utility::function_2d1565a236387b2( #"loot_source", #"supply_drop_airplane" ) );
                issupplydrop = 1;
                break;
            case #"hash_1a50c41f80fb532b":
                lootsource = challenges::function_a23641f33e985edb( lootsource, ae_utility::function_2d1565a236387b2( #"loot_source", #"weapon_locker" ) );
                break;
            case #"hash_763609926e3b8ed":
                lootsource = challenges::function_a23641f33e985edb( lootsource, ae_utility::function_2d1565a236387b2( #"loot_source", #"duffel_bag" ) );
                break;
            case #"hash_93553b29704c0d3":
                lootsource = challenges::function_a23641f33e985edb( lootsource, ae_utility::function_2d1565a236387b2( #"loot_source", #"cash_register" ) );
                break;
            case #"hash_2808ce3c4558142d":
                lootsource = challenges::function_a23641f33e985edb( lootsource, ae_utility::function_2d1565a236387b2( #"loot_source", #"cash_register" ) );
                break;
            case #"hash_5fe210289499bd6e":
                issupplydrop = 1;
                break;
            default:
                break;
        }
    }
    
    if ( issupplydrop )
    {
        function_c37e0d9336664b1f( player, container );
    }
    
    if ( quickprompt::quickpromptisenabled() )
    {
        if ( player calloutmarkerping_mp::function_fa511c27ff3cfada( container, lootid ) )
        {
            player thread quickprompt::quickpromptshow( 3 );
        }
    }
    
    challenges::reportlootitemevent( player, lootid, undefined, method, quantity, lootsource );
    player notify( #"looted_item", lootid, quantity, 0 );
    
    if ( !isbrgamemode() )
    {
        br_pickups::function_c184270d1f716161( player, player.origin );
    }
}

// Namespace loot_mp
// Params 2
// Checksum 0x5250b76, Offset: 0x43df
// Size: 0x1fd
function function_c37e0d9336664b1f( looter, container )
{
    var_c7f51d2f16dc2a59 = getdvarint( @"hash_a1e254e5a2b575d7", 1 ) == 1;
    var_9e80c41bbb74aef4 = 0;
    players = teams::getteamdata( looter.team, "players" );
    
    if ( isdefined( container ) )
    {
        if ( isdefined( container.openedby ) )
        {
            if ( !var_c7f51d2f16dc2a59 )
            {
                var_ea91508402a118ee = 0;
                
                foreach ( player in players )
                {
                    if ( arraycontains( container.openedby, player ) )
                    {
                        var_ea91508402a118ee = 1;
                        break;
                    }
                }
                
                if ( !var_ea91508402a118ee )
                {
                    container.openedby = arraycombineunique( container.openedby, players );
                    var_9e80c41bbb74aef4 = 1;
                }
            }
        }
        else
        {
            container.openedby = [];
            container.openedby = arraycombineunique( container.openedby, players );
            var_9e80c41bbb74aef4 = 1;
        }
    }
    
    if ( !var_9e80c41bbb74aef4 )
    {
        return;
    }
    
    foreach ( player in players )
    {
        if ( !isdefined( player.supplydropsopened ) )
        {
            player.supplydropsopened = 0;
        }
        
        player.supplydropsopened++;
        player points::doscoreevent( #"dmz_supply_drop_opened" );
    }
}

// Namespace loot_mp
// Params 1
// Checksum 0x23e43269, Offset: 0x45e4
// Size: 0x32, Type: bool
function function_aa0397fa378bc8e4( container )
{
    if ( !( isdefined( container ) && isdefined( container.containertype ) ) )
    {
        return false;
    }
    
    return container.containertype == 14;
}

// Namespace loot_mp
// Params 1
// Checksum 0xd856ad90, Offset: 0x461f
// Size: 0x74, Type: bool
function function_77446e259fbebd12( container )
{
    if ( !isdefined( container.containertype ) )
    {
        return false;
    }
    
    return container.containertype == 13 || container.containertype == 15 || container.containertype == 17 || container.containertype == 18 || container.containertype == 19;
}

// Namespace loot_mp
// Params 1
// Checksum 0x5fe033c7, Offset: 0x469c
// Size: 0x62, Type: bool
function function_5cdaa261d954d20( container )
{
    if ( !isdefined( container.containertype ) )
    {
        return false;
    }
    
    return container.containertype == 16 || container.containertype == 6 || container.containertype >= 7 && container.containertype <= 12;
}

// Namespace loot_mp
// Params 3
// Checksum 0xe40e4147, Offset: 0x4707
// Size: 0x15b
function function_92c75b3dfc836cf( opener, container, var_35d455e7476f277e )
{
    level endon( #"game_ended" );
    opener endon( #"death_or_disconnect" );
    opener endon( #"enter_live_ragdoll" );
    container endon( #"death" );
    waittime = 0.35;
    overridetime = getdvarfloat( @"hash_d9e519d9c89af2f3", 0 );
    
    if ( overridetime > 0 )
    {
        waittime = overridetime;
    }
    
    container utility::waittill_any_timeout( waittime, "closed" );
    
    if ( !player::isreallyalive( opener ) )
    {
        return;
    }
    
    if ( var_35d455e7476f277e )
    {
        var_e5ede4455766a025 = getdvarint( hashcat( @"scr_", game_utility::getgametype(), "_lootingSpecialXPOverride" ), 0 );
        
        if ( var_e5ede4455766a025 == 0 )
        {
            var_e5ede4455766a025 = undefined;
        }
        
        opener thread points::doscoreevent( #"br_cacheopen_epic", undefined, undefined, var_e5ede4455766a025 );
        opener playsoundtoplayer( "uin_wz2_loot_container_open_epic", opener );
        return;
    }
    
    xpoverride = getdvarint( hashcat( @"scr_", game_utility::getgametype(), "_lootingXPOverride" ), 0 );
    
    if ( xpoverride == 0 )
    {
        xpoverride = undefined;
    }
    
    opener thread points::doscoreevent( #"br_cacheOpen", undefined, undefined, xpoverride );
    opener playsoundtoplayer( "uin_wz2_loot_container_open_common", opener );
}

// Namespace loot_mp
// Params 8
// Checksum 0x24549204, Offset: 0x486a
// Size: 0x187
function function_69c8862acdc870f0( player, lootid, quantity, weaponref, var_173cfcf7993f6228, overridedist, overrideorigin, var_df78d4a492ecf0a6 )
{
    ref = loot::function_f54ecb89dfab8e8c( lootid );
    success = 0;
    
    if ( ref == "cash" )
    {
        plundername = br_plunder::getplundernamebyamount( quantity );
        fakepickup = spawnstruct();
        fakepickup.scriptablename = plundername;
        fakepickup.var_b8b2f39fcba6d824 = 1;
        fakepickup.count = quantity;
        player br_pickups::playpickupfeedback( fakepickup );
        player br_plunder::playerplunderpickup( quantity, undefined, undefined, 1 );
        success = 1;
    }
    else if ( ref == "dmz_loot_quest_intel" || ref == "dmz_trap_quest_trigger" )
    {
        player br_pickups::function_55de798ca5dc4080( lootid, undefined, 1 );
        success = 1;
    }
    else if ( br_public::isammo( ref ) )
    {
        success = player br_pickups::function_e2df2f8df3b3ce9a( ref, lootid, quantity, 1 );
    }
    else if ( isweaponitem( lootid ) )
    {
        var_df78d4a492ecf0a6 = var_df78d4a492ecf0a6 && player common_inventory::function_9cd65c8312048802() >= 7 && !player common_inventory::function_d33e11a8dda3cb20();
        success = player br_pickups::lootitem( lootid, quantity, weaponref, 1, undefined, undefined, overridedist, overrideorigin, var_173cfcf7993f6228, var_df78d4a492ecf0a6 );
    }
    else
    {
        success = player br_pickups::lootitem( lootid, quantity, weaponref, 1, !var_173cfcf7993f6228, undefined, overridedist, overrideorigin, var_173cfcf7993f6228 );
    }
    
    return success;
}

// Namespace loot_mp
// Params 2
// Checksum 0x4a376ff8, Offset: 0x49fa
// Size: 0x1fc
function function_79d9c92e2724f1b0( player, container )
{
    if ( player.carryinghostage && isdefined( level.br_pickups.var_9d247aba85e39454 ) )
    {
        player hud_message::showerrormessage( level.br_pickups.var_9d247aba85e39454 );
        return;
    }
    
    lootid = player common_inventory::function_b2c6164fc8a62023();
    parentcontainer = container;
    container = function_aea840f4352608fb( player, container );
    
    if ( !isdefined( container.weaponslotobj ) )
    {
        return;
    }
    
    var_6a57b789bb871d86 = 1;
    
    foreach ( weaponobj in player.primaryinventory )
    {
        if ( weapon::isfistweapon( weaponobj ) )
        {
            var_6a57b789bb871d86 = 0;
            break;
        }
    }
    
    if ( var_6a57b789bb871d86 && player common_inventory::function_d33e11a8dda3cb20() )
    {
        hud_message::showerrormessage( level.br_pickups.br_pickupdenyequipnoroom );
        return;
    }
    
    function_b6cb458b9bea3095( player, lootid, 1, parentcontainer );
    
    if ( !var_6a57b789bb871d86 )
    {
        function_439af3b796a87468( player, parentcontainer );
        return;
    }
    
    [ _, weaponobj, pastteam, metadata, _, _, _ ] = function_eb64c60707462d81( player, container );
    
    if ( br_instance_inventory::function_926a8f8643d34690() )
    {
        br_instance_inventory::function_9e6e0e24612d44e0( player, weaponobj, undefined, metadata );
    }
    else
    {
        player common_inventory::function_1923cd40e1b4efc8( weaponobj );
    }
    
    function_a3d8c84944353dfe( player, parentcontainer );
    player playsoundtoplayer( "fly_pickup_wpn", player );
}

// Namespace loot_mp
// Params 5
// Checksum 0xad3a28f4, Offset: 0x4bfe
// Size: 0x329
function function_3d2df00a6e925f1b( player, index, quantity, container, var_173cfcf7993f6228 )
{
    lootid = 0;
    itemquantity = 0;
    [ lootid, itemquantity ] = function_e954849d8e889bd( player, container, index, var_173cfcf7993f6228 );
    
    if ( lootid == 0 || itemquantity == 0 )
    {
        return;
    }
    
    weaponref = function_1a03bf6e54b76ecf( player, container, index );
    sameweapon = undefined;
    var_df78d4a492ecf0a6 = undefined;
    
    if ( isdefined( weaponref ) )
    {
        if ( player.carryinghostage && isdefined( level.br_pickups.var_9d247aba85e39454 ) )
        {
            player hud_message::showerrormessage( level.br_pickups.var_9d247aba85e39454 );
            return;
        }
        
        fakepickup = spawnstruct();
        fakepickup.scriptablename = weaponref;
        var_df78d4a492ecf0a6 = 1;
        newweapon = br_weapons::function_e21fbe40c5ae575e( fakepickup )[ 0 ];
        
        foreach ( weap in self.primaryweapons )
        {
            if ( issameweapon( weap, newweapon ) )
            {
                lootid = loot::function_d3e3bcaea591a6a2( br_weapons::br_ammo_type_for_weapon( newweapon ) );
                itemquantity = weaponclipsize( newweapon );
                quantity = itemquantity;
                sameweapon = 1;
                break;
            }
        }
    }
    
    itemref = loot::function_f54ecb89dfab8e8c( lootid );
    
    if ( itemref == "cash" )
    {
        playerplunder = player.plundercount ?? 0;
        maxplunder = level.br_plunder.plunderlimit ?? playerplunder + itemquantity;
        
        if ( playerplunder + itemquantity > level.br_plunder.plunderlimit )
        {
            quantity = level.br_plunder.plunderlimit - playerplunder;
        }
    }
    
    if ( !isdefined( quantity ) )
    {
        quantity = itemquantity;
    }
    
    assert( itemquantity >= quantity, "<dev string:x1fa>" );
    
    if ( lootid == 0 || quantity == 0 )
    {
        return 1;
    }
    
    overridedist = distance2d( container.origin, player.origin ) / 2;
    overrideorigin = undefined;
    
    if ( function_aa0397fa378bc8e4( container ) )
    {
        overrideorigin = container.origin;
    }
    
    success = function_69c8862acdc870f0( player, lootid, quantity, weaponref, var_173cfcf7993f6228, overridedist, overrideorigin, var_df78d4a492ecf0a6 );
    
    if ( success || sameweapon )
    {
        newquantity = itemquantity - quantity;
        newlootid = lootid;
        function_b6cb458b9bea3095( player, newlootid, quantity, container );
        function_66668ee51ee32f35( player, container, index, newlootid, newquantity );
        function_298b77306db108f0( lootid, player, container, index );
    }
    
    return success;
}

// Namespace loot_mp
// Params 4
// Checksum 0xc81f1f43, Offset: 0x4f30
// Size: 0x254
function function_439af3b796a87468( player, container, itemtype, overridedist )
{
    if ( !isdefined( container ) )
    {
        return 1;
    }
    
    if ( player.carryinghostage && isdefined( level.br_pickups.var_9d247aba85e39454 ) )
    {
        player hud_message::showerrormessage( level.br_pickups.var_9d247aba85e39454 );
        return;
    }
    
    [ _, weaponslotobj, pastteam, metadata, quantity, altquantity, lefthandquantity ] = function_eb64c60707462d81( player, container );
    
    if ( !isdefined( weaponslotobj ) )
    {
        return 1;
    }
    
    weapon = weaponslotobj;
    
    foreach ( weap in self.primaryweapons )
    {
        if ( issameweapon( weap, weapon ) )
        {
            hud_message::showerrormessage( level.br_pickups.br_pickupdenyalreadyhaveweapon );
            return;
        }
    }
    
    if ( player common_inventory::function_d33e11a8dda3cb20() )
    {
        weaponslotweapon = player common_inventory::function_7bf60ff8870e96b4();
        
        if ( issameweapon( weaponslotweapon, weapon ) )
        {
            hud_message::showerrormessage( level.br_pickups.br_pickupdenyalreadyhaveweapon );
            return;
        }
    }
    
    if ( !isdefined( quantity ) )
    {
        quantity = weaponclipsize( weapon );
    }
    
    overrideorigin = undefined;
    
    if ( function_aa0397fa378bc8e4( container ) )
    {
        overrideorigin = container.origin;
    }
    
    br_pickups::equipweapon( weapon, quantity, undefined, altquantity, undefined, undefined, metadata, overridedist, overrideorigin, undefined, lefthandquantity );
    function_a3d8c84944353dfe( player, container );
    
    if ( function_aa0397fa378bc8e4( container ) )
    {
        player setclientomnvar( "loot_container_open", 0 );
        container notify( #"closed" );
        pickups::loothide( container );
    }
}

// Namespace loot_mp
// Params 4
// Checksum 0xad536390, Offset: 0x518c
// Size: 0x2d8
function function_4b734bd88c67417b( player, index, loadoutindex, container )
{
    lootid = 0;
    quantity = 0;
    overridedist = distance2d( container.origin, self.origin ) / 2;
    
    if ( function_a319e5c06802cd78( player, container ) && loadoutindex != 0 )
    {
        function_345ace5702e91f1a( loadoutindex, player, container, 0 );
    }
    else
    {
        [ lootid, quantity ] = function_e954849d8e889bd( player, container, index );
    }
    
    if ( lootid == 0 || quantity == 0 )
    {
        return;
    }
    
    ref = loot::function_f54ecb89dfab8e8c( lootid );
    
    if ( function_d8e3e3b93d310128( player, container, index ) )
    {
        ref = container.contents[ index ][ "ref" ];
    }
    
    pickupremains = 0;
    
    if ( br_public::isammo( ref ) )
    {
        player common_inventory::function_d3959596f4031a1d( lootid, quantity );
    }
    else if ( br_pickups::isgascan( ref ) )
    {
        hud_message::showerrormessage( level.br_pickups.var_2c585953124fc454 );
        return;
    }
    else if ( function_d8e3e3b93d310128( player, container, index ) )
    {
        if ( player.carryinghostage && isdefined( level.br_pickups.var_9d247aba85e39454 ) )
        {
            player hud_message::showerrormessage( level.br_pickups.var_9d247aba85e39454 );
            return;
        }
        
        overrideorigin = undefined;
        
        if ( function_aa0397fa378bc8e4( container ) )
        {
            overrideorigin = container.origin;
        }
        
        if ( loadoutindex > 0 )
        {
            br_pickups::quickdropweapon( player, 1, loadoutindex - 1, undefined, 0, 0, overridedist, overrideorigin );
        }
        
        weaponobj = br_pickups::getfullweaponobjforscriptablepartname( ref );
        quantity = weaponclipsize( weaponobj );
        success = br_pickups::equipweapon( weaponobj, quantity, undefined, undefined, undefined, undefined, undefined, overridedist, overrideorigin, undefined, quantity );
        
        if ( !success )
        {
            return;
        }
    }
    else
    {
        var_9467a1a08c510d4 = undefined;
        
        if ( getdvarint( @"hash_1903ee79b0fffb17", 0 ) )
        {
            var_9467a1a08c510d4 = player common_inventory::function_9cfce16f3087291a();
        }
        
        overrideorigin = undefined;
        
        if ( function_aa0397fa378bc8e4( container ) )
        {
            overrideorigin = container.origin;
        }
        
        pickupremains = br_pickups::equipitem( lootid, quantity, var_9467a1a08c510d4, undefined, undefined, undefined, overridedist, overrideorigin );
        
        if ( !isdefined( pickupremains ) )
        {
            return;
        }
    }
    
    function_b6cb458b9bea3095( player, lootid, quantity, container );
    
    if ( function_aa0397fa378bc8e4( container ) )
    {
        player setclientomnvar( "loot_container_open", 0 );
        container notify( #"closed" );
        pickups::loothide( container );
        return;
    }
    
    originallootid = lootid;
    lootid = pickupremains == 0 ? 0 : lootid;
    function_66668ee51ee32f35( player, container, index, lootid, quantity );
    function_298b77306db108f0( originallootid, player, container, index );
}

// Namespace loot_mp
// Params 3
// Checksum 0x5dadcd, Offset: 0x546c
// Size: 0x8df
function function_46e9fad35d05d811( containerslot, backpackslot, container )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( function_aa0397fa378bc8e4( container ) && isdefined( self.var_42547f1bd3ea0117 ) && self.var_42547f1bd3ea0117[ backpackslot ] )
    {
        self setclientomnvar( "loot_container_open", 0 );
        container notify( #"closed" );
        return;
    }
    
    if ( backpackslot == 100 )
    {
        if ( self.carryinghostage && isdefined( level.br_pickups.var_9d247aba85e39454 ) )
        {
            hud_message::showerrormessage( level.br_pickups.var_9d247aba85e39454 );
            return;
        }
        
        if ( common_inventory::function_d33e11a8dda3cb20() )
        {
            var_d4fcd9b60d8ec1c = common_inventory::function_7bf60ff8870e96b4();
            overrideorigin = undefined;
            
            if ( function_aa0397fa378bc8e4( container ) )
            {
                overrideorigin = container.origin;
            }
            
            spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( overrideorigin ?? self.origin, self.angles );
            weaponinfostruct = spawnstruct();
            weaponinfostruct.ammoclipright = weaponclipsize( var_d4fcd9b60d8ec1c );
            weaponinfostruct.ammoclipleft = weaponclipsize( var_d4fcd9b60d8ec1c );
            weaponinfostruct.ammoclipalt = weaponclipsize( var_d4fcd9b60d8ec1c );
            weaponinfostruct.ammostock = weaponmaxammo( var_d4fcd9b60d8ec1c );
            item = item_weapon::function_53da2af5697709f8( var_d4fcd9b60d8ec1c, weaponinfostruct, spawnoptions );
            
            if ( br_instance_inventory::function_926a8f8643d34690() )
            {
                weaponmetadata = br_instance_inventory::function_6a05cf5689058e1f( self, 2 );
                
                if ( isdefined( weaponmetadata ) )
                {
                    item.metadata = weaponmetadata;
                }
            }
            
            common_inventory::function_56f7e890f83685bd();
        }
        
        [ lootid, weaponobj, pastteam, metadata, quantity, _, lefthandquantity ] = function_eb64c60707462d81( self, container, containerslot );
        
        if ( !isdefined( weaponobj ) )
        {
            return;
        }
        
        if ( !isdefined( quantity ) )
        {
            quantity = weaponclipsize( weaponobj );
        }
        
        self setweaponammoclip( weaponobj, quantity );
        
        if ( weapon::isakimbo( weaponobj ) )
        {
            if ( !isdefined( lefthandquantity ) )
            {
                lefthandquantity = weaponclipsize( weaponobj );
            }
            
            self setweaponammoclip( weaponobj, lefthandquantity, "left" );
        }
        
        if ( br_instance_inventory::function_926a8f8643d34690() )
        {
            br_instance_inventory::function_9e6e0e24612d44e0( self, weaponobj, 1, undefined );
        }
        else
        {
            common_inventory::function_1923cd40e1b4efc8( weaponobj );
        }
        
        function_a3d8c84944353dfe( self, container, containerslot );
        return;
    }
    
    [ containerlootid, containerquantity ] = function_e954849d8e889bd( self, container, containerslot );
    containerscriptable = loot::getScriptableFromLootID( containerlootid );
    backpacklootid = common_inventory::inventory_getlootidatbackpackindex( backpackslot );
    backpackquantity = common_inventory::inventory_getquantityatbackpackindex( backpackslot );
    backpackscriptable = loot::getScriptableFromLootID( backpacklootid );
    var_7417c2d6803d33d3 = isdefined( containerscriptable ) && namespace_5ab67a14d18bea3f::function_e96bd96c3a428bb8( containerscriptable );
    var_a1cf7ada6d32e612 = isdefined( backpackscriptable ) && namespace_5ab67a14d18bea3f::function_e96bd96c3a428bb8( backpackscriptable );
    var_e31dca5b81f02493 = isdefined( backpackscriptable ) && br_pickups::function_1578d9983da7761a( backpackscriptable );
    
    if ( function_aa0397fa378bc8e4( container ) && utility::issharedfuncdefined( backpacklootid, #"canquickdrop" ) )
    {
        if ( !utility::callsharedfunc( backpacklootid, #"canquickdrop", self ) )
        {
            self setclientomnvar( "loot_container_open", 0 );
            container notify( #"closed" );
            hud_message::showerrormessage( level.br_pickups.var_f54c276d04b1c3bb );
            return;
        }
    }
    
    if ( var_a1cf7ada6d32e612 )
    {
        overrideorigin = undefined;
        
        if ( function_aa0397fa378bc8e4( container ) )
        {
            overrideorigin = container.origin;
        }
        
        namespace_5ab67a14d18bea3f::dropperkpack( undefined, undefined, backpackslot, overrideorigin );
    }
    else if ( var_e31dca5b81f02493 )
    {
        dropstruct = pickups::function_f71dd588dc4f6288();
        
        if ( isdefined( container.dropstruct ) )
        {
            dropstruct = container.dropstruct;
        }
        
        overrideorigin = undefined;
        
        if ( function_aa0397fa378bc8e4( container ) )
        {
            overrideorigin = container.origin;
        }
        
        spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( overrideorigin ?? self.origin, self.angles );
        br_elite_broken_arrow::function_643954a035d06e38( spawnoptions, self );
        element = namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( backpackscriptable, backpackquantity, spawnoptions );
        br_elite_broken_arrow::function_51730e86424734b2( self, element, backpackslot );
    }
    else if ( br_pickups::function_fe0521864025d97e( backpackscriptable ) )
    {
        br_pickups::function_58fb35e7414b9c05( backpacklootid, backpackquantity, backpackscriptable, backpackslot );
    }
    
    common_inventory::function_4f226d9d5d61901e( backpackslot, backpackquantity );
    fakepickup = spawnstruct();
    fakepickup.scriptablename = loot::getScriptableFromLootID( containerlootid );
    fakepickup.count = containerquantity;
    fakepickup.var_b8b2f39fcba6d824 = 1;
    fakepickup.origin = container.origin;
    fakepickup.dropstruct = pickups::function_f71dd588dc4f6288();
    fakepickup.instance = container;
    
    if ( br_pickups::function_d1bdfe41ee9800f9( fakepickup.scriptablename ) )
    {
        fakepickup.blacksite = container.blacksite;
        fakepickup.originalteam = container.originalteam;
    }
    
    if ( var_7417c2d6803d33d3 )
    {
        namespace_5ab67a14d18bea3f::function_564bc0f74d98e10( backpackslot, container );
        quantity = 1;
        var_33ed632112a7f7cf = 0;
        
        if ( isdefined( container.perks ) )
        {
            [ quantity, var_33ed632112a7f7cf ] = br_pickups::function_de6c2fa53bdb8f87( container.perks );
        }
        
        common_inventory::inventory_setbackpackitematindex( backpackslot, containerlootid, quantity, var_33ed632112a7f7cf );
    }
    else
    {
        common_inventory::function_d3959596f4031a1d( containerlootid, containerquantity );
        br_pickups::onpickuptakenintobackpack( fakepickup );
        br_pickups::playpickupfeedback( fakepickup );
        
        if ( !function_aa0397fa378bc8e4( container ) )
        {
            function_b6cb458b9bea3095( self, containerlootid, containerquantity, container );
        }
        else
        {
            br_pickups::function_abed73c8891ee73c( self, fakepickup, 0, 20 );
        }
    }
    
    if ( !getdvarint( @"hash_8b40bee5a7e0fc04", 0 ) || function_aa0397fa378bc8e4( container ) || function_5cdaa261d954d20( container ) )
    {
        function_66668ee51ee32f35( self, container, containerslot, 0, 0 );
        maxcount = level.br_pickups.var_3444316dc55e4b0a[ fakepickup.scriptablename ];
        
        if ( !isdefined( maxcount ) || maxcount == 0 )
        {
            maxcount = level.br_pickups.maxcounts[ fakepickup.scriptablename ];
        }
        
        dropstruct = fakepickup.dropstruct;
        
        if ( isdefined( container.dropstruct ) )
        {
            dropstruct = container.dropstruct;
        }
        
        if ( !var_a1cf7ada6d32e612 && !var_e31dca5b81f02493 )
        {
            overrideorigin = undefined;
            dropnewitem = 1;
            scriptablename = loot::getScriptableFromLootID( backpacklootid );
            
            if ( function_aa0397fa378bc8e4( container ) )
            {
                if ( getdvarint( @"hash_8367f78074282ef0", 0 ) && container.loadoutcontainer )
                {
                    loadouttype = level.br_pickups.br_itemtype[ fakepickup.scriptablename ];
                    backpacktype = level.br_pickups.br_itemtype[ scriptablename ];
                    
                    if ( loadouttype == backpacktype )
                    {
                        br_pickups::equipitem( backpacklootid, backpackquantity );
                        dropnewitem = 0;
                    }
                }
                
                if ( !container.loadoutcontainer && dropstruct.dropcount < 1 )
                {
                    overrideorigin = container.origin;
                }
            }
            
            if ( dropnewitem )
            {
                if ( br_pickups::function_d1bdfe41ee9800f9( scriptablename ) )
                {
                    br_strongholds::function_30128ad2ab80b07d( dropstruct, self.blacksite );
                }
                else
                {
                    spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( self.origin, self.angles );
                    newent = namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( scriptablename, backpackquantity, spawnoptions );
                    
                    if ( isdefined( newent ) )
                    {
                        utility::callsharedfunc( scriptablename, #"dropped", newent, self, spawnoptions.baseorigin );
                    }
                }
            }
        }
    }
    else
    {
        function_66668ee51ee32f35( self, container, containerslot, backpacklootid, backpackquantity );
        
        if ( getdvarint( @"hash_c85a9bcc06a81a1f", 0 ) )
        {
            if ( !isdefined( container.var_6e6ff8fe385db3a ) )
            {
                container.var_6e6ff8fe385db3a = [];
            }
            
            container.var_6e6ff8fe385db3a[ containerslot ] = [];
            container.var_6e6ff8fe385db3a[ containerslot ][ "lootID" ] = backpacklootid;
            container.var_6e6ff8fe385db3a[ containerslot ][ "quantity" ] = backpackquantity;
        }
    }
    
    if ( function_aa0397fa378bc8e4( container ) )
    {
        self setclientomnvar( "loot_container_open", 0 );
        container notify( #"closed" );
        pickups::loothide( container );
    }
    
    function_298b77306db108f0( containerlootid, self, container, containerslot );
}

// Namespace loot_mp
// Params 4
// Checksum 0xa479a8b0, Offset: 0x5d53
// Size: 0x20c
function function_345ace5702e91f1a( loadoutindex, player, container, itemtype )
{
    if ( player.carryinghostage && isdefined( level.br_pickups.var_9d247aba85e39454 ) )
    {
        player hud_message::showerrormessage( level.br_pickups.var_9d247aba85e39454 );
        return;
    }
    
    [ lootid, weaponslotobj, pastteam, metadata, quantity, _, _ ] = function_eb64c60707462d81( player, container );
    
    if ( !isdefined( weaponslotobj ) )
    {
        return;
    }
    
    br_pickups::quickdropweapon( player, 1, loadoutindex - 1, undefined, 0, 0 );
    backpackweaponname = getcompleteweaponname( weaponslotobj );
    var_740d7537d9d9279e = undefined;
    
    if ( isdefined( weaponslotobj.basename ) )
    {
        var_740d7537d9d9279e = weaponslotobj.basename;
    }
    else
    {
        var_740d7537d9d9279e = getweaponbasename( weaponslotobj );
    }
    
    overrideorigin = undefined;
    
    if ( function_aa0397fa378bc8e4( container ) )
    {
        overrideorigin = container.origin;
    }
    
    success = br_weapons::br_forcegivecustomweapon( player, weaponslotobj, backpackweaponname, var_740d7537d9d9279e, undefined, undefined, overrideorigin, undefined, pastteam );
    
    if ( success )
    {
        weaponslot = 0;
        currentprimary = br_pickups::function_5ef22d170cdde55e( player, 0 );
        currentsecondary = br_pickups::function_5ef22d170cdde55e( player, 1 );
        
        if ( currentprimary == weaponslotobj )
        {
            weaponslot = 0;
        }
        else if ( currentsecondary == weaponslotobj )
        {
            weaponslot = 1;
        }
        
        br_instance_inventory::function_72c9ea7f1f09c391( player, weaponslotobj, weaponslot, 1, metadata );
        function_a3d8c84944353dfe( player, container );
        
        if ( function_aa0397fa378bc8e4( container ) )
        {
            player setclientomnvar( "loot_container_open", 0 );
            container notify( #"closed" );
            pickups::loothide( container );
        }
    }
}

// Namespace loot_mp
// Params 2
// Checksum 0xcfaaf944, Offset: 0x5f67
// Size: 0x239
function function_33781f4917f1fcde( opener, container )
{
    [ items, lastvalidindex ] = function_bd786d01398cca27( container.contents, opener, container );
    container.contents = items;
    opener.var_50f741a14f09a6 = container;
    opener.var_75f60e367c30d7ac = opener.origin;
    
    if ( isdefined( container.linkedparent ) )
    {
        opener.var_75f60e367c30d7ac = rotatevectorinverted( opener.origin - container.linkedparent.origin, container.linkedparent.angles );
    }
    
    /#
        if ( items.size > 55 )
        {
            println( "<dev string:xcf>" + items.size + "<dev string:x103>" + 55 + "<dev string:x11c>" );
        }
    #/
    
    for ( itemindex = 0; itemindex < 55 ; itemindex++ )
    {
        if ( itemindex <= lastvalidindex )
        {
            function_7875275a0511dfeb( opener, container, itemindex, items[ itemindex ][ "lootID" ], items[ itemindex ][ "quantity" ], items[ itemindex ][ "ref" ] );
            continue;
        }
        
        function_8632ef63c71b6048( opener, itemindex );
    }
    
    opener setclientomnvar( "loot_container_weapon", 0 );
    
    if ( !isdefined( container.containertype ) )
    {
        container.containertype = 1;
    }
    
    containertype = container.containertype;
    
    foreach ( player in level.players )
    {
        container disablescriptableplayeruse( player );
    }
    
    opener setclientomnvar( "loot_container_open", containertype );
    container thread function_3cd03ddb9c97fb47( container, opener );
    container thread function_f4864e365efb6c46( container, opener );
    opener calloutmarkerping::function_d34345aa1f30ebba();
}

// Namespace loot_mp
// Params 5
// Checksum 0x891d3f8a, Offset: 0x61a8
// Size: 0x93
function function_a7da62c448fddcd8( player, slotindex, container, var_173cfcf7993f6228, quantity )
{
    if ( function_aa0397fa378bc8e4( container ) )
    {
        return;
    }
    
    if ( slotindex == 100 )
    {
        function_79d9c92e2724f1b0( player, container );
    }
    else
    {
        function_2eb63da268420582( player, slotindex, container );
        function_3d2df00a6e925f1b( player, slotindex, quantity, container, var_173cfcf7993f6228 );
    }
    
    if ( isdefined( container ) && iscontainerempty( container, player ) && iscontaineropen( player ) )
    {
        common_cache::closelootablecontainer( container, player );
    }
}

// Namespace loot_mp
// Params 2
// Checksum 0xf7d1d7a5, Offset: 0x6243
// Size: 0x1e0
function function_1cb8c3d990595192( notification, slotindex )
{
    if ( level.infilcinematicactive )
    {
        return;
    }
    
    if ( isdefined( notification ) )
    {
        if ( !isdefined( self.var_50f741a14f09a6 ) )
        {
            return;
        }
        
        container = self.var_50f741a14f09a6;
        
        switch ( notification )
        {
            case #"hash_31a47c100531f34f":
                function_a7da62c448fddcd8( self, slotindex, container, undefined, 1 );
                break;
            case #"hash_b7e2e7e659da3043":
                function_a7da62c448fddcd8( self, slotindex, container );
                break;
            case #"hash_453445f0e586a78e":
                loadoutindex = slotindex >> 8;
                itemtype = slotindex & 255;
                
                if ( ( itemtype == 3 || itemtype == 150 ) && loadoutindex != 0 )
                {
                    function_345ace5702e91f1a( loadoutindex, self, container, itemtype );
                }
                else if ( slotindex == 100 || itemtype == 150 )
                {
                    function_439af3b796a87468( self, container, itemtype );
                }
                else
                {
                    function_2eb63da268420582( self, itemtype, container );
                    function_4b734bd88c67417b( self, itemtype, loadoutindex, container );
                }
                
                if ( isdefined( container ) && iscontainerempty( container, self ) && iscontaineropen( self ) )
                {
                    common_cache::closelootablecontainer( container, self );
                }
                
                break;
            case #"hash_fb84b605789df05e":
                if ( isdefined( container ) )
                {
                    common_cache::closelootablecontainer( container, self );
                }
                
                break;
            case #"hash_10217053947e341b":
                containerslot = slotindex >> 8;
                backpackslot = slotindex & 255;
                
                if ( iscontaineropen( self ) && isdefined( container ) )
                {
                    function_46e9fad35d05d811( containerslot, backpackslot, container );
                }
                
                if ( isdefined( container ) && iscontainerempty( container, self ) && iscontaineropen( self ) )
                {
                    common_cache::closelootablecontainer( container, self );
                }
                
                break;
            default:
                break;
        }
    }
}

// Namespace loot_mp
// Params 3
// Checksum 0xfea9ba07, Offset: 0x642b
// Size: 0xc5
function function_2eb63da268420582( player, slotindex, container )
{
    if ( function_b883bff8be9f52eb( container, slotindex ) )
    {
        return;
    }
    
    lootid = getlootidatcontainerindex( player, slotindex, container );
    itemquantity = function_adc34dc6458d547b( player, slotindex, container );
    
    if ( lootid == 0 || itemquantity == 0 )
    {
        return;
    }
    
    contentscontainer = function_aea840f4352608fb( player, container );
    contents = contentscontainer.contents;
    
    if ( isdefined( contents[ slotindex ][ "callback" ] ) )
    {
        thread [[ self.var_50f741a14f09a6.contents[ slotindex ][ "callback" ] ]]( self.var_50f741a14f09a6, player );
    }
}

// Namespace loot_mp
// Params 0
// Checksum 0x9aaf097, Offset: 0x64f8
// Size: 0x18, Type: bool
function function_9722c743ac724c51()
{
    return ( getmatchrulesdata( "commonOption", "lootCacheInventoryStrip" ) ?? 1 ) == 1;
}

// Namespace loot_mp
// Params 1
// Checksum 0x29edde18, Offset: 0x6519
// Size: 0x2c8
function function_35a36ca65478ae37( container )
{
    if ( container.type == "br_loot_cache_april" )
    {
        return 0;
    }
    
    if ( game_utility::getgametype() == "dmz" && !getdvarint( @"hash_597831555a246842", 0 ) )
    {
        return 1;
    }
    
    if ( isdefined( container.type ) && container.type != "br_loot_cache" && container.type != "br_reusable_loot_cache" && container.type != "br_loot_cache_yellow" && container.type != "br_loot_cache_yellow_quiet" && container.type != "br_loot_cache_lege" && container.type != "br_loot_cache_gulag" && container.type != "br_loot_cache_personal_supply" && container.type != "br_loot_cache_stronghold" && container.type != "br_loot_cache_blacksite" && container.type != "br_loot_cache_bunker" && container.type != "cache_medicine_cabinet" && container.type != "cache_cash_register" && container.type != "cache_cash_register_clean" && container.type != "cache_medical_box_wall" && container.type != "cache_medical_box_wall_worn" && container.type != "dmz_hidden_container_common" && container.type != "cache_duffel_bag_01" && container.type != "cache_duffel_bag_02" && container.type != "cache_weapon_locker" && container.type != "br_loot_cache_holiday_common" && container.type != "br_loot_cache_holiday_lege" && container.type != "br_loot_cache_holiday_dth" && container.type != "ob_loot_cache_large" && container.type != "br_loot_cache_roguesignal" && container.type != "br_loot_cache_personal_legacy" && container.type != "br_loot_cache_personal_legacy_golden" )
    {
        if ( utility::issharedfuncdefined( #"gametype", #"hash_5c8b26ceb24796f8" ) )
        {
            return utility::callsharedfunc( #"gametype", #"hash_5c8b26ceb24796f8", container );
        }
        
        return 1;
    }
    
    if ( !getdvarint( @"hash_f6c12cf19ac66121", 1 ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace loot_mp
// Params 0
// Checksum 0xdf5766cd, Offset: 0x67ea
// Size: 0x17, Type: bool
function function_861930f87f16abbc()
{
    return ( getmatchrulesdata( "commonOption", "aiBackpackDrop" ) ?? 0 ) == 1;
}

// Namespace loot_mp
// Params 0
// Checksum 0x787bec5d, Offset: 0x680a
// Size: 0x18, Type: bool
function function_7e4d11ff71e3d599()
{
    return ( getmatchrulesdata( "commonOption", "playerBackpackDrop" ) ?? 1 ) == 1;
}

// Namespace loot_mp
// Params 0
// Checksum 0xd95f700b, Offset: 0x682b
// Size: 0x1c, Type: bool
function function_1c8bb57e5f495dec()
{
    return function_861930f87f16abbc() || function_7e4d11ff71e3d599() || function_9722c743ac724c51();
}

// Namespace loot_mp
// Params 3
// Checksum 0x3eb41f4c, Offset: 0x6850
// Size: 0x2ed
function getindexforlootidincontainer( container, lootid, player )
{
    if ( !isdefined( container ) )
    {
        return [ undefined, undefined ];
    }
    
    container = function_aea840f4352608fb( player, container );
    
    if ( !( isdefined( container.contents ) && isdefined( lootid ) ) )
    {
        return [ undefined, undefined ];
    }
    
    if ( function_5cdaa261d954d20( container ) )
    {
        foreach ( index, item in container.contents )
        {
            if ( !( isdefined( item[ "lootID" ] ) && isdefined( item[ "quantity" ] ) ) || item[ "lootID" ] == 0 || item[ "quantity" ] == 0 )
            {
                continue;
            }
            
            if ( item[ "lootID" ] == lootid )
            {
                return [ index, 0 ];
            }
        }
        
        if ( isdefined( container.loadoutcontents ) )
        {
            foreach ( index, item in container.loadoutcontents )
            {
                if ( !( isdefined( item[ "lootID" ] ) && isdefined( item[ "quantity" ] ) ) || item[ "lootID" ] == 0 || item[ "quantity" ] == 0 )
                {
                    continue;
                }
                
                if ( item[ "lootID" ] == lootid )
                {
                    return [ index, 1 ];
                }
            }
        }
        
        if ( isdefined( container.var_9185433e2ad9ec33 ) && lootid == container.var_64df982caf48609c )
        {
            return [ 100, 1 ];
        }
    }
    
    foreach ( index, item in container.contents )
    {
        if ( !( isdefined( item[ "lootID" ] ) && isdefined( item[ "quantity" ] ) ) || item[ "lootID" ] == 0 || item[ "quantity" ] == 0 )
        {
            continue;
        }
        
        if ( item[ "lootID" ] == lootid )
        {
            return [ index, 0 ];
        }
    }
    
    if ( lootid == container.weaponslotcontents )
    {
        return [ 100, 0 ];
    }
    
    return [ undefined, undefined ];
}

// Namespace loot_mp
// Params 2
// Checksum 0x1a6f5515, Offset: 0x6b46
// Size: 0x2d
function function_aea840f4352608fb( opener, container )
{
    if ( function_13a69e0034bdf2f9( opener, container ) )
    {
        return function_89b43bf99e20a168( opener, container );
    }
    
    return container;
}

// Namespace loot_mp
// Params 4
// Checksum 0xec85c56f, Offset: 0x6b7c
// Size: 0x9c
function function_e954849d8e889bd( opener, container, index, var_173cfcf7993f6228 )
{
    var_ae0b9b4845da97d8 = function_b883bff8be9f52eb( container, index );
    
    if ( var_ae0b9b4845da97d8 )
    {
        index -= 11;
        lootid = getloadoutdoublebackpacklootid( container, index, var_173cfcf7993f6228 );
        itemquantity = function_a52c163bca75efe8( container, index, var_173cfcf7993f6228 );
    }
    else
    {
        lootid = getlootidatcontainerindex( opener, index, container, var_173cfcf7993f6228 );
        itemquantity = function_adc34dc6458d547b( opener, index, container, var_173cfcf7993f6228 );
    }
    
    return [ lootid, itemquantity ];
}

// Namespace loot_mp
// Params 4
// Checksum 0x2900b22f, Offset: 0x6c21
// Size: 0xab
function function_9a3e2cb4da8b5868( opener, container, index, quantity )
{
    if ( !isdefined( container ) )
    {
        return;
    }
    
    if ( function_b883bff8be9f52eb( container, index ) )
    {
        container.loadoutcontents[ index - 11 ][ "quantity" ] = quantity;
        return;
    }
    
    if ( function_13a69e0034bdf2f9( opener, container ) )
    {
        container.playercontents[ opener.guid ].contents[ index ][ "quantity" ] = quantity;
        return;
    }
    
    container.contents[ index ][ "quantity" ] = quantity;
}

// Namespace loot_mp
// Params 4
// Checksum 0x89bdd72, Offset: 0x6cd4
// Size: 0xab
function function_45dc08cd179c7b32( opener, container, index, lootid )
{
    if ( !isdefined( container ) )
    {
        return;
    }
    
    if ( function_b883bff8be9f52eb( container, index ) )
    {
        container.loadoutcontents[ index - 11 ][ "lootID" ] = lootid;
        return;
    }
    
    if ( function_13a69e0034bdf2f9( opener, container ) )
    {
        container.playercontents[ opener.guid ].contents[ index ][ "lootID" ] = lootid;
        return;
    }
    
    container.contents[ index ][ "lootID" ] = lootid;
}

// Namespace loot_mp
// Params 5
// Checksum 0x94c9293b, Offset: 0x6d87
// Size: 0xc0
function function_66668ee51ee32f35( opener, container, index, lootid, quantity )
{
    if ( !( isdefined( container ) && isdefined( opener ) && isdefined( index ) && isdefined( lootid ) && isdefined( quantity ) ) )
    {
        return;
    }
    
    lootid = lootid > 0 ? lootid : 0;
    quantity = quantity > 0 ? quantity : 0;
    
    if ( lootid == 0 || quantity == 0 )
    {
        lootid = 0;
        quantity = 0;
    }
    
    function_45dc08cd179c7b32( opener, container, index, lootid );
    function_9a3e2cb4da8b5868( opener, container, index, quantity );
    containercontents = function_aea840f4352608fb( opener, container );
    function_7875275a0511dfeb( opener, containercontents, index, lootid, quantity );
}

// Namespace loot_mp
// Params 2
// Checksum 0x27e27ab8, Offset: 0x6e4f
// Size: 0x6f, Type: bool
function function_a319e5c06802cd78( opener, container )
{
    if ( !isdefined( container ) )
    {
        return false;
    }
    
    if ( isdefined( container.var_64df982caf48609c ) && isdefined( container.var_9185433e2ad9ec33 ) )
    {
        return true;
    }
    
    contentscontainer = function_aea840f4352608fb( opener, container );
    return isdefined( contentscontainer.weaponslotcontents ) && isdefined( contentscontainer.weaponslotobj );
}

// Namespace loot_mp
// Params 3
// Checksum 0x652ba695, Offset: 0x6ec7
// Size: 0x1fa
function function_eb64c60707462d81( opener, container, index )
{
    weaponref = function_1a03bf6e54b76ecf( opener, container, index );
    
    if ( isdefined( weaponref ) )
    {
        lootid = loot::function_d3e3bcaea591a6a2( weaponref );
        weaponobj = br_pickups::getfullweaponobjforscriptablepartname( weaponref );
        return [ lootid, weaponobj, undefined, undefined, weaponclipsize( weaponobj ) ];
    }
    
    if ( !function_a319e5c06802cd78( opener, container ) )
    {
        return [ undefined, undefined, undefined, undefined, undefined ];
    }
    
    lootid = undefined;
    weaponobj = undefined;
    pastteam = undefined;
    metadata = undefined;
    quantity = undefined;
    altquantity = undefined;
    lefthandquantity = undefined;
    
    if ( isdefined( container.var_64df982caf48609c ) && isdefined( container.var_9185433e2ad9ec33 ) )
    {
        lootid = container.var_64df982caf48609c;
        weaponobj = container.var_9185433e2ad9ec33;
        pastteam = container.var_d770d062d2277817;
        metadata = container.loadoutmetadata;
        quantity = container.var_83d5ec579c0923f0;
        altquantity = container.var_a58af1de7ecc7625;
        lefthandquantity = container.var_d5f1431744f9428c;
    }
    else
    {
        containercontents = function_aea840f4352608fb( opener, container );
        lootid = containercontents.weaponslotcontents;
        weaponobj = containercontents.weaponslotobj;
        pastteam = containercontents.var_d80f548b9b26d1fb;
        metadata = containercontents.metadata;
        quantity = containercontents.weaponslotclip;
        altquantity = containercontents.var_655fababc6344d9f;
        lefthandquantity = containercontents.var_ee5ceae7ad99228;
    }
    
    return [ lootid, weaponobj, pastteam, metadata, quantity, altquantity, lefthandquantity ];
}

// Namespace loot_mp
// Params 3
// Checksum 0x8db6bc8b, Offset: 0x70ca
// Size: 0x207
function function_a3d8c84944353dfe( opener, container, index )
{
    if ( function_d8e3e3b93d310128( opener, container, index ) )
    {
        function_66668ee51ee32f35( opener, container, index, 0, 0 );
        return;
    }
    
    if ( function_13a69e0034bdf2f9( opener, container ) )
    {
        container.playercontents[ opener.guid ].weaponslotobj = undefined;
        container.playercontents[ opener.guid ].weaponslotcontents = 0;
        container.playercontents[ opener.guid ].metadata = undefined;
        container.playercontents[ opener.guid ].var_d80f548b9b26d1fb = undefined;
        container.playercontents[ opener.guid ].weaponslotclip = undefined;
        container.playercontents[ opener.guid ].var_ee5ceae7ad99228 = undefined;
        container.playercontents[ opener.guid ].var_655fababc6344d9f = undefined;
    }
    else if ( isdefined( container.var_64df982caf48609c ) && isdefined( container.var_9185433e2ad9ec33 ) )
    {
        container.var_9185433e2ad9ec33 = undefined;
        container.var_64df982caf48609c = 0;
        container.loadoutmetadata = undefined;
        container.var_d770d062d2277817 = undefined;
        container.var_83d5ec579c0923f0 = undefined;
        container.var_a58af1de7ecc7625 = undefined;
        container.var_d5f1431744f9428c = undefined;
        function_9d65d96238d48ae( opener );
        return;
    }
    else
    {
        container.weaponslotobj = undefined;
        container.weaponslotcontents = 0;
        container.metadata = undefined;
        container.var_d80f548b9b26d1fb = undefined;
        container.weaponslotclip = undefined;
        container.var_655fababc6344d9f = undefined;
        container.var_ee5ceae7ad99228 = undefined;
    }
    
    opener setclientomnvar( "loot_container_weapon", 0 );
}

// Namespace loot_mp
// Params 9
// Checksum 0xe751078, Offset: 0x72d9
// Size: 0xc4
function function_43b2ea123b58c1c4( container, lootid, weaponobj, pastteam, noextract, quantity, metadata, altclip, lefthandquantity )
{
    container.weaponslotcontents = lootid;
    container.weaponslotobj = weaponobj;
    container.var_d80f548b9b26d1fb = pastteam;
    container.var_758b843ffc08c9b2 = noextract;
    container.weaponslotclip = quantity;
    container.var_ee5ceae7ad99228 = lefthandquantity;
    container.var_655fababc6344d9f = altclip;
    container.metadata = metadata;
}

// Namespace loot_mp
// Params 11
// Checksum 0x602e120f, Offset: 0x73a5
// Size: 0xe3
function function_3d4987dd14eeffe0( player, specificcontainer, weaponobj, lootid, itemtype, itemindex, quantity, metadata, noextract, altclip, lefthandquantity )
{
    script::demoforcesre( "Removed a br_weapons function as br_weapons is deprecated. Add in common_item system logic instead to handle pastTeam if this is needed still" );
    pastteam = undefined;
    
    if ( isdefined( specificcontainer ) )
    {
        function_43b2ea123b58c1c4( specificcontainer, lootid, weaponobj, pastteam, noextract, quantity, metadata, altclip, lefthandquantity );
    }
    else
    {
        function_43b2ea123b58c1c4( player.var_50f741a14f09a6, lootid, weaponobj, pastteam, noextract, quantity, metadata, altclip, lefthandquantity );
    }
    
    function_5b66206be41a47a7( player, specificcontainer, "loot_container_weapon", lootid, weaponobj );
    
    if ( isdefined( itemtype ) && isdefined( itemindex ) )
    {
        player thread br_pickups::quickdropitem( itemtype, itemindex, 1 );
    }
}

// Namespace loot_mp
// Params 3
// Checksum 0x2b81bca0, Offset: 0x7490
// Size: 0x63, Type: bool
function function_d8e3e3b93d310128( opener, container, index )
{
    if ( !( isdefined( opener ) && isdefined( container ) && isdefined( index ) ) )
    {
        return false;
    }
    
    contentscontainer = function_aea840f4352608fb( opener, container );
    return isdefined( contentscontainer ) && isdefined( contentscontainer.contents[ index ][ "ref" ] );
}

// Namespace loot_mp
// Params 3
// Checksum 0x1bd6dc0e, Offset: 0x74fc
// Size: 0x56
function function_1a03bf6e54b76ecf( opener, container, index )
{
    if ( !function_d8e3e3b93d310128( opener, container, index ) )
    {
        return;
    }
    
    contentscontainer = function_aea840f4352608fb( opener, container );
    return contentscontainer.contents[ index ][ "ref" ];
}

// Namespace loot_mp
// Params 2
// Checksum 0xa06f5f3, Offset: 0x755b
// Size: 0x5c
function function_db7a81db21067850( opener, container )
{
    partname = container function_84ad2f70189ee7c3();
    
    if ( function_13a69e0034bdf2f9( opener, container ) )
    {
        function_7f12edd369eb3ae9( opener, container );
        return;
    }
    
    if ( container getscriptableparthasstate( partname, "fully_opening_unusable" ) )
    {
        container setscriptablepartstate( partname, "fully_opening_unusable" );
    }
}

// Namespace loot_mp
// Params 4
// Checksum 0x504bae83, Offset: 0x75bf
// Size: 0xfb
function function_298b77306db108f0( lootid, player, container, index )
{
    if ( !function_5cdaa261d954d20( container ) || !br_pickups::function_cfce107ef35a347e( loot::getScriptableFromLootID( lootid ) ) || !function_56d525c33dd2bd84( index ) )
    {
        return;
    }
    
    basecount = common_item::function_44eacd480abb5b94( container.count );
    spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( container.origin, container.angles );
    spawnedbackpack = namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( "brloot_backpack_player_small", basecount, spawnoptions );
    function_be3976eed851ec20( container, spawnedbackpack );
    spawnedbackpack setscriptablepartstate( "body", "partially_open_usable" );
    
    if ( isdefined( container.opener ) )
    {
        openlootablecontainer( container.opener, spawnedbackpack );
    }
    
    pickups::loothide( container, "body" );
}

// Namespace loot_mp
// Params 2
// Checksum 0xc9e9165, Offset: 0x76c2
// Size: 0x2c9
function function_be3976eed851ec20( container, backpack )
{
    backpack.contents = container.contents;
    backpack.containertype = container.containertype;
    backpack.deadplayerindex = container.deadplayerindex;
    backpack.owner = container.owner;
    backpack.weaponslotcontents = container.weaponslotcontents;
    backpack.weaponslotobj = container.weaponslotobj;
    backpack.weaponslotclip = container.weaponslotclip;
    backpack.var_ee5ceae7ad99228 = container.var_ee5ceae7ad99228;
    backpack.var_d80f548b9b26d1fb = container.var_d80f548b9b26d1fb;
    backpack.metadata = container.var_ba26f716717f0caf;
    backpack.var_655fababc6344d9f = container.var_655fababc6344d9f;
    backpack.backpacksize = container.backpacksize;
    backpack.loadoutcontents = container.loadoutcontents;
    backpack.var_64df982caf48609c = container.var_64df982caf48609c;
    backpack.var_9185433e2ad9ec33 = container.var_9185433e2ad9ec33;
    backpack.var_83d5ec579c0923f0 = container.var_83d5ec579c0923f0;
    backpack.var_d5f1431744f9428c = container.var_d5f1431744f9428c;
    backpack.var_a58af1de7ecc7625 = container.var_a58af1de7ecc7625;
    backpack.loadoutmetadata = container.loadoutmetadata;
    backpack.var_d770d062d2277817 = container.var_d770d062d2277817;
    
    if ( isdefined( container.owner ) && isdefined( container.owner.var_a883ec236391a6bf ) )
    {
        container.owner.var_a883ec236391a6bf = backpack;
    }
    
    if ( game_utility::getgametype() == "dmz" )
    {
        backpack.criticalitem = 1;
    }
    
    foreach ( item in backpack.contents )
    {
        utility::callsharedfunc( item[ "lootID" ], #"hash_9f56ee5ad640666b", backpack );
    }
}

// Namespace loot_mp
// Params 3
// Checksum 0xcca108ac, Offset: 0x7993
// Size: 0x68
function function_29cd9a9428b7935f( container, player, items )
{
    initplayercontents( player, container, container.containertype );
    
    if ( !isdefined( container.playersregistered ) )
    {
        container.playersregistered = [];
    }
    
    container.playersregistered[ player.guid ] = items;
}

// Namespace loot_mp
// Params 3
// Checksum 0x8759320d, Offset: 0x7a03
// Size: 0x92
function function_8b29ceedb578f4b8( container, players, items )
{
    foreach ( player in players )
    {
        function_29cd9a9428b7935f( container, player, items );
    }
}

// Namespace loot_mp
// Params 4
// Checksum 0x563dd0da, Offset: 0x7a9d
// Size: 0x18e
function initplayercontents( player, container, containertype, weaponslot )
{
    if ( !isdefined( container.playercontents ) )
    {
        container.playercontents = [];
    }
    
    if ( !isdefined( container.playercontents[ player.guid ] ) )
    {
        container.playercontents[ player.guid ] = spawnstruct();
        container.playercontents[ player.guid ].contents = [];
    }
    
    container.containertype = 1;
    container.playercontents[ player.guid ].containertype = 1;
    
    if ( isdefined( containertype ) )
    {
        container.containertype = containertype;
        container.playercontents[ player.guid ].containertype = containertype;
    }
    
    container.playercontents[ player.guid ].type = container.type;
    container.playercontents[ player.guid ].origin = container.origin;
    container.playercontents[ player.guid ].angles = container.angles;
}

// Namespace loot_mp
// Params 3
// Checksum 0xd1f51c86, Offset: 0x7c33
// Size: 0x16c
function function_c1bd3db63e64bad1( player, container, items )
{
    if ( !function_13a69e0034bdf2f9( player, container ) )
    {
        initplayercontents( player, container );
    }
    
    if ( !isarray( items ) )
    {
        items = [ items ];
    }
    
    foreach ( item in items )
    {
        index = container.playercontents[ player.guid ].contents.size;
        container.playercontents[ player.guid ].contents[ index ] = [];
        container.playercontents[ player.guid ].contents[ index ][ "lootID" ] = item[ "lootID" ];
        container.playercontents[ player.guid ].contents[ index ][ "quantity" ] = item[ "quantity" ] ?? 1;
    }
}

// Namespace loot_mp
// Params 9
// Checksum 0x50228a2a, Offset: 0x7da7
// Size: 0x167
function function_20d60770b321859d( player, container, lootid, quantity, weaponobj, metadata, pastteam, altquantity, lefthandquantity )
{
    if ( !function_13a69e0034bdf2f9( player, container ) )
    {
        initplayercontents( player, container );
    }
    
    container.playercontents[ player.guid ].weaponslotcontents = lootid;
    container.playercontents[ player.guid ].weaponslotobj = weaponobj;
    container.playercontents[ player.guid ].metadata = metadata;
    container.playercontents[ player.guid ].var_d80f548b9b26d1fb = pastteam;
    container.playercontents[ player.guid ].weaponslotclip = quantity;
    container.playercontents[ player.guid ].var_ee5ceae7ad99228 = lefthandquantity;
    container.playercontents[ player.guid ].var_655fababc6344d9f = altquantity;
}

// Namespace loot_mp
// Params 2
// Checksum 0xe2389b30, Offset: 0x7f16
// Size: 0x39, Type: bool
function function_13a69e0034bdf2f9( opener, container )
{
    return isdefined( container ) && isdefined( opener ) && isdefined( container.playercontents[ opener.guid ] );
}

// Namespace loot_mp
// Params 2
// Checksum 0x61bba21e, Offset: 0x7f58
// Size: 0x49
function function_89b43bf99e20a168( opener, container )
{
    if ( !isdefined( container.playercontents[ opener.guid ] ) )
    {
        return;
    }
    
    return container.playercontents[ opener.guid ];
}

// Namespace loot_mp
// Params 2
// Checksum 0xb6145d15, Offset: 0x7faa
// Size: 0x53
function function_2a575a3a25290973( opener, container )
{
    if ( !isdefined( container.playercontents[ opener.guid ] ) )
    {
        return;
    }
    
    return container.playercontents[ opener.guid ].contents;
}

// Namespace loot_mp
// Params 2
// Checksum 0x5fe3c41f, Offset: 0x8006
// Size: 0x1d
function function_8bcd3d98b0f96525( player, container )
{
    container disablescriptableplayeruse( player );
}

// Namespace loot_mp
// Params 2
// Checksum 0xfc2bda9c, Offset: 0x802b
// Size: 0x107
function function_7f12edd369eb3ae9( opener, container )
{
    totalplayers = container.playercontents.size;
    totalcount = 0;
    
    foreach ( guid, playercontents in container.playercontents )
    {
        player = player::getplayerforguid( guid );
        
        if ( iscontainerempty( playercontents, player ) )
        {
            totalcount++;
            function_8bcd3d98b0f96525( player, container );
        }
    }
    
    partname = container function_84ad2f70189ee7c3();
    
    if ( totalcount >= totalplayers && container getscriptableparthasstate( partname, "fully_opening_unusable" ) )
    {
        container setscriptablepartstate( partname, "fully_opening_unusable" );
    }
}

