// scripts\mp\br\br_black_market.gsc  (hash_1e11556dad6c9df0.gscc) (size: 29014 Bytes / 0x7156 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3505d7e4 (889575396)
// size ...... 29014 (0x7156)
// includes .. 23  (offset: 0x6736)
// strings ... 134 (offset: 0x67ee)
// dev strs .. 30  (offset: 0x6fe2)
// exports ... 55  (offset: 0x4b1a)
// cseg ...... 0xed7 + 0x3c43 (0x4b1a)
// imports ... 150 (offset: 0x53b2)
// animtree1 . 0   (offset: 0x7156)
// animtree2 . 0   (offset: 0x7156)
#using script_62f2f17deb39ce40;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_common_kiosk;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_recon_quest;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\gamelogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_kiosk;
#using scripts\mp\music_br;
#using scripts\mp\poi;

#namespace br_black_market;

// Namespace br_black_market
// Params 0, eflags: 0x5
// Checksum 0xbf1a3360, Offset: 0xef5
// Size: 0x3b
function private autoexec main()
{
    if ( getdvarint( @"scr_br_black_market_enabled", 0 ) )
    {
        blackmarket_init();
        return;
    }
    
    utility::registersharedfunc( #"hash_da46e3937970eaef", #"contract_validate", &cleanup_black_market_contract );
}

// Namespace br_black_market
// Params 0
// Checksum 0xa78c019b, Offset: 0xf38
// Size: 0x18, Type: bool
function cleanup_black_market_contract()
{
    if ( self.varianttag == "black_market_recon" )
    {
        return false;
    }
    
    return true;
}

// Namespace br_black_market
// Params 0
// Checksum 0x9a6a8728, Offset: 0xf59
// Size: 0xd6
function blackmarket_init()
{
    setdvar( @"hash_857a007fa5beea3f", 1 );
    setdvar( @"hash_f17a96e9014e216", 250 );
    ui::lui_registercallback( "br_black_market_kiosk", &function_c17e6856aed46e51 );
    utility::registersharedfunc( #"hash_da46e3937970eaef", #"hash_be0d75f42e2b50c9", &function_8418b61ad3b319ae );
    init_black_market_data();
    level._effect[ "black_market_nuke_explosion" ] = loadfxasset( "vfx_saw_br_gameplay_daisy_radiation_zone_nuke_01" );
    
    if ( !isdefined( level.var_a91372bf2ae4d5a7 ) )
    {
        level.var_a91372bf2ae4d5a7 = getxhash( level game_utility::getbasegametype() );
    }
    
    init_vo();
    level callback::add( #"player_item_pickup", &on_item_pickup );
    level callback::add( #"on_contract_completed", &on_contract_completed );
    level thread function_2597cb7fcb304b82();
    
    /#
        debug_init();
    #/
}

// Namespace br_black_market
// Params 1
// Checksum 0xb946780e, Offset: 0x1037
// Size: 0x2f6
function function_e98a42ce1084203f( player )
{
    if ( !level.var_ab06be8f65123f71.initcomplete )
    {
        common_kiosk::function_b1b75e4a51094d62( common_kiosk::function_9d041619b6fccf18( "saw_sm_island_shadowlink_t1" ) );
        common_kiosk::function_b1b75e4a51094d62( common_kiosk::function_9d041619b6fccf18( "saw_sm_island_shadowlink_t2" ) );
        common_kiosk::function_b1b75e4a51094d62( common_kiosk::function_9d041619b6fccf18( "saw_sm_island_shadowlink_t3" ) );
        init_activities();
        level.var_ab06be8f65123f71.initcomplete = 1;
    }
    
    team = teams::getteamdata( player.team, "players" );
    
    if ( isdefined( level.var_ab06be8f65123f71.var_ecea9a714729f7e2[ player.team ] ) )
    {
        return;
    }
    
    foreach ( teammate in team )
    {
        teammate setclientomnvar( "ui_buy_station_global_enabled", 1 );
        teammate setclientomnvar( "ui_black_market_tier", 1 );
        teammate.index = level.var_ab06be8f65123f71.kioskindex;
        teammate.overrideindex = common_kiosk::function_9d041619b6fccf18( "saw_sm_island_shadowlink_t1" );
        
        if ( !teammate callback::exists( #"hash_2c631dc23e0ee99b", &on_kiosk_purchase ) )
        {
            teammate callback::add( #"hash_2c631dc23e0ee99b", &on_kiosk_purchase );
        }
        
        if ( !teammate callback::exists( #"hash_8daeabb90e45c6bc", &function_91d1ef0e8a7cb47 ) )
        {
            teammate callback::add( #"hash_8daeabb90e45c6bc", &function_91d1ef0e8a7cb47 );
        }
        
        if ( teammate playerads() == 0 )
        {
            teammate weapon_utility::giveandfireoffhandreliable( makeweapon( "ks_gesture_shadowlink_sat_wz" ), undefined );
        }
        
        teammate dlog_recordplayerevent( "dlog_event_br_shadowlink_acquired", [ "time_from_match_start_ms", gettime() ] );
    }
    
    level.var_ab06be8f65123f71.var_ecea9a714729f7e2[ player.team ] = 1;
    level.var_ab06be8f65123f71.var_6c70feef73807c5e[ player.team ] = level.var_ab06be8f65123f71.kioskindex;
    level.var_ab06be8f65123f71.teamobjectives[ player.team ] = [];
    level.var_ab06be8f65123f71.var_603ef34f57ab1318[ player.team ] = [];
    level.var_ab06be8f65123f71.var_b5bbd449f3715bb1[ player.team ] = [];
    level.var_ab06be8f65123f71.kioskindex++;
    function_d0ce10fed55911e2( player.team, "Gained access to black market." );
}

// Namespace br_black_market
// Params 1, eflags: 0x4
// Checksum 0x1c2e5abd, Offset: 0x1335
// Size: 0x210
function private on_kiosk_purchase( params )
{
    switch ( params.itemdata.ref )
    {
        case #"hash_9e3716fdd37732ac":
            assign_objectives( level.var_ab06be8f65123f71.var_b9ca7ed059dcda9d.hitlistactivitylist, 3, 300, 1 );
            
            foreach ( teammate in teams::getteamdata( self.team, "players" ) )
            {
                teammate dlog_recordplayerevent( "dlog_event_br_shadowlink_hitlist_started", [ "tier", 1, "time_from_match_start_ms", gettime() ] );
            }
            
            function_a6e814bae308291a( self, "Purchased hitlist tier 1." );
            break;
        case #"hash_9e3719fdd3773765":
            assign_objectives( level.var_ab06be8f65123f71.var_b9ca7bd059dcd404.hitlistactivitylist, 2, 420, 2 );
            
            foreach ( teammate in teams::getteamdata( self.team, "players" ) )
            {
                teammate dlog_recordplayerevent( "dlog_event_br_shadowlink_hitlist_started", [ "tier", 2, "time_from_match_start_ms", gettime() ] );
            }
            
            function_a6e814bae308291a( self, "Purchased hitlist tier 2." );
            break;
        case #"hash_faf9d2753c8134bb":
            thread call_nuke();
            break;
    }
}

// Namespace br_black_market
// Params 1, eflags: 0x4
// Checksum 0x88c60905, Offset: 0x154d
// Size: 0x15d
function private function_91d1ef0e8a7cb47( params )
{
    if ( isdefined( params.kiosk.overrideindex ) && isdefined( params.kiosk.team ) )
    {
        if ( params.kiosk.overrideindex == get_buy_station_index( level.var_ab06be8f65123f71.var_ecea9a714729f7e2[ params.kiosk.team ] ) )
        {
            if ( params.itemdata.ref == "wz_consumable_self_revive_advanced" )
            {
                self setclientomnvar( "ui_self_revive_advanced_acquired", 1 );
            }
            
            self dlog_recordplayerevent( "dlog_event_br_shadowlink_item_purchased", [ "item_purchased", params.itemdata.entryref, "cost", params.cost, "time_from_match_start_ms", gettime() ] );
            function_a6e814bae308291a( self, "Player purchased " + string( params.itemdata.entryref ) + " from Tier " + string( level.var_ab06be8f65123f71.var_ecea9a714729f7e2[ self.team ] ) + " black market." );
        }
    }
}

// Namespace br_black_market
// Params 0, eflags: 0x4
// Checksum 0x8423b64, Offset: 0x16b2
// Size: 0x602
function private init_black_market_data()
{
    level.var_ab06be8f65123f71 = spawnstruct();
    
    if ( !isdefined( level.var_ab06be8f65123f71.var_ecea9a714729f7e2 ) )
    {
        level.var_ab06be8f65123f71.var_ecea9a714729f7e2 = [];
    }
    
    if ( !isdefined( level.var_ab06be8f65123f71.var_6c70feef73807c5e ) )
    {
        level.var_ab06be8f65123f71.var_6c70feef73807c5e = [];
    }
    
    if ( !isdefined( level.var_ab06be8f65123f71.teamobjectives ) )
    {
        level.var_ab06be8f65123f71.teamobjectives = [];
    }
    
    if ( !isdefined( level.var_ab06be8f65123f71.var_603ef34f57ab1318 ) )
    {
        level.var_ab06be8f65123f71.var_603ef34f57ab1318 = [];
    }
    
    level.var_ab06be8f65123f71.kioskindex = 900;
    level.var_ab06be8f65123f71.var_b9ca7ed059dcda9d = getscriptbundle( "hitlistactivitylist" + ":" + "hitlistactivities_t1" );
    level.var_ab06be8f65123f71.var_b9ca7bd059dcd404 = getscriptbundle( "hitlistactivitylist" + ":" + "hitlistactivities_t2" );
    level.var_ab06be8f65123f71.initcomplete = 0;
    level.var_ab06be8f65123f71.hitlistcallbacks = [];
    level.var_ab06be8f65123f71.activitylist = [];
    level.var_ab06be8f65123f71.var_d1c27291e22160d2 = [];
    level.var_ab06be8f65123f71.var_5f0a261bdae1f6e6 = [];
    
    if ( !getdvarint( @"scr_br_black_market_kills_disable", 0 ) )
    {
        level.var_ab06be8f65123f71.hitlistcallbacks[ "black_market_kills" ] = "black_market_kills_complete";
        level.var_ab06be8f65123f71.activitylist[ "black_market_kills" ] = "wz_sat_activity_black_market_kills";
    }
    
    if ( !getdvarint( @"scr_br_black_market_cash_disable", 0 ) )
    {
        level.var_ab06be8f65123f71.hitlistcallbacks[ "black_market_cash" ] = "black_market_cash_complete";
        level.var_ab06be8f65123f71.activitylist[ "black_market_cash" ] = "wz_sat_activity_black_market_cash";
        level.var_ab06be8f65123f71.hitlistcallbacks[ "black_market_cash_t2" ] = "black_market_cash_complete";
        level.var_ab06be8f65123f71.activitylist[ "black_market_cash_t2" ] = "wz_sat_activity_black_market_cash_t2";
        level.var_ab06be8f65123f71.var_d1c27291e22160d2[ "black_market_cash" ] = "black_market_cash_t2";
    }
    
    if ( !getdvarint( @"scr_br_black_market_caches_disable", 0 ) )
    {
        level.var_ab06be8f65123f71.hitlistcallbacks[ "black_market_caches" ] = "black_market_caches_complete";
        level.var_ab06be8f65123f71.activitylist[ "black_market_caches" ] = "wz_sat_activity_black_market_caches";
    }
    
    if ( !getdvarint( @"hash_5e4c7aaed3f1c8a2", 0 ) )
    {
        level.var_ab06be8f65123f71.hitlistcallbacks[ "black_market_mark_targets" ] = "black_market_mark_targets_complete";
        level.var_ab06be8f65123f71.activitylist[ "black_market_mark_targets" ] = "wz_sat_activity_black_market_mark_targets";
        level.var_ab06be8f65123f71.hitlistcallbacks[ "black_market_mark_targets_t2" ] = "black_market_mark_targets_complete";
        level.var_ab06be8f65123f71.activitylist[ "black_market_mark_targets_t2" ] = "wz_sat_activity_black_market_mark_targets_t2";
        level.var_ab06be8f65123f71.var_d1c27291e22160d2[ "black_market_mark_targets" ] = "black_market_mark_targets_t2";
    }
    
    if ( !getdvarint( @"scr_br_black_market_contracts_disable", 0 ) )
    {
        level.var_ab06be8f65123f71.hitlistcallbacks[ "black_market_contracts" ] = "black_market_contracts_complete";
        level.var_ab06be8f65123f71.activitylist[ "black_market_contracts" ] = "wz_sat_activity_black_market_contracts";
        level.var_ab06be8f65123f71.hitlistcallbacks[ "black_market_contracts_t2" ] = "black_market_contracts_complete";
        level.var_ab06be8f65123f71.activitylist[ "black_market_contracts_t2" ] = "wz_sat_activity_black_market_contracts_t2";
        level.var_ab06be8f65123f71.var_d1c27291e22160d2[ "black_market_contracts" ] = "black_market_contracts_t2";
    }
    
    if ( !getdvarint( @"scr_br_black_market_deposit_disable", 0 ) )
    {
        level.var_ab06be8f65123f71.hitlistcallbacks[ "black_market_deposit" ] = "black_market_deposit_complete";
        level.var_ab06be8f65123f71.activitylist[ "black_market_deposit" ] = "wz_sat_activity_black_market_deposit";
    }
    
    if ( !getdvarint( @"hash_e55c665fe37fcc08", 0 ) )
    {
        level.var_ab06be8f65123f71.hitlistcallbacks[ "black_market_kills_execution_t2" ] = "black_market_kills_execution_complete";
        level.var_ab06be8f65123f71.activitylist[ "black_market_kills_execution_t2" ] = "wz_sat_activity_black_market_kills_execution_t2";
        level.var_ab06be8f65123f71.var_5f0a261bdae1f6e6[ "black_market_kills_execution_t2" ] = "black_market_kills_melee_t2";
    }
    
    if ( !getdvarint( @"hash_108f3036378c09b8", 0 ) )
    {
        level.var_ab06be8f65123f71.hitlistcallbacks[ "black_market_kills_handcannon_t2" ] = "black_market_kills_handcannon_complete";
        level.var_ab06be8f65123f71.activitylist[ "black_market_kills_handcannon_t2" ] = "wz_sat_activity_black_market_kills_handcannon_t2";
    }
    
    if ( !getdvarint( @"hash_81e9ad566930edce", 0 ) )
    {
        level.var_ab06be8f65123f71.hitlistcallbacks[ "black_market_kills_melee_t2" ] = "black_market_kills_melee_complete";
        level.var_ab06be8f65123f71.activitylist[ "black_market_kills_melee_t2" ] = "wz_sat_activity_black_market_kills_melee_t2";
        level.var_ab06be8f65123f71.var_5f0a261bdae1f6e6[ "black_market_kills_melee_t2" ] = "black_market_kills_execution_t2";
    }
    
    if ( !getdvarint( @"hash_8e7c93fd5a146dc9", 0 ) )
    {
        level.var_ab06be8f65123f71.hitlistcallbacks[ "black_market_kills_explosive_t2" ] = "black_market_kills_explosive_complete";
        level.var_ab06be8f65123f71.activitylist[ "black_market_kills_explosive_t2" ] = "wz_sat_activity_black_market_kills_explosive_t2";
    }
}

// Namespace br_black_market
// Params 0, eflags: 0x4
// Checksum 0x8d51afc1, Offset: 0x1cbc
// Size: 0x9e
function private init_activities()
{
    foreach ( variant in getarraykeys( level.var_ab06be8f65123f71.hitlistcallbacks ) )
    {
        activity_definition_utils::function_74af1ab4059e3c06( level.var_ab06be8f65123f71.activitylist[ variant ], variant );
    }
}

// Namespace br_black_market
// Params 0, eflags: 0x4
// Checksum 0x7b52709f, Offset: 0x1d62
// Size: 0x4e
function private init_vo()
{
    game[ "dialog" ][ "black_market_hitlist_start" ] = "mpsh_bmde_bmhl";
    game[ "dialog" ][ "black_market_hitlist_fail" ] = "mpsh_bmde_bmhf";
    game[ "dialog" ][ "black_market_hitlist_success" ] = "mpsh_bmde_bmhs";
    game[ "dialog" ][ "black_market_item_pickup" ] = "mpsh_bmde_bmls";
}

// Namespace br_black_market
// Params 4, eflags: 0x4
// Checksum 0x9772dc3b, Offset: 0x1db8
// Size: 0x68c
function private assign_objectives( hitlistactivities, objectivecount, duration, tier )
{
    function_f544cd21e2c401c8( self.team );
    activities = [];
    
    foreach ( index, objective in hitlistactivities )
    {
        if ( !isdefined( level.var_ab06be8f65123f71.hitlistcallbacks[ objective.variant ] ) )
        {
            continue;
        }
        
        if ( tier == 2 && function_f02c63b99c9614c9( level.var_ab06be8f65123f71.var_d1c27291e22160d2, objective.variant ) )
        {
            continue;
        }
        
        activities[ index ] = objective;
        activities[ index ].listindex = index;
    }
    
    foreach ( var_912997ed1f2589d5 in level.var_ab06be8f65123f71.var_603ef34f57ab1318[ self.team ] )
    {
        foreach ( activity in activities )
        {
            if ( var_912997ed1f2589d5.varianttag == activity.variant )
            {
                activities = arrayremove( activities, activity );
                break;
            }
        }
    }
    
    if ( tier == 1 )
    {
        level.var_ab06be8f65123f71.var_b5bbd449f3715bb1[ self.team ] = [];
    }
    
    var_fa3c7acdb3992e66 = [];
    var_1bdf3db0d54ddd73 = 0;
    randomact = arrayrandomize( activities );
    
    foreach ( objective in randomact )
    {
        callback = level.var_ab06be8f65123f71.hitlistcallbacks[ objective.variant ];
        
        if ( !isdefined( callback ) )
        {
            continue;
        }
        
        if ( arraycontains( var_fa3c7acdb3992e66, objective.variant ) )
        {
            continue;
        }
        
        if ( isdefined( level.var_ab06be8f65123f71.var_5f0a261bdae1f6e6[ objective.variant ] ) )
        {
            var_fa3c7acdb3992e66 = arraycombineunique( var_fa3c7acdb3992e66, [ level.var_ab06be8f65123f71.var_5f0a261bdae1f6e6[ objective.variant ] ] );
        }
        
        if ( tier == 1 && isdefined( level.var_ab06be8f65123f71.var_d1c27291e22160d2[ objective.variant ] ) )
        {
            if ( level.var_ab06be8f65123f71.var_b5bbd449f3715bb1[ self.team ].size >= level.var_ab06be8f65123f71.var_d1c27291e22160d2.size - 1 )
            {
                continue;
            }
            
            level.var_ab06be8f65123f71.var_b5bbd449f3715bb1[ self.team ][ level.var_ab06be8f65123f71.var_b5bbd449f3715bb1[ self.team ].size ] = objective.variant;
        }
        
        activity = give_objective( objective.variant, callback, var_1bdf3db0d54ddd73, objective.listindex );
        
        if ( isdefined( activity ) && isdefined( activity.var_e31e2f92f674112e ) )
        {
            level.var_ab06be8f65123f71.teamobjectives[ self.team ] = arrayremove( level.var_ab06be8f65123f71.teamobjectives[ self.team ], activity );
            level.var_ab06be8f65123f71.var_603ef34f57ab1318[ self.team ][ level.var_ab06be8f65123f71.var_603ef34f57ab1318[ self.team ].size ] = activity;
            function_d0ce10fed55911e2( self.team, "Failed to start objective " + string( activity.varianttag ) + "." );
            continue;
        }
        
        foreach ( player in teams::getteamdata( self.team, "players" ) )
        {
            player dlog_recordplayerevent( "dlog_event_br_shadowlink_objective_started", [ "objective_name", activity.varianttag, "time_from_match_start_ms", gettime() ] );
        }
        
        function_d0ce10fed55911e2( self.team, "Given objective " + string( activity.varianttag ) + "." );
        var_1bdf3db0d54ddd73++;
        
        if ( var_1bdf3db0d54ddd73 >= objectivecount )
        {
            if ( tier == 2 )
            {
                function_8dc086a910655543( var_1bdf3db0d54ddd73 );
            }
            
            level thread function_f5740edf7dd9131( self.team, duration );
            level thread br_public::brleaderdialogteam( "black_market_hitlist_start", self.team, 1, 0.5, undefined, "dx_br_brsa_", undefined, 1 );
            return;
        }
    }
    
    assertmsg( "<dev string:x24>" );
    function_d0ce10fed55911e2( self.team, "Failed to give 3 valid objectives." );
    level thread function_f5740edf7dd9131( self.team, duration );
    level thread br_public::brleaderdialogteam( "black_market_hitlist_start", self.team, 1, 0.5, undefined, "dx_br_brsa_", undefined, 1 );
}

// Namespace br_black_market
// Params 4, eflags: 0x4
// Checksum 0xcf2b429d, Offset: 0x244d
// Size: 0x133
function private give_objective( activityvariant, activitycallback, var_1bdf3db0d54ddd73, activityindex )
{
    team = teams::getteamdata( self.team, "players" );
    properties = activity_definition_utils::function_9129cd8075c85c09( activity_definition_utils::getactivitydefinition( activityvariant ) );
    new_event = activity_instance_common::createactivityinstance( properties.activitytype, activityvariant );
    activity_participation::function_fb0ec90aaf6d4c61( new_event, team );
    new_event.team = self.team;
    new_event.objectiveindex = activityindex;
    new_event.var_f118922d6f1d1e00 = var_1bdf3db0d54ddd73 + 1;
    new_event.activitycallback = activitycallback;
    activity_instance_common::function_852865f5a195559f( new_event );
    
    if ( !level callback::exists( activitycallback, &on_objective_complete ) )
    {
        level callback::add( activitycallback, &on_objective_complete );
    }
    
    level.var_ab06be8f65123f71.teamobjectives[ self.team ][ level.var_ab06be8f65123f71.teamobjectives[ self.team ].size ] = new_event;
    return new_event;
}

// Namespace br_black_market
// Params 1, eflags: 0x4
// Checksum 0x5cb3f718, Offset: 0x2589
// Size: 0x298
function private function_8dc086a910655543( var_1bdf3db0d54ddd73 )
{
    var_7d0c29c314634c78 = [];
    
    foreach ( var_17beda621d3a35cc, var_17bedd621d3a3c65 in level.var_ab06be8f65123f71.var_d1c27291e22160d2 )
    {
        if ( !arraycontains( level.var_ab06be8f65123f71.var_b5bbd449f3715bb1[ self.team ], var_17beda621d3a35cc ) )
        {
            var_7d0c29c314634c78[ var_7d0c29c314634c78.size ] = var_17bedd621d3a3c65;
        }
    }
    
    if ( var_7d0c29c314634c78.size == 0 )
    {
        return;
    }
    
    var_f32b2e445d0d23b6 = utility::array_random( var_7d0c29c314634c78 );
    callback = level.var_ab06be8f65123f71.hitlistcallbacks[ var_f32b2e445d0d23b6 ];
    
    if ( !isdefined( callback ) )
    {
        return;
    }
    
    listindex = -1;
    
    foreach ( index, objective in level.var_ab06be8f65123f71.var_b9ca7bd059dcd404.hitlistactivitylist )
    {
        if ( objective.variant == var_f32b2e445d0d23b6 )
        {
            listindex = index;
            break;
        }
    }
    
    activity = give_objective( var_f32b2e445d0d23b6, callback, var_1bdf3db0d54ddd73, listindex );
    
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        player dlog_recordplayerevent( "dlog_event_br_shadowlink_objective_started", [ "objective_name", activity.varianttag, "time_from_match_start_ms", gettime() ] );
    }
    
    function_d0ce10fed55911e2( self.team, "Given objective " + string( activity.varianttag ) + "." );
}

// Namespace br_black_market
// Params 1, eflags: 0x4
// Checksum 0x4529d990, Offset: 0x2829
// Size: 0x5e
function private get_buy_station_index( tier )
{
    switch ( tier )
    {
        case 1:
            return common_kiosk::function_9d041619b6fccf18( "saw_sm_island_shadowlink_t1" );
        case 2:
            return common_kiosk::function_9d041619b6fccf18( "saw_sm_island_shadowlink_t2" );
        case 3:
            return common_kiosk::function_9d041619b6fccf18( "saw_sm_island_shadowlink_t3" );
    }
}

// Namespace br_black_market
// Params 1
// Checksum 0x50e061cc, Offset: 0x2890
// Size: 0x4b
function function_c17e6856aed46e51( value )
{
    if ( value > 0 )
    {
        thread common_kiosk::_runpurchasemenu( self );
        
        if ( level.var_ab06be8f65123f71.teamobjectives[ self.team ].size > 0 )
        {
            self setclientomnvar( "ui_hit_list_active", 1 );
        }
    }
}

// Namespace br_black_market
// Params 1
// Checksum 0xdeb4bb1a, Offset: 0x28e3
// Size: 0x6e
function on_item_pickup( params )
{
    if ( params.itembundle.ref == "wz_consumable_quest_black_market" )
    {
        function_e98a42ce1084203f( params.player );
        level thread br_public::brleaderdialogteam( "black_market_item_pickup", params.player.team, 1, 0.5, undefined, "dx_br_brsa_", undefined, 1 );
    }
}

// Namespace br_black_market
// Params 1
// Checksum 0x896f2415, Offset: 0x2959
// Size: 0x72
function on_contract_completed( params )
{
    if ( params.contract.varianttag == "black_market_recon" )
    {
        function_e98a42ce1084203f( params.players[ 0 ] );
        level.var_ab06be8f65123f71.reservednodes = arrayremove( level.var_ab06be8f65123f71.reservednodes, self.var_b25418214626adee );
    }
}

// Namespace br_black_market
// Params 1
// Checksum 0x6661664, Offset: 0x29d3
// Size: 0x3df
function on_objective_complete( params )
{
    if ( level.var_ab06be8f65123f71.teamobjectives[ params.team ] )
    {
        level.var_ab06be8f65123f71.teamobjectives[ params.team ] = arrayremove( level.var_ab06be8f65123f71.teamobjectives[ params.team ], params.activity );
        team = teams::getteamdata( params.team, "players" );
        
        foreach ( teammate in team )
        {
            teammate thread points::doscoreevent( #"br_black_market_objective_complete" );
            teammate playsoundevent( "uin_br_black_maket_obj_complete" );
            teammate dlog_recordplayerevent( "dlog_event_br_shadowlink_objective_completed", [ "objective_name", params.activity.varianttag, "success", 1, "time_from_match_start_ms", gettime() ] );
        }
        
        function_d0ce10fed55911e2( params.team, string( params.activity.varianttag ) + " objective complete" );
        
        if ( level.var_ab06be8f65123f71.teamobjectives[ params.team ].size == 0 )
        {
            level.var_ab06be8f65123f71.var_ecea9a714729f7e2[ params.team ]++;
            
            foreach ( teammate in team )
            {
                teammate thread points::doscoreevent( #"br_black_market_hitlist_complete" );
                teammate playsoundevent( "uin_br_black_maket_hitlist_complete" );
                teammate thread hud_message::showsplash( "hit_list_success", undefined, undefined, undefined, undefined, "splash_list_br_black_market" );
                teammate.overrideindex = get_buy_station_index( level.var_ab06be8f65123f71.var_ecea9a714729f7e2[ params.team ] );
                teammate setclientomnvar( "ui_hit_list_timer", 0 );
                teammate setclientomnvar( "ui_black_market_tier", level.var_ab06be8f65123f71.var_ecea9a714729f7e2[ params.team ] );
                teammate thread function_8e6982b6b4f62505();
                teammate dlog_recordplayerevent( "dlog_event_br_shadowlink_hitlist_completed", [ "tier", level.var_ab06be8f65123f71.var_ecea9a714729f7e2[ params.team ], "success", 1, "time_from_match_start_ms", gettime() ] );
            }
            
            level notify( "stop_hitlist_timer_" + params.team );
            level thread br_public::brleaderdialogteam( "black_market_hitlist_success", params.team, 1, 2, undefined, "dx_br_brsa_", undefined, 1 );
            function_d0ce10fed55911e2( params.team, "Hit list complete. Team is now tier " + string( level.var_ab06be8f65123f71.var_ecea9a714729f7e2[ params.team ] ) );
            
            if ( getdvarint( @"hash_f742c29832022740", 1 ) )
            {
                function_9a8915f0d7342749( params.team );
            }
        }
    }
}

// Namespace br_black_market
// Params 0
// Checksum 0x84cace66, Offset: 0x2dba
// Size: 0xfa
function function_2597cb7fcb304b82()
{
    utility::flag_wait( "create_script_initialized" );
    level.var_ab06be8f65123f71.var_9806c23721298384 = [];
    level.var_ab06be8f65123f71.reservednodes = [];
    uploadstructs = utility::getstructarray( "intel_upload_station", "targetname" );
    
    foreach ( uploadstruct in uploadstructs )
    {
        if ( uploadstruct.script_noteworthy == "shadowlink" )
        {
            level.var_ab06be8f65123f71.var_9806c23721298384[ level.var_ab06be8f65123f71.var_9806c23721298384.size ] = uploadstruct;
        }
    }
}

// Namespace br_black_market
// Params 1
// Checksum 0xd82c8afd, Offset: 0x2ebc
// Size: 0x380
function function_8418b61ad3b319ae( var_ca369031b554da2f )
{
    availablenodes = [];
    
    foreach ( node in level.var_ab06be8f65123f71.var_9806c23721298384 )
    {
        if ( !arraycontains( level.var_ab06be8f65123f71.reservednodes, node ) )
        {
            availablenodes[ availablenodes.size ] = node;
        }
    }
    
    node = br_recon_quest::function_8aabe8488ceb5c2f( self.var_1103806baee402d5, self.var_332f929de1894b2b, availablenodes );
    
    if ( !isdefined( node ) )
    {
        assertmsg( "<dev string:x6b>" );
        return;
    }
    
    v_origin = getgroundposition( node.origin, 1 );
    var_2a21be5f74f73c3d = node.angles ?? ( 0, 0, 0 );
    node.angles = var_2a21be5f74f73c3d;
    payload = [ #"teamselect", var_ca369031b554da2f.team ];
    
    if ( !isdefined( self.domflag ) )
    {
        self.domflag = spawnscriptable( self.var_332f929de1894b2b.domscriptable, v_origin, var_2a21be5f74f73c3d, undefined, payload );
    }
    
    self.domflag.script_poi = poi::poi_findpoioriginisin( node.origin, 1 );
    domradius = int( node.radius ) ?? 168;
    self.domflag.trigger = spawn( "trigger_radius", node.origin, 0, int( domradius ), self.var_332f929de1894b2b.var_1e35088397af1053 );
    self.domflag.radius = domradius;
    self.domflag.trigger utility::trigger_on();
    self.domflag.playersintrigger = [];
    self.domflag.activity_instance = self;
    self.domflag.task = self;
    node.setup = 1;
    node.domflag = self.domflag;
    self.domflag.node = node;
    
    foreach ( player in level.players )
    {
        self.domflag disablescriptableplayeruse( player );
    }
    
    self.domflag thread namespace_b52a40a0de3ec90a::domflag_watchtrigger();
    self.var_b25418214626adee = node;
    level.var_ab06be8f65123f71.reservednodes[ level.var_ab06be8f65123f71.reservednodes.size ] = node;
}

// Namespace br_black_market
// Params 5
// Checksum 0xf725c248, Offset: 0x3244
// Size: 0xf5
function set_objective_omnvars( var_f118922d6f1d1e00, objectiveindex, currentprogress, maxprogress, descdata )
{
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        player setclientomnvar( "ui_hit_list_obj_id_" + var_f118922d6f1d1e00, objectiveindex );
        player setclientomnvar( "ui_hit_list_obj_progress_" + var_f118922d6f1d1e00, currentprogress );
        player setclientomnvar( "ui_hit_list_obj_max_progress_" + var_f118922d6f1d1e00, maxprogress );
        
        if ( isdefined( descdata ) )
        {
            player setclientomnvar( "ui_hit_list_obj_desc_data_index_" + var_f118922d6f1d1e00, descdata );
        }
    }
}

// Namespace br_black_market
// Params 1
// Checksum 0xb4441e06, Offset: 0x3341
// Size: 0xde
function function_f544cd21e2c401c8( team )
{
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        for ( var_f118922d6f1d1e00 = 1; var_f118922d6f1d1e00 <= 3 ; var_f118922d6f1d1e00++ )
        {
            player setclientomnvar( "ui_hit_list_obj_id_" + var_f118922d6f1d1e00, -1 );
            player setclientomnvar( "ui_hit_list_obj_progress_" + var_f118922d6f1d1e00, -1 );
            player setclientomnvar( "ui_hit_list_obj_max_progress_" + var_f118922d6f1d1e00, -1 );
            player setclientomnvar( "ui_hit_list_obj_desc_data_index_" + var_f118922d6f1d1e00, -1 );
        }
    }
}

// Namespace br_black_market
// Params 2
// Checksum 0xdafdd5c6, Offset: 0x3427
// Size: 0xbd
function function_538557e757f948f0( var_f118922d6f1d1e00, currentprogress )
{
    if ( !isdefined( var_f118922d6f1d1e00 ) && !isdefined( currentprogress ) )
    {
        return;
    }
    
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        player setclientomnvar( "ui_hit_list_obj_progress_" + var_f118922d6f1d1e00, currentprogress );
        player playsoundevent( "saw_black_market_ui_hitlist_tick" );
    }
}

// Namespace br_black_market
// Params 0
// Checksum 0xb953e9c0, Offset: 0x34ec
// Size: 0x11
function function_8e6982b6b4f62505()
{
    wait 3;
    self setclientomnvar( "ui_hit_list_active", 0 );
}

// Namespace br_black_market
// Params 2
// Checksum 0x7bf1dcfb, Offset: 0x3505
// Size: 0x100
function function_f5740edf7dd9131( team, duration )
{
    level endon( #"game_ended" );
    level endon( #"disconnect" );
    level endon( "stop_hitlist_timer_" + team );
    starttime = gettime();
    
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        player setclientomnvar( "ui_hit_list_active", 1 );
        player setclientomnvar( "ui_hit_list_timer", duration * 1000 + starttime );
        player thread hud_message::showsplash( "hit_list_started", undefined, undefined, undefined, undefined, "splash_list_br_black_market" );
    }
    
    wait duration;
    hitlist_fail( team );
}

// Namespace br_black_market
// Params 1
// Checksum 0x1450376f, Offset: 0x360d
// Size: 0x22e
function hitlist_fail( team )
{
    teammates = teams::getteamdata( team, "players" );
    level thread br_public::brleaderdialogteam( "black_market_hitlist_fail", team, 1, 2, undefined, "dx_br_brsa_", undefined, 1 );
    
    foreach ( teammate in teammates )
    {
        teammate setclientomnvar( "ui_hit_list_timer", 0 );
        teammate setclientomnvar( "ui_hit_list_active", 0 );
        teammate thread hud_message::showsplash( "hit_list_failed", undefined, undefined, undefined, undefined, "splash_list_br_black_market" );
        teammate dlog_recordplayerevent( "dlog_event_br_shadowlink_hitlist_completed", [ "tier", level.var_ab06be8f65123f71.var_ecea9a714729f7e2[ team ], "success", 0, "time_from_match_start_ms", gettime() ] );
    }
    
    team_objectives = level.var_ab06be8f65123f71.teamobjectives[ team ];
    
    foreach ( objective in team_objectives )
    {
        activity_instance_common::endactivity( objective, 0 );
        level.var_ab06be8f65123f71.teamobjectives[ team ] = arrayremove( level.var_ab06be8f65123f71.teamobjectives[ team ], objective );
    }
    
    function_f9dcb00da5756876( team );
    level notify( "stop_hitlist_timer_" + team );
    function_d0ce10fed55911e2( team, "Hitlist tier " + string( level.var_ab06be8f65123f71.var_ecea9a714729f7e2[ team ] ) + " failed." );
}

// Namespace br_black_market
// Params 1
// Checksum 0x3a3c17a9, Offset: 0x3843
// Size: 0xa6
function function_f9dcb00da5756876( team )
{
    teammates = teams::getteamdata( team, "players" );
    
    if ( teammates.size == 0 )
    {
        return;
    }
    
    kiosk = teammates[ 0 ];
    itemstock = level.buystationstock[ kiosk.index ].stock;
    var_dc86cc9fb0bd3bc9 = getarraykeys( itemstock );
    
    if ( arraycontains( var_dc86cc9fb0bd3bc9, "saw_sm_island_shadowlink_hitlist_1" ) )
    {
        itemstock[ "saw_sm_island_shadowlink_hitlist_1" ] = 1;
        return;
    }
    
    if ( arraycontains( var_dc86cc9fb0bd3bc9, "saw_sm_island_shadowlink_hitlist_2" ) )
    {
        itemstock[ "saw_sm_island_shadowlink_hitlist_2" ] = 1;
        return;
    }
}

// Namespace br_black_market
// Params 1
// Checksum 0xa671528, Offset: 0x38f1
// Size: 0xfc
function function_9a8915f0d7342749( team )
{
    teammates = teams::getteamdata( team, "players" );
    
    foreach ( teammate in teammates )
    {
        if ( !isdefined( teammate.firesaleforplayers ) )
        {
            teammate.firesaleforplayers = [ teammate ];
        }
        
        if ( !arraycontains( teammate.firesaleforplayers, teammate ) )
        {
            teammate.firesaleforplayers[ teammate.firesaleforplayers.size ] = teammate;
        }
        
        if ( teammate.common_kiosk == teammate )
        {
            br_common_kiosk::function_8c37d124818e1233( teammate, "black_market" );
        }
    }
}

// Namespace br_black_market
// Params 0, eflags: 0x4
// Checksum 0xb16491bb, Offset: 0x39f5
// Size: 0xdf
function private call_nuke()
{
    level endon( #"game_ended" );
    level endon( #"disconnect" );
    points::doscoreevent( #"ss_nuke_deployed" );
    var_54a3cc7eee03047e = 10;
    setomnvar( "ui_nuke_timer_type", 0 );
    setomnvar( "ui_nuke_countdown_active", 1 );
    setomnvar( "ui_nuke_player_id", self getentitynumber() );
    level thread function_eccdf38a6677d307( var_54a3cc7eee03047e );
    level thread function_431e3311dc37ae00( var_54a3cc7eee03047e );
    wait 9;
    level thread launch_drone( ( -13980, 14097, 6000 ), ( -201, -7966, 44 ) );
    wait 3;
    level thread nuke_deathblur();
    wait 2;
    nuke_explosion( ( -201, -7966, 44 ) );
    wait 3;
    level thread function_cf31c9e72de21e97();
    wait 0.3;
    level thread nuke_death( self );
    wait 3;
    level thread function_982fb2743014a601( self );
}

// Namespace br_black_market
// Params 1
// Checksum 0x1cf28b6a, Offset: 0x3adc
// Size: 0xc7
function function_eccdf38a6677d307( traveltime )
{
    level endon( #"game_ended" );
    level endon( #"disconnect" );
    level endon( #"nuke_cancelled" );
    level endon( #"hash_44e31ad9646385b5" );
    var_d83f0fd6ab64c192 = int( traveltime * 1000 + gettime() );
    setomnvar( "ui_nuke_end_milliseconds", var_d83f0fd6ab64c192 );
    level waittill( #"host_migration_begin" );
    timepassed = 0;
    
    if ( utility::issharedfuncdefined( #"nuke", #"hostmigration_waittillhostmigrationdone" ) )
    {
        timepassed = [[ utility::getsharedfunc( #"nuke", #"hash_f4ef4debbc3f9f35" ) ]]();
    }
    
    if ( timepassed > 0 )
    {
        setomnvar( "ui_nuke_end_milliseconds", var_d83f0fd6ab64c192 + timepassed );
    }
}

// Namespace br_black_market
// Params 1, eflags: 0x4
// Checksum 0xe7facc47, Offset: 0x3bab
// Size: 0x29
function private function_431e3311dc37ae00( delay )
{
    level endon( #"nuke_cancelled" );
    
    if ( delay > 0 )
    {
        wait delay;
    }
    
    function_fbd83ac3c8000c91();
}

// Namespace br_black_market
// Params 0
// Checksum 0xcfe3083d, Offset: 0x3bdc
// Size: 0xe
function function_fbd83ac3c8000c91()
{
    setomnvar( "ui_nuke_countdown_active", -1 );
}

// Namespace br_black_market
// Params 2
// Checksum 0x95cf9ceb, Offset: 0x3bf2
// Size: 0xbd
function launch_drone( var_2801f7da37580e7e, baseexplosionpoint )
{
    level endon( #"game_ended" );
    dronemodel = "veh9_mil_air_large_drone_mp";
    drone = spawn( "script_model", var_2801f7da37580e7e );
    drone setmodel( dronemodel );
    drone setcandamage( 0 );
    drone.angles = vectortoangles( ( baseexplosionpoint[ 0 ], baseexplosionpoint[ 1 ], 0 ) - ( var_2801f7da37580e7e[ 0 ], var_2801f7da37580e7e[ 1 ], 0 ) );
    drone setscriptablepartstate( #"engine", #"on", 0 );
    drone moveto( baseexplosionpoint + ( 0, 0, var_2801f7da37580e7e[ 2 ] ) + anglestoforward( drone.angles ) * 120000, 20 );
}

// Namespace br_black_market
// Params 1
// Checksum 0xc7e4c83a, Offset: 0x3cb7
// Size: 0x34
function nuke_explosion( where )
{
    playfxanydistance( utility::getfx( "black_market_nuke_explosion" ), where );
    earthquake( 0.8, 5, where, 150000 );
}

// Namespace br_black_market
// Params 0
// Checksum 0xd1a5c954, Offset: 0x3cf3
// Size: 0x94
function nuke_deathblur()
{
    foreach ( character in level.characters )
    {
        if ( isplayer( character ) )
        {
            if ( player::isreallyalive( character ) )
            {
                character visionsetnakedforplayer( "nuke_deathblur", 4 );
            }
        }
    }
}

// Namespace br_black_market
// Params 0
// Checksum 0x99cef981, Offset: 0x3d8f
// Size: 0x137
function nuke_vision()
{
    visionsetnaked( "nuke_global_flash", 0.05 );
    setdvar( @"hash_d18838f3e4b65d16", 0 );
    
    if ( utility::issharedfuncdefined( #"nuke", #"hash_f4ef4debbc3f9f35" ) )
    {
        [[ utility::getsharedfunc( #"nuke", #"hash_f4ef4debbc3f9f35" ) ]]( 0.5 );
    }
    
    level thread function_5c04b3eec5073e8e( 1, 2 );
    level waittill( #"hash_44e31ad9646385b5" );
    wait 1;
    
    if ( !level.var_4389235061115e3a )
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player setclientomnvar( "ui_world_fade", 1 );
            level thread game_utility::fadetoblackforplayer( player, 0, 0.25 );
        }
    }
    
    level.nukeinfo.visioninprogress = 0;
}

// Namespace br_black_market
// Params 2
// Checksum 0xda86952d, Offset: 0x3ece
// Size: 0x59
function function_5c04b3eec5073e8e( var_d174c51744023a2f, var_f1056821009d3dce )
{
    if ( utility::issharedfuncdefined( #"nuke", #"hash_f4ef4debbc3f9f35" ) )
    {
        [[ utility::getsharedfunc( #"nuke", #"hash_f4ef4debbc3f9f35" ) ]]( var_d174c51744023a2f );
    }
    
    visionsetnaked( "", var_f1056821009d3dce );
}

// Namespace br_black_market
// Params 0
// Checksum 0x40005206, Offset: 0x3f2f
// Size: 0xb0
function function_cf31c9e72de21e97()
{
    setomnvarforallclients( "post_game_state", 11 );
    
    foreach ( player in level.players )
    {
        var_947bb4706c5ccfaa = player hud_util::function_cd054751d2d5b5c5( "white" );
        var_947bb4706c5ccfaa thread hud_util::function_d69ae82e9a4716aa( player, 0.3, 10, 2, 1 );
    }
}

// Namespace br_black_market
// Params 1
// Checksum 0x6465b355, Offset: 0x3fe7
// Size: 0x116
function nuke_death( owner )
{
    level endon( #"game_ended" );
    level notify( #"hash_44e31ad9646385b5" );
    
    foreach ( character in level.characters )
    {
        if ( isplayer( character ) )
        {
            character.nuked = 1;
            
            if ( player::isreallyalive( character ) )
            {
                character dodamage( 999999, ( -201, -7966, 44 ), owner, undefined, "MOD_EXPLOSIVE", undefined, "none" );
            }
        }
    }
    
    wait 1;
    
    if ( utility::issharedfuncdefined( #"nuke", #"hash_41868e03ee00f30d" ) )
    {
        [[ utility::getsharedfunc( #"nuke", #"hash_41868e03ee00f30d" ) ]]();
    }
}

// Namespace br_black_market
// Params 1
// Checksum 0x3f757c47, Offset: 0x4105
// Size: 0xda
function function_982fb2743014a601( winner )
{
    winning_team = winner.team;
    level thread function_b9689ae0ce27fae5();
    
    foreach ( player in level.players )
    {
        player.br_spectatorinitialized = 1;
    }
    
    music_br::function_a7fb040e884f8833( level.players );
    gamelogic_mp::endgame( winning_team, game[ "end_reason" ][ "Warzone Victory" ], game[ "end_reason" ][ "Warzone Victory" ] );
}

// Namespace br_black_market
// Params 0
// Checksum 0xcb6e69f8, Offset: 0x41e7
// Size: 0x2e
function function_b9689ae0ce27fae5()
{
    if ( getdvarint( @"scr_br_winners_circle_enabled", 0 ) )
    {
        wait 6;
        level.br_circle.dangercircleent delete();
    }
}

/#

    // Namespace br_black_market
    // Params 0
    // Checksum 0x1bc2b22b, Offset: 0x421d
    // Size: 0xf4, Type: dev
    function debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:xa3>" );
        devgui::add_devgui_func( "<dev string:xb4>", "<dev string:xcc>", &function_a18177285d64ee5a );
        devgui::add_devgui_func( "<dev string:xef>", "<dev string:x104>", &function_da8e0a0c8e53d7d8 );
        devgui::add_devgui_func( "<dev string:x12c>", "<dev string:x141>", &function_c8753fa20fe58a30 );
        devgui::add_devgui_func( "<dev string:x169>", "<dev string:x17c>", &debug_spawn_black_market );
        devgui::add_devgui_func( "<dev string:x1a2>", "<dev string:x1bb>", &function_57a297379a347c56 );
        devgui::add_devgui_func( "<dev string:x1da>", "<dev string:x1f5>", &function_7658df49485205a1 );
        devgui::add_devgui_func( "<dev string:x216>", "<dev string:x228>", &function_9bb13e0646fdde04 );
        devgui::add_devgui_func( "<dev string:x24d>", "<dev string:x25d>", &function_1296b318072a1b85 );
        devgui::add_devgui_func( "<dev string:x280>", "<dev string:x28d>", &function_985e3d4fa70acb90 );
        devgui::add_devgui_func( "<dev string:x2ad>", "<dev string:x2b9>", &function_dcc1a2d1725a4f7f );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_black_market
    // Params 0
    // Checksum 0x73ac1dc3, Offset: 0x4319
    // Size: 0x108, Type: dev
    function function_a18177285d64ee5a()
    {
        foreach ( dompoint in level.var_ab06be8f65123f71.var_9806c23721298384 )
        {
            sphere( dompoint.origin, 80, ( 0, 1, 0 ), 0, 5000 );
            payload = [ #"teamselect", level.players[ 0 ].team ];
            dompoint = spawnscriptable( "<dev string:x2d8>", dompoint.origin, dompoint.angles, undefined, payload );
            dompoint setscriptablepartstate( "<dev string:x2e5>", "<dev string:x2f0>" );
        }
    }

    // Namespace br_black_market
    // Params 0
    // Checksum 0x216fef76, Offset: 0x4429
    // Size: 0x12e, Type: dev
    function function_da8e0a0c8e53d7d8()
    {
        team = level.players[ 0 ].team;
        level.var_ab06be8f65123f71.var_ecea9a714729f7e2[ team ]++;
        
        if ( level.var_ab06be8f65123f71.var_ecea9a714729f7e2[ team ] > 3 )
        {
            level.var_ab06be8f65123f71.var_ecea9a714729f7e2[ team ] = 3;
        }
        
        foreach ( teammate in teams::getteamdata( team, "<dev string:x2f7>" ) )
        {
            teammate.overrideindex = get_buy_station_index( level.var_ab06be8f65123f71.var_ecea9a714729f7e2[ team ] );
            teammate setclientomnvar( "<dev string:x2ff>", level.var_ab06be8f65123f71.var_ecea9a714729f7e2[ team ] );
        }
    }

    // Namespace br_black_market
    // Params 0
    // Checksum 0xf8ea4079, Offset: 0x455f
    // Size: 0x12e, Type: dev
    function function_c8753fa20fe58a30()
    {
        team = level.players[ 0 ].team;
        level.var_ab06be8f65123f71.var_ecea9a714729f7e2[ team ]--;
        
        if ( level.var_ab06be8f65123f71.var_ecea9a714729f7e2[ team ] < 1 )
        {
            level.var_ab06be8f65123f71.var_ecea9a714729f7e2[ team ] = 1;
        }
        
        foreach ( teammate in teams::getteamdata( team, "<dev string:x2f7>" ) )
        {
            teammate.overrideindex = get_buy_station_index( level.var_ab06be8f65123f71.var_ecea9a714729f7e2[ team ] );
            teammate setclientomnvar( "<dev string:x2ff>", level.var_ab06be8f65123f71.var_ecea9a714729f7e2[ team ] );
        }
    }

    // Namespace br_black_market
    // Params 0
    // Checksum 0x76230d1, Offset: 0x4695
    // Size: 0x59, Type: dev
    function debug_spawn_black_market()
    {
        v_spawn_pos = devgui::function_97024c0a6d1256a6();
        bundle = common_item::function_cf68ad18114498b2( "<dev string:x314>" );
        spawn_options = common_item::function_bc5ff2958b71a708( v_spawn_pos );
        spawn_options.critical = 1;
        common_item::function_61c2c0251e742ffd( bundle, 1, spawn_options );
    }

    // Namespace br_black_market
    // Params 0
    // Checksum 0x844cede5, Offset: 0x46f6
    // Size: 0x17, Type: dev
    function function_57a297379a347c56()
    {
        function_e98a42ce1084203f( level.players[ 0 ] );
    }

    // Namespace br_black_market
    // Params 0
    // Checksum 0x5480152c, Offset: 0x4715
    // Size: 0x103, Type: dev
    function function_7658df49485205a1()
    {
        level.players[ 0 ] setclientomnvar( "<dev string:x335>", 0 );
        level.players[ 0 ] setclientomnvar( "<dev string:x2ff>", 0 );
        level.players[ 0 ].index = 0;
        level.players[ 0 ].overrideindex = 0;
        level.var_ab06be8f65123f71.var_ecea9a714729f7e2[ level.players[ 0 ].team ] = undefined;
        level.var_ab06be8f65123f71.var_6c70feef73807c5e[ level.players[ 0 ].team ] = undefined;
        level.var_ab06be8f65123f71.teamobjectives[ level.players[ 0 ].team ] = undefined;
        level.var_ab06be8f65123f71.var_603ef34f57ab1318[ level.players[ 0 ].team ] = undefined;
    }

    // Namespace br_black_market
    // Params 0
    // Checksum 0x4b74145, Offset: 0x4820
    // Size: 0xd7, Type: dev
    function function_9bb13e0646fdde04()
    {
        team = level.players[ 0 ].team;
        hitlist_fail( team );
        
        switch ( level.var_ab06be8f65123f71.var_ecea9a714729f7e2[ team ] )
        {
            case 1:
                level.players[ 0 ] assign_objectives( level.var_ab06be8f65123f71.var_b9ca7ed059dcda9d.hitlistactivitylist, 3, 300, 1 );
                break;
            case 2:
                level.players[ 0 ] assign_objectives( level.var_ab06be8f65123f71.var_b9ca7bd059dcd404.hitlistactivitylist, 2, 420, 2 );
                break;
        }
    }

    // Namespace br_black_market
    // Params 0
    // Checksum 0x99db8fe8, Offset: 0x48ff
    // Size: 0x21, Type: dev
    function function_1296b318072a1b85()
    {
        function_f9dcb00da5756876( level.players[ 0 ].team );
    }

    // Namespace br_black_market
    // Params 0
    // Checksum 0x621753b9, Offset: 0x4928
    // Size: 0x21, Type: dev
    function function_985e3d4fa70acb90()
    {
        hitlist_fail( level.players[ 0 ].team );
    }

    // Namespace br_black_market
    // Params 0
    // Checksum 0x9fde1887, Offset: 0x4951
    // Size: 0x17, Type: dev
    function function_dcc1a2d1725a4f7f()
    {
        level.players[ 0 ] thread call_nuke();
    }

#/

// Namespace br_black_market
// Params 2
// Checksum 0x410ec38c, Offset: 0x4970
// Size: 0xdd
function function_d0ce10fed55911e2( team, string )
{
    teamnames = [];
    
    foreach ( teammate in teams::getteamdata( team, "players" ) )
    {
        teamnames[ teamnames.size ] = teammate.name;
    }
    
    if ( getdvarint( @"scr_br_black_market_debug", 0 ) )
    {
        logstring( "[SHADOWLINK][TEAM: " + string( team ) + " - " + string( teamnames ) + "] " + string );
    }
}

// Namespace br_black_market
// Params 2
// Checksum 0xbf9e8d24, Offset: 0x4a55
// Size: 0x61
function function_a6e814bae308291a( player, string )
{
    if ( getdvarint( @"scr_br_black_market_debug", 0 ) )
    {
        logstring( "[SHADOWLINK][TEAM: " + string( player.team ) + "]" + "[PLAYER: " + player.name + "] " + string );
    }
}

// Namespace br_black_market
// Params 3
// Checksum 0x5cfab61, Offset: 0x4abe
// Size: 0x5c
function function_89707e63629ff7e6( team, varianttag, string )
{
    if ( getdvarint( @"scr_br_black_market_debug", 0 ) )
    {
        logstring( "[SHADOWLINK][TEAM: " + string( team ) + "]" + "[" + string( varianttag ) + "] " + string );
    }
}

