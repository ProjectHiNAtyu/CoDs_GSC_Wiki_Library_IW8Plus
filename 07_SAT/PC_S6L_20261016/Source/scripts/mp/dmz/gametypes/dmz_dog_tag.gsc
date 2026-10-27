// scripts\mp\dmz\gametypes\dmz_dog_tag.gsc  (hash_05ae27f052cdec39.gscc) (size: 16326 Bytes / 0x3fc6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf9c1cdc3 (4190227907)
// size ...... 16326 (0x3fc6)
// includes .. 18  (offset: 0x3b92)
// strings ... 63  (offset: 0x3c22)
// dev strs .. 3   (offset: 0x3fa2)
// exports ... 38  (offset: 0x26ee)
// cseg ...... 0x4de + 0x2210 (0x26ee)
// imports ... 122 (offset: 0x2cde)
// animtree1 . 0   (offset: 0x3fc6)
// animtree2 . 0   (offset: 0x3fc6)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\bounty_wanted;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\gamelogic;
#using scripts\mp\loot\common_instance_inventory;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_inventory_groups;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\operator;

#namespace dmz_dog_tag;

// Namespace dmz_dog_tag
// Params 0, eflags: 0x5
// Checksum 0x3388faf7, Offset: 0x4fc
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"dogtag", #"common_item", &function_7aa914e7b99624b2, undefined );
}

// Namespace dmz_dog_tag
// Params 0, eflags: 0x4
// Checksum 0xe64d1dbd, Offset: 0x525
// Size: 0x35a
function private function_7aa914e7b99624b2()
{
    if ( !function_8ee07314dbc6f4d7() )
    {
        return;
    }
    
    level.dogtagscriptables = [];
    level.var_1b4ca59164742e80 = [];
    level.var_74325596166ce2b6 = [];
    level.var_fe604c516960e40e = [];
    level.dogtagmeansofdeath = [ [ "MOD_UNKNOWN", "MOD_DOWN", "MOD_TEAM_WIPED", "MOD_DESPAWN" ], [ "MOD_PISTOL_BULLET", "MOD_RIFLE_BULLET", "MOD_EXPLOSIVE_BULLET" ], [ "MOD_GRENADE", "MOD_GRENADE_SPLASH" ], [ "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE", "MOD_SCORESTREAK" ], [ "MOD_MELEE", "MOD_MELEE_DOG", "MOD_MELEE_ALIEN" ], [ "MOD_HEAD_SHOT" ], [ "MOD_CRUSH", "MOD_IMPACT" ], [ "MOD_FALLING" ], [ "MOD_SUICIDE", "MOD_TRIGGER_HURT" ], [ "MOD_FIRE", "MOD_FIRE_BULLET", "MOD_ELEMENTAL_FIRE" ], [ "MOD_EXECUTION", "MOD_MEATSHIELD" ], [ "MOD_PENETRATION" ], [ "MOD_INTERROGATE" ], [ "MOD_ELEMENTAL_ELEC" ], [ "MOD_ELEMENTAL_COLD" ], [ "MOD_ELEMENTAL_TOXIC" ], [ "MOD_ELEMENTAL_DARK" ], [ "MOD_ELEMENTAL_LIGHT" ], [ "MOD_RADIATION" ], [ "MOD_TEAM_TO_GULAG" ], [ "MOD_TEAM_REPOSITIONING" ] ];
    callback::add( #"player_connect", &onplayerconnect );
    callback::add( #"player_spawned", &onplayerspawn );
    callback::add( #"player_extracted", &function_6dabd8def75a469a );
    utility::registersharedfunc( #"dogtag", #"getdogtagdata", &getdogtagdata );
    callback::add( #"player_assimilated", &onteamchange );
    common_item::function_4b30c091d3b04a25( "dogtag" );
    common_item::function_84174b793b5fe9a7( "dogtag", #"use", &usedogtag );
    common_item::function_84174b793b5fe9a7( "dogtag", #"canautouse", &function_ef411319f71e7850 );
    common_item::function_84174b793b5fe9a7( "dogtag", #"hash_9886eb1395647ce1", &function_3f23879132f430f );
    common_item::function_84174b793b5fe9a7( "dogtag", #"getcurrent", &function_716a9ec0bf85a9c1 );
    common_item::function_84174b793b5fe9a7( "dogtag", #"database_additem", &function_17f9580e28cb1ba8 );
    common_item::function_84174b793b5fe9a7( "dogtag", #"hash_e2da6c78fc49f200", &function_c6ae15440fccda23 );
    common_item::function_84174b793b5fe9a7( "dogtag", #"hash_2cc40f197e06aed7", &function_4a33138b679ade68 );
    callback::add( #"hash_43fa020e1f5bd32e", &function_4d71d80d00e36e8c );
    callback::add( "lootcache_looted", &onCacheLooted );
    
    /#
        level thread debugdogtags();
    #/
}

// Namespace dmz_dog_tag
// Params 1, eflags: 0x4
// Checksum 0x719e6754, Offset: 0x887
// Size: 0x53
function private onplayerconnect( params )
{
    if ( !isdefined( level.dogtaginfo ) )
    {
        level.dogtaginfo = [];
    }
    
    self endon( #"disconnect" );
    self waittill( #"spawned_player" );
    
    if ( !self )
    {
        return;
    }
    
    self setclientomnvar( "ui_dmz_dog_tag", function_3b3e7146aa7adc8c( self ) );
}

// Namespace dmz_dog_tag
// Params 1, eflags: 0x4
// Checksum 0x961de6c1, Offset: 0x8e2
// Size: 0x24a
function private function_6dabd8def75a469a( params )
{
    for ( backpackindex = 0; backpackindex < common_inventory::function_7d8024a0beed38ae() ; backpackindex++ )
    {
        lootid = common_inventory::inventory_getlootidatbackpackindex( backpackindex );
        
        if ( !isdefined( lootid ) || lootid == 0 )
        {
            continue;
        }
        
        if ( !function_7b2fcbd8d8d2e2a3( lootid ) && !function_dd760c59915e326d( lootid ) )
        {
            continue;
        }
        
        itembundle = common_item::function_b202b16941992cca( lootid );
        
        if ( !itembundle )
        {
            continue;
        }
        
        additionaldata = common_inventory_groups::function_af51bdd9c1c5acd3( 1, backpackindex );
        
        if ( !additionaldata )
        {
            continue;
        }
        
        data = level.dogtaginfo[ additionaldata.var_80a55ae41f929b49 ];
        
        if ( !data )
        {
            continue;
        }
        
        self recorddogtag( data.victimxuid ?? "0", data.killerxuid ?? "0", data.meansofdeathint ?? 0, data.timeofdeath ?? 0, data.bountyScore ?? 0, data.operatorskinlootid ?? lootid, data.poiindex ?? 0, itembundle.var_af7e293dfbed7bd8 ?? 0 );
        
        if ( !function_dd760c59915e326d( lootid ) )
        {
            continue;
        }
        
        var_f118922d6f1d1e00 = utility::callsharedfunc( #"hash_9f74af5df376ea68", #"hash_d9367d6b9c423d16", common_item_database::function_db2360bc1c33f6f9( lootid ) );
        
        if ( !isdefined( var_f118922d6f1d1e00 ) )
        {
            continue;
        }
        
        foreach ( player in teams::getteamdata( self.team, "players" ) )
        {
            var_738643b87d9694aa = player getplayerdata( level.var_6f9b00680ed002d8, "bossBoardKills", var_f118922d6f1d1e00 );
            player setplayerdata( level.var_6f9b00680ed002d8, "bossBoardKills", var_f118922d6f1d1e00, var_738643b87d9694aa + 1 );
        }
    }
}

// Namespace dmz_dog_tag
// Params 1, eflags: 0x4
// Checksum 0xbf961d7e, Offset: 0xb34
// Size: 0x3c
function private onplayerspawn( params )
{
    if ( !params.revivespawn || !isdefined( self.dogtag ) )
    {
        return;
    }
    
    common_item::function_2b5e2ff57d5f392( self.dogtag, 0 );
}

// Namespace dmz_dog_tag
// Params 1, eflags: 0x4
// Checksum 0x1ee69592, Offset: 0xb78
// Size: 0x1ab
function private onteamchange( params )
{
    playerinfo = level.dogtaginfo[ self.guid ];
    
    if ( !isdefined( playerinfo ) )
    {
        return;
    }
    
    playerinfo.team = params.newteam;
    
    foreach ( teammember in teams::getteamdata( params.newteam, "players" ) )
    {
        for ( i = 0; i < teammember common_inventory::function_9cd65c8312048802() ; i++ )
        {
            if ( !function_7b2fcbd8d8d2e2a3( teammember common_inventory::inventory_getlootidatbackpackindex( i ) ) )
            {
                continue;
            }
            
            additionaldata = common_inventory_groups::function_af51bdd9c1c5acd3( 2, i );
            
            if ( !additionaldata )
            {
                continue;
            }
            
            data = level.dogtaginfo[ additionaldata.var_80a55ae41f929b49 ];
            
            if ( !data || data.victimteam != teammember.team )
            {
                continue;
            }
            
            teammember common_inventory::inventory_setbackpackitematindex( i, 0, 0 );
            
            if ( isdefined( data.victim ) )
            {
                function_e57e36b55e67b657( data.victim );
            }
            
            if ( data.victim != teammember )
            {
                br_gametype_dmz::showdmzsplash( "dmz_recover_dog_tag", [ teammember ] );
            }
        }
    }
}

// Namespace dmz_dog_tag
// Params 1
// Checksum 0x76a5fc8d, Offset: 0xd2b
// Size: 0x57
function function_e57e36b55e67b657( player )
{
    function_ff4a0e3c9d3674dc( player, 1 );
    
    if ( bounty_wanted::isenabled() )
    {
        bounty_wanted::function_79183cad3c7b34e5( player.var_c140cb3b186d3ae2 ?? 0 );
    }
    
    if ( !level.var_22046ec20ae0ea90 )
    {
        br_gametype_dmz::showdmzsplash( "dmz_recover_dog_tag", [ player ], undefined );
    }
}

// Namespace dmz_dog_tag
// Params 2
// Checksum 0x5bd0c23e, Offset: 0xd8a
// Size: 0x5d
function function_2adb7498fb190f( killer, var_80a55ae41f929b49 )
{
    data = level.dogtaginfo[ var_80a55ae41f929b49 ];
    
    if ( !data.playedcelebration )
    {
        data.playedcelebration = 1;
        br_gametype_dmz::showdmzsplash( "dmz_kill_confirm_dog_tag", [ killer ] );
    }
}

// Namespace dmz_dog_tag
// Params 2, eflags: 0x4
// Checksum 0x2ca15763, Offset: 0xdef
// Size: 0x66
function private function_3f23879132f430f( item, togroup )
{
    itembundle = common_item::function_6b8ff3d5f2688336( item );
    
    if ( !usedogtag( itembundle, item, undefined, undefined, 1 ) )
    {
        item.dontdrop = 1;
        return [ item, 0 ];
    }
    
    return [ item, togroup ];
}

// Namespace dmz_dog_tag
// Params 5, eflags: 0x4
// Checksum 0xa30c47f9, Offset: 0xe5d
// Size: 0x2ca
function private usedogtag( itembundle, item, autouse, var_981c264073bf1154, editonly = 0 )
{
    if ( item.var_b63192f61121f97 && bounty_wanted::isenabled() && common_instance_inventory::isenabled() )
    {
        common_instance_inventory::function_79183cad3c7b34e5();
        return 0;
    }
    
    lootid = common_item::function_779887309ec71dfe( itembundle );
    
    if ( !editonly && function_dd760c59915e326d( lootid ) )
    {
        var_73347bba95ffde1 = function_2e675cc26b8792f9( itembundle, self.origin );
        var_73347bba95ffde1.currentowner = self;
        var_73347bba95ffde1.scriptable = undefined;
        objidpoolmanager::objective_teammask_removefrommask( var_73347bba95ffde1.enemyobjid, self.team );
        objidpoolmanager::objective_teammask_single( var_73347bba95ffde1.var_59c578116594b93f, self.team );
        level notify( "dog_tag_picked_up_" + lootid, self.team );
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"hash_62df333dcc424ae4", [ self ] );
    }
    
    data = level.dogtaginfo[ item.additionaldata.var_80a55ae41f929b49 ];
    
    if ( !data )
    {
        return item.count;
    }
    
    if ( self.team == data.victimteam )
    {
        if ( !data.victim || data.victim != self )
        {
            br_gametype_dmz::showdmzsplash( "dmz_recover_dog_tag", [ self ], undefined );
        }
        
        if ( data.victim )
        {
            function_e57e36b55e67b657( data.victim );
        }
        
        return 0;
    }
    
    if ( data.killer == self )
    {
        thread function_2adb7498fb190f( self, item.additionaldata.var_80a55ae41f929b49 );
    }
    
    if ( !function_dd760c59915e326d( lootid ) && hasomnvar( "ui_bounty_wanted_collected_loot_id" ) )
    {
        self setclientomnvar( "ui_bounty_wanted_collected_loot_id", lootid );
        index = ( bounty_wanted::function_d6112fe3de4a7987( data.bountyScore ) ?? -1 ) + 1;
        entnumber = data.victim getentitynumber();
        skinlootid = 0;
        
        if ( isplayer( data.victim ) )
        {
            skinref = data.victim operator::function_cc5d60d5178c5007();
            skinlootid = loot::getlootidfromref( skinref ) ?? 0;
        }
        
        bounty_wanted::function_9134eb92130b9544( "ui_bounty_wanted_collected_", entnumber, index, skinlootid );
    }
    
    return item.count;
}

// Namespace dmz_dog_tag
// Params 5, eflags: 0x4
// Checksum 0xcb8ae604, Offset: 0x112f
// Size: 0x19e
function private function_c6ae15440fccda23( player, itembundle, item, inventorygroup, params )
{
    slot = params.index;
    
    if ( !isdefined( slot ) )
    {
        return;
    }
    
    data = item.additionaldata.var_80a55ae41f929b49 ? level.dogtaginfo[ item.additionaldata.var_80a55ae41f929b49 ] : undefined;
    player setplayerdata( level.var_6f9b00680ed002d8, "backpackDogTagInfo", slot, "victimXuid", data.victimxuid ?? "0" );
    player setplayerdata( level.var_6f9b00680ed002d8, "backpackDogTagInfo", slot, "killerXuid", data.killerxuid ?? "0" );
    player setplayerdata( level.var_6f9b00680ed002d8, "backpackDogTagInfo", slot, "meansOfDeath", data.meansofdeathint ?? 0 );
    player setplayerdata( level.var_6f9b00680ed002d8, "backpackDogTagInfo", slot, "timeOfDeath", data.timeofdeath ?? 0 );
    player setplayerdata( level.var_6f9b00680ed002d8, "backpackDogTagInfo", slot, "poiIndex", data.poiindex ?? 0 );
    player setplayerdata( level.var_6f9b00680ed002d8, "backpackDogTagInfo", slot, "bountyScore", data.bountyScore ?? 0 );
}

// Namespace dmz_dog_tag
// Params 1, eflags: 0x4
// Checksum 0xdb52eda, Offset: 0x12d5
// Size: 0x14a
function private onCacheLooted( params )
{
    if ( !params.cacheinstance.var_80a55ae41f929b49 )
    {
        return;
    }
    
    data = getdogtagdata( params.cacheinstance.var_80a55ae41f929b49 );
    
    if ( data )
    {
        self setplayerdata( level.var_6f9b00680ed002d8, "enemyPlayerDogTagInfo", "victimXuid", data.victimxuid ?? "0" );
        self setplayerdata( level.var_6f9b00680ed002d8, "enemyPlayerDogTagInfo", "killerXuid", data.killerxuid ?? "0" );
        self setplayerdata( level.var_6f9b00680ed002d8, "enemyPlayerDogTagInfo", "meansOfDeath", data.meansofdeathint ?? 0 );
        self setplayerdata( level.var_6f9b00680ed002d8, "enemyPlayerDogTagInfo", "timeOfDeath", data.timeofdeath ?? 0 );
        self setplayerdata( level.var_6f9b00680ed002d8, "enemyPlayerDogTagInfo", "poiIndex", data.poiindex ?? 0 );
        self setplayerdata( level.var_6f9b00680ed002d8, "enemyPlayerDogTagInfo", "bountyScore", data.bountyScore ?? 0 );
    }
}

// Namespace dmz_dog_tag
// Params 4, eflags: 0x4
// Checksum 0x9dc828a1, Offset: 0x1427
// Size: 0x29, Type: bool
function private function_ef411319f71e7850( itembundle, item, autouse, allowswap )
{
    return true;
}

// Namespace dmz_dog_tag
// Params 1, eflags: 0x4
// Checksum 0xd4a6d53a, Offset: 0x1459
// Size: 0x38
function private function_716a9ec0bf85a9c1( params )
{
    return { #count:hasdogtag( self ) ? 1 : 0, #name:level.var_bdb809807c06b646 };
}

// Namespace dmz_dog_tag
// Params 1, eflags: 0x4
// Checksum 0xdae3771b, Offset: 0x149a
// Size: 0x109
function private function_17f9580e28cb1ba8( itembundlename )
{
    lootid = common_item::function_b01955b20c77371d( itembundlename );
    
    if ( lootid )
    {
        if ( !level.var_634a0f2558753e30 )
        {
            level.var_bdb809807c06b646 = itembundlename;
        }
        
        dogtagbundle = common_item::function_90c3e0c1fd55d6b6( itembundlename );
        
        if ( isdefined( dogtagbundle.var_af7e293dfbed7bd8 ) && dogtagbundle.scriptable )
        {
            if ( dogtagbundle.var_af7e293dfbed7bd8 == 0 )
            {
                level.var_634a0f2558753e30 = 1;
            }
            
            if ( dogtagbundle.var_bf85a3a3f9fb5195 )
            {
                level.dogtagscriptables[ dogtagbundle.var_af7e293dfbed7bd8 ] = dogtagbundle.scriptable;
                level.var_1b4ca59164742e80[ dogtagbundle.var_af7e293dfbed7bd8 ] = lootid;
                return;
            }
            
            level.var_74325596166ce2b6[ level.var_74325596166ce2b6.size ] = dogtagbundle.scriptable;
            level.var_fe604c516960e40e[ level.var_fe604c516960e40e.size ] = lootid;
        }
    }
}

// Namespace dmz_dog_tag
// Params 1
// Checksum 0x41dd816c, Offset: 0x15ab
// Size: 0x70, Type: bool
function hasdogtag( player )
{
    if ( !function_8ee07314dbc6f4d7() )
    {
        return false;
    }
    
    if ( player br_public::isplayeringulag() )
    {
        return false;
    }
    
    if ( !isdefined( level.dogtaginfo ) )
    {
        level.dogtaginfo = [];
    }
    
    hastag = level.dogtaginfo[ player.guid ].hastag;
    return !isdefined( hastag ) || hastag;
}

// Namespace dmz_dog_tag
// Params 0
// Checksum 0x4825ff98, Offset: 0x1624
// Size: 0x2b, Type: bool
function function_8ee07314dbc6f4d7()
{
    return level.gametypebundle.dropdogtags && getdvarint( @"hash_c172182c38d61b3", 1 ) == 1;
}

// Namespace dmz_dog_tag
// Params 1
// Checksum 0xcd21286b, Offset: 0x1658
// Size: 0x66
function function_a084b2fcf3307a37( player )
{
    if ( game_utility::getgametype() != "dmz" && getdvarint( @"hash_7bea5a5cf88445dc", 0 ) )
    {
        return "brloot_dogtag";
    }
    
    tier = function_3b3e7146aa7adc8c( player );
    
    if ( isdefined( level.dogtagscriptables ) )
    {
        return level.dogtagscriptables[ tier ];
    }
    
    return "rex_loot_dogtag_steel";
}

// Namespace dmz_dog_tag
// Params 1
// Checksum 0x4821c211, Offset: 0x16c7
// Size: 0x3f
function function_d19864f8c32f315f( player )
{
    tier = function_3b3e7146aa7adc8c( player );
    
    if ( isdefined( level.var_1b4ca59164742e80 ) )
    {
        return level.var_1b4ca59164742e80[ tier ];
    }
    
    return 94773;
}

// Namespace dmz_dog_tag
// Params 1
// Checksum 0x5593a663, Offset: 0x170f
// Size: 0x87
function function_b11e1152414b6b63( lootid )
{
    foreach ( tier, taglootid in level.var_1b4ca59164742e80 )
    {
        if ( taglootid == lootid )
        {
            return tier;
        }
    }
    
    return 0;
}

// Namespace dmz_dog_tag
// Params 1
// Checksum 0x3cf7c3bf, Offset: 0x179f
// Size: 0x8f
function function_3b3e7146aa7adc8c( player )
{
    if ( !isdefined( level.dogtagscriptables ) && isdefined( level.var_1b4ca59164742e80 ) )
    {
        assertmsg( "<dev string:x24>" );
        return 0;
    }
    
    if ( !isdefined( player ) )
    {
        assertmsg( "<dev string:x56>" );
        return 0;
    }
    
    /#
        overridetier = getdvarint( @"hash_855a310cd1834a3e", -1 );
        
        if ( overridetier >= 0 )
        {
            return overridetier;
        }
    #/
    
    dogtaglootid = common_instance_inventory::function_e2bf67c04711b64f( player );
    return function_b11e1152414b6b63( dogtaglootid );
}

// Namespace dmz_dog_tag
// Params 2
// Checksum 0x9f55fa0b, Offset: 0x1837
// Size: 0x75
function function_ff4a0e3c9d3674dc( player, hastag )
{
    data = level.dogtaginfo[ player.guid ];
    
    if ( data )
    {
        data.hastag = hastag;
    }
    
    if ( hastag )
    {
        omnvarvalue = function_3b3e7146aa7adc8c( player );
    }
    else
    {
        omnvarvalue = -1;
    }
    
    player setclientomnvar( "ui_dmz_dog_tag", omnvarvalue );
}

// Namespace dmz_dog_tag
// Params 1
// Checksum 0xb842f97f, Offset: 0x18b4
// Size: 0x2f, Type: bool
function function_7b2fcbd8d8d2e2a3( lootid )
{
    return isdefined( lootid ) && isdefined( level.var_1b4ca59164742e80 ) && arraycontains( level.var_1b4ca59164742e80, lootid );
}

// Namespace dmz_dog_tag
// Params 1
// Checksum 0x63c5e73, Offset: 0x18ec
// Size: 0x2f, Type: bool
function function_dd760c59915e326d( lootid )
{
    return isdefined( lootid ) && isdefined( level.var_fe604c516960e40e ) && arraycontains( level.var_fe604c516960e40e, lootid );
}

// Namespace dmz_dog_tag
// Params 2
// Checksum 0x7ce603f0, Offset: 0x1924
// Size: 0x56, Type: bool
function function_5e8cc941466ba7e6( player, var_80a55ae41f929b49 )
{
    if ( !player.team || !level.dogtaginfo )
    {
        return false;
    }
    
    return level.dogtaginfo[ var_80a55ae41f929b49 ].victimteam == player.team;
}

// Namespace dmz_dog_tag
// Params 2
// Checksum 0x23bb5967, Offset: 0x1983
// Size: 0x4c, Type: bool
function function_40dfa7754a2416ca( killer, var_80a55ae41f929b49 )
{
    if ( !killer.guid || level.dogtaginfo )
    {
        return false;
    }
    
    return level.dogtaginfo[ var_80a55ae41f929b49 ].killer == killer;
}

// Namespace dmz_dog_tag
// Params 1
// Checksum 0x9131e1b6, Offset: 0x19d8
// Size: 0x45
function getdogtagdata( var_dfb11c726fa02ad7 )
{
    guid = isent( var_dfb11c726fa02ad7 ) ? var_dfb11c726fa02ad7.guid : var_dfb11c726fa02ad7;
    
    if ( !isdefined( guid ) )
    {
        return;
    }
    
    return level.dogtaginfo[ guid ];
}

// Namespace dmz_dog_tag
// Params 3
// Checksum 0x87c8a0b8, Offset: 0x1a26
// Size: 0x7a
function function_34d0a7ddfa21db1c( victim, killer, meansofdeath = "MOD_UNKNOWN" )
{
    if ( !isdefined( level.dogtaginfo ) )
    {
        level.dogtaginfo = [];
    }
    
    if ( isdefined( victim ) && isdefined( killer ) && ( victim == killer || !isplayer( killer ) ) )
    {
        killer = undefined;
    }
    
    if ( !hasdogtag( victim ) )
    {
        return;
    }
    
    function_6ac803eed478cacb( victim, killer, meansofdeath );
}

// Namespace dmz_dog_tag
// Params 3, eflags: 0x4
// Checksum 0xb5467a69, Offset: 0x1aa8
// Size: 0x2d7
function private function_6ac803eed478cacb( victim, killer, meansofdeath )
{
    meansofdeathint = 0;
    
    foreach ( index, array in level.dogtagmeansofdeath )
    {
        if ( arraycontains( array, meansofdeath ) )
        {
            meansofdeathint = index;
            break;
        }
    }
    
    if ( !isdefined( level.dogtaginfo[ victim.guid ] ) )
    {
        level.dogtaginfo[ victim.guid ] = { #hastag:1, #victimxuid:isplayer( victim ) ? function_fffbd405b1911268( victim getxuid() ) : undefined, #victimguid:victim.guid, #victim:victim };
    }
    
    level.dogtaginfo[ victim.guid ].killer = killer;
    level.dogtaginfo[ victim.guid ].killerxuid = isplayer( killer ) ? function_fffbd405b1911268( killer getxuid() ) : undefined;
    level.dogtaginfo[ victim.guid ].victimteam = victim.team;
    level.dogtaginfo[ victim.guid ].meansofdeathint = meansofdeathint;
    level.dogtaginfo[ victim.guid ].timeofdeath = getsystemtime();
    level.dogtaginfo[ victim.guid ].poiindex = utility::callsharedfunc( #"poi", #"hash_cd2758a499bb6be4", utility::callsharedfunc( #"poi", #"hash_79b3b95992c86428", victim.origin ) );
    level.dogtaginfo[ victim.guid ].operatorskinlootid = victim.operatorcustomization.skinlootid;
    level.dogtaginfo[ victim.guid ].bountyScore = int( min( victim.bountyScore ?? 0, 255 ) );
    level.dogtaginfo[ victim.guid ].playedcelebration = 0;
}

// Namespace dmz_dog_tag
// Params 0
// Checksum 0xa89fb6ac, Offset: 0x1d87
// Size: 0x7d
function function_3dbdce08c63b95aa()
{
    var_f6d9ea6e3c1cb794 = 0;
    var_eabf8f96f9eb1901 = 0;
    
    for ( i = 0; i < common_inventory::function_9cd65c8312048802() ; i++ )
    {
        lootid = common_inventory::inventory_getlootidatbackpackindex( i );
        
        if ( function_7b2fcbd8d8d2e2a3( lootid ) )
        {
            var_f6d9ea6e3c1cb794 += 1;
            continue;
        }
        
        if ( function_dd760c59915e326d( lootid ) )
        {
            var_eabf8f96f9eb1901 += 1;
        }
    }
    
    return [ var_f6d9ea6e3c1cb794, var_eabf8f96f9eb1901 ];
}

// Namespace dmz_dog_tag
// Params 4, eflags: 0x4
// Checksum 0x62facc77, Offset: 0x1e0d
// Size: 0xe5
function private function_4a33138b679ade68( scriptable, count, positioningdata, spawnoptions )
{
    dogtag = spawnscriptable( scriptable, positioningdata.finalorigin, positioningdata.finalangles, undefined, positioningdata.payload, spawnoptions.payload );
    itemspawnentry = common_item::function_80af1e9daffacc7d( scriptable );
    
    if ( function_dd760c59915e326d( common_item::function_779887309ec71dfe( itemspawnentry ) ) )
    {
        data = function_2e675cc26b8792f9( itemspawnentry, positioningdata.finalorigin );
        data.currentowner = undefined;
        data.scriptable = dogtag;
        objidpoolmanager::function_6bc07fb92848feab( data.enemyobjid );
        objidpoolmanager::function_7736d86e518e223( data.var_59c578116594b93f );
    }
    
    return dogtag;
}

// Namespace dmz_dog_tag
// Params 1, eflags: 0x4
// Checksum 0x8364e298, Offset: 0x1efb
// Size: 0x4b
function private function_73347bba95ffde1( ref )
{
    if ( !isdefined( level.var_65c55ffe758f0ec ) )
    {
        level.var_65c55ffe758f0ec = [];
    }
    
    if ( !isdefined( level.var_65c55ffe758f0ec[ ref ] ) )
    {
        level.var_65c55ffe758f0ec[ ref ] = {};
    }
    
    return level.var_65c55ffe758f0ec[ ref ];
}

// Namespace dmz_dog_tag
// Params 1, eflags: 0x4
// Checksum 0xc6d6200f, Offset: 0x1f4f
// Size: 0x36, Type: bool
function private function_984e62dcdaea8f81( ref )
{
    objid = function_73347bba95ffde1( ref ).enemyobjid;
    return isdefined( objid ) && objid != -1;
}

// Namespace dmz_dog_tag
// Params 2, eflags: 0x4
// Checksum 0x5406b158, Offset: 0x1f8e
// Size: 0x1df
function private function_2e675cc26b8792f9( itemspawnentry, origin )
{
    var_73347bba95ffde1 = function_73347bba95ffde1( itemspawnentry.ref );
    
    if ( function_984e62dcdaea8f81( itemspawnentry.ref ) )
    {
        return var_73347bba95ffde1;
    }
    
    enemyobjid = objidpoolmanager::requestobjectiveid( 99 );
    var_59c578116594b93f = objidpoolmanager::requestobjectiveid( 99 );
    
    if ( enemyobjid == -1 || var_59c578116594b93f == -1 )
    {
        return var_73347bba95ffde1;
    }
    
    var_73347bba95ffde1.enemyobjid = enemyobjid;
    var_73347bba95ffde1.var_59c578116594b93f = var_59c578116594b93f;
    
    foreach ( objid in [ enemyobjid, var_59c578116594b93f ] )
    {
        objective_setlabel( objid, itemspawnentry.titlestring );
        objective_setpings( objid, 1 );
        objective_setzoffset( objid, ( 0, 0, 40 )[ 2 ] );
        objective_icon( objid, "ui_rex_hud_icon_dogtag_case" );
        function_3759e26b1b750f5( objid, function_c182766395482505() );
        objective_setbackground( objid, 1 );
        objective_position( objid, origin );
        objective_setownerteam( objid, undefined );
        objective_setprogressteam( objid, undefined );
        objective_setfadedisabled( objid, 0 );
        function_ac9886e0e2860e18( objid, 50000, 55000 );
        objective_disableping( objid, 0 );
        objidpoolmanager::update_objective_objectiveid( objid, 16 );
        objective_setplayintro( objid, 0 );
    }
    
    objective_state( enemyobjid, "current" );
    objective_state( var_59c578116594b93f, "active" );
    objidpoolmanager::function_6bc07fb92848feab( enemyobjid );
    objidpoolmanager::function_7736d86e518e223( var_59c578116594b93f );
    level thread function_c78de4d560332e0( itemspawnentry );
    return var_73347bba95ffde1;
}

// Namespace dmz_dog_tag
// Params 1, eflags: 0x4
// Checksum 0xbff295b4, Offset: 0x2176
// Size: 0x18a
function private function_c78de4d560332e0( itemspawnentry )
{
    level endon( #"game_ended" );
    level endon( itemspawnentry.ref + "_extracted" );
    waittillframeend();
    data = function_73347bba95ffde1( itemspawnentry.ref );
    
    while ( true )
    {
        if ( isdefined( data.currentowner ) )
        {
            objective_position( data.enemyobjid, data.currentowner.origin + ( 0, 0, 35 ) );
            objective_position( data.var_59c578116594b93f, data.currentowner.origin + ( 0, 0, 35 ) );
        }
        else if ( isdefined( data.scriptable ) )
        {
            objective_position( data.enemyobjid, data.scriptable.origin );
            objective_position( data.var_59c578116594b93f, data.scriptable.origin );
        }
        else
        {
            objidpoolmanager::returnobjectiveid( data.enemyobjid );
            objidpoolmanager::returnobjectiveid( data.var_59c578116594b93f );
            data.enemyobjid = -1;
            data.var_59c578116594b93f = -1;
            return;
        }
        
        objective_ping( data.enemyobjid );
        objective_ping( data.var_59c578116594b93f );
        wait 5;
    }
}

// Namespace dmz_dog_tag
// Params 1, eflags: 0x4
// Checksum 0x2f008a9f, Offset: 0x2308
// Size: 0xf0
function private function_4d71d80d00e36e8c( params )
{
    if ( !isdefined( params.lootid ) || params.lootid == 0 )
    {
        return;
    }
    
    if ( !isdefined( params.quantity ) || params.quantity == 0 )
    {
        return;
    }
    
    if ( !function_dd760c59915e326d( params.lootid ) )
    {
        return;
    }
    
    itemspawnentry = common_item::function_b202b16941992cca( params.lootid );
    data = function_2e675cc26b8792f9( itemspawnentry, params.cache.origin );
    data.currentowner = undefined;
    data.scriptable = params.cache;
    objidpoolmanager::function_6bc07fb92848feab( data.enemyobjid );
    objidpoolmanager::function_7736d86e518e223( data.var_59c578116594b93f );
}

/#

    // Namespace dmz_dog_tag
    // Params 0
    // Checksum 0x3a48e7fd, Offset: 0x2400
    // Size: 0x2ee, Type: dev
    function debugdogtags()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_b044a50f64f8d1f4", 0 ) )
            {
                setdvar( @"hash_b044a50f64f8d1f4", 0 );
                dogtags = getentitylessscriptablearray( "<dev string:x92>" );
                
                if ( dogtags.size )
                {
                    dogtag = dogtags[ 0 ];
                    bot = undefined;
                    
                    foreach ( player in level.players )
                    {
                        if ( isbot( player ) && player::isreallyalive( player ) )
                        {
                            bot = player;
                            break;
                        }
                    }
                    
                    bot common_item::function_96119bed8ab4c5d9( dogtag, 0 );
                }
            }
            
            if ( getdvarint( @"hash_db9e3d9e8570dfb3", 0 ) )
            {
                setdvar( @"hash_db9e3d9e8570dfb3", 0 );
                enemybot = undefined;
                
                foreach ( player in level.players )
                {
                    if ( isbot( player ) && isalive( player ) && player.team != level.players[ 0 ].team )
                    {
                        enemybot = player;
                        break;
                    }
                }
                
                friendlybot = undefined;
                
                foreach ( player in level.players )
                {
                    if ( isbot( player ) && isalive( player ) && player.health > 50 && player.team == level.players[ 0 ].team )
                    {
                        friendlybot = player;
                        break;
                    }
                }
                
                friendlybot dodamage( 10000, enemybot.origin, enemybot, enemybot );
                wait 3;
                friendlybot dodamage( 10000, enemybot.origin, enemybot, enemybot );
            }
            
            if ( getdvarint( @"hash_c6dd0ae8694d585b", 0 ) == 1 )
            {
                setdvar( @"hash_c6dd0ae8694d585b", 0 );
                gamelogic_mp::gethostplayer() function_6dabd8def75a469a();
            }
            
            waitframe();
        }
    }

#/
