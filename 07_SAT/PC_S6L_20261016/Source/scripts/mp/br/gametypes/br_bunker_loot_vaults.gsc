// scripts\mp\br\gametypes\br_bunker_loot_vaults.gsc  (hash_2d9875ef179cf5cc.gscc) (size: 4399 Bytes / 0x112f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6101ee7e (1627516542)
// size ...... 4399 (0x112f)
// includes .. 7   (offset: 0xfcb)
// strings ... 18  (offset: 0x1003)
// dev strs .. 1   (offset: 0x1123)
// exports ... 6   (offset: 0xb4f)
// cseg ...... 0x1cd + 0x982 (0xb4f)
// imports ... 30  (offset: 0xc3f)
// animtree1 . 0   (offset: 0x112f)
// animtree2 . 0   (offset: 0x112f)
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\br\br_quest_inventory;
#using scripts\mp\br\gametypes\br_bunker_alt;
#using scripts\mp\br\gametypes\br_bunker_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\flags;

#namespace br_bunker_loot_vaults;

// Namespace br_bunker_loot_vaults
// Params 0
// Checksum 0x7598fcd6, Offset: 0x1eb
// Size: 0x30a
function init()
{
    level.lootbunkersactive = getdvarint( @"hash_48fd1e2273274091", 1 ) && getdvarint( @"scr_sierra_sidequest_enabled", 1 );
    level.maxaccesscardspawns_red = getdvarint( @"scr_bunker_maxaccesscardspawns_red", 5 );
    level.accesscardsspawned_red = 0;
    scriptable::scriptable_addusedcallbackbypart( "maphint_keypad_bunker_loot_vault", &keypadscriptableused );
    var_cd0b0131a144b9cd = [ undefined, 0, 1, 3, 4, 5, 6, 9, 10, 11 ];
    var_cd0b0131a144b9cd[ 19 ] = 2;
    var_cd0b0131a144b9cd[ 20 ] = 7;
    var_cd0b0131a144b9cd[ 21 ] = 8;
    var_5dce51dd2b3cb00 = [ 1, 2, 3, 7, 8, 10 ];
    level.var_aab6ca8e50b31e47 = [ 2, 7, 8 ];
    var_cb9522469a8aaf87 = [];
    level.bunker_loot_vaults = spawnstruct();
    level.bunker_loot_vaults.doors = [];
    level.bunker_loot_vaults.hints = [];
    
    foreach ( questid, bunkernumber in var_cd0b0131a144b9cd )
    {
        bunkernumber = var_cd0b0131a144b9cd[ questid ];
        var_5ca997607409a6c8 = hashcat( @"hash_2ac45dbf3d037071", bunkernumber, "_enabled" );
        
        if ( getdvarint( var_5ca997607409a6c8, 1 ) )
        {
            var_cb9522469a8aaf87[ var_cb9522469a8aaf87.size ] = bunkernumber;
        }
    }
    
    for ( i = 0; i <= 10 ; i++ )
    {
        var_132b6c221fdfb884 = "bunker_door_" + i;
        var_ba0098459e26fdcd = "bunker_staged_reward_vault_" + i;
        var_db6e8324dc0605a2 = getaltbunkerindexforname( var_132b6c221fdfb884 );
        
        if ( var_db6e8324dc0605a2 >= 0 )
        {
            continue;
        }
        
        doors = getentarray( var_132b6c221fdfb884, #targetname );
        entlessdoors = getentitylessscriptablearray( var_132b6c221fdfb884, #targetname );
        level.bunker_loot_vaults.doors[ i ] = entlessdoors[ 0 ] ?? doors[ 0 ];
        
        if ( !isdefined( level.bunker_loot_vaults.doors[ i ] ) )
        {
            continue;
        }
        
        var_9da443fcdd2d2fab = arraycontains( var_cb9522469a8aaf87, i ) && level.lootbunkersactive;
        
        if ( var_9da443fcdd2d2fab )
        {
            level thread br_bunker_utility::function_570a0e83663d22a4( var_ba0098459e26fdcd );
        }
        
        level thread br_bunker_utility::initbunkerdoor( level.bunker_loot_vaults.doors[ i ], var_9da443fcdd2d2fab );
        thread initlootvaultkeypad( var_9da443fcdd2d2fab, i, arraycontains( var_5dce51dd2b3cb00, i ) );
    }
}

// Namespace br_bunker_loot_vaults
// Params 4
// Checksum 0x90db0bbf, Offset: 0x4fd
// Size: 0x305
function initlootvaultkeypad( var_9da443fcdd2d2fab, bunkerindex, var_48a553c335f3ec89, isaltbunker )
{
    if ( getdvarint( @"hash_79e6e6571d8c012", 1 ) == 0 )
    {
        return;
    }
    
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    
    if ( isaltbunker )
    {
        door = level.br_bunker_alt.bunkervaults.doors[ bunkerindex ];
    }
    else
    {
        door = level.bunker_loot_vaults.doors[ bunkerindex ];
    }
    
    forward = anglestoforward( door.angles );
    left = anglestoleft( door.angles );
    hintorigin = undefined;
    keycardconsumable = arraycontains( level.var_aab6ca8e50b31e47, bunkerindex ) ? "wz_consumable_access_card_bunker_blue" : "wz_consumable_access_card_bunker_red";
    
    if ( var_48a553c335f3ec89 )
    {
        hintorigin = door.origin + ( 0, 0, 45 ) + forward * 50 + left * 97;
    }
    else
    {
        hintorigin = door.origin + ( 0, 0, 45 ) + forward * 37 + left * 80;
    }
    
    if ( isaltbunker )
    {
        level.br_bunker_alt.bunkervaults.hints[ bunkerindex ] = spawnscriptable( "maphint_keypad_bunker_alt", hintorigin );
        level.br_bunker_alt.bunkervaults.hints[ bunkerindex ].isopenable = var_9da443fcdd2d2fab;
        level.br_bunker_alt.bunkervaults.hints[ bunkerindex ].door = door;
        level.br_bunker_alt.bunkervaults.hints[ bunkerindex ].bunkernumber = bunkerindex;
        keypadinstance = level.br_bunker_alt.bunkervaults.hints[ bunkerindex ];
    }
    else
    {
        level.bunker_loot_vaults.hints[ bunkerindex ] = spawnscriptable( "maphint_keypad_bunker_loot_vault", hintorigin );
        level.bunker_loot_vaults.hints[ bunkerindex ].isopenable = var_9da443fcdd2d2fab;
        level.bunker_loot_vaults.hints[ bunkerindex ].door = door;
        level.bunker_loot_vaults.hints[ bunkerindex ].bunkernumber = bunkerindex;
        level.bunker_loot_vaults.hints[ bunkerindex ].consumable = keycardconsumable;
        keypadinstance = level.bunker_loot_vaults.hints[ bunkerindex ];
    }
    
    if ( !var_9da443fcdd2d2fab )
    {
        level thread disablekeypad( keypadinstance, isaltbunker );
    }
}

// Namespace br_bunker_loot_vaults
// Params 6
// Checksum 0x26bf4e7c, Offset: 0x80a
// Size: 0x48
function keypadscriptableused( instance, part, state, player, bautouse, usestring )
{
    level thread _keypadscriptableused( instance, part, state, player, bautouse );
}

// Namespace br_bunker_loot_vaults
// Params 5
// Checksum 0x1f2b340, Offset: 0x85a
// Size: 0x2ac
function _keypadscriptableused( instance, part, state, player, bautouse )
{
    assert( part == "<dev string:x24>" );
    isaltbunker = br_bunker_alt::isaltbunkerscriptable( instance );
    assert( !isaltbunker );
    
    if ( instance.backwallkeypad )
    {
        if ( soundexists( "br_keypad_deny" ) )
        {
            playsoundatpos( player.origin, "br_keypad_deny" );
        }
        
        instance setscriptablepartstate( "maphint_keypad_bunker_loot_vault", "off" );
        wait 3;
        instance setscriptablepartstate( "maphint_keypad_bunker_loot_vault", "on" );
        return;
    }
    
    if ( getdvarint( @"hash_8c6e1c43e3d41dd3", 0 ) == 1 || instance.isopenable && player br_quest_inventory::has_quest_item( instance.consumable ) )
    {
        level thread br_bunker_utility::openbunkerdoor( instance.door, 1, "bunker_loot_shared", "door_open" );
        instance setscriptablepartstate( "maphint_keypad_bunker_loot_vault", "off" );
        player br_quest_inventory::consume_quest_item( instance.consumable );
        points::function_40522c040a4e7b1( player.team, #"br_bunker_opened" );
        player utility::callsharedfunc( #"br_bunkers", #"hash_7df9a859177613d0", instance.bunkernumber );
        player dlog_recordplayerevent( "dlog_event_br_bunker_data", [ "index", instance.bunkernumber, "isaltbunker", isaltbunker, "success", 1 ] );
        return;
    }
    
    if ( soundexists( "br_keypad_deny" ) )
    {
        playsoundatpos( player.origin, "br_keypad_deny" );
    }
    
    var_f1f4b01f48f45576 = %"hash_2635390a30032733";
    
    switch ( instance.consumable )
    {
        case #"hash_df902f78f4035f75":
            var_f1f4b01f48f45576 = %"hash_128628d5bb7f2c14";
            break;
        case #"hash_d3e6e201f51aea24":
            var_f1f4b01f48f45576 = %"hash_75ef656ace1b9f9b";
            break;
    }
    
    player [[ level.showerrormessagefunc ]]( var_f1f4b01f48f45576 );
    player dlog_recordplayerevent( "dlog_event_br_bunker_data", [ "index", instance.bunkernumber, "isaltbunker", isaltbunker, "success", 0 ] );
    instance setscriptablepartstate( "maphint_keypad_bunker_loot_vault", "off" );
    wait 3;
    instance setscriptablepartstate( "maphint_keypad_bunker_loot_vault", "on" );
}

// Namespace br_bunker_loot_vaults
// Params 2
// Checksum 0x830c9302, Offset: 0xb0e
// Size: 0x41
function disablekeypad( instance, isaltbunker )
{
    keypadpartname = isaltbunker ? "maphint_keypad_bunker_alt" : "maphint_keypad_bunker_loot_vault";
    waitframe();
    instance setscriptablepartstate( keypadpartname, "inaccessible" );
}

