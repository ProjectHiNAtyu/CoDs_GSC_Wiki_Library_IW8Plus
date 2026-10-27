// scripts\mp\events.gsc  (hash_66cf1fb5a503dc23.gscc) (size: 168693 Bytes / 0x292f5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7ce06148 (2095079752)
// size ...... 168693 (0x292f5)
// includes .. 68  (offset: 0x25cf9)
// strings ... 538 (offset: 0x25f19)
// dev strs .. 33  (offset: 0x2900d)
// exports ... 212 (offset: 0x1e289)
// cseg ...... 0x2e1e + 0x1b46b (0x1e289)
// imports ... 572 (offset: 0x203a9)
// animtree1 . 0   (offset: 0x292f5)
// animtree2 . 0   (offset: 0x292f5)
#using script_3e14de319bce19ea;
#using script_52a473ac9352028b;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\killstreaks\killstreak_common;
#using scripts\common\math;
#using scripts\common\script;
#using scripts\common\telemetry_utils;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\weapon;
#using scripts\mp\ai_fortress;
#using scripts\mp\armor;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_challenges;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_elite_broken_arrow;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\calloutmarkerping_mp;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\codcaster_utils;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\equipment\snapshot_grenade;
#using scripts\mp\common\gameobjects\gameobjects_shared;
#using scripts\mp\common\killstreaks\helper_drone;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\killstreaks\uav_bigmap;
#using scripts\mp\common\utility\combat_feed_utility;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\gameplay_telemetry_utils;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\train_utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\crossbow;
#using scripts\mp\damage;
#using scripts\mp\dragonsbreath;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameplay_telemetry;
#using scripts\mp\gamescore;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\operator;
#using scripts\mp\persistence;
#using scripts\mp\poi;
#using scripts\mp\potg;
#using scripts\mp\potg_events;
#using scripts\mp\rank;
#using scripts\mp\stat_limits;
#using scripts\mp\supers;
#using scripts\mp\telemetry_mp;
#using scripts\mp\weapons;

#namespace events;

// Namespace events
// Params 0
// Checksum 0x1b412572, Offset: 0x2e3c
// Size: 0xe97
function events_init()
{
    assert( !level.var_575a4cf40e046954 );
    
    if ( !flags::gameflagexists( "score_event_init_done" ) )
    {
        flags::gameflaginit( "score_event_init_done", 0 );
    }
    
    utility::registersharedfunc( #"score", #"hash_648cdd5826fc187f", &gamescore::gethighestscoringplayer );
    utility::registersharedfunc( #"score", #"hash_a9494f7ac7475784", &gamescore::getplayerscore );
    utility::registersharedfunc( #"score", #"hash_511496dd113f1fa1", &gamescore::function_78736ecffb73080c );
    utility::registersharedfunc( #"score", #"hash_a9ff7e9bcd6dbdfc", &gamescore::function_28debfd611d37dfb );
    utility::registersharedfunc( #"score", #"hash_f25d0d135ca8808c", &gamescore::function_495db9d10bdbdfbb );
    utility::registersharedfunc( #"score", #"hash_be7000c0c6f5884b", &gamescore::function_c5118def88a4bf90 );
    utility::registersharedfunc( #"potg", #"hash_6a8709bef8e57ab5", &potg::getcurpotgscene );
    utility::registersharedfunc( #"potg", #"hash_4a396cb5b36ca065", &potg::shouldskippotg );
    utility::registersharedfunc( #"potg", #"hash_8d0103993c2d120d", &potg::function_4758d0aee5ea85d0 );
    utility::registersharedfunc( #"winners_circle", #"hash_dc7b792b18c4e3e3", &winners_circle::function_ede1c1983085636c );
    level callback::add( #"player_connect", &function_58c92a4e72661f10 );
    level callback::add( #"player_spawned", &function_58c92a4e72661f10 );
    
    if ( level.brgametype.var_9436e1a1f5ddc646 )
    {
        utility::registersharedfunc( #"gametype", #"hash_b5a77ed63d3b12cb", &function_58c92a4e72661f10 );
    }
    
    level.var_3b9a9fba6a6a8562 = randomint( 100 ) <= getdvarint( @"hash_150d20061bff5f6a", 0 );
    level.var_931ca47cc298f7af = #"display_xp";
    bundle = function_d9ef32b02c3cf6f9();
    level.var_86aeeda9e33aa0b9 = level.gamemodebundle.var_86aeeda9e33aa0b9 ?? 0;
    level.multikilltimeout = level.scoreeventglobals.var_850458ede9d50390 ?? 4;
    level.var_36cf9f43f205635c = level.gamemodebundle.var_36cf9f43f205635c ?? 0;
    level.var_dd30bf39c0753f31 = level.gamemodebundle.var_dd30bf39c0753f31 && !getdvarint( @"hash_b52185dbb2d9067c", 0 ) ?? 0;
    
    if ( level.gamemodebundle.var_bd71a3586ad57e2a && !level.gametypebundle.var_5faf6cfd03fd63a1 && getdvarint( @"hash_c3a0d5544cc92de0", 1 ) )
    {
        level.var_a7b7f3866fe6bf21 = { #eightkills:level.gamemodebundle.var_3cdcec9e9f3adb2f ?? level.gametypebundle.var_3cdcec9e9f3adb2f, #sevenkills:level.gamemodebundle.var_542c995c1a52b7b9 ?? level.gametypebundle.var_542c995c1a52b7b9, #sixkills:level.gamemodebundle.var_bc61b5e0568314e0 ?? level.gametypebundle.var_bc61b5e0568314e0, #fivekills:level.gamemodebundle.var_963f01767c96a8c6 ?? level.gametypebundle.var_963f01767c96a8c6, #fourkills:level.gamemodebundle.var_e0f764b70beba036 ?? level.gametypebundle.var_e0f764b70beba036, #threekills:level.gamemodebundle.var_d829b9e7c26bb3a0 ?? level.gametypebundle.var_d829b9e7c26bb3a0, #twokills:level.gamemodebundle.var_44ecc6e7e17adb4a ?? level.gametypebundle.var_44ecc6e7e17adb4a, #delay:level.gamemodebundle.var_1042f084e093794 ?? level.gametypebundle.var_1042f084e093794 };
    }
    
    function_8f156c73f7efd1f0();
    level.var_299faa498c02cc0d = 1;
    
    if ( isdefined( bundle ) )
    {
        level.var_42ae619a2b6c37ba = 1;
        
        if ( getdvarint( @"hash_67732a16075db2c3", 0 ) > 0 )
        {
            level.var_42ae619a2b6c37ba = 0;
        }
        
        if ( level.var_42ae619a2b6c37ba )
        {
            wait 0.5;
        }
        
        level.var_661f7037ece52b6 = 0;
        
        foreach ( entry in bundle.var_3a30a5373af42578 )
        {
            function_425d86de430a44f1( entry );
        }
        
        foreach ( entry in bundle.core_score_events )
        {
            function_592cb76dd6724256( entry );
        }
        
        foreach ( entry in bundle.combat_score_events )
        {
            function_592cb76dd6724256( entry );
        }
        
        foreach ( entry in bundle.gametype_score_events )
        {
            function_592cb76dd6724256( entry );
        }
        
        foreach ( entry in bundle.ammo_mod_score_events )
        {
            function_592cb76dd6724256( entry );
        }
        
        foreach ( entry in bundle.vehicle_score_events )
        {
            function_592cb76dd6724256( entry );
        }
        
        foreach ( entry in bundle.extra_score_events )
        {
            function_592cb76dd6724256( entry );
        }
        
        foreach ( entry in bundle.medal_score_events )
        {
            function_592cb76dd6724256( entry );
        }
        
        foreach ( entry in bundle.var_fbdb32d92f470b05 )
        {
            function_592cb76dd6724256( entry );
        }
        
        foreach ( entry in bundle.var_b1fe08bb5ed46ee3 )
        {
            function_592cb76dd6724256( entry );
        }
        
        foreach ( entry in bundle.br_score_events )
        {
            function_592cb76dd6724256( entry );
        }
        
        foreach ( entry in bundle.equipment_score_events )
        {
            function_592cb76dd6724256( entry );
        }
        
        foreach ( entry in bundle.zombie_score_events )
        {
            function_592cb76dd6724256( entry );
        }
        
        foreach ( entry in bundle.var_8e81e4bfb75731c3 )
        {
            function_592cb76dd6724256( entry );
        }
        
        foreach ( entry in bundle.var_b1ff153be4a4de3b )
        {
            function_592cb76dd6724256( entry );
        }
        
        foreach ( entry in bundle.var_bdb1f0a649260f25 )
        {
            function_592cb76dd6724256( entry );
        }
        
        foreach ( entry in bundle.var_93f44c8ffb48f327 )
        {
            function_592cb76dd6724256( entry );
        }
        
        foreach ( entry in bundle.nonlethal_score_events )
        {
            function_592cb76dd6724256( entry );
        }
        
        foreach ( entry in bundle.soldier_score_events )
        {
            function_592cb76dd6724256( entry );
        }
        
        foreach ( entry in bundle.var_e65d1f4d4a77e9f4 )
        {
            function_592cb76dd6724256( entry );
        }
        
        foreach ( entry in bundle.var_98f7bcfa5c90fe96 )
        {
            function_592cb76dd6724256( entry );
        }
    }
    
    /#
        if ( level.var_30c472db85766e68 > 0 )
        {
            assertmsg( "<dev string:x24>" + level.var_30c472db85766e68 + "<dev string:x40>" );
        }
    #/
    
    level.var_5a58cd2f4c908a34 = undefined;
    level.var_661f7037ece52b6 = undefined;
    level.var_2c244622b9967d24 = undefined;
    level.var_575a4cf40e046954 = 1;
    level.var_64fa056a9a5ed146 = getdvarint( @"hash_db06b3524a2b879d", 1 ) == 1;
    flags::gameflagset( "score_event_init_done" );
}

// Namespace events
// Params 0, eflags: 0x4
// Checksum 0xc08013fd, Offset: 0x3cdb
// Size: 0x353
function private function_d9ef32b02c3cf6f9()
{
    bundlename = level.gametypebundle.scoreeventlist;
    
    if ( !isdefined( bundlename ) )
    {
        return;
    }
    
    level.scoreeventlist = bundlename;
    bundle = getscriptbundle( hashcat( %"scoreeventlist:", bundlename ) );
    
    if ( isdefined( bundle.scoreeventglobals ) )
    {
        level.scoreeventglobals = getscriptbundle( bundle.scoreeventglobals );
        
        if ( isdefined( level.scoreeventglobals.var_8d45834430108e72 ) )
        {
            level.scoreeventglobals.var_9be8154810a6d28b = cos( level.scoreeventglobals.var_8d45834430108e72 );
        }
    }
    
    if ( isdefined( bundle.aartracking ) )
    {
        level.aartracking = getscriptbundle( bundle.aartracking );
    }
    
    if ( isdefined( bundle.stattracking ) )
    {
        level.stattracking = getscriptbundle( bundle.stattracking );
    }
    
    level.var_aaa03c7cc5e4f51c = istrue( bundle.var_15d5bb8588a287b6 );
    level.var_e2148c9fc8f801b1 = istrue( bundle.var_38215eb5700b8063 );
    level.var_7f87aa229a65fa05 = bundle.var_7f87aa229a65fa05;
    
    if ( isdefined( bundle ) )
    {
        if ( bundle.var_fe31eee53e0b0733 )
        {
            level.var_931ca47cc298f7af = #"display_score";
        }
        
        level.var_7127fbeed683aad8 = istrue( bundle.var_7127fbeed683aad8 );
        level.var_296253a91eeebfc6 = istrue( bundle.var_296253a91eeebfc6 );
        level.var_1296ae9926d4d5c5 = istrue( bundle.var_1b15df7763fd8887 );
        level.var_8496aaa2d651af50 = istrue( bundle.var_8496aaa2d651af50 );
        level.var_af0045e470655ee = istrue( bundle.var_af0045e470655ee );
        level.var_4efbde520ba90867 = istrue( bundle.var_4efbde520ba90867 );
        level.var_d8f972bdc4f3a553 = istrue( bundle.var_d8f972bdc4f3a553 );
        level.var_ad9c707dd7d69f42 = bundle.var_ad9c707dd7d69f42 ?? getdvarfloat( @"scr_splash_kill_buffer", 0.25 );
        level.var_23730bd6be76cb84 = istrue( bundle.var_23730bd6be76cb84 );
        supers_mp::function_4f3849ddacf0b0c0( bundle.var_55f5ea554bfe390a );
        supers_mp::function_a57064278d4e8136( bundle.var_9495a85e17711b0f );
        supers_mp::function_f8580c22ea1b1d30( bundle );
        level.var_c03337b0d81a9e27 = [];
        level.var_399a49f01414bc69 = [];
        
        foreach ( entry in bundle.var_a931fefee54613d4 )
        {
            if ( isdefined( entry.weapon ) )
            {
                level.var_399a49f01414bc69[ entry.weapon ] = entry.postfix;
            }
        }
        
        /#
            if ( getdvarint( @"hash_34d5471aab291648", 0 ) )
            {
                level.var_b1618c674f7a4fbc = 1;
                level.var_30c472db85766e68 = 0;
                level.var_97036200d820abc = [];
            }
        #/
    }
    
    return bundle;
}

// Namespace events
// Params 1
// Checksum 0x44ec50f, Offset: 0x4037
// Size: 0x7e
function function_58c92a4e72661f10( params )
{
    self notify( #"hash_b764082c493f2e9c" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_b764082c493f2e9c" );
    level endon( #"game_ended" );
    childthread function_a25e4c9216ef1c73();
    
    while ( true )
    {
        utility::waittill_any( "skydive_beginfreefall", "skydive_deployparachute" );
        self.var_8e388104c7c4d011 = 1;
        
        while ( !self isonground() )
        {
            waitframe();
        }
        
        self.var_8e388104c7c4d011 = undefined;
    }
}

// Namespace events
// Params 0, eflags: 0x4
// Checksum 0xdcec197c, Offset: 0x40bd
// Size: 0x19c
function private function_a25e4c9216ef1c73()
{
    if ( !level.var_3b9a9fba6a6a8562 )
    {
        return;
    }
    
    player = self;
    player.parachutefreefall = spawnstruct();
    player.parachutefreefall.data = [];
    
    while ( true )
    {
        player utility::waittill_any( "skydive_beginfreefall", "skydive_deployparachute" );
        var_c0b94fa08f8939d0 = gettime();
        
        while ( !player isonground() )
        {
            index = player.parachutefreefall.data.size;
            
            if ( player jumpbuttonpressed() && index < 5 && gettime() - ( player.parachutefreefall.data[ player.parachutefreefall.data.size - 1 ].jumpbuttonpressed ?? 0 ) >= 1000 )
            {
                player.parachutefreefall.data[ index ] = spawnstruct();
                player.parachutefreefall.data[ index ].isparachutedeployed = player isparachutedeployed();
                player.parachutefreefall.data[ index ].playerorigin = player.origin;
                player.parachutefreefall.data[ index ].jumpbuttonpressed = gettime();
            }
            
            waitframe();
        }
        
        function_805da575b84b8feb( index, var_c0b94fa08f8939d0 );
    }
}

// Namespace events
// Params 2, eflags: 0x4
// Checksum 0xadcef892, Offset: 0x4261
// Size: 0x24c
function private function_805da575b84b8feb( index, var_c0b94fa08f8939d0 )
{
    player = self;
    playerx = "";
    playery = "";
    var_10f50841c4b80477 = "";
    jumpbuttonpressed = "";
    
    foreach ( var_bd991995576b0c29 in player.parachutefreefall.data )
    {
        playerx += int( var_bd991995576b0c29.playerorigin[ 0 ] ) + "|";
        playery += int( var_bd991995576b0c29.playerorigin[ 1 ] ) + "|";
        var_10f50841c4b80477 += int( var_bd991995576b0c29.playerorigin[ 2 ] ) + "|";
        jumpbuttonpressed += int( var_bd991995576b0c29.jumpbuttonpressed / 1000 ) + "|";
    }
    
    eventparams = [ "player_x", playerx ?? "", "player_y", playery ?? "", "player_z", var_10f50841c4b80477 ?? "", "button_presses", jumpbuttonpressed ?? "", "dive_started_time", int( var_c0b94fa08f8939d0 / 1000 ) ?? -1, "player_health_landing", int( ( player.health ?? 0 ) + ( player.armorhealth ?? 0 ) ) ?? -1, "player_z_landing", int( player.origin[ 2 ] ) ?? 0 ];
    player.parachutefreefall.data = [];
    player dlog_recordplayerevent( "dlog_event_br_skydiving_parachute", eventparams );
}

// Namespace events
// Params 0, eflags: 0x4
// Checksum 0x4ad05da0, Offset: 0x44b5
// Size: 0x68
function private function_99b39ccaca1605d1()
{
    if ( !level.var_42ae619a2b6c37ba )
    {
        return;
    }
    
    level.var_661f7037ece52b6++;
    
    if ( !isdefined( level.var_5a58cd2f4c908a34 ) )
    {
        level.var_5a58cd2f4c908a34 = 25 * int( ( level.frameduration ?? 16 ) / 16 );
    }
    
    if ( level.var_661f7037ece52b6 >= level.var_5a58cd2f4c908a34 )
    {
        waitframe();
        level.var_661f7037ece52b6 = 0;
    }
}

// Namespace events
// Params 0, eflags: 0x4
// Checksum 0x77d8586a, Offset: 0x4525
// Size: 0x227
function private function_8f156c73f7efd1f0()
{
    utility::registersharedfunc( #"event", #"predatormissileimpact", &predatormissileimpact );
    utility::registersharedfunc( #"event", #"largevehicleexplosion", &largevehicleexplosion );
    utility::registersharedfunc( #"event", #"vehiclekilled", &vehiclekilled );
    utility::registersharedfunc( #"event", #"missilefired", &missilefired );
    level._effect[ "money" ] = loadfxasset( "vfx_props_cash_player_drop" );
    level.numkills = 0;
    level thread onplayerconnect();
    level thread monitorhealed();
    callback::add( #"stance_changed", &stancechanged );
    callback::add( #"stance_changed_post", &function_cc7a5f0c4d025998 );
    callback::add( #"jump_begin", &jumpbegin );
    callback::add( #"mantle_begin", &mantlebegin );
    callback::add( #"dtp_begin", &dtpbegin );
    callback::add( #"dtp_end", &dtpend );
    callback::add( #"sprint_end", &function_36163635c67da3c8 );
    callback::add( #"sprint_slide_end", &function_cead7db776b55e91 );
    callback::add( #"player_in_air_begin", &function_e7302a4eea4a864 );
    callback::add( #"game_ended", &function_4a14466bed488cff );
    callback::add( #"player_death", &onplayerdeath );
    callback::add( #"hash_244314ef9125e636", &function_a34aef984160a893 );
    callback::add( #"player_spawned", &onplayerspawned );
    callback::add( #"hash_3f03a307b9f6e227", &function_c166f426bdb7d385 );
    callback::add( #"wall_jump_begin", &function_dd71e90754bceb20 );
    callback::add( #"wall_jump_end", &function_1d54cd7f3204eec );
    callback::add( #"active_roll_begin", &function_cdeebfff9fd3743f );
    callback::add( #"hash_ad99e3d3c9ff54f1", &function_1749a2f53f8cd2b7 );
}

// Namespace events
// Params 1
// Checksum 0x13f5220, Offset: 0x4754
// Size: 0x97
function onplayerspawned( params )
{
    self.var_27a561637e13dd5c = undefined;
    self.offscreenattackers = undefined;
    self.var_58b9cb211fef48bb = undefined;
    self.var_7e5719799a02450d = undefined;
    self.var_10faec23ca8480f = undefined;
    self.var_e522579e4d7d3ab6 = undefined;
    self.var_b753ecf2305ccb71 = undefined;
    self.var_9b8c24cccee1a519 = undefined;
    thread function_4cbdb04b16893e15();
    thread function_7c73c53116cd9c5c();
    function_989803315095d491();
    
    if ( self.var_61e17fe9b183ff1c )
    {
        self.var_61e17fe9b183ff1c = undefined;
        thread points::doscoreevent( #"hash_a4ee0784ab2279b6" );
    }
}

// Namespace events
// Params 1
// Checksum 0x67fc88f7, Offset: 0x47f3
// Size: 0x1af
function function_a34aef984160a893( deathdata )
{
    attacker = deathdata.attacker;
    victim = deathdata.victim;
    
    if ( !victim || !attacker || attacker == victim )
    {
        return;
    }
    
    if ( player::isreallyalive( attacker ) )
    {
        return;
    }
    
    equipmentref = equipment_mp::getequipmentreffromweapon( deathdata.objweapon );
    inflictor = deathdata.inflictor;
    
    if ( !equipmentref || !inflictor.birthtime )
    {
        return;
    }
    
    equipmentbundle = level.equipment.table[ equipmentref ].bundle;
    
    if ( !isdefined( attacker.var_10faec23ca8480f[ inflictor.birthtime ] ) )
    {
        attacker.var_10faec23ca8480f[ inflictor.birthtime ] = 0;
    }
    
    attacker.var_10faec23ca8480f[ inflictor.birthtime ]++;
    
    if ( attacker.var_10faec23ca8480f[ inflictor.birthtime ] == 2 && equipmentbundle.var_4ff2627931ed4476 )
    {
        attacker thread points::doscoreevent( equipmentbundle.var_4ff2627931ed4476 );
    }
    
    if ( attacker.var_10faec23ca8480f[ inflictor.birthtime ] == 3 )
    {
        attacker.var_e522579e4d7d3ab6[ victim.guid ] = 1;
        
        if ( equipmentbundle.var_206738b1866937e5 )
        {
            attacker thread points::doscoreevent( equipmentbundle.var_206738b1866937e5 );
        }
    }
}

// Namespace events
// Params 1
// Checksum 0x6cbfb18e, Offset: 0x49aa
// Size: 0xbf
function onplayerdeath( deathdata )
{
    function_685429b0b93e2af( deathdata );
    self.var_49c5d9bb5965b473 = 0;
    self.var_15de96d9ab0305b6 = 0;
    self.headshotkillchain = 0;
    self.var_8c767773348195e8 = undefined;
    self.var_dbec57a6f0f50e6c = undefined;
    self.var_2b8afa91907fac59 = undefined;
    self.var_dff35a570cbec5a8 = undefined;
    self.var_b8837774e4fee951 = undefined;
    self.var_65b133d36c961ccc = undefined;
    self.var_308fee31f379a73d = undefined;
    self.var_4e88f6e44ad3dc79 = undefined;
    self.var_b1a7bcec9cf49488 = undefined;
    self.var_5273e52e39429943 = undefined;
    self.var_38810aee0d242063 = undefined;
    self.var_7e5e10a6e6422f11 = undefined;
    self.var_5799a77f18d0229a = undefined;
    self.isactiverolling = undefined;
}

// Namespace events
// Params 0
// Checksum 0xecb8a057, Offset: 0x4a71
// Size: 0x95
function function_4cbdb04b16893e15()
{
    self notify( #"hash_d961d82ab11f2b1" );
    self endon( #"hash_d961d82ab11f2b1" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"execution_begin" );
        self.var_c74f2ae506961460 = 1;
        victim = self getexecutionpartner();
        self.var_49c3ac74099ff5c9 = victim.var_c74f2ae506961460;
        
        while ( self isinexecutionattack() && isalive( victim ) )
        {
            waitframe();
        }
        
        self.var_c74f2ae506961460 = undefined;
        self.var_49c3ac74099ff5c9 = undefined;
    }
}

// Namespace events
// Params 1
// Checksum 0x44fad7ef, Offset: 0x4b0e
// Size: 0x84
function function_425d86de430a44f1( entry )
{
    if ( !isdefined( entry ) )
    {
        return;
    }
    
    ref = entry.ref;
    
    if ( !isdefined( ref ) || ref == "" )
    {
        return;
    }
    
    rank::registerscoreinfomultiplier( ref, entry.multiplier );
    group = entry.group ?? "unassigned";
    rank::registerscoreinfo( ref, #"group", group );
}

// Namespace events
// Params 1
// Checksum 0x24949ecb, Offset: 0x4b9a
// Size: 0x666
function function_592cb76dd6724256( entry )
{
    if ( !isdefined( entry ) )
    {
        return;
    }
    
    /#
        if ( entry.ref )
        {
            if ( getdvarint( @"hash_4b1dea3e40bd7abd", 0 ) )
            {
                if ( level.var_ea7b8ef8e2dbe454[ entry.ref ] )
                {
                    level.var_3055c4aefd33e760[ entry.ref ] = entry.ref;
                    assertmsg( entry.ref + "<dev string:x94>" );
                }
                
                level.var_ea7b8ef8e2dbe454[ entry.ref ] = entry.ref;
            }
        }
    #/
    
    if ( entry.omitted )
    {
        level.var_c03337b0d81a9e27[ entry.ref ] = 1;
        return;
    }
    
    ref = entry.ref;
    
    if ( !isdefined( ref ) || ref == "" )
    {
        return;
    }
    
    function_99b39ccaca1605d1();
    score = entry.score ?? 0;
    xp = entry.xp ?? 0;
    potgscore = entry.potgscore ?? 0;
    var_a89282e1101775a = entry.var_a89282e1101775a ?? 0;
    
    if ( entry.isaward )
    {
        var_e1e00318c069bd4d = 1;
        
        if ( level.var_8496aaa2d651af50 )
        {
            var_ae04295ce2f8914d = isxhashasset( entry.splashbundle );
            
            if ( !var_ae04295ce2f8914d )
            {
                var_e1e00318c069bd4d = 0;
            }
        }
        
        if ( var_e1e00318c069bd4d )
        {
            rank::registerscoreinfo( ref, #"isaward", 1 );
        }
        else
        {
            /#
                if ( level.var_8496aaa2d651af50 )
                {
                    if ( !isdefined( level.var_8981bb8ff0cc678f ) )
                    {
                        level.var_8981bb8ff0cc678f = 0;
                    }
                    
                    level.var_8981bb8ff0cc678f++;
                }
            #/
        }
    }
    
    if ( !entry.forceinit )
    {
        if ( score == 0 && xp == 0 && potgscore == 0 && ( !entry.loadoutxp || !level.var_e2148c9fc8f801b1 ) )
        {
            /#
                if ( level.var_b1618c674f7a4fbc )
                {
                    level.var_97036200d820abc[ level.var_30c472db85766e68 ] = ref;
                    level.var_30c472db85766e68++;
                }
            #/
            
            return;
        }
        
        assert( score >= 0 );
        assert( xp >= 0 );
    }
    
    rank::registerscoreinfo( ref, #"value", score );
    rank::registerscoreinfo( ref, #"xp", xp );
    rank::registerscoreinfo( ref, #"potgscore", potgscore );
    rank::registerscoreinfo( ref, #"hash_ddc6a1b45a3259d9", var_a89282e1101775a );
    
    if ( entry.isobjective )
    {
        rank::registerscoreinfo( ref, #"isobjective", entry.isobjective );
    }
    
    if ( entry.rarity )
    {
        rank::registerscoreinfo( ref, #"rarity", entry.rarity );
    }
    
    if ( entry.momentummultiplier )
    {
        rank::registerscoreinfo( ref, #"momentummultiplier", entry.momentummultiplier );
    }
    
    if ( entry.weaponxpoverride && level.var_aaa03c7cc5e4f51c )
    {
        rank::registerscoreinfo( ref, #"weaponxpoverride", entry.weaponxpoverride );
    }
    
    if ( entry.isteamplay )
    {
        rank::registerscoreinfo( ref, #"isteamplay", entry.isteamplay );
    }
    
    if ( entry.loadoutxp && level.var_e2148c9fc8f801b1 )
    {
        rank::registerscoreinfo( ref, #"loadoutxp", entry.loadoutxp );
    }
    
    supers_mp::function_16ccf60113bf29a9( ref, entry.superpoints );
    var_ae04295ce2f8914d = isxhashasset( entry.splashbundle );
    
    if ( !var_ae04295ce2f8914d )
    {
        function_9b13e8fe0c7de907( ref, hud_message::getsplashtablename() );
    }
    
    group = entry.group ?? "unassigned";
    rank::registerscoreinfo( ref, #"group", group );
    
    if ( !entry.nobonus )
    {
        rank::registerscoreinfo( ref, #"allowbonus", 1 );
    }
    
    if ( entry.var_bda491f912fe911a )
    {
        rank::registerscoreinfo( ref, #"hash_582866801a05178b", 1 );
    }
    
    if ( entry.var_e7696e45bbb0a313 )
    {
        rank::registerscoreinfo( ref, #"hash_6eb465a93205967a", 1 );
    }
    
    if ( entry.var_c9f5190087459c78 )
    {
        rank::registerscoreinfo( ref, #"hash_2322564347237f7", 1 );
    }
    
    if ( entry.streakpoints )
    {
        rank::registerscoreinfo( ref, #"streakPoints", entry.streakpoints );
    }
    
    if ( level.var_296253a91eeebfc6 )
    {
        if ( entry.var_8707d66b753ed072 )
        {
            rank::registerscoreinfo( ref, #"hash_e98734bda1c5c091", 1 );
        }
    }
    
    if ( isdefined( entry.battlechatterevent ) )
    {
        rank::registerscoreinfo( ref, #"battlechatterevent", entry.battlechatterevent );
    }
    
    if ( entry.var_f9819547ca6c7ee0 && combat_feed_utility::function_47a6f06f6300fa18() )
    {
        rank::registerscoreinfo( ref, #"hash_aae7781dce5b709f", entry.var_f9819547ca6c7ee0 );
    }
    
    if ( var_ae04295ce2f8914d )
    {
        var_a66a9d37fb19a4fa = function_43b5ed5a14a56573( #"scriptbundle_splash", entry.splashbundle );
        
        /#
            if ( !isdefined( var_a66a9d37fb19a4fa ) )
            {
                assertmsg( "<dev string:xc1>" + getxhashsourcename( entry.splashbundle ) );
            }
        #/
        
        if ( isdefined( var_a66a9d37fb19a4fa ) )
        {
            rank::registerscoreinfo( ref, #"hash_9ef9bbcd1edc198b", var_a66a9d37fb19a4fa );
            function_6adecb9196c91fed( ref, entry.splashbundle );
            
            if ( level.aartracking.trackmedals && entry.isaward )
            {
                if ( isdefined( level.var_705cfa989075904f ) )
                {
                    [[ level.var_705cfa989075904f ]]( ref, entry.splashbundle );
                }
            }
        }
    }
}

// Namespace events
// Params 2
// Checksum 0xe6b59917, Offset: 0x5208
// Size: 0xf9
function function_9b13e8fe0c7de907( ref, splashtablename )
{
    if ( level.gamemodebundle.var_3ebc79b20ea42a8f )
    {
        return;
    }
    
    splashtablerow = tablelookuprownum( splashtablename, 0, ref );
    
    if ( splashtablerow < 0 )
    {
        return;
    }
    
    rank::registerscoreinfo( ref, #"splashtablerow", splashtablerow );
    text = tablelookup( splashtablename, 0, ref, 2 );
    
    if ( isistring( text ) && text != &"" )
    {
        rank::registerscoreinfo( ref, #"hastext", 1 );
    }
    
    priority = int( tablelookup( splashtablename, 0, ref, 13 ) );
    rank::registerscoreinfo( ref, #"priority", priority );
    var_eb057ab4d77fcc1f = int( tablelookup( splashtablename, 0, ref, 14 ) );
    rank::registerscoreinfo( ref, #"alwaysshowsplash", var_eb057ab4d77fcc1f );
}

// Namespace events
// Params 2
// Checksum 0x4ad9ccba, Offset: 0x5309
// Size: 0x11d
function function_6adecb9196c91fed( ref, var_c00bd564bd0d2789 )
{
    assert( isxhashasset( var_c00bd564bd0d2789 ) );
    
    if ( !isxhashasset( var_c00bd564bd0d2789 ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_2c244622b9967d24 ) )
    {
        level.var_2c244622b9967d24 = [ #"shortName", #"priority", #"alwaysshowsplash" ];
    }
    
    splashbundle = getscriptbundlefieldvalues( var_c00bd564bd0d2789, level.var_2c244622b9967d24 );
    assert( isstruct( splashbundle ) );
    
    if ( !isstruct( splashbundle ) )
    {
        return;
    }
    
    if ( isdefined( splashbundle.shortname ) )
    {
        rank::registerscoreinfo( ref, #"hastext", 1 );
    }
    
    if ( isdefined( splashbundle.priority ) )
    {
        rank::registerscoreinfo( ref, #"priority", splashbundle.priority );
    }
    
    if ( !level.var_7127fbeed683aad8 )
    {
        if ( splashbundle.alwaysshowsplash )
        {
            rank::registerscoreinfo( ref, #"alwaysshowsplash", 1 );
        }
    }
}

// Namespace events
// Params 0
// Checksum 0x745aba16, Offset: 0x542e
// Size: 0x1a
function onplayerspawn()
{
    if ( combat_feed_utility::function_47a6f06f6300fa18() )
    {
        function_d25dde7d87de96d0();
        return;
    }
    
    function_68c7fb18bec9093c();
}

// Namespace events
// Params 0
// Checksum 0xd2441549, Offset: 0x5450
// Size: 0x158
function onplayerconnect()
{
    for ( ;; )
    {
        level waittill( #"connected", player );
        
        if ( !game_utility_mp::lpcfeaturegated() )
        {
            player.killedplayers = [];
            player.killedby = [];
            player.var_dbec57a6f0f50e6c = [];
        }
        
        player.lastkilledby = undefined;
        player.greatestuniqueplayerkills = 0;
        player.recentkillcount = 0;
        player.var_eaf5be39c4590dd = 0;
        player.recentassaultcount = 0;
        player.lastkilltime = 0;
        player.prevlastkilltime = 0;
        player.lastkilldogtime = 0;
        
        if ( !isdefined( player.pers[ "lethalEquipmentKillMask" ] ) )
        {
            player.pers[ "lethalEquipmentKillMask" ] = 0;
        }
        
        player.objectiveachievementkillcount = 0;
        player.damagedplayers = [];
        player thread monitorreload();
        player thread function_28959f334b2c020();
        
        if ( player gameplay_telemetry_utils::function_9f6656b47d8779ee() )
        {
            player thread gameplay_telemetry::function_a2ca0c0d5139a904();
        }
        
        player.lastweaponchangetime = 0;
        player initstancetracking();
        
        if ( getdvarint( @"hash_eba0ce405ac50c64", 0 ) == 1 )
        {
            player setclientdvar( @"cg_everyonehearseveryone", 1 );
        }
    }
}

// Namespace events
// Params 2
// Checksum 0x68554565, Offset: 0x55b0
// Size: 0x51
function damagedplayer( victim, damage )
{
    if ( damage < 50 && damage > 10 )
    {
        level thread battlechatter_mp::saytoself( self, "plr_damaged_light", undefined, 0.1 );
        return;
    }
    
    level thread battlechatter_mp::saytoself( self, "plr_damaged_heavy", undefined, 0.1 );
}

// Namespace events
// Params 2
// Checksum 0x303d6ad2, Offset: 0x5609
// Size: 0x1f
function playerworlddeath( attacker, meansofdeath )
{
    potg_events::playerworlddeath( attacker, meansofdeath );
}

// Namespace events
// Params 4
// Checksum 0x3e54f7bd, Offset: 0x5630
// Size: 0x238
function checkcollateral( victim, objweapon, meansofdeath, weapongroup )
{
    if ( !isdefined( self.killsinaframecount ) )
    {
        self.killsinaframecount = 0;
    }
    
    self.killsinaframecount++;
    thread function_47d814e6b0d5bff();
    
    if ( weaponclass( objweapon ) == "spread" )
    {
        if ( !isdefined( self.shotgunkillsinaframecount ) )
        {
            self.shotgunkillsinaframecount = 0;
        }
        
        self.shotgunkillsinaframecount++;
        
        if ( self.shotgunkillsinaframecount >= 2 )
        {
            return #"hash_dd94fd3bee9e6c50";
        }
    }
    else if ( meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_HEAD_SHOT" )
    {
        var_30100e68dbcd42e = 1;
        
        if ( level.scoreeventglobals.var_c01b1cfa98cc667f && weapongroup != "weapon_sniper" && weapongroup != "weapon_dmr" )
        {
            var_30100e68dbcd42e = 0;
        }
        
        if ( var_30100e68dbcd42e && level.scoreeventglobals.var_3a54abcf7c91606 )
        {
            if ( victim.attackerdata.size >= 1 )
            {
                var_30100e68dbcd42e = 0;
                damagethreshold = victim.maxhealth * 0.9;
                
                foreach ( attackerguid, attackerdata in victim.attackerdata )
                {
                    if ( self.guid == attackerguid && attackerdata.hitcount == 1 && attackerdata.effectivedamage >= damagethreshold )
                    {
                        var_30100e68dbcd42e = 1;
                        break;
                    }
                }
            }
        }
        
        if ( var_30100e68dbcd42e )
        {
            if ( !isdefined( self.bulletkillsinaframecount ) )
            {
                self.bulletkillsinaframecount = 0;
            }
            
            self.bulletkillsinaframecount++;
            
            if ( self.bulletkillsinaframecount >= 2 )
            {
                return #"hash_ba8b5547dfa84580";
            }
        }
    }
    
    return #"nocollateral";
}

// Namespace events
// Params 0
// Checksum 0xa8e81116, Offset: 0x5871
// Size: 0x51
function function_47d814e6b0d5bff()
{
    self notify( #"hash_95433bc7423e933b" );
    self endon( #"hash_95433bc7423e933b" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    waittillframeend();
    self.killsinaframecount = 0;
    self.shotgunkillsinaframecount = 0;
    self.bulletkillsinaframecount = 0;
}

// Namespace events
// Params 5
// Checksum 0x406cc68a, Offset: 0x58ca
// Size: 0x9c
function killedplayernotifysys( killid, victim, objweapon, meansofdeath, weapongroup )
{
    self notify( #"hash_5e4fdc739cff9db5" );
    self endon( #"hash_5e4fdc739cff9db5" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    waittillframeend();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    thread notifykilledplayer( killid, victim, objweapon, meansofdeath, self.killsinaframecount );
    self.killsinaframecount = 0;
    self.bulletkillsinaframecount = 0;
    self.shotgunkillsinaframecount = 0;
}

// Namespace events
// Params 5
// Checksum 0xccaa8c90, Offset: 0x596e
// Size: 0x90
function notifykilledplayer( killid, victim, objweapon, meansofdeath, numkills )
{
    assert( isdefined( objweapon ), "<dev string:x102>" );
    weaponname = undefined;
    
    if ( isweapon( objweapon ) )
    {
        weaponname = getcompleteweaponname( objweapon );
    }
    else
    {
        weaponname = objweapon;
    }
    
    for ( i = 0; i < numkills ; i++ )
    {
        self notify( #"got_a_kill", victim, weaponname, meansofdeath, objweapon );
        waitframe();
    }
}

// Namespace events
// Params 4
// Checksum 0xef0e9e15, Offset: 0x5a06
// Size: 0x68, Type: bool
function attackerisinflictor( attacker, inflictor, objweapon, meansofdeath )
{
    if ( isdefined( inflictor ) )
    {
        if ( isdefined( inflictor.owner ) )
        {
            return ( inflictor.owner == attacker );
        }
        else if ( attackerisinflictorforradiusexplosiveweapon( objweapon, inflictor, meansofdeath ) )
        {
            return true;
        }
        else
        {
            return ( inflictor == attacker );
        }
    }
    
    return true;
}

// Namespace events
// Params 3
// Checksum 0xbe009606, Offset: 0x5a77
// Size: 0x5a, Type: bool
function attackerisinflictorforradiusexplosiveweapon( objweapon, inflictor, meansofdeath )
{
    if ( isdefined( objweapon ) && inflictor.classname == "worldspawn" && meansofdeath == "MOD_EXPLOSIVE" )
    {
        if ( weapon::getweaponrootname( objweapon ) == "iw9_dm_crossbow" )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace events
// Params 5, eflags: 0x4
// Checksum 0x76215bb3, Offset: 0x5ada
// Size: 0x504
function private wasoneshotkill( victim, objweapon, meansofdeath, curtime, weapongroup )
{
    /#
        assert( isdefined( victim ), "<dev string:x12f>" );
        assert( isdefined( objweapon ), "<dev string:x17c>" );
        assert( isdefined( meansofdeath ), "<dev string:x1c9>" );
        assert( isdefined( curtime ), "<dev string:x21e>" );
        assert( isdefined( weapongroup ), "<dev string:x271>" );
    #/
    
    var_a2950569464d68aa = weapon_utility::function_72753cbca8f2699f( objweapon ) && utility::isbulletdamage( meansofdeath );
    var_c147b753f2be0de1 = function_c147b753f2be0de1( objweapon );
    
    if ( !var_c147b753f2be0de1 )
    {
        if ( weapongroup == "other" || weapongroup == "weapon_projectile" || level.scoreeventglobals.var_1b6d2dc5d3d396c9 && !var_a2950569464d68aa )
        {
            return 0;
        }
        
        if ( utility::ismeleedamage( meansofdeath ) || isexplosivedamagemod( meansofdeath ) || utility::ismeatshielddamage( meansofdeath ) )
        {
            return 0;
        }
    }
    
    if ( level.scoreeventglobals.var_3a54abcf7c91606 )
    {
        if ( !isdefined( victim.attackerdata ) || victim.attackerdata.size <= 0 )
        {
            return 0;
        }
        
        damagethreshold = victim.maxhealth * 0.9;
        
        foreach ( attackerguid, attackerdata in victim.attackerdata )
        {
            if ( self.guid === attackerguid && attackerdata.hitcount == 1 && attackerdata.effectivedamage >= damagethreshold )
            {
                return 1;
            }
        }
        
        return 0;
    }
    
    if ( ( level.var_63d1c72ce3422d7a ?? damage_effects::function_15bf270501d22aaa() ) > 2000 )
    {
        assert( isdefined( level.var_9196ec5c24823331 ) );
        selfvalid = 0;
        elsevalid = 0;
        
        foreach ( guid, attackerdata in victim.attackerdata )
        {
            if ( guid == self.guid )
            {
                if ( curtime == attackerdata.firsttimedamaged )
                {
                    selfvalid = 1;
                }
                else
                {
                    break;
                }
                
                continue;
            }
            
            if ( isdefined( attackerdata.lasttimedamaged ) && curtime - attackerdata.lasttimedamaged < level.var_9196ec5c24823331 )
            {
                elsevalid = 1;
                break;
            }
        }
        
        return ( selfvalid && !elsevalid );
    }
    
    if ( isdefined( victim.attackers ) && isdefined( victim.guid ) && victim.attackers.size == 1 && !isdefined( victim.attackers[ victim.guid ] ) )
    {
        /#
            if ( !isdefined( victim.attackers[ self.guid ] ) )
            {
                println( "<dev string:x2c3>" + getcompleteweaponname( objweapon ) );
                println( "<dev string:x2cc>" + meansofdeath );
                println( "<dev string:x2db>" + self.guid + "<dev string:x2eb>" + self.name + "<dev string:x2f4>" );
                i = 0;
                
                foreach ( key, value in victim.attackers )
                {
                    println( "<dev string:x2f6>" + i + "<dev string:x308>" + key + "<dev string:x2eb>" + value.name + "<dev string:x2f4>" );
                    i++;
                }
            }
        #/
        
        assert( isdefined( victim.attackers[ self.guid ] ), "<dev string:x310>" );
        
        if ( victim.attackerdata[ self.guid ].hitcount > 1 && weapon::isakimbo( objweapon ) )
        {
            return 0;
        }
        
        return ( curtime == victim.attackerdata[ self.guid ].firsttimedamaged );
    }
    
    return 0;
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0x89e933d7, Offset: 0x5fe6
// Size: 0x3c
function private function_c147b753f2be0de1( objweapon )
{
    switch ( objweapon.damagemodcategory )
    {
        case #"hash_4d03e91b5478b2bb":
            return 1;
        default:
            return 0;
    }
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0xe15c4ad4, Offset: 0x602a
// Size: 0x6b
function private isprimaryweaponclass( classname )
{
    switch ( classname ?? "" )
    {
        case #"hash_690c0d6a821b42e":
        case #"hash_6191aaef9f922f96":
        case #"hash_8cdaf2e4ecfe5b51":
        case #"hash_900cb96c552c5e8e":
        case #"hash_fa24dff6bd60a12d":
            return 1;
        default:
            return 0;
    }
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0xf095e521, Offset: 0x609d
// Size: 0x20, Type: bool
function private function_17e383a6e7e192bc( classname )
{
    return classname === "pistol" || classname === "launcher";
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0xcf16488c, Offset: 0x60c6
// Size: 0x14, Type: bool
function private function_1b5cd8f204cb4ce3( classname )
{
    return classname === "pistol";
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0xad60a422, Offset: 0x60e3
// Size: 0x18, Type: bool
function private function_f3115d147c20b0f6( classname )
{
    return classname === #"melee";
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0x9a138bbf, Offset: 0x6104
// Size: 0x47
function private function_a3065f3e99b54666( weaponname )
{
    if ( !isdefined( self.var_937fbc0a6fab61e2 ) )
    {
        self.var_937fbc0a6fab61e2 = weaponname;
    }
    
    if ( self.var_937fbc0a6fab61e2 != weaponname )
    {
        self.var_7d8ef959d71d1b1 = 1;
        self.var_937fbc0a6fab61e2 = undefined;
    }
}

// Namespace events
// Params 2, eflags: 0x4
// Checksum 0x7dc523b1, Offset: 0x6153
// Size: 0x126
function private function_167fa0553529a2c5( objweapon, classname )
{
    if ( !isdefined( self ) || weapon::function_597e1c0b6df2fada( objweapon.basename ) )
    {
        return;
    }
    
    switch ( classname )
    {
        case #"hash_2ab98cab4066a74e":
        case #"hash_db653a4972b3c13b":
        case #"hash_e224d0b635d0dadd":
            return;
        case #"hash_690c0d6a821b42e":
        case #"hash_6191aaef9f922f96":
        case #"hash_8cdaf2e4ecfe5b51":
        case #"hash_900cb96c552c5e8e":
        case #"hash_fa24dff6bd60a12d":
            self.var_49c5d9bb5965b473 |= 1;
            break;
        case #"hash_719417cb1de832b6":
            self.var_49c5d9bb5965b473 |= 4;
        case #"hash_61e969dacaaf9881":
        case #"hash_ba39cac9c099d4f1":
            self.var_49c5d9bb5965b473 |= 2;
            break;
        default:
            self.var_49c5d9bb5965b473 |= 8;
            break;
    }
}

// Namespace events
// Params 0
// Checksum 0xc63a90ef, Offset: 0x6281
// Size: 0x18
function function_989803315095d491()
{
    if ( !isdefined( self.var_49c5d9bb5965b473 ) )
    {
        self.var_49c5d9bb5965b473 = 0;
    }
}

// Namespace events
// Params 5
// Checksum 0x77070c0c, Offset: 0x62a1
// Size: 0x143
function function_597384ab825df062( victim, objweapon, meansofdeath, inflictor, deathdata )
{
    if ( isbrgamemode() )
    {
        teamswithplayers = game_utility_mp::function_2d6eda4bd30f6b52();
        
        if ( isdefined( victim ) && isdefined( teamswithplayers ) && teamswithplayers.size == 2 )
        {
            victimteamcount = teams::getteamdata( victim.team, "aliveCount" );
            
            if ( victimteamcount == 0 )
            {
                if ( !isdefined( self.modifiers[ "mask4" ] ) )
                {
                    self.modifiers[ "mask4" ] = 0;
                }
                
                self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"hash_6bdb9eb4eb9d6fab" ) );
            }
        }
        
        numkills = self.pers[ "kills" ];
        
        if ( numkills == 0 )
        {
            self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"hash_9e8bf5b8ef5462f4" ) );
        }
    }
}

// Namespace events
// Params 6
// Checksum 0xdc627b8a, Offset: 0x63ec
// Size: 0x7b4f
function function_a2d92a4b5cb17d36( victim, objweapon, weapongroup, meansofdeath, inflictor, deathdata )
{
    if ( !isdefined( level.var_f2fe63a22820fc3d ) )
    {
        level.var_f2fe63a22820fc3d = [ "hit_loc":0, "attachment_flags":0, "mask5":0, "mask4":0, "mask3":0, "mask2":0, "mask":0 ];
    }
    
    self.modifiers = arraycopy( level.var_f2fe63a22820fc3d );
    
    if ( !isdefined( level.var_4b6e4c1d03535df1 ) )
    {
        level.var_4b6e4c1d03535df1 = [];
    }
    
    callback::callback( #"hash_2709fd1dd4cef88d", { #deathdata:deathdata, #inflictor:inflictor, #meansofdeath:meansofdeath, #weapongroup:weapongroup, #objweapon:objweapon, #victim:victim } );
    curtime = gettime();
    victimguid = victim.guid ?? "none";
    var_31c9ded9444b556b = isdefined( objweapon.basename ) && objweapon.basename != "none";
    
    if ( ( !weapon::iskillstreakweaponname( objweapon.basename ) || weapon::function_597e1c0b6df2fada( objweapon.basename ) ) && !isdefined( self.perks[ "specialty_explosivebullets" ] ) )
    {
        if ( isdefined( level.sharedfuncs[ #"camo_evolution" ][ #"hash_c77452a152c440d3" ] ) )
        {
            self [[ level.sharedfuncs[ #"camo_evolution" ][ #"hash_c77452a152c440d3" ] ]]( self, objweapon );
        }
        
        attackerisinflictor = attackerisinflictor( self, inflictor, objweapon, meansofdeath );
        lastattacker = victim.lastattacker ?? victim.laststandattacker;
        var_e3a86b6cd9169598 = victim.laststandattacker === lastattacker && victim.inlaststand;
        var_e3fc31716a3ef60b = 0;
        
        if ( getdvarint( @"hash_b7d30c36ac281531", 1 ) && inflictor.classname == "worldspawn" && var_e3a86b6cd9169598 )
        {
            attackerisinflictor = 1;
            var_e3fc31716a3ef60b = 1;
        }
        
        if ( var_31c9ded9444b556b && weapon::iscacprimaryweapon( objweapon, weapongroup ) && objweapon.var_1616e6fbba9a722d == getxhashasset( self.loadoutsecondary ) )
        {
            self.modifiers[ "primary_weapon_equipped_in_secondary_slot_kill" ] = 1;
            self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"primary_weapon_equipped_in_secondary_slot_kill" ) );
        }
        
        attackerposition = victim.attackerposition ?? self.origin;
        var_e3a86b6cd9169598 = 0;
        
        if ( victim.inlaststand && isdefined( victim.laststandattacker ) )
        {
            lastattacker = victim.lastattacker ?? victim.laststandattacker;
            var_e3a86b6cd9169598 = lastattacker === victim.laststandattacker;
        }
        
        var_e3fc31716a3ef60b = 0;
        
        if ( getdvarint( @"hash_b7d30c36ac281531", 1 ) && isdefined( inflictor.classname ) && inflictor.classname == "worldspawn" && var_e3a86b6cd9169598 )
        {
            attackerisinflictor = 1;
            var_e3fc31716a3ef60b = 1;
        }
        
        attackerposition = victim.attackerposition ?? self.origin;
        var_2bf59c61b6d17e33 = anglestoforward( self getplayerangles() );
        var_eaa9b74a22279790 = victim.origin - attackerposition;
        var_164f80ff6bd4d43e = vectornormalize( var_eaa9b74a22279790 );
        var_9bd5f18545722c04 = vectordot( var_2bf59c61b6d17e33, var_164f80ff6bd4d43e );
        attackervelocity = self getvelocity();
        var_13ceed07351526e8 = vectornormalize( attackervelocity );
        var_f4061506239fc0bd = vectordot( var_2bf59c61b6d17e33, var_13ceed07351526e8 );
        var_7c42446588b35c76 = length2dsquared( attackervelocity );
        
        if ( isdefined( level.scoreeventglobals.var_3afa8115118f2644 ) )
        {
            isprimary = self.loadoutprimary == objweapon.var_1616e6fbba9a722d;
            issecondary = self.loadoutsecondary == objweapon.var_1616e6fbba9a722d;
            var_ec6c1f7f31fbc819 = self.loadouttertiary == objweapon.var_1616e6fbba9a722d;
            
            if ( isprimary || issecondary || var_ec6c1f7f31fbc819 )
            {
                function_cbf5aa1041be464c( weapon::getweaponrootname( objweapon ) );
            }
        }
        
        if ( victim.disguised )
        {
            self.modifiers[ "disguised_enemy_kill" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"disguised_enemy_kill" ) );
        }
        
        if ( level.teambased && ( victim.var_c74f2ae506961460 || victim ismeatshieldattacker() || self.var_49c3ac74099ff5c9 ) )
        {
            self.modifiers[ "execute_save" ] = 1;
        }
        
        if ( self.var_3fdddb8aea428110 )
        {
            self.var_3fdddb8aea428110 = undefined;
            self.modifiers[ "obj_five_plus_defense_kill" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"obj_five_plus_defense_kill" ) );
        }
        
        if ( self.var_318dd8924d672e20 )
        {
            self.var_318dd8924d672e20 = undefined;
            self.modifiers[ "obj_def_kill" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"obj_def_kill" ) );
        }
        
        if ( self.var_a24f27229c8dd8bb )
        {
            self.var_a24f27229c8dd8bb = undefined;
            self.modifiers[ "obj_assault_kill" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"obj_assault_kill" ) );
        }
        
        if ( self.var_dd375d6d77538641 )
        {
            self.var_dd375d6d77538641 = undefined;
            self.modifiers[ "bomb_planter_kill" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"bomb_planter_kill" ) );
        }
        
        if ( self.var_ba06685f1daa2b60 )
        {
            self.var_ba06685f1daa2b60 = undefined;
            self.modifiers[ "bomb_defuser_kill" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"bomb_defuser_kill" ) );
        }
        
        if ( inflictor.var_cad106e30bb98d88 )
        {
            self.modifiers[ "bunkerbuster_penetration_kill" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"bunkerbuster_penetration_kill" ) );
            
            if ( isdefined( inflictor.surfaceorientation ) )
            {
                switch ( inflictor.surfaceorientation )
                {
                    case #"hash_bdea657441323e75":
                        self.modifiers[ "wall_bang_kill_wall" ] = 1;
                        self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"bunkerbuster_penetration_kill_wall" ) );
                        break;
                    case #"hash_28b4e95012259360":
                        self.modifiers[ "wall_bang_kill_ceiling" ] = 1;
                        self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"bunkerbuster_penetration_kill_ceiling" ) );
                        break;
                    case #"hash_3e7681464ca7b9fd":
                        self.modifiers[ "wall_bang_kill_floor" ] = 1;
                        self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"bunkerbuster_penetration_kill_floor" ) );
                        break;
                    default:
                        break;
                }
            }
        }
        
        if ( self.var_7562b3a264775d5c )
        {
            self.var_7562b3a264775d5c = undefined;
            self.modifiers[ "snd_ace_kill" ] = 1;
            self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"snd_ace_kill" ) );
        }
        
        if ( self.var_4b8d810f484a22cb )
        {
            self.var_4b8d810f484a22cb = undefined;
            self.modifiers[ "bank_shot_kill" ] = 1;
            self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"bank_shot_kill" ) );
        }
        
        if ( isdefined( level.sharedfuncs[ #"challenges" ][ #"hash_fe4251017975f1a4" ] ) && isplayer( self ) )
        {
            if ( self [[ level.sharedfuncs[ #"challenges" ][ #"hash_fe4251017975f1a4" ] ]]( victim, self ) )
            {
                self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"hash_5430cedc28b69ca4" ) );
            }
        }
        
        _weaponclass = objweapon.var_47c4004240fbe59d;
        
        if ( _weaponclass == #"" )
        {
            _weaponclass = objweapon.classname;
        }
        
        function_167fa0553529a2c5( objweapon, _weaponclass );
        
        if ( !self.var_dff35a570cbec5a8 )
        {
            if ( isprimaryweaponclass( _weaponclass ) )
            {
                function_a3065f3e99b54666( objweapon.basename );
            }
            
            if ( self.var_7d8ef959d71d1b1 )
            {
                self.var_dff35a570cbec5a8 = 1;
                self.var_7d8ef959d71d1b1 = undefined;
                self.modifiers[ "two_primary_kills" ] = 1;
                self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"hash_4b32b602080de2e5" ) );
            }
        }
        
        if ( !self.var_b8837774e4fee951 )
        {
            if ( ( self.var_49c5d9bb5965b473 & 5 ) == 5 )
            {
                self.var_b8837774e4fee951 = 1;
                self.modifiers[ "lifetime_pistol_and_primary_kill" ] = 1;
                self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"lifetime_pistol_and_primary_kill" ) );
            }
        }
        
        if ( !self.var_65b133d36c961ccc )
        {
            if ( ( self.var_49c5d9bb5965b473 & 3 ) == 3 )
            {
                self.var_65b133d36c961ccc = 1;
                self.modifiers[ "lifetime_secondary_and_primary_kill" ] = 1;
                self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"lifetime_secondary_and_primary_kill" ) );
            }
        }
        
        if ( !self.var_308fee31f379a73d )
        {
            if ( ( self.var_49c5d9bb5965b473 & 11 ) == 11 )
            {
                self.var_308fee31f379a73d = 1;
                self.modifiers[ "lifetime_secondary_primary_and_melee_kill" ] = 1;
                self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"lifetime_secondary_primary_and_melee_kill" ) );
            }
        }
        
        if ( self.var_e006de984e056e08 )
        {
            self.modifiers[ "scout_pulse_kill" ] = 1;
            self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"scout_pulse_kill" ) );
            tempbundle = killstreak::function_85b2d8e857ab4898( "radar_ping" );
            thread points::function_f8a0deb1a12da52e( #"radarping_finished", undefined, tempbundle.lootid );
        }
        
        if ( self.var_7a44face12042213 )
        {
            self.modifiers[ "sentinel_bonus_kill" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"sentinel_bonus_kill" ) );
        }
        
        if ( self.var_9b8c24cccee1a519 )
        {
            self.modifiers[ "all_chosen_specialist_perks_active_kill" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"all_chosen_specialist_perks_active_kill" ) );
        }
        
        if ( self.var_de0e5e468776d901 )
        {
            self.var_de0e5e468776d901 = undefined;
            self.modifiers[ "captain_stealth_kill" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"captain_stealth_kill" ) );
        }
        
        if ( self.activeuavcount )
        {
            self.modifiers[ "uav_kill" ] = 1;
            self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"uav_kill" ) );
            tempbundle = killstreak::function_85b2d8e857ab4898( "uav" );
            thread points::function_f8a0deb1a12da52e( #"uav_finished", undefined, tempbundle.lootid );
        }
        
        if ( self.var_44f1c37319244499 )
        {
            self.modifiers[ "harp_kill" ] = 1;
            self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"harp_kill" ) );
            tempbundle = killstreak::function_85b2d8e857ab4898( "directional_uav" );
            thread points::function_f8a0deb1a12da52e( #"harp_finished", undefined, tempbundle.lootid );
        }
        
        if ( self.var_9605e867634181ab )
        {
            self.modifiers[ "cuav_kill" ] = 1;
            self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"cuav_kill" ) );
            tempbundle = killstreak::function_85b2d8e857ab4898( "counter_uav" );
            thread points::function_f8a0deb1a12da52e( #"cuav_finished", undefined, tempbundle.lootid );
        }
        
        if ( victim.ksempd )
        {
            self.modifiers[ "disabled_by_your_emp_blast_kill" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"disabled_by_your_emp_blast_kill" ) );
        }
        
        if ( self.var_9e887c4fb56269e4 )
        {
            self.var_9e887c4fb56269e4 = undefined;
            self.modifiers[ "acoustic_amp_kill" ] = 1;
            self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"acoustic_amp_kill" ) );
        }
        
        if ( self.var_bf16e02ff43a6a37 )
        {
            self.var_bf16e02ff43a6a37 = undefined;
            self.modifiers[ "signal_lure_kill" ] = 1;
            self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"signal_lure_kill" ) );
        }
        
        function_920a35d38f329ffb( victim );
        
        if ( self.var_32fd3b4f0d29af1f )
        {
            self.modifiers[ "perk_greed_with_four_of_same_playstyle_kill" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"perk_greed_with_four_of_same_playstyle_kill" ) );
        }
        
        if ( self.var_ee6799720a3a8f9c[ victimguid ] )
        {
            self.modifiers[ "your_combat_link_kill" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"your_combat_link_kill" ) );
        }
        
        if ( self.usingremote )
        {
            self.modifiers[ "remote_piloting_kill" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"remote_piloting_kill" ) );
        }
        
        if ( self.var_21877673ec5d4c6f )
        {
            self.var_21877673ec5d4c6f = undefined;
            self.modifiers[ "warcry_triple_plus_kill" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"warcry_triple_plus_kill" ) );
        }
        
        if ( self.var_f35bae2c4488483b )
        {
            self.var_f35bae2c4488483b = undefined;
            self.modifiers[ "signal_lure_triple_plus_kill" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"signal_lure_triple_plus_kill" ) );
        }
        
        if ( isdefined( victim.pingedby[ self.guid ] ) )
        {
            self.modifiers[ "pinged_by_you_kill" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"pinged_by_you_kill" ) );
        }
        
        if ( isdefined( self.var_2f4095841cd45bab ) && curtime - self.var_2f4095841cd45bab <= 4000 )
        {
            self.modifiers[ "tac_insert_respawn_kill" ] = 1;
            self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"tac_insert_respawn_kill" ) );
        }
        
        if ( self.var_7e5719799a02450d )
        {
            self.var_7e5719799a02450d = undefined;
            self.modifiers[ "morphine_kill_plus_rapid_kill" ] = 1;
            self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"morphine_kill_plus_rapid_kill" ) );
        }
        
        if ( abs( attackervelocity[ 0 ] ) >= 10 || abs( attackervelocity[ 1 ] ) >= 10 || abs( attackervelocity[ 2 ] ) >= 10 )
        {
            self.modifiers[ "moving_kill" ] = 1;
            self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"moving_kill" ) );
        }
        
        isbulletdamage = utility::isbulletdamage( meansofdeath );
        ismeleedamage = utility::ismeleedamage( meansofdeath );
        
        if ( ( isbulletdamage || ismeleedamage ) && isdefined( var_f4061506239fc0bd ) && isdefined( var_7c42446588b35c76 ) )
        {
            if ( abs( var_f4061506239fc0bd ) < 0.8 && var_7c42446588b35c76 > 50 )
            {
                self.modifiers[ "strafing_kill" ] = 1;
                self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"strafing_kill" ) );
            }
        }
        
        if ( ismeleedamage )
        {
            attackerdata = victim.attackerdata[ self.guid ];
            
            if ( isdefined( attackerdata.damagesources ) )
            {
                foreach ( damagesource in attackerdata.damagesources )
                {
                    if ( isdefined( damagesource.meansofdeath ) && utility::isbulletdamage( damagesource.meansofdeath ) )
                    {
                        self.modifiers[ "melee_kill_after_bullet_damage" ] = 1;
                        self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"melee_kill_after_bullet_damage" ) );
                        break;
                    }
                }
            }
        }
        
        if ( meansofdeath == "MOD_EXECUTION" )
        {
            self.modifiers[ "execution" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"execution" ) );
            
            if ( gameplay_telemetry_utils::function_944c6d9098e40dfb( victim ) )
            {
                killdist = math::round_float( distance( attackerposition, victim.origin ) / 39.37, 2 );
                gameplay_telemetry::function_f98fbe3bbb2ed9f1( "lastKillRange", undefined, killdist, 0 );
                gameplay_telemetry::function_83a6a8db9fcbb065( "weap_dist", objweapon.basename, 2, killdist, 0 );
                var_6a5dd89ab92aec73 = gameplay_telemetry::function_42040e5fa41218b3( "weap_longest_dist", objweapon.basename );
                
                if ( killdist > var_6a5dd89ab92aec73 )
                {
                    gameplay_telemetry::function_83a6a8db9fcbb065( "weap_longest_dist", objweapon.basename, 2, killdist, 0 );
                }
            }
        }
        
        if ( level.numkills == 0 && !isagent( victim ) )
        {
            self.modifiers[ "firstblood" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"firstblood" ) );
        }
        
        if ( var_31c9ded9444b556b && wasoneshotkill( victim, objweapon, meansofdeath, curtime, weapongroup ) )
        {
            self.modifiers[ "oneshotkill" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"1shot1kill" ) );
        }
        
        if ( isdefined( self.lastinsmoketime ) && self.lastinsmoketime + 5000 > curtime || isdefined( victim.lastinsmoketime ) && victim.lastinsmoketime + 5000 > curtime )
        {
            self.modifiers[ "insmoke" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"enemyinsmoke" ) );
        }
        
        if ( uav_bigmap::function_cdd5542320f92744() && isbrgamemode() )
        {
            var_d61b1d2dbc3e4d5b = self getentitynumber();
            
            if ( isdefined( level.var_944be9a343c2d532 ) && level.var_944be9a343c2d532[ var_d61b1d2dbc3e4d5b ] )
            {
                self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"enemywithuav" ) );
            }
            else if ( isdefined( level.activetowers ) && isdefined( self.team ) )
            {
                foreach ( instance in level.activetowers )
                {
                    if ( instance.activeteam != self.team )
                    {
                        dist = distance2dsquared( instance.origin, self.origin );
                        
                        if ( dist <= level.var_ed1d437905997e43 )
                        {
                            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"enemywithuav" ) );
                            break;
                        }
                    }
                }
            }
        }
        else if ( killstreak_utility::teamhasuav( victim.team ) )
        {
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"enemywithuav" ) );
        }
        
        if ( ( meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_GRENADE" ) && victim.stuckbygrenadeowner === self && inflictor.equipmentref && weapon::getequipmenttype( objweapon ) == "lethal" )
        {
            self.modifiers[ "grenadestuck" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"grenadestuck" ) );
            
            if ( victim.var_2ce333df9ce87760[ self.guid ] )
            {
                self.modifiers[ "grenade_huck_stuck" ] = 1;
                self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"grenade_huck_stuck" ) );
            }
        }
        
        if ( game_utility_mp::isassaulting( victim ) )
        {
            self.modifiers[ "assault" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"assaulting" ) );
            incrementobjectiveachievementkill();
        }
        
        if ( game_utility_mp::isdefending( victim ) )
        {
            self.modifiers[ "defender" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"defending" ) );
            incrementobjectiveachievementkill();
        }
        
        if ( meansofdeath == "MOD_MELEE" || meansofdeath == "MOD_MELEE_TAKEDOWN" )
        {
            self.modifiers[ "melee" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"melee" ) );
            
            if ( meansofdeath == "MOD_MELEE_TAKEDOWN" )
            {
                self.modifiers[ "heavy_melee" ] = 1;
                self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"heavy_melee" ) );
            }
            
            if ( weapongroup != "weapon_melee" && weapongroup != "weapon_melee2" )
            {
                self.modifiers[ "gunbutt" ] = 1;
                self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"gunbutt" ) );
            }
        }
        
        if ( isdefined( deathdata.heldoffhand ) )
        {
            if ( getweaponrootstring( deathdata.heldoffhand ) == "frag_grenade" || deathdata.heldoffhand.basename == "cluster_grenade_mp" )
            {
                self.modifiers[ "cooking" ] = 1;
                self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"cooking" ) );
            }
        }
        
        if ( deathdata.assistedsuicide )
        {
            self.modifiers[ "assistedsuicide" ] = 1;
        }
        
        if ( self.pers[ "cur_death_streak" ] > 3 )
        {
            self.modifiers[ "comeback" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"comeback" ) );
        }
        
        function_8f26df18dbcd57c2( objweapon, meansofdeath, deathdata );
        
        if ( curtime - self.spawntime <= 4000 )
        {
            self.modifiers[ "shortlyafterrespawnkill" ] = 1;
            self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"hash_19532193a060fa59" ) );
        }
        
        if ( self.wasti && curtime - self.spawntime <= 5000 )
        {
            self.modifiers[ "jackintheboxkill" ] = 1;
        }
        
        if ( !player::isreallyalive( self ) && isdefined( self.deathtime ) )
        {
            timesincelastdeath = curtime - self.deathtime;
            
            if ( timesincelastdeath < 2500 && timesincelastdeath > 0 )
            {
                self.modifiers[ "posthumous" ] = 1;
                self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"posthumous" ) );
            }
        }
        
        if ( level.teambased && isdefined( victim.lastkilltime ) && curtime - victim.lastkilltime < 1500 )
        {
            if ( isdefined( victim.lastkilledplayer ) && victim.lastkilledplayer != self )
            {
                self.modifiers[ "avenger" ] = 1;
                self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"avenger" ) );
            }
        }
        
        if ( isbackkill( self, victim, meansofdeath ) )
        {
            self.modifiers[ "backstab" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"backstab" ) );
            
            if ( meansofdeath == "MOD_MELEE" || meansofdeath == "MOD_MELEE_TAKEDOWN" )
            {
                self.modifiers[ "melee_backstab" ] = 1;
                self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"melee_backstab" ) );
            }
        }
        
        if ( !self isnightvisionon() )
        {
            self.modifiers[ "withoutnvgs" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"withoutnvgs" ) );
        }
        
        if ( isbulletdamage && isdefined( victim.attackerdata ) )
        {
            foreach ( attackerent in victim.attackerdata )
            {
                if ( isdefined( attackerent.damagesources[ "equip_molotov" ] ) && attackerent.attackerent == self )
                {
                    self.modifiers[ "postmolotovbulletkill" ] = 1;
                    self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"hash_f752cd02cab21240" ) );
                    break;
                }
            }
        }
        
        if ( attackerisinflictor )
        {
            victimposition = victim.origin;
            
            if ( var_e3fc31716a3ef60b && isdefined( victim.var_3242e03bf1b09197 ) )
            {
                victimposition = victim.var_3242e03bf1b09197;
            }
            
            var_cf0ff034c880563a = getshotdistancetype( self, objweapon, meansofdeath, attackerposition, victimposition );
            killdist = math::round_float( distance( attackerposition, victimposition ) / 39.37, 2 );
            gameplay_telemetry::function_f98fbe3bbb2ed9f1( "lastKillRange", undefined, killdist, 0 );
            gameplay_telemetry::function_83a6a8db9fcbb065( "weap_dist", objweapon.basename, 2, killdist, 0 );
            telemetry_mp::function_7640fb4384ba46fa( self, objweapon, int( killdist ) );
            var_6a5dd89ab92aec73 = gameplay_telemetry::function_42040e5fa41218b3( "weap_longest_dist", objweapon.basename );
            
            if ( killdist > var_6a5dd89ab92aec73 )
            {
                gameplay_telemetry::function_83a6a8db9fcbb065( "weap_longest_dist", objweapon.basename, 2, killdist, 0 );
            }
            
            if ( var_31c9ded9444b556b )
            {
                switch ( var_cf0ff034c880563a )
                {
                    case #"hash_e1ae7daca67ccc55":
                        self.modifiers[ "pointblank" ] = 1;
                        self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"shortrange" ) );
                        break;
                    case #"hash_bbddd8225d923d3":
                        self.modifiers[ "longshot" ] = 1;
                        self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"longrange" ) );
                        self setclientomnvar( "ui_longshot_dist", killdist );
                        self setclientomnvar( "ui_longshot_special", islongshotspecial( attackerposition, victimposition, objweapon ) );
                        break;
                    case #"hash_4364fa08acd17954":
                        self.modifiers[ "longshot" ] = 1;
                        self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"longrange" ) );
                        self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"verylongrange" ) );
                        self.modifiers[ "very_longshot" ] = 1;
                        self setclientomnvar( "ui_longshot_dist", killdist );
                        self setclientomnvar( "ui_longshot_special", islongshotspecial( attackerposition, victimposition, objweapon ) );
                        break;
                }
            }
            
            if ( self.focusbreath || isdefined( self.var_c06462955efc0a91 ) && self.lastshotfiredtime === self.var_1395863480400423 && curtime - self.var_c06462955efc0a91 <= 6000 )
            {
                self.modifiers[ "holdingbreath" ] = 1;
                self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"holdbreath" ) );
            }
            
            if ( var_31c9ded9444b556b && class::isweaponsilenced( objweapon ) )
            {
                self.modifiers[ "silencedkill" ] = 1;
                self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"silenced" ) );
            }
            
            if ( victim weapons::isstunnedorblinded() || victim.var_917038143d36327f[ "flashed" ] || victim.var_917038143d36327f[ "stunned" ] )
            {
                self.modifiers[ "victimimpairedkill" ] = 1;
                self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"victim_impaired" ) );
                self.modifiers[ "detectedimpairedkill" ] = 1;
                self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"detected_impaired" ) );
            }
            
            if ( victim.ishaywire || victim.var_917038143d36327f[ "shocked" ] )
            {
                self.modifiers[ "victim_haywire" ] = 1;
                self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"victim_haywire" ) );
            }
            
            if ( isdetected( self, victim ) )
            {
                self.modifiers[ "detectedimpairedkill" ] = 1;
                self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"detected_impaired" ) );
            }
            
            if ( isdefined( deathdata.damageflags ) && deathdata.damageflags & 8 && !( deathdata.damageflags & 16384 ) )
            {
                self.modifiers[ "coverkill" ] = 1;
                self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"cover_kill" ) );
            }
            
            if ( issurvivorkill( self ) )
            {
                self.modifiers[ "low_health_kill" ] = 1;
                self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"lowhealth" ) );
            }
            
            if ( self.attackerdata[ victim.guid ].var_1064e75bd343dd83[ victim.guid ] )
            {
                self.modifiers[ "victim_shot_attacker_first_kill" ] = 1;
                self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"victim_shot_attacker_first_kill" ) );
            }
            
            if ( function_853f2fa3d548d7ec( self ) )
            {
                self.modifiers[ "airborne" ] = 1;
                self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"airborne" ) );
            }
            
            if ( function_853f2fa3d548d7ec( victim ) )
            {
                self.modifiers[ "victim_airborne" ] = 1;
                self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"victim_airborne" ) );
            }
            
            if ( isdefined( victim.var_61f63b24a5b2158a ) )
            {
                self.modifiers[ "victim_has_dmz_bounty" ] = 1;
                self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"victim_has_dmz_bounty" ) );
            }
            
            if ( self playermount() >= 0.5 )
            {
                self.modifiers[ "mounted" ] = 1;
                self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"mounted" ) );
            }
            
            if ( self ishanging() )
            {
                self.modifiers[ "ledgehanging" ] = 1;
                self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"ledgehanging" ) );
            }
            
            if ( isbulletdamage )
            {
                self.modifiers[ "bullet_damage" ] = 1;
                remainingammo = self getweaponammoclip( objweapon );
                
                if ( remainingammo <= 0 )
                {
                    self.modifiers[ "last_bullet_kill" ] = 1;
                    self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"lastbullet" ) );
                }
                
                burstfirecount = objweapon.burstcount;
                modesemi = objweapon.issemiauto || burstfirecount == 1 || objweapon.adsissemiauto && player::isplayerads();
                modeauto = !modesemi && objweapon.isauto;
                
                if ( modeauto )
                {
                    self.modifiers[ "full_auto_kill" ] = 1;
                    self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"full_auto_kill" ) );
                }
                
                if ( objweapon.issemiauto || burstfirecount == 1 )
                {
                    self.modifiers[ "semi_auto_kill" ] = 1;
                    self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"semi_auto_kill" ) );
                }
                else if ( burstfirecount > 1 )
                {
                    self.modifiers[ "burst_kill" ] = 1;
                    self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"burst_kill" ) );
                }
                
                if ( player::isplayerads() )
                {
                    if ( self function_25af1328b3e8da54( self.currentprimaryweapon ) )
                    {
                        self.modifiers[ "tac_stance" ] = 1;
                        self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"tac_stance_kill" ) );
                    }
                    else
                    {
                        self.modifiers[ "ads" ] = 1;
                        self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"ads" ) );
                    }
                }
                else
                {
                    self.modifiers[ "hipfire" ] = 1;
                    self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"hipfire" ) );
                }
            }
            else if ( weapongroup == "weapon_projectile" )
            {
                if ( inflictor.adsfire )
                {
                    self.modifiers[ "ads" ] = 1;
                    self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"ads" ) );
                }
                else
                {
                    self.modifiers[ "hipfire" ] = 1;
                    self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"hipfire" ) );
                }
            }
            else if ( objweapon.var_1616e6fbba9a722d == %"sat_sl_sargas" && !inflictor.adsfire )
            {
                self.modifiers[ "hipfire" ] = 1;
                self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"hipfire" ) );
            }
            
            if ( victim issprinting() )
            {
                self.modifiers[ "victim_sprinting" ] = 1;
                self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"victimsprinting" ) );
            }
            
            if ( level.teambased )
            {
                players = teams::getfriendlyplayers( self.team, 1 );
                
                foreach ( player in players )
                {
                    if ( player == self )
                    {
                        continue;
                    }
                    
                    if ( distancesquared( self.origin, player.origin ) < 90000 )
                    {
                        self.modifiers[ "buddy_kill" ] = 1;
                        break;
                    }
                }
            }
            
            if ( weapons::isstunnedorblinded() )
            {
                self.modifiers[ "impaired" ] = 1;
                self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"enemystunned" ) );
            }
            
            var_bda53394c108f2e = isweapon( objweapon ) ? getcompleteweaponname( objweapon ) : "";
            
            if ( self.tookweaponfrom[ var_bda53394c108f2e ].var_3a1cc6241650f669 == victim )
            {
                self.modifiers[ "backfire" ] = 1;
                self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"backfire" ) );
            }
            
            if ( var_31c9ded9444b556b )
            {
                if ( item_weapon::function_558121b89ab6a092( objweapon ) )
                {
                    self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"hash_4dc2ec9c29dc0b01" ) );
                }
                else if ( function_f08ecc43d309a219( self, objweapon ) )
                {
                    self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"hash_4a1f225b3af5f5f0" ) );
                }
            }
        }
        else if ( weapongroup == "weapon_projectile" )
        {
            if ( inflictor.adsfire )
            {
                self.modifiers[ "ads" ] = 1;
                self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"ads" ) );
            }
            else
            {
                self.modifiers[ "hipfire" ] = 1;
                self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"hipfire" ) );
            }
        }
        
        if ( isdefined( self.var_688945b063626b53 ) && curtime - self.var_688945b063626b53 < level.scoreeventglobals.var_aca39812c4c74555 && !self isonground() )
        {
            self.modifiers[ "360_spin_kill" ] = 1;
        }
        
        vehicle = vehicle::get_vehicle();
        
        if ( isdefined( vehicle ) )
        {
            self.modifiers[ "in_vehicle" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"invehicle" ) );
            
            if ( vehicle vehicle::ishelicopter() )
            {
                self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"from_helicopter" ) );
            }
            else if ( vehicle vehicle::get_ref() == %"hash_3585a3d351c5e6ff" )
            {
                self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"from_mrap" ) );
            }
            
            if ( victim damage::playerkilled_washitbyvehicle( meansofdeath, inflictor ) )
            {
                if ( inflictor.occupants[ "driver" ] == self )
                {
                    self.modifiers[ "vehicle_kill" ] = 1;
                }
            }
        }
        
        if ( victim isonascender() || victim isonzipline() )
        {
            self.modifiers[ "victim_on_zipline" ] = 1;
            self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"victim_on_zipline" ) );
        }
        
        if ( victim.var_8e388104c7c4d011 )
        {
            self.modifiers[ "sky_kill" ] = 1;
            victim.var_8e388104c7c4d011 = undefined;
            self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"victim_airborne" ) );
        }
        
        if ( isdefined( victim.streakdata ) )
        {
            foreach ( streakinfo in victim.streakdata.streaks )
            {
                costdiff = streakinfo.currentcost - victim.streakpoints;
                
                if ( costdiff > 0 && costdiff <= 1 )
                {
                    self.modifiers[ "buzzkill" ] = victim.pers[ "cur_kill_streak" ];
                    self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"buzzkill" ) );
                    break;
                }
            }
        }
        
        if ( !game_utility_mp::runleanthreadmode() )
        {
            if ( level.teambased )
            {
                if ( victim.score > 0 )
                {
                    if ( !isdefined( enemies ) )
                    {
                        enemies = teams::getenemyplayers( self.team );
                    }
                    
                    if ( level.scoreeventglobals.var_ebea6d4f18e56b9f && is_enemy_highest_score( victim, level.players ) || !level.scoreeventglobals.var_ebea6d4f18e56b9f && is_enemy_highest_score( victim, enemies ) )
                    {
                        self.modifiers[ "kingslayer" ] = 1;
                        self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"kingslayer" ) );
                    }
                }
            }
            else if ( victim.score > 0 )
            {
                if ( is_enemy_highest_score( victim, level.players ) )
                {
                    self.modifiers[ "kingslayer" ] = 1;
                    self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"kingslayer" ) );
                }
            }
        }
        
        if ( var_31c9ded9444b556b && inflictor.isequipment && meansofdeath == "MOD_IMPACT" && !weapon::function_e1a6c47f66c6de20( objweapon ) )
        {
            self.modifiers[ "item_impact" ] = 1;
        }
        
        if ( var_31c9ded9444b556b && inflictor.isequipment && inflictor.threwback )
        {
            self.modifiers[ "grenade_reverse" ] = 1;
        }
        
        if ( var_31c9ded9444b556b && damage::islauncherdirectimpactdamage( objweapon, meansofdeath ) )
        {
            self.modifiers[ "launcher_impact" ] = 1;
        }
        
        if ( var_31c9ded9444b556b && damage::islauncherdirectimpactdamage( objweapon, meansofdeath, 1 ) )
        {
            self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"launcher_impact" ) );
        }
        
        if ( var_9bd5f18545722c04 >= 0.6428 )
        {
            self.modifiers[ "victim_in_standard_view" ] = 1;
        }
        
        if ( weapon_utility::function_6901d4a87ebafa4f( objweapon, victim ) )
        {
            self.modifiers[ "weapon_pickup_kill" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"recentweaponpickup" ) );
        }
        
        if ( isdefined( self.lastreloadtime ) && curtime - self.lastreloadtime <= 5000 )
        {
            self.modifiers[ "reload_kill" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"recentreload" ) );
        }
        
        if ( isdefined( self.var_ec0a10d5cbcfca21 ) && curtime - self.var_ec0a10d5cbcfca21 <= 5000 )
        {
            self.modifiers[ "after_sprint_kill" ] = 1;
            self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"after_sprint_kill" ) );
        }
        
        if ( self issprinting() )
        {
            self.modifiers[ "while_sprinting_kill" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"while_sprinting_kill" ) );
        }
        
        if ( victim.isdefusing )
        {
            self.modifiers[ "killed_defuser" ] = 1;
        }
        
        if ( victim.isplanting )
        {
            self.modifiers[ "killed_planter" ] = 1;
        }
        
        if ( var_31c9ded9444b556b && weapon::iscacsecondaryweapongroup( weapongroup, objweapon ) || isdefined( self.perks[ "specialty_munitions_2" && isdefined( self.secondaryweaponobj ) && objweapon == self.secondaryweaponobj ] ) )
        {
            self.modifiers[ "secondary_weapon" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"usingsecondaryweapon" ) );
        }
        
        if ( player::isinlaststand( self ) )
        {
            self.modifiers[ "last_stand" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"laststand" ) );
            
            if ( player::function_73fe5f51164eb3ca( self ) )
            {
                self.modifiers[ "morphine_injector_kill" ] = 1;
                self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"morphine_injector_kill" ) );
            }
        }
        
        if ( player::isinlaststand( victim ) || deathdata.brvictiminlaststand )
        {
            self.modifiers[ "victim_last_stand" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"victimlaststand" ) );
        }
        
        if ( self ismeatshieldattacker() && victim ismeatshieldvictim() && self.meatshieldstate == 13 )
        {
            self.modifiers[ "meat_shield_grenade_finisher" ] = 1;
        }
        
        if ( inflictor.var_2805eec786427e6a )
        {
            self.modifiers[ "meat_shield_explosion_kill" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"meat_shield_grenade_finisher" ) );
        }
        
        if ( !isdefined( level.var_4b6e4c1d03535df1[ #"radiation" ] ) )
        {
            level.var_4b6e4c1d03535df1[ #"radiation" ] = isdefined( level.sharedfuncs[ #"radiation" ][ #"radiation_isinradiation" ] ) || isdefined( level.sharedfuncs[ #"biobunker_radiation" ][ #"hash_e710940665e8f80a" ] );
        }
        
        if ( level.var_4b6e4c1d03535df1[ #"radiation" ] )
        {
            inradiation = utility::callsharedfunc( #"radiation", #"radiation_isinradiation", victim.origin ) || utility::callsharedfunc( #"biobunker_radiation", #"hash_e710940665e8f80a", victim.origin );
            
            if ( inradiation )
            {
                self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"victim_in_radiation" ) );
            }
            
            var_744b2f76acf25203 = utility::callsharedfunc( #"radiation", #"radiation_isinradiation", self.origin ) || utility::callsharedfunc( #"biobunker_radiation", #"hash_e710940665e8f80a", self.origin );
            
            if ( var_744b2f76acf25203 )
            {
                self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"in_radiation" ) );
            }
        }
        
        platform = isplayer( self ) || isactor( self ) ? self getmovingplatformparent() : undefined;
        
        if ( isdefined( platform ) && platform vehicle::is_vehicle() && platform.isheli )
        {
            tracecontents = physics_createcontents( [ "physicscontents_playerclip", "physicscontents_vehicle" ] );
            trace = trace::sphere_trace( self.origin - ( 0, 0, 15 ), self.origin - ( 0, 0, 45 ), 15, self, tracecontents );
            
            if ( trace[ "entity" ] == platform )
            {
                self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"from_helicopter" ) );
                
                if ( platform vehicle::get_ref() === %"hash_1dd941f8f4026e3" )
                {
                    self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"from_palfa" ) );
                }
            }
        }
        
        if ( self isinvehicleleanout() )
        {
            self.modifiers[ "vehiclelean" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"vehiclelean" ) );
            
            if ( vehicle::get_ref() === %"hash_3dff816eedc0901c" )
            {
                self.modifiers[ "vehiclelean_sedan" ] = 1;
                self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"vehiclelean_sedan" ) );
            }
        }
        
        if ( var_31c9ded9444b556b && ( meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_HEAD_SHOT" || weaponclass( objweapon ) == "spread" ) )
        {
            collateralresult = checkcollateral( victim, objweapon, meansofdeath, weapongroup );
            
            if ( self.killsinaframecount >= 2 )
            {
                collateralae( self.killsinaframecount );
            }
            
            switch ( collateralresult )
            {
                case #"hash_ba8b5547dfa84580":
                    if ( victim.playergoingintols )
                    {
                        victim.var_e988ab84618d4592 = { #collateralhandler:&collateral, #shotcount:self.bulletkillsinaframecount, #attacker:self };
                    }
                    else
                    {
                        collateral( self.bulletkillsinaframecount );
                    }
                    
                    break;
                case #"hash_dd94fd3bee9e6c50":
                    if ( victim.playergoingintols )
                    {
                        victim.var_e988ab84618d4592 = { #collateralhandler:&shotguncollateral, #shotcount:self.shotgunkillsinaframecount, #attacker:self };
                    }
                    else
                    {
                        shotguncollateral( self.shotgunkillsinaframecount );
                    }
                    
                    break;
                default:
                    break;
            }
            
            if ( isdefined( deathdata.idflags ) && deathdata.idflags & 8 && !( deathdata.idflags & 16384 ) && ( victim.inlaststand || victim.playergoingintols ) )
            {
                victim.var_9cf07436884eef22 = 1;
            }
        }
        
        if ( isdefined( meansofdeath ) )
        {
            switch ( meansofdeath )
            {
                case #"hash_d8646db4e6ee3658":
                    self.modifiers[ "fire_damage" ] = 1;
                    self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"fire" ) );
                    break;
                case #"hash_b1078ff213fddba6":
                    self.modifiers[ "impact_damage" ] = 1;
                    self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"equipmentimpact" ) );
                    break;
                case #"hash_abb1587cdc6def23":
                    self.modifiers[ "crush_damage" ] = 1;
                    self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"crush" ) );
                    break;
                default:
                    break;
            }
        }
        
        if ( var_31c9ded9444b556b && ( isdefined( objweapon.basename ) && issubstr( objweapon.basename, "molotov" ) || issubstr( objweapon.basename, "thermite" ) || dragonsbreath::isdragonsbreathweapon( objweapon ) || crossbow::isthermitecrossbow( objweapon ) ) )
        {
            self.modifiers[ "fire_damage" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"fire" ) );
        }
        
        if ( victim.gulagjailer )
        {
            self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"victim_is_gulag_jailer" ) );
        }
        
        for ( moverparent = self; true ; moverparent = newparent )
        {
            if ( ( isplayer( moverparent ) || isactor( moverparent ) ) && !moverparent islinked() )
            {
                newparent = moverparent getmovingplatformparent();
            }
            else
            {
                newparent = moverparent getlinkedparent();
            }
            
            if ( !isdefined( newparent ) )
            {
                break;
            }
        }
        
        if ( isdefined( moverparent ) && moverparent vehicle::is_vehicle() && ( !isdefined( vehicle ) || moverparent != vehicle ) )
        {
            ref = train_utility::get_train_name( moverparent );
            
            if ( ref === "cargo_train" || ref === "br_passenger_train" )
            {
                self.modifiers[ "ontrain" ] = 1;
                
                if ( ref == "cargo_train" )
                {
                    self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"on_cargo_train" ) );
                }
                else if ( ref == "br_passenger_train" )
                {
                    self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"on_passenger_train" ) );
                }
                
                self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"ontrain" ) );
            }
            else
            {
                self.modifiers[ "vehiclesurf" ] = 1;
                self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"vehiclesurf" ) );
                
                if ( moverparent.classname == "script_vehicle" && moverparent vehicle_getspeed() > 25 )
                {
                    self.modifiers[ "infastvehicle" ] = 1;
                    self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"infastvehicle" ) );
                }
            }
        }
        
        if ( self != victim && inflictor.owner == victim )
        {
            self.modifiers[ "attacker_exploded_victims_lethal_kill" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"attacker_exploded_victims_lethal_kill" ) );
        }
        
        if ( isdefined( inflictor.equipmentref ) )
        {
            if ( isent( inflictor ) && ( inflictor.equipmentref == "equip_c4" || inflictor.equipmentref == "equip_claymore" ) )
            {
                stuckto = inflictor getlinkedparent();
                
                if ( isdefined( stuckto ) && stuckto.helperdronetype == "radar_drone_recon" )
                {
                    self.modifiers[ "recon_drone_explosive" ] = 1;
                    self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"recondroneexplosive" ) );
                    
                    if ( level.challengesallowed && isdefined( stuckto.owner ) )
                    {
                        self.recondroneteammate = stuckto.owner;
                    }
                }
                else if ( isdefined( stuckto ) && stuckto vehicle::is_vehicle() )
                {
                    self.modifiers[ "vehicle_explosive" ] = 1;
                    self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"vehicleexplosive" ) );
                    
                    if ( stuckto vehicle::ishelicopter() )
                    {
                        self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"helicopter_explosive" ) );
                    }
                }
            }
            
            if ( weapon::getequipmenttype( objweapon ) == "lethal" )
            {
                self.modifiers[ "equipment_kill" ] = 1;
                self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"lethal_equipment_kill" ) );
            }
        }
        
        if ( var_31c9ded9444b556b && vehicle::isvehicleweaponname( objweapon.basename ) && meansofdeath == "MOD_EXPLOSIVE" )
        {
            self.modifiers[ "vehicle_explosive" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"vehicleexplosive" ) );
            
            if ( weapon::function_7940d8028488f980( objweapon.basename ) )
            {
                self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"helicopter_explosive" ) );
            }
        }
        
        if ( armor::hasarmor() )
        {
            self.modifiers[ "wearingarmor" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"wearingarmor" ) );
        }
        
        if ( armor::function_70d2a998e632c76() )
        {
            self.modifiers[ "fullarmor" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"fullarmor" ) );
        }
        
        victimfortress = ai_fortress::function_386da8b7d1afe346( victim.origin );
        
        if ( isdefined( victimfortress ) && ai_fortress::function_c4cc2f9a17167e1b( victimfortress ) )
        {
            self.modifiers[ "victiminstronghold" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"victiminstronghold" ) );
            
            if ( ai_fortress::function_1d4c7c521dd6fe83( victimfortress ) )
            {
                self.modifiers[ "victiminlockedstronghold" ] = 1;
                self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"victiminlockedstronghold" ) );
            }
        }
        
        if ( br_public::isplayeringulag() )
        {
            self.modifiers[ "in_gulag" ] = 1;
            self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"in_gulag" ) );
        }
        
        if ( isdefined( victim.origin ) )
        {
            if ( isdefined( level.var_465128b42ee87684 ) )
            {
                foreach ( struct in level.var_465128b42ee87684 )
                {
                    dist = distance2d( struct.origin, victim.origin );
                    
                    if ( dist <= struct.radius )
                    {
                        self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"radio_pinged" ) );
                    }
                }
            }
            
            if ( isdefined( level.activetowers ) && isdefined( self.team ) )
            {
                foreach ( instance in level.activetowers )
                {
                    if ( instance.activeteam === self.team )
                    {
                        dist = distance2dsquared( instance.origin, victim.origin );
                        
                        if ( dist <= level.var_ed1d437905997e43 )
                        {
                            self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"uav_tower_pinged" ) );
                        }
                    }
                }
            }
        }
        
        if ( var_31c9ded9444b556b && isdefined( self.team ) )
        {
            var_5617f9d80d30cacf = item_weapon::function_af299135a62729b8( objweapon );
            
            if ( isdefined( var_5617f9d80d30cacf ) && var_5617f9d80d30cacf != self.team )
            {
                self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"used_enemy_weapon" ) );
            }
        }
        
        if ( meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" )
        {
            if ( inflictor.threwback )
            {
                if ( objweapon )
                {
                    thread gamelogic_mp::threadedsetweaponstatbyname( objweapon, 1, "debuff_kills" );
                }
                
                self.modifiers[ "throwback_grenade_kill" ] = 1;
                self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"throwback_grenade" ) );
            }
        }
        
        if ( meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" )
        {
            if ( inflictor.iscooked )
            {
                self.modifiers[ "with_cooked_grenade_kill" ] = 1;
                self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"hash_5b4eb501eaf86d4e" ) );
            }
        }
        
        if ( isdefined( victim.damagedplayers ) )
        {
            foreach ( guid, damagetime in victim.damagedplayers )
            {
                if ( guid === self.guid && isdefined( damagetime ) && curtime - damagetime < 15000 )
                {
                    self.modifiers[ "damager_kill" ] = 1;
                    self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"hash_d5f7402ac6e6fc0c" ) );
                }
            }
        }
        
        if ( level.teambased )
        {
            if ( isdefined( victim.damagedplayers ) )
            {
                if ( !isdefined( enemies ) )
                {
                    enemies = teams::getenemyplayers( self.team );
                }
                
                foreach ( guid, damagetime in victim.damagedplayers )
                {
                    victimisenemy = 0;
                    
                    foreach ( enemy in enemies )
                    {
                        if ( guid == enemy.guid )
                        {
                            victimisenemy = 1;
                            break;
                        }
                    }
                    
                    if ( isdefined( guid ) && guid != self.guid && victimisenemy == 0 && isdefined( damagetime ) && curtime - damagetime < 15000 )
                    {
                        self.modifiers[ "team_damager_kill" ] = 1;
                        self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"hash_fbf026161c1d9738" ) );
                    }
                }
            }
        }
        
        zoomlevel = self playergetzoomfov();
        
        if ( zoomlevel <= 22 )
        {
            self.modifiers[ "extreme_magnification_kill" ] = 1;
            self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"extreme_magnification_kill" ) );
        }
        
        if ( victim.is_fall_explosions_damage )
        {
            self.modifiers[ "fall_explosions_kill" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"fall_explosions_kill" ) );
        }
        
        if ( victim.is_shocking_reload_damage )
        {
            self.modifiers[ "shocking_reload_kill" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"shocking_reload_kill" ) );
        }
        
        if ( victim iswallrunning() )
        {
            self.modifiers[ "killonwall" ] = 1;
        }
        
        if ( inflictor.var_ef7442bad4acaf0e )
        {
            self.modifiers[ "technomancer_drone_kill" ] = 1;
            self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"technomancer_drone_kill" ) );
        }
        
        if ( weapon::function_597e1c0b6df2fada( objweapon.basename ) || weapon_utility::isbulletweapon( objweapon ) || meansofdeath == "MOD_MELEE" || meansofdeath == "MOD_MELEE_TAKEDOWN" )
        {
            if ( victim vehicle::is_in_vehicle() || isdefined( victim.lastvehicle ) )
            {
                self.modifiers[ "victim_in_vehicle" ] = 1;
                self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"victiminvehicle" ) );
                vehicle = victim vehicle::get_vehicle();
                
                if ( vehicle && vehicle_occupancy::get_driver( vehicle, 1 ) == victim || deathdata.var_48fa51f4669ad6c7 )
                {
                    self.modifiers[ "victim_driving_vehicle" ] = 1;
                }
            }
            
            if ( function_8e315fc2393f2705() )
            {
                self.modifiers[ #"in_dtp" ] = 1;
                self.modifiers[ "dtp_kill" ] = 1;
                self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"dtp_kill" ) );
                
                if ( self.var_d9dbc6867528ff82 )
                {
                    self.modifiers[ "non_forward_dtp_kill" ] = 1;
                    self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"hash_daecc6093d5a357e" ) );
                }
            }
            
            if ( self.var_58b9cb211fef48bb )
            {
                self.modifiers[ "supine_corkscrew_kill" ] = 1;
                self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"supine_corkscrew_kill" ) );
            }
            
            if ( isdefined( self.var_4632cc178c21073f ) && curtime - self.var_4632cc178c21073f <= 2500 )
            {
                self.modifiers[ "weapon_change_kill" ] = 1;
                self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"weaponswap" ) );
                
                if ( isbulletdamage )
                {
                    self.modifiers[ "weapon_change_bullet_kill" ] = 1;
                }
            }
            
            if ( isdefined( self.lastadsstarttime ) && curtime - self.lastadsstarttime <= 500 && ( weapongroup == "weapon_sniper" || weapongroup == "weapon_dmr" ) )
            {
                if ( weapongroup == "weapon_sniper" )
                {
                    self.modifiers[ "sniper_quickscope" ] = 1;
                }
                
                self.modifiers[ "quickscope" ] = 1;
                self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"quickscope" ) );
            }
            
            if ( self.var_2d5b79b93c51aa8f )
            {
                self.var_2d5b79b93c51aa8f = undefined;
                self.modifiers[ "wall_bang_kill" ] = 1;
                self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"wall_bang_kill" ) );
            }
            
            if ( self ismeatshieldattacker() && !victim ismeatshieldvictim() )
            {
                self.modifiers[ "meat_shield_kill" ] = 1;
                self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"hash_b09b8381de375238" ) );
            }
            
            if ( victim ismeatshieldattacker() )
            {
                meatshieldvictim = victim getmeatshieldpartner();
                
                if ( isdefined( meatshieldvictim ) )
                {
                    if ( self.team == meatshieldvictim.team )
                    {
                        self.modifiers[ "meat_shield_save" ] = 1;
                    }
                }
            }
            
            if ( self.var_5799a77f18d0229a || isdefined( self.var_9e094dd56f970a03 ) && curtime - self.var_9e094dd56f970a03 <= 1000 )
            {
                self.modifiers[ "while_wall_jump_kill" ] = 1;
                self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"while_wall_jump_kill" ) );
            }
            
            if ( self.isactiverolling || isdefined( self.var_c879847af9201fb6 ) && curtime - self.var_c879847af9201fb6 <= 2500 )
            {
                self.modifiers[ "recent_active_roll_kill" ] = 1;
                self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"recent_active_roll_kill" ) );
            }
            
            if ( self isonzipline() || self isonascender() )
            {
                self.modifiers[ "ascender_kill" ] = 1;
            }
            
            if ( function_853f2fa3d548d7ec( victim ) && function_853f2fa3d548d7ec( self ) )
            {
                if ( attackerisinflictor )
                {
                    self.modifiers[ "air_to_air_kill" ] = 1;
                }
            }
            else
            {
                if ( attackerisinflictor )
                {
                    var_41360f0bcfc012aa = self function_41360f0bcfc012aa();
                    var_4ba6b2598231ad0f = isdefined( self.var_a0a222315f11cfef );
                    
                    if ( self iswallrunning() )
                    {
                        self.modifiers[ "wallkill" ] = 1;
                    }
                    else if ( function_853f2fa3d548d7ec( self ) )
                    {
                        if ( ( weapon::iscacprimaryorsecondary( objweapon ) || weapon::isthrowingknife( objweapon ) ) && !weapon::iskillstreakweapon( objweapon.basename ) && !self.assistedsuicide )
                        {
                            self.modifiers[ "jumpkill" ] = 1;
                            self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"jumpkill" ) );
                        }
                    }
                    else if ( events_issliding() )
                    {
                        self.modifiers[ "slidekill" ] = 1;
                        self.modifiers[ "sliding" ] = 1;
                        self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"slide" ) );
                        
                        if ( var_f4061506239fc0bd < 0.7071 && var_7c42446588b35c76 > 50 )
                        {
                            self.modifiers[ "non_forward_slide_kill" ] = 1;
                            self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"non_forward_slide_kill" ) );
                        }
                    }
                    else if ( self isonladder() )
                    {
                        self.modifiers[ "onladder" ] = 1;
                        self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"onladder" ) );
                    }
                    else if ( self.var_391c5dbd8fb94d36 && curtime - self.var_391c5dbd8fb94d36 <= 4000 )
                    {
                        self.modifiers[ "after_wingsuit_kill" ] = 1;
                        self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"after_wingsuit_kill" ) );
                    }
                    else if ( var_41360f0bcfc012aa || var_4ba6b2598231ad0f && curtime - self.var_a0a222315f11cfef <= 2000 )
                    {
                        self.modifiers[ "while_grappling_kill" ] = 1;
                        self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"while_grappling_kill" ) );
                    }
                    
                    if ( !var_41360f0bcfc012aa && var_4ba6b2598231ad0f && curtime - self.var_a0a222315f11cfef <= 4000 )
                    {
                        self.modifiers[ "shortly_after_grappling" ] = 1;
                        self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"shortly_after_grappling" ) );
                    }
                    
                    if ( !isdefined( vehicle ) )
                    {
                        stance = self getstance();
                        
                        switch ( stance )
                        {
                            case #"hash_c6775c88e38f7803":
                                self.modifiers[ "standing_kill" ] = 1;
                                self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"standing" ) );
                                break;
                            case #"hash_d91940431ed7c605":
                                self.modifiers[ "prone_kill" ] = 1;
                                self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"prone" ) );
                                
                                if ( !( meansofdeath == "MOD_MELEE" || meansofdeath == "MOD_MELEE_TAKEDOWN" ) )
                                {
                                    function_d71060ad67bd36ea();
                                }
                                
                                break;
                            case #"hash_3fed0cbd303639eb":
                                self.modifiers[ "crouch_kill" ] = 1;
                                self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"crouch" ) );
                                break;
                        }
                    }
                }
                
                if ( var_31c9ded9444b556b && isskeetshooter( self, objweapon, meansofdeath, attackerposition, victim ) )
                {
                    self.modifiers[ "killinair" ] = 1;
                }
            }
        }
        
        function_60636f66ff66ed50( objweapon, meansofdeath, inflictor, victim );
    }
    
    if ( weapon::iskillstreakweaponname( objweapon.basename ) )
    {
        killstreakref = killstreak::getkillstreaknamefromweapon( objweapon );
        
        if ( !self.var_b753ecf2305ccb71[ killstreakref ] )
        {
            self.var_b753ecf2305ccb71[ killstreakref ] = 1;
            self.modifiers[ "unique_scorestreak_kill" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"unique_scorestreak_kill" ) );
        }
    }
    
    attackerdata = victim.attackerdata[ self.guid ];
    
    if ( attackerdata.var_22b37ea8a43d69a2 == "ENV_EXPLOSIVE" || self.var_4c99c8a81c239b07 || self.var_ce0ad07ff09a1aca )
    {
        self.var_4c99c8a81c239b07 = undefined;
        self.var_ce0ad07ff09a1aca = undefined;
        self.modifiers[ "environmental_hazard_kill" ] = 1;
        self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"environmental_hazard_kill" ) );
    }
    
    if ( inflictor.streakinfo.mpstreaksysteminfo.source == "carepackage" || inflictor.var_f1883f6e151e0ab.mpstreaksysteminfo.source == "carepackage" )
    {
        self.modifiers[ "care_package_streak_kill" ] = 1;
        self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"care_package_streak_kill" ) );
        
        if ( inflictor.streakinfo.mpstreaksysteminfo.var_36d265ac42039b40.guid == victim.guid || inflictor.var_f1883f6e151e0ab.mpstreaksysteminfo.var_36d265ac42039b40.guid == victim.guid )
        {
            self.modifiers[ "care_package_owner_streak_kill" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"care_package_owner_streak_kill" ) );
        }
    }
    
    if ( ( inflictor.streakinfo.bundle.var_f088013d20169bf3 ?? #"none" ) != #"none" || ( inflictor.var_f1883f6e151e0ab.bundle.var_f088013d20169bf3 ?? #"none" ) != #"none" )
    {
        self.modifiers[ #"overclocked_killstreak_kill" ] = 1;
    }
    
    if ( var_31c9ded9444b556b && objweapon.isalternate )
    {
        self.modifiers[ "isaltmode" ] = 1;
        self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"isaltmode" ) );
    }
    
    if ( self.lastkilledby === victim )
    {
        self.modifiers[ "revenge" ] = 1;
        self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"revenge" ) );
    }
    
    nemesis = getnemesis();
    
    if ( arraycontains( nemesis, victimguid ) )
    {
        self.modifiers[ "killedNemesis" ] = 1;
        self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"nemesis" ) );
    }
    
    if ( self.var_850991e8213a0549 )
    {
        self.var_850991e8213a0549 = undefined;
        self.modifiers[ "chi_style_nemesis_kill" ] = 1;
        self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"chi_style_nemesis_kill" ) );
    }
    
    if ( self.var_54dfc5a46377bb64 || self.var_917038143d36327f[ "flashed" ] )
    {
        self.modifiers[ "attacker_flashed" ] = 1;
        self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"attacker_flashed" ) );
    }
    
    if ( self.ishaywire || self.var_917038143d36327f[ "shocked" ] )
    {
        self.modifiers[ "attacker_haywired" ] = 1;
        self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"attacker_haywired" ) );
    }
    
    if ( self.isstunned || self.var_917038143d36327f[ "stunned" ] )
    {
        self.modifiers[ "attacker_stunned" ] = 1;
        self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"attacker_stunned" ) );
    }
    
    if ( player::function_ac6830fc9a3124c2( self ) || self.var_917038143d36327f[ "smoked" ] )
    {
        self.modifiers[ "attacker_smoked" ] = 1;
        self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"attacker_smoked" ) );
    }
    
    if ( player::function_ed0f4304ef2eb551( victim ) || victim.var_917038143d36327f[ "pulsed" ] )
    {
        self.modifiers[ "victim_visible_on_hb_sensor" ] = 1;
        self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"victim_visible_on_hb_sensor" ) );
    }
    
    if ( player::function_984e56e31791b0b0( victim ) || victim.var_917038143d36327f[ "snapped" ] )
    {
        self.modifiers[ "victim_snapped" ] = 1;
        self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"victim_snapped" ) );
    }
    
    if ( player::function_984e56e31791b0b0( self ) || victim.var_917038143d36327f[ "snapped" ] )
    {
        self.modifiers[ "attacker_snapped" ] = 1;
        self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"attacker_snapped" ) );
    }
    
    if ( function_392bd8e4ff44f2c6( self, victim ) )
    {
        self.modifiers[ "victim_pinged_by_portable_radar" ] = 1;
        self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"victim_pinged_by_portable_radar" ) );
        
        if ( self.var_5a9f8ade4d7872c9 == self )
        {
            self.modifiers[ "victim_pinged_by_attackers_portable_radar" ] = 1;
            self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"victim_pinged_by_attackers_portable_radar" ) );
        }
    }
    
    if ( victim.trapped_by_razor_wire )
    {
        self.modifiers[ "victim_trapped_by_razor_wire" ] = 1;
        self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"victim_trapped_by_razor_wire" ) );
        victim.trapped_by_razor_wire = undefined;
    }
    
    if ( victim.var_2043360363d22f5b )
    {
        self.modifiers[ "victim_marked_by_seeker_drone" ] = 1;
        self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"victim_marked_by_seeker_drone" ) );
        
        if ( isdefined( victim.var_53335d43c07de017 ) )
        {
            if ( victim.var_53335d43c07de017 == self )
            {
                self.modifiers[ "victim_marked_by_attackers_seeker_drone" ] = 1;
                self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"victim_marked_by_attackers_seeker_drone" ) );
            }
        }
        
        victim.var_2043360363d22f5b = undefined;
        victim.var_53335d43c07de017 = undefined;
        victim.var_3d9ce8b820bd6625 = undefined;
    }
    
    if ( self.var_3ce5ee980d4c5036 )
    {
        self.modifiers[ "attacker_spawned_from_tac_insert" ] = 1;
        self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"attacker_spawned_from_tac_insert" ) );
    }
    
    if ( self isswimming() )
    {
        self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"swimming" ) );
        
        if ( self isswimunderwater() )
        {
            self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"underwater" ) );
        }
    }
    
    if ( isagent( victim ) )
    {
        if ( player::function_4ec00e606da98a80( self ) )
        {
            self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"unaware" ) );
        }
    }
    
    hitloc = 0;
    
    if ( damage_utility::validshotcheck( meansofdeath, self ) )
    {
        switch ( deathdata.hitloc )
        {
            case #"hash_db653a4972b3c13b":
                hitloc = ae_utility::function_2d1565a236387b2( #"hit_loc", #"none" );
                break;
            case #"hash_8a1772f5f912c880":
                hitloc = ae_utility::function_2d1565a236387b2( #"hit_loc", #"helmet" );
                break;
            case #"hash_b107b5547c755d23":
                hitloc = ae_utility::function_2d1565a236387b2( #"hit_loc", #"head" );
                break;
            case #"hash_92bbfe494d03d772":
                hitloc = ae_utility::function_2d1565a236387b2( #"hit_loc", #"neck" );
                break;
            case #"hash_24df6c1a53c03c53":
                hitloc = ae_utility::function_2d1565a236387b2( #"hit_loc", #"upper_torso" );
                break;
            case #"hash_51d5d0b9add9cc5a":
                hitloc = ae_utility::function_2d1565a236387b2( #"hit_loc", #"left_upper_arm" );
                break;
            case #"hash_d42e71cd9f1e822f":
                hitloc = ae_utility::function_2d1565a236387b2( #"hit_loc", #"right_upper_arm" );
                break;
            case #"hash_a7980c387477e7bb":
                hitloc = ae_utility::function_2d1565a236387b2( #"hit_loc", #"left_lower_arm" );
                break;
            case #"hash_5d5aac570f6fd382":
                hitloc = ae_utility::function_2d1565a236387b2( #"hit_loc", #"right_lower_arm" );
                break;
            case #"hash_da51cc36a471058":
                hitloc = ae_utility::function_2d1565a236387b2( #"hit_loc", #"left_hand" );
                break;
            case #"hash_da2f35145aa58933":
                hitloc = ae_utility::function_2d1565a236387b2( #"hit_loc", #"right_hand" );
                break;
            case #"hash_810a7426c8bac3ac":
                hitloc = ae_utility::function_2d1565a236387b2( #"hit_loc", #"left_upper_leg" );
                break;
            case #"hash_1cbc508a2fe01b79":
                hitloc = ae_utility::function_2d1565a236387b2( #"hit_loc", #"right_upper_leg" );
                break;
            case #"hash_7b36142458a6c2d5":
                hitloc = ae_utility::function_2d1565a236387b2( #"hit_loc", #"left_lower_leg" );
                break;
            case #"hash_a638fec9040cfcf4":
                hitloc = ae_utility::function_2d1565a236387b2( #"hit_loc", #"right_lower_leg" );
                break;
            case #"hash_168c74e879f0ba11":
                hitloc = ae_utility::function_2d1565a236387b2( #"hit_loc", #"left_foot" );
                break;
            case #"hash_9536712388e65bce":
                hitloc = ae_utility::function_2d1565a236387b2( #"hit_loc", #"right_foot" );
                break;
            case #"hash_fb5b5e6c07253005":
                hitloc = ae_utility::function_2d1565a236387b2( #"hit_loc", #"gun" );
                break;
            case #"hash_b2116949ba13eb10":
                hitloc = ae_utility::function_2d1565a236387b2( #"hit_loc", #"shield" );
                break;
            case #"hash_25789111b74943b4":
                hitloc = ae_utility::function_2d1565a236387b2( #"hit_loc", #"armor" );
                break;
            case #"hash_df21ff8a0b282215":
                hitloc = ae_utility::function_2d1565a236387b2( #"hit_loc", #"soft" );
                break;
        }
    }
    
    self.modifiers[ "hit_loc" ] = challenges::function_a23641f33e985edb( self.modifiers[ "hit_loc" ], hitloc );
    
    if ( self.carryinghostage )
    {
        self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"holding_hostage" ) );
    }
    
    if ( self function_52f6e3ae185d4603( victim getentitynumber() ) )
    {
        self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"pinged" ) );
    }
    
    if ( isdefined( level.var_f645d9b684d3e6b7 ) && level.var_f645d9b684d3e6b7.size > 0 )
    {
        self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"hash_ea1d366ed74d6ea5" ) );
    }
    
    if ( calloutmarkerping_mp::function_577661f056cb61e9( victim ) )
    {
        self.modifiers[ "pinged_by_friendly" ] = 1;
        self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"pinged_by_friendly" ) );
    }
    
    if ( var_31c9ded9444b556b && weapongroup == "other" )
    {
        checklethalequipmentachievement( objweapon );
    }
    
    if ( deathdata.meansofdeath == "MOD_EXPLOSIVE" || deathdata.meansofdeath == "MOD_GRENADE_SPLASH" || deathdata.meansofdeath == "MOD_GRENADE" || attackerdata.var_22b37ea8a43d69a2 == "ENV_EXPLOSIVE" || inflictor.classname == "rocket" && !level.var_fe3993a23186adc9[ objweapon.basenamehash ] )
    {
        self.modifiers[ "explosive_damage" ] = 1;
        self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"explosive_damage" ) );
    }
    
    if ( self.haskillstreakactive || uav_bigmap::function_cdd5542320f92744() && isbrgamemode() && isdefined( uav_bigmap::function_17f93121881b4278( self ) ) )
    {
        self.modifiers[ "while_killstreak_active" ] = 1;
        self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"while_killstreak_active" ) );
    }
    
    if ( isdefined( self.var_c0f99e46094dea7a ) )
    {
        var_5b1bbf683b432f9e = gettime() / 1000 - self.var_c0f99e46094dea7a;
        
        if ( var_5b1bbf683b432f9e <= 60 )
        {
            self.modifiers[ "recently_entered_poi" ] = 1;
            self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"recently_entered_poi" ) );
        }
    }
    
    if ( isdefined( level.activitymanager ) && isdefined( level.activitymanager.var_a9b234c9e9601ab0 ) )
    {
        activity = [[ level.activitymanager.var_a9b234c9e9601ab0 ]]( self.team );
        
        if ( self == activity.var_ca369031b554da2f && activity.type == "BR_CONTRACT_MOSTWANTED" )
        {
            self.modifiers[ "while_most_wanted_target" ] = 1;
            self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"while_most_wanted_target" ) );
        }
        
        activity = [[ level.activitymanager.var_a9b234c9e9601ab0 ]]( victim.team );
        
        if ( victim == activity.var_ca369031b554da2f && activity.type == "BR_CONTRACT_MOSTWANTED" )
        {
            self.modifiers[ "victim_is_most_wanted_target" ] = 1;
            self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"victim_is_most_wanted_target" ) );
        }
    }
    
    if ( level.gulag.shutdown )
    {
        self.modifiers[ "after_gulag_closed" ] = 1;
        self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"after_gulag_closed" ) );
    }
    
    if ( isbrgamemode() )
    {
        var_20fee393a77d187e = br_circle::function_8bdcbb2e3fe350() && level.br_circle.circleindex == 1 || !br_circle::function_8bdcbb2e3fe350() && level.br_circle.circleindex == 0;
        
        if ( var_20fee393a77d187e )
        {
            self.modifiers[ "during_first_circle" ] = 1;
            self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"during_first_circle" ) );
        }
        
        if ( isdefined( level.br_circle ) && level.br_circle.circleindex == level.br_level.br_circleclosetimes.size - 1 )
        {
            self.modifiers[ "during_final_circle" ] = 1;
            self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"during_final_circle" ) );
        }
        
        if ( !isdefined( self.var_abf0654a0b40d48e ) )
        {
            self.var_abf0654a0b40d48e = [];
        }
        
        if ( self.objweapon.basename && !arraycontains( self.var_abf0654a0b40d48e, self.objweapon.basename ) )
        {
            self.var_abf0654a0b40d48e[ self.var_abf0654a0b40d48e.size ] = self.objweapon.basename;
            self.modifiers[ "with_weapon_previously_unused" ] = 1;
            self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"with_weapon_previously_unused" ) );
        }
        
        if ( isdefined( self.freefallstarttime ) )
        {
            if ( gettime() - self.freefallstarttime < 60000 )
            {
                self.modifiers[ "hot_drop_kill" ] = 1;
                self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"hot_drop_kill" ) );
            }
        }
        
        if ( helper_drone::function_11513d6fb722aba8() )
        {
            self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"hash_269ddbb1abddd9fb" ) );
        }
        
        if ( isdefined( level.brgametype.respawnenable ) && !level.brgametype.respawnenable )
        {
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"hash_990a8a1506de6d12" ) );
        }
        
        if ( self.lootperks.size > 0 )
        {
            self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"hash_73d44cfb17993b9e" ) );
        }
    }
    
    if ( function_a1bc2d99430319eb( 2 ) )
    {
        self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"hash_3c221a19be5ce18c" ) );
    }
    
    if ( function_e50cf9a405270aae( inflictor, meansofdeath ) )
    {
        self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"hash_6533df9364731d15" ) );
    }
    
    if ( victim function_f1fe3d6ed7236d89() )
    {
        self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"victim_is_sniper" ) );
    }
    
    if ( self.stealth_perks_to_remove )
    {
        self.modifiers[ "stealth_enabled" ] = 1;
        self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"stealth_enabled" ) );
    }
    
    if ( self.var_b87cafbca06df20f )
    {
        self.modifiers[ "while_in_obj_kill" ] = 1;
        self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"while_in_obj_kill" ) );
    }
    
    if ( self.var_63490a14ef1618a3 && self.var_f05d2dfb2652889f > 1 )
    {
        self.modifiers[ "while_slayer_kill" ] = 1;
        self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"while_slayer_kill" ) );
    }
    
    if ( self.attackerdata )
    {
        foreach ( var_9b81026c6c1365fc in self.attackerdata )
        {
            equipmenttype = weapon::getequipmenttype( var_9b81026c6c1365fc.objweapon );
            
            if ( equipmenttype == "lethal" )
            {
                self.modifiers[ "while_damaged_by_lethal_kill" ] = 1;
                self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"while_damaged_by_lethal_kill" ) );
                break;
            }
        }
    }
    
    attackerdata = victim.attackerdata[ self.guid ];
    
    if ( isdefined( attackerdata.damagesources ) )
    {
        foreach ( damagesource in attackerdata.damagesources )
        {
            equipmenttype = weapon::getequipmenttype( damagesource.objweapon );
            
            if ( equipmenttype == "lethal" )
            {
                self.modifiers[ "enemy_damaged_by_lethal_kill" ] = 1;
                self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"enemy_damaged_by_lethal_kill" ) );
                break;
            }
        }
    }
    
    if ( isdefined( self.lastadsstarttime ) && curtime - self.lastadsstarttime <= 1000 )
    {
        self.modifiers[ "recent_ads_kill" ] = 1;
        self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"recent_ads_kill" ) );
    }
    
    if ( objweapon.var_25b0062cbe4d9c99 == #"sat_ks_sniper_briefcase" && self.modifiers[ "wall_bang_kill" ] )
    {
        self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"sniper_briefcase_wall_bang_kill" ) );
    }
    
    if ( self.var_dfb4efc4c9e3d3ec )
    {
        self.modifiers[ "scout_buff_active" ] = 1;
        self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"scout_buff_active" ) );
    }
    
    if ( !self.var_4e88f6e44ad3dc79 && !self.var_7e5e10a6e6422f11 && self.var_b6aeeab42ea78ff >= 1 )
    {
        if ( !isprimaryweaponclass( _weaponclass ) )
        {
            self.var_7e5e10a6e6422f11 = 1;
            self.var_38810aee0d242063 = undefined;
            self.var_b1a7bcec9cf49488 = undefined;
        }
        else if ( self.var_2fb177f83bfb1a31[ objweapon.basename ] )
        {
            if ( !isdefined( self.var_38810aee0d242063 ) )
            {
                self.var_38810aee0d242063 = objweapon.basename;
            }
            
            if ( !self.var_b1a7bcec9cf49488 && isdefined( self.var_5273e52e39429943 ) && self.var_5273e52e39429943 != objweapon.basename )
            {
                self.var_b1a7bcec9cf49488 = 1;
            }
        }
    }
    
    if ( isdefined( self.var_4c52b2420aae9702 ) && curtime - self.var_4c52b2420aae9702 <= 4000 )
    {
        self.modifiers[ "after_scavenger_bag_kill" ] = 1;
        self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"after_scavenger_bag_kill" ) );
    }
    
    if ( self.modifiers[ "wasTricked" ] )
    {
        self.modifiers[ "victim_recently_destroyed_own_holo" ] = 1;
        self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"victim_recently_destroyed_own_holo" ) );
    }
    
    if ( victim.var_917038143d36327f )
    {
        victim.var_917038143d36327f = undefined;
    }
    
    if ( challenges::function_21f89245c36f1704( inflictor ) )
    {
        self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"hash_9989407564cb2f27" ) );
    }
}

// Namespace events
// Params 4
// Checksum 0xb3d2ecd6, Offset: 0xdf43
// Size: 0x5e
function function_60636f66ff66ed50( objweapon, meansofdeath, inflictor, victim )
{
    function_713c7a699cbc920a( inflictor, objweapon );
    function_641681d08c786531( inflictor.glgrenadeparent ?? objweapon );
    function_38038469acf6cd3e( victim, inflictor, objweapon, meansofdeath );
    function_8c660d76a87e2d97( victim );
}

// Namespace events
// Params 4, eflags: 0x4
// Checksum 0xd444297d, Offset: 0xdfa9
// Size: 0x4bf
function private function_38038469acf6cd3e( victim, inflictor, objweapon, meansofdeath )
{
    if ( victim.var_b52498c11832e4ea )
    {
        var_fd86e5f678d6e4ef = 1;
        self.modifiers[ "vision_pulse_kill" ] = 1;
        self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"vision_pulse_kill" ) );
    }
    
    if ( victim.var_96527d1d3c7cdb7e )
    {
        var_fd86e5f678d6e4ef = 1;
        self.modifiers[ "survival_life_drain_kill" ] = 1;
        self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"survival_life_drain_kill" ) );
    }
    
    if ( self.var_ae2956efdf721fbe.size > 0 )
    {
        self.modifiers[ "while_inside_bubble_shield_kill" ] = 1;
        self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"while_inside_bubble_shield_kill" ) );
    }
    
    if ( victim.var_b57d118f387faec7 )
    {
        var_fd86e5f678d6e4ef = 1;
        self.modifiers[ "black_hat_hacked_kill" ] = 1;
        self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"black_hat_hacked_kill" ) );
    }
    
    if ( victim.var_1229e9bf5e1e066e )
    {
        var_fd86e5f678d6e4ef = 1;
        self.modifiers[ "mega_jump_stunned_kill" ] = 1;
        self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"mega_jump_stunned_kill" ) );
    }
    
    if ( victim.var_dcf8da1beef94913 )
    {
        var_fd86e5f678d6e4ef = 1;
        self.modifiers[ "shadow_break_stunned_kill" ] = 1;
        self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"shadow_break_stunned_kill" ) );
    }
    
    if ( victim._blackboard.var_79b2d8d61c6ef8b1 && self.var_477fb40f9399f4a6 )
    {
        var_fd86e5f678d6e4ef = 1;
        self.modifiers[ "monkey_bomb_attract_kill" ] = 1;
        self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"monkey_bomb_attract_kill" ) );
    }
    
    if ( victim.flame_blast_burning )
    {
        var_fd86e5f678d6e4ef = 1;
        self.modifiers[ "flame_blast_burning" ] = 1;
        self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"flame_blast_burning" ) );
    }
    
    attackerisinflictor = attackerisinflictor( self, inflictor, objweapon, meansofdeath );
    
    if ( attackerisinflictor )
    {
        curtime = gettime();
        
        if ( isdefined( self.var_cf8af0d0f209d2bb ) && curtime - self.var_cf8af0d0f209d2bb <= 2000 )
        {
            self.modifiers[ "after_teleport_kill" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"after_teleport_kill" ) );
        }
        
        if ( self.megajumpdata.megajumpinprogress || self.megajumpendtime && curtime - self.megajumpendtime <= 2000 )
        {
            self.modifiers[ "mega_jump_kill" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"mega_jump_kill" ) );
        }
    }
    
    if ( var_fd86e5f678d6e4ef )
    {
        self.modifiers[ "ability_kill" ] = 1;
        self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"ability_kill" ) );
    }
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0x68e1eef5, Offset: 0xe470
// Size: 0x5b
function private function_8c660d76a87e2d97( victim )
{
    if ( self.modifiers[ "active_camo_kill" ] )
    {
        self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"active_camo_enabled" ) );
    }
}

// Namespace events
// Params 1
// Checksum 0xafdb2ff1, Offset: 0xe4d3
// Size: 0x7a2
function function_920a35d38f329ffb( victim )
{
    if ( self.var_237757064cda082f || victim.var_917038143d36327f[ "flashed" ] )
    {
        var_e4c269673b34bfd6 = 1;
        var_6af9f8eb05fab28 = 1;
        self.var_237757064cda082f = undefined;
        self.modifiers[ "flashed_kill" ] = 1;
        self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"hash_72b1047c1944c6ff" ) );
    }
    
    if ( self.var_7576e5f315dd11f5 || victim.var_917038143d36327f[ "stunned" ] )
    {
        var_e4c269673b34bfd6 = 1;
        var_6af9f8eb05fab28 = 1;
        self.var_7576e5f315dd11f5 = undefined;
        self.modifiers[ "concussed_kill" ] = 1;
        self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"hash_16c89bd5de678bcb" ) );
    }
    
    if ( self.var_99732766273aec20 )
    {
        var_e4c269673b34bfd6 = 1;
        self.var_99732766273aec20 = undefined;
        self.modifiers[ "kill_in_your_smoke" ] = 1;
        self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"hash_b6321b02e5fddd59" ) );
    }
    
    if ( self.var_ecbbdda6352284db )
    {
        var_e4c269673b34bfd6 = 1;
        self.var_ecbbdda6352284db = undefined;
        self.modifiers[ "stim_shot_kill" ] = 1;
        self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"stim_shot_kill" ) );
    }
    
    if ( self.var_45726d48cb2933af )
    {
        var_e4c269673b34bfd6 = 1;
        self.var_45726d48cb2933af = undefined;
        self.modifiers[ "prox_alarm_kill" ] = 1;
        self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"hash_aed39059bd8a508f" ) );
    }
    
    if ( self.var_421ca81478fc2aef || victim.var_917038143d36327f[ "shocked" ] )
    {
        var_e4c269673b34bfd6 = 1;
        var_6af9f8eb05fab28 = 1;
        self.var_421ca81478fc2aef = undefined;
        self.modifiers[ "shock_kill" ] = 1;
        self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"shock_kill" ) );
    }
    
    if ( self.var_841452f4ac91f5bd )
    {
        var_e4c269673b34bfd6 = 1;
        self.var_841452f4ac91f5bd = undefined;
        self.modifiers[ "decoy_grenade_kill" ] = 1;
        self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"decoy_grenade_kill" ) );
    }
    
    if ( self.var_c6835bd1faf41221 )
    {
        var_e4c269673b34bfd6 = 1;
        var_6af9f8eb05fab28 = 1;
        self.var_c6835bd1faf41221 = undefined;
        self.modifiers[ "victim_emp_affected" ] = 1;
        self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"victim_emp_affected" ) );
    }
    
    if ( self.var_7dfa8e416c7d2d06 )
    {
        var_e4c269673b34bfd6 = 1;
        self.var_7dfa8e416c7d2d06 = undefined;
        self.modifiers[ "spycam_kill" ] = 1;
        self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"spycam_kill" ) );
    }
    
    if ( self.var_95a789937b05993d )
    {
        var_e4c269673b34bfd6 = 1;
        var_6af9f8eb05fab28 = 1;
        self.var_95a789937b05993d = undefined;
        self.modifiers[ "victim_sensor_grenade_affected" ] = 1;
        self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"victim_sensor_grenade_affected" ) );
    }
    
    if ( self.var_47f09ec55dfe6150 )
    {
        var_e4c269673b34bfd6 = 1;
        var_6af9f8eb05fab28 = 1;
        self.var_47f09ec55dfe6150 = undefined;
    }
    
    var_d010b06c3c14eb1d = level.var_d010b06c3c14eb1d ?? %"sat_gas_grenade_mp";
    
    if ( victim.debuffinfo[ var_d010b06c3c14eb1d ] )
    {
        owned_debuff = 0;
        
        foreach ( debuff in victim.debuffinfo[ var_d010b06c3c14eb1d ] )
        {
            if ( debuff.attacker.guid == self.guid )
            {
                owned_debuff = 1;
                break;
            }
        }
        
        if ( owned_debuff )
        {
            var_e4c269673b34bfd6 = 1;
            var_6af9f8eb05fab28 = 1;
            self.modifiers[ "victim_afected_own_gas_grenade" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"victim_afected_own_gas_grenade" ) );
        }
    }
    
    if ( victim.debuffinfo[ %"sat_gas_trap_plantable_mp" ] )
    {
        owned_debuff = 0;
        
        foreach ( debuff in victim.debuffinfo[ %"sat_gas_trap_plantable_mp" ] )
        {
            if ( debuff.attacker.guid == self.guid )
            {
                owned_debuff = 1;
                break;
            }
        }
        
        if ( owned_debuff )
        {
            self.modifiers[ "victim_afected_own_gas_trap" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"victim_afected_own_gas_trap" ) );
        }
    }
    
    if ( var_e4c269673b34bfd6 )
    {
        self.var_e4c269673b34bfd6 = undefined;
        self.modifiers[ "tactical_kill" ] = 1;
        self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"your_tactical_kill" ) );
    }
    
    if ( var_6af9f8eb05fab28 )
    {
        self.var_6af9f8eb05fab28 = undefined;
        self.modifiers[ "impaired_by_tactical_kill" ] = 1;
        self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"impaired_by_tactical_kill" ) );
    }
}

// Namespace events
// Params 3
// Checksum 0x8b6b7901, Offset: 0xec7d
// Size: 0x128
function function_8f26df18dbcd57c2( objweapon, meansofdeath, deathdata )
{
    var_31c9ded9444b556b = isdefined( objweapon.basename ) && objweapon.basename != "none";
    
    if ( !var_31c9ded9444b556b )
    {
        return;
    }
    
    if ( damage_utility::validshotcheck( meansofdeath, self ) && meansofdeath != "MOD_GRENADE" && ( meansofdeath == "MOD_HEAD_SHOT" || namespace_4c6ef5221f3fa284::function_5d96d2a079feb03a( deathdata.hitloc ) || function_a486f361db213284( objweapon, deathdata ) ) && !stat_limits::function_608486f90656f2f7( #"limitheadshots" ) )
    {
        self.modifiers[ "headshot" ] = 1;
        self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"headshot" ) );
        
        if ( !isdefined( self.headshotkillchain ) )
        {
            self.headshotkillchain = 0;
        }
        
        self.headshotkillchain++;
        return;
    }
    
    self.headshotkillchain = 0;
}

// Namespace events
// Params 2
// Checksum 0xde1476d2, Offset: 0xedad
// Size: 0x28b
function function_713c7a699cbc920a( inflictor, objweapon )
{
    var_e1835d03268913bb = weapons::recommendedstatusbyseason( objweapon, inflictor );
    
    if ( !isdefined( var_e1835d03268913bb ) )
    {
        return;
    }
    
    if ( var_e1835d03268913bb[ 0 ] )
    {
        self.modifiers[ "recommended_season_0" ] = 1;
        self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"recommended_season_0" ) );
    }
    
    if ( var_e1835d03268913bb[ 1 ] )
    {
        self.modifiers[ "recommended_season_1" ] = 1;
        self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"recommended_season_1" ) );
    }
    
    if ( var_e1835d03268913bb[ 2 ] )
    {
        self.modifiers[ "recommended_season_2" ] = 1;
        self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"recommended_season_2" ) );
    }
    
    if ( var_e1835d03268913bb[ 3 ] )
    {
        self.modifiers[ "recommended_season_3" ] = 1;
        self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"recommended_season_3" ) );
    }
    
    if ( var_e1835d03268913bb[ 4 ] )
    {
        self.modifiers[ "recommended_season_4" ] = 1;
        self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"recommended_season_4" ) );
    }
    
    if ( var_e1835d03268913bb[ 5 ] )
    {
        self.modifiers[ "recommended_season_5" ] = 1;
        self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"recommended_season_5" ) );
    }
    
    if ( var_e1835d03268913bb[ 6 ] )
    {
        self.modifiers[ "recommended_season_6" ] = 1;
        self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"recommended_season_6" ) );
    }
}

// Namespace events
// Params 1
// Checksum 0xdb830b27, Offset: 0xf040
// Size: 0x297
function function_641681d08c786531( objweapon )
{
    function_a0cae2a917082bcd( objweapon );
    var_31c9ded9444b556b = isdefined( objweapon.basename ) && objweapon.basename != "none";
    
    if ( !var_31c9ded9444b556b )
    {
        return;
    }
    
    usingsuppressor = objweapon issilenced();
    
    if ( usingsuppressor )
    {
        self.modifiers[ "attachment_flags" ] = challenges::function_a23641f33e985edb( self.modifiers[ "attachment_flags" ], ae_utility::function_2d1565a236387b2( #"weapon_attachment_flags", #"suppressor" ) );
    }
    
    if ( isdefined( objweapon.scope ) )
    {
        scopeattachment = objweapon.scope;
        basetype = getattachmentbasetype( objweapon, scopeattachment );
        
        if ( basetype == "ironsdefault" )
        {
            self.modifiers[ "attachment_flags" ] = challenges::function_a23641f33e985edb( self.modifiers[ "attachment_flags" ], ae_utility::function_2d1565a236387b2( #"weapon_attachment_flags", #"irons" ) );
        }
        else if ( basetype == "reflex" || basetype == "minireflex" )
        {
            self.modifiers[ "attachment_flags" ] = challenges::function_a23641f33e985edb( self.modifiers[ "attachment_flags" ], ae_utility::function_2d1565a236387b2( #"weapon_attachment_flags", #"reflex" ) );
        }
        else if ( basetype == "hybrid" )
        {
            self.modifiers[ "attachment_flags" ] = challenges::function_a23641f33e985edb( self.modifiers[ "attachment_flags" ], ae_utility::function_2d1565a236387b2( #"weapon_attachment_flags", #"hybrid" ) );
        }
        else if ( basetype == "acog" )
        {
            self.modifiers[ "attachment_flags" ] = challenges::function_a23641f33e985edb( self.modifiers[ "attachment_flags" ], ae_utility::function_2d1565a236387b2( #"weapon_attachment_flags", #"acog" ) );
        }
        else if ( basetype == "holo" )
        {
            self.modifiers[ "attachment_flags" ] = challenges::function_a23641f33e985edb( self.modifiers[ "attachment_flags" ], ae_utility::function_2d1565a236387b2( #"weapon_attachment_flags", #"holo" ) );
        }
        
        if ( isthermalattachment( objweapon, scopeattachment ) )
        {
            self.modifiers[ "attachment_flags" ] = challenges::function_a23641f33e985edb( self.modifiers[ "attachment_flags" ], ae_utility::function_2d1565a236387b2( #"weapon_attachment_flags", #"thermal" ) );
        }
    }
}

// Namespace events
// Params 1
// Checksum 0x62afe846, Offset: 0xf2df
// Size: 0x569
function function_a0cae2a917082bcd( objweapon )
{
    var_6b295309a15e23ed = objweapon.var_f6f9f66e9b50d71c;
    
    if ( !isdefined( var_6b295309a15e23ed ) )
    {
        return;
    }
    
    var_e1a9e6836139ab3 = 0;
    var_d2e2d72e15e4205f = [ #"isamp", #"category", #"baseref" ];
    var_287b4b3237470d77 = getweapondefaultattachments( weapon::getdefaultweaponbasename( objweapon.basename ) );
    
    foreach ( attachment in var_6b295309a15e23ed )
    {
        bundle = getscriptbundlefieldvalues( attachment, var_d2e2d72e15e4205f );
        
        if ( !isdefined( bundle ) )
        {
            continue;
        }
        
        var_460feca106cb4463 = bundle.baseref ?? "";
        var_c1a114f6925e9d64 = isdefined( bundle.category ) ? toupper( getscriptbundlefieldvalue( bundle.category, #"ref" ) ) : undefined;
        
        if ( bundle.isamp )
        {
            self.modifiers[ "weapon_has_AMP" ] = 1;
            self.modifiers[ "attachment_flags" ] = challenges::function_a23641f33e985edb( self.modifiers[ "attachment_flags" ], ae_utility::function_2d1565a236387b2( #"weapon_attachment_flags", #"amp" ) );
        }
        
        if ( isdefined( var_c1a114f6925e9d64 ) )
        {
            if ( var_c1a114f6925e9d64 == "CONVERSIONKIT" )
            {
                self.modifiers[ "weapon_has_conversionkit" ] = 1;
                self.modifiers[ "attachment_flags" ] = challenges::function_a23641f33e985edb( self.modifiers[ "attachment_flags" ], ae_utility::function_2d1565a236387b2( #"weapon_attachment_flags", #"CONVERSIONKIT" ) );
            }
            
            if ( var_c1a114f6925e9d64 == "OPTIC" || issubstr( var_460feca106cb4463, "scope" ) )
            {
                self.modifiers[ "weapon_has_scope" ] = 1;
                self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"hash_efa8718cf03a1110" ) );
            }
            
            if ( var_c1a114f6925e9d64 != "RECEIVER" && var_c1a114f6925e9d64 != "NONE" && !arraycontains( var_287b4b3237470d77, var_460feca106cb4463 ) )
            {
                var_e1a9e6836139ab3++;
            }
        }
        
        if ( issubstr( var_460feca106cb4463, "ammo" ) && var_c1a114f6925e9d64 == "GUNPERK" )
        {
            self.modifiers[ "weapon_has_alternate_ammo" ] = 1;
            self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"hash_f9b754255057f953" ) );
        }
    }
    
    if ( function_46ec0ebc88b3a6fc( objweapon ) || objweapon.basenamehash == %"t10_bunkerbuster_gl_mp" || objweapon.basenamehash == %"t10_bunkerbuster_not_burrowed_gl_mp" || objweapon.basenamehash == %"t10_bunkerbuster_round_gl_mp" )
    {
        if ( isdefined( objweapon.classname ) && ( objweapon.classname == "grenade" || objweapon.classname == "spread" || objweapon.classname == "projectile" ) )
        {
            self.modifiers[ "weapon_has_underbarrel" ] = 1;
            self.modifiers[ "attachment_flags" ] = challenges::function_a23641f33e985edb( self.modifiers[ "attachment_flags" ], ae_utility::function_2d1565a236387b2( #"weapon_attachment_flags", #"underbarrel" ) );
        }
    }
    
    if ( weapon::isakimbo( objweapon ) )
    {
        self.modifiers[ "weapon_has_akimbo" ] = 1;
        self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"akimbo" ) );
    }
    
    if ( var_e1a9e6836139ab3 == 8 )
    {
        self.modifiers[ "eight_attachments_kill" ] = 1;
        self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"eight_attachments_kill" ) );
        return;
    }
    
    if ( var_e1a9e6836139ab3 >= 5 )
    {
        self.modifiers[ "fully_loaded_kill" ] = 1;
        self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"fully_loaded_kill" ) );
        return;
    }
    
    if ( var_e1a9e6836139ab3 == 0 )
    {
        self.modifiers[ "barebones_kill" ] = 1;
        self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"barebones_kill" ) );
    }
}

// Namespace events
// Params 2
// Checksum 0xdeaa7496, Offset: 0xf850
// Size: 0x6f
function function_f49e24ff9e0db53d( attacker, victim )
{
    if ( !isdefined( victim ) )
    {
        return;
    }
    
    var_87f2e1365979e32f = teams::getteamdata( attacker.team, "aliveCount" );
    
    if ( var_87f2e1365979e32f != 1 )
    {
        return;
    }
    
    if ( !isdefined( attacker.var_84939e940d7f7bf0 ) )
    {
        attacker.var_84939e940d7f7bf0 = 0;
    }
    
    attacker.var_84939e940d7f7bf0++;
}

// Namespace events
// Params 2
// Checksum 0xe9bd00e0, Offset: 0xf8c7
// Size: 0x153
function function_8a990b3daa34d46a( winningteam, losingteam )
{
    var_2972174ae50837b0 = teams::getteamdata( losingteam, "aliveCount" );
    
    if ( var_2972174ae50837b0 != 0 )
    {
        return;
    }
    
    winningplayers = teams::getteamdata( winningteam, "players" );
    waittillframeend();
    
    foreach ( player in winningplayers )
    {
        if ( !isdefined( player.var_84939e940d7f7bf0 ) )
        {
            continue;
        }
        
        switch ( player.var_84939e940d7f7bf0 )
        {
            case 1:
                scoreeventhash = #"event_1v1";
                break;
            case 2:
                scoreeventhash = #"event_1v2";
                break;
            case 3:
                scoreeventhash = #"event_1v3";
                break;
            default:
                scoreeventhash = #"event_1v4";
                break;
        }
        
        player thread points::doscoreevent( scoreeventhash );
        return;
    }
}

// Namespace events
// Params 3
// Checksum 0xfcde2aec, Offset: 0xfa22
// Size: 0x2e6
function function_4d230763bac84313( victim, objweapon, inflictor )
{
    assert( isdefined( victim ), "<dev string:x32c>" );
    assert( isdefined( objweapon ), "<dev string:x35e>" );
    equipmentref = objweapon.equipmentref ?? equipment_mp::getequipmentreffromweapon( objweapon );
    weaponname = getcompleteweaponname( objweapon );
    
    if ( !objweapon )
    {
        return;
    }
    
    if ( weapon::iskillstreakweapon( objweapon ) || killstreak::isremotekillstreak( weaponname ) )
    {
        return;
    }
    
    if ( !equipmentref && utility::isusingremote() )
    {
        return;
    }
    
    attackerorigin = victim.var_2acdae9aaa7c06db.attackerorigin ?? self.origin;
    victimorigin = victim.var_2acdae9aaa7c06db.victimorigin ?? victim.origin;
    killdistancesq = distancesquared( attackerorigin, victimorigin );
    var_13946f336af95838 = level.scoreeventglobals.var_b6653984532303bb ?? 9843;
    var_aee1e78df2e8dd80 = var_13946f336af95838 * var_13946f336af95838;
    
    if ( ( weapon_utility::isbulletweapon( objweapon ) || weapon_utility::function_c1972d0d01397a22( objweapon ) || weapon_utility::function_186e07887b6bbeb1( objweapon ) ) && killdistancesq >= var_aee1e78df2e8dd80 )
    {
        thread points::doscoreevent( #"super_longshot" );
        self.modifiers[ "moon_shot_kill" ] = 1;
        self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"moon_shot_kill" ) );
        return;
    }
    
    if ( isdefined( equipmentref ) )
    {
        bundle = level.equipment.table[ equipmentref ].bundle;
        
        if ( isdefined( bundle.var_67321242bf5423e0 ) && isdefined( bundle.var_936f8f1b8816849d ) )
        {
            thresholddist = bundle.var_936f8f1b8816849d;
            thresholddistsq = thresholddist * thresholddist;
            
            if ( killdistancesq >= thresholddistsq )
            {
                eventinfo = damage::function_c7f203dba75721b1( victim, inflictor );
                thread points::doscoreevent( bundle.var_67321242bf5423e0, objweapon, undefined, undefined, victim, undefined, undefined, undefined, undefined, undefined, eventinfo );
                self.modifiers[ "hail_mary_kill" ] = 1;
                self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"hail_mary_kill" ) );
                return;
            }
        }
    }
    
    if ( self.modifiers[ "longshot" ] )
    {
        thread points::doscoreevent( #"longshot", undefined, undefined, undefined, victim );
    }
}

// Namespace events
// Params 3
// Checksum 0x398fed60, Offset: 0xfd10
// Size: 0x10b
function function_5f87c9aaa9f85f96( victim, meansofdeath, deathdata )
{
    assert( isdefined( victim ), "<dev string:x399>" );
    assert( isdefined( meansofdeath ), "<dev string:x3c5>" );
    
    if ( victim.inlaststand )
    {
        meansofdeath = deathdata.meansofdeath;
    }
    
    if ( meansofdeath == "MOD_EXECUTION" )
    {
        if ( self.disguised )
        {
            thread points::doscoreevent( #"spy_kit_finish" );
            self.modifiers[ "spy_kit_melee_execution_kill" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"spy_kit_melee_execution_kill" ) );
            return;
        }
        
        if ( victim.ishvt == 1 )
        {
            thread points::doscoreevent( #"execute_hvt" );
            return;
        }
        
        thread points::doscoreevent( #"execute", undefined, undefined, undefined, victim );
    }
}

// Namespace events
// Params 0
// Checksum 0x8b04d36, Offset: 0xfe23
// Size: 0x46
function function_90e1b346b2edb093()
{
    var_f8d8aa8a0aec0f92 = self.isstunnedbyenemy || self.var_54dfc5a46377bb64 || self.var_955518e3fd692fbd;
    
    if ( var_f8d8aa8a0aec0f92 )
    {
        thread points::doscoreevent( #"blind_fire" );
    }
}

// Namespace events
// Params 2
// Checksum 0x713d7bea, Offset: 0xfe71
// Size: 0x6a
function function_ae5caf33ea30a142( victim, meansofdeath )
{
    assert( isdefined( victim ), "<dev string:x399>" );
    assert( isdefined( meansofdeath ), "<dev string:x3c5>" );
    
    if ( meansofdeath == "MOD_EXECUTION" && self.lastkilledby === victim )
    {
        thread points::doscoreevent( #"revenge_execute" );
        self.lastkilledby = undefined;
    }
}

// Namespace events
// Params 1
// Checksum 0xeceda4dc, Offset: 0xfee3
// Size: 0x41
function function_91743710801f38f4( victim )
{
    if ( !isdefined( victim.lastweaponobj ) )
    {
        return;
    }
    
    if ( weapon::function_1344ad15d2d7bd21( victim.lastweaponobj ) )
    {
        thread points::doscoreevent( #"ss_shutdown" );
    }
}

// Namespace events
// Params 2
// Checksum 0xc650e02f, Offset: 0xff2c
// Size: 0x237
function function_59162be7b42a7e27( victim, var_95795539e2a8343 )
{
    assert( isdefined( victim ), "<dev string:x3f7>" );
    var_dec36ab35413b4ef = victim getentitynumber();
    
    if ( !isdefined( level.scoreeventglobals.var_239d44b83e8dd4d7 ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_d531dfce96022f1b[ var_95795539e2a8343 ] ) )
    {
        return;
    }
    
    if ( !self.var_d531dfce96022f1b[ var_95795539e2a8343 ].isprimaryweapon )
    {
        var_95795539e2a8343 = self.var_d531dfce96022f1b[ var_95795539e2a8343 ].primaryweaponstring;
    }
    
    if ( level.scoreeventglobals.var_239d44b83e8dd4d7 > self.var_d531dfce96022f1b[ var_95795539e2a8343 ].enemies.size )
    {
        return;
    }
    
    if ( isdefined( self.var_d531dfce96022f1b[ var_95795539e2a8343 ].enemies[ var_dec36ab35413b4ef ] ) )
    {
        self.var_d531dfce96022f1b[ var_95795539e2a8343 ].enemies[ var_dec36ab35413b4ef ] = 0;
    }
    
    foreach ( boolval in self.var_d531dfce96022f1b[ var_95795539e2a8343 ].enemies )
    {
        if ( boolval )
        {
            return;
        }
    }
    
    if ( isdefined( self.var_d531dfce96022f1b[ var_95795539e2a8343 ].secondaryweapons ) )
    {
        foreach ( weaponstring in self.var_d531dfce96022f1b[ var_95795539e2a8343 ].secondaryweapons )
        {
            self.var_d531dfce96022f1b[ weaponstring ] = undefined;
        }
    }
    
    self.var_d531dfce96022f1b[ var_95795539e2a8343 ] = undefined;
    thread points::doscoreevent( #"teamwipe_scorestreak" );
}

// Namespace events
// Params 6
// Checksum 0x3029fbe, Offset: 0x1016b
// Size: 0x3d90
function killedplayer( killid, victim, objweapon, meansofdeath, inflictor, deathdata )
{
    if ( stat_limits::function_608486f90656f2f7( #"limitkills" ) )
    {
        return;
    }
    
    curtime = gettime();
    objweapon = weapon_utility::function_8097c50c526bd683( objweapon );
    weapongroup = weapon::function_820c0dca2415bd8( objweapon );
    
    if ( isdefined( victim.laststandattackermodifiers ) )
    {
        self.modifiers = victim.laststandattackermodifiers;
        function_597384ab825df062( victim, objweapon, meansofdeath, inflictor, deathdata );
    }
    else
    {
        function_a2d92a4b5cb17d36( victim, objweapon, weapongroup, meansofdeath, inflictor, deathdata );
    }
    
    function_f805c88de53eee6d( "poi_kill" );
    var_2fc669d4ccb1f63e = istrue( level.gamemodebundle.var_2fc669d4ccb1f63e );
    
    if ( var_2fc669d4ccb1f63e )
    {
        function_2754deb49e2bee42( objweapon, meansofdeath, inflictor, victim );
    }
    else if ( level.var_dd30bf39c0753f31 )
    {
        var_e2e82b6431a6ecd0 = killstreaks::function_b28df08dec350c61( inflictor, objweapon );
        
        if ( isdefined( var_e2e82b6431a6ecd0 ) && isdefined( var_e2e82b6431a6ecd0.streakname ) )
        {
            function_d980c8bfe541541a( var_e2e82b6431a6ecd0.streakname );
        }
        
        function_792823e29eedf15d( killid, objweapon, meansofdeath, inflictor, victim );
    }
    else
    {
        checkkillstreakkillevents( objweapon, meansofdeath, inflictor, victim );
    }
    
    thread checkfinalkillachievements( victim );
    victimguid = victim.guid;
    myguid = self.guid;
    var_95795539e2a8343 = getcompleteweaponname( objweapon );
    iskillstreakweapon = deathdata.iskillstreakweapon || killstreak::isjuggernaut();
    equipmenttype = weapon::getequipmenttype( objweapon );
    thread killedplayernotifysys( killid, victim, objweapon, meansofdeath, weapongroup );
    
    if ( equipmenttype == "lethal" )
    {
        if ( inflictor.var_de862ee85e3e2f42 )
        {
            var_95795539e2a8343 = inflictor.var_de862ee85e3e2f42;
        }
        else
        {
            var_95795539e2a8343 = inflictor.birthtime;
        }
        
        level callback::callback( #"hash_6c71d319dc089c27", { #equipment:inflictor, #victim:victim, #attacker:self, #event:#"hash_47ff65c901bd4d04" } );
    }
    
    thread updaterecentkills( killid, victim, objweapon, var_95795539e2a8343 ?? #"unknown", iskillstreakweapon, inflictor );
    thread updatec4vehiclemultkill( meansofdeath, inflictor );
    thread updateghostridekills();
    
    if ( function_f74b17e0937aae8( curtime, deathdata ) )
    {
        quadfeed( killid, iskillstreakweapon );
    }
    
    self.prevlastkilltime = self.lastkilltime;
    self.lastkilltime = curtime;
    self.lastkilledplayer = victim;
    self.lastkillvictimpos = victim.origin;
    
    if ( victim != self && level.gamemodebundle.var_67302f78b191f13a )
    {
        function_4d230763bac84313( victim, objweapon, inflictor );
        function_5f87c9aaa9f85f96( victim, meansofdeath, deathdata );
        function_90e1b346b2edb093();
        function_ae5caf33ea30a142( victim, meansofdeath );
        
        if ( self.modifiers[ "environmental_hazard_kill" ] )
        {
            thread points::doscoreevent( #"environment_kill" );
        }
        
        if ( iskillstreakweapon )
        {
            function_59162be7b42a7e27( victim, var_95795539e2a8343 );
            
            if ( utility::isusingremote() || killstreak::isremotekillstreak( var_95795539e2a8343 ) || weapon::function_1344ad15d2d7bd21( objweapon ) )
            {
                if ( !isdefined( self.var_13c7bcbdb6f1570b ) )
                {
                    self.var_13c7bcbdb6f1570b = 0;
                }
                
                self.var_13c7bcbdb6f1570b++;
                
                if ( self.var_13c7bcbdb6f1570b == 4 )
                {
                    thread points::doscoreevent( #"scorestreak_going_hard" );
                    self.modifiers[ "scorestreak_going_hard_kill" ] = 1;
                    self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"scorestreak_going_hard_kill" ) );
                }
                
                if ( isdefined( victim.var_c36e159445e2a48b ) )
                {
                    if ( !isdefined( self.var_7058e78ca68b4da9 ) )
                    {
                        self.var_7058e78ca68b4da9 = 0;
                    }
                    
                    self.var_7058e78ca68b4da9++;
                    
                    if ( self.var_7058e78ca68b4da9 == 2 )
                    {
                        thread points::doscoreevent( #"scorestreak_hard_stop" );
                        self.modifiers[ "hard_stop_kill" ] = 1;
                        self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"hard_stop_kill" ) );
                    }
                }
            }
        }
        
        if ( utility::issharedfuncdefined( #"false_flag", #"hash_1f2b7948f1ff783b" ) )
        {
            var_162ccf34e87c46c1 = [[ utility::getsharedfunc( #"false_flag", #"hash_1f2b7948f1ff783b" ) ]]();
            isfalseflagged = isdefined( victim.var_9ae31e49bba9af9a ) && victim.var_9ae31e49bba9af9a + var_162ccf34e87c46c1 > gettime();
            
            if ( isfalseflagged )
            {
                if ( utility::issharedfuncdefined( #"false_flag", #"hash_1d047d66cf820797" ) )
                {
                    self thread [[ utility::getsharedfunc( #"false_flag", #"hash_1d047d66cf820797" ) ]]( self, victim );
                }
            }
        }
        
        if ( self.modifiers[ "execute_save" ] )
        {
            thread points::doscoreevent( #"execute_save" );
        }
        
        if ( self.var_9d1953bce8a134a0 == 2 )
        {
            thread points::doscoreevent( #"uav_double_kill" );
        }
        
        if ( self.var_43d22bb148995a1d == 2 )
        {
            thread points::doscoreevent( #"uav_double_kill" );
        }
        
        if ( isdefined( self.var_2f4095841cd45bab ) && curtime - self.var_2f4095841cd45bab <= 4000 )
        {
            self.modifiers[ "tac_insert_respawn_kill" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"tac_insert_respawn_kill" ) );
            
            if ( self.lastkilledby == victim )
            {
                thread points::doscoreevent( #"insta_tac_insert" );
            }
        }
        
        if ( isdefined( inflictor.equipmentref ) && isdefined( level.equipment.table[ inflictor.equipmentref ].bundle ) )
        {
            var_f21d2a99d0a3ec6d = level.equipment.table[ inflictor.equipmentref ].bundle.var_f21d2a99d0a3ec6d;
            
            if ( deathdata.hitloc != "none" && isdefined( var_f21d2a99d0a3ec6d ) )
            {
                thread points::doscoreevent( var_f21d2a99d0a3ec6d );
            }
        }
    }
    else if ( self.modifiers[ "longshot" ] )
    {
        thread points::doscoreevent( #"longshot", undefined, undefined, undefined, victim );
    }
    
    if ( !isdefined( level.numkills ) )
    {
        level.numkills = 0;
    }
    
    level.numkills++;
    
    if ( self.deaths > 0 )
    {
        kdr = self.kills / self.deaths;
        
        if ( kdr > 3 )
        {
            level thread battlechatter_mp::saytoself( self, "plr_kd_high", undefined, 0.75 );
        }
    }
    else if ( self.kills > 5 )
    {
        level thread battlechatter_mp::saytoself( self, "plr_kd_high", undefined, 0.75 );
    }
    
    if ( self.laststanding )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
        {
            if ( isdefined( self.leaderboarddata[ "clutch" ] ) )
            {
                self.leaderboarddata[ "clutch" ] = self.leaderboarddata[ "clutch" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "clutch" ] ) )
            {
                [[ level.leaderboardfunc[ "clutch" ] ]]( self, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
            
            if ( isdefined( self.pers[ "clutch" ] ) )
            {
                self.pers[ "clutch" ] = self.pers[ "clutch" ] + 1;
            }
        }
    }
    
    self.damagedplayers[ victimguid ] = undefined;
    hvtkill( victim );
    
    if ( self.modifiers[ "firstblood" ] )
    {
        firstblood( killid, victim );
    }
    
    if ( self.modifiers[ "execution" ] )
    {
        execution( killid, victim );
    }
    
    if ( br_elite_broken_arrow::function_83984ed760cb2b30( victim ) )
    {
        br_elite_broken_arrow::function_50830da7bfae9317( victim );
    }
    
    if ( ( !weapon::iskillstreakweaponname( objweapon.basename ) || weapon::function_1344ad15d2d7bd21( objweapon ) ) && !isdefined( self.perks[ "specialty_explosivebullets" ] ) )
    {
        if ( self.modifiers[ "ascender_kill" ] == 1 )
        {
            thread points::doscoreevent( #"zipline_kill" );
        }
        
        if ( self.modifiers[ #"in_dtp" ] && !self.var_58b9cb211fef48bb )
        {
            thread points::doscoreevent( #"dive_kill" );
        }
        
        if ( self.modifiers[ "supine_corkscrew_kill" ] )
        {
            thread points::doscoreevent( #"supine_corkscrew" );
        }
        
        if ( self.modifiers[ "sniper_quickscope" ] )
        {
            thread points::doscoreevent( #"quick_scope" );
        }
        
        if ( self.modifiers[ "sky_kill" ] )
        {
            thread points::doscoreevent( #"sky_kill" );
        }
        
        if ( self.modifiers[ "weapon_change_bullet_kill" ] )
        {
            thread points::doscoreevent( #"hotswap_kill" );
        }
        
        if ( self.modifiers[ "air_to_air_kill" ] )
        {
            thread points::doscoreevent( #"air_to_air_kill" );
        }
        
        if ( self.modifiers[ "wallkill" ] )
        {
            thread points::doscoreevent( #"wallrun_kill" );
        }
        
        if ( self.modifiers[ "killonwall" ] )
        {
            thread points::doscoreevent( #"kill_wallrunner" );
        }
        
        if ( self.modifiers[ "killinair" ] )
        {
            thread points::doscoreevent( #"kill_jumper" );
        }
        
        if ( self.modifiers[ "recent_active_roll_kill" ] )
        {
            thread points::doscoreevent( #"combat_roll_kill" );
        }
        
        if ( self.modifiers[ "while_wall_jump_kill" ] )
        {
            thread points::doscoreevent( #"wall_jump_kill" );
        }
        
        if ( self.modifiers[ "snaked_kill" ] )
        {
            thread points::doscoreevent( #"snaked" );
        }
        
        if ( self.modifiers[ "meat_shield_save" ] )
        {
            thread points::doscoreevent( #"meat_shield_save" );
        }
        
        if ( self.modifiers[ "meat_shield_explosion_kill" ] )
        {
            thread points::doscoreevent( #"body_shield_explosion_kill" );
        }
        
        if ( isdefined( self.vehicle.combo ) )
        {
            thread points::doscoreevent( #"combo" );
        }
        
        if ( weapon::isthrowingknife( objweapon ) )
        {
            thread points::doscoreevent( #"throwingknife_kill" );
        }
        
        if ( self.modifiers[ "sliding" ] )
        {
            thread points::doscoreevent( #"slide_kill", undefined, undefined, undefined, victim );
        }
        
        if ( self.modifiers[ "gunbutt" ] )
        {
            thread points::doscoreevent( #"gun_butt", undefined, undefined, undefined, victim );
        }
        
        if ( self.modifiers[ "backstab" ] && objweapon.basename == "iw8_knife_mp" )
        {
            thread points::doscoreevent( #"backstab", undefined, undefined, undefined, victim );
        }
        
        if ( self.modifiers[ "vehicle_kill" ] )
        {
            thread points::doscoreevent( #"vehicle_kill", undefined, undefined, undefined, victim );
        }
        
        if ( self.modifiers[ "victim_driving_vehicle" ] )
        {
            thread points::doscoreevent( #"driver_kill", undefined, undefined, undefined, victim );
        }
        
        if ( self.modifiers[ "meat_shield_kill" ] )
        {
            thread points::doscoreevent( #"meat_shield_kill", undefined, undefined, undefined, victim );
        }
        
        if ( self.modifiers[ "jumpkill" ] )
        {
            thread points::doscoreevent( #"air_kill", undefined, undefined, undefined, victim );
        }
        
        if ( self.modifiers[ "meat_shield_grenade_finisher" ] )
        {
            thread points::doscoreevent( #"meat_shield_grenade_finisher", undefined, undefined, undefined, victim );
        }
        
        if ( meansofdeath == "MOD_MELEE" && weapon::isfistweapon( objweapon ) )
        {
            thread points::doscoreevent( #"fist_kill", undefined, undefined, undefined, victim );
        }
        
        noscopecondition = weapongroup == "weapon_sniper" && self.modifiers[ "hipfire" ] && !self.modifiers[ "weapon_has_underbarrel" ];
        
        if ( noscopecondition )
        {
            thread points::doscoreevent( #"sniper_rifle_noscope" );
        }
        
        var_1946bd80146b8c36 = noscopecondition && self.modifiers[ "360_spin_kill" ];
        
        if ( var_1946bd80146b8c36 )
        {
            thread points::doscoreevent( #"event_360_snipe" );
        }
        
        function_91743710801f38f4( victim );
        
        if ( self.modifiers[ "revenge" ] )
        {
            self.lastkilledby = undefined;
            revenge( killid, victim );
        }
        
        if ( objweapon.basename == "none" && meansofdeath != "MOD_EXECUTION" && meansofdeath != "MOD_MEATSHIELD" )
        {
            return 0;
        }
        
        attackerisinflictor = attackerisinflictor( self, inflictor, objweapon, meansofdeath );
        
        if ( self.modifiers[ "oneshotkill" ] )
        {
            if ( level.scoreeventglobals.var_9d0863916164a13c )
            {
                if ( ( self.var_7a12848b93164b3c ?? 0 ) < curtime )
                {
                    if ( !isdefined( self.var_5dfbfca334403414 ) )
                    {
                        self.var_5dfbfca334403414 = getxhashhexname( #"one_shot_two_kills_awarded" );
                    }
                    
                    thread points::function_a0b28fbe32e53f12( #"one_shot_kill", self.var_5dfbfca334403414 );
                }
            }
            else
            {
                thread points::doscoreevent( #"one_shot_kill" );
            }
            
            if ( isdefined( self.pers[ "telemetry" ].one_shot_kills ) )
            {
                self.pers[ "telemetry" ].one_shot_kills++;
            }
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "oneShotOneKills" ] ) )
                {
                    self.leaderboarddata[ "oneShotOneKills" ] = self.leaderboarddata[ "oneShotOneKills" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "oneShotOneKills" ] ) )
                {
                    [[ level.leaderboardfunc[ "oneShotOneKills" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                
                if ( isdefined( self.pers[ "oneShotOneKills" ] ) )
                {
                    self.pers[ "oneShotOneKills" ] = self.pers[ "oneShotOneKills" ] + 1;
                }
            }
        }
        
        if ( self.modifiers[ "vehicle_kill" ] )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "vehicleKills" ] ) )
                {
                    self.leaderboarddata[ "vehicleKills" ] = self.leaderboarddata[ "vehicleKills" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "vehicleKills" ] ) )
                {
                    [[ level.leaderboardfunc[ "vehicleKills" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                
                if ( isdefined( self.pers[ "vehicleKills" ] ) )
                {
                    self.pers[ "vehicleKills" ] = self.pers[ "vehicleKills" ] + 1;
                }
            }
        }
        
        if ( self.modifiers[ "equipment_kill" ] )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "lethalKills" ] ) )
                {
                    self.leaderboarddata[ "lethalKills" ] = self.leaderboarddata[ "lethalKills" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "lethalKills" ] ) )
                {
                    [[ level.leaderboardfunc[ "lethalKills" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                
                if ( isdefined( self.pers[ "lethalKills" ] ) )
                {
                    self.pers[ "lethalKills" ] = self.pers[ "lethalKills" ] + 1;
                }
            }
        }
        
        if ( self.modifiers[ "grenadestuck" ] )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "stickKills" ] ) )
                {
                    self.leaderboarddata[ "stickKills" ] = self.leaderboarddata[ "stickKills" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "stickKills" ] ) )
                {
                    [[ level.leaderboardfunc[ "stickKills" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                
                if ( isdefined( self.pers[ "stickKills" ] ) )
                {
                    self.pers[ "stickKills" ] = self.pers[ "stickKills" ] + 1;
                }
            }
        }
        
        if ( self.modifiers[ "assistedsuicide" ] )
        {
            assistedsuicide( killid, objweapon );
        }
        
        if ( self.modifiers[ "comeback" ] )
        {
            comeback( killid );
        }
        
        if ( self.modifiers[ "headshot" ] )
        {
            level thread battlechatter_mp::saytoself( self, "plr_killfirm_headshot", undefined, 0.75 );
            
            if ( !level.var_23730bd6be76cb84 )
            {
                eventinfo = level.gamemodebundle.var_67302f78b191f13a ? damage::function_c7f203dba75721b1( victim, inflictor ) : undefined;
                headshot( killid, eventinfo, undefined, inflictor, victim );
            }
            else if ( level.var_dd30bf39c0753f31 )
            {
                if ( level.var_931ca47cc298f7af == #"display_xp" )
                {
                    headshot( killid, eventinfo, undefined, inflictor, victim );
                }
            }
        }
        
        if ( self.modifiers[ "posthumous" ] )
        {
            postdeathkill( killid );
        }
        
        if ( !player::isreallyalive( self ) && isdefined( self.deathtime ) )
        {
            timesincelastdeath = gettime() - self.deathtime;
            
            if ( game_utility_mp::issimultaneouskillenabled() )
            {
                if ( timesincelastdeath == 0 && self.lastattacker === victim )
                {
                    thread points::doscoreevent( #"simultaneous_kill", undefined, undefined, undefined, undefined, 1 );
                    victim thread points::doscoreevent( #"simultaneous_kill", undefined, undefined, undefined, undefined, 1 );
                }
            }
        }
        
        if ( self.modifiers[ "avenger" ] )
        {
            avengedplayer( killid, victim.lastkilledplayer );
        }
        
        var_cd6c51cf0bbff478 = undefined;
        
        if ( victim isinexecutionattack() )
        {
            var_41d412bda18ef6d6 = utility::playersnear( victim.origin, 300 );
            
            foreach ( player in var_41d412bda18ef6d6 )
            {
                if ( player.team == self.team && player isinexecutionvictim() )
                {
                    var_cd6c51cf0bbff478 = player.guid;
                    defendedplayer( killid, player.guid );
                    break;
                }
            }
        }
        
        foreach ( guid, damagetime in victim.damagedplayers )
        {
            if ( guid == self.guid || guid == victim.guid )
            {
                continue;
            }
            
            if ( guid === var_cd6c51cf0bbff478 )
            {
                continue;
            }
            
            if ( level.teambased && curtime - damagetime < 1750 && meansofdeath === "MOD_RIFLE_BULLET" )
            {
                defendedplayer( killid, guid );
            }
        }
        
        if ( self.modifiers[ "pointblank" ] )
        {
            thread pointblank( killid, victim );
        }
        
        if ( self.modifiers[ "longshot" ] )
        {
            thread longshot( killid );
        }
        
        if ( self.modifiers[ "very_longshot" ] )
        {
            thread very_longshot( killid );
        }
        
        if ( self.modifiers[ "silencedKill" ] )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "silencedKills" ] ) )
                {
                    self.leaderboarddata[ "silencedKills" ] = self.leaderboarddata[ "silencedKills" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "silencedKills" ] ) )
                {
                    [[ level.leaderboardfunc[ "silencedKills" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                
                if ( isdefined( self.pers[ "silencedKills" ] ) )
                {
                    self.pers[ "silencedKills" ] = self.pers[ "silencedKills" ] + 1;
                }
            }
        }
        
        if ( attackerisinflictor )
        {
            switch ( weaponclass( objweapon.basename ) )
            {
                case #"hash_8cdaf2e4ecfe5b51":
                    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
                    {
                        if ( isdefined( self.leaderboarddata[ "arKills" ] ) )
                        {
                            self.leaderboarddata[ "arKills" ] = self.leaderboarddata[ "arKills" ] + 1;
                        }
                        
                        if ( isdefined( level.leaderboardfunc[ "arKills" ] ) )
                        {
                            [[ level.leaderboardfunc[ "arKills" ] ]]( self, 1 );
                        }
                        
                        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                        
                        if ( isdefined( self.pers[ "arKills" ] ) )
                        {
                            self.pers[ "arKills" ] = self.pers[ "arKills" ] + 1;
                        }
                    }
                    
                    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( victim ) ) )
                    {
                        if ( isdefined( victim.leaderboarddata[ "arDeaths" ] ) )
                        {
                            victim.leaderboarddata[ "arDeaths" ] = victim.leaderboarddata[ "arDeaths" ] + 1;
                        }
                        
                        if ( isdefined( level.leaderboardfunc[ "arDeaths" ] ) )
                        {
                            [[ level.leaderboardfunc[ "arDeaths" ] ]]( victim, 1 );
                        }
                        
                        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                        
                        if ( isdefined( victim.pers[ "arDeaths" ] ) )
                        {
                            victim.pers[ "arDeaths" ] = victim.pers[ "arDeaths" ] + 1;
                        }
                    }
                    
                    if ( meansofdeath == "MOD_HEAD_SHOT" )
                    {
                        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
                        {
                            if ( isdefined( self.leaderboarddata[ "arHeadshots" ] ) )
                            {
                                self.leaderboarddata[ "arHeadshots" ] = self.leaderboarddata[ "arHeadshots" ] + 1;
                            }
                            
                            if ( isdefined( level.leaderboardfunc[ "arHeadshots" ] ) )
                            {
                                [[ level.leaderboardfunc[ "arHeadshots" ] ]]( self, 1 );
                            }
                            
                            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                            
                            if ( isdefined( self.pers[ "arHeadshots" ] ) )
                            {
                                self.pers[ "arHeadshots" ] = self.pers[ "arHeadshots" ] + 1;
                            }
                        }
                    }
                    
                    break;
                case #"hash_900cb96c552c5e8e":
                    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
                    {
                        if ( isdefined( self.leaderboarddata[ "smgKills" ] ) )
                        {
                            self.leaderboarddata[ "smgKills" ] = self.leaderboarddata[ "smgKills" ] + 1;
                        }
                        
                        if ( isdefined( level.leaderboardfunc[ "smgKills" ] ) )
                        {
                            [[ level.leaderboardfunc[ "smgKills" ] ]]( self, 1 );
                        }
                        
                        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                        
                        if ( isdefined( self.pers[ "smgKills" ] ) )
                        {
                            self.pers[ "smgKills" ] = self.pers[ "smgKills" ] + 1;
                        }
                    }
                    
                    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( victim ) ) )
                    {
                        if ( isdefined( victim.leaderboarddata[ "smgDeaths" ] ) )
                        {
                            victim.leaderboarddata[ "smgDeaths" ] = victim.leaderboarddata[ "smgDeaths" ] + 1;
                        }
                        
                        if ( isdefined( level.leaderboardfunc[ "smgDeaths" ] ) )
                        {
                            [[ level.leaderboardfunc[ "smgDeaths" ] ]]( victim, 1 );
                        }
                        
                        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                        
                        if ( isdefined( victim.pers[ "smgDeaths" ] ) )
                        {
                            victim.pers[ "smgDeaths" ] = victim.pers[ "smgDeaths" ] + 1;
                        }
                    }
                    
                    if ( meansofdeath == "MOD_HEAD_SHOT" )
                    {
                        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
                        {
                            if ( isdefined( self.leaderboarddata[ "smgHeadshots" ] ) )
                            {
                                self.leaderboarddata[ "smgHeadshots" ] = self.leaderboarddata[ "smgHeadshots" ] + 1;
                            }
                            
                            if ( isdefined( level.leaderboardfunc[ "smgHeadshots" ] ) )
                            {
                                [[ level.leaderboardfunc[ "smgHeadshots" ] ]]( self, 1 );
                            }
                            
                            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                            
                            if ( isdefined( self.pers[ "smgHeadshots" ] ) )
                            {
                                self.pers[ "smgHeadshots" ] = self.pers[ "smgHeadshots" ] + 1;
                            }
                        }
                    }
                    
                    break;
                case #"hash_690c0d6a821b42e":
                    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
                    {
                        if ( isdefined( self.leaderboarddata[ "shotgunKills" ] ) )
                        {
                            self.leaderboarddata[ "shotgunKills" ] = self.leaderboarddata[ "shotgunKills" ] + 1;
                        }
                        
                        if ( isdefined( level.leaderboardfunc[ "shotgunKills" ] ) )
                        {
                            [[ level.leaderboardfunc[ "shotgunKills" ] ]]( self, 1 );
                        }
                        
                        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                        
                        if ( isdefined( self.pers[ "shotgunKills" ] ) )
                        {
                            self.pers[ "shotgunKills" ] = self.pers[ "shotgunKills" ] + 1;
                        }
                    }
                    
                    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( victim ) ) )
                    {
                        if ( isdefined( victim.leaderboarddata[ "shotgunDeaths" ] ) )
                        {
                            victim.leaderboarddata[ "shotgunDeaths" ] = victim.leaderboarddata[ "shotgunDeaths" ] + 1;
                        }
                        
                        if ( isdefined( level.leaderboardfunc[ "shotgunDeaths" ] ) )
                        {
                            [[ level.leaderboardfunc[ "shotgunDeaths" ] ]]( victim, 1 );
                        }
                        
                        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                        
                        if ( isdefined( victim.pers[ "shotgunDeaths" ] ) )
                        {
                            victim.pers[ "shotgunDeaths" ] = victim.pers[ "shotgunDeaths" ] + 1;
                        }
                    }
                    
                    if ( meansofdeath == "MOD_HEAD_SHOT" )
                    {
                        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
                        {
                            if ( isdefined( self.leaderboarddata[ "shotgunHeadshots" ] ) )
                            {
                                self.leaderboarddata[ "shotgunHeadshots" ] = self.leaderboarddata[ "shotgunHeadshots" ] + 1;
                            }
                            
                            if ( isdefined( level.leaderboardfunc[ "shotgunHeadshots" ] ) )
                            {
                                [[ level.leaderboardfunc[ "shotgunHeadshots" ] ]]( self, 1 );
                            }
                            
                            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                            
                            if ( isdefined( self.pers[ "shotgunHeadshots" ] ) )
                            {
                                self.pers[ "shotgunHeadshots" ] = self.pers[ "shotgunHeadshots" ] + 1;
                            }
                        }
                    }
                    
                    break;
                case #"hash_fa24dff6bd60a12d":
                    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
                    {
                        if ( isdefined( self.leaderboarddata[ "lmgKills" ] ) )
                        {
                            self.leaderboarddata[ "lmgKills" ] = self.leaderboarddata[ "lmgKills" ] + 1;
                        }
                        
                        if ( isdefined( level.leaderboardfunc[ "lmgKills" ] ) )
                        {
                            [[ level.leaderboardfunc[ "lmgKills" ] ]]( self, 1 );
                        }
                        
                        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                        
                        if ( isdefined( self.pers[ "lmgKills" ] ) )
                        {
                            self.pers[ "lmgKills" ] = self.pers[ "lmgKills" ] + 1;
                        }
                    }
                    
                    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( victim ) ) )
                    {
                        if ( isdefined( victim.leaderboarddata[ "lmgDeaths" ] ) )
                        {
                            victim.leaderboarddata[ "lmgDeaths" ] = victim.leaderboarddata[ "lmgDeaths" ] + 1;
                        }
                        
                        if ( isdefined( level.leaderboardfunc[ "lmgDeaths" ] ) )
                        {
                            [[ level.leaderboardfunc[ "lmgDeaths" ] ]]( victim, 1 );
                        }
                        
                        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                        
                        if ( isdefined( victim.pers[ "lmgDeaths" ] ) )
                        {
                            victim.pers[ "lmgDeaths" ] = victim.pers[ "lmgDeaths" ] + 1;
                        }
                    }
                    
                    if ( meansofdeath == "MOD_HEAD_SHOT" )
                    {
                        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
                        {
                            if ( isdefined( self.leaderboarddata[ "lmgHeadshots" ] ) )
                            {
                                self.leaderboarddata[ "lmgHeadshots" ] = self.leaderboarddata[ "lmgHeadshots" ] + 1;
                            }
                            
                            if ( isdefined( level.leaderboardfunc[ "lmgHeadshots" ] ) )
                            {
                                [[ level.leaderboardfunc[ "lmgHeadshots" ] ]]( self, 1 );
                            }
                            
                            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                            
                            if ( isdefined( self.pers[ "lmgHeadshots" ] ) )
                            {
                                self.pers[ "lmgHeadshots" ] = self.pers[ "lmgHeadshots" ] + 1;
                            }
                        }
                    }
                    
                    break;
                case #"hash_6191aaef9f922f96":
                    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
                    {
                        if ( isdefined( self.leaderboarddata[ "sniperKills" ] ) )
                        {
                            self.leaderboarddata[ "sniperKills" ] = self.leaderboarddata[ "sniperKills" ] + 1;
                        }
                        
                        if ( isdefined( level.leaderboardfunc[ "sniperKills" ] ) )
                        {
                            [[ level.leaderboardfunc[ "sniperKills" ] ]]( self, 1 );
                        }
                        
                        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                        
                        if ( isdefined( self.pers[ "sniperKills" ] ) )
                        {
                            self.pers[ "sniperKills" ] = self.pers[ "sniperKills" ] + 1;
                        }
                    }
                    
                    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( victim ) ) )
                    {
                        if ( isdefined( victim.leaderboarddata[ "sniperDeaths" ] ) )
                        {
                            victim.leaderboarddata[ "sniperDeaths" ] = victim.leaderboarddata[ "sniperDeaths" ] + 1;
                        }
                        
                        if ( isdefined( level.leaderboardfunc[ "sniperDeaths" ] ) )
                        {
                            [[ level.leaderboardfunc[ "sniperDeaths" ] ]]( victim, 1 );
                        }
                        
                        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                        
                        if ( isdefined( victim.pers[ "sniperDeaths" ] ) )
                        {
                            victim.pers[ "sniperDeaths" ] = victim.pers[ "sniperDeaths" ] + 1;
                        }
                    }
                    
                    if ( meansofdeath == "MOD_HEAD_SHOT" )
                    {
                        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
                        {
                            if ( isdefined( self.leaderboarddata[ "sniperHeadshots" ] ) )
                            {
                                self.leaderboarddata[ "sniperHeadshots" ] = self.leaderboarddata[ "sniperHeadshots" ] + 1;
                            }
                            
                            if ( isdefined( level.leaderboardfunc[ "sniperHeadshots" ] ) )
                            {
                                [[ level.leaderboardfunc[ "sniperHeadshots" ] ]]( self, 1 );
                            }
                            
                            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                            
                            if ( isdefined( self.pers[ "sniperHeadshots" ] ) )
                            {
                                self.pers[ "sniperHeadshots" ] = self.pers[ "sniperHeadshots" ] + 1;
                            }
                        }
                    }
                    
                    break;
                case #"hash_61e969dacaaf9881":
                    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
                    {
                        if ( isdefined( self.leaderboarddata[ "launcherKills" ] ) )
                        {
                            self.leaderboarddata[ "launcherKills" ] = self.leaderboarddata[ "launcherKills" ] + 1;
                        }
                        
                        if ( isdefined( level.leaderboardfunc[ "launcherKills" ] ) )
                        {
                            [[ level.leaderboardfunc[ "launcherKills" ] ]]( self, 1 );
                        }
                        
                        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                        
                        if ( isdefined( self.pers[ "launcherKills" ] ) )
                        {
                            self.pers[ "launcherKills" ] = self.pers[ "launcherKills" ] + 1;
                        }
                    }
                    
                    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( victim ) ) )
                    {
                        if ( isdefined( victim.leaderboarddata[ "launcherDeaths" ] ) )
                        {
                            victim.leaderboarddata[ "launcherDeaths" ] = victim.leaderboarddata[ "launcherDeaths" ] + 1;
                        }
                        
                        if ( isdefined( level.leaderboardfunc[ "launcherDeaths" ] ) )
                        {
                            [[ level.leaderboardfunc[ "launcherDeaths" ] ]]( victim, 1 );
                        }
                        
                        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                        
                        if ( isdefined( victim.pers[ "launcherDeaths" ] ) )
                        {
                            victim.pers[ "launcherDeaths" ] = victim.pers[ "launcherDeaths" ] + 1;
                        }
                    }
                    
                    if ( meansofdeath == "MOD_HEAD_SHOT" )
                    {
                        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
                        {
                            if ( isdefined( self.leaderboarddata[ "launcherHeadshots" ] ) )
                            {
                                self.leaderboarddata[ "launcherHeadshots" ] = self.leaderboarddata[ "launcherHeadshots" ] + 1;
                            }
                            
                            if ( isdefined( level.leaderboardfunc[ "launcherHeadshots" ] ) )
                            {
                                [[ level.leaderboardfunc[ "launcherHeadshots" ] ]]( self, 1 );
                            }
                            
                            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                            
                            if ( isdefined( self.pers[ "launcherHeadshots" ] ) )
                            {
                                self.pers[ "launcherHeadshots" ] = self.pers[ "launcherHeadshots" ] + 1;
                            }
                        }
                    }
                    
                    break;
                case #"hash_719417cb1de832b6":
                    if ( !objweapon.ismelee )
                    {
                        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
                        {
                            if ( isdefined( self.leaderboarddata[ "pistolKills" ] ) )
                            {
                                self.leaderboarddata[ "pistolKills" ] = self.leaderboarddata[ "pistolKills" ] + 1;
                            }
                            
                            if ( isdefined( level.leaderboardfunc[ "pistolKills" ] ) )
                            {
                                [[ level.leaderboardfunc[ "pistolKills" ] ]]( self, 1 );
                            }
                            
                            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                            
                            if ( isdefined( self.pers[ "pistolKills" ] ) )
                            {
                                self.pers[ "pistolKills" ] = self.pers[ "pistolKills" ] + 1;
                            }
                        }
                        
                        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( victim ) ) )
                        {
                            if ( isdefined( victim.leaderboarddata[ "pistolPeaths" ] ) )
                            {
                                victim.leaderboarddata[ "pistolPeaths" ] = victim.leaderboarddata[ "pistolPeaths" ] + 1;
                            }
                            
                            if ( isdefined( level.leaderboardfunc[ "pistolPeaths" ] ) )
                            {
                                [[ level.leaderboardfunc[ "pistolPeaths" ] ]]( victim, 1 );
                            }
                            
                            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                            
                            if ( isdefined( victim.pers[ "pistolPeaths" ] ) )
                            {
                                victim.pers[ "pistolPeaths" ] = victim.pers[ "pistolPeaths" ] + 1;
                            }
                        }
                        
                        if ( meansofdeath == "MOD_HEAD_SHOT" )
                        {
                            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
                            {
                                if ( isdefined( self.leaderboarddata[ "pistolHeadshots" ] ) )
                                {
                                    self.leaderboarddata[ "pistolHeadshots" ] = self.leaderboarddata[ "pistolHeadshots" ] + 1;
                                }
                                
                                if ( isdefined( level.leaderboardfunc[ "pistolHeadshots" ] ) )
                                {
                                    [[ level.leaderboardfunc[ "pistolHeadshots" ] ]]( self, 1 );
                                }
                                
                                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                                
                                if ( isdefined( self.pers[ "pistolHeadshots" ] ) )
                                {
                                    self.pers[ "pistolHeadshots" ] = self.pers[ "pistolHeadshots" ] + 1;
                                }
                            }
                        }
                        
                        break;
                    }
                    
                    break;
            }
            
            rootname = weapon::getweaponrootname( objweapon );
            weapongroup = weapon::weapongroupmap( rootname );
            
            if ( weapongroup )
            {
                switch ( weapongroup )
                {
                    case #"hash_8af0086b038622b5":
                        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
                        {
                            if ( isdefined( self.leaderboarddata[ "assaultKills" ] ) )
                            {
                                self.leaderboarddata[ "assaultKills" ] = self.leaderboarddata[ "assaultKills" ] + 1;
                            }
                            
                            if ( isdefined( level.leaderboardfunc[ "assaultKills" ] ) )
                            {
                                [[ level.leaderboardfunc[ "assaultKills" ] ]]( self, 1 );
                            }
                            
                            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                            
                            if ( isdefined( self.pers[ "assaultKills" ] ) )
                            {
                                self.pers[ "assaultKills" ] = self.pers[ "assaultKills" ] + 1;
                            }
                        }
                        
                        break;
                    case #"hash_47368bc0d2ef1565":
                        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
                        {
                            if ( isdefined( self.leaderboarddata[ "dmrKills" ] ) )
                            {
                                self.leaderboarddata[ "dmrKills" ] = self.leaderboarddata[ "dmrKills" ] + 1;
                            }
                            
                            if ( isdefined( level.leaderboardfunc[ "dmrKills" ] ) )
                            {
                                [[ level.leaderboardfunc[ "dmrKills" ] ]]( self, 1 );
                            }
                            
                            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                            
                            if ( isdefined( self.pers[ "dmrKills" ] ) )
                            {
                                self.pers[ "dmrKills" ] = self.pers[ "dmrKills" ] + 1;
                            }
                        }
                        
                        break;
                }
            }
            
            if ( meansofdeath == "MOD_MELEE" || meansofdeath == "MOD_MELEE_TAKEDOWN" )
            {
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
                {
                    if ( isdefined( self.leaderboarddata[ "meleeKills" ] ) )
                    {
                        self.leaderboarddata[ "meleeKills" ] = self.leaderboarddata[ "meleeKills" ] + 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "meleeKills" ] ) )
                    {
                        [[ level.leaderboardfunc[ "meleeKills" ] ]]( self, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                    
                    if ( isdefined( self.pers[ "meleeKills" ] ) )
                    {
                        self.pers[ "meleeKills" ] = self.pers[ "meleeKills" ] + 1;
                    }
                }
                
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( victim ) ) )
                {
                    if ( isdefined( victim.leaderboarddata[ "meleeDeaths" ] ) )
                    {
                        victim.leaderboarddata[ "meleeDeaths" ] = victim.leaderboarddata[ "meleeDeaths" ] + 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "meleeDeaths" ] ) )
                    {
                        [[ level.leaderboardfunc[ "meleeDeaths" ] ]]( victim, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                    
                    if ( isdefined( victim.pers[ "meleeDeaths" ] ) )
                    {
                        victim.pers[ "meleeDeaths" ] = victim.pers[ "meleeDeaths" ] + 1;
                    }
                }
            }
            
            if ( isdefined( level.supportdrones ) && level.supportdrones.size > 0 )
            {
                foreach ( drone in level.supportdrones )
                {
                    if ( drone.owner == self && drone.helperdronetype == "radar_drone_overwatch" )
                    {
                        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( drone.owner ) ) )
                        {
                            if ( isdefined( drone.owner.leaderboarddata[ "killstreakPersonalUAVKills" ] ) )
                            {
                                drone.owner.leaderboarddata[ "killstreakPersonalUAVKills" ] = drone.owner.leaderboarddata[ "killstreakPersonalUAVKills" ] + 1;
                            }
                            
                            if ( isdefined( level.leaderboardfunc[ "killstreakPersonalUAVKills" ] ) )
                            {
                                [[ level.leaderboardfunc[ "killstreakPersonalUAVKills" ] ]]( drone.owner, 1 );
                            }
                            
                            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                            
                            if ( isdefined( drone.owner.pers[ "killstreakPersonalUAVKills" ] ) )
                            {
                                drone.owner.pers[ "killstreakPersonalUAVKills" ] = drone.owner.pers[ "killstreakPersonalUAVKills" ] + 1;
                            }
                        }
                        
                        break;
                    }
                }
            }
            
            if ( self.modifiers[ "low_health_kill" ] )
            {
                thread points::doscoreevent( #"low_health_kill" );
            }
            
            if ( self.modifiers[ "ads" ] )
            {
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
                {
                    if ( isdefined( self.leaderboarddata[ "adsKills" ] ) )
                    {
                        self.leaderboarddata[ "adsKills" ] = self.leaderboarddata[ "adsKills" ] + 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "adsKills" ] ) )
                    {
                        [[ level.leaderboardfunc[ "adsKills" ] ]]( self, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                    
                    if ( isdefined( self.pers[ "adsKills" ] ) )
                    {
                        self.pers[ "adsKills" ] = self.pers[ "adsKills" ] + 1;
                    }
                }
            }
            else if ( self.modifiers[ "tac_stance" ] )
            {
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
                {
                    if ( isdefined( self.leaderboarddata[ "tacStanceKills" ] ) )
                    {
                        self.leaderboarddata[ "tacStanceKills" ] = self.leaderboarddata[ "tacStanceKills" ] + 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "tacStanceKills" ] ) )
                    {
                        [[ level.leaderboardfunc[ "tacStanceKills" ] ]]( self, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                    
                    if ( isdefined( self.pers[ "tacStanceKills" ] ) )
                    {
                        self.pers[ "tacStanceKills" ] = self.pers[ "tacStanceKills" ] + 1;
                    }
                }
            }
            else if ( self.modifiers[ "hipfire" ] )
            {
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
                {
                    if ( isdefined( self.leaderboarddata[ "hipfireKills" ] ) )
                    {
                        self.leaderboarddata[ "hipfireKills" ] = self.leaderboarddata[ "hipfireKills" ] + 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "hipfireKills" ] ) )
                    {
                        [[ level.leaderboardfunc[ "hipfireKills" ] ]]( self, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                    
                    if ( isdefined( self.pers[ "hipfireKills" ] ) )
                    {
                        self.pers[ "hipfireKills" ] = self.pers[ "hipfireKills" ] + 1;
                    }
                }
            }
            
            if ( self ismantling() )
            {
                mantlekill();
            }
            
            if ( self.modifiers[ "backfire" ] )
            {
                backfire();
            }
        }
        
        if ( self.modifiers[ "buzzkill" ] )
        {
            buzzkill( killid, victim );
        }
        
        if ( self.modifiers[ "impaired" ] )
        {
            impairedkill();
        }
        
        isbulletdamage = utility::isbulletdamage( meansofdeath );
        var_8b6cc076bf3c89a7 = isdefined( self.offscreenattackers[ victim.guid ] ) && curtime - self.offscreenattackers[ victim.guid ] < level.scoreeventglobals.var_73c56c40a78b19b0 && isbulletdamage && isalive( self );
        
        if ( var_8b6cc076bf3c89a7 )
        {
            thread points::doscoreevent( #"react_kill" );
            self.modifiers[ "react_kill" ] = 1;
            self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"react_kill" ) );
        }
        
        if ( isbulletdamage && self.var_27a561637e13dd5c && !weapon::function_1344ad15d2d7bd21( objweapon ) )
        {
            thread points::doscoreevent( #"golden_bullets" );
        }
        
        if ( isdefined( victim.stuckbygrenade ) )
        {
            level thread battlechatter_mp::saytoself( self, "plr_killfirm_semtex", undefined, 0.75 );
        }
        
        if ( inflictor.hasbounced && weapon::isthrowingknife( objweapon ) )
        {
            self.modifiers[ "bounced_throwing_knife_kill" ] = 1;
            self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"bounced_throwing_knife_kill" ) );
        }
        
        gametypexhash = getxhash( game_utility::getgametype() );
        
        if ( gametypexhash == #"dm" )
        {
            if ( weapon::issnowball( objweapon.basename ) && weapon::function_b31ea04b0d6c8935( objweapon.basename ) )
            {
                thread points::doscoreevent( #"kill_gold_snowball" );
            }
            
            if ( isdefined( victim getcurrentweapon() ) )
            {
                victimweapon = victim getcurrentweapon();
                
                if ( isdefined( victimweapon.basename ) && weapon::function_b31ea04b0d6c8935( victimweapon.basename ) )
                {
                    thread points::doscoreevent( #"kill_gold_snowball" );
                }
            }
        }
        
        if ( gametypexhash == #"gold_gun" )
        {
            if ( weapon::isgoldengun( objweapon.basename ) )
            {
                thread points::doscoreevent( #"kill_ray_gun" );
            }
            
            if ( isdefined( victim getcurrentweapon() ) )
            {
                victimweapon = victim getcurrentweapon();
                
                if ( isdefined( victimweapon.basename ) && weapon::isgoldengun( victimweapon.basename ) )
                {
                    thread points::doscoreevent( #"kill_shutdown_ray_gun" );
                }
            }
        }
        
        if ( victim.var_99702520a6704748 > 0 )
        {
            thread points::doscoreevent( #"kill_v_power_electrified_enemy" );
        }
        
        if ( self.var_9d06c5b5a931f6e )
        {
            thread points::doscoreevent( #"kill_v_power_melee" );
        }
        
        if ( victim.var_4d00f2f3e96b6b1f || victim getscriptablehaspart( "superpowers_aura" ) && victim getscriptablepartstate( "superpowers_aura", 1 ) == "on" )
        {
            thread points::doscoreevent( #"kill_shutdown_v_power" );
        }
        
        if ( gamescore::isdebuffedbyweaponandplayer( self, victim, "decoy_grenade_mp" ) )
        {
            rank::scoreeventpopup( #"baited_kill" );
        }
        
        if ( gametypexhash == #"dom_jugg" || gametypexhash == #"koth_jugg" || gametypexhash == #"conf_jugg" )
        {
            if ( weapon_utility::ischainsword( objweapon.basename ) )
            {
                thread points::doscoreevent( #"hash_5f5800e4adb393cb" );
            }
            
            if ( meansofdeath == "MOD_CRUSH" )
            {
                thread points::doscoreevent( #"mp_juggermosh_kill_ground_pound" );
            }
        }
        
        if ( getdvarint( @"hash_4753586a2ac8718f", 0 ) != 0 )
        {
            var_16b8cdfe675f8126 = operator::function_b518cf4ab4b71ede();
            var_354a56dbdb05e665 = victim operator::function_b518cf4ab4b71ede();
            
            if ( var_16b8cdfe675f8126 < 3 )
            {
                thread points::doscoreevent( hashcat( #"hash_7d3e2b1b480a64c", var_16b8cdfe675f8126 ) );
            }
            
            if ( isdefined( var_354a56dbdb05e665 ) )
            {
                thread points::doscoreevent( hashcat( #"hash_c04e9e95779880d6", var_354a56dbdb05e665 ) );
            }
        }
        
        if ( getdvarint( @"vortex_playlist", 0 ) != 0 )
        {
            if ( self.herodrop && meansofdeath == "MOD_CRUSH" )
            {
                thread points::doscoreevent( #"arcade_aoe_power_kill" );
            }
            else if ( isdefined( level.var_ff841c3a655891d1 ) && isdefined( objweapon ) && arraycontains( level.var_ff841c3a655891d1, objweapon ) )
            {
                switch ( objweapon.basename )
                {
                    case #"hash_aec1771e9a671b1a":
                        thread points::doscoreevent( #"arcade_pickup_kill_rocket_shotgun" );
                        break;
                    case #"hash_e5bfeb043f9cc08e":
                        thread points::doscoreevent( #"arcade_pickup_kill_pdango" );
                        break;
                    case #"hash_50516c32059a970d":
                        thread points::doscoreevent( #"arcade_pickup_kill_moscar" );
                        break;
                    case #"hash_ff242e3e8fc4aacd":
                        thread points::doscoreevent( #"arcade_pickup_kill_minigun_rage" );
                        break;
                }
            }
        }
        
        if ( self.modifiers[ "kingslayer" ] )
        {
            kingslayer( killid, victim );
            
            if ( game_utility::getgametype() == "gun" && ( meansofdeath == "MOD_MELEE" || meansofdeath == "MOD_MELEE_TAKEDOWN" ) )
            {
                thread points::doscoreevent( #"mode_gun_melee_1st_place" );
            }
        }
        
        if ( self.score < victim.score )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "higherRankedKills" ] ) )
                {
                    self.leaderboarddata[ "higherRankedKills" ] = self.leaderboarddata[ "higherRankedKills" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "higherRankedKills" ] ) )
                {
                    [[ level.leaderboardfunc[ "higherRankedKills" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                
                if ( isdefined( self.pers[ "higherRankedKills" ] ) )
                {
                    self.pers[ "higherRankedKills" ] = self.pers[ "higherRankedKills" ] + 1;
                }
            }
        }
        else if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
        {
            if ( isdefined( self.leaderboarddata[ "lowerRankedKills" ] ) )
            {
                self.leaderboarddata[ "lowerRankedKills" ] = self.leaderboarddata[ "lowerRankedKills" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "lowerRankedKills" ] ) )
            {
                [[ level.leaderboardfunc[ "lowerRankedKills" ] ]]( self, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
            
            if ( isdefined( self.pers[ "lowerRankedKills" ] ) )
            {
                self.pers[ "lowerRankedKills" ] = self.pers[ "lowerRankedKills" ] + 1;
            }
        }
        
        if ( self.modifiers[ "item_impact" ] )
        {
            equipmentref = objweapon.equipmentref ?? equipment_mp::getequipmentreffromweapon( objweapon );
            bundle = level.equipment.table[ equipmentref ].bundle;
            
            if ( !bundle.var_39645f5d7cd4d502 )
            {
                eventname = bundle.impactscoreevent ?? #"item_impact";
                thread points::doscoreevent( eventname );
            }
        }
        
        if ( self.modifiers[ "launcher_impact" ] )
        {
            directimpactkill( undefined, victim );
        }
        
        if ( game_utility_mp::getgametypenumlives() >= 1 )
        {
            if ( victim.pers[ "lives" ] == 0 )
            {
                thread points::doscoreevent( #"mode_x_eliminate", undefined, undefined, undefined, victim );
            }
            
            lastaliveplayer = game_utility_mp::trygetlastpotentiallivingplayer();
            
            if ( lastaliveplayer === self )
            {
                thread points::doscoreevent( #"mode_x_last_alive", undefined, undefined, undefined, victim );
            }
        }
        
        if ( !level.gamemodebundle.var_67302f78b191f13a )
        {
            checksuperkillevents( victim, inflictor, objweapon, meansofdeath, var_95795539e2a8343 );
        }
        
        checksupershutdownevents( victim, objweapon, meansofdeath );
    }
    else if ( weapon::iskillstreakweaponname( objweapon.basenamehash ) || weapon::function_d4dcd88477cfa8ca( objweapon.basenamehash ) )
    {
        if ( issubstr( objweapon.basename, "laser_charge" ) )
        {
            thread points::doscoreevent( #"kill_v_power_laser" );
        }
    }
    
    if ( !isdefined( victim.damagedplayers[ self.guid ] ) )
    {
        cleankill();
    }
    
    if ( !game_utility_mp::lpcfeaturegated() )
    {
        if ( !isdefined( self.killedplayers[ victimguid ] ) )
        {
            self.killedplayers[ victimguid ] = 0;
        }
        
        self.killedplayers[ victimguid ]++;
        
        if ( !isdefined( self.var_dbec57a6f0f50e6c[ victimguid ] ) )
        {
            self.var_dbec57a6f0f50e6c[ victimguid ] = 0;
        }
        
        self.var_dbec57a6f0f50e6c[ victimguid ]++;
        
        if ( !isdefined( victim.killedby[ myguid ] ) )
        {
            victim.killedby[ myguid ] = 0;
        }
        
        victim.killedby[ myguid ]++;
        function_a6f9417565d0ec0c();
    }
    
    victim.lastkilledby = self;
    
    if ( !game_utility_mp::lpcfeaturegated() && !level.multiteambased )
    {
        enemycount = 0;
        
        if ( level.teambased )
        {
            enemycount = teams::getenemycount( self.team );
        }
        else
        {
            enemycount = level.players.size - 1;
        }
        
        if ( enemycount > 3 && self.killedplayers.size == enemycount )
        {
            currentcount = 0;
            
            if ( isdefined( self.pers[ "killEnemyTeam" ] ) )
            {
                currentcount = self.pers[ "killEnemyTeam" ];
            }
            
            shouldprogress = 1;
            
            foreach ( player, killcount in self.killedplayers )
            {
                if ( killcount <= currentcount )
                {
                    shouldprogress = 0;
                    break;
                }
            }
            
            if ( shouldprogress )
            {
                killentireenemyteam( killid );
            }
        }
    }
    
    if ( !victim utility::isusingremote() )
    {
        victim thread player::setdof_killer();
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"deployed_decoy" ][ #"hash_e3efe28a08433358" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        victim [[ var_32dbca3143d9c4a5 ]]();
    }
    
    script::bufferednotify( "kill_event_buffered", victim, var_95795539e2a8343, meansofdeath, self.modifiers );
    thread potg_events::onplayerkilled( self, inflictor, victim, meansofdeath, objweapon, deathdata.psoffsettime );
    
    if ( isbrgamemode() && level.var_64fa056a9a5ed146 )
    {
        thread namespace_4c6ef5221f3fa284::function_31dbee8b223e11ce( victim );
    }
    else
    {
        thread namespace_4c6ef5221f3fa284::function_914a94e95f5cd13a( victim );
    }
    
    var_6c2c150894af98a9 = self getplayermovementstate();
    level callback::callback( #"hash_6c71d319dc089c27", { #var_6c2c150894af98a9:var_6c2c150894af98a9, #isprimary:weapon::isprimaryweapon( objweapon ), #victim:victim, #iskillstreak:iskillstreakweapon, #objweapon:objweapon, #attacker:self, #event:#"hash_1f36538689dd6873" } );
}

// Namespace events
// Params 7
// Checksum 0x818f24f4, Offset: 0x13f03
// Size: 0x70
function killedagent( victim, einflictor, idamage, idflags, smeansofdeath, weapon, shitloc )
{
    assert( level.var_36cf9f43f205635c );
    namespace_4c6ef5221f3fa284::function_bd587d9af34aadfc( victim, shitloc, idamage, weapon );
    namespace_4c6ef5221f3fa284::function_914a94e95f5cd13a( victim );
    namespace_4c6ef5221f3fa284::function_44a00dc3f336bca6();
}

// Namespace events
// Params 2
// Checksum 0x2eeb54cb, Offset: 0x13f7b
// Size: 0x19d
function function_f567912869fad5d4( cur_kill_streak, victim )
{
    if ( level.gamemodebundle.var_9a8d85cbed27b23d )
    {
        if ( cur_kill_streak > 1 )
        {
            if ( cur_kill_streak <= 30 )
            {
                thread points::doscoreevent( hashcat( #"streak_x", cur_kill_streak ), undefined, undefined, undefined, victim );
            }
            else
            {
                thread points::doscoreevent( #"streak_x30_plus" );
            }
        }
    }
    else
    {
        streaknum = 5;
        
        if ( level.gametype == "arm" || level.gametype == "conflict" || level.gametype == "brtdm" )
        {
            streaknum = 10;
        }
        
        if ( !( cur_kill_streak % streaknum ) )
        {
            if ( ( !isdefined( self.lastkillsplash ) || cur_kill_streak != self.lastkillsplash ) && !isbrgamemode() )
            {
                thread hud_util::teamplayercardsplash( "callout_kill_streaking", self, undefined, cur_kill_streak );
                self.lastkillsplash = cur_kill_streak;
            }
            
            if ( cur_kill_streak <= 30 )
            {
                thread points::doscoreevent( hashcat( #"streak_", cur_kill_streak ) );
            }
        }
        
        if ( cur_kill_streak > 30 )
        {
            thread points::doscoreevent( #"streak_max" );
        }
    }
    
    if ( cur_kill_streak > 1 )
    {
        if ( cur_kill_streak == level.nukecost && level.gametypebundle.earnnuke && !level.disablepersonalnuke )
        {
            thread killstreaks::function_bb3b6daf53f1e682( level.nukecost, level.gamemodebundle.nukeref ?? "nuke" );
        }
    }
}

// Namespace events
// Params 1
// Checksum 0x5a9502fe, Offset: 0x14120
// Size: 0xbb
function function_f805c88de53eee6d( event )
{
    if ( !isdefined( level.poi ) )
    {
        return 0;
    }
    
    if ( !isdefined( self.var_b785384fff792496 ) )
    {
        self.var_b785384fff792496 = [];
    }
    
    if ( !isdefined( self.var_b785384fff792496[ event ] ) )
    {
        self.var_b785384fff792496[ event ] = [];
    }
    
    poiname = poi::poi_findpoioriginisin( self.origin );
    
    if ( !( isdefined( poiname ) && isdefined( level.poi[ poiname ][ "calloutIndex" ] ) ) )
    {
        return 0;
    }
    
    calloutIndex = level.poi[ poiname ][ "calloutIndex" ];
    
    if ( function_e259a93b0f90250d( event, calloutIndex ) )
    {
        function_e5ce623333bc4fe4( event, calloutIndex );
    }
}

// Namespace events
// Params 2
// Checksum 0x528f94e1, Offset: 0x141e3
// Size: 0x2b, Type: bool
function function_e259a93b0f90250d( event, calloutIndex )
{
    if ( isdefined( self.var_b785384fff792496[ event ][ calloutIndex ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace events
// Params 2
// Checksum 0x1573ec59, Offset: 0x14217
// Size: 0x32
function function_e5ce623333bc4fe4( event, calloutIndex )
{
    self.var_b785384fff792496[ event ][ calloutIndex ] = 1;
    challenges::function_37e945722d6497f3( self, event, 1 );
}

// Namespace events
// Params 4
// Checksum 0x14f816ab, Offset: 0x14251
// Size: 0x16c0
function checkkillstreakkillevents( objweapon, meansofdeath, inflictor, victim )
{
    iskillstreak = isdefined( objweapon ) && weapon::iskillstreakweapon( objweapon.basename ) || weapon::iskillstreakvehicleinflictor( inflictor ) || inflictor killstreak::isjuggernaut();
    
    if ( !iskillstreak )
    {
        return;
    }
    
    var_e2e82b6431a6ecd0 = killstreaks::function_b28df08dec350c61( inflictor, objweapon );
    function_7fae313f10bc9d47( self, victim, inflictor, objweapon, var_e2e82b6431a6ecd0 );
    
    if ( points::isforcekillstreakprogressweapon( objweapon ) )
    {
        return;
    }
    
    if ( !isdefined( var_e2e82b6431a6ecd0 ) )
    {
        return;
    }
    
    cankillchain = 1;
    
    if ( isdefined( var_e2e82b6431a6ecd0.mpstreaksysteminfo ) )
    {
        lifeidearned = var_e2e82b6431a6ecd0.mpstreaksysteminfo.streaklifeid;
        lifeidcurrent = self.lifeid;
        
        if ( lifeidearned != lifeidcurrent )
        {
            cankillchain = 0;
        }
        
        if ( var_e2e82b6431a6ecd0.mpstreaksysteminfo.ownerxuid != self getxuid() )
        {
            cankillchain = 0;
        }
    }
    
    if ( !isdefined( var_e2e82b6431a6ecd0.streakname ) )
    {
        return;
    }
    
    givemidmatch = 0;
    isair = 0;
    isground = 0;
    killstreakname = var_e2e82b6431a6ecd0.streakname;
    
    switch ( killstreakname )
    {
        case #"hash_e477c24ee18bb2f6":
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "killstreakTankKills" ] ) )
                {
                    self.leaderboarddata[ "killstreakTankKills" ] = self.leaderboarddata[ "killstreakTankKills" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "killstreakTankKills" ] ) )
                {
                    [[ level.leaderboardfunc[ "killstreakTankKills" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                
                if ( isdefined( self.pers[ "killstreakTankKills" ] ) )
                {
                    self.pers[ "killstreakTankKills" ] = self.pers[ "killstreakTankKills" ] + 1;
                }
            }
            
            givemidmatch = 1;
            isground = 1;
            break;
        case #"hash_349713b5ad494dda":
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "killstreakChopperGunnerKills" ] ) )
                {
                    self.leaderboarddata[ "killstreakChopperGunnerKills" ] = self.leaderboarddata[ "killstreakChopperGunnerKills" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "killstreakChopperGunnerKills" ] ) )
                {
                    [[ level.leaderboardfunc[ "killstreakChopperGunnerKills" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                
                if ( isdefined( self.pers[ "killstreakChopperGunnerKills" ] ) )
                {
                    self.pers[ "killstreakChopperGunnerKills" ] = self.pers[ "killstreakChopperGunnerKills" ] + 1;
                }
            }
            
            givemidmatch = 1;
            isair = 1;
            break;
        case #"hash_691f39dddd9116b8":
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "killstreakChopperSupportKills" ] ) )
                {
                    self.leaderboarddata[ "killstreakChopperSupportKills" ] = self.leaderboarddata[ "killstreakChopperSupportKills" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "killstreakChopperSupportKills" ] ) )
                {
                    [[ level.leaderboardfunc[ "killstreakChopperSupportKills" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                
                if ( isdefined( self.pers[ "killstreakChopperSupportKills" ] ) )
                {
                    self.pers[ "killstreakChopperSupportKills" ] = self.pers[ "killstreakChopperSupportKills" ] + 1;
                }
            }
            
            givemidmatch = 1;
            isair = 1;
            break;
        case #"hash_28d0236400e33fd0":
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "killstreakCruiseMissileKills" ] ) )
                {
                    self.leaderboarddata[ "killstreakCruiseMissileKills" ] = self.leaderboarddata[ "killstreakCruiseMissileKills" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "killstreakCruiseMissileKills" ] ) )
                {
                    [[ level.leaderboardfunc[ "killstreakCruiseMissileKills" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                
                if ( isdefined( self.pers[ "killstreakCruiseMissileKills" ] ) )
                {
                    self.pers[ "killstreakCruiseMissileKills" ] = self.pers[ "killstreakCruiseMissileKills" ] + 1;
                }
            }
            
            givemidmatch = 1;
            isair = 1;
            break;
        case #"hash_4220be38a5f150b8":
            givemidmatch = 1;
            break;
        case #"hash_413c38e72fe8b5bf":
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "killstreakGunshipKills" ] ) )
                {
                    self.leaderboarddata[ "killstreakGunshipKills" ] = self.leaderboarddata[ "killstreakGunshipKills" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "killstreakGunshipKills" ] ) )
                {
                    [[ level.leaderboardfunc[ "killstreakGunshipKills" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                
                if ( isdefined( self.pers[ "killstreakGunshipKills" ] ) )
                {
                    self.pers[ "killstreakGunshipKills" ] = self.pers[ "killstreakGunshipKills" ] + 1;
                }
            }
            
            givemidmatch = 1;
            isair = 1;
            break;
        case #"hash_bf2f9adbd2b41d5":
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "killstreakVTOLJetKills" ] ) )
                {
                    self.leaderboarddata[ "killstreakVTOLJetKills" ] = self.leaderboarddata[ "killstreakVTOLJetKills" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "killstreakVTOLJetKills" ] ) )
                {
                    [[ level.leaderboardfunc[ "killstreakVTOLJetKills" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                
                if ( isdefined( self.pers[ "killstreakVTOLJetKills" ] ) )
                {
                    self.pers[ "killstreakVTOLJetKills" ] = self.pers[ "killstreakVTOLJetKills" ] + 1;
                }
            }
            
            givemidmatch = 1;
            isair = 1;
            break;
        case #"hash_4ad475e6e15635bd":
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "killstreakJuggernautKills" ] ) )
                {
                    self.leaderboarddata[ "killstreakJuggernautKills" ] = self.leaderboarddata[ "killstreakJuggernautKills" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "killstreakJuggernautKills" ] ) )
                {
                    [[ level.leaderboardfunc[ "killstreakJuggernautKills" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                
                if ( isdefined( self.pers[ "killstreakJuggernautKills" ] ) )
                {
                    self.pers[ "killstreakJuggernautKills" ] = self.pers[ "killstreakJuggernautKills" ] + 1;
                }
            }
            
            givemidmatch = 1;
            isground = 1;
            break;
        case #"hash_cd0a0403551fc411":
            givemidmatch = 1;
            isground = 1;
            break;
        case #"hash_52d9b7ed584bec3e":
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "killstreakShieldTurretKills" ] ) )
                {
                    self.leaderboarddata[ "killstreakShieldTurretKills" ] = self.leaderboarddata[ "killstreakShieldTurretKills" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "killstreakShieldTurretKills" ] ) )
                {
                    [[ level.leaderboardfunc[ "killstreakShieldTurretKills" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                
                if ( isdefined( self.pers[ "killstreakShieldTurretKills" ] ) )
                {
                    self.pers[ "killstreakShieldTurretKills" ] = self.pers[ "killstreakShieldTurretKills" ] + 1;
                }
            }
            
            givemidmatch = 1;
            isground = 1;
            break;
        case #"hash_62810d05099e0103":
            givemidmatch = 1;
            break;
        case #"hash_cf0ef5bef19a311b":
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "killstreakWheelsonKills" ] ) )
                {
                    self.leaderboarddata[ "killstreakWheelsonKills" ] = self.leaderboarddata[ "killstreakWheelsonKills" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "killstreakWheelsonKills" ] ) )
                {
                    [[ level.leaderboardfunc[ "killstreakWheelsonKills" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                
                if ( isdefined( self.pers[ "killstreakWheelsonKills" ] ) )
                {
                    self.pers[ "killstreakWheelsonKills" ] = self.pers[ "killstreakWheelsonKills" ] + 1;
                }
            }
            
            givemidmatch = 1;
            isground = 1;
            break;
        case #"hash_8c766d6477287bb6":
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "killstreakAirstrikeKills" ] ) )
                {
                    self.leaderboarddata[ "killstreakAirstrikeKills" ] = self.leaderboarddata[ "killstreakAirstrikeKills" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "killstreakAirstrikeKills" ] ) )
                {
                    [[ level.leaderboardfunc[ "killstreakAirstrikeKills" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                
                if ( isdefined( self.pers[ "killstreakAirstrikeKills" ] ) )
                {
                    self.pers[ "killstreakAirstrikeKills" ] = self.pers[ "killstreakAirstrikeKills" ] + 1;
                }
            }
            
            givemidmatch = 1;
            isair = 1;
            break;
        case #"hash_4d5aa76e8707f47b":
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "killstreakSentryGunKills" ] ) )
                {
                    self.leaderboarddata[ "killstreakSentryGunKills" ] = self.leaderboarddata[ "killstreakSentryGunKills" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "killstreakSentryGunKills" ] ) )
                {
                    [[ level.leaderboardfunc[ "killstreakSentryGunKills" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                
                if ( isdefined( self.pers[ "killstreakSentryGunKills" ] ) )
                {
                    self.pers[ "killstreakSentryGunKills" ] = self.pers[ "killstreakSentryGunKills" ] + 1;
                }
            }
            
            givemidmatch = 1;
            isground = 1;
            break;
        case #"hash_ab5712e297cd430e":
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "killstreakRemoteTurretKills" ] ) )
                {
                    self.leaderboarddata[ "killstreakRemoteTurretKills" ] = self.leaderboarddata[ "killstreakRemoteTurretKills" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "killstreakRemoteTurretKills" ] ) )
                {
                    [[ level.leaderboardfunc[ "killstreakRemoteTurretKills" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                
                if ( isdefined( self.pers[ "killstreakRemoteTurretKills" ] ) )
                {
                    self.pers[ "killstreakRemoteTurretKills" ] = self.pers[ "killstreakRemoteTurretKills" ] + 1;
                }
            }
            
            givemidmatch = 1;
            isground = 1;
            break;
        case #"hash_b4ac3581c343a029":
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "killstreakCluserStrikeKills" ] ) )
                {
                    self.leaderboarddata[ "killstreakCluserStrikeKills" ] = self.leaderboarddata[ "killstreakCluserStrikeKills" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "killstreakCluserStrikeKills" ] ) )
                {
                    [[ level.leaderboardfunc[ "killstreakCluserStrikeKills" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                
                if ( isdefined( self.pers[ "killstreakCluserStrikeKills" ] ) )
                {
                    self.pers[ "killstreakCluserStrikeKills" ] = self.pers[ "killstreakCluserStrikeKills" ] + 1;
                }
            }
            
            givemidmatch = 1;
            isair = 1;
            break;
        case #"hash_e6bea339d3cbd3e8":
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "killstreakWhitePhosphorousKillsAssists" ] ) )
                {
                    self.leaderboarddata[ "killstreakWhitePhosphorousKillsAssists" ] = self.leaderboarddata[ "killstreakWhitePhosphorousKillsAssists" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "killstreakWhitePhosphorousKillsAssists" ] ) )
                {
                    [[ level.leaderboardfunc[ "killstreakWhitePhosphorousKillsAssists" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                
                if ( isdefined( self.pers[ "killstreakWhitePhosphorousKillsAssists" ] ) )
                {
                    self.pers[ "killstreakWhitePhosphorousKillsAssists" ] = self.pers[ "killstreakWhitePhosphorousKillsAssists" ] + 1;
                }
            }
            
            givemidmatch = 1;
            isair = 1;
            break;
        case #"hash_9e36e3bd3a9dd00d":
            givemidmatch = 1;
            isair = 1;
            break;
        case #"hash_7a687f6a4d685110":
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "killstreakSwitchbladeDroneKills" ] ) )
                {
                    self.leaderboarddata[ "killstreakSwitchbladeDroneKills" ] = self.leaderboarddata[ "killstreakSwitchbladeDroneKills" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "killstreakSwitchbladeDroneKills" ] ) )
                {
                    [[ level.leaderboardfunc[ "killstreakSwitchbladeDroneKills" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                
                if ( isdefined( self.pers[ "killstreakSwitchbladeDroneKills" ] ) )
                {
                    self.pers[ "killstreakSwitchbladeDroneKills" ] = self.pers[ "killstreakSwitchbladeDroneKills" ] + 1;
                }
            }
            
            givemidmatch = 1;
            isair = 1;
            break;
        case #"hash_a1031216158c7882":
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "killstreakLoiteringMunitionKills" ] ) )
                {
                    self.leaderboarddata[ "killstreakLoiteringMunitionKills" ] = self.leaderboarddata[ "killstreakLoiteringMunitionKills" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "killstreakLoiteringMunitionKills" ] ) )
                {
                    [[ level.leaderboardfunc[ "killstreakLoiteringMunitionKills" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                
                if ( isdefined( self.pers[ "killstreakLoiteringMunitionKills" ] ) )
                {
                    self.pers[ "killstreakLoiteringMunitionKills" ] = self.pers[ "killstreakLoiteringMunitionKills" ] + 1;
                }
            }
            
            givemidmatch = 1;
            isair = 1;
            break;
        case #"hash_472d8b6c2f51a9c8":
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "killstreakIMSKills" ] ) )
                {
                    self.leaderboarddata[ "killstreakIMSKills" ] = self.leaderboarddata[ "killstreakIMSKills" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "killstreakIMSKills" ] ) )
                {
                    [[ level.leaderboardfunc[ "killstreakIMSKills" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                
                if ( isdefined( self.pers[ "killstreakIMSKills" ] ) )
                {
                    self.pers[ "killstreakIMSKills" ] = self.pers[ "killstreakIMSKills" ] + 1;
                }
            }
            
            givemidmatch = 1;
            isground = 1;
            break;
        case #"hash_48cc3a9a58208f82":
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "killstreakDNANukeKills" ] ) )
                {
                    self.leaderboarddata[ "killstreakDNANukeKills" ] = self.leaderboarddata[ "killstreakDNANukeKills" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "killstreakDNANukeKills" ] ) )
                {
                    [[ level.leaderboardfunc[ "killstreakDNANukeKills" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                
                if ( isdefined( self.pers[ "killstreakDNANukeKills" ] ) )
                {
                    self.pers[ "killstreakDNANukeKills" ] = self.pers[ "killstreakDNANukeKills" ] + 1;
                }
            }
            
            givemidmatch = 1;
            isair = 1;
            break;
        case #"hash_c45eaeb429cf1944":
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "killstreakAssaultChopperKills" ] ) )
                {
                    self.leaderboarddata[ "killstreakAssaultChopperKills" ] = self.leaderboarddata[ "killstreakAssaultChopperKills" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "killstreakAssaultChopperKills" ] ) )
                {
                    [[ level.leaderboardfunc[ "killstreakAssaultChopperKills" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                
                if ( isdefined( self.pers[ "killstreakAssaultChopperKills" ] ) )
                {
                    self.pers[ "killstreakAssaultChopperKills" ] = self.pers[ "killstreakAssaultChopperKills" ] + 1;
                }
            }
            
            givemidmatch = 1;
            isair = 1;
            break;
        default:
            if ( !isdefined( level.var_eac48db7da1c7505 ) )
            {
                level.var_eac48db7da1c7505 = spawnstruct();
                level.var_eac48db7da1c7505.iskillstreakkill = 1;
            }
            
            thread points::doscoreevent( #"hash_1387a1180e68dc64", objweapon, undefined, undefined, undefined, undefined, undefined, cankillchain, var_e2e82b6431a6ecd0, undefined, level.var_eac48db7da1c7505 );
            break;
    }
    
    if ( isdefined( var_e2e82b6431a6ecd0.kills ) )
    {
        var_e2e82b6431a6ecd0.kills++;
    }
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "killstreakKills" ] ) )
        {
            self.leaderboarddata[ "killstreakKills" ] = self.leaderboarddata[ "killstreakKills" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "killstreakKills" ] ) )
        {
            [[ level.leaderboardfunc[ "killstreakKills" ] ]]( self, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
        
        if ( isdefined( self.pers[ "killstreakKills" ] ) )
        {
            self.pers[ "killstreakKills" ] = self.pers[ "killstreakKills" ] + 1;
        }
    }
    
    if ( isair )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
        {
            if ( isdefined( self.leaderboarddata[ "killstreakAirKills" ] ) )
            {
                self.leaderboarddata[ "killstreakAirKills" ] = self.leaderboarddata[ "killstreakAirKills" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "killstreakAirKills" ] ) )
            {
                [[ level.leaderboardfunc[ "killstreakAirKills" ] ]]( self, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
            
            if ( isdefined( self.pers[ "killstreakAirKills" ] ) )
            {
                self.pers[ "killstreakAirKills" ] = self.pers[ "killstreakAirKills" ] + 1;
            }
        }
    }
    
    if ( isground )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
        {
            if ( isdefined( self.leaderboarddata[ "killstreakGroundKills" ] ) )
            {
                self.leaderboarddata[ "killstreakGroundKills" ] = self.leaderboarddata[ "killstreakGroundKills" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "killstreakGroundKills" ] ) )
            {
                [[ level.leaderboardfunc[ "killstreakGroundKills" ] ]]( self, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
            
            if ( isdefined( self.pers[ "killstreakGroundKills" ] ) )
            {
                self.pers[ "killstreakGroundKills" ] = self.pers[ "killstreakGroundKills" ] + 1;
            }
        }
    }
    
    if ( givemidmatch )
    {
        event = hashcat( #"ss_kill_", killstreakname );
        pointsoverride = undefined;
        
        if ( cankillchain && isdefined( self.perks[ "specialty_chain_killstreaks" ] ) )
        {
            pointsoverride = rank::getscoreinfovalue( event );
        }
        
        dontwait = 1;
        
        if ( !isdefined( level.var_eac48db7da1c7505 ) )
        {
            level.var_eac48db7da1c7505 = spawnstruct();
            level.var_eac48db7da1c7505.iskillstreakkill = 1;
        }
        
        thread points::doscoreevent( event, objweapon, pointsoverride, undefined, undefined, dontwait, undefined, cankillchain, var_e2e82b6431a6ecd0, undefined, level.var_eac48db7da1c7505 );
    }
    
    level thread battlechatter_mp::saytoself( self, "plr_killfirm_killstreak", undefined, 0.75 );
}

// Namespace events
// Params 4
// Checksum 0xa28466a5, Offset: 0x15919
// Size: 0x1d1
function function_2754deb49e2bee42( objweapon, meansofdeath, inflictor, victim )
{
    iskillstreak = isdefined( objweapon ) && weapon::iskillstreakweapon( objweapon.basename ) || weapon::iskillstreakvehicleinflictor( inflictor ) || inflictor.crate.streakref == "airdrop_crate";
    
    if ( !iskillstreak )
    {
        return;
    }
    
    var_e2e82b6431a6ecd0 = killstreaks::function_b28df08dec350c61( inflictor, objweapon );
    function_7fae313f10bc9d47( self, victim, inflictor, objweapon, var_e2e82b6431a6ecd0 );
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "killstreakKills" ] ) )
        {
            self.leaderboarddata[ "killstreakKills" ] = self.leaderboarddata[ "killstreakKills" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "killstreakKills" ] ) )
        {
            [[ level.leaderboardfunc[ "killstreakKills" ] ]]( self, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
        
        if ( isdefined( self.pers[ "killstreakKills" ] ) )
        {
            self.pers[ "killstreakKills" ] = self.pers[ "killstreakKills" ] + 1;
        }
    }
    
    if ( isdefined( inflictor.crate.streakinfo.kills ) )
    {
        inflictor.crate.streakinfo.kills++;
        return;
    }
    
    if ( isdefined( var_e2e82b6431a6ecd0.kills ) )
    {
        var_e2e82b6431a6ecd0.kills++;
    }
}

// Namespace events
// Params 5
// Checksum 0x6ed6d323, Offset: 0x15af2
// Size: 0x32f
function function_7fae313f10bc9d47( attacker, victim, inflictor, objweapon, streakinfo )
{
    if ( isplayer( victim ) )
    {
        telemetry_mp::function_cbf4eaf678a574e3( victim, killstreak::getkillstreaknamefromweapon( objweapon ), inflictor.crate.streakinfo.streakname );
        
        if ( isbot( victim ) )
        {
            if ( !isdefined( attacker.pers[ "telemetry" ].bot_killstreak_kills ) )
            {
                attacker.pers[ "telemetry" ].bot_killstreak_kills = 0;
            }
            
            attacker.pers[ "telemetry" ].bot_killstreak_kills++;
        }
        else
        {
            if ( !isdefined( attacker.pers[ "telemetry" ].player_killstreak_kills ) )
            {
                attacker.pers[ "telemetry" ].player_killstreak_kills = 0;
            }
            
            attacker.pers[ "telemetry" ].player_killstreak_kills++;
        }
    }
    else if ( isagent( victim ) )
    {
        if ( !isdefined( attacker.pers[ "telemetry" ].agent_killstreak_kills ) )
        {
            attacker.pers[ "telemetry" ].agent_killstreak_kills = 0;
        }
        
        attacker.pers[ "telemetry" ].agent_killstreak_kills++;
    }
    
    if ( isplayer( attacker ) )
    {
        if ( isbot( attacker ) )
        {
            if ( !isdefined( victim.pers[ "telemetry" ].var_90ab4e486d171e04 ) )
            {
                victim.pers[ "telemetry" ].var_90ab4e486d171e04 = 0;
            }
            
            victim.pers[ "telemetry" ].var_90ab4e486d171e04++;
        }
        else
        {
            if ( !isdefined( victim.pers[ "telemetry" ].var_d0d338af214b4950 ) )
            {
                victim.pers[ "telemetry" ].var_d0d338af214b4950 = 0;
            }
            
            victim.pers[ "telemetry" ].var_d0d338af214b4950++;
        }
    }
    
    if ( streakinfo.streakname == "airdrop_crate" )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
        {
            if ( isdefined( self.leaderboarddata[ "enemiesCrushedByCarePackages" ] ) )
            {
                self.leaderboarddata[ "enemiesCrushedByCarePackages" ] = self.leaderboarddata[ "enemiesCrushedByCarePackages" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "enemiesCrushedByCarePackages" ] ) )
            {
                [[ level.leaderboardfunc[ "enemiesCrushedByCarePackages" ] ]]( self, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
            
            if ( isdefined( self.pers[ "enemiesCrushedByCarePackages" ] ) )
            {
                self.pers[ "enemiesCrushedByCarePackages" ] = self.pers[ "enemiesCrushedByCarePackages" ] + 1;
            }
        }
    }
}

// Namespace events
// Params 3
// Checksum 0xeeac36f8, Offset: 0x15e29
// Size: 0x94
function function_6c7ad7001bc34550( objweapon, meansofdeath, inflictor )
{
    if ( ( weapon::iskillstreakweapon( objweapon.basename ) || weapon::iskillstreakvehicleinflictor( inflictor ) ) && !points::isforcekillstreakprogressweapon( objweapon ) && isdefined( inflictor.streakinfo.streakname ) && isdefined( inflictor.streakinfo.kills ) )
    {
        inflictor.streakinfo.kills++;
    }
}

// Namespace events
// Params 5
// Checksum 0x89527f60, Offset: 0x15ec5
// Size: 0xfe
function checksuperkillevents( victim, inflictor, objweapon, meansofdeath, var_95795539e2a8343 )
{
    superinuse = supers_mp::issuperinuse();
    superref = supers_mp::getcurrentsuperref();
    super = supers_mp::getcurrentsuper();
    superweapon = weapon::issuperweapon( objweapon.basename );
    score_ref = undefined;
    
    if ( !isdefined( superref ) )
    {
        return;
    }
    
    if ( superweapon )
    {
        thread killedplayerwithsuperweapon( victim, inflictor, objweapon, meansofdeath, var_95795539e2a8343 );
        
        if ( meansofdeath != "MOD_MELEE" )
        {
            script::bufferednotify( "super_kill_buffered" );
        }
    }
    
    var_7bc60c501ee175e5 = 0;
    
    if ( isdefined( superref ) )
    {
        if ( var_7bc60c501ee175e5 )
        {
            thread superkill( superref, meansofdeath );
            supers_mp::combatrecordsuperkill( superref );
            
            if ( isdefined( score_ref ) )
            {
                thread points::doscoreevent( score_ref );
            }
            
            script::bufferednotify( "super_kill_buffered" );
        }
    }
}

// Namespace events
// Params 3
// Checksum 0xddfa18d4, Offset: 0x15fcb
// Size: 0x6f
function checksupershutdownevents( victim, objweapon, meansofdeath )
{
    var_4ef981e77b5ebe75 = victim supers_mp::issuperinuse();
    var_3d1e7c555af29a6 = victim supers_mp::getcurrentsuperref();
    victimsuper = victim supers_mp::getcurrentsuper();
    
    if ( !isdefined( var_3d1e7c555af29a6 ) )
    {
        return;
    }
    
    if ( var_4ef981e77b5ebe75 == 1 )
    {
        thread supershutdown( victim );
    }
}

// Namespace events
// Params 5
// Checksum 0x781ef54, Offset: 0x16042
// Size: 0x9e
function killedplayerwithsuperweapon( victim, inflictor, objweapon, meansofdeath, var_95795539e2a8343 )
{
    superref = supers_mp::getsuperrefforsuperweapon( objweapon );
    var_2d2366f17e40145e = self.recentkillsperweapon[ var_95795539e2a8343 ];
    
    if ( var_2d2366f17e40145e > 0 && var_2d2366f17e40145e % 2 == 0 )
    {
        superkill( superref, meansofdeath );
    }
    else
    {
        var_109694c092585142 = supers_mp::getcurrentsuper();
        var_109694c092585142.numkills++;
    }
    
    supers_mp::combatrecordsuperkill( superref );
}

// Namespace events
// Params 2
// Checksum 0x301c6b36, Offset: 0x160e8
// Size: 0xc7
function superkill( superref, meansofdeath )
{
    rootsuperref = supers_mp::getrootsuperref( superref );
    medalref = hashcat( #"super_kill_", rootsuperref );
    
    if ( rank::function_dd61d4640c245ebc( medalref ) )
    {
        if ( !isdefined( level.var_4bd3fbac02cbd9ec ) )
        {
            level.var_4bd3fbac02cbd9ec = spawnstruct();
            level.var_4bd3fbac02cbd9ec.var_a1142360cbd74f69 = 1;
        }
        
        thread points::doscoreevent( medalref, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, level.var_4bd3fbac02cbd9ec );
    }
    
    var_109694c092585142 = supers_mp::getcurrentsuper();
    var_109694c092585142.numkills++;
    self.modifiers[ "super_kill_medal" ] = superref;
}

// Namespace events
// Params 3
// Checksum 0x8a819b78, Offset: 0x161b7
// Size: 0x3de
function killedkillstreak( killstreakname, killer, var_70d5883dbcbedf76 )
{
    if ( isbrgamemode() && killstreakname == "scrambler_drone_guard" )
    {
        awardname = hashcat( #"kill_ss_counter_uav" );
    }
    else
    {
        awardname = hashcat( #"kill_ss_", killstreakname );
    }
    
    if ( isdefined( var_70d5883dbcbedf76 ) )
    {
        if ( weapon::iskillstreakweapon( var_70d5883dbcbedf76 ) && killstreak::getkillstreaknamefromweapon( var_70d5883dbcbedf76 ) == #"hellstorm_missile" )
        {
            var_48fb0d78f90533f7 = #"hellstorm_shutdown";
        }
        
        if ( isdefined( killer ) )
        {
            killer thread gamelogic_mp::threadedsetweaponstatbyname( var_70d5883dbcbedf76, 1, "kill_streak_destructions" );
        }
    }
    
    if ( isdefined( self.attackerdata ) )
    {
        foreach ( var_fb28c40836d3bf4a in self.attackerdata )
        {
            var_379a0f39e0147743 = var_fb28c40836d3bf4a.attackerent ?? var_fb28c40836d3bf4a.attacker;
            
            if ( !isdefined( var_379a0f39e0147743 ) )
            {
                continue;
            }
            
            if ( var_379a0f39e0147743 != killer )
            {
                if ( var_fb28c40836d3bf4a.damage < 75 )
                {
                    continue;
                }
            }
            
            var_8fae12a308f4b91c = var_fb28c40836d3bf4a.objweapon;
            
            if ( var_70d5883dbcbedf76.damagemodcategory == #"airpatrol" && var_8fae12a308f4b91c == var_70d5883dbcbedf76 )
            {
                if ( !isdefined( var_379a0f39e0147743.var_6a73b2bd383cfa80 ) )
                {
                    var_379a0f39e0147743.var_6a73b2bd383cfa80 = 0;
                }
                
                var_379a0f39e0147743.var_6a73b2bd383cfa80++;
                
                if ( var_379a0f39e0147743.var_6a73b2bd383cfa80 == 2 )
                {
                    var_379a0f39e0147743 thread points::doscoreevent( #"air_patrol_double" );
                }
            }
            
            eventinfo = { #isdestroyedkillstreak:1 };
            
            if ( !level.scoreeventglobals.var_78344ca1a83764cf && isdefined( var_8fae12a308f4b91c ) )
            {
                if ( weaponclass( var_8fae12a308f4b91c ) != "rocketlauncher" && var_8fae12a308f4b91c.basename != "iw8_la_kgolf_mp" )
                {
                    eventinfo.var_ef32324b503188b8 = 1;
                }
            }
            
            var_379a0f39e0147743 thread points::doscoreevent( awardname, var_8fae12a308f4b91c, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, eventinfo );
            
            if ( var_48fb0d78f90533f7 )
            {
                var_379a0f39e0147743 thread points::doscoreevent( var_48fb0d78f90533f7, var_8fae12a308f4b91c, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, eventinfo );
            }
            
            if ( var_379a0f39e0147743 != killer )
            {
                var_379a0f39e0147743 thread challenges::function_3ef859e4837f4249( self, var_379a0f39e0147743, var_8fae12a308f4b91c );
            }
            
            streakbundle = level.streakglobals.streakbundles[ killstreakname ];
            
            if ( isdefined( streakbundle.var_6203bc2d78f80e93 ) )
            {
                var_379a0f39e0147743 thread points::doscoreevent( streakbundle.var_6203bc2d78f80e93, var_8fae12a308f4b91c, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, eventinfo );
            }
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( var_379a0f39e0147743 ) ) )
            {
                if ( isdefined( var_379a0f39e0147743.leaderboarddata[ "destroyedKillstreaks" ] ) )
                {
                    var_379a0f39e0147743.leaderboarddata[ "destroyedKillstreaks" ] = var_379a0f39e0147743.leaderboarddata[ "destroyedKillstreaks" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "destroyedKillstreaks" ] ) )
                {
                    [[ level.leaderboardfunc[ "destroyedKillstreaks" ] ]]( var_379a0f39e0147743, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                
                if ( isdefined( var_379a0f39e0147743.pers[ "destroyedKillstreaks" ] ) )
                {
                    var_379a0f39e0147743.pers[ "destroyedKillstreaks" ] = var_379a0f39e0147743.pers[ "destroyedKillstreaks" ] + 1;
                }
            }
            
            level thread battlechatter_mp::saytoself( var_379a0f39e0147743, "plr_killstreak_destroy", undefined, 0.75 );
        }
    }
}

// Namespace events
// Params 4
// Checksum 0x70291021, Offset: 0x1659d
// Size: 0x55
function killedequipment( victim, killer, var_70d5883dbcbedf76, streakinfo )
{
    if ( isdefined( killer ) )
    {
        if ( isdefined( victim ) && isdefined( streakinfo ) )
        {
            killstreak::function_b700fb2ad0fa69e9( victim, killer, streakinfo );
        }
        
        killer thread gamelogic_mp::threadedsetweaponstatbyname( var_70d5883dbcbedf76, 1, "equipment_destructions" );
    }
}

// Namespace events
// Params 1
// Checksum 0x982f4cad, Offset: 0x165fa
// Size: 0xa3
function processscrapassist( killer )
{
    scrapassistplayers = killstreaks::getscrapassistplayers( killer );
    
    foreach ( player in scrapassistplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player thread points::doscoreevent( #"scrap_assist" );
    }
}

// Namespace events
// Params 2
// Checksum 0xf41585db, Offset: 0x166a5
// Size: 0xae, Type: bool
function is_enemy_highest_score( enemy, enemies )
{
    if ( !isdefined( enemy.score ) )
    {
        return false;
    }
    
    foreach ( e in enemies )
    {
        if ( e.score > enemy.score )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace events
// Params 6
// Checksum 0x4216a31e, Offset: 0x1675c
// Size: 0x264
function getshotdistancetype( attacker, objweapon, meansofdeath, attackerposition, victimposition, weapongroup = weapon::getweapongroup( objweapon.basename ) )
{
    if ( isalive( attacker ) && meansofdeath != "MOD_MELEE" && meansofdeath != "MOD_MELEE_TAKEDOWN" && meansofdeath != "MOD_MEATSHIELD" && !attacker utility::isusingremote() && ( weapon::isprimaryweapon( objweapon ) || weapon::iscacsecondaryweapon( objweapon, weapongroup ) || weapon::isthrowingknife( objweapon ) ) && !weapon::iskillstreakweapon( objweapon.basename ) && !attacker.assistedsuicide )
    {
        killdistsq = distancesquared( attackerposition, victimposition );
        pointblankthreshold = level.scoreeventglobals.pointblankrange ?? 96;
        
        if ( killdistsq < pointblankthreshold * pointblankthreshold )
        {
            return "pointblank";
        }
        
        if ( killdistsq > 4000000 )
        {
            return "very_longshot";
        }
        
        longshotdist = undefined;
        
        switch ( weapongroup )
        {
            case #"hash_34340d457a63e7f1":
                longshotdist = 800;
                break;
            case #"hash_ab10f9c080fe4faf":
            case #"hash_c9c190665b9c4a1d":
            case #"hash_cd7f87dc1cdeaa54":
                longshotdist = 1200;
                break;
            case #"hash_bef5ec0b3e197ae":
            case #"hash_47368bc0d2ef1565":
            case #"hash_8af0086b038622b5":
            case #"hash_dd616da0b395a0b0":
                if ( objweapon.basename == "iw9_dm_crossbow_mp" )
                {
                    longshotdist = 1200;
                }
                else
                {
                    longshotdist = 1500;
                }
                
                break;
            case #"hash_46b22b021532342e":
            case #"hash_c095d67337b1f5a1":
                longshotdist = 2000;
                break;
            case #"hash_16cf6289ab06bd30":
                longshotdist = 500;
                break;
            case #"hash_9d18adab1b65a661":
                longshotdist = 1200;
                break;
            case #"hash_f4cd588fc5c3d2d5":
                longshotdist = 1969;
                break;
            default:
                longshotdist = 1536;
                break;
        }
        
        longshotdistsq = longshotdist * longshotdist;
        
        if ( killdistsq > longshotdistsq )
        {
            return "longshot";
        }
    }
    
    return "none";
}

// Namespace events
// Params 3
// Checksum 0xe49e4135, Offset: 0x169c9
// Size: 0x14f, Type: bool
function islongshotspecial( attackerposition, victimposition, objweapon )
{
    killdistsq = distancesquared( attackerposition, victimposition );
    var_e00fe9ba31bfb619 = weapon::getweapongroup( objweapon.basename );
    longshotdist = undefined;
    
    switch ( var_e00fe9ba31bfb619 )
    {
        case #"hash_34340d457a63e7f1":
            longshotdist = 1500;
            break;
        case #"hash_ab10f9c080fe4faf":
        case #"hash_c9c190665b9c4a1d":
        case #"hash_cd7f87dc1cdeaa54":
            longshotdist = 2000;
            break;
        case #"hash_47368bc0d2ef1565":
            longshotdist = 4000;
            break;
        case #"hash_bef5ec0b3e197ae":
        case #"hash_8af0086b038622b5":
        case #"hash_dd616da0b395a0b0":
            longshotdist = 3000;
            break;
        case #"hash_46b22b021532342e":
        case #"hash_c095d67337b1f5a1":
            longshotdist = 8000;
            break;
        case #"hash_16cf6289ab06bd30":
            longshotdist = 1000;
            break;
        case #"hash_9d18adab1b65a661":
            longshotdist = 4000;
            break;
        default:
            longshotdist = 4000;
            break;
    }
    
    longshotdistsq = longshotdist * longshotdist;
    return killdistsq > longshotdistsq;
}

// Namespace events
// Params 5
// Checksum 0xf627db33, Offset: 0x16b21
// Size: 0x7f, Type: bool
function isdeathfromabove( attacker, objweapon, meansofdeath, attackerposition, victim )
{
    if ( isalive( attacker ) && attacker isjumping() && utility::isbulletdamage( meansofdeath ) )
    {
        deltaheight = attacker.origin[ 2 ] - victim.origin[ 2 ];
        return ( deltaheight > 60 );
    }
    
    return false;
}

// Namespace events
// Params 1
// Checksum 0x7042e14e, Offset: 0x16ba9
// Size: 0x8f, Type: bool
function function_853f2fa3d548d7ec( var_99a29d7de5eb9cbb )
{
    if ( var_99a29d7de5eb9cbb isjumping() )
    {
        return true;
    }
    else if ( !var_99a29d7de5eb9cbb isonground() && !var_99a29d7de5eb9cbb iswallrunning() && !var_99a29d7de5eb9cbb isswimming() && !var_99a29d7de5eb9cbb isswimunderwater() )
    {
        return true;
    }
    else
    {
        parachutestate = var_99a29d7de5eb9cbb._blackboard.parachutestate;
        
        if ( isdefined( parachutestate ) && ( parachutestate == "freefall" || parachutestate == "parachuting" ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace events
// Params 5
// Checksum 0x5a6b909b, Offset: 0x16c41
// Size: 0x4c, Type: bool
function isskeetshooter( attacker, objweapon, meansofdeath, attackerposition, victim )
{
    return isalive( attacker ) && victim isjumping() && utility::isbulletdamage( meansofdeath );
}

// Namespace events
// Params 3
// Checksum 0xebe2fa6, Offset: 0x16c96
// Size: 0xbb, Type: bool
function isbackkill( attacker, victim, meansofdeath )
{
    if ( !isplayer( attacker ) || !isplayer( victim ) )
    {
        return false;
    }
    
    if ( meansofdeath != "MOD_RIFLE_BULLET" && meansofdeath != "MOD_PISTOL_BULLET" && meansofdeath != "MOD_MELEE" && meansofdeath != "MOD_MELEE_TAKEDOWN" && meansofdeath != "MOD_HEAD_SHOT" )
    {
        return false;
    }
    
    victimangles = victim getplayerangles();
    attackerangles = attacker getplayerangles();
    anglediff = angleclamp180( victimangles[ 1 ] - attackerangles[ 1 ] );
    
    if ( abs( anglediff ) < 80 )
    {
        return true;
    }
    
    return false;
}

// Namespace events
// Params 1
// Checksum 0x7ec29669, Offset: 0x16d5a
// Size: 0x3a, Type: bool
function issurvivorkill( player )
{
    return player.health > 0 && player.health < player.maxhealth * 0.5;
}

// Namespace events
// Params 2
// Checksum 0xeae4cc86, Offset: 0x16d9d
// Size: 0xeb, Type: bool
function isdetected( attacker, victim )
{
    issnapshotted = isdefined( victim.lastsnapshotgrenadetime ) && victim.lastsnapshotgrenadetime + snapshot_grenade::function_9258113638c21420() > gettime();
    isfalseflagged = isdefined( victim.var_9ae31e49bba9af9a ) && victim.var_9ae31e49bba9af9a + snapshot_grenade::function_9258113638c21420() > gettime();
    var_8c9e987916bad411 = uav_bigmap::function_45375faf54fa8ecc( attacker, victim );
    var_400a08f27b9010a2 = ( attacker.radarstrength > 3 || var_8c9e987916bad411 ) && !isdefined( victim.perks[ "specialty_br_ghost" ] );
    var_3cc6d411a0540f5 = istrue( victim.var_3cc6d411a0540f5 );
    return issnapshotted || var_400a08f27b9010a2 || var_3cc6d411a0540f5 || isfalseflagged;
}

// Namespace events
// Params 1
// Checksum 0x1b5dda5d, Offset: 0x16e91
// Size: 0x2e
function proximityassist( killid )
{
    self.modifiers[ "proximityAssist" ] = 1;
    thread points::doscoreevent( #"proximityassist" );
}

// Namespace events
// Params 1
// Checksum 0x5b060d66, Offset: 0x16ec7
// Size: 0x2e
function proximitykill( killid )
{
    self.modifiers[ "proximityKill" ] = 1;
    thread points::doscoreevent( #"proximitykill" );
}

// Namespace events
// Params 1
// Checksum 0x76313121, Offset: 0x16efd
// Size: 0xf5
function longshot( killid )
{
    thread utility::trycall( level.matchdata_logattackerkillevent, killid, "longshot" );
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "longshotKills" ] ) )
        {
            self.leaderboarddata[ "longshotKills" ] = self.leaderboarddata[ "longshotKills" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "longshotKills" ] ) )
        {
            [[ level.leaderboardfunc[ "longshotKills" ] ]]( self, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
        
        if ( isdefined( self.pers[ "longshotKills" ] ) )
        {
            self.pers[ "longshotKills" ] = self.pers[ "longshotKills" ] + 1;
        }
    }
}

// Namespace events
// Params 1
// Checksum 0x93c56100, Offset: 0x16ffa
// Size: 0x20
function very_longshot( killid )
{
    level thread battlechatter_mp::trysaylocalsound( self, #"bc_flavor_player_headshotlong", 1 );
}

// Namespace events
// Params 2
// Checksum 0xbec9c4ab, Offset: 0x17022
// Size: 0x113
function pointblank( killid, victim )
{
    thread utility::trycall( level.matchdata_logattackerkillevent, killid, "pointblank" );
    thread points::doscoreevent( #"pointblank", undefined, undefined, undefined, victim );
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "pointBlankKills" ] ) )
        {
            self.leaderboarddata[ "pointBlankKills" ] = self.leaderboarddata[ "pointBlankKills" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "pointBlankKills" ] ) )
        {
            [[ level.leaderboardfunc[ "pointBlankKills" ] ]]( self, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
        
        if ( isdefined( self.pers[ "pointBlankKills" ] ) )
        {
            self.pers[ "pointBlankKills" ] = self.pers[ "pointBlankKills" ] + 1;
        }
    }
}

// Namespace events
// Params 5
// Checksum 0xff3e850c, Offset: 0x1713d
// Size: 0x73
function headshot( killid, eventinfo, objweapon, inflictor, victim )
{
    if ( inflictor.var_aa3dc1c1665433b7 )
    {
        return;
    }
    
    thread utility::trycall( level.matchdata_logattackerkillevent, killid, "headshot" );
    thread points::doscoreevent( #"headshot", objweapon, undefined, undefined, victim, undefined, undefined, undefined, undefined, undefined, eventinfo );
}

// Namespace events
// Params 2
// Checksum 0x99ab6a4b, Offset: 0x171b8
// Size: 0x10e
function avengedplayer( killid, lastvictim )
{
    thread utility::trycall( level.matchdata_logattackerkillevent, killid, "avenger" );
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "avengerKills" ] ) )
        {
            self.leaderboarddata[ "avengerKills" ] = self.leaderboarddata[ "avengerKills" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "avengerKills" ] ) )
        {
            [[ level.leaderboardfunc[ "avengerKills" ] ]]( self, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
        
        if ( isdefined( self.pers[ "avengerKills" ] ) )
        {
            self.pers[ "avengerKills" ] = self.pers[ "avengerKills" ] + 1;
        }
    }
    
    thread points::doscoreevent( #"avenger" );
}

// Namespace events
// Params 2
// Checksum 0x4933c293, Offset: 0x172ce
// Size: 0x46
function assistedsuicide( killid, objweapon )
{
    thread utility::trycall( level.matchdata_logattackerkillevent, killid, "assistedsuicide" );
    
    if ( !isbrgamemode() )
    {
        thread points::doscoreevent( #"assistedsuicide", objweapon );
    }
}

// Namespace events
// Params 2
// Checksum 0x8c6a79b1, Offset: 0x1731c
// Size: 0x16e
function defendedplayer( killid, guid )
{
    thread utility::trycall( level.matchdata_logattackerkillevent, killid, "defender" );
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "defenderKills" ] ) )
        {
            self.leaderboarddata[ "defenderKills" ] = self.leaderboarddata[ "defenderKills" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "defenderKills" ] ) )
        {
            [[ level.leaderboardfunc[ "defenderKills" ] ]]( self, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
        
        if ( isdefined( self.pers[ "defenderKills" ] ) )
        {
            self.pers[ "defenderKills" ] = self.pers[ "defenderKills" ] + 1;
        }
    }
    
    thread killeventtextpopup( #"save_teammate", 0 );
    thread points::doscoreevent( #"save_teammate" );
    self.modifiers[ "savior_kill" ] = 1;
    self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"savior_kill" ) );
}

// Namespace events
// Params 1
// Checksum 0xa1eea749, Offset: 0x17492
// Size: 0x33
function postdeathkill( killid )
{
    thread utility::trycall( level.matchdata_logattackerkillevent, killid, "posthumous" );
    thread points::doscoreevent( #"posthumous" );
}

// Namespace events
// Params 2
// Checksum 0x468a01c9, Offset: 0x174cd
// Size: 0x14e
function revenge( killid, victim )
{
    thread utility::trycall( level.matchdata_logattackerkillevent, killid, "revenge" );
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "revengeKills" ] ) )
        {
            self.leaderboarddata[ "revengeKills" ] = self.leaderboarddata[ "revengeKills" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "revengeKills" ] ) )
        {
            [[ level.leaderboardfunc[ "revengeKills" ] ]]( self, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
        
        if ( isdefined( self.pers[ "revengeKills" ] ) )
        {
            self.pers[ "revengeKills" ] = self.pers[ "revengeKills" ] + 1;
        }
    }
    
    thread points::doscoreevent( #"revenge" );
    
    if ( !level.gamemodebundle.var_da7869431c7775a6 )
    {
        playfx( utility::getfx( "money" ), victim.origin + ( 0, 0, 64 ) );
    }
}

// Namespace events
// Params 5
// Checksum 0x315a802c, Offset: 0x17623
// Size: 0x420
function multikill( killid, killcount, var_cfec745b97741232, var_1c6c0b7e15afcd86, victim )
{
    assert( killcount > 1 );
    var_f6e3d8ceb292ae49 = istrue( level.scoreeventglobals.var_f6e3d8ceb292ae49 );
    
    if ( !var_f6e3d8ceb292ae49 )
    {
        if ( !isdefined( self.currentmultikill ) )
        {
            self.currentmultikill = killcount;
        }
        
        if ( killcount < self.currentmultikill )
        {
            return;
        }
        
        self notify( #"multikill" );
        self endon( #"multikill" );
        self endon( #"disconnect" );
        waitframe();
    }
    
    profilestart();
    award = undefined;
    teamsplash = undefined;
    
    switch ( killcount )
    {
        case 2:
            award = #"double";
            break;
        case 3:
            award = #"triple";
            teamsplash = "callout_3xkill";
            break;
        case 4:
            award = #"four";
            teamsplash = "callout_4xkill";
            break;
        case 5:
            award = #"five";
            teamsplash = "callout_5xkill";
            break;
        case 6:
            award = #"six";
            teamsplash = "callout_6xkill";
            break;
        case 7:
            award = #"seven";
            teamsplash = "callout_7xkill";
            break;
        case 8:
            if ( !level.scoreeventglobals.var_824e7a3005f228e9 )
            {
                award = #"eight";
                teamsplash = "callout_8xkill";
                break;
            }
        default:
            award = #"multi";
            teamsplash = "callout_9xkill";
            break;
    }
    
    if ( isdefined( self.pers[ "totalMultikills" ] ) )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
        {
            if ( isdefined( self.leaderboarddata[ "totalMultikills" ] ) )
            {
                self.leaderboarddata[ "totalMultikills" ] = self.leaderboarddata[ "totalMultikills" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "totalMultikills" ] ) )
            {
                [[ level.leaderboardfunc[ "totalMultikills" ] ]]( self, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
            
            if ( isdefined( self.pers[ "totalMultikills" ] ) )
            {
                self.pers[ "totalMultikills" ] = self.pers[ "totalMultikills" ] + 1;
            }
        }
    }
    
    if ( isdefined( self.pers[ "highestMultikill" ] ) && killcount > self.pers[ "highestMultikill" ] )
    {
        self.pers[ "highestMultikill" ] = killcount;
        codcasterclientmatchdata::function_2c4d0484259644c5( 10, killcount );
    }
    
    thread utility::trycall( level.matchdata_logmultikill, killid, killcount );
    
    if ( isdefined( award ) )
    {
        self.currentmultikill = killcount;
        var_1c6c0b7e15afcd86 = istrue( var_1c6c0b7e15afcd86 );
        
        if ( !level.var_af0045e470655ee )
        {
            thread killeventtextpopup( award, var_cfec745b97741232 ?? 1, var_1c6c0b7e15afcd86, { #victim:victim } );
        }
        
        if ( !var_1c6c0b7e15afcd86 )
        {
            eventinfo = spawnstruct();
            eventinfo.var_fa13397bbf3bd94a = 1;
            eventinfo.ismultikill = 1;
            thread points::doscoreevent( award, undefined, undefined, undefined, victim, undefined, undefined, undefined, undefined, undefined, eventinfo );
        }
        
        if ( self.var_b1a7bcec9cf49488 )
        {
            challenges::function_57bca958eb1b226a( self );
            self.var_5273e52e39429943 = undefined;
        }
        else if ( self.var_38810aee0d242063 )
        {
            self.var_5273e52e39429943 = self.var_38810aee0d242063;
        }
        
        self.var_38810aee0d242063 = undefined;
        self.var_7e5e10a6e6422f11 = undefined;
    }
    
    if ( isdefined( teamsplash ) )
    {
        if ( !var_1c6c0b7e15afcd86 )
        {
            if ( game_utility::function_8d8af1d3e14d5c3b() )
            {
                profilestop();
                return;
            }
            
            thread hud_util::teamplayercardsplash( teamsplash, self );
        }
    }
    
    profilestop();
}

// Namespace events
// Params 1
// Checksum 0x1e2fd018, Offset: 0x17a4b
// Size: 0x24b
function function_a7b7f3866fe6bf21( killcount )
{
    self notify( #"hash_d3429d97b82cfa2e" );
    self endon( #"hash_d3429d97b82cfa2e" );
    assert( killcount > 1 );
    
    if ( !isdefined( level.var_a7b7f3866fe6bf21 ) )
    {
        return;
    }
    
    waittillframeend();
    
    if ( isdefined( level.var_a7b7f3866fe6bf21.delay ) )
    {
        wait level.var_a7b7f3866fe6bf21.delay;
    }
    
    switch ( killcount )
    {
        case 2:
            if ( isdefined( level.var_a7b7f3866fe6bf21.twokills ) )
            {
                self playlocalsound( level.var_a7b7f3866fe6bf21.twokills, undefined, undefined, 1 );
            }
            
            break;
        case 3:
            if ( isdefined( level.var_a7b7f3866fe6bf21.threekills ) )
            {
                self playlocalsound( level.var_a7b7f3866fe6bf21.threekills, undefined, undefined, 1 );
            }
            
            break;
        case 4:
            if ( isdefined( level.var_a7b7f3866fe6bf21.fourkills ) )
            {
                self playlocalsound( level.var_a7b7f3866fe6bf21.fourkills, undefined, undefined, 1 );
            }
            
            break;
        case 5:
            if ( isdefined( level.var_a7b7f3866fe6bf21.fivekills ) )
            {
                self playlocalsound( level.var_a7b7f3866fe6bf21.fivekills, undefined, undefined, 1 );
            }
            
            break;
        case 6:
            if ( isdefined( level.var_a7b7f3866fe6bf21.sixkills ) )
            {
                self playlocalsound( level.var_a7b7f3866fe6bf21.sixkills, undefined, undefined, 1 );
            }
            
            break;
        case 7:
            if ( isdefined( level.var_a7b7f3866fe6bf21.sevenkills ) )
            {
                self playlocalsound( level.var_a7b7f3866fe6bf21.sevenkills, undefined, undefined, 1 );
            }
            
            break;
        default:
            if ( isdefined( level.var_a7b7f3866fe6bf21.eightkills ) )
            {
                self playlocalsound( level.var_a7b7f3866fe6bf21.eightkills, undefined, undefined, 1 );
            }
            
            break;
    }
}

// Namespace events
// Params 2
// Checksum 0x75a5a621, Offset: 0x17c9e
// Size: 0x6d
function firstblood( killid, victim )
{
    if ( !isbrgamemode() )
    {
        codcaster_utils::function_3038b6eafc46c037( 11, self.team, self getentitynumber() );
    }
    
    thread utility::trycall( level.matchdata_logattackerkillevent, killid, "firstblood" );
    thread hud_util::teamplayercardsplash( "callout_firstblood", self );
    thread points::doscoreevent( #"firstblood", undefined, undefined, undefined, victim );
}

// Namespace events
// Params 1
// Checksum 0xdcb8863d, Offset: 0x17d13
// Size: 0x6a
function hvtkill( victim )
{
    if ( isdefined( victim.bountyobject ) )
    {
        self.modifiers[ "hvtKill" ] = 1;
        self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"victim_hvt" ) );
    }
}

// Namespace events
// Params 2
// Checksum 0x20bd694b, Offset: 0x17d85
// Size: 0x76
function buzzkill( killid, victim )
{
    thread utility::trycall( level.matchdata_logattackerkillevent, killid, "buzzkill" );
    thread points::doscoreevent( #"buzzkill" );
    
    if ( level.gametypebundle.requisitionsenabled && getdvarint( @"hash_ee6087278c7605f6", 1 ) == 1 )
    {
        thread killstreaks::function_3601e07eb739e6e8( "buzzkill", victim );
    }
}

// Namespace events
// Params 0
// Checksum 0x69781552, Offset: 0x17e03
// Size: 0x12
function impairedkill()
{
    thread points::doscoreevent( #"stunned_kill" );
}

// Namespace events
// Params 0
// Checksum 0x7974be6b, Offset: 0x17e1d
// Size: 0x2
function meatshieldkill()
{
    
}

// Namespace events
// Params 1
// Checksum 0x95d5549a, Offset: 0x17e27
// Size: 0x105
function comeback( killid )
{
    thread utility::trycall( level.matchdata_logattackerkillevent, killid, "comeback" );
    thread points::doscoreevent( #"comeback" );
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "comebackKills" ] ) )
        {
            self.leaderboarddata[ "comebackKills" ] = self.leaderboarddata[ "comebackKills" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "comebackKills" ] ) )
        {
            [[ level.leaderboardfunc[ "comebackKills" ] ]]( self, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
        
        if ( isdefined( self.pers[ "comebackKills" ] ) )
        {
            self.pers[ "comebackKills" ] = self.pers[ "comebackKills" ] + 1;
        }
    }
}

// Namespace events
// Params 1
// Checksum 0x850f1dfc, Offset: 0x17f34
// Size: 0xbd
function supershutdown( victim )
{
    rootsuperref = supers_mp::getrootsuperref( victim.super.staticdata.ref );
    self.modifiers[ "superShutdown" ] = victim.super.staticdata.ref;
    medalref = hashcat( #"hash_499e8b2730bb3818", rootsuperref );
    
    switch ( rootsuperref )
    {
        case #"hash_438c49412523936e":
            medalref = #"super_shutdown_bull_charge";
            break;
    }
    
    if ( rank::function_dd61d4640c245ebc( medalref ) )
    {
        thread points::doscoreevent( medalref );
    }
}

// Namespace events
// Params 1
// Checksum 0xf9ce19ff, Offset: 0x17ff9
// Size: 0xfe
function collateral( numkills )
{
    if ( numkills == 2 )
    {
        level thread battlechatter_mp::saytoself( self, "plr_killfirm_twofer", undefined, 0.75 );
        thread points::doscoreevent( #"one_shot_two_kills" );
        self.modifiers[ "collateral_kill" ] = 1;
        self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"collateral_kill" ) );
        
        if ( level.scoreeventglobals.var_9d0863916164a13c )
        {
            if ( !isdefined( self.var_5dfbfca334403414 ) )
            {
                self.var_5dfbfca334403414 = getxhashhexname( #"one_shot_two_kills_awarded" );
            }
            
            self notify( self.var_5dfbfca334403414 );
            self.var_7a12848b93164b3c = gettime();
        }
    }
    
    if ( numkills == 3 )
    {
        level thread battlechatter_mp::saytoself( self, "plr_killfirm_threefer", undefined, 0.75 );
    }
    
    thread potg_events::collateral( self, numkills );
}

// Namespace events
// Params 1
// Checksum 0xf1fc45ba, Offset: 0x180ff
// Size: 0x16
function shotguncollateral( numkills )
{
    thread potg_events::shotguncollateral( self, numkills );
}

// Namespace events
// Params 0
// Checksum 0x537b4a10, Offset: 0x1811d
// Size: 0x12
function mantlekill()
{
    thread points::doscoreevent( #"mantle_kill" );
}

// Namespace events
// Params 0
// Checksum 0x8cfcf83f, Offset: 0x18137
// Size: 0x12
function backfire()
{
    thread points::doscoreevent( #"backfire" );
}

// Namespace events
// Params 2, eflags: 0x4
// Checksum 0x4c250d4b, Offset: 0x18151
// Size: 0xb6
function private quadfeed( killid, iskillstreakweapon )
{
    self.modifiers[ "quadfeed" ] = 1;
    self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"quadfeed" ) );
    eventinfo = { #var_fa13397bbf3bd94a:iskillstreakweapon };
    thread points::doscoreevent( #"quad_feed", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, eventinfo );
    thread potg_events::quadfeed( self, level.quadfeedinfo.obtainedstarttime, gettime() );
}

// Namespace events
// Params 1
// Checksum 0x83974b40, Offset: 0x1820f
// Size: 0x12d
function killentireenemyteam( killid )
{
    self.modifiers[ "killEnemyTeam" ] = 1;
    self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"killEnemyTeam" ) );
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "killEnemyTeam" ] ) )
        {
            self.leaderboarddata[ "killEnemyTeam" ] = self.leaderboarddata[ "killEnemyTeam" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "killEnemyTeam" ] ) )
        {
            [[ level.leaderboardfunc[ "killEnemyTeam" ] ]]( self, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
        
        if ( isdefined( self.pers[ "killEnemyTeam" ] ) )
        {
            self.pers[ "killEnemyTeam" ] = self.pers[ "killEnemyTeam" ] + 1;
        }
    }
}

// Namespace events
// Params 2
// Checksum 0xe5591539, Offset: 0x18344
// Size: 0x131
function kingslayer( killid, victim )
{
    thread points::doscoreevent( #"first_place_kill" );
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "highestRankedKills" ] ) )
        {
            self.leaderboarddata[ "highestRankedKills" ] = self.leaderboarddata[ "highestRankedKills" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "highestRankedKills" ] ) )
        {
            [[ level.leaderboardfunc[ "highestRankedKills" ] ]]( self, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
        
        if ( isdefined( self.pers[ "highestRankedKills" ] ) )
        {
            self.pers[ "highestRankedKills" ] = self.pers[ "highestRankedKills" ] + 1;
        }
    }
    
    if ( level.gametypebundle.requisitionsenabled && getdvarint( @"hash_ee6087278c7605f6", 1 ) == 1 )
    {
        thread killstreaks::function_3601e07eb739e6e8( "kingslayer", victim );
    }
}

// Namespace events
// Params 2
// Checksum 0xf8292919, Offset: 0x1847d
// Size: 0x2a
function directimpactkill( killid, victim )
{
    thread points::doscoreevent( #"launcher_direct_hit", undefined, undefined, undefined, victim );
}

// Namespace events
// Params 1
// Checksum 0x6b0f07de, Offset: 0x184af
// Size: 0x5b
function tripledefenderkill( killid )
{
    self.modifiers[ "tripledefenderkill" ] = 1;
    self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"defender" ) );
}

// Namespace events
// Params 2
// Checksum 0xf2d6ee19, Offset: 0x18512
// Size: 0xfc
function execution( killid, victim )
{
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "executions" ] ) )
        {
            self.leaderboarddata[ "executions" ] = self.leaderboarddata[ "executions" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "executions" ] ) )
        {
            [[ level.leaderboardfunc[ "executions" ] ]]( self, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
        
        if ( isdefined( self.pers[ "executions" ] ) )
        {
            self.pers[ "executions" ] = self.pers[ "executions" ] + 1;
        }
    }
    
    thread points::doscoreevent( #"execution", undefined, undefined, undefined, victim );
}

// Namespace events
// Params 0
// Checksum 0x83be7f41, Offset: 0x18616
// Size: 0x51
function cleankill()
{
    self.modifiers[ "cleanKill" ] = 1;
    self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"clean_kill" ) );
}

// Namespace events
// Params 0
// Checksum 0xdf8ac511, Offset: 0x1866f
// Size: 0xde
function disconnected()
{
    myguid = self.guid;
    
    if ( !game_utility_mp::lpcfeaturegated() )
    {
        for ( entry = 0; entry < level.players.size ; entry++ )
        {
            if ( isdefined( level.players[ entry ].killedplayers[ myguid ] ) )
            {
                level.players[ entry ].killedplayers[ myguid ] = undefined;
            }
            
            if ( isdefined( level.players[ entry ].killedby[ myguid ] ) )
            {
                level.players[ entry ].killedby[ myguid ] = undefined;
            }
            
            if ( isdefined( level.players[ entry ].var_dbec57a6f0f50e6c[ myguid ] ) )
            {
                level.players[ entry ].var_dbec57a6f0f50e6c[ myguid ] = undefined;
            }
        }
    }
}

// Namespace events
// Params 0
// Checksum 0x6e4152df, Offset: 0x18755
// Size: 0x4d
function monitorhealed()
{
    if ( rank::function_dd61d4640c245ebc( "healed" ) == 0 )
    {
        return;
    }
    
    level endon( #"end_game" );
    
    for ( ;; )
    {
        level waittill( #"healed", player );
        player thread points::doscoreevent( #"healed" );
    }
}

// Namespace events
// Params 0
// Checksum 0x2ad3d6e5, Offset: 0x187aa
// Size: 0xf9
function function_ae66e9c9792546bf()
{
    self notify( #"hash_d0b980e61c5e940c" );
    self endon( #"hash_d0b980e61c5e940c" );
    self endon( #"death_or_disconnect" );
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    
    if ( !challenges::challengesenabledforplayer() )
    {
        return;
    }
    
    if ( !isdefined( level.var_319c046ca4d59ecf ) )
    {
        level.var_319c046ca4d59ecf = getdvarint( @"hash_759733fa83683a72", 50 );
    }
    
    if ( !isdefined( self.var_8a664a995ab3f9bb ) )
    {
        self.var_8a664a995ab3f9bb = 0;
    }
    
    istacsprint = 0;
    var_134ca029298ac8e1 = undefined;
    
    while ( true )
    {
        if ( self issupersprinting() )
        {
            if ( istacsprint && isdefined( var_134ca029298ac8e1 ) )
            {
                self.var_8a664a995ab3f9bb += utility::function_3a444812a9926ec( var_134ca029298ac8e1, self.origin );
                function_34bd3d332f10855a();
            }
            else
            {
                istacsprint = 1;
            }
            
            var_134ca029298ac8e1 = self.origin;
        }
        else if ( istacsprint )
        {
            istacsprint = 0;
        }
        
        wait 0.1;
    }
}

// Namespace events
// Params 1
// Checksum 0xf1c6aa85, Offset: 0x188ab
// Size: 0xa8
function function_34bd3d332f10855a( ismatchend )
{
    if ( !isdefined( self ) || !challenges::challengesenabledforplayer() )
    {
        return;
    }
    
    if ( !isdefined( self.var_8a664a995ab3f9bb ) )
    {
        self.var_8a664a995ab3f9bb = 0;
    }
    
    if ( !isdefined( self.var_562052b0be53eb45 ) )
    {
        self.var_562052b0be53eb45 = 0;
    }
    
    var_ca188fd5d3eb833d = int( self.var_8a664a995ab3f9bb - self.var_562052b0be53eb45 );
    
    if ( !ismatchend && var_ca188fd5d3eb833d < level.var_319c046ca4d59ecf )
    {
        return;
    }
    
    challenges::function_37e945722d6497f3( self, "tac_sprint_meter_distance", var_ca188fd5d3eb833d );
    self.var_562052b0be53eb45 += var_ca188fd5d3eb833d;
}

// Namespace events
// Params 0
// Checksum 0x3ddedda8, Offset: 0x1895b
// Size: 0x7c
function function_d1b23d540da7bff0()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !challenges::challengesenabledforplayer() )
    {
        return;
    }
    
    startpos = self.origin;
    
    for ( lastpos = startpos; self.var_c0b53846b1bfb648 ; lastpos = self.origin )
    {
        waitframe();
        
        if ( player::isreallyalive( self ) )
        {
        }
    }
    
    if ( startpos != lastpos )
    {
        function_3266a5081ad49ce1( startpos, lastpos );
    }
}

// Namespace events
// Params 2
// Checksum 0xcf484f1f, Offset: 0x189df
// Size: 0x45
function function_3266a5081ad49ce1( startpos, lastpos )
{
    var_ca188fd5d3eb833d = int( utility::function_3a444812a9926ec( startpos, lastpos ) );
    
    if ( var_ca188fd5d3eb833d <= 0 )
    {
        return;
    }
    
    challenges::function_37e945722d6497f3( self, "ascender_zipline_meter_distance", var_ca188fd5d3eb833d );
}

// Namespace events
// Params 0, eflags: 0x4
// Checksum 0x5cf59859, Offset: 0x18a2c
// Size: 0x156
function private function_a6f9417565d0ec0c()
{
    if ( self.var_8c767773348195e8 )
    {
        return;
    }
    
    if ( !isdefined( enemies ) )
    {
        enemies = teams::getenemyplayers( self.team );
    }
    
    if ( enemies.size < 4 || enemies.size != self.var_dbec57a6f0f50e6c.size )
    {
        return;
    }
    
    foreach ( enemy in enemies )
    {
        if ( !self.var_dbec57a6f0f50e6c[ enemy.guid ] )
        {
            return;
        }
    }
    
    if ( level.gametypebundle.var_7c12d93605370780 )
    {
        thread points::doscoreevent( level.gametypebundle.var_7c12d93605370780 );
    }
    
    self.modifiers[ "unique_enemy_wipeout_four_plus" ] = 1;
    self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"unique_enemy_wipeout_four_plus" ) );
    self.var_8c767773348195e8 = 1;
}

// Namespace events
// Params 4
// Checksum 0x1c97dd9f, Offset: 0x18b8a
// Size: 0x59f
function function_cb5ca077839b0295( objweapon, var_95795539e2a8343, inflictor, victim )
{
    equipmentref = objweapon.equipmentref ?? inflictor.equipmentref;
    
    if ( equipmentref )
    {
        equipmentbundle = level.equipment.table[ equipmentref ].bundle;
        
        if ( !equipmentbundle )
        {
            parent_ref = equipment_mp::function_fdc4a655fbde0dec( inflictor.weapon_name );
            equipmentbundle = level.equipment.table[ parent_ref ].bundle;
        }
    }
    else if ( weapon::iskillstreakweapon( objweapon ) )
    {
        if ( level.streakglobals )
        {
            streakname = killstreak::getkillstreaknamefromweapon( objweapon );
            streakbundle = level.streakglobals.streakbundles[ streakname ];
        }
    }
    
    if ( !equipmentbundle && !streakbundle )
    {
        return;
    }
    
    if ( self.recentkillsperweapon[ var_95795539e2a8343 ] > 0 )
    {
        if ( level.scoreeventglobals.var_54d37975345db8fe )
        {
            awardevent = self.recentkillsperweapon[ var_95795539e2a8343 ] >= 2;
        }
        else
        {
            awardevent = self.recentkillsperweapon[ var_95795539e2a8343 ] % 2 == 0;
        }
    }
    
    if ( equipmentbundle )
    {
        if ( !weapon::isthrowingknife( objweapon ) )
        {
            level thread battlechatter_mp::saytoself( self, "plr_killfirm_grenade", undefined, 0.75 );
            level thread battlechatter_mp::saytoself( self, "plr_killfirm_amf", undefined, 0.75 );
        }
        
        if ( self.recentkillsperweapon[ var_95795539e2a8343 ] == 3 )
        {
            if ( equipmentbundle.var_4ff2627931ed4476 )
            {
                thread points::doscoreevent( #"triple_explosion" );
                self.modifiers[ "three_plus_explosion_kill" ] = 1;
                self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"three_plus_explosion_kill" ) );
            }
            
            if ( equipmentbundle.var_206738b1866937e5 )
            {
                eventinfo = { #killcamentstickstolookatent:isdefined( inflictor.stuckenemyentity ), #killcamlookatentityindex:victim getentitynumber(), #killcamentstarttime:inflictor.birthtime, #killcamentindex:isent( inflictor ) ? inflictor getentitynumber() : undefined };
                thread points::doscoreevent( equipmentbundle.var_206738b1866937e5, objweapon, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, eventinfo );
            }
        }
        
        if ( self.recentkillsperweapon[ var_95795539e2a8343 ] >= 4 )
        {
            if ( equipmentbundle.var_48541461c3c78d64 )
            {
                eventinfo = { #killcamentstickstolookatent:isdefined( inflictor.stuckenemyentity ), #killcamlookatentityindex:victim getentitynumber(), #killcamentstarttime:inflictor.birthtime, #killcamentindex:isent( inflictor ) ? inflictor getentitynumber() : undefined };
                thread points::doscoreevent( equipmentbundle.var_48541461c3c78d64, objweapon, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, eventinfo );
            }
        }
        
        if ( awardevent )
        {
            if ( equipmentbundle.var_4ff2627931ed4476 )
            {
                thread points::doscoreevent( equipmentbundle.var_4ff2627931ed4476 );
            }
            
            if ( equipmentbundle.var_4ff2627931ed4476 == #"grenade_double" )
            {
                self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"popcorn" ) );
            }
            
            if ( equipmentbundle.var_6c2175e2a04030af && self.var_4330cc679e242908[ var_95795539e2a8343 ] == 2 )
            {
                thread points::doscoreevent( #"double_obj_delayed_explosion" );
                self.modifiers[ "double_obj_delayed_explosion" ] = 1;
                self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"double_obj_delayed_explosion" ) );
            }
        }
        
        return;
    }
    
    eventinfo = { #killcamentstickstolookatent:isdefined( inflictor.stuckenemyentity ), #killcamlookatentityindex:victim getentitynumber(), #killcamentstarttime:inflictor.birthtime, #killcamentindex:isent( inflictor ) ? inflictor getentitynumber() : undefined };
    
    if ( self.recentkillsperweapon[ var_95795539e2a8343 ] == 2 && streakbundle.var_8d9fd3d69e285af6 )
    {
        thread points::doscoreevent( streakbundle.var_8d9fd3d69e285af6, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, eventinfo );
    }
    else if ( self.recentkillsperweapon[ var_95795539e2a8343 ] == 3 && streakbundle.var_206738b1866937e5 )
    {
        thread points::doscoreevent( streakbundle.var_206738b1866937e5, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, eventinfo );
    }
    else if ( self.recentkillsperweapon[ var_95795539e2a8343 ] >= 4 && streakbundle.var_48541461c3c78d64 )
    {
        thread points::doscoreevent( streakbundle.var_48541461c3c78d64, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, eventinfo );
    }
    
    params = { #streakname:streakname, #player:self, #event:#"hash_945ff68488ae3b43" };
    level callback::callback( #"hash_6c71d319dc089c27", params );
}

// Namespace events
// Params 8, eflags: 0xc
// Checksum 0x8b939eeb, Offset: 0x19131
// Size: 0x3b7
function private function_525262dc44273c6( killid, victim, objweapon, var_95795539e2a8343, inflictor, defensekill, defendedobjective, defendedtrigger )
{
    self notify( #"hash_af67ece9a041bfcc" );
    self endon( #"hash_af67ece9a041bfcc" );
    var_f6e3d8ceb292ae49 = istrue( level.scoreeventglobals.var_f6e3d8ceb292ae49 );
    
    if ( var_f6e3d8ceb292ae49 )
    {
        if ( !player::isreallyalive( self ) )
        {
            return;
        }
    }
    
    self endon( #"disconnect" );
    
    if ( !var_f6e3d8ceb292ae49 )
    {
        level endon( #"game_ended" );
    }
    
    if ( !isdefined( self.var_b6aeeab42ea78ff ) )
    {
        self.var_b6aeeab42ea78ff = 0;
    }
    
    self.var_b6aeeab42ea78ff++;
    
    if ( defensekill && defendedtrigger && victim istouching( defendedtrigger ) )
    {
        if ( !isdefined( self.var_195d4f618d28705c ) )
        {
            self.var_195d4f618d28705c = 0;
        }
        
        self.var_195d4f618d28705c++;
        grantwipeout = 1;
        
        foreach ( var_3c80af1be574dfc3 in defendedobjective.touchlist[ victim.team ] )
        {
            if ( isalive( var_3c80af1be574dfc3.player ) )
            {
                grantwipeout = 0;
                break;
            }
        }
        
        if ( !self.var_321d11776f8dc586 && grantwipeout && self.var_195d4f618d28705c >= 2 )
        {
            self.var_321d11776f8dc586 = 1;
            thread points::doscoreevent( #"mode_x_wipeout" );
            self.modifiers[ "obj_clear_two_plus_enemies" ] = 1;
            self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"obj_clear_two_plus_enemies" ) );
        }
    }
    
    if ( !isdefined( self.var_2fb177f83bfb1a31 ) )
    {
        self.var_2fb177f83bfb1a31 = [];
    }
    
    self.var_2fb177f83bfb1a31[ objweapon.basename ] = 1;
    
    if ( !self.var_dc40713bf1d96b04 && self.var_2fb177f83bfb1a31.size > 1 && self.var_b6aeeab42ea78ff >= 3 )
    {
        self.modifiers[ "two_weapon_triple_plus_kill" ] = 1;
        self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"two_weapon_triple_plus_kill" ) );
        self.var_dc40713bf1d96b04 = 1;
    }
    
    if ( var_f6e3d8ceb292ae49 )
    {
        utility::function_7ce22801650d61d4( "death", level.multikilltimeout );
    }
    else
    {
        wait level.multikilltimeout;
    }
    
    if ( self.var_b6aeeab42ea78ff > 1 )
    {
        thread multikill( killid, self.var_b6aeeab42ea78ff, 1, !var_f6e3d8ceb292ae49, victim );
        
        if ( self.var_b6aeeab42ea78ff > 2 && !isbrgamemode() )
        {
            codcaster_utils::function_3038b6eafc46c037( 12, self.team, self getentitynumber(), self.var_b6aeeab42ea78ff );
        }
    }
    
    self.var_b6aeeab42ea78ff = undefined;
    self.var_195d4f618d28705c = undefined;
    self.var_2fb177f83bfb1a31 = undefined;
    self.var_dc40713bf1d96b04 = undefined;
    self.var_9d1953bce8a134a0 = undefined;
    self.var_43d22bb148995a1d = undefined;
    self.var_321d11776f8dc586 = undefined;
}

// Namespace events
// Params 6
// Checksum 0x34d3455b, Offset: 0x194f0
// Size: 0x47a
function updaterecentkills( killid, victim, objweapon, var_95795539e2a8343, iskillstreakweapon, inflictor )
{
    self notify( #"hash_c078619108beee2f" );
    self endon( #"hash_c078619108beee2f" );
    var_f6e3d8ceb292ae49 = istrue( level.scoreeventglobals.var_f6e3d8ceb292ae49 );
    
    if ( var_f6e3d8ceb292ae49 )
    {
        if ( !player::isreallyalive( self ) )
        {
            return;
        }
    }
    
    self endon( #"disconnect" );
    
    if ( !var_f6e3d8ceb292ae49 )
    {
        level endon( #"game_ended" );
    }
    
    self.recentkillcount++;
    script::bufferednotify( "update_rapid_kill_buffered", self.recentkillcount, var_95795539e2a8343 );
    var_1d70cbb8f38e94ba = iskillstreakweapon && level.scoreeventglobals.var_4d4945ec102ffc4b;
    
    if ( self.recentkillcount > 1 && !var_1d70cbb8f38e94ba )
    {
        childthread function_a7b7f3866fe6bf21( self.recentkillcount );
    }
    
    if ( self.recentkillcount > 1 && !iskillstreakweapon )
    {
        thread potg_events::multikill( self.recentkillcount );
    }
    
    if ( !isdefined( self.recentkillsperweapon ) )
    {
        self.recentkillsperweapon = [];
    }
    
    if ( !isdefined( self.recentkillsperweapon[ var_95795539e2a8343 ] ) )
    {
        self.recentkillsperweapon[ var_95795539e2a8343 ] = 0;
    }
    
    self.recentkillsperweapon[ var_95795539e2a8343 ]++;
    var_1344ad15d2d7bd21 = weapon::function_1344ad15d2d7bd21( objweapon );
    
    if ( isdefined( victim.var_c36e159445e2a48b ) )
    {
        if ( !isdefined( self.var_4330cc679e242908[ var_95795539e2a8343 ] ) )
        {
            self.var_4330cc679e242908[ var_95795539e2a8343 ] = 0;
        }
        
        self.var_4330cc679e242908[ var_95795539e2a8343 ]++;
    }
    
    defensekill = game_utility_mp::isdefending( victim );
    var_ce3dff4182d11009 = game_utility_mp::isassaulting( victim );
    
    if ( var_ce3dff4182d11009 )
    {
        self.recentassaultcount++;
        
        if ( script::isnumbermultipleof( self.recentassaultcount, 3 ) )
        {
            tripledefenderkill( killid );
        }
    }
    
    if ( defensekill )
    {
        defendedobjective = game_utility_mp::function_f32f6f305882730( victim );
        
        if ( defendedobjective )
        {
            defendedtrigger = gameobjects_shared::get_trigger( defendedobjective );
            var_d363c86bcff087f1 = defendedobjective.entnum;
            
            if ( !isdefined( var_d363c86bcff087f1 ) )
            {
                var_d363c86bcff087f1 = gameobjects_shared::get_objective_key( defendedobjective );
            }
            
            if ( !isdefined( self.defenderskilled[ var_d363c86bcff087f1 ] ) )
            {
                self.defenderskilled[ var_d363c86bcff087f1 ] = 0;
            }
            
            self.defenderskilled[ var_d363c86bcff087f1 ]++;
        }
    }
    
    if ( !iskillstreakweapon || var_1344ad15d2d7bd21 )
    {
        thread function_525262dc44273c6( killid, victim, objweapon, var_95795539e2a8343, inflictor, defensekill, defendedobjective, defendedtrigger );
    }
    
    if ( level.gamemodebundle.var_67302f78b191f13a )
    {
        function_cb5ca077839b0295( objweapon, var_95795539e2a8343, inflictor, victim );
    }
    
    if ( isdetected( self, victim ) )
    {
        if ( isdefined( self.activeuavcount ) )
        {
            if ( !isdefined( self.var_9d1953bce8a134a0 ) )
            {
                self.var_9d1953bce8a134a0 = 0;
            }
            
            self.var_9d1953bce8a134a0++;
        }
        
        if ( self.var_44f1c37319244499 )
        {
            if ( !isdefined( self.var_43d22bb148995a1d ) )
            {
                self.var_43d22bb148995a1d = 0;
            }
            
            self.var_43d22bb148995a1d++;
        }
    }
    
    if ( var_f6e3d8ceb292ae49 )
    {
        utility::function_7ce22801650d61d4( "death", level.multikilltimeout );
    }
    else
    {
        if ( self.recentkillcount > 1 && !var_1d70cbb8f38e94ba )
        {
            thread multikill( killid, self.recentkillcount, 0, undefined, victim );
        }
        
        wait level.multikilltimeout;
    }
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "mostMultikills" ] ) )
        {
            self.leaderboarddata[ "mostMultikills" ] = self.leaderboarddata[ "mostMultikills" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "mostMultikills" ] ) )
        {
            [[ level.leaderboardfunc[ "mostMultikills" ] ]]( self, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
        
        if ( isdefined( self.pers[ "mostMultikills" ] ) )
        {
            self.pers[ "mostMultikills" ] = self.pers[ "mostMultikills" ] + 1;
        }
    }
    
    self.currentmultikill = 0;
    self.recentkillcount = 0;
    self.recentkillsperweapon = undefined;
    self.var_4330cc679e242908 = undefined;
}

// Namespace events
// Params 0, eflags: 0x4
// Checksum 0x4256702e, Offset: 0x19972
// Size: 0xc
function private function_5921bd2730684415()
{
    self.var_db03e79aed8ed98c = undefined;
}

// Namespace events
// Params 0, eflags: 0x4
// Checksum 0x2325f5ff, Offset: 0x19986
// Size: 0x26
function private function_e600866023455ea4()
{
    utility::waittill_any( "stance_changed", "death" );
    function_5921bd2730684415();
    self notify( #"hash_87d6bd6ff51a004c" );
}

// Namespace events
// Params 0, eflags: 0x4
// Checksum 0xf63b8b9c, Offset: 0x199b4
// Size: 0x18
function private function_b6850b060d2242f3()
{
    wait 2;
    function_5921bd2730684415();
    self notify( #"hash_87d6bd6ff51a004c" );
}

// Namespace events
// Params 0, eflags: 0xc
// Checksum 0xc40077c1, Offset: 0x199d4
// Size: 0xb4
function private function_6558c9df0597db5b()
{
    self notify( #"hash_814ef2cc866ebc6" );
    self endon( #"hash_814ef2cc866ebc6" );
    self endon( #"disconnect" );
    self endon( #"hash_87d6bd6ff51a004c" );
    childthread function_e600866023455ea4();
    childthread function_b6850b060d2242f3();
    var_4927c7b702468f3c = 0;
    yawprev = self.angles[ 1 ];
    yawcurr = yawprev;
    
    while ( abs( var_4927c7b702468f3c ) < 45 )
    {
        yawprev = yawcurr;
        yawcurr = self.angles[ 1 ];
        angledelta = angleclamp180( yawcurr - yawprev );
        var_4927c7b702468f3c += angledelta;
        waitframe();
    }
    
    self.var_db03e79aed8ed98c = 1;
}

// Namespace events
// Params 0
// Checksum 0x13785edc, Offset: 0x19a90
// Size: 0x67
function function_d71060ad67bd36ea()
{
    if ( self.var_db03e79aed8ed98c )
    {
        self.modifiers[ "snaked_kill" ] = 1;
        self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"snaked_kill" ) );
        return;
    }
    
    thread function_6558c9df0597db5b();
}

// Namespace events
// Params 2
// Checksum 0x42abef17, Offset: 0x19aff
// Size: 0x4f
function updatec4vehiclemultkill( meansofdeath, inflictor )
{
    paramstruct = spawnstruct();
    paramstruct.meansofdeath = meansofdeath;
    paramstruct.inflictor = inflictor;
    br_challenges::challengeevaluator( "br_mastery_c4VehicleMultKill", paramstruct );
}

// Namespace events
// Params 0
// Checksum 0x68d30f7, Offset: 0x19b56
// Size: 0x2e
function updateghostridekills()
{
    paramstruct = spawnstruct();
    paramstruct.maderecentkill = 1;
    br_challenges::challengeevaluator( "br_mastery_ghostRideWhip", paramstruct );
}

// Namespace events
// Params 0, eflags: 0x4
// Checksum 0x18a87de4, Offset: 0x19b8c
// Size: 0x20
function private function_d8db301e06045993()
{
    level.quadfeedinfo = { #feedtimes:[], #player:self };
}

// Namespace events
// Params 2, eflags: 0x4
// Checksum 0x2df77d58, Offset: 0x19bb4
// Size: 0x167, Type: bool
function private function_f74b17e0937aae8( now, deathdata )
{
    if ( level.quadfeedinfo.player != self )
    {
        function_d8db301e06045993();
    }
    
    if ( level.scoreeventglobals.var_5543d5e7459cf038 )
    {
        if ( deathdata.iskillstreakweapon && !deathdata.var_1344ad15d2d7bd21 )
        {
            return false;
        }
    }
    
    if ( level.quadfeedinfo.feedtimes.size > 0 )
    {
        var_d28a188305e5e86e = now - ( level.scoreeventglobals.var_b82800c69a2ec68c ?? 10000 );
        
        if ( level.quadfeedinfo.feedtimes[ 0 ] < var_d28a188305e5e86e )
        {
            level.quadfeedinfo.feedtimes = function_7e2a37dec1c1525( var_d28a188305e5e86e );
        }
        
        if ( level.quadfeedinfo.feedtimes.size == 3 )
        {
            var_2a6990ffc785d506 = level.quadfeedinfo.feedtimes[ 0 ];
            function_d8db301e06045993();
            level.quadfeedinfo.obtainedstarttime = var_2a6990ffc785d506;
            return true;
        }
    }
    
    level.quadfeedinfo.feedtimes[ level.quadfeedinfo.feedtimes.size ] = now;
    return false;
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0x58a0f868, Offset: 0x19d24
// Size: 0xa1
function private function_7e2a37dec1c1525( var_d28a188305e5e86e )
{
    var_b0232391559c34b0 = [];
    
    foreach ( feedtime in level.quadfeedinfo.feedtimes )
    {
        if ( feedtime > var_d28a188305e5e86e )
        {
            var_b0232391559c34b0[ var_b0232391559c34b0.size ] = feedtime;
        }
    }
    
    return var_b0232391559c34b0;
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0xe1b60a16, Offset: 0x19dce
// Size: 0x43
function private function_cead7db776b55e91( params )
{
    if ( player::isreallyalive( self ) )
    {
        self.eventsslideendtime = params.time;
        potg::processevent( "recent_slide" );
        return;
    }
    
    self.var_ec0a10d5cbcfca21 = undefined;
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0x534d9c26, Offset: 0x19e19
// Size: 0x37
function private function_36163635c67da3c8( params )
{
    if ( player::isreallyalive( self ) )
    {
        self.var_ec0a10d5cbcfca21 = params.time;
        return;
    }
    
    self.var_ec0a10d5cbcfca21 = undefined;
}

// Namespace events
// Params 0
// Checksum 0x812a2367, Offset: 0x19e58
// Size: 0x41, Type: bool
function events_issliding()
{
    if ( self issprintsliding() )
    {
        return true;
    }
    
    now = gettime();
    
    if ( isdefined( self.eventsslideendtime ) )
    {
        if ( now - self.eventsslideendtime <= 500 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0xdefcd1, Offset: 0x19ea2
// Size: 0x35
function private dtpend( params )
{
    if ( player::isreallyalive( self ) )
    {
        self.var_9d3e1a32ce12960b = params.time;
        return;
    }
    
    self.var_9d3e1a32ce12960b = undefined;
}

// Namespace events
// Params 0
// Checksum 0x287d62c1, Offset: 0x19edf
// Size: 0x42, Type: bool
function function_8e315fc2393f2705()
{
    if ( self isdiving() )
    {
        return true;
    }
    
    now = gettime();
    
    if ( isdefined( self.var_9d3e1a32ce12960b ) && now - self.var_9d3e1a32ce12960b <= 500 )
    {
        return true;
    }
    
    return false;
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0x377d8191, Offset: 0x19f2a
// Size: 0x17
function private function_dd71e90754bceb20( params )
{
    self.var_5799a77f18d0229a = 1;
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0xa4baea0d, Offset: 0x19f49
// Size: 0x23
function private function_1d54cd7f3204eec( params )
{
    self.var_9e094dd56f970a03 = gettime();
    self.var_5799a77f18d0229a = undefined;
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0x96e4a006, Offset: 0x19f74
// Size: 0x17
function private function_cdeebfff9fd3743f( params )
{
    self.isactiverolling = 1;
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0xd627d8fe, Offset: 0x19f93
// Size: 0x23
function private function_1749a2f53f8cd2b7( params )
{
    self.var_c879847af9201fb6 = gettime();
    self.isactiverolling = undefined;
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0xa7f858d8, Offset: 0x19fbe
// Size: 0x2b
function private function_c166f426bdb7d385( params )
{
    self.lastadsstarttime = params.time;
    self clearsoundsubmix( "hit_indicator_hipfire" );
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0xc3165bc7, Offset: 0x19ff1
// Size: 0x17
function private function_92243a25e710e505( params )
{
    self setsoundsubmix( "hit_indicator_hipfire" );
}

// Namespace events
// Params 0
// Checksum 0x199b1dab, Offset: 0x1a010
// Size: 0x159
function monitorreload()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self.lastreloadtime = 0;
    
    while ( true )
    {
        self waittill( #"reload_ammo_added" );
        objweapon = self getcurrentweapon();
        challenges::function_e14422a86e7720d6( self, objweapon );
        self.lastreloadtime = gettime();
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
        {
            if ( isdefined( self.leaderboarddata[ "reloads" ] ) )
            {
                self.leaderboarddata[ "reloads" ] = self.leaderboarddata[ "reloads" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "reloads" ] ) )
            {
                [[ level.leaderboardfunc[ "reloads" ] ]]( self, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
            
            if ( isdefined( self.pers[ "reloads" ] ) )
            {
                self.pers[ "reloads" ] = self.pers[ "reloads" ] + 1;
            }
        }
        
        self.reloadamount = isdefined( self.reloadamount ) ? self.reloadamount + 1 : 0;
    }
}

// Namespace events
// Params 0
// Checksum 0x6f61e49e, Offset: 0x1a171
// Size: 0x49
function function_28959f334b2c020()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"end_firing" );
        wait 1;
        
        if ( isdefined( self.var_15de96d9ab0305b6 ) )
        {
            self.var_15de96d9ab0305b6 = 0;
        }
    }
}

// Namespace events
// Params 0
// Checksum 0xd8b50fb2, Offset: 0x1a1c2
// Size: 0x46
function monitorweaponswitch()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self.lastweaponchangetime = 0;
    
    while ( true )
    {
        self waittill( #"weapon_change" );
        self.lastweaponchangetime = gettime();
    }
}

// Namespace events
// Params 0, eflags: 0xc
// Checksum 0x86fffac4, Offset: 0x1a210
// Size: 0x35
function private function_7c73c53116cd9c5c()
{
    self notify( #"hash_fd98097810042f54" );
    self endon( #"hash_fd98097810042f54" );
    self.var_c3638434ac692af1 = 1;
    wait 0.25;
    self.var_c3638434ac692af1 = undefined;
}

// Namespace events
// Params 2
// Checksum 0xafdfbfa4, Offset: 0x1a24d
// Size: 0x67
function updateweaponchangetime( var_c83b16a307b9c80d, var_cbe6ee21dddcac3c )
{
    if ( var_c83b16a307b9c80d.basename === var_cbe6ee21dddcac3c.basename )
    {
        return;
    }
    
    self.lastweaponchangetime = gettime();
    
    if ( !self.var_c3638434ac692af1 && !class::shouldallowinstantclassswap() )
    {
        self.var_4632cc178c21073f = self.lastweaponchangetime;
    }
}

// Namespace events
// Params 2, eflags: 0x4
// Checksum 0xae01667f, Offset: 0x1a2bc
// Size: 0x297
function private function_306441f8765619e2( prevstance, time )
{
    if ( !isdefined( self.laststancechangetime ) )
    {
        self.laststancechangetime = 0;
    }
    
    switch ( prevstance )
    {
        case #"crouch":
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "timeCrouched" ] ) )
                {
                    self.leaderboarddata[ "timeCrouched" ] = self.leaderboarddata[ "timeCrouched" ] + ( time - self.laststancechangetime ) * 0.001;
                }
                
                if ( isdefined( level.leaderboardfunc[ "timeCrouched" ] ) )
                {
                    [[ level.leaderboardfunc[ "timeCrouched" ] ]]( self, ( time - self.laststancechangetime ) * 0.001 );
                }
                
                assert( isint( ( time - self.laststancechangetime ) * 0.001 ) || isfloat( ( time - self.laststancechangetime ) * 0.001 ), "<dev string:x428>" );
                
                if ( isdefined( self.pers[ "timeCrouched" ] ) )
                {
                    self.pers[ "timeCrouched" ] = self.pers[ "timeCrouched" ] + ( time - self.laststancechangetime ) * 0.001;
                }
            }
            
            break;
        case #"prone":
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "timeProne" ] ) )
                {
                    self.leaderboarddata[ "timeProne" ] = self.leaderboarddata[ "timeProne" ] + ( time - self.laststancechangetime ) * 0.001;
                }
                
                if ( isdefined( level.leaderboardfunc[ "timeProne" ] ) )
                {
                    [[ level.leaderboardfunc[ "timeProne" ] ]]( self, ( time - self.laststancechangetime ) * 0.001 );
                }
                
                assert( isint( ( time - self.laststancechangetime ) * 0.001 ) || isfloat( ( time - self.laststancechangetime ) * 0.001 ), "<dev string:x428>" );
                
                if ( isdefined( self.pers[ "timeProne" ] ) )
                {
                    self.pers[ "timeProne" ] = self.pers[ "timeProne" ] + ( time - self.laststancechangetime ) * 0.001;
                }
            }
            
            break;
    }
}

// Namespace events
// Params 0
// Checksum 0x135b2f9c, Offset: 0x1a55b
// Size: 0x4b
function initstancetracking()
{
    self.var_84f7f2ffadd85173 = [];
    self.var_84f7f2ffadd85173[ #"prone" ] = 0;
    self.var_84f7f2ffadd85173[ #"crouch" ] = 0;
    self.var_84f7f2ffadd85173[ #"stand" ] = 0;
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0xcda6dea3, Offset: 0x1a5ae
// Size: 0x39
function private stancechanged( params )
{
    if ( !params.isalive )
    {
        return;
    }
    
    function_306441f8765619e2( params.prevstance, params.time );
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0xe367f244, Offset: 0x1a5ef
// Size: 0x3d
function private function_cc7a5f0c4d025998( params )
{
    if ( !params.isalive )
    {
        return;
    }
    
    self.var_84f7f2ffadd85173[ params.stance ] = params.time;
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0x4ffd4d91, Offset: 0x1a634
// Size: 0x2e
function private function_685429b0b93e2af( deathdata )
{
    function_306441f8765619e2( getxhash( self getstance() ), deathdata.deathtime ?? gettime() );
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0xe9eef32f, Offset: 0x1a66a
// Size: 0xbb
function private function_4a14466bed488cff( params )
{
    assert( self == level );
    
    if ( self != level )
    {
        return;
    }
    
    now = gettime();
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player function_306441f8765619e2( getxhash( player getstance() ), now );
    }
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0xfb35212a, Offset: 0x1a72d
// Size: 0x18
function private jumpbegin( params )
{
    potg::processevent( "recent_jump" );
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0x562f8c4a, Offset: 0x1a74d
// Size: 0x13
function private function_e7302a4eea4a864( params )
{
    thread threesixtynoscope();
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0x59c2c2df, Offset: 0x1a768
// Size: 0x18
function private mantlebegin( params )
{
    potg::processevent( "recent_mantle" );
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0xf7565a52, Offset: 0x1a788
// Size: 0x1a
function private dtpbegin( params )
{
    thread supinecorkscrew();
    thread function_48b74f0d4fd5f266();
}

// Namespace events
// Params 0, eflags: 0xc
// Checksum 0x286f2b9c, Offset: 0x1a7aa
// Size: 0xa8
function private function_48b74f0d4fd5f266()
{
    self notify( #"hash_fd11db2589d50231" );
    self endon( #"hash_fd11db2589d50231" );
    self endon( #"disconnect" );
    self.var_d9dbc6867528ff82 = 0;
    wait 0.1;
    
    while ( isalive( self ) && function_8e315fc2393f2705() )
    {
        if ( !self.var_d9dbc6867528ff82 )
        {
            attackervelocity = self getvelocity();
            
            if ( vectordot( anglestoforward( self getplayerangles() ), vectornormalize( attackervelocity ) ) < 0.7071 && length2dsquared( attackervelocity ) > 50 )
            {
                self.var_d9dbc6867528ff82 = 1;
            }
        }
        
        waitframe();
    }
    
    self.var_d9dbc6867528ff82 = undefined;
}

// Namespace events
// Params 0
// Checksum 0xd90698f4, Offset: 0x1a85a
// Size: 0x148
function supinecorkscrew()
{
    self notify( #"hash_f491fa64c4594f0b" );
    self endon( #"hash_f491fa64c4594f0b" );
    self endon( #"death_or_disconnect" );
    
    if ( !level.gametypebundle.var_2e615b9703b5b0be )
    {
        return;
    }
    
    if ( !isdefined( level.gametypebundle.var_fbee5b01ca2c83b9 ) )
    {
        return;
    }
    
    attacker = self;
    yawprev = attacker.angles[ 1 ];
    yawcurr = attacker.angles[ 1 ];
    anglescumulative = 0;
    
    while ( attacker isdiving() )
    {
        if ( !attacker.var_58b9cb211fef48bb )
        {
            yawprev = yawcurr;
            yawcurr = attacker.angles[ 1 ];
            angledelta = angleclamp180( yawcurr - yawprev );
            anglescumulative += angledelta;
            
            if ( abs( anglescumulative ) >= level.gametypebundle.var_fbee5b01ca2c83b9 )
            {
                attacker.var_58b9cb211fef48bb = 1;
            }
        }
        
        waitframe();
    }
    
    if ( isdefined( level.gametypebundle.var_1bee45649aa63dd4 ) )
    {
        wait level.gametypebundle.var_1bee45649aa63dd4;
    }
    
    attacker.var_58b9cb211fef48bb = undefined;
}

// Namespace events
// Params 0
// Checksum 0xb3039779, Offset: 0x1a9aa
// Size: 0x159
function threesixtynoscope()
{
    if ( isbot( self ) )
    {
        return;
    }
    
    var_379e09c211afa20d = level.scoreeventglobals.var_d3eec910765cbbc1;
    
    if ( !isdefined( var_379e09c211afa20d ) )
    {
        return;
    }
    
    self notify( #"threesixtynoscope" );
    self endon( #"threesixtynoscope" );
    self endon( #"death_or_disconnect" );
    attacker = self;
    yawprev = attacker.angles[ 1 ];
    yawcurr = yawprev;
    anglescumulative = 0;
    var_f292a3508651b70 = 0;
    var_1ca3a074157ff03b = level.scoreeventglobals.var_c0233dc8750d689c ?? 20;
    
    while ( !attacker isonground() )
    {
        if ( self isskydiving() )
        {
            self waittill( #"skydive_end" );
            yawprev = attacker.angles[ 1 ];
            yawcurr = yawprev;
            anglescumulative = 0;
            var_f292a3508651b70 = 0;
        }
        else
        {
            yawprev = yawcurr;
            yawcurr = attacker.angles[ 1 ];
            anglescumulative += angleclamp180( yawcurr - yawprev );
            var_98b1c2afa8596c75 = abs( anglescumulative );
            
            if ( var_98b1c2afa8596c75 >= var_379e09c211afa20d && var_98b1c2afa8596c75 - var_f292a3508651b70 >= var_1ca3a074157ff03b )
            {
                var_f292a3508651b70 = var_98b1c2afa8596c75;
                attacker.var_688945b063626b53 = gettime();
            }
        }
        
        wait 0.05;
    }
}

// Namespace events
// Params 1
// Checksum 0xa7308f4, Offset: 0x1ab0b
// Size: 0x15
function predatormissileimpact( impactpos )
{
    potg_events::predatormissileimpact( impactpos );
}

// Namespace events
// Params 1
// Checksum 0x2b6fbfe9, Offset: 0x1ab28
// Size: 0x15
function largevehicleexplosion( explosionpos )
{
    potg_events::largevehicleexplosion( explosionpos );
}

// Namespace events
// Params 1
// Checksum 0xb90d4301, Offset: 0x1ab45
// Size: 0x15
function vehiclekilled( damagedata )
{
    potg_events::vehiclekilled( damagedata );
}

// Namespace events
// Params 1
// Checksum 0xf868f584, Offset: 0x1ab62
// Size: 0x15
function missilefired( missile )
{
    thread trackmissile( missile );
}

// Namespace events
// Params 1
// Checksum 0x79a65a9b, Offset: 0x1ab7f
// Size: 0x10b
function trackmissile( missile )
{
    level endon( #"game_ended" );
    missile endon( #"death" );
    missile endon( #"entitydeleted" );
    missile.whizbyplayers = [];
    
    while ( true )
    {
        whizbyplayers = utility::playersnear( missile.origin, 220 );
        
        foreach ( player in whizbyplayers )
        {
            if ( player === missile.owner )
            {
                continue;
            }
            
            missilewhizby( player, missile );
            missile.whizbyplayers[ player.guid ] = 1;
        }
        
        wait 0.1;
    }
}

// Namespace events
// Params 2
// Checksum 0x95953b0f, Offset: 0x1ac92
// Size: 0x1e
function missilewhizby( player, missile )
{
    potg_events::missilewhizby( player );
}

// Namespace events
// Params 2
// Checksum 0x36aefc7e, Offset: 0x1acb8
// Size: 0x4b1
function bombdefused( defuser, defusesite )
{
    waslastalive = 0;
    
    if ( game_utility_mp::getgametypenumlives() >= 1 )
    {
        liveplayers = game_utility_mp::getpotentiallivingplayers();
        
        if ( liveplayers.size == 1 && liveplayers[ 0 ] == defuser )
        {
            waslastalive = 1;
        }
    }
    
    enemiesnearby = 0;
    
    if ( !waslastalive && game_utility::getgametype() != "dd" )
    {
        playersnearby = getplayersinradius( defuser.origin, 600 );
        
        foreach ( player in playersnearby )
        {
            if ( player.team != defuser.team )
            {
                enemiesnearby = 1;
                break;
            }
        }
    }
    
    defusesite = defusesite.objectivekey ?? undefined;
    
    if ( teams::function_f4df3d3d69adab39( level.bombowner.team ) )
    {
        defuser thread points::doscoreevent( #"ninja_defuse" );
    }
    
    if ( player::isreallyalive( level.bombowner ) && level.bombowner.bombplantedtime + 3000 + level.defusetime * 1000 > gettime() )
    {
        if ( game_utility::getgametype() != "dd" )
        {
            enemiesnearby = 1;
        }
    }
    else
    {
        defuser thread points::doscoreevent( #"emp_defuse" );
    }
    
    if ( waslastalive )
    {
        defuser thread points::doscoreevent( #"mode_sd_last_defuse", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, { #extraparam:defusesite } );
    }
    else
    {
        defuser thread points::doscoreevent( #"mode_sd_defuse", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, { #extraparam:defusesite } );
    }
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( defuser ) ) )
    {
        if ( isdefined( defuser.leaderboarddata[ "defuses" ] ) )
        {
            defuser.leaderboarddata[ "defuses" ] = defuser.leaderboarddata[ "defuses" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "defuses" ] ) )
        {
            [[ level.leaderboardfunc[ "defuses" ] ]]( defuser, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
        
        if ( isdefined( defuser.pers[ "defuses" ] ) )
        {
            defuser.pers[ "defuses" ] = defuser.pers[ "defuses" ] + 1;
        }
    }
    
    defuser persistence::statsetchild( "round", "defuses", defuser.pers[ "defuses" ] );
    defuser codcasterclientmatchdata::function_8ecc753b54a5740f( 2, 1 );
    
    if ( isdefined( defuser.pers[ "sneakDefuses" ] ) )
    {
        if ( teams::function_f4df3d3d69adab39( defuser.team ) )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( defuser ) ) )
            {
                if ( isdefined( defuser.leaderboarddata[ "sneakDefuses" ] ) )
                {
                    defuser.leaderboarddata[ "sneakDefuses" ] = defuser.leaderboarddata[ "sneakDefuses" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "sneakDefuses" ] ) )
                {
                    [[ level.leaderboardfunc[ "sneakDefuses" ] ]]( defuser, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
                
                if ( isdefined( defuser.pers[ "sneakDefuses" ] ) )
                {
                    defuser.pers[ "sneakDefuses" ] = defuser.pers[ "sneakDefuses" ] + 1;
                }
            }
        }
    }
    
    defuser stats::setextrascore1( defuser.pers[ "defuses" ] );
    
    if ( isplayer( defuser ) )
    {
        telemetry_data = spawnstruct();
        telemetry_data.player = defuser;
        telemetry_data.eventname = "defuse";
        telemetry_data.position = defuser.origin;
        telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
    }
    
    potg_events::bombdefused( defuser, waslastalive, enemiesnearby );
}

// Namespace events
// Params 2
// Checksum 0x2b3e84f3, Offset: 0x1b171
// Size: 0x38
function revivedplayer( reviver, revivee )
{
    if ( reviver == revivee )
    {
        return;
    }
    
    potg_events::revivedplayer( reviver, revivee );
    
    if ( isbrgamemode() )
    {
        br_analytics::branalytics_revive( reviver, revivee );
    }
}

// Namespace events
// Params 2
// Checksum 0xf08d0675, Offset: 0x1b1b1
// Size: 0xb7, Type: bool
function function_f08ecc43d309a219( player, weapon )
{
    foreach ( weapondata in player.var_1a87a9e7cf39ff69 )
    {
        if ( weapondata.infilowner == player && weapon.basename == weapondata.baseweapon )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace events
// Params 2
// Checksum 0xb429da4d, Offset: 0x1b271
// Size: 0x34
function doorused( player, opening )
{
    potg_events::doorused( player, opening );
    
    if ( opening )
    {
        player.lastdooropentime = gettime();
    }
}

// Namespace events
// Params 0
// Checksum 0x7d375120, Offset: 0x1b2ad
// Size: 0x122
function shothit()
{
    if ( !isdefined( self.pers[ "shotsHit" ] ) )
    {
        self.pers[ "shotsHit" ] = 0;
    }
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "shotsHit" ] ) )
        {
            self.leaderboarddata[ "shotsHit" ] = self.leaderboarddata[ "shotsHit" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "shotsHit" ] ) )
        {
            [[ level.leaderboardfunc[ "shotsHit" ] ]]( self, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
        
        if ( isdefined( self.pers[ "shotsHit" ] ) )
        {
            self.pers[ "shotsHit" ] = self.pers[ "shotsHit" ] + 1;
        }
    }
    
    if ( level.potgenabled && !level.gametypebundle.var_2e615b9703b5b0be )
    {
        potg_events::shothit();
    }
}

// Namespace events
// Params 2
// Checksum 0xb90d435c, Offset: 0x1b3d7
// Size: 0x1f
function shotmissed( totalshots, hitshots )
{
    potg_events::shotmissed( totalshots, hitshots );
}

// Namespace events
// Params 4
// Checksum 0x731f3161, Offset: 0x1b3fe
// Size: 0x44f
function killeventtextpopup( scoreeventref, showassplash, dontshowscoreevent, params )
{
    if ( function_f5062c36d13e920c() )
    {
        return;
    }
    
    if ( !isdefined( self ) )
    {
        script::demoforcesre( "killEventTextPopup called with invalid self" );
        return;
    }
    
    if ( level.var_dd30bf39c0753f31 )
    {
        if ( !self.killstreak_kill && scoreeventref == #"kill" && ( self.suppress_kill || self.var_3f98a27bd6d0f2b3 ) )
        {
            self.suppress_kill = undefined;
            self.var_3f98a27bd6d0f2b3 = undefined;
            return;
        }
    }
    
    if ( self.killeventqueue.size >= 2047 )
    {
        assert( "<dev string:x44e>" );
        return;
    }
    
    showassplash = istrue( showassplash );
    
    if ( !rank::scoreeventhastext( scoreeventref ) && !showassplash )
    {
        return;
    }
    
    if ( !isdefined( self.killeventqueue ) )
    {
        self.killeventqueue = [];
    }
    
    if ( function_816d59a5b87f83f6() )
    {
        foreach ( event in self.killeventqueue )
        {
            if ( event.scoreeventref == scoreeventref )
            {
                return;
            }
        }
    }
    
    if ( level.var_dd30bf39c0753f31 )
    {
        if ( level.var_931ca47cc298f7af == #"display_xp" && level.var_23730bd6be76cb84 )
        {
            if ( params.var_e7696e45bbb0a313 )
            {
                var_fe72cce2f4375e3c = rank::getscoreinfovalue( #"kill" );
                params.xpgiven += var_fe72cce2f4375e3c;
                self.suppress_kill = 1;
            }
            
            if ( self.killstreak_kill && scoreeventref == #"killstreak_kill" )
            {
                self.killstreak_kill = undefined;
            }
        }
    }
    
    splashdata = { #xpgiven:params.xpgiven, #pointsgiven:params.pointsgiven, #extraparam:params.extraparam, #dontshowscoreevent:istrue( dontshowscoreevent ), #processedscoreevent:0, #processedsplash:0, #alwaysshowsplash:rank::scoreeventalwaysshowassplash( scoreeventref ), #priority:rank::getscoreeventpriority( scoreeventref ), #showassplash:showassplash, #scoreeventref:scoreeventref };
    
    if ( combat_feed_utility::function_47a6f06f6300fa18() )
    {
        victimguid = undefined;
        var_90ee7b7e08e4c847 = rank::getscoreinfocategory( scoreeventref, #"hash_aae7781dce5b709f" );
        killcount = 0;
        
        if ( isdefined( params.victim ) )
        {
            victimguid = params.victim player::getuniqueid();
        }
        else if ( !var_90ee7b7e08e4c847 )
        {
            killcount = self.killcountthislife ?? 0;
        }
        
        splashdata.killcount = params.killcount ?? killcount;
        splashdata.victimguid = victimguid;
        splashdata.var_90ee7b7e08e4c847 = var_90ee7b7e08e4c847;
    }
    
    if ( level.var_23730bd6be76cb84 )
    {
        splashdata.isobjectivekill = params.isobjectivekill;
    }
    
    var_2837671cb4a41d92 = !splashdata.dontshowscoreevent;
    
    if ( var_2837671cb4a41d92 && splashdata.alwaysshowsplash && level.var_296253a91eeebfc6 )
    {
        var_efce242113a326c5 = rank::function_c93ef027a4ddaca8( scoreeventref );
        
        if ( var_efce242113a326c5 && ( !level.var_bbf4f9dff7b0244e[ scoreeventref ] && params.calledfrom == #"doScoreEvent" || !rank::getscoreinfocategory( scoreeventref, #"hash_e98734bda1c5c091" ) ) )
        {
            splashdata.dontshowscoreevent = 1;
        }
    }
    
    self.killeventqueue[ self.killeventqueue.size ] = splashdata;
    
    if ( combat_feed_utility::function_47a6f06f6300fa18() )
    {
        thread function_d25dde7d87de96d0();
        return;
    }
    
    thread function_68c7fb18bec9093c();
}

// Namespace events
// Params 0
// Checksum 0x5dd540e6, Offset: 0x1b855
// Size: 0x1e6
function function_68c7fb18bec9093c()
{
    self notify( #"hash_4d6f7dd8890538dc" );
    self endon( #"hash_4d6f7dd8890538dc" );
    waitframe();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    profilestart();
    
    if ( isdefined( self.killeventqueue ) )
    {
        if ( self.killeventqueue.size > 35 )
        {
            logstring( " === POSSIBLE processKillEventQueue HITCH DETECTED WITH " + self.killeventqueue.size + " EVENTS ===\n" );
            
            for ( i = 0; i < self.killeventqueue.size ; i++ )
            {
                if ( isdefined( self.killeventqueue[ i ].scoreeventref ) )
                {
                    logstring( "[" + i + "] " + getxhashhexname( self.killeventqueue[ i ].scoreeventref ) + "\n" );
                }
            }
        }
        
        if ( !isdefined( self.splashpriorityqueue ) )
        {
            self.splashpriorityqueue = [];
        }
        
        if ( !isdefined( self.var_9361e01b99a0b2ef ) )
        {
            self.var_9361e01b99a0b2ef = [];
        }
        
        if ( self.splashpriorityqueue.size > 200 )
        {
            function_cdee04e9a4533661();
        }
        
        if ( self.splashpriorityqueue.size < 2047 )
        {
            foreach ( event in self.killeventqueue )
            {
                function_e97899d59328e811( event );
                
                if ( self.splashpriorityqueue.size >= 2047 )
                {
                    assert( "<dev string:x47e>" );
                    break;
                }
            }
        }
        
        self.splashpriorityqueue = arraysort( self.splashpriorityqueue, undefined, &function_32c45c1082c0b2d );
    }
    
    self.killeventqueue = undefined;
    thread processsplashpriorityqueue();
    profilestop();
}

// Namespace events
// Params 0
// Checksum 0x5e782849, Offset: 0x1ba43
// Size: 0x95f
function function_d25dde7d87de96d0()
{
    self notify( #"hash_243d9530950569b7" );
    self endon( #"hash_243d9530950569b7" );
    waitframe();
    waittillframeend();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    profilestart();
    
    if ( isdefined( self.killeventqueue ) )
    {
        if ( !isdefined( self.splashpriorityqueue ) )
        {
            self.splashpriorityqueue = [];
        }
        
        if ( !isdefined( self.var_9361e01b99a0b2ef ) )
        {
            self.var_9361e01b99a0b2ef = [];
        }
        
        if ( !isdefined( self.var_5b99b7e5b917c696 ) )
        {
            self.var_5b99b7e5b917c696 = [];
        }
        
        if ( !isdefined( self.var_d884db3d152a635 ) )
        {
            self.var_d884db3d152a635 = [];
        }
        
        if ( !isdefined( self.var_24493073beb0f325 ) )
        {
            self.var_24493073beb0f325 = [];
        }
        
        if ( self.splashpriorityqueue.size > 200 )
        {
            function_cdee04e9a4533661();
        }
        
        foreach ( event in self.killeventqueue )
        {
            if ( event.var_90ee7b7e08e4c847 )
            {
                if ( self.var_24493073beb0f325.size < 2047 )
                {
                    self.var_24493073beb0f325[ self.var_24493073beb0f325.size ] = event;
                }
                
                continue;
            }
            
            if ( !isdefined( event.victimguid ) )
            {
                if ( !isdefined( self.var_d884db3d152a635[ event.killcount ] ) )
                {
                    self.var_d884db3d152a635[ event.killcount ] = spawnstruct();
                    self.var_d884db3d152a635[ event.killcount ].killcount = event.killcount;
                    self.var_d884db3d152a635[ event.killcount ].totalpoints = 0;
                    self.var_d884db3d152a635[ event.killcount ].events = [];
                }
                
                if ( self.var_d884db3d152a635[ event.killcount ].events.size < 2047 )
                {
                    self.var_d884db3d152a635[ event.killcount ].events[ self.var_d884db3d152a635[ event.killcount ].events.size ] = event;
                }
                
                points = function_2cae99ed8e8671d0( event );
                self.var_d884db3d152a635[ event.killcount ].totalpoints += points;
                continue;
            }
            
            if ( !isdefined( self.var_5b99b7e5b917c696[ event.victimguid ] ) )
            {
                self.var_5b99b7e5b917c696[ event.victimguid ] = spawnstruct();
                self.var_5b99b7e5b917c696[ event.victimguid ].killcount = 0;
                self.var_5b99b7e5b917c696[ event.victimguid ].totalpoints = 0;
                self.var_5b99b7e5b917c696[ event.victimguid ].events = [];
            }
            
            if ( self.var_5b99b7e5b917c696[ event.victimguid ].events.size < 2047 )
            {
                self.var_5b99b7e5b917c696[ event.victimguid ].events[ self.var_5b99b7e5b917c696[ event.victimguid ].events.size ] = event;
            }
            
            if ( event.killcount > 0 )
            {
                self.var_5b99b7e5b917c696[ event.victimguid ].killcount = event.killcount;
            }
            
            points = function_2cae99ed8e8671d0( event );
            self.var_5b99b7e5b917c696[ event.victimguid ].totalpoints += points;
        }
        
        foreach ( victimgroup in self.var_5b99b7e5b917c696 )
        {
            killcountgroup = self.var_d884db3d152a635[ victimgroup.killcount ];
            
            if ( isdefined( killcountgroup ) )
            {
                victimgroup.totalpoints += killcountgroup.totalpoints;
                
                if ( victimgroup.events.size < 2047 )
                {
                    foreach ( event in killcountgroup.events )
                    {
                        victimgroup.events[ victimgroup.events.size ] = event;
                        
                        if ( victimgroup.events.size >= 2047 )
                        {
                            assert( "<dev string:x4b3>" );
                            break;
                        }
                    }
                }
                
                self.var_d884db3d152a635[ victimgroup.killcount ] = undefined;
            }
            
            if ( victimgroup.killcount > 0 )
            {
                var_15d53c5789666401 = self.var_d884db3d152a635[ victimgroup.killcount - 1 ];
                
                if ( isdefined( var_15d53c5789666401 ) )
                {
                    victimgroup.totalpoints += var_15d53c5789666401.totalpoints;
                    
                    if ( victimgroup.events.size < 2047 )
                    {
                        foreach ( event in var_15d53c5789666401.events )
                        {
                            victimgroup.events[ victimgroup.events.size ] = event;
                            
                            if ( victimgroup.events.size >= 2047 )
                            {
                                assert( "<dev string:x4b3>" );
                                break;
                            }
                        }
                    }
                    
                    self.var_d884db3d152a635[ victimgroup.killcount - 1 ] = undefined;
                }
            }
        }
        
        foreach ( group in self.var_d884db3d152a635 )
        {
            if ( self.var_24493073beb0f325.size < 2047 )
            {
                foreach ( event in group.events )
                {
                    event.killcount = 0;
                    self.var_24493073beb0f325[ self.var_24493073beb0f325.size ] = event;
                    
                    if ( self.var_24493073beb0f325.size >= 2047 )
                    {
                        assert( "<dev string:x4e7>" );
                        break;
                    }
                }
            }
        }
        
        foreach ( group in self.var_5b99b7e5b917c696 )
        {
            function_cf4677525531aa0f( group );
        }
        
        self.var_24493073beb0f325 = arraysort( self.var_24493073beb0f325, undefined, &function_32c45c1082c0b2d );
        
        foreach ( event in self.var_24493073beb0f325 )
        {
            function_e97899d59328e811( event );
        }
    }
    
    self.killeventqueue = undefined;
    self.var_5b99b7e5b917c696 = undefined;
    self.var_d884db3d152a635 = undefined;
    self.var_24493073beb0f325 = undefined;
    thread processsplashpriorityqueue();
    profilestop();
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0xe04b2760, Offset: 0x1c3aa
// Size: 0x77
function private function_2cae99ed8e8671d0( event )
{
    if ( level.var_931ca47cc298f7af == #"display_xp" )
    {
        return ( event.xpgiven ?? rank::getscoreinfocategory( event.scoreeventref, #"xp" ) );
    }
    
    return event.pointsgiven ?? rank::getscoreinfocategory( event.scoreeventref, #"value" );
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0xa22bc518, Offset: 0x1c429
// Size: 0x19c
function private function_cf4677525531aa0f( group )
{
    group.events = arraysort( group.events, undefined, &function_32c45c1082c0b2d );
    totalevents = group.events.size;
    killcount = group.killcount;
    totalpoints = group.totalpoints;
    eventcounter = 0;
    var_39c3a480231d4e78 = min( group.events.size, combat_feed_utility::function_3f12a36a6f8ea8d6() ) - 1;
    
    if ( killcount > 255 )
    {
        killcount = 255;
    }
    
    if ( totalevents > 255 )
    {
        totalevents = 255;
    }
    
    if ( totalpoints > 65535 )
    {
        totalpoints = 65535;
    }
    
    foreach ( event in group.events )
    {
        if ( eventcounter >= combat_feed_utility::function_3f12a36a6f8ea8d6() )
        {
            event.dontshowscoreevent = 1;
        }
        
        event.killcount = killcount;
        event.totalevents = totalevents;
        event.totalpoints = totalpoints;
        event.nodelay = eventcounter < var_39c3a480231d4e78 ? 1 : 0;
        eventcounter++;
        function_e97899d59328e811( event );
    }
}

// Namespace events
// Params 0, eflags: 0x4
// Checksum 0xfc6323a, Offset: 0x1c5cd
// Size: 0x108
function private function_cdee04e9a4533661()
{
    if ( !isdefined( self.var_96e7a9aac8db3afc ) )
    {
        self.var_96e7a9aac8db3afc = 0;
    }
    
    if ( gettime() - self.var_96e7a9aac8db3afc > 2000 || self.splashpriorityqueue.size >= 2047 )
    {
        self.var_96e7a9aac8db3afc = gettime();
        splashpriorityqueue = [];
        
        foreach ( event in self.splashpriorityqueue )
        {
            if ( event.processedsplash && ( event.processedscoreevent || event.dontshowscoreevent ) )
            {
                continue;
            }
            
            splashpriorityqueue[ splashpriorityqueue.size ] = event;
        }
        
        self.splashpriorityqueue = splashpriorityqueue;
    }
}

// Namespace events
// Params 2, eflags: 0x4
// Checksum 0xbc2db9b8, Offset: 0x1c6dd
// Size: 0x2c, Type: bool
function private function_32c45c1082c0b2d( a, b )
{
    return a.priority > b.priority;
}

// Namespace events
// Params 0
// Checksum 0x3274fff7, Offset: 0x1c712
// Size: 0x42a
function processsplashpriorityqueue()
{
    self notify( #"hash_feef83b1c5351a78" );
    self endon( #"hash_feef83b1c5351a78" );
    self endon( #"disconnect" );
    
    if ( !isdefined( self.splashpriorityqueue ) )
    {
        return;
    }
    
    splashallowed = !level.gametypebundle.removekilleventsplash;
    
    if ( combat_feed_utility::function_47a6f06f6300fa18() )
    {
        splashallowed = 0;
    }
    
    /#
        foreach ( event in self.splashpriorityqueue )
        {
            if ( splashallowed && event.showassplash && event.alwaysshowsplash )
            {
                println( "<dev string:x522>" + getxhashsourcename( event.scoreeventref ) );
            }
            
            println( "<dev string:x52c>" + getxhashsourcename( event.scoreeventref ) );
        }
    #/
    
    foreach ( event in self.splashpriorityqueue )
    {
        if ( event.processedsplash )
        {
            continue;
        }
        
        if ( splashallowed && event.showassplash && event.alwaysshowsplash )
        {
            if ( utility::issharedfuncdefined( #"splash", #"hash_1cdff8916d495428" ) )
            {
                self thread [[ utility::getsharedfunc( #"splash", #"hash_1cdff8916d495428" ) ]]( event.scoreeventref, [ self ] );
            }
            else
            {
                thread hud_message::showsplash( event.scoreeventref, undefined, undefined, undefined, level.var_af0045e470655ee );
            }
        }
        
        event.processedsplash = 1;
    }
    
    var_d8f972bdc4f3a553 = istrue( level.var_d8f972bdc4f3a553 );
    var_93a12c17d6dd1948 = level.var_ad9c707dd7d69f42 ?? getdvarfloat( @"scr_splash_kill_buffer", 0.25 );
    var_506a1f4876e21649 = undefined;
    
    if ( var_d8f972bdc4f3a553 )
    {
        var_506a1f4876e21649 = var_93a12c17d6dd1948 - ( gettime() - ( self.var_433677b2d959ba33 ?? 0 ) ) * 0.001;
        
        if ( var_506a1f4876e21649 <= 0 )
        {
            var_506a1f4876e21649 = undefined;
        }
    }
    
    var_3b544dbd3b7c1dee = 0;
    
    foreach ( evententry in self.splashpriorityqueue )
    {
        if ( evententry.processedscoreevent || evententry.dontshowscoreevent )
        {
            var_3b544dbd3b7c1dee++;
            continue;
        }
        
        if ( isdefined( var_506a1f4876e21649 ) )
        {
            wait var_506a1f4876e21649;
            var_506a1f4876e21649 = undefined;
            
            if ( !isdefined( self ) || !isdefined( self.splashpriorityqueue ) )
            {
                return;
            }
        }
        
        evententry.processedscoreevent = 1;
        var_3b544dbd3b7c1dee++;
        self.var_433677b2d959ba33 = gettime();
        thread rank::function_278dab9f1c228ea8( evententry.scoreeventref, evententry.extraparam, evententry.pointsgiven, evententry.xpgiven, evententry );
        
        if ( combat_feed_utility::function_47a6f06f6300fa18() && evententry.nodelay )
        {
            continue;
        }
        
        if ( self.splashpriorityqueue.size - var_3b544dbd3b7c1dee > 200 )
        {
            wait var_93a12c17d6dd1948 * 0.5;
        }
        else
        {
            wait var_93a12c17d6dd1948;
        }
        
        if ( !isdefined( self ) || !isdefined( self.splashpriorityqueue ) )
        {
            return;
        }
    }
    
    if ( isdefined( self ) )
    {
        self.splashpriorityqueue = undefined;
        self.var_9361e01b99a0b2ef = undefined;
    }
}

// Namespace events
// Params 1
// Checksum 0x9f6f17b0, Offset: 0x1cb44
// Size: 0x68
function function_e97899d59328e811( splashdata )
{
    if ( function_816d59a5b87f83f6() )
    {
        if ( arraycontains( self.var_9361e01b99a0b2ef, splashdata.scoreeventref ) )
        {
            return;
        }
        
        self.var_9361e01b99a0b2ef[ self.var_9361e01b99a0b2ef.size ] = splashdata.scoreeventref;
    }
    
    self.splashpriorityqueue[ self.splashpriorityqueue.size ] = splashdata;
}

// Namespace events
// Params 0
// Checksum 0x3e3fb7c2, Offset: 0x1cbb4
// Size: 0x12, Type: bool
function function_816d59a5b87f83f6()
{
    if ( level.var_af0045e470655ee )
    {
        return false;
    }
    
    return true;
}

// Namespace events
// Params 0
// Checksum 0x67021dde, Offset: 0x1cbcf
// Size: 0xc7
function getnemesis()
{
    nemesis = [];
    
    if ( !game_utility_mp::lpcfeaturegated() && isdefined( self.killedby ) )
    {
        highestkillcount = 0;
        
        foreach ( guid, killcount in self.killedby )
        {
            if ( killcount > highestkillcount )
            {
                nemesis = [ guid ];
                highestkillcount = killcount;
                continue;
            }
            
            if ( killcount == highestkillcount )
            {
                nemesis[ nemesis.size ] = guid;
            }
        }
    }
    
    return nemesis;
}

// Namespace events
// Params 2
// Checksum 0xc0b7df8d, Offset: 0x1cc9f
// Size: 0x33, Type: bool
function function_a486f361db213284( objweapon, deathdata )
{
    if ( weapon::isthrowingstar( objweapon ) && deathdata.var_49082f50a1e5e854 )
    {
        return true;
    }
    
    return false;
}

// Namespace events
// Params 1
// Checksum 0x26a188d5, Offset: 0x1ccdb
// Size: 0xac
function checklethalequipmentachievement( objweapon )
{
    assert( isdefined( level.lethal_equipmentmaskoffsets ), "<dev string:x535>" );
    
    if ( !level.challengesallowed )
    {
        return;
    }
    
    equipref = equipment_mp::getequipmentreffromweapon( objweapon );
    
    if ( !( isdefined( equipref ) && isdefined( level.lethal_equipmentmaskoffsets[ equipref ] ) ) )
    {
        return;
    }
    
    if ( self.pers[ "lethalEquipmentKillMask" ] & level.lethal_equipmentmaskoffsets[ equipref ] )
    {
        return;
    }
    
    self.pers[ "lethalEquipmentKillMask" ] = self.pers[ "lethalEquipmentKillMask" ] | level.lethal_equipmentmaskoffsets[ equipref ];
}

// Namespace events
// Params 0
// Checksum 0xb4ba30d9, Offset: 0x1cd8f
// Size: 0x91
function incrementobjectiveachievementkill()
{
    if ( !level.challengesallowed )
    {
        return;
    }
    
    if ( self.objectiveachievementkillcount == -1 )
    {
        return;
    }
    
    self.objectiveachievementkillcount++;
    var_6a04f09027d40f85 = undefined;
    
    switch ( level.mapname )
    {
        case #"hash_9de262a7132ec180":
        case #"hash_dd0468a72c625fe3":
            var_6a04f09027d40f85 = 50;
            break;
        default:
            var_6a04f09027d40f85 = 30;
            break;
    }
    
    if ( self.objectiveachievementkillcount >= var_6a04f09027d40f85 )
    {
        self.objectiveachievementkillcount = -1;
    }
}

// Namespace events
// Params 1
// Checksum 0xfe4807a5, Offset: 0x1ce28
// Size: 0xd1
function checkfinalkillachievements( victim )
{
    self endon( #"disconnect" );
    var_aa817c15405469fc = 0;
    var_784905eab21db5b3 = 0;
    
    if ( !level.challengesallowed || !isdefined( victim ) )
    {
        self.recondroneteammate = undefined;
        return;
    }
    
    if ( isplayer( victim ) && isdefined( self.recondroneteammate ) )
    {
        if ( self.modifiers[ "recon_drone_explosive" ] )
        {
            var_aa817c15405469fc = 1;
        }
    }
    
    if ( isbrgamemode() )
    {
        if ( self.modifiers[ "execution" ] )
        {
            var_784905eab21db5b3 = 1;
        }
    }
    
    level utility::waittill_any_timeout( 1, "game_ended" );
    
    if ( level.gameended )
    {
        if ( var_784905eab21db5b3 )
        {
            br_challenges::challengeevaluator( "br_mastery_roundKillExecute", undefined );
        }
    }
    
    self.recondroneteammate = undefined;
}

// Namespace events
// Params 0
// Checksum 0x239f6e1d, Offset: 0x1cf01
// Size: 0x23, Type: bool
function function_f5062c36d13e920c()
{
    /#
        if ( getdvarint( @"hash_6735e9fcb3e821b9", 0 ) )
        {
            return true;
        }
    #/
    
    return istrue( level.var_f5062c36d13e920c );
}

// Namespace events
// Params 0
// Checksum 0xadfc9d7, Offset: 0x1cf2d
// Size: 0x18
function function_b8b24a291af69f1d()
{
    level callback::add( #"on_ai_killed", &on_ai_killed );
}

// Namespace events
// Params 1
// Checksum 0x684540d, Offset: 0x1cf4d
// Size: 0x274
function on_ai_killed( sparams )
{
    if ( level.score_events_disabled )
    {
        return;
    }
    
    if ( self.death_source == "despawn" )
    {
        return;
    }
    
    if ( !isdefined( sparams.eattacker ) )
    {
        return;
    }
    
    if ( isplayer( sparams.eattacker.owner ) )
    {
        sparams.eattacker = sparams.eattacker.owner;
    }
    else if ( isdefined( sparams.eattacker.vehicletype ) )
    {
        sparams.eattacker = sparams.eattacker getvehicleowner();
    }
    
    if ( !isplayer( sparams.eattacker ) && !isplayer( sparams.eattacker.var_bd22ba6c600a23a3 ) )
    {
        return;
    }
    
    victim = self;
    typestring = "";
    
    if ( !isdefined( self.kiastring ) )
    {
        return;
    }
    
    kiaevent = self.kiastring;
    
    if ( !isxhash( kiaevent ) )
    {
        assert( 0, kiaevent );
        kiaevent = getxhash( kiaevent );
    }
    
    if ( isdefined( level.var_2365b76f19ea37ea ) )
    {
        [[ level.var_2365b76f19ea37ea ]]( victim, sparams.eattacker, sparams.einflictor, sparams.smeansofdeath, sparams.sweapon, sparams.shitloc, typestring, kiaevent );
        return;
    }
    
    if ( isplayer( sparams.eattacker.var_bd22ba6c600a23a3 ) )
    {
        sparams.eattacker = sparams.eattacker.var_bd22ba6c600a23a3;
        sparams.sweapon = undefined;
    }
    
    points = rank::getscoreinfovalue( kiaevent );
    xp = rank::getscoreinfoxp( kiaevent );
    sparams.eattacker killeventtextpopup( kiaevent, 0, 0 );
    
    if ( points > 0 )
    {
        sparams.eattacker gamescore::giveplayerscore( kiaevent, points, self );
        sparams.eattacker points::displayscoreeventpoints( points, kiaevent );
    }
    
    if ( xp > 0 )
    {
        sparams.eattacker rank::giverankxp( kiaevent, xp, sparams.sweapon, 1, 0 );
    }
}

// Namespace events
// Params 0
// Checksum 0x982dbb28, Offset: 0x1d1c9
// Size: 0x3d
function watchformorebulletkillsinaframeae()
{
    self notify( #"hash_35663b09f9c1a9b6" );
    self endon( #"hash_35663b09f9c1a9b6" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    waittillframeend();
    self.var_a680cce7c744e61d = 0;
}

// Namespace events
// Params 1
// Checksum 0xc54ac623, Offset: 0x1d20e
// Size: 0x96
function collateralae( numkills )
{
    if ( numkills == 2 )
    {
        self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"one_shot_two_kills" ) );
    }
    
    if ( numkills == 3 )
    {
        self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"one_shot_three_kills" ) );
    }
}

// Namespace events
// Params 3
// Checksum 0xbeb8e6ce, Offset: 0x1d2ac
// Size: 0xf3
function function_3799ac52cb0c45dd( attacker, einflictor, objweapon )
{
    streakinfo = einflictor.streakinfo;
    
    if ( !isdefined( streakinfo ) )
    {
        streakinfo = einflictor.var_ec0bb630fbaa253a[ objweapon.basename ] ?? einflictor.owner.var_ec0bb630fbaa253a[ objweapon.basename ];
    }
    
    streakname = streakinfo.streakname;
    assert( isdefined( streakname ), "<dev string:x5a1>" );
    
    if ( !isdefined( attacker.var_e73f627a785541a2[ streakname ] ) )
    {
        return;
    }
    
    attacker.var_e73f627a785541a2[ streakname ] += 1;
    var_8360090b02f0e28f = attacker.var_e73f627a785541a2[ streakname ];
    function_c04f53a6cae7d9a3( attacker, streakname, var_8360090b02f0e28f );
}

// Namespace events
// Params 3
// Checksum 0x25773109, Offset: 0x1d3a7
// Size: 0x8e
function function_c04f53a6cae7d9a3( attacker, streakname, var_8360090b02f0e28f )
{
    bundle = level.streakglobals.streakbundles[ streakname ];
    assert( isdefined( bundle ), "<dev string:x5de>" );
    elimthreshold = bundle.var_118a92b310f12ef5;
    
    if ( var_8360090b02f0e28f === elimthreshold )
    {
        attacker thread points::doscoreevent( bundle.var_d46c641392a80648 );
        attacker.var_e73f627a785541a2[ streakname ] = undefined;
    }
}

// Namespace events
// Params 1
// Checksum 0x7bfbead5, Offset: 0x1d43d
// Size: 0x3b
function function_1df78f8cb7d682d0( objweapon )
{
    equipmenttype = weapon::getequipmenttype( objweapon );
    
    if ( equipmenttype == "lethal" )
    {
        thread points::doscoreevent( #"combination_elimination" );
    }
}

// Namespace events
// Params 0, eflags: 0xc
// Checksum 0xfe2f8c68, Offset: 0x1d480
// Size: 0x29
function private function_42688cf4dbc8155()
{
    self notify( #"hash_c933f058bbe7b807" );
    self endon( #"hash_c933f058bbe7b807" );
    wait 30;
    self notify( #"coast_cleared_timeout" );
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0xe2b2b54d, Offset: 0x1d4b1
// Size: 0x88
function private function_22a20dd1313ccada( objectivekey )
{
    self endon( #"coast_cleared_timeout" );
    childthread function_42688cf4dbc8155();
    
    while ( true )
    {
        self waittill( #"player_zone_captured", var_a781c88785ce2038 );
        
        if ( objectivekey == var_a781c88785ce2038 )
        {
            thread points::doscoreevent( #"cleared_cap" );
            challenges::function_5ad31191afd12405();
            
            if ( isdefined( self.var_be2e46675f0841c8 ) && self.var_be2e46675f0841c8.size == 0 )
            {
                self.var_be2e46675f0841c8 = undefined;
            }
            
            break;
        }
    }
}

// Namespace events
// Params 1
// Checksum 0xa90e9117, Offset: 0x1d541
// Size: 0x78
function function_f3b6ddfecdb144fa( objectivekey )
{
    self notify( #"hash_4c4f9b258845898f" );
    self endon( #"hash_4c4f9b258845898f" );
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( self.var_be2e46675f0841c8[ objectivekey ] ) )
    {
        self.var_be2e46675f0841c8[ objectivekey ] = 1;
        wait 2;
    }
    else
    {
        childthread function_22a20dd1313ccada( objectivekey );
    }
    
    if ( isdefined( self.var_be2e46675f0841c8 ) )
    {
        self.var_be2e46675f0841c8[ objectivekey ] = undefined;
    }
}

// Namespace events
// Params 0
// Checksum 0xe003bfb5, Offset: 0x1d5c1
// Size: 0x13
function function_b49819835545fb9()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    thread challenges::function_b322b07715ac8992();
}

// Namespace events
// Params 0
// Checksum 0x1a0fbe07, Offset: 0x1d5dc
// Size: 0x1d
function function_d4fd7d540188e407()
{
    thread points::doscoreevent( #"event_5_kill_obj" );
    self.var_3fdddb8aea428110 = 1;
}

// Namespace events
// Params 0
// Checksum 0x62fba0cf, Offset: 0x1d601
// Size: 0x1d
function function_1aa2f7550e20dc20()
{
    thread points::doscoreevent( #"mode_sd_plant_save" );
    self.var_dd375d6d77538641 = 1;
}

// Namespace events
// Params 0
// Checksum 0x60b52725, Offset: 0x1d626
// Size: 0x1d
function function_7993ea01a4c8736b()
{
    thread points::doscoreevent( #"mode_sd_defuse_save" );
    self.var_ba06685f1daa2b60 = 1;
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0xff045e1a, Offset: 0x1d64b
// Size: 0xdb, Type: bool
function private function_a1bc2d99430319eb( timesec )
{
    if ( !isdefined( self.attackerdata ) )
    {
        return false;
    }
    
    /#
        timesec = getdvarfloat( @"hash_a6b498489acef4b0", timesec );
    #/
    
    timems = timesec * 1000;
    
    foreach ( attackerdata in self.attackerdata )
    {
        if ( attackerdata.attackerent != self && gettime() - attackerdata.lasttimedamaged < timems )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace events
// Params 1
// Checksum 0x3546db39, Offset: 0x1d72f
// Size: 0x32
function function_20a5f572df6afd43( eventinfo )
{
    thread points::doscoreevent( #"obj_def_kill", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, eventinfo );
    self.var_318dd8924d672e20 = 1;
}

// Namespace events
// Params 0
// Checksum 0x56bc71a3, Offset: 0x1d769
// Size: 0x1d
function function_58da673c1c3fc9f2()
{
    thread points::doscoreevent( #"mode_x_assault" );
    self.var_a24f27229c8dd8bb = 1;
}

// Namespace events
// Params 0
// Checksum 0x111f7a0, Offset: 0x1d78e
// Size: 0x46
function function_a7d373228760063b()
{
    if ( isdefined( level.gametypebundle.var_2d5e32f4f4c5207b ) )
    {
        thread points::doscoreevent( level.gametypebundle.var_2d5e32f4f4c5207b );
        return;
    }
    
    thread points::doscoreevent( #"obj_prog_defend" );
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0xd734ed4d, Offset: 0x1d7dc
// Size: 0xea
function private function_cbf5aa1041be464c( weaponrootname )
{
    if ( !isdefined( self.var_2b8afa91907fac59[ weaponrootname ] ) )
    {
        self.var_2b8afa91907fac59[ weaponrootname ] = 0;
    }
    
    self.var_2b8afa91907fac59[ weaponrootname ]++;
    
    if ( self.var_2b8afa91907fac59[ weaponrootname ] == 30 )
    {
        if ( !self hasplayerdata() )
        {
            return;
        }
        
        var_9c03642f9c645960 = self getplayerdata( level.var_6f9b00680ed002d8, level.scoreeventglobals.var_3afa8115118f2644, weaponrootname );
        
        if ( var_9c03642f9c645960 )
        {
            return;
        }
        
        self setplayerdata( level.var_6f9b00680ed002d8, level.scoreeventglobals.var_3afa8115118f2644, weaponrootname, 1 );
        self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"hash_3d67ae221a1bcbc0" ) );
    }
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0xb049d81c, Offset: 0x1d8ce
// Size: 0x67, Type: bool
function private function_60dbf6243fbc9057( inflictor )
{
    if ( inflictor.isequipment && inflictor.equipmentref )
    {
        switch ( inflictor.equipmentref )
        {
            case #"hash_4320d77f90725183":
            case #"hash_4b6ab8d07b349016":
                return true;
            default:
                break;
        }
    }
    
    return false;
}

// Namespace events
// Params 2, eflags: 0x4
// Checksum 0x3952e3be, Offset: 0x1d93e
// Size: 0xfb, Type: bool
function private function_e50cf9a405270aae( inflictor, meansofdeath )
{
    if ( !isdefined( inflictor ) )
    {
        return false;
    }
    
    if ( !isexplosivedamagemod( meansofdeath ) )
    {
        return false;
    }
    
    if ( isdefined( inflictor vehicle::get_ref() ) )
    {
        children = inflictor getlinkedchildren();
        
        foreach ( child in children )
        {
            if ( function_60dbf6243fbc9057( child ) )
            {
                return true;
            }
        }
    }
    else if ( function_60dbf6243fbc9057( inflictor ) && isent( inflictor ) )
    {
        parent = inflictor getlinkedparent();
        
        if ( isdefined( parent ) && isdefined( parent vehicle::get_ref() ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace events
// Params 0, eflags: 0x4
// Checksum 0x881e5d58, Offset: 0x1da42
// Size: 0x1f, Type: bool
function private function_f1fe3d6ed7236d89()
{
    weaponobj = self getcurrentprimaryweapon();
    return weaponclass( weaponobj ) == "sniper";
}

// Namespace events
// Params 2, eflags: 0x4
// Checksum 0xa129c844, Offset: 0x1da6a
// Size: 0xed
function private function_392bd8e4ff44f2c6( attacker, victim )
{
    if ( !isdefined( attacker.var_d84690daf210c17d ) || !isdefined( attacker.var_543ebeda38aa9b7f ) || !isdefined( attacker.var_484517e462eeec53 ) )
    {
        return 0;
    }
    
    if ( isdefined( victim.perks[ "specialty_ghost" ] ) || isdefined( victim.perks[ "specialty_br_ghost" ] ) )
    {
        return 0;
    }
    
    var_88c70e278cbab1f7 = distance2dsquared( attacker.var_484517e462eeec53, victim.origin ) <= attacker.var_543ebeda38aa9b7f * attacker.var_543ebeda38aa9b7f;
    
    if ( !var_88c70e278cbab1f7 )
    {
        return 0;
    }
    
    var_254ccd47fbe7a8ac = attacker.var_d84690daf210c17d > victim.deathtime;
    victim.pinged_by_portable_radar = 1;
    return var_254ccd47fbe7a8ac;
}

// Namespace events
// Params 5, eflags: 0x4
// Checksum 0x84ddf0bd, Offset: 0x1db60
// Size: 0x2d3
function private function_792823e29eedf15d( killid, objweapon, meansofdeath, inflictor, victim )
{
    iskillstreak = isdefined( objweapon ) && weapon::iskillstreakweapon( objweapon.basename );
    
    if ( !iskillstreak )
    {
        return;
    }
    
    var_e2e82b6431a6ecd0 = killstreaks::function_b28df08dec350c61( inflictor, objweapon );
    
    if ( !isdefined( var_e2e82b6431a6ecd0 ) )
    {
        return;
    }
    
    if ( isdefined( var_e2e82b6431a6ecd0.kills ) )
    {
        var_e2e82b6431a6ecd0.kills++;
    }
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "killstreakKills" ] ) )
        {
            self.leaderboarddata[ "killstreakKills" ] = self.leaderboarddata[ "killstreakKills" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "killstreakKills" ] ) )
        {
            [[ level.leaderboardfunc[ "killstreakKills" ] ]]( self, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
        
        if ( isdefined( self.pers[ "killstreakKills" ] ) )
        {
            self.pers[ "killstreakKills" ] = self.pers[ "killstreakKills" ] + 1;
        }
    }
    
    if ( !isdefined( level.var_eac48db7da1c7505 ) )
    {
        level.var_eac48db7da1c7505 = spawnstruct();
    }
    
    if ( !isdefined( level.var_eac48db7da1c7505.iskillstreakkill ) )
    {
        level.var_eac48db7da1c7505.iskillstreakkill = 1;
    }
    
    function_7fae313f10bc9d47( self, victim, inflictor, objweapon, var_e2e82b6431a6ecd0 );
    
    if ( meansofdeath == "MOD_HEAD_SHOT" )
    {
        if ( inflictor.var_aa3dc1c1665433b7 )
        {
            return;
        }
        
        thread utility::trycall( level.matchdata_logattackerkillevent, killid, "headshot" );
        event = #"killstreak_headshot_kill";
    }
    else
    {
        self.killstreak_kill = 1;
        event = #"killstreak_kill";
    }
    
    cankillchain = 1;
    
    if ( isdefined( var_e2e82b6431a6ecd0.mpstreaksysteminfo ) )
    {
        if ( var_e2e82b6431a6ecd0.mpstreaksysteminfo.streaklifeid != self.lifeid )
        {
            cankillchain = 0;
        }
        
        if ( var_e2e82b6431a6ecd0.mpstreaksysteminfo.ownerxuid != self getxuid() )
        {
            cankillchain = 0;
        }
    }
    
    pointsoverride = undefined;
    
    if ( cankillchain && isdefined( self.perks[ "specialty_chain_killstreaks" ] ) )
    {
        pointsoverride = rank::getscoreinfovalue( event );
    }
    
    thread points::doscoreevent( event, objweapon, pointsoverride, undefined, undefined, 1, undefined, cankillchain, var_e2e82b6431a6ecd0, undefined, level.var_eac48db7da1c7505 );
    level thread battlechatter_mp::saytoself( self, "plr_killfirm_killstreak", undefined, 0.75 );
}

// Namespace events
// Params 1
// Checksum 0x17f054f3, Offset: 0x1de3b
// Size: 0x44e
function function_d980c8bfe541541a( streakname )
{
    if ( !streakname )
    {
        return;
    }
    
    if ( !isdefined( level.event_data ) )
    {
        level.event_data = [];
    }
    
    var_187fb9d2b7753d75 = level.streakglobals.streakbundles[ streakname ];
    
    if ( !isdefined( var_187fb9d2b7753d75 ) )
    {
        return;
    }
    
    if ( !isdefined( level.event_data[ streakname ] ) )
    {
        if ( !isdefined( event_data ) )
        {
            event_data = {};
        }
        
        event_data.isair = var_187fb9d2b7753d75.isaerial ?? 0;
        event_data.isground = var_187fb9d2b7753d75.isground ?? 0;
        event_data.issupport = var_187fb9d2b7753d75.issupport ?? 0;
        event_data.isvehicle = var_187fb9d2b7753d75.isvehicle ?? 0;
        event_data.var_f9c70d92a053199f = var_187fb9d2b7753d75.var_f9c70d92a053199f;
        level.event_data[ streakname ] = event_data;
    }
    
    if ( level.event_data[ streakname ].var_f9c70d92a053199f )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
        {
            if ( isdefined( self.leaderboarddata[ level.event_data[ streakname ].var_f9c70d92a053199f ] ) )
            {
                self.leaderboarddata[ level.event_data[ streakname ].var_f9c70d92a053199f ] += 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ level.event_data[ streakname ].var_f9c70d92a053199f ] ) )
            {
                [[ level.leaderboardfunc[ level.event_data[ streakname ].var_f9c70d92a053199f ] ]]( self, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
            
            if ( isdefined( self.pers[ level.event_data[ streakname ].var_f9c70d92a053199f ] ) )
            {
                self.pers[ level.event_data[ streakname ].var_f9c70d92a053199f ] += 1;
            }
        }
    }
    
    if ( level.event_data[ streakname ].isair )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
        {
            if ( isdefined( self.leaderboarddata[ "killstreakAirKills" ] ) )
            {
                self.leaderboarddata[ "killstreakAirKills" ] = self.leaderboarddata[ "killstreakAirKills" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "killstreakAirKills" ] ) )
            {
                [[ level.leaderboardfunc[ "killstreakAirKills" ] ]]( self, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
            
            if ( isdefined( self.pers[ "killstreakAirKills" ] ) )
            {
                self.pers[ "killstreakAirKills" ] = self.pers[ "killstreakAirKills" ] + 1;
            }
        }
    }
    
    if ( level.event_data[ streakname ].isground )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
        {
            if ( isdefined( self.leaderboarddata[ "killstreakGroundKills" ] ) )
            {
                self.leaderboarddata[ "killstreakGroundKills" ] = self.leaderboarddata[ "killstreakGroundKills" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "killstreakGroundKills" ] ) )
            {
                [[ level.leaderboardfunc[ "killstreakGroundKills" ] ]]( self, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x428>" );
            
            if ( isdefined( self.pers[ "killstreakGroundKills" ] ) )
            {
                self.pers[ "killstreakGroundKills" ] = self.pers[ "killstreakGroundKills" ] + 1;
            }
        }
    }
}

