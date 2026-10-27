// scripts\mp\br\gametypes\br_common_kiosk.gsc  (hash_354b7d73ef5d4ead.gscc) (size: 19120 Bytes / 0x4ab0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3573da48 (896784968)
// size ...... 19120 (0x4ab0)
// includes .. 29  (offset: 0x4634)
// strings ... 63  (offset: 0x471c)
// dev strs .. 1   (offset: 0x4aa0)
// exports ... 43  (offset: 0x2d78)
// cseg ...... 0x5bd + 0x27bb (0x2d78)
// imports ... 150 (offset: 0x3430)
// animtree1 . 0   (offset: 0x4ab0)
// animtree2 . 0   (offset: 0x4ab0)
#using scripts\common\callbacks;
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_exclusion_zone;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\br\gametypes\br_quest_util;
#using scripts\mp\class;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\rejoin_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\currency;
#using scripts\mp\deathicons;
#using scripts\mp\flags;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\loot\common_kiosk;
#using scripts\mp\menus;

#namespace br_common_kiosk;

// Namespace br_common_kiosk
// Params 0
// Checksum 0x16d45230, Offset: 0x5db
// Size: 0x33a
function init()
{
    level.var_797b14a7ea4df55 = spawnstruct();
    level.var_797b14a7ea4df55.var_889dd52e0880f1d1 = getdvarint( @"hash_c1aa68b2429a9d1", 0 );
    level.var_797b14a7ea4df55.var_2216bbfb36d9b1e6 = getdvarint( @"hash_686f2ecd7659d9c", 1574 );
    level.var_797b14a7ea4df55.var_92537005e91d2306 = getdvarfloat( @"hash_2f35d81a913072d9", 0.5 );
    level.var_797b14a7ea4df55.var_e79f29e37e22951b = getdvarint( @"hash_79607e773021b145", 1 ) == 1;
    level.var_797b14a7ea4df55.var_e253c9f921155d75 = getdvarint( @"hash_95d75e4aac93c20d", 1 );
    level.var_797b14a7ea4df55.var_dc658b74c2d08d33 = getdvarint( @"hash_65dde558b4cae454", 6 );
    var_21c5ca8c5426e6bd = getmatchrulesdata( "brData", "fireSaleFreeItems" );
    
    if ( var_21c5ca8c5426e6bd )
    {
        level.var_797b14a7ea4df55.fireSaleFreeItems = strtok( var_21c5ca8c5426e6bd, "|" );
    }
    
    level.var_15b5fff339fcb92 = spawnstruct();
    level.var_15b5fff339fcb92.var_5657dbfb2cbc2972 = getdvarint( @"hash_2c643d66272c8220", 0 );
    level.var_15b5fff339fcb92.reductionamount = getdvarint( @"hash_3e96eb6030c0338f", 100 );
    level.var_15b5fff339fcb92.minimumprice = getdvarint( @"hash_874167279e21b729", 600 );
    callbacks = spawnstruct();
    callbacks.var_a417fc940cd953b9 = &function_a417fc940cd953b9;
    callbacks.firesaleactiveforplayer = &iskioskfiresaleactiveforplayer;
    callbacks.var_ecd93599094b26cd = &function_a8f6845122d0bf42;
    callbacks.var_5a140345b0fdc9ad = &br_team_revive_purchase;
    callbacks.var_31c4496a390b83dc = &br_team_revive_all_purchase;
    callbacks.purchaseloadout = &function_381afa34f0722539;
    callbacks.var_92ac319b7cccf588 = &function_92ac319b7cccf588;
    callbacks.var_8c37d124818e1233 = &function_8c37d124818e1233;
    callbacks.var_508a9518dc74e748 = &function_508a9518dc74e748;
    callbacks.var_8c5111eb81abe768 = &function_8c5111eb81abe768;
    
    if ( level.var_e298f874f79103ed )
    {
        callbacks.var_ea56078d44169b8 = &function_ea56078d44169b8;
        callbacks.onarmorykioskpurchase = &onarmorykioskpurchase;
        callbacks.var_52f28106b1df1c8 = &function_52f28106b1df1c8;
    }
    
    if ( level.var_797b14a7ea4df55.var_e253c9f921155d75 )
    {
        thread function_8ae7ed90d4548da8();
        common_kiosk::function_ea4e5fb141e28d6e( &function_9e17359c911e5a7d );
    }
    
    common_kiosk::br_kiosk_init( callbacks );
    callback::add( #"hash_440e335c78393d75", &function_1f90de01dd0181a0 );
    callback::add( #"hash_8daeabb90e45c6bc", &onkioskpurchase );
    br_circle::registercirclecallbacks( 4, &dangercircletick, &dangermulticircletick, &common_kiosk::function_50a87808f478947f, &function_95f13d141203a55b );
    callback::add( #"hash_dd36ab548337dd9a", &function_6aad9548db64d4a4 );
    
    if ( getdvarint( @"hash_ad4aed3730427bc5", 1 ) )
    {
        level thread function_fd9b4fce6e78327a();
    }
}

// Namespace br_common_kiosk
// Params 1
// Checksum 0x9a83f059, Offset: 0x91d
// Size: 0xb0, Type: bool
function function_1f90de01dd0181a0( params )
{
    if ( params.itemdata )
    {
        bundlename = function_ad2a5237ae8ed35e( params.itemdata.ref );
        
        if ( !isdefined( bundlename ) )
        {
            return true;
        }
        
        subtype = getscriptbundlefieldvalue( bundlename, #"subtype" );
        
        if ( getdvarint( @"hash_eeddb17634c70443", 1 ) && subtype == "field_guide" )
        {
            return !isdefined( params.player.perks[ params.itemdata.ref ] );
        }
    }
    
    return true;
}

// Namespace br_common_kiosk
// Params 0
// Checksum 0x98e1f039, Offset: 0x9d6
// Size: 0xe0
function function_8ae7ed90d4548da8()
{
    while ( !utility::flag( "buy_stations_spawned" ) )
    {
        waitframe();
    }
    
    foreach ( kiosk in getentitylessscriptablearray( undefined, undefined, undefined, undefined, "br_plunder_box" ) )
    {
        if ( !kiosk.var_94dbe7695ac27ed7 )
        {
            utility::callsharedfunc( #"emp", #"hash_71bd51894f6f9085", kiosk, &kioskemp, &function_f22f68c3d39c5bf2 );
            
            if ( level.var_36218e71baa7e689 )
            {
                level.var_89fe7f9fa2bc945d[ level.var_89fe7f9fa2bc945d.size ] = kiosk;
            }
        }
    }
}

// Namespace br_common_kiosk
// Params 2
// Checksum 0x7880b13, Offset: 0xabe
// Size: 0x6c
function function_9e17359c911e5a7d( scriptable, instance )
{
    if ( !scriptable.var_94dbe7695ac27ed7 )
    {
        utility::callsharedfunc( #"emp", #"hash_71bd51894f6f9085", scriptable, &kioskemp, &function_f22f68c3d39c5bf2 );
        
        if ( level.var_36218e71baa7e689 )
        {
            level.var_89fe7f9fa2bc945d[ level.var_89fe7f9fa2bc945d.size ] = scriptable;
        }
    }
}

// Namespace br_common_kiosk
// Params 2, eflags: 0x4
// Checksum 0x2d0b6b44, Offset: 0xb32
// Size: 0xa4
function private iskioskfiresaleactiveforplayer( kiosk, player )
{
    if ( !isdefined( kiosk ) && !level.var_e298f874f79103ed )
    {
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
    
    if ( level.var_797b14a7ea4df55.global_firesale_active )
    {
        return 1;
    }
    
    if ( !isdefined( kiosk.firesaleforplayers ) )
    {
        return 0;
    }
    
    return arraycontains( kiosk.firesaleforplayers, player );
}

// Namespace br_common_kiosk
// Params 2, eflags: 0x4
// Checksum 0xa270405d, Offset: 0xbdf
// Size: 0x38
function private function_a8f6845122d0bf42( kiosk, player )
{
    if ( !isdefined( kiosk.firesaleforplayers ) )
    {
        return 0;
    }
    
    return arraycontains( kiosk.firesaleforplayers, player );
}

// Namespace br_common_kiosk
// Params 0, eflags: 0x4
// Checksum 0x6053ce8e, Offset: 0xc20
// Size: 0x18, Type: bool
function private function_dae8e9cc3954591b()
{
    if ( br_publicevents::ispubliceventoftypeactive( %"firesale" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace br_common_kiosk
// Params 3, eflags: 0x4
// Checksum 0xabd1a6e0, Offset: 0xc41
// Size: 0x43
function private function_b5dc890b15588d42( kiosk, player, time )
{
    level endon( #"game_ended" );
    wait time;
    
    if ( isdefined( kiosk ) && isdefined( player ) )
    {
        kioskfiresaledoneforplayer( kiosk, player );
    }
}

// Namespace br_common_kiosk
// Params 2
// Checksum 0x8e6f3952, Offset: 0xc8c
// Size: 0x87
function kioskfiresaledoneforplayer( kiosk, player )
{
    if ( !( isdefined( kiosk ) && isdefined( kiosk.firesaleforplayers ) ) )
    {
        return;
    }
    
    if ( kiosk br_contract_manager::checkforactiveobjicon() )
    {
        kiosk br_contract_manager::hidequestobjiconfromplayer( player );
    }
    
    kiosk.firesaleforplayers = arrayremove( kiosk.firesaleforplayers, player );
    function_a81ff2dd91265e8( player, "reward" );
    
    if ( !function_a8f6845122d0bf42( kiosk, player ) )
    {
        player setclientomnvar( "ui_br_kiosk_hide_discount", 1 );
    }
}

// Namespace br_common_kiosk
// Params 3
// Checksum 0xe1675c3f, Offset: 0xd1b
// Size: 0x100
function kiosksetupfiresaleforplayer( kiosk, player, duration )
{
    if ( !isdefined( kiosk.firesaleforplayers ) )
    {
        kiosk.firesaleforplayers = [ player ];
    }
    else if ( !arraycontains( kiosk.firesaleforplayers, player ) )
    {
        kiosk.firesaleforplayers[ kiosk.firesaleforplayers.size ] = player;
    }
    
    if ( kiosk == player.common_kiosk )
    {
        function_8c37d124818e1233( player, "reward" );
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
    
    if ( isdefined( duration ) )
    {
        level thread function_b5dc890b15588d42( kiosk, player, duration );
    }
}

// Namespace br_common_kiosk
// Params 0, eflags: 0x4
// Checksum 0x7a7b7e08, Offset: 0xe23
// Size: 0x41
function private function_9be5a88e2e243822()
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

// Namespace br_common_kiosk
// Params 6
// Checksum 0x24e41c81, Offset: 0xe6c
// Size: 0x1d0
function br_team_revive_all_purchase( purchaseindex, kiosk, var_910cd58b1d8df9a0, var_a1c1cc5cf66f2de9, getactualcost, var_75dbb34857ca590b )
{
    player = self;
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    var_910cd58b1d8df9a0 = &function_c4500ff06a1d8cba;
    squad = teams::getteamdata( player.team, "players" );
    
    if ( getdvarint( @"hash_f4b944678a499f15", 1 ) )
    {
        squad = arraysort( squad, undefined, &function_a69c9fd263e17596 );
    }
    else if ( getdvarint( @"hash_1a17e986e6dac5c8", 0 ) )
    {
        squad = arraysort( squad, undefined, &is_player_dead_longer );
    }
    
    foreach ( squadmate in squad )
    {
        if ( !isdefined( squadmate ) || !isdefined( squadmate.sessionuimemberindex ) || squadmate == player )
        {
            continue;
        }
        
        if ( squadmate rejoin_utility::function_e421863f0f4de34() )
        {
            continue;
        }
        
        purchaseindex = squadmate.sessionuimemberindex + 1;
        profilestart();
        ret = player br_team_revive_purchase( purchaseindex, kiosk, var_910cd58b1d8df9a0, var_a1c1cc5cf66f2de9, getactualcost, var_75dbb34857ca590b, "teammate_buyback_all" );
        profilestop();
        
        if ( ret == 3 )
        {
            break;
        }
        
        if ( !isdefined( ret ) && level.var_797b14a7ea4df55.var_92537005e91d2306 > 0 )
        {
            wait level.var_797b14a7ea4df55.var_92537005e91d2306;
        }
    }
}

// Namespace br_common_kiosk
// Params 2
// Checksum 0xfb8d5635, Offset: 0x1044
// Size: 0x2c, Type: bool
function is_player_dead_longer( lhs, rhs )
{
    return lhs.deathtime < rhs.deathtime;
}

// Namespace br_common_kiosk
// Params 2
// Checksum 0x7305bc33, Offset: 0x1079
// Size: 0x51, Type: bool
function function_a69c9fd263e17596( lhs, rhs )
{
    var_dff9b0e7196aa73d = lhs currency::get_currency_amount( "cash" ) ?? 0;
    var_cd626b2a059e04da = rhs currency::get_currency_amount( "cash" ) ?? 0;
    return var_dff9b0e7196aa73d > var_cd626b2a059e04da;
}

// Namespace br_common_kiosk
// Params 1
// Checksum 0xc6330c3f, Offset: 0x10d3
// Size: 0xc
function function_c4500ff06a1d8cba( msg )
{
    
}

// Namespace br_common_kiosk
// Params 7
// Checksum 0xe16b9dd9, Offset: 0x10e7
// Size: 0x6d5
function br_team_revive_purchase( purchaseindex, kiosk, var_910cd58b1d8df9a0, var_a1c1cc5cf66f2de9, getactualcost, var_75dbb34857ca590b, var_42fe8032be1b902e )
{
    player = self;
    squadmatesquadindex = purchaseindex - 1;
    var_6355b03aa74e720b = player currency::get_currency_amount( "cash" );
    
    if ( getdvarint( @"hash_ece0c71aa9d5c939", 0 ) )
    {
        logstring( "[ WHY_NO_BUYBACK TEST] buyback from - " + player.name + " for squadmateSquadIndex = " + squadmatesquadindex );
    }
    
    targetsquadmate = undefined;
    squad = teams::getteamdata( player.team, "players" );
    
    foreach ( squadmate in squad )
    {
        if ( !isdefined( squadmate ) || squadmate == player )
        {
            continue;
        }
        
        if ( squadmate.sessionuimemberindex == squadmatesquadindex )
        {
            if ( getdvarint( @"hash_ece0c71aa9d5c939", 0 ) )
            {
                logstring( "[ WHY_NO_BUYBACK TEST] buyback player - " + squadmate.name + ", sessionuimemberindex = " + squadmate.sessionuimemberindex );
            }
            
            targetsquadmate = squadmate;
            break;
        }
    }
    
    if ( !isdefined( targetsquadmate ) )
    {
        player [[ var_910cd58b1d8df9a0 ]]( 12 );
        return 12;
    }
    
    var_721831e1b32baf68 = [[ var_a1c1cc5cf66f2de9 ]]( "teamrevive" );
    
    if ( isbot( targetsquadmate ) )
    {
        var_721831e1b32baf68 = structcopy( var_721831e1b32baf68 );
        var_721831e1b32baf68.revivedteammate = targetsquadmate;
    }
    
    var_af28b9556aaeceeb = [[ getactualcost ]]( player, var_721831e1b32baf68 );
    var_cd9290c5d6b11dec = level.var_797b14a7ea4df55.var_889dd52e0880f1d1 && !br_gametypes::isfeaturedisabled( #"hash_856067c342f8f1a5" );
    usetoken = player.hasrespawntoken && var_cd9290c5d6b11dec && var_6355b03aa74e720b < var_af28b9556aaeceeb;
    
    if ( !usetoken && var_6355b03aa74e720b < var_af28b9556aaeceeb )
    {
        player [[ var_910cd58b1d8df9a0 ]]( 3 );
        return 3;
    }
    
    if ( !targetsquadmate br_public::iseligibleforteamrevive() && !getdvarint( @"hash_4d250e4873e1753e", 0 ) )
    {
        if ( br_public::isrespawningfromtoken( targetsquadmate ) )
        {
            player [[ var_910cd58b1d8df9a0 ]]( 14 );
            return 14;
        }
        else if ( player::isreallyalive( targetsquadmate ) )
        {
            player [[ var_910cd58b1d8df9a0 ]]( 15 );
            return 15;
        }
        else
        {
            player [[ var_910cd58b1d8df9a0 ]]( 13 );
            return 13;
        }
    }
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
    {
        if ( isdefined( player.leaderboarddata[ "kioskRevives" ] ) )
        {
            player.leaderboarddata[ "kioskRevives" ] = player.leaderboarddata[ "kioskRevives" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "kioskRevives" ] ) )
        {
            [[ level.leaderboardfunc[ "kioskRevives" ] ]]( player, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
        
        if ( isdefined( player.pers[ "kioskRevives" ] ) )
        {
            player.pers[ "kioskRevives" ] = player.pers[ "kioskRevives" ] + 1;
        }
    }
    
    player.endmatchstats[ "kioskRevives" ] = ( player.endmatchstats[ "kioskRevives" ] ?? 0 ) + 1;
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( targetsquadmate ) ) )
    {
        if ( isdefined( targetsquadmate.leaderboarddata[ "revivedFromKiosk" ] ) )
        {
            targetsquadmate.leaderboarddata[ "revivedFromKiosk" ] = targetsquadmate.leaderboarddata[ "revivedFromKiosk" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "revivedFromKiosk" ] ) )
        {
            [[ level.leaderboardfunc[ "revivedFromKiosk" ] ]]( targetsquadmate, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
        
        if ( isdefined( targetsquadmate.pers[ "revivedFromKiosk" ] ) )
        {
            targetsquadmate.pers[ "revivedFromKiosk" ] = targetsquadmate.pers[ "revivedFromKiosk" ] + 1;
        }
    }
    
    targetsquadmate.endmatchstats[ "revivedFromKiosk" ] = ( targetsquadmate.endmatchstats[ "revivedFromKiosk" ] ?? 0 ) + 1;
    lootid = isdefined( var_42fe8032be1b902e ) ? 999999 : 999998;
    typestring = var_42fe8032be1b902e ?? "teammate_buyback";
    player common_item::items_analytics( undefined, undefined, undefined, lootid, undefined, typestring, undefined, undefined, typestring, player.origin, 1, var_af28b9556aaeceeb );
    params = spawnstruct();
    params.player = player;
    params.cost = var_af28b9556aaeceeb;
    params.itemdata = var_721831e1b32baf68;
    params.kiosk = kiosk;
    player callback::callback( #"hash_906ce08d1b0ca8ce", params );
    
    if ( !usetoken )
    {
        [[ var_75dbb34857ca590b ]]( player, var_721831e1b32baf68, "teamrevive" );
    }
    else
    {
        var_269da547f8c75e4f = spawnstruct();
        var_269da547f8c75e4f.cost = 0;
        var_269da547f8c75e4f.firesalediscount = 0;
        [[ var_75dbb34857ca590b ]]( player, var_269da547f8c75e4f, "teamrevive" );
    }
    
    onkioskpurchase( { #itemdata:var_721831e1b32baf68, #kiosk:kiosk, #player:player } );
    
    if ( utility::issharedfuncdefined( #"gametype", #"kioskreviveplayer" ) )
    {
        targetsquadmate thread utility::callsharedfunc( #"gametype", #"kioskreviveplayer", player, usetoken );
    }
    else
    {
        targetsquadmate thread br_gulag::playergulagautowin( "kioskRevivePlayer", player, usetoken, 1 );
    }
    
    flareoverride = getdvar( @"hash_58d8dfa7b8338078", "" );
    
    if ( isdefined( kiosk ) )
    {
        if ( flareoverride != "" )
        {
            level thread br_contract_manager::utilflare_shootflare( kiosk.origin, flareoverride );
        }
        else
        {
            level thread br_contract_manager::utilflare_shootflare( kiosk.origin, "revive" );
        }
    }
    
    player thread hud_message::showsplash( "br_squadmate_revived" );
    
    if ( isdefined( targetsquadmate.lastdeathpos ) && level.var_797b14a7ea4df55.var_e79f29e37e22951b )
    {
        thread deathicons::function_50307255623796cc( targetsquadmate );
    }
}

// Namespace br_common_kiosk
// Params 1, eflags: 0x4
// Checksum 0xc512ae45, Offset: 0x17c4
// Size: 0x12
function private function_72b8d636fcc1022e( token )
{
    return int( token );
}

// Namespace br_common_kiosk
// Params 0, eflags: 0x4
// Checksum 0x572fed3f, Offset: 0x17df
// Size: 0x62
function private function_5a035dfbd14fd754()
{
    if ( isdefined( level.var_797b14a7ea4df55.var_c69519a7e47a9abd ) )
    {
        return;
    }
    
    var_c69519a7e47a9abd = getdvar( @"scr_br_kiosk_loadout_primary_weapon_cost", "250" );
    level.var_797b14a7ea4df55.var_c69519a7e47a9abd = utility::array_map( strtok( var_c69519a7e47a9abd, "," ), &function_72b8d636fcc1022e );
}

// Namespace br_common_kiosk
// Params 2, eflags: 0x4
// Checksum 0x507772ff, Offset: 0x1849
// Size: 0x15e
function private function_4bafbae09b3aea7a( weaponobj, attachmentrefs )
{
    function_5a035dfbd14fd754();
    itemdata = spawnstruct();
    itemdata.ref = "loadout_primary";
    itemdata.entryref = "loadoutPrimary";
    itemdata.type = "loadout";
    itemdata.firesalediscount = getdvarint( @"hash_c9fafe5f24ced86", 50 );
    attachmentcount = function_2d04c21246a0442a( weaponobj );
    weaponcost = level.var_797b14a7ea4df55.var_c69519a7e47a9abd[ 0 ];
    attachmentcost = attachmentcount > 0 && isdefined( level.var_797b14a7ea4df55.var_c69519a7e47a9abd[ attachmentcount ] ) ? level.var_797b14a7ea4df55.var_c69519a7e47a9abd[ attachmentcount ] : 0;
    
    if ( level.var_797b14a7ea4df55.var_c69519a7e47a9abd && !isdefined( level.var_797b14a7ea4df55.var_c69519a7e47a9abd[ attachmentcount ] ) )
    {
        script::demoforcesre( "Weapon: " + getxhashhexname( weaponobj.basename ) + " has attachment count: " + attachmentcount + " which is not listed in loadoutPrimaryWeaponCost." );
    }
    
    itemdata.cost = weaponcost + attachmentcost;
    return itemdata;
}

// Namespace br_common_kiosk
// Params 6
// Checksum 0x2ce2aa6f, Offset: 0x19b0
// Size: 0x37e
function function_381afa34f0722539( loadoutindex, kiosk, var_910cd58b1d8df9a0, var_a1c1cc5cf66f2de9, getactualcost, var_75dbb34857ca590b )
{
    player = self;
    
    if ( getdvarint( @"hash_e10d9168500bd034", 0 ) )
    {
        defaultloadout = menus::isloadoutindexdefault( loadoutindex );
        loadoutitemdata = defaultloadout ? [[ var_a1c1cc5cf66f2de9 ]]( "loadout_default" ) : [[ var_a1c1cc5cf66f2de9 ]]( "loadout_custom" );
        assert( isdefined( loadoutitemdata ) );
        var_df4e60b1510caced = [[ getactualcost ]]( player, loadoutitemdata );
        
        if ( player currency::get_currency_amount( "cash" ) < var_df4e60b1510caced )
        {
            player [[ var_910cd58b1d8df9a0 ]]( 3 );
            return;
        }
        
        newclasschoice = menus::getclasschoice( loadoutindex );
        player.pers[ "class" ] = newclasschoice;
        player.class = newclasschoice;
        newclassdata = player class::preloadandqueueclass( newclasschoice );
        droploadout = getdvarint( @"hash_8c9c23ffa66bc8b8", 1 );
        dropbehind = getdvarint( @"hash_d292455426d573d3", 1 );
        br_analytics::branalytics_inventory_snapshot( player, "purchasing_new_loadout" );
        br::br_giveselectedclass( player, droploadout, dropbehind );
        params = spawnstruct();
        params.player = player;
        params.cost = var_df4e60b1510caced;
        params.itemdata = loadoutitemdata;
        params.kiosk = kiosk;
        player callback::callback( #"hash_ccb2ffae1085d28f", params );
        onkioskpurchase( { #kiosk:kiosk, #player:player } );
        [[ var_75dbb34857ca590b ]]( player, loadoutitemdata, "loadout" );
        
        if ( defaultloadout )
        {
            br_analytics::branalytics_kiosk_purchaseitem( player, var_df4e60b1510caced, "defaultLoadout", "loadout_" + loadoutindex );
        }
        else
        {
            br_analytics::branalytics_kiosk_purchaseloadout( player, var_df4e60b1510caced, newclassdata );
        }
        
        return;
    }
    
    classchoice = menus::getclasschoice( loadoutindex );
    classstruct = class::loadout_getorbuildclassstruct( classchoice );
    assert( isdefined( classstruct ) );
    
    if ( !( isdefined( classstruct.loadoutprimary ) && isdefined( classstruct.loadoutprimaryattachments ) && isdefined( classstruct.loadoutprimaryobject ) && isdefined( classstruct.loadoutprimaryfullname ) ) )
    {
        player [[ var_910cd58b1d8df9a0 ]]( 2 );
        return;
    }
    
    var_65a2b8a39c214fef = function_4bafbae09b3aea7a( classstruct.loadoutprimaryobject, classstruct.loadoutprimaryattachments );
    var_df4e60b1510caced = [[ getactualcost ]]( player, var_65a2b8a39c214fef );
    
    if ( player currency::get_currency_amount( "cash" ) < var_df4e60b1510caced )
    {
        player [[ var_910cd58b1d8df9a0 ]]( 3 );
        return;
    }
    
    if ( item_weapon::function_ec55b6cd928fb1a6( player, classstruct.loadoutprimaryobject ) )
    {
        params = spawnstruct();
        params.player = player;
        params.cost = var_df4e60b1510caced;
        params.itemdata = var_65a2b8a39c214fef;
        params.kiosk = kiosk;
        player callback::callback( #"hash_8c05ac10cfd33502", params );
        onkioskpurchase( { #kiosk:kiosk, #player:player } );
        [[ var_75dbb34857ca590b ]]( player, var_65a2b8a39c214fef, var_65a2b8a39c214fef.type );
        br_analytics::function_a08ffb4d30d1778c( player, var_df4e60b1510caced, classstruct.loadoutprimary, classstruct.loadoutprimaryattachments );
    }
}

// Namespace br_common_kiosk
// Params 0
// Checksum 0x93775ba3, Offset: 0x1d36
// Size: 0x3e
function function_a417fc940cd953b9()
{
    var_2dafc86aeb2199fd = getmatchrulesdata( "commonOption", "buyStationPool" );
    potentialbuystations = utility::function_49a778e73bbb0f58( @"scr_buy_station_pool", "", var_2dafc86aeb2199fd );
    return potentialbuystations;
}

// Namespace br_common_kiosk
// Params 3
// Checksum 0x9a0c04d5, Offset: 0x1d7d
// Size: 0x1d7
function dangercircletick( dangercircleorigin, dangercircleradius, thresholdradius )
{
    if ( br_gametypes::isfeaturedisabled( #"kiosk" ) || !getdvarint( @"hash_9ce834b516e05f4a", 1 ) )
    {
        return;
    }
    
    var_1bdc861911b3625e = dangercircleradius + level.var_797b14a7ea4df55.var_2216bbfb36d9b1e6;
    var_b37e42f15ca6902b = var_1bdc861911b3625e * var_1bdc861911b3625e;
    var_83a49b02be42b069 = 0;
    
    foreach ( armorykiosk in level.common_armory_kiosk.instances )
    {
        var_8b217f269a1d0c8d = !isdefined( armorykiosk.deconeffectcount ) && exclusion_zones::function_1efc19de6199fff6( armorykiosk.origin, 0, 0 ) == -1 && distance2dsquared( armorykiosk.origin, dangercircleorigin ) + level.var_ea96217a33eb6457 > var_b37e42f15ca6902b;
        armorykiosk.var_8b217f269a1d0c8d = var_8b217f269a1d0c8d;
        
        if ( armorykiosk.visible )
        {
            if ( var_8b217f269a1d0c8d )
            {
                function_cd2eb56f7058384a( armorykiosk );
            }
            else if ( !armorykiosk.isemped )
            {
                var_83a49b02be42b069++;
            }
            
            continue;
        }
        
        if ( !var_8b217f269a1d0c8d && !armorykiosk.b_force_disabled && !armorykiosk.isemped )
        {
            common_kiosk::function_50a87808f478947f( armorykiosk );
            var_83a49b02be42b069++;
        }
    }
    
    if ( level.var_c3258700fcc17d2 )
    {
        setomnvar( "ui_br_available_kiosk_num", var_83a49b02be42b069 );
    }
}

// Namespace br_common_kiosk
// Params 0
// Checksum 0xb30eda69, Offset: 0x1f5c
// Size: 0x19e
function dangermulticircletick()
{
    if ( br_gametypes::isfeaturedisabled( #"kiosk" ) || !getdvarint( @"hash_9ce834b516e05f4a", 1 ) )
    {
        return;
    }
    
    var_edcbb0c70598b9b4 = [];
    var_83a49b02be42b069 = 0;
    
    foreach ( armorykiosk in level.common_armory_kiosk.instances )
    {
        var_8b217f269a1d0c8d = !isdefined( armorykiosk.deconeffectcount ) && exclusion_zones::function_1efc19de6199fff6( armorykiosk.origin, 0, 0 ) == -1 && !br_circle_util::ispointinmulticircledanger( armorykiosk.origin, level.var_ea96217a33eb6457 );
        armorykiosk.var_8b217f269a1d0c8d = var_8b217f269a1d0c8d;
        
        if ( armorykiosk.visible )
        {
            if ( var_8b217f269a1d0c8d )
            {
                var_edcbb0c70598b9b4[ var_edcbb0c70598b9b4.size ] = armorykiosk;
                function_cd2eb56f7058384a( armorykiosk );
            }
            else if ( !armorykiosk.isemped )
            {
                var_83a49b02be42b069++;
            }
            
            continue;
        }
        
        if ( !var_8b217f269a1d0c8d && !armorykiosk.b_force_disabled && !armorykiosk.isemped )
        {
            common_kiosk::function_50a87808f478947f( armorykiosk );
            var_83a49b02be42b069++;
        }
    }
    
    if ( level.var_c3258700fcc17d2 )
    {
        setomnvar( "ui_br_available_kiosk_num", var_83a49b02be42b069 );
    }
    
    return var_edcbb0c70598b9b4;
}

// Namespace br_common_kiosk
// Params 0
// Checksum 0xef5be0cb, Offset: 0x2103
// Size: 0x94
function function_95f13d141203a55b()
{
    foreach ( armorykiosk in level.common_armory_kiosk.instances )
    {
        if ( isdefined( armorykiosk.visible ) )
        {
            function_cd2eb56f7058384a( armorykiosk );
        }
    }
}

// Namespace br_common_kiosk
// Params 1
// Checksum 0xa514796b, Offset: 0x219f
// Size: 0x58
function function_cd2eb56f7058384a( armorykiosk )
{
    if ( !armorykiosk.visible || armorykiosk.disabled )
    {
        return;
    }
    
    if ( isdefined( armorykiosk.visible ) && armorykiosk br_contract_manager::checkforactiveobjicon() )
    {
        armorykiosk br_contract_manager::deletequestobjicon();
    }
    
    common_kiosk::function_cd2eb56f7058384a( armorykiosk );
}

// Namespace br_common_kiosk
// Params 1
// Checksum 0xc2194a27, Offset: 0x21ff
// Size: 0xd5
function function_6aad9548db64d4a4( params )
{
    objectivestate = params.objectivestate;
    level.common_armory_kiosk.var_971f20e392d7da1f = objectivestate;
    
    foreach ( kiosk in common_kiosk::function_5c2447fa1580c330() )
    {
        if ( kiosk.b_force_disabled )
        {
            continue;
        }
        
        if ( !kiosk.visible )
        {
            continue;
        }
        
        kiosk setscriptablepartstate( "objective", objectivestate );
    }
}

// Namespace br_common_kiosk
// Params 1
// Checksum 0x95c4d8bc, Offset: 0x22dc
// Size: 0xe0
function onkioskpurchase( params )
{
    player = params.player;
    kiosk = params.kiosk;
    itemdata = params.itemdata;
    
    if ( function_dae8e9cc3954591b() && function_a8f6845122d0bf42( kiosk, player ) && function_8c5111eb81abe768( itemdata ) )
    {
        kioskfiresaledoneforplayer( kiosk, player );
        return;
    }
    
    if ( !function_dae8e9cc3954591b() && function_a8f6845122d0bf42( kiosk, player ) && ( itemdata.firesalediscount != 0 || function_8c5111eb81abe768( itemdata ) ) )
    {
        kioskfiresaledoneforplayer( kiosk, player );
        return;
    }
    
    if ( function_dae8e9cc3954591b() && function_8c5111eb81abe768( itemdata ) )
    {
        function_a81ff2dd91265e8( player, "publicevent" );
    }
}

// Namespace br_common_kiosk
// Params 2
// Checksum 0x1c5c9289, Offset: 0x23c4
// Size: 0x31
function function_92ac319b7cccf588( kiosk, player )
{
    player setclientomnvar( "ui_br_kiosk_hide_discount", 0 );
    player function_a81ff2dd91265e8( player, "reward" );
}

// Namespace br_common_kiosk
// Params 2
// Checksum 0xd2eb76bb, Offset: 0x23fd
// Size: 0xea
function function_ea56078d44169b8( player, channel )
{
    if ( !isdefined( player ) )
    {
        return 0;
    }
    
    if ( player.armorykioskpurchaseallowed )
    {
        return 1;
    }
    
    if ( level.var_e298f874f79103ed )
    {
        if ( !player isonground() && !isdefined( player.vehicle ) )
        {
            if ( channel == "br_item_purchase" )
            {
                player common_kiosk::_closepurchasemenuwithresponse( 18 );
                return 0;
            }
        }
        
        switch ( channel )
        {
            case #"hash_21c87951dc0972dd":
            case #"hash_29076d117d462839":
            case #"hash_3319419c6206a325":
            case #"hash_488003205a6f0be9":
            case #"hash_4ef5bb48d3b44264":
            case #"hash_57241c1e1ceb332d":
            case #"hash_b552fe0a04aa5018":
            case #"hash_de1d173000607e3e":
            case #"hash_ea4a05d8dc5311f9":
                return 1;
        }
    }
}

// Namespace br_common_kiosk
// Params 1
// Checksum 0x221c2b51, Offset: 0x24ef
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

// Namespace br_common_kiosk
// Params 2
// Checksum 0x5f3ed43c, Offset: 0x2557
// Size: 0xd1
function onarmorykioskpurchase( channel, purchaseindex )
{
    player = self;
    kiosk = player.common_kiosk;
    menueventparam = "channel: " + channel;
    
    if ( isdefined( purchaseindex ) )
    {
        menueventparam = menueventparam + ", index: " + purchaseindex;
    }
    
    if ( channel == "buy_menu_open" )
    {
        if ( level.var_e298f874f79103ed && !isdefined( kiosk ) )
        {
            player setclientomnvar( "ui_buystation_purchase_response", 0 );
            kiosktype = function_a160f0512ffc87b9( kiosk );
            br_analytics::branalytics_kiosk_menu_event( player, "menu_open", menueventparam, kiosktype );
            player thread common_kiosk::_watchtoautoclosemenu( player );
            return;
        }
    }
    
    kiosktype = function_a160f0512ffc87b9( kiosk );
    br_analytics::branalytics_kiosk_menu_event( player, "menu_purchase", menueventparam, kiosktype );
}

// Namespace br_common_kiosk
// Params 2
// Checksum 0x9b509f73, Offset: 0x2630
// Size: 0x57
function function_52f28106b1df1c8( itemref, player )
{
    if ( level.var_e298f874f79103ed && !isdefined( player.common_kiosk ) )
    {
        buystationindex = getomnvar( "ui_br_quick_buystation" );
        
        if ( isdefined( buystationindex ) )
        {
            return common_kiosk::function_89c427f6b73d6543( buystationindex, itemref );
        }
    }
}

// Namespace br_common_kiosk
// Params 1
// Checksum 0xc9ccfe7f, Offset: 0x2690
// Size: 0xdd
function function_da1991d7d5596e0a( buystationref )
{
    buystationindex = common_kiosk::function_9d041619b6fccf18( buystationref );
    setomnvar( "ui_br_quick_buystation", buystationindex );
    common_kiosk::function_b1b75e4a51094d62( buystationindex );
    
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
}

// Namespace br_common_kiosk
// Params 0
// Checksum 0x20f8f53c, Offset: 0x2775
// Size: 0xb3
function function_fd9b4fce6e78327a()
{
    level endon( #"game_ended" );
    level waittill( #"br_final_circle" );
    br_circle::function_e441e2dbc58966e8( 4 );
    
    foreach ( armorykiosk in level.common_armory_kiosk.instances )
    {
        armorykiosk.var_96c948fbd84c94a6 = 1;
    }
    
    function_95f13d141203a55b();
}

// Namespace br_common_kiosk
// Params 2
// Checksum 0x2cf01a7b, Offset: 0x2830
// Size: 0x68
function function_8c37d124818e1233( player, source )
{
    if ( !isdefined( level.var_797b14a7ea4df55.fireSaleFreeItems ) )
    {
        return;
    }
    
    if ( !isdefined( player.var_e5168ad44f9b579c ) )
    {
        player.var_e5168ad44f9b579c = [];
    }
    
    player.var_e5168ad44f9b579c[ source ] = 1;
    player setclientomnvar( "ui_br_kiosk_free_discount", 1 );
}

// Namespace br_common_kiosk
// Params 2
// Checksum 0xfc5b8ba2, Offset: 0x28a0
// Size: 0x85
function function_a81ff2dd91265e8( player, source )
{
    if ( !( isdefined( level.var_797b14a7ea4df55.fireSaleFreeItems ) && isdefined( player.var_e5168ad44f9b579c ) ) )
    {
        return;
    }
    
    if ( player.var_e5168ad44f9b579c[ source ] )
    {
        player.var_e5168ad44f9b579c[ source ] = undefined;
        
        if ( player.var_e5168ad44f9b579c.size == 0 )
        {
            player.var_e5168ad44f9b579c = undefined;
            player setclientomnvar( "ui_br_kiosk_free_discount", 0 );
        }
    }
}

// Namespace br_common_kiosk
// Params 1
// Checksum 0x2108ede8, Offset: 0x292d
// Size: 0x47
function function_8c5111eb81abe768( itemdata )
{
    if ( isdefined( level.var_797b14a7ea4df55.fireSaleFreeItems ) )
    {
        return arraycontains( level.var_797b14a7ea4df55.fireSaleFreeItems, itemdata.ref );
    }
    
    return 0;
}

// Namespace br_common_kiosk
// Params 1
// Checksum 0x3ead47b2, Offset: 0x297d
// Size: 0x18, Type: bool
function function_508a9518dc74e748( player )
{
    return isdefined( player.var_e5168ad44f9b579c );
}

// Namespace br_common_kiosk
// Params 1
// Checksum 0x6daf5a58, Offset: 0x299e
// Size: 0x206
function kioskemp( data )
{
    self.isemped = 1;
    self.var_1d87cd2cbcd4fac4 = function_cd2eb56f7058384a( self );
    
    if ( !isdefined( data.time ) )
    {
        data.time = level.var_797b14a7ea4df55.var_dc658b74c2d08d33;
    }
    
    if ( getdvarint( @"hash_ef89849dfc036e9f", 0 ) )
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
            
            return;
        }
        
        if ( isdefined( self.temptrigger.triggerenterents ) )
        {
            self.temptrigger.endtime = int( gettime() + utility::function_4b74c15943231980( data.time ) );
            
            foreach ( player in self.temptrigger.triggerenterents )
            {
                player lower_message::setlowermessageomnvar( "buystation_offline", self.temptrigger.endtime );
            }
        }
    }
}

// Namespace br_common_kiosk
// Params 1
// Checksum 0xefffb061, Offset: 0x2bac
// Size: 0xf2
function function_f22f68c3d39c5bf2( data )
{
    self.isemped = undefined;
    
    if ( !self.var_8b217f269a1d0c8d && self.visible )
    {
        common_kiosk::function_50a87808f478947f( self );
    }
    
    if ( self.temptrigger )
    {
        foreach ( ent in self.temptrigger.triggerenterents )
        {
            if ( isplayer( ent ) )
            {
                ent function_d41a31b10d7a7586( ent, self.temptrigger );
            }
        }
        
        self.temptrigger delete();
        self.temptrigger = undefined;
    }
}

// Namespace br_common_kiosk
// Params 2
// Checksum 0x4f360a92, Offset: 0x2ca6
// Size: 0x9d
function function_25ba9b48b9d80812( player, trigger )
{
    player endon( #"disconnect" );
    self endon( #"hash_e8824994906a4c6d" );
    lower_message::setlowermessageomnvar( "buystation_offline", trigger.endtime );
    
    for ( timeleft = utility::function_6f5d2e1f1ff70482( trigger.endtime - gettime() ); trigger && timeleft > 0 ; timeleft = utility::function_6f5d2e1f1ff70482( trigger.endtime - gettime() ) )
    {
        wait timeleft;
    }
    
    waitframe();
    thread function_d41a31b10d7a7586( player, trigger );
}

// Namespace br_common_kiosk
// Params 2
// Checksum 0x5f3033f1, Offset: 0x2d4b
// Size: 0x2d
function function_d41a31b10d7a7586( player, trigger )
{
    self notify( #"hash_e8824994906a4c6d" );
    lower_message::setlowermessageomnvar( "clear_lower_msg" );
}

